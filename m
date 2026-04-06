Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCBE9E9D826
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 00:58:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9A6B10E13F;
	Mon,  6 Apr 2026 00:58:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oraVGmkq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i4klINnZ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E052C10E03D
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 00:58:45 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 635JaNfw3450012
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Apr 2026 00:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=plykkzu89dtG38Upzg/y2TNU
 tXJmjdeCCRcfnkKEyGA=; b=oraVGmkqRj/TEC1Zfqb1y2uMv30guNpqZmXRksJd
 sm4aGZbJoiYFVrq/1jnX4OaBsy9yGh3z9bJ0aG6UT+dNKDRC0eoHW9Ip9zplgnrq
 nuO3mSKBwgA47J9fvcwDNPYB5lYxA38Mg8cBTx+s7TpYB6XMulYEGL3TU0woN+WA
 eOI4jYZzrGNjQvlPlmLwbdbQXl2KT3qW27nGWF8wxBrfju93+PHqBO3khGtWwRkm
 jN+jEQUNQme1CfK/M4i/nvzf/CH6KDlwcpe6NqkiNWVmaKpGzYkKPUPQXk8Pi4iv
 3nAGmXByB7dNrEO9HlAtulpdtUEan8BNWf2Pwb9iv20FxA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dauthbc53-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 00:58:44 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5093a985e21so99941351cf.3
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Apr 2026 17:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775437124; x=1776041924;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=plykkzu89dtG38Upzg/y2TNUtXJmjdeCCRcfnkKEyGA=;
 b=i4klINnZ+xJcMYRtyVvchTRieng+TP1wAFarByFMN37OcQijHrpg9z3P/NSF8SFQ3J
 simz4N8asaWvJZMA5nXiI+SIJ2YXQyOxlNUn60xXaE+s6I90Ngy6F6twrEH4uwAUZY+2
 ErQRjcClZOAuRHpxEloi8c+Lle2jqgLvNmrde8plgULvtsMVyCGBaox7VbnYAmnZ9ZjC
 nmUHS0/nI7YqtvhhGfBFZolI+mgAE3eCwk+49R5PVQc3oT3F9GdlEi25j1yAjJUmBJsQ
 ErWfmnYQrJl20vL3UMbgJXur/TDCq9xY7rGhDY6z4ZfviRGLz1tP5JB1eGfAA28d5O+m
 jEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775437124; x=1776041924;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=plykkzu89dtG38Upzg/y2TNUtXJmjdeCCRcfnkKEyGA=;
 b=QVSvkcy6EvHGRiZRHpFUS0AEpB0jlCZ5srXMDw2zJHwF0m8z+BdajmwE9YhcEJB70j
 WcI7jKc3rB+pxqZu6bZ1f+rDMPFnphMSg3J4liif8dvv6o5DhqB7exOKeOPFx3fkbiNa
 jZRqKjndjhIRR+I+dib+KdKU7QPEnQX9GYmrdELruzgc0c1ev5j+0+Rjl9BG7UVsv3Sn
 hf+TcoZzx6kuGN/3EHThZsKTcW8YKNUOswzUPszWoyn/3oVH45jxcVy3WQZfWjEjnMzT
 SRi4JHQTPaS/t1pPVC8q+1FFKMrPR7cgZ95cH3zlzJAewLzr6baH8cJw6f+Y5AWCUbG0
 ZS8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5aEJ+1XKiN3GaWw8lKmqH0Muegw1yBf5kxXSjwfjvUvN8FLHgLLcjoW5Uapl43QNYk+izhuKK26M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyqdfJ9YpOWRHRa54mfb3WQe3owKRCQhwXDZeETCDBaLzn9D3ht
 aRnKC6gebKnFgDFAiV6h5yE7jAVCATVImAXkBWgOZfgaKkmMsbqrS3v5byJ+81GDsGH3pdEf3ST
 E3pWWbGMJBqVc8ueLXz4Lm69y+sb5WC4jdwJCgfx+isnVglv5+Enm2p/51NCPQxheFndTHr4=
X-Gm-Gg: AeBDieuD4rIUBOqSCe1QdCfOmu/OFb9OViF2BuUn/SZT3Vltt0w+CKCbvxajBE6mwto
 6Z/BBavqa/boV/CqyaSDZaWBhK3o9jteRUhm+b7r/ym20AXM8wpJz5M+5saK2ItI0M6l1hMFBS9
 ZuKdGLdXrRzVpERqOlT0MVcIaYMtQ86N5MD7ctuw4pMjhYpiy5naCPVfj2FI1DFmsKCawgzJ/DV
 KKYW1eq8Vw+J4xYIvpoYTNUdfZfLdDyee2gnu1lTkhG3Wa55D8RTadtcYgHUcCdJk5lLAfpxybo
 DIBoxwIT2PP7ehvhSapubMFCF5c/gtzfCAvyovVcgGrVF0vTpvlvs95GFnYykU8z+gjkRcODosH
 HSMPRiZPvjM1MpJ1VnhFhZNh964BLxIxCt5Uob5sV3fZ8LgKPIGxacX2zWIZN49YSFfIPx19HpQ
 P5qjnDtL5rBf9QxgJHPfFqSXMATX5kRj/CHtc=
X-Received: by 2002:a05:622a:5a0f:b0:50d:8656:3e60 with SMTP id
 d75a77b69052e-50d865643a3mr60606761cf.50.1775437123916; 
 Sun, 05 Apr 2026 17:58:43 -0700 (PDT)
X-Received: by 2002:a05:622a:5a0f:b0:50d:8656:3e60 with SMTP id
 d75a77b69052e-50d865643a3mr60606501cf.50.1775437123405; 
 Sun, 05 Apr 2026 17:58:43 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38cd1fdfe5csm26751851fa.15.2026.04.05.17.58.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 17:58:41 -0700 (PDT)
Date: Mon, 6 Apr 2026 03:58:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
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
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 2/8] dt-bindings: display/msm: dp-controller: Allow
 DAI on SM8650 and others
Message-ID: <obnn4673iq7xdynuitngag35o7he3ogfegxwx33hnvlzhubjsm@5v3sr6euwrpr>
References: <20260405-dts-qcom-display-regs-v2-0-34f4024c65dc@oss.qualcomm.com>
 <20260405-dts-qcom-display-regs-v2-2-34f4024c65dc@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260405-dts-qcom-display-regs-v2-2-34f4024c65dc@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDAwNyBTYWx0ZWRfX+VIIE+MxzKGK
 rcslYAyb6IGaOGGwLwuZozGMaplQVPA8u7b2+5gWGZbKjN8eFMwm3nkgqU9rRFQbwMSyx9GbR+e
 U2JZE+l//oifAEjL0hERNnrXDymzHu6hurZEueZd1fkc+qMBmiei3fIchxERCeELdtw8uTh3QAY
 MAbY+x27s8+KgMV73cBtXM0qEm1UhNtfgYVpO3lqN/hqbytF0rR+tUN1pvUHZ2J2RAlNI1uc9U3
 Kcte4s94XWyFy3OKXARHHkhxb68cii4GeVQsL6eGAPkUEnxEZPPtFnwumzqXhcm0QObbirhFEU3
 7Ny+ZSDSIzdcQ4ouFCR8D5jA3Mt1ZjUBS0CJdvzvoZRFZMxxvSVTpozyUkcMxBCyxQNl27rJbJm
 drP4lDFbt9YPe2kIXcHSkC9lugQjI6I57UHKUhYGhy7/Fg/3qfZkXge6qVwDmr1qLAyGwqIuU6c
 M7Sg0KZ7lemLadV64Sw==
X-Proofpoint-GUID: 3z8C-vUnyd2NcihjBD9DQlAJBOHtCkeq
X-Authority-Analysis: v=2.4 cv=MIptWcZl c=1 sm=1 tr=0 ts=69d30545 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=Ul4Vrl7rK0zFZ15zA1kA:9 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: 3z8C-vUnyd2NcihjBD9DQlAJBOHtCkeq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-05_08,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604060007
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

On Sun, Apr 05, 2026 at 04:33:58PM +0200, Krzysztof Kozlowski wrote:
> DisplayPort on Qualcomm SoCs like SM8650 and compatible SM8750 supports
> audio and there is already DTS having cells and sound-name-prefix.  The
> "else:" clause for non-EDP and non-aux-bus cases already requires
> '#sound-dai-cells', so it should actually reference the dai-common.yaml
> for other properties, as pointed out by dtbs_check warnings like:
> 
>   sm8650-hdk-display-card-rear-camera-card.dtb:
>     displayport-controller@af54000 (qcom,sm8650-dp): Unevaluated properties are not allowed ('sound-name-prefix' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> ---
> 
> Changes in v2:
> 1. Add dai-common.yaml reference (Dmitry)
> ---
>  Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
