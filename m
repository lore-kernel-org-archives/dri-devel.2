Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C709CD6E6E
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 19:58:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DA5711A2BB;
	Thu,  4 Jun 2026 19:58:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ETFjJOiF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A45311A2BB
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 19:58:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B854F6001A;
 Thu,  4 Jun 2026 19:58:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546B31F00893;
 Thu,  4 Jun 2026 19:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780603128;
 bh=gJOk7BoRFFnoNCcuaNMXcG63x1aR/efL01GVawW3S6A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ETFjJOiFSbZjeaIIHEAbl9plVjaf2Ew2deUXOUsMbbD3GOiGNZ6d1ZfAY6PjGUO1F
 GpxXfUmPhwyoMo9y8ITPEcPQA8RTO6/2FKhib7wOxpUDqdfeiMLpir3xZF+KcODveu
 pSl/LybPnX3gzA+0YlOtXCqOoEkXV49gwqCKoxKKwdzL0mYxfu4ic1mBnjzoJCEIrX
 dDdrgfgOisS+qsHeiFbwn5O7WuCvSLJiwf0JduD9JC9uO7a7EvUmfKNWS7fcWcFuS2
 rmRajOExbubnur90QOQC5YK66tF+axT6VY9n7U0rKWyDHp4a7zRyViI6AbCkzkS9S6
 6tO+xFAyrvouA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/gem: Try to fix change_handle ioctl, attempt 4
To: "Simona Vetter" <simona.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260604194437.1725314-1-simona.vetter@ffwll.ch>
References: <20260604194437.1725314-1-simona.vetter@ffwll.ch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 19:58:47 +0000
Message-Id: <20260604195848.546B31F00893@smtp.kernel.org>
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
- [High] The ioctl returns 0 on `args->handle =3D=3D args->new_handle` with=
out validating if the handle actually exists in the IDR.
--

commit c59eb6aaceabfd08a4835d7c2c0133017afcb072
Author: Simona Vetter <simona.vetter@ffwll.ch>

drm/gem: Try to fix change_handle ioctl, attempt 4

This commit attempts to fix a race condition in the change_handle ioctl by
reworking the two-stage idr replacement logic and renaming variables for
clarity. It also unifies the object lookup and idr_replace steps and disabl=
es
the ioctl pending testing.

> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index ac751a42db281..55caad80a3503 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
[ ... ]
> @@ -1028,52 +1028,36 @@ int drm_gem_change_handle_ioctl(struct drm_device=
 *dev, void *data,
>  	/* idr_alloc() limitation. */
>  	if (args->new_handle > INT_MAX)
>  		return -EINVAL;
> -	handle =3D args->new_handle;
> -
> -	obj =3D drm_gem_object_lookup(file_priv, args->handle);
> -	if (!obj)
> -		return -ENOENT;
> +	new_handle =3D args->new_handle;
> =20
> -	if (args->handle =3D=3D handle) {
> -		ret =3D 0;
> -		goto out;
> -	}
> +	if (args->handle =3D=3D new_handle)
> +		return 0;

[Severity: High]
Does this new early return skip handle validation?

Previously, drm_gem_object_lookup() was called before this check, returning
-ENOENT if the given handle was invalid. In the new code, if a user passes
a non-existent handle but sets new_handle to the exact same value, the ioctl
will return 0 (success) instead of -ENOENT.=20

Should the handle existence still be verified before returning success here?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604194437.1725=
314-1-simona.vetter@ffwll.ch?part=3D1
