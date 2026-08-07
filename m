Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C18C2A09B
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 18:46:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6270610E447;
	Fri,  7 Aug 2026 18:46:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="d6lY2MFg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4512F10E447
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 18:46:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4C7E5409CD;
 Fri,  7 Aug 2026 18:46:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D601F000E9;
 Fri,  7 Aug 2026 18:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786128374;
 bh=xNjv+bSzXK91TcwNUFRoo1yub9RPymkqxKBSRAWo8qs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=d6lY2MFg2b+LuFYiQCWkaq1EpxKHtzuOr4r0mNw4e2y92bXGHCGFLpoq3fb3J1ADu
 yC+hbiD7pkiR+bpCF27tKGqnbafFqK3zJxij4o7rKImBvYiKyIXOS2R/fPAfLszB/7
 rB8Bph8yM7OPFgWwUa0THxzUnsIPtxb8br4wBO5D2XOIyE/9tcQDhshLi356SmoTGO
 jgcyTPBhn95ejGWfGKr5hUhdPHCIZc0jeYn2l9dWN7v+o5XQheD3EVT8DjdjYo+NoF
 KUU+8YZrkzZJKrChyOpyg/NgpDkBRnpMMWLjgPOEyRSuH08ZvbOMWuUdyCFyf9R82B
 E7u/2pP8ZvgqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/gem: Fix and enable CHANGE_HANDLE
To: "David Francis" <David.Francis@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260807183735.1019040-1-David.Francis@amd.com>
References: <20260807183735.1019040-1-David.Francis@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 18:46:12 +0000
Message-Id: <20260807184613.F1D601F000E9@smtp.kernel.org>
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
- [Critical] Missing idr_preload_end() in the idr_alloc error path leaves p=
reemption permanently disabled.
--

--- Patch [1]: [PATCH] drm/gem: Fix and enable CHANGE_HANDLE ---
commit 4926fe37208872dd7c9115003f10226cea7a200a
Author: David Francis <David.Francis@amd.com>
drm/gem: Fix and enable CHANGE_HANDLE

This patch enables the CHANGE_HANDLE ioctl for GEM and adds validation
for the handle inputs. It also adds idr_preload before idr_alloc to
ensure memory allocation can be fulfilled without sleeping while holding
a spinlock.

> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 018df97d590dc..00693626d7683 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
[ ... ]
> @@ -1038,14 +1025,22 @@ int drm_gem_change_handle_ioctl(struct drm_device=
 *dev, void *data,
[ ... ]
>  	mutex_lock(&file_priv->prime.lock);
> +	idr_preload(GFP_KERNEL);
>  	spin_lock(&file_priv->table_lock);
>  	ret =3D idr_alloc(&file_priv->object_idr, NULL, new_handle, new_handle =
+ 1,
>  			GFP_NOWAIT);
> @@ -1059,10 +1054,12 @@ int drm_gem_change_handle_ioctl(struct drm_device=
 *dev, void *data,

[Severity: Critical]
Does this error path leave preemption permanently disabled?

Looking at the code just after idr_alloc() in drm_gem_change_handle_ioctl(),
there is an error path that skips idr_preload_end():

	ret =3D idr_alloc(&file_priv->object_idr, NULL, new_handle, new_handle + 1,
			GFP_NOWAIT);

	if (ret < 0) {
		spin_unlock(&file_priv->table_lock);
		goto out_unlock;
	}

If idr_alloc() fails (for example, returning -ENOSPC when new_handle is
already in use), the code jumps to out_unlock which only releases prime.lock
and returns. Since idr_preload() disables preemption, wouldn't we need an
idr_preload_end() call before returning to avoid a scheduling while atomic
system panic?

>  	if (IS_ERR_OR_NULL(obj)) {
>  		idr_remove(&file_priv->object_idr, new_handle);
>  		spin_unlock(&file_priv->table_lock);
> +		idr_preload_end();
>  		ret =3D -ENOENT;
>  		goto out_unlock;
>  	}
>  	spin_unlock(&file_priv->table_lock);
> +	idr_preload_end();
> =20
>  	if (obj->dma_buf) {
>  		ret =3D drm_prime_add_buf_handle(&file_priv->prime, obj->dma_buf,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807183735.1019=
040-1-David.Francis@amd.com?part=3D1
