Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCA6C53209
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 18:50:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC28510E6D8;
	Mon, 27 Jul 2026 18:50:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VcCxQp+s";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECDD310E6D8
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 18:50:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 69F924141B;
 Mon, 27 Jul 2026 18:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7DD1F000E9;
 Mon, 27 Jul 2026 18:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785178204;
 bh=XN+AQZblzTXQOEOaPlayUTnhVJK/Ofl9vQkupe+womU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VcCxQp+suBv2a88jEpFpyYSu2UZhljEL2v343arKNSUXOEg6m+Y+QQnO6EqjMa6YS
 rP+HFtGF7x8ofMQiZzDa3AEnJr7EhTHl6NftBMLXSK1ryNRL8pKPVO1d6K4N1VvLkw
 FHcT/MdDX855kLW88j5EIDKBWv8pzTK+nyDyO30cC4tBw+1zn51+5L/nHgVCsKgdxx
 WtzdqJNNaCJ2lII0wpRSfaT3R6tsNQPZaP3mdL2ZaqiP5ba3Q3eRbcAyBn0Lxz65jV
 Dt8+oN5hVUewokmllpUp491clccAA5imKkRqcI1Qz4KXkAxiV9vHqLK+hVWjYh1G3K
 IcHgvx0KpIpEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/4] drm/vmwgfx: Change ttm refs for dumb buffers.
To: "Maaz Mombasawala" <maaz.mombasawala@broadcom.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260727182622.236086-5-maaz.mombasawala@broadcom.com>
References: <20260727182622.236086-1-maaz.mombasawala@broadcom.com>
 <20260727182622.236086-5-maaz.mombasawala@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 18:50:03 +0000
Message-Id: <20260727185004.2C7DD1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Critical] Artificial pinning of the base object causes a reliable Use-Af=
ter-Free.
- [High] Refcount underflow and potential use-after-free because `ttm_base_=
object_lookup_for_ref` return value is ignored.
- [Medium] Leaked mutex state due to bypassing `ttm_prime_refcount_release`.

Pre-existing issues:
- [High] Race condition causing Use-After-Free due to premature `drm_gem_ob=
ject_put`.
--

--- Patch [4]: [PATCH v6 4/4] drm/vmwgfx: Change ttm refs for dumb buffers.=
 ---
commit 1eb9390d984c556a9fb59cfdc777988b3f118fac
Author: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

drm/vmwgfx: Change ttm refs for dumb buffers.

This commit preserves a reference to the surface during dumb buffer creation
to keep the dumb buffer valid for framebuffer usage. This fixes IGT tests
that use dumb buffers.

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vm=
wgfx/vmwgfx_surface.c
> index bd0563741e89d..74e11baa7095f 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> @@ -2340,11 +2340,21 @@ int vmw_dumb_create(struct drm_file *file_priv,
>  	struct vmw_user_surface *usurf =3D container_of(vbo->dumb_surface,
>  						struct vmw_user_surface, srf);

[Severity: High]
This is a pre-existing issue, but can accessing vbo->dumb_surface here
lead to a use-after-free?

Looking at vmw_dumb_create(), the vbo reference is dropped slightly
earlier via drm_gem_object_put(). If a concurrent thread guesses the
gem handle and closes it, the final reference could be dropped. This
would free vbo before this container_of() calculation and assignment occur.

>  	usurf->prime.base.refcount_release =3D NULL;

[Severity: Medium]
Does setting the release callback to NULL bypass
ttm_prime_refcount_release() and leak the prime object's mutex?

This appears to prevent explicitly destroying the mutex, which can
trigger warnings when kernel mutex debugging is enabled.

> +	ttm_base_object_lookup_for_ref(dev_priv->tdev, arg.rep.handle);

[Severity: High]
Can this lookup fail if a concurrent thread guesses the sequential IDR
handle and calls the unref surface ioctl?

If the lookup fails and returns NULL, the internal reference is not
acquired. Because the return value is ignored here, the unconditional
unref later in vmw_dumb_surface_unref() might cause a kref underflow.

>  err:
>  	if (res)
>  		vmw_resource_unreference(&res);
> -
>  	ttm_ref_object_base_unref(tfile, arg.rep.handle);
> =20
>  	return ret;
>  }
> +
> +void vmw_dumb_surface_unref(struct vmw_surface **dumb_surface)
> +{
> +	struct vmw_user_surface *usurf =3D container_of(*dumb_surface,
> +						struct vmw_user_surface, srf);
> +	struct ttm_base_object *base =3D &usurf->prime.base;
> +
> +	ttm_base_object_unref(&base);
> +	vmw_surface_unreference(dumb_surface);

[Severity: Critical]
Does setting refcount_release to NULL earlier and decoupling the base
object lifecycle from the underlying resource create a use-after-free
regression here?

If userspace concurrently grabs an extra reference to the surface via
the ref surface ioctl, the base object's refcount is incremented.
When the gem handle is later closed, ttm_base_object_unref() drops one
reference, leaving the refcount > 0.

However, vmw_surface_unreference() unconditionally drops the resource
refcount to 0, which frees the usurf object containing the base object.
The base object would remain in the IDR tree, and later accesses to it
would use freed memory.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727182622.2360=
86-1-maaz.mombasawala@broadcom.com?part=3D4
