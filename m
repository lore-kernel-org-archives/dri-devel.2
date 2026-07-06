Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BBCC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 03:24:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74B0E10E71A;
	Mon,  6 Jul 2026 03:24:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mvE1egaz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26A5E10E71A
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 03:24:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CC61741A80;
 Mon,  6 Jul 2026 03:24:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F861F000E9;
 Mon,  6 Jul 2026 03:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783308266;
 bh=l2UAIVl0/6rscTwz2uR3WCRBAGiUDwpxLzUw6BHpEVQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mvE1egazaAzgXlT/bQ4JXfSWOKE2DDFqQ+Iy9YfOea1L8auXa1SmJsDngSqfiM2CP
 uNPNbnOFZ6Ate2sKdTqlFwO/7GdfC2NHl9u1SPl0b3zfdYB0u20DUGDDhuGLKXb/yc
 5lBa0Quw6OvqOdVvV/Mjwig0ryWCR5R2BIw4T+VLCaDSR9xyUM+kZ9caLDnuERNiao
 176L3jwN3R84nHGEzX0c6sVIDWE/mnfA4xhc7M9y05xe/ynMlW61MwiH9M3tqBR+MJ
 eycAny0fscgu2BmspuFoLhJMaWo2Gqyeg3z08kLdJB9Rovrkd4yVLZdJ/1Ih9wxT/o
 zD2o8Tb+4bxMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm: nova-drm: use vertical import style
To: "Guru Das Srinagesh" <linux@gurudas.dev>
Cc: "Danilo Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
 "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260705-drm-vert-imp-v1-1-c7b24e290763@gurudas.dev>
References: <20260705-drm-vert-imp-v1-1-c7b24e290763@gurudas.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 03:24:26 +0000
Message-Id: <20260706032426.78F861F000E9@smtp.kernel.org>
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
- [Low] Incomplete vertical import conversion and unmerged import paths.
--

commit 4005a285946c405f71ba0fa91578531ee7637244
Author: Guru Das Srinagesh <linux@gurudas.dev>

drm: nova-drm: use vertical import style

This commit converts the module imports to a vertical layout to improve
readability and maintainability.

> diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
> index a3b7bd36792c1..547da5caa58db 100644
> --- a/drivers/gpu/drm/nova/file.rs
> +++ b/drivers/gpu/drm/nova/file.rs
> @@ -1,10 +1,16 @@
>  // SPDX-License-Identifier: GPL-2.0
> =20
> -use crate::driver::{NovaDevice, NovaDriver};
> +use crate::driver::{
> +    NovaDevice,
> +    NovaDriver, //
> +};
>  use crate::gem::NovaObject;
>  use kernel::{
>      alloc::flags::*,
> -    drm::{self, gem::BaseObject},
> +    drm::{
> +        self,
> +        gem::BaseObject, //
> +    },
>      pci,
>      prelude::*,
>      uapi,
>  };

[Severity: Low]
This isn't a bug, but does the kernel::{...} block need a trailing //
after uapi, to ensure rustfmt preserves the vertical formatting?

> diff --git a/drivers/gpu/drm/nova/gem.rs b/drivers/gpu/drm/nova/gem.rs
> index 9d8ff7de2c0f7..8d89804257371 100644
> --- a/drivers/gpu/drm/nova/gem.rs
> +++ b/drivers/gpu/drm/nova/gem.rs
> @@ -2,14 +2,21 @@
> =20
>  use kernel::{
>      drm,
> -    drm::{gem, gem::BaseObject, DeviceContext},
> +    drm::{
> +        gem,
> +        gem::BaseObject,
> +        DeviceContext, //
> +    },

[Severity: Low]
Could these drm and gem imports be merged? For instance, they might be
combined into a single drm::{self, gem::{self, BaseObject}, DeviceContext, =
//}
block to avoid redundant paths.

>      page,
>      prelude::*,
>      sync::aref::ARef,
>  };

[Severity: Low]
Similar to the file.rs changes, does this outermost block need a trailing //
after sync::aref::ARef, to maintain the vertical style when formatted?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705-drm-vert-i=
mp-v1-1-c7b24e290763@gurudas.dev?part=3D1
