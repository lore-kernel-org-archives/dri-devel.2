Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFFCEC43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 15:13:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AAF110F67D;
	Fri, 26 Jun 2026 15:13:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NCrMIi3l";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A85FE10F67D
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 15:12:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8E44B43215;
 Fri, 26 Jun 2026 15:12:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467241F000E9;
 Fri, 26 Jun 2026 15:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782486779;
 bh=XY2Ljx58VLG1o+LP6f3Y+CoOongkzajIMyhmSCuo4Y0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NCrMIi3lNOyEz9s22iaMr6aaVdLmcf8qYR+1UHuzXp8kB0v0bZdnwkfWRoSYzHDwK
 EqORVemfnTcz5k9UHVQzAo8yl8hkFej60SDV/d/pomICpM96F3AYx7PPeNZW50/vNf
 s8byz36YXMFwUqT2Rdvwvfw0qYT8C4z/3QRUJVDlTup2WilHDONhe90MRxdwsRM/u+
 b4ZZvM53bXFLEuC1NoJ5J3+7H88LqkUmClYva72lxM7JalYnio4sdqPItzLZ8jhOEc
 pksz2hanMZmYwGpxkJkC8F+gyX6PBUM8B5TemwrI4IQ2sUW19SB89zKcXxFsoPANvA
 +oQ3po228rf4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fix: drm/vmwgfx: vmw_simple_resource_create_ioctl: fix
 base object   refcount leak on ttm_base_object_init failure
To: "WenTao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260626150224.49792-1-vulab@iscas.ac.cn>
References: <20260626150224.49792-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 15:12:58 +0000
Message-Id: <20260626151259.467241F000E9@smtp.kernel.org>
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
- [Critical] Type Mismatch / NULL Pointer Dereference in ttm_base_object_un=
ref.
- [High] Double Free / Use-After-Free of vmw_resource on error path.
- [High] IDR Double Remove and Corruption.
--

commit 0e71ac7463131ddc891fdadbc6bca7ae37b5bcac
Author: WenTao Liang <vulab@iscas.ac.cn>

fix: drm/vmwgfx: vmw_simple_resource_create_ioctl: fix base object refcount=
 leak on ttm_base_object_init failure

This commit attempts to fix a refcount leak by adding a call to
ttm_base_object_unref() in the error path of vmw_simple_resource_create_ioc=
tl()
when ttm_base_object_init() fails.

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_simple_resource.c b/drivers/gp=
u/drm/vmwgfx/vmwgfx_simple_resource.c
> index 0d51b45422699..05f0f55441426 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_simple_resource.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_simple_resource.c
> @@ -176,6 +176,7 @@ vmw_simple_resource_create_ioctl(struct drm_device *d=
ev, void *data,
> =20
>  	if (ret) {
>  		vmw_resource_unreference(&tmp);
> +		ttm_base_object_unref(&usimple->base);

[Severity: Critical]
Does this pass the correct pointer type to ttm_base_object_unref()?

ttm_base_object_unref() expects a struct ttm_base_object **, but &usimple->=
base
is a struct ttm_base_object *.

If this compiles, ttm_base_object_unref() will interpret the first 8 bytes =
of
usimple->base as a pointer. Since usimple was allocated with kzalloc(), this
reads as NULL:

drivers/gpu/drm/vmwgfx/ttm_object.c:ttm_base_object_unref() {
	struct ttm_base_object *base =3D *p_base;

	*p_base =3D NULL;

	kref_put(&base->refcount, ttm_release_base);
}

Can this dereference NULL when passing &base->refcount to kref_put()?


[Severity: High]
Does ttm_base_object_init() already clean up its own state on failure,
making this unref call unsafe?

If ttm_base_object_init() fails (for example, in ttm_ref_object_add()), it
cleans up the IDR entry in its error path:

drivers/gpu/drm/vmwgfx/ttm_object.c:ttm_base_object_init() {
    ...
out_err1:
	spin_lock(&tdev->object_lock);
	idr_remove(&tdev->idr, base->handle);
	spin_unlock(&tdev->object_lock);
	return ret;
}

If ttm_base_object_unref() is called afterward, it will trigger
ttm_release_base() which also unconditionally calls idr_remove() for the sa=
me
handle:

drivers/gpu/drm/vmwgfx/ttm_object.c:ttm_release_base() {
    ...
	spin_lock(&tdev->object_lock);
	idr_remove(&tdev->idr, base->handle);
	spin_unlock(&tdev->object_lock);
    ...
}

If another thread successfully allocates an object and receives the same ID=
 in
the window between these two calls, will this corrupt the IDR by deleting t=
he
other thread's valid ID?

>  		goto out_err;
>  	}
> =20
>  	func->set_arg_handle(data, usimple->base.handle);
>  out_err:
>  	vmw_resource_unreference(&res);

[Severity: High]
If the type mismatch above is fixed, will this cause a double free and
use-after-free of the vmw_resource?

When ttm_base_object_unref() drops the refcount to 0, it calls
ttm_release_base(), which invokes the provided release callback
vmw_simple_resource_base_release(). That callback drops a reference on the
embedded vmw_resource, dropping its refcount to 0 and freeing usimple.

However, the error path then proceeds here to the out_err label and
unconditionally calls vmw_resource_unreference(&res) on the already freed
memory.

>  out_ret:
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626150224.4979=
2-1-vulab@iscas.ac.cn?part=3D1
