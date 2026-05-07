Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF20CD343B
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 14:44:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F2B410F179;
	Thu,  7 May 2026 14:44:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EVVSz7wI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Cq4UBr8p";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 213AC10F179
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 14:44:15 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647EeR3p259326
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 14:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dZS4Z+n5yl3239JmhoNbCdzxJTz/lzr+NgykezCYlEg=; b=EVVSz7wIFyrLJmZz
 poqDC3p78W4clIeM/dnCNcNXkaMl9hccxhUDA1kztXGceFFPT1+RfYYwsNuym+wC
 7u0waGaZrVg96sa7G0K2pUbTzqVaTsDioOnkmQO2Vim0bGqGiBk5A3oLZj9WUB3L
 YsZPwunY8DwBOQ4tXrKefPz/yHz2sXS6/tsNuR86NYl/kukj5WfyB7z2VwJ9kJJ9
 Q7zJByAu6lYhRsxgK/M1IBILIdKVvdSBAv+gO/17XQ0pUssg7TBXcr7ZHyq4BBPD
 XqH88/Qw52PRlp7eOzVLy7oMp9D1uTpeC2gBw7vjvaKJdbKyTnMjUFO4461pg0FT
 o1qPWQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0hr8tn7n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 14:44:14 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c8247b55775so1038265a12.3
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 07:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778165054; x=1778769854;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dZS4Z+n5yl3239JmhoNbCdzxJTz/lzr+NgykezCYlEg=;
 b=Cq4UBr8pin9mLbqFIbWIoG6sI5qVsp31ZUMQpWC+36Lxcbb0I1lr7F5gXL7uEDphiT
 Q0eaPKDnQLpYPLxaoqdkoJo714RsOyCzu/1aUhwco103FxJ3xU8LaTpKpajrW44LJ9kN
 ggfptOTS6V2DfZW0mP7Sl2wAu58PQLHLH8g6YpehfuDVFhRrGpn6yjLWYNlF2bTGSZN+
 26krxJH5Hg+/ve8YlzHcc9nXpGFiI+KHaHTINacZBo8AotlUMQHwitYF6PciCXWKbj50
 dqHmYisyQoMbwhmntCoLvXVN6Kr+X2Pz00NGebV+GchXAP9IA71W/IR8o3nSCTm+CgsY
 GF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778165054; x=1778769854;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dZS4Z+n5yl3239JmhoNbCdzxJTz/lzr+NgykezCYlEg=;
 b=dv07ei89iCpal16VRMRj+1zmMBGdjQ6HZWuUCfwbfS2ZvvVfwtF80eZCGEBEnmwl68
 uN4jTkZAnyI8uTwOgYYWEie1hctqWQ3AOOBK7G4JitZfWSOgn39m629ndZjcPq06m85B
 nP2v+f4+FaAKNrR0bdmqPyFaBJ7zgSDeuWW9m7asa8ZQxRgN8uXIFXbBn3e4HSuAn8qn
 mbWtiLqXovEzcUQo0104cSZyhgbi2SbVZ4UIA1CfKnIWGfEL/1L3XNGmGY0Xwv0gqT3p
 2paapjYx5Z3bxug2qbHue1sGSzanBK14pEcsqAck4HhnvTQ8ZFaLUDx7YNhiml44JVMY
 +gEg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+hX/cnK75V5d+STjfycAPPT6n70DIF5rHZxlForx6sIa4HdA6SHSQWJa2e5AyzwDL2WfGBSPsj3I4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyUp0i0O9vvPaf49kIHCJlBAEtgcghuESv9Syyg1yyCqwpyuooq
 S3hPkoYVylvDfgB4ySuTNf6o6/iRpgM4huOdnWpJ6o40ofL5B6fYUuhEqFNtsG3U3h1B+grWyEV
 vs5Y+k0hhOuKLYpCD1us9T7ijHmCc8hpLPmhn5N/jtstSPvk+ZQ08UP6kjyAHY+oXAaUlggU=
X-Gm-Gg: AeBDieuyMqOjX0Ucvon3rxO7LFCpuJdZ1OVrCm2Q2KFqhjn2vS+O2d263E/Wr12+Aj4
 i31CKdhbNhy54oi3wZMm9aSVAvzborNFTEOjP0oKOD6m/6g2sXjkLSHsX15v3OhRs4BT1JPnSSG
 oHGd1dgo02XHO/SQk+dhdgrczsAMFrvrXe/AUhlkLdBauLiMkOX8SaiSqgBAnCp9yZvNJY6AGho
 GjI6x4VGGuaFMxscEhJSr71d7CsFeAqjZyavEDfRCCWXYMCIHtlRmAWV1RAssOd+P/sgtAZBzcA
 wZE3R8mdIbztdmARJqONDX8QFgQfn0/NPAS3PHKiP2o3M6juwXziKD+ysdcdZDLEAw3IDtlYfPp
 c7eQKrSxoexV81hOEC+2jtMXU6j8C2Uz0TxhqVyVY1fu69VxqEGFtPLE=
X-Received: by 2002:a05:6a21:6d82:b0:3a2:ecb8:56f0 with SMTP id
 adf61e73a8af0-3aa5aaf65f0mr8713541637.33.1778165053519; 
 Thu, 07 May 2026 07:44:13 -0700 (PDT)
X-Received: by 2002:a05:6a21:6d82:b0:3a2:ecb8:56f0 with SMTP id
 adf61e73a8af0-3aa5aaf65f0mr8713494637.33.1778165053030; 
 Thu, 07 May 2026 07:44:13 -0700 (PDT)
Received: from [10.206.103.12] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83965c30ddasm11425000b3a.21.2026.05.07.07.44.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 07:44:12 -0700 (PDT)
Message-ID: <2b3e5751-4de1-45fa-95a4-6d3d69fbe2dc@oss.qualcomm.com>
Date: Thu, 7 May 2026 20:14:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: Re: [PATCH v4 16/29] drm/msm/adreno: write reserved UBWC-related bits
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260507-ubwc-rework-v4-0-c19593d20c1d@oss.qualcomm.com>
 <20260507-ubwc-rework-v4-16-c19593d20c1d@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260507-ubwc-rework-v4-16-c19593d20c1d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: tKdYgB7oRSIfI57uTdbak73C_wnhVMHp
X-Authority-Analysis: v=2.4 cv=caHiaHDM c=1 sm=1 tr=0 ts=69fca53e cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=ZswEv4b9r44Tze3PQiwA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: tKdYgB7oRSIfI57uTdbak73C_wnhVMHp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE0NiBTYWx0ZWRfX7bqlys+lw0E1
 ATrf+ajro6ez4GD1a2iAD1k7hsF+VdO03vMaZeMLDupANVlbKnG0QccoshZKyZGe+XwlxszmwWU
 DERp+COMNGp0f6w1fe+AkgFKU/GWPF8jiq5nNtimQI2typrM5WGhLT8ZnXOLoCKgkcKPTaeNxss
 Gpxe5Yt8QFkOrEaxV9lClfraoTJWt0urk3PV0BqiCBgg13h2G1AWaF9pgkY52RqUXR3tEwEamNs
 WDap/WaEJuh2ZagxhN6IMDBIzqGYhlqR20ZbzYMnCUtetq+N5IahHN/FBiW/OSGjghcIqTo6JA8
 dLw3e4rSu+mno6hEch3voaD3Mk9tQDHZjMABdfPATwKK3L4km21rHhofmBZdUW6cWRmA+FX/Tdp
 CYhMBXIi0wpB++wG5XeI+CAY05/5gFVs+vmVEpSu/M1vs4kWUv0BJo4izjxQm6XbTjI2qHEceMB
 rvxL0m4vUnwLWC5iWFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070146
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
> On the latest A8xx Adreno chips several of the bits in the UBWC-related
> registers are now hardwired to 1. Currently the driver doesn't write
> them because there is no side-effect. In the preparation for the
> refactoring in the next patch, write '1' to those bits anyway.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil

> ---
>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> index 53def136e0fc..7a6223ddd8cf 100644
> --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> @@ -288,6 +288,8 @@ static void a8xx_set_ubwc_config(struct msm_gpu *gpu)
>  	switch (ubwc_version) {
>  	case UBWC_6_0:
>  		yuvnotcomptofc = true;
> +		amsbc = true;
> +		rgb565_predicator = true;
>  		break;
>  	case UBWC_5_0:
>  		amsbc = true;
> 

