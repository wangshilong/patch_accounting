#!/bin/sh

Josef_branch="git://git.kernel.org/pub/scm/linux/kernel/git/josef/btrfs-next.git"
Linus_branch="git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git"
Kernel_repo="/root/kernel/linux"

go_work()
{
	cnt=`git log --author="$1" --since="$2" --until="$3" --pretty=oneline | wc -l`
	echo "Author: $cnt"
	git log --author="$1" --since="$2" --until="$3" --pretty=oneline
	echo ""

	cnt=`git log --grep="Reviewed-by: $1" --since="$2" --until="$3" --pretty=oneline | wc -l`
	echo "Reviewed-by: $cnt"
	git log --grep="Reviewed-by: $1" --since="$2" --until="$3" --pretty=oneline
	echo ""

	git log --grep="Signed-off-by: $1" --since="$2" --until="$3" --pretty=oneline >1.txt
	git log --author="$1" --since="$2" --until="$3" --pretty=oneline > 2.txt

	cnt=`sort 1.txt 2.txt | uniq -u | wc -l`
	echo "Signed-off-by: $cnt"
	sort 1.txt 2.txt | uniq -u
	rm -rf 1.txt 2.txt
	echo ""

	cnt=`git log --grep="Ackedy-by: $1" --since="$2" --until="$3" --pretty=oneline | wc -l`
	echo "Acked-by: $cnt"
	git log --grep="Acked-by: $1" --since="$2" --until="$3" --pretty=oneline
	echo ""

	cnt=`git log --grep="Reported-by: $1" --since="$2" --until="$3" --pretty=oneline | wc -l`
	echo "Reported-by: $cnt"
	git log --grep="Reported-by: $1" --since="$2" --until="$3" --pretty=oneline
	echo ""

	cnt=`git log --grep="Tested-by: $1" --since="$2" --until="$3" --pretty=oneline | wc -l`
	echo "Tested-by: $cnt"
	git log --grep="Tested-by: $1" --since="$2" --until="$3" --pretty=oneline
	echo ""
}

go_work "$1" "$2" "$3"

