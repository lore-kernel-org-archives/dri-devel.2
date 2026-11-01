Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FEA606A326
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 23:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nbl9wLqA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B274210EAE2;
	Sun,  1 Nov 2026 23:05:43 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9370210EAE2
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 23:05:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BA82D605CE;
 Sun,  1 Nov 2026 23:05:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480C41F000C1;
 Sun,  1 Nov 2026 23:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793574336;
 bh=3d7JQ7nIIOHvt9ytgZs8SmES7IJbS0pHckkjhW/R4JQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nbl9wLqARooiokNMnR8dLLJh1ZKHHoSZ0wrVPL/G0NpntEvXRTMQRAo+sZhq7Isxo
 hAUieF7MT2clpKVLhmYjI5MOh3IUOkyPNPCDO7Kin8eN+iy0HEWZtFXtr3YGuShSDo
 qv1fLI4/2CqbNO+kow7m+NtMqexOEZkLxfMK8jdv9zWM+4FcRyo5iekjZ9V4obMWzJ
 i99fTmJWLZDEdImIfKns6uVpCE3fyMDxxJnlsPmZAuijwNc0OvHuQbHwz3watL2XLq
 Nsep6UDvZRBIK0F0KnsxRmvu1gyAtCL6dwivPdYgRIxqjHpy7mmEvaL+dmfyuPqdlA
 R9vFpJp/fhc0A==
Message-ID: <sashiko-outbox-192751@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 24/25] accel/qda: Add legacy shim support for DSP
 capability query
To: "Ekansh Gupta" <ekansh.gupta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261102-v4-v4-24-88f2f24a5f0b@qti.qualcomm.com>
References: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
 <20261102-v4-v4-24-88f2f24a5f0b@qti.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 23:05:35 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] accel/qda: non-zero remote_session_id sent in qda_fastrpc_invoke=
_pack()
- [Low] accel/qda: commit message references non-existent qda_fastrpc_get_d=
sp_info()
--

commit a3e1eaffe6784dab5dbbf7ef1443bdf4fdd1f0a5
Author: Ekansh Gupta <ekangupt@qti.qualcomm.com>

accel/qda: Add legacy shim support for DSP capability query

This commit wires FASTRPC_IOCTL_GET_DSP_INFO into the legacy FastRPC
compatibility shim so user space can query DSP capabilities through
/dev/fastrpc-* devices using the shared capability cache.

>     accel/qda: Add legacy shim support for DSP capability query
>    =20
>     Wire FASTRPC_IOCTL_GET_DSP_INFO into the legacy FastRPC compatibility
>     shim on top of qda_fastrpc_get_dsp_info(), so existing user space can
>     query DSP capabilities through the /dev/fastrpc-* interface exactly
>     as it could with the driver this one replaces.
>    =20
>     The device-wide capability cache introduced for the native
>     DRM_IOCTL_QDA_QUERY path is reused as-is; the shim only has to
>     translate between the legacy fastrpc_ioctl_capability layout and the
>     shared qda_fastrpc_get_dsp_info() call.
>    =20
>     Signed-off-by: Ekansh Gupta <ekangupt@qti.qualcomm.com>

[Severity: Low]
This isn't a bug, but the commit message states twice that
FASTRPC_IOCTL_GET_DSP_INFO is wired on top of qda_fastrpc_get_dsp_info().
Should this reference qda_get_dsp_capability() instead, since
legacy_get_dsp_info() in drivers/accel/qda/qda_legacy_ops.c delegates to
qda_get_dsp_capability() and no function named qda_fastrpc_get_dsp_info()
exists in the codebase?

> diff --git a/drivers/accel/qda/qda_legacy_ops.c b/drivers/accel/qda/qda_l=
egacy_ops.c
> index fc5e94c0c9bcd..8d9d597c76c26 100644
> --- a/drivers/accel/qda/qda_legacy_ops.c
> +++ b/drivers/accel/qda/qda_legacy_ops.c
> @@ -188,6 +188,11 @@ static int legacy_invoke(struct qda_session *session=
, u32 handle, u32 sc,
>  	return qda_fastrpc_invoke_legacy(session->qda_dev, session, handle, sc,=
 args);
>  }
> =20
> +static int legacy_get_dsp_info(struct qda_session *session, u32 attribut=
e_id, u32 *capability)
> +{
> +	return qda_get_dsp_capability(session->qda_dev, session, attribute_id, =
capability);
> +}

[Severity: Medium]
When user space opens /dev/fastrpc-* (which assigns a positive
session->remote_session_id via qda_session_alloc()) and issues
FASTRPC_IOCTL_GET_DSP_INFO before creating a DSP process, will the DSP
accept the capability query with a non-zero msg->fastrpc.remote_session_id?

When qdev->valid_attributes is false, the call chain:

  qda_shim_get_dsp_info()
    legacy_get_dsp_info()
      qda_get_dsp_capability()
        qda_fastrpc_invoke(QDA_FASTRPC_TYPE_GET_DSP_INFO, ...)
          qda_fastrpc_invoke_common()
            qda_fastrpc_invoke_pack()

packs the request with ctx->handle set to QDA_FASTRPC_DSP_UTILITIES_HANDLE.

However, in drivers/accel/qda/qda_fastrpc.c, qda_fastrpc_invoke_pack() only
zeroes remote_session_id for QDA_FASTRPC_INIT_HANDLE:

	/* The session has no process yet to identify while one is being created */
	if (ctx->handle =3D=3D QDA_FASTRPC_INIT_HANDLE)
		msg->fastrpc.remote_session_id =3D 0;
	else
		msg->fastrpc.remote_session_id =3D ctx->session->remote_session_id;

In contrast, in drivers/misc/fastrpc.c, fastrpc_get_info_from_dsp() calls
fastrpc_internal_invoke() with kernel =3D true, and fastrpc_invoke_send() s=
ets
msg->client_id =3D 0 whenever kernel is true.

Should qda_fastrpc_invoke_pack() also set msg->fastrpc.remote_session_id =
=3D 0
when ctx->handle =3D=3D QDA_FASTRPC_DSP_UTILITIES_HANDLE so that capability
queries match the legacy driver and do not pass an uninitialized DSP
process's session ID?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-v4-v4-0-88=
f2f24a5f0b@qti.qualcomm.com?part=3D24
