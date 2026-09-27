Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29A6C9832F
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 18:37:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EB8D10E5FB;
	Sun, 27 Sep 2026 18:37:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="davDUBk5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6061E10E5FB
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 18:37:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 57AAD60052;
 Sun, 27 Sep 2026 18:37:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB6F1F000FF;
 Sun, 27 Sep 2026 18:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790534222;
 bh=AmAGmdz7yJBOCu3/ATC5ZoeOsQb5TYZWkUrdrNhIISo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=davDUBk5an4VEUQWoFtjOZMNTZPjX3a2EEI6DR0oTVtH7AFyxu4/Lh5PNitIxtrkt
 YBZsHHjW4F1Oi7xAK6s6xillMuo/9QgaD/va3fIAh0LwlYrYd4WWre8+HotTuaOPjK
 +eg3c9iMw4E/Fnf322L46wPLSqsxgYuFg4WNz0YJnsCI2F9N2fmvvsDitW68p7mxni
 kswXKeYwmS6K7CfLWpmqMNDj7VfHJhtHvu6QWMDU+XrHOjEndRpDL7DVcYmqTzdjLA
 YHNzb/UINqc2lLEsgjrAlNWJRaL6/p56YQWjLHi3j5SfiMZJJVwIoXLhyWR7JW1Fn2
 iV/TlTiKmaQzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/14] dt-bindings: display: Add Solomon SSD16xx
 e-paper controller binding
To: "Devarsh Thakkar" <devarsht@ti.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260927182329.4193961-3-devarsht@ti.com>
References: <20260927182329.4193961-1-devarsht@ti.com>
 <20260927182329.4193961-3-devarsht@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 18:37:01 +0000
Message-Id: <20260927183701.AAB6F1F000FF@smtp.kernel.org>
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
- [Medium] dt-bindings: redefined standard rotation property semantics (clo=
ckwise vs CCW)
- [Medium] dt-bindings: missing panel-common.yaml reference incorrectly rej=
ects panel properties
- [Medium] dt-bindings: missing spi-3wire property definition breaks valida=
tion for 3-wire mode
--

commit 504b4d897333eddd3593a4ba35eae49d79d7d739
Author: Devarsh Thakkar <devarsht@ti.com>
dt-bindings: display: Add Solomon SSD16xx e-paper controller binding

This commit adds a device tree binding for the Solomon Systech SSD16xx e-Pa=
per
display controllers. It covers the 4-wire SPI interface and required GPIO p=
ins
while also noting optional 3-wire mode support.

Link: https://www.crystalfontz.com/controllers/SolomonSystech/SSD1683
Link: https://files.seeedstudio.com/wiki/Other_Display/42-epaper/GDEY042T81=
.pdf
Link: https://www.crystalfontz.com/controllers/SolomonSystech/SSD1673
Link: https://www.crystalfontz.com/controllers/SolomonSystech/SSD1680
Link: https://www.crystalfontz.com/controllers/SolomonSystech/SSD1681

> diff --git a/Documentation/devicetree/bindings/display/solomon,ssd16xx.ya=
ml b/Documentation/devicetree/bindings/display/solomon,ssd16xx.yaml
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/solomon,ssd16xx.yaml
[ ... ]
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#

[Severity: Medium]
Is this missing a reference to /schemas/display/panel/panel-common.yaml#?

Because this schema acts as a display panel node and sets
unevaluatedProperties: false later in the file, omitting the panel-common
reference strictly forbids standard panel properties like power-supply or
port. This might prevent valid hardware board configurations from passing
schema validation.

> +
> +properties:
> +  compatible:

[Severity: Medium]
Should spi-3wire: true be explicitly declared here in the properties sectio=
n?

The commit message notes that the controller supports 3-wire mode, but neit=
her
this schema nor the referenced spi-peripheral-props.yaml define spi-3wire.
Because unevaluatedProperties is set to false, configuring a peripheral in
3-wire mode with the standard spi-3wire property will erroneously fail sche=
ma
validation.

[ ... ]
> +  rotation:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 90, 180, 270]
> +    description:
> +      Display rotation in degrees clockwise.

[Severity: Medium]
Does defining rotation as clockwise conflict with standard device tree
semantics?

The device tree standard for displays (panel-common.yaml) explicitly defines
rotation as counter-clockwise. Defining it as clockwise here creates a
semantic mismatch that could lead to inverted rotation at runtime if the DRM
driver or generic kernel helpers parse it assuming the standard CCW semanti=
cs.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927182329.4193=
961-1-devarsht@ti.com?part=3D2
