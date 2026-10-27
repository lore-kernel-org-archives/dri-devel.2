Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BBE606A31D
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 12:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=koLzP5bK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D812310E3FB;
	Tue, 27 Oct 2026 12:10:57 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22F1210F432
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 12:10:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BE5AC406F3;
 Tue, 27 Oct 2026 12:10:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1541F01825;
 Tue, 27 Oct 2026 12:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793103051;
 bh=4S/cP/vbtzznFFxgpptGATWYxKUSjxY/EhHopNokUmc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=koLzP5bKhzKjD/4oT47YxDq3ck1GiAAcuolbRsYAxdBvjn4Bn0HLQA6SqG3EI4hCi
 mybHorvkda6HptixCqKaHfwfm7WHfMr35UEVZQT+FKQGrit5uIquTByM8IL/oSKT17
 iYD2jZecLZhTjOQsD71chRRVMf6AVm/12E4NhlpdnP2QMVGOPm9RzyQgJtfWVgv+hh
 32f3WQUBkxj/KniwPVhcBKd8IGEDb1RPXsqFIpEKrLlddN+0j70zf2yyreVeg7Y2Xi
 ruJi4CorNonOkCv2966p1XRRVueeXa+alQ6aq66qeCqcAS6IJXSNbupYB2Vq6tqjFQ
 z/TXgkSzLt7wQ==
Message-ID: <sashiko-outbox-186515@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] drm/bridge: analogix_dp: deassert DP_PHY_PD on
 power-on for exynos
To: "Alexandre Marquet" <tb@a-marquet.fr>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261027-drm-misc-next-manta-auxbus-v1-1-3a45c3cf531d@a-marquet.fr>
References: <20261027-drm-misc-next-manta-auxbus-v1-0-3a45c3cf531d@a-marquet.fr>
 <20261027-drm-misc-next-manta-auxbus-v1-1-3a45c3cf531d@a-marquet.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 12:10:51 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/bridge: analogix_dp_set_analog_power_down() breaks ANALOG_TO=
TAL
--

commit 91a05dce5d444dd4add713f60a3388d24c0834b4
Author: Alexandre Marquet <tb@a-marquet.fr>

drm/bridge: analogix_dp: deassert DP_PHY_PD on power-on for exynos

This commit modifies analogix_dp_set_analog_power_down() on Exynos platforms
to deassert DP_PHY_PD and assert individual block power-down bits before
powering on requested analog blocks.

> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/=
gpu/drm/bridge/analogix/analogix_dp_reg.c
> index c1344a3f013ab..9f634d4e47933 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> @@ -256,6 +256,19 @@ void analogix_dp_set_analog_power_down(struct analog=
ix_dp_device *dp,
>  	if (dp->plat_data && analogix_dp_is_rockchip(dp->plat_data->dev_type))
>  		phy_pd_addr =3D ANALOGIX_DP_PD;
> =20
> +	reg =3D readl(dp->reg_base + phy_pd_addr);
> +
> +	if (dp->plat_data && (dp->plat_data->dev_type =3D=3D EXYNOS_DP)) {
> +		/* On exynos, register AUX_PD and CH[0-3]_PD have no effect if
> +		 * DP_PHY_PD is asserted. So, when powering any of them up, we
> +		 * need to deassert DP_PHY_PD first.
> +		 */
> +		if (!enable && (reg & DP_PHY_PD)) {
> +			reg &=3D ~DP_PHY_PD;
> +			reg |=3D AUX_PD | CH0_PD | CH1_PD | CH2_PD | CH3_PD;
> +		}
> +	}

[Severity: Medium]
What happens when analogix_dp_set_analog_power_down() is called on EXYNOS_DP
with block set to ANALOG_TOTAL and enable set to false while DP_PHY_PD is
asserted in ANALOGIX_DP_PHY_PD?

Because this check runs before switch (block) for all block values, it clea=
rs
DP_PHY_PD and sets AUX_PD | CH0_PD | CH1_PD | CH2_PD | CH3_PD in reg. When
execution then reaches the ANALOG_TOTAL case:

drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c:analogix_dp_set_analog_po=
wer_down() {
	...
	case ANALOG_TOTAL:
		if (dp->plat_data && analogix_dp_is_rockchip(dp->plat_data->dev_type))
			mask =3D DP_INC_BG;
		else
			mask =3D DP_PHY_PD;

		if (enable)
			reg |=3D mask;
		else
			reg &=3D ~mask;

		writel(reg, dp->reg_base + phy_pd_addr);
	...
}

reg &=3D ~DP_PHY_PD leaves AUX_PD and CH0_PD through CH3_PD set, so writel()
powers down AUX and all four channels instead of powering on everything as
described in the commit message.

Should the ANALOG_TOTAL case also clear AUX_PD | CH0_PD | CH1_PD | CH2_PD |
CH3_PD when enable is false, or should the pre-switch check exclude
ANALOG_TOTAL and POWER_ALL?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-drm-misc-n=
ext-manta-auxbus-v1-0-3a45c3cf531d@a-marquet.fr?part=3D1
