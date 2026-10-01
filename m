Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787F9CA5FD2
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:03:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDA7010E1FD;
	Thu,  1 Oct 2026 13:03:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KHDKmt7+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F6FC10E1FD
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 13:03:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 91AB560A66;
 Thu,  1 Oct 2026 13:03:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C691F000FF;
 Thu,  1 Oct 2026 13:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790859814;
 bh=u2bxlgfIDf0Jyo6crFBUa9Oz+4rgTdAA8aLHqy71Mgk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KHDKmt7+eF3IfJUD02mHVfEiuPymtoTIVQs92As/UgJkymnrREV4S9Qy5mcGccOPC
 a/KO/4Dw8PbHx367/yZd+q+BlUBkLQDiLYmHvq9wUGKXt9gPWLAQonxVtLMz2UoeK7
 FKPL8BdT9sCE77TwQE7ontGqHJ1COhU6bc4C5ynIrXYwLKeU6y3z9KIqy3JGY/JzEQ
 2RrfhKCJM/oDUFF1bsezUFaAoCtu/SF6IRczAR1tJ7S2gm4ShEJa8EUcSFqc44rhHb
 foh/DIwraD5zNPMc/il+LOaPYEEk7JxxwDsB+EYZ9BbuN0bt35dRBak+jdTWcS+Co1
 zzaxixQf0ujZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 11/24] drm/atomic: move
 drm_atomic_helper_disable_all() and drm_atomic_helper_shutdown() from
 drm_atomic_helper to drm_atomic
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20261001-drm-bridge-hotplug-v2-11-8e34986dcb68@bootlin.com>
References: <20261001-drm-bridge-hotplug-v2-0-8e34986dcb68@bootlin.com>
 <20261001-drm-bridge-hotplug-v2-11-8e34986dcb68@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 13:03:33 +0000
Message-Id: <20261001130334.07C691F000FF@smtp.kernel.org>
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
- [Low] drm: outdated helper function names in drm_atomic documentation
--

commit 1f801641406daea3f9369bcd8c55bd29b23f3328
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/atomic: move drm_atomic_helper_disable_all() and drm_atomic_helper_shut=
down() from drm_atomic_helper to drm_atomic

This patch moves drm_atomic_helper_shutdown() and its callee
drm_atomic_helper_disable_all() from the drm_kms_helper module to the drm
module, renaming them to drm_atomic_shutdown() and drm_atomic_disable_all().
The original functions are kept as deprecated wrappers to avoid a module
dependency loop.

> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 9bb761eda59f4..ec7a0f369c8b0 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -2081,6 +2081,121 @@ int __drm_atomic_helper_set_config(struct drm_mod=
e_set *set,

[ ... ]

> + * Note that if callers haven't already acquired all modeset locks this =
might
> + * return -EDEADLK, which must be handled by calling drm_modeset_backoff=
().
> + *
> + * Returns:
> + * 0 on success or a negative error code on failure.
> + *
> + * See also:
> + * drm_atomic_helper_suspend(), drm_atomic_helper_resume() and
> + * drm_atomic_helper_shutdown().
> + */
> +int drm_atomic_disable_all(struct drm_device *dev,
> +			   struct drm_modeset_acquire_ctx *ctx)

[Severity: Low]
Should this "See also" section refer to the newly renamed
drm_atomic_shutdown() instead of the deprecated
drm_atomic_helper_shutdown() wrapper?

[ ... ]

> +/**
> + * drm_atomic_shutdown - shutdown all CRTC
> + * @dev: DRM device
> + *
> + * This shuts down all CRTC, which is useful for driver unloading. Shutd=
own on
> + * suspend should instead be handled with drm_atomic_helper_suspend(), s=
ince
> + * that also takes a snapshot of the modeset state to be restored on res=
ume.
> + *
> + * This is just a convenience wrapper around drm_atomic_helper_disable_a=
ll(),
> + * and it is the atomic version of drm_helper_force_disable_all().
> + */
> +void drm_atomic_shutdown(struct drm_device *dev)

[Severity: Low]
Does this documentation need to be updated to mention it wraps
drm_atomic_disable_all() instead of the deprecated
drm_atomic_helper_disable_all() function?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-drm-bridge=
-hotplug-v2-0-8e34986dcb68@bootlin.com?part=3D11
