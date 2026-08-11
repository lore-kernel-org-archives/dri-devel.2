Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6D7C5B56A
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 18:19:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58C5010E301;
	Tue, 11 Aug 2026 18:19:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nPE2XjlC";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012070.outbound.protection.outlook.com [52.101.53.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23B2910E301
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 18:19:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPPJOSqBOeYNomjLCU0E6Y112GSZAxb6XjeTOnmE4TTMLdKEqvmUM12+BL57BixAVLvoHDn4TTTWs0LqmSDa0bV2KY2LyrtM3s3ZvDdOqkCgQDqMLcem9eGph0KLyVwrUZRagjVJN+L17zTbcLFwUWmYgDORlnWBQsqEgNSoWLaTF+F1fGULMpdrvzHgGiOcQ3q3oTiPPozoKkbkX+ckYfB8LDbGBNhG9xA4Ll6BPcm0ya/bxvSLwv61d7CgIQ9yG0WLxhw5Uu4vK8aMqtIFt6N4zWF/DXaHUrlTsd5fiPpkgaCIjoDT9SRpUVN3MxB2eW+FGXx75dQRPO2VbhAk5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmw2XTMr+GFX/XOKIFB57wu6uG6dD87cvrIb0avbURE=;
 b=zOkuRUU1TKTvmzc7Wl3HptpaJukXzPsPdBHUbildUpxVW9Eaz05Km+8gsiUOqsVoQ2fl++vN6enwCzo5r5lD2OQFVP0Bc9K1D8Jj7Vk/lfbx4URc4B75riUlAYkmb26xm3Ijwc8qNciWBRWOJvKaiqkvgGUxvqE67zbyQZZdeu/jSxbDNAhR9vqKg7yRQF6dK1Ft0/+itGlBu3UmNN71OwaxyONfbdWHdjV07Y16OGhYcIX3Kmmsz0nZd+pJ05ejryedu7w5mch6ZX8lvDTiBgExxHTgYTWLECGe9eU/+rdNqyvcdA1ikUXa9Kc1vZ5ET+2nKeKLfC93Uk0nWQs6Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmw2XTMr+GFX/XOKIFB57wu6uG6dD87cvrIb0avbURE=;
 b=nPE2XjlCVt8Qx4ml1DOkTv6FqTL6HQ/3pS4Ui3iWJnuap6nlE0RsT4ijtf00Tdlub0uoge5iLlW4UVK8F31p0kqkSadbqSP5GV2luSZa5GH8TOB24B0bZYu/SD+Mxq+zwOqkQH8iz4gyEhkoAM5OIJkYto4YvObTzKk8CXLXnRI=
Received: from SJ2P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5da::18)
 by SJ2PR12MB8783.namprd12.prod.outlook.com (2603:10b6:a03:4d0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 11 Aug
 2026 18:18:51 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:5da:cafe::19) by SJ2P220CA0008.outlook.office365.com
 (2603:10b6:a03:5da::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Tue,
 11 Aug 2026 18:18:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 18:18:50 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 13:18:47 -0500
From: David Francis <David.Francis@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: David Francis <David.Francis@amd.com>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>, Christian Koenig <christian.koenig@amd.com>,
 Simona Vetter <simona.vetter@ffwll.ch>
Subject: [PATCH v2] drm/gem: Fix and enable CHANGE_HANDLE
Date: Tue, 11 Aug 2026 14:18:35 -0400
Message-ID: <20260811181835.1660190-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|SJ2PR12MB8783:EE_
X-MS-Office365-Filtering-Correlation-Id: b2fe0363-9e78-4a0f-6cdb-08def7d4fe96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|10067099003|56012099006|11063799006|6133799003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: OUXBROjp5uo91zG0gaZBNJvKxiB1419pcGLDQio1WRYR9HHQ0zfiyhiRbvZejZ0RfJ1zEDDzhnEl4XuVDp7cg6MCjQo1jN8YZ/iXnmjjrh6fYWTPHatRNZSXquNSfFR0lyMPRinKU6BKArGErABDOdDPvJQvwO9SL/IqrMEqVoCuIKDpZoyhDdLTqU0O/qnSakeJuKfKfEZYM3hgQJDLC921vX4plLzOKlq+DjFpBZtWMPHyjv34FCIvlofGiid64PvEM5h4scj6fG8PyQ8na3hBWAf8lG9g3lNXxvN55+4+I8PS7K+YyrzWYQJuBIaQTK8sBWLnA+tm38SmuxNNwLfQ9ikBBuLGS80BiYfgXrgwjqR/hOmg2tt3whUtad5bU5RXO+c7kBtwVBC5aRXm0I6ixBSuy/m6wfjPrDvyS+4V42xj0OPHz/1S8RuTvfmS2/DuhMehbf8Xo+2oXwHXoghUJxqp0rljJtJRRvieZbH1km4LCHoAx2/lS0HzvRsMpNBZvlpeWwDsPqs9yG0AFNqAXZdQ3UM2QeHyKI07SVUgfRDBTR5uitgaZO/ZZ9P0XEYEiIXb5bxT11h6vRAKHUrmAM9IZmjrDfbWDTsjcpunpBTXcatLv/yW+cknmF7YCJVtVmIkFVvGfXNMSJBWTg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GTU5zCJOlwXrCb+Wf5XWTxQxdqlf9GH4rTTwMUSmKFn2bQ1ZhbaINXxfPEpgquFbrJ3bRbEalgkGnyexJbiCaEn4YJtBmKbXKISeg2UOXuoVFAzvX7JBJ4IayEVeRFMxwB73cED6ciUeZuq6leNrYCDKbbNtnNyH9WfCFTqOyfb2ZHOjDlgAiyQEp8UCoOaS3kxdGmxdmEAsKpSp5OqqYJAiN/+QcbLunX0HouUeS1KmXkY4ScilnbL/Qyq5NsxMEameBt/cFxY5L+VC/MHx2Ln7UVxEdlcdivD5fARBMOLM5c2kLUyZ7e/WEjLhmJkHl/a5ADNsI7anpFoH0t5RNp1mQ5CAFlSuTErRJwP6ym0ejNevkZpnFEa44nGPcJkpwdo/1bkTv3g6Fwh+ajN/lf1z7zuJXEyLwL0/v4HdUJe3GHn/20MXrfCgrRxo69hc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 18:18:50.8227 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2fe0363-9e78-4a0f-6cdb-08def7d4fe96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8783
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

Make the following changes to CHANGE_HANDLE
- Changing a non-existent handle to itself is ENOENT
- idr_preload before idr_alloc
- reject new_handle = 0 with EINVAL

This patch will not be merged until the relevant igt-tests
(https://gitlab.freedesktop.org/fdavid-amd/igt-gpu-tools)
are reviewed, merged, and run to the satisfaction of everyone
involved.

cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
cc: Christian Koenig <christian.koenig@amd.com>
cc: Simona Vetter <simona.vetter@ffwll.ch>
Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/drm_gem.c   | 30 ++++++++++++++----------------
 drivers/gpu/drm/drm_ioctl.c |  3 +--
 2 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index e3ed684ddcf2..c8f3bf27b7de 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1015,19 +1015,6 @@ drm_gem_open_ioctl(struct drm_device *dev, void *data,
 	return ret;
 }
 
-/*
- * This ioctl is disabled for security reasons but also it failed
- * to follow process in terms of adding testing in igt and verifying
- * all the corner cases which made fixing security bugs in it even
- * harder than necessary.
- *
- * To re-enable this ioctl
- * 1. land working IGT tests in igt-gpu-tools that cover
- *    all corner cases and race conditions.
- * 2. handle idr_preload
- * 3. handle == 0
- * 4. handle == new_handle semantics definition.
- */
 int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
 				struct drm_file *file_priv)
 {
@@ -1039,20 +1026,29 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
 		return -EOPNOTSUPP;
 
 	/* idr_alloc() limitation. */
-	if (args->new_handle > INT_MAX)
+	if (args->new_handle == 0 || args->new_handle > INT_MAX)
 		return -EINVAL;
 	new_handle = args->new_handle;
 
-	if (args->handle == new_handle)
-		return 0;
+	if (args->handle == new_handle) {
+		spin_lock(&file_priv->table_lock);
+		if (idr_find(&file_priv->object_idr, args->handle))
+			ret = 0;
+		else
+			ret = -ENOENT;
+		spin_unlock(&file_priv->table_lock);
+		return ret;
+	}
 
 	mutex_lock(&file_priv->prime.lock);
+	idr_preload(GFP_KERNEL);
 	spin_lock(&file_priv->table_lock);
 	ret = idr_alloc(&file_priv->object_idr, NULL, new_handle, new_handle + 1,
 			GFP_NOWAIT);
 
 	if (ret < 0) {
 		spin_unlock(&file_priv->table_lock);
+		idr_preload_end();
 		goto out_unlock;
 	}
 
@@ -1060,10 +1056,12 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
 	if (IS_ERR_OR_NULL(obj)) {
 		idr_remove(&file_priv->object_idr, new_handle);
 		spin_unlock(&file_priv->table_lock);
+		idr_preload_end();
 		ret = -ENOENT;
 		goto out_unlock;
 	}
 	spin_unlock(&file_priv->table_lock);
+	idr_preload_end();
 
 	if (obj->dma_buf) {
 		ret = drm_prime_add_buf_handle(&file_priv->prime, obj->dma_buf,
diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index e2df4becce62..ff193155129e 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -660,8 +660,7 @@ static const struct drm_ioctl_desc drm_ioctls[] = {
 	DRM_IOCTL_DEF(DRM_IOCTL_GEM_CLOSE, drm_gem_close_ioctl, DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF(DRM_IOCTL_GEM_FLINK, drm_gem_flink_ioctl, DRM_AUTH),
 	DRM_IOCTL_DEF(DRM_IOCTL_GEM_OPEN, drm_gem_open_ioctl, DRM_AUTH),
-	/* see drm_gem.c:drm_gem_change_handle_ioctl for why this is invalid */
-	DRM_IOCTL_DEF(DRM_IOCTL_GEM_CHANGE_HANDLE, drm_invalid_op, DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF(DRM_IOCTL_GEM_CHANGE_HANDLE, drm_gem_change_handle_ioctl, DRM_RENDER_ALLOW),
 
 	DRM_IOCTL_DEF(DRM_IOCTL_MODE_GETRESOURCES, drm_mode_getresources, 0),
 
-- 
2.34.1

