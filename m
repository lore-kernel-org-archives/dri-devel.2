Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BEECA5FBB
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:25:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5C7410EA04;
	Wed, 30 Sep 2026 07:25:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PEh1wrjh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF66F10EA04
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 07:25:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C14304164D;
 Wed, 30 Sep 2026 07:25:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB6D1F000FF;
 Wed, 30 Sep 2026 07:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790753111;
 bh=szEAWm8vXvUGdw5LnGMd7rh8Pq4FstLVk5HenOVxV30=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PEh1wrjh0rxj28jxtg6Z6N3M2qDkjqA4+R+ULkzAvMrXg0z+9InMpziRx67stvjoL
 5A4oNncgWCQUNb0T/3EWEU09wJIMdcyIBAOxyM8q1ULdlGpCgPZzLJzATHP0ueGsp0
 CfE8Q691QcgJ3jptyY425wqANciE6HFGgc311T+ot5cCVRzXg7kqoCRfppO9lw8G9o
 +bRun9I9FySV/hl/uftwJCb24JP4OmwJAGA2iJfc2xCKdebQxKdCIxqfG24lqNyhOJ
 nobTw5TmPI51ouCZW69XLqYEvonrSmRjPdiX+Fvvj3psP6J0QcJAOjyVzAfiv6je7G
 YcZ0il9QVE+RA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/3] dt-bindings: mfd: Document Skyworks AAT2870
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: mfd@lists.linux.dev, lee@kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260930071513.54697-2-clamor95@gmail.com>
References: <20260930071513.54697-1-clamor95@gmail.com>
 <20260930071513.54697-2-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 07:25:10 +0000
Message-Id: <20260930072511.3DB6D1F000FF@smtp.kernel.org>
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
- [Medium] leds: incorrect scaling for led-max-microamp constraints
--

commit 629a67ba3ff0e9f6e02a0fa733445881d67a7d0c
Author: Svyatoslav Ryhel <clamor95@gmail.com>

dt-bindings: mfd: Document Skyworks AAT2870
   =20
Document Skyworks AAT2870 LED Backlight Driver and Multiple LDO Lighting
Management Unit.

> diff --git a/Documentation/devicetree/bindings/leds/skyworks,aat2870.yaml=
 b/Documentation/devicetree/bindings/leds/skyworks,aat2870.yaml
> new file mode 100644
> index 0000000000000..6dfcd1fa399ca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/skyworks,aat2870.yaml
> @@ -0,0 +1,127 @@
[ ... ]
> +  backlight:
> +    $ref: /schemas/leds/backlight/common.yaml#
> +    unevaluatedProperties: false
> +
> +    properties:
> +      compatible:
> +        const: skyworks,aat2870-backlight
> +
> +      led-max-microamp:
> +        minimum: 450000
> +        maximum: 27900000
> +        default: 450000

[Severity: Medium]
Are these constraints for led-max-microamp mathematically correct? The valu=
es
range from 450,000 to 27,900,000 uA, which corresponds to 450 mA to 27.9 Am=
ps.

Real hardware limits appear to be 0.45 mA to 27.9 mA, which would be 450 to
27,900 uA. Defining a physically correct value (e.g., <27900>) in a device
tree will fail schema validation.

> +
> +      max-brightness:
> +        default: 255
[ ... ]
> +            backlight {
> +                compatible =3D "skyworks,aat2870-backlight";
> +
> +                skyworks,channels =3D /bits/ 8 <0xff>;
> +                led-max-microamp =3D <27900000>;

[Severity: Medium]
Does this example propagate the erroneous 27.9 Amps value?

The follow-up driver patch (commit mfd: aat2870: Convert to use OF bindings)
propagates this incorrect scaling, meaning correct values will be wrongly
clamped to minimum brightness.

> +            };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930071513.5469=
7-1-clamor95@gmail.com?part=3D1
