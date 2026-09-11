Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E6CC88E53
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:39:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FB4010E491;
	Fri, 11 Sep 2026 16:39:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ES7pRPG0";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013019.outbound.protection.outlook.com
 [40.107.201.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E24210E435
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 16:39:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LH0JCywwdyfswjPNtgEKl8C/uTBDIiw6UmIX3xrbYIVLBiK5EZlVbV3MFd1W8A8SQUL/3Mpad4p7c39JiI0/Jdxg6ftopBx57bqehcdwsekdtennnp8tFcIQtkTRZTmcejgZG2csrWNvd51vpKoPqemd7AOHBosa/d/zd0MpOpF8w/x+FpRGfHlnvqKvUdo590jw3Fsvf0caBgKibtX5g59jkx69cJGHixS3EZi8Qj69Yk4LCg2eg08G3mN4suB+9AbaOTKWt7yEn+XNbcnYw+8nAzlmcErVBCi+gn8MG7kpZIBbuyYelAaRCKgWAmiPeaP2jmbY4PKsGND9hzNExQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j16+L6ESLULydaZ46JSBdVWVrvAaiXPZGr6E8zdRjis=;
 b=DLfLLpNCx4Uh8FYFN5bDXjqM0n8xi7AW/Bch6UJMsXUGYqNxeVa8ldhDsMQVNW7TmQ0M8W9S2onxcXj/9uz7qyaW7yS788GG7X49FG3JcmO8HbTwOM/dxLftYIv6CQ7IsQhUBIso9C/uRs+4QQi1x5bfme/r8tIHT5Ok54roxCkNSzASWLkVUdPAC+fuR6P4WjBlhPpD9q9jLjLqUys7KpIZjUFcHZcZE2hkBWPyFGuztlUYUvlLcjjnK1iWsPhtay9btYfFhQPNyxK+Ka00fkHf4jd1oSDuHzLY+kiaMKGbvcovhOAmexQawkE49/9/glLHa/fKZSNPzXvvrXDpCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=amd.com; 
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j16+L6ESLULydaZ46JSBdVWVrvAaiXPZGr6E8zdRjis=;
 b=ES7pRPG0DGNNv80r6aAGawJxRNXgvHxkaOYiRj2A8AF9kO1DNE9xFwoq++grptAk+zFWl5bF6dDQSMg8TekmUg+x4be1EM3AeuONjtSpSTS6Ykw3S1i05lEwg/zS0ETpcvTD0YU53tO5hTbwZzXmBRAhoIJgETKUsGoXuDPr09A=
Received: from MN2PR14CA0018.namprd14.prod.outlook.com (2603:10b6:208:23e::23)
 by SA1PR12MB7173.namprd12.prod.outlook.com (2603:10b6:806:2b4::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 16:39:20 +0000
Received: from BN2PEPF0000A88F.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::87) by MN2PR14CA0018.outlook.office365.com
 (2603:10b6:208:23e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 16:39:18 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A88F.mail.protection.outlook.com (10.167.248.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 16:39:17 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 11:39:17 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 11 Sep 2026 11:39:16 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>,
 <dri-devel@lists.freedesktop.org>, <max.zhen@amd.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>
Subject: [PATCH V1] accel/amdxdna: Fully initialize map structure before
 registering notifier
Date: Fri, 11 Sep 2026 09:39:07 -0700
Message-ID: <20260911163907.1193852-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A88F:EE_|SA1PR12MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: cfb0cef7-c02b-4753-8d97-08df1023391a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|6133799003|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: TD4iCQCpe9X+l1Ci2BggoFB2URucG46n20YFOYFmVtxvdko4tyE0i9akNS7HtpvCaR4FqkS9sIm25gsCVcTXkVpNtNfXMjjuvlGCp/TT6TEm0ZLTya7y0560PItVD4qriZ/8yQWT42DrjZcvvu+Cs94LgpRhoLzgr3dS75bKFC6Ko7I8GMpwmNLsMC0hyoZTC7uZNOCRxkwKFGRuL5LiOqchodLPBTAkjM/RINpMx2C9R/yDtEI0Zs//IA6PA63s/V85/RRgUdFragAQsBe2CD6QacBYMSxtDFZL1GCo/WSqBWPlxnWAnYT5bdr0wJvxYkiDH9BaeSiKtHXBhBp+5Xa4kgMJn4773Kq0xOG77WIaGttkTOW4/E5SZHRvuMIKLvln87mtcr2HyQVbgLor23LjLQxWJemqHKJlbb1XCyOG2/KCcoh1W4+VsmwYofw7mrR1CmviFX2dPJ1YDy0xzbQsWA8t1jt8gDi90OZzWBYxay7+/KAszTsSW+r3sOmYN3ctuITz8Tm0WhpAtAkKGIHY8mEueZYFma0a+pl3K4oeuvgNlh/FkhUcN/khz49lPTyF//6zny9w0AGYmEXpAdHkB9ucY7J92RK351Ad06kacMJbdig/NlzoYZUYKgBGsXJktwubchDDJdNgrVZpYI2UoxsezUCTNMZOmBuhhbL+HBTQK5oDzJ+yTB6lvHlFw8yBGbgQaZtgiOxl+/dlPQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(6133799003)(56012099006)(10067099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GGr9W4DKg/WGoN1UK651UFsNtq8ReSPfO654FEK//2a+yg+HsCL1BgRb1rE2tnB17afrfWRzLlOjrvoL8wLl879sm1+PC+zhAo1TA64NfL1MXvcVatMPEQM4uEK7XRu9YAWvVJ7rU8/ReLTfp1a9RCnTpZ1RFKezCoKqHN1FNZU8zpiDKqKQWAG/+hoFHOdupCyx7213Xk3E6UYaTJuVyyba14bJ7MyMQvgcJlMVqzJvBX5rAwFl1SCFh5lBjNODetZLQAVAHd0CnDMj8USNJH/PIrndEQ4cNi7zz/vEc1XvksEEW9nKmKUTz5tnyaUSBbAdwEVN5aURmnCagqX83Xk2r+GOVwetAhcWBHT3ljkVcEgk+8DfDfvBJ/e8FYDuQDM2iKsqOit8LqdBhE4mTLirvLNJLoSLMP5NOEKQlsGkt4LXRyImN1G69IMGg08P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 16:39:17.7398 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb0cef7-c02b-4753-8d97-08df1023391a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A88F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7173
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

The map structure is currently only partially initialized when the
notifier is registered. Although holding mmap_write_lock() prevents
the notifier callback from running before the remaining initialization
is complete, the ordering can be confusing during code review.

Fully initialize the map structure before registering the notifier so
that the structure is completely constructed before it is published.

Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/amdxdna_gem.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index 5a1a2ee261b7..e861db6f9369 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -415,6 +415,15 @@ static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
 		goto free_map;
 	}
 
+	mapp->range.notifier = &mapp->notifier;
+	mapp->range.start = vma->vm_start;
+	mapp->range.end = vma->vm_end;
+	mapp->range.default_flags = HMM_PFN_REQ_FAULT;
+	mapp->abo = abo;
+	kref_init(&mapp->refcnt);
+
+	INIT_WORK(&mapp->hmm_unreg_work, amdxdna_hmm_unreg_work);
+
 	ret = mmu_interval_notifier_insert_locked(&mapp->notifier,
 						  current->mm,
 						  addr,
@@ -425,15 +434,6 @@ static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
 		goto free_pfns;
 	}
 
-	mapp->range.notifier = &mapp->notifier;
-	mapp->range.start = vma->vm_start;
-	mapp->range.end = vma->vm_end;
-	mapp->range.default_flags = HMM_PFN_REQ_FAULT;
-	mapp->abo = abo;
-	kref_init(&mapp->refcnt);
-
-	INIT_WORK(&mapp->hmm_unreg_work, amdxdna_hmm_unreg_work);
-
 	down_write(&xdna->notifier_lock);
 	if (list_empty(&abo->mem.umap_list))
 		abo->mem.uva = addr;
-- 
2.34.1

