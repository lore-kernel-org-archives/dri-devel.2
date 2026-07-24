Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046BFC531FA
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 16:18:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C2BC10E059;
	Fri, 24 Jul 2026 16:18:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wci3KlRM";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011046.outbound.protection.outlook.com [52.101.52.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1E8F10E050;
 Fri, 24 Jul 2026 16:17:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0/Nn+GURikdxg5cEbS0qsXZPnWtZ/3+86C27mDWfKqVXpLsvARTFBeocCmXfzVUH3PaeDsrFwGDkgfrpbXNag5Jg0NPCwV7soGFgee7fzJixEt8ko9DY6LtblCFdLDgaLO+/SVl+dmzhdN1YuBByBsgncWmzQnFcOpM+u5hJGdEpe4ZvqHdlocbBvORaNUQlUa6Tm/RqQv6/lFSS6RZYdDCnG04RvM7mSbbhWZLk8+DfuTDAG6iWy3JZFF1QwhoVPok+bSdZDa5exkgUDe/8JFTRytuDHJZnWiWBFS/azEpfFxe0Q84x3mrYcVIkjeW7sIg2u5PKnZ+7hYnUPMN/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvYQJPBZKnp2vdfYoa0gYoDGucvurbGwFNKLsMvAp24=;
 b=rmjF+3ZvSyk+BlEGlF64pwPU0/JOXIDoXWuakCnM3zbCy1C1C2BC/iouPKTlP89d+KKCY53Rvp5UFK1R1sUAbH2Bj3aoJS3PA4OflcuDuxdXBhpc933o07iU2goF4Zp/mFWdyZhKQ5XFIrLcE3Hvxh9H2f/OZn3RZG1dLA/ZHxXR9AEpzveQMpk+hEYJ952zHJ8SCNiRn0D7HGw4JsMqNYvs3Iojm/2vUixbRttCV24XKZIbu+vlkF53Tfuf6Jky3W/z0oIRa/UCde4zm/FizdkgLPOK4tXvY0IZzwZQ3Lmk3RuMIAEf4fPWKhuf+NZcFoZlZNhYbai+BpBEtznwGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvYQJPBZKnp2vdfYoa0gYoDGucvurbGwFNKLsMvAp24=;
 b=wci3KlRMz2/S3Ak50PYT2AYhpbUVeqTVbi4zbqEXgNtw5MmlLDZCTkFcMb8cxA+J8aauGx5Tlp6eOtChEm814mWet4Y/6FXGLMSbi7pF0ZYcIGcZLF56oQZClaFZnzHQxM8ZG6nATRD7xFQzIA4gErZghEcPrCq94Zu3IqN9G4o=
Received: from PH5P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::15)
 by CYXPR12MB9279.namprd12.prod.outlook.com (2603:10b6:930:d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Fri, 24 Jul
 2026 16:17:51 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:510:34b:cafe::67) by PH5P222CA0011.outlook.office365.com
 (2603:10b6:510:34b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.12 via Frontend Transport; Fri,
 24 Jul 2026 16:17:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 16:17:50 +0000
Received: from MKMALEXHUAN01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 24 Jul
 2026 11:17:49 -0500
From: Alex Huang <Alex.Huang2@amd.com>
To: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <harry.wentland@amd.com>, <sunpeng.li@amd.com>, <siqueira@igalia.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <superm1@kernel.org>, <alex.hung@amd.com>
CC: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Alex Huang <Alex.Huang2@amd.com>
Subject: [PATCH v2 0/4] drm/edid: Parse AMD VSDB FreeSync range in common code
Date: Fri, 24 Jul 2026 12:17:09 -0400
Message-ID: <20260724161713.119382-1-Alex.Huang2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|CYXPR12MB9279:EE_
X-MS-Office365-Filtering-Correlation-Id: 999f7bb6-9a8d-4dcb-1715-08dee99f1b95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|7416014|18002099003|11063799006|5023799004|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info: 9/m6ENR0KhAlAryr+HCQP6udHgbgSt3SPyqf9/lhGqLUCPHCQFtaQw3GvF9+mFt/jJlxdtcjtWYQ4+lG6cSMPEauanf00bXzHhjI7VivtVe6AZESeN0bCThLncpHlBzzqx2cWFiWIe2YSdpUJSRjfjE5GkYmOd4sDlBs/ODrYKeWz0ZtaK6qzl7ZKHurppMFmh6hf5/Oyzo06JKrN6APZYR95XjBN03znPZGRsfd/M+k/WuqCZ8dm5OlPTF6IdQAn1YEHoKoKzOCibW6B0LMUeu72OlRNV3iJgvnvfrcZJODAmYi7oBNS9P9L1nx62hD8yu+BNc/6i5d8p9WAquUzGmOP5I+WAOGSf66AOJ6Ukik/XcR1SE99W2OZMXqm0Nb7gtb5tGK8GViXPPkAsb5sUn4FnxZRQ0sjKdgVmJ4mdnariEbydhhSUZ4AA08F13oYZatRqy+/mVMXd8yM3W8jQhhj+xj7OMQKXmSbxF0io8NcKXenxTu7BFkkb2cfwMpZCJyO7n0oCbqz4/eIiJGcdMcg7vdq7DoknxzMVzdpDeQJEVKGZ4Qxxgq795phvArTEeh4nlQeUXciFNjrktndQx9K7Ie2Xhd9ZK+k4MekHA7sDkl3m9PC5epziODzaZbOhmJFMlUzReaXXXDEr1qpU1siajmZcTPJMuIlr/aFa6JY/v8TuYVAmrjjO9wt4VSXCAdV848lT5dsBRmkovVAhau/30/51XbDQxRPFTMVJ0Elg1OVKnWoBDUq/rWsWHC
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(7416014)(18002099003)(11063799006)(5023799004)(56012099006)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uIxCxzyV0n5fFWFiPwAuiy3A2RxOuQ7bYR430XqocVhuPsUCNJkg/bq0mdHzpt2bcPwdXKwfQptrBKLcQtEiD43ZbcLFpEOxPlhodelNawUsk3IvF8JvovWUUBiI3EfuJhCMPBcNFi42W1tm18CmsYF6bONAmUAC8E4Db+KfVeTKuTDBFeovIv3bhov3VuGUsmkI/SKUrGVBvovxt+3/0Q3OtpIXESAfPO4ucDGBBdWmj1FSl54tVLtFeMf3COGbPs30AJO3OoHV3I96ueEFX3fDNAdcn7vbot8fSXRKpiRTCN9MTjsfGEoSayePoiUGlTKBkXeSyEfqCstEftJH0JTzNaHHQr2G+HKH9ORiITUMyKLBB9HsgNxvXrPeZfNlpBvFx8m6TbMyatn5YSbE0thHI+hTGtFy8sJxbqFaL7okVgYa595QeE5iOrHJ53Kp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 16:17:50.4407 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 999f7bb6-9a8d-4dcb-1715-08dee99f1b95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9279
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
 drivers/gpu/drm/drm_edid.c                    | 141 ++++++++--
 include/drm/drm_connector.h                   |  22 +-
 9 files changed, 175 insertions(+), 567 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dc_edid_parser.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dc_edid_parser.h

--
2.34.1

