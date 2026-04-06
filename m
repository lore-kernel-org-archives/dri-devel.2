Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46CA5FB5175
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 22:24:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CEF910E0A7;
	Mon,  6 Apr 2026 22:24:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bSDNo/Cp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mx75xrZi";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED1AF10E0A7
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 22:24:56 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 636LSvtR2580245
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Apr 2026 22:24:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=t2bz/AuUCyIyjUyeiEAv5+oKtlxkr+8qudGmv/ZvY58=; b=bS
 DNo/CpLSg5Q0/LYBh07j6rSOuEKz+t2Zyqk74J+9h+2fHqzqMddYKfJh/01Z8/G7
 Tdu1wLBcG5RYA66x4rgahrtot3t7g4ZcMyFuFay6O/VkA7i8Bwo6UFJ14pxF7ERm
 J/TGr74kJh/MVOK35vLkWXT3ZzbH56TX87e/DKdUnLQJiJ9tT31JklahFmpdCTyh
 o9tk4f+kTHfWe1BCFnwNd+p8fxrK7xdST/3B/UzYowaKmzLxbz+cz7c9U1FNxDsT
 JtWOX2EkGjQ9LTiIqeyY3Ul4p/wXcDIEt49ahH91Vl0pUW0opJIW6cWtyx+KR+/L
 cFG+g1NBO2bTOw2srhag==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmsf03vt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 22:24:55 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7d7e2c62d70so10659646a34.2
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 15:24:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775514295; cv=none;
 d=google.com; s=arc-20240605;
 b=D4YnQpBBA+Ey2+MIp1bAoHV0OOpF/93vpaIt3osK/63m5y3l6L13Rim23i0+BiMGK8
 uPrFYBd/4Qoci1Vt9k7ZkYFcaUQqisvlMUT/3LT97QF3DY2uhSidTO2FkEi1MMluI9iS
 pwRnlISs5waO58NBGIvVi3WLv+gKCNYfcCx7tdT27JtOExy59tBmSjkxcCAB23d9D3nC
 rS8JyWc8dhQ4DKVBlQLtKJKk2FXU29zwK+g+FlBsKJgtmloKmMrS0dPcP59MNGFGZWQc
 HUz0HnL9XcxufydpgrRU2tEvqy6TraYkkMVTvF1r3Xu8WismQOVMVSQKW2IbwAcGwubp
 M3gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=t2bz/AuUCyIyjUyeiEAv5+oKtlxkr+8qudGmv/ZvY58=;
 fh=zGb837pJxbecf6s5rbc8NN+krchlIr2q+s/W8HhusyY=;
 b=VTB4tgEfD2DER21kdr17gDBee2ahqBG2knYyXsTebk7FTJteq4ta+CitKKOwCrV93Q
 e2C3f4kgi6MZUS3brqYz76yvf4zFA6Yo5dNuj+XziyKmLpaqt7LIo+bkTLYa8/Tm3vgl
 YtSN5OJaUioyPhRvZUgl3wYVK2BflmKEAmd/6t3XoVjjBVFNLnvOClzidAS7DDVVGXrv
 sshWbd03nGHvtTIrha6wCiFZb7fQWWVSr8/XPGXYfcVB1VibZZMjQ+pHpaEgyT5YMLbj
 J+W1tLHMygEhsSpixo1u5r1Wa5U48w+6eAdehlw8Mb3wDSXS12ZXSfgFDBJwU8a4p38D
 YWPQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775514295; x=1776119095;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=t2bz/AuUCyIyjUyeiEAv5+oKtlxkr+8qudGmv/ZvY58=;
 b=Mx75xrZiWYmEr7byDYp12vnLjpJpgZICbj59cWMG31wpFvmfxTjcBGm7XRyM27cvbN
 sbK407ZhAgcDhlGvnkTmqt4EphDPGWpdmQLJGnuOQFQRLsCYlbRr/PglYbiyxNcvsa+x
 ABu1NQnCGOuwW3vZT5wFPU5mO8SpOfDPxlfee8WsN7Rbh5H4MSLdfI9SyAaN4BFXHz1v
 jwsyFB7LCxUVd4C3zAU60IQmIN/EYwN2RFwm44T7FoR4GHL0MgsrTSs9d7RHdb63GMu2
 csPUh0W0MQkJzeku7CeO7D9gqKeeI6glTRTDWAfYx4/bD9jI+yGOxHqrTeGOsHVYYRyW
 dvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775514295; x=1776119095;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t2bz/AuUCyIyjUyeiEAv5+oKtlxkr+8qudGmv/ZvY58=;
 b=pHqEw7lo39+SJ7GSZDLN13sJJv/irKgnaIlyEpCPSUeSqyFIJdOiD714x58NYUJ63x
 zDuy1B7PDjBAO4YtH8ce9/XjETu1aeR3IMm23thCnlJFc4oEjuTV2zcP2MRWk6lv1tKD
 Nc2mRDnvSlaDhho+ua2vE4m2Oa1YWbN605PTClKZEIVXQ0QNM6m1R+JkleJgxZth4lSL
 dEpuxsD2kfny9+PFkmsy8zvZi982wj/h1Ct8UqySXV5gJa83AlzCQGXvD5hYOCsiivHf
 WsxXyz1teXouDtreKGe59muEZA7dGbGmSocVlkajXWazMiTRO8o/CBgEWR5fM7SCyFuj
 Y0AA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcotuF2vIpFCzqAy1wixkit71dZgmSgJJ+elBvtV/E31bLBtpuI/JtXDpIOry6C/ZlGnAgoQyX7bk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzuUx9btH8bZZO/6YDF2autdXMZJnXX2SiypP4sqP3lorccAsWc
 /Y94WQPToC46m9KmuhvOJQrpIWB+zj2yx87AUfH8oRfQ+ernRvGGWCfiw25jzykasM78UMOqM7L
 Da1FeAkdUMr7PzarCG54fLxqAe4AwR/NytaFP6yKVyMnqC9a+JPKwotMT2/Q6Wji1kDzhVqABuy
 1rPvDpNzHYwkhZnsrbIKjAAbEGhKXPEaIR6bTDSDvG9guhqw==
X-Gm-Gg: AeBDies8FfAnd+C0dUzXTZSV1XOocnmZ5Zar7eytXbtXBMWOgkNEFTfhQWphqzV3VMP
 5ErEsquQzWoaRD6EyAf4xseXS8BK6yDXdHfecJ7IuhcJll10slx1zkp99kKCsP03H65j4rQ0lXw
 8rjILpPiTrutFAZSyjjubGX/S6Yhxh5VCHaA/hZzglEfcYUJUtV3xhKEYspCqXvgr2VrXpYm8OD
 Ymhm1hfqJSCijSAwwk9OBcALiT7KLXIbakwdw==
X-Received: by 2002:a05:6830:6b0d:b0:7d7:ddb9:5061 with SMTP id
 46e09a7af769-7dbb6fa2b4emr9066012a34.13.1775514294980; 
 Mon, 06 Apr 2026 15:24:54 -0700 (PDT)
X-Received: by 2002:a05:6830:6b0d:b0:7d7:ddb9:5061 with SMTP id
 46e09a7af769-7dbb6fa2b4emr9065986a34.13.1775514294542; Mon, 06 Apr 2026
 15:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260407-adreno-fix-ubwc-v1-1-bb2b09450b87@oss.qualcomm.com>
In-Reply-To: <20260407-adreno-fix-ubwc-v1-1-bb2b09450b87@oss.qualcomm.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 6 Apr 2026 15:24:43 -0700
X-Gm-Features: AQROBzBS8EWtQypBhKxnT0niYnWq5NV_q0tMBtRASSXiPvPyGM3PAAbslpXL_kk
Message-ID: <CACSVV03uVF-STTwCVR3=9Jf=dCh7buBmk-1LBhYO0YfUDYXNDQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/adreno: fix userspace-triggered crash on a2xx-a4xx
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDIxOSBTYWx0ZWRfX/VcrNXpefyFP
 k16KEZZ9xiw9n2hMMqcX2Q9nkVS8VYZB2nskPQAhrJm2ZnCuBKA1X9+7Fv5qw6UC3eB12Vo2DV4
 hcaIq58uzwbsWP5608q6z8dS14tYPKMqL56idCQPaAIg6RTU4Q05k+SOGZZ6mqAJm173bnd5mB9
 Nd1ybJeE2wlb6cGU3qjxrBWOh8IYP/Sx1JNLqvcnrgy7JVib4apHGOEQekNpS1/2vO/sXjEB7Pd
 VZOJqfMDqt+AmG2/1DF4U+cd1SVi3h266nUMdpM3AFSjjSSywzXW2gZRfmjNMZfwRtrmbYsVGj/
 uXrDIsiHfze447adt8jTsFK3LNvk3yzZDLs5GeSmfilFLMuVlZkEOLOi7ov1Np3tpYPQI32NNj8
 9J1vJcTMBVV6N80+0asp/i4OuDFLPgRtu+2ID1g4qhwXq33mtEY2E4iiADOe7yGl3dui6/MwbcE
 OfsoF4atxrQQ5aGwaVw==
X-Proofpoint-ORIG-GUID: 97Q4AmcktNuOc0YP7Oqi93rcDzSciOQ0
X-Proofpoint-GUID: 97Q4AmcktNuOc0YP7Oqi93rcDzSciOQ0
X-Authority-Analysis: v=2.4 cv=DcInbPtW c=1 sm=1 tr=0 ts=69d432b7 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=lCW5SLys8A1o4QUykOsA:9
 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 phishscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604060219
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

On Mon, Apr 6, 2026 at 3:14=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> Before a5xx Adreno driver will not try fetching UBWC params (because
> those generations didn't support UBWC anyway), however it's still
> possible to query UBWC-related params from the userspace, triggering
> possible NULL pointer dereference. Check for UBWC config in
> adreno_get_param() and return sane defaults if there is none.
>
> Fixes: a452510aad53 ("drm/msm/adreno: Switch to the common UBWC config st=
ruct")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/ms=
m/adreno/adreno_gpu.c
> index d5fe6f6f0dec..7dc95c0a17f7 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -426,16 +426,25 @@ int adreno_get_param(struct msm_gpu *gpu, struct ms=
m_context *ctx,
>                 *value =3D vm->mm_range;
>                 return 0;
>         case MSM_PARAM_HIGHEST_BANK_BIT:
> -               *value =3D adreno_gpu->ubwc_config->highest_bank_bit;
> +               if (!adreno_gpu->ubwc_config)
> +                       *value =3D 13;
> +               else
> +                       *value =3D adreno_gpu->ubwc_config->highest_bank_=
bit;

These three params are only used by userspace on a6xx, so tbh it would
be ok to return -ENOENT for platforms that have no ubwc config.  That
might be better than returning imaginary values.

BR,
-R

>                 return 0;
>         case MSM_PARAM_RAYTRACING:
>                 *value =3D adreno_gpu->has_ray_tracing;
>                 return 0;
>         case MSM_PARAM_UBWC_SWIZZLE:
> -               *value =3D adreno_gpu->ubwc_config->ubwc_swizzle;
> +               if (!adreno_gpu->ubwc_config)
> +                       *value =3D 0;
> +               else
> +                       *value =3D adreno_gpu->ubwc_config->ubwc_swizzle;
>                 return 0;
>         case MSM_PARAM_MACROTILE_MODE:
> -               *value =3D adreno_gpu->ubwc_config->macrotile_mode;
> +               if (!adreno_gpu->ubwc_config)
> +                       *value =3D 0;
> +               else
> +                       *value =3D adreno_gpu->ubwc_config->macrotile_mod=
e;
>                 return 0;
>         case MSM_PARAM_UCHE_TRAP_BASE:
>                 *value =3D adreno_gpu->uche_trap_base;
>
> ---
> base-commit: 36ece9697e89016181e5ae87510e40fb31d86f2b
> change-id: 20260407-adreno-fix-ubwc-6a2564710e21
>
> Best regards,
> --
> With best wishes
> Dmitry
>
