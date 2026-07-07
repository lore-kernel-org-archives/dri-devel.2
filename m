Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEBC7C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 20:16:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EE8910E4FF;
	Tue,  7 Jul 2026 20:16:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1NrkHvm1";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010005.outbound.protection.outlook.com [52.101.56.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF15D10E4FF
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 20:16:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gks5pggx3TdWbvbL5H3+rqOrAyflEq+wzyJEeMBu0XF72BjFGnlXVP6XRSf0n62HzXPluE3H+neWnBjIYdxalnmrP813zhlJCrgiUuqfNGVh+mqP0+/HXr8Kck8I1gmDEK0HDsbVPZOkvdILLbEcP6kmQF/jTQWphHaK2qWoznJt2RSvKAaRAENeACOcnlWQj+upiH4SIqEkI0Spz67Sulhx7VgONiSMB8/rCz1V/HST/IHfIZVVdlXngyc7wJ54qvcM8s1osRcZcdOw/Xlb5l1JggOcqmWrDVCT6BxZKib3zz0Q/EUOQ7a8zQa/YMOElR+/qItZ+ATHIL9VFMQQnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvYfaPnJIoVf/3xd8me57aAB56fLHu9qYjFhLnve9i0=;
 b=bqCKHJkm080LLV+FyVTltTdQu97dl2YKfr5Rti+O6SjpLVW/mwPrxlCcdorbveZSyOfoZIPFYsxiHBeP3JUWTMivRc439IndOZr00W/dsau4jGxpqq0eEvq95sQDpxTaRuV8dWHpQIfj4cif6tMPdsQGeHPRQGiLURhgJnPp3YDFwgr9B2Jf+d/RiXaML6JkTf1pVoCeJBmo3GuzVnokLs05abh5GcXVWDmZGjlhNHI20359IyGafAb3Jy77aEUC0DOnHQKp2cUsP/vSqkJr9ks3gtNU+v0mZYEtCMKF5gJx3kSFqOJK/T9WXCdukYnf9puxP1RJqaLjNTvKS0P0+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvYfaPnJIoVf/3xd8me57aAB56fLHu9qYjFhLnve9i0=;
 b=1NrkHvm122KX/q2PHhS33/DjByi4Xn1B31N13r49V8JytyqWwGGqs1HFg2az04loe6QqD3RHKACTfryuloErZMESuI+01lEIxn1YHktnlHkms0RAbpCZC63dmh1oLrfafRLA1OuEbu4vS0kSn1IWNGY8MPilCpkiA5yaUoyh1Go=
Received: from DS7PR07CA0001.namprd07.prod.outlook.com (2603:10b6:5:3af::10)
 by SA1PR12MB8096.namprd12.prod.outlook.com (2603:10b6:806:326::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 20:15:59 +0000
Received: from DM2PEPF00003FC5.namprd04.prod.outlook.com
 (2603:10b6:5:3af:cafe::b) by DS7PR07CA0001.outlook.office365.com
 (2603:10b6:5:3af::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 20:15:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM2PEPF00003FC5.mail.protection.outlook.com (10.167.23.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 20:15:59 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 15:15:58 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 15:15:58 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 15:15:57 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V2] accel/amdxdna: Fix potential NULL pointer dereference of
 abo->client
Date: Tue, 7 Jul 2026 13:15:56 -0700
Message-ID: <20260707201556.562191-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC5:EE_|SA1PR12MB8096:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fe94bcd-bab9-4441-7184-08dedc648f4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|11063799006|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: 1jrsdLnyqaaOfcOdLerpjf0eYhbtkT60MJmJnZKZd2qmvScH38J4kJ82mEfiNwgcMHASlKtjGPR8qPAnCOVLDyjaCwAhpHuWMixKJLomRRe1VkjL1gQlQciUJjH5TfYRwcTpblvUrhtd4fyZNBfdkIJPLi1HTFWkgrWg+PeahdqiVJfMCvBbrWhqSKYZbVB12Xuvx52mrP0Rn4xyvylsa5gvnXa3+dsv4i72ZEbc0bwuaxNfldM70RRigRZzZH9iMO3cVzXeGqRNmCk7hf60ZJl+wQXqqO8tG/mvUX8PrNeWU7UekQJOJgUx4r2/8sXVfY6tPIMvgFGx6xK1qx4XflXBVeZhA7Ixr7IQMfXG25+ZeuGponYGxDXkRQfsfQIty63A/OUgYsJw2/WFYLTL8W/J8kMleHoDhRDJNWm49vq+CdFtSqwulBPKNft7zIvnwvB7J6q3hZtJC0shRn9NgrHPBDGxdJCJH3QCxZrdqc9rOlhwBJ684jvz7eA0V3A9MTYsb8c0OhmxS53BevPw9Zo1bR0vl8NPCScw48fb2KPtwsOgV9FyAEI4/GfshI4IRpgHz9zsw6HjnzUBYHlSvD03OFkPhWhZ+vM+iQ583i3aLzymVoqhWZ14Ocrep/SJGweuMtx9rdbp2L0cjINm3VhZGnc1U1/VxcIlf7yjTZrfUslk9IfovHtCaHuHP7mg7Qedf2lD7uRTT6VS1LR7Ag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(11063799006)(18002099003)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sViF6DgBHcY82Al5wPTNAwEesEPNS6VzKhu49ixJpkgc7lfy3hpYYmKjdlzBSfq2Bprnbh0RTwcVCg8jTbobFN5Ro1nu5uLu2QBH3J0y5W3rsUhF1NFfbsrky7IMw3X6qMk4qhHmHSLMWohoSY8Vw58wYfToTygtcKWNPbHa5eNdMUU39UgYNIcvuduoYEkD9BSUKmoZKnEETTEm2/vQbVF/v+oyabnUBQ9F7ezPLblUBdlMWM0DIGNize0aM7H3VjOeqeOuzPqcDM2dL3SbkwaqwTKJoRb4wZTnO7IWPWCfek8BZi040lZoLGn9pPSDWx4kwunN62cAUeBHme1AeuyEd0lOsEIyfeavkxzJv/Xp9KUjGZM46yANJIf8HL276rAEnwlVtYT9SVlTVM6dhMhbkR4qwUPoiyx2VRLfucQf/WZecOcuD7/evxpU33xu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 20:15:59.1341 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe94bcd-bab9-4441-7184-08dedc648f4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8096
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

Closing a BO handle clears abo->client, while the underlying GEM object
may remain alive due to internal kernel references. As a result, code
executed after the BO handle is closed may dereference a NULL abo->client
pointer.

Remove accesses to abo->client from code paths that may execute after the
BO handle has been closed.

Fixes: d76856beb4a4 ("accel/amdxdna: Refactor GEM BO handling and add helper APIs for address retrieval")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie2_message.c |  4 ++--
 drivers/accel/amdxdna/amdxdna_gem.c  | 11 +++++++++--
 drivers/accel/amdxdna/amdxdna_gem.h  | 11 +++++++++--
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
index c4b364801cc0..dfe0fbdf066d 100644
--- a/drivers/accel/amdxdna/aie2_message.c
+++ b/drivers/accel/amdxdna/aie2_message.c
@@ -840,7 +840,7 @@ static struct aie2_exec_msg_ops npu_exec_message_ops = {
 static int aie2_init_exec_req(void *req, struct amdxdna_gem_obj *cmd_abo,
 			      size_t *size, u32 *msg_op)
 {
-	struct amdxdna_dev *xdna = cmd_abo->client->xdna;
+	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(cmd_abo)->dev);
 	int ret;
 	u32 op;
 
@@ -874,7 +874,7 @@ static int
 aie2_cmdlist_fill_slot(void *slot, struct amdxdna_gem_obj *cmd_abo,
 		       size_t *size, u32 *cmd_op)
 {
-	struct amdxdna_dev *xdna = cmd_abo->client->xdna;
+	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(cmd_abo)->dev);
 	int ret;
 	u32 op;
 
diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index 1275f91ca705..4628a2787265 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -198,6 +198,7 @@ amdxdna_gem_destroy_obj(struct amdxdna_gem_obj *abo)
  */
 void *amdxdna_gem_vmap(struct amdxdna_gem_obj *abo)
 {
+	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
 	struct iosys_map map = IOSYS_MAP_INIT_VADDR(NULL);
 	int ret;
 
@@ -210,7 +211,7 @@ void *amdxdna_gem_vmap(struct amdxdna_gem_obj *abo)
 	if (!abo->mem.kva) {
 		ret = drm_gem_vmap(to_gobj(abo), &map);
 		if (ret)
-			XDNA_ERR(abo->client->xdna, "Vmap bo failed, ret %d", ret);
+			XDNA_ERR(xdna, "Vmap bo failed, ret %d", ret);
 		else
 			abo->mem.kva = map.vaddr;
 	}
@@ -354,7 +355,13 @@ static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
 	unsigned long nr_pages;
 	int ret;
 
-	if (!amdxdna_pasid_on(abo->client)) {
+	/*
+	 * When PASID is off, amdxdna_gem_obj_open() called amdxdna_dma_map_bo()
+	 * and mem.dma_addr is valid; use the DMA address directly and skip HMM.
+	 * Avoid dereferencing abo->client which may be NULL (cleared in close())
+	 * while internal kernel references are still held.
+	 */
+	if (abo->mem.dma_addr != AMDXDNA_INVALID_ADDR) {
 		/* Need to set uva for heap uva validation */
 		abo->mem.uva = addr;
 		return 0;
diff --git a/drivers/accel/amdxdna/amdxdna_gem.h b/drivers/accel/amdxdna/amdxdna_gem.h
index a35d2f15d32c..1e90e32bf3cd 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.h
+++ b/drivers/accel/amdxdna/amdxdna_gem.h
@@ -88,12 +88,19 @@ u64 amdxdna_gem_dev_addr(struct amdxdna_gem_obj *abo);
 
 static inline u64 amdxdna_dev_bo_offset(struct amdxdna_gem_obj *abo)
 {
-	return amdxdna_gem_dev_addr(abo) - abo->client->xdna->dev_info->dev_mem_base;
+	return amdxdna_gem_dev_addr(abo) - to_xdna_dev(to_gobj(abo)->dev)->dev_info->dev_mem_base;
 }
 
 static inline u64 amdxdna_obj_dma_addr(struct amdxdna_gem_obj *abo)
 {
-	return amdxdna_pasid_on(abo->client) ? amdxdna_gem_uva(abo) : abo->mem.dma_addr;
+	/*
+	 * amdxdna_gem_obj_open() calls amdxdna_dma_map_bo() only when PASID is
+	 * off, leaving mem.dma_addr at AMDXDNA_INVALID_ADDR when PASID is on.
+	 * Avoid dereferencing abo->client, which is cleared to NULL by
+	 * amdxdna_gem_obj_close() while internal kernel references remain.
+	 */
+	return (abo->mem.dma_addr != AMDXDNA_INVALID_ADDR) ?
+		abo->mem.dma_addr : amdxdna_gem_uva(abo);
 }
 
 void amdxdna_umap_put(struct amdxdna_umap *mapp);
-- 
2.34.1

