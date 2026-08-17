Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2217BC5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:02:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FCC410E77C;
	Mon, 17 Aug 2026 12:02:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IMsL01fd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HZUPm89R";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1030F10E776
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 12:02:05 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67H9dege1058335
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 12:02:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MeHZMvZOZuAxwsZ8n+gIZCO62QIfIjRdAX5vebKCDRI=; b=IMsL01fd1SOeHKF0
 S3GR7oxPotWqqw6ru0woMEysrngTVRhVfIG/sC6L2u6gkJgiivkOHOc98u7t8lsi
 wopHDQCuLGkCszqW9MarlNbefePw6zZZNseFFfiHGm5k9RzYVySDW6tgLmAh/5g0
 IvPzhhYnbxnC4MWY4rl4Jr8uUQDz1Nmvpik7OeY9RzI7FllxSHF1bY905TpubMhO
 L9wpkSUwHsYeBs2rTMU5eRx7WwZTRRTnEnaa99gg1niiqcZ9R/h7MkJ1N12Q9hec
 Ho81FJhvv99UkQGavDVQyfV/gZGN9zVkbnYAB9GvRLWPcu5K609rFFquo4QkcLJb
 Jq23tA==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3x30gxje-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 12:02:04 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-977a63277c7so33308241.1
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 05:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786968123; x=1787572923;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MeHZMvZOZuAxwsZ8n+gIZCO62QIfIjRdAX5vebKCDRI=;
 b=HZUPm89RNt74lXElNcBkja0w52P1qZaIeiViHjJpP2jTeUxVBQDKixaNE+37JfVYqW
 lrGvZudH6vrvbqeS1sEFztdyCEZzg/yQTcDkrG+ux/EhoIhxQQS+BTlQyPBkd7USQEee
 QfSXMtBGO63KpC8s9KnPSSosy8vvXq4W/zdBvdfSDqNddh5rPJn/oT7ETOT+ZROLh8CB
 xujDp6ny0o9fB1OvypBPVnQyf3EBdvinULWTTfPQaTzQBIKirgg3PItxCL6Zm4cAG28a
 ihZgqSwiuO1g3UsS/xDRJLMa5wVN4SulZvAf7aVrie6Tg2L+GsXxQwaa1R1KGhbFP+Rc
 2pZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786968123; x=1787572923;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MeHZMvZOZuAxwsZ8n+gIZCO62QIfIjRdAX5vebKCDRI=;
 b=HdKJowGBfnKh6Fo5l8cAHhzxyO4nn02uwKHeEFfMuVVQWaDnF/X6dH87uE8Zmp8f+8
 6BzVtg40hOI0MoPmE1LoiK3iHZbu9VWxEdHPjvXdY13xZRHRSDQyPMFHtzKcuv3fQtub
 Y3uMc+NLhYPIBF+ctKTGFOiBJoJT5lcYUkXvrd1Jx4DGdHJx0T04fbCaD+qLYyBtO67h
 0tylP2bABH3SX9R9G79QnvI9F6KoXaz64oxQIE6lY+Ftp5W+J5fvJGYhTwZOQarTtfPl
 lDkmNwjHH7c+I6rN6hlYArMZGLcP9aB0oXDQpJthg301HOwxFkQ/Pe27EVQpIId2u+ka
 KKHw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqNTZxr6mxVoZ6ljWfUoj9BhFU7kfa4UnI6C9K5skY5O9ZEkUA1XbDZJJoYgeo4BBZ+AwXFxP8AXYg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzHy6lAn0MQWTb58TB3PKXoDFkQFjuIdfP1GL6rcnx8E5NBDvk3
 +K/71z8Dcw+pBDY8MXT4lso/cGSI9jEJxWHB+mOPHvjKcgLS99KHQlpJBjWVGMxQEKZbX0KD232
 jzuboRGaHGUMAvIoF7gxIYEILETbQTLeIVjy6jnfgjRpt7qx1ng/7UXW0zQRddqGdMNujZEk=
X-Gm-Gg: AR+sD13IlCPqCNbrl/RpuidpizL8/PdaxCGoXvZQShl3PePhYowkOMLyC3rVTjO4Trn
 dh9ea+fKGCMus/ZUR7KM0aHh05F/eLPjb6hNF9CSS+TDQ5cr5jKMXkFAxzTQHjI/e8ydNyKjNdp
 Ge0KtQAKlau+NYNKBilsDq5L5WPLUNGt2fe9YKf4y6Rm5gBLLTkqoeTo3zD1sicaVWV4aFkq6YI
 iokf37LddeZRz+DRgXIuqKKYvvR95K6bi+jsPWn2LkPfo7saxBZzqiSJEkPylwewgFs5+NHfOyg
 G3D5erKi6Te0Adh2roo6cBcrRfLJTqmmKnQZNwNckGzWu6+FP3fo3gm0A0W8FZqBvcbdz2Vv+PP
 ClPM0SbHeeH5UxCiDdEEVO6As
X-Received: by 2002:a05:6102:3748:b0:739:b6bf:bc9e with SMTP id
 ada2fe7eead31-76f2cf64f8bmr1309029137.3.1786968123171; 
 Mon, 17 Aug 2026 05:02:03 -0700 (PDT)
X-Received: by 2002:a05:6102:3748:b0:739:b6bf:bc9e with SMTP id
 ada2fe7eead31-76f2cf64f8bmr1308970137.3.1786968122518; 
 Mon, 17 Aug 2026 05:02:02 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2185b97aa1sm12677966b.46.2026.08.17.05.01.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 05:02:01 -0700 (PDT)
Message-ID: <5e8e6701-ddfe-458e-ae08-2d8810816320@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 14:01:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] arm64: dts: qcom: sm8750: Add GPU cooling
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
References: <20260809-pakala-gpu-v1-0-207ad1fac1c7@oss.qualcomm.com>
 <20260809-pakala-gpu-v1-4-207ad1fac1c7@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260809-pakala-gpu-v1-4-207ad1fac1c7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA5MSBTYWx0ZWRfX1GbD7i051Jdr
 pXG1dNOaeBxjHLmR6HCSh66iTENHmQuKt09vJmh65A2hcwJunISy2Mz2qIhaic79eelFC3L8/Rc
 IPCN/1y6bVSf1HfpmlslDKWI6aGWdqhoZXwU5HcMUSXjDmvAlBr0hcjPYzL0V/bCfXpPbtD54Re
 bZX99GRWU0B6OaN1mm9BO0iNnN/PbvHcWDjmrHrKSZSrnB++CYgtrJPYL0DrWtt0oHyM51IpGUS
 7jOAEq4ib7zcglzkXTUj0dHkr5AL4Dt2ukRj2b+xHxfiAKOYdHkY7kkNNKIv4gO8fNqnnWNqgwN
 Zj3ypcHe/rwg4dOdZczyDBgod+F7wQxTK/0pVKB1cGkjCGbJmog5fEpP13saz2HS6hlXrcc4ucV
 QdvpilbzRIjgPkXepO+/mIaPRFC3X7MjZvlLYghsPhzu37wCZkeh0/3KwcmcRoqXKV9C5uDyd/K
 ssIYmuu6m1+gvsOOhLg==
X-Proofpoint-GUID: D219MuSTpSYoCA8Ygqqmgz94-ZAVnyeB
X-Proofpoint-ORIG-GUID: D219MuSTpSYoCA8Ygqqmgz94-ZAVnyeB
X-Authority-Analysis: v=2.4 cv=Y9/IdBeN c=1 sm=1 tr=0 ts=6a82f83c cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=QDjCMyA0A8yHJihhU1wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA5MSBTYWx0ZWRfXyOVvrHDHlgoD
 ioHh0uUt3Q18vJxBlyH3TnT5B08rdLXy2LkoorZfleEYq20d5LoRByQSvEuoR2pSD6oup7+CBHT
 k82DfKmgs7FdCts0BAwQakTBH05iLOo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170091
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

On 8/8/26 10:23 PM, Akhil P Oommen wrote:
> From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> 
> Unlike the CPU, the GPU does not throttle its speed automatically
> when it reaches high temperatures.
> 
> Set up GPU cooling by throttling the GPU speed
> when reaching 105°C.
> 
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
