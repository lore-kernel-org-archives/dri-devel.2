Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D88606A337
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YwYVjH4Z;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Zun9vVlH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7647410EDDA;
	Mon,  2 Nov 2026 13:03:23 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C05910EDD7
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 13:03:12 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2D0VRu3604463
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 13:03:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rwDvCUcycop1taBMmQpXpaVGTG1WRnAIuw6p85hHgWM=; b=YwYVjH4ZysaBu8l4
 1s0nZo+iGjK+TUj4pKtuAYIgm2/oTd9cAZnCEL4/aJ3SCEY/bVs/r34GqFyhhDtp
 kE+HM4nuJAUnHGyB1n0J6SXPgq3yzYIdLSmt/DkJ+T1gC3BQsG47UfIs3rTpJOM/
 5jAQL7jqFSR/0nSwD+nc1UirHLDAlQtXcr9FWk1GfPinRIlawK7MsGKhEwfmUKSA
 dAQdl2CwFaleNszRvUFQjup3/S7IZXIVMB32ZADWZkIdtm1tNMWBpVv7KNKXSm+C
 C/KpfRer8MJDWFk9C1SwR1VPXBBjMbiiFOBvmgiq/yB2NbTHWtqUEGocwvSR6aWE
 Q2ddTg==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpka61w9t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 13:03:11 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5eab0ea26afso86472e0c.1
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 05:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793624590; x=1794229390;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rwDvCUcycop1taBMmQpXpaVGTG1WRnAIuw6p85hHgWM=;
 b=Zun9vVlHTTfgbT6NWTkZm0voMkVvmQFoRdvYQUfHPr3+oUY8fduzYBT3ZfzOOdOvnR
 sBZ5Wu3kIS/KuUZckXrxcjBts1cBNpiVDUy/AM5Y7I9zuqPu72pCfUDwqcBm5w1HkPnX
 qqhILrwHu0DuqssuE7hCr6QlVZyI/26rFdFNVZ5vJMefl5nbtnFKDx/DVyoX2vGhpRmh
 wLiBsbnKOh8X5mReSYye3OUJzTSENL3DoRz0HoI+o7p+GqOtxVVDerG02/UUoyQgrp2H
 d+nimAfzWt0XF6xMa7REbeGGvniOlvIZ4aHeYUGJDkHmAE2wZ5yBiHWkuSVaUZmSrm16
 98kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793624590; x=1794229390;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rwDvCUcycop1taBMmQpXpaVGTG1WRnAIuw6p85hHgWM=;
 b=VLjbR1jiv+p5KyMh1lG2JqlKWaDcX404CtFEMoVMmtAGpDsrXqRmRrVR0m9FEz11C1
 omXegd6bPEtgbfwtCWjqiSjXXd1qXHHMd90P/8oP4fgUAzsx+QQsUCl7oadk95ed/0g1
 3zKl3rIbrXqkqkLZ1sB6t6ZmIQ1R9csbLXWlrnhbUrC1r5lIoW8153EKF05hytRtiAww
 7I9dVsSxCVLbEu5Jb2gwZYWOpexChNYiWWKgRlu+7Lo1vs9z9CvaDDipe8K2ZSb9H/Xw
 mlLefz2hQMjcDdrlbP86/9HA9uA3HTkYxBmYNonQSvCX7wOYeFkaWBMxWafKk6BAWP1l
 ouSA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzr4eSmKxaUPefaAE1+wwyzBBYDlmHfr4I+fgKRhdKAPoild5lOCkH5PoNUCjoMp0P0/b9nsiBXWAY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/iEGr/7jEx3nXhN3uLs28weWoktE5oAILLOCbXOgYfejo64QCZ
 fOifJJX8HVmIR8T+yp6mERXfqZGFQMPXlkMUBVHq8EOMTSgD8RNwD9HQEdLbJ9Eb/W9xLsPuiM8
 PqaR37qH7DoMQ+Tw3R/CtKkQQKi5jvS4bsHpt3KGyqpm8e5ND4PhtJlZ2h0DWjV+NDz+A51w=
X-Gm-Gg: AYBFou20Hedavsu68XYvwLdSM217JiZwMn8ACcjE631c4Bwam9VAt7zI/iyzToIjfBk
 K3x4SGu/4ru71lR9Y4euKa7A9Hxk9qrJETdpbBF8jGqXsDNFe9tik1jLQTb5Hyy2QyHpos4yKUE
 jPy17DHjUakXDReDPEgTlXEzfR5u9IalqZ9wZAp7pJBOCFicLZ64kambIN2rfy95h8YCL2t8GAd
 gUVX0F5wGTnF0a+9cC2+baD9QSTz3D1ZuPqM1GxqP+eRwpLO45O4AVP1S4zkk6FddG8fcmhC/n2
 8LH2slfS07YeDFWoBqfSkr3dAtmqporCB+JXLdJsehkHXeyRFAegaDStV+tTTa9E2uC/x6ofI88
 qVcrt5R0kxvAYDBNLkJjKk/ZwLUrtVnW0aPA288pfhtlwubc4lWq8E2yXMyAmsro+QVj5b04=
X-Received: by 2002:ac5:c7c6:0:b0:5ea:d67f:fd39 with SMTP id
 71dfb90a1353d-5ec68998269mr4388748e0c.5.1793624590375; 
 Mon, 02 Nov 2026 05:03:10 -0800 (PST)
X-Received: by 2002:ac5:c7c6:0:b0:5ea:d67f:fd39 with SMTP id
 71dfb90a1353d-5ec68998269mr4388694e0c.5.1793624589652; 
 Mon, 02 Nov 2026 05:03:09 -0800 (PST)
Received: from [192.168.226.248] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfe072d19csm1698389e87.40.2026.11.02.05.03.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 05:03:08 -0800 (PST)
Message-ID: <14d63775-3024-47fa-a495-60351c31e6eb@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 14:03:03 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 09/14] drm/msm: initialize LPAC ring
To: Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org
References: <20261029-descriptive-name-lpac-upstream-v2-0-a21a5c850961@gmail.com>
 <20261029-descriptive-name-lpac-upstream-v2-9-a21a5c850961@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261029-descriptive-name-lpac-upstream-v2-9-a21a5c850961@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: PKx99mIEyVNmU5QO7R8niH19dI-GGErY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1MSBTYWx0ZWRfX+Y9pm7HXz1oV
 +4Mv2W1zfuj7c1BEPpXSKMnYb0s1VIFOpqivTyr1bql0zivo8YYUnoIIIjcp+zgwVnMMsphDIa+
 vpa5YxeSl2P00xWcXuFLVtvIzzMWAsY=
X-Authority-Analysis: v=2.4 cv=ZbyIpcVA c=1 sm=1 tr=0 ts=6ae88a0f cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=km2EZEuaMOR48S9SEsUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1MSBTYWx0ZWRfX9cXgFc7ciK7a
 wmGqGyov5Ju+gfDVNmC73vUfW8QQJiIG3R/o/b/zeTGZKYvTHtBC16Mqj6//vNiGI0dIvCSk19V
 Gy0ngD/gBvuDHz8lhWTxAXOVLpnNkfwak0E6rf5cBEA14BEepg1xNDCDToh/A3TAx3U9M5dIW6t
 wbZq6m6f2cYuNBvUCuS+SrN8FnfQ5vY9fSriuT3tShqDp8ZFUI9XOBEwb6czDxrI01Id1AYC4UF
 wSWbhezD7K9OOfh3wmwDJm8QfB+54/GpG0bNSHUWwHH9aDQGCufB+byIMygjQ9iOXF47Bk0/Pxj
 KH9Jl++cADVSOUJKkOliQ3QAmwXyRFTrQPr3trHzRwlz/7Z3wENVJE6EPA5RW7VadI2oCxFwJhN
 Wr36ocGU7yOajqqUa+ynUu4hoXJSPGg3A8aEd+V2LXMK0YgqM3cch65EW8bkLCmjngUrroU+HgF
 33vMFyszDkfyjeJS6hQ==
X-Proofpoint-GUID: PKx99mIEyVNmU5QO7R8niH19dI-GGErY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-11-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020051
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/26 2:52 PM, Anna Maniscalco wrote:
> Program all the register needed to start up LPAC and send initialization
> sequence.
> 
> Additionally, now that the LPAC ring is live, make the code aware of it.
> 
> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
> ---

[...]

> +	/* *Don't* send a power up reg list for concurrent binning (TODO) */

Here's what my robot came up with

human tldr: missing the listed registers from a750_ifpc_reglist_regs[]
and a7xx_pwrup_reglist_regs[]

LLM:

The strongest IFPC-specific suspect is that LPAC setup is not
fully restored after IFPC. The series enables LPAC on gen70900
(Adreno 750), which already has ADRENO_QUIRK_IFPC. When LPAC is active,
patch 09 programs several GX registers in hw_init(), but adds only
CP_LPAC_PROTECT_CNTL to the A750 IFPC restore list.

The missing registers are:
- UCHE_DEBUG_CNTL_1 (bit 30)
- CP_LPAC_CHICKEN_DBG
- SP_CHICKEN_BITS_2
- SP_LPAC_CHICKEN_BITS_2

A likely fix is to include those LPAC registers in the A750 IFPC
restore list and the applicable general power-up list, so their
initialized values survive collapse. The KGSL code in this checkout
has a similar pattern: it conditionally adds LPAC chicken-bit registers
to the Gen7 IFPC list when LPAC is enabled (adreno_gen7.c:652–660).

Konrad
