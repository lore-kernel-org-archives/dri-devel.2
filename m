Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D29C606A33A
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 19:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gC2HHm0Y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8850E1126EA;
	Thu, 19 Nov 2026 19:26:36 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 536A41126EA
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 19:26:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 607D9625A5;
 Thu, 19 Nov 2026 19:26:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44961F000C5;
 Thu, 19 Nov 2026 19:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795116389;
 bh=7ktet8E7tx6WaNlo87kXwRvg7L6PH0mE7IdgLF3vB4M=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=gC2HHm0Y1YAzTIOxKTv7SdK58x+Yi2fEqLjxGROmtdN/3F9eJnOjGsN+OhMnhXORs
 RJyvT+wvvrD4XhGdoHZzk01MrNqE5PdTbblD8fjdSHPlBOBd2yLKr6Gw04usY1PCjW
 v5dOxHQOjFLsVTMyhCV23s6kcuowFKGAYuOygJCxY8zTlz6pZNMJuN9ePClcZFi+uH
 2Xbc2hSrnmfM1srZDzmGHslRUXwBNo6PmI0BCz2k2WuswshjDEsNdlk3mzPJqqbTjE
 NA3bzIsVSKHlqGAlit1vc9uZ4gN2OMTILfbLyCF2qjcdcOGI9ZAMIZGaZCb+bWLhY4
 ofjLzly/WmOKg==
Message-ID: <sashiko-outbox-223878@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/vmwgfx: Fix UAF race between dumb buffer
 creation and surface unref
To: "Jayapal Ashwin Nair" <jayapalashwin.nair@amd.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261119190705.11305-1-jayapalashwin.nair@amd.com>
References: <20261119190705.11305-1-jayapalashwin.nair@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:26:28 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] drm/vmwgfx: race before lookup in vmw_dumb_create() leaks BO
  and causes UAF
- [High] drm/vmwgfx: uncounted guest_memory_bo in vmw_dumb_create()
  allows BO UAF
- [Medium] drm/vmwgfx: race on vbo->is_dumb init and early handle in
  vmw_dumb_create()
--

commit 54040d43ddc198064c68982ed3a1423e38eed16b
Author: Jayapal Ashwin Nair <jayapalashwin.nair@amd.com>

drm/vmwgfx: Fix UAF race between dumb buffer creation and surface unref

This commit takes a counted surface reference for vbo->dumb_surface in
vmw_dumb_create() and leaves the surface TTM base object destructor set so
each owner drops its own reference.

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vm=
wgfx/vmwgfx_surface.c
> index bd0563741e89d..942d2f39332b5 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> +++ b/drivers/gpu/drm/vmwgfx_surface.c

[ ... ]

> @@ -2331,15 +2324,9 @@ int vmw_dumb_create(struct drm_file *file_priv,
> =20
>  	vbo =3D res->guest_memory_bo;
>  	vbo->is_dumb =3D true;
> -	vbo->dumb_surface =3D vmw_res_to_srf(res);
> +	/* Owned by the GEM handle, dropped in vmw_bo_free() */
> +	vbo->dumb_surface =3D vmw_surface_reference(vmw_res_to_srf(res));

[Severity: Medium]
Can concurrent ioctls observe vbo before vbo->is_dumb and vbo->dumb_surface
are initialized?

vmw_gb_surface_define_ext_ioctl() publishes both arg.rep.buffer_handle and
arg.rep.handle before returning to vmw_dumb_create().  A concurrent
DRM_IOCTL_MODE_ADDFB2 on arg.rep.buffer_handle can enter
vmw_user_object_lookup() while vbo->is_dumb is still false (converting the
lookup to a surface and dropping uo->buffer) or after vbo->is_dumb is set
to true while vbo->dumb_surface is still NULL.

Similarly, if another thread retains arg.rep.handle via
DRM_IOCTL_VMW_GB_SURFACE_REF_EXT and the GEM handle is later closed while
vbo is busy, ttm_bo_release() queues vbo for delayed deletion with refcount
0 before vmw_bo_free() clears res->guest_memory_bo.  A concurrent
vmw_gb_surface_reference_internal() can then pass
&srf->res.guest_memory_bo->tbo.base to drm_gem_handle_create() after its
refcount has reached 0.

>  	drm_gem_object_put(&vbo->tbo.base);

[Severity: High]
Does dropping res->guest_memory_bo's GEM reference here allow a
use-after-free on vbo if userspace retains the surface handle and switches
its backup buffer?

Because arg.rep.handle is published as a shareable surface before
ttm_ref_object_base_unref() removes it below, another thread can retain the
surface handle and submit SVGA_3D_CMD_BIND_GB_SURFACE:

CPU0                              CPU1
vmw_dumb_create()
  vmw_gb_surface_define_ext_ioctl()
                                  vmw_surface_handle_reference()
                                    ttm_ref_object_add(tfile, ...)
  drm_gem_object_put(&vbo->tbo.base)
  ...
  ttm_ref_object_base_unref(...)
                                  vmw_execbuf_process()
                                    vmw_cmd_bind_gb_surface()
                                      ...
                                      vmw_resource_unreserve()
                                        vmw_user_bo_unref(
                                          &res->guest_memory_bo)
                                          <-- drops GEM handle's ref,
                                              freeing vbo

res->guest_memory_bo still points to vbo without a counted reference after
drm_gem_object_put(), so switching the surface backup drops the last
reference belonging to args->handle while the GEM handle remains installed
in file_priv->object_idr.

> -	/*
> -	 * Unset the user surface dtor since this in not actually exposed
> -	 * to userspace. The suface is owned via the dumb_buffer's GEM handle
> -	 */
> -	struct vmw_user_surface *usurf =3D container_of(vbo->dumb_surface,
> -						struct vmw_user_surface, srf);
> -	usurf->prime.base.refcount_release =3D NULL;
>  err:
>  	if (res)
>  		vmw_resource_unreference(&res);

[Severity: High]
What happens if DRM_IOCTL_VMW_UNREF_SURFACE destroys arg.rep.handle before
vmw_user_resource_lookup_handle() runs in vmw_dumb_create()?

CPU0                              CPU1
vmw_dumb_create()
  vmw_gb_surface_define_ext_ioctl()
    ...
    vmw_bo_add_detached_resource(vbo, res)
    ttm_prime_object_init(...)
    vmw_resource_unreference(&res)
                                  ttm_ref_object_base_unref()
                                    vmw_user_surface_base_release()
                                      vmw_resource_unreference(&res)
                                        vmw_resource_release()
                                          vmw_user_bo_unref(...)
                                          vmw_user_surface_free()
                                            kfree(user_srf)
  vmw_user_resource_lookup_handle()
    /* returns -EINVAL, jumps to err */
                                  vmw_kms_fb_create()
                                    ...
                                    vmw_bo_surface(vbo)
                                      res->func->res_type
                                        <-- use-after-free

When vmw_user_resource_lookup_handle() fails, the err path does not call
drm_gem_handle_delete(file_priv, arg.rep.buffer_handle).  That leaks
arg.rep.buffer_handle in file_priv->object_idr with vbo->is_dumb still
false and a dangling res pointer in vbo->detached_resources, which
vmw_bo_surface() dereferences when the leaked GEM handle is later passed to
DRM_IOCTL_MODE_ADDFB2 or DRM_IOCTL_PRIME_HANDLE_TO_FD.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119190705.1130=
5-1-jayapalashwin.nair@amd.com?part=3D1
