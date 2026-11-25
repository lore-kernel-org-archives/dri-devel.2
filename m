Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41E3606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cl+ar3mT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BAD010F998;
	Wed, 25 Nov 2026 02:19:37 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6025010F994
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 02:19:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1E1424390C;
 Wed, 25 Nov 2026 02:19:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868D11F000D0;
 Wed, 25 Nov 2026 02:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795573169;
 bh=y6lFZz4Fpy3uKtsMrfEHfrJltL2TqjLKliIhVZ69M0k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Cl+ar3mTIiDw0bVLHuC/pzi703kn0cy1BUef/AocukAuAfjPp0rP+l4SySMu+2tU5
 0XxVD0nqkvRxRWT4ca7ayP7d1K+cMCYVd6/2MUvRPtlcTScWn8zlB/NNRfUfp4HjEE
 N0lg4tB8+T+bNeijzSx6b0ViR8OE7gkvgwf12hUyI5scGg9WSfiPEfaH0IKbh318Gg
 DO3Cm7fgXhJfJvag/5n/O+C9O+Bd4H/VH55H70L71R6bPkxc8V/zbsynMaPZb6Zzwu
 zwoUlW+TYF+BSKasvWfNJwVtI536l67POApavSkQhjnAmlLKaM8JQ4TTovem4DSL8p
 36Bd5uGw8PPuw==
Message-ID: <sashiko-outbox-232401@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/6] dt-bindings: backlight: add VIEWE I2C backlight
 binding
To: Hefei <3066883572@qq.com>, dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <tencent_33047574BCFD03DA2AE57B9890EB09FE7705@qq.com>
References: <20261125021127.1430-1-3066883572@qq.com>
 <tencent_33047574BCFD03DA2AE57B9890EB09FE7705@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 02:19:29 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Low] dt-bindings: backlight: undocumented vendor prefix viewe in
  compatible
- [Low] dt-bindings: backlight: schema filename mismatches
  viewe,7kf82-backlight
- [Low] dt-bindings: backlight: redundant binding in subject and empty
  changelog
--

commit b74671fa2d89ece52daffc3be1232b5909e8c227
Author: Hefei <3066883572@qq.com>

> dt-bindings: backlight: add VIEWE I2C backlight binding
>
> Signed-off-by: Hefei <3066883572@qq.com>

[Severity: Low]
The dt-bindings: prefix already indicates a binding patch, so the trailing
word "binding" in the subject is redundant.  Could you drop it and add a
commit message body describing the hardware?

> diff --git a/Documentation/devicetree/bindings/leds/backlight/viewe,i2c-b=
acklight.yaml b/Documentation/devicetree/bindings/leds/backlight/viewe,i2c-=
backlight.yaml
> new file mode 100644
> index 0000000000000..9be4bc93087ae
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/viewe,i2c-backligh=
t.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/backlight/viewe,i2c-backlight.ya=
ml#

[Severity: Low]
Should the schema filename and $id be viewe,7kf82-backlight.yaml to match
the sole compatible string defined below, as required by
Documentation/devicetree/bindings/writing-bindings.rst?

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: VIEWE 7KF82 I2C panel backlight
> +
> +maintainers:
> +  - Hefei <3066883572@qq.com>
> +
> +description: |
> +  I2C backlight MCU used on the VIEWE 7KF82 DSI module. Protocol is devi=
ce
> +  address 0x45, register 0x86, brightness 0..255. A discrete MCU part nu=
mber
> +  is not exposed on the FPC silk; the binding is therefore keyed to the
> +  module.
> +
> +allOf:
> +  - $ref: common.yaml#
> +
> +properties:
> +  compatible:
> +    const: viewe,7kf82-backlight

[Severity: Low]
Is there a patch registering the viewe vendor prefix in
Documentation/devicetree/bindings/vendor-prefixes.yaml?  Without an entry
for ^viewe,.*, make dt_binding_check and checkpatch.pl fail on
viewe,7kf82-backlight.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_A3BF23A8B6E=
3691F0D567ADF8B84194F4408@qq.com?part=3D3
