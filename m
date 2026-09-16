Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3706AC982C9
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:00:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51CEE10EC86;
	Wed, 16 Sep 2026 16:00:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nhLTUF0G";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E9B710ECB9
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 16:00:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3274E42DC4;
 Wed, 16 Sep 2026 16:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5F61F000FF;
 Wed, 16 Sep 2026 16:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789574419;
 bh=Ydnkobt8d1OCf8cXm89W4LuryFwjkgPXjx+lVfR3s2w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nhLTUF0GKLG3sdLsGv0C1xREJldQB8F2H4M6x9pqtTUCx2kz1NuRUqYs7iEOYLce1
 2LDeccW2OBfRq3S4u22ekSpQkwsP8j+thsEk861BLVSy9V26C8LlxiRDApzaWtAmJc
 dCvrj1rPLipP586fyis/aN3SQVrhsmje5B9gE3hS/LKZLkdBcmazy33eYb36d3+wOv
 ic5FdX89scN99n3DzI61yTPsAuuaOljKa9922rcEx1cYlLlEjnZZ4CUCn7hAIIWkFG
 viW975E9LrP9HF1nikgAAAJA2XWgd+IH2m3nF9Jtd1R/PXGR1HQdOjHshr+CIOg66z
 07ZLfCvz9wTxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 08/38] dyndbg: add stub macro for
 DECLARE_DYNDBG_CLASSMAP
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260916-dd-cmap-part2-clean-v10-8-af4cf4767707@gmail.com>
References: <20260916-dd-cmap-part2-clean-v10-0-af4cf4767707@gmail.com>
 <20260916-dd-cmap-part2-clean-v10-8-af4cf4767707@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 16:00:18 +0000
Message-Id: <20260916160018.DC5F61F000FF@smtp.kernel.org>
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
- [Low] drm: compilation failure due to DECLARE_DYNDBG_CLASSMAP stub
--

commit 96b109d4ffa1bfc809c49d548861d8dd8aa48aaf
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: add stub macro for DECLARE_DYNDBG_CLASSMAP

This commit moves the DECLARE_DYNDBG_CLASSMAP macro definition inside the
DYNAMIC_DEBUG ifdef block. It also adds an empty stub macro for builds
without dynamic debug enabled to provide a cleaner starting point for
future changes.

> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> index 05743900a1169..a10adac8e8f00 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
[ ... ]
> @@ -314,6 +314,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
> =20
>  #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)
>  #define DYNAMIC_DEBUG_BRANCH(descriptor) false
> +#define DECLARE_DYNDBG_CLASSMAP(...)

[Severity: Low]
Does this empty stub lead to a compilation failure in the DRM subsystem?

In drivers/gpu/drm/Makefile, CFLAGS is used but ignored by Kbuild for
subdirectories, meaning DYNAMIC_DEBUG_MODULE is never actually defined
for the DRM subsystem. Before this patch, DECLARE_DYNDBG_CLASSMAP was
defined unconditionally, which masked the Kbuild typo.

When CONFIG_DYNAMIC_DEBUG=3Dn, CONFIG_DYNAMIC_DEBUG_CORE=3Dy, and
CONFIG_DRM_USE_DYNAMIC_DEBUG=3Dy, this empty stub is used because
DYNAMIC_DEBUG_MODULE is undefined. This causes DECLARE_DYNDBG_CLASSMAP
to expand to nothing.

As a result, drm_print.c attempts to reference the undeclared
drm_debug_classes variable, causing a build regression:

drivers/gpu/drm/drm_print.c:drm_debug_bitmap() {
    ...
    .map =3D &drm_debug_classes,
    ...
}

Would it be possible to handle the stub expansion differently or update
the DRM Makefile to use ccflags-y instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-dd-cmap-pa=
rt2-clean-v10-0-af4cf4767707@gmail.com?part=3D8
