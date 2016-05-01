classdef CChromosom < handle
    properties
        mMaxParameterValue
        mMinParameterValue
        mMutationMaximum
        mMutationMinimum
        mMutationRate   %Mutation rate in %
        mKD
        mKI
        mKP
        mFitness
        mRelativeFitness
    end
    
    methods
        function newChromosom = CChromosom(maxParam, minParam,...
                                           mutationMax, mutationMin,...
                                           mutationRate)
           newChromosom.mMaxParameterValue = maxParam;
           newChromosom.mMinParameterValue = minParam;
           newChromosom.mMutationMaximum   = mutationMax;
           newChromosom.mMutationMinimum   = mutationMin;
           newChromosom.mMutationRate      = mutationRate;
           parameterSpan = abs(maxParam - minParam);
           newChromosom.mKD = rand() * parameterSpan + minParam;
           newChromosom.mKI = rand() * parameterSpan + minParam;
           newChromosom.mKP = rand() * parameterSpan + minParam;
           newChromosom.mFitness = -inf;
           newChromosom.mRelativeFitness = -inf;
        end
        function mutate(this)
            %Evaluate Random number to determine whether mutation takes
            %place
            if(randi(100) <= this.mMutationRate)
                valueSpan = abs(this.mMutationMaximum - this.mMutationMinimum);
                mutationValue = rand() * valueSpan + this.mMinParameterValue;
                this.mKI = this.mKI + mutationValue;
                mutationValue = rand() * valueSpan + this.mMinParameterValue;
                this.mKP = this.mKP + mutationValue;
                mutationValue = rand() * valueSpan + this.mMinParameterValue;
                this.mKD = this.mKD + mutationValue;
                
                if(this.mKP <= this.mMinParameterValue)
                    this.mKP = this.mMinParameterValue;
                end
                if(this.mKD <= this.mMinParameterValue)
                    this.mKD = this.mMinParameterValue;
                end
                if(this.mKI <= this.mMinParameterValue)
                    this.mKI = this.mMinParameterValue;
                end
                if(this.mKP >= this.mMaxParameterValue)
                    this.mKP = this.mMaxParameterValue;
                end
                if(this.mKD >= this.mMaxParameterValue)
                    this.mKD = this.mMaxParameterValue;
                end
                if(this.mKI >= this.mMaxParameterValue)
                    this.mKI = this.mMaxParameterValue;
                end   
            end
        end
        function setFitness(this, fitness)
                this.mFitness = fitness;
        end
        function setRelativeFitness(this, summedFitness)
            this.mRelativeFitness = this.mFitness / summedFitness;
        end
    end
    
end

