Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76AA3C5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:01:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC73410E77A;
	Mon, 17 Aug 2026 12:01:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XRVemVB7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KgmYkeaU";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F8C710E77A
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 12:01:05 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67H9dcG42990856
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 12:01:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iSATXp9QJh37aHfasXkd8sfYODHkh/uv+2k6x9xJLYQ=; b=XRVemVB7N27fM/As
 AHNSMOnOGSvUoWbSZyQ8CTCe6Y5AFplZ70QjzLSB1VB1mlc+LwctFJvlDsyOSm9A
 vyE+n7u+cZPOPERoMhY8VQqBEMmW+C3pM8bpfoqxMctVKPPrbHWHdEOZmpM6oBxc
 5/6rkGD7IAsdWtuyFmQNATR9USOAxilzLRQuvlthdBLlKb+rezyw2lasyauvTaLf
 Q50dhbWpa7D0SIBCfk8ps4mnsKzEpIdRbysV1gBLFJNLCR0KfFqVfVxOv5mmmgMV
 FFVnbbuH0hXado9S2ZoU1C6OL64vnOjgWstFzlGf3/tn+3Gsswv6fjdvK028g4wL
 oB7wLA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3y7krnnd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 12:01:04 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c07313be5so4055721cf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 05:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786968059; x=1787572859;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=iSATXp9QJh37aHfasXkd8sfYODHkh/uv+2k6x9xJLYQ=;
 b=KgmYkeaUxPnAiraNiSa11GFfOCpnh8a3rW0/AhGZqVrPcrd+f8iPrqFzOPaKWMeGEA
 LSq63u/m+EoVP76c8Hf6oj63Mb1E+WWVbzzRiZ/HJAGDUEJ3qW1A3/aCn6YIg7K5so1m
 8huQgQ1S7yNCdQUCLY6a8svjElW5/nYcPW4TFbfKfD0DXB+dEcZnjPvHXmQiXJTvWGyq
 t3C1L4Nbf0akG8KRwpQFq+2QBr/0pCHOrDGQKBr8BKcLaixNq/Wy+9WXlw1cPrQu71BV
 Fhta/UonpnzVSygy9hRc0/YEMTQBaPRLyuospcbfP/AnX8vzSarDLXEGtRwl7DuIE6RI
 evOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786968059; x=1787572859;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iSATXp9QJh37aHfasXkd8sfYODHkh/uv+2k6x9xJLYQ=;
 b=XPQnlBrvaBsje7K36VsswZl9E4A4AA80EQNcm8bfjm9Q6RXsH7ZQNJSEE66jMt/1sh
 /MlihXTNB32TdLm8HT2y/TqC7GtXADWFvzLRRveBIAkJMcd5Fk/QnmamIrnPfjZHO0kD
 SVkAjHAh58eecQ3pFzLyIAQis6AzIPWKNpjWym2wpCRsL2nfWvbI9STnC4EKLlZgoXGO
 X4Vbg6Rxas/7XSZZQeQ8TVvP7uz47/wpzy5mcdw6hXFjZ283UBJ+NPHH/jpHXF3/94CD
 4PIbrWAXHkF2P39FKs+09p1R7bY64i4QqaujvZJdd9TWQoaxz/O+LlprR2FYgiqRx56T
 qnOg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpW6RPfRYlAb1eTUQpfvF/YXO7bej04WfQKqUxXr975UhlqYA1SDZdZzivZSFhgvlnqiAET2SJLtZA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxW2y0Dy7KpU+vcRERymq/JHY2p6UvVX3Ob9JfwuOFfDwFzoYWs
 9c7N1eQWCGal1PLLdgM1RGN+Jy7e3jYgy+DIQRgdRhlWsbLlkxH2b3vlR2pjSkyZEl3GIa2Z4lh
 RnN5QvHNY+2fsn+7gxpP+8slfDlRPTt1ajWvppriquytSOiCaDQplLhaRiuck+NeXIOvk5uc=
X-Gm-Gg: AR+sD10e7mXq7X5pJZyCfxbw3LBZIfPTMinkG/Xjukmihq5PqvEMEXnqrlj164nJifE
 t7VHiUXzhsSmgzAq/gBHoNgj0/1H8Ss1XGqcRdPmTK/GrIrUy0e+8IUYVyuQjeiMiFKl6Rhkkvr
 bcKtbYDGKt2Y4eCXIw7n+LQ+I3DgKRCFmmRcjk9/OD59vOdaJC4rsMOwFvE/NosLLkjBwCXgw7e
 lBy7eWhfY+A3OwXh2q3v3WlsNjO3wH7+QFxeVAAqBHBjgFB7DlCPtL2ygohMOV7PLjo8+u4xQoE
 LDsHk/HIH0rMwkx7TVYqZFW1+wN+Rac4ypLnM0dljE6TS49cJL2u6dAt/o0Fwt5NubxMJfRQEPN
 FTbWhLFFBg0sAj+mDdopArFuR
X-Received: by 2002:a05:622a:2d6:b0:51c:2101:f0 with SMTP id
 d75a77b69052e-52d8533db8bmr188658521cf.2.1786968058239; 
 Mon, 17 Aug 2026 05:00:58 -0700 (PDT)
X-Received: by 2002:a05:622a:2d6:b0:51c:2101:f0 with SMTP id
 d75a77b69052e-52d8533db8bmr188656281cf.2.1786968056229; 
 Mon, 17 Aug 2026 05:00:56 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2185bc66bdsm12587866b.58.2026.08.17.05.00.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 05:00:55 -0700 (PDT)
Message-ID: <37d4eb09-75d3-4a95-aa1f-5a76d3ebb95d@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 14:00:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] arm64: dts: qcom: sm8750-mtp: Enable Adreno 830 GPU
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
 devicetree@vger.kernel.org, Jie Zhang <jie.zhang@oss.qualcomm.com>
References: <20260809-pakala-gpu-v1-0-207ad1fac1c7@oss.qualcomm.com>
 <20260809-pakala-gpu-v1-5-207ad1fac1c7@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260809-pakala-gpu-v1-5-207ad1fac1c7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: vUTbhHGcnIPslKb3bKmcA0qF5coPODCh
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA5MCBTYWx0ZWRfX/B8QHAHx48Z8
 4do1lSrTQdo4Xah4Jx3/pA5Va2AF2RXpIikl7Rqzp6nXGjlNZhWccGIXqX3gXVnaSw3IoklxQGw
 ingCo0L5ZWu454aXL6rz20zF5YO8Z1g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA5MCBTYWx0ZWRfX5qc3hQuXN2ON
 vmPTOJtWP9hwfFfoZnHpdOeKm6OUiLONPflpkr4EjH3KrqwbNmE/On+iMAdACwjMo5NRErCx9cZ
 GiFpkzYf8eo4PD4Mek4vpPvOp7mKw/Z02SOFCgCuT00Z26+XsbcQ/PunC6NNHHA1edVeGfUgnGp
 Iys30+3WxFfpjKrVSVxGZ45/kViMSusLrNUYKD1QKLrbMTMqeMaUlvvhKIvvx55dvzKgpDD6P6H
 PF5pqi+a3epxXZv4gMS2UjLkW4bzAs+dMKIsWu0wI3IOOVRJQYRVyduFC0N2mtXVr4CZTd9S1Oz
 2N8/DPX/VqZ48tpCf9jESCn+tti3WGgGBOU29160d6SDLZS/VM2dNO4UQkFsYUM1Ju69CqnDbmT
 sXnACifuBA0O3FS1pibQS9Q6rRelkPMurKgb2EubWCcQ52C1TXI9hyA5SO0N0D0bwWhNDgIj5sy
 XrFGzj5klWtygn3q6Kg==
X-Authority-Analysis: v=2.4 cv=HYEkiCE8 c=1 sm=1 tr=0 ts=6a82f800 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=QDjCMyA0A8yHJihhU1wA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: vUTbhHGcnIPslKb3bKmcA0qF5coPODCh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0 malwarescore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170090
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
> From: Jie Zhang <jie.zhang@oss.qualcomm.com>
> 
> Enable GPU for sm8750-mtp platform and provide path for zap
> shader.
> 
> Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
