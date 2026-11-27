Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F01D606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 03:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=v+D9Cdhe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B50E910E349;
	Fri, 27 Nov 2026 03:41:36 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.77.159])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A1F210E161;
 Fri, 27 Nov 2026 03:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
 s=mxsw2412; t=1795750853;
 bh=gRzSE886gqVPNfRIk/T791axfG2WElyar5tUseuf8tw=;
 h=From:Date:Subject:MIME-Version:Message-Id:To;
 b=v+D9Cdhev9N/TEl0Fa1sTrbV4iltMCwzC7nurR9Nj5OZFByQXrgyCxs16rAgz5Ter
 8sbHErjaKekrTNbnTOEL0f6ph9rvc2Z0jqwlfbtVvfku2Rda8L5VyLdK/VRxlccYX+
 kwzcBd0sXOmzDIWtkLS9k2iejOj9/0CbN9rQDskI=
X-QQ-mid: esmtpsz18t1795750846t005b7e38
X-QQ-Originating-IP: uROc6SY8cPRHqCbo0tZNh72h/13nBFKmcLhhsL3jfgQ=
Received: from LT-LIANGBAIHUI.dc.com ( [120.237.158.181])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 27 Nov 2026 11:40:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17842540283637095505
EX-QQ-RecipientCnt: 20
From: Baihui Liang <liangbaihui@linux.spacemit.com>
Date: Fri, 27 Nov 2026 11:39:51 +0800
Subject: [PATCH v3] drm/imagination: re-check firmware idle state before
 runtime suspend
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-img-pm-autosuspend-v3-1-3a65ee22d9b2@linux.spacemit.com>
X-B4-Tracking: v=1; b=H4sIAIb7CGsC/32NzQ6CMBAGX4X0bAldsAVPvofxgLCFNfITWhoM4
 d1t8eCFuLdJvp1ZmcGJ0LBLtLIJHRkaeg/pKWJVW/YNcqo9M0hAigQKTl3Dx46Xsx3MbEbsa66
 UgjpPMyG1Yv5xnFDTsktv9y+b+fHEygZTWLRk7DC996oTYfc34AQXHGR+FnmWlGmG1xf18xKbs
 aywIxtXQ8dCycHP5e/QBd6VgZJ5oaUGXRy6tm37AL6h0JQbAQAA
X-Change-ID: 20261029-img-pm-autosuspend-7772d83416f7
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Yixun Lan <dlan@kernel.org>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, gye976@gmail.com, 
 Baihui Liang <liangbaihui@linux.spacemit.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795750844; l=6789;
 i=liangbaihui@linux.spacemit.com; s=20261015; h=from:subject:message-id;
 bh=0LRS5sRlNCnbjexn/7XJmmzCalEGkE1fUT4nAMwDoWc=;
 b=W5t+cb2PvoYGdNHyfjzqgejQrvkXw7bl8Hq6huF3jLaByrFdZXJF5BfQFBHEcambW4v6ASwsq
 sz8WntOYXSLDdTJDv6gS6IPsKtpMbi4NpxW3JzgLQwnLloOvU6xoAw8
X-Developer-Key: i=liangbaihui@linux.spacemit.com; a=ed25519;
 pk=L9Pa1YBHFuJrRPNu/FfSW/likBvv9j2dUrR3r+YyJ5M=
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Mb1BOhWcNIRMEbOuuFz9XFhKTU/zHj10gWylwAze9Ivm7Ug8LQ3td0k1
 YYuFAUpuv0ZFoVlnk6RLqy76mWe/GrWYqq2JqVPjeVw37ptwPaKRBi9fLykgoSTdoCGzWx+
 FtW1Lh4oT8GtgNAGQQsfJML4giIzcOJ4CTeF+Df3QeiNpVXXLYorspSbFkhZMMSeWm5hOSp
 e+CaVv1OSuGwM2iLKHZ4mWAJB10u0KgnfhLguyg7Dzt9EtYois0jFro8IpRl38dJb0sm6+q
 PY5CEOFxlmmhpkkXldkYWz0Vx6NPctPrDVGD9Y1uvIPHuWyWGxpzJsocLnO7O3BknGIPN84
 OxRWv6pyJsaHWaN4o/6LDfhNs/exUgaPsHwfCv6etog/ZrKJa9MAeRsxK90REKWIU6MHtSP
 OVMYHwejcr70KjxGhQ0s4exa9NAhLe8gJMCI+SAPIGyiEUu5f3ZLPjCaJ/OcTMiPPT4Aps4
 IQ6HrdigCEUTzOPosk/GcHR2qPrDLSRm7nI94EyQF2fpirhM5M/Kn1f5hiuo9gPZ+BcA4p8
 gtW4jN+kLSGVc9pIW1u2bHSL09fjLVI5p9bfzQliWzFRE4gPKIb9OIf3t96nrGCdo+WUCCq
 HuN+J3L/hJDsvqi8aDanBgaX0/Y3FhR3aYgrAL8V/tj6+Hz3oEyFxqWgeuXOxuc/MAM7WdR
 zkm3Ndx5eCHWTPWrKosCSFWnShj4MazDAMtprrKvsI1Up7HzmH8jH9ZnEX3O7dPS33byCbs
 RGlv+CdhiSr2y4LQcLhzB5I0EjOsYdP61zakZ28l/nZ3ByaD1IhktrdIhEqU6SGuM0Aj6IY
 v3hOh4EIvqj+BmqIS1RMeGDGKMwS9emiB/X+6BkAk+Zx4xzsy3T2urH62ofSGt15nytCAOE
 fpLMJs3ddiP8YV5jqrVXWd/V5YP18rsROBj8pJAj+Hq0PTU4wIoZnb3gOZjDddRe7AceLtq
 mIOBWWImvws8ciep0VRmKH8RMu1wFJrMlA1H6R0jfQnRWAQpP/DESYXvXwum0MOvHCvr7Y2
 nxY9Ji8neBNici473DTl8D8deA/+T0X6Ubb7c7EaFZyxDT8lJQ2DWl5PkANYZ7NQvQfbuuQ
 /av6skaNSd+gujnpNvrDRh2wkDZ95a0/QM3rEdpWCnhxYiecYvG0XrzL7HIEgj2ZElycRHu
 h8bS
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

pvr_power_device_idle() rejects runtime suspend while the firmware
hasn't reached ROGUE_FWIF_POW_IDLE. The PM core doesn't reschedule
idle notification after rejection, so no further pm_runtime_put()
arrives on an idle GPU and the device stays powered indefinitely.

Move the idle check into pvr_power_device_suspend() and return -EBUSY
after pm_runtime_mark_last_busy() so the PM core reschedules the
autosuspend timer and retries until the firmware is idle.

Factor the power-off sequence into a helper and call it from the
removal path with runtime PM disabled, bypassing the idle check.
Power off before destroying the job and free-list ID arrays, since
the IRQ handler can still process firmware commands during shutdown
and look up free-list IDs.

Signed-off-by: Baihui Liang <liangbaihui@linux.spacemit.com>
---
Changes in v3:
- Factor the shared power-off sequence out of the runtime suspend callback.
- On driver removal, disable runtime PM and bypass the firmware idle check.
  Power off the GPU before destroying the job and free-list ID arrays.
- Link to v2: https://patch.msgid.link/20261111-img-pm-autosuspend-v2-1-427689f6f2f9@linux.spacemit.com

Changes in v2:
- Move the pvr_power_is_idle() check into pvr_power_device_suspend()
  and return -EBUSY after pm_runtime_mark_last_busy().
- Drop pvr_power_device_idle() and pass NULL in RUNTIME_PM_OPS().
- Link to v1: https://patch.msgid.link/20261029-img-pm-autosuspend-v1-1-26851840a34e@linux.spacemit.com
---
 drivers/gpu/drm/imagination/pvr_drv.c   |  9 ++++-
 drivers/gpu/drm/imagination/pvr_power.c | 72 +++++++++++++++++++++++++--------
 drivers/gpu/drm/imagination/pvr_power.h |  2 +-
 3 files changed, 63 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imagination/pvr_drv.c
index 5c965ef0274..bf70cd5c6df 100644
--- a/drivers/gpu/drm/imagination/pvr_drv.c
+++ b/drivers/gpu/drm/imagination/pvr_drv.c
@@ -1469,19 +1469,24 @@ static void pvr_remove(struct platform_device *plat_dev)
 	struct drm_device *drm_dev = platform_get_drvdata(plat_dev);
 	struct pvr_device *pvr_dev = to_pvr_device(drm_dev);
 
+	pm_runtime_disable(drm_dev->dev);
+
 	WARN_ON(!xa_empty(&pvr_dev->job_ids));
 	WARN_ON(!xa_empty(&pvr_dev->free_list_ids));
 
+	pvr_power_device_shutdown(pvr_dev);
+
 	xa_destroy(&pvr_dev->job_ids);
 	xa_destroy(&pvr_dev->free_list_ids);
 
-	pm_runtime_suspend(drm_dev->dev);
 	pvr_device_fini(pvr_dev);
 	drm_dev_unplug(drm_dev);
 	pvr_watchdog_fini(pvr_dev);
 	pvr_queue_device_fini(pvr_dev);
 	pvr_context_device_fini(pvr_dev);
 	pvr_power_domains_fini(pvr_dev);
+
+	pm_runtime_enable(drm_dev->dev);
 }
 
 static const struct pvr_device_data pvr_device_data_manual = {
@@ -1516,7 +1521,7 @@ static const struct of_device_id dt_match[] = {
 MODULE_DEVICE_TABLE(of, dt_match);
 
 static const struct dev_pm_ops pvr_pm_ops = {
-	RUNTIME_PM_OPS(pvr_power_device_suspend, pvr_power_device_resume, pvr_power_device_idle)
+	RUNTIME_PM_OPS(pvr_power_device_suspend, pvr_power_device_resume, NULL)
 };
 
 static struct platform_driver pvr_driver = {
diff --git a/drivers/gpu/drm/imagination/pvr_power.c b/drivers/gpu/drm/imagination/pvr_power.c
index eb4b6ecdf4f..a0537a888d8 100644
--- a/drivers/gpu/drm/imagination/pvr_power.c
+++ b/drivers/gpu/drm/imagination/pvr_power.c
@@ -366,6 +366,50 @@ const struct pvr_power_sequence_ops pvr_power_sequence_ops_pwrseq = {
 	.power_off = pvr_power_off_sequence_pwrseq,
 };
 
+static int
+pvr_power_device_off(struct pvr_device *pvr_dev)
+{
+	int err;
+
+	/* Caller must hold a drm_dev_enter() reference. */
+	if (READ_ONCE(pvr_dev->fw_dev.initialised)) {
+		err = pvr_power_fw_disable(pvr_dev, false, true);
+		if (err)
+			return err;
+	}
+
+	return pvr_dev->device_data->pwr_ops->power_off(pvr_dev);
+}
+
+/* Power the device off on driver removal, skipping the idle check done by
+ * pvr_power_device_suspend() as the device won't be resumed. Runtime PM must be
+ * disabled by the caller.
+ */
+void
+pvr_power_device_shutdown(struct pvr_device *pvr_dev)
+{
+	struct drm_device *drm_dev = from_pvr_device(pvr_dev);
+	struct device *dev = drm_dev->dev;
+	int idx;
+	int err;
+
+	if (pm_runtime_status_suspended(dev))
+		return;
+
+	if (!drm_dev_enter(drm_dev, &idx)) {
+		drm_err(drm_dev, "Device is unplugged, cannot power it off\n");
+		return;
+	}
+
+	err = pvr_power_device_off(pvr_dev);
+	drm_dev_exit(idx);
+	if (!err)
+		err = pm_runtime_set_suspended(dev);
+
+	if (err)
+		drm_err(drm_dev, "Failed to power the device off (%d)\n", err);
+}
+
 int
 pvr_power_device_suspend(struct device *dev)
 {
@@ -378,15 +422,19 @@ pvr_power_device_suspend(struct device *dev)
 	if (!drm_dev_enter(drm_dev, &idx))
 		return -EIO;
 
-	if (READ_ONCE(pvr_dev->fw_dev.initialised)) {
-		err = pvr_power_fw_disable(pvr_dev, false, true);
-		if (err)
-			goto err_drm_dev_exit;
-	}
+	if (READ_ONCE(pvr_dev->fw_dev.initialised) && !pvr_power_is_idle(pvr_dev)) {
+		/*
+		 * The firmware has not drained the GPU yet. Refresh last_busy so
+		 * the PM core reschedules the autosuspend and retries this callback
+		 * until the firmware becomes idle.
+		 */
+		pm_runtime_mark_last_busy(dev);
+		drm_dev_exit(idx);
 
-	err = pvr_dev->device_data->pwr_ops->power_off(pvr_dev);
+		return -EBUSY;
+	}
 
-err_drm_dev_exit:
+	err = pvr_power_device_off(pvr_dev);
 	drm_dev_exit(idx);
 
 	return err;
@@ -427,16 +475,6 @@ pvr_power_device_resume(struct device *dev)
 	return err;
 }
 
-int
-pvr_power_device_idle(struct device *dev)
-{
-	struct platform_device *plat_dev = to_platform_device(dev);
-	struct drm_device *drm_dev = platform_get_drvdata(plat_dev);
-	struct pvr_device *pvr_dev = to_pvr_device(drm_dev);
-
-	return pvr_power_is_idle(pvr_dev) ? 0 : -EBUSY;
-}
-
 static int
 pvr_power_clear_error(struct pvr_device *pvr_dev)
 {
diff --git a/drivers/gpu/drm/imagination/pvr_power.h b/drivers/gpu/drm/imagination/pvr_power.h
index c34252bda07..dde765f18ce 100644
--- a/drivers/gpu/drm/imagination/pvr_power.h
+++ b/drivers/gpu/drm/imagination/pvr_power.h
@@ -16,9 +16,9 @@ void pvr_device_lost(struct pvr_device *pvr_dev);
 
 bool pvr_power_is_idle(struct pvr_device *pvr_dev);
 
+void pvr_power_device_shutdown(struct pvr_device *pvr_dev);
 int pvr_power_device_suspend(struct device *dev);
 int pvr_power_device_resume(struct device *dev);
-int pvr_power_device_idle(struct device *dev);
 
 int pvr_power_reset(struct pvr_device *pvr_dev, bool hard_reset);
 

---
base-commit: 067c5c24cef23d913b67eaaf71ae67e7169a6620
change-id: 20261029-img-pm-autosuspend-7772d83416f7

Best regards,
--  
Baihui Liang <liangbaihui@linux.spacemit.com>

