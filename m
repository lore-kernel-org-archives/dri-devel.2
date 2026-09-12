Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9399C88E53
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 15:14:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC88D10E730;
	Sat, 12 Sep 2026 15:14:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mb7hlqui";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="enciM45X";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04DE910E730
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 15:14:23 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68CEdcaH4128352
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 15:14:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=2RE/Ft/l2lAC92ld70vmZ1LagKt55M96AI93rGFYrKo=; b=mb
 7hlqui6mgeogkjoJMJtXHDkMzzXOBazp7dTPY49Ohh63Nx9G7fWJDJeSSGfVhFN+
 /FO/IpAnsqHl9Yw57FNzn4bp8Igs22Fb/ZUDkMHeGPR8QAZ3f/E4Rt9ka1f1XmpB
 +K+BTwVxlAQVdcP+GJl3hRi+e1xxKZVuNXs7QeMnZPX8DMpNSaDSIaOOmTGbtuHm
 qOT61QcarXlhCi/HVRvFB5ZkhG0FAC3UAFd5Xrcp7jXqRMd06/TFFRGWNDoHcT3U
 8XqDoziRO+mCK4Pi3yl2qVL4vJhxWQ30X+DHL9xsZOykZxQrG0ph5RFOqoa7gQjn
 e6xerWR5xjyLvB9xUZag==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9c98h7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 15:14:23 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-4566537e644so2474497fac.0
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 08:14:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789226062; cv=none;
 d=google.com; s=arc-20260327;
 b=BjVmbB5J9bLZye4aHM336tbd4Q+4fM6fk291TK7iejfIMkwPz273C78ErLlwE5UAMW
 34QVBzlOoutfgJnz50S6PZe8A5yiotnklefMzFg5w6V9LxBIitIgoRw+l7bNpouIaJqz
 H94gUEfF5+GBFI26Clcew3RPB5rliDJxclW+Itjbf5D+y6ngYatm/+1voOEJ35BjaMIK
 HBF38GcWtU4BrBm7jNXS7WLg1AwjLu9+3bVya7AernXLwF+fn3813jgpm6213XgAVFhq
 ihFXb95W0aEqa5e/TlFmRMT2OKXe010APGv4U+XJrKg9sFun7IW/2IlNpncjX7wtvlBL
 EaZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=2RE/Ft/l2lAC92ld70vmZ1LagKt55M96AI93rGFYrKo=;
 fh=NMjaC0EyV0Bgp4SESdfDvfz+ODu5b1w3qrVg8TRfn8M=;
 b=YU49Z4Q+0mZebeLTb1/8Mk2xYQ6oo0JTANGVv2wC0wyPWb/x5SQ69lGYbLb6u8vslU
 dOR/4xn5qAwXidhTJMiNR/JR3JNiGdrvHEVidflFZ/tcWIHGh+pWpO44gS2Brz5TQDQ8
 7eoYE8Xj6SEr8ljJYj6AkuxVYkWUNJgH84V5UnJmY4Szy4pNwUYLbpLmQWK7SL0bkXye
 pFgTQ63iE5xMhRYVMz+3/VXdDv6pruH8GYiOVtlnTTkHrMB+6e/vR2XC4fbUdX8P//5D
 9A+gtuEcpxJzldvwzXCDIaN1k4RQDkfD/FJK4H9Vic0dOQ/LSWf0+Q9zWxbpNqQVYTwk
 86Pw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789226062; x=1789830862;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2RE/Ft/l2lAC92ld70vmZ1LagKt55M96AI93rGFYrKo=;
 b=enciM45XATevyrqHk++e1MEQ4KQjRx8eJuRd+EJu6in3Y3A0RZY4DhoqRmZ9J/QBFz
 JFfQ36FcXno5CL0sQ1S4HmBm/g9jRIpSnZj2l23HpJtFcm7TYGT9ugdSP5atf7nR4U1N
 k11A3nZKdlwhGfzQI3x0w5UJnVArxj8Vrr9dZi1AKhjNUsUEoqsuZIWE0dlR7EG8cQxz
 RBFUYAzy5wxZM3t9hgIWgb4h6lWRFpLr5zSoUA7F3O5zMWRgiLvF+3bkgI7ziUNlkzbW
 6xLfxchwfxn52DNuYMfr7P1PrG9LpGPVjKoRBTMHGRkV5Odi4SixaeeQJOsgDXcgcHFU
 x0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789226062; x=1789830862;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2RE/Ft/l2lAC92ld70vmZ1LagKt55M96AI93rGFYrKo=;
 b=Bp25YFSlZbquDqWWzgdo3rVRbBcSg2siSsJiGOT2Zf0sOFfn/I0mdXExcsj/bm2KqS
 DSyRdi1NDwiXQSN/LqH9EoCX624eZaCceqwJk0O0CTdwObw+CmoszdsnJm4ib4FgAJsm
 v7UQkI10XxzWUyIpbvvXExLxhqBTUzvG0zsNnkWAVaO3rqqeuLMgypPoZZYi4LMo43DF
 HqMtN2X/1Od6DTPRLDsBxMczzzGGTffim10FxjwGcR959jfgp89Lst4azbZRzA3wEV+i
 KpBpCm8kEeKfkoTMS2w5LcqFvmXNKcnus4/LUPHZjQgewrjZK1CzcqpSCGqtiumqxyyr
 4Zgw==
X-Forwarded-Encrypted: i=1;
 AKwUvByrksYbM3Nyl7CjAeYb4fDzKRvTDpt1CuXpJOaWJ64HQxZTY5R9NG/DAjMZwPooVPeIaJ//2V/v088=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lfrDzz85+croOz5u161m8X8ThZCPQTIgodo6Pnu5dSdr4yjWGg
 GKEm5K6RXhivAQEKusii57WzXyAiGP24/SiVmPwKrbgISNmSS1v+AAuLsU0/JFINO52MOHqxiU+
 qalHPRZpilcWh9Mpkh0VaPR8jisQbYuOX9hvijra6ys+7UmMo96V4MTB6VwM+pUUalOUkzdISaX
 04r6lfaz3J6lPj6l/M4WL3SamgKp19p5nhlwY9wcumMiqb5g==
X-Gm-Gg: AYBFou1arXcAQ8wKkR8ibLy7v7nSX8UkqYjikn5a3O5rjaNI9j+sTT1oVKJa17o8wlH
 RkzzTERkjQMXbHkSuvlgT6c5EEAANCEolfU+KJTAmcqy7PZTgIxI5/SR9r1FJUlA537ZjmSp0p6
 VmZ48rJv1FA0ceiOMya3BJ18nnpNDRwzGBjLV8aZ6AjGExY2ZTZ+FZQ2C0
X-Received: by 2002:a05:6870:5067:b0:464:ddfb:592 with SMTP id
 586e51a60fabf-47f58061ca2mr1788150fac.6.1789226062416; 
 Sat, 12 Sep 2026 08:14:22 -0700 (PDT)
X-Received: by 2002:a05:6870:5067:b0:464:ddfb:592 with SMTP id
 586e51a60fabf-47f58061ca2mr1788135fac.6.1789226061991; Sat, 12 Sep 2026
 08:14:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260820154428.1278@ferrisoft.com>
 <30d4a7b4-1f1b-4589-b132-2115cab98b71@oss.qualcomm.com>
 <20260905085428.reply-a8xx-fmax@ferrisoft.com>
In-Reply-To: <20260905085428.reply-a8xx-fmax@ferrisoft.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Sat, 12 Sep 2026 08:14:11 -0700
X-Gm-Features: AcwNN1WdubAYmhy0MrZ_kcHNrPuJ-kRycJWGZKZbOcTIFLmj2AiKYhhlnSLmwqM
Message-ID: <CACSVV00FYe+cSgzE3A0G8-6pE9NEuUDOWCs4w=Y93JZqyWPc1w@mail.gmail.com>
Subject: Re: drm/msm: unrecoverable a8xx hang-recovery loop on Glymur ("cx
 gdsc didn't collapse"); killing the offending client does not stop the loop
To: Greg Ociepka <greg@ferrisoft.com>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDIyMCBTYWx0ZWRfX4vv2cdho7FYA
 9oFKkxktjf1db47RLdVaDman1Vj6QC1hObVqDo/bfaHuzN+2gsEDI+fenE/XQgSnT7GROWy7xfj
 xPPK/RNI5En2A4R+WHPRvbK8Yef+5GQ=
X-Proofpoint-GUID: vk7Zwl0ztleiEtqYGyLS60iMAp2Qtitn
X-Authority-Analysis: v=2.4 cv=BdZNQbt2 c=1 sm=1 tr=0 ts=6aa56c4f cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=zXLAmZJP3ypUEzgl:21 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=a8UEx8NLAAAA:8 a=saP2t_mShj24_FTDOHQA:9
 a=QEXdDO2ut3YA:10 a=1zu1i0D7hVQfj8NKfPKu:22 a=cvBusfyB2V15izCimMoJ:22
 a=-yeuc7zBjbfZT8aiaP-D:22 a=-OPlMFtxszdMq-1ZrUoe:22
X-Proofpoint-ORIG-GUID: vk7Zwl0ztleiEtqYGyLS60iMAp2Qtitn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDIyMCBTYWx0ZWRfX/VK78UbWogz2
 10cCUk/AG+xDBcRC0/yFNhEwizIU87rE1b7KrhQw3/qmRhbK8n2WGg/AHisVedKDFX7aHx5alk/
 PZME+GqKXc0uhFmG76FTXibEi4zIaGhqL9aF1HNTLVwE2ThooTg7mJqKAWsLvHT1tpWVlvNX4aV
 CWvz6ORXie2rXSwpFYChInznOg9ZBPyvONDyiUksp8e0YjqyipAxJ1LTfIde0Ol7wSaFYGbFp72
 gTmCBk5n3QuR3yY0KcoPHpmhvzdQItoTixQfvuXjwJjxAiDonJzFgHiH4RmGss+m2BQkslcEIwe
 An2/tTQ1AAw/rhZEyA6lkEDTAN13OOc5ratdAZlRDlRD17/wSFN3VEEJbJekC85T+suOSOI85Kz
 hzhQeRDSBt+T/E1QEXhSceuZF/7puoyXFWZfpuqdK1uY/y6pKZZRMYaxdmgsh/H9OmT94mzeY+N
 p7LXzfu3YI9ckTRqI3w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0 clxscore=1015
 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609120220
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: rob.clark@oss.qualcomm.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Fri, Sep 4, 2026 at 11:54=E2=80=AFPM Greg Ociepka <greg@ferrisoft.com> w=
rote:
>
> On Fri, 4 Sep 2026 04:29:16 +0530, Akhil P Oommen wrote:
> > On 8/20/2026 7:14 PM, Greg Ociepka wrote:
> [...]
> >> We are happy to test patches, run instrumented builds, and provide
> >> full journals or devcoredumps - the machine reproduces this every
> >> couple of days under normal desktop use.
> >
> > Does your tree have these fixes:
> > https://lore.kernel.org/lkml/06489359-1b96-43ad-a065-bfb9bee51a10@linar=
o.org/t/#u
>
> Yes, all six of them. I checked each patch of that series against
> linux-next (cgit):
>
>   d9108bfdb746 drm/msm/a6xx: Fix stale rpmh votes after suspend
>   b303e1d52811 drm/msm: Recover HW before retire hung submit
>   fc7ccbc6174b drm/msm/a6xx: Fix A663 GPUCC register list for state captu=
re
>   d052d0358fb8 drm/msm/a6xx: Fix A621 GPUCC register list for state captu=
re
>   bc024d325e98 drm/msm/a6xx: Fix IRQ storm during msm_recovery test
>   40b793714ad8 drm/msm: Fix task_struct reference leak in recover_worker
>
> All of them are already in next-20260730, which is the tree the report
> (and the four incidents in it) came from, and they are in
> next-20260831 as well, which this machine has been running since the
> evening of Sep 3 (7.3.0-rc1-next-20260831, with the same local
> platform patches as described in the report, still nothing anywhere
> near the GPU, GMU, GDSC or clock paths, plus one unrelated
> fs/buffer.c fix).
>
> So the loop reproduced with these fixes in place.
>
> For completeness, the timeline since the report:
>
> - After the report I started running thunderbird, the most frequent
>   "offending task" of the earlier incidents, with
>   LIBGL_ALWAYS_SOFTWARE=3D1 (llvmpipe) as a user-space mitigation.
> - The last incident on the next-20260730 tree was on Aug 30, 12:10
>   CEST: 689 "hangcheck recover" cycles in one boot, with a different
>   client as the trigger, so the mitigation did not prevent it.
> - Since the switch to next-20260831 on the evening of Sep 3 there has
>   been no incident, but against a historical rate of one every few
>   days that short a window does not mean anything yet.
>
> > Also, could you try limiting the Fmax to < 1Ghz?
>
> Yes. The OPP table as the kernel sees it here (available_frequencies)
> is 310, 410, 572, 760, 820, 915, 1070, 1185, 1350, 1550, 1700 and
> 1850 MHz, and max_freq is at 1850000000 as I write this, i.e. the
> full range. I will cap it at 915 MHz, the highest step below 1 GHz,
> through devfreq at runtime:
>
>   echo 915000000 > /sys/class/devfreq/3d00000.gpu/max_freq
>
> and keep the machine at that setting under normal use. It is a sysfs
> setting, so there is an uncapped window after every boot until it is
> re-applied; I will log that window per boot and check any incident
> against it, since onset correlated with session restores in the
> earlier incidents. Given the historical rate I would like to give it
> at least two weeks before concluding anything, and I will report
> either way: at the first incident under the cap (with the journal and
> trans_stat, reset when the cap went on, so you can see devfreq never
> asked for anything above it), or after the observation window if it
> stays clean. One caveat: this stacks on top of the kernel bump, so a
> clean run would not tell the two apart on its own; if it stays clean
> I can go back to the full range on next-20260831 to separate them.
>
> On Thu, 3 Sep 2026 13:16:47 +0200, Konrad Dybcio wrote:
> > On 8/21/26 3:35 PM, Rob Clark wrote:
> [...]
> >> Fwiw, the kernel I've been using: [1]..  but that doesn't have the a16
> >> dts. I need to move forward to something newer, hopefully I'll get to
> >> that today.  We'll see if I start seeing this issue.  Or maybe
> >> something x2e vs x2ee is different regarding pmic/supplies?
> >>
> >> My device doesn't have the highest OPP (1.85ghz), which I think your
> >> device does.  We might be still missing some power related features
> >> that are (more?) needed at higher freq's, or maybe I have a more lucky
> >> piece of silicon?  Akhil would know more about this.  You might try
> >> removing the highest OPP in gpu_opp_table (in glymur.dtsi) to see if
> >> that improves stability?  (Repeat until it is stable if you have the
> >> same issues w/ 1.7ghz.)
> >
> > Greg, have you tried this?
>
> Not yet, and sorry for the late answer on this. We have not run the
> machine with the top OPP(s) removed from the DT for any meaningful
> period, so there is no data point from that side; what we did instead
> is the mitigation and the kernel bump described above. Rob's guess is
> right: this is the X2 Elite Extreme part (UX3607OA), it does have the
> 1.85 GHz OPP, and it is currently running with the full range
> (max_freq 1850000000, see above). Mesa here is still 26.1.5, the same
> as in the report, so it has not been a variable in any of this.
>
> Rather than removing OPPs from the DT one at a time, I will start with
> Akhil's Fmax < 1 GHz test via the runtime cap above, which is
> reversible without a rebuild and is also the most direct test of Rob's
> "power related features that are (more?) needed at higher freq's"
> theory. It is not quite the same thing as dropping the OPP (the GMU
> still gets the full table, the GPU just never gets asked for the top
> levels), so if the capped run stays clean, walking the cap back up, or
> dropping just the top OPP from the DT as Rob suggested, is the natural
> next step to find where it starts failing.
>
> On the x2e vs x2ee question: I have no insight into PMIC or supply
> differences between the two parts. If there is anything worth dumping
> from this machine on that front (regulator state, the level table the
> GMU is given, ...), tell me what and I will collect it.
>
> The offer stands: at the next incident I will grab the devcoredump of
> the first crash state in the loop, before it expires, together with
> the full journal of that boot, and I can run instrumented builds or
> debug patches on top of next-20260831.

If the issue you hit starts w/ "GMU firmware initialization timed
out", like the issue I was hitting, the patch I just sent[1] (and CC'd
you on) increases the timeout to a safe value.  Could you please try
this patch?

BR,
-R

[1] https://lore.kernel.org/all/20260912150915.28700-1-robin.clark@oss.qual=
comm.com/
