Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACAECCD4851
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 06:47:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1987910E97B;
	Tue, 12 May 2026 06:47:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="f+CzhVRz";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62B9710E97B
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 06:47:50 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64C5A2Zt1917347; Tue, 12 May 2026 07:47:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=k
 xfg1XWIhk6tdwELSLWLOFQ64UZo/MwznNHe1YAsA/g=; b=f+CzhVRzt2orx9H1T
 +9x8nRjI4L5GL2Ro8XFSMGz7QjcSOlJ7YDNglFTQ+ySQa/omi8o9R7HN4nyBR4Qk
 mNTgNGcxxCBgKdAybRt+2VvQqrLXiJi2amMcvixFU84sKmMLjvP7yzNVBRrvy+SP
 w0t1AWxLYGYvJUbHVwGTuBJRWgXxGXZxmjDT0QCUThS7/wwmSftY/sfuWEb9xlsP
 p4tiw2WvD/Xz7dKoJprypmYJPeKJms3RqF9pEeUWT1hVLNXkaH8cszk/DaU6BLbR
 xkFpYg05xscrtOvCPJrTV4S7AmmALryDn5sbaXAIUZOaCseBAuQ6YOo3JvGRluaB
 Kcwkg==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4e1w0t2c6c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 May 2026 07:47:40 +0100 (BST)
Received: from [127.0.1.1] (172.25.128.214) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 07:47:36 +0100
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
Date: Tue, 12 May 2026 12:17:06 +0530
Subject: [PATCH 4/4] drm/imagination: Access FW initialised state with
 READ/WRITE_ONCE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260512-b4-context_reset-v1-4-439bee96ed83@imgtec.com>
References: <20260512-b4-context_reset-v1-0-439bee96ed83@imgtec.com>
In-Reply-To: <20260512-b4-context_reset-v1-0-439bee96ed83@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Alessio Belle <alessio.belle@imgtec.com>,
 "Alexandru Dadu" <alexandru.dadu@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 "Brajesh Gupta" <brajesh.gupta@imgtec.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778568444; l=4211;
 i=brajesh.gupta@imgtec.com; s=20260417; h=from:subject:message-id;
 bh=GRqIZg1SyGtcigDD/Tmdx9J9kf1KM0s3ZODFHCcl2JI=;
 b=oM+PTL49wjR4LgoZ6cZZ+ZRyKE3Uvrkb1M/iBfMjlZ+BvLqGsq0yGwtm8m1uqNLmmrXB92FrA
 CLpzosgX/u7BGTAeLonueW9r7SBMwNCe7npri14/k8i5XHShgEqJBKl
X-Developer-Key: i=brajesh.gupta@imgtec.com; a=ed25519;
 pk=vDcrSP6vOpWKs914T986xUbB/vY0/cU7mRRb16MRkcg=
X-Originating-IP: [172.25.128.214]
X-Authority-Analysis: v=2.4 cv=b/6CJNGx c=1 sm=1 tr=0 ts=6a02cd0c cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=aRQ8HefCnzIA:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=xXLj2AOFsAhGXIg0LM0A:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA2NCBTYWx0ZWRfX7sXcou9kSIZg
 c1Gb2Og5YeDgGsxOcN+Mzn46YJMNk9T19PpbWx5qj1Egoo+y+XmyS73NkM3ccQc29tCtM7SvaEs
 x5xiDMEKvkezLvlaT9Qi4zJRVLoh1YKLjd/4+MwNgc4SgVtZCi4ItYq4J1TePpvQV+uTXRDpcRy
 aUWh7DYfDp+u5cwqHmtCIy++sD76i8pLhPpcEaIqGEcIw/V3eBBqMbpulZ7ukaIP7khUQddbvwD
 h4aqpoROdcCy7agvkysn+L0anuGOPpwxGN9raLtAyLwZ9BXoebt7V99QWYqBzEglZI23dJdFTTF
 7lJmwBNR2zrcWFpZyepCTxRCGD2weJ2lMKY/IdPDSihDIny9/noid7Ea9rQLtZsx3PPDLEzu0AT
 H2cxvZAi7gHfd6xtexPcI/eBrffoh1qk54dnMM7Q38Vj+Fj6phOcOGN3hNe99BUBhS9kiBxdMAI
 j0Z8T2vHdq8BJ9FAYRQ==
X-Proofpoint-GUID: RBaXoXS-z6-e57MAXjZ2gvla73OsawMp
X-Proofpoint-ORIG-GUID: RBaXoXS-z6-e57MAXjZ2gvla73OsawMp
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

Update FW initialised state shared resource access with READ/WRITE_ONCE
to prevent any complier optimization and ensure atomicity of operation.

Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_device.c |  2 +-
 drivers/gpu/drm/imagination/pvr_fw.c     |  4 ++--
 drivers/gpu/drm/imagination/pvr_mmu.c    |  2 +-
 drivers/gpu/drm/imagination/pvr_power.c  | 10 +++++-----
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_device.c b/drivers/gpu/drm/imagination/pvr_device.c
index 49696101b547..2691ef9af0ca 100644
--- a/drivers/gpu/drm/imagination/pvr_device.c
+++ b/drivers/gpu/drm/imagination/pvr_device.c
@@ -213,7 +213,7 @@ static irqreturn_t pvr_device_irq_thread_handler(int irq, void *data)
 	while (pvr_fw_irq_pending(pvr_dev)) {
 		pvr_fw_irq_clear(pvr_dev);
 
-		if (pvr_dev->fw_dev.initialised) {
+		if (READ_ONCE(pvr_dev->fw_dev.initialised)) {
 			pvr_fwccb_process(pvr_dev);
 			pvr_kccb_wake_up_waiters(pvr_dev);
 			pvr_device_process_active_queues(pvr_dev);
diff --git a/drivers/gpu/drm/imagination/pvr_fw.c b/drivers/gpu/drm/imagination/pvr_fw.c
index b8ad3f1d222c..850a3ec8e775 100644
--- a/drivers/gpu/drm/imagination/pvr_fw.c
+++ b/drivers/gpu/drm/imagination/pvr_fw.c
@@ -1004,7 +1004,7 @@ pvr_fw_init(struct pvr_device *pvr_dev)
 		goto err_fw_stop;
 	}
 
-	fw_dev->initialised = true;
+	WRITE_ONCE(fw_dev->initialised, true);
 
 	return 0;
 
@@ -1044,7 +1044,7 @@ pvr_fw_fini(struct pvr_device *pvr_dev)
 {
 	struct pvr_fw_device *fw_dev = &pvr_dev->fw_dev;
 
-	fw_dev->initialised = false;
+	WRITE_ONCE(fw_dev->initialised, false);
 
 	pvr_fw_destroy_structures(pvr_dev);
 	pvr_fw_object_unmap_and_destroy(pvr_dev->kccb.rtn_obj);
diff --git a/drivers/gpu/drm/imagination/pvr_mmu.c b/drivers/gpu/drm/imagination/pvr_mmu.c
index e9fefcc4e234..3cac482e1034 100644
--- a/drivers/gpu/drm/imagination/pvr_mmu.c
+++ b/drivers/gpu/drm/imagination/pvr_mmu.c
@@ -134,7 +134,7 @@ int pvr_mmu_flush_exec(struct pvr_device *pvr_dev, bool wait)
 		return -EIO;
 
 	/* Can't flush MMU if the firmware hasn't been initialised yet. */
-	if (!pvr_dev->fw_dev.initialised)
+	if (!READ_ONCE(pvr_dev->fw_dev.initialised))
 		goto err_drm_dev_exit;
 
 	cmd_mmu_cache_data->cache_flags =
diff --git a/drivers/gpu/drm/imagination/pvr_power.c b/drivers/gpu/drm/imagination/pvr_power.c
index a73a6815306b..0ed9e7be604b 100644
--- a/drivers/gpu/drm/imagination/pvr_power.c
+++ b/drivers/gpu/drm/imagination/pvr_power.c
@@ -216,7 +216,7 @@ pvr_watchdog_worker(struct work_struct *work)
 	if (pm_runtime_get_if_in_use(from_pvr_device(pvr_dev)->dev) <= 0)
 		goto out_requeue;
 
-	if (!pvr_dev->fw_dev.initialised)
+	if (!READ_ONCE(pvr_dev->fw_dev.initialised))
 		goto out_pm_runtime_put;
 
 	stalled = pvr_watchdog_kccb_stalled(pvr_dev);
@@ -378,7 +378,7 @@ pvr_power_device_suspend(struct device *dev)
 	if (!drm_dev_enter(drm_dev, &idx))
 		return -EIO;
 
-	if (pvr_dev->fw_dev.initialised) {
+	if (READ_ONCE(pvr_dev->fw_dev.initialised)) {
 		err = pvr_power_fw_disable(pvr_dev, false);
 		if (err)
 			goto err_drm_dev_exit;
@@ -408,7 +408,7 @@ pvr_power_device_resume(struct device *dev)
 	if (err)
 		goto err_drm_dev_exit;
 
-	if (pvr_dev->fw_dev.initialised) {
+	if (READ_ONCE(pvr_dev->fw_dev.initialised)) {
 		err = pvr_power_fw_enable(pvr_dev);
 		if (err)
 			goto err_power_off;
@@ -548,7 +548,7 @@ pvr_power_reset(struct pvr_device *pvr_dev, bool hard_reset)
 		err = pvr_power_fw_disable(pvr_dev, hard_reset, false);
 		if (!err) {
 			if (hard_reset) {
-				pvr_dev->fw_dev.initialised = false;
+				WRITE_ONCE(pvr_dev->fw_dev.initialised, false);
 				WARN_ON(pvr_power_device_suspend(from_pvr_device(pvr_dev)->dev));
 
 				err = pvr_fw_hard_reset(pvr_dev);
@@ -556,7 +556,7 @@ pvr_power_reset(struct pvr_device *pvr_dev, bool hard_reset)
 					goto err_device_lost;
 
 				err = pvr_power_device_resume(from_pvr_device(pvr_dev)->dev);
-				pvr_dev->fw_dev.initialised = true;
+				WRITE_ONCE(pvr_dev->fw_dev.initialised, true);
 				if (err)
 					goto err_device_lost;
 			} else {

-- 
2.43.0

