Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273E2606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 22:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B42wBbuB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 716F310EAD0;
	Sun,  1 Nov 2026 22:49:56 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3612810E4C8
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 22:49:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5E4C4601FF;
 Sun,  1 Nov 2026 22:49:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E019B1F000C1;
 Sun,  1 Nov 2026 22:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793573389;
 bh=vV6kLb6DHFb6iq8kDn3ambSc6ACGAIYEvJIhMocz2t8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=B42wBbuBjA2cWWeAWQeDGUAHJLLYR1wWgFy37FTK0ouf7XrxsIBs7MHJ/XyeVqwR5
 z6XdHJXYRn56ZNTDh0OH3k/aOIjnF5q74CYHuZCaQHBb5MbJUZ/tb/mKAyO4l5K2Em
 Xl/JgoQ9gPLNU9ywfxNirhCP35Hijq/92yXJmzzT73AdK3mdCTT5eT3BjbClrLzXv+
 Yk7OEtGHP6B8kWQXvUQjHjSAoHp7coN5O/W/ytwVdxy+GiqJyLMbfqUQrF5HfEbEIA
 jmqH0NPj6z+3Fjnv1t2HgIjQmA+2uyoOWg85vYAwUs7kn+IAPpLAg23oMsZ+R26TQv
 DgXa+Xu8nsKdQ==
Message-ID: <sashiko-outbox-192735@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 20/25] accel/qda: Add remote attach to root and
 sensors protection domains
To: "Ekansh Gupta" <ekansh.gupta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261102-v4-v4-20-88f2f24a5f0b@qti.qualcomm.com>
References: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
 <20261102-v4-v4-20-88f2f24a5f0b@qti.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 22:49:48 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] accel/qda: race between qda_ioctl_attach() and qda_ioctl_init_crea=
te()
--

commit c03ef3a6851102dcdbec94040ce6c4949c48a5b9
Author: Ekansh Gupta <ekangupt@qti.qualcomm.com>

accel/qda: Add remote attach to root and sensors protection domains

This commit adds an ioctl to attach a calling session to an existing root or
sensors protection domain on the DSP instead of creating a new user process.

> diff --git a/drivers/accel/qda/qda_ioctl.c b/drivers/accel/qda/qda_ioctl.c
> index 999afa9e70c23..9b8cccfea1e3a 100644
> --- a/drivers/accel/qda/qda_ioctl.c
> +++ b/drivers/accel/qda/qda_ioctl.c
> @@ -121,6 +121,8 @@ static int qda_fastrpc_invoke(u32 type, void *data, s=
truct qda_session *session)
>  	if (type =3D=3D QDA_FASTRPC_RMID_INIT_CREATE) {
>  		qda_session_set_init_mem(session, ctx->init_mem_gem_obj);
>  		WRITE_ONCE(session->pd, QDA_USER_PD);
> +	} else if (type =3D=3D QDA_FASTRPC_RMID_INIT_ATTACH) {
> +		WRITE_ONCE(session->pd, ctx->pd);
>  	}
> =20
>  out_put:
> @@ -174,6 +176,40 @@ int qda_release_dsp_process(struct qda_dev *qdev, st=
ruct qda_session *session)
>  	return qda_fastrpc_invoke(QDA_FASTRPC_RMID_INIT_RELEASE, NULL, session);
>  }
> =20
> +/**
> + * qda_ioctl_attach() - Attach to a DSP-resident protection domain
> + * @dev: DRM device structure
> + * @data: User-space data (struct drm_qda_remote_attach)
> + * @file_priv: DRM file private data
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +int qda_ioctl_attach(struct drm_device *dev, void *data, struct drm_file=
 *file_priv)
> +{
> +	struct drm_qda_remote_attach *args =3D data;
> +	struct qda_session *session =3D file_priv->driver_priv;
> +	int pd;
> +
> +	if (args->pad)
> +		return -EINVAL;
> +
> +	switch (args->pd_type) {
> +	case QDA_ATTACH_ROOT_PD:
> +		pd =3D QDA_ROOT_PD;
> +		break;
> +	case QDA_ATTACH_SENSORS_PD:
> +		pd =3D QDA_SENSORS_PD;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (READ_ONCE(session->init_mem_gem_obj))
> +		return -EBUSY;
> +
> +	return qda_fastrpc_invoke(QDA_FASTRPC_RMID_INIT_ATTACH, &pd, session);
> +}

[Severity: High]
Can a concurrent call to qda_ioctl_init_create() race with qda_ioctl_attach=
()
on the same file descriptor and corrupt session->pd?

As noted in the struct qda_session definition for init_mem_gem_obj, ioctls =
on
a single file can run concurrently. In qda_ioctl_attach(),
session->init_mem_gem_obj is checked without holding a lock before calling
qda_fastrpc_invoke(), which sleeps in qda_fastrpc_invoke_common() while
waiting for the DSP response.

Meanwhile, qda_ioctl_init_create() -> qda_session_init_create() ->
qda_fastrpc_invoke() only populates session->init_mem_gem_obj via
qda_session_set_init_mem() after its own DSP invocation completes:

	if (type =3D=3D QDA_FASTRPC_RMID_INIT_CREATE) {
		qda_session_set_init_mem(session, ctx->init_mem_gem_obj);
		WRITE_ONCE(session->pd, QDA_USER_PD);
	} else if (type =3D=3D QDA_FASTRPC_RMID_INIT_ATTACH) {
		WRITE_ONCE(session->pd, ctx->pd);
	}

If thread 1 runs qda_ioctl_init_create() and thread 2 runs qda_ioctl_attach=
()
before thread 1's RPC finishes, thread 2 sees session->init_mem_gem_obj as
null and proceeds. If thread 1 finishes first and sets
session->init_mem_gem_obj and session->pd, and thread 2 finishes second,
thread 2 will overwrite session->pd with the attached root or sensors domain
(or conversely, qda_ioctl_init_create() can be called on an already-attached
session).

When the file is later closed, qda_postclose() checks
session->init_mem_gem_obj and sends the process release request to
session->pd:

drivers/accel/qda/qda_drv.c:qda_postclose() {
	if (READ_ONCE(session->init_mem_gem_obj) && drm_dev_enter(dev, &idx)) {
		qda_release_dsp_process(session->qda_dev, session);
		drm_dev_exit(idx);
	}

	qda_session_put(session);
}

Because qda_fastrpc_prepare_args() sets ctx->pd from session->pd, wouldn't
qda_release_dsp_process() send the release message to the wrong protection
domain, leaving the user process running on the DSP while qda_session_put()
frees session->init_mem_gem_obj?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-v4-v4-0-88=
f2f24a5f0b@qti.qualcomm.com?part=3D20
