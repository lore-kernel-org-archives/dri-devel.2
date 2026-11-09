Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30678606A325
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 17:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DV+l1BWj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B2C210F460;
	Mon,  9 Nov 2026 17:14:19 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013018.outbound.protection.outlook.com
 [40.93.201.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A97A310F451;
 Mon,  9 Nov 2026 17:14:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oFpRVrfz3HcX+eanW0yZDPoHSEclW9+v7PjhMidirznluefwenibvFdqxIlc2jrBah+EHj/+Xq9DNa2aVXmHXx5DYv/11sHakwbVmkNwii85dArdZA8GDvUcLvJVqQzkzeAqAPlmTSQdit3/yE//QW5pFSQlS0v0bXZMHoGjVeoFJUWLShs2bPaLaA7YbYzyY9q5inB/mlTM8TdDpBCCBPiWlYfSnCFK8KmkRxtXFEU0CIkciHZnklLa35oG15zZ+bkWsoCNOR0cAUDxe+us+3k25Xh/0ROKvRdBPNsGnQhWRhvBmNjTiV9pQcuALf8txb8teaukvbwwz89VTq9OQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMS3le6QBnzMVsln3mhOiZA5j5GDOGeZZCuRiafEg3w=;
 b=qUj1ktKmFiWfNNtOA3qbbUu6MB2UqZ8QV0dETKJ8oq2rAhD6HNpTbJ/hCus1P0QiZ97yLM9k0uZofLP+pfIggWFZqr5i/7wPDhtfxP5j5VAikp8/MPvwTpMZXsuRmjCwTgAHaFGywSKjHXykto63wq//aFjzt2PLSLVMb2HhZ64l+UukXYtrj7DQhl9DLtlbO6YRirMB4UY+gbs2eIl4vL7y88ykwKkl2oikfK95Jy/dMGd+6TX01cWFIrVfNsyqTvkcjIhOmd44HCxrz6EpzCL9oJiqdOd9qJVFINGquvAPDv+xZQNhsRyOhMvcpA8eyQwkLzxmVZcy1hzcnPgLlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMS3le6QBnzMVsln3mhOiZA5j5GDOGeZZCuRiafEg3w=;
 b=DV+l1BWjpC16dmQQSxSOFrKebrnquMa5GxCcoQAzWZimAfTzBCDNXQfLAD962lN5cJkYsALmUWR201WcTifjg29WIA7ivieM8OE8nKM6NN2rPs7Vl6QsMd7H6OpEoLFgfpIE47pKq3xjk/muuOEChjLDOh2zQpHn9RuSyrcBOdo=
Received: from SJ0PR03CA0158.namprd03.prod.outlook.com (2603:10b6:a03:338::13)
 by SJ0PR12MB6926.namprd12.prod.outlook.com (2603:10b6:a03:485::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 17:14:10 +0000
Received: from CO1PEPF0001885E.namprd02.prod.outlook.com
 (2603:10b6:a03:338:cafe::45) by SJ0PR03CA0158.outlook.office365.com
 (2603:10b6:a03:338::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Mon, 9
 Nov 2026 17:14:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF0001885E.mail.protection.outlook.com (10.167.249.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 17:14:07 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Mon, 9 Nov 2026 11:14:05 -0600
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Sashiko-bot <sashiko-bot@kernel.org>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/6] drm/amdgpu: use pci_set_master in
 amdgpu_device_mode1_reset
Date: Mon, 9 Nov 2026 18:13:21 +0100
Message-ID: <20261109171333.4329-2-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109171333.4329-1-pierre-eric.pelloux-prayer@amd.com>
References: <20261109171333.4329-1-pierre-eric.pelloux-prayer@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF0001885E:EE_|SJ0PR12MB6926:EE_
X-MS-Office365-Filtering-Correlation-Id: 17e5ebe4-1a7c-4c6c-aa1d-08df3e84ddf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|18002099003|22082099003|10067099003|56012099006|261009223027099003|11063799006|261028144727099003|261102123227099003|261022105027099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: q5TKCu/8++vbE8g4LLW65Hu2z81wZEKl6f3cR0X6pqtpDWrt6luN012Zir0g4IueBJx6IyPXspGwcIk83xsbGJFznrHCdPM+3U8OXdO0fRUiJ9yvavYyINJgVSpfrGRWOWkUg2Qly3U5pcrcwVHH3q6cg6UgYegEzNNxqttgiLcDSih8FAHSQAYA2cZQQGjl1F9piIyUu4m39vfWP1aaexFCkV0AFvVSvRsJqOKbKWBSjIqlHE2gDs/9/9UhahF6cc1fIn1isNFwZRmFnFbP+MkFDlVAdgndHq1AtC1HW8NGNjPYz2fAPsi6vjRhA25nkvxWGhBfvEw7pf6k2ZZrQlnljxYsZ91B/12uLmod1Q+bfJM1fuVX4KVK/t2Lo6yFz4QvXeZyXNZ/GWlK/526eQEaSZF0K4fVnAk9nG8Gw2mAVz9KLhU+zZA0tMUCJQBRhuGvDkC/HM0hbMcOUCDGfrTOqmZO4xEdem23VVQoBYIO3bFTdgE3pD9wnHjE3macxRjXxoCRZkEHy9wi7OwnFz19yF/sNSjsT5uRz1EKUxNjolXb3cbVJvfRP0WPaPs+ap6VEEckN9APWw7hrxVFSt5xuJAGP4DGXAd44Vd9dyadTfS32kIKytIH9k4XdirhJYqB2ANg0few4aFfmhzAyA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(10067099003)(56012099006)(261009223027099003)(11063799006)(261028144727099003)(261102123227099003)(261022105027099003)(261021121427099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qhkXcRGHXu5vCQMU0swEyV6UVdUEXM6BfexSNkVpUEUnVyLeT6EBU13P2suQxCZ/Wt7Hg9o3tejzkw/Jlu61JinT6B+QHktw0dVC/iTlBvQ48FDGqfIYu9FfGas55BopRtkgbv2SeEDchSjdhdzL1mQbo6Pzo+jxr/KGwxZHKUqIqCTAQhZFuSSxSKMcUUrv2BFZGhmPegDXVneUwQh7e/TEYTAZ6af68saVs2OkDwiPGyrRQH2qO0bnDu2Z5wMpflpQ6MFC7DZddkid7yiG747YXeVewBddUm/dujVJoqkbwnoqYlLF7gAg/Kc7go0sdCNZpHGcVbo3IgOTwdzLnaQSIk34H4dzD+xuHg/XWhUWn2gwMKHAne/OCZs3K2soRmDotCcaaiiOiKyTsEu84LcPgvZRisx8z/xNC8B05oTUBx0sDTLNjXCKSSZSBEEJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 17:14:07.9438 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e5ebe4-1a7c-4c6c-aa1d-08df3e84ddf4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF0001885E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6926
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

It's explicitly disabled above but never re-enabled, assuming
that amdgpu_device_load_pci_state would restore it. But if
pci_clear_master was called before entering amdgpu_device_mode1_reset
the saved state won't have the master status.

Reported-by: Sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20261029152000.22001-1-pierre-eric.pelloux-prayer@amd.com?part=4
Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5069042b5279..730e9e93d078 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4981,6 +4981,10 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
 	smp_mb();
 
 	amdgpu_device_load_pci_state(adev->pdev);
+
+	/* enable BM back */
+	pci_set_master(adev->pdev);
+
 	ret = amdgpu_psp_wait_for_bootloader(adev);
 	if (ret)
 		goto mode1_reset_failed;
-- 
2.43.0

