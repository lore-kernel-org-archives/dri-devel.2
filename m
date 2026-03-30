Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB771061B17
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 16:37:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2423510E566;
	Mon, 30 Mar 2026 16:37:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n/D/kbv2";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010009.outbound.protection.outlook.com [52.101.46.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6502D10E566
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 16:37:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLafKV4T1GqUzIrIzk13NeWcvadzxbQBiF83LXbv+AOGPSItoKPP7pZFNKdOGFSaPeAkIKHgvEOJ/Vv2PAhI/r1usbsknUkpT6pEfpB7RauTK6QugggF1FMgH+zFheCz4+nGC4zCnApS0lzCDJDC6eSslsG8qZu8cqYMxb2kIfvxX0i8OR656AqBVqB0z3I1RPcL15ldCCypKUvEJhcjhprEqWkRnGK5Jwtb9gbdZo6R5khxrF9DP1fdsbRv+LAHckQyTPbVSP8rbvlTXPzy2fBE8dzQF95oRnRCww1NXwQ928SKVeygj9wcbbY1H9W7s8TcQLd4V2NlWcZ0anwgyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcfYiwGOXaipEHVr7vU7LIq43IMEREHfaUZVu4iFroU=;
 b=MsXDnoACtxMTDX5PIL/2ODZuZMsZ0ivhXWi+PFRtO0kX6DrOW8w6hS90EQpl2lxS1QYGmfx0JRpzHCmHu2Bhr1KQSE+/nOv0Lt+5IB7lXcmlBLL2uGdsYEYubzoTqP8kJDcpqtXreUuYADWsCaAUOyfLHjKMzYlDBbyCzjPOX1BB4Si6PrGCOgUoXUyrlTq4uUWH80eHvTwXklw6RPe3W+kAQ8FtICY54tdEwq/NFZ21UtCIxwgoS5bskTnRrXOWDPknoHrgqGcHG5+nreVTXbLIES7To9XZhrKy2zlu2jDhGMMrGoCL02226OfG+o/9z1qOlp2qhlbsxpB3k/HWTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcfYiwGOXaipEHVr7vU7LIq43IMEREHfaUZVu4iFroU=;
 b=n/D/kbv2L3mYo7tXVngVPGG0zA9xCJD/jbdrvJ5R/ewLo5krN7WVbRbiQGW2NPPGtvvqZAAt9s7LUukrRA0N0D7aasqMnVsJUd38APV/QSNGO0lqP3n6u8J4KBH7e7WXVqAs6oG3nfLEdDHpROMxJ4y6cOLiqV1N25OTQpefBFE=
Received: from SA0PR12CA0007.namprd12.prod.outlook.com (2603:10b6:806:6f::12)
 by DM4PR12MB7741.namprd12.prod.outlook.com (2603:10b6:8:103::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 16:37:15 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:6f:cafe::2b) by SA0PR12CA0007.outlook.office365.com
 (2603:10b6:806:6f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 16:37:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 16:37:15 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 11:37:14 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 09:37:14 -0700
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 30 Mar 2026 11:37:13 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <maciej.falkowski@linux.intel.com>
CC: David Zhang <yidong.zhang@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V1 0/6] accel/amdxdna: Initial support for AIE4 platform
Date: Mon, 30 Mar 2026 09:36:59 -0700
Message-ID: <20260330163705.3153647-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|DM4PR12MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: c9c38b2e-20b0-49b9-c1a8-08de8e7a99f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: n/78HbwBVCk3ix2WFolqg8Z4buABmJO0Tc105SswBYzzwsv/3H8FMPnCsTqIw9+iyRAcOeU5LSG3aNheq9bXEfRGRRHjvX17Db/uogLCGx+qQX7B16ii6uX70ZsVltCJK8eWhcr9s86dvsOy8xhnnpCtdkb1jJwYsPLAjABhyF3hjfgPJfoGP6QvcLuVMBuob2CRnwSUpebar+IERoEpOodmXyZ6JmV4nLBrBkSbAFZUE5PdtsXiq31Hh4x4bth2KnYkaDGy/POpWcRnT6gN94EGSsdmeb8ADycXuWduKKk2L0O6QKbKJ2ubbrVs70Puh9kR5KhABwq3Ku7YMyZ5RHolapzGOxENUtCWgh2qa0VVtu8XlbZFNm7bDRbw5NrffO8RwvRH7GWa3+UIgNssNsipZL5lF0dfQKkLsRQUIPRLAJif6AZtnjuIY/hVYes8aPcxE8+7d9GPo5H50onKwsBLNCJ89m+AZIguPuqWgG94BR0h6uEDJjCCb9v9jVGl2nuMCRtqiMPmyUywp/7gZSyEmfVndNxJ+/Cm2wHlXOMwx//DiyCGIwbVcxXIGpwh+q1Xc4QtJA36fmaI4KR/+92w6stqD7SU80irLT3dcJSBr1/+PJWFY9efiZczmGxdpNigaPCCFTCYTuB8X3n0YOyC+VA/bNEI2zEOOPJOIF4NA+CzOLqLF7HAMMKkbk5xCfjSzQodSABVXDg1xyee5y7xllXSCnU6ETBFhA4IfpdPrHyQFkw+9b4pxDXwy/G4wom7dPvxuKfhlzGALvMZnw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: T4PF6jyZT/UuA+Ui0mQOYBddBz6M/1/Bbjzfld30VEO7u/Drtup3sKEbPczf5LfSgiO/kHylJ0YIj02nuX09KNvHpHRqEGjFLPAiw2w49tP/GujLUxG6tx6/Y0RO9qt7ZglQfmUUVOZELqFc+5mOXkbV41Ch7YR6Rt+Dy697Op9Vm+ja8bx63ZDz6hQ2NM5b5OrTBIE/SQOhUgt2Mzc5f1aLLvZm/1yg8m8WyZfxH70HldQqgwpHiPdV2El/MzKSZWlSyveaou13PV4mltkFsVlaVmrIbHjw/eRkv8B/r5GYfoUluuroxYIZ19gpRfQl3205+OTgKBIFda5eu01JK+YY6TTxaZiuRYAF2zRath5ozYpIq8u5BrDKeAYyUY+SvxDrQgLvfDZFAe4lhfwLDiKMhRkrFj5lXY5RMRxLxxqfeKld6kpUzymN2oRiTnyg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 16:37:15.2718 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c38b2e-20b0-49b9-c1a8-08de8e7a99f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7741
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

From: David Zhang <yidong.zhang@amd.com>

This series adds initial support for AMD NPU (AIE4) platforms, including
the Physical Function with SR-IOV support on PCI device IDs 0x17F2 and
0x1B0B (NPU3).

Support for SR-IOV Virtual Functions and non-SR-IOV configurations will
be added in future patches.

The AIE4 platform uses mechanisms similar to AIE2 for mailbox, PSP, and
SMU interactions. To support this, the driver is refactored to introduce
shared implementations for mailbox, PSP, and SMU, allowing both AIE2 and
AIE4 to reuse common code.

Series structure

(patch 1) Create common mailbox functions
Factor the AIE mailbox send-and-wait and status handling into common code.
AIE2 and AIE4 use same aie_send_mgmt_msg_wait() and DECLARE_AIE_MSG();

(patch 2) Add AIE4 SR-IOV support
Add the AIE4 Physical Function driver and SR-IOV: new PCI IDs and device
table entries. The amdxdna driver is updated with a sriov_configure
callback. The mailbox layer gets helpers so it works for both AIE2
(iohub) and AIE4 (no iohub). UAPI is extended with AMDXDNA_DEV_TYPE_PF.

(patch 3) Create common PSP interfaces
Make PSP support into common code.

(patch 4) AIE4 PSP support and firmware loading
Use PSP common code for AIE4 hardware. Add firmware request code for psp
operations, add NPU3 PSP BAR/register layout in npu3_regs.c.

(patch 5) Create common SMU interfaces
Make SMU support into common code.

(patch 6) AIE4 SMU support
Use SMU common code for AIE4 hardware. Add smu operations, add NPU3 SMU
BAR/register layout in npu3_regs.c.

Testing

Build and load on a system with an AIE4/NPU3 PF; confirm the device is
bound and SR-IOV can be enabled (e.g. via sriov_numvfs). Confirm
AIE2-based devices (e.g. NPU4) still probe and run as before.

David Zhang (5):
  accel/amdxdna: Add basic support for AIE4 devices
  accel/amdxdna: Create common PSP interfaces for AIE2 and AIE4
  accel/amdxdna: Add AIE4 firmware loading
  accel/amdxdna: Create common SMU interfaces for AIE2 and AIE4
  accel/amdxdna: Add AIE4 power on and off support

Lizhi Hou (1):
  accel/amdxdna: Create shared functions for AIE2 and AIE4

 drivers/accel/amdxdna/Makefile          |  10 +-
 drivers/accel/amdxdna/aie.c             |  89 +++++
 drivers/accel/amdxdna/aie.h             | 104 +++++
 drivers/accel/amdxdna/aie2_ctx.c        |   4 +-
 drivers/accel/amdxdna/aie2_error.c      |  12 +-
 drivers/accel/amdxdna/aie2_message.c    | 140 +++----
 drivers/accel/amdxdna/aie2_pci.c        | 145 +++----
 drivers/accel/amdxdna/aie2_pci.h        |  93 +----
 drivers/accel/amdxdna/aie2_pm.c         |   6 +-
 drivers/accel/amdxdna/aie2_psp.c        | 161 --------
 drivers/accel/amdxdna/aie2_smu.c        | 156 --------
 drivers/accel/amdxdna/aie4_message.c    |  27 ++
 drivers/accel/amdxdna/aie4_msg_priv.h   |  49 +++
 drivers/accel/amdxdna/aie4_pci.c        | 491 ++++++++++++++++++++++++
 drivers/accel/amdxdna/aie4_pci.h        |  53 +++
 drivers/accel/amdxdna/aie4_sriov.c      |  88 +++++
 drivers/accel/amdxdna/aie_psp.c         | 235 ++++++++++++
 drivers/accel/amdxdna/aie_smu.c         | 153 ++++++++
 drivers/accel/amdxdna/amdxdna_mailbox.c |  19 +-
 drivers/accel/amdxdna/amdxdna_mailbox.h |   8 +-
 drivers/accel/amdxdna/amdxdna_pci_drv.c |  19 +-
 drivers/accel/amdxdna/amdxdna_pci_drv.h |  10 +
 drivers/accel/amdxdna/npu1_regs.c       |  25 +-
 drivers/accel/amdxdna/npu3_regs.c       |  77 ++++
 drivers/accel/amdxdna/npu4_regs.c       |  30 +-
 drivers/accel/amdxdna/npu5_regs.c       |   2 +-
 drivers/accel/amdxdna/npu6_regs.c       |   2 +-
 include/uapi/drm/amdxdna_accel.h        |   3 +-
 28 files changed, 1609 insertions(+), 602 deletions(-)
 create mode 100644 drivers/accel/amdxdna/aie.c
 create mode 100644 drivers/accel/amdxdna/aie.h
 delete mode 100644 drivers/accel/amdxdna/aie2_psp.c
 delete mode 100644 drivers/accel/amdxdna/aie2_smu.c
 create mode 100644 drivers/accel/amdxdna/aie4_message.c
 create mode 100644 drivers/accel/amdxdna/aie4_msg_priv.h
 create mode 100644 drivers/accel/amdxdna/aie4_pci.c
 create mode 100644 drivers/accel/amdxdna/aie4_pci.h
 create mode 100644 drivers/accel/amdxdna/aie4_sriov.c
 create mode 100644 drivers/accel/amdxdna/aie_psp.c
 create mode 100644 drivers/accel/amdxdna/aie_smu.c
 create mode 100644 drivers/accel/amdxdna/npu3_regs.c

-- 
2.34.1

