Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9265DFF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 12:21:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3D7610EB46;
	Tue, 28 Apr 2026 12:21:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="lDEouwh7";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09D0210EB46
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 12:21:44 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 753DC1A3471;
 Tue, 28 Apr 2026 12:21:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 3E459601D0;
 Tue, 28 Apr 2026 12:21:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EF52010728AA4; 
 Tue, 28 Apr 2026 14:21:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777378900; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=FkhJI2u81cWQQKkbpyLd60L537rqdrvEOTTOduSP8fc=;
 b=lDEouwh70SunD0CIWASRbWeFowTrGybIpcklgMde26dHzbTlVQO4tNpqeNvxp/DTQsoqLf
 MVjtKrPOCWqpHgHajsl9TS3Z3HbhRIpfUc1ER+yeSnCjIO3sw4GAhoSvOm0qOqbvwlTHrB
 x+gO9MKBp4xsCHTPNEnL2nYoU4H0Uz7b3WQc5J0o29raPzA+01q4oo01SleqCbz0BDqus+
 +SOujwJmPYbFV9TLnY1ejbitcPWUig77tZIqCoYyaNv88N+8BWkg4GxKRwHhpKohvAc+Wg
 QN2E2KsPjss+wNTEiCqCvUKMlcm3LPj/suEerpCepkldM2ueNI7yNcP+xUABCg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Apr 2026 14:21:35 +0200
Message-Id: <DI4S8GN9WTCI.75C07G767ZOV@bootlin.com>
Cc: "Vinod Koul" <vkoul@kernel.org>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Frank Li" <Frank.Li@nxp.com>, "Sascha Hauer" <s.hauer@pengutronix.de>,
 "Pengutronix Kernel Team" <kernel@pengutronix.de>, "Fabio Estevam"
 <festevam@gmail.com>, <dri-devel@lists.freedesktop.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-phy@lists.infradead.org>, <imx@lists.linux.dev>,
 <linux-arm-kernel@lists.infradead.org>, <linux@ew.tq-group.com>, "Alexander
 Stein" <alexander.stein@ew.tq-group.com>, "Ying Liu" <victor.liu@nxp.com>
To: "Laurentiu Palcu" <laurentiu.palcu@oss.nxp.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v22 5/8] dt-bindings: phy: Add Freescale iMX8MQ DP and
 HDMI PHY
X-Mailer: aerc 0.20.1
References: <20260424-dcss-hdmi-upstreaming-v22-0-30a28f89298d@oss.nxp.com>
 <20260424-dcss-hdmi-upstreaming-v22-5-30a28f89298d@oss.nxp.com>
 <DI3YF5Y2B3GZ.25AP4NKQAXH36@bootlin.com>
 <f6rf5d6nhglkwendf5yvaklfn2ovlwkqstsz7vvl5zefibtiun@wic7bchohmwv>
In-Reply-To: <f6rf5d6nhglkwendf5yvaklfn2ovlwkqstsz7vvl5zefibtiun@wic7bchohmwv>
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

On Mon Apr 27, 2026 at 4:35 PM CEST, Laurentiu Palcu wrote:
> Hi Luca,
>
> On Mon, Apr 27, 2026 at 02:59:47PM +0200, Luca Ceresoli wrote:
>> Hello Laurentiu,
>>
>> On Fri Apr 24, 2026 at 1:07 PM CEST, Laurentiu Palcu wrote:
>> > From: Sandor Yu <Sandor.yu@nxp.com>
>> >
>> > Add bindings for Freescale iMX8MQ DP and HDMI PHY.
>> >
>> > Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
>> > Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
>> > ---
>> >  .../bindings/phy/fsl,imx8mq-hdptx-phy.yaml         | 80 +++++++++++++=
+++++++++
>> >  1 file changed, 80 insertions(+)
>> >
>> > diff --git a/Documentation/devicetree/bindings/phy/fsl,imx8mq-hdptx-ph=
y.yaml b/Documentation/devicetree/bindings/phy/fsl,imx8mq-hdptx-phy.yaml
>> > new file mode 100644
>> > index 0000000000000..a24435139b8b3
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/phy/fsl,imx8mq-hdptx-phy.yaml
>> > @@ -0,0 +1,80 @@
>> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> > +%YAML 1.2
>> > +---
>> > +$id: http://devicetree.org/schemas/phy/fsl,imx8mq-hdptx-phy.yaml#
>> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> > +
>> > +title: Cadence HDP-TX DP/HDMI PHY for Freescale i.MX8MQ SoC
>> > +
>> > +maintainers:
>> > +  - Sandor Yu <sandor.yu@nxp.com>
>>
>> Based on what you said in the cover, I guess this line will have to be
>> changed. Are you willing to maintain this binding?
>
> Yes, I'll update it in the next iteration.
>
>>
>> > +description:
>> > +  The Cadence HDP-TX DP/HDMI PHY is a child node of the MHDP8501 brid=
ge,
>> > +  sharing the same MMIO region as the parent bridge node.
>> > +
>> > +properties:
>> > +  compatible:
>> > +    const: fsl,imx8mq-hdptx-phy
>> > +
>> > +  clocks:
>> > +    items:
>> > +      - description: PHY reference clock.
>> > +      - description: APB clock.
>> > +
>> > +  clock-names:
>> > +    items:
>> > +      - const: ref
>> > +      - const: apb
>> > +
>> > +  "#phy-cells":
>> > +    const: 0
>> > +
>> > +required:
>> > +  - compatible
>> > +  - clocks
>> > +  - clock-names
>> > +  - "#phy-cells"
>> > +
>> > +additionalProperties: false
>> > +
>> > +examples:
>> > +  - |
>> > +    #include <dt-bindings/clock/imx8mq-clock.h>
>> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> > +
>> > +    display-bridge@32c00000 {
>> > +        compatible =3D "fsl,imx8mq-mhdp8501";
>> > +        reg =3D <0x32c00000 0x100000>;
>> > +        interrupts =3D <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
>> > +                     <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
>> > +        interrupt-names =3D "plug_in", "plug_out";
>> > +        clocks =3D <&clk IMX8MQ_CLK_DISP_APB_ROOT>;
>> > +        phys =3D <&dp_phy>;
>> > +
>> > +        ports {
>> > +            #address-cells =3D <1>;
>> > +            #size-cells =3D <0>;
>>
>> The ports are not mentioned in the properties. I'm not a DT maintainer, =
but
>> I think they should, e.g. to mention which port is the input and which i=
s
>> the output.
>>
>> > +
>> > +            port@0 {
>> > +                reg =3D <0>;
>> > +                endpoint {
>> > +                    remote-endpoint =3D <&dcss_out>;
>> > +                };
>> > +            };
>> > +
>> > +            port@1 {
>> > +                reg =3D <1>;
>> > +                endpoint {
>> > +                    data-lanes =3D <2 1 0 3>;
>>
>> Having a remote-endpoint property would be nice here, to make the exampl=
e
>> more complete.
>
> The ports and the remote endpoints are documented in the bridge binding..=
.

Ah, my bad, I reviewed too quickly and mixed the phy and bridge bindings in
my mind, sorry.

>
> However, I believe I screwed this example up by adding the entire bridge =
node,
> instead of just a simple:
>
> mhdp {
>     phy {
>         compatible =3D "fsl,imx8mq-hdptx-phy";
>         #phy-cells =3D <0>;
>         clocks =3D <&hdmi_phy_27m>, <&clk IMX8MQ_CLK_DISP_APB_ROOT>;
>         clock-names =3D "ref", "apb";
>     };
> };
>
> I'll simplify the example in the next iteration.

Yes, I think it would make sense to do it.

Thanks,
Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
