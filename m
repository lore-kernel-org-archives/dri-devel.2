Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35F9606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 16:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jgFoEId8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2765510F63A;
	Tue, 24 Nov 2026 16:09:58 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85E0510F63A
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 16:09:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6F108415AA;
 Tue, 24 Nov 2026 16:09:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28671F000C4;
 Tue, 24 Nov 2026 16:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795536592;
 bh=t8ZjfPRSG9HJtipz5fNNGb10T+NLQlGfxzG9Gitm4As=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jgFoEId83C3WMYleqZh7uKZH+Np5kScOZrqBM7QWYD2ZDkVraC6PQ2ARfRgLjW6VN
 G32gVqO7ucd9pmgBq1c4Vur9rVLU8YtQrwP23YTutRA/B8mhJIJ8/NHiaZKGcUEWRh
 WQ/+pcyx2Q+Xl7J0IHe11O98YBOCu//wBK8uap5zGQ31tjFApELwPGkWLoovLqhHxr
 bf3Jw1GNHyL3GByYsw0bhGODWC8hIj7HPeh+hH8gpN58IzMqTlSr9skgkD0O3JoLYz
 Bdwic382V0gPhqedjBYLmR34UQNUVmdu8uImOHKdKcRRfVVolAFqMD/XXM9UI5A4vA
 ZJVM5q1QRaklQ==
Message-ID: <sashiko-outbox-231533@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 14/18] soc: starfive: Add jh7110-hdmi-subsystem driver
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261124-jh7110-clean-send-v8-14-de92635dd857@samsung.com>
References: <20261124-jh7110-clean-send-v8-0-de92635dd857@samsung.com>
 <CGME20261124155425eucas1p2035620902a47a26cb56909c0afda250f@eucas1p2.samsung.com>
 <20261124-jh7110-clean-send-v8-14-de92635dd857@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 16:09:51 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] soc: starfive: wrong regmap stride and val_bits in
  jh7110-hdmi-subsystem
--

commit 53f4e237d4154b9fe38d95df3857cd80819078dc
Author: Michal Wilczynski <m.wilczynski@samsung.com>

soc: starfive: Add jh7110-hdmi-subsystem driver

This commit adds the parent platform driver for the StarFive JH7110 HDMI
subsystem, initializing a shared MMIO regmap and populating its HDMI
controller and PHY child devices.

> diff --git a/drivers/soc/starfive/jh7110-hdmi-subsystem.c b/drivers/soc/s=
tarfive/jh7110-hdmi-subsystem.c
> new file mode 100644
> index 0000000000000..b01dc66450f51
> --- /dev/null
> +++ b/drivers/soc/starfive/jh7110-hdmi-subsystem.c
> @@ -0,0 +1,72 @@
[ ... ]
> +static const struct regmap_config starfive_hdmi_regmap_config =3D {
> +	.reg_bits =3D 32,
> +	.val_bits =3D 8,
> +	.max_register =3D 0x3fff,
> +};

[Severity: Medium]
Should starfive_hdmi_regmap_config set .val_bits =3D 32, .reg_stride =3D 4,
and .max_register =3D 0x3ffc?

Both child drivers that consume this shared regmap address registers at
4-byte offsets (offset * 4 in drivers/gpu/drm/bridge/inno-hdmi.c and
reg * 4 in drivers/phy/starfive/phy-jh7110-inno-hdmi.c), and the
controller's own fallback regmap config uses 32-bit accesses with a
4-byte stride:

drivers/gpu/drm/bridge/inno-hdmi.c:
static const struct regmap_config inno_hdmi_regmap_config =3D {
	.reg_bits =3D 32,
	.val_bits =3D 32,
	.reg_stride =3D 4,
};

With .val_bits =3D 8 and the default 1-byte stride, regmap_mmio uses byte
accessors (readb/writeb) instead of 32-bit accessors (readl/writel), does
not check 4-byte alignment, and regmap debugfs dumps step through 0x0000..
0x3fff by 1 byte, issuing unaligned byte reads to the upper three bytes
of every 32-bit register slot.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-jh7110-cle=
an-send-v8-0-de92635dd857@samsung.com?part=3D14
