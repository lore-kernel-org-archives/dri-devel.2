Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31255C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 21:14:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76B9A10F48C;
	Fri, 28 Aug 2026 21:14:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="egVFxzMv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4486E10F48C
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 21:14:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EEE6C40191;
 Fri, 28 Aug 2026 21:14:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E5A1F000E9;
 Fri, 28 Aug 2026 21:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787951661;
 bh=qmjEAnr+uIP2qw/Jvm35X68NPwB8MkSTeY1KD79OBYs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=egVFxzMvuvQdMvzNwle/yNPC5ZA6eAy7ZR1PaPORwzagJmrfMeeaoedvIb+03vie2
 ph2Jn6gvzixYI64qPS9YxIlbRjcuUZ9r5aKSJ/NRwYbHQsWRYuV/WC9U1ckk9p7RG9
 9plLtVey0OvPG7PA8iDClvOMHl3VLDCLApPdACVo+PYIpZJ75Fhufwz+F1qApxX4l3
 XZMtkq5LGQ8sA+k2LfkImAitAoa2oFxZ6bIi0JffFeabvYGUVGWxSAJ1ANrR0r8iVh
 xaWQgQKF3QFHfhWo3LW3/LW28/0s1rxE5J9f96mt5Sq/nPCbY60m6MiGC9gdPh80zl
 uWGB+WvURbDUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/17] drm/panfrost: Move lock and modparam
 initialisations into their subsystems
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260828-claude-fixes-v7-3-72a13b2c125d@collabora.com>
References: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
 <20260828-claude-fixes-v7-3-72a13b2c125d@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 21:14:21 +0000
Message-Id: <20260828211421.B1E5A1F000E9@smtp.kernel.org>
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
- [Low] Global variable lacks `static` qualifier after being localized to a=
 single file
--

commit 8f093246201046313865b72d1d462aeb11847f4f
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

    drm/panfrost: Move lock and modparam initialisations into their subsyst=
ems
   =20
    The device init function feels a bit cluttered with things that should =
be
    done in the specific subsystems where those locks and lists are being
    used. Same goes for module parameters, it's best to limit them to the
    subsystems where they're relevant.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/pa=
nfrost/panfrost_gem.c
> index 7b993a089af2d..15105b7f954bf 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
[ ... ]
> @@ -11,10 +11,17 @@
>  #include <drm/panfrost_drm.h>
>  #include <drm/drm_print.h>
>  #include "panfrost_device.h"
> -#include "panfrost_drv.h"
>  #include "panfrost_gem.h"
>  #include "panfrost_mmu.h"
> =20
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +bool panfrost_transparent_hugepage =3D true;

[Severity: Low]
Since panfrost_transparent_hugepage was moved into panfrost_gem.c and its
declaration was removed from panfrost_drv.h, should this be declared as sta=
tic?

Without the static qualifier, this variable is now exposed to the global
namespace and triggers a Sparse warning ("symbol
'panfrost_transparent_hugepage' was not declared. Should it be static?").

> +module_param_named(transparent_hugepage, panfrost_transparent_hugepage, =
bool, 0400);
> +MODULE_PARM_DESC(transparent_hugepage, "Use a dedicated tmpfs mount poin=
t with Transparent Hugepage enabled (true =3D default)");
> +#else
> +#define panfrost_transparent_hugepage false
> +#endif
> +
>  int panfrost_gem_init(struct panfrost_device *pfdev)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-claude-fix=
es-v7-0-72a13b2c125d@collabora.com?part=3D3
