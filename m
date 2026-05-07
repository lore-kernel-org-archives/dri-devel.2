Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE14ACD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 13:59:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3946210F14B;
	Thu,  7 May 2026 13:59:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eeezDhzx";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ThBobuDT";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C3B910F14B
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 13:59:11 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6477pfs91424581
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 13:59:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZwAYWEgtEY3+koYnss2p7DKsYyhBNH1k8tWzi8XpcvU=; b=eeezDhzxPCC+kbIu
 zUGle5mgfatlTdB0rpP4hOI7AJNGooOuWohtcvLelycpfI8eZ3PeaquPZPHec9k2
 CRakWoFVa2DAhVxvVIjQ/Z3qe/j6mSp8G8zitVtQ0pj5v+S9Cw2u0PrKit0OMVTb
 ErV5iCZV8aLWRcmwpXA0Urq3uEaTsl6ASKa4Tr50gxITJS4Odb/4huRSiuRPaaNu
 hId9wOGB7ijlfMIIgOj62xV5ie2lp4OMo+WS1cWbR2P6PHNdpIAgUupdvBpo7uoo
 MvMUGioYXuAnRXTTuPQUDsHTscdAAMFfBI91dowXIS2gemLJejWNNU/NgaRh8ejD
 SG6Hrg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0pqfsbsr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 13:59:10 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-36615b95e7aso588700a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 06:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778162349; x=1778767149;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZwAYWEgtEY3+koYnss2p7DKsYyhBNH1k8tWzi8XpcvU=;
 b=ThBobuDTZ1zY6sv2IdAku9T7MFaMD9Tm7FhDqwMNjYP1g0XK8Jr+PR4qkeTH0sO15O
 JsM496f2n1ypUQt51nQKD6+YP05WYram6xWBCv+rDp9KtDXEPV8aNZBgI1sKGUnb5vob
 B0rCkb7s8yBc11tN562g5OE+Cnrr5c11q17Zr/cBnvD2ZjeAxqTLv7dFiVje4u2zrUzv
 6LY8LvrQy2f2fcqKUqTZY77FhJvlJpZycxxKy5zjI+6AiibJFTV36F3bZL3MM+nhcDnN
 D7ir5yRExmg+Km5L0z8SnvnlFxxG05odzeX5n42yKhJspqCYM2INPAA69rrx1WTObJG3
 vgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778162349; x=1778767149;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZwAYWEgtEY3+koYnss2p7DKsYyhBNH1k8tWzi8XpcvU=;
 b=E9l//WZNAdZmVVuu7OJlqoMLNr6I8tvcHGlkPOhPE6Hpu7Ihg1eRv8N+JxS7tRyADS
 f20/zO/LYAZKO+INeBU9C0BSGRXEE3YmphIuwjAZJwNDbQFeyAGR7exdHM2Q97pcM83S
 6qX5+vzuRWD4oqszsK1wjzIiHFupv0ARDGPDIRHMFr6ekunLUZZuaH7zIgNizQNKq8Lx
 Nk3HaLjNKjTFjRocwJ6HZPHn/RN3SgQ4kaxDvthqZSnUl3MGNq8Yl4GiSEU8YXCn3mAP
 uaBWIaQmJy4O5LvqGAGKi3MfvYVtCnFT9Z/JrDKpi/ydV5IH36ngVLP7eYkDsX5SiET4
 iexw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+A4c5dj7srBHD+YgoTJ17toDJaEK9DgrK1bb/sxVh8zds10gFtfh1Vc5c35tJTEtpGt/XGPE5BvJc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxm1H6S7Dv0X2ISVWMRBKTrZakslzCqdNETLQYJYOwhk1rVe6t3
 i2pvnM4/IIXBlxKpypd4kR35/z3SumdKwJ91wDEVSjPzxejRDVghNP/TfPoEjLyyGwESveugwX7
 NXauYWGx4wn4UPKmiOo2lmLieFb0ZIdhFsklVi689G+nnPA+MQutWzi7DM5GNYg39W8th0LE=
X-Gm-Gg: AeBDiet6PVOUN/G0oR+/NChywLnYRXeFj15T1Z5XG3K9FgNTT4Byk7WDpHFHSqyp+8b
 Se0LAT3ZBKLjrIIaes/ypEJL8wBpNPh1B4WxZz2/kKfcbwsqrqW+pJGHkLCeapfPsXKADftsxYM
 a+vToJuH7aft90mLGMZDT/jveDOs87K9mS65v4fDIA7eQeJVe6c9XDssIk4DLB8giLsjqiaVLUB
 93aP4l3rzgiFoHef9Iw1CxrQ9vcCVyt+R1HaUNAoYgFfWZGdB2ls7u0fR6iusNNllaGOjJaKizp
 Ta9bBlwSfjPij0u3mf2Q0IG9Fe2WDTmpZIYSG7+aJs82TsflHA+tBmEdzAO4LedkDyKVQZiWVpc
 cpU/FT3kbXSYCo5CD/o+VJRZbJDYisArDKUcnSYF8tHRhkKLk6VJdzOM=
X-Received: by 2002:a17:90b:134d:b0:362:bb93:f25e with SMTP id
 98e67ed59e1d1-365ac775af2mr8898394a91.23.1778162349163; 
 Thu, 07 May 2026 06:59:09 -0700 (PDT)
X-Received: by 2002:a17:90b:134d:b0:362:bb93:f25e with SMTP id
 98e67ed59e1d1-365ac775af2mr8898363a91.23.1778162348682; 
 Thu, 07 May 2026 06:59:08 -0700 (PDT)
Received: from [10.206.103.12] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-365b0160dc4sm4827436a91.0.2026.05.07.06.59.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 06:59:08 -0700 (PDT)
Message-ID: <961d582a-d65a-417f-b777-01360b30ca86@oss.qualcomm.com>
Date: Thu, 7 May 2026 19:29:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/29] drm/msm/adreno: use new helper to set
 macrotile_mode
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260507-ubwc-rework-v4-0-c19593d20c1d@oss.qualcomm.com>
 <20260507-ubwc-rework-v4-10-c19593d20c1d@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260507-ubwc-rework-v4-10-c19593d20c1d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TJB1jVla c=1 sm=1 tr=0 ts=69fc9aae cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=xedk9TFi4NFs6gOXDsYA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEzOSBTYWx0ZWRfX+KFMzF74+bVC
 AkcALw2HU+njR/zK4UT+jLnd/BtWokIGm9ksrc+dKhWTswyBM6kiGzxk3iPo7w9w9mtXfdUINwK
 javLDyGbRiS2uCvercUOefmk/Nw5qT/F9d2re+A/jLvan9k82dcUKXMWQJ12Gph0fnUHQ1ZMas6
 RaXKUw4awkEZtRnY+sakHX49niFFYd2UDNrdwhjOl1To+JTkNbhdNykkvayyHv1nMSkfh6AosLR
 GhuW7UCsD90q/cHTflX1FxiVJ/jhRppXGbZ8d/82WwBy3xnSaPlMe2XLqUHrxE7F1M3CeZWoX6b
 WupAKJIRAyTyKLx8dT31yBXJQhvcvzNLxZnxAxAWYl1n1eVBfVcFhFUtNinLsPlXF88ec2CyVWA
 ATXbXL9pMnIZSDH6XG87///g8N1XtA9DW0h6lK3oNHC5J05IHOS110ZxN5zesymx4VI0rsHgayF
 K8Zkt1Cnf3NhWp25vhQ==
X-Proofpoint-GUID: M7df-5CG1AEtTNQVFdyVujAHdpW1Jsyw
X-Proofpoint-ORIG-GUID: M7df-5CG1AEtTNQVFdyVujAHdpW1Jsyw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070139
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

On 5/7/2026 6:33 PM, Dmitry Baryshkov wrote:
> Use freshly defined helper instead of using the raw value from the
> database.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 2 +-
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 812bb95e8011..76c681614416 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -791,7 +791,7 @@ static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
>  		  min_acc_len_64b << 23 | hbb_lo << 21);
>  
>  	gpu_write(gpu, REG_A6XX_RBBM_NC_MODE_CNTL,
> -		  cfg->macrotile_mode);
> +		  qcom_ubwc_macrotile_mode(cfg));
>  }
>  
>  static void a7xx_patch_pwrup_reglist(struct msm_gpu *gpu)
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index 66f80f2d12f9..bf1572156b0b 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -433,7 +433,7 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
>  		*value = adreno_gpu->ubwc_config->ubwc_swizzle;
>  		return 0;
>  	case MSM_PARAM_MACROTILE_MODE:
> -		*value = adreno_gpu->ubwc_config->macrotile_mode;
> +		*value = qcom_ubwc_macrotile_mode(adreno_gpu->ubwc_config);
>  		return 0;
>  	case MSM_PARAM_UCHE_TRAP_BASE:
>  		*value = adreno_gpu->uche_trap_base;
> 

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil.
