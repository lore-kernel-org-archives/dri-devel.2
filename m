Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 522FDC5CFDB
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 16:43:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92B4710E58C;
	Fri, 14 Aug 2026 16:43:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vcoWOX0b";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013030.outbound.protection.outlook.com
 [40.107.201.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FB5910E584;
 Fri, 14 Aug 2026 16:43:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ldLmNQiuWpkOw/R7gQPvzUDK76iOxg2dUpZqa7cxRP5ffauG/NeAgaAVtSGr/sS58dKG2TCi/ynSf/1yJ+J/wAgyDfOpJnujffOJeX9q+Clk7DRPf5TPOScT0LaQyXnlbyr6ECBWvackqpq/LoLhR244oQKp7e9tPg/wrMd45NPdfIYsXH1zfzC232nQuQAVFQV5GiwU2zEyH/SUxxenTbZxVDwTMaLbE/wR8id6W2aqM9kJkKIJoXYnfetljvJwE1zgZW4DnOHYA3HCq9RBPWW+JYx/xF1A/4gbssEwoyxXhghtqj5z+NcgpdhGXZ1fYLEn6pg18i0LRJ5W2WAsFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DDkXXt/wCXHY7cZODYoEQS2CgGeRdFq2SS2uv9IliA=;
 b=WHLmL93AYBtvm3JygWWJU9xXFRuYL4itzXBOprDyswbSD6dk99shn+aidDiStukIzks7jSppqY6BKLTbKbR0z7BlcPwDCCXGe657LzNeDt7Mh3mag1EjU/MaSVoj4FRNx4AJZjxRwOSA/Ad9HRYxJN6PI9gyRz67HjJkzynY4qwZ/dzShdBEuiQvBUqPoXzkQH84TelK7l01VByFRiFvDhx7//uTLVvQH07Qh0ckfH4+DN+6USYJzSvOf7Gobl9Sv6aj1Qn/4fsXSjz+55ApVMRMfV+3RKZa/ejTAo1RC70iNR1QA5wrsFbq2vZZA9VcQo3nZFsMTbH3eGVROPaIZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DDkXXt/wCXHY7cZODYoEQS2CgGeRdFq2SS2uv9IliA=;
 b=vcoWOX0bXHapcMmZmXD5oXEPX1BQGvh7Uz0f6tzT22/fw/2ZcZ1Q4n4VDg/h2o0iFo1xdwt0T1IioxvKgM0k5ik0o1Ca1UndI9KqtveLRBe9iOl/dOw6L8ezxbTpyen4i/cJaBap+h3XrthE5sizptcfRvB/JN2dkcTN3cgEU+8=
Received: from BL1PR13CA0013.namprd13.prod.outlook.com (2603:10b6:208:256::18)
 by PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Fri, 14 Aug
 2026 16:43:30 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:208:256:cafe::a6) by BL1PR13CA0013.outlook.office365.com
 (2603:10b6:208:256::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3 via Frontend Transport; Fri, 14
 Aug 2026 16:43:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.0 via Frontend Transport; Fri, 14 Aug 2026 16:43:27 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 11:43:26 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Harry Wentland
 <harry.wentland@amd.com>, =?UTF-8?q?Tomasz=20Paku=C5=82a?=
 <tomasz.pakula.oficjalny@gmail.com>, <daniel@fooishbar.org>, Fangzhi Zuo
 <jerry.zuo@amd.com>
Subject: [PATCH v4 0/4] HDMI 2.1 VRR and ALLM support
Date: Fri, 14 Aug 2026 12:43:40 -0400
Message-ID: <20260814164344.3098143-1-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811003921.1398292-1-jerry.zuo@amd.com>
References: <20260811003921.1398292-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|PH8PR12MB7301:EE_
X-MS-Office365-Filtering-Correlation-Id: deca30dc-adca-42a5-13ce-08defa232a6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|22082099003|18002099003|56012099006|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: N2cVOxEv6yiLJ4O383wVCb7MCKDWMxCsGMiZInvUAWHpXvYqCrrkYLUcphrR+/yzgmHGWHXBlnybKrYPDyyvFJnCwRJTgiqaF8hHGNGrTAjKKWGDGjUrZnRl0YdR/Bq2ZGtDYIY417Akrf996x+/HAR8i2zs/B7YQocxOC1FrSmDvI4iaxf4DjwNKlhzK1iyqc0UX4DXbi5ttBpAX6Afl1atslnoNf1G0sqxhX7qhS9PCt80kMTA+1WK5aRtATZyfninKpVLEPLI87phogHCKkeqIqJQa8zr6ConweyWtX46bIZProF8MmdHA12HcNmtPyTH8ue0OhpCoQHyM1W/Dp78HwtEchg1/qjb1DuihOAhroK6sfYd7nykEkwfL9BW8D9rYaeg75V19h3OgDl9J8PrH/11Ukzvr3+u4SWCrcIEFG56AL6J9OKQLwYf10cVohE6USh/rRCgDA1ojq97+yjTSvWFqi8idyhpZZkEJGxyDOI/TIUQ+27mA4DaIfxiZrObIYzhwfEB++oBW4D8uRfPbsItsaNLXVTaE8Jp2j1ObLE4FLARyk2bDlAMkf4APv/VRhjdCjkW+WqNHX+R16R9Dg3nVoEQrzt4dp1/9MSfjpC9xE33n7ZItPcklFihbvYLETdMDKFZ8amzLIm0U6WLIBugwjf+QaAGTlDh2swvFEQL6moULUoIiHL2vLwhl3rATrgEZxx7CPMeFxuE9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 71iMFikWZBjtbPKAhof6a14mmoXWe//JUXQtcdIWTSumg+6ThJ1r6VG4NKLsHzn1lxt/cf1D34eT98AM33uEfnmbPm19Q1907KOgmT7HrfxdU5SrzgPmVPTkhJH6Eerj1o7gZFz3dHhi2KVTfpK0uMrt8p1P8cbCapTNcCp63Iah9ouGUghun4o7CoHxn+QDMSCNxI6GApnRk4tfRHGJVXeo/5HCOGZOUxtNu7/2GyBP4uD+uTm8VtJGUO5SMgV9SDdhw03T6Sf0Ggy1fZcCibAQyEDtAJS2LUEFEmWtFit2v76kgLaxZL8cH4BpNO2z01h/5uJtjJvDPYaWbTfoPWi8rkZ+YrTmEfhzCo7DzOghhK+JgreuInOYkB/d4dMKAoqCJkxSoiwN+Ezj6RRMReZaS+zaE2KUeuIZFtO1To+JZS2l4Ktk6EF5jVrAcE4B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 16:43:27.5284 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: deca30dc-adca-42a5-13ce-08defa232a6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7301
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

This series adds HDMI 2.1 gaming support to amdgpu: Variable Refresh Rate
(VRR) derived from the HDMI Forum VSDB (HF-VSDB), and Auto Low-Latency
Mode (ALLM). It builds on a drm/edid patch that parses the HF-VSDB gaming
capabilities into struct drm_hdmi_info.

  - Patch 1 reports FreeSync from the AMD VSDB (existing mechanism).
  - Patch 2 (drm/edid) parses the HF-VSDB VRR range and ALLM bit.
  - Patch 3 enables VRR from the HF-VSDB when the AMD VSDB has no range.
  - Patch 4 signals ALLM_Mode in the HF-VSIF when Gaming-VRR is active.

v1: https://lore.kernel.org/amd-gfx/20260730171754.704049-1-jerry.zuo@amd.com/
v2: https://lore.kernel.org/amd-gfx/20260806205449.16806-1-jerry.zuo@amd.com/
v3: https://lore.kernel.org/amd-gfx/20260811003921.1398292-1-jerry.zuo@amd.com/

Changes since v3:
  - Drop the content-type based ALLM heuristic. ALLM_Mode is now set only
    for the mandatory Gaming-VRR case (VRR_EN=1 with a sink that advertises
    ALLM), per HDMI 2.1 Section 7.6.6; it is no longer derived from the
    content type.

Changes since v2:
  - Fix coding-style issues in the VTEM info-packet code.

Fangzhi Zuo (3):
  drm/amd/display: Add 2.1 FreeSync support for AMD VSDB EDID Block
  drm/amd/display: Add HDMI 2.1 VRR support from HF-VSDB
  drm/amd/display: Enable HDMI ALLM for Gaming-VRR

Tomasz Pakuła (1):
  drm/edid: parse HDMI 2.1 gaming (ALLM/VRR) capabilities from HF-VSDB

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   5 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  71 +++++++++++-
 .../display/amdgpu_dm/amdgpu_dm_freesync.c    |  41 +++++++
 .../amd/display/modules/inc/mod_info_packet.h |   4 +
 .../display/modules/info_packet/info_packet.c | 109 ++++++++++++++++++
 drivers/gpu/drm/drm_edid.c                    |  42 +++++++
 include/drm/drm_connector.h                   |  47 ++++++++
 7 files changed, 317 insertions(+), 2 deletions(-)


base-commit: de2622bbc20276eaaaafa8fdbd374ace1ced28dc
-- 
2.53.0

