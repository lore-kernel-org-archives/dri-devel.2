Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECA8CD4F52
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 18:03:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC90310E978;
	Mon, 18 May 2026 18:03:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="rY5nOyem";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011027.outbound.protection.outlook.com [52.101.57.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4799210E97F
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 18:03:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGL2wGjwWqd3jbtEjSWX8wGiyPawP14u2JQes7wDWEenlAL7WaR+msrZUAupfmlP47pWWdvCHxkbNgzJhom/BPr/zeBU3+iKqOTt1czu/iRUuyWHnQCIY3VmJjnNjdP8B9osquRHgZj6083H16tXdJGcXbr4zDAxB2jpOwhBOFPaGl1g38FjPDXjNj1eUsC2WbFqSY97lpghxLgT4YwgdwrVk8pSiahRqZjYTMw4uOH7SQQiP+UO0hwTl9c/XvzN1ypmbwc/b+lYtoXaSntP1resNZYp7N75mQlJ0SeSUndFCnKEp9CocdnunAuy6nWLXw0rfrKyVPtG3K8zlKPe5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8FiRSIHOCK9wOA9iQPRx1UMLNB5gOQbZbj4pML08/c=;
 b=mSolBUb4AEVp1y2oJ3WQo4KdOVw35IHrN47vhgGYfJG+MmgcfbLsyjUjW9Nu3L6LjzbDFezq1R7qWq8J1MZ5aZQYfBTibxaC5xwvF5oqvntLOi6wORStQN5daxd+ex47KOgDYe2BCaNhTPqiDbLGuUMHFSmrWCdLeUp5BIslEy/xZjLM0mn64mYC7UTN44zJv22j7oOsUq5jbYbZdFE1UDwvDUzASAXBMHCF9irkPmsCZwzkVprVeWm8vuPBDWTeepuITSHhdl9CdrLraQdhd2Tq5DMLE/GSrIISzYQpuFTIajsiw911lqHTb6yEL3BA8D30szzdhzC3j/j0wWSngw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8FiRSIHOCK9wOA9iQPRx1UMLNB5gOQbZbj4pML08/c=;
 b=rY5nOyemrKRiUecg6PN5gBAJeXVEybc+O/0NvRHxJf/GIDh+HY/aAe/i3MYZqIdrTS0/ARq39eQZcj0/vu0BA1a75e7djDfoxgnq9tY4LS5c81iN8SSydBX44IeQrf3dJnTfIvLlu5svytVhqFs7fFgrx3TfSZf/DDoY9Rl8q+9WYZpgoQavc0iqPRY+SMNEInkXeISD6nNyBxT0r5rQbkCcLUplurgbhIZwV81GxTXQx4H7HY1n0bMwg1cPpxSOm2EiqcUE5Ydux2tUKTxb11yiwsM/ptWpTA8bLroLqbST6CJRTNUdK73rgC3Zo99wvQWpHfsTZudz+Z1nLs5QeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SJ0PR12MB8114.namprd12.prod.outlook.com (2603:10b6:a03:4e8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 18:03:46 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0025.012; Mon, 18 May 2026
 18:03:46 +0000
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
Subject: [PATCH v1 00/12] Introduce nova-core mm prerequisites
Date: Mon, 18 May 2026 14:03:30 -0400
Message-Id: <20260518180342.2387845-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR03CA0051.namprd03.prod.outlook.com
 (2603:10b6:408:e7::26) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SJ0PR12MB8114:EE_
X-MS-Office365-Filtering-Correlation-Id: a0ddd1c7-2659-476e-692e-08deb507cdf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7416014|56012099003|18002099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info: J4A6rQM/OqSXrljg1ZH5hwuTbF57Lbf41ajjSTX7z59/CMKzqUo+VN7ZjO+hjRcMLMA9RmtJ+aHYVGojzCTjyJaRfaR94EnxAqviTNM3mSrIvQFFjgTj5ZCg1tsLDadJgfe+uKYEsTRc6eki9yrcCeALemNUOMMdQr3WbntBvv6HaGouwkQzRpDTtFWqPB9LwkgrMopApmpHt3Oq5sYLKU/MzT9p5ZAhmd5jSCEUgRd/3f9cYsKfd+NhWFKJ/ixn8sMPboM1b0gX5qEbKW3sztQ2G45hgE1Sl/2FD2VvLITWkkEgF1elBUPOwOmCToVJqJmg5nx5OOmB5BWmR+Pwd7DgduTzlI8+5Qfe7xxNkfBwcSzOc370bh1q8yzegh8GdD4J/zA7auHvZglpEIVwuxa/NGjI606+H+9LtDE0WayNrwzNzv4PvjLJWKVcGQZUrCpj91wO8wzV6NLXaDXX2+dIudQquWBHOCQKVpu0sNnHte+j+OdS6IYjyxp5+0IoY69wLTtOvLG7BtFXLNuPmiTnyOVZqGP6PkMQVllFz4TCFUZXqmqyH4mAChVxie7ZtLjVN/0Sort4xZxonbbo/lvXC961+MhfahyNoTU9EEcPWhvaW6Ezj1w5qJdK9k3dzXBTD3DKftJKNPUC7P6ObtI/alWRvjQMA8W9QDyTfdbIuu/+gpZm9zYC2Ai4wrU3L1U2Yys3jLlOp0WTTHWqew==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014)(56012099003)(18002099003)(3023799003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9ZRO1MPozvIfH9zXsFlz/LfBQqWo9UPUOA9PxeaPfQafK3RYHRWIRlzvYLIN?=
 =?us-ascii?Q?qx1WDXRk/6VWtbsOfrXQHpruDHxefwL2R9yv0lgyiL5NVc8HoFgWTP/0AqA8?=
 =?us-ascii?Q?WN/9xelm/cMG5eYV11if4+2i+BvodjAmhPtvrqQ9FA74eYA1UmbwtY88Nf3r?=
 =?us-ascii?Q?vy34aIkViOz7ouj3d53t493fUZ2U63/Iq+P/sRLiLwCUw+vfAk/nqzMJ+VcJ?=
 =?us-ascii?Q?a7AvctxaNiOGMMN+Y5uak9x5UVIiHt8i3UQV4ET7w5UFwj8x54b5ngokVhq1?=
 =?us-ascii?Q?Qgq7E0IzZhLO9RYXF2KjahwL1V+g7L+zop40kpOZDCgcY8LNvzoPg+jZJjmb?=
 =?us-ascii?Q?xaUESB2A0QhjLWMYthfA0zZx0QYr4yz2kAs7x25Ew1tyK83OdNFKvaDIqelp?=
 =?us-ascii?Q?ogJpgIpoXpHfTyGE4v/RDpLz10ktnouFf1vo+4ugVm9G5XTIXyeyM7fkVUNc?=
 =?us-ascii?Q?JQ2r3qQ3+ci/R6YGhWDKMrWsCg8WUw2H1cxLwkIetZGvF3SW1VzfrOBbYmSr?=
 =?us-ascii?Q?OZ07Igs+jPAFBuZTIQwcvqFz/HKq+7q1NhCxKIrU7m65SFpvFqUPJTA+pgS1?=
 =?us-ascii?Q?0O0WzoOpqnKhVRgjPtkXRzh3goSXcwOLaicB19nJ92rnFtq66kOhWRw/YzPV?=
 =?us-ascii?Q?1WAYDADyng4nVQsADnfa0DaZMVR1nZxP6oIhGXDmP2DxA+S0k1WvjSRTpFSm?=
 =?us-ascii?Q?ikm1LdXtaw9hKAftOrgNeXJ/qqz5OK9YaxFJX+uQKSVlXMtTFLxmnD2M0c7o?=
 =?us-ascii?Q?heTKK/e/zGqAPYO4SltbU962/SE26kEd9YLSpegnbBZw8TJnjroD/ziL5Ql7?=
 =?us-ascii?Q?WjKiFmL1h+BqyvhAo4C8irSAGRPverPCohZXxYLSJpA+8bk77XyTaqxknLAl?=
 =?us-ascii?Q?Bfrq1vWezjr2bpKxlYeLprotyClgKwusM+j+gMGfX2PiIQLRNlqYBVSB6BX5?=
 =?us-ascii?Q?eOaZMyjZWR+rAavhFWuNRCYvGTg/1mS5nwRHV97pehzuNTmTYcDy4+bgf7Yk?=
 =?us-ascii?Q?IIMhGqC3xBhgg1KRfsHvtavwLAywRnQes6ND5LMnhwmVi3MYhnLAnRHQpZZv?=
 =?us-ascii?Q?esv3QBWUYHuWu1cevjmoWoTPTU3Ae3jhhvxkRZhRVB6rGG6peiJN9nVIdtqP?=
 =?us-ascii?Q?73EkLIiQkDdnPG3J4HqlRtw4b2ifO723w0VY2jvikENcEd0FUrn19SQRW+HJ?=
 =?us-ascii?Q?Jt4ihtCEtoWc28Y5IdgP34JCv25rxAOtQ0N+7wsvwOIsbiRvZGrrnWNlINSp?=
 =?us-ascii?Q?W00/vGs2hXzf+wuNhti88YolhjDbho1y2ixKfAA9qyyDM+JOuT9vXsLUU1en?=
 =?us-ascii?Q?xUL2lNm++FSzHfM5KwDucvDGEUCPyxLi9UWfmOfwYKYR9A7dfe1qAn9fe4o0?=
 =?us-ascii?Q?23vL7VpDHI8SHz262hCsPpEKE7sFKrJMHjQCRG/p7OeykflfmvO03ekEcqiN?=
 =?us-ascii?Q?fmP4gdNAZb2ozfMhW1u+vSwuhCI2YVhzYQ8IXXgb4P8u4EZ7yGr1NkoiImqr?=
 =?us-ascii?Q?RIChFrXo6Sd4gB1xSdxBhjDPCYBkgsrPxW4AAA1uockYE/UND4SLchbNVAR6?=
 =?us-ascii?Q?vsxTDFNXopPsGq2HrJ3CaXLNg+Mg/7tFnAtOlZbvuTaIxtuQX5RFfgb4LHOY?=
 =?us-ascii?Q?DRTS6ihAd4FVziiCc3evDht6S1WU1KyMPkVSjGEmM4h6fbPogBNNACnynU62?=
 =?us-ascii?Q?sMjqpmr+6UDGSGROrnzNG+ZBjx9FTxqaYwjXMffRZLay/6RkQ/3zOxEOkODB?=
 =?us-ascii?Q?1wfWk8H8Mw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ddd1c7-2659-476e-692e-08deb507cdf1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 18:03:45.9380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: plc2V/p2aqSAh/jBlUP2ZQCK0BDQr17EEKxlTfjrFSvRAJK2h0kbffthhAYKYcf19nhTxnHmFZpcxWBCpWLSOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8114
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

This series introduces the prerequisite memory-management infrastructure for
the nova-core driver: a centralized GpuMm manager, types for addressing VRAM
(Pfn, VramAddress), the PRAMIN aperture for indirect VRAM access from the CPU,
and the GSP plumbing that surfaces the usable FB region and total VRAM extent
at boot. It also picks up two small Rust enablers (pci::Bar::resource_flags()
and a cast+shift accessor form of bitfield!) that the rest of the nova-core
mm code relies on.

This series is based on drm-rust-next.

Dependencies (not yet merged):

- Alex Courbot's bitfield series. Tested on v2:
  https://lore.kernel.org/all/20260409-bitfield-v2-0-23ac400071cb@nvidia.com/
  A newer v3 of bitfield is available and should also work (haven't tested):
  https://lore.kernel.org/all/20260501-bitfield-v3-0-aa1076c3337d@nvidia.com/

- rust: maple_tree: implement Send and Sync for MapleTree (v3):
  https://lore.kernel.org/all/20260511143604.3848176-1-joelagnelf@nvidia.com/

The git tree (containing the dependencies above, this series, and the
follow-on page-table/VMM/BAR1 series) can be found at:
git://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git (tag: nova-mm-v1-20260518)

Change log:

Changes from v12 to v1 (split-out):

- Part 1 of 2; the v12 series was split for easier review. Page-table/VMM/BAR1 patches in companion series.
- Broke v12's "Add common memory management types" into atomic patches: Pfn, VramAddress, VramAddress arithmetic.
- New prereq: "rust: pci: add resource_flags accessor".
- New prereq: "rust: bitfield: support cast+shift accessor syntax".
- "Add GpuMm centralized memory manager" scoped to scaffolding only; buddy/TLB wiring deferred to companion series.
- Squashed v12's "pramin: drop useless as_ref()" cleanup into "Add PRAMIN aperture self-tests".
- Moved "rust: maple_tree: Send and Sync" out as a standalone dependency.
- Smaller code touch-ups across most carried-over patches.

Link to v12: https://lore.kernel.org/all/20260425211454.174696-1-joelagnelf@nvidia.com/

Joel Fernandes (12):
  rust: pci: add resource_flags accessor
  rust: bitfield: support cast+shift accessor syntax
  gpu: nova-core: gsp: Return GspStaticInfo from boot()
  gpu: nova-core: gsp: Extract usable FB region from GSP
  gpu: nova-core: gsp: Expose total physical VRAM end from FB region
    info
  gpu: nova-core: mm: Add Pfn (Physical Frame Number) type
  gpu: nova-core: mm: Add VramAddress type and conversion traits
  gpu: nova-core: mm: Add VramAddress arithmetic and ordering
  gpu: nova-core: mm: Add support to use PRAMIN windows to write to VRAM
  docs: gpu: nova-core: Document the PRAMIN aperture mechanism
  gpu: nova-core: mm: Add GpuMm centralized memory manager
  gpu: nova-core: mm: Add PRAMIN aperture self-tests

 Documentation/gpu/nova/core/pramin.rst   | 123 ++++++
 Documentation/gpu/nova/index.rst         |   1 +
 drivers/gpu/nova-core/Kconfig            |  10 +
 drivers/gpu/nova-core/driver.rs          |   2 +
 drivers/gpu/nova-core/gpu.rs             |  48 ++-
 drivers/gpu/nova-core/gsp/boot.rs        |  12 +-
 drivers/gpu/nova-core/gsp/commands.rs    |  16 +-
 drivers/gpu/nova-core/gsp/fw/commands.rs |  49 ++-
 drivers/gpu/nova-core/mm.rs              | 247 +++++++++++
 drivers/gpu/nova-core/mm/pramin.rs       | 512 +++++++++++++++++++++++
 drivers/gpu/nova-core/nova_core.rs       |   1 +
 drivers/gpu/nova-core/regs.rs            | 122 ++++++
 rust/helpers/pci.c                       |   6 +
 rust/kernel/bitfield.rs                  |  67 +++
 rust/kernel/io/resource.rs               |   8 +
 rust/kernel/pci.rs                       |  14 +
 16 files changed, 1228 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/gpu/nova/core/pramin.rst
 create mode 100644 drivers/gpu/nova-core/mm.rs
 create mode 100644 drivers/gpu/nova-core/mm/pramin.rs


base-commit: 9bd99adf7cee4b8ed4adecd53269010250a0d2ec
-- 
2.34.1

