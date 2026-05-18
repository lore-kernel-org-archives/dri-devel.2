Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA10CD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 15:57:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AB7B10E929;
	Mon, 18 May 2026 15:57:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fez9jC7h";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010025.outbound.protection.outlook.com [52.101.56.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F06E410E8EB
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 15:57:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CzqB+jQplPr3wyfJ7Kj8+iHScVVIvi4hBqbYpCF4eeVD8/NSU5NYjKDC8tuBmmUSdYvq2lrmR/ocxEYVv3uV+vM6yGYsU5Udgxt6ZnxUzB+X/qM0IbFgqGsVunEWPF7YUcq+8mVV8r9fSrQZ51EKgr5cg/u1Vj0jDyy3uh5ok9wRqOeMiiqdTUFww7rlsyVpHZeJ98qj4kxxK1fIVXhY54mkVunvhCbY7xl83nS/MAV53Qczsp1PJ99Xt6tADE1DCkPwVjU1d0om9oLzvXfK+XA5i6ZEk5DlBA0IxGflzuUuv5cifvyssZSeTC7WCWFiPTSwHQiv1B4b5Is5jBq+IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SW0PQkmHbqIgFVRfYX43j9x3TuCRGG0eNMQOZjIcZe4=;
 b=RsdX53/9MN3AWX42G06nIFr99OwO8frD6OKSrM+2FGi+D/RqdCcQ8JZs5KDRrv02LTQxO4gRjN2dn55m4CLIhtZtjbsfFtVtOW7vri75LT7Rd3zAW20hCvNbtamAR07kn8hiKPpbbbuhD9mLP2DDu2H06Ns5u8C0XgPPvgsskzmL8asdFbJ/IMQmlj6xLLKLHK2/PlOVnJP71fB+geJfcIreJO6xEqRFnlr2r+ok6znZkJDANGUz2IeGX+wu0g4M19S+4Ac/2hy5YqXueWwQNeJR/SaiBLX+xaDoIgil3W6H5FV+epCg+Gdqnl93r+/4F0qSTHcnTZP7i+KYT79i/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SW0PQkmHbqIgFVRfYX43j9x3TuCRGG0eNMQOZjIcZe4=;
 b=fez9jC7hEtHBaBZAu/cgqOkB9Auv2IvNsnpZFcnBplSz3KjV6fiOJDstN3V/ykZEzQckKBg5lQrnjH8Q4PRwAEgB6XAp0+XBdRUoZ8Vi3G62jwJm41S+UqUY9qZqYkFUETuASWHLHp4FChCoxceHibqib+QZlAL5zW9hWFTRmy4=
Received: from CH0PR03CA0058.namprd03.prod.outlook.com (2603:10b6:610:b3::33)
 by PH8PR12MB7254.namprd12.prod.outlook.com (2603:10b6:510:225::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 15:57:29 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::34) by CH0PR03CA0058.outlook.office365.com
 (2603:10b6:610:b3::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 15:57:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 15:57:28 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Mon, 18 May
 2026 10:57:18 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 May
 2026 10:57:18 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 18 May 2026 10:57:17 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <linaro-mm-sig@lists.linaro.org>, <dri-devel@lists.freedesktop.org>,
 <christian.koenig@amd.com>, <simona@ffwll.ch>, <max.zhen@amd.com>,
 <sonal.santan@amd.com>
Subject: [PATCH V2] accel/amdxdna: Remove mmap and export support for ubuf
Date: Mon, 18 May 2026 08:57:05 -0700
Message-ID: <20260518155706.937461-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|PH8PR12MB7254:EE_
X-MS-Office365-Filtering-Correlation-Id: bf5d4738-68a2-4a09-cc10-08deb4f6294b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: XKtVVS8rMdPbZRVTYflLeBdXl9oLebHcgiJuRURjyWJzYhOR12WSBEW8uRYXAOxtXX+xVLbFr2KP76duPNsJT+Ns90TiqO+tRuF5VVKf7ErMhCegN1ZLqmbHHKrw+wCl7vtUfxANY/MfxhWupubqXzMgKDKrV12gWUKnb9AKcrTWiJweLLhnf1r1iWifq8Z63Yq9C+4I690BlkDdvLb43I10A88UysqbQhsZItWMHry5K3SgSbBkGvoRXgOYh3fTYDCfiHskvjzMMrj4RT1zQW0HXuOD9TMXvfrQJmkk/vFe+pz96Vk/dsH6Ap5T4bFXsIUOXhU1Wc9Vz2RZ3YfE/EqExY5ZzjUoMmv7X4hs8K3xvIRFSiOyvY279sEnS3FRprps8AVVweYiDxUsoc3RQHTPJQWx6AZ5GCF/Nr1JDHdrPnr603dOC9Wx77nudkPOGmD7v61iWkW9Su4QCCxNbntaXR+rdJZmaoeOl8HmZz3H6LzyT238dGnfNgcZFbVP1sSHYxwpOoVeaGCGQdPKFN4V7gyXclp29hLqkTyxjhGn2C53Tg4uOXxbmcgl4LseDlnPXcYgiYFb7HUvmt63guClpQ47hO3iDTH3VM67hc2+bielclEcV76PPyRJE07kOJZq4qPRbuYXAeZOlk4qm9nl7IRVkERZ3Hw2JvA+O22HIJ4ZvRJ8njnOCM1K8TCo2pUNn51kn6VIwM7plnzIVkGH15hZJkxK56XHUc4izsg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QujnHfeIiKWoJ/bpxy+0lH6sl8SFi8ThuRp/ni5AQ7TXFBoIRN/PN9o9oHF7JqNFUo+8wgy80wLq/dCHi7GXtiEojMXxAk1iIw5jSmF9uzX2C7lOdFiPwNj72w9b3i1IlLmjZL9A7/Re2GenYp42NSizsye/ffFwct1ZVkJryhdBVkJfA/SPCV54SfjRxiJOSil8g/nXRv6AyKvnUsCce94geYktvAFLOFdvJyg1MXcgsD06RyoSbLVkx/rfJwgQxE8npVdGJSyDGWDRA1noC003yGNw37ByyjhuNBuG4LH+XUEeyjENBIRKvNeLKEUWi70R+O2nF9Q8E+GtCFkk8+1VIXf/llBnWRhKpBQEjpuHqvD0Z/bCG5wP4UhLyLZR08fsGvnrBxZc2lWng5cbBOKt59BM7DntqISfLS67zxJGKXZditOXj/+zrKzHIHWn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 15:57:28.0426 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf5d4738-68a2-4a09-cc10-08deb4f6294b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7254
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

Ubuf pages should not be mmaped or exported. Remove the ubuf mmap callback
and return -EOPNOTSUPP when exporting ubuf objects.

ubuf vmap is also removed for there is not a real use case yet.

Fixes: bd72d4acda10 ("accel/amdxdna: Support user space allocated buffer")
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
v2:
  Remove dead code amdxdna_ubuf_vm_ops structure and amdxdna_ubuf_vm_fault
  function.
  Rename Non-exportable buffer flag from 'pri' to 'private_buffer'

 drivers/accel/amdxdna/amdxdna_gem.c  |  9 ++++-
 drivers/accel/amdxdna/amdxdna_gem.h  |  2 ++
 drivers/accel/amdxdna/amdxdna_ubuf.c | 50 ----------------------------
 3 files changed, 10 insertions(+), 51 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index 319d2064fafa..6b9b556de555 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -492,6 +492,9 @@ static struct dma_buf *amdxdna_gem_prime_export(struct drm_gem_object *gobj, int
 	struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
 	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
 
+	if (abo->private_buffer)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	if (abo->dma_buf) {
 		get_dma_buf(abo->dma_buf);
 		return abo->dma_buf;
@@ -716,6 +719,7 @@ amdxdna_gem_create_ubuf_object(struct drm_device *dev, struct amdxdna_drm_create
 {
 	struct amdxdna_dev *xdna = to_xdna_dev(dev);
 	struct amdxdna_drm_va_tbl va_tbl;
+	struct amdxdna_gem_obj *abo;
 	struct drm_gem_object *gobj;
 	struct dma_buf *dma_buf;
 
@@ -742,7 +746,10 @@ amdxdna_gem_create_ubuf_object(struct drm_device *dev, struct amdxdna_drm_create
 
 	dma_buf_put(dma_buf);
 
-	return to_xdna_obj(gobj);
+	abo = to_xdna_obj(gobj);
+	abo->private_buffer = true;
+
+	return abo;
 }
 
 static struct amdxdna_gem_obj *
diff --git a/drivers/accel/amdxdna/amdxdna_gem.h b/drivers/accel/amdxdna/amdxdna_gem.h
index 4fc48a1189d2..957305ccb485 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.h
+++ b/drivers/accel/amdxdna/amdxdna_gem.h
@@ -54,6 +54,8 @@ struct amdxdna_gem_obj {
 
 	/* True, if BO is managed by XRT, not application */
 	bool				internal;
+	/* True, if BO is not exportable */
+	bool				private_buffer;
 };
 
 #define to_gobj(obj)    (&(obj)->base.base)
diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.c b/drivers/accel/amdxdna/amdxdna_ubuf.c
index 3769210c55cc..bb60fb80467e 100644
--- a/drivers/accel/amdxdna/amdxdna_ubuf.c
+++ b/drivers/accel/amdxdna/amdxdna_ubuf.c
@@ -69,60 +69,10 @@ static void amdxdna_ubuf_release(struct dma_buf *dbuf)
 	kfree(ubuf);
 }
 
-static vm_fault_t amdxdna_ubuf_vm_fault(struct vm_fault *vmf)
-{
-	struct vm_area_struct *vma = vmf->vma;
-	struct amdxdna_ubuf_priv *ubuf;
-	unsigned long pfn;
-	pgoff_t pgoff;
-
-	ubuf = vma->vm_private_data;
-	pgoff = (vmf->address - vma->vm_start) >> PAGE_SHIFT;
-
-	pfn = page_to_pfn(ubuf->pages[pgoff]);
-	return vmf_insert_pfn(vma, vmf->address, pfn);
-}
-
-static const struct vm_operations_struct amdxdna_ubuf_vm_ops = {
-	.fault = amdxdna_ubuf_vm_fault,
-};
-
-static int amdxdna_ubuf_mmap(struct dma_buf *dbuf, struct vm_area_struct *vma)
-{
-	struct amdxdna_ubuf_priv *ubuf = dbuf->priv;
-
-	vma->vm_ops = &amdxdna_ubuf_vm_ops;
-	vma->vm_private_data = ubuf;
-	vm_flags_set(vma, VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
-
-	return 0;
-}
-
-static int amdxdna_ubuf_vmap(struct dma_buf *dbuf, struct iosys_map *map)
-{
-	struct amdxdna_ubuf_priv *ubuf = dbuf->priv;
-	void *kva;
-
-	kva = vmap(ubuf->pages, ubuf->nr_pages, VM_MAP, PAGE_KERNEL);
-	if (!kva)
-		return -EINVAL;
-
-	iosys_map_set_vaddr(map, kva);
-	return 0;
-}
-
-static void amdxdna_ubuf_vunmap(struct dma_buf *dbuf, struct iosys_map *map)
-{
-	vunmap(map->vaddr);
-}
-
 static const struct dma_buf_ops amdxdna_ubuf_dmabuf_ops = {
 	.map_dma_buf = amdxdna_ubuf_map,
 	.unmap_dma_buf = amdxdna_ubuf_unmap,
 	.release = amdxdna_ubuf_release,
-	.mmap = amdxdna_ubuf_mmap,
-	.vmap = amdxdna_ubuf_vmap,
-	.vunmap = amdxdna_ubuf_vunmap,
 };
 
 static int readonly_va_entry(struct amdxdna_drm_va_entry *va_ent)
-- 
2.34.1

