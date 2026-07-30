Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70EAC55164
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 15:00:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DE2710E191;
	Thu, 30 Jul 2026 15:00:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZPt55iuv";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010036.outbound.protection.outlook.com [52.101.56.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC2DD10E191;
 Thu, 30 Jul 2026 15:00:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+OqsohDOUOJNmvfgkzbZItontM5rolFGOHG6kN6/BzgKKnqxlldU137dTUe2Ft/smt6F12Tf1LdCqurZcgYSXDnsyynCTbKyp0DxoQ2xYyOfV4GJ9mpQLXWNrz/2uhDMB/fwEzVlFqJwwscPWqY0uxeee9Or1xodoshj2jNKq/rImjne8TGQPvC63qjjDY64ak6BDXHuBatbNzMWbwsntxeSQpCCbxM3hxahlc4mwjsFxXUdW0TyhkJ36ONrcyr9FptY59a6DnVZOwQeSZux9bz1Jc5pPv88tMcWbV6I1cmpw6f/Zh3Sz8lTuFDtusoAG8Y7S/qkg/Wh3aITWFarw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efAIAEBmxoDDjozZCxTk5HlbhQ8EvEnUrOEcGPwS1JE=;
 b=ixZmQszkilAcR3zz7kiyDxJ6MHsKgna4XHwYEop6IjJPzTsDWOZincQPlPGkUurVmENwMqfXcT4UPHDEknNLVb7HxWIx7NYhsrBT/NOdmLz2f6PXA4XNz0xJhggiit+TUZJnF2ODXh/yfPCeR8AVYPX9b5P9G45GCdIZ3/14Vcf51Gjn5ilNvsJrG+iOGlP+us4ci6qBzw2vrcZftX8ZdAgLRCls1ZIS9X5MQSKWq1e3Iv71uUlJFCn9I8fNYIr8pVts5DQMz9C+RxjtsehlYsn9I/hbccOMkL8GyzHXs6CeFaKuVbsM5laDPXuNQQYiV5yZvBqbRWnqJ3NbS2LtdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efAIAEBmxoDDjozZCxTk5HlbhQ8EvEnUrOEcGPwS1JE=;
 b=ZPt55iuvcrle8iQlEPXpZP6q86qjri3fXMnSXQE+fWpkcPr3dfUm3sQGiayNRqobnHHADsa1HKplh2TjpEqeERL6xogZGq3+stUs0Y+cndMebtOxIb+sXSWmpUrkNBb2C/sTjDNIx7aVtVmAe5AJ52uq8xlDy5088SMnq3y3huo=
Received: from PH7P221CA0038.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::7)
 by MN0PR12MB5954.namprd12.prod.outlook.com (2603:10b6:208:37d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 15:00:26 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:510:33c:cafe::51) by PH7P221CA0038.outlook.office365.com
 (2603:10b6:510:33c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.15 via Frontend Transport; Thu,
 30 Jul 2026 15:00:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.1 via Frontend Transport; Thu, 30 Jul 2026 15:00:26 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 10:00:25 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 08:00:25 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 30 Jul 2026 10:00:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu drm-fixes-7.2
Date: Thu, 30 Jul 2026 11:00:18 -0400
Message-ID: <20260730150018.801791-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|MN0PR12MB5954:EE_
X-MS-Office365-Filtering-Correlation-Id: 4442734f-2a89-4609-2ebc-08deee4b49d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|18002099003|13003099007|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: U+ZhISzv63Udg+LZ9qUauiBD2oggPK2arEapgTqR9nzq4znRcaIvuQ2FQNlXmoPi0INkcvkGN/qgHwwRVri3jsJpULHmHHBD09cPDjiOyj7IGJbK6Gs5piilN49B5KZef/BvbiJlsckMNKjnmBPul5Dbl7KiUqUOiJSTVT/98wEMB3fLz6DX5+phgAICwWLjHiBmr48YeTTJRWUzK9Qc9BHUvWANFTq3nqJ8Rm7N5wOTaoKVuNhUQaEYFlYPRcCEhqIvNeUFyrWKSNw+reo8blmB94QaH5/JlSbjJ9tjkKtEiB/9ImMmHNtCd0dIxMz25rHPkLJkiOOBOpaVPtA7gIeeFoEL1/kaZ4JmU1DjOhjYqyq/rB2DqgWINlxCETXhhdM2YosQHem8O9mWEHR20F9KUXjUJ1yX99gm81+ofblzTQ1tE8SduiOzIzfPIXyQcgPkMVwEcVYIaU9ptWoe4C1eAW85uWO40p8UM1WJuMhC7NSm/F630nrBhp5beyWMe5VTvy2Nee3b3Qf21y3v50uKf08fnOUWjcJ9+XOXzOYGlxuTRDgosjVUjk6pN4vP/AtJFAg6PV5/UejxbYh2d6LHghKugOg2WcWbuFCX+e+4jI2thCiKei+VMvixZ4WAHfZIJawlcRrqhg5wYFzdZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(18002099003)(13003099007)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AMU6/cZgtZraLb/K+wX+BMz0OOJzzikeXSvjo0c+t8/7EqCtc8BfnkY/AlcVB/1QGDWpOZ1MA9CSa6qrljW64GQnFrVNbwxXkjJ72AjzVnZHPhoz7GPSZaYjQeB9pVUi0zBfQ3VT3eR74dx+YXcS5Vjt5okowIQgcvlJ9PvAcqOBZKhg11I8YY5XzCiRbDVDztWkmlNFAbgF3kYl5ACqVdgEeXCIah0daj9BB+OvnbNRyHxIRqit/KH+r9cM3TLmgi32TlYpG+TNskAYDMRbE0DkTRPlJFto2ZgCSOUbOKfzUh2DlGs2LIZLMLmwZQV8n3rE07cpni0vh52SFq0fE6x10wgeX9yP+BlDqVsXP+7+ygBFDtzaZc1xAF2Gqnu1aaTh9OZBlFYaApLhvk0nYj+kr9TGxnPyHGWeJQG0tXsjTJyw4IIQAqB1SWlHNgT9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 15:00:26.0796 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4442734f-2a89-4609-2ebc-08deee4b49d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5954
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

Hi Dave, Simona,

Two more small fixes for 7.2 on top of yesterday's PR.

The following changes since commit 114b42507b6a23d9d24e24e4ef165233332c64d4:

  drm/amd/display: use proper context for logging (2026-07-28 20:01:24 -0400)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-fixes-7.2-2026-07-30

for you to fetch changes up to 8419331e64d92a8de5fc4feef0e305f201fb8b33:

  drm/amd/display: Exit idle optimizations before programming (2026-07-29 18:21:24 -0400)

----------------------------------------------------------------
amd-drm-fixes-7.2-2026-07-30:

amdgpu:
- PM sysfs fix for APUs
- Follow on pageflip timeout fix

----------------------------------------------------------------
Leo Li (1):
      drm/amd/display: Exit idle optimizations before programming

Yang Wang (1):
      drm/amd/pm: hide pp_table sysfs on APUs

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 78 +++++++++++++----------
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c               | 13 +++-
 2 files changed, 57 insertions(+), 34 deletions(-)
