Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0BB8C88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:16:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0563E10FB8C;
	Tue, 15 Sep 2026 11:16:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PXSyXrJF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EED710FB8C
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 11:16:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1C1CD40A4A;
 Tue, 15 Sep 2026 11:16:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2EAF1F000FF;
 Tue, 15 Sep 2026 11:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789470987;
 bh=52i9ah0RO/482wq3RW5QRt1Q9P4u1ioEaCxUnv0CStY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PXSyXrJFnRX5YwM8Kp/DMibluj/rG12SrK7tLXfkkWs4wp+bC9fvPszw2RvJDo+jd
 tuWs8PxxWEwqXg/fB99BGDUKCtc0ocmp9fpN9yjQeV82j9jZ+m14mr9wjY5UIdZiKE
 I5eDTZSruBLvBXzkZYhmz8oTYVrQJjgUERYVnCQ+qoBaTl5YwNTdoU6yWz6pzJYr/Z
 7aoh/dFdn+d2lnAYC1+rS0/L1XsnpscxuuKHcLcKU3WCoB27TfdAevaMgCet69nCcL
 udM6bQ+kPaj5XJGq71Zmzm/fcZ4mFaAf+6sby0IPCkWImMvVbUlc21sDh+ArflWE5E
 1Gk/VFE8esGkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] drm/syncobj: Use scope-based cleanup for
 eventfd_ctx
To: "Bence Csokas" <bence.csokas@arm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260915-efd-autofree-v2-2-06d2c9d1547f@arm.com>
References: <20260915-efd-autofree-v2-0-06d2c9d1547f@arm.com>
 <20260915-efd-autofree-v2-2-06d2c9d1547f@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:16:26 +0000
Message-Id: <20260915111626.D2EAF1F000FF@smtp.kernel.org>
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
- [Medium] cleanup: mixing goto and scope-based cleanup in drm_syncobj_even=
tfd_ioctl
--

commit ff6fd047e86cd28041b0ce12099546c46df110b2
Author: Bence Csokas <bence.csokas@arm.com>

drm/syncobj: Use scope-based cleanup for eventfd_ctx

This patch converts the eventfd context in drm_syncobj_eventfd_ioctl() to
use scope-based cleanup now that eventfd supports it.

> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
> index c23a5de27effa..efc4e8af220c8 100644
> --- a/drivers/gpu/drm/drm_syncobj.c
> +++ b/drivers/gpu/drm/drm_syncobj.c
> @@ -1462,9 +1462,9 @@ int
>  drm_syncobj_eventfd_ioctl(struct drm_device *dev, void *data,
>  			  struct drm_file *file_private)
>  {
> +	struct eventfd_ctx *ev_fd_ctx __free(eventfd) =3D NULL;
>  	struct drm_syncobj_eventfd *args =3D data;
>  	struct drm_syncobj *syncobj;

[ ... ]

> @@ -1490,10 +1490,10 @@ drm_syncobj_eventfd_ioctl(struct drm_device *dev,=
 void *data,
>  	entry =3D kzalloc_obj(*entry);
>  	if (!entry) {
>  		ret =3D -ENOMEM;
> -		goto err_kzalloc;
> +		goto err_fdget;

[Severity: Medium]
Does this mix goto-based error handling and scope-based cleanup within
drm_syncobj_eventfd_ioctl()?

According to include/linux/cleanup.h, the expectation is that usage of
goto and cleanup helpers is never mixed in the same function. All resources
that need cleanup should either be converted to scope-based cleanup, or
none of them.

Leaving the err_fdget label to manually call drm_syncobj_put(syncobj)
while using __free(eventfd) for ev_fd_ctx can lead to confusing resource
ownership and break the expected LIFO teardown ordering.

Could syncobj be converted to use scope-based cleanup as well?

>  	}
>  	entry->syncobj =3D syncobj;
> -	entry->ev_fd_ctx =3D ev_fd_ctx;
> +	entry->ev_fd_ctx =3D no_free_ptr(ev_fd_ctx);
>  	entry->point =3D args->point;
>  	entry->flags =3D args->flags;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-efd-autofr=
ee-v2-0-06d2c9d1547f@arm.com?part=3D2
