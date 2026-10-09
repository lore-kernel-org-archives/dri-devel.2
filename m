Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578B8CA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 12:55:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE88910E3A8;
	Fri,  9 Oct 2026 12:55:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LPX4o8xs";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BEC210E3A8
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 12:55:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 482AF60DC1;
 Fri,  9 Oct 2026 12:55:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28671F000FF;
 Fri,  9 Oct 2026 12:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791550548;
 bh=RzaJ0lg+LQEuoyUJMyCAuT6C05Q8bXAt5YguCtEBXCk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LPX4o8xsTUPcZXYrCrr5Jfy1J2NLD9KVdo3AODjh8l4kZOLcvzdh+15IXpFTIzFyI
 yHHBaoC2gnd25qvTbD6u8bVNPgJRBsc/d0idKaX+pI5G7/X5WglIg6uKjRMkrm3q04
 yWBbua4e7j5NaP2J9yA/yeA/FvfyglCgBCd/kY+1j3cPFFKNj7i9/PoeSoByFV997r
 SGptBgn8xnFR/eYwN5FQ2bfYdDqEasNiduTpMDd08iQ5dj8kcVSeP/E2X2uPmGdyi1
 voCZMOvlgMlGvj6TR+HwNiRrEMOjuGQsk6Do/SQy2R+07lLVM4/DJUeQraXgSf/Yuc
 DUnG9sog2MLaw==
Message-ID: <sashiko-outbox-165574@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 02/15] drm/panfrost: Move lock and modparam
 initialisations into their subsystems
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261009-claude-fixes-v14-2-cb743b3b973b@collabora.com>
References: <20261009-claude-fixes-v14-0-cb743b3b973b@collabora.com>
 <20261009-claude-fixes-v14-2-cb743b3b973b@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 12:55:47 +0000
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
- [Low] drm/panfrost: missing moduleparam.h include for module_param_named
--

commit 773e4af10fafabff3b1003f157c629dac2d4ca7d
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
   =20
drm/panfrost: Move lock and modparam initialisations into their subsystems

This commit moves subsystem-specific lock and list initializations, as well
as module parameters, out of panfrost_drv.c and into their respective
subsystems to unclutter the device init function.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/pa=
nfrost/panfrost_gem.c
> index f39c0f50ed4ff..383ac8cd56456 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
> @@ -11,20 +11,27 @@
>  #include <drm/panfrost_drm.h>
>  #include <drm/drm_print.h>
>  #include "panfrost_device.h"
> -#include "panfrost_drv.h"
>  #include "panfrost_gem.h"
>  #include "panfrost_mmu.h"
> =20
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +static bool panfrost_transparent_hugepage =3D true;
> +module_param_named(transparent_hugepage, panfrost_transparent_hugepage, =
bool, 0400);
> +MODULE_PARM_DESC(transparent_hugepage, "Use a dedicated tmpfs mount poin=
t with Transparent Hugepage enabled (true =3D default)");

[Severity: Low]
Does this file need to include <linux/moduleparam.h> for these macros?

Since module_param_named() and MODULE_PARM_DESC() were moved into
panfrost_gem.c, and the panfrost_drv.h include was removed, omitting
<linux/moduleparam.h> (or <linux/module.h>) can cause a build failure
when compiling this file.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-claude-fix=
es-v14-0-cb743b3b973b@collabora.com?part=3D2
