Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCAADE9A758
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 10:18:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 270B710E12B;
	Tue, 24 Mar 2026 10:18:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="i0sF4b5B";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a//FHH/I";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B54310E12B
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 10:18:36 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62O9g8RY3903825
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 10:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MPnI1qz4JmkBX498CrBWzlzsexCfiYIj7F62cjd2QS8=; b=i0sF4b5Bd5Q2u2/G
 6Nf+7F3BWhGAx9S+XYEqluz3vVGkL4ea84c/VHzWf4onrQVwORSie8sMayeQg8Ei
 ZrC8mExhbrkEbUANs/WdsM8+o5TT7S/6IJtPe+DGhcF5RRigabZDHGlZ8mf+x/1s
 xArN5Y9dHaybq7vdmHnaswQWDQbdTfKGSjm9K3tbDi3bXtS+2XUqp+R+nPh3L6VJ
 kbTKT0rawrDoCVLR6/2ILuheEY4o2ttOYhC5QwFTNi9fDP0u/zfl8vE2SVW3Dzup
 54kFdM7kLVcm4ABFaQWO4L5gkLhR/99IrZmLI3kDOVld13kdx8AoJwr/9enhsinS
 zHdWjg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3jt0hcy4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 10:18:35 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b68af943eso7938471cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 03:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774347515; x=1774952315;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MPnI1qz4JmkBX498CrBWzlzsexCfiYIj7F62cjd2QS8=;
 b=a//FHH/IVJQH2lafxpK8LY+taUGakvUhPKbWZ//lefnKtE/qsUJkBnC5XiCAsioi5G
 ITNV+hT4+nhd46BYXzA8cbM1xfP4MY3DVYUj1JlYvT74amFDq0t7W7njjd8owqMIimdx
 CbqIcnHNz2lQJA0sEI7XU15TBVuxJUxL5s+vF8fzsrCrKdOMYECBRrqTiY/sqAgZIemC
 6Z8vdoQP5+pFB7/9nO041r0o/0sLt7DiNAn1kUXFEawkAsWgl2pQMVA66Ox05jYWdDsv
 Fx7RSpHNs/dm8fGnksA08+qCvuRRJ7z6rFSI7i5CrDgv+3tYVkj6FLi2A75CQ04aV33W
 GSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774347515; x=1774952315;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MPnI1qz4JmkBX498CrBWzlzsexCfiYIj7F62cjd2QS8=;
 b=kQu1vJsiHGTz2qqLfu8OxCgknaOgvGUhSL7pVP/Su/GulIMK0bwYvZ4sQ9qklAox+B
 /Htpblymt+69QsouZqZ1uKYSgkL4p3cMd84RQbHNGIbnrOj8EAnlOGcPL9t/I/rYvunP
 RBza1hJZE6QlL/Imu+v/cCS1vQelftTPQW9tnCZ2SlV+SZN4prnEjKQy2XwlnXDgayt9
 SdXLpB9Bz6uWVDlrHtcdqpbcUa7U6Ow8Aj7/mjFbnrit7QJz9iEcQIZuEvbX5GPFqA4A
 S0ABbLRu4YvmIskLJRx+qbDtb8QZtzNKeNpIk6ifNDGB7yHJcRAyAY0SMscnyiPNJ8O7
 KtSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/lEpo4vclCzaTuy9T0eU3KIxVZ5oI4ao8Jx3/HU8aP0AGS9H3T92Sx0oT4Qq8jUQrFzLkbNF0Ip4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwEWBUt1PzLabUSuaNq8/YufCtrzaJpbeoBR/I3uIGI8yJb1+61
 fSbaXbZvIfjDFN9TrZVRNkZMV/YVAAfDavx+kKTU5ihO4ioN19/xembBi8GWIg2fNXzxP9ZU766
 Fd+mbmQZuiPkxlCDFNImO6MrbUbkAybG9eEUhsb96Znyio73pMJ9JoyW/YRHRw+d8GudvhOU=
X-Gm-Gg: ATEYQzxTm5EtJBZkZtLwkoSP0q+bn2XW+hE670uy53EWqrSErgvM5NxuI4BFl2ZQHxK
 kMoHNCc/xLjx4YtKkDTo0JSszdhLPgCiQHLJE9B+VNuKEOfECKiwRKD6xhy3MmtN4SbZr6OTnZo
 wvHb/4WhCGl8Sg9WXOu6gaE3Ip4d1FmF39JG0w+Xo86weqJ5h/Xn267WcwQgE9NdYZAMkJwhBaa
 e2nL58X6b3GAVtjnKSp0puoQVR7R4/DErYF9yw1xsmULADFB8i4yUvOirTKyT3Q5WWFJmWgT3TW
 iW02hn7n/3Wjh8/3aCXbb+6TKWa5FCCZrO13l+WZTmMYVZR2YON/iZtAwWGbgBxl2dlh+PNW8aG
 TeOb/d9VA4bG0N160kkK/L5S5nHIJmotseTOWDVhTfj53kNud+5wUB4Gnzu18dt8RXf41x/4HQh
 5VHns=
X-Received: by 2002:ac8:5a04:0:b0:509:219f:8e34 with SMTP id
 d75a77b69052e-50b37233ff9mr177154151cf.0.1774347514996; 
 Tue, 24 Mar 2026 03:18:34 -0700 (PDT)
X-Received: by 2002:ac8:5a04:0:b0:509:219f:8e34 with SMTP id
 d75a77b69052e-50b37233ff9mr177153911cf.0.1774347514588; 
 Tue, 24 Mar 2026 03:18:34 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9832f440e7sm615146366b.3.2026.03.24.03.18.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 03:18:33 -0700 (PDT)
Message-ID: <3a71adbc-b06c-4c04-b539-abb56e4b1c6d@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 11:18:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/16] drm/msm/a8xx: Preemption support for A840
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
 <20260324-a8xx-gpu-batch2-v1-14-fc95b8d9c017@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260324-a8xx-gpu-batch2-v1-14-fc95b8d9c017@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: filYPVOdbIA_psv1mp-YXoxdyGNe-_d_
X-Authority-Analysis: v=2.4 cv=Nc3rFmD4 c=1 sm=1 tr=0 ts=69c264fb cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=n4QsoBDMxz4R0sOL5fcA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: filYPVOdbIA_psv1mp-YXoxdyGNe-_d_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA4MiBTYWx0ZWRfX7pu6vnQHTxg0
 ecuS1ZI9xCFXn8eVeobNuJRGf7LH9s8A5mKhUxUFOrMrZOJaczAc9HdRmw/fDGSP0crLYTAoh4r
 saF6ERbJQP/g+PSar9Yj5m4jE856KseEM9gURheyizjbDM6iF8gBVSQQPTy73tEk2Tl31JuIUQw
 L9h7hoYuCwomuFxcTombi15txg+tlleGXPki2Ns9Da9bwIER0hg95QgQEgb8UecLmx1hMDI+WnU
 GG0/B34yEqCUFK3+d7yTYRITLmELbNFfDIyaYDL4+7AC9lS1+x9Wib6jIubQdIuXQ2hQHaxA2HW
 +d0hsbesnEnsrrRTiIxEI9evQ18WeZEAAvT7FyItZuP1u1s8oWB+bfwzQx1J19+qIdIaOn1nZwb
 ELjzR+b0dn00ygUzdcvpEmN/yaEQvEdetacjYpx6QdsSEh+L8kT64mDfPNV3O7UJsiCTdMdD/EY
 xD/w+k2gJ++7HsGv08g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240082
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
> The programing sequence related to preemption is unchanged from A7x. But
> there is some code churn due to register shuffling in A8x. So, split out
> the common code into a header file for code sharing and add/update
> additional changes required to support preemption feature on A8x GPUs.
> 
> Finally, enable the preemption quirk in A840's catalog to enable this
> feature.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

[...]

> +	/* ... and after*/

ultra nit: space before comment end marker, please

[...]

> +static int a8xx_preempt_start(struct msm_gpu *gpu)
> +{
> +	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> +	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
> +	struct msm_ringbuffer *ring = gpu->rb[0];
> +
> +	if (gpu->nr_rings <= 1)

Can this ever be < 1?


> +static void a8xx_preempt_keepalive_vote(struct msm_gpu *gpu, bool on)
> +{
> +	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> +	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
> +
> +	if (adreno_has_gmu_wrapper(adreno_gpu))
> +		return;

Are we going to have any a8xx+gmuwrapper?

Konrad
