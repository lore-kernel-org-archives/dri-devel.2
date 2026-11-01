Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57B9606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 22:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WxNUuLan
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44F1210EAC8;
	Sun,  1 Nov 2026 22:43:47 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17DFC10EAC8
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 22:43:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5EE2A605CE;
 Sun,  1 Nov 2026 22:43:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0CAB1F000C1;
 Sun,  1 Nov 2026 22:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793573020;
 bh=2cEYh1X+6TGAtnmfg/ey8NVbV9SEUjiyMwUk0dZwNGA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WxNUuLanFdDLiHp/nrXy3pvw/y/DG62V3IAq0dz3TXxT6u4QB3Rvh9fKxwPYKPrZ8
 9n/uxj4BDgaaZ9Oen9gmQ/rL5pV54F8lUlKvbp4ZN/eFbtbLEWClef472A5JBpmEm/
 YMan9OF4dhC0Odm+Ta3e7UFwYxRoJb5FIAlazXrZpSfCpZkAYYJqZbZ9EnPRE7FWCp
 6OcG0z1+I9oeqZVpwnSYZVshZj6voGcATG6ZFPR5xb4VHVmkEnnepDH1jRGGn8QLs5
 XpOtFcF1dppsOVcHjwTp/Ij5THoOzdYg6S6nZcCVlTqeBV/Zpqifb3Od4CnebfSJRc
 g9z4L0DQYnEgQ==
Message-ID: <sashiko-outbox-192729@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/25] accel/qda: Add legacy ops base and auxiliary
 device
To: "Ekansh Gupta" <ekansh.gupta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261102-v4-v4-8-88f2f24a5f0b@qti.qualcomm.com>
References: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
 <20261102-v4-v4-8-88f2f24a5f0b@qti.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 22:43:39 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] accel/qda: use-after-free of iommu_dev when DMA-BUF outlives sessi=
on
- [High] accel/qda: use-after-free in legacy ops after qda_rpmsg_remove()
- [High] accel/qda: GEM object leak on mmap() due to missing vm_ops
- [Low] accel/qda: unnecessary export of qda_session_alloc() and qda_sessio=
n_free()
--

commit c10272995846f83dffe56b2be6fa2691d606459a
Author: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

accel/qda: Add legacy ops base and auxiliary device

This commit creates an auxiliary device per DSP domain for the legacy FastR=
PC
compatibility module to bind to and exports a table of operations
(qda_legacy_ops_table) for session lifecycle and DMA-BUF allocation and
import. Sessions created by the legacy module hold a drm_device reference a=
nd
operate on DMA-BUFs and GEM objects directly without a drm_file.

> diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
> index 5e953d1f98bf4..21113deceaadb 100644
> --- a/drivers/accel/qda/qda_drv.c
> +++ b/drivers/accel/qda/qda_drv.c
> @@ -14,7 +15,13 @@
>  #include "qda_ioctl.h"
>  #include "qda_prime.h"
> =20
> -static struct qda_session *qda_session_alloc(struct qda_dev *qdev)
> +/**
> + * qda_session_alloc() - Create a session on a device
> + * @qdev: Device to create the session on
> + *
> + * Return: The new session, or ERR_PTR on failure
> + */
> +struct qda_session *qda_session_alloc(struct qda_dev *qdev)
>  {
>  	struct qda_session *session;
> =20
> @@ -26,6 +33,7 @@ static struct qda_session *qda_session_alloc(struct qda=
_dev *qdev)
> =20
>  	return session;
>  }
> +EXPORT_SYMBOL_FOR_MODULES(qda_session_alloc, "qda_fastrpc_shim");
> =20
>  static int qda_open(struct drm_device *dev, struct drm_file *file)
>  {
> @@ -42,13 +50,18 @@ static int qda_open(struct drm_device *dev, struct dr=
m_file *file)
>  	return 0;
>  }
> =20
> -static void qda_session_free(struct qda_session *session)
> +/**
> + * qda_session_free() - Release a session and whatever it still holds
> + * @session: Session to release
> + */
> +void qda_session_free(struct qda_session *session)
>  {
>  	if (session->assigned_iommu_dev)
>  		qda_memory_manager_release_device(session->assigned_iommu_dev);
> =20
>  	kfree(session);
>  }
> +EXPORT_SYMBOL_FOR_MODULES(qda_session_free, "qda_fastrpc_shim");

[Severity: Low]
This isn't a bug, but why are qda_session_alloc() and qda_session_free()
exported with EXPORT_SYMBOL_FOR_MODULES(..., "qda_fastrpc_shim") in
drivers/accel/qda/qda_drv.c?

Since qda_legacy_ops.o is linked into the same qda module via qda-y in
drivers/accel/qda/Makefile and exposes session creation and destruction
through qda_legacy_ops_table (where legacy_session_create() and
legacy_session_destroy() also manage the drm_dev reference), does
qda_fastrpc_shim ever need to call the raw qda_session_alloc() and
qda_session_free() helpers directly?

[ ... ]

> diff --git a/drivers/accel/qda/qda_legacy_ops.c b/drivers/accel/qda/qda_l=
egacy_ops.c
> new file mode 100644
> index 0000000000000..3566a10c64880
> --- /dev/null
> +++ b/drivers/accel/qda/qda_legacy_ops.c
> @@ -0,0 +1,80 @@

[ ... ]

> +static struct qda_session *legacy_session_create(struct qda_dev *qdev)
> +{
> +	struct qda_session *session;
> +
> +	session =3D qda_session_alloc(qdev);
> +	if (!IS_ERR(session))
> +		drm_dev_get(&qdev->drm_dev);
> +
> +	return session;
> +}
> +
> +static void legacy_session_destroy(struct qda_session *session)
> +{
> +	struct drm_device *drm_dev =3D &session->qda_dev->drm_dev;
> +
> +	qda_session_free(session);
> +	drm_dev_put(drm_dev);
> +}

[Severity: High]
What happens if a DMA-BUF allocated by legacy_alloc_dmabuf() (or a GEM obje=
ct
imported by legacy_import_dmabuf()) outlives the session when
legacy_session_destroy() is called in drivers/accel/qda/qda_legacy_ops.c?
Note that on normal process exit, close_files() closes file descriptors in
ascending order, so an earlier /dev/fastrpc-* fd will be closed before
DMA-BUF fds allocated later from that session.

When legacy_alloc_dmabuf() creates a buffer and exports it via
drm_gem_prime_export(), the resulting dma_buf holds a reference to gem_obj
and qdev->drm_dev, and gem_obj->iommu_dev points to
session->assigned_iommu_dev. However, neither qda_dma_alloc() nor
qda_gem_prime_import_sg_table() takes a reference on iommu_dev->ref or on t=
he
session.

When legacy_session_destroy() runs while the exported DMA-BUF is still aliv=
e:

legacy_session_destroy()
  -> qda_session_free()
       -> qda_memory_manager_release_device(session->assigned_iommu_dev)
            iommu_dev->assigned_session =3D NULL;
            kref_put(&iommu_dev->ref, iommu_device_free);

First, clearing iommu_dev->assigned_session allows assign_available_device()
in drivers/accel/qda/qda_memory_manager.c to hand the same context bank to a
new session while the old session's DMA-BUF remains allocated and mapped in
that context bank's SMMU domain, and causes qda_gem_prime_import() (which
checks to_qda_gem_obj(obj)->iommu_dev =3D=3D session->assigned_iommu_dev) to
treat the previous session's buffer as belonging to the new session.

Second, if qda_rpmsg_remove() subsequently runs and unregisters the context
bank via qda_cb_unpopulate() -> qda_cb_teardown_device() ->
qda_memory_manager_unregister_device(), iommu_dev->ref drops to zero and
iommu_device_free() frees struct qda_iommu_device. When the DMA-BUF fd is
later closed, drm_gem_dmabuf_release() -> qda_gem_free_object() ->
qda_memory_manager_free() -> qda_dma_free() in
drivers/accel/qda/qda_memory_dma.c dereferences the freed gem_obj->iommu_de=
v:

void qda_dma_free(struct qda_gem_obj *gem_obj)
{
	dma_free_coherent(gem_obj->iommu_dev->dev, gem_obj->size,
			  gem_obj->virt, qda_gem_dma_addr(gem_obj));

Can this lead to a use-after-free of gem_obj->iommu_dev as well as premature
context bank reuse?

> +
> +/*
> + * As the GEM_CREATE ioctl, but exporting a DMA-BUF rather than installi=
ng a
> + * handle: a session the shim created has no DRM file to hold handles, a=
nd the
> + * legacy interface hands buffers to user space as file descriptors anyw=
ay.
> + */
> +static struct dma_buf *legacy_alloc_dmabuf(struct qda_session *session, =
u64 size)
> +{
> +	struct qda_dev *qdev =3D session->qda_dev;
> +	struct drm_gem_object *gem_obj;
> +	struct dma_buf *dmabuf;
> +
> +	gem_obj =3D qda_gem_create_object(&qdev->drm_dev, qdev->iommu_mgr, size=
, session);
> +	if (IS_ERR(gem_obj))
> +		return ERR_CAST(gem_obj);
> +
> +	/* O_RDWR so the fd can be mapped writable */
> +	dmabuf =3D drm_gem_prime_export(gem_obj, O_RDWR);
> +
> +	/* The DMA-BUF took its own reference if the export succeeded */
> +	drm_gem_object_put(gem_obj);
> +
> +	return dmabuf;
> +}

[Severity: High]
Does mmap() on a DMA-BUF returned by legacy_alloc_dmabuf() leak gem_obj and
its backing DMA allocation?

When user space maps the exported DMA-BUF fd, the call chain is:

dma_buf_mmap()
  -> drm_gem_dmabuf_mmap()
       -> drm_gem_prime_mmap()

In drm_gem_prime_mmap():

	vma->vm_ops =3D obj->funcs->vm_ops;
	drm_gem_object_get(obj);
	ret =3D obj->funcs->mmap(obj, vma);

However, in drivers/accel/qda/qda_gem.c, qda_gem_object_funcs does not set
.vm_ops:

const struct drm_gem_object_funcs qda_gem_object_funcs =3D {
	.free =3D qda_gem_free_object,
	.get_sg_table =3D qda_gem_get_sg_table,
	.mmap =3D qda_gem_mmap_obj,
};

And qda_gem_mmap_obj() -> qda_dma_mmap() -> dma_mmap_coherent() does not set
vma->vm_ops either. Because vma->vm_ops remains NULL instead of using
drm_gem_vm_open and drm_gem_vm_close, unmapping the VMA never calls
drm_gem_vm_close() to drop the reference taken by drm_gem_object_get(obj).
Won't every mmap() call permanently leak the qda_gem_obj, its coherent DMA
buffer, and the associated drm_device reference?

[ ... ]

> diff --git a/drivers/accel/qda/qda_prime.c b/drivers/accel/qda/qda_prime.c
> index 7a709e3000d8b..128d4ab2cf64f 100644
> --- a/drivers/accel/qda/qda_prime.c
> +++ b/drivers/accel/qda/qda_prime.c
> @@ -181,4 +181,37 @@ int qda_prime_fd_to_handle(struct drm_device *drm_de=
v, struct drm_file *file_pri
>  	return ret;
>  }
> =20
> +/**
> + * qda_prime_import_dmabuf() - Import a DMA-BUF without installing a han=
dle
> + * @drm_dev: DRM device
> + * @session: Session to import into
> + * @dma_buf: Buffer to import
> + *
> + * As qda_prime_fd_to_handle(), but stopping at the GEM object: a sessio=
n the
> + * legacy shim created has no DRM file to install a handle in. The calle=
r owns
> + * the returned reference.
> + *
> + * Return: The new GEM object on success, ERR_PTR on failure
> + */
> +struct drm_gem_object *qda_prime_import_dmabuf(struct drm_device *drm_de=
v,
> +					       struct qda_session *session,
> +					       struct dma_buf *dma_buf)
> +{
> +	struct qda_dev *qdev =3D qda_dev_from_drm(drm_dev);
> +	struct drm_gem_object *gem_obj;
> +	int ret;
> +
> +	ret =3D qda_memory_manager_assign_device(qdev->iommu_mgr, session);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	guard(mutex)(&qdev->import_lock);
> +
> +	qdev->importing_session =3D session;
> +	gem_obj =3D qda_gem_prime_import(drm_dev, dma_buf);
> +	qdev->importing_session =3D NULL;
> +
> +	return gem_obj;
> +}
> +
>  MODULE_IMPORT_NS("DMA_BUF");
> diff --git a/drivers/accel/qda/qda_rpmsg.c b/drivers/accel/qda/qda_rpmsg.c
> index 2c9d79937b106..14034e250555d 100644
> --- a/drivers/accel/qda/qda_rpmsg.c
> +++ b/drivers/accel/qda/qda_rpmsg.c
> @@ -50,6 +50,9 @@ static void qda_rpmsg_remove(struct rpmsg_device *rpdev)
>  {
>  	struct qda_dev *qdev =3D dev_get_drvdata(&rpdev->dev);
> =20
> +	/* Take the legacy nodes away first, so nothing new opens during teardo=
wn */
> +	qda_unregister_device(qdev);
> +
>  	/*
>  	 * Unplug before clearing @rpdev: once there are ioctls that reach the
>  	 * DSP, this is what stops a new one from starting and waits for the

[Severity: High]
In legacy_session_create(), drm_dev_get(&qdev->drm_dev) is taken so that
qdev survives qda_rpmsg_remove() while a legacy session remains open.
However, can legacy_alloc_dmabuf(), legacy_import_dmabuf() (via
qda_prime_import_dmabuf()), or later buffer cleanup trigger a use-after-free
if they run concurrently with or after qda_rpmsg_remove()?

In drivers/accel/qda/qda_rpmsg.c, qda_rpmsg_remove() does:

	qda_unregister_device(qdev);
	drm_dev_unplug(&qdev->drm_dev);
	qdev->rpdev =3D NULL;
	qda_cb_unpopulate(qdev);
	qda_deinit_device(qdev);

1. In qda_init_device(), qdev->iommu_mgr is allocated with
devm_kzalloc(qdev->dev, ...), which is managed by the rpmsg device rather
than &qdev->drm_dev. When qda_rpmsg_remove() finishes, devres frees
qdev->iommu_mgr even though qdev->drm_dev is still held by the open legacy
session.

2. qda_deinit_device() frees iommu_mgr->devices and destroys both
iommu_mgr->assignment_lock and qdev->import_lock, while qda_cb_unpopulate()
calls of_platform_device_destroy() on each context bank child device (which
qda_cb_setup_device() stored in iommu_dev->dev without taking a device
reference).

3. Neither legacy_alloc_dmabuf() nor qda_prime_import_dmabuf() enters a
drm_dev_enter() / drm_dev_exit() critical section, so drm_dev_unplug() does
not synchronize with them. If legacy_alloc_dmabuf() or
qda_prime_import_dmabuf() is called on an already-open legacy session during
or after qda_rpmsg_remove(), won't it dereference the freed qdev->iommu_mgr,
lock the destroyed assignment_lock and import_lock mutexes, and pass the
destroyed iommu_dev->dev to dma_alloc_coherent() or dma_buf_attach()? And
even if buffers were allocated before qda_rpmsg_remove() and only freed
afterwards, won't qda_gem_free_object() pass the destroyed iommu_dev->dev to
dma_free_coherent() or dma_buf_unmap_attachment_unlocked()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-v4-v4-0-88=
f2f24a5f0b@qti.qualcomm.com?part=3D8
