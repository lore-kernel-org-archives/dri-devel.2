Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD362C43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 06:08:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BF7A10E727;
	Sat, 11 Jul 2026 06:08:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BMlVMNE/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AD6010E727
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 06:08:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 50B24431CF;
 Sat, 11 Jul 2026 06:08:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5C31F000E9;
 Sat, 11 Jul 2026 06:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783750117;
 bh=GmCDzHvKzZG41jtnajg3n+SiMxUDv8sj7VejOOpbaOg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BMlVMNE/Iev/LwggCq3vM5HAmUPY3bS2/2FsrFkAOZijGwCcNQMEoBJfEAbgcYG8Q
 o4LK320hFGZH2ybJ8ZDpzblqpmMxI7vSftdnOTmG7wsxnFMqO1jlxwnN16T5GLHbUY
 opIQQH6XrDQcDfHN24SVkgm7Yr7Botg7FHURHg7F09FTANPZ7J8GMaPAdDwe85LWdl
 xaeh8eQG1NrDyYOivUCNeOUwch5SuwmIZrq8p22o2CYgi/ovg4KAAJGqO3LFc6s5JK
 G1pOuZ/C6o6edO/42o264mBIpQ1a64doTotPgVn1+4zvUi0hhUitXT7/Ialbgq5zVa
 G1PAOvbSrUt1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/16] ASoC: dt-bindings: add TI PCM1773
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, lee@kernel.org, conor+dt@kernel.org, mfd@lists.linux.dev
In-Reply-To: <a02383ea5907a677f4c61066d423efde2b9de48b.1783749722.git.hns@goldelico.com>
References: <cover.1783749722.git.hns@goldelico.com>
 <a02383ea5907a677f4c61066d423efde2b9de48b.1783749722.git.hns@goldelico.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 06:08:36 +0000
Message-Id: <20260711060836.CD5C31F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Incorrect `$id` path with extra `bindings/` directory component.
- [Low] Undocumented property `enable-gpios` is used in the example but mis=
sing from the `properties` block.
--

--- Patch [7]: [PATCH 07/16] ASoC: dt-bindings: add TI PCM1773 ---
commit 743fe66d5b39db7483986e7887f8d34c7081d440
Author: H. Nikolaus Schaller <hns@goldelico.com>

ASoC: dt-bindings: add TI PCM1773

This commit adds a new device tree binding for the Texas Instruments PCM1771
and PCM1773 simple audio codecs. It documents the compatible string and sho=
ws
basic usage.

> diff --git a/Documentation/devicetree/bindings/sound/pcm1773.yaml b/Docum=
entation/devicetree/bindings/sound/pcm1773.yaml
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/pcm1773.yaml
> @@ -0,0 +1,32 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bindings/sound/pcm1773.yaml#

[Severity: Low]
Does this $id path match the exact file path relative to
Documentation/devicetree/bindings/? It looks like there is an extra
bindings/ directory component here which might cause schema cross-reference
resolution to fail or dt_binding_check to skip validation.

[ ... ]

> +properties:
> +  compatible:
> +    const: ti,pcm1773
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    audio-codec {
> +      compatible =3D "ti,pcm1773";
> +      enable-gpios =3D <&gpio4 22 GPIO_ACTIVE_LOW>;

[Severity: Low]
Will this example fail dt_binding_check validation? The schema uses
additionalProperties: false, but enable-gpios is omitted from the properties
block above, which will cause the strict schema validation to reject this
example and any actual device tree nodes using the property.

> +    };
> +
> +...

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783749722.gi=
t.hns@goldelico.com?part=3D7
