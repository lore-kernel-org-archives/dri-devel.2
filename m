Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9231B606A32C
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 09:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bGrmGLWg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E968610EC38;
	Mon,  2 Nov 2026 09:06:13 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDD9310EC38
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 09:06:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6B9F340483;
 Mon,  2 Nov 2026 09:06:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C751F000C1;
 Mon,  2 Nov 2026 09:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793610367;
 bh=E050Cb4NvGpuJuKeOYNm6YfY39i+zJx9O4OhRK/W0bw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bGrmGLWgelWMzt8ksLZnuccoB1h4PkiBc0E9cTkeLqTpBq4RQrRUpjfgw1TXoPEdr
 e6uexaOnHMsc4XPcjBAnKmnaeHDf5BvmcvHUKXMPCqx1vEkzERxd5v+PO0mwRQJqIK
 gKYVzMOnNIH3W3kIZGlMACNzjKeH53rGZY0sKqqsIDu7LFlCGTfsy0OjiFYe9C7wTV
 2YCPwu14WubTTXhcJgGwpHaFeCY9uPdP6HK7CPgSmMF0DTsZBRq8McwjNAMUaLfdIt
 nzbyYcenIfz4G+E2edWZ90hV1Wnc8asLPnTiuRoVJL7NIPyYSWhlwPLdvM2kc7DWTq
 zPR7yqrDnVi0g==
Message-ID: <sashiko-outbox-193153@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/3] misc: fastrpc: move ADSP duplicate session
 creation to the driver
To: "Vinayak Katoch" <vinayak.katoch@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261102-dup-sessions-v7-2-03f06c014e78@oss.qualcomm.com>
References: <20261102-dup-sessions-v7-0-03f06c014e78@oss.qualcomm.com>
 <20261102-dup-sessions-v7-2-03f06c014e78@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 09:06:06 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] misc: fastrpc: session leak in fastrpc_rpmsg_probe() on race with =
open
--

commit 51e0d53d78d8245f1572af01da3a96d0f550fc6f
Author: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>

misc: fastrpc: move ADSP duplicate session creation to the driver

This commit removes the qcom,nsessions device tree property read and per-CB
session duplication from fastrpc_cb_init(), and instead appends
FASTRPC_DUP_SESSIONS copies of the last initialized session in
fastrpc_rpmsg_probe() for the ADSP domain.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 7441e9b8940d8..b4be0ee2bc181 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c

[ ... ]

> @@ -2369,16 +2372,6 @@ static int fastrpc_cb_init(struct platform_device =
*pdev)
>  	if (cctx->domain_id =3D=3D CDSP_DOMAIN_ID)
>  		dma_bits =3D cctx->soc_data->dma_addr_bits_cdsp;
> =20
> -	if (sessions > 0) {
> -		struct fastrpc_session_ctx *dup_sess;
> -
> -		for (i =3D 1; i < sessions; i++) {
> -			if (cctx->sesscount >=3D FASTRPC_MAX_SESSIONS)
> -				break;
> -			dup_sess =3D &cctx->session[cctx->sesscount++];
> -			memcpy(dup_sess, sess, sizeof(*dup_sess));
> -		}
> -	}
>  	spin_unlock_irqrestore(&cctx->lock, flags);
>  	rc =3D dma_set_mask(dev, DMA_BIT_MASK(dma_bits));
>  	if (rc) {
> @@ -2681,6 +2674,22 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device=
 *rpdev)
>  	if (err)
>  		goto err_deregister_fdev;
> =20
> +	if (data->domain_id =3D=3D ADSP_DOMAIN_ID && data->sesscount > 0) {
> +		struct fastrpc_session_ctx *last_sess;
> +		struct fastrpc_session_ctx *dup_sess;
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&data->lock, flags);
> +		last_sess =3D &data->session[data->sesscount - 1];
> +		for (i =3D 0; i < FASTRPC_DUP_SESSIONS; i++) {
> +			if (data->sesscount >=3D FASTRPC_MAX_SESSIONS)
> +				break;
> +			dup_sess =3D &data->session[data->sesscount++];
> +			memcpy(dup_sess, last_sess, sizeof(*dup_sess));
> +		}
> +		spin_unlock_irqrestore(&data->lock, flags);
> +	}

[Severity: High]
As reported by Sashiko on v2 [1], could a concurrent open() claim last_sess
between fastrpc_cb_init() dropping cctx->lock and fastrpc_rpmsg_probe()
duplicating the session, permanently leaking all 4 dup_sess entries?

In fastrpc_rpmsg_probe(), fastrpc_device_register() calls misc_register()
before fastrpc_cb_devices_create() and before the ADSP duplicate session
block:

drivers/misc/fastrpc.c:fastrpc_rpmsg_probe() {
	...
	switch (domain_id) {
	case ADSP_DOMAIN_ID:
		...
		err =3D fastrpc_device_register(rdev, data, secure_dsp, domain);
	...
	err =3D fastrpc_cb_devices_create(rpdev);
}

Previously, fastrpc_cb_init() duplicated the sessions inside the same
cctx->lock critical section that initialized sess->used =3D false. With this
change, fastrpc_cb_init() sets sess->valid =3D true, increments
cctx->sesscount, and drops cctx->lock before fastrpc_rpmsg_probe() re-acqui=
res
data->lock to copy last_sess.

If userspace daemons open the character device node during this window,
fastrpc_device_open() -> fastrpc_session_alloc() can claim last_sess and set
last_sess->used =3D true (or fail with -EBUSY if all raw CB sessions are
consumed before the duplicate sessions are appended):

drivers/misc/fastrpc.c:fastrpc_session_alloc() {
	...
	for (i =3D 0; i < cctx->sesscount; i++) {
		if (!cctx->session[i].used && cctx->session[i].valid) {
			cctx->session[i].used =3D true;
			session =3D &cctx->session[i];
			...
			break;
		}
	}
}

When fastrpc_rpmsg_probe() then runs memcpy(dup_sess, last_sess,
sizeof(*dup_sess)), used =3D true is copied into all 4 dup_sess slots witho=
ut
resetting dup_sess->used =3D false. Because no fastrpc_user instance owns t=
hose
duplicated slots, fastrpc_session_free() will never be called on them,
leaving all 4 extra ADSP sessions permanently unavailable. Also,
data->sesscount is checked outside data->lock before entering the block.

[1] https://lore.kernel.org/r/20260708041312.ACF681F000E9@smtp.kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-dup-sessio=
ns-v7-0-03f06c014e78@oss.qualcomm.com?part=3D2
