Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 908B2C4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 16:46:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2DD610E524;
	Tue, 21 Jul 2026 16:46:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2ICDNDNy";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011023.outbound.protection.outlook.com [52.101.57.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1197610E303;
 Tue, 21 Jul 2026 16:46:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c4B3Askdi+SQKFQUD/tg9eVa5dP1Kyij30Plm2NRTxlwa6zt2FsUnySTQzjP1ukQ4i/7UNYG5Z2F1OHIuyc3fM1BPj1SUCB+Y1CzFrtDrH555n0sDbk41U7iPPZM0PGEIMiCDYHuKMrlFiFgS8bZ1AGCZ+OAQ+C2E94Th19lhJZbgZhHHQC2cxXIV0oC/TQzP758x9hQnVY7lR3dTbzc95+tW5KDoeI3oOs0d4d7w+OexJsuB3tXY9ykK8tKsKDYnxBlduxHMg/ljEHdFg+JcAdiP4qU7fd+0WB2laeUh9vLHfYphkU2f7VzYsH4qBaIGKC2cdIjVFqk0xtALGlKnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+O/1u3/IikjiOrLTW/GkZ2TaEBK23wjvagEDiFgbouI=;
 b=DEwReEALTGMDXcuIqLjM5S+UUVvPvcq1n95NxAfSJNpZoSbeQbqabHOZwyQF2C9Ed0AwlKMipidVzpH9kKlGz9O3NkDsl6cyjVwZ6XfacOnhH/gzjdLqfsWghi7Eo45f63lku4iMX70akxgqgBnFQ4Po+FWZmrkEkDfqquQ8FVkyD9Uoup9/YSLZn/v+DtkBwH9nl4tHv7ag8/h0PSbpkCCUz/At/XOEz3chpwOFZxWg7Wz4DFNbAB/2qip7hTnrK0o4fyD25jBdVzRMFQSf+wEioJA8E43v83BGM4PUOMtVEZkBUx7nNoFaWAVL4n2wmatD/7STyMwqXyiGSM0M0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+O/1u3/IikjiOrLTW/GkZ2TaEBK23wjvagEDiFgbouI=;
 b=2ICDNDNy8Wa1uN8Gun4nW6/YZgg7rYZc5uTbcg+FV4nYdmTzV7N/LEo3jM3XuQ8TF0q3kUxwNjeBlD++Ic7te354BDfRR0Xd2Ub21vjQqBytYguLMFCfWzUU3MbvlA8Kq35lIdL0EJoDBeg46nNBdxFI7JAz9hwKifxKnOQrgxA=
Received: from BN1PR13CA0012.namprd13.prod.outlook.com (2603:10b6:408:e2::17)
 by BL3PR12MB6596.namprd12.prod.outlook.com (2603:10b6:208:38f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 16:46:04 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:408:e2:cafe::52) by BN1PR13CA0012.outlook.office365.com
 (2603:10b6:408:e2::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 16:46:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 16:46:03 +0000
Received: from MKMALEXHUAN01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 11:46:02 -0500
From: Alex Huang <Alex.Huang2@amd.com>
To: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <harry.wentland@amd.com>, <sunpeng.li@amd.com>, <siqueira@igalia.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <superm1@kernel.org>, <alex.hung@amd.com>
CC: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Alex Huang <Alex.Huang2@amd.com>
Subject: [PATCH 0/4] drm/edid: Parse AMD VSDB FreeSync range in common code
Date: Tue, 21 Jul 2026 12:44:26 -0400
Message-ID: <20260721164430.2121326-1-Alex.Huang2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|BL3PR12MB6596:EE_
X-MS-Office365-Filtering-Correlation-Id: 97db2580-3e89-4bf6-2a57-08dee7478d9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|7416014|23010399003|376014|18002099003|10067099003|5023799004|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info: gSRpYdegywAIhJWdvnxamlsWwA0Gdx4Ih06pMrb60ly4MWZnfvWlt27E8A/PwaXrJM0DaBN2QQmC0YVyZVWfgpCMsvFQ+TTUuaSoXFPpneJ4xhOyr4W4MxfFnPZY5J7K/UsJ1I78jlGirDEHrqz39xwvlMq7rr1CeK6GjAeFbdCv6EIUy9ev1V3oy9dSMIQd5CD+nJzOciYaEkv003GmXyao+hLY9e+X/Qvq3Hhjq2d9SnIY8d8PWMAHsWbTqxbvVKqc/7t7qMOAwIMrYXqmY3gzt6uzUE1wwQfrn2g9dJxWbVctlO1SIjaXxa9Hir9NbhJA8D/Zwes40egTuZ0mibDje+rvQBmZqGsktrs5xbd3V2HGSTlqwLAz6+o5GPiGo6gK2HINQwY4MsSLpB/mN/4DKL7soZKblzkG7NYaJiyd7blUlb+Ot1cx0itSb2GhXoWzPfk19DyoSr0hacH7zj3nn3FbFavBRGmmYiC12q/O/mVMrpcE/3tp4GTaBHoiADM3/lXlHXhoBNUwuWzsnOFa4t/xuPcc38q8ZB1peBgCy8fE+zSXaNmo+UnOpGpDSnAoWfjsZLF1ffIDrYEjmAt/nJcQId8mbJxPt8HWJfHAQ97iiZq/uyymFbByu8oemmU5NibIi7hs1kJFXLIcF71sT8TpZSVq/+D7cloPK4+uTvtnlkeQnpf7WDl0IH59doZeKBe6cMecnb7r1F8KJt4YBVuGUCSu+Q1yjNhLsManed1PZmUj6n1xtiYPrtc/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(23010399003)(376014)(18002099003)(10067099003)(5023799004)(11063799006)(56012099006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wPZ3wIwFaHBw4vShXe3KjHQ04mdVX/Qtk4I1BOtQgCaaRGYoav9M7edFC4RGc3gzEz17lXbU0vwIZvD99BtlTkKXtEOso7+PG1Me6Kea8HNsqfOyy7RX74H9SE56L4tL+EqSOC/GkFsObnEAlAG5+NW3chxzmzS5gGPUFLee1UhflnYnYVwhdJCFUo/k5/NewhoxwSTRVo+xXctP/BAs/zW6eIOGKRMbUaBW4VyMHQkiVch5SyBBqovd+bFWZ8qtJENO9D/owaBK3KemRdMqAbszB88Fg2yMCBWomnITgybFb+R/i0nRkqXFU8DnEZpPrIAIC91xODd+ov0CNI4DRhFt4nKTMdRagFb+5gOTXZwANGQrzK6bRDcOcfoSVOk8ntG4Ak3v6gaM3h5lCFAQS/f/zrg6RTaIA4Eq7fEdoUcn7TMULRDlqU3/aeyKKjbN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 16:46:03.7133 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97db2580-3e89-4bf6-2a57-08dee7478d9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6596
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

Alex Huang (4):
  drm/edid: Parse AMD VSDB for FreeSync refresh range
  drm/amd/display: Use HDMI FreeSync range from common EDID parser
  drm/amd/display: Refactor FreeSync capability detection flow
  drm/amd/display: Remove unused DMCU/DMUB EDID CEA parser

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 252 +++---------------
 drivers/gpu/drm/amd/display/dc/Makefile       |   1 -
 .../gpu/drm/amd/display/dc/dc_edid_parser.c   |  80 ------
 .../gpu/drm/amd/display/dc/dc_edid_parser.h   |  44 ---
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c | 121 ---------
 drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h  |  10 -
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  71 -----
 drivers/gpu/drm/drm_edid.c                    | 134 ++++++++--
 include/drm/drm_connector.h                   |  22 +-
 9 files changed, 169 insertions(+), 566 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dc_edid_parser.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dc_edid_parser.h

-- 
2.34.1

