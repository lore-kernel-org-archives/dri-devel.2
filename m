Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BEE0CA9EBB
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 22:53:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE32E10EB6A;
	Fri,  9 Oct 2026 22:53:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u/rVD50r";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010055.outbound.protection.outlook.com
 [52.101.193.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CABE10EB64
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 22:53:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UfNA3KrDY/Z12k9jTqwIq8rxtbLegj9ej/jSrPL2EQgWxLanMP9GqBhIZ6AeXe0717OyExI+h78WQ/yQsIlZEZwEsC8ohmSAi1jjfdedBreR1WxjSTo42VlUCIDr4tYG632WANoHg1DsZUwpjsN9OCXyc1P2LdDTrEA7aFb3SowLv1Vu46owsTJpt2heeJJ73dgH6rcFA/O6muKk2GnF33fKAucdEj9fk5sxpSiv0UZ3UV7GzMTos0wFwvstbGQIRGuNKpn7yURz+R+4x4/zLPWthYRwEWQUN749bHx3aHRhNksYBBRNCZprXWdTtymOCP+Xj268rxw7a4wI7YX6OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4VLWhbwSKFvkfAs3w+oqa0poHDfh9pnUrQz6fPJHcM=;
 b=VYIkMnM/DCPi4gfUuNYUhr2cVWFfptysFsIY4PKlae8QjswRd4ZZzqkwcUu36NDuZ/n9lwATWauIPuw2fD8KhK2ssacIO9WBWwcZ87VsUK9i+HdurDNR9nZvJUIGBR+SnwBYzAdojQaPWEv3AhEVV7sC2RYNxsEJor6acn+nylhy4QaLPVo8pxxuUJD/AHbqX2Pwd4LeQR8V6CWBaZFaIX+zshCSfFg9jUV079uByFosLx01xZdEe/mThVeXZLi4TiXx5L25ghc7jeniko7ksfZXoVHk6rGAE+zcL2QQrjmHVvN6LE5zxLkb8maZ51Ml7xqkHziqhDGLN+WpdRHRIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4VLWhbwSKFvkfAs3w+oqa0poHDfh9pnUrQz6fPJHcM=;
 b=u/rVD50rEOWBqH6ED6rBWrl0lOJdje5M0LeWSCYu2FdKpD01BDaLwhMfH+kBvrEi49Fi4j7wcMkB5PKIrlBgzjYMqzKFfOm+XSS9unLezgaJ18eoYEc9ACColfkFnAIDmoBiSfWmZaQ4ctPM92hc2vetrhpRm+/94dRXA6EBWFI=
Received: from BL1P222CA0026.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::31)
 by SJ2PR12MB7895.namprd12.prod.outlook.com (2603:10b6:a03:4c6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Fri, 9 Oct
 2026 22:53:50 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:208:2c7:cafe::23) by BL1P222CA0026.outlook.office365.com
 (2603:10b6:208:2c7::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 22:53:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.0 via Frontend Transport; Fri, 9 Oct 2026 22:53:49 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 17:53:42 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 17:53:41 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Fri, 9 Oct 2026 17:53:41 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V4 00/19] accel/amdxdna: Kernel submission and PM for AIE4
Date: Fri, 9 Oct 2026 15:53:24 -0700
Message-ID: <20261009225343.3079074-1-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|SJ2PR12MB7895:EE_
X-MS-Office365-Filtering-Correlation-Id: 85ee7540-38a2-4091-9647-08df26582eb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|3023799007|6133799003|18002099003|10067099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: YYSwEcXITt3nxMAAJGF22dbjk8Kv2GWpsFDsHnFNTmgdDHaUV96jUUgKhIA6AAqaX2jEidJk/QdukVKat/IOdEqYGeflwhyQe2Z4L6W5FifaxjtXq92lIB5mMSIrzB3g7SJlVHk2HMzVPfypxgNplFR4iV8o5D3sUArRAHI0kQg0lnedOreEkTdNcY0c8q633Zv7S8k9IG2nQjz+jfkDU5lVaTxsaaDJUFqCfY0pBPizYJ5OhrnUKNIVUV6pWOYN9cTYG1gdvv3GAur4Kcu6UfAfjPMDgQ+XZUDmv47FXXv4OV4h+CHcw4mJz+Wnj6aJrgLCdfd2trPt4+Wy76lEmoiUxChHLF+dW79eR3EPnKc3KDmCwExKBz48HIz0MYikZzi6GeURtLJ7GdDYkCU4+bhsvhaGsM40QCDhYYvpGk6lDy/pvh94bNBEpEkp9/UGCHcHUhok1+faeTc24tlLcM0DqtBLFDQ1ftKA3eMwdSDWzNFbLJbYH2mHo3rYK/SMVxx0NM0+VZ3hxGbPINYaEoAZxd4mmtBzgnQTEGm6K+8GwCKpVasRXKTbg5JrnCxg8geHAqT7D6Zc0OYUAFeuffU2al5WOGu7Q1LYGe8BHkTEF2uDszRWU9YJBfw2+lYVciFE2TB2HSZDxEF1QwUamwpu26CE2zJb8hmCOubv+PI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(3023799007)(6133799003)(18002099003)(10067099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JlErw3puGcD2Pr4c5S2uqXH3GuExmXy0ROWc3sIm68WJ+6a5YI0wW2n0rqbDD6VEW7ViYcKDKnlXNnJQqyKsbaqCQ03VcrLKPyjr0azixQzU6/cFZd3jm7FnJxI+Ic1pmaT306fKl6v0Zq/XOzSBW3sIT0Q+qbeqjxsjir/Cl2DZ/jgCckKFj06qtil98/D738Zfte2DepQKtKQtHQTM+mj/pvmiumsoygZkzAZZBsMkX8J7gSvoP+pLHY5JIZDANSQKVqw5zt+8XNujEwjoDw6Fk19frc2cu6YYzbgbTV8UNQp3o01URBNyREsz1/qS5/P+RxdrmhUxG1uLESq0EkSgtkMSCYwnUJf/pcxWxjVKm+sj/tKkwK0Xje0PsUbJ4aDtY8aRBGHzao36boJBtGCqaBXMmuK/2DKEgNVS9z4YgU/r6zkFPauNgXsct28q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 22:53:49.2207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ee7540-38a2-4091-9647-08df26582eb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7895
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

Changes in v4:
- Return -ENODEV instead of -EAGAIN from aie4_cmd_wait() when the
  context is in error, so waiters fail after a failed resume instead
  of retrying forever.
- Take a runtime PM reference in aie4_hwctx_init() so context creation
  does not send mailbox messages to a suspended device.
- Make the HMM invalidate wait uninterruptible, so a pending signal
  does not let pages be freed while the NPU may still access them.
- Record whether a command wait ended on completion or disconnect,
  so a context unlinked and relinked during the wait cannot report
  a false completion, and a torn read_index cannot stop the worker.
- Resume the device in the wait ioctl when the context is suspended
  by power management instead of returning -EAGAIN, and return 0
  for commands completed before suspend.
- Add a job timeout that stops the hardware context when a job does not
  complete, so job fences published to dma_resv are always signaled in
  finite time.

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
The patch layout is the same as v0 except for the v3 and v4 changes above;
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
  accel/amdxdna: Support firmware 6.0
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

 drivers/accel/amdxdna/aie.c             |   33 +-
 drivers/accel/amdxdna/aie.h             |   47 +-
 drivers/accel/amdxdna/aie2_ctx.c        |   90 +-
 drivers/accel/amdxdna/aie2_message.c    |    4 +-
 drivers/accel/amdxdna/aie2_pci.c        |   67 +-
 drivers/accel/amdxdna/aie2_pci.h        |   40 +-
 drivers/accel/amdxdna/aie2_pm.c         |   10 +-
 drivers/accel/amdxdna/aie4_ctx.c        | 1129 +++++++++++++++++++++--
 drivers/accel/amdxdna/aie4_host_queue.h |   72 +-
 drivers/accel/amdxdna/aie4_message.c    |  245 +++++
 drivers/accel/amdxdna/aie4_msg_priv.h   |  149 ++-
 drivers/accel/amdxdna/aie4_pci.c        |  814 +++++++++++++++-
 drivers/accel/amdxdna/aie4_pci.h        |  117 ++-
 drivers/accel/amdxdna/aie4_sriov.c      |   66 +-
 drivers/accel/amdxdna/amdxdna_ctx.c     |   72 +-
 drivers/accel/amdxdna/amdxdna_ctx.h     |   28 +-
 drivers/accel/amdxdna/amdxdna_debugfs.c |    3 +
 drivers/accel/amdxdna/amdxdna_gem.c     |   87 +-
 drivers/accel/amdxdna/amdxdna_gem.h     |    1 +
 drivers/accel/amdxdna/amdxdna_pci_drv.c |   46 +-
 drivers/accel/amdxdna/amdxdna_pci_drv.h |   20 +-
 drivers/accel/amdxdna/amdxdna_pm.c      |   34 +
 drivers/accel/amdxdna/amdxdna_pm.h      |    2 +
 drivers/accel/amdxdna/amdxdna_sysfs.c   |    2 +-
 drivers/accel/amdxdna/npu1_regs.c       |   19 +-
 drivers/accel/amdxdna/npu3_regs.c       |  105 ++-
 drivers/accel/amdxdna/npu4_regs.c       |   30 +-
 27 files changed, 2926 insertions(+), 406 deletions(-)

-- 
2.34.1

