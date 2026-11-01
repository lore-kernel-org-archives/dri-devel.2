Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBA3606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 22:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=caCAj5x0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2813110E4E5;
	Sun,  1 Nov 2026 22:47:49 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEB8F10E4E5
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 22:47:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9A0FE601FF;
 Sun,  1 Nov 2026 22:47:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2F01F00919;
 Sun,  1 Nov 2026 22:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793573262;
 bh=LrLY1iI1NzwTi2CmkbLiDGLNp4jsblhx5btv9Q4sQuY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=caCAj5x0gkmDzHzVLvAwRhUSPClBegV0P4nZ8FXYVRrZDIZ/yZ8cVFnwOMtX+7/lk
 XmRUcd1A7lPlFL++JPX+E2mLvTFcsSSqOb5v5wQJOLoBVg8xdc383WfIIadrJUbRl4
 e/wn31M1gwibADhGZkMaENQY/39HPo0VKJrfm7+8NVc29We0DSZX8dQpoeuPacMnng
 lkKtBVckfs3bGC5OQKBoQWSa1fsndXyyYLLFdv+yhtkI21/Bbkz6nL9ysFg+T7rmBs
 dA4oXGfmqjTULgoQwTmk5UIzi75IMKeZ/9V/swOk1Z9i2v2v0L+ktSuwDsw35d4QWn
 3n+1685Vi5+ow==
Message-ID: <sashiko-outbox-192733@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 14/25] accel/qda: Add invocation through the legacy
 FastRPC shim
To: "Ekansh Gupta" <ekansh.gupta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261102-v4-v4-14-88f2f24a5f0b@qti.qualcomm.com>
References: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
 <20261102-v4-v4-14-88f2f24a5f0b@qti.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 22:47:41 +0000
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] accel/qda: missing VMA and size checks in process_msg_buffer()
- [High] accel/qda: broken fd and handle semantics in legacy invoke path
- [High] accel/qda: premature unmap of legacy DMA handle args in qda_fastrp=
c_context_free()
- [High] accel/qda: premature ctx_xa publication in qda_fastrpc_invoke_lega=
cy()
- [High] accel/qda: race with unplug teardown in qda_shim_invoke()
--

commit db6b9ba28a99a54082c1f760f47bf540c628d123
Author: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

accel/qda: Add invocation through the legacy FastRPC shim

This commit adds FASTRPC_IOCTL_INVOKE support to the legacy FastRPC
compatibility shim by importing each fd-backed argument into the session's
context bank and passing the resolved GEM objects into
qda_fastrpc_invoke_legacy(). Buffer offsets for legacy arguments are
derived from the caller's VMA mapping in process_msg_buffer().

> diff --git a/drivers/accel/qda/qda_fastrpc.c b/drivers/accel/qda/qda_fast=
rpc.c
> index 3a1959e2c53ee..693dd6f035d2a 100644
> --- a/drivers/accel/qda/qda_fastrpc.c
> +++ b/drivers/accel/qda/qda_fastrpc.c
> @@ -55,6 +55,22 @@ static void setup_pages_from_gem_obj(struct qda_gem_ob=
j *qda_gem_obj,
>  	pages->size =3D qda_gem_obj->size;
>  }
> =20
> +static int calculate_vma_offset(u64 user_ptr, u64 *offset)
> +{
> +	struct vm_area_struct *vma;
> +	int ret =3D -EFAULT;
> +
> +	mmap_read_lock(current->mm);
> +	vma =3D find_vma(current->mm, user_ptr);
> +	if (vma && vma->vm_start <=3D user_ptr) {
> +		*offset =3D (user_ptr & PAGE_MASK) - vma->vm_start;
> +		ret =3D 0;
> +	}
> +	mmap_read_unlock(current->mm);
> +
> +	return ret;
> +}
> +
>  static u64 calculate_page_aligned_size(u64 addr, u64 len)
>  {
>  	u64 pg_start =3D (addr & PAGE_MASK) >> PAGE_SHIFT;
> @@ -286,23 +302,45 @@ struct qda_fastrpc_invoke_ctx *qda_fastrpc_context_=
alloc(struct qda_dev *qdev)
>  }
> =20
>  /*
> - * Resolve the address of an in/out buffer argument. The buffer is named=
 by a
> - * GEM handle, looked up in the calling session's own handle table, so a
> - * session cannot name another's buffer. The offset and length come from=
 user
> - * space and are checked against the buffer's real size: a region descri=
bed as
> - * larger than its buffer would let the DSP read and write past the end =
of it,
> - * into whatever else is mapped in the same context bank.
> + * Resolve the address of an in/out buffer argument. The buffer is eithe=
r a
> + * GEM object the legacy shim already resolved into ctx->gem_objs[i], or=
 a GEM
> + * handle looked up in the calling session's own handle table. For a han=
dle,
> + * the offset and length come from user space and are checked against the
> + * buffer's real size: a region described as larger than its buffer woul=
d let
> + * the DSP read and write past the end of it, into whatever else is mapp=
ed in
> + * the same context bank.
>   */
>  static int process_msg_buffer(struct qda_fastrpc_invoke_ctx *ctx, int i,
>  			      union qda_remote_arg *rpra,
>  			      struct qda_phy_page *pages)
>  {
>  	u64 len =3D ctx->args[i].length;
> -	struct qda_gem_obj *qda_gem_obj;
>  	struct drm_gem_object *gem_obj;
> +	struct qda_gem_obj *qda_gem_obj;
>  	u64 unaligned_addr;
> +	u64 vma_offset =3D 0;
>  	int err;
> =20
> +	if (ctx->gem_objs[i]) {
> +		/*
> +		 * The legacy ABI predates GEM handles, so the offset field
> +		 * holds an address in the caller's own mapping of the buffer,
> +		 * or 0 if it has none, meaning the start of the buffer.
> +		 */
> +		qda_gem_obj =3D to_qda_gem_obj(ctx->gem_objs[i]);
> +		if (ctx->args[i].offset) {
> +			err =3D calculate_vma_offset(ctx->args[i].offset, &vma_offset);
> +			if (err)
> +				return err;
> +		}
> +
> +		rpra[i].buf.addr =3D ctx->args[i].offset;
> +		pages[i].addr =3D qda_gem_obj->dma_addr + vma_offset;
> +		pages[i].size =3D calculate_page_aligned_size(ctx->args[i].offset, len=
);
> +
> +		return 0;
> +	}

[Severity: Critical]
Could this legacy buffer path in process_msg_buffer() in
drivers/accel/qda/qda_fastrpc.c allow out-of-bounds DSP DMA access or
Stream ID spoofing across context banks?

When qda_shim_invoke() -> qda_fastrpc_invoke_legacy() ->
qda_fastrpc_invoke_common() -> qda_fastrpc_invoke_pack() ->
qda_fastrpc_get_args() -> process_msg_buffer() resolves a buffer with
ctx->gem_objs[i] set, calculate_vma_offset() looks up any VMA in
current->mm containing user_ptr and computes:

    *offset =3D (user_ptr & PAGE_MASK) - vma->vm_start;

without verifying that the VMA backs the imported DMA-BUF for
ctx->gem_objs[i] or accounting for vma->vm_pgoff.

Unlike the GEM handle path below it, which checks:

    if (ctx->args[i].offset > qda_gem_obj->size ||
        len > qda_gem_obj->size - ctx->args[i].offset)

and unlike fastrpc_map_attach() in drivers/misc/fastrpc.c, which checks
len > map->size, the legacy branch in process_msg_buffer() does not check
vma_offset, the in-page offset (ctx->args[i].offset & ~PAGE_MASK), or len
against qda_gem_obj->size.

As a result, passing a length or VMA offset larger than qda_gem_obj->size
sets pages[i].addr and pages[i].size to a range extending past the end of
qda_gem_obj into adjacent mappings in the session's IOMMU context bank,
such as ctx->msg_gem_obj. In addition, because qda_gem_obj->dma_addr
encodes the session's Stream ID at soc_data->sid_pos (bit 32 on
default_soc_data), passing a user_ptr inside a large anonymous VMA so that
vma_offset >=3D (1ULL << 32) causes qda_gem_obj->dma_addr + vma_offset to
carry into the Stream ID bits and target another session's context bank.

Finally, because ctx->args[i].offset and len are unvalidated 64-bit values
on this path, addr + len - 1 and (pg_end - pg_start + 1) * PAGE_SIZE in
calculate_page_aligned_size() can overflow 64-bit arithmetic and wrap
pages[i].size to a small value or zero.

Should calculate_vma_offset() and process_msg_buffer() verify that the
offset and length stay within qda_gem_obj->size without overflowing?

[ ... ]

> @@ -551,6 +589,105 @@ int qda_fastrpc_invoke_common(struct qda_dev *qdev,=
 struct qda_fastrpc_invoke_ct
>  	return 0;
>  }
> =20
> +/**
> + * qda_fastrpc_invoke_legacy() - Perform a dynamic invocation on behalf =
of the legacy shim
> + * @qdev: Device to invoke on
> + * @session: Legacy session (no backing drm_file)
> + * @handle: Remote handle to invoke on the DSP
> + * @sc: FastRPC scalars value encoding the number of in/out buffers
> + * @legacy_args: Kernel-side argument array, one entry per QDA_REMOTE_SC=
ALARS_LENGTH(sc)
> + *
> + * Unlike the accel UAPI path, the argument descriptors and any backing =
GEM
> + * objects already live in kernel memory: the shim has already resolved
> + * every fd-backed argument via its own import path, since a legacy sess=
ion
> + * has no GEM handle table to resolve a handle-based argument against.
> + * Ownership of each @legacy_args[i].obj reference transfers to this fun=
ction,
> + * on failure as well as on success.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +int qda_fastrpc_invoke_legacy(struct qda_dev *qdev, struct qda_session *=
session,
> +			      u32 handle, u32 sc, struct qda_legacy_invoke_arg *legacy_args)
> +{
> +	struct qda_fastrpc_invoke_ctx *ctx;
> +	struct drm_qda_fastrpc_invoke_args *args;
> +	u32 nscalars;
> +	int err;
> +	int i;
> +
> +	nscalars =3D QDA_REMOTE_SCALARS_LENGTH(sc);
> +
> +	/*
> +	 * An fd naming a buffer another session exported resolves to the
> +	 * original object, still mapped in that session's context bank, so
> +	 * the same check as for a handle applies.
> +	 */
> +	for (i =3D 0; i < nscalars; ++i) {
> +		if (legacy_args[i].obj &&
> +		    to_qda_gem_obj(legacy_args[i].obj)->iommu_dev !=3D session->assign=
ed_iommu_dev) {
> +			err =3D -EACCES;
> +			goto err_put_legacy_objs;
> +		}
> +	}
> +
> +	ctx =3D qda_fastrpc_context_alloc(qdev);
> +	if (IS_ERR(ctx)) {
> +		err =3D PTR_ERR(ctx);
> +		goto err_put_legacy_objs;
> +	}
> +
> +	/* Dropped by qda_fastrpc_context_free(), as for the accel UAPI path */
> +	qda_session_get(session);
> +	ctx->session =3D session;
> +	ctx->handle =3D handle;
> +	ctx->sc =3D sc;
> +
> +	ctx->nbufs =3D QDA_REMOTE_SCALARS_INBUFS(sc) + QDA_REMOTE_SCALARS_OUTBU=
FS(sc);
> +	if (nscalars) {
> +		args =3D kzalloc_objs(*args, nscalars);
> +		if (!args) {
> +			err =3D -ENOMEM;
> +			goto err_put_legacy_objs_ctx;
> +		}
> +
> +		ctx->gem_objs =3D kzalloc_objs(*ctx->gem_objs, nscalars);
> +		if (!ctx->gem_objs) {
> +			kfree(args);
> +			err =3D -ENOMEM;
> +			goto err_put_legacy_objs_ctx;
> +		}
> +
> +		for (i =3D 0; i < nscalars; ++i) {
> +			args[i].offset =3D legacy_args[i].ptr;
> +			args[i].length =3D legacy_args[i].length;
> +			/* process_dma_handle() skips handle args whose handle is 0 */
> +			args[i].handle =3D (i >=3D ctx->nbufs && legacy_args[i].obj) ?
> +					 (u32)legacy_args[i].fd : 0;
> +			ctx->gem_objs[i] =3D legacy_args[i].obj;
> +		}

[Severity: High]
Won't moving the sole reference to legacy_args[i].obj into ctx->gem_objs[i]
for DMA handle arguments (i >=3D ctx->nbufs) in qda_fastrpc_invoke_legacy()
cause them to be unmapped from the SMMU context bank as soon as the
invocation finishes?

In qda_shim_invoke(), shim_import_fd() imports each fd via
qda_prime_import_dmabuf(), returning a drm_gem_object with a single
reference for any external DMA-BUF (or once user space closes its fd).
When the invocation finishes, qda_fastrpc_context_free() drops every entry
in ctx->gem_objs:

    if (ctx->gem_objs) {
        for (i =3D 0; i < ctx->nscalars; ++i) {
            if (ctx->gem_objs[i])
                drm_gem_object_put(ctx->gem_objs[i]);
        }
        kfree(ctx->gem_objs);
    }

Unlike drivers/misc/fastrpc.c (where fastrpc_create_maps() retains handle
mappings on fl->maps across invocations until the DSP returns their fd in
fdlist) and unlike the accel UAPI path (where ctx->session->file holds a
GEM handle reference until qda_fastrpc_cleanup_handlelist() deletes it),
qda_fastrpc_context_free() drops the last reference on DMA handle objects
immediately on return, unmapping them while the DSP still holds their IOVA.
Moreover, qda_fastrpc_cleanup_handlelist() checks if (ctx->session->file),
which is always NULL for legacy sessions.

How are DMA handle mappings meant to stay alive across invocations and be
released via handlelist for legacy sessions?

> +
> +		ctx->args =3D args;
> +	}
> +
> +	ctx->nscalars =3D nscalars;
> +
> +	err =3D qda_fastrpc_invoke_common(qdev, ctx);
> +
> +	kref_put(&ctx->refcount, qda_fastrpc_context_free);

[Severity: High]
Can a concurrent call to qda_rpmsg_remove() -> qda_fastrpc_flush_pending()
drop the only reference on ctx and cause a use-after-free and double put in
qda_fastrpc_invoke_legacy()?

In qda_fastrpc_invoke_legacy(), qda_fastrpc_context_alloc() initializes
ctx->refcount to 1 and immediately inserts ctx into qdev->ctx_xa via
xa_alloc(), before ctx->session, ctx->args, and ctx->gem_objs are populated
and before qda_rpmsg_send_msg() takes the second reference for the response
path.

Because qda_shim_ioctl() only performs a lockless drm_dev_is_unplugged()
check rather than holding a drm_dev_enter() section across the ioctl,
qda_rpmsg_remove() can run concurrently and call
qda_fastrpc_flush_pending():

    xa_for_each(&qdev->ctx_xa, idx, ctx) {
        ctx->retval =3D -EPIPE;
        complete(&ctx->work);
        kref_put(&ctx->refcount, qda_fastrpc_context_free);
    }

If qda_fastrpc_flush_pending() runs before qda_rpmsg_send_msg() acquires
the second reference (or after qda_rpmsg_send_msg() fails with -ENODEV), it
drops ctx->refcount from 1 to 0 and frees ctx while
qda_fastrpc_invoke_legacy() is still using it, followed by a second
kref_put() on the freed ctx when qda_fastrpc_invoke_legacy() returns.

[ ... ]

> diff --git a/drivers/accel/qda/qda_fastrpc_shim.c b/drivers/accel/qda/qda=
_fastrpc_shim.c
> index 25f5c242efde1..03fce990ccdb9 100644
> --- a/drivers/accel/qda/qda_fastrpc_shim.c
> +++ b/drivers/accel/qda/qda_fastrpc_shim.c

[ ... ]

> @@ -50,6 +52,25 @@ struct qda_shim_dev {
> =20
>  static const struct file_operations qda_shim_fops;
> =20
> +/* A negative @fd means the argument has no buffer, which is not an erro=
r */
> +static struct drm_gem_object *shim_import_fd(struct qda_session *session=
, s32 fd)
> +{
> +	struct drm_gem_object *obj;
> +	struct dma_buf *dmabuf;
> +
> +	if (fd < 0)
> +		return NULL;
> +
> +	dmabuf =3D dma_buf_get(fd);
> +	if (IS_ERR(dmabuf))
> +		return ERR_CAST(dmabuf);
> +
> +	obj =3D qda_legacy_ops_table.import_dmabuf(session, dmabuf);
> +	dma_buf_put(dmabuf);
> +
> +	return obj;
> +}
> +
>  static int qda_shim_open(struct inode *inode, struct file *file)
>  {
>  	struct qda_shim_node *snode =3D container_of(file->private_data, struct=
 qda_shim_node,
> @@ -120,11 +141,77 @@ static long qda_shim_alloc_dma_buf(struct qda_shim_=
file *sf, void __user *argp)
>  	return 0;
>  }
> =20
> +static long qda_shim_invoke(struct qda_shim_file *sf, void __user *argp)
> +{
> +	struct qda_legacy_invoke_arg *largs;
> +	struct fastrpc_invoke_args *uargs;
> +	struct fastrpc_invoke args;
> +	u32 nargs;
> +	int err;
> +	int i;
> +
> +	if (copy_from_user(&args, argp, sizeof(args)))
> +		return -EFAULT;
> +
> +	nargs =3D QDA_REMOTE_SCALARS_LENGTH(args.sc);
> +	if (!nargs)
> +		return qda_legacy_ops_table.invoke(sf->session, args.handle, args.sc, =
NULL);
> +
> +	uargs =3D kcalloc(nargs, sizeof(*uargs), GFP_KERNEL);
> +	if (!uargs)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(uargs, u64_to_user_ptr(args.args), nargs * sizeof(*u=
args))) {
> +		kfree(uargs);
> +		return -EFAULT;
> +	}
> +
> +	largs =3D kcalloc(nargs, sizeof(*largs), GFP_KERNEL);
> +	if (!largs) {
> +		kfree(uargs);
> +		return -ENOMEM;
> +	}
> +
> +	for (i =3D 0; i < nargs; ++i) {
> +		struct drm_gem_object *obj;
> +
> +		largs[i].ptr =3D uargs[i].ptr;
> +		largs[i].length =3D uargs[i].length;
> +		largs[i].fd =3D uargs[i].fd;
> +
> +		obj =3D shim_import_fd(sf->session, uargs[i].fd);
> +		if (IS_ERR(obj)) {
> +			err =3D PTR_ERR(obj);
> +			goto err_put_objs;
> +		}
> +		largs[i].obj =3D obj;
> +	}

[Severity: High]
Does the fd handling across shim_import_fd(), qda_fastrpc_invoke_legacy(),
process_msg_buffer(), and process_dma_handle() break several valid legacy
FASTRPC_IOCTL_INVOKE argument patterns?

1. In drivers/misc/fastrpc.c, fastrpc_create_maps() skips importing
   arguments when fd =3D=3D 0, fd =3D=3D -1, or length =3D=3D 0. Here, qda_=
shim_invoke()
   calls shim_import_fd() even when uargs[i].length =3D=3D 0, and
   shim_import_fd() only returns NULL for fd < 0. If user space passes a
   zero-initialized descriptor (fd =3D=3D 0, length =3D=3D 0) or fd =3D=3D =
0 for an
   unbacked argument, shim_import_fd() calls dma_buf_get(0) (typically
   stdin) and fails the ioctl with -EINVAL or -EBADF.

2. Conversely, if a DMA handle argument (i >=3D ctx->nbufs) genuinely uses
   fd =3D=3D 0 and shim_import_fd() imports it into legacy_args[i].obj,
   qda_fastrpc_invoke_legacy() sets:

       args[i].handle =3D (i >=3D ctx->nbufs && legacy_args[i].obj) ?
                        (u32)legacy_args[i].fd : 0;

   which evaluates to 0. In process_dma_handle(), the check for
   !ctx->args[i].handle runs before checking ctx->gem_objs[i], so fd 0 is
   treated as having no buffer and setup_pages_from_gem_obj() is skipped.

3. For a buffer argument (i < ctx->nbufs) with fd < 0 and length > 0,
   shim_import_fd() returns NULL ("not an error"), leaving
   ctx->gem_objs[i] =3D=3D NULL and ctx->args[i].handle =3D=3D 0. When
   qda_fastrpc_get_args() calls process_msg_buffer(), both
   ctx->gem_objs[i] and ctx->args[i].handle are 0, so process_msg_buffer()
   immediately returns -EINVAL.

> +
> +	kfree(uargs);
> +
> +	/* Takes ownership of every largs[i].obj, whether or not it succeeds */
> +	err =3D qda_legacy_ops_table.invoke(sf->session, args.handle, args.sc, =
largs);

[Severity: High]
What prevents qda_rpmsg_remove() from tearing down the device while
qda_shim_invoke() is importing buffers and building the invocation in
drivers/accel/qda/qda_fastrpc_shim.c?

In qda_shim_ioctl(), the unplug check is a lockless call to
drm_dev_is_unplugged(&sf->session->qda_dev->drm_dev), and drm_dev_enter()
is not acquired until qda_rpmsg_send_msg().

If qda_rpmsg_remove() runs right after qda_shim_ioctl() passes
drm_dev_is_unplugged(), drm_dev_unplug() completes immediately without
waiting for in-flight shim ioctls, and qda_rpmsg_remove() proceeds to run:

    qda_fastrpc_flush_pending(qdev);
    qda_cb_unpopulate(qdev);
    qda_deinit_device(qdev);

This destroys the context bank platform devices (of_platform_device_destroy=
),
frees qdev->iommu_mgr->devices, and destroys assignment_lock,
qdev->ctx_xa, and qdev->import_lock while qda_shim_invoke() ->
shim_import_fd() -> qda_prime_import_dmabuf() and
qda_fastrpc_invoke_legacy() are concurrently accessing them.

Should qda_shim_ioctl() guard the dispatch call with drm_dev_enter() and
drm_dev_exit() so that drm_dev_unplug() waits for in-flight legacy ioctls
to finish before tearing down the device?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-v4-v4-0-88=
f2f24a5f0b@qti.qualcomm.com?part=3D14
