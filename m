Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6EE7CD98D2
	for <dri-devel@archiver.kernel.org>; Sun, 14 Jun 2026 03:32:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB82C10E00F;
	Sun, 14 Jun 2026 03:32:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gHTNleiG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D58F10E00F
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 03:32:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ED9A040318;
 Sun, 14 Jun 2026 03:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0B41F000E9;
 Sun, 14 Jun 2026 03:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781407930;
 bh=BTVqbW5P9RVnnnaAh4OMm15uijGoTsz59kAcEHvE69I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gHTNleiGguAz1eBqu6eAcTLlD/OcndCBw217IHRAui0q9Xx0NmpOxmwcY1fLpcaEq
 AZD1nwwZnYTyI3WC+N1EnERzCwJIKhT1hv6QMcmWwTh+UhNmfDkY7X/encW3p4zC/z
 qFeHaqYM/l5tDYFo8r0Ska0NTfHwThj4EIPwaf5XqyuUj9/sqCfMr3UoK4K60fwanm
 U0l/W+apHmf5s4wl1aI4kmcPg9fOildcMXnb84PsUAi3CSQOaJUN8KOfmvtZU+bdMq
 RJypomYXRViHlBIIDSp/Wj7weH+6KLnaPKBjdBxcIfs+F6mIFf7HMhmIToX0c/JApB
 e5vJN9IfdXVVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] staging: vme_user: remove obsolete VMEbus driver and
 Kconfig entry
To: "Gabriel Ramos Barbosa Mota" <maguraa53@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260613033138.601841-2-maguraa53@gmail.com>
References: <20260613033138.601841-2-maguraa53@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 14 Jun 2026 03:32:10 +0000
Message-Id: <20260614033210.AA0B41F000E9@smtp.kernel.org>
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
- [Medium] Incomplete driver removal: only the Kconfig inclusion was remove=
d, leaving orphaned source files, build entries, and documentation.
--

commit bf2996a15c0248854dd33c79b9ebac4018349692
Author: Gabriel Ramos Barbosa Mota <maguraa53@gmail.com>

staging: vme_user: remove obsolete VMEbus driver and Kconfig entry

This commit removes the Kconfig inclusion for the VMEbus driver in the
staging tree.

Closes: https://lore.kernel.org/oe-kbuild-all/202606130547.TsvyPMvB-lkp@int=
el.com/

> diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
> index 2f92cd698bef6..0e6e5330fb6af 100644
> --- a/drivers/staging/Kconfig
> +++ b/drivers/staging/Kconfig
> @@ -46,6 +46,4 @@ source "drivers/staging/vc04_services/Kconfig"
> =20
>  source "drivers/staging/axis-fifo/Kconfig"
> =20
> -source "drivers/staging/vme_user/Kconfig"

[Severity: Medium]
The commit message indicates the driver is being removed, but this patch
only removes the Kconfig inclusion. Are there missing changes to remove
the driver's source files in drivers/staging/vme_user/ and its build
entry in drivers/staging/Makefile?

Additionally, should the references to the VME subsystem in MAINTAINERS
and the API documentation in Documentation/driver-api/vme.rst also be
cleaned up in this commit?

> -
>  endif # STAGING

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613033138.6018=
41-2-maguraa53@gmail.com?part=3D1
