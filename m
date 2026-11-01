Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100CC606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 22:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SmaA3QpG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A8AC10EAC9;
	Sun,  1 Nov 2026 22:44:32 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B371E10EAC9
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 22:44:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2015D601FF;
 Sun,  1 Nov 2026 22:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14911F00A02;
 Sun,  1 Nov 2026 22:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793573065;
 bh=Xeufzxot0TCCOkLXeTcQKGLKdI6d4dBgS9BbRpotJOw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SmaA3QpGVqfZ4tjYmzs105LU4o3Xx8ODJrvQAAjwhrwKX0TuNuZKL3s2Hx2dRW4Z4
 s2VcKDgyJfaJrvumFOwFBSWbYFZ/UkI49VoAi8k17YD9k9B4q93l+iF7rnEP5JdwdQ
 LwrVAtJltGcXdQr5MR603WpfJv8lrs57bQ7rwOsybB+fpNOEoOx7WkY4Uw53bv2Nn9
 IZOUwpPAMzhxKfT0KFBwJPvW2kV9AQfPL1WxoknxZQKtDM8OAY0IUMyJZAU/I+p6AL
 KW2QGoLTD5VT9C8Uy5wDIPpyd1nOfigmRTVOXZtK4MUKLpngWPhnMdHSWrho2nVMXX
 XoLBiKK8zc9vA==
Message-ID: <sashiko-outbox-192730@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/25] accel/qda: Add invocation argument validation
 and packing
To: "Ekansh Gupta" <ekansh.gupta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261102-v4-v4-12-88f2f24a5f0b@qti.qualcomm.com>
References: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
 <20261102-v4-v4-12-88f2f24a5f0b@qti.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 22:44:25 +0000
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
- [High] accel/qda: union corruption on zero handle in process_dma_handle()
- [High] accel/qda: missing bounds and overflow checks in process_dma_handl=
e()
- [High] accel/qda: dangling session->file pointer after qda_postclose()
- [High] accel/qda: premature drm_dev_put() while qda_session remains alive
- [Medium] accel/qda: unvalidated attr field in qda_fastrpc_prepare_args_in=
voke()
--

commit 0212e9880ce32dca1d81b275fcea22de7515a72a
Author: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

accel/qda: Add invocation argument validation and packing

This commit adds FastRPC invocation argument validation, message payload
packing, and per-session message buffer pooling for the QDA driver. It also
converts struct qda_session to be reference-counted so in-flight invocations
can outlive the open file and clean up DSP-released GEM handles.

> diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
> index bdfb23c3c0b1d..99bd37fca4384 100644
> --- a/drivers/accel/qda/qda_drv.c
> +++ b/drivers/accel/qda/qda_drv.c
[ ... ]
> @@ -50,22 +61,47 @@ static int qda_open(struct drm_device *dev, struct dr=
m_file *file)
[ ... ]
>  static void qda_postclose(struct drm_device *dev, struct drm_file *file)
>  {
> -	qda_session_free(file->driver_priv);
> +	qda_session_put(file->driver_priv);
>  }

[Severity: High]
When an invocation outlives the file it was issued on, does session->file
become a dangling pointer to a freed struct drm_file after qda_postclose()
runs?

In qda_open(), session->file is set to the raw struct drm_file pointer, and
qda_fastrpc_prepare_args() takes a reference on ctx->session so that the
session can outlive file closure if the caller stops waiting for the DSP.

However, when the DRM file is closed, drm_file_free() destroys
file->object_idr via drm_gem_release(), calls qda_postclose(), and then
frees struct drm_file with kfree(file):

drm_file_free()
  drm_gem_release(dev, file)
  dev->driver->postclose(dev, file) -> qda_postclose()
    qda_session_put(file->driver_priv)
  kfree(file)

Because qda_postclose() only drops the file owner's session reference witho=
ut
clearing session->file or synchronizing with in-flight invocations, any
session kept alive by an invocation retains a non-NULL session->file pointer
to freed memory. When the DSP response later triggers
qda_fastrpc_cleanup_handlelist():

void qda_fastrpc_cleanup_handlelist(struct qda_fastrpc_invoke_ctx *ctx)
{
	...
	for (i =3D 0; i < QDA_FASTRPC_MAX_HANDLELIST; i++) {
		if (!handlelist[i])
			break;
		if (ctx->session->file)
			drm_gem_handle_delete(ctx->session->file, (u32)handlelist[i]);
	}
}

checking ctx->session->file and passing it to drm_gem_handle_delete() will
dereference the freed struct drm_file and its destroyed handle table.

> diff --git a/drivers/accel/qda/qda_fastrpc.c b/drivers/accel/qda/qda_fast=
rpc.c
> index ec37a38e92158..2971f2f9461fc 100644
> --- a/drivers/accel/qda/qda_fastrpc.c
> +++ b/drivers/accel/qda/qda_fastrpc.c
[ ... ]
> @@ -70,3 +283,272 @@ struct qda_fastrpc_invoke_ctx *qda_fastrpc_context_a=
lloc(struct qda_dev *qdev)
[ ... ]
> +static int process_dma_handle(struct qda_fastrpc_invoke_ctx *ctx, int i,
> +			      union qda_remote_arg *rpra,
> +			      struct qda_phy_page *pages)
> +{
> +	struct drm_gem_object *gem_obj;
> +	int err;
> +
> +	if (!ctx->args[i].handle) {
> +		rpra[i].buf.addr =3D ctx->args[i].offset;
> +		rpra[i].buf.len =3D ctx->args[i].length;
> +		return 0;
> +	}

[Severity: High]
What prevents user space from bypassing handle validation in
process_dma_handle() by passing handle =3D=3D 0 with a non-zero offset for a
DMA-handle argument?

In qda_fastrpc_get_args(), arguments at indices ctx->nbufs <=3D i <
ctx->nscalars are DMA-handle arguments, which the DSP interprets as struct
qda_remote_dmahandle (rpra[i].dma). Because union qda_remote_arg overlays
struct qda_remote_buf with struct qda_remote_dmahandle:

union qda_remote_arg {
	struct qda_remote_buf buf;
	struct qda_remote_dmahandle dma;
};

writing the 64-bit ctx->args[i].offset into rpra[i].buf.addr when
ctx->args[i].handle is 0 populates rpra[i].dma.handle with the low 32 bits =
of
ctx->args[i].offset and rpra[i].dma.offset with the high 32 bits, while
rpra[i].buf.len overwrites rpra[i].dma.len.

In addition, qda_fastrpc_get_args() sets list[i].num =3D ctx->args[i].lengt=
h ?
1 : 0 before calling process_dma_handle(), so a zero handle with a non-zero
length leaves list[i].num set to 1 while pages[i] remains unpopulated.
Checking !ctx->args[i].handle before ctx->gem_objs[i] also skips any
pre-populated ctx->gem_objs[i] entry when handle is 0.

> +
> +	if (ctx->gem_objs[i]) {
> +		gem_obj =3D ctx->gem_objs[i];
> +	} else {
> +		err =3D get_gem_obj_from_handle(ctx, ctx->args[i].handle, &gem_obj);
> +		if (err)
> +			return err;
> +
> +		ctx->gem_objs[i] =3D gem_obj;
> +	}
> +
> +	setup_pages_from_gem_obj(to_qda_gem_obj(gem_obj), &pages[i]);
> +
> +	/* The DSP-facing offset and length fields are 32-bit by wire format */
> +	rpra[i].dma.handle =3D ctx->args[i].handle;
> +	rpra[i].dma.len =3D (u32)ctx->args[i].length;
> +	rpra[i].dma.offset =3D (u32)ctx->args[i].offset;
> +
> +	return 0;
> +}

[Severity: High]
Should process_dma_handle() validate ctx->args[i].offset and
ctx->args[i].length against the GEM object's size and U32_MAX before casting
them to u32?

In process_msg_buffer(), the user-supplied offset and length are checked
against qda_gem_obj->size so that a descriptor cannot reference memory past
the end of its buffer in the session's context bank:

	if (ctx->args[i].offset > qda_gem_obj->size ||
	    len > qda_gem_obj->size - ctx->args[i].offset) {
		...
		return -EINVAL;
	}

In process_dma_handle(), however, ctx->args[i].length and
ctx->args[i].offset are cast directly to u32 and written into rpra[i].dma.l=
en
and rpra[i].dma.offset without checking that the region lies within
to_qda_gem_obj(gem_obj)->size or fits within 32 bits. Can user space use a
DMA-handle argument to pass a truncated or out-of-bounds region to the DSP?

[ ... ]
> +static int qda_fastrpc_prepare_args_invoke(struct qda_fastrpc_invoke_ctx=
 *ctx, void *argp)
> +{
> +	struct drm_qda_invoke_args *invoke_args =3D argp;
> +	struct drm_qda_fastrpc_invoke_args *args;
> +	u32 nscalars;
> +
> +	ctx->handle =3D invoke_args->handle;
> +	ctx->sc =3D invoke_args->sc;
> +
> +	nscalars =3D QDA_REMOTE_SCALARS_LENGTH(ctx->sc);
> +	if (!nscalars)
> +		return 0;
> +
> +	args =3D kzalloc_objs(*args, nscalars);
> +	if (!args)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(args, u64_to_user_ptr(invoke_args->args),
> +			   nscalars * sizeof(*args))) {
> +		kfree(args);
> +		return -EFAULT;
> +	}
> +
> +	ctx->args =3D args;
> +
> +	return 0;
> +}

[Severity: Medium]
Should qda_fastrpc_prepare_args_invoke() reject non-zero values in
args[i].attr with -EINVAL?

struct drm_qda_fastrpc_invoke_args defines __u32 attr in the UAPI header,
with no valid attribute flags currently defined, and nothing in
qda_fastrpc_prepare_args_invoke() or qda_fastrpc_get_args() checks that
args[i].attr is zero. If user space passes uninitialized non-zero values in
attr today, won't that prevent future kernel versions from introducing flag
bits in attr without breaking existing user space?

> diff --git a/drivers/accel/qda/qda_legacy_ops.c b/drivers/accel/qda/qda_l=
egacy_ops.c
> index 3566a10c64880..9639ea84b2007 100644
> --- a/drivers/accel/qda/qda_legacy_ops.c
> +++ b/drivers/accel/qda/qda_legacy_ops.c
> @@ -33,7 +33,7 @@ static void legacy_session_destroy(struct qda_session *=
session)
>  {
>  	struct drm_device *drm_dev =3D &session->qda_dev->drm_dev;
> =20
> -	qda_session_free(session);
> +	qda_session_put(session);
>  	drm_dev_put(drm_dev);
>  }

[Severity: High]
Can dropping the drm_device reference before the last reference to struct
qda_session is released cause a use-after-free of struct qda_dev?

With this change, struct qda_session is reference-counted and can outlive
file closure (both via legacy_session_destroy() and via drm_release() ->
qda_postclose()) when an in-flight invocation or its deferred ctx->put_work
still holds a reference on ctx->session.

However, legacy_session_destroy() still calls drm_dev_put(drm_dev)
immediately after qda_session_put(session), and struct qda_session does not
hold its own drm_dev_get() reference until qda_session_release(). If the
file is closed while an invocation is still in flight and the underlying
rpmsg device is unbound before ctx->put_work completes, the final
drm_device reference can be dropped and struct qda_dev freed before
qda_fastrpc_context_free() and qda_session_release() run:

qda_fastrpc_context_free()
  xa_erase(&ctx->qdev->ctx_xa, ...)
  qda_session_msg_buf_put(ctx->session, &ctx->msg_gem_obj->base)
  qda_session_put(ctx->session) -> qda_session_release()
    qda_session_msg_buf_pool_destroy(session)
      drm_gem_object_put(entry->gem_obj)

At that point, accessing ctx->qdev->ctx_xa and freeing the session's GEM
objects will dereference the already-freed struct qda_dev. Should the
drm_device reference be held across the lifetime of struct qda_session and
released in qda_session_release() instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-v4-v4-0-88=
f2f24a5f0b@qti.qualcomm.com?part=3D12
