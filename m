Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A13606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 22:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LwsIu7In
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78F7B10EAD1;
	Sun,  1 Nov 2026 22:50:12 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A7F110EAD1
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 22:50:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B10C5601FF;
 Sun,  1 Nov 2026 22:50:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D5A51F000C1;
 Sun,  1 Nov 2026 22:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793573405;
 bh=EO+ff5Y6VkLUVdQuv8v58Df2RDEi/hObez3wLhwlfWI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LwsIu7InlbDkh4P/f3mYHc58yw1m5//4N6XYGRdbU1FaopoSsIGu7uCF/yq0PZYKq
 WhLzNJtO0mUkDfZGD7VaW3CmZdeDd5nv91/o0MpiMSMyVMQUv3HS1ScfKztxe6I8ez
 dIF9UXlgAb4ctPIRWVis7drULt3tupRHkjBoTSKwn0g6i3Fl7rtSNPjHjE2eCBqqIF
 1qstkytnUAetpBLwmd5hr6Ut/BRA0RYgzR7pxCtjG3isNX+PYPWkgsR1+j/f1/v5Oc
 fUv9JEiEBruwx8j1YWSQN/D9FZp5E0drbyqUEesbjw21OORrbzatOr3weSMl0jFYS/
 lMTsmZNu7OXew==
Message-ID: <sashiko-outbox-192737@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 15/25] accel/qda: Add DSP process creation and release
To: "Ekansh Gupta" <ekansh.gupta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261102-v4-v4-15-88f2f24a5f0b@qti.qualcomm.com>
References: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
 <20261102-v4-v4-15-88f2f24a5f0b@qti.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 22:50:04 +0000
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
- [Critical] accel/qda: DMA UAF of init_mem_gem_obj on signal in qda_fastrp=
c_invoke()
- [Critical] accel/qda: race in qda_session_set_init_mem() frees active pro=
cess memory
- [Critical] accel/qda: unprivileged userspace can invoke QDA_FASTRPC_INIT_=
HANDLE
- [High] accel/qda: deadlock in qda_postclose() holding drm_dev_enter() acr=
oss RPC
- [High] accel/qda: default session->pd of QDA_ROOT_PD allows unattached ro=
ot PD invoke
--

commit 981b12f498982e2e454ee8c3d214b24f64472c31
Author: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

accel/qda: Add DSP process creation and release

This commit adds FastRPC requests and the DRM_IOCTL_QDA_REMOTE_SESSION_CREA=
TE
ioctl to create a DSP process on a session and release it when the session
closes. It allocates per-session memory for the DSP process image and tracks
the session's protection domain for subsequent requests.

> diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
> index 7d44342d3f67b..983c6a3dcfb45 100644
> --- a/drivers/accel/qda/qda_drv.c
> +++ b/drivers/accel/qda/qda_drv.c
[ ... ]
> @@ -101,7 +105,16 @@ EXPORT_SYMBOL_FOR_MODULES(qda_session_put, "qda_fast=
rpc_shim");
> =20
>  static void qda_postclose(struct drm_device *dev, struct drm_file *file)
>  {
> -	qda_session_put(file->driver_priv);
> +	struct qda_session *session =3D file->driver_priv;
> +	int idx;
> +
> +	/* Only a session that created a process has one to release */
> +	if (READ_ONCE(session->init_mem_gem_obj) && drm_dev_enter(dev, &idx)) {
> +		qda_release_dsp_process(session->qda_dev, session);
> +		drm_dev_exit(idx);
> +	}

[Severity: High]
Can holding drm_dev_enter() across qda_release_dsp_process() in
qda_postclose() deadlock with qda_rpmsg_remove() if the DSP crashes or the
RPMsg transport disconnects while the release request is in flight?

qda_release_dsp_process() calls qda_fastrpc_invoke() ->
qda_fastrpc_invoke_common(), which sends the QDA_FASTRPC_RMID_INIT_RELEASE
message (inside qda_rpmsg_send_msg(), which already uses its own short
drm_dev_enter()/drm_dev_exit() section around rpmsg_send()) and then blocks=
 in
qda_rpmsg_wait_for_rsp() via wait_for_completion_interruptible(&ctx->work).

If the RPMsg device is removed before the DSP replies, qda_rpmsg_remove() r=
uns:

drivers/accel/qda/qda_rpmsg.c:qda_rpmsg_remove() {
	drm_dev_unplug(&qdev->drm_dev);
	qdev->rpdev =3D NULL;
	qda_fastrpc_flush_pending(qdev);
	...
}

drm_dev_unplug() calls synchronize_srcu(&drm_unplug_srcu) and waits for
qda_postclose() to call drm_dev_exit(idx), while qda_postclose() is blocked=
 in
qda_rpmsg_wait_for_rsp() waiting for qda_fastrpc_flush_pending() to complete
ctx->work (and when qda_postclose() runs during process exit after
exit_signals() or from the delayed_fput workqueue, signals cannot interrupt=
 the
wait).

Should qda_postclose() check !drm_dev_is_unplugged(dev) instead of holding
drm_dev_enter() across the blocking RPC wait?

[ ... ]
> diff --git a/drivers/accel/qda/qda_fastrpc.c b/drivers/accel/qda/qda_fast=
rpc.c
> index 693dd6f035d2a..4672405ea4b79 100644
> --- a/drivers/accel/qda/qda_fastrpc.c
> +++ b/drivers/accel/qda/qda_fastrpc.c
[ ... ]
> @@ -511,9 +572,14 @@ int qda_fastrpc_invoke_pack(struct qda_fastrpc_invok=
e_ctx *ctx, struct qda_msg *
>  	/* Ensure the payload is visible to the DSP before the doorbell */
>  	dma_wmb();
> =20
> -	msg->fastrpc.remote_session_id =3D ctx->session->remote_session_id;
> +	/* The session has no process yet to identify while one is being create=
d */
> +	if (ctx->handle =3D=3D QDA_FASTRPC_INIT_HANDLE)
> +		msg->fastrpc.remote_session_id =3D 0;
> +	else
> +		msg->fastrpc.remote_session_id =3D ctx->session->remote_session_id;
> +
>  	msg->fastrpc.tid =3D current->pid;
> -	msg->fastrpc.ctx =3D ctx->ctxid | QDA_USER_PD;
> +	msg->fastrpc.ctx =3D ctx->ctxid | ctx->pd;
>  	msg->fastrpc.handle =3D ctx->handle;
>  	msg->fastrpc.sc =3D ctx->sc;
>  	msg->fastrpc.addr =3D msg->phys;

[Severity: Critical]
What prevents unprivileged user space from invoking QDA_FASTRPC_INIT_HANDLE
directly via DRM_IOCTL_QDA_REMOTE_INVOKE or the legacy invoke path?

In qda_fastrpc_invoke_pack(), any invocation with ctx->handle =3D=3D
QDA_FASTRPC_INIT_HANDLE is formatted with msg->fastrpc.remote_session_id =
=3D 0.
However, neither qda_fastrpc_prepare_args_invoke() nor
qda_fastrpc_invoke_legacy() rejects user-supplied requests where handle =3D=
=3D
QDA_FASTRPC_INIT_HANDLE:

drivers/accel/qda/qda_fastrpc.c:qda_fastrpc_prepare_args_invoke() {
	ctx->handle =3D invoke_args->handle;
	ctx->sc =3D invoke_args->sc;
	...
}

drivers/accel/qda/qda_fastrpc.c:qda_fastrpc_invoke_legacy() {
	...
	ctx->type =3D QDA_FASTRPC_RMID_INVOKE_DYNAMIC;
	ctx->legacy =3D true;
	ctx->pd =3D READ_ONCE(session->pd);
	ctx->handle =3D handle;
	ctx->sc =3D sc;
	...
}

Doesn't this allow an unprivileged caller to forge kernel initialisation
requests to QDA_FASTRPC_INIT_HANDLE with remote_session_id =3D 0=E2=80=94fo=
r example,
invoking QDA_FASTRPC_RMID_INIT_CREATE / QDA_FASTRPC_RMID_INIT_CREATE_ATTR f=
or a
signed process without CAP_SYS_ADMIN, supplying arbitrary physical page
descriptors in argument 3, or sending QDA_FASTRPC_RMID_INIT_RELEASE with
another session's remote_session_id?

[ ... ]
> @@ -740,8 +913,23 @@ int qda_fastrpc_prepare_args(struct qda_fastrpc_invo=
ke_ctx *ctx,
>  	 */
>  	qda_session_get(session);
>  	ctx->session =3D session;
> -
> -	err =3D qda_fastrpc_prepare_args_invoke(ctx, argp);
> +	ctx->pd =3D READ_ONCE(session->pd);
> +
> +	switch (ctx->type) {
> +	case QDA_FASTRPC_RMID_INIT_RELEASE:
> +		err =3D qda_fastrpc_prepare_args_release_process(ctx);
> +		break;
> +	case QDA_FASTRPC_RMID_INIT_CREATE:
> +		/* The new process is in the user PD, and so is the request creating i=
t */
> +		ctx->pd =3D QDA_USER_PD;
> +		err =3D qda_fastrpc_prepare_args_init_create(ctx, argp);
> +		break;
> +	case QDA_FASTRPC_RMID_INVOKE_DYNAMIC:
> +		err =3D qda_fastrpc_prepare_args_invoke(ctx, argp);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

[Severity: High]
Because qda_session_alloc() zero-initializes struct qda_session, session->pd
starts as 0 (QDA_ROOT_PD).

If user space calls DRM_IOCTL_QDA_REMOTE_INVOKE (via qda_ioctl_invoke() ->
qda_fastrpc_prepare_args()) or FASTRPC_IOCTL_INVOKE (via
qda_fastrpc_invoke_legacy()) before creating a DSP process on the session,
ctx->pd is set to READ_ONCE(session->pd) =3D=3D QDA_ROOT_PD, and
qda_fastrpc_invoke_pack() packs QDA_ROOT_PD into msg->fastrpc.ctx.

Can an unprivileged caller use this to direct invocations at QDA_ROOT_PD be=
fore
any protection domain has been created or attached?

[ ... ]
> diff --git a/drivers/accel/qda/qda_ioctl.c b/drivers/accel/qda/qda_ioctl.c
> index e9f4151e344af..f51ad0bc9e9cc 100644
> --- a/drivers/accel/qda/qda_ioctl.c
> +++ b/drivers/accel/qda/qda_ioctl.c
> @@ -75,7 +75,22 @@ int qda_ioctl_gem_mmap_offset(struct drm_device *dev, =
void *data, struct drm_fil
>  	return drm_gem_dumb_map_offset(file_priv, dev, args->handle, &args->off=
set);
>  }
> =20
> -static int qda_fastrpc_invoke(void *data, struct qda_session *session)
> +/*
> + * A process created again replaces the first, so the memory held for the
> + * previous one is dropped. Swapped atomically, as ioctls on one file ca=
n run
> + * concurrently.
> + */
> +static void qda_session_set_init_mem(struct qda_session *session, struct=
 qda_gem_obj *mem)
> +{
> +	struct qda_gem_obj *old;
> +
> +	drm_gem_object_get(&mem->base);
> +	old =3D xchg(&session->init_mem_gem_obj, mem);
> +	if (old)
> +		drm_gem_object_put(&old->base);
> +}

[Severity: Critical]
As reported by Sashiko on v1 [1], is an atomic xchg() in
qda_session_set_init_mem() sufficient when two threads call
DRM_IOCTL_QDA_REMOTE_SESSION_CREATE concurrently on the same file?

In qda_fastrpc_invoke(), qda_fastrpc_invoke_common() and
qda_session_set_init_mem() run without a per-session lock serializing proce=
ss
creation. If Thread A (with memA) and Thread B (with memB) issue
QDA_FASTRPC_RMID_INIT_CREATE concurrently:

1. The DSP processes Thread A first and Thread B second, so the active DSP
   process is replaced and runs in memB.
2. On the CPU, Thread B runs qda_session_set_init_mem(session, memB) before
   Thread A runs qda_session_set_init_mem(session, memA).
3. Thread A swaps session->init_mem_gem_obj to memA and calls
   drm_gem_object_put(&memB->base).
4. When Thread B drops ctx->refcount at out_put, qda_fastrpc_context_free()
   drops the last reference to memB, unmapping and freeing memB while the D=
SP
   process is actively running in it.

Should process creation on a session be serialized with a mutex (or rejecte=
d if
a process already exists)?

> +
> +static int qda_fastrpc_invoke(u32 type, void *data, struct qda_session *=
session)
>  {
>  	struct qda_dev *qdev =3D session->qda_dev;
>  	struct qda_fastrpc_invoke_ctx *ctx;
> @@ -85,11 +100,26 @@ static int qda_fastrpc_invoke(void *data, struct qda=
_session *session)
>  	if (IS_ERR(ctx))
>  		return PTR_ERR(ctx);
> =20
> +	ctx->type =3D type;
> +
>  	err =3D qda_fastrpc_prepare_args(ctx, session, data);
>  	if (err)
>  		goto out_put;
> =20
>  	err =3D qda_fastrpc_invoke_common(qdev, ctx);
> +	if (err)
> +		goto out_put;
> +
> +	/*
> +	 * The session only changes once the DSP has accepted the request, so a
> +	 * failed create leaves the previous process, if any, as it was. The
> +	 * memory is freed with the session, which the invocation keeps alive
> +	 * until it is done, so a release needs no reference of its own.
> +	 */
> +	if (type =3D=3D QDA_FASTRPC_RMID_INIT_CREATE) {
> +		qda_session_set_init_mem(session, ctx->init_mem_gem_obj);
> +		WRITE_ONCE(session->pd, QDA_USER_PD);
> +	}
> =20
>  out_put:
>  	kref_put(&ctx->refcount, qda_fastrpc_context_free);

[Severity: Critical]
What happens if a thread calling DRM_IOCTL_QDA_REMOTE_SESSION_CREATE is
interrupted by a signal while qda_fastrpc_invoke_common() is waiting in
qda_rpmsg_wait_for_rsp()?

After qda_rpmsg_send_msg() has sent the QDA_FASTRPC_RMID_INIT_CREATE reques=
t to
the DSP, a signal causes wait_for_completion_interruptible(&ctx->work) to
return -ERESTARTSYS. Here in qda_fastrpc_invoke(), the error check jumps to
out_put without calling qda_session_set_init_mem(session,
ctx->init_mem_gem_obj).

The DSP still processes the in-flight create request, loads the ELF image i=
nto
ctx->init_mem_gem_obj, starts the process, and replies. When qda_rpmsg_cb()
receives the reply and runs qda_fastrpc_context_put_wq() ->
qda_fastrpc_context_free():

drivers/accel/qda/qda_fastrpc.c:qda_fastrpc_context_free() {
	...
	if (ctx->init_mem_gem_obj)
		drm_gem_object_put(&ctx->init_mem_gem_obj->base);
	...
}

Because qda_session_set_init_mem() never took a reference for the session,
qda_fastrpc_context_free() drops the only reference to ctx->init_mem_gem_obj
and frees the DMA buffer while the DSP process is running in it. In additio=
n,
session->init_mem_gem_obj remains NULL, so qda_postclose() later skips
qda_release_dsp_process() and qda_session_release() releases
session->assigned_iommu_dev while the orphaned DSP process is still using t=
hat
context bank.

Could ctx->init_mem_gem_obj be retained by the session whenever an INIT_CRE=
ATE
request has been sent to the DSP (or transferred when the DSP replies with
status 0)?

[1] https://lore.kernel.org/r/20260519-qda-series-v1-13-b2d984c297f8@oss.qu=
alcomm.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-v4-v4-0-88=
f2f24a5f0b@qti.qualcomm.com?part=3D15
