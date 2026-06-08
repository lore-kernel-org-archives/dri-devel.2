Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70155CD6E79
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:32:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4ABB10F704;
	Mon,  8 Jun 2026 16:32:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bhzT2jWC";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 464AA10F71C
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 16:32:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AD04660098;
 Mon,  8 Jun 2026 16:32:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D90C1F00893;
 Mon,  8 Jun 2026 16:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780936333;
 bh=P2j1bZoDZUVbf7nCapsGeS8yA4Qa8qzCAZNoIE3YcH0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bhzT2jWC2XL5hRSyjqUIw0cqU5v7micgynooDDcHSCK+KUSEf/dNShck4S137WRkN
 qqbpk91q+PTXKdL2I+7OOAgDsMGCRoZZxjqzZRF4DghNMvVNBNB2++3cT3zNttDlgt
 lFHT81OkHPmMvrcesuK801a2Y03gov6aXCiuWQr9ljLU91r+mjzG4qv4utRR7xSa+g
 vj8HmR3WbeDm6VJq4SLIy4JG7CwXtOs7Zgg6EQvg50scOxlRhJxovRCHCfGKtdcpI/
 eTmaRgYemFO9Gr5hwZZPkWESP3LkLu4wN/C7qPuPmgKclLCPn3S+sD9lwgCtyqar8r
 QgXyB+f5tK2BA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 2/3] accel/amdxdna: Fix amdxdna_client accessing race
 in amdxdna_drm_gem_mmap()
To: "Lizhi Hou" <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260608161418.2748988-2-lizhi.hou@amd.com>
References: <20260608161418.2748988-2-lizhi.hou@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 16:32:12 +0000
Message-Id: <20260608163213.4D90C1F00893@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] Caching the `vm_area_struct` pointer in the MMU interval notif=
ier leads to Use-After-Free on `munmap()`.
- [High] The patch incompletely fixes a Use-After-Free of `amdxdna_client` =
during device removal. The UAF remains in the standard GEM mmap path, IOCTL=
s, and GEM destruction callbacks.
- [High] Double put of DRM GEM object reference on the error path in `amdxd=
na_insert_pages`.
- [High] Premature destruction of `notifier_wq` leads to Use-After-Free whe=
n unmapping VMAs after device removal.
--

commit 4a66abc4067bb1f72f27f8b25d0d1de298787835
Author: Lizhi Hou <lizhi.hou@amd.com>

accel/amdxdna: Fix amdxdna_client accessing race in amdxdna_drm_gem_mmap()

amdxdna_drm_gem_mmap() can be called after drm_dev_unplug() during device
removal. In that case, the mmap path may access amdxdna_client after it
has been freed, leading to a use-after-free.

Guard the mmap path with drm_dev_enter()/drm_dev_exit() and return an
error if the device is already unplugged.

> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdx=
dna/amdxdna_pci_drv.c
> index a22c986f1b331..c18ddad9f6459 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> @@ -253,15 +253,24 @@ static int amdxdna_drm_gem_mmap(struct file *filp, =
struct vm_area_struct *vma)
>  {
>  	struct drm_file *drm_filp =3D filp->private_data;
>  	struct amdxdna_client *client =3D drm_filp->driver_priv;
> -	struct amdxdna_dev *xdna =3D client->xdna;
> +	struct amdxdna_dev *xdna;
> +	int ret, idx;
> =20
>  	if (likely(vma->vm_pgoff >=3D DRM_FILE_PAGE_OFFSET_START))
>  		return drm_gem_mmap(filp, vma);
> =20

[Severity: High]
This is a pre-existing issue, but does this bypass of drm_dev_enter() leave
the use-after-free unresolved for standard GEM mmaps?

The patch adds drm_dev_enter() below this check, but if the condition
(vma->vm_pgoff >=3D DRM_FILE_PAGE_OFFSET_START) is met, it calls drm_gem_mm=
ap()
which eventually calls amdxdna_gem_obj_mmap() without the device removal
protection. Since amdxdna_remove() frees all client structures regardless of
open file descriptors, abo->client becomes a dangling pointer here.

Additionally, do the IOCTL handlers (like amdxdna_drm_config_hwctx_ioctl in
drivers/accel/amdxdna/amdxdna_ctx.c) and GEM destruction callbacks
(like amdxdna_gem_del_bo_usage in drivers/accel/amdxdna/amdxdna_gem.c)
also need drm_dev_enter() protection? They appear to extract and dereference
filp->driver_priv without synchronization.

> -	if (!xdna->dev_info->ops->mmap)
> -		return -EOPNOTSUPP;
> +	if (!drm_dev_enter(drm_filp->minor->dev, &idx))
> +		return -ENODEV;

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but could the error path in
amdxdna_insert_pages() lead to a double put of the GEM object reference?

In drivers/accel/amdxdna/amdxdna_gem.c:amdxdna_insert_pages(), if page
insertion fails:

	if (ret) {
		XDNA_ERR(xdna, "Failed insert pages %d", ret);
		vma->vm_ops->close(vma);
		return ret;
	}

For shmem GEM objects, calling close() drops the object reference. When this
error returns to drm_gem_mmap_obj(), it executes its error cleanup path whi=
ch
calls drm_gem_object_put() again, causing the same reference to be dropped
twice.

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to destroy the
notifier_wq during device removal?

In drivers/accel/amdxdna/amdxdna_pci_drv.c:amdxdna_remove():

	destroy_workqueue(xdna->notifier_wq);

If userspace retains mapped VMAs after the device is removed, a subsequent
munmap() will trigger amdxdna_hmm_invalidate() in
drivers/accel/amdxdna/amdxdna_gem.c, which queues work to the destroyed
workqueue:

	queue_work(xdna->notifier_wq, &mapp->hmm_unreg_work);

Can this lead to a use-after-free if the workqueue was already freed?

[Severity: Critical]
This isn't a bug introduced by this patch, but does caching the vm_area_str=
uct
pointer lead to a use-after-free during munmap()?

In drivers/accel/amdxdna/amdxdna_gem.c:amdxdna_hmm_register(), the vma
pointer is cached:

	mapp->vma =3D vma;

The core MM subsystem can split or free VMA objects independently. When
munmap() is called, the notifier queues amdxdna_hmm_unreg_work() to run
asynchronously. By the time amdxdna_umap_release() runs, the core MM has
already freed the VMA, but the driver dereferences it:

	if (is_import_bo(abo) && vma->vm_file && vma->vm_file->f_mapping)

Does this need to be tracked differently to avoid accessing a freed VMA?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608161418.2748=
988-1-lizhi.hou@amd.com?part=3D2
