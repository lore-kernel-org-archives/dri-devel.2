Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFDBCC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:58:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C08310E23F;
	Thu, 15 Oct 2026 09:57:59 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8D3B10EB9C
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:57:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CD3E5601F0;
 Thu, 15 Oct 2026 09:57:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649281F000C4;
 Thu, 15 Oct 2026 09:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792058272;
 bh=Pr6pDRKqsDDyXckII64KJB4a2rFLkkihia34H5Bc+qI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Rota2NvcRx4bhysJj8Jh3yait+xquUxnmRWhHb1VBKAlgJxHMVC6YpOPAqIqPvNjO
 uKl8XlA7Bn/zluFOrdswz6YPiGXLBO6l7RX3c/XdxQmC5hiEqAAp83ErFh221Zb1jX
 eojRm34goatjQIaUsf4oYmTFJNATSTiMrr367RqqGCcZtYJm81NQCeN/L2TmON05NA
 Lgm7a+3z1IL7huGn0agJikW9GB05mJMmnfStc9BonyrwqjBgTqz52RNBjDM8gBTO6r
 w8GjkIsE++UZaXSvGOpeuNHWTwQmZhkaGS28iBrsF6pU5fonBfQvAo79bisyVbmKpr
 t/irStpND9iOg==
Message-ID: <sashiko-outbox-172614@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] drm/bridge: ite-it66121: improve reading IDs and
 log on errors
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261015-drm-ite-it66121-log-probe-errors-v1-1-7fd6994e0be0@bootlin.com>
References: <20261015-drm-ite-it66121-log-probe-errors-v1-0-7fd6994e0be0@bootlin.com>
 <20261015-drm-ite-it66121-log-probe-errors-v1-1-7fd6994e0be0@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 09:57:51 +0000
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
- [Low] drm: Sparse warnings due to __u16 usage for little-endian data
--

commit 8f50576e49682d9068991d3e7de12fc063b0685f
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>
drm/bridge: ite-it66121: improve reading IDs and log on errors

This commit switches from individual regmap_read() calls to a single
regmap_bulk_read() when fetching vendor and device IDs. It introduces a
union to explicitly handle the data bytes and adds proper error checking
to prevent silently continuing with invalid values.

> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridg=
e/ite-it66121.c
> --- a/drivers/gpu/drm/bridge/ite-it66121.c
> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> @@ -1579,7 +1579,16 @@ static const struct it66121_chip_info it66xx_chip_=
info[] =3D {
> =20
>  static int it66121_probe(struct i2c_client *client)
>  {
> -	u32 revision_id, vendor_ids[2] =3D { 0 }, device_ids[2] =3D { 0 };
> +	union {
> +		__u8 byte[4];
> +		struct {
> +			__u16 vendor;
> +			__u16 device;
> +		};

[Severity: Low]
Should these fields be declared as __le16 instead of __u16?

Since they hold little-endian data populated directly by regmap_bulk_read()
and are later passed to le16_to_cpu(), using natively-typed __u16 here
violates the kernel's endianness typing rules and triggers Sparse warnings
for incorrect types.

> +	} chip_id_regs;
> +	BUILD_BUG_ON(sizeof(chip_id_regs) !=3D 4);
> +	u16 vendor_id, device_id;

[ ... ]

> @@ -1643,19 +1652,22 @@ static int it66121_probe(struct i2c_client *clien=
t)

[ ... ]

> +	vendor_id =3D le16_to_cpu(chip_id_regs.vendor);
> +	device_id =3D le16_to_cpu(chip_id_regs.device);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-drm-ite-it=
66121-log-probe-errors-v1-0-7fd6994e0be0@bootlin.com?part=3D1
