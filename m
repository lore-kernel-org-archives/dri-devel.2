Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF98606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 21:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MBBnP7Zy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F09F5112107;
	Thu,  5 Nov 2026 21:20:30 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012015.outbound.protection.outlook.com [52.101.53.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E55CB112208;
 Thu,  5 Nov 2026 21:20:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPB6e3ME7lQcbwfj1MBmTEWix+QqOWqguyM+McMQqpkKO7iwt96QhFi91qImA1jg92tV8mqR6VIV6vePCIdSdHz0IOGatFUDM+JdFHNlgOs714r4r4x1y1/pzqivrfV5scXqZVoLbVUzt4IfxPrINnt+1FILdTdPHmY9SbspjKMUt+YHlV9N1QWS4+3UThmWXpz3J4vECRT+jcr0sQgwMDAmmLegk4HjlrcqFgM4sYtB5Dam08Avhx4nWd5zuTdKwV0jZ7SHqiGDdMGR5DZDIK/5KrrCe4u93Z2eVxTTCo49IpLJkJK192BMsbjPKex6FJ2KOQ3lXWD0Yk5iMXIIIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NenUcyKQuzftS1tslNx0jcRR+pmzZispwcuHJPxQl4=;
 b=XhMEl/ZnPBLEo3SIFdryNlU1gHqFOabdPZOMRSprmOh/EZemDWlhWwVml+HmRpnu/uIUxTC/lGXhE+WZt02bVqlfYfktE5l0obnU6TAqcu4YTfKZ2rSWh2+fFvUWhzd7VOKhb3EkBFsCFI9HS2X77z3aZHVH0Wkpw99f/lFcIJG0K+x34U6kBC7MYX/6J7pK2YyVQpsDThBxuZF6DLtOQBCwf/M8az7NBm+aU6bkWKeNvLTNJZw3Nn/H2mb7kPsHXk9DDZk3hIRaXT+jJ0AuwxuHLVQVkD2DJavcIHi/xmO4PyboI/tqDP7NLoyrXQcIcs3saHFbirDxgQ0J9LUNyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NenUcyKQuzftS1tslNx0jcRR+pmzZispwcuHJPxQl4=;
 b=MBBnP7Zyq3lJZCkcXIGt7rlUA9Za0pObQwQZ9ASGGMeyCxJRHW4OPdMFhEo+cQbktyX+svuc+TaR1xuKtfVoWLmpRdIPmQSvhuoxY+ZKNH/KIxSxZcewv6WcAKalOiN/kW38UqNVO9vL/cG2eUOK2j8YET8jYm0iJpiFLwrp/84=
Received: from CH2PR08CA0030.namprd08.prod.outlook.com (2603:10b6:610:5a::40)
 by PH7PR12MB6467.namprd12.prod.outlook.com (2603:10b6:510:1f5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 5 Nov 2026
 21:20:10 +0000
Received: from BN1PEPF00018548.namprd05.prod.outlook.com
 (2603:10b6:610:5a:cafe::69) by CH2PR08CA0030.outlook.office365.com
 (2603:10b6:610:5a::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 21:20:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018548.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 21:20:09 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 15:20:09 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 15:20:09 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 5 Nov 2026 15:20:08 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd, drm drm-fixes-7.4
Date: Thu, 5 Nov 2026 16:20:00 -0500
Message-ID: <20261105212000.2846044-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018548:EE_|PH7PR12MB6467:EE_
X-MS-Office365-Filtering-Correlation-Id: 597de869-667b-465b-e4d0-08df3b829240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|18002099003|18092099006|10086099003|10067099003|13003099007|3023799007|56012099006|261022075727099003|11063799006|261026140227099003|261009221727099003|261102123227099003|261026121527099003|261009221227099003|261009223027099003|261021121427099003|261021123027099003|261009223327099003|261009220027099003|261028144727099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: ToB2lA7thMGqjhrh6F2ypgWVjf6Pj6aQAf0e+uqrmFW7wil9636mLCduzzvmV8hqC7oO9yN8DGisjm/Z7ghICyBd50ADCmt51N1CpaaTy8fsHOfcjHdDhTGcnCHvO73U5o0p/eF2Kbjic73jPPt1bj/V1YDHGwM6NVTtsofLmvFYsWpdcqOQ0rTnCgVZo0j1/IhNSY9BASJTEwIuQWrAiyEcSN8IhV9TfuROjN9IbvUTpJep9hl6fDmT5vGa88XOs5IaFQZbUyIWxia+V0tijQzixeW/TLchtDIOilz424ZN94bGgDe0C5WghmxkXmThEibhcU1eT3uoAfXq/BnhvfqfCXzQTK8FXWuHvoEZK5PVTbucfCt3AN8Ls9mW4chrV0e9YBXrxPHTonIWxh11VfEvwlUMmAgJIpaqcmC+kpTVOJswZXpGjZobffxv4hKA127aLqZVET/BF2nxtgol1ABHUsobp/OeC3lptWkzhkuSrl0FFn4+KhCbjdrp3CLpzAt3/SN+H7o3MNe13ngLyQqeCVPIzr0FdqzKn48UlqOtC852X24dsLAlSWah9A2uZr8DINUJADvXsJrzyar6jb9hof2pMtf2MG6UYRwfMta6fdSZanU8Rn33gX8O4L5x5VvkNSLbJWpEcjQ9OjhHnA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(18002099003)(18092099006)(10086099003)(10067099003)(13003099007)(3023799007)(56012099006)(261022075727099003)(11063799006)(261026140227099003)(261009221727099003)(261102123227099003)(261026121527099003)(261009221227099003)(261009223027099003)(261021121427099003)(261021123027099003)(261009223327099003)(261009220027099003)(261028144727099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Jlcqwt8u+Edtb+mP0Dwlm2PsF3IC7Xl11xHWQNaiM5GXz9rWiDtsK8Y1lpCd8lJK5HHxKIpZvC4//5CTuiLzp0ceq1X96doyzipu15QMTHSiDD9jORaXXToxyEEbITH2r0mTutEjoiU4Hzdk0KHrbTP4ZxDl1dN47fJKQ0X7IeHbtqQkolyPBsmmnoPjSlPPHBa6ZvGwEuMwI+3xg2W2sW5uHOAm8SJElFZMb0d+rWpFkhv93bg+ajgKljAD/+mh4IYNOO71GjkQxgOaYL2F0BxpI5VQ5b/FpWREwCu+05LTHopcF02FgiAnKhXMgbHbKd3M0q2+RMTMQMmi7FQqaJ8z4yFt6kH20cZQ2uULkVyhXyCV4eW0rJU+FJTen6zSB3hcjFdkcpuXWm2Ni2DoYQZgJGu71/lnXTczGdUfUqeiEW4UttKtRTz5FOA5AGWE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 21:20:09.4981 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 597de869-667b-465b-e4d0-08df3b829240
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018548.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6467
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

Fixes for 7.4.

The following changes since commit 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4:

  Linux 7.4-rc1 (2026-11-01 13:26:31 -0800)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/amdgpu/kernel.git tags/amd-drm-fixes-7.4-2026-11-05

for you to fetch changes up to 6d1f901a83603a7d314e4a756b416b11d8dc7e35:

  drm/amdgpu: don't drop the gang dependency fence twice (2026-11-04 12:48:19 -0500)

----------------------------------------------------------------
amd-drm-fixes-7.4-2026-11-05:

amdgpu:
- UALink fixes
- RAS fixes
- GEM_OP fix
- Parse IB fixes
- CS user fence fix
- GPU reset fixes
- Multi-media idle work handler cleanup fixes
- UserQ fixes
- CRC fix
- SR-IOV fixes
- IP discovery fix
- HDMI 2.2 FRL fixes
- DDC pin fix
- HUBP fix
- SPM fix
- DCN 3.2 fixes
- VRR/freesync fix
- Seamless boot fix
- SMU 13.0.7 fix
- Backlight fix
- dma-buf fixes
- GPUVM fixes
- Move DMCUB back to VRAM
- Non-DC audio fix
- BACO fix

amdkfd:
- Fix WPTR BO eviction fence handling
- GPUVM locking fix

drm:
- Add parsing for additional HDMI 2.2 FRL rates

----------------------------------------------------------------
Alex Hung (1):
      drm/amd/display: Avoid closing unowned DDC pins

Bas Nieuwenhuizen (1):
      drm/amdgpu: Check cs flags.

Calvin Owens (1):
      Revert "drm/amd/display: Allocate DCN32/1 dmub memory to GTT"

Ce Sun (1):
      drm/amdgpu: skip RAS error count reset in debug mode

Dariusz Marcinkiewicz (1):
      drm/amdgpu: check amdgpu_vm_ready() in dma-buf move notify

Erhan Bilgili (2):
      drm/amdgpu: Fix duplicate dependency fence releases
      drm/amdgpu: Report MES ring wait timeouts.

Fangzhi Zuo (2):
      drm/edid: Parse HDMI 2.2 FRL rates from the SCDS
      drm/amd/display: Accept HDMI 2.2 FRL rates from the sink EDID

Hugo Sales (1):
      drm/amdgpu: Clamp the ATIF backlight curve to its 99 points

Jesse Zhang (11):
      drm/amdgpu: sign extend the addresses GEM_OP(GET_MAPPING_INFO) returns
      drm/amdgpu: parse CS IBs at the BO offset their VA mapping starts at
      drm/amdgpu: keep the CS user fence BO in GTT
      drm/amdkfd: use the queue's process info for the WPTR BO eviction fence
      drm/amdgpu/userq: validate the moved individual BOs on restore
      drm/amdgpu/gfx12: disallow GFXOFF while updating the SPM VMID
      drm/amdgpu: drop the dma-buf reference when a KFD import fails
      drm/amdgpu: unlock the VM and BO when attaching a KFD BO fails
      drm/amdgpu: rewrite all PTEs of the BOs after a VM reset
      drm/amdgpu: don't walk the CS chunks when allocating them failed
      drm/amdgpu: don't drop the gang dependency fence twice

Kent Russell (1):
      drm/amdgpu: Ensure that harvest information gets set

Kevin Wang (1):
      drm/amd/pm: populate unique ID for smu 13.0.7

Kylie C (1):
      drm/amd/display: Don't select zero V_TOTAL_MIN/MAX on seamless boot

Leo Liu (1):
      drm/amdgpu: cancel idle work in hw_init failure paths for vcn/uvd/vce/jpeg

Mario Limonciello (1):
      drm/amd/pm: track BACO state in the SMU v11 ArmD3 sequence

Matthew Schwartz (1):
      drm/amd/display: Keep the nominal vtotal while VRR is inactive

Melissa Wen (1):
      drm/amd/display: Signal PQ EOTF in FreeSync infopacket for DP HDR

Mikhail Gavrilov (1):
      drm/amd/display: set allow_freesync before validating a new stream

Milan Milicevic (2):
      drm/amdgpu: clear RB_OVERFLOW bit when enabling interrupts for navi10_ih
      drm/amdgpu: publish IH enabled before PSP programs IH_RB_CNTL

Misha Nasledov (1):
      drm/amd/display: Drop clock requirements on DCN32 when no displays are active

Mukul Joshi (1):
      drm/amdgpu: only tear down an active UALink accelerator

Prike Liang (7):
      drm/amdgpu/mes: skip unmap queue notification during GPU reset
      drm/amdgpu/uvd: don't allocate or lock BOs in the direct IB test
      drm/amdgpu/userq: wait for GPU reset before mapping or unmapping queues
      drm/amdgpu: finish GPU recovery callbacks before restarting schedulers
      drm/amdgpu: stop the schedulers before preparing the GPU reset
      drm/amdgpu/vce: don't allocate a scheduler fence in the direct IB test
      drm/amdgpu: stop GPU recovery wait for the JPEG/VCN idle work

Roman Demidov (1):
      drm/amd/display: Fix NULL deref in dcn401_update_clocks_update_dtb_dto

Roman Li (1):
      drm/amd/display: Reset DET of HUBPs without a plane before outstanding updates

Wayne Lin (1):
      drm/amd/display: add missing CRC engine 1 registers

renpanpan (1):
      drm/amdgpu: Only enable HDMI audio if display supports it

 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c           |  6 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   | 17 ++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             | 21 +++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 41 ++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      | 44 ++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c        |  5 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |  7 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c           | 25 ++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h           |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c            |  6 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c           |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          | 19 ++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            | 11 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            |  5 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            | 36 +++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h            |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             | 16 ++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c        |  1 -
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c             |  5 ++-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c              |  5 ++-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c              |  5 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             |  2 +
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c               | 13 ++++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c             | 27 ++++++-------
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c             | 28 ++++++--------
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c             | 27 ++++++-------
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c             | 28 ++++++--------
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c           | 27 ++++++-------
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c           | 27 ++++++-------
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c           | 27 ++++++-------
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c           | 28 ++++++--------
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c           | 28 ++++++--------
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c           | 27 ++++++-------
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c             |  4 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c             |  4 +-
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c             | 41 +++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c              |  4 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c              |  4 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c              |  4 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c              |  4 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c              |  4 +-
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c              |  6 ++-
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c              |  6 ++-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c              |  6 ++-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c              |  6 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c              | 15 ++++++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c              | 13 +++++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c              | 16 ++++++--
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c              | 17 +++++++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c              | 15 +++++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c            | 15 +++++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c            | 15 +++++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c            | 15 +++++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c            | 16 +++++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c            | 16 +++++++-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |  3 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c | 11 +-----
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c | 27 ++++++++++++-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |  6 +++
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c       | 30 +++++++++++++++
 .../amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c |  3 ++
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  6 ++-
 .../gpu/drm/amd/display/dc/core/dc_hw_sequencer.c  | 31 +++++++++++++++
 drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h |  3 ++
 .../display/dc/link/protocols/link_dp_capability.c |  6 +--
 .../gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c |  7 ++++
 .../gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.h | 18 +++++++++
 .../gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h | 22 ++++++++++-
 .../drm/amd/display/dc/optc/dcn314/dcn314_optc.h   | 18 +++++++++
 .../gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h | 11 ++++++
 .../gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.h | 11 ------
 .../drm/amd/display/dc/optc/dcn401/dcn401_optc.h   | 12 ++++++
 .../gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.h |  2 +
 .../gpu/drm/amd/display/dc/optc/dcn60/dcn60_optc.h |  2 +
 .../amd/display/dc/resource/dcn32/dcn32_resource.c | 15 +++++++-
 .../amd/display/dc/resource/dcn32/dcn32_resource.h |  6 +++
 .../display/dc/resource/dcn401/dcn401_resource.h   |  6 +++
 .../drm/amd/display/modules/freesync/freesync.c    |  6 +--
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     | 20 +++++++++-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   | 20 ++++++++++
 drivers/gpu/drm/drm_edid.c                         | 12 ++++++
 84 files changed, 828 insertions(+), 313 deletions(-)
