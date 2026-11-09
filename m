Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F54606A33D
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 17:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xrphkCuh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86EC010F46D;
	Mon,  9 Nov 2026 17:15:51 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012009.outbound.protection.outlook.com
 [40.93.195.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C210910F46D;
 Mon,  9 Nov 2026 17:15:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=byk4lVQhsHxacHvA6D/aJ3gNSj1+HZrs6Xw5vdFEjm8Py2H4Yx1FGp4pMcJf2en4YvNNum88m8QoSUYD3rXbpCCRVCg+Skfa1T3qyzNNJh29zXhi8eBBrK84Ims8RHpQdvS4Lnx8LV96YxO+Q2PULikSZz1PHKjG4fkRo83NLAUT8XgPIyHFoHVsxjPYVP7Kx1teQqk1nPTaCH24veErBw7+W2nqxAHXxwOsiYXM7ouKty2mwwCASSMn2Xyl5M8PxGhwyg5P5qPKTPAjiP0Phn0SfAftFRFU60n3iDkadeG38EpJtJUhOXKDZE3Q9W/RVvcsTwWrd4qgUXSENJEjSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyHMIwkA56U4AEYpadHfaZeALE/+Kg49s7t2doPLk9A=;
 b=nZ2n1/Dk7aS8Vkb6oFqEYFIpQDksUBuVcd6cGipTygGZuS/fxAbQWJXngO+/6iEGzwHoqvxOmGP+8felpl/pdizP3dXBGEGwW2Zbg3vl2UgAGcsQOpwJMT6yQ7VwmYwxm0cHRUCh+BkZ9ZGo0hiez4LDvYQBN/Y71XCCkv2DV3sZFVuu3vfdZ6f3DErtF+jydLMCfivYaXBb97uzhu2DLtPCjt7aDdL61vQn1wI0LManW3KDy/rkiAsNKHFhR4tKSTItdX4ys63IsDL9ehu95hhQmeDWO7kzjXZfvNL9DDIKB0FDeDq+0fDgYMeU6afKcAu1iolom7w+PNc/zm7tFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyHMIwkA56U4AEYpadHfaZeALE/+Kg49s7t2doPLk9A=;
 b=xrphkCuhCV2x0DSo81CQB4hkMhB24pMF9bfxbliZIkBAgiHd3AmtSF5Q3WPYjROgnTG8G99TJcYZ1mCVdEsqPNe3ZrE8o3oig0BePs9AOhwFnsiNEh+3tmd5vPazPJRADhFGkn3ugIlSeWVljDBz2nrqR4DxpqC26UVURM9U9LU=
Received: from MW4PR04CA0171.namprd04.prod.outlook.com (2603:10b6:303:85::26)
 by LV2PR12MB6014.namprd12.prod.outlook.com (2603:10b6:408:170::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Mon, 9 Nov
 2026 17:15:38 +0000
Received: from CO1PEPF0001885D.namprd02.prod.outlook.com
 (2603:10b6:303:85:cafe::9a) by MW4PR04CA0171.outlook.office365.com
 (2603:10b6:303:85::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 17:15:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF0001885D.mail.protection.outlook.com (10.167.249.246) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 17:15:38 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Mon, 9 Nov 2026 11:15:36 -0600
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Felix Kuehling
 <Felix.Kuehling@amd.com>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 5/6] drm/amdgpu: add wedge event implementation
Date: Mon, 9 Nov 2026 18:13:24 +0100
Message-ID: <20261109171333.4329-5-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109171333.4329-1-pierre-eric.pelloux-prayer@amd.com>
References: <20261109171333.4329-1-pierre-eric.pelloux-prayer@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF0001885D:EE_|LV2PR12MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: 92a05cc9-4bcc-4e08-9771-08df3e851358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|23010399003|261009223027099003|261009221227099003|261026140227099003|261028144727099003|261102123227099003|261021121427099003|261022105027099003|261022075727099003|261026121527099003|261021123027099003|11063799006|56012099006|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: T/VJOlQwThjjTLRuj9xu6qNNPjPObMwU/25TUn6LzaCxpd8xOLzSy0lRNVxhXPaeg1eaN3kn1Mfjubr4K7ZJBIdjl3v91vKIXtLu+L5l9ZLLPH2NmhlvavXl6HDaS9XKR3BLRBCPVzY4iPIOHToKYeqbpdPwn37q7SZUEOwKli6BiQ8vh/VbSrT18fHPg8RcTziMXOJ8VohXTaYEr8XyjqdqFFl2q3eBVZd/5+5ozMXr0qYU5SZMsebLSR7RU6yJldhaOHOLjvx3VKfuk5jhdVx37EQ0E3nFp6ALtbWquyP1oFQRMo2UiDMicutNYDZcjtu0Os+sTvOW3q6Z6nqwcfkUtj3oZ9GDhqBm/E2at580crwIyQTR25LBQC7RQjg1SCI/MgjF83V91exAPrTz1vs7a7ILBUun6x6kz48fII2c1tCl9KITLFw5dQP6OUn28ZwRLCtkn8Gs/G+7LEEtd251zFc5M8z/8FDIZC72LIUXOthDZlvk0Dq2bhkawfyXTPRCmx07ns2eqnbghMhS6fw+tkj2WT94jzH/K6pLviYr3Uz4qSK7kRZ2+VSWQwAewVTKJ4aFz4VGIdRaUIoIQ3hHBGarXsSr43Jch6GhUuLQZLIsLT6UbIExrK0gPBzRKyXLriDhekT3Zb+p8LE27Rli2gB1HMFOryGg/5QATRwPmhPW5UpMvHH225VsRtV0vo5k9wohIuY/KSuR42hCtg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(261009223027099003)(261009221227099003)(261026140227099003)(261028144727099003)(261102123227099003)(261021121427099003)(261022105027099003)(261022075727099003)(261026121527099003)(261021123027099003)(11063799006)(56012099006)(6133799003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Rq34LxxAP92uJtnimopqWqk9d+3RfqHeTbjoluqqixxguREcMsVkFZQ+oSa0CwvlkErlw/+0f3sYYPYAZ7MrTriXbwy0zsVM6iOUSJduabjuK4IvaPzy8xqPuTsb6aM8NaCZuQBi6ge1tu0DGrkKlzC9viw4JuE7Xs10fU5xw393mgDxHHdUeQp3QEfrvUi1QeFjkeCUssTeg42CvcnrPhFCeIYrpsqKuWn1mg41fbuQ3sq9k4OOpzL/8FE3ApGEtEStrhbalibsx8wRWVGIzhOCPOyGZx8Q0+moFue3BdpPQJLoResltgjuLpHtgB+hx0X6MaIsv9TPKiQUqLRTFWs9iozO9+VvcsaaW+GtJqwhW2ZIkQk+ShoORZi7FyIg7kq3A/5lNJI7EU18iBgbx9iHLIkwZXYypgLD5QvYwVZUtc1QVLbqB8AbB4In2Wqj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 17:15:38.4693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a05cc9-4bcc-4e08-9771-08df3e851358
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF0001885D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

Assisted-by: LLM
Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 13 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c     |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  8 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    |  8 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 31 +++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 12 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  5 ----
 drivers/gpu/drm/amd/amdkfd/kfd_process.c   |  6 ++++-
 10 files changed, 81 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index a486ac746a5b..cfbb5ab5a2fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -985,6 +985,13 @@ struct amdgpu_device {
 	/* Per device gpu_recovery setting. 0 means disabled. */
 	unsigned int gpu_recovery;
 
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
@@ -1374,4 +1381,10 @@ void amdgpu_device_set_uid(struct amdgpu_uid *uid_info,
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index fa301c71b782..d119de477284 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1465,6 +1465,9 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	if (!adev->accel_working)
 		return -EBUSY;
 
+	if (amdgpu_device_is_wedged(adev))
+		return -ENODEV;
+
 	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, lock);
 
 	r = PM_RUNTIME_ACQUIRE_ERR(&lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a812551b353f..7335f9c4d86f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4149,6 +4149,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	}
 
 	amdgpu_device_init_gpu_recovery(adev);
+	atomic_set(&adev->wedge_status, 0);
 
 fence_driver_init:
 	/* Fence driver */
@@ -4401,6 +4402,9 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 		amdgpu_sync_free(&adev->isolation[i].prev);
 	}
 
+	if (atomic_xchg(&adev->wedge_status, 0))
+		pm_runtime_put_autosuspend(adev->dev);
+
 	amdgpu_reset_fini(adev);
 
 	/* free i2c buses */
@@ -5144,6 +5148,10 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
 	r = 0;
 	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
 		amdgpu_set_init_level(tmp_adev, init_level);
+
+		if (atomic_xchg(&tmp_adev->wedge_status, 0))
+			pm_runtime_put_autosuspend(tmp_adev->dev);
+
 		if (full_reset) {
 			/* post card */
 			amdgpu_reset_set_dpc_status(tmp_adev, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index fb60a99f43c1..9b4c76f198f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -459,6 +459,9 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 	uint32_t handle, initial_domain;
 	int r;
 
+	if (amdgpu_device_is_wedged(adev))
+		return -ENODEV;
+
 	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, lock);
 
 	r = PM_RUNTIME_ACQUIRE_ERR(&lock);
@@ -967,6 +970,11 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	if (r)
 		goto error_put_gobj;
 
+	if (amdgpu_device_is_wedged(adev)) {
+		r = -ENODEV;
+		goto error_put_gobj;
+	}
+
 	/* Add input syncobj fences (if any) for synchronization. */
 	r = amdgpu_gem_add_input_fence(filp,
 				       args->input_fence_syncobj_handles,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 4204c3c750a8..53fa9fa83ae7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -730,6 +730,9 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	struct amdgpu_job *job;
 	int r;
 
+	if (amdgpu_device_is_wedged(adev))
+		return;
+
 	ring = to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
 
 	if (!hub->sdma_invalidation_workaround || vmid ||
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 16391cc2b9a5..61e8f479556e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -24,6 +24,7 @@
 #include <linux/kthread.h>
 #include <linux/wait.h>
 #include <linux/sched.h>
+#include <linux/pm_runtime.h>
 
 #include <drm/drm_drv.h>
 
@@ -184,9 +185,30 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		if (r)
 			dev_err(adev->dev, "GPU Recovery Failed: %d\n", r);
 	} else {
-		drm_sched_suspend_timeout(&ring->sched);
-		if (amdgpu_sriov_vf(adev))
-			adev->virt.tdr_debug = true;
+		struct drm_gpu_scheduler *sched;
+		struct amdgpu_fence *guilty_fence;
+
+		/* Declare the device as wedged if it's not already. */
+		if (!atomic_xchg(&adev->wedge_status, 1)) {
+			/* This ref will be dropped in amdgpu_device_reinit_after_reset. */
+			pm_runtime_get_noresume(adev->dev);
+
+			pci_clear_master(adev->pdev);
+
+			drm_dev_wedged_event(&adev->ddev, DRM_WEDGE_RECOVERY_REBIND, info);
+		}
+
+		guilty_fence = to_amdgpu_job(s_job)->hw_fence;
+
+		sched = &ring->sched;
+
+		/* Prevent anybody else from touching the ring buffer. */
+		drm_sched_wqueue_stop(sched);
+
+		amdgpu_fence_driver_force_completion(ring, &guilty_fence->base);
+
+		/* Start the scheduler again */
+		drm_sched_wqueue_start(sched);
 	}
 
 exit:
@@ -438,7 +460,8 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
 
 	/* Skip job if VRAM is lost and never resubmit gangs */
 	if (job->generation != amdgpu_vm_generation(adev, job->vm) ||
-	    (job->job_run_counter && job->gang_submit))
+	    (job->job_run_counter && job->gang_submit) ||
+	    amdgpu_device_is_wedged(adev))
 		dma_fence_set_error(finished, -ECANCELED);
 
 	if (finished->error < 0) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 14a72a406d37..2393cad36ac0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -781,6 +781,9 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		return copy_to_user(out, &count, min(size, 4u)) ? -EFAULT : 0;
 	}
 	case AMDGPU_INFO_TIMESTAMP: {
+		if (amdgpu_device_is_wedged(adev))
+			return -ENODEV;
+
 		PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, pm);
 
 		ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
@@ -913,6 +916,9 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		if (info->read_mmr_reg.count > 128)
 			return -EINVAL;
 
+		if (amdgpu_device_is_wedged(adev))
+			return -ENODEV;
+
 		PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, pm);
 
 		ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
@@ -953,6 +959,9 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		uint64_t vm_size;
 		uint32_t pcie_gen_mask, pcie_width_mask;
 
+		if (amdgpu_device_is_wedged(adev))
+			return -ENODEV;
+
 		/* The clock limits are only available while the SMU is up. */
 		PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, pm);
 
@@ -1187,6 +1196,9 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		}
 	}
 	case AMDGPU_INFO_SENSOR: {
+		if (amdgpu_device_is_wedged(adev))
+			return -ENODEV;
+
 		PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, pm);
 
 		ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 4b1b42fee6b4..6ffd9e45e3ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1255,12 +1255,12 @@ void amdgpu_virt_init(struct amdgpu_device *adev)
 
 static bool amdgpu_virt_access_debugfs_is_mmio(struct amdgpu_device *adev)
 {
-	return amdgpu_sriov_is_debug(adev) ? true : false;
+	return amdgpu_device_is_wedged(adev) ? true : false;
 }
 
 static bool amdgpu_virt_access_debugfs_is_kiq(struct amdgpu_device *adev)
 {
-	return amdgpu_sriov_is_normal(adev) ? true : false;
+	return !amdgpu_device_is_wedged(adev) ? true : false;
 }
 
 int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index a2c1aa838737..665d483de731 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -315,7 +315,6 @@ struct amdgpu_virt {
 	uint32_t gim_feature;
 	uint32_t reg_access_mode;
 	int req_init_data_ver;
-	bool tdr_debug;
 	struct amdgpu_virt_ras_err_handler_data *virt_eh_data;
 	bool ras_init_done;
 	uint32_t reg_access;
@@ -446,10 +445,6 @@ static inline bool is_virtual_machine(void)
 	((adev)->virt.gim_feature & AMDGIM_FEATURE_PP_ONE_VF)
 #define amdgpu_sriov_multi_vf_mode(adev) \
 	(amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-#define amdgpu_sriov_is_debug(adev) \
-	((!amdgpu_in_reset(adev)) && adev->virt.tdr_debug)
-#define amdgpu_sriov_is_normal(adev) \
-	((!amdgpu_in_reset(adev)) && (!adev->virt.tdr_debug))
 #define amdgpu_sriov_is_av1_support(adev) \
 	((adev)->virt.gim_feature & AMDGIM_FEATURE_AV1_SUPPORT)
 #define amdgpu_sriov_is_vcn_rb_decouple(adev) \
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index ac18c2be6ecb..b95dddeaccc5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -2424,8 +2424,12 @@ struct kfd_process_device *kfd_process_device_data_by_id(struct kfd_process *p,
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

