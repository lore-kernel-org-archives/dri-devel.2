Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5211E606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 10:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=atNk28Vp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B737410FD26;
	Wed, 21 Oct 2026 10:18:10 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F42210E24F
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 10:18:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 369E94108D;
 Wed, 21 Oct 2026 10:18:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEEF91F000C9;
 Wed, 21 Oct 2026 10:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792577884;
 bh=lEHu7P5W44eP8/G405tAAYc9hCyoqi0OrwXbksDGnNA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=atNk28VpougGIR0pNP3ZAqP6I7E0SqzDMrF90c6sKikDmUIA5vkl1JMFqNaTB9RES
 MDq/nZH7aRp/gvsl6aciq64Y2B/foIhLV4FKgPGC7PS498RCV4A0SHlEoqEUv93YQx
 dQdK844qj4pYwzOujdN3IuP4yj9ohjNzqZtzIdz44GTI8Je8VJaOHFKcOyChQ0JA0D
 AOrQUY0vf81W29cqLX2MpvcBAOv1IOcX6C+XtUOsuDSj8h6hGbVn0zrn0kLkdcHFRM
 hIOMI1tm5ufLq4ZiAyuMbNp+NywMtzR66l0wHnepVfR01dGbz8QyQd0aEDWLhjt3qU
 MaPFbdy/pPbJg==
Message-ID: <sashiko-outbox-180091@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/3] misc: fastrpc: iterate CB nodes manually instead
 of of_platform_populate
To: "Vinayak Katoch" <vinayak.katoch@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261021-dup-sessions-v6-1-578ab52ba66c@oss.qualcomm.com>
References: <20261021-dup-sessions-v6-0-578ab52ba66c@oss.qualcomm.com>
 <20261021-dup-sessions-v6-1-578ab52ba66c@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 10:18:03 +0000
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
- [High] misc: fastrpc: double of_node_put() in fastrpc_cb_devices_create()
- [High] misc: fastrpc: missing DMA and IOMMU setup in fastrpc_cb_devices_c=
reate()
- [High] misc: fastrpc: premature misc_register() before fastrpc_cb_devices=
_create()
--

commit 17aff65cbac844472a8706f83a0e300c3444f667
Author: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>

misc: fastrpc: iterate CB nodes manually instead of of_platform_populate

This commit replaces of_platform_populate() and the separate
fastrpc_cb_driver platform driver with manual iteration over child DT nodes
in fastrpc_cb_devices_create() and cleanup in fastrpc_cb_devices_destroy()
so context banks are initialized synchronously during fastrpc_rpmsg_probe().

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index af18ff1992eed..caa479f304c1c 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c

[ ... ]

> @@ -2389,37 +2388,51 @@ static int fastrpc_cb_probe(struct platform_devic=
e *pdev)
>  	return 0;
>  }
> =20
> -static void fastrpc_cb_remove(struct platform_device *pdev)
> +static void fastrpc_cb_devices_destroy(struct rpmsg_device *rpdev)
>  {
> -	struct fastrpc_channel_ctx *cctx =3D dev_get_drvdata(pdev->dev.parent);
> -	struct fastrpc_session_ctx *sess =3D dev_get_drvdata(&pdev->dev);
> +	struct fastrpc_channel_ctx *cctx =3D dev_get_drvdata(&rpdev->dev);
> +	struct device *rdev =3D &rpdev->dev;
>  	unsigned long flags;
>  	int i;
> =20
>  	spin_lock_irqsave(&cctx->lock, flags);
> -	for (i =3D 0; i < FASTRPC_MAX_SESSIONS; i++) {
> -		if (cctx->session[i].sid =3D=3D sess->sid) {
> -			cctx->session[i].valid =3D false;
> -			cctx->sesscount--;
> -		}
> -	}
> +	for (i =3D 0; i < cctx->sesscount; i++)
> +		cctx->session[i].valid =3D false;
>  	spin_unlock_irqrestore(&cctx->lock, flags);
> +
> +	device_for_each_child_reverse(rdev, NULL, of_platform_device_destroy);
>  }
> =20
> -static const struct of_device_id fastrpc_match_table[] =3D {
> -	{ .compatible =3D "qcom,fastrpc-compute-cb" },
> -	{ }
> -};
> +static int fastrpc_cb_devices_create(struct rpmsg_device *rpdev)
> +{
> +	struct device *rdev =3D &rpdev->dev;
> +	struct platform_device *pdev;
> +	struct device_node *np;
> +	int err;
> =20
> -static struct platform_driver fastrpc_cb_driver =3D {
> -	.probe =3D fastrpc_cb_probe,
> -	.remove =3D fastrpc_cb_remove,
> -	.driver =3D {
> -		.name =3D "qcom,fastrpc-cb",
> -		.of_match_table =3D fastrpc_match_table,
> -		.suppress_bind_attrs =3D true,
> -	},
> -};
> +	for_each_available_child_of_node(rdev->of_node, np) {
> +		if (!of_device_is_compatible(np, "qcom,fastrpc-compute-cb")) {
> +			of_node_put(np);
> +			continue;
> +		}

[Severity: High]
Won't calling of_node_put(np) before continue in fastrpc_cb_devices_create()
cause a double-put on np when an available child node is not compatible with
"qcom,fastrpc-compute-cb"?

for_each_available_child_of_node() advances by calling
of_get_next_available_child() -> of_get_next_status_child() in
drivers/of/base.c:

	of_node_put(prev);
	raw_spin_unlock_irqrestore(&devtree_lock, flags);
	return next;

Because the loop increment expression dereferences prev->sibling and
automatically calls of_node_put(prev) on each step, dropping the reference =
on
np explicitly before continue underflows the struct device_node reference
count and can lead to a use-after-free.

> +
> +		pdev =3D of_platform_device_create(np, NULL, rdev);
> +		if (!pdev) {
> +			of_node_put(np);
> +			fastrpc_cb_devices_destroy(rpdev);
> +			return -ENODEV;
> +		}
> +
> +		err =3D fastrpc_cb_init(pdev);
> +		if (err) {
> +			of_node_put(np);
> +			fastrpc_cb_devices_destroy(rpdev);
> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +}

[Severity: High]
With fastrpc_cb_driver removed, how are DMA and IOMMU configuration and
probe deferral handled for the context bank platform devices created in
fastrpc_cb_devices_create()?

Previously, binding each qcom,fastrpc-compute-cb device to fastrpc_cb_driver
went through really_probe() in drivers/base/dd.c, which checked supplier
links via device_links_check_suppliers(dev), set dev->driver, and called
platform_dma_configure() in drivers/base/platform.c:

	if (is_of_node(fwnode)) {
		ret =3D of_dma_configure(dev, to_of_node(fwnode), true);
	} else if (is_acpi_device_node(fwnode)) {
		attr =3D acpi_get_dma_attr(to_acpi_device_node(fwnode));
		ret =3D acpi_dma_configure(dev, attr);
	}
	/* @dev->driver may not be valid when we're called from the IOMMU layer */
	if (ret || !drv || to_platform_driver(drv)->driver_managed_dma)
		return ret;

	ret =3D iommu_device_use_default_domain(dev);

Without a bound platform_driver or an explicit of_dma_configure() call in
fastrpc_cb_devices_create() or fastrpc_cb_init(), pdev->dev.driver is always
NULL:

1. Because the iommus property resides on the child compute-cb DT nodes
   rather than the parent rpmsg node, fw_devlink only creates proxy
   sync_state links on rdev. During of_platform_device_create() ->
   device_add(), iommu_init_device() in drivers/iommu/iommu.c calls
   dev->bus->dma_configure(dev) with dev->driver =3D=3D NULL and ignores its
   return value. If the SMMU has not probed yet and of_iommu_configure()
   returns -EPROBE_DEFER in of_dma_configure_id() (drivers/of/device.c), it
   returns early before arch_setup_dma_ops(dev, coherent), yet
   fastrpc_cb_init() still succeeds and marks sess->valid =3D true with
   unconfigured DMA ops and no IOMMU translation. A subsequent
   bus_iommu_probe() replay of of_dma_configure_id() also overwrites
   *dev->dma_mask with the 32-bit coherent_dma_mask, clobbering the 34-bit
   mask set via dma_set_mask() in fastrpc_cb_init().

2. When CONFIG_IOMMU_API is disabled, iommu_bus_notifier is not registered
   and of_dma_configure() is never called on pdev->dev at all.

3. Even when the SMMU has already probed, platform_dma_configure() returns
   before calling iommu_device_use_default_domain(dev) because dev->driver
   is NULL (leaving group->owner_cnt at 0 while fastrpc performs DMA
   allocations and dma_buf mappings on sess->dev), and managed supplier
   device links to pdev->dev remain unactivated because
   device_links_driver_bound() never runs.

> @@ -2639,7 +2652,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device =
*rpdev)
>  	data->rpdev =3D rpdev;
>  	dev_set_drvdata(&rpdev->dev, data);
> =20
> -	err =3D of_platform_populate(rdev->of_node, NULL, NULL, rdev);
> +	err =3D fastrpc_cb_devices_create(rpdev);
>  	if (err)
>  		goto err_deregister_fdev;
> =20

[Severity: High]
Could calling fastrpc_cb_devices_create() after fastrpc_device_register() in
fastrpc_rpmsg_probe() still expose partially initialized sessions to
userspace and trigger a use-after-free on failure?

Earlier in fastrpc_rpmsg_probe(), fastrpc_device_register() calls
misc_register() before data->refcount, data->users, data->lock, data->ctx_i=
dr,
and data->rpdev are initialized, and before fastrpc_cb_devices_create(rpdev)
is called (as well as before ADSP duplicate session creation in "misc:
fastrpc: move ADSP duplicate session creation to the driver"). Inside
fastrpc_cb_init(), sess->valid =3D true and cctx->sesscount++ are also publ=
ished
under cctx->lock before dma_set_mask() is executed:

	sess =3D &cctx->session[cctx->sesscount++];
	sess->used =3D false;
	sess->valid =3D true;
	sess->dev =3D dev;
	sess->sid =3D sid;
	...
	spin_unlock_irqrestore(&cctx->lock, flags);
	rc =3D dma_set_mask(dev, DMA_BIT_MASK(dma_bits));
	if (rc) {
		dev_err(dev, "%u-bit DMA enable failed\n", dma_bits);
		return rc;
	}

Because the miscdevices are already registered while
fastrpc_cb_devices_create() iterates over the DT child nodes, a concurrent
fastrpc_device_open() -> fastrpc_session_alloc() can still observe zero or a
partial set of sessions, or acquire an earlier session and take a reference
on data via fastrpc_channel_ctx_get(cctx).

Unlike of_platform_populate() which previously returned 0 even if child
device creation failed, if dma_set_mask() fails or a later CB node fails in
of_platform_device_create() or fastrpc_cb_init(), fastrpc_cb_devices_create=
()
destroys the CB platform devices and fastrpc_rpmsg_probe() jumps to
err_deregister_fdev -> err_free_data: kfree(data), freeing data while an op=
en
file descriptor still holds references to fl->cctx and fl->sctx->dev. Should
fastrpc_device_register() be called only after cctx and all CB sessions have
been fully initialized?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021-dup-sessio=
ns-v6-0-578ab52ba66c@oss.qualcomm.com?part=3D1
