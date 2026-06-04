Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB7BCD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 12:52:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD0F111A004;
	Thu,  4 Jun 2026 12:52:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cv7szaif";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YEv82R5l";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D678A114000
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 12:52:04 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654Cdhqb2478030
 for <dri-devel@lists.freedesktop.org>; Thu, 4 Jun 2026 12:52:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=XgEAN0/+gM+54F4VHBCxD3vD
 G/6RjDY/mUjZmgXTXkY=; b=cv7szaifabc9i/rBVu+6yJCIPhf9YS5ZWrXb0Cn2
 WIZxxHuFffeW3CqWnz6oVEgffx9RksYyxCgYtl1wi83p+8KZqsl2ajf+MGJDds6t
 Y9vH6qhtIuAauLC+PVKPktU7jFgIfO1H6tI1BBhbjy7L2mjiPbFYIrK0yR9NQ+lL
 xUZ6EnwHKMKrg/HcpMv4ENmcCc5ahfI2kXTgKTVt0a2Cvx+uFXJit3AQ2PZ0ak6O
 LPpjneRJQv4MqX7nz0nGvwQJxx2ETr/WXfaQhyThKwLufFQ6oFdYiUH155WezWZM
 8tEW0AIKTlAxcymhWO9hn6lmlcJS61WxmaVvRybeHHeL+A==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek4hvhavh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 12:52:04 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-6c152655acfso84169137.0
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 05:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780577523; x=1781182323;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XgEAN0/+gM+54F4VHBCxD3vDG/6RjDY/mUjZmgXTXkY=;
 b=YEv82R5l5MYdsb85npICyeeUZpDO8g1i59NWZi2bEgadhrTFkoqLLucRGyppA0xJbh
 HTLvUu0laOmgPoVJXO/8311ePIYIK4nu7Ncahgr47Giq8mUylWpzwxSaZxPFRRq0nNPD
 cjzbVr09kBHGm9/bkQQnliTnlMRiW62z1unhdpAGv9WLJMT691CChEXeIB4RXZx8SES0
 S/bFgDpTw/YFQnqy/RpHQM884Wn+fISbWANmqNrQD9L/qFkEzs7obSzQ0DRj3+y8juA3
 YAlo7Z0SzyaKkXbKfCGsVF18j8PrNyOaXZ+NNzqrLtbbY97HWKsdvxVZ174zOPC5Uzvg
 rzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780577523; x=1781182323;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XgEAN0/+gM+54F4VHBCxD3vDG/6RjDY/mUjZmgXTXkY=;
 b=qDtyhzIuWZR9x2BJr74TSk7cA8PydmEONRtEyr7WT4pJHyluDVnijP58wDTH4V9NeR
 zMSjKaPyLeRv/mZVdSD/8MtlOzAzRt+/zldY6hS+dfa4hrsRvRp8FWkC8eGVukhrE6lK
 XW5/w9C+CN+/xiuv18COuXEWdeoHT/dW5bxMRWV1T6TRGOWymoEvPKBXfyf4QV2uCFhC
 tEsHO2HSEnoJ78GVBSwjsg7LySC2V7ut8e5RhRyaTIbQiesGp3+l9Htp7I0HJcsCU3Tl
 U/4yL05rOkzkAuT7S4koquUy6L55SEH6XldUArXjuZRmHwVpiSZrEwh3SfwPAI/l9su9
 66nQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+H1s2M8HXs0hKokfoBxELMbq/qgYn64kMTYwh1TX0U9lNV4/OFFYFPct/zkAZBU5TxUZUK/mdsDOQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyZHRcSyLfPyGHBE1NrkaCM+DisZdWD9uM3IzuQxnW1ULo9PPLc
 heShn/DLhxWXZZ/XQSDQotisqUvidIdscYIYPjsseES+Q2VgN7q+KOE+AdZlisB4z1hU7Fwmk5w
 /J/r0z97G/tIy24HtW5rnTdivW45nx9RzdJb7VQIaEMpUMj5WHE+VEy3ZSwAVvSv5SmAbanA=
X-Gm-Gg: Acq92OH49Sy5G4cT5PSaQAeVKElSdznHSLODPQqPVydmn0gvckGzDDS2Z/ywBwzdfxM
 f+TNiQCJqttIDzQuo1TBzOp2R4NU2yajbpZDdf4j5JzJpT/H9n2AiFDTOlf+eUe0tDWx1Msn2Rt
 9dPPYPUgCvYiPOH87Hh6glVRnjnJDggxYa58Mz20jYY3cJyyFuRWcEaK+JaNL/B9O+DjKsRNRW3
 4Oo67AGlTonvNfhjnH1K0q4qeNDrI2d2knh50aNIysKIPziaaZ1ITayvO/5ooGZXRPmupckFsM7
 VY2qQcYs4qnyE9ongz14kSTCDxEdCDqcVcfeF63pgq5/Z9cj8DgcCr5qmk1djXaG15lfaL+tvRG
 DbhGP9aS0k9TGwjqPb+emlDz87H6QbQLi5YkmyhEo7cOaK94luF5JggBoCqQCQkmX2eg0z6+q3H
 kGMjwsoeY7jL/Mc3SSvu8wf+Yo2sGXuATyWA1Vx5Fxm9WMIw==
X-Received: by 2002:a05:6102:8027:b0:6a2:cfe7:20b3 with SMTP id
 ada2fe7eead31-6ec278d65d9mr4057213137.2.1780577523161; 
 Thu, 04 Jun 2026 05:52:03 -0700 (PDT)
X-Received: by 2002:a05:6102:8027:b0:6a2:cfe7:20b3 with SMTP id
 ada2fe7eead31-6ec278d65d9mr4057200137.2.1780577522595; 
 Thu, 04 Jun 2026 05:52:02 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa7b99c74esm1188940e87.81.2026.06.04.05.52.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 05:52:01 -0700 (PDT)
Date: Thu, 4 Jun 2026 15:51:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nabige Aala <nabige.aala@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: display: msm: qcm2290: Add Shikra MDSS
Message-ID: <elb6gc36lkxdbvukretqx5widqozg4tw3wbg3o7ma3fsckjueu@sruvhflcy2sm>
References: <20260604-shikra-display-v2-0-b3c1b2b67edc@oss.qualcomm.com>
 <20260604-shikra-display-v2-1-b3c1b2b67edc@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604-shikra-display-v2-1-b3c1b2b67edc@oss.qualcomm.com>
X-Proofpoint-GUID: 1wfNOpPYSX7QPfEXb-tNbI4ebewVCJaJ
X-Proofpoint-ORIG-GUID: 1wfNOpPYSX7QPfEXb-tNbI4ebewVCJaJ
X-Authority-Analysis: v=2.4 cv=Zp/d7d7G c=1 sm=1 tr=0 ts=6a2174f4 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=VFkWRHED51hAbpIxpgQA:9 a=CjuIK1q_8ugA:10
 a=-aSRE8QhW-JAV6biHavz:22 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDEyNCBTYWx0ZWRfXw6veMOlmisZu
 ywsSXvv9ju2Dex1rBmkI133UieUwaVinjm/TpST8alBpKjI8NjfmIqnXYTnCLvYl2+KffYKwsme
 3svcOk18N9cDnlXwrC/4w3wrmW7MpY0FazGsiqLhmEQr510MCo0PsDPDTS2vot2/XdMwmeq3WtC
 JsrkYlZraKFFiV//vc6KZVhA4psf4v86dbPOXDvuUHCuAXmc8EE3Ifv2XGUj2AlAH/tsFultFbf
 Qbd+fwxRs3dqu6H8FwBQeIbC/OkKicROBjb8s4K1psBLiNVhzORJYHPemHwIXAGMUf1QHABBR3R
 RI7IRM8X06sSvhwVp3op2xNkq1kyUELe/MUJhm6FojupzqzuvaDhUXCplbmt4lnq1lCngGa9F5q
 onKqyu/UnoLLhQGkzy5Wh/ihphD9WbzVtHkAM17SIvzuu2OxOHwfJyKw+LtWHXHpB+gvB1NbhED
 rHpC4iAQTLABdP4nqVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040124
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

On Thu, Jun 04, 2026 at 06:00:47PM +0530, Nabige Aala wrote:
> Shikra SoC uses the same MDSS/DPU/DSI hardware as QCM2290 (DPU 6.5),
> sharing the same register layout, DSI controller and 14nm DSI PHY.
> Add qcom,shikra-mdss to the qcm2290-mdss binding compatible enum
> rather than introducing a separate binding file.
> 
> Register qcom,shikra-dsi-ctrl in dsi-controller-main.yaml alongside
> qcom,qcm2290-dsi-ctrl, and update the qcm2290-mdss patternProperties
> to accept both SoC-specific DPU and DSI controller compatibles.
> 
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  .../bindings/display/msm/dsi-controller-main.yaml  |  1 +
>  .../bindings/display/msm/qcom,qcm2290-dpu.yaml     |  7 ++--
>  .../bindings/display/msm/qcom,qcm2290-mdss.yaml    | 38 ++++++++++++++++++----
>  3 files changed, 37 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> index dbc0613e427e..a2f3e91104af 100644
> --- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> @@ -33,6 +33,7 @@ properties:
>                - qcom,sdm660-dsi-ctrl
>                - qcom,sdm670-dsi-ctrl
>                - qcom,sdm845-dsi-ctrl
> +              - qcom,shikra-dsi-ctrl

It is the same as QCM2290. Why didn't you follow the pattern and add it
using qcm2290 one as a fallback?

>                - qcom,sm6115-dsi-ctrl
>                - qcom,sm6125-dsi-ctrl
>                - qcom,sm6150-dsi-ctrl
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
> index be6cd8adb3b6..e166a73651df 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
> @@ -13,8 +13,11 @@ $ref: /schemas/display/msm/dpu-common.yaml#
>  
>  properties:
>    compatible:
> -    const: qcom,qcm2290-dpu
> -
> +    oneOf:
> +      - const: qcom,qcm2290-dpu
> +      - items:
> +          - const: qcom,shikra-dpu
> +          - const: qcom,qcm2290-dpu
>    reg:
>      items:
>        - description: Address offset and size for mdp register set
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
> index bb09ecd1a5b4..7184b09a8774 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
> @@ -4,21 +4,36 @@
>  $id: http://devicetree.org/schemas/display/msm/qcom,qcm2290-mdss.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Qualcomm QCM220 Display MDSS
> +title: Qualcomm QCM2290 and Shikra Display MDSS
>  
>  maintainers:
>    - Loic Poulain <loic.poulain@linaro.org>
> +  - Nabige Aala <nabige.aala@oss.qualcomm.com>

Nope.

>  
>  description:
>    Device tree bindings for MSM Mobile Display Subsystem(MDSS) that encapsulates
>    sub-blocks like DPU display controller and DSI. Device tree bindings of MDSS
> -  are mentioned for QCM2290 target.
> +  are mentioned for QCM2290 and Shikra targets. Shikra uses the same MDSS/DPU/DSI
> +  hardware as QCM2290 (DPU 6.5) and shares the same register layout.
>  
>  $ref: /schemas/display/msm/mdss-common.yaml#
>  
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - qcom,qcm2290-mdss
> +  required:
> +    - compatible

Why do you need this?

> +
>  properties:
>    compatible:
> -    const: qcom,qcm2290-mdss
> +    oneOf:
> +      - const: qcom,qcm2290-mdss
> +      - items:
> +          - const: qcom,shikra-mdss
> +          - const: qcom,qcm2290-mdss
>  
>    clocks:
>      items:
> @@ -52,7 +67,11 @@ patternProperties:
>  
>      properties:
>        compatible:
> -        const: qcom,qcm2290-dpu
> +        oneOf:
> +          - const: qcom,qcm2290-dpu
> +          - items:
> +              - const: qcom,shikra-dpu
> +              - const: qcom,qcm2290-dpu
>  
>    "^dsi@[0-9a-f]+$":
>      type: object
> @@ -60,9 +79,14 @@ patternProperties:
>  
>      properties:
>        compatible:
> -        items:
> -          - const: qcom,qcm2290-dsi-ctrl
> -          - const: qcom,mdss-dsi-ctrl
> +        oneOf:
> +          - items:
> +              - const: qcom,qcm2290-dsi-ctrl
> +              - const: qcom,mdss-dsi-ctrl
> +          - items:
> +              - const: qcom,shikra-dsi-ctrl
> +              - const: qcom,qcm2290-dsi-ctrl
> +              - const: qcom,mdss-dsi-ctrl

Change this to contains:qcom,qcm2290-dsi-ctrl

>  
>    "^phy@[0-9a-f]+$":
>      type: object
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
