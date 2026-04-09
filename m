Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1097F31E22
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 15:23:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2F6010E0EA;
	Thu,  9 Apr 2026 15:23:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GtzljLRN";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010009.outbound.protection.outlook.com [52.101.46.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C49F10E0EA
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 15:23:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XfNHv2U6mNrAFoIL26wN9DfmnNBwMMZxjcbxDm0SPfSYRERLlSge9n4BP4MUujyVTdOnIaXmAOTdbN7Q89EOVzXjwOeCPVk9bFvR5k/dhZ3yG0P4qAQ6ksabd9d8eI0IT2/2F065FzkHT6XusEE69ls4vA7ls4Bnn0hdAUSWJQz/ozSYYxnwBEiL+omiRWhUTESXTCibURMhX4uRKsgyo9Cj5JDUKESL3ZNn4iAIIYMcpwU6kASzwnTlANEF9HqcvkhFns6Ns56/OwvjBccbGWdeujW3hvqPM+Ez+Var4YLIno9o4tX7OG7f+A5HEeV2fvsmAGPnxPmVwtmfrd7gxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRs5VJp4ysqwsS8ckaf6n6ggsykQabUNlpVdR9V3neY=;
 b=T6qsmQhAEXsJbgkiqauTxSrVBNaWBKQi0aEbSFiK9QmcDFujdgUzm0HKzd+Mt6pDD58KhmApkh6P0djMkcoD6vfyGSmjQia9OWJVc70V9sVryDWBOB/WtEamwL8hBbCCA1c/5hkLt6igkSL4rrtyeRzqihfs5LU1/zY5Dmgycf7EaNDaLnTa22a6ZIuq6FvbKlbSV+/3SXzQR9CBOc1CaHdpkbF8g3y0R+0IE+RUvNeWj+OsGmMXk7VgiZRjzLVJfXh64NX6U3eLh01pUgxy9SccO4HBthAQuZDhs35YPDSYTIM5DAUWuL2g6sWysxoJVjq513cqV6mcclfV1l/www==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRs5VJp4ysqwsS8ckaf6n6ggsykQabUNlpVdR9V3neY=;
 b=GtzljLRNDPYDASxvmSP/W7nnuIQ+YAGiEcCBEW6JpjRG8+rd9KOLP/0HApUiR4qtLHsWh5FYw8stDNdPcRmnkYg22v5RcRa53LfYoNc6TJ7aSJ4aDMV8+7zrEfIqeUn18GI/hgOylOW+hhAhezxUZaGot95Xyu3jTgvHOPn5ulo=
Received: from CH0PR03CA0261.namprd03.prod.outlook.com (2603:10b6:610:e5::26)
 by LV2PR12MB5896.namprd12.prod.outlook.com (2603:10b6:408:172::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Thu, 9 Apr
 2026 15:23:08 +0000
Received: from DM2PEPF00003FC6.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::5b) by CH0PR03CA0261.outlook.office365.com
 (2603:10b6:610:e5::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.41 via Frontend Transport; Thu,
 9 Apr 2026 15:23:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC6.mail.protection.outlook.com (10.167.23.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 15:23:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 9 Apr
 2026 10:23:06 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 9 Apr
 2026 10:23:06 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 9 Apr 2026 10:23:05 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <maciej.falkowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V1] accel/amdxdna: Expose per-client BO memory usage via fdinfo
Date: Thu, 9 Apr 2026 08:22:59 -0700
Message-ID: <20260409152259.176883-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC6:EE_|LV2PR12MB5896:EE_
X-MS-Office365-Filtering-Correlation-Id: 298f8c60-05e7-4b67-ae82-08de964be676
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: zZxcm+OF2BvYrGWnBMFbyIAGkOfsAm9rfnwnrbNtavO1q0wd/G4zkKB/5qu4Xb4YG1G8kzt82rQlqB+uDTsitoY+4lkbu88w1ZUrISCzlghkSshUT7GgNp5n7APdheMee6gVjng/EnCSHXklC06L3z74C2NjcWiJ7Fkk7gse0NG5B666ficVsIv21Z+OMN37bkLGR4oGY9K9iomuxL9DMY9+gm3h/FQuFdtsybRq7Hmbe9PbKBgQb4dVYgLfo6HAlL0qcMs8PCty+1fSp6PQWhS+wEb+uGa0kVW0ZEYZ+Ib+asvKQlAF6NRpWz1DpWx4qHdW2f9A41MoXDY6uJuHdvT4a5UVPa3dQFFGu0NhgHlz/98RzTUZnZexGc7FRhLOIkDlyYKm0e+mAKg2350ei2Xgfu4lHGRLxVaYfP1lUjJIXg7iZ5fB6Q0YCMxECq3ZPNFupv6aFubgrljhNa20S1LaMHpnUDtDVo8b35etgdjuUcmuv/syoH4qMectAzb8uVkIj5y6ZF5JaBBQsJcdk1oWR1pdgb1hiT9yZxW6lkGzCUPiqNqH/g0G5PXihRksJsZtafHFt1XKdmibqG2mUjoHis9rZ53HY03r/sLvJCkPC/bUZ+85hhSHsavvGBg9Nb603EFA38lri64JY4WaNGh2AdQkxbz8TG3u85szPsB+RVRCAKyyeVChWj7sj3lbBFEXIwmRsNH8y4fBLVdx+vscpWSeakf6imhJQ9ZagLp8kOtE+tekTmnposUBSjtPjjuMGuW6ZJRE3225+ffzGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZFSll5sHe36mw3EyXDJ5MAjTm8r29j+S8YMSuBHmjL5Q6HpSOKeoO5mNk200IZeYO1Dt3DfXvRPYOQSWWIXyOsb/stk8uCoocMwMog7gBZVY4rJwsMFkcg8KVax2nwfbMEtgGklm4cSuXiX0zRxRUVT4qG7w5s1ZfuU5L4Cto99fDeG0/KU8emAP2pXRApsGsz7mQHIwyrPU3pC2NqJpEtFSKjnL6w6g1MecZdZKWH+HqQt/hHQwzxdHrZP9EHx0ELDcNnwjEo3b500DwiWs61QVjQNW4hivpjaWfXm7dK3feY3PlcsJvaKbjycIXTUlDF2mcjkIJ6KycDtjep0RzYIHkPDFAUmGPEZf+OFfbyoniO9m3bSTNERnM58wyHHXMWbuWGy0+CtiFRbIomFfF8FXsVfh52rnafnMffC40tWZ0jbcATpBlaZt9SAzC/P9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 15:23:06.5869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 298f8c60-05e7-4b67-ae82-08de964be676
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5896
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

Implement amdxdna_show_fdinfo() to report per-client memory usage,
including below driver-specific memory stat:
  - heap allocation (amdxdna-heap-alloc)
  - internal BO allocation (amdxdna-internal-alloc)
  - external BO allocation (amdxdna-external-alloc)

Hook the implementation into the DRM fdinfo infrastructure via
drm_driver.show_fdinfo, while continuing to expose standard DRM
memory stat through drm_show_memory_stats().

This improves observability of per-process memory usage and aligns
with existing fdinfo reporting mechanisms used by other drivers.

Signed-off-by: Max Zhen <max.zhen@amd.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 Documentation/accel/amdxdna/amdnpu.rst  | 25 +++++++++++++++++++
 Documentation/gpu/drm-usage-stats.rst   |  1 +
 drivers/accel/amdxdna/amdxdna_pci_drv.c | 32 ++++++++++++++++++++++++-
 3 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/Documentation/accel/amdxdna/amdnpu.rst b/Documentation/accel/amdxdna/amdnpu.rst
index 42e54904f9a8..064973bf4893 100644
--- a/Documentation/accel/amdxdna/amdnpu.rst
+++ b/Documentation/accel/amdxdna/amdnpu.rst
@@ -270,6 +270,31 @@ MERT can report various kinds of telemetry information like the following:
 * Deep Sleep counter
 * etc.
 
+.. _amdxdna-usage-stats:
+
+Amdxdna DRM client usage stats implementation
+=============================================
+
+The amdxdna driver implements the DRM client usage stats specification as
+documented in :ref:`drm-client-usage-stats`.
+
+Example of the output showing the implemented key value pairs:
+
+::
+
+        pos:	0
+        flags:	0100002
+        mnt_id:	29
+        ino:	939
+        drm-driver:	amdxdna_accel_driver
+        drm-client-id:	3219
+        drm-pdev:	0000:c5:00.1
+        amdxdna_accel_driver-heap-alloc:	60 KiB
+        amdxdna_accel_driver-internal-alloc:	67588 KiB
+        amdxdna_accel_driver-external-alloc:	0
+        drm-total-memory:	67632 KiB
+        drm-shared-memory:	0
+
 
 References
 ==========
diff --git a/Documentation/gpu/drm-usage-stats.rst b/Documentation/gpu/drm-usage-stats.rst
index 63d6b2abe5ad..24d3012ca7a6 100644
--- a/Documentation/gpu/drm-usage-stats.rst
+++ b/Documentation/gpu/drm-usage-stats.rst
@@ -215,3 +215,4 @@ Driver specific implementations
 * :ref:`panfrost-usage-stats`
 * :ref:`panthor-usage-stats`
 * :ref:`xe-usage-stats`
+* :ref:`amdxdna-usage-stats`
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
index 09d7d88bb6f1..21eddfc538d0 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
@@ -226,6 +226,35 @@ static const struct drm_ioctl_desc amdxdna_drm_ioctls[] = {
 	DRM_IOCTL_DEF_DRV(AMDXDNA_SET_STATE, amdxdna_drm_set_state_ioctl, DRM_ROOT_ONLY),
 };
 
+static void amdxdna_show_fdinfo(struct drm_printer *p, struct drm_file *filp)
+{
+	struct amdxdna_client *client = filp->driver_priv;
+	size_t heap_usage, external_usage, internal_usage;
+	char *drv_name = filp->minor->dev->driver->name;
+
+	mutex_lock(&client->mm_lock);
+
+	heap_usage = client->heap_usage;
+	internal_usage = client->total_int_bo_usage;
+	external_usage = client->total_bo_usage - internal_usage;
+
+	mutex_unlock(&client->mm_lock);
+
+	/*
+	 * Note for driver specific BO memory usage stat.
+	 * Total memory alloc = amdxdna-internal-alloc + amdxdna-external-alloc
+	 */
+	drm_fdinfo_print_size(p, drv_name, "heap", "alloc", heap_usage);
+	drm_fdinfo_print_size(p, drv_name, "internal", "alloc", internal_usage);
+	drm_fdinfo_print_size(p, drv_name, "external", "alloc", external_usage);
+	/*
+	 * Note for DRM standard BO memory stat.
+	 * drm-total-memory counts both DEV BO and HEAP BO
+	 * drm-shared-memory counts BO imported
+	 */
+	drm_show_memory_stats(p, filp);
+}
+
 static const struct file_operations amdxdna_fops = {
 	.owner		= THIS_MODULE,
 	.open		= accel_open,
@@ -236,6 +265,7 @@ static const struct file_operations amdxdna_fops = {
 	.read		= drm_read,
 	.llseek		= noop_llseek,
 	.mmap		= drm_gem_mmap,
+	.show_fdinfo	= drm_show_fdinfo,
 	.fop_flags	= FOP_UNSIGNED_OFFSET,
 };
 
@@ -251,7 +281,7 @@ const struct drm_driver amdxdna_drm_drv = {
 	.postclose = amdxdna_drm_close,
 	.ioctls = amdxdna_drm_ioctls,
 	.num_ioctls = ARRAY_SIZE(amdxdna_drm_ioctls),
-
+	.show_fdinfo = amdxdna_show_fdinfo,
 	.gem_create_object = amdxdna_gem_create_shmem_object_cb,
 	.gem_prime_import = amdxdna_gem_prime_import,
 };
-- 
2.34.1

