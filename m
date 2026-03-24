Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37DBE9A74F
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 09:48:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48F1110E5A5;
	Tue, 24 Mar 2026 09:48:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IEvWCCKY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZLvieGXY";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 457BC10E55F
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 09:48:25 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62O99jCH2930615
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 09:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hoKEgoUvUUln+NtcEflV6fUXI9ZyYyiSqPOsjxxTzBs=; b=IEvWCCKY9vy/yuDb
 04ReAzzSAoeErOTGrwCRQpWfp/vUOIUPaz5yuM3yRRUY9j/yGVVCXuc8nZOFQJ26
 T3yyuLo8/QhXeLMpJG+voaM7V0pRsq+7Cg9Hx9G1zJ+gqwxEwEIBXLiIQ3v9hPHH
 U4Iwq0GElfsS9GcQpSgBXTDbg34c0RAuWymODNWqtVVI1F0l8Bo8Wbxue9tFcgBb
 OrO+S7G8mWkXVEZDoP49XlSns707Pp0/E7JoXd1dYO/kSgtTqG+O1sx5nGsu49S4
 Yz9+fPVxVfxUcFDyBOzx/w6zzpxbD8j125hhOYyZE2iCxEmTjfU5FI03/fBxZ95B
 eLyGXw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3qr384pv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 09:48:24 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b32feb719so33502571cf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 02:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774345703; x=1774950503;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hoKEgoUvUUln+NtcEflV6fUXI9ZyYyiSqPOsjxxTzBs=;
 b=ZLvieGXYmUbhLi3I2LqswzFhRa18ULKso9xRr8RqmPDzuUEUVxlLFI3YZ1jLHl5R6p
 nAHGAVa6iJWTh5tfzzvQeijKrXiWtt5ZyIRWqyU0ftO3Dpr04bcNypiM8SIPPorXYzqf
 0qG3+W6Zxlo4SqD+FqZGA6UjpvPkawj8jE4T9WAuFWb4nwOdwWyevnufybclPkTWqtqc
 8tEjcl/6OJgU0/KHPLYlrujDHcSIRuZnkLNVtQyny1OxOllqK4gRGCdDqY6D3OKJNpYb
 cO+dR/jC6fQRGPEx6Kir1XRfxuE8NTLlDkqZcGGdArjrDcxhY6l+rORlhRlnM7e73q81
 BFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774345703; x=1774950503;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hoKEgoUvUUln+NtcEflV6fUXI9ZyYyiSqPOsjxxTzBs=;
 b=kV4nkYtLluquJA0nQJ753ZN5lcq4jP2WQ5crrso0qW+TEFtbFWgpX6QPpaE4RmY5JM
 SjdBBvlldoNEfhyNgBGQG+SDHMEo+lChHbWVeK75Rb/sTf4AxaSSKj3KeOdCkgOt0wow
 V3ZzDhJjXSbHWyg5ho0X5+ahh8koe63EHBSzHIdxyOF6wK+7WhIMzeaJHUZulZpjymLW
 BY6sGkfPd0YTCzYv0EcLRunqwVXuWitJZGqWaDs5DaO6iMz/4PsbZ8/lEBko6I3HZsff
 XI9yvjOM8UuymSkLr9DWXoP0zNNO8zr5rUtDopB1Fsdi20xHzcMK+b1V/y6btBzDO6fu
 uMMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCULt4BSM7yXmImmnFsSX5hiSIz2mxAS2tAtOyuw5LGM/lkBLOAQF/ST2WCenV6cXsVFt+qIVOMDpLc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxDU0dY5oocHNwdUqIywsS6AM6iE2u1PSyoSYqVJwOnQv7mVVnO
 1i4AzF8ZNebCZdZzm4ykG20ZzaFsEno46RXbT6T6IsAHFD10wVf1UA/tS5vDSDYAWqCeqKuaH8k
 AXDmC7AL7H95yr9CzCK0Ov5vT4S7Xx5zIQ7+6oK36qvY+UE7z0oouILlmsQFwoEwUjsksnbU=
X-Gm-Gg: ATEYQzz8bthTi/KWOoicnUb8ZU4xivHakVRPUmsZlAMcArEIfVckUkyqKw3NZCa72dY
 HumnebtEkVoSrEwCir2UrIExrdKSEet3Q/Cbtdo4bd4s4MIfBdBzc5qwlKPZg5xQXXf4G5vJRA9
 fa0mtuFzCi6JNb2KyNQKg2Qav9+E2fSfnkexAhRn3GabbBn28m1bLbJOIIF3NEKddN5ecgbFuo7
 rep4hETaqRAywA+BiXk4EYTmtusw4zRNr8aCRa8bbqD5yv+28y2kvAUfiWpzbCrHQNbH6ISsQ7q
 uClYn/VawrB7uA1IFXQZB3AHpJFAVFPhg+03MrJ7R145kqWXtwTnpGVzvDBVOkHQ31iG0CS09zZ
 2ILdEdDsySlzk+2jEfgm7nSBsVPxqBPO0LoEC9dbITgQMVzlQBe6EGX8QFrRiJSrKxeTF9GyTUt
 HQCWM=
X-Received: by 2002:a05:622a:1992:b0:509:d76:fe73 with SMTP id
 d75a77b69052e-50b373d748amr181292391cf.3.1774345703546; 
 Tue, 24 Mar 2026 02:48:23 -0700 (PDT)
X-Received: by 2002:a05:622a:1992:b0:509:d76:fe73 with SMTP id
 d75a77b69052e-50b373d748amr181292131cf.3.1774345703079; 
 Tue, 24 Mar 2026 02:48:23 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a285192e88sm3096534e87.12.2026.03.24.02.48.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 02:48:18 -0700 (PDT)
Message-ID: <b0ce15a6-b2b4-4059-93fd-9b4b0b4360c8@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 10:48:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/16] drm/msm/a8xx: Fix the ticks used in submit traces
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
 <20260324-a8xx-gpu-batch2-v1-1-fc95b8d9c017@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260324-a8xx-gpu-batch2-v1-1-fc95b8d9c017@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA3OCBTYWx0ZWRfX41ejFSBZpimR
 T2/pD9Mc9DzpE25xuPMBT4xfcro0UdmUZRaAhtxegCEFrMCYxdahHuVa/HcxnMakY4kETcIlF0i
 eThhLXqIogEqjpOLaNgNgard+l7kOfYy5dYc9GU8nkmQdpX142wvHv5/bJfY6NrEl1JBU2xpdem
 LymRGrDcruxbcW8AYul67yzahAqx8DkiuS9m9jEOEo6oRGdm+j3Ad43CVV4D2Wpm/un2703KnJQ
 3zlqW8wXpDyOjIgu+EGfx/hupqyW7tvURsD9IcNmWvFFLuYk77ZC1bLY4MZunNts3INK8xVYoqU
 CZugElqOFrVMVPB6dch1JBgyyqgiYqP8Qz5I25wuNU4qS+aW/l40uuVWh0QYVPrOq1EBELRqYJj
 Y+CbVpRZJuPYpNg98icHkBFsqgZiihmOgNTM6ewGbCkIPmFEdhN0mL6TlyAlZDkm/lyiCTekFds
 2+SoHnrER5vSKqQ6s7g==
X-Proofpoint-GUID: ggqQZtUamaNdoqONG50-QF4pacJ6hKSy
X-Authority-Analysis: v=2.4 cv=Vpwuwu2n c=1 sm=1 tr=0 ts=69c25de8 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=SuZvJZu2A8V8SJCN6oQA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: ggqQZtUamaNdoqONG50-QF4pacJ6hKSy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240078
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

On 3/23/26 9:12 PM, Akhil P Oommen wrote:
> GMU_ALWAYS_ON_COUNTER_* registers got moved in A8x, but currently, A6x
> register offsets are used in the submit traces instead of A8x offsets.
> To fix this, refactor a bit and use adreno_gpu->funcs->get_timestamp()
> everywhere.
> 
> While we are at it, update a8xx_gmu_get_timestamp() to use the GMU AO
> counter.
> 
> Fixes: 288a93200892 ("drm/msm/adreno: Introduce A8x GPU Support")
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

[...]

> -static int a6xx_gmu_get_timestamp(struct msm_gpu *gpu, uint64_t *value)
> +static u64 a6xx_gmu_get_timestamp(struct msm_gpu *gpu)
>  {
>  	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
>  	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
>  
> -	*value = read_gmu_ao_counter(a6xx_gpu);
> -
> -	return 0;
> +	return read_gmu_ao_counter(a6xx_gpu);

Can we instead make read_gmu_ao_counter() take a struct msm_gpu * and drop
this wrapper? Other callers also already have a ptr of that type

[...]

> -int a8xx_gmu_get_timestamp(struct msm_gpu *gpu, uint64_t *value)
> +static u64 read_gmu_ao_counter(struct a6xx_gpu *a6xx_gpu)

Similarly here (also I know this is a static symbol, but keeping an
a8xx_ prefix would be nice

[...]

>  	case MSM_PARAM_TIMESTAMP:
>  		if (adreno_gpu->funcs->get_timestamp) {
> -			int ret;
> -
>  			pm_runtime_get_sync(&gpu->pdev->dev);
> -			ret = adreno_gpu->funcs->get_timestamp(gpu, value);
> +			*value = (uint64_t) adreno_gpu->funcs->get_timestamp(gpu);

"u64", I think checkpathch will also warn about whitespace after a typecast

Konrad
