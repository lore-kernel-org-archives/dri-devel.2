Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF93AC5DF67
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 17:07:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA1ED10E516;
	Thu, 13 Aug 2026 17:07:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B2GVYOj1";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011001.outbound.protection.outlook.com [52.101.57.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F29E10E4F0;
 Thu, 13 Aug 2026 17:07:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5ExBBU5/gWcUS3VrkvK7g0C3EI6krokPz5fGYrm3n59cpiqawlPRTO30JNpZBmWeEESagcJSSFy1zD9gozY2Tdv0QQDk5knXayP4dzkmKJfbJUVj8ZZtoT1LUywD40l4eWYGdV9f4kSyxNRdEGp7oIo1+0XUEpUkkZXFMqQ8iCCcR6SaJrOZzOpw8wqNJ/hTldl2pyecTYBufbCmNChL2vqMG2iDpwnVfSFd3wZ7UmIZsFTdt9D+CVjqw1wAAfkyJXJg/keMKoj6MF8Uf2zXtgYml7N0EcU5T3E9+Ew4U5TrbCqEvTGe8iG5rIX5fV0C92KroQiu/oTTqh5bqCZNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lL82t2OLM/wn2Q+yxtfQ91Svwb3rtAxX+o7utqCsHCI=;
 b=tJnJqRU+P5AkgBW6Z+1DclN63wVbW4korK/v1BPz3QndFq79YA7Ug0Mbi13o53g3mpcka3+H/Yty5B1zG4pOM6tt6D4CrME3zLCPOPrF9TmOw/lJFJOV2vTAl7hs4uvGAexHD8tbRnVjmx7WdupFZQk4GzUR3T0r61fCd/f9sSviHSE/N8Iq2hxnPl04iaCWlPURH8hnwCvz8amFZJ3o3pYDfkX5KRjPmeafU0LQwzFs9FsNk+sWZMS5e/WOA9aQ2afxpFdlM6JJ6vKOmILiYd/Yz7FbWC75NemDq1k1aWeMpClAgwtHEfC/AlEN/XL3CxDcU8cLUpE0Rba8LE87Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lL82t2OLM/wn2Q+yxtfQ91Svwb3rtAxX+o7utqCsHCI=;
 b=B2GVYOj15JA23EBbT8IcoaVxiue0HYuQF4hR9Xfz9vVnLspJxo69UE0WuEE8F7ITjSjJAblIXteMUsklba9ZKKjLMZSano8O0zqq9g3RVac3SdXjsiMcgLgSRjVJ1NLmkwjE4XS1rsOWgVSj7zo1V6Zaxy1nWz0FkKYY8+gz5t8=
Received: from SA1PR02CA0011.namprd02.prod.outlook.com (2603:10b6:806:2cf::28)
 by CYYPR12MB8937.namprd12.prod.outlook.com (2603:10b6:930:cb::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Thu, 13 Aug
 2026 17:07:42 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:2cf:cafe::47) by SA1PR02CA0011.outlook.office365.com
 (2603:10b6:806:2cf::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Thu,
 13 Aug 2026 17:07:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 17:07:42 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 12:07:40 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/5] drm/amdgpu: add gpu_recovery_allowed flag to
 amdgpu_device
Date: Thu, 13 Aug 2026 19:06:58 +0200
Message-ID: <20260813170705.15745-1-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|CYYPR12MB8937:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bce261c-de93-4ed6-bf2a-08def95d6346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|6133799003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: c/SLPKoz0PZfSV5GgfLV4AgNL2uKjc5DB9OaRYHalrIwtRTlsTI9tXr1IafH7Ny+G8pB3iOHufHtR3FVCFiNIzMrKxX1JC9Sc6NYDGjD3iiyUlcPgVpo+yFmn3SK9vy3LpnfUNF//VKkVBWnJtMOGVYbvgv1Mb38UmHfAurH+bBLVJqjAePW5KpLE6+mpV6XN8txygHk/PCZ6L9dUEoZEIibuC7q0/ucPdsxuG4S4n3nUsDOEjkoD+T0SBRzTMlApiwdniwWtbNtXqxa7XkcYfyyWXkmnf8Fa3Heal6P8KZj3jk49gc2id75owp1YG2P8NmLoHnPr/XbN+uuWiJIVSw99XPg5ixQXlJWY46N/qzAaY0mQ7Pt2+5i1YzIWakdePkcxX12jy2Yn45cf3Qg8bPFmn0HxBbs5CAvyT90D0Y70eAgC6aUWSxZfRe25N7b0C8XeY6TFXGqwRcWxV9L4dZuHaxAag7SDz1yHsuTkoRj3lOuWJRs6ZUas6cgFBLdMZTdSWyplYY2C+904z99Af1+PqtOyeoT+pF4mjCM+Y/elbaoeB2+U6Sql4Hoxil8CIRvV8fp4RGLHC0BSG2fx/NPm1lNYF2mZ9Y+G8dOsiahDs3dzbsMEi6SGVXOIoRL758VMl6qsuGwqGSH5dEvLiqjYewh4imlpWmFi1IGDlepchRBB3aBas9pqik8ZxfBlzwCBooDccwMeHdgvGa88g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8+jZvMdOQd6yakofJ0HfzQAxlZ8vR/9ek8Bhi4attSUHPEpn70B/X6dvJGXPGfs+H1NAmLmQkWGucKqezTwY/xTl2NQIR5Gqsens4BLk6WFvilWgKanVwiti96iX+IVIEsy0mTvPexhFkXLyRxVZ42aSa609LIPn/+j90yYi0G2VB/5+ERua+CnbsIjReDEVsi5DAWr4fbYiM077LYK2q/4W9M4Wkf1bZ3/+Q/U3Se2YNS7GLA0qPzHCMu4D6wh0WjNSIgaIqCQ+rF5S+kAaoSbVJATw6Ktl8Z7M3zQ8eqvClTQ60e9RzSEM9efS7YNU1BD6pOFPUlma6ZBqivLeh1tJXpb0Hz5PY8Zl5TGGNdgXnXph16Sibc0HmHvV9UTFKB69xZeAMoR0mHkt32/uezfHtuTuNjzY4sZIcmU6u48bkcTE3OheCBo0VQ799iGy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 17:07:42.5683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bce261c-de93-4ed6-bf2a-08def95d6346
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8937
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

Add a per-device boolean to control whether GPU recovery is attempted
on a hang, independently of the global amdgpu.gpu_recovery module
parameter. It defaults to true and is exposed as a write to the
existing amdgpu_gpu_recover debugfs file, so a single device can have
auto-recovery disabled without affecting every other GPU in the
system.

amdgpu_device_should_recover_gpu() now takes this flag into account.

Assisted-by: Claude:Sonnet 5
Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 21 +++++++++++++++++----
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 7974f9b7944f..21b33dc34edf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -957,6 +957,13 @@ struct amdgpu_device {
 
 	struct amdgpu_uma_carveout_info uma_info;
 
+	/* Whether this device is allowed to attempt GPU recovery on a hang.
+	 * Defaults to true; can be turned off per-device (e.g. via the
+	 * amdgpu_gpu_recover debugfs file) independently of the global
+	 * amdgpu.gpu_recovery module parameter.
+	 */
+	bool gpu_recovery_allowed;
+
 	/* KFD
 	 * Must be last --ends in a flexible-array member.
 	 */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 964efec0d335..5578d5f64937 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4034,6 +4034,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		}
 	}
 
+	adev->gpu_recovery_allowed = true;
+
 fence_driver_init:
 	/* Fence driver */
 	r = amdgpu_fence_driver_sw_init(adev);
@@ -4834,6 +4836,9 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
 	if (amdgpu_gpu_recovery == 0)
 		goto disabled;
 
+	if (!adev->gpu_recovery_allowed)
+		goto disabled;
+
 	/* Skip soft reset check in fatal error mode */
 	if (!amdgpu_ras_is_poison_mode_supported(adev))
 		return true;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 3043ad041bb4..707e69d8bb11 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -975,9 +975,13 @@ static int amdgpu_debugfs_fence_info_show(struct seq_file *m, void *unused)
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
@@ -1001,8 +1005,17 @@ static int gpu_recover_get(void *data, u64 *val)
 	return 0;
 }
 
+static int gpu_recover_set(void *data, u64 val)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)data;
+
+	adev->gpu_recovery_allowed = !!val;
+
+	return 0;
+}
+
 DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_fence_info);
-DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_gpu_recover_fops, gpu_recover_get, NULL,
+DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_gpu_recover_fops, gpu_recover_get, gpu_recover_set,
 			 "%lld\n");
 
 static void amdgpu_debugfs_reset_work(struct work_struct *work)
@@ -1037,7 +1050,7 @@ void amdgpu_debugfs_fence_init(struct amdgpu_device *adev)
 	if (!amdgpu_sriov_vf(adev)) {
 
 		INIT_WORK(&adev->reset_work, amdgpu_debugfs_reset_work);
-		debugfs_create_file("amdgpu_gpu_recover", 0444, root, adev,
+		debugfs_create_file("amdgpu_gpu_recover", 0644, root, adev,
 				    &amdgpu_debugfs_gpu_recover_fops);
 	}
 #endif
-- 
2.43.0

