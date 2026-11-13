Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204A5606A32E
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 15:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NiwwlItE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D67810E7FE;
	Fri, 13 Nov 2026 15:02:52 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011059.outbound.protection.outlook.com
 [40.93.194.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE5DF10E534
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 15:02:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RX5HwiQE4EJ+Q12n/lM3bYZ7A27Y973sCbXMXxnwJ9O/UyK3R1IodNlanbV+pspo5d9iBQ1YrcVto1HzzPdRVzPCPuZegAQ3pM8mfqLg4K1UzejxLNJB+Q1ZNj0UVpPHacpJm1yDmuJhCGRQYuppAsYaLZkkHmVnaHFFP+Nr4l3vsS8ctJye0Y7VD63RVrYF6r5BX2ReJ4y1u/5A9rffLcFRIj3vFw8AH9oFp5VU6wRUQezhlKAafXuvlA5Wnaw1jVa31evj8dTz3ao1Hmo7t6/mAqV+zhICcGUS+gaE4k2TZuuzwQx7Wgmcbw61NeKDsaXPNsIQYu3ApfXYsST52Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSvENbgjI43OC4Sxk01wFlj0JH6lvtPe1w9HRny+Tr8=;
 b=ekfkbVUrxxmIayDcZEdmUheCaHor8TkiVU8YGKsYTDjHYPadz43GMw+XFwgb8cTMaAQA0zskDq9JHbzS0A5s39cjkGp+0eoar8l+PfC2/wTrDHmf1qc6qbNFHfFkt5i1f7/E7xRAoxcMNSYBjR5hP00zyzKhcSAGK/vF2c47jlgkNtMUY/sgMHKpK1aMMdazWeSSR/vlZYs5slu+M0axSagfSjXuaEIJNKTjO+ZImI62lNQyhoO9rgiDs0u2ZZKgRddGR/2eVCrGrMsbzwStwola7u6ZoL5ab0Odk/IUU01PzpxgfjXAaGx63XNOsufHpFUROTgltotrulsysJBQPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSvENbgjI43OC4Sxk01wFlj0JH6lvtPe1w9HRny+Tr8=;
 b=NiwwlItEKx/BCLUe+8Sddb0B/1GHccF4vEohJ+pd+0qqhHfsClGZks5Evt52hKxe5LXuSDPnuIuFZuaLul3NBbtsUdoPm2dTslnxoniBUZSdwPzbDc0Rf3YvzII81yzuFa3GhO6ikYm71F5z39xp+6xSq/d0PX/UQJDTGY7Aiqw=
Received: from DS7PR03CA0302.namprd03.prod.outlook.com (2603:10b6:8:2b::11) by
 CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.9; Fri, 13 Nov 2026 15:02:42 +0000
Received: from DS2PEPF00007108.namprd05.prod.outlook.com
 (2603:10b6:8:2b:cafe::19) by DS7PR03CA0302.outlook.office365.com
 (2603:10b6:8:2b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Fri, 13
 Nov 2026 15:02:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00007108.mail.protection.outlook.com (10.167.23.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 15:02:41 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 13 Nov
 2026 09:02:40 -0600
From: David Francis <David.Francis@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: David Francis <David.Francis@amd.com>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>, Christian Koenig <christian.koenig@amd.com>,
 Simona Vetter <simona.vetter@ffwll.ch>
Subject: [PATCH v4] drm/gem: Fix and enable CHANGE_HANDLE
Date: Fri, 13 Nov 2026 10:02:26 -0500
Message-ID: <20261113150226.1123441-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00007108:EE_|CYXPR12MB9320:EE_
X-MS-Office365-Filtering-Correlation-Id: 920f18ff-7f42-45a2-f49d-08df41972a35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|10067099003|11063799006|56012099006|261022105027099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261021123027099003|261102130727099003|261102123227099003|261009223027099003|261009221227099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: Vms6Xw7jr2AM5zIHiDXHfExnDXpjt68kCcI0usfNfiWirHMK6bsEQpy2GYZTabMNHq0UnERTRmUBhAME0Dy42ReOIMQrUheNvkeDtklxzynEdHkhc14WFs8uCrYsprwM6nyZ2wGRXqoLORrsRhozX9lDr+PlH+IwzWV7xKNBzmtgnV8MHkl+R8pN5xLTNK0MD4cKZYP2PqLnt7q2quaiLKJdTNmqsWvCi34dxmBQe3R0v1/GOwCuq+j4L2AtFfX/IVZNU7P8XDMyAaat6a0BBv7d1BefSWSpXwYppAx20picqRWDxEYpl2bngEKVykLSzegJEqZ8fy6jseLvxFJtzzhPQyp1KtkGTRhJwrsdJkatXNqQAW89WuXpq3FE8d4v13hNXpwt/nsVi9YGZap0evPsuTzDjIKS78/PCJWd9p4mVZz4jLgI7J+tf4/Hza9z/V+KnPrSg86oCr7RWnd99VYTLN+DHoC1Bu7BwFo167O8NJx3gcJtI/IDlcbzpkMQVVIJhEFCsQ69DqwGcE246XNmtUl7qlF5NfN4RU7ZAHpG4WmerOTgU5iRRqPnocfRfHNkqkBM14qYPuLLkOxqVv4K9c8hT2dxw4ujZmGLPquVLarKZ/2OEwQ2q5GP/lDAE5aSkA5XN44+jvTSV/qpGPZg0l41oHCxO3F5xdMVfo4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(261022105027099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261102130727099003)(261102123227099003)(261009223027099003)(261009221227099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: n1JNWzSD9zt/PIAt6tQGqPJG8rXvhC0BbE7S+tjMwf9WZYM8tVCooQKvhxzGlCovcQ3y/rr3a1FVT0ayijkgQwPI1iFIYJ/IOUkovdNRK0x7e0+5eY0guKkgmkx8xkFeH83HgAGFQLHN9+RKGwAj/+ruqFF9eL6TXDHuNdVE7Yz2Kb8vN8XqczqjJuz9RkkiQzADoxkmhunVh331zJSjKPtsFCwJo0USdiNNxo6Pvf9m2fljpT6gViaTOlRiCdaO0hD3PDiOgmqCJHgIQ+YIhAg1zhO7YbfFnMaGCtBkTq+uFz3D82+pVg5mBYpvp1C4b7qUM7kRKJ18noD7ErH+qTyjp9Z4maSiYUCilfL5Rj/WuuRguHPWCv5cAIZeU1jElZzwmXWxm9kImwdQ+5D6QdswInvTzSRP6A6IXlk+q59nyj7inu2ESDX+ZI1wTAxN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 15:02:41.3567 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 920f18ff-7f42-45a2-f49d-08df41972a35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00007108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9320
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

And the new handle being taken is now EBUSY instead of ENOENT.

With these changes the TODO can be removed and the ioctl can be
re-enabled.

Accompanying IGT patch on igt-dev (currently at v4) is
tests/intel: Add edge case and race condition tests for GEM_CHANGE_HANDLE

v2: new_handle = old_handle is EINVAL
v3: More detailed commit message and some cleanup
v4: New handle taken is now EBUSY instead of ENOSPC

cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
cc: Christian Koenig <christian.koenig@amd.com>
cc: Simona Vetter <simona.vetter@ffwll.ch>
Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/drm_gem.c   | 33 ++++++++++++---------------------
 drivers/gpu/drm/drm_ioctl.c |  3 +--
 2 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 6a86bd2a0343..0c64170f7d61 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1018,44 +1018,33 @@ drm_gem_open_ioctl(struct drm_device *dev, void *data,
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
 	struct drm_gem_change_handle *args = data;
 	struct drm_gem_object *obj;
-	int new_handle, ret;
+	int ret;
+	u32 new_handle;
 
 	if (!drm_core_check_feature(dev, DRIVER_GEM))
 		return -EOPNOTSUPP;
 
-	/* idr_alloc() limitation. */
-	if (args->new_handle > INT_MAX)
-		return -EINVAL;
 	new_handle = args->new_handle;
 
-	if (args->handle == new_handle)
-		return 0;
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
+		ret = -EBUSY;
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

