Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD36CC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 09:00:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1771610F64E;
	Tue, 13 Oct 2026 09:00:14 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E309E10E794
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 09:00:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0A1EB600D1;
 Tue, 13 Oct 2026 09:00:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942781F000FF;
 Tue, 13 Oct 2026 09:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791882005;
 bh=mP8UAN166uAwmr9BVXGi3v2QYRRMQOZOs0t/KTz2cqw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Qr07HNFqczWXpXGXJMp1t/YBZGzZawx4TqTJwFVL+hgaGKgm8OMwwJ2w2/PEpCuxi
 /nVC6min64gRDq1/MXem19Bve4/4deOmZhfr3zDHUoDd9mMgCiiVys0pueilVh6Jcu
 78Yfp5kmxd2Dc1ANpTxE5u7kdpt6eJ+QeQUD4GG9l4KKsLJw7cv/rzRfFqmxDIktiy
 eoyBR93jZjWGZZaz+vhglM6ziCsOFLRR+eDdkW8OZRfbPoVW9V3gqjb8dNsGy5Jpbs
 87+1D9dzwpkltHtiVDn0q88o41/h4AMZvndj5bkdHX8PJkS/abnPNUZmI2sTXlDM93
 +HiFIFveXOiIg==
Message-ID: <sashiko-outbox-169293@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/7] bus: mhi: Move Sahara protocol driver under MHI
 host client drivers
To: "Kishore Batta" <kishore.batta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261013-sahara_protocol_new_v2-v9-2-dc9f24357c4a@oss.qualcomm.com>
References: <20261013-sahara_protocol_new_v2-v9-0-dc9f24357c4a@oss.qualcomm.com>
 <20261013-sahara_protocol_new_v2-v9-2-dc9f24357c4a@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 09:00:05 +0000
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
- [High] qaic: leak of timesync and ras drivers on init failure
- [High] mhi: sahara: UAF due to missing read_data_work cancellation
- [Medium] bus: mhi: mhi_sahara module missing MODULE_DEVICE_TABLE for auto=
loading
- [Medium] kconfig: MHI_SAHARA missing select WANT_DEV_COREDUMP silently dr=
ops dumps
--

commit 1096a5d73941553ee9b70087bffc4c550e7d93dd
Author: Kishore Batta <kishore.batta@oss.qualcomm.com>

bus: mhi: Move Sahara protocol driver under MHI host client drivers

This commit moves the Sahara protocol driver from the QAIC accelerator
subsystem to the generic MHI host client drivers. It creates a dedicated
Kconfig and Makefile hierarchy for Sahara. The driver is also converted
to use module_mhi_driver() instead of manual register and unregister hooks.

> diff --git a/drivers/bus/mhi/host/clients/sahara/Kconfig b/drivers/bus/mh=
i/host/clients/sahara/Kconfig
> new file mode 100644
> index 0000000000000..f1fc7013a2dee
> --- /dev/null
> +++ b/drivers/bus/mhi/host/clients/sahara/Kconfig
> @@ -0,0 +1,15 @@
> +config MHI_SAHARA
> +	tristate "Sahara protocol driver"
> +	depends on MHI_BUS

[Severity: Medium]
Will this silently drop memory dumps on systems without WANT_DEV_COREDUMP
enabled?

Since WANT_DEV_COREDUMP is a hidden symbol (no prompt), users cannot manual=
ly
enable it. Because the newly extracted MHI_SAHARA driver advertises memory
dump retrieval and relies on dev_coredumpv(), omitting a select
WANT_DEV_COREDUMP statement means the devcoredump fallback stub might just
free the buffer without warning, leading to a silent loss of functionality.

> diff --git a/drivers/accel/qaic/qaic_drv.c b/drivers/accel/qaic/qaic_drv.c
> index 0acf6cdd44f81..64e87dfaa5603 100644
> --- a/drivers/accel/qaic/qaic_drv.c
> +++ b/drivers/accel/qaic/qaic_drv.c
[ ... ]
> @@ -816,7 +809,6 @@ static int __init qaic_init(void)
> =20
>  free_bootlog:
>  	qaic_bootlog_unregister();
> -free_mhi:
>  	mhi_driver_unregister(&qaic_mhi_driver);
>  free_pci:
>  	pci_unregister_driver(&qaic_pci_driver);

[Severity: High]
Does this error path leak the timesync and ras MHI drivers?

If qaic_ssr_register() fails, the code jumps to free_bootlog. This cleanup
path unregisters the bootlog, MHI, and PCI drivers, but skips calling
qaic_timesync_deinit() and qaic_ras_unregister().=20

Because mhi_driver_register() adds these driver structures to the driver
core and sysfs, failing module initialization without unregistering them
leaves dangling pointers to the unloaded module's memory, which could
trigger a use-after-free crash if the bus core subsequently accesses them.

> diff --git a/drivers/accel/qaic/sahara.c b/drivers/bus/mhi/host/clients/s=
ahara/sahara.c
> similarity index 99%
> rename from drivers/accel/qaic/sahara.c
> rename to drivers/bus/mhi/host/clients/sahara/sahara.c
> index c7c0b3eb4b65f..75c0cf6010e15 100644
> --- a/drivers/accel/qaic/sahara.c
> +++ b/drivers/bus/mhi/host/clients/sahara/sahara.c
[ ... ]
> @@ -922,13 +922,7 @@ static struct mhi_driver sahara_mhi_driver =3D {
>  		.name =3D "sahara",
>  	},
>  };
> +module_mhi_driver(sahara_mhi_driver);

[Severity: Medium]
Will this driver fail to load automatically when the hardware is detected?

Because the driver is now extracted into an independent module, missing the
MODULE_DEVICE_TABLE macro for sahara_mhi_match_table means the match table
isn't exported to the module alias table. This prevents udev or modprobe
from automatically loading mhi_sahara when the QAIC_SAHARA channel is
detected.

[Severity: High]
Is there a use-after-free risk during device removal if read_data_work
remains pending?

When the device is removed or unbound via sysfs, sahara_mhi_remove() is
called. While fw_work and dump_work are cancelled, read_data_work is
completely omitted:

drivers/bus/mhi/host/clients/sahara/sahara.c:sahara_mhi_remove() {
	struct sahara_context *context =3D dev_get_drvdata(&mhi_dev->dev);

	cancel_work_sync(&context->fw_work);
	cancel_work_sync(&context->dump_work);
	vfree(context->mem_dump);
	sahara_release_image(context);
	mhi_unprepare_from_transfer(mhi_dev);
}

If read_data_work was scheduled and remains pending, it will execute after
sahara_mhi_remove() returns and access the context structure, which has
already been freed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-sahara_pro=
tocol_new_v2-v9-0-dc9f24357c4a@oss.qualcomm.com?part=3D2
