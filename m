Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB23C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 22:20:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E17110EDD5;
	Tue,  8 Sep 2026 22:20:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Srqt5fhZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0715410EDD5
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 22:20:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E4C21404CD
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 22:20:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9DA1F00A3A;
 Tue,  8 Sep 2026 22:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788906041;
 bh=orIkwD9KOsvMTVGqy55UqkiKbTTYqfGfvlgiGuzzD80=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Srqt5fhZnFaYO5LAeaQXx/cPLrmjJgmXIHVtBF8hZ4+djnJ7YvpKVFUegaxqbc3Ov
 icrxjoCQL/M4KrsL09l7wIWAzBdsXRx+Etetw/9TOpR5LYJUKLYdIDqwQTq5xFOTJk
 Xj8+U/IfK3yroWWKpgsktl3aRoDXU2dYE2JE07TuwTkIEWoiQuD0CpPx4JBaNtTUxi
 MOOUpC4wf+dHd9I6k8/4jCJYafrEG44UFnyxTUPui5psWggYogDJZQR5/aDjtj357N
 psP6enhxE0Cvcmd+3QirlqfMOLNGt9bTRr2aqbz2mTXxw8QF6clKuBuGxOM70takxR
 Tsd/qHQ3Q4mGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 14/22] accel: ethosu: Account for feature map element
 size
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260908-ethosu-fixes-v3-14-490fe215286f@kernel.org>
References: <20260908-ethosu-fixes-v3-0-490fe215286f@kernel.org>
 <20260908-ethosu-fixes-v3-14-490fe215286f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 22:20:41 +0000
Message-Id: <20260908222041.9E9DA1F00A3A@smtp.kernel.org>
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
- [Critical] Missing max coordinate check for tile 0 in feat_matrix_size wh=
en storage =3D=3D 1 allows out-of-bounds NPU memory accesses.
--

commit 8f5e0f4e084740b6432179e0d2b5e40f78355e1e
Author: Rob Herring (Arm) <robh@kernel.org>

accel: ethosu: Account for feature map element size

The feature map bounds calculation currently accounts for only one byte
of the final element. This can leave the tail of B16, B32, and B64
elements outside the validated buffer.

Use the feature map element size when calculating the final byte.

> diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/eth=
osu_gem.c
> index 11aa3f4dd0e7d..974cf562ef495 100644
> --- a/drivers/accel/ethosu/ethosu_gem.c
> +++ b/drivers/accel/ethosu/ethosu_gem.c
> @@ -426,7 +426,7 @@ static u64 feat_matrix_length(struct ethosu_device *e=
dev,
>  		return U64_MAX;
>  	}
> =20
> -	if (check_add_overflow(addr, 1ULL, &offset))
> +	if (check_add_overflow(addr, (u64)element_size, &offset))
>  		return U64_MAX;
> =20
>  	info->region_size[fm->region] =3D max(info->region_size[fm->region], of=
fset);

[Severity: Critical]
This is a pre-existing issue, but while we are looking at feature map
bounds calculations, I noticed a potential out-of-bounds regression in
feat_matrix_size() introduced earlier in the series.

When storage =3D=3D 1 (plan 1 vertical tiling) and the operation spans into
tile 1 or tile 2 (where y > fm->height[0]), the validation only checks y=3D0
for tile 0:

drivers/accel/ethosu/ethosu_gem.c:feat_matrix_size() {
...
	if (storage =3D=3D 1) {
		ret =3D feat_matrix_check_location(edev, info, st, fm, type, x, 0, c,
						 ofm, max_len);
...
	}
...

Since base[0] and base[1] are independently programmed by the user-space
command stream, base[0] + fm->height[0] * stride_y can be the true global
maximum address of the feature map.

Because the check omits the maximum boundary of tile 0 (which would be
min(y, fm->height[0])), could this severely underestimate the required
buffer size and allow unprivileged NPU command streams to access memory
outside the validated GEM buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-ethosu-fix=
es-v3-0-490fe215286f@kernel.org?part=3D14
