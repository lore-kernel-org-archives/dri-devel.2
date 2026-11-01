Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B399606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 22:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bX69hHWj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 077D010E4E7;
	Sun,  1 Nov 2026 22:54:17 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EAC210EAD4
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 22:54:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4D91A601FF;
 Sun,  1 Nov 2026 22:54:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3001F000C1;
 Sun,  1 Nov 2026 22:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793573649;
 bh=m9dOw3rV3uSDxWPDTcg1j4+4t0MdpzIzXpwYcg292dU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bX69hHWj5E6QwEFUIaww6GdWIj/YjiGfljepgJGWHi39BpO+mZBLP2mHOM0me7LYV
 J7Qx0Xi3pXnKxNJ5hOM5Ejc6ztIbluhUKw3TxQOpc7vrZPnnPLijrxgTlEyGYYDH65
 btnJJ7iVJYqWJh35/B2HIpALc6FKN5Ezb4nLaccRQuQ7O757dcr/SMKSDqpqtvLHtm
 7n8QmYoWnhaj0/xZucSWPkcqcCl9Ymxplsx/e+dlOUirHSUKmlsl0XfVpXbJluh8uH
 j1sWgEXyWIeO6WVlBwEuPMCSp0t2ilcVt5vN9GVEqMqbc+Ef7tQJQvkck6HJdwGw8x
 UsPqHwP571ugQ==
Message-ID: <sashiko-outbox-192743@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 17/25] accel/qda: Add remote memory mapping to the
 DSP address space
To: "Ekansh Gupta" <ekansh.gupta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261102-v4-v4-17-88f2f24a5f0b@qti.qualcomm.com>
References: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
 <20261102-v4-v4-17-88f2f24a5f0b@qti.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 22:54:08 +0000
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
- [Critical] accel/qda: premature GEM object put in qda_fastrpc_context_fre=
e() on mmap
- [High] accel/qda: missing offset bounds check in setup_mmap_pages() for m=
em_map
- [High] accel/qda: uninitialized session PD and leaked mappings in qda_ioc=
tl_mmap()
- [Medium] accel/qda: drm_qda_mem_map.attrs is ignored and unused fields ar=
e unvalidated
- [Medium] accel/qda: DSP mapping leak on signal interruption in qda_fastrp=
c_invoke()
--

commit 395c018ba64267dfbd2bc4c753e6cc750574fd40
Author: Ekansh Gupta <ekangupt@qti.qualcomm.com>

accel/qda: Add remote memory mapping to the DSP address space

This commit adds the DRM_IOCTL_QDA_REMOTE_MMAP ioctl to map a buffer handle
into the remote processor's address space via QDA_FASTRPC_RMID_INIT_MMAP or
QDA_FASTRPC_RMID_INIT_MEM_MAP and return the mapped address to user space.

> diff --git a/drivers/accel/qda/qda_fastrpc.c b/drivers/accel/qda/qda_fast=
rpc.c
> index 35ce60f3de2ec..744d7317cbe11 100644
> --- a/drivers/accel/qda/qda_fastrpc.c
> +++ b/drivers/accel/qda/qda_fastrpc.c
> @@ -3,6 +3,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/capability.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/limits.h>
>  #include <linux/mm.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
> @@ -251,6 +252,9 @@ void qda_fastrpc_context_free(struct kref *ref)
>  	if (ctx->init_mem_gem_obj)
>  		drm_gem_object_put(&ctx->init_mem_gem_obj->base);
> =20
> +	if (ctx->map_obj)
> +		drm_gem_object_put(ctx->map_obj);

[Severity: Critical]
Could dropping ctx->map_obj here when the invocation context is freed cause=
 a
use-after-free while the mapping remains active on the remote processor?

In setup_mmap_pages(), get_gem_obj_from_handle() stores the buffer reference
in ctx->map_obj and passes qda_gem_obj->dma_addr to the remote processor for
QDA_FASTRPC_RMID_INIT_MMAP or QDA_FASTRPC_RMID_INIT_MEM_MAP.

However, as soon as the mapping call finishes in qda_fastrpc_invoke():

    qda_ioctl_mmap()
      -> qda_fastrpc_invoke()
           -> kref_put(&ctx->refcount, qda_fastrpc_context_free)
                -> drm_gem_object_put(ctx->map_obj)

the kernel drops its reference to ctx->map_obj before qda_ioctl_mmap()
returns to user space, unlike ctx->init_mem_gem_obj which is transferred to
the session via qda_session_set_init_mem().

If user space then closes the buffer handle with DRM_IOCTL_GEM_CLOSE while
the remote mapping at vaddrout is still in place, qda_gem_free_object() will
free the backing memory and release its address in session->assigned_iommu_=
dev.
Because driver-allocated buffers (such as alloc_kernel_gem() buffers and
ctx->msg_gem_obj) allocate from the same session->assigned_iommu_dev context
bank, couldn't later ioctls reuse that address and allow remote code to
access or corrupt in-flight control messages? Also, should margs->flags be
validated in qda_fastrpc_prepare_args_map() before forwarding it to
QDA_FASTRPC_RMID_INIT_MMAP?

[ ... ]

> @@ -890,6 +930,148 @@ static int qda_fastrpc_prepare_args_init_create(str=
uct qda_fastrpc_invoke_ctx *c
>  	return err;
>  }
> =20
> +/*
> + * Find the buffer a mapping request names and describe it to the DSP. T=
he
> + * buffer is held by the context until the request is done, so that clos=
ing its
> + * handle meanwhile cannot free memory the DSP is being told to map. The
> + * region must fit in the buffer, as the DSP would otherwise map past it=
s end.
> + */
> +static int setup_mmap_pages(struct qda_fastrpc_invoke_ctx *ctx, struct d=
rm_qda_mem_map *margs,
> +			    struct qda_phy_page *pages)
> +{
> +	struct qda_gem_obj *qda_gem_obj;
> +	int err;
> +
> +	if (!margs->handle)
> +		return -EINVAL;
> +
> +	err =3D get_gem_obj_from_handle(ctx, margs->handle, &ctx->map_obj);
> +	if (err)
> +		return err;
> +
> +	qda_gem_obj =3D to_qda_gem_obj(ctx->map_obj);
> +	if (margs->size > qda_gem_obj->size)
> +		return -EINVAL;
> +
> +	pages->addr =3D qda_gem_obj->dma_addr;
> +	pages->size =3D margs->size ? margs->size : qda_gem_obj->size;

[Severity: High]
Does setup_mmap_pages() need to check margs->offset against qda_gem_obj->si=
ze
as well?

In qda_fastrpc_prepare_args_mem_map(), margs->offset is only checked against
INT_MAX before being written to req->offset:

	if (margs->offset > INT_MAX)
		return -EINVAL;
	...
	req->offset =3D margs->offset;

And setup_mmap_pages() only verifies that margs->size <=3D qda_gem_obj->siz=
e,
unlike process_msg_buffer() which checks both the offset and the remaining
length:

	if (ctx->args[i].offset > qda_gem_obj->size ||
	    len > qda_gem_obj->size - ctx->args[i].offset) {

When DRM_IOCTL_QDA_REMOTE_MMAP is called with QDA_REQUEST_MEM_MAP and a
non-zero margs->offset (for example with margs->size =3D=3D 0, which sets
pages->size to qda_gem_obj->size, or with margs->offset + pages->size
exceeding qda_gem_obj->size), won't this allow mapping past the end of
qda_gem_obj?

> +
> +	return 0;
> +}

[ ... ]

> +static int qda_fastrpc_prepare_args_mem_map(struct qda_fastrpc_invoke_ct=
x *ctx, void *argp)
> +{
> +	struct drm_qda_mem_map *margs =3D argp;
> +	struct qda_fastrpc_mem_map_req_msg *req;
> +	struct qda_gem_obj *kernel_gem;
> +	u8 *gv;
> +	int err;
> +
> +	const size_t off_req =3D 0;
> +	const size_t off_pages =3D off_req + sizeof(*req);
> +	const size_t off_rsp =3D off_pages + sizeof(struct qda_phy_page);
> +	const size_t total_size =3D off_rsp + sizeof(struct qda_fastrpc_map_rsp=
_msg);
> +
> +	/* The wire field is signed */
> +	if (margs->offset > INT_MAX)
> +		return -EINVAL;
> +
> +	ctx->sc =3D QDA_FASTRPC_SCALARS(QDA_FASTRPC_RMID_INIT_MEM_MAP, 3, 1);
> +	ctx->handle =3D QDA_FASTRPC_INIT_HANDLE;
> +
> +	err =3D alloc_kernel_args(ctx, 4);
> +	if (err)
> +		return err;
> +
> +	kernel_gem =3D alloc_kernel_gem(ctx, total_size);
> +	if (IS_ERR(kernel_gem))
> +		return PTR_ERR(kernel_gem);
> +	gv =3D kernel_gem->virt;
> +
> +	req =3D (struct qda_fastrpc_mem_map_req_msg *)(gv + off_req);
> +	req->remote_session_id =3D ctx->session->remote_session_id;
> +	req->handle =3D margs->dsp_handle;
> +	req->offset =3D margs->offset;
> +	req->flags =3D margs->flags;
> +	req->vaddrin =3D margs->vaddrin;
> +	req->num =3D sizeof(struct qda_phy_page);
> +	req->data_len =3D 0;

[Severity: Medium]
Should margs->attrs be handled or rejected here, and should unused fields in
struct drm_qda_mem_map be checked for zero in qda_fastrpc_prepare_args_map(=
)?

The comment on struct drm_qda_mem_map in include/uapi/drm/qda_accel.h state=
s:

 * Makes a buffer visible to the DSP of this file ahead of the calls that u=
se
 * it. QDA_REQUEST_MMAP maps a whole buffer and uses @handle, @flags,
 * @vaddrin, @size and @vaddrout. QDA_REQUEST_MEM_MAP maps a region of it w=
ith
 * caller-chosen attributes and uses every field.

However, qda_fastrpc_prepare_args_mem_map() never reads or validates
margs->attrs, and qda_fastrpc_prepare_args_map() does not reject non-zero
values in margs->attrs, margs->offset, or margs->dsp_handle when request is
QDA_REQUEST_MMAP.

[ ... ]

> @@ -953,6 +1135,12 @@ int qda_fastrpc_prepare_args(struct qda_fastrpc_inv=
oke_ctx *ctx,
>  		ctx->pd =3D QDA_USER_PD;
>  		err =3D qda_fastrpc_prepare_args_init_create(ctx, argp);
>  		break;
> +	case QDA_FASTRPC_RMID_INIT_MMAP:
> +		err =3D qda_fastrpc_prepare_args_map(ctx, argp);
> +		break;
> +	case QDA_FASTRPC_RMID_INIT_MEM_MAP:
> +		err =3D qda_fastrpc_prepare_args_mem_map(ctx, argp);
> +		break;

[Severity: High]
What happens if user space calls DRM_IOCTL_QDA_REMOTE_MMAP before creating a
session process, or closes the file while mappings are still active?

When a file is opened in qda_open(), qda_session_alloc() zero-initializes
struct qda_session, leaving session->pd as 0 (QDA_ROOT_PD) and
session->init_mem_gem_obj as NULL until DRM_IOCTL_QDA_REMOTE_SESSION_CREATE
completes. In qda_fastrpc_prepare_args(), ctx->pd is initialized from
READ_ONCE(session->pd), so calling qda_ioctl_mmap() on a freshly opened file
will send QDA_FASTRPC_RMID_INIT_MMAP or QDA_FASTRPC_RMID_INIT_MEM_MAP to
QDA_ROOT_PD without an initialized session or a capability check.

In addition, when the DRM file is closed, qda_postclose() only calls
qda_release_dsp_process() when session->init_mem_gem_obj is non-NULL:

	if (READ_ONCE(session->init_mem_gem_obj) && drm_dev_enter(dev, &idx)) {
		qda_release_dsp_process(session->qda_dev, session);
		drm_dev_exit(idx);
	}

and nothing tracks or unmaps active DRM_IOCTL_QDA_REMOTE_MMAP mappings befo=
re
drm_gem_release() frees the GEM objects and qda_session_release() releases
session->assigned_iommu_dev. Doesn't this leak the remote mappings on close?

> diff --git a/drivers/accel/qda/qda_ioctl.c b/drivers/accel/qda/qda_ioctl.c
> index 99b8a2517726b..cd3cea72f50e8 100644
> --- a/drivers/accel/qda/qda_ioctl.c
> +++ b/drivers/accel/qda/qda_ioctl.c
> @@ -110,6 +110,8 @@ static int qda_fastrpc_invoke(u32 type, void *data, s=
truct qda_session *session)
>  	if (err)
>  		goto out_put;
> =20
> +	qda_fastrpc_return_result(ctx, data);

[Severity: Medium]
Can a signal interrupting qda_fastrpc_invoke_common() leak the remote mappi=
ng
in the DSP address space?

After qda_rpmsg_send_msg() sends a QDA_FASTRPC_RMID_INIT_MMAP or
QDA_FASTRPC_RMID_INIT_MEM_MAP request, qda_rpmsg_wait_for_rsp() waits in
wait_for_completion_interruptible(&ctx->work).

If a signal arrives before the reply, qda_fastrpc_invoke_common() returns
-ERESTARTSYS and qda_fastrpc_invoke() jumps to out_put, skipping
qda_fastrpc_return_result(). When the DSP later finishes the mapping and
writes rsp->vaddrout into ctx->gem_objs[idx], qda_rpmsg_cb() drops the last
reference on ctx and frees the buffer without returning vaddrout to user
space or unmapping the region on the DSP.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-v4-v4-0-88=
f2f24a5f0b@qti.qualcomm.com?part=3D17
