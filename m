Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E38606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 07:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K92uuv3k
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32BE710E0C0;
	Mon, 16 Nov 2026 07:14:49 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C2D310E0C0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 07:14:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4C3CE626FA;
 Mon, 16 Nov 2026 07:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A1E1F000C7;
 Mon, 16 Nov 2026 07:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794813282;
 bh=+nuxUFW9XQdHOPNkb5fV2ycPeQVA8tCXx1QAfCVGfGs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=K92uuv3kkXItdxJxJNtBVjiOjFzMdeSx3BlMgML4771xlOu2fI0bVNnODUJ++EtI9
 ACxuh4kAZfE7oG7Ddw4BJIVAtcLqekvI4zps3hB+r3cI9prZLtxCmCpmIbrnHFwC2U
 vUejJt8KsOncyzPugA5f1uGfpPwYTZkz1fTgPHhOlVXL1qvOU6uSx4A7EyoZNtYzfQ
 Gvy2IwsUWLUVx3yUAxjtkeDlQ3MrWiz6l3NmjRns0vcqgDlDlnyBCGp6U56U4GFNLB
 2OmMDqXqFfEIIN5yBeZ4I9D/1CbIw8s/aSiQNfGjua1oOw/74+vCZ4JUArN4l7on9A
 G7m5GrbRDarYg==
Message-ID: <sashiko-outbox-216398@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: display: panel: add Novatek NT36525
To: =?utf-8?b?QWRpbCBIw7xzcmV2IFRlcGU=?= <tadilhusrev@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261116070212.314228-2-tadilhusrev@gmail.com>
References: <20261116070212.314228-1-tadilhusrev@gmail.com>
 <20261116070212.314228-2-tadilhusrev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 07:14:41 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] dt-bindings: display: panel: novatek,nt36525: inverted RESX
  reset-gpios polarity
- [Medium] dt-bindings: display: panel: novatek,nt36525: missing
  vpos-supply and vneg-supply properties
- [Medium] dt-bindings: display: novatek,nt36525: additionalProperties
  blocks backlight
--

commit ff4d190494305111a5c1b07276dbb75205cedb54
Author: Adil H=C3=BCsrev Tepe <tadilhusrev@gmail.com>

dt-bindings: display: panel: add Novatek NT36525

This commit adds a Device Tree binding schema for MIPI-DSI video-mode
panels based on the Novatek NT36525 controller.

> diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36=
525.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36525.=
yaml
> new file mode 100644
> index 0000000000000..5c6e7cce06411
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36525.yaml
> @@ -0,0 +1,71 @@
[ ... ]
> +description:
> +  A MIPI-DSI video-mode panel driven by a Novatek NT36525 controller,
> +  720x1480. The first compatible string names the specific panel as fitt=
ed
> +  in a device; the second is the NT36525 controller it is based on. The
> +  panel reset (RESX) is active high in the Samsung Galaxy XCover5 bring-=
up
> +  sequence.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - samsung,xcover5-nt36525
> +      - const: novatek,nt36525
> +
> +  reg:
> +    maxItems: 1
> +    description: DSI virtual channel
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: panel power supply

[Severity: Medium]
Should this binding also declare vpos-supply and vneg-supply?

In commit "drm/panel: add Novatek NT36525 panel driver", nt36525_probe()
requests three separate regulators ("vdd", "vpos", and "vneg") and
nt36525_prepare() sequences all three rails.  Without vpos-supply and
vneg-supply in the schema, device tree nodes that provide the positive and
negative analog bias supplies consumed by the driver will fail dtbs_check
validation.

> +
> +  port: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios
> +  - vdd-supply
> +  - port
> +
> +additionalProperties: false

[Severity: Medium]
Does additionalProperties: false reject the backlight property and other
common properties inherited from panel-common.yaml#?

Because additionalProperties: false forbids any property from a referenced
schema that is not re-listed locally, standard properties from
panel-common.yaml# such as backlight cause dtbs_check errors, even though
nt36525_probe() in commit "drm/panel: add Novatek NT36525 panel driver"
parses backlight via drm_panel_of_backlight().  Using
unevaluatedProperties: false instead allows the inherited properties from
panel-common.yaml# and avoids needing to duplicate reset-gpios and port.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dsi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        panel@0 {
> +            compatible =3D "samsung,xcover5-nt36525", "novatek,nt36525";
> +            reg =3D <0>;
> +            reset-gpios =3D <&gpa0 0 GPIO_ACTIVE_HIGH>;

[Severity: Medium]
Is the reset-gpios polarity inverted in the description and example?

Under panel-common.yaml#, reset-gpios is logically active when asserting
reset.  The RESX pin on the NT36525 is physically active-low (asserted low
to reset and driven high to release reset, as shown by the 1-0-1 pulse in
nt36525_prepare() in commit "drm/panel: add Novatek NT36525 panel driver"),
so it should be described as active-low and use GPIO_ACTIVE_LOW.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116070212.3142=
28-1-tadilhusrev@gmail.com?part=3D1
