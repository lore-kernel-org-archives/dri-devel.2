Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B6BC5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 07:45:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE75710F1D0;
	Thu, 13 Aug 2026 07:45:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FPeaVwaZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VJxVf4wz";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1701210F1D0
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 07:45:14 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67D5g1K1628997
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 07:45:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qx3EP7LJrDWwM9ZG7+f76byk7vIQMhbjIHopCD4jEHo=; b=FPeaVwaZH3jCLoS5
 dy0eX0Pb3zDAb+XwrpSQIH/ET7Kf8cU/fG19XeutIRCwHGUWYJWsgfvRvqF2zPKt
 shQg1naGOkYc4ds9j5LtGe1OhB7UlDXDA0Qj63WhCU5eq32qxaIq249b0fz5O9jK
 gEfOg62iM7LNgXl/ZnxD1ihTpKwDBQEMzbZveq8XfeQH3/ywlApAl2aNtvzON2of
 c0zqSfFx09E+wfpsT9237+I3P0ypZ4fWps5WUlaqf11uctg/F0uMBQOx6T8TXver
 Y5g2D8DdcSkrkLA8OGErq9crWmdpgeBSCQ3IbrF1hCglPudSsRMqLRS7zPwclIkL
 58V8Tw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0xsk2g57-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 07:45:12 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8eeba1d9e47so16712146d6.2
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 00:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786607112; x=1787211912;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qx3EP7LJrDWwM9ZG7+f76byk7vIQMhbjIHopCD4jEHo=;
 b=VJxVf4wzW/Q3fq9HS7TaAnQ1lij7ao5bCGFDEiB3bXE2RV6J8oXE/Z1W8jH/ws7ukb
 HIVOQPAMjLbe3LzEjBVJUVwhysxOrtTqYDZqFTgPUPWjDBTZ82sG2deUvaSAiOsBCMco
 URn1yLc3Wb6oQs4Pvhyjf8c9JPWQVIdAXpLKjnPJ4EfZvdbt0q8ZR3IDcTN5NHBsDJyM
 v8UtVxw7nMBKcNVctyuWlWVqCJggqc4EjKCebvbyLE7Ufc+K1BG21TcPE3E9F3vslk75
 u0XeX3ZUpqnZj982HumZPmd0Yt8wkQg20f09NtVApSr4DdMvWqy0Bd2GrUHry5Xjqevn
 MpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786607112; x=1787211912;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qx3EP7LJrDWwM9ZG7+f76byk7vIQMhbjIHopCD4jEHo=;
 b=XxXyrLbFaANyLb84F1bRZpBLrO0pgXfxDBp8PdtFyoQZ5coadDjK9DCkmcdsQYHRM/
 U0TOdeI3rp+yApYoSzoItYVclyfJEWSJDGHL1IyCJJRUCUAzj+158dsNoDYAW/CN+Io9
 3Udy2huSZJ9RbapnYQUg0EULW10Vdr97fK9end+l2k6YLlHyQ1pQ9PfvDQTmdBQXfbJK
 /vf90o/34IUerbqpQhunNayS1M9v6HH76hyj3afMGlxum2ncNSH2lT42KSHztHqsDkLB
 jNbWbL2k2IDPwvIyVrImyPDOPiw9vhtl7L9UXBtB8I6Etts1TBy6mUP940FCaxOpYSvQ
 FYCw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpDwmU11pA8LfnWI0detbnjjPOwMAAYN+pevQNEqfVzOWjyicVzuwiht6CMp+PQcbG82C4+2tC2Saw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyViFu8SAj5uJJfScjdBuV32zZ6zKa1n18XLcWvJMADuFLv+Xg8
 p7S+iLODkoAH24PWK7QBeLQ0sHKPwqfZQKgWKdH4FmJbefHtAM6+8GJ2cqL4+7it0nXVDj/nE0J
 dc9rdVas/Nxj2TNAAIztKG/CvRaOQIQEp6bc7kHnCDCr03UiS4FZOj3YYw1Pvzgm95SpYxOc=
X-Gm-Gg: AR+sD10fSWlMIXAxzL3Qivwkrcyf9qE5Gu8IsRMKZA+b9SGIjVlgqciXA9iqoOlfMSv
 byO6lCX2DGtQwrrCJ770WS5w2I8DQEdo9YYVXFfzN02+Wk57IzY7oGIRfFBwWueN+aPop98oY5a
 B+UeZtc3UtIMzpfxEZFORiQJFFXwYqW0Ju4rM4m7UgbK+HZcgAkbxAFmP+BL8UkxcR1IYsdnN7H
 x0W7BeBXsvbN6IszmnCldvq8gi93tJ2P2JYtGp4Yb7f5tfP4b61TTVEMxbhS87G8jK9v+0i0WK6
 hRnuHP7UAOuvvW9pR33azZImUdFbATgfqOXvIexac53DC7AX5XPd3dwOVsOVBtZCY1lqwYQ1Iy8
 8M5G9KH8j8UmyQzxV3qKh6TWJVojGC9XPzrt6YFb2q3UZLSoHHD/I6DY8eyDjEMch
X-Received: by 2002:ad4:4eee:0:b0:8f0:47b2:5736 with SMTP id
 6a1803df08f44-90a80b3a0e8mr34463086d6.13.1786607112466; 
 Thu, 13 Aug 2026 00:45:12 -0700 (PDT)
X-Received: by 2002:ad4:4eee:0:b0:8f0:47b2:5736 with SMTP id
 6a1803df08f44-90a80b3a0e8mr34462516d6.13.1786607111959; 
 Thu, 13 Aug 2026 00:45:11 -0700 (PDT)
Received: from [10.111.164.29] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90a8179e4fasm9733956d6.2.2026.08.13.00.45.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2026 00:45:11 -0700 (PDT)
Message-ID: <4fff475e-dcce-4a1a-aa06-25d0694bd3eb@oss.qualcomm.com>
Date: Thu, 13 Aug 2026 15:45:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: display: msm: Allow two MDSS power
 domains
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Abel Vesa <abelvesa@kernel.org>, Yuanjie Yang
 <yuanjie.yang@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260720-msm_gdsc2-v1-0-4687866d6cb0@oss.qualcomm.com>
 <20260720-msm_gdsc2-v1-1-4687866d6cb0@oss.qualcomm.com>
 <nqxbpcwxwastqutkfkaqz4o2telev3lixgrdlmb6anftpywjog@ibfxfb4e42xd>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <nqxbpcwxwastqutkfkaqz4o2telev3lixgrdlmb6anftpywjog@ibfxfb4e42xd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Q5PDf-K5FDywAf8XIjAQPEsA7Pl73RX1
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a7d7609 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=0b-XH3JjkyDtS5VtSh0A:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA1MiBTYWx0ZWRfX+7WThjCW0BZN
 MpuYyaTyQjo16CY/gywIgS2C6UeXlMY4g3w0owrPtybRh6oPQ+gHfchSyPifMDxjz00+sf/wPz4
 M/Au1fkPDXfAO+UpRINDixnwD8qtu4o=
X-Proofpoint-ORIG-GUID: Q5PDf-K5FDywAf8XIjAQPEsA7Pl73RX1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA1MiBTYWx0ZWRfX6ONw0JUUnCVJ
 VQb1ntDI6JjKj/0O68QsU5th/LgTEUVg5jmSDwSCmSvLnLSx0PdG3NMyMHloG2oSkeUaj06cD1s
 enFtNuNK3fkJLBCLlUoOkP60sXdMI+QpqBW0qjq9GK0NUlroNUW7A10zkwjJTl9dhzmpn7tDeoe
 aPUQ/iQ8kX0iPhCrA429jFiGkpXsvcMkOe8X7vnkQJkDuKSf+nfsI5F7Rh8f9nHGOp/qiqVSLTp
 qbk+kferlBbPLpkTvMNOzyHAyv6hmf5jBtrsPI8zr3xhwAWSNrBvxBrn8un8F5SeWEickhjQpiW
 B45PO03P/niuRhkMWQAi6HCfibTWUT1x10tjPerkYpOtOqj2VJmAdWgz8W5wWcZzQcMxRDkw9iM
 Lor6pefcAFpn6lZHTQc5WRFU+ZEC1MEZsz7Uolyirw/qSLsBiIQq5QjGFEXe8QnwNOKRvBsGt+d
 8TCNFD7f5NZQ94bwNcA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130052
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



On 7/22/2026 2:18 AM, Dmitry Baryshkov wrote:
> On Mon, Jul 20, 2026 at 04:43:53PM +0800, Yongxing Mou wrote:
>> Kaanapali (SM8750) and Glymur use two display power domains.
>> CORE_GDSC powers the main display hardware while INT2_GDSC
>> powers a subset of SSPP blocks.
> 
> I see that INT2_GDSC is defined since SC8280XP / SM8450. Does it need to
> be enabled on all those platforms?
> 
No, INT2_GDSC was introduced starting from Kaanapali for SSPP1 
(VIG2/VIG3/DMA5). Prior to that, it was not actually used and 
essentially served as a placeholder.

Sorry for the confusion. Glymur does not require INT2_GDSC to be enabled 
either. I previously assumed it behaved the same way as Kaanapali, but 
that assumption was incorrect.
>>
>> Allow the MDSS bindings to describe both power domains and
>> their corresponding power-domain-names values.
>>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   .../devicetree/bindings/display/msm/mdss-common.yaml        |  3 ++-
>>   .../devicetree/bindings/display/msm/qcom,glymur-mdss.yaml   | 13 ++++++++++++-
>>   .../bindings/display/msm/qcom,kaanapali-mdss.yaml           | 13 ++++++++++++-
>>   3 files changed, 26 insertions(+), 3 deletions(-)
>>
> 

