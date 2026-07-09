Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55CF8C44507
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:33:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAA0A10F505;
	Thu,  9 Jul 2026 11:32:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n4vw+tM/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37F4810F4F3
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 11:32:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E6FB54059D;
 Thu,  9 Jul 2026 11:32:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869D01F00A3D;
 Thu,  9 Jul 2026 11:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783596777;
 bh=37OD9pu/+XxsJMPggOES3ndkeWsyrJRSDvNPYC/8Fuc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=n4vw+tM/2xK/Z13/paCR/n15kc8ieBy24AFQ8GQ9f6eTTzV95/SKA8WYUI3fZRRLc
 baStSEkeLY/M6+sbOxctwj71C5MCc1rmsjr0rGQBVeqVwOPoaWJjkLBDKa3zUVIEI4
 SQ5JcjMGelEvew2O3yj1Wdla6i+jsm31SfJanDlKilnwSpgFbnHn1xfkaZK7obbJdC
 koa+JZeojW1EBK83tyrBvLdCAZ5JaDTZ+ejMan5Ai1TvNaIx85ryW7xY+7j1bw3Nmz
 /ptdXyiAx7XrXpACAzGgmJC5HjE7z5clLdSsapWr7Tte8lBX0qSz+h7c65kuskoyCO
 3Td1UR18ie1tA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/11] drm/mediatek: mtk_dp: Add support for HotPlug
 Detection in DP AUX
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org
In-Reply-To: <20260709100617.42583-10-angelogioacchino.delregno@collabora.com>
References: <20260709100617.42583-1-angelogioacchino.delregno@collabora.com>
 <20260709100617.42583-10-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 11:32:57 +0000
Message-Id: <20260709113257.869D01F00A3D@smtp.kernel.org>
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
- [High] Unconditionally unmasking legacy DP_TRANS HPD interrupts while fai=
ling to clear them when `aux_hpd_supported` is true causes an unhandled IRQ=
 storm.
- [Medium] Missing `mtk_dp->legacy_regoff` offset when polling the `MTK_DP_=
AUX_P0_364C` register via `regmap_read_poll_timeout()`.
--

--- Patch [9]: [PATCH v2 09/11] drm/mediatek: mtk_dp: Add support for HotPl=
ug Detection in DP AUX ---
commit 804af7d08e6512ddf93b2634e3ded89904e4b43b
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: drm/mediatek: mtk_dp: Add support for HotPlug Detection in DP AUX

Newer MediaTek DisplayPort IPs can finally use the AUX to perform hotplug
detection without having to power up the entire eDP or DP IP. This commit
enables support for configuring and performing HPD in AUX, checking the
correct HPD strategy with a new platform data variable.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek=
/mtk_dp.c
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c

[ ... ]

> @@ -1086,8 +1086,28 @@ static u32 mtk_dp_hwirq_get_clear(struct mtk_dp *m=
tk_dp)
>  	return irq_status;
>  }
> =20
> +static inline u32 mtk_dp_hwirq_get_clear(struct mtk_dp *mtk_dp)
> +{
> +	if (mtk_dp->data->aux_hpd_supported)
> +		return mtk_dp_aux_hwirq_get_clear(mtk_dp);
> +
> +	return mtk_dp_trans_hwirq_get_clear(mtk_dp);
> +}

[Severity: High]
If aux_hpd_supported is true, this function only clears the AUX interrupts.
Could the unmasked DP_TRANS interrupts trigger an interrupt storm since they
are never cleared here?

>  static void mtk_dp_hwirq_enable(struct mtk_dp *mtk_dp, bool enable)
>  {
> +	u32 mask, val;
> +
> +	/* Valid only for SoCs with working AUX HPD, this register is ignored o=
n the others */
> +	if (enable) {
> +		mask =3D HPD_CONNECT_EVENT | HPD_INTERRUPT_EVENT | HPD_DISCONNECT_EVEN=
T;
> +		val =3D 0;
> +	} else {
> +		mask =3D DP_TX_AUX_INT_MASK;
> +		val =3D DP_TX_AUX_INT_MASK;
> +	}
> +	mtk_dp_update_bits(mtk_dp, MTK_DP_TX_AUX_INT_MASKING, val, mask);
> +
>  	mtk_dp_update_bits(mtk_dp, MTK_DP_TRANS_P0_3418,
>  			   enable ? 0 :
>  			   IRQ_MASK_DP_TRANS_P0_DISC_IRQ |
>  			   IRQ_MASK_DP_TRANS_P0_CONN_IRQ |
>  			   IRQ_MASK_DP_TRANS_P0_INT_IRQ,
>  			   IRQ_MASK_DP_TRANS_P0_MASK);
>  }

[Severity: High]
Is it intended to unconditionally unmask the legacy DP_TRANS HPD interrupts
here, even when aux_hpd_supported is true?

If a DP_TRANS interrupt fires when aux_hpd_supported is true,
mtk_dp_hwirq_get_clear() will skip clearing it, which might lead to an
unhandled irq loop.

[ ... ]

> @@ -2113,10 +2191,15 @@ static int mtk_dp_wait_hpd_asserted(struct drm_dp=
_aux *mtk_aux, unsigned long wa
>  	u32 val;
>  	int ret;
> =20
> -	ret =3D regmap_read_poll_timeout(mtk_dp->regs,
> -				       MTK_DP_TRANS_P0_3414 + mtk_dp->legacy_regoff,
> -				       val, !!(val & HPD_DB_DP_TRANS_P0_MASK),
> -				       wait_us / 100, wait_us);
> +	if (mtk_dp->data->aux_hpd_supported)
> +		ret =3D regmap_read_poll_timeout(mtk_dp->regs, MTK_DP_AUX_P0_364C,
> +					       val, !!(val & HPD_STATUS_DP_AUX_TX_P0_MASK),
> +					       wait_us / 100, wait_us);

[Severity: Medium]
Does this regmap_read_poll_timeout() call need to include the
mtk_dp->legacy_regoff offset for the MTK_DP_AUX_P0_364C register?

Other register accesses seem to consistently add this offset. Missing it
here might lead to polling the wrong physical memory address and timing out
if legacy_regoff happens to be non-zero on the hardware.

> +	else
> +		ret =3D regmap_read_poll_timeout(mtk_dp->regs,
> +					       MTK_DP_TRANS_P0_3414 + mtk_dp->legacy_regoff,
> +					       val, !!(val & HPD_DB_DP_TRANS_P0_MASK),
> +					       wait_us / 100, wait_us);
>  	if (ret) {
>  		mtk_dp->train_info.cable_plugged_in =3D false;
>  		return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709100617.4258=
3-1-angelogioacchino.delregno@collabora.com?part=3D9
