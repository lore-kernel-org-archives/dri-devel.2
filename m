Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C7CF54AD7
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 16:32:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22C2C10E111;
	Tue, 24 Mar 2026 16:32:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5fqjrCVg";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010000.outbound.protection.outlook.com [52.101.201.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBE8210E61D
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 16:32:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=usQ1m6yRTGT/tz7ZF3P4mVuy/PXjeC7soXjRRi/m+nEhH5za2TmLrlOwIb6O8TzWkUmWXCMRLo3WI1od7WHQ/bJZnocIX1k+no5K1kpIZtK5rVuRQpF3G5rAmDmHiYildlnP8Q+Wi+0iFy5kdyMqyK3MThlFXS4xmAGqV9dxrEbuS2GO14/QQgh7NHLjFSACROjpXhWDMHY0Kx3FGnvGEg9jMvRbFHkgkV1hxOVgt4eNnKFb3kcaHMWmOFN/c+7NqCbCcXsyAjMVhI+1oSpfjPg51CYuswFznKSZdkIUpL4yu+hVZswaZhHQOkHznUlVUaZTIsC/j09n8LBk8tE/yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkB1FmZYZvQtqsPRZfucaLrnPuqekLPgJD2KhdXtBeM=;
 b=g6PddpxZ2BVfkYi71UN6AszWzSvgL+gn08RR4Nsf780hfivq9GwB3WnHqUz6VvbxNyVdfT/YizbW/Sk5wFZyCniC9w7IJELRH7WUdaAOlUOEhjgCbaCmaWF7ciXnlrJOJWG6tagVswhLcZwu4Mv0KYKYCUHrEVobwLrpnTBAsxLGcGgMDEbimk434Mjq5bEEQQGqGh/lkOSU7wSdNseNm8vsuCd959WtgumEpFl0yletyRthciNKATfj3Wnp82+KP1VXrAlbBf1RWuD0Mz82TTl5g78xARQ5zhUf2hAVae7jVJt6r+QKJlsHwtZQGk/ao/jPRIA4uhvJRw5Y+oIGVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkB1FmZYZvQtqsPRZfucaLrnPuqekLPgJD2KhdXtBeM=;
 b=5fqjrCVgrXtKI9Je3N+WlEoPa8mwrAKUZlzhQ4Ul+3nxwgg3YG/tmQjXr3CK5Q3T7YYJPrAN1GULK6cyniyyieoSwvvPii39vKtt2a4s1KpN3ORR7JLiC9W/S6R1EgWjGB19zxV638buvdfEHo5ke3GDL9QihDJiZgTjL9L18/g=
Received: from MN0P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::18)
 by CH2PR12MB4278.namprd12.prod.outlook.com (2603:10b6:610:ab::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 16:32:01 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::f) by MN0P220CA0024.outlook.office365.com
 (2603:10b6:208:52e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 16:31:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 16:32:01 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Mar
 2026 11:32:01 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 24 Mar 2026 11:32:00 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <maciej.falkowski@linux.intel.com>
CC: Max Zhen <max.zhen@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>, Lizhi Hou <lizhi.hou@amd.com>
Subject: [PATCH V1] accel/amdxdna: Add per-process BO memory usage query
 support
Date: Tue, 24 Mar 2026 09:31:59 -0700
Message-ID: <20260324163159.2425461-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|CH2PR12MB4278:EE_
X-MS-Office365-Filtering-Correlation-Id: 6191eb1e-8669-4432-cb23-08de89c2e062
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 92OL85xAcOz3j2U+tx9j7mSwf0sriHqelGMTQbXbRRJdSK/F3F6mgWvxfZJ8V/YLZXUMlYXub8LB76Bf/A9nW0DkwMI+CPMet0dfhynM0DJszgf4Ol6hLgeIS6/YkesI0c12HXTprwhWh3m4Nue6l3VGXHn8n55CkH96oyCvwkOY8bJZSdtDnq3hzpCPMbXDbC5yOXbKrck/GqPuab2IrpfIuVkIfs+STxon72ZtX7yTUi9Eav8h2wpawIAGK6YKsydXNQgg8tqBIFAt2upebpT+7dl7OqQL6JqI8oxIsdnwIaRyrz5xDaAh7JcEuD3hbmSxskj3OFmPOsD+z8hDkbwbYPGI0XzgrA7xFggYlhmKaBiMjwphOgi9YpyhHnd9olaO1OfhOj8KmRJiUpVRRWpGxdyIeUjtUXgsCsoLJLyjihs2svdRA9lceJohd/DtLiazCjwjhRZt3MYTR8uYBASV/FwDZXDphC24wm/rmG6qH40rk9xfEgq9a0fLNV9M1EJR8YHwx/RIVC6WmO7/4V6Lbj+STWk5cHzoBJeZtQ4D6sIWDLCbS89o6s8zZtMeIY593SxOI/34ol8uStEw894qjbL/ChaLXuPGBc/t4f1dxllzEBIaI/ujOILETs8S//bTJRj6/ceHczovmsXcwdhQu4LmiIvDNsC4HAdqmoHgoFJh8fbWgxPsIZg684DR/VEOJGrCiNDrEZaynqA7Y2T5SDNPuDVpuFQFk1L5OD9TnkrVMPXXWq92I+wo6a7yjxIcjvT3SxSCIac9WDs6Uw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QrVziY8TDLaTJGdLQuq7TEW8kZkHoJyQjNVI8yQocBJs0QNXhuzXs2EJaqHtsnx6EITTAj7BpKfoZZwZcYhHNg9K9I8Mw8e6GGhxRByahhVsXqn1kg3LxZg2pXEGY+nm/+tjLzNs1J+WWrSyemrRsEZ6q/T/RX18E/3gQEauwX0cWTPpLcEu3V8QmoD2dSqMw1nrI93eCYgKgCEeyVQMm/xnldiX6VNVes0N1eJSgRMBZ0vV3fIfupAlUyQdTPQUxEaUyZtNYm79z/Ccf3W/XvErKe3U8tJEZOc88lHo84uEg9eUIqgS9es43lp3OSEMbtZpq43NCB+GJqa4HIBSW0iMdGXvOezD/n8LhKzDrAF4D3Kf8WyqtgHQaDMywQJ3zvDan3kwgRPH5zMP3VcWJnphO/S89+dC/FT20HQ7Tz7a7KLab+ooOoLb7F6DYD0s
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 16:32:01.4014 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6191eb1e-8669-4432-cb23-08de89c2e062
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4278
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

From: Max Zhen <max.zhen@amd.com>

Add support for querying per-process buffer object (BO) memory
usage through the amdxdna GET_ARRAY UAPI.

Introduce a new query type, DRM_AMDXDNA_BO_USAGE, along with
struct amdxdna_drm_bo_usage to report BO memory usage statistics,
including heap, total, and internal usage.

Track BO memory usage on a per-client basis by maintaining counters
in GEM open/close and heap allocation/free paths. This ensures the
reported statistics reflect the current memory footprint of each
process.

Wire the new query into the GET_ARRAY implementation to expose
the usage information to userspace.

Signed-off-by: Max Zhen <max.zhen@amd.com>
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie2_pci.c        |   4 +
 drivers/accel/amdxdna/amdxdna_gem.c     | 134 ++++++++++++++++++++++--
 drivers/accel/amdxdna/amdxdna_gem.h     |   7 +-
 drivers/accel/amdxdna/amdxdna_pci_drv.c |   6 +-
 drivers/accel/amdxdna/amdxdna_pci_drv.h |   4 +
 include/uapi/drm/amdxdna_accel.h        |  35 +++++++
 6 files changed, 177 insertions(+), 13 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
index 9e39bfe75971..f1ac4e00bd9f 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -865,6 +865,7 @@ static int aie2_hwctx_status_cb(struct amdxdna_hwctx *hwctx, void *arg)
 	tmp->command_submissions = hwctx->priv->seq;
 	tmp->command_completions = hwctx->priv->completed;
 	tmp->pasid = hwctx->client->pasid;
+	tmp->heap_usage = hwctx->client->heap_usage;
 	tmp->priority = hwctx->qos.priority;
 	tmp->gops = hwctx->qos.gops;
 	tmp->fps = hwctx->qos.fps;
@@ -1148,6 +1149,9 @@ static int aie2_get_array(struct amdxdna_client *client,
 	case DRM_AMDXDNA_HW_LAST_ASYNC_ERR:
 		ret = aie2_get_array_async_error(xdna->dev_handle, args);
 		break;
+	case DRM_AMDXDNA_BO_USAGE:
+		ret = amdxdna_drm_get_bo_usage(&xdna->ddev, args);
+		break;
 	default:
 		XDNA_ERR(xdna, "Not supported request parameter %u", args->param);
 		ret = -EOPNOTSUPP;
diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index 27712704e42d..238ee244d4a6 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -63,6 +63,8 @@ amdxdna_gem_heap_alloc(struct amdxdna_gem_obj *abo)
 		goto unlock_out;
 	}
 
+	client->heap_usage += mem->size;
+
 	drm_gem_object_get(to_gobj(heap));
 
 unlock_out:
@@ -74,16 +76,17 @@ amdxdna_gem_heap_alloc(struct amdxdna_gem_obj *abo)
 static void
 amdxdna_gem_heap_free(struct amdxdna_gem_obj *abo)
 {
+	struct amdxdna_client *client = abo->client;
 	struct amdxdna_gem_obj *heap;
 
-	mutex_lock(&abo->client->mm_lock);
+	mutex_lock(&client->mm_lock);
 
 	drm_mm_remove_node(&abo->mm_node);
-
-	heap = abo->client->dev_heap;
+	client->heap_usage -= abo->mem.size;
+	heap = client->dev_heap;
 	drm_gem_object_put(to_gobj(heap));
 
-	mutex_unlock(&abo->client->mm_lock);
+	mutex_unlock(&client->mm_lock);
 }
 
 static struct amdxdna_gem_obj *
@@ -102,6 +105,8 @@ amdxdna_gem_create_obj(struct drm_device *dev, size_t size)
 	abo->mem.dma_addr = AMDXDNA_INVALID_ADDR;
 	abo->mem.uva = AMDXDNA_INVALID_ADDR;
 	abo->mem.size = size;
+	abo->open_ref = 0;
+	abo->internal = false;
 	INIT_LIST_HEAD(&abo->mem.umap_list);
 
 	return abo;
@@ -508,13 +513,55 @@ static void amdxdna_imported_obj_free(struct amdxdna_gem_obj *abo)
 	kfree(abo);
 }
 
+static inline bool
+amdxdna_gem_skip_bo_usage(struct amdxdna_gem_obj *abo)
+{
+	/* Do not count imported BOs since the buffer is not allocated by us. */
+	if (is_import_bo(abo))
+		return true;
+
+	/* Already counted as part of HEAP BO */
+	if (abo->type == AMDXDNA_BO_DEV)
+		return true;
+
+	return false;
+}
+
+static void
+amdxdna_gem_add_bo_usage(struct amdxdna_gem_obj *abo)
+{
+	struct amdxdna_client *client = abo->client;
+
+	if (amdxdna_gem_skip_bo_usage(abo))
+		return;
+
+	guard(mutex)(&client->mm_lock);
+
+	client->total_bo_usage += abo->mem.size;
+	if (abo->internal)
+		client->total_int_bo_usage += abo->mem.size;
+}
+
+static void
+amdxdna_gem_del_bo_usage(struct amdxdna_gem_obj *abo)
+{
+	struct amdxdna_client *client = abo->client;
+
+	if (amdxdna_gem_skip_bo_usage(abo))
+		return;
+
+	guard(mutex)(&client->mm_lock);
+
+	client->total_bo_usage -= abo->mem.size;
+	if (abo->internal)
+		client->total_int_bo_usage -= abo->mem.size;
+}
+
 static void amdxdna_gem_obj_free(struct drm_gem_object *gobj)
 {
 	struct amdxdna_dev *xdna = to_xdna_dev(gobj->dev);
 	struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
 
-	XDNA_DBG(xdna, "BO type %d xdna_addr 0x%llx", abo->type, amdxdna_gem_dev_addr(abo));
-
 	amdxdna_hmm_unregister(abo, NULL);
 	flush_workqueue(xdna->notifier_wq);
 
@@ -543,9 +590,13 @@ static int amdxdna_gem_obj_open(struct drm_gem_object *gobj, struct drm_file *fi
 	int ret;
 
 	guard(mutex)(&abo->lock);
+	abo->open_ref++;
 
-	if (!abo->client)
+	if (abo->open_ref == 1) {
+		/* Attached to the client when first opened by it. */
 		abo->client = filp->driver_priv;
+		amdxdna_gem_add_bo_usage(abo);
+	}
 	if (amdxdna_iova_on(xdna)) {
 		ret = amdxdna_iommu_map_bo(xdna, abo);
 		if (ret)
@@ -555,6 +606,20 @@ static int amdxdna_gem_obj_open(struct drm_gem_object *gobj, struct drm_file *fi
 	return 0;
 }
 
+static void amdxdna_gem_obj_close(struct drm_gem_object *gobj, struct drm_file *filp)
+{
+	struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
+
+	guard(mutex)(&abo->lock);
+	abo->open_ref--;
+
+	if (abo->open_ref == 0) {
+		amdxdna_gem_del_bo_usage(abo);
+		/* Detach from the client when last closed by it. */
+		abo->client = NULL;
+	}
+}
+
 static int amdxdna_gem_dev_obj_vmap(struct drm_gem_object *obj, struct iosys_map *map)
 {
 	struct amdxdna_gem_obj *abo = to_xdna_obj(obj);
@@ -575,6 +640,7 @@ static const struct drm_gem_object_funcs amdxdna_gem_dev_obj_funcs = {
 static const struct drm_gem_object_funcs amdxdna_gem_shmem_funcs = {
 	.free = amdxdna_gem_obj_free,
 	.open = amdxdna_gem_obj_open,
+	.close = amdxdna_gem_obj_close,
 	.print_info = drm_gem_shmem_object_print_info,
 	.pin = drm_gem_shmem_object_pin,
 	.unpin = drm_gem_shmem_object_unpin,
@@ -708,10 +774,13 @@ amdxdna_drm_create_share_bo(struct drm_device *dev,
 	if (IS_ERR(abo))
 		return ERR_CAST(abo);
 
-	if (args->type == AMDXDNA_BO_DEV_HEAP)
+	if (args->type == AMDXDNA_BO_DEV_HEAP) {
 		abo->type = AMDXDNA_BO_DEV_HEAP;
-	else
+		abo->internal = true;
+	} else {
 		abo->type = AMDXDNA_BO_SHARE;
+		abo->internal = args->type == AMDXDNA_BO_CMD;
+	}
 
 	return abo;
 }
@@ -783,6 +852,11 @@ amdxdna_drm_create_dev_bo(struct drm_device *dev,
 	gobj = to_gobj(abo);
 	gobj->funcs = &amdxdna_gem_dev_obj_funcs;
 	abo->type = AMDXDNA_BO_DEV;
+	abo->internal = true;
+	/*
+	 * DEV BOs cannot be alive when client is gone, it's OK to
+	 * always establish the connection.
+	 */
 	abo->client = client;
 
 	ret = amdxdna_gem_heap_alloc(abo);
@@ -826,7 +900,7 @@ int amdxdna_drm_create_bo_ioctl(struct drm_device *dev, void *data, struct drm_f
 	if (IS_ERR(abo))
 		return PTR_ERR(abo);
 
-	/* ready to publish object to userspace */
+	/* Ready to publish object to userspace and count for BO usage. */
 	ret = drm_gem_handle_create(filp, to_gobj(abo), &args->handle);
 	if (ret) {
 		XDNA_ERR(xdna, "Create handle failed");
@@ -986,3 +1060,43 @@ int amdxdna_drm_sync_bo_ioctl(struct drm_device *dev,
 	drm_gem_object_put(gobj);
 	return ret;
 }
+
+int amdxdna_drm_get_bo_usage(struct drm_device *dev, struct amdxdna_drm_get_array *args)
+{
+	size_t min_sz = min(args->element_size, sizeof(struct amdxdna_drm_bo_usage));
+	char __user *buf = u64_to_user_ptr(args->buffer);
+	struct amdxdna_dev *xdna = to_xdna_dev(dev);
+	struct amdxdna_client *tmp_client;
+	struct amdxdna_drm_bo_usage tmp;
+
+	drm_WARN_ON(dev, !mutex_is_locked(&xdna->dev_lock));
+
+	if (args->num_element != 1)
+		return -EINVAL;
+
+	if (copy_from_user(&tmp, buf, min_sz))
+		return -EFAULT;
+
+	if (!tmp.pid)
+		return -EINVAL;
+
+	tmp.total_usage = 0;
+	tmp.internal_usage = 0;
+	tmp.heap_usage = 0;
+
+	list_for_each_entry(tmp_client, &xdna->client_list, node) {
+		if (tmp.pid != tmp_client->pid)
+			continue;
+
+		mutex_lock(&tmp_client->mm_lock);
+		tmp.total_usage += tmp_client->total_bo_usage;
+		tmp.internal_usage += tmp_client->total_int_bo_usage;
+		tmp.heap_usage += tmp_client->heap_usage;
+		mutex_unlock(&tmp_client->mm_lock);
+	}
+
+	if (copy_to_user(buf, &tmp, min_sz))
+		return -EFAULT;
+
+	return 0;
+}
diff --git a/drivers/accel/amdxdna/amdxdna_gem.h b/drivers/accel/amdxdna/amdxdna_gem.h
index a77d9344f8a4..4fc48a1189d2 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.h
+++ b/drivers/accel/amdxdna/amdxdna_gem.h
@@ -41,8 +41,9 @@ struct amdxdna_gem_obj {
 	struct amdxdna_client		*client;
 	u8				type;
 	bool				pinned;
-	struct mutex			lock; /* Protects: pinned, mem.kva */
+	struct mutex			lock; /* Protects: pinned, mem.kva, open_ref */
 	struct amdxdna_mem		mem;
+	int				open_ref;
 
 	/* Below members are initialized when needed */
 	struct drm_mm			mm; /* For AMDXDNA_BO_DEV_HEAP */
@@ -50,6 +51,9 @@ struct amdxdna_gem_obj {
 	u32				assigned_hwctx;
 	struct dma_buf			*dma_buf;
 	struct dma_buf_attachment	*attach;
+
+	/* True, if BO is managed by XRT, not application */
+	bool				internal;
 };
 
 #define to_gobj(obj)    (&(obj)->base.base)
@@ -98,5 +102,6 @@ void amdxdna_gem_unpin(struct amdxdna_gem_obj *abo);
 int amdxdna_drm_create_bo_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
 int amdxdna_drm_get_bo_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
 int amdxdna_drm_sync_bo_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
+int amdxdna_drm_get_bo_usage(struct drm_device *dev, struct amdxdna_drm_get_array *args);
 
 #endif /* _AMDXDNA_GEM_H_ */
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
index d83be00daf2b..b50a7d1f8a11 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
@@ -36,9 +36,10 @@ MODULE_FIRMWARE("amdnpu/17f0_11/npu_7.sbin");
  * 0.5: Support getting telemetry data
  * 0.6: Support preemption
  * 0.7: Support getting power and utilization data
+ * 0.8: Support BO usage query
  */
 #define AMDXDNA_DRIVER_MAJOR		0
-#define AMDXDNA_DRIVER_MINOR		7
+#define AMDXDNA_DRIVER_MINOR		8
 
 /*
  * Bind the driver base on (vendor_id, device_id) pair and later use the
@@ -120,11 +121,12 @@ static void amdxdna_client_cleanup(struct amdxdna_client *client)
 	amdxdna_hwctx_remove_all(client);
 	xa_destroy(&client->hwctx_xa);
 	cleanup_srcu_struct(&client->hwctx_srcu);
-	mutex_destroy(&client->mm_lock);
 
 	if (client->dev_heap)
 		drm_gem_object_put(to_gobj(client->dev_heap));
 
+	mutex_destroy(&client->mm_lock);
+
 	if (!IS_ERR_OR_NULL(client->sva))
 		iommu_sva_unbind_device(client->sva);
 	mmdrop(client->mm);
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
index e91d14ae5190..0661749917d6 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
@@ -138,6 +138,10 @@ struct amdxdna_client {
 	struct iommu_sva		*sva;
 	int				pasid;
 	struct mm_struct		*mm;
+
+	size_t				heap_usage;
+	size_t				total_bo_usage;
+	size_t				total_int_bo_usage;
 };
 
 #define amdxdna_for_each_hwctx(client, hwctx_id, entry)		\
diff --git a/include/uapi/drm/amdxdna_accel.h b/include/uapi/drm/amdxdna_accel.h
index bddaaaf945cf..61d3686fa3b1 100644
--- a/include/uapi/drm/amdxdna_accel.h
+++ b/include/uapi/drm/amdxdna_accel.h
@@ -591,8 +591,37 @@ struct amdxdna_async_error {
 	__u64 ex_err_code;
 };
 
+/**
+ * struct amdxdna_drm_bo_usage - all types of BO usage
+ * BOs managed by XRT/SHIM/driver is counted as internal.
+ * Others are counted as external which are managed by applications.
+ *
+ * Among all types of BOs:
+ *   AMDXDNA_BO_DEV_HEAP - is counted for internal.
+ *   AMDXDNA_BO_SHARE    - is counted for external.
+ *   AMDXDNA_BO_CMD      - is counted for internal.
+ *   AMDXDNA_BO_DEV      - is counted by heap_usage only, not internal
+ *                         or external. It does not add to the total memory
+ *                         footprint since its mem comes from heap which is
+ *                         already counted as internal.
+ */
+struct amdxdna_drm_bo_usage {
+	/** @pid: The ID of the process to query from. */
+	__s64 pid;
+	/** @total_usage: Total BO size used by process. */
+	__u64 total_usage;
+	/** @internal_usage: Total internal BO size used by process. */
+	__u64 internal_usage;
+	/** @heap_usage: Total device BO size used by process. */
+	__u64 heap_usage;
+};
+
+/*
+ * Supported params in struct amdxdna_drm_get_array
+ */
 #define DRM_AMDXDNA_HW_CONTEXT_ALL	0
 #define DRM_AMDXDNA_HW_LAST_ASYNC_ERR	2
+#define DRM_AMDXDNA_BO_USAGE		6
 
 /**
  * struct amdxdna_drm_get_array - Get information array.
@@ -605,6 +634,12 @@ struct amdxdna_drm_get_array {
 	 *
 	 * %DRM_AMDXDNA_HW_CONTEXT_ALL:
 	 * Returns all created hardware contexts.
+	 *
+	 * %DRM_AMDXDNA_HW_LAST_ASYNC_ERR:
+	 * Returns last async error.
+	 *
+	 * %DRM_AMDXDNA_BO_USAGE:
+	 * Returns usage of heap/internal/external BOs.
 	 */
 	__u32 param;
 	/**
-- 
2.34.1

