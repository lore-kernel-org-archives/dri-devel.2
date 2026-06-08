Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A4FCD6E79
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 03:37:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81F7510EC87;
	Mon,  8 Jun 2026 03:37:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gHHPe393";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ADDD10EC87
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 03:37:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 38C4A44014;
 Mon,  8 Jun 2026 03:37:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB99D1F00893;
 Mon,  8 Jun 2026 03:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780889867;
 bh=0FY8Tk0Fh+TvMcEi/z71TM5M4DzNdGSxC7tOe/9mHws=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gHHPe393N8Dwbse7A4jf/J18CfaZyyHJE1WAkUlA9yttff7AYA1zgX5azOMrJGx6Y
 WzBoxa8KRTEFpIx7whfHsizEA6azSNLFUYP4bRPLnhR82xzQNi3CoQhTb9cnfDfBYN
 WNKEN59Hl2Y9UbqvnnE4zn6tz4EUS4uCPk3noxps5a2L4L1ro41+V7x+Y9izM1K3+k
 vzfpZVFLjfxHRo/M1fel8CwSHSWkLIoK8E/vWpExQymZB4A83Cp07iu5uvDai4nx5H
 Hjj7N7KddELBbei4GaKpZmmGV5yNpWHE09dLw/A6s9c+PfMX+zQxYtZdzuPISd5obX
 ynbftp3nJE47w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/vmwgfx: fix ttm_base_object refcount leak in
 vmw_buffer_prime_to_surface_base()
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260608032739.111055-1-vulab@iscas.ac.cn>
References: <20260608032739.111055-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 03:37:46 +0000
Message-Id: <20260608033746.DB99D1F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Uninitialized variable dereference leading to kernel panic on =
the error path.
- [Critical] Double-put / Use-After-Free on the success path due to droppin=
g a reference expected by the caller.
--

commit 6c286ae1f64531ad67606db48092510b8d2a64d9
Author: Wentao Liang <vulab@iscas.ac.cn>

drm/vmwgfx: fix ttm_base_object refcount leak in vmw_buffer_prime_to_surfac=
e_base()

This patch attempts to fix a reference leak where the reference returned by
vmw_lookup_user_surface_for_buffer() was not properly dropped. It adds a ca=
ll
to ttm_base_object_unref() at the error handling out label.

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vm=
wgfx/vmwgfx_surface.c
> index b2d3927b55673..9e63846fd6630 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> @@ -972,6 +972,7 @@ static int vmw_buffer_prime_to_surface_base(struct vm=
w_private *dev_priv,
> =20
>  	*base_p =3D base;
>  out:
> +	ttm_base_object_unref(&base);

[Severity: Critical]
Does this code dereference an uninitialized pointer when
vmw_lookup_user_surface_for_buffer() fails?

In vmw_buffer_prime_to_surface_base(), base is declared but not initialized.
If vmw_lookup_user_surface_for_buffer() returns NULL, the code jumps to the
out label:

	user_srf =3D vmw_lookup_user_surface_for_buffer(dev_priv, bo, *handle);
	if (WARN_ON(!user_srf)) {
		drm_warn(&dev_priv->drm,
			 "User surface fd %d (handle %d) is null.\n", fd, *handle);
		ret =3D -EINVAL;
		goto out;
	}

Because base has not been assigned a value before this jump, calling
ttm_base_object_unref(&base) at the out label will dereference an uninitial=
ized
pointer, which could cause a kernel panic.

[Severity: Critical]
Will dropping the reference here cause a double-put or use-after-free on the
success path?

On the success path, the resolved base object is assigned to *base_p:

	*base_p =3D base;

If the reference is unconditionally unreferenced at the out label, the obje=
ct
returned to the caller (e.g. vmw_surface_reference_ioctl) will have already
lost the reference.

Since the caller expects to own this temporary reference and drop it
themselves, wouldn't dropping it here result in a double-put when the caller
eventually calls ttm_base_object_unref() on the returned object?

>  	vmw_user_bo_unref(&bo);
> =20
>  	return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608032739.1110=
55-1-vulab@iscas.ac.cn?part=3D1
