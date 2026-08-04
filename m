Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9CBC55ABF
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 14:34:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 667AF10EA95;
	Tue,  4 Aug 2026 14:34:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vG/xkFWw";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010030.outbound.protection.outlook.com
 [52.101.193.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98A4110E193;
 Tue,  4 Aug 2026 14:34:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C5FcgabDJuwuqm/DV+qmWVksHNBLG5sOe5uc2PfOTkofPMoJblUdzzMJjgI8Wei8IkrriLP0AmJEAm7XnLwh37feq2YW9a64MqLHLOnWKL6vpowE08scuxC2uu1ITrptUX11A1rkTBR4DqsVcs1eeybnjCN4XA7zxWiPofhp1/2SwFl8K27xHZyh89MHyod0nJTUNU2sfo191oDp98vrzbVytFnwzRxOovmhSuVyHJCdpxHFGVb/ySAoxvE0uFgedjbHzUbeZ3yyglnqd3O7BsPouT9BccFSwUNADe1WfCsSUnd5O18aBlvJInGWiPk2X8anM8ZfIpFG6Yif0c2I0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhsJu7xV5bZ8k1Y2uQ1DdVWjUGfZKPEDmL/U10TRxsc=;
 b=WfwQ6UN9uaumKv4ZyIcRtCvHLJvf/aPaO83/8+qVzE+LD7WBZccZcdHymEP+v3QYa4QyQamS5PIqEzOoGji551ijk0eWL9FLCoPTEP1n8ciUBbQBSVxpAO20pQcKbgIDUj6BSzKaUx9aA3hLoW/nJXMO3nAG0q13mdG7671Y1Xkf78q78J2Ux8k0rC1Wg9VYw/J80e/4uary4NYZF2d9L5MNQ1UzNYz0OGIaCcxKeTsMnCikmQjkp3lVRWHbK2eBz3LzwjAAjncGlKiWWxRKaSnpUgBaojq+ntA90V6mazUFGQ2KoOOzPuaQ4uLWZRMbtIZeppNcTc7KHbebuEnZVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhsJu7xV5bZ8k1Y2uQ1DdVWjUGfZKPEDmL/U10TRxsc=;
 b=vG/xkFWwnLzSkt31vjfmXE7wSQYDXjTuR/zVMugeKED5q6Bv9k6CX5k8y1BrNzMZiAbM9uR9kWKZn6yivE42UTOFyLy/O9LDI3lWAdS5RZMHMU0AUNHPXd/0FlGvrT2L7Z5WmeLhu/UKeEberY9s1XVlZE2c7fWzypYxUz7XT6s=
Received: from MW4PR04CA0037.namprd04.prod.outlook.com (2603:10b6:303:6a::12)
 by CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 14:33:59 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:303:6a:cafe::2e) by MW4PR04CA0037.outlook.office365.com
 (2603:10b6:303:6a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Tue, 4
 Aug 2026 14:33:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 14:33:58 +0000
Received: from MKMALEXHUAN01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 09:33:57 -0500
From: Alex Huang <Alex.Huang2@amd.com>
To: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <harry.wentland@amd.com>, <sunpeng.li@amd.com>, <siqueira@igalia.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>, <alex.hung@amd.com>
CC: <superm1@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, Alex Huang
 <Alex.Huang2@amd.com>
Subject: [PATCH v3 0/4] drm/edid: Parse AMD VSDB FreeSync range in common code
Date: Tue, 4 Aug 2026 10:33:35 -0400
Message-ID: <20260804143339.714548-1-Alex.Huang2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|CY8PR12MB7491:EE_
X-MS-Office365-Filtering-Correlation-Id: 47979a7d-16ee-4e72-ffc3-08def2356b89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|36860700016|82310400026|1800799024|921020|10067099003|56012099006|5023799004|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: UwuQ9KiNUYjSMivVC9i8aOZXY6kxH5zJvx7GHSNMktimkkBwXjXjct9x49yfgMWQ9GAm7T2FN+GTo+ZYFNq9OcrsSo8EcBUITaNkmrQoKTynkW7ljhUllMu32urYTiwQzSM5LrmtomReYPg6qLzHcDKBJJWcZPFTK0D9af8U6azG7jQMEKh+ftXCaGj2ccccp8Bb+X/hp6wlZ8S2QZP2N5xokXfubE1tqzrc9nxd0pKLD2dn5sXm9uHMxXZpp099CbIGM3bHRz64gltYXzkOCWol6gLnNOgvp6P7qMroI81Wgq+BZ9VVeHBtr42ZDqfuqD6I57gQKI2umylNyoRs+eLHJb92TsO9bhMkJC2SXLurp16UxWmL1GN9oa/PX+bSLDElRKWe45WV6aBHrBF941pCNxjFqaIHKO/FPvxMi5V84tF504OkGEi8qHlpRK1qoUhS3c9Y1nNqSCapq4LPQCz/J4SV1tJn9VgcFKci23dtNDIRQnwoIC86Li6kaoCUuyph61EQEQ0GxFe3Ix30pRubuic+UvPOc4D/iUC0wFiYMLvQu4d86cY1baW9UJigLabdMnMWgHEVTewyU4dRLF3115upr/oG2a0ifaGl6YY0YAj5Fl2+BqAS8icgmbi7cmnqA3X0uz++R7OpjkpiGJLVGfDynFg5qZuEhVlJqPPY2HQPP6kZdIz1/OA5Aiu8uXtlUFFT4YpQ3wTlzwnrOyE1sGxVj8golPRKeEqms+LP1qGPwywF2QJI5j2TJek1
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(921020)(10067099003)(56012099006)(5023799004)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jmbr1WrGq6SCdF8KHSL8kA/nyHmFT0mDI/Ek0/4JXyyHX9NVAlyflAi/4pu98LsH4PWHltewWlIqcsoVZi/J1LIn+1FvzWsyKV3zPjQ3RhLWtSgaW50uv4MPMmBKgULu+vM6ZR73Nb9y3dDVMY/YYKXu4pqNBAXAOQlHlyq1MGQyMyso13WpPnbE/O0EeWZft3U10Y2AHVRcHvWgaO5uDoXa4vm+u+YBXj7P7lmwwSBMMS/DIyWFz7tR9cl0sjmfI2okxZr1G8jRkUuMddXV7i4w7u45VKEv0IVy6HgUX3jzWVPJhIMvJ/N0kdbStj2GVrckhgwaZ3n9PPsWPsOr2gCXf025MHlHetNj+JFjbdsoQe8Lnmu768Zo1ktJPas+a7x+IiPVEL5HLcfePklhcBVOmDNDaVjOejh0KAK9n36ip1dxcHgbMwISgb1SB/rG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 14:33:58.3101 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47979a7d-16ee-4e72-ffc3-08def2356b89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7491
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

This patch series implements parsing for AMD VSDB block's FreeSync
related data directly in the EDID common parser.

Some monitor manufacturers advertise their VRR capability exclusively
using the AMD VSDB block's FreeSync data fields, many other
manufacturers (notably pre EDID 1.4 monitors and some post 1.4 monitors)
also do not include the relevant continuous frequency feature flag in
the EDID. This makes it difficult to differentiate true VRR capability
from supporting a few refresh rates between the range specified in EDID
refresh rate range field in a spec compliant manner.

Incidentally also resolves a recent regression where amdgpu failed to
detect some DP monitors as VRR capable after EDID parser was moved to
DRM common.

v2:
- Use a ladder style parser as suggested by Mario.
- Validate payload lengths before parsing.
- Removed an extra amd_vsdb_version reassignment.

v3:
- Parse future versions as v3 block as suggested by Mario.

Alex Huang (4):
  drm/edid: Parse AMD VSDB for FreeSync refresh range
  drm/amd/display: Use HDMI FreeSync range from common EDID parser
  drm/amd/display: Clean up FreeSync capability detection
  drm/amd/display: Remove unused DMCU/DMUB EDID CEA parser

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 252 +++---------------
 drivers/gpu/drm/amd/display/dc/Makefile       |   1 -
 .../gpu/drm/amd/display/dc/dc_edid_parser.c   |  80 ------
 .../gpu/drm/amd/display/dc/dc_edid_parser.h   |  44 ---
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c | 121 ---------
 drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h  |  10 -
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  71 -----
 drivers/gpu/drm/drm_edid.c                    | 147 ++++++++--
 include/drm/drm_connector.h                   |  22 +-
 9 files changed, 181 insertions(+), 567 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dc_edid_parser.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dc_edid_parser.h

-- 
2.34.1

