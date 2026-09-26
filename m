Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 102A2C9832A
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 01:36:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08BA310E2D2;
	Sat, 26 Sep 2026 01:36:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fiK8U8nH";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011019.outbound.protection.outlook.com [52.101.62.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9F0D10E2D2
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 01:35:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CEAju/btz5hFa4kwMPyNL+zGezlUsPEDrhNstCnJhOljN9y9H/i3B6amE7Vwa59/AJkoQUjZZeD+JeRyvSELX+sbc1/ZFu2UkBh7Wvh05nlBdKV+Lz08y4twvwBSqn4QSFzHoxbUDZgZrSuDiwOJKZzLTPwlsHAGhuxK5N2ad8K4T9w0y//DdqWsjiZUBumsEv3mpiGMVAH+RW1OFqOCkgrssKzsF0nMSfrFlR8TU3Y//O5+duS7XKhwntwyQHusrLdo4vL9AEa4lWufB2+hHtweGbayEsRyHrmVFk6rm52a7poT5e3pNFy4AASENSmviXPrcWC2RMWTVZYebGip8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTsL2vyItoGQwbfBIN2POwbRadTZqSSI/ljqd1ZI/s8=;
 b=yelu35/51OM8BbOv435zPI+/9Ef2uAFp87OW0LtEWhX+NUDTELjNRj/UgODUTnjILrCbPB9jvHgo6yzlOBE+/S8Lxv7zzRnwUAxbwsgvzmuKCSBJwi3mD1XDJCwbTJcPKWptAa4AGdTfqUKktoSvBbp+oRERM6T8Pi9TW9NegkzwTgriV0trg3LFSaW8W3lNdjR9TqshyWZOaLbfHn6+LWI7nAbF6rFajp1mVb0wC5VXh2y0ywkkv+IPLwFJOyA3k/C/9+KTSVjIJ/Bcm08Eq9JkpfYUxu3JgZauTqY+2id3h7BVZXTdLr7CBJCecL5gSYmz3Se1YM1AaUsyL475qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTsL2vyItoGQwbfBIN2POwbRadTZqSSI/ljqd1ZI/s8=;
 b=fiK8U8nH6/NUWGQ0IplJAVAufGFrQKYYiuqUGTtUW7JPB9ZyPArvO5zRxE2ztRjVlfZmLCBOOEajqHXreXLQwpaDTznmR5iqut29Q0iCWmRS7R515kCbk0xn5c8qU4cM9qv4lp2R3R7xxa9NhXRbVdBWWD5hsxgo6o2a8EljQzI=
Received: from CH0PR13CA0028.namprd13.prod.outlook.com (2603:10b6:610:b1::33)
 by SJ5PPF4D350AC80.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::993) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Sat, 26 Sep
 2026 01:35:33 +0000
Received: from BN5PEPF00046989.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::5) by CH0PR13CA0028.outlook.office365.com
 (2603:10b6:610:b1::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Sat,
 26 Sep 2026 01:35:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN5PEPF00046989.mail.protection.outlook.com (10.167.245.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Sat, 26 Sep 2026 01:35:32 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 20:35:31 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Fri, 25 Sep 2026 20:35:31 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V0 17/21] accel/amdxdna: Finalize runtime PM before acquiring
 dev_lock on removal
Date: Fri, 25 Sep 2026 18:34:44 -0700
Message-ID: <20260926013448.3840921-18-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260926013448.3840921-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20260926013448.3840921-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF00046989:EE_|SJ5PPF4D350AC80:EE_
X-MS-Office365-Filtering-Correlation-Id: 8857f232-46f3-4e31-1eac-08df1b6e74ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|4143699003|5023799004|11063799006|10067099003|56012099006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: DVxOH8bDDDtHcSmKtqKlqpdM13c09ZCwohlTiUSscydmJQvNNUfvIQL48LP5HSWffN3NOm2jZb/WrggYYtYc101nGfK3J/1iMO2bqTe/VBiH6XH89zwXjxsDKe1tHUsSUaLhDcxaSqUhWKMCfPubIyT7sARNg9+rf6BwJ3+XG3V146pGbvnp3gGBAH0QAxFgkcTVbtEyDi2us3NQwABcWHipeHlre5gn3cpDz4gZXdUamO9m4AOZ9aziMEDgx1l/b/3LgdwX3jdNl6lm/3DcMd94igkftXqxdQm1CXZMXhmd9z8+RsCCLWlpHzqU/qZAuPNskMi/AAT5BLSqfGS9PtNaI1PhdTvNdwM3bs7TFB9HyOTHiPFIG6syOXcVNLD+IhBOEoMabE+Ckb7k0kh/6I+KcGW1JW2crzJUqUN4Uyh/JiwzLr+F5akZhxBJAMO3CUqoDs/c06Rl8TW1Qx+80iMPmTIyRUVJdJOfR2SPn+YS7J91bO2g5e+IVMK2mtIbdCUnO5yQTbIYlCjKCPk3jU4TurZySBfYUA6ylKTX4+HV2VUs0vM+Q+CBUPKV6Eji8+Wzu9mHl+1zNVFSM3mbU9wwm9oDCa7X/6jEZvT1Y1oOLRutRfdOFzhzxkC3Uky8ZcL3cE5OXcZRLCxJkzsbOYBEm6TWgx5YSflLpqO9hYivaoQxGewthUUOf/4r/I87lAMiwGpbs4NyIxVCv4AgmQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(4143699003)(5023799004)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4qVPqbEE8rQR9/G970gsD5rdp9kOQcyVR6czJ3GOTiK/hjvUSF3Zd2IAO2y94VR79KL26TyAJ/wtFoonM1oIotQf6CowStlHl+ezz72W1HL0vfujb5vEWX9B4DQ8bu6we3T32sVOa3IwfD1htFt5lL2BoZecInZGryhCL0G6PGyY+N/8g6tVJgVNoTLzy7iZeiTs0stFTAkhfd1G/SgHlyFlqZfUeyti93w23R6iUamvMDkTyvRx6dGjsvx/yIhbQ/4Ndj9qXuqCegatBygOlkfDMV9+ShnwqCzidtjvtYv4hKlZdVRI9MfR7aBP7RE3JjSNQzDxWoHTyamgZpK8DuYu4IWZv+rCbIxiVXjfK+x1Zp/50jNhKPxvEpL+HvQ088M5DiDMyHe7RXE9dtrFuZqkEIM69EGuPZG8U/K7EvFB6hOoyHhkRFjawhh/oyMd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2026 01:35:32.7231 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8857f232-46f3-4e31-1eac-08df1b6e74ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN5PEPF00046989.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4D350AC80
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

When the device is runtime-suspended, pm_runtime_forbid() synchronously
resumes the device via rpm_resume(), which invokes
amdxdna_pm_runtime_resume(). Because amdxdna_pm_runtime_resume()
acquires dev_lock, calling amdxdna_pm_fini() inside ops->fini() while
holding dev_lock in amdxdna_remove() causes a deadlock.

Move amdxdna_pm_fini() out of ops->fini() and invoke it before acquiring
dev_lock in amdxdna_remove() as well as the probe failure unwind path.
Also call pm_runtime_dont_use_autosuspend() in amdxdna_pm_fini() to disable
autosuspend upon teardown.

In addition, move amdxdna_pm_init() out of aie2_init() into amdxdna_probe()
following hardware initialization. This makes runtime PM lifecycle
setup and teardown symmetrical and common across all device types.

Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/aie2_pci.c        | 2 --
 drivers/accel/amdxdna/amdxdna_pci_drv.c | 4 ++++
 drivers/accel/amdxdna/amdxdna_pm.c      | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
index b70af1923643..0d209b7b6484 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -623,7 +623,6 @@ static int aie2_init(struct amdxdna_dev *xdna)
 	release_firmware(fw);
 	aie2_msg_init(ndev);
 	amdxdna_vbnv_init(xdna);
-	amdxdna_pm_init(xdna);
 	return 0;
 
 stop_hw:
@@ -638,7 +637,6 @@ static int aie2_init(struct amdxdna_dev *xdna)
 
 static void aie2_fini(struct amdxdna_dev *xdna)
 {
-	amdxdna_pm_fini(xdna);
 	aie2_hw_stop(xdna);
 	aie2_hwctx_sched_fini(xdna->dev_handle);
 }
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
index 8b6e7283e057..1d0b91e73260 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
@@ -413,6 +413,8 @@ static int amdxdna_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto iommu_fini;
 	}
 
+	amdxdna_pm_init(xdna);
+
 	ret = amdxdna_sysfs_init(xdna);
 	if (ret) {
 		XDNA_ERR(xdna, "Create amdxdna attrs failed: %d", ret);
@@ -431,6 +433,7 @@ static int amdxdna_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 failed_sysfs_fini:
 	amdxdna_sysfs_fini(xdna);
 failed_dev_fini:
+	amdxdna_pm_fini(xdna);
 	mutex_lock(&xdna->dev_lock);
 	xdna->dev_info->ops->fini(xdna);
 	mutex_unlock(&xdna->dev_lock);
@@ -446,6 +449,7 @@ static void amdxdna_remove(struct pci_dev *pdev)
 
 	drm_dev_unplug(&xdna->ddev);
 	amdxdna_sysfs_fini(xdna);
+	amdxdna_pm_fini(xdna);
 
 	mutex_lock(&xdna->client_lock);
 	mutex_lock(&xdna->dev_lock);
diff --git a/drivers/accel/amdxdna/amdxdna_pm.c b/drivers/accel/amdxdna/amdxdna_pm.c
index b1fafddd7ad5..9c030b7836fb 100644
--- a/drivers/accel/amdxdna/amdxdna_pm.c
+++ b/drivers/accel/amdxdna/amdxdna_pm.c
@@ -75,4 +75,5 @@ void amdxdna_pm_fini(struct amdxdna_dev *xdna)
 
 	pm_runtime_get_noresume(dev);
 	pm_runtime_forbid(dev);
+	pm_runtime_dont_use_autosuspend(dev);
 }
-- 
2.34.1

