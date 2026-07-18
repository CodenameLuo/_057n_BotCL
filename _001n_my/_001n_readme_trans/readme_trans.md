# 在图像分类中学习瓶颈概念

[PDF](https://arxiv.org/abs/2304.10131)

## 模型结构

![结构图](../../figs/overview.png)

## 摘要

解释和说明神经网络的行为对许多任务都至关重要。可解释人工智能为应对这一挑战提供了一种方式，主要是在事后解释范式下给出决策中每个像素的重要性。然而，理解这类解释仍然可能需要专家知识。近期一些面向可解释性的尝试采用了基于概念的框架，在若干概念与模型决策之间建立更高层次的关系。本文提出了瓶颈概念学习器（Bottleneck Concept Learner, BotCL）。BotCL 仅通过训练过程中为目标任务学习到的概念是否存在来表示一张图像，而不需要对概念进行显式监督。BotCL 使用专门设计的正则项，使学习到的概念能够被人类理解。我们以若干图像分类任务作为测试平台，展示了 BotCL 将神经网络重塑为更具可解释性的模型的潜力。

## 使用方法

#### 数据集

下载 CUB 或 ImageNet，并将它们放到你的 `dataset_dir` 指向的目录中。你也可以制作自己的数据集，其结构类似于 ImageNet，并将其命名为 Custom。

#### MNIST 使用方法

使用以下命令进行训练：

```bash
python main_recon.py --num_classes 10 --num_cpt 20 --lr 0.001 --epoch 50 --lr_drop 30
```

使用以下命令对一个样本进行推理。你可以修改索引来选择不同的输入样本。修改 `top_sample`（论文中为 top-10）可以展示某个概念的更多细节。修改 `deactivate` 可以移除某个概念。输入样本和所有概念的可视化结果分别显示在 `vis` 和 `vis_pp` 文件夹中。

```bash
python vis_recon.py --num_classes 10 --num_cpt 20 --index 0 --top_sample 20 ---deactivate -1
```

#### CUB200、ImageNet 和 Custom 使用方法

我们首先预训练 backbone，然后训练整个模型。对于 ImageNet 和 Custom，只需修改数据集名称。

```text
Backbone 预训练：
python main_contrast.py --num_classes 50 --num_cpt 20 --base_model resnet18 --lr 0.0001 --epoch 60 --lr_drop 40 --pre_train True --dataset CUB200 --dataset_dir "your dir"

BotCL 训练：
python main_contrast.py --num_classes 50 --num_cpt 20 --base_model resnet18 --lr 0.0001 --epoch 60 --lr_drop 40 --dataset CUB200 --dataset_dir "your dir" --weak_supervision_bias 0.1 --quantity_bias 0.1 --distinctiveness_bias 0.05 --consistence_bias 0.01
```

使用以下命令可视化学习到的概念。

```text
首先运行 process.py 提取所有数据集样本的激活：
python process.py

然后通过以下命令查看生成的概念：
python vis_contrast.py --num_classes 50 --num_cpt 20 --base_model resnet18 --index 100 --top_sample 20 --dataset CUB200
```

## 发表信息

如果你想使用这项工作，请考虑引用以下论文。

```bibtex
@inproceedings{wang2023botcl,
 author = {Bowen Wang and Liangzhi Li and Yuta Nakashima and Hajime Nagahara},
 booktitle = {IEEE Conference on Computer Vision and Pattern Recognition (CVPR)},
 pages = {},
 title = {Learning Bottleneck Concepts in Image Classification},
 year = {2023}
}
```
