Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA48CFB5173
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 23:43:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C86F10E2FD;
	Mon,  6 Apr 2026 23:43:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="K5YiiQ57";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K5S54ped";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7AF810E2FD
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 23:43:22 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 636LSfGB2580030
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Apr 2026 23:43:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hfm5estcAn1Cw7C4MRrM5+NNSc/ctNCcBh2lICL2YvM=; b=K5YiiQ57crlXi82y
 AzktGtA8cSsJWrH8qVtdBCrnCMw6aFInSmAklRh3v4udOBEDQxwfQ/uCKUQCpLme
 Pac/X/t7sVYIoNOqzBy5+zCstSe6FP8fAKSm7wdh/shi9eIdvEb4ahdfEqNIK3GI
 IFmz/acmTwCa4wV3PVMpw62Auu95IjHnZ3vntanZkpSVmt0cDfECZvfzCH8o+j1o
 KGxtUvIW7NrDQdPv6h1WV4XC7y/2SXHI+3gVI2wMDeZI2Hho9jyymFVV/JfFve2c
 fDm+fU2NW8smqkTr/F+FMsrg0gV7UnHIgXfJ8N3bAzRjGMH0exfuUO+wxz0CLFtY
 P8h0pw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmsf08kr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 23:43:21 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50da529ff48so1253391cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 16:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775519001; x=1776123801;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hfm5estcAn1Cw7C4MRrM5+NNSc/ctNCcBh2lICL2YvM=;
 b=K5S54ped9k9PyUEq3Q+dan8gN1AJ7CTaCoEE1Nf9SI08RDFiEtS5ThvJajkKO7O50k
 EHQcLg6GPDKUYCSpVXnEQGcZoIsSxQT7Uo0NAQu4ZVmpugo8RuPQq2fVFATfyYXF386S
 mFkf2bQ47uzkdLDuF/96ljyUEP5F3W15OJXhZYuC46W/n6H2nJ7xSqfIFYZLOqKNv9eG
 6elpFIfhG3JAC+y2I1xVxeeL5URtZ+/X31HdwNsUikrzfQYgn/zq2TnOaJfYzqbI8uji
 BpXEEHxIlblbgLaOp59bE9hZxSvGv0QACyEqhy6Sh5CV/4+NayCiQn5nk6/wl13+B6O8
 DcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775519001; x=1776123801;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hfm5estcAn1Cw7C4MRrM5+NNSc/ctNCcBh2lICL2YvM=;
 b=fOpTzuScU6zGAbbARFIzQ72BzvhCGY5bLreqX9HA0518h0cUI7Y7r86wZTZk2sRvEh
 KgmuC2WrOFhVCjvRjfKwglYvUAwrbvj6F1tO05/3Ik75BF6jPmKuXrq4R+6xMoEAdEAd
 s81rLpjQd0PrP3wFiFP8aUW4SJgP8P1Kn6UMfr6kY1d5/mycZJn3M3yqBq1R0S857aDZ
 HQHD7A5C4C5NNd3Goar6It9YNMaRICNeKjXXgJIAMcqA4yWZgt8zeiZA4nPCLCfvu8YJ
 +vX/wCcx2lzLHQyvL8JqBkC4z0ieHQuwUQ3lxBmflQ1G9iY+upsnbWWGhw5a9qc60ewk
 7leg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqtwvPpsDCZ+ekrJT2e9VVrnzo9HntIc5I8qic4BdmfxjlKxVuNb5g35P2tWt6C/FeeI8YfsDLwNU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxtyxsu/uDqvT3eJsP0yDZXIwB4DTJu6uGXdbqOk8lXQoC73ZWV
 oogSQ8o3coTjCoDbU7rO/A1mSYhP9AyCGIl/2/kWjcR8MXM9dCzHG3GQRkehxMrPQ4M+TUOCNr0
 mp8Es1IgmppUL7LoVrpaTRwX4LvIrsC58kbO35qSHHmnWMcE8mdSs3Ea4LtJyUYpsCAYRO3M=
X-Gm-Gg: AeBDieuNOKKMjV/k7IZH+oInDupzr34GEoNHb5r1quj6zGNevT0BmBUNY+dAI2su6xX
 3ThmLK1Dncpr0nFkdIy7qLExQvhsPxWz0dZzEWUqrDNjmmVzlG7kS2cpGjnsQD37LpPiBibuphF
 jGnuJVPX9HrnCmop+GZTtA79/Vf9JKIDU9EdqLo+ICo7NW0D5OtA2mOq9CxY7x3JeJp7ckfwzjz
 FDJxXTQ/MnyMa6WW1aSWGx3AIkolsGlHoli2kRGRw/iiNvXLlfGtPHF2xjdXwR7YnoKKMBcKGpy
 uasJ/ly/XF2efP1M4gIsgpqNZQepP0E/vcG3aWvMLzXCXOsZetPbymxrRhVO7qfmRSF97gbw7tu
 k3nLa57bvAQa8Lp3GcQ5WeEorU6dJHB48CpMSQJ3pMeWhHHDHH0d7WsA5kDf8HYRwe6JHJOsdsc
 JfvplbhUHMpEWQmgi20hhu2CooRMgZS/VqmEk=
X-Received: by 2002:a05:622a:1249:b0:50d:8d63:3899 with SMTP id
 d75a77b69052e-50d8d633997mr117473721cf.14.1775519001128; 
 Mon, 06 Apr 2026 16:43:21 -0700 (PDT)
X-Received: by 2002:a05:622a:1249:b0:50d:8d63:3899 with SMTP id
 d75a77b69052e-50d8d633997mr117473411cf.14.1775519000715; 
 Mon, 06 Apr 2026 16:43:20 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2c6ca3100sm3725118e87.35.2026.04.06.16.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 16:43:18 -0700 (PDT)
Date: Tue, 7 Apr 2026 02:43:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <rob.clark@oss.qualcomm.com>
Cc: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/adreno: fix userspace-triggered crash on a2xx-a4xx
Message-ID: <5boflu67xgvflhrkbmc4gsv7dx3dzke5b324hudnrtt5kzn5wn@74e4t7doa2zg>
References: <20260407-adreno-fix-ubwc-v1-1-bb2b09450b87@oss.qualcomm.com>
 <CACSVV03uVF-STTwCVR3=9Jf=dCh7buBmk-1LBhYO0YfUDYXNDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSVV03uVF-STTwCVR3=9Jf=dCh7buBmk-1LBhYO0YfUDYXNDQ@mail.gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDIzMSBTYWx0ZWRfX65JCaJLC0tMd
 18rlt9BmX81YKhXUfCjCVa4cEF04TVRI6lRkjoXuQUpIlk/+1e6usFo6okjocE4q5b+Mz1dK8O7
 Z6DlhAcFX0hQq0TixOC9mRQvYFjKsMeFTnCnWWpzSGwrT11lsHaiBaMh+MHxNJBdtAuTwOAOebZ
 Xe86fWrpLr7C22Yjau3CHh9G/DJWMXEb2/kcdOYAz40D/WHmBOjper/j2atwiF19AnPSHHg5GH9
 Au37wJURLPWXif+iJsuRAGN8lk//YNz1OS7hM1LyA7uFB0Q1vXEOa7aNQwwefwHtjiTyPsem+ON
 1n+UO03VmHyn4DoUB0j9avXjXUTH7M5BDWEtxnAX7qdc1IbACyW1efkak+9gcwpwg/hcjjCtavZ
 +I0XqLplAcxAecmVKRqhMCwae0S8M8bHqRwuzWx0YaEpqdHDa2haIwxf+BTJiJ6lpIjyJl1rRma
 /Brogd183syZKMmr/vg==
X-Proofpoint-ORIG-GUID: fSoueQ26EXLsFWV_CUGVabUk95FsNAg3
X-Proofpoint-GUID: fSoueQ26EXLsFWV_CUGVabUk95FsNAg3
X-Authority-Analysis: v=2.4 cv=DcInbPtW c=1 sm=1 tr=0 ts=69d44519 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=aIc0x1t0BmEQyzKU2LkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_05,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 phishscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604060231
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

On Mon, Apr 06, 2026 at 03:24:43PM -0700, Rob Clark wrote:
> On Mon, Apr 6, 2026 at 3:14 PM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >
> > Before a5xx Adreno driver will not try fetching UBWC params (because
> > those generations didn't support UBWC anyway), however it's still
> > possible to query UBWC-related params from the userspace, triggering
> > possible NULL pointer dereference. Check for UBWC config in
> > adreno_get_param() and return sane defaults if there is none.
> >
> > Fixes: a452510aad53 ("drm/msm/adreno: Switch to the common UBWC config struct")
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > index d5fe6f6f0dec..7dc95c0a17f7 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > @@ -426,16 +426,25 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
> >                 *value = vm->mm_range;
> >                 return 0;
> >         case MSM_PARAM_HIGHEST_BANK_BIT:
> > -               *value = adreno_gpu->ubwc_config->highest_bank_bit;
> > +               if (!adreno_gpu->ubwc_config)
> > +                       *value = 13;
> > +               else
> > +                       *value = adreno_gpu->ubwc_config->highest_bank_bit;
> 
> These three params are only used by userspace on a6xx, so tbh it would
> be ok to return -ENOENT for platforms that have no ubwc config.  That
> might be better than returning imaginary values.

I'd say, those are defaults. But I agree, -ENOENT might be better.

> 
> BR,
> -R
> 
> >                 return 0;
> >         case MSM_PARAM_RAYTRACING:
> >                 *value = adreno_gpu->has_ray_tracing;
> >                 return 0;
> >         case MSM_PARAM_UBWC_SWIZZLE:
> > -               *value = adreno_gpu->ubwc_config->ubwc_swizzle;
> > +               if (!adreno_gpu->ubwc_config)
> > +                       *value = 0;
> > +               else
> > +                       *value = adreno_gpu->ubwc_config->ubwc_swizzle;
> >                 return 0;
> >         case MSM_PARAM_MACROTILE_MODE:
> > -               *value = adreno_gpu->ubwc_config->macrotile_mode;
> > +               if (!adreno_gpu->ubwc_config)
> > +                       *value = 0;
> > +               else
> > +                       *value = adreno_gpu->ubwc_config->macrotile_mode;
> >                 return 0;
> >         case MSM_PARAM_UCHE_TRAP_BASE:
> >                 *value = adreno_gpu->uche_trap_base;
> >
> > ---
> > base-commit: 36ece9697e89016181e5ae87510e40fb31d86f2b
> > change-id: 20260407-adreno-fix-ubwc-6a2564710e21
> >
> > Best regards,
> > --
> > With best wishes
> > Dmitry
> >

-- 
With best wishes
Dmitry
