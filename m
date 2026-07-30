Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CAF4C5516D
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 20:13:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E522310E06B;
	Thu, 30 Jul 2026 20:13:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iNNYfDVe";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 397B410E06B
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 20:13:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 168B5600AD;
 Thu, 30 Jul 2026 20:13:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12931F000E9;
 Thu, 30 Jul 2026 20:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785442398;
 bh=2TVFVdI/YNsLjXLNrJiic6aCtcqx9KIJjKc5XdRyKqo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iNNYfDVevAYACSvMd5wZ9oOY5dK87re7/mKfkqywyvpyheTTxIQS+W8AfyGDlhHf3
 dKYhfHQwhOHNYQKLXvoYPHNVireIcmexkNOdpHkxhNXCLKZ59xfrSKsl43ecCKE8nj
 4I47d5IyqNrMqpEjUonlAQRgNe2YaBtF4ZabYOADNKcnPi4ObRQbW+Eis0pPgSQNGf
 edVY3hLjct2voDutDqbw4vFUvf9h+EcZioLFtqVw0WZd6Q1zvd94No5TdOy7WUqhMD
 Avhf5hw18jYn2YJP1SpJaUl2+yOgDi71w1xU7WgTmVO/G0titmDvHB6HGzQrvNPiLM
 T95q7cEKVW01A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] drm/nouveau: Fix cleanup bug in
 nouveau_drm_device_new()
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260730195523.1467423-2-lyude@redhat.com>
References: <20260730195523.1467423-1-lyude@redhat.com>
 <20260730195523.1467423-2-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 20:13:18 +0000
Message-Id: <20260730201318.A12931F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Use-After-Free on DRM driver private data (`struct nouveau_drm`) w=
hen userspace retains file descriptors or GEM objects after the physical de=
vice is unbound.
--

--- Patch [1]: [PATCH v2 1/5] drm/nouveau: Fix cleanup bug in nouveau_drm_d=
evice_new() ---
commit 915c6f6927c7e80b9c5ab3b1a2ff665d1e795afc
Author: Lyude Paul <lyude@redhat.com>

drm/nouveau: Fix cleanup bug in nouveau_drm_device_new()

This commit converts the allocation of struct nouveau_drm to use devres
to simplify the cleanup path.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouv=
eau/nouveau_drm.c
> index 4d1ad718e09b7..9570850656126 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
[ ... ]
> @@ -740,17 +739,15 @@ nouveau_drm_device_new(const struct drm_driver *drm=
_driver, struct device *paren
>  	struct nouveau_drm *drm;
>  	int ret;
> =20
> -	drm =3D kzalloc_obj(*drm);
> +	drm =3D devm_kzalloc(parent, sizeof(*drm), GFP_KERNEL);

[Severity: High]
This isn't a bug introduced by this patch, but doesn't tying the allocation
of struct nouveau_drm to the physical device's devres lifecycle preserve a
use-after-free condition?

If a user opens the DRM device, allocates a GEM object, and holds onto it
across a device unbind (such as a module unload or hot-unplug), the device
removal will trigger devres cleanup and free this devm_kzalloc'd memory.

Later, when the user drops the last reference to the GEM object, the DRM co=
re
cleans it up and eventually calls nouveau_gem_object_del(). This function
derives the nouveau_drm pointer from the GEM object's embedded TTM buffer
object and dereferences it, accessing the freed memory. TTM core functions
will also access the dangling ttm_device embedded in the freed nouveau_drm
struct.

Would it be safer to use drmm_kzalloc() here so the driver-private data liv=
es
exactly as long as the drm_device refcount?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730195523.1467=
423-1-lyude@redhat.com?part=3D1
