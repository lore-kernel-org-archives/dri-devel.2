Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B185CA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 04:22:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D9C710EF6F;
	Tue,  6 Oct 2026 04:22:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eCqciN8B";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012050.outbound.protection.outlook.com [40.107.209.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B4A610EF6F
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 04:22:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mFmUH6VeBKXsKxp3CH3DaIFmIryLcIHpJyBY5Da4Yj+dJruTMC79nbaufPI2N2Y4aagjPQeZeIRs98kjCZgYQlfni0pwn748AHIiiU19c+YV7/bRqaSBGyBHYWjB1QgRRGMyHBlIEOBQozxEmRmxpInHqQy2rTzn8dxwSQuwcKWQQ4+2PpsALQ6wkAJm0HGmVwvBXk6RYWS2pP9gO6Urkv3Pyanwx2i8F/tFgC8l/c4OXdDpwkzAfsPTeRqHd5GRvarAntLAaACWrq1d9Izaysd0NDyMZpdcaliUFoZy8P/0H0s3KZXPYSCAssi6cVLq4sBhSBesIKofPk5XzI5txA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnaBkrgtjPlPioPfICR0yA90Tn+DzgqS5hgoGxurvCc=;
 b=DWV9nMYWYieREGvUiOjC0wvihu1VhMGD/5/1D27Go6/jjWn9CWQ34tCskYcfp7+7J+x2H8TJWXcEVHoaroGVcByiwtX1O2Ck8NnUc/xn/UE1o8wJGk97hvgCRbEGvRVADNn/pW6XOBr8EYi9zv3UDEYLPJidDL1aCSQ+n/Avxj/M5k3fYTnckjEpGwD1+gSMfGmeIGrI7lAtZRS0iBdsCyRv+suSDgUb7ZkPnFdib0dqdLteSMysMW0qKH5ADyFEZzvBewGspLpb2XYBw49o5jmRntmMZmh7aYDIAOrk+5VPafqJ8axbmwpdixTmuWnTULjNjXwWzhZx1TIojAvffA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnaBkrgtjPlPioPfICR0yA90Tn+DzgqS5hgoGxurvCc=;
 b=eCqciN8BR7hRBqV4V/50wQcRLzNIWr6vtHuCvm7ZxnEcgoDeeomPBBcgsvYDYbC3bbxAAhab9JfjILttyRUnOeAMwkLvf08+oJma9/FrdmiTu4I9iXWkLJxRMFN4+Gz/TTfjLmWqZ80WfU+bsFTrPhoBX69GyagUDusljKdcFEI=
Received: from BN0PR04CA0153.namprd04.prod.outlook.com (2603:10b6:408:eb::8)
 by SA0PR12MB7075.namprd12.prod.outlook.com (2603:10b6:806:2d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Tue, 6 Oct
 2026 04:22:47 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:eb:cafe::a5) by BN0PR04CA0153.outlook.office365.com
 (2603:10b6:408:eb::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 04:22:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 04:22:46 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 23:22:46 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Mon, 5 Oct 2026 23:22:45 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V2 00/20] accel/amdxdna: Kernel submission and PM for AIE4
Date: Mon, 5 Oct 2026 21:22:10 -0700
Message-ID: <20261006042230.547807-1-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|SA0PR12MB7075:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e5cc9e7-d828-4247-960d-08df23617994
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|11063799006|56012099006|10067099003|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: e7MPBOaNa7BlV0ouSDelNh6IDGyfeeTqxnAeAlSfXgMtabZwmugT1C/70gHXhf7r9jdZUhkUooMkxm/EWnp7QMKSQ0fWHfuN2WQmwgMEJpFGs6gSyYJQFjeTxvi8H5XWWYiiTDb4kMrpW17nRCmaL1D0u95TXKxR14aufm2GpomnpOnIzhZc/j9BQzhGez5/nynhu2y1gCA2YTCOKLFlhGKky1kG4ukQRMpE2LjrMK9PGT0zr01FpilX7boy1QHbxtLno8rzQDiseLEZQq4iKKvYee51ZFCaonkQ8GihKO+MW1PDOWXy+ypfNNldFliB2xP8P5pBzalmIbL0pAQEkHXvQ/Cv9d5h5Qu6MqsrD1piSYyrAQfSXnIXsiCkOWuWIwRgrQXcrO3aufeG9GttQDlzj/lSjQZ+vB1zH/F3yNUqxrNdGqWxxEkJdioDNq1ETAyRIZqOhYXKRFPdHwZYwdCFJ1f2JAHmaxHb0ulvzsnn3Jyd/GhppyIWxTtPTRsAngiVc0dc0KaXR2g4OZFs23Czt7WVG2u1OFo4Bxrx5sTD+F5cP2QddTe2yvaBS8io56M9SMG4vTdDzVGt/e0z2+agp4aoENUsJmggWlJVR2mcqDK96piCkXk3poeG4niRW/ck4YK4NtDqBE6NC3SpGC4b+l0VUsT6Ox2qxZ1MqOch4QC+5cQkoC6Mov73fgAjLtGEO9MTccHcc2V39S6PUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(11063799006)(56012099006)(10067099003)(3023799007)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gLvWbQOGuC1THJyp6UoAXl8Pj2Ik4f3OI9JE1d1jkvrnqJDiBVF76RHhkPz6rK+0EAirmVcuLpeFq7+LWJqngMB4ymPQhhm5Aq4nHLsdba0srE6ArO5QB51uQcnf+X2wj0sS+1GyKhsaEH31BXWUcKx0mNCnN3un8RqZh9LEQ7wBtqJ6SN2N1Njr0fhnWOpX5ptFuUCnelj0xFsBXlhCh+8LgyM1LNoNt62bI5yfrSOqNGYko0os1TwtImMZCHECNU0PlxhvqIHJM3IkxTfzdrOIQ0Ywm1mYKR/1M/Uazn4MmGh3UESXLQSrxUfu/HNi/RaXisCIVPFJzm3PxhaQ/wCJclTfzfahw8KxZ+PKHSXvR7JZ0g/nEJgnJOARw+9jEaXXGUoIjp3fUqbDv6aXX4dIv49oB9mFRcUhxv6RoCBY7G6HeJRD18GHiGzio8JV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 04:22:46.8058 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e5cc9e7-d828-4247-960d-08df23617994
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7075
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
kernel-mode command submission (KMQ), and system and runtime power
management.

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
- Keep the last valid read_index cache lockless and document why a
  stale value can only delay, never falsely report, a completion.
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
The patch layout is unchanged since v0; see the v0 cover letter for a
per-patch overview.

Testing:
- Tested on AMD AIE4/NPU3 hardware in both classic and SR-IOV (PF/VF)
  modes.
- Verified kernel-mode command submission with direct and indirect
  execution packets under concurrent workloads.
- Verified system suspend/resume (S2idle/S3) and runtime autosuspend
  cycles during idle and active command submission.
- Verified SR-IOV VF binding, execution, and PM dependency sequencing.
- Confirmed no regression on existing AIE2 devices (NPU1/NPU4).


David Zhang (20):
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
  accel/amdxdna: Implement AIE4 command packet building and submission
  accel/amdxdna: Make hmm_invalidate common for AIE2 and AIE4
  accel/amdxdna: Finalize runtime PM before acquiring dev_lock on
    removal
  accel/amdxdna: Implement AIE4 suspend and resume
  accel/amdxdna: Link SR-IOV VFs for power management sequencing
  accel/amdxdna: Implement runtime suspend and resume support
  accel/amdxdna: Enable AIE4 firmware logging to DRAM

 drivers/accel/amdxdna/aie.c             |  63 +-
 drivers/accel/amdxdna/aie.h             |  47 +-
 drivers/accel/amdxdna/aie2_ctx.c        |  15 -
 drivers/accel/amdxdna/aie2_message.c    |   4 +-
 drivers/accel/amdxdna/aie2_pci.c        |  67 +-
 drivers/accel/amdxdna/aie2_pci.h        |  40 +-
 drivers/accel/amdxdna/aie2_pm.c         |  10 +-
 drivers/accel/amdxdna/aie4_ctx.c        | 995 ++++++++++++++++++++++--
 drivers/accel/amdxdna/aie4_host_queue.h |  72 +-
 drivers/accel/amdxdna/aie4_message.c    | 244 ++++++
 drivers/accel/amdxdna/aie4_msg_priv.h   | 149 +++-
 drivers/accel/amdxdna/aie4_pci.c        | 836 +++++++++++++++++++-
 drivers/accel/amdxdna/aie4_pci.h        | 125 ++-
 drivers/accel/amdxdna/aie4_sriov.c      | 118 ++-
 drivers/accel/amdxdna/amdxdna_ctx.c     |  25 +-
 drivers/accel/amdxdna/amdxdna_ctx.h     |  28 +-
 drivers/accel/amdxdna/amdxdna_debugfs.c |   3 +
 drivers/accel/amdxdna/amdxdna_pci_drv.c |  63 +-
 drivers/accel/amdxdna/amdxdna_pci_drv.h |  19 +-
 drivers/accel/amdxdna/amdxdna_pm.c      |  35 +
 drivers/accel/amdxdna/amdxdna_pm.h      |   4 +-
 drivers/accel/amdxdna/amdxdna_sysfs.c   |   2 +-
 drivers/accel/amdxdna/npu1_regs.c       |  19 +-
 drivers/accel/amdxdna/npu3_regs.c       | 105 ++-
 drivers/accel/amdxdna/npu4_regs.c       |  30 +-
 25 files changed, 2804 insertions(+), 314 deletions(-)

-- 
2.34.1

