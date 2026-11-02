Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D27606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nvvrfu8G
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0760510E5EC;
	Mon,  2 Nov 2026 08:54:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BA9A10EC38
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 08:54:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 85055435B9;
 Mon,  2 Nov 2026 08:54:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA8D1F000C1;
 Mon,  2 Nov 2026 08:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793609651;
 bh=5ouW8bPwxm9oPY5ROks9PUBMahMrV83ww3DdhtzYSvw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nvvrfu8Gj9eo5L/WT7fdJl6hRlKV+Gij/pKVoid5Wf0tpcTpfi9DPS3t52mwLdm6Q
 CzP+J/P48oYuXY3h23Njb7abGEt9s2mzyl4Py3ALnDVq0i4OsV59pUg+L/x+wrRB0v
 cemyWUTJ2/z9L3kZ93c+Pqqa/uHS5/WPLu2Nzq+WN7WGxli0SaIKgfUc8wDoc+fNG2
 nryzwHAQZSfHy3eaciC+uvSI+F7gQ6ul7VM7Bx1JVSAuQBc61OYJdojm+qRNrf5J0R
 QaRuE2Y9D9QUIPnwjPEdiXeX+QVABdp+BK1LkGOyAdvl7ijhzbXz+qRi856d5p8hwV
 1DimEZenXEc1w==
Message-ID: <sashiko-outbox-193141@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/3] misc: fastrpc: iterate CB nodes manually instead
 of of_platform_populate
To: "Vinayak Katoch" <vinayak.katoch@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261102-dup-sessions-v7-1-03f06c014e78@oss.qualcomm.com>
References: <20261102-dup-sessions-v7-0-03f06c014e78@oss.qualcomm.com>
 <20261102-dup-sessions-v7-1-03f06c014e78@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 08:54:10 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] misc: fastrpc: missing SCM memory and pointer cleanup in fastrpc_r=
pmsg_probe()
- [High] misc: fastrpc: premature fastrpc_device_register() in fastrpc_rpms=
g_probe()
--

commit 3d1d4146f1c73d49d10eb5163573a4b2ed34670c
Author: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>

misc: fastrpc: iterate CB nodes manually instead of of_platform_populate

This commit replaces of_platform_populate() and the separate
fastrpc_cb_driver platform driver with manual iteration over child DT nodes
in fastrpc_cb_devices_create() so that context banks are synchronously
configured and initialized before fastrpc_rpmsg_probe() returns. It also
adds fastrpc_cb_devices_destroy() to invalidate sessions and destroy the
child platform devices on teardown.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index af18ff1992eed..7441e9b8940d8 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c

[ ... ]

> +static int fastrpc_cb_devices_create(struct rpmsg_device *rpdev)
> +{
> +	struct device *rdev =3D &rpdev->dev;
> +	struct platform_device *pdev;
> +	struct device_node *np;
> +	int err;
> =20
> +	for_each_available_child_of_node(rdev->of_node, np) {
> +		if (!of_device_is_compatible(np, "qcom,fastrpc-compute-cb"))
> +			continue;
> +
> +		pdev =3D of_platform_device_create(np, NULL, rdev);
> +		if (!pdev) {
> +			of_node_put(np);
> +			fastrpc_cb_devices_destroy(rpdev);
> +			return -ENODEV;
> +		}
> +
> +		/*
> +		 * No driver binds to the CB devices, so the driver core never
> +		 * runs dma_configure for them. Do it here so that dma-coherent,
> +		 * dma-ranges and the IOMMU link are set up before the session
> +		 * is used. A CB whose IOMMU setup failed is destroyed now,
> +		 * instead of being left for the next IOMMU registration to
> +		 * retry (and fail on), but does not fail the whole channel:
> +		 * failing the probe makes the DSP reopen the channel in a loop.
> +		 */
> +		err =3D of_dma_configure(&pdev->dev, np, true);
> +		if (!err && of_property_present(np, "iommus") &&
> +		    !device_iommu_mapped(&pdev->dev))
> +			err =3D -ENODEV;
> +		if (err) {
> +			if (err =3D=3D -EPROBE_DEFER) {
> +				of_node_put(np);
> +				fastrpc_cb_devices_destroy(rpdev);
> +				return err;
> +			}
> +
> +			dev_err(rdev, "skipping %pOF: failed to configure DMA/IOMMU: %d\n",
> +				np, err);
> +			of_platform_device_destroy(&pdev->dev, NULL);
> +			continue;
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
> =20
>  static int fastrpc_device_register(struct device *dev, struct fastrpc_ch=
annel_ctx *cctx,
>  				   bool is_secured, const char *domain)

[Severity: High]
As reported by Sashiko on v2 [1], fastrpc_rpmsg_probe() calls
fastrpc_device_register() -> misc_register() before initializing the
channel context fields and before calling fastrpc_cb_devices_create():

fastrpc_rpmsg_probe()
    fastrpc_device_register()
        misc_register(&fdev->miscdev);
    ...
    kref_init(&data->refcount);
    ...
    INIT_LIST_HEAD(&data->users);
    spin_lock_init(&data->lock);
    idr_init(&data->ctx_idr);
    data->domain_id =3D domain_id;
    data->rpdev =3D rpdev;
    dev_set_drvdata(&rpdev->dev, data);

    err =3D fastrpc_cb_devices_create(rpdev);
    if (err)
        goto err_deregister_fdev;

If userspace opens /dev/fastrpc-* immediately after misc_register(),
fastrpc_device_open() runs on an uninitialized spinlock and kref, can
dereference a null cctx->rpdev in dev_err_ratelimited(&cctx->rpdev->dev, ..=
.),
and still sees zero or only partially populated sessions while
fastrpc_cb_devices_create() iterates over the child nodes (additionally,
fastrpc_cb_init() sets sess->valid =3D true under cctx->lock before checking
dma_set_mask()).

Furthermore, with this patch, if fastrpc_cb_devices_create() initializes
the first context bank and a concurrent fastrpc_device_open() acquires that
session, and then a subsequent child node returns -EPROBE_DEFER from
of_dma_configure() or fails in of_platform_device_create() or
fastrpc_cb_init(), fastrpc_cb_devices_create() calls
fastrpc_cb_devices_destroy(rpdev) and fastrpc_rpmsg_probe() jumps to
err_deregister_fdev:

err_deregister_fdev:
    if (data->fdevice)
        misc_deregister(&data->fdevice->miscdev);
    if (data->secure_fdevice)
        misc_deregister(&data->secure_fdevice->miscdev);

err_free_data:
    kfree(data);

Can this destroy the child platform device backing fl->sctx->dev and
unconditionally kfree(data) while the open file descriptor still holds
active references to fl->cctx and fl->sctx?

> @@ -2639,7 +2677,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device =
*rpdev)
>  	data->rpdev =3D rpdev;
>  	dev_set_drvdata(&rpdev->dev, data);
> =20
> -	err =3D of_platform_populate(rdev->of_node, NULL, NULL, rdev);
> +	err =3D fastrpc_cb_devices_create(rpdev);
>  	if (err)
>  		goto err_deregister_fdev;

[Severity: High]
Previously, of_platform_populate() only registered child devices and return=
ed
0 even when child context bank probes deferred waiting for the SMMU. Now
fastrpc_cb_devices_create() synchronously calls of_dma_configure() and
fastrpc_cb_init() and returns -EPROBE_DEFER (or another error) to
fastrpc_rpmsg_probe(), jumping to err_deregister_fdev.

Earlier in fastrpc_rpmsg_probe(), fastrpc_init_reserved_mem() transfers
ownership of the reserved memory region for ADSP_DOMAIN_ID and SDSP_DOMAIN_=
ID
away from HLOS to the remote DSP VMIDs:

fastrpc_init_reserved_mem()
    if (domain_id =3D=3D ADSP_DOMAIN_ID) {
        cctx->remote_heap_addr =3D res.start;
        cctx->remote_heap_size =3D resource_size(&res);
    }
    if (!cctx->vmcount)
        return 0;
    src_perms =3D BIT(QCOM_SCM_VMID_HLOS);
    return qcom_scm_assign_mem(res.start, resource_size(&res), &src_perms,
                               cctx->vmperms, cctx->vmcount);

And before calling fastrpc_cb_devices_create(), fastrpc_rpmsg_probe() also
sets up:

    rdev->dma_mask =3D &data->dma_mask;
    ...
    idr_init(&data->ctx_idr);
    ...
    dev_set_drvdata(&rpdev->dev, data);

When fastrpc_cb_devices_create() fails or returns -EPROBE_DEFER,
err_deregister_fdev frees data without reassigning the reserved memory back
to QCOM_SCM_VMID_HLOS, without destroying data->ctx_idr, and without cleari=
ng
rpdev->dev.driver_data or rdev->dma_mask.

When the deferred probe is retried later, won't fastrpc_init_reserved_mem()
fail permanently in qcom_scm_assign_mem() because QCOM_SCM_VMID_HLOS no
longer owns the memory region, while also leaving dangling rdev->dma_mask a=
nd
drvdata pointers into freed memory (where an incoming rpmsg callback before
rpmsg_destroy_ept() in rpmsg_dev_probe() could dereference cctx in
fastrpc_rpmsg_callback())?

[1] https://lore.kernel.org/r/20260708041312.ACF681F000E9@smtp.kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-dup-sessio=
ns-v7-0-03f06c014e78@oss.qualcomm.com?part=3D1
