Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CD9C5DF6D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 09:29:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A7BB10E100;
	Wed, 19 Aug 2026 09:29:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eiULWlNa";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8FCC10E100
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 09:29:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F105D6020E;
 Wed, 19 Aug 2026 09:29:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A911F000E9;
 Wed, 19 Aug 2026 09:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787131779;
 bh=l/64QleNXL8U2oyROv6c0r90kSn9j9tzILBvtv/FTco=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eiULWlNazG0cYyP9Nrd9iidhBWUo7iv8HwPFqzCAdhEJnAduCtTt6dVlTQMOhXHOo
 mPeU2JdxYa21mHeRtMCNwuZxah/AHPTZGH/n4YdXEpqWSaVv68FsttueEZ1VKtPRlu
 5fpoV+HspIy2wv4hE1fGdl+q+K3Bi/+kOQIxM4iVBjs17VxPChUbotkNAJfC9Blm15
 EEQeFRrtmi65eyl4EZj938Ub5nGtZ6xrP5YZ2eB9Nss7QKktlVoN/1R6pojp8+I4G2
 +72/owJeCPPuXCuNHyiYeho9+KQAzZczgRkRHxtfdlNNwjQfZck+YbvHeVtbHZA69e
 2FSSb/HFbe+0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/nouveau/nv04: check cursor buffer object size
 before upload
To: "Zhenhao Wan" <whi4ed0g@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260819-nouveau-nv04-cursor-oob-v2-1-63eb8d0c847f@gmail.com>
References: <20260819-nouveau-nv04-cursor-oob-v2-1-63eb8d0c847f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 09:29:39 +0000
Message-Id: <20260819092939.89A911F000E9@smtp.kernel.org>
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
- [High] Concurrent calls to `nv04_crtc_cursor_set` sharing the same cursor=
 GEM object corrupt `nvbo->kmap`, causing a memory leak and NULL pointer de=
reference.
--

--- Patch [1]: [PATCH v2] drm/nouveau/nv04: check cursor buffer object size=
 before upload ---
commit c56f9068ff05cc5ffb036fafee41018786a585b4
Author: Zhenhao Wan <whi4ed0g@gmail.com>

drm/nouveau/nv04: check cursor buffer object size before upload

This patch adds a bounds check to the cursor buffer object in=20
nv04_crtc_cursor_set before mapping it to prevent an out-of-bounds read
when an undersized gem object is supplied.

Link: https://patch.msgid.link/20260813-nouveau-nv04-cursor-oob-v1-1-3f3eb3=
7d213d@gmail.com

> diff --git a/drivers/gpu/drm/nouveau/dispnv04/crtc.c b/drivers/gpu/drm/no=
uveau/dispnv04/crtc.c
> --- a/drivers/gpu/drm/nouveau/dispnv04/crtc.c
> +++ b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
[ ... ]
> @@ -1000,6 +1000,11 @@ nv04_crtc_cursor_set(struct drm_crtc *crtc, struct=
 drm_file *file_priv,
>  		return -ENOENT;
>  	cursor =3D nouveau_gem_object(gem);
> =20
> +	if (gem->size < array3_size(width, height, 4)) {
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +
>  	ret =3D nouveau_bo_map(cursor);

[Severity: High]
This is a pre-existing issue, but does this code handle concurrent
cursor updates safely when the same cursor gem object is used?

If a process assigns the same cursor gem object to two different crtcs
concurrently, the drm core handles the ioctls concurrently since it only
locks each crtc->mutex individually. Both threads would look up the same
nouveau_bo and call nouveau_bo_map() concurrently.

Looking at nouveau_bo_map(), the kernel mapping is written to the shared
nvbo->kmap struct, and the lock is dropped:

drivers/gpu/drm/nouveau/nouveau_bo.c:nouveau_bo_map() {
	ret =3D ttm_bo_reserve(&nvbo->bo, false, false, NULL);
	...
	ret =3D ttm_bo_kmap(&nvbo->bo, 0, PFN_UP(nvbo->bo.base.size), &nvbo->kmap);

	ttm_bo_unreserve(&nvbo->bo);
	return ret;
}

If two threads execute this concurrently, the second thread overwrites the
first thread's mapping, which leaks the virtual memory area.

When the first thread finishes uploading its cursor data, it calls
nouveau_bo_unmap():

drivers/gpu/drm/nouveau/nouveau_bo.c:nouveau_bo_unmap() {
	...
	ttm_bo_kunmap(&nvbo->kmap);
	...
}

This clears nvbo->kmap.virtual to NULL without taking any locks. When the
second thread attempts to read pixel data via nouveau_bo_rd32() during its
own upload phase, wouldn't it fetch the NULL pointer and dereference it?

>  	if (ret)
>  		goto out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-nouveau-nv=
04-cursor-oob-v2-1-63eb8d0c847f@gmail.com?part=3D1
