Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335C2606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 22:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S/GIh6SN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 985C910E00A;
	Sun,  1 Nov 2026 22:51:54 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77F9210EAD4
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 22:51:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A9862601FF;
 Sun,  1 Nov 2026 22:51:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 375BD1F000C1;
 Sun,  1 Nov 2026 22:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793573507;
 bh=A22o90k6v/rWmyIeOcoHXwPDNzXTTrv9UCr1yXKAF40=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=S/GIh6SNzOdJ+e5PqXbhTSgyxZ2JyTpe5eP+r1jUzozBcQxAjNWZweFHkXO43JH6B
 VwhubsSaFwH05JkOKDW4MYCkBnpzEJu3WJOdZGDcKbyI/z/HJP3IdIElER+5UrvMUs
 xvZzVyBUC8Ea0Gs6TFXz4P6hEbgvYYzDB6OcIncw2x1T0Q1F7aF9mbwmlX1rOWa6Wt
 WWUe6G7nR8L1S/mzGFrTY1pzSCrz0Pvv2wowT+Xs/dVIxDDHMpxSmymjYvtWoHQnik
 4Qm9pnRNWRlYUR3rqCj/0jApy1+fzMLXQCHkUmN0DCApU/T156nfN0kC6vuaFDUsah
 Ds73GT80fdYtQ==
Message-ID: <sashiko-outbox-192740@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/25] accel/qda: Add DMA-BUF import
To: "Ekansh Gupta" <ekansh.gupta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261102-v4-v4-7-88f2f24a5f0b@qti.qualcomm.com>
References: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
 <20261102-v4-v4-7-88f2f24a5f0b@qti.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 22:51:46 +0000
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] accel/qda: unreferenced iommu_dev in qda_gem_obj causes UAF and CB=
 reuse
- [High] accel/qda: UAF on CB device unplug in qda_gem_free_object() and im=
port
- [High] accel/qda: missing vm_ops in qda_gem_object_funcs leaks GEM ref on=
 mmap
- [Medium] accel/qda: 32-bit dma_addr_t truncates SID in qda_gem_prime_impo=
rt_sg_table()
- [Low] accel/qda: unused gem_prime_import_sg_table hook and stale import c=
omments
- [Low] accel/qda: qda_gem_prime_import_sg_table() allocates unused shmem f=
ile
--

commit c21f00e936e2fb1a3bd269969e95dd625e477ff7
Author: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

accel/qda: Add DMA-BUF import

This commit adds DMA-BUF PRIME import and sg_table export support to the
QDA accelerator driver, mapping imported buffers into the importing
session's IOMMU context bank and verifying that mappings are physically
or IOVA contiguous.

> diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
> index 37019ff38ecbc..5e953d1f98bf4 100644
> --- a/drivers/accel/qda/qda_drv.c
> +++ b/drivers/accel/qda/qda_drv.c
[ ... ]
> @@ -69,6 +70,9 @@ static const struct drm_driver qda_drm_driver =3D {
>  	.postclose =3D qda_postclose,
>  	.ioctls =3D qda_ioctls,
>  	.num_ioctls =3D ARRAY_SIZE(qda_ioctls),
> +	.gem_prime_import =3D qda_gem_prime_import,
> +	.gem_prime_import_sg_table =3D qda_gem_prime_import_sg_table,
> +	.prime_fd_to_handle =3D qda_prime_fd_to_handle,
>  	.name =3D QDA_DRIVER_NAME,
>  	.desc =3D "Qualcomm DSP Accelerator Driver",
>  };

[Severity: Low]
This isn't a bug, but is .gem_prime_import_sg_table in qda_drm_driver ever
called by the DRM core?

In DRM PRIME, dev->driver->gem_prime_import_sg_table is only invoked by
drm_gem_prime_import_dev(). However, qda_gem_prime_import() does not call
drm_gem_prime_import_dev(); it open-codes dma_buf_attach() and
dma_buf_map_attachment_unlocked() and calls qda_gem_prime_import_sg_table()
directly.

The commit message ("The core PRIME helper takes the device to attach to, so
pass the session's context bank") and the kernel-doc comment on
qda_gem_prime_import_sg_table() ("Called by the DRM PRIME helpers once they
have attached to the exporter...") also describe the
drm_gem_prime_import_dev() flow rather than the open-coded path in
qda_gem_prime_import(). Could qda_gem_prime_import() either call
drm_gem_prime_import_dev(drm_dev, dma_buf, session->assigned_iommu_dev->dev)
after handling the same-device check, or drop the unused hook and update the
comments?

> diff --git a/drivers/accel/qda/qda_gem.c b/drivers/accel/qda/qda_gem.c
> index 864bac914e48d..a9ab8ccb78930 100644
> --- a/drivers/accel/qda/qda_gem.c
> +++ b/drivers/accel/qda/qda_gem.c
[ ... ]
> @@ -24,6 +31,10 @@ static int qda_gem_mmap_obj(struct drm_gem_object *gem=
_obj, struct vm_area_struc
>  	struct qda_gem_obj *qda_gem_obj =3D to_qda_gem_obj(gem_obj);
>  	int ret;
> =20
> +	/* Imported buffers have to be mapped through the exporter */
> +	if (drm_gem_is_imported(gem_obj))
> +		return -EINVAL;
> +
>  	/* The fake offset only identifies the object, it does not index into i=
t */
>  	vma->vm_pgoff =3D 0;
> =20
> @@ -36,8 +47,35 @@ static int qda_gem_mmap_obj(struct drm_gem_object *gem=
_obj, struct vm_area_struc
>  	return 0;
>  }
> =20
> -static const struct drm_gem_object_funcs qda_gem_object_funcs =3D {
> +/*
> + * Lets another context bank map this buffer when a session imports the
> + * dma-buf this object was exported as: see qda_gem_prime_import().
> + */
> +static struct sg_table *qda_gem_get_sg_table(struct drm_gem_object *gem_=
obj)
> +{
[ ... ]
> +	return sgt;
> +}
> +
> +const struct drm_gem_object_funcs qda_gem_object_funcs =3D {
>  	.free =3D qda_gem_free_object,
> +	.get_sg_table =3D qda_gem_get_sg_table,
>  	.mmap =3D qda_gem_mmap_obj,
>  };

[Severity: High]
Does mmap() on a QDA GEM object or a PRIME-exported QDA DMA-BUF leak the
drm_gem_object reference and its coherent DMA buffer?

Both drm_gem_mmap_obj() (for DRM fd mmap) and
drm_gem_dmabuf_mmap()->drm_gem_prime_mmap() (for PRIME-exported DMA-BUF mma=
p,
now reachable because .get_sg_table is wired up) take a reference via
drm_gem_object_get(obj), set vma->vm_ops =3D obj->funcs->vm_ops, and call
obj->funcs->mmap(obj, vma).

Because qda_gem_object_funcs leaves .vm_ops unset and
qda_gem_mmap_obj()->qda_dma_mmap()->dma_mmap_coherent() does not set
vma->vm_ops either, vma->vm_ops remains NULL (and is replaced with
dummy_vm_ops in mmap_region()). When the VMA is later unmapped,
drm_gem_vm_close() is never called to drop the reference acquired at mmap
time, so qda_gem_free_object() never runs and qda_gem_obj and its DMA memory
are leaked.

Additionally, in the PRIME DMA-BUF mmap path, drm_gem_prime_mmap() adds
drm_vma_node_start(&obj->vma_node) to vma->vm_pgoff before calling
obj->funcs->mmap(). Resetting vma->vm_pgoff =3D 0 in qda_gem_mmap_obj() ins=
tead
of subtracting drm_vma_node_start(&gem_obj->vma_node) discards any non-zero
page offset passed to mmap() on the exported DMA-BUF fd.

Should qda_gem_object_funcs set .vm_ops to a vm_operations_struct with
.open =3D drm_gem_vm_open and .close =3D drm_gem_vm_close, and adjust
vma->vm_pgoff -=3D drm_vma_node_start(&gem_obj->vma_node) in qda_gem_mmap_o=
bj()?

> diff --git a/drivers/accel/qda/qda_gem.h b/drivers/accel/qda/qda_gem.h
> index af3b9dfc75099..1dab494197aab 100644
> --- a/drivers/accel/qda/qda_gem.h
> +++ b/drivers/accel/qda/qda_gem.h
[ ... ]
> @@ -16,14 +17,20 @@ struct qda_session;
> =20
>  /**
>   * struct qda_gem_obj - A buffer the DSP can access
> + *
> + * Either allocated by this driver or imported from another one. Use
> + * drm_gem_is_imported() on @base to tell which; imported buffers have no
> + * @virt and own no memory, they only hold a mapping of someone else's.
>   */
>  struct qda_gem_obj {
>  	/** @base: DRM GEM object base; must be first member */
>  	struct drm_gem_object base;
>  	/** @iommu_dev: Context bank this buffer is mapped into */
>  	struct qda_iommu_device *iommu_dev;
> -	/** @virt: Kernel virtual address of the buffer */
> +	/** @virt: Kernel virtual address, NULL for imported buffers */
>  	void *virt;
> +	/** @sgt: Mapping of an imported buffer, NULL otherwise */
> +	struct sg_table *sgt;
>  	/** @dma_addr: Address of the buffer as the DSP sees it */
>  	dma_addr_t dma_addr;

[Severity: Medium]
Can qda_gem_obj->dma_addr truncate the stream ID offset on 32-bit
CONFIG_COMPILE_TEST builds where dma_addr_t is 32 bits wide?

In qda_gem_prime_import_sg_table():

	qda_gem_obj->dma_addr =3D sg_dma_address(sgt->sgl) +
				qda_soc_sid_offset(qdev->soc_data, iommu_dev->sid);

qda_soc_sid_offset() returns a u64 with sid shifted left by 32 or 56 bits,
and qda_soc_dma_addr() takes a u64 iova, but struct qda_gem_obj stores
dma_addr as dma_addr_t. When !CONFIG_ARCH_DMA_ADDR_T_64BIT, storing the sum
into dma_addr_t drops the upper 32 bits containing the SID. Should dma_addr=
 in
struct qda_gem_obj be u64?

> diff --git a/drivers/accel/qda/qda_prime.c b/drivers/accel/qda/qda_prime.c
> new file mode 100644
> index 0000000000000..7a709e3000d8b
> --- /dev/null
> +++ b/drivers/accel/qda/qda_prime.c
> @@ -0,0 +1,184 @@
[ ... ]
> +struct drm_gem_object *qda_gem_prime_import_sg_table(struct drm_device *=
drm_dev,
> +						     struct dma_buf_attachment *attach,
> +						     struct sg_table *sgt)
> +{
> +	struct qda_dev *qdev =3D qda_dev_from_drm(drm_dev);
> +	size_t size =3D PAGE_ALIGN(attach->dmabuf->size);
> +	struct qda_iommu_device *iommu_dev;
> +	struct qda_gem_obj *qda_gem_obj;
> +	int ret;
> +
> +	if (drm_prime_get_contiguous_size(sgt) < size) {
> +		drm_dbg_driver(drm_dev, "Rejecting non-contiguous buffer of %zu bytes\=
n", size);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	/*
> +	 * The buffer was mapped into the context bank of the session doing the
> +	 * import, so that is the bank the DSP has to be told about.
> +	 */
> +	iommu_dev =3D dev_get_drvdata(attach->dev);
> +	if (!iommu_dev)
> +		return ERR_PTR(-ENODEV);
> +
> +	qda_gem_obj =3D kzalloc_obj(*qda_gem_obj);
> +	if (!qda_gem_obj)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret =3D drm_gem_object_init(drm_dev, &qda_gem_obj->base, size);
> +	if (ret) {
> +		kfree(qda_gem_obj);
> +		return ERR_PTR(ret);
> +	}

[Severity: Low]
Does an imported DMA-BUF GEM object need shmem backing via
drm_gem_object_init()?

drm_gem_object_init() calls drm_gem_private_object_init() and then allocate=
s a
shmem file of size bytes via shmem_file_setup(). Since imported DMA-BUF
objects are backed by the exporter's memory rather than shmem (and also if
shmem_file_setup() fails, kfree(qda_gem_obj) is called without
drm_gem_private_object_fini() to clean up _resv and gpuva.lock), should
qda_gem_prime_import_sg_table() call drm_gem_private_object_init() instead?

> +
> +	qda_gem_obj->base.funcs =3D &qda_gem_object_funcs;
> +	qda_gem_obj->size =3D size;
> +	qda_gem_obj->sgt =3D sgt;
> +	qda_gem_obj->iommu_dev =3D iommu_dev;
> +	qda_gem_obj->dma_addr =3D sg_dma_address(sgt->sgl) +
> +				qda_soc_sid_offset(qdev->soc_data, iommu_dev->sid);
> +
> +	return &qda_gem_obj->base;
> +}
> +
[ ... ]
> +struct drm_gem_object *qda_gem_prime_import(struct drm_device *drm_dev,
> +					    struct dma_buf *dma_buf)
> +{
> +	struct qda_dev *qdev =3D qda_dev_from_drm(drm_dev);
> +	struct qda_session *session =3D qdev->importing_session;
> +	struct dma_buf_attachment *attach;
> +	struct drm_gem_object *obj;
> +	struct sg_table *sgt;
> +	int ret;
> +
> +	if (!session || !session->assigned_iommu_dev)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (drm_gem_is_prime_exported_dma_buf(drm_dev, dma_buf)) {
> +		/*
> +		 * A buffer this driver exported. The DRM core would hand back
> +		 * the original object, which stays in the context bank of the
> +		 * session that allocated it, while the DSP of this session
> +		 * translates addresses in its own bank. Share the object only
> +		 * within a bank, and map it again for any other.
> +		 */
> +		obj =3D dma_buf->priv;
> +		if (to_qda_gem_obj(obj)->iommu_dev =3D=3D session->assigned_iommu_dev)=
 {
> +			drm_gem_object_get(obj);
> +			return obj;
> +		}
> +	}

[Severity: High]
What happens if a session exports a QDA GEM object as a DMA-BUF (now enabled
via qda_gem_get_sg_table()) and then closes its DRM fd while the exported
dma_buf fd remains open?

When the exporting session closes its DRM fd:

  qda_postclose()
    -> qda_session_free()
      -> qda_memory_manager_release_device(session->assigned_iommu_dev)

qda_memory_manager_release_device() clears iommu_dev->assigned_session =3D =
NULL
and drops the session's kref on iommu_dev, even though the exported
qda_gem_obj is still alive and holds an unreferenced pointer in
qda_gem_obj->iommu_dev (and remains mapped in that context bank's SMMU
domain).

This appears to allow two failure modes:

1. If a second session opens the device, qda_memory_manager_assign_device()
can assign that same iommu_dev to the new session while the first session's
exported buffer is still mapped in that context bank. If the second session
then imports the dma_buf, to_qda_gem_obj(obj)->iommu_dev =3D=3D
session->assigned_iommu_dev in qda_gem_prime_import() evaluates to true and
returns the original non-imported GEM object (where drm_gem_is_imported(obj)
is false), allowing the second session to mmap() the buffer through QDA as =
well
as sharing the SMMU context bank before the old buffer is freed.

2. If the RPMsg device is removed after the exporting session closed its DRM
fd while the exported dma_buf is still held open:

  qda_rpmsg_remove()
    -> qda_cb_unpopulate()
      -> qda_cb_teardown_device()
        -> qda_memory_manager_unregister_device()

drops the remaining kref on iommu_dev and frees iommu_dev via kfree(). Any
subsequent import/attach calling qda_gem_get_sg_table()->qda_dma_get_sgtabl=
e()
or final release calling
qda_gem_free_object()->qda_memory_manager_free()->qda_dma_free() will then
dereference the freed qda_gem_obj->iommu_dev pointer.

Should each qda_gem_obj hold a reference on iommu_dev (and keep the context
bank from being reassigned until all GEM allocations/mappings in it have be=
en
released)?

> +
> +	attach =3D dma_buf_attach(dma_buf, session->assigned_iommu_dev->dev);
> +	if (IS_ERR(attach))
> +		return ERR_CAST(attach);
[ ... ]
> +int qda_prime_fd_to_handle(struct drm_device *drm_dev, struct drm_file *=
file_priv,
> +			   int prime_fd, u32 *handle)
> +{
> +	struct qda_dev *qdev =3D qda_dev_from_drm(drm_dev);
> +	struct qda_session *session =3D file_priv->driver_priv;
> +	int ret;
> +
> +	ret =3D qda_memory_manager_assign_device(qdev->iommu_mgr, session);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&qdev->import_lock);
> +
> +	qdev->importing_session =3D session;
> +	ret =3D drm_gem_prime_fd_to_handle(drm_dev, file_priv, prime_fd, handle=
);
> +	qdev->importing_session =3D NULL;
> +
> +	return ret;
> +}

[Severity: High]
Can qda_prime_fd_to_handle() and qda_gem_free_object() race with or access
freed context bank devices after qda_rpmsg_remove()?

In qda_rpmsg_remove():

  drm_dev_unplug(&qdev->drm_dev);
  qda_cb_unpopulate(qdev);
  qda_deinit_device(qdev);

First, drm_ioctl_kernel() only checks drm_dev_is_unplugged() at entry and d=
oes
not hold a drm_dev_enter()/drm_dev_exit() critical section. Because
qda_prime_fd_to_handle() does not guard its body with
drm_dev_enter()/drm_dev_exit(), drm_dev_unplug() will not wait for an
in-flight import to complete before qda_cb_unpopulate() destroys the context
bank platform devices and qda_deinit_device() frees qdev->iommu_mgr->devices
and destroys qdev->import_lock.

Second, in qda_gem_prime_import(), dma_buf_attach(dma_buf,
session->assigned_iommu_dev->dev) attaches the DMA-BUF to the context bank
child platform_device (&entry->pdev->dev) without holding a reference that
keeps the device registered. If qda_rpmsg_remove() runs while a user process
has an open session with imported (or allocated) GEM objects,
qda_cb_unpopulate() calls of_platform_device_destroy(&entry->pdev->dev, NUL=
L),
which unregisters and frees entry->pdev. When the user process later closes
its fd, qda_gem_free_object() calls:

  drm_prime_gem_destroy(gem_obj, qda_gem_obj->sgt)
    -> dma_buf_unmap_attachment_unlocked()
      -> dma_unmap_sgtable(attach->dev, ...)

(or qda_dma_free() -> dma_free_coherent(gem_obj->iommu_dev->dev, ...)),
dereferencing the unregistered and freed context bank struct device.

Should qda_prime_fd_to_handle() use drm_dev_enter()/drm_dev_exit(), and sho=
uld
the context bank device lifetime be tied to active GEM objects/attachments =
or
managed via drmm so it outlives open file descriptors and GEM objects?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-v4-v4-0-88=
f2f24a5f0b@qti.qualcomm.com?part=3D7
