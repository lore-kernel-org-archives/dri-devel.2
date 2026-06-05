Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0711DCD6E79
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 12:43:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CE0C112B01;
	Fri,  5 Jun 2026 12:43:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="f9UDTUpO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D2E8112B01
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 12:43:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DA75140D73;
 Fri,  5 Jun 2026 12:43:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F0D1F00893;
 Fri,  5 Jun 2026 12:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780663391;
 bh=ARYEBDCkr8JMTn9F9phrXMQ23eYjEY/Z/c085UPAM+0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=f9UDTUpOVkmIc0vnv5eAdFmV7mXAxn6aCDdTbofAw16tjIztgQAw83sANK2QzFpcC
 W+uwC41LCiGfx1zJAdAKhArBJVVXtE0JNtCrweIdQFh/hKiRs/mX+WbtOTe623Eqop
 FVg0c+K+iV0P5ZaK4p841WO4JUdpOQP37jI6bDyTrUk0GCErwAV3yprtlQKWi+Y8Ax
 xIFEXp2hBllK7OddXhXptAdBuHS6PhUKwJZRLB5S/bi34VKGf6WPRaMExRVWG9e9uJ
 8hEzcQjYhwaAoGdSr4njPcjvKq+zZCRh+4+b3yWRgKvmjMqE6DkSnhQ0nTZEDdIVYA
 j4Q3sNw7o9ryg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/6] Introduce Xe Uncorrectable Error Handling
To: "Mallesh Koujalagi" <mallesh.koujalagi@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260605122544.1021695-9-mallesh.koujalagi@intel.com>
References: <20260605122544.1021695-9-mallesh.koujalagi@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 12:43:11 +0000
Message-Id: <20260605124311.A8F0D1F00893@smtp.kernel.org>
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
- [High] Bypassing the Linux driver core by manually invoking probe and rem=
ove callbacks causes Use-After-Free on failure.
- [High] Unbalanced decrement of the `xe->wedged.ref` counter incorrectly p=
ermanently wedges the device after a non-fatal error recovery.
- [High] Unprotected Read-Modify-Write of Upstream Switch Port (USP) PCIe A=
ER registers causes race conditions and corrupts switch state.
- [Medium] Unbounded firmware query loops in `get_queued_pages()` and `get_=
offlined_list()` allow a malfunctioning sysctrl firmware to hang the kernel.
--

commit 1dea0dcd39b5b10ff25f34fd2fa55710387abdc7
Author: Riana Tauro <riana.tauro@intel.com>
Subject: Introduce Xe Uncorrectable Error Handling

This patch introduces PCI error handling to the Xe driver to process
and recover from hardware and firmware errors. It queries the system
controller for RAS error details and handles device teardown and re-probe
sequences during slot resets.

Link: https://patchwork.freedesktop.org/series/160482/

> diff --git a/drivers/gpu/drm/xe/xe_pci_error.c b/drivers/gpu/drm/xe/xe_pc=
i_error.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/xe/xe_pci_error.c
[ ... ]
> +static pci_ers_result_t xe_pci_error_detected(struct pci_dev *pdev, pci_=
channel_state_t state)
> +{
> +	struct xe_device *xe =3D pdev_to_xe_device(pdev);
> +
> +	xe_err(xe, "PCI error: detected state =3D %u\n", state);
> +
> +	if (state =3D=3D pci_channel_io_perm_failure)
> +		return PCI_ERS_RESULT_DISCONNECT;
> +
> +	/* If the device is already wedged or in survivability mode, do not att=
empt recovery */
> +	if (xe_survivability_mode_is_boot_enabled(xe) || xe_device_wedged(xe))
> +		return PCI_ERS_RESULT_DISCONNECT;
> +
> +	switch (state) {
> +	case pci_channel_io_normal:
> +		return PCI_ERS_RESULT_CAN_RECOVER;
[ ... ]
> +static pci_ers_result_t xe_pci_error_slot_reset(struct pci_dev *pdev)
> +{
[ ... ]
> +	/*
> +	 * Secondary Bus Reset causes all VRAM state to be lost along with
> +	 * hardware state. As an initial step, re-probe the device to
> +	 * re-initialize the driver and hardware.
> +	 * TODO: optimize by re-initializing only the hardware state and re-cre=
ating
> +	 * kernel BOs.
> +	 */
> +	xe_device_clear_in_reset(xe);
> +	pdev->driver->remove(pdev);
> +	devres_release_group(&pdev->dev, xe->devres_group_id);
> +
> +	if (pdev->driver->probe(pdev, ent))
> +		return PCI_ERS_RESULT_DISCONNECT;

[Severity: High]
Can this manual driver teardown cause a use-after-free?

If pdev->driver->probe() fails before updating the driver data pointer,
pdev->dev.driver_data will remain pointing to the memory freed by
devres_release_group().

The PCI core might later call xe_pci_remove(), which will dereference
this stale pointer. Would it be safer to avoid manually calling driver
lifecycle callbacks?

> +
> +	xe =3D pdev_to_xe_device(pdev);
> +
> +	/* Wedge the device to prevent I/O operations till the resume callback =
*/
> +	xe_device_wedged_get(xe);
> +
> +	return PCI_ERS_RESULT_RECOVERED;
> +}
> +
> +static void xe_pci_error_resume(struct pci_dev *pdev)
> +{
> +	struct xe_device *xe =3D pdev_to_xe_device(pdev);
> +
> +	xe_err(xe, "PCI error: resume\n");
> +
> +	/* Resume I/O operations */
> +	xe_device_wedged_put(xe);

[Severity: High]
Does this unconditional put cause an underflow when recovering from non-fat=
al
errors?

In xe_pci_error_detected(), the pci_channel_io_normal path returns
PCI_ERS_RESULT_CAN_RECOVER without calling prepare_device_for_reset(), so
the wedged refcount is never incremented.

When xe_pci_error_resume() is later called, this put will decrement the
counter to -1, which incorrectly evaluates as true in xe_device_wedged()
and permanently wedges the device.

> +}
> diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/xe/xe_ras.c
[ ... ]
> +static void get_queued_pages(struct xe_device *xe)
> +{
> +	struct xe_sysctrl_mailbox_command command =3D {0};
> +	struct xe_ras_page_offline_queue response =3D {0};
> +	u32 count =3D 0;
> +	size_t rlen;
> +	int ret, i;
[ ... ]
> +	do {
> +		memset(&response, 0, sizeof(response));
> +
> +		ret =3D xe_sysctrl_send_command(&xe->sc, &command, &rlen);
[ ... ]
> +	} while (response.additional_data);

[Severity: Medium]
Could a malfunctioning sysctrl firmware cause a soft lockup here?

The loop relies entirely on the firmware's additional_data flag and
total_pages limit. Unlike xe_ras_process_errors() which enforces an
XE_SYSCTRL_FLOOD_LIMIT, this loop appears to lack a driver-enforced
iteration ceiling.

> +}
> +
> +static void get_offlined_list(struct xe_device *xe)
> +{
> +	struct xe_sysctrl_mailbox_command command =3D {0};
> +	struct xe_ras_page_offline_list response =3D {0};
> +	u32 count =3D 0;
> +	size_t rlen;
> +	int ret, i;
[ ... ]
> +	do {
> +		memset(&response, 0, sizeof(response));
> +
> +		ret =3D xe_sysctrl_send_command(&xe->sc, &command, &rlen);
[ ... ]
> +	} while (response.additional_data);

[Severity: Medium]
Is there a similar risk of a soft lockup in this loop if the firmware
continuously returns additional_data?

> +}
[ ... ]
> +static void aer_unmask_and_downgrade_internal_error(struct xe_device *xe)
> +{
> +	struct pci_dev *pdev =3D to_pci_dev(xe->drm.dev);
> +	u32 aer_uncorr_mask, aer_uncorr_sev, aer_uncorr_status;
> +	struct pci_dev *usp;
> +	u16 aer_cap;
> +
> +	usp =3D find_usp_dev(pdev);
> +	if (!usp)
> +		return;
[ ... ]
> +	/* Initialize Uncorrectable Error Severity Register */
> +	pci_read_config_dword(usp, aer_cap + PCI_ERR_UNCOR_SEVER, &aer_uncorr_s=
ev);
> +	aer_uncorr_sev &=3D ~PCI_ERR_UNC_INTN;
> +	pci_write_config_dword(usp, aer_cap + PCI_ERR_UNCOR_SEVER, aer_uncorr_s=
ev);
> +
> +	/* Initialize Uncorrectable Error Mask Register */
> +	pci_read_config_dword(usp, aer_cap + PCI_ERR_UNCOR_MASK, &aer_uncorr_ma=
sk);
> +	aer_uncorr_mask &=3D ~PCI_ERR_UNC_INTN;
> +	pci_write_config_dword(usp, aer_cap + PCI_ERR_UNCOR_MASK, aer_uncorr_ma=
sk);
> +
> +	pci_save_state(usp);

[Severity: High]
Can this read-modify-write sequence corrupt the switch state if multiple
endpoints probe concurrently?

The upstream switch port is a shared resource, and modifying its AER
capability registers without synchronization could lead to race conditions
when other child devices (such as SR-IOV VFs) execute this same path.

> +	dev_dbg(&usp->dev, "Uncorrectable Internal Errors downgraded and unmask=
ed\n");
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605122544.1021=
695-8-mallesh.koujalagi@intel.com?part=3D1
