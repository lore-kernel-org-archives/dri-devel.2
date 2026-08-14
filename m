Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5D5C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 13:50:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B78F10F5E2;
	Fri, 14 Aug 2026 13:50:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hb75IKdo";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8896B10F5D5
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 13:50:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 53F00404DC;
 Fri, 14 Aug 2026 13:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC7A1F000E9;
 Fri, 14 Aug 2026 13:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786715421;
 bh=Rjnq4x6bXEpNaVZbokgV//IhowIU6zyCU7xqVv+4d8k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hb75IKdon1FLke4et8E1DvTyFBKz7SZw2IOOCHh6HarqhUvlb3vbeosUkqJOynuq8
 aU41VoMZ7IiDuOOZJdSdqvLRuORRsASHGqLcJZTBvZUrgonip8EJKAmmn7AfP+YQld
 lCRn/roglb+P7SJxtjdOYDip3GDVrTsBTsg2Z0KhfwYHVBDUlixiCy7Ey8k6mUfJDB
 p7sdb/028RsQA/xsaZcOWn/8dC1qNjmGEn4O7AcGxda29Fyl+yBlOC778U3FqM/G8m
 TKaaKy2KAvIgSARLU1p1zmSo3nfAW13kT0OfQhoa6ji34nMtgXms7l8YIhWG1+yWVh
 f4fvAw7q9AnQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/amdxdna: Keep PCI power state in sync with
 runtime PM
To: reza.jelveh@gmail.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814132744.516105-1-reza.jelveh+git@gmail.com>
References: <20260814132744.516105-1-reza.jelveh+git@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 13:50:20 +0000
Message-Id: <20260814135021.0CC7A1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Error paths in aie2_hw_start() leave the PCI power state out of sy=
nc

Pre-existing issues:
- [High] Missing PCI state save before D3hot transition causes kernel warni=
ngs and configuration corruption
--

--- Patch [1]: [PATCH] accel/amdxdna: Keep PCI power state in sync with run=
time PM ---
commit f75387302cbbf4db35ad9c9ef5066d43bf266934
Author: Reza Jelveh <reza.jelveh+git@gmail.com>

accel/amdxdna: Keep PCI power state in sync with runtime PM

This patch attempts to keep the PCI core's power state tracking in sync wit=
h=20
the NPU hardware by explicitly setting D3hot in aie2_hw_stop() and D0 in=20
aie2_hw_start(). It aims to prevent errors during noirq suspend and resume=
=20
due to reading unreachable config space.

> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie=
2_pci.c
> index daec1f6b49079..831277c1eb744 100644
> --- a/drivers/accel/amdxdna/aie2_pci.c
> +++ b/drivers/accel/amdxdna/aie2_pci.c

[ ... ]

> @@ -316,6 +316,12 @@ static void aie2_hw_stop(struct amdxdna_dev *xdna)
>  	aie2_smu_fini(ndev);
>  	aie2_error_async_events_free(ndev);
>  	pci_disable_device(pdev);
> +	/*
> +	 * The platform powers the NPU down once the firmware is stopped.
> +	 * Record D3hot while the device is still reachable, so the noirq
> +	 * suspend path does not attempt a stale D0 transition.
> +	 */
> +	pci_set_power_state(pdev, PCI_D3hot);

[Severity: High]
This is a pre-existing issue, but will setting the power state to D3hot here
without first saving the PCI state trigger a PM warning and force a read of
corrupted config state?

If aie2_hw_stop() calls pci_set_power_state() without a preceding call to
pci_save_state(), the suspend paths detect that the power state changed
but the state is not saved, which triggers a "PCI PM: State of device not
saved" warning.

During pci_pm_suspend(), does this warning proceed to the noirq phase where
pci_save_state() reads from the already-powered-off device? This could save
0xffffffff and restore it on resume, which would permanently break the devi=
ce
until a cold reboot.

[ ... ]

> @@ -333,6 +339,13 @@ static int aie2_hw_start(struct amdxdna_dev *xdna)
>  		return 0;
>  	}
> =20
> +	/* The platform powers the device down when the firmware is stopped. */
> +	ret =3D pci_set_power_state(pdev, PCI_D0);
> +	if (ret) {
> +		XDNA_ERR(xdna, "failed to power up device, ret %d", ret);
> +		return ret;
> +	}
> +

[Severity: High]
If hardware initialization fails later in aie2_hw_start(), do the error
paths leave the PCI power state out of sync?

For example, if aie2_mgmt_fw_init() fails, the code jumps to stop_fw
and eventually disable_dev:

stop_fw:
    aie2_suspend_fw(ndev);
    xdna_mailbox_stop_channel(ndev->aie.mgmt_chann);
stop_psp:
    aie_psp_stop(ndev->aie.psp_hdl);
fini_smu:
    aie2_smu_fini(ndev);
free_channel:
    xdna_mailbox_free_channel(ndev->aie.mgmt_chann);
    ndev->aie.mgmt_chann =3D NULL;
disable_dev:
    pci_disable_device(pdev);

These error paths power down the hardware by stopping the firmware but
fail to roll back the kernel's state tracking with=20
pci_set_power_state(pdev, PCI_D3hot).

Since the PM core continues to track the device as D0, won't the next
suspend attempt try a D0-to-D3hot transition on the unreachable device
and trigger the exact inaccessible warning this patch is meant to fix?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814132744.5161=
05-1-reza.jelveh+git@gmail.com?part=3D1
