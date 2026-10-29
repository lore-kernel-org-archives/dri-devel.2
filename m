Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B42606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PbDpMLK4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1D79112398;
	Thu, 29 Oct 2026 15:15:05 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34F42112398
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 15:14:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CC66A40D84
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 15:14:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934091F01829;
 Thu, 29 Oct 2026 15:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793286898;
 bh=7k0CEdKnezxy9eHGh2cnL5F/iG3FG7BgkLBSQFPUmMs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PbDpMLK4t0VP4/+N1kjFUThZ7wUWSGrrRo+B+Y72V/aZQzMbF/5jd65bAmjjDAyNs
 +m7llmtTzUReQr1lAUI2azld3/dfspPkMHd2v7HWwC9xmxg0BQvD7S00RRXi8uGdk6
 Av2P4rVm/mh1ANFBdZWCTINdjmEIgJYnB3XbiLee5wdtSU5wAHVHl1O7jyGn01Xy77
 erLZhdp7OUnWseUnDNgAjBfFB6SMW5LlU5MiHCqOSMlN2EXBBZ3zPrPLzKPHstJZrN
 j5fCAGZe0mRp5grhEXLCICllGDhh/0yvqz6nUySTOdESVtU/EaKB0Jfh0rG+dV+cnZ
 nxbzau3w/O2Ug==
Message-ID: <sashiko-outbox-189591@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 28/31] accel: ethosu: Validate resize operations
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261029-ethosu-fixes-v4-28-4aa25e22578e@kernel.org>
References: <20261029-ethosu-fixes-v4-0-4aa25e22578e@kernel.org>
 <20261029-ethosu-fixes-v4-28-4aa25e22578e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 15:14:58 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] accel: ethosu: off-by-one in OFM block size for resize_axis_size()
- [High] accel: ethosu: off-by-one IFM coordinate bound in resize_axis_size=
()
--

commit 97ac650ca88e247fea2055f1c004d98774087255
Author: Rob Herring (Arm) <robh@kernel.org>

accel: ethosu: Validate resize operations

This commit adds command stream validation for Ethos-U85 NPU_OP_RESIZE
operations by tracking the resize scale, offset, step, and OFM block size
registers and validating the input feature map bounds.

> diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/eth=
osu_gem.c
> index fe6bf1a2f8cb2..0b227664afc7b 100644
> --- a/drivers/accel/ethosu/ethosu_gem.c
> +++ b/drivers/accel/ethosu/ethosu_gem.c

[ ... ]

> @@ -663,6 +675,98 @@ calc_acc_input_size(struct drm_device *ddev,
>  	return ret;
>  }
> =20
> +static int resize_axis_size(struct cmd_state *st, int axis, u16 ofm_size,
> +			    u16 ofm_blk_size, u32 *size)
> +{
> +	struct resize_axis *resize =3D &st->resize[axis];
> +	u64 one_step, blk_step, coord;
> +
> +	if (resize->offset < -(s16)resize->scale_n ||
> +	    resize->offset >=3D resize->scale_n ||
> +	    resize->one_step_mod >=3D resize->scale_n ||
> +	    resize->blk_step_mod >=3D resize->scale_n)
> +		return -EINVAL;
> +
> +	one_step =3D resize->one_step_int * resize->scale_n +
> +		resize->one_step_mod;
> +	blk_step =3D resize->blk_step_int * resize->scale_n +
> +		resize->blk_step_mod;
> +	if (check_mul_overflow((u64)ofm_blk_size, one_step, &coord) ||
> +	    blk_step !=3D coord)
> +		return -EINVAL;
> +
> +	if (check_mul_overflow((u64)ofm_size, one_step, &coord) ||
> +	    check_add_overflow(coord, (u64)resize->scale_n - 1, &coord))
> +		return -EINVAL;
> +
> +	coord =3D div_u64(coord, resize->scale_n);
> +	if (coord >=3D U32_MAX)
> +		return -EINVAL;
> +
> +	*size =3D coord + 1;
> +	return 0;
> +}
> +
> +
> +static int calc_sizes_resize(struct drm_device *ddev,
> +			     struct ethosu_validated_cmdstream_info *info,
> +			     struct cmd_state *st)
> +{
> +	struct ethosu_device *edev =3D to_ethosu_device(ddev);
> +	u32 ifm_width, ifm_height;
> +	u64 len;
> +	int ret;
> +
> +	if (!cmd_state_reg_is_set(st, NPU_SET_KERNEL_WIDTH_M1) ||
> +	    !cmd_state_reg_is_set(st, NPU_SET_KERNEL_HEIGHT_M1) ||
> +	    !cmd_state_reg_is_set(st, NPU_SET_OFM_BLK_WIDTH_M1) ||
> +	    !cmd_state_reg_is_set(st, NPU_SET_OFM_BLK_HEIGHT_M1) ||
> +	    !cmd_state_reg_is_set(st, NPU_SET_RESIZE_X_SCALE_N_M1) ||
> +	    !cmd_state_reg_is_set(st, NPU_SET_RESIZE_Y_SCALE_N_M1) ||
> +	    !cmd_state_reg_is_set(st, NPU_SET_RESIZE_X_OFFSET) ||
> +	    !cmd_state_reg_is_set(st, NPU_SET_RESIZE_Y_OFFSET) ||
> +	    !cmd_state_reg_is_set(st, NPU_SET_RESIZE_X) ||
> +	    !cmd_state_reg_is_set(st, NPU_SET_RESIZE_Y))
> +		return -EINVAL;
> +
> +	ret =3D resize_axis_size(st, 0, st->ofm.width, st->ofm_blk_width,
> +			       &ifm_width);
> +	if (ret)
> +		return ret;
> +	ret =3D resize_axis_size(st, 1, st->ofm.height[2], st->ofm_blk_height,
> +			       &ifm_height);
> +	if (ret)
> +		return ret;
> +
> +	if (check_add_overflow(ifm_width, (u32)st->ifm.width, &ifm_width) ||
> +	    check_add_overflow(ifm_height, (u32)st->ifm.height[2], &ifm_height))
> +		return -EINVAL;
> +
> +	ret =3D feat_matrix_size(edev, info, st, &st->ifm, FEAT_MATRIX_IFM,
> +			       ifm_width, ifm_height, st->ifm.depth, false, &len);

[Severity: High]
Does this overestimate ifm_width and ifm_height when passing them to
feat_matrix_size()?

In resize_axis_size(), ofm_size is already the 0-based maximum OFM coordina=
te
(st->ofm.width or st->ofm.height[2]), so coord after dividing by
resize->scale_n is a 0-based IFM coordinate. Setting *size =3D coord + 1
converts it to a 1-based size, and calc_sizes_resize() then adds st->ifm.wi=
dth
(NPU_SET_KERNEL_WIDTH_M1) and st->ifm.height[2] (NPU_SET_KERNEL_HEIGHT_M1) =
on
top of that. In addition, resize_axis_size() adds resize->scale_n - 1 rather
than accounting for resize->offset, which can increase coord by another 1 w=
hen
resize->offset < resize->scale_n - 1.

However, feat_matrix_size() -> feat_matrix_check_location() ->
feat_matrix_length() expects 0-based maximum coordinates (x, y, c), matching
how st->ofm.width, st->ofm.height[2], and st->ifm.depth are passed:

drivers/accel/ethosu/ethosu_gem.c:feat_matrix_length() {
	...
	switch (storage) {
	case 0:
		if (x >=3D fm->width0 + 1) {
			x -=3D fm->width0 + 1;
			tile +=3D 1;
		}
		if (y >=3D fm->height[tile] + 1) {
			y -=3D fm->height[tile] + 1;
			tile +=3D 2;
		}
		break;
	...
}

When ifm_width or ifm_height exceeds the actual 0-based maximum coordinate =
by
1 or 2 on a single-tile IFM (where fm->width0 and fm->height[0] are set to =
the
IFM dimensions minus 1 and only NPU_SET_IFM_BASE0 is programmed), wouldn't
feat_matrix_length() advance to tiles 1..3 and fail validation with -EINVAL,
or require a larger IFM buffer than the tensor size?

[ ... ]

> @@ -1069,6 +1178,12 @@ static int ethosu_gem_cmdstream_copy_and_validate(=
struct drm_device *ddev,
>  			}
>  			st.ofm.precision =3D param;
>  			break;
> +		case NPU_SET_OFM_BLK_WIDTH_M1:
> +			st.ofm_blk_width =3D param & 0x7f;
> +			break;
> +		case NPU_SET_OFM_BLK_HEIGHT_M1:
> +			st.ofm_blk_height =3D param & 0x7f;
> +			break;

[Severity: High]
Should st.ofm_blk_width and st.ofm_blk_height store (param & 0x7f) + 1 (or
should resize_axis_size() add 1 to ofm_blk_size)?

NPU_SET_OFM_BLK_WIDTH_M1 and NPU_SET_OFM_BLK_HEIGHT_M1 encode the block
dimensions minus 1, similar to NPU_SET_RESIZE_X_SCALE_N_M1 and
NPU_SET_RESIZE_Y_SCALE_N_M1 where param + 1 is stored.

In ethosu_gem_cmdstream_copy_and_validate() -> calc_sizes_resize() ->
resize_axis_size(), ofm_blk_size is multiplied directly by one_step:

	if (check_mul_overflow((u64)ofm_blk_size, one_step, &coord) ||
	    blk_step !=3D coord)
		return -EINVAL;

With the unadjusted _M1 value, resize_axis_size() checks that blk_step equa=
ls
(block_size - 1) * one_step instead of block_size * one_step, which rejects
valid NPU_OP_RESIZE command streams with -EINVAL whenever one_step is
non-zero.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-ethosu-fix=
es-v4-0-4aa25e22578e@kernel.org?part=3D28
