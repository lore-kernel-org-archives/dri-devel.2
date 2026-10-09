Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7659FCA6015
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 14:44:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD3CC1121A7;
	Fri,  9 Oct 2026 14:44:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="d3wW/zEo";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D16E1121A7
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 14:44:37 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (dynamic-2a00-1028-8389-0276-8139-a635-2d39-b80f.ipv6.o2.cz
 [IPv6:2a00:1028:8389:276:8139:a635:2d39:b80f])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id C5C35346;
 Fri,  9 Oct 2026 16:42:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1791556958;
 bh=blrsm518AbY7gsS1Fe/wV9oYiBIEFkxhkrxPCpHO4uU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=d3wW/zEolVEpicLWTjYVHNvptXBe3prTygHVLJCx+disI2aDOh2v4BUdSFDAMAtD6
 /fOCQzoNZOazwKjpSJ1/91L0OMR9OprtBQBgNlLIG2WpVBg/D+BBpWEO2UiyjNRgnC
 Z/jLFoZKS6C0NlIuGxuHbQy9mHwh32m7HRG3X/oc=
Date: Fri, 9 Oct 2026 16:44:34 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Conor Dooley <conor@kernel.org>
Cc: Quchaosheng <quchaosheng000406@163.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: display: ti,tpd12s015: Convert to DT
 schema
Message-ID: <20261009144434.GD622105@killaraus.ideasonboard.com>
References: <20261009105601.301891-1-quchaosheng000406@163.com>
 <20261009105601.301891-2-quchaosheng000406@163.com>
 <20261009-2f34bbada2c463c78b2c05a7@squawk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261009-2f34bbada2c463c78b2c05a7@squawk>
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

On Fri, Oct 09, 2026 at 03:25:49PM +0100, Conor Dooley wrote:
> On Fri, Oct 09, 2026 at 06:55:59PM +0800, Quchaosheng wrote:
> > From: Chaosheng Qu <quchaosheng000406@163.com>
> > 
> > Convert the TPD12S015 HDMI level shifter binding to DT schema.
> > 
> > The TI TPD12S015 is an HDMI companion chip that combines a level shifter
> > and ESD protection circuitry. Document the two ports it exposes between
> > the HDMI transmitter and the connector.
> > 
> > The tpd12s016 is software compatible with the tpd12s015 and is listed as
> > a fallback compatible by am57xx-idk-common.dtsi, so accept it as a
> > fallback of "ti,tpd12s015". The driver matches on "ti,tpd12s015" only, so
> > a board using the tpd12s016 must list both compatibles.
> > 
> > Assisted-by: LLM
> > Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
> 
> No idea if the sashiko reply is valid, because I have no clue if
> providing a subset of the gpios is functional. Really this should have
> multiple different gpios properties,

Definitely.

> but this binding is really old and
> not worth changing IMO.
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> pw-bot: not-applicable

I'm getting annoyed be the LLM-assisted individual conversions. Can we
start requiring people who convert text bindings to YAML to at least
handle whole groups in one go ? If they're going to do a bad job, I'd
rather have to review it once only.

> > ---
> >  .../bindings/display/ti/ti,tpd12s015.txt      | 44 ---------
> >  .../bindings/display/ti/ti,tpd12s015.yaml     | 90 +++++++++++++++++++
> >  2 files changed, 90 insertions(+), 44 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/display/ti/ti,tpd12s015.txt
> >  create mode 100644 Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.txt b/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.txt
> > deleted file mode 100644
> > index 26e6d32e3f20..000000000000
> > --- a/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.txt
> > +++ /dev/null
> > @@ -1,44 +0,0 @@
> > -TPD12S015 HDMI level shifter and ESD protection chip
> > -====================================================
> > -
> > -Required properties:
> > -- compatible: "ti,tpd12s015"
> > -
> > -Optional properties:
> > -- gpios: CT CP HPD, LS OE and HPD gpios
> > -
> > -Required nodes:
> > -- Video port 0 for HDMI input
> > -- Video port 1 for HDMI output
> > -
> > -Example
> > --------
> > -
> > -tpd12s015: encoder@1 {
> > -	compatible = "ti,tpd12s015";
> > -
> > -	gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>,	/* 60, CT CP HPD */
> > -		<&gpio2 9 GPIO_ACTIVE_HIGH>,	/* 41, LS OE */
> > -		<&gpio2 31 GPIO_ACTIVE_HIGH>;	/* 63, HPD */
> > -
> > -	ports {
> > -		#address-cells = <1>;
> > -		#size-cells = <0>;
> > -
> > -		port@0 {
> > -			reg = <0>;
> > -
> > -			tpd12s015_in: endpoint@0 {
> > -				remote-endpoint = <&hdmi_out>;
> > -			};
> > -		};
> > -
> > -		port@1 {
> > -			reg = <1>;
> > -
> > -			tpd12s015_out: endpoint@0 {
> > -				remote-endpoint = <&hdmi_connector_in>;
> > -			};
> > -		};
> > -	};
> > -};
> > diff --git a/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml b/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml
> > new file mode 100644
> > index 000000000000..1927da3bd736
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml
> > @@ -0,0 +1,90 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/ti/ti,tpd12s015.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: TI TPD12S015 HDMI level shifter and ESD protection chip
> > +
> > +maintainers:
> > +  - Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> > +
> > +description: |
> > +  The TPD12S015 is an HDMI companion chip that combines a level shifter and
> > +  ESD protection circuitry. It sits between an HDMI transmitter and the HDMI
> > +  connector, and provides control over the level shifter enable and the
> > +  hot-plug detect signals.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - const: ti,tpd12s015
> > +      - items:
> > +          - const: ti,tpd12s016
> > +          - const: ti,tpd12s015
> > +
> > +  gpios:
> > +    description:
> > +      The CT CP HPD, LS OE and HPD GPIOs, in that order. The first controls
> > +      the level shifter, the second enables the level shifter outputs and
> > +      the third reads the hot-plug detect line.
> > +    maxItems: 3
> > +
> > +  ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +
> > +    properties:
> > +      port@0:
> > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > +        unevaluatedProperties: false
> > +        description: HDMI input from the transmitter.
> > +
> > +      port@1:
> > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > +        unevaluatedProperties: false
> > +        description: HDMI output to the connector.
> > +
> > +    required:
> > +      - port@0
> > +      - port@1
> > +
> > +required:
> > +  - compatible
> > +  - ports
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    encoder1 {
> > +        compatible = "ti,tpd12s015";
> > +
> > +        gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>,    /* 60, CT CP HPD */
> > +                <&gpio2 9 GPIO_ACTIVE_HIGH>,    /* 41, LS OE */
> > +                <&gpio2 31 GPIO_ACTIVE_HIGH>;    /* 63, HPD */
> > +
> > +        ports {
> > +            #address-cells = <1>;
> > +            #size-cells = <0>;
> > +
> > +            port@0 {
> > +                reg = <0>;
> > +
> > +                tpd12s015_in: endpoint {
> > +                    remote-endpoint = <&hdmi_out>;
> > +                };
> > +            };
> > +
> > +            port@1 {
> > +                reg = <1>;
> > +
> > +                tpd12s015_out: endpoint {
> > +                    remote-endpoint = <&hdmi_connector_in>;
> > +                };
> > +            };
> > +        };
> > +    };
> > +
> > +...

-- 
Regards,

Laurent Pinchart
