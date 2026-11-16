Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7949E60A381B
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iXcoWeHX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C334310F1E4;
	Mon, 16 Nov 2026 13:51:10 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C534B10F1E4
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:51:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7830F46481;
 Mon, 16 Nov 2026 13:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4015A1F000CD;
 Mon, 16 Nov 2026 13:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794837064;
 bh=6sDJIk+V4j+eQsW2coNqt+eR3Hj9ubiMUeYnaj+QQzw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iXcoWeHXY+Qdv1EeCq8CUs+h6B5OynluvER1mqBTseGW6vvNsNuiZ79f9FtQUQ3Er
 ImP2+ZcWoUMvWhpKYkTANOIXcHGdZuoPFDDnNquve7QmZa0F+0eWPLakFteUB8DB5p
 WcLiLG1LXHlsw9htg3qP/aeBh1LwLWEkczlnbnYL/+2JWxel3BLyKgwb+tUlaT8Gi1
 raoKjj2JoBUf8f9FfUE5nOK651XqG2LlBUNT7eBljn9HfAKFO7sO1RJpv3S48B5uvb
 q7Swpviwtp4MqYDgJwef5yvd7lCE5RYhm/8qd5GZaDl8DD7LnbpNwvESy9N3wsJdQz
 UxQudqF61jE1Q==
Message-ID: <sashiko-outbox-217114@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] misc: fastrpc: fix init ordering race in rpmsg
 probe
To: "Vinayak Katoch" <vinayak.katoch@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261116-fastrpc-probe-fixes-v3-2-3cd56d9d9a93@oss.qualcomm.com>
References: <20261116-fastrpc-probe-fixes-v3-0-3cd56d9d9a93@oss.qualcomm.com>
 <20261116-fastrpc-probe-fixes-v3-2-3cd56d9d9a93@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 13:51:03 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] misc: fastrpc: dangling drvdata and dma_mask on
  fastrpc_rpmsg_probe() error
- [Low] misc: fastrpc: inaccurate Fixes trailer in fastrpc_rpmsg_probe()
  commit
--

commit 4a1cfc3ddafb9d12682d2f0bc78e07af7648cf89
Author: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>

> misc: fastrpc: fix init ordering race in rpmsg probe
>=20
> fastrpc_device_register() calls misc_register() which makes the device
> node visible to userspace. However, kref_init(), spin_lock_init(),
> INIT_LIST_HEAD(), dev_set_drvdata() and of_platform_populate()
> were all called after the switch/misc_register block, leaving a window
> where userspace can open the device and call fastrpc_device_open() on
> a partially initialised channel context.
>=20
> On a concurrent open(), fastrpc_channel_ctx_get() calls kref_get() on
> a kzalloc-zeroed, never kref_init()'d refcount of 0, triggering:
>=20
>   refcount_t: addition on 0; use-after-free.
>   Call trace:
>    refcount_warn_saturate+0x120/0x148 (P)
>    fastrpc_device_open+0x204/0x258 [fastrpc]
>    misc_open+0xd8/0x1a0
>=20
> Additionally, of_platform_populate() not having run means
> sesscount is still 0, so fastrpc_session_alloc() returns NULL and
> fastrpc_device_open() hits the error path which calls
> fastrpc_channel_ctx_put() on the already-bogus refcount. This
> triggers the free callback, kfree()-ing the channel context. A
> subsequent IRQ-path fastrpc_rpmsg_callback() then dereferences the
> freed spinlock:
>=20
>   Unable to handle kernel paging request at virtual address ffffcd5841510=
ca0
>   Internal error: Oops: 0000000096000047 [#1] SMP
>   Call trace:
>    queued_spin_lock_slowpath+0x414/0x5e0 (P)
>    _raw_spin_lock_irqsave+0x74/0x90
>    fastrpc_rpmsg_callback+0x4c/0xf0 [fastrpc]
>    qcom_glink_native_rx+0x6c4/0xf10
>    qcom_glink_smem_intr+0x1c/0x38 [qcom_glink_smem]
>   Kernel panic - not syncing: Oops: Fatal exception in interrupt
>=20
> Fix by moving all channel context initialisation (kref_init,
> spin_lock_init, INIT_LIST_HEAD, idr_init, dev_set_drvdata) and
> of_platform_populate() before fastrpc_device_register(), ensuring
> the struct is fully ready before the device node is visible to
> userspace.
>=20
> Add err_depopulate label in the error path since
> of_platform_populate() now runs before misc_register(); a
> fastrpc_device_register() failure must call of_platform_depopulate()
> to clean up the compute-cb children.
>=20
> On CDSP/GDSP the secure node is registered before the non-secure one, so
> an application may already have opened the first node and hold a channel
> context reference when the second registration fails. Freeing the
> context with kfree() there would leave that user with a dangling
> pointer. Handle it like fastrpc_rpmsg_remove(): after the nodes are
> deregistered, clear rpdev, wake pending invocations with -EPIPE and drop
> only the probe reference with fastrpc_channel_ctx_put(), so the last
> holder frees the context. Move fastrpc_notify_users() above probe so it
> can be used there.
>=20
> Fixes: 965602eabb57 ("misc: fastrpc: separate fastrpc device from channel=
 context")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>

[Severity: Low]
Is 965602eabb57 ("misc: fastrpc: separate fastrpc device from channel
context") the right commit for the Fixes tag?

That commit only factored misc_register() into fastrpc_device_register() at
the same position in fastrpc_rpmsg_probe().  Calling misc_register() before
spin_lock_init(), INIT_LIST_HEAD(), idr_init() and of_platform_populate()
dates back to f6f9279f2bf0 ("misc: fastrpc: Add Qualcomm fastrpc basic
driver model"), and the kref_init() ordering issue was introduced in
278d56f970ae ("misc: fastrpc: Reference count channel context").

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index da0b2333a3ca3..0bbc1e00001ca 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
[ ... ]
> @@ -2599,6 +2613,23 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device=
 *rpdev)
>  	data->poll_mode_supported =3D soc_data->poll_mode_supported ||
>  		of_machine_get_match(fastrpc_poll_supported_machines);
> =20
> +	kref_init(&data->refcount);
> +	atomic_set(&data->ctx_seq, 0);
> +
> +	rdev->dma_mask =3D &data->dma_mask;
> +	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
> +	INIT_LIST_HEAD(&data->users);
> +	INIT_LIST_HEAD(&data->invoke_interrupted_mmaps);
> +	spin_lock_init(&data->lock);
> +	idr_init(&data->ctx_idr);
> +	data->domain_id =3D domain_id;
> +	data->rpdev =3D rpdev;
> +	dev_set_drvdata(&rpdev->dev, data);
> +
> +	err =3D of_platform_populate(rdev->of_node, NULL, NULL, rdev);
> +	if (err)
> +		goto err_free_data;
> +
>  	switch (domain_id) {
>  	case ADSP_DOMAIN_ID:
>  	case MDSP_DOMAIN_ID:
> @@ -2607,7 +2638,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device =
*rpdev)
>  		data->unsigned_support =3D false;
>  		err =3D fastrpc_device_register(rdev, data, secure_dsp, domain);
>  		if (err)
> -			goto err_free_data;
> +			goto err_depopulate;
>  		break;
>  	case CDSP_DOMAIN_ID:
>  	case GDSP_DOMAIN_ID:
> @@ -2615,7 +2646,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device =
*rpdev)
>  		/* Create both device nodes so that we can allow both Signed and Unsig=
ned PD */
>  		err =3D fastrpc_device_register(rdev, data, true, domain);
>  		if (err)
> -			goto err_free_data;
> +			goto err_depopulate;
> =20
>  		err =3D fastrpc_device_register(rdev, data, false, domain);
>  		if (err)
> @@ -2623,26 +2654,9 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device=
 *rpdev)
>  		break;
>  	default:
>  		err =3D -EINVAL;
> -		goto err_free_data;
> +		goto err_depopulate;
>  	}
> =20
> -	kref_init(&data->refcount);
> -	atomic_set(&data->ctx_seq, 0);
> -
> -	rdev->dma_mask =3D &data->dma_mask;
> -	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
> -	INIT_LIST_HEAD(&data->users);
> -	INIT_LIST_HEAD(&data->invoke_interrupted_mmaps);
> -	spin_lock_init(&data->lock);
> -	idr_init(&data->ctx_idr);
> -	data->domain_id =3D domain_id;
> -	data->rpdev =3D rpdev;
> -	dev_set_drvdata(&rpdev->dev, data);
> -
> -	err =3D of_platform_populate(rdev->of_node, NULL, NULL, rdev);
> -	if (err)
> -		goto err_deregister_fdev;
> -
>  	return 0;
> =20
>  err_deregister_fdev:
> @@ -2651,23 +2665,27 @@ static int fastrpc_rpmsg_probe(struct rpmsg_devic=
e *rpdev)
>  	if (data->secure_fdevice)
>  		misc_deregister(&data->secure_fdevice->miscdev);
> =20
> +err_depopulate:
> +	/*
> +	 * A registered device node may already have been opened, so a user
> +	 * can hold a cctx reference. Drop only our reference instead of
> +	 * freeing the context directly.
> +	 */
> +	spin_lock_irqsave(&data->lock, flags);
> +	data->rpdev =3D NULL;
> +	list_for_each_entry(user, &data->users, user)
> +		fastrpc_notify_users(user);
> +	spin_unlock_irqrestore(&data->lock, flags);
> +
> +	of_platform_depopulate(rdev);
> +	fastrpc_channel_ctx_put(data);
> +	return err;
> +
>  err_free_data:
>  	kfree(data);
>  	return err;
>  }

[Severity: High]
Does moving dev_set_drvdata() and rdev->dma_mask =3D &data->dma_mask earlier
leave dangling pointers on rpdev->dev when of_platform_populate() or
fastrpc_device_register() fails?

rpmsg_dev_probe() creates rpdev->ept with fastrpc_rpmsg_callback() before
calling fastrpc_rpmsg_probe(), and only destroys the endpoint after probe
returns:

CPU0                                  CPU1 (<hardirq>)
rpmsg_dev_probe()
  rpmsg_create_ept()
  fastrpc_rpmsg_probe()
    dev_set_drvdata(&rpdev->dev, data)
    of_platform_populate() -> fails
    kfree(data)
                                      fastrpc_rpmsg_callback()
                                        cctx =3D dev_get_drvdata(&rpdev->de=
v)
                                        spin_lock_irqsave(&cctx->lock, ...)
                                          <-- use-after-free
  rpmsg_destroy_ept()

Because fastrpc_rpmsg_callback() only checks whether cctx is NULL, any
incoming rpmsg interrupt before rpmsg_destroy_ept() finishes will
dereference freed data at &cctx->lock and &cctx->ctx_idr.  In addition,
device_unbind_cleanup() does not reset rdev->dma_mask, leaving it pointing
into the freed struct fastrpc_channel_ctx.

Clearing drvdata with dev_set_drvdata(&rpdev->dev, NULL) and resetting
rdev->dma_mask =3D NULL before releasing data in the error paths (or setting
drvdata only after fastrpc_device_register() succeeds) would avoid this
regression.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-fastrpc-pr=
obe-fixes-v3-0-3cd56d9d9a93@oss.qualcomm.com?part=3D2
