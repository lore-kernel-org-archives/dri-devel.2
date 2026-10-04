Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC9FCA5FF0
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 16:50:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D595810EAAB;
	Sun,  4 Oct 2026 16:50:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IOfzX0q0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B57C10EAAA
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 16:50:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 14ED642B14;
 Sun,  4 Oct 2026 16:50:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86DE01F00898;
 Sun,  4 Oct 2026 16:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791132657;
 bh=5AdhvBZtdreGBBfmpt7FZcqlh2Deh824eypm0xyIOvo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IOfzX0q0fXUn9Sc5DYV52XXzTIAESBsA09hUyPpXTE2HuFjdVdpB9hr+5jlynu1tp
 AtpDcUAAR5m/HoiDqC2frk7sF1VjZzjkkNdAp62BLaSmZks0xlTxe4ypn+mVwbd6Uu
 pqpx/XaYgNG25y/W6OB2Ef0CpEfHiyyASvTS2sueJpniV6zEMK7+Sl/P889hIT1Nd3
 RFz09EusddKAdf808WYmCeJ/EZnFAx5eqroa78V7j8ze/TLmsfleTJyBfzh3HQ63aB
 gVd2JWVQTfRPi+x3NosarB3x9ltj/TqI6UgP2QmLilBH7f/2/XzKFHOygeFjjG32ie
 5YM7Mho9bJVuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: mfd: Document Skyworks AAT2870
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: lee@kernel.org, linux-leds@vger.kernel.org, robh@kernel.org,
 conor+dt@kernel.org, mfd@lists.linux.dev, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261004164121.193514-2-clamor95@gmail.com>
References: <20261004164121.193514-1-clamor95@gmail.com>
 <20261004164121.193514-2-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 16:50:56 +0000
Message-Id: <20261004165056.86DE01F00898@smtp.kernel.org>
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
- [Low] dt-bindings: missing `type: object` constraints for child nodes
--

commit 44544968b5bc5130f1768962ce3f85c8bc12cfad
Author: Svyatoslav Ryhel <clamor95@gmail.com>

dt-bindings: mfd: Document Skyworks AAT2870

Document Skyworks AAT2870 LED Backlight Driver and Multiple LDO Lighting
Management Unit.

> diff --git a/Documentation/devicetree/bindings/leds/skyworks,aat2870.yaml=
 b/Documentation/devicetree/bindings/leds/skyworks,aat2870.yaml
> new file mode 100644
> index 0000000000000..014678616076f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/skyworks,aat2870.yaml
[ ... ]
> +  vin-supply:
> +    description: Regulator providing power to the "IN" pin.
> +
> +  backlight:
> +    $ref: /schemas/leds/backlight/common.yaml#
> +    unevaluatedProperties: false

[Severity: Low]
Does this node definition need an explicit type: object?

Since this backlight property references /schemas/leds/backlight/common.yam=
l#
which does not define type: object at its root, the dt_binding_check schema
validation tool will fail with a type is missing error when checking this
new schema. In dt-schema, properties representing child nodes must explicit=
ly
declare type: object if it is not inherited from a $ref.

[ ... ]
> +    patternProperties:
> +      "^(ldo-(a|b|c|d))$":
> +        $ref: /schemas/regulator/regulator.yaml#
> +        unevaluatedProperties: false

[Severity: Low]
Similarly, do these regulator subnodes matching ldo-[a-d] require a
type: object constraint?

Like the backlight node above, the referenced external schema
(/schemas/regulator/regulator.yaml#) does not inherently provide type: obje=
ct,
which will also result in validation failures.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004164121.1935=
14-1-clamor95@gmail.com?part=3D1
