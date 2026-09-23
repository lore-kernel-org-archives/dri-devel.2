Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF0CC9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 19:24:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3104710E98C;
	Wed, 23 Sep 2026 19:24:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HekNAfX1";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30BF710F12B
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 19:24:37 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-39dfedbf80fso29198a91.3
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 12:24:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790191477; cv=none;
 d=google.com; s=arc-20260327;
 b=NmfkMEOivN7U563fddmUDNfqD0DeFLBuhRaoYfpXOWQUzHuM/JjqfkzkaQ9a+2s6Ej
 hDW3f3o4uLfxu9i1aeILsmYHyzlG63qycU5Y9Lsi8YAjxQJMneIJrG7mTxaN/SYkhNW8
 Z9MJ3Pu8/osxMxKdoTNeFnUeTbvG8zemppNkQgNFQKav87XjD6mQwE1loIStQrzVghgA
 2vk65ras9wHSkIGEf0nWNnO0Pg3S14IPLBbf0xMo4YfLMUWvYikmG5FqWmktlydimPjH
 68eLbB0qdsrmIW6Uoc2KJ6Tk60MOlj6S7HRAMD3848pVOOVXzuZaMszn5v4zcCYTcUvt
 BLOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0x2nZQroxHQRc04e1jt8isM+CH3x3G89bDQEzIpEuKE=;
 fh=PUT/tTovCC4At04nJ3SyHN02yxJRWmfxcIONn8LMYJA=;
 b=Od7WNp9iXilRAX7HJayIw0kra7IxsYGQh3OXYhIqahzAKsi1ajWzgGLk7wwa/sEzYg
 Q9fGfgwVMpsv4fAi+8P49cf6HJsP8QKxczSF2MawO27xRlTKBitcmZhJ4Q9WnfJji2M1
 uchXCyDPLOwMDs4nnmBlZE/Vzi8Io0orMpcLgsSKoBpDeZrz/I091GJk0E+QQ5NnR91L
 CSnKxI9xGV7cnzc5OPpjmrjwTi5vAsnpo9a4CtKx2KZkgV6lXdfaSqEhZMRYzWDo+78Z
 cwNs4mrOkRG87vNL5OqxplVK9TCi0bFJ10L1OIHd3gox+iSyk1ofPffeAkRB09vlUkyZ
 Mecg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790191477; x=1790796277; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0x2nZQroxHQRc04e1jt8isM+CH3x3G89bDQEzIpEuKE=;
 b=HekNAfX10wiqPlWi7oAkOissNPW+uaXOzip/iYvIl3gYlYX7ePXxbqOmOqM1fBD3Zz
 uy5MT45Rp+NUcSYxDz7DOVbCs05apXb/8omI6uJ3xoXzRBdX+HQzJcegHy+70BBoEfc2
 or2eAxV2wjg77wRFyhF3F4felKKnyw/xV563PETL+xBT9pFnIveerlay7CyBlbI0eAVS
 84odENGxtaZ+MW9cymQG85jmtjp9KY+ONywvXvC72ye+GRo1fKzBbWBfEG3paYqNVk46
 GsUTUHCYWFnHXK2OY7+EwRo1VSLHoIBKTehpPQEqAQ0Al6Pnfk7aUN6eCWN+2/iFg87O
 xjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790191477; x=1790796277;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0x2nZQroxHQRc04e1jt8isM+CH3x3G89bDQEzIpEuKE=;
 b=ANCpjxKW/GIVramSpaz1OOd0JGJZTVtgBLjGVgQIqs1+XXHkFglnet4hMK/zaD4iaR
 Cw5fSw0PTB62ICbCARTzixPqsGpUfp5fI/1+oH5kZEtPjrAWU9QUNOfF7Lg0Jzabd3KF
 emUwrwFXMoO6w2e9ogdMrWtdFyO4q02mlE/dnxxVM5rMOq6LHNVt8ZU5F+fOn929TjR2
 aPLK/I4M6NJSVXFbGde72g/GOSVZ+EiUtmTsHkaOfYkc5R4PjrWtMtey12wp/gswt36L
 9fJu+/pnmpnRyQNBlTcv6a7fGY7v3ScqyvGlIFgH4yOE6SqI7qHR48rCKYM9PUhc1Wil
 6EOg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwx1My2bduEGqOO66jZ4hSCWvyP24aBQHvzCauz8UxJV9gDzng4VwUq0jTkDrtub3Zu+FUrPCx0sRw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lGc03EyE96LTPUA7TmEkaVswBGLF4tNQtEc9aOutglArB+crjX
 cOD4AfOXPN/ZeTvju+wpwl9F+cWmGXPOxsGof8HENv2TARDxUCFFQZW4ex7F+kzOVVv0ovsZXTM
 q6MBH3pka1sT0jq3+lmoJiRiYzOyJ6qQ=
X-Gm-Gg: AYBFou1k707MTqO+ZqpEVTcDffWV3bGg438Ud/F4FWGhfdl4Tkcubd688hZ5AQZMp9L
 UCLw4DJSdzZ6F1lqDeJOkUJsLjIu4kND88S8sPJvMhM+UiOqIIQMErJzB9HpteoFO9xljR3tfyQ
 L61nC1qGuU5Y3i6gycpsP3mqsxlzyt31Ymy1d77pAmnMerwLA1bnr3JcE9NrrduVA6TFAwH1gxO
 iXXih+oQA6cESzNs75VlhoJ330UHOqb1/3tkAAIcC35kNkBEyHnTRWH98WizEGWqUbLd0WS38X3
 nxfFOrWQc7H3rVPlt609YReIjk0tcReVUJScaUUvrhLgdHWiLTU9NQm74QOzKKF2njyfrzyq1Yv
 3OfwPycrd444=
X-Received: by 2002:a17:90b:254e:b0:3a0:238b:db4d with SMTP id
 98e67ed59e1d1-3a098dc0266mr188923a91.5.1790191476700; Wed, 23 Sep 2026
 12:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260923-hawi-gpu-v1-0-0c3c79a1a470@oss.qualcomm.com>
In-Reply-To: <20260923-hawi-gpu-v1-0-0c3c79a1a470@oss.qualcomm.com>
From: Connor Abbott <cwabbott0@gmail.com>
Date: Wed, 23 Sep 2026 15:24:24 -0400
X-Gm-Features: AcwNN1VoBofGVm8cbejsfh35C-7w7BgK4tswB9hEES5ypKbcuahQ7NLIu-ocYuY
Message-ID: <CACu1E7GndBnSj75ZVqic9NxdSakZJL3ZJOuz7D+RbVWA4DUqTQ@mail.gmail.com>
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

On Wed, Sep 23, 2026 at 6:26=E2=80=AFAM Akhil P Oommen <akhilpo@oss.qualcom=
m.com> wrote:
>
> Adreno 850 is the next generation of A8x GPU present in Hawi SoC. It shar=
es
> the ADRENO_8XX_GEN2 family and slice architecture with A840, but has many
> architectural improvements. There is a new block Matrix core (MALU) which
> helps to accelerate certain compute workloads. Also, there is a new Bx ra=
il
> that powes a part of the GPU IP. GMU is now powered by a dedicated GDSC
> powered by MxG rail.

If there is a dedicated rail for GMU, then
VK_KHR_calibrated_timestamps is likely broken, assuming that the GMU
AO counter is on this rail. The AO offset logic in kgsl probably needs
to be ported here. Has this been tested?

Connor

>
> Maili GPU (Adreno 845) is very similar to A850, except that it doesn't
> have the MALU block.
>
> We will post the Mesa support and linux-firmware support soon. MALU suppo=
rt
> will be brought in separately along with its support in Mesa.
>
> As there is no display support available for Hawi/Maili, validated offscr=
een
> testcases that render basic triangles, glmark2-offscreen etc.
>
> The driver/dt-binding patches are for Rob to pickup and the DT patches
> are for Bjorn.
>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
> To: Rob Clark <robin.clark@oss.qualcomm.com>
> To: Sean Paul <sean@poorly.run>
> To: Konrad Dybcio <konradybcio@kernel.org>
> To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> To: Dmitry Baryshkov <lumag@kernel.org>
> To: Abhinav Kumar <abhinav.kumar@linux.dev>
> To: Jessica Zhang <jesszhan0024@gmail.com>
> To: Marijn Suijten <marijn.suijten@somainline.org>
> To: David Airlie <airlied@gmail.com>
> To: Simona Vetter <simona@ffwll.ch>
> To: Jordan Crouse <jordan@cosmicpenguin.net>
> To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> To: Maxime Ripard <mripard@kernel.org>
> To: Thomas Zimmermann <tzimmermann@suse.de>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: Bjorn Andersson <andersson@kernel.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: freedreno@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Cc: devicetree@vger.kernel.org
>
> ---
> Akhil P Oommen (11):
>       drm/msm/a6xx: Honor perfmode_bw threshold on A8x
>       drm/msm/a6xx: Fix secondary rail vote in ARC votes
>       drm/msm/a6xx: Fix RPMH dependency votes
>       drm/msm/a6xx: Factor out RPMh arc-vote helpers
>       drm/msm/a6xx: Add BX rail support to GMU dependency votes
>       drm/msm/a6xx: Clamp MX dependency vote
>       drm/msm/a8xx: Add Adreno 850 support
>       drm/msm/a6xx: Send THINMEM config to GMU for A850
>       dt-bindings: display/msm: Document A850 GPU and GMU
>       arm64: dts: qcom: hawi: Add GPU support
>       arm64: dts: qcom: hawi-mtp: Enable GPU
>
> Bhaskar Reddy Valluru (4):
>       drm/msm/a8xx: Add Adreno 845 support
>       dt-bindings: display/msm: Document A845 GPU and GMU
>       arm64: dts: qcom: maili: Add GPU support
>       arm64: dts: qcom: maili-mtp: Enable GPU
>
>  .../devicetree/bindings/display/msm/gmu.yaml       |  90 ++++-
>  .../devicetree/bindings/display/msm/gpu.yaml       |   4 +
>  arch/arm64/boot/dts/qcom/hawi-mtp.dts              |   8 +
>  arch/arm64/boot/dts/qcom/hawi.dtsi                 | 336 +++++++++++++++=
+
>  arch/arm64/boot/dts/qcom/maili-mtp.dts             |   8 +
>  arch/arm64/boot/dts/qcom/maili.dtsi                | 309 ++++++++++++++
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c          | 446 +++++++++++++++=
++++++
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c              | 231 +++++++----
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.h              |   1 +
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h              |   2 +
>  drivers/gpu/drm/msm/adreno/a6xx_hfi.c              |  25 ++
>  drivers/gpu/drm/msm/adreno/a6xx_hfi.h              |   1 +
>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c              |  16 +-
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h            |  21 +
>  drivers/gpu/drm/msm/registers/adreno/a6xx.xml      |   8 +
>  15 files changed, 1407 insertions(+), 99 deletions(-)
> ---
> base-commit: 1e9b8055458b92f9ebab6f39d97ade5265a0b012
> change-id: 20260811-hawi-gpu-05b4ecfc3c4c
> prerequisite-message-id: 20260923-hawi-dt-post-v1-0-e41473b6298b@oss.qual=
comm.com
> prerequisite-patch-id: 239c169e15da44519b2dad09ecd92f0052757929
> prerequisite-patch-id: 6c586be864944bb1eed773e8c211b898bb1289fe
> prerequisite-patch-id: f3d8748ccdb6760563f3e07f701a18388a9408ed
> prerequisite-patch-id: b1639353868bed10fd3cbfcd01cfb88b7e737ead
> prerequisite-message-id: 20260922-maili-dts-v1-0-ac2b1b76bfd9@oss.qualcom=
m.com
> prerequisite-patch-id: 36f12c16bf9cb0411d8be2f396407c724162189d
> prerequisite-patch-id: 28ede1ab83d4b5b56423ebb09bae74b6599b3bac
> prerequisite-patch-id: 6b3e28c55c07bfcdca8bfa9219fa0c6c763c6f6e
> prerequisite-patch-id: a2007fdaaeaf2981860c54ae5514f5a6f06c6bb3
> prerequisite-patch-id: af8aa3c630647336bdaeffa9c88de3650f1e49e4
>
> Best regards,
> --
> Akhil P Oommen <akhilpo@oss.qualcomm.com>
>
