Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C678C5AD4E
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:37:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD42010E641;
	Mon, 10 Aug 2026 06:37:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=holtechnik.com header.i=@holtechnik.com header.b="lQuox7AE";
	dkim-atps=neutral
X-Greylist: delayed 534 seconds by postgrey-1.36 at gabe;
 Sat, 08 Aug 2026 03:56:12 UTC
Received: from hognose1.porkbun.com (hognose1.porkbun.com [35.82.102.206])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D991C10E4C9;
 Sat,  8 Aug 2026 03:56:12 +0000 (UTC)
Received: from localhost.localdomain (192-184-175-24.fiber.dynamic.sonic.net
 [192.184.175.24])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 (Authenticated sender: phollinsky@holtechnik.com)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 7A35147EBFA;
 Sat,  8 Aug 2026 03:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=holtechnik.com;
 s=default; t=1786160838;
 bh=GGDdDAc8Bdsq+Kyf4eKQQ96PLRRuWdnU9xLbdBl+78A=;
 h=From:To:Cc:Subject:Date;
 b=lQuox7AE/mJCZ6rYgisH7+XRBEn6/29HUk+gg9HBv/g6o2QR5WkWN1KcZ565i2Z/f
 cfVGDC47qTAk5dYyMOVeN3CJS51kHD5hMcpzYeZI7uo6XjpHUxa0UtavcEViQqTDbG
 +IqLz18eBmKHOp7fvRd1ZMacTALiIQLCYdG5p6HA=
From: Paul Hollinsky <phollinsky@holtechnik.com>
To: sumit.garg@oss.qualcomm.com,
	andersson@kernel.org
Cc: mathieu.poirier@linaro.org, robin.clark@oss.qualcomm.com, lumag@kernel.org,
 abhinav.kumar@linux.dev, akhilpo@oss.qualcomm.com, konradybcio@kernel.org,
 mukesh.ojha@oss.qualcomm.com, cros-qcom-dts-watchers@chromium.org,
 linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: [REGRESSION] qcom PAS TZ API migration breaks GPU and modem on
 TrustZone without PAS (sc7180 trogdor)
Date: Fri,  7 Aug 2026 20:47:16 -0700
Message-ID: <20260808034716.58888-1-phollinsky@holtechnik.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

Hi,

Two commits from the "firmware: qcom: Add OP-TEE PAS service support"
series break the GPU and the modem on SC7180 Chromebooks (trogdor):

  f3b1357673dd ("remoteproc: qcom_q6v5_mss: Switch to generic PAS TZ APIs")
  0be72be03ca7 ("drm/msm: Switch to generic PAS TZ APIs")

Both are in linux-next as of next-20260805 and neither is in a released
kernel yet, so there is still time to fix this before v7.3.

Seen on a Lenovo IdeaPad Duet 3 (sc7180-trogdor-wormdingler) booting
next-20260805. Reverting the two commits separately and together on an
otherwise unmodified next-20260805 confirms them: each revert restores
its own subsystem and only its own. Config: QCOM_SCM=y, QCOM_PAS=y,
QCOM_TZMEM=y, DRM_MSM=m, QCOM_Q6V5_MSS=m, and CONFIG_TEE is not set so
QCOM_PAS_TEE cannot be enabled and the SCM backend is the only possible
PAS provider here.

Both commits also revert cleanly on their own: the series migrated the
callers but left the qcom_scm_pas_*() API exported.

#regzbot introduced: f3b1357673dd
#regzbot title: qcom: GPU and modem fail to probe on TrustZone firmware without PAS

(0be72be03ca7 from the same series is an independent second culprit)


Symptoms
========

1. The GPU never initialises and userspace falls back to llvmpipe:

  adreno 5000000.gpu: [drm:adreno_zap_shader_load] *ERROR* PAS is not available
  msm_dpu ae01000.display-controller: [drm:adreno_load_gpu] *ERROR* gpu hw init failed: -517

  That pair repeats on every DRM open.

2. The modem remoteproc never probes:

  4080000.remoteproc: deferred probe pending

  On trogdor the modem is what loads the WLAN firmware, so ath10k_snoc
  probes, creates wifi-firmware.0, then never receives QMI. Result: no
  wifi at all.


Why PAS is unavailable here
===========================

Both commits replace a qcom_scm_is_available() check with
qcom_pas_is_available(). Those are not equivalent: the former asks
whether the SCM transport is up, the latter whether the TrustZone
firmware implements the peripheral authentication service.

Trogdor's TZ does not implement PAS. I instrumented
__qcom_scm_is_call_available() and the firmware answers coherently,
yes to everything the platform actually uses, no only to PAS:

  svc 0x06 cmd 0x01  IS_CALL_AVAIL      -> 1   (discovery itself works)
  svc 0x02 cmd 0x01  PAS_INIT_IMAGE     -> 0
  svc 0x02 cmd 0x05  PAS_AUTH_AND_RESET -> 0
  svc 0x02 cmd 0x07  PAS_IS_SUPPORTED   -> 0
  svc 0x0c cmd 0x16  MP_ASSIGN          -> 1   (used by ath10k MSA every boot)
  svc 0x05 cmd 0x01  IO_READ            -> 1
  svc 0x05 cmd 0x02  IO_WRITE           -> 1

The third line is the one that matters. qcom_scm_probe() registers the
SCM PAS backend only if qcom_scm_is_pas_available() (qcom_scm.c:2908):

	if (qcom_scm_is_pas_available()) {
		qcom_pas_ops_scm.dev = scm->dev;
		qcom_pas_ops_register(&qcom_pas_ops_scm);
	}

and qcom_scm_is_pas_available() probes exactly
QCOM_SCM_SVC_PIL / QCOM_SCM_PIL_PAS_AUTH_AND_RESET (svc 0x02 cmd 0x05),
which returns 0 above. So qcom_pas_ops_register() is never called,
ops_ptr stays NULL, and qcom_pas_is_available() (a plain
!!smp_load_acquire(&ops_ptr)) is false for the lifetime of the boot.
With CONFIG_TEE unset there is no OP-TEE backend to supply one either.

That part is working as designed. The problem is that neither new call
site actually needs PAS on this platform. The migration conflated "needs
TrustZone memory protection" with "needs PAS".


remoteproc
==========

sc7180_mss has need_mem_protection = true but need_pas_mem_setup = false.
Its memory protection is qcom_scm_assign_mem(), a different TZ service
(MP_ASSIGN above, which is available). Only the need_pas_mem_setup path
issues PAS calls. Gating every need_mem_protection platform on PAS stops
the modem probing at all.

Six platforms specify need_mem_protection = true with
need_pas_mem_setup = false:

  sc7180_mss, sc7280_mss, sdm660_mss, sdm845_mss, msm8998_mss, msm8996_mss


drm/msm
=======

Even before the SCM->PAS change, the ordering wasn't right here.

zap_available is a static initialised to true (adreno_gpu.c:29), and it
is only ever cleared inside zap_shader_load_mdt(). But
adreno_zap_shader_load() checks for PAS *before* calling it:

	if (!zap_available)		/* still true on the first call */
		return -ENODEV;

	if (!qcom_pas_is_available())	/* fails here, forever */
		return -EPROBE_DEFER;

	return zap_shader_load_mdt(...);	/* never reached */

sc7180-trogdor.dtsi does /delete-node/ &gpu_zap_shader;, so the intended
path on this board is: zap_shader_load_mdt() finds no zap-shader child,
sets zap_available = false, returns -ENODEV, and the caller falls back to
SECVID_TRUST_CNTL. ("Zap shader not enabled - using SECVID_TRUST_CNTL
instead" appears on working v7.2 kernels.) With the PAS check in front of
it, that discovery can never run, so the flag is never cleared and every
subsequent call fails identically.

-EPROBE_DEFER is misleading here: it is not a probe return value.
adreno_zap_shader_load() is called from a6xx_hw_init(), so nothing in
the driver core retries it. It propagates up until adreno_load_gpu()
returns NULL, and load_gpu() (msm_drv.c:200) re-attempts on every DRM
open while priv->gpu is NULL. Each open fails the same way, and PAS can
never become available in between.

So the driver is consulting PAS before it knows whether it needs PAS.


Suggested fix, drm/msm
======================

Given the above, I think the right fix is to move the availability check
behind the DT discovery rather than restore the SCM check. Boards with no
zap-shader node then never consult PAS at all, and boards that do have one
keep the qcom_pas_is_available() gate the original patch was going for:

--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -52,6 +52,12 @@
 		return -ENODEV;
 	}
 
+	/* We need PAS to be able to load the firmware */
+	if (!qcom_pas_is_available()) {
+		DRM_DEV_ERROR(dev, "PAS is not available\n");
+		return -EPROBE_DEFER;
+	}
+
 	ret = of_reserved_mem_region_to_resource(np, 0, &r);
 	if (ret) {
 		zap_available = false;
@@ -170,18 +176,11 @@
 int adreno_zap_shader_load(struct msm_gpu *gpu, u32 pasid)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
-	struct platform_device *pdev = gpu->pdev;
 
 	/* Short cut if we determine the zap shader isn't available/needed */
 	if (!zap_available)
 		return -ENODEV;
 
-	/* We need PAS to be able to load the firmware */
-	if (!qcom_pas_is_available()) {
-		DRM_DEV_ERROR(&pdev->dev, "PAS is not available\n");
-		return -EPROBE_DEFER;
-	}
-
 	return zap_shader_load_mdt(gpu, adreno_gpu->info->zapfw, pasid);
 }
 

I have this booting here: the GPU initialises and logs "Zap shader not
enabled - using SECVID_TRUST_CNTL instead", as it did before the
regression.


Suggested fix, remoteproc
=========================

Keep an SCM gate for need_mem_protection and add a separate PAS gate for
need_pas_mem_setup. This is what I did to get it working:

--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -2079,7 +2079,16 @@ static int q6v5_probe(struct platform_device *pdev)
 	if (!desc)
 		return -EINVAL;
 
-	if (desc->need_mem_protection && !qcom_pas_is_available())
+	/*
+	 * Memory protection is done through qcom_scm_assign_mem(), which needs
+	 * SCM but not PAS. Only the memory setup path issues PAS calls, so
+	 * requiring PAS for every need_mem_protection platform prevents the
+	 * modem from probing at all on TZ firmware that offers no PAS.
+	 */
+	if (desc->need_mem_protection && !qcom_scm_is_available())
+		return -EPROBE_DEFER;
+
+	if (desc->need_pas_mem_setup && !qcom_pas_is_available())
 		return -EPROBE_DEFER;
 
 	mba_image = desc->hexagon_mba_image;

Unlike the drm/msm case there is no "remove the SCM dependency" argument
to make here: mss calls qcom_scm_assign_mem() directly, so it is
intrinsically an SCM client on these platforms.

The SCM gate is definitely required here: qcom_scm_assign_mem()
dereferences __scm->mempool without testing it (qcom_scm.c:1370), so
removing the check would trigger a NULL dereference if the driver probes
before qcom_scm has.


On the API contract
===================

For what it is worth, the kernel-doc for qcom_pas_is_available()
(qcom_pas.c:256) reads:

  Note that it is mandatory for any PAS client to invoke this API.
  If it returns true then only any other PAS API can be invoked.

That is a guard to call before invoking a PAS API, not a statement that a
driver touching TZ at all should refuse to probe without PAS.
ipa_main.c:764 consults it only on the loader path that genuinely needs
PAS rather than as a blanket probe precondition, which is the shape both
fixes above are aiming for.

Happy to send either or both as proper patches if this looks right to you,
or to test whatever shape you prefer.

All the best,
Paul Hollinsky
