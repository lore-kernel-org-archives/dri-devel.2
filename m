Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6F4C5DF89
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 13:35:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69F3310E2B4;
	Fri, 21 Aug 2026 13:35:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cBu8b+3X";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fDnYMkTL";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AE2310E2AE
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 13:35:23 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67LCoav02444210
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 13:35:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=EGgQsjjT+EKRdOye7pYxMstrrJ0PX0qzvJBOzzPkvg8=; b=cB
 u8b+3XyTBgp6SlM5EdMs4p+/wwmozMKDNRA33WdUMt/SbYo7O0VitOgUyQ7cBN5x
 gaCovsenEWtmaU4JGEHkO1RbHBhWjc2laf4G/enPgPUOgYvbXCKNKamWm+9u6jKy
 I0k7oQ0tSynRf8vHDcu37nUkU3Zmwow/IWdaaC4NedH09at3alLqfxlb5RsDhKA9
 zkw1kWzOmbrx1Ka47iMigyIJv8El7au+cfThIAY2Fj5mHsPuhqkJ0o/X9R8Og+T9
 fw/95u50awX/RU2c8FwLMfmci4ciyWKoE4AxzcPnRpUnmZ0tMYL8hn8mJsKbAPz0
 RK2ob4Ev35Eo8s20fnXg==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6cdsjhvg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 13:35:22 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-456ab1a7f2cso1601254fac.3
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 06:35:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787319322; cv=none;
 d=google.com; s=arc-20260327;
 b=Fk0dQ6qM8OVuWleLW+Zcr0mg8V5zAdzIGY682m3GQuedZVRbqVYtaD4Hoq6AO5Zq5l
 F5aV3mA7+fKXcciLKepUHtWStLHSeYFX6rxrDRRlI96GXogc2+GfUCcClq1kHU20G4Wp
 K4cVgWwcddG2L1lVm3rTS0dDmWGiGMXXWoGnVbM7YPSe3JmYdk2+vXT32EW5pnjv55Zy
 FmdtTLnTc9GhLILRidnAw9JIhUh5dd9f2M9vcKjJ7aHO9w9LdeKJHwjqJ0W7CL1BFZNp
 iY8Dfp46sG8RUw7upYTBUK0HS2TbzTyp87tVI/xG3BcefNyBopJR4P3FWUaoNEmsF/Ua
 +sJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=EGgQsjjT+EKRdOye7pYxMstrrJ0PX0qzvJBOzzPkvg8=;
 fh=Q7U1gPw/lSdWqf5I/iZFpBg8qtvJK2HPuBiOlks3a9w=;
 b=eG4fjoEAsNxL5fj9qIYMMrT/5YmIlp3h65UFnVeoH7xwkAGY1Fw7yQ8GJGja0B5Ezc
 7Hu/ShsBwAUUgNFdhTpnx0cRwuQVWjpgCHrPlr+5KeuaXku1sikpiy0agIQ/59ZhojUp
 dC6vV1c98KA/Mai1kHFZvG/4tliSey5yoPonobH42Bt0I221/uemfEcxXxs4TojNhpPx
 F0QYmkvFLHvP8NmCQBLhMZ0u74xHAajpT+PGmtGYvaM8kobDCC/v+0bYdKac+GpUcoLy
 4wpQUMKqQS3ornxqRPW1stHWF5xdlpTUuSTIrCbwHD+b0cVzt6WHRx0m7y2SSl4a0tfh
 4A7Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787319322; x=1787924122;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EGgQsjjT+EKRdOye7pYxMstrrJ0PX0qzvJBOzzPkvg8=;
 b=fDnYMkTL6n6pRg3QNGT0dHQ9ZmBBTrtVgkEp7g4/VquhyGMDTt8BDO9+E9aDill5t+
 tatAUVSV3yqmSNwvkvpRCxVBbIOYGQnCLYE3Ls2RgHTXx5UfUr4cM79+ASEoTLKdD3HL
 OnbIeJiRpr7lQHOPmSTVYlTzofCRGhefY/9har8H4c9k7Mc7OB3vWA0ILEmbubBZQDcY
 kM4z9WAfR0kRqZODRdGDxaFFmh66IUf/lt16Vpia/6O64o4jOziLtSC3G1iYa1MUdA5y
 UnrV87m12Ma2G7bZOhv/7uLKtOLjIkuDmWW4VaSX6JBVhCOzm2lwr/9hooakNp+Y5VGq
 MHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787319322; x=1787924122;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EGgQsjjT+EKRdOye7pYxMstrrJ0PX0qzvJBOzzPkvg8=;
 b=SchDbEh8Eg0bFSz8Tmf5fJjCmdEq1s80iwczgb9I4h5bcqPfWJjeVRYqzucSG9du7x
 x+2jQSC2CX2HfFDwAwk9GFn1y3n00F7wVeasNm4cmPvywJ4QktovFM8i2/snzbCfgStO
 gLLjkx/oRtUVCZTlTidIpdkOfBNLFxJzwFLZfjVDlVAEoUqdzEJEIsChTdgraF6umWSq
 vnD0KjfzCXJHapOTdKT6K5WOg0FXDj8HK1n8wGO+Ud3ktbO42juVhiJITgvviZ4kfge9
 OauY+JlMvPqsb1wTv+qOjQlUUI1umSRY30QVY0n615V2QfNgdku2GUuivH7l/0XbDWrj
 Rjzw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqq9JjTXKgrkVLz8kneBRD8TIIp46KpA33kLVexo/fx5SkOISRhjOw7eTXmXH69aEgrdgB0vymRNMM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m+ATxlR0SzAA9H9b+Vwme+Brx52eBAQz7EyNlSVRZSH2fZuzNt
 7hSSSO3dZbfCQMlOtY5vzFd0v1PRZCat4ZQzA884oP1M9sj9mrePnWrFgfINd0MdmveSXtUj7um
 TCc/5DL2aCeHg5pdXBV3W+tBy3htE/Vd/Xkyf6XsU3hd644UVKnL6ZhHplU+J0fvJ3CiiI9Atj7
 GPOr6uXf2F3fYgXpo8JzDSGfRTAdrHTzIyxeWh4f3Vuwf+xw==
X-Gm-Gg: AR+sD107KwU+KhLBAL+s7XPBg7RuChdsT7kV1UvZzbMlVMkVeQsiNNIssCU7PG28hpP
 RPpAPpieVqGN6lLzkcip1Ewv20A0g03PrWNs11SOzOde7I/JkMiBaHEVgSxUvz3sh48Ke2f1hX/
 +J/7zTdxqun7P26YAGpL0mcNqEiQ26sc0Rka0upBLWUcZdxB7BMQsvGhFc
X-Received: by 2002:a05:6870:1d15:b0:456:c9f7:787c with SMTP id
 586e51a60fabf-46351473502mr6812841fac.17.1787319321682; 
 Fri, 21 Aug 2026 06:35:21 -0700 (PDT)
X-Received: by 2002:a05:6870:1d15:b0:456:c9f7:787c with SMTP id
 586e51a60fabf-46351473502mr6812772fac.17.1787319321277; Fri, 21 Aug 2026
 06:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260820154428.1278@ferrisoft.com>
In-Reply-To: <20260820154428.1278@ferrisoft.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Fri, 21 Aug 2026 06:35:10 -0700
X-Gm-Features: AcwNN1UiaeiwmovB3MnAFVEjAMtoAugtRp3z9oZpPE4thN2uzL1MwSpJhcy6nHc
Message-ID: <CACSVV003bOJo4OJGvwHAda3h+KoiVJnzOqjwAVfjNG=V-V+RAA@mail.gmail.com>
Subject: Re: drm/msm: unrecoverable a8xx hang-recovery loop on Glymur ("cx
 gdsc didn't collapse"); killing the offending client does not stop the loop
To: Greg Ociepka <greg@ferrisoft.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: yE9sgAOwRcXBHvvac5Z8QYW0AwSKbrrQ
X-Proofpoint-GUID: yE9sgAOwRcXBHvvac5Z8QYW0AwSKbrrQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEwNCBTYWx0ZWRfX+TF3uFqqOgTl
 PwXbJsGa/qOGCEbDRP4g0um4L7inqC9yjMZwkP05y7zxWHXsBC3EyF+KwZGfvkgXDzeatkcXLMg
 yhZbwiqDdiKzhvoom5MIXKg/K/GWmeU=
X-Authority-Analysis: v=2.4 cv=RN2D2Yi+ c=1 sm=1 tr=0 ts=6a88541a cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=zXLAmZJP3ypUEzgl:21 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=e5mUnYsNAAAA:8
 a=a8UEx8NLAAAA:8 a=hKCgGfK2mU0xOqVuEwwA:9 a=QEXdDO2ut3YA:10
 a=1zu1i0D7hVQfj8NKfPKu:22 a=Vxmtnl_E_bksehYqCbjh:22 a=-yeuc7zBjbfZT8aiaP-D:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEwNCBTYWx0ZWRfXyn/ZgO9GpnXX
 NmC+dyx6NrKyGJ3EG9gx4rBjH15GpTgWzG4ba9kFVO6fPoUgntJG37Ll3AjWiE3op8V/AdgyU/x
 +7mcVnTRH6Mhfn53ulETYwcyBn5jwM73Z/zAPPEyd6rgaolIv6Wu91AuWzkubBRUzQrVR1QJLGk
 d6DIIIqMJ/i7T4CzX+lcgmZJ3H9eyw6OPahczOVIooCK0zYot/SxKTR1HrvvJiAqwZhEhikSGDX
 m5cErGlL5s/ucjfGW385Jih+2CiFHPJAFIQdigOXAA0yEMYXZtStO0G0+IUCrRHyScQG3U6T5pr
 jL8k0bLneu/7rRYPoGdcj27zYNcChhVbzsqeXz1yrhHO1V9DId3J6dprRHrmhAS8WNIp5YH0byS
 jVDGxLVkMFK7kpGxU/A7hkReZRnkD4YhJ5hcF6lWuGuguiyGXNvWjUz9CxiXj39wxqQnTmtcmz/
 smQb/mQAcaSPeNqHrFw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210104
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

On Thu, Aug 20, 2026 at 6:44=E2=80=AFAM Greg Ociepka <greg@ferrisoft.com> w=
rote:
>
> Hi,
>
> On an ASUS Zenbook A16 (UX3607OA, Snapdragon X2 Elite Extreme "Glymur", A=
dreno GPU, chip id 0x44070041) we are hitting an unrecoverable GPU recovery=
 loop that, once triggered, can only be cleared by a full reboot.
>
> Environment:
> - kernel: linux-next next-20260730, plus a handful of local patches for t=
his laptop (USB wakeup-source/dma-coherent DTS, CPU thermal trips, an eDP l=
ink-training retry tweak and a DP debug-print ratelimit); none of them touc=
h the GPU, GMU, GDSC or GPU clock paths
> - Mesa 26.1.5 (freedreno, a8xx)
> - GMU firmware v5.2.38 (qcom/gen80100_gmu.bin) and gen80100_sqe.fw from l=
inux-firmware
> - niri (smithay-based Wayland compositor), ordinary desktop clients
>
> Symptom: a regular client (rotating across sessions: chromium, firefox, X=
wayland, thunderbird) eventually triggers a GPU fault. From that point reco=
very loops at roughly 1 Hz; every iteration logs:
>
>   adreno 3d00000.gpu: [drm:a8xx_irq [msm]] *ERROR* gpu fault ring 2 fence=
 28f9c status 00880005 gfx_status 00880004
>   adreno 3d00000.gpu: [drm:a8xx_irq [msm]] *ERROR* BR: status 00880004 rb=
 0002/0078 ib1 0000000000000000/0000 ib2 0000000000000000/0000 ib3 00000000=
00000000/0000
>   adreno 3d00000.gpu: [drm:a8xx_irq [msm]] *ERROR* BV: status 00880004 rb=
 0000/0078 ib1 0000000000000000/0000 ib2 0000000000000000/0000 ib3 00000000=
00000000/0000
>   msm_dpu ae01000.display-controller: [drm:recover_worker [msm]] *ERROR* =
44070041: hangcheck recover!
>   msm_dpu ae01000.display-controller: [drm:recover_worker [msm]] *ERROR* =
44070041: offending task: <client>
>   adreno 3d00000.gpu: [drm:a8xx_recover [msm]] *ERROR* cx gdsc didn't col=
lapse
>
> Observations across four separate incidents (2026-08-09 to 2026-08-20; lo=
ngest 60+ minutes; worst measured rate 161 recover cycles in 5 minutes):
>
> 1. The reported offending client differs between incidents and can change=
 within a single incident.
> 2. Killing the offending client does not stop the loop. We verified this =
explicitly: after SIGTERM-ing the reported victim the loop continued at an =
unchanged rate within seconds, and the next client that submitted work beca=
me the new "offending task". The corrupted state evidently survives in hard=
ware/firmware rather than in the client.
> 3. The loop never converges on its own; only a full reboot restores the G=
PU. While it runs, the victim's surface stays black and the whole desktop d=
egrades, since every recovery stalls the GPU.
> 4. Onset correlates with many clients creating GPU contexts in parallel, =
e.g. right after a session restore spawns half a dozen applications at once=
.
>
> Since every iteration reports "cx gdsc didn't collapse", the recovery pat=
h apparently never succeeds in power-cycling the GPU, which would explain w=
hy the fault state persists across recovery attempts. Two questions this ra=
ises:
>
> - Is the CX GDSC on Glymur shared with, or kept up by, other consumers (t=
he display path, for instance) so that it cannot collapse while the panel i=
s active - which would make this recovery flow structurally ineffective on =
this SoC?
> - Or does gen8/GMU require a different stop/reset sequence before the col=
lapse is attempted?

Hmm, I've not seen this on glymur slim7x, and I've crashed the GPU
plenty while burning down the remaining clcts/glcts/vkcts issues.  And
certainly not any GPU hangs/crashes in normal desktop usage.  (Vanilla
gnome-shell / fedora f44 here.)

System mesa is 26.1.6, but for testing/debug it has been newer ToT
mesa.  I kinda suspect that the mesa version does not matter, this
sounds more like a power issue.

Fwiw, the kernel I've been using: [1]..  but that doesn't have the a16
dts. I need to move forward to something newer, hopefully I'll get to
that today.  We'll see if I start seeing this issue.  Or maybe
something x2e vs x2ee is different regarding pmic/supplies?

My device doesn't have the highest OPP (1.85ghz), which I think your
device does.  We might be still missing some power related features
that are (more?) needed at higher freq's, or maybe I have a more lucky
piece of silicon?  Akhil would know more about this.  You might try
removing the highest OPP in gpu_opp_table (in glymur.dtsi) to see if
that improves stability?  (Repeat until it is stable if you have the
same issues w/ 1.7ghz.)

BR,
-R

[1] https://gitlab.freedesktop.org/robclark/msm/-/commits/glymur-next?ref_t=
ype=3Dheads

>
> We are happy to test patches, run instrumented builds, and provide full j=
ournals or devcoredumps - the machine reproduces this every couple of days =
under normal desktop use.
>
> Thanks,
> Greg Ociepka
>
