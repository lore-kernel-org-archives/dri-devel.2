Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA24606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 22:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LTuXI7AH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 385B610EAD4;
	Sun,  1 Nov 2026 22:57:36 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D16610EAD4
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 22:57:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1446240B0B;
 Sun,  1 Nov 2026 22:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4EB61F000C1;
 Sun,  1 Nov 2026 22:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793573850;
 bh=Bb0+97KjgwSdtxPnH+/QFR7YNr1orRn4BcPB0HrjLFw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LTuXI7AHowW+kgxs3T0DrKZ/WqBsjGqvrCUsIx03qiirXPogw2DLbpj23ZhDFYAu5
 ZPRBmrgrSL94jZ9igyDakG0Vo8v6SdXSoE51/0pR2YbpEH9sktlscL3NpB7l28P7Du
 PtGGNQbvRDTskAJMXkWTIm0K3DsPOvS8dGAk7U7hDYMUb9e1wIV2kG7sHtBznUo+OL
 S1sAJWZgV3MOuFJ/VMKqAtJfVUL1luOlpVcucktV2HlR8clR++SPfqj7M8v7yHiecc
 Fox7L1GrYpFkhXyBcNuXM+FkDqv3mZ4qlQXQNl3QIFF74BjYCTJapsaMMlpCeCMmKO
 K5l/600M8VhBQ==
Message-ID: <sashiko-outbox-192744@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 19/25] accel/qda: Add remote memory map and unmap to
 the legacy shim
To: "Ekansh Gupta" <ekansh.gupta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261102-v4-v4-19-88f2f24a5f0b@qti.qualcomm.com>
References: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
 <20261102-v4-v4-19-88f2f24a5f0b@qti.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 22:57:29 +0000
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
- [Critical] accel/qda: use-after-free race on placeholder in qda_shim_mem_=
map()
- [High] accel/qda: unmap size mismatch in qda_shim_mmap() when size is 0
- [High] accel/qda: missing unplug check in shim_mappings_release() on close
- [High] accel/qda: premature buffer release when legacy unmap fails or is =
interrupted
- [Medium] accel/qda: race in shim_mapping_detach() and shim_mapping_attach=
()
- [Medium] accel/qda: missing offset bounds check in setup_mmap_pages()
--

commit b1739b465f1ac98dac259c9a90724960699924f1
Author: Ekansh Gupta <ekangupt@qti.qualcomm.com>

accel/qda: Add remote memory map and unmap to the legacy shim

This commit implements the four legacy FastRPC memory map and unmap ioctls
in the QDA compatibility shim by importing DMA-BUF file descriptors and
tracking live mappings per open file so buffers remain referenced while
mapped on the DSP.

> diff --git a/drivers/accel/qda/qda_fastrpc.c b/drivers/accel/qda/qda_fast=
rpc.c
> index dbd14cd07cb20..b35604fce630c 100644
> --- a/drivers/accel/qda/qda_fastrpc.c
> +++ b/drivers/accel/qda/qda_fastrpc.c

[ ... ]

> @@ -935,19 +935,33 @@ static int qda_fastrpc_prepare_args_init_create(str=
uct qda_fastrpc_invoke_ctx *c
>   * buffer is held by the context until the request is done, so that clos=
ing its
>   * handle meanwhile cannot free memory the DSP is being told to map. The
>   * region must fit in the buffer, as the DSP would otherwise map past it=
s end.
> + *
> + * A caller with no handle table supplies the buffer already imported. I=
t is
> + * checked as a buffer named by handle would be: an fd can name a buffer=
 that
> + * another session exported, which resolves to the original object, still
> + * mapped in that session's context bank.
>   */
> -static int setup_mmap_pages(struct qda_fastrpc_invoke_ctx *ctx, struct d=
rm_qda_mem_map *margs,
> +static int setup_mmap_pages(struct qda_fastrpc_invoke_ctx *ctx, struct q=
da_mem_map_args *args,
>  			    struct qda_phy_page *pages)
>  {
> +	struct drm_qda_mem_map *margs =3D &args->map;
>  	struct qda_gem_obj *qda_gem_obj;
>  	int err;
> =20
> -	if (!margs->handle)
> -		return -EINVAL;
> +	if (args->obj) {
> +		if (to_qda_gem_obj(args->obj)->iommu_dev !=3D ctx->session->assigned_i=
ommu_dev)
> +			return -EACCES;
> =20
> -	err =3D get_gem_obj_from_handle(ctx, margs->handle, &ctx->map_obj);
> -	if (err)
> -		return err;
> +		drm_gem_object_get(args->obj);
> +		ctx->map_obj =3D args->obj;
> +	} else {
> +		if (!margs->handle)
> +			return -EINVAL;
> +
> +		err =3D get_gem_obj_from_handle(ctx, margs->handle, &ctx->map_obj);
> +		if (err)
> +			return err;
> +	}
> =20
>  	qda_gem_obj =3D to_qda_gem_obj(ctx->map_obj);
>  	if (margs->size > qda_gem_obj->size)
>  		return -EINVAL;
> =20
>  	pages->addr =3D qda_gem_obj->dma_addr;
>  	pages->size =3D margs->size ? margs->size : qda_gem_obj->size;

[Severity: Medium]
Can a caller of FASTRPC_IOCTL_MEM_MAP or DRM_IOCTL_QDA_REMOTE_MMAP (with
QDA_REQUEST_MEM_MAP) map past the end of qda_gem_obj by supplying a
non-zero margs->offset?

In qda_shim_mem_map(), only args.offset < 0 is rejected, and
qda_fastrpc_prepare_args_mem_map() only checks margs->offset > INT_MAX
before setting req->offset =3D margs->offset.

Here in setup_mmap_pages(), only margs->size > qda_gem_obj->size is
checked. If a caller passes 0 < margs->offset <=3D INT_MAX and
margs->size <=3D qda_gem_obj->size (including margs->size =3D=3D 0, which s=
ets
pages->size to qda_gem_obj->size) such that margs->offset + pages->size
exceeds qda_gem_obj->size, shouldn't setup_mmap_pages() also check that
margs->offset <=3D qda_gem_obj->size and pages->size <=3D qda_gem_obj->size=
 -
margs->offset?

> diff --git a/drivers/accel/qda/qda_fastrpc_shim.c b/drivers/accel/qda/qda=
_fastrpc_shim.c
> index 4a2ba20ee01ac..c46d2de4f5818 100644
> --- a/drivers/accel/qda/qda_fastrpc_shim.c
> +++ b/drivers/accel/qda/qda_fastrpc_shim.c

[ ... ]

> @@ -79,6 +101,83 @@ static struct drm_gem_object *shim_import_fd(struct q=
da_session *session, s32 fd
>  	return obj;
>  }
> =20
> +/* Takes ownership of @obj on success; on failure the caller still owns =
it */
> +static struct qda_shim_mapping *shim_mapping_add(struct qda_shim_file *s=
f,
> +						 struct list_head *list, u64 key, u64 vaddr,
> +						 u64 size, struct drm_gem_object *obj)
> +{
> +	struct qda_shim_mapping *m, *new;
> +
> +	new =3D kzalloc_obj(*new);
> +	if (!new)
> +		return ERR_PTR(-ENOMEM);
> +
> +	new->key =3D key;
> +	new->vaddr =3D vaddr;
> +	new->size =3D size;
> +	new->obj =3D obj;
> +
> +	guard(mutex)(&sf->maps_lock);
> +
> +	list_for_each_entry(m, list, node) {
> +		if (m->key =3D=3D key) {
> +			kfree(new);
> +			return ERR_PTR(-EEXIST);
> +		}
> +	}
> +	list_add_tail(&new->node, list);
> +
> +	return new;
> +}
> +
> +static struct qda_shim_mapping *shim_mapping_detach(struct qda_shim_file=
 *sf,
> +						    struct list_head *list, u64 key, u64 vaddr)
> +{
> +	struct qda_shim_mapping *m;
> +
> +	guard(mutex)(&sf->maps_lock);
> +
> +	list_for_each_entry(m, list, node) {
> +		if (m->key =3D=3D key && m->vaddr =3D=3D vaddr) {
> +			list_del(&m->node);
> +			return m;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +static void shim_mapping_attach(struct qda_shim_file *sf, struct list_he=
ad *list,
> +				struct qda_shim_mapping *m)
> +{
> +	guard(mutex)(&sf->maps_lock);
> +	list_add_tail(&m->node, list);
> +}

[Severity: Medium]
Can detaching a mapping in shim_mapping_detach() and dropping sf->maps_lock
before validating size or calling the blocking unmap RPC race with
concurrent map and unmap calls on the same open file?

First, in qda_shim_mem_unmap(), m is removed from sf->mem_map_list while
qda_legacy_ops_table.mem_unmap() runs without sf->maps_lock held. While m
is detached, its key (args.fd) is absent from sf->mem_map_list, so a
concurrent qda_shim_mem_map() with the same fd can pass the duplicate-key
check in shim_mapping_add() and insert a second entry with the same fd. If
the in-flight mem_unmap() then fails (for example, interrupted by a signal
with -ERESTARTSYS in wait_for_completion_interruptible()),
shim_mapping_attach() unconditionally appends m back onto sf->mem_map_list
with list_add_tail(), leaving duplicate fd keys in sf->mem_map_list.

Second, in both qda_shim_mmap() and qda_shim_mem_map(), m is visible on the
list before copy_to_user() runs. If a concurrent qda_shim_munmap() (for
example, with a mismatched args.size since m->size !=3D args.size is checked
after shim_mapping_detach()) or a failing qda_shim_mem_unmap() temporarily
detaches m while copy_to_user() faults, the error rollback call to
shim_mapping_detach() in the map path will return NULL and skip unmapping
and freeing m, after which the failing unmap path calls
shim_mapping_attach() and re-attaches m even though the map ioctl returned
-EFAULT.

> +
> +static void shim_mapping_free(struct qda_shim_mapping *m)
> +{
> +	drm_gem_object_put(m->obj);
> +	kfree(m);
> +}
> +
> +/* The DSP unmap comes first: the buffer must outlive the DSP's use of i=
t */
> +static void shim_mappings_release(struct qda_shim_file *sf)
> +{
> +	struct qda_shim_mapping *m, *tmp;
> +
> +	list_for_each_entry_safe(m, tmp, &sf->mmap_list, node) {
> +		list_del(&m->node);
> +		qda_legacy_ops_table.munmap(sf->session, m->vaddr, m->size);
> +		shim_mapping_free(m);
> +	}
> +
> +	list_for_each_entry_safe(m, tmp, &sf->mem_map_list, node) {
> +		list_del(&m->node);
> +		qda_legacy_ops_table.mem_unmap(sf->session, m->key, m->vaddr, m->size);
> +		shim_mapping_free(m);
> +	}
> +}

[Severity: High]
What happens in qda_shim_release() -> shim_mappings_release() if the file
is closed after the underlying rpmsg device has been removed?

When the rpmsg device is removed while a /dev/fastrpc-* file is still open,
qda_rpmsg_remove() calls drm_dev_unplug(), qda_cb_unpopulate() (destroying
each context-bank platform device), and qda_deinit_device() (destroying
qdev->iommu_mgr->assignment_lock and qdev->ctx_xa), and devres frees
qdev->iommu_mgr.

In drivers/accel/qda/qda_legacy_ops.c, legacy_release() checks
drm_dev_is_unplugged(&session->qda_dev->drm_dev) before calling
qda_release_dsp_process(). However, qda_shim_release() calls
shim_mappings_release() before legacy_release(), and neither
shim_mappings_release() nor legacy_munmap() and legacy_mem_unmap() checks
drm_dev_is_unplugged(). Won't closing a file with active mappings after
unplug call into qda_fastrpc_invoke() -> xa_alloc(&qdev->ctx_xa, ...) and
alloc_kernel_gem() -> qda_memory_manager_alloc(), dereferencing the
destroyed ctx_xa, devm-freed qdev->iommu_mgr, and destroyed context-bank
platform device?

[ ... ]

> @@ -191,6 +295,156 @@ static long qda_shim_init_create(struct qda_shim_fi=
le *sf, void __user *argp)
>  	return err;
>  }
> =20
> +static long qda_shim_mmap(struct qda_shim_file *sf, void __user *argp)
> +{
> +	struct qda_shim_mapping *m;
> +	struct fastrpc_req_mmap args;
> +	struct drm_gem_object *obj;
> +	int err;
> +
> +	if (copy_from_user(&args, argp, sizeof(args)))
> +		return -EFAULT;
> +
> +	obj =3D shim_import_fd(sf->session, args.fd);
> +	if (IS_ERR(obj))
> +		return PTR_ERR(obj);
> +	if (!obj)
> +		return -EINVAL;
> +
> +	err =3D qda_legacy_ops_table.mmap(sf->session, obj, args.vaddrin, args.=
size, args.flags,
> +					&args.vaddrout);
> +	if (err) {
> +		drm_gem_object_put(obj);
> +		return err;
> +	}
> +
> +	m =3D shim_mapping_add(sf, &sf->mmap_list, args.vaddrout, args.vaddrout=
, args.size, obj);

[Severity: High]
If user space passes args.size =3D=3D 0 to FASTRPC_IOCTL_MMAP (or
args.length =3D=3D 0 to FASTRPC_IOCTL_MEM_MAP in qda_shim_mem_map()), doesn=
't
this record m->size =3D 0 while the DSP actually mapped the full GEM object
size?

In setup_mmap_pages():

	pages->addr =3D qda_gem_obj->dma_addr;
	pages->size =3D margs->size ? margs->size : qda_gem_obj->size;

When args.size is 0, the DSP maps qda_gem_obj->size bytes, but
qda_shim_mmap() and qda_shim_mem_map() record 0 in m->size. When the
mapping is later unmapped via qda_shim_munmap(), qda_shim_mem_unmap(),
copy_to_user() failure rollback, or shim_mappings_release(), the DSP is
asked to unmap 0 bytes before shim_mapping_free() drops the reference on
obj, and FASTRPC_IOCTL_MUNMAP calls specifying the actual buffer size will
be rejected by m->size !=3D args.size. Should m->size record the effective
mapped size (or should a zero size/length be rejected)?

> +	if (IS_ERR(m)) {
> +		err =3D PTR_ERR(m);
> +		goto err_unmap;
> +	}
> +
> +	if (copy_to_user(argp, &args, sizeof(args))) {
> +		m =3D shim_mapping_detach(sf, &sf->mmap_list, args.vaddrout, args.vadd=
rout);
> +		if (m) {
> +			qda_legacy_ops_table.munmap(sf->session, m->vaddr, m->size);
> +			shim_mapping_free(m);
> +		}
> +		return -EFAULT;
> +	}
> +
> +	return 0;
> +
> +err_unmap:
> +	qda_legacy_ops_table.munmap(sf->session, args.vaddrout, args.size);
> +	drm_gem_object_put(obj);
> +
> +	return err;
> +}

[Severity: High]
Can ignoring the return value of munmap() and mem_unmap() in these rollback
paths (and in shim_mappings_release()) release m->obj while the DSP still
has the buffer mapped?

Here in qda_shim_mmap() (on copy_to_user() failure and at err_unmap), in
qda_shim_mem_map() (on copy_to_user() failure), and in
shim_mappings_release() on file close, qda_legacy_ops_table.munmap() or
mem_unmap() waits in qda_rpmsg_wait_for_rsp() via
wait_for_completion_interruptible(&ctx->work).

If a signal is pending or arrives while waiting (returning -ERESTARTSYS),
or if allocating the unmap invocation context fails, the DSP has not
unmapped the buffer, yet shim_mapping_free(m) or drm_gem_object_put(obj)
immediately drops the reference on the GEM object (which for an imported
DMA-BUF in the shim is the sole reference, tearing down its IOMMU mapping
or freeing its DMA memory in qda_gem_free_object()).

[ ... ]

> +static long qda_shim_mem_map(struct qda_shim_file *sf, void __user *argp)
> +{
> +	struct qda_shim_mapping *m;
> +	struct fastrpc_mem_map args;
> +	struct drm_gem_object *obj;
> +	int err;
> +
> +	if (copy_from_user(&args, argp, sizeof(args)))
> +		return -EFAULT;
> +
> +	if (args.offset < 0)
> +		return -EINVAL;
> +
> +	obj =3D shim_import_fd(sf->session, args.fd);
> +	if (IS_ERR(obj))
> +		return PTR_ERR(obj);
> +	if (!obj)
> +		return -EINVAL;
> +
> +	/* Reserved before the DSP is asked, so the same fd cannot be mapped tw=
ice */
> +	m =3D shim_mapping_add(sf, &sf->mem_map_list, args.fd, 0, args.length, =
obj);
> +	if (IS_ERR(m)) {
> +		drm_gem_object_put(obj);
> +		return PTR_ERR(m);
> +	}
> +
> +	err =3D qda_legacy_ops_table.mem_map(sf->session, obj, args.flags, args=
.attrs, args.offset,
> +					   args.vaddrin, args.length, args.fd, &args.vaddrout);
> +	if (err) {
> +		m =3D shim_mapping_detach(sf, &sf->mem_map_list, args.fd, 0);
> +		if (m)
> +			shim_mapping_free(m);
> +		return err;
> +	}
> +
> +	scoped_guard(mutex, &sf->maps_lock)
> +		m->vaddr =3D args.vaddrout;

[Severity: Critical]
Can a concurrent FASTRPC_IOCTL_MEM_UNMAP with args.vaddr =3D=3D 0 detach and
free the placeholder m while qda_legacy_ops_table.mem_map() is still
running?

In qda_shim_mem_map(), shim_mapping_add() inserts m into sf->mem_map_list
with m->key =3D args.fd and m->vaddr =3D 0, and transfers the caller's only
reference on obj into m->obj before dropping sf->maps_lock:

	m =3D shim_mapping_add(sf, &sf->mem_map_list, args.fd, 0, args.length, obj=
);
	...
	err =3D qda_legacy_ops_table.mem_map(sf->session, obj, ...);

While qda_legacy_ops_table.mem_map() is executing without sf->maps_lock, a
concurrent qda_shim_mem_unmap() on the same file with the same args.fd and
args.vaddr =3D=3D 0 will match the placeholder in shim_mapping_detach():

	list_for_each_entry(m, list, node) {
		if (m->key =3D=3D key && m->vaddr =3D=3D vaddr) {
			list_del(&m->node);
			return m;
		}
	}

If qda_legacy_ops_table.mem_unmap() then succeeds, qda_shim_mem_unmap()
calls shim_mapping_free(m), which puts m->obj (potentially before
setup_mmap_pages() has called drm_gem_object_get(args->obj)) and frees m.
When qda_legacy_ops_table.mem_map() finishes and returns 0,
qda_shim_mem_map() writes m->vaddr =3D args.vaddrout to the freed m and
leaves the DSP mapping active with m->obj already released.

Conversely, if qda_legacy_ops_table.mem_map() fails while the concurrent
qda_shim_mem_unmap() has detached m, qda_shim_mem_map()'s cleanup
shim_mapping_detach() returns NULL, and if mem_unmap() then fails and calls
shim_mapping_attach(), the failed placeholder with vaddr =3D=3D 0 is
re-attached to sf->mem_map_list, leaking m->obj until file close and
blocking future FASTRPC_IOCTL_MEM_MAP calls on that fd with -EEXIST.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-v4-v4-0-88=
f2f24a5f0b@qti.qualcomm.com?part=3D19
