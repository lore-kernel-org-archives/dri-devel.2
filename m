Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65FD5EDB7CC
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 09:12:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C01DE10E37F;
	Tue,  7 Apr 2026 09:12:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mwOTzdze";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U/msmbea";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECBE510E37E
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 09:12:43 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6376YpnM2327993
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Apr 2026 09:12:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZH7NJeeL+W0a0G40QLryaXbsSTbVab4mx59PHbCSQMk=; b=mwOTzdzegibL1bSr
 r/heC0qre9CYMHscG2vVaL5iFH3flu0z/iRSiHX3GR3HS+PE5grXy80vnbf4xX5+
 p4wT+Q2Z4gghcMPJ0V9zbSrWVU5TwjO3Iff8KqDoV1vYy+34XkxwBaFnuD5fd4bc
 4ZayZbW8/zgtj1JF814Xiu+TsCbzOv8BCVA1mtiTBu8MW8u694zbqFLPqsT7nCdv
 M9m7gAp1lFaXYoE6jC971Srnmh3XDM2C2PLFwrV81eTPfHGea1SnMxVUHLtNes82
 /n1YkGfhs4G3DzqpfERK4V+nvevNVxH/qBadqmWCwSu0Idvh7dw3B6VOciDLY+PK
 8QlKAQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcms4syum-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 09:12:43 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cb485c686cso168191885a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 02:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775553162; x=1776157962;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZH7NJeeL+W0a0G40QLryaXbsSTbVab4mx59PHbCSQMk=;
 b=U/msmbeaoN+a4eckFeXcdLQGRnBa548ih9x9zHIclCBTbYy3HgLXORLei2LvxDYgGC
 fJc+BSYsmNBihSVPn/W5SNqiTOOzI1T40Fp4gQ+LwfRYjc1b+/Jo46LqygZXehKuMmA3
 ECRVWJTy6h3aCa72JorIENAacIZ/S4GIKk7uCn/LpTqePOyG8L5X6a2/jBXch88KzBvs
 LgBshwPGPYbQojVK7/ZS7LQ3wWX46pn9Fnu8R8ihtIqvyTYOgzayju96ACqtF2d49w6T
 2na2CV6yB8ueo2YDnS4kI7z3MYzMOJg5QFzk0ocBD7Hw0v3tNgTcDxdrlnQztOXwgWg1
 5wqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775553162; x=1776157962;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZH7NJeeL+W0a0G40QLryaXbsSTbVab4mx59PHbCSQMk=;
 b=DSmsLfdIctNQnEzHLxSMFAFyybnGqWaPB48S4XO2YY9b52SYA6Hz3sEnJjQilXx2wu
 wRDwtQVHurPKkk5EjMLBDrbhhlDB5Dj+oeRAzYi4bZiAdGQHinEjCz1t/jiDz+8MDclE
 J1VD5jcXeRYiZ31mb94qnQs8Nz4ajOH0OJcVw1BPwNjEXE1PX4uYDJjE0fY2sEOXTu5O
 xCHB7qoMSCdwoR0zhwnuxkxexOR2xHHDKzrmIn4jFvSPTuQiTuo78Zf80+XD4sCBGHiR
 ZlRu0W11QAKFW/7vCtuKGABcBjQZhxO9oo2ZoCLDmsyeVcy7kMOylwSYsqKsuDlspSdR
 p+7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWU8CfMoc56SvUUGR8MoA+0TLfZ8uuYq6EdQtHs3MP12v6hkltQ4y7DjxZ3DSdr4vCFBbmsPs3K5mw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz+Ppm3C/AKpF3ThjLHAiOQjqOf0thAmtoYM7JQ3yPWTXSshiGd
 dukod6ED4K9Q1s5weR8XOxrPypoTNtuRTMWPdngraYQHVqJS1P6shXIJVpUJCzfZsFvk4RFvnVh
 L49+EFqwDsZrYBTiiQbtC6CGoSgFT5wsQ7MzMVYxbUnSkny4MxMTa/Zcx7ZLjxX7vAAIDXKo=
X-Gm-Gg: AeBDieucEAFQWnfSV8AN2zOHWkjBLQSWVIbmeIcFEtmUKEXEO6n9uLWBVaW5INPjGEc
 Lx3ZlcXkL/CuSqbX6GP0ucpjIPA79BTiUlJ2RJURfNPJb8xD+BqM1DRZx5A4n+XlXOfRL9dslc6
 SgubT1Ju+1XxO/MDbFLq2gVz9DP7afSEYMcd8pgBFkVJC11jxMFgZucCTrifzOPZpqA6IEPVwj3
 sT4sqj4lmXzC/orEqec0taT06Kan6hZYe8knFfh5Md8+l6l045TZ+eitDCBonRjo7YJUICGBJ7q
 hQQC+IspPlnI3i4CDihl00RRNm++lxuPf3M6XS9eYPP7c8tZbxAQXCHp2vqP/XMxUoXsv4DbhtA
 /jO0HSe70FJmi4Kf5UT0kL9qaggQggC5RYD/yGZADp43/k4SsP8LdfxV9TOxL0fWp4122xedV2H
 OoZpM=
X-Received: by 2002:ac8:5853:0:b0:50d:aae1:7078 with SMTP id
 d75a77b69052e-50daae17569mr2878291cf.1.1775553162395; 
 Tue, 07 Apr 2026 02:12:42 -0700 (PDT)
X-Received: by 2002:ac8:5853:0:b0:50d:aae1:7078 with SMTP id
 d75a77b69052e-50daae17569mr2878061cf.1.1775553161873; 
 Tue, 07 Apr 2026 02:12:41 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9d0edd4264sm19703366b.36.2026.04.07.02.12.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 02:12:40 -0700 (PDT)
Message-ID: <d986e1b6-afa4-4e39-a586-2ca119ccd42c@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 11:12:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] arm64: dts: qcom: sm8750: Correct DPU VBIF address
 space size
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
References: <20260402-dts-qcom-display-regs-v1-0-daa54ab448a3@oss.qualcomm.com>
 <20260402-dts-qcom-display-regs-v1-7-daa54ab448a3@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260402-dts-qcom-display-regs-v1-7-daa54ab448a3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA4MyBTYWx0ZWRfX4+xr3avEbkQy
 Mn1iNtXUSTkBFaW+LXSNbJHXPdDjCS0TWyAXZ9gSyM9FAg3D7ToASMTievX728z3o3PgIezkHgD
 PsQGsWe/sADhIyVeKdIFhPNJVLopbKkAigx0i5eCeZCKgHS+A/oVHIy4sIFlTVvkjKXFtnUxPeA
 3JdnMD1Iw3uoOpPkUO1EGdypkvSRLvFlkKR2gKgwlwax0eqc+2rqI1xw9oCQzTOEZOlvdS6Wa5f
 BOojg5w/5fe5EdQBtTlYIZufBSBrfjqhM7ToAnSLyvA9sMKuOOdNoxWy2YvBu6CxX5FyVeVTqo3
 +53OZWxQJ2/+MG7Qc/zCeqsl4uGut8GwmaxDa6JURCbXwNo9yz/5Puydi9OIh0JZDzjd9dWghEF
 wOmnM4W9C/I7m5ePWLjqE+mTqB3KKgeqhHuEFPhSNWxXasgP2md3OnfRiXlLG2jByieAs+AYB7T
 Ahy1kWqtmnRqjVOPiNA==
X-Proofpoint-ORIG-GUID: QS-q27qIMsSWgv_Ep5s-hXqPt15TjDDr
X-Authority-Analysis: v=2.4 cv=WNZPmHsR c=1 sm=1 tr=0 ts=69d4ca8b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=fzqTxgmSy3qf8bfLeY0A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: QS-q27qIMsSWgv_Ep5s-hXqPt15TjDDr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070083
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

On 4/2/26 1:45 PM, Krzysztof Kozlowski wrote:
> VBIF register range is 0x3000 long, so correct the code even though
> missing part seems without practical impact.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
