Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B7DC624D0
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 19:14:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 500D110EEAE;
	Tue,  1 Sep 2026 19:14:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DBK0+A9G";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012008.outbound.protection.outlook.com [52.101.43.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0110A10EE9D;
 Tue,  1 Sep 2026 19:14:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dkh/5J/at6UDqlL0IpPSJVXKuk3/gRD3o7W9EwlYjLOFkNnyM+CrZK2NfqXPFJdIXots1/9tEaqExuGUetWC2sFlI/4IBZd3RASmWbeD+Dus1SSE+mFkNIu42bd0X4E2vuo9Hx9hiihi5CIp5bMWZUB8itjftk+C/alx3ZaSE0LgDWTEX9fNjgrxZFkS9zwRFTEuPJs7+Ch0+Fn/WmH268WQ1A6eRxT8tDhAkrAvM8zWI/j0NC/mtFW/7zpYdX0GYiF6vymi1WHdNpU+pJFDYogUHXMVTPSmRKrjMzcuZnpd/SYVkjr1E8cUl6aEUQ+3M0RAp3Y0HGDxStbJ2k5tpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nj5RBX4nkDpbpc3Ng+QuEZoz8GhqL/wHZOEW9ribHOw=;
 b=SK3q+JALV2y8vm1HrHN5tBHWU0hnPJb2hLOBROcwe3EHytJAN/GmMRrbMT8ie3H4ynLfx7UuNFTOcC8weAhhPcyVC+5Yl3OvWaR8wrbjHACUhxRcL1g337n+I1PN5v5UKPiOw0R5nExS7xY1Oh58rSEp6pSSJ8x87g2JYcPZlPGS6iym7t23KFoRAQGpaMQ7NyibyOpSzZTtgVDho2kc0b5eFyryAWNpLeLRgEBftQc1DJLeU4UzdT9CoQsB9eHjNTIwOlyoaKHh8ATMBytuP0YtXqMFCtET7eBWpTzuQ4nAeY/G6IOsbPjYon6dbuJN9GPNYRulWJts5LrdWQLjbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nj5RBX4nkDpbpc3Ng+QuEZoz8GhqL/wHZOEW9ribHOw=;
 b=DBK0+A9GnoeDo0sVUKwnteFbyzxFrYz/30A6jb21Jb3uRvRPzyeNZwEtPGgST+tvQLwY/S5tVOzudjGP/G9BK2lnXi3ntmaJ2qliZdZg1noruC0k2NCltP3+BgZFiq51W7wbUngHuW+WRtDnllQhP9JvPEfBcs/1KR0favdCS0w=
Received: from DM6PR03CA0079.namprd03.prod.outlook.com (2603:10b6:5:333::12)
 by SJ1PR12MB6291.namprd12.prod.outlook.com (2603:10b6:a03:456::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 19:13:45 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:5:333:cafe::2b) by DM6PR03CA0079.outlook.office365.com
 (2603:10b6:5:333::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 19:13:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 19:13:44 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 14:13:43 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <adolfotregosa@gmail.com>, <harry.wentland@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>
Subject: [PATCH v1 0/3] drm/amd/display: passive VRR
Date: Tue, 1 Sep 2026 15:12:48 -0400
Message-ID: <20260901191251.2653684-1-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|SJ1PR12MB6291:EE_
X-MS-Office365-Filtering-Correlation-Id: 76aa03bf-9cfa-42cb-5217-08df085d2485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|18002099003|56012099006|10067099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: geLIAWTD2vBRfYLDbDskzMuy34irmTtmPVnQhmpyQak87DC9WltRMezBziYA4+Fs3V7eS/UgU0E+luVGO/9PPvWloznK8FGincH0m+XR6BRrMxozgew8BRCATYhMpKRDNVYCeavave+bWU2hHk00AZ3qgxy/N2mKwcqrAUzKinn6w+p88gg1MjENgJUes+BpatTMAc4i3Bn7sesenqaPK7aw9xUJ6j1LC220+Q4XEpn2ehS4cNpPQjlHyfOFNQDui1iHvskRELaT2UeHUkTIubOAdcEHvkgyZGvs6MNkZA4fLMDwSuiqRl2kgD0yCkCTMrX//+xHCo4kBoL1v5vEbtFoR/2fDHVqBzjB3ekm7s5FRspmQfuAcdlPeKgCIsBbxaRbjMUt6etCQgmsX5AJZuTroe2bvdKtb3UZhuUV4NmKN+o8EXEOT0E+NTvv6F++qTSN9wBKDiyM6WE6CzA3zq75nrIl+iZNw8aCkL33DygTbqDkEFDGXt/AnLv79N6d7p+xa/P267gjzaFLUC4O7ZYxNiLdVyjZnW+EpLrEyIl0DvlXjhgI7SRxa3pKYLGf25N17ni3uu64e9CWwHf+L5A2hl04XDObNcv8iBc2efdMk20QXb7+qAznz+sNDYpVinJMfngi6U22GhWJ5PuN5tGhYvwUWuZ0dV0Q0+E+Bh4Q/0mIMTSUHtjp/D3hqcwIArZNwZSyR72yHKdMUzIhYQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(18002099003)(56012099006)(10067099003)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qG7MU1F7S4tuMkUYAh9avLRjW1VWk6bNAmd/AunLuLGJ10S0AJKvRkGa5mmOFEUr9HZGB931WSn3rLdoCDIXxzKrSTp8inE2gEMJDT2rtKf8hdreD8MYS8m+FhHdBl6tewXobAGpSOvd57ggzYvMpaoTqpiDDudKBRUGzXfDljn7c8FnBfXqoDvy1+SKtb5Z3VDXBakabRfPLU9SS6K/+WMweMVbG46BD8wn6gzTzntbdlVaFXYjlBG2QK1GFYn0tx9LNSOrPG0xoAavhGsML/NmmyldTlmFkizZgd6HFUXjcrZT1JvM5O0t7vOgKUSTRHnoeNRXb3idXAsLMH7Tp/WAKkaDzGLN8J50eA8ebi7dtqDVS+kqIJxBoBrEreyOnufbJsqBRfo0OwoPVNyk8XV5pip+NvXCyoffIO0FRxGE1P+7fSLxj6KnpISP+KIg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 19:13:44.6820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76aa03bf-9cfa-42cb-5217-08df085d2485
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6291
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

Passive VRR keeps a sink in its variable-refresh state during fixed-refresh
(desktop) use, avoiding the blanking/brightness flicker that HDMI sinks
without seamless VRR transitions show on VRR entry/exit. It is opt-out
(enabled by default where the connector advertises passive_vrr_capable) and
is not useful for DP/eDP, where seamless VRR transitions are mandated by the
standard.

Patch 1 adds the DRM core plumbing: the PASSIVE_VRR_DISABLED atomic CRTC
property and the immutable passive_vrr_capable connector property, with the
attach/set helpers.

Patch 2 wires these into amdgpu via the existing DC
stream->freesync_on_desktop path.

Patch 3 fixes the MCCS FreeSync fallback so that HDMI-Forum VRR (HF-VSDB)
sinks keep freesync_capable; without it passive VRR never engages on the
very TMDS HF-VSDB sinks it targets.


Fangzhi Zuo (1):
  drm/amd/display: Keep FreeSync for HF-VSDB VRR sinks in MCCS fallback

Tomasz Pakuła (2):
  drm: Add passive_vrr properties for passive/desktop VRR
  drm/amd/display: Use passive_vrr properties in amdgpu

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 +
 .../display/amdgpu_dm/amdgpu_dm_connector.c   | 13 +++-
 .../display/amdgpu_dm/amdgpu_dm_freesync.c    |  7 ++
 drivers/gpu/drm/drm_atomic_uapi.c             |  4 +
 drivers/gpu/drm/drm_connector.c               | 73 +++++++++++++++++++
 drivers/gpu/drm/drm_crtc.c                    |  2 +
 drivers/gpu/drm/drm_mode_config.c             |  6 ++
 include/drm/drm_connector.h                   | 15 ++++
 include/drm/drm_crtc.h                        |  9 +++
 include/drm/drm_mode_config.h                 |  6 ++
 10 files changed, 134 insertions(+), 2 deletions(-)


base-commit: 8c77d618886a143de5cd87a35963b4993075802a
-- 
2.53.0

