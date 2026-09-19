Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC9FC982CC
	for <dri-devel@archiver.kernel.org>; Sat, 19 Sep 2026 23:01:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 073C110E7C7;
	Sat, 19 Sep 2026 23:01:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W+7mnk31";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0A0910E869
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 23:01:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1BE3B601FB;
 Sat, 19 Sep 2026 23:01:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C3821F000FF;
 Sat, 19 Sep 2026 23:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789858873;
 bh=kpWCk1WP70MwykY5q2H2SANz3dFaV8/xllMOsiuRziA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=W+7mnk31y2umjaIn5o8C76hq9S7fGkh/Y31Pj5GsDAojIsw3lvLwjjSQiQXdYaWCd
 TZRFf3VbCzwRe2wwLfZtPv85blPntnCzalsfbHRPAaMqRZtShejTotdQSuFCv0rXlb
 GlFYi7GzrdUX6OVznZ9zvQLmYKnx3dj0GETb97EDFx8xK4WGedP70w1LOmhwWmFm6R
 /1nEdR6jtzB+fh9QL16kCs0RY9pWCRG6J9yH/p5/EYVrgTw0qtxz0gGyJnvjm7NS5l
 NzzrCpoKaau7m7fHDFjML45+jLfAds8+ryHG0RNs2SPj0lkBR7Il3I23kyvbPMpF4u
 qxePr6k/bSMkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/vmwgfx: fix surface size overflow, execbuf bounds,
 and cursor/msg leaks
To: "Hui Peng" <benquike@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260919223441.3884374-1-benquike@gmail.com>
References: <20260919223441.3884374-1-benquike@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 23:01:13 +0000
Message-Id: <20260919230113.9C3821F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] drm/vmwgfx: Unconditional handle deletion destroys user GEM handles
- [High] drm/vmwgfx: UAF when dereferencing task_pgrp() without RCU read lo=
ck
- [Low] drm/vmwgfx: Redundant bounds checks duplicate existing logic
--

commit 6aae9fde1f923607d6ff8a6e9acd96d7a0082c2d
Author: Hui Peng <benquike@gmail.com>

drm/vmwgfx: fix surface size overflow, execbuf bounds, and cursor/msg leaks

This commit fixes multiple integer overflows, out-of-bounds accesses, and
resource leaks across drivers/gpu/drm/vmwgfx/.

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vm=
wgfx/vmwgfx_execbuf.c
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> @@ -1511,6 +1511,10 @@ static int vmw_cmd_dma(struct vmw_private *dev_pri=
v,
> =20
>  	cmd =3D container_of(header, typeof(*cmd), header);
> =20
> +	if (unlikely(header->size < sizeof(cmd->body) + sizeof(*suffix))) {
> +		VMW_DEBUG_USER("Invalid DMA command size.\n");
> +		return -EINVAL;
> +	}

[Severity: Low]
Is this duplicate check in vmw_cmd_dma() intentional? The exact same
condition for the header size is verified immediately below this block,
making this new check redundant.

>  	if (unlikely(header->size < sizeof(cmd->body) + sizeof(*suffix))) {
>  		VMW_DEBUG_USER("Illegal SVGA_3D_CMD_SURFACE_DMA size.\n");
>  		return -EINVAL;
>  	}

[ ... ]

> @@ -1572,6 +1576,10 @@ static int vmw_cmd_draw(struct vmw_private *dev_pr=
iv,
>  	VMW_DECLARE_CMD_VAR(*cmd, SVGA3dCmdDrawPrimitives);
>  	SVGA3dVertexDecl *decl =3D (SVGA3dVertexDecl *)(
>  		(unsigned long)header + sizeof(*cmd));
> +	if (unlikely(header->size < sizeof(cmd->body))) {
> +		VMW_DEBUG_USER("Draw command size too small.\n");
> +		return -EINVAL;
> +	}

[Severity: Low]
Could we remove this duplicate check? We do the exact same verification
a few lines lower in vmw_cmd_draw() right after retrieving the command
body with container_of.

>  	SVGA3dPrimitiveRange *range;
>  	uint32_t i;
>  	uint32_t maxnum;
>  	int ret;
>=20
>  	cmd =3D container_of(header, typeof(*cmd), header);
>=20
>  	if (unlikely(header->size < sizeof(cmd->body))) {

[ ... ]

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c b/drivers/gpu/drm/vmwgfx=
/vmwgfx_msg.c
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
> @@ -1045,7 +1046,7 @@ int vmw_mksstat_add_ioctl(struct drm_device *dev, v=
oid *data,
>  	hypervisor_ppn_add((PPN64)page_to_pfn(page));
> =20
>  	dev_priv->mksstat_user_pages[slot] =3D page;
> -	atomic_set(&dev_priv->mksstat_user_pids[slot], task_pgrp_vnr(current));
> +	atomic_set(&dev_priv->mksstat_user_pids[slot], pid_nr(task_pgrp(current=
)));

[Severity: High]
Can this sequence cause a use-after-free? The function task_pgrp() returns
an RCU protected pointer, but it looks like we are calling pid_nr() here
without holding the rcu_read_lock.

If a concurrent sys_setpgid() changes the process group and drops the
reference to the old pid structure, and this thread is preempted right
before pid_nr() executes, could the RCU grace period expire and free the
pointer before we dereference it?

>  	arg->id =3D slot;

[ ... ]

> @@ -1104,7 +1105,7 @@ int vmw_mksstat_remove_ioctl(struct drm_device *dev=
, void *data,
> =20
>  	DRM_DEV_INFO(dev->dev, "pid=3D%d arg.id=3D%zu\n", current->pid, slot);
> =20
> -	pgid =3D task_pgrp_vnr(current);
> +	pgid =3D pid_nr(task_pgrp(current));

[Severity: High]
Does this have the same RCU protection issue as in vmw_mksstat_add_ioctl()?
We are dereferencing the task_pgrp() return value outside of an RCU read
lock.

>  	pid =3D atomic_cmpxchg(&dev_priv->mksstat_user_pids[slot], pgid, MKSSTA=
T_PID_RESERVED);

[ ... ]

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vm=
wgfx/vmwgfx_surface.c
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> @@ -967,12 +979,14 @@ static int vmw_buffer_prime_to_surface_base(struct =
vmw_private *dev_priv,
>  	if (ret) {
>  		drm_warn(&dev_priv->drm,
>  			 "Couldn't add an object ref for the buffer (%d).\n", *handle);
> +		ttm_base_object_unref(&base);
>  		goto out;
>  	}
> =20
>  	*base_p =3D base;
>  out:
>  	vmw_user_bo_unref(&bo);
> +	drm_gem_handle_delete(file_priv, *handle);
> =20
>  	return ret;
>  }

[Severity: High]
Could this unconditional handle deletion destroy a GEM handle that is activ=
ely
owned by userspace?

The function drm_gem_prime_fd_to_handle() will return an existing handle
if the userspace process previously imported the fd. By unconditionally cal=
ling
drm_gem_handle_delete() on both the success and error paths in
vmw_buffer_prime_to_surface_base(), the handle is permanently removed from
the object IDR table.

If the userspace application continues using the handle after this call,
might this revoke access or cause a use-after-free if the ID is recycled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919223441.3884=
374-1-benquike@gmail.com?part=3D1
