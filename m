Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A2DC5CFCF
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 02:47:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2157710E499;
	Thu, 13 Aug 2026 02:47:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ls9oZGH5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A408710E499;
 Thu, 13 Aug 2026 02:47:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 27DAB600AD;
 Thu, 13 Aug 2026 02:47:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B775C1F000E9;
 Thu, 13 Aug 2026 02:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786589276;
 bh=QiSgqXEqeJewf4t/irr3hxg9Mt76PZhBsxZw3XSWE5Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ls9oZGH5QPHkiaEWASrUOUbzp8m0fo4jD+MvIlnbrkRCaxKRAp8y2pQGIIc9OpDDq
 /EesIBgPtTIm1/hKDsVaXy7Yzt1q7jQNpYjTy5UAqN/gCjyegZgfFwzQFd1XYqzIWW
 LdlxjEXfgSUZZdpq6pR//X2IMHWpTQ/Jkt4Pqm9ldV6eq5UMdUmVjjIUPNu9dr0d4I
 sUAcERQnP7Tgs/IOrsmtJ5OGA/u4UxhWF0d4seDBWlIKfWdqojEXzkrLdVg4Qs7Mku
 z9lTESgvFwv22N0ggrTRLg2xdaDyBLCUWKdA9GabWvrXJditEfpZBwwGKYL1I0JQh2
 UQqMCl0tQbrRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] drm/xe: Implement Wa_22016122933
To: =?utf-8?b?VGFsZXMgQS4gTWVuZG9uw6dh?= <talesam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260813023016.805573-4-talesam@gmail.com>
References: <20260813023016.805573-1-talesam@gmail.com>
 <20260813023016.805573-4-talesam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 02:47:56 +0000
Message-Id: <20260813024756.B775C1F000E9@smtp.kernel.org>
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
- [High] Direct dereference of `xe_device_get_gt()` return value without a =
preceding NULL check.
--

--- Patch [3]: [PATCH v2 3/3] drm/xe: Implement Wa_22016122933 ---
commit 79bddd9db4e49ddb9738f564c898446b08519d91
Author: Tales A. Mendon=C3=A7a <talesam@gmail.com>

drm/xe: Implement Wa_22016122933

On platforms with a standalone media GT and media version 13.00
(MTL/ARL), memory shared between the CPU and the media GT's GuC must
not be mapped cached on the CPU side: the CPU can otherwise read stale
cache lines for data the GuC has already written.

Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678

> diff --git a/drivers/gpu/drm/xe/xe_guc.c b/drivers/gpu/drm/xe/xe_guc.c
> index 4286bd05c6861..c988a2a3b7bdb 100644
> --- a/drivers/gpu/drm/xe/xe_guc.c
> +++ b/drivers/gpu/drm/xe/xe_guc.c

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential NULL
pointer dereference in this file in guc_g2g_alloc().

The xe_device_get_gt() function can return NULL for invalid GT indices, but
its return value is immediately dereferenced without a check:

	if (gt->info.id !=3D 0) {
		struct xe_gt *root_gt =3D xe_device_get_gt(xe, 0);
		struct xe_guc *root_guc =3D &root_gt->uc.guc;

If the primary GT (index 0) is missing or invalid, this will crash the
system. Does this code need a NULL check for root_gt, or should it use
xe_root_mmio_gt(xe) instead if the root tile's primary GT is specifically
needed?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813023016.8055=
73-1-talesam@gmail.com?part=3D3
