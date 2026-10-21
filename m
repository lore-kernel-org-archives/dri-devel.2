Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FEE606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 09:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cpyKqUiF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A73B210FCFC;
	Wed, 21 Oct 2026 09:41:27 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66E8510FCFC
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 09:41:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 269CF432F4;
 Wed, 21 Oct 2026 09:41:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E5D1F000CA;
 Wed, 21 Oct 2026 09:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792575681;
 bh=lvh33Io0e59QJykAk+ZDON2/tBDNFPgKqlyPlaccaqo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cpyKqUiF2uI/KGBKOJk66uXuHBq9YnYUf76uCxT4iFPyvERHFbOjB59cNn1ONy0Dk
 HqrG14EknAO4BSx6+4URX2kIg+RRDGrOG43BmHbdI9m6Y77oIoRHYLdlpvMAv9ZZiz
 JhCqGV11RcU+PhNmjG0uiu44JMYAnb16oXBrMpRzRB10aVC16oqSj8WLu6HuFi1+fC
 N+l/qvegUA/OCtjOWMcDbu+J2PkJZlnQHFinVNAoOwMJwiRIaJxWH0GTszOM84e8Ii
 goUMcADseyrnY3xNQdsCyTKAakc5gzhstK8rBy50eMDv36kiBVcgYiJOE1Fy0gK4+x
 DcEyOxoNnvW3A==
Message-ID: <sashiko-outbox-180046@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/3] dt-bindings: misc: qcom,fastrpc: deprecate
 qcom,nsessions
To: "Vinayak Katoch" <vinayak.katoch@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261021-dup-sessions-v6-3-578ab52ba66c@oss.qualcomm.com>
References: <20261021-dup-sessions-v6-0-578ab52ba66c@oss.qualcomm.com>
 <20261021-dup-sessions-v6-3-578ab52ba66c@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 09:41:19 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] misc: fastrpc: double of_node_put() on continue in fastrpc_cb_devi=
ces_create()
- [Medium] misc: fastrpc: session leak in fastrpc_rpmsg_probe() when duplic=
ating active session
--

commit 9b30a7a26899dd48c168049c0e649bd641947cdc
Author: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>

misc: fastrpc: iterate CB nodes manually instead of of_platform_populate

This patch series (through commit c3dc726c9e7a, "dt-bindings: misc:
qcom,fastrpc: deprecate qcom,nsessions") replaces of_platform_populate()
with manual iteration of context bank child DT nodes in
fastrpc_cb_devices_create() so that context banks are initialized
synchronously during fastrpc_rpmsg_probe().

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index af18ff1992eed..caa479f304c1c 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c

[ ... ]

> @@ -2389,37 +2388,51 @@ static int fastrpc_cb_probe(struct platform_devic=
e *pdev)
>  	return 0;
>  }

[ ... ]

> +static int fastrpc_cb_devices_create(struct rpmsg_device *rpdev)
> +{
> +	struct device *rdev =3D &rpdev->dev;
> +	struct platform_device *pdev;
> +	struct device_node *np;
> +	int err;
> +
> +	for_each_available_child_of_node(rdev->of_node, np) {
> +		if (!of_device_is_compatible(np, "qcom,fastrpc-compute-cb")) {
> +			of_node_put(np);
> +			continue;
> +		}

[Severity: High]
Doesn't calling of_node_put(np) before continue in
fastrpc_cb_devices_create() drop the reference on np twice when an
available child node of rdev->of_node does not match
"qcom,fastrpc-compute-cb"?

In include/linux/of.h, for_each_available_child_of_node() advances to the
next node on each loop iteration by passing the current child node as prev
to of_get_next_available_child():

    #define for_each_available_child_of_node(parent, child) \
        for (child =3D of_get_next_available_child(parent, NULL); child !=
=3D NULL; \
             child =3D of_get_next_available_child(parent, child))

And in drivers/of/base.c, of_get_next_available_child() delegates to
of_get_next_status_child(), which already releases the reference on prev:

    for (; next; next =3D next->sibling) {
        if (!checker(next))
            continue;
        if (of_node_get(next))
            break;
    }
    of_node_put(prev);

When fastrpc_rpmsg_probe() -> fastrpc_cb_devices_create() encounters a
non-matching available child node, the explicit of_node_put(np) followed by
continue causes a reference count underflow on struct device_node and a
potential use-after-free. Should the explicit of_node_put(np) before
continue be removed (while keeping the of_node_put(np) calls on the early
return error paths)?

[ ... ]

commit 810d79d90cb45359bb71f6c3439fb0921ee5af9c
Author: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>

misc: fastrpc: move ADSP duplicate session creation to the driver

This commit removes the qcom,nsessions property handling from
fastrpc_cb_init() and instead duplicates the last initialized session
FASTRPC_DUP_SESSIONS times in fastrpc_rpmsg_probe() for the ADSP domain.

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
> +
>  	return 0;

[Severity: Medium]
Can moving the session duplication out of fastrpc_cb_init() and into a
separate lock critical section in fastrpc_rpmsg_probe() leak the duplicated
dup_sess entries if userspace opens the device concurrently during probe?

In fastrpc_rpmsg_probe(), fastrpc_device_register() registers the miscdevice
before fastrpc_cb_devices_create() and the ADSP session duplication block
run. Previously, session duplication happened inside fastrpc_cb_probe()
under the same cctx->lock acquisition that initialized sess->used =3D false.

Now, fastrpc_cb_init() initializes the session and drops cctx->lock:

    sess =3D &cctx->session[cctx->sesscount++];
    sess->used =3D false;
    sess->valid =3D true;
    sess->dev =3D dev;
    sess->sid =3D sid;

    if (cctx->domain_id =3D=3D CDSP_DOMAIN_ID)
        dma_bits =3D cctx->soc_data->dma_addr_bits_cdsp;

    spin_unlock_irqrestore(&cctx->lock, flags);

Because the /dev/fastrpc-adsp miscdevice is already live, a concurrent open
from userspace (such as udev or a fastrpc daemon) calling
fastrpc_device_open() -> fastrpc_session_alloc() can allocate the last
session and set last_sess->used =3D true before fastrpc_rpmsg_probe()
acquires data->lock:

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

When fastrpc_rpmsg_probe() then copies last_sess via memcpy(dup_sess,
last_sess, sizeof(*dup_sess)) without resetting dup_sess->used =3D false, a=
ll
FASTRPC_DUP_SESSIONS duplicated entries are created with used =3D true and =
no
owning fastrpc_user to release them, permanently exhausting those sessions
for the lifetime of the channel context and causing later allocations in
fastrpc_session_alloc() to fail with -EBUSY.

Should dup_sess->used =3D false be set explicitly after the memcpy(), or
should fastrpc_device_register() be called after all sessions and context
banks are initialized?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021-dup-sessio=
ns-v6-0-578ab52ba66c@oss.qualcomm.com?part=3D3
