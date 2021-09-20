#!/bin/sh

# --type: int, type of problem, 0 means classification and 1 means regression
# --dataset: str, name of dataset. hint: can be set "artificial"
# --data_path: str, path to load dataset
# --result_folder: str, name of folder to store the results
# -- epochs: int, epochs to run for one algorithm
# --n_repetitions: int, number of times to repeat for one algorithm
# --ill_conditional: int, 1 means reg=1/sqrt{n}; 2 means 1/n; 3 means 1/n^2.
# --loss: str, support "Logistic" for classification; "L2" or "PseudoHuber" for regression. default: "L2"
# --regularizer: str, support "L2" or "PseudoHuber". default: "L2"
# --reg: float, regularization parameter, default-None
# --lr: float, learning rate for Stochastic Averaging Newton, default: 1.0
# --run_xx: do we run xx algorithm
# --run_newton False --run_gd False

# python main.py --type 1 --dataset 'colon-cancer' --data_path './datasets/colon-cancer' \
#                --name 'colon' --result_folder 'sps2' --log_file 'log1.txt' \
#                --epochs 75 --n_repetition 10 --reg 0.0 --tol 1e-8  \
#                --loss "Logistic" --regularizer 'L2'  \
#                --run_sps True --run_sgd True --run_adam True --run_sps2 True 

# python main.py --type 1 --dataset 'duke' --data_path './datasets/duke' \
#                --name 'duke' --result_folder 'sps2' --log_file 'log1.txt' \
#                --epochs 75 --n_repetition 10 --reg 0.0 --tol 1e-8  \
#                --loss "Logistic" --regularizer 'L2'  \
#                --run_sps True --run_sgd True --run_adam True --run_sps2 True 

betas=(0.1)
DATASET="colon-cancer" #mushrooms duke colon-cancer
NUM_betas=${#betas[@]}
for (( r=0; r<$NUM_betas; r++ ))
do
    NAME="$DATASET-${betas[r]}"
    python main.py --type 1 --dataset $DATASET --data_path "./datasets/$DATASET" \
                --name "$DATASET-${betas[r]}" --result_folder 'sps2' --log_file "log-${NAME}.txt" \
                --epochs 50 --n_repetition 1 --reg 0.0 --tol 1e-8  \
                --loss "Logistic" --regularizer 'L2'  \
                --run_sps True --run_sgd True --run_adam True --run_sps2 True  --beta ${betas[r]}
done

