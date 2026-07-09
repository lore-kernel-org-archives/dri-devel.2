Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C19C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 10:49:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4140810EB69;
	Thu,  9 Jul 2026 10:49:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="He8elmbq";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7453B10EB69
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 10:49:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5AB2A40649;
 Thu,  9 Jul 2026 10:49:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1E51F000E9;
 Thu,  9 Jul 2026 10:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783594149;
 bh=3lQn4yaDcYHH2de0Pr/kcZvEOmh+UzT3iBXRv/BrskQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=He8elmbqlfAUmnbDBV4rtYpD3NBo9cGp5OJdx8uz0IPT0iWZk+IrxLuUYOe+GvW+u
 b+PW914pBGLza1aCAqj6jdRxXV6IGSlHr+dS7jMc2T5WDw+g0NgCcN97Y0wU4xGFF2
 YilH5huWXvBLB+YC91BKE2OKI+mosdK+pK3O448o8pCWvDFmdm1Y9ZJmzB8lQ4DfUl
 8KRwqMBDQsvEkdCL9tLtpVQx8XVyY88ra/dDhSGCPTjYBJcOgAU/I5hIk+V7sHdxvm
 KbTsxZfOcjqRGZgk6IbOykeEOlBhtqhAMLUBgWle96hS5kkZvuLUh+ncXz4Md1Ld7C
 EKxthQGosrWvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/11] drm/mediatek: mtk_dp: Add support for HotPlug
 Detection in DP AUX
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260709103431.46616-10-angelogioacchino.delregno@collabora.com>
References: <20260709103431.46616-1-angelogioacchino.delregno@collabora.com>
 <20260709103431.46616-10-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 10:49:08 +0000
Message-Id: <20260709104908.EE1E51F000E9@smtp.kernel.org>
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
- [High] Missing conditional logic when unmasking TRANS HPD interrupts lead=
s to potential interrupt storm lockup.
- [Medium] Missing register offset addition (`legacy_regoff`) in `regmap_re=
ad_poll_timeout` for `MTK_DP_AUX_P0_364C`.
--

--- Patch [9]: [PATCH v3 09/11] drm/mediatek: mtk_dp: Add support for HotPl=
ug Detection in DP AUX ---
commit 7b18e9e5242c5a51686ac5bc28f9baba9e41f72f
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

drm/mediatek: mtk_dp: Add support for HotPlug Detection in DP AUX

Newer MediaTek DisplayPort IPs can use the AUX to perform hotplug detection
(HPD) without having to power up the entire eDP or DP IP. This commit enabl=
es
support for configuring and performing HPD in AUX and checks the correct HPD
strategy with a new platform data variable.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek=
/mtk_dp.c
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
[ ... ]
> @@ -1062,8 +1086,28 @@ static u32 mtk_dp_hwirq_get_clear(struct mtk_dp *m=
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
> +
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
Does this unconditionally unmask the TRANS HPD interrupts even when
aux_hpd_supported is true?

If the TRANS hardware asserts an HPD interrupt (such as line noise),
mtk_dp_hwirq_get_clear() will completely skip reading and clearing the
TRANS HPD interrupt status because aux_hpd_supported is true.

Since the bit is never cleared, irq_status will be 0 in mtk_dp_hpd_event(),
which then returns IRQ_HANDLED:

	if (!irq_status)
		return IRQ_HANDLED;

Will returning IRQ_HANDLED defeat the kernel's spurious interrupt
detector and lead to an infinite interrupt storm lockup?

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
Is this missing the legacy_regoff addition?

The original code and the else branch both add mtk_dp->legacy_regoff
when calling regmap_read_poll_timeout().

If an SoC ever uses a non-zero legacy_regoff while supporting AUX HPD,
could this read from the wrong hardware register address?

> +	else
> +		ret =3D regmap_read_poll_timeout(mtk_dp->regs,
> +					       MTK_DP_TRANS_P0_3414 + mtk_dp->legacy_regoff,
> +					       val, !!(val & HPD_DB_DP_TRANS_P0_MASK),
> +					       wait_us / 100, wait_us);
>  	if (ret) {
>  		mtk_dp->train_info.cable_plugged_in =3D false;
>  		return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709103431.4661=
6-1-angelogioacchino.delregno@collabora.com?part=3D9
