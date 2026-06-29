Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB339C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 06:43:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D112E10E036;
	Mon, 29 Jun 2026 06:43:43 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 076DD10E036
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 06:43:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B1D73400D8;
 Mon, 29 Jun 2026 06:43:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB8B1F00A3A;
 Mon, 29 Jun 2026 06:43:42 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/vmwgfx: Fix NULL vs error pointer bug in
 vmw_prime_import_sg_table()
To: "Dan Carpenter" <error27@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <akIR3WlKLCiCTb5T@stanley.mountain>
References: <akIR3WlKLCiCTb5T@stanley.mountain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 06:43:12 +0000
Message-Id: <20260629064342.7FB8B1F00A3A@smtp.kernel.org>
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
- [High] The error path unconditionally returns ERR_PTR(-ENOMEM), masking t=
he actual error code from vmw_bo_create().
--

commit 97833dd848667c1ef6ccc7587272c584beab9fb5
Author: Dan Carpenter <error27@gmail.com>

drm/vmwgfx: Fix NULL vs error pointer bug in vmw_prime_import_sg_table()

The patch changes the initial value of gem in vmw_prime_import_sg_table()
from NULL to ERR_PTR(-ENOMEM) to prevent a NULL pointer dereference in the
caller when vmw_bo_create() fails.

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c b/drivers/gpu/drm/vmwgfx=
/vmwgfx_gem.c
> index 39f8c46550c27..f25db04f87778 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
> @@ -184,7 +184,7 @@ struct drm_gem_object *vmw_prime_import_sg_table(stru=
ct drm_device *dev,
>  {
>  	int ret;
>  	struct vmw_private *dev_priv =3D vmw_priv(dev);
> -	struct drm_gem_object *gem =3D NULL;
> +	struct drm_gem_object *gem =3D ERR_PTR(-ENOMEM);

[Severity: High]
This is a pre-existing issue, but does hardcoding ERR_PTR(-ENOMEM) mask the
actual error returned by vmw_bo_create()?

When vmw_bo_create() fails, it returns an error code in the ret variable:

	ret =3D vmw_bo_create(dev_priv, &params, &vbo);
	if (ret !=3D 0)
		goto out_no_bo;

Since gem is initialized to ERR_PTR(-ENOMEM) and never updated with ret bef=
ore
jumping to out_no_bo, the actual error code is permanently lost.

If vmw_bo_create() is interrupted by a signal and returns -ERESTARTSYS,
masking it with -ENOMEM breaks the kernel's signal handling and syscall
restart mechanism. This could potentially cause unexpected failures in
userspace applications and compositors.

Could gem be updated to ERR_PTR(ret) in the error path instead?

>  	struct vmw_bo *vbo;
>  	struct vmw_bo_params params =3D {
>  		.domain =3D (dev_priv->has_mob) ? VMW_BO_DOMAIN_SYS : VMW_BO_DOMAIN_VR=
AM,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/akIR3WlKLCiCTb5T@st=
anley.mountain?part=3D1
