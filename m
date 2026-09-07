Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E944AC79FA0
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 16:33:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBF7A10E14B;
	Mon,  7 Sep 2026 16:33:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VKwAep2y";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cE7FnjKR";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24FB210E14B
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 16:33:29 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687Fkp263890292
 for <dri-devel@lists.freedesktop.org>; Mon, 7 Sep 2026 16:33:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=DRVweJQIoIP40t34svqv3Me3LqPrRQmfXefWUAwDqlM=; b=VK
 wAep2ympu9JT872ZaG9cwfiY7NPDhks1SFhSeoj0aDyOCFORuB7548WWrVoyAoAV
 ZJ/NqYTcEvasN9cA+KUngQeZppvSAgi5WtL+Q5n8wtjOOCW4yoqmjzhYLgdyrYmZ
 9YzAgGFLn/x2zAa6VzQVzu//zvLKPBCWiowuhIPhAiPBn0YOyPA6v+uoBUc7ZUpX
 /SP7fLNdslr7J5Zxkx2Npc598/TxtO4A2GSn74n+iDrF0mY4FyFCqIGIBA1M5Ocm
 n9vmn/0jvT0JmeceqYvRcAH+3muRRFKtpFb/EFUN1qcaOMZYIn4N64RBKJiIC/ws
 9auj7SmN3wwPnVv1WtDA==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gj077g5ag-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 16:33:27 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-46617932071so1745273fac.0
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 09:33:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788798807; cv=none;
 d=google.com; s=arc-20260327;
 b=bdXGaDST5ZpY64RH/odBdiLppGy/tWS4v5bdpN5kAHFlJhcS4om18bfeXU1xfe4Xow
 Np/DJzoxoUUuecd3Tiz4uoj6BjuCgCa/Hg4VznFx/VqTmnyPZNrr+ePEtWIFkqLLQuRj
 AD0PV3/km8jU8j5a/iiOuw7EUHD+6N0NMo4I099NNmIK4hPCj0IcZX3Nw3yhpwB7cr6O
 7DrQFfegCB53iflloAw6gbSoXuiUL3nWqqaxpc/hy1l0taPYWR8x5AYKYG3MSgST2Pof
 2NMvrAR3sKhKUF5GZWHlcPVO7FAtOMd5cz0v+i2GtNr6MEdSQZW2wr7iqqkI2XI3cPQw
 uVMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=DRVweJQIoIP40t34svqv3Me3LqPrRQmfXefWUAwDqlM=;
 fh=wyEahGFEfBYOaW/GDBoqczFwNuDgrYrSR5X0UmLy9hU=;
 b=QkHOGnaTd5BQFYelQiVBYnbqCrkq2xkeHEF0ZmK1a2+5yZcugbCFa52DHkieYL7txA
 B51M6fjEJkh94lnn9sf72qP9yjZz2XF0PdQ1HM6zKJycmQCcTkkYubh3knOSJrix0BwB
 2TYZnZlFelM8dIwSo3dBkhUsprbRzVeM/ukkDw1rmz3hVLeL7B34FsQtzKUAG3J22d1L
 lXM7yYobhoh1+Hc9lu45H0EzBEUkXucRPS8ZDNaCM5sCQ3ZKlwbP2SSGGGlurUY5yDEa
 qU+4jDzhymQ/iGZHykH3qexri7H9wT+sV/qK1VUBrVk8AfSmACPnaP8TaVBGAIfTFviB
 B36w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788798807; x=1789403607;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DRVweJQIoIP40t34svqv3Me3LqPrRQmfXefWUAwDqlM=;
 b=cE7FnjKRHTA0C6djvPfzhA44iN3rGdryEDjgcdX+rUo5CvakvQwiqE0l9EBMvQp9DC
 Sj4Z+TuQJSxyTGjV7iAtvqGLs45wY7xFjkvel99P05/FCByxlMlB2bBCV/GB421Lv+hM
 3aRHXIzRoXnr3ATD7vSiuj02oQ3/zBhYnWqhV7jnXj0RSpeT7zGo0Tm9kHKgyPqwBwff
 KG0+1Y8tGB5DvYNnoMVhDm2XTIh2lT5kgU7rD5F62/AoQ6ArwfpfTu5c7Hly2dipJndH
 Z4CDztEnouA3imWiHRRWoXGFC/xtoXptg+6mYfQhYayjGm9s8ks8gDwXR0HBicCxy57i
 HVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788798807; x=1789403607;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DRVweJQIoIP40t34svqv3Me3LqPrRQmfXefWUAwDqlM=;
 b=O9ZlvnGjb0YjA0owZQ/Lb7J/JQyxtAJCJqEGmR1jxHktzxubBbtCz6H/sRV+r62oB2
 TMhEikh9hz1jQje5SaZx7NQnXtGr/iHRCJN3OmAoY76V70UalMDI2GbO+/tShfzrT63O
 nN7t5xZ7cBH11eqGlxjZ/lyKOKBd5DH0FSPt1/ZZnSCwnWTc5bzfnlnCxD+BoawVtSZq
 k/5dlkjfdwpbOi8FuyNNxFEWnNl9+l3mVWbhGWMZO2SP992sdTNp9ncd2kmN8MHwKYR/
 BTvjWyTaDdcgrOcN9CUTo5uVOksj7DgnW3yOe5S5Eoeb6uZ0ggiSRKHF0Q+TUWQHkFxc
 HW7Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxkVTpWoa9M23gG9JNz0NDcASntcClgdhs4dRL0oTy2HO2ArWVN8xD8xi0m8pRvT4HIBi0SgfpZMGQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lGV1aiYYzjPGR5iMusoYHrQEwUK/3GEo7D+/imnEPv5KRp5lF+
 6JkNcl1ms3i9BcJAT6+D0o+OFyWs8SkK3xifxPnqVEOQy3g8jB+sLJGB6GwwtHm18bC0P8upNEx
 b8UUx6oDHrcZjc+r1pqHzo3J8z/mAhoyx/9l+mlGRWiyM12iIvI4xT50kJwcPgwNeHO+UItTrrP
 BZ5CkIRzuzLfnV9AwCAUlB9Wvj+mayV/uLDYfQycZi1Cowfg==
X-Gm-Gg: AYBFou39t2L+RFtp1jWV9AH5mkl4h74N7BQY7giMSmWKetgVnoLMEB+q7pgbJgpl1by
 XxWYVze1YL1P5H5jUWb0E4uzB9BfvGoM98fG7b1qf8+LPNQgeDZF8sbR4brZ7lO5WxTFNwQSF25
 kkjFnlsVm5KUn/LtA9YT/lBCQydDgKw7Dv25tg08oJpY+fokuk5Xc9IEyp
X-Received: by 2002:a05:6871:553:b0:475:a112:126f with SMTP id
 586e51a60fabf-475a1124d24mr12814786fac.28.1788798806926; 
 Mon, 07 Sep 2026 09:33:26 -0700 (PDT)
X-Received: by 2002:a05:6871:553:b0:475:a112:126f with SMTP id
 586e51a60fabf-475a1124d24mr12814755fac.28.1788798806458; Mon, 07 Sep 2026
 09:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260820154428.1278@ferrisoft.com>
 <30d4a7b4-1f1b-4589-b132-2115cab98b71@oss.qualcomm.com>
 <20260905085428.reply-a8xx-fmax@ferrisoft.com>
In-Reply-To: <20260905085428.reply-a8xx-fmax@ferrisoft.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 09:33:13 -0700
X-Gm-Features: AcwNN1WTSdXxqjPurMcfkkuM_h7J6pO-dYWho9XClOHzE3KKLwTxWGQJ-ha6JbY
Message-ID: <CACSVV02JMXbUWYGtAv8Tiq5EoAi00KYyfdBUfDGzuETu=rS9GA@mail.gmail.com>
Subject: Re: drm/msm: unrecoverable a8xx hang-recovery loop on Glymur ("cx
 gdsc didn't collapse"); killing the offending client does not stop the loop
To: Greg Ociepka <greg@ferrisoft.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE4MyBTYWx0ZWRfX9yDYGvxgLMWY
 sFniYyXWJ861Di/ZF+83zQe/LGWgtZLuVYeYE6lB2bBrObcc16tjnCs3maINi+E10zWeInoV5K5
 L4HdMC5FewicGhwWqQ0rRSMFS6CQbCSusUoeVuBQC0A0uCKQ90rCzK1D21eRX229WUuS9+jqy6w
 7s6Cp1XbU5izlyNDUnNzvB/sU8JGZCD+EVoLLgYNgsUkRgS+rR+ipXTxuPv7gCU46dXRbeh4UxJ
 pSlFkp0DsDikjzSumL188aPD/be+N/f5LDz3R3JZLgT2OGnlldGdoYAT0nu+efgxu4IobRS6Wu2
 BSrYdzPtRm1vogAmg0UenSZhRhhtqFA4Z3TM5GfAmjRhdxuduLsOHbWQquWEatJjdjE419lk3fP
 hkBF70+hDxXh6eEBrgAbusUuY/uTLtzrFcfdy2SEtULOnJx+H82aT2TLVOXheGPFYlEypQZZvvg
 RncrID17VGAyzdnA2Iw==
X-Authority-Analysis: v=2.4 cv=Xbe5Co55 c=1 sm=1 tr=0 ts=6a9ee757 cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=zXLAmZJP3ypUEzgl:21 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=a8UEx8NLAAAA:8 a=FZWR3zCvmohz_MwBo3EA:9 a=QEXdDO2ut3YA:10
 a=vh23qwtRXIYOdz9xvnmn:22 a=cvBusfyB2V15izCimMoJ:22 a=-yeuc7zBjbfZT8aiaP-D:22
 a=-OPlMFtxszdMq-1ZrUoe:22
X-Proofpoint-ORIG-GUID: Bux98Na-vxlHq4vFAYgFwjYaAvAKia3O
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE4MyBTYWx0ZWRfX4MiXNypAViuW
 G0dY8EzfdVCgf90hlE/XE9A1vddupwfLbV7R5o4d43SftLH+rKAqxEltPg8F1Y/YGQSCLjsQvxj
 PdZodAgIvLwUYU75jBQdo766hqRT7KI=
X-Proofpoint-GUID: Bux98Na-vxlHq4vFAYgFwjYaAvAKia3O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_04,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070183
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

Fwiw, I've started to see something similar, which seems to start with:

Sep 07 09:19:07 shady kernel: platform 3d6c000.gmu:
[drm:a6xx_gmu_start [msm]] *ERROR* GMU firmware initialization timed
out
Sep 07 09:19:07 shady kernel: platform 3d6c000.gmu:
[drm:a6xx_gmu_set_oob [msm]] *ERROR* Timeout waiting for GMU OOB set
GPU_SET: 0x8000
Sep 07 09:19:07 shady kernel: platform 3d6c000.gmu:
[drm:a6xx_gmu_set_oob [msm]] *ERROR* Timeout waiting for GMU OOB set
GPU_SET: 0x8000
Sep 07 09:19:07 shady kernel: platform 3d6c000.gmu:
[drm:a6xx_gmu_set_oob [msm]] *ERROR* Timeout waiting for GMU OOB set
GPU_SET: 0x8000
Sep 07 09:19:10 shady audit[236335]: AUDIT1123 pid=3D236335 uid=3D1000
auid=3D1000 ses=3D3
subj=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
msg=3D'cwd=3D"/home/robclark/Downloads/deleteme/darktable-bench"
cmd=3D"true" exe=3D"/usr/bin/sudo" terminal=3Dpts/3 res=3Dfailed'
Sep 07 09:19:10 shady sudo[236335]: robclark : a password is required
; TTY=3Dpts/3 ; PWD=3D/home/robclark/Downloads/deleteme/darktable-bench ;
USER=3Droot ; COMMAND=3D/usr/sbin/true
Sep 07 09:19:12 shady kernel: msm_dpu ae01000.display-controller:
[drm:hangcheck_handler [msm]] *ERROR* 44070041: hangcheck detected gpu
lockup rb 0!
Sep 07 09:19:12 shady kernel: msm_dpu ae01000.display-controller:
[drm:hangcheck_handler [msm]] *ERROR* 44070041:     completed fence:
581164
Sep 07 09:19:12 shady kernel: msm_dpu ae01000.display-controller:
[drm:hangcheck_handler [msm]] *ERROR* 44070041:     submitted fence:
581167
Sep 07 09:19:12 shady kernel: msm_dpu ae01000.display-controller:
[drm:recover_worker [msm]] *ERROR* 44070041: hangcheck recover!
Sep 07 09:19:12 shady kernel: msm_dpu ae01000.display-controller:
[drm:recover_worker [msm]] *ERROR* 44070041: offending task:
gnome-shell (/usr/bin/gnome-shell --mode=3Duser)

In particular, "GMU firmware initialization timed out"

I _think_ the main change on my end is switching to release kernel
config (from one that had lockdep and other debug stuff enabled),
since I was doing some benchmarking.

BR,
-R
