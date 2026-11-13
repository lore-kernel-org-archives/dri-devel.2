Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDB6606B5ED
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YdgqGTca
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76C7010EC40;
	Fri, 13 Nov 2026 16:07:47 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3824810EC40
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 16:07:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1C35B40770;
 Fri, 13 Nov 2026 16:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C471F000C4;
 Fri, 13 Nov 2026 16:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794586061;
 bh=QHh7M6hi+j7VinMepO3+M2pW5ddOGV1/ZUU8GAVUNCM=;
 h=Date:From:To:Cc:Subject;
 b=YdgqGTcaRO1W9qPmLtOqUOfcO+iL0UCnCAnvrfoaa2rx2RifNQPr2NCmrFef9j4rt
 akcEf4EE8DBP47gZpo54clx0aZZ5CTnuOeP/OwZfwfCa2+vI9MJnyGbjUPnAEZamGx
 J3/bw/PZpdnEjGZzfgbCksgI7/Cf8gSvAomfx4qib1JftCq11M2mP9jfAyUVuqVlXm
 i/mMqznJ7qbcf4hAt8qRgN2/pOSR8IOFbDdMCLKRjLfBQ0rmPGrFu0r4BXMVtbRSE/
 OcUFF7gcIIpzGqFgpfywUeQ0nac3wsLbx7rPUvsxU07rlt6HzsSK1uEy+QAaPwRuW/
 TVxVVfpvywIxw==
Date: Fri, 13 Nov 2026 16:07:37 +0000
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the drm tree with the drm-fixes tree
Message-ID: <avc1ycKeEb7l7eTT@sirena.org.uk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8TtJXYIZ1PubQcZP"
Content-Disposition: inline
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--8TtJXYIZ1PubQcZP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got conflicts in:

  drivers/gpu/drm/xe/xe_amc.c
  drivers/gpu/drm/xe/xe_configfs.h
  drivers/gpu/drm/xe/xe_device.c
  drivers/gpu/drm/xe/xe_device.h
  drivers/gpu/drm/xe/xe_device_types.h
  drivers/gpu/drm/xe/xe_drm_ras.c
  drivers/gpu/drm/xe/xe_gsc.c
  drivers/gpu/drm/xe/xe_gt.c
  drivers/gpu/drm/xe/xe_gt_sriov_vf.c
  drivers/gpu/drm/xe/xe_guc_submit.c
  drivers/gpu/drm/xe/xe_hwmon.c
  drivers/gpu/drm/xe/xe_late_bind_fw.c
  drivers/gpu/drm/xe/xe_mert.c
  drivers/gpu/drm/xe/xe_pat.c
  drivers/gpu/drm/xe/xe_pci.c
  drivers/gpu/drm/xe/xe_pci_error.c
  drivers/gpu/drm/xe/xe_pm.c
  drivers/gpu/drm/xe/xe_ras.c
  drivers/gpu/drm/xe/xe_survivability_mode.c

between commits from the drm-fixes tree and commits from the drm tree
which it didn't seem worthwhile to identify :/ .

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --git a/drivers/gpu/drm/xe/xe_amc.c b/drivers/gpu/drm/xe/xe_amc.c
index d6fe59669a74b..37694e34271a1 100644
--- a/drivers/gpu/drm/xe/xe_amc.c
+++ b/drivers/gpu/drm/xe/xe_amc.c
@@ -20,6 +20,7 @@
 #include "xe_i2c.h"
 #include "xe_mmio.h"
 #include "xe_pm.h"
+#include "xe_wedge.h"
=20
 /**
  * DOC: Add-In Management Controller (AMC)
@@ -165,8 +166,8 @@ static void xe_amc_work(struct work_struct *work)
 	case AMC_ALERT_OOB_RESET:
 	case AMC_ALERT_CATERR:
 		dev_warn(amc->i2c->drm_dev, "AMC Alert: %s\n", amc_alert[alert_reason]);
-		xe_device_declare_wedged(i2c_client_to_xe_device(client),
-					 DRM_WEDGE_RECOVERY_REBIND | DRM_WEDGE_RECOVERY_BUS_RESET);
+		xe_wedge_declare(i2c_client_to_xe_device(client),
+				 DRM_WEDGE_RECOVERY_REBIND | DRM_WEDGE_RECOVERY_BUS_RESET);
 		break;
 	default:
 		dev_warn(amc->i2c->drm_dev, "unknown AMC alert: %d\n", alert_reason);
diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index c41533644c928..273e2c45fea9b 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -81,6 +81,7 @@
 #include "xe_vsec.h"
 #include "xe_wait_user_fence.h"
 #include "xe_wa.h"
+#include "xe_wedge.h"
=20
 #include <generated/xe_device_wa_oob.h>
 #include <generated/xe_wa_oob.h>
@@ -238,7 +239,7 @@ static long xe_drm_ioctl(struct file *file, unsigned in=
t cmd, unsigned long arg)
 	struct xe_device *xe =3D to_xe_device(file_priv->minor->dev);
 	long ret;
=20
-	if (xe_device_wedged(xe))
+	if (xe_wedged(xe))
 		return -ECANCELED;
=20
 	ACQUIRE(xe_pm_runtime_ioctl, pm)(xe);
@@ -256,7 +257,7 @@ static long xe_drm_compat_ioctl(struct file *file, unsi=
gned int cmd, unsigned lo
 	struct xe_device *xe =3D to_xe_device(file_priv->minor->dev);
 	long ret;
=20
-	if (xe_device_wedged(xe))
+	if (xe_wedged(xe))
 		return -ECANCELED;
=20
 	ACQUIRE(xe_pm_runtime_ioctl, pm)(xe);
@@ -373,6 +374,9 @@ bool xe_device_is_admin_only(const struct xe_device *xe)
 }
 #endif
=20
+/* Number of allocated struct xe_device */
+static atomic_t xe_device_count;
+
 static void xe_device_destroy(struct drm_device *dev, void *dummy)
 {
 	struct xe_device *xe =3D to_xe_device(dev);
@@ -392,6 +396,9 @@ static void xe_device_destroy(struct drm_device *dev, v=
oid *dummy)
 		destroy_workqueue(xe->destroy_wq);
=20
 	ttm_device_fini(&xe->ttm);
+
+	if (atomic_dec_and_test(&xe_device_count))
+		wake_up_var(&xe_device_count);
 }
=20
 /**
@@ -462,6 +469,7 @@ int xe_device_init_early(struct xe_device *xe)
 		return err;
=20
 	xe_bo_dev_init(&xe->bo_device);
+	atomic_inc(&xe_device_count);
 	err =3D drmm_add_action_or_reset(&xe->drm, xe_device_destroy, NULL);
 	if (err)
 		return err;
@@ -668,7 +676,7 @@ static void vf_update_device_info(struct xe_device *xe)
 	xe->info.has_heci_cscfi =3D 0;
 	xe->info.has_heci_gscfi =3D 0;
 	xe->info.has_i2c =3D 0;
-	xe->info.has_late_bind =3D 0;
+	xe->info.late_bind_mask =3D 0;
 	xe->info.skip_guc_pc =3D 1;
 	xe->info.skip_pcode =3D 1;
 	xe->info.has_drm_ras =3D false;
@@ -690,16 +698,6 @@ static int xe_device_vram_alloc(struct xe_device *xe)
 	return 0;
 }
=20
-static void wedged_work(struct work_struct *work);
-static void xe_device_wedged_fini(struct drm_device *drm, void *arg);
-
-static int xe_device_wedged_init(struct xe_device *xe)
-{
-	INIT_WORK(&xe->wedged.work, wedged_work);
-
-	return drmm_add_action_or_reset(&xe->drm, xe_device_wedged_fini, xe);
-}
-
 /**
  * xe_device_probe_early: Device early probe
  * @xe: xe device instance
@@ -759,16 +757,11 @@ int xe_device_probe_early(struct xe_device *xe)
 	 */
 	assert_lmem_ready(xe);
=20
-	xe->wedged.mode =3D xe_device_validate_wedged_mode(xe, xe_modparam.wedged=
_mode) ?
-			  XE_DEFAULT_WEDGED_MODE : xe_modparam.wedged_mode;
-	drm_dbg(&xe->drm, "wedged_mode: setting mode (%u) %s\n",
-		xe->wedged.mode, xe_wedged_mode_to_string(xe->wedged.mode));
-
 	err =3D xe_device_vram_alloc(xe);
 	if (err)
 		return err;
=20
-	err =3D xe_device_wedged_init(xe);
+	err =3D xe_wedge_init(xe);
 	if (err)
 		return err;
=20
@@ -776,6 +769,25 @@ int xe_device_probe_early(struct xe_device *xe)
 }
 ALLOW_ERROR_INJECTION(xe_device_probe_early, ERRNO); /* See xe_pci_probe()=
 */
=20
+static void override_has_cached_pt(struct xe_device *xe)
+{
+	struct xe_gt *gt;
+	u8 id;
+
+	for_each_gt(gt, xe, id) {
+		/*
+		 * Wa_16029380221: The affected GT will always use
+		 * non-coherent access to page tables, so we must do
+		 * uncached writes from the CPU.
+		 */
+		if (XE_GT_WA(gt, 16029380221))
+			xe->info.has_cached_pt =3D false;
+
+		if (XE_GT_WA(gt, 14026539277))
+			xe->info.has_cached_pt =3D false;
+	}
+}
+
 static int probe_has_flat_ccs(struct xe_device *xe)
 {
 	struct xe_gt *gt;
@@ -858,14 +870,6 @@ static void detect_preproduction_hw(struct xe_device *=
xe)
 	}
 }
=20
-static void xe_device_wedged_fini(struct drm_device *drm, void *arg)
-{
-	struct xe_device *xe =3D arg;
-
-	if (atomic_read(&xe->wedged.flag))
-		xe_pm_runtime_put(xe);
-}
-
 #ifdef CONFIG_DRM_XE_DEBUG_PAGE_SIZE
 static int xe_debug_page_size_alloc_ctrl_init(struct xe_device *xe)
 {
@@ -926,14 +930,7 @@ int xe_device_probe(struct xe_device *xe)
 			return err;
 	}
=20
-	/*
-	 * Wa_16029380221: The affected GT will always use non-coherent
-	 * access to page tables, so we must do uncached writes from the
-	 * CPU.
-	 */
-	for_each_gt(gt, xe, id)
-		if (XE_GT_WA(gt, 16029380221))
-			xe->info.has_cached_pt =3D false;
+	override_has_cached_pt(xe);
=20
 	for_each_tile(tile, xe, id) {
 		err =3D xe_ggtt_init_early(tile->mem.ggtt);
@@ -983,7 +980,9 @@ int xe_device_probe(struct xe_device *xe)
 	if (err)
 		return err;
=20
-	xe_ras_init(xe);
+	err =3D xe_ras_init(xe);
+	if (err)
+		return err;
=20
 	/*
 	 * Now that GT is initialized (TTM in particular),
@@ -1104,13 +1103,6 @@ int xe_device_probe(struct xe_device *xe)
=20
 	detect_preproduction_hw(xe);
=20
-	/*
-	 * Process and log any errors detected by hardware. Possible results can
-	 * include declaring the device as wedged, which must be done only after
-	 * xe_device_wedged_fini() is registered.
-	 */
-	xe_ras_process_errors(xe);
-
 	err =3D devm_add_action_or_reset(xe->drm.dev, xe_device_sanitize, xe);
 	if (err)
 		goto err_unregister_display;
@@ -1346,153 +1338,6 @@ u64 xe_device_uncanonicalize_addr(struct xe_device =
*xe, u64 address)
 	return address & GENMASK_ULL(xe->info.va_bits - 1, 0);
 }
=20
-/**
- * DOC: Xe Device Wedging
- *
- * Xe driver uses drm device wedged uevent as documented in Documentation/=
gpu/drm-uapi.rst.
- * When device is in wedged state, every IOCTL will be blocked and GT cann=
ot
- * be used. The conditions under which the driver declares the device wedg=
ed
- * depend on the wedged mode configuration (see &enum xe_wedged_mode). The
- * default recovery method for a wedged state is rebind/bus-reset.
- *
- * Another recovery method is vendor-specific. Below are the cases that se=
nd
- * ``WEDGED=3Dvendor-specific`` recovery method in drm device wedged ueven=
t.
- *
- * Case: Firmware Flash
- * --------------------
- *
- * Identification Hint
- * +++++++++++++++++++
- *
- * ``WEDGED=3Dvendor-specific`` drm device wedged uevent with
- * :ref:`Runtime Survivability mode <xe-survivability-mode>` is used to no=
tify
- * admin/userspace consumer about the need for a firmware flash.
- *
- * Recovery Procedure
- * ++++++++++++++++++
- *
- * Once ``WEDGED=3Dvendor-specific`` drm device wedged uevent is received,=
 follow
- * the below steps
- *
- * - Check Runtime Survivability mode sysfs.
- *   If enabled, firmware flash is required to recover the device.
- *
- *   /sys/bus/pci/devices/<device>/survivability_mode
- *
- * - Admin/userspace consumer can use firmware flashing tools like fwupd t=
o flash
- *   firmware and restore device to normal operation.
- */
-
-static void wedged_work(struct work_struct *work)
-{
-	struct xe_device *xe =3D container_of(work, struct xe_device, wedged.work=
);
-
-	/* Notify userspace of wedged device */
-	drm_dev_wedged_event(&xe->drm, xe->wedged.method, NULL);
-}
-
-#define WEDGED_URL	"https://docs.kernel.org/gpu/drm-uapi.html#device-wedgi=
ng"
-#define XE_BUG_URL	"https://gitlab.freedesktop.org/drm/xe/kernel/issues/ne=
w"
-
-/**
- * xe_device_declare_wedged - Declare device wedged
- * @xe: xe device instance
- * @method: method(s) to be used for recovery
- *
- * This is a final state that can only be cleared with the recovery method
- * specified in the drm wedged uevent.
- *
- * In this state every IOCTL will be blocked so the GT cannot be used.
- * In general it will be called upon any critical error such as gt reset
- * failure or guc loading failure. Userspace will be notified of this state
- * through device wedged uevent.
- * If xe.wedged module parameter is set to 2, this function will be called
- * on every single execution timeout (a.k.a. GPU hang) right after devcore=
dump
- * snapshot capture. In this mode, GT reset won't be attempted so the stat=
e of
- * the issue is preserved for further debugging.
- */
-void xe_device_declare_wedged(struct xe_device *xe, unsigned long method)
-{
-	struct xe_gt *gt;
-	u8 id;
-
-	if (xe->wedged.mode =3D=3D XE_WEDGED_MODE_NEVER) {
-		drm_dbg(&xe->drm, "Wedged mode is forcibly disabled\n");
-		return;
-	}
-
-	if (!atomic_xchg(&xe->wedged.flag, 1)) {
-		xe->needs_flr_on_fini =3D true;
-		xe_pm_runtime_get_noresume(xe);
-
-		xe_log_err_fatal(xe, WEDGED, -EIO, "Device declared wedged!\n");
-		xe_err_once(xe, "IOCTLs and executions are now blocked!\n"
-			    "For recovery procedure, refer to %s\n"
-			    "Please file a _new_ bug report at %s\n",
-			    WEDGED_URL, XE_BUG_URL);
-
-		for_each_initialized_gt(gt, xe, id)
-			xe_gt_declare_wedged(gt);
-
-		/*
-		 * XE_WEDGED_MODE_UPON_ANY_HANG_NO_RESET is intended for debugging
-		 * hangs, so wedge the device with 'none' recovery method and have
-		 * it available to the user for debugging.
-		 */
-		if (xe->wedged.mode =3D=3D XE_WEDGED_MODE_UPON_ANY_HANG_NO_RESET)
-			xe->wedged.method =3D DRM_WEDGE_RECOVERY_NONE;
-		else
-			xe->wedged.method =3D method;
-
-		schedule_work(&xe->wedged.work);
-	}
-}
-
-/**
- * xe_device_validate_wedged_mode - Check if given mode is supported
- * @xe: the &xe_device
- * @mode: requested mode to validate
- *
- * Check whether the provided wedged mode is supported.
- *
- * Return: 0 if mode is supported, error code otherwise.
- */
-int xe_device_validate_wedged_mode(struct xe_device *xe, unsigned int mode)
-{
-	if (mode > XE_WEDGED_MODE_UPON_ANY_HANG_NO_RESET) {
-		drm_dbg(&xe->drm, "wedged_mode: invalid value (%u)\n", mode);
-		return -EINVAL;
-	} else if (mode =3D=3D XE_WEDGED_MODE_UPON_ANY_HANG_NO_RESET && (IS_SRIOV=
_VF(xe) ||
-		   (IS_SRIOV_PF(xe) && !IS_ENABLED(CONFIG_DRM_XE_DEBUG)))) {
-		drm_dbg(&xe->drm, "wedged_mode: (%u) %s mode is not supported for %s\n",
-			mode, xe_wedged_mode_to_string(mode),
-			xe_sriov_mode_to_string(xe_device_sriov_mode(xe)));
-		return -EPERM;
-	}
-
-	return 0;
-}
-
-/**
- * xe_wedged_mode_to_string - Convert enum value to string.
- * @mode: the &xe_wedged_mode to convert
- *
- * Returns: wedged mode as a user friendly string.
- */
-const char *xe_wedged_mode_to_string(enum xe_wedged_mode mode)
-{
-	switch (mode) {
-	case XE_WEDGED_MODE_NEVER:
-		return "never";
-	case XE_WEDGED_MODE_UPON_CRITICAL_ERROR:
-		return "upon-critical-error";
-	case XE_WEDGED_MODE_UPON_ANY_HANG_NO_RESET:
-		return "upon-any-hang-no-reset";
-	default:
-		return "<invalid>";
-	}
-}
-
 /**
  * xe_device_asid_to_vm() - Find VM from ASID
  * @xe: the &xe_device
@@ -1517,3 +1362,25 @@ struct xe_vm *xe_device_asid_to_vm(struct xe_device =
*xe, u32 asid)
=20
 	return vm;
 }
+
+/**
+ * xe_device_exit() - Device subsystem exit function.
+ *
+ * Exit function to be called at module unload time.
+ */
+void xe_device_exit(void)
+{
+	/*
+	 * Wait for all devices to be freed. 20s is well above the typical
+	 * maximum dma_fence signalling time, so warn and keep waiting if
+	 * we're still not done by then, since it may indicate a leaked
+	 * xe_device reference is stalling module unload.
+	 */
+	if (!wait_var_event_timeout(&xe_device_count,
+				    !atomic_read(&xe_device_count),
+				    HZ * 20)) {
+		pr_warn("%s: Waiting for %d xe device(s) to be freed before unloading.\n=
",
+			DRIVER_NAME, atomic_read(&xe_device_count));
+		wait_var_event(&xe_device_count, !atomic_read(&xe_device_count));
+	}
+}
diff --git a/drivers/gpu/drm/xe/xe_device.h b/drivers/gpu/drm/xe/xe_device.h
index 3ce1481d0e573..6df60edcb8f81 100644
--- a/drivers/gpu/drm/xe/xe_device.h
+++ b/drivers/gpu/drm/xe/xe_device.h
@@ -211,11 +211,6 @@ bool xe_device_is_l2_flush_optimized(struct xe_device =
*xe);
 void xe_device_td_flush(struct xe_device *xe);
 void xe_device_l2_flush(struct xe_device *xe, bool force);
=20
-static inline bool xe_device_wedged(struct xe_device *xe)
-{
-	return atomic_read(&xe->wedged.flag);
-}
-
 #ifdef CONFIG_DRM_XE_DEBUG_PAGE_SIZE
 static inline bool xe_debug_page_size_supported(struct xe_device *xe)
 {
@@ -264,10 +259,6 @@ static inline bool xe_debug_page_size_mode_is_mixed(st=
ruct xe_device *xe)
 }
 #endif
=20
-void xe_device_declare_wedged(struct xe_device *xe, unsigned long method);
-int xe_device_validate_wedged_mode(struct xe_device *xe, unsigned int mode=
);
-const char *xe_wedged_mode_to_string(enum xe_wedged_mode mode);
-
 struct xe_file *xe_file_get(struct xe_file *xef);
 void xe_file_put(struct xe_file *xef);
=20
@@ -286,6 +277,8 @@ static inline bool xe_device_is_admin_only(const struct=
 xe_device *xe)
 }
 #endif
=20
+void xe_device_exit(void);
+
 /*
  * Occasionally it is seen that the G2H worker starts running after a dela=
y of more than
  * a second even after being queued and activated by the Linux workqueue s=
ubsystem. This
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_d=
evice_types.h
index 5aa52975ebb46..d99881c6e1d53 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -12,6 +12,7 @@
 #include <drm/drm_file.h>
 #include <drm/ttm/ttm_device.h>
=20
+#include "xe_cper_types.h"
 #include "xe_devcoredump_types.h"
 #include "xe_drm_ras_types.h"
 #include "xe_heci_gsc.h"
@@ -21,6 +22,7 @@
 #include "xe_platform_types.h"
 #include "xe_pmu_types.h"
 #include "xe_pt_types.h"
+#include "xe_ras_types.h"
 #include "xe_sriov_pf_types.h"
 #include "xe_sriov_types.h"
 #include "xe_sriov_vf_types.h"
@@ -30,6 +32,7 @@
 #include "xe_sysctrl_types.h"
 #include "xe_tile_types.h"
 #include "xe_validation.h"
+#include "xe_wedge_types.h"
=20
 #if IS_ENABLED(CONFIG_DRM_XE_DEBUG)
 #define TEST_VM_OPS_ERROR
@@ -47,22 +50,6 @@ struct xe_pxp;
 struct xe_ttm_stolen_mgr;
 struct xe_vram_region;
=20
-/**
- * enum xe_wedged_mode - possible wedged modes
- * @XE_WEDGED_MODE_NEVER: Device will never be declared wedged.
- * @XE_WEDGED_MODE_UPON_CRITICAL_ERROR: Device will be declared wedged only
- *	when critical error occurs like GT reset failure or firmware failure.
- *	This is the default mode.
- * @XE_WEDGED_MODE_UPON_ANY_HANG_NO_RESET: Device will be declared wedged =
on
- *	any hang. In this mode, engine resets are disabled to avoid automatic
- *	recovery attempts. This mode is primarily intended for debugging hangs.
- */
-enum xe_wedged_mode {
-	XE_WEDGED_MODE_NEVER =3D 0,
-	XE_WEDGED_MODE_UPON_CRITICAL_ERROR =3D 1,
-	XE_WEDGED_MODE_UPON_ANY_HANG_NO_RESET =3D 2,
-};
-
 #ifdef CONFIG_DRM_XE_DEBUG_PAGE_SIZE
 /**
  * enum xe_page_size_alloc_ctrl_mode - User BO page-size allocation contro=
l modes
@@ -164,6 +151,8 @@ struct xe_device {
 		u8 vm_max_level;
 		/** @info.va_bits: Maximum bits of a virtual address */
 		u8 va_bits;
+		/** @info.late_bind_mask: Indicates supported late binding firmwares */
+		u8 late_bind_mask;
=20
 		/*
 		 * Keep all flags below alphabetically sorted
@@ -185,6 +174,8 @@ struct xe_device {
 		u8 has_drm_ras:1;
 		/** @info.has_fan_control: Device supports fan control */
 		u8 has_fan_control:1;
+		/** @info.has_fixed_vram_channels: Device has fixed VRAM temperature cha=
nnels */
+		u8 has_fixed_vram_channels:1;
 		/** @info.has_flat_ccs: Whether flat CCS metadata is used */
 		u8 has_flat_ccs:1;
 		/** @info.has_gsc_nvm: Device has gsc non-volatile memory */
@@ -195,8 +186,6 @@ struct xe_device {
 		u8 has_heci_gscfi:1;
 		/** @info.has_i2c: Device has I2C controller */
 		u8 has_i2c:1;
-		/** @info.has_late_bind: Device has firmware late binding support */
-		u8 has_late_bind:1;
 		/** @info.has_llc: Device has a shared CPU+GPU last level cache */
 		u8 has_llc:1;
 		/** @info.has_mbx_power_limits: Device has support to manage power limit=
s using
@@ -553,18 +542,7 @@ struct xe_device {
 	atomic_t in_reset;
=20
 	/** @wedged: Struct to control Wedged States and mode */
-	struct {
-		/** @wedged.flag: Xe device faced a critical error and is now blocked. */
-		atomic_t flag;
-		/** @wedged.mode: Mode controlled by kernel parameter and debugfs */
-		enum xe_wedged_mode mode;
-		/** @wedged.method: Recovery method to be sent in the drm device wedged =
uevent */
-		unsigned long method;
-		/** @wedged.inconsistent_reset: Inconsistent reset policy state between =
GTs */
-		bool inconsistent_reset;
-		/** @wedged.work: Worker to defer non-atomic calls */
-		struct work_struct work;
-	} wedged;
+	struct xe_wedge wedged;
=20
 	/** @devres_group: devres group */
 	void *devres_group;
@@ -580,8 +558,17 @@ struct xe_device {
 	/** @pmu: performance monitoring unit */
 	struct xe_pmu pmu;
=20
-	/** @ras: RAS structure for device */
-	struct xe_drm_ras ras;
+	/** @ras: RAS (Reliability, Availability, Serviceability) structures */
+	struct {
+		/** @ras.nl_data: drm-ras netlink data */
+		struct xe_drm_ras nl_data;
+
+		/** @ras.state: RAS device and firmware state */
+		struct xe_ras_state state;
+	} ras;
+
+	/** @cper: CPER state */
+	struct xe_cper cper;
=20
 	/** @i2c: I2C host controller */
 	struct xe_i2c *i2c;
diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ra=
s.c
index 30cf40ee5fe4d..7554803aae11a 100644
--- a/drivers/gpu/drm/xe/xe_drm_ras.c
+++ b/drivers/gpu/drm/xe/xe_drm_ras.c
@@ -31,7 +31,7 @@ static int query_error_counter(struct xe_device *xe,
 			       enum drm_xe_ras_error_severity severity,
 			       u32 error_id, const char **name, u32 *val)
 {
-	struct xe_drm_ras *ras =3D &xe->ras;
+	struct xe_drm_ras *ras =3D &xe->ras.nl_data;
 	struct xe_drm_ras_counter *info =3D ras->info[severity];
=20
 	if (!info || !info[error_id].name)
@@ -52,7 +52,7 @@ static int clear_error_counter(struct xe_device *xe,
 			       enum drm_xe_ras_error_severity severity,
 			       u32 error_id)
 {
-	struct xe_drm_ras *ras =3D &xe->ras;
+	struct xe_drm_ras *ras =3D &xe->ras.nl_data;
 	struct xe_drm_ras_counter *info =3D ras->info[severity];
=20
 	if (!info || !info[error_id].name)
@@ -101,7 +101,7 @@ static int query_correctable_error_threshold(struct drm=
_ras_node *ep, u32 error_
 					     const char **name, u32 *threshold)
 {
 	struct xe_device *xe =3D ep->priv;
-	struct xe_drm_ras *ras =3D &xe->ras;
+	struct xe_drm_ras *ras =3D &xe->ras.nl_data;
 	struct xe_drm_ras_counter *info =3D ras->info[DRM_XE_RAS_ERR_SEV_CORRECTA=
BLE];
=20
 	if (!info || !info[error_id].name)
@@ -117,7 +117,7 @@ static int query_correctable_error_threshold(struct drm=
_ras_node *ep, u32 error_
 static int set_correctable_error_threshold(struct drm_ras_node *ep, u32 er=
ror_id, u32 threshold)
 {
 	struct xe_device *xe =3D ep->priv;
-	struct xe_drm_ras *ras =3D &xe->ras;
+	struct xe_drm_ras *ras =3D &xe->ras.nl_data;
 	struct xe_drm_ras_counter *info =3D ras->info[DRM_XE_RAS_ERR_SEV_CORRECTA=
BLE];
=20
 	if (!info || !info[error_id].name)
@@ -153,7 +153,7 @@ static int assign_node_params(struct xe_device *xe, str=
uct drm_ras_node *node,
 			      const enum drm_xe_ras_error_severity severity)
 {
 	struct pci_dev *pdev =3D to_pci_dev(xe->drm.dev);
-	struct xe_drm_ras *ras =3D &xe->ras;
+	struct xe_drm_ras *ras =3D &xe->ras.nl_data;
 	const char *device_name;
=20
 	device_name =3D kasprintf(GFP_KERNEL, "%04x:%02x:%02x.%d",
@@ -201,7 +201,7 @@ static void cleanup_node(struct drm_device *drm, void *=
node)
=20
 static int register_nodes(struct xe_device *xe)
 {
-	struct xe_drm_ras *ras =3D &xe->ras;
+	struct xe_drm_ras *ras =3D &xe->ras.nl_data;
 	struct drm_ras_node *node;
 	int i, ret;
=20
@@ -241,7 +241,7 @@ static int register_nodes(struct xe_device *xe)
  */
 void xe_drm_ras_event(struct xe_device *xe, u32 component, u32 severity, u=
32 value)
 {
-	struct xe_drm_ras *ras =3D &xe->ras;
+	struct xe_drm_ras *ras =3D &xe->ras.nl_data;
 	struct xe_drm_ras_counter *info;
 	struct drm_ras_node *node;
 	int ret;
@@ -275,7 +275,7 @@ void xe_drm_ras_event(struct xe_device *xe, u32 compone=
nt, u32 severity, u32 val
  */
 int xe_drm_ras_init(struct xe_device *xe)
 {
-	struct xe_drm_ras *ras =3D &xe->ras;
+	struct xe_drm_ras *ras =3D &xe->ras.nl_data;
 	struct drm_ras_node *node;
 	int err;
=20
diff --git a/drivers/gpu/drm/xe/xe_gsc.c b/drivers/gpu/drm/xe/xe_gsc.c
index 2bbe0f20ff8d3..db669a953886a 100644
--- a/drivers/gpu/drm/xe/xe_gsc.c
+++ b/drivers/gpu/drm/xe/xe_gsc.c
@@ -31,6 +31,7 @@
 #include "xe_sched_job.h"
 #include "xe_uc_fw.h"
 #include "xe_wa.h"
+#include "xe_wedge.h"
 #include "instructions/xe_gsc_commands.h"
 #include "regs/xe_gsc_regs.h"
 #include "regs/xe_gt_regs.h"
@@ -340,8 +341,8 @@ static int gsc_er_complete(struct xe_gt *gt)
 		 * declare the device as wedged.
 		 */
 		xe_gt_err(gt, "GSC ER timed out!\n");
-		xe_device_declare_wedged(gt_to_xe(gt),
-					 DRM_WEDGE_RECOVERY_REBIND | DRM_WEDGE_RECOVERY_BUS_RESET);
+		xe_wedge_declare(gt_to_xe(gt),
+				 DRM_WEDGE_RECOVERY_REBIND | DRM_WEDGE_RECOVERY_BUS_RESET);
 		return -EIO;
 	}
=20
diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
index 286aee5775c0d..b751b5044f3ca 100644
--- a/drivers/gpu/drm/xe/xe_gt.c
+++ b/drivers/gpu/drm/xe/xe_gt.c
@@ -12,7 +12,6 @@
 #include <drm/drm_managed.h>
 #include <uapi/drm/xe_drm.h>
=20
-#include <generated/xe_device_wa_oob.h>
 #include <generated/xe_wa_oob.h>
=20
 #include "instructions/xe_alu_commands.h"
@@ -68,6 +67,7 @@
 #include "xe_uc_fw.h"
 #include "xe_vm.h"
 #include "xe_wa.h"
+#include "xe_wedge.h"
 #include "xe_wopcm.h"
=20
 #define GRDOM_RESET_TIMEOUT_MS	5
@@ -459,35 +459,6 @@ int xe_gt_record_default_lrcs(struct xe_gt *gt)
 	return err;
 }
=20
-static void wa_14026539277(struct xe_gt *gt)
-{
-	struct xe_device *xe =3D gt_to_xe(gt);
-	u32 val;
-
-	/*
-	 * FIXME: We currently can't use FUNC(xe_rtp_match_not_sriov_vf) in the
-	 * rules for Wa_14026539277 due to xe_wa_process_device_oob() being
-	 * called before xe_sriov_probe_early(); and we can't move the call to
-	 * the former to happen after the latter because MMIO read functions
-	 * already depend on a device OOB workaround.  This needs to be fixed by
-	 * allowing workaround checks to happen at different stages of driver
-	 * initialization.
-	 */
-	if (IS_SRIOV_VF(xe))
-		return;
-
-	if (!XE_DEVICE_WA(xe, 14026539277))
-		return;
-
-	if (!xe_gt_is_main_type(gt))
-		return;
-
-	val =3D xe_gt_mcr_unicast_read_any(gt, L2COMPUTESIDECTRL);
-	val &=3D ~CECTRL;
-	val |=3D CECTRL_CENODATA_ALWAYS;
-	xe_gt_mcr_multicast_write(gt, L2COMPUTESIDECTRL, val);
-}
-
 int xe_gt_init_early(struct xe_gt *gt)
 {
 	int err;
@@ -621,15 +592,6 @@ static int gt_init_with_gt_forcewake(struct xe_gt *gt)
 	else
 		gt->info.has_wmtp_disabled =3D 0;
=20
-	/*
-	 * Wa_14026539277 can't be implemented as a regular GT workaround (i.e.
-	 * as an entry in gt_was[]) for two reasons: it is actually a device
-	 * workaround that happens to involve programming a GT register; and it
-	 * needs to be applied early to avoid getting the hardware in a bad
-	 * state before we have a chance to do the necessary programming.
-	 */
-	wa_14026539277(gt);
-
 	return 0;
 }
=20
@@ -948,7 +910,7 @@ static void gt_reset_worker(struct work_struct *w)
 	unsigned int fw_ref;
 	int err;
=20
-	if (xe_device_wedged(gt_to_xe(gt)))
+	if (xe_wedged(gt_to_xe(gt)))
 		goto err_pm_put;
=20
 	if (xe_device_is_in_reset(gt_to_xe(gt)))
@@ -1007,8 +969,7 @@ static void gt_reset_worker(struct work_struct *w)
=20
 err_fail:
 	xe_log_err_fatal(gt, GT, err, "reset failed\n");
-	xe_device_declare_wedged(gt_to_xe(gt),
-				 DRM_WEDGE_RECOVERY_REBIND | DRM_WEDGE_RECOVERY_BUS_RESET);
+	xe_wedge_declare(gt_to_xe(gt), DRM_WEDGE_RECOVERY_REBIND | DRM_WEDGE_RECO=
VERY_BUS_RESET);
 err_pm_put:
 	xe_pm_runtime_put(gt_to_xe(gt));
 }
@@ -1091,6 +1052,19 @@ int xe_gt_sanitize_freq(struct xe_gt *gt)
 	return ret;
 }
=20
+/**
+ * xe_gt_resume_early() - Early init for GT resume
+ * @gt: the GT object
+ *
+ * Handles GT related init before GT restart after a suspend cycle.
+ */
+void xe_gt_resume_early(struct xe_gt *gt)
+{
+	xe_gt_idle_disable_c6(gt);
+
+	xe_uc_resume_early(&gt->uc);
+}
+
 int xe_gt_resume(struct xe_gt *gt)
 {
 	int err;
@@ -1215,19 +1189,19 @@ static void gt_wedge_worker(struct work_struct *w)
 {
 	struct xe_gt *gt =3D container_of(w, typeof(*gt), wedge.worker);
=20
-	xe_uc_declare_wedged(&gt->uc);
+	xe_uc_wedge_declare(&gt->uc);
 	xe_tlb_inval_reset(&gt->tlb_inval);
 	xe_pm_runtime_put(gt_to_xe(gt));
 }
=20
 /**
- * xe_gt_declare_wedged() - Declare GT wedged
+ * xe_gt_wedge_declare() - Declare GT wedged
  * @gt: the GT object
  *
  * Wedge the GT which stops all submission, saves desired debug state, and
  * cleans up anything which could timeout.
  */
-void xe_gt_declare_wedged(struct xe_gt *gt)
+void xe_gt_wedge_declare(struct xe_gt *gt)
 {
 	struct xe_device *xe =3D gt_to_xe(gt);
=20
diff --git a/drivers/gpu/drm/xe/xe_gt_sriov_vf.c b/drivers/gpu/drm/xe/xe_gt=
_sriov_vf.c
index 28ec83bb8100d..2a5f2064ad3e8 100644
--- a/drivers/gpu/drm/xe/xe_gt_sriov_vf.c
+++ b/drivers/gpu/drm/xe/xe_gt_sriov_vf.c
@@ -37,6 +37,7 @@
 #include "xe_tile_sriov_vf.h"
 #include "xe_tlb_inval.h"
 #include "xe_uc_fw.h"
+#include "xe_wedge.h"
 #include "xe_wopcm.h"
=20
 #define make_u64_from_u32(hi, lo) ((u64)((u64)(u32)(hi) << 32 | (u32)(lo)))
@@ -1462,7 +1463,7 @@ static void vf_post_migration_recovery(struct xe_gt *=
gt)
 fail:
 	vf_post_migration_abort(gt);
 	xe_gt_sriov_err(gt, "migration recovery failed (%pe)\n", ERR_PTR(err));
-	xe_device_declare_wedged(xe, DRM_WEDGE_RECOVERY_REBIND | DRM_WEDGE_RECOVE=
RY_BUS_RESET);
+	xe_wedge_declare(xe, DRM_WEDGE_RECOVERY_REBIND | DRM_WEDGE_RECOVERY_BUS_R=
ESET);
 	return;
=20
 queue:
diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc=
_submit.c
index 01f79f8883ba6..b14b37b767f5e 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -50,6 +50,7 @@
 #include "xe_trace.h"
 #include "xe_uc_fw.h"
 #include "xe_vm.h"
+#include "xe_wedge.h"
=20
 #define XE_GUC_EXEC_QUEUE_CGP_CONTEXT_ERROR_LEN		6
=20
@@ -286,20 +287,26 @@ static void primelockdep(struct xe_guc *guc)
 	fs_reclaim_release(GFP_KERNEL);
 }
=20
+static int guc_id_mgr_init(struct xe_guc *guc)
+{
+	if (IS_SRIOV_PF(guc_to_xe(guc)))
+		return xe_guc_id_mgr_init_shared(&guc->submission_state.idm);
+	else if (IS_SRIOV_VF(guc_to_xe(guc)))
+		return xe_guc_id_mgr_init_small(&guc->submission_state.idm,
+						xe_gt_sriov_vf_guc_ids(guc_to_gt(guc)));
+	else
+		return xe_guc_id_mgr_init(&guc->submission_state.idm);
+}
+
 /**
  * xe_guc_submit_init() - Initialize GuC submission.
  * @guc: the &xe_guc to initialize
- * @num_ids: number of GuC context IDs to use
  *
- * The bare-metal or PF driver can pass ~0 as &num_ids to indicate that all
- * GuC context IDs supported by the GuC firmware should be used for submis=
sion.
- *
- * Only VF drivers will have to provide explicit number of GuC context IDs
- * that they can use for submission.
+ * This function initializes the GuC submission state.
  *
  * Return: 0 on success or a negative error code on failure.
  */
-int xe_guc_submit_init(struct xe_guc *guc, unsigned int num_ids)
+int xe_guc_submit_init(struct xe_guc *guc)
 {
 	struct xe_device *xe =3D guc_to_xe(guc);
 	struct xe_gt *gt =3D guc_to_gt(guc);
@@ -309,7 +316,7 @@ int xe_guc_submit_init(struct xe_guc *guc, unsigned int=
 num_ids)
 	if (err)
 		return err;
=20
-	err =3D xe_guc_id_mgr_init(&guc->submission_state.idm, num_ids);
+	err =3D guc_id_mgr_init(guc);
 	if (err)
 		return err;
=20
@@ -415,8 +422,7 @@ static int alloc_guc_id(struct xe_guc *guc, struct xe_e=
xec_queue *q)
 	int ret, i;
=20
 	mutex_lock(&guc->submission_state.lock);
-	ret =3D xe_guc_id_mgr_reserve_locked(&guc->submission_state.idm,
-					   q->width);
+	ret =3D xe_guc_id_mgr_reserve_usable_locked(&guc->submission_state.idm, q=
->width);
 	mutex_unlock(&guc->submission_state.lock);
 	if (ret < 0)
 		return ret;
@@ -1450,10 +1456,10 @@ static bool guc_submit_hint_wedged(struct xe_guc *g=
uc)
 	if (xe->wedged.mode !=3D XE_WEDGED_MODE_UPON_ANY_HANG_NO_RESET)
 		return false;
=20
-	if (xe_device_wedged(xe))
+	if (xe_wedged(xe))
 		return true;
=20
-	xe_device_declare_wedged(xe, DRM_WEDGE_RECOVERY_REBIND | DRM_WEDGE_RECOVE=
RY_BUS_RESET);
+	xe_wedge_declare(xe, DRM_WEDGE_RECOVERY_REBIND | DRM_WEDGE_RECOVERY_BUS_R=
ESET);
=20
 	return true;
 }
@@ -1666,7 +1672,7 @@ guc_exec_queue_timedout_job(struct drm_sched_job *drm=
_job)
 	if (!exec_queue_killed(q))
 		wedged =3D guc_submit_hint_wedged(exec_queue_to_guc(q));
 	else
-		wedged =3D xe_device_wedged(xe);
+		wedged =3D xe_wedged(xe);
=20
 	/*
 	 * Only tag as GPU hang if this is the original timeout, not a
@@ -1786,8 +1792,8 @@ guc_exec_queue_timedout_job(struct drm_sched_job *drm=
_job)
 	}
=20
 	if (wedge_device)
-		xe_device_declare_wedged(gt_to_xe(q->gt),
-					 DRM_WEDGE_RECOVERY_REBIND | DRM_WEDGE_RECOVERY_BUS_RESET);
+		xe_wedge_declare(gt_to_xe(q->gt),
+				 DRM_WEDGE_RECOVERY_REBIND | DRM_WEDGE_RECOVERY_BUS_RESET);
=20
 	/*
 	 * We want the job added back to the pending list so it gets freed; this
@@ -2552,7 +2558,7 @@ static int guc_exec_queue_wait_suspend_done(struct xe=
_exec_queue *q, bool blocki
 						       WAIT_COND, HZ * 5);
 	}
=20
-	if (!blocking && vf_recovery(guc) && !xe_device_wedged(xe))
+	if (!blocking && vf_recovery(guc) && !xe_wedged(xe))
 		return -EAGAIN;
=20
 	if (!ret)
@@ -2812,7 +2818,7 @@ int xe_guc_submit_reset_prepare(struct xe_guc *guc)
=20
 void xe_guc_submit_reset_wait(struct xe_guc *guc)
 {
-	wait_event(guc->ct.wq, xe_device_wedged(guc_to_xe(guc)) ||
+	wait_event(guc->ct.wq, xe_wedged(guc_to_xe(guc)) ||
 		   !xe_guc_read_stopped(guc));
 }
=20
@@ -3307,7 +3313,7 @@ g2h_exec_queue_lookup(struct xe_guc *guc, u32 guc_id)
 	struct xe_gt *gt =3D guc_to_gt(guc);
 	struct xe_exec_queue *q;
=20
-	if (unlikely(guc_id >=3D GUC_ID_MAX)) {
+	if (unlikely(guc_id >=3D xe_guc_id_mgr_max_usable(&guc->submission_state.=
idm))) {
 		xe_gt_err(gt, "Invalid guc_id %u\n", guc_id);
 		return NULL;
 	}
diff --git a/drivers/gpu/drm/xe/xe_hwmon.c b/drivers/gpu/drm/xe/xe_hwmon.c
index 20c1cfffc5a03..defe8aaca7c11 100644
--- a/drivers/gpu/drm/xe/xe_hwmon.c
+++ b/drivers/gpu/drm/xe/xe_hwmon.c
@@ -6,6 +6,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/hwmon.h>
 #include <linux/jiffies.h>
+#include <linux/overflow.h>
 #include <linux/types.h>
 #include <linux/units.h>
=20
@@ -15,6 +16,7 @@
 #include "regs/xe_pcode_regs.h"
 #include "xe_device.h"
 #include "xe_hwmon.h"
+#include "xe_log.h"
 #include "xe_mmio.h"
 #include "xe_pcode.h"
 #include "xe_pcode_api.h"
@@ -39,7 +41,11 @@ enum xe_hwmon_reg_operation {
 	REG_READ64,
 };
=20
-#define MAX_VRAM_CHANNELS      (16)
+#define MAX_VRAM_CHANNELS	80
+#define FIXED_VRAM_CHANNELS	16
+
+/* Each MSU enable bit maps to one VRAM subsystem of 4 channels. */
+#define VRAM_CHANNELS_PER_MSU	4
=20
 enum xe_hwmon_channel {
 	CHANNEL_CARD,
@@ -48,6 +54,7 @@ enum xe_hwmon_channel {
 	CHANNEL_MCTRL,
 	CHANNEL_PCIE,
 	CHANNEL_VRAM_N,
+	/* Compile-time upper bound; actual channel count is hwmon->temp.vram_cou=
nt */
 	CHANNEL_VRAM_N_MAX =3D CHANNEL_VRAM_N + MAX_VRAM_CHANNELS - 1,
 	CHANNEL_MAX,
 };
@@ -101,8 +108,15 @@ enum sensor_attr_power {
=20
 #define PWR_ATTR_TO_STR(attr)	(((attr) =3D=3D hwmon_power_max) ? "PL1" : "=
PL2")
=20
-/* Index of memory controller in READ_THERMAL_DATA output */
+/* Sensor byte indices in READ_THERMAL_DATA output for BMG. */
 #define TEMP_INDEX_MCTRL	2
+#define TEMP_INDEX_PCIE		10
+#define BMG_G21_TEMP_INDEX_PCIE	8
+
+/* Sensor byte indices in READ_THERMAL_DATA output for CRI. */
+#define CRI_TEMP_INDEX_MCTRL	16
+#define CRI_TEMP_MCTRL_COUNT	4
+#define CRI_TEMP_INDEX_PCIE	20
=20
 /* Mailbox sentinel reported for an unavailable temperature sensor */
 #define TEMP_MBX_INVALID	0xFF
@@ -144,16 +158,22 @@ struct xe_hwmon_thermal_info {
 		/** @data: temperature limits as little-endian dwords */
 		__le32 data[DIV_ROUND_UP(TEMP_LIMIT_MAX, sizeof(u32))];
 	};
-	/** @count: no of temperature sensors available for the platform */
+	/** @count: temperature sensors count from READ_THERMAL_CONFIG */
 	u8 count;
+	/** @vram_count: exclusive upper bound for VRAM temperature channel indic=
es */
+	u8 vram_count;
+	/** @available: temperature sensor availability cached at registration */
+	bool available[CHANNEL_MAX];
+	/** @msu_mask: VRAM subsystem enable mask read from MMIO */
+	u32 msu_mask;
 	union {
 		/** @value: per-sensor raw mailbox temperature; bit7=3Dsign, bits6:0=3Dm=
agnitude */
 		u8 value[U8_MAX + 1];
 		/** @dword: sensor values as little-endian dwords, u32-aligned for pcode=
 reads */
 		__le32 dword[DIV_ROUND_UP(U8_MAX + 1, sizeof(u32))];
 	};
-	/** @vram_label: vram label names */
-	char vram_label[MAX_VRAM_CHANNELS][MAX_LABEL_SIZE];
+	/** @vram_label: vram label names, dynamically allocated based on vram_co=
unt */
+	char (*vram_label)[MAX_LABEL_SIZE];
 };
=20
 /**
@@ -296,6 +316,14 @@ static int xe_hwmon_pcode_set_default_power_limits(str=
uct xe_hwmon *hwmon)
 	return ret;
 }
=20
+static bool xe_hwmon_vram_channel_enabled(const struct xe_hwmon *hwmon, in=
t index)
+{
+	if (hwmon->xe->info.platform =3D=3D XE_CRESCENTISLAND)
+		return hwmon->temp.msu_mask & BIT(index / VRAM_CHANNELS_PER_MSU);
+
+	return true;
+}
+
 static struct xe_reg xe_hwmon_get_reg(struct xe_hwmon *hwmon, enum xe_hwmo=
n_reg hwmon_reg,
 				      int channel)
 {
@@ -303,12 +331,21 @@ static struct xe_reg xe_hwmon_get_reg(struct xe_hwmon=
 *hwmon, enum xe_hwmon_reg
=20
 	switch (hwmon_reg) {
 	case REG_TEMP:
-		if (xe->info.platform =3D=3D XE_BATTLEMAGE || xe->info.platform =3D=3D X=
E_CRESCENTISLAND) {
+		if (xe->info.platform =3D=3D XE_CRESCENTISLAND) {
+			if (channel =3D=3D CHANNEL_PKG)
+				return CRI_PACKAGE_TEMPERATURE;
+			else if (channel =3D=3D CHANNEL_VRAM)
+				return CRI_VRAM_TEMPERATURE;
+			else if (in_range(channel, CHANNEL_VRAM_N, hwmon->temp.vram_count) &&
+				 xe_hwmon_vram_channel_enabled(hwmon, channel - CHANNEL_VRAM_N))
+				return CRI_VRAM_TEMPERATURE_N(channel - CHANNEL_VRAM_N);
+		} else if (xe->info.platform =3D=3D XE_BATTLEMAGE) {
 			if (channel =3D=3D CHANNEL_PKG)
 				return BMG_PACKAGE_TEMPERATURE;
 			else if (channel =3D=3D CHANNEL_VRAM)
 				return BMG_VRAM_TEMPERATURE;
-			else if (in_range(channel, CHANNEL_VRAM_N, MAX_VRAM_CHANNELS))
+			else if (in_range(channel, CHANNEL_VRAM_N, hwmon->temp.vram_count) &&
+				 xe_hwmon_vram_channel_enabled(hwmon, channel - CHANNEL_VRAM_N))
 				return BMG_VRAM_TEMPERATURE_N(channel - CHANNEL_VRAM_N);
 		} else if (xe->info.platform =3D=3D XE_DG2) {
 			if (channel =3D=3D CHANNEL_PKG)
@@ -375,17 +412,20 @@ static struct xe_reg xe_hwmon_get_reg(struct xe_hwmon=
 *hwmon, enum xe_hwmon_reg
  * same pattern for sysfs, allow arbitrary PL1 limits to be set but display
  * clamped values when read.
  */
-static void xe_hwmon_power_max_read(struct xe_hwmon *hwmon, u32 attr, int =
channel, long *value)
+static int xe_hwmon_power_max_read(struct xe_hwmon *hwmon, u32 attr, int c=
hannel, long *value)
 {
 	u32 reg_val =3D 0;
 	struct xe_device *xe =3D hwmon->xe;
 	struct xe_reg rapl_limit, pkg_power_sku;
 	struct xe_mmio *mmio =3D xe_root_tile_mmio(xe);
+	int ret =3D 0;
=20
 	mutex_lock(&hwmon->hwmon_lock);
=20
 	if (hwmon->xe->info.has_mbx_power_limits) {
-		xe_hwmon_pcode_read_power_limit(hwmon, attr, channel, &reg_val);
+		ret =3D xe_hwmon_pcode_read_power_limit(hwmon, attr, channel, &reg_val);
+		if (ret)
+			goto unlock;
 	} else {
 		rapl_limit =3D xe_hwmon_get_reg(hwmon, REG_PKG_RAPL_LIMIT, channel);
 		pkg_power_sku =3D xe_hwmon_get_reg(hwmon, REG_PKG_POWER_SKU, channel);
@@ -417,6 +457,7 @@ static void xe_hwmon_power_max_read(struct xe_hwmon *hw=
mon, u32 attr, int channe
 	}
 unlock:
 	mutex_unlock(&hwmon->hwmon_lock);
+	return ret;
 }
=20
 static int xe_hwmon_power_max_write(struct xe_hwmon *hwmon, u32 attr, int =
channel, long value)
@@ -439,7 +480,9 @@ static int xe_hwmon_power_max_write(struct xe_hwmon *hw=
mon, u32 attr, int channe
 			ret =3D xe_hwmon_pcode_rmw_power_limit(hwmon, attr, channel, PWR_LIM_EN=
, 0);
 			if (ret)
 				goto unlock;
-			xe_hwmon_pcode_read_power_limit(hwmon, attr, channel, &reg_val);
+			ret =3D xe_hwmon_pcode_read_power_limit(hwmon, attr, channel, &reg_val);
+			if (ret)
+				goto unlock;
 		} else {
 			reg_val =3D xe_mmio_rmw32(mmio, rapl_limit, PWR_LIM_EN, 0);
 			reg_val =3D xe_mmio_read32(mmio, rapl_limit);
@@ -496,15 +539,18 @@ static int xe_hwmon_power_max_write(struct xe_hwmon *=
hwmon, u32 attr, int channe
 	return ret;
 }
=20
-static void xe_hwmon_power_rated_max_read(struct xe_hwmon *hwmon, u32 attr=
, int channel,
-					  long *value)
+static int xe_hwmon_power_rated_max_read(struct xe_hwmon *hwmon, u32 attr,=
 int channel,
+					 long *value)
 {
 	struct xe_mmio *mmio =3D xe_root_tile_mmio(hwmon->xe);
 	u32 reg_val;
+	int ret =3D 0;
=20
 	if (hwmon->xe->info.has_mbx_power_limits) {
 		/* PL1 is rated max if supported. */
-		xe_hwmon_pcode_read_power_limit(hwmon, PL1_HWMON_ATTR, channel, &reg_val=
);
+		ret =3D xe_hwmon_pcode_read_power_limit(hwmon, PL1_HWMON_ATTR, channel, =
&reg_val);
+		if (ret)
+			return ret;
 	} else {
 		/*
 		 * This sysfs file won't be visible if REG_PKG_POWER_SKU is invalid, so =
valid check
@@ -518,6 +564,7 @@ static void xe_hwmon_power_rated_max_read(struct xe_hwm=
on *hwmon, u32 attr, int
=20
 	reg_val =3D REG_FIELD_GET(PKG_TDP, reg_val);
 	*value =3D mul_u64_u32_shr(reg_val, SF_POWER, hwmon->scl_shift_power);
+	return ret;
 }
=20
 /*
@@ -540,7 +587,7 @@ static void xe_hwmon_power_rated_max_read(struct xe_hwm=
on *hwmon, u32 attr, int
  * hwmon->scl_shift_energy of 14 bits we have 57 (63 - 20 + 14) bits before
  * energyN_input overflows. This at 1000 W is an overflow duration of 278 =
years.
  */
-static void
+static int
 xe_hwmon_energy_get(struct xe_hwmon *hwmon, int channel, long *energy)
 {
 	struct xe_mmio *mmio =3D xe_root_tile_mmio(hwmon->xe);
@@ -551,7 +598,7 @@ xe_hwmon_energy_get(struct xe_hwmon *hwmon, int channel=
, long *energy)
 	/* Energy is supported only for card and pkg */
 	if (channel > CHANNEL_PKG) {
 		*energy =3D 0;
-		return;
+		return 0;
 	}
=20
 	if (hwmon->xe->info.platform =3D=3D XE_BATTLEMAGE) {
@@ -563,7 +610,7 @@ xe_hwmon_energy_get(struct xe_hwmon *hwmon, int channel=
, long *energy)
 		if (ret !=3D sizeof(pmt_val)) {
 			drm_warn(&hwmon->xe->drm, "energy read from pmt failed, ret %d\n", ret);
 			*energy =3D 0;
-			return;
+			return ret < 0 ? ret : -EIO;
 		}
=20
 		if (channel =3D=3D CHANNEL_PKG)
@@ -580,6 +627,7 @@ xe_hwmon_energy_get(struct xe_hwmon *hwmon, int channel=
, long *energy)
=20
 	*energy =3D mul_u64_u32_shr(ei->accum_energy, SF_ENERGY,
 				  hwmon->scl_shift_energy);
+	return 0;
 }
=20
 static ssize_t
@@ -602,10 +650,11 @@ xe_hwmon_power_max_interval_show(struct device *dev, =
struct device_attribute *at
 	if (hwmon->xe->info.has_mbx_power_limits) {
 		ret =3D xe_hwmon_pcode_read_power_limit(hwmon, power_attr, channel, &reg=
_val);
 		if (ret) {
-			drm_err(&hwmon->xe->drm,
-				"power interval read fail, ch %d, attr %d, val 0x%08x, ret %d\n",
-				channel, power_attr, reg_val, ret);
-			reg_val =3D 0;
+			xe_log_err(hwmon->xe, HWMON, ret,
+				   "Power interval read fail, ch %d, attr %d, val 0x%08x\n",
+				   channel, power_attr, reg_val);
+			mutex_unlock(&hwmon->hwmon_lock);
+			return ret;
 		}
 	} else {
 		reg_val =3D xe_mmio_read32(mmio, xe_hwmon_get_reg(hwmon, REG_PKG_RAPL_LI=
MIT,
@@ -797,30 +846,24 @@ static const struct attribute_group *hwmon_groups[] =
=3D {
 	NULL
 };
=20
+static const u32 hwmon_temp_config[CHANNEL_MAX + 1] =3D {
+	[CHANNEL_CARD] =3D HWMON_T_LABEL,
+	[CHANNEL_PKG] =3D HWMON_T_CRIT | HWMON_T_EMERGENCY | HWMON_T_INPUT |
+			 HWMON_T_LABEL | HWMON_T_MAX,
+	[CHANNEL_VRAM ... CHANNEL_PCIE] =3D HWMON_T_CRIT | HWMON_T_EMERGENCY |
+					 HWMON_T_INPUT | HWMON_T_LABEL,
+	[CHANNEL_VRAM_N ... CHANNEL_VRAM_N_MAX] =3D HWMON_T_CRIT | HWMON_T_EMERGE=
NCY |
+							 HWMON_T_INPUT | HWMON_T_LABEL,
+	[CHANNEL_MAX] =3D 0, /* hwmon config terminator */
+};
+
+static const struct hwmon_channel_info hwmon_temp_info =3D {
+	.type =3D hwmon_temp,
+	.config =3D hwmon_temp_config,
+};
+
 static const struct hwmon_channel_info * const hwmon_info[] =3D {
-	HWMON_CHANNEL_INFO(temp,
-			   HWMON_T_LABEL,
-			   HWMON_T_CRIT | HWMON_T_EMERGENCY | HWMON_T_INPUT | HWMON_T_LABEL |
-			   HWMON_T_MAX,
-			   HWMON_T_CRIT | HWMON_T_EMERGENCY | HWMON_T_INPUT | HWMON_T_LABEL,
-			   HWMON_T_CRIT | HWMON_T_EMERGENCY | HWMON_T_INPUT | HWMON_T_LABEL,
-			   HWMON_T_CRIT | HWMON_T_EMERGENCY | HWMON_T_INPUT | HWMON_T_LABEL,
-			   HWMON_T_CRIT | HWMON_T_EMERGENCY | HWMON_T_INPUT | HWMON_T_LABEL,
-			   HWMON_T_CRIT | HWMON_T_EMERGENCY | HWMON_T_INPUT | HWMON_T_LABEL,
-			   HWMON_T_CRIT | HWMON_T_EMERGENCY | HWMON_T_INPUT | HWMON_T_LABEL,
-			   HWMON_T_CRIT | HWMON_T_EMERGENCY | HWMON_T_INPUT | HWMON_T_LABEL,
-			   HWMON_T_CRIT | HWMON_T_EMERGENCY | HWMON_T_INPUT | HWMON_T_LABEL,
-			   HWMON_T_CRIT | HWMON_T_EMERGENCY | HWMON_T_INPUT | HWMON_T_LABEL,
-			   HWMON_T_CRIT | HWMON_T_EMERGENCY | HWMON_T_INPUT | HWMON_T_LABEL,
-			   HWMON_T_CRIT | HWMON_T_EMERGENCY | HWMON_T_INPUT | HWMON_T_LABEL,
-			   HWMON_T_CRIT | HWMON_T_EMERGENCY | HWMON_T_INPUT | HWMON_T_LABEL,
-			   HWMON_T_CRIT | HWMON_T_EMERGENCY | HWMON_T_INPUT | HWMON_T_LABEL,
-			   HWMON_T_CRIT | HWMON_T_EMERGENCY | HWMON_T_INPUT | HWMON_T_LABEL,
-			   HWMON_T_CRIT | HWMON_T_EMERGENCY | HWMON_T_INPUT | HWMON_T_LABEL,
-			   HWMON_T_CRIT | HWMON_T_EMERGENCY | HWMON_T_INPUT | HWMON_T_LABEL,
-			   HWMON_T_CRIT | HWMON_T_EMERGENCY | HWMON_T_INPUT | HWMON_T_LABEL,
-			   HWMON_T_CRIT | HWMON_T_EMERGENCY | HWMON_T_INPUT | HWMON_T_LABEL,
-			   HWMON_T_CRIT | HWMON_T_EMERGENCY | HWMON_T_INPUT | HWMON_T_LABEL),
+	&hwmon_temp_info,
 	HWMON_CHANNEL_INFO(power, HWMON_P_MAX | HWMON_P_RATED_MAX | HWMON_P_LABEL=
 | HWMON_P_CRIT |
 			   HWMON_P_CAP,
 			   HWMON_P_MAX | HWMON_P_RATED_MAX | HWMON_P_LABEL | HWMON_P_CAP),
@@ -834,9 +877,31 @@ static const struct hwmon_channel_info * const hwmon_i=
nfo[] =3D {
 static int xe_hwmon_pcode_read_thermal_info(struct xe_hwmon *hwmon)
 {
 	struct xe_tile *root_tile =3D xe_device_get_root_tile(hwmon->xe);
+	struct xe_mmio *mmio =3D xe_root_tile_mmio(hwmon->xe);
 	u32 config =3D 0, data0 =3D 0, data1 =3D 0;
 	int ret;
=20
+	/*
+	 * Only CRI reports dynamic VRAM channel state. Fixed-channel platforms
+	 * set the count up front so those sensors stay visible even if the therm=
al
+	 * mailbox reads below fail.
+	 */
+	if (hwmon->xe->info.has_fixed_vram_channels)
+		hwmon->temp.vram_count =3D FIXED_VRAM_CHANNELS;
+
+	if (hwmon->xe->info.platform =3D=3D XE_CRESCENTISLAND) {
+		hwmon->temp.msu_mask =3D xe_mmio_read32(mmio, CRI_MSU_VRAM_ENABLE);
+		hwmon->temp.vram_count =3D fls(hwmon->temp.msu_mask) * VRAM_CHANNELS_PER=
_MSU;
+		drm_dbg(&hwmon->xe->drm, "MSU VRAM enable mask 0x%x, VRAM channel bound =
%d\n",
+			hwmon->temp.msu_mask, hwmon->temp.vram_count);
+		if (hwmon->temp.vram_count > MAX_VRAM_CHANNELS) {
+			drm_warn(&hwmon->xe->drm,
+				 "VRAM channel bound %d exceeds max %d, clamping\n",
+				 hwmon->temp.vram_count, MAX_VRAM_CHANNELS);
+			hwmon->temp.vram_count =3D MAX_VRAM_CHANNELS;
+		}
+	}
+
 	ret =3D xe_pcode_read(root_tile, PCODE_MBOX(PCODE_THERMAL_INFO, READ_THER=
MAL_LIMITS, 0),
 			    &data0, &data1);
 	if (ret)
@@ -889,17 +954,43 @@ static int mbx_temp_decode(u8 value)
 	return (value & TEMP_MBX_SIGN) ? -temp : temp;
 }
=20
+static u8 xe_hwmon_pcie_temp_index(const struct xe_hwmon *hwmon)
+{
+	if (hwmon->xe->info.platform =3D=3D XE_CRESCENTISLAND)
+		return CRI_TEMP_INDEX_PCIE;
+
+	if (hwmon->xe->info.subplatform =3D=3D XE_SUBPLATFORM_BATTLEMAGE_G21)
+		return BMG_G21_TEMP_INDEX_PCIE;
+
+	return TEMP_INDEX_PCIE;
+}
+
 static int get_mc_temp(struct xe_hwmon *hwmon, long *val)
 {
 	struct xe_tile *root_tile =3D xe_device_get_root_tile(hwmon->xe);
-	int ret, i, count =3D 0;
+	int ret, i, start, end, count =3D 0;
 	s32 average =3D 0;
+	u32 data =3D 0;
=20
 	guard(mutex)(&hwmon->hwmon_lock);
=20
-	for (i =3D 0; i < DIV_ROUND_UP(hwmon->temp.count, sizeof(u32)); i++) {
-		u32 data =3D 0;
+	/* CRI relocated the memory controller temperatures to READ_THERMAL_DATA =
bytes 16..19. */
+	if (hwmon->xe->info.platform =3D=3D XE_CRESCENTISLAND) {
+		start =3D CRI_TEMP_INDEX_MCTRL;
+		end =3D CRI_TEMP_INDEX_MCTRL + CRI_TEMP_MCTRL_COUNT;
+	} else {
+		start =3D TEMP_INDEX_MCTRL;
+		end =3D min_t(int, hwmon->temp.count - 1, xe_hwmon_pcie_temp_index(hwmon=
));
+	}
=20
+	if (end <=3D start || end > hwmon->temp.count) {
+		drm_warn(&hwmon->xe->drm,
+			 "memory controller range [%d, %d) is invalid for temperature count %d\=
n",
+			 start, end, hwmon->temp.count);
+		return -ENODATA;
+	}
+
+	for (i =3D start / sizeof(u32); i < DIV_ROUND_UP(end, sizeof(u32)); i++) {
 		ret =3D xe_pcode_read(root_tile, PCODE_MBOX(PCODE_THERMAL_INFO, READ_THE=
RMAL_DATA, i),
 				    &data, NULL);
 		if (ret)
@@ -908,7 +999,7 @@ static int get_mc_temp(struct xe_hwmon *hwmon, long *va=
l)
 		hwmon->temp.dword[i] =3D cpu_to_le32(data);
 	}
=20
-	for (i =3D TEMP_INDEX_MCTRL; i < hwmon->temp.count - 1; i++) {
+	for (i =3D start; i < end; i++) {
 		if (!mbx_temp_valid(hwmon, hwmon->temp.value[i]))
 			continue;
 		average +=3D mbx_temp_decode(hwmon->temp.value[i]);
@@ -928,23 +1019,36 @@ static int get_mc_temp(struct xe_hwmon *hwmon, long =
*val)
 	return 0;
 }
=20
-static int get_pcie_temp(struct xe_hwmon *hwmon, long *val)
+static int get_pcie_temp(const struct xe_hwmon *hwmon, long *val)
 {
 	struct xe_tile *root_tile =3D xe_device_get_root_tile(hwmon->xe);
 	u32 data =3D 0;
+	int index;
 	int ret;
=20
+	index =3D xe_hwmon_pcie_temp_index(hwmon);
+	if (index >=3D hwmon->temp.count) {
+		drm_warn(&hwmon->xe->drm,
+			 "PCIe temperature index %d out of range for temperature count %d\n",
+			 index, hwmon->temp.count);
+		return -ENODATA;
+	}
+
 	ret =3D xe_pcode_read(root_tile, PCODE_MBOX(PCODE_THERMAL_INFO, READ_THER=
MAL_DATA,
-						  PCIE_SENSOR_GROUP_ID), &data, NULL);
+						  index / sizeof(data)),
+						  &data, NULL);
 	if (ret)
 		return ret;
=20
-	/* Sensor offset is different for G21 */
-	if (hwmon->xe->info.subplatform !=3D XE_SUBPLATFORM_BATTLEMAGE_G21)
-		data =3D REG_FIELD_GET(PCIE_SENSOR_MASK, data);
-
+	data >>=3D (index % sizeof(data)) * BITS_PER_BYTE;
 	data =3D REG_FIELD_GET(TEMP_MASK, data);
-	*val =3D mbx_temp_decode(data) * MILLIDEGREE_PER_DEGREE;
+	if (!mbx_temp_valid(hwmon, data)) {
+		drm_dbg(&hwmon->xe->drm, "PCIe temperature not available\n");
+		return -ENXIO;
+	}
+
+	if (val)
+		*val =3D mbx_temp_decode(data) * MILLIDEGREE_PER_DEGREE;
=20
 	return 0;
 }
@@ -1043,19 +1147,70 @@ static void xe_hwmon_get_voltage(struct xe_hwmon *h=
wmon, int channel, long *valu
 	*value =3D DIV_ROUND_CLOSEST(REG_FIELD_GET(VOLTAGE_MASK, reg_val) * 2500,=
 SF_VOLTAGE);
 }
=20
-static inline bool is_vram_ch_available(struct xe_hwmon *hwmon, int channe=
l)
+static bool xe_hwmon_temp_probe(struct xe_hwmon *hwmon, int channel)
 {
 	struct xe_mmio *mmio =3D xe_root_tile_mmio(hwmon->xe);
-	int vram_id =3D channel - CHANNEL_VRAM_N;
-	struct xe_reg vram_reg;
+	struct xe_reg reg;
+	u32 reg_val;
=20
-	vram_reg =3D xe_hwmon_get_reg(hwmon, REG_TEMP, channel);
-	if (!xe_reg_is_valid(vram_reg) || !xe_mmio_read32(mmio, vram_reg))
+	switch (channel) {
+	case CHANNEL_PKG:
+	case CHANNEL_VRAM:
+	case CHANNEL_VRAM_N...CHANNEL_VRAM_N_MAX:
+		reg =3D xe_hwmon_get_reg(hwmon, REG_TEMP, channel);
+		if (!xe_reg_is_valid(reg))
+			return false;
+
+		/*
+		 * On CRI, VRAM channel presence comes from the MSU enable mask
+		 * (applied in xe_hwmon_get_reg()); the temperature register's
+		 * 0xffffffff sentinel is not reliable for VRAM channels.
+		 */
+		if (hwmon->xe->info.platform =3D=3D XE_CRESCENTISLAND && channel >=3D CH=
ANNEL_VRAM_N)
+			return true;
+
+		reg_val =3D xe_mmio_read32(mmio, reg);
+		if (!mmio_temp_valid(hwmon, reg_val)) {
+			drm_dbg(&hwmon->xe->drm,
+				"channel %d temperature unavailable, val 0x%x\n", channel, reg_val);
+			return false;
+		}
+
+		return true;
+	case CHANNEL_MCTRL:
+		return hwmon->temp.count && !get_mc_temp(hwmon, NULL);
+	case CHANNEL_PCIE:
+		return hwmon->temp.count && !get_pcie_temp(hwmon, NULL);
+	default:
 		return false;
+	}
+}
=20
-	/* Create label only for available vram channel */
-	sprintf(hwmon->temp.vram_label[vram_id], "vram_ch_%d", vram_id);
-	return true;
+static int xe_hwmon_init_temp_info(struct xe_hwmon *hwmon)
+{
+	struct device *dev =3D hwmon->xe->drm.dev;
+	int channel;
+
+	if (hwmon->xe->info.has_mbx_thermal_info && xe_hwmon_pcode_read_thermal_i=
nfo(hwmon))
+		drm_warn(&hwmon->xe->drm, "Thermal mailbox not supported by card firmwar=
e\n");
+
+	/* vram_count is known only after reading thermal info above. */
+	if (hwmon->temp.vram_count) {
+		hwmon->temp.vram_label =3D devm_kcalloc(dev, hwmon->temp.vram_count,
+						      MAX_LABEL_SIZE, GFP_KERNEL);
+		if (!hwmon->temp.vram_label)
+			return -ENOMEM;
+	}
+
+	for (channel =3D 0; channel < CHANNEL_MAX; channel++) {
+		hwmon->temp.available[channel] =3D xe_hwmon_temp_probe(hwmon, channel);
+		if (hwmon->temp.available[channel] && hwmon->temp.vram_label &&
+		    in_range(channel, CHANNEL_VRAM_N, hwmon->temp.vram_count))
+			snprintf(hwmon->temp.vram_label[channel - CHANNEL_VRAM_N], MAX_LABEL_SI=
ZE,
+				 "vram_ch_%d", channel - CHANNEL_VRAM_N);
+	}
+
+	return 0;
 }
=20
 static umode_t
@@ -1065,14 +1220,13 @@ xe_hwmon_temp_is_visible(struct xe_hwmon *hwmon, u3=
2 attr, int channel)
 	case hwmon_temp_emergency:
 		switch (channel) {
 		case CHANNEL_PKG:
-			return hwmon->temp.limit[TEMP_LIMIT_PKG_SHUTDOWN] ? 0444 : 0;
-		case CHANNEL_VRAM:
-			return hwmon->temp.limit[TEMP_LIMIT_MEM_SHUTDOWN] ? 0444 : 0;
 		case CHANNEL_MCTRL:
 		case CHANNEL_PCIE:
-			return hwmon->temp.count ? 0444 : 0;
+			return (hwmon->temp.available[channel] &&
+				hwmon->temp.limit[TEMP_LIMIT_PKG_SHUTDOWN]) ? 0444 : 0;
+		case CHANNEL_VRAM:
 		case CHANNEL_VRAM_N...CHANNEL_VRAM_N_MAX:
-			return (is_vram_ch_available(hwmon, channel) &&
+			return (hwmon->temp.available[channel] &&
 				hwmon->temp.limit[TEMP_LIMIT_MEM_SHUTDOWN]) ? 0444 : 0;
 		default:
 			return 0;
@@ -1080,14 +1234,13 @@ xe_hwmon_temp_is_visible(struct xe_hwmon *hwmon, u3=
2 attr, int channel)
 	case hwmon_temp_crit:
 		switch (channel) {
 		case CHANNEL_PKG:
-			return hwmon->temp.limit[TEMP_LIMIT_PKG_CRIT] ? 0444 : 0;
-		case CHANNEL_VRAM:
-			return hwmon->temp.limit[TEMP_LIMIT_MEM_CRIT] ? 0444 : 0;
 		case CHANNEL_MCTRL:
 		case CHANNEL_PCIE:
-			return hwmon->temp.count ? 0444 : 0;
+			return (hwmon->temp.available[channel] &&
+				hwmon->temp.limit[TEMP_LIMIT_PKG_CRIT]) ? 0444 : 0;
+		case CHANNEL_VRAM:
 		case CHANNEL_VRAM_N...CHANNEL_VRAM_N_MAX:
-			return (is_vram_ch_available(hwmon, channel) &&
+			return (hwmon->temp.available[channel] &&
 				hwmon->temp.limit[TEMP_LIMIT_MEM_CRIT]) ? 0444 : 0;
 		default:
 			return 0;
@@ -1095,7 +1248,8 @@ xe_hwmon_temp_is_visible(struct xe_hwmon *hwmon, u32 =
attr, int channel)
 	case hwmon_temp_max:
 		switch (channel) {
 		case CHANNEL_PKG:
-			return hwmon->temp.limit[TEMP_LIMIT_PKG_MAX] ? 0444 : 0;
+			return (hwmon->temp.available[channel] &&
+				hwmon->temp.limit[TEMP_LIMIT_PKG_MAX]) ? 0444 : 0;
 		default:
 			return 0;
 		}
@@ -1104,13 +1258,10 @@ xe_hwmon_temp_is_visible(struct xe_hwmon *hwmon, u3=
2 attr, int channel)
 		switch (channel) {
 		case CHANNEL_PKG:
 		case CHANNEL_VRAM:
-			return xe_reg_is_valid(xe_hwmon_get_reg(hwmon, REG_TEMP,
-								channel)) ? 0444 : 0;
 		case CHANNEL_MCTRL:
 		case CHANNEL_PCIE:
-			return hwmon->temp.count ? 0444 : 0;
 		case CHANNEL_VRAM_N...CHANNEL_VRAM_N_MAX:
-			return is_vram_ch_available(hwmon, channel) ? 0444 : 0;
+			return hwmon->temp.available[channel] ? 0444 : 0;
 		default:
 			return 0;
 		}
@@ -1119,6 +1270,70 @@ xe_hwmon_temp_is_visible(struct xe_hwmon *hwmon, u32=
 attr, int channel)
 	}
 }
=20
+#define IEEE754_SIGN		REG_BIT(31)
+#define IEEE754_EXP_MASK	REG_GENMASK(30, 23)
+#define IEEE754_MANTISSA_MASK	REG_GENMASK(22, 0)
+#define IEEE754_EXP_BIAS	127 /* Exponent bias to obtain the actual exponen=
t */
+#define IEEE754_MANTISSA_BITS	23 /* Mantissa width and implicit leading-1 =
bit position */
+#define IEEE754_EXP_SPECIAL	0xff /* reserved exponent value encoding infin=
ity or NaN */
+
+/**
+ * xe_hwmon_temperature_decode - Decode an IEEE-754 temperature register v=
alue
+ * @reg_val: The raw register value to decode
+ * @temperature: Pointer to store the decoded temperature in millidegrees =
Celsius.
+ *
+ * IEEE-754 single-precision format:
+ *
+ *  31 30                         23 22                         0
+ * +--+-----------------------------+----------------------------+
+ * | S|          exponent           |          fraction          |
+ * +--+-----------------------------+----------------------------+
+ *
+ * value =3D (-1)^S * 1.fraction * 2^(exponent - 127)
+ *
+ * Return: 0 on success or an error if @reg_val is non-finite or cannot be
+ * represented in millidegrees Celsius.
+ */
+static int xe_hwmon_temperature_decode(u32 reg_val, long *temperature)
+{
+	u32 exponent =3D REG_FIELD_GET(IEEE754_EXP_MASK, reg_val);
+	u32 mantissa =3D REG_FIELD_GET(IEEE754_MANTISSA_MASK, reg_val);
+	s64 value;
+	int shift;
+
+	/* Exponent 0xff encodes infinity or NaN. */
+	if (exponent =3D=3D IEEE754_EXP_SPECIAL)
+		return -EINVAL;
+
+	/* Subnormal values are smaller than one millidegree Celsius. */
+	if (!exponent) {
+		*temperature =3D 0;
+		return 0;
+	}
+
+	value =3D (s64)(mantissa | BIT(IEEE754_MANTISSA_BITS)) * MILLIDEGREE_PER_=
DEGREE;
+	shift =3D exponent - (IEEE754_EXP_BIAS + IEEE754_MANTISSA_BITS);
+	if (shift >=3D 0) {
+		if (shift >=3D BITS_PER_LONG || value > (LONG_MAX >> shift))
+			return -ERANGE;
+		value <<=3D shift;
+	} else if (shift > -64) {
+		value >>=3D -shift;
+	} else {
+		value =3D 0;
+	}
+
+	/* Ensure the decoded value fits in a long. */
+	if (overflows_type(value, *temperature))
+		return -ERANGE;
+
+	if (reg_val & IEEE754_SIGN)
+		value =3D -value;
+
+	*temperature =3D value;
+	return 0;
+}
+
 static int
 xe_hwmon_temp_read(struct xe_hwmon *hwmon, u32 attr, int channel, long *va=
l)
 {
@@ -1128,26 +1343,33 @@ xe_hwmon_temp_read(struct xe_hwmon *hwmon, u32 attr=
, int channel, long *val)
 	switch (attr) {
 	case hwmon_temp_input:
 		switch (channel) {
-		case CHANNEL_PKG:
-		case CHANNEL_VRAM:
-			reg_val =3D xe_mmio_read32(mmio, xe_hwmon_get_reg(hwmon, REG_TEMP, chan=
nel));
-
-			/* HW register value is in degrees Celsius, convert to millidegrees. */
-			*val =3D REG_FIELD_GET(TEMP_MASK, reg_val) * MILLIDEGREE_PER_DEGREE;
-			return 0;
 		case CHANNEL_MCTRL:
 			return get_mc_temp(hwmon, val);
 		case CHANNEL_PCIE:
 			return get_pcie_temp(hwmon, val);
+		case CHANNEL_PKG:
+		case CHANNEL_VRAM:
 		case CHANNEL_VRAM_N...CHANNEL_VRAM_N_MAX:
 			reg_val =3D xe_mmio_read32(mmio, xe_hwmon_get_reg(hwmon, REG_TEMP, chan=
nel));
-			/*
-			 * This temperature format is 24 bit [31:8] signed integer and 8 bit
-			 * [7:0] fraction.
-			 */
-			*val =3D (s32)(REG_FIELD_GET(TEMP_MASK_VRAM_N, reg_val)) *
-				(REG_FIELD_GET(TEMP_SIGN_MASK, reg_val) ? -1 : 1) *
-				 MILLIDEGREE_PER_DEGREE;
+			if (!mmio_temp_valid(hwmon, reg_val)) {
+				drm_dbg(&hwmon->xe->drm,
+					"channel %d temperature invalid, val 0x%llx\n",
+					channel, reg_val);
+				return -ENXIO;
+			}
+			if (hwmon->xe->info.platform >=3D XE_CRESCENTISLAND) {
+				return xe_hwmon_temperature_decode((u32)reg_val, val);
+			} else if (channel >=3D CHANNEL_VRAM_N) {
+				/*
+				 * This temperature format is 24 bit [31:8] signed integer and 8 bit
+				 * [7:0] fraction for platforms before CRI.
+				 */
+				*val =3D (s32)REG_FIELD_GET(TEMP_MASK_VRAM_N, reg_val) *
+					(REG_FIELD_GET(TEMP_SIGN_MASK, reg_val) ? -1 : 1) *
+					MILLIDEGREE_PER_DEGREE;
+			} else {
+				*val =3D REG_FIELD_GET(TEMP_MASK, reg_val) * MILLIDEGREE_PER_DEGREE;
+			}
 			return 0;
 		default:
 			return -EOPNOTSUPP;
@@ -1229,7 +1451,8 @@ xe_hwmon_power_is_visible(struct xe_hwmon *hwmon, u32=
 attr, int channel)
 		}
 	case hwmon_power_crit:
 		if (channel =3D=3D CHANNEL_CARD) {
-			xe_hwmon_pcode_read_i1(hwmon, &uval);
+			if (xe_hwmon_pcode_read_i1(hwmon, &uval))
+				return 0;
 			return (uval & POWER_SETUP_I1_WATTS) ? 0644 : 0;
 		}
 		break;
@@ -1248,7 +1471,8 @@ xe_hwmon_power_is_visible(struct xe_hwmon *hwmon, u32=
 attr, int channel)
 			}
 		}
 		if ((!(uval & PWR_LIM_EN)) && channel =3D=3D CHANNEL_CARD) {
-			xe_hwmon_pcode_read_i1(hwmon, &uval);
+			if (xe_hwmon_pcode_read_i1(hwmon, &uval))
+				return 0;
 			return (uval & POWER_SETUP_I1_WATTS) ? 0444 : 0;
 		}
 		return (uval) ? 0444 : 0;
@@ -1264,11 +1488,9 @@ xe_hwmon_power_read(struct xe_hwmon *hwmon, u32 attr=
, int channel, long *val)
 	switch (attr) {
 	case hwmon_power_max:
 	case hwmon_power_cap:
-		xe_hwmon_power_max_read(hwmon, attr, channel, val);
-		return 0;
+		return xe_hwmon_power_max_read(hwmon, attr, channel, val);
 	case hwmon_power_rated_max:
-		xe_hwmon_power_rated_max_read(hwmon, attr, channel, val);
-		return 0;
+		return xe_hwmon_power_rated_max_read(hwmon, attr, channel, val);
 	case hwmon_power_crit:
 		return xe_hwmon_power_curr_crit_read(hwmon, channel, val, SF_POWER);
 	default:
@@ -1385,8 +1607,7 @@ xe_hwmon_energy_read(struct xe_hwmon *hwmon, u32 attr=
, int channel, long *val)
 {
 	switch (attr) {
 	case hwmon_energy_input:
-		xe_hwmon_energy_get(hwmon, channel, val);
-		return 0;
+		return xe_hwmon_energy_get(hwmon, channel, val);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -1555,8 +1776,10 @@ static int xe_hwmon_read_label(struct device *dev,
 			*str =3D "mctrl";
 		else if (channel =3D=3D CHANNEL_PCIE)
 			*str =3D "pcie";
-		else if (in_range(channel, CHANNEL_VRAM_N, MAX_VRAM_CHANNELS))
+		else if (in_range(channel, CHANNEL_VRAM_N, hwmon->temp.vram_count))
 			*str =3D hwmon->temp.vram_label[channel - CHANNEL_VRAM_N];
+		else
+			return -EOPNOTSUPP;
 		return 0;
 	case hwmon_power:
 	case hwmon_energy:
@@ -1584,7 +1807,7 @@ static const struct hwmon_chip_info hwmon_chip_info =
=3D {
 	.info =3D hwmon_info,
 };
=20
-static void
+static int
 xe_hwmon_get_preregistration_info(struct xe_hwmon *hwmon)
 {
 	struct xe_mmio *mmio =3D xe_root_tile_mmio(hwmon->xe);
@@ -1641,8 +1864,7 @@ xe_hwmon_get_preregistration_info(struct xe_hwmon *hw=
mon)
 		if (xe_hwmon_is_visible(hwmon, hwmon_fan, hwmon_fan_input, channel))
 			xe_hwmon_fan_input_read(hwmon, channel, &fan_speed);
=20
-	if (hwmon->xe->info.has_mbx_thermal_info && xe_hwmon_pcode_read_thermal_i=
nfo(hwmon))
-		drm_warn(&hwmon->xe->drm, "Thermal mailbox not supported by card firmwar=
e\n");
+	return xe_hwmon_init_temp_info(hwmon);
 }
=20
 int xe_hwmon_register(struct xe_device *xe)
@@ -1671,7 +1893,9 @@ int xe_hwmon_register(struct xe_device *xe)
 	hwmon->xe =3D xe;
 	xe->hwmon =3D hwmon;
=20
-	xe_hwmon_get_preregistration_info(hwmon);
+	ret =3D xe_hwmon_get_preregistration_info(hwmon);
+	if (ret)
+		goto err_null_hwmon;
=20
 	drm_dbg(&xe->drm, "Register xe hwmon interface\n");
=20
@@ -1680,11 +1904,15 @@ int xe_hwmon_register(struct xe_device *xe)
 								&hwmon_chip_info,
 								hwmon_groups);
 	if (IS_ERR(hwmon->hwmon_dev)) {
-		drm_err(&xe->drm, "Failed to register xe hwmon (%pe)\n", hwmon->hwmon_de=
v);
-		xe->hwmon =3D NULL;
-		return PTR_ERR(hwmon->hwmon_dev);
+		ret =3D PTR_ERR(hwmon->hwmon_dev);
+		xe_log_err(xe, HWMON, ret, "Failed to register xe hwmon\n");
+		goto err_null_hwmon;
 	}
=20
 	return 0;
+
+err_null_hwmon:
+	xe->hwmon =3D NULL;
+	return ret;
 }
 MODULE_IMPORT_NS("INTEL_PMT_TELEMETRY");
diff --git a/drivers/gpu/drm/xe/xe_late_bind_fw.c b/drivers/gpu/drm/xe/xe_l=
ate_bind_fw.c
index 1bddfaf0fb9f0..355d7c841871d 100644
--- a/drivers/gpu/drm/xe/xe_late_bind_fw.c
+++ b/drivers/gpu/drm/xe/xe_late_bind_fw.c
@@ -17,6 +17,12 @@
 #include "xe_pcode.h"
 #include "xe_pcode_api.h"
 #include "xe_pm.h"
+#include "xe_sysctrl.h"
+
+/*
+ * TODO: Add MODULE_FIRMWARE() for xe/cri_ocode_<ver>.bin once the
+ *       Ocode firmware binary is available upstream.
+ */
=20
 /*
  * The component should load quite quickly in most cases, but it could take
@@ -33,10 +39,12 @@
=20
 static const u32 fw_id_to_type[] =3D {
 		[XE_LB_FW_FAN_CONTROL] =3D INTEL_LB_TYPE_FAN_CONTROL,
+		[XE_LB_FW_OCODE] =3D INTEL_LB_TYPE_OCODE,
 	};
=20
 static const char * const fw_id_to_name[] =3D {
 		[XE_LB_FW_FAN_CONTROL] =3D "fan_control",
+		[XE_LB_FW_OCODE] =3D "ocode",
 	};
=20
 static struct xe_device *
@@ -104,6 +112,7 @@ static int parse_cpd_header(struct xe_late_bind_fw *lb_=
fw,
 	manifest =3D data + offset;
=20
 	lb_fw->version =3D manifest->fw_version;
+	lb_fw->sdk_api_version =3D manifest->ocode_data.sdk_api_version;
=20
 	return 0;
 }
@@ -179,6 +188,34 @@ static const char *xe_late_bind_parse_status(uint32_t =
status)
 		return "Invalid Payload";
 	case INTEL_LB_STATUS_TIMEOUT:
 		return "Timeout";
+	case INTEL_LB_STATUS_BUFFER_TOO_SMALL:
+		return "Buffer too small";
+	case INTEL_LB_STATUS_INTERNAL_ERROR:
+		return "Internal Error";
+	case INTEL_LB_STATUS_INVALID_FPT_TABLE:
+		return "Invalid FPT Table";
+	case INTEL_LB_STATUS_SIGNED_PAYLOAD_VERIFICATION_ERROR:
+		return "Signed Payload Verification Error";
+	case INTEL_LB_STATUS_SIGNED_PAYLOAD_INVALID_CPD:
+		return "Signed Payload Invalid CPD";
+	case INTEL_LB_STATUS_SIGNED_PAYLOAD_FW_VERSION_MISMATCH:
+		return "Signed Payload FW Version Mismatch";
+	case INTEL_LB_STATUS_SIGNED_PAYLOAD_INVALID_MANIFEST:
+		return "Signed Payload Invalid Manifest";
+	case INTEL_LB_STATUS_SIGNED_PAYLOAD_INVALID_HASH:
+		return "Signed Payload Invalid Hash";
+	case INTEL_LB_STATUS_SIGNED_PAYLOAD_BINDING_TYPE_MISMATCH:
+		return "Signed Payload Binding type Mismatch";
+	case INTEL_LB_STATUS_SIGNED_PAYLOAD_HANDLE_SVN_FAILED:
+		return "Signed Payload Handle SVN Failed";
+	case INTEL_LB_STATUS_DESTINATION_MBOX_FAILURE:
+		return "Destination MBOX Failure";
+	case INTEL_LB_STATUS_MISSING_LOADING_PATCH:
+		return "Missing Loading Patch";
+	case INTEL_LB_STATUS_INVALID_COMMAND:
+		return "Invalid Command";
+	case INTEL_LB_STATUS_INVALID_HECI_HEADER:
+		return "Invalid HECI Header";
 	default:
 		return "Unknown error";
 	}
@@ -193,7 +230,7 @@ static int xe_late_bind_fw_num_fans(struct xe_late_bind=
 *late_bind, u32 *num_fan
 			     PCODE_MBOX(FAN_SPEED_CONTROL, FSC_READ_NUM_FANS, 0), num_fans, NUL=
L);
 }
=20
-void xe_late_bind_wait_for_worker_completion(struct xe_late_bind *late_bin=
d)
+static void wait_for_worker_completion(struct xe_late_bind *late_bind)
 {
 	struct xe_device *xe =3D late_bind_to_xe(late_bind);
 	struct xe_late_bind_fw *lbfw;
@@ -269,18 +306,12 @@ static void xe_late_bind_work(struct work_struct *wor=
k)
 	xe_pm_runtime_put(xe);
 }
=20
-int xe_late_bind_fw_load(struct xe_late_bind *late_bind)
+static void xe_late_bind_fw_load(struct xe_late_bind *late_bind)
 {
 	struct xe_device *xe =3D late_bind_to_xe(late_bind);
 	struct xe_late_bind_fw *lbfw;
 	int fw_id;
=20
-	if (!late_bind->component_added)
-		return -ENODEV;
-
-	if (late_bind->disable)
-		return 0;
-
 	for (fw_id =3D 0; fw_id < XE_LB_FW_MAX_ID; fw_id++) {
 		lbfw =3D &late_bind->late_bind_fw[fw_id];
 		if (lbfw->payload) {
@@ -288,7 +319,6 @@ int xe_late_bind_fw_load(struct xe_late_bind *late_bind)
 			queue_work(late_bind->wq, &lbfw->work);
 		}
 	}
-	return 0;
 }
=20
 static int __xe_late_bind_fw_init(struct xe_late_bind *late_bind, u32 fw_i=
d)
@@ -298,6 +328,7 @@ static int __xe_late_bind_fw_init(struct xe_late_bind *=
late_bind, u32 fw_id)
 	struct xe_late_bind_fw *lb_fw;
 	const struct firmware *fw;
 	u32 num_fans;
+	u16 sdk_ver =3D 0;
 	int ret;
=20
 	if (fw_id >=3D XE_LB_FW_MAX_ID)
@@ -320,9 +351,23 @@ static int __xe_late_bind_fw_init(struct xe_late_bind =
*late_bind, u32 fw_id)
 			return 0;
 	}
=20
-	snprintf(lb_fw->blob_path, sizeof(lb_fw->blob_path), "xe/%s_8086_%04x_%04=
x_%04x.bin",
-		 fw_id_to_name[lb_fw->id], pdev->device,
-		 pdev->subsystem_vendor, pdev->subsystem_device);
+	if (lb_fw->type =3D=3D INTEL_LB_TYPE_OCODE) {
+		/* Get SDK API version */
+		ret =3D xe_sysctrl_sdk_api_version(xe, &sdk_ver);
+		if (ret) {
+			drm_warn(&xe->drm, "Failed to get OCODE SDK API version: %pe\n",
+				 ERR_PTR(ret));
+			return 0;
+		}
+
+		snprintf(lb_fw->blob_path, sizeof(lb_fw->blob_path),
+			 "xe/cri_ocode_%u.bin", sdk_ver);
+	} else {
+		snprintf(lb_fw->blob_path, sizeof(lb_fw->blob_path),
+			 "xe/%s_8086_%04x_%04x_%04x.bin",
+			 fw_id_to_name[lb_fw->id], pdev->device,
+			 pdev->subsystem_vendor, pdev->subsystem_device);
+	}
=20
 	drm_dbg(&xe->drm, "Request late binding firmware %s\n", lb_fw->blob_path);
 	ret =3D firmware_request_nowarn(&fw, lb_fw->blob_path, xe->drm.dev);
@@ -332,17 +377,17 @@ static int __xe_late_bind_fw_init(struct xe_late_bind=
 *late_bind, u32 fw_id)
 		return 0;
 	}
=20
-	if (fw->size > XE_LB_MAX_PAYLOAD_SIZE) {
-		drm_err(&xe->drm, "Firmware %s size %zu is larger than max pay load size=
 %u\n",
-			lb_fw->blob_path, fw->size, XE_LB_MAX_PAYLOAD_SIZE);
-		ret =3D -ENODATA;
-		goto release_fw;
-	}
-
 	ret =3D parse_lb_layout(lb_fw, fw->data, fw->size, "LTES");
 	if (ret)
 		goto release_fw;
=20
+	if (lb_fw->type =3D=3D INTEL_LB_TYPE_OCODE && lb_fw->sdk_api_version !=3D=
 sdk_ver) {
+		drm_warn(&xe->drm, "%s late binding fw: SDK API version mismatch %u !=3D=
 %u\n",
+			 fw_id_to_name[lb_fw->id], lb_fw->sdk_api_version, sdk_ver);
+		ret =3D 0;
+		goto release_fw;
+	}
+
 	lb_fw->payload_size =3D fw->size;
 	lb_fw->payload =3D drmm_kzalloc(&xe->drm, lb_fw->payload_size, GFP_KERNEL=
);
 	if (!lb_fw->payload) {
@@ -355,6 +400,10 @@ static int __xe_late_bind_fw_init(struct xe_late_bind =
*late_bind, u32 fw_id)
 		 lb_fw->version.major, lb_fw->version.minor,
 		 lb_fw->version.hotfix, lb_fw->version.build);
=20
+	if (lb_fw->type =3D=3D INTEL_LB_TYPE_OCODE)
+		drm_info(&xe->drm, "%s firmware SDK API version %u\n",
+			 fw_id_to_name[lb_fw->id], lb_fw->sdk_api_version);
+
 	memcpy((void *)lb_fw->payload, fw->data, lb_fw->payload_size);
 	INIT_WORK(&lb_fw->work, xe_late_bind_work);
=20
@@ -365,6 +414,7 @@ static int __xe_late_bind_fw_init(struct xe_late_bind *=
late_bind, u32 fw_id)
=20
 static int xe_late_bind_fw_init(struct xe_late_bind *late_bind)
 {
+	struct xe_device *xe =3D late_bind_to_xe(late_bind);
 	int ret;
 	int fw_id;
=20
@@ -373,6 +423,8 @@ static int xe_late_bind_fw_init(struct xe_late_bind *la=
te_bind)
 		return -ENOMEM;
=20
 	for (fw_id =3D 0; fw_id < XE_LB_FW_MAX_ID; fw_id++) {
+		if (!(xe->info.late_bind_mask & BIT(fw_id)))
+			continue;
 		ret =3D __xe_late_bind_fw_init(late_bind, fw_id);
 		if (ret)
 			return ret;
@@ -399,7 +451,7 @@ static void xe_late_bind_component_unbind(struct device=
 *xe_kdev,
 	struct xe_device *xe =3D kdev_to_xe_device(xe_kdev);
 	struct xe_late_bind *late_bind =3D &xe->late_bind;
=20
-	xe_late_bind_wait_for_worker_completion(late_bind);
+	wait_for_worker_completion(late_bind);
=20
 	late_bind->component.ops =3D NULL;
 }
@@ -414,7 +466,7 @@ static void xe_late_bind_remove(void *arg)
 	struct xe_late_bind *late_bind =3D arg;
 	struct xe_device *xe =3D late_bind_to_xe(late_bind);
=20
-	xe_late_bind_wait_for_worker_completion(late_bind);
+	wait_for_worker_completion(late_bind);
=20
 	late_bind->component_added =3D false;
=20
@@ -425,6 +477,43 @@ static void xe_late_bind_remove(void *arg)
 	}
 }
=20
+static bool late_bind_mei_enabled(struct xe_device *xe)
+{
+	if (!IS_ENABLED(CONFIG_INTEL_MEI_LB))
+		return false;
+
+	/* MEI exposed as xe auxiliary device */
+	if (xe->info.has_heci_cscfi)
+		return IS_ENABLED(CONFIG_INTEL_MEI_GSC);
+
+	/* Standalone MEI PCI function */
+	return IS_ENABLED(CONFIG_INTEL_MEI_CSC);
+}
+
+/**
+ * xe_late_bind_pm_suspend() - Wait for pending late binding fw loads
+ * @late_bind: pointer to late bind structure.
+ */
+void xe_late_bind_pm_suspend(struct xe_late_bind *late_bind)
+{
+	if (!late_bind->component_added)
+		return;
+
+	wait_for_worker_completion(late_bind);
+}
+
+/**
+ * xe_late_bind_pm_resume() - Reload late binding fw after resume
+ * @late_bind: pointer to late bind structure.
+ */
+void xe_late_bind_pm_resume(struct xe_late_bind *late_bind)
+{
+	if (!late_bind->component_added || late_bind->disable)
+		return;
+
+	xe_late_bind_fw_load(late_bind);
+}
+
 /**
  * xe_late_bind_init() - add xe mei late binding component
  * @late_bind: pointer to late bind structure.
@@ -436,10 +525,10 @@ int xe_late_bind_init(struct xe_late_bind *late_bind)
 	struct xe_device *xe =3D late_bind_to_xe(late_bind);
 	int err;
=20
-	if (!xe->info.has_late_bind)
+	if (!xe->info.late_bind_mask)
 		return 0;
=20
-	if (!IS_ENABLED(CONFIG_INTEL_MEI_LB) || !IS_ENABLED(CONFIG_INTEL_MEI_GSC)=
) {
+	if (!late_bind_mei_enabled(xe)) {
 		drm_info(&xe->drm, "Can't init xe mei late bind missing mei component\n"=
);
 		return 0;
 	}
@@ -461,5 +550,7 @@ int xe_late_bind_init(struct xe_late_bind *late_bind)
 	if (err)
 		return err;
=20
-	return xe_late_bind_fw_load(late_bind);
+	xe_late_bind_fw_load(late_bind);
+
+	return 0;
 }
diff --git a/drivers/gpu/drm/xe/xe_mert.c b/drivers/gpu/drm/xe/xe_mert.c
index 934be933d57f7..a2eae6088c1ac 100644
--- a/drivers/gpu/drm/xe/xe_mert.c
+++ b/drivers/gpu/drm/xe/xe_mert.c
@@ -11,6 +11,7 @@
 #include "xe_mmio.h"
 #include "xe_sriov_printk.h"
 #include "xe_tile.h"
+#include "xe_wedge.h"
=20
 /**
  * xe_mert_init_early() - Initialize MERT data
@@ -74,8 +75,7 @@ static void mert_handle_cat_error(struct xe_device *xe)
 		break;
 	case CATERR_UNMAPPED_GGTT:
 		xe_sriov_err(xe, "MERT: CAT_ERR: Access to an unmapped GGTT!\n");
-		xe_device_declare_wedged(xe,
-					 DRM_WEDGE_RECOVERY_REBIND | DRM_WEDGE_RECOVERY_BUS_RESET);
+		xe_wedge_declare(xe, DRM_WEDGE_RECOVERY_REBIND | DRM_WEDGE_RECOVERY_BUS_=
RESET);
 		break;
 	case CATERR_LMTT_FAULT:
 		xe_sriov_dbg_ratelimited(xe, "MERT: CAT_ERR: VF%u LMTT fault!\n", vfid);
@@ -83,8 +83,7 @@ static void mert_handle_cat_error(struct xe_device *xe)
 		break;
 	default:
 		xe_sriov_err(xe, "MERT: Unexpected CAT_ERR code=3D%#x!\n", code);
-		xe_device_declare_wedged(xe,
-					 DRM_WEDGE_RECOVERY_REBIND | DRM_WEDGE_RECOVERY_BUS_RESET);
+		xe_wedge_declare(xe, DRM_WEDGE_RECOVERY_REBIND | DRM_WEDGE_RECOVERY_BUS_=
RESET);
 		break;
 	}
 }
diff --git a/drivers/gpu/drm/xe/xe_pat.c b/drivers/gpu/drm/xe/xe_pat.c
index 0ac64a6a3098a..5938fef22579a 100644
--- a/drivers/gpu/drm/xe/xe_pat.c
+++ b/drivers/gpu/drm/xe/xe_pat.c
@@ -16,6 +16,7 @@
 #include "xe_force_wake.h"
 #include "xe_gt.h"
 #include "xe_gt_mcr.h"
+#include "xe_log.h"
 #include "xe_mmio.h"
 #include "xe_sriov.h"
 #include "xe_wa.h"
@@ -93,29 +94,29 @@ struct xe_pat_ops {
 };
=20
 static const struct xe_pat_table_entry xelp_pat_table[] =3D {
-	[0] =3D { XELP_PAT_WB, XE_COH_1WAY },
-	[1] =3D { XELP_PAT_WC, XE_COH_NONE },
-	[2] =3D { XELP_PAT_WT, XE_COH_NONE },
-	[3] =3D { XELP_PAT_UC, XE_COH_NONE },
+	[0] =3D { XELP_PAT_WB, XE_COH_1WAY, 1 },
+	[1] =3D { XELP_PAT_WC, XE_COH_NONE, 1 },
+	[2] =3D { XELP_PAT_WT, XE_COH_NONE, 1 },
+	[3] =3D { XELP_PAT_UC, XE_COH_NONE, 1 },
 };
=20
 static const struct xe_pat_table_entry xehpc_pat_table[] =3D {
-	[0] =3D { XELP_PAT_UC, XE_COH_NONE },
-	[1] =3D { XELP_PAT_WC, XE_COH_NONE },
-	[2] =3D { XELP_PAT_WT, XE_COH_NONE },
-	[3] =3D { XELP_PAT_WB, XE_COH_1WAY },
-	[4] =3D { XEHPC_PAT_CLOS(1) | XELP_PAT_WT, XE_COH_NONE },
-	[5] =3D { XEHPC_PAT_CLOS(1) | XELP_PAT_WB, XE_COH_1WAY },
-	[6] =3D { XEHPC_PAT_CLOS(2) | XELP_PAT_WT, XE_COH_NONE },
-	[7] =3D { XEHPC_PAT_CLOS(2) | XELP_PAT_WB, XE_COH_1WAY },
+	[0] =3D { XELP_PAT_UC, XE_COH_NONE, 1 },
+	[1] =3D { XELP_PAT_WC, XE_COH_NONE, 1 },
+	[2] =3D { XELP_PAT_WT, XE_COH_NONE, 1 },
+	[3] =3D { XELP_PAT_WB, XE_COH_1WAY, 1 },
+	[4] =3D { XEHPC_PAT_CLOS(1) | XELP_PAT_WT, XE_COH_NONE, 1 },
+	[5] =3D { XEHPC_PAT_CLOS(1) | XELP_PAT_WB, XE_COH_1WAY, 1 },
+	[6] =3D { XEHPC_PAT_CLOS(2) | XELP_PAT_WT, XE_COH_NONE, 1 },
+	[7] =3D { XEHPC_PAT_CLOS(2) | XELP_PAT_WB, XE_COH_1WAY, 1 },
 };
=20
 static const struct xe_pat_table_entry xelpg_pat_table[] =3D {
-	[0] =3D { XELPG_PAT_0_WB, XE_COH_NONE },
-	[1] =3D { XELPG_PAT_1_WT, XE_COH_NONE },
-	[2] =3D { XELPG_PAT_3_UC, XE_COH_NONE },
-	[3] =3D { XELPG_PAT_0_WB | XELPG_2_COH_1W, XE_COH_1WAY },
-	[4] =3D { XELPG_PAT_0_WB | XELPG_3_COH_2W, XE_COH_2WAY },
+	[0] =3D { XELPG_PAT_0_WB, XE_COH_NONE, 1 },
+	[1] =3D { XELPG_PAT_1_WT, XE_COH_NONE, 1 },
+	[2] =3D { XELPG_PAT_3_UC, XE_COH_NONE, 1 },
+	[3] =3D { XELPG_PAT_0_WB | XELPG_2_COH_1W, XE_COH_1WAY, 1 },
+	[4] =3D { XELPG_PAT_0_WB | XELPG_3_COH_2W, XE_COH_2WAY, 1 },
 };
=20
 /*
@@ -294,25 +295,69 @@ static const struct xe_pat_table_entry xe3p_lpg_pat_t=
able[] =3D {
 	[31] =3D XE2_PAT( 0, 0, 3, 0, 3, 3 ),
 };
=20
+bool xe_pat_index_is_valid(struct xe_device *xe, u16 pat_index)
+{
+	if (WARN_ON(pat_index >=3D xe->pat.n_entries))
+		return false;
+
+	return xe->pat.table[pat_index].valid;
+}
+
 u16 xe_pat_index_get_coh_mode(struct xe_device *xe, u16 pat_index)
 {
-	WARN_ON(pat_index >=3D xe->pat.n_entries);
+	WARN_ON(!xe_pat_index_is_valid(xe, pat_index));
+	WARN_ON(!xe->pat.table[pat_index].coh_mode ||
+		xe->pat.table[pat_index].coh_mode > XE_COH_2WAY);
 	return xe->pat.table[pat_index].coh_mode;
 }
=20
 bool xe_pat_index_get_comp_en(struct xe_device *xe, u16 pat_index)
 {
-	WARN_ON(pat_index >=3D xe->pat.n_entries);
+	WARN_ON(!xe_pat_index_is_valid(xe, pat_index));
 	return !!(xe->pat.table[pat_index].value & XE2_COMP_EN);
 }
=20
 u16 xe_pat_index_get_l3_policy(struct xe_device *xe, u16 pat_index)
 {
-	WARN_ON(pat_index >=3D xe->pat.n_entries);
+	WARN_ON(!xe_pat_index_is_valid(xe, pat_index));
=20
 	return REG_FIELD_GET(XE2_L3_POLICY, xe->pat.table[pat_index].value);
 }
=20
+bool xe_pat_wa_14026539277_reserved(struct xe_device *xe, u16 pat_index)
+{
+	struct xe_gt *gt;
+	u8 id;
+	bool has_wa =3D false;
+
+	for_each_gt(gt, xe, id) {
+		if (XE_GT_WA(gt, 14026539277)) {
+			has_wa =3D true;
+			break;
+		}
+	}
+
+	/*
+	 * Disallow 2-way coherency for any L3 cache policy because
+	 * XE_L3_POLICY_UC could still be promoted to a cached policy
+	 * by MOCS indices.
+	 */
+	return has_wa && xe_pat_index_get_coh_mode(xe, pat_index) =3D=3D XE_COH_2=
WAY;
+}
+
+static u32 wa_14026539277_fixup_pat_value(struct xe_gt *gt, u32 value)
+{
+	if (XE_GT_WA(gt, 14026539277)) {
+		if (REG_FIELD_GET(XE2_COH_MODE, value) =3D=3D XE_COH_2WAY) {
+			value &=3D ~(XE2_L3_POLICY | XE2_COH_MODE);
+			value |=3D REG_FIELD_PREP(XE2_L3_POLICY, XE_L3_POLICY_UC) |
+				 REG_FIELD_PREP(XE2_COH_MODE, XE_COH_1WAY);
+		}
+	}
+
+	return value;
+}
+
 static const struct xe_pat_table_entry *gt_pta_entry(struct xe_gt *gt)
 {
 	struct xe_device *xe =3D gt_to_xe(gt);
@@ -373,18 +418,22 @@ static void program_pat_mcr(struct xe_gt *gt, const s=
truct xe_pat_table_entry ta
=20
 	for (int i =3D 0; i < n_entries; i++) {
 		struct xe_reg_mcr reg_mcr =3D XE_REG_MCR(_PAT_INDEX(i));
+		u32 pat =3D wa_14026539277_fixup_pat_value(gt, table[i].value);
=20
-		xe_gt_mcr_multicast_write(gt, reg_mcr, table[i].value);
+		xe_gt_mcr_multicast_write(gt, reg_mcr, pat);
 	}
=20
 	if (xe->pat.pat_ats)
-		xe_gt_mcr_multicast_write(gt, XE_REG_MCR(_PAT_ATS), xe->pat.pat_ats->val=
ue);
+		xe_gt_mcr_multicast_write(gt, XE_REG_MCR(_PAT_ATS),
+					  wa_14026539277_fixup_pat_value(gt, xe->pat.pat_ats->value));
=20
 	if (pta_entry)
-		xe_gt_mcr_multicast_write(gt, XE_REG_MCR(_PAT_PTA), pta_entry->value);
+		xe_gt_mcr_multicast_write(gt, XE_REG_MCR(_PAT_PTA),
+					  wa_14026539277_fixup_pat_value(gt, pta_entry->value));
=20
 	if (tr_pta_entry)
-		xe_gt_mcr_multicast_write(gt, XE_REG_MCR(_PAT_TR_PTA), tr_pta_entry->val=
ue);
+		xe_gt_mcr_multicast_write(gt, XE_REG_MCR(_PAT_TR_PTA),
+					  wa_14026539277_fixup_pat_value(gt, tr_pta_entry->value));
 }
=20
 static int xelp_dump(struct xe_gt *gt, struct drm_printer *p)
@@ -534,13 +583,16 @@ static int xe2_dump(struct xe_gt *gt, struct drm_prin=
ter *p)
 	drm_printf(p, "PAT table: (* =3D reserved entry)\n");
=20
 	for (i =3D 0; i < xe->pat.n_entries; i++) {
+		bool rsvd =3D !xe->pat.table[i].valid ||
+			    xe_pat_wa_14026539277_reserved(xe, i);
+
 		if (xe_gt_is_media_type(gt))
 			pat =3D xe_mmio_read32(&gt->mmio, XE_REG(_PAT_INDEX(i)));
 		else
 			pat =3D xe_gt_mcr_unicast_read_any(gt, XE_REG_MCR(_PAT_INDEX(i)));
=20
 		xe_pat_index_label(label, sizeof(label), i);
-		xe->pat.ops->entry_dump(p, label, pat, !xe->pat.table[i].valid);
+		xe->pat.ops->entry_dump(p, label, pat, rsvd);
 	}
=20
 	/*
@@ -692,8 +744,9 @@ int xe_pat_init_early(struct xe_device *xe)
 		 * raise an error rather than trying to silently inherit the
 		 * most recent platform's behavior.
 		 */
-		drm_err(&xe->drm, "Missing PAT table for platform with graphics version =
%d.%02d!\n",
-			GRAPHICS_VER(xe), GRAPHICS_VERx100(xe) % 100);
+		xe_log_err(xe, PAT, -ENODATA,
+			   "Missing PAT table for platform with graphics version %d.%02d!\n",
+			   GRAPHICS_VER(xe), GRAPHICS_VERx100(xe) % 100);
 		return -ENODATA;
 	}
=20
@@ -756,9 +809,14 @@ int xe_pat_dump_sw_config(struct xe_gt *gt, struct drm=
_printer *p)
 	for (u32 i =3D 0; i < xe->pat.n_entries; i++) {
 		u32 pat =3D xe->pat.table[i].value;
=20
+		pat =3D wa_14026539277_fixup_pat_value(gt, pat);
+
 		if (GRAPHICS_VER(xe) >=3D 20) {
+			bool rsvd =3D !xe->pat.table[i].valid ||
+				    xe_pat_wa_14026539277_reserved(xe, i);
+
 			xe_pat_index_label(label, sizeof(label), i);
-			xe->pat.ops->entry_dump(p, label, pat, !xe->pat.table[i].valid);
+			xe->pat.ops->entry_dump(p, label, pat, rsvd);
 		} else if (xe->info.platform =3D=3D XE_METEORLAKE) {
 			xelpg_pat_entry_dump(p, i, pat);
 		} else if (xe->info.platform =3D=3D XE_PVC) {
@@ -773,6 +831,8 @@ int xe_pat_dump_sw_config(struct xe_gt *gt, struct drm_=
printer *p)
 	if (pta_entry) {
 		u32 pat =3D pta_entry->value;
=20
+		pat =3D wa_14026539277_fixup_pat_value(gt, pat);
+
 		drm_printf(p, "Page Table Access:\n");
 		xe->pat.ops->entry_dump(p, "PTA_MODE", pat, false);
 	}
@@ -780,6 +840,8 @@ int xe_pat_dump_sw_config(struct xe_gt *gt, struct drm_=
printer *p)
 	if (tr_pta_entry) {
 		u32 pat =3D tr_pta_entry->value;
=20
+		pat =3D wa_14026539277_fixup_pat_value(gt, pat);
+
 		drm_printf(p, "TRTT Page Table Access:\n");
 		xe->pat.ops->entry_dump(p, "TR_PTA_MODE", pat, false);
 	}
@@ -787,6 +849,8 @@ int xe_pat_dump_sw_config(struct xe_gt *gt, struct drm_=
printer *p)
 	if (xe->pat.pat_ats) {
 		u32 pat =3D xe->pat.pat_ats->value;
=20
+		pat =3D wa_14026539277_fixup_pat_value(gt, pat);
+
 		drm_printf(p, "PCIe ATS/PASID:\n");
 		xe->pat.ops->entry_dump(p, "PAT_ATS ", pat, false);
 	}
diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
index 12ff5c9025478..7fba5295c33e6 100644
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@ -417,16 +417,17 @@ static const struct xe_device_desc bmg_desc =3D {
 	.dma_mask_size =3D 46,
 	.has_display =3D true,
 	.has_fan_control =3D true,
+	.has_fixed_vram_channels =3D true,
 	.has_flat_ccs =3D 1,
 	.has_mbx_power_limits =3D true,
 	.has_mbx_thermal_info =3D true,
 	.has_gsc_nvm =3D 1,
 	.has_heci_cscfi =3D 1,
 	.has_i2c =3D true,
-	.has_late_bind =3D true,
 	.has_pre_prod_wa =3D 1,
 	.has_soc_remapper_telem =3D true,
 	.has_sriov =3D true,
+	.late_bind_mask =3D BIT(XE_LB_FW_FAN_CONTROL),
 	.max_gt_per_tile =3D 2,
 	MULTI_LRC_MASK,
 	.needs_scratch =3D true,
@@ -487,6 +488,8 @@ static const struct xe_device_desc cri_desc =3D {
 	.has_sriov =3D true,
 	.has_sysctrl =3D true,
 	.has_temp_sentinel =3D true,
+	.late_bind_mask =3D BIT(XE_LB_FW_FAN_CONTROL) |
+			  BIT(XE_LB_FW_OCODE),
 	.max_gt_per_tile =3D 2,
 	MULTI_LRC_MASK,
 	.require_force_probe =3D true,
@@ -722,8 +725,9 @@ static int handle_gmdid(struct xe_device *xe,
=20
 	*graphics_ip =3D find_graphics_ip(ver);
 	if (!*graphics_ip) {
-		drm_err(&xe->drm, "Hardware reports unknown graphics version %u.%02u\n",
-			ver / 100, ver % 100);
+		xe_log_err(xe, REGS, -EINVAL,
+			   "Hardware reports unknown graphics version %u.%02u\n",
+			   ver / 100, ver % 100);
 	}
=20
 	ret =3D read_gmdid(xe, GMDID_MEDIA, &ver, media_revid);
@@ -736,8 +740,9 @@ static int handle_gmdid(struct xe_device *xe,
=20
 	*media_ip =3D find_media_ip(ver);
 	if (!*media_ip) {
-		drm_err(&xe->drm, "Hardware reports unknown media version %u.%02u\n",
-			ver / 100, ver % 100);
+		xe_log_err(xe, REGS, -EINVAL,
+			   "Hardware reports unknown media version %u.%02u\n",
+			   ver / 100, ver % 100);
 	}
=20
 	return 0;
@@ -798,6 +803,7 @@ static int xe_info_init_early(struct xe_device *xe,
 	xe->info.has_device_uid =3D desc->has_device_uid;
 	xe->info.has_drm_ras =3D desc->has_drm_ras;
 	xe->info.has_fan_control =3D desc->has_fan_control;
+	xe->info.has_fixed_vram_channels =3D desc->has_fixed_vram_channels;
 	/* runtime fusing may force flat_ccs to disabled later */
 	xe->info.has_flat_ccs =3D desc->has_flat_ccs;
 	xe->info.has_mbx_power_limits =3D desc->has_mbx_power_limits;
@@ -806,7 +812,6 @@ static int xe_info_init_early(struct xe_device *xe,
 	xe->info.has_heci_gscfi =3D desc->has_heci_gscfi;
 	xe->info.has_heci_cscfi =3D desc->has_heci_cscfi;
 	xe->info.has_i2c =3D desc->has_i2c;
-	xe->info.has_late_bind =3D desc->has_late_bind;
 	xe->info.has_llc =3D desc->has_llc;
 	xe->info.has_mert =3D desc->has_mert;
 	xe->info.has_page_reclaim_hw_assist =3D desc->has_page_reclaim_hw_assist;
@@ -824,6 +829,7 @@ static int xe_info_init_early(struct xe_device *xe,
 	xe->info.needs_scratch =3D desc->needs_scratch;
 	xe->info.needs_shared_vf_gt_wq =3D desc->needs_shared_vf_gt_wq;
 	xe->info.multi_lrc_mask =3D desc->multi_lrc_mask;
+	xe->info.late_bind_mask =3D desc->late_bind_mask;
=20
 	xe->info.probe_display =3D IS_ENABLED(CONFIG_DRM_XE_DISPLAY) &&
 				 xe_modparam.probe_display &&
diff --git a/drivers/gpu/drm/xe/xe_pci_error.c b/drivers/gpu/drm/xe/xe_pci_=
error.c
index a5c8fd67738cf..9bf0da3a3d152 100644
--- a/drivers/gpu/drm/xe/xe_pci_error.c
+++ b/drivers/gpu/drm/xe/xe_pci_error.c
@@ -13,6 +13,7 @@
 #include "xe_printk.h"
 #include "xe_ras.h"
 #include "xe_survivability_mode.h"
+#include "xe_wedge.h"
=20
 static void prepare_device_for_reset(struct pci_dev *pdev)
 {
@@ -22,7 +23,7 @@ static void prepare_device_for_reset(struct pci_dev *pdev)
=20
 	/*
 	 * Wedge the device to prevent userspace access but do not send the ueven=
t.
-	 * xe_device_wedged_fini() releases runtime pm if wedged flag is set, so =
acquire a runtime
+	 * xe_wedge_fini() releases runtime pm if wedged flag is set, so acquire =
a runtime
 	 * pm reference to avoid underflow.
 	 */
 	if (!atomic_xchg(&xe->wedged.flag, 1))
@@ -31,7 +32,7 @@ static void prepare_device_for_reset(struct pci_dev *pdev)
 	xe_device_set_in_reset(xe);
=20
 	for_each_gt(gt, xe, id) {
-		xe_gt_declare_wedged(gt);
+		xe_gt_wedge_declare(gt);
 		flush_work(&gt->wedge.worker);
 	}
=20
@@ -63,7 +64,7 @@ static pci_ers_result_t xe_pci_error_detected(struct pci_=
dev *pdev, pci_channel_
 		return PCI_ERS_RESULT_DISCONNECT;
=20
 	/* If the device is already wedged or in survivability mode, do not attem=
pt recovery */
-	if (xe_survivability_mode_is_boot_enabled(xe) || xe_device_wedged(xe))
+	if (xe_survivability_mode_is_boot_enabled(xe) || xe_wedged(xe))
 		return PCI_ERS_RESULT_DISCONNECT;
=20
 	switch (state) {
@@ -88,7 +89,7 @@ static pci_ers_result_t xe_pci_error_mmio_enabled(struct =
pci_dev *pdev)
=20
 	/* User wants to debug the error, prevent reset */
 	if (xe->wedged.mode =3D=3D XE_WEDGED_MODE_UPON_ANY_HANG_NO_RESET) {
-		xe_device_declare_wedged(xe, DRM_WEDGE_RECOVERY_NONE);
+		xe_wedge_declare(xe, DRM_WEDGE_RECOVERY_NONE);
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
=20
diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index d95f0d128ed49..61d68c09189f7 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -186,7 +186,7 @@ int xe_pm_suspend(struct xe_device *xe)
 	if (err)
 		goto err;
=20
-	xe_late_bind_wait_for_worker_completion(&xe->late_bind);
+	xe_late_bind_pm_suspend(&xe->late_bind);
=20
 	for_each_gt(gt, xe, id)
 		xe_gt_suspend_prepare(gt);
@@ -249,7 +249,7 @@ int xe_pm_resume(struct xe_device *xe)
 		xe_wa_apply_tile_workarounds(tile);
=20
 	for_each_gt(gt, xe, id)
-		xe_gt_idle_disable_c6(gt);
+		xe_gt_resume_early(gt);
=20
 	xe_display_pm_resume_early(xe);
=20
@@ -290,7 +290,7 @@ int xe_pm_resume(struct xe_device *xe)
 	if (IS_VF_CCS_READY(xe))
 		xe_sriov_vf_ccs_register_context(xe);
=20
-	xe_late_bind_fw_load(&xe->late_bind);
+	xe_late_bind_pm_resume(&xe->late_bind);
=20
 	drm_dbg(&xe->drm, "Device resumed\n");
 	xe_pm_block_end_signalling();
@@ -707,7 +707,7 @@ int xe_pm_runtime_resume(struct xe_device *xe)
 			xe_wa_apply_tile_workarounds(tile);
=20
 		for_each_gt(gt, xe, id)
-			xe_gt_idle_disable_c6(gt);
+			xe_gt_resume_early(gt);
=20
 		xe_display_pm_resume_early(xe);
=20
@@ -755,7 +755,7 @@ int xe_pm_runtime_resume(struct xe_device *xe)
 		xe_sriov_vf_ccs_register_context(xe);
=20
 	if (xe->d3cold.allowed)
-		xe_late_bind_fw_load(&xe->late_bind);
+		xe_late_bind_pm_resume(&xe->late_bind);
=20
 out:
 	xe_rpm_lockmap_release(xe);
diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
index fe16a41060607..2c01c183d02b1 100644
--- a/drivers/gpu/drm/xe/xe_ras.c
+++ b/drivers/gpu/drm/xe/xe_ras.c
@@ -3,7 +3,12 @@
  * Copyright =A9 2026 Intel Corporation
  */
=20
+#include <linux/bitfield.h>
+
+#include "xe_assert.h"
+#include "xe_bo.h"
 #include "xe_configfs.h"
+#include "xe_cper.h"
 #include "xe_debugfs.h"
 #include "xe_device.h"
 #include "xe_drm_ras.h"
@@ -16,6 +21,11 @@
 #include "xe_sysctrl_event_types.h"
 #include "xe_sysctrl_mailbox.h"
 #include "xe_sysctrl_mailbox_types.h"
+#include "xe_ttm_vram_mgr.h"
+#include "xe_wedge.h"
+
+/* Any non-null entry marks the page as offlined by firmware */
+#define XE_RAS_PAGE_OFFLINED		xa_mk_value(1)
=20
 #define CORE_COMPUTE_UNCORR_TYPE	GENMASK(26, 25)
 /*
@@ -103,7 +113,8 @@ static const char * const gpu_health_states[] =3D {
 };
 static_assert(ARRAY_SIZE(gpu_health_states) =3D=3D XE_RAS_HEALTH_MAX);
=20
-static int get_counter(struct xe_device *xe, struct xe_ras_error_class *co=
unter, u32 *value);
+static int get_counter(struct xe_device *xe, struct xe_ras_error_class *co=
unter,
+		       u32 *value, bool emit_cper);
=20
 static u8 drm_to_xe_ras_severity(u8 severity)
 {
@@ -129,6 +140,20 @@ static u8 xe_to_drm_ras_severity(u8 severity)
 	}
 }
=20
+static u8 ras_sev_to_cper_sev(u8 severity)
+{
+	switch (severity) {
+	case XE_RAS_SEV_CORRECTABLE:
+		return CPER_SEV_CORRECTED;
+	case XE_RAS_SEV_UNCORRECTABLE:
+		return CPER_SEV_RECOVERABLE;
+	case XE_RAS_SEV_INFORMATIONAL:
+		return CPER_SEV_INFORMATIONAL;
+	default:
+		return CPER_SEV_RECOVERABLE;
+	}
+}
+
 static u8 drm_to_xe_ras_component(u8 component)
 {
 	switch (component) {
@@ -165,6 +190,24 @@ static u8 xe_to_drm_ras_component(u8 component)
 	}
 }
=20
+static enum xe_sigid ras_comp_to_hw_sigid(u8 component)
+{
+	switch (component) {
+	case XE_RAS_COMP_DEVICE_MEMORY:
+		return XE_SIGID_DEVICE_MEMORY;
+	case XE_RAS_COMP_CORE_COMPUTE:
+		return XE_SIGID_CORE_COMPUTE;
+	case XE_RAS_COMP_PCIE:
+		return XE_SIGID_PCIE;
+	case XE_RAS_COMP_FABRIC:
+		return XE_SIGID_FABRIC;
+	case XE_RAS_COMP_SOC_INTERNAL:
+		return XE_SIGID_SOC_INTERNAL;
+	default:
+		return XE_SIGID_HW;
+	}
+}
+
 static int ras_status_to_errno(u32 status)
 {
 	switch (status) {
@@ -185,6 +228,12 @@ static int ras_status_to_errno(u32 status)
 	}
 }
=20
+static u16 ras_comp_to_log_comp(u8 component)
+{
+	return FIELD_PREP(XE_LOG_COMPONENT_CLASS_MASK, XE_LOG_COMPONENT_CLASS_HAR=
DWARE) |
+	       FIELD_PREP(XE_LOG_COMPONENT_TYPE_MASK, component);
+}
+
 static inline const char *sev_to_str(u8 severity)
 {
 	if (severity >=3D XE_RAS_SEV_MAX)
@@ -201,6 +250,142 @@ static inline const char *comp_to_str(u8 component)
 	return xe_ras_components[component];
 }
=20
+static int send_page_offline_cmd(struct xe_device *xe, u64 page_address,
+				 enum xe_ras_page_action action)
+{
+	struct xe_sysctrl_mailbox_command command =3D {0};
+	struct xe_ras_page_offline_request request =3D {0};
+	struct xe_ras_page_offline_response response =3D {0};
+	struct xe_ras_state *state =3D &xe->ras.state;
+	size_t rlen;
+	int ret;
+
+	if (!xe->info.has_sysctrl)
+		return 0;
+
+	xe_assert(xe, action < XE_RAS_PAGE_ACTION_MAX);
+
+	request.page_address =3D page_address;
+	request.action =3D action;
+
+	if (action =3D=3D XE_RAS_PAGE_ACTION_OFFLINE)
+		xe_log_err(xe, DEVICE_MEMORY, 0, "Requesting firmware to offline page 0x=
%llx\n",
+			   page_address);
+	else
+		xe_log_err(xe, DEVICE_MEMORY, 0, "Requesting firmware to remove page 0x%=
llx from queue\n",
+			   page_address);
+
+	xe_sysctrl_create_command(&command, XE_SYSCTRL_GROUP_GFSP, XE_SYSCTRL_CMD=
_PAGE_OFFLINE,
+				  &request, sizeof(request), &response, sizeof(response));
+
+	ret =3D xe_sysctrl_send_command(&xe->sc, &command, &rlen);
+	if (ret) {
+		xe_log_err(xe, SYSCTRL, ret, "failed to send page offline command\n");
+		return ret;
+	}
+
+	if (rlen !=3D sizeof(response)) {
+		xe_log_err(xe, SYSCTRL, -EINVAL,
+			   "unexpected page offline response length %zu (expected %zu)\n",
+			   rlen, sizeof(response));
+		return -EINVAL;
+	}
+
+	ret =3D ras_status_to_errno(response.status);
+	if (ret) {
+		xe_log_err(xe, SYSCTRL, ret, "page offline command failed with status %u=
\n",
+			   response.status);
+		return ret;
+	}
+
+	if (action =3D=3D XE_RAS_PAGE_ACTION_OFFLINE) {
+		ret =3D xa_err(xa_store(&state->offlined_pages,
+				      page_address >> XE_PTE_SHIFT,
+				      XE_RAS_PAGE_OFFLINED, GFP_KERNEL));
+		if (ret)
+			xe_err(xe, "Failed to store offlined page 0x%llx: %d\n", page_address,
+			       ret);
+	}
+
+	return 0;
+}
+
+static int handle_page_offline(struct xe_device *xe, u64 page_address, boo=
l notify_fw)
+{
+	struct xe_ras_state *state =3D &xe->ras.state;
+	enum xe_ras_page_action action;
+	u64 addr;
+	int ret;
+
+	if (!IS_ALIGNED(page_address, XE_PAGE_SIZE)) {
+		xe_log_err(xe, SYSCTRL, -EINVAL, "Unaligned physical page address: 0x%ll=
x\n",
+			   page_address);
+		return -EINVAL;
+	}
+
+	/* User policy set to disable page offlining */
+	if (xe_ras_get_disable_vram_page_offline(xe)) {
+		action =3D XE_RAS_PAGE_ACTION_REMOVE;
+		xe_log_err(xe, DEVICE_MEMORY, -EOPNOTSUPP, "User policy set to disable p=
age offlining\n");
+		goto notify;
+	}
+
+	addr =3D ALIGN_DOWN(page_address, PAGE_SIZE);
+
+	ret =3D xe_ttm_vram_handle_addr_fault(xe, addr);
+
+	/*
+	 * Handle return code from address fault handling function:
+	 *  0: Page softofflined, remove from firmware queue
+	 * -EIO: Address belongs to a critical BO/stolen area that cannot be offl=
ined
+	 * -ENOMEM: Failed to allocate BO for soft-offlining the page
+	 * -EEXIST: Address is soft offlined but yet to be offlined by firmware f=
or second
+	 * occurrence
+	 */
+
+	switch (ret) {
+	case 0:
+		action =3D XE_RAS_PAGE_ACTION_REMOVE;
+		xe_log_err(xe, DEVICE_MEMORY, ret,
+			   "Poison detected at physical address 0x%llx, page soft-offlined\n",
+			   page_address);
+		break;
+	case -EIO:
+		xe_log_err(xe, DEVICE_MEMORY, ret,
+			   "Poison detected at physical address 0x%llx, page belongs to critica=
l BO and cannot be soft-offlined\n",
+			   page_address);
+		return ret;
+	case -EEXIST:
+		if (xa_load(&state->offlined_pages, page_address >> XE_PTE_SHIFT))
+			action =3D XE_RAS_PAGE_ACTION_REMOVE;
+		else
+			action =3D XE_RAS_PAGE_ACTION_OFFLINE;
+
+		xe_log_err(xe, DEVICE_MEMORY, ret,
+			   "Double-bit ECC error detected at physical address 0x%llx, page soft=
-offlined\n",
+			   page_address);
+		break;
+	case -ENOMEM:
+		xe_log_err(xe, DEVICE_MEMORY, ret,
+			   "Poison detected at physical address 0x%llx, failed to soft-offline\=
n",
+			   page_address);
+		return ret;
+	default:
+		xe_log_err(xe, DEVICE_MEMORY, ret, "Failed to handle address fault at ph=
ysical address 0x%llx\n",
+			   page_address);
+		return 0;
+	}
+
+ notify:
+	if (notify_fw) {
+		ret =3D send_page_offline_cmd(xe, page_address, action);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static bool ras_counter_is_valid(struct xe_device *xe, struct xe_ras_error=
_class *counter)
 {
 	u8 severity =3D counter->common.severity;
@@ -219,6 +404,106 @@ static bool ras_counter_is_valid(struct xe_device *xe=
, struct xe_ras_error_class
 	return true;
 }
=20
+/*
+ * Fetch and process offline list and queue from firmware via mailbox. @no=
tify_fw controls
+ * whether firmware is notified of the offline/remove action.
+ */
+static void process_offline_pages(struct xe_device *xe, u32 cmd, void *req=
, size_t req_size,
+				  void *resp, size_t resp_size,
+				  struct xe_ras_offline_common *common, bool notify_fw)
+{
+	struct xe_sysctrl_mailbox_command command =3D {0};
+	struct xe_ras_offline_list_request *list_req;
+	struct xe_ras_state *state =3D &xe->ras.state;
+	unsigned long index;
+	u32 total_pages =3D 0, count =3D 0;
+	size_t rlen;
+	int ret, i;
+
+	list_req =3D req;
+
+	xe_sysctrl_create_command(&command, XE_SYSCTRL_GROUP_GFSP, cmd, req, req_=
size, resp,
+				  resp_size);
+
+	do {
+		memset(resp, 0, resp_size);
+
+		if (list_req)
+			list_req->index =3D count;
+
+		ret =3D xe_sysctrl_send_command(&xe->sc, &command, &rlen);
+		if (ret) {
+			xe_log_err(xe, SYSCTRL, ret, "failed to get page offline data, cmd=3D%#=
x\n",
+				   cmd);
+			return;
+		}
+
+		if (rlen !=3D resp_size) {
+			xe_log_err(xe, SYSCTRL, -EINVAL,
+				   "unexpected page offline response length %zu (expected %zu), cmd=3D=
%#x\n",
+				   rlen, resp_size, cmd);
+			return;
+		}
+
+		/* Populate the maximum number of pages from offline list */
+		if (list_req && !state->max_pages)
+			state->max_pages =3D
+				((struct xe_ras_offline_list_response *)resp)->max_entries;
+
+		for (i =3D 0; i < common->pages_returned && i < XE_RAS_NUM_PAGES; i++) {
+			handle_page_offline(xe, common->page_addresses[i], notify_fw);
+			/* The pages are already offlined by firmware */
+			if (!notify_fw) {
+				index =3D common->page_addresses[i] >> XE_PTE_SHIFT;
+				ret =3D xa_err(xa_store(&state->offlined_pages, index,
+						      XE_RAS_PAGE_OFFLINED, GFP_KERNEL));
+				if (ret)
+					xe_err(xe, "Failed to store offlined page 0x%llx: %d\n",
+					       common->page_addresses[i], ret);
+			}
+		}
+
+		count +=3D common->pages_returned;
+		if (!common->pages_returned)
+			break;
+
+		if (!total_pages)
+			total_pages =3D common->total_pages;
+
+		if (count > total_pages) {
+			xe_log_err(xe, SYSCTRL, -EINVAL,
+				   "Pages returned exceed total pages %u, returned %u, cmd=3D%#x\n",
+				   total_pages, count, cmd);
+			return;
+		}
+	} while (common->additional_data);
+}
+
+/*
+ * Retrieve firmware queued pages from warm-retained SRAM during probe. Ha=
ndle and soft-offline
+ * each page as required.
+ */
+static void get_offline_queue(struct xe_device *xe)
+{
+	struct xe_ras_offline_common response =3D {0};
+
+	process_offline_pages(xe, XE_SYSCTRL_CMD_GET_OFFLINE_QUEUE, NULL, 0, &res=
ponse,
+			      sizeof(response), &response, true);
+}
+
+/*
+ * Retrieve permanently offlined pages from firmware's non-volatile storag=
e during probe,
+ * allowing the driver to soft-offline them before kernel allocations begi=
n.
+ */
+static void get_offline_list(struct xe_device *xe)
+{
+	struct xe_ras_offline_list_response response =3D {0};
+	struct xe_ras_offline_list_request request =3D {0};
+
+	process_offline_pages(xe, XE_SYSCTRL_CMD_GET_OFFLINE_LIST, &request, size=
of(request),
+			      &response, sizeof(response), &response.common, false);
+}
+
 static struct pci_dev *find_usp_dev(struct pci_dev *pdev)
 {
 	struct pci_dev *vsp;
@@ -291,7 +576,7 @@ static void ras_send_error_event(struct xe_device *xe, =
u8 severity, u8 component
 	counter.common.severity =3D severity;
 	counter.common.component =3D component;
=20
-	ret =3D get_counter(xe, &counter, &value);
+	ret =3D get_counter(xe, &counter, &value, false);
 	if (ret)
 		return;
=20
@@ -301,13 +586,17 @@ static void ras_send_error_event(struct xe_device *xe=
, u8 severity, u8 component
 	xe_drm_ras_event(xe, drm_component, drm_severity, value);
 }
=20
-static u8 handle_core_compute_errors(struct xe_ras_error_array *arr)
+static u8 handle_core_compute_errors(struct xe_device *xe, struct xe_ras_e=
rror_array *arr)
 {
 	struct xe_ras_compute_error *error_info =3D (void *)arr->details;
+	u8 cper_sev =3D ras_sev_to_cper_sev(arr->counter.common.severity);
 	u8 uncorr_type;
=20
 	uncorr_type =3D FIELD_GET(CORE_COMPUTE_UNCORR_TYPE, error_info->log_heade=
r);
=20
+	xe_log_comp(xe, cper_sev, CORE_COMPUTE, &arr->counter, sizeof(arr->counte=
r),
+		    "Uncorrectable error detected, type %u\n", uncorr_type);
+
 	/* Request a reset if error is global */
 	if (uncorr_type =3D=3D GLOBAL_UNCORR_ERROR)
 		return XE_RAS_RECOVERY_ACTION_RESET;
@@ -321,14 +610,16 @@ static u8 handle_core_compute_errors(struct xe_ras_er=
ror_array *arr)
=20
 static void punit_error_handler(struct xe_device *xe)
 {
-	xe_device_declare_wedged(xe, DRM_WEDGE_RECOVERY_COLD_RESET);
+	xe_wedge_declare(xe, DRM_WEDGE_RECOVERY_COLD_RESET);
 }
=20
 static u8 handle_soc_internal_errors(struct xe_device *xe, struct xe_ras_e=
rror_array *arr)
 {
 	struct xe_ras_soc_error *info =3D (void *)arr->details;
 	struct xe_ras_soc_error_source *source =3D &info->source;
-	struct xe_ras_error_class *counter =3D &arr->counter;
+	u32 raw_source;
+
+	BUILD_BUG_ON(sizeof(raw_source) !=3D sizeof(*source));
=20
 	if (source->csc) {
 		struct xe_ras_csc_error *csc_error =3D (void *)info->details;
@@ -342,9 +633,8 @@ static u8 handle_soc_internal_errors(struct xe_device *=
xe, struct xe_ras_error_a
 		 * is required.
 		 */
 		if (csc_error->hec_fw_error) {
-			xe_err(xe, "[RAS]: CSC %s detected: 0x%x\n",
-			       sev_to_str(counter->common.severity),
-			       csc_error->hec_fw_error);
+			xe_log_comp_fatal(xe, SOC_INTERNAL, &arr->counter, sizeof(arr->counter),
+					  "CSC error detected: 0x%08x\n", csc_error->hec_fw_error);
 			xe_survivability_mode_runtime_enable(xe);
 			return XE_RAS_RECOVERY_ACTION_DISCONNECT;
 		}
@@ -352,42 +642,56 @@ static u8 handle_soc_internal_errors(struct xe_device=
 *xe, struct xe_ras_error_a
 		struct xe_ras_ieh_error *ieh_error =3D (void *)info->details;
=20
 		if (ieh_error->global_error_status & XE_RAS_SOC_IEH_PUNIT) {
-			xe_err(xe, "[RAS]: PUNIT %s detected: 0x%x\n",
-			       sev_to_str(counter->common.severity),
-			       ieh_error->global_error_status);
+			xe_log_comp_fatal(xe, SOC_INTERNAL, &arr->counter, sizeof(arr->counter),
+					  "PUNIT error detected: 0x%08x\n",
+					  ieh_error->global_error_status);
 			punit_error_handler(xe);
 			return XE_RAS_RECOVERY_ACTION_DISCONNECT;
 		}
 	}
=20
 	/* For other SoC internal errors, request a reset as recovery mechanism */
+	memcpy(&raw_source, source, sizeof(raw_source));
+	xe_log_comp(xe, ras_sev_to_cper_sev(arr->counter.common.severity), SOC_IN=
TERNAL,
+		    &arr->counter, sizeof(arr->counter),
+		    "Unknown error detected: 0x%08x\n", raw_source);
 	return XE_RAS_RECOVERY_ACTION_RESET;
 }
=20
 static u8 handle_device_memory_errors(struct xe_device *xe, struct xe_ras_=
error_array *arr)
 {
 	struct xe_ras_memory_error *info =3D (void *)arr->details;
+	u8 cper_sev =3D ras_sev_to_cper_sev(arr->counter.common.severity);
+	int ret;
=20
 	/*
 	 * For memory errors, the recovery action depends on the error category
 	 *
-	 * TODO: Double-bit ECC errors: Page offlining
+	 * Double-bit ECC errors: Page offlining
 	 * Poison and data parity errors: Log only
 	 * For any other memory errors, request a reset as recovery mechanism
 	 */
 	switch (info->category) {
 	case XE_RAS_MEMORY_POISON:
-		xe_info(xe, "[RAS]: Poison error detected\n");
+		xe_log_comp_info(xe, DEVICE_MEMORY, &arr->counter, sizeof(arr->counter),
+				 "Poison error detected\n");
 		break;
 	case XE_RAS_MEMORY_DATA_PARITY:
-		xe_info(xe, "[RAS]: Data parity error detected\n");
+		xe_log_comp_info(xe, DEVICE_MEMORY, &arr->counter, sizeof(arr->counter),
+				 "Data parity error detected\n");
 		break;
 	case XE_RAS_MEMORY_DB_ECC:
-		xe_info(xe, "[RAS]: Double-bit ECC error detected at sw address 0x%llx\n=
",
-			info->sw_address);
-		/* TODO: Add page offlining for Double-bit ECC error */
-		fallthrough;
+		ret =3D handle_page_offline(xe, info->sw_address, true);
+		xe_log_comp(xe, ret ? cper_sev : CPER_SEV_INFORMATIONAL,
+			    DEVICE_MEMORY, &arr->counter, sizeof(arr->counter),
+			    "Double-bit ECC error detected at sw address 0x%llx\n",
+			    info->sw_address);
+		if (ret)
+			return XE_RAS_RECOVERY_ACTION_RESET;
+		break;
 	default:
+		xe_log_comp(xe, cper_sev, DEVICE_MEMORY, &arr->counter, sizeof(arr->coun=
ter),
+			    "Unknown error detected\n");
 		return XE_RAS_RECOVERY_ACTION_RESET;
 	}
=20
@@ -420,8 +724,11 @@ void xe_ras_counter_threshold_crossed(struct xe_device=
 *xe,
 		if (!ras_counter_is_valid(xe, &errors[id]))
 			continue;
=20
-		xe_warn(xe, "[RAS]: %s %s detected\n",
-			comp_to_str(component), sev_to_str(severity));
+		xe_log_from(xe, ras_sev_to_cper_sev(severity),
+			    ras_comp_to_hw_sigid(component),
+			    ras_comp_to_log_comp(component),
+			    &errors[id], sizeof(errors[id]),
+			    "error detected\n");
=20
 		/* Send event once per component */
 		if (sent & BIT(component))
@@ -432,9 +739,37 @@ void xe_ras_counter_threshold_crossed(struct xe_device=
 *xe,
 	}
 }
=20
-static int get_counter(struct xe_device *xe, struct xe_ras_error_class *co=
unter, u32 *value)
+static int get_counter(struct xe_device *xe, struct xe_ras_error_class *co=
unter,
+		       u32 *value, bool emit_cper)
 {
 	struct xe_ras_get_counter_response response =3D {0};
+	int ret;
+
+	ret =3D xe_ras_get_counter_response(xe, counter, &response);
+	if (ret)
+		return ret;
+
+	*value =3D response.value;
+	if (emit_cper)
+		xe_cper_emit_counter(xe, ras_sev_to_cper_sev(counter->common.severity),
+				     ras_comp_to_hw_sigid(counter->common.component),
+				     counter, &response);
+	return 0;
+}
+
+/**
+ * xe_ras_get_counter_response() - Get error counter record
+ * @xe: Xe device instance
+ * @counter: RAS error class
+ * @response: Counter record retrieved
+ *
+ * Retrieve the counter record of a specific error class from firmware.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int xe_ras_get_counter_response(struct xe_device *xe, const struct xe_ras_=
error_class *counter,
+				struct xe_ras_get_counter_response *response)
+{
 	struct xe_ras_get_counter_request request =3D {0};
 	struct xe_sysctrl_mailbox_command command =3D {0};
 	struct xe_ras_error_common *common;
@@ -444,7 +779,7 @@ static int get_counter(struct xe_device *xe, struct xe_=
ras_error_class *counter,
 	request.counter =3D *counter;
=20
 	xe_sysctrl_create_command(&command, XE_SYSCTRL_GROUP_GFSP, XE_SYSCTRL_CMD=
_GET_COUNTER,
-				  &request, sizeof(request), &response, sizeof(response));
+				  &request, sizeof(request), response, sizeof(*response));
=20
 	ret =3D xe_sysctrl_send_command(&xe->sc, &command, &rlen);
 	if (ret) {
@@ -452,20 +787,19 @@ static int get_counter(struct xe_device *xe, struct x=
e_ras_error_class *counter,
 		return ret;
 	}
=20
-	if (rlen !=3D sizeof(response)) {
+	if (rlen !=3D sizeof(*response)) {
 		xe_err(xe, "sysctrl: unexpected get counter response length %zu (expecte=
d %zu)\n",
-		       rlen, sizeof(response));
+		       rlen, sizeof(*response));
 		return -EIO;
 	}
=20
-	if (!ras_counter_is_valid(xe, &response.counter))
+	if (!ras_counter_is_valid(xe, &response->counter))
 		return -EBADMSG;
=20
-	common =3D &response.counter.common;
-	*value =3D response.value;
+	common =3D &response->counter.common;
=20
-	xe_dbg(xe, "[RAS]: get counter %u for %s %s\n", *value, comp_to_str(commo=
n->component),
-	       sev_to_str(common->severity));
+	xe_dbg(xe, "[RAS]: get counter %u for %s %s\n", response->value,
+	       comp_to_str(common->component), sev_to_str(common->severity));
=20
 	return 0;
 }
@@ -547,7 +881,7 @@ enum xe_ras_recovery_action xe_ras_process_errors(struc=
t xe_device *xe)
=20
 			switch (component) {
 			case XE_RAS_COMP_CORE_COMPUTE:
-				action =3D handle_core_compute_errors(arr);
+				action =3D handle_core_compute_errors(xe, arr);
 				break;
 			case XE_RAS_COMP_SOC_INTERNAL:
 				action =3D handle_soc_internal_errors(xe, arr);
@@ -600,7 +934,7 @@ int xe_ras_get_counter(struct xe_device *xe, u8 severit=
y, u8 component, u32 *val
 	counter.common.component =3D drm_to_xe_ras_component(component);
=20
 	guard(xe_pm_runtime)(xe);
-	return get_counter(xe, &counter, value);
+	return get_counter(xe, &counter, value, READ_ONCE(xe->cper.on_query));
 }
=20
 /**
@@ -905,33 +1239,83 @@ static const struct attribute_group gpu_health_group=
 =3D {
 	.attrs =3D gpu_health_attrs,
 };
=20
+static void ras_fini(void *arg)
+{
+	struct xe_device *xe =3D arg;
+
+	xa_destroy(&xe->ras.state.offlined_pages);
+}
+
+/**
+ * xe_ras_get_disable_vram_page_offline - Get the vram page offline user p=
olicy
+ * @xe: xe device instance
+ *
+ * Return: true if the vram page offline policy is disabled, false otherwi=
se.
+ */
+bool xe_ras_get_disable_vram_page_offline(struct xe_device *xe)
+{
+	return xe->ras.state.disable_vram_page_offline;
+}
+
+/**
+ * xe_ras_get_max_pages - Get the maximum number of pages
+ * @xe: xe device instance
+ *
+ * Return: Maximum number of pages stored by the firmware in flash
+ */
+u32 xe_ras_get_max_pages(struct xe_device *xe)
+{
+	return xe->ras.state.max_pages;
+}
+
 /**
  * xe_ras_init - Initialize Xe RAS
  * @xe: xe device instance
  *
  * Initialize Xe RAS
+ *
+ * Return: 0 on success, negative error code otherwise
  */
-void xe_ras_init(struct xe_device *xe)
+int xe_ras_init(struct xe_device *xe)
 {
+	struct xe_ras_state *state =3D &xe->ras.state;
 	int ret;
=20
-	/*
-	 * TODO: Replace platform check with xe->info.has_disable_vram_page_offli=
ne
-	 * once the feature flag is plumbed through device info.
-	 */
-	if (xe->info.platform =3D=3D XE_CRESCENTISLAND)
-		xe->ras.disable_vram_page_offline =3D
-			xe_configfs_get_disable_vram_page_offline(to_pci_dev(xe->drm.dev));
-
 	xe_drm_ras_init(xe);
=20
 	if (!xe->info.has_sysctrl)
-		return;
+		return 0;
+
+	/*
+	 * TODO: Replace with xe->info.has_disable_vram_page_offline once the fea=
ture flag is
+	 * plumbed through device info.
+	 */
+	xe->ras.state.disable_vram_page_offline =3D
+		xe_configfs_get_disable_vram_page_offline(to_pci_dev(xe->drm.dev));
=20
 	if (IS_ENABLED(CONFIG_PCIEAER))
 		ras_usp_aer_init(xe);
=20
+	xa_init(&state->offlined_pages);
+
+	ret =3D devm_add_action_or_reset(xe->drm.dev, ras_fini, xe);
+	if (ret)
+		return ret;
+
+	/* Fetch the offline list before queue to avoid duplication */
+	get_offline_list(xe);
+	get_offline_queue(xe);
+
+	/*
+	 * During probe, process and log any errors detected by firmware while th=
e driver was not
+	 * loaded. Critical errors such as Punit and CSC are reported through Pco=
de init failure,
+	 * causing the driver to enter survivability mode.
+	 */
+	xe_ras_process_errors(xe);
+
 	ret =3D devm_device_add_group(xe->drm.dev, &gpu_health_group);
 	if (ret)
-		xe_err(xe, "Failed to create GPU health sysfs, err=3D%d\n", ret);
+		return ret;
+
+	return xe_cper_sysfs_init(xe);
 }
diff --git a/drivers/gpu/drm/xe/xe_survivability_mode.c b/drivers/gpu/drm/x=
e/xe_survivability_mode.c
index ca031576fecb7..d73cdad0b3a9c 100644
--- a/drivers/gpu/drm/xe/xe_survivability_mode.c
+++ b/drivers/gpu/drm/xe/xe_survivability_mode.c
@@ -20,6 +20,7 @@
 #include "xe_pcode_api.h"
 #include "xe_printk.h"
 #include "xe_vsec.h"
+#include "xe_wedge.h"
=20
 /**
  * DOC: Survivability Mode
@@ -446,7 +447,7 @@ void xe_survivability_mode_runtime_enable(struct xe_dev=
ice *xe)
 	survivability->type =3D XE_SURVIVABILITY_TYPE_RUNTIME;
 	xe_log_err(xe, SURVIVABILITY, 0, "Runtime Mode enabled!\n");
=20
-	xe_device_declare_wedged(xe, DRM_WEDGE_RECOVERY_VENDOR);
+	xe_wedge_declare(xe, DRM_WEDGE_RECOVERY_VENDOR);
=20
 	xe_log_err(xe, SURVIVABILITY, 0, "Firmware flash required!\n");
 	xe_info(xe, "Please refer to the userspace documentation for more details=
 how to flash the firmware on %s!\n",

--8TtJXYIZ1PubQcZP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmr3NcgACgkQJNaLcl1U
h9B7pwgAgGMnOQGOhWxTeDBFu4yyV5hY8eQb1h++uO6Caqx86dWE48wkgfoNQkgi
/I05DGM3b1R7Nj5D7oHl4BMVHPvqWEVUG4wxGhCqTyk+mIFkw4qaV1JlMbzN2VJw
44dfC+uTl9BW0AWkRJ0A/+iD0uO7Vjc/V8woVN/uEKE8pZ0uBZuZjhrNgftgn/uw
OzWp0JUDs89n17XvsHgZGYFwDSpVNMbF9FyuZAaZMNh++dw7ltaAfI6zA+dR74tL
QOY4Kq8SEDGPQIanypZw/WHy3VQQ6ePtYB03jUiITAfT1qu96ZWOuEuaKzSrzJOy
2WsSqDo5EUtFXlr0otsCI1WqaC1/Xw==
=8obv
-----END PGP SIGNATURE-----

--8TtJXYIZ1PubQcZP--
