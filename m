Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D62606A332
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 20:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bws35NYU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACE3A10EC54;
	Fri,  6 Nov 2026 20:35:39 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010027.outbound.protection.outlook.com [52.101.56.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BD1F10EC54
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 20:35:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AaK8nruUhIHB3sEmrzacJf8usNuPqwtii7arYj613Sx/yj5OHI2Q+KQYaPHzLIWUwhKNS20r41w//oGfu4IoUSA3ZZZMyN138yWMjIgIs8jecpUDLlE4PWQZlv3vng3y0wFnjXQnk/LOg75LA1vxwOngRuVziHjaR/sQ4UB9rYgXmUX7mbCONGMgaRouxB04IqRW7UmkGzf3C3zP4rLYY0jy0UBviHKO96MsjuwUvNu2qsRZOEipSUYMjOw8XSDpAX1fBLcKeCNNQOtYXlNfL6l7dNcE3DoX3x6JwZ+3gIuNwWAwHtRdA6ynEGV4bsW4+WuGy3xx93IdmC0MT0Pk4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53EafT0Wg2JMNxziUwc04YYUXGwFbi9bCEOcClbOTpw=;
 b=xKCi9pvp0f7KhP15tp8vcgQ+hnMR54UB83QS+POAp6BMk+CJbgAauxJwnS6P5Gk1u2Jyzy1fYtyvrd+RRpvlSfg5HcRcFm7zoHIl8FZPZZ8ZpwydNspKEf39sO8fcXoDtHW3tqz2Zjseg8JO0xALOUTI4Hnkfg05ZSb1T7EgmbXylhUaCPwj2nZqiI0dpv09PftxHr2BCw14uzQjxXpCSIHv6EFWi2I3xQ3AEnjZruE2gtFskdf6q8r12A0l/HbNNC0TaGWB0+/VQsgn0LId0OVSPHiex154aosbWUH+s7coOEEl4vgr9J+Eld9zKWmp9p554YXLCdH5Ml54W7+cqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53EafT0Wg2JMNxziUwc04YYUXGwFbi9bCEOcClbOTpw=;
 b=bws35NYU8BabJuob/NnWO9d8XGwYkZyp3vgzEAsEo83ElS2WOSSD/HKFpeuw9dcOKogAxX/d1BFqpzJV5gSKKb5IEPMmzcF48x3sEgicS5319YC3lzzCBvkXhhGQfCAoqxb9cIU7HzTe2mJXpyXQEdhTNZDNRKifhpugipgOKGk=
Received: from CYXPR03CA0013.namprd03.prod.outlook.com (2603:10b6:930:d0::14)
 by LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 20:35:27 +0000
Received: from CY7PEPF000000F5.namprd05.prod.outlook.com
 (2603:10b6:930:d0:cafe::97) by CYXPR03CA0013.outlook.office365.com
 (2603:10b6:930:d0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 20:35:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY7PEPF000000F5.mail.protection.outlook.com (10.167.247.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 20:35:24 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 14:35:24 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 14:35:24 -0600
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 6 Nov 2026 14:35:23 -0600
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>
Subject: [PATCH V1] accel/amdxdna: Use vma->vm_mm consistently in
 amdxdna_hmm_register()
Date: Fri, 6 Nov 2026 12:35:16 -0800
Message-ID: <20261106203516.2734090-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000F5:EE_|LV2PR12MB5869:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b04a7c7-a80d-407a-d02e-08df3c457c7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|18002099003|10067099003|56012099006|261026121527099003|261021121427099003|261026140227099003|261022105027099003|261021123027099003|261009223027099003|261102123227099003|11063799006|261028144727099003;
X-Microsoft-Antispam-Message-Info: 9JYeO5aGxiVUY4bXZZW/lBpa1YHOBm2+4eZs5pkG+Zzh3LoCBYQbSTTPLbM5pxAFwoMOk0pMN8f5OUKXC+A6/Q3fEgR5Dy7TZ43XziU9Ordy6CZCF5fDgGN08oxyZddwgR2x08323HBmeaMA/LXifLF3La0n9zGhOb8eXfhLqGeOFAbLsKwXlOoEoAC3s60/e+/tqOOJWV9zcpZUFTCBcto8YdfDtlC/XV89vDu/aarPwIUzPJt0hdgflcfG2QDo/Fd7qg/pcxaTT0JISnrKSkiOT1OaxMQccSprcdmLKbp0OY9nuwBGaxC3X9slW9i1+9gseGo1v8OmKGW79ZM+hycJCyLDgiIEjuB3Pv8UNUg+TnmGZ0JSjb2EFOn2FCAoBes25p2ysbI1szafH4wUlWEzIP7qfVtT9KRQa4A1vrlq9021KXY/WPcZzTq1TnvAIFCef8slbW7OkauNZ1Lv+5F+4ZFYS/UtPvUSDAN3l4dYXc2m56NGWlZ9MN6P4uWn2j2scCriUPXO7tCVuESChLJXHb2Gbof3a135pLUPcotvyxnhf51UdrDH8NnLRIc0ohNoFMYbiewVWH0rcCKPA1vfh5OyS+I86JZSCEYFGtD2u8LyTtvaVXY6C3Z/a6qoOVKKRmRBBMyoscvGyD1zp8eHuF4uBNV/p7etX5tVftu83sgBga0clboD3iJPVH7J9Z5OZh39LwJGDv1oj4B8DA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(18002099003)(10067099003)(56012099006)(261026121527099003)(261021121427099003)(261026140227099003)(261022105027099003)(261021123027099003)(261009223027099003)(261102123227099003)(11063799006)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xnVR4aKa0mmYnTZNaDcDsXT1vFjYOQoNG0y1IBxkpyUZ8qMxvhFWHZfzRW89Ohu6IG8c33hke86Oz3jsOizcHl2P5XIcAy5CXFBisP9VT2eLAC/imTlng1hF3UGc+T4mP5ixhJcTAGwurglAbgvz942V5/TlHO8GtjfrKlL2TGS5bB5EhpjjOqLz/tUBkZqQQQ34Z13VZkzM8fH6QCvaQVI3VMVzHm8A0Y6OrIjGvY6kk2A2Ho/jp4EggQCRQR7jkZjLmL3/nrkSnkw92ku+Zc88s2vhiPE4TiPtonm/bhjpaCd9Gmr9WfhguV2TkGa/E6/EtFrEsCpt3PXTxD4vo8ZkvYw7JOPd6ufT0T05/l7npJ8rJzDrxwOyo1px9K2m03M83zcKblx8+gjprhe2qHhfYPEk+jHSoELAgV8riy73e9LcbZwK5c6ldgDxrAne
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 20:35:24.8158 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b04a7c7-a80d-407a-d02e-08df3c457c7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY7PEPF000000F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5869
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

amdxdna_hmm_register() keys the umap list lookup and the interval
notifier insertion on current->mm, while amdxdna_hmm_unregister() and
amdxdna_mark_mapp_invalid() match the same list entries against
vma->vm_mm. The two are identical for the ->mmap() callback, so this is
not a functional change, but the inconsistency makes the code harder to
follow.

Use vma->vm_mm in both places. It is the mm whose mmap_lock is held
across ->mmap(), which is what mmu_interval_notifier_insert_locked()
asserts on, and it is the mm the teardown paths look the mapping up by.

Assisted-by: LLM
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/amdxdna_gem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index 09e48c794e1b..92125bc753c7 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -443,7 +443,7 @@ static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
 
 	down_read(&xdna->notifier_lock);
 	list_for_each_entry(mapp, &abo->mem.umap_list, node) {
-		if (compare_range(mapp, current->mm, addr, addr + len)) {
+		if (compare_range(mapp, vma->vm_mm, addr, addr + len)) {
 			up_read(&xdna->notifier_lock);
 			return 0;
 		}
@@ -477,7 +477,7 @@ static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
 	kref_init(&mapp->refcnt);
 
 	ret = mmu_interval_notifier_insert_locked(&mapp->notifier,
-						  current->mm,
+						  vma->vm_mm,
 						  addr,
 						  len,
 						  &amdxdna_hmm_ops);

base-commit: d2a8cee91bfa8616f713c7c8f539a81e8e3554ea
-- 
2.34.1

