Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A797EFF885A
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 21:15:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CA9E10E489;
	Sat, 25 Apr 2026 21:15:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="mospLIrx";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012066.outbound.protection.outlook.com
 [40.93.195.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4A2110E486
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 21:15:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sV8+Ie2X+Jm/uO2pmlWRuJtFDb2u+4P9AleiGM/3j5M+WwAXJCrMBpne9Vi/tkrTG3Fmv5MivC9tn7Nc5MaLSj9Y9G6RuH2lclUTBjr8xf9Rcv6YQiqPI1L8c7mmtqtDNb4+StEOdGY/2UE1HMjoU7Rgl/L0riwHqVJzCGVMtDkM2+t5run54z1fs649xitFSVGxif1aSA0cbRc2KZJaqtwa3eXvaTZeG4azpUyP3mjRyRvjikrREu+dusKRGprgFZoDcwXjhUGCBq3St58T8qZA7aUSk3Ezcp9h2TEUs22EVx9C+lHTZziesO48dtZJuE8tA5I71jmZd8yu07+dzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LUFv9Wv0Sxe3UNad2MOUQ656N3Ws1k8t7Ubg0BukTo=;
 b=tS52xrWRFsQafc5nq6bIpd4yV338caskxx19jWlBpKXs5gRhI2lFlmXdBw1N41R59+CLkO643pSiJ6Emiv99R+Dz+Rw27wn+m0VoJU6Hto5SBu+S4jayP/2K+MSRjdzWZ70lPPd69oiB82qsVhRTbPnd9KK+rEItL90ly5hL7ldGlsJdPkiDPqHYirMhlCW00yD48qIuwROU1mCP3q6DIti6LfhJ7PDTMN7UXVxyuqT60m1EC2VS60gEGnWAt/SKut0Fh8V5fLLS+g/xMHFQai7QevM1ad8MjaPZQdTHiJ+1opgIJIrLD86YUaTmjgvBCjW+FpPHBc1inwZnzd8PVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LUFv9Wv0Sxe3UNad2MOUQ656N3Ws1k8t7Ubg0BukTo=;
 b=mospLIrxNqvadsz+d3UqnsmtpUMCQElxEd6DDBXCqHAkaIvofAmkYKA+zJWrFxgwxqSv35gmE1kMpUY3fvQLRPee/MrMrVJjL1EZurIWc0TSPOoOrqmu9o3uIoCIWWahOMvVYOfK+53l6Q6sL7tYGFEfb4smBcwgSU7ItwyTNfpNAroJu0GTK5usVRX/l3GVUElANUN5x4NOp4HL5E+NyGu/B3CnU0EunioQm9nRJVER6ls5i1et+c03EAO8Kzul62kMgkp5DioYd8eBAlr56q62Cb/lKiGi/GWuGikrWkRaQ6VmRPfpl2QNDBDYx01jCw7872SVpns4V6OtbNBYLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 IA1PR12MB8358.namprd12.prod.outlook.com (2603:10b6:208:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.13; Sat, 25 Apr
 2026 21:15:18 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.012; Sat, 25 Apr 2026
 21:15:18 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 nova-gpu@lists.linux.dev, Nikola Djukic <ndjukic@nvidia.com>,
 David Airlie <airlied@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, Edwin Peer <epeer@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Andrea Righi <arighi@nvidia.com>,
 Andy Ritger <aritger@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 Balbir Singh <balbirs@nvidia.com>, Philipp Stanner <phasta@kernel.org>,
 alexeyi@nvidia.com, Eliot Courtney <ecourtney@nvidia.com>,
 joel@joelfernandes.org, linux-doc@vger.kernel.org,
 Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH v12 05/22] docs: gpu: nova-core: Document the PRAMIN aperture
 mechanism
Date: Sat, 25 Apr 2026 17:14:37 -0400
Message-Id: <20260425211454.174696-6-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260425211454.174696-1-joelagnelf@nvidia.com>
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0256.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::21) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|IA1PR12MB8358:EE_
X-MS-Office365-Filtering-Correlation-Id: b89aacf5-d3c9-4213-bfad-08dea30fc0b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: oYrIxfVcCxvegW1b/iX0uJaM9tkGc/+rclFdG1Eh9zEkGvBpb/JE8tFxzFdCw/7HvjaxQziCJfoEWj2ZqWivtjII5YjZnW+J8uKlm+ov622hbiOH0ujQuKGAkcTue0AlVlS0lKCcuyn4coepYPTTEZjkoDU4PWegQuhNxl2r/YVQw+esPdv0YHV/dTKdzI4r+1X027b6gBXtS+no9LITRo/G2argXFbOAeG7ZLT6G+3U5edFzkMHX7b6514VoMd2ef+kGZCyr5dfGX3B1JoPGy69ihAe4fDGMJKlRxe93XxpB6FYttKbP24pc/GrWPo/EN/+Mk7J5CpLu2fS6WoMbBBf9oJL/7KEec8Zwbv30K8O5Ye6v643jcLQM4VcCssgT+5rdiujq8QbonTtDfAU31mfyp293K2rgLSKEjOubhcD4TzIAcV+VfN/wT9MEMl+3jmccoSbf/tO7sBXCcJ6AQfHvJ6UkDYIMIvg945aqWHeV4nMt+7JvnfFV/mCJlQCDiDMPsY3UkI1yOw7PUyHxff2aKy023DxteX1xf/PyvE01s3A65YkDgVyXLR4thdJch02QPT48c89c4ZvxJsSZIsmVeUv1ZQL+0pfIx6GF3HBmQQySdEsYh/hC8VCGEjrrNiN19Rf8lLxdIpXYdcnxYcK4D98gZnaL3pOO8KJTh5+cxMBcEcpngI2sYLud1onO3H/1TzTH5uBA1LrKytEapq2MRH2omLmpyt+uM7qfD4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XcN7iYOrrQcMyRd4pG9qkMLYXtOWsJyk0M03ICRfg+yZQXkl2/5Zv4rQl+vJ?=
 =?us-ascii?Q?qZ4UDSQbLGN20TO2IY+uPN68bNkR8qS1djdlM+q3w0wz3Lm2/xeFC5osy3t/?=
 =?us-ascii?Q?18dis8pTKWXMirDtssMqHjXpHRf6cvfm5P0+jflsoHaM105lafBdS9GPSGFC?=
 =?us-ascii?Q?BW0KwrFut8op37afihh67HsBlzcS5nP1JYm0OHoORou7fR9mZENYwJzDIAa+?=
 =?us-ascii?Q?R3YeG6yl0ZdkvLgoW0IQcM+cfC1wPTkwr7HxvL4uiqGWoAuXW33GP/K8t/86?=
 =?us-ascii?Q?df+rCtIIVN9aaU5LTcHnc0JfXIju4hM8EiVfAUOzVfTgqm8UJWVG9TMgE0L1?=
 =?us-ascii?Q?43/4SV8G6DhS3yD+RzAPMZxypWm5zUiw6p1C1534Q7O8kKqYeNM/SwFKZqbl?=
 =?us-ascii?Q?c1ZDiA9g6uRTSfzmwWzx5bSO/CccQ8iOi5xWW2BuAcoh6AesurCqXeKI2ZMB?=
 =?us-ascii?Q?UAY21pJ/gu6SbvcJeUuIYJ/eYwAwfd0jx/doL12AA1zBNTqnFjh55NFWnWgB?=
 =?us-ascii?Q?NkS5dTNk1zNTpicKwYLHoF2HQHlFMOZIV6P9PuccmSqww1Dp/GKbqwcmr3Gp?=
 =?us-ascii?Q?EX7ABt3Luo2NqdC4eooMlPbN5BCOX7VPz6x22B909Qz5Ef77d+7vXecFacpD?=
 =?us-ascii?Q?JjqSbG0cXOdpJ5ZQk4H0EltV2Cl56F3XhsnePi5wxq1bA10/fh1Fgns5Lu5l?=
 =?us-ascii?Q?MEK8ztx8r8v8k2Hm0ClW6dee9/2EIM1kL/vCOhY2BMy1bkz6k7PEPEkD+2Pl?=
 =?us-ascii?Q?xgIDsnatXNDjM27ULO/wVgfKAtOMNU4W8jCFWf/kUaCCkoS2FOGdTQiVzA1Y?=
 =?us-ascii?Q?Sab3OHfHswOVdKnA+zengwxoN99rMD0ZY4NrNs3hrB49LdvIi2mDzelVohac?=
 =?us-ascii?Q?B79Q5MERzKwDKQ6gqx8Wq7ThOPugV2QjrOjbepCSFT1LF00zo2+gqZk8l6or?=
 =?us-ascii?Q?vb7js7YG7E+DRGHqBYXnox/pKLVH0hbhWLGgG1qz9PYpHTISdPA8p5F8Q7h1?=
 =?us-ascii?Q?Q6e0Pana1dVunmFtNWZBWXE5qmT5tqt73iaPyVdFRntfjKRqGFvEwEIsobd/?=
 =?us-ascii?Q?Wktch1lIVQpKtjCshwIrUEgmWyQv3NNtGxGWlytKL0erxxg+UwUod1v1Wk8n?=
 =?us-ascii?Q?oOcJ+yM4eb3CQqASd8uTWswILLucY0hoBjR9j5bMW6oJPgZpY8nE2Sf/C1es?=
 =?us-ascii?Q?fyjBI4jnhL4rjTObXwQ22MMKRh6dKSCfclIDCiUaOnY7r8v//VPePSuWqRpG?=
 =?us-ascii?Q?sUhX7JGKFY+O6kLZjvgv7zR1tuWHdh1ELoVPz2rXECTtx6CCR2lmkDWirSu8?=
 =?us-ascii?Q?IcPxypJaYoX9bp4+nvSv4zhezNRMoN5ypoMFqy1vfs4ySJiYPi+o/07BaHse?=
 =?us-ascii?Q?bCyvAYqQCTHAGd+iab3ngp+uq/IKF1SWYfcaXzokYSfQwSrPTyJDoPs0yTRI?=
 =?us-ascii?Q?z9KWlxGVvLkcHknnV3l1Y7AbN0dDOxhDppl4LL+1QN0P//uu1ThvHUDMSWYJ?=
 =?us-ascii?Q?Kr5c5QkyviNKtczbM/qyPlQrbILZUYNm1OpDQhMd/xlBJdDG2YcnQhxMu8nB?=
 =?us-ascii?Q?JLSAD1ISo9+znEKtzah4bHPBgTYUFY3A6KcUZ4mtPReRL5ebSLbD9EFd4XER?=
 =?us-ascii?Q?Xaq6m0Io/MN+Qv9Y3qZcORE+PMOd4D4bb5ufswZOmYBctZJGNheukrhvDQKg?=
 =?us-ascii?Q?NXdMU/lDRoHk2XI+DKZjaoix6rYooDMYfVuSYrUgyZqBb4EbzgiezTkCjdTo?=
 =?us-ascii?Q?9WRjD3GCog=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b89aacf5-d3c9-4213-bfad-08dea30fc0b7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 21:15:18.7583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DK9ZlMU917n47jxpShrd913JnJwv/0s1VG3jEX0ytY/steVH/gHvDisIeS3QufQl6kwVKOp3c/vLLi5No/whGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8358
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

Add documentation for the PRAMIN aperture mechanism used by nova-core
for direct VRAM access.

Nova only uses TARGET=VRAM for VRAM access. The SYS_MEM target values
are documented for completeness but not used by the driver.

Cc: Nikola Djukic <ndjukic@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 Documentation/gpu/nova/core/pramin.rst | 123 +++++++++++++++++++++++++
 Documentation/gpu/nova/index.rst       |   1 +
 2 files changed, 124 insertions(+)
 create mode 100644 Documentation/gpu/nova/core/pramin.rst

diff --git a/Documentation/gpu/nova/core/pramin.rst b/Documentation/gpu/nova/core/pramin.rst
new file mode 100644
index 000000000000..f6cbb0811163
--- /dev/null
+++ b/Documentation/gpu/nova/core/pramin.rst
@@ -0,0 +1,123 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================
+PRAMIN aperture mechanism
+=========================
+
+.. note::
+   The following description is approximate and current as of the Ampere family.
+   It may change for future generations and is intended to assist in understanding
+   the driver code.
+
+Introduction
+============
+
+PRAMIN is a hardware aperture mechanism that provides CPU access to GPU Video RAM (VRAM) before
+the GPU's Memory Management Unit (MMU) and page tables are initialized. This 1MB sliding window,
+located at a fixed offset within BAR0, is essential for setting up page tables and other critical
+GPU data structures without relying on the GPU's MMU.
+
+Architecture Overview
+=====================
+
+The PRAMIN aperture mechanism is logically implemented by the GPU's PBUS (PCIe Bus Controller Unit)
+and provides a CPU-accessible window into VRAM through the PCIe interface::
+
+    +-----------------+    PCIe     +------------------------------+
+    |      CPU        |<----------->|           GPU                |
+    +-----------------+             |                              |
+                                    |  +----------------------+    |
+                                    |  |       PBUS           |    |
+                                    |  |  (Bus Controller)    |    |
+                                    |  |                      |    |
+                                    |  |  +--------------+<------------ (window starts at
+                                    |  |  |   PRAMIN     |    |    |     BAR0 + 0x700000)
+                                    |  |  |   Window     |    |    |
+                                    |  |  |   (1MB)      |    |    |
+                                    |  |  +--------------+    |    |
+                                    |  |         |            |    |
+                                    |  +---------|------------+    |
+                                    |            |                 |
+                                    |            v                 |
+                                    |  +----------------------+<------------ (Program PRAMIN to any
+                                    |  |       VRAM           |    |    64KB-aligned VRAM boundary)
+                                    |  |    (Several GBs)     |    |
+                                    |  |                      |    |
+                                    |  |   FB[0x0000000000]   |    |
+                                    |  |          ...         |    |
+                                    |  |   FB[0xFFFFFFFFFF]   |    |
+                                    |  +----------------------+    |
+                                    +------------------------------+
+
+PBUS (PCIe Bus Controller) is responsible for, among other things, handling MMIO
+accesses to the BAR registers.
+
+PRAMIN Window Operation
+=======================
+
+The PRAMIN window provides a 1MB sliding aperture that can be repositioned over
+the entire VRAM address space using the ``NV_PBUS_BAR0_WINDOW`` register.
+
+Window Control Mechanism
+-------------------------
+
+::
+
+    NV_PBUS_BAR0_WINDOW Register (0x1700):
+    +-------+--------+--------------------------------------+
+    | 31:26 | 25:24  |               23:0                   |
+    | RSVD  | TARGET |            BASE_ADDR                 |
+    |       |        |        (bits 39:16 of VRAM address)  |
+    +-------+--------+--------------------------------------+
+
+    The 24-bit BASE_ADDR field encodes bits [39:16] of the target VRAM address,
+    providing 40-bit (1TB) address space coverage with 64KB alignment.
+
+    TARGET field (bits 25:24):
+    - 0x0: VRAM (Video Memory)
+    - 0x1: SYS_MEM_COH (Coherent System Memory)
+    - 0x2: SYS_MEM_NONCOH (Non-coherent System Memory)
+    - 0x3: Reserved
+
+.. note::
+   Nova only uses TARGET=VRAM (0x0) for video memory access. The SYS_MEM
+   target values are documented here for hardware completeness but are
+   not used by the driver.
+
+64KB Alignment Requirement
+---------------------------
+
+The PRAMIN window must be aligned to 64KB boundaries in VRAM. This is enforced
+by the ``BASE_ADDR`` field representing bits [39:16] of the target address::
+
+    VRAM Address Calculation:
+    actual_vram_addr = (BASE_ADDR << 16) + pramin_offset
+    Where:
+    - BASE_ADDR: 24-bit value from NV_PBUS_BAR0_WINDOW[23:0]
+    - pramin_offset: 20-bit offset within the PRAMIN window [0x00000-0xFFFFF]
+
+    Example Window Positioning:
+    +---------------------------------------------------------+
+    |                    VRAM Space                           |
+    |                                                         |
+    |  0x0000000000 +-----------------+ <-- 64KB aligned      |
+    |               | PRAMIN Window   |                       |
+    |               |    (1MB)        |                       |
+    |  0x00000FFFFF +-----------------+                       |
+    |                                                         |
+    |       |              ^                                  |
+    |       |              | Window can slide                 |
+    |       v              | to any 64KB-aligned boundary     |
+    |                                                         |
+    |  0x0123400000 +-----------------+ <-- 64KB aligned      |
+    |               | PRAMIN Window   |                       |
+    |               |    (1MB)        |                       |
+    |  0x01234FFFFF +-----------------+                       |
+    |                                                         |
+    |                       ...                               |
+    |                                                         |
+    |  0xFFFFF00000 +-----------------+ <-- 64KB aligned      |
+    |               | PRAMIN Window   |                       |
+    |               |    (1MB)        |                       |
+    |  0xFFFFFFFFFF +-----------------+                       |
+    +---------------------------------------------------------+
diff --git a/Documentation/gpu/nova/index.rst b/Documentation/gpu/nova/index.rst
index e39cb3163581..b8254b1ffe2a 100644
--- a/Documentation/gpu/nova/index.rst
+++ b/Documentation/gpu/nova/index.rst
@@ -32,3 +32,4 @@ vGPU manager VFIO driver and the nova-drm driver.
    core/devinit
    core/fwsec
    core/falcon
+   core/pramin
-- 
2.34.1

