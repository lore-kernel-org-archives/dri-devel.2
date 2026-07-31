Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF51C54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 14:56:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB17D10E216;
	Fri, 31 Jul 2026 14:56:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NKGxkniu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D049710E216
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 14:56:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AD59541882;
 Fri, 31 Jul 2026 14:56:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590471F000E9;
 Fri, 31 Jul 2026 14:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785509813;
 bh=RghDj4nEXNSV4HfmJ0mBMqLZLh2Q4I2x6tT4U9zSw5U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NKGxkniuxBBQu6w7aNQ5aT0AcclU2tenN2TI7TlmIlLjMQnIf67YRPNEdUZQ6SIex
 e1QsBU2VEUcul03uHT1nKkRGmEwkzmt625wMZy0ORhX9artsnu1iyVTSaHLPelgCTh
 Os1GmWF8CEV7q4VdAIGu8RFY33UeTm9aWU7lBw4rzape+xNvE/JGNS6+fo0T2JDXsQ
 9MOwYH3B+LqIiQQuRYuotn9K30C/GnUeBrrVYjdV6JbpF4pDqvrZWzCMzLo+B6GPiU
 uCdJIeRVaHdAtTIUHNI24OFceki8WYQG+XFmhqSVJXtjpJayGAX2UbsFy3VL+W8m8E
 1goh0cSCTYJdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: display: solomon,ssd1307fb: add
 SH1107 compatible
To: "Jakub Turek" <jakub.turek@elsta.tech>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260731-feat-sh1107-v2-2-0d2893e44ebd@elsta.tech>
References: <20260731-feat-sh1107-v2-0-0d2893e44ebd@elsta.tech>
 <20260731-feat-sh1107-v2-2-0d2893e44ebd@elsta.tech>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 14:56:53 +0000
Message-Id: <20260731145653.590471F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] The fbdev driver ignores the device-specific default dimensions do=
cumented in the device tree bindings, falling back to a hardcoded 96x16 for=
 all devices including the newly documented sinowealth,sh1107.
--

--- Patch [2]: [PATCH v2 2/2] dt-bindings: display: solomon,ssd1307fb: add =
SH1107 compatible ---
commit 6de7ab88b3219b227a8443711b01ecabe4a747f9
Author: Jakub Turek <jakub.turek@elsta.tech>

dt-bindings: display: solomon,ssd1307fb: add SH1107 compatible

This commit updates the device tree documentation to include the
"sinowealth,sh1107" compatible string. It also configures default values for
the display dimensions and clock settings when this compatible is used.

> diff --git a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.=
yaml b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
> index 153ff86fb4059..6b17a701bbaa5 100644
> --- a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
> +++ b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
[ ... ]
> @@ -140,6 +141,22 @@ allOf:
>          solomon,dclk-frq:
>            default: 5
> =20
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: sinowealth,sh1107
> +    then:
> +      properties:
> +        solomon,width:
> +          default: 128
> +        solomon,height:
> +          default: 64

[Severity: High]
This isn't a bug introduced by this patch, but does the fbdev driver actual=
ly
respect these default dimensions?

Looking at ssd1307fb_probe() in drivers/video/fbdev/ssd1307fb.c, the driver
appears to hardcode the fallback values to 96x16:

drivers/video/fbdev/ssd1307fb.c:ssd1307fb_probe() {
    ...
	if (device_property_read_u32(dev, "solomon,width", &par->width))
		par->width =3D 96;

	if (device_property_read_u32(dev, "solomon,height", &par->height))
		par->height =3D 16;
    ...
}

If a device tree node for sinowealth,sh1107 is created without the
solomon,width and solomon,height properties, relying on the schema's
defaults, will the driver initialize the display with the hardcoded 96x16
resolution instead?

> +        solomon,dclk-div:
> +          default: 1
> +        solomon,dclk-frq:
> +          default: 8

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-feat-sh110=
7-v2-0-0d2893e44ebd@elsta.tech?part=3D2
