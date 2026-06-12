Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D876CD4F2C
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 08:24:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA38710F31F;
	Fri, 12 Jun 2026 08:24:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AmQowg6e";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AC0610F31F
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 08:24:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 75AA26001D;
 Fri, 12 Jun 2026 08:24:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100A21F000E9;
 Fri, 12 Jun 2026 08:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781252692;
 bh=s4n9V7EMGvwMOkWCX0IR/+KyNRi44ffOtWWATfLVMuE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AmQowg6eh3M1trNOrTt90T1rddr+HNr4gQb+JpUzo08ScbdkUTPn0tR3p283gPoEJ
 1tFM3yAlsUjJWgrShIHYOwRXO8C/CgJ8Mn/MzVoU7Mt7ewSGuqo+jgcjFD315F+bDD
 59s5859b13uCnateM1A3R54KFrpgsHNNGVgJQ2jjqjlqKjZraGwReWSRhTo6Hl/XSs
 FTUMivA8aFaH1GHLA3hDyxZSmwgROhSDDvlQJzPY4ZCDCXr1Bj72FV61x1yzQW+m5o
 OLeLOtbrXIlIiazszLMsZ5DOjC5LeGlq2VsAQhfLLzIPqJSX4P9lpGL4Mz8oGXmnZm
 /PpMl/VUHwVzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/6] Introduce Xe Uncorrectable Error Handling
To: "Mallesh Koujalagi" <mallesh.koujalagi@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260612080722.26726-9-mallesh.koujalagi@intel.com>
References: <20260612080722.26726-9-mallesh.koujalagi@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 08:24:51 +0000
Message-Id: <20260612082452.100A21F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [Critical] Manually calling `pdev->driver->probe()` and `remove()` in `xe=
_pci_error_slot_reset()` bypasses the device core's lifecycle and synchroni=
zation, leading to Use-After-Free, resource leaks, state corruption, and cr=
ashes.
- [High] Unbalanced `xe_device_wedged_put()` in PCI error resume path perma=
nently wedges the device.
- [High] The endpoint driver directly modifies the Upstream Switch Port (US=
P) AER configuration registers, leading to layering violations, unprotected=
 RMW race conditions, and permanently leaked hardware state modifications.
- [High] Lockless checks of the `in_reset` flag create a Time-Of-Check to T=
ime-Of-Use race with the PCI error handler, potentially causing MMIO aborts.
- [Medium] Integer overflow in page offline processing loops allows a compr=
omised firmware to trap the kernel in an infinite loop.
- [Medium] Use of C bitfields to define hardware data structures makes the =
layout compiler- and architecture-dependent.
- [Medium] Unconditional page offlining due to commented-out address fault =
handling.
--

commit 428443bc3d7fc4298f440e96ee0492972d733535
Author: Riana Tauro <riana.tauro@intel.com>
Subject: Introduce Xe Uncorrectable Error Handling

This commit introduces uncorrectable error handling for the Xe driver. It
includes PCI error handlers for recovery and reset operations. It also
integrates RAS error processing via system controller mailboxes.

Link: https://patchwork.freedesktop.org/series/160482/

> diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_g=
uc_submit.c
> --- a/drivers/gpu/drm/xe/xe_guc_submit.c
> +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
[ ... ]
> @@ -1511,7 +1511,7 @@ guc_exec_queue_timedout_job(struct drm_sched_job *d=
rm_job)
>  	 * If devcoredump not captured and GuC capture for the job is not ready
>  	 * do manual capture first and decide later if we need to use it
>  	 */
> -	if (!exec_queue_killed(q) && !xe->devcoredump.captured &&
> +	if (!xe_device_is_in_reset(xe) && !exec_queue_killed(q) && !xe->devcore=
dump.captured &&
>  	    !xe_guc_capture_get_matching_and_lock(q)) {
>  		/* take force wake before engine register manual capture */
>  		CLASS(xe_force_wake, fw_ref)(gt_to_fw(q->gt), XE_FORCEWAKE_ALL);

[Severity: High]
Could this lockless check of the in_reset flag create a race condition with
the PCI error handler?

If this worker thread evaluates xe_device_is_in_reset() as false just before
prepare_device_for_reset() sets the flag and disables the PCI device, the
worker might attempt MMIO access on a disabled device. Will this cause a
master abort or system hang?

> diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
> --- a/drivers/gpu/drm/xe/xe_pci.c
> +++ b/drivers/gpu/drm/xe/xe_pci.c
[ ... ]
> @@ -1102,6 +1104,10 @@ static int xe_pci_probe(struct pci_dev *pdev, cons=
t struct pci_device_id *ent)
>  	if (xe_display_driver_probe_defer(pdev))
>  		return -EPROBE_DEFER;
> =20
> +	devres_id =3D devres_open_group(&pdev->dev, NULL, GFP_KERNEL);
> +	if (!devres_id)
> +		return -ENOMEM;
> +

[Severity: Critical]
Is devres_open_group() intentionally left without a matching close call?

All subsequent devres allocations will be tied to this group. As seen below
in xe_pci_error_slot_reset(), this group is forcefully released, which could
leak resources if a manual probe fails.

> diff --git a/drivers/gpu/drm/xe/xe_pci_error.c b/drivers/gpu/drm/xe/xe_pc=
i_error.c
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

[Severity: High]
Does this path need to call xe_device_wedged_get() like the frozen state do=
es?

Returning PCI_ERS_RESULT_CAN_RECOVER here bypasses prepare_device_for_reset=
().
When the recovery finishes and xe_pci_error_resume() calls
xe_device_wedged_put(), it might underflow the reference count and permanen=
tly
wedge the device.

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

[Severity: Critical]
Are we bypassing the Linux device model here? Directly calling
pdev->driver->remove() and probe() misses devres lifecycle management,
device links, PM runtime, and sysfs synchronization.

If the manual probe() fails, it seems like we leak all newly allocated
devm_ resources since the driver core is not involved. Would a later
normal driver unbind cause a use-after-free by calling remove on a
partially initialized device?

> diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
> --- a/drivers/gpu/drm/xe/xe_ras.c
> +++ b/drivers/gpu/drm/xe/xe_ras.c
[ ... ]
> +static int handle_page_offline(struct xe_device *xe, u64 page_address, b=
ool send_offline_cmd)
> +{
> +	enum xe_ras_page_action action;
> +	int ret =3D 0;
> +
> +	if (!IS_ALIGNED(page_address, XE_PAGE_SIZE)) {
> +		xe_err(xe, "sysctrl: Unaligned page address: 0x%llx\n", page_address);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * TODO: Call function to handle address fault
> +	 * ret =3D xe_ttm_vram_handle_addr_fault(xe, page_address);
> +	 */
> +
> +	/*
> +	 * Handle return code from address fault handling function:
> +	 *  0: Address is valid and can be offlined
> +	 * -EIO: Address belongs to a critical BO that cannot be offlined
> +	 * -EOPNOTSUPP: Address is valid and can be offlined but user policy is=
 not to offline
> +	 *
> +	 * For any other non-zero error code, skip offlining.
> +	 */
> +
> +	switch (ret) {
> +	case 0:
> +		action =3D XE_RAS_PAGE_ACTION_OFFLINE;
> +		break;

[Severity: Medium]
Is it intended to leave the address fault handling function commented out?

Because ret remains 0, the switch statement will unconditionally execute the
success case and set the action to XE_RAS_PAGE_ACTION_OFFLINE. Could this
instruct the firmware to offline memory pages even if they hold critical
kernel structures, potentially crashing the system?

[ ... ]
> +static void get_queued_pages(struct xe_device *xe)
> +{
[ ... ]
> +		for (i =3D 0; i < response.pages_returned && i < XE_RAS_NUM_PAGES; i++)
> +			handle_page_offline(xe, response.page_addresses[i], true);
> +
> +		count +=3D response.pages_returned;
> +		if (!response.pages_returned)
> +			break;
> +
> +		if (count > response.total_pages) {

[Severity: Medium]
Can the addition to count overflow?

Both count and response.pages_returned are 32-bit unsigned integers. If the
system controller firmware returns a crafted value like 0xFFFFFFFF, count
could wrap around to a small value, bypassing the safety check. Since the
loop lacks an explicit maximum iteration limit, could this trap the kernel
thread in an infinite loop?

[ ... ]
> +static void aer_unmask_and_downgrade_internal_error(struct xe_device *xe)
> +{
> +	struct pci_dev *pdev =3D to_pci_dev(xe->drm.dev);
> +	u32 aer_uncorr_mask, aer_uncorr_sev, aer_uncorr_status;
> +	struct pci_dev *usp;
> +	u16 aer_cap;
[ ... ]
> +	/* Initialize Uncorrectable Error Severity Register */
> +	pci_read_config_dword(usp, aer_cap + PCI_ERR_UNCOR_SEVER, &aer_uncorr_s=
ev);
> +	aer_uncorr_sev &=3D ~PCI_ERR_UNC_INTN;
> +	pci_write_config_dword(usp, aer_cap + PCI_ERR_UNCOR_SEVER, aer_uncorr_s=
ev);

[Severity: High]
Is it safe for the endpoint driver to directly perform read-modify-write
operations on the Upstream Switch Port AER configuration registers?

Since the upstream bridge is owned by the PCI core and pcieport service
driver, wouldn't these unprotected operations race with concurrent updates
from the AER core or userspace? Also, since these modifications aren't
reverted during driver unload or after reset, will they permanently alter
the behavior of the slot?

> diff --git a/drivers/gpu/drm/xe/xe_ras_types.h b/drivers/gpu/drm/xe/xe_ra=
s_types.h
> --- a/drivers/gpu/drm/xe/xe_ras_types.h
> +++ b/drivers/gpu/drm/xe/xe_ras_types.h
[ ... ]
> +/**
> + * struct xe_ras_soc_error_source - Source of SoC error
> + */
> +struct xe_ras_soc_error_source {
> +	/** @csc: CSC */
> +	u32 csc:1;
> +	/** @ieh: IEH (Integrated Error Handler) */
> +	u32 ieh:1;
> +	/** @reserved: Reserved for future use */
> +	u32 reserved:30;
> +} __packed;

[Severity: Medium]
Since this structure maps directly to System Controller Mailbox payloads, is
it safe to use C bitfields here?

The packing order of bitfields is compiler-defined and dependent on
architecture endianness. Could this result in incorrect parsing of hardware
error sources on big-endian architectures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612080722.2672=
6-8-mallesh.koujalagi@intel.com?part=3D1
