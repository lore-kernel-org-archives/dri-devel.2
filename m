Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C26606A32C
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 23:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T9MDTRgJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D50BA10EAD7;
	Sun,  1 Nov 2026 23:00:14 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D7D010EAD7
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 23:00:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8231E605CE;
 Sun,  1 Nov 2026 23:00:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C39D1F000C1;
 Sun,  1 Nov 2026 23:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793574007;
 bh=3k/kJc5KKPcMMNYhT37LBve6fhojnYYTaj7v+3LTh7k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=T9MDTRgJnQTcDosmkkozueOu+TgTdEgb0X0qcfvjHeFYXjZx4UQAEWYsQ1EWqMMCt
 OtJiyVTg2flzIFrvcLV0N0TV0lgPoU5d8OjxMehTe8L2s+txsLMflGQeITFERoMHFF
 LKrYgDS3uWyMArzSh6dJxA1j/slaCPr7Ekvdro9Hh1FZfPvK8LWqOoxfyGo2XOynU1
 JPvlWsK/aRJVLY6HW2HtChy5N5UOaDZ1HXHsQXmERxg4+azvfbPJaD50awki5ScDQR
 3YvXfnjK1pws9Yao8CPCStnpo+wY24T9Sae2TJVUOK/gKSSeoq8owjq3rpRaMCa+x7
 /iqKO2d3oaNUQ==
Message-ID: <sashiko-outbox-192746@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 22/25] accel/qda: Add remote session attach to the
 legacy shim
To: "Ekansh Gupta" <ekansh.gupta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261102-v4-v4-22-88f2f24a5f0b@qti.qualcomm.com>
References: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
 <20261102-v4-v4-22-88f2f24a5f0b@qti.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 23:00:06 +0000
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
- [High] accel/qda: race between qda_session_attach() and qda_session_init_=
create()
- [High] accel/qda: use-after-free in qda_session_attach() during rpmsg rem=
oval
- [Medium] accel/qda: interrupted wait in qda_attach_audio_pd() resends rem=
ote heap
--

commit ae4f1060dc81ff84d55ddf1c5fd82d79333077f8
Author: Ekansh Gupta <ekangupt@qti.qualcomm.com>

accel/qda: Add remote session attach to the legacy shim

This commit wires FASTRPC_IOCTL_INIT_ATTACH, FASTRPC_IOCTL_INIT_ATTACH_SNS,
and FASTRPC_IOCTL_INIT_CREATE_STATIC into the legacy FastRPC compatibility
shim by extracting qda_session_attach() and exposing it via
qda_legacy_ops_table.

> diff --git a/drivers/accel/qda/qda_fastrpc_shim.c b/drivers/accel/qda/qda=
_fastrpc_shim.c
> index c46d2de4f5818..c1464b1adbc2c 100644
> --- a/drivers/accel/qda/qda_fastrpc_shim.c
> +++ b/drivers/accel/qda/qda_fastrpc_shim.c
[ ... ]
> @@ -295,6 +296,23 @@ static long qda_shim_init_create(struct qda_shim_fil=
e *sf, void __user *argp)
>  	return err;
>  }
> =20
> +static long qda_shim_attach(struct qda_shim_file *sf, u32 pd_type)
> +{
> +	return qda_legacy_ops_table.attach(sf->session, pd_type, NULL, 0);
> +}
> +
> +/* memlen is ignored: the Audio PD heap size comes from the device tree =
*/
> +static long qda_shim_init_create_static(struct qda_shim_file *sf, void _=
_user *argp)
> +{
> +	struct fastrpc_init_create_static args;
> +
> +	if (copy_from_user(&args, argp, sizeof(args)))
> +		return -EFAULT;
> +
> +	return qda_legacy_ops_table.attach(sf->session, QDA_ATTACH_AUDIO_PD,
> +					   u64_to_user_ptr(args.name), args.namelen);
> +}

[Severity: High]
Can qda_shim_attach() and qda_shim_init_create_static() (as well as
qda_ioctl_attach()) trigger a use-after-free if the underlying rpmsg device
is removed while an attach ioctl is in flight?

Both qda_shim_ioctl() and drm_ioctl() only perform a point-in-time
drm_dev_is_unplugged() check on entry without entering a drm_dev_enter()
critical section:

drivers/accel/qda/qda_fastrpc_shim.c:qda_shim_ioctl() {
	if (drm_dev_is_unplugged(&sf->session->qda_dev->drm_dev))
		return -ENODEV;

	return qda_shim_dispatch(sf, cmd, (void __user *)arg);
}

If qda_rpmsg_remove() runs after that check passes (for example while
qda_shim_init_create_static() or qda_attach_audio_pd() sleeps in
copy_from_user() or memdup_user()), drm_dev_unplug() does not wait for the
in-flight qda_session_attach() call before tearing down the device:

drivers/accel/qda/qda_rpmsg.c:qda_rpmsg_remove() {
	drm_dev_unplug(&qdev->drm_dev);
	qdev->rpdev =3D NULL;
	qda_fastrpc_flush_pending(qdev);
	qda_cb_unpopulate(qdev);
	qda_deinit_device(qdev);
	qda_deinit_remote_heap(qdev);
}

qda_deinit_device() destroys qdev->iommu_mgr->assignment_lock and
qdev->ctx_xa, and devres teardown on &rpdev->dev frees qdev->iommu_mgr
(allocated with devm_kzalloc(qdev->dev, ...) in qda_init_device()). When the
in-flight qda_session_attach() proceeds into:

  qda_fastrpc_invoke()
    -> qda_fastrpc_context_alloc()
    -> qda_fastrpc_prepare_args()
      -> alloc_kernel_gem()
        -> qda_gem_create_object()
          -> qda_memory_manager_alloc()
            -> qda_memory_manager_assign_device()

wouldn't it access the destroyed qdev->ctx_xa and dereference the freed
qdev->iommu_mgr (or have its newly allocated ctx freed early if
qda_fastrpc_flush_pending() runs between qda_fastrpc_context_alloc() and
qda_rpmsg_send_msg())?

> diff --git a/drivers/accel/qda/qda_ioctl.c b/drivers/accel/qda/qda_ioctl.c
> index 41234fc576a9a..aaf3e5e6b5b18 100644
> --- a/drivers/accel/qda/qda_ioctl.c
> +++ b/drivers/accel/qda/qda_ioctl.c
> @@ -183,7 +183,7 @@ int qda_release_dsp_process(struct qda_dev *qdev, str=
uct qda_session *session)
>   * so that a concurrent one cannot skip the heap while the first is stil=
l in
>   * flight, and the flag is set only once the DSP has accepted it.
>   */
> -static int qda_attach_audio_pd(struct qda_session *session, struct drm_q=
da_remote_attach *args)
> +static int qda_attach_audio_pd(struct qda_session *session, const char _=
_user *uname, u32 namelen)
>  {
>  	struct qda_dev *qdev =3D session->qda_dev;
>  	struct qda_static_pd_args sargs =3D {};
> @@ -193,20 +193,20 @@ static int qda_attach_audio_pd(struct qda_session *=
session, struct drm_qda_remot
>  	if (strcmp(qdev->dsp_name, "adsp") || !qdev->remote_heap_size)
>  		return -ENODEV;
> =20
> -	if (!args->namelen || args->namelen > QDA_FASTRPC_INIT_NAMELEN_MAX)
> +	if (!namelen || namelen > QDA_FASTRPC_INIT_NAMELEN_MAX)
>  		return -EINVAL;
> =20
> -	name =3D memdup_user(u64_to_user_ptr(args->name), args->namelen);
> +	name =3D memdup_user(uname, namelen);
>  	if (IS_ERR(name))
>  		return PTR_ERR(name);
> =20
> -	if (name[args->namelen - 1]) {
> +	if (name[namelen - 1]) {
>  		err =3D -EINVAL;
>  		goto out_free;
>  	}
> =20
>  	sargs.name =3D name;
> -	sargs.namelen =3D args->namelen;
> +	sargs.namelen =3D namelen;
> =20
>  	scoped_guard(mutex, &qdev->remote_heap_lock) {
>  		if (!qdev->audio_init_mem) {

[Severity: Medium]
What happens in qda_attach_audio_pd() if qda_fastrpc_invoke() is interrupted
by a signal after sending the request to the DSP?

Inside the qdev->remote_heap_lock guard:

	scoped_guard(mutex, &qdev->remote_heap_lock) {
		if (!qdev->audio_init_mem) {
			sargs.heap.addr =3D qdev->remote_heap_addr;
			sargs.heap.size =3D qdev->remote_heap_size;
		}

		err =3D qda_fastrpc_invoke(QDA_FASTRPC_RMID_INIT_CREATE_STATIC, &sargs, s=
ession);
		if (!err && sargs.heap.size)
			qdev->audio_init_mem =3D true;
	}

qda_fastrpc_invoke_common() calls qda_rpmsg_send_msg() and then blocks in
qda_rpmsg_wait_for_rsp() via wait_for_completion_interruptible(&ctx->work).
If a signal interrupts the wait before the DSP replies, qda_fastrpc_invoke()
returns -ERESTARTSYS while the first QDA_FASTRPC_RMID_INIT_CREATE_STATIC
request is still in flight on the DSP.

Because err is non-zero, qdev->audio_init_mem remains false when
qdev->remote_heap_lock is released. Could a concurrent or restarted
FASTRPC_IOCTL_INIT_CREATE_STATIC / DRM_IOCTL_QDA_REMOTE_SESSION_ATTACH call
then observe !qdev->audio_init_mem and hand the remote heap to the DSP a
second time?

> @@ -226,38 +226,60 @@ static int qda_attach_audio_pd(struct qda_session *=
session, struct drm_qda_remot
>  }
> =20
>  /**
> - * qda_ioctl_attach() - Attach to a DSP-resident protection domain
> - * @dev: DRM device structure
> - * @data: User-space data (struct drm_qda_remote_attach)
> - * @file_priv: DRM file private data
> + * qda_session_attach() - Attach a session to a DSP-resident protection =
domain
> + * @session: Session to attach
> + * @pd_type: QDA_ATTACH_ROOT_PD, QDA_ATTACH_SENSORS_PD or QDA_ATTACH_AUD=
IO_PD
> + * @name: User pointer to the static PD name (QDA_ATTACH_AUDIO_PD only)
> + * @namelen: Length of @name including the NUL (QDA_ATTACH_AUDIO_PD only)
> + *
> + * Shared by the accel UAPI and the legacy shim, so the privilege check =
lives
> + * here rather than on the ioctl.
>   *
>   * Return: 0 on success, negative error code on failure
>   */
> -int qda_ioctl_attach(struct drm_device *dev, void *data, struct drm_file=
 *file_priv)
> +int qda_session_attach(struct qda_session *session, u32 pd_type, const c=
har __user *name,
> +		       u32 namelen)
>  {
> -	struct drm_qda_remote_attach *args =3D data;
> -	struct qda_session *session =3D file_priv->driver_priv;
>  	int pd;
> =20
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
>  	if (READ_ONCE(session->init_mem_gem_obj))
>  		return -EBUSY;
> =20
> -	switch (args->pd_type) {
> +	switch (pd_type) {
>  	case QDA_ATTACH_ROOT_PD:
>  	case QDA_ATTACH_SENSORS_PD:
> -		if (args->name || args->namelen)
> +		if (name || namelen)
>  			return -EINVAL;
> =20
> -		pd =3D args->pd_type =3D=3D QDA_ATTACH_ROOT_PD ? QDA_ROOT_PD : QDA_SEN=
SORS_PD;
> +		pd =3D pd_type =3D=3D QDA_ATTACH_ROOT_PD ? QDA_ROOT_PD : QDA_SENSORS_P=
D;
> =20
>  		return qda_fastrpc_invoke(QDA_FASTRPC_RMID_INIT_ATTACH, &pd, session);
>  	case QDA_ATTACH_AUDIO_PD:
> -		return qda_attach_audio_pd(session, args);
> +		return qda_attach_audio_pd(session, name, namelen);
>  	default:
>  		return -EINVAL;
>  	}
>  }

[Severity: High]
Does qda_session_attach() race with concurrent qda_session_init_create()
calls on the same session?

Both the accel UAPI and the legacy shim allow concurrent ioctls on the same
open file without holding a per-session lock. In qda_session_attach(), the
check:

	if (READ_ONCE(session->init_mem_gem_obj))
		return -EBUSY;

runs unlocked before qda_fastrpc_invoke() sleeps waiting for the DSP
response, and qda_session_init_create() does not check whether the session
has already attached or is attaching. State updates only happen after the
DSP responds in qda_fastrpc_invoke():

	if (type =3D=3D QDA_FASTRPC_RMID_INIT_CREATE) {
		qda_session_set_init_mem(session, ctx->init_mem_gem_obj);
		WRITE_ONCE(session->pd, QDA_USER_PD);
	} else if (type =3D=3D QDA_FASTRPC_RMID_INIT_ATTACH ||
		   type =3D=3D QDA_FASTRPC_RMID_INIT_CREATE_STATIC) {
		WRITE_ONCE(session->pd, ctx->pd);
	}

If one thread calls qda_session_attach() and another concurrently calls
qda_session_init_create() on the same file descriptor, both can pass
validation and send RPCs to the DSP. If QDA_FASTRPC_RMID_INIT_CREATE finish=
es
first (setting session->init_mem_gem_obj and session->pd =3D QDA_USER_PD) a=
nd
QDA_FASTRPC_RMID_INIT_ATTACH finishes second, session->pd is overwritten wi=
th
QDA_ROOT_PD or QDA_SENSORS_PD while session->init_mem_gem_obj remains
non-NULL.

When the file is later closed, legacy_release() or qda_postclose() sees
session->init_mem_gem_obj is non-NULL and calls qda_release_dsp_process(),
which sends QDA_FASTRPC_RMID_INIT_RELEASE directed at READ_ONCE(session->pd)
(now the attached PD instead of QDA_USER_PD). Wouldn't that leave the User =
PD
process running on the DSP while qda_session_release() frees
session->init_mem_gem_obj underneath it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-v4-v4-0-88=
f2f24a5f0b@qti.qualcomm.com?part=3D22
