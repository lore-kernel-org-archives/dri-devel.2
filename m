Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B4810F92E6
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 17:26:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5C0E10ED12;
	Tue, 31 Mar 2026 17:26:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GVU8V0Ez";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011039.outbound.protection.outlook.com [40.107.208.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21F9A10ED12
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 17:26:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3zXTuclCzAKBU1sHiIxZhjUbD/F+Vn3zq3ynoyQaA/EPs23FCtLjnKhS/WxFHjwn+b7gnxjA7uBYzirW7aOSO8QPJnqlBMaaUvdifg5Alc9dpnMijBQYxKvi8cJlFZNChaxDaNd8QBTrvbGYB9jqvL9U9DsFg7ihCVdAuJRPJZUVpWxHD8sC75nIv6Z9M5z3OsqlVGpDhpq1bR+tBhZvPVavajkWj9uy/p3uEeY2789blzbWkdsI5m9BhzGSSaahNNT80D8soFJia9Q/aNqjBwsapvaSNaLLXmm9XcOI4QxZB+Y+GyLf3IGg/VI75Zjd/szlPW/mPgIhH8zRHB7nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDu7PNHKuCVF5P3HaBJDe2vXV21zkcc8oerBRfSVYq8=;
 b=xoA+gh4LUJC70JgFR9rX+SvfQSEDcmWRpdqlh968Pyk80qqGmNOgnd9eOyZ0Xjh+3GhU/oeJsM07DJV/fXObtJSDMofrw0gRX0gk8iAySdGjB+GjATQgvdu/+cTy/wPEMhmiwp54Ih/weiBQvc4wEHidpJhEmZ18AV39arHCfnEMLbwxTtLYog5Ju/xe+suWzAmSKqxZTDo/yRv0Mxf+dJtNkgexT1TRq+kMFlCuFT9Ugn2bkg2cLPdjmR8WIa8HXZvT8rJqClWOVzaWNsmpJPBV+lt12zrBKAWNbDzNlWuYWT10xWFItRfhIPnQZRMbT4FZrz1jKkYdSLQJgwucmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDu7PNHKuCVF5P3HaBJDe2vXV21zkcc8oerBRfSVYq8=;
 b=GVU8V0EzMZbzehpZkksarbUD+o9edO+KMSh0xqmA4iBV/AhxxQABkEvB9flAUo8LOgDsLfNGzJerj/eSLU6v1mz2YizSjkEgW/6IWmYPmZd/7JZIe83Wh/CxlVeVt+qO6gpJjplRuYoynzQMAYmJydpz+YN6as26qBo6t/PKZ7o=
Received: from SJ0PR13CA0076.namprd13.prod.outlook.com (2603:10b6:a03:2c4::21)
 by DM4PR12MB5867.namprd12.prod.outlook.com (2603:10b6:8:66::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.11; Tue, 31 Mar
 2026 17:26:38 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::11) by SJ0PR13CA0076.outlook.office365.com
 (2603:10b6:a03:2c4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.15 via Frontend Transport; Tue,
 31 Mar 2026 17:26:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 31 Mar 2026 17:26:38 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 31 Mar
 2026 12:26:37 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 31 Mar 2026 12:26:36 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <maciej.falkowski@linux.intel.com>
CC: Max Zhen <max.zhen@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>, Lizhi Hou <lizhi.hou@amd.com>
Subject: [PATCH V2] accel/amdxdna: Support read-only user-pointer BO mappings
Date: Tue, 31 Mar 2026 10:26:35 -0700
Message-ID: <20260331172635.3275296-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|DM4PR12MB5867:EE_
X-MS-Office365-Filtering-Correlation-Id: 0695cfef-fac8-4506-7b25-08de8f4aaa87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: MgcraO59t4NU8VDyWIGL2Rl4ow9pa10zjIznqM9FvtbOxPxkBOiK4cL3xVOxQEQbAfDVVTMQOq5kA+CV6dLtZ6vcWB0XK0XT81Qo5BkA9SKq8x76jB9vaohJ/5Nny5RT7SwFLJTD1MQ1JNERYPdk1HwxIeuCh2Kni6sPpvMgyB9F9AkqSwWzM87rXoM+NgRJnmsG/9AvloLapc3VsRck8vqwm1UvunCpL0XQpXHIdYb4mIVo8Zv3H/noGrqOF3XXWicca6B7w7U63ZvYFen5nEqfFoN1cYXDqsVfHNfNg4zv5S9U39GmVsznX4M4ES5rFrxVhBwcI9GwZctN1rp6DVT4WRsaWzKhsC5Cp0oHGCl7C7ShKdYQ1avqS6bzG+yTaS1JJ65+2WrGCOBH6RMV3yzUX+oXis0uTsM00nW2gdYWCgkPpKPRh9vtuQ3WcWqFfAbEZWPPYZNGsvLTepR+RWhO2TpmmsZx77vYSli9l+tZtT+UzpZ6dU1ianlDFXRa+VdzhbVE5bwzV82R2Sx1moh0LMOnbtojU61oWof/FBKofbH4zznvyVJ1zNQOvvX4x8Irs9/+TF/7TKwWPHwfRj7+RidaKg2SyXs3aEI8ls8O7yQU5DhDa6zPK9KGN2zyoR9pXy103sidpXtqmYlLMIC7luJNDcZbd01FX5a/RXE7QD127q7L8mTZzxaiBoYFtoQlrhDzfWOLR9W74rFQopAJsQu6dXT7UWDxa8SDcQi5CQEhhLKSYkso3ZhazoAWDAlN1VPOMZj3TfVSm/Yp6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: v9sLjjXjnKN5z8hV9ZNghh5H6QCPTU5DKNmwieaRbZuW1MGPvE0SeXJVK9O37D5/wc08337Qtq/FrzYq7ErBWdBcrXldLrYoYpv3v0i3Oa3bVQ5Q38kFr7p5K69UNkLbKqt02NFE3o1eiELh8Sb92qbvtWy7oV4U86bxVMVVRpWN+udmYB87kBC5qdryqNbvROrwxHG//etKRxFv8XkYJWPwJkwJwi/aapx3ac/QWreUZ16gJdwWycnQ1LXvMbR9vYL+nwubTwGqM+w5TaX5BjtBkLt5Um/NKFGbhZb5LPCj6oU1pDn/irCFg2MJV1l03JihYcbKZr2F/agZLRH57wGtK6+pZb7iVlbwLRfcZ9bgtlWNW1CGgb+hh+eyrgS1iOYsadthA5b+JvccEMZiUL6SkAfgaxmcQL+QJzkmd/Adbx8Ve86zn61/ifoJmg1F
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 17:26:38.3431 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0695cfef-fac8-4506-7b25-08de8f4aaa87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5867
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

Update the amdxdna user-pointer (ubuf) BO path to support creating buffer
objects from read-only user mappings.

Detect read-only VMAs by checking VMA permissions across all user virtual
address ranges associated with the BO. When all entries are read-only, pin
user pages without FOLL_WRITE and export the resulting dmabuf as read-only
(O_RDONLY).

This allows userptr BOs backed by read-only mappings to be safely imported
and used without requiring write access, which was previously rejected due
to unconditional FOLL_WRITE usage.

Signed-off-by: Max Zhen <max.zhen@amd.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/amdxdna_ubuf.c | 29 ++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.c b/drivers/accel/amdxdna/amdxdna_ubuf.c
index 4c0647057759..3769210c55cc 100644
--- a/drivers/accel/amdxdna/amdxdna_ubuf.c
+++ b/drivers/accel/amdxdna/amdxdna_ubuf.c
@@ -125,6 +125,26 @@ static const struct dma_buf_ops amdxdna_ubuf_dmabuf_ops = {
 	.vunmap = amdxdna_ubuf_vunmap,
 };
 
+static int readonly_va_entry(struct amdxdna_drm_va_entry *va_ent)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+	int ret;
+
+	mmap_read_lock(mm);
+
+	vma = find_vma(mm, va_ent->vaddr);
+	if (!vma ||
+	    vma->vm_start > va_ent->vaddr ||
+	    vma->vm_end - va_ent->vaddr < va_ent->len)
+		ret = -ENOENT;
+	else
+		ret = vma->vm_flags & VM_WRITE ? 0 : 1;
+
+	mmap_read_unlock(mm);
+	return ret;
+}
+
 struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
 				 u32 num_entries, void __user *va_entries)
 {
@@ -134,6 +154,7 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
 	struct amdxdna_ubuf_priv *ubuf;
 	u32 npages, start = 0;
 	struct dma_buf *dbuf;
+	bool readonly = true;
 	int i, ret;
 	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
 
@@ -172,6 +193,10 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
 			ret = -EINVAL;
 			goto free_ent;
 		}
+
+		/* Pin pages as writable as long as not all entries are read-only. */
+		if (readonly && readonly_va_entry(&va_ent[i]) != 1)
+			readonly = false;
 	}
 
 	ubuf->nr_pages = exp_info.size >> PAGE_SHIFT;
@@ -194,7 +219,7 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
 		npages = va_ent[i].len >> PAGE_SHIFT;
 
 		ret = pin_user_pages_fast(va_ent[i].vaddr, npages,
-					  FOLL_WRITE | FOLL_LONGTERM,
+					  (readonly ? 0 : FOLL_WRITE) | FOLL_LONGTERM,
 					  &ubuf->pages[start]);
 		if (ret >= 0) {
 			start += ret;
@@ -211,7 +236,7 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
 
 	exp_info.ops = &amdxdna_ubuf_dmabuf_ops;
 	exp_info.priv = ubuf;
-	exp_info.flags = O_RDWR | O_CLOEXEC;
+	exp_info.flags = (readonly ? O_RDONLY : O_RDWR) | O_CLOEXEC;
 
 	dbuf = dma_buf_export(&exp_info);
 	if (IS_ERR(dbuf)) {
-- 
2.34.1

