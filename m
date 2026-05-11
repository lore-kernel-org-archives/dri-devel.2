Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302C7CD37BE
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 20:58:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55FFC10E1F1;
	Mon, 11 May 2026 20:58:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="V1u1rJGz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c4abtUUK";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFEBC10E20D
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 20:58:44 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK6TnR2202230
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 20:58:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9/p9ARwLXTJwRe2U4yqJFSD8BOX1Dr2lRgTY9kR08Xw=; b=V1u1rJGzXkpOMKlD
 cOfPNOc3SI+WgeiL6w8LZEK88483Jj6Y436ZC2KgVgtRP5eSCGuYYYa4hCRNot++
 a7Dn38LfNGYNHcm6ceOch8+oALHmCil0JIcW/FYUrnFtdobxMhLbI9eB4N/u0Z+t
 BRMKglshERHgMZXlJrBsCSd4wzu92v1T2CwGpOpVPpsUi1tPNBhrpj1E+14NG8wt
 enlitUK9Ni8A0Lj7HdLxEkBlchsv6LUV0w07uWySIACTJfLreQABjhN9EuBIeoZj
 Q56/sIFi7RkgDDM5iVecXvgc8NKWT5BC4bn3I0YbMNPur7eGv9K5tRn5CBC96V+U
 4qwa0Q==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nuyg79p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 20:58:44 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-83cecc22d5fso2077569b3a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778533123; x=1779137923;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9/p9ARwLXTJwRe2U4yqJFSD8BOX1Dr2lRgTY9kR08Xw=;
 b=c4abtUUKNTu057vOxwSEvRiMMMnzX2ZmnunoB/DWJ61RSr7zSArZZH52wixq25/w13
 2Y6Y3sBqaGhxkCg5xVaj+Eog+VILgiClPSPmGjwULyY1eOFttt5qbPBX+AyY2hnJ/kZm
 QlNTdt89Eb8K+sV7evNT57v4aeeggMbOtTbw4IT8azckHU97Acj5XMyjYJh3YAJuEHdb
 sXLaJ8s/Q7WkZysw5Ls4nDLuUKO3T1QBdL2Ou7JbhPX0e0eeNmuh49dPMtilVevGryi2
 /SyekAzCQcpH50UHUp9uwCr6UT8ioqqwvk0J36YWT3yDPIFYwRei0xANW24rVNFA7B3h
 hLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778533123; x=1779137923;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9/p9ARwLXTJwRe2U4yqJFSD8BOX1Dr2lRgTY9kR08Xw=;
 b=UMK9rA57sLk5pF6EQIpzoJiZDAv0vp4FTACvqIB5QhZC4haEd8BPbr51WxtTIZf5No
 P0z4y3UbM0oU/OwjTuLuMcmzN7cgwov3IVdDK7xsNbOr9wKvbPEEbMCVsEEE6+JgYnWq
 NGxQFjpQhkh6M2ggRrEZ/clvLDEIgz5TPKinv0jSlTE7LwrsIm3If8Fujs8dinuvHDOy
 gfKR2AX7QxRtIA6sVszkc9hXd6h/IDWAELhzX/xoodMILE7iWsM99xsrq637DpZ6gN9W
 dCRuxcFBY2wJHAUTFlpqL0vk1KYe7VAgPDCr3qFGDJHgcVmRldk6U3wDFr4EARZ7ema2
 7RVA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ZpdPlGCDFtH7qyTwBMZJz+AChCoGZ7RgWfX8UYp/T1fgPnkgnZ9OKJrQtO/dbp45QsyoAwf6YDUg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy0fyyC2qBwcunEKQHUt/oHBHLSrdjNDlIf7JyU4afNX4ZG2GzE
 g/LawI9gvg2PUqx6uJfcY2hS+ohC7NGeVJrv9n0gjj7TI8XdE47Qgk9j2UxBWX3xSz8dI2Nc8sR
 Ld+v4Z5c/zGIxBTkeYLFyUQ9wvjV3wv4k3LChPkIDkb5pVJfxj3AQKCAGwvQX2Bo68CYSwTt/cS
 HRoFw=
X-Gm-Gg: Acq92OGUGHoXPix2WTvikLPXsshoghCnPtEcw1iRcAZzQapmmQ83HCFmXlRdpMPSJPd
 /39MCbs8ZwsjuoUg3dZ1cugM5NIhQPWoUpqYH7JGKx3htABcwdLGMTZLBYnZ+Re0tHrwvkBVShb
 MJHxoM8xiDFPyuFjDGY8zWngm9wD2XA3QOry+NWK1FxDHCGF2LgBBGpJABfjvOfo7fp0xEI/N56
 F3spzyikpHQHksaxHEt5gyXCg8TjqpHMnKyHh6QDf1s7yuHmcCHCCuiGN3IDYn17xBg7HpTc4tB
 yf6Lt3nGkRecdW0RZrFSrCwWN+tsusMXgiDYZnO9hY/6OP0kphnzfyeNSn2CVg5T2y0niaGrFgG
 L+KmivMOX8DQkh+GtAmepWRej1AlxH3dhfBMiYPvE/10G
X-Received: by 2002:a05:6a00:428a:b0:83d:b11f:7979 with SMTP id
 d2e1a72fcca58-83eebbf4d69mr76931b3a.29.1778533123251; 
 Mon, 11 May 2026 13:58:43 -0700 (PDT)
X-Received: by 2002:a05:6a00:428a:b0:83d:b11f:7979 with SMTP id
 d2e1a72fcca58-83eebbf4d69mr76903b3a.29.1778533122756; 
 Mon, 11 May 2026 13:58:42 -0700 (PDT)
Received: from [192.168.1.3] ([106.222.228.93])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8396563f049sm24664326b3a.7.2026.05.11.13.58.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 13:58:42 -0700 (PDT)
Message-ID: <b0a99bbf-d916-4990-8ef9-2db428192e94@oss.qualcomm.com>
Date: Tue, 12 May 2026 02:28:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] drm/msm/a8xx: Fix RSCC offset
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
References: <20260512-glymur-gpu-dt-v3-0-84232dc21c03@oss.qualcomm.com>
 <20260512-glymur-gpu-dt-v3-1-84232dc21c03@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260512-glymur-gpu-dt-v3-1-84232dc21c03@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDIyMiBTYWx0ZWRfX4u98EZ/3hmvU
 jxKJHMUvz/wv3RFEC+qmp+k1/Oz7fHmE1m3E6p9vL6uXT/RYPkNqOzW3CvIJtaCETjJdLOvtmgS
 DIvWMMC74AUbfTUhxdyEik0f30xTg6VANHcPhuPLTByGIalKlVfBtz1urdo7yRY15AMYNnG3Jlh
 6K3L6CrhisFzyS+oaIC0Cr9KiIBPsYIwbE76Gn0Cy/63DHnZ42tlKah+WxBrqZk8aSLDZE7cJRj
 JFLtJJ/xjcIloK2NKE/fg/9SK+tt9pkjYDeq1QMivdEDrNJe5m2qIES06N4DDNZZb/lc48tnBbd
 D6CLuMLqw0jAvrTUh/4rsu+5wXeg93E5G9+T/4K9l/mlzG4o855PGDsRH4hfoFUst8KCDwiW3Cs
 dkXjn7aramoISDIJUSR1qp685pzMja7zOe0fcy7oexx4kCSBGzYK2SLX40OMFY2R5ta/YOP3V67
 M4FEtnEHhMPNtvLG8wg==
X-Proofpoint-GUID: TVW3B740UvYL2djaTc5AUtEuPKkrfS3T
X-Proofpoint-ORIG-GUID: TVW3B740UvYL2djaTc5AUtEuPKkrfS3T
X-Authority-Analysis: v=2.4 cv=Y5XIdBeN c=1 sm=1 tr=0 ts=6a024304 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=1UGwFfo7D6NxPCeOlddrGg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=-ol3qSTvAihUzIL2rFMA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 adultscore=0 phishscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605110222
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

On 5/12/2026 1:36 AM, Akhil P Oommen wrote:
> In A8xx, the RSCC block is part of GPU's register space. Update the
> virtual base address of rscc to point to the correct address.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

Missed the Fixes tag:

Fixes: 50e8a557d8d3 ("drm/msm/a8xx: Add support for A8x GMU")

-Akhil

> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 1b44b9e21ad8..cab4c46c6cf2 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -2357,7 +2357,12 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
>  			goto err_mmio;
>  		}
>  	} else if (adreno_is_a8xx(adreno_gpu)) {
> -		gmu->rscc = gmu->mmio + 0x19000;
> +		/*
> +		 * On a8xx , RSCC lives at GPU base + 0x50000, which falls
> +		 * inside the GPU's kgsl_3d0_reg_memory range rather than the
> +		 * GMU's.
> +		 */
> +		gmu->rscc = gpu->mmio + 0x50000;
>  	} else {
>  		gmu->rscc = gmu->mmio + 0x23000;
>  	}
> 

