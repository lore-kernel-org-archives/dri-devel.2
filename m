Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70505CA9EC7
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 08:33:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9801B10E01F;
	Sun, 11 Oct 2026 08:33:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ouA1yz3b";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 161E810E01F
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 08:33:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 19731600AA;
 Sun, 11 Oct 2026 08:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC2B1F0089B;
 Sun, 11 Oct 2026 08:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791707604;
 bh=21p/tNdTknSSHsuxJ9ami0fbfcIm8YfZRuAP2R8IzYo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ouA1yz3bssGz9jRBEwjQVtUoh8C86dwsMoAhVobomND9tU03XrUGmDxKLNFOtfyiC
 tcL89HkDyaAbvr5HK97siqPEZlvfiv/JQsb0i+gehU3Nd+Ih+23zxOF6UpSkk/YotQ
 NzqMxrfpm20lNxiuAe+T2ZFJNmANci+jF1efP9luzZnyXfd/HFprbDEgPkgQsPqiS1
 TbgRPHUTten7XC12PjdkJgW5sxEXObp6ci2Ix6M+p0b5tjRrzsXLTZOqdGW7dsktTa
 rynQE1mxHlLVnbyx13idRWHBicuOnS+c9hHOPHHtKSu9SNko+WqYM1wA2XEFHQkjKo
 Qln8DuB96KKsg==
Message-ID: <sashiko-outbox-167123@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/1] phy: mediatek: phy-mtk-hdmi: Use regmap to
 manipulate hdmi registers
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: neil.armstrong@linaro.org, vkoul@kernel.org, linux-phy@lists.infradead.org,
 olteanv@gmail.com, dri-devel@lists.freedesktop.org
In-Reply-To: <20261011082042.348422-2-l.scorcia@gmail.com>
References: <20261011082042.348422-1-l.scorcia@gmail.com>
 <20261011082042.348422-2-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 08:33:23 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] phy: mediatek: uninitialized stack variable used if regmap_read(=
) fails
- [Medium] phy: mediatek: uninitialized stack variable use if regmap_read()=
 fails
- [Low] Build: missing explicit include of <linux/bitfield.h>
--

commit 0d55ccaecdee64be04bc28971e8e4aca3393e3a3
Author: Luca Leonardo Scorcia <l.scorcia@gmail.com>

phy: mediatek: phy-mtk-hdmi: Use regmap to manipulate hdmi registers

This commit transitions the Mediatek HDMI PHY driver to use the regmap API
for register manipulation, removing custom helpers. This resolves an -EBUSY
error on mt8167 devices where the HDMI PHY registers are mapped inside the
apmixedsys memory space.

> diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c b/drivers/phy/med=
iatek/phy-mtk-hdmi-mt2701.c
> index c9a1f20e939b9..7fcf9116a0a93 100644
> --- a/drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c
> +++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c
> @@ -5,7 +5,13 @@
>   */
> =20
>  #include "phy-mtk-hdmi.h"
> -#include "phy-mtk-io.h"
> +
> +/* field @mask shall be constant and continuous */
> +#define mtk_phy_update_regmap_field(regmap, reg, mask, val) \
> +({ \
> +	BUILD_BUG_ON_MSG(!__builtin_constant_p(mask), "mask is not constant"); \
> +	regmap_update_bits(regmap, reg, mask, FIELD_PREP(mask, val)); \
> +})

[Severity: Low]
The code removes phy-mtk-io.h which explicitly included <linux/bitfield.h>,
but does not add <linux/bitfield.h> while still using FIELD_PREP. Relying on
implicit transitive inclusion for core bitfield macros can sometimes cause
build failures across different architectures or under varying compiler fla=
gs.
Should <linux/bitfield.h> be explicitly included in this file or the common
header?

[ ... ]

> @@ -133,7 +136,7 @@ static unsigned long mtk_hdmi_pll_recalc_rate(struct =
clk_hw *hw,
>  	unsigned long out_rate, val;
>  	u32 tmp;
> =20
> -	tmp =3D readl(hdmi_phy->regs + HDMI_CON6);
> +	regmap_read(hdmi_phy->regs, HDMI_CON6, &tmp);
>  	val =3D FIELD_GET(RG_HTPLL_PREDIV_MASK, tmp);

[Severity: Medium]
If regmap_read() fails and returns an error code, tmp is left uninitialized.
Using the uninitialized stack variable tmp in the FIELD_GET macro leads to
undefined behavior, which could result in incorrect PLL clock rates. Should=
 the
return value of regmap_read() be checked here?

>  	switch (val) {
>  	case 0x00:
> @@ -150,7 +153,7 @@ static unsigned long mtk_hdmi_pll_recalc_rate(struct =
clk_hw *hw,
>  	val =3D FIELD_GET(RG_HTPLL_FBKDIV_MASK, tmp);
>  	out_rate *=3D (val + 1) * 2;
> =20
> -	tmp =3D readl(hdmi_phy->regs + HDMI_CON2);
> +	regmap_read(hdmi_phy->regs, HDMI_CON2, &tmp);
>  	val =3D FIELD_GET(RG_HDMITX_TX_POSDIV_MASK, tmp);

[Severity: Medium]
Similar to the previous read, if regmap_read() fails, tmp remains
uninitialized. Does this also need an error check?

[ ... ]

> diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt8173.c b/drivers/phy/med=
iatek/phy-mtk-hdmi-mt8173.c
> index 58c6596c8c20b..6df997ff74c97 100644
> --- a/drivers/phy/mediatek/phy-mtk-hdmi-mt8173.c
> +++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt8173.c
> @@ -5,7 +5,13 @@
>   */
> =20
>  #include "phy-mtk-hdmi.h"
> -#include "phy-mtk-io.h"
> +
> +/* field @mask shall be constant and continuous */
> +#define mtk_phy_update_regmap_field(regmap, reg, mask, val) \
> +({ \
> +	BUILD_BUG_ON_MSG(!__builtin_constant_p(mask), "mask is not constant"); \
> +	regmap_update_bits(regmap, reg, mask, FIELD_PREP(mask, val)); \
> +})

[Severity: Low]
As in the mt2701 driver, <linux/bitfield.h> is not explicitly included but
FIELD_PREP is used. Should the header be explicitly included here as well?

[ ... ]

> diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c b/drivers/phy/med=
iatek/phy-mtk-hdmi-mt8195.c
> index a4bc1268946d8..5d6122277725a 100644
> --- a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
> +++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
> @@ -15,62 +15,64 @@
>  #include <linux/units.h>
>  #include <linux/nvmem-consumer.h>
> =20
> -#include "phy-mtk-io.h"
>  #include "phy-mtk-hdmi.h"
>  #include "phy-mtk-hdmi-mt8195.h"
> =20
> +/* field @mask shall be constant and continuous */
> +#define mtk_phy_update_regmap_field(regmap, reg, mask, val) \
> +({ \
> +	BUILD_BUG_ON_MSG(!__builtin_constant_p(mask), "mask is not constant"); \
> +	regmap_update_bits(regmap, reg, mask, FIELD_PREP(mask, val)); \
> +})

[Severity: Low]
Missing explicit include of <linux/bitfield.h> for FIELD_PREP here too.

[ ... ]

> @@ -501,8 +497,11 @@ static int mtk_hdmi_phy_pwr5v_disable(struct regulat=
or_dev *rdev)
>  static int mtk_hdmi_phy_pwr5v_is_enabled(struct regulator_dev *rdev)
>  {
>  	struct mtk_hdmi_phy *hdmi_phy =3D rdev_get_drvdata(rdev);
> +	u32 tmp;
> +
> +	regmap_read(hdmi_phy->regs, HDMI_CTL_1, &tmp);
> =20
> -	return !!(readl(hdmi_phy->regs + HDMI_CTL_1) & RG_HDMITX_PWR5V_O);
> +	return !!(tmp & RG_HDMITX_PWR5V_O);
>  }

[Severity: Medium]
If regmap_read() fails, tmp is uninitialized. The function then evaluates t=
he
regulator enabled state based on stack garbage. Does regmap_read()'s return
value need to be checked to prevent this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011082042.3484=
22-1-l.scorcia@gmail.com?part=3D1
