Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2396C531D0
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 20:29:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15BF110E49F;
	Mon, 27 Jul 2026 20:29:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VOccvNly";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6313710E49F;
 Mon, 27 Jul 2026 20:29:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D5B9B438CC;
 Mon, 27 Jul 2026 20:29:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07A81F000E9;
 Mon, 27 Jul 2026 20:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785184175;
 bh=hma6c/O+4dubSDjB1fhfl/X7eMkAj80EhqTMeqQfkeg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=VOccvNlyG487f3FXDFLQ+/ir23zrzc10+Fjvvnzas4sykIwsEHeuNU+vqaGx2DfsK
 mvq64BQKNGexQ0UDKrRO6W/6vKivWPz29429jBm3jpkawTdG1FQ+LrIYb7ux+EzqbM
 1/32w0U1EDq1W0H6hi1t9bx+bSqRmNTWlmkP0At6OTneAvubLe7jrQ506heaxVaUbq
 9MP0og7ev98B+3pmIr1nQ4vMUy0nvvGPRXD8KG671/9EMgqWDCxyhXrgoC2viF+TKy
 7aMHe+25qJcNh4DlhAiymQ/OT4CfgCYYcvtlB5qglJ0jCABg9MsGqX20tLlMCliklw
 TCbW3jKMcjpWw==
Date: Mon, 27 Jul 2026 22:29:31 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v5 5/6] dt-bindings: display: Add Synaptics R63455 panel
 support
Message-ID: <20260727-spotted-winged-mantis-7aa1ce@quoll>
References: <20260727-sm8650-7-1-bonded-dsi-v5-0-c042266b9eeb@linaro.org>
 <20260727-sm8650-7-1-bonded-dsi-v5-5-c042266b9eeb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260727-sm8650-7-1-bonded-dsi-v5-5-c042266b9eeb@linaro.org>
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

Not build checked. Please use tools, not humans for trivial things.

> +      - const: synaptics,r63455
> +
> +  reg:
> +    maxItems: 1
> +    description: DSI virtual channel
> +
> +  reset-gpios:
> +    maxItems: 2
> +    description: 2 reset pins for 2 physical panels

Won't work. gpio-consumer-common expects only one reset line. You need
two separate properties.

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

---

> +    dsi@ae94000 {
> +        vdda-supply = <&vreg_l3i_1p2>;
> +        status = "okay";
> +
> +        qcom,dual-dsi-mode;
> +        qcom,master-dsi;

None of above is relevant. Drop

> +
> +        panel: panel@0 {

Unused label.

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
