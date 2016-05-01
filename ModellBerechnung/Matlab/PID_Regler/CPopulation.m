classdef CPopulation < handle
    properties
        mPopulationSize
        mCrossoverRate
        mMutationRate
        mPopulation
    end
    
    methods
        function p = CPopulation(size, crossRate, mutationRate,...
                                 mutationMax, mutationMin,...
                                 paramMax, paramMin)
                p.mPopulationSize = size;
                p.mCrossoverRate  = crossRate;
                p.mMutationRate   = mutationRate;
                p.mPopulation     = cell(size, 1);
                for index = 1:size
                   p.mPopulation{index} = CChromosom(paramMax, paramMin,...
                                                mutationMax, mutationMin,...
                                                mutationRate);
                end
        end
        function run(this, numberOfRuns)
           for runNr = 1:numberOfRuns
              this.evaluateFitness();
              this.select();
              this.mutate();
           end
        end
        function evaluateFitness(this)
            for index = 1:this.mPopulationSize
               currentChromosom = this.mPopulation{index};
               K_D = currentChromosom.mKD;
               K_I = currentChromosom.mKI;
               K_P = currentChromosom.mKP;
               
               sim('CubaModelPID');
               currentChromosom.setFitness(-1/fitness);
            end
        end
        function select(this)
            summedFitness = 0;
            for index = 1:this.mPopulationSize
               summedFitness = summedFitness + this.mPopulation{index}.mFitness;
            end
            for index = 1:this.mPopulationSize
                this.mPopulation{index}.setRelativeFitness(summedFitness);
            end
            newPopulation = cell(this.mPopulationSize, 1);
            remainingSize = this.mCrossoverRate * this.mPopulationSize;
            for index = 1:remainingSize
                randomNr = rand();
                stop = 0;
                oldIndex = 0;
                while(stop == 0)
                    oldIndex = oldIndex + 1;
                    if(this.mPopulation{oldIndex}.mRelativeFitness > randomNr)
                        newPopulation{index} = this.mPopulation{oldIndex};
                        stop = 1;
                    else
                        randomNr = randomNr - this.mPopulation{oldIndex}.mRelativeFitness;
                    end
                end
            end
            
            for index = remainingSize:this.mPopulationSize
                firstChrom = newPopulation{randi(remainingSize)};
                secondChrom = newPopulation{randi(remainingSize)};
                newPopulation{index} = this.crossover(firstChrom, secondChrom);
            end
            this.mPopulation = newPopulation;
        end
        function newChromosom = crossover(this, chrom1, chrom2)
            newChromosom = CChromosom(chrom1.mMaxParameterValue, chrom1.mMinParameterValue,...
                                      chrom1.mMutationMaximum, chrom1.mMutationMinimum,...
                                      chrom1.mMutationRate);
            if(rand() >= 0.5)
                newChromosom.mKD = chrom2.mKD;
            else
                newChromosom.mKD = chrom1.mKD;
            end
            
            if(rand() >= 0.5)
                newChromosom.mKI = chrom2.mKI;
            else
                newChromosom.mKI = chrom1.mKI;
            end
            
            if(rand() >= 0.5)
                newChromosom.mKP = chrom2.mKP;
            else
                newChromosom.mKP = chrom1.mKP;
            end
        end
        function mutate(this)
           for index = 1:this.mPopulationSize
               this.mPopulation{index}.mutate();
           end
        end
    end
    
end

