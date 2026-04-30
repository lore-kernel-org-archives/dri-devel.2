Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48934FF8875
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 13:56:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AC6A10E9D4;
	Thu, 30 Apr 2026 13:56:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eXMk8MoP";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013046.outbound.protection.outlook.com
 [40.107.201.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBC2B10E7E1;
 Thu, 30 Apr 2026 13:56:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+IiS98HW/VRZHsIG5eSmifdJlH6idT8izagLqJxxJdUhyOjzieWqAszFkJAJQqJDYjKQ1A1SqcbhnObF9pEnP+vIxr1Mdj6vunZRGdHE4lnluLtCb61uPlnZ1N+wrjVurzg/3oaKcaz3vkGzT2qatC7u+m8eCE3gtsjyBbsk1NQHga9qEaE4epBCc55Dw6zUFT06btHCOgwLR6km519A3I8uHt6+ne6MV0w/bmuHftCILa9GYgOoLcC/w8otSDXSPmRWzC6iDjmyLtBGcfoHL3gp5xxCPfrxcEgZ5OD8nkpU/FQ56Bq8zEuzaGCI/U5nYhMjYeIH2JxV8V5gbWKzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3biIT7c5z83xmnkeJMsGWRkFB4QjdSHVn495mV9Gps=;
 b=K+TD5KANgR4RPL8Dj2b/TE61zXGAtTpt5WhKhtfTrxpN3vEvzn1jA2TDdFo3Mj10OIPDbe9jf/7p35GQS77+uj9t4088oSRLI/h9nakUOWrzBc1tyWSB/cMRTF0OqWAO9xxxTZfrBfjCGhWdZpauwBtp7I9LKeQSn4G/rvkzWL5JVeCPY4uNG/gir9TOogFMHt+5mSPXuJMds0v009YS27it3AHJo3GQw29NKJznRwS9BNzce3lLu1X6GYBCgVllg7IGYyoP8IcelK0sLnvs/MwIeE43xzrU9gX40nhZfEOuVUF79Qdq4fdEnuRGuQ+cLvvChvSSfQAt6y17x8oeMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3biIT7c5z83xmnkeJMsGWRkFB4QjdSHVn495mV9Gps=;
 b=eXMk8MoPe2QMGD7qin+uHWT5LdvIgRT7EN5ouJQB88AO7usgRCp5Ga2/gGQd9XqPLj3R6s44eD1tyy9wNmpBgcd6PYFXYhm3asPmA0BeI6lLYPj6JuKZo2hnBdJV83W6pL8/SYR4GMT6EAzKW1u8VxOSv4s8DJ7TYKofrtjpP78=
Received: from BL0PR05CA0015.namprd05.prod.outlook.com (2603:10b6:208:91::25)
 by DM4PR12MB8475.namprd12.prod.outlook.com (2603:10b6:8:190::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.21; Thu, 30 Apr
 2026 13:56:34 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::e2) by BL0PR05CA0015.outlook.office365.com
 (2603:10b6:208:91::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.5 via Frontend Transport; Thu,
 30 Apr 2026 13:56:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 13:56:33 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 08:56:31 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Apr 2026 08:56:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd drm-fixes-7.1
Date: Thu, 30 Apr 2026 09:56:19 -0400
Message-ID: <20260430135619.3929877-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|DM4PR12MB8475:EE_
X-MS-Office365-Filtering-Correlation-Id: 59902c38-5544-46a8-53da-08dea6c049fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: J7fanROB3NiqVbLubPqkEhEB95C0UF/bcMuHknlnlpe+0mlW68u1/RxcJDJf8CHQu1qVf6rE1dENttpblcwMp+QEaEa4kDZaM8Oi4+3pogkzo56kSupEWenvdCfDTzRcEZv3O2Zjdc6Lyvrshcfw7JnExhBXmT389BR1IVp7glj1axUm7VM0T2IlyfcU1nId0u/rmRDHPN7Rm4aprYsJGCIBswSyULHDixa8zlcA54+V159f1hDQ3li/aeihLW6nkAqY0QT2sUFn+ngGXC9FTmRLaDF3VjZrsOJ0HyIJNT70Dol2xEvTQHkkHLPMP8oUNPSym+F2iMhLmznw6NO3QS0SPh/P+k8MAYjYIxvA2yo59ulAovS2EnTartB2auf+XvFNSCc5vYx0rcnnsels0NYioJ7DOWjqSICQ5puto7W8lG9vd3nEQ/4f7+/yNneEK8IHRHYq7XfRneHoR9VX1Hrn9ZHhUnHSKhm+TjRro+QRiRUbqbCVR9YCXgvq0q6ycg/U+WmbN4rom/oYb3Ia1v3BbbO94MVk9W8k8AhclPuf2gTHF3fjj3QlAa3Eki7z8zCzp1cUXkKowtikVvbddo+jX6gvIKlq5446ELTs5/UMctM37zHpbqLOGlvlNRbUH+q300C4GRyKBFrhHvMFnFxGQcq5Nr4sdnFDhCFpJAJRacmt3CzzbGtWkc97FB6NLmx+oReC7eWoQNM8d8ghmI+LTy7oVD5dxmTw5jjvdfM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(13003099007)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: u53HXBYyZ057l/uXz5fqPZDZp/yuwqtWrG6ekDKnbW9NGekpxlGNaEWrvmmh+FFHdsQ1egEE6hFz8q1LSBDaj8tOuF82XGTKC1/Q2bCXAADqjmrq+DhLq2U1DYWoRPpct78LvPIKOmtyAJNquxvo/yDFUo5+SQlvcH+SHtGW68uJ9KY3sR8cObIrmcAXMeMQcaF3hu6O64c3JR0HM1OAaCjdGvR3Huc4YIyexVi+ZqWoyGrNBQYX7I/jep4/PfrhaCN+x3vzZzYsYp5mMQNMSdJo+qOYMHgfKk5Z5tUhjJrdVDg166+owJaQkvLucMjCk1HLvM4BrAah0/qnXeEodAOYehiRk5gdiydrfIMu4v0GVAgx1dNTe0zA9/PDg9kDQvhVRUwcY/59JaLGRNB0+UcucCiJ5P0MfvWR4PWKR46JyDBkNwEZ+JFwJGJntJGW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 13:56:33.7910 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59902c38-5544-46a8-53da-08dea6c049fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8475
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

The following changes since commit e49712ef03dbc4e282dd0e76469642279c2811e5:

  Merge tag 'amd-drm-fixes-7.1-2026-04-23' of https://gitlab.freedesktop.org/agd5f/linux into drm-next (2026-04-24 09:17:41 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-fixes-7.1-2026-04-30

for you to fetch changes up to 019155e2bd3e2cec425553195e9f9bc76bb0f848:

  drm/amd/display: Use EDID from VBIOS embedded panel info (2026-04-29 10:41:46 -0400)

----------------------------------------------------------------
amd-drm-fixes-7.1-2026-04-30:

amdgpu:
- GFX12 fix for CONFIG_DRM_DEBUG_MM configs
- Fix DC analog support
- Userq fixes
- GART placement fix
- Aldebaran SMU fixes
- AMDGPU_INFO_READ_MMR_REG fix
- UVD 3.1 fix
- GC 6 TCC fix
- Fix root reservation in amdgpu_vm_handle_fault()
- RAS fix
- Module reload fix for APUs
- Fix build for CONFIG_DRM_FBDEV_EMULATION=n
- IGT DWB regression fix
- GC 11.5.4 fix
- VCN user fence fixes
- JPEG user fence fixes
- SMU 13.0.6 fix
- VCN 3/4 IB parser fixes
- NV3x+ dGPU vblank fix
- DCE6/8 fixes for LVDS/eDP panels without an EDID

amdkfd:
- Fix for when CONFIG_HSA_AMD is not set
- SVM fixes

----------------------------------------------------------------
Alex Deucher (1):
      drm/amd/display: properly handle family setting for early GC 11.5.4

Alysa Liu (1):
      drm/amdkfd: validate SVM ioctl nattr against buffer size

Arjan van de Ven (1):
      drm/amdgpu: fix zero-size GDS range init on RDNA4

Benjamin Cheng (2):
      drm/amdgpu/vcn3: Avoid overflow on msg bound check
      drm/amdgpu/vcn4: Avoid overflow on msg bound check

Christian König (2):
      drm/amdgpu: fix AMDGPU_INFO_READ_MMR_REG
      drm/amdgpu: rework userq fence signal processing

Gaghik Khachatrian (1):
      drm/amd/display: Update MCIF_ADDR macro to address IGT DWB regression

Hongyan Xu (1):
      drm/amdgpu: avoid double drm_exec_fini() in userq validate

Kent Russell (1):
      drm/amdgpu: Only send RMA CPER when threshold is exceeded

Leo Li (1):
      drm/amd/display: Restore 5s vbl offdelay for NV3x+ DGPUs

Lijo Lazar (2):
      drm/amd/pm: Update emit clock logic
      drm/amd/pm: Add fine grained flag to SMU v13.0.6

Mario Limonciello (AMD) (1):
      amdkfd: Only ignore -ENOENT for KFD init failuires

Pierre-Eric Pelloux-Prayer (1):
      drm/amdgpu: fix root reservation in amdgpu_vm_handle_fault

Prike Liang (1):
      drm/amdgpu: clean up the userq unmap error handler

Roman Li (1):
      drm/amd/display: Restore analog connector support

Shubhankar Milind Sardeshpande (1):
      drm/amdgpu: Avoid reset in AMDGPU unload path for APUs with GFX V11 and higher.

Timur Kristóf (9):
      drm/amdgpu/gmc: Fix AMDGPU_GART_PLACEMENT_LOW to not overlap with VRAM
      drm/amdgpu/uvd3.1: Don't validate the firmware when already validated
      drm/amdgpu/gfx6: Support harvested SI chips with disabled TCCs (v2)
      drm/amd/display: Allow embedded connectors without DDC
      drm/amd/display: Allow DCE link encoder without AUX registers
      drm/amd/display: Allow constructing DCE6 link encoder without DDC
      drm/amd/display: Allow constructing DCE8 link encoder without DDC
      drm/amd/display: Read EDID from VBIOS embedded panel info
      drm/amd/display: Use EDID from VBIOS embedded panel info

Yang Wang (1):
      drm/amd/pm: fix missing fine-grained dpm table flag on aldebaran

Yinjie Yao (19):
      drm/amdgpu/vcn: set no_user_fence for VCN v2.0 enc/dec rings
      drm/amdgpu/vcn: set no_user_fence for VCN v2.5 enc/dec rings
      drm/amdgpu/vcn: set no_user_fence for VCN v3.0 enc/dec rings
      drm/amdgpu/vcn: set no_user_fence for VCN v4.0 enc ring
      drm/amdgpu/vcn: set no_user_fence for VCN v4.0.3 enc ring
      drm/amdgpu/vcn: set no_user_fence for VCN v4.0.5 enc ring
      drm/amdgpu/vcn: set no_user_fence for VCN v5.0.0 enc ring
      drm/amdgpu/vcn: set no_user_fence for VCN v5.0.1 enc ring
      drm/amdgpu/vcn: set no_user_fence for VCN v5.0.2 enc ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v2.0 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v2.5 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v3.0 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v4.0 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v4.0.3 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v4.0.5 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v5.0.0 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v5.0.1 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v5.0.2 ring
      drm/amdgpu/jpeg: set no_user_fence for JPEG v5.3.0 ring

YuanShang (1):
      drm/amdkfd: check if vm ready in svm map and unmap to gpu

Yury Norov (1):
      drm/amdgpu: fix build for CONFIG_DRM_FBDEV_EMULATION=n

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |  5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            | 57 ++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          | 22 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             | 17 +++-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             | 10 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             | 10 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c             | 11 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c              | 66 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c             |  1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c             |  2 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c             |  1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c             |  1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c           |  1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c           |  1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c           |  1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c           |  1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c           |  1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c           |  1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c             | 11 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c             | 11 +--
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c              | 10 +++
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c              |  2 +
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c              |  2 +
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c              |  7 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c              |  5 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c            |  1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c            |  1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c            |  1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c            |  1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c            |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           | 26 +++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |  3 +
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               | 11 +++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 24 +++++-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  | 44 ++++++++++
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c  | 73 ++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc.h                |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_bios_types.h     |  3 +-
 .../gpu/drm/amd/display/dc/dce/dce_link_encoder.c  |  4 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mmhubbub.c  |  4 +-
 drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c |  3 +
 .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c  | 94 ++++++++++++++--------
 drivers/gpu/drm/amd/display/dc/link/link_factory.c |  4 +-
 .../amd/display/dc/resource/dce60/dce60_resource.c |  3 +-
 .../amd/display/dc/resource/dce80/dce80_resource.c |  3 +-
 .../amd/display/include/grph_object_ctrl_defs.h    |  4 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c |  1 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |  1 +
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             |  2 +-
 include/drm/drm_fb_helper.h                        |  6 ++
 56 files changed, 447 insertions(+), 152 deletions(-)
