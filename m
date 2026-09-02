Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C12A0C61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 18:24:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A706010E1B3;
	Wed,  2 Sep 2026 18:24:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eycr/zxv";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2917410E1B3
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 18:24:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 57F6660230;
 Wed,  2 Sep 2026 18:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60D21F000E9;
 Wed,  2 Sep 2026 18:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788373482;
 bh=TjVbvexKttbBWdH2eJcdVWG4LpJQ0OxASICZKYZb25k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eycr/zxvqv//gJhneut9wkV1mHuiaNZ4O4o0AOJgcO2X7aGRopuA9zfWnZ5YAt0z1
 QBOhhE4MKeT4zULWkRuHY8nuH7Kl3kk6DAwm3NdQ8iJPh1EQvaJoHzjQb16MkCv12c
 A2i9VBPZMtQRBBL2NZZlhssbRMUTCI4mMelcezAA75jHI1yFi2QIovYuH21J4u9lIA
 aQIXQIOHg61T7e5CV+m3M5gYUMMW6CJnJ1i60IGS2hLbB3mPYOLW63XqU98DnRhmdf
 JMVOjGi17evxe6KwsCsI9u7eEwjloMFOE3+NxfJCXTbwWoueoKYdeB7u7DbR5/hi+j
 os2eOiOBF6OtA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2] drm/lease: optionally expose leases as device nodes
To: "Andrey Erokhin" <language.lawyer@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260902180846.2753456-1-language.lawyer@gmail.com>
References: <20260902180846.2753456-1-language.lawyer@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 18:24:41 +0000
Message-Id: <20260902182441.E60D21F000E9@smtp.kernel.org>
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
- [High] Exposed lease devices are not unregistered when the primary DRM de=
vice is unregistered, causing a resource leak of the hardware device.
- [High] A race condition in `drm_expose_lease` exposes the lease device to=
 concurrent lookups before initialization completes, leading to a Use-After=
-Free on error paths.
--

commit 384e9d119c9161556cff8b6b1ef37502f82fc82f
Author: Andrey Erokhin <language.lawyer@gmail.com>

drm/lease: optionally expose leases as device nodes

DRM leases are only returned as anonymous file descriptors.
Device managers such as udev and logind cannot discover these leases,
assign them to seats, or hand them to sessions via their device APIs.

Accept O_CREAT in DRM_IOCTL_MODE_CREATE_LEASE to expose the lease
as a DRM class device named after its primary node and lessee ID.
Make the device a sibling of the primary node with DEVTYPE=3Ddrm_lease.

> diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
> index 5d2cf724cbd7b..fdd706530d7c8 100644
> --- a/drivers/gpu/drm/drm_lease.c
> +++ b/drivers/gpu/drm/drm_lease.c
[ ... ]
> @@ -263,10 +271,144 @@ static struct drm_master *drm_lease_create(struct =
drm_master *lessor, struct idr
>  	return ERR_PTR(error);
>  }
> =20
> +struct drm_exposed_lease {
> +	struct file *lessee_file;
> +	struct drm_master *lessee;
> +	struct file_operations fops;
> +	struct device kdev;
> +};
[ ... ]
> +static int drm_expose_lease(struct file *lessee_file,
> +			    struct drm_master *lessee)
> +{
> +	int ret =3D 0;
> +	u32 minor;
> +	struct drm_exposed_lease *exposed;
> +	struct device *drm_kdev;
> +	struct device *kdev;
> +
> +	exposed =3D kzalloc_obj(*exposed);
> +	if (!exposed)
> +		return -ENOMEM;
> +
> +	exposed->lessee_file =3D lessee_file;
> +	exposed->lessee =3D lessee;
> +	exposed->fops =3D *lessee_file->f_op;
> +	exposed->fops.release =3D drm_exposed_lease_release;
> +
> +	drm_kdev =3D lessee->dev->primary->kdev;
> +	kdev =3D &exposed->kdev;
> +
> +	device_initialize(kdev);
> +	kdev->class =3D drm_kdev->class;
> +	kdev->type =3D &drm_exposed_lease_device_type;
> +	kdev->parent =3D drm_kdev->parent;
> +	kdev->release =3D drm_exposed_device_release;
> +	ret =3D dev_set_name(kdev, "%s-lessee-%d", dev_name(drm_kdev), lessee->=
lessee_id);
> +	if (ret < 0)
> +		goto device_put;
> +
> +	ret =3D xa_alloc(&drm_exposed_lease_minors_xa, &minor, exposed,
> +		       XA_LIMIT(0, DRM_EXPOSED_LEASE_MINORS - 1), GFP_KERNEL);

[Severity: High]
This makes the exposed struct globally visible in the xarray before
device_add() has completed.

Could a concurrent thread guess the minor number and call open() on the
newly created lease device node while it is still being initialized?

> +	if (ret < 0)
> +		goto device_put;
> +
> +	kdev->devt =3D MKDEV(drm_exposed_lease_major, minor);
> +	ret =3D device_add(kdev);

[Severity: High]
When the primary DRM device is unregistered (e.g., via drm_dev_unregister()
on a hot-unplug), how are these exposed lease devices cleaned up?

Since this lease device takes a kobject reference to its parent
(kdev->parent =3D drm_kdev->parent), if the lease devices are not explicitly
unregistered during primary device teardown, could this pin the parent kobj=
ect
indefinitely and leak the physical hardware device structures?

> +	if (ret < 0)
> +		goto minor_free;
> +
> +	return 0;
> +
> +minor_free:
> +	xa_erase(&drm_exposed_lease_minors_xa, minor);
> +
> +device_put:
> +	put_device(kdev);

[Severity: High]
If device_add() fails and we enter this error path, put_device(kdev)
will free the exposed struct.

If a concurrent thread had already looked up the minor and passed it to
drm_lease_open(), wouldn't this free cause a dangling pointer in the
concurrent open()?

> +
> +	return ret;
> +}
[ ... ]
> +static int drm_lease_open(struct inode *inode, struct file *filp)
> +{
> +	struct drm_exposed_lease *exposed;
> +	struct file *lessee_file =3D NULL;
> +	const struct file_operations *fops =3D NULL;
> +
> +	xa_lock(&drm_exposed_lease_minors_xa);
> +	exposed =3D xa_load(&drm_exposed_lease_minors_xa, iminor(inode));
> +	if (exposed && exposed->lessee_file) {
> +		lessee_file =3D get_file_active(&exposed->lessee_file);
> +		if (lessee_file)
> +			fops =3D fops_get(&exposed->fops);
> +	}
> +	xa_unlock(&drm_exposed_lease_minors_xa);
> +
> +	if (!lessee_file)
> +		return -ENODEV;
> +	if (!fops) {
> +		fput(lessee_file);
> +		return -ENODEV;
> +	}
> +
> +	replace_fops(filp, fops);

[Severity: High]
If drm_expose_lease() fails at device_add() and frees the exposed
struct after this concurrent drm_lease_open() has called
replace_fops(filp, fops), won't filp->f_op point to freed memory?

Could this lead to a Use-After-Free on subsequent syscalls (like ioctl
or close)?

> +	filp->f_mapping =3D lessee_file->f_mapping;
> +	filp->private_data =3D lessee_file->private_data;
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902180846.2753=
456-1-language.lawyer@gmail.com?part=3D1
