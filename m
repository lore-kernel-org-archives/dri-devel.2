Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E94606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UfO5wdDu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 048691123BB;
	Thu, 29 Oct 2026 15:21:17 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011066.outbound.protection.outlook.com [52.101.57.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D10731123B6;
 Thu, 29 Oct 2026 15:21:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=waobYfPQdX/pnjFp3/baqtPB2o6cbtFtpnFDGpHQRI6sGG8K1vy8hEfnP5odBjLP9rQw9S1bI/PUkT4+uEG8GFzT8w0pnWJN15e/YdMfmOu5RJy4u0lP2fzdXRVIwpXzmUSghOBV3h76ITSGF0iSb/1fbWLNIdBRzQc0RHnEI7jqJIbDB6AkHEUpdkoPzfzCuvUWAF3OzNChg+OWuQ/ifyO40h9MFEtMrKFv3aUcFywWXQcJ+pRSOp8VbUY7DURxMiUV+267adMlBFCjC9alEnNxnbfnBVfM5mn1Ez8jLM209PMrYeVtSolNQnzivS0HOix0H/jUSMbE+N8VUpY9iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKO28l82T1TqDqEafOEgSZnpZGXZVkZYZUOoCl0CtQc=;
 b=l3sX/qdf5zTQ5bWZV0w+t4Vg7s259rDkRDJ/OJ0KOywlVnPVhDsHM9l6IFG2UQDRH0JncIpaNDnxeOY0AJgFDLRkVxFi3JjMUqRZWC8GfFm82jqP9raDmPRKDAeQzofRT4yq+c8O6xvv3yOTGk1DpZAj8rsVBVXw6iZv0AL8Zp1j6RsRbaZy3+XwLuFLhNdLnTMtabi2dUhljsDoB9tzwyalHGBgWLdURXitpUm+hpmYBuOLBXYoq6cAkpQMrcRHkwdHUFkE9f7vbHT7hoxwUu4oscif+zlqP4oT8V7i7HsNTz+nP4iR1r0Jp7EbYopJQYdbfbliYizf3s4RrEFKcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKO28l82T1TqDqEafOEgSZnpZGXZVkZYZUOoCl0CtQc=;
 b=UfO5wdDuSCOW79Mx/+cI2toMlMZ5RbTWa55SnfIPUGcCrsSExfNCysNmuqCTXtUk+F9awHZBIrINP/acT+Y0U4qh8pU86IOnWW8yKZgnlyVz5d5kkkBzux6RapB6gCiJdGqQpAeeC/g+dnx58zNAC+kfqg68Nw4uw/q0vk4lhXU=
Received: from CH0PR03CA0038.namprd03.prod.outlook.com (2603:10b6:610:b3::13)
 by MW4PR12MB7357.namprd12.prod.outlook.com (2603:10b6:303:219::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 15:21:02 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::3c) by CH0PR03CA0038.outlook.office365.com
 (2603:10b6:610:b3::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 29 Oct 2026 15:21:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 15:21:02 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Thu, 29 Oct 2026 10:20:59 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/5] drm/amdgpu: add gpu_recovery_enabled flag to
 amdgpu_device
Date: Thu, 29 Oct 2026 16:19:49 +0100
Message-ID: <20261029152000.22001-2-pierre-eric.pelloux-prayer@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|MW4PR12MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: 9044f92a-c24a-4d6f-5545-08df35d03e14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|6133799003|18002099003|22082099003|56012099006|11063799006|261026140227099003|261028144727099003|261022075727099003|261021123027099003|10067099003|261021121427099003|261022105027099003|261009223327099003|261009220027099003|261009221227099003|261009221727099003|261009223027099003|260925021911599003|260925021311599003|260925022911599003;
X-Microsoft-Antispam-Message-Info: 2PzZzqjApNVmIgAByYF+pGZ3OO7pA0Ketfugl/UjSCkMSqxKCXNSzR3I0LVQ1bcSO4OQeVD/d5HOkIJEfPYUWAFUJk6fviJkF92HHZUALw95/RcBejL2FwfgCQHsejClN/ALFIWlmwl8JXp/dWDbD4XQrTRgJAQ1QF2qVJfwxLJ8Ql5idHZkDUHvq5PMd5IabUvoSmu9JLEdT/MBvhjSnYxGZdPzo8yNjxokcCQfsnou6YFm0umyHU8X0jMDkhbS3M/3hcpsNG9j+hs4bJ7nTl3ubyWvqY2f8qUG8H++yspL1S7Mm03+AT/vnTxkXaBpxduxkVf/CHibuuuTpOC9+kJICnL9TPX1ifDgQ37UvBnUq6EEtyoxRGWE49H808IkLW1M5+aPipT/+ziI6d79iA17/KQtd2huYWVDFE5nWDlYm/tUH0arU4kw53r6dOvUSB1yHRF+Vlvcc83dcarTEZ+c+DKxGUZKvJ+OlSdENoc21q/yPdLjEDQabOP76NRsflu5LfYK/UP6S43lmKENvocliCeSlMxvSIOqTVcyIk5GedzybYhS0KslJVsIcRUEoSV5x+PtMd3yREdPqVCbCkfKcMxInETh/IaJ0wBZ/+AIgmb+sYZJK/WkjhzE3WCZlwTPzbQ0ga2NzrxPKLruCSR155INKreIG4TWuDIAOhx0DGquF9PieCBOruEXhwWKj4oiYKMUxfieUbuMSS5C6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(261026140227099003)(261028144727099003)(261022075727099003)(261021123027099003)(10067099003)(261021121427099003)(261022105027099003)(261009223327099003)(261009220027099003)(261009221227099003)(261009221727099003)(261009223027099003)(260925021911599003)(260925021311599003)(260925022911599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: u+9b6D+MWkE/LzDfTFX9YtGqTPlKQXmz6JxnHwMKIMxGFqxvXsti1klSyddpwJ+zkMvAcTy4zIDJwF6wTLpOoIlSnmHYfEjBOLNTvKNpPI7GMHlCAY+tpRviIp3wwkN2mqEUO0gRXahc8GQ0QyQMmCTjSd68UNGvT+m0Oo894pLKEee/mdYsj05KxDjRoZcm5WeDB/4nnrikVImn6fmFVrloJaj+boSivaqiPhdSZAl+WB4/LvlToY1GRLlf6MyIRfGTEdxHu9hNC3kB4N7JLF3PZL3bRExm8kcmI1T19ZoLd8TihiOYmIBpnHMyT8m/k3g0y4jzr3ZULKHv87RHJgESulxI5U2FXhKBF6YY2FS+24+IIlYrs9HtDJcPNBzMMedFxSfDxBhkLZL8YhBdE/VnDgCWLk6U72ZvXWVEsRBUDSBcgOlISRafG2C4iUoI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 15:21:02.0294 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9044f92a-c24a-4d6f-5545-08df35d03e14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7357
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

Add a per-device boolean to control whether GPU recovery is attempted
on a hang, independently of the global amdgpu.gpu_recovery module
parameter. It defaults to true and is exposed as a write to the
existing amdgpu_gpu_recover debugfs file, so a single device can have
auto-recovery disabled without affecting every other GPU in the
system.

amdgpu_device_should_recover_gpu() now takes this flag into account.

Assisted-by: LLM
Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 21 +++++++++++++++++----
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 5a32b54b1e9b..34bbb30b6f0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -982,6 +982,13 @@ struct amdgpu_device {
 
 	struct amdgpu_uma_carveout_info uma_info;
 
+	/* Whether this device can attempt GPU recovery on a hang.
+	 * Defaults to true; can be turned off per-device (e.g. via the
+	 * amdgpu_gpu_recover debugfs file) independently of the global
+	 * amdgpu.gpu_recovery module parameter.
+	 */
+	bool gpu_recovery_enabled;
+
 	/* KFD
 	 * Must be last --ends in a flexible-array member.
 	 */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5069042b5279..ec2514079919 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4109,6 +4109,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		}
 	}
 
+	adev->gpu_recovery_enabled = true;
+
 fence_driver_init:
 	/* Fence driver */
 	r = amdgpu_fence_driver_sw_init(adev);
@@ -4908,6 +4910,9 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
 	if (amdgpu_gpu_recovery == 0)
 		goto disabled;
 
+	if (!adev->gpu_recovery_enabled)
+		goto disabled;
+
 	/* Skip soft reset check in fatal error mode */
 	if (!amdgpu_ras_is_poison_mode_supported(adev))
 		return true;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index bff2d38f3571..c54ff34572b0 100644
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
+	adev->gpu_recovery_enabled = !!val;
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
-- 
2.43.0

