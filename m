Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816A1FF5135
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:17:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1A2310E4A8;
	Tue,  7 Apr 2026 19:17:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LVrPEXdO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ewVomxuu";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5E8210E4A8
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 19:17:28 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637FwB081796071
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Apr 2026 19:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 78mumGK398J9R90HCNz7x2LTJLiKD3WL0bIthEI3fxk=; b=LVrPEXdO7xzxlrnj
 0h37mDnSyDRUBpbbUUj4kpAp5BQSPkH62Z0ug8W2vFLLRA2S4czt/LVlqHLN+mjt
 2XFlDlHRKTnK2Cw0U9/Mj2bS8CxOGWDxT+DYdN5vQC67PdzmUIg1Wzf/Ik5m8Z+q
 cFoD0BXzhBUP4Zna6A2SG0gu9KodxslgluyHQG0Th9uE0HWgXg3eAIOEalYPBPgd
 r0Ec0ubAmPcXpTrQ5An83GUPzrdyXjvBEFVMEzH4qg4Uaelu4gzhrNVoKY+HF8Ks
 tYifdPSMhWrjpXNX+xEyDA4S6fjmvlVuMPHTqPNhfLarVxHkRdKdRNKaBXX0BIl3
 J5AKmA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd51d8ts0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 19:17:28 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b24cd2e2b3so57160815ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 12:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775589448; x=1776194248;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=78mumGK398J9R90HCNz7x2LTJLiKD3WL0bIthEI3fxk=;
 b=ewVomxuu0iK4qYizKOXhqeSGnBEblscUJj3AKFilJysgmpV2yNJVOVbyqDSCkKeCB4
 yR0+f4O1vG5fIYLMXAaeP0QqQJlNJZOtL8m9VW4r7ywb9SoqHdiKY3P3pHRgF6iipJ0p
 0Vgl3P8vjH91lGkptCW8fwnOZACd+zDXD+sDdwqzLfd/qOEYoAjfrKlqU3lgc2NBs1xN
 FzSYqJpbZ/yxqbVgLuxO7BTu5rinJToZMOhh/b4MaFlUzhmwsrnZLkzuDLUOJbN8ehC2
 m1cEOsybta3oz6RXqEZnPMfNtMZYAn8eNvx7+7OiKWilkTSA45du2T4yRQRUp4xEA1Od
 wk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775589448; x=1776194248;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=78mumGK398J9R90HCNz7x2LTJLiKD3WL0bIthEI3fxk=;
 b=S6V+gvyDiJW1m3OpGERAnhyl2PIVoPkz/VBl+573+6Aav73w0JxBxOANmzyYTj+nS5
 7w5COA/Tfxp088aaoFOtaEzJdmRPUdRRz0v88gP/goA//UqAhcITz1eCiu6zO8OI1UFK
 uLiwdgovTH8iBbD0TVtGDZ02eIXxQebI0y4WJNlGBga9oiHXSREc2YW3iwv8GoJA40Uj
 7dOsJUYNllYp/spRaphSXUtHpnJDZ/30RB8Io0yerjq6+YNnJL2QIM0iVpf0AcG/wX6d
 W7Fo28F3YgvzMDX4/dqjJATgdO2CbTDhuAg5fiYMFCkcbOdnrC11wlLy9lPo4AhX08rT
 SGFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1+heBvvFpUeQprRQGCPmVh2G2kMnB7GfNdG92LjzLb7tzu9++rCzIVPXs/DF80QX5NU5ZZzvNBt4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzRzOZbpR+UMLZeSPpW1eplGr8AN7hF56i0cc9knOP7vbSyWIep
 9EwEdvDHh+77J7MmmTwFevp97Vb2Uir87aq1OYTfnqycYGEANDY2D9X0pAPH2uOXnKc9Vm2cLsS
 QWyCNAODepD9QMt+gSBeBKce5bYnhTIbTbUs9N0BoQYU/HwuJ9TG3SzL0aUYsjx4i2Sqdb6pIEn
 GKfLU=
X-Gm-Gg: AeBDieuidkA11Wc4VcaWoxEZ13+9IntqfWi/qKgkVueNnoLLZmhQueF5CX/qNaPTJi5
 DO9bTSVS5+lGMlx7gEeBqXw7bGQOS86MRbjpR1DYa+tmTvOPvcOY3Xm034B4w8McEvAJnxH9J4L
 XM7EZgNkJKyKbYRZIzRXDEf/oJoObVVr174wfQF/H6ePHzPlSaoBixbS5BcWyRF8F1QDnZ8vHEa
 2iF0uDLcdLJIdJw4IsMVROEe1MwEhu/rijKD+RqOJ1yA2+wb8Iav6QWGCwIAPI1BpA8O0PSa9TO
 fKM0vkHDg2PYjZE8AzarhtT5puioEw4prgo7JVFVNIlwi4OBltJRwBSjg6ukjXLRxYka/v4bZRh
 cn3YpYAYgEAPrWE/KEmvnhw5hF+jpjH/HhKWYcSYQ5uDZzw==
X-Received: by 2002:a17:903:38d0:b0:2b2:5042:dd18 with SMTP id
 d9443c01a7336-2b281715eedmr185147135ad.3.1775589447587; 
 Tue, 07 Apr 2026 12:17:27 -0700 (PDT)
X-Received: by 2002:a17:903:38d0:b0:2b2:5042:dd18 with SMTP id
 d9443c01a7336-2b281715eedmr185146775ad.3.1775589447090; 
 Tue, 07 Apr 2026 12:17:27 -0700 (PDT)
Received: from [192.168.1.8] ([106.222.229.237])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749e2e97sm240033735ad.82.2026.04.07.12.17.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 12:17:26 -0700 (PDT)
Message-ID: <d56c1af1-af46-44f9-a048-2b3f22529307@oss.qualcomm.com>
Date: Wed, 8 Apr 2026 00:47:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/msm/adreno: fix userspace-triggered crash on
 a2xx-a4xx
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260407-adreno-fix-ubwc-v2-1-7ff73624635e@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260407-adreno-fix-ubwc-v2-1-7ff73624635e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ra2MpR07x0kG1C6Ey5ohiTlznGSViyws
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE3NSBTYWx0ZWRfX5djbHAP3gEpn
 7gFvCLQQm7vFrimUFVjFS5LXdPTU5aPe8MW6FHsEk3YlalhFcUDLs5eKKQsoH9PLNq9SIx3Y5E/
 v7z82tLusYEW68LlmZX10YjQZMn9tzYrz4OWHpJINnGR4zHrxJDA8TAiMOuS9yVlil3cSVPkpmq
 iK2jV1Gen2l1CGv+gI3mmg8k/rmxfZPEzrl3NWAh4JgtUpXQm9GtNI8s8NL3h8OGp+kqgm9/0A3
 asLw79QVzCe2gJBg7F+7V0R0h52xNvA1bdnQW4JehmLtyAxHpRc2qjokrXR8vIl1uceL2GqA7Oe
 vUqhMqynsXySOfSVKREDgbwyrIZunGXOn64mQpDYarI1sZp5+9p3EfpSC4+5a1+4RoZ55k+H5xi
 zLOxcIc498PLSRaJNgP6jIJbPzq0hpQwzaPBGkJ29oeVwkaTbvKjYJtTVTNlQ05YK/PPoDvMCfV
 NIQ2Xk6AyOZeMNwHL2w==
X-Authority-Analysis: v=2.4 cv=AcaB2XXG c=1 sm=1 tr=0 ts=69d55848 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=oIjhDLspr5RTlLLUpj0f1A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=dQ27rmbLVP968nd230MA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: ra2MpR07x0kG1C6Ey5ohiTlznGSViyws
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_04,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 phishscore=0 impostorscore=0 spamscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070175
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

On 4/7/2026 8:53 AM, Dmitry Baryshkov wrote:
> Before a5xx Adreno driver will not try fetching UBWC params (because
> those generations didn't support UBWC anyway), however it's still
> possible to query UBWC-related params from the userspace, triggering
> possible NULL pointer dereference. Check for UBWC config in
> adreno_get_param() and return sane defaults if there is none.
> 
> Fixes: a452510aad53 ("drm/msm/adreno: Switch to the common UBWC config struct")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil

> ---
> Changes in v2:
> - Changed adreno_get_param() return -ENOENT for affected params (Rob)
> - Link to v1: https://patch.msgid.link/20260407-adreno-fix-ubwc-v1-1-bb2b09450b87@oss.qualcomm.com
> ---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index d5fe6f6f0dec..34e4ab43b0f6 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -426,15 +426,21 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
>  		*value = vm->mm_range;
>  		return 0;
>  	case MSM_PARAM_HIGHEST_BANK_BIT:
> +		if (!adreno_gpu->ubwc_config)
> +			return -ENOENT;
>  		*value = adreno_gpu->ubwc_config->highest_bank_bit;
>  		return 0;
>  	case MSM_PARAM_RAYTRACING:
>  		*value = adreno_gpu->has_ray_tracing;
>  		return 0;
>  	case MSM_PARAM_UBWC_SWIZZLE:
> +		if (!adreno_gpu->ubwc_config)
> +			return -ENOENT;
>  		*value = adreno_gpu->ubwc_config->ubwc_swizzle;
>  		return 0;
>  	case MSM_PARAM_MACROTILE_MODE:
> +		if (!adreno_gpu->ubwc_config)
> +			return -ENOENT;
>  		*value = adreno_gpu->ubwc_config->macrotile_mode;
>  		return 0;
>  	case MSM_PARAM_UCHE_TRAP_BASE:
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

