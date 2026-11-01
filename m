Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1C4606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 22:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jhx8V7uE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 297FB10EACF;
	Sun,  1 Nov 2026 22:48:19 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73C8210EACF
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 22:48:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 28A4A40E45;
 Sun,  1 Nov 2026 22:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2C11F00919;
 Sun,  1 Nov 2026 22:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793573293;
 bh=vTIZEbQ+QiUHI5noJxVIcUxNqPMJj7WhcV9msWIb8z8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jhx8V7uEm/RriPwOr/6oU7kbr4daoB6BZdktRdANwBgdz4sfJ1u55tdaliDqR8tp7
 ZzU4PNKKszxVQ1QpBbnaJ/B4Dmm6uzUe1SaRQUfyHUjb8xQLRjX3ubfSvxylAiagb/
 52rdGLAnPabCiUK6TJW0XLoGhtLFB5xJ0QaoItAAOAmVHo/SbJVC+toa9F65hJR7S7
 5cO4ZS7Re0nbO+mSwyBZa/q8iYrrGvKxQAAunjvhJ6FrdCBMFW1kUI3g/JjEwkCB1c
 moWunQIjLpNrAx4ZCJzr57DMAaE++dQkamhIzI4Dc42+n8HYMW4OGeRRGNKA8IuqNl
 rTMetPy8CPhLQ==
Message-ID: <sashiko-outbox-192734@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 16/25] accel/qda: Add DSP process creation and
 release to the legacy shim
To: "Ekansh Gupta" <ekansh.gupta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261102-v4-v4-16-88f2f24a5f0b@qti.qualcomm.com>
References: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
 <20261102-v4-v4-16-88f2f24a5f0b@qti.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 22:48:12 +0000
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
- [High] accel/qda: TOCTOU race and UAF between legacy_release() and qda_rp=
msg_remove()
- [High] accel/qda: missing QDA_FASTRPC_INIT_HANDLE check on user invoke pa=
ths
- [Medium] accel/qda: qda_shim_init_create() imports args.filefd when filel=
en or filefd is 0
--

commit cd276e39d68d699c859df87ba50e8e071d334588
Author: Ekansh Gupta <ekangupt@qti.qualcomm.com>

accel/qda: Add DSP process creation and release to the legacy shim

This commit adds DSP process creation (FASTRPC_IOCTL_INIT_CREATE) and relea=
se
upon file close to the legacy /dev/fastrpc-* compatibility shim, enforcing
secure/non-secure node rules and importing the ELF image file descriptor in=
to
the session's context bank.

> diff --git a/drivers/accel/qda/qda_fastrpc_shim.c b/drivers/accel/qda/qda=
_fastrpc_shim.c
> index 03fce990ccdb9..4a2ba20ee01ac 100644
> --- a/drivers/accel/qda/qda_fastrpc_shim.c
> +++ b/drivers/accel/qda/qda_fastrpc_shim.c
[ ... ]
> @@ -141,6 +154,43 @@ static long qda_shim_alloc_dma_buf(struct qda_shim_f=
ile *sf, void __user *argp)
>  	return 0;
>  }
> =20
> +/*
> + * As in drivers/misc/fastrpc.c: on a secure channel, a client that came=
 in
> + * through the non-secure node may only create an unsigned PD, and only =
on a
> + * domain that supports unsigned PD offload.
> + */
> +static bool qda_shim_session_rejected(struct qda_shim_file *sf, bool uns=
igned_pd)
> +{
> +	if (!sf->secure_node && sf->secure_channel)
> +		return !sf->unsigned_support || !unsigned_pd;
> +
> +	return false;
> +}
> +
> +static long qda_shim_init_create(struct qda_shim_file *sf, void __user *=
argp)
> +{
> +	struct drm_gem_object *elf_obj =3D NULL;
> +	struct fastrpc_init_create args;
> +	int err;
> +
> +	if (copy_from_user(&args, argp, sizeof(args)))
> +		return -EFAULT;
> +
> +	if (qda_shim_session_rejected(sf, args.attrs & FASTRPC_MODE_UNSIGNED_MO=
DULE))
> +		return -ECONNREFUSED;

[Severity: High]
Can user space bypass both qda_shim_session_rejected() here and the
CAP_SYS_ADMIN check in qda_fastrpc_prepare_args_init_create() by sending a
QDA_FASTRPC_INIT_HANDLE (0x1) message through FASTRPC_IOCTL_INVOKE or
DRM_IOCTL_QDA_REMOTE_INVOKE?

In drivers/misc/fastrpc.c, fastrpc_internal_invoke() rejects user-space
invocations targeting FASTRPC_INIT_HANDLE with -EPERM when !kernel. Here,
however, neither qda_shim_invoke() -> legacy_invoke() ->
qda_fastrpc_invoke_legacy() nor qda_ioctl_invoke() ->
qda_fastrpc_prepare_args_invoke() blocks handle =3D=3D QDA_FASTRPC_INIT_HAN=
DLE.

Even more concerning, qda_fastrpc_invoke_pack() checks ctx->handle rather t=
han
ctx->type:

    if (ctx->handle =3D=3D QDA_FASTRPC_INIT_HANDLE)
        msg->fastrpc.remote_session_id =3D 0;
    else
        msg->fastrpc.remote_session_id =3D ctx->session->remote_session_id;

As a result, an unprivileged client on a non-secure node can call
FASTRPC_IOCTL_INIT_CREATE with FASTRPC_MODE_UNSIGNED_MODULE to transition
session->pd to QDA_USER_PD (or leave session->pd at QDA_ROOT_PD) and then i=
ssue
FASTRPC_IOCTL_INVOKE with handle =3D QDA_FASTRPC_INIT_HANDLE and sc encoding
QDA_FASTRPC_RMID_INIT_CREATE, QDA_FASTRPC_RMID_INIT_CREATE_ATTR, or
QDA_FASTRPC_RMID_INIT_RELEASE using user-controlled buffers. Should
QDA_FASTRPC_INIT_HANDLE be rejected on the user-space invoke paths?

> +
> +	elf_obj =3D shim_import_fd(sf->session, args.filefd);
> +	if (IS_ERR(elf_obj))
> +		return PTR_ERR(elf_obj);

[Severity: Medium]
What happens in qda_shim_init_create() when user space passes a
zero-initialized args.filefd (0) for an empty image (args.filelen =3D=3D 0)=
 or for
a bare-pointer image (args.file !=3D 0, args.filelen > 0), or when args.fil=
elen
is 0 with a non-negative args.filefd?

In drivers/misc/fastrpc.c, fastrpc_init_create_process() only imports
init.filefd when both init.filelen and init.filefd are non-zero:

    if (init.filelen && init.filefd) {
        ...
    }

And in drivers/accel/qda/qda_legacy_ops.c, legacy_init_create() is written =
to
expect elf_obj =3D=3D NULL when no descriptor-backed image is used:

    if (!elf_obj && filelen)
        return -EOPNOTSUPP;

However, shim_import_fd() only treats negative file descriptors as absent:

    if (fd < 0)
        return NULL;

    dmabuf =3D dma_buf_get(fd);

If a caller zero-initializes struct fastrpc_init_create so args.filefd is 0,
shim_import_fd(sf->session, 0) calls dma_buf_get(0) on standard input, fail=
ing
with -EINVAL or -EBADF instead of allowing an empty image or returning
-EOPNOTSUPP for a bare pointer (or silently importing fd 0 if stdin happens=
 to
be a valid DMA-BUF). Should qda_shim_init_create() only call shim_import_fd=
()
when args.filelen && args.filefd (or should shim_import_fd() treat fd <=3D =
0 as
absent)?

> diff --git a/drivers/accel/qda/qda_legacy_ops.c b/drivers/accel/qda/qda_l=
egacy_ops.c
> index 74ee4995350e2..2b3b3f4fb246b 100644
> --- a/drivers/accel/qda/qda_legacy_ops.c
> +++ b/drivers/accel/qda/qda_legacy_ops.c
[ ... ]
> @@ -38,6 +39,42 @@ static void legacy_session_destroy(struct qda_session =
*session)
>  	drm_dev_put(drm_dev);
>  }
[ ... ]
> +static int legacy_release(struct qda_session *session)
> +{
> +	/* Only a session that created a process has one to release */
> +	if (!READ_ONCE(session->init_mem_gem_obj))
> +		return 0;
> +
> +	/* Unplug check only; see qda_shim_ioctl() for why not drm_dev_enter() =
*/
> +	if (drm_dev_is_unplugged(&session->qda_dev->drm_dev))
> +		return -ENODEV;
> +
> +	return qda_release_dsp_process(session->qda_dev, session);
> +}

[Severity: High]
Does using drm_dev_is_unplugged() instead of holding a critical section acr=
oss
qda_release_dsp_process() expose a race and use-after-free with
qda_rpmsg_remove()?

In drivers/accel/qda/qda_rpmsg.c, qda_rpmsg_remove() relies on
drm_dev_unplug() to wait for active callers to finish before flushing pendi=
ng
contexts and tearing down device resources:

    drm_dev_unplug(&qdev->drm_dev);
    qdev->rpdev =3D NULL;
    qda_fastrpc_flush_pending(qdev);
    qda_cb_unpopulate(qdev);
    qda_deinit_device(qdev);

Because drm_dev_is_unplugged() immediately drops its SRCU read lock via
drm_dev_exit(), qda_rpmsg_remove() can run concurrently right after
drm_dev_is_unplugged() returns false:

1. In qda_release_dsp_process() -> qda_fastrpc_invoke(),
   qda_fastrpc_context_alloc(qdev) allocates ctx with refcount =3D=3D 1 and=
 stores
   it in qdev->ctx_xa.
2. Concurrently, qda_rpmsg_remove() calls drm_dev_unplug(&qdev->drm_dev).
   When qda_fastrpc_invoke_common() calls qda_rpmsg_send_msg(), drm_dev_ent=
er()
   now fails with -ENODEV, so the second reference on ctx for the response
   callback is never taken.
3. Meanwhile, qda_fastrpc_flush_pending(qdev) in qda_rpmsg_remove() iterates
   qdev->ctx_xa and calls kref_put(&ctx->refcount, qda_fastrpc_context_free=
),
   dropping the caller's sole reference and freeing ctx while
   qda_fastrpc_invoke() is still using it and about to call
   kref_put(&ctx->refcount, qda_fastrpc_context_free) a second time at out_=
put.
4. Furthermore, qda_rpmsg_remove() proceeds to qda_cb_unpopulate(qdev) and
   qda_deinit_device(qdev) (destroying the context-bank platform devices,
   qdev->iommu_mgr, and qdev->ctx_xa) while qda_release_dsp_process() is st=
ill
   allocating from qdev->ctx_xa and qdev->iommu_mgr.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-v4-v4-0-88=
f2f24a5f0b@qti.qualcomm.com?part=3D16
