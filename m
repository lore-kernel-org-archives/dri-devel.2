Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B2EC43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 15:14:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43DB710E635;
	Sun, 28 Jun 2026 15:14:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Cbg9qAS6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5E7810E635
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 15:14:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B621240384;
 Sun, 28 Jun 2026 15:14:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DF81F000E9;
 Sun, 28 Jun 2026 15:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782659661;
 bh=g0lnf1ZWGqjRrmlHGm9YTg6de5oaRrbk2j99cVWvYiI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Cbg9qAS6RSBqnvvM6CHuvq8AGPVkQsH7i6SjJWydY8ASNRdoP/d0YDWMBZ/1L8lcU
 tyShGVPd8ex/AuJYbdG6EbZPcmUeScJbWHNJAWwzZORsT8ZI67MzgIHHGrkNGDWK6m
 l8fNb3dke4M410dGQRVgZYVwBEaY9rS9Ho9dOcpad2y1E78RocgyIy3S5JDey3+Mcx
 hU8wk8jSS5tlkfjqyVrFt6NstFiRnvRH4h233GO9v/5Ko39pmSTV1l3LRsIQyfn3VA
 QgxiUQPSzh1BkpnrwRPQABrv8cb5RMWj8vbs+IUIuqGR9P8nuFPx5pzfxFxNkAkqSz
 lcXLv7o6oaauQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 16/19] drm: fix race between partial
 drm_dev_register() failure and ioctl
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260628145406.2107056-17-dakr@kernel.org>
References: <20260628145406.2107056-1-dakr@kernel.org>
 <20260628145406.2107056-17-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 15:14:20 +0000
Message-Id: <20260628151421.60DF81F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] drm_dev_register() fails to unmap CPU memory mappings on the error=
 path, allowing userspace to retain access to physical memory that is subse=
quently freed.
- [High] drm_dev_synchronize_unplug() fails to protect against concurrent d=
rm_open() calls, leaving dev->driver->open() vulnerable to use-after-free.
--

commit e64c045955a50d4e3b92080a95ee364a79c625f5
Author: Danilo Krummrich <dakr@kernel.org>

drm: fix race between partial drm_dev_register() failure and ioctl

This commit introduces drm_dev_synchronize_unplug() to fix a race
where userspace could enter a drm_dev_enter() critical section during
a partial drm_dev_register() failure. It calls the new function on the
error path to ensure all in-flight critical sections complete before
cleanup proceeds.

Closes: https://lore.kernel.org/all/20260620190648.2E9F61F000E9@smtp.kernel=
.org/

> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
[ ... ]
> @@ -473,6 +473,22 @@ void drm_dev_exit(int idx)
>  }
>  EXPORT_SYMBOL(drm_dev_exit);
> =20
> +/*
> + * Mark the device as unplugged and wait for any in-flight drm_dev_enter=
()
> + * critical sections to complete.
> + */
> +static void drm_dev_synchronize_unplug(struct drm_device *dev)
> +{
> +	/*
> +	 * After synchronizing any critical read section is guaranteed to see
> +	 * the new value of ->unplugged, and any critical section which might
> +	 * still have seen the old value of ->unplugged is guaranteed to have
> +	 * finished.
> +	 */
> +	dev->unplugged =3D true;
> +	synchronize_srcu(&drm_unplug_srcu);
> +}

[Severity: High]
This is a pre-existing issue, but does this function completely protect
against concurrent drm_open() calls?

Looking at drm_open() in drivers/gpu/drm/drm_file.c, it checks the
unplugged flag via drm_minor_acquire() without entering the SRCU
critical section:

	minor =3D drm_minor_acquire(&drm_minors_xa, iminor(inode));
	if (IS_ERR(minor))
		return PTR_ERR(minor);

Could a thread calling open() read dev->unplugged =3D=3D false just before
this function sets it to true?

Since drm_open() doesn't hold the SRCU read lock, synchronize_srcu()
would return immediately, allowing the teardown to proceed while
dev->driver->open() executes concurrently.

[ ... ]
> @@ -1118,6 +1127,13 @@ int drm_dev_register(struct drm_device *dev, unsig=
ned long flags)
>  	if (dev->driver->unload)
>  		dev->driver->unload(dev);
>  err_minors:
> +	/*
> +	 * If a minor was registered before the failure, userspace could have
> +	 * opened it and entered a drm_dev_enter() critical section. Ensure all
> +	 * such sections complete before we clean up.
> +	 */
> +	drm_dev_synchronize_unplug(dev);
> +
>  	remove_compat_control_link(dev);
>  	drm_minor_unregister(dev, DRM_MINOR_ACCEL);
>  	drm_minor_unregister(dev, DRM_MINOR_PRIMARY);

[Severity: High]
This isn't a bug introduced by this patch, but is there a missing call
to unmap_mapping_range() on this error path?

If a minor was successfully registered before the failure, userspace
could have opened it and mapped a GEM object. In drm_dev_unplug(),
we unmap the CPU mappings:

	drm_dev_synchronize_unplug(dev);
	drm_dev_unregister(dev);
	unmap_mapping_range(dev->anon_inode->i_mapping, 0, 0, 1);

Does omitting this in the err_minors path in drm_dev_register() allow
userspace to retain access to physical memory that devres will subsequently
free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628145406.2107=
056-1-dakr@kernel.org?part=3D16
