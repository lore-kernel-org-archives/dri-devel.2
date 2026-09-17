Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878A6C88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 20:12:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8802F10E2E9;
	Thu, 17 Sep 2026 20:12:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="as4M5n9s";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012011.outbound.protection.outlook.com [52.101.48.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 430A710E004;
 Thu, 17 Sep 2026 20:12:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZyxwPOvMbhh4O0vJYLFoZtWvFAlaFCMm3ZVt0koyWiNmNZ0dAICQc1F2usMUYyprrbxotzr4Fsw12+B0H2kEEO6pRJJGePfFdo5cqdv+eQV5wFQqSkaG6Oo0WrmN5wRFmDI4Vg0NxsNYXCLznhQ+w2Vz4B9ElA8rbDJB6C9iaTQh3tpDOaJpZ0C6mYf+wP3LyzcHhLAKH3PO0s9WAywiH0CWmY4mVRz7ZMyxFl1hCVhW/KvXEmHmxk4o5XGKLCfkySz8qx22E9pHgsXyaqV1Qs2S6gXjPLI+NVzZ2A/HjeXIdPc0QxwQjdJzDIRulInNIE2ukONX+KzTqFfsEb5N5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urg/TFxxcxspg8TA0n05SsXUmnCaHizVvhwuneFSyT8=;
 b=F8uZ8FXPg2vpAeW9tNJYALirwXFA94Fki/uCz4IXPcYFdMDk0Kwh+CNOkWvbHz6+hw6s1UJY462WTRtd0ny5iDBlwtwOpEa1N98qtgLRPwWPCZO5PnSSD3u+BU8BqyUJeMZloeV8Z0TjCqTHZkMEg0U+9woltE2UykDFsDfM1cMHGaK0comFOlkN2L3tgYR47/4MmisFcrFcumnt9GaDnrEQzi7nZskeT8TuASb3uum7ElSYa362A0VApr0n4KHcS/rj5ymcW0Y/7oajNjTl8+PbRahMcAnvV3P2fVTD8Wn3VZdn/TfzpC0nqKMxTkarVtlmP6n79+I5djx58f4a8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urg/TFxxcxspg8TA0n05SsXUmnCaHizVvhwuneFSyT8=;
 b=as4M5n9sOtFnfvjQ5XGDdzAieg/Z1trYFAV2bIORLS/m6dVDC4RRtznHPC+pFUUHsk6FKwSeeN28bgKzw5nQIUuwVITdFOFb+NTWIFmBHSe+ijDd9Dbsdk489Ht1LAioslw52fizBbC/ULQXohVRP44ZKauhQ2kK65TyG3kYUR0=
Received: from SJ0PR13CA0203.namprd13.prod.outlook.com (2603:10b6:a03:2c3::28)
 by LV8PR12MB9112.namprd12.prod.outlook.com (2603:10b6:408:184::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 20:12:34 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::24) by SJ0PR13CA0203.outlook.office365.com
 (2603:10b6:a03:2c3::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.7 via Frontend Transport; Thu, 17
 Sep 2026 20:12:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 20:12:29 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 15:12:21 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 15:12:21 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 17 Sep 2026 15:12:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd drm-fixes-7.3
Date: Thu, 17 Sep 2026 16:12:13 -0400
Message-ID: <20260917201213.3880863-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|LV8PR12MB9112:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d9d7cca-f563-4c2d-ccd4-08df14f8002c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|13003099007|18002099003|11063799006|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: +AN3sV+elLTaechej/Q7xaTQcoQI3Xb3ErbObBYH756Yqa4unZ6SwFakB2aLUpbg5Q89t+8xtNkSiuOx1LmxLHgZEFUJXrRuZkwRJBLRjScdhRYmBeJeB12HsAAUYhh3DgX92rfTbQ8xITvKMTHrZuWxL+0XClZvyQSZ8Bx9lRUapv2f14s4g0xFsiPOtxnJ6vcTR+dSo6r+WvH7X5jlwZeHOnzTOoQKRIMEXnNMgkm1TGxYvXML8XvO1b1xbyOF8Wxe3W05Mi84bKwBjAq/L6SfU3nKGgBud9EEnON5xsK1gHiVjpl4j0B978vfUhzfGa5ua1NHH/CAo0YUN8SQBicx9Vtj6JbKRUKEDnSUyk7qVYX3a82KDuBEUHmYhqnPee0+xWaVOOVlPkJd0rzmzzbHSNOssyq79kCHQ5lubwG7CPtK1i9gOl54H/HLvTga/rVXctcMB3YJPsVrFYd4LdLyz1QudI0YwePxpRoJJ8zyfqcH/5I9IzMqFi20pgQnR0qQh6f1qqfk3EMZ8zcvHcGWG9xv6Ra793SL8flLsxkehYzaaufap/CLpKBWlOgmEM216GCyYoQ1lqc5fbpvU4sEcIOxU8UEag4lD0CVHZW5IPnLQqYL29UP4OzDDUTh2OK+Ym3BZlkd5uKiLXpWsy4VLYyUTHGLVGExhoA7vQU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(13003099007)(18002099003)(11063799006)(56012099006)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rFcsQxX+yPxiK8i6KtJzELmvJHaFNMos4kqS47zQ8v4HTC7pLNsuMUdHfv+JcE2m48okfjcrZ/abfxoWlJ6t/U5vJ6wTfIHVvTqhY/iBrirIy296+MyQp45F6kZEBDl17ifB3WAWXhabmMZK8pOxTTau5Se7WuNZ/oNsijHUHLvSN4WMT+CQAUa5lpFpYBEa08eraq+CDTL45ouPsVuPR7waUFd197A8iyMVhMrmLlVrUGcauhmnNrkfmcPNRrsUQIr92OZxHFa1FqRF3oWfDUX8hOJNmt8tzyE9FXo7eGB9z8RT1Jo9pc5jZ/yAYR8oNzfE5hp9Lz5sT9Ey7N+2rryDrSSkLy+nAiNtY2TC1QFc4bVyT1o65q0gZN/6qsqK6jnhMjFdyaMGCQ0Shf1oHWKH06ywY7L2dPoUzD4Sd1SpcGyOERSvkmrNNGeNgXzP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 20:12:29.6155 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9d7cca-f563-4c2d-ccd4-08df14f8002c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9112
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

Fixes for 7.3

The following changes since commit fd73f4a6659897191fa0d40695fe370925dd3780:

  Linux 7.3-rc3 (2026-09-13 14:38:02 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/amdgpu/kernel.git tags/amd-drm-fixes-7.3-2026-09-17

for you to fetch changes up to 2ac2fe765ef475f409616ac0b57c4a3922749b0f:

  drm/amd/display: fix MALL hysteresis timer underflow at high refresh rates (2026-09-17 11:59:24 -0400)

----------------------------------------------------------------
amd-drm-fixes-7.3-2026-09-17:

amdgpu:
- SMU 14.x fix
- DC IRQ fix
- Runtime PM fix for P2P
- RAS fix
- PCIe reporting fix
- DCN 6 fix
- Device removal fix
- DC MALL fix

amdkfd:
- GC 12.x fixes
- Boundary checks
- Mapping clear fix

----------------------------------------------------------------
Chengjun Yao (1):
      drm/amdgpu: fix rmmio iounmap skipped on device removal

David Francis (2):
      drm/amdkfd: Avoid integer underflow with ffs in EOP ring size calc
      drm/amdkfd: Avoid integer underflow in EOP ring size calculation.

Dmitriy Chumachenko (1):
      drm/amdgpu: check ras and obj before dereference

Francis Marlou Pacaro (1):
      drm/amd/display: fix MALL hysteresis timer underflow at high refresh rates

Kevin Wang (1):
      drm/amd/pm: report energy accumulator for smu 14.0.3

Leo Li (1):
      drm/amd/display: Atomize IRQ register read/modify/write ops

Mario Limonciello (2):
      drm/amdgpu: Fix GPU PCIe link capability reporting
      drm/amdgpu: Skip KFD mapping clear before initialization

Mike Lothian (1):
      drm/amdgpu: hold a runtime PM reference for P2P dma-buf attachments

Srinivasan Shanmugam (1):
      drm/amd/display: Fix NULL dereference in dcn50/dcn60 init_hw

Vladimir Marioukhine (1):
      drm/amdkfd: implement restore_mqd callbacks for GFX12/12.1

 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 54 ++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c        | 43 ++++++++++++-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c             |  2 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  7 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c   |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c   |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c   | 61 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c | 70 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |  6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c    |  5 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  4 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  | 12 ++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |  3 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |  3 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  | 64 ++++++++++++--------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h  | 28 +++++++++
 .../display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c  | 16 +++--
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c       |  8 ++-
 .../display/amdgpu_dm/tests/amdgpu_dm_irq_test.c   | 34 +++++------
 .../drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c    | 13 ++--
 .../drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c    |  6 +-
 .../drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c    |  5 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   |  3 +
 25 files changed, 346 insertions(+), 110 deletions(-)
