#!/bin/sh

set -e

linus0="I don't care about you."
linus1="Quite frankly, that sucks. It's not acceptable."
linus2="You dun goofed."
linus3="Guys, this is not a dick-sucking contest."
linus4="Why should *I* care?"
linus5="Who the f*ck does idiotic things like that? How did they \
not die as babies, considering that they were likely too stupid \
to find a tit to suck on?"
linus6="Please add a healthy dose of critical thinking."
linus7="BULLSHIT."
linus8="Somebody is pushing complete garbage for unclear reasons."
linus9="WHAT THE F*CK IS GOING ON?"
linus10="I think we need something better than this garbage."
linus11="That is either genius, or a seriously diseased mind."
linus12="I'm in awe of your truly marvelously disgusting hack. \
That is truly a work of art."
linus13="I'm sure it doesn't work or causes warnings for various \
reasons, but it's still a thing of beaty."
linus14="Is \"I hope you all die a painful death\" too strong?"
linus15="It's what I call \"mental masturbation\", when you \
engage in some pointless intellectual exercise that has no \
possible meaning. "
linus16="Your code is shit.. your argument is shit."
linus17="Why don't we write code that just works?"
linus18="I hope I won't end up having to hunt you all down and \
kill you in your sleep."
linus19="There aren't enough swear-words in the English language,\
 so now I'll have to call you perkeleen vittupää just to express \
my disgust and frustration with this crap."
linus20="Get rid of it. And I don't *ever* want to see that shit again."
linus21="...it is pure and utter SHIT."

linus_c="Christ, people. Learn C, instead of just stringing \
random characters together until it compiles (with warnings)."
linus_xml="XML is crap. Really. There are no excuses."

usage="Usage: $0 [ -i <git_dir> -h ]"

while getopts i:h opt; do
    case $opt in
        i) if [ ! -d "$OPTARG/.git" ]; then
               echo "Not a Git directory: $OPTARG"
               exit 1
           fi
           cp "$0" "$OPTARG/.git/hooks/pre-commit"
           echo "pre-commit hook has been installed"
           exit 0;;
        ?) echo "$usage"
        exit 1;;
    esac
done

if [ ! -d .git ]; then
    echo "$linus0"
    exit 1
fi

if git rev-parse --verify HEAD >/dev/null 2>&1; then
    against=HEAD
else
    against=$(git hash-object -t tree /dev/null)
fi

eval "$(awk '
        BEGIN {
            srand()
            print "rand1=" int(rand() * 22) "; rand2=" int(rand() * 22)
        }')"

files=$(git diff --name-status "$against" | awk '$1 != "D" { print $2 }')
random_file=$(for f in $files; do echo "$f"; done | shuf -n 1)
if [ "$random_file" = "" ]; then echo "$linus0"; exit 1; fi
random_line=$(random_line=$(shuf -n 1 "$random_file")
              if [ -z "$random_line" ]; then
                  grep -m 1 '[a-zA-Z]' "$random_file"
              else
                  echo "$random_line";
              fi)
random_observation=$(if [ "${random_file##*.}" = "c" ]; then
                         if [ $(($rand1 % 2)) -eq 0 ]; then echo "_c";
                         else echo "$rand2"; fi
                     elif [ "${random_file##*.}" = "xml" ]; then
                         if [ $(($rand1 % 2)) -eq 0 ]; then echo "_xml";
                         else echo "$rand2"; fi
                     else echo "$rand1"; fi)

echo "From the file '$random_file':"
echo "> $random_line"
eval "echo \"\$linus$random_observation\""

exit 1
