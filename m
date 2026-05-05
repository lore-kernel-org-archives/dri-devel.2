Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D27CD3427
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 16:21:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E66B10EB63;
	Tue,  5 May 2026 16:21:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dQ8MIwoY";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011041.outbound.protection.outlook.com [52.101.52.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48D3110EB63;
 Tue,  5 May 2026 16:21:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RV4s6TE3OZWLHCayT6qYgXPp6dthyWuy0/esw4CaiCck+6e4VBojGz/suEp4ltBLhxkvAlmCKqR1m6SSbWr14Q3gSKWqW0ilewuXepqPfLIIDLVz4MbfN0B+YlNkHMUSWAIp+yWbaOvILRRkgCHzmtKET2gPAb1xn0dbfEKVN+RWyi4pfU+3uU5F3iQi1qBkg1QjVsf0DmoEhK9qEJD7j/HHKWSoJgU5BrDupEuxBLWcBYIHaKlUWbeKJtTutAq+zokDygEWMvBzi+SYwMF4XbwHvxikhBhWXazugIAYSM9sdQSFq1xAWr7EU3CUANIpIr41MkewfE7C+Sn1b8lsEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AowH6PFUClhkw7yKu+hkxTVCHWAnEdEVKdxF6OUa43s=;
 b=QHGru64VJcuO1aojCFy8XOAiJcp5dpnBG93ZPs2Zi3OkVla4WmU/ac3MWdILEITFaSofMSoJ6tUhzoNOZte91aSJmBw4FXaeosVZmZquWjPhx/k/iOizQSIxX3ixBuW/w7TJNaplQ7zUCGOTIgyhjY1+p+BRfM5EVm9Iag/gP899KjTvrk65ZgDxZS6uQvrBAysTJ0iFb3ILpFupyxp1znEfhGLp6ZVmgZD2IExamTxR+HaB8wWrs5MFFfDLEz5dVwsQMoUzpd+wWJiKDnuRA5t5S5iMKPKVvfpukXsZnSuQgkMytiMP+TRMKuThq8NUmdVnahommeQK1fm2r0LJPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AowH6PFUClhkw7yKu+hkxTVCHWAnEdEVKdxF6OUa43s=;
 b=dQ8MIwoYywn28le9tAxlxH4qrwT4EWortzo+jCG0ZJC/yKeRdZMGoE9xL0vHSjGBUUyOKJo4BGgkh7yaSNIO3Oicy5OhlBunMGg0/4D/5G4YvRBDOmfDvijbv78FNBpJHohBcpSpmkrM/XqdjO2oRvER84poXxtNqgniB41eP9I=
Received: from CH3P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::8)
 by IA0PR12MB7774.namprd12.prod.outlook.com (2603:10b6:208:430::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 16:20:56 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:1e8:cafe::da) by CH3P220CA0015.outlook.office365.com
 (2603:10b6:610:1e8::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Tue,
 5 May 2026 16:20:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 16:20:53 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 11:20:51 -0500
From: Alex Hung <alex.hung@amd.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <timur.kristof@gmail.com>,
 <pratap.nirujogi@amd.com>, <vitaly.prosyak@amd.com>,
 <harry.wentland@amd.com>, <alex.hung@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Remove UML build exclusion from Kconfig
Date: Tue, 5 May 2026 10:20:18 -0600
Message-ID: <20260505162018.1755740-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|IA0PR12MB7774:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c6c6016-779a-4277-7d76-08deaac247cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: oD923n3H3T2lIQnDUp6pWGevhBqbXp21HrZOCzrIe1WngD4zkTGxwuYmNKCzmajT8Vli1vp9X08b0ApY9I2oI+xwzuSf3jz9/hJ+pNSKiD4VcGNCTFlALelJ0g6MTkP9d02zWLCHWa6Bc1wH3G/H9kNcRTLzQxNGVDlhUUCa95GaAevbywAonA6QGfu3gqxvmhinqmfsgDJmw5EoxNb/UdgrPI+GBMqr+RDBwFh9RXLa7tvz0fkob0HprpgwhYd6jOaySOwzuZrk9reqDHlb+CxbolNF9KkBcr4316iTKyxPjdO+gMugSvHYFWh7vtaB1ElRyceaKdbSie+kzn2b4IPJf953+FavU3jQOqcZNEjZcBj1d5wGa7b4ROwj+j2kBQzGDuhTCpYkGIz7Htt1d3Nw7cZ3GoYfPAqa40wmK/iZ+uKtINirLqoYZ+JInbzOurFGpS9N5dviWmKAnYwYUJKicRD/WxwGIbwsfeBnm8OXZ5GKeUZey0sodkjXYFizZ0PwLSdAU3X/x7V158RwnBe0Vpw8uDWfBt737KJ+fCK3WuHPXIrhzHBqwaGnUxNVvi4+tQQtAJROwONuqvUad0Gwbua5S7qyvwHokD4ive79GkKReI3gPmSzoXZh7Zo6LDMO1gSu2SZI7nKUNN97N30XnlB84Aqnyjviqsyc+jdgffJfWCeqYlQA880ky2TNb9QG1ZelddLZIjc3yZIpVzbwIjXWt2oX9PW8GLnQ6twnyAwA4VR5751he/Rycn9I/a2P0vmBJb3piR3itDsWag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(921020)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rqSwtnP9AMEzg4IatQ7kLzvXpqefn1oPcxaGYpYxIftVUI2RneGt5VF0JQvu2Cc5OlrsNQ/AlvKWlmzZJCm5hMGcWIbQ+e1KSuVLW0GwatLw1l2xwu/hzShpvhyrRPbRbyCm5D9YhzXWYaZlaMRHyzXs0TAmZ47NPHlerkLCGVjnvwCCdiNXbk1T4dKfXjjfsx1bDVfPSnqXA/7dwB/wXqpkOAiiOFko/Gki5cYlbJ0hrUmQc/uVsTuL6Vn+L+cpBp+rZgDNTj2+Ra4mVE18sih3YoZjrjanQbs6GJ1nnM7Yo2PMr+JT8LWLgqANQLj7eF+8ZVFqPw4cCQhc/oqfozncXIPfzUGVXEAfH7vwezGJeJemiqoKcYfvAuD44JCNcZnfv2dcK/JPwdvSzmDGAVTPVRPIu/9GOiVH/CD/rwfsl+UWpWCBHfc11xR2x6pG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 16:20:53.7789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c6c6016-779a-4277-7d76-08deaac247cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7774
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

From: Harry Wentland <harry.wentland@amd.com>

The depends on !UML was added in commit dffe68131707 ("amdgpu: Avoid
building on UML") to work around build failures with allyesconfig on
UML. The original errors were:

 - smu7_hwmgr.c: incompatible pointer type 'struct cpuinfo_um *' vs
   'struct cpuinfo_x86 *' in intel_core_rkl_chk()
 - kfd_topology.c: 'struct cpuinfo_um' has no member named 'apicid'

Both issues have since been resolved independently:
 - intel_core_rkl_chk() has been removed entirely.
 - kfd_topology.c now uses a proper #ifdef CONFIG_X86_64 guard.
 - All other cpuinfo_x86/cpu_data() references in the driver are
   guarded by #if IS_ENABLED(CONFIG_X86) or #ifdef CONFIG_X86_64.

Removing this exclusion allows CONFIG_DRM_AMDGPU to be selected on UML,
which in turn enables running KUnit tests (such as amdgpu_dm_crc_test)
under UML without needing a full hardware-capable kernel build.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
index 0d4ce2ef9da6..49a7360f45ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/Kconfig
+++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
@@ -3,7 +3,6 @@
 config DRM_AMDGPU
 	tristate "AMD GPU"
 	depends on DRM && PCI
-	depends on !UML
 	select FW_LOADER
 	select DRM_CLIENT
 	select DRM_CLIENT_SELECTION
--
2.43.0

