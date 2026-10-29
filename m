Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF3B606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Ska39Kk4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C638610E17A;
	Thu, 29 Oct 2026 15:21:53 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013016.outbound.protection.outlook.com
 [40.93.201.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E93110E17A;
 Thu, 29 Oct 2026 15:21:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQ+mAaIF7tR2qhLmT1Rz5/oGW741ZqeVAaUgZJOBu95PFJdjGH6yscgRAdIIYQaSC+8k1g2Lzpz2xBFu8z1weC7WZlygEUGY6ubQTDulLOjKHe4iWf4ZJkkgkOdfGkES1uqFse+jRui7MComjVPp9/hQgU0YEakMHhY7hpKSZmtW18WNjUcTf41IZAyVvAElNu4jybxVQeZUWGD/maqHxp44oMRKkEexXiSyxUm+LX8J6qmgZu9ExR7e5/QizcSaVllNJYMaSjfFuWX/1N8qaPasSO5Tz9ODoWTP+1qLlyp9KyV9t7xRVBI+/oEIrb0PSt6cMpulcdfvYAMCIu7RcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5qE6TRuHz/u1s+UcxpXs9MW7ypeH7ShXkwAjQP66gY=;
 b=eWi5PMoEMzGgM9xGrczgXmfnz3QDp0jis4gvGH8OonnZsh5o/xXCBbkEqX9dFcH49l/Vay9hMdojjSY+cNlVX9DcD/kNHOmEFkAB/Q5/VBqbot8SqnhyM0BRz6hltD5uIy1pULTjKb9c3eW/e9WNnHcoLLYfxQtBorcNMJ8o2hnEvLzBoceUrRNKr+XLdHd5UgCrdP2/D3XxLb6qoDb4z/V0gLzsOQTMjgV8ERnMBdQlr1eekAQ9xG68edPTj2LcnepXVVyvFchcaEKVC+bsKmti21EIeNKOffTbEMoxqBxmeO92jc3/1hQMr+fEmCG3NYMtbiqMk7NBbf3yoD/Lag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5qE6TRuHz/u1s+UcxpXs9MW7ypeH7ShXkwAjQP66gY=;
 b=Ska39Kk4Y+BViuR+0jIk7l+NuBsvjXWxORos1zJA8qO8D4Hix0TVVLjyYG+AajCJLMv/EBriu+Z0s3SKvbq0eatfYBUnc8qJwTt+kRwwcrK/MWefIAoki2Psq0qvQreUsdKDcQD79nQMGUYFKcHzViOPOE3Z938KEpS0NZMI0B0=
Received: from SJ0PR05CA0030.namprd05.prod.outlook.com (2603:10b6:a03:33b::35)
 by SN7PR12MB6931.namprd12.prod.outlook.com (2603:10b6:806:261::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 15:21:41 +0000
Received: from BY1PEPF00026956.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::8c) by SJ0PR05CA0030.outlook.office365.com
 (2603:10b6:a03:33b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.4 via Frontend Transport; Thu, 29
 Oct 2026 15:21:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF00026956.mail.protection.outlook.com (10.167.244.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 15:21:41 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Thu, 29 Oct 2026 10:21:39 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Felix Kuehling
 <Felix.Kuehling@amd.com>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 4/5] drm/amdgpu: add wedge event implementation
Date: Thu, 29 Oct 2026 16:19:51 +0100
Message-ID: <20261029152000.22001-4-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029152000.22001-1-pierre-eric.pelloux-prayer@amd.com>
References: <20261029152000.22001-1-pierre-eric.pelloux-prayer@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026956:EE_|SN7PR12MB6931:EE_
X-MS-Office365-Filtering-Correlation-Id: dbb93e31-7c94-42f0-616e-08df35d055cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|260925022911599003|260925021911599003|260925021311599003|11063799006|56012099006|261009223027099003|261009221227099003|261026121527099003|261026140227099003|261028144727099003|261021121427099003|261022075727099003|261022105027099003|261021123027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 2au5ktVxFleNPq0ZkMce7xCcI+8U0G/jmXHqVOAzBSRtGpYElB/13CklzqxWZ0TYCI84AT8yITTXUKHoLvPpikZNEZQZ/9dlOuQNsuBrIOE3lzGKqLBOBRA/sOmJunDNrdKhcr2t8ZeRAut+lc4BOOOtzCAfqNEeaveY2XhVobWgoE22shLx8Txr3UrXbQMQTGDQyvUMhVA8AyMzyvvyDe7I3l2PSiOokyvi5Vkf586yfX/weQwRbd76KdQmAyev4WfhgC7BKgnCuM6ZmzTUcLDbyN50nPsbCedRp/m7u8aa4uIIF9dWlBsSWL07jDsANklPQRQFwzPNFoQ6eSr98af/aiCtMoVFe+B7C2mNnWgiXxWkoc7mMsT72/EgbsAybDpai6Ccl6eE6ir+QjVFx3L5GPECWCSn2dg8eiGEurCWsi2eEIZqJZpPR5+x6s3TfrMr3/O+49V2PZTAXl5QsFKOBfW3JGU92lPPvc6q5KS+WTvK9R+W3w0BcJb8RdXnOOW/y6wWpkX0iA7Kj8AaFnWRumF/1d21CkwNmAOmQF6j/qknBmENgr5j0FMxPhUQHHzzyxe3oWxDy4md1lOYHnk/bFhf2yrHKkg/kZWtzgRKQUj/K31EnGr1yACPSKXtaPbvrQsi4oJT7gBu6VVV+NRxCsMq1h1kV+mYz0Yelt0xaGH2TqGc0Hl62BjyO/jhFHWc/l5GVdMa/ApFkXyBzQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(260925022911599003)(260925021911599003)(260925021311599003)(11063799006)(56012099006)(261009223027099003)(261009221227099003)(261026121527099003)(261026140227099003)(261028144727099003)(261021121427099003)(261022075727099003)(261022105027099003)(261021123027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lYiTNA+7eRB355C8Br3Q6mKS520FwAQR0BORC/HZ4FlfeQDL9HbsKriC2cOolgokd3S6QByol3AdLTRQ1cHNjRxpn42iqhVN5xukfrBBiHYRIRIHeQu9FWg+SnLmdZA1vAT7su/3H3R+WLFpn5vjJHKplW+pHca8jDnLYrZ8UH2eqtj8JrxpcvtVkHiUEmuHmLd26uyo5y9B1p3Dlhy5elMhbLFql7d28GVBSw4hd0x8BwJcdrR1mVC6jcVvnpe33mK1BG5prpGSC2XLWPP/Ske1pXsiEFGMeAU+jLD/bnvCzpBdTeY+rDu/euSOb/PgcO2LLn0Qabwd4D1enPwuRLtz7MEctwkSlaLren2tFJ9VWWWgFiAvXbfZYxx1IV43TSdh8nXuj/LNgVogjjD6Q4+F8NOWHr0aviVmbFNmqbP6E6X5cvVHk0aT5vARxZ7M
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 15:21:41.7488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb93e31-7c94-42f0-616e-08df35d055cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF00026956.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6931
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c     |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  8 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    |  8 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 34 ++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 12 ++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c   |  6 +++-
 8 files changed, 83 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 34bbb30b6f0c..cd4959486c94 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -989,6 +989,13 @@ struct amdgpu_device {
 	 */
 	bool gpu_recovery_enabled;
 
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
index ec2514079919..641b7fe24951 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4110,6 +4110,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	}
 
 	adev->gpu_recovery_enabled = true;
+	atomic_set(&adev->wedge_status, 0);
 
 fence_driver_init:
 	/* Fence driver */
@@ -4362,6 +4363,9 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 		amdgpu_sync_free(&adev->isolation[i].prev);
 	}
 
+	if (atomic_xchg(&adev->wedge_status, 0))
+		pm_runtime_put_autosuspend(adev->dev);
+
 	amdgpu_reset_fini(adev);
 
 	/* free i2c buses */
@@ -5155,6 +5159,10 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
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
index fb60a99f43c1..617d4eec4e26 100644
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
@@ -961,6 +964,11 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 		abo = NULL;
 	}
 
+	if (amdgpu_device_is_wedged(adev)) {
+		r = -ENODEV;
+		goto error_put_gobj;
+	}
+
 	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, lock);
 
 	r = PM_RUNTIME_ACQUIRE_ERR(&lock);
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
index 0b8d0a79dd45..f72c9c690c3b 100644
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
+				/* This ref will be dropped in amdgpu_device_reinit_after_reset. */
+				pm_runtime_get_noresume(adev->dev);
+
+				pci_clear_master(adev->pdev);
+
+				drm_dev_wedged_event(&adev->ddev, DRM_WEDGE_RECOVERY_REBIND, info);
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
@@ -439,7 +466,8 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
 
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

