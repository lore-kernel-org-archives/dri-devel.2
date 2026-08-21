Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB018C5DF87
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 07:33:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0764710F23E;
	Fri, 21 Aug 2026 07:33:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DNhkkGiD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F05810F23E
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 07:33:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ECBDD43B0A;
 Fri, 21 Aug 2026 07:33:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70931F000E9;
 Fri, 21 Aug 2026 07:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787297597;
 bh=gi9JHOcfYoqUSrDtjQrSlz1e+hjsNqaVrW1Z0bBTTwI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DNhkkGiD8Q5Y9Z0T40HWwRtHiV0qSg/mgey5M0VlEQ+9tf0JjhwEhzE5jk2WY4fT7
 CMSakOihI9ZAQCECCYmV5w34oVS2ykg87PEmbYWsIEGXMTtxiU3SRBv0cdJuwmH44C
 i0Yy4iNI/Grn8PbIO+I7REbp5vDBwhuPA9o/FIK0WL0/noDGF+OKpCCjqDUvL02LlP
 z4n1H9WSgebI+vC5/+reWdPQ4s8KMy5MjdjlTGZuvdbMpHCJerCZTkhwcUFAyIdxF7
 3Tw3iSzPGYmzfL/+rexOyOPdGXKvAk7ptxqUIWPhEKWhoXdyg2qGkY0m1V9o0Z+e9a
 vsFEaSwkVaA4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/gud: validate GUD_ROTATION_0 is present in
 supported rotations
To: "Sajal Gupta" <sajal2005gupta@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260821071812.16500-1-sajal2005gupta@gmail.com>
References: <20260821071812.16500-1-sajal2005gupta@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 07:33:17 +0000
Message-Id: <20260821073317.A70931F000E9@smtp.kernel.org>
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
- [Critical] An out-of-bounds heap write occurs in `gud_plane_atomic_check`=
 due to an incorrect array indexing bug. When populating `req->properties` =
with plane properties, the driver uses `req->properties[num_properties + i]=
` while simultaneously incrementing `num_properties` inside the loop. This =
causes the effective index to be `initial_num_properties + 2 * i`, which sk=
ips elements and ultimately writes past the end of the allocated array. A m=
alicious USB device can trigger this by advertising multiple plane and conn=
ector properties (up to 32 of each), causing the loop to write up to index =
94 in an array allocated for 64 elements.
--

--- Patch [1]: [PATCH] drm/gud: validate GUD_ROTATION_0 is present in suppo=
rted rotations ---
commit 63f4e25c2ff8da9667835a1e92cc53b147ae5f56
Author: Sajal Gupta <sajal2005gupta@gmail.com>

drm/gud: validate GUD_ROTATION_0 is present in supported rotations

The rotation argument to drm_plane_create_rotation_property() is set to
DRM_MODE_ROTATE_0, and the device reported rotation bitmask is used as
the supported_rotations argument. The driver never validates that
GUD_ROTATION_0 is present, so a device that omits it from its
GUD_PROPERTY_ROTATION triggers a warning. Fix this by skipping the creation
of rotation property if the device doesn't have the GUD_ROTATION_0 bit.

Fixes: 40e1a70b4aed ("drm: Add GUD USB Display driver")
Reported-by: syzbot+efe2810681f1b065d3a8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3Defe2810681f1b065d3a8
Tested-by: syzbot+efe2810681f1b065d3a8@syzkaller.appspotmail.com
Signed-off-by: Sajal Gupta <sajal2005gupta@gmail.com>

> diff --git a/drivers/gpu/drm/gud/gud_drv.c b/drivers/gpu/drm/gud/gud_drv.c
> index 89bd6ca36003f..3a1b9e2a2eaa1 100644
> --- a/drivers/gpu/drm/gud/gud_drv.c
> +++ b/drivers/gpu/drm/gud/gud_drv.c
[ ... ]

[Severity: Critical]
This is a pre-existing issue, but can this loop write out of bounds?

Looking at gud_plane_atomic_check() in drivers/gpu/drm/gud/gud_pipe.c:

	num_properties =3D ret;
	for (i =3D 0; i < gdrm->num_properties; i++) {
		...
		req->properties[num_properties + i].prop =3D cpu_to_le16(prop);
		req->properties[num_properties + i].val =3D cpu_to_le64(val);
		num_properties++;
	}

Since num_properties is incremented inside the loop, the index
num_properties + i actually increments by 2 on each iteration.

If a USB device advertises multiple plane and connector properties,
would this skip array elements and eventually write past the end of the
req->properties allocation, causing a heap buffer overflow?

Could this be fixed by just using num_properties as the index instead of
num_properties + i?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821071812.1650=
0-1-sajal2005gupta@gmail.com?part=3D1
