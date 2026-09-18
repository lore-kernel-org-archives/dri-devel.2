Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0001FC982D7
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 21:35:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C21B910E177;
	Fri, 18 Sep 2026 21:35:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="U3D8k9lf";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55DBA10E177
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 21:35:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 81CE9408ED;
 Fri, 18 Sep 2026 21:35:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333951F000FF;
 Fri, 18 Sep 2026 21:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789767320;
 bh=ej3xKpckrpjvUc2u6qoLx+3TMAOcBxUdzeIFFyYah/c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=U3D8k9lfVGUmG3mrLdr956SF7/Qr5CBRsP2flicGDEQ75+/x23Gz7gEdh0FeSfeOc
 PtLQM0QAfD4jSijXXjL4vzXI/6kdfmRD88xSJ3dmf+R3sAyp21mlzRfKw1lTn0TlzF
 hqAhbwz9JnTygIoS1AqYKAxjH+LxQNrOjuS/SYtCmlfLlojf8j18w8Z9scv2QOkyBp
 atgWD6pI9o9jsvuHdvoiMD7K1I57B49g/DdD+oFyuxRM89OeePA1MRjBeXiiHtFqZP
 1dax3Bv/8ODg6IBwW/ZFtA5wD5LFllEGvbfA4UlFc84SJQItxe8xF9MlnBv/5mbZST
 GvNXUIA+atX0A==
Date: Fri, 18 Sep 2026 16:35:18 -0500
From: Rob Herring <robh@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: display: panel: Add Novatek NT37705
Message-ID: <20260918213518.GA2337779-robh@kernel.org>
References: <20260918-fp6-panel-v2-0-6695c4008920@fairphone.com>
 <20260918-fp6-panel-v2-1-6695c4008920@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918-fp6-panel-v2-1-6695c4008920@fairphone.com>
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

On Fri, Sep 18, 2026 at 04:40:04PM +0200, Luca Weiss wrote:
> Novatek NT37705 is a display driver IC used to drive AMOLED DSI panels.
> 
> Describe it and the panel in the Fairphone (Gen. 6) (BJ631JHM-T71-D900
> from BOE) using it.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Link: https://lore.kernel.org/r/81a3c207-4d8f-490f-8e2a-6f3f4c2acd35@kernel.org/
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  .../bindings/display/panel/novatek,nt37705.yaml    | 72 ++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt37705.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt37705.yaml
> new file mode 100644
> index 000000000000..1c796599f6fc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/novatek,nt37705.yaml

Did novatek,nt37705 get dropped as a compatible, but the filename 
remains?

> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/novatek,nt37705.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Novatek NT37705-based DSI display panels
> +
> +maintainers:
> +  - Luca Weiss <luca.weiss@fairphone.com>
> +
> +description:
> +  The Novatek NT37705 is a generic DSI Panel IC used to control AMOLED panels.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    contains:

As sashiko reports, "contains" is too loose.

> +      const: boe,bj631jhm-t71-d900
> +
> +  reg:
> +    maxItems: 1
> +
> +  vddio-supply:
> +    description: I/O voltage rail
> +
> +  dvdd-supply:
> +    description: Digital voltage rail
> +
> +  vci-supply:
> +    description: Analog voltage rail
> +
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios
> +  - vddio-supply
> +  - dvdd-supply
> +  - vci-supply
> +  - port
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dsi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        panel@0 {
> +            compatible = "boe,bj631jhm-t71-d900";
> +            reg = <0>;
> +
> +            reset-gpios = <&tlmm 12 GPIO_ACTIVE_LOW>;
> +
> +            vci-supply = <&vreg_l19b>;
> +            vddio-supply = <&vreg_l9b>;
> +            dvdd-supply = <&vreg_oled_dvdd_1p2>;
> +
> +            port {
> +                panel_in_0: endpoint {
> +                    remote-endpoint = <&dsi0_out>;
> +                };
> +            };
> +        };
> +    };
> +
> +...
> 
> -- 
> 2.55.0
> 
