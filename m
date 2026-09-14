Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16BBEC88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 17:50:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53DE210F0B5;
	Mon, 14 Sep 2026 17:50:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fr6ndC5h";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D9A610F0B5
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 17:50:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 98604602A8;
 Mon, 14 Sep 2026 17:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D701F000FF;
 Mon, 14 Sep 2026 17:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789408241;
 bh=xMtGSZ9GCYGfMAl4B0AAky5+obOwCakTK3amOkLiNKs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fr6ndC5h8Bpvedb7EX2dHaYrGIMgCwWpt0gvC5JzHJDRleU146fcWr0ArtTsUoHF3
 Plzyjk/TI5nWxcEtWebQX9B/T80BmSgIxSM5g+UpFH1c55bqYOE751Inh8nGw3oN6A
 t0S9KUUtuD/praJdckYv6Ab9I2lFy83o51ZZKWVspR/XSe4vbJDGge85ceHrrPXDQ7
 Edg0xUVhN+h5xNVDze/TGqU5GTnJ1sOutchoGG1gZQo56/AAemRQiY9Dob1LkPWZsH
 A0H6gYve4t9Z/5ennnqsUvr5Y79JmuV5+H1DRm43sKMVQE2eFpgmeHxGGXFtppy4TR
 AzLG+3ZXM2BUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] backlight: qcom-wled: Fix WLED3 brightness
 register stride
To: "David Heidelberg" <david@ixit.cz>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260914-qcom-wled-backlight-v2-1-a908d9233e93@ixit.cz>
References: <20260914-qcom-wled-backlight-v2-0-a908d9233e93@ixit.cz>
 <20260914-qcom-wled-backlight-v2-1-a908d9233e93@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 17:50:40 +0000
Message-Id: <20260914175041.25D701F000FF@smtp.kernel.org>
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
- [High] The patch incorrectly implements a 16-byte stride for WLED3 bright=
ness registers instead of the intended 2-byte stride, causing register coll=
ision and corruption.
--

commit f7a2ef410d595586ca0ef2c87637e54f23dec1e2
Author: David Heidelberg <david@ixit.cz>
Subject: backlight: qcom-wled: Fix WLED3 brightness register stride

This commit aims to fix an overlapping brightness register write issue in t=
he
WLED3 driver. It modifies the WLED3_SINK_REG_BRIGHT macro to update the
register stride for consecutive strings. The commit message states the inte=
nt
is to use a 2-byte stride.

> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backligh=
t/qcom-wled.c
> index 650dd95f06ef5..22c35da72dce3 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
> @@ -59,7 +59,7 @@
>  #define  WLED3_SINK_REG_CURR_SINK_SHFT			5
> =20
>  /* WLED3 specific per-'string' registers below */
> -#define WLED3_SINK_REG_BRIGHT(n)			(0x40 + n)
> +#define WLED3_SINK_REG_BRIGHT(n)			(0x40 + (n * 0x10))

[Severity: High]
Does this code incorrectly implement a 16-byte stride instead of the intend=
ed
2-byte stride?

The commit message states "Use the 2 byte stride.", but the macro evaluates=
 to
a 16-byte stride (n * 0x10) instead of a mathematically sound 2-byte stride
(n * 2).

When wled3_set_brightness() evaluates this macro and passes it to
regmap_bulk_write():

drivers/video/backlight/qcom-wled.c:wled3_set_brightness() {
    ...
		rc =3D regmap_bulk_write(wled->regmap, wled->ctrl_addr +
				       WLED3_SINK_REG_BRIGHT(wled->cfg.enabled_strings[i]),
				       &v, sizeof(v));
    ...
}

Writing 2 bytes to WLED3_SINK_REG_BRIGHT(2) calculates the address as
0x40 + 0x20 =3D 0x60. This will overwrite the adjacent control register
WLED3_SINK_REG_STR_MOD_EN(0) (which is also defined as 0x60 + 0x00), causing
hardware control register corruption.

> =20
>  #define WLED3_SINK_REG_STR_MOD_EN(n)			(0x60 + (n * 0x10))
>  #define  WLED3_SINK_REG_STR_MOD_MASK			BIT(7)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914-qcom-wled-=
backlight-v2-0-a908d9233e93@ixit.cz?part=3D1
