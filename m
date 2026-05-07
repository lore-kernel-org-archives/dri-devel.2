Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68FD3CD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 14:05:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9674C10F173;
	Thu,  7 May 2026 14:05:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cygh2Qjy";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ENPDb54J";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1171810E24F
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 14:05:03 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6479mKGJ026622
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 14:05:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZShhxOovjzceMtLMUQYhBHlHiz8slZH+0gurq0OqEk8=; b=Cygh2QjygimB4lDY
 nDu4g6wftBDfD9lv7BDk1JZY62SDV7nliBAd/T5r8OoomfwlTJN6dsI7XmC3CYNb
 BVoEb4uVgW+5w+Cn9EpxiMrBItZvwJ5YY7vzIo1lTCPeoQv9IYxglZNK33Zv7XzP
 0fXxI2cqL7IdxrFuleUUGGijY/pBXDFdXhIq3I+0VBuu0udSz7hNGjsXECtqUtam
 g5fh4+UXLG7tb5zpdBMukRTgchYcNoyZ9HuBIMSgYteu7WhQS9bSG7m0CGH0JYhS
 2KL0ZWhEGf9KCGTSNFyxyMQPoWeuces5Z4tVvTfqT4O/w9wTkr0R58ETBjTOcB8M
 DtpLNA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0k1t27uw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 14:05:01 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2adef9d486bso9523965ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 07:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778162701; x=1778767501;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZShhxOovjzceMtLMUQYhBHlHiz8slZH+0gurq0OqEk8=;
 b=ENPDb54JCxZlqxHwafCueWZaURqyv2cr0b5lC8vr9lBNfx9jpRUJUQ44+hND0xzYR8
 hFCFVaI8JBH35lSdHu+EkfqTWWsoswyN9QQihm95hEPZPq60eZEb0jC0oGvzymRjm6xs
 e7qaTcO8DeZ5SzssRnLY+96tVvzkE/WEBIx6N89Z2o+hpLBtcJLm4Akxtu2PRWvwWsZM
 V2ndOWedn3/n5oEN/PjCEsmUbEM0CPTN2v69qfYTW0hu91qENVXMCWduAGHY2eRW2DbT
 oadwtGxpy6F9EwqJ/TRzBuIP4JOLtO36R70XFz0Q5q4MPAQ7XRs3l4xH631ENnd6avs1
 LoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778162701; x=1778767501;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZShhxOovjzceMtLMUQYhBHlHiz8slZH+0gurq0OqEk8=;
 b=jsYnWoAIJSViyCREaJhM3hT7qBbWihAbGxxzEIF4+YG0ur+6CWqGwhH/EsTLWE2lJo
 x7XD59d2Nr+CvvKCHQszdDlFFZjw/ihdQWOSWpN48JIjvhBSh38fl92F9PzAIqPFu2fJ
 i7HE2kSaiGXBhcgjXghgDdVV9X4T1hfB18PCCYKmdDwpR7LZsekYspWFltgc7Lt8ZJMS
 K4y7vN0/S7sSl+WpXl5r01eGw+6tCSmM4vWUGM+lORIMKZv/nnwSZir+6kjloFk7sClq
 wDwab+N66nDL8q6f6U7Yzb440p2R4Ou9JxWJlSK9SWLB/c1GI0F705wrgAAO5XjFC3m6
 YPrQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9FRbA3YfaAl2ZTfhpBZavmhIlhTj8j6CJsjwAkrwSGcFcp15hdNj6wVqIEMzHx6IlTAR1UppN7i/4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxN0ntUAp4e91JTA5LRVOKRzmA5nUvVbV7AYW+AXMv79SW/YOx8
 7iXF0dEasy1jtRk9lDrQWexLnF29hhn/E3ozm1Oq48ihMXoWCinmeNV5GjP4pgqCH/EbyxR2olO
 3TWuJRlTtaIyZ35cGX+SnReZ1M0uk5TtvsZBzkHunC7DxMoTitbB8cYIFw7TTFynWOFB6V3A=
X-Gm-Gg: AeBDieuYFPUCe+CzipyXKJecRp8xzo8+xUvNRCjnQkb17Ckx8fuxvrWYUrZkbalLq85
 w7coeuq3LvTJ5D1A/vvWbKTgn654pGICo9/0UTsOkrQeEPnsXVEWqfrXyaDFH5l7PiIEZTZ8jZx
 I8TyWjFMW5gOF8LymiztRb2AgTyQ7z+zSo4BTJmSAkOQhJWGYaWohi/84AkFo6AtNnp/PgL0juC
 1d+xWWTGFCflY1cffNc4+WDAhw4Gya1jso0dMX51rVSULqs/spxi1pG/sOE4ldfFpxUbzWikI/y
 JPTyxBkuUZX8UkQ0/ZNFsFJrWSrwQ4g/JdjHad0nrFAnBKqLYtRwM/x5iBhJo1Y4C9hUwa1x+dC
 ioCVfa/ClGTzdF03Y/7N5UErnYRNgVv6OCkzXLfdTs86+YTnZxZTXTv9auTE0xAKxhA==
X-Received: by 2002:a17:903:13ce:b0:2b9:fc68:d8bc with SMTP id
 d9443c01a7336-2ba7881ba37mr86118555ad.0.1778162700717; 
 Thu, 07 May 2026 07:05:00 -0700 (PDT)
X-Received: by 2002:a17:903:13ce:b0:2b9:fc68:d8bc with SMTP id
 d9443c01a7336-2ba7881ba37mr86117695ad.0.1778162699928; 
 Thu, 07 May 2026 07:04:59 -0700 (PDT)
Received: from [10.206.103.12] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2babadd281bsm29136815ad.43.2026.05.07.07.04.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 07:04:59 -0700 (PDT)
Message-ID: <42d3395e-00d7-454b-bd8d-0a7b70a64887@oss.qualcomm.com>
Date: Thu, 7 May 2026 19:34:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/29] drm/msm/adreno: Trust the SSoT UBWC config
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
 <20260507-ubwc-rework-v4-5-c19593d20c1d@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260507-ubwc-rework-v4-5-c19593d20c1d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EoPiaycA c=1 sm=1 tr=0 ts=69fc9c0d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=rXB18VZcS01e0qBHpfIA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: GJK3JAhdpxv9uR3HBaIrnvkZYp3_TMjh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE0MCBTYWx0ZWRfX77HcMUoTC5I9
 J4+A3AGqzREHqBxKQC8urMaNZ0O/Rx3WOs2YiP9wQSPtj16X0W0Bks5RTCc0ECsB2rdkgFHN918
 VrOBoCX/G8Te+/GVORx33qweTNYbyz2sbHTMHus5EMpRxWoakG67udwxLyxbAf3vhQQ0H2y20bM
 gtjGkWFL/kXMleAAVVE1nzYl9IMVrKI0fmoEI4dQbU7tLZ3815Tk+3wRhrKnLAry869l6AeAfDu
 C/tmWVNkwj7IVZIUma8zDlfM3g8CZoRnUrkD2XEdQywZPI0tWZRkMdtRhue2cz4HYc6V791gNG2
 8eQbH0Fl2XrEzW6yhPcEPfH9lYzb9MPHKWCgETPpxFpdpe2fHu7QB3a+/VBa7onV/htB7DEW7oK
 SbTiOSzEzgrJVOMc3+hia06clarp6edCEN+kueERbeyhGE17qDi/6/t2vKJpihFXJDafO9w7GdS
 UNW7Vyy6Qd5PssJslBQ==
X-Proofpoint-GUID: GJK3JAhdpxv9uR3HBaIrnvkZYp3_TMjh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 adultscore=0
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
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Now that the highest_bank_bit value is retrieved from the running
> system and the global config has been part of the tree for a couple
> of releases, there is no reason to keep any hardcoded values inside
> the GPU driver.
> 
> Get rid of them.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Rob Clark <robin.clark@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil.

> ---
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c   | 11 ++---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 82 ++-------------------------------
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h |  5 --
>  3 files changed, 6 insertions(+), 92 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> index 79acae11154a..699fc0f551ed 100644
> --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> @@ -1725,7 +1725,6 @@ static struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
>  	struct msm_drm_private *priv = dev->dev_private;
>  	struct platform_device *pdev = priv->gpu_pdev;
>  	struct adreno_platform_config *config = pdev->dev.platform_data;
> -	const struct qcom_ubwc_cfg_data *common_cfg;
>  	struct a5xx_gpu *a5xx_gpu = NULL;
>  	struct adreno_gpu *adreno_gpu;
>  	struct msm_gpu *gpu;
> @@ -1769,13 +1768,9 @@ static struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
>  	a5xx_preempt_init(gpu);
>  
>  	/* Inherit the common config and make some necessary fixups */
> -	common_cfg = qcom_ubwc_config_get_data();
> -	if (IS_ERR(common_cfg))
> -		return ERR_CAST(common_cfg);
> -
> -	/* Copy the data into the internal struct to drop the const qualifier (temporarily) */
> -	adreno_gpu->_ubwc_config = *common_cfg;
> -	adreno_gpu->ubwc_config = &adreno_gpu->_ubwc_config;
> +	adreno_gpu->ubwc_config = qcom_ubwc_config_get_data();
> +	if (IS_ERR(adreno_gpu->ubwc_config))
> +		return ERR_CAST(adreno_gpu->ubwc_config);
>  
>  	adreno_gpu->uche_trap_base = 0x0001ffffffff0000ull;
>  
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index d5aba072f44c..1d998636c5a3 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -733,82 +733,6 @@ static void a6xx_set_cp_protect(struct msm_gpu *gpu)
>  	gpu_write(gpu, REG_A6XX_CP_PROTECT(protect->count_max - 1), protect->regs[i]);
>  }
>  
> -static int a6xx_calc_ubwc_config(struct adreno_gpu *gpu)
> -{
> -	const struct qcom_ubwc_cfg_data *common_cfg;
> -	struct qcom_ubwc_cfg_data *cfg = &gpu->_ubwc_config;
> -
> -	/* Inherit the common config and make some necessary fixups */
> -	common_cfg = qcom_ubwc_config_get_data();
> -	if (IS_ERR(common_cfg))
> -		return PTR_ERR(common_cfg);
> -
> -	/* Copy the data into the internal struct to drop the const qualifier (temporarily) */
> -	*cfg = *common_cfg;
> -
> -	/* Use common config as is for A8x */
> -	if (!adreno_is_a8xx(gpu)) {
> -		cfg->ubwc_swizzle = 0x6;
> -		cfg->highest_bank_bit = 15;
> -	}
> -
> -	if (adreno_is_a610(gpu)) {
> -		cfg->highest_bank_bit = 13;
> -		cfg->ubwc_swizzle = 0x7;
> -	}
> -
> -	if (adreno_is_a612(gpu))
> -		cfg->highest_bank_bit = 14;
> -
> -	if (adreno_is_a618(gpu))
> -		cfg->highest_bank_bit = 14;
> -
> -	if (adreno_is_a619(gpu))
> -		/* TODO: Should be 14 but causes corruption at e.g. 1920x1200 on DP */
> -		cfg->highest_bank_bit = 13;
> -
> -	if (adreno_is_a619_holi(gpu))
> -		cfg->highest_bank_bit = 13;
> -
> -	if (adreno_is_a621(gpu))
> -		cfg->highest_bank_bit = 13;
> -
> -	if (adreno_is_a623(gpu))
> -		cfg->highest_bank_bit = 16;
> -
> -	if (adreno_is_a650(gpu) ||
> -	    adreno_is_a660(gpu) ||
> -	    adreno_is_a690(gpu) ||
> -	    adreno_is_a730(gpu) ||
> -	    adreno_is_a740_family(gpu)) {
> -		/* TODO: get ddr type from bootloader and use 15 for LPDDR4 */
> -		cfg->highest_bank_bit = 16;
> -	}
> -
> -	if (adreno_is_a663(gpu)) {
> -		cfg->highest_bank_bit = 13;
> -		cfg->ubwc_swizzle = 0x4;
> -	}
> -
> -	if (adreno_is_7c3(gpu))
> -		cfg->highest_bank_bit = 14;
> -
> -	if (adreno_is_a702(gpu))
> -		cfg->highest_bank_bit = 14;
> -
> -	if (cfg->highest_bank_bit != common_cfg->highest_bank_bit)
> -		DRM_WARN_ONCE("Inconclusive highest_bank_bit value: %u (GPU) vs %u (UBWC_CFG)\n",
> -			      cfg->highest_bank_bit, common_cfg->highest_bank_bit);
> -
> -	if (cfg->ubwc_swizzle != common_cfg->ubwc_swizzle)
> -		DRM_WARN_ONCE("Inconclusive ubwc_swizzle value: %u (GPU) vs %u (UBWC_CFG)\n",
> -			      cfg->ubwc_swizzle, common_cfg->ubwc_swizzle);
> -
> -	gpu->ubwc_config = &gpu->_ubwc_config;
> -
> -	return 0;
> -}
> -
>  static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
>  {
>  	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> @@ -2701,10 +2625,10 @@ static struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
>  	msm_mmu_set_fault_handler(to_msm_vm(gpu->vm)->mmu, gpu,
>  				  adreno_gpu->funcs->mmu_fault_handler);
>  
> -	ret = a6xx_calc_ubwc_config(adreno_gpu);
> -	if (ret) {
> +	adreno_gpu->ubwc_config = qcom_ubwc_config_get_data();
> +	if (IS_ERR(adreno_gpu->ubwc_config)) {
>  		a6xx_destroy(&(a6xx_gpu->base.base));
> -		return ERR_PTR(ret);
> +		return ERR_CAST(adreno_gpu->ubwc_config);
>  	}
>  
>  	/* Set up the preemption specific bits and pieces for each ringbuffer */
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> index ec643b84646b..324319762383 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> @@ -236,12 +236,7 @@ struct adreno_gpu {
>  	/* firmware: */
>  	const struct firmware *fw[ADRENO_FW_MAX];
>  
> -	/*
> -	 * The migration to the central UBWC config db is still in flight - keep
> -	 * a copy containing some local fixups until that's done.
> -	 */
>  	const struct qcom_ubwc_cfg_data *ubwc_config;
> -	struct qcom_ubwc_cfg_data _ubwc_config;
>  
>  	/*
>  	 * Register offsets are different between some GPUs.
> 

