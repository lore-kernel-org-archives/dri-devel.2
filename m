Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DAB5C9832A
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 01:35:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A604310E02A;
	Sat, 26 Sep 2026 01:35:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZruQtrXO";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010012.outbound.protection.outlook.com [52.101.46.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 780D010E02A
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 01:35:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVm3W98ApPyyx6JKIjWXgJRdwEqQYNcxjsjqyvwywsTBSYD/V9X0yipY+Dmw+PWIo2Vo4KM8Lld4qfoF8o7eEkAknAHUNuMNFbOaXTnNyoEv4aVZDi6vAlOGw1zgNLkP2qvJSkUhq7PEjw//RyeKOJRaeD4oyMLf3mPHFgCXzjk3GscWpe+OL09L13B836Tn0RzHmghL2FjqrGZPkSmynOcLM41ikHjWx1iFy53CYwWyk/kpN2Zh4UAJynGU/lAMFH/VCxOnAcQux5hSgDZiKAYdLpQ354WMVINCZdjINYBk2u3MYkWlP6KtjkoioBWNRaex0So5+kF0qJ2toxP3HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcWwtA5fuNvPZrpQxAFELbI9Qyw0J7X4ifFjanWSTGc=;
 b=BTHqrSEizGJ8bC6l4k4x23oYfkHhtHiFwaMd4fZXbBII33QnArigmX9woIy46SxfI0lHRUDPrgLN33ptyeSVMFYyzclaElf/oPPHV/6T5XWgZvuHF48lgStAmqE3rlr+MOLJg7M6Q7Ms0qNPKxSkWwDNTySKOWJYFV1eZbouH3dRHckpXV+VQS3vmsedDArvT/6/oCpIzFfTnrPsseNpl2LpDyUffQWbQUE1J5qVWm2flawXAPllYQ3dB4zvKTWLtiMG1GITK5pwp3RMe2yICw8ZP4QRzMH6Jtvh2M00W9wYV+o6QjaEsobwt0CanxeFYrWFDrIzm35RpQ+j191X6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcWwtA5fuNvPZrpQxAFELbI9Qyw0J7X4ifFjanWSTGc=;
 b=ZruQtrXOw8VlahqctBtTbroXcP2q7Zhl82HqK7Uf11MrI6p1/oQo6Jjl8YOcYs30CNl4qSfo5h8O/q2DdZiGLfpgjmX/6xv2TxG6aFu6cgl1jxStNp0hmDEKClAr7Mkt/dsyCP8Ww4xhbjKItVz0jl7vCUFGsgFmOCjwb+lZtqI=
Received: from BN9PR03CA0085.namprd03.prod.outlook.com (2603:10b6:408:fc::30)
 by DS0PR12MB8041.namprd12.prod.outlook.com (2603:10b6:8:147::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Sat, 26 Sep
 2026 01:35:18 +0000
Received: from BN5PEPF0004698A.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::86) by BN9PR03CA0085.outlook.office365.com
 (2603:10b6:408:fc::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Sat,
 26 Sep 2026 01:35:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN5PEPF0004698A.mail.protection.outlook.com (10.167.245.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Sat, 26 Sep 2026 01:35:18 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 20:35:17 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Fri, 25 Sep 2026 20:35:16 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V0 00/21] accel/amdxdna: Kernel submission and PM for AIE4
Date: Fri, 25 Sep 2026 18:34:27 -0700
Message-ID: <20260926013448.3840921-1-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF0004698A:EE_|DS0PR12MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: 05ed9698-48f0-4045-9a2e-08df1b6e6bf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|10067099003|3023799007|6133799003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: HGtUSE7nb3BtEz8NywFD5rMOTCdr1PY6LMp8IzHfNk8wiPhcuRIqbiO9uNnfELUi+/oBqMEF/iinrQoMrBFXiBT5gUSqkMreFFOo2QCKSwzmy6P2zhAVNoq1yLoPqGZ9RBaOESMUSH/IEofkAIGCtNstEeFONfcVJxHP+/mvVLSA9aiygyk2UvMkGo5euvZ8DZf4X3F3kbvuICn1uptzhTB0YXh32AqX8uz5bZRjp3sOXWX8XqGR/U/RJxhLdBoZHxFqwQE2LvlKV+7RcGrTyRO/wugRVpf0m2peSIieD0k4iqnlwzZHmv2C+yoh5aeO2bNllNcGfSVVj2lrpzOVu1lcaIjjjufHbMH2rl+j46fG+5ijoAaHyMb5EYmj7c/2Z1eX3U4JPWGAVooLWwzOGjBoKrmra/p54ygQFqgVLDog/q6Ys/PWLadGmMpgd4BM9ho058hwFE7E80rqbmonjajNXgqrSeKbLZQHFctt1nPqENa+MlcjnuYGL6K7tf6AZG4pYwPPDESbSdUPhZBfiNzjDoPz6ZIDk6TiuWtmDAZ+TOCvg2Jjc+L++iXwZpXbyHWcHE3P/m/VALTCdo3wnPcEJHS3do2XpRby7IfumNEZQNc7vKiw2WXCXRrC3PiqeeicZhTJOfI/Zf+UHtUAxnWOZG7jeybaIbKqHdCEKjDCLPWrDVv+2l5c1jI85gimnD6me38Ac1sJVKfzzj2VMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(10067099003)(3023799007)(6133799003)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FfimWliRp31GZaRMASc4Mj29Mo60CjS9NI0dP4f5mK7JfUo+Ci1nffD7c832RBHxEqm/fc7pHPB5cZ6Gm2WSB9fow2JXzSl737e6+jPwfDsme+42Nx5kOel04cQJh4Cmn2xockrajExw2ff0cypxu1AxolnmlbHDrpL4qE8IXNvJIyNBkghIahOuZg3bnQaQYoBqQpU0fL4a05wgdOda4vaOYhwLGJgviiZ2J+BerJJh190364z9HFdkggcA3GPXz8kFOhqwKn9rrHfAU6W+tUCPUgb5fZQZClTnC89bqCiVo1aFyHArNIZC5A9Ac6LrSI4UkrFo8yg39/Q9aYohJK/2wWc0Y7g7mu2LTGyQ9Ipz1IlGL6VAA8HUdDcfWjMTTfsY8ZKN1BE8m4fxGszY/UQ/Vhh01Q1HH/+KqAtTSvRrk47unFRFtnGLOhVQmFwh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2026 01:35:18.0764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ed9698-48f0-4045-9a2e-08df1b6e6bf0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN5PEPF0004698A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8041
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

This patch series extends the amdxdna accelerator driver to support
AMD AIE4 (NPU3) platforms with kernel-mode command submission (KMQ),
device telemetry queries, comprehensive system and runtime power
management, and NPU3 classic device support.

Previously, AIE4 devices relied on userspace doorbell mapping for command
dispatch. This series establishes kernel-mode submission as the default
execution path, providing robust fence management, BO reservation
locking, and queue lifecycle handling. Additionally, it implements full
system suspend/resume and runtime power management across Physical
Functions (PF), Virtual Functions (VF), and Classic devices, along with
SR-IOV PM dependency linking and userspace runtime compatibility stubs.

Series structure:

1. Firmware Interfaces, Versioning & Compatibility (Patches 1-4)
   - Patch 1: Rename NPU3 firmware filenames to match official release
     binaries (npu.sbin, cert.sbin) and declare MODULE_FIRMWARE().
   - Patch 2: Remove userspace doorbell mmap and default to kernel
     submission with invalid doorbell offsets for user contexts.
   - Patch 3: Add CERT (Column Enternal Run Time) firmware version
     queries and protocol validation (aie_check_cert_protocol) before
     upgrading queue layouts.
   - Patch 4: Upgrade firmware interface version to 6.0, updating host
     queue layout, opcode definitions, and hwctx creation requests.

2. Device Operations, Telemetry & Power Modes (Patches 5-9)
   - Patch 5: Add NPU3 classic device operations (aie4_classic_ops) and
     register definitions, managing SMU/PSP firmware symmetrically, and
     remove unreleased device IDs 0x1B0B and 0x1B0C.
   - Patch 6: Expose AIE and NPU firmware versions via GET_INFO ioctl.
   - Patch 7: Add power mode get/set support via GET_INFO and SET_STATE.
   - Patch 8: Restore cached user power mode overrides on hardware start
     so overrides persist across PM cycles and firmware reloads.
   - Patch 9: Add clock metadata, DPM frequency table initialization,
     and hardware resource info queries, generalizing DPM tracking
     across AIE generations in struct aie_device, with independent
     clock domain level handling for AIE compute and host clocks.

3. Hardware Initialization & Transport Hooks (Patches 10-12)
   - Patch 10: Add context switch hysteresis configuration with debugfs
     control (ctx_switch_hysteresis_us) applied on hardware start.
   - Patch 11: Refactor AIE4 hardware initialization sequence into
     distinct modular phases (query_fw, config_fw, setup_aie) across
     PF, VF, and classic devices.
   - Patch 12: Decouple PCI doorbell and MSI-X notification transport
     hooks from transport-neutral context management code.

4. Kernel-Mode Command Submission & Fencing (Patches 13-16)
   - Patch 13: Implement kernel queue lifecycle, job workqueue, and
     memory layout for kernel-mode submission.
   - Patch 14: Fix fence timeline name (dev_name() to prevent UAF after
     context destruction) and allocate unique fence context per job to
     prevent evicting fences in shared BO reservation objects.
   - Patch 15: Prepare command submission structures, smp_rmb ordering
     for read index updates, and asynchronous disconnect/reset checks.
   - Patch 16: Implement full command packet building (direct/indirect
     packets), BO reservation locking and fence attachment matching
     AIE2, queue slot waiting, context reset recovery, and
     aie4_hwctx_wait_for_running() to safely quiesce worker threads.

5. System & Runtime Power Management (Patches 17-20)
   - Patch 17: Fix runtime PM deadlock on device removal by finalizing
     RPM before acquiring dev_lock, and symmetrically initialize RPM
     during probe across all device types.
   - Patch 18: Implement system suspend and resume for PF, VF, and
     classic devices, draining in-flight jobs, restoring contexts, and
     re-linking VFs.
   - Patch 19: Link SR-IOV VFs via device_link_add() to ensure the PM
     core suspends VFs before the PF and resumes the PF before VFs.
   - Patch 20: Implement runtime suspend and resume support for AIE4
     and AIE2, validating active VFs on PF and handling independent VF
     runtime power states.

6. Userspace ABI Compatibility (Patch 21)
   - Patch 21: Add a stub hwctx_config callback returning 0 to support
     the DRM_AMDXDNA_CONFIG_HWCTX ioctl, enabling userspace validation
     runtimes (such as XRT GEMM tests) to run unmodified.

Testing:
- Tested on AMD AIE4/NPU3 hardware in both classic and SR-IOV (PF/VF)
  modes.
- Verified kernel-mode command submission with direct and indirect
  execution packets under concurrent workloads.
- Verified system suspend/resume (S2idle/S3) and runtime autosuspend
  cycles during idle and active command submission.
- Verified SR-IOV VF binding, execution, and PM dependency sequencing.
- Confirmed no regression on existing AIE2 devices (NPU1/NPU4).

David Zhang (21):
  accel/amdxdna: Rename NPU3 firmware files
  accel/amdxdna: Remove mmap for doorbell
  accel/amdxdna: Add CERT firmware version support
  accel/amdxdna: Upgrade firmware version to 6.0
  accel/amdxdna: Add NPU3 classic device support
  accel/amdxdna: Add AIE version query to aie4_get_info
  accel/amdxdna: Add get and set power_mode for AIE4
  accel/amdxdna: Restore power mode override on AIE4 hardware start
  accel/amdxdna: Add clock, DPM frequency, and resource info queries for
    AIE4
  accel/amdxdna: Add context switch hysteresis with debugfs control
  accel/amdxdna: Refactor AIE4 hardware initialization sequence
  accel/amdxdna: Decouple AIE4 doorbell and MSI-X notification transport
    hooks
  accel/amdxdna: Implement AIE4 kernel queue lifecycle and memory layout
  accel/amdxdna: Fix fence timeline name and context allocation
  accel/amdxdna: Prepare for AIE4 command submission
  accel/amdxdna: Implement AIE4 command packet building and submission
  accel/amdxdna: Finalize runtime PM before acquiring dev_lock on
    removal
  accel/amdxdna: Implement AIE4 suspend and resume
  accel/amdxdna: Link SR-IOV VFs for power management sequencing
  accel/amdxdna: Implement runtime suspend and resume support
  accel/amdxdna: Add stub hwctx_config for AIE4

 drivers/accel/amdxdna/aie.c             |   45 +-
 drivers/accel/amdxdna/aie.h             |   45 +-
 drivers/accel/amdxdna/aie2_message.c    |    4 +-
 drivers/accel/amdxdna/aie2_pci.c        |   65 +-
 drivers/accel/amdxdna/aie2_pci.h        |   39 +-
 drivers/accel/amdxdna/aie2_pm.c         |   10 +-
 drivers/accel/amdxdna/aie4_ctx.c        | 1083 +++++++++++++++++++++--
 drivers/accel/amdxdna/aie4_host_queue.h |   79 +-
 drivers/accel/amdxdna/aie4_message.c    |  216 +++++
 drivers/accel/amdxdna/aie4_msg_priv.h   |  137 ++-
 drivers/accel/amdxdna/aie4_pci.c        |  812 ++++++++++++++++-
 drivers/accel/amdxdna/aie4_pci.h        |  138 ++-
 drivers/accel/amdxdna/aie4_sriov.c      |  104 ++-
 drivers/accel/amdxdna/amdxdna_ctx.c     |   29 +-
 drivers/accel/amdxdna/amdxdna_ctx.h     |   22 +
 drivers/accel/amdxdna/amdxdna_debugfs.c |    3 +
 drivers/accel/amdxdna/amdxdna_pci_drv.c |   53 +-
 drivers/accel/amdxdna/amdxdna_pci_drv.h |   18 +-
 drivers/accel/amdxdna/amdxdna_pm.c      |   35 +
 drivers/accel/amdxdna/amdxdna_pm.h      |    4 +-
 drivers/accel/amdxdna/amdxdna_sysfs.c   |    2 +-
 drivers/accel/amdxdna/npu1_regs.c       |   19 +-
 drivers/accel/amdxdna/npu3_regs.c       |   99 ++-
 drivers/accel/amdxdna/npu4_regs.c       |   30 +-
 24 files changed, 2805 insertions(+), 286 deletions(-)

-- 
2.34.1

