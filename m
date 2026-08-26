Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6313FC61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 07:40:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C11A610EC09;
	Wed, 26 Aug 2026 07:40:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z0/4SOkW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3614110EC09
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 07:40:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B87414342D;
 Wed, 26 Aug 2026 07:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0421F000E9;
 Wed, 26 Aug 2026 07:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787730018;
 bh=WbNn2vKvajY3bolVHV+90CK/ov3ro2t2/r5084d73FU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Z0/4SOkWaLgIqtYvS0+e8iOY72TFa3xiYNyt9pG4xRp2AYxRbw8KZSxOwHqMQfoMf
 QLCOpWZeXRLbbsOA36g0BtCa/Uw6oeSTJXJ4zlZWpffWTvyjWgQDGKeOtvxdjZ7nsu
 JvOLe5c2bIgY7WJLA/h9m4FUCCWcjABwYanaSfvChUYk82Z8y/sRZP8pDDRb+ZSwlX
 Yi7y1dE8/jibK9CnPp5xufnYDm7fjy8N3AnZ2zAwPwi9+bqMraDdXKwi1QoqPs8+JO
 L1Z1h8pqr5N6GrLA7FtOJcJNEZr7ogpR1OACJ746KoClzXTxbjyOFGoNRuLhezR/NH
 x2z/aB9/6iU7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: backlight: Add Orient Chip OCP8178
To: "Wim de With" <wf@dewith.io>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, lee@kernel.org, conor+dt@kernel.org,
 linux-leds@vger.kernel.org
In-Reply-To: <20260826-ocp8178-backlight-v4-1-47d7acce882e@dewith.io>
References: <20260826-ocp8178-backlight-v4-0-47d7acce882e@dewith.io>
 <20260826-ocp8178-backlight-v4-1-47d7acce882e@dewith.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 07:40:18 +0000
Message-Id: <20260826074018.5D0421F000E9@smtp.kernel.org>
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
- [Medium] Using `additionalProperties: false` with an `allOf` `$ref` break=
s property inheritance.
--

commit 76f37f9a56bf914fefbc5653351c8e4714ee18e8
Author: Wim de With <wf@dewith.io>

dt-bindings: backlight: Add Orient Chip OCP8178

Add device tree bindings for the Orient Chip OCP8178 LED backlight
driver.

> diff --git a/Documentation/devicetree/bindings/leds/backlight/ocs,ocp8178=
.yaml b/Documentation/devicetree/bindings/leds/backlight/ocs,ocp8178.yaml
> new file mode 100644
> index 0000000000000..1cd95aac0d168
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/ocs,ocp8178.yaml

[ ... ]

> +allOf:
> +  - $ref: common.yaml#
> +
> +properties:
> +  compatible:
> +    const: ocs,ocp8178

[ ... ]

> +required:
> +  - compatible
> +  - ctrl-gpios
> +
> +additionalProperties: false

[Severity: Medium]
Since this schema includes an allOf reference to common.yaml#, does using
additionalProperties: false break property inheritance? This will reject
standard backlight properties not explicitly listed in the local schema
during device tree validation.

Should this use unevaluatedProperties: false instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826-ocp8178-ba=
cklight-v4-0-47d7acce882e@dewith.io?part=3D1
