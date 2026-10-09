Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A0F7CA601D
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 11:14:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F11B10E5E4;
	Fri,  9 Oct 2026 11:14:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P96Vx3HG";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7183C10E5E4
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 11:14:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8AED860534;
 Fri,  9 Oct 2026 11:14:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26EE1F000FF;
 Fri,  9 Oct 2026 11:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791544468;
 bh=wAlmfTO1x8ZGuIrBVnjfCIbThBR9a4CfW10WL3eQS7M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=P96Vx3HGBtOYuWHSnBl8hVuig9QLG7UyK8EDObvwgJBfuB/QmmBDPaK8cQDB8PBMa
 JbIZlb9gDD7cRfa1gmsSjpE2B6zti95nLR8g/IR/ynRYVi0aicL1BjP2iQJQ9RsdlP
 AXZA8y7i6NC93LKx7PV+tXIYk+kn5tAscrv9x5GubMOGVtxT1QN0TtSLcGFWmklQt8
 Ics8hnLFKmzf485VHwIaVv+JBuuR6NSLngtdhg9fLrEpfsLnEQOgbUs20rGrdRw5xn
 SMcYpPXQzhqeC4y8bPybn/2LSDqgiLb1yBFXVD1ZjVKl/RFrbR6SonelaTJhEI44pT
 Gu+PE6reFhT4w==
Message-ID: <sashiko-outbox-165335@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: display: ti,tpd12s015: Convert to DT
 schema
To: Quchaosheng <quchaosheng000406@163.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261009105601.301891-2-quchaosheng000406@163.com>
References: <20261009105601.301891-1-quchaosheng000406@163.com>
 <20261009105601.301891-2-quchaosheng000406@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 11:14:27 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] dt-bindings: display: ti,tpd12s015: gpios lacks minItems: 3 and is =
not required
--

commit 0e47bb58ccd4af1df6d3ff49895c7cf9fbc75cb8
Author: Chaosheng Qu <quchaosheng000406@163.com>

dt-bindings: display: ti,tpd12s015: Convert to DT schema

Convert the TPD12S015 HDMI level shifter binding to DT schema.

> diff --git a/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.ya=
ml b/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml
> new file mode 100644
> index 0000000000000..1927da3bd7361
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml
[ ... ]
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
> +      The CT CP HPD, LS OE and HPD GPIOs, in that order. The first contr=
ols
> +      the level shifter, the second enables the level shifter outputs and
> +      the third reads the hot-plug detect line.
> +    maxItems: 3

[Severity: Low]
Does this schema accurately reflect the requirements for the GPIOs?

If a device tree node defines fewer than 3 GPIOs or omits the property
entirely, it will pass schema validation since maxItems is set to 3 without
minItems: 3, and gpios is omitted from the required block below.

However, both the DRM and FBDEV drivers unconditionally fetch index 2 (the
HPD GPIO) and fail probe if it is missing:

drivers/gpu/drm/bridge/ti-tpd12s015.c:tpd12s015_probe() {
	...
	gpio =3D devm_gpiod_get_index(&pdev->dev, NULL, 2, GPIOD_IN);
	if (IS_ERR(gpio))
		return PTR_ERR(gpio);
	...
}

Should the schema include minItems: 3 under gpios and add gpios to the
required list to ensure device tree configurations that pass validation don=
't
silently fail during driver probe?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009105601.3018=
91-1-quchaosheng000406@163.com?part=3D1
