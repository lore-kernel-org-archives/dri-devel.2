Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA3FC79FA1
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 22:24:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A808010EDDB;
	Tue,  8 Sep 2026 22:24:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hmjEx8np";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16E4510EDDB
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 22:24:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DAEB64050A
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 22:24:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932901F00A3A;
 Tue,  8 Sep 2026 22:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788906254;
 bh=B0GxYvtQ4dvVWnc/d9uVragq62PMfXup+VvypRR7PtY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hmjEx8npCm1HYMkkBsWe4r7c6kYtaVW1u1mD/m9/dgrfgAiTHEOEHyRj6BcrDfQIf
 D7hlngjkIGIJbaWDPfieMTRTFLNBLrnEBDe3g4Pr7sICccH3N+dhHhrNkMGT0eW/kx
 nzAtPa85/ymHjBSRKMh7VYl/V7Wnvg8Cbo699yYOAEqj1DH/4U37bZJJCmOz1+aDRh
 UXuTMzTXfr3HJTEBmWMMnF5EgtuTxK/FF8gT+r/FaDe6C0xL4UxUtYI/4zDcZcdrHt
 aJlqrdQILjDM5/tNJb2N+b85UbC1tRsAaYrN4ltu7rMudapI81K6BxTduCd6xh5jbH
 cZNCjq3AFWo9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 19/22] accel: ethosu: Restrict dynamic IFM2 weights
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260908-ethosu-fixes-v3-19-490fe215286f@kernel.org>
References: <20260908-ethosu-fixes-v3-0-490fe215286f@kernel.org>
 <20260908-ethosu-fixes-v3-19-490fe215286f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 22:24:14 +0000
Message-Id: <20260908222414.932901F00A3A@smtp.kernel.org>
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
- [Critical] Missing bounds validation for Tile 0's maximum Y extent when c=
hecking NHCWB16 (storage =3D=3D 1) feature matrices.
--

commit 55c57d446ca04d4d5fc6125acd2d154b7839c8a4
Author: Rob Herring (Arm) <robh@kernel.org>

accel: ethosu: Restrict dynamic IFM2 weights

This commit adds validation to reject dynamic-weight convolutions where the
kernel is not 1x1. This prevents a crafted kernel from causing the NPU to
access memory beyond the validated IFM2 feature map.

Cc: stable@vger.kernel.org

> diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/eth=
osu_gem.c
> index 632a2352491a0..df26ccd50a96a 100644
> --- a/drivers/accel/ethosu/ethosu_gem.c
> +++ b/drivers/accel/ethosu/ethosu_gem.c

[ ... ]

While reviewing the memory accesses in this file, I noticed a pre-existing
issue in feat_matrix_size():

drivers/accel/ethosu/ethosu_gem.c:feat_matrix_size() {
...
        if (storage =3D=3D 1) {
                ret =3D feat_matrix_check_location(edev, info, st, fm, type=
, x, 0, c,
                                                 ofm, max_len);
                if (ret)
                        return ret;
...
}

[Severity: Critical]
This is a pre-existing issue, but does this NHCWB16 format (storage =3D=3D =
1)
validation correctly check the maximum Y coordinate accessed in Tile 0?

For storage =3D=3D 0, the code correctly checks min(y, fm->height[0]). Howe=
ver,
for storage =3D=3D 1, it only probes Tile 0 at y =3D 0.

If a userspace application submits a command stream where the overall
operation height y > fm->height[0] and fm->stride_y is a very large value,
could the hardware access memory up to base[0] + fm->height[0] * stride_y?

Since the validator skips checking y =3D fm->height[0] for Tile 0, the
computed info->region_size appears to be drastically underestimated. Could
this underestimation bypass the GEM buffer bounds check, allowing the NPU
to read or write out-of-bounds physical memory via DMA?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-ethosu-fix=
es-v3-0-490fe215286f@kernel.org?part=3D19
