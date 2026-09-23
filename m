Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 056B3C982EA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 11:16:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43F5A10EFC6;
	Wed, 23 Sep 2026 11:16:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WpK965Rj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6805E10EFD6;
 Wed, 23 Sep 2026 11:16:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 38D1B43DDB;
 Wed, 23 Sep 2026 11:16:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CB61F000FF;
 Wed, 23 Sep 2026 11:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790162166;
 bh=GZbmNp0hOi/EWJZ4QMV2oZg5jG4TOnCN9i5rVy9+ytQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WpK965RjOooOddvHoEvzBrXMzOSpDwdZkzbDO2IxSEnFpPJZzYYx+FdOW9sSAVcy2
 t9c9jfo+cQX6OVGJSFYFpl1NvurltXJ4N0rFB7JPyqcz+QaFy44zBi3ymRZfC6/ZAz
 hoGTakmtQTCUukKblZy3Onr4c0mq75bAzeWEb19HF6cUOUnhjeAYKQd8yh09WcBls3
 2bFj2ffpB+X34bdLnRtkf8dEgyPFpzitlYPpMtuBry11NkjsdbXEAcSaMPUJGNORpH
 1rQGFvZUwitnMauPxI1g7jZRcwXJRjvcn8ORyozQpIMGlxnOh94eiTNd3qtk1ExS5T
 vB2pEIb/rYKJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/fbdev: Move fbdev helpers into client library
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20260923110537.451614-3-tzimmermann@suse.de>
References: <20260923110537.451614-1-tzimmermann@suse.de>
 <20260923110537.451614-3-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 11:16:05 +0000
Message-Id: <20260923111605.D7CB61F000FF@smtp.kernel.org>
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
- [Low] drm: build failure in armada driver due to missing header rename
- [Low] drm: sphinx documentation build fails due to un-updated kernel-doc =
paths
--

commit eec385087eda413784c5684a793dc7987f6f4f49
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/fbdev: Move fbdev helpers into client library

This commit moves DRM's fbdev helpers into the client-library module and
fixes include statements throughout the DRM drivers. It also renames the
files from drm_fb_helper to drm_fbdev_helper.

> diff --git a/include/drm/drm_fb_helper.h b/include/drm/clients/drm_fbdev_=
helper.h
> similarity index 99%
> rename from include/drm/drm_fb_helper.h
> rename to include/drm/clients/drm_fbdev_helper.h
> index 0c5e5ed7b5e74..7575aaf34c620 100644
> --- a/include/drm/drm_fb_helper.h
> +++ b/include/drm/clients/drm_fbdev_helper.h

[Severity: Low]
Does drivers/gpu/drm/armada/armada_fbdev.c need to be updated to include the
new header path?  This file still includes the old header path, which causes
a build failure because the header was renamed:

drivers/gpu/drm/armada/armada_fbdev.c:
#include <drm/drm_fb_helper.h>

[Severity: Low]
Do the kernel-doc directives in Documentation/gpu/drm-kms-helpers.rst need
to be updated?  These directives reference the old file paths, breaking the
Sphinx documentation build:

Documentation/gpu/drm-kms-helpers.rst:
.. kernel-doc:: drivers/gpu/drm/drm_fb_helper.c
   :doc: fbdev helpers

.. kernel-doc:: include/drm/drm_fb_helper.h
   :internal:

.. kernel-doc:: drivers/gpu/drm/drm_fb_helper.c
   :export:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923110537.4516=
14-1-tzimmermann@suse.de?part=3D2
