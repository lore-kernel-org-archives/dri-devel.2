Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB74ACD3423
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 20:58:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BC2110F627;
	Fri,  1 May 2026 20:58:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="hqTvUDR4";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010019.outbound.protection.outlook.com
 [40.93.198.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F54410F627
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 20:58:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZyBhRh0BVomyju+uIrlls6RyVId1VT03jXSauf2tv/aeH7AEgVT/3nLMgMU6iqPU5gu5TJlduPOq7Ix/zKC7JVNYdwB0u6LmyksuDx4T4deN+1dAHQjtxnBaN8UmJKVcsLvDII3/7rJLJNONsgp/LY/9Tzkavfok4tooIjNMQR+PBXG87DiTbhvETVLBNaJvVMTU0dXGrsIZM1PbhYZr882vuFxFhpaOiyJw4r69GUHB8KJcrSbixCfoJx3wL4B4SAcQP5LAWEqvzyMFLuBJ6/qqO5XGiK/3HNiIVl0WefDIfbiemfWJrQfX4hfRD+6kZ9iOPNVfaAEIoBWUrhuMRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aL2MNDnyPPldz3xrGgxZrIWhngKmUIj7co/qwaWhtmI=;
 b=vabjIf3Z1iQnIFNM7ZhbYzN8jcgJGlf5j8zDeAjexJxOS0QqC+W0fVfTVoEVEMreBQJinVEYik4tqNFyPugWAJ9vggfRCznQvkq8eKMrmsaPZe19qOvCejvZB/vR7GXbjugF1U/VgvpRcmozlYlLJARWOIXCpJKojOIvhZ9z1Xy2gNc2OP0o1yn+O3ESZtbXf0sMspSapnC+vgHHyhOUXPpIYwvA3D5GTnHODMBcvstdoK2leCLJAY6B2UPkyQsNLMwEBMFMRvzk54NQz6JZYgpYJDqKmZ8j9x4TIhxIHcR2zskR98Fyfs+zEJPB6y+Z4WzTV40lP2yxc/vbnZ+7HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aL2MNDnyPPldz3xrGgxZrIWhngKmUIj7co/qwaWhtmI=;
 b=hqTvUDR4o/wdabupI/jWaIDVxMatAK7hoJlpDi+AD2gDNz19EuaYKgguZ95hf6iTE2Tdo5f+5GGvNC4nKbWnUHWr8UUseO6f3DvcBs9hKJp+qx5EU3WBdR+7/G+/iXP1B3DRCiw2YGfZXRjEnpkh9IXu4Ewq6VxxlMO/u49z4cvz9j5BOMXpabEnSAkXjgfEZh1MLAWnuXhLv/dMVYhE+AyNHBGbOzvtoF1UntBnvZFwiBwHSOfgMHnfW9OKi6eNsx5+QUOasy6BY5nSJHOfdQOsik1R9Gg2Tn+J8778XJ2neIqZ0RW9DvV+g9okbLbUsttrCE99xBkNXk/w+Ooi+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 CY3PR12MB9554.namprd12.prod.outlook.com (2603:10b6:930:109::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Fri, 1 May
 2026 20:58:46 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.022; Fri, 1 May 2026
 20:58:46 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: Danilo Krummrich <dakr@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-doc@vger.kernel.org, Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH v1 7/7] gpu: nova-core: document INTR_CTRL interrupt tree
Date: Fri,  1 May 2026 16:58:25 -0400
Message-Id: <20260501205825.73614-8-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260501205825.73614-1-joelagnelf@nvidia.com>
References: <20260501205825.73614-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0040.namprd15.prod.outlook.com
 (2603:10b6:208:237::9) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|CY3PR12MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: cdce5c8e-aa19-406c-17fa-08dea7c46f67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: iiwCywOnQ3kf1eBTXzmsr0emgkHJJxQQrVze9Q5bhdWtCU7/uxOoQRk5sRKGiCpTRJOBhMrdJi18qJe/lpZql42KK2jTBYZetZXQ4JIJ2qNDPCFizXBypkX2XD6L+hRwzODqqFcyf1o/WkvZh6nGzqXMWLp3uo5OnY5bXWWD3tMgqT7BiF38ow2omKqZyDRY3GzR4pnA5r1kyOsbWrnyvy8CcgKwnRHIx6Es6nk4x2LNSdGwsdphspmZVKtikOMxFgCYfXyhKIVY1hnu6ixPqBljY1F9TWdyT0nJasccpUv+n7gvEm3DfSvn94rvfI59uMEVEz9J/nTJ3uzTt9lBvReeSS3djhYbIud7C8IWpORKaPyZ4sZhyw767McLut2hcIWjVAGH9JJg63sZGSajFpnYRI4bVgKGqJWOILVRE4cHEyEPryhyAviwPUPe/QHqL9ErTIBMWB74XTXT11osyp18MJal8jQE23N17yGP7r0JFM7HpTGj70e0/8DozHJWikUHidcaUsCAw6qECtL7Sn2oWnbWGMmPDyCQyISSljYTtMlftOjeeVL8GIhUzYpKFJOiSF0vXDi7fl49j5hZNVTJ4XHSu60b1PnurA+6O6Mz9FI5pDhLNMcMNimjn94bMPlHyBUhbqzFGjGd3tHqUyf9vww2kl3ymYoUWQJ/1jh6pCnx05OIEDVQfx9uQ4Gw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2MiDNDqIzhVtA7wDCyPBzSkRvJPdxmPolypsYzc996uh7bxrH2cegeA4Mii7?=
 =?us-ascii?Q?J6oOmEdPy1TmGfuTYkbUyF7y1GlFBhyYtRwI2nEg5P8NE6HdFtw0gKhUZEI+?=
 =?us-ascii?Q?fh3izdVmDFb1C5SAjVl1bXBIkArUeL0WWQAS4zMsKuQO9J7j4sO9ZPHTDl8M?=
 =?us-ascii?Q?hLMAYivM5nsXcSqZ2YjnfXGFSAZ54H+KfmtfSjf/272uPjMNFP+f/xZUUgSk?=
 =?us-ascii?Q?wuv+GGufH8EYU2Ma7I5wEkDOizSPoA2B8CwwWHXyIOxx9neV7RopICZpTEVq?=
 =?us-ascii?Q?BKOimCLzrS2RTjzm9g9GR0HsSQAeW8ewwvu/NtoBcfc4lZTq6XGEClV8u7XE?=
 =?us-ascii?Q?1GvkxrkSndm/oDi0gqjSQJMR1VERsh9Kc/Ew7GTN6Qsb29dsRLTxHqy588rO?=
 =?us-ascii?Q?p+HJKPmnyv6aSQKp3SuW/tKw/688AJ0OrMNlVhL1WMfS2xrtxUWYxuzx8Fbb?=
 =?us-ascii?Q?Oxxaa4MtgVoUktW0kkFEPE57UWY4ChjYeGKJ0CWCJ3OHPp9UQEfn7ODeAH1Z?=
 =?us-ascii?Q?p9i16KiEWr6CNOKFl+OI3Agx+SQB0kVtGqaBjGSqozJAt2iyO0gL+POqD6qB?=
 =?us-ascii?Q?00kBpEmyt3Yr8pszzIxNy0gYr/C0a68TnOaGtZPO7YBbPelf5nj7phKlbhc1?=
 =?us-ascii?Q?jRqDjzlsYqRR0XEzKMEAmzL+K282xACKz1reeCI61e/TbpE3bnK6JauVnM5N?=
 =?us-ascii?Q?gkWSLCyGgmoLfvQcRaJRKP0DPtMhvvrAMV9w9qa0SIpVruI3InXylWwFlul/?=
 =?us-ascii?Q?/LaDL8LLFI+qtoTPxrh+DoMBhT8PiOjJEAKQf9hkLndodftK6GW6UnfaE1D4?=
 =?us-ascii?Q?SNuvaE6XR5c1GHrrLu5XE0GB1kt/m5NBWE0z82DNnalKMWUNrB0RPFoRB6Zx?=
 =?us-ascii?Q?z4GtJgdkjY1zbxI5BurcEcPxXclWnDMvMq7d2CC++6bIsolttMKg12fDJZQZ?=
 =?us-ascii?Q?ip6YkU028MmtHLjtHzpgMOPW1qkenvwhcJw3cTcbdMLaVPRUmXI75daSoAWO?=
 =?us-ascii?Q?FNkla05I08tuX4TmEcMBbJd+Yo6xvlCF0rOC/ca7mOldNRrmklEP0sLLE3K1?=
 =?us-ascii?Q?VIt3YsbXB+f01iXy7MGvdTIeBhUwhRVaySppEMMohhmWAtXrjjRujtx4ABHK?=
 =?us-ascii?Q?BWNll8N2IBYccHAHwiRSCAOu/UwtwiolvoEvkb0jDL5amCbetzfYGqIIhlaz?=
 =?us-ascii?Q?IBwy5339rPeejQbpVvgKNj8+X5LRZdDoJXcYBT4c01Xs9IZSGTnBFL0ld7nt?=
 =?us-ascii?Q?DhlaY0Tdg2j6ucGeODYaatYzCPHxUD2KB6zGIq4GUPjxMlDcvBNNYTEEcXVq?=
 =?us-ascii?Q?+YRmvSl6KxTwN4dNBE/cMOrznfBTS1DJxU1j3hWLyBcIlaJFOZtBxJS+8ehV?=
 =?us-ascii?Q?DukI4iaZQhnrO0qhdEF3akN0ZXYr/zknGVoLAnJNmOFE1THeCaZ3z0FZH615?=
 =?us-ascii?Q?GAVSDgl8hjCDvykjDAC3Vvx99PkpHU+4f0bFq2euGFYmsZg/h1DjF1i+EGqM?=
 =?us-ascii?Q?B2T1yMPK7gG8xOxXGtlBfLb9Wyogi4KPrxnyceH7rlN05ehIkPV3Y42WdNyl?=
 =?us-ascii?Q?JDvxH7Lg6kGwKceZTzlCZdXE1XqK9OSUrlLlUKAzwNuUxTc+3atB31V2Luve?=
 =?us-ascii?Q?kGBA+a/Y37hjYCenFvTP0fjhjL8pjPhFmv+mhYmkHn8BJplHpy+B8jvX0qKT?=
 =?us-ascii?Q?0RmUuQcQgGjyLw7qXL96ddemJv7Qo5NSErPO9ktrRvLRN3seFigvSPoAZmZZ?=
 =?us-ascii?Q?79F6XEcnmg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdce5c8e-aa19-406c-17fa-08dea7c46f67
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 20:58:45.8904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yA2kiHMcfV4ERjmXLHFaAl9gEqgz7aycAq1QsKnPeMkmqbYIgylnruIYKO33/6dleWunjP9rLxWfUmGrslrpJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9554
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

Add documentation describing the interrupt controller architecture for
modern NVIDIA GPUs.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 Documentation/gpu/nova/core/intr-ctrl.rst | 305 ++++++++++++++++++++++
 Documentation/gpu/nova/index.rst          |   1 +
 2 files changed, 306 insertions(+)
 create mode 100644 Documentation/gpu/nova/core/intr-ctrl.rst

diff --git a/Documentation/gpu/nova/core/intr-ctrl.rst b/Documentation/gpu/nova/core/intr-ctrl.rst
new file mode 100644
index 000000000000..10091c258f9c
--- /dev/null
+++ b/Documentation/gpu/nova/core/intr-ctrl.rst
@@ -0,0 +1,305 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============================================
+INTR_CTRL: The GPU's Interrupt Controller
+==============================================
+
+This document describes the interrupt controller which sits between
+the GPU's internal engines (including GSP) and the host's MSI delivery path.
+It is the first hardware block the host driver consults whenever an interrupt is
+delivered, and it is responsible for telling software which engine interrupted.
+It is also known as the "INTR_CTRL" block. The main evolution of interrupt
+controller architecture is to support virtualization (multiple views of the
+interrupt tree for PFs and VFs).
+
+Per-function trees
+==================
+
+Each PCIe function has its own private interrupt tree:
+
+* The Physical Function (PF) sees a tree at a fixed BAR0 offset.
+* Each Virtual Function (VF) sees its own tree at the same BAR0 offset
+  *within its own BAR0 view*, and it cannot observe the PF's tree.
+* The GSP firmware also has its own logical tree in INTR_CTRL used for
+  receiving interrupts to GSP from the engines, but we don't need to
+  bother with those in nova-core (that's GSP's business).
+
+.. note::
+  The PF can also see the VF's tree at an aliased offset in BAR0, which
+  is useful if the guest driver needs host help in configuring interrupts,
+  but we currently do not use that in nova-core.
+
+Two-level interrupt tree
+========================
+
+INTR_CTRL multiplexes up to 256 internal interrupt vectors onto the single
+MSI line allocated to the PCIe function via a two-level tree of MMIO
+registers, where each TOP bit covers exactly two adjacent leaves (known
+as a "subtree"). As an example, on GA102, the tree looks like this::
+
+    TOP register (32-bit)
+     |   bit N == 1 => subtree N has at least one pending leaf
+     |
+     +-- bit 0 --> LEAF[0] (32-bit)  vectors    0..  31  (nonstall base)
+     |             LEAF[1] (32-bit)  vectors   32..  63
+     |
+     +-- bit 1 --> LEAF[2] (32-bit)  vectors   64..  95
+     |             LEAF[3] (32-bit)  vectors   96.. 127
+     |
+     +-- bit 2 --> LEAF[4] (32-bit)  vectors  128.. 159  (CPU doorbell @ 129)
+     |             LEAF[5] (32-bit)  vectors  160.. 191
+     |
+     +-- bit 3 --> LEAF[6] (32-bit)  vectors  192.. 223  (engine stall base,
+     |             LEAF[7] (32-bit)  vectors  224.. 255   GSP stall vector)
+     |
+     +-- bits 4..7 (Hopper+ only) --> LEAF[8..15]
+
+
+The second level (LEAF registers) is where individual engines deposit
+their interrupt events. The first level (TOP register) is a summary: bit
+``N`` of TOP is set if and only if at least one bit is set in the two
+leaves owned by subtree ``N``. Software can therefore start from TOP,
+identify which subtrees have work, and then descend into just those leaves
+- it never needs to read all 16 leaf registers blindly.
+
+The advantage of this architecture is that it allows the host to mask
+entire subtrees of interrupts at once, rather than having to mask each
+leaf individually. Similar reasoning for determining which interrupt
+source fired, the host can walk the tree without going through all 16
+leaves.
+
+Each TOP bit, called a **subtree**, is wired in hardware to exactly two
+adjacent leaves (``leaves 2*N`` and ``2*N + 1``), so nova-core derives
+``num_subtrees = num_leaves / 2`` rather than tracking both numbers
+independently.
+
+End-to-end engine interrupt routing to MSI
+===============================================
+
+The engine interrupt routing is done by the engine's INTR_CTRL(i)
+register. This register is written once by GSP at boot and decides
+which tree/leaf to activate in the INTR_CTRL. This model assists in
+virtualization, as it is possible for the GSP to route engines to the
+correct tree/leaf corresponding to the VF. GSP then provides the
+information to the host via the INTR_GET_KERNEL_TABLE RPC so that
+the host knows which leaf bits correspond to an engine's interrupt.
+
+It roughly looks like the following::
+              +--------------- Engine (CE, GR, NVDEC, ...) ---------------+
+              |                                                           |
+              |   internal work completes                                 |
+              |          |                                                |
+              |          v                                                |
+              |   +-----------------------------------------+             |
+              |   | INTR_CTRL(i): programmable register     |             |
+              |   | (written once by GSP-RM at boot,        |             |
+              |   |  one such reg per engine)               |             |
+              |   |                                         |             |
+              |   |   VECTOR  = 200   (-> which leaf bit)   |             |
+              |   |   GFID    = 0     (-> which function's  |             |
+              |   |                       tree: 0=PF, N=VF) |             |
+              |   |   CPU     = 1     (-> copy to CPU tree?)|             |
+              |   |   GSP     = 0     (-> copy to GSP tree?)|             |
+              |   +--------------------+--------------------+             |
+              |                        |                                  |
+              |     engine builds      |                                  |
+              |     interrupt ctrl     |                                  |
+              |     command message    |                                  |
+              |  (all2ctrl_intr_cmd)   |                                  |
+              +------------------------|----------------------------------+
+                                       |
+                                       v
+                   +-----------------------------------------+
+                   | Central INTR_CTRL block                 |
+                   |                                         |
+                   | reads message; for the tree picked      |
+                   | by GFID, sets:                          |
+                   |   LEAF[ 200 / 32 ]  = LEAF[6]           |
+                   |   bit  ( 200 % 32 ) = bit 8             |
+                   | TOP subtree 3 = pending                 |
+                   +--------------------+--------------------+
+                                        |
+                                        v
+                                MSI to host (PF)
+
+Vector encoding
+---------------
+
+A vector number ``v`` (0..255) maps to a unique ``(leaf, bit)`` pair::
+
+    leaf_index = v / 32
+    bit_in_leaf = v % 32
+
+For example, vector 129 (the CPU doorbell self-test vector we use in
+the INTR_CTRL self-test, see below) lives in ``LEAF[4]`` at bit 1,
+which is reachable through subtree 2 in the TOP register.
+
+Architecture differences
+------------------------
+
+The number of *active* leaves depends on the GPU architecture:
+
+==================  =================  ==========  ================
+Architecture        Active leaves      Subtrees    ``subtree_mask``
+==================  =================  ==========  ================
+Turing / Ampere     8                  4           ``0x0f``
+Ada Lovelace        8                  4           ``0x0f``
+Hopper / Blackwell  16                 8           ``0xff``
+==================  =================  ==========  ================
+
+Pre-Hopper chipsets only have leaves 0-7 wired up; the upper half of the
+TOP register is unused and reads back as zero. Hopper widened the tree to
+16 leaves to support more engines and more virtual functions.
+
+Stall vs nonstall vector ranges
+===============================
+
+A common point of confusion: **stall and nonstall are NOT separate
+interrupt trees**. They are two different *vector ranges* within the same
+INTR_CTRL tree, and the source engine picks which range its interrupt
+lands in.
+
+* **Nonstall** vectors live in the low leaves (``LEAF[0..1]``, vectors
+  0..63). The engine fires the interrupt and continues immediately,
+  whether or not the host has acknowledged it. Used for "fire and
+  forget" notifications - examples: vblank, semaphore wakeups, performance
+  counter overflow).
+
+* **Stall** vectors live in the high leaves.
+  On Turing and Ampere:
+  ``LEAF[6..7]`` (vectors 192..255, subtree 3).
+  On Hopper:
+  ``LEAF[6..11]`` (subtrees 3..5).
+  The engine *blocks* (stalls) until the host writes a W1C (Write 1 to Clear)
+  ack to the leaf bit. Example: MMU fault.
+
+ISR operation flow
+==================
+
+When an MSI fires, the ISR walks the tree in a fixed sequence::
+
+    1. UNARM    write subtree_mask -> TOP_EN_CLEAR  (stop MSI delivery)
+    2. READ     pending = TOP                       (which subtrees fired?)
+    3. ACK      for each pending leaf:
+                   mask = LEAF[i]                   (read pending vectors)
+                   LEAF[i] = mask                   (W1C the latches)
+                   dispatch handlers for set bits
+    4. REARM    write subtree_mask -> TOP_EN_SET    (resume MSI delivery)
+
+A few important properties:
+
+* **All pending leaf bits must be acked**, even bits that nova-core does
+  not currently dispatch. Leaving a bit set keeps its subtree pending in
+  TOP, which means the next REARM immediately fires another MSI - an
+  interrupt storm. The handler therefore acks the full leaf mask, not
+  just the bits it recognizes.
+
+* **REARM happens only after every pending leaf has been acked.**
+  Otherwise a still-set leaf bit would re-fire MSI on the next REARM
+  even though the ISR is mid-processing.
+
+Edge-trigger and rearm semantics
+================================
+
+Each LEAF bit is a sticky latch with edge-triggered SET behaviour:
+
+* The latch SETS on the rising edge of the source signal (an engine
+  message arriving on the interrupt control command interface, or a falcon
+  output wire transitioning low->high).
+* The latch CLEARS only when the host writes a 1 to that bit (W1C).
+* A still-asserted source does **not** re-set the latch. There is no
+  way to make a level-asserted signal "re-fire" except to drop and
+  re-raise it.
+
+There are two distinct rescue mechanisms, at two different layers,
+for two different problems. They are easy to confuse, so first some
+vocabulary as the rescues are entirely about how these pieces of
+hardware are wired together:
+
+* ``LEAF[i]``: each bit is a *sticky latch*: bit ``b`` SETs on the
+  rising edge of an ``all2ctrl_intr_cmd`` message and CLEARs only
+  when the host writes 1 to that bit (W1C ack).
+
+* ``TOP[N]``: bit ``N`` of the read-only ``TOP`` register. Purely
+  combinational: it reads 1 if and only if at least one bit is
+  latched in either of the two leaves owned by subtree ``N``,
+  i.e. ``LEAF[2N]`` or ``LEAF[2N+1]``. Software cannot write ``TOP``;
+  the hardware tracks the leaves automatically.
+
+* ``TOP_EN[N]``: a single host-controlled "armed?" bit per subtree,
+  internal to INTR_CTRL. The host *sets* it by writing 1 to
+  ``TOP_EN_SET`` and *clears* it by writing 1 to ``TOP_EN_CLEAR``.
+  Reading either register returns the current ``TOP_EN`` bitmask.
+  ``TOP_EN`` is not a latch; it just remembers what the host last set
+  or cleared.
+
+* The **MSI-edge AND-gate**: one per subtree, internal to ``INTR_CTRL``.
+  It ANDs ``TOP[N]`` with ``TOP_EN[N]`` and drives the output
+  through an edge detector. An MSI for subtree ``N`` is delivered
+  on every *rising edge* of this AND output; level changes that
+  drop the output to 0 (for any reason) deliver no MSI.
+
+::
+
+       LEAF[2N], LEAF[2N+1]         (sticky latches; W1C to clear)
+              |
+              v
+       (OR of all 64 latched bits in subtree N)
+              |
+              v
+        TOP[N] ----+
+                   |
+                   AND ---(rising edge detector)---> MSI for subtree N
+                   |
+       TOP_EN[N] --+
+              ^
+              |   host pokes:
+              |     write 1 to TOP_EN_SET[N]   -> TOP_EN[N] becomes 1
+              |     write 1 to TOP_EN_CLEAR[N] -> TOP_EN[N] becomes 0
+
+With that in hand:
+
+1. **REARM** (writing the subtree mask to ``TOP_EN_SET``) rescues a
+   timing race: between the ISR's last leaf ack and the moment
+   ``TOP_EN`` is brought back high, *new* engine events can arrive
+   and latch fresh leaf bits. The ISR did its best to drain
+   everything visible at the time of its W1C, but the W1C only
+   clears the bits the ISR snapshotted; anything the engine fires
+   afterwards sets new bits in ``LEAF[i]`` that the ISR never saw.
+
+2. **INTR_RETRIGGER** (a per-engine register, not part of INTR_CTRL)
+   rescues a still-asserted level source *inside an engine*. Most
+   engines drive their internal "interrupt pending" signal as a
+   level and convert it to an ``all2ctrl_intr_cmd`` message via an
+   edge converter that fires only on the rising edge of that level.
+   So one rising edge of the engine's level produces one message,
+   which sets one leaf bit. After the host's W1C clears that leaf
+   bit, a level that has stayed high produces no new edge, so the
+   engine's edge converter never sends another message to INTR_CTRL,
+   the leaf stays clear, and ``TOP[N]`` is 0. REARM's AND-gate trick
+   is useless here. Writing 1 to the engine's
+   ``INTR_RETRIGGER`` register drops the engine's level for one
+   clock cycle; the level then returns to 1 (the engine still has
+   work pending in its source register), the edge converter sees a
+   fresh 0->1 transition, sends a new message, the leaf re-latches,
+   ``TOP[N]`` goes back to 1, and an MSI follows on REARM (or
+   immediately, if ``TOP_EN[N]`` was already 1). ``INTR_RETRIGGER``
+   bridges the asymmetry between level-asserted internal engine
+   logic and edge-driven ``INTR_CTRL`` leaf messages.
+
+CPU doorbell self-test
+======================
+
+INTR_CTRL exposes a software-trigger register, ``NV_VF_INTR_LEAF_TRIGGER``.
+Writing a vector number ``v`` to this register synthesizes a hardware
+interrupt event on vector ``v``: the matching leaf bit latches, TOP
+updates, and (assuming the subtree is armed and the leaf vector is
+enabled) an MSI is delivered to the host.
+
+nova-core uses vector 129 (``LEAF[4]`` bit 1) as a self-test "doorbell":
+during early initialization, the driver registers a temporary ISR for vector
+129, writes 129 to ``LEAF_TRIGGER``, and verifies that its ISR fires.
+This validates the entire MSI -> INTR_CTRL -> ISR path *without* needing
+the GSP firmware to be running, which makes it useful for debugging early
+PCI / MSI issues, VFIO passthrough setups, and testing when GSP is not yet
+available.
diff --git a/Documentation/gpu/nova/index.rst b/Documentation/gpu/nova/index.rst
index e39cb3163581..1ea111988e35 100644
--- a/Documentation/gpu/nova/index.rst
+++ b/Documentation/gpu/nova/index.rst
@@ -32,3 +32,4 @@ vGPU manager VFIO driver and the nova-drm driver.
    core/devinit
    core/fwsec
    core/falcon
+   core/intr-ctrl
-- 
2.34.1

