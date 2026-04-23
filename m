Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD0DFDEE2B
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 17:01:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFBF610F1D5;
	Thu, 23 Apr 2026 17:01:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lWus9q9X";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013058.outbound.protection.outlook.com
 [40.93.196.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B55FF10F1D5;
 Thu, 23 Apr 2026 17:01:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lmlHdlh0jrnww72JYVA130fsIbzqT4aIv8nPYZQEg5/DAMRVtCRj5wO2nIylYWLd7eSuGHaEgJwxkcuPB4ew6P6NdXiMf/aKCtVfYYpuMz+3j1G8gAJL0P7Ac0iqF6CgHnjybkPARaFemWJaCu33ChaF20wz68IRbXOS8+fw5nfuuu/+/M+jaXbJhEURHCnNItdT0+lTkci88U/ptnukKf5nEow8Mb4rEu20Q+tOCqfN3z5M8/yHCWw7O+RQbbngwXYoRjwGOoQT49NncUCwf3BPpDuLgifYL6GuV4RB+R35EsdJ+KXj6D5LU4jhUIaWl2O4/n5yF+6RloUd+ot5xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jj5oh9ANkuV2k7AcFqrHZASY6uIH2uMT0Cfo6OpF/yg=;
 b=e1VXjnQUMBmzcvyL9B+LhNiwJHo9/fnmX1FnB0JALAfQ/QZwvhze/QTI6s8BdEcWgh8s5osHZpsqcplXJW9ltO7yODsoBLiW0yYMO2tFVvCT0NNz6IpqZB71QeLDXgqGqyQ0PHNvjT7qNCu0QzKCgDJepEgGky5inbQtE4s2ZEw3+sIm/rTX2q0TPtOwsrnEDJuV3W+N9LbIJsOLkMKOQAFLvSkcn0KxsJIGie9+i47LMXAt1z8T2TpYiM62VfixmDeAiPQ662+y/vod/RK1kUzlEv4RftotlSPHnjcLZEXzzDdV3JKB6BNwr4GxzRXVSt+9tu7NYX96UTUYjM+cew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jj5oh9ANkuV2k7AcFqrHZASY6uIH2uMT0Cfo6OpF/yg=;
 b=lWus9q9XOpOrSdyDR0j5GNH4PI3rPm5Z8YlFBuSCLraSGjzSi7PfrpLmajfNCOqibLBrMcFmBabpTmugzyJkV1bnKp68l4tmXyeY2fVh+nu1G9dnMAwLc1aQVFTUiRFoDnoc+VEUWAUss4rpmYMxOZG++vnxZU8Bwdhx+H+kxuI=
Received: from SA9PR10CA0021.namprd10.prod.outlook.com (2603:10b6:806:a7::26)
 by MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Thu, 23 Apr
 2026 17:01:38 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:806:a7:cafe::bb) by SA9PR10CA0021.outlook.office365.com
 (2603:10b6:806:a7::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Thu,
 23 Apr 2026 17:01:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 23 Apr 2026 17:01:37 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 23 Apr
 2026 12:01:37 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 23 Apr
 2026 12:01:37 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 23 Apr 2026 12:01:37 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd drm-fixes-7.1
Date: Thu, 23 Apr 2026 13:01:28 -0400
Message-ID: <20260423170129.2345978-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|MN2PR12MB4223:EE_
X-MS-Office365-Filtering-Correlation-Id: 20c08aa0-065b-498c-4d22-08dea159fbb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: H4Fd8Qk22krUloPct7tcJxgHbEDDweFrsOzGNme0G05MNnElml0O5LXENxvNNM/url5nBBrdQcOcCpSMvD9CiFPjDoGqdkrwbgEdYYgeqQ+lAtxUeRCSHLhYYVMBCpo7oumIMpoZLGTOY0/1rw53vuca/pHNdLoW7GjGe8VBC8OauDDE0N+9tGM3en6OSUzh8XqX+49/gAAivxtbYSglHRUTQa4qUoRKIfeok5O4OYDD7N+UypWzPE5x0LkqIABDCbUmGfByclJkfKYMk0O6oHk+LXDNISz+9HeoSszxSNUbkziGtGedyyQXtaTNXYJyuiUF+toDBBGKLfURHSpFvYn/0esI8WBY1Y4dnqShRDnAPO/bWLmt7yESwx3kwnNiAirI7wa7KYpnoRmJjt+lyscpt+9SXGsm/pyTM8+szteai/0U8IPfqH5dx2M/QOzCpYwa3YLh/GxFwrCfqU4vmxYu6884OV5b2eh4E1wdVHpus+/m88ylemoraMJ0XFphfJUt9ppVkGo4Jved5jji6FTWu3JySbTCgGUjCCiqg/f2tsPPSt2oAS/tQ7CmVRRGVKXgvs/tPjFErKP85tmXp692/sThyfdGf7U2dJhYFGxtTqEumI5hCewR+ZVEQ4U9hrFXt+llRKCwjtuyTFF7DuUqZ8jUCNAzNX+bDkUUbR+uWo/OjXTp/nK3QtGyDI02QwNMxaaGW5+jWnMdVryaTHhOmyGTHUEXeRekmjW/Dj0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kB1AnlT2g/+myDEL7N0HAnKtKySVinHXtnuoDw3eX8em4vCP4BGIQ7i5TQacZKHufW25+xHXn3k1V2XE4IbTpLAoz3FxR84CP1KXMe39w2pbDupFu9wpSIHdmGp14dKz0EH9shqSMUhso6/f3Gcy0Hc3n2NSW7ifRUoKxS9kKREAzFR821O/G1hAYS/PeOVE7hwBA119NacudBsP/15OASb3aolRI/AgIhNT3TYJ06iJpQR3LpeFvk8r3QZ6KhmMlCuqugm957swO6eNGd2wymovFJAMn3QZi2dkalbODLRPoW9yLVsfrAgPz3zH6a7TbgwkjvE9PpZoUHvHRrJS6AsV2ZFE0fJWCKPCdisOtYy2vIUK+ajAJloyu8GhFzfZZVs/qMqmJ7Nkwxo9vysTDP9bA91PBymd2pKQRc+FIA5H4niAaqPWUTeGcxRSVLLu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 17:01:37.9966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c08aa0-065b-498c-4d22-08dea159fbb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223
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

Fixes for 7.1.

The following changes since commit dd88d42d9ca0dd7a4ed327dd33f6ead76cedf726:

  drm/amdgpu: drop userq fence driver refs out of fence process() (2026-04-17 15:41:12 -0400)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-fixes-7.1-2026-04-23

for you to fetch changes up to 74b73fa56a395d46745e4f245225963e9f8be7f1:

  drm/amdkfd: Add upper bound check for num_of_nodes (2026-04-23 12:54:45 -0400)

----------------------------------------------------------------
amd-drm-fixes-7.1-2026-04-23:

amdgpu:
- DC idle state manager fix
- ASPM fix
- GPUVM SVM fix
- DCE 6 fix

amdkfd:
- num_of_nodes bounds check fix

----------------------------------------------------------------
Alysa Liu (1):
      drm/amdkfd: Add upper bound check for num_of_nodes

Leo Li (1):
      drm/amd/display: Undo accidental fix revert in amdgpu_dm_ism.c

Mario Limonciello (1):
      drm/amd: Adjust ASPM support quirk to cover more Intel hosts

Siwei He (1):
      drm/amdgpu: OR init_pte_flags into invalid leaf PTE updates

Timur Kristóf (1):
      drm/amd/display: Disable 10-bit truncation and dithering on DCE 6.x

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c            |  9 +++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c             |  7 +++++--
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c              |  3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                 |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c             | 11 +++++++++++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c | 10 ----------
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c     |  6 ++++++
 7 files changed, 29 insertions(+), 18 deletions(-)
