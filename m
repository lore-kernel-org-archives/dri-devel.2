Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23722CD6E79
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 02:37:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3944010E049;
	Tue,  9 Jun 2026 02:37:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lw4+Zsyp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E59810E049
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 02:37:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5C339601E1;
 Tue,  9 Jun 2026 02:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31E41F00893;
 Tue,  9 Jun 2026 02:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780972675;
 bh=K/xviIOsOoa+ViTLTeUQa4MmyW2gCwLfWnJ6goHuYnk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lw4+ZsypjzSraVLeurHOGxs7dXHZKGeD96gRFNKQzn/rzBVHqCHwJT1YHpifyKxGS
 LTi/zDQ+JL3j8MyxGwE0IGsgeG1vDe+vk3qyVNpVNj13eFShwdHxV6FXu1scCKpedm
 I3vgiJ48/xY9xmifebN29pOXnMKHF9P+ylUAPEe53EjVUkxFpCDrS7ksJNJ+8uWY8k
 3KllfDOMeJ0Mzilii7qnZeaf+sB2I9rfJ9FmXfMv+DC1tJHnr3PXliJE1DaRsdmfzR
 2Q9UlTG+1mbNtzgYj1KZnoMNWcEJj+6NIYJ4nl3JZAgA2RgRYnLun+0JX6uWXo40XY
 DzB90Yy/fVVtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/gem: Fix resource leaks in
 drm_gem_huge_mnt_create() error paths
To: yaolu@kylinos.cn
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609022504.65722-1-yaolu@kylinos.cn>
References: <20260609022504.65722-1-yaolu@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 02:37:54 +0000
Message-Id: <20260609023754.F31E41F00893@smtp.kernel.org>
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
- [Critical] drm_gem_huge_mnt_create() leaves an ERR_PTR or a freed pointer=
 in dev->huge_mnt on failure, leading to cascading failures or Use-After-Fr=
ee during GEM object creation.
--

commit 7e7660e13d434072f394d83fe8c601ac0c32b376
Author: Lu Yao <yaolu@kylinos.cn>

drm/gem: Fix resource leaks in drm_gem_huge_mnt_create() error paths

This commit fixes two resource leaks in the error handling paths of
drm_gem_huge_mnt_create() by releasing the filesystem type reference and
the fs_context allocated for the mount.

> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index e3ed684ddcf29..6f0751d668ad9 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
[ ... ]
> @@ -122,19 +122,24 @@ int drm_gem_huge_mnt_create(struct drm_device *dev,=
 const char *value)
[ ... ]
>  	ret =3D vfs_parse_fs_string(fc, "huge", value);
>  	if (unlikely(ret))
> -		return -ENOPARAM;
> +		goto err;
> =20
>  	dev->huge_mnt =3D fc_mount_longterm(fc);
>  	put_fs_context(fc);
> =20
>  	return drmm_add_action_or_reset(dev, drm_gem_huge_mnt_free, NULL);

[Severity: Critical]
This is a pre-existing issue, but does this leave an invalid pointer in
dev->huge_mnt on failure?

If fc_mount_longterm() fails and returns an ERR_PTR, it gets unconditionally
assigned to dev->huge_mnt. If drmm_add_action_or_reset() then succeeds,
drm_gem_get_huge_mnt() will later return this ERR_PTR. This bypasses the NU=
LL
check in drm_gem_object_init() and causes shmem_file_setup_with_mnt() to fa=
il
for subsequent allocations.

Additionally, if drmm_add_action_or_reset() fails, it triggers its cleanup
action drm_gem_huge_mnt_free(), which calls kern_unmount(dev->huge_mnt).
However, dev->huge_mnt is not reset to NULL. Later, drm_gem_object_init()
could pass this freed pointer to shmem_file_setup_with_mnt(), resulting in
a use-after-free.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609022504.6572=
2-1-yaolu@kylinos.cn?part=3D1
