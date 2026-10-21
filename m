Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4661E606A332
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 09:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZKa+QwrQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 954E310FD20;
	Wed, 21 Oct 2026 09:44:45 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EF7D10FD20
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 09:44:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4D48043672;
 Wed, 21 Oct 2026 09:44:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A4A1F000C9;
 Wed, 21 Oct 2026 09:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792575879;
 bh=K6J8Ow9mb1LVZZK/gpyIhb1PAxP0aYI9zlWavgJixbo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZKa+QwrQ240+gp046TR0ILq3qmKYip/k8ldNqiXZVNjPPabbo4Zu+weUcWCSkxUdt
 gRkfGOnLPNrTon9PsJMUCWslui1hI1wkRDlWxyqnpjNY7XdSnTaqloxz+3xIDj4R7O
 I7b7MG5K0YrDh0mBN5a+mv5AokNg9sU0vSsretAT3Ett1EPnR1nQQE2NUg9l7bzbqi
 AuD2zEJIq4yIDcSw1G4wcFMHMzGaJQIlsnLFeXikSZmz1l84DuDfo35srk4P3Ck3eg
 VYef3rpeQiq8KOjZI0KfBeWm/VCgntywaiWH8+SSyTnCQZMMOKiagS7/qpLlFr27Q4
 vxjyO7ICnPGmw==
Message-ID: <sashiko-outbox-180052@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/3] misc: fastrpc: move ADSP duplicate session
 creation to the driver
To: "Vinayak Katoch" <vinayak.katoch@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261021-dup-sessions-v6-2-578ab52ba66c@oss.qualcomm.com>
References: <20261021-dup-sessions-v6-0-578ab52ba66c@oss.qualcomm.com>
 <20261021-dup-sessions-v6-2-578ab52ba66c@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 09:44:38 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] misc: fastrpc: session leak in fastrpc_rpmsg_probe() on race with =
open
- [High] misc: fastrpc: double of_node_put() in fastrpc_cb_devices_create()
- [High] misc: fastrpc: use-after-free on fastrpc_cb_devices_create() failu=
re in probe
--

commit 810d79d90cb45359bb71f6c3439fb0921ee5af9c
Author: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>

misc: fastrpc: move ADSP duplicate session creation to the driver

This commit removes the qcom,nsessions device tree property read and per-ba=
nk
session duplication from fastrpc_cb_init(), and instead appends four copies=
 of
the last session in fastrpc_rpmsg_probe() for the adsp domain.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index caa479f304c1c..5dd1990d3e2a9 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
[ ... ]
> @@ -2368,16 +2371,6 @@ static int fastrpc_cb_init(struct platform_device =
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
> @@ -2656,6 +2649,22 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device=
 *rpdev)
>  	if (err)
>  		goto err_deregister_fdev;

[Severity: High]
Could calling of_node_put(np) before continue in fastrpc_cb_devices_create()
cause a double release of the device_node reference on np?

Right before this check in drivers/misc/fastrpc.c, fastrpc_rpmsg_probe() ca=
lls
fastrpc_cb_devices_create(rpdev) (introduced earlier in this series by comm=
it
"misc: fastrpc: iterate CB nodes manually instead of of_platform_populate"):

drivers/misc/fastrpc.c:fastrpc_cb_devices_create() {
	for_each_available_child_of_node(rdev->of_node, np) {
		if (!of_device_is_compatible(np, "qcom,fastrpc-compute-cb")) {
			of_node_put(np);
			continue;
		}
		...
}

In include/linux/of.h, for_each_available_child_of_node() advances the loop
with of_get_next_available_child(parent, child), which already drops the
reference on the previous child node:

#define for_each_available_child_of_node(parent, child) \
	for (child =3D of_get_next_available_child(parent, NULL); child !=3D NULL;=
 \
	     child =3D of_get_next_available_child(parent, child))

When an available child node under rdev->of_node is not compatible with
"qcom,fastrpc-compute-cb", calling of_node_put(np) before continue drops the
reference on np a first time, and the loop increment drops it a second time,
leading to a reference count underflow and potential use-after-free on np.

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
What prevents a race with fastrpc_device_open() from permanently leaking the
duplicated dup_sess entries in data->session[] here?

In drivers/misc/fastrpc.c, fastrpc_rpmsg_probe() registers the character
device via fastrpc_device_register() -> misc_register() before calling
fastrpc_cb_devices_create(rpdev):

drivers/misc/fastrpc.c:fastrpc_rpmsg_probe() {
	...
	case ADSP_DOMAIN_ID:
	case MDSP_DOMAIN_ID:
	case SDSP_DOMAIN_ID:
		data->unsigned_support =3D false;
		err =3D fastrpc_device_register(rdev, data, secure_dsp, domain);
		...
	err =3D fastrpc_cb_devices_create(rpdev);
}

Previously, fastrpc_cb_init() duplicated the sessions inside the same
cctx->lock critical section that initialized sess->used =3D false. With this
regression, fastrpc_cb_init() sets sess->used =3D false and sess->valid =3D=
 true,
increments cctx->sesscount, and drops cctx->lock before calling
dma_set_mask():

drivers/misc/fastrpc.c:fastrpc_cb_init() {
	...
	sess =3D &cctx->session[cctx->sesscount++];
	sess->used =3D false;
	sess->valid =3D true;
	sess->dev =3D dev;
	sess->sid =3D sid;

	if (cctx->domain_id =3D=3D CDSP_DOMAIN_ID)
		dma_bits =3D cctx->soc_data->dma_addr_bits_cdsp;

	spin_unlock_irqrestore(&cctx->lock, flags);
	rc =3D dma_set_mask(dev, DMA_BIT_MASK(dma_bits));
}

If userspace (such as fastrpc daemons triggered when misc_register() exposes
the device node) opens the device during this unlocked window,
fastrpc_device_open() -> fastrpc_session_alloc() can allocate up to last_se=
ss
and set last_sess->used =3D true:

drivers/misc/fastrpc.c:fastrpc_session_alloc() {
	...
	for (i =3D 0; i < cctx->sesscount; i++) {
		if (!cctx->session[i].used && cctx->session[i].valid) {
			cctx->session[i].used =3D true;
			session =3D &cctx->session[i];
			fl->client_id =3D i + 1;
			break;
		}
	}
}

When fastrpc_rpmsg_probe() then checks data->sesscount > 0 (outside
data->lock), acquires data->lock, and copies last_sess into each dup_sess v=
ia
memcpy(dup_sess, last_sess, sizeof(*dup_sess)), used =3D true is copied int=
o all
four dup_sess slots without resetting dup_sess->used =3D false.

Because no fastrpc_user instance owns those dup_sess pointers,
fastrpc_session_free() is never called on them, leaving all four duplicated
sessions permanently marked used =3D true and unallocatable.

> +
>  	return 0;
> =20
>  err_deregister_fdev:

[Severity: High]
If fastrpc_cb_devices_create() fails after a session has been marked valid,
can kfree(data) in the err_deregister_fdev path cause a use-after-free on
data and the destroyed child platform devices?

Premature registration of the miscdevice prior to child population and
kfree(data) on the error path existed prior to this commit, and commit
9b30a7a26899 ("misc: fastrpc: iterate CB nodes manually instead of
of_platform_populate") in this series replaced of_platform_populate() with
fastrpc_cb_devices_create() while this patch modifies fastrpc_cb_init() and
fastrpc_rpmsg_probe().

During fastrpc_rpmsg_probe() -> fastrpc_cb_devices_create() ->
fastrpc_cb_init() in drivers/misc/fastrpc.c, once the first context bank se=
ts
sess->valid =3D true and drops cctx->lock, a concurrent open() on the regis=
tered
miscdevice can succeed in fastrpc_device_open():

drivers/misc/fastrpc.c:fastrpc_device_open() {
	...
	/* Released in fastrpc_device_release() */
	fastrpc_channel_ctx_get(cctx);
	...
	fl->sctx =3D fastrpc_session_alloc(fl);
	...
	spin_lock_irqsave(&cctx->lock, flags);
	list_add_tail(&fl->user, &cctx->users);
	spin_unlock_irqrestore(&cctx->lock, flags);
}

If dma_set_mask() then fails in fastrpc_cb_init(), or a subsequent child no=
de
fails in of_platform_device_create() or fastrpc_cb_init(),
fastrpc_cb_devices_create() destroys the child platform devices via
fastrpc_cb_devices_destroy(rpdev) and returns an error:

drivers/misc/fastrpc.c:fastrpc_cb_devices_create() {
	...
		err =3D fastrpc_cb_init(pdev);
		if (err) {
			of_node_put(np);
			fastrpc_cb_devices_destroy(rpdev);
			return err;
		}
}

fastrpc_rpmsg_probe() then jumps to err_deregister_fdev, calls
misc_deregister() (which does not close existing open file descriptors), and
unconditionally frees data with kfree(data) instead of releasing the initial
reference via fastrpc_channel_ctx_put(data):

drivers/misc/fastrpc.c:fastrpc_rpmsg_probe() {
	...
err_deregister_fdev:
	if (data->fdevice)
		misc_deregister(&data->fdevice->miscdev);
	if (data->secure_fdevice)
		misc_deregister(&data->secure_fdevice->miscdev);

err_free_data:
	kfree(data);
	return err;
}

When the open file descriptor later performs an ioctl or closes the file in
fastrpc_device_release() -> fastrpc_user_put(), it dereferences the freed
cctx (data) to lock cctx->lock, remove fl->user from cctx->users, clear
fl->sctx->used, and call fastrpc_channel_ctx_put(fl->cctx).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021-dup-sessio=
ns-v6-0-578ab52ba66c@oss.qualcomm.com?part=3D2
