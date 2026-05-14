Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986ADCD4851
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 12:44:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 085C110F1CD;
	Thu, 14 May 2026 12:44:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="P9O0Crni";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xsgr9IjQ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07CDF10F1C1
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 12:44:06 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EBeR9V2713167
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 12:44:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rAvsMuwZV4ckNzcq8kycV+c90RKc2YlbhdiothPSIhI=; b=P9O0CrniShmq3Pj3
 iA3WD2SZI1Hycq79Apgxw1n9nuht/0Fgw+utcmQggHJkn2eiqsVoJY1qSiV5zEgb
 LLF1lBFVB2vtjBwsIpDrIvlCv5tL+5Vsw3HWBAn/9v3pMn+NiOKf6m31VUtp2qDb
 XR6oSmqq5fhg+QpNWHXbrEB9LlYmmpVEi4pvP9NfiBRCjyuGC/pzUXOYPklNnAj9
 p5Bwce3oS79TsLxZnX5MZUjSVz3AuXSpKb0eg70Z1a85XSHCMDNWJ7TzVR0al0DY
 PvkY099ekYKVzFO+8YtJPwF2lfxAAVa/TVTMD91m9C90j/40wPOiABA6llH9PS7l
 QUB8Tw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e58v899fy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 12:44:05 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-6314bbea08dso326354137.1
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 05:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778762644; x=1779367444;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rAvsMuwZV4ckNzcq8kycV+c90RKc2YlbhdiothPSIhI=;
 b=Xsgr9IjQtCzNI0HN3vYdY5J0y1v+xavSHygLSrlFxFkhz5Xoce1TuoRJLPmSGA1IjM
 WeJ5Drx3Zg6c0xF77phTuN+W2+XrQ2GJuFbdXLny7r2s8B27xaR8c15v2yIjiQTnNBxg
 rGfzXtBlLtv3M2XoEdc9mUuvxBab42j0aealJfHSyT2rkbRPXf9M4dlTvR6qgdFXV2PM
 FdHcXD6lcV9flZ65pNI9dpK/bQLKD0KFuPibil65FIBxYVqka3MTO73RU0i1hIYonn/S
 oRoyOUh0+kqDe5jpIcsDA4HPz2kg0MulHLRDgBdjuKOxNaA6tye0taUW5fbdItLSTnRG
 9icQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778762644; x=1779367444;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rAvsMuwZV4ckNzcq8kycV+c90RKc2YlbhdiothPSIhI=;
 b=LYJbcOlvu27XDS5CKBIM7OffJhQaJOiBhjQYinK6yXyYBpv4Y+SZ6KeNwr3WQhQjaX
 10uMIqFzq7KIFoWcRbwQkc6FojuDc+kIf70kyHtFOM+T8NKK1hftBDVkcsOCwndJD9QX
 C7cAEc4cwLEjEzqjMr4daEK0ec2GkMLY3qLBX7E/lEc0A6F54LgOnDtKMQqmS/SkK27/
 lQX6LkA4JcSRZLdCqzSUN7ymlVmnM/9U+4TyajcyXgzHBnvmuZ5y9obIhTwHglZXex09
 QoArlqtoFEsiCtbWgHNz7lYVM+5pMv7nhqqmXeEDc8/A11Gi0cThzMIcJSFOsnm5Bjmq
 A13A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8HMdaRqOGVpFLtucu8LSRtwBMYbO5pP/0/nsusBDnZz6KnjvqV0OuE9j7RaYZ0/D0uKHjLxi25/Rs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YynRUA7SGaRQNCMtkPmyg1dKzf2IwlwLU31k0Bp3RfH7qKvnaJZ
 lj/AGUX70mIG0VPh6X872OyNC3gbB+zho8meJtzgM5kZ7fgxPqZGaLpasRwv61RbCiRKElPzC31
 JSkBU+xkI5fCUOJuSjpPqz1QF2sCOyYTFiS9SPFz6uUsiq+Q7iQWwtJk4XHzwBkWkIdVRNBU=
X-Gm-Gg: Acq92OGuvT4Up6VvGpaxbGISdg25LQ9FxQe/qlAGaiXcP3HIw4GTkYuahtYDfQooQAw
 di+5MMDXc8Zt5QdtGtdYDNss1Gp5r1DfYwzkdv15/c807FhbsIkqCOg++pd5MZzhnatEzBimFeM
 lkOm+bbhz2WvWuBdk6lChUuKgzw5Y2feevcyzoeGVVA7R830bqRjxYTGXju9bgxXopauebPBp6I
 Fq8J0KuFCD6RVJsibP7QIPnlioqppXwCHTWQYnA2FNfi5jrIqV67lln60LUKYS/UGtOa3pyVTJS
 DxeCzlViwoefcWLRIyUIi6nSMe/ziquwmE6OfL1a2CzT07Q39VFGpExQQxK9Y8ammNV/nPsatGw
 IV4RUgIfOnkCVcNdHkQfXfYA5tL7PPQQRM6YCBwqxyZ8mwDpiR+ymRk5+JXOtU36iAiJgi760td
 +f/pDbuWcA149xPQ==
X-Received: by 2002:a05:6102:308e:b0:631:3ccc:42df with SMTP id
 ada2fe7eead31-637750e0095mr1201543137.3.1778762644572; 
 Thu, 14 May 2026 05:44:04 -0700 (PDT)
X-Received: by 2002:a05:6102:308e:b0:631:3ccc:42df with SMTP id
 ada2fe7eead31-637750e0095mr1201528137.3.1778762644167; 
 Thu, 14 May 2026 05:44:04 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bd4f4c24178sm87039266b.15.2026.05.14.05.44.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2026 05:44:03 -0700 (PDT)
Message-ID: <f0cd7431-acc3-4468-a2ce-7e44a915472f@oss.qualcomm.com>
Date: Thu, 14 May 2026 14:44:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] arm64: dts: qcom: kaanapali: Add qfprom node
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Jingyi Wang <jingyi.wang@oss.qualcomm.com>
References: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
 <20260512-kaana-gpu-dt-v1-4-13e1c07c2050@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260512-kaana-gpu-dt-v1-4-13e1c07c2050@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDEyNyBTYWx0ZWRfX916rLQpczIEB
 GyvQ5+cGYLvXtvDL+mJES+GaCNQ7bgeaOV+GKOFxjP1YBz+KagYJbxAEkRxMAWG3byPVlDtwNlq
 QXHdSOF7V+ZtUQC7tbrJtVl2mfsydmfYTqRctwMCzcbp1mVpTv4KdYSBjwG1kCtil3Dqk6kNdJ0
 Cd6BG/2NrWlLMjxqXP/RCeAGKwRGIwSohswhWNT5BVKjka3+1jMbR9690Ewlc5ELDXQNusd7VSS
 mP3TlLwqBurLAmacx2VS44kICzwkWd3GBwuEPEKrqaEM+dW+eeEr3vblWLjcAYi6f8diNSHrAzI
 FKSyTBb8Trx0k/j2xBoN/THeJMUER3eC2SLAz5Otnl/6myyZ+sN+YCZv9N3PZq4PmCI5rNMzP9m
 AeE3HpNUmx4Ahp9AqlMADEDXkeVNCbzD4ePjOQja1R1WExj9kxHfQ93eWXan1++ysk/AXKOlafj
 Iyy1Sxtn5KV6P9eCyQQ==
X-Proofpoint-GUID: -NQPBy88ZcT70zYd9umuBp2aQTEeFp0O
X-Authority-Analysis: v=2.4 cv=YZSNIQRf c=1 sm=1 tr=0 ts=6a05c395 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=_Tv7ClR51sp9MY50WFAA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-ORIG-GUID: -NQPBy88ZcT70zYd9umuBp2aQTEeFp0O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140127
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

On 5/12/26 12:23 AM, Akhil P Oommen wrote:
> From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> 
> Add the qfprom node and gpu related subnodes on Kaanapali SoC.
> 
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
