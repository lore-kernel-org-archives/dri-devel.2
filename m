Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62184C5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 18:37:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91C0C10E42E;
	Fri,  7 Aug 2026 18:37:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K0JY5uoM";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012038.outbound.protection.outlook.com [52.101.53.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C155910E42E
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 18:37:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vKSXpUuomGLlHjKsXlsvtOe90r/tuyEcbk556AlM5UY92KcPFqFX/DHIdZPegBPsu6ScdeRvtIthjMoq9/6GbXmkADKcoayC9sLfBQvaGK7UEBERv9+4fv8F3Fy0Lz4gitZ7rhTX5xbZbpfC4UPk52kh9oORyPyBaWEGuPJOJgJPqCWJIHs9GtN/QzkMxXIrWZjgeBaSL5cJOG54YDBPVtjEOAXpR8oWjBqVEim/eNeGleOAKZTX6BvNL8Nb4NJ5NjSTxMcoWBGV50H6KjgofKd2OvKKPwZvkIrlviWOQ96z58wyLs0eKWOqDnSQ1uSINk0IsD8Xt9BaSctCYbDsNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5F2qRj3Sh8oV9NiZ3Miw51RBOmZf9OmlzqRc2CvzJ/Y=;
 b=cG1f5f5HoXe2xUyf/YJfn6zpZlS8PgIA5BF/nvyUU58J31UDhJfPm03XtUqxNF9dXtpMCQHJK08WlSQhIutU6EFx8UKhu3FkNvCRU/xr2x2uSJQADU8vD3rtbjYP4NENWT8HoX9/0BuOim922EOFOBDfrX3psaVXZMAUNQJFYJ1ixq0EgnEPSttcE2lVjLKteafJ+KUVRAea+jVkAyVZY4TJXptydxFdgObNiGGZa45QhuX7QKhVAKqkBlxV/kQsbqZK5rIZ2lQI7q683dPO2e+PAwDDOzaZFNwDQ/NMO8o2dBEb3zN/k4G49UUZLuRymtWzHa4AkJkW7pEWAb/Ihw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5F2qRj3Sh8oV9NiZ3Miw51RBOmZf9OmlzqRc2CvzJ/Y=;
 b=K0JY5uoMwTgV+sF5XlPYJla21suO8IIZfSBYPiFeQyZcsJDaqmsgYwUSVSqmCgUda8oWeyYEg/4+PNLq58lycBmW5Jbj7CkVTa1UV5Vyl+xtXreFN+jcohWRe6XgDVEmuTrd7i6y8RY3WaNS5Z62oDWQ4AnDPAiiaib8eUNPm+U=
Received: from MN2PR15CA0059.namprd15.prod.outlook.com (2603:10b6:208:237::28)
 by BL3PR12MB6547.namprd12.prod.outlook.com (2603:10b6:208:38e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Fri, 7 Aug
 2026 18:37:50 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::a7) by MN2PR15CA0059.outlook.office365.com
 (2603:10b6:208:237::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.24 via Frontend Transport; Fri, 7
 Aug 2026 18:37:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 18:37:49 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 13:37:49 -0500
From: David Francis <David.Francis@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: David Francis <David.Francis@amd.com>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>, Christian Koenig <christian.koenig@amd.com>,
 Simona Vetter <simona.vetter@ffwll.ch>
Subject: [PATCH] drm/gem: Fix and enable CHANGE_HANDLE
Date: Fri, 7 Aug 2026 14:37:35 -0400
Message-ID: <20260807183735.1019040-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|BL3PR12MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ef22378-e1e1-4bd4-e463-08def4b2fbb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|13003099007|6133799003|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: jxv/TR24CbSMG3D6iG4k+vZ0ctpdV4Xz81eiFmuASWebJGTnCfYjs5Y6tx70y92cktGoW1g7f26m8lPgBbozpW5wmsDW9Y7eX2etwnCyi3dlB2GVXMLqi6G2+Gn97G//+/t1LSnR2KA1sNix4S3KFO9bgV3IN8RA1x80FD28LeJrpmiDewzgFQH3iiv/10JW9ovbWWHFXxfHvJnuvaXBgWLypC1PrtQMUayrILw9Cg7vFMg85iCXSmWxfXqzfVF3snLJ4jI3Iq9i9uDLblegg/0YJ6CO1MkgBJJfmzTzxsgwv+i2I+168KWDw8MtlcVHZ0ora6i6JS1yXj3gHX+x+EVDUPbx9LnfJQfHS6ihfRYZ3F8Vn1PCoizFNLhZuqpeoT/pMY9b3nLg+7YQb9SyuuUzWCRd8mbVFnu0sF4rLXhTMXRUPKs/s7mHInEnkAdlFtVmXNIU5MrB4b6sdzyWmhiGYNJq3fAoucME9FKUAv3fJTN50PFgJVfn1qXaprJdxb6P47Og1EkUY6dqdDo4IZhLE5XTq6uevpupG7ibj8lWPGc+iFfVj4pySVXROibWY5bXPlxSnWBzSDo3IREt6njdelupDcdQyUrxM08bhicGsynAEsRa8oxPZnWAY4RvKS5UeVmuUwA0UsOqsFrB82VHik3R4o9SY1gHNMFCu7o3iVQ3BWDVDdPgCVnn4HIj0lkQPH07axWJYSKGtYWb2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(13003099007)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: E90RjGOWGTdu51SpYVSUiDR7+n//8ECzFtzVwFd+CJwxxG1fDMoViCFh62Q/9QEFAtV9OnaN/pOzNpOwE4n259wmxvSEIuTlO4GsCwciwyljPb2rwujqtnEALbIaMy1bV1UpQAniead6kIKmY7/9WoeT+aZa4xR5ZjQDL6t5n6huX50bzYINwTk+IgCTL2eKEdprhlpc3mjvX2g1dCDcnkPI+86J9oaDPCEU+O0zPtAwYzRDmGKr2ptJR0pIoetyHmkV9Bkpm5uNlNwgjntm4Ulkq3MuUv6j9tLCSmLJcL/prGcJPBg+UdE+mg5yEPwP5sPYvOAAcUfMfkf1auhQClhj5ve5ZqhpkNm0k5VRZTzoTVCjmgiGpj52HkHV1LdWiyYvqhxn+5KBeneALGB0/Jx+75nNTXyRwWusj50C9UJMMeZuR6AVYQt1OsDpgygV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 18:37:49.7054 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef22378-e1e1-4bd4-e463-08def4b2fbb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6547
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
 drivers/gpu/drm/drm_gem.c   | 29 +++++++++++++----------------
 drivers/gpu/drm/drm_ioctl.c |  3 +--
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index e3ed684ddcf2..9a9b91256b8a 100644
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
@@ -1039,14 +1026,22 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
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
@@ -1060,10 +1055,12 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
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

