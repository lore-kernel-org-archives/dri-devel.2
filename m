Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF7DFC79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 10:08:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BA2F10F425;
	Thu, 10 Sep 2026 10:08:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="kuux1Pn6";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B536C10F422;
 Thu, 10 Sep 2026 10:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789034885; x=1820570885;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=57ELQZY/6YSaNa7cAB52Gwj5BqsKa034ylhG3IY3A2k=;
 b=kuux1Pn6ggCMl+fyiNkI4VKUFD7T+9RqCJsJdnvB/N8S72lvR2QZraCf
 O3wrtzUemPcX8wBhO2Wj7ftKFJCmPhqW++rEEL/SzAP8WheTSzAA5XJ1o
 dyZPrOcVyMyH2hNq5joJmXWqHFWS7x5wxN5ZVU7hUaVzHttryKcAtvAFr
 y2my+PNKhT0FfdkpKF3BLcOjV6fQoe+L/fGgaRJMsFlIDjh8DQ5IXBd8m
 l5HBIYYa8tSEFVTT87Hd5X8ASkGbVxTiJWVOvcWVUwX/v1rgUrgHk48tO
 Y5SSe1es/7vK2GXgQNHViw5O6HkHg3d9mwP1IU+PZEG9ZzsTL7Yvo0J0p w==;
X-CSE-ConnectionGUID: sdMnSs/XQwatcM6NXRPlyA==
X-CSE-MsgGUID: QL28/fSkS7ab3UgSytfZcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="93345731"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="93345731"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 03:08:05 -0700
X-CSE-ConnectionGUID: 97P/1oY7ShiO3mu6tU85bw==
X-CSE-MsgGUID: pzb/FopiRJO9i0V8gBWBRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; d="scan'208";a="301482347"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.245.193])
 ([10.245.245.193])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 03:08:03 -0700
Message-ID: <3d75cfb6dd151ddb99eccec1e2712c80bfd334ef.camel@linux.intel.com>
Subject: Re: [PATCH 02/13] drm/xe: Separate AER reset state from device wedging
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Arvind Yadav <arvind.yadav@intel.com>, intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com, 
 rodrigo.vivi@intel.com
Date: Thu, 10 Sep 2026 12:07:59 +0200
In-Reply-To: <20260827101801.1247654-3-arvind.yadav@intel.com>
References: <20260827101801.1247654-1-arvind.yadav@intel.com>
 <20260827101801.1247654-3-arvind.yadav@intel.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Thu, 2026-08-27 at 15:47 +0530, Arvind Yadav wrote:
> PCI error recovery currently uses xe->wedged.flag to block driver
> access. This mixes a temporary AER reset with a permanent device
> wedge.
>=20
> If the device wedges during AER recovery, the wedge is not seen as
> the
> first transition. The AER resume callback may then clear the flag and
> make the permanently wedged device appear usable again.
>=20
> Keep the old device blocked while slot reset removes it, and block
> the
> new device until the AER resume callback.
>=20
> The old AER path took a runtime PM reference to balance
> xe_device_wedged_fini(), which drops one when wedged.flag is set. AER
> no
> longer sets that flag, so keeping the Xe-owned reference would leak
> it.
> pcie_do_recovery() holds a PCI-core runtime PM reference across the
> error_detected, slot_reset and resume callbacks.
>=20
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
> ---
> =C2=A0drivers/gpu/drm/xe/xe_bo.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0drivers/gpu/drm/xe/xe_device.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 4 ++--
> =C2=A0drivers/gpu/drm/xe/xe_device.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 12 ++++++++++++
> =C2=A0drivers/gpu/drm/xe/xe_guc_ct.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 4 ++--
> =C2=A0drivers/gpu/drm/xe/xe_guc_pc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 10 +++++-----
> =C2=A0drivers/gpu/drm/xe/xe_guc_rc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 4 ++--
> =C2=A0drivers/gpu/drm/xe/xe_guc_submit.c=C2=A0=C2=A0=C2=A0 |=C2=A0 8 ++++=
++--
> =C2=A0drivers/gpu/drm/xe/xe_guc_tlb_inval.c |=C2=A0 8 +++++++-
> =C2=A0drivers/gpu/drm/xe/xe_pci_error.c=C2=A0=C2=A0=C2=A0=C2=A0 | 22 ++++=
+++++++-----------
> =C2=A0drivers/gpu/drm/xe/xe_sriov_pf.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 2 +-
> =C2=A010 files changed, 49 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index dde309821237..b86cd6030ed6 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
> @@ -2094,7 +2094,7 @@ static vm_fault_t xe_bo_cpu_fault(struct
> vm_fault *vmf)
> =C2=A0	int err =3D 0;
> =C2=A0	int idx;
> =C2=A0
> -	if (xe_device_wedged(xe) || !drm_dev_enter(&xe->drm, &idx))
> +	if (xe_device_io_blocked(xe) || !drm_dev_enter(&xe->drm,
> &idx))
> =C2=A0		return ttm_bo_vm_dummy_page(vmf, vmf->vma-
> >vm_page_prot);
> =C2=A0
> =C2=A0	ret =3D xe_bo_cpu_fault_fastpath(vmf, xe, bo, needs_rpm);
> diff --git a/drivers/gpu/drm/xe/xe_device.c
> b/drivers/gpu/drm/xe/xe_device.c
> index 74d566693dfd..a92e90acdf0d 100644
> --- a/drivers/gpu/drm/xe/xe_device.c
> +++ b/drivers/gpu/drm/xe/xe_device.c
> @@ -225,7 +225,7 @@ static long xe_drm_ioctl(struct file *file,
> unsigned int cmd, unsigned long arg)
> =C2=A0	struct xe_device *xe =3D to_xe_device(file_priv->minor->dev);
> =C2=A0	long ret;
> =C2=A0
> -	if (xe_device_wedged(xe))
> +	if (xe_device_io_blocked(xe))
> =C2=A0		return -ECANCELED;
> =C2=A0
> =C2=A0	ACQUIRE(xe_pm_runtime_ioctl, pm)(xe);
> @@ -243,7 +243,7 @@ static long xe_drm_compat_ioctl(struct file
> *file, unsigned int cmd, unsigned lo
> =C2=A0	struct xe_device *xe =3D to_xe_device(file_priv->minor->dev);
> =C2=A0	long ret;
> =C2=A0
> -	if (xe_device_wedged(xe))
> +	if (xe_device_io_blocked(xe))
> =C2=A0		return -ECANCELED;
> =C2=A0
> =C2=A0	ACQUIRE(xe_pm_runtime_ioctl, pm)(xe);
> diff --git a/drivers/gpu/drm/xe/xe_device.h
> b/drivers/gpu/drm/xe/xe_device.h
> index 6c4cfaebc44a..a3f876c60d76 100644
> --- a/drivers/gpu/drm/xe/xe_device.h
> +++ b/drivers/gpu/drm/xe/xe_device.h
> @@ -212,6 +212,18 @@ static inline bool xe_device_wedged(struct
> xe_device *xe)
> =C2=A0	return atomic_read(&xe->wedged.flag);
> =C2=A0}
> =C2=A0
> +/*
> + * Return true when device access must be blocked either permanently
> because
> + * the device is wedged or temporarily while PCI error recovery is
> running.
> + *
> + * Do not use this helper for one-way wedged-device decisions such
> as DMA
> + * isolation, IRQ resume suppression or recovery-method reporting.
> + */
> +static inline bool xe_device_io_blocked(struct xe_device *xe)
> +{
> +	return xe_device_wedged(xe) || xe_device_is_in_reset(xe);
> +}
> +
> =C2=A0#ifdef CONFIG_DRM_XE_DEBUG_PAGE_SIZE
> =C2=A0static inline bool xe_debug_page_size_supported(struct xe_device
> *xe)
> =C2=A0{
> diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c
> b/drivers/gpu/drm/xe/xe_guc_ct.c
> index 5c4733da385c..3c3fe4928fa2 100644
> --- a/drivers/gpu/drm/xe/xe_guc_ct.c
> +++ b/drivers/gpu/drm/xe/xe_guc_ct.c
> @@ -1062,7 +1062,7 @@ static int __guc_ct_send_locked(struct
> xe_guc_ct *ct, const u32 *action,
> =C2=A0	xe_gt_assert(gt, g2h_len || !num_g2h);
> =C2=A0	lockdep_assert_held(&ct->lock);
> =C2=A0
> -	if (xe_device_wedged(ct_to_xe(ct))) {
> +	if (xe_device_io_blocked(ct_to_xe(ct))) {
> =C2=A0		ret =3D -ENOTRECOVERABLE;
> =C2=A0		goto out;
> =C2=A0	}
> @@ -1813,7 +1813,7 @@ static int g2h_read(struct xe_guc_ct *ct, u32
> *msg, bool fast_path)
> =C2=A0	xe_gt_assert(gt, xe_guc_ct_initialized(ct));
> =C2=A0	lockdep_assert_held(&ct->fast_lock);
> =C2=A0
> -	if (xe_device_wedged(xe))
> +	if (xe_device_io_blocked(xe))
> =C2=A0		return -ENOTRECOVERABLE;
> =C2=A0
> =C2=A0	if (ct->state =3D=3D XE_GUC_CT_STATE_DISABLED)
> diff --git a/drivers/gpu/drm/xe/xe_guc_pc.c
> b/drivers/gpu/drm/xe/xe_guc_pc.c
> index 097b075bd89a..9fe397296dc4 100644
> --- a/drivers/gpu/drm/xe/xe_guc_pc.c
> +++ b/drivers/gpu/drm/xe/xe_guc_pc.c
> @@ -188,7 +188,7 @@ static int pc_action_reset(struct xe_guc_pc *pc)
> =C2=A0	int ret;
> =C2=A0
> =C2=A0	ret =3D xe_guc_ct_send(ct, action, ARRAY_SIZE(action), 0, 0);
> -	if (ret && !(xe_device_wedged(pc_to_xe(pc)) && ret =3D=3D -
> ECANCELED))
> +	if (ret && !(xe_device_io_blocked(pc_to_xe(pc)) && ret =3D=3D -
> ECANCELED))
> =C2=A0		xe_gt_err(pc_to_gt(pc), "GuC PC reset failed:
> %pe\n",
> =C2=A0			=C2=A0 ERR_PTR(ret));
> =C2=A0
> @@ -212,7 +212,7 @@ static int pc_action_query_task_state(struct
> xe_guc_pc *pc)
> =C2=A0
> =C2=A0	/* Blocking here to ensure the results are ready before
> reading them */
> =C2=A0	ret =3D xe_guc_ct_send_block(ct, action, ARRAY_SIZE(action));
> -	if (ret && !(xe_device_wedged(pc_to_xe(pc)) && ret =3D=3D -
> ECANCELED))
> +	if (ret && !(xe_device_io_blocked(pc_to_xe(pc)) && ret =3D=3D -
> ECANCELED))
> =C2=A0		xe_gt_err(pc_to_gt(pc), "GuC PC query task state
> failed: %pe\n",
> =C2=A0			=C2=A0 ERR_PTR(ret));
> =C2=A0
> @@ -235,7 +235,7 @@ static int pc_action_set_param(struct xe_guc_pc
> *pc, u8 id, u32 value)
> =C2=A0		return -EAGAIN;
> =C2=A0
> =C2=A0	ret =3D xe_guc_ct_send(ct, action, ARRAY_SIZE(action), 0, 0);
> -	if (ret && !(xe_device_wedged(pc_to_xe(pc)) && ret =3D=3D -
> ECANCELED))
> +	if (ret && !(xe_device_io_blocked(pc_to_xe(pc)) && ret =3D=3D -
> ECANCELED))
> =C2=A0		xe_gt_err(pc_to_gt(pc), "GuC PC set param[%u]=3D%u
> failed: %pe\n",
> =C2=A0			=C2=A0 id, value, ERR_PTR(ret));
> =C2=A0
> @@ -257,7 +257,7 @@ static int pc_action_unset_param(struct xe_guc_pc
> *pc, u8 id)
> =C2=A0		return -EAGAIN;
> =C2=A0
> =C2=A0	ret =3D xe_guc_ct_send(ct, action, ARRAY_SIZE(action), 0, 0);
> -	if (ret && !(xe_device_wedged(pc_to_xe(pc)) && ret =3D=3D -
> ECANCELED))
> +	if (ret && !(xe_device_io_blocked(pc_to_xe(pc)) && ret =3D=3D -
> ECANCELED))
> =C2=A0		xe_gt_err(pc_to_gt(pc), "GuC PC unset param failed:
> %pe",
> =C2=A0			=C2=A0 ERR_PTR(ret));
> =C2=A0
> @@ -1357,7 +1357,7 @@ static void xe_guc_pc_fini_hw(void *arg)
> =C2=A0	struct xe_guc_pc *pc =3D arg;
> =C2=A0	struct xe_device *xe =3D pc_to_xe(pc);
> =C2=A0
> -	if (xe_device_wedged(xe))
> +	if (xe_device_io_blocked(xe))
> =C2=A0		return;
> =C2=A0
> =C2=A0	xe_guc_pc_stop(pc);
> diff --git a/drivers/gpu/drm/xe/xe_guc_rc.c
> b/drivers/gpu/drm/xe/xe_guc_rc.c
> index 99fa127b261f..eb5ec443f7ee 100644
> --- a/drivers/gpu/drm/xe/xe_guc_rc.c
> +++ b/drivers/gpu/drm/xe/xe_guc_rc.c
> @@ -40,7 +40,7 @@ static int guc_action_setup_gucrc(struct xe_guc
> *guc, u32 control)
> =C2=A0	int ret;
> =C2=A0
> =C2=A0	ret =3D xe_guc_ct_send(&guc->ct, action, ARRAY_SIZE(action),
> 0, 0);
> -	if (ret && !(xe_device_wedged(guc_to_xe(guc)) && ret =3D=3D -
> ECANCELED))
> +	if (ret && !(xe_device_io_blocked(guc_to_xe(guc)) && ret =3D=3D
> -ECANCELED))
> =C2=A0		xe_gt_err(guc_to_gt(guc),
> =C2=A0			=C2=A0 "GuC RC setup %s(%u) failed (%pe)\n",
> =C2=A0			=C2=A0=C2=A0 control =3D=3D GUCRC_HOST_CONTROL ?
> "HOST_CONTROL" :
> @@ -73,7 +73,7 @@ static void xe_guc_rc_fini_hw(void *arg)
> =C2=A0	struct xe_device *xe =3D guc_to_xe(guc);
> =C2=A0	struct xe_gt *gt =3D guc_to_gt(guc);
> =C2=A0
> -	if (xe_device_wedged(xe))
> +	if (xe_device_io_blocked(xe))
> =C2=A0		return;
> =C2=A0
> =C2=A0	CLASS(xe_force_wake, fw_ref)(gt_to_fw(gt), XE_FW_GT);
> diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c
> b/drivers/gpu/drm/xe/xe_guc_submit.c
> index 99d8c807ff05..a307af458cf8 100644
> --- a/drivers/gpu/drm/xe/xe_guc_submit.c
> +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
> @@ -2452,7 +2452,7 @@ static int
> guc_exec_queue_wait_suspend_done(struct xe_exec_queue *q, bool blocki
> =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WAIT_COND, HZ
> * 5);
> =C2=A0	}
> =C2=A0
> -	if (!blocking && vf_recovery(guc) && !xe_device_wedged(xe))
> +	if (!blocking && vf_recovery(guc) &&
> !xe_device_io_blocked(xe))
> =C2=A0		return -EAGAIN;
> =C2=A0
> =C2=A0	if (!ret)
> @@ -2694,7 +2694,11 @@ int xe_guc_submit_reset_prepare(struct xe_guc
> *guc)
> =C2=A0
> =C2=A0void xe_guc_submit_reset_wait(struct xe_guc *guc)
> =C2=A0{
> -	wait_event(guc->ct.wq, xe_device_wedged(guc_to_xe(guc)) ||
> +	/*
> +	 * AER sets in_reset before declaring the GT wedged, which
> wakes this
> +	 * waitqueue.
> +	 */
> +	wait_event(guc->ct.wq, xe_device_io_blocked(guc_to_xe(guc))
> ||
> =C2=A0		=C2=A0=C2=A0 !xe_guc_read_stopped(guc));
> =C2=A0}
> =C2=A0
> diff --git a/drivers/gpu/drm/xe/xe_guc_tlb_inval.c
> b/drivers/gpu/drm/xe/xe_guc_tlb_inval.c
> index 046d0655122f..646e13671cd9 100644
> --- a/drivers/gpu/drm/xe/xe_guc_tlb_inval.c
> +++ b/drivers/gpu/drm/xe/xe_guc_tlb_inval.c
> @@ -34,6 +34,9 @@ static int send_tlb_inval(struct xe_guc *guc, const
> u32 *action, int len)
> =C2=A0
> =C2=A0	xe_gt_assert(gt, action[1]);	/* Seqno */
> =C2=A0
> +	if (xe_device_io_blocked(guc_to_xe(guc)))
> +		return -ECANCELED;
> +
> =C2=A0	xe_gt_stats_incr(gt, XE_GT_STATS_ID_TLB_INVAL, 1);
> =C2=A0	return xe_guc_ct_send(&guc->ct, action, len,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 G2H_LEN_DW_TLB_INVALIDATE, 1);
> @@ -69,6 +72,9 @@ static int send_tlb_inval_ggtt(struct xe_tlb_inval
> *tlb_inval, u32 seqno)
> =C2=A0	 * signals waiters.
> =C2=A0	 */
> =C2=A0
> +	if (xe_device_io_blocked(xe))
> +		return -ECANCELED;
> +
> =C2=A0	if (xe_guc_ct_enabled(&guc->ct) && guc-
> >submission_state.enabled) {
> =C2=A0		u32 action[] =3D {
> =C2=A0			XE_GUC_ACTION_TLB_INVALIDATION,
> @@ -77,7 +83,7 @@ static int send_tlb_inval_ggtt(struct xe_tlb_inval
> *tlb_inval, u32 seqno)
> =C2=A0		};
> =C2=A0
> =C2=A0		return send_tlb_inval(guc, action,
> ARRAY_SIZE(action));
> -	} else if (xe_device_uc_enabled(xe) &&
> !xe_device_wedged(xe)) {
> +	} else if (xe_device_uc_enabled(xe)) {
> =C2=A0		struct xe_mmio *mmio =3D &gt->mmio;
> =C2=A0
> =C2=A0		if (IS_SRIOV_VF(xe))
> diff --git a/drivers/gpu/drm/xe/xe_pci_error.c
> b/drivers/gpu/drm/xe/xe_pci_error.c
> index 79ce0c671549..d82256d8721f 100644
> --- a/drivers/gpu/drm/xe/xe_pci_error.c
> +++ b/drivers/gpu/drm/xe/xe_pci_error.c
> @@ -9,7 +9,6 @@
> =C2=A0#include "xe_gt.h"
> =C2=A0#include "xe_log.h"
> =C2=A0#include "xe_pci.h"
> -#include "xe_pm.h"
> =C2=A0#include "xe_printk.h"
> =C2=A0#include "xe_ras.h"
> =C2=A0#include "xe_survivability_mode.h"
> @@ -20,14 +19,15 @@ static void prepare_device_for_reset(struct
> pci_dev *pdev)
> =C2=A0	struct xe_gt *gt;
> =C2=A0	u8 id;
> =C2=A0
> +
> =C2=A0	/*
> -	 * Wedge the device to prevent userspace access but do not
> send the uevent.
> -	 * xe_device_wedged_fini() releases runtime pm if wedged
> flag is set, so acquire a runtime
> -	 * pm reference to avoid underflow.
> +	 * Block device access while PCI error recovery is in
> progress.
> +	 *
> +	 * The old runtime PM reference balanced
> xe_device_wedged_fini() while
> +	 * AER set wedged.flag. AER no longer sets that flag, and
> +	 * pcie_do_recovery() holds its own runtime PM reference
> across the
> +	 * recovery callbacks.

This is an in-code comment describing what this patch is doing. A
future code reader has no idea what "The old runtime PM reference" is.
Please keep comments involving the old pre-patch code in the commit
message.


> =C2=A0	 */
> -	if (!atomic_xchg(&xe->wedged.flag, 1))
> -		xe_pm_runtime_get_noresume(xe);
> -
> =C2=A0	xe_device_set_in_reset(xe);
> =C2=A0
> =C2=A0	for_each_gt(gt, xe, id)
> @@ -116,7 +116,6 @@ static pci_ers_result_t
> xe_pci_error_slot_reset(struct pci_dev *pdev)
> =C2=A0	 * TODO: optimize by re-initializing only the hardware state
> and re-creating
> =C2=A0	 * kernel BOs.
> =C2=A0	 */
> -	xe_device_clear_in_reset(xe);
> =C2=A0	pdev->driver->remove(pdev);
> =C2=A0	devres_release_group(&pdev->dev, xe->devres_group);
> =C2=A0
> @@ -125,8 +124,8 @@ static pci_ers_result_t
> xe_pci_error_slot_reset(struct pci_dev *pdev)
> =C2=A0
> =C2=A0	xe =3D pdev_to_xe_device(pdev);
> =C2=A0
> -	/* Wedge the device to prevent I/O operations till the
> resume callback */
> -	atomic_set(&xe->wedged.flag, 1);
> +	/* Block the new instance until the resume callback. */
> +	xe_device_set_in_reset(xe);
> =C2=A0
> =C2=A0	return PCI_ERS_RESULT_RECOVERED;
> =C2=A0}
> @@ -137,7 +136,8 @@ static void xe_pci_error_resume(struct pci_dev
> *pdev)
> =C2=A0
> =C2=A0	xe_info(xe, "PCI error: resume\n");
> =C2=A0
> -	atomic_set(&xe->wedged.flag, 0);
> +	/* Resume I/O operations. */
> +	xe_device_clear_in_reset(xe);
> =C2=A0}
> =C2=A0
> =C2=A0const struct pci_error_handlers xe_pci_error_handlers =3D {
> diff --git a/drivers/gpu/drm/xe/xe_sriov_pf.c
> b/drivers/gpu/drm/xe/xe_sriov_pf.c
> index 33bd754d138f..568b7ed7c380 100644
> --- a/drivers/gpu/drm/xe/xe_sriov_pf.c
> +++ b/drivers/gpu/drm/xe/xe_sriov_pf.c
> @@ -157,7 +157,7 @@ int xe_sriov_pf_wait_ready(struct xe_device *xe)
> =C2=A0	unsigned int id;
> =C2=A0	int err;
> =C2=A0
> -	if (xe_device_wedged(xe))
> +	if (xe_device_io_blocked(xe))
> =C2=A0		return -ECANCELED;
> =C2=A0
> =C2=A0	for_each_gt(gt, xe, id) {


/Thomas
