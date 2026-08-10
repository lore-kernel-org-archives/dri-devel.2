Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32402C5AD7B
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 16:54:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 510CA10E234;
	Mon, 10 Aug 2026 16:54:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k0G76b0o";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010042.outbound.protection.outlook.com [52.101.61.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C95D10E234;
 Mon, 10 Aug 2026 16:54:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W42t+aQHrwz1cP7EUo05SiwSDeTrJ4Iv6fULBzbvg/v/EJrhFGS806iROyLh013T2krOCqwovdslyzPzohKfwSma4uhfNEhoqLI2qJ2FBGReSc4PTfhPocOVVQ8eCamhXd42q18QLAm8r8aDD1rRey1TtyNDdTu41WzJ11seJct+rp/exgKR1vWUM7/L6C4R5lLmhLEsNDoKp638ctgWQIg2gVgRp2lGIVlvjmUkoCnc+eCy8JCj9UICCVB8cW2ca+eC39+pr4XQ3xnbEf/7+KjAlWfdD78HMZSs0nJ+W/T8FWwsiod2VKh58bguduQqOM8oAyNQ6ME86512anPZAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHRo2/3dhZi4HMy+u66lmOq55ngoQ5TbxWP+IWhe+dc=;
 b=qwhc8iedG2FT3nZx9NgQMpjTPN0cswEyBuQIHJ8EofXOVkfRwOq3W4wp66QnAxueYBSzL11BRB7WQdqv8Oxn0ZxkTO8xJaFfZ36HYyx8WSypU2AkZYi1h6JbC2B+OyEQY19wwVNwlskwaWVbRXY3ePXkYGHWbD9SqSy1KMkrWTujICGOTXE6IFCms9byBWxnLpzSO9DEtEwEvNh09IRsDXmnKG2AHEpr9n9VS1GNjx34Dyz3BoSBC+s6xrWQxxGdsOVtEb6fK19uU+VTf3bDnc5in8isDKowVcJ5j6YnlkNYYnW5WB8muTslD5KKG58yaw8BIzlkoT19f8CjUiZmQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHRo2/3dhZi4HMy+u66lmOq55ngoQ5TbxWP+IWhe+dc=;
 b=k0G76b0o/D5YCWJkn1NX6fwAf23S41rXZZtinutQdUDKnU8v9OmPUA2q6JHROGBS5II0hfAHne4KyCGnwZcStGZYEEJjNCffMASk/Ca9RYTH7pN4CMNNIFHNf2wP9HJNAK7axdb25lJ+rODbl9a4NS6IYJVMdCm7kVr8ZZG9NM0=
Received: from MW4PR03CA0203.namprd03.prod.outlook.com (2603:10b6:303:b8::28)
 by DM4PR12MB6277.namprd12.prod.outlook.com (2603:10b6:8:a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 16:54:29 +0000
Received: from MW1PEPF00016159.namprd21.prod.outlook.com
 (2603:10b6:303:b8:cafe::3f) by MW4PR03CA0203.outlook.office365.com
 (2603:10b6:303:b8::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 16:54:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF00016159.mail.protection.outlook.com (10.167.249.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.0 via Frontend Transport; Mon, 10 Aug 2026 16:54:29 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 11:54:27 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/3] drm/amdgpu: add wedge event implementation
Date: Mon, 10 Aug 2026 18:53:18 +0200
Message-ID: <20260810165322.24682-1-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00016159:EE_|DM4PR12MB6277:EE_
X-MS-Office365-Filtering-Correlation-Id: 68123ad6-4b31-46d7-05b2-08def7000b5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|18002099003|56012099006|10067099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: ZYx86fIy3nJDY81eYqKVUK6QQ2mBBCPEQsAilPd41VIlazeiKmfBCSzEnoFyYResp8zDlnkssys4YYuVKMTPv5Vz2Ph1LxR8oLjpvsPUre6leNtZKZ0eDFoA/aRfqgXtP8CUrDI0xEQrkpB+5zcU8IFQwwbHQC0kcuHeyqIBRBfJJ6bXUIeu5A4/wOGwYipRQdkGoh/wAsvO+59W0i8pFZ7HOAuUrJA0xGWnGzsCOxwzgB/AtY5nI9UJo9PxdAVhDc3P9wSn9V38ZUn68MPXJKQ43ve1v/+yGrbKOEXVELF7SnqIIaIM0fj9MJBv0oe9cVCHuwoehqKxrrrM/oMkXlBvv2cY4UcdhS/UaqmVIDWoubT++7haac//+xBMum0mw1d1eavzL0/LrscD/oAKPEo+KTaJw9OKQ8fZNB15OGWdAFjcc0qXkFPAv7VcX5smhYlawscnv8SkCh1fYNC5T1hRnzVrTq0kfnZufhoC8bG5ogYf7FAmdtY9JCc78oQOYLLdNdhZSPFBgPeWobMRNk+d8kRdGor4Kg2ycJ9SdSGdUzHSEXXutCKHIzSpJgP5voqX4pD2JpV4voSiGuFIi480e27xm8TKVbhMLshJbVwSFqiyzWe5OHmoaN3WHBgEmt0iXCgq37aJfBaRizA+om5XIJ0cExyp58VviFwCqtL04SmvR7rx9O3NE/xTUoD2JjZ7ciD/s9UXRy1JeBcJtA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(56012099006)(10067099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ImuaXltzay6EkQX0UFxiX/jvh2mUWmoQWaEGASXb3dDuiYo+t7j4IiAGwsO/Q+bE+POwiUctf1T8lHoWnO5UOziOHDFp4oY2PBCTvTF/QsEuX8lLiuW6aa9pxxssF8c91g6yCaQaTBpp7kB8BEPflnQLApFJUuL3q2fmq6URkmP4Ui0t5Hbu4Qup6hPlobgwxWgwzpoIkD647a0H9YMSM9ROoMFD3DRc5VJg7RggtCdEtDLgPVDA9CHJICzxFCYNNBbnAOvEGGtpBtVNdibushhoWpLaxAuMy3oXCycdM2URYvtPKmWCW+A4f0LftPzu5+3vCTq/kxrULV81IXaoosbcBopneWqSg4X9KVGw0HZprpkwY/tp32PXStKAlhwce+6o+iu3Hg33XTcwBXu4Prwwkd1PKImXHkmvHUOc7nZIzhf48xikSc6sBy91cvrz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 16:54:29.4609 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68123ad6-4b31-46d7-05b2-08def7000b5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF00016159.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6277
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

When a job times out the kernel tries to reset the GPU to get
the system back to a normal state.
Sometimes it's useful to disable this process - for instance to
be able to inspect the hardware state at the time of the hang.
Since leaving fence unsignalled might affect the system's
stability, this commit enables the drm wedge framework for amdgpu.

When a hang condition is detected, the GPU isn't reset but all
the pending fences are signalled and the hung GPU cannot receive
new work. When the user is done, it's possible to trigger a GPU
reset.

The auto-recovery is still enabled by default, and to use this
feature one has to either:
* boot with amdgpu.gpu_recovery=0: not recommended as it disables
  recovery for all GPUs
* write to /sys/kernel/debug/dri/X/amdgpu_wedge to enable/disable
  at runtime for one GPU

The implementation uses at atomic to store the wedge status.
Runtime power management is disabled when the decided is wedged
(because we can't submit any work to the GPU).

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 11 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  5 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 35 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 43 ++++++++++++++++++++--
 6 files changed, 100 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 7974f9b7944f..83f4a86303bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -957,6 +957,11 @@ struct amdgpu_device {
 
 	struct amdgpu_uma_carveout_info uma_info;
 
+	struct {
+		atomic_t flag;
+		int boot_gpu_recovery;
+	} wedged;
+
 	/* KFD
 	 * Must be last --ends in a flexible-array member.
 	 */
@@ -1342,4 +1347,10 @@ void amdgpu_device_set_uid(struct amdgpu_uid *uid_info,
 			   uint64_t uid);
 uint64_t amdgpu_device_get_uid(struct amdgpu_uid *uid_info,
 			       enum amdgpu_uid_type type, uint8_t inst);
+
+static inline bool amdgpu_device_is_wedged(struct amdgpu_device *adev)
+{
+	return atomic_read(&adev->wedged.flag);
+}
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 964efec0d335..c636a94d869c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4034,6 +4034,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		}
 	}
 
+	adev->wedged.boot_gpu_recovery = amdgpu_gpu_recovery;
+	if (atomic_xchg(&adev->wedged.flag, 0))
+		pm_runtime_put_autosuspend(adev->dev);
+
 fence_driver_init:
 	/* Fence driver */
 	r = amdgpu_fence_driver_sw_init(adev);
@@ -5740,6 +5744,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		dev_info(adev->dev, "GPU reset end with ret = %d\n", r);
 
 	atomic_set(&adev->reset_domain->reset_res, r);
+	if (atomic_xchg(&adev->wedged.flag, 0))
+		pm_runtime_put_autosuspend(adev->dev);
 
 	if (!r) {
 		struct amdgpu_task_info *ti = NULL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 0ab380ca7e64..399e935df7b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3006,10 +3006,15 @@ long amdgpu_drm_ioctl(struct file *filp,
 		      unsigned int cmd, unsigned long arg)
 {
 	struct drm_file *file_priv = filp->private_data;
+	struct amdgpu_device *adev;
 	struct drm_device *dev;
 	long ret;
 
 	dev = file_priv->minor->dev;
+	adev = drm_to_adev(dev);
+	if (amdgpu_device_is_wedged(adev))
+		return -ENODEV;
+
 	ret = pm_runtime_get_sync(dev->dev);
 	if (ret < 0)
 		goto out;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 3043ad041bb4..b24106298576 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -974,6 +974,39 @@ static int amdgpu_debugfs_fence_info_show(struct seq_file *m, void *unused)
 	return 0;
 }
 
+/*
+ * amdgpu_debugfs_wedge - enable/disable "wedged" device framework.
+ *
+ * When enabled, gpu auto recovery will be disabled and the device has to
+ * be reset manually (equivalent to amdgpu.gpu_recovery=0).
+ *
+ * Read will return if the device is currently wedged.
+ */
+static int amdgpu_device_wedged_get(void *data, u64 *val)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)data;
+	*val = amdgpu_device_is_wedged(adev);
+	return 0;
+}
+static int amdgpu_device_wedged_set(void *data, u64 val)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)data;
+
+	if (amdgpu_device_is_wedged(adev))
+		return -EINVAL;
+
+	if (val)
+		amdgpu_gpu_recovery = 0;
+	else
+		amdgpu_gpu_recovery = adev->wedged.boot_gpu_recovery;
+
+	return 0;
+}
+
+
+DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_wedge_fops, amdgpu_device_wedged_get, amdgpu_device_wedged_set,
+			 "%lld\n");
+
 /*
  * amdgpu_debugfs_gpu_recover - manually trigger a gpu reset & recover
  *
@@ -1039,6 +1072,8 @@ void amdgpu_debugfs_fence_init(struct amdgpu_device *adev)
 		INIT_WORK(&adev->reset_work, amdgpu_debugfs_reset_work);
 		debugfs_create_file("amdgpu_gpu_recover", 0444, root, adev,
 				    &amdgpu_debugfs_gpu_recover_fops);
+		debugfs_create_file("amdgpu_wedge", 0644, root, adev,
+				    &amdgpu_debugfs_wedge_fops);
 	}
 #endif
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 3dc8faa091d7..f43d85ba4b78 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -716,6 +716,9 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	struct amdgpu_job *job;
 	int r;
 
+	if (amdgpu_device_is_wedged(adev))
+		return;
+
 	ring = to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
 
 	if (!hub->sdma_invalidation_workaround || vmid ||
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index d97cf1212e0f..187eac9aab1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -24,6 +24,7 @@
 #include <linux/kthread.h>
 #include <linux/wait.h>
 #include <linux/sched.h>
+#include <linux/pm_runtime.h>
 
 #include <drm/drm_drv.h>
 
@@ -184,9 +185,44 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		if (r)
 			dev_err(adev->dev, "GPU Recovery Failed: %d\n", r);
 	} else {
-		drm_sched_suspend_timeout(&ring->sched);
-		if (amdgpu_sriov_vf(adev))
+		if (amdgpu_sriov_vf(adev)) {
+			drm_sched_suspend_timeout(&ring->sched);
 			adev->virt.tdr_debug = true;
+		} else {
+			/* Declare the device as wedged if it's not already. */
+			struct drm_gpu_scheduler *sched;
+			struct amdgpu_ring *ring;
+			struct amdgpu_fence *guilty_fence;
+			int i;
+
+			if (!atomic_xchg(&adev->wedged.flag, 1)) {
+				pm_runtime_get_sync(adev->dev);
+
+				pci_clear_master(adev->pdev);
+
+				drm_dev_wedged_event(&adev->ddev, DRM_WEDGE_RECOVERY_REBIND |
+						DRM_WEDGE_RECOVERY_BUS_RESET, NULL);
+			}
+
+			guilty_fence = to_amdgpu_job(s_job)->hw_fence;
+
+			for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
+				ring = adev->rings[i];
+
+				if (!amdgpu_ring_sched_ready(ring))
+					continue;
+
+				sched = &ring->sched;
+
+				/* Stop the scheduler to prevent anybody else from touching the ring buffer. */
+				drm_sched_wqueue_stop(sched);
+
+				amdgpu_fence_driver_force_completion(ring, &guilty_fence->base);
+
+				/* Start the scheduler again */
+				drm_sched_wqueue_start(sched);
+			}
+		}
 	}
 
 exit:
@@ -452,7 +488,8 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
 
 	/* Skip job if VRAM is lost and never resubmit gangs */
 	if (job->generation != amdgpu_vm_generation(adev, job->vm) ||
-	    (job->job_run_counter && job->gang_submit))
+	    (job->job_run_counter && job->gang_submit) ||
+	    amdgpu_device_is_wedged(adev))
 		dma_fence_set_error(finished, -ECANCELED);
 
 	if (finished->error < 0) {
-- 
2.43.0

