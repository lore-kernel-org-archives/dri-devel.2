Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC60606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 23:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AhRd3s+x
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09C8E10EAE1;
	Sun,  1 Nov 2026 23:03:57 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 306E210EAE1
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 23:03:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7011D605CE;
 Sun,  1 Nov 2026 23:03:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9EFC1F000C1;
 Sun,  1 Nov 2026 23:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793574230;
 bh=1k9VPmgUKLR9y4zfOkmrvWNcPce/g4gg8PNddO8ZZVM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AhRd3s+xcxxE9UIc4q7V97SAAiwidddd9D4o8dOWaJBX76befSipE2ZEhKUZx0Jrz
 wO6TwpJ7ZG83CSWdzsatIRNxzP6YhZ57l2vXHvqGCdTmg/KgHH2zzOABloR5CShsVq
 1SHXGVuQm7nKUuaYE6WuBO3BpgPUQT5RTJRKyvMfZgJ0xzuGuTVP+WQMnUSw5InKN1
 fmkkpG+DnlIc32twvWi7JdDY9vxZkhPjIBJ0ItbL6idArhF3fp84tvgqu++R/8u+W5
 iGOKnfEZ1S3vswubaMKlOI//XZWaXwGk1UvPeplf2yPl3PHOwToGq429KgbgRT+gEM
 BxwKbvwHk0ZTg==
Message-ID: <sashiko-outbox-192750@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 23/25] accel/qda: Add DSP capability query
To: "Ekansh Gupta" <ekansh.gupta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261102-v4-v4-23-88f2f24a5f0b@qti.qualcomm.com>
References: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
 <20261102-v4-v4-23-88f2f24a5f0b@qti.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 23:03:49 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] accel/qda: non-zero remote_session_id in qda_fastrpc_invoke_pack()=
 for dsp info
- [Medium] accel/qda: destroyed mutex qdev->attr_lock while held in qda_dei=
nit_device()
--

commit 8c89a0764b44acd4840198a5f29101cbf6dc706a
Author: Ekansh Gupta <ekangupt@qti.qualcomm.com>

accel/qda: Add DSP capability query

This commit adds a QDA_QUERY_DSP_CAPABILITIES query type to
DRM_IOCTL_QDA_QUERY to fetch DSP capability attributes through the DSP
utilities handle and cache them on the device for subsequent queries.

> diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
> index 1e72dce769b9a..51d8ef10c6c1a 100644
> --- a/drivers/accel/qda/qda_drv.c
> +++ b/drivers/accel/qda/qda_drv.c
> @@ -154,6 +154,7 @@ struct qda_dev *qda_alloc_device(struct device *dev)
> =20
>  	INIT_LIST_HEAD(&qdev->cb_devs);
>  	mutex_init(&qdev->import_lock);
> +	mutex_init(&qdev->attr_lock);
>  	xa_init_flags(&qdev->ctx_xa, XA_FLAGS_ALLOC1);
>  	atomic64_set(&qdev->ctx_seq, 0);
>  	atomic_set(&qdev->session_id_seq, 0);
> @@ -181,6 +182,7 @@ void qda_deinit_device(struct qda_dev *qdev)
>  	qda_memory_manager_exit(qdev->iommu_mgr);
>  	xa_destroy(&qdev->ctx_xa);
>  	mutex_destroy(&qdev->import_lock);
> +	mutex_destroy(&qdev->attr_lock);
>  }

[Severity: Medium]
Can mutex_destroy(&qdev->attr_lock) in qda_deinit_device() run while
qdev->attr_lock is still held or waited on by qda_get_dsp_capability()?

In qda_get_dsp_capability(), qdev->attr_lock is held across
qda_fastrpc_invoke():

drivers/accel/qda/qda_ioctl.c:qda_get_dsp_capability() {
	guard(mutex)(&qdev->attr_lock);

	if (!qdev->valid_attributes) {
		err =3D qda_fastrpc_invoke(QDA_FASTRPC_TYPE_GET_DSP_INFO, qdev->dsp_attri=
butes,
					 session);
}

Inside qda_fastrpc_invoke() -> qda_fastrpc_invoke_common(),
qda_rpmsg_send_msg() calls drm_dev_exit() after rpmsg_send(), and then
qda_rpmsg_wait_for_rsp() sleeps in wait_for_completion_interruptible(&ctx->=
work)
while qdev->attr_lock remains held.

If the remote processor crashes or the rpmsg device is removed before the
DSP replies, qda_rpmsg_remove() runs:

drivers/accel/qda/qda_rpmsg.c:qda_rpmsg_remove() {
	drm_dev_unplug(&qdev->drm_dev);
	qdev->rpdev =3D NULL;
	qda_fastrpc_flush_pending(qdev);
	qda_cb_unpopulate(qdev);
	qda_deinit_device(qdev);
}

Because the waiting thread already exited the drm_dev_enter() section,
drm_dev_unplug() does not wait for it. qda_fastrpc_flush_pending() wakes
the invocation with complete(&ctx->work) and qda_rpmsg_remove() proceeds
directly to qda_deinit_device() -> mutex_destroy(&qdev->attr_lock) before
the woken thread in qda_get_dsp_capability() has unlocked qdev->attr_lock.

> diff --git a/drivers/accel/qda/qda_fastrpc.c b/drivers/accel/qda/qda_fast=
rpc.c
> index e9688e3ba4048..6044cfad53e96 100644
> --- a/drivers/accel/qda/qda_fastrpc.c
> +++ b/drivers/accel/qda/qda_fastrpc.c

[ ... ]

> @@ -980,6 +987,43 @@ static int qda_fastrpc_prepare_args_create_static(st=
ruct qda_fastrpc_invoke_ctx
>  	return 0;
>  }
> =20
> +/*
> + * DSP capability query packed layout:
> + *   [0] count	sizeof(u32), the capacity of the array below	IN
> + *   [1] attrs	(QDA_MAX_DSP_ATTRIBUTES - 1) * sizeof(u32)	OUT
> + *
> + * Index 0 of the cached array is reserved, so only the rest is exchange=
d.
> + */
> +static int qda_fastrpc_prepare_args_get_dsp_info(struct qda_fastrpc_invo=
ke_ctx *ctx)
> +{
> +	const u32 attr_count =3D QDA_MAX_DSP_ATTRIBUTES - 1;
> +	struct qda_gem_obj *kernel_gem;
> +	int err;
> +
> +	const size_t off_attrs =3D sizeof(u32);
> +	const size_t total_size =3D off_attrs + attr_count * sizeof(u32);
> +
> +	ctx->sc =3D QDA_FASTRPC_SCALARS(0, 1, 1);
> +	ctx->handle =3D QDA_FASTRPC_DSP_UTILITIES_HANDLE;

[Severity: High]
When ctx->handle is set to QDA_FASTRPC_DSP_UTILITIES_HANDLE here, should
qda_fastrpc_invoke_pack() also set msg->fastrpc.remote_session_id to 0?

Currently, qda_fastrpc_invoke_pack() only checks for QDA_FASTRPC_INIT_HANDL=
E:

drivers/accel/qda/qda_fastrpc.c:qda_fastrpc_invoke_pack() {
	/* The session has no process yet to identify while one is being created */
	if (ctx->handle =3D=3D QDA_FASTRPC_INIT_HANDLE)
		msg->fastrpc.remote_session_id =3D 0;
	else
		msg->fastrpc.remote_session_id =3D ctx->session->remote_session_id;
}

When userspace issues DRM_IOCTL_QDA_QUERY with QDA_QUERY_DSP_CAPABILITIES
before creating a DSP process on the session, qda_fastrpc_invoke_pack()
will pack the session's non-zero remote_session_id into the RPMsg wire
header for a stateless utilities call that has no remote process context
(whereas drivers/misc/fastrpc.c passes kernel =3D true in
fastrpc_get_info_from_dsp() so fastrpc_invoke_send() sets msg->client_id =
=3D 0).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-v4-v4-0-88=
f2f24a5f0b@qti.qualcomm.com?part=3D23
