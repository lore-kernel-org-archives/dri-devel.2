Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82621606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I/jse2Rk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9957010EE72;
	Tue, 24 Nov 2026 07:40:38 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DFFC10EE72
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 07:40:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 44BBC41653;
 Tue, 24 Nov 2026 07:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF621F000D0;
 Tue, 24 Nov 2026 07:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795506032;
 bh=1LevJtmKfjqye0X/IH+VwjyhHGPkDVR9ieTbL1FhTzE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=I/jse2RkgI2YYsBRMes2VH4YJvITooyzzp5bcMJMf+r+XG5NPHXyqLTmOnZwusaEH
 xiEjGAZZYLFbjUvGFwn0XfmjoFWOCdhNd+YYYggeIYMsT2po5Mvsxhkv/PdRrX2Noo
 WiPLaNeKZhkANFX+eEKxidjxtcfqTeLcr5EVftkJCL4e8G3HaHwiwlmHJsV6e6paNf
 xtuyqn9Wml3XzXavg6VtwS2p4CJhPrucw4j1J+kZ+kCHp8bAQpWN+VCicM2f12NR/3
 Dl8QGMYfsLEyPF5szG22VyICKlmkb8KFQLPNG74gj02AI+RArAdqkfIFwAT3n23zH1
 oKAy+83C9h9iQ==
Message-ID: <sashiko-outbox-230655@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/20] dt-bindings: sound: Document OpenPandora sound
 card
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 linux-sound@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 lee@kernel.org
In-Reply-To: <5c6f7deca16f70f1f19cb40c57d70e30068d6000.1795505160.git.hns@goldelico.com>
References: <cover.1795505160.git.hns@goldelico.com>
 <5c6f7deca16f70f1f19cb40c57d70e30068d6000.1795505160.git.hns@goldelico.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 07:40:31 +0000
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
- [Medium] dt-bindings: sound: openpandora sound-dai omits mcbsp4 and
  twl4030 DAIs
- [Low] dt-bindings: sound: openpandora sound-dai lacks per-entry items
  list
- [Low] dt-bindings: sound: openpandora example has status property and
  wrong order
--

commit a7d9248344c1d8736a83ed4cfd8b21aad87db0cb
Author: H. Nikolaus Schaller <hns@goldelico.com>

dt-bindings: sound: Document OpenPandora sound card

This commit adds a Device Tree binding schema for the OpenPandora OMAP3
audio subsystem connecting OMAP3 McBSP, the PCM1773 DAC, and the TWL4030
codec.

> diff --git a/Documentation/devicetree/bindings/sound/openpandora,omap3pan=
dora-sound.yaml b/Documentation/devicetree/bindings/sound/openpandora,omap3=
pandora-sound.yaml
> new file mode 100644
> index 0000000000000..6c4d69ffc1c50
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/openpandora,omap3pandora-so=
und.yaml

[ ... ]

> +  sound-dai:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    minItems: 2
> +    maxItems: 2
> +    description:
> +      Phandles to the audio CPU DAI (OMAP3 McBSP) and the codec DAI.

[Severity: Low]
Should sound-dai define an items list with a per-entry description for
each phandle instead of using minItems/maxItems with a free-form
description?

[ ... ]

> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    sound {
> +        compatible =3D "openpandora,omap3pandora-sound";
> +        status =3D "okay";
> +
> +        label =3D "OpenPandora";
> +
> +        amp-gpios =3D <&gpio1 14 GPIO_ACTIVE_HIGH>;
> +        amp-supply =3D <&aux_5v>;
> +
> +        widgets =3D
> +            "Line", "Line Out",
> +            "Line", "Line In",
> +            "Headphone", "Headphone Jack",
> +            "Microphone", "Mic (internal)",
> +            "Microphone", "Mic (external)";

[Severity: Low]
DT binding examples normally omit status =3D "okay", and the property
order in the example node (widgets, routing, sound-dai) does not match
the order declared under properties: in the schema (sound-dai, routing,
widgets).

> +
> +        routing =3D
> +            "DAC1", "APLL Enable",
> +            "DAC2", "APLL Enable",
> +            "Headphone Amplifier", "VOUTL",
> +            "Headphone Amplifier", "VOUTR",
> +            "Line Out", "VOUTL",
> +            "Line Out", "VOUTR",
> +            "Headphone Jack", "Headphone Amplifier",
> +            "AUXL", "Line In",
> +            "AUXR", "Line In",
> +            "MAINMIC", "Mic (internal)",
> +            "Mic (internal)", "Mic Bias 1",
> +            "SUBMIC", "Mic (external)",
> +            "Mic (external)", "Mic Bias 2";
> +
> +        sound-dai =3D <&mcbsp2>, <&dac>;
> +    };

[Severity: Medium]
Does constraining sound-dai to two phandles omit the second DAI link for
OMAP3 McBSP4 and the TWL4030 codec?

The OpenPandora audio complex (sound/soc/ti/omap3pandora.c) uses two DAI
links: McBSP2 connected to the PCM1773 DAC for playback, and McBSP4
connected to the TWL4030 codec for capture and APLL clocking.  The
schema description and the example routing table both include the
TWL4030 widgets (APLL Enable, AUXL, AUXR, MAINMIC, SUBMIC, Mic Bias 1,
Mic Bias 2), but sound-dai only allows two entries and lists only
<&mcbsp2> and <&dac>.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795505160.gi=
t.hns@goldelico.com?part=3D6
