Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E92FF5136
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:26:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F2AB10E4AD;
	Tue,  7 Apr 2026 19:26:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KjaywABU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MT1C2XaY";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9322610E4AD
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 19:26:33 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637Cjp7B3402384
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Apr 2026 19:26:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YRe1tFw6XshCfPqTzjTwur7/G8T/aZXCtfVRsh0nIPM=; b=KjaywABU+41cTPa7
 X5HNq5QmgiW0tMqZpEXO2cUYhZtmgXtxdDUzizKUwWv5LTW5IWH0S+07V61cY1a7
 yC6uGZXAXsUQ6XH+5isKbN9BYYeVpklweLxIgTpnVo+le0TRDYO9HmEQ3ccsnRf0
 o6OT79kObbX+AwLWNF1hj6WV0uxrLTwvaLzb71PbNWEVIQqApBHmFd3Nhl3Xl5St
 fxTJ1FklMA70Vg7IOq4+aaSk2uoSuXPSc97dvsZz8lkAfZE6b3G4YFCEylRqgK5k
 PWeKftUe4fXTCjvIETK8qrBGJ2dijGPTvW2ONLbOy2QChK47K5cxWlkOAceXikoQ
 0ON0Wg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrhvaj2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 19:26:32 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b23af7d7e8so151156315ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 12:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775589991; x=1776194791;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YRe1tFw6XshCfPqTzjTwur7/G8T/aZXCtfVRsh0nIPM=;
 b=MT1C2XaYeUtbXYw2ndvPXmHh0Hgq1RRfSkYEdZvDUK7rOmyXrUdtITLegVx6zgRpxH
 3AiipUeSw7KlHZgX1EZIAtyB+Mf1W38M20Xp7UmoRNmbuFAiPpcTOmGwy5pQcHaE8n4W
 Ztp6jD61yDt/0eObCcC1HJSaRRo/cj6PjQ1+ZIRw9Xy3jmTmEF+klB+Ty9x0CYmBxfgg
 mwUvr3yxwp2pUNkjpIf4/cpyujtm2N1nqK7mZm39NlZ+smPFQo5/lRxMyqgf1UXhYI85
 2SRB6LIVSUkR6ehPMV0NRRtaluoWoCeJS0SwdMszF9ib3EgT6Pov+ca9NHRGRzcOCFdb
 oyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775589991; x=1776194791;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YRe1tFw6XshCfPqTzjTwur7/G8T/aZXCtfVRsh0nIPM=;
 b=X6bRoabswbPw5T+rZqv6aJq4t/u534Coy/W+G7UCFl0TT4GcAQlbShAqCdwOYQRdFm
 d3IY3M2cTrHw0GUVxd9tSh78ss863yXYXKxeBTaNwSUHI140sB4qfCsoAdwDrJF3JYvR
 QgLyp8ZZdqkHhIgtuNfTLIetIP+c2+E1hPooAQospCAZGM9w8tKQhgVq0nf9RB0GrSoi
 KokkEEAgPe4aavlMWupl/P3RkiPAm+6gz5DuGNn6YqZG2JP+4QeCu/T5wd+VvzS5LaMo
 DsyiffZTE6oTMKUsTpFF6DkAacc+GwNUFLKoqgu0JSeTIje0DXyZg8KC8w00sxRXAVFH
 WqYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXo2LNU7NbFcH64lzuKqg8WFdCRDqGurtD5kdW4zcnptHvT5wviLmCZum1pTS6PqqM8xT2lrh0JYxk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzVKXkw+JPGgO7L2weDqdXWoDjEROxFfEWsqdUm98nWL958p5Sn
 hkp87BXXD3RuVxZRMBzTeeNtMd4OWBXVxjBU+tYodQnEfQuxVYH+8mlPKFbUwXD8sBaftr1ihLR
 fYwL5n7xkQEkqZMubkY84JOzS2JLcoVIQmYaT3be6KRRfL6c0kVnDk2Gg7CKTSns5+DtU8izG6O
 PF2l4=
X-Gm-Gg: AeBDievV+9u0uXbQfTePcvEny4YvqV2r+jnMLcB5f0WTpOZTQdnFli23H6kbStkIa/p
 l5tNKVWo7rnoAFCZdpLl2NqGlWDJWDNy9EOwu4cECYNSHaSyddao2RuAhgu9aPHYYQIvKodMAk4
 b0oI+SxgrbpI1WWqdS8pdINThY4kjhi667rTVG47Vz0PFPpTEuapRw0R7oZVLCtaqakeZyBDLdN
 fULzXNDA153IiQJiEJf3QWzv5wNY/FDVaQ+PlxPsNCqUh2AAT6Ek+b9BOIjDC3/mO9JSEal4TzU
 fL6jcx0uJt4WxRgnw9bJw7g6jRXVX7E9V2P4E3m+jg7PeKioSFOl9P1ZtYqh5otWDHr5w/V+nNn
 43P4TlHWq1vOK+OmCjSikl87bTW4IgjU7Chr2Sey5bJbh4Q==
X-Received: by 2002:a17:903:2c05:b0:2b2:5840:809c with SMTP id
 d9443c01a7336-2b281828136mr193199795ad.1.1775589991101; 
 Tue, 07 Apr 2026 12:26:31 -0700 (PDT)
X-Received: by 2002:a17:903:2c05:b0:2b2:5840:809c with SMTP id
 d9443c01a7336-2b281828136mr193199525ad.1.1775589990639; 
 Tue, 07 Apr 2026 12:26:30 -0700 (PDT)
Received: from [192.168.1.8] ([106.222.229.237])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27478b658sm194467505ad.31.2026.04.07.12.26.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 12:26:30 -0700 (PDT)
Message-ID: <6ca53b3e-bad7-44ea-8bbf-d35514262b7c@oss.qualcomm.com>
Date: Wed, 8 Apr 2026 00:56:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 0/6] Add support for Adreno 810 GPU
To: Alexander Koskovich <akoskovich@pm.me>
Cc: Luca Weiss <luca.weiss@fairphone.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>
References: <20260402-adreno-810-v2-0-ce337ca87a9e@pm.me>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260402-adreno-810-v2-0-ce337ca87a9e@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE3NiBTYWx0ZWRfXwpdejKYDge2y
 aaJV/AbYvTBmTo1dq5gMJ8Fz/5PCjaik/ke5ZFWgOYCBa+HZteWfSMIKkp+pwrGGVtwwbQChWIz
 OtKmfwALDy5Kbhpo7m31ynjOw86ntabyVtEWVe3cBtAEQGp6vCHAWBda3h1wrRAbh50i5h7ME99
 mamJN+NzHz5L1vcXKfhv/YaWfLtdCjAk2C9oaF2Po9mMGj7LikXUaBjAzSej0SzcZRlSAWBVPDl
 ncJYDQrsNHJSfJaX/NobJPUdy9AgSVk2fbJ+YfimOjxCu0v5M/LYkHon6oaYfH9w42jam7OCdlG
 4Xe0x4ttNhNzzNSfDEIl/nG5gpFvnl+TftHldL404ezUSod6zkYqgdpZ+Q5/KrRyQ7KCCsh/Fli
 cPEqRFR5SbksjswkxZ2awfYFiIvCtIA+MnaCSFqLLeam9QwQdK8v/w9iw1nqW0jmYc7vd3nXjs1
 prRhRPcUdbnd2527seg==
X-Proofpoint-GUID: go5F1_kDBvIWxVm3buGg1wH7eWykU90G
X-Authority-Analysis: v=2.4 cv=XPUAjwhE c=1 sm=1 tr=0 ts=69d55a68 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=oIjhDLspr5RTlLLUpj0f1A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=6H0WHjuAAAAA:8 a=6HAHnblGeAPFfXcocwYA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-ORIG-GUID: go5F1_kDBvIWxVm3buGg1wH7eWykU90G
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

On 4/3/2026 4:38 AM, Alexander Koskovich wrote:
> Adreno 810 is present in the Milos SoC and is the first GPU to be released in
> the A8x family.
> 
> Note that the OPP table is limited to 1050MHz to start with as the only Milos
> device I have is limited to that speed in GPU_CC_FREQ_LIMIT_VAL.
> 
> This series is marked as RFC because it depends on a couple other in review
> series, batch 2 for A8x [1] and the GXCLKCTL block for Milos [2].
> 
> There is also currently an issue on Milos with gx_clkctl_gx_gdsc being stuck on
> during runtime PM [3]. The proper fix is to only toggle the GX GDSC during GMU
> recovery, as the firmware manages it in all other cases. This is the same issue
> seen on SM8750 and is being worked on by Qualcomm. Right now I am just working
> around this locally by not collapsing the GX GDSC during runtime suspend.

This fix is posted here:
https://lore.kernel.org/lkml/20260407-gfx-clk-fixes-v1-0-4bb5583a5054@oss.qualcomm.com/

Please mark you series as dependent on this.

-Akhil

> 
> [1]: https://lore.kernel.org/linux-arm-msm/20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com
> [2]: https://lore.kernel.org/linux-arm-msm/20260306-milos-gxclkctl-v1-0-00b09ee159a7@fairphone.com
> [3]: https://lore.kernel.org/linux-arm-msm/5409e13e-280c-47b6-a29f-351cb609bc6f@oss.qualcomm.com
> 
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---
> Changes in v2:
> - Mark as RFC due to dependency on in-review changes
> - Explain in DTS commit why qcom,kaanapali-gxclkctl.h and not qcom,milos-gxclkctl.h
> - cx_mmio -> cx_misc_mmio
> - Sync a810_nonctxt_regs with GRAPHICS.LA.14.0.r5-03100-lanai.0
> - Link to v1: https://lore.kernel.org/r/20260331-adreno-810-v1-0-725801dbb12b@pm.me
> 
> ---
> Alexander Koskovich (6):
>       dt-bindings: display/msm/gmu: Document Adreno 810 GMU
>       drm/msm/adreno: rename llc_mmio to cx_misc_mmio
>       drm/msm/adreno: set cx_misc_mmio regardless of if platform has LLCC
>       drm/msm/a8xx: use pipe protect slot 15 for last-span-unbound feature
>       drm/msm/adreno: add Adreno 810 GPU support
>       arm64: dts: qcom: milos: Add Adreno 810 GPU and GMU nodes
> 
>  .../devicetree/bindings/display/msm/gmu.yaml       |  32 +++
>  arch/arm64/boot/dts/qcom/milos.dtsi                | 148 +++++++++++
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c          | 271 +++++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |   8 +-
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |  44 ++--
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h              |  14 +-
>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c              |  11 +-
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h            |   5 +
>  8 files changed, 493 insertions(+), 40 deletions(-)
> ---
> base-commit: 128d2eccd20bd74fd104b412d949d869aa48f108
> change-id: 20260330-adreno-810-5a47525522cd
> 
> Best regards,

