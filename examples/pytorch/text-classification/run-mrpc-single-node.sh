
time(python run_glue.py --model_name_or_path bert-base-cased --task_name mrpc --do_train --do_eval --max_seq_length 128 --per_device_train_batch_size 32 --learning_rate 2e-5 --num_train_epochs 3 --output_dir /tmp/mrpc/ --overwrite_output_dir True)

