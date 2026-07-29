Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC95C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 20:18:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3C3210E092;
	Wed, 29 Jul 2026 20:18:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vfZ95JUM";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013064.outbound.protection.outlook.com
 [40.93.196.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B649810E08C;
 Wed, 29 Jul 2026 20:18:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T4eodQvX2/2AAmIGinDCXtzCSqVRiawUncw4UWEuGEZQ1ELkcnHhaGDks3IZD6z+pmo54xgUfoczfdyALxQzHnoBvmFX+qxuQMuCu9ydorGv4DFbYnQ+zpH2ShpwtOteo4ZNIYlZC/cc7BeZZRXDhvaMmwQnTmwLnDz5Rr/wJKvqtzoZpTFCFsqCiRydifcg7EXXPwO8zqTyuoX5hgCisjypL92FShX7XG9LEM3CA4Ahr4RQlRSNSE+4n9BChExvJPN2LFNOE1H4ZbIYMGd6+376+wiqpPnhHnlu+AdAGT66Zw0oSarUS2KTLRIsE/5sPYLwP1WEoSx3wljdX6vewg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5n0PnUFjtAdGNfYu60/WKSuT6tm+VvJk7GUakzci0Yk=;
 b=AyIjqOKM6qoetk1k81EYgRjOvTfs2vgSXauCkksZeHb83LGrfFT1ihY7S3OcWngCjDCG5LLqDDxup4B4hagusBilNiYaqVV0CziQaB4NZIXCCIbsrwFdtP2JCS56fZnEUUoDuuMRZq22YLny6tXUKQPgesVc/poWXgmjWsBO8Y8Fai9xazGH4asC1/YW7f7TBfxoJuTx+5Npk2ENR3Hdj2PxXcog6SwLITK45wRZ50cgq+Wi8M1/z83o3YxRaEiOdbHxyPiMiM9MOpOl0+4ZkBKNdM9CdPFIMh+lhQ6YxrPJ4K9Doy2yZXaCBhQpvqikzmPAdauzSFCRkZLWua8ykA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5n0PnUFjtAdGNfYu60/WKSuT6tm+VvJk7GUakzci0Yk=;
 b=vfZ95JUM1VUmpsZHLRr4a30STs0csZ4O4jVAD3wWikhbEAeOlT++DtgNDYLoMK5GqeO25e2tmeCXJ6FFHNE/0qNAyJa68S85TBc+xlnj78RG3LfSZMXcfP+LuQ2ENAUlloKt3Fnxs/rDTeKpqmrlDHvjA4gOaMOnvAAlWPTn0SU=
Received: from CH0PR07CA0008.namprd07.prod.outlook.com (2603:10b6:610:32::13)
 by BY5PR12MB4146.namprd12.prod.outlook.com (2603:10b6:a03:20d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 20:18:13 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::59) by CH0PR07CA0008.outlook.office365.com
 (2603:10b6:610:32::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Wed,
 29 Jul 2026 20:18:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 20:18:12 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 15:18:09 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 15:18:08 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 29 Jul 2026 15:18:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd, radeon drm-next-7.3
Date: Wed, 29 Jul 2026 16:18:01 -0400
Message-ID: <20260729201801.4073097-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|BY5PR12MB4146:EE_
X-MS-Office365-Filtering-Correlation-Id: 72d5a379-4e62-42e0-247b-08deedae83a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|13003099007|6133799003|56012099006|5023799004|11063799006|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: TyL9uIHDgpHE7zgaRGJfFpPC0UURmTvVVc7AeNiqW0Z5aG3by/Twkf1ThPe38ziqV6o1oTa+vErvIXnhqePj1mqspo/h9QVvui4hWK/oe7f+AEtGzh6trxMXOuY8UqS8dTLJ0EpRgj1GFuVxOOGRYPRr6cr6cfztpwPxc2R2T4jJIaaIh7BHDSgxU8RJ/t2GHoaM0Ae+E0MPqpkCUJIlCBbD8DuM72J33JPCiXfkYsvIJ6Q4IIf6j6mDWcDrmMBAlPfDhF7nnBN2TQO5lI1VqT3cb9u4LRlzr1jBjWhZsq353lgcY3YZIcRqmwEJsKVrVUMzGa5UQmCSQP1Ywn6JzLulBRZrPr7YmlogFLix4e3RYHAxfhxgwjKQ0N4Sml9Le6HcVJWFmd4LfVYVx2U8WEuy7lp1aCkzb7AWkw7+QpMYNnTLWVVvoJ1qhU2B1H82Fleqie7txM8f03m7Jar72BNEzcG6LdmJojBmOwwEf+GGObHQ50m+0dfBrvGV5yi+x2ut7AACGSy0aOoO2GcA212D0aTyHW7nLpdOiQAzPtFhJAlDBZ9cfTn5druy17dIpcCLB0inb2SAnAsj83/4yJusORvJfKPCB0H2Pg4tuSRyPFkadUJmhy363KisR0sQty4KbadU5J2lwItO2sai7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(13003099007)(6133799003)(56012099006)(5023799004)(11063799006)(10067099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wEoB4FutBU3piHPZfDp/SCzKOxksQlAueq68kCM6he+mPLnXwivgRdhBIVDKdDLF6gLA4nsWYtasy4mCF5HwKvOoh8Zobdi2dBlqu2RuRyVnc1QWVk9WpJQ44+aRaSEjvAhN6w5aGjcJ2kdu0y7JjjepO1Ldj9rmWBzZvxdWAUFaQ6KPzSyLVLWSi7jZqnTcS6wLO6ubinVYYRnELmXvJgM2hw88Cbe/hE6ajwLkamVFvRnorbebr0tNOpoRlAVXve3jw/IDtyPz9UlFCI2zMZglog6Rz301tUpn33vYyyelaMoGupydORQjyUg/LaEVkK4Eu7jtjVKIeRcCaOsJgGONITon7X6n1SuC4Qzdc11ahW8dM1QZrOxR2e1zZduLSyNSQVAwCXyUAcopVLlPPZWB4YmKvDwPwjuT+AMF1LMk3dU2iW0rsrLldRSkBgS4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 20:18:12.1314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d5a379-4e62-42e0-247b-08deedae83a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4146
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

A few more updates for 7.3.

The following changes since commit 295a8c0b0e44760ef7e06c55beacbe0caafe1ce7:

  Merge tag 'amd-drm-next-7.3-2026-07-15' of https://gitlab.freedesktop.org/agd5f/linux into drm-next (2026-07-16 13:13:42 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-next-7.3-2026-07-29

for you to fetch changes up to 6f16fcbb0c46a87e3d9685407e906573d60104b0:

  drm/amd/display: use proper context for logging (2026-07-28 19:17:34 -0400)

----------------------------------------------------------------
amd-drm-next-7.3-2026-07-29:

amdgpu:
- VCN 5.3 fix
- UserQ fixes
- GEM close optimization
- HDMI AV mute fix
- UML build fixes
- GFXOFF residency metrics fixes
- SMU 15 fixes
- debug_vm fix
- PSP 15 fixes
- NBIO 7.11.5 fix
- pptable use after free fix
- gpu metrics fetch fix
- DC viewport fix
- DML2.1 fix
- i2c retimer spam fix
- UMD profile pstate fix
- Power metrics format cleanup
- GTT size fix on APUs
- DC context logging fix
- Misc fixes
- IB pool clean up and fixes
- DCN 4.2 updates
- Old BUG() and BUG_ON() removal
- RAS updates
- PASID management updates
- DC MCIF ARB updates
- More DC KUNIT tests
- Refactor dc_validation_set
- Introduce dc_state_get_status unified status accessor
- Apple Studio Display fixes
- DML updates
- DC writeback fixes
- MES updates
- PTL updates
- DC code restructuring
- DC FRL fixes
- Add modifiers for GFX6-8
- Resume fix for MacBookPro15,1

amdkfd:
- Various bounds checking fixes
- Mutex locking fix
- Clean up debug runlist printing
- SR-IOV fixes
- Avoid topology_lock in kfd_mmap
- Fix signal reset event
- SVM eviction fixes

radeon:
- Fix for unset CONFIG_ACPI

----------------------------------------------------------------
Alan Swanson (1):
      drm/amd/display: Silence link_dpms I2C retimer failures

Alex Deucher (20):
      drm/amdgpu: properly account for resets with user queues
      drm/amdgpu/imu11: WARN() rather than BUG()
      drm/amd/display: check if dml21_add_phantom_plane() is successful
      drm/amdgpu/imu12: WARN() rather than BUG()
      drm/amdgpu/mes11: drop all BUG()s
      drm/amdgpu/mes12: drop all BUG()s
      drm/amdgpu/mes12.1: drop all BUG()s
      drm/amdgpu/psp11: replace BUG() with an error
      drm/amdgpu/psp13: replace BUG() with an error
      drm/amdgpu/psp13.0.4: replace BUG() with an error
      drm/amdgpu/psp14: replace BUG() with an error
      drm/amdgpu/gfx6: drop all BUG()s
      drm/amdgpu/gfx7: drop all BUG()s
      drm/amdgpu/gfx8: drop all BUG()s
      drm/amdgpu/gfx9: drop all BUG()s
      drm/amdgpu/gfx9.4.3: drop all BUG()s
      drm/amdgpu/gfx10: drop all BUG()s
      drm/amdgpu/gfx11: drop all BUG()s
      drm/amdgpu/gfx12: drop all BUG()s
      drm/amdgpu/gfx12.1: drop all BUG()s

Alex Hung (45):
      drm/amd/display: add dm_dmub_hw_init KUnit coverage
      drm/amd/display: add dm_dmub_hw_resume KUnit coverage
      drm/amd/display: add fused IO KUnit coverage
      drm/amd/display: add DMUB command sync KUnit coverage
      drm/amd/display: add VBIOS bounding box KUnit test
      drm/amd/display: Test color mod init and 3D LUT size
      drm/amd/display: Test plane colorop helper walkers
      drm/amd/display: Test CRTC color management update
      drm/amd/display: Test plane color management update
      drm/amd/display: Test plane colorop pipeline update
      drm/amd/display: add KUnit tests for DM IP-block callbacks
      drm/amd/display: add KUnit tests for DM CRTC vblank/scanout
      drm/amd/display: add KUnit tests for DM atomic state helpers
      drm/amd/display: add KUnit tests for DM stream scaling
      drm/amd/display: add KUnit tests for HDCP state diffing
      drm/amd/display: add KUnit tests for freesync config
      drm/amd/display: add KUnit tests for per-frame master sync
      drm/amd/display: add KUnit tests for stutter quirk
      drm/amd/display: add KUnit tests for DPCD poweroff delay
      drm/amd/display: add CRC source list KUnit coverage
      drm/amd/display: add CRC source verify KUnit coverage
      drm/amd/display: add CRC configure KUnit coverage
      drm/amd/display: add CRC set-source KUnit coverage
      drm/amd/display: add CRC IRQ handler KUnit coverage
      drm/amd/display: Fix missing dc_3dlut forward declaration
      drm/amd/display: Flush IRQ workqueue in schedule-work tests
      drm/amdgpu: Fix __rcu fence pointer accesses
      drm/amdgpu: Pack nested ucode_info struct
      drm/amd/display: Fix writeback completion timing
      drm/amd/display: share common DM KUnit helpers
      drm/amd/display: move scaling helper to connector
      drm/amd/display: move stutter quirk to quirks file
      drm/amd/display: move watermarks table to pp_smu
      drm/amd/display: move GPU mem helpers to services
      drm/amd/display: add FreeSync/VRR module
      drm/amd/display: add cursor module
      drm/amd/display: add KUnit tests for audio component get_eld
      drm/amd/display: add KUnit tests for audio commit path
      drm/amd/display: Add KUnit test for native backlight registration
      drm/amd/display: Add color transfer-function tests
      drm/amd/display: Add atomic transfer-function tests
      drm/amd/display: Add CRTC and plane degamma tests
      drm/amd/display: Add legacy plane LUT tests
      drm/amd/display: Add truncated colorop tests
      drm/amd/display: Add colorop LUT programming tests

Alexander Chechik (2):
      drm/amd/display: enforce UCLK pstate support in mode_support
      drm/amd/display: plumb PMO per-plane pstate methods into mode_support

Amber Lin (1):
      drm/amdkfd: Fix signal reset event

Andre Eikmeyer (1):
      drm/amdgpu: reset VI ASIC on MacBookPro15,1

Aurabindo Pillai (2):
      drm/amd/display: Adjust the structure dml2_dchub_watermark_regs
      drm/amd/display: Adjust structure dml2_display_dlg_regs

Austin Zheng (1):
      drm/amd/display: Add Writeback Watermarks and Latency Fields

Bhawanpreet Lakha (24):
      drm/amd/display: Replace amdgpu_dm_kunit_helpers.h with dm_helpers.h
      drm/amd/display: Add stream creation tests for connector
      drm/amd/display: Add detect and poll tests for connector
      drm/amd/display: Add register and unregister tests for connector
      drm/amd/display: Add destroy tests for connector
      drm/amd/display: Add encoder helper tests for connector
      drm/amd/display: Add EDID management tests for connector
      drm/amd/display: Add mode helper tests for connector
      drm/amd/display: Add i2c and EDID parsing tests for connector
      drm/amd/display: Add mode validation and CEC tests for connector
      drm/amd/display: Add stream validation tests for connector
      drm/amd/display: Add KUnit tests for link_lock and psp SRM helpers
      drm/amd/display: Add KUnit tests for HDCP display helpers
      drm/amd/display: Add KUnit tests for event_callback
      drm/amd/display: Add KUnit tests for event_property_validate
      drm/amd/display: Add KUnit tests for watchdog and cpirq events
      drm/amd/display: Add KUnit tests for hdcp_destroy
      drm/amd/display: Add KUnit tests for enable_assr
      drm/amd/display: Add KUnit tests for update_config
      drm/amd/display: Add KUnit tests for hdcp_create_workqueue
      drm/amd/display: Add KUnit tests for srm_data_write and srm_data_read
      drm/amd/display: Add KUnit tests for HDCP DDC link adapters
      drm/amd/display: Add initialized-branch test for psp_set_srm
      drm/amd/display: Add deeper event_property_update tests

Bob Zhou (1):
      drm/amdgpu: skip clearing empty freed VM list on GEM close

Candice Li (1):
      drm/amdgpu: restore UMD profile pstate after runtime resume

Ce Sun (4):
      drm/amdgpu/ras: Add debug mask to disable CE logs for uniras
      drm/amd/ras: add device lost check to early exit psp cmd wait loop
      drm/amdgpu: normalize error return of RAS command wrapper functions
      drm/amdgpu: avoid resource leak on SR-IOV VF with AMDGIM_FEATURE_RAS_CPER enabled

Charlene Liu (1):
      drm/amd/display: change dcc_rate from 1 to 2 for log use only

Christian König (4):
      drm/amdgpu: give different sizes for each SA pool type
      drm/amdgpu: add gfp_flags to amdgpu_sa_manager v2
      drm/amdgpu: move job parameter to the end in amdgpu_job_alloc() and *_with_ib()
      drm/amdgpu: use correct gfp_t for job allocation

Clara Wong (1):
      drm/amd/display: Reduce DML reinitialization when params don't change

Clay King (1):
      drm/amd/display: adjust floating point format for gamut remap when needed

David Francis (1):
      drm/amdkfd: Handle invalid event type in CRIU event restore

Dillon Varone (5):
      drm/amd/display: Correct pipe usage for populating stream config
      drm/amd/display: Add MCIF ARB programming structures
      drm/amd/display: Add updated MCIF ARB register definitions
      drm/amd/display: Add DWB validation support to DML2.1 wrapper
      drm/amd/display: Port DCN4+ MCIF ARB programming to new format

Dominik Kaszewski (1):
      drm/amd/display: Split DPMS ON into parts

Fangzhi Zuo (2):
      drm/amd/display: Prune per-tile Timing from Apple Studio Display Primary Tile
      drm/amd/display: dispatch compressed FRL cap check inside dml1_frl_cap_chk_inter

Fares Soliman (1):
      drm/amdgpu: Update message IDs to PMFW to correctly gather GFXOFF residency logs

Gabe Teeger (1):
      drm/amd/display: add dcn42b specific SMU clock table read

Gang Ba (1):
      drm/amdkfd: Fix missing authorization check in KFD_IOC_DBG_TRAP_DISABLE

George Zhang (1):
      drm/amd/display: Fix divide-by-zero in calculate_mcache_setting on zero viewport

Harkirat Gill (1):
      drm/amdgpu: cap GTT size to physical RAM on APUs

Huang, Leon (1):
      drm/amd/display: Add get replay residency function

Ilya Bakoulin (1):
      drm/amd/display: Fix DP LT failure logging

Jerry Zuo (1):
      drm/amd/display: hide Apple Studio Display secondary tile

Jiri Slaby (SUSE) (1):
      drm/amd/display: use proper context for logging

John Harrison (1):
      drm/amd/display: Fix use-after-free bugs in KUnit tests

Justin Chen (2):
      drm/amd/display: Revert Fix DMSS not triggering for HDR to SDR transition
      drm/amd/display: add DalForceMaxDisplayClock debug option to DML2

Kanala Ramalingeswara Reddy (2):
      drm/amdgpu: Update driver if header for SMU V15.0.5
      drm/amdgpu: enable mode2 reset for SMU IP v15.0.5

Kent Russell (1):
      drm/amdkfd: Clean up debug runlist printing

Leo Chen (1):
      drm/amd/display: Register DCN as a PMFW DF C-state client on DCN42

Leo Li (1):
      drm/amd/display: Fix flip-done timeouts on mode1 reset

Matthew Stewart (3):
      drm/amd/display: Add DCHUBBUB_HW_DEBUG offset/mask
      drm/amd/display: Fixes for dcn42b_soc_bb.h
      drm/amd/display: Fix rounding errors in CalculatePrefetchSchedule

Nicholas Carbones (1):
      drm/amd/display: Correct vblank_end calc for fams cmd packet

Philip Yang (2):
      drm/amdkfd: Avoid topology_lock in kfd_mmap
      drm/amdkfd: Evict SVM BOs synchronously from TTM eviction

Pierre-Eric Pelloux-Prayer (1):
      drm/amdgpu: move debug_vm handling to amdgpu_cs_parser_fini

Prike Liang (1):
      drm/amd/display: Fix DML file discovery for out-of-tree builds

Ray Wu (2):
      drm/amd/display: Increase HDMI AV mute wait from 2 to 3 frames
      drm/amd/display: Add AV mute wait frames to dce110_set_avmute

Relja Vojvodic (1):
      drm/amd/display: Fix force FRL rate debug setting

Robin Chen (1):
      drm/amd/display: fix debug flags assignment in dmub_replay.c

Santhosh, Ashwin (1):
      drm/amd/display: Promote DC to 3.2.391

Shubhankar Milind Sardeshpande (2):
      drm/amdgpu: Enable support for PSP 15_0_5
      drm/amdgpu: Fix NBIO 7.11.5 offsets

Srinivasan Shanmugam (5):
      drm/amdgpu/gfx9.4.3: Fix MEC rollback loop in EOP IRQ setup
      drm/amdgpu: Allow PASID allocator to store fpriv owner
      drm/amdgpu: Resolve VM through DRM PASID ownership
      drm/amdgpu: Drop vm_manager PASID to VM mapping
      drm/amdgpu: Add missing MES helper parameter descriptions

Stanley.Yang (1):
      drm/amdgpu/ras: use vram_base_offset for UMC inject address

Sunil Khatri (1):
      drm/amdgpu: dont pin wptr bo instead use eviction fence

Suresh Guttula (1):
      drm/amdgpu : update mmhub eco sec lvl for vcn5_3

Taimur Hassan (1):
      drm/amd/display: Promote DC to 3.2.390

Tao Zhou (3):
      drm/amd/ras: send RMA event in RAS init stage
      drm/amd/ras: update flip bit setting for uniras
      drm/amd/ras: detect old ras eeprom format

Timur Kristóf (5):
      drm/fourcc: Add modifiers for AMD GFX6-8
      drm/amdgpu: Convert tiling flags to modifiers on GFX6-8
      drm/amd/display: Support DRM format modifiers on GFX6-8
      drm/amd/display: Don't use tiling flags anymore
      drm/amdgpu/ttm: Use more optimal copy packet sizes for copy and fill

Tomasz Siemek (4):
      drm/amd/display: Drop CONFIG_DRM_AMD_DC_DCN4_2 from 3dlut code
      drm/amd/display: Refactor DPP_PROGRAM_GAMUT_REMAP to drop pipe_ctx param
      drm/amd/display: Refactor DPP_SET_OUTPUT_TRANSFER_FUNC to drop pipe_ctx
      drm/amd/display: Use current mpc pipe in set output transfer func

Uwe Kleine-König (1):
      drm/radeon: Only define radeon_acpi_vfct_match when actually used

Uwe Kleine-König (The Capable Hub) (1):
      drm/amdgpu: Consistently define pci_device_ids using named initializers

Victor Zhao (3):
      drm/amdgpu: add generic interfaces for PTL requests in virtualization
      drm/amdgpu: always get PTL state from PSP under sriov
      drm/amdgpu: convert ptl_hw_supported to enum

Vladimir Marioukhine (1):
      drm/amdkfd: fix QID bit leak in pqm_create_queue()

Wayne Lin (1):
      drm/amd/display: Add SPL UPSP upsampling and YUV422 scaling support

Wenjing Liu (7):
      drm/amd/display: Introduce dc_probe public object model
      drm/amd/display: Introduce dc_update_state unified commit interface
      drm/amd/display: Refactor dc_validation_set array into single root struct
      drm/amd/display: Introduce dc_state_get_status unified status accessor
      drm/amd/display: Introduce program_perfmon hwss hook and BLS perfmon sequence
      drm/amd/display: Wire probe commit path into dc_update_state
      drm/amd/display: Make dc_state_update const in commit path

Will Aitken (1):
      drm/amdgpu: Use just sriov capability bit for xgmi ext peer link support

William Palacek (4):
      drm/amdkfd: Add bounds check for CRAT subtype length
      drm/amdkfd: fix uint32_t overflow in EOP ring buffer size alignment
      drm/amdkfd: hold event_mutex while checkpointing CRIU events
      drm/amdkfd: allow CWSR grace period of 0 on supported firmware

Yang Wang (3):
      drm/amd/pm: fix pptable use-after-free
      drm/amd/pm: fix torn gpu metrics reads
      drm/amd/pm: use milliwatts for GPU power sensors

chong li (1):
      drm/amdgpu: reduce early full GPU access during SR-IOV init

 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |   25 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c   |    5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c           |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   34 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |   13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   88 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |  177 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  641 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |    5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |    3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c             |   38 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c            |   85 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h            |    6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c            |   17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h            |    8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c           |    5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |   36 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c            |   43 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h           |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |  102 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h            |    2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h           |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c             |   18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h             |    3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |   66 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |   37 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            |    5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            |    8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |   12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           |   36 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h           |   11 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |   69 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |    6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c        |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c           |    6 +-
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h        |   29 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |   22 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |   19 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             |   17 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c             |   16 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c              |   12 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c              |    3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |    3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |   18 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c            |   34 +-
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c             |    5 +-
 drivers/gpu/drm/amd/amdgpu/imu_v12_0.c             |    5 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c           |   24 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c         |   19 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c             |   27 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c             |   15 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c             |   16 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c              |    7 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c              |   28 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h              |    2 +
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c           |  146 +-
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h            |    1 +
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c             |    4 +-
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c             |    4 +-
 drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c           |    4 +-
 drivers/gpu/drm/amd/amdgpu/psp_v14_0.c             |    4 +-
 drivers/gpu/drm/amd/amdgpu/psp_v15_0.c             |   93 +-
 drivers/gpu/drm/amd/amdgpu/soc21.c                 |    1 +
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c              |   10 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c              |   10 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c            |   26 +
 drivers/gpu/drm/amd/amdgpu/vi.c                    |   20 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |   29 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c              |    9 +
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |   19 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.c            |   40 +-
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c           |    4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c    |   16 +-
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c |   70 +-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |    2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c             |    2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |   88 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h               |   10 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/Makefile     |    4 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 1045 +---------
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   50 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c    |    3 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    |    2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c    |   52 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.h    |   26 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c  |    2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    |  217 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.h    |   45 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c  |    7 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |   15 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c   |  443 +++++
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.h   |   52 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c |   11 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h |    9 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c |  362 ++++
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.h |   65 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c |  100 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h |   37 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |   12 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  |   35 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c  |    2 +-
 .../display/amdgpu_dm/amdgpu_dm_kunit_helpers.h    |   20 -
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |    1 -
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    |  345 +++-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h    |    7 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c   |   54 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.h   |    3 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c  |    2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c   |   34 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c   |    2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_services.c |   55 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   |    2 +-
 .../gpu/drm/amd/display/amdgpu_dm/tests/Makefile   |    2 +
 .../display/amdgpu_dm/tests/amdgpu_dm_audio_test.c |  651 ++++++
 .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     |   61 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_color_test.c | 1401 +++++++++++++
 .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     | 1787 ++++++++++++++++-
 .../display/amdgpu_dm/tests/amdgpu_dm_crc_test.c   |  728 +++++++
 .../display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c  |   30 +-
 .../amdgpu_dm/tests/amdgpu_dm_cursor_test.c        |  268 +++
 .../display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c  |  837 ++++++++
 .../amdgpu_dm/tests/amdgpu_dm_freesync_test.c      |  453 +++++
 .../display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c  | 2063 +++++++++++++++++++-
 .../display/amdgpu_dm/tests/amdgpu_dm_irq_test.c   |   63 +-
 .../amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c      |   42 +-
 .../amdgpu_dm/tests/amdgpu_dm_kunit_test_helpers.h |    4 +
 .../display/amdgpu_dm/tests/amdgpu_dm_plane_test.c |  149 +-
 .../amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c        |   20 +
 .../display/amdgpu_dm/tests/amdgpu_dm_psr_test.c   |   15 +-
 .../amdgpu_dm/tests/amdgpu_dm_quirks_test.c        |   65 +
 .../amd/display/amdgpu_dm/tests/amdgpu_dm_test.c   | 1031 ++++++----
 .../display/amdgpu_dm/tests/amdgpu_dm_wb_test.c    |    5 +-
 drivers/gpu/drm/amd/display/dc/basics/conversion.c |   61 +-
 drivers/gpu/drm/amd/display/dc/basics/conversion.h |   12 +-
 .../amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c   |   28 +
 .../amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h   |    1 +
 .../drm/amd/display/dc/clk_mgr/dcn42/dcn42_smu.c   |   29 +-
 .../drm/amd/display/dc/clk_mgr/dcn42/dcn42_smu.h   |    2 +
 .../amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c |  183 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  471 +++--
 .../gpu/drm/amd/display/dc/core/dc_hw_sequencer.c  |  422 +++-
 .../gpu/drm/amd/display/dc/core/dc_link_exports.c  |    7 +
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |   98 +-
 drivers/gpu/drm/amd/display/dc/core/dc_sink.c      |    3 +
 drivers/gpu/drm/amd/display/dc/core/dc_state.c     |   72 +-
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |   28 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |  226 ++-
 drivers/gpu/drm/amd/display/dc/dc_probe.h          |   97 +
 drivers/gpu/drm/amd/display/dc/dc_state.h          |    7 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |   30 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h          |    9 +-
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |   20 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c |    4 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c   |    2 +-
 drivers/gpu/drm/amd/display/dc/dm_helpers.h        |   11 +
 .../gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c  |   10 +-
 drivers/gpu/drm/amd/display/dc/dml2_0/Makefile     |    7 +-
 .../dc/dml2_0/dml21/dml21_translation_helper.c     |   92 +-
 .../drm/amd/display/dc/dml2_0/dml21/dml21_utils.c  |   32 +-
 .../drm/amd/display/dc/dml2_0/dml21/dml21_utils.h  |    5 +
 .../display/dc/dml2_0/dml21/dml21_wrapper_fpu.c    |   32 +-
 .../dml21/inc/bounding_boxes/dcn42b_soc_bb.h       |    4 +-
 .../dc/dml2_0/dml21/inc/dml_top_dchub_registers.h  |   30 +
 .../display/dc/dml2_0/dml21/inc/dml_top_types.h    |    5 +
 .../dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c |   38 +-
 .../dml21/src/dml2_core/dml2_core_dcn4_calcs.c     |  138 +-
 .../dml21/src/dml2_core/dml2_core_dcn4_calcs.h     |    2 +
 .../dml21/src/dml2_core/dml2_core_shared_types.h   |    3 +
 .../dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c |   21 +
 .../dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.c  |   32 +-
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c       |    2 +-
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c    |    8 +-
 .../drm/amd/display/dc/dpp/dcn20/dcn20_dpp_cm.c    |    8 +-
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c    |    8 +-
 .../drm/amd/display/dc/dwb/dcn30/dcn30_dwb_cm.c    |    3 +-
 .../drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.h |    7 +-
 .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c  |   53 +-
 .../drm/amd/display/dc/hwss/dce60/dce60_hwseq.c    |    2 +-
 .../drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c    |   31 +-
 .../drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h    |    5 +-
 .../drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c    |   22 +-
 .../drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h    |    3 +-
 .../drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c    |   71 +-
 .../drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h    |    6 +-
 .../drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c    |   21 +-
 .../drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c    |   31 +-
 .../drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h    |    8 +-
 .../drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c    |    7 +-
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c  |   72 +-
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h  |    6 +-
 .../drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c    |   17 +-
 drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h |  214 +-
 .../drm/amd/display/dc/hwss/hw_sequencer_private.h |    6 +-
 drivers/gpu/drm/amd/display/dc/inc/core_status.h   |   10 +
 drivers/gpu/drm/amd/display/dc/inc/core_types.h    |   53 +
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h    |   10 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h   |   18 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/mcif_wb.h    |   24 +-
 drivers/gpu/drm/amd/display/dc/inc/link_service.h  |    4 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h      |    7 +-
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c    |  200 +-
 drivers/gpu/drm/amd/display/dc/link/link_dpms.h    |    4 +-
 .../display/dc/link/protocols/link_dp_training.c   |   28 +-
 .../amd/display/dc/link/protocols/link_hdmi_frl.c  |    2 +-
 drivers/gpu/drm/amd/display/dc/mmhubbub/Makefile   |   10 +
 .../amd/display/dc/mmhubbub/dcn32/dcn32_mmhubbub.c |    4 +-
 .../amd/display/dc/mmhubbub/dcn32/dcn32_mmhubbub.h |    5 +
 .../display/dc/mmhubbub/dcn401/dcn401_mmhubbub.c   |  135 ++
 .../display/dc/mmhubbub/dcn401/dcn401_mmhubbub.h   |   40 +
 .../amd/display/dc/mmhubbub/dcn42/dcn42_mmhubbub.h |    1 +
 .../gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c   |   44 +-
 .../gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c |   69 +-
 .../gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h |    6 +-
 drivers/gpu/drm/amd/display/dc/os_types.h          |   10 +
 .../display/dc/resource/dce100/dce100_resource.h   |    1 -
 .../display/dc/resource/dce112/dce112_resource.h   |    7 -
 .../amd/display/dc/resource/dcn30/dcn30_resource.c |    2 +
 .../display/dc/resource/dcn301/dcn301_resource.c   |    2 +
 .../display/dc/resource/dcn302/dcn302_resource.c   |    2 +
 .../display/dc/resource/dcn303/dcn303_resource.c   |    2 +
 .../amd/display/dc/resource/dcn31/dcn31_resource.c |    2 +
 .../display/dc/resource/dcn314/dcn314_resource.c   |    2 +
 .../display/dc/resource/dcn315/dcn315_resource.c   |    2 +
 .../display/dc/resource/dcn316/dcn316_resource.c   |    2 +
 .../amd/display/dc/resource/dcn32/dcn32_resource.c |    2 +
 .../display/dc/resource/dcn321/dcn321_resource.c   |    2 +
 .../amd/display/dc/resource/dcn35/dcn35_resource.c |    2 +
 .../display/dc/resource/dcn351/dcn351_resource.c   |    2 +
 .../amd/display/dc/resource/dcn36/dcn36_resource.c |    2 +
 .../display/dc/resource/dcn401/dcn401_resource.c   |   31 +-
 .../display/dc/resource/dcn401/dcn401_resource.h   |    4 +
 .../amd/display/dc/resource/dcn42/dcn42_resource.c |   30 +-
 .../display/dc/resource/dcn42b/dcn42b_resource.c   |    2 +
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c       |  202 +-
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h |   58 +-
 .../gpu/drm/amd/display/modules/power/power_psr.c  |    7 -
 .../drm/amd/display/modules/power/power_replay.c   |    7 -
 drivers/gpu/drm/amd/include/amdgpu_ptl.h           |    9 +-
 drivers/gpu/drm/amd/include/kgd_pp_interface.h     |    6 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                |   26 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |   29 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h            |    6 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |    4 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c  |    4 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c  |    2 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c  |    5 +-
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h       |    5 +
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |    2 +-
 .../pm/swsmu/inc/pmfw_if/smu15_driver_if_v15_0_0.h |   38 +
 .../drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h |    6 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h       |    4 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h       |    2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  |    2 +-
 .../drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c    |    6 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    |    8 +-
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |    7 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c   |   59 +-
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c    |    5 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c |    3 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |    2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c  |    3 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c   |    4 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c   |    2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |    3 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |    2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c   |    2 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c   |    3 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   |    2 +-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c   |  223 ++-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c   |    3 +-
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c   |   17 +-
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c   |    2 +
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c   |    3 +
 drivers/gpu/drm/amd/ras/rascore/ras.h              |    5 +
 drivers/gpu/drm/amd/ras/rascore/ras_aca.c          |   17 +-
 drivers/gpu/drm/amd/ras/rascore/ras_aca_v1_0.c     |    2 +-
 drivers/gpu/drm/amd/ras/rascore/ras_core.c         |   23 +
 drivers/gpu/drm/amd/ras/rascore/ras_eeprom.c       |    5 +
 drivers/gpu/drm/amd/ras/rascore/ras_eeprom.h       |    4 +-
 drivers/gpu/drm/amd/ras/rascore/ras_psp.c          |    3 +
 drivers/gpu/drm/amd/ras/rascore/ras_umc.c          |    3 +-
 drivers/gpu/drm/amd/ras/rascore/ras_umc.h          |   21 +
 drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c    |  129 +-
 drivers/gpu/drm/radeon/radeon_bios.c               |    2 +-
 include/uapi/drm/drm_fourcc.h                      |  209 +-
 291 files changed, 16640 insertions(+), 3597 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.h
 delete mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_kunit_helpers.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_probe.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/mmhubbub/dcn401/dcn401_mmhubbub.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/mmhubbub/dcn401/dcn401_mmhubbub.h
