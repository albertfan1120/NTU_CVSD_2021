import re

#========== parameter ==========
FA = open("try_idle.power", "r")
FB = open("try_idle_after_active.power", "r")
FC = open("try_active.power", "r")
pwr_diff_th = 5 # TA modify

#========== parsing ==========
for line in FA:
  rslt = re.findall(r'Total Power.*', line)
  if rslt:
    pwr_a = float(line.split()[3])

for line in FB:
  rslt = re.findall(r'Total Power.*', line)
  if rslt:
    pwr_b = float(line.split()[3])

for line in FC:
  rslt = re.findall(r'Total Power.*', line)
  if rslt:
    pwr_c = float(line.split()[3])

pwr_diff      = round(abs(pwr_a - pwr_b)/pwr_a*100, 2)
pwr_diff_rslt = pwr_diff < pwr_diff_th;


#========== display ==========
print("(A) Idle power:              " + str(pwr_a))
print("(B) Idle_after_active power: " + str(pwr_b))
print("(C) Active power:            " + str(pwr_c))
print("***** Assume (A) & (B) time window are the same *****")
print("(A) & (B) diff ratio:        " + str(pwr_diff) + "%")
if pwr_diff_rslt:
  print("=====================================================")
  print("========== Power diff ratio result PASS!!! ==========")
  print("=====================================================")
else:
  print("=====================================================")
  print("========== Power diff ratio result FAIL!!! ==========")
  print("=====================================================")
  #print("Check if all CG are well designed; otherwise, explain in the report.")

FA.close()
FB.close()
FC.close()


