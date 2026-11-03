Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C46606A32E
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zUV9ipXs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B326A10F6A4;
	Tue,  3 Nov 2026 15:54:40 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010051.outbound.protection.outlook.com [52.101.46.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0320110F6A4
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 15:54:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9BbcE2Erqg7kXGI26J3iQSjRazApfPy5Ji6grgyrvTZqw8MXJ92cKyOTI9OWn4ZbO9NBNURo9jY6K0OgTmi7B/1zRADLcwOdDF/LSS4oiWJR/Jytc3V6VSNwo/q+NWNpzG+uleiKKaHLp+6ke6rcVRp7wpcSa0umvNtV5wtZAzDmvY5vVuWZiNHQM5gDA+7lwY0FyAXiuh1Wrbf9ljCywW5S5WU/0yxFjOO16LEMcy1sqUcEqacAD9zJqJ4kmX5iMuJJoTisRTxqirZ5uM5oX4as17Z8MQmmgJZzNAGPyvxkSYeKMKxxJ+0HZDgUU9HEHKr2hTv3X1jiRF50kUFPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jl6H/g25Hbfu1+bpU29IDNbFdeYq7pIqi8+JsAa9HQ0=;
 b=mehDvM+LAtqAYy0n9JLDiV7HTl2uQ8Y9lvGW7vrMJRXMM5Hj2PbSGiud3xazWAXYP8seF9zkPNn8njRGJqHMKaxRv30aFgUdJI4Ye44QqcxdQufITYIctzdUq1FygPJW2DUo+1YD0ZHQkIOrAyWb2VrJnI1LxgMbe9t6Q2XNjyF7lLybSQ2AHO4Ma2JrA2O4ozWQF2rng+Le5d2YMlyhLkkFD6DJd+O0K5Mc2g/+JvVRfin5TLp9oJniw5zppR0xmrSiHXiIO8zTGAokS4Z+iFZE0muQFDi2aUA5NWed69nyqZEv+WdryNwtAwToa+rPB7YMaAGzxN02+tXMeSXQGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jl6H/g25Hbfu1+bpU29IDNbFdeYq7pIqi8+JsAa9HQ0=;
 b=zUV9ipXskh5vlZpXFacyOfxZn7YXWWbim7bN2B7pES1kiv0Y5TWSKc6KkT+DJH/XJOapPuP7UuUXhCBPH36ogrF6HIJ15hpq5XMYZCTkS48s6FnsiWdYI3rB3zmI0yxDzQozIYXBcpZWljBSXOfQs/t5TCFxo/kbZ/5LLXZqVr0=
Received: from CH0PR13CA0027.namprd13.prod.outlook.com (2603:10b6:610:b1::32)
 by SA1PR12MB8162.namprd12.prod.outlook.com (2603:10b6:806:33a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 15:54:27 +0000
Received: from CH01EPF000BE948.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::1e) by CH0PR13CA0027.outlook.office365.com
 (2603:10b6:610:b1::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 15:54:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE948.mail.protection.outlook.com (10.167.244.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 15:54:26 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 09:54:25 -0600
From: David Francis <David.Francis@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: David Francis <David.Francis@amd.com>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>, Christian Koenig <christian.koenig@amd.com>,
 Simona Vetter <simona.vetter@ffwll.ch>
Subject: [PATCH v3] drm/gem: Fix and enable CHANGE_HANDLE
Date: Tue, 3 Nov 2026 10:54:11 -0500
Message-ID: <20261103155411.3305376-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE948:EE_|SA1PR12MB8162:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bff37f0-245a-4115-7405-08df39c2bcaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|6133799003|10067099003|261102123227099003|18002099003|261102130727099003|13003099007|56012099006|11063799006|261021121427099003|261026140227099003|261022105027099003|261026121527099003|261009223027099003|261028144727099003|261009221227099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: ifyXrRG7aHwcERdpbdaxUW2NZkW8WyaYmOlj0CE6rfEuwhd4423PQEaanDQkaufev/LhK5FlTBHl5b0u1F+U5l06gIZ6/dzERCZFYAqPhL595aHbWooxNwbd3a7y306XgBJiQFND9jhL3KUB117tVuvZXzroAjey0kDOwXGNnAxUyNsw4LF2nc/+CkVYZ0HkDzVeD2hDVh+5qjYMt5vM9lds2fxeIMMNeea91txmJ+xLKbHkw7lHZTqVifNcJbOSwSZnAQmtmzEgcBdSnT1jAqMSDs7wghdz8/xmct0rubfnVrG84U6v3w8iTmyfR2+bpXwm924Uq7kxp6J7E6Oxr+PBCxl2pqVBmbSBVhwCiQDqKJ+crHCKxPo5RMR4E0uib35c+u88mJmEaGSr2QejmhSNipySdTLYIjomMhROsQw+kwnj6s7HtwGUmWUqB1+Ef9FfDtAN3sOREoKr36uoaIXwiTgHDOujxOV3AhF0V0anoOwDXQ9X1xg6G0gEI71Anki/Tk9FSoJp9fFsevY4eHbEy03OBEWG67tO82l7ZzFwf6RERwZ+Cta3XT3Oee8pjpu++srmCZutd3XqLo/smYA4irFw1mwa8bPLTKWz3Ocg4bnHpsUvhdDecTsvTcvKdS1B+AOaX2azsW1ucvTJIdoi2MVs1zZlULlRPLoTsXg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(6133799003)(10067099003)(261102123227099003)(18002099003)(261102130727099003)(13003099007)(56012099006)(11063799006)(261021121427099003)(261026140227099003)(261022105027099003)(261026121527099003)(261009223027099003)(261028144727099003)(261009221227099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SsPznjATiGzjG5XcJ2EJm7H9NIX6E7eLMh8picRWdI2aDMy5bQi5nf5AU8KrQCQcndIl9aBpiyioJr9G7ewC3RwJGnASIZrAd/zDwg4+F9PPQo/N/X0J0OMp9Pb3jBW0/Y0Far++B0hQ57nd9O+V+YizyT70D5wuQVfR0pJFHFJpcfYrCyoS8BZLQz0a5ynEwWVnwd+G4hcLS5Kznjo3V1ljkY9x3+UQNjpWHnmrxndTLWhMJWXsAVMloyTU+ypq1rOwA+F4U9FgQxzhB9Et19uoOvTp2v2VGkVqzz1vorYQc4u+s2OuN1C5ahMc0zsLs0W4DIgolZ5ea+byKx54+7PVwnrBdXa+SgxIKZEThZ4216nWb+u6diRZdLB5smtUqFQfBc9I5Zpwb+YV7CqVI3RMSqR2cKCdDZ8+Pr/jgdPdHl4sgmN75EPFEW8GWkU6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 15:54:26.1390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bff37f0-245a-4115-7405-08df39c2bcaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE948.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8162
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

Make the following changes to CHANGE_HANDLE
- reject new_handle = old_handle with -EINVAL
- idr_preload before idr_alloc
- reject new_handle = 0 with -EINVAL
and re-enable it.

These changes are prerequisities for the enabling of this ioctl, which was
disabled over security concerns and the lack of IGT tests.

For a summary of the saga so far, see
https://lists.freedesktop.org/archives/dri-devel/2026-June/571890.html

I hope these changes leave the ioctl in a spot where it is safe to
re-enable. There are now igt tests covering all corner case behaviour
and race conditions between change_handle and itself, create, free,
import, and export.

The new_handle = 0 and new_handle = old_handle corner cases
are now -EINVAL as recommended; these are covered in the igt tests.

idr_preload is now correctly called before idr_alloc.

With these changes the TODO can be removed and the ioctl can be
re-enabled.

Accompanying IGT patch on igt-dev is
tests/intel: Add edge case and race condition tests for GEM_CHANGE_HANDLE

v2: new_handle = old_handle is EINVAL
v3: More detailed commit message and some cleanup

cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
cc: Christian Koenig <christian.koenig@amd.com>
cc: Simona Vetter <simona.vetter@ffwll.ch>
Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/drm_gem.c   | 30 ++++++++++--------------------
 drivers/gpu/drm/drm_ioctl.c |  3 +--
 2 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 6a86bd2a0343e..bb55715e8d170 100644
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
@@ -1041,21 +1028,22 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
 	if (!drm_core_check_feature(dev, DRIVER_GEM))
 		return -EOPNOTSUPP;
 
-	/* idr_alloc() limitation. */
-	if (args->new_handle > INT_MAX)
-		return -EINVAL;
 	new_handle = args->new_handle;
 
-	if (args->handle == new_handle)
-		return 0;
+	/* idr_alloc() limitations. */
+	if (new_handle == 0 || new_handle > INT_MAX ||
+	    args->handle == new_handle)
+		return -EINVAL;
 
 	mutex_lock(&file_priv->prime.lock);
+	idr_preload(GFP_KERNEL);
 	spin_lock(&file_priv->table_lock);
-	ret = idr_alloc(&file_priv->object_idr, NULL, new_handle, new_handle + 1,
-			GFP_NOWAIT);
+	ret = idr_alloc(&file_priv->object_idr, NULL, new_handle,
+			new_handle + 1, GFP_NOWAIT);
 
 	if (ret < 0) {
 		spin_unlock(&file_priv->table_lock);
+		idr_preload_end();
 		goto out_unlock;
 	}
 
@@ -1063,10 +1051,12 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
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
index e2df4becce629..ff193155129e7 100644
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

