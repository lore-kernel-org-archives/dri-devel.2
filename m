Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C269C79FA1
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 01:10:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFE2410EE38;
	Wed,  9 Sep 2026 01:10:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nBt/91HD";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A9E510EE38
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 01:10:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2BB5C601FB;
 Wed,  9 Sep 2026 01:10:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAFAA1F00A3A;
 Wed,  9 Sep 2026 01:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788916201;
 bh=NKsw/DD5o2qV5RvFgW6LmX+4CKTjelFvDtWQuz14AQM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nBt/91HDF7+KwLMj2NN8ZWnY8j9x8ghxfdiVcjRbQHRQp6ld0UPIXxsbE/tIcqLaN
 TNFU09PsJ0n/DYDgR6YvpbHLYRjIvwODPmE41w1xNGr7G8IjqQ/404Zk4A437+fR00
 cw0Xy4wTskHKT6UiSuoiF2sBforNMX957/NRDSMdvMauQ5jMyHN7ZBEalZ7C9ElFvG
 DocC5ehHoLHJxmKrYBfoircC+XhNbrlUrB8JvwT7R/Z/6WFawPpMvy4ARetLMzRkDO
 bNb4oXCrVIVVMSVIpvbCRyu5HJiButcUkkjBA8XJnXNcvu7HG4rhmw5RO+9K+FOare
 YJG99EWd3ziRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 08/39] dyndbg: add stub macro for
 DECLARE_DYNDBG_CLASSMAP
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260908-dd-cmap-part2-clean-v9-8-3a3f621f4a10@gmail.com>
References: <20260908-dd-cmap-part2-clean-v9-0-3a3f621f4a10@gmail.com>
 <20260908-dd-cmap-part2-clean-v9-8-3a3f621f4a10@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 01:10:01 +0000
Message-Id: <20260909011001.AAFAA1F00A3A@smtp.kernel.org>
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
- [Low] Moving DECLARE_DYNDBG_CLASSMAP into the CONFIG_DYNAMIC_DEBUG block =
causes a build failure in DRM when CONFIG_DYNAMIC_DEBUG is disabled but CON=
FIG_DYNAMIC_DEBUG_CORE is enabled.
--

commit 0230d1a17999838bd74e9c3bf428293b96fde5ce
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: add stub macro for DECLARE_DYNDBG_CLASSMAP

This patch adds a stub macro for DECLARE_DYNDBG_CLASSMAP for !DYNAMIC_DEBUG
builds. It moves the original macro definition under the ifdef block to
provide a cleaner starting point for future changes.

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
Does this empty stub cause a build failure in DRM when compiling with
CONFIG_DYNAMIC_DEBUG=3Dn, CONFIG_DYNAMIC_DEBUG_CORE=3Dy, and
CONFIG_DRM_USE_DYNAMIC_DEBUG=3Dy?

Because DYNAMIC_DEBUG_MODULE is missing for drm_print.c in this configurati=
on,
the stub macro is used. This causes drm_debug_classes to be undeclared when
drm_debug_bitmap() attempts to reference it:

drivers/gpu/drm/drm_print.c:drm_debug_bitmap() {
    ...
    .map =3D &drm_debug_classes,
    ...
}

Could this empty stub be updated to properly declare the struct pointer even
when the debug features are disabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-dd-cmap-pa=
rt2-clean-v9-0-3a3f621f4a10@gmail.com?part=3D8
