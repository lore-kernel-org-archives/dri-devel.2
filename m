Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99BB6CC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 14:49:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AA9A112388;
	Thu, 15 Oct 2026 14:49:20 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C36D1123A9
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 14:49:10 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FAPti01596357
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 14:49:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0ieEJs/BWB4adN/CPzHmGs4+przVlyrjuLYc8uLfGhQ=; b=oMRaOIGh/vAinRbc
 IIWDc0kEgaACGgan4xoD6xDYDPm+RzNyOkkz7TM51hbBKbOjQb1ILunCf5VbMU27
 sN3FAVVmoaU2fOFriiMN9P8xIiwH1+4Y9aS5wKiivJnqDP4DCqna4Y5DFSeFwBrE
 DDap1AqxDjV7beRhj3x3TKUxJ69iCO5SlSeOdmwmwMuVvw0cv3bQpv8TsFzegaob
 0EeooP4PM2j4QnWeyPeHEgONSvsfeoTRusutVcLXzc+1W/e92f2IXJOdiPMA4RfB
 ieflyfGRnweFPpXbDoSXHKTShXQqHER1p6oR3LMDFxUOKwLoS5VGPpNLM0ld1lx/
 U2iKzw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haw2v91pe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 14:49:09 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93edac58b24so79137885a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 07:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792075748; x=1792680548;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0ieEJs/BWB4adN/CPzHmGs4+przVlyrjuLYc8uLfGhQ=;
 b=Any0zTJfn5mve/eqSE/aZyLIUwAiKcoNVEgifWz4T3oyntJNgSfPFRc1c5T+m4Qiq+
 opWGtTrHQEv4n4iLMjWhf1rYPd/W9DSFKs9c84wB5mT1+A+u757zwD1AHgMCjvGtTWpf
 vfuXTDaR7GtOCT3diTKNrLvsCbSPeupgpjV5xkp7sKCwqfuU7twZ25j58V3afRPsFzYq
 NMkdBa8+KPMDCV2wr6S+qgBZmK/4e8Jsd5bD91tlPu+SJZ/pdYTKhCAjnPwfY6UsFoPS
 B0kYlCHL4yjeMzpKNTTiG9yw2O2jbFqBjK8Py4Qdgc+QcmPm09fABNTVM0rIhm1E1C5k
 ooCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792075748; x=1792680548;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0ieEJs/BWB4adN/CPzHmGs4+przVlyrjuLYc8uLfGhQ=;
 b=wZ924uOV68w/VEUKNx9j2JsmJ85lC+2PEN2+4jzYmU80uVLVtTq/6nXXy1gabRVwYz
 KT0ftAMBNbDZD4skuirHg8uRYp8BohhJEMTTGcTvpyRCJ/RIxmGMejABZj9wNHyDLl8K
 eZ9BlrfB5oK2NdyShjPlxFvs4otnXxHCb5z7uSGvYQzB2fX/IfhWMNPcldcNJFjwlvm+
 v1GzNukc3tanb+RZdpot6rhWRfWsfemXeZp4jNmhbETbcLpSZyJkt+O9ou/lJxWgE0lv
 2CEdHyvEAf2gdtPl8PCO7qIq1Nggrm81/ud3k6MUs4NAakQ72qQuWzEBcVXaml/s9XaG
 NeVg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz7J9z4NpsmjWYJV5i6T8392GCuDKDF1wfmAJNrNZCOrZY3zCC3XCN0R/unMCusVU5UHjPs13Wqp+8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJhtYfJlMVVya5G/veD9xZIYSgVIstL8cTfSUucAsJRu7abKmVK
 c+7pJGEHvJn44VJeGsRZFdPeyVJKcL6c+uIDpTCRTzBGQvHvIa9z6rpfUPTglMD6+gN/GP1ag7G
 JydmqQiyEv6GZnyG7vsM1EG0j+iCONmJV7jdAS/RGJYBdWfcmHZi1VT4nTcVnznrNUh+7WLw=
X-Gm-Gg: AYBFou18kszYEOAjACoOhP80Kj9qh8+jUq+ytgxwuMm/wbtdeKilNKoUbeSP5TUwQ/p
 eAUdxBHUYrf36ChTAA1xZI6+6fyCGS00ZLPo28XlyqLIfC4MtAxhdXElPjC4c5WTldZuK+O42oI
 b2OVv58VcmtrLMGOX0pPuq6HRpTSFv7SrZ/uImISL+Pinin9rnO4Of3Vbt8TcyYAPG4OtHCX4jJ
 wjhozq2K72zs05f7xaInfMzUD9nM/RgN/gHhBRAqRVDfg2SHrbvb9MXEZlqPH9OUdBphZQHJcS5
 uTGIACiwIYdZ1Sq5BYOIVTiFUoBJVmBey6pQzDSfQRD8R7Q/yyeVDGOyTUm7JxK8EOa6lEa/6t4
 eayjsvLF2OIkyhexvj2t7Kg==
X-Received: by 2002:a05:620a:390c:b0:93f:a34:d9fa with SMTP id
 af79cd13be357-93f0a34dd2bmr842945285a.1.1792075747487; 
 Thu, 15 Oct 2026 07:49:07 -0700 (PDT)
X-Received: by 2002:a05:620a:390c:b0:93f:a34:d9fa with SMTP id
 af79cd13be357-93f0a34dd2bmr842938185a.1.1792075746898; 
 Thu, 15 Oct 2026 07:49:06 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3aafdefdc4asm7442501fa.30.2026.10.15.07.49.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 07:49:04 -0700 (PDT)
Message-ID: <300889d8-cb0f-4939-9b67-c60d0b1499d3@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 16:49:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] arm64: dts: qcom: Add Microsoft Surface Laptop 8th
 Edition
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Maximilian Luz
 <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
 Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
 Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
Cc: Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20261006-mahua-surface-laptop-v1-0-406fc042162a@oss.qualcomm.com>
 <179207449898.13793.6897763208667873901.b4-ty@b4>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <179207449898.13793.6897763208667873901.b4-ty@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1OCBTYWx0ZWRfX3SSMo4ZWZovF
 IP0KbRqP6Of8qlZOX76Sep9m0k3CstzhCIM1WMne0Jl7ooCQQojUto08516iJvVK02gNbPF1Pw1
 ZfLEX1l9MHcy7RXjDf9+S4FDP406Wb7UOn+wQed0yBFhLYPhDUAj18wDlEgGE+wmKuu63rNKeUf
 OhQ5+JbQEc3qrRJXPz0LpVWsA58perPVjVZZhvWQunREsANihaLRCIwYQ72DehpuHwka8Uk7pHv
 /rAeZ1Y5dnUc6Z/hCZtCrvThSxgcEWoswasfXWdVUXOCh2sGxc7uoB9UIb7ieBGQWNCe4kqBw2A
 ua1gPBkeoqmDePeH4P4cEInejKPwVC4sfJj4LnN+gGbHFx2+u6EEFVTcLxiw9im6J86Ojo/bbDu
 lOAyzaGQvF8+twiiPpFSNcOtacQ+fK0Q5YXHzvHshKNOd2saArkOgpl6Vt5d5rFkHjs2rT3b79m
 eASvGayT3IzR7b/n/ow==
X-Proofpoint-ORIG-GUID: cZM9RCkgb9LcQYdZby01ZKFcxPTWwjWQ
X-Proofpoint-GUID: cZM9RCkgb9LcQYdZby01ZKFcxPTWwjWQ
X-Authority-Analysis: v=2.4 cv=G/CJgNk5 c=1 sm=1 tr=0 ts=6ad0e7e5 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=-rt_0zctJVaUuj_7EdMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1OCBTYWx0ZWRfX15U7a0k3AuYM
 y/4lt2OlCy+IgMXIsjH2oF/tXRl5NOiWQ2GF2Y/ysKQESVqpDCV1HV9qt9OH/S2c2sQ1vN3L4sr
 5S50VzGG29Pou4jF+wmMkm/W7u2YT2w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150058
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

On 10/15/26 4:28 PM, Ilpo Järvinen wrote:
> On Tue, 06 Oct 2026 02:50:26 -0700, Gopikrishna Garmidi wrote:
> 
>> This series adds initial support for the Microsoft Surface Laptop 13.8"
>> 8th Edition. It's built on Mahua, the 12-core variant of Glymur with
>> cluster2 fused off.
>>
>> As on the Surface Laptop 7, the keyboard, fan and platform profile are
>> handled by the Surface Aggregator Module over UART. The rest of the
>> board is close to the Qualcomm reference design.
>>
>> [...]
> 
> Thank you for your contribution, it has been applied to my local
> review-ilpo-next branch. Note it will show up in the public
> platform-drivers-x86/review-ilpo-next branch only once I've pushed my
> local branch there, which might take a while.
> 
> FYI [if applicable to your patch], as per Linus' policy change, also
> fixes are mostly routed through for-next unless the fix is for a
> commit introduced in the most recent cycle or is clearly a regression
> fix.
> 
> The list of commits applied:
> [1/5] dt-bindings: arm: qcom: Document Microsoft Surface Laptop 8th Edition
>       (no commit info)
> [2/5] firmware: qcom: scm: Allow QSEECOM on Surface Laptop 8th Edition
>       (no commit info)
> [3/5] platform/surface: aggregator_registry: Add Surface Laptop 8th Edition
>       commit: e93536b1fcf775356b06ddc845461e64d4c87313
> [4/5] drm/panel-edp: Add Sharp LQ138P1JX61 (Surface Laptop 8th Ed.)
>       (no commit info)
> [5/5] arm64: dts: qcom: Add Microsoft Surface Laptop 8th Edition
>       (no commit info)

I'm hoping that's the tool acting up?

Konrad
