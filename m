Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3BFCA9ED5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 06:57:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 044E310E194;
	Mon, 12 Oct 2026 06:57:15 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F9F910E325
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 06:57:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1FE8960AA1;
 Mon, 12 Oct 2026 06:57:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842AE1F0089B;
 Mon, 12 Oct 2026 06:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791788227;
 bh=vEuBnmKFzhaHa35SWhMTKgji34Zzi7/2hC6q4Ak7OpM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Eh8svbRILbxhY5uIa0UPYYJfYWiHdB+fqHWnQPxIh7BcSsz+i7ppKvINfA3OWLt9m
 5WD0Kj2hh4sPGvSFoHfJCzRTNPUlBbQdiiDrGKCkF1xjbObfQtDdQVMHFACR01kwFZ
 ZyBqJYgMbSjYb29PWSlFfkA76NTnwFmlaPT5lc6bOm9+krFyFu2rBVJXgj+et+2STT
 TtZYk683NvrWQC5Mp9lxKI0S7/p/eaRiupA8q95NN2p0C7V2IpmDZb9ZhmED0PZOYK
 gqbf07rehFD8JIH4tzMWiu3BLRvk91sfbVCuvwgZzpDZgwbx7c9tweWsi1v1Sr+uQ0
 agXoQRoqy1r0Q==
Message-ID: <sashiko-outbox-167756@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: display: panel: Add RAiO RA8875
 display controller
To: "Adam Azuddin" <azuddinadam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20261012064518.3497285-2-azuddinadam@gmail.com>
References: <20261012064518.3497285-1-azuddinadam@gmail.com>
 <20261012064518.3497285-2-azuddinadam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 06:57:07 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] dt-bindings: spi-peripheral-props.yaml restricts reg to 256, bre=
aking parallel/I2C buses
- [Medium] dt-bindings: missing dc-gpios breaks schema validation for legac=
y DTs
- [Medium] dt-bindings: display: panel: raio,ra8875: missing interrupts pro=
perty for INT# pin
--

commit 770e5c23771cd9005f8ced2e1ea873a2b2042967
Author: Adam Azuddin <azuddinadam@gmail.com>

dt-bindings: display: panel: Add RAiO RA8875 display controller

The RA8875 is an SPI-connected TFT display controller by RAiO
Technology Inc. It supports display resolutions of up to 800x480.

Add YAML binding schema for the RA8875 controller, along with
the raio vendor prefix for RAiO Technology Inc.

> diff --git a/Documentation/devicetree/bindings/display/panel/raio,ra8875.=
yaml b/Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml
> new file mode 100644
> index 0000000000000..86777e2cec57a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml
> @@ -0,0 +1,77 @@
[ ... ]
> +description:
> +  The RA8875 is a TFT LCD controller for panels up to 800x480 pixels.
> +  It can be connected to the controller via 8080/6800 parallel interface,
> +  SPI or I2C.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#

[Severity: Medium]
Since the description mentions the device can be connected via 8080/6800
parallel interface or I2C, does unconditionally including the SPI peripheral
properties here break non-SPI bindings?

The spi-peripheral-props.yaml schema restricts the elements of the reg
property to a maximum value of 256. For parallel memory-mapped interfaces,
the reg property typically holds a full physical address which violates this
constraint, causing device tree validation to fail.

Could this inclusion be made conditional based on the bus type instead?

[ ... ]
> +required:
> +  - compatible
> +  - reg
> +  - display-timings
> +  - vdd-supply
> +
> +unevaluatedProperties: false

[Severity: Medium]
Will this break validation for existing device trees that include the dc-gp=
ios
property?

The legacy fbtft driver strictly required this property for the raio,ra8875
device and would abort probe without it:

drivers/staging/fbtft/fbtft-core.c:fbtft_verify_gpios() {
    ...
    if (pdata->display.buswidth !=3D 9 &&  par->startbyte =3D=3D 0 &&
        !par->gpio.dc) {
        dev_err(par->info->device,
            "Missing info about 'dc' gpio. Aborting.\n");
        return -EINVAL;
    }
    ...
}

Because existing device trees in the wild must contain this property to work
with the legacy driver, omitting it here while setting unevaluatedProperties
to false will cause them to fail validation.

[Severity: Medium]
Does this schema omission prevent describing the hardware accurately when t=
he
INT# pin is connected?

The RA8875 hardware features a dedicated INT# pin to signal events from its
built-in touchscreen and keypad controllers. Omitting the interrupts proper=
ty
while setting unevaluatedProperties to false means valid device trees
specifying this interrupt routing will be rejected.

Should the interrupts property be added to allow full hardware description,
even if the current DRM driver does not consume it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012064518.3497=
285-1-azuddinadam@gmail.com?part=3D1
