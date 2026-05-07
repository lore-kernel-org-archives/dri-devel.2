Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB08CD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 14:05:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E997310F16E;
	Thu,  7 May 2026 14:05:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="i0/AVF2H";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JUlcwX4o";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1597D10E08C
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 14:05:33 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647BUngs3924293
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 14:05:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +BC6FDv/KCnHxFRu2JFlqNIRoVxvZm/nujJQr/xP2ew=; b=i0/AVF2HZDo/BLCb
 WvTrxhYA/bVoEZuS4GZc+d3L8vOAe+VW1AYGfT5VqQ/4dzbA7/BHCAUjM3Draws5
 nXR2cPrSskwlYT/6Bl8SflTbYzKpdblgCQ4EzeV2AVMbFk4Nw+SsHjxnjPqs1cnT
 81Y+5E6tvM1nv2c9CdbtUFVNss0W4Ev/7WItpilLA7O60BU0cs+HUu46R4Y2qMS/
 gXd1v6CphbUbeolHiUZeGbN+3R+kkMu9WhylTuSg9DgTrMorCBFbqjGc/EDyLoZg
 wfS3WeJJsgHDDew3ILgRQZ89oEr/DHkgKo0gdTvjw4fiOkbRSOdeLYyjDob+ikV0
 xu7rKQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0c88be2y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 14:05:32 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3663d5e9bf4so65232a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 07:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778162731; x=1778767531;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+BC6FDv/KCnHxFRu2JFlqNIRoVxvZm/nujJQr/xP2ew=;
 b=JUlcwX4oC5LAeLW8ARLyxyRb3KgMs8UB2i/TpHhqTnQ+LZyqW8bnefmNFPcV4kknTg
 IHNstPk7YKkzsCq9fVYDc8hGxjT6T62VRSPYAQY/ZCYnnVBHd6NLcDM09TP6FCIusnCm
 +oIgRA+eXnYU88f1QriNqJQry50wEZQjztkd2bNCKNJyHMR2QiW67MeYUi9MQebsyv4U
 2MdM/xXWaNLPyfNix8XTnB8BMl9AI1ymSMruTtAJywVc9A0NusTKiCC/3KrwG054H9I1
 Fu9CSwXv3d3AVUP0dZ8cr5JBMS0y5nJuHpA0GSaHzz8ttn11iBMtVpgkJ3+y9i3BTO76
 6M9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778162731; x=1778767531;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+BC6FDv/KCnHxFRu2JFlqNIRoVxvZm/nujJQr/xP2ew=;
 b=fqQeEyVW7T1lSuigQ3YRmQcGuzXFEcEaKewhG7lwzmzBgZRYgbdtrdU2l/fb0O4Gnr
 LCRNmm1pyuBNESuNh9vrZ1EY4XSECcoiAahEVI6do1GPjid/iGkXwdZN7+7KvtZ6dp54
 c3A5+u1PoLJK5iAOgip0EAyB5R3DFwsqdgImzxeU42VjanetBdhb4XGJAewZErV/7QpL
 YO1p/u31hrg18e1Wwo3dMSEe0lrzm2wcaGbaABHk0/0a4xlIKmyTrXjor5p+o1UGh9aK
 uLeI+yk/cv14qt+cQlGAo171yVBwMrhan+7oCsGg6W8hAJialr7/vpFEBv/yVRjYY39z
 dXrw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9FvFP809nxgL8LaZ8lorczhvz1CfaAmkyPPNXz6y+Y2Uk8Eez5bZBMFZnwAHWrMrnthhi0lnAdFNo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxWyXIaxKavRMQGec8bnrTG6sI9EluUntFFyq91zXxyGhsMBgqt
 C0d0qG9rLS9HAXtvDbCd1FHK+IPwRV3PyxsRUk8mRY/KcSV28F5ZKP7J7bWluv/r23ddKaOOK11
 g6ckO8kJ0LrqAZURtY3anjYpnt7x0HaoTAo70DBeqUjWN3pD4tCHqetffNFGOlU/1ZvmR7fo=
X-Gm-Gg: AeBDietNSJ1UdqqaLcgbW+4elpMSvM5P23tIdDShEwq+nxMfJulKsHSNZiavKmTXPwT
 hkzy6+S2JbDtRtVsAf++DtHy8FewFRBIUN3w5pqDfQL3x5fNQJrrPqgih8aftKrkrqQZWJGYI3f
 Vq3BiGVIhNErkp+aQoWfuvVy2FYiOCVbdnhmLJlvR87VGlnpL4rLsniTb/yg4b/qeHX0unDm9w6
 FKVz7rF/uCm+eMFoBK+EAZH8kYs98/s7l0xXDANGkb6mTEXMjKDgM3/2W5h7I/WO0axDE+DW4hM
 AEh+YVlD9xgpcWMm3NZeHMMKo7KirsQeaKAflDtQ8+In2VLN0v9F+f/mzML1b6/Kggo/b8mtpcc
 nNNK1xJqHVHovs7qIVyu713f+tAzkWMhNF3K1aQfdGbRW7JIdy/u5hmA=
X-Received: by 2002:a17:90b:2f4e:b0:35d:a0b7:9608 with SMTP id
 98e67ed59e1d1-365abadd261mr7941375a91.7.1778162731060; 
 Thu, 07 May 2026 07:05:31 -0700 (PDT)
X-Received: by 2002:a17:90b:2f4e:b0:35d:a0b7:9608 with SMTP id
 98e67ed59e1d1-365abadd261mr7941240a91.7.1778162729807; 
 Thu, 07 May 2026 07:05:29 -0700 (PDT)
Received: from [10.206.103.12] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-365b4bd8debsm6158400a91.2.2026.05.07.07.05.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 07:05:29 -0700 (PDT)
Message-ID: <09031221-51cd-4a6e-b87e-f2d8290f8ac2@oss.qualcomm.com>
Date: Thu, 7 May 2026 19:35:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/29] drm/msm/adreno: use qcom_ubwc_version_tag()
 helper
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
 <20260507-ubwc-rework-v4-6-c19593d20c1d@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260507-ubwc-rework-v4-6-c19593d20c1d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: _zel0nKmIrUgZwgLWxN_7UcPQti71f6s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE0MCBTYWx0ZWRfX+4ZrBxB7ZYMU
 AibpUIG1D4XhuKeTIyD0TzZ/EAbC5WWzec1jcq/S3TVWhnuXeUqxMEPl1b7xJrqnBCX6cEnqfx4
 A4kwxjT6QlGyky6GMNkLtKtsKq2rkfZpSusiesrKHxMOvcXj/fCTii109fDD6zE5lrQxD5IcpWZ
 wSdvWkMA9zymN3dQ+UmV2TQV8yc+YW7hdcnQCX0cgsIkrf1L0/owBX6HsIPiWrjOmwNzRYIhLd9
 UVcu5uJd71+N79ieG+6A/x+bhHeah6GR+BAs6bWj1z6N4mOoYm3Psd2yfC2myzRfRzcR2PkLO/M
 nwEfG6GacK3svsgv9tHynfInRQSCcVXio6KTBB8h1d8iGx2nevDFmHuvhvDt6b0vagisRUDKl8A
 EA6f45U4U1nN2wtUeUwzuukYCIUNsV3mlyR60N+Jk2wiaPjxB/m3vqSiRFm046KzW9arq+n0Ni6
 gQzPxltVAWxWz8HB5Lg==
X-Proofpoint-GUID: _zel0nKmIrUgZwgLWxN_7UcPQti71f6s
X-Authority-Analysis: v=2.4 cv=X8Zi7mTe c=1 sm=1 tr=0 ts=69fc9c2c cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=GMbUkbxl-BqPewUEXpgA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070140
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
> Use new helper defined to program UBWC version to the hardware.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil

> ---
>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> index ccfccc45133f..1923f904d37d 100644
> --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> @@ -282,35 +282,33 @@ static void a8xx_set_ubwc_config(struct msm_gpu *gpu)
>  	bool rgb565_predicator = false, amsbc = false;
>  	bool ubwc_mode = qcom_ubwc_get_ubwc_mode(cfg);
>  	u32 ubwc_version = cfg->ubwc_enc_version;
> -	u32 hbb, hbb_hi, hbb_lo, mode = 1;
> +	u32 hbb, hbb_hi, hbb_lo, mode;
>  	u8 uavflagprd_inv = 2;
>  
>  	switch (ubwc_version) {
>  	case UBWC_6_0:
>  		yuvnotcomptofc = true;
> -		mode = 5;
>  		break;
>  	case UBWC_5_0:
>  		amsbc = true;
>  		rgb565_predicator = true;
> -		mode = 4;
>  		break;
>  	case UBWC_4_0:
>  		amsbc = true;
>  		rgb565_predicator = true;
>  		fp16compoptdis = true;
>  		rgba8888_lossless = true;
> -		mode = 2;
>  		break;
>  	case UBWC_3_0:
>  		amsbc = true;
> -		mode = 1;
>  		break;
>  	default:
>  		dev_err(&gpu->pdev->dev, "Unknown UBWC version: 0x%x\n", ubwc_version);
>  		break;
>  	}
>  
> +	mode = qcom_ubwc_version_tag(cfg);
> +
>  	/*
>  	 * We subtract 13 from the highest bank bit (13 is the minimum value
>  	 * allowed by hw) and write the lowest two bits of the remaining value
> 

