Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D537CD8C85
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 12:23:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ABC7112DF2;
	Sat,  6 Jun 2026 12:23:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WBmeTuPI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VZ/cXhQW";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53327112DF2
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 12:23:10 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 656BDs221329267
 for <dri-devel@lists.freedesktop.org>; Sat, 6 Jun 2026 12:23:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=CACWQZmD4R6XLQ6GUpqLrmsN
 jTowQtAT8WsqwDHWPdg=; b=WBmeTuPIOwbj+d1qhz3dLCw/DxKcDzYN36fVQCa7
 MzqzyPGZ5yNuJvDk5V7qEnXnGW0mtIM33IIH6w0A80MLFDoP2KoMDxG/l07B6D6n
 NH10gHN7+BCOTTtMiI/B85/yLHwOeAKr68Q4KZF4NmrZD0wS2fI/5uP01yVK6l/x
 xm+ijz0lWyd0LYGdJHgtH9sMH6KVCa04fgsRQeWGOsor9btSqR4eLuP8qYVA4opQ
 iMj7pKTJIeyS+LW9wR3Tn2awb6DgOJ7+I0/POtGuYVOQ9QNoMujVAUB3zV/rEn7F
 9WcInIola8DuFHFAuMWEQlDy5jt1WYnSwrJICXSxLS7wKA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embs18y5f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 06 Jun 2026 12:23:09 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-963eeb6f2baso3074732241.0
 for <dri-devel@lists.freedesktop.org>; Sat, 06 Jun 2026 05:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780748589; x=1781353389;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CACWQZmD4R6XLQ6GUpqLrmsNjTowQtAT8WsqwDHWPdg=;
 b=VZ/cXhQWSEMBc4oKLcCF1CayGE9hin24H5O+XYZtjMxkf5tA2SmcvZLHh7bMBU+K3a
 NIyRT7VsJhzfiZ+5g0on8tCuNnQ/cYqibbuv8USDduMprRxYGAUneWlXi2pivhQmE4Sq
 gC/3Yo8pd6lY+YuEXTg+dmNkIPZhXe3xRy0qF4+S88tzCY+N1ACGO14AxDQXFZcKnthH
 YQALj8z+XS++Lp33SZ+zAx56nGp6TR0Px4p8CgEYlHpDWObBMnR+l3NssINWqYo1fQpZ
 ZM4XpgOfqbnoD+lRTbaOHVDll2p+LDhziMGZe9qM0GjFrfvN4UWBPmQYXKXNEoa/z4Ii
 1H/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780748589; x=1781353389;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CACWQZmD4R6XLQ6GUpqLrmsNjTowQtAT8WsqwDHWPdg=;
 b=Wd6pEAdVDm9fFv6NiZixwb2DPegpCkDbRyoXOZgVr6uk+/74xmBbTiwEjSrZVNMPWz
 njYExf8c+qoJWbjSLR8Ut4O1Q/V11pDaMsFQbIsRpxUCmBYlQlWEsfdJyKdkz4ssbE9h
 F+W/WeyeK+aoW2HGvM1rasb54aGwVFDIUfC1KMKXA7nNpQCwlRnBKjwifTfJWEQg0sgU
 64wuE+Qgc/GDEGr5ckTgr6KwvzQOKQUyYAoPZN8JJUABQeeYdomhfmqL5mbMPR+p6Vxt
 kZavSiDDYNtpttTJUNbeITG1roogrtimafd9mxF1RP2QhyjevJgmsMzvFBlze9lV9kjw
 jpFw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9/OyuSOCZ/k84r8t1Q9+xYl2SShnkdYRZKWulgdOY0OcRStVSVnwoLPO10JPuv1AoquVa6ZJdThoI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxex1TnFDQxqPLBGK8bQDCpSH+movkwNdFO1Yegy/IfS11Sz6YF
 GPUaiTrHO9DEoTTGmlcARUhfch0NkXc4W6HrFr5r1sAA2msCCcDMs2HUqpcoYjUZzkjTZhkAcOU
 M+veWxWGONpa6NwWIbmciuNvbtM4ZaPF6KHT1rPaNshk/tt8pLJnoa1CNuXOYF9weWIwSFco=
X-Gm-Gg: Acq92OEXBTNXP94SdLUyhfwfgpSRItKs5HAn7/q8ax8dgwceiq44XazM+smeMFRKrgE
 QgQ66sYbsg1D9a4gN3cSErJccbK7sn1QwU2kY1svib/FcZ3Qz/xOpxzzhFIQLoDBLWSvHNi5doZ
 InTCsY0gpRrQr02bhh5eLOaVHCJpLj5PKVTYJTX+8BHutsPcHF826hrSR2Qhds8+5BHixHNHZq5
 wZhNUk9Z6L2hDiWphZ33drz0SlxTDXHZ3+MwFPP+kJYUJUM4j342CM+9UkafkecbP4bdWGzA1d/
 TCtRKQg1bbVHPdyo3YA2lkTObNJIVFNyV+MVQIRvcYCUZqjlWMalW27wFUPG37F72PVWUcCNA7r
 N6vVk9n9FRpwJS3WcQr7xJAbXq6dvBP0IOWBGmsXxkLSCMTldF1tNgvDpJveJsQvX7cYO2lrBjv
 O/Vo0sBdGiPPpCrYWM1D6vaqdit2cSBjciOEM+unfhxQ1o5g==
X-Received: by 2002:a05:6102:f14:b0:631:4c79:b1e8 with SMTP id
 ada2fe7eead31-6ff0afefe3dmr3974197137.22.1780748588666; 
 Sat, 06 Jun 2026 05:23:08 -0700 (PDT)
X-Received: by 2002:a05:6102:f14:b0:631:4c79:b1e8 with SMTP id
 ada2fe7eead31-6ff0afefe3dmr3974174137.22.1780748588296; 
 Sat, 06 Jun 2026 05:23:08 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa7b97ac34sm2444082e87.39.2026.06.06.05.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 05:23:07 -0700 (PDT)
Date: Sat, 6 Jun 2026 15:23:05 +0300
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
Subject: Re: [PATCH v3 1/3] dt-bindings: display: msm: qcm2290: Add Shikra MDSS
Message-ID: <fphua2bsw36libxqkrfubnaybvdtwncplddhexx26dtbjir7ov@jvmu4avug54z>
References: <20260605-shikra-display-v3-0-9846ba5fe635@oss.qualcomm.com>
 <20260605-shikra-display-v3-1-9846ba5fe635@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605-shikra-display-v3-1-9846ba5fe635@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDEyNCBTYWx0ZWRfXxZ6ma+p+XI7o
 pEQ+i8RgcoORJbSJQdxyM2W6AsTM0ps53zMH5DVl+mApMkgEVRU+lDUR/sNYCe9Z+LQKC4Mtrog
 GUDMKmYKnZ9V7HmIpE6AqLXkb/g3LO8DD19WqMzR6hV6TqR6mUHZ71uptlWWbFZ98psZbTNkQ8D
 o3o3IpQE5c1mi6VfWMw5TRXprnL00TfSQ6jiM6p1nbdUe0VDAlii274P+hhw4dphVxGEuR8k9lm
 LYGxyXv69sunkuDHEaVlRIQLubQ0qYZFqT8WYRn7LKcLE9EOPwXgpirmn/bpRRNmmwFQYy+nLIZ
 nI26i6uK2Pn3p3u35Qi+6Yp7x4dwE/71Wy57/0EWPnhA8ntarZ+EIdKICigDirXfbqSR+u9dxHD
 vBmXMDPgkYGh9XGLLpJCQYkdpoF0unGdUpeXXsTboPOBiBSJXw08z4bx3sxva9klaWiJpUACgqT
 H6A4p/rJMpBEgzbqctw==
X-Authority-Analysis: v=2.4 cv=CeY4Irrl c=1 sm=1 tr=0 ts=6a24112d cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=jtPkKwLRCkpF2dlEjY4A:9 a=CjuIK1q_8ugA:10
 a=1WsBpfsz9X-RYQiigVTh:22 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: OjSbOl3OYGSIiN3j7oseC_8F21YDaVIA
X-Proofpoint-GUID: OjSbOl3OYGSIiN3j7oseC_8F21YDaVIA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606060124
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

On Fri, Jun 05, 2026 at 03:48:51PM +0530, Nabige Aala wrote:
> Shikra reuses the same MDSS/DPU 6.5 hardware as QCM2290. Extend
> the existing qcm2290 bindings to cover Shikra by adding fallback
> compatible chains for MDSS, DPU and DSI controller nodes rather
> than introducing a separate binding file.
> 
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  .../bindings/display/msm/dsi-controller-main.yaml  |  4 ++++
>  .../bindings/display/msm/qcom,qcm2290-dpu.yaml     |  7 +++++--
>  .../bindings/display/msm/qcom,qcm2290-mdss.yaml    | 22 +++++++++++++++-------
>  3 files changed, 24 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> index dbc0613e427e..ab2cfd6d6e3e 100644
> --- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> @@ -57,6 +57,10 @@ properties:
>            - const: qcom,eliza-dsi-ctrl
>            - const: qcom,sm8750-dsi-ctrl
>            - const: qcom,mdss-dsi-ctrl
> +      - items:
> +          - const: qcom,shikra-dsi-ctrl
> +          - const: qcom,qcm2290-dsi-ctrl
> +          - const: qcom,mdss-dsi-ctrl

Wrong sort order, qcm2290 < sm8750

>        - enum:
>            - qcom,dsi-ctrl-6g-qcm2290
>            - qcom,mdss-dsi-ctrl # This should always come with an SoC-specific compatible
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
> index bb09ecd1a5b4..ef21b2c263f2 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/display/msm/qcom,qcm2290-mdss.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Qualcomm QCM220 Display MDSS
> +title: Qualcomm QCM2290 and Shikra Display MDSS
>  
>  maintainers:
>    - Loic Poulain <loic.poulain@linaro.org>
> @@ -12,13 +12,18 @@ maintainers:
>  description:
>    Device tree bindings for MSM Mobile Display Subsystem(MDSS) that encapsulates
>    sub-blocks like DPU display controller and DSI. Device tree bindings of MDSS
> -  are mentioned for QCM2290 target.
> +  are mentioned for QCM2290 and Shikra targets. Shikra uses the same MDSS/DPU/DSI
> +  hardware as QCM2290 (DPU 6.5) and shares the same register layout.
>  
>  $ref: /schemas/display/msm/mdss-common.yaml#
>  
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
> @@ -52,7 +57,11 @@ patternProperties:
>  
>      properties:
>        compatible:
> -        const: qcom,qcm2290-dpu
> +        oneOf:
> +          - const: qcom,qcm2290-dpu
> +          - items:
> +              - const: qcom,shikra-dpu
> +              - const: qcom,qcm2290-dpu

Use contains:

>  
>    "^dsi@[0-9a-f]+$":
>      type: object
> @@ -60,9 +69,8 @@ patternProperties:
>  
>      properties:
>        compatible:
> -        items:
> -          - const: qcom,qcm2290-dsi-ctrl
> -          - const: qcom,mdss-dsi-ctrl
> +        contains:
> +          const: qcom,qcm2290-dsi-ctrl
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
