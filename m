Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1304DC44524
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:43:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07AF010E53F;
	Thu, 23 Jul 2026 07:43:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0d4aDDc4";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011042.outbound.protection.outlook.com [52.101.52.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D28A510E53F
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 07:43:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=re0ZX14XeSJO9ujljoQ/jYCfR6Mcx/43nbmSBzHYVoOTqsEPAYypjL6B/AocohmYNOA99KsLSmhBxxs6kDToIGnrtMT4hhTSScfb3yYE4/zK6dKL0LcJG7i96oAIXHDZylPXmij9+sCXcj6iPAcE82Kd5PAoqBaYOp/Lg5FbU/cBM1vixRBv7+Dq3bLUIkwyP3JW7AjzTckZLN0484OQHYoHyW+U0D6lurEEuwxxYhD+DPHLCWcrj99HazMJC1ZdD7tuecv1y+roAN4zeqthx8nbGLRHSZBvTkzc3AOo9w7Tj5sDCLuK3vCxkPRA6C/VhjTSMYJ7S7sI2zphhKlIhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K47/FnCRs8WjWRunKigdnyTzB1AvXVrCMqqpMAKdlQs=;
 b=ReX1snZ3UqaeAGXoQn3E/SqNT6WdllcpwqWkOFir7KTbd11UcbZXIm0b26xDXe+3TbkvSlIW/Da6gl+eoJcdEzmVvJIWJX0t4BMfTx76M6aApZ0JxyoDvTfYsohgnbRZxHp7WjrpLWyUO5ep0dwu4lQGg4D3z0bdw2PAO4xpG/BeY+1mqcaCgJZlVF8Cgqo3FG6E9TYDOT9Mnao7XfKrQnKWBmd7LaOdGO90jeK1mG3z/iUZE6l8t9qTa68Q3N/lhhhOWw8dI4YicZapTc4USw0U45fgON+bompJfA7QLhQys3JKDp3vbwKyh4wGEHhHvN/yEsRwHar3MbXpShXxoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K47/FnCRs8WjWRunKigdnyTzB1AvXVrCMqqpMAKdlQs=;
 b=0d4aDDc4fiZ8SA8euPABYVDVEI8mFaHNjE1YtUUMZs/uBqIL5LozujV+QRRqrjxv0v2Vswung1a3XS9xYNNmBizTJGqa7fwy226QnegWVgH3akD7kHg4KjDfJKNE6GwcVtE4KbEn7Md7SE8cw3lL3F0DgIsbF0kwG0Q41T7tk6U=
Received: from BN9PR03CA0758.namprd03.prod.outlook.com (2603:10b6:408:13a::13)
 by CYXPR12MB9317.namprd12.prod.outlook.com (2603:10b6:930:e2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 07:43:08 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:13a:cafe::80) by BN9PR03CA0758.outlook.office365.com
 (2603:10b6:408:13a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Thu,
 23 Jul 2026 07:43:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 07:43:08 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 02:43:07 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 23 Jul 2026 02:43:07 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V1] accel/amxdna: fix page-insertion errors in
 amdxdna_insert_pages()
Date: Thu, 23 Jul 2026 00:42:56 -0700
Message-ID: <20260723074256.2435143-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|CYXPR12MB9317:EE_
X-MS-Office365-Filtering-Correlation-Id: 14c98c5b-d1c8-441a-4047-08dee88e09d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: BmjXePtrjeeSME5uQ+3/gcRHNmS15FmGRg43l0DZh06mOt+PXE2gzB3Z4sNGPSJnjgyfvh/KPLBmBIFP5p4eGT0FSvgH0rBB3q7ETuF7tzGPkZyVCLO6twCS60qSWEAG3OLZM7DvfMRwoEqY4tbsx7VPTOLSH/2HwlUbNZQeL0r9F3IN75haZTw389NBoIcq2VUsRwdQpfl8PglEh0qYqU+sU+5B0/B9c3bkkmS1VxbqZ9KLX8cqdkbX2ueHnsxTtxdx7UtQoUpJBdV/8BmlCPtPWiqvpLJPRWwbzBM7+vSXNJMcCPnrFdMk9deE1ciBIX7bOyRgkj1vRsQsixMh74viSeZJ12epQ3pSf3S4neKoetGVQqosVctlwfI9Z6E0mnsxM6mG1ooGHX3mqN+uK8lBnVSaGN1CnQqWsD7Hr+eEkTW8rtkJT4cmv9nrGNji87A/SRXzGCqtndDvU2mO0g72aQJacUyrv9cJiXG9raXHdfjTU4OwMA5Cn5L6rMDKGxVKO8MUyzKwAE56aD7W5sVpBZXcC07ZIy/8R5GfNpzca7u5LuFVWqnLQj8+jWNvbXoS/gMS/AofrmtkbzgFx0/iKPZSdNfcQa8M+/mDc9R6iDOkF410CGVTsPfG+mjR+jCQXo6vnl1gWu7rF5C+bi4fB1To4kTYY4X8Mz3oQxJ3beFXpjsLl2TeitbjuaBeWxhP3wmH1duAVhcDg25Pfg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MviYSvfRzjU3olxGYcdcJFdgZf2cG03ep09dyGx4JG/jyCbTrPBcbFUbXJa9j1Rwt/UpnTjy3x1O3tzg+k97C4BXoSF24aOOQ6p6LusXPxXsxhMypD4j+7++8ALSSmdFWumhtE+YJttyb6Gec7DoSGIkVxPE9oLK3ulT96Yj41/f/t4xl5VCWKTozh6R3gqT3R/W6PCYFkIXY/OV2WB556kRIcPkzvk87btydTp6IW71RpPhizig83WO5VKBUGXPnXMaukFtwYJ+dydwYLwjUSm2CHnkGavMhwdJ8KTuL0KX7H7uX8VxMvOzZLHwNO6NVkDgGYx3HSsoOnfDtpDWgpIQEc6Z6/XtciL017D+grX1RVJc7JlRrRaZq/bal7LQwwGE+eTJoaE1SYqt6p7vWMCqzLEPEKkXDCW0Mt9TRSTcpGzaTM1On9hoU2MPvkyc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 07:43:08.0959 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c98c5b-d1c8-441a-4047-08dee88e09d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9317
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

Two error paths in amdxdna_insert_pages() called vma->vm_ops->close(vma)
before returning an error code to the caller.  This is incorrect:
amdxdna_gem_obj_mmap() registers an HMM interval notifier before calling
amdxdna_insert_pages(), and on a hard error it jumps to hmm_unreg to undo
that registration.  Calling vm_ops->close() manually — which drops the
shmem pages_pin_count and the GEM object reference that backs the VMA —
before the mmap syscall has even returned causes those resources to be
released while the VMA is still alive.  The kernel VMA teardown will call
vm_ops->close() a second time when the process later unmaps the range,
producing a reference count underflow.

Replace both hard-error returns with a deferred-fault approach that keeps
the VMA alive and retries page insertion through the HMM range-fault path.

Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/amdxdna_gem.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index d6fe6fb41286..aed110ad1c1e 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -435,6 +435,23 @@ static void amdxdna_gem_dev_obj_free(struct drm_gem_object *gobj)
 	amdxdna_gem_destroy_obj(abo);
 }
 
+static void amdxdna_mark_mapp_invalid(struct amdxdna_gem_obj *abo,
+				      struct vm_area_struct *vma)
+{
+	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
+	struct amdxdna_umap *mapp;
+
+	down_write(&xdna->notifier_lock);
+	abo->mem.map_invalid = true;
+	list_for_each_entry(mapp, &abo->mem.umap_list, node) {
+		if (compare_range(mapp, vma->vm_mm, vma->vm_start, vma->vm_end)) {
+			mapp->invalid = true;
+			break;
+		}
+	}
+	up_write(&xdna->notifier_lock);
+}
+
 static int amdxdna_insert_pages(struct amdxdna_gem_obj *abo,
 				struct vm_area_struct *vma)
 {
@@ -456,8 +473,7 @@ static int amdxdna_insert_pages(struct amdxdna_gem_obj *abo,
 				      &num_pages);
 		if (ret) {
 			XDNA_ERR(xdna, "Failed insert pages %d", ret);
-			vma->vm_ops->close(vma);
-			return ret;
+			amdxdna_mark_mapp_invalid(abo, vma);
 		}
 
 		return 0;
@@ -477,9 +493,9 @@ static int amdxdna_insert_pages(struct amdxdna_gem_obj *abo,
 		fault_ret = handle_mm_fault(vma, vma->vm_start + offset,
 					    FAULT_FLAG_WRITE, NULL);
 		if (fault_ret & VM_FAULT_ERROR) {
-			vma->vm_ops->close(vma);
 			XDNA_ERR(xdna, "Fault in page failed");
-			return -EFAULT;
+			amdxdna_mark_mapp_invalid(abo, vma);
+			break;
 		}
 
 		offset += PAGE_SIZE;
-- 
2.34.1

