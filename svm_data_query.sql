select sir.num_aligns, sir.length, sir.model1, sir.prob1, sir.model2, sir.prob2,

case 
when pea_sids.failure_tries <> 0 or pea_sids.exitstatus <> 0 then true
when pea_sim.failure_tries <> 0 or pea_sim.exitstatus <> 0 then true
when pea_sirs.failure_tries <> 0 or pea_sirs.exitstatus <> 0 then true
when pea_simg.failure_tries <> 0 or pea_simg.exitstatus <> 0 then true
when pea_sir.failure_tries <> 0 or pea_sir.exitstatus <> 0 then true
when ((sir.model1 = 'WAG+G' AND sir.length > 250) OR (sir.model2 = 'JTT+G' and sir.prob2 > 1000)) then true
else false
end as erro

from sciphy.idataselection sids, sciphy.imafft sim, sciphy.ireadseq sirs, sciphy.imodelgenerator simg, sciphy.iraxml sir,

public.eactivation pea_sids, public.eactivation pea_sim, public.eactivation pea_sirs, public.eactivation pea_simg, public.eactivation pea_sir

where sids.name = sim.name and

sids.name = sirs.name and

sids.name = simg.name and

sids.name = sir.name and

sids.taskid = pea_sids.taskid and

sim.taskid = pea_sim.taskid and

sirs.taskid = pea_sirs.taskid and

simg.taskid = pea_simg.taskid and

sir.taskid = pea_sir.taskid;
