Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C67CC6B08
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:00:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BDA610E514;
	Tue, 13 Oct 2026 13:00:19 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EFCE10E514
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 13:00:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6403E43AC9;
 Tue, 13 Oct 2026 13:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1DDA1F000FF;
 Tue, 13 Oct 2026 13:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791896412;
 bh=jkn00oKNilqawMytVOgJxaKIXAtfj8HSDkaiQNLRYgI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=V1xvDhsR8EK8bwdQiFPZqK3arBNNSPIfLZf1Pm4ZPVewADGjyzUVOZg8/w0x26one
 vCFX4l+ahbDdbWwe90P+fASGoLBFP8LLZw9z8/5ODH0VD1q4nf8D+sVCNSjxL6rUkx
 nlezNQj1LN0F6QBxvWjJ34JQey9B3G3q6wG8Ht0NluP8QS6HCddKtJF5SmATsc/vlm
 7HVpTU7tJ4K9rspY0VbZGr1giJgwCClcKNdhYyzgM94jsNBr6dH0nvqNK7okG4Lzrb
 HzHZ2boO8Vv08vGAoMAJRANEd+zN52mSTh27Bmsu1fW62l0mPo2O9LChUBz1DvL8XJ
 hJ/sZDBxzJ9OA==
Message-ID: <sashiko-outbox-169764@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 5/6] drm/rockchip: analogix_dp: Add support for RK3568
To: "Damon Ding" <damon.ding@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-phy@lists.infradead.org, robh@kernel.org, conor+dt@kernel.org,
 vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20261013124946.1807886-6-damon.ding@rock-chips.com>
References: <20261013124946.1807886-1-damon.ding@rock-chips.com>
 <20261013124946.1807886-6-damon.ding@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 13:00:11 +0000
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
- [High] rockchip/dp: unchecked NULL pointer dereference on missing GRF pro=
perty
--

commit 9a6e6f45c854c22f24d403cf8bdab7a0504199b6
Author: Damon Ding <damon.ding@rock-chips.com>

drm/rockchip: analogix_dp: Add support for RK3568

The RK3568 eDP controller does not require any GRF configurations,
so make the "rockchip,grf" property optional.  Also enable the
optional avdd-0v9 and avdd-1v8 supplies which power the eDP PHY.

> diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gp=
u/drm/rockchip/analogix_dp-rockchip.c
> --- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> @@ -320,8 +320,9 @@ static int rockchip_dp_of_probe(struct rockchip_dp_de=
vice *dp)
>  	struct device *dev =3D dp->dev;
>  	struct device_node *np =3D dev->of_node;
>  	struct clk *clk;
> +	int ret;
> =20
> -	dp->grf =3D syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
> +	dp->grf =3D syscon_regmap_lookup_by_phandle_optional(np, "rockchip,grf"=
);
>  	if (IS_ERR(dp->grf))
>  		return dev_err_probe(dev, PTR_ERR(dp->grf),
>  				     "failed to get rockchip,grf property\n");

[Severity: High]
Since this changes the lookup to syscon_regmap_lookup_by_phandle_optional(),
dp->grf will be NULL when the property is absent, and the IS_ERR() check wi=
ll
pass.

Can this cause a NULL pointer dereference for legacy SoCs (like RK3288, RK3=
399,
or RK3588) if the device tree is missing the property?

For those older SoCs, the chip_data specifies valid GRF fields. During disp=
lay
initialization, the driver calls rockchip_grf_field_write():

drivers/gpu/drm/rockchip/analogix_dp-rockchip.c:rockchip_grf_field_write() {
	if (!field->valid)
		return 0;

	mask =3D GENMASK(field->msb, field->lsb);
	val <<=3D field->lsb;

	return rockchip_grf_write(grf, field->reg, mask, val);
}

This forwards the potentially NULL grf pointer to rockchip_grf_write() and
eventually to regmap_write(), which dereferences it:

drivers/base/regmap/regmap.c:regmap_write() {
	...
	if (!IS_ALIGNED(reg, map->reg_stride))
		return -EINVAL;
	...
}

Should probe validate that dp->grf !=3D NULL if the chip type requires it,
rather than allowing probe to succeed and causing a kernel oops later?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013124946.1807=
886-1-damon.ding@rock-chips.com?part=3D5
