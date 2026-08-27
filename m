Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 685ECC61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 20:45:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9116F10F1B8;
	Thu, 27 Aug 2026 20:45:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T1chxEF0";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58F6210F1B8
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 20:45:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6DE7E600D4
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 20:45:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03FC81F000E9;
 Thu, 27 Aug 2026 20:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787863531;
 bh=+Yo/apEn8NQ9KW1pVAOj1OBFtet2hS5vMIZmfv6gY8g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=T1chxEF0bJNgconD15AZh1imPN/4EH8lsKZkiv+VpriRIMpgS8UeZzkOoVf6qE/Cy
 bqYpyrJ00XEfMyV45woCKdWornUKVkjUbR/RLF2qLcc+gOWFjAASWwPFiscSGj0O8g
 x8kokaUsEZIsZUmyBi/TUHGg/sQNhoLN6TCo5Z0Us9UB7U0gd6qUPPBx9A5dL+WacB
 V7IuZRj2P6s+q6esnNlk/kh4PWLOAPEwEYufL4dOcBZSB/fExyE1gBvbvnyQc15NV0
 3uFbRwi6ib5IxBu5yjwYLECxOM3JZ0I8H4mxM3pjtCgzx/q3uOOVZIyBiyXscCdyUg
 sHuGsP4uOypug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/11] accel: ethosu: Validate all feature map tiles
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260827-ethosu-fixes-v1-10-346f9ea8791c@kernel.org>
References: <20260827-ethosu-fixes-v1-0-346f9ea8791c@kernel.org>
 <20260827-ethosu-fixes-v1-10-346f9ea8791c@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 20:45:30 +0000
Message-Id: <20260827204531.03FC81F000E9@smtp.kernel.org>
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

New issues:
- [Critical] Incomplete U65 storage encoding override causes inconsistent t=
ile address calculation and broken validation.

Pre-existing issues:
- [Critical] Insufficient bounds checking of intermediate feature map tiles=
 due to evaluating start coordinates instead of maximum accessed coordinate=
s.
--

commit 6ed551b31329946a632c14e3d13b0adf33231586
Author: Rob Herring (Arm) <robh@kernel.org>

accel: ethosu: Validate all feature map tiles

This commit updates the command-stream validator to check the final=20
coordinate of every tile touched by an operation instead of just the=20
final feature-map coordinate. It also treats U65 feature maps as 2x2=20
tiled.

> diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/eth=
osu_gem.c
> index 2aafbfe95a8c2..a042e650f626a 100644
> --- a/drivers/accel/ethosu/ethosu_gem.c
> +++ b/drivers/accel/ethosu/ethosu_gem.c
[ ... ]
> @@ -259,6 +259,72 @@ static u64 feat_matrix_length(struct ethosu_device *=
edev,
>  	return addr;
>  }
> =20
> +static int feat_matrix_check_location(struct ethosu_device *edev,
[ ... ]
> +static int feat_matrix_size(struct ethosu_device *edev,
> +			    struct ethosu_validated_cmdstream_info *info,
> +			    struct feat_matrix *fm,
> +			    u32 x, u32 y, u32 c, bool ofm, u64 *max_len)
> +{
> +	u32 storage =3D ethosu_is_u65(edev) ? 0 : fm->precision >> 14;

[Severity: Critical]
Does this U65 storage encoding override create an inconsistency with how
feat_matrix_length() calculates the storage?

In feat_matrix_size(), storage is forced to 0 for U65. However, looking at
feat_matrix_length(), it still decodes storage using the precision bits:

static u64 feat_matrix_length(...)
{
        u32 element_size, storage =3D fm->precision >> 14;
        ...
}

Could a manipulated command stream use this discrepancy to pass validation =
on
one tile (using storage =3D 0) while the hardware accesses a different,
unvalidated tile base address (using storage =3D 1)?

> +	int ret;
> +
> +	*max_len =3D 0;
> +
> +	if (ethosu_is_u65(edev) || storage =3D=3D 0) {
> +		for (int xi =3D 0; xi < 2; xi++) {
> +			for (int yi =3D 0; yi < 2; yi++) {
> +				ret =3D feat_matrix_check_location(edev, info, fm,
> +								 xi ? x : 0,
> +								 yi ? y : 0, c, ofm,
> +								 max_len);

[Severity: Critical]
This is a pre-existing issue, but does this loop evaluate the absolute
coordinate 0 instead of the maximum valid coordinate for the intermediate
tile?

By checking (0, y) and (x, y), it appears we skip the maximum local
coordinate accessed in the intermediate tile (such as fm->width0). Could
this allow a command stream with an inflated stride to pass validation
here but cause the hardware to perform an out-of-bounds DMA access?

> +				if (ret)
> +					return ret;
> +			}
> +		}
> +		return 0;
> +	}
> +
> +	if (storage =3D=3D 1) {
> +		ret =3D feat_matrix_check_location(edev, info, fm, x, 0, c,
> +						 ofm, max_len);

[Severity: Critical]
This is a pre-existing issue, but similar to the 2x2 case above, is tile 0
checked at y=3D0 instead of its maximum accessed extent (fm->height[0])?

This might leave its size bounds not fully validated.

> +		if (ret)
> +			return ret;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-ethosu-fix=
es-v1-0-346f9ea8791c@kernel.org?part=3D10
