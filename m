Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C505C982CC
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 01:36:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB1E810E325;
	Thu, 17 Sep 2026 01:36:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NIVUo31v";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vn467n9A";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C78210E325
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 01:36:20 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GHPDEn3238306
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 01:36:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=B3DU5cPahpn7psp7SjqFFTO7
 I4tqeebDWCAKEo8WiDs=; b=NIVUo31vaSU3r5pkg/JBp8KuLWVqFvUjsSv3h+EB
 3DWFFlKb7WY9iDHHqQ2kD070fenGN7oNJYpqL7kpmCdo0O90xEbhIp9hn/1cviQo
 excxG0ZR2GEQc0/2TXpl8gt7kEBMH6hNvAcadX0E5AdYpbcKKdiJq6amd+SWfwR7
 mNVxB+hCTsTU6HDS8mgopdyahWV321p5+AR5rzPB0+BhGfpmektrg1VnS+P4Qkg6
 w0sZoznkUhG1QjngKbhH2Vj9gQlckaV3CEhvBh9jWRnrpyl6xlrLqgR3DLCLN3uF
 FPbE8Ts71VfK9QAN+FRgQPO2y/wnuv3uOk3YJxRkSs3IkQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqyga1nn7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 01:36:19 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc11b5dd54dso595197a12.3
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 18:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789608978; x=1790213778;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=B3DU5cPahpn7psp7SjqFFTO7I4tqeebDWCAKEo8WiDs=;
 b=Vn467n9AB7Uc+hu+ta9Q6AXyqdn+fVWibtNavzOB/1DuJ/8vsZvL7PXkxBiD3x3cYa
 NQxBK77/uvmFqAyyXvm43QilmMGmLjd6/JWD5G048KAphz0NpW3KtvCZcX0tmE8dAHPJ
 A3TmLbiB2SPrGWXV3joceYKu635HdRBohWTE3r+qWuOuRZuRoGBXMhW9iiAt7KSrdJiW
 iojmpF6izIqV+8X1FpfmN+KthfPdVAjCq8XG6uaeBC/wbhz56rSWytprMiAUzCGzXmpm
 yB4wi0gWuZP1j6aD7MM53K8SvOJSGGioW8/ShcDJxdwol34y1BGhrTZgHHVA/iKnunsS
 QD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789608978; x=1790213778;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=B3DU5cPahpn7psp7SjqFFTO7I4tqeebDWCAKEo8WiDs=;
 b=h1CCfl+2KWWzVvSPxf61UWxlKOtWsUaB8brcOtvqfsPmHYAHCNVR+XdMhW/Io+NaFb
 PTE8F5KrlL3MCxwH9KPghMVFMvQLLu6bDdbCsvEBZcbJ4/D98U221SyfQ4hr3jsLBKdU
 YdeUR0AVGOZ55ldUZgtyNMedFKW/SyLA7AplnckB6tzT0T7fR3lI/SljeUqCW3a3vji8
 d6tHjcMiH43eOZKr9eTqCgtjlQqg3VIN2lOIjJ0NY7M8Km6rTwSX++UqMk58FhdFxuif
 OYij9jjlEqvXRqTTcZA52r8T+xblN1Qx7blupEFqFAtzMCzLOBLpKoTJSJgZBV/l7LY3
 qVoA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzqm1pIw7hjftT/xMJijlV6eev265XtIG3DucEyVphJDwU6wTmyewVPO92fT+GTcKfxr6ect1R+kOg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kDYdQMRKzKatK5AQLRUH9lzQqO2/1RE3fB50K9e1Zjyx2IgEaj
 bKIvA61DfI5ayH9v8jmvkwqRmBu0lo6K90BMg5nnasq7HtWy/4SdYSpgmNKU4lypwrPqq1QqoyC
 AWKzSW7pGIAMm5fILXdK14yGzWDUMBbKv6i6lCiJ0IXuTKnffSagD3li6c065mCXhN+k0c6E=
X-Gm-Gg: AYBFou04FkArMLO+S+gTEluQehUA63dxUxA2DPaEoO/aRdxDNX4lgFETJuzmtcMbhoT
 m0ZtzOZE0G7yG/m1jE8t4w3LwS5M2jOHNGBsGe/tJoT4TeA8DLthdoaW07we4g4/MZ0v5ncE3mH
 PN/5BPBdtDKd9LbcIaSZCG5wTaceUafOJzWaZ5MByDfc8+eHFw//0BXhIakjeIX3MO6vOb+6+PQ
 hrAyL6ShPOmGnaJCbyfayX2B0NBT0UjRP23P/fNcygkyZGO+aD0GYGMfBtbjjZuKIyhss8iDUHX
 ANrOZ39xs+owIAUoMXA/5N+zIDaBL5hl4gtUyRVXS7KbKt7Q0AIXyWiVncA9V6Gb7iQElIR82CJ
 4Nc9ewVEnziHgMmpbDSZ1TGv35/4kCWTjCta8RHOKS+Q=
X-Received: by 2002:a05:6a20:cfa2:b0:3dd:57bf:7242 with SMTP id
 adf61e73a8af0-3dd5f456c26mr12096624637.8.1789608978051; 
 Wed, 16 Sep 2026 18:36:18 -0700 (PDT)
X-Received: by 2002:a05:6a20:cfa2:b0:3dd:57bf:7242 with SMTP id
 adf61e73a8af0-3dd5f456c26mr12096582637.8.1789608977646; 
 Wed, 16 Sep 2026 18:36:17 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bfb05e604sm9699019eec.12.2026.09.16.18.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 18:36:17 -0700 (PDT)
Date: Thu, 17 Sep 2026 09:36:08 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Nabige Aala <nabige.aala@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org,
 Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
Subject: Re: [PATCH 03/17] dt-bindings: display/msm: Document Nord MDSS
Message-ID: <aqtECDwHPiUUZqTB@QCOM-aGQu4IUr3Y>
References: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
 <20260911-nord-drv-dt-v1-3-e25c073cf1b6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-nord-drv-dt-v1-3-e25c073cf1b6@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: bTxOCPawS0CoKIgE4stPFUh6nw5tLTLl
X-Proofpoint-GUID: bTxOCPawS0CoKIgE4stPFUh6nw5tLTLl
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDAxOSBTYWx0ZWRfX3JaKo6+/cKnr
 WcqHJWNr7sh96lG5TyE+J3DlfY/j5xT2/Rh3oXuaIBflFo25L/mE0bJlq/k3jXzmnl5XD1K4n+h
 x7wZBhH5IyvRLfP4yjSLzezxy3r9FmE=
X-Authority-Analysis: v=2.4 cv=I9fw19gg c=1 sm=1 tr=0 ts=6aab4413 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=gEfo2CItAAAA:8 a=JfrnYn6hAAAA:8 a=EUspDBNiAAAA:8 a=-8PEYfhsPDB8XfM_kOAA:9
 a=CjuIK1q_8ugA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDAxOSBTYWx0ZWRfX4b3DbKmT/t/q
 xUciha++vhPGNy4feXQr9pHJwK9K8WtS7lYP7cG/B9u1wVrZVd+uX4V3gQyyBdozFnbRAlYNgp5
 Sx7ihdbFzRf5whb0KYLibVKjQWOKoB8YFUa01nQGNwcEB2N/ejIgnAs//qEI5Gz7BsTtQrRMdwF
 wDZwsA6CH8MG7nt1UMhq1OUZl6G+RywaHWJ1rtid1q4wDZqK5IeriAlXFrTXLDpNeCpWjz58Vzs
 8UiuNPL9ynxG/MXd5WCPvhg0Rm5gUv1FrmozXIwUa44vk0AlHUJuAb1bghivDJoJ89gxBY+Q4UU
 UzrVf8P5dw6tdcVYI7STzllfZNZ0oarKmuUUF0TbeTcfpteFQgW9KTUaV+U6BcINv+Iooo06XOT
 O1AxEO7Rj0EV3kJkFBcDpMrwG/59YvWoMgSumHaGBz1fommL0FxBCVjc0pWnfnHS5U/ybWxXgM0
 VW9zIH6xk5tZX257mcA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170019
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

On Fri, Sep 11, 2026 at 09:06:34PM +0530, Nabige Aala wrote:
> From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> 
> Add the binding for the display subsystem (MDSS) found on the Qualcomm
> Nord SoC. Nord is MDSS 12.1, DP-only (no DSI), with two independent DP
> controllers.
> 
> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  .../bindings/display/msm/qcom,nord-mdss.yaml       | 98 ++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,nord-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,nord-mdss.yaml
> new file mode 100644
> index 000000000000..0b0cacdca9db
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,nord-mdss.yaml
> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/msm/qcom,nord-mdss.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Nord display subsystem (MDSS)
> +
> +maintainers:
> +  - Mahadevan P <mahadevan.p@oss.qualcomm.com>
> +
> +description:
> +  Nord display subsystem consists of MDSS (display controller), DPU 1499A
> +  (display processing unit), and display interface controllers (DP only, no DSI).
> +  This is MDSS 12.1, DP-only, with 2 independent DP controllers.
> +
> +$ref: /schemas/display/msm/mdss-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: qcom,nord-mdss
> +
> +  clocks:
> +    items:
> +      - description: Display AHB
> +      - description: Display hf AXI
> +      - description: Display core
> +
> +  clock-names:
> +    items:
> +      - const: iface
> +      - const: bus
> +      - const: core
> +
> +  iommus:
> +    maxItems: 1

The DTS in downstream repository doesn't seem to agree. There is two
items for iommus.

> +
> +  interconnects:
> +    items:
> +      - description: Interconnect path from mdp0 port to the data bus
> +      - description: Interconnect path from CPU to the reg bus
> +
> +  interconnect-names:
> +    items:
> +      - const: mdp0-mem
> +      - const: cpu-cfg
> +
> +patternProperties:
> +  "^display-controller@[0-9a-f]+$":
> +    type: object
> +    additionalProperties: true
> +    properties:
> +      compatible:
> +        const: qcom,nord-dpu
> +
> +  "^displayport-controller@[0-9a-f]+$":
> +    type: object
> +    additionalProperties: true
> +    properties:
> +      compatible:
> +        const: qcom,nord-dp
> +
> +  "^phy@[0-9a-f]+$":
> +    type: object
> +    additionalProperties: true
> +    properties:
> +      compatible:
> +        const: qcom,nord-dp-phy
> +
> +required:
> +  - compatible
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,dispcc-nord.h>

Please run dt_binding_check against mainline kernel where the header is
actually qcom,nord-dispcc.h.

Shawn

> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/power/qcom,rpmhpd.h>
> +
> +    display-subsystem@ae00000 {
> +        compatible = "qcom,nord-mdss";
> +        reg = <0x0ae00000 0x1000>;
> +        reg-names = "mdss";
> +        power-domains = <&dispcc_gdsc>;
> +        clocks = <&dispcc DISPCC_MDSS_AHB_CLK>,
> +                 <&gcc GCC_DISP_HF_AXI_CLK>,
> +                 <&dispcc DISPCC_MDSS_MDP_CLK>;
> +        clock-names = "iface", "bus", "core";
> +        resets = <&dispcc DISP_CC_MDSS_CORE_BCR>;
> +        interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-controller;
> +        #interrupt-cells = <1>;
> +        iommus = <&apps_smmu 0x800 0x420>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges;
> +    };
> 
> -- 
> 2.34.1
> 
> 
> -- 
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy
