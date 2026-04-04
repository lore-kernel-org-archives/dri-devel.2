Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DC5E63FFA
	for <dri-devel@archiver.kernel.org>; Sat,  4 Apr 2026 22:04:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EEA710E141;
	Sat,  4 Apr 2026 22:04:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="j4kv9ThK";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PKAf+cTC";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2D8010E141
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 22:04:38 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 634H8AkI3333835
 for <dri-devel@lists.freedesktop.org>; Sat, 4 Apr 2026 22:04:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=dUW0RwB9Q/zSV2QNFW4FlByk
 kVTIFbYnaBQQuw6cd1k=; b=j4kv9ThKsVHyPQD0xJtUDSegpJ7WEFA+Fi+DGRIz
 2zROxRvor8BfJJKnEUdUvkErQxbwIbKlttGOZh+XtyEfYeLRqGniuJf7lBrJcinv
 jZ0YWyqhXLi61BqtykR9UJYfqJR1FtquEIACdqcqc2HNBV7tkMWqanmNYfXoZV0l
 v+30h3ZGlJsI+KRhPA/yBphQ3pH4r/E39TgEbswMtXfoDO6EK+Dmlcwje9x5l4C+
 2Lhm/XGJWBdbgN4ilwXkRSSC6a1tzqTFVnzZXFeFPQtd4GI/pOOmdUiJlRCPZulq
 +jR4p2BGL0pMOEJVXpPz6qhxWC6DWhydj9bW7KLVr+yKHQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4darbfhsjk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Apr 2026 22:04:38 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50d6bf346adso33193021cf.1
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Apr 2026 15:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775340277; x=1775945077;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dUW0RwB9Q/zSV2QNFW4FlBykkVTIFbYnaBQQuw6cd1k=;
 b=PKAf+cTCiq+OQK0LfM1rF27eomfYi9gBI+jzAYis/JO3iU6kf5ST/zUDz+8KiZUA97
 v2Z21N7U34+LtCYokwLtOpuUqJECDrARuZhx5uTFtscEGxhb0+VmSMk6BPmrtlAixpwg
 de8N59NM9+DXz5T37RPJvpEiN+nKvz8ocGjPuT6uj8V614cfT7VwxXuGR/gAGon6R1VH
 DI36dxNTsDfW5nfqOCucLJulRo8zy1Y8+FaHADnFbAorlYUXdZx9g+zcpVJ95yTOlVA8
 7Yw18WoP4W0UW2P+KRdjD8AIrxtgvLSsFTWcIbfg45/wwkqgvXpr+6iADhB1pWhzGPYj
 BgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775340277; x=1775945077;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dUW0RwB9Q/zSV2QNFW4FlBykkVTIFbYnaBQQuw6cd1k=;
 b=SlvZJKscXDYcvg2uUG+D2GjU7MgnPFVor63elJddqc0eRi6t7C3EzAbuefOJ1+ascJ
 8ac+PS40u28yEJgOz5ogSSx/W12jx+aKeWPCVki7i/pTiIEMU/ZkAUOYRu/jOAnv2m9a
 tlaOHQkRR6ApUcG3PmOzGAQ6xtVuCLR2ISGYnMbTtkFrBkD3/Xft1T+RUOlfHdenXwUs
 0/geMLrerCcXtCrsm9ccAllqkYNrmME57NDXcZN7N2Z8JBmUTR4qToNwqGIPaKJPBylx
 VMD3J0+3Hri0wmCNSZ7r43pJ6jO4YDTcuiq7dxgnhHLXJzKR/P/KNFjy9mB3YC91KzM/
 KWcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8IEQ/33++OXDSaC6wSfadGH+0w2uV9ldgyXlewszAujVMNSuxK1wpVFhzwiM8d0R6eTT8HpNRHBs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxGYs16onFv1vDycMEZOgJXYkcT/CTI0aMnBYqrN2Fypf7AXjY2
 /qm1hpKiX6Oup+9iIoJBre3GveipKXNCeBGnZcoUlEfZOLJiMnLODD7VN3qacC8Aqy6jd1x41na
 gQoa9FshZLqr+NiO8GbdIKIzzDsrnJHDHLsTIITAoLAdZL7Llb9ZoVlIRajxeG1T86s9d7OU=
X-Gm-Gg: AeBDietAc5m5M1RcC6fZvFQK51ekJ/a+uQTw2ouB9cJJ8WlMCqhbCTtVWH8x0y/XH4F
 D1xA11Bkg9+w7mbEtyOnSpHSMGOQXW9hVSE3bFSnS2jqrWy/ghN2u2V99G3xI3N9ieFqn4hP1GF
 S30n/REMQhixyI6SN+ab5guo9cqhF7qBhlqDMsfTbyxtBDoVGVui3p3LYwTmli4eR6rPNE38DcW
 +oFMfjl+L2Ye8HhU94cwSTqhdbI+b0wrnu+6P5AhL3Q6Z49SieHWCmw/AEtfUW7O44knSjVQWjQ
 dCmb2TPAi8rgLH3nApVgpFuYv3snaZEOscfxTfShxUqtgu76W5+7E+tEFls0i0S75548wZzfBcC
 72a6nD9gsNNK7NNqzS90JK9nZCN3zLDUgkecft5KqEz5NyikDUFrWyELFS0ybq26x9AYJ8aeaxE
 nJyQn8kCTJzcsx3mvPa99kAyKgcfFWC1/ekFg=
X-Received: by 2002:a05:622a:586:b0:50d:8102:e9c3 with SMTP id
 d75a77b69052e-50d8102ed29mr36229071cf.57.1775340277224; 
 Sat, 04 Apr 2026 15:04:37 -0700 (PDT)
X-Received: by 2002:a05:622a:586:b0:50d:8102:e9c3 with SMTP id
 d75a77b69052e-50d8102ed29mr36228611cf.57.1775340276788; 
 Sat, 04 Apr 2026 15:04:36 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38cd212a940sm21365631fa.29.2026.04.04.15.04.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2026 15:04:34 -0700 (PDT)
Date: Sun, 5 Apr 2026 01:04:31 +0300
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
Subject: Re: [PATCH 3/7] dt-bindings: display/msm: sm8650: Correct VBIF range
 in example
Message-ID: <xsspzrpmlxtmfageptdvodf4bptbnd5msvelhr4tvjvj2bznjm@jicwkpbukm5o>
References: <20260402-dts-qcom-display-regs-v1-0-daa54ab448a3@oss.qualcomm.com>
 <20260402-dts-qcom-display-regs-v1-3-daa54ab448a3@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402-dts-qcom-display-regs-v1-3-daa54ab448a3@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDIxMCBTYWx0ZWRfX1H2ynE/yZhzA
 ShNxisgKVvydgKSeDnFXLHQSar2g78xB2Ht8xc8aFgl0baTrBCYPWvnUU2PS+3U6MnOzcBg7VVq
 5fMU4nRNTDWuq/ldT+adwjtFGqhuHcB5HFasXrt1IGD95X5Zkp/dva7yXo1+3BIPimE84+Rsj8+
 ts5rNBlCoG62SG/QaehKXJShmRtQpj4gMKUAWO85bUDBKSHflXg3XlMPDEHdv1yustOKqUVV3Aq
 e2PBnFwrlYoTD7CMQJFfv20a/Bme9j1fTmqkL28CZtApW9WpZdzYkkfKXNj3PZPGXhVyB8ogvkd
 K6MLZr1ahpqnNL7/WsXM6sJOmc5ycAlwbh1SYbAMXUAG082XjbNcLmZm1JuFHRyWdZt09wBOam8
 +rMW32+FDdxmH66ka3M6ttLUg1mpuU6JclBD+EIIYQtigJLLocV8SMm4jbNMpJGs6Y9X1H3+BJ3
 kUslv79XGtPUn7zSaaQ==
X-Proofpoint-ORIG-GUID: gr4D0HK5v19vjEmc922qkrL48z6-0HT1
X-Proofpoint-GUID: gr4D0HK5v19vjEmc922qkrL48z6-0HT1
X-Authority-Analysis: v=2.4 cv=I6Zohdgg c=1 sm=1 tr=0 ts=69d18af6 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=vvC85rtXJxrRrxXJzTYA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-04_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604040210
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

On Thu, Apr 02, 2026 at 01:45:14PM +0200, Krzysztof Kozlowski wrote:
> VBIF register range is 0x3000 long, so correct the example.  No
> practical impact, except when existing code is being re-used in new
> contributions.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml  | 2 +-
>  Documentation/devicetree/bindings/display/msm/qcom,sm8650-mdss.yaml | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
