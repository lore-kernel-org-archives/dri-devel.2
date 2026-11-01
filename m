Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5CB606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 22:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hzzsNLRm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7009710E4C8;
	Sun,  1 Nov 2026 22:50:02 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8918F10E4C8
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 22:49:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0D10E605CB;
 Sun,  1 Nov 2026 22:49:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1261F000C1;
 Sun,  1 Nov 2026 22:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793573394;
 bh=rnp/lfplZRkZVwoZ2ToX+4NSoZhIC//eKwokLoBjj0Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hzzsNLRmBBd0ccRZNxPTkGKiZ96ERI+vBX996hmsxJFdujaVPN3JorghBZFl7xrrh
 zqg8OCtoP2/BKXz6EWfWrTJz2Yvb8TLbGEJTP0ZsQ+y/HAW9cUAPvsWxkij64kUi45
 BHcP12MX39o1w8DUTEuwBR5NjLZ2NyMgT7qBE8VUQdpW1P/L8X5uQ5i7C+sxnt8+21
 pJZY/jlAxLTyLZw5TQ6LeBsHna5ylwljQ8Wkk8iGgT3gqCYlXU+dMTG4CfWR6OtsXx
 4StpMlscJKnAGkEX7m8InHDWI1MiFqdhmt8b26gYk7qoxCD1vjBD6ABdZa+0rnZX3k
 ZusT8Iq1aVVtQ==
Message-ID: <sashiko-outbox-192736@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 18/25] accel/qda: Add remote memory unmapping from
 the DSP address space
To: "Ekansh Gupta" <ekansh.gupta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261102-v4-v4-18-88f2f24a5f0b@qti.qualcomm.com>
References: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
 <20261102-v4-v4-18-88f2f24a5f0b@qti.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 22:49:54 +0000
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
- [High] accel/qda: missing GEM object reference for active DSP mappings
- [High] accel/qda: refcount underflow and UAF in qda_fastrpc_flush_pending=
()
- [Low] accel/qda: duplicate address fields and unchecked fields in qda_ioc=
tl_munmap()
--

commit 52a28fd51f1253e9ef94a6c86442ba00197bb35c
Author: Ekansh Gupta <ekangupt@qti.qualcomm.com>

accel/qda: Add remote memory unmapping from the DSP address space

This commit adds the DRM_IOCTL_QDA_REMOTE_MUNMAP ioctl and FastRPC prepare
handlers to allow user space to unmap plain and attribute-based buffer
mappings from the DSP address space.

> diff --git a/drivers/accel/qda/qda_fastrpc.c b/drivers/accel/qda/qda_fast=
rpc.c
> index 744d7317cbe11..dbd14cd07cb20 100644
> --- a/drivers/accel/qda/qda_fastrpc.c
> +++ b/drivers/accel/qda/qda_fastrpc.c
> @@ -1072,6 +1072,73 @@ static int qda_fastrpc_prepare_args_mem_map(struct=
 qda_fastrpc_invoke_ctx *ctx,
>  	return err;
>  }
> =20
> +/*
> + * INIT_MUNMAP packed layout:
> + *   [0] req	sizeof(qda_fastrpc_munmap_req_msg)	IN
> + */
> +static int qda_fastrpc_prepare_args_munmap(struct qda_fastrpc_invoke_ctx=
 *ctx, void *argp)
> +{
> +	struct drm_qda_mem_unmap *uargs =3D argp;
> +	struct qda_fastrpc_munmap_req_msg *req;
> +	struct qda_gem_obj *kernel_gem;
> +	int err;
> +
> +	ctx->sc =3D QDA_FASTRPC_SCALARS(QDA_FASTRPC_RMID_INIT_MUNMAP, 1, 0);
> +	ctx->handle =3D QDA_FASTRPC_INIT_HANDLE;
> +
> +	err =3D alloc_kernel_args(ctx, 1);
> +	if (err)
> +		return err;
> +
> +	kernel_gem =3D alloc_kernel_gem(ctx, sizeof(*req));
> +	if (IS_ERR(kernel_gem))
> +		return PTR_ERR(kernel_gem);
> +
> +	req =3D kernel_gem->virt;
> +	req->remote_session_id =3D ctx->session->remote_session_id;
> +	req->vaddr =3D uargs->vaddrout;
> +	req->size =3D uargs->size;
> +
> +	assign_kernel_gem_arg(ctx, 0, kernel_gem, req, sizeof(*req));
> +	drm_gem_object_put(&kernel_gem->base);
> +
> +	return 0;
> +}
> +
> +/*
> + * INIT_MEM_UNMAP packed layout:
> + *   [0] req	sizeof(qda_fastrpc_mem_unmap_req_msg)	IN
> + */
> +static int qda_fastrpc_prepare_args_mem_unmap(struct qda_fastrpc_invoke_=
ctx *ctx, void *argp)
> +{
> +	struct drm_qda_mem_unmap *uargs =3D argp;
> +	struct qda_fastrpc_mem_unmap_req_msg *req;
> +	struct qda_gem_obj *kernel_gem;
> +	int err;
> +
> +	ctx->sc =3D QDA_FASTRPC_SCALARS(QDA_FASTRPC_RMID_INIT_MEM_UNMAP, 1, 0);
> +	ctx->handle =3D QDA_FASTRPC_INIT_HANDLE;
> +
> +	err =3D alloc_kernel_args(ctx, 1);
> +	if (err)
> +		return err;
> +
> +	kernel_gem =3D alloc_kernel_gem(ctx, sizeof(*req));
> +	if (IS_ERR(kernel_gem))
> +		return PTR_ERR(kernel_gem);
> +
> +	req =3D kernel_gem->virt;
> +	req->remote_session_id =3D ctx->session->remote_session_id;
> +	req->handle =3D uargs->dsp_handle;
> +	req->vaddrin =3D uargs->vaddr;
> +	req->len =3D uargs->size;
> +
> +	assign_kernel_gem_arg(ctx, 0, kernel_gem, req, sizeof(*req));
> +	drm_gem_object_put(&kernel_gem->base);
> +
> +	return 0;
> +}

[Severity: High]
Can leaving the GEM object lifetime entirely to user space while a DSP
mapping is active lead to DMA use-after-free?

During qda_ioctl_mmap(), setup_mmap_pages() acquires ctx->map_obj only for
the duration of the MMAP RPC, and qda_fastrpc_context_free() drops it as
soon as the ioctl completes:

drivers/accel/qda/qda_fastrpc.c:qda_fastrpc_context_free() {
	...
	if (ctx->map_obj)
		drm_gem_object_put(ctx->map_obj);
	...
}

While the mapping remains live on the DSP between DRM_IOCTL_QDA_REMOTE_MMAP
and DRM_IOCTL_QDA_REMOTE_MUNMAP, the kernel does not track the mapping on
struct qda_session or hold a drm_gem_object reference.

If user space closes the GEM handle via DRM_IOCTL_GEM_CLOSE before calling
DRM_IOCTL_QDA_REMOTE_MUNMAP (or if qda_rpmsg_wait_for_rsp() is interrupted
by a signal after the map request was sent so user space never receives
vaddrout), qda_gem_free_object() immediately frees the DMA buffer and its
IOVA in session->assigned_iommu_dev while the DSP mapping is still active.

Because session->assigned_iommu_dev is also used by alloc_kernel_gem() and
qda_fastrpc_invoke_pack() to allocate internal FastRPC request and payload
buffers, can the freed IOVA be reused for kernel RPC messages while an
unprivileged DSP user process still has vaddrout mapped to it?

Furthermore, even if user space keeps the handle open, when a process exits
or is killed while a mapping is active, drm_file_free() runs
drm_gem_release() before dev->driver->postclose() (qda_postclose()):

drivers/gpu/drm/drm_file.c:drm_file_free()
  -> drm_gem_release()
  -> qda_postclose()
       -> qda_release_dsp_process()

Doesn't this free and unmap all GEM buffers while the DSP process is still
running and before qda_release_dsp_process() tears it down? Also, because
active mappings are not tracked by the kernel,
qda_fastrpc_prepare_args_munmap() and qda_fastrpc_prepare_args_mem_unmap()
forward arbitrary user-supplied vaddr/vaddrout, size, and dsp_handle values
to QDA_FASTRPC_INIT_HANDLE without verifying that they match an existing
mapping.

> diff --git a/drivers/accel/qda/qda_ioctl.c b/drivers/accel/qda/qda_ioctl.c
> index cd3cea72f50e8..17d1b488b4a9b 100644
> --- a/drivers/accel/qda/qda_ioctl.c
> +++ b/drivers/accel/qda/qda_ioctl.c
> @@ -197,6 +197,30 @@ int qda_ioctl_mmap(struct drm_device *dev, void *dat=
a, struct drm_file *file_pri
>  	}
>  }
> =20
> +/**
> + * qda_ioctl_munmap() - Remove a buffer's mapping from the DSP's address=
 space
> + * @dev: DRM device structure
> + * @data: User-space data (struct drm_qda_mem_unmap)
> + * @file_priv: DRM file private data
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +int qda_ioctl_munmap(struct drm_device *dev, void *data, struct drm_file=
 *file_priv)
> +{
> +	struct drm_qda_mem_unmap *unmap_req =3D data;
> +
> +	switch (unmap_req->request) {
> +	case QDA_REQUEST_MUNMAP:
> +		return qda_fastrpc_invoke(QDA_FASTRPC_RMID_INIT_MUNMAP, data,
> +					  file_priv->driver_priv);
> +	case QDA_REQUEST_MEM_UNMAP:
> +		return qda_fastrpc_invoke(QDA_FASTRPC_RMID_INIT_MEM_UNMAP, data,
> +					  file_priv->driver_priv);
> +	default:
> +		return -EINVAL;
> +	}
> +}

[Severity: High]
Can calling qda_fastrpc_invoke() from qda_ioctl_munmap() race with
qda_fastrpc_flush_pending() during rpmsg teardown and cause a refcount
underflow and use-after-free on struct qda_fastrpc_invoke_ctx?

In qda_fastrpc_invoke(), qda_fastrpc_context_alloc() initializes
ctx->refcount to 1 and inserts ctx into qdev->ctx_xa before the message is
prepared or sent:

drivers/accel/qda/qda_fastrpc.c:qda_fastrpc_context_alloc() {
	...
	kref_init(&ctx->refcount);
	...
	ret =3D xa_alloc(&qdev->ctx_xa, &id, ctx, XA_LIMIT(1, QDA_FASTRPC_CTXID_MA=
X),
		       GFP_KERNEL);
	...
}

The second reference on ctx->refcount for the response handler is only
taken later in qda_rpmsg_send_msg(), and is dropped immediately if
rpmsg_send() fails or asynchronously via ctx->put_work after qda_rpmsg_cb()
runs. However, ctx is only erased from qdev->ctx_xa inside
qda_fastrpc_context_free() when the final reference is dropped.

If qda_rpmsg_remove() runs concurrently and calls
qda_fastrpc_flush_pending():

drivers/accel/qda/qda_fastrpc.c:qda_fastrpc_flush_pending() {
	...
	xa_for_each(&qdev->ctx_xa, idx, ctx) {
		ctx->retval =3D -EPIPE;
		complete(&ctx->work);
		kref_put(&ctx->refcount, qda_fastrpc_context_free);
	}
}

while an invocation in qda_fastrpc_invoke() is still in
qda_fastrpc_prepare_args() or qda_fastrpc_invoke_pack(), or after
qda_rpmsg_send_msg() failed (for example with -ENODEV at drm_dev_enter()),
or after qda_rpmsg_cb() already queued ctx->put_work, won't
qda_fastrpc_flush_pending() drop a reference that was never held by the
pending response path, freeing ctx before the caller or worker drops its
own reference?

> diff --git a/include/uapi/drm/qda_accel.h b/include/uapi/drm/qda_accel.h
> index bd2d0f4308b10..43598ddef461d 100644
> --- a/include/uapi/drm/qda_accel.h
> +++ b/include/uapi/drm/qda_accel.h
[ ... ]
> @@ -173,6 +180,29 @@ struct drm_qda_mem_map {
>  	__u64 vaddrout;
>  };
> =20
> +/**
> + * struct drm_qda_mem_unmap - Parameters for removing a DSP mapping
> + * @request: QDA_REQUEST_MUNMAP or QDA_REQUEST_MEM_UNMAP
> + * @dsp_handle: Identifier the DSP tracks the buffer by (QDA_REQUEST_MEM=
_UNMAP)
> + * @vaddr: Address the mapping was made at (QDA_REQUEST_MEM_UNMAP)
> + * @vaddrout: Address the mapping was made at (QDA_REQUEST_MUNMAP)
> + * @size: Length of the mapping in bytes
> + *
> + * Removes a mapping made with DRM_IOCTL_QDA_REMOTE_MMAP, named by the a=
ddress
> + * that call returned in drm_qda_mem_map.vaddrout. The request must matc=
h the
> + * one the mapping was made with: QDA_REQUEST_MUNMAP uses @vaddrout and =
@size,
> + * QDA_REQUEST_MEM_UNMAP uses @dsp_handle, @vaddr and @size. The buffer =
is not
> + * affected, so its handle must stay open for as long as the DSP uses the
> + * mapping.
> + */
> +struct drm_qda_mem_unmap {
> +	__u32 request;
> +	__s32 dsp_handle;
> +	__u64 vaddr;
> +	__u64 vaddrout;
> +	__u64 size;
> +};

[Severity: Low]
As reported by Sashiko on v1 [1], struct drm_qda_mem_unmap defines two
separate address fields (vaddr and vaddrout) for the same DSP virtual
address returned in drm_qda_mem_map.vaddrout, and qda_ioctl_munmap() does
not verify that the fields unused by the selected request type (dsp_handle
and vaddr for QDA_REQUEST_MUNMAP, or vaddrout for QDA_REQUEST_MEM_UNMAP)
are zero. Could a single address field be used here, with unused fields
checked for zero in qda_ioctl_munmap()?

[1] https://lore.kernel.org/r/20260519-qda-series-v1-15-b2d984c297f8@oss.qu=
alcomm.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-v4-v4-0-88=
f2f24a5f0b@qti.qualcomm.com?part=3D18
