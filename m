Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFD6606A322
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XQQP1utw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ACB210E1D4;
	Mon,  9 Nov 2026 13:44:09 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012037.outbound.protection.outlook.com [52.101.48.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 776F310E1D4;
 Mon,  9 Nov 2026 13:44:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c3EU2A2CRH9mj7HVat/rAkg3GivUzJbXfmSbLe5rShAA/3XnNas5Ybz+VuMTnb/lUhrN+DcNtAhiYJNqpVvghi1DL5S2gU/TEWvXSeLqP2Z5g+mQdE5hjSv19D1UgVHdbTVzUqMeuTPA70q6wd00qDJsuerDhkoBhgyRJBuTE15LP2zAqzUfeRX06KuAzA0XQ1RK7ZnZq/g+VeunnNbICQTE9idFi3UctuULfxaBddezkmpGPnqUemFTOkxmKFhPTGUOjKyM64wuqSgpZo5svf6zzVdZ3Rn1K5qVfzl0BomYyfUKhsDieHIekLaXzbcBIpvdSa0MV3Dm0mE+a00t0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRMDM4CM0eRZra1yMGc/VjW1CkLBNg7tdg5qZsQ2+vM=;
 b=IBWGfzdFLfy/t0oZxavvq96h3ip8lYdK9DY9f0BmhUAe8gb/yfDZGvX2N3IJfan3S0ABaSn1JQW3sf0wINU/pz7+jCEcI3F7CMIDzJvyBWjWg7LZMc89jnAO5bl2+9baHwIRhNy4X1kCzKcqq9n814x6fEQZB2r+De2Vbacg1GzJpZY59jtBDhnmRzK9yzLx0YQXKu7mk6UyH9z/wk6g9g7Dh3iB1f0l2MkC5q9+bEZf4UgaxZe8U3A00KWMXRDx4pzuIRvY88B6j27WiLvRw61P9Ia1j8eNEK54AeVzf17gXX7FxdGD90tSL7VXjrgIyDiJKdE76vh94bvZ3WxVGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRMDM4CM0eRZra1yMGc/VjW1CkLBNg7tdg5qZsQ2+vM=;
 b=XQQP1utwN+GhiAdjyih7U0iqgi9tPyuoQ4sFidCydPTcHiBa+5zNvJ3PKIJI3Cp9OYIcxkySB7VRZZxSHoKwPeanhCSRW3u+hqhwErWx15O0I6Atgymh+9R5RGIMc2vEsvuxkF3r6VPp3RBX3s6T5Cx0Ep2tq27eryj4TVj7Gvg=
Received: from PH8P221CA0061.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::17)
 by CH2PR12MB4038.namprd12.prod.outlook.com (2603:10b6:610:7b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 13:43:58 +0000
Received: from MW3PEPF00001659.namprd21.prod.outlook.com
 (2603:10b6:510:349:cafe::16) by PH8P221CA0061.outlook.office365.com
 (2603:10b6:510:349::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 13:43:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW3PEPF00001659.mail.protection.outlook.com (10.167.249.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.0 via Frontend Transport; Mon, 9 Nov 2026 13:43:57 +0000
Received: from alysaliu-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 07:43:56 -0600
From: William Palacek <William.Palacek@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: <intel-xe@lists.freedesktop.org>, <matthew.auld@intel.com>,
 <arunpravin.paneerselvam@amd.com>, <joelagnelf@nvidia.com>,
 <sanjay.kumar.yadav@intel.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] gpu/buddy: find range-biased blocks in the free trees
Date: Mon, 9 Nov 2026 08:43:44 -0500
Message-ID: <20261109134346.3169162-1-William.Palacek@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PEPF00001659:EE_|CH2PR12MB4038:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eb34394-879a-4d26-5199-08df3e678126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|11063799006|261021121427099003|56012099006|261021123027099003|261022105027099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|10067099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: FLPfXNReEMOmvQkVS/i9aQhx1icvlP+CM16+5MUYKwVTSmP4yilcbMzTDlHO6uKHZI8Pc3JPU3XtogZXZweK8KVBlqvauTKOtZmqWQnsfLTOhhv8P+m/vd7QFGCiZAcASPeLlP8Faku83VBgvzL7UuyybtGhCjexf7g2L0XTatKeQcK1QPKiT0WcKheAMBy0TRQlHdsuQskLAgX402mDgBjL9YMDAsgjXdKlS1W5yhV9osSbz9G7YqCfQ3LQvkx1tZyyZudwPZPLU8C6knB7ZQTya8bxDDj5HZZl8hLPy8D5NkQQQnCp4IIdlG3n08BRP63s9SDeCPfanmMRAZMmtqQVkKNoKMRTj7YnF3+8tsBYtCav2GzO3Vi0tChPk8NlqTZiKLyke4oun2JgckzDkBnZudk8MZdvX3NihyA2dbATqJBxm1FgnwIL3SSkiELsn1tva7jNVfcOe6Glf+Hsdt88AWEr9SQqw0PlWoN9shJpVHd79kUpcvAFbxe1iqLO73wtozdBt6uzqWS/hEPsNOJQVlZOIDnE99pGmYuCsyZ4bJPlE+R+MUy3P5rkRebheTomYG/stPsiPcX8nA3hjGH59qTOhnorOKmvRIzBT+Jjua2HbRHg8qx8dpRUmeS/GiN5KZTDvSotz/B6vGtbEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(11063799006)(261021121427099003)(56012099006)(261021123027099003)(261022105027099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Nxb3kogZjizEfMZH374GpbcQm8gHou/E1QCsLPpvdWMKwBI7EN+0ZHhcHjPOTd4Jr7aSVJvV95Q8l3mUxJgrZDsyXLyV3DWK3o6fK5I+uEqOJzRYU8mHuqCADivlsAzy1w3vrHvHv2uSnYE1v0iPXWdLR3cZjaGIksriCHrkhIz3wfBnKURVDw+GZZUFM0smV6Ga1IWbospUqHQuDG6xmfg7KFik79wuouRZ9sMrngKtykny8kUeVCQWXTei2c1CC5AoLqLNRcIFI71x1h42Y07QK67SLEEBkCqDv1PgMk+FICGqgFbByp7TaDoQhN+UeuvAhJqwUfscuxm48dFqA08VzqU7QROU0jC9jU0vz/ZeTsyj+TmxyMlgwT1q5Ml01MtBuqOmrjVKVVSfPLXKzv6gDDETdaRqCbjIeAjr1nBZF4ZRjMsriAy5r+FqZu4f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 13:43:57.7870 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb34394-879a-4d26-5199-08df3e678126
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW3PEPF00001659.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4038
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A range-restricted allocation walks every split block in the range, so
its cost grows linearly with the number of live allocations there.
amdgpu restricts every VRAM allocation to its memory partition under
NPS2/NPS4, so on MI300X in CPX/NPS4 KFD allocation latency grows with
every live BO, under a VRAM manager lock shared by the compute
partitions.

Patch 1 narrows the walk to the highest free block wholly inside the
range, found in the offset-sorted free trees. Patch 2 adds a KUnit test
for the NPS4 pattern (range-biased, cleared, top-down, 64 KiB) that
also checks placement: 1190 ms before, 3 ms after.

v2:
- rebased onto drm-misc-next (single free tree) (Arun)
- take the highest contained block, keeping the walk's top-down
  placement, including for GPU_BUDDY_TOPDOWN_ALLOCATION (Arun)
- the test checks top-down placement
- placement differs from the full walk only for blocks straddling the
  upper range edge and for clear steering across blocks (see patch 1)

v1: https://patchwork.freedesktop.org/series/176957/

William Palacek (2):
  gpu/buddy: find range-biased blocks in the free trees
  gpu/tests/buddy: add range-biased allocation performance test

 drivers/gpu/buddy.c                | 35 +++++++++++++++++++++++++++++-
 drivers/gpu/tests/gpu_buddy_test.c | 27 +++++++++++++++++++++++
 2 files changed, 61 insertions(+), 1 deletion(-)


base-commit: 6f7098738fff3ec7393f924343188cb8e6ebc5d2
-- 
2.43.0

