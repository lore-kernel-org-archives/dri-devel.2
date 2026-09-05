Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D35AC624D3
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 14:25:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62AEE10E284;
	Sat,  5 Sep 2026 14:25:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WxCpvAc1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L88KF/W+";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C420310E0CD
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 14:25:16 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 685BVQYD1559548
 for <dri-devel@lists.freedesktop.org>; Sat, 5 Sep 2026 14:25:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=TEJoaOLREJ7ky89PpMOiUDudDFY0hbDCRGifOtYnzEo=; b=Wx
 CpvAc1/EgcHJE0//gj/tTwWEghDKBXot8xBahwwzjfqbFVE2DJOtbNuu4hym5oxl
 uErb9o9/OdRG5pN7ql1seLquCPNAvzIskRLXQ7D249BiUiy9a23FiO2vFDTzERr/
 M2YiULV182qVKbJMgTNpiYnQ0zxBRD9HTvDp9lzK0z4GzVV3dbHQwvvb7jB9e/M5
 Lp1E19Hv8x8bnTcRvyJ440FvqQhQS4nw24qKtD49kHc/OKq1R519hbv3ZwgCQNmy
 R6o77YqOI8NHx5q4fdWgO6CyBLsHZaG4TJQqurWvlRH9pJ5Q6Zb8wJAYXJgSJWj2
 BvQWdV4tA2sSko/6RoWw==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggcca10pm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 05 Sep 2026 14:25:15 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-4b597558c4cso2299482b6e.1
 for <dri-devel@lists.freedesktop.org>; Sat, 05 Sep 2026 07:25:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788618315; cv=none;
 d=google.com; s=arc-20260327;
 b=f7EjX5el+F9qXhCD3ScyxqTpb1j7iKoxTTYoLCaqGgFhNxxtly/Bwq3y1fM034yJXN
 qDPznaYaiaPvTT2A7lBEzfxoIvaYVlwpD3s5mNb8zl/iSR23rBh4Lg6eaVJLD5RyJ0g4
 OmpuEh1782DGu9pQonh76U96pGaSbbYFNyEnPwmv/f14nDm5robPbC9g/sNEI6vtBJXx
 mdNeXsigBPR+pegIe7KFQi2QygeE8kyMeZ/KRCwdcj/o1xt7OPPlk4VGbUpO/+0QjOUS
 WwLOggoGTFA8WaoMZQtGaOAfiLzekmYp/631mUXaSwmvDl5OqtOR7Pgz3+qwmxT041wr
 ggqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=TEJoaOLREJ7ky89PpMOiUDudDFY0hbDCRGifOtYnzEo=;
 fh=AZnPORNZ37kVMgBJBkhlc6LxxTOmBPekhX/Kqx2Mqbc=;
 b=koXcbfcfni98qRaGi2PbZirzIznokL3PZiRaSaS+9z0Wv9lmNuwnbdfoGYb3mCA+x4
 P8Tg3jVS+pihsnCqK69r+dbNiOGUtZE5dK0PtEiMy/Azqb3WpMGq2rrZaedC94gemrBK
 M8F1ns/4uUnTr5eT5MTUcjtMP/G474i+kvkDZdPCXaM2JJ8M1Ioxy+5ymNEOxCLoRHgC
 xVinq+oJzwQ4fBcJkUwhT0AVnpXQbcoXdz52fdpbZVl8jOVqhIIDU6ixx8Vy4goX68DH
 4WQqnCAMFy55S8Ib4q8MMa6g8Gm+U5vDsBD0629pChSO2gYBUAeszCNSPiMvxW+sdWMU
 cZyQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788618315; x=1789223115;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TEJoaOLREJ7ky89PpMOiUDudDFY0hbDCRGifOtYnzEo=;
 b=L88KF/W+iqKySJYF2lybSa0EYEo5Atm5esaQoO2HL6fnYSJb8miJwxkqDxfnanORN0
 RNuHEAgFOAoqF/pfvVdPSLc+WotHZgGELEOrZlPfQbE6o5AoYGj+cE43zQAQGf30RQWF
 BOEY06DlXJPSZUHFEk3NBHBVaq99TBVtl6yAjbsfiUGFs1iuHV5pxyV1uUQOiJfc03PO
 mp6K+IdLNK6hNdz3z7/nbxOV1tg978hgSSHAGyXFUeGHrtDB9jVSqN58WdGtYmaE4kJu
 JHRm/UBVqPMZFYHxgh1GQd8ir/sBEwy1buz0QVJXfvY26iHS5iXZwNhNRXSY5m3I14Y9
 z4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788618315; x=1789223115;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TEJoaOLREJ7ky89PpMOiUDudDFY0hbDCRGifOtYnzEo=;
 b=M8d1Wl02fdfcVyLjNWQWMFYVXoAHqTIGMcFfYgtz049ko7WMucIDd3eBekBiA5IJM4
 ENjoel+VVvm79dUanosCn12q6PqEjeDcPleVa/5Vf8rCwaQr08fZ0Eb82vXMvD89e2OD
 rubnK/+iYeO5l2w89eMZ0kYYt/nD6wW1QQ+gtyQ24HzEvXEyBwbWm6SA1viFnLEn/+Fl
 Wb+ckb04vcQmh3zjXJRLw0fhRirA9pmP8lVxmSB1CKF9lD8pDXJhxKWRk9JirF6kjYiq
 syeeYCLaJKo2B/efV1fYmhjqAJKkXU/JkDJm80MPEL4P8+n0OYmM4z5czycl09byR1k3
 hlhQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzCr+NFWjZO7nVlnUqdqBlgqjTCGDPuXlV34KylARCnj8qbbZv+kyFqo1T7lwQmol52o+n7/zxSVNs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ntwA8+6N31k98o3iyX7aCk+tcVwGZq32o1aOKXXpOFTaCil5AV
 uYIDOmzyW1R8z1Fgjoz88yB6S2ieu3iDtiyizoYTZ5SNMtDKJm3NCnKXTb8RnvwSEj4JcfLVlas
 S25LethQsQ3iAHosP1v2B29N/XDPASSakGf0ggraVnZIMp44iSg38xWvsWj8cGVmWdS0rswHT57
 HoRPi6r+3APXxodanVaO+2PMpkjBQd2dnQQY+N5HIpSxqdEA==
X-Gm-Gg: AYBFou01tX3Pf99T/1pJJ8RkSfP5O/31HqDRuqOJHubGca25Q+Bs8YNU7wVbIYL+lWH
 K7Sp/D31m7i/9POYRUxeWwprLZQQftmKdet3pOSTRWie6lSZ0xhuS/asZpA0Nb5Ty4fvPcEkDpL
 fen6lr7VF0t5JgLoPN77aYYF16zIsV3L6xfXvE1Hh6waXiqh/5winJ7hwk
X-Received: by 2002:a05:6808:1395:b0:4b2:67f1:11d7 with SMTP id
 5614622812f47-4b9636b626fmr12210909b6e.17.1788618314882; 
 Sat, 05 Sep 2026 07:25:14 -0700 (PDT)
X-Received: by 2002:a05:6808:1395:b0:4b2:67f1:11d7 with SMTP id
 5614622812f47-4b9636b626fmr12210863b6e.17.1788618314341; Sat, 05 Sep 2026
 07:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260820154428.1278@ferrisoft.com>
 <30d4a7b4-1f1b-4589-b132-2115cab98b71@oss.qualcomm.com>
 <20260905085428.reply-a8xx-fmax@ferrisoft.com>
In-Reply-To: <20260905085428.reply-a8xx-fmax@ferrisoft.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Sat, 5 Sep 2026 07:25:03 -0700
X-Gm-Features: AcwNN1VGjYKCaVAdjVj_CV9ZUwDN_wxCLN7sg_J_x04ObDxcG-lql5Xlet69y0g
Message-ID: <CACSVV00EV+QoaCiQVBRm8E6ScBA_orQrhHPFBCTTQ9A89SS8EQ@mail.gmail.com>
Subject: Re: drm/msm: unrecoverable a8xx hang-recovery loop on Glymur ("cx
 gdsc didn't collapse"); killing the offending client does not stop the loop
To: Greg Ociepka <greg@ferrisoft.com>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: aR2zpF8xAfZWImcMK7Q0zXCJxf7AgGAI
X-Authority-Analysis: v=2.4 cv=EJo2FVZC c=1 sm=1 tr=0 ts=6a9c264b cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=zXLAmZJP3ypUEzgl:21 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=a8UEx8NLAAAA:8 a=saP2t_mShj24_FTDOHQA:9 a=QEXdDO2ut3YA:10
 a=TPnrazJqx2CeVZ-ItzZ-:22 a=cvBusfyB2V15izCimMoJ:22 a=-yeuc7zBjbfZT8aiaP-D:22
 a=-OPlMFtxszdMq-1ZrUoe:22
X-Proofpoint-ORIG-GUID: aR2zpF8xAfZWImcMK7Q0zXCJxf7AgGAI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA1MDE1OCBTYWx0ZWRfX6S/feemxLpfo
 0HHXdkclDRoQ29/c3hd6TQUJD6zZ2O5zLmEayzslZmi/sFlaYoTA0T5UsfAHeu7HJ2Yr5jYE9bO
 ArpYH0s4DWSWDToyk9M6hf78XbpY0Nnmadg++TSK5HMx72WqxWL0xM3HSYrm4xJqEz2r5eQHWGQ
 D/hQqnRJFbXQ0O6aWnRGEnpJs91VCPjj1ymtOVOr6vmcWj6uq2N4U81y/OHkl8Iz6qPLhnN+utQ
 3v0tVvuUEPZ8SeiQLvYFgBkpOt2xQcBkYnhIakPUVnFcV58sbqIseYw16P0qXxEItigceyxzoGa
 hQLFTyOmtXw59V2aioNbOBlaPZKMKrlcz8m60X2LRSPp+SFhpL6J3u0POcJ+Pa12aYcKfZ3t2Hl
 BKS1QccwMHGxIi23eGdjmv5CK2mWfqvD7pB//izrdx8pDdwD26VpJgjMHC3itWBx6E3le4XP9uZ
 Vc+4PU9ii/JbKYKv+Dg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA1MDE1OCBTYWx0ZWRfXydYxTU+OVMdX
 MfTy1ykyNgRQjzWhR6uFROzNlLb59Oqbsr4eowCt5qHt5mx18gq7i8N+n4sqIvLK1sfw9l5yZjX
 j3y6ETtWUibSYvm/jx70ythujWYTqfA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609050158
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

Devcoredump is, unfortunately, not fully wired up for gen8, so
unfortunately it won't be too useful.  But this does smell a bit power
related so I expect lower OPPs would be more stable.

BR,
-R
