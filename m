Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C346606A320
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 23:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=az2NXJWG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 681FF10ECDB;
	Wed, 18 Nov 2026 23:45:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27C3210E54D
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 23:45:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D22F14778F;
 Wed, 18 Nov 2026 23:45:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBBC1F000C4;
 Wed, 18 Nov 2026 23:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795045511;
 bh=AFmS+ExA3O9uGeWxOl8tI0+E9O/D93sFEmv0hrbJZAI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=az2NXJWG03j0gYrCTZN9VXqQu2oL+wYWQKJ5JihHXlPRmuES2bhWGpze2w0HquvXg
 h774lSN5z7U6V4U8DPgZVTqZzytjHF8QD1HIxg4LnHS3Zp6sdfeu3jmpPq0ev2eMeq
 AFMuMkqndFK2qj/q+VPHIsBJjP4Ff9C+VNlzRlgiCwjR7+A3h1Zs7qxzrInRLuzzLs
 vqVHFblRCllOzDG7e88w02Jc3nIPbtUCkDp0MQT5x5oUBneG2IVOBvdtqAMVOAsAnY
 jzBSY0dUqSUS4p0kxI0CGQ06t/md1Z4+CEinmjwbYAgDZ4ZhG/OjPLLo890iC3G36J
 OND+PmBxC1PQw==
Message-ID: <sashiko-outbox-222208@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/15] accel/amd-ai-engine: Add support to
 enable/disable tile clocks
To: "Gregory Williams" <gregory.williams@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261118233211.4121361-15-gregory.williams@amd.com>
References: <20261118233211.4121361-1-gregory.williams@amd.com>
 <20261118233211.4121361-15-gregory.williams@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 23:45:11 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] accel/amd-ai-engine: aiemlv2_set_part_clocks() clobbers
  tiles_inuse bitmap
- [Low] accel/amd-ai-engine: % 2 discards mask bit 1 in
  aiemlv2_scan_part_clocks()
--

commit 31b6ed2773ef86bbc6d6e5049ee938eccc623dd5
Author: Gregory Williams <gregory.williams@amd.com>

accel/amd-ai-engine: Add support to enable/disable tile clocks

This commit adds partition clock scanning and tile clock enable/disable
operations for requesting and releasing AI Engine tiles.

> diff --git a/drivers/accel/amd-ai-engine/ai-engine-aiemlv2.c b/drivers/ac=
cel/amd-ai-engine/ai-engine-aiemlv2.c
> index 0c9c7ccdd54e0..26dd1d726bfad 100644
> --- a/drivers/accel/amd-ai-engine/ai-engine-aiemlv2.c
> +++ b/drivers/accel/amd-ai-engine/ai-engine-aiemlv2.c
> @@ -13,6 +13,16 @@
>  #define AIEMLV2_COL_SHIFT		25U
>  #define AIEMLV2_ROW_SHIFT		20U
> =20
> +/*
> + * Register offsets
> + */
> +#define AIEMLV2_SHIMPL_COLCLOCK_CTRL_REGOFF		0x0007FF20U
> +
> +/*
> + * Register masks
> + */
> +#define AIEMLV2_SHIMPL_COLCLOCK_CTRL_MASK		GENMASK(1, 0)
> +
>  static u32 aiemlv2_get_tile_type(struct aie_device *adev, struct aie_loc=
ation *loc)
>  {
>  	u8 num_mem_rows =3D adev->ttype_attr[AIE_TILE_TYPE_MEMORY].num_rows;
> @@ -25,8 +35,148 @@ static u32 aiemlv2_get_tile_type(struct aie_device *a=
dev, struct aie_location *l
>  	return AIE_TILE_TYPE_SHIMNOC;
>  }
> =20
> +static int aiemlv2_scan_part_clocks(struct aie_partition *apart)
> +{
> +	struct aie_range *range =3D &apart->range;
> +	struct aie_device *adev =3D apart->adev;
> +	struct aie_location loc;
> +
> +	/* Clear the bitmap of cores and memories clock state */
> +	aie_resource_put_region(&apart->cores_clk_state, 0,
> +				apart->cores_clk_state.total);
> +
> +	/*
> +	 * If the clock buffer on shim tile is enabled, then all tiles above in
> +	 * the same column are also enabled.
> +	 */
> +
> +	loc.row =3D 0;
> +	for (loc.col =3D range->start.col;
> +	     loc.col < range->start.col + range->size.col;
> +	     loc.col++) {
> +		void __iomem *va;
> +		u32 val, nbitpos;
> +
> +		nbitpos =3D (loc.col - range->start.col) * (range->size.row - 1) + loc=
.row;
> +
> +		va =3D adev->base +
> +		     aie_cal_regoff(adev, loc,
> +				    AIEMLV2_SHIMPL_COLCLOCK_CTRL_REGOFF);
> +		val =3D readl(va);
> +
> +		if (!((val & AIEMLV2_SHIMPL_COLCLOCK_CTRL_MASK) % 2))
> +			continue;

[Severity: Low]
Does applying "% 2" after masking with AIEMLV2_SHIMPL_COLCLOCK_CTRL_MASK
(GENMASK(1, 0)) unintentionally discard bit 1?  Since (val & 0x3) % 2 only
tests bit 0, a column with bit 1 set and bit 0 clear will be treated as
clocked off during aie_part_create() -> aie_part_scan_clk_state().

> +
> +		aie_resource_set(&apart->cores_clk_state, nbitpos,
> +				 range->size.row - 1);
> +	}
> +	/*
> +	 * Set the tiles in use bitmap.
> +	 * In case of scanning, tiles which are powered on are considered as
> +	 * tiles in use.
> +	 */
> +	bitmap_copy(apart->tiles_inuse.bitmap, apart->cores_clk_state.bitmap,
> +		    apart->tiles_inuse.total);
> +
> +	return 0;
> +}
> +
> +static int aiemlv2_set_part_clocks(struct aie_partition *apart)
> +{
> +	struct aie_range *range =3D &apart->range;
> +	struct aie_range prev_range =3D {};
> +	struct aie_location loc;
> +	int ret =3D -EINVAL;
> +	u32 prev_ops =3D 0;
> +
> +	for (loc.col =3D 0; loc.col < range->size.col; loc.col++) {
> +		u32 startbit, col_inuse =3D 0;
> +
> +		startbit =3D loc.col * (range->size.row - 1);
> +
> +		for (loc.row =3D range->start.row + 1;
> +		     loc.row < range->start.row + range->size.row;
> +		     loc.row++) {
> +			u32 nbitpos =3D startbit + loc.row - 1;
> +
> +			if (aie_resource_testbit(&apart->tiles_inuse, nbitpos)) {
> +				col_inuse =3D 1;
> +				break;
> +			}
> +		}
> +
> +		if (col_inuse) {
> +			struct aie_range op_range =3D {
> +				.start.col =3D loc.col + range->start.col,
> +				.size.col =3D 1,
> +			};
> +
> +			ret =3D aie_resource_set(&apart->tiles_inuse, startbit,
> +					       apart->range.size.row - 1);
> +			if (ret)
> +				return ret;
> +			ret =3D aie_resource_set(&apart->cores_clk_state, startbit,
> +					       apart->range.size.row - 1);

[Severity: Medium]
Should aiemlv2_set_part_clocks() avoid setting the entire column in
apart->tiles_inuse when col_inuse is true?

When aie_part_request_tiles() requests a subset of tiles in a column, it
sets only those tile bits in apart->tiles_inuse, but this call marks every
row in the column as in use.  If the caller later releases the requested
tiles via aie_part_release_tiles(), only the specified tile bits are
cleared in apart->tiles_inuse, so aiemlv2_set_part_clocks() sees the remain=
ing
row bits still set, re-sets the released bits in apart->tiles_inuse, and
never disables the column clock buffer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118233211.4121=
361-1-gregory.williams@amd.com?part=3D14
