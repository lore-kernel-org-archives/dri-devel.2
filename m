Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC1E2CD98CC
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 02:23:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE58A10E2B8;
	Fri, 12 Jun 2026 02:23:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UQAll0/G";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C20210E2B8
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 02:23:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8A41D600AF;
 Fri, 12 Jun 2026 02:23:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EAE1F000E9;
 Fri, 12 Jun 2026 02:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781231019;
 bh=gKjT5WnAis+zm53NTSR8hG84UG6dBB0rW7QUv//kpKk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UQAll0/GvLODUfRhbvjrw8Ht4j3ylycld39YuucbHZklEaGq/MJ3d00Tvbg/THNCl
 nqUB8Cx7MbmO3G1IbNWWIGPBCaEqj/SXeU8Hw7TJVy2geekEyFHT5YMn0c2EYyzqxd
 k9iomBAnywk3CTrXhmZwXliNemqoduz7d4p8o9C83eh/CHeVvNqlN8JDSC/HJ39320
 y/Je6hLhMN0gVXdyyqHO9Rwwc+v/oEGfYa4k+CyEfZh/pnR1LD1VFx1IvJ9v4JWVaq
 hjHzmBo35+78WgovnWpJBImINXQVQbwxXOtn4qqsH31az2cskmTOCoF3lNV30HWwE8
 gLWzxYz1pwAPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] nouveau/gem: reserve the bo in the info ioctl around
 the vma lookup
To: "Dave Airlie" <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260612020658.3176270-1-airlied@gmail.com>
References: <20260612020658.3176270-1-airlied@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 02:23:38 +0000
Message-Id: <20260612022339.26EAE1F000E9@smtp.kernel.org>
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
- [High] Accessing `nvbo->bo.resource->mem_type` and `nvbo->offset` without=
 holding the BO reservation lock can lead to race conditions and a NULL poi=
nter dereference.
--

commit 764469ad454388a56166a4dfcafbe464a44fc502
Author: Dave Airlie <airlied@redhat.com>

nouveau/gem: reserve the bo in the info ioctl around the vma lookup

This commit adds a buffer object reservation lock around the vma lookup
in the non-uvmm path to prevent a use-after-free against the gem close path.

Cc: stable@vger.kernel.org

> diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouv=
eau/nouveau_gem.c
> index 20dba02d6175b..c5a24dff4b69b 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_gem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
> @@ -313,11 +313,20 @@ nouveau_gem_info(struct drm_file *file_priv, struct=
 drm_gem_object *gem,
>  	rep->offset =3D nvbo->offset;

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to access the
buffer object resource right before this section?

In nouveau_gem_info(), when checking the domains, the code dereferences
nvbo->bo.resource:

    else if (nvbo->bo.resource->mem_type =3D=3D TTM_PL_TT)
        rep->domain =3D NOUVEAU_GEM_DOMAIN_GART;
    else
        ...
    rep->offset =3D nvbo->offset;

Because this happens before the newly added ttm_bo_reserve() lock is
acquired, could a concurrent buffer object move or pipeline gutting free
the resource and set bo.resource to NULL?

If so, accessing the memory type without the lock and without a NULL check
could lead to a NULL pointer dereference. Should the reservation be moved
higher up to protect these accesses as well?

>  	if (vmm->vmm.object.oclass >=3D NVIF_CLASS_VMM_NV50 &&
>  	    !nouveau_cli_uvmm(cli)) {
> +		int ret;
> +
> +		ret =3D ttm_bo_reserve(&nvbo->bo, false, false, NULL);
> +		if (ret)
> +			return ret;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612020658.3176=
270-1-airlied@gmail.com?part=3D1
