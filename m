Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CC3606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 17:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aTo3SxHk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 592EB10E286;
	Fri, 20 Nov 2026 17:32:22 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F465112C0F
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 17:32:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 165D343372;
 Fri, 20 Nov 2026 17:32:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440BA1F000C6;
 Fri, 20 Nov 2026 17:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795195935;
 bh=WTVfqDO7JYv3rw75rbR1yF0m83xWq3dEqOPlWcgDeV8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aTo3SxHkw5CFFEi5Sf/7mkV4krrvGMRqsEO2oApOGPu9ZWa4XjwpaB74bCUSIupex
 7Q+0FAPep13P7+QQMQuc8rmdf2Std+jmdqsX0vnbGCj//BfAwFETaC6Be9pBlxiXHL
 yotXk3Fm2jxAWVtbIm7UPVUcw11mOk4AicGMcuenj8GhGq+8CIDHPeh/KLmGqPtWT6
 4FkNDIlguCprymwVvB98wrzm0aerbjFQw+KPW/fjD9ZGT0s4UxQ7pTzh3palaWBi66
 j3Q7Ut4XbLoDZjhFObccDaeppsfNejxo1BkUE4oRhdmhFoV73Ck3rlWM75u340bfWg
 5jZqUIqkPf/vw==
Message-ID: <sashiko-outbox-225674@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] drm: Fix incorrect CFLAGS-y spelling inside
 Makefile
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261120-rd-mostly-v2-2-88056ede02a8@gmail.com>
References: <20261120-rd-mostly-v2-0-88056ede02a8@gmail.com>
 <20261120-rd-mostly-v2-2-88056ede02a8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 17:32:14 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm: redundant ccflags-y with subdir-ccflags-y duplicates
  compiler flag
--

commit 3641ab8573c265c9f30c513b01ff9a6dc232bced
Author: Jim Cromie <jim.cromie@gmail.com>

drm: Fix incorrect CFLAGS-y spelling inside Makefile

This commit replaces CFLAGS-$(CONFIG_DRM_USE_DYNAMIC_DEBUG) with
ccflags-y and subdir-ccflags-y in drivers/gpu/drm/Makefile so that
-DDYNAMIC_DEBUG_MODULE is passed during compilation.

> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index 2c6bc093a923a..4a93c09f08d94 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -3,7 +3,8 @@
>  # Makefile for the drm device driver.  This driver provides support for =
the
>  # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
> =20
> -CFLAGS-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)	+=3D -DDYNAMIC_DEBUG_MODULE
> +ccflags-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)		+=3D -DDYNAMIC_DEBUG_MODULE
> +subdir-ccflags-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)	+=3D -DDYNAMIC_DEBUG_MODU=
LE

[Severity: Low]
Is ccflags-$(CONFIG_DRM_USE_DYNAMIC_DEBUG) redundant when
subdir-ccflags-$(CONFIG_DRM_USE_DYNAMIC_DEBUG) is also set?

In scripts/Makefile.build, subdir-ccflags-y is appended to KBUILD_CFLAGS
for both the current directory and its subdirectories:

scripts/Makefile.build {
    ...
    # flags that take effect in current and sub directories
    KBUILD_AFLAGS +=3D $(subdir-asflags-y)
    KBUILD_CFLAGS +=3D $(subdir-ccflags-y)
    ...
}

Setting both passes -DDYNAMIC_DEBUG_MODULE twice on the compiler command
line for every object built directly in drivers/gpu/drm/.  Keeping only
subdir-ccflags-$(CONFIG_DRM_USE_DYNAMIC_DEBUG), matching the rest of this
Makefile, covers both drivers/gpu/drm/ and its subdirectories.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-rd-mostly-=
v2-0-88056ede02a8@gmail.com?part=3D2
