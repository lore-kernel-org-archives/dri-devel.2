Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780A4C79F82
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 00:53:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9C7E10FB54;
	Sat,  5 Sep 2026 00:53:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z708g2hS";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF47E10FB54
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 00:53:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B814243F07
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 00:53:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C961F00A3E;
 Sat,  5 Sep 2026 00:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788569621;
 bh=WDabL4ve/miYlt6147Jch4bAqzJs4s2w0FqKBJOwPPg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Z708g2hS+P6eday5ax130I4pKW9eyHLbHQZetbE6tSOwnjpRB9DgQiDj1woc529Pg
 pbkqUJL05Dg5fSubobRy3gzb1v3x6qL39X0qPkVAu4ASLqsbqxuiAom/RmvyYSg9mr
 R0e6GFP/IMa7hlYKtU97P/18W15F6IpUQZ8Dw9HQ4V2mdvVFmP+Oq7gZ96uio/QZVl
 UKpHxEOCQtBtfkZpUN5GV/rDwRlaROcKpvaDvD95xJWYpQ7RvO+xPGKHHVn+Frn3ju
 TFq+9SLHAJkkipjvRAyh5Qx4XFo+lXhsvjGXKtxmQJJSwiSnS+yHTfPOb8rJSeRhkv
 educ+ZgyDa32A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/19] accel: ethosu: Validate all feature map tiles
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260904-ethosu-fixes-v2-10-3767738756a4@kernel.org>
References: <20260904-ethosu-fixes-v2-0-3767738756a4@kernel.org>
 <20260904-ethosu-fixes-v2-10-3767738756a4@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 00:53:40 +0000
Message-Id: <20260905005341.60C961F00A3E@smtp.kernel.org>
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
- [Critical] Incomplete bounds validation for multi-tile feature maps allow=
s NPU out-of-bounds memory access (stride overflow).
--

commit ed82a852cb38061cea72ccfbb8b9844fe471cc0f
Author: Rob Herring (Arm) <robh@kernel.org>

accel: ethosu: Validate all feature map tiles

The commit modifies the command-stream validator to check the final
coordinate of every tile touched by an operation, rather than just the
final feature-map coordinate. It also updates the treatment of U65 feature
maps to be checked as 2x2 tiled.

> diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/eth=
osu_gem.c
> index c913c95e48ae0..c54496fa08f4c 100644
> --- a/drivers/accel/ethosu/ethosu_gem.c
> +++ b/drivers/accel/ethosu/ethosu_gem.c
[ ... ]
> @@ -423,6 +423,74 @@ static u64 feat_matrix_length(struct ethosu_device *=
edev,
[ ... ]
> +static int feat_matrix_size(struct ethosu_device *edev,
> +			    struct ethosu_validated_cmdstream_info *info,
> +			    struct cmd_state *st, struct feat_matrix *fm,
> +			    enum feat_matrix_type type,
> +			    u32 x, u32 y, u32 c, bool ofm, u64 *max_len)
> +{
> +	u32 storage =3D ethosu_is_u65(edev) ? 0 : fm->precision >> 14;
> +	int ret;
> +
> +	*max_len =3D 0;
> +
> +	if (ethosu_is_u65(edev) || storage =3D=3D 0) {
> +		for (int xi =3D 0; xi < 2; xi++) {
> +			for (int yi =3D 0; yi < 2; yi++) {
> +				ret =3D feat_matrix_check_location(edev, info, st, fm, type,
> +								 xi ? x : 0,
> +								 yi ? y : 0, c, ofm,
> +								 max_len);

[Severity: Critical]
This isn't a bug introduced by this patch, but it appears the validation
logic might still be incomplete for intermediate tiles. In feat_matrix_size=
(),
when checking storage =3D=3D 0, the loop evaluates to 0 (the relative minim=
um
coordinate) for intermediate tiles rather than checking the tile's maximum
extent.=20

Because feat_matrix_length() calculates offset by multiplying strides by the
passed coordinates, passing 0 skips validating the maximum memory offset
for tile 0 (which should be evaluated at fm->width0 and fm->height[0]).
Could an ioctl command stream from unprivileged userspace, carrying a valid
base address but artificially large strides, bypass bounds checking here and
cause the NPU to access out-of-bounds memory?

> +				if (ret)
> +					return ret;
> +			}
> +		}
> +		return 0;
> +	}
> +
> +	if (storage =3D=3D 1) {
> +		ret =3D feat_matrix_check_location(edev, info, st, fm, type, x, 0, c,
> +						 ofm, max_len);
> +		if (ret)
> +			return ret;
> +		if (fm->height[0] < fm->height[1] && fm->height[1] <=3D y) {
> +			ret =3D feat_matrix_check_location(edev, info, st, fm, type, x,
> +							 fm->height[1], c, ofm,
> +							 max_len);

[Severity: Critical]
This is also a pre-existing issue, but similar to the loop above, does this
storage =3D=3D 1 logic skip validating the maximum memory bound of tile 0?

The code explicitly checks the boundaries at y =3D 0 and y =3D fm->height[1=
], but
it seems to skip verifying the maximum extent of tile 0 at y =3D fm->height=
[0].
Would this allow unprivileged userspace to trigger out-of-bounds accesses
during intermediate tile processing if the vertical stride is maliciously
large?

> +			if (ret)
> +				return ret;
> +		}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-ethosu-fix=
es-v2-0-3767738756a4@kernel.org?part=3D10
