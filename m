Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C799DCD4F57
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 08:25:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF1B710EB1A;
	Tue, 19 May 2026 08:25:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="YM0I8StG";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE7E510EB10
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 08:25:55 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64J5EwVp3681130; Tue, 19 May 2026 09:25:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=x
 emrNXIpjxfr+d0075XhQuP0Jv8ViFL4/hxjoXXP+Bw=; b=YM0I8StGLJSp1GlPx
 h37ANn4DZfGmT7Mef1oR3K5No0u8jWFc3989sLfPs6D71Um1fyr2rE5oqp+kkqzf
 8+S5XGrWvt8ukxKOQedRU4riWdERw7Tuv7fLJj6xA3b+HUijvg7Lk1LEGk1k+r00
 aN5Q8Dvms25lIDFNACLyqhSae9Fb6YSLVOzrdgCVvgXi5x7x7/BIvxK2bBdjhMn5
 wCY190oCSdtd36Mq5YSHiY8RJaGez5ZSz8XxlQJLZzJANBWEEZI4gnHpF5idtzjz
 XIKP6KxmjvErP/qKS3DbZItWq6e6aMIWoQn9evTiS7co9U79o0tRlqHMvFb41B6e
 7TP0Q==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4e6gnsjda8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 May 2026 09:25:44 +0100 (BST)
Received: from [127.0.1.1] (172.25.128.214) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 19 May
 2026 09:25:41 +0100
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
Date: Tue, 19 May 2026 13:55:28 +0530
Subject: [PATCH v2 3/4] drm/imagination: Rename FW booted to FW initialised
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260519-b4-context_reset-v2-3-931018a7131d@imgtec.com>
References: <20260519-b4-context_reset-v2-0-931018a7131d@imgtec.com>
In-Reply-To: <20260519-b4-context_reset-v2-0-931018a7131d@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Alessio Belle <alessio.belle@imgtec.com>,
 "Alexandru Dadu" <alexandru.dadu@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 "Brajesh Gupta" <brajesh.gupta@imgtec.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779179132; l=5110;
 i=brajesh.gupta@imgtec.com; s=20260417; h=from:subject:message-id;
 bh=aZV17fcQgNulgwuJ9yNPkU/wsgVgzcMzNG5nv09wShc=;
 b=pW7o/3NAbYzdljabMPLvBc/6uuATTRYRicKKZIyDrrliH8I75ksfJXbV6w1cbm7mkqqsmHUUq
 D9gF+GkUuunBFjzB23UGcRWpJAbxE8JQTRT6onWY6CUp2v041KC4oL7
X-Developer-Key: i=brajesh.gupta@imgtec.com; a=ed25519;
 pk=vDcrSP6vOpWKs914T986xUbB/vY0/cU7mRRb16MRkcg=
X-Originating-IP: [172.25.128.214]
X-Proofpoint-GUID: u-mqgfA3jI7vg-mV9mNOz-u0NbOIydP0
X-Proofpoint-ORIG-GUID: u-mqgfA3jI7vg-mV9mNOz-u0NbOIydP0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDA4MiBTYWx0ZWRfX6c9s3h78cXNV
 KBAnfmYiAN1Z7JBkby91YyWNtKIdIqhLvc9CYz0fKrV4/AhBFEy8w0fGafk14oDPKO/IHQ7W0yu
 InORdXBIYnBQQ6xfVd20DP249IoqRM2axKTQafCiGXKwIf/DNLJPqwJRz2li+AUQybeQ4th1zxw
 5sp5+qbq2rYLxP/pCmRvYE0EzZH7YSWhOc3CyIsy5V5agNSKo/E/faDEUa0E1Q2fQ/9bZ9Z4uL2
 YyWvx4069r1JsyMbG8KVwyGgezLJSoNKZYsi+zKEZwjjwpzsRJJhY/y1DehxfO2y5z2BreV5Kdn
 Fupi9jPQqTdhKsyg6D7nKf+VgVTZj/ulwpasjW3g0rkZaJ5nS41NdF7DXF9lZF7S5DT0r9yz48o
 RUHYEZJV9hXQftwKunafMZpxb2JDZu1vcNKHxKGEpM1hfisYhwrPHQbSdvjVyqWpGhFS9QEW9S2
 oB0y7dNisfZ2MNdyIhQ==
X-Authority-Analysis: v=2.4 cv=W9EIkxWk c=1 sm=1 tr=0 ts=6a0c1e88 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=aRQ8HefCnzIA:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=xXLj2AOFsAhGXIg0LM0A:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
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

Rename the variable from 'booted' to 'initialised' to align with the
driver's expectations and state, indicating that FW boot initialisation
is complete and the firmware is fully initialised.

Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_device.c |  2 +-
 drivers/gpu/drm/imagination/pvr_fw.c     |  4 ++--
 drivers/gpu/drm/imagination/pvr_fw.h     |  7 +++++--
 drivers/gpu/drm/imagination/pvr_mmu.c    |  4 ++--
 drivers/gpu/drm/imagination/pvr_power.c  | 14 +++++++-------
 5 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_device.c b/drivers/gpu/drm/imagination/pvr_device.c
index dbb6f5a8ded1..49696101b547 100644
--- a/drivers/gpu/drm/imagination/pvr_device.c
+++ b/drivers/gpu/drm/imagination/pvr_device.c
@@ -213,7 +213,7 @@ static irqreturn_t pvr_device_irq_thread_handler(int irq, void *data)
 	while (pvr_fw_irq_pending(pvr_dev)) {
 		pvr_fw_irq_clear(pvr_dev);
 
-		if (pvr_dev->fw_dev.booted) {
+		if (pvr_dev->fw_dev.initialised) {
 			pvr_fwccb_process(pvr_dev);
 			pvr_kccb_wake_up_waiters(pvr_dev);
 			pvr_device_process_active_queues(pvr_dev);
diff --git a/drivers/gpu/drm/imagination/pvr_fw.c b/drivers/gpu/drm/imagination/pvr_fw.c
index 288516dc2560..b8ad3f1d222c 100644
--- a/drivers/gpu/drm/imagination/pvr_fw.c
+++ b/drivers/gpu/drm/imagination/pvr_fw.c
@@ -1004,7 +1004,7 @@ pvr_fw_init(struct pvr_device *pvr_dev)
 		goto err_fw_stop;
 	}
 
-	fw_dev->booted = true;
+	fw_dev->initialised = true;
 
 	return 0;
 
@@ -1044,7 +1044,7 @@ pvr_fw_fini(struct pvr_device *pvr_dev)
 {
 	struct pvr_fw_device *fw_dev = &pvr_dev->fw_dev;
 
-	fw_dev->booted = false;
+	fw_dev->initialised = false;
 
 	pvr_fw_destroy_structures(pvr_dev);
 	pvr_fw_object_unmap_and_destroy(pvr_dev->kccb.rtn_obj);
diff --git a/drivers/gpu/drm/imagination/pvr_fw.h b/drivers/gpu/drm/imagination/pvr_fw.h
index 1404dd492d7c..3390c84e4fd3 100644
--- a/drivers/gpu/drm/imagination/pvr_fw.h
+++ b/drivers/gpu/drm/imagination/pvr_fw.h
@@ -295,8 +295,11 @@ struct pvr_fw_device {
 	/** @mem: Structure containing objects representing firmware memory allocations. */
 	struct pvr_fw_mem mem;
 
-	/** @booted: %true if the firmware has been booted, %false otherwise. */
-	bool booted;
+	/**
+	 * @initialised: %true if the firmware has been successfully initialised,
+	 *               %false otherwise.
+	 */
+	bool initialised;
 
 	/**
 	 * @processor_type: FW processor type for this device. Must be one of
diff --git a/drivers/gpu/drm/imagination/pvr_mmu.c b/drivers/gpu/drm/imagination/pvr_mmu.c
index 2e4da5b2c499..e9fefcc4e234 100644
--- a/drivers/gpu/drm/imagination/pvr_mmu.c
+++ b/drivers/gpu/drm/imagination/pvr_mmu.c
@@ -133,8 +133,8 @@ int pvr_mmu_flush_exec(struct pvr_device *pvr_dev, bool wait)
 	if (!drm_dev_enter(from_pvr_device(pvr_dev), &idx))
 		return -EIO;
 
-	/* Can't flush MMU if the firmware hasn't booted yet. */
-	if (!pvr_dev->fw_dev.booted)
+	/* Can't flush MMU if the firmware hasn't been initialised yet. */
+	if (!pvr_dev->fw_dev.initialised)
 		goto err_drm_dev_exit;
 
 	cmd_mmu_cache_data->cache_flags =
diff --git a/drivers/gpu/drm/imagination/pvr_power.c b/drivers/gpu/drm/imagination/pvr_power.c
index 88fcce433d12..a73a6815306b 100644
--- a/drivers/gpu/drm/imagination/pvr_power.c
+++ b/drivers/gpu/drm/imagination/pvr_power.c
@@ -216,7 +216,7 @@ pvr_watchdog_worker(struct work_struct *work)
 	if (pm_runtime_get_if_in_use(from_pvr_device(pvr_dev)->dev) <= 0)
 		goto out_requeue;
 
-	if (!pvr_dev->fw_dev.booted)
+	if (!pvr_dev->fw_dev.initialised)
 		goto out_pm_runtime_put;
 
 	stalled = pvr_watchdog_kccb_stalled(pvr_dev);
@@ -378,8 +378,8 @@ pvr_power_device_suspend(struct device *dev)
 	if (!drm_dev_enter(drm_dev, &idx))
 		return -EIO;
 
-	if (pvr_dev->fw_dev.booted) {
-		err = pvr_power_fw_disable(pvr_dev, false, true);
+	if (pvr_dev->fw_dev.initialised) {
+		err = pvr_power_fw_disable(pvr_dev, false);
 		if (err)
 			goto err_drm_dev_exit;
 	}
@@ -408,8 +408,8 @@ pvr_power_device_resume(struct device *dev)
 	if (err)
 		goto err_drm_dev_exit;
 
-	if (pvr_dev->fw_dev.booted) {
-		err = pvr_power_fw_enable(pvr_dev, true);
+	if (pvr_dev->fw_dev.initialised) {
+		err = pvr_power_fw_enable(pvr_dev);
 		if (err)
 			goto err_power_off;
 	}
@@ -548,7 +548,7 @@ pvr_power_reset(struct pvr_device *pvr_dev, bool hard_reset)
 		err = pvr_power_fw_disable(pvr_dev, hard_reset, false);
 		if (!err) {
 			if (hard_reset) {
-				pvr_dev->fw_dev.booted = false;
+				pvr_dev->fw_dev.initialised = false;
 				WARN_ON(pvr_power_device_suspend(from_pvr_device(pvr_dev)->dev));
 
 				err = pvr_fw_hard_reset(pvr_dev);
@@ -556,7 +556,7 @@ pvr_power_reset(struct pvr_device *pvr_dev, bool hard_reset)
 					goto err_device_lost;
 
 				err = pvr_power_device_resume(from_pvr_device(pvr_dev)->dev);
-				pvr_dev->fw_dev.booted = true;
+				pvr_dev->fw_dev.initialised = true;
 				if (err)
 					goto err_device_lost;
 			} else {

-- 
2.43.0

