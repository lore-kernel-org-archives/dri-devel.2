Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CE9CD6E6E
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 23:18:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B47221129EA;
	Thu,  4 Jun 2026 23:18:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MxiXxHgU";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011030.outbound.protection.outlook.com [52.101.62.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 334FF1127E6;
 Thu,  4 Jun 2026 23:18:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qd5AYTuH22Dynj9TE20U4TtrqxC++gb+u0yThLWaUmEVrt8m3ibVk9MmFk87mqy9O+wKJ2PvPUrlQ9Pw58A/Es2miVZlKABNgO1Ck8TnNMScCMIvUFKzt+93ZGkQOGTYjaksiQXFTd56WfSsquVNxnOlC85sOln/CgnkMbuG9pzNzBiZAWLFSuBSMuJn3eMTbKBn+SWoOCxBy1J/CXeXD0DMPSZ3Ap3MnZN+OxX7JAswW8yyWa1q40rhTI5gw+rHGSkwNAEuWD2n+T7lFRn9HnvKccNeYAvJ2Vie3nJxPzR6Vk8PFLcwE7nzjh/lwW3oIi9DYmy/7CCQ1fYZq2D2QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsIF2u80OCFNmY1yZogsaAwgNTkLNAYzjgqM15Gv6IM=;
 b=eeIicDtVTZmDK7SZ1Eoa82I9AyQXTcdbHpGudhdS9h7II9okfhL4woy9SJDkPFcmykFntYyg7WCEb6BOv0IO1eVvrWmrzfSlGMTJJlbR3FIKuezbWL6jQoU7hfrvM7faJBCna5aTd3ZRjBCcxTHsnGnyvmoO3p3NnkS44VTZuf36wCVRupq7//sWDOlqwQKG0mQ2qBg6YtPfKiEfF1QMfIgWWboqcRv8I0JgJPseMkovG9OfS1t03TMZf5KUud7Yy9Tenl0vkd/5fzAA9+o5SaoczSVAIqNjtn5i300D1qJcvPcDBKy7YARIEWw3Sq/VPp/5GdaFWqJtfWepa/opAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsIF2u80OCFNmY1yZogsaAwgNTkLNAYzjgqM15Gv6IM=;
 b=MxiXxHgU0Xe8tCJpw6oSTfnaQGk8Wr29YG5oQaQAb0ffPM4GJhYkehO/0gFXuk6NYQ0vKiZNDFUWbUPjegVjZMjTG8/zijgzf/a7RKmzN/l9tgQzaUpHOqG7XRM8fdNi2ERphXr8drm5TEBaQpkIFTROOP6o/vJnMjNAgDCQ72g=
Received: from SJ0PR13CA0193.namprd13.prod.outlook.com (2603:10b6:a03:2c3::18)
 by DS0PR12MB8367.namprd12.prod.outlook.com (2603:10b6:8:fd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 23:18:11 +0000
Received: from MWH0EPF000C6194.namprd02.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::1f) by SJ0PR13CA0193.outlook.office365.com
 (2603:10b6:a03:2c3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Thu, 4
 Jun 2026 23:18:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6194.mail.protection.outlook.com (10.167.249.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 23:18:10 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 18:18:09 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 4 Jun 2026 18:18:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd drm-next-7.2
Date: Thu, 4 Jun 2026 19:18:00 -0400
Message-ID: <20260604231801.19979-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6194:EE_|DS0PR12MB8367:EE_
X-MS-Office365-Filtering-Correlation-Id: 119bde40-861e-495d-cd2e-08dec28f8b62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|18002099003|6133799003|11063799006|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info: zdI+6xejRmawo0Z0rjZuEdCFs6GI+SdQTVqNeSOtWVjZ0BC9dzPKFIj6zjbhrXFL6ENWEagmhCaaePZi/8E99FokZQnWQn6bk3bO2xoVsUGFt/jpSuKo/ajFYUJ0XBE9UbV+oJuY1XaUFRklTOApAGPbj7bkflsUR1aryLkj45AyKAkT+SsQCFs7z84z+XTtICMxXl//ssA/tga+MTF/Ib02ymK4X9D2sN640AJanjtDosuin/CUei4vII2Yb73H9QxzKEvP2t0ESP9MtTP536Y9JwvdlRmzw81W44XN3mLPmisR1ATVImmGtREK3uNwvABw2+yTH/VAkdf0mAol8YNANqwnBg9dWTAwlLOKgqB+kZPZXcQlFxBZa5xqypIJ79n3c6TL7Crc00mRdet0ElVTvesNFloo2yDiNZhr8TL+THIrv1eciBRdw6d0UK1bv9i7p6tI1cmOFvH4opF073kYqq6s2MYcQOo+Of2Ba+IOgL2bFPq+I9G0LBswN7vkZ2iz6P9KtoFc++2uEYVWI1th/OLycDEajDcKgbUTAf/qy82OwqJLD46Tjf1Hr8g/8pBvX7NPXPMY6LJcO595XlA3RAtKawU1bvQdOggMoZqsd0PEQ3iI6yT427fUw4JFkdj29Y4TqTQR6un4MDcjIAUpEgtoOquv4Oy2BEn0/0+CfxMES7CsIzQF/PyGzDRP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(18002099003)(6133799003)(11063799006)(56012099006)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: M9tNj1FOkBFIG00/BxFBSzoA5VuB1YFbtgnIsJvc/v03W8xnG6eUFhGPbfgTK15SkVFRtaOyif0hQHYwKWBqxaRkYwzBOQjos7+ibB4GiikxZvwZtlZL4irgKlQowlTw1M8dR8uCRIUsFLoVA+zHrSYRbH4PcBlU71n2ihqcx06lD6erb/0oQ3AHUqNLG3xk773kEqkktkcrVg3VCGpEp2AkjygDLiwx9SG/Rwpt1nCh3FFPBI3RPf0rvjk524rgRA6YaaohBc8oDTVycAhCFxrhutxyN8I4XaGbKB8yqnSsxD+GGXbd+0bydRXOCx1yluHkuMdJyTT0y/zjPebM1tDgbJUKCIOYpy8XvvxBySIfdPQsVmOfOn/WU0O6r9PwQqon956gDtXARjX9pT15x8L/jYHgdwiwV14Vd9TDgPEVE9wodsbEGaAoZ+hs2vqD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 23:18:10.6896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 119bde40-861e-495d-cd2e-08dec28f8b62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6194.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8367
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

I send another pull for -fixes, and figured I'd send out a few more fixes
for 7.2.

The following changes since commit 3ea273267fd29cbf6d83ee72329f59eb5042605b:

  drm/amd/pm: smu_v14_0_0: use SoftMin for gfxclk in set_soft_freq_limited_range (2026-06-03 14:02:35 -0400)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-next-7.2-2026-06-04

for you to fetch changes up to 56ae73c92e200e630c2bdf1e98c88b86c8483b37:

  drm/amdkfd: always resume_all after suspend_all (2026-06-04 15:38:08 -0400)

----------------------------------------------------------------
amd-drm-next-7.2-2026-06-04:

amdgpu:
- UserQ fix
- Userptr fix
- MCCS freesync fix
- Remove some triggerable BUG() calls
- DCN 4.2.1 fixes
- Lockdep annotations
- Guilty handling fix
- VCN 5.3 fix
- FRL fixes
- Bounds checking fixes
- HMM fix
- IRQ accounting fix

amdkfd:
- Fix an event information leak
- Events bounds check fix
- Trap cleanup fix
- Bounds checking fixes
- MES fix

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdkfd: always resume_all after suspend_all

Asad Kamal (1):
      drm/amd/pm: Stop pp_od_clk_voltage emit at PAGE_SIZE

Aurabindo Pillai (2):
      drm/amd/display: widen dc_hdmi_frl_flags.force_frl_rate to unsigned int
      drm/amd/display: use unsigned types for local pipe and REG_GET counters

Candice Li (1):
      drm/amd/pm: bound OD parameter parsing to stack array size

Ce Sun (1):
      drm/amdgpu: Fix user-triggerable BUG()/BUG_ON() calls

Christian König (2):
      drm/amdgpu: deprecate guilty handling
      drm/amdgpu: restart the CS if some parts of the VM are still invalidated

David Rosca (1):
      drm/amdgpu/userq: Fix reading timeline points in wait ioctl

Honglei Huang (1):
      drm/amdgpu: drop retry loop in amdgpu_hmm_range_get_pages

Jeevana Muthyala (1):
      drm/amdgpu/vcn5.0.0: enable secure submission on unified ring for VCN 5.3.0

Lijo Lazar (1):
      drm/amd/pm: Use strscpy in profile mode parsing

Matthew Stewart (2):
      drm/amd/display: Fix DCN42B version detection
      drm/amd/display: Add DCN42B to dml21_translation_helper

Michel Dänzer (1):
      drm/amd/display: Consult MCCS FreeSync cap only if requested & supported

Sunday Clement (1):
      drm/amdkfd: Add bounds check for AMDKFD_IOC_WAIT_EVENTS

Sunil Khatri (3):
      drm/amdgpu: compare MES firmware version ucode for gfx11
      drm/amdgpu: validate the mes firmware version for gfx12
      drm/amdgpu: validate the mes firmware version for gfx12.1

Vitaly Prosyak (1):
      drm/amdgpu: Add lockdep annotations for lock ordering validation

Yongqiang Sun (4):
      drm/amdkfd: fix SMI event cross-process information leak
      drm/amdkfd: Unwind debug trap enable on copy_to_user failure
      drm/amdkfd: fix sysfs topology prop length on buffer truncation
      drm/amdkfd: Fix infinite loop parsing CRAT with zero subtype length

Yunxiang Li (1):
      drm/amdgpu/gfx: move fault and EOP IRQ get/put to hw_init/hw_fini

 drivers/gpu/drm/amd/amdgpu/Makefile                |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c            |  25 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h            |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c            |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c        | 195 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.h        |  39 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c            |  12 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h            |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c     |  14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c    |   9 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |  43 +++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             | 162 ++++++++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             | 162 ++++++++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c             | 114 ++++++------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |  34 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c            |  35 ++--
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c             |   1 +
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c             |   1 +
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c             |   1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c              |   2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c            |  39 ++++-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c              |   8 +
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c             |   6 +
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  20 +--
 drivers/gpu/drm/amd/amdkfd/kfd_events.c            |   2 +
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c        |   8 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |   3 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  14 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h     |   2 +-
 .../gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c   |   2 +-
 .../dc/dml2_0/dml21/dml21_translation_helper.c     |   1 +
 .../dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.c  |   4 +-
 drivers/gpu/drm/amd/display/include/dal_asic_id.h  |   4 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |  20 ++-
 39 files changed, 716 insertions(+), 309 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.h
