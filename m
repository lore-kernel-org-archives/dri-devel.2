Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B659C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 07:49:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46DDB10EB87;
	Tue,  1 Sep 2026 07:49:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DMAhSwQ8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02EB010EB87
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 07:49:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B723040A7E;
 Tue,  1 Sep 2026 07:49:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7766E1F000E9;
 Tue,  1 Sep 2026 07:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788248970;
 bh=xxmNOa8/zr75A4u+LlOVkUaluGz85Z/kqWIRqYIehlE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DMAhSwQ8XjAzTpYMnlRiUuA/zp2RT7X+s8SIAg+aHKmNGfELdQXDiygEQL8ew99ga
 lUyLlir8wWPQHaUAnTIOGdya3gQ8GQ6o9HBIfXnauNi7ubOAzfizgjoPB1yyUw3UD8
 QJHkJAiO2m1tI+vsDF4tP+ymkOU01+eEQGJrqwrJmw3cczdhXDbZ3WSNnfSWp2wP9e
 TgXk4rb2hJkD5tZacCossCxRX1g6xtEIrnirnXjDxuLil1jhvZNVz1SO7DHshhi9n4
 oAE+Y7BaoV3tJ1dc4zIO1UU7XtC+jc3352/Rgv9DMKqq861l6RNci6RHpC/I1DbqEg
 Gfb/eeFsCW+nA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] drm/lease: optionally expose leases as device nodes
To: "Andrey Erokhin" <language.lawyer@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831200047.2533572-1-language.lawyer@gmail.com>
References: <20260831200047.2533572-1-language.lawyer@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 07:49:29 +0000
Message-Id: <20260901074930.7766E1F000E9@smtp.kernel.org>
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
- [Critical] `drm_lease_open` fails to assign `filp->f_mapping`, breaking G=
EM mmap invalidation and causing a physical page Use-After-Free.
- [High] Infinite loop in `drm_lease_open()` due to `get_file_rcu()` usage =
under a spinlock on a file with zero refcount.
- [High] `drm_lease_open()` replaces `filp->f_op` without acquiring a modul=
e reference for the new fops, leading to a module refcount underflow.
- [High] Incorrect error handling in `drm_expose_lease()` leads to a memory=
 leak and a Use-After-Free race condition.
--

commit 256d152bf5555316b6c49d22028de885037d1205
Author: Andrey Erokhin <language.lawyer@gmail.com>

drm/lease: optionally expose leases as device nodes

DRM leases are only returned as anonymous file descriptors. Device
managers such as udev and logind therefore cannot discover a lease, assign
it to a seat, or hand it to a session through their normal device APIs.

> diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
> index 5d2cf724cbd7b..32a11312d0ce8 100644
> --- a/drivers/gpu/drm/drm_lease.c
> +++ b/drivers/gpu/drm/drm_lease.c
[ ... ]
> +static int drm_expose_lease(struct file *lessee_file,
> +			    struct drm_master *lessee)
> +{
[ ... ]
> +	ret =3D dev_set_name(kdev, "%s-lessee-%d", dev_name(drm_kdev), lessee->=
lessee_id);
> +	if (ret < 0)
> +		goto minor_free;
> +	ret =3D device_add(kdev);
> +	if (ret < 0)
> +		goto device_put;
> +
> +	return 0;
> +
> +device_put:
> +	put_device(kdev);
> +
> +minor_free:
> +	xa_erase(&drm_exposed_lease_minors_xa, minor);

[Severity: High]
Does this error path introduce a use-after-free regression and a memory
leak?

If device_add() fails, the code jumps to device_put and calls
put_device(), which frees the exposed structure via
drm_exposed_device_release(). Execution then falls through to minor_free
and calls xa_erase(). Between the free and the erase, concurrent functions
like drm_lease_uevent() can look up the freed exposed pointer in the xarray
and dereference it.

Additionally, if dev_set_name() fails, the code jumps straight to
minor_free, bypassing put_device() and permanently leaking the device
structure.

> +
> +	return ret;
> +}
[ ... ]
> +static int drm_lease_open(struct inode *inode, struct file *filp)
> +{
> +	struct drm_exposed_lease *exposed;
> +	struct file *lessee_file =3D NULL;
> +
> +	xa_lock(&drm_exposed_lease_minors_xa);
> +	exposed =3D xa_load(&drm_exposed_lease_minors_xa, iminor(inode));
> +	if (exposed && exposed->lessee_file && get_file_rcu(&exposed->lessee_fi=
le))

[Severity: High]
Can get_file_rcu() cause an infinite loop regression here?

If a user opens a lease device concurrently while the anonymous lease file
is being closed, the lease file's refcount can drop to 0.

The get_file_rcu() function spins indefinitely waiting for the pointer to
become NULL if the refcount is 0. Since exposed->lessee_file is never set
to NULL, this lockup occurs under the drm_exposed_lease_minors_xa spinlock,
preventing the cleanup routine from ever removing it.

> +		lessee_file =3D exposed->lessee_file;
> +	xa_unlock(&drm_exposed_lease_minors_xa);
> +
> +	if (!lessee_file)
> +		return -ENODEV;
> +
> +	replace_fops(filp, &exposed->fops);

[Severity: High]
Does replacing the file operations here cause a module reference count
underflow regression?

The replace_fops() macro correctly drops the reference to the old fops, but
this code does not call fops_get(&exposed->fops) to acquire a reference to
the new fops owner. When the file is later closed, VFS will call fops_put()
and drop a module reference that was never acquired.

> +	filp->private_data =3D lessee_file->private_data;

[Severity: Critical]
Does this initialization miss setting the file mapping, potentially leading
to a use-after-free regression of physical memory?

The code copies fops and private_data from the lessee_file, but fails to
update filp->f_mapping =3D lessee_file->f_mapping.

When userspace mmaps the file, the VMA is attached to the generic character
device's address space rather than the DRM device's address space. If the
GEM object is later destroyed, the DRM driver's unmap_mapping_range() call
targets the DRM address space and fails to find the VMA. This leaves the
PTEs intact, allowing userspace to continue accessing freed physical pages.

> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831200047.2533=
572-1-language.lawyer@gmail.com?part=3D1
