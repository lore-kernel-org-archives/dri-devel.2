Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0445E606A334
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 10:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=OsTEc4hJ;
	dkim=fail reason="signature verification failed" header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=G+PXL67+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46E7F112346;
	Thu,  5 Nov 2026 10:39:55 +0000 (UTC)
X-Greylist: delayed 364 seconds by postgrey-1.36 at gabe;
 Thu, 05 Nov 2026 10:39:48 UTC
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de
 [85.215.255.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9F81112333
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 10:39:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793874463; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=C3Y9keIYgoQs3vXpOwRiGYBRnljNpY1smG690BI9YseAzLAgztq21ZdI3+5Nk4MIDC
 QEl7M+B+fi5YwDog02tIgEGDMYSaxARVlZcIE9pNnfTHvramzznfYer9T8Qt/NkSu1l6
 Nnd9BqrJ5jZDwOnpkw3lcCUDXlcjMzZciZKjcV8LDKWE1hjW2QOzeSKR3mXBeSxYy5MM
 Rqa5GSzNjNNQDwdKLDXxIxMpbToIvMEfPPEOfy4d997OshqxvTmUeR9sIUHm6S1DP7dy
 DiaXTPPKTvG2ZeVUwFUtrDgnsElck/DWyC6mRUqn1cQ5tDT1sf8S1qBlfRP/th5PwNc6
 bt1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793874463;
 s=strato-dkim-0002; d=strato.com;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
 From:Subject:Sender;
 bh=iHAtW1kD/nESlYFv2Ph59Q89Id7ZV4lzaWqBxv3ZuMI=;
 b=h+HLAi2fqN+7MxqdMEvUmxHQ0GkK2Vx54W103Pgb+qSz3nwIK3RIgDQdQi0w9Km3Tx
 fjQxREnuGopSfdQ3iWyazy10XRfeQl28lO7hfh30e8nosdm7Ki0wrQB4shRzsW9ouyLt
 NmnvCCcrA//kIsN+A3S2XOXu5IDpBAPKuIkdzOiNIqtT2aQrOG04fOFqN0zJKJJJY9JX
 AUIlpei1aKvliqQGWPblyYVj05S5I/Evj2vEodi47ltdbFAEqsa41JjElAdE3Z4x6XJR
 SjdtwaH9F0coRnhRBlGKtvu6RqVlRWSTqN+/ceEwKhff4fLLMA/ur6th/6m/Wo6IjS+W
 2yZg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793874463;
 s=strato-dkim-0002; d=goldelico.com;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
 From:Subject:Sender;
 bh=iHAtW1kD/nESlYFv2Ph59Q89Id7ZV4lzaWqBxv3ZuMI=;
 b=OsTEc4hJH7/1QfpNnMWCORUN0Mq9vmGOXJsizmIpA46YHD5txBGFACMgAshqU/rwgv
 N6Qm+R/7V1IFKNc8c1cMc9MvCEZtfei9KUuYAnXqul+U9n1fexgf+8JfkQkxweriEQBO
 fmp7R5RCOXBAyjRP/02l7XdaJDR38Fcj3g/gbVgiwkuvcKuIM9ZwWzhoPOP6FPAObVPJ
 nWZRktLAz5f6VKj65ZSpcaBFKrNcICBrEtaynNK0HAdElD8gHba81gclWjU135T7zvFr
 ycKjZxNGQSgNMZcV9fHxWJpgh7cz4l4MZrhYhg90tlqLfQtQkOkRfpyQCRf6lppujble
 GgVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793874463;
 s=strato-dkim-0003; d=goldelico.com;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
 From:Subject:Sender;
 bh=iHAtW1kD/nESlYFv2Ph59Q89Id7ZV4lzaWqBxv3ZuMI=;
 b=G+PXL67+ApjeRq7GSPKbQCC5q6lUKGRXNNSqay4Zqt8DdWNGRUEE08lwKRH1DtJDVH
 kFnlzvue36jfefeVorAg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrV25oGlMiNUOZNJoYXSTSpu/Ae46f1NE9YxyvD"
Received: from smtpclient.apple by smtp.strato.de (RZmta 55.6.3 AUTH)
 with ESMTPSA id Qb56a22A5ARgiF4
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1
 with 256 ECDH bits, eq. 3072 bits RSA))
 (Client did not present a certificate);
 Thu, 5 Nov 2026 11:27:42 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.10\))
Subject: Re: [PATCH v2 2/5] dt-bindings: display: Add the Ingenic X1600 LCD
 controller
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20261025191640.13592-3-olivier@mgcrea.io>
Date: Thu, 5 Nov 2026 11:27:12 +0100
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Cercueil <paul@crapouillou.net>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <09A3F895-9007-414E-8EE0-17BD18E63F53@goldelico.com>
References: <20261025191640.13592-1-olivier@mgcrea.io>
 <20261025191640.13592-3-olivier@mgcrea.io>
To: Olivier Louvignes <olivier@mgcrea.io>
X-Mailer: Apple Mail (2.3826.700.81.1.10)
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

> Am 25.10.2026 um 20:16 schrieb Olivier Louvignes <olivier@mgcrea.io>:
>=20
> The X1600's display controller fetches frames through descriptors and
> keeps its interface and timings in register blocks of their own (X1600
> programming manual, chapter 10), so it shares nothing with the
> controllers ingenic,lcd.yaml describes. Its registers are those of the
> X2000's display controller without the composer.
>=20
> Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
> ---
> .../bindings/display/ingenic,x1600-lcd.yaml   | 70 +++++++++++++++++++
> MAINTAINERS                                   |  5 ++
> 2 files changed, 75 insertions(+)
> create mode 100644 =
Documentation/devicetree/bindings/display/ingenic,x1600-lcd.yaml
>=20
> diff --git =
a/Documentation/devicetree/bindings/display/ingenic,x1600-lcd.yaml =
b/Documentation/devicetree/bindings/display/ingenic,x1600-lcd.yaml
> new file mode 100644
> index 000000000000..171536c78f4b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/ingenic,x1600-lcd.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/ingenic,x1600-lcd.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ingenic X1600 LCD controller
> +
> +maintainers:
> +  - Olivier Louvignes <olivier@mgcrea.io>
> +
> +description:
> +  The display controller of the Ingenic X1600 SoC. It fetches frames =
through
> +  descriptors in memory and drives a parallel RGB panel or a smart =
panel;
> +  its registers have nothing in common with the controllers described =
in
> +  ingenic,lcd.yaml.
> +
> +properties:
> +  $nodename:
> +    pattern: "^lcd-controller@[0-9a-f]+$"
> +
> +  compatible:
> +    const: ingenic,x1600-lcd
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: The pixel clock, whose gate also gates the =
controller
> +
> +  clock-names:
> +    items:
> +      - const: lcd
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/properties/port
> +    description: The output, to the panel or bridge.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    lcd-controller@13050000 {
> +        compatible =3D "ingenic,x1600-lcd";
> +        reg =3D <0x13050000 0x10000>;
> +
> +        interrupt-parent =3D <&intc>;
> +        interrupts =3D <31>;
> +
> +        clocks =3D <&cgu 16>;
> +        clock-names =3D "lcd";
> +
> +        port {
> +            lcd_out: endpoint {
> +                remote-endpoint =3D <&panel_in>;
> +            };
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a08087fb6e67..98d46b1cc029 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12927,6 +12927,11 @@ F: include/linux/mfd/ingenic-tcu.h
> F: sound/soc/codecs/jz47*
> F: sound/soc/jz4740/
>=20
> +INGENIC X1600 DRM DRIVER
> +M: Olivier Louvignes <olivier@mgcrea.io>
> +S: Maintained
> +F: Documentation/devicetree/bindings/display/ingenic,x1600-lcd.yaml
> +
> INJOINIC IP5xxx POWER BANK IC DRIVER
> M: Samuel Holland <samuel@sholland.org>
> S: Maintained
> --=20
> 2.39.5


I've looked through the implementation and compared it with the hardware
architecture and programming manuals for the Ingenic X-series (x1600, =
x2000,
x2600).

It is indeed a completely different display controller as found in the
jz4 series so a new driver is reasonable.

Here is some architectural feedback regarding the naming convention,
compatibility, and why we need to future-proof this layout:

1) IP Naming and Architecture (LCD vs. DPU):
The manual for the x1600 is a bit ambiguous, but the x2000 and x2600
documentation identifies this block as the "DPU (Display Processing =
Unit)
Display Controller" (located at base address 0x13050000 on all three =
SoC).

Calling the core driver or compatible string "x1600-lcd" is too =
restrictive.
This IP block is a generic display engine designed to drive highly =
diverse
protocols across the SoC generations:
  * x1000: MIPI-DBI (SLCD)
  * x1830: MIPI-DPI (TFT), MIPI-DBI (SLCD)
  * x1600: MIPI-DSI, MIPI-DPI (TFT)
  * x2000: MIPI-DSI, MIPI-DPI (TFT), MIPI-DBI (SLCD)
  * x2600: MIPI-DSI, MIPI-DPI (TFT), MIPI-DBI (SLCD), LVDS
  (NOTE: this does not match the presence of physical drivers for these =
protocols)

Recommendation: We should decouple the core controller logic from the =
physical
signaling interfaces. The driver framework needs to be prepared for =
these upcoming
formats (alongside features like the x2600 rotation engine).
Please update the compatible string to "ingenic,x1600-dpu" (with =
"ingenic,dpu"
as the fallback) and rename the file to ingenic-dpu.c to reflect that =
this is
a scalable DPU driver not limited to "LCD".

2) Vendor Kernel:
A look at the vendor's v6.6 downstream kernel confirms this =
architecture. While their
ingenicfb.c and ingenic_lcd_6800.c drivers are tailored for specific =
downstream use
cases and non-DRM subsystems (old style fbdev), they explicitly =
reference the "DPU"
and hook the x2600 rotation module into it.

Adopting the generic ingenic-dpu naming upfront prevents us from =
breaking bindings
or duplicating code when adding x2000/x2600 support later.

3) Testing and Validation Feedback:
I've looked into integrating your patch series (including the pinctrl =
and panel drivers)
on our LX16 platform.

On this specific hardware, the LCD interface is only routed to internal =
test points.
Therefore, I attempted to verify the pipeline by using a dummy/no-op =
hack for your
hiby,lg35583 panel driver. The plan was to use a scope to watch =
framebuffer content
on the test points. However, this approach triggered a kernel lockup =
during boot
right after successfully running lg35583_get_modes().

Due to time constraints, I have not debuged the root cause of this =
lockup, so you
can ignore it if the panel works for you.

Nevertheless, looking at the code, the structural alignment of the =
components=E2=80=94including
the core logic, the panel driver baseline, and the proposed pinctrl =
extension
(lcd-18bit-msb added to x1600_lcd_groups[])=E2=80=94looks very =
promising.

Once the naming is refactored to align with the generic DPU =
architecture, this looks
like a very solid foundation to base future work on.

BR and thanks,
Nikolaus

