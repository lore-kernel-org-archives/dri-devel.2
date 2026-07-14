Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA061C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 13:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27E9F10ED4A;
	Tue, 14 Jul 2026 13:33:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jO4w0S9c";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 894D410ED4A
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 13:33:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0AEB041447;
 Tue, 14 Jul 2026 13:33:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B131F000E9;
 Tue, 14 Jul 2026 13:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784036032;
 bh=6zwXgUreFNnTjMPfZryW3YAmMf4iVgde3awU78MMx0M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jO4w0S9cZMfPylLvlTEVKFSzJn0W7TNN2QQEykI7zqgWqpm5aV1BnWKAk9oRTf4dj
 XnzlaMsElhd3Vlh4fMT1DMF484Zp9wwYCW/xfgbYgfJh9L6kAqSJDjLItrxBpUS4+F
 5AF33tghjVuT+5v/+InGyKzjiPKhCx2AvpkekOP4nx/a69h+mc6NDlf+nAcEQZsJTY
 4t7V5Wt32w8DADJzJCeUNnCGnJtHA+4FjC4FzyEji+kcvyVqRjgb7qkLb/bvLe4Kml
 pJX2CLL1bliPiuXTyDq1R8MgnLhJm+XCHkguAoyqxVU4RVkD6WJIWPO3zh7KYr2R0f
 Cds7c5LqTLJPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/tegra: Finalize GEM object on initialization failure
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260714131923.1575860-1-lgs201920130244@gmail.com>
References: <20260714131923.1575860-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 13:33:52 +0000
Message-Id: <20260714133352.B8B131F000E9@smtp.kernel.org>
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
- [High] A racing userspace thread can trigger a use-after-free by guessing=
 the GEM handle during creation, leading to premature object destruction.
--

--- Patch [1]: [PATCH] drm/tegra: Finalize GEM object on initialization fai=
lure ---
commit dfc541dc5f8719918460cc54c0dfa389b27272fd
Author: Guangshuo Li <lgs201920130244@gmail.com>

drm/tegra: Finalize GEM object on initialization failure

The commit introduces a call to drm_gem_private_object_fini() on the failur=
e=20
path of drm_gem_object_init() inside tegra_bo_alloc_object() before freeing
the buffer object, ensuring proper cleanup of the partially initialized GEM
object.

> diff --git a/drivers/gpu/drm/tegra/gem.c b/drivers/gpu/drm/tegra/gem.c
> index ace3e5a805cf7..9ce8ecf1a2335 100644
> --- a/drivers/gpu/drm/tegra/gem.c
> +++ b/drivers/gpu/drm/tegra/gem.c
> @@ -312,8 +312,10 @@ static struct tegra_bo *tegra_bo_alloc_object(struct=
 drm_device *drm,
>  	size =3D round_up(size, PAGE_SIZE);
> =20
>  	err =3D drm_gem_object_init(drm, &bo->gem, size);
> -	if (err < 0)
> +	if (err < 0) {
> +		drm_gem_private_object_fini(&bo->gem);
>  		goto free;
> +	}
> =20
>  	err =3D drm_gem_create_mmap_offset(&bo->gem);
>  	if (err < 0)

[Severity: High]
This is a pre-existing issue, but while reviewing this area of the code
I noticed a potential use-after-free in the related
tegra_bo_create_with_handle() function.

If drm_gem_handle_create() fails, the error path unconditionally calls
tegra_bo_free_object():

drivers/gpu/drm/tegra/gem.c:tegra_bo_create_with_handle() {
	...
	err =3D drm_gem_handle_create(file, &bo->gem, handle);
	if (err) {
		tegra_bo_free_object(&bo->gem);
		return ERR_PTR(err);
	}
	...
}

Inside drm_gem_handle_create(), the handle is inserted into the IDR before
secondary operations like drm_vma_node_allow() are checked. If that check
fails, the handle is removed.

During the brief window where the handle is in the IDR, could a racing
userspace thread guess the handle and issue an ioctl (like
DRM_IOCTL_GEM_CLOSE) to look up the object and increment its refcount?

If that happens and tegra_bo_create_with_handle() receives the error, it
appears to ignore the elevated refcount and unconditionally free the object
by calling tegra_bo_free_object(). When the racing thread later calls
drm_gem_object_put(), does this result in dereferencing freed memory?

Would it be safer to use drm_gem_object_put() instead of directly calling
tegra_bo_free_object() here so that the object is only freed when the
racing thread drops its reference?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714131923.1575=
860-1-lgs201920130244@gmail.com?part=3D1
