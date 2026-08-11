Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC652C5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 23:48:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBE9710E1A6;
	Tue, 11 Aug 2026 23:48:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CAWuA8aD";
	dkim-atps=neutral
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com
 [209.85.208.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6106110E3A7
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 23:48:21 +0000 (UTC)
Received: by mail-lj1-f174.google.com with SMTP id
 38308e7fff4ca-39c94fccf3eso5028541fa.0
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 16:48:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786492099; cv=none;
 d=google.com; s=arc-20260327;
 b=KbIEUYxcsHSnZMhhqmDznBeY1liBFd5XfVNB1ehaGCXKhx4ukNIZzCKVx2bRSPbNsd
 E0gSRp9dOd4KoVbt1aVHtbH4vIbFm5M5UzRfd6yHh+T/k3wNPEGMH78+BPyeGsDvB4/I
 E0jRZKbP7B4phds6DDoWwWsn/MijYCr3f6R7Xq8k4kKtecyCL5EW0t0LfJhm6lvq1lDs
 6eb1V23OahE47Wuiy5DqAJrJZ7ISu91gHpO2lH1j5cIhI0koSKZh6lSaDDbPvl7/Q9NC
 oOK8thEK/otumWzQWf0fkVf9mFb4JtTGdoNn31uJtTKxVgH+5JsPbLA1lYI10vQdcIYh
 MNYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2v8c/t2XNNgMLOvm+YLPynbBDsv4JXJ1xwFLnZFif1M=;
 fh=XrBocfJp9HhZ00HnzdpH1nSGcwsjRWqq/MBE2En5Og8=;
 b=PolXsjeWIjbulsMv37ObW2/kaqwVhkffGBaifeEoKttFiKl2H+lehSvR/VdvVF+0wN
 S6wqMM8xr6jcDejOtSTB0cnjFAbD79kPn00OfF+rdsM8E3z67wpEjHMGxdipemxwQwqu
 JkbVKkC9lxr72zZbTafsJN0rN0Wrx45eveBQYiixqWTtihC0tj2xG9WdOJ6J4HTS+XPf
 p3TuvAyVbYEgLik6HdMo4GPG0FqULS73sUX9R0TtG9jrpzwVshmzbNKlvFfrzJAT2OEW
 9n1pRHHw8K/UFfOqKVQR5okXZFRBSrjjfPrmH7zxa0yHOyVSxnipaCSdamzmZi4Epm7s
 YxKA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786492099; x=1787096899; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2v8c/t2XNNgMLOvm+YLPynbBDsv4JXJ1xwFLnZFif1M=;
 b=CAWuA8aDF7ZnSko4MCuCdsQzB0RP9iKPXla57UL9EK14npThQFdCbnXck7bElzc4wR
 SDrXo4piMjlDk3/OtIjlFLwUo+6euxQrutQL2bVvIbBvVTTTe0DKc/g19Gsyfe3LnQwD
 OSyo940KPfSEl1dXW2niAnnRbjIgPqXcOVBkWLhpWv/77+Qr23eorP+MLpY6SWThgw0X
 5MMTazTEf8JMovLKhPzjH7gy7YbbHqydlcoxMMkMnMdU+is6UIeuQ1gATD0ZOASo+QFI
 SuroF/vWef9SHukpPm/w0DGZ8s07xe9/KJ7GmQXEV80fl1mx9K6J3yPOMh9vGe7npfvp
 8cdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786492099; x=1787096899;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2v8c/t2XNNgMLOvm+YLPynbBDsv4JXJ1xwFLnZFif1M=;
 b=NIM+cOWuLJiKBdbwAgKDyRSm5tz++AbiI8mRha5WvEdE/altPJ5Wuo8I2jbtbpz63w
 c2VP3DdCN8zjPmHbjJyMmRaD8hoNFKSZI2rtPUXisFh/vdSWt2SqLNCNkYapi6CM2VVR
 E9z/tNMx1pmMMVqDP4/XQ996xeuaHLXWDt1gB2vWljRQhOHdgzAZykF3RTDgv1+vDQud
 RYMFDCgs8rGVlQz2UsbLVq0WtWEHbLIhNVp4I9rBfG5Rf9H9GRsmsO8B2fa/WzBUQaqG
 BeK+GZml8/S377edLLmo+j9ahZA4MMt5p9RQdC8jEY87XoOtpLB8fQZ+OxfFcX09/eZo
 c3Vg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrzJmIvnaTv2XKoR0MIdJhdone8mfTq6EKFXXUl3iEzUx6la5AWf3/21038ycpTjzmXJkD4WluEn04=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz23ApA86Dq2aWysYl7Qp6dQ+hWVbJBVv/dIfg7DEcog36qWMHB
 BEHVQRSpWf9tDpd29Ag17EHRXDFAJUIe7/1bnFhfyxjyoZmb0C/awWUKWle6nvI5YYG2RcTMue3
 vX4CvaNNbSn+RVhQ6/qArIeHR9xlHJeI=
X-Gm-Gg: AR+sD11USjN/z5VO5bNv4PMNiDqWfjxmz5XdJX8xoqQEHwbxiwtWST7bSpMbjX71isW
 JKbLBKiBqPx0Zm1qNfIqkVKe9V7jy7RBOUf3kMZlCt5pZmobQivPW0tqR7qG/yYD15OVLrBsaCf
 MAqGRpuMKcwxMMrPqBrombj7aBYmcwk7Ejh8nPrXJ3+UxEZA/1Z6KtyuLHE93jxE/j/4Yb02dGK
 VSvenGdqX1i6FYH43fToEVW6JPp9r4WhY3bgMYPKihqzON4YcLdXVF3G+4Ft7xgABRzzR5ncRcW
 6y7iA0+8KEevZIyPMMc94w3qIcjBS+O2E//dtzZ4cszXvUT485HPa/VQUc+tabQmpo3mzmV8yK7
 BMNUQYawCWyt/rJeoA8c2lxzYcqSIwaVn9QDGfNbGQg==
X-Received: by 2002:a05:651c:510:b0:396:7e66:45ba with SMTP id
 38308e7fff4ca-3a10d4d0cb8mr229091fa.8.1786492099161; Tue, 11 Aug 2026
 16:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <CALHNRZ-yffAy7xZbjVEZOfgVeqFGZ6h9jvNkbtTsNNXGQSgeCQ@mail.gmail.com>
 <471185ea-acb6-4e82-80a3-ac716a1cd8ad@oss.qualcomm.com>
In-Reply-To: <471185ea-acb6-4e82-80a3-ac716a1cd8ad@oss.qualcomm.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Tue, 11 Aug 2026 18:48:07 -0500
X-Gm-Features: AUfX_mx5Ig8I3Sj5vECfhlqPLWkRaKAaNIS_xT5xFaP_LgYmRTq5k2zP334pZIQ
Message-ID: <CALHNRZ9cy=iNKcxVNC+KVm29B29=fZtc0EX6V3qTe4fqexbiVA@mail.gmail.com>
Subject: Re: [PATCH 1/6] drm/msm/a8xx: Add support for Adreno 830 GPU
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: abhinav.kumar@linux.dev, David Airlie <airlied@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 Jessica Zhang <jesszhan0024@gmail.com>, jie.zhang@oss.qualcomm.com, 
 Konrad Dybcio <konradybcio@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <lumag@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 marijn.suijten@somainline.org, Maxime Ripard <mripard@kernel.org>, 
 Rob Herring <robh@kernel.org>, robin.clark@oss.qualcomm.com, sean@poorly.run, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
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

On Tue, Aug 11, 2026 at 5:54=E2=80=AFPM Akhil P Oommen <akhilpo@oss.qualcom=
m.com> wrote:
>
> On 8/11/2026 1:29 PM, Aaron Kling wrote:
> >> From: Jie Zhang <jie.zhang@oss.qualcomm.com>
> >> Add support for the Adreno 830 GPU present in SM8750 SoC. Adreno 830 G=
PU
> >> belongs to the A8x Gen 1 family and it is architecturally close Adreno=
 840.
> >> Add a new catalog entry along with the register list to enable support
> >> for this GPU.
> >> Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
> >> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> >> ---
> >>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 334 +++++++++++++++++++++=
+++++++++
> >>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c     |   2 +-
> >>  drivers/gpu/drm/msm/adreno/adreno_gpu.h   |   5 +
> >>  3 files changed, 340 insertions(+), 1 deletion(-)
> >> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/d=
rm/msm/adreno/a6xx_catalog.c
> >> index 90a0c7ffb3c8..418edde9104e 100644
> >> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> >> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> >> @@ -1693,6 +1693,294 @@ static const struct adreno_info a7xx_gpus[] =
=3D {
> >>  };
> >>  DECLARE_ADRENO_GPULIST(a7xx);
> >>
> >> +static const struct adreno_reglist_pipe a830_nonctxt_regs[] =3D {
> >> + { REG_A8XX_CP_SMMU_STREAM_ID_LPAC, 0x00000101, BIT(PIPE_NONE) },
> >> + { REG_A8XX_GRAS_DBG_ECO_CNTL, 0x00000800, BIT(PIPE_BR) | BIT(PIPE_BV=
) },
> >> + { REG_A6XX_PC_AUTO_VERTEX_STRIDE, 0x00000001, BIT(PIPE_BR) | BIT(PIP=
E_BV) },
> >> + { REG_A8XX_PC_VIS_STREAM_CNTL, 0x10010000, BIT(PIPE_BR) | BIT(PIPE_B=
V) },
> >> + { REG_A8XX_PC_CONTEXT_SWITCH_STABILIZE_CNTL_1, 0x00000002, BIT(PIPE_=
BR) | BIT(PIPE_BV) },
> >> + { REG_A8XX_PC_CHICKEN_BITS_1, 0x00000003, BIT(PIPE_BR) | BIT(PIPE_BV=
) },
> >> + { REG_A8XX_PC_CHICKEN_BITS_2, 0x00000200, BIT(PIPE_BR) | BIT(PIPE_BV=
) },
> >> + { REG_A8XX_PC_CHICKEN_BITS_3, 0x00400000, BIT(PIPE_BR) | BIT(PIPE_BV=
) },
> >> + { REG_A8XX_PC_CHICKEN_BITS_4, 0x00500050, BIT(PIPE_BR) | BIT(PIPE_BV=
) },
> >> + /* Configure GBIF GX registers */
> >> + { REG_A8XX_UCHE_GBIF_GX_CONFIG, 0x010240e0, BIT(PIPE_NONE) },
> >> + { REG_A8XX_RBBM_GBIF_CLIENT_QOS_CNTL, 0x22122212, BIT(PIPE_NONE) },
> >> + /* Enable full concurrent resolve and unresolves */
> >> + { REG_A7XX_RB_CCU_CNTL, 0x00000068, BIT(PIPE_BR) },
> >> + /* Partially enable perf clear, Disable DINT to c/z be data forwardi=
ng */
> >> + { REG_A7XX_RB_CCU_DBG_ECO_CNTL, 0x00002200, BIT(PIPE_BR) },
> >> + { REG_A8XX_RB_GC_GMEM_PROTECT, 0x0c000000, BIT(PIPE_BR) },
> >> + /* Configure number of outstanding transactions to 32 */
> >> + { REG_A8XX_RB_RESOLVE_PREFETCH_CNTL, 0x00000007, BIT(PIPE_BR) },
> >> + /* Configure UCHE request time out to 16 cycles for CCU/UCHE arbitra=
tion */
> >> + { REG_A8XX_RB_CMP_DBG_ECO_CNTL, 0x00004000, BIT(PIPE_BR) },
> >> + { REG_A8XX_RBBM_NC_MODE_CNTL, 0x00000001, BIT(PIPE_NONE) },
> >> + { REG_A8XX_RBBM_SLICE_NC_MODE_CNTL, 0x00000001, BIT(PIPE_NONE) },
> >> + { REG_A8XX_RBBM_WAIT_IDLE_CLOCKS_CNTL, 0x00000030, BIT(PIPE_NONE) },
> >> + { REG_A8XX_RBBM_WAIT_IDLE_CLOCKS_CNTL2, 0x00000030, BIT(PIPE_NONE) }=
,
> >> + { REG_A8XX_RBBM_CGC_P2S_CNTL, 0x00000040, BIT(PIPE_NONE) },
> >> + /* Enable contribution of all shader stages to SP perfcounters */
> >> + { REG_A6XX_SP_PERFCTR_SHADER_MASK, 0x0000003f, BIT(PIPE_NONE) },
> >> + /*
> >> + * BIT(26): Limit the number of wave-slots for Eviction buffer to 1 p=
er ALU GRP
> >> + * BIT(30): Disable LPAC auto-promotion
> >> + */
> >> + { REG_A7XX_SP_CHICKEN_BITS_1, BIT(26) | BIT(30), BIT(PIPE_NONE) },
> >> + /*
> >> + * BIT(22): Disable PS out of order retire
> >> + * BIT(23): Enable half wave mode and MM instruction src&dst is half =
precision
> >> + */
> >> + { REG_A7XX_SP_CHICKEN_BITS_2, BIT(22) | BIT(23), BIT(PIPE_NONE) },
> >> + { REG_A7XX_SP_CHICKEN_BITS_3, 0x00300000, BIT(PIPE_NONE) },
> >> + { REG_A7XX_SP_HLSQ_TIMEOUT_THRESHOLD_DP, 0x00000080,  BIT(PIPE_NONE)=
 },
> >> + { REG_A6XX_TPL1_DBG_ECO_CNTL, 0x10000000, BIT(PIPE_NONE) },
> >> + /* Enable cubemap small miplevel optimization settings */
> >> + /* BIT(26): Disable final clamp for bicubic filtering */
> >> + { REG_A6XX_TPL1_DBG_ECO_CNTL1, 0x04000724, BIT(PIPE_NONE) },
> >> + /* Disable tag bank id hashing */
> >> + { REG_A6XX_UCHE_MODE_CNTL, 0x00080000, BIT(PIPE_NONE) },
> >> + { REG_A8XX_UCHE_CCHE_MODE_CNTL, 0x00001000, BIT(PIPE_NONE) },
> >> + /* Limit gmem number of ways for GMEM requests in each set */
> >> + { REG_A8XX_UCHE_CCHE_CACHE_WAYS, 0x00000800, BIT(PIPE_NONE)},
> >> + /* Disable write slow pointer in data phase queue */
> >> + { REG_A8XX_UCHE_HW_DBG_CNTL, BIT(8), BIT(PIPE_NONE) },
> >> + /* Configure UCHE to CCU switchthreshold timeout cycles */
> >> + { REG_A8XX_UCHE_VARB_IDLE_TIMEOUT, 0x00000020, BIT(PIPE_NONE) },
> >> + { REG_A7XX_VFD_DBG_ECO_CNTL, 0x00008000, BIT(PIPE_BR) | BIT(PIPE_BV)=
 },
> >> + { REG_A8XX_VFD_CB_BV_THRESHOLD, 0x00500050, BIT(PIPE_BR) | BIT(PIPE_=
BV) },
> >> + { REG_A8XX_VFD_CB_BR_THRESHOLD, 0x00600060, BIT(PIPE_BR) | BIT(PIPE_=
BV) },
> >> + { REG_A8XX_VFD_CB_BUSY_REQ_CNT, 0x00200020, BIT(PIPE_BR) | BIT(PIPE_=
BV) },
> >> + { REG_A8XX_VFD_CB_LP_REQ_CNT, 0x00100020, BIT(PIPE_BR) | BIT(PIPE_BV=
) },
> >> + { REG_A8XX_VPC_FLATSHADE_MODE_CNTL, 0x00000001, BIT(PIPE_BR) | BIT(P=
IPE_BV) },
> >> + /* Disable redundant tile data optimization */
> >> + { REG_A8XX_VSC_KMD_DBG_ECO_CNTL, BIT(11), BIT(PIPE_NONE)},
> >> + { },
> >> +};
> >> +
> >> +static const u32 a830_protect_regs[] =3D {
> >> + A6XX_PROTECT_RDONLY(0x00000, 0x03a3),
> >> + A6XX_PROTECT_RDONLY(0x003b4, 0x008b),
> >> + A6XX_PROTECT_NORDWR(0x00440, 0x001f),
> >> + A6XX_PROTECT_RDONLY(0x00580, 0x005f),
> >> + A6XX_PROTECT_NORDWR(0x005e0, 0x011f),
> >> + A6XX_PROTECT_RDONLY(0x0074a, 0x0005),
> >> + A6XX_PROTECT_RDONLY(0x00759, 0x0026),
> >> + A6XX_PROTECT_RDONLY(0x00789, 0x0000),
> >> + A6XX_PROTECT_RDONLY(0x0078c, 0x0013),
> >> + A6XX_PROTECT_NORDWR(0x00800, 0x0029),
> >> + A6XX_PROTECT_NORDWR(0x00837, 0x00af),
> >> + A6XX_PROTECT_RDONLY(0x008e7, 0x00c9),
> >> + A6XX_PROTECT_NORDWR(0x008ec, 0x00c3),
> >> + A6XX_PROTECT_NORDWR(0x009b1, 0x0250),
> >> + A6XX_PROTECT_RDONLY(0x00ce0, 0x0001),
> >> + A6XX_PROTECT_RDONLY(0x00df0, 0x0000),
> >> + A6XX_PROTECT_NORDWR(0x00df1, 0x0000),
> >> + A6XX_PROTECT_NORDWR(0x00e01, 0x0000),
> >> + A6XX_PROTECT_NORDWR(0x00e03, 0x1fff),
> >> + A6XX_PROTECT_NORDWR(0x03c00, 0x00c5),
> >> + A6XX_PROTECT_RDONLY(0x03cc6, 0x1fff),
> >> + A6XX_PROTECT_NORDWR(0x08600, 0x01ff),
> >> + A6XX_PROTECT_NORDWR(0x08e00, 0x00ff),
> >> + A6XX_PROTECT_RDONLY(0x08f00, 0x0000),
> >> + A6XX_PROTECT_NORDWR(0x08f01, 0x01be),
> >> + A6XX_PROTECT_NORDWR(0x09600, 0x01ff),
> >> + A6XX_PROTECT_RDONLY(0x0981a, 0x02e5),
> >> + A6XX_PROTECT_NORDWR(0x09e00, 0x01ff),
> >> + A6XX_PROTECT_NORDWR(0x0a600, 0x01ff),
> >> + A6XX_PROTECT_NORDWR(0x0ae00, 0x0000),
> >> + A6XX_PROTECT_NORDWR(0x0ae02, 0x0004),
> >> + A6XX_PROTECT_NORDWR(0x0ae08, 0x0006),
> >> + A6XX_PROTECT_NORDWR(0x0ae10, 0x036f),
> >> + A6XX_PROTECT_NORDWR(0x0b600, 0x1fff),
> >> + A6XX_PROTECT_NORDWR(0x0dc00, 0x1fff),
> >> + A6XX_PROTECT_RDONLY(0x0fc00, 0x1fff),
> >> + A6XX_PROTECT_NORDWR(0x18400, 0x003f),
> >> + A6XX_PROTECT_RDONLY(0x18440, 0x013f),
> >> + A6XX_PROTECT_NORDWR(0x18580, 0x1fff),
> >> + A6XX_PROTECT_NORDWR(0x1b400, 0x1fff),
> >> + A6XX_PROTECT_NORDWR(0x1f400, 0x0477),
> >> + A6XX_PROTECT_RDONLY(0x1f878, 0x0787),
> >> + A6XX_PROTECT_NORDWR(0x1f930, 0x0329),
> >> + A6XX_PROTECT_NORDWR(0x20000, 0x1fff),
> >> + A6XX_PROTECT_NORDWR(0x27800, 0x007f),
> >> + A6XX_PROTECT_RDONLY(0x27880, 0x0381),
> >> + A6XX_PROTECT_NORDWR(0x27882, 0x0001),
> >> + A6XX_PROTECT_NORDWR(0x27c02, 0x0000),
> >> +};
> >> +DECLARE_ADRENO_PROTECT(a830_protect, 64);
> >
> > I have tested this on an AYN Odin 3, which has a CQ8725S SoC with
> > A830. As-is, this change causes the device to fail to boot. Comparing
> > to a different implementation of this support that I used previously,
> > I found the operable difference is the count_max field here. Dropping
> > that from 64 to 15 allows the device to boot and work as intended. I
> > unfortunately don't have uart to see what the actual failure text is
> > and provide any more information than this.
>
> Maybe your stack is missing this patch:
> https://lore.kernel.org/lkml/20260502-adreno-810-v5-5-bc9fd2bb788d@pm.me/

This is correct. The kernel baseline I am using is partway between 7.1
and the 7.2 rc's and does not have that series yet. Picking that
specific commit does resolve the failure without needing to change
count_max.

Aaron
