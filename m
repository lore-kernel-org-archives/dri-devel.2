Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAFC606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 22:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DqMAyB1Y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B6DB10E6E8;
	Wed, 28 Oct 2026 22:22:04 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011042.outbound.protection.outlook.com [52.101.62.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7646310E6E3;
 Wed, 28 Oct 2026 22:21:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SfZ3keksN45x1wQLEUB5WXb50uumnBSECC9MB5VeCysevvd19V1X28bJtDV6D4oWTth1zwRb+b4C5l/FZVlh2n4q7pRHrkxh3COVYC/PZtafu42oCT/MwrJK9A/VwJly+pExla+8+ZFZT/jqbkzKi4FtEZ08Zzb2bHycR/RpceY8cAxb66/Pf3K24kZJhfTYeb1SLdAtOVgeQ40myXqACJl1vRG827wSFtC7679nXl/1GU17sapGZQCAE+r4DquochmqknRINm9RqDnG0p46krIN3F9fk3q7M02//G34pitJoJUoDxuOJKd8QwsaoWsrDofNlMla7tOtYTLoEDU9RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzRocZnKpEXdUKMLA8qfeo3U1edMPXIBq3N+EUdV7xo=;
 b=SR3WEMEnnWQbDzTezj16Kf9CN78eQ5TqNxl143vwXMnLrx63qdb4ORltvEX4a+YiAPVlpzxA7AygNXk8mRGgBnzYeO/5nU2DFrwCOVL/95GNAraqbxOa2GCA+07CCRYPPs9U3K8JXfGthKRROmVLyApyQEMolD2FGhKC46nLnCL4Z+nwcePXkykGdJZSkPgkgXJDutGoc+/QEqLXR/bgGj6Z/7cI6fdHoJEaeiKvKXho4r4FJX5UFwn/VswEAmgG9Ut9eOpgohYn+3t9MQCVIPN54sJEF7QycbVSLIfjeh6QX+VaK9iOfad0GxkEjIV76PvtDSk8o/tEJbdTxqpP1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzRocZnKpEXdUKMLA8qfeo3U1edMPXIBq3N+EUdV7xo=;
 b=DqMAyB1YFi5t9dzYd89Q7ghKCW0e3vvBCnfmcvxigb/FCrFfz3bSPwYo68EKQp0i5d1f6P5jCipYrSuPpEicvlbbvwx+/9BoDYrR3g/IxhWHpI+d3+Owplu5pfmeLAc18BM5lIiQXyqaEdviWVTBplZKW0VdGqL69YOa29/LrbU=
Received: from DSZP220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::15) by
 LY0PR12MB854252.namprd12.prod.outlook.com (2603:10b6:408:3bb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 22:21:15 +0000
Received: from CY4PEPF000392D9.namprd03.prod.outlook.com
 (2603:10b6:5:280:cafe::46) by DSZP220CA0001.outlook.office365.com
 (2603:10b6:5:280::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.7 via Frontend Transport; Wed, 28
 Oct 2026 22:21:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF000392D9.mail.protection.outlook.com (10.167.247.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 22:21:15 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 17:21:14 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 28 Oct 2026 17:21:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd, radeon drm-next-7.5
Date: Wed, 28 Oct 2026 18:21:01 -0400
Message-ID: <20261028222102.1296050-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF000392D9:EE_|LY0PR12MB854252:EE_
X-MS-Office365-Filtering-Correlation-Id: 401a892d-a9c4-4d9b-715b-08df3541c7d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|18002099003|6133799003|261026121527099003|13003099007|3023799007|261021123027099003|10067099003|56012099006|261022113327099003|261021121427099003|261009223027099003|261022115727099003|261022075727099003|5023799004|261022105027099003|261026140227099003|11063799006|261028144727099003;
X-Microsoft-Antispam-Message-Info: 3t50E9ZqOrQBG7w19LoMNPQFu3TFGh3EA8bz8obehLm1ZUPmJOqCrC1DFUb6uloQysZqukA1CbPTd2Rz+my91EU4mayhtIykY3F36YJdV+cEymDmYp4fqbf66dLCsygl60FWeTE4/oZhpjxknDyigoXB48JgruJnD4ytqdP87NkNysnMJioAGSf8F/YJY9/tijeM2s5Bs+g1SNQBK7dWqjAsDd3yv7Uk01xr/+Wg8QZ/GZKMp4Eqy6Bd/Rt4uCfM+IvmSSsjJN4OJ9BYfAYzbpx8MJKKmBH4ycqnvf9odyDaRC8aOo8KO+AhDC9pqHTyLO8djYy0/+1hhJgHiRc1h+/9dpz7uAnDPsoBHLCtqPeILqfYnXGL1Mje2M582XDj9tSIxU3H6xyyOQ6VZg+t2wNSyrm42yLP2+B+l909XjoMMBvCUnb+cuVv3tv94nRBV8QBNt/vhRtP+OwUu2QvjWRYiPKx7OaUP25toZBC5vmXSQTur9zcM3MZDHhrEmif2Bs4NzZbgeyXeo6MtcmYXwA4qHsdPkC+3tsYioM0RTyLGUXiMEQZxXvbGtNPr5CJJd1CHgy9iut8LaTfQZlf+hVm4Lx25uY5If/vgKEelYXM+QHAW/NhFUnVR+85y0TjiiUdl/6Hr+93kojnYKHD3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(6133799003)(261026121527099003)(13003099007)(3023799007)(261021123027099003)(10067099003)(56012099006)(261022113327099003)(261021121427099003)(261009223027099003)(261022115727099003)(261022075727099003)(5023799004)(261022105027099003)(261026140227099003)(11063799006)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ipoxCoUP4B3SgcONTsvuN+3ZijJ+IqiiystT4YNOQ6o0uPIEOP/G29VJxJYxHQjyFAqsvLKNI8uiBVISEUp8fBmZbsRTz95aAHUM67W4OZ2G+ICasIaIUI5WRGyfPollco+udvZUJ0besSvIuU2UBfBrQbEUrIHWkRaat/xrPEW52kteoiudGGkrwWcVlmrGpkBrlwpaG1NGeTMBfSs3JoMKB4lM8H4fQr62HcwZEeF4cgqmQJl3Zxm87c8MdPlgvqKqi6I/9hG1JerPqzHdjspDgjoHb5CK1JsXR7iqZ6Af5VVXZN43uNnjhcNsVgtI73EsODSmk7m412wE4JqrnpcDlWPxBOqfo2OuE5LaSNWpiB0jcEOjA4O8n+Lr6DWjDwDWIfyLuYQzMhX0lk4I4EI9YTUsaoBbVrWo9DOG6f2jXzPJ8tLfDIi4yC4oAN+0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 22:21:15.1125 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 401a892d-a9c4-4d9b-715b-08df3541c7d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF000392D9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB854252
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Dave, Simona,

New stuff for 7.5.

The following changes since commit a56b45995b1e6b9ee671485b1fe68b0c7f754a67:

  Merge tag 'drm-rust-next-2026-10-11' of https://gitlab.freedesktop.org/drm/rust/kernel into drm-next (2026-10-13 18:01:37 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/amdgpu/kernel.git tags/amd-drm-next-7.5-2026-10-28

for you to fetch changes up to a24121023a434cb9b2b4db964d3fbbb4547d5e4c:

  drm/radeon: retry UVD v1 init on failure after resume (2026-10-27 15:10:50 -0400)

----------------------------------------------------------------
amd-drm-next-7.5-2026-10-28:

amdgpu:
- VCE/UVD sched teardown fix
- Display runpm reference fix
- Display TD-LUT fix
- SMU 13.x fixes
- SMU 14.x fixes
- Gang submit fix
- Passive DVI sink fix
- USB4 tunnel fix
- Freesync/VRR fixes
- SMU 15.x updates
- UALink updates
- RAS updates
- UVD fixes
- Runpm improvements
- Userq updates
- sched entity fixes
- GPUVM fixes
- SPM/VMID reservation rework
- Display rotation fix
- HWSS refactor
- AUX fixes
- DCN 4.2 updates
- HDR fixes
- DCN 6.x updates
- GC 12.x updates
- NBIO doorbell rework
- NBIF cleanup
- XCP cleanup fixes
- SDMA 3.x fix
- SR-IOV updates
- Misc cleanups
- Mac fixes
- HDMI fixes
- eDP fixes
- Userptr fixes
- PTL fixes
- SDMA related cleanups
- Prep work for display initialization rework
- DPMS fixes
- KUnit fixes
- DC atomic state allocation fixes

amdkfd:
- Bounds checking fixes
- Hotplug fixes
- SVM fixes
- CRIU fixes
- GFX12 fix
- Debugger fixes
- GC 12.1 updates
- Doorbell race fix
- CWSR fixes
- GPU reset fixes
- Correct VRAM available calculations
- SDMA fixes
- Version bump for SVM fixes
- Misc cleanups

radeon:
- VCE fixes ported from amdgpu
- UVD fix

----------------------------------------------------------------
Alex Hung (11):
      drm/amd/display: Handle pipeline name OOM
      drm/amd/display: Fix CRTC init cleanup
      drm/amd/display: Flatten CRC update flow
      drm/amd/display: Clean up allocation handling
      drm/amd/display: Fix coding style errors
      drm/amd/display: Fix KUnit connector leaks
      drm/amd/display: Use kunit_kcalloc for arrays
      drm/amd/display: Destroy dup connector state
      drm/amd/display: Drop single-entry kcalloc
      drm/amd/display: Use kzalloc_obj in tests
      drm/amd/display: Assert NOT_NULL on allocs

Alvin Lee (6):
      drm/amd/display: Use aux hw inst if no ddc pin exists
      drm/amd/display: Program HDR visual confirm based on per pipe info
      drm/amd/display: Update DMU cmd header
      drm/amd/display: Use picoseconds for line time on DCN6+
      drm/amd/display: Correct next frame calculation
      drm/amd/display: Update alt-ch size calc to handle MPO + ODM correctly

Andy Shevchenko (1):
      drm/amdkfd: Do not use internal implementation of tolower()

Aric Cyr (2):
      drm/amd/display: Invalidate the DRR shadow after a hardware re-init
      drm/amd/display: move timing_adjust_pending into dc_stream_state

Asad Kamal (5):
      drm/amd/pm: Update smu_v15_0_8 PMFW headers
      drm/amd/pm: Add set_npm_limit function
      drm/amd/pm: Add NPM metrics reads and SetNpmLimit
      drm/amd/pm: Add store npm limit function
      drm/amd/pm: Notify node unload during driver unload

Ashwin Santhosh (1):
      drm/amd/display: Pre-allocate DC state for atomic-context commits

Austin Zheng (1):
      drm/amd/display: Expose Generic Function That Can Be Reused

Avi Weiss (2):
      drm/amd/pm: propagate errors when forcing SMU11 clock levels
      drm/amd/display: Initialize missing TD-LUT programming inputs

Benjamin Cheng (1):
      drm/amdgpu/userq: actually validate userq BOs

Boyuan Zhang (1):
      drm/amdgpu/psp: Fail on VCN firmware load error

Ce Sun (3):
      drm/amdgpu/pm: move smu_feature_init to smu_early_init
      drm/amdgpu/ras: Use MP1 feature status to select fw-managed EEPROM
      drm/amdgpu/ras: Select EEPROM ops based on PSP IP version

Charlene Liu (5):
      drm/amd/display: Fix rotate 90 degrees surface corruption issue
      drm/amd/display: use dmub to notify pme
      drm/amd/display: Do not allow vbios version of dmubfw in the driver
      drm/amd/display: remove hard code min dcfclk for AC.
      drm/amd/display: remove not used code

Chi Hong (1):
      drm/amd/ras: skip RAS TA firmware reload on resume for SR-IOV VFs

Daniel Phillips (1):
      amdkfd: Fix memory availability double accounting of kfd pinned objects

David Belanger (3):
      drm/amdkfd: add watch_addresses to set_shader_debugger interface
      drm/amdkfd: pass watchpoint addresses to MES for GFX11
      drm/amdkfd: pass watchpoint addresses to MES for GFX12

David Yat Sin (1):
      drm/amdkfd: Bump KFD ioctl version - SVM no access

Dillon Varone (2):
      drm/amd/display: Improve mandatory pstate optimization and check
      drm/amd/display: set VRR_EN for inactive state

Dominik Kaszewski (2):
      drm/amd/display: Directly include compiler_attributes.h
      drm/amd/display: Convert update scratch to memory pool

Elena Sakhnovitch (1):
      drm/amdgpu/gmc9: add extra type-2 TLB flush for gfx942/gfx950

Fangzhi Zuo (7):
      drm/amd/display: Simplify hdmi_automation debugfs with debugfs_create_bool
      drm/amd/display: reject invalid per-mode FreeSync timing
      drm/amd/display: warn on unadvertised modes without scaling
      drm/amd/display: align VRR timing gate with FreeSync module
      drm/amd/display: Poll passive DVI sinks for EDID readiness
      drm/amd/display: Cap DSC bpp for USB4 DP tunnels
      drm/amd/display: refresh cached HDMI FreeSync state

George Shen (4):
      drm/amd/display: Split link_set_dsc_on_stream into encoder and DSC components
      drm/amd/display: Add new config_dsc hwseq function for dcn60
      drm/amd/display: Program DSC prior to OTG enable starting DCN60
      drm/amd/display: Preserve planes on DPMS-on during DP test link retrain

Harish Kasiviswanathan (2):
      drm/amdgpu: Don't hardcode hqd registers list size
      drm/amdkfd: fix NULL deref in SDMA HQD debugfs dump on GC 12.1

Harkirat Gill (1):
      drm/amdgpu: re-enable GFXOFF for compute on GFX12

Hawking Zhang (14):
      drm/amdgpu/gfx_v12_0: Remove legacy CP programming
      drm/amdgpu: Add common NBIO doorbell entry helpers
      drm/amdgpu: Add nbio v6_3_2 doorbell layout
      drm/amdgpu: Use common doorbell helpers in nbio v6_3_2
      drm/amdgpu: Add nbio v4_3 doorbell layout
      drm/amdgpu: Use common doorbell helpers in nbio v4_3
      drm/amdgpu: Support doorbell range programming through smn
      drm/amdgpu: Use common doorbell helpers in nbio v7_9
      drm/amdgpu: Use common doorbell helpers in nbio v7_11_5
      drm/amdgpu: Add nbif v4_10_0 ip headers
      drm/amdgpu: Add nbio v7_11_4 support
      drm/amdgpu: Drop nbio v7_11_x support from nbif v6_3_1
      drm/amdgpu: Use common doorbell helpers in nbio v7_11_4
      drm/amdgpu: Use common doorbell helpers in nbif v6_3_1

Heng Zhou (1):
      drm/amdkfd: fix lost wakeup in interrupt drain on debugged process exit

Henry Martin (1):
      drm/amdkfd: fix doorbell allocation race creating duplicate allocations

Horatio Zhang (1):
      drm/amdgpu: skip the PASID TLB fence for the UALink NPA VM

Ilya Bakoulin (2):
      drm/amd/display: Fix HDMI FRL FFE compliance test
      drm/amd/display: Adjust HDMI FRL LT timeout

Ivan Lipski (2):
      drm/amd/display: fix NULL dc deref in hpd_init KUnit tests
      drm/amd/display: Re-init cursor offload to dmub after resume

Jesse Zhang (18):
      drm/amdgpu: wake the GPU for INFO queries that access the hardware
      drm/amdgpu/userq: reject imported dma-bufs as WPTR BO
      drm/amdgpu: fix the error path in amdgpu_vm_pt_alloc()
      drm/amdgpu: don't drop the runtime PM reference twice in amdgpu_gpr
      drm/amdgpu: free the userptr ranges when a CS fails after parser_bos
      drm/amdgpu: report the BO alignment in bytes in GEM_LIST_HANDLES
      drm/amdgpu: keep the eviction fence until the last handle is closed
      drm/amdgpu: reject unknown GEM_METADATA ops
      drm/amdgpu: return copy errors from AMDGPU_INFO_UQ_FW_AREAS
      drm/amdgpu: reject ANONONLY userptrs that span multiple VMAs
      drm/amdkfd: don't drop an SVM CWSR reference that was never taken
      drm/amdgpu: keep PRT mappings off the VM state lists again
      drm/amdgpu: reject CS chunks too large for kvmalloc()
      drm/amdkfd: split vram_pages of SVM ranges prefetched without a GPU mapping
      drm/amdkfd: send SMI process and VM fault events only to allowed clients
      drm/amdgpu: don't wait for the SPM VMID's jobs under the VMID manager lock
      drm/amdgpu: drop the gang leader reference when freeing gang jobs
      drm/amdkfd: evict the queues only once for CRIU PROCESS_INFO

Jiale Yao (1):
      drm/amdkfd: validate SRAT subtables before parsing

John Fisher (1):
      drm/amdgpu: wait for pending page table updates before switching a VM to CPU updates

Kaier Hsueh (1):
      drm/amd/display: YUV422 Semi-Planar Images Show Color Blurring at Color Boundaries

Karthi Kandasamy (1):
      drm/amd/display: Do full link training during HDR/SDR seamless switch

Keita Morisaki (1):
      drm/amd/display: Fix swap in median3() for DSC rate control

Kenneth Feng (2):
      drm/amd/pm: add zero fan stop temperature support on smu 14.0.2
      drm/amd/pm:restate all customized OD features on every table upload for smu 13.0.0/smu 14.0.2

Kent Russell (1):
      drm/amdgpu: Add log when register access is blocked in PTL

Kevin Wang (6):
      drm/amd/pm: mark the current DPM clock level active
      drm/amd/pm: align smu 13.0.7 activity-monitor power profile output
      drm/amd/pm: reapply umd profile state after recovery
      drm/amd/pm: report smu energy accumulator updates
      drm/amd/pm: preserve committed OD features for SMU 13.0.0/13.0.7
      drm/amd/pm: preserve committed OD features for SMU 14.0.2

Leo Chen (1):
      drm/amd/display: Disable HUBP/DPP power gating on DCN42

Leon Huang (1):
      drm/amd/display: Add AS-SDP V3 support for VESA PR

Luigi Lauro (2):
      drm/amdgpu: require _PR3 for BOCO
      drm/amd/display: take a runtime PM reference only when a CRTC turns on

Luqmaan Irshad (1):
      drm/amdgpu: defer XCP DRM device free until primary release

Maciej Kucharek (3):
      drm/amdgpu: reset SI ASIC on MacBookPros with VRAM at 0
      drm/amdgpu: reset CIK ASIC on Apple boards with VRAM at 0
      drm/amdgpu: reset VI ASIC on Apple boards with VRAM at 0

Mario Limonciello (1):
      drm/amd/display: don't WARN when removing an unallocated MST payload

Matheus Tagliari (2):
      drm/radeon: process the VCE interrupt on SI and Trinity
      drm/radeon/vce1: enable the VCE trap interrupt

Matthew Stewart (1):
      drm/amd/display: Reuse mpc401_read_mpcc_state on dcn42, dcn60

Mukul Joshi (2):
      drm/amdgpu: add gfx 12.1 SDMA MQD definition
      drm/amdkfd: set SDMA MQD dummy_reg1 on GFX 12.1

Olivier Kaloudoff (3):
      drm/amdkfd: tear down KFD processes before early fini_sw on disconnect
      drm/amdkfd: stop restore retries on device unplug
      drm/amdgpu: guard VCE/UVD sched entity teardown on failed probe

Omer El Idrissi (1):
      drm/amdgpu: remove unused tracepoint

Omokefe Emmanuel Onanaroghene (1):
      drm/amd/display: remove unused cgs register accessor typedefs

Ovidiu Bunea (3):
      drm/amd/display: Fix frac_urg_bw conversion to correct U0.10 format
      drm/amd/display: Update DCN42 cstate latencies
      drm/amd/display: Add debug flag to support for different DMCUB FW loading

Perry Yuan (3):
      drm/amdgpu: fix sched entity leak in ttm buffer entity init
      drm/amdgpu: destroy mutex when tearing down ttm buffer entity
      drm/amdgpu: fix GEM object leak on ENOMEM in userptr ioctl

Philip Yang (3):
      drm/amdkfd: Fix svm_bo use after free in svm_range_clone
      drm/amdgpu: Reject UALink source-identification address mode
      drm/amdgpu: Enable remote TLB shootdown

Piotr Maziarz (1):
      drm/amd/display: Gate DP_TRACE_SOURCE_SEQUENCE emission on the debug flag

Prike Liang (3):
      drm/amdgpu/mes: move RS64 query buffer setup to software init
      drm/amdgpu: drop the unused firmware loading mutex
      drm/amdgpu: remove suspend/resume DRM clients during GPU recovery

Rafal Ostrowski (2):
      drm/amd/display: HWSS Refactor - DC IP request control
      drm/amd/display: HWSS Refactor - DPP root clock control

Ray Wu (3):
      drm/amd/display: Align eDP DSC link policy to minimize lane count
      drm/amd/display: Log PSR and Replay status after mode change
      drm/amd/display: Exit PSR/Replay on non-modeset full updates

Roman Li (1):
      drm/amd/display: guard DCE-only hwseq definitions

Samson Tam (5):
      drm/amd/display: handle exit LS in second ISHARP programming block
      drm/amd/display: handle UPSP chroma upsampling in DML
      drm/amd/display: Revert "Program DSC prior to OTG enable starting DCN60"
      drm/amd/display: Revert "Add new config_dsc hwseq function for dcn60"
      drm/amd/display: Revert "Split link_set_dsc_on_stream into encoder and DSC components"

Shahyan Soltani (2):
      drm/amdgpu: move amdgpu_vm_bo_update() call into correct location
      drm/amdgpu: clear vm pts upon a vm->generation mismatch

Sharique Pervaiz (1):
      drm/amd/display: Add DPG force-on-flip support for SystemDisplayEnable

Sridevi Arvindekar (3):
      drm/amd/display: Fix upsampling for linear scaling of subsampled YUV
      drm/amd/display: Fix linear scaling and upsampling
      drm/amd/display: Reset UPSP and pre-CSC registers on DCN6 DPP reset

Srinivasan Shanmugam (1):
      drm/amd/display: Fix NULL sink dereference in USB4 bandwidth functions

Stanley.Yang (3):
      drm/amd/ras: Fix APU platform ras block feature mask
      drm/amd/ras: Support invoke ras command
      drm/amd/ras: Add pcie bif ras aca bank info

Sunil Khatri (18):
      drm/amdgpu: store the user-queue VMID mask instead of first_kfd_vmid
      drm/amdgpu: amdgpu_vmid_mgr_set_vmid_mask to set up both hubs at once
      drm/amdgpu: use the same naming scheme for kq and uq VMID masks
      drm/amdgpu: add spm_vmid and exclude it from the MES, KFD and kq pools
      drm/amdgpu: reserve SPM VMID on gfx7
      drm/amdgpu: reserve SPM VMID on gfx8
      drm/amdgpu: reserve SPM VMID on gfx9
      drm/amdgpu: reserve SPM VMID on gfx10
      drm/amdgpu: reserve SPM VMID on gfx11
      drm/amdgpu: reserve SPM VMID on gfx12
      drm/amdgpu: use spm_vmid for the default RLC SPM VMID
      drm/amdgpu: use dedicated SPM VMID from the reserved path
      drm/amdgpu: remove the now-redundant runtime SPM VMID update
      drm/amdgpu: remove the unused ring parameter from update_spm_vmid()
      drm/amdgpu: fix amdgpu_vm_bo_insert_map to let bo gets update
      drm/amdgpu: identify the root PD by pointer in amdgpu_vm_bo_needs_update
      drm/amdgpu: bind the SPM VMID's page table to the reserving VM
      drm/amdgpu: rename amdgpu_vmid_alloc/free_reserved to _spm

Taimur Hassan (5):
      drm/amd/display: Promote DC to 3.2.402
      drm/amd/display: [FW Promotion] Release 0.1.80.0
      drm/amd/display: Promote DC to 3.2.403
      drm/amd/display: [FW Promotion] Release 0.1.81.0
      drm/amd/display: Promote DC to 3.2.404

Timur Kristóf (2):
      drm/amdgpu/uvd3.1: Fix checking whether UVD firmware keyselect was already set
      drm/amdgpu/sdma3: Work around POLL_REGMEM / FENCE hang

Tom St Denis (1):
      drm/amd/amdgpu: Add missing GC 11.0.0 registers

Tony Cheng (18):
      drm/amd/display: Add Core 2 initialization BLS scaffolding
      drm/amd/display: Scaffold Core2 BLS builder and executor
      drm/amd/display: Add Core 2 Workaround Manager scaffolding
      drm/amd/display: Scaffold DMUB inbox BLS dispatch
      drm/amd/display: Scaffold generic DMUB GPINT BLS dispatch
      drm/amd/display: Scaffold DMUB STOP_FW on the init BLS
      drm/amd/display: Name the init STOP_FW entry DMUB_HALT_FW
      drm/amd/display: Scaffold PSP reload, ABI query, and Initialize DCN
      drm/amd/display: Call the init BLS from Core2 hardware init
      drm/amd/display: Attach retained DMUB windows to PSP reload
      drm/amd/display: Split dcn401 init register writes into hwseq funcs
      drm/amd/display: Add dal_gpio_ddc_open_aux_once
      drm/amd/display: Dispatch the dcn401_init_hw calls from the Executor
      drm/amd/display: Narrow the DMUB-driven dcn401 init builder helpers
      drm/amd/display: Run DC2_DC1_Wrapped init as staged BLS builds
      drm/amd/display: Read DCN401 PHY reset and lane enable state
      drm/amd/display: Read cursor update lock into mpcc_state
      drm/amd/display: Add BIOS, link, DSC and cursor lock to get_hw_state

Tvrtko Ursulin (3):
      drm/amdgpu: Size the buffer_funcs array by maximum number of SDMA instances
      drm/amdgpu: Size the vm_pte_scheds array by maximum number of SDMA instances
      drm/amdgpu: Simplify amdgpu_ring_init

Victor Skvortsov (1):
      drm/amdgpu: Enable queue reset for sdma 7.1 VFs

Victor Zhao (2):
      drm/amdgpu/mes: Support 64-bit register reads
      drm/amdgpu: Read SMUIO GPU clock on GFX12.1 VF

Wenjing Liu (3):
      drm/amd/display: Fix QoS bandwidth fields copied from DML
      drm/amd/display: Remove deprecated bandwidth Kbps fields
      drm/amd/display: Add debug option to force MPC combine

Will Aitken (1):
      drm/amdgpu: Ensure fb-sharing is enabled for xgmi same hive check

William Palacek (2):
      drm/amdkfd: wait for a GPU reset before freeing a BO
      drm/amdkfd: Validate the control stack of a restored queue

Willian Oliveira (1):
      drm/amdgpu/gfx7,8: remove redundant RLC cleanup

Xiang Liu (5):
      drm/amd/ras: report threshold status after bad pages are saved
      drm/amd/ras: report the bad page threshold in every work mode
      drm/amd/ras: init reserved vram size before RAS core sw init
      drm/amd/ras: report bad page threshold only when exceeded
      drm/amd/ras: use page units in EEPROM status messages

Yibiao Li (1):
      drm/amd/display: Use separate iterator for preferred mode lookup

Yongqiang Sun (3):
      drm/amdgpu: log mes_dbgext from every MES pipe
      drm/amdgpu: send SETUP_MES_DBGEXT to the requested pipe
      drm/amdkfd: Enable IB execution for user-mode SDMA queues

Zhen Han (1):
      drm/amdkfd: correct vram_available calculation

ukrainer8 (1):
      drm/radeon: retry UVD v1 init on failure after resume

 drivers/gpu/drm/amd/amdgpu/Makefile                |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |    7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |   19 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c |   12 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c |   12 -
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c   |   58 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |  105 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   35 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |   21 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   22 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |    6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   14 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |   29 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |   24 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h            |    2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c             |    7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c            |  180 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h            |   26 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c            |   24 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h            |    1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |   43 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c            |  201 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h            |   15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c           |  150 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h           |   88 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |   33 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |   15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c         |   17 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |    5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |   12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h            |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c          |    7 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h          |   16 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |   10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h            |    3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c         |   21 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h          |    1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |   17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c    |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            |    3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            |    3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  104 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |    9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c          |   12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c            |   40 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h            |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c           |    6 +-
 drivers/gpu/drm/amd/amdgpu/cik.c                   |   10 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |   24 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |   16 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             |  143 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c             |   43 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c              |   16 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |   17 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |   24 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c            |    6 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h            |    3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c            |   42 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |   15 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c             |   16 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c             |   31 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c              |   14 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c              |   18 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c              |   18 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |   46 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c         |    7 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c             |   31 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c             |   12 +
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c             |    8 +
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c           |  369 +++----
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c             |  265 +++--
 drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c           |  324 +++---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_11_4.c          |  452 +++++++++
 drivers/gpu/drm/amd/amdgpu/nbio_v7_11_4.h          |   32 +
 drivers/gpu/drm/amd/amdgpu/nbio_v7_11_5.c          |  256 +++--
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c             |  377 +++----
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c             |   25 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c             |   39 +-
 drivers/gpu/drm/amd/amdgpu/si.c                    |   10 +
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c              |    2 +-
 drivers/gpu/drm/amd/amdgpu/vi.c                    |   10 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |   50 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c              |   35 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c             |   16 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h             |    2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |    9 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |    9 +
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c          |   23 +-
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c   |    2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c   |    2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v12_1.c |    2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c    |   78 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h       |    9 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c   |    9 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c   |    9 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c   |   13 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c |   49 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |   10 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c    |    2 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   13 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |   51 +-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |   30 +-
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c             |   23 +-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c        |   60 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |   36 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |    2 +-
 drivers/gpu/drm/amd/amdkfd/soc15_int.h             |    1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  141 +--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   22 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c    |    2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c  |    4 +
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    |   63 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.h    |    2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |   12 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |   70 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c |    5 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c |   43 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |   31 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h  |    4 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |   17 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    |    6 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h    |    2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_services.c |    2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h    |    2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c     |    5 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_audio_test.c |   84 +-
 .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     |   48 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_color_test.c |    8 +-
 .../amdgpu_dm/tests/amdgpu_dm_colorop_test.c       |    2 +-
 .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     |   80 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c  |  248 +++--
 .../display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c  |  168 +--
 .../amdgpu_dm/tests/amdgpu_dm_freesync_test.c      |   79 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c  |    4 +-
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c       |   20 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_irq_test.c   |  373 ++++---
 .../amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c      |    2 +-
 .../amdgpu_dm/tests/amdgpu_dm_mst_types_test.c     |   12 +-
 .../amdgpu_dm/tests/amdgpu_dm_quirks_test.c        |    6 +-
 .../amd/display/amdgpu_dm/tests/amdgpu_dm_test.c   |   30 +-
 drivers/gpu/drm/amd/display/dc/Makefile            |    8 +
 .../drm/amd/display/dc/bls_builder/bls_builder.c   |   21 +
 .../drm/amd/display/dc/bls_builder/bls_builder.h   |   98 ++
 .../display/dc/bls_builder/bls_builder_internal.h  |   11 +
 .../dc/bls_builder/bls_builder_legacy_init.h       |  128 +++
 .../display/dc/bls_builder/dcn401_init_builder.c   |  413 ++++++++
 .../display/dc/bls_builder/dcn401_init_builder.h   |   42 +
 .../dc/bls_builder/dcn401_init_builder_legacy.c    | 1071 ++++++++++++++++++++
 .../dc/bls_builder/dcn401_init_builder_legacy.h    |   18 +
 .../gpu/drm/amd/display/dc/bls_builder/dmub_abi.h  |   13 +
 .../drm/amd/display/dc/bls_executor/bls_executor.c |  703 +++++++++++++
 .../drm/amd/display/dc/bls_executor/bls_executor.h |   21 +
 .../amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c |    2 -
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  216 +++-
 .../gpu/drm/amd/display/dc/core/dc_hw_sequencer.c  |  105 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |   19 -
 .../drm/amd/display/dc/core/dc_resource_helper.c   |   46 +
 .../gpu/drm/amd/display/dc/core2/dc_core2_init.c   |   78 +-
 .../amd/display/dc/core2/dc_core2_legacy_init.c    |  236 +++++
 .../amd/display/dc/core2/dc_core2_legacy_init.h    |   17 +
 drivers/gpu/drm/amd/display/dc/dc.h                |   35 +-
 .../drm/amd/display/dc/dc_api_dispatch/api_shim.h  |    4 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c       |   17 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h       |   11 +
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h       |    3 +-
 drivers/gpu/drm/amd/display/dc/dc_fused_io.c       |    4 +-
 drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h     |    4 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h       |    1 -
 drivers/gpu/drm/amd/display/dc/dc_memory_pool.c    |    1 +
 drivers/gpu/drm/amd/display/dc/dc_memory_pool.h    |    2 +
 drivers/gpu/drm/amd/display/dc/dc_spl_translate.c  |   22 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |    3 +
 .../drm/amd/display/dc/dccg/dcn314/dcn314_dccg.c   |    4 +-
 .../gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c |   21 +-
 .../gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.h |    3 +-
 .../gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c |    2 +-
 .../display/dc/dcn10/dcn10_hw_sequencer_debug.c    |  173 ++++
 .../dc/dio/dcn401/dcn401_dio_link_encoder.c        |   22 +-
 .../dc/dio/dcn401/dcn401_dio_link_encoder.h        |    8 +
 .../gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c   |    2 +-
 .../dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h |    8 +-
 .../dml21/src/dml2_core/dml2_core_dcn4_calcs.c     |    9 +-
 .../src/dml2_core/dml2_core_dcn5_calcs_dchub.c     |    5 +-
 .../src/dml2_core/dml2_core_dcn6_calcs_dchub.c     |   17 +-
 .../dml2_core_dcn6_funcs_mode_programming.c        |    4 +-
 .../dml2_core/dml2_core_dcn6_funcs_mode_support.c  |    3 +-
 .../dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c |   20 +-
 .../dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn5.c |   13 +-
 .../dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6.c   |    2 +-
 .../dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6.h   |    1 +
 .../src/dml2_pmo/dml2_pmo_dcn6_stage_optimizers.c  |   97 +-
 .../alternate_pstate_shared_lib.c                  |   11 +-
 .../dml21/src/inc/dml2_internal_shared_types.h     |    2 +-
 .../dml21_wrapper/dml21_translation_helper.c       |   11 +-
 .../amd/display/dc/dmub_messenger/dmub_messenger.c |   81 ++
 .../amd/display/dc/dmub_messenger/dmub_messenger.h |   55 +
 .../gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c   |    4 +-
 .../gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.h   |    3 +-
 .../gpu/drm/amd/display/dc/dpp/dcn20/dcn20_dpp.c   |    4 +-
 .../gpu/drm/amd/display/dc/dpp/dcn201/dcn201_dpp.c |    4 +-
 .../gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c   |   76 +-
 .../gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h   |    9 +-
 .../gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c |    4 +-
 .../gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h |   11 +-
 .../amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c    |   48 +-
 .../gpu/drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c   |    4 +-
 .../gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.c   |    4 +-
 .../gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.h   |    3 +-
 .../gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c   |   55 +-
 .../gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.h   |   16 +-
 .../drm/amd/display/dc/dpp/dcn60/dcn60_dpp_dscl.c  |   20 +-
 drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c |   19 +
 .../drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c |    9 +-
 .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c  |   68 +-
 .../drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c    |   28 +-
 .../drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c    |   30 +-
 .../drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c    |   21 +-
 .../drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c  |   20 +-
 .../drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h  |    2 +
 .../drm/amd/display/dc/hwss/dcn314/dcn314_init.c   |    1 +
 .../drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c    |    7 +-
 .../drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c    |   24 +-
 .../drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h    |    2 +
 .../gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c |    1 +
 .../drm/amd/display/dc/hwss/dcn351/dcn351_init.c   |    1 +
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c  |   50 +-
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h  |    5 +-
 .../drm/amd/display/dc/hwss/dcn401/dcn401_init.c   |    4 +
 .../drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c    |    6 +-
 .../gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c |    1 +
 .../drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c    |    3 +-
 .../drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c    |    4 +-
 drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h |  236 ++++-
 .../drm/amd/display/dc/hwss/hw_sequencer_private.h |   13 +-
 drivers/gpu/drm/amd/display/dc/inc/core_types.h    |    7 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h       |    6 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h        |    3 +-
 .../gpu/drm/amd/display/dc/inc/hw/link_encoder.h   |    2 +
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h        |    1 +
 .../amd/display/dc/link/accessories/link_dp_cts.c  |   19 +-
 .../amd/display/dc/link/hwss/link_hwss_hpo_frl.c   |    3 +
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c    |   26 +-
 .../amd/display/dc/link/protocols/link_hdmi_frl.c  |  129 ++-
 .../gpu/drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c   |    2 +
 .../gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c |    2 +-
 .../gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h |    5 +
 .../gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c   |   10 +-
 .../gpu/drm/amd/display/dc/mpc/dcn60/dcn60_mpc.c   |    2 +-
 drivers/gpu/drm/amd/display/dc/os_types.h          |    1 -
 .../display/dc/resource/dcn401/dcn401_resource.c   |   10 +-
 .../amd/display/dc/resource/dcn42/dcn42_resource.c |    9 +-
 .../display/dc/resource/dcn42/dcn42_resource_fpu.c |   22 -
 .../display/dc/resource/dcn42/dcn42_resource_fpu.h |    1 -
 .../amd/display/dc/resource/dcn60/dcn60_resource.h |    6 +
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c       |   59 +-
 .../dc/workaround_manager/workaround_manager.c     |   74 ++
 .../dc/workaround_manager/workaround_manager.h     |   46 +
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h    |   45 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c  |    7 +
 .../amd/display/include/gpio_service_interface.h   |    6 +
 .../drm/amd/display/modules/inc/mod_info_packet.h  |    5 +
 .../amd/display/modules/info_packet/info_packet.c  |   38 +-
 .../drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h |    4 +
 .../amd/include/asic_reg/gc/gc_11_0_0_sh_mask.h    |   54 +
 .../amd/include/asic_reg/nbif/nbif_4_10_0_offset.h |  103 ++
 .../include/asic_reg/nbif/nbif_4_10_0_sh_mask.h    |  573 +++++++++++
 drivers/gpu/drm/amd/include/cgs_common.h           |   74 +-
 drivers/gpu/drm/amd/include/kgd_pp_interface.h     |    3 +
 drivers/gpu/drm/amd/include/mes_v11_api_def.h      |   10 +
 drivers/gpu/drm/amd/include/mes_v12_api_def.h      |    3 +
 drivers/gpu/drm/amd/include/v12_structs.h          |  133 +++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                |  103 ++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |   33 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h            |    2 +
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c   |   33 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |  105 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |    8 +
 .../amd/pm/swsmu/inc/pmfw_if/smu_v15_0_8_pmfw.h    |   12 +-
 .../amd/pm/swsmu/inc/pmfw_if/smu_v15_0_8_ppsmc.h   |    5 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h       |    4 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h       |    1 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    |    6 +-
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |    2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |  206 +++-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |  294 ++++--
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   |  286 +++++-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c   |  151 ++-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.h   |    4 +
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             |   61 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h             |    2 +
 drivers/gpu/drm/amd/ras/core/aca_v1_0.c            |    7 +
 drivers/gpu/drm/amd/ras/core/eeprom.c              |    2 +-
 drivers/gpu/drm/amd/ras/core/ras.h                 |    3 +-
 drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c      |   48 +-
 drivers/gpu/drm/amd/ras/core/ras_psp.c             |   40 +-
 drivers/gpu/drm/amd/ras/core/ras_psp.h             |    3 +
 drivers/gpu/drm/amd/ras/core/ras_psp_v13_0.c       |   14 +-
 drivers/gpu/drm/amd/ras/core/ras_umc.c             |    9 +-
 drivers/gpu/drm/amd/ras/core/ta_if.h               |    1 +
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c   |    3 +
 drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h          |    6 +
 drivers/gpu/drm/radeon/evergreen.c                 |   14 +
 drivers/gpu/drm/radeon/si.c                        |   14 +
 drivers/gpu/drm/radeon/sid.h                       |    2 +
 drivers/gpu/drm/radeon/uvd_v1_0.c                  |   52 +-
 drivers/gpu/drm/radeon/vce_v1_0.c                  |    9 +
 include/uapi/linux/kfd_ioctl.h                     |    3 +-
 308 files changed, 10955 insertions(+), 3184 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v7_11_4.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v7_11_4.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_internal.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_legacy_init.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder_legacy.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder_legacy.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/dmub_abi.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/core/dc_resource_helper.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/core2/dc_core2_legacy_init.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/core2/dc_core2_legacy_init.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dmub_messenger/dmub_messenger.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dmub_messenger/dmub_messenger.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/workaround_manager/workaround_manager.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/workaround_manager/workaround_manager.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbif/nbif_4_10_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbif/nbif_4_10_0_sh_mask.h
