Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA8760A380B
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 05:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Aqt2lihx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBF2710E783;
	Thu, 29 Oct 2026 05:33:39 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11AAD10E76D
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 05:33:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BB53D4391E;
 Thu, 29 Oct 2026 05:33:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833981F01825;
 Thu, 29 Oct 2026 05:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793252012;
 bh=e2hIFdCEUlbiS9vTl6d/z5RsRmY01oICqIoEM+92zPo=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=Aqt2lihx3GUSG9lTV0cui5CzGC9Pv7uX5iYVl/SiDOKj/+wsMP1TX/Zl7z2Eebr/n
 tIrxAasqD4iH+d78/jsQi/IqzAA6+v8FfC5kGq1+vOpG293Nc2ivAaKeZkCDm7Y+OA
 hEFIJ5xXNIM01VA9Tuu8z3oawreZCe/wkW1YR7rr3b7P6F+uKESU+LpivOBcRL0Uus
 ZrZXl/qLMgiXR2zRQ/h/Z4440vrVBwefheBqx0GTXQrVpfaxPksxhLjawICYsHNuYg
 yyWOaOnvgg24gzSFFT0CJJkq60nyXLFSEuG3Q9X1z7lJRM4NXYmbmZLQNbvDI+C2T+
 XlqAfcvg1k4pQ==
Message-ID: <sashiko-outbox-188756@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/vmwgfx: Fix use-after-free race in vmw_dumb_create()
To: "Jayapal Ashwin Nair" <jayapalashwin.nair@amd.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <48e6780670395107cc9853bf63fa7ac1d034cdd7.1793249917.git.jayapalashwin.nair@amd.com>
References: <48e6780670395107cc9853bf63fa7ac1d034cdd7.1793249917.git.jayapalashwin.nair@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 05:33:32 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] drm/vmwgfx: use-after-free race in vmw_dumb_create() on ttm_ba=
se_object
--

commit 36be588adb31a9030632708fd24d6fb50dd07914
Author: Jayapal Ashwin Nair <jayapalashwin.nair@amd.com>

drm/vmwgfx: Fix use-after-free race in vmw_dumb_create()

This commit moves drm_gem_object_put(&vbo->tbo.base) after the access to
vbo->dumb_surface and usurf->prime.base.refcount_release in
vmw_dumb_create() to prevent a use-after-free when racing with a concurrent
DRM_IOCTL_GEM_CLOSE.

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vm=
wgfx/vmwgfx_surface.c
> index bd0563741e89d..2dfbd914bdef2 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> @@ -2332,7 +2332,6 @@ int vmw_dumb_create(struct drm_file *file_priv,
>  	vbo =3D res->guest_memory_bo;
>  	vbo->is_dumb =3D true;
>  	vbo->dumb_surface =3D vmw_res_to_srf(res);
> -	drm_gem_object_put(&vbo->tbo.base);
>  	/*
>  	 * Unset the user surface dtor since this in not actually exposed
>  	 * to userspace. The suface is owned via the dumb_buffer's GEM handle
> @@ -2340,6 +2339,7 @@ int vmw_dumb_create(struct drm_file *file_priv,
>  	struct vmw_user_surface *usurf =3D container_of(vbo->dumb_surface,
>  						struct vmw_user_surface, srf);
>  	usurf->prime.base.refcount_release =3D NULL;
> +	drm_gem_object_put(&vbo->tbo.base);
>  err:
>  	if (res)
>  		vmw_resource_unreference(&res);

[Severity: Critical]
Does this still leave a use-after-free race on usurf->prime.base in the
subsequent ttm_ref_object_base_unref() call at the end of vmw_dumb_create()?

drivers/gpu/drm/vmwgfx/vmwgfx_surface.c:vmw_dumb_create() {
    ...
	usurf->prime.base.refcount_release =3D NULL;
	drm_gem_object_put(&vbo->tbo.base);
err:
	if (res)
		vmw_resource_unreference(&res);

	ttm_ref_object_base_unref(tfile, arg.rep.handle);
    ...
}

Under the same concurrent DRM_IOCTL_GEM_CLOSE race on arg.rep.buffer_handle,
after both drm_gem_object_put(&vbo->tbo.base) and drm_gem_close_ioctl() drop
their GEM references on vbo, vmw_gem_object_free() -> ttm_bo_fini() ->
vmw_bo_free() drops the vbo->dumb_surface reference on &usurf->srf.res:

drivers/gpu/drm/vmwgfx/vmwgfx_bo.c:vmw_bo_free() {
    ...
	if (vbo->dumb_surface) {
		WARN_ON(!vbo->is_dumb);
		vmw_surface_unreference(&vbo->dumb_surface);
	}
    ...
}

Once vmw_resource_unreference(&res) and vmw_bo_free() have both dropped the=
ir
references on res->kref, vmw_resource_release() -> vmw_user_surface_free()
queues the entire struct vmw_user_surface (including usurf->prime.base) for
freeing via kfree_rcu():

drivers/gpu/drm/vmwgfx/vmwgfx_surface.c:vmw_user_surface_free() {
    ...
	kfree(srf->offsets);
	kfree(srf->metadata.sizes);
	kfree(srf->snooper.image);
	ttm_prime_object_kfree(user_srf, prime);
}

At that point, usurf->prime.base is still registered in tfile->ref_hash and
tdev->idr. When vmw_dumb_create() then calls
ttm_ref_object_base_unref(tfile, arg.rep.handle) -> ttm_ref_object_release()
-> ttm_base_object_unref() -> ttm_release_base(), it accesses and mutates
usurf->prime.base (including base->refcount, base->handle, base->tfile, and
base->refcount_release) outside RCU protection after kfree_rcu() has already
been invoked on usurf:

drivers/gpu/drm/vmwgfx/ttm_object.c:ttm_ref_object_release() {
    ...
	hash_del_rcu(&ref->hash.head);
	list_del(&ref->head);
	spin_unlock(&tfile->lock);

	ttm_base_object_unref(&ref->obj);
	kfree_rcu(ref, rcu_head);
    ...
}

drivers/gpu/drm/vmwgfx/ttm_object.c:ttm_release_base() {
    ...
	spin_lock(&tdev->object_lock);
	idr_remove(&tdev->idr, base->handle);
	spin_unlock(&tdev->object_lock);
    ...
	ttm_object_file_unref(&base->tfile);
	if (base->refcount_release)
		base->refcount_release(&base);
}

Should ttm_ref_object_base_unref(tfile, arg.rep.handle) be called before
dropping the references via drm_gem_object_put(&vbo->tbo.base) and
vmw_resource_unreference(&res) so that usurf cannot be freed until after its
ttm_base_object is unreferenced?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/48e6780670395107cc9=
853bf63fa7ac1d034cdd7.1793249917.git.jayapalashwin.nair@amd.com?part=3D1
