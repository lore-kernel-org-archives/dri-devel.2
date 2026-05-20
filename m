Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816B5CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 22:36:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DF6210E140;
	Wed, 20 May 2026 22:36:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Fie+nJZ0";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010000.outbound.protection.outlook.com [52.101.56.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 130F710E140
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 22:36:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQp+UVa87NuuBYqOWNYR1pDDRXK305QmmYBoWwrEVLOU0UdzLlvxjI7Ag3a842LCIhEIPgYHT0EYpupN2OBYO2ftKloWxeh2C7aooWYU4uOmOwivS/xeh3ygdloWbgpwrK2RDBvY4NbM8Th3+O6Oo4a0IiagVt1J7wnN2U2//TDKim42srJ7BSLyk/dDcAg1h6HJGkFgnXfGOW5ZdnUHpzBq0NyMwFIpSA9GU+K5FHkZb1HDIQBXihezKnwO3txILTTKL2ysrchkKnA2/LrypKAhaIcy+cH96pPq2lM7d1RhKXrxZ5emvpMAK2WnIEHAHd7tESYzNKg7kx3YV+dnzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gigPQCDikk8n1x4wKIPhPdsRKQUfyvvMjl4QALLx1WU=;
 b=gr9v4ox9AomX/cJu8gqX2JrKzeu5+gedUC1wK82B13SI3WlE9lw+ttvwYsTZPaebUBOhIWq4i/u0mqc0LEX49yDZW+3Y/AGNjSQP9LxaNDNUv/yO++kUNU1ltWtP+v44158ctgUCsEbyA/599G89kTXfCh7odHkrBWP7KPFW8YS56Kp1sXbQTyqSvLBQiwLrcAsjbpYsoJiJYWgw5Gz8fpoTyeZEexCWLgBATInDhap3JyA70YClEfQ13nfNcbt+im+nRi8tGVcj3fnHrU2/Ug1ofrOqeTsR7U45EM7mcB5hF09Sc2I2Vzmgn1uzVPv1VETIRQC0tvX2JSIzekGqYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gigPQCDikk8n1x4wKIPhPdsRKQUfyvvMjl4QALLx1WU=;
 b=Fie+nJZ0FtMly+U6f5HzXwHTtKtoBhUCHEwdyN+I1mJo9Bu56hTNZcdrdx5Y2BFN8jh//8uqzsV9nkRrZNKah4DS+WM87CY8FaA2Y/hxKkI2TKaQ193WyRA1CeNRSAGQpQxke3rkkYoSqEZHNFr7EYRcjzdaktv/px9Ybxghwrg=
Received: from SJ0PR13CA0179.namprd13.prod.outlook.com (2603:10b6:a03:2c7::34)
 by CH3PR12MB8259.namprd12.prod.outlook.com (2603:10b6:610:124::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 22:36:05 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::5f) by SJ0PR13CA0179.outlook.office365.com
 (2603:10b6:a03:2c7::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.15 via Frontend Transport; Wed, 20
 May 2026 22:36:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 22:36:05 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Wed, 20 May
 2026 17:36:04 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 May
 2026 17:36:04 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 20 May 2026 17:36:04 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V1] accel/amdxdna: Block running when IOMMU is off
Date: Wed, 20 May 2026 15:35:31 -0700
Message-ID: <20260520223531.1403302-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|CH3PR12MB8259:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a3c19d8-fd07-42f1-ee78-08deb6c02dc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|11063799006|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: PSWqju4fm8AAIuRT02fve2/YEKMev0JPfimEu1D/mwQt2lTiWr+7uzQnglU6sfnWYHi6IwsVXbLVgReXiePRsMWgvBK4W/z9cHbhgJ9o+k7PpgkBeKKoKcPiHsPTqJfQpUKIwLOTHnKdMfRsEZx6MsmMRaUFr5htms7VltcSEN4r8NcqeidX2f9iOkTiltzt663tVrxc/Bo1m0jyxJkdOS/gFA5F6zGxLjBHB3oexMq4CPkG9gswp19WWnSoASLofwoWN5PV8cxbV9ZcQRCHCpnB9t9v+x6oF6cnvaAv6fMinKX6Nc+q4IqUjeDUHpLkNhMX1q089pnEyaL0/f9Lw3zB+u41Z56rfpLohI9vz00cY/rbBp7yaFIW3fpvNFzuHB5Njc4x4jNQ9quT5zNtppMh6oWuuJ0YRiJpm5W1eyjqpocFWXPK/h3CdIM7ntqAiQa72vY/juWyF4KabQGa9LATAf+Plla7QsTavJLWGURCFNTX7nw7jwXMJvcbuZ8CXagg6r9Z77D6X4eylpMgyZI+c3kDib5agFJg8agv94u/b6upfI4NudDzO/TqI/1vdw/tamm6CJg+436HcpBprPOASXX4N1yxwt3+EH2aGFZ/IpKZ5qPhs8ITXi5Xri1uUC5faiYcldz6OLdhs9EUpKnZcchdDpu34zyGaDigdArZLOa+5UkettzSGoQ8CbHZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(11063799006)(13003099007)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Lx0VAzmHwBDIuP0bicu6MDTNU6raLcDdA7SUDuXQn6lNdbPq1ezM9YED0pSqogXsTaL88GeQ0plJkblzdNbEQdu4U0aMUbcJ191ydwO19xUBsxYcx9ou9HtwNSchiO+YG+QoQFB2u/4qgTzbGKj5yhXpNwLqi5UpLfZLFSP1DVpDamMhfxN7Nwsc4y6iPh+moyc76fMOqC5AsaTFEK8yUbtxod6aFL5z4lCnVoLLpvDLXWZ3csVqVezgheVNiC8kHkA2yzGrTKdzYsDnpaQFoXizhgqnBt9UhniNs0XRBhvbXWcGqZGduosGX/9dGx3yEPA9NZGKpmlFoMeF4FfklklFUMWc1g9Qnvs8epacnH+U1FdQ8c08yyk/d6j9nysIbDTW4h6JV4WwDRasRkYImcO+zsL7P54kT+NvlUXPvSu5uoiATFtaHnRR0wIcXrhu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 22:36:05.0334 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3c19d8-fd07-42f1-ee78-08deb6c02dc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8259
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

The AIE2 device firmware requires IOMMU on.

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5319
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie2_pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
index c4d345d4c76b..22f66c7f534d 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -490,6 +490,11 @@ static int aie2_init(struct amdxdna_dev *xdna)
 		return -EINVAL;
 	}
 
+	if (!xdna->group) {
+		XDNA_ERR(xdna, "Running without IOMMU not supported");
+		return -EINVAL;
+	}
+
 	ndev = drmm_kzalloc(&xdna->ddev, sizeof(*ndev), GFP_KERNEL);
 	if (!ndev)
 		return -ENOMEM;
-- 
2.34.1

