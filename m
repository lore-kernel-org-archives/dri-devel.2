Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50323C88E45
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 21:31:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C18310E8C0;
	Thu, 10 Sep 2026 21:31:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sYoB279u";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012004.outbound.protection.outlook.com
 [40.93.195.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C5BA10E763;
 Thu, 10 Sep 2026 21:30:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J8ap6YqVciL2ktZBckho2w0NV+oP/8ZIqu7gSydqaq2t+K9q/rKBt+xjNAs1/ZUBetbmTmRsO3wQA/wvQCfmnd4QMwrn6wFo16UPP+jQtJ/2QlpP/1sJTzLZ4PYJysjAOKvw7jkMMD4g0RQhyDxeIotjm973tiXiaCEq+TJQ01Tg8068mhE7XFpucDHGenuSm87ENPbdn+qxHILOl6ul6J4I834z9f73BNOUl5LKJFZYkWkL+HU/KelNBeMEnktPnfWeiW66ru8uHpv+vorbPJgS90LaqTkAiPF2Z14rn4tSPz+cdj2X8mRWrCqi/9t3X7/lNJgoucS1zmg7/oDSrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6O6XvwHdpgYMtJFmgehBkl6pxhqRpRb4+Ymeqr6zNE=;
 b=Kvucb0mbsrfLRju2i0lYgfsWmkBLmNpXqSTqCri1JiyxtO4okmnedAXp+JD0zryKmYqgEsoRhCCthOkcLOtq4UaB4WWerLIZA/vWIDN9RvQ9faUw0bLzz9t6un89l74x6C4UUdznu0K+AuRGXYBNCQ+PoSVLhL4Qs151ct2INE1+fi6lhwBAMTg8Egt4ps3vyoiPobwP2uwdodvg/PaxAF6VBYgow7pbtkaqES6BWEOG8rBHoQpNhZupjfkkb6Lbuz8T+dq1v8QjXu9XpJfGU5fH6ZJNsIsYal9ipK3HAdf7r3W5KuI15f0+rpPgjYOcv1A1KTS8JHECVYaGiFpWRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6O6XvwHdpgYMtJFmgehBkl6pxhqRpRb4+Ymeqr6zNE=;
 b=sYoB279utF2bbPPiFsFnhMDj4yiAycxE7LCZBf3ksIx8dg5pCDHCrjEw8lxQRX8j5tTD8JvXy0FeqZZ1hB16JzQ9MYCjFtfiU7lLYmZJP3edVyr1zgfDAthQ6C5f/tCcfeO/6SGYZqZ6oZC2e/6BaGSPvf8kZ7crmLeJCqVXCYs=
Received: from CH2PR14CA0057.namprd14.prod.outlook.com (2603:10b6:610:56::37)
 by MN0PR12MB6003.namprd12.prod.outlook.com (2603:10b6:208:37f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 21:30:50 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::a8) by CH2PR14CA0057.outlook.office365.com
 (2603:10b6:610:56::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Thu, 10
 Sep 2026 21:30:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 21:30:48 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 16:30:47 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 16:30:47 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Thu, 10 Sep 2026 16:30:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd, drm, UAPI drm-next-7.4
Date: Thu, 10 Sep 2026 17:30:39 -0400
Message-ID: <20260910213040.826425-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|MN0PR12MB6003:EE_
X-MS-Office365-Filtering-Correlation-Id: bca0668c-ffa2-4687-a543-08df0f82c7e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|376014|82310400026|5023799004|56012099006|11063799006|18002099003|10086099003|18092099006|3023799007|10067099003|13003099007|6133799003;
X-Microsoft-Antispam-Message-Info: Gexfu/PW9Puzawy6OmUfvhBMDN+FAZh1VU+T4ezJkZ2wtnEPMYG/s9vZsAIMZ8G9mO2W6uB9S7Sb7FM+hdHoyR67GP2tPx6uWmvAUQsLdtwkEk8HElMVHQ/UPagiGf0g0LFacT/U7Ys285WQB8PxLczR3QwxUAUJalUwl87+ZeWVNaeKaLH9Gxp06E4c0AnQw4N2zWReCilzLbPKLza+oiiexJUQJVyHzoKofU6aAL/NNZeIE107F5FX2X9hfGU45RysQPtpXaWA6c1VEQRRmC7a/UAbAxZls8BAzYJkxl8qJBfydNdCGhuFf4GLFEaexOc4H+2KlMpKLYfwvXbix0naQW+a+dVg5h7+AWJJV83s2Ja2+kAADsfU+tKMluphyQiSM3KqPqzTvWOrDPY6JkAAU9DxSEJvqCMPj0f+yQXUB2jgkMRL+1kNEmzBKqz7++VEdhX/PGGF+mK1+eOGf4wZ2ot9cOMrk1G+TVfLtj0rZ4aFBWabbSqoXMoHmKCE9Yxd6W93d5IoB5a0kPVXac32E+NthEVC/H0BFOS8cXvnf+Wt90qW0NWnJWaLnmsRBdmJpR/agyenq0HjdjHAtzHY/H9FB0krn09589eGHH7ubn5jjh6r+W2lVyRzyoBEr7gMOSF5EZhFWAqStCmSsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(376014)(82310400026)(5023799004)(56012099006)(11063799006)(18002099003)(10086099003)(18092099006)(3023799007)(10067099003)(13003099007)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 685/wwnlUmAgb2szW3Jss4r2lK876x+8Dc6GgGCLHG6Vjz9FUux9dQgu1k8NbHauN4+tj9k16KRM2nGSg8yDqoGoBf29io8iaXdSiHyJ3EcZcGK7OoanRk9jJ+un3uDU8RMQhImvNEBQV/AfNzp3pkmkrRmNubZA5EXrfvNnIMYW6onHZ+Xv+S/n3pSdHTti1hH2jKh3zUG6nBjQrgtKe/v82b6qWq2D85AMF9VS6sX0I/V+z0PLwSmQZHsmpUmUaH1PT7FOSd+g70moz1tXKBKs/LkmQmOgkm3HDISEuuuns2+nshxzVtljovLEhKjAA5XBL+jARxV60Ki9ShwXQ+7ZIqL7XcpUtcB0vDKfRAo4tQ3aTbp1Kn63VTWSMSMNJ85aeIThaqJo2WCwhiDPE2kfnqqt3gX201y924vagDBoTbLhWSUIWsmsDwUpPkXA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 21:30:48.3287 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bca0668c-ffa2-4687-a543-08df0f82c7e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6003
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

New stuff for 7.4.

The following changes since commit 92a9eebd2a1f892fe482154d83f9f1626bc73d3b:

  drm/amd/display: fix dc_lock leak on GPU reset error paths (2026-08-25 18:24:30 -0400)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/amdgpu/kernel.git tags/amd-drm-next-7.4-2026-09-10

for you to fetch changes up to 9f725dd80ae781ac046420e0e53ffe5b3bcfa44b:

  rust/drm/gem: initialize callbacks with ..pin_init::zeroed() (2026-09-10 12:12:09 -0400)

----------------------------------------------------------------
amd-drm-next-7.4-2026-09-10:

amdgpu:
- Freesync fixes
- GPUVM fix
- Debugfs fixes
- HDMI updates
- IPS fix
- GPU reset fix
- RGB quantization fixes
- SMU 13.0.x fixes
- MES updates
- UserQ updates
- UVD fix
- Various bounds checks
- DML fixes
- DCN 6 updates
- NBIO 7.11.5 support
- Audio fixes
- More display KUnit tests
- SMU 15 updates
- RAS updates
- VCN 5.0.2 updates
- JPEG 5.0.2 updates
- DCN 4.2 updates
- PSR fixes
- Misc cleanups
- PSP 15.0.8 updates
- RAS BERT support
- RAS CPER updates
- vblank fixes
- LSDMA updates
- GC 12.1 updates
- MMHUB 4.2 updates
- NBIO 6.3.2 updates
- SMU 15.0.8 updates
- IP discovery updates
- GPU spatial partitioning updates
- HDMI 2.1 freesync support
- HDMI 2.1 ALLM support
- HDMI 2.1 VRR support
- Require jobs for IBs
- Enable FRL for HDMI
- MES oversubscription fixes
- IH 6-7 updates
- GMC 11-12 fault handling updates
- Fixed point cleanup
- Backlight fixes
- GPUVM cleanup
- Devcoredump fixes
- UALoE (UALink over Ethernet) Support
- SDMA userq fixes
- GC 8 fix

amdkfd:
- Various bounds checks
- SVM fixes
- GC 12.1 updates
- MES updates
- Trap handler fixes
- Debugfs fixes

drm:
- Add gem callback for when handle count goes to 0
- Rust fix

UAPI:
- INFO IOCTL fix for 32 bit userspace on 64 bit kernel
- Add syncobj_points to USERQ signal ioctl
    Proposed userspace:
    * radeonsi NV_timeline_semaphore
    https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/37335
    * RADV user queues
    https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/40808
- Add UALink support IOCTLs
    Proposed userspace:
    https://github.com/ROCm/rocm-systems/blob/35959f8e1260c7cee3e51a740e320be3856ee4ff/projects/rocr-runtime/libhsakmt/src/memory.c#L971
    https://github.com/ROCm/rocm-systems/blob/35959f8e1260c7cee3e51a740e320be3856ee4ff/projects/rocr-runtime/libhsakmt/src/memory.c#L1036

----------------------------------------------------------------
Alex Deucher (5):
      drm/amdgpu/gfx8: only apply compute quantums to KCQs
      drm/amdgpu: switch all IPs to using job for IBs
      drm/amdgpu: require a job to schedule an IB
      Documentation: add initial UALink Documentation
      drm/amdgpu/gmc12: drop duplicate gmc.init_pte_flags

Alex Hung (91):
      drm/amd/display: test stream VRR updates
      drm/amd/display: test VRR IRQ parameters
      drm/amd/display: test VRR transitions
      drm/amd/display: test dm_check_cursor_fb
      drm/amd/display: test native cursor state check
      drm/amd/display: test dm_plane_color_pipeline_active
      drm/amd/display: test amdgpu_dm_crtc_get_cursor_mode
      drm/amd/display: Test writeback connector
      drm/amd/display: Test GPU memory allocation
      drm/amd/display: Test EDID quirks and ACPI EDID read
      drm/amd/display: Test execute_synaptics_rc_command failures
      drm/amd/display: Test MST stream feature read failure
      drm/amd/display: Test dm_helpers_submit_i2c_over_aux
      drm/amd/display: Test GPU memory allocate and free helpers
      drm/amd/display: Test dm_helpers_dmub_set_config_sync
      drm/amd/display: Test dm_helpers_is_dp_sink_present
      drm/amd/display: Test dm_helpers_read_local_edid
      drm/amd/display: Test dp_handle_test_pattern_request patterns
      drm/amd/display: Test DMUB reg callbacks
      drm/amd/display: Test VBIOS bounding box
      drm/amd/display: Test dm_init_microcode
      drm/amd/display: Test dm_dmub_sw_init
      drm/amd/display: Test MST sideband message ack path
      drm/amd/display: Test dm_dp_mst_get_modes without a remote EDID
      drm/amd/display: Test dm_dp_mst_get_modes with a remote EDID
      drm/amd/display: Test dm_dp_mst_detect DPCD probe and unplug
      drm/amd/display: Test MST connector register and unregister
      drm/amd/display: Test dm_dp_mst_connector_destroy
      drm/amd/display: Test plane state duplicate and destroy
      drm/amd/display: Test modifier list de-duplication
      drm/amd/display: Test GFX6-8 tiling info from modifiers
      drm/amd/display: Test GFX6-8 tile mode and tile split lookups
      drm/amd/display: Test GFX6-8 modifier calculation
      drm/amd/display: Test GFX6-8 modifier list generation
      drm/amd/display: Test framebuffer prepare and cleanup
      drm/amd/display: Test cursor update and async plane update
      drm/amd/display: Refactor amdgpu_dm_irq_test
      drm/amd/display: Test pageflip completion in the high IRQ handlers
      drm/amd/display: Test writeback handling in dm_crtc_high_irq
      drm/amd/display: Test schedule_dc_vmin_vmax
      drm/amd/display: Test handle_hpd_irq_helper detect and debounce exits
      drm/amd/display: Test HPD RX, HPD init and DMUB callback branches
      drm/amd/display: Test dm_dmub_outbox1_low_irq drain and work guards
      drm/amd/display: Test amdgpu_dm_dce110_register_irq_handlers
      drm/amd/display: Test amdgpu_dm_dcn10_register_irq_handlers
      drm/amd/display: Test ISM idle commit
      drm/amd/display: Test ISM idle exit arms
      drm/amd/display: Test ISM delayed workers
      drm/amd/display: Test colorop error paths
      drm/amd/display: Model ASSERT as path terminator
      drm/amd/display: Test backlight caps validation
      drm/amd/display: Skip ACPI backlight caps test
      drm/amd/display: Test vblank counter and scanout position
      drm/amd/display: Test DM atomic private state helpers
      drm/amd/display: Test affected MST DSC CRTC selection
      drm/amd/display: Test cursor commit
      drm/amd/display: Test vblank event arming
      drm/amd/display: Test page flip interrupt state update
      drm/amd/display: Test CRTC memory domain change detection
      drm/amd/display: Test PSR dirty rectangle filling
      drm/amd/display: Test plane reset decision
      drm/amd/display: Test link and sink dump
      drm/amd/display: Test HDCP update
      drm/amd/display: Test global modeset lock acquisition
      drm/amd/display: Test timing sync trigger
      drm/amd/display: Test IP block teardown and link emulation
      drm/amd/display: Test mod_power stream updates on modeset
      drm/amd/display: Test atomic commit setup
      drm/amd/display: Test MMHUB config read
      drm/amd/display: Test power module init
      drm/amd/display: Test vline0 irq control
      drm/amd/display: Test DMCU firmware load
      drm/amd/display: Test SW init and fini
      drm/amd/display: Test DM late init
      drm/amd/display: Test mode and plane init
      drm/amd/display: Test DM early init
      drm/amd/display: Test DC plane info fill
      drm/amd/display: Test DC plane attributes
      drm/amd/display: Test MST VCPI slot calc
      drm/amd/display: Test vblank IRQ handling
      drm/amd/display: Test self refresh entry
      drm/amd/display: Test GPU reset helpers
      drm/amd/display: Test plane update adapter
      drm/amd/display: Test MST resume guards
      drm/amd/display: Test cached suspend state
      drm/amd/display: Test writeback state transitions
      drm/amd/display: Test atomic validation guards
      drm/amd/display: Fix unused params in flip sched
      drm/amd/display: Validate irq source in DM IRQ handler
      drm/amd/display: Test DM IRQ handler source guard
      drm/amd/display: Fix signedness mismatches in cm3

Alex Sierra (6):
      drm/amdgpu: fix master_xcc_ids[] indexing for non-zero xcc_id
      drm/amdkfd: Use dedicated kernel memory for compute MQDs on GFX12.1
      drm/amdkfd: disable debug before retiring MES process context on teardown
      Revert "drm/amdgpu: Set default xnack mode for gfx_v12.1 A0/B0"
      drm/amd: force remote MTYPE_NC on GFX12.1 mtype_local=0
      drm/amdgpu: log remote memory MTYPE for GC 12.1.0

Alvin Lee (11):
      drm/amd/display: Update dcn60 clkmgr interfaces
      drm/amd/display: Apply workaround to limit SopCount for now
      drm/amd/display: Disable alt-ch until dependencies are ready
      drm/amd/display: Add hook to disable alt-ch in PMO
      drm/amd/display: Update alt-ch size calculations
      drm/amd/display: Fix DPP PRE_GAM register offset on DCN60
      drm/amd/display: Ensure requested LSDMA BW is within the SOP bound
      drm/amd/display: Add override for LSDMA BW in QoS table
      drm/amd/display: Add override capability for UTM table params
      drm/amd/display: Enable FW locality check in DCN6
      drm/amd/display: Dump clock registers in HW init instead of SW init

Amber Lin (3):
      drm/amdgpu: Fix reset_hw_queue on MES 12.1
      drm/amdgpu: Set queue reset method for GC 12.1
      drm/amdgpu: Update queue reset support version

Amin Gattout (1):
      drm/amdgpu: Replace deprecated strcpy with strscpy

Arunpravin Paneer Selvam (1):
      drm/amdgpu: skip the VMID 0 flush for VRAM

Asad Kamal (3):
      drm/amd/pm: add 5s custom timeout for unload messages
      drm/amd/amdgpu: Add soc_v1_0 reset handler
      drm/amd/amdgpu: Allow reset init for smu_v15_0_8

Austin Zheng (15):
      drm/amd/display: Make Struct In DCN42 SOC BB Header Static
      drm/amd/display: Refactor Per-DPM Derate Logic
      drm/amd/display: Update Derates And Set Default Per-DPM Derates
      drm/amd/display: Unify CalculateFlipSchedule Logic
      drm/amd/display: Update soc_and_ip_translator To Use Updated Per-DPM Derate Organization
      drm/amd/display: Fix CalculateFlipSchedule Calculation
      drm/amd/display: Preparations To Move DML Wrapper Out Of DML
      drm/amd/display: Clean up Per-DPM Struct
      drm/amd/display: Fix Order Of Operation In Calculate Flip Schedule
      drm/amd/display: Remove const Qualifier From Non-Pointer Fields
      drm/amd/display: Move DML Wrapper into its own Component
      drm/amd/display: Set DISPCLK per surface in DML
      drm/amd/display: Update Urgent Burst Calculation To Account For Unbounded Requests
      Revert "drm/amd/display: Unify CalculateFlipSchedule Logic"
      drm/amd/display: Update DML fields used for mode support

Bhawanpreet Lakha (32):
      drm/amd/display: Cover crtc duplicate_state stream and null guard
      drm/amd/display: Cover crtc destroy callback
      drm/amd/display: Add reset_state existing-state branch test
      drm/amd/display: Add amdgpu_dm_crtc_late_register test
      drm/amd/display: Add amdgpu_dm_crtc_init tests
      drm/amd/display: Add KUnit tests for amdgpu_dm_crtc_helper_atomic_check
      drm/amd/display: Cover MST path in encoder atomic_check
      drm/amd/display: Cover amdgpu_dm_encoder_init
      drm/amd/display: Cover MST-start failure in detect_mst
      drm/amd/display: Cover amdgpu_dm_update_connector_after_detect
      drm/amd/display: Cover HDMI infoframe/freesync timing paths
      drm/amd/display: Add amdgpu_dm_connector_poll KUnit tests
      drm/amd/display: Cover hide_secondary_tile_from_userspace
      drm/amd/display: Cover dm_validate_stream_and_context
      drm/amd/display: Cover amdgpu_dm_create_validate_stream_for_sink
      drm/amd/display: Cover amdgpu_dm_connector_mode_valid
      drm/amd/display: Cover mode_valid EDID mgmt path
      drm/amd/display: Cover amdgpu_dm_fill_hdr_info_packet
      drm/amd/display: Cover amdgpu_dm_connector_atomic_check
      drm/amd/display: Cover atomic_check modeset triggers
      drm/amd/display: Cover funcs_force valid EDID path
      drm/amd/display: Cover amdgpu_dm_connector_get_modes
      drm/amd/display: Cover create_eml_sink valid EDID path
      drm/amd/display: Cover amdgpu_set_panel_orientation
      drm/amd/display: Cover amdgpu_dm_prune_primary_tile_modes
      drm/amd/display: Cover add_fs_modes mode generation
      drm/amd/display: Cover add_fs_modes illegal timing skip
      drm/amd/display: Cover hdmi_frl_status_polling_work
      drm/amd/display: Cover amdgpu_dm_i2c_xfer
      drm/amd/display: Cover amdgpu_dm_create_i2c
      drm/amd/display: Cover dm_restore_drm_connector_state
      drm/amd/display: Cover EDID CEA parsing helpers

Bokun Zhang (2):
      drm/amdgpu: Add VCN v5.0.2 SRIOV code path
      drm/amdgpu: Add JPEG v5.0.2 SRIOV code path

Boyuan Zhang (1):
      drm/amdgpu/jpeg: fix jpeg_v5_0_2_is_idle detection

Candice Li (8):
      drm/amdgpu: factor PSP v1.0 firmware bin descriptor parsing
      drm/amdgpu: load standalone RL firmware on psp v15_0_8
      drm/amdgpu: load TA firmware for psp v15_0_8
      drm/amdgpu: update UMC active_mask to u64
      drm/amdgpu: add ext_umc_mask to RAS TA init
      drm/amd/ras: add ext_umc_mask to RAS TA init
      drm/amdgpu: declare MEC_1 and RLC firmware in gfx_v12_1
      drm/amdgpu: enable RAS on psp v15_0_8

Charlene Liu (3):
      drm/amd/display: fix HPD program filter programming
      drm/amd/display: add a NULL pointer check
      drm/amd/display: Make sure streamclk gating is off when enabling streamclk

Chenyu Chen (1):
      drm/amd/display: Add CACP ACE curve area debugfs for IGT validation

Christian König (2):
      drm/amdgpu: start to move VM internals into amdgpu_vm_internal.h
      drm/amdgpu: remove unecessary parameters from trace_amdgpu_vm_update_ptes

Colin Ian King (1):
      drm/amd/display: Fix spelling mistake "optmization" -> "optimization"

David Rosca (2):
      drm/amdgpu/userq: Add syncobj_points to signal ioctl
      drm/amdgpu: Bump version for userq timeline syncobj fixes

Dillon Varone (8):
      drm/amd/display: Add support for overriding UTM client QC profile
      drm/amd/display: Rename carried dce clock manager functions for dcn10
      drm/amd/display: Fix mismatch number of OPP/DPP accounting
      drm/amd/display: Populate vblank_nom according to bounding box
      drm/amd/display: Guard DAL port idle optimizations by ASIC rev
      drm/amd/display: Re-enable multi-dwb support
      drm/amd/display: Change RBBMIF timeout control conditions
      drm/amd/display: Add immediate restore to FAMS2 for DRR

Dr. David Alan Gilbert (4):
      drm/amdgpu: Remove is_idle test case
      drm/amdgpu: Remove is_idle (trivial cases)
      drm/amdgpu: Remove is_idle (non trivial functions)
      drm/amdgpu: Remove is_idle

Eric Huang (5):
      drm/amdgpu: add new mes misc api for gfx11
      drm/amdkfd: workaround 100% gpu usage issue for gfx11
      drm/amdgpu/userq: create the same workaround of oversubscription timer
      drm/amdgpu: correct oversubscription timer interval for gfx11
      drm/amdgpu: fix oversubscription timer for sr-iov

Fangzhi Zuo (10):
      drm/amd/display: Force FreeSync range minimum on quirky panels
      drm/amd/display: restore FRL cap on non-destructive HDMI link verify
      drm/amd/display: Add HDMI 2.1 FreeSync support for AMD VSDB
      drm/amd/display: Add HDMI 2.1 VRR support for HF-VSDB
      drm/amd/display: Enable HDMI ALLM for Gaming-VRR
      drm/amd/display: Enable HDMI FRL by default
      drm/amd/display: Emit VTEM for HF-VSDB VRR on TMDS links
      drm/amd/display: Exit IPS before connector detection on resume
      drm/amd/display: Fix HF-VSDB DSC bpc detection to be cumulative
      drm/amd/display: Fix NULL deref of new_stream->sink in VTEM guard

Feifei Xu (12):
      drm/amdgpu: Disable SDMA Hang WatchDog in SDMA_v7_1
      drm/amdgpu: add amdgpu_discovery_log_bad_signature helper
      drm/amdgpu: add MEM_RESERVED_INFO to discovery table
      drm/amdgpu: Add NPS_INFO case to amdgpu_discovery_table_check
      drm/amdgpu: add amdgpu_discovery_get_mem_reserved_info_table
      drm/amdgpu: add amdgpu_discovery_get_mem_reserved_region_by_id
      drm/amdgpu: add get_fw_reserved_info implementation
      drm/amdgpu: set reserve_tmr in amdgpu_discovery_get_tmr_info
      drm/amdgpu: query the reserved info with get_fw_reserved_info
      drm/amdgpu: add amdgpu_discovery_dump_mem_reserved_info_table
      drm/amdgpu: add mem_reserved_info sysfs attribute
      drm/amdgpu/discovery: skip MEM_RESERVED_INFO on unsupported ASICs

Felix Kuehling (18):
      drm/amdgpu: Make extra space in psp->cmd_buf_bo usable
      drm/amdgpu: Add sysfs API for UALink information
      drm/amdgpu: Add sysfs API for UALink physical pod setup
      drm/amdgpu: Add sysfs API for UALink virtual pod config
      drm/amdgpu: Add sysfs API for UALink station configuration
      drm/amdgpu: Implement PSP cmd UAL_GET_CONFIG
      drm/amdgpu: Query initial UALink config from PSP
      drm/amdgpu: Implement PSP cmd UAL_SET_PPOD_CONFIG
      drm/amdgpu: Set physical pod configuration to PSP
      drm/amdgpu: Implement PSP cmd UAL_SET_VPOD_CONFIG
      drm/amdgpu: Set virtual pod configuration to PSP
      drm/amdgpu: Implement PSP cmd UAL_SET_STATION_CONFIG
      drm/amdgpu: Set UALink station config to PSP
      drm/amdgpu: Implement PSP cmd UAL_SET_NPA_CONFIG
      drm/amdgpu: Enable/disable NPA address translation using PSP
      drm/amdgpu: Prevent double-free of drm_exec
      drm/amdgpu: Pin page tables in NPA VMs
      drm/amdgpu: Initialize NPA PT/PDs to noretry

Gabe Teeger (3):
      drm/amd/display: clamp force_min_dcfclk to dcn42b range
      drm/amd/display: Enable min dispclk ODM on DCN42
      drm/amd/display: Force min DCFCLK on AC for DCN42B

Gaghik Khachatrian (2):
      drm/amd/display: gate DCE ASIC code behind CONFIG_DRM_AMD_DC_DCE
      drm/amd/display: Add passthrough visual confirm

Gangliang Xie (1):
      drm/amdgpu: add handler for nHT error

Hansen Dsouza (1):
      drm/amd/display: Add debug bit for force p2cpm

Hari Mishal (1):
      drm/amd/display: fix division by zero in get_estimated_bw()

Harish Kasiviswanathan (3):
      drm/amdkfd: Don't use DEVICE_COHERENT on GFX12.1
      drm/amdgpu: Add helper function to check psp xgmi ta
      drm/amdgpu: Add ual_config_state to ual_get_config

Harry VanZyllDeJong (1):
      drm/amd/display: eDP panel polarity control and test support

Harry Wentland (1):
      dm/amdgpu: fix malformed link_settings debugfs output

Hawking Zhang (12):
      drm/amd/display: use GNU make rwildcard instead of find
      drm/amdgpu: Init partition_mode and xcc_mask for GFX_IMU_PARTITION_SWITCH
      drm/amdgpu/gfxhub_v12_1: Remove obsolete programming
      drm/amdgpu/mmhub_v4_2: Remove obsolete programming
      drm/amdgpu: Add gc_info_v1_5 table for soc_v1_0
      drm/amdgpu: Use max SA WGP count for GC info v1.5 CU config
      drm/amdgpu: Use discovered mmhub inst_mask for v4_2_0
      drm/amdgpu: Use mmhub inst_mask for gmc v12_1 vmhub setup
      drm/amdgpu: Use global addr for mmhub v4_2 reg access
      drm/amdgpu: Report vm fault status HI32 when avaialble
      drm/amdgpu: Enable translate further for gc v12_1 v3
      drm/amdgpu: Init mcm_addr look up table

Horatio Zhang (3):
      drm/amdgpu: Init soc_v1_0 rev_id from IP discovery die_id
      drm/amdgpu: skip IMU microcode request for GC 12.1
      drm/amdkfd: allow 255 queues per process on GFX 12.1.0

Ilya Bakoulin (2):
      drm/amd/display: Clear HUBPREQ_DEBUG_DB on DCN6
      drm/amd/display: Fix missing APG regs for DCN60 HDMI

Ivan Lipski (3):
      drm/amd/display: Refactor hdmi_frl_status_polling_work for Kunit testing
      drm/amd/display: Guard amdgpu_dm_irq_schedule_work against NULL irq_wq
      drm/amd/display: Fix DCN5/6 DML2 compilation warnings

James Lin (2):
      drm/amd/display: Fall back to overlay cursor on dcn4x when top plane doesn't fill CRTC
      drm/amd/display: Avoid NULL hubp deref for remaining mpcc_id assignment

James Zhu (3):
      drm/amdkfd: enhance host trap process in 1st trap handler
      drm/amdkfd: add stochastic in 1st trap handler
      drm/amdkfd: enable trap ID work around

Jay Cornwall (1):
      drm/amdkfd: gfx12.1 add no-op prefetch on trap entry

Jesse Zhang (4):
      drm/amdgpu/sdma: add detect_hung_queue callback
      drm/amdgpu/sdma6: implement detect_hung_queue
      drm/amdgpu/sdma7: implement detect_hung_queue
      drm/amdgpu/userq: reset a hung SDMA user queue over MMIO

Jiahao Li (2):
      drm/amd/ras: overlap VF RAS_CMD buffer and legacy RAS telemetry memory regions
      drm/amdgpu: add new interface in guest driver for getting RAS capability when uniras enabled

Jiangshan Yi (1):
      drm/amdgpu: remove redundant NULL check in amdgpu_cs_vm_handling

Jinzhou Su (1):
      drm/amdgpu: Fix NULL pointer issue during ualink init

Joshua Aberback (1):
      drm/amd/display: Remove unnecessary includes

Jun Lei (1):
      drm/amd/display: Add opt-out for DCN6 OutstandingRequests mode-support check

Kanala Ramalingeswara Reddy (1):
      drm/amdgpu: Skip accessing psp rum time db for APUs

Karthi Kandasamy (1):
      drm/amd/display: Skip eDP teardown while forced PSR is active

Kevin Wang (2):
      drm/amd/pm: fix gpu metrics energy accumulator for smu 13.0.0/13.0.7
      drm/amd/pm: report energy accumulator for smu 13.0.0

Klara Modin (1):
      rust/drm/gem: initialize callbacks with ..pin_init::zeroed()

Le Ma (10):
      drm/amdgpu: skip xgmi operations for non-xgmi multi-node configs
      drm/amdgpu: disable GFX clockgating for GC 12.1.0
      drm/amdgpu: add get_rom_offset callback for NBIO 6.3.2
      drm/amdgpu: handle MMHUB harvest information from ip discovery
      drm/amdgpu: handle LSDMA instance and harvest information from ip discovery
      drm/amdgpu: init NPS supported modes for GC 12.1.0
      drm/amdgpu: add memory partition sysfs init/fini for GC 12.1.0
      drm/amdgpu: free memory partition info on gmc v12 sw_fini
      drm/amdgpu: add NPS2 memory cap for soc v1.0 DPX mode
      drm/amdgpu: extend PSP command polling sleep range

Lijo Lazar (24):
      drm/amdgpu: Use partition switch shadow register
      drm/amdgpu: Add workaround to enable GCv12.1 MGCG
      drm/amdgpu: Use 100M as refclock for SOCv1.0
      drm/amdgpu: Add psp interrupt handling
      drm/amdgpu: Add PSP v15.0.8 interrupt handler
      drm/amdgpu: Skip showing available NPS modes
      drm/amd/pm: Implement notify_ac_dc callback for swsmu
      drm/amdgpu: Remove gfxoff calls in GC v12.1
      drm/amdgpu: Add psp ualink command interfaces
      drm/amdgpu: Fetch asp ualink interface version
      drm/amdgpu: Separate out ualink init sequences
      drm/amdgpu: Add ualink as separate ip block
      drm/admgpu: Seggregate ualink nht messaging
      drm/amdgpu: Assign accel state based on ASP config
      drm/amdgpu: Drop duplicate vpod check functions
      drm/amdgpu: Add support to send ASP completion
      drm/amdgpu: Add handlers for ualink notifications
      drm/amdgpu: Improve ualink state transitions
      drm/amdgpu: Use uniform logic for inband/sideband
      drm/amdgpu: Add name for ualink ip block
      drm/amdgpu: Move ualink ip version related changes
      drm/amdgpu: Add hw_fini for ualink
      drm/amdgpu: Expose ualink info under each xcp
      drm/amd/pm: Separate PPT limit restore from smu_set_ac_dc

Likun Gao (7):
      drm/amdgpu: add sdma debug parameter
      drm/amdgpu: Correct GFX_IMU_PARTITION_SWITCH value for gc 12_1
      drm/amdgpu: remove retired cp cmd pkg for gc v12_1
      drm/amdgpu: clean up vm flush func for gc v12_1
      drm/amdgpu: update mcm_addr_lut data for imu v12_1
      drm/amdgpu: update mcm_addr_lut data for imu v12_1
      drm/amdgpu: correct mcm_addr_lut value for gc v12_1

Linlin Yang (1):
      drm/amd/display: fix misspelling of "overridden"

Mangesh Gadre (3):
      drm/amdgpu: Updated compute partition validation
      drm/amdgpu: add DPX mode for 6-XCC configuration
      drm/amdgpu: skip DPX mode for unsupported GC parts

Mario Limonciello (2):
      drm/amdgpu: restrict BAR0 fallback read to SR-IOV VFs only
      drm/amdkfd: fix scope of mqd_mgr dereference in pqm_debugfs_mqds

Meera Patel (1):
      drm/amd/display: Fix DPREFCLK override when SMU isn't present or ready for DCN315

Melissa Wen (2):
      drm/amd/display: use halving distribution for all encode-to-linear curves
      drm/amd/display: use translate_curve_to_degamma_hw_format on DCN30

Michel Dänzer (1):
      drm/amd/display: Consult MCCS FreeSync cap only if requested & supported

Mukul Joshi (52):
      drm/amdkfd: Update SDMA engines reporting for GFX 12.1
      drm/amdgpu: Unmap KIQ during driver unload on GFX 12.1
      drm/amdkfd: set CP_IQ_WAIT_TIME2.QUE_SLEEP on GFX 12.1
      drm/amdkfd: Skip pairwise CU mask check for GFX12.1
      drm/amdgpu: Update no-retry PTE flags for GFX12
      drm/amdgpu: Drop BUG_ON in PDE address verification for GFX 12.1
      drm/amdgpu: Add UALink manager core infrastructure
      drm/amdgpu: Add a new NPA Address space
      drm/amdgpu: Add address allocator for NPA addresses
      drm/amdgpu: Initialize VM for NPA addr management
      drm/amdgpu: Rework VMID reservation logic
      drm/amdgpu: Reserve VMID for NPA VM
      drm/amdgpu: Use reserved VMID for NPA VM
      drm/amdgpu: Enable UALink Manager when pod becomes active
      drm/amdgpu: Create a drm client for UALink NPA BOs
      drm/amdgpu: Control NPA DMA-buf importing
      drm/amdgpu: Add ualink handle to BOs
      drm/amdgpu: Implement UALink handle export
      drm/amdgpu: Add connection state management
      drm/amdgpu: Implement UALink handle import ioctl
      drm/amdgpu: Implement mechanism to revoke exported memory
      drm/amdgpu: lock UALink import invalidation via drm_exec
      drm/amdgpu: Cleanup exported UALink handles
      drm/amdgpu: Cleanup imported UALink handles
      drm/amdgpu: Handle connection reset
      drm/amdgpu: Setup PTE mappings for NPA addresses
      drm/amdgpu: Add handling for remote interrupts
      drm/amdgpu: Send TLB shootdown on exported memory unmap
      drm/amdgpu: Handle local GPUs in UALink import
      drm/amdgpu: Add debugfs to drop UALink protocol messages
      drm/amdgpu: Temporarily disable sending remote TLB shootdowns
      drm/amdgpu: Temporarily Flush TLB on NPA mapping always
      drm/amdgpu: fix NPA-RELEASE race in UALink exporter cleanup
      drm/amdgpu: initialize UALink importer node list head
      drm/amdgpu: Fix initialization flags for UALink XAs
      drm/amdgpu: fix dma_buf leak in UALink exporter cleanup
      drm/amdgpu: Fix uninitialized fence in UALink NPA unmap
      drm/amdgpu: Use vm->last_update fence in UALink NPA unmap paths
      drm/amdgpu: always use MTYPE_UC for remote memory on GFX 12.1
      drm/amdkfd: program compute MQD coherent_aql_mtype on GFX 12.1
      drm/amdgpu: Fix GART and SDMA entity leak on vPod reconfiguration
      drm/amdgpu: Add UALink diagnostic logging for vpod commit/activation
      drm/amdgpu: Handle UALink vPod reconfiguration while ACTIVE
      drm/amdgpu: Cleanup UALink XA entries on manager stop
      drm/amdgpu: Handle concurrent UALINK handle import race
      drm/amdgpu: create UALink NPA import BO directly in the NPA domain
      drm/amdgpu: add mtype_remote module parameter
      drm/amdgpu: Honor mtype overrides for NPA remote memory
      drm/gem: Add callback for when handle count goes to 0
      drm/amdgpu: Add ioctl infra for exporting/importing UALink handles
      drm/amdgpu: Don't ignore LSDMA copy errors during remote interrupt send
      drm/amdgpu: Reset UALink connection on failed TLB-shootdown send

Nathan Chancellor (2):
      drm/amd/display: Shorten hdmi_frl_status_polling_workqueue
      drm/amd/ras: Adjust second parameter of mp1_v13_0_eeprom_send_msg()

Nevenko Stupar (1):
      drm/amd/display: Fix DC Hub reference frequency assert range

Nicholas Kazlauskas (3):
      drm/amd/display: Fix crash in DCN5/6 calcs when GPUVM enabled
      drm/amd/display: Fix HostVM init and SOCBB VM config for DCN6
      drm/amd/display: Adjust vblank_nom policy for HW SDP tranmission reqs

Ovidiu Bunea (5):
      drm/amd/display: Decide zstate_support based off Z8 global support
      drm/amd/display: Add DC_BLS command
      drm/amd/display: Notify DMU to allow DCHVM<->rIOMMU SDP port disconnection for DCN42
      drm/amd/display: Send DPM0 clock values to DMU
      drm/amd/display: Set mpc_tree_params->opp_id during OPP resource construct

Peichen Huang (2):
      drm/amd/display: add wait stream regen event
      drm/amd/display: Do not use panel_inst in pr

Perry Yuan (1):
      drm/amdkfd: don't gate userptr cleanup on the owning mm

Philip Yang (19):
      drm/amdgpu: LSDMA supports multiple threads
      drm/amdgpu: LSDMA check PIO error status
      drm/amdgpu: Fix MES wb status pointer overwriting adjacent wb slot
      drm/amdgpu: Fix GMC v12.1.0 MID1 page fault vmhub selection
      drm/amdgpu: Fix UALink vPod double-activation
      drm/amdgpu: Add UALink remote state structures and API declarations
      drm/amdgpu: Add UALink NPA address layout helpers
      drm/amdgpu: Add UALink NPA address computation for ring buffers
      drm/amdgpu: Add UALink NPA VM mapping for ring buffers
      drm/amdgpu: Add UALink SDMA scheduler entities
      drm/amdgpu: Add UALink GART helpers for NPA address access
      drm/amdgpu: Add UALink ring buffer allocation and firmware init
      drm/amdgpu: Add UALink remote command packets and SDMA dispatch
      drm/amdgpu: Add UALink firmware writeback address configuration
      drm/amdgpu: Add UALink cross-GPU TLB shootdown and remote interrupt
      drm/amdgpu: Add UALink software init, teardown, and reset
      drm/amdgpu: Add UALink IH ring and enable interrupt
      drm/amdgpu: UALink use LSDMA to send remote interrupt command
      drm/amdgpu: Increase UALink soft ring size

Prike Liang (3):
      drm/amdgpu: use underscores in TLB fence driver and timeline names
      drm/amdgpu: clean up the userq support redundant check
      drm/amdgpu: skip gfx switch_power_profile during GPU reset

Priya Hosur (1):
      drm/amdkfd: Add TLB flush after MES queue eviction/suspension

Rafal Ostrowski (1):
      drm/amd/display: Remove RMCM tetrahedral cube from dc_plane_state

Ray Wu (1):
      drm/amd/display: Align KUnit tests Makefile license header

Relja Vojvodic (2):
      drm/amd/display: Update and revert FRL LT Timeout behaviour
      drm/amd/display: Update HDMI link rate and DSC handling for DCN60

Roman Li (3):
      drm/amd/display: Set gpuvm min page size to 4K on dcn35/36
      drm/amd/display: Fix backlight control for luminance-capable OLED
      drm/amd/display: Apply debug bit for force p2cpm

Samson Tam (4):
      drm/amd/display: Move custom float structures from opp.h to custom_float.h
      drm/amd/display: Remove fixpt and custom float duplicated code
      drm/amd/display: Remove internal references
      Revert "drm/amd/display: Fix CalculateFlipSchedule Calculation"

Satyajit Roy (3):
      drm/amd/display: Propagate HDMI RGB quantization selectability
      drm/amd/display: Honor Broadcast RGB for BT.2020 RGB output
      drm/amd/display: Rebuild InfoFrames on output color space changes

Shaoyun Liu (1):
      drm/amdgpu: move tlb invalidation to mes sched pipe

Shiwu Zhang (4):
      drm/amdgpu: retire rb settings from gfx v12.1.0
      drm/amdgpu: retire tcc info and tcp harvest from gfx v12.1.0
      drm/amdgpu: retire get_gb_add_config for gfx_v12_1_0
      drm/amdgpu: add mec FW support for silicon rev 0

Shubhankar Milind Sardeshpande (4):
      Revert "drm/amdgpu: add support for NBIO IP version 7.11.5"
      drm/amdgpu: Add NBIO 7.11.5 header files
      drm/amdgpu: Add NBIO 7.11.5 support
      drm/amd/pm: compute SMU v15.0.0 gpu_metrics from accumulator table

Sonny Jiang (13):
      drm/amdgpu: Config VCN instance for soc_v1_0"
      drm/amdgpu: Config JPEG instance for soc_v1_0
      drm/amdgpu: correct VCN V5_0_2 doorbell range_size
      drm/amdgpu: Correct VCN V5_0_2 doorbell index setting
      drm/amdgpu: VCN 5_0_2 add support for multi-instance
      drm/amdgpu: VCN 5_0_2 disable VCN_RRMT
      drm/amdgpu: VCN 5_0_2 enable multi-instance
      drm/amdgpu: JPEG 5_0_2 Add multi-instance interrupt support
      drm/amdgpu: VCN 5_0_2 correct process interrupt warn message
      drm/amdgpu: JPEG 5_0_2 set inst_per_aid to 2
      drm/amdgpu: Jpeg 5_0_2 enable doorbell
      drm/amdgpu: Jpeg uses shard VM invalidation engine
      drm/amdgpu: JPEG 5_0_2 enable multi-instance

Sridevi Arvindekar (2):
      drm/amd/display: Fix audio test errors
      drm/amd/display: Fixes for HPO test regressions

Srinivasan Shanmugam (1):
      drm/amd/pm: Remove unused functions in smu_v15_0

Stanley.Yang (1):
      drm/amd/ras: add supported aca blocks mapping

Sunil Khatri (11):
      drm/amdgpu/userq: use fence_val instead or rptr
      drm/amdgpu/userq: use fence_val instead or rptr
      drm/amdgpu: make amdgpu_vm_bo_lookup_mapping() take a raw address
      drm/amdgpu/userq: update the kernel docs for amdgpu_userq_fence_read_wptr
      drm/amdgpu: use AMDGPU_GPU_PAGE_SHIFT instead of PAGE_SHIFT
      drm/amdgpu: fix Idle BOs list in VM debugfs status info
      drm/amdgpu: fix byte/dword unit mismatch in coredump IB dump
      drm/amdgpu: update the fw version for gfx11 userqueues
      drm/amdgpu: update the fw version for gfx12 userqueues
      drm/amdgpu/userq: add a warning if fw does not support userqueues
      drm/amdgpu/userq: dont overwrite the error of subsequent map call

Taimur Hassan (7):
      drm/amd/display: Promote DC to 3.2.393
      drm/amd/display: [FW Promotion] Release 0.1.71.0
      drm/amd/display: Promote DC to 3.2.394
      drm/amd/display: Promote DC to 3.2.395
      drm/amd/display: Promote DC to 3.2.396
      drm/amd/display: [FW Promotion] Release 0.1.74.0
      drm/amd/display: Promote DC to 3.2.397

Tao Zhou (2):
      drm/amd/ras: set pa base and lfb size for uniras
      drm/amd/ras: do not fail hw_init on ras eeprom errors

Thadeu Lima de Souza Cascardo (1):
      Revert "drm/amdgpu: debugfs: avoid extra EOLs in amdgpu_gem_info"

Timur Kristóf (12):
      drm/amdgpu/ttm: Make buffer copy source readonly
      drm/amdgpu: Respect noretry flag for retry faults on GFX12.1
      drm/amdgpu/gfxhub: Enable retry fault interrupts in L2_PROTECTION_FAULT_CNTL2
      drm/amdgpu/ih: Don't perturb HW registers when accessing soft IH ring
      drm/amdgpu/ih6.1: Use IH_SW_RING_SIZE for soft IH ring instead of PAGE_SIZE
      drm/amdgpu/ih7.0: Use IH_SW_RING_SIZE for soft IH ring instead of PAGE_SIZE
      drm/amdgpu/gmc11: Pass cam_index to retry fault handler
      drm/amdgpu/gmc12: Pass cam_index to retry fault handler
      drm/amdgpu/gmc12: Use AMDGPU_PTE_IS_PTE flag for init_pte_flags on GFX12.0
      drm/amdgpu/vm: Use init PTE flags in amdgpu_vm_handle_fault()
      drm/amdgpu/ih6.0: Enable retry CAM on Navi 3 dGPUs
      drm/amdgpu/ih7.0: Enable retry CAM on Navi 4 dGPUs

Tom Chung (3):
      drm/amd/display: test native cursor mode on a disabled CRTC
      drm/amd/display: set base.enable in cursor mode tests
      drm/amd/display: Restore the native cursor mode early return for disabled CRTCs

Tomasz Pakuła (1):
      drm/edid: parse HDMI 2.1 gaming (ALLM/VRR) capabilities from HF-VSDB

Tomasz Siemek (8):
      drm/amd/display: Move periodic interrupt calculations to HWSS
      drm/amd/display: Refactor HUBP_WAIT_FOR_DCC_META_PROP to drop pipe_ctx
      drm/amd/display: Use mpcc_id instead of hubp instance
      drm/amd/display: Refactor DPP_SET_INPUT_TRANSFER_FUNC to drop pipe_ctx
      drm/amd/display: Split OPTC_PIPE_CONTROL_LOCK into smaller HWSS blocks
      drm/amd/display: Move cursor SDR white level calculation out of hwss executor
      drm/amd/display: Remove pipe_ctx param from MPC_VISUAL_CONFIRM
      drm/amd/display: Refactor DC_SEND_CURSOR_INFO_TO_DMU to drop pipe_ctx

Tony Qi (1):
      drm/amd/display: Add max_downscale_src_width debugfs for IGT validation

Vitaly Prosyak (1):
      drm/amdgpu: cancel hang_detect_work before taking userq_mutex

Wayne Lin (1):
      drm/amd/display: Extend DMUB wait for DIG PHY programming commands

Wenjing Liu (7):
      drm/amd/display: Fix DCN6 peak bandwidth measurement overshoot
      drm/amd/display: Guard against empty DCN6 UTM QoS table
      drm/amd/display: Add utm_support capability flag
      drm/amd/display: Add stressed peak bandwidth probe with DMA contention
      drm/amd/display: Add dml2_core_dcn6_calcs function pointer table
      drm/amd/display: Route DCN6 mode support calcs through function pointer table
      drm/amd/display: Route DCN6 mode programming calcs through function pointer table

William Palacek (1):
      drm/amdkfd: skip migration when the fault window is already in VRAM

Willian Oliveira (1):
      drm/amdgpu/gfx8: fix register_list_format leak in gfx_v8_0_init_microcode

Xiang Liu (37):
      drm/amd/ras: Rename CPER section descriptor struct
      drm/amd/ras: register mce notifier to obtain ras error info
      drm/amd/ras: Introduce BOOT CPER encoding function
      drm/amdgpu/ras: prepare ras_psp for ras_mgr-owned TA reload
      drm/amdgpu/ras: reload RAS TA from ras mgr resume
      drm/amd/ras: add PCIE_PL ACA block mapping
      drm/amd/ras: map boot log events to CPER type
      drm/amd/ras: add rascore BERT record walker
      drm/amd/ras: process cached BERT boot errors
      drm/amd/ras: add missing ras core block names
      drm/amd/ras: add BERT CPER table helpers
      drm/amd/ras: record crashdump BERT sections as boot CPER
      drm/amd/ras: move BERT boot errors to BERT sw init
      drm/amd/ras: allow waking RAS processing without an event
      drm/amd/ras: classify ACA v5 MCE status
      drm/amd/ras: preserve CPU MCE context in the log ring
      drm/amd/ras: define processor and memory CPER formats
      drm/amd/ras: generate AMD crashdump CPER records
      drm/amd/ras: generate processor CPER records
      drm/amd/ras: generate Platform Memory CPER records
      drm/amd/ras: collect CPU MCE metadata
      drm/amd/ras: parse and route BERT sections
      drm/amd/ras: assign BERT platform record ownership
      drm/amd/ras: fix CPER command record retrieval
      drm/amd/ras: request GFX RAS features through ras_mgr
      drm/amd/ras: use the per-ASIC reserved VRAM size for the bad page threshold
      drm/amd/ras: keep the established socket id layout on older parts
      drm/amd/ras: skip the RAS firmware reload when the block is down
      drm/amd/ras: tolerate an unsupported MCA debug mode control
      drm/amd/ras: drop the RAS module state when its sw init fails
      drm/amd/ras: tell KFD the reset came from an ECC error
      drm/amd/ras: record the fatal state on every device of the hive
      drm/amd/ras: skip poison banks read through the UE channel
      drm/amd/ras: drop the ras_ prefix from the ACA v5 file names
      drm/amd/ras: report the banks the scrubber logged
      drm/amd/ras: report how far a CPER record query got
      drm/amd/ras: take a log batch id only once there is something to log

YiPeng Chai (76):
      drm/amd/ras: Add ras notification event
      drm/amd/ras: add interface to support parsing aca bank ecc info
      drm/amd/ras: Parse error type of MCE and encode CPER
      drm/amd/ras: Add interface to get ras eeprom table version
      drm/amd/ras: Add dedicated interface to obtain cper info
      drm/amd/ras: optimize mp1 dump bank interface
      drm/amd/ras: support separate logging of gfx aid and xcd errors
      drm/amd/ras: Optimize and remove redundant code
      drm/amd/ras: Supports recording data source timestamps to EEPROM
      drm/amd/ras: Improve function interface to record different types of data
      drm/amd/ras: Change variable name to avoid confusion
      drm/amd/ras: add common interface to query ras subunit version
      drm/amd/ras: Add aca parser v5_0
      drm/amd/ras: Add fifo to cache ras data from mce notification
      drm/amd/ras: Add mce ras error type
      drm/amd/ras: Handling ras mce notification event
      drm/amd/ras: Add ras ip configuration for A + A
      drm/amd/ras: Add ras_psp v15_0 for A + A
      drm/amd/ras: Add ras block id mapping
      drm/amd/ras: Support querying RAS driver capabilities
      drm/amd/ras: Add ras command to obtain ras capabilities
      drm/amd/ras: Support poison consumption handling for A + A sriov guest
      drm/amdgpu: Handle ras interrupts using unified interface
      drm/amdgpu: Support obtaining ras capabilities
      drm/amd/ras: Remove unused function interfaces
      drm/amd/ras: Isolate ras mce handler with CONFIG_X86_MCE_AMD
      drm/amd/ras: add interface to query nps mode and vram type
      drm/amd/ras: add helper to convert aca bank to eeprom record
      drm/amd/ras: ras mp1 introduces common interfaces
      drm/amd/ras: Support retrieving bad page info from mp1_v15_0
      drm/amd/ras: add interfaces to manage multiple EEPROMs
      drm/amd/ras: Refactor EEPROM parameter config to support multiple ras EEPROMs
      drm/amd/ras: Ras eeprom supports new eeprom management interfaces
      drm/amd/ras: switch to use new eeprom management interfaces
      drm/amdgpu/ras: Rework fw eeprom handling for new management interface
      drm/amd/ras: unify umc record logging paths for runtime and preload
      drm/amd/ras: add interface to obtain FW eeprom records at runtime
      drm/amd/ras: preload and handle bad pages at boot time
      drm/amd/ras: add interface to report bad page info
      drm/amd/ras: Support obtaining bad page info at boot time for ras_mp1_v15_0
      drm/amd/ras: Add gpu rma exception handling
      drm/amd/ras: use record count instead of bad page count for EEPROM threshold checking
      drm/amd/ras: remove unused code from ras eeprom
      drm/amd/ras: Add null check to prevent null pointer exception
      drm/amdgpu: Add bad page preloading and pre-reservation support
      drm/amdgpu: fix duplicate ras debugfs node creation on driver reload
      drm/amdgpu: refactor memory handling to support both external and internal allocation
      drm/amdgpu/ras: support loading RAS RL and TA firmware in RAS module
      drm/amdgpu: add switch to select firmware loading path for RAS RL and TA
      drm/amd/pm: update RAS-specific interface to support multi-parameter
      drm/amd/ras: update mp1_v13_0 to use smu ras multi-parameter interface
      drm/amd/ras: support multi-parameter communication with mp1 in ras_mp1_v15_0
      drm/amd/ras: harden error handling and fix resource/lock issues
      drm/amd/ras: fix silent error swallowing in get_record_count paths
      drm/amd/ras: add address translation interface for umc_v15_0
      drm/amd/ras: fix driver unload failure when uniras is enabled
      drm/amd/ras: use single socket per GPU device to store ACA RAS error info
      drm/amd/ras: update aca bank decoding for A + A
      drm/amd/ras: add management interface to support psp bad page address translation
      drm/amdgpu/ras: use flip-bit mask to generalize bad page address derivation
      drm/amd/ras: introduce row page address buffer alloc/free interfaces
      drm/amd/ras: limit eeprom ras table validation to init and post-write
      drm/amd/ras: resolve compiler warning for stack frame exceeding 1024 bytes
      drm/amd/ras: replace variable with function to check poison support
      drm/amd/ras: update interface to support multiple ras query methods
      drm/amd/ras: improve ras log timestamp precision
      drm/amd/ras: add module parameter for uniras
      drm/amdgpu: extend ras feature mask to 64-bit for A + A
      drm/amd/ras: refactor ras cper to simplify adding new cper events
      drm/amd/ras: fix ras cmd returning incorrect cper count
      drm/amd/ras: unify variable naming conventions
      drm/amd/ras: add interface and improve extensibility
      drm/amd/ras: populate cper aca register info for rma device
      drm/amd/ras: filter out invalid pages from extended page addresses
      drm/amd/ras: fix and improve bad page count calculation
      drm/amd/ras: increase page buffer size for A+A

Yogesh Mohan Marimuthu (1):
      drm/amdgpu/userq: fix struct drm_amdgpu_info_device padding for 32bit compile

YuBiao Wang (1):
      drm/amdgpu: recompute the dw estimate after allocating a new VM update job

Yuling Li (1):
      drm/amd/display: Fix cursor disable with horizontally split planes

 Documentation/gpu/amdgpu/index.rst                 |     1 +
 Documentation/gpu/amdgpu/ualink.rst                |    75 +
 drivers/gpu/drm/amd/amdgpu/Makefile                |     5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |    10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c            |     6 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c |     3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h |     3 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c   |    36 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c  |     3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h  |     3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |     4 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |    14 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c   |    14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |    18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |   337 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h      |    13 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c        |     5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |    31 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |     9 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h            |     4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |    15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h            |     3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c             |   124 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c            |    33 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h            |    27 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h             |     2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h            |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c             |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |    35 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h            |    11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c            |     6 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c            |     5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c           |    38 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h           |     2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |    11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c          |    20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h          |     4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c            |     6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c            |   101 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h            |    11 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h          |     3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |    14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h         |     5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |   593 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h            |    86 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |   105 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h            |     3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c     |     8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h     |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c          |     7 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h           |     3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h           |     3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h          |    12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace_points.c   |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |    70 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h            |     4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c         |  6299 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h         |   427 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c            |    46 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h            |     8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |    45 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c    |    68 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           |    39 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h           |     2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c           |     6 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |    56 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |   122 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c         |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h    |   155 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c          |    35 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c        |     6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c   |     4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c            |    38 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c            |    11 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h            |     7 +
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h        |    49 +-
 drivers/gpu/drm/amd/amdgpu/cik.c                   |     7 -
 drivers/gpu/drm/amd/amdgpu/cik_ih.c                |    12 -
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c              |    37 +-
 drivers/gpu/drm/amd/amdgpu/cz_ih.c                 |    12 -
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c             |     6 -
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c              |     6 -
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c              |     6 -
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |    44 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |    52 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             |    52 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c             |   307 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1_pkt.h         |    39 -
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c              |    26 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c              |    39 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |   161 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |   146 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c            |    28 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c            |    33 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c        |     9 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c          |     9 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c          |    41 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c           |     9 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c           |     2 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c           |     9 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c           |     9 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c           |     9 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c         |     9 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |    11 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c             |    17 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c             |    58 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c             |   175 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.h             |     2 +
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c              |     7 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c              |     7 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c              |    19 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |    13 +-
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c            |    12 -
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c               |    39 +-
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c               |    16 +-
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c               |    43 +-
 drivers/gpu/drm/amd/amdgpu/imu_v12_1.c             |    91 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c             |     1 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c             |     2 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c             |     1 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c             |     1 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c           |     1 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c           |     1 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c           |     1 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c           |     3 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h           |     8 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c           |   265 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c           |     1 -
 drivers/gpu/drm/amd/amdgpu/lsdma_v7_1.c            |    27 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c         |    59 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c             |    20 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c             |    75 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c          |   374 +-
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c             |    11 +-
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c           |   155 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c             |     2 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c           |    18 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_11_5.c          |   351 +
 drivers/gpu/drm/amd/amdgpu/nbio_v7_11_5.h          |    32 +
 drivers/gpu/drm/amd/amdgpu/nv.c                    |     6 -
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h            |   162 +
 drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c           |   146 +
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c             |    52 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c             |    52 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |    55 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c           |    55 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c             |    54 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c             |    53 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c             |    86 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c             |    86 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c             |    82 +-
 drivers/gpu/drm/amd/amdgpu/si.c                    |     6 -
 drivers/gpu/drm/amd/amdgpu/si_dma.c                |    31 +-
 drivers/gpu/drm/amd/amdgpu/si_ih.c                 |     1 -
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |     6 -
 drivers/gpu/drm/amd/amdgpu/soc21.c                 |     6 -
 drivers/gpu/drm/amd/amdgpu/soc24.c                 |     6 -
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c              |   480 +-
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.h              |     3 +
 drivers/gpu/drm/amd/amdgpu/ta_ras_if.h             |     1 +
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c              |    12 -
 drivers/gpu/drm/amd/amdgpu/ualink_v1_0.c           |   143 +
 drivers/gpu/drm/amd/amdgpu/ualink_v1_0.h           |    30 +
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c              |     8 -
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c              |     8 -
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c              |     8 -
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c              |     1 -
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c              |     1 -
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c              |     1 -
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c              |     1 -
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c              |     3 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c              |     1 -
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c              |     2 -
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c              |    16 -
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c              |    23 -
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c            |    21 -
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c            |    23 -
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c            |    23 -
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c            |    19 -
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c            |   351 +-
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c             |     7 -
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c             |     7 -
 drivers/gpu/drm/amd/amdgpu/vi.c                    |     6 -
 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h     |  1264 +-
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm |   135 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |     7 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |    99 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.h  |     1 +
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c           |    51 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c |    30 +-
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c |     3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |    44 +-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |    22 +-
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c             |    10 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |     7 +-
 drivers/gpu/drm/amd/display/Kconfig                |     9 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   343 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   138 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    |    41 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.h    |     1 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c  |   110 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h  |    28 +
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    |   138 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.h    |    17 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |    50 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h |     7 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c   |    61 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.h   |     6 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |   108 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c |    47 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h |    15 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c |    47 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |    38 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  |     8 +
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |    12 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.h    |     4 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    |    48 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h    |    12 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_services.c |    35 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   |    72 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h   |    16 +
 .../gpu/drm/amd/display/amdgpu_dm/tests/Makefile   |     4 +-
 .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     |    53 +-
 .../amdgpu_dm/tests/amdgpu_dm_colorop_test.c       |   232 +-
 .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     |  4088 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c  |   746 +
 .../amdgpu_dm/tests/amdgpu_dm_cursor_test.c        |   732 +
 .../display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c  |   578 +-
 .../amdgpu_dm/tests/amdgpu_dm_freesync_test.c      |   407 +
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c       |   883 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_irq_test.c   |  1230 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_ism_test.c   |   367 +-
 .../amdgpu_dm/tests/amdgpu_dm_mst_types_test.c     |   741 +
 .../display/amdgpu_dm/tests/amdgpu_dm_plane_test.c |   703 +-
 .../amdgpu_dm/tests/amdgpu_dm_services_test.c      |   228 +-
 .../amd/display/amdgpu_dm/tests/amdgpu_dm_test.c   |  4224 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_wb_test.c    |   330 +
 drivers/gpu/drm/amd/display/dc/Makefile            |     1 +
 .../drm/amd/display/dc/bios/command_table_helper.c |     7 +-
 .../amd/display/dc/bios/command_table_helper2.c    |     2 +
 drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile    |     8 +
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c   |     4 +
 .../amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c |    12 +-
 .../amd/display/dc/clk_mgr/dcn10/dcn10_clk_mgr.c   |   181 +
 .../amd/display/dc/clk_mgr/dcn10/dcn10_clk_mgr.h   |    29 +
 .../drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c |     9 +-
 .../drm/amd/display/dc/clk_mgr/dcn10/rv2_clk_mgr.c |     6 +-
 .../amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c   |    12 +-
 .../amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c |     6 +-
 .../drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c  |     5 +-
 .../amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c   |     8 +-
 .../drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c |     8 +-
 .../amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c   |    10 +-
 .../amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c |    10 +-
 .../amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c |    14 +-
 .../amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c |    10 +-
 .../amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c   |    18 +-
 .../amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c   |    12 +-
 .../amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c |    18 +-
 .../amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c   |    26 +-
 .../amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h   |     5 +
 .../amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c |    51 +-
 .../gpu/drm/amd/display/dc/clk_mgr/dcn60/dalsmc.h  |   344 +-
 .../amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c   |   337 +-
 .../amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.h   |    17 +-
 .../dc/clk_mgr/dcn60/dcn60_clk_mgr_smu_msg.c       |   220 +-
 .../dc/clk_mgr/dcn60/dcn60_clk_mgr_smu_msg.h       |   167 +-
 .../display/dc/clk_mgr/dcn60/dcn60_smu_driver_if.h |    78 +
 drivers/gpu/drm/amd/display/dc/core/dc.c           |    36 +-
 drivers/gpu/drm/amd/display/dc/core/dc_debug.c     |     2 +
 .../gpu/drm/amd/display/dc/core/dc_hw_sequencer.c  |   488 +-
 .../gpu/drm/amd/display/dc/core/dc_link_exports.c  |    25 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |    99 +-
 drivers/gpu/drm/amd/display/dc/core/dc_state.c     |     4 +-
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |    21 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |    18 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c       |   117 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h       |    46 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h       |    18 +-
 drivers/gpu/drm/amd/display/dc/dc_probe.h          |     1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h          |     4 +-
 .../gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c |     1 +
 .../gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c |    14 +-
 .../gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.h |     2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c       |    12 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c |    42 +-
 .../amd/display/dc/dio/dcn10/dcn10_link_encoder.c  |    10 +-
 .../display/dc/dio/dcn42/dcn42_dio_link_encoder.c  |     4 +-
 .../gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.c   |     1 -
 .../gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c   |    18 +-
 .../amd/display/dc/dml/dcn30/display_mode_vba_30.c |     2 +-
 .../amd/display/dc/dml/dcn31/display_mode_vba_31.c |     2 +-
 .../gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c  |     8 +-
 .../gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c   |     1 -
 drivers/gpu/drm/amd/display/dc/dml2_0/Makefile     |    17 +-
 .../amd/display/dc/dml2_0/dml21/dml21_wrapper.h    |   106 -
 .../dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h |    39 +-
 .../dml21/inc/bounding_boxes/dcn42b_soc_bb.h       |    35 +-
 .../dml2_0/dml21/inc/bounding_boxes/dcn4_soc_bb.h  |    25 +-
 .../dml2_0/dml21/inc/bounding_boxes/dcn6_soc_bb.h  |    12 +
 .../dc/dml2_0/dml21/inc/dml_top_dchub_registers.h  |     1 +
 .../dml2_0/dml21/inc/dml_top_display_cfg_types.h   |     1 +
 .../dml2_0/dml21/inc/dml_top_soc_parameter_types.h |    28 +-
 .../display/dc/dml2_0/dml21/inc/dml_top_types.h    |    14 +
 .../dc/dml2_0/dml21/src/dml2_cga/dml2_cga_dcn6.c   |     4 +-
 .../dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c |     4 +
 .../dml21/src/dml2_core/dml2_core_dcn4_calcs.c     |    72 +-
 .../dml21/src/dml2_core/dml2_core_dcn4_calcs.h     |     1 +
 .../src/dml2_core/dml2_core_dcn5_calcs_dchub.c     |    18 +-
 .../src/dml2_core/dml2_core_dcn5_calcs_dchub.h     |    23 +
 .../dml2_core/dml2_core_dcn5_calcs_display_pipe.c  |     2 +-
 .../dml2_core/dml2_core_dcn5_funcs_initialize.c    |     2 +-
 .../dml2_core_dcn5_funcs_mode_programming.c        |     8 +-
 .../dml2_core/dml2_core_dcn5_funcs_mode_support.c  |    32 +-
 .../dml21/src/dml2_core/dml2_core_dcn6_calcs.c     |    63 +-
 .../dml21/src/dml2_core/dml2_core_dcn6_calcs.h     |   468 +
 .../src/dml2_core/dml2_core_dcn6_calcs_dchub.c     |    86 +-
 .../dml2_core/dml2_core_dcn6_funcs_initialize.c    |     4 +
 .../dml2_core_dcn6_funcs_mode_programming.c        |    52 +-
 .../dml2_core_dcn6_funcs_mode_programming.h        |    31 +
 .../dml2_core/dml2_core_dcn6_funcs_mode_support.c  |   350 +-
 .../dml2_core/dml2_core_dcn6_funcs_mode_support.h  |   324 +
 .../dml21/src/dml2_core/dml2_core_shared_types.h   |    12 +-
 .../dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c |   106 +-
 .../src/dml2_pmo/dml2_pmo_dcn6_stage_optimizers.c  |     2 +-
 .../dc/dml2_0/dml21/src/dml2_top/dml2_top_utm.c    |     2 +-
 .../src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c     |    13 +
 .../dml21/src/inc/dml2_internal_shared_types.h     |    19 +
 .../gpu/drm/amd/display/dc/dml2_wrapper/Makefile   |    61 +
 .../dml21_wrapper}/dml21_translation_helper.c      |    45 +-
 .../dml21_wrapper}/dml21_translation_helper.h      |     7 +-
 .../dml21_wrapper}/dml21_utils.c                   |    24 +-
 .../dml21_wrapper}/dml21_utils.h                   |     7 +-
 .../dml21_wrapper}/dml21_wrapper.c                 |     2 +-
 .../dc/dml2_wrapper/dml21_wrapper/dml21_wrapper.h  |   107 +
 .../dml21_wrapper}/dml21_wrapper_fpu.c             |    19 +-
 .../dml21_wrapper}/dml21_wrapper_fpu.h             |     7 +-
 .../dml2_dc_resource_mgmt.c                        |    60 +-
 .../dml2_dc_resource_mgmt.h                        |     0
 .../dc/{dml2_0 => dml2_wrapper}/dml2_dc_types.h    |     0
 .../{dml2_0 => dml2_wrapper}/dml2_internal_types.h |     2 +-
 .../{dml2_0 => dml2_wrapper}/dml2_mall_phantom.c   |    70 +-
 .../{dml2_0 => dml2_wrapper}/dml2_mall_phantom.h   |     0
 .../dc/{dml2_0 => dml2_wrapper}/dml2_policy.c      |     2 +-
 .../dc/{dml2_0 => dml2_wrapper}/dml2_policy.h      |     0
 .../dml2_translation_helper.c                      |    21 +-
 .../dml2_translation_helper.h                      |     0
 .../dc/{dml2_0 => dml2_wrapper}/dml2_utils.c       |    28 +-
 .../dc/{dml2_0 => dml2_wrapper}/dml2_utils.h       |     0
 .../dc/{dml2_0 => dml2_wrapper}/dml2_wrapper.c     |     6 +-
 .../dc/{dml2_0 => dml2_wrapper}/dml2_wrapper.h     |     0
 .../dc/{dml2_0 => dml2_wrapper}/dml2_wrapper_fpu.c |    45 +-
 .../dc/{dml2_0 => dml2_wrapper}/dml2_wrapper_fpu.h |     0
 .../gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.h   |    11 +-
 .../gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.h   |     7 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c        |     8 +
 .../gpu/drm/amd/display/dc/dsc/dcn60/dcn60_dsc.c   |     4 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c       |     7 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c   |     4 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c |     4 +
 .../dc/hpo/dcn60/dcn60_hpo_frl_stream_encoder.c    |   131 +-
 .../drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h |    11 +-
 .../drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c |     5 +-
 .../drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c |     7 +
 .../drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c |   209 +-
 .../drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.h |    19 +-
 .../gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c |     6 +-
 .../gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.h |     2 +-
 .../gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c |     2 +-
 .../gpu/drm/amd/display/dc/hubp/dcn60/dcn60_hubp.c |     3 +
 drivers/gpu/drm/amd/display/dc/hwss/Makefile       |     6 +
 .../gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.c    |    46 +-
 .../gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.h    |    12 +-
 .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c  |    25 +-
 .../drm/amd/display/dc/hwss/dce60/dce60_hwseq.c    |     8 +-
 .../drm/amd/display/dc/hwss/dce80/dce80_hwseq.c    |     3 +-
 .../drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c    |   152 +-
 .../drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h    |    13 +-
 .../gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c |     4 +-
 .../drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c    |   237 +-
 .../drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h    |    21 +-
 .../gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c |     3 +-
 .../drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c  |    34 +-
 .../drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.h  |     5 +-
 .../drm/amd/display/dc/hwss/dcn201/dcn201_init.c   |     4 +-
 .../gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c |     3 +-
 .../drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c    |    61 +-
 .../drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h    |     8 +-
 .../gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c |     3 +-
 .../drm/amd/display/dc/hwss/dcn301/dcn301_init.c   |     3 +-
 .../gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c |     3 +-
 .../drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c  |     8 +-
 .../drm/amd/display/dc/hwss/dcn314/dcn314_init.c   |     3 +-
 .../drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c    |    71 +-
 .../drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h    |    10 +-
 .../gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c |     3 +-
 .../gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c |     3 +-
 .../drm/amd/display/dc/hwss/dcn351/dcn351_init.c   |     3 +-
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c  |   204 +-
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h  |    12 +-
 .../drm/amd/display/dc/hwss/dcn401/dcn401_init.c   |     3 +-
 .../drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c    |    49 +-
 .../drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.h    |    12 +-
 .../gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c |     3 +-
 .../drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c    |     3 +-
 .../drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c    |    50 +-
 .../gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c |     3 +-
 drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h |   114 +-
 .../drm/amd/display/dc/hwss/hw_sequencer_private.h |    21 +-
 drivers/gpu/drm/amd/display/dc/inc/core_status.h   |     2 +
 drivers/gpu/drm/amd/display/dc/inc/core_types.h    |     9 +
 drivers/gpu/drm/amd/display/dc/inc/custom_float.h  |    21 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h   |     1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h  |    10 -
 drivers/gpu/drm/amd/display/dc/inc/hw/opp.h        |    14 +-
 drivers/gpu/drm/amd/display/dc/inc/link_service.h  |     7 +-
 drivers/gpu/drm/amd/display/dc/irq/Makefile        |     2 +
 .../amd/display/dc/irq/dce110/irq_service_dce110.c |    21 -
 .../amd/display/dc/irq/dce110/irq_service_dce110.h |     9 -
 drivers/gpu/drm/amd/display/dc/irq/irq_service.c   |    28 +
 drivers/gpu/drm/amd/display/dc/irq/irq_service.h   |     9 +
 .../amd/display/dc/link/hwss/link_hwss_hpo_dp.c    |    23 +-
 .../gpu/drm/amd/display/dc/link/link_detection.c   |     4 +-
 drivers/gpu/drm/amd/display/dc/link/link_factory.c |     6 +-
 .../display/dc/link/protocols/link_dp_capability.c |     3 +-
 .../display/dc/link/protocols/link_dp_dpia_bw.c    |     5 +
 .../dc/link/protocols/link_dp_panel_replay.c       |    36 +-
 .../dc/link/protocols/link_dp_panel_replay.h       |     2 +-
 .../dc/link/protocols/link_edp_panel_control.c     |    81 +-
 .../dc/link/protocols/link_edp_panel_control.h     |     4 +
 .../amd/display/dc/link/protocols/link_hdmi_frl.c  |    32 +-
 .../gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.c   |     2 +
 drivers/gpu/drm/amd/display/dc/os_types.h          |    18 +
 drivers/gpu/drm/amd/display/dc/resource/Makefile   |     4 +
 .../display/dc/resource/dce112/dce112_resource.c   |    62 -
 .../amd/display/dc/resource/dcn32/dcn32_resource.c |     2 +-
 .../amd/display/dc/resource/dcn35/dcn35_resource.c |     2 +-
 .../display/dc/resource/dcn351/dcn351_resource.c   |     2 +-
 .../amd/display/dc/resource/dcn36/dcn36_resource.c |     2 +-
 .../display/dc/resource/dcn401/dcn401_resource.c   |     2 +-
 .../amd/display/dc/resource/dcn42/dcn42_resource.c |     6 +-
 .../display/dc/resource/dcn42b/dcn42b_resource.c   |     6 +-
 .../amd/display/dc/resource/dcn60/dcn60_resource.c |    42 +-
 .../amd/display/dc/resource/dcn60/dcn60_resource.h |     9 +-
 .../dcn401/dcn401_soc_and_ip_translator.c          |     6 +-
 .../dcn60/dcn60_soc_and_ip_translator.c            |     6 +-
 drivers/gpu/drm/amd/display/dc/sspl/Makefile       |     5 +-
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c       |   130 +-
 .../amd/display/dc/sspl/dc_spl_isharp_filters.c    |    10 +-
 .../amd/display/dc/sspl/dc_spl_scl_easf_filters.c  |    88 +-
 .../drm/amd/display/dc/sspl/dc_spl_scl_filters.c   |    24 +-
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h |    60 +-
 .../gpu/drm/amd/display/dc/sspl/spl_custom_float.c |   152 -
 .../gpu/drm/amd/display/dc/sspl/spl_custom_float.h |    29 -
 .../gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.c   |   495 -
 .../gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.h   |   526 -
 .../gpu/drm/amd/display/dc/sspl/spl_namespace.h    |    17 +
 drivers/gpu/drm/amd/display/dc/sspl/spl_os_types.h |    43 +-
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h    |    65 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c    |     2 +-
 drivers/gpu/drm/amd/display/include/dal_asic_id.h  |     5 +
 .../drm/amd/display/modules/inc/mod_info_packet.h  |     4 +
 .../gpu/drm/amd/display/modules/inc/mod_power.h    |     1 +
 .../amd/display/modules/info_packet/info_packet.c  |   109 +
 drivers/gpu/drm/amd/include/amd_shared.h           |     6 +-
 .../drm/amd/include/asic_reg/gc/gc_12_1_0_offset.h |     2 +
 .../amd/include/asic_reg/gc/gc_12_1_0_sh_mask.h    |     4 +-
 .../amd/include/asic_reg/nbio/nbio_7_11_5_offset.h | 11074 ++++
 .../include/asic_reg/nbio/nbio_7_11_5_sh_mask.h    | 63248 +++++++++++++++++++
 drivers/gpu/drm/amd/include/discovery.h            |   179 +-
 .../amd/include/ivsrcid/mpnht/irqsrcs_mpnht_15_0.h |    30 +
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h    |     3 +-
 drivers/gpu/drm/amd/include/v12_structs.h          |     2 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                |     9 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c         |     6 -
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c         |     7 -
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c   |     6 -
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |    38 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |    15 +-
 .../pm/swsmu/inc/pmfw_if/smu15_driver_if_v15_0_0.h |    46 -
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h       |     6 -
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |     8 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |     7 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |     4 +-
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c     |   166 -
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c   |   284 +-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c   |    11 +-
 drivers/gpu/drm/amd/ras/core/Makefile              |     9 +-
 drivers/gpu/drm/amd/ras/core/aca.c                 |   353 +-
 drivers/gpu/drm/amd/ras/core/aca.h                 |    44 +-
 drivers/gpu/drm/amd/ras/core/aca_v1_0.c            |    41 +-
 drivers/gpu/drm/amd/ras/core/aca_v5_0.c            |   448 +
 drivers/gpu/drm/amd/ras/core/aca_v5_0.h            |    62 +
 drivers/gpu/drm/amd/ras/core/cmd.c                 |   147 +-
 drivers/gpu/drm/amd/ras/core/cmd.h                 |    32 +-
 drivers/gpu/drm/amd/ras/core/core.c                |   313 +-
 drivers/gpu/drm/amd/ras/core/eeprom.c              |   472 +-
 drivers/gpu/drm/amd/ras/core/eeprom.h              |    27 +-
 drivers/gpu/drm/amd/ras/core/eeprom_fw.c           |   576 +-
 drivers/gpu/drm/amd/ras/core/eeprom_fw.h           |    67 +-
 drivers/gpu/drm/amd/ras/core/log_ring.c            |    56 +-
 drivers/gpu/drm/amd/ras/core/log_ring.h            |    46 +-
 drivers/gpu/drm/amd/ras/core/ras.h                 |   131 +-
 drivers/gpu/drm/amd/ras/core/ras_bert.c            |   546 +
 drivers/gpu/drm/amd/ras/core/ras_bert.h            |    33 +
 drivers/gpu/drm/amd/ras/core/ras_cper.c            |   834 +-
 drivers/gpu/drm/amd/ras/core/ras_cper.h            |   175 +-
 drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c      |   418 +
 drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.h      |   124 +
 drivers/gpu/drm/amd/ras/core/ras_gfx.c             |    10 +-
 drivers/gpu/drm/amd/ras/core/ras_mce.c             |   151 +
 drivers/gpu/drm/amd/ras/core/ras_mce.h             |    51 +
 drivers/gpu/drm/amd/ras/core/ras_mp1.c             |   150 +-
 drivers/gpu/drm/amd/ras/core/ras_mp1.h             |    52 +-
 drivers/gpu/drm/amd/ras/core/ras_mp1_v13_0.c       |    12 +-
 drivers/gpu/drm/amd/ras/core/ras_mp1_v15_0.c       |   249 +
 drivers/gpu/drm/amd/ras/core/ras_mp1_v15_0.h       |    30 +
 drivers/gpu/drm/amd/ras/core/ras_nbio.c            |     9 +-
 drivers/gpu/drm/amd/ras/core/ras_process.c         |    36 +-
 drivers/gpu/drm/amd/ras/core/ras_psp.c             |   589 +-
 drivers/gpu/drm/amd/ras/core/ras_psp.h             |   111 +-
 drivers/gpu/drm/amd/ras/core/ras_psp_v13_0.c       |    76 +
 drivers/gpu/drm/amd/ras/core/ras_psp_v15_0.c       |   133 +
 drivers/gpu/drm/amd/ras/core/ras_psp_v15_0.h       |    31 +
 drivers/gpu/drm/amd/ras/core/ras_umc.c             |   631 +-
 drivers/gpu/drm/amd/ras/core/ras_umc.h             |    52 +-
 drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c       |   143 +-
 drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.h       |     3 -
 drivers/gpu/drm/amd/ras/core/ras_umc_v15_0.c       |   220 +
 drivers/gpu/drm/amd/ras/core/ras_umc_v15_0.h       |    69 +
 drivers/gpu/drm/amd/ras/core/ta_if.h               |    35 +
 drivers/gpu/drm/amd/ras/ras_mgr/Makefile           |     5 +-
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_bert.c  |   191 +
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_bert.h  |    30 +
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c   |    38 +
 .../drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c    |   141 +-
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c   |   267 +
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.h   |    31 +
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c   |   342 +-
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h   |     8 +-
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c   |    71 +
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.h   |    30 +
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c |    21 +-
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.c   |     9 +-
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c   |   100 +-
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c  |    42 +-
 drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h          |     2 +
 drivers/gpu/drm/drm_edid.c                         |    42 +
 drivers/gpu/drm/drm_gem.c                          |     5 +-
 include/drm/drm_connector.h                        |    47 +
 include/drm/drm_gem.h                              |    11 +
 include/drm/ttm/ttm_resource.h                     |     2 +-
 include/uapi/drm/amdgpu_drm.h                      |    43 +-
 rust/kernel/drm/gem/mod.rs                         |    13 +-
 rust/kernel/drm/gem/shmem.rs                       |     5 +-
 557 files changed, 116863 insertions(+), 9853 deletions(-)
 create mode 100644 Documentation/gpu/amdgpu/ualink.rst
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v7_11_5.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v7_11_5.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/ualink_v1_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/ualink_v1_0.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/dcn10_clk_mgr.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/dcn10_clk_mgr.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_smu_driver_if.h
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_wrapper/Makefile
 rename drivers/gpu/drm/amd/display/dc/{dml2_0/dml21 => dml2_wrapper/dml21_wrapper}/dml21_translation_helper.c (96%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0/dml21 => dml2_wrapper/dml21_wrapper}/dml21_translation_helper.h (94%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0/dml21 => dml2_wrapper/dml21_wrapper}/dml21_utils.c (97%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0/dml21 => dml2_wrapper/dml21_wrapper}/dml21_utils.h (96%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0/dml21 => dml2_wrapper/dml21_wrapper}/dml21_wrapper.c (100%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_wrapper.h
 rename drivers/gpu/drm/amd/display/dc/{dml2_0/dml21 => dml2_wrapper/dml21_wrapper}/dml21_wrapper_fpu.c (96%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0/dml21 => dml2_wrapper/dml21_wrapper}/dml21_wrapper_fpu.h (95%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_dc_resource_mgmt.c (96%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_dc_resource_mgmt.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_dc_types.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_internal_types.h (99%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_mall_phantom.c (97%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_mall_phantom.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_policy.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_policy.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_translation_helper.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_translation_helper.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_utils.c (98%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_utils.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_wrapper.c (97%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_wrapper.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_wrapper_fpu.c (93%)
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 => dml2_wrapper}/dml2_wrapper_fpu.h (100%)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/sspl/spl_custom_float.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/sspl/spl_custom_float.h
 delete mode 100644 drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/sspl/spl_namespace.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_5_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_5_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/ivsrcid/mpnht/irqsrcs_mpnht_15_0.h
 create mode 100644 drivers/gpu/drm/amd/ras/core/aca_v5_0.c
 create mode 100644 drivers/gpu/drm/amd/ras/core/aca_v5_0.h
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_bert.c
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_bert.h
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.h
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_mce.c
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_mce.h
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_mp1_v15_0.c
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_mp1_v15_0.h
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_psp_v15_0.c
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_psp_v15_0.h
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_umc_v15_0.c
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_umc_v15_0.h
 create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_bert.c
 create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_bert.h
 create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c
 create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.h
 create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c
 create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.h
