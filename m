Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 138AAC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:50:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D09C10E364;
	Wed,  1 Jul 2026 10:50:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ORHqEKsJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0966C10E364
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 10:50:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E46F64405F;
 Wed,  1 Jul 2026 10:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4371F00A3A;
 Wed,  1 Jul 2026 10:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782903055;
 bh=+JBXT1ilAdUfk5qXBlYUsxIdHaKX7iMEpOjN8I7pspU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ORHqEKsJA4TZhvik89WJvYgD44DdGVSedm6F7mmGmwBDjEuu7RTcBNgOgjg0D33fu
 i6Xvbp2oINA9eIwH1Rpd5TCDKHtxoVzsbcFzUApOBJzzDbjtxDet6oXTna81OZZFzN
 oNYBdSeJ2oOGUIA/mCy7oh3NKYRP1iDYAJBkmNMJRC9iISl40pbD2Hm8t7yw2sfkz7
 I3lcpn5NsiGRoGFWkWQiFVAPzUXJ7wBzYEJM8230rn/JNjKOowH5wtNmDLIfkaEaxg
 qmgg+zj1cWPEAcX24yTzAtP7v9y1D8IXSdT30PNIXd90WyPvdw2460YHQ2zSAv7g1u
 ATatNadhDd4zw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/7] bus: mhi: Move Sahara protocol driver under MHI
 host client drivers
To: "Kishore Batta" <kishore.batta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260701-sahara_protocol_new_v2-v6-2-3a78362c4741@oss.qualcomm.com>
References: <20260701-sahara_protocol_new_v2-v6-0-3a78362c4741@oss.qualcomm.com>
 <20260701-sahara_protocol_new_v2-v6-2-3a78362c4741@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 10:50:55 +0000
Message-Id: <20260701105055.8D4371F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Medium] Extracting the Sahara protocol to `MHI_SAHARA` and making `DRM_A=
CCEL_QAIC` depend on it breaks existing kernel configurations.
- [Medium] The standalone `MHI_SAHARA` Kconfig entry fails to select `WANT_=
DEV_COREDUMP`, causing memory dumps to be silently discarded if QAIC is not=
 enabled.

Pre-existing issues:
- [High] The `qaic_init()` error handling path fails to unregister the time=
sync and RAS MHI drivers if `qaic_ssr_register()` fails, causing a use-afte=
r-free panic.
- [High] The driver cleanup routine `sahara_mhi_remove()` fails to cancel `=
read_data_work`, which can lead to a use-after-free.
- [High] Teardown symmetry violation in `sahara_mhi_remove()` allows cancel=
led works to be rescheduled by incoming MHI traffic, leading to a use-after=
-free.
--

commit 45d20bba8e8207c4574856cd753b585b5512dea6
Author: Kishore Batta <kishore.batta@oss.qualcomm.com>

bus: mhi: Move Sahara protocol driver under MHI host client drivers

This commit moves the Sahara protocol driver from the QAIC accelerator
subsystem to the MHI bus host client drivers. It creates a dedicated
Kconfig/Makefile hierarchy for Sahara and converts it to use
module_mhi_driver().

> diff --git a/drivers/accel/qaic/Kconfig b/drivers/accel/qaic/Kconfig
> --- a/drivers/accel/qaic/Kconfig
> +++ b/drivers/accel/qaic/Kconfig
> @@ -8,6 +8,7 @@ config DRM_ACCEL_QAIC
>  	depends on DRM_ACCEL
>  	depends on PCI && HAS_IOMEM
>  	depends on MHI_BUS
> +	depends on MHI_SAHARA

[Severity: Medium]
Will this dependency silently disable the QAIC driver for existing users?

When users upgrade their kernels and run make olddefconfig, the new
MHI_SAHARA option will default to 'N'. Because DRM_ACCEL_QAIC now uses
"depends on MHI_SAHARA", it will be silently disabled and hidden from
menuconfig.

Should this use "select MHI_SAHARA" instead to preserve backward
compatibility?

>  	select CRC32
>  	select WANT_DEV_COREDUMP
>  	help

[ ... ]

> diff --git a/drivers/accel/qaic/qaic_drv.c b/drivers/accel/qaic/qaic_drv.c
> --- a/drivers/accel/qaic/qaic_drv.c
> +++ b/drivers/accel/qaic/qaic_drv.c
> @@ -818,7 +811,6 @@ static int __init qaic_init(void)
> =20
>  free_bootlog:
>  	qaic_bootlog_unregister();
> -free_mhi:
>  	mhi_driver_unregister(&qaic_mhi_driver);
>  free_pci:
>  	pci_unregister_driver(&qaic_pci_driver);

[Severity: High]
This is a pre-existing issue, but does the qaic_init() error handling
path leak resources and cause a use-after-free?

If qaic_ssr_register() fails, the code jumps to free_bootlog, but it
misses unregistering the timesync and RAS MHI drivers:

drivers/accel/qaic/qaic_drv.c:qaic_init() {
    ...
    ret =3D qaic_timesync_init();
    ...
    ret =3D qaic_ras_register();
    ...
    ret =3D qaic_ssr_register();
    if (ret) {
        pr_debug("qaic: qaic_ssr_register failed %d\n", ret);
        goto free_bootlog;
    }
    ...
free_bootlog:
    qaic_bootlog_unregister();
    mhi_driver_unregister(&qaic_mhi_driver);
free_pci:
    ...
}

Since qaic_timesync_driver and qaic_ras_mhi_driver remain registered
with the MHI bus, will any subsequent MHI bus interaction dereference
these freed pointers and cause a kernel panic?

[ ... ]

> diff --git a/drivers/bus/mhi/host/clients/sahara/Kconfig b/drivers/bus/mh=
i/host/clients/sahara/Kconfig
> new file mode 100644
> --- /dev/null
> +++ b/drivers/bus/mhi/host/clients/sahara/Kconfig
> @@ -0,0 +1,15 @@
> +config MHI_SAHARA
> +	tristate "Sahara protocol driver"
> +	depends on MHI_BUS

[Severity: Medium]
Does this standalone Kconfig entry need to select WANT_DEV_COREDUMP?

The MHI_SAHARA driver uses dev_coredumpv() to generate memory dumps.
If it is built without QAIC or another driver that explicitly selects
WANT_DEV_COREDUMP, the kernel will use the fallback dummy stub for
dev_coredumpv(), silently freeing buffers and dropping the dumps.

Should MHI_SAHARA explicitly select WANT_DEV_COREDUMP here?

> +	help
> +	  Enable support for the Sahara protocol transported over the MHI bus.

[ ... ]

> diff --git a/drivers/accel/qaic/sahara.c b/drivers/bus/mhi/host/clients/s=
ahara/sahara.c
> similarity index 99%
> rename from drivers/accel/qaic/sahara.c
> rename to drivers/bus/mhi/host/clients/sahara/sahara.c
> --- a/drivers/accel/qaic/sahara.c
> +++ b/drivers/bus/mhi/host/clients/sahara/sahara.c
> @@ -923,13 +923,7 @@ static struct mhi_driver sahara_mhi_driver =3D {
>  		.name =3D "sahara",
>  	},
>  };
> +module_mhi_driver(sahara_mhi_driver);

[Severity: High]
This isn't a bug introduced by this patch, but does the driver cleanup
routine fail to cancel read_data_work?

The sahara_context struct is automatically freed after sahara_mhi_remove()
returns. The function cancels fw_work, dump_work, and cmd_work, but it
misses read_data_work:

drivers/bus/mhi/host/clients/sahara/sahara.c:sahara_mhi_remove() {
    ...
    cancel_work_sync(&context->fw_work);
    cancel_work_sync(&context->dump_work);
    cancel_work_sync(&context->cmd_work);
    vfree(context->mem_dump);
    sahara_release_image(context);
    ...
}

If read_data_work is pending or executing when the device is removed,
will it access the freed context struct and cause a use-after-free?


[Severity: High]
This is a pre-existing issue, but does the order of operations in
sahara_mhi_remove() allow cancelled works to be rescheduled?

The function calls cancel_work_sync() before calling
mhi_unprepare_from_transfer():

drivers/bus/mhi/host/clients/sahara/sahara.c:sahara_mhi_remove() {
    ...
    cancel_work_sync(&context->fw_work);
    cancel_work_sync(&context->dump_work);
    cancel_work_sync(&context->cmd_work);
    ...
    mhi_unprepare_from_transfer(mhi_dev);
}

Because the MHI channels remain active during the cancel_work_sync()
calls, can an incoming MHI packet immediately reschedule a work that
was just cancelled?

Should mhi_unprepare_from_transfer() be called first to silence
callbacks and prevent a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-sahara_pro=
tocol_new_v2-v6-0-3a78362c4741@oss.qualcomm.com?part=3D2
