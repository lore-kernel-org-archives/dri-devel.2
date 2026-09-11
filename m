Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41FA7C88E4D
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 19:13:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE56D10E548;
	Fri, 11 Sep 2026 19:13:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O/HnHzuq";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012030.outbound.protection.outlook.com [52.101.53.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 160A310E4FE;
 Fri, 11 Sep 2026 19:13:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oz65z6FC2b/ANT74jEsB/yQWixOrS0HVmfMBMrIBjngjnZ0FDzTuFxYStu2BsQE+/A9ndsX95/I8fK+5PQ/i9MJWJhNI5M0/OWd1QVOKSZBs6tQ7r/6/vctk4dCdnJer1/GWa0Piv71LvlN/XOuTM5GugAKS5Vfu9VwyF3Q+IRKV1C1/CugTchcPRYL17V9Ag7mxA5ovkNpkEdazzWpPGh04yW2KyPkLsiEoovEJxVNg7hCuFxLvqavjrOyuOS0m/Ew/hi/l4cBbizllsD6icsAYR5+putGmzO41DNdtUqTgsBJwGBzrX8Jhj3nIuNzy30iaRXC1ouM/p/HymXFroA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72IdhyQa5gsNwBfatUtiMBt4p5g479KGTD7hRCZmA34=;
 b=vN6Q0fBU3bbKzuEegfF5oT7fAHUDSpl4ALVOBarx9Q8GKL+g1n0zU1dhOmphYBKQOY38sOwwCtDp5ZyOuOcdGnJdv0ukKe5VSOS55BMzjMoOJ9wj6Ek0OpJtbGPNXmxyM5izXkYWkOhON1ieAgVfq9XwTvdn6O/cMWCH5DhD2u14l2DYMbLNmns1/t0goINCoc/aO3s0HuN8sBeECQPsfuDV+Ei0cK5mD2UZZa2fXlY2C6i5RKLm8zSN0KmWCjzrdX2D8Utg0h2V+YwhnwFr/dz0yCsyys2KIIdf+F7ZlAHrEsL+n6yR0sl46CzlUX2PGzLby+l8VY4Df+UK9pOWGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72IdhyQa5gsNwBfatUtiMBt4p5g479KGTD7hRCZmA34=;
 b=O/HnHzuqRJ9sU6bvwAZ47wno+g8BjLPhwcNIxls/2hMzVI7/XA2kQa8H048ZrB8JWJjpkfHfv2iEgboAsEvjJNkiSXPLgr0W0qdrCMJHjNsQmhhXNoQWBA3UVK2FkJOWmtwcafvl2PukZqJXIW5gSKHeQe+XkGolhUEJU9Khe6g=
Received: from CH0PR13CA0055.namprd13.prod.outlook.com (2603:10b6:610:b2::30)
 by SJ1PR12MB6217.namprd12.prod.outlook.com (2603:10b6:a03:458::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Fri, 11 Sep
 2026 19:13:25 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::7d) by CH0PR13CA0055.outlook.office365.com
 (2603:10b6:610:b2::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.4 via Frontend Transport; Fri, 11
 Sep 2026 19:13:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 19:13:25 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 14:13:24 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 11 Sep 2026 14:13:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <felix.kuehling@amd.com>
Subject: [PATCH] MAINTAINERS: update git tree for radeon, amdgpu, amdkfd
Date: Fri, 11 Sep 2026 15:13:16 -0400
Message-ID: <20260911191316.1705352-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|SJ1PR12MB6217:EE_
X-MS-Office365-Filtering-Correlation-Id: 88b51af3-0b4a-4ae7-e863-08df1038c11e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|13003099007|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: cYuFo0em50iR//7NgZxNQN1iOvxy+Xunlae5VEXOLcWpDYIHvUCpfucOTHBp2XB9mWwowee7ytW0PeZfTYzVl8faugZMbyGcFKKasnpiqOhM7EZOWIgAj8sPuiYbTfeXU6TZaAk652U0Of6/yocmTJ4Vzbyb650mPvtQ8YHwVsn8lbCujcuc2bIp5vRflJdVhD323+knmGbSN532L1Q52auZZ+v1eVcG6lURJ8EoqiXBb3K92/fi3csJC6lNlwu2VTNiTvuSVGp8J2yRVYGdioqBz8zePUdflXXoPcJvs81+9v/jgz2QwOaHYpnR/IzRQfaXz4g1ddh0h5YFaiNrcTwYkZhu0WzO3ec/HsURnDYFfqK6twePwudkQBu0ZcosIrTOOpuBW06dVYwM/0vFPvYg2aMLDvvHpsAJEb87KwcMxlkSZ+caqCpph6aQv+PekbzQKddZQLMNyKuGv5e2BTYFOAHL6e4kHytaofHJ4cymFXZLnoTq+kQlhul8cx+KAHqEcwRjoANvdqXfxyMwq0fz9eZNktWCl73jkElX5JvJ6pjXFWi8kwSGAg0C3pdWMof5Y+3ZHGRgTC6f9ikqKwwuvB5tgT09NlrA1JA4h8KVzdsm33+NYxJYs6wZal3iwMJ69dcK7qyhPHALwGGQXQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(13003099007)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bDfj/V0DhYIbUbg5Zq9WggPsSiyypM+xSpRArvVlyEC0E/hXfH2RvgZyZLTz8/fJ5b66gnFHnI1TlfovsUtF9jz/2oVRXrIDUabNBZINJSpQWFn/NgQ983oyqMeDxaec6l5J/cLCr9dBlJqHwyZoT8iT6FMFMAW27BTDdesEE+ZDYouwfoORf7CvR2/Zewu7L7wm0W1NZaJfmQdKZj9UD/xeyn1KqbR4cRHDOQzIjQYlA2P8F6encB199+BNkOgmkO8lpZegPPLw5Jz2ZVhlLFeYD46Esbi8s1Zp33H7+EiWfxRsyRblaZncmDFwFJDwdvt+tluBqpJW7r2VhT1zPhpMu+mqz+CVyuE2xmK5WXWZpe7jwn/uQsE+9YIvPsQgNqXLC3DJXBpq9UJsFDdULaO42Y5Q0cDwfrMuLeBz+5BDHAuxWm5F4kblcLVdTZaC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 19:13:25.3539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b51af3-0b4a-4ae7-e863-08df1038c11e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6217
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

Point to the new repo on gitlab.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: christian.koenig@amd.com
Cc: felix.kuehling@amd.com
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cc2d3e4275654..4c5ad2d7f3f88 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1188,7 +1188,7 @@ AMD KFD
 M:	Felix Kuehling <Felix.Kuehling@amd.com>
 L:	amd-gfx@lists.freedesktop.org
 S:	Supported
-T:	git https://gitlab.freedesktop.org/agd5f/linux.git
+T:	git https://gitlab.freedesktop.org/drm/amdgpu/kernel.git
 F:	drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd*.[ch]
 F:	drivers/gpu/drm/amd/amdkfd/
 F:	drivers/gpu/drm/amd/include/cik_structs.h
@@ -22193,7 +22193,7 @@ L:	amd-gfx@lists.freedesktop.org
 S:	Supported
 B:	https://gitlab.freedesktop.org/drm/amd/-/issues
 C:	irc://irc.oftc.net/radeon
-T:	git https://gitlab.freedesktop.org/agd5f/linux.git
+T:	git https://gitlab.freedesktop.org/drm/amdgpu/kernel.git
 F:	Documentation/gpu/amdgpu/
 F:	drivers/gpu/drm/amd/
 F:	drivers/gpu/drm/ci/xfails/amd*
-- 
2.55.0

