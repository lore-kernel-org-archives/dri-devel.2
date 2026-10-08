Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249D1CA6007
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 03:24:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E2CD10E532;
	Thu,  8 Oct 2026 03:24:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zqzeyUSc";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012031.outbound.protection.outlook.com
 [40.93.195.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D23BA10E532
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 03:24:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t29MpEboTozKMp41v2kpxv1tAVqnLiyIjkboi/OiJ0/hIJe4RDsavx07+BBb7vvGhE5v2qN4sFyazsRHFTV0U1prwpiGVRMuTdr1/nSGnysKuhroxH2KMQcKTLoP69MzPAT6UsmVjDJSsQv55oVq7pFDtSjukJOn2Phv5WAGFJjH674bNd4fO6Rl9T7aDFZN40eG6ZKohvIbfYs9k0DFaLWAWfHr0ZNQBF9q7+UfrB9Y9bdsoLk1ZpbiLA8VWQgmgDBYSmEF8Jvni3GooUUKHYU/HFjLAC5EOaTjxp+SQ92WZ9OsH11gW0b9NKXYgsWzoWHvmWKUfl77WCcO6mraIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjfsCyUEC8P6ZnUl0oiPyVCQQ8kPsuHy5B8BYM8eW80=;
 b=UjOPRzF6o3/6gMx03AgI9PuOOqNKVVHpvLivniy4UKCy7xqD3XOrffXRo9uPzihQOdT3/B2uOaU6CL+9IFlbnMsWWOXJxlK4Zw/aiKP3fvzV7ctBqXiJpwk00pu5pottDjoQEtN+2g0AQkt0sBbRXGTw7m4NaiDl1J/cn2xBw2je7biCLvA0SS4tDO4I+SEdBsJW54Xy3NkFZiyuXcKVN3JZgYK/Yff41JqzEfDqiQ1gHj9Lti1KiZ6y1XxV8Mq3z/ZcnjTBEEpd/iBJpaguMxFsHpQlSljMaT4swJFKSRWDINGgEZMbxrT/Ctx8AoeHtGd38SlRw4iIOLm7eIPFEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjfsCyUEC8P6ZnUl0oiPyVCQQ8kPsuHy5B8BYM8eW80=;
 b=zqzeyUScs6PnUEUmer5Ye6l+DVrukkk68hDrq0gLwE+VInan/LgxZe31Xsd7raqIlmCLj9TfaRnMOuuTJfXuuWQHYhlknLyVkeyiC8pdks4S0mSEynsZSJzm+TI/XTwXK5itINGK2RP9tDlStohxVTXJVpiQEMxAsYk+MO5hhYY=
Received: from PH8P221CA0061.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::17)
 by PH0PR12MB7887.namprd12.prod.outlook.com (2603:10b6:510:26d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 03:23:56 +0000
Received: from MW1PEPF0001615D.namprd21.prod.outlook.com
 (2603:10b6:510:349:cafe::a3) by PH8P221CA0061.outlook.office365.com
 (2603:10b6:510:349::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 8
 Oct 2026 03:23:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MW1PEPF0001615D.mail.protection.outlook.com (10.167.249.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.3 via Frontend Transport; Thu, 8 Oct 2026 03:23:56 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 22:23:54 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 22:23:54 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Wed, 7 Oct 2026 22:23:53 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V3 00/19] accel/amdxdna: Kernel submission and PM for AIE4
Date: Wed, 7 Oct 2026 20:23:29 -0700
Message-ID: <20261008032348.2044667-1-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615D:EE_|PH0PR12MB7887:EE_
X-MS-Office365-Filtering-Correlation-Id: 39ac30f6-2dca-450c-1eba-08df24eb960b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: j/S00cQq3SVoMJrF0xIIy6zDmC3/Mbv4PWU5jquwdeewMtTbMO3ebY0Q7xNhL80wVSHPr2JwaAiU7KzN10DdWsgSk49tjiBLQWbUqIwJXTy9VBxykYVekC3w6A7d8SvQzxFZOHXNEHPssfMwxaNaCFEWWmOJsFM6QR4btGZ+N+Td82vtuaBg5FItxvoOQYthWlhWQMBgtEHwA8zL/61vVdHBLkBqbZ0ZLW6W8bYMHaR6iceVKNtDFlMJKP1EHOSQHcNxNWHMiw4QQU29nEUoeLJcqnv1CC8H9v6ZyNPwXqr2V3JoYgQDV0Oc5PtYhPusgy/gOgiQJueFUSegu1nmDkO7XPCBf41kiB7c1HYFwaBO1ZUwu8KpkVLE98Rsv2qFwe+qlhin1GQOw4ZJsvwN3UbZHDlcHpsMPyVQp/QdxAzux0DZ4PM4fSdVXymh6cpukv8zW4ee974KMPbrYFxCC/ujLT/maBzX5W9vggeeOsolOAfyZOrnrqpc1w3zFl9LQzIl3wR1tLXX0GYjtOd7fLDMoUByZlu96nK+vbMYcaOZ3fT5A58y2afLUtaB6iHtyQT0r2tZ/fVDdg9Jv6LVJytZx70Tsd9HJkic7T6vBqMXzYvTEMNFSCN657BFe649Y76wVnlSShipqIjm8ryTeGFNs5rRmeSyjP9UZ+qU02SzFMoo96klj57xo/o1UR1BTlOIf/nl+0CETRKU0bgoPQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tPvZS43Em1NykE4lOcsApDkJGVExcyw9ByL547DKjH2eECT2m5ux3QBfeJa1zUVgmzbUuBogLGCLE8shr+BbUb4crO2bJup1d6I49X+z3MvPDV6CBHvdw0HULt72btOC2GDPjogg06HGqrlsHsbaNZX8FrFtVzXbDHAYi2jfIFcq5oUOLltISv4neqs1hPOVcjTTCePtuXPwJ8XJtJYOf0u2L8KzwLkPotYDQR4Wh1BGsLnFAMNM2eRzbZ9BOW9tRJGwJ8rIWVayUP31nNbEJbSnAoIzKbSsBLOt85yqkKqWbqb+xJUCiuP08g1ch4Na/1cwqQCcxERlunefLa/edWQO5eUfkzTxG4hgzYDGyPxyO+wUEd4zzf7335VypsfNcNsHkIALaWBAI04MqauHeRWhRQH7Yje/bs7AdBPf4bD3DhedyT29eBl8VtRao3OX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 03:23:56.1779 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ac30f6-2dca-450c-1eba-08df24eb960b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7887
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
AMD AIE4 (NPU3) platforms, including classic and PF/VF for SR-IOV with
kernel-mode command submission (KMQ), system power management, and
runtime power management for the classic device.

Changes in v3 (addresses v2 review comments):
- Lock, check and fence chained sub-command BOs with the job BOs,
  since the NPU writes completion to command BO headers.
- Use the validated payload pointer in submit_one_cmd() to fix a
  TOCTOU on the user-writable command header.
- Drop the last_read_index cache; get_read_index() returns 0 when
  read_index is still invalid after a re-sample, so callers treat the
  command as incomplete and keep waiting.
- Align the runtime config message buffer to 4 bytes.
- Move the HMM invalidate wait and populate_range into common GEM
  code, and repopulate invalidated user mappings in AIE4 command
  submission instead of failing the submit.
- Drop the patch that finalized runtime PM before taking dev_lock on
  removal; the PCI core keeps the device active during remove, so
  there is no deadlock.
- Use a stateless PF/VF device link, folded into the suspend and
  resume patch, so it survives VF driver rebind such as vfio-pci.
- Return -EBUSY from runtime suspend when a device has no
  runtime_suspend callback, so the PM core keeps it active.

Changes in v2:
- Drop the redundant cert_feature_table configuration.
- Call aie4_partition_fini() when aie4_restore_power_mode() fails, so
  the partition is not leaked on hardware start failure.
- Return -ETIME from best-effort firmware configuration steps, so a
  mailbox timeout fails the probe instead of letting it succeed with
  unresponsive firmware.
- Fix a synchronize_srcu() deadlock in context teardown by stopping
  the hardware context and waking all waiters before destroying it.
- Use READ_ONCE() for read_index and for fields read from user-shared
  command buffers, so checked values cannot change after validation.
- Check that cert_comp is still linked in all command wait paths, so
  -EAGAIN is only returned on a real disconnect.
- Check that trace buffer addresses fit within 48 bits, as required by
  the current CERT design, instead of silently truncating them.
- Hold references to chained sub-command BOs until job release, so
  userspace cannot free a BO while hardware may still access it.
- Document that job fences are signaled when submission fails or the
  hardware context is stopped, destroyed or suspended, and that job
  timeout detection and recovery (TDR) will follow in a separate
  change to guarantee the fence signaling in finite time.
- Address use-after-free comments on fence dev_name().
- Abort hardware contexts when resume fails to start the hardware,
  so submitters waiting for a context to reconnect fail instead of
  blocking forever.
- Document that VF driver rebind requires re-enabling SR-IOV via
  sriov_numvfs, which recreates the PF/VF PM device links.
- Add pm_ptr() wrapper to fix the build with CONFIG_PM=n.
- Remove hwctx_config for AIE4; use-after-free cases in the debug
  buffer handling need more work.
- Detect VF passthrough by comparing against the PF driver instead of
  the module owner, which is NULL for built-in drivers.

Changes in v1:
- Firmware version 6.0: return IOMMU_PASID_INVALID from aie4_msg_pasid().
- Power mode: consolidate cached power mode override restoration on
  hardware start directly into the power mode introduction patch, and
  respect user buffer size.
- Transport hooks: fix header include to use <drm/amdxdna_accel.h>.
- Command submission & fencing: fold fence timeline naming and unique
  timeline context allocation into the command submission patch.

Series structure:
The patch layout is the same as v0 except for the v3 changes above;
see the v0 cover letter for a per-patch overview.

Testing:
- Tested on AMD AIE4/NPU3 hardware in both classic and SR-IOV (PF/VF)
  modes.
- Verified kernel-mode command submission with direct and indirect
  execution packets under concurrent workloads.
- Verified system suspend/resume (S2idle/S3) during idle and active
  command submission, and runtime autosuspend on the classic device.
- Verified SR-IOV VF binding and execution.
- Confirmed no regression on existing AIE2 devices (NPU1/NPU4).


David Zhang (19):
  accel/amdxdna: Rename NPU3 firmware files
  accel/amdxdna: Remove mmap for doorbell
  accel/amdxdna: Add CERT firmware version support
  accel/amdxdna: Upgrade firmware version to 6.0
  accel/amdxdna: Add NPU3 classic device support
  accel/amdxdna: Add AIE version query to aie4_get_info
  accel/amdxdna: Add get and set power_mode for AIE4
  accel/amdxdna: Add clock, DPM frequency, and resource info queries for
    AIE4
  accel/amdxdna: Add context switch hysteresis with debugfs control
  accel/amdxdna: Refactor AIE4 hardware initialization sequence
  accel/amdxdna: Decouple AIE4 doorbell and MSI-X notify transport hooks
  accel/amdxdna: Implement AIE4 kernel queue lifecycle and memory layout
  accel/amdxdna: Prepare for AIE4 command submission
  accel/amdxdna: Move HMM invalidate wait into common GEM code
  accel/amdxdna: Make populate_range common for AIE2 and AIE4
  accel/amdxdna: Implement AIE4 command packet building and submission
  accel/amdxdna: Enable AIE4 firmware logging to DRAM
  accel/amdxdna: Implement AIE4 suspend and resume
  accel/amdxdna: Implement runtime suspend and resume support

 drivers/accel/amdxdna/aie.c             |   45 +-
 drivers/accel/amdxdna/aie.h             |   45 +-
 drivers/accel/amdxdna/aie2_ctx.c        |   90 +-
 drivers/accel/amdxdna/aie2_message.c    |    4 +-
 drivers/accel/amdxdna/aie2_pci.c        |   64 +-
 drivers/accel/amdxdna/aie2_pci.h        |   40 +-
 drivers/accel/amdxdna/aie2_pm.c         |   10 +-
 drivers/accel/amdxdna/aie4_ctx.c        | 1067 +++++++++++++++++++++--
 drivers/accel/amdxdna/aie4_host_queue.h |   72 +-
 drivers/accel/amdxdna/aie4_message.c    |  244 ++++++
 drivers/accel/amdxdna/aie4_msg_priv.h   |  149 +++-
 drivers/accel/amdxdna/aie4_pci.c        |  807 ++++++++++++++++-
 drivers/accel/amdxdna/aie4_pci.h        |  117 ++-
 drivers/accel/amdxdna/aie4_sriov.c      |   66 +-
 drivers/accel/amdxdna/amdxdna_ctx.c     |   25 +-
 drivers/accel/amdxdna/amdxdna_ctx.h     |   28 +-
 drivers/accel/amdxdna/amdxdna_debugfs.c |    3 +
 drivers/accel/amdxdna/amdxdna_gem.c     |   83 +-
 drivers/accel/amdxdna/amdxdna_gem.h     |    1 +
 drivers/accel/amdxdna/amdxdna_pci_drv.c |   46 +-
 drivers/accel/amdxdna/amdxdna_pci_drv.h |   20 +-
 drivers/accel/amdxdna/amdxdna_pm.c      |   34 +
 drivers/accel/amdxdna/amdxdna_pm.h      |    2 +
 drivers/accel/amdxdna/amdxdna_sysfs.c   |    2 +-
 drivers/accel/amdxdna/npu1_regs.c       |   19 +-
 drivers/accel/amdxdna/npu3_regs.c       |  105 ++-
 drivers/accel/amdxdna/npu4_regs.c       |   30 +-
 27 files changed, 2832 insertions(+), 386 deletions(-)

-- 
2.34.1

