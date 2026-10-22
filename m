Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D017B606A323
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 09:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aUxOJBde
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B5A8112423;
	Thu, 22 Oct 2026 09:29:09 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C1451123AE
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:29:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C6E4460211;
 Thu, 22 Oct 2026 09:29:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2F61F000C1;
 Thu, 22 Oct 2026 09:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792661341;
 bh=kf/tVn41aQnC//tdWisCyNaSLmTOMbhRKHzhwCJ27Tg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aUxOJBde9mvWwTNxG9NJNpZp6JCzHdUTY7Mj488NBEAXpgP/Qq4GOHDf+b3vyl7os
 iq8qXY044edvclHZycASQn8o/j24QvD+Fxhy+2Iu0J8fRaNfok2khlg7ZdHT3CL449
 ja+DDl5tNdZkMe43SxnenzWfbqCbuWa2kR1x+ekZxa8OHuAlx6NBMz+86OBGBUZqLw
 wjo/rwiz0bvZr6vP4EWeuRQy3tke1jn/dNh9OFdWLNKtLlyMiZz1IQLDYisfuzk514
 Fdcw9qj4sEIWp8pomzPNzn+9FhSYFLARCHX4JmorEFbeRUsHDSVU/XxynSVNTDyq17
 fQ//O7oPifNHg==
Message-ID: <sashiko-outbox-181262@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] misc: fastrpc: fix init ordering race in rpmsg
 probe
To: "Vinayak Katoch" <vinayak.katoch@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261022-fastrpc-probe-fixes-v2-2-a6b3f6f62571@oss.qualcomm.com>
References: <20261022-fastrpc-probe-fixes-v2-0-a6b3f6f62571@oss.qualcomm.com>
 <20261022-fastrpc-probe-fixes-v2-2-a6b3f6f62571@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 09:29:01 +0000
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
- [High] misc: fastrpc: race on ADSP duplicate sessions in fastrpc_rpmsg_pr=
obe()
- [High] misc: fastrpc: dangling drvdata on error paths in fastrpc_rpmsg_pr=
obe()
--

commit ea9ec3521b0228bbc7931e61d1e5ec984d8cfeaf
Author: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>

misc: fastrpc: fix init ordering race in rpmsg probe

This patch moves channel context initialization and
fastrpc_cb_devices_create() ahead of fastrpc_device_register() in
fastrpc_rpmsg_probe() so the context is initialized before device nodes are
exposed to userspace. It also updates the probe error path to clean up
compute-cb devices and drop the channel context reference.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index f280bff2edf05..fc09cd27af4b8 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c

[ ... ]

> @@ -2605,6 +2619,23 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device=
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
> +	err =3D fastrpc_cb_devices_create(rpdev);
> +	if (err)
> +		goto err_free_data;
> +
>  	switch (domain_id) {
>  	case ADSP_DOMAIN_ID:
>  	case MDSP_DOMAIN_ID:
> @@ -2613,7 +2644,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device =
*rpdev)
>  		data->unsigned_support =3D false;
>  		err =3D fastrpc_device_register(rdev, data, secure_dsp, domain);
>  		if (err)
> -			goto err_free_data;
> +			goto err_depopulate;
>  		break;
>  	case CDSP_DOMAIN_ID:
>  	case GDSP_DOMAIN_ID:
> @@ -2621,7 +2652,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device =
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
> @@ -2629,30 +2660,12 @@ static int fastrpc_rpmsg_probe(struct rpmsg_devic=
e *rpdev)
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
> -	err =3D fastrpc_cb_devices_create(rpdev);
> -	if (err)
> -		goto err_deregister_fdev;
> -
>  	if (data->domain_id =3D=3D ADSP_DOMAIN_ID && data->sesscount > 0) {
>  		struct fastrpc_session_ctx *last_sess;
>  		struct fastrpc_session_ctx *dup_sess;
> -		unsigned long flags;
> =20
>  		spin_lock_irqsave(&data->lock, flags);
>  		last_sess =3D &data->session[data->sesscount - 1];

[Severity: High]
Since fastrpc_cb_devices_create() now populates data->session[] before
fastrpc_device_register() exposes the ADSP device node via misc_register(),
can userspace open the device before this ADSP session duplication block
runs?

If a concurrent fastrpc_device_open() -> fastrpc_session_alloc() runs in
that window, it marks the last CB session in-use:

drivers/misc/fastrpc.c:fastrpc_session_alloc() {
	spin_lock_irqsave(&cctx->lock, flags);
	for (i =3D 0; i < cctx->sesscount; i++) {
		if (!cctx->session[i].used && cctx->session[i].valid) {
			cctx->session[i].used =3D true;
			session =3D &cctx->session[i];
			...
			break;
		}
	}
	spin_unlock_irqrestore(&cctx->lock, flags);
}

When fastrpc_rpmsg_probe() then copies last_sess into the
FASTRPC_DUP_SESSIONS slots with memcpy(dup_sess, last_sess,
sizeof(*dup_sess)), dup_sess->used =3D true is copied into all 4 duplicate
session entries. Because no fastrpc_user owns those duplicated entries,
fastrpc_session_free() will only clear last_sess->used, leaving the 4
duplicated ADSP sessions permanently marked used =3D true and unavailable f=
or
the lifetime of the channel.

Should the ADSP session duplication block also be moved before
fastrpc_device_register()?

> @@ -2673,23 +2686,27 @@ static int fastrpc_rpmsg_probe(struct rpmsg_devic=
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
> +	fastrpc_cb_devices_destroy(rpdev);
> +	fastrpc_channel_ctx_put(data);
> +	return err;
> +
>  err_free_data:
>  	kfree(data);
>  	return err;
>  }

[Severity: High]
In rpmsg_dev_probe(), the endpoint is created with fastrpc_rpmsg_callback()
before fastrpc_rpmsg_probe() is called, and is only destroyed after
fastrpc_rpmsg_probe() returns:

drivers/rpmsg/rpmsg_core.c:rpmsg_dev_probe() {
	...
	ept =3D rpmsg_create_ept(rpdev, rpdrv->callback, NULL, chinfo);
	...
	err =3D rpdrv->probe(rpdev);
	if (err) {
		dev_err(dev, "%s: failed: %d\n", __func__, err);
		goto destroy_ept;
	}
}

With dev_set_drvdata(&rpdev->dev, data) and rdev->dma_mask =3D &data->dma_m=
ask
moved ahead of fastrpc_cb_devices_create() and fastrpc_device_register(),
both err_depopulate and err_free_data can free data while rpdev->dev
driver_data and rdev->dma_mask still point to it.

If an incoming glink interrupt runs fastrpc_rpmsg_callback() before
rpmsg_dev_probe() destroys the endpoint, won't dev_get_drvdata(&rpdev->dev)
return the freed data pointer, bypass the !cctx check, and dereference
&cctx->lock and &cctx->ctx_idr after free? Also, in the err_free_data path,
should idr_destroy(&data->ctx_idr) be called before kfree(data)?

>[ ... ]
=E5=9C=A8=E8=BF=9B=E8=A1=8C=E6=9C=80=E7=BB=88=E8=BE=93=E5=87=BA=E5=89=8D=EF=
=BC=8C=E6=A3=80=E6=9F=A5=E7=BB=93=E5=B0=BE=E7=A9=BA=E8=A1=8C=E3=80=82

Let's remove the trailing `[ ... ]` and commentary note from the output. Ev=
erything is clean and ready. End of thought.commit ea9ec3521b0228bbc7931e61=
d1e5ec984d8cfeaf
Author: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>

misc: fastrpc: fix init ordering race in rpmsg probe

This patch moves channel context initialization and
fastrpc_cb_devices_create() ahead of fastrpc_device_register() in
fastrpc_rpmsg_probe() so the context is initialized before device nodes are
exposed to userspace. It also updates the probe error path to clean up
compute-cb devices and drop the channel context reference.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index f280bff2edf05..fc09cd27af4b8 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c

[ ... ]

> @@ -2605,6 +2619,23 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device=
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
> +	err =3D fastrpc_cb_devices_create(rpdev);
> +	if (err)
> +		goto err_free_data;
> +
>  	switch (domain_id) {
>  	case ADSP_DOMAIN_ID:
>  	case MDSP_DOMAIN_ID:
> @@ -2613,7 +2644,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device =
*rpdev)
>  		data->unsigned_support =3D false;
>  		err =3D fastrpc_device_register(rdev, data, secure_dsp, domain);
>  		if (err)
> -			goto err_free_data;
> +			goto err_depopulate;
>  		break;
>  	case CDSP_DOMAIN_ID:
>  	case GDSP_DOMAIN_ID:
> @@ -2621,7 +2652,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device =
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
> @@ -2629,30 +2660,12 @@ static int fastrpc_rpmsg_probe(struct rpmsg_devic=
e *rpdev)
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
> -	err =3D fastrpc_cb_devices_create(rpdev);
> -	if (err)
> -		goto err_deregister_fdev;
> -
>  	if (data->domain_id =3D=3D ADSP_DOMAIN_ID && data->sesscount > 0) {
>  		struct fastrpc_session_ctx *last_sess;
>  		struct fastrpc_session_ctx *dup_sess;
> -		unsigned long flags;
> =20
>  		spin_lock_irqsave(&data->lock, flags);
>  		last_sess =3D &data->session[data->sesscount - 1];

[Severity: High]
Since fastrpc_cb_devices_create() now populates data->session[] before
fastrpc_device_register() exposes the ADSP device node via misc_register(),
can userspace open the device before this ADSP session duplication block
runs?

If a concurrent fastrpc_device_open() -> fastrpc_session_alloc() runs in
that window, it marks the last CB session in-use:

drivers/misc/fastrpc.c:fastrpc_session_alloc() {
	spin_lock_irqsave(&cctx->lock, flags);
	for (i =3D 0; i < cctx->sesscount; i++) {
		if (!cctx->session[i].used && cctx->session[i].valid) {
			cctx->session[i].used =3D true;
			session =3D &cctx->session[i];
			...
			break;
		}
	}
	spin_unlock_irqrestore(&cctx->lock, flags);
}

When fastrpc_rpmsg_probe() then copies last_sess into the
FASTRPC_DUP_SESSIONS slots with memcpy(dup_sess, last_sess,
sizeof(*dup_sess)), dup_sess->used =3D true is copied into all 4 duplicate
session entries. Because no fastrpc_user owns those duplicated entries,
fastrpc_session_free() will only clear last_sess->used, leaving the 4
duplicated ADSP sessions permanently marked used =3D true and unavailable f=
or
the lifetime of the channel.

Should the ADSP session duplication block also be moved before
fastrpc_device_register()?

> @@ -2673,23 +2686,27 @@ static int fastrpc_rpmsg_probe(struct rpmsg_devic=
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
> +	fastrpc_cb_devices_destroy(rpdev);
> +	fastrpc_channel_ctx_put(data);
> +	return err;
> +
>  err_free_data:
>  	kfree(data);
>  	return err;
>  }

[Severity: High]
In rpmsg_dev_probe(), the endpoint is created with fastrpc_rpmsg_callback()
before fastrpc_rpmsg_probe() is called, and is only destroyed after
fastrpc_rpmsg_probe() returns:

drivers/rpmsg/rpmsg_core.c:rpmsg_dev_probe() {
	...
	ept =3D rpmsg_create_ept(rpdev, rpdrv->callback, NULL, chinfo);
	...
	err =3D rpdrv->probe(rpdev);
	if (err) {
		dev_err(dev, "%s: failed: %d\n", __func__, err);
		goto destroy_ept;
	}
}

With dev_set_drvdata(&rpdev->dev, data) and rdev->dma_mask =3D &data->dma_m=
ask
moved ahead of fastrpc_cb_devices_create() and fastrpc_device_register(),
both err_depopulate and err_free_data can free data while rpdev->dev
driver_data and rdev->dma_mask still point to it.

If an incoming glink interrupt runs fastrpc_rpmsg_callback() before
rpmsg_dev_probe() destroys the endpoint, won't dev_get_drvdata(&rpdev->dev)
return the freed data pointer, bypass the !cctx check, and dereference
&cctx->lock and &cctx->ctx_idr after free? Also, in the err_free_data path,
should idr_destroy(&data->ctx_idr) be called before kfree(data)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-fastrpc-pr=
obe-fixes-v2-0-a6b3f6f62571@oss.qualcomm.com?part=3D2
