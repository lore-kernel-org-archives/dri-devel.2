Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10A8C5DF67
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 17:08:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C06AD10E51E;
	Thu, 13 Aug 2026 17:08:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n5wkuiXH";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010029.outbound.protection.outlook.com
 [40.93.198.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 118CE10E51E;
 Thu, 13 Aug 2026 17:08:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GyyLvCCZsOWXprLLoYBv6Cf3Muxt41VjFXyZd7KBzZc+a0Rxbx86Selshrhq/SI87IdcncTeAfCsTwZhBssJH/f2uEvsMs4QtIguffa8kbXK6qnKwyce4KrcOkRSDPbAjnkxlLZ2JkIE5y/n2ps5ArhLK1kBpcoDN2g8/X9/dwFS05tRmrz7P7Eysh5ixr3wwp6GO6/tlMONZdvFAqfu/sfOF8KDUNHw+RHQ6Iwyr7ufQA7JjJanr0pW6j8QqqY+DX4hDXcBfG64mdXfDkV/W6Cf1T1ENlqPIAytv22xddDlkEt21+ISskoL9HNzs0rF/Q4P8BJxM9wGptnPd6oRiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MVpaQbyc4/hGdiR7VuOSocaWRGyxaLKnjJHJaqDqqY=;
 b=E7uAgDyxfURPyleu+QsiprVO080DMwHrvyrf7dd1BucoVTnXC3tU0yDkeUBaKqp4F5CIQRNbcII839kN5wbBTUg6/UkAN0NeVmR37mAlV3BEuE8/dw8SWNkHag0srvx4PmvhLFkjtL/+EckQ28dTdjnaORCldQNJwcIsRlWsLsy9vmPDs9nI8X561V9R4YI9WLcC4JG/gbRD/jNerjYuoDlANRgrzHGhmFSP5F4TFs4qlLkXpYZNFNRE2MMy+rGCtOIA8UZeo5nt/i/tBDgpvN2Q1rGCyPVQjev+iAUhSRzDlrbSKHZeCzEw3lPq2Q8VSqByKKPNEFshJxOlfYK6oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MVpaQbyc4/hGdiR7VuOSocaWRGyxaLKnjJHJaqDqqY=;
 b=n5wkuiXHkW1FQBk1AF3FgNFm9qUMvR+JxOCl4uduSq6gn0ZkDHxsvjTka00vsoqvSiszeJhO7Ar+ilSDqOHpDnnQGzPpBdsGWESEykDneDYP9+aZoKhI27EJryQ6BgGqziqA3nvXQaFlJ0oqDDt0mFWOZfYnnBBQxalHggv4iak=
Received: from PH7P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::34)
 by DM4PR12MB6424.namprd12.prod.outlook.com (2603:10b6:8:be::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 13 Aug
 2026 17:08:16 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:510:32a:cafe::8) by PH7P221CA0023.outlook.office365.com
 (2603:10b6:510:32a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Thu,
 13 Aug 2026 17:08:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 17:08:16 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 12:08:12 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Felix Kuehling
 <Felix.Kuehling@amd.com>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/5] drm/amdgpu: add wedge event implementation
Date: Thu, 13 Aug 2026 19:07:00 +0200
Message-ID: <20260813170705.15745-3-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813170705.15745-1-pierre-eric.pelloux-prayer@amd.com>
References: <20260813170705.15745-1-pierre-eric.pelloux-prayer@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|DM4PR12MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: 6533734e-de02-410a-5b15-08def95d774f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|22082099003|18002099003|56012099006|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: aHkrLpVWM7RktbKO9dEXchfjEaMgixfv1lOWbw1ly8vtOuNOKvK0i7GWlQuEk2dAKCBj1efF8cJ17jM43e2VTaYs/ggO33aKUb4YkEzuE5aAMlA5WOgshXnZMZWyJwM8LhV2TgvDntHF6nyBFtajSaZ0ndFScRfAIphaSiU9f5dwwO/IZw/FM7zBDnR4F1sIDuNPPESxVHyncpXh2yosbukcYKOs0eS1Iy2bMSl0fkDDNFN0RUTSeo1aWcWzQte3POPHRN7rlvhfnfyGfXBzl3EbObcz4iYnFcG+1qT5gL2jVBAdqmK59M9jx/c+u5cum8MKugdwBpAJ7k1I6LE2C7P8CUCW7BpAw/OwquPJ2NAyD4dndt+DilRImsEfcGTt0a1akIkCemVmxSluzGRL26H6dDgSUD8F6rqYsLPzq0mWoVbFb/Awjw2mh01sSx8sixiA8PX0SNxAN2SSNzYuynSftlZyc3cBgKPapUJMrYB6dsuCvq6x+omn1idCSAg6q8LejqxO8OVhDXE96pB/jliE1tVFakSZfV4l0gusP5AUtxZwMqKbWHToUG8ssBpm2LB0UPXgZgqj26ADTN0l1TYwUJKkN/5SZQiBodYRwQNa8jP3Ty79MBzeUrqIK+i8RZGUyWhn4L2X+ZEIl/X9EeesOrg3wb1A8K5ptopyrv278SPtMy7w+oUOLQCLMsyU3teKJjoXOvBb4cfnGtNLCw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tFAY54YZDMBJR1nobARSDdDHk8NUPb4TLd27M0hssEpIyVZOrj0iKK8pQokdi85DH41qoNE454wJIKQa6PuJ6sEOFY0iEd06XI2Mst83hT1Q8+9ZfnMUe/Qm6p81PwHTbJDtl/xF4IFSn25hNLRy97KRyxGAFfYR6nb2rG6jf4dMBV+m0WVjOrmgF6ME7Zbf4PdUiHlRT+AXp3nxmR+bG49Nogp75Yg2xSvBj+9c1kPlVw6i0WkVRnn/Vd8yWR71iKOmswKtxNbN2wYuRpUWtrTz2Ci1OGPfOe48id2J2aXbG3ao1j8Mn8TcZFZFoJWBYWl++X847QygP7xxHjVq/hQxVgmFv5pUJVJeleEz25ncK9NsxzmMUeOz58aiVY5icVza1Wnjf8xUhl+3U7WLXY6wkM4R0R2whjvMeB6ZJQbKEfSd2FVa+LblJ+adCFFj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 17:08:16.1534 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6533734e-de02-410a-5b15-08def95d774f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6424
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
new work. For KFD it's implemented by making
kfd_process_device_data_by_id return NULL if the requested GPU
is wedged.

When the user is done, it's possible to trigger a GPU
reset.

The auto-recovery is still enabled by default, and to use this
feature one has to either:
* boot with amdgpu.gpu_recovery=0: not recommended as it disables
  recovery for all GPUs
* write 0 to /sys/kernel/debug/dri/X/amdgpu_gpu_recover to disable
  auto-recovery for one GPU only

Runtime power management is disabled when the device is wedged
(because we can't submit any work to the GPU).

Assisted-by: Claude:Sonnet 5
Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 13 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  5 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 34 ++++++++++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_process.c   |  6 +++-
 6 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 21b33dc34edf..039a92f2eb0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -964,6 +964,13 @@ struct amdgpu_device {
 	 */
 	bool gpu_recovery_allowed;
 
+	/* Set to 1 when the device has been declared wedged following a
+	 * hang: it no longer accepts new work and pending fences have been
+	 * force-signalled. Reset to 0 once the device is reset back to a
+	 * working state.
+	 */
+	atomic_t wedge_status;
+
 	/* KFD
 	 * Must be last --ends in a flexible-array member.
 	 */
@@ -1349,4 +1356,10 @@ void amdgpu_device_set_uid(struct amdgpu_uid *uid_info,
 			   uint64_t uid);
 uint64_t amdgpu_device_get_uid(struct amdgpu_uid *uid_info,
 			       enum amdgpu_uid_type type, uint8_t inst);
+
+static inline bool amdgpu_device_is_wedged(struct amdgpu_device *adev)
+{
+	return atomic_read(&adev->wedge_status);
+}
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5578d5f64937..949de13d7997 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4035,6 +4035,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	}
 
 	adev->gpu_recovery_allowed = true;
+	if (atomic_xchg(&adev->wedge_status, 0))
+		pm_runtime_put_autosuspend(adev->dev);
 
 fence_driver_init:
 	/* Fence driver */
@@ -5745,6 +5747,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		dev_info(adev->dev, "GPU reset end with ret = %d\n", r);
 
 	atomic_set(&adev->reset_domain->reset_res, r);
+	if (atomic_xchg(&adev->wedge_status, 0))
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
index 43511e0419a1..41d083646da5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -24,6 +24,7 @@
 #include <linux/kthread.h>
 #include <linux/wait.h>
 #include <linux/sched.h>
+#include <linux/pm_runtime.h>
 
 #include <drm/drm_drv.h>
 
@@ -185,9 +186,35 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		if (r)
 			dev_err(adev->dev, "GPU Recovery Failed: %d\n", r);
 	} else {
-		drm_sched_suspend_timeout(&ring->sched);
-		if (amdgpu_sriov_vf(adev))
+		if (amdgpu_sriov_vf(adev)) {
+			drm_sched_suspend_timeout(&ring->sched);
 			adev->virt.tdr_debug = true;
+		} else {
+			struct drm_gpu_scheduler *sched;
+			struct amdgpu_fence *guilty_fence;
+
+			/* Declare the device as wedged if it's not already. */
+			if (!atomic_xchg(&adev->wedge_status, 1)) {
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
+			sched = &ring->sched;
+
+			/* Prevent anybody else from touching the ring buffer. */
+			drm_sched_wqueue_stop(sched);
+
+			amdgpu_fence_driver_force_completion(ring, &guilty_fence->base);
+
+			/* Start the scheduler again */
+			drm_sched_wqueue_start(sched);
+		}
 	}
 
 exit:
@@ -453,7 +480,8 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
 
 	/* Skip job if VRAM is lost and never resubmit gangs */
 	if (job->generation != amdgpu_vm_generation(adev, job->vm) ||
-	    (job->job_run_counter && job->gang_submit))
+	    (job->job_run_counter && job->gang_submit) ||
+	    amdgpu_device_is_wedged(adev))
 		dma_fence_set_error(finished, -ECANCELED);
 
 	if (finished->error < 0) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 0a7c1900da95..544dc960833b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -2433,8 +2433,12 @@ struct kfd_process_device *kfd_process_device_data_by_id(struct kfd_process *p,
 		for (i = 0; i < p->n_pdds; i++) {
 			struct kfd_process_device *pdd = p->pdds[i];
 
-			if (pdd->user_gpu_id == gpu_id)
+			if (pdd->user_gpu_id == gpu_id) {
+				if (amdgpu_device_is_wedged(pdd->dev->adev))
+					return NULL;
+
 				return pdd;
+			}
 		}
 	}
 	return NULL;
-- 
2.43.0

