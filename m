Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210EF60A2625
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 16:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aXd1ljZn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49D8910E176;
	Tue,  3 Nov 2026 16:13:39 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBE3010E176
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 16:13:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9B2FD41591;
 Tue,  3 Nov 2026 16:13:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631CE1F00A16;
 Tue,  3 Nov 2026 16:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793722413;
 bh=TPKP6uNBsvTIRWUzkH4W1MBaP4DTcdcWbD/Tmld5/sM=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=aXd1ljZnnLDX5QuKEh40jgoUS17RcZVSr7ULofgqUB1165uGejBjEqTkB6I9jcXIz
 4jZO+NikBRPu6IFr59KssPEqL4cHgiyLlBEqAmGCwHWidbwwvf/bowAg/3HG8PK/BB
 nzcGlgGfjq2LKVftXu9DjRdMb7pMQuYEc0BcRX1YwEGg83nDvomV/hwXlGYkf9iEdx
 NwmizCLJR1bFxS5dYtmR6C163d71C+/T17wme7svynUiKT81qHY2JaVGNbAefvrjX2
 Gwlxmzu6lGx7KI+B7pb+q8lnbtwDn/y135KkBDOecCd6vq0KTE4pwVNhfU17LFuaHI
 G0jNuz8WbTGWA==
Message-ID: <sashiko-outbox-195705@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/gem: Fix and enable CHANGE_HANDLE
To: "David Francis" <David.Francis@amd.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261103155411.3305376-1-David.Francis@amd.com>
References: <20261103155411.3305376-1-David.Francis@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 16:13:32 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/gem: signed int truncation in drm_gem_change_handle_ioctl()
- [Medium] drm/gem: broken PRIME handling in drm_gem_change_handle_ioctl()
--

commit 69ca138819f06e34ad7cfcd2fb35830a526fdf7a
Author: David Francis <David.Francis@amd.com>

drm/gem: Fix and enable CHANGE_HANDLE

This commit updates drm_gem_change_handle_ioctl() to reject a new_handle of=
 0
or equal to the existing handle, adds idr_preload() around idr_alloc(), and
re-enables DRM_IOCTL_GEM_CHANGE_HANDLE in the core DRM ioctl table.

> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 3ce38df7b8b85..6973bf69dd439 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
[ ... ]
> @@ -1040,21 +1027,22 @@ int drm_gem_change_handle_ioctl(struct drm_device=
 *dev, void *data,
>  	if (!drm_core_check_feature(dev, DRIVER_GEM))
>  		return -EOPNOTSUPP;
> =20
> -	/* idr_alloc() limitation. */
> -	if (args->new_handle > INT_MAX)
> -		return -EINVAL;
>  	new_handle =3D args->new_handle;
> =20
> -	if (args->handle =3D=3D new_handle)
> -		return 0;
> +	/* idr_alloc() limitations. */
> +	if (new_handle =3D=3D 0 || new_handle > INT_MAX ||
> +	    args->handle =3D=3D new_handle)
> +		return -EINVAL;
> =20
>  	mutex_lock(&file_priv->prime.lock);
> +	idr_preload(GFP_KERNEL);
>  	spin_lock(&file_priv->table_lock);
> -	ret =3D idr_alloc(&file_priv->object_idr, NULL, new_handle, new_handle =
+ 1,
> -			GFP_NOWAIT);
> +	ret =3D idr_alloc(&file_priv->object_idr, NULL, new_handle,
> +			new_handle + 1, GFP_NOWAIT);

[Severity: High]
Does moving new_handle =3D args->new_handle ahead of the INT_MAX check allow
negative values to bypass validation and trigger a warning in idr_alloc()?

In struct drm_gem_change_handle, args->new_handle is __u32, whereas the loc=
al
variable new_handle in drm_gem_change_handle_ioctl() is a signed int. Moving
the assignment before the bounds check makes new_handle > INT_MAX
tautologically false.

When userspace passes args->new_handle >=3D 0x80000000 (with args->handle !=
=3D
args->new_handle), new_handle wraps to a negative value, passes the check,
and is passed as start to idr_alloc():

lib/idr.c:idr_alloc() {
	if (WARN_ON_ONCE(start < 0))
		return -EINVAL;
}

This reintroduces the warning fixed by commit 12f15d52d38a, and evaluating
new_handle + 1 when args->new_handle =3D=3D INT_MAX also overflows signed i=
nt.
Should new_handle be declared as u32 (or checked against args->new_handle
before assignment)?

> =20
>  	if (ret < 0) {
>  		spin_unlock(&file_priv->table_lock);
> +		idr_preload_end();
>  		goto out_unlock;
>  	}
> =20
> @@ -1062,10 +1050,12 @@ int drm_gem_change_handle_ioctl(struct drm_device=
 *dev, void *data,
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

[Severity: Medium]
With DRM_IOCTL_GEM_CHANGE_HANDLE now enabled in drm_ioctls[], is it safe for
drm_gem_change_handle_ioctl() to read obj->dma_buf and update file_priv->pr=
ime
here?

First, struct drm_gem_object documents that obj->dma_buf is protected by
dev->object_name_lock:

drivers/gpu/drm/drm_prime.c:export_and_register_object() {
	...
	obj->dma_buf =3D dmabuf;
	get_dma_buf(obj->dma_buf);
}

Reading obj->dma_buf under only file_priv->prime.lock can race with another
drm_file exporting the shared object under dev->object_name_lock.

Second, checking if (obj->dma_buf) tests whether the underlying GEM object =
has
an associated dma_buf rather than whether args->handle is registered in this
file's PRIME cache (via drm_prime_lookup_buf_by_handle(&file_priv->prime,
args->handle)). If a client holds a PRIME handle to obj and a second non-PR=
IME
handle to the same obj (for example via GEM_OPEN or MODE_GETFB2), changing =
the
non-PRIME handle will insert a duplicate entry for obj->dma_buf into
file_priv->prime.dmabufs while drm_prime_remove_buf_handle(&file_priv->prim=
e,
args->handle) will be a no-op.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103155411.3305=
376-1-David.Francis@amd.com?part=3D1
