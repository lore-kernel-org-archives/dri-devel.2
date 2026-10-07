Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB77CA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 14:11:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D813E10F5F3;
	Wed,  7 Oct 2026 14:11:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yVVMtLf0";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013008.outbound.protection.outlook.com
 [40.93.196.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75F0C10F5F3
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 14:11:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KIyk7/H6d1P5Vd6SGeV7P8onOokUMyOqob9iKW4QZfUjBhYTJc7T4juLD8atgOCDcGhSAl9qxngc5PIAWSWk/laezyNvAEo/Zr+kCRITmtnS8iMCAle7VIvSw+1SbPsylhaa8YbtVzBi9b3LBDvZx1iW1nOIp0LhhMeiR5WR2AwN7iv9ZKl+qFZGryn48GJpElRfsxR+EdvdNZLWKFbgGc19gpNP282Ghqgtu/IawAMko5tRrm+zvXw6kz2cGwQMfN3Jba8B2f8ZAVhrHLKxvFFpPQ+yvJ57nIEwDFCIkfnv7ReAmG9H2Lnj+s+S8PE2HokUwaZNyXusFbBUYGXe1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bAnFmMO83XtPj2UC3RHsd7bnNKhx39fjvGNCiRaSzM=;
 b=MXeIUtz3WuOkgi6AKMiPs+brt0GkfCyxN8v3t767T3TLD5vt7zA2T2hOpirYgAkUVmGEXVO4jx6Qu/9N6BNzL/pOn4cZG+Y4JAil0a+DCE4/kixmVsbP+nG8A3vT0rTD5dxx1Rnw1zqmjTGSPWsGaoG69N+akuaWIPY8soAp4zcYBDagbnZnPlIFV3Q3e/UEAFc+/bDoUQhyx+rRKZN0yyt4tZkwhHqf2XZJufnvarVn9Sy+yIVnxswiBQMpt8ml8TDvrtQc+3SC/l1RdI72PWHpd9CRMhncPuSblY8r3Hckt+rG65dInRIwZ1ZiM7CeVZ4YdTmpAhp0vFLgc0enrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bAnFmMO83XtPj2UC3RHsd7bnNKhx39fjvGNCiRaSzM=;
 b=yVVMtLf0KL1uNiK5vD0AE/6arnIwkpa9HWccXh5TIe72r/L6YYWYxjUe0xNLX939qMYPXHGA5OttdQcC7a/t0iarHmguR83nBWsKVvD7/yQu7XiTsbeQ+Q27Aq37AZCLHwRRrkN+ylSY9Ce83/TDpzB/kPCXyj8QSbRhbVrtq98=
Received: from CYZPR12CA0015.namprd12.prod.outlook.com (2603:10b6:930:8b::15)
 by IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 14:10:58 +0000
Received: from DS2PEPF000061C2.namprd02.prod.outlook.com
 (2603:10b6:930:8b:cafe::19) by CYZPR12CA0015.outlook.office365.com
 (2603:10b6:930:8b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 7
 Oct 2026 14:10:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C2.mail.protection.outlook.com (10.167.23.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 14:10:57 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 09:10:55 -0500
From: David Francis <David.Francis@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: David Francis <David.Francis@amd.com>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>, Christian Koenig <christian.koenig@amd.com>,
 Simona Vetter <simona.vetter@ffwll.ch>
Subject: [PATCH v2] drm/gem: Fix and enable CHANGE_HANDLE
Date: Wed, 7 Oct 2026 10:10:43 -0400
Message-ID: <20261007141043.2928048-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C2:EE_|IA1PR12MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a3f557b-d63b-4f5a-2044-08df247cceaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|10067099003|56012099006|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: 26dbDTLoeX/YmZRCqNBYQWd1mOPzJLY+S5dAD5MFOrdjlI/4aSRaFyyJI0iY1Qn9PIIK9POLOhO9JGTqcoqfDlczW2/YmFha06CQYTh6nXPMas0NRHMr/4rE5WoJOmwDhQ0TFPoqQPnYTVDX07J1hZJZDsMI5UQ0VfM/uUI50xedlALhdqYDyJapexz9Mc9BpPYwJ6g3L1q7RDtRx1ntL5wBmfaMKNH0ebI9+cwTSEIWcQG8IMnT2uwC+7erf8YdBXeEnLNp453p8hjk6zGyJJHM/s6MnpSQ5bNtFXGOf+uGPA41AYZmOHqKsuUI0UeXj2+0tYm3VqXiFExr1E4f2X4xkp+k0/55dFoFKk0fkIlbMfO9xUjuNQdJkcCSl2E5IlLC2I8M4GxQlTHeGAKczWKKJSHe8cAlpdBAx3MSVnEPqwF0sWS3RSBOQo/NS3M37TJsA/KyxV8bUJekexwIjS4LvDPaSJ7XhbmZ+P3vV1ARl6vMCfPWn8CiDJ+k3UYWYKJIPdCiT40w/8LkWUhX2xHzMJhmg96GUKvvikZwmhEMYwEOlm4RftO/UggfroQjtaPKas60K2k6gKv80suocGt+FppdxWN5Js9hSUtpnj9oaYdKm0F14XPNvUOu7FUx9MxcQvVPg1wnv5uFS7fNu8voRD80y0+Jswv7o+XLG9NSWR7ieDJLwDL0UCd2J2wdolN4Vpc/Gs+joDgjxY6gaQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AWzoP+FeW4nXinvqoOYdZeiLgrili4D5k9KKy7wkpXNr3wAyY5iX6jaoBLQmSVBGXT/Nzs8secSrh7ngEalygASB/llC4wUP/O5/3Ep9QKzoMXo3FDGQO5tbmlEwnjXkOxkXS48+cLDSNvQs0djvW/wATuhZCd6as6fkEqYY4hFaBi3i5qEZQTTZsAeWgOSIYyRxrWHTlKwOhikJIgP8vsDo1xZ9cNDM/lA6we3NUO8e1D0dky5m5a5N9R17UzIHbf9BS/fl4YqIIKa8ccBZr2RumVIMJbFSlzcziZzk9qTlH22wIGt5tTdNlGqxpRvdwB41+GWf8g4LICqEYVRuSel0xrqouM6kZCuRXb0t+LiMkrLxSRf1Sshs80QkZdLTKkkSh5QQP0QUgK+8LF1jZRd4PVsIipKWBsmyW3XfbDYTdrgWd6lAUuJaAw9iFqz+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 14:10:57.0907 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3f557b-d63b-4f5a-2044-08df247cceaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6018
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
- reject new_handle = old_handle with EINVAL
- idr_preload before idr_alloc
- reject new_handle = 0 with EINVAL

See also the igt patch
tests/intel: Add edge case and race condition tests for GEM_CHANGE_HANDLE
on igt-dev

v2: new_handle = old_handle is EINVAL

cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
cc: Christian Koenig <christian.koenig@amd.com>
cc: Simona Vetter <simona.vetter@ffwll.ch>
Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/drm_gem.c   | 21 ++++++---------------
 drivers/gpu/drm/drm_ioctl.c |  3 +--
 2 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 6a86bd2a0343..81aee038e3b2 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1018,19 +1018,6 @@ drm_gem_open_ioctl(struct drm_device *dev, void *data,
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
@@ -1042,20 +1029,22 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
 		return -EOPNOTSUPP;
 
 	/* idr_alloc() limitation. */
-	if (args->new_handle > INT_MAX)
+	if (args->new_handle == 0 || args->new_handle > INT_MAX)
 		return -EINVAL;
 	new_handle = args->new_handle;
 
 	if (args->handle == new_handle)
-		return 0;
+		return -EINVAL;
 
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
 
@@ -1063,10 +1052,12 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
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

