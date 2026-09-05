Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7257C79F82
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 00:55:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA75110FB5E;
	Sat,  5 Sep 2026 00:55:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JRv/H07v";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8747510FB5E
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 00:55:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 41DC543550
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 00:55:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B0B1F00A3D;
 Sat,  5 Sep 2026 00:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788569748;
 bh=LcQhhzuuzTTAUVzIq9wbOox7RtSDwyglAiIncMiJmWI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JRv/H07vxFPsridJt0TLat+kC0wf17356VDMjTu42aDXyu5+rJxxy5pyxtnORB0/9
 eUdhdcVk0TblPx7zwa6ONfwoC01hLVGd8ScKGY56/j96hYPkwcQS/Z+Yzd7JojTz1W
 AB5i7n9Dzc3vYuaRxsZLLDkEW4ARs+S6kizMN7AAGmwLFAtVhzYv9I31NcRV7oGixB
 GJHt+dOY2hgkh1zlxxVFTQCbhZKaBPW0Zg3DV5PdUiEpYCKBqjlI9BZ4t3pMbXRRqO
 2JmEAe2/1sDxWXVg90R26Yv3+dC7J5NL+owlpF6xQyjyrCyFcEGLHcH/p80GeA+uiZ
 Sf08hcBix1UiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/19] accel: ethosu: Account for kernel dilation in
 IFM size
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260904-ethosu-fixes-v2-13-3767738756a4@kernel.org>
References: <20260904-ethosu-fixes-v2-0-3767738756a4@kernel.org>
 <20260904-ethosu-fixes-v2-13-3767738756a4@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 00:55:47 +0000
Message-Id: <20260905005548.02B0B1F00A3D@smtp.kernel.org>
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
- [Critical] The command stream validation in `feat_matrix_size` fails to c=
heck the maximum accessed address within intermediate tiles, allowing an at=
tacker to bypass bounds checks and cause the NPU to access out-of-bounds me=
mory.
--

commit eae7ad151b58329b8dda3932561e68aa3827908a
Author: Rob Herring (Arm) <robh@kernel.org>

accel: ethosu: Account for kernel dilation in IFM size

Kernel dilation increases the input feature-map area accessed by a kernel
operation. Include the x and y dilation settings when calculating the
required IFM bounds. Without this, a command stream using x2 dilation can
access IFM memory past the range validated by the driver.

> diff --git a/drivers/accel/ethosu/ethosu_device.h b/drivers/accel/ethosu/=
ethosu_device.h
> index d7e1e3c8ca12d..8e23fdbf7f8ab 100644
> --- a/drivers/accel/ethosu/ethosu_device.h
> +++ b/drivers/accel/ethosu/ethosu_device.h
[ ... ]
> diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/eth=
osu_gem.c
> index d60a2a453302b..63dd07791f314 100644
> --- a/drivers/accel/ethosu/ethosu_gem.c
> +++ b/drivers/accel/ethosu/ethosu_gem.c
[ ... ]
> @@ -536,10 +536,16 @@ static int calc_sizes(struct drm_device *ddev,
>  			((st->ifm.stride_kernel >> 1) & 0x1) + 1;
>  		u32 stride_x =3D ((st->ifm.stride_kernel >> 5) & 0x2) +
>  			(st->ifm.stride_kernel & 0x1) + 1;
> +		u32 dilation_y =3D 1 + !!(st->ifm.stride_kernel &
> +					 NPU_KERNEL_DILATION_Y);
> +		u32 dilation_x =3D 1 + !!(st->ifm.stride_kernel &
> +					 NPU_KERNEL_DILATION_X);
>  		s32 ifm_height =3D st->ofm.height[2] * stride_y +
> -			st->ifm.height[2] - (st->ifm.pad_top + st->ifm.pad_bottom);
> +			st->ifm.height[2] * dilation_y -
> +			(st->ifm.pad_top + st->ifm.pad_bottom);
>  		s32 ifm_width =3D st->ofm.width * stride_x +
> -			st->ifm.width - (st->ifm.pad_left + st->ifm.pad_right);
> +			st->ifm.width * dilation_x -
> +			(st->ifm.pad_left + st->ifm.pad_right);
> =20
>  		if (ifm_height < 0 || ifm_width < 0)
>  			return -EINVAL;

[Severity: Critical]
This isn't a regression introduced by this patch, but does the command stre=
am
validation in feat_matrix_size() fail to check the maximum accessed address
within intermediate tiles?

Looking at drivers/accel/ethosu/ethosu_gem.c in feat_matrix_size():

	if (ethosu_is_u65(edev) || storage =3D=3D 0) {
		for (int xi =3D 0; xi < 2; xi++) {
			for (int yi =3D 0; yi < 2; yi++) {
				ret =3D feat_matrix_check_location(edev, info, st, fm, type,
								 xi ? x : 0,
								 yi ? y : 0, c, ofm,
								 max_len);

The validation loop only checks the memory bounds by testing the origin
of the first tile (xi =3D 0, yi =3D 0) and the extremities of the last tile
(xi =3D 1, yi =3D 1), but skips checking the inner boundaries of
intermediate tiles.

If a user-space application constructs a command stream
defining a feature map that spans multiple tiles (e.g., storage =3D=3D 0),
could it set base[0] near the end of the valid GEM buffer and set a
large width0 for the first tile, while setting base[1] to the beginning
of the buffer?

Because the check for x =3D 0 (Tile 0) uses base[0] + 0, and the check
for x =3D x_max (Tile 1) uses base[1] + offset, both could pass
validation. However, the maximum offset within Tile 0
(base[0] + width0 * stride_x) is never verified by the logic.

Could this allow the NPU to execute the command stream and access
out-of-bounds memory up to this unchecked boundary?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-ethosu-fix=
es-v2-0-3767738756a4@kernel.org?part=3D13
