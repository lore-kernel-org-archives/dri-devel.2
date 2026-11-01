Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D31606A326
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 22:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GB20UhRU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 146B310EAC4;
	Sun,  1 Nov 2026 22:43:01 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA46010EAC4
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 22:42:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 57E05601FF;
 Sun,  1 Nov 2026 22:42:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3ACB1F000C1;
 Sun,  1 Nov 2026 22:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793572974;
 bh=CVOHdcbNnrBIcfMpPXMPb78KhGgJ5hMpw/QKbhUboHA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GB20UhRU+l6i3162DNbZNEFCiY1pRxFSdpCKXilts5mUiVRUfMOZ1vGqIJdwCAiCi
 CpBOGcXpxNkiozYw4kwuLSygRlA6dDHJYWLnJNBTwsRQ0lUHk+9cSiGI/obJidRMgd
 CfgwCNG7oCicLrWDqMPRrS8L9kT/Tok4hs445x/4PFHlT+9WtooFujlbuBqRYSmdBm
 rUL+rBQyrqM1Qm2BQGiUEPhcN3ZJk7SChFiHQRmNbmfOoEPIw9de3sd610W/o0JyQR
 f2ACMPZmJ/ifv7OQ/8KAuMot6nNFjmhN5/bNDcRKeY9gtKDn/FUwRINzIsqF0lI9zB
 wbL4CcEe1fGSg==
Message-ID: <sashiko-outbox-192728@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/25] accel/qda: Add legacy FastRPC shim skeleton
To: "Ekansh Gupta" <ekansh.gupta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261102-v4-v4-9-88f2f24a5f0b@qti.qualcomm.com>
References: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
 <20261102-v4-v4-9-88f2f24a5f0b@qti.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 22:42:53 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] accel/qda: unplug race in qda_shim_ioctl() due to missing drm_=
dev_enter()
- [Critical] accel/qda: UAF and CB reuse when DMA-BUF outlives qda_shim_rel=
ease()
- [High] accel/qda: GEM object leak on DMA-BUF mmap() due to NULL vm_ops
--

commit a13f2a6988b9b1d52b35c9e30bbc2ea3fc109ecb
Author: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

accel/qda: Add legacy FastRPC shim skeleton

This commit adds a separate compatibility module that exposes /dev/fastrpc-*
misc device nodes per DSP domain on top of the QDA driver and implements the
FASTRPC_IOCTL_ALLOC_DMA_BUFF ioctl by exporting buffers as DMA-BUF file
descriptors.

> diff --git a/drivers/accel/qda/qda_fastrpc_shim.c b/drivers/accel/qda/qda=
_fastrpc_shim.c
> new file mode 100644
> index 0000000000000..25f5c242efde1
> --- /dev/null
> +++ b/drivers/accel/qda/qda_fastrpc_shim.c

[ ... ]

> +static int qda_shim_release(struct inode *inode, struct file *file)
> +{
> +	struct qda_shim_file *sf =3D file->private_data;
> +
> +	qda_legacy_ops_table.session_destroy(sf->session);
> +	kfree(sf);
> +
> +	return 0;
> +}

[Severity: Critical]
What happens if a DMA-BUF fd returned by qda_shim_alloc_dma_buf() remains o=
pen
after the /dev/fastrpc-* file descriptor is closed (which also occurs on
normal process exit when close_files() closes fds in ascending numerical
order)?

When qda_shim_alloc_dma_buf() allocates a buffer via
legacy_alloc_dmabuf() -> qda_gem_create_object() -> qda_memory_manager_allo=
c(),
a context bank (struct qda_iommu_device) is assigned to
sf->session->assigned_iommu_dev and qda_dma_alloc() stores a raw pointer to=
 it
in gem_obj->iommu_dev:

drivers/accel/qda/qda_memory_dma.c:qda_dma_alloc() {
	...
	gem_obj->virt =3D virt;
	gem_obj->dma_addr =3D dma_addr +
			    qda_soc_sid_offset(iommu_dev->qdev->soc_data, iommu_dev->sid);
	gem_obj->iommu_dev =3D iommu_dev;
	...
}

Closing the /dev/fastrpc-* fd calls qda_shim_release() ->
legacy_session_destroy() -> qda_session_free() ->
qda_memory_manager_release_device(session->assigned_iommu_dev), which clears
iommu_dev->assigned_session =3D NULL and drops the session's kref on
iommu_dev->ref while the exported DMA-BUF is still allocated and mapped in
that context bank's SMMU domain.

Doesn't that allow another session to be assigned the same context bank whi=
le
the buffer is still live, and also lead to a use-after-free of
gem_obj->iommu_dev and gem_obj->iommu_dev->dev in qda_dma_free(),
qda_dma_mmap(), or qda_dma_get_sgtable() if qda_rpmsg_remove() tears down t=
he
context bank devices before the DMA-BUF fd is closed?

> +static long qda_shim_alloc_dma_buf(struct qda_shim_file *sf, void __user=
 *argp)
> +{
> +	struct fastrpc_alloc_dma_buf args;
> +	struct dma_buf *dmabuf;
> +	int fd;
> +
> +	if (copy_from_user(&args, argp, sizeof(args)))
> +		return -EFAULT;
> +
> +	/* The size is 64 bits wide on the wire but a size_t further down */
> +	if (args.size > SIZE_MAX)
> +		return -EINVAL;
> +
> +	/* args.flags is not used, as in drivers/misc/fastrpc.c */
> +	dmabuf =3D qda_legacy_ops_table.alloc_dmabuf(sf->session, args.size);
> +	if (IS_ERR(dmabuf))
> +		return PTR_ERR(dmabuf);

[Severity: High]
Does mapping the DMA-BUF fd returned here leak the underlying drm_gem_object
and coherent DMA buffer?

qda_shim_alloc_dma_buf() calls legacy_alloc_dmabuf(), which creates a GEM
object with qda_gem_object_funcs and exports it via drm_gem_prime_export():

drivers/accel/qda/qda_gem.c:
const struct drm_gem_object_funcs qda_gem_object_funcs =3D {
	.free =3D qda_gem_free_object,
	.get_sg_table =3D qda_gem_get_sg_table,
	.mmap =3D qda_gem_mmap_obj,
};

When user space calls mmap() on the returned DMA-BUF fd,
drm_gem_dmabuf_mmap() -> drm_gem_prime_mmap() sets
vma->vm_ops =3D obj->funcs->vm_ops, calls drm_gem_object_get(obj), and invo=
kes
obj->funcs->mmap(obj, vma). Because qda_gem_object_funcs leaves .vm_ops NULL
(instead of setting drm_gem_vm_open and drm_gem_vm_close) and qda_gem_mmap_=
obj()
does not set vma->vm_ops either, nothing drops the GEM object reference when
the VMA is unmapped.

[ ... ]

> +static long qda_shim_ioctl(struct file *file, unsigned int cmd, unsigned=
 long arg)
> +{
> +	struct qda_shim_file *sf =3D file->private_data;
> +
> +	if (drm_dev_is_unplugged(&sf->session->qda_dev->drm_dev))
> +		return -ENODEV;
> +
> +	return qda_shim_dispatch(sf, cmd, (void __user *)arg);
> +}

[Severity: Critical]
Can qda_shim_ioctl() race with qda_rpmsg_remove() and access freed memory?

drm_dev_is_unplugged() enters the SRCU read-side critical section via
drm_dev_enter() and immediately exits it via drm_dev_exit() before returning
false. As a result, qda_shim_dispatch() -> qda_shim_alloc_dma_buf() ->
legacy_alloc_dmabuf() -> qda_gem_create_object() executes without holding
drm_dev_enter().

If qda_rpmsg_remove() runs concurrently:

drivers/accel/qda/qda_rpmsg.c:qda_rpmsg_remove() {
	...
	qda_unregister_device(qdev);
	drm_dev_unplug(&qdev->drm_dev);
	qdev->rpdev =3D NULL;
	qda_cb_unpopulate(qdev);
	qda_deinit_device(qdev);
}

misc_deregister() in qda_unregister_device() only serializes against open()=
 and
does not wait for in-flight ioctls on already-open /dev/fastrpc-* files, and
drm_dev_unplug() returns without waiting for qda_shim_alloc_dma_buf() becau=
se
the SRCU read lock was already dropped.

qda_cb_unpopulate() and qda_deinit_device() then destroy the context bank
platform devices, free qdev->iommu_mgr->devices, and destroy
qdev->iommu_mgr->assignment_lock, and devres frees qdev->iommu_mgr (which w=
as
allocated with devm_kzalloc(qdev->dev, ...) in qda_init_device()) while the
concurrent qda_shim_alloc_dma_buf() thread is still accessing qdev->iommu_m=
gr
and allocating from the context bank device.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-v4-v4-0-88=
f2f24a5f0b@qti.qualcomm.com?part=3D9
