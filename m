Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA218107BCCD
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:54:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DC3210E44C;
	Fri, 13 Mar 2026 16:54:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="N1FyOtKP";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012008.outbound.protection.outlook.com [52.101.43.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1B3510E44C;
 Fri, 13 Mar 2026 16:54:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=osgfkorWoAA35ex5AtO5APDQwMf686TkqgPJEtZdH6IOUvPA9GVsQfQDhBet6iQnaDFQSqa1BgllF6Cysp0F07Ud+A4Mr3R4NYpQ01EzsMWHTEiLE+ypkAoneyBc+j+XzE2PD/4bsLjYAnYy1PS4lWowuTx8pOz5pnA86kpHzvHOGLny6xOoXUOZkz31CuNqGejtW0JPXFw6EZZTrHtcuiBCumHaPdYw0Hf5V6iP9bGAFOBwkR6y+4vppRZFwlOmu/dQg7kObHXe9r5e2TxZ1zCz1cVpx6R21uk5jqM5Rzrj4E1xyEy/pHRbMq7oKJzUgphDRn3jAHVQMwJWSOJOWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KAw02OuVSyZwUmmtUVt34r2fNbLGFaSEuR+z4ZIVGE=;
 b=nvd6uZXBdq4JxdZt7cXQ98RyhY72YdRjIBpFHjR8TKy+JJWYn5B1G3JeZCxbET7UI1y0i6WRGBT1kt/Pl5TiVoPjeSRmS0sf/Pi7AWEt7AGiNmxY6N72bkGTMrepGisRoTjFSeNQqXwTUuP3706JmEAqq67YevVVebuU0sPoZ7zfxssAF8dmsOseXcIFVSPyO33ayGyi6wukuCYsTainfu9OFaeVx1r424G6yxGhPDKijpAUyCojTCIUHasPHO141X+XOueGiI2Ntc4QEU/q1PyosXgbaPQBPdEpTkW6uMjQb6o51sGciJ1AMhI5+fIH0mEDpFoHZ3wgCG3ZgdJjOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KAw02OuVSyZwUmmtUVt34r2fNbLGFaSEuR+z4ZIVGE=;
 b=N1FyOtKPFL1ybxgXe6S6rDQsqXBfmtllz/TixuJMENJUZ80cwxcyxAxEA1koAI7rIsftQduNkJqoTRBz39hK00w+N7IQhEjtlEC6HEAvQlIASjbkEEP2HA1xI8+2+N+GqrerCdMGYgNMKJqWs6a07AZvZlLZ/oa2seEjFF/8XFj7ZtSUAQsdX2fdu5HBTNwAZep07xcccByAvWyS/nepXhOiQRCd18H6mTamSMQz7fUssaTynUy4fcNibeUzYl3bp+HjoLMgjkR28rLb9Ji9dCD+4OTMsxBg2NLAz5Sjs6bq3+5pwHupfTro/8h1LblXjLn3iXn8o9Ylf/HR9Qxwug==
Received: from DS7PR03CA0061.namprd03.prod.outlook.com (2603:10b6:5:3bb::6) by
 MN0PR12MB5740.namprd12.prod.outlook.com (2603:10b6:208:373::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Fri, 13 Mar
 2026 16:54:07 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:5:3bb:cafe::a8) by DS7PR03CA0061.outlook.office365.com
 (2603:10b6:5:3bb::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.28 via Frontend Transport; Fri,
 13 Mar 2026 16:54:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.0 via Frontend Transport; Fri, 13 Mar 2026 16:54:05 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 09:53:47 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 09:53:46 -0700
Received: from inno-dell.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Mar 2026 09:53:38 -0700
From: Zhi Wang <zhiw@nvidia.com>
To: <dakr@kernel.org>, <aliceryhl@google.com>, <acourbot@nvidia.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <lossin@kernel.org>,
 <gary@garyguo.net>
CC: <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <kjaju@nvidia.com>,
 <alkumar@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <jhubbard@nvidia.com>,
 <gjuvekar@nvidia.com>, <joelagnelf@nvidia.com>, <zhiwang@kernel.org>, "Zhi
 Wang" <zhiw@nvidia.com>
Subject: [RFC v2 00/10] gpu: nova-core: boot GSP with vGPU enabled
Date: Fri, 13 Mar 2026 18:53:24 +0200
Message-ID: <20260313165336.935771-1-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|MN0PR12MB5740:EE_
X-MS-Office365-Filtering-Correlation-Id: b09f8ac9-34d5-4f02-30b3-08de81212316
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|7416014|18002099003|56012099003|13003099007;
X-Microsoft-Antispam-Message-Info: 5vovyr6rHV3fUnLZSqBxF93PqlWGmpDeRSUum/9rEpHUEAoNLrducRipjVLvq3uBO/FsKUm5XMq1YbGlBDWBptQ0EABnpCwNeJOYhImVEoCED8+npCVAV51pi1nYF6VsGSUfKSW8Yj0eFvpkzAQXEi1rt8Acq2AG9uDivB1sCG7yskE0Zsp+6N/r4LUhPjCu0G4WE/ubAURBfs7GRsiUcHc1jteNcTxp7apfqE+uxCpUHeaIFVOThNJVHLCcUL45/Q0mgrdqiWCXmiJJYLEBXt502yBHHEjUwje+iOE960uXp52vSIkPD0obWvUscO2gjEQ8oahI6xfTOS94vat+hmX4FpLmVZTk8X0FDp4dc8f9ZcsMME3MBVTEDRu/qvQwTo0N0iVRau4AT/lO9haMigaRjMKyeuvy2ByaOul4U4OWXSHGGKaGcobyXEB7OdMXEuw63/JmuhOTxyqKbvoLDaOa1z6YttDgRGuuAaF0PBa4zKY5XiJru/VibwNJ4g2git8hHK6DB9zEy6eEig/alzzCE+VNXl9Gx7nxxEDOOTqAUeFeMKgwh5NaK5d51HOGjiXbO2Ne+k2Ct2+GNg4CUfhRtsIegWj895AWubIlaWIEby2BwdqZU6SAYMoHzv8FKp/n0w0lAS6tFKZi47PnKbBwEbxQ8uL62y+3MWBSHHO2sL3jO6j/J7gx9YBXsvHIMmlBR5hjd/X2WaFmo/yBXtM5Mxl0n7lVj05X/vFa4+uwKyAurfunhk2Ko6SoG0xYZxzUrbFVgc5GBI6+x8+43bbuKeMWf3/FgfQ/yPu9dSo=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(7416014)(18002099003)(56012099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HzcG1jyOQlix6kaJCxOumq8s6ilbpGph+z4hhwOu09P/9pBXNgPcP/dnhoyjKIto+8xkg2Cn9qoVi7apw+gASXkrQsCv5RKLxXY0b0DDNVLyIl282JuYZNhDOIhF0tDtFxPPjOOkwT8T48JILFkTMjJSGHoBGntO99iOyfjPitHTumEJvxC5FMZ2z4WJ3L+/peOVzhOa/ROq31/yg0raWAul4Ild+T5sUsEQAuiMGeOedu4Kol2fOojpOcp3ySAKNXTuNyckHswX6FzPrWsgoDd1S98s0/261UTfCp4gX7oR4ZRkLtqQKSOcoLyMb2HnBd0DwHd1TANH8rfKmQgBZ7rscUU6zLyjv8oCy0SRP5QcMZFfU6Tnt/itBzCJlDh75USrVM+0EPQegw/1OnK+sQYhQyvwXT5o5iKvJeh1B70CVZEd7qTXRH3iCJj4iEEQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 16:54:05.4402 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b09f8ac9-34d5-4f02-30b3-08de81212316
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5740
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

Booting up GSP with vGPU enabled is part of the first milestone (M1)
together with rust fwctl abstraction [1] and nova-core fwctl driver [2]
for upstream vGPU support, allowing us to validate the basic GSP boot flow
with vGPU enabled, upload vGPU types even before the remaining nova-core
dependencies are ready.

This RFC v2 series is rebased on top of john/nova-core-blackwell-v6
(linux 7.0.0-rc1) [3], with the ExtSriovCapability abstraction extracted
into a separate upstream patch [4] based on Garry's WIP work. It also adds
FSP PRC protocol support for querying vGPU mode on Blackwell+
architectures, along with documentation for the FSP/PRC interface.

Besides the mailing list review, all the patches of M1 will be maintained
and iterated on the zhi/vgpu-m1-staging branch [5] before all the
dependencies are solved.

v2:

- Adopt early-return style (Dirk).
- Add #ifndef CONFIG_PCI_IOV helper to fix compilation when
  CONFIG_PCI_IOV is disabled, per (Alex).
- Change return type from Result<i32> to Result<u16> to match the
  PCI spec field width, avoiding try_from at call sites.
- GspVfInfo changed to tuple struct (Alex).
- Use unconditional constructor with Option wrapping instead of
  bool parameter. (Alex)
- Use full initialization expression instead of mutating a zeroed
  value.
- Use .chain() pattern in GspSetSystemInfo::init() for optional
  vGPU info. (Alex)
- Eliminate all magic numbers: add vf_bar_is_64bit() and
  read_vf_bar64_addr() to ExtSriovCapability using PCI bindings
  constants (PCI_BASE_ADDRESS_MEM_TYPE_MASK, etc.).
- Use KVec<RegistryEntry> for dynamic registry entry construction
  instead of hardcoded array (Timur, Joel, Alexandre).
- Replace magic numbers 32/48 with named binding constants
  MAX_PARTITIONS_WITH_GFID_32VM / MAX_PARTITIONS_WITH_GFID from
  OpenRM (Alex).
- Use read_poll_timeout() instead of single read for scrubber
  completion check (Joel).
- Use dev instead of pdev.as_ref() in dev_dbg! (Dirk).
- Change scrubber trigger condition from vgpu_requested to
  fb_layout.wpr2_heap.len() > SZ_256M, checking actual heap size
  instead of vGPU flag. (Alex).

- New patches:

- Factor out common FSP message header, return response buffer to caller,
  add PRC protocol support for reading vGPU mode from FSP on Blackwell+,
- Add FSP/PRC protocol documentation. (Suggested by Joel)
- The [!UPSTREAM] config space access patch from v1 is replaced by the
  ExtSriovCapability abstraction submitted separately [4].

Dependencies Status
=============================

[1] rust: introduce abstractions for fwctl v3              - In review
[2] gpu: nova-core: add fwctl driver                       - In review
[4] rust: pci: add extended capability and SR-IOV support  - RFC
[6] I/O projection API (Gary Guo)                          - WIP
[7] gsp: add continuation record support v6                - In review
[8] gsp: add locking to Cmdq v4                            - In review
[9] gsp: add RM control command infrastructure             - In review

[1] https://lore.kernel.org/rust-for-linux/20260217204909.211793-1-zhiw@nvidia.com/
[2] https://lore.kernel.org/rust-for-linux/20260305190936.398590-1-zhiw@nvidia.com/
[3] https://github.com/johnhubbard/linux/tree/nova-core-blackwell-v6
[4] https://lore.kernel.org/rust-for-linux/20260225180449.1813833-1-zhiw@nvidia.com/
[5] https://github.com/zhiwang-nvidia/nova-core/tree/zhi/vgpu-m1-staging
[6] https://github.com/nbdd0121/linux/tree/io_projection
[7] https://lore.kernel.org/nouveau/20260306-cmdq-continuation-v6-0-cc7b629200ee@nvidia.com/
[8] https://lore.kernel.org/nouveau/20260310-cmdq-locking-v4-0-4e5c4753c408@nvidia.com/
[9] https://lore.kernel.org/nouveau/20260227-rmcontrol-v1-0-86648e4869f9@nvidia.com/

Zhi Wang (10):
  rust: pci: expose sriov_get_totalvfs() helper
  gpu: nova-core: factor out common FSP message header
  gpu: nova-core: return FSP response buffer to caller
  gpu: nova-core: read vGPU mode from FSP via PRC protocol
  gpu: nova-core: add FSP and PRC protocol documentation
  gpu: nova-core: introduce vgpu_support module param
  gpu: nova-core: populate GSP_VF_INFO when vGPU is enabled
  gpu: nova-core: set RMSetSriovMode when NVIDIA vGPU is enabled
  gpu: nova-core: reserve a larger GSP WPR2 heap when vGPU is enabled
  gpu: nova-core: load the scrubber ucode when vGPU support is enabled

 Documentation/gpu/nova/core/fsp.rst           | 135 ++++++++++
 Documentation/gpu/nova/index.rst              |   1 +
 drivers/gpu/nova-core/fb.rs                   |  21 +-
 drivers/gpu/nova-core/firmware.rs             |   3 +-
 drivers/gpu/nova-core/firmware/booter.rs      |   2 +
 drivers/gpu/nova-core/fsp.rs                  | 231 +++++++++++++++---
 drivers/gpu/nova-core/gpu.rs                  |  48 +++-
 drivers/gpu/nova-core/gsp.rs                  |  32 ++-
 drivers/gpu/nova-core/gsp/boot.rs             | 133 +++++++---
 drivers/gpu/nova-core/gsp/commands.rs         | 105 +++++---
 drivers/gpu/nova-core/gsp/fw.rs               |  90 ++++++-
 drivers/gpu/nova-core/gsp/fw/commands.rs      |  12 +-
 .../gpu/nova-core/gsp/fw/r570_144/bindings.rs |   4 +
 drivers/gpu/nova-core/mctp.rs                 |   2 +
 drivers/gpu/nova-core/nova_core.rs            |  15 ++
 drivers/gpu/nova-core/regs.rs                 |  12 +
 drivers/gpu/nova-core/vgpu.rs                 |  37 +++
 rust/helpers/pci.c                            |   7 +
 rust/kernel/pci.rs                            |  14 ++
 19 files changed, 797 insertions(+), 107 deletions(-)
 create mode 100644 Documentation/gpu/nova/core/fsp.rst
 create mode 100644 drivers/gpu/nova-core/vgpu.rs

-- 
2.51.0

