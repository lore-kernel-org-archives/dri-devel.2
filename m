Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B67606A336
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 12:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kWqDjOED
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30BCD10F643;
	Tue, 10 Nov 2026 12:15:54 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1454710F643
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 12:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794312949; x=1825848949;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=l8AZHUbBT10rst5OFdt5Z0mDYj7qQK9sYESz6Ge7jes=;
 b=kWqDjOEDzj9wVNPTkfIEgvY4VcxmMm7p7rEhIKDfUV0iTcCzD2AUIFyM
 ebmiCSwwlOYCYTrRmdH/kJt5B5A2JnBtElkC7ezsLo0rI7vnKy6hItu2O
 XXz1MM36mtRwpHXnIhd9HGOj5M6HiBTJWkmb5B1IdK1BmxVKbWu9tp4pX
 JnUsVGkPYEECXDJCWFbViQncEfTWqOBeL467uPDprx+3oyr4Nk+cISX5v
 kwYCT31I9RMb7GqxFNak2XZCSup+K8EM/BmyilNgJ/nMiIs04dFWAYoJM
 VU3JbDP7u8gLVBAsalasZKjSpRIemCdgPQxoY8NyRFzaWAfJnQ6BwlH5U A==;
X-CSE-ConnectionGUID: z7a+WK8rRiW2CwHEUG0T/Q==
X-CSE-MsgGUID: SISvOntaSrSSLtOZtmNC1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2962376"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="2962376"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 04:15:48 -0800
X-CSE-ConnectionGUID: ed6m2X4pRcSXwkMq9opBfw==
X-CSE-MsgGUID: JfABqc8UT1i0jAGjSI3Hcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8730891"
Received: from pl-npu-pc-kwachow.igk.intel.com ([10.91.220.239])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 04:15:46 -0800
From: Karol Wachowski <karol.wachowski@linux.intel.com>
To: Daksh Sahni <swizzguy76@gmail.com>,
	dri-devel@lists.freedesktop.org
Cc: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 dawid.osuchowski@linux.intel.com,
 Karol Wachowski <karol.wachowski@linux.intel.com>, stable@vger.kernel.org
Subject: [PATCH v3] accel/ivpu: Defer recovery until probe completes
Date: Tue, 10 Nov 2026 13:15:34 +0100
Message-ID: <20261110121534.3566028-1-karol.wachowski@linux.intel.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

An error IRQ that fires after ivpu_boot() enables interrupts queues
recovery_work during probe. If probe then fails, the device is torn
down while the work runs, and the work faults on the unmapped BARs:

  BUG: unable to handle page fault for address: ffffcfc6680200f4
  Workqueue: events_unbound ivpu_pm_recovery_work [intel_vpu]
  RIP: 0010:ivpu_hw_ip_ipc_rx_addr_get+0xc/0xb0 [intel_vpu]
  Call Trace:
   ivpu_wait_for_ready+0x155/0x220 [intel_vpu]
   ivpu_boot+0x9e/0x270 [intel_vpu]
   ivpu_resume+0xa4/0xd0 [intel_vpu]
   ivpu_pm_reset_complete+0x2c/0x90 [intel_vpu]
   ivpu_pm_recovery_work+0xf6/0x140 [intel_vpu]

If probe succeeds, the recovery runs concurrently with the rest of
probe, and its pm_runtime_disable() discards the initial autosuspend
request, leaving the NPU active until first use. Any recovery that
starts while the NPU is idle loses the pending autosuspend the same way.

Keep recovery_work disabled from ivpu_pm_init() until ivpu_pm_enable().
A trigger during probe still runs diagnostics and masks interrupts, and
ivpu_pm_enable() runs the deferred recovery before the initial
autosuspend request. A trigger racing with ivpu_pm_enable() can cause
a second, harmless recovery. Request autosuspend at the end of
ivpu_pm_reset_complete() so the NPU suspends again after every reset.

Fixes: 852be13f3bd3 ("accel/ivpu: Add PM support")
Cc: stable@vger.kernel.org
Reported-by: Daksh Sahni <swizzguy76@gmail.com>
Closes: https://lore.kernel.org/r/20261107174215.15818-1-swizzguy76@gmail.com
Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
---

Notes:
    v3:
    - Request autosuspend at the end of ivpu_pm_reset_complete().
      pm_runtime_disable() in ivpu_pm_reset_begin() cancels a pending
      autosuspend request and pm_runtime_enable() does not re-issue it, so
      a recovery racing with the initial autosuspend request in
      ivpu_pm_enable() left the NPU active until first use (Sashiko).
      A trigger racing with ivpu_pm_enable() can still queue recovery
      twice. The second run is a full reset that leaves the device in a
      consistent state, and autosuspend is now re-requested after each
      reset.
    - Replace pm_runtime_mark_last_busy() with pm_request_autosuspend() in
      ivpu_pm_reset_complete(); it marks the device busy itself.
    - Shorten the commit message.
    - v2: https://lore.kernel.org/r/20261110085003.3527014-1-karol.wachowski@linux.intel.com

    v2:
    - Rework of Daksh's "accel/ivpu: Disable recovery work on probe failure":
      https://lore.kernel.org/r/20261107174215.15818-1-swizzguy76@gmail.com
    - Keep recovery_work disabled from ivpu_pm_init() until ivpu_pm_enable()
      instead of disabling it on the probe error path, which is too late as
      recovery may already run concurrently with ivpu_boot() (Sashiko)
    - Run a recovery requested during probe from ivpu_pm_enable() and wait
      for it before the initial autosuspend request, so the NPU is reset
      before use and the autosuspend is not lost when probe succeeds

    v1:
    - Link: https://lore.kernel.org/r/20261107174215.15818-1-swizzguy76@gmail.com

 drivers/accel/ivpu/ivpu_pm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
index aa813262253e..e4b79c946ca0 100644
--- a/drivers/accel/ivpu/ivpu_pm.c
+++ b/drivers/accel/ivpu/ivpu_pm.c
@@ -150,8 +150,8 @@ static void ivpu_pm_reset_complete(struct ivpu_device *vdev)
 	up_write(&vdev->pm->reset_lock);
 	atomic_set(&vdev->pm->reset_pending, 0);
 
-	pm_runtime_mark_last_busy(vdev->drm.dev);
 	pm_runtime_enable(vdev->drm.dev);
+	pm_request_autosuspend(vdev->drm.dev);
 }
 
 static void ivpu_pm_recovery_work(struct work_struct *work)
@@ -415,6 +415,7 @@ void ivpu_pm_init(struct ivpu_device *vdev)
 	atomic_set(&pm->engine_reset_counter, 0);
 
 	INIT_WORK(&pm->recovery_work, ivpu_pm_recovery_work);
+	disable_work(&pm->recovery_work);
 	INIT_DELAYED_WORK(&pm->job_timeout_work, ivpu_job_timeout_work);
 
 	if (ivpu_disable_recovery)
@@ -439,6 +440,12 @@ void ivpu_pm_enable(struct ivpu_device *vdev)
 {
 	struct device *dev = vdev->drm.dev;
 
+	enable_work(&vdev->pm->recovery_work);
+	if (atomic_read(&vdev->pm->reset_pending)) {
+		queue_work(system_dfl_wq, &vdev->pm->recovery_work);
+		flush_work(&vdev->pm->recovery_work);
+	}
+
 	pm_runtime_allow(dev);
 	pm_runtime_put_autosuspend(dev);
 }

base-commit: 54d3ff1b5ac08d0e28029b93a1719ddd9ff670a4
-- 
2.43.0

