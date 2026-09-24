Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85811C9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 14:06:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFC2D10F5EB;
	Thu, 24 Sep 2026 14:06:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hb94lw3o";
	dkim-atps=neutral
Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com
 [74.125.228.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B321810F5EB
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 14:06:49 +0000 (UTC)
Received: by mail-pz2-f40.google.com with SMTP id
 41be03b00d2f7-cc1ab16a9b0so35473a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 07:06:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790258809; cv=none;
 d=google.com; s=arc-20260327;
 b=hLBb8hYXzKLDOcDhlKrwVhMqIKaIAJ485IvAcHNfZw0YjA3JFbhrhUlePy9VrTjEg3
 LYLto9OIJLjBb5hHMVCZ8kbHcg4AIbk5bbPOYlORHHHrNTwazn1BZ/SEoGaNzdk+MK/u
 qbxavgJ8cusff/23wKnYCtNOg/C7w4PtbhrfmA31Q4561GZcDQaM6tcrW7rp9sntHrFN
 cNhKldDh6DnJdqNDjkHDyiy0tyqTII4T9Ke8cLkpfth9/iggLgAP94/Kc3h4bnD1+/tx
 4CAkJ5o48aZ1kZuXR0WmHslNnWgO69VTunpG8DlhRUsfU2+NEcX+JBwXIUpDprP+jtDL
 1n/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JcTZ3ffRCO1EwcSB6GSlnipqVfq4JrFIZdul9BjBkvw=;
 fh=LBfE+XNEYkIEQrhdic/sFTSWx9EOZQ0sd6wrgcqXjJQ=;
 b=RF1cwPfnxfTIGrfSc27b4C4qhXvYG67NRQUKWsbQ8dU1bu+NGqCQRTh2V/2K7oneKM
 4daob1eUhLiiXNppyOe3FI4RO7nvtUbsxZ14p3qaIx4249iP40YOioBZKJXLLFGbQ5PA
 LM3bJ6ocF3tJ4WCnQQHaoah0wRswoAULpRBFftd+YAfcbSWanDGRExcqXAcWxmipyS1F
 JYZ7uSc2YunCIl9TYN6ft2NTKZLbuX0tbznGlgi6BXKPazrOclj7FnopCoX3wjvc4RRf
 69AjY9rYB2wW1L3dtV/b2SWqOWWubv67BLrAqyo5oVS0Az9sR6gpL5MyRHNBaUuFSjzJ
 dgGg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790258809; x=1790863609; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JcTZ3ffRCO1EwcSB6GSlnipqVfq4JrFIZdul9BjBkvw=;
 b=hb94lw3of1qUgBiScFg5e04eZZ9tiuQUZUYHvu+5q9uQUbeMNQbsmY6iDyNqthUezT
 bNXfYPEtxRYcLdnpyTfmTSnarQ9Gndow0FLZipQF85J3Rqj1FDRhHQ16zsHBGYe4U5sA
 TXY/9KfORYwFhUrKqs+qLvQaX04EXWL+4yxb0hiMcX/uWgTlsHJo7QnFbEA+okVe0beg
 Mi+wi19VhXCwbJOsEalCGrIud8sUJF1sOPA4vtPVdqJSdZvugGau2VTETxTYna0cSt1q
 ngS1mF4yLqxVgw1P/0xyqpOUzHBK/Vge4ANRi5oJ6gYAZYkJQjv0PYUi5ZRVL4egm2N3
 0sOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790258809; x=1790863609;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JcTZ3ffRCO1EwcSB6GSlnipqVfq4JrFIZdul9BjBkvw=;
 b=gct+DXsKXZnuv597pXzoO5i6td4PMvH81pes3ZcwI3aSplWqakphiKzDsFrJX4+Tu1
 HuWKmajNHcs+0orB+aDhsqeF07oQPREezri9GEmtxK+z5f57oyDFKt2An+nWdgOTBizH
 4o/vJKDasHK2MrI0QwOmfpSPOOV/SYSh21OMRdEjVElC0DlC7qBaKcII7O9D+kqc3ysa
 o5pWKVSEUxt17Q5co5NEIbhYyPGatWHkTKjmOPpoa3U+wuuK7+Swa3j/27lxojGEmfKp
 XXVfKZoit7e0FpjfVbNwZtjDaqcimuoFVLRT8xBFWAIaqzV6c23WxK21j+6fTbjPHhi1
 KuAA==
X-Forwarded-Encrypted: i=1;
 AKwUvByIcCA0SK1hzbzqln/qQcCXKC33u/V+HZQnWhS1E5cOUejy1iv86ZzeV5W0zbOG5XyblNoXnmHeP6c=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kNokh9NP9v2w6OJTJeMq2AgL9BtAuW6D9+w7x/Ec/CUyOYa8rY
 QNybe34ObLNszcl7ZOcvWb0djVXy31+NSbTG4GALBFYyO/pOwI0DjBkUwnMnlP/2+5LRq0UAh8h
 5U8X2bC9RgI6aAiUj3Tep8P6qCAZ+Fnu6M5gGVLk=
X-Gm-Gg: AYBFou2oxenCwpOYeS5dIHC0ytq5tZohAwV4yobpeTjl1SckKz3JOFAzNPXr1uM7rGe
 VCA6oqInno9QVLQabvswjiE/KeSaYpcs3n6o7JE0DQZZ/gd4gp5O6UmfsBlJBR+JmgjMElJZWVS
 SEitvr5WpTUzr6XlPiigfr758PIssaS1IkA+Ye0OOMa6T2MQc5up1vMsPpBdFZyvhKM10s+EZui
 eYjTX21iMfyDOvERJvDlVDpcnYjxQlADV4UW9y07f6btvyWbnZ7kvW8ag31EAqxQxZ81WS7hWwB
 hfPOA4GkXUqMxVt2tPdSIE3wSc4uciEON1PN2sasYg5PnUV64T9u5AXFe5GQkybOEBVtPDb5y5H
 ckjTEgPBP8Lls
X-Received: by 2002:a17:90b:3c06:b0:39d:f130:ba54 with SMTP id
 98e67ed59e1d1-3a09837f56dmr4405287a91.0.1790258809042; Thu, 24 Sep 2026
 07:06:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260923-hawi-gpu-v1-0-0c3c79a1a470@oss.qualcomm.com>
 <CACu1E7GndBnSj75ZVqic9NxdSakZJL3ZJOuz7D+RbVWA4DUqTQ@mail.gmail.com>
 <692ff69a-330e-40db-bffc-a53987fa4bce@oss.qualcomm.com>
In-Reply-To: <692ff69a-330e-40db-bffc-a53987fa4bce@oss.qualcomm.com>
From: Connor Abbott <cwabbott0@gmail.com>
Date: Thu, 24 Sep 2026 10:06:37 -0400
X-Gm-Features: AclHuK_K3H4oMYks1o-_9RZ45Z4Udp7YxXFegQ_4Y9VAlkof6K_6cES08nQszX4
Message-ID: <CACu1E7FuCVhu_0gKmVVeBL=e4=zghvXJT=mZVfg8UjUzRrv3Yw@mail.gmail.com>
Subject: Re: [PATCH 00/15] drm/msm: Support for Hawi & Maili GPU
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jordan Crouse <jordan@cosmicpenguin.net>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Thu, Sep 24, 2026 at 9:41=E2=80=AFAM Akhil P Oommen <akhilpo@oss.qualcom=
m.com> wrote:
>
>
>
> On 9/24/2026 12:54 AM, Connor Abbott wrote:
> > On Wed, Sep 23, 2026 at 6:26=E2=80=AFAM Akhil P Oommen <akhilpo@oss.qua=
lcomm.com> wrote:
> >>
> >> Adreno 850 is the next generation of A8x GPU present in Hawi SoC. It s=
hares
> >> the ADRENO_8XX_GEN2 family and slice architecture with A840, but has m=
any
> >> architectural improvements. There is a new block Matrix core (MALU) wh=
ich
> >> helps to accelerate certain compute workloads. Also, there is a new Bx=
 rail
> >> that powes a part of the GPU IP. GMU is now powered by a dedicated GDS=
C
> >> powered by MxG rail.
> >
> > If there is a dedicated rail for GMU, then
> > VK_KHR_calibrated_timestamps is likely broken, assuming that the GMU
> > AO counter is on this rail. The AO offset logic in kgsl probably needs
> > to be ported here. Has this been tested?
>
> Not sure how GMU core's power domain affect the AO timer. Could you pleas=
e point
> me to the AO offset related change in KGSL? I will check.

Previously the GMU AO counter was part of CX, which is kept on by
other things in the system, so it continues to tick even if the GPU is
suspended. However kgsl does not rely on that, and recalibrates the
GMU AO timer whenever booting the GMU [1], which we currently don't
do. I don't know if the timer is still part of CX, but if not, then
this part of kgsl could become load-bearing in a way it wasn't before.
It seems possible that it isn't part of CX anymore, given your
description that GMU and other things have been moved to new
GPU-specific power domains.

Connor

[1] https://git.codelinaro.org/clo/la/platform/vendor/qcom/opensource/graph=
ics-kernel/-/blob/gfx-kernel.lnx.16.0.r14-rel/adreno_gen8.c?ref_type=3Dhead=
s#L917

>
> -Akhil.
> >
> > Connor
> >
> >>
> >> Maili GPU (Adreno 845) is very similar to A850, except that it doesn't
> >> have the MALU block.
> >>
> >> We will post the Mesa support and linux-firmware support soon. MALU su=
pport
> >> will be brought in separately along with its support in Mesa.
> >>
> >> As there is no display support available for Hawi/Maili, validated off=
screen
> >> testcases that render basic triangles, glmark2-offscreen etc.
> >>
> >> The driver/dt-binding patches are for Rob to pickup and the DT patches
> >> are for Bjorn.
> >>
> >> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> >> ---
> >> To: Rob Clark <robin.clark@oss.qualcomm.com>
> >> To: Sean Paul <sean@poorly.run>
> >> To: Konrad Dybcio <konradybcio@kernel.org>
> >> To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> >> To: Dmitry Baryshkov <lumag@kernel.org>
> >> To: Abhinav Kumar <abhinav.kumar@linux.dev>
> >> To: Jessica Zhang <jesszhan0024@gmail.com>
> >> To: Marijn Suijten <marijn.suijten@somainline.org>
> >> To: David Airlie <airlied@gmail.com>
> >> To: Simona Vetter <simona@ffwll.ch>
> >> To: Jordan Crouse <jordan@cosmicpenguin.net>
> >> To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> >> To: Maxime Ripard <mripard@kernel.org>
> >> To: Thomas Zimmermann <tzimmermann@suse.de>
> >> To: Rob Herring <robh@kernel.org>
> >> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> >> To: Conor Dooley <conor+dt@kernel.org>
> >> To: Bjorn Andersson <andersson@kernel.org>
> >> Cc: linux-arm-msm@vger.kernel.org
> >> Cc: dri-devel@lists.freedesktop.org
> >> Cc: freedreno@lists.freedesktop.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Cc: devicetree@vger.kernel.org
> >>
> >> ---
> >> Akhil P Oommen (11):
> >>       drm/msm/a6xx: Honor perfmode_bw threshold on A8x
> >>       drm/msm/a6xx: Fix secondary rail vote in ARC votes
> >>       drm/msm/a6xx: Fix RPMH dependency votes
> >>       drm/msm/a6xx: Factor out RPMh arc-vote helpers
> >>       drm/msm/a6xx: Add BX rail support to GMU dependency votes
> >>       drm/msm/a6xx: Clamp MX dependency vote
> >>       drm/msm/a8xx: Add Adreno 850 support
> >>       drm/msm/a6xx: Send THINMEM config to GMU for A850
> >>       dt-bindings: display/msm: Document A850 GPU and GMU
> >>       arm64: dts: qcom: hawi: Add GPU support
> >>       arm64: dts: qcom: hawi-mtp: Enable GPU
> >>
> >> Bhaskar Reddy Valluru (4):
> >>       drm/msm/a8xx: Add Adreno 845 support
> >>       dt-bindings: display/msm: Document A845 GPU and GMU
> >>       arm64: dts: qcom: maili: Add GPU support
> >>       arm64: dts: qcom: maili-mtp: Enable GPU
> >>
> >>  .../devicetree/bindings/display/msm/gmu.yaml       |  90 ++++-
> >>  .../devicetree/bindings/display/msm/gpu.yaml       |   4 +
> >>  arch/arm64/boot/dts/qcom/hawi-mtp.dts              |   8 +
> >>  arch/arm64/boot/dts/qcom/hawi.dtsi                 | 336 ++++++++++++=
++++
> >>  arch/arm64/boot/dts/qcom/maili-mtp.dts             |   8 +
> >>  arch/arm64/boot/dts/qcom/maili.dtsi                | 309 ++++++++++++=
++
> >>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c          | 446 ++++++++++++=
+++++++++
> >>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c              | 231 +++++++----
> >>  drivers/gpu/drm/msm/adreno/a6xx_gmu.h              |   1 +
> >>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h              |   2 +
> >>  drivers/gpu/drm/msm/adreno/a6xx_hfi.c              |  25 ++
> >>  drivers/gpu/drm/msm/adreno/a6xx_hfi.h              |   1 +
> >>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c              |  16 +-
> >>  drivers/gpu/drm/msm/adreno/adreno_gpu.h            |  21 +
> >>  drivers/gpu/drm/msm/registers/adreno/a6xx.xml      |   8 +
> >>  15 files changed, 1407 insertions(+), 99 deletions(-)
> >> ---
> >> base-commit: 1e9b8055458b92f9ebab6f39d97ade5265a0b012
> >> change-id: 20260811-hawi-gpu-05b4ecfc3c4c
> >> prerequisite-message-id: 20260923-hawi-dt-post-v1-0-e41473b6298b@oss.q=
ualcomm.com
> >> prerequisite-patch-id: 239c169e15da44519b2dad09ecd92f0052757929
> >> prerequisite-patch-id: 6c586be864944bb1eed773e8c211b898bb1289fe
> >> prerequisite-patch-id: f3d8748ccdb6760563f3e07f701a18388a9408ed
> >> prerequisite-patch-id: b1639353868bed10fd3cbfcd01cfb88b7e737ead
> >> prerequisite-message-id: 20260922-maili-dts-v1-0-ac2b1b76bfd9@oss.qual=
comm.com
> >> prerequisite-patch-id: 36f12c16bf9cb0411d8be2f396407c724162189d
> >> prerequisite-patch-id: 28ede1ab83d4b5b56423ebb09bae74b6599b3bac
> >> prerequisite-patch-id: 6b3e28c55c07bfcdca8bfa9219fa0c6c763c6f6e
> >> prerequisite-patch-id: a2007fdaaeaf2981860c54ae5514f5a6f06c6bb3
> >> prerequisite-patch-id: af8aa3c630647336bdaeffa9c88de3650f1e49e4
> >>
> >> Best regards,
> >> --
> >> Akhil P Oommen <akhilpo@oss.qualcomm.com>
> >>
>
