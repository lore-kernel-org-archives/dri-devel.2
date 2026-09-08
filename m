Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606EFC79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 22:14:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E27C10E542;
	Tue,  8 Sep 2026 22:14:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K68HItFx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7463A10E542
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 22:14:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 32B634363B
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 22:14:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F591F00A3A;
 Tue,  8 Sep 2026 22:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788905675;
 bh=rtX4f4F9HtSbxXKzVLk3aO6QWHwKzdynDDi1H2DhD54=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=K68HItFxAuPO5SRhd4+Ed8XhooQlxJ8IQKCJFGu7fbuc8LOwySxqYUMhFbyIV73vT
 PMutuU5yy/KzTjYbZawtdInO07RSxxp8K+UUwBhNSpy9DiELZunpYCXLjKdViRH1Nh
 4+ugWrXpJwoeviXwFSdomcnAjTIhePensG+Cw3LjTwgmpZD3ldfkvPWKj/1XSEDiZm
 tBOxfoDiLcMaqFBn1xHRVvk2j4S5EnIDJCcqX1v0XT6hnevXc1i6SUkBribgpkQwWs
 lCeyEcgWWp9BorjpQ0uwROBb/P8FDEI2tqDXILXn4hFjruvdrvLsdAMEgYAaC63FtX
 ACSvqxTKk7a1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/22] accel: ethosu: Validate all feature map tiles
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260908-ethosu-fixes-v3-13-490fe215286f@kernel.org>
References: <20260908-ethosu-fixes-v3-0-490fe215286f@kernel.org>
 <20260908-ethosu-fixes-v3-13-490fe215286f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 22:14:34 +0000
Message-Id: <20260908221434.E0F591F00A3A@smtp.kernel.org>
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
- [High] In `feat_matrix_size()`, the bounds validation for `storage =3D=3D=
 1` (NHCWB16) fails to check the maximum `y` coordinate accessed within Til=
e 0, allowing arbitrary out-of-bounds NPU memory access.
--

commit d083f33a7d240704ac9b7187779f0ac15b49cf73
Author: Rob Herring (Arm) <robh@kernel.org>

accel: ethosu: Validate all feature map tiles

The command-stream validator previously checked only the final feature-map
coordinate, which could leave earlier tile base addresses unchecked for
tiled tensors. This patch checks the final coordinate of every tile touched
by an operation and treats U65 feature maps as 2x2 tiled.

> diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/eth=
osu_gem.c
> index 5d4e897831396..11aa3f4dd0e7d 100644
> --- a/drivers/accel/ethosu/ethosu_gem.c
> +++ b/drivers/accel/ethosu/ethosu_gem.c

[ ... ]

> @@ -434,6 +434,94 @@ static u64 feat_matrix_length(struct ethosu_device *=
edev,
> +static int feat_matrix_size(struct ethosu_device *edev,
> +			    struct ethosu_validated_cmdstream_info *info,
> +			    struct cmd_state *st, struct feat_matrix *fm,
> +			    enum feat_matrix_type type,
> +			    u32 x, u32 y, u32 c, bool ofm, u64 *max_len)
> +{

[ ... ]

> +	if (storage =3D=3D 1) {
> +		ret =3D feat_matrix_check_location(edev, info, st, fm, type, x, 0, c,
> +						 ofm, max_len);
> +		if (ret)
> +			return ret;
> +		if (fm->height[0] < fm->height[1] && fm->height[1] <=3D y) {

[Severity: High]
This isn't a bug introduced by this patch, but this patch attempts to fix
tile validation and appears to still miss the maximum coordinate of Tile 0
for storage =3D=3D 1 (NHCWB16).

Does this code fail to validate the upper memory bounds of Tile 0?

When userspace submits a command stream with storage =3D=3D 1, fm->height[0=
] > 0,
and an operation maximum y > fm->height[0], the bounds validation evaluates
Tile 0 only at its base (y =3D 0). It never evaluates min(y, fm->height[0]).

Because the validator calculates the required size for Tile 0 based only on
its first row, it misses the memory offset for subsequent rows up to
fm->height[0]. By supplying an undersized GEM buffer for Tile 0, could an
unprivileged user bypass memory validation and corrupt NPU-accessible memor=
y?

> +			ret =3D feat_matrix_check_location(edev, info, st, fm, type, x,
> +							 fm->height[1], c, ofm,
> +							 max_len);
> +			if (ret)
> +				return ret;
> +		}
> +		if (fm->height[1] < y) {
> +			ret =3D feat_matrix_check_location(edev, info, st, fm, type, x,
> +							 fm->height[1] + 1, c, ofm,
> +							 max_len);
> +			if (ret)
> +				return ret;
> +		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-ethosu-fix=
es-v3-0-490fe215286f@kernel.org?part=3D13
