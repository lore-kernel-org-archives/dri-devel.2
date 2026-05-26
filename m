Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42756CD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 08:14:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8B4E10E5D8;
	Tue, 26 May 2026 08:14:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="gYY0UJOu";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12B7710E5D8
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 08:13:59 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64Q5c4oT1372110; Tue, 26 May 2026 09:13:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=pj5yT923SNawEs2eSwOBIgb
 JRhKAZ71qa/QOAxDaBKc=; b=gYY0UJOuE6fnO4R9IeSuru614tf8du/3z3iWUuJ
 MC1KC4SQFYO4HG/ilA6Ij/0+kbOrYuY7NZWrxIaJbdWf9F5MAIkxUzr2czKJHR+M
 nBPLwU8geML7xVSIWZ2NAewBcVATW1hmkLcPDqHmtnayBsqT//zhmcZ8w0LhuH2t
 +dEbZj9um6UAsV+9DEQrtY3v9n6EHLMyUkU1+KHS3y8DlYfm3ONJILcOJlpcbDPH
 kFGrkCyUn/7p8fQUQQxAon/vUWcwTafytMEKZQiq63b139qRwFJNa682liDl+OBI
 ED47WqqxGj2ZehVG836VmVUWOcscdnY260Htk6y9ei5xf7Q==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4eb2gpj3cj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 May 2026 09:13:43 +0100 (BST)
Received: from NP-A-BELLE.kl.imgtec.org (172.25.4.148) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 09:13:42 +0100
From: Alessio Belle <alessio.belle@imgtec.com>
Date: Tue, 26 May 2026 09:13:07 +0100
Subject: [PATCH 6.12.y v2] drm/imagination: Synchronize interrupts before
 suspending the GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260526-sync-irqs-6-12-v2-1-b4306e95194d@imgtec.com>
X-B4-Tracking: v=1; b=H4sIABJWFWoC/3WNMQ6DMBAEv4KuziH7hA1JlX9EFGAOuAJIbISCk
 P8ey33K2dXOXhDYCwd4FBd4PiTItiagWwFu7taJUYbEQIqsMkQYztWh+E9Ai5pw1NVgerJdUzG
 k0dvzKN8sfIEtNZUntCmfJeybP/PPoXP7T3lo1Ngrdu5ua6Pq5inLtLMr3bZAG2P8AYnzUEC1A
 AAA
X-Change-ID: 20260522-sync-irqs-6-12-f14d5b26a84e
To: <stable@vger.kernel.org>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Frank Binns
 <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Brajesh Gupta <brajesh.gupta@imgtec.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 Alessio Belle <alessio.belle@imgtec.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779783222; l=5576;
 i=alessio.belle@imgtec.com; s=20251208; h=from:subject:message-id;
 bh=J8lKQoNKV+JMfB3fR4hf91EIIcQBXyScajDT6txi44w=;
 b=nMOO4zgP6pwLF2s9lcDprt6TGOTMOHxn4bN0vY7CD1n98bvd1B00AZ9/HDrAMyDxtNDh/uKd5
 YBY6AtNRcyGCW1d6C34IIRiYHEA4gnqMMzA7hnzR3AqiYUd2JJcVHcG
X-Developer-Key: i=alessio.belle@imgtec.com; a=ed25519;
 pk=2Vtuk+GKBRjwMqIHpKk+Gx6zl7cgtq0joszcOc0zF4g=
X-Originating-IP: [172.25.4.148]
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA3MSBTYWx0ZWRfX3pnp9kHsCWzA
 ftCC8kq7PwUJDiFcJvpUwC9IhgyKEhon7EFUpNOOZHmBKx/mVPFBvMISWTZ3ywCYizR7Fqphrbz
 meimWQAb9NUPRXvP6ZVNKMuHT0RrcsFOLA07ruzBgzoGMuGjfJniXZju2WXS7fCEPk1k0Bt719O
 aSCpAomGwHQXVUg8N5quUFJB1/FPyQ81LKJlQzAfOMRa26jNl1BlKFzGm1BF92VnGQssCVym7Ml
 WjX8njhU5XwDtZH38Dy/Cf7iDSGUluUTcOJPQRXq0EBkPvMeUN4CXT7jG0nBwFrAZayZ0mo6E54
 haMgtOFoRaXhs/pLt/wKgKgtvYYF/GSWMK60mU88lV5u5+mb2blIp4vjawhI6TOWAxOm85eBgeD
 GVBVNAl1KQj/BXOjHSlvNBABc4NzwXDHDsP1MARs9vDO0YFcQAPwghqpf2kmZyFtLRcHhTfIkue
 K5OMOeDC0swzfI6Gh/Q==
X-Authority-Analysis: v=2.4 cv=I5xVgtgg c=1 sm=1 tr=0 ts=6a155637 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=eKA7eXnvbLIA:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=bC-a23v3AAAA:8 a=r_1tXGB3AAAA:8 a=VwQbUJbxAAAA:8 a=Ol410iqxPhN9chiBww0A:9
 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: AujraktLsJqIhFUdD5QBir7tWcMYZ-bb
X-Proofpoint-GUID: AujraktLsJqIhFUdD5QBir7tWcMYZ-bb
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

commit 2d7f05cddf4c268cc36256a2476946041dbdd36d upstream.

The runtime PM suspend callback doesn't know whether the IRQ handler is
in progress on a different CPU core and doesn't wait for it to finish.

Depending on timing, the IRQ handler could be running while the GPU is
suspended, leading to it being killed when trying to access GPU
registers. See example signature below.

In a power off sequence initiated by the runtime PM suspend callback,
wait for any IRQ handlers in progress on other CPU cores to finish, by
calling synchronize_irq().

This version of the patch contains only the part of the upstream commit
that applies to 6.12; the rest was a revert of code added in 6.16.
The second paragraph above is different because on 6.12 this kind of bug
doesn't seem to crash the entire kernel, only the IRQ handler, leaving
the driver unusable in practice.

The crash signature below is also different, both because of the above,
and because there was no support for TI AM68 SK in 6.12.

Example signature on a TI AM62 SK platform:

  [ 7827.189088] Internal error: synchronous external abort: 0000000096000010 [#1] PREEMPT SMP
  [ 7827.197311] Modules linked in:
  [ 7827.222015] CPU: 0 UID: 0 PID: 461 Comm: irq/405-gpu Tainted: G   M               6.12.90 #5
  [ 7827.230461] Tainted: [M]=MACHINE_CHECK
  [ 7827.234203] Hardware name: Texas Instruments AM625 SK (DT)
  [ 7827.239682] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  [ 7827.246637] pc : pvr_device_irq_thread_handler+0x64/0x180 [powervr]
  [ 7827.252941] lr : irq_thread_fn+0x2c/0xa8
  [ 7827.256872] sp : ffff800082d8bd50
  [ 7827.260179] x29: ffff800082d8bd70 x28: ffff8000800ce374 x27: ffff800081829cc0
  [ 7827.267328] x26: ffff000004701e80 x25: ffff000005b884ac x24: ffff000005bd5780
  [ 7827.274472] x23: ffff00000da40bc0 x22: ffff00000da40ba0 x21: ffff800082d8bd58
  [ 7827.281614] x20: ffff00000da40000 x19: ffff000004701e80 x18: 08000000c6af9003
  [ 7827.288750] x17: 0000000000000010 x16: 0000000000000068 x15: 0df234008df66400
  [ 7827.295886] x14: 0000000000000000 x13: 000005c68f6e7191 x12: 000000000000025e
  [ 7827.303020] x11: 00000000000000c0 x10: 0000000000000ac0 x9 : ffff800082d8bd00
  [ 7827.310157] x8 : ffff000005bd62a0 x7 : ffff000077261380 x6 : 00000000000005c6
  [ 7827.317292] x5 : 000000000000425e x4 : 0000000000000000 x3 : 0000000000000000
  [ 7827.324428] x2 : 00000000000008a8 x1 : ffff800082d608a8 x0 : ffff000005bd5780
  [ 7827.331568] Call trace:
  [ 7827.334011]  pvr_device_irq_thread_handler+0x64/0x180 [powervr]
  [ 7827.339954]  irq_thread_fn+0x2c/0xa8
  [ 7827.343530]  irq_thread+0x16c/0x2f4
  [ 7827.347019]  kthread+0x110/0x114
  [ 7827.350248]  ret_from_fork+0x10/0x20
  [ 7827.353834] Code: f9446682 f943c281 b9404442 8b020021 (b9400021)
  [ 7827.359921] ---[ end trace 0000000000000000 ]---
  [ 7827.364820] genirq: exiting task "irq/405-gpu" (461) is an active IRQ thread (irq 405)
  [ 8011.230278] powervr fd00000.gpu: Job timeout
  [ 8011.230350] powervr fd00000.gpu: Job timeout
  [ 8011.230426] powervr fd00000.gpu: Job timeout

Fixes: cc1aeedb98ad ("drm/imagination: Implement firmware infrastructure and META FW support")
Fixes: 96822d38ff57 ("drm/imagination: Handle Rogue safety event IRQs")
Cc: stable@vger.kernel.org
Signed-off-by: Alessio Belle <alessio.belle@imgtec.com>
Reviewed-by: Matt Coster <matt.coster@imgtec.com>
Link: https://patch.msgid.link/20260310-drain-irqs-before-suspend-v1-1-bf4f9ed68e75@imgtec.com
Signed-off-by: Matt Coster <matt.coster@imgtec.com>
---
This is a backport of the parts relevant to 6.12 of [1].

[1] https://lore.kernel.org/all/20260310-drain-irqs-before-suspend-v1-0-bf4f9ed68e75@imgtec.com/
---
Changes in v2:
- Restored missing upstream trailers
- Link to v1: https://lore.kernel.org/r/20260522-sync-irqs-6-12-v1-1-b0ecc9675078@imgtec.com
---
 drivers/gpu/drm/imagination/pvr_power.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_power.c b/drivers/gpu/drm/imagination/pvr_power.c
index bf4cf8426f91..077d2651798c 100644
--- a/drivers/gpu/drm/imagination/pvr_power.c
+++ b/drivers/gpu/drm/imagination/pvr_power.c
@@ -84,7 +84,7 @@ pvr_power_request_pwr_off(struct pvr_device *pvr_dev)
 }
 
 static int
-pvr_power_fw_disable(struct pvr_device *pvr_dev, bool hard_reset)
+pvr_power_fw_disable(struct pvr_device *pvr_dev, bool hard_reset, bool rpm_suspend)
 {
 	if (!hard_reset) {
 		int err;
@@ -100,6 +100,11 @@ pvr_power_fw_disable(struct pvr_device *pvr_dev, bool hard_reset)
 			return err;
 	}
 
+	if (rpm_suspend) {
+		/* Wait for late processing of GPU or firmware IRQs in other cores */
+		synchronize_irq(pvr_dev->irq);
+	}
+
 	return pvr_fw_stop(pvr_dev);
 }
 
@@ -243,7 +248,7 @@ pvr_power_device_suspend(struct device *dev)
 		return -EIO;
 
 	if (pvr_dev->fw_dev.booted) {
-		err = pvr_power_fw_disable(pvr_dev, false);
+		err = pvr_power_fw_disable(pvr_dev, false, true);
 		if (err)
 			goto err_drm_dev_exit;
 	}
@@ -425,7 +430,7 @@ pvr_power_reset(struct pvr_device *pvr_dev, bool hard_reset)
 			queues_disabled = true;
 		}
 
-		err = pvr_power_fw_disable(pvr_dev, hard_reset);
+		err = pvr_power_fw_disable(pvr_dev, hard_reset, false);
 		if (!err) {
 			if (hard_reset) {
 				pvr_dev->fw_dev.booted = false;

---
base-commit: 2538fbeff8a94ee2b54eb09d92209e24a1e650d4
change-id: 20260522-sync-irqs-6-12-f14d5b26a84e

Best regards,
-- 
Alessio Belle <alessio.belle@imgtec.com>

