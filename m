Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1475AC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 14:28:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 539FC10ED86;
	Tue,  7 Jul 2026 14:28:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CtTgMoTi";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D587910ED86
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 14:28:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 32F636138A;
 Tue,  7 Jul 2026 14:28:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695821F00A3A;
 Tue,  7 Jul 2026 14:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783434496;
 bh=Nms9/XZgwR9douNdc28TyXxyzdrvEOBewOrL1S/fLgI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CtTgMoTiDmUKRF+AunWWAqJT/IJh/zgOfsCeWoSL4Jewbx9slF4TKppyZR2uLVgy6
 skc3zofrZAZFq0AOuw/LermFiV38jHg2emZIjUMvkOFKN2rxwh0+ah/fAGcLCvSfFe
 ntubjONyryzm1SZc8LnHpfT7+V53KcMyo8wSUaWfyKASRsa+aj5dyfnGiqCDfYUmJf
 bO6mbBIe5puaJ+GNxtEyI3N4WHTsr5x2KZK3lAZbwasii0J1NSPQlZ5+fkh2LMOIXM
 OEEC/7i++JSaSfLdkzv1nUIY0rQ7mT9wUvH0z3ToH5aIiPPwWF35FP/pSzkzGCbPZ/
 eTpi/hPtTjyxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/12] phy: phy-mtk-dp: Rewrite and document default
 driving param macros
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, vkoul@kernel.org, olteanv@gmail.com,
 neil.armstrong@linaro.org, linux-phy@lists.infradead.org, conor+dt@kernel.org,
 robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260707141931.191172-10-angelogioacchino.delregno@collabora.com>
References: <20260707141931.191172-1-angelogioacchino.delregno@collabora.com>
 <20260707141931.191172-10-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 14:28:15 +0000
Message-Id: <20260707142816.695821F00A3A@smtp.kernel.org>
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
- [Low] The patch uses `FIELD_PREP_CONST` (and earlier patches in the serie=
s use `FIELD_PREP`) without explicitly including `<linux/bitfield.h>`.
--

--- Patch [9]: [PATCH v2 09/12] phy: phy-mtk-dp: Rewrite and document defau=
lt driving param macros ---
commit e682fc4989b37eaa003ac03d4d2a9a69b306a63b
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

phy: phy-mtk-dp: Rewrite and document default driving param macros

This commit rewrites the default driving parameters for the PHY using
FIELD_PREP_CONST. It also adds definitions and comments to explain what
these parameters are supposed to set.

> diff --git a/drivers/phy/mediatek/phy-mtk-dp.c b/drivers/phy/mediatek/phy=
-mtk-dp.c
> index d0ef8e8f6670c..9a800d6b91c3f 100644
> --- a/drivers/phy/mediatek/phy-mtk-dp.c
> +++ b/drivers/phy/mediatek/phy-mtk-dp.c
> @@ -85,51 +85,47 @@

[ ... ]

> +#define XTP_LN_TX_LCTXC_SW2_PRE1	GENMASK(5, 0)
> +#define XTP_LN_TX_LCTXC_SW3_PRE0	GENMASK(13, 8)
> +
> +#define BUILD_DRIVING_PARAM_0(sw0_pre0, sw0_pre1, sw0_pre2, sw0_pre3) (	\
> +	FIELD_PREP_CONST(XTP_LN_TX_LCTXC_SW0_PRE0, sw0_pre0) |		\

[Severity: Low]
This isn't a bug, but should linux/bitfield.h be explicitly included since
this code now uses FIELD_PREP_CONST?=20

Relying on implicit inclusions can cause build breakages in the future if a
header like linux/phy/phy.h or linux/regmap.h stops including it.

> +	FIELD_PREP_CONST(XTP_LN_TX_LCTXC_SW0_PRE1, sw0_pre1) |		\
> +	FIELD_PREP_CONST(XTP_LN_TX_LCTXC_SW0_PRE2, sw0_pre2) |		\
> +	FIELD_PREP_CONST(XTP_LN_TX_LCTXC_SW0_PRE3, sw0_pre3)		\
> +)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707141931.1911=
72-1-angelogioacchino.delregno@collabora.com?part=3D9
