Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE17D10A88E4
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 16:28:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62FA510E928;
	Thu, 26 Mar 2026 16:28:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VN3EfQuY";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010046.outbound.protection.outlook.com [52.101.201.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7209E10E928
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 16:28:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYk6iIZyTDKZKgWFxtosI1sl+8FOzljLGzev7S6dW5v7vwZiCH2RnW6QocR9AsxCIkwzuocPbcU58N4Gzszx/H4OHziWjiadtgg/OeecSV25AM3vxucXbDk6BqD14IqWNoEoYsZoK7q0ScKtc/4JPM1ImaNh7D2NtQdERWFJy4/sfjNDPdJegucqIW7w56kCOhF8fIITNaSjJbnLIkAafQlB6VCLLdROGNfE+YEx9z1qKRcqeqvvPEFMNqXDc0MspIF49l4tC8ADuC/l/ZzS1dPC7p7iZgvcnkmmAWMvR9FFMAYLVlPJGuK7hI0L1KV7MbXD1F3sfx5wnNzM6oXSLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNrFRhJXJMeM+1sX2XjS3nRt27DB+gmsnVltoE7LyqY=;
 b=og6ULnsqaSpEl6/Mf/JhXdiKIHDbb9dliEZAt9eeh6ihCOIseEhK/osqvHAFofYa1aJraOQAm4s6wumEKO4SWsnjvL74cGQLmvWbPeomMqAYsSR6GKjY+Omqen5VHKCsnTU2W0U8KWXmP6RaD4jAL7ouJbieE7NRgXUhurXXUGfEN9s3PZAHsJ+pHKxq5F1TLOJqS07vi/KcigzJgFjOkVJVh+VSNEWCCGtoI8ouw4BmaGSmAL4ro0lKMkzVPqqzysdfctLSJRduF0+Kkj0iKdwC8m1YeoUKRf3wfbo2ADdoEwNeBHheaSzk5ANiJ4mKkf5AMJHPQwtUQabQT1/zjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNrFRhJXJMeM+1sX2XjS3nRt27DB+gmsnVltoE7LyqY=;
 b=VN3EfQuYd2Ah/QvAe/AwXpycYtf7MOftkEdpV8I4/S7hAF2uh53wQRHMLpd4W/b7jgy7ytT0jkPBeclpMRrpRVKmkP9EM8l56IZNjJ284flrDTfIYvGIj4Kwj+5btV+tA8xQsUVFBvqWrvNaudSGQ7CqynBaHAh92bHXFEdRxoM=
Received: from DM6PR07CA0078.namprd07.prod.outlook.com (2603:10b6:5:337::11)
 by CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Thu, 26 Mar
 2026 16:28:02 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:337:cafe::67) by DM6PR07CA0078.outlook.office365.com
 (2603:10b6:5:337::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.33 via Frontend Transport; Thu,
 26 Mar 2026 16:28:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 16:28:01 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 11:28:01 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 11:28:01 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 26 Mar 2026 11:28:00 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <maciej.falkowski@linux.intel.com>
CC: Max Zhen <max.zhen@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>, Lizhi Hou <lizhi.hou@amd.com>
Subject: [PATCH V1] accel/amdxdna: Support read-only user-pointer BO mappings
Date: Thu, 26 Mar 2026 09:27:59 -0700
Message-ID: <20260326162759.2674547-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|CH2PR12MB4262:EE_
X-MS-Office365-Filtering-Correlation-Id: 067e3b00-3d8a-4216-a69c-08de8b54a66b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: fMNpOQLmdQ2VJYZRX3ucCkhQD9VSnMAtiu0NqZBKxHPKSrNkDprKc/PjWTzUkDBKhzD2sYl7fo7l1GJhnp+M8u0tT2PIegrO4CziozblTEwfwhEm0a8o0ftlsQ3RsFhHPHL5U+NFihVAkpnL+aj7iVTw/McRFlZlQw6coEusXM3Y5LVbthES6rdAmoRbwyVNGxtkzqeVHeu0OZepZtzIm2r1z5rAi57/tozEpiaaZs+JytPC/FYzQlyIco4pHspp5Ts0VHxaxaomGC9j3dY3wVji40e6HRK7env5cwoKAspR7ZZQQARq0PRQ9LQCDHPyqIkbG5O9DCyefJ+pj862MtOQRXJP/JLJ/kpx0JcoS+55XVaigqN87GW0oQgls9aFUWHDoLiZPcfec/LRo6FUdgu/a2tB8mIdS+eXdvOoUVaRRzyNip8i/9pC/FF789jbBmRGoHS5ibhSHfCxh0GhHGHsXt/CWbWEcT5OAZpTYggtv5uh/iASZoSbGPGlxWJt8vZuhhDQFw9AOFVPId6PS4gFMslG8stBoGhX639Xe0G4LZkXh5aS49NLeaqph6CvyCZc3X+sx5VDD3YUiSHW3H8YvqDdDxrJm1dOL/2tQOvhc4aXKuCsZA5LO6UFrdck0oACbVbbpCcB0VcWdR6I1dJNLXK6pjvty09StolNT5uumAO7GdNly75a6mlGy6OQnfsBpiSTIzTIcNumykIfpPOIMTCaJqKXBEJgU+FR9cDb9H1tKnn50e/Nje79NHf5waRRK0UWeTws2joUmhB2QQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bdEYs3Q5ZCdKeErJzSnxjU1zdrg5MDEc/mCr/2tVq7ER5NZ+/VQ2Jexfo5jgTYpniP21cS7F/scMVRKGHWr3N6FlEr5pH4R4ajEc/AFq/4OI2b7xHCJb0r/MXyaiyAE7yiJcQ5nC/qE4PXHUbMp6c+Wf8925nEE5GEvzhX9nkJqXpsPMQrw+sWS/qXk6KSN+7MpBtuINtl249D4vCHvp5sro3qEcghK1JNY+Lvdu0x/qiiIJ4c6PUswnvPj9z5f158wnzqfOrP1sK/VwDKVURQ1jX+HPv/nkv/FpsPf9Ewn7fwkB55t/qd/nLA4JX22zXs0L9i8AHpmcQ7KglfdErcfEnvKvCjFsUZQJfCv9yRZxioH9QCxdCiz1NVQV6FiF6jHRxDLI5iyUSZyZcZaB8WanXPB+OYvRZjjSCDHzJ9csp1QwaBiJNz7InIYIVqt2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 16:28:01.8339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 067e3b00-3d8a-4216-a69c-08de8b54a66b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4262
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
 drivers/accel/amdxdna/amdxdna_ubuf.c | 30 ++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.c b/drivers/accel/amdxdna/amdxdna_ubuf.c
index 4c0647057759..1a0e2a274170 100644
--- a/drivers/accel/amdxdna/amdxdna_ubuf.c
+++ b/drivers/accel/amdxdna/amdxdna_ubuf.c
@@ -125,6 +125,27 @@ static const struct dma_buf_ops amdxdna_ubuf_dmabuf_ops = {
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
+	    vma->vm_end < va_ent->vaddr ||
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
@@ -134,6 +155,7 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
 	struct amdxdna_ubuf_priv *ubuf;
 	u32 npages, start = 0;
 	struct dma_buf *dbuf;
+	bool readonly = true;
 	int i, ret;
 	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
 
@@ -172,6 +194,10 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
 			ret = -EINVAL;
 			goto free_ent;
 		}
+
+		/* Pin pages as writable as long as not all entries are read-only. */
+		if (readonly && readonly_va_entry(&va_ent[i]) != 1)
+			readonly = false;
 	}
 
 	ubuf->nr_pages = exp_info.size >> PAGE_SHIFT;
@@ -194,7 +220,7 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
 		npages = va_ent[i].len >> PAGE_SHIFT;
 
 		ret = pin_user_pages_fast(va_ent[i].vaddr, npages,
-					  FOLL_WRITE | FOLL_LONGTERM,
+					  (readonly ? 0 : FOLL_WRITE) | FOLL_LONGTERM,
 					  &ubuf->pages[start]);
 		if (ret >= 0) {
 			start += ret;
@@ -211,7 +237,7 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
 
 	exp_info.ops = &amdxdna_ubuf_dmabuf_ops;
 	exp_info.priv = ubuf;
-	exp_info.flags = O_RDWR | O_CLOEXEC;
+	exp_info.flags = (readonly ? O_RDONLY : O_RDWR) | O_CLOEXEC;
 
 	dbuf = dma_buf_export(&exp_info);
 	if (IS_ERR(dbuf)) {
-- 
2.34.1

