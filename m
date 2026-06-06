Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94203CD6E55
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 05:08:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B541C112D22;
	Sat,  6 Jun 2026 05:08:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L/EWXQ3R";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06188112D22
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 05:08:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 91894402BF;
 Sat,  6 Jun 2026 05:08:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1278C1F00893;
 Sat,  6 Jun 2026 05:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780722519;
 bh=zfrpr2ZwbwsXzpaIjP4ZAyy37/spCmP0osyV0BEpaMY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=L/EWXQ3Re/Uiv1l0a2xm+pAeQtziVLMCDQAUsyD3yq+DxiOR4hvUuS1EMKgGxiTD3
 5n0zCOMmnz9E2khCPvzMkv/MuGt50gwv43Cxxx2nA+gddBF9CfriMQCg/EgKDLu92v
 6391AKXdDxzRJamPALXkX1UNtM6m5mo+7gSaFcEH70uSIOCEbcnI9R7CyrBAcXcQ6c
 Fia+dYRNhY0HXMO3Kdb62KFXoPkzAY+3p80mEpTWLxQiCxycG3d6Gx4trskjgQ853C
 /rF3P3P3e2Fzv1LHuEeNqxqeOSNMqRZdicDYL76zUjy0fDZM95euR8tVFsvlqGdCQB
 NgtQjGIu8WrTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/14] mfd: lm3533: Set DMA mask
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260606045738.21050-11-clamor95@gmail.com>
References: <20260606045738.21050-11-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 05:08:38 +0000
Message-Id: <20260606050839.1278C1F00893@smtp.kernel.org>
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

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but an out-of-bounds=
 array write occurs in `lm3533_device_init` when a child node contains mult=
iple matching compatible strings.
--

commit 5fa77e39c45bca237d41fbd7e2b8b8b97be664ec
Author: Svyatoslav Ryhel <clamor95@gmail.com>

mfd: lm3533: Set DMA mask

This commit sets the DMA mask to zero to prevent a warning in dmesg about
the DMA mask not being set for the platform device. It applies to both
the coherent and regular DMA mask, as neither the core nor the cells
utilize DMA.

> diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
> index 500cec3ccebad..5d17da1d998b5 100644
> --- a/drivers/mfd/lm3533-core.c
> +++ b/drivers/mfd/lm3533-core.c
[ ... ]
> @@ -489,6 +489,10 @@ static int lm3533_i2c_probe(struct i2c_client *i2c)
>  				   LM3533_BOOST_FREQ_MAX);
>  	lm3533->boost_freq =3D lm3533->boost_freq / (500 * KILO) - 1;
> =20
> +	/* LM3533 and child devices do not use DMA */
> +	i2c->dev.coherent_dma_mask =3D 0;
> +	i2c->dev.dma_mask =3D &i2c->dev.coherent_dma_mask;
> +
>  	return lm3533_device_init(lm3533);
>  }

[Severity: High]
This is a pre-existing issue, but can the device initialization in
lm3533_device_init() write past the bounds of the lm3533_devices array?

The array is allocated based on the total number of child nodes:

lm3533_devices =3D devm_kcalloc(dev, nchilds, sizeof(*lm3533_devices),
                              GFP_KERNEL);

However, inside the device_for_each_child_node_scoped() loop, the
compatibility checks are independent if statements without an else if or
continue:

if (fwnode_device_is_compatible(child, "ti,lm3533-als")) {
        lm3533_devices[count].name =3D "lm3533-als";
        ...
        count++;
}

if (fwnode_device_is_compatible(child, "ti,lm3533-backlight")) {
        ...
        count++;
}

If a single child node contains multiple matching compatible strings,
such as "ti,lm3533-als" and "ti,lm3533-backlight", count will be
incremented multiple times during a single loop iteration.

Since the bounds check if (count >=3D nchilds) break; only happens at the
start of the loop, this sequence would allow count to exceed nchilds,
writing out of bounds on the lm3533_devices array.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606045738.2105=
0-1-clamor95@gmail.com?part=3D10
