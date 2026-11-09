Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3310606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 17:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=b6D8iuHk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E96A10F469;
	Mon,  9 Nov 2026 17:15:27 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011038.outbound.protection.outlook.com [52.101.57.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07C7F10F469;
 Mon,  9 Nov 2026 17:15:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DjCPedAUvAuJFGo6gLN+Pn3OlK4OM2kEeEB+PlehvnjgrLQ4ufS0vaNsqfiew4DtyVZay8/ef3/P5+6wRtebYzwEuGvJk6PzZ2QNslitZ328kYK2oVptKTAqhGj5I7CT883VxyWrIQ3FJ/mBjVfvvvy8Lg7bA7lYIPYk1C3D9lwKZGs1HmDtm12OSIH9w7pWernxDmTnE0mjcsVBkygFhrb8BbIUEjJ7jBzz4Y/HDc0V38X7j/TEMGpuFtZkt51Ak0yT8xBzcS2qA1vMqWAhTXrAqZ4JOybGPG5YdW2Sfmed9wVrD8fXIIBi6UHMFo7vNuwUSfI++fgBRq9z+dyJCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGVsmAf4tIhUAAN+U3h7SYpwAwz+W70ZrjR+g3DwYdA=;
 b=vx6JKmVJIz9QKWaBHWmuakx3HT8mKFbs1iXIdncNFK+076qwmsnSoCRUAMrX10j/Vv9HDsfREhxHkzljuHLdQ2EN+EB7jc9cifMBj4kAK5X+RhbrnRkhaxoAx6xX8FoYTpwxn8S66xTtZNFUcTscfdUFOGBYVwUD3iu78qxoem8hBbWPICnRs+jlrgQm8m+uoGegPfKy0z/nBFM0RhVxD5BIoF9+T05OVYJvoO5Sam8tAY6C6APdN7o/Bg6ixbpu+ebI6s8hPR7J6lH5DEqstaTbvGjh4YX/aPFKYFqjLMnQf38SiHLRu31ZneMixLTa/a/oeap9QD/t6SipKiS1Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGVsmAf4tIhUAAN+U3h7SYpwAwz+W70ZrjR+g3DwYdA=;
 b=b6D8iuHkfmONHlMqUMGiTahD58CrjC5uV/pmRjMdpi2UkvRpYjCVa1EmjJOrerl4URPsMD5gF6zU2dow974CpQR8Mt/exVWE8PQ5YWZ25NOpgTAGA0aq1zjE6ou6hGV1AIu8CdNQhCYY60DAtAYimQtFhWzeHwgG1Nlg5j+1H7g=
Received: from SJ0PR05CA0169.namprd05.prod.outlook.com (2603:10b6:a03:339::24)
 by DS7PR12MB5885.namprd12.prod.outlook.com (2603:10b6:8:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 9 Nov
 2026 17:15:13 +0000
Received: from CO1PEPF0001885F.namprd02.prod.outlook.com
 (2603:10b6:a03:339:cafe::4) by SJ0PR05CA0169.outlook.office365.com
 (2603:10b6:a03:339::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Mon, 9
 Nov 2026 17:15:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF0001885F.mail.protection.outlook.com (10.167.249.248) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 17:15:12 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Mon, 9 Nov 2026 11:15:10 -0600
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Felix Kuehling
 <Felix.Kuehling@amd.com>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 4/6] drm/amdgpu: handle gpu_recovery per device
Date: Mon, 9 Nov 2026 18:13:23 +0100
Message-ID: <20261109171333.4329-4-pierre-eric.pelloux-prayer@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF0001885F:EE_|DS7PR12MB5885:EE_
X-MS-Office365-Filtering-Correlation-Id: 84900cd1-b655-45e0-0f49-08df3e8503ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|261022075727099003|261026140227099003|261021123027099003|261026121527099003|11063799006|56012099006|261021121427099003|261028144727099003|261009221727099003|261009223327099003|261009220027099003|261009223027099003|261009221227099003|261022105027099003|10067099003|22082099003|6133799003|261102123227099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: PvC/TdasD1/I1vOcYROnVx3CjsMfaxy9dwYoKrBsqwa4A6yfqSSuKW8ypyPZUGs3d3aZPcXQUiTyTOdAnmgvvaIg4Az4zOsEfOL0GvI6dLT7Z34gzMvpUnO8lblvK6oDlM2JnikGx5KyA8IOzIdQc+Pq19m5Xf5s84U43Ni4GN5dbW7cb4fgwxcvHfZNNFgUqxdpdT/iMXIMavJ7Br3sX5bE0uw3+S2M2R13zxpN1qbVhPy6CElWUT9+qLdX25eE+Y4uzKxFmF/vu7rISGy6PuzHyr1voiQNGlXhbf1yO+zv+jMF6DPTM1OQYZjo4hFWAXEMvM4cWefm0qvkEn57ratJK3aORsOQ7EbBiVwAPycTQJzX3TBDy/x1euAkM2rb9REWKXEZ/sPQztKKscSw13JoBRy8vP3ldgdk33LVThHBclfIlmdAn2Le7k7zsZABbKkgzC0/jNva+mS3YoynFimr01k8L+Y2W8v9gDq6sQe0m18pdqxShCCabaGe9LSIvOUzHyuHFgB5eO5KPFzeYtdGOtVLXm8SNktfeDUqoaBRVojmY3mgH8YN6Dd6mEQP1e7NZWW70d/YpXkD1fl9TgktdJkhQmpV1f4OoKrA9W1HGBsisoqjYlFxJ4O8SAN/UqOGVXoWbqemN2duNFHBbspM1FdbYBKXN07q7LOwSZaL/Sy+7i9C/wqLuFSYF1D9ZxeT5O2UltnBb1O+6zUaLg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(261022075727099003)(261026140227099003)(261021123027099003)(261026121527099003)(11063799006)(56012099006)(261021121427099003)(261028144727099003)(261009221727099003)(261009223327099003)(261009220027099003)(261009223027099003)(261009221227099003)(261022105027099003)(10067099003)(22082099003)(6133799003)(261102123227099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4TLA8uNzVsbXJEiKlR6iSATtASJfz51/K+RS9VZQbWwM1yxuarDKJ9Y3u1H+nvbmviA+ciQ/nThedgFlIRY9dG8UWi1m2B8LLtGIvepdl17YTV8FponwHu2/wWe0jf6uMYaZ5IRn226snzKvSLFwBoI8kpJKaleP5B2Mf+lOeM2nJ+sDmLxLhAjJOzz6OQ69afxTzk/pwIeibCzQdsNfa7CRSM4LIrQ48d/n4NIQ4djsD/K8P/SJ56fD1BkEOW3wg1MJBkrkmQtcwxXTJZXhmxCGJm7i8ej+1hzFDNSM0qJG8omYPO+1Ek3eSXSeRE6wxT+Po8vFdClMuTiVGH1F2q/O64RVfUITcLc9wS8IjXROBV31zVFVc0zkHJg3n9126diRRvwwp2F1wcf1H+64KuEvreKp40+k6TDUhHYgWOr+g8UKc4j+eMierlF+QrAc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 17:15:12.6494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84900cd1-b655-45e0-0f49-08df3e8503ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF0001885F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5885
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

Instead of having a module wide parameter, store gpu_recovery
in amdgpu_device. Its initial value is based on the boot param
and it can be overridden by writing to the existing
amdgpu_gpu_recover debugfs file, so a single device can have
auto-recovery disabled without affecting every other GPU in the
system.

amdgpu_device_should_recover_gpu() now only consider this param.

Assisted-by: LLM
Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 11 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 92 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c     | 21 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c       |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  4 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c            |  2 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  6 +-
 10 files changed, 81 insertions(+), 71 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 5a32b54b1e9b..a486ac746a5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -982,6 +982,9 @@ struct amdgpu_device {
 
 	struct amdgpu_uma_carveout_info uma_info;
 
+	/* Per device gpu_recovery setting. 0 means disabled. */
+	unsigned int gpu_recovery;
+
 	/* KFD
 	 * Must be last --ends in a flexible-array member.
 	 */
@@ -1195,7 +1198,6 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 
 /* Common functions */
 bool amdgpu_device_has_job_running(struct amdgpu_device *adev);
-bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev);
 int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			      struct amdgpu_job *job,
 			      struct amdgpu_reset_context *reset_context);
@@ -1323,9 +1325,14 @@ int amdgpu_device_set_cg_state(struct amdgpu_device *adev,
 int amdgpu_device_set_pg_state(struct amdgpu_device *adev,
 			       enum amd_powergating_state state);
 
+static inline bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
+{
+	return adev->gpu_recovery != 0;
+}
+
 static inline bool amdgpu_device_has_timeouts_enabled(struct amdgpu_device *adev)
 {
-	return amdgpu_gpu_recovery != 0 &&
+	return amdgpu_device_should_recover_gpu(adev) &&
 		adev->gfx_timeout != MAX_SCHEDULE_TIMEOUT &&
 		adev->compute_timeout != MAX_SCHEDULE_TIMEOUT &&
 		adev->sdma_timeout != MAX_SCHEDULE_TIMEOUT &&
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 730e9e93d078..a812551b353f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3762,6 +3762,45 @@ amdgpu_device_should_register_switcheroo(struct amdgpu_device *adev, bool px)
 		       apple_gmux_detect(NULL, NULL)));
 }
 
+static void amdgpu_device_init_gpu_recovery(struct amdgpu_device *adev)
+{
+	adev->gpu_recovery = 0;
+
+	if (amdgpu_gpu_recovery == 0)
+		return;
+
+	/* Skip soft reset check in fatal error mode */
+	if (!amdgpu_ras_is_poison_mode_supported(adev) ||
+	    amdgpu_sriov_vf(adev)) {
+		adev->gpu_recovery = adev->gpu_recovery > 0 ?
+			adev->gpu_recovery :-1;
+	} else if (amdgpu_gpu_recovery == -1) {
+		switch (adev->asic_type) {
+#ifdef CONFIG_DRM_AMDGPU_SI
+		case CHIP_VERDE:
+		case CHIP_TAHITI:
+		case CHIP_PITCAIRN:
+		case CHIP_OLAND:
+		case CHIP_HAINAN:
+#endif
+#ifdef CONFIG_DRM_AMDGPU_CIK
+		case CHIP_KAVERI:
+		case CHIP_KABINI:
+		case CHIP_MULLINS:
+#endif
+		case CHIP_CARRIZO:
+		case CHIP_STONEY:
+		case CHIP_CYAN_SKILLFISH:
+			return;
+		default:
+			adev->gpu_recovery = 1;
+			break;
+		}
+	} else {
+		adev->gpu_recovery = amdgpu_gpu_recovery;
+	}
+}
+
 /**
  * amdgpu_device_init - initialize the driver
  *
@@ -4109,6 +4148,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		}
 	}
 
+	amdgpu_device_init_gpu_recovery(adev);
+
 fence_driver_init:
 	/* Fence driver */
 	r = amdgpu_fence_driver_sw_init(adev);
@@ -4894,57 +4935,6 @@ bool amdgpu_device_has_job_running(struct amdgpu_device *adev)
 	return false;
 }
 
-/**
- * amdgpu_device_should_recover_gpu - check if we should try GPU recovery
- *
- * @adev: amdgpu_device pointer
- *
- * Check amdgpu_gpu_recovery and SRIOV status to see if we should try to recover
- * a hung GPU.
- */
-bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
-{
-
-	if (amdgpu_gpu_recovery == 0)
-		goto disabled;
-
-	/* Skip soft reset check in fatal error mode */
-	if (!amdgpu_ras_is_poison_mode_supported(adev))
-		return true;
-
-	if (amdgpu_sriov_vf(adev))
-		return true;
-
-	if (amdgpu_gpu_recovery == -1) {
-		switch (adev->asic_type) {
-#ifdef CONFIG_DRM_AMDGPU_SI
-		case CHIP_VERDE:
-		case CHIP_TAHITI:
-		case CHIP_PITCAIRN:
-		case CHIP_OLAND:
-		case CHIP_HAINAN:
-#endif
-#ifdef CONFIG_DRM_AMDGPU_CIK
-		case CHIP_KAVERI:
-		case CHIP_KABINI:
-		case CHIP_MULLINS:
-#endif
-		case CHIP_CARRIZO:
-		case CHIP_STONEY:
-		case CHIP_CYAN_SKILLFISH:
-			goto disabled;
-		default:
-			break;
-		}
-	}
-
-	return true;
-
-disabled:
-		dev_info(adev->dev, "GPU recovery disabled.\n");
-		return false;
-}
-
 int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
 {
 	u32 i;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index bff2d38f3571..a8e23f4e8113 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -980,9 +980,13 @@ static int amdgpu_debugfs_fence_info_show(struct seq_file *m, void *unused)
 }
 
 /*
- * amdgpu_debugfs_gpu_recover - manually trigger a gpu reset & recover
+ * amdgpu_debugfs_gpu_recover - manually trigger a gpu reset & recover,
+ * and control whether this device is allowed to auto-recover from a hang.
  *
- * Manually trigger a gpu reset at the next fence wait.
+ * Read triggers a gpu reset at the next fence wait.
+ *
+ * Write 0/1 to disable/enable auto GPU recovery for this device
+ * (equivalent to amdgpu.gpu_recovery=0, but scoped to this device only).
  */
 static int gpu_recover_get(void *data, u64 *val)
 {
@@ -1006,8 +1010,17 @@ static int gpu_recover_get(void *data, u64 *val)
 	return 0;
 }
 
+static int gpu_recover_set(void *data, u64 val)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)data;
+
+	adev->gpu_recovery = !!val;
+
+	return 0;
+}
+
 DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_fence_info);
-DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_gpu_recover_fops, gpu_recover_get, NULL,
+DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_gpu_recover_fops, gpu_recover_get, gpu_recover_set,
 			 "%lld\n");
 
 static void amdgpu_debugfs_reset_work(struct work_struct *work)
@@ -1042,7 +1055,7 @@ void amdgpu_debugfs_fence_init(struct amdgpu_device *adev)
 	if (!amdgpu_sriov_vf(adev)) {
 
 		INIT_WORK(&adev->reset_work, amdgpu_debugfs_reset_work);
-		debugfs_create_file("amdgpu_gpu_recover", 0444, root, adev,
+		debugfs_create_file("amdgpu_gpu_recover", 0644, root, adev,
 				    &amdgpu_debugfs_gpu_recover_fops);
 	}
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 0ae6e990c310..28f9048f806c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2299,7 +2299,7 @@ static int amdgpu_gfx_sysfs_reset_mask_init(struct amdgpu_device *adev)
 {
 	int r = 0;
 
-	if (!amdgpu_gpu_recovery)
+	if (!amdgpu_device_should_recover_gpu(adev))
 		return r;
 
 	if (adev->gfx.num_gfx_rings) {
@@ -2319,7 +2319,7 @@ static int amdgpu_gfx_sysfs_reset_mask_init(struct amdgpu_device *adev)
 
 static void amdgpu_gfx_sysfs_reset_mask_fini(struct amdgpu_device *adev)
 {
-	if (!amdgpu_gpu_recovery)
+	if (!amdgpu_device_should_recover_gpu(adev))
 		return;
 
 	if (adev->gfx.num_gfx_rings)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 4d363bcfb6a5..16391cc2b9a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -111,7 +111,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	if (!amdgpu_sriov_vf(adev))
 		amdgpu_job_core_dump(adev, job);
 
-	if (amdgpu_gpu_recovery &&
+	if (amdgpu_device_should_recover_gpu(adev) &&
 	    amdgpu_ring_is_reset_type_supported(ring, AMDGPU_RESET_TYPE_SOFT_RECOVERY) &&
 	    amdgpu_ring_soft_recovery(ring, job->vmid, s_job->s_fence->parent)) {
 		dev_err(adev->dev, "ring %s timeout, but soft recovered\n",
@@ -130,7 +130,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	}
 
 	/* attempt a per ring reset */
-	if (amdgpu_gpu_recovery &&
+	if (amdgpu_device_should_recover_gpu(adev) &&
 	    amdgpu_ring_is_reset_type_supported(ring, AMDGPU_RESET_TYPE_PER_QUEUE) &&
 	    ring->funcs->reset) {
 		dev_err(adev->dev, "Starting %s ring reset\n",
@@ -152,7 +152,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	}
 
 	/* Attempt an IP block soft reset, if supported. */
-	if (amdgpu_gpu_recovery &&
+	if (amdgpu_device_should_recover_gpu(adev) &&
 	    amdgpu_ring_is_reset_type_supported(ring, AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET)) {
 		r = amdgpu_device_ip_soft_reset(ring, job->hw_fence);
 		if (!r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 87ecbd429f95..8da7c8e91e25 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -454,7 +454,7 @@ int amdgpu_sdma_sysfs_reset_mask_init(struct amdgpu_device *adev)
 {
 	int r = 0;
 
-	if (!amdgpu_gpu_recovery)
+	if (!amdgpu_device_should_recover_gpu(adev))
 		return r;
 
 	if (adev->sdma.num_instances) {
@@ -468,7 +468,7 @@ int amdgpu_sdma_sysfs_reset_mask_init(struct amdgpu_device *adev)
 
 void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev)
 {
-	if (!amdgpu_gpu_recovery)
+	if (!amdgpu_device_should_recover_gpu(adev))
 		return;
 
 	if (adev->dev->kobj.sd) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 1a2aa85c504e..64fb04ff2098 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -101,7 +101,7 @@ static void amdgpu_userq_mgr_reset_work(struct work_struct *work)
 	 * If GPU recovery feature is disabled system-wide,
 	 * skip all reset detection logic
 	 */
-	if (!amdgpu_gpu_recovery)
+	if (!amdgpu_device_should_recover_gpu(adev))
 		return;
 
 	memset(&reset_context, 0, sizeof(reset_context));
@@ -137,7 +137,7 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 	 * If GPU recovery feature is disabled system-wide,
 	 * skip all reset detection logic
 	 */
-	if (!amdgpu_gpu_recovery)
+	if (!amdgpu_device_should_recover_gpu(adev))
 		return;
 
 	if (queue->vm && queue->vm->pasid) {
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
index c3293e5a658c..907f18b195ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
@@ -550,7 +550,7 @@ static int xgpu_vi_mailbox_rcv_irq(struct amdgpu_device *adev,
 	int r;
 
 	/* trigger gpu-reset by hypervisor only if TDR disabled */
-	if (!amdgpu_gpu_recovery) {
+	if (!amdgpu_device_should_recover_gpu(adev)) {
 		/* see what event we get */
 		r = xgpu_vi_mailbox_rcv_msg(adev, IDH_FLR_NOTIFICATION);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index b2024d05aa5f..b35622e65981 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -570,7 +570,7 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
 		 */
 		if (adev->pcie_reset_ctx.in_link_reset)
 			return AMD_RESET_METHOD_LINK;
-		if (amdgpu_gpu_recovery == 4 || amdgpu_gpu_recovery == 5)
+		if (adev->gpu_recovery == 4 || adev->gpu_recovery == 5)
 			return AMD_RESET_METHOD_MODE2;
 		else if (!(adev->flags & AMD_IS_APU))
 			return AMD_RESET_METHOD_MODE1;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index ce67e56efa8c..18fa7c8cc210 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -336,7 +336,7 @@ static int remove_queue_mes_on_reset_option(struct device_queue_manager *dqm, st
 
 	/* remove_hw_queue failure indicates a queue hang. reset the queue */
 	r = reset_queues_mes(dqm, q);
-	if (r && amdgpu_gpu_recovery) {
+	if (r && amdgpu_device_should_recover_gpu(adev)) {
 		dev_err(adev->dev, "failed to remove queue from MES, doorbell=0x%x\n",
 			q->properties.doorbell_off);
 		dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU reset\n");
@@ -494,7 +494,7 @@ static int reset_queues_mes(struct device_queue_manager *dqm, struct queue *q)
 	if (WARN_ON(dqm->detect_hang_count > 0))
 		return 0;
 
-	if (!amdgpu_gpu_recovery) {
+	if (!amdgpu_device_should_recover_gpu(adev)) {
 		r = -ENOTRECOVERABLE;
 		goto fail;
 	}
@@ -2806,7 +2806,7 @@ static int reset_queues_on_hws_hang(struct device_queue_manager *dqm, bool is_sd
 
 		return -EPERM;
 	}
-	if (!amdgpu_gpu_recovery)
+	if (!amdgpu_device_should_recover_gpu(adev))
 		return -ENOTRECOVERABLE;
 
 	return is_sdma ? reset_hung_queues_sdma(dqm) : reset_hung_queues(dqm);
-- 
2.43.0

