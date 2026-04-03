Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F3A3E88D6A
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 21:43:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8435010E03A;
	Fri,  3 Apr 2026 21:43:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GSCp0wkI";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010037.outbound.protection.outlook.com [52.101.46.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7D6310E03A;
 Fri,  3 Apr 2026 21:43:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rXcBA+NFTuKZa3VOb/cZCEHbJpH794F9HPdBjMa21vMMsSLosNOTiIoaMy/q9N/nCwcWwt0S3i9Iw7KDCeHrJGvc9VceJWea9USKyQoWMeRqKK+gncne6t2sD/htGBwKEwu4tVnlrdRzJD1Jvx37g6pfZBSwQLvD4bZZXC8Tt4VkkY6A4wJxQdZI2Aa6XQ0T9/oh1j4u3nrsafhGVb5OC0l1cNE50HFpUnnZ5HmG6rbzZO+OQ+91TKcMCcO2eq2MEpkZb1NvqSgWmN26uhjbK0pUjlwUql+R0LunknUPxWoHMvj3XeHWaeeKzBx5m8GGttfStsE9ZftZ7lxeTsQFGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96Vxr0YoVkTMwLh/llnqYQ2xWowmCsSGmvIKWxQFoyc=;
 b=cMZCJx+ebt6/7U5QvWcWQoqwbAU1jfgoqoCEphKc0jOdtJYmFuiAS+SI94EYYAxTZjedUZ/gDFBSjJCvTk2JR2W+EykUm1/LgAGy/yZj/xfw0KDQn+55xHtQD0zurpG2ATNPgbxvCzczeznbjNOwVBza0CuDci+yjBhinP0TwGaPDDorsvRHsjrNYQ91VtxWt+Nk9qNEeuCZUh5SkT8nyMa4zB8qUfcs1BSxJpy8nVzJ2bfy8C9gM0TKhda9dF0PjdHiJfOqua4sWjaXueNKY9NLGhH/3cA3ar8WVqmM+VIapXHpS7s/2CqTYYLV/Be9CvvSgtLUkqfT38qnF/IQ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96Vxr0YoVkTMwLh/llnqYQ2xWowmCsSGmvIKWxQFoyc=;
 b=GSCp0wkIrALjU25XMhUuVeKeYevc+HtsfQAcRv/YLfWsq0P3MLh16u0so9pNcouN4bbfVHAqbAe1iwsqkeRll18N0gmhyZRz1Tfv81O3kg/8FeyTH1qF94Uan20G4r3Hm+DKT1HV3JW1vCwSxhw80md22pUCg5EkuXgLWYYdXJY=
Received: from SJ0PR13CA0111.namprd13.prod.outlook.com (2603:10b6:a03:2c5::26)
 by DM6PR12MB4108.namprd12.prod.outlook.com (2603:10b6:5:220::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 3 Apr
 2026 21:43:45 +0000
Received: from MWH0EPF000C6184.namprd02.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::f1) by SJ0PR13CA0111.outlook.office365.com
 (2603:10b6:a03:2c5::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.21 via Frontend Transport; Fri,
 3 Apr 2026 21:43:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6184.mail.protection.outlook.com (10.167.249.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 3 Apr 2026 21:43:44 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 3 Apr
 2026 16:43:43 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 3 Apr 2026 16:43:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd, radeon, drm drm-next-7.1
Date: Fri, 3 Apr 2026 17:43:28 -0400
Message-ID: <20260403214329.2976329-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6184:EE_|DM6PR12MB4108:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aaa0b92-f314-4e15-b2ce-08de91ca1455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 5WQ1hE/XfIu9OtOUq9iJNx4OSPRy+ROlzUGsPy9TZkwCpkka5l2cWo7n9FEvXQedeqE8MKfRa9ikZw6o+60gAS6z8+p64e0jnPpbNc09aGA/XCoowD2hvDcukBGK5mbk97yO+cXSrDv6Sc64D/HMDwuDCXM2feA8t+4WIbVJNz4PryppIP15DrNamJIG/rIT0OO9Zt8xBWNS9c9M22F6yzCGLi2IhZxlP/zCvilc5o1Ar1sRjBhHp68wjTU5ivY3d5I4KL1G0zP++8xFPxYUfVpdV3yNRFZxx3FiWYVk84pnIpbE3PmgE3yuxZqKdu8eql0BAZtFyol8AEsD0cFUi81XV+v9vXHFf0GO7xT2xsNV3jgn4aLeggo89s1cHD4lgrXbFF24uD8LzqKKRk+I85gWSqmsMhWgJRLPE16V5ia0FlYOmYlVq3/vidjpx5pcU4qD5eXIsgCjOwRp5qvoTmxC6X5d+krm5kKE9WQusAy+A5RFFusHaL8rSWsYaGz0auS8p/L7uYMPwGESgEK9Mi7ymMYNq+Ekimfi/6ngQC7mMjCda1voqURhC1aDz7uwjMi2njwh6/vp5e6RCPFov2SBbqJytTI1UaWUYUrxombwh1lRGyg5MaLsesLGoNVoYeuRlXC3ntlVukCnmtMQsP0uM2Iknv9GtwKGcHDNJZGAwSow/nsNpRdSo58CB39JPBLtweSRUBcX14aa5g+xdKphPSppAREybp9pmttCjQE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(13003099007)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kWpyiw35W6/Ki1cgy0P+SweoTQJ2TgVQ7Q4gc+pgTenLwOdrSyzojA4pOtjh+Hj/C4Dp9z/VyCIoxQueqmVWTQdaYDeMAUJRMAnAK22IC3eCtR0kqImFYFp/YwmnVti4S69rg9mlEgwollgES3cQS0N8UoPqZogxVMz2/Hv8F/dARDm/LcpUok/Q+R+uUuL55uT9j1ytmAHH0zVtCgHwhVMJN1qMTBLtoNSm+/XzFTDgJnqDJiTdx6otLadW60Kl0/DXDVzhOJyKctd13GZ/kpAHDSI5kgZL03AntBmEZlic71I5lnKlpePWYrbzchDXTEfX5rvYnVuuuBJEWFSnoyASXphnx8qinQgQQKh1d9O8Wg23Mu6Qkc6JyIHBMZ3tlQNeF4CJ8GAdPyTL6V5EISdm+NydkfZTSZWvUSylgoukTVs4mgFwuscg/sUaBxiT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 21:43:44.2425 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aaa0b92-f314-4e15-b2ce-08de91ca1455
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6184.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4108
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

A few last changes for 7.1.

The following changes since commit 512f9f150f367176fa9e5f4613b4863409a6f686:

  Merge tag 'drm-msm-next-2026-04-02' of https://gitlab.freedesktop.org/drm/msm into drm-next (2026-04-03 18:57:00 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-next-7.1-2026-04-03

for you to fetch changes up to 7b15fc2d1f1a00fb99f0146e404ff2600999ec74:

  drm/amdgpu: dump job ibs in the devcoredump (2026-04-03 16:16:25 -0400)

----------------------------------------------------------------
amd-drm-next-7.1-2026-04-03:

amdgpu:
- Audio regression fix
- Use drm edid parser for AMD VSDB
- Misc cleanups
- VCE cs parse fixes
- VCN cs parse fixes
- RAS fixes
- Clean up and unify vram reservation handling
- GPU Partition updates
- system_wq cleanups
- Add CONFIG_GCOV_PROFILE_AMDGPU kconfig option
- SMU vram copy updates
- SMU 15 fixes
- SMU 13 fixes
- SMU 14 fixes
- UserQ fixes
- Replace pasid idr with an xarray
- Dither handling fix
- Enable amdgpu by default for CIK APUs
- Add IBs to devcoredump

amdkfd:
- system_wq cleanups

radeon:
- system_wq cleanups

drm:
- Add support for AMD VSDB parsing to drm_edid

----------------------------------------------------------------
Benjamin Cheng (5):
      drm/amdgpu: Add bounds checking to ib_{get,set}_value
      drm/amdgpu/vce: Prevent partial address patches
      drm/amdgpu/vcn3: Prevent OOB reads when parsing dec msg
      drm/amdgpu/vcn4: Prevent OOB reads when parsing dec msg
      drm/amdgpu/vcn4: Prevent OOB reads when parsing IB

Ce Sun (1):
      drm/amd/ras: enable uniras via IP version check

Chenyu Chen (2):
      drm/edid: Parse AMD Vendor-Specific Data Block
      drm/amd/display: Use drm_display_info for AMD VSDB data

Ionut Nechita (1):
      drm/amd/display: Wire up dcn10_dio_construct() for all pre-DCN401 generations

Lijo Lazar (17):
      drm/amdgpu: Add reserved region ids
      drm/amdgpu: Add stolen vga reserve-region
      drm/amdgpu: Add extended stolen vga reserve-region
      drm/amdgpu: Add stolen_reserved reserve-region
      drm/amdgpu: Add fw_reserved reserve-region
      drm/amdgpu: Add firmware extended reserve-region
      drm/amdgpu: Add fw vram usage reserve-region
      drm/amdgpu: Add host driver reserved-region
      drm/amdgpu: Add memory training reserve-region
      drm/amdgpu: Group filling reserve region details
      drm/amdgpu: Add function to fill fw reserve region
      drm/amdgpu: Add function to fill training region
      drm/amdgpu: Move validation of reserve region info
      drm/amdgpu: Consolidate reserve region allocations
      drm/amd/pm: Add smu vram copy function
      drm/amd/pm: Use smu vram copy in SMUv13
      drm/amd/pm: Use smu vram copy in SMUv15

Linus Probert (2):
      drm/amd/display: Replace inline NUM_ELEMENTS macro with ARRAY_SIZE
      drm/amd/display: Remove unused NUM_ELEMENTS macros

Marco Crivellari (5):
      drm/amd/display: Replace use of system_wq with system_percpu_wq
      drm/amdgpu: replace use of system_unbound_wq with system_dfl_wq
      drm/amdgpu: replace use of system_wq with system_dfl_wq
      amd/amdkfd: add WQ_UNBOUND to alloc_workqueue users
      drm/radeon: add WQ_PERCPU to alloc_workqueue users

Mario Kleiner (1):
      drm/amd/display: Change dither policy for 10 bpc output back to dithering

Mikhail Gavrilov (1):
      drm/amdgpu: replace PASID IDR with XArray

Pierre-Eric Pelloux-Prayer (4):
      drm/amdgpu: save ring content before resetting the device
      drm/amdgpu: extract amdgpu_vm_lock_by_pasid from amdgpu_vm_handle_fault
      drm/amdgpu: store ib info for devcoredump
      drm/amdgpu: dump job ibs in the devcoredump

Prike Liang (2):
      drm/amdgpu: rework userq fence driver alloc/destroy
      drm/amdgpu: make userq fence_drv drop explicit in queue destroy

Srinivasan Shanmugam (3):
      drm/amd/display: Fix dc_is_fp_enabled name mismatch
      drm/amd/display: Fix parameter mismatch in panel self-refresh helper
      drm/amd/display: Fix missing parameter details in amdgpu_dm_ism

Sunil Khatri (5):
      drm/amdgpu/userq: dont need check for return values in amdgpu_userq_evict
      drm/amdgpu/userq: fence wait for max time in amdgpu_userq_wait_for_signal
      drm/amdgpu/userq: add the return code too in error condition
      drm/amdgpu/userq: call dma_resv_wait_timeout without test for signalled
      drm/amdgpu/userq: use dma_fence_wait_timeout without test for signalled

Timur Kristóf (1):
      drm/amdgpu: Use amdgpu by default for CIK APUs too

Vitaly Prosyak (1):
      drm/amdgpu: add CONFIG_GCOV_PROFILE_AMDGPU Kconfig option

Xiaogang Chen (1):
      drm/amdgpu: add an option to allow gpu partition allocate all available memory

Yang Wang (4):
      drm/amd/pm: correct mem_busy_percent display due to calculation errors
      drm/amd/pm: fix null pointer dereference issue in smu_v15_0_8_get_power_limit()
      drm/amd/pm: optimize logic and remove unnecessary checks in smu v15.0.8
      drm/amd/pm: fix memleak issue in smu_v15_0_8_get_gpu_metrics()

 drivers/gpu/drm/amd/amdgpu/Kconfig                 |  17 +
 drivers/gpu/drm/amd/amdgpu/Makefile                |   4 +
 drivers/gpu/drm/amd/amdgpu/aldebaran.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   5 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c       |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c   |  18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c   | 191 +++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h   |  21 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |  39 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h            |  17 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |  23 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h            |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c            |  39 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h            |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c          |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h           |  11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            | 362 +++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h            |  53 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |  81 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c    |  32 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h    |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           |  50 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  89 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c            |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h            |   2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |  10 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             |  10 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c             |  11 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |   2 -
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c             |   2 -
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c             |   2 -
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c              |   2 -
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c              |   2 -
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c              |   2 -
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |   2 -
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c             |  10 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c             |  10 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c              |  23 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c              |  44 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |   3 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 128 ++++----
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |  14 -
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |  21 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c  |   9 +
 drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c     |   2 +-
 .../gpu/drm/amd/display/dc/core/dc_hw_sequencer.c  |   5 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |   2 +-
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |   6 +-
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c    |   3 -
 .../drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c  |   3 -
 .../gpu/drm/amd/display/dc/mpc/dcn20/dcn20_mpc.c   |   2 -
 .../gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c   |   4 -
 .../amd/display/dc/resource/dcn10/dcn10_resource.c |  41 +++
 .../amd/display/dc/resource/dcn20/dcn20_resource.c |  42 +++
 .../display/dc/resource/dcn201/dcn201_resource.c   |  41 +++
 .../amd/display/dc/resource/dcn21/dcn21_resource.c |  34 ++
 .../amd/display/dc/resource/dcn30/dcn30_resource.c |  42 +++
 .../display/dc/resource/dcn301/dcn301_resource.c   |  42 +++
 .../display/dc/resource/dcn302/dcn302_resource.c   |  41 +++
 .../display/dc/resource/dcn303/dcn303_resource.c   |  41 +++
 .../amd/display/dc/resource/dcn31/dcn31_resource.c |  40 +++
 .../display/dc/resource/dcn314/dcn314_resource.c   |  40 +++
 .../display/dc/resource/dcn315/dcn315_resource.c   |  40 +++
 .../display/dc/resource/dcn316/dcn316_resource.c   |  40 +++
 .../amd/display/dc/resource/dcn32/dcn32_resource.c |  43 +++
 .../display/dc/resource/dcn321/dcn321_resource.c   |  43 +++
 .../amd/display/dc/resource/dcn35/dcn35_resource.c |  43 +++
 .../display/dc/resource/dcn351/dcn351_resource.c   |  43 +++
 .../amd/display/dc/resource/dcn36/dcn36_resource.c |  43 +++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |  17 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |  10 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c  |   9 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |  19 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |  10 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   |  10 +-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c   |  76 ++---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             |  12 +
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h             |   3 +
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c   |   9 +-
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c  |  16 +-
 drivers/gpu/drm/drm_edid.c                         |  72 ++++
 drivers/gpu/drm/radeon/radeon_display.c            |   3 +-
 drivers/gpu/drm/radeon/radeon_drv.c                |   3 +-
 include/drm/drm_connector.h                        |  38 +++
 92 files changed, 1756 insertions(+), 703 deletions(-)
