Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA5FC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:57:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2308C10F564;
	Thu,  9 Jul 2026 11:57:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TB66LA6p";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2392E10F564
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 11:57:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6DED26001A;
 Thu,  9 Jul 2026 11:57:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0B41F000E9;
 Thu,  9 Jul 2026 11:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783598270;
 bh=PrTr6K7jLLOXXMUw055BXdN17Hg4A6u5frOLy54M2hg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TB66LA6pIOkWtgCrCEaIEG9ejS64/jxgTXMp05+VGtnHlz5LlTMgUYFv+7RrNCYS6
 Ff5FXRv/xoQh01cdj0i2+2tu1QQdXvIfR5jc6eF1lYhUNd6VOJgqgu/1f4KorBhgBg
 Cgz7BpUI/QBDyiDBo3xFlcctthyKp4NHAOqx/9P2Cwcu8uNi9Nl1GvVPL55orflgLo
 gpfdoDrFmB2S1CbDHQN4nvUFZZQ+n9wJoa9al461tgz6UeFZ5ZxxWBuFEztLWPpdpw
 2VhGXXgB4/j3HlG9PMdlGOAFlpX4l+4v90ibwtv8N4ah2B3fz0utMrIPPMQWn0ReG9
 HJTBqPVeKrYzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/12] drm/mediatek: mtk_dp: Clarify XTAL freq and
 Debounce registers
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260709113148.49090-13-angelogioacchino.delregno@collabora.com>
References: <20260709113148.49090-1-angelogioacchino.delregno@collabora.com>
 <20260709113148.49090-13-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 11:57:49 +0000
Message-Id: <20260709115749.CA0B41F000E9@smtp.kernel.org>
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
- [Medium] The patch silently fixes a pre-existing double-shift bug that wa=
s incorrectly writing 0 to the HPD interrupt debounce thresholds. This alte=
rs the hardware state, contradicting the commit message's claim that its 'o=
nly purpose [is] increasing human readability'.
--

--- Patch [12]: [PATCH v4 12/12] drm/mediatek: mtk_dp: Clarify XTAL freq an=
d Debounce registers ---
commit 947b13de5fec9b2788067fcdae3f6c00732e0060
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

drm/mediatek: mtk_dp: Clarify XTAL freq and Debounce registers

This patch clarifies the meaning of the sub-fields in the crystal frequency
and transmitter interrupt debounce registers for increased human readabilit=
y.

> Clarify the meaning of the sub-fields in the crystal frequency and
> transmitter interrupt debounce registers, with the only purpose of
> increasing human readability.

[ ... ]

> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
> @@ -1260,28 +1266,29 @@ static void mtk_dp_initialize_aux_hpd_detect_sett=
ings(struct mtk_dp *mtk_dp)
> =20
>  static void mtk_dp_initialize_hpd_detect_settings(struct mtk_dp *mtk_dp)
>  {
> -	u32 val;
> -
>  	/* Mask AUX TOP interrupt, as this uses transmitter for HPD */
>  	mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_IRQ_MASK,
>  			   AUX_TOP_IRQ_MSK, AUX_TOP_IRQ_MSK);
> =20
> -	/* Debounce threshold */
> +	/* Set Hotplug debounce threshold time: xtal_period * deb_thd */
>  	mtk_dp_update_bits(mtk_dp, MTK_DP_TRANS_P0_3410,
>  			   8, HPD_DEB_THD_DP_TRANS_P0_MASK);
> =20
> -	val =3D (HPD_INT_THD_DP_TRANS_P0_LOWER_500US |
> -	       HPD_INT_THD_DP_TRANS_P0_UPPER_1100US) << 4;
> -	mtk_dp_update_bits(mtk_dp, MTK_DP_TRANS_P0_3410,
> -			   val, HPD_INT_THD_DP_TRANS_P0_MASK);
> -
>  	/*
> -	 * Connect threshold 1.5ms + 5 x 0.1ms =3D 2ms
> -	 * Disconnect threshold 1.5ms + 5 x 0.1ms =3D 2ms
> +	 * Set interrupt debounce threshold time
> +	 * VAL  |  0     1     2     3  INT_THD
> +	 * Low  | 100   300   500   700 uS
> +	 * High | 700   900  1100  1300 uS
>  	 */
> -	val =3D (5 << 8) | (5 << 12);
>  	mtk_dp_update_bits(mtk_dp, MTK_DP_TRANS_P0_3410,
> -			   val,
> +			   FIELD_PREP_CONST(HPD_INT_LOW_THD_DP_TRANS_P0_MASK, 2) |
> +			   FIELD_PREP_CONST(HPD_INT_HIGH_THD_DP_TRANS_P0_MASK, 2),
> +			   HPD_INT_THD_DP_TRANS_P0_MASK);

[Severity: Medium]
Does this patch silently fix a functional bug rather than just improving
readability?

In the original code, the LOWER_500US and UPPER_1100US macros were already
shifted by 4 and 6 respectively. Applying << 4 on top of them resulted in a
double shift, making val equal to 0xA00. When that was masked with
HPD_INT_THD_DP_TRANS_P0_MASK (which is 0xF0), it evaluated to 0, incorrectly
programming the hardware.

The new code using FIELD_PREP_CONST calculates 0xA0, correctly applying the
intended 500/1100uS thresholds.

Since the commit message states this has the only purpose of increasing hum=
an
readability, could this functional fix be overlooked for stable backports?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709113148.4909=
0-1-angelogioacchino.delregno@collabora.com?part=3D12
