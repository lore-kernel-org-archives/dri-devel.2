Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56642FF8860
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 13:00:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADB5E10E2A5;
	Mon, 27 Apr 2026 12:59:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="KM19ZW6A";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 985E210E2A5
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 12:59:57 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id E36D5C5CD48;
 Mon, 27 Apr 2026 13:00:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B81ED600D1;
 Mon, 27 Apr 2026 12:59:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1E5EF1072804C; 
 Mon, 27 Apr 2026 14:59:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777294793; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=w1gq2kSLPRi8BDsMgY4czhQqlGkV5UyJsHxlDfVChz0=;
 b=KM19ZW6ABhnHYA6hBe+i6d5oGTfsERPMy9ZBlb6TXMxvbpEfHorIfO/ocCrZPQMj83+MMn
 WrD4/vTbGY6rM5cwa1G5nhIKmyZwF7QFL8+o25zNnOvvG/jh/xdbabGQtgw08qLzLadkNA
 chUGjND3ttfvUWbS6h1JpmC4LBiJh5KLijGlI/o8xH1uaR5QlibWlwsYuBtsx2A4z4qCtG
 hmpocuBB1sgz7UJbCtJkJ4N9n542wvcyqzOoR8Zc7rLbxjqeH2e+p95mVteN2TdGXD3UG3
 cBQ7dp0YU54eialMN0ggw/T08DMOtO5qeg98RjTD0ZpS500TnopeLBbZtcZwTw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Apr 2026 14:59:47 +0200
Message-Id: <DI3YF5Y2B3GZ.25AP4NKQAXH36@bootlin.com>
Subject: Re: [PATCH v22 5/8] dt-bindings: phy: Add Freescale iMX8MQ DP and
 HDMI PHY
Cc: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
 <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <linux@ew.tq-group.com>, "Alexander Stein"
 <alexander.stein@ew.tq-group.com>, "Ying Liu" <victor.liu@nxp.com>
To: "Laurentiu Palcu" <laurentiu.palcu@oss.nxp.com>, "Vinod Koul"
 <vkoul@kernel.org>, "Neil Armstrong" <neil.armstrong@linaro.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Frank Li" <Frank.Li@nxp.com>,
 "Sascha Hauer" <s.hauer@pengutronix.de>, "Pengutronix Kernel Team"
 <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20260424-dcss-hdmi-upstreaming-v22-0-30a28f89298d@oss.nxp.com>
 <20260424-dcss-hdmi-upstreaming-v22-5-30a28f89298d@oss.nxp.com>
In-Reply-To: <20260424-dcss-hdmi-upstreaming-v22-5-30a28f89298d@oss.nxp.com>
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Laurentiu,

On Fri Apr 24, 2026 at 1:07 PM CEST, Laurentiu Palcu wrote:
> From: Sandor Yu <Sandor.yu@nxp.com>
>
> Add bindings for Freescale iMX8MQ DP and HDMI PHY.
>
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> ---
>  .../bindings/phy/fsl,imx8mq-hdptx-phy.yaml         | 80 ++++++++++++++++=
++++++
>  1 file changed, 80 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/phy/fsl,imx8mq-hdptx-phy.y=
aml b/Documentation/devicetree/bindings/phy/fsl,imx8mq-hdptx-phy.yaml
> new file mode 100644
> index 0000000000000..a24435139b8b3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/fsl,imx8mq-hdptx-phy.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/fsl,imx8mq-hdptx-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cadence HDP-TX DP/HDMI PHY for Freescale i.MX8MQ SoC
> +
> +maintainers:
> +  - Sandor Yu <sandor.yu@nxp.com>

Based on what you said in the cover, I guess this line will have to be
changed. Are you willing to maintain this binding?

> +description:
> +  The Cadence HDP-TX DP/HDMI PHY is a child node of the MHDP8501 bridge,
> +  sharing the same MMIO region as the parent bridge node.
> +
> +properties:
> +  compatible:
> +    const: fsl,imx8mq-hdptx-phy
> +
> +  clocks:
> +    items:
> +      - description: PHY reference clock.
> +      - description: APB clock.
> +
> +  clock-names:
> +    items:
> +      - const: ref
> +      - const: apb
> +
> +  "#phy-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - clocks
> +  - clock-names
> +  - "#phy-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8mq-clock.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    display-bridge@32c00000 {
> +        compatible =3D "fsl,imx8mq-mhdp8501";
> +        reg =3D <0x32c00000 0x100000>;
> +        interrupts =3D <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-names =3D "plug_in", "plug_out";
> +        clocks =3D <&clk IMX8MQ_CLK_DISP_APB_ROOT>;
> +        phys =3D <&dp_phy>;
> +
> +        ports {
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;

The ports are not mentioned in the properties. I'm not a DT maintainer, but
I think they should, e.g. to mention which port is the input and which is
the output.

> +
> +            port@0 {
> +                reg =3D <0>;
> +                endpoint {
> +                    remote-endpoint =3D <&dcss_out>;
> +                };
> +            };
> +
> +            port@1 {
> +                reg =3D <1>;
> +                endpoint {
> +                    data-lanes =3D <2 1 0 3>;

Having a remote-endpoint property would be nice here, to make the example
more complete.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
