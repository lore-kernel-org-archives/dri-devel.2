Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B306C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 13:40:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD6B610ED08;
	Wed, 26 Aug 2026 13:40:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kfyoT95B";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A5E310ED08
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:40:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3067A6011F;
 Wed, 26 Aug 2026 13:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6781F000E9;
 Wed, 26 Aug 2026 13:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787751612;
 bh=CC5nzDgUGvHFkQptgc6g8oKeZh1fjk6guBTiyuavIqI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kfyoT95BmSWz84K+eTJeeUwMo6XFmCC95p+yn7cYNcq6ecsPVz1Ml5j2dz1H1t65L
 hrH6lai4kVhEEd/L4FQb+B8KPzvZLa1JZ9db0Ti5MmMe6JGxiHu5xPPtJmA9xh1MBB
 j7eH5xx6PEumkwfwu6uh0ZacHDa8DR9X2N9u7UwHl0EVqzLl3/C3Ay+6nXpCJxGlML
 Y8w9+sWvj8rh7HKFIXeZh4xd354kuJJD4wqS4m8EZ4A0ZGRgTO2vDYGUwYtIuF0W5w
 w8oSxSTkxjsthAkDHZOpGx8lfiu/DKdM17nhn1hJ72costKsqxPkzc9AeMyHmhuT5b
 t+aKdbYs/rr5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] misc: fastrpc: move ADSP duplicate session
 creation to the driver
To: "Vinayak Katoch" <vinayak.katoch@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260826-dup-sessions-v4-2-35555d2bfed4@oss.qualcomm.com>
References: <20260826-dup-sessions-v4-0-35555d2bfed4@oss.qualcomm.com>
 <20260826-dup-sessions-v4-2-35555d2bfed4@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 13:40:12 +0000
Message-Id: <20260826134012.8D6781F000E9@smtp.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Session duplication non-atomicity introduces a race window allowin=
g a permanent leak of duplicated sessions.

Pre-existing issues:
- [Critical] Premature character device registration allows unprivileged us=
erspace to free the channel context during probe, leading to a Use-After-Fr=
ee.
- [High] Dangling pointer in rdev->dma_mask after probe failure leads to us=
e-after-free.
- [High] Dangling pointer to child platform devices after fastrpc_rpmsg_rem=
ove leads to UAF during DMA allocations.
--

commit a8d47b7ddf0527e896eee27dcc31b42059209d4c
Author: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>

misc: fastrpc: move ADSP duplicate session creation to the driver

For ADSP, only a limited number of FastRPC context banks (CBs) are
available. Each CB supports a single session, which means only a few
processes can run on ADSP simultaneously. If all sessions are consumed
by fastrpc daemons, no session remains available when a user application
starts, causing the application to fail.

To work around this, qcom,nsessions =3D <5> was set in DT to duplicate
sessions inline during fastrpc_cb_init(). This policy does not belong
in DT and should be handled at the driver level instead.

Remove the qcom,nsessions DT property read and the per-CB duplication
logic from fastrpc_cb_init(). After all context banks have been
initialised in fastrpc_rpmsg_probe(), append FASTRPC_DUP_SESSIONS (4)
copies of the last session for the ADSP domain.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index a153107d00853..98a61b8b90131 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
[ ... ]
> @@ -2399,16 +2398,6 @@ static int fastrpc_cb_init(struct platform_device =
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

[Severity: High]
Does moving this duplication logic out of fastrpc_cb_init() introduce a
race window?

The lock is released here, but duplication now happens later in
fastrpc_rpmsg_probe(). In the meantime, userspace can open the device
and allocate this session, setting its used flag to true.

[Severity: High]
This isn't a bug introduced by this patch, but earlier in
fastrpc_cb_init(), a weak pointer to the child platform device is stored
in the session context without incrementing its reference count:

    sess->dev =3D dev;

During module unbind, fastrpc_rpmsg_remove() destroys these child
devices via of_platform_depopulate(). However, active userspace file
descriptors are not closed.

Could subsequent ioctls on an open fastrpc file descriptor pass this
dangling sess->dev pointer to dma_alloc_coherent(), causing a
use-after-free in the DMA API?

>  	rc =3D dma_set_mask(dev, DMA_BIT_MASK(dma_bits));
>  	if (rc) {
[ ... ]
> @@ -2629,6 +2618,22 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device=
 *rpdev)
>  			goto err_depopulate;
>  	}
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

[Severity: High]
If a racing userspace process has already allocated last_sess and set
its used flag to true, does this memcpy() blindly copy the used =3D true
state to the newly duplicated sessions?

Since these duplicated sessions are not attached to any open file
descriptor, it seems they will never be freed on close(), permanently
leaking ADSP sessions.

> +		}
> +		spin_unlock_irqrestore(&data->lock, flags);
> +	}
> +
>  	return 0;
> =20
>  err_depopulate:

[Severity: Critical]
This isn't a bug introduced by this patch, but earlier in
fastrpc_rpmsg_probe(), the character device is registered and exposed
to userspace before critical data structures are initialized:

    err =3D fastrpc_device_register(rdev, data, secure_dsp, domain);
    ...
    kref_init(&data->refcount);

If unprivileged userspace immediately opens the device before sessions
are added, fastrpc_device_open() fails to find a session and calls
fastrpc_channel_ctx_put().

Does this underflow the 0-initialized refcount and free the data struct
while fastrpc_rpmsg_probe() is still executing, leading to a
use-after-free?

[Severity: High]
This isn't a bug introduced by this patch, but earlier in
fastrpc_rpmsg_probe(), the device's DMA mask pointer is assigned to a
field inside the dynamically allocated data structure:

    rdev->dma_mask =3D &data->dma_mask;

If the probe subsequently fails, the err_free_data path frees data but
fails to clear rdev->dma_mask. Since the rpmsg_device outlives the
probe failure, could subsequent DMA operations or teardown checks by
the driver core dereference this dangling pointer and cause a
use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826-dup-sessio=
ns-v4-0-35555d2bfed4@oss.qualcomm.com?part=3D2
