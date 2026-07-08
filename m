Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9637DC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 12:37:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F008E10E601;
	Wed,  8 Jul 2026 12:37:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JKGqwLn2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB20510E601
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 12:37:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CE88E60008;
 Wed,  8 Jul 2026 12:37:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289401F000E9;
 Wed,  8 Jul 2026 12:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783514258;
 bh=8fUFQDzaUf36uu7CDdNF60MWQnD0G9Nnv1PIm09s/RI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JKGqwLn2f/56m8y6eAKhEWCzCiLcujvPhOW8iqtGW/ro+U+zcpe3AtaBSqJp9H/aU
 T24PuOjJBjRVdIuXQo9QQ7+MXUChvLqSni4oQpKrGAs0kEhbKaLXGZHIQ3CT1EQepJ
 Dhv+z0mZxU5YG2K7cMIrClE5dMWYzEospHINkLs8X+ku10cvBxL80NQBE1MfKjIw77
 0KKRDiuGssYKAOoMfSqHMwVO3mcpiwYHd01U1iQrN/PDjZELtE4B/6sX63Vjm6vfT4
 V8dKfxr5J4fQfD+KepmlrHFTZJG7MVfLBE88/QX5caGAjQV3U/mc+cbvxv2QXqvwse
 lpa2shIiPbB/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: leds: backlight: Convert TPS65217 to DT
 schema
To: "Eduard Bostina" <egbostina@gmail.com>
Cc: lee@kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, linux-leds@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260708123317.1768641-1-egbostina@gmail.com>
References: <20260708123317.1768641-1-egbostina@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 12:37:37 +0000
Message-Id: <20260708123738.289401F000E9@smtp.kernel.org>
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

> Convert the Texas Instruments TPS65217 PMIC bindings to DT schema.
>=20
> During the conversion, the following updates were made:
> - Make the 'backlight' node optional to resolve dtbs_check warnings.
>   Some boards declare a bare TPS65217 node without implementing the
>   backlight configuration.
> - Document the 'isink-en' property in the backlight subnode to resolve
>   dtbs_check warnings. This property is used (am335x-guardian.dts)
>   to manage the backlight current sinks. It was missing from the old
>   txt binding.
> - 'additionalProperties: true' is at the top level because the
>   TPS65217 node is documented across multiple independent schemas
>   matching the same compatible string.
>=20
> Signed-off-by: Eduard Bostina <egbostina@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708123317.1768=
641-1-egbostina@gmail.com?part=3D1

