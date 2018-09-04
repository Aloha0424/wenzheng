dir=./mount/temp/toxic/v10/tfrecords/fttalk/
vocab_dir=./mount/data/kaggle/toxic/talk_corpus/fastText/result/
vocab=$vocab_dir/vocab.txt
python3 ./gen-vocab-parse.py --out_dir $dir --vocab_name vocab.full --min_count -1 --full_tokenizer=0 --tokenizer_vocab $vocab
python3 ./merge-emb.py --dir $dir --out_name glove.npy --min_count 10 --emb $vocab_dir/toxic.vec
python3 ./merge-charemb.py --dir $dir
cat $dir/vocab.txt | vocab2project.py > $dir/vocab.project 
python3 ./gen-records-parse.py --vocab $dir/vocab.txt  --input $dir/train.csv --tokenizer_vocab $vocab
python3 ./gen-records-parse.py --vocab $dir/vocab.txt --input $dir/test.csv  --tokenizer_vocab $vocab

