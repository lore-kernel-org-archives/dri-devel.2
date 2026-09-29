Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC7B6CA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:12:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A32C10E9C9;
	Tue, 29 Sep 2026 12:12:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="TVoQZoOV";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9834110E9C9
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 12:12:38 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id CB7A1C3D;
 Tue, 29 Sep 2026 14:10:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1790683846;
 bh=U/ZHELYrFaEQ3sMrE4JTj1Tft7dlNbybWNXd2onWZC4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TVoQZoOVXSlL3imsxqA+YRdzmqVNKSSBcyPWf0ItcyDgxMXTB+5QfgN1koH048ewZ
 LplOn4ENq5q8R/xUvbiMQT683fj65wqVWu1PG8ks6E8kXrtnFQ/ESYJU6wAof0ZnYk
 0pS8WNIHQuKJml/psm1hVLdZbz34gzwlgU0e3uOo=
Date: Tue, 29 Sep 2026 15:12:35 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Quchaosheng <quchaosheng000406@163.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>,
 Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: ti,tpd12s015: Convert to DT
 schema
Message-ID: <20260929121235.GF171869@killaraus.ideasonboard.com>
References: <20260915120327.47114-1-quchaosheng000406@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260915120327.47114-1-quchaosheng000406@163.com>
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

On Tue, Sep 15, 2026 at 08:03:26PM +0800, Quchaosheng wrote:
> Convert the TPD12S015 HDMI level shifter binding to DT schema.
> 
> The TI TPD12S015 is an HDMI companion chip that combines a level shifter
> and ESD protection circuitry. Document the two ports it exposes between
> the HDMI transmitter and the connector.
> 
> The tpd12s016 is described as software compatible with the tpd12s015 and
> is listed as a fallback compatible by am57xx-idk-common.dtsi, so accept
> both orderings. Boards that also route the DDC lines through the chip
> pass five GPIOs rather than three.

Assisted-by tag missing.

This patch also seems to be missing understanding of what you're doing.
Not only does it combine conversion to YAML and changes to the bindings
in one patch, it also gives no rationale for the changes.

Please don't waste maintainer's time with LLM-generated patches that you
haven't tried to understand.

> Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
> ---
>  .../bindings/display/ti/ti,tpd12s015.txt      | 44 ---------
>  .../bindings/display/ti/ti,tpd12s015.yaml     | 93 +++++++++++++++++++
>  2 files changed, 93 insertions(+), 44 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/ti/ti,tpd12s015.txt
>  create mode 100644 Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.txt b/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.txt
> deleted file mode 100644
> index 26e6d32e3..000000000
> --- a/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.txt
> +++ /dev/null
> @@ -1,44 +0,0 @@
> -TPD12S015 HDMI level shifter and ESD protection chip
> -====================================================
> -
> -Required properties:
> -- compatible: "ti,tpd12s015"
> -
> -Optional properties:
> -- gpios: CT CP HPD, LS OE and HPD gpios
> -
> -Required nodes:
> -- Video port 0 for HDMI input
> -- Video port 1 for HDMI output
> -
> -Example
> --------
> -
> -tpd12s015: encoder@1 {
> -	compatible = "ti,tpd12s015";
> -
> -	gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>,	/* 60, CT CP HPD */
> -		<&gpio2 9 GPIO_ACTIVE_HIGH>,	/* 41, LS OE */
> -		<&gpio2 31 GPIO_ACTIVE_HIGH>;	/* 63, HPD */
> -
> -	ports {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		port@0 {
> -			reg = <0>;
> -
> -			tpd12s015_in: endpoint@0 {
> -				remote-endpoint = <&hdmi_out>;
> -			};
> -		};
> -
> -		port@1 {
> -			reg = <1>;
> -
> -			tpd12s015_out: endpoint@0 {
> -				remote-endpoint = <&hdmi_connector_in>;
> -			};
> -		};
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml b/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml
> new file mode 100644
> index 000000000..b3351b601
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml
> @@ -0,0 +1,93 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/ti/ti,tpd12s015.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI TPD12S015 HDMI level shifter and ESD protection chip
> +
> +maintainers:
> +  - Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> +
> +description: |
> +  The TPD12S015 is an HDMI companion chip that combines a level shifter and
> +  ESD protection circuitry. It sits between an HDMI transmitter and the HDMI
> +  connector, and provides control over the level shifter enable and the
> +  hot-plug detect signals.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: ti,tpd12s015
> +      - items:
> +          - const: ti,tpd12s016
> +          - const: ti,tpd12s015
> +
> +  gpios:
> +    description:
> +      The CT CP HPD, LS OE and HPD GPIOs, in that order. The first GPIO
> +      controls the level shifter, the second enables the level shifter
> +      outputs and the third reads the hot-plug detect line. Boards that
> +      also route the DDC lines through the chip use five entries, with
> +      the SCL and SDA GPIOs appended.
> +    minItems: 3
> +    maxItems: 5
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: HDMI input from the transmitter.
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: HDMI output to the connector.
> +
> +    required:
> +      - port@0
> +      - port@1
> +
> +required:
> +  - compatible
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    encoder1 {
> +        compatible = "ti,tpd12s015";
> +
> +        gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>,    /* 60, CT CP HPD */
> +                <&gpio2 9 GPIO_ACTIVE_HIGH>,    /* 41, LS OE */
> +                <&gpio2 31 GPIO_ACTIVE_HIGH>;    /* 63, HPD */
> +
> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            port@0 {
> +                reg = <0>;
> +
> +                tpd12s015_in: endpoint {
> +                    remote-endpoint = <&hdmi_out>;
> +                };
> +            };
> +
> +            port@1 {
> +                reg = <1>;
> +
> +                tpd12s015_out: endpoint {
> +                    remote-endpoint = <&hdmi_connector_in>;
> +                };
> +            };
> +        };
> +    };
> +
> +...
> 

-- 
Regards,

Laurent Pinchart
