Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A364FCD8CB2
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 15:11:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0474F10E492;
	Wed, 10 Jun 2026 15:11:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="shbKRxvX";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012036.outbound.protection.outlook.com [52.101.43.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AD0C10E492
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 15:11:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kxt5P/EEBqcWJ2ix0nByTEbSJ6x5QDJkx2mhVaSO6JnCCNeXqZ678zLGOw1JoELCGUPwS+gKdMQr8CVblMN563wqmLAMf4Qw94uG9iS2s/e+T6+NkK/hkrfB7cv4vQkU75eKRcBK5S0QT2RMWMdtEJc4AGxa92Y7u1FZECJAA+vtIxD/2CROq2dZXBy8EEPCPWzjPwmXNbDKR7pVSY884tWXfQP1tYeVtljE/oDMRYXMFcX8ohFAmeVwtZQfLTNClDYubkXnKnm6dIkdTzL6uA1MRVdPW84C9f5SIO4WWkRO5BMyTVeIq1YjiU/ENddZQYL7yIf9lOdtXsQkaKe10w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jssqmiaiZ9rXUV9ZmNdUR3Apgml8BwFxZa66QRHtYA=;
 b=k7AV56EmMRVtSo62VyppKU/pN6rIrC3DhYK2yvm45sCeoAcN0+PqIU+p9v+KUe4eCW4RYd+FkLMLtssCtx46BT8dGDGv36JqXRJKgBPnioxohxenzIaIYp1cDgP/jI1kZsOT0NfHK4Fsfp/NAKjNzIImhvO9pvNvk5rt8UQl/iS1V/S9rYLb8oAui5Dajq/H9WVNNenF4VkwGDMQfM07lcqKUTjsMD4nI/RLWRZyNj4rdRdueuJjOhpF37WQrF10dxmNK4ovqaDmxEe25RVBEYP5i2f0mJxtGFEt9FlfXQ1mm3jTXF5WXrUJYJx5nfWkPTBOjGDn3py09svL35THRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jssqmiaiZ9rXUV9ZmNdUR3Apgml8BwFxZa66QRHtYA=;
 b=shbKRxvXQuuvmkBc0slPDcuY26Vj5GnjvcF9vq235n6+08bJGuDTSF4y3aRUxgdXaRJ6IwR2jToFevFsTSqUGyRh0y2+A7I77dg6fB5X0e9Bu2LOLynWdAw0WpPaxlydKLgryTLKMk5FmIiCVYEk17O/8WXFc97+vf+kyG+Kij0=
Received: from PH1PEPF000132EE.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::36)
 by IA0PR12MB9009.namprd12.prod.outlook.com (2603:10b6:208:48f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 15:11:36 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2a01:111:f403:f912::5) by PH1PEPF000132EE.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 15:11:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 15:11:35 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 10:11:35 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 10:11:34 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 10:11:34 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V1] accel/amdxdna: Fix mm_struct reference leak in
 aie2_populate_range()
Date: Wed, 10 Jun 2026 08:11:27 -0700
Message-ID: <20260610151127.2994185-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|IA0PR12MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: 9808707a-bab4-4804-9607-08dec7029024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: mF+03fwWRTFEmE8JFox7ClFuQsC1DFLBM3cJRQJIbLkeJKfqT580WbskBL+M2K51e/9vtrmZMyKhL2KRBPCx/lD37pFRcpvDz4ofZz+nXjS+VL3LGz42iB5/oRQrkX1JT4rGLSflN1sDD9Uxe9NdOxUyBfwB1WvCD1QS7nxzmU1uIRDt9lO9POZklMXwI0ZHWK05BMyxAVosm8OKZBdqoYQxAlv+XqGXS814jTySfub8SEnrnTnsxcT8QNYpJPVn0g/YWdol4VbFYGx8JtskjeWCG4C137FybLFfMa2to4PprGXyV9Lu73E2UdXP9UQBjwXl5iN6fdW4ko0Rr3QgJAD/K1uySEVWjkJ4EjOMnr/JVhlwD4CAMsPbKWmXQ6Z0kboV6WeAfJ1ZVFThNtQpDvECmJ+KC0yioONZ4u4JMUggig6H1JT3svrQvZYr6aUPWSA0/T93Lls7s5Edxui29iQd1KwNqdx4OFNwPR4zz2O6zjJNFZTjLZC5weuBlSLpTuXZ4U4E+uR05KpajYeMcEpLzwzDhAiKe5OG30gPv4tyS5rk+8AGP7VV1Glv93qmqDNg8MZuENDDipq+ZY0qXOUMMuCnECzBnj8uZpYN7pEuM5a60GSehqQIvF/ceZlfh4GncVCb5bDu6U0KQubQ3ROA7MEl5mP3uLQelC+Lq6XJdGDqvv3s4lK37fiI1JvsO9JErGduvb7zTQYum/n+U7Fq2JX0x0t17SwSXidm4HY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qj5SrXcVtNI1/iOmaaQIU8R/sBcYvxXD8Q4W84ugwTnru+ILlJzVUvkUQzeDqkqCs+vKlbN8hmuokyTpV8Vn+q/Bt6/T0uiFtaBXfOqAb4KFsiyeJ23d63fz7npLYnHp+oqp7YUKQsIbSquxwxdp7t2hgHAlORFi9ScQuFW6ltU0uODfTpSeJ79GcQeNkPRVCaSqsj2iIs4gUmEE6MPJgq8mAulzlyQInC4hyYCJvYWfIubBtH8djWT/yu1CNFvLRwe6PmG9pMhl7ACfc4zoxXkguEOXdzcf71MedpWRUWGyBqZXLQQ5xZUvjMOD+3JroRdOsj3sl7DWleTvhWvCtBu/FAT0iyvlXD/4h6zzjgW3r1nftRu4WEvaYLPwlal3+474Q7lFmHbJKA7saudG/iH8MI2nvMbj2Gi0ClyhA67kPocBW9OWcCHSWOFx139z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 15:11:35.4477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9808707a-bab4-4804-9607-08dec7029024
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9009
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

aie2_populate_range() jumps back to the again label without calling
mmput(mm), leaking a reference to the mm_struct.

Add the missing mmput() before jumping to again.

Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie2_ctx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index 3e21e2dabe82..e0f30dbe0238 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -1041,6 +1041,7 @@ static int aie2_populate_range(struct amdxdna_gem_obj *abo)
 
 		if (ret == -EBUSY) {
 			amdxdna_umap_put(mapp);
+			mmput(mm);
 			goto again;
 		}
 
@@ -1051,11 +1052,13 @@ static int aie2_populate_range(struct amdxdna_gem_obj *abo)
 	if (mmu_interval_read_retry(&mapp->notifier, mapp->range.notifier_seq)) {
 		up_write(&xdna->notifier_lock);
 		amdxdna_umap_put(mapp);
+		mmput(mm);
 		goto again;
 	}
 	mapp->invalid = false;
 	up_write(&xdna->notifier_lock);
 	amdxdna_umap_put(mapp);
+	mmput(mm);
 	goto again;
 
 put_mm:
-- 
2.34.1

