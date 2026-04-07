Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1423DEDB7F8
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 10:56:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E8E710E3E0;
	Tue,  7 Apr 2026 10:56:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NFmVb2YC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PpegGfe/";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1564710E3DD
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 10:56:41 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6376f82P3402359
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Apr 2026 10:56:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ko+QfhLFwmwkxoUOJjdvmB7TSp2JRVRFcGoAOsZ7jO4=; b=NFmVb2YC62QCgbj9
 ROi1zp1yHdWUoSXTDEYN2HMyaHFePibhcCfXJiROm1raq6ZH6U8p8qeSf8gGG4hQ
 t3fD7Cgms9AcIbNIvK6bftF8NofE+8SH4yJwiekx3odZ6+OBM/5hzzL7nIJ/loW5
 Gj1loQIgThK6kMsNNuqj1utmaZ/tWRtcV6WeibBiT2L2+BF9hrCvDt5v1bRYyUe7
 e6ULJp3yJ5BYi3L/0QAlh+mAiUx64QeaNeaFzfnfU/yd1M62CBNlrztF8gP113e6
 PmiyektmEl47FHoW08Xz2RpY9GX8GE1n5S5hqc/tTSGNCNDm0/WWcbJoXMFAJFU7
 gyhTrQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrhtbxy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 10:56:39 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8cff2297253so102458885a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 03:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775559399; x=1776164199;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ko+QfhLFwmwkxoUOJjdvmB7TSp2JRVRFcGoAOsZ7jO4=;
 b=PpegGfe/Bf4DLwpahZVYHW/7/cujV7F9RJicr28o0ITdr0H8wCMggrO7eOJhuMl9xY
 i4CxzXy19r4NMQzDZI0u9FGj2D9qeld80+lYH/YLKn/VecGGXPLMnIeyf937IJmJNpM0
 iboHSNutAV1ulYIu7B2S/acMNA7JOloFLfythy3X2EpvVS/W2AsHDD40F6iZst9XBC0X
 MB7vL3sbh32up+aFvzo9VQjcq7cQGTHOmvCdm5v/6JStcg9jCD04aB+VizA90md6CD/g
 8iqKu6wdPq9Tjim84p510eq/3Ws1QiPBoOxnMraxzO7Kf8vWiLoGjl80d3fx5J8NOvx2
 RBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775559399; x=1776164199;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ko+QfhLFwmwkxoUOJjdvmB7TSp2JRVRFcGoAOsZ7jO4=;
 b=ProZSeReS8rBAnicYFAy/CvpCeBElSctgd2L8gDiE4t+CKQqrPCKjS3Mkl4/eAPv5N
 TStHKutQonLaR6NiDdhPkdL6TOqrsMG0qmvND+r0XdIJDcB+g3FwsHBXIEfYedBlzYoA
 g+adOSx3tyvCN+ltc+yGRLS9/wTjYQLGqh76PXDp9AIZhhsNzyb9imuuvCJrW/0bVdKY
 l+KQF+9fYxUR2JikRQz7o3WS3kgob6jmNv/pfNvKLugu6p7/8OxH//ORxVjH56eOnHw+
 ZvSly6A9hZ/F73w7qiSMvA6UdcL6iQrXilltUm4r6L8jQFS3ayDBRFO0Yz4Rpuk9Sfjb
 Ho7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4QbsX8Fa+krldenzG+sgcButSqNEUtW9Fbg6a76ovfLwg1ZM6cUdqrDsFmQF2XUGE7E3xLsIC2X0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyfEbUQIEJe17OUQoh1W7sQS/Qn2r92oKiih0P8TxHT39UfMoMv
 UyShqr1h+ZMGbLi7oGue+/isqIFTf/YcfwQOhWHylXjkK202FfdtQk7BIKivinAsujUNl14bMUv
 mYoiGwCrgBQIC9c0mG4tMwMtP2s6yEY/ltWppy/mWxCCwEL6TIwF7U5KeSQePizJ9+FQG3qg=
X-Gm-Gg: AeBDieukpNFxUeybWaWUHPHmRY/PLqhk2x+sZN933Yzl0KU0unm+mT0FyL0+copf21I
 0CB36sBc6J3v6vvI8ShKwxuWzhBuk4SiVZi1eXEpK6giwBurmMv4x4lNXiqzYVRw8LagHzvsUkX
 9jH2Bs6J+jAViIUMaRlSQ6wQRq+d7ZMSH57RsKnW7mP0o0egK1JgY7smCRzQITK3oHNiHshq8Tb
 6pZjefoVUHEBOKdRpDWwHlrsRb6MR4DFD025d3u3Z7LjB4+vFpQZ+F9MVZHhiHP36yIiX0Ytcfx
 FQSODqGfbJJelKlb/1HHwQwAPqN4BJxklDr5yh1DhvWR2aP+3adCiUTVf8vZEI8KSx4CwoGer0k
 aFgSf7BG1FhVN7uuxsmCwfLgbLTu1go9ZcSv+6PLoGbt9//TEYPRCrz90Pxmx7bXphKx7wEO54P
 fUy2g=
X-Received: by 2002:a05:620a:489b:b0:8c6:e2a7:ad1c with SMTP id
 af79cd13be357-8d41b2e38bbmr1763512485a.5.1775559399148; 
 Tue, 07 Apr 2026 03:56:39 -0700 (PDT)
X-Received: by 2002:a05:620a:489b:b0:8c6:e2a7:ad1c with SMTP id
 af79cd13be357-8d41b2e38bbmr1763509385a.5.1775559398584; 
 Tue, 07 Apr 2026 03:56:38 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-66e033a7800sm4257700a12.18.2026.04.07.03.56.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 03:56:37 -0700 (PDT)
Message-ID: <6149513e-2c0f-4f01-a467-b4a213d65609@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 12:56:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] clk: qcom: gdsc: Add custom disable callback for GX
 GDSC
To: Taniya Das <taniya.das@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
 Imran Shaik <imran.shaik@oss.qualcomm.com>,
 Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
References: <20260407-gfx-clk-fixes-v1-0-4bb5583a5054@oss.qualcomm.com>
 <20260407-gfx-clk-fixes-v1-1-4bb5583a5054@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260407-gfx-clk-fixes-v1-1-4bb5583a5054@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEwMiBTYWx0ZWRfX8KoffbPWVpL8
 tf27/7M+Whh8nCxhpyToTj6x9ztUm0JQwLhJitzIBra/j1l5pJ5KAGiLH3bgfIyqxJHSrgCJFdB
 JoQ5xhR777ASn72RzzhdWniiaiuHF87+G0FWggUHu5vECy++YevMquvmYcajQ/yySIpctUwcckR
 aulJBTED9wszrMm3lx/prXS9f7TMnBdXEq9nx9bxBL5ZMKqBqgbfOcL/NtTBusPmNoUqyV9Ht35
 kFGdQGP0LvapSG4M4TK6RO3bHbdum90dxnRmT2qvP4x9lU/BHmYWCbqWZtK9H/afP3A7ryLeZeu
 Q4RxBz2nsJvbnDTVy/WDLpUhtVCNpLz3W1gUtHDkox7NSvQBNddF2mkI18Tz1oYeI54qGJJCtIs
 SALJ/AFHT6G8qLOmZ3oDdKraqcJGzKstizU3a/+THoaLAHOnmQ4xekYKjTyZ1PeSwYVT3Y1JQE9
 l5O/+vXcg+sopP/WtGQ==
X-Proofpoint-GUID: 1vEDliX6bluS8fq6k7LsNdT50Wcq9uOd
X-Authority-Analysis: v=2.4 cv=XPUAjwhE c=1 sm=1 tr=0 ts=69d4e2e7 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=ZW6dt3tIyA_XQ_bais0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: 1vEDliX6bluS8fq6k7LsNdT50Wcq9uOd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070102
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

On 4/7/26 11:30 AM, Taniya Das wrote:
> From: Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
> 
> The GX GDSC is a special power domain that should only be disabled
> by OS during GMU recovery. In all other scenarios, the GMU firmware
> is responsible for handling its disable sequence, and OS must not
> interfere.
> 
> During the resume_noirq() phase of system resume, the GenPD framework
> enables all power domains and later disables them in the complete()
> phase if there are no active votes from OS. This behavior can
> incorrectly disable the GX GDSC while the GMU firmware is still using
> it.
> 
> To prevent this, implement a custom disable callback for GX GDSC that
> relies on GenPD’s synced_poweroff flag. The GMU driver sets this flag
> only during recovery, allowing OS to explicitly disable GX GDSC in
> hardware in that case. In all other situations, the disable callback
> will avoid touching GX GDSC hardware.
> 
> Signed-off-by: Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/gdsc.c | 22 ++++++++++++++++++++++
>  drivers/clk/qcom/gdsc.h |  1 +
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> index 95aa071202455421d818171d04f95d15e2b581fa..ab5d741a2e2351bfac06a6814c5a8ba7355bc8bc 100644
> --- a/drivers/clk/qcom/gdsc.c
> +++ b/drivers/clk/qcom/gdsc.c
> @@ -675,3 +675,25 @@ int gdsc_gx_do_nothing_enable(struct generic_pm_domain *domain)
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(gdsc_gx_do_nothing_enable);
> +
> +/*
> + * GX GDSC is a special power domain. Normally, its disable sequence
> + * is managed by the GMU firmware, and high level OS must not attempt

nit: "and high level OS must not attempt" -> "and the OS must not attempt"


> + * to disable it. The only exception is during GMU recovery, where the
> + * GMU driver can set GenPD’s synced_poweroff flag to allow explicitly
> + * disable GX GDSC in hardware.
> + */
> +int gdsc_gx_disable(struct generic_pm_domain *domain)
> +{
> +	struct gdsc *sc = domain_to_gdsc(domain);
> +
> +	if (domain->synced_poweroff)
> +		return gdsc_disable(domain);

Can we use this version to replace gdsc_gx_do_nothing_enable() too?

Konrad
