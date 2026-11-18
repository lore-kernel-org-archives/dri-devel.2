Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ECB606A330
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 23:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=duRSMqdl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A5561120C3;
	Wed, 18 Nov 2026 23:35:34 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DBBE1120C3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 23:35:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BF5756429B;
 Wed, 18 Nov 2026 23:35:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B62B1F000C4;
 Wed, 18 Nov 2026 23:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795044922;
 bh=V/3Sa/7amUi1Q38yROz+XHYMjg2iV0mSA7O5MhN/l1Y=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=duRSMqdl+mYigm2fsprPuDX6uaBxpEfWTNnWBaIOpGzVd/tiYHeHvFtnXtW1EL0t4
 YdMwopKtFf+vySWZI5TLV/Xt436emGOgaqFiYbahwXznvC+DC0ZLNQFWIDRuI4VSBu
 Gd3bmcG28NlAR6Bj3UqPj3XRIkdUu+2jwDlA3U41mpfR5YQqwYAzN/z5vuUl2dS8Zb
 tQ23BvTsHgb1Tc4ygONSfT3wDP2RKDDIbumdogwu8aGr0+Xd6dp+07SI9GefqXtgnk
 8QONUbepl8awE72tBOC1Ahe1qltlulbAUnIMXI1dlqFdts6LYJbK3HBwqmGAslZrAO
 er1VaZjJwgLJA==
Message-ID: <sashiko-outbox-222190@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/4] accel/qaic: Add callbacks for DRM RAS netlink
 telemetry
To: "Zack McKevitt" <zachary.mckevitt@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261117233442.407877-5-zachary.mckevitt@oss.qualcomm.com>
References: <20261117233442.407877-1-zachary.mckevitt@oss.qualcomm.com>
 <20261117233442.407877-5-zachary.mckevitt@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 23:35:22 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] accel/qaic: missing tele_wq flush and drmm/devm mismatch in
  create_qdev()
- [Medium] accel/qaic: missing dev_state check under tele_mutex in
  telemetry_request()
- [Medium] accel/qaic: Kconfig depends on default-n DRM_RAS despite
  stubbed API
- [Low] accel/qaic: ignored qaic_telemetry_register() failure in
  qaic_init()
--

commit d01a133716244ea133490c85965bd2f525824839
Author: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>

accel/qaic: Add callbacks for DRM RAS netlink telemetry

This commit adds MHI telemetry channel support for QAIC devices and
registers a DRM RAS telemetry node to expose device telemetry fields over
Generic Netlink.

> diff --git a/drivers/accel/qaic/Kconfig b/drivers/accel/qaic/Kconfig
> index 116e42d152ca8..6a07db0c402e7 100644
> --- a/drivers/accel/qaic/Kconfig
> +++ b/drivers/accel/qaic/Kconfig
> @@ -8,6 +8,7 @@ config DRM_ACCEL_QAIC
>  	depends on DRM_ACCEL
>  	depends on PCI && HAS_IOMEM
>  	depends on MHI_BUS
> +	depends on DRM_RAS
>  	select CRC32
>  	select WANT_DEV_COREDUMP
>  	help

[Severity: Medium]
Does adding "depends on DRM_RAS" disable DRM_ACCEL_QAIC in existing
configs?  DRM_RAS defaults to n, so running olddefconfig on a kernel
configuration with DRM_ACCEL_QAIC enabled will silently drop the driver
unless DRM_RAS was explicitly selected.

include/drm/drm_ras.h already provides no-op inline stubs for
drm_ras_node_register() and drm_ras_node_unregister() when CONFIG_DRM_RAS
is disabled, so DRM_ACCEL_QAIC does not need a hard Kconfig dependency on
DRM_RAS.

[ ... ]

> diff --git a/drivers/accel/qaic/qaic_drv.c b/drivers/accel/qaic/qaic_drv.c
> index 90c0d31e414ae..6d185151a0a69 100644
> --- a/drivers/accel/qaic/qaic_drv.c
> +++ b/drivers/accel/qaic/qaic_drv.c

[ ... ]

> @@ -854,12 +863,17 @@ static int __init qaic_init(void)
>  	ret =3D qaic_ras_register();
>  	if (ret)
>  		pr_debug("qaic: qaic_ras_register failed %d\n", ret);
> +
>  	ret =3D qaic_ssr_register();
>  	if (ret) {
>  		pr_debug("qaic: qaic_ssr_register failed %d\n", ret);
>  		goto free_bootlog;
>  	}
> =20
> +	ret =3D qaic_telemetry_register();
> +	if (ret)
> +		pr_debug("qaic: qaic_telemetry_register failed %d\n", ret);
> +
>  	return 0;
> =20
>  free_bootlog:
> @@ -889,6 +903,7 @@ static void __exit qaic_exit(void)
>  	 * reinitializing the link_up state after the cleanup is done.
>  	 */
>  	link_up =3D true;
> +	qaic_telemetry_unregister();
>  	qaic_ssr_unregister();
>  	qaic_ras_unregister();
>  	qaic_bootlog_unregister();

[Severity: Low]
If qaic_telemetry_register() fails in qaic_init(), module initialization
still succeeds with qaic_telemetry_mhi_driver left unregistered.  When the
module is later unloaded, qaic_exit() unconditionally calls
qaic_telemetry_unregister() -> mhi_driver_unregister() ->
driver_unregister(), which hits WARN(1, "Unexpected driver unregister!\n")
because drv->p is NULL.  Should qaic_init() unwind and propagate the error
when qaic_telemetry_register() fails, matching qaic_ssr_register()?

> diff --git a/drivers/accel/qaic/qaic_telemetry.c b/drivers/accel/qaic/qai=
c_telemetry.c
> new file mode 100644
> index 0000000000000..bcf9842f4ec91
> --- /dev/null
> +++ b/drivers/accel/qaic/qaic_telemetry.c
> @@ -0,0 +1,563 @@

[ ... ]

> +static int telemetry_request(struct qaic_device *qdev, u8 cmd, u8 cmd_ty=
pe, s64 *val, s64 *status)
> +{
> +	struct wrapper_msg *wrapper;
> +	struct xfer_queue_elem elem;
> +	struct telemetry_msg *resp;
> +	struct telemetry_msg *req;
> +	long ret =3D 0;
> +
> +	wrapper =3D kzalloc_obj(*wrapper);
> +	if (!wrapper)
> +		return -ENOMEM;
> +
> +	kref_init(&wrapper->ref_count);
> +	req =3D &wrapper->msg;
> +
> +	ret =3D mutex_lock_interruptible(&qdev->tele_mutex);
> +	if (ret)
> +		goto free_req;
> +
> +	if (!qdev->tele_ch) {
> +		mutex_unlock(&qdev->tele_mutex);
> +		ret =3D -ENODEV;
> +		goto free_req;
> +	}

[Severity: Medium]
Can telemetry_request() queue a request onto qdev->tele_xfer_list after
wake_all_telemetry() has already drained it during a reset?

qaic_telemetry_get() and qaic_telemetry_set() check qdev->dev_state !=3D
QAIC_ONLINE before calling telemetry_request() and acquiring
qdev->tele_mutex.  During qaic_notify_reset(), qdev->tele_ch remains
non-NULL until qaic_telemetry_mhi_remove() runs after
synchronize_srcu(&qdev->dev_lock):

CPU0                                    CPU1
qaic_telemetry_get()
  srcu_read_lock(&qdev->dev_lock)
  if (qdev->dev_state !=3D QAIC_ONLINE)
  telemetry_request()
                                        qaic_notify_reset()
                                          qdev->dev_state =3D QAIC_OFFLINE;
                                          wake_all_telemetry(qdev)
                                            mutex_lock(&qdev->tele_mutex)
                                            /* drains tele_xfer_list */
                                            mutex_unlock(&qdev->tele_mutex)
    mutex_lock_interruptible(&qdev->tele_mutex)
    /* qdev->tele_ch is still non-NULL */
    mhi_queue_buf(...)
    list_add_tail(&elem.list, &qdev->tele_xfer_list)
    mutex_unlock(&qdev->tele_mutex)
    wait_for_completion_interruptible_timeout(..., HZ)
                                          synchronize_srcu(&qdev->dev_lock)
                                            <-- stalls for HZ

CPU0 queues MHI buffers onto a resetting channel after wake_all_telemetry()
has already run, stalls synchronize_srcu(&qdev->dev_lock) for the full HZ
timeout, and returns -ETIMEDOUT instead of -ENODEV.  Should
telemetry_request() recheck qdev->dev_state !=3D QAIC_ONLINE under
qdev->tele_mutex, similar to how msg_xfer() checks qdev->dev_state under
qdev->cntl_mutex?

[ ... ]

> +static void qaic_telemetry_mhi_remove(struct mhi_device *mhi_dev)
> +{
> +	struct qaic_device *qdev =3D dev_get_drvdata(&mhi_dev->dev);
> +
> +	qaic_drm_ras_unregister_node(qdev);
> +	mhi_unprepare_from_transfer(qdev->tele_ch);
> +	qdev->tele_ch =3D NULL;
> +}

[Severity: High]
Can a pending resp_worker() item or drmm cleanup access qdev after it has
been freed?

In create_qdev(), qdev is allocated with devm_kzalloc_flex() on &pdev->dev,
whereas qdev->tele_mutex and qdev->tele_wq are managed by drmm on the
drm_device via drmm_mutex_init() and qaicm_wq_init().  Furthermore,
qaic_telemetry_mhi_remove() does not flush qdev->tele_wq after
mhi_unprepare_from_transfer().  If the PCI device is removed while
userspace holds an open file descriptor to /dev/accel/accelN, the open file
keeps a reference on drm_device, so devres frees qdev before
drm_managed_release() runs:

CPU0                                    kworker
qaic_pci_remove()
  ...
  qaic_telemetry_mhi_remove()
    mhi_unprepare_from_transfer(...)
    /* tele_wq not flushed */
devres_release_all(&pdev->dev)
  /* frees qdev while drm ref > 0 */
                                        resp_worker()
                                          mutex_lock(&qdev->tele_mutex)
                                            <-- use-after-free

Even without a pending work item, when userspace later closes the DRM file
descriptor, the final drm_dev_put() runs __drmm_mutex_release() on
&qdev->tele_mutex in the already-freed qdev.  Flushing qdev->tele_wq in
qaic_telemetry_mhi_remove() and tying tele_mutex and tele_wq to devm on
&pdev->dev (or matching qdev's lifetime) would avoid both use-after-frees.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117233442.4078=
77-1-zachary.mckevitt@oss.qualcomm.com?part=3D4
