#!/bin/bash

# 1. 初始化 conda（必须）
# source /home/HDD5/tjut_luocongyuan/_000n_00000000/_003n_backend/_001n_z001/_001n_conda_linux/_001n_install/miniconda3/etc/profile.d/conda.sh
source /root/autodl-tmp/_000n_00000000/_003n_backend/_001n_z001/_001n_miniconda/_001n_install/miniconda3/etc/profile.d/conda.sh

# 2. 激活项目环境
conda deactivate
# conda activate /home/HDD5/tjut_luocongyuan/_000n_00000000/_003n_backend/_001n_z001/_001n_conda_linux/_002n_my_conda_env_list/_020n_My_CIL
# conda activate /root/autodl-tmp/_000n_00000000/_003n_backend/_001n_z001/_001n_miniconda/_002n_conda_list/_001n_My_CIL
conda activate /root/autodl-tmp/_000n_00000000/_003n_backend/_001n_z001/_001n_miniconda/_002n_conda_list/_010n_botcl

# 3. 进入项目目录
# cd /home/HDD5/tjut_luocongyuan/_000n_00000000/_000n_uni/_005n_my_codes/_001n_projects/_006n_My_Framework/_000n_My_CIL/My_CIL/_001n_my_src
# cd /root/autodl-tmp/_000n_00000000/_000n_uni/_001n_my_codes/_001n_projects/_005n_claude_code_projs/_001n_cc_translation/_010n_codes/_001n_My_CIL/My_CIL/_001n_my_src
cd /root/autodl-tmp/_000n_00000000/_000n_uni/_001n_my_codes/_001n_projects/_005n_claude_code_projs/_001n_cc_translation/_010n_codes/_024n_botcl/botcl

# 4. 跑实验

CUDA_VISIBLE_DEVICES=0 \
PYTHONUNBUFFERED=1 \
python -m main_contrast \
--dataset CUB200 \
--dataset_dir /root/autodl-tmp/_000n_00000000/_000n_uni/_001n_my_codes/_001n_projects/_005n_claude_code_projs/_001n_cc_translation/_010n_codes/_024n_botcl/botcl/_002n_datasets/_001n_CUB200 \
--output_dir /root/autodl-tmp/_000n_00000000/_000n_uni/_001n_my_codes/_001n_projects/_005n_claude_code_projs/_001n_cc_translation/_010n_codes/_024n_botcl/botcl/saved_model \
--num_classes 50 \
--num_cpt 20 \
--base_model resnet18 \
--cpt_activation att \
--lr 0.0001 \
--epoch 60 \
--batch_size 256 \
--num_workers 4 \
--device cuda:0 \
--weak_supervision_bias 0.1 \
--att_bias 0.1 \
--quantity_bias 0.1 \
--distinctiveness_bias 0.05 \
--consistence_bias 0.01
