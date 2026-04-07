Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D658FF5136
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:22:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B982710E4AB;
	Tue,  7 Apr 2026 19:22:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xz6iU7x7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GOfvExLx";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D6B610E4A7
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 19:22:44 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637Con2k3402629
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Apr 2026 19:22:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 C687xfLoeQteSwkKvA8QRz6JT8hljSA+LtUOYoNV2ew=; b=Xz6iU7x7Mm+f+JZR
 vzAvYj8qZSGTgM0Fp/XB/3GSWPWNIa3HJVQP4PKrWxYEEIxHcssuDItIsZxIKFe4
 IHltDXSRqCutXgXCAfB/O025ZiUWik0P9peLu5I3eU777y8U2W6xfCnAOusGq2Vg
 zCbvqltzNCSTF0ts8QkvmyHOBBn2VsZ9P0Q1Zu63rVETQuKIzpsP/7MtHwjgG9Bv
 AFhnWpXt0xT38UcrOiuLPoUFR2bLNQkJ+r27DmqO1/PmmaDnnDkvf9W5VqdOhy72
 3vNbd/mwzSzxNo0ICX1T3dWt4p8Kb0Mhw25BAImiccPGAgN3XePargDUFZ8xCx0t
 GIpv1g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrhva5r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 19:22:43 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b242cbb97aso43472615ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 12:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775589762; x=1776194562;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C687xfLoeQteSwkKvA8QRz6JT8hljSA+LtUOYoNV2ew=;
 b=GOfvExLxqreu5nCXBW5+hHzuy8HJi8WaKRVB/gatcYtoD68GUff1xiQuXD+lLwFP0O
 rCKi+omrVTT+Gg1fD/dilmURc6wCcFYHZxj3yzVDD/mM8LZyFJ+/wV+gwiAzbnO4Qlhf
 C5JlEp+Ppk84PRzgWWF/xSR1qX3RCnUupSVoERNLzwQwiT6HeHQUsKo0hWQKLDxNoPMJ
 avcOqu5T1DaK87X5HJnn/3+rZIYnNccUzOzLa5iOd22gEOS6NiH79GWCMPh7LaoIR69t
 zfpA5eScm1GJIJYHh+3apagei+N5ahPk9EpxQYWzRGZeosgzsqlLm1VBYG2NRmYBMZWo
 ensg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775589762; x=1776194562;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C687xfLoeQteSwkKvA8QRz6JT8hljSA+LtUOYoNV2ew=;
 b=q6wWjGhrXJIRh3hNH3GvqB6IJTFtFIms+ETmeOTfmR1pSela1ttMpZXhSkCuEP9YvD
 N5I9HixsMPdOcs2Aq6d+5F/ivFPzvSbRKfakzGPSEQ+pyJvwJ/daGfhb7EjbIAeeFcBW
 umCGsMvyfERfQMyjhcC1TUIqh6BbxMIqrBm7+fa2dDHS25xQRfdOEikRVtLBEp5PC4rM
 LdbndqXitVmsH2T024hUS++ib9VMexRJuhGChkgTn3HB3ofrSXDI8heNsmLzsE84Xiy/
 3FN8dETXKM7yJruswwU4wUcLrDLkKJXC7gpQ6E2tF/uTOJBVTs6Lxq6VF+1kiRlxiZMq
 unZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeOwk9oB3aBD6mCHXn/Uv0zjBWEH3+VgQgy1cR48Y8Y5AYK1ZfHtvB6doAek/d+SfenZ1DzHK4u3Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxSOOWDFt7fZka54qVhHtuDmMk0HaWR8GrnRQwHRz1PQz4ajKcS
 uBEPPsjIR/7ynw4Y+Kg4CNgv2s9ZrekreloXmsjoFDk6mlGvQ8nxLKvMeRbvtVs/Cbv2Nkzj4P0
 zZ/6kNT4gTTEJH/r+UFVFrqChyLzAU1mArkgE6opL5d6rAlwIfPd6u7jsSNzE8xGZ/Om7Jew=
X-Gm-Gg: AeBDieubv3GSe/+zIfPmD8i2ETe9w9bE1XowSSyCOFW+N5u5regblaAw2Mf7vW+9wqv
 p7U3B0cXR4SjuMDTi+OV/upKDxpqwMlXqJYfdIJP/SKrDeMdRcnYodLfX3fBvLg54QDcff14qWf
 gAwQ00iqku34Dew9HhVas3fzO7sukaGcqq5A6Ot3l+XLFUz8dy0DrBfmuhBHkbibzHV1ji5p9Bi
 fPovUAZMOi54uEQ1LzExPE3lz5T5LtCqCqb6Pj3I/xOFUf25Gm44UppZtF7Pw0aQcYdLC1Hmdwm
 JsteOOfgp/IZsEnKJa9gy5sTSP7X9uy8CpatiEFBZMuBBE64KAiw1SS30s/0V2hKZTC/eoFPZST
 zyYLZ+89IVyMgrsIaSFxeGe9sYpgZbm5iu5XRAOvPxtQPGw==
X-Received: by 2002:a17:903:1b4c:b0:2b2:420a:b48a with SMTP id
 d9443c01a7336-2b28182c458mr187169885ad.32.1775589761430; 
 Tue, 07 Apr 2026 12:22:41 -0700 (PDT)
X-Received: by 2002:a17:903:1b4c:b0:2b2:420a:b48a with SMTP id
 d9443c01a7336-2b28182c458mr187169615ad.32.1775589760938; 
 Tue, 07 Apr 2026 12:22:40 -0700 (PDT)
Received: from [192.168.1.8] ([106.222.229.237])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749a3a0fsm238836465ad.59.2026.04.07.12.22.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 12:22:40 -0700 (PDT)
Message-ID: <948dbae1-0d12-423f-9b4d-c28e844d8fd2@oss.qualcomm.com>
Date: Wed, 8 Apr 2026 00:52:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/4] Devicetree support for Glymur GPU
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
 freedreno@lists.freedesktop.org, Rajendra Nayak <quic_rjendra@quicinc.com>,
 Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>
References: <20260405-glymur-gpu-dt-v1-0-2135eb11c562@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260405-glymur-gpu-dt-v1-0-2135eb11c562@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE3NiBTYWx0ZWRfXzNvLZ0i02pgw
 4ALzBOjhqqPzsuAFIHrYIk94yseiynFNCLdTKGVNPSJOT3i5OJap4ITibHWJXU1F9nsDPHgBJbc
 ia/9bLTuB1UkRVTwZ6ubn7sR8xBpwcqDqcOJ7u/meH/Y6KBD406d80PlPARNxqG7DE3qhD+9/Hu
 2UMvijcbraXQ1ULaJphRdeUsVhVvoItBX5Dkhp/RIVjXdBqWMacDLUE3wLicZ6ldjSsUuvJFbdJ
 /eqbBV2eA2CeyMTCzgo5Wy6/yiJMuybDv2in0wEDTt6kFRvLCsitUaaRE8i5wQGxdLQDGfdqcm0
 OyLzv2th1PkyWmhJsrt8GT5ZYg15YrxWTcX9SbAKHQDyD/B38MLLHp/HXGiKkYTPnKtfR7HIL5M
 jj7WU22E+Ijrw0/M8UnwATq+JgC7kBI56wcjA9u+8x5pYINJHofb2oFl97GTdhRdi1ciCM6tGS3
 IvBManD641tObdc1wKg==
X-Proofpoint-GUID: EwXSiA1WdDOtKE955XGB_YoeKLM2z5gX
X-Authority-Analysis: v=2.4 cv=XPUAjwhE c=1 sm=1 tr=0 ts=69d55983 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=oIjhDLspr5RTlLLUpj0f1A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=4ZsNYdiHAHguiUsAXTsA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: EwXSiA1WdDOtKE955XGB_YoeKLM2z5gX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_04,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070176
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

On 4/5/2026 2:33 AM, Akhil P Oommen wrote:
> This series adds the necessary Device Tree bits to enable GPU support
> on the Glymur-based CRD devices. The Adreno X2-85 GPU present in Glymur
> chipsets is based on the new Adreno A8x family of GPUs. It features a new
> slice architecture with 4 slices, significantly higher bandwidth
> throughput compared to mobile counterparts, raytracing support, and the
> highest GPU Fmax seen so far on an Adreno GPU (1850 Mhz), among other
> improvements.
> 
> This series includes patches that add GPU SMMU, GPU/GMU support, and a
> patch to enable the GPU/GMU nodes on the CRD. Keen-eyed readers may
> notice that the secure firmware property is missing. This is
> intentional: The Glymur-based laptop platforms generally allow booting
> Linux at EL2 (yay!), which means the zap firmware not required here.
> 
> The series is marked as RFC because an update is required in the
> gxclkctl/drm drivers to properly support the IFPC feature across all A8x
> GPUs. We plan to post a separate series shortly to address this. I prefer
> to merge the DT series after that series is acked, so that we retain the
> flexibility adjust the DT bindings if needed.

Taniya has posted it here:
https://lore.kernel.org/lkml/20260407-gfx-clk-fixes-v1-0-4bb5583a5054@oss.qualcomm.com/

-Akhil

> 
> This series is only compile tested on linux-next. But I have cherry-picked
> and verified the functionality on a downstream tree which is pretty close
> to upstream. Also, there is a dtb-check error for the adreno smmu node. I
> will fix that in the next revision.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
> Akhil P Oommen (3):
>       dt-bindings: display/msm: gpu: Document Adreno X2-185
>       arm64: dts: qcom: Add GPU support for Glymur
>       arm64: dts: qcom: Enable GPU & GMU on Glymur CRD
> 
> Rajendra Nayak (1):
>       arm64: dts: qcom: glymur: Add GPU smmu node
> 
>  .../devicetree/bindings/display/msm/gpu.yaml       |   1 +
>  arch/arm64/boot/dts/qcom/glymur-crd.dts            |   8 +
>  arch/arm64/boot/dts/qcom/glymur.dtsi               | 234 +++++++++++++++++++++
>  3 files changed, 243 insertions(+)
> ---
> base-commit: 83acad05dee54a5cff0c98dd7962e55d4c6b145a
> change-id: 20260226-glymur-gpu-dt-339e5092606b
> prerequisite-message-id: <20260303-glymur_mmcc_dt_config_v2-v2-0-da9ded08c26f@oss.qualcomm.com>
> prerequisite-patch-id: a1fb5b7ee94995a24f6e96d1d2524e710d3a7e60
> prerequisite-patch-id: 56c830b7718129323b006e492aed9822d7c30079
> 
> Best regards,

