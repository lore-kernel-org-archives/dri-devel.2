Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3875CDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:54:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57D1B10ECB4;
	Tue, 23 Jun 2026 20:54:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AClXy9zI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43F5C10ECB4
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:54:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2A8DD43629;
 Tue, 23 Jun 2026 20:54:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2401F000E9;
 Tue, 23 Jun 2026 20:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782248072;
 bh=pPyEhKBmv0BIWA0TkijnZwXA3h71wiiB9FHxJxoDmmY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AClXy9zIDOcdemuNDla6T+O9IahFjd56MmbmOikz+5zUS/vP2hjy+KfMf8wdFOSKY
 WylI0nJ6Yjk/3lu8gjxwHBjtL8yjNreSLoPcc6eyv4Ls6JaU+bSfTNeTdnqLNmMZfu
 K+tpwcY3weKLPDUANn4t7OdE7HIEYSM7v3bfPs2XlLh4lAN28N1x5xNcHvgSIDZrSu
 /T5Z1SZjHYQioQxbJj1u20QgnEOvCCL7Nz/usrsMRxrKjSAzldzqDQQkcTIGhLZGyr
 3ZlhCcjp9C5r7CIazdjkbjd6mKBO8l5hWnl5yUJI86KC6LEEbeejCf307OBOxx6uAL
 9AlKq1YKjt8Cg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/6] Introduce Xe Uncorrectable Error Handling
To: "Mallesh Koujalagi" <mallesh.koujalagi@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260622131458.144873-9-mallesh.koujalagi@intel.com>
References: <20260622131458.144873-8-mallesh.koujalagi@intel.com>
 <20260622131458.144873-9-mallesh.koujalagi@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 20:54:31 +0000
Message-Id: <20260623205431.ED2401F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:
- [High] Manual invocation of driver remove and probe callbacks in the PCI =
error slot_reset handler bypasses the driver core.
- [High] Unclosed devres group captures unintended resources and its forcef=
ul release causes Use-After-Free.
- [High] Endpoint driver directly modifies AER registers of the Upstream Sw=
itch Port via unsynchronized RMW.
- [High] Unbalanced `xe_device_wedged_put()` during non-fatal PCI error rec=
overy causes refcount underflow and permanently wedges the device.
- [High] Clearing `xe->in_reset` prematurely and manually destroying devres=
 causes TDR and async workers to dereference NULL MMIO pointers.
- [High] Unsynchronized checks of `xe_device_is_in_reset()` cause Time-of-C=
heck to Time-of-Use (TOCTOU) races with PCI reset.
- [High] Calling `pci_match_id()` manually in `xe_pci_error_slot_reset()` r=
eturns NULL for devices bound via dynamic IDs, causing a NULL pointer deref=
erence.
- [High] `prepare_device_for_reset()` disables the PCI device without cance=
lling or flushing active GT reset workers, risking MMIO timeouts.
- [Medium] Flawed accumulation logic and missing flood limits in `get_queue=
d_pages` and `get_offlined_list` cause premature aborts or infinite loops.
- [Medium] Double removal of sysfs group `survivability_info_group` via bot=
h `devm_device_add_group` and `xe_survivability_mode_fini`.
--

commit 5c76039736fbbd64a08449cce81a6b27917ce366
Author: Riana Tauro <riana.tauro@intel.com>

Introduce Xe Uncorrectable Error Handling

This commit introduces uncorrectable error handling for the Xe driver, addi=
ng
PCI error handlers to recover from AER and system controller errors. It=20
includes device wedging logic and hooks into the PCI error recovery flow.

> diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
> index c9d4fb6c4ff6a..352e7eb008d90 100644
> --- a/drivers/gpu/drm/xe/xe_pci.c
> +++ b/drivers/gpu/drm/xe/xe_pci.c
> @@ -1078,6 +1079,7 @@ static int xe_pci_probe(struct pci_dev *pdev, const=
 struct pci_device_id *ent)
>  	const struct xe_device_desc *desc =3D (const void *)ent->driver_data;
>  	const struct xe_subplatform_desc *subplatform_desc;
>  	struct xe_device *xe;
> +	void *devres_id;
>  	int err;
> =20
>  	subplatform_desc =3D find_subplatform(desc, pdev->device);
> @@ -1105,6 +1107,10 @@ static int xe_pci_probe(struct pci_dev *pdev, cons=
t struct pci_device_id *ent)
>  	if (xe_display_driver_probe_defer(pdev))
>  		return -EPROBE_DEFER;
> =20
> +	devres_id =3D devres_open_group(&pdev->dev, NULL, GFP_KERNEL);
> +	if (!devres_id)
> +		return -ENOMEM;
> +

[Severity: High]
Does this code capture all future devm allocations unintentionally?

A devres group is opened here via devres_open_group() but never closed.
Consequently, all subsequent devres allocations by the driver and subsystem
will be silently added to this group. When devres_release_group() is manual=
ly
called later in xe_pci_error_slot_reset(), it forcefully destroys all
devm-managed resources, including the drm_device memory. If userspace holds
an open FD to the DRM device, could subsequent IOCTLs or FD closures access
the freed memory and cause a use-after-free?

> diff --git a/drivers/gpu/drm/xe/xe_pci_error.c b/drivers/gpu/drm/xe/xe_pc=
i_error.c
> new file mode 100644
> index 0000000000000..b08601f470d63
> --- /dev/null
> +++ b/drivers/gpu/drm/xe/xe_pci_error.c
> @@ -0,0 +1,135 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright =C2=A9 2026 Intel Corporation
> + */
> +
> +#include <linux/pci.h>
> +
> +#include "xe_device.h"
> +#include "xe_gt.h"
> +#include "xe_pci.h"
> +#include "xe_printk.h"
> +#include "xe_ras.h"
> +#include "xe_survivability_mode.h"
> +
> +static void prepare_device_for_reset(struct pci_dev *pdev)
> +{
> +	struct xe_device *xe =3D pdev_to_xe_device(pdev);
> +	struct xe_gt *gt;
> +	u8 id;
> +
> +	xe_device_set_in_reset(xe);
> +
> +	/* Wedge the device to prevent userspace access during reset */
> +	xe_device_wedged_get(xe);
> +
> +	for_each_gt(gt, xe, id)
> +		xe_gt_declare_wedged(gt);
> +
> +	pci_disable_device(pdev);
> +}

[Severity: High]
Are active GT reset workers properly synchronized before disabling the devi=
ce?

This calls pci_disable_device(pdev) while gt_reset_worker or other
hardware-accessing work items may be actively executing. Although
xe_device_set_in_reset() is called, this only prevents new workers from
starting.

If a worker is actively polling MMIO registers when pci_disable_device drops
the memory decode enable bit, the MMIO reads will instantly return 0xFFFFFF=
FF.
Can this cause polling loops to time out, delay the reset process, or trigg=
er
unexpected hardware warnings?

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
Will this cause a refcount underflow for non-fatal errors?

When receiving pci_channel_io_normal, this returns PCI_ERS_RESULT_CAN_RECOV=
ER
without calling prepare_device_for_reset(), which means xe_device_wedged_ge=
t()
is never called.

If the subsequent mmio_enabled handler successfully recovers the error, the
PCI core directly invokes xe_pci_error_resume(), which unconditionally calls
xe_device_wedged_put(xe).

Could this underflow the xe->wedged.ref atomic counter to -1, permanently
wedging the device and incorrectly blocking all subsequent IOCTLs and GuC
submissions?

[ ... ]

> +static pci_ers_result_t xe_pci_error_slot_reset(struct pci_dev *pdev)
> +{
> +	const struct pci_device_id *ent =3D pci_match_id(pdev->driver->id_table=
, pdev);
> +	struct xe_device *xe =3D pdev_to_xe_device(pdev);

[Severity: High]
Could this return NULL for devices bound via dynamic IDs?

This retrieves the device ID table entry by manually calling pci_match_id(),
which exclusively searches the driver's statically compiled id_table. If the
device was bound using the dynamic ID mechanism via sysfs new_id,
pci_match_id() returns NULL.

> +
> +	xe_err(xe, "PCI error: slot reset\n");
> +
> +	pci_restore_state(pdev);
> +
> +	if (pci_enable_device(pdev)) {
> +		xe_err(xe, "Cannot re-enable PCI device after reset\n");
> +		return PCI_ERS_RESULT_DISCONNECT;
> +	}
> +
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

[Severity: High]
Does clearing xe->in_reset prematurely cause a race condition with async
workers?

xe_device_clear_in_reset(xe) is called immediately before tearing down the
driver and calling devres_release_group(). The in_reset flag is meant to
prevent asynchronous workers (like the TDR timer) from accessing hardware
during reset.

By clearing it too early, TDR workers will pass the !xe_device_is_in_reset(=
xe)
check and execute concurrently with driver teardown. Since
devres_release_group() synchronously unmaps MMIO, could a racing TDR worker
attempt to read hardware registers using unmapped pointers (for example,
during xe_devcoredump()), leading to a panic?

> +
> +	if (pdev->driver->probe(pdev, ent))
> +		return PCI_ERS_RESULT_DISCONNECT;

[Severity: High]
Is it safe to pass a potentially NULL 'ent' pointer to the probe function?

If pci_match_id() returned NULL earlier, passing it here will cause
xe_pci_probe() to immediately dereference ent->driver_data, resulting in a
deterministic NULL pointer dereference.

[Severity: High]
Does manually invoking the remove and probe callbacks bypass the Linux
driver core?

Directly calling pdev->driver->remove(pdev) and pdev->driver->probe(pdev, e=
nt)
bypasses the unbind/bind state machine of the Linux driver core. This
detaches the device from proper lifecycle management.

If the manual probe fails, devres is not automatically cleaned up.
Furthermore, the driver core still considers the device bound. Upon eventual
module unload or unbind, the driver core will execute remove() a second time
on the already-freed xe structure, potentially resulting in a use-after-free
or double-free regression.

> diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_g=
uc_submit.c
> index 9458bf477fa6e..12416bfa32557 100644
> --- a/drivers/gpu/drm/xe/xe_guc_submit.c
> +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
> @@ -1532,7 +1532,7 @@ guc_exec_queue_timedout_job(struct drm_sched_job *d=
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
Is there a time-of-check to time-of-use (TOCTOU) race condition here?

Asynchronous workers rely on the atomic check xe_device_is_in_reset(xe) to
avoid interacting with hardware during PCI error recovery, but this flag is
checked without holding any synchronization lock.

Immediately after the worker verifies the device is not in reset, the PCI
error handler could concurrently invoke prepare_device_for_reset(), setting
the flag and disabling the PCI device. The worker would then blindly proceed
to access MMIO or manipulate firmware state on a disabled device. Could this
cause MMIO timeouts or undefined hardware behavior?

> diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
> index 44f4e1a3455b7..d6db0e98586fe 100644
> --- a/drivers/gpu/drm/xe/xe_ras.c
> +++ b/drivers/gpu/drm/xe/xe_ras.c
> @@ -131,6 +126,305 @@ static inline const char *comp_to_str(u8 component)
>  	return xe_ras_components[component];
>  }
> =20
> +static int send_page_offline(struct xe_device *xe, enum xe_ras_page_acti=
on action, u64 page_address)

[ ... ]

> +static void get_queued_pages(struct xe_device *xe)
> +{
> +	struct xe_sysctrl_mailbox_command command =3D {0};
> +	struct xe_ras_page_offline_queue response =3D {0};
> +	u32 count =3D 0;
> +	size_t rlen;
> +	int ret, i;
> +
> +	/* Supported only on platforms with system controller */
> +	if (!xe->info.has_sysctrl)
> +		return;
> +
> +	xe_sysctrl_create_command(&command, XE_SYSCTRL_GROUP_GFSP,
> +				  XE_SYSCTRL_CMD_GET_OFFLINE_QUEUE, NULL, 0, &response,
> +				  sizeof(response));
> +
> +	do {
> +		memset(&response, 0, sizeof(response));
> +
> +		ret =3D xe_sysctrl_send_command(&xe->sc, &command, &rlen);
> +		if (ret) {
> +			xe_err(xe, "sysctrl: failed to get page offline queue %d\n", ret);
> +			return;
> +		}
> +
> +		if (rlen !=3D sizeof(response)) {
> +			xe_err(xe, "sysctrl: unexpected page offline queue response length %z=
u (expected %zu)\n",
> +			       rlen, sizeof(response));
> +			return;
> +		}
> +
> +		for (i =3D 0; i < response.pages_returned && i < XE_RAS_NUM_PAGES; i++)
> +			handle_page_offline(xe, response.page_addresses[i], true);
> +
> +		count +=3D response.pages_returned;
> +		if (!response.pages_returned)
> +			break;
> +
> +		if (count > response.total_pages) {
> +			xe_err(xe, "sysctrl: Pages returned from queue exceed total pages %u,=
 returned %u\n",
> +			       response.total_pages, count);
> +			return;
> +		}
> +	} while (response.additional_data);

[Severity: Medium]
Could the accumulation logic here lead to a premature abort or infinite loo=
p?

The loop monotonically accumulates response.pages_returned into count, and
compares it against response.total_pages. If the firmware concurrently upda=
tes
total_pages to a smaller value as pages are dequeued, this check could fals=
ely
trigger and prematurely abort the recovery.

Additionally, there is no maximum iteration limit (like
XE_SYSCTRL_FLOOD_LIMIT). If a buggy firmware implementation keeps setting
additional_data =3D 1 indefinitely, could this force the kernel into an inf=
inite
loop or cause the u32 count to overflow?

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
> +
> +	aer_cap =3D pci_find_ext_capability(usp, PCI_EXT_CAP_ID_ERR);
> +	if (!aer_cap) {
> +		dev_info(&usp->dev, "AER capability unavailable\n");
> +		return;
> +	}
> +
> +	/*
> +	 * Clear any stale Uncorrectable Internal Error Status event in Uncorre=
ctable Error
> +	 * Status Register.
> +	 */
> +	pci_read_config_dword(usp, aer_cap + PCI_ERR_UNCOR_STATUS, &aer_uncorr_=
status);
> +	if (aer_uncorr_status & PCI_ERR_UNC_INTN)
> +		pci_write_config_dword(usp, aer_cap + PCI_ERR_UNCOR_STATUS, PCI_ERR_UN=
C_INTN);
> +
> +	/*
> +	 * All errors are steered to USP which is a PCIe AER Compliant device.
> +	 * Downgrade all the errors to non-fatal to prevent PCIe bus driver
> +	 * from triggering a Secondary Bus Reset (SBR). This allows error
> +	 * detection, containment and recovery in the driver.
> +	 *
> +	 * The Uncorrectable Error Severity Register has the 'Uncorrectable
> +	 * Internal Error Severity' set to fatal by default. Set this to
> +	 * non-fatal and unmask the error.
> +	 */
> +
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

[Severity: High]
Is it safe for the endpoint driver to directly modify AER registers of the
Upstream Switch Port using an unsynchronized read-modify-write sequence?

Retrieving the parent Upstream Switch Port (USP) device and directly modify=
ing
its AER Configuration space bypasses the pcieport driver which manages it.

Because the modification uses an unlocked read-modify-write sequence,
concurrent probing of multiple endpoint functions or concurrent AER event
handling by the PCI core could result in lost updates and permanently
corrupted AER configurations on the PCIe switch.

> diff --git a/drivers/gpu/drm/xe/xe_survivability_mode.c b/drivers/gpu/drm=
/xe/xe_survivability_mode.c
> index 427afd144f3ac..4c506027fa94c 100644
> --- a/drivers/gpu/drm/xe/xe_survivability_mode.c
> +++ b/drivers/gpu/drm/xe/xe_survivability_mode.c
> @@ -296,7 +304,8 @@ static int create_survivability_sysfs(struct pci_dev =
*pdev)
>  	if (ret)
>  		return ret;
> =20
> -	if (check_boot_failure(xe)) {
> +	/* Survivability info is not required if enabled via configfs */
> +	if (!xe_configfs_get_survivability_mode(pdev)) {
>  		ret =3D devm_device_add_group(dev, &survivability_info_group);
>  		if (ret)
>  			return ret;

[Severity: Medium]
Will this result in a double-removal of the sysfs group?

The survivability_info_group is registered using devm_device_add_group(),
which sets up an automatic devres cleanup action. Additionally,
xe_survivability_mode_fini() is registered via devm_add_action_or_reset(),
which calls device_remove_group() for the exact same group.

During device teardown, devres executes the automatically added
devm_device_remove_group first. It then executes xe_survivability_mode_fini,
which removes the group again. Furthermore, if the configfs check prevents =
the
group from being added initially, xe_survivability_mode_fini will still
unconditionally attempt to remove it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622131458.1448=
73-8-mallesh.koujalagi@intel.com?part=3D1
