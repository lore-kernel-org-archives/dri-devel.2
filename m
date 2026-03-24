Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9473CE9A756
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 09:53:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBD7510E5AE;
	Tue, 24 Mar 2026 09:53:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AzVGb0Tx";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XD02/dcW";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65EC310E124
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 09:53:20 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62O42jLm1762120
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 09:53:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iapTK+TrQmONmVoW3zX5R7ZoU2XaR1AWJC4yYw/a8uk=; b=AzVGb0Tx5agp8Z49
 C8lmGpKsqFZYFO1aXh/EmJ8ngMIYdQFqimPDL0tHsxM4/9BECYn8sRwmPOnUlofA
 AMmqnp8nPDMpvWye2VWoWmmbo40hPYkLescIl9dTERx9GWPvHDF/2IPzHyjTUOCV
 djBA0SiJdlaze1ctLXSMacF5Hy/RQkpbrdB6Zodws6IEO/CaAFYOwz5y0O0OaQaB
 2nyz+5vT8HHYLlW53+sKCPH+oIGizHHKcQb+O0chRzdsG+rMatOBGxc9c+tgPMHO
 gLLWSklZEmhPhMe16M8oD5MfFA7IRyJjrA+OfnzeN27tVEE8bOJ3meIAcJQPfhgq
 Xaa3uA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d36f0bwgh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 09:53:19 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50b33a19837so48785651cf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 02:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774345998; x=1774950798;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iapTK+TrQmONmVoW3zX5R7ZoU2XaR1AWJC4yYw/a8uk=;
 b=XD02/dcW3SWtcNaRCdVMYXdWNGT2IxwdO8WvOIxI2XoTk24Mu/zemhvi/kJX5s2V2p
 ZoDis0umPW08+ixfvp1cdzFdnr16cQqh3p3y2k9TuTOiAi1X0scVy6vd1cvEKozcDdK2
 0vqnkgepBJ7DQb/2jOm6VI7/zLudtwHZvoSuZHFP0Rlr8HEgq6cZ9Qadt94urIO/sfMM
 ZEDMDDs5PTazrRQd+Bf/gHD/XtsZDgp552/AJ/7rhPQEuGZMPTBtSTHuRQVyFPrMxNPl
 MGCDxcd2TIj/+BQnmub+7W1DVkbRqo08n1FHar+1gsu6hTuJX+F9qFcycKxgGvgAPo6M
 m8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774345998; x=1774950798;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iapTK+TrQmONmVoW3zX5R7ZoU2XaR1AWJC4yYw/a8uk=;
 b=VV9lSiJGbDzTAlABsV/0/p4BhomOfKhpnsU5vnUkH0OeQBb6gmI3bZvfNwM+0VGNR8
 riPUDY7V38FiHQElJNsh7BGiwETAzPjCXRFbNiu8FD2roIGjHnnzBV/nj2+TV8Cf09SJ
 tG7gbn+YGQibUV4tQeLGcg0Nrf7uqP2W+m+YiCk6CaWiemulmUxfy/cL2mpGbkjv18B+
 1T5fI46vNIebdahCa8pAULBluWveL2fYgW5adHdL93Qej0ATwGUUMjUvByQVZyUbhr5i
 5Z4UurtlUpLes5FIyM8iBAzJo/3lhtjRtTy190aOoOCikXYGYfpbXZs9MeRXEegBXOHe
 bF2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyIF8fkghtdT96J7OAkdiqA8WckLlp9nr9Utic0YoroZFE0ImcysSmOOtUksqVMh1Q82UgAsvxdrc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwaqcfoCcFGVPDKPPd1wZjvFRX8/9HQJe8dlDkK27zUljHEql6j
 F3X/jt436FY1oMyREFHVffgy96VzAhMP4Q1m+RpPL7UoDjSu+v2Ocqz1805Z1rMi+X6JPTv2IgR
 69CkYmRWK8tGbAVCMAfe2RA4m4AgASX2jJUUz7mdK6ptVpgJMhpikX3tC5kEQKx87Ze8Aa68=
X-Gm-Gg: ATEYQzwSooCpG52aF1CPdnfSkjy6FnC/ZEmjM6wByj3O4xtao7BHO4n7KXgv+r+VL4D
 vNUId7LyG/BtQl0fQtPDEJMEPKVSazhZGGsbxjxXZnlF/XoRR+Br13Q4sYtc0An8MIbONVNoPkQ
 vVIhmd++UCBp1EhS4+8Raj+ORzzn+TjSX1nEmBNFN42gmruVGDBB3ay95PvTBFMDgpKzvqw8irK
 2Sh4i6VRlzP3yWg38AnDSZhV5zo56F6EfcgbebASw3zwN+xCIlrL7emn2KB1pnU2ElxtB37QBEK
 ihMWALj4DD6ME0vmYhSGHSRCV0y/n0er4db233E/U9hoYmX7FJ/wnARFC4rW7JpmUZelvubXBZK
 d5BxwX2cxx2HdWxJtqRZTuzUA3JQR15t0E57nsgCPL7TZk3oVC20KjJHgSCQPCoN40q8hFHpHXX
 kj7Tw=
X-Received: by 2002:ac8:7d09:0:b0:509:bed:db5 with SMTP id
 d75a77b69052e-50b37518e31mr180228261cf.7.1774345998287; 
 Tue, 24 Mar 2026 02:53:18 -0700 (PDT)
X-Received: by 2002:ac8:7d09:0:b0:509:bed:db5 with SMTP id
 d75a77b69052e-50b37518e31mr180227951cf.7.1774345997739; 
 Tue, 24 Mar 2026 02:53:17 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-66a36996b12sm472185a12.25.2026.03.24.02.53.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 02:53:16 -0700 (PDT)
Message-ID: <d52be851-401f-4157-8bb8-675744aa484e@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 10:53:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/16] drm/msm/adreno: Coredump on GPU/GMU init failures
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
 <20260324-a8xx-gpu-batch2-v1-5-fc95b8d9c017@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260324-a8xx-gpu-batch2-v1-5-fc95b8d9c017@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=b+q/I9Gx c=1 sm=1 tr=0 ts=69c25f0f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=3MGHxYdU-HpZmC8ccYkA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: kxr8FBqMQvXKMLXbRx--weC8PYWJxNqO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA3OSBTYWx0ZWRfX0JQx7ihUVHEr
 m4yBHmd/7tGpjfrdfl6RRsFKXkojPHVxn2T1L/B2tZ6xNxPaVjA4Whyj0g/HTopSif+gB7yoQu5
 90jufsHoi4u/hLQmWytGrMk/QwnYg5z3m4vrAf/4Ss6WVKOLus0HuhnW/LJ2B5pa2/JTalNUvZv
 He+X7u9xI5WycDvNLk4FdIvxZ4IOxhADBHdxPUZZmTSBwNZCwdVB/M1WoV5t4xNa8rymmAw1Uj1
 H1kebuZf+NU3SVvXyCyylvfh+fmNIG5uuBEz2i6duHInY1GNQfj5gsak8IltgUjVomHvsR5dxjw
 FDRBwrJrU8/8KOZF+ePCMybopCa1oy2jAuA68gg3SIeIm1RlT0bVu8ph7ZbWc7AjG6/2v9/uWys
 gJIPwpwpBck+FSEjq3kN/HirwQwK2auFCeGwqdQXq/cu5tzk4BGCxkPf1NPc/PcDNxRi8gCyNdr
 nt6UyNBL6LP2FKMNZWw==
X-Proofpoint-GUID: kxr8FBqMQvXKMLXbRx--weC8PYWJxNqO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603240079
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
> Capture coredump on GPU or GMU errors during initialization to help in
> debugging the issues. To be consistent with the locks while calling
> msm_gpu_crashstate_capture(), call pm_runtime_get(gpu) always with
> msm_gpu->lock.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c      | 1 +
>  drivers/gpu/drm/msm/adreno/adreno_device.c | 7 +++++--
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c    | 2 ++
>  drivers/gpu/drm/msm/msm_gpu.c              | 5 +++--
>  drivers/gpu/drm/msm/msm_gpu.h              | 2 ++
>  5 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 690d3e53e273..6d511dc54e43 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -1240,6 +1240,7 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
>  	/* On failure, shut down the GMU to leave it in a good state */
>  	if (ret) {
>  		disable_irq(gmu->gmu_irq);
> +		msm_gpu_crashstate_capture(gpu, NULL, NULL, NULL, NULL);
>  		a6xx_rpmh_stop(gmu);
>  		pm_runtime_put(gmu->gxpd);
>  		pm_runtime_put(gmu->dev);
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
> index 4edfe80c5be7..85b3e1f0e4fa 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> @@ -105,6 +105,7 @@ struct msm_gpu *adreno_load_gpu(struct drm_device *dev)
>  	 */
>  	pm_runtime_enable(&pdev->dev);
>  
> +	mutex_lock(&gpu->lock);

guared(mutex)(&gpu->lock) will let you drop the subsequent
jump-to-unlock

Konrad
