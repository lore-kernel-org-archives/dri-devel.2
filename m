Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB478C4452D
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 04:48:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0685B10EC25;
	Wed, 22 Jul 2026 04:48:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XFkjxfe3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E3EF10EC25
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 04:48:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 802F4600FC;
 Wed, 22 Jul 2026 04:48:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1661F1F000E9;
 Wed, 22 Jul 2026 04:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784695691;
 bh=l10UNsvniFtFpPjlUujBEc4HMHSZPDJgjnmoqUIKIew=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XFkjxfe3dV9YyltCi//1sHk1FKI3Ifg/LVjMuV3w0JxINGA5jedL48ewt8XMGAm/o
 ooe0poVSvuFQQqHd6enxhVRcRJ2yak8k8HKhBpLlt7Ao9J/QFTU0MngBNg+ZtnVlxP
 aPT7F3YvWk7+HEdz2zYNkuSXqtFPdRpKwdvAsEk0fZPfYLp4KQ7XnAi7HWcUaNkzzu
 r9LIW4SdW7qQcBx/Aiz4TQQUb7Z6iYi4Z0xp7a4/mD/IUHsAUpPLh7scwWJR0c9uhH
 NVUd44iQ3UL6j8A0QajRQcfHJ+6h6WKE/7KoBuKCizzKXp8ch4Ukf1LWvadw3wskmA
 6kI2A9RYTPq1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] drm/xe: select TRANSPARENT_HUGEPAGE
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722044220.1110278-2-matthew.brost@intel.com>
References: <20260722044220.1110278-1-matthew.brost@intel.com>
 <20260722044220.1110278-2-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 04:48:10 +0000
Message-Id: <20260722044811.1661F1F000E9@smtp.kernel.org>
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
- [Low] DRM_XE unconditionally selects TRANSPARENT_HUGEPAGE without inherit=
ing its architecture and PREEMPT_RT dependencies.
--

--- Patch [2]: [PATCH 2/3] drm/xe: select TRANSPARENT_HUGEPAGE ---
commit 039323cec9a41618d3b6161e1831b08e7ba4069a
Author: Matthew Brost <matthew.brost@intel.com>

drm/xe: select TRANSPARENT_HUGEPAGE

This commit selects TRANSPARENT_HUGEPAGE for the DRM_XE driver to ensure
the THP split machinery is available for Xe's TTM shrinker incremental
swap path.

> diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
> index 4d7dcaff2b915..88a4f3d09d5fe 100644
> --- a/drivers/gpu/drm/xe/Kconfig
> +++ b/drivers/gpu/drm/xe/Kconfig
> @@ -11,6 +11,12 @@ config DRM_XE
>  	# the shmem_readpage() which depends upon tmpfs
>  	select SHMEM
>  	select TMPFS
> +	# Xe is the only TTM driver that exercises the TTM shrinker's
> +	# incremental swap path, which splits the pool's compound folios one
> +	# page at a time via folio_split_driver_managed(). That helper lives
> +	# in the THP split machinery, so pull it in here rather than for all
> +	# TTM users.
> +	select TRANSPARENT_HUGEPAGE

[Severity: Low]
Does this select statement need to inherit the dependencies for
TRANSPARENT_HUGEPAGE?

TRANSPARENT_HUGEPAGE has specific architecture dependencies (like
HAVE_ARCH_TRANSPARENT_HUGEPAGE) and can conflict with PREEMPT_RT. Selecting
a config symbol without inheriting its dependencies can cause Kconfig unmet
dependency warnings and potential build failures on configurations where
those dependencies are not met (for example, on non-x86 architectures when
building with COMPILE_TEST).

Should this use a conditional selection (e.g., select TRANSPARENT_HUGEPAGE
if HAVE_ARCH_TRANSPARENT_HUGEPAGE) or be changed to a "depends on" to
ensure it is only pulled in when its requirements are satisfied?

>  	select DRM_BUDDY
>  	select DRM_CLIENT_SELECTION
>  	select DRM_KMS_HELPER

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722044220.1110=
278-1-matthew.brost@intel.com?part=3D2
