Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E99C9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 16:27:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 817EC10EF9D;
	Tue, 29 Sep 2026 16:27:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bzKQ1LX0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cwFtRIvj";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A46B910EF94
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 16:27:16 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TCvs5R3300547
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 16:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=KrUCqsYTgbbcxI69a3MU7CHs
 c2hnXpP31LHoTjuw12A=; b=bzKQ1LX0ioMfaRQtFaoYw7wNI1TygoxmCOdaQ0UN
 2YjQsP+xr2FcYaTgM9auQI5uY+fAj4E/3jINOGwTIePoraoBYolDSQqIdL3ulMbL
 z6F9rM3+bIeaGFigLjZ5E8k0xXi5ue7UXZhcyDENA41YeWo3I3s5Gs5xtR+pJ1Mm
 p1ao/4TBFV4WSIfoAlYdxflUJiuHHVFNojspPP931hcLWtnZxYw/zqzT5Qq9M7RU
 wO6RM7oK84bDOyccJaGgfNpHpa8lJ/VECG5BZkImGyxWQ+CB16tPV7FLQjGHUgOk
 L9a/zczwG5ivEl6nxK4MgYQm1DNyltCTAhXhFB4Y2ru2jw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0dsx10tv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 16:27:15 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7a04805f8f1so3657034137.3
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 09:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790699235; x=1791304035;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KrUCqsYTgbbcxI69a3MU7CHsc2hnXpP31LHoTjuw12A=;
 b=cwFtRIvjUQsLWthp47qXZ15aZh1LlSfPkycEkvCjyY3WVweocirZ1aRByHEzAPekCq
 yi0AYAMBcrgEnQphBZu1PsvBm7Qb6JnzKvZlvEiflw40vQPTjCE9xfmXOakPf6PuVcGm
 noptLw/2II4Il6vf7KkLklSGDge6Osn5EagNQBrhVM72xhJm8ZL8H5sK83FGap5LFa2T
 3ooSjID5wwj40N6kDO0Cjd+LXPdVs8RAbwYBsRmjCUqPV1JAEuVoMCLIHv++uykYqDGL
 p1dJK8gN7G2fZ80puZOVU2QFKv5llPt0jDfH0f32WPFfDeNRRd0uVLgY8U2WrZaI1cRI
 gTUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699235; x=1791304035;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KrUCqsYTgbbcxI69a3MU7CHsc2hnXpP31LHoTjuw12A=;
 b=2eKrGNdFLbPdvz3a0tQpt/znwTExEvy1iKlYHOLfe1mgD2lgiGA9yLh3KRB/B6Y34L
 3xNkKUDCU2rvqNczBeDfjlc/QMryV7HbxgKQS4Khk7srvktrXKH7YfX30PIuLqNjs4i4
 A/jwn6w5lLp+SLewPYmr6nfjS2tgZgLgZMD1njief/NEiAVS1AmHqL4+4tlA0HMf2paY
 wUNPjJD4qlMpiu9JMOnv3qJRA/0HgfGrLzNaBe0mu+SltRukp12OzbLSvwVyRXTE7eUt
 tdfFJDAH9CWUfYQa7q6Z06q2Hy3rYGMtWTkoMV0+ke85I9q/Utpl2cujFgfuUG0nrXiA
 +wig==
X-Forwarded-Encrypted: i=1;
 AKwUvByfNLeTQRojTAXHKjaqhxkZrPp6A3gaqhxpF/EYDlBVMWh4/Pd+ds/AA8goyZCK50m0wruPmuuLVKI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIC+vtfjmlSOBZuk9xbxb1FGm/gGmd/ebF1l3USoHAPHB65kFCO
 8zZJDGuD7f8UeqxVHViCEXEiNCkKGjjM7W3N4+gbJD7MHrA+1NzH+KsKoKlk260kcJO9o5LtJPX
 J+1u9CWDVmPMw37CoPSgu9nhi8lp3UY6EYyp3dEFdldWXvUQAy5S2PYIo0QJp0WDRJ5itLzU=
X-Gm-Gg: AYBFou2Y8jMld0BZzWnDcT1dDIykSUQL/7m+KG+L8KbWn1oh3vUgyRUF9wZiz+lL9u0
 uuFH452c6zH8rT6Q9QIrSFVMgeq2EB5S3ON+HoMLcX5+ZyV8Ha8FU6MGK+LME98FMZkOYNzWH22
 7VqHkXJYPwHWko6rRLDXdDY/BhRSRFtiBQXNTfcI13V8qbC29rEPqVpesszpB6sszKiT57KdGNd
 QDQRMbGcBoP8//n79UFKrDyBLW38/28g5FvezPpFczof74WA84GgUlCadQKIewsrb/HtY3GZKAr
 nZ439WiS/ulufrbvlo+1OO850TZE3MZoa4UHPV6tl6Xc/jYIUOssNWakrjnmrwFhoA0u8kFj8Re
 KZJZzKgrTWrmazl5hM1xWITjGl5IPzF00bMNMzATd/GEFQtvihDJ7YcwOJhoOSjivy97JZHSS2p
 dOh4sSL80X3NWL
X-Received: by 2002:a05:6102:8508:10b0:7b4:2acd:fb9a with SMTP id
 ada2fe7eead31-7bc3d68f8d2mr11483137.25.1790699234758; 
 Tue, 29 Sep 2026 09:27:14 -0700 (PDT)
X-Received: by 2002:a05:6102:8508:10b0:7b4:2acd:fb9a with SMTP id
 ada2fe7eead31-7bc3d68f8d2mr11463137.25.1790699234157; 
 Tue, 29 Sep 2026 09:27:14 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a77171003bsm115851fa.3.2026.09.29.09.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:27:12 -0700 (PDT)
Date: Tue, 29 Sep 2026 19:27:11 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 5/6] dt-bindings: display: Add Synaptics R63455 panel
 support
Message-ID: <2iiownhw67anqqcxgvfff3gyejjzwwfxtcy4kvst5j5yg7hiy2@bry4ol7alvp6>
References: <20260727-sm8650-7-1-bonded-dsi-v5-0-c042266b9eeb@linaro.org>
 <20260727-sm8650-7-1-bonded-dsi-v5-5-c042266b9eeb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727-sm8650-7-1-bonded-dsi-v5-5-c042266b9eeb@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA2NSBTYWx0ZWRfX2gdbn2jH1IFD
 FuOXNf2m0PANFKFkdqSIWPcSFWa9kSJM0NEWnR+Pow5fTx52KaHMCAKWp11pQUMB8kal+L0/Gtn
 kdFvCoPD4lWmynztm2adSiZboYSUkjZamNe+haOfXWWcZECO7vXjx+pKgv6S6e92jDeOU05yXP/
 aQtt/JYQP5oFDENdIYfa6+0HLXc0LM9MbBnFkqmKQ0bY2hg59u4kvvm5+RfxQQUt3N85aFW1NHP
 5kXtrMq1LKnyuhWqkioLLQQwX32dTs3yRiIN/V/uk0ENcY/DidlodpsD4WzDze9rPbM6JF8rIqk
 BKPxYcL0qD26RhSzge2a5gA6OeesoyhczV1hqNp+iZG26ROJLp603XgtNsSYCW2/hz6v2lRJWY8
 MnzUyQfRHUI7ZjeJCgMaCUdyBmgi4X1PpeCZPdLKKr0QvZdKQLP/iKwm82gyz8Yy4pIkZ9AQiWE
 VIdMIV4x2rRCKhVWodQ==
X-Proofpoint-ORIG-GUID: E2qH5B2kzgKTIK5O6O3BNlLaBucKAeMs
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA2NSBTYWx0ZWRfXxBwLJPSiy3O9
 KJNgB5Ojncv1IsyWjIMzD6C4baVUHrpw+Eeh6M87f5oPUw2M5g5xQCcvtI/MNEmCcG8CmSQbtb5
 N5+wEy8ux91+O7vFgG6m9QwN4L8yrbI=
X-Proofpoint-GUID: E2qH5B2kzgKTIK5O6O3BNlLaBucKAeMs
X-Authority-Analysis: v=2.4 cv=DqvDa2/+ c=1 sm=1 tr=0 ts=6abbe6e4 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=gEfo2CItAAAA:8
 a=KKAkSRfTAAAA:8 a=5IMEwuT189ni8Q75ZTYA:9 a=CjuIK1q_8ugA:10
 a=gYDTvv6II1OnSo0itH1n:22 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 adultscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290065
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

On Mon, Jul 27, 2026 at 04:08:44PM +0800, Jun Nie wrote:
> Add support for the dual-panel system found in the virtual reality device.
> This system consists of two physical 2160x2160 panels, each connected via
> a MIPI DSI interface. The backlight is managed through DSI link.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  .../bindings/display/panel/synaptics,r63455.yaml   | 133 +++++++++++++++++++++
>  1 file changed, 133 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/synaptics,r63455.yaml b/Documentation/devicetree/bindings/display/panel/synaptics,r63455.yaml
> new file mode 100644
> index 0000000000000..c3bc8df981df7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/synaptics,r63455.yaml
> @@ -0,0 +1,133 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/synaptics,r63455.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synaptics R63455 based dual 2160x2160 MIPI-DSI Panel
> +
> +maintainers:
> +  - Jun Nie <jun.nie@linaro.org>
> +
> +description:
> +  Synaptics R63455 is a Virtual Reality Display Driver and VR Bridge, used in
> +  pair in Headset devices. The Virtual Reality Display complex is composed of
> +  two strictly identical display panels, each driven by its own DSI interface
> +  but forms a single virtual display for the human eye perception and thus
> +  requires a strict synchronization of the two display panel content update.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +        - sharp,ls026b3sa06
> +        - boe,vs026c4m-n52-6000
> +      - const: synaptics,r63455

Judging by the Synaptics presentation at MIPI devcon 2018, R63455 is a
DDIC which supports only one panel. The VR bridge (in their case it was
VXR7200) drives two separate R63455-based panels. As such, I'd assume,
that this hardware description is not 100% correct.

> +
> +  reg:
> +    maxItems: 1
> +    description: DSI virtual channel
> +
> +  reset-gpios:
> +    maxItems: 2
> +    description: 2 reset pins for 2 physical panels
> +
> +  left-pos-supply:
> +    description: Positive 5.7V supply for left panel
> +
> +  right-pos-supply:
> +    description: Positive 5.7V supply for right panel
> +
> +  left-neg-supply:
> +    description: Negative 5.7V supply for left panel
> +
> +  right-neg-supply:
> +    description: Negative 5.7V supply for right panel
> +
> +  left-backlight-supply:
> +    description: Backlight 21V supply for left panel
> +
> +  right-backlight-supply:
> +    description: Backlight 21V supply for right panel
> +
> +  vdda-supply:
> +    description: core 1.8V supply for panels
> +
> +  ports:
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: DSI input port for primary DSI link
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: DSI input port for secondary DSI link
> +
> +    required:
> +      - port@0
> +      - port@1
> +
> +required:
> +  - compatible
> +  - reset-gpios
> +  - left-pos-supply
> +  - left-neg-supply
> +  - right-pos-supply
> +  - right-neg-supply
> +  - left-backlight-supply
> +  - right-backlight-supply
> +  - vdda-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dsi@ae94000 {
> +        vdda-supply = <&vreg_l3i_1p2>;
> +        status = "okay";

There is no need for the status in DT examples.

> +
> +        qcom,dual-dsi-mode;
> +        qcom,master-dsi;
> +
> +        panel: panel@0 {
> +            compatible = "sharp,ls026b3sa06", "synaptics,r63455";
> +            reg = <0>;
> +
> +            reset-gpios = <&pm8550_gpios 3 GPIO_ACTIVE_HIGH>,
> +                          <&pm8550_gpios 11 GPIO_ACTIVE_HIGH>;
> +
> +            left-pos-supply = <&vpos_left>;
> +            left-neg-supply = <&vneg_left>;
> +            right-pos-supply = <&vpos_right>;
> +            right-neg-supply = <&vneg_right>;
> +            left-backlight-supply = <&backlight_left>;
> +            right-backlight-supply = <&backlight_right>;
> +
> +            vdda-supply = <&vreg_l12b_1p8>;
> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                port@0 {
> +                    reg = <0>;
> +                    panel0_in: endpoint {
> +                        remote-endpoint = <&dsi0_out>;
> +                    };
> +                };
> +
> +                port@1 {
> +                    reg = <1>;
> +                    panel1_in: endpoint {
> +                        remote-endpoint = <&dsi1_out>;
> +                    };
> +                };
> +            };
> +        };
> +    };
> +
> +...
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
