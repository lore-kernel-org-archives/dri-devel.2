Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A5DCD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 18:11:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76FF710E98B;
	Mon, 18 May 2026 18:11:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="g3GyudFu";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010068.outbound.protection.outlook.com [52.101.61.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 640C710E985
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 18:11:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Clm6tM9+w1jPnKyjWmjmLOm5ovS4W3oIJcxME1yw/MOdvL9Fofn3QetrJ9AxoHgPL0usM4A9EWWwlkGghByMZaPWxCma02KtbWgEo/5tjamxW1ijjt5B8eFaHnZy4opLLL55GxMqlvLLNAxWGFeY7mllHBst3QPV5TBdXhdrTdeiJPSiKTVCIrUmSOdbfRWg22KcinAlzS9clUA0Z22ij+ozbdxAkHaHSpvJb3HwaXXWCzYKf6gRd3pDowLxs2DKESJENsW/wUq8s+cOfLmM7mwP8pxO6XSKnzA59xrs0k5HCGifgXTK3fyLv52yNTzXi6ApRaqghTvyfRMWgzNmQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBb09YLdV5uBXv4oU3uXNRNQvF3L4n/qZi9xwplljt8=;
 b=Jb5s2+xow8bdGH1xduX6Dz+cjcOUCi2YWUu9yViy4MOSpbsOLsoGL9ysGsxulqUxSTWvxlaeFLZ2jdcP6Vd5FLrGSohCY4LDmH/NKHxG70w/LqQCKw/yh5Pnxhq2CSQHLkaTpA2YIiyyFBh+R4C5b01aCAQxUx/XE8mGoFEqepjrRK+IWfuCzFrh9jA177tb8osoyF9IRZikbptpRGFuEOYrqQQtUhdBeortgpKrKUdI/JU/k1GsibJgOzDETUfVwxA4Gd5uCzUkTaTp1BdLkF6+OsjhmgF581uKdb3HWjkWWofghknPFX2P989u0l7luvvMHDRS4pnr3Q4OublP6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBb09YLdV5uBXv4oU3uXNRNQvF3L4n/qZi9xwplljt8=;
 b=g3GyudFuFovISEEHu444q4rxa5Tv/eaYwoiU6jJrdW10N+WsXl8pjX2TUGwrs/zksKfrKohaW3RqaLwkxQMdHtyc+YF5O2hkwjpvf21zfKFx3G0MO2HDsPt5mcFeg+2gqdva6dU+PzC9BHsD9yoXkvgLTMrd9kApnJtTYOBnXXIZmN8mJKsQQzTt8tIAobcmSy4/OfpjaNMlMMvIXnuDpQ9OMJV1F/CrXAHt4AMEv2RCqnANFlqonUmiQ86MdPKKB4J/R7Dz46qPzfrvRCvTuAhuVL/dDphWlUOQR07h+7gZR4aPlO+Lzq2dDtrf8XSvNIIivWvscCnTNfpDXnCn0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 BY5PR12MB4276.namprd12.prod.outlook.com (2603:10b6:a03:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 18:11:31 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0025.012; Mon, 18 May 2026
 18:11:31 +0000
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
Subject: [PATCH v1 00/16] Introduce page table types,
 vmm and bar1 mapping support
Date: Mon, 18 May 2026 14:11:09 -0400
Message-Id: <20260518181126.2493572-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0040.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:5b6::13) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|BY5PR12MB4276:EE_
X-MS-Office365-Filtering-Correlation-Id: 70885ea7-d717-40a9-8fed-08deb508e33d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|18002099003|56012099003|13003099007|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info: RmwR7r30Y/rGLHL1J/AwdmX1Yf1TBXefoe5vJOT952yr63AWeNwddz2A/fiajsNqeeus1UNEWfCN1hx6XtAMopyyxy0ieMo5b6uMxrOrKC57xo6T4ku2OXGV4M9mQofbWo6PMURx8W8bkwXpcf0duut/jIj6z+HFXrUd9U7mtTJgVltyL4EpyVJ9MGXSsnqIWtXxNCVOOmnnefxgR/rsWBpICN7fc39W1mTdpWuRe0mdoJ/+CfKD1OFRskoZFjdrFaRPvYfEmDpcahx22pmaAK85gvdWy0KiRD0ZukA/L0ByRl+3dF7zya6jFMy6t/JVJ2FivrgcIW7dbH7/RJpxqo0plDIyH4hYA9DLamyvc4LUijlNeDbtzXZC2i46fnJhAji5BtyOgDJ8Uciw0+fDu9E+3RAKzIyog1hYpWknLlVKyA2eiTvtkjSdVVj6gQCr3LS0x27sGaaLXQnAbvRO8OJVl5v6XvmAqke6qKPvsIIh7cKJoys0uAwSWvc3+aJ0vGxSjKfsyDbyih34mGNdjnGnL8L/0dhBhEkYdVtbcQ1N3fPK8HGDJlBAgowk5meRVBbF8xOVzB7OdPhziLr3v9eK7H8DKUiw5Uaya4hvHsVPFQMzvbjSQjn1iy4E5Jm1XvdLRDaEgoQr2ocHSUahX1Vjpc1q3i4pYHzo2bJIbiECaOdESwJ19OBEZr0rELbD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(18002099003)(56012099003)(13003099007)(3023799003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?htC5gNFomwASQ2wtu4dfUKZDaFqJcumVB6MxRUa49BOBScX0YLnYBoimjyVq?=
 =?us-ascii?Q?TTZDi7Rh8ShsTCouDe4/tzmfL9ewZkp1WlqstCpKaGjondcUvzII64RlZiJ/?=
 =?us-ascii?Q?tRJy9kjyphB4BuqQMp2EVLLOpXfHpFChXhyFuG31aMZDlqeoAbt0xD0tB0L4?=
 =?us-ascii?Q?XzxIAlJDqA8dFaf8RMUSrJ4x5HYs/I59xRfNOLodQVmJ163qxo3UdstnJ5a7?=
 =?us-ascii?Q?eeI/1AGd10C06+UT9bTlddKHSY2RwOfgIye6I366Q2N7YnRNuTvhcpVN5j92?=
 =?us-ascii?Q?TIowTcLpEbZmutye0/Xz4vSgse0Q6TK/2C9rP+3DKb4TpzKt2Ta8IFviEhVf?=
 =?us-ascii?Q?pZwwwvO64K4tWu2TuuJ+j2w1hyZKz4MZP8mrQ+KSqkKK9syAel6MMyWCbEeN?=
 =?us-ascii?Q?WaWC2Ek3FfgNd5VULfB2WLw+KCkSUOuax7Vk52bCzp0/hZGGHWcN7xZKV0pn?=
 =?us-ascii?Q?fsm3qmmPAhwxOzB56ZBTt0to2u9tka4i/YKGIn1YzRvbL2bMlGra20NmrMpz?=
 =?us-ascii?Q?kBYhsxBlQ9MVHLqwVisFPhvtz3as9GrTxa5kW+hfGydLKNBxO1nZfVYpQomT?=
 =?us-ascii?Q?K4sTXAqQxh2IUn+saFTF4tFXGaMyIWMkemi5NUYUJXUNMurrMaz54gaooAMX?=
 =?us-ascii?Q?bHI7/dMMs2UEX6rzia7t2SPhqqBz6VqKgu/Rd4qYiQ91jkN+Ee5EL8BPYrjt?=
 =?us-ascii?Q?ZJcMtEnD+tuG7+2k4HRAvRYZxlkFG7LC/SK+6UEkIrzfxvR8eNedKVLBWlhl?=
 =?us-ascii?Q?iLXBU7C0s9xL74+LTw+KFGfoEfGdTv6Qcp2JF27bjIXrWPH7XxgMShQ9mxwO?=
 =?us-ascii?Q?FxaO3lI1jB4Sr7nVH82B9pGFHAjVVD+fuEW3nJtkee3X6hKGFe6F27D1RuSw?=
 =?us-ascii?Q?PxCrOCfe6sAtNoNmFdYR7BnpbJlHdLk2Er7t6PPSHUubp4l8lJHdEMGY4LPQ?=
 =?us-ascii?Q?LAgfJrFQUrEBOot3NwtJVoGXDiQmvIvrc+ZXKt7rt5kisk4HaGFV8eCQToD3?=
 =?us-ascii?Q?gkWcq26n7EAmOg18BYrGWuWT2jckX306zxQZkxjNWbEL8l77hKzYLe0AAjL7?=
 =?us-ascii?Q?jz1aBl0KMk8rJC3FyxMejOaV2IvYGicFxSL1k1SIRkWdSFab5ZlRI3QCPRBs?=
 =?us-ascii?Q?QJ1jHJ6ilSDbPZBAp6U4oHYQrqiNAnZz5ttc5JyDJuvoFPYADLAHSEVa1LW5?=
 =?us-ascii?Q?NPbvtsQSTOhGgZTG9XUipmjqsWjmcornHCQ5mHwObFl6kBNtwLP+prrjd6Ra?=
 =?us-ascii?Q?rO7SCJ1/oLafu6EIOca6McBIKUhZjmSD/r6PBpU1o3Gl9EW9WNqdKT54e/v2?=
 =?us-ascii?Q?IOBAmuEN15vjrElawjzhQ6WDkbEazmaSciIAxb1ZafQ+bwX8w6zJSTAUuwgv?=
 =?us-ascii?Q?o3PR3BAYCYXvAkPKvKfElNeI19ZJThW/yNIINWIF2/ThY648Wir6is9IKoqM?=
 =?us-ascii?Q?UiBvAN+3CdosvE2OMf5IFD0i7Zympy+H0TxCW/asaV1pYOejs5TzURnaE+5r?=
 =?us-ascii?Q?X2hzxDtkEq3SBal60LfuY86S9CwRpLMzslRJqfsSp6hiGe4DfuihAc0LQgHv?=
 =?us-ascii?Q?otbZmSYS2hGsn3Qvf6FOCqhFZT7js/jV8wybFwFhXvKLPZJwoxWWpOVYK/TT?=
 =?us-ascii?Q?+WgpJi9FCov2Ceee/ucLRIHPIbdRQa9PojMdt3xdKKkLtpeB5HhRPLVEDDeQ?=
 =?us-ascii?Q?xUfq3FqgJLzMKVdNQ/RtEwNPoKEcOvj08y51tu54ByOfuPkdZ0bL+HpVaH00?=
 =?us-ascii?Q?k/fQDIYAWQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70885ea7-d717-40a9-8fed-08deb508e33d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 18:11:31.1587 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NEBcwC0sR5vHzalUSbe4xx49s24wIOCogWIBHPdiOc7XaYDoplGOpzwfhP3U3jxw5dKQazoNSCO4bg0g7w6yxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4276
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

This series introduces page-table types and a Virtual Memory Manager (VMM)
for the nova-core driver, plus a BAR1 user (with selftests) layered on top.
The page-table layer uses trait-based generics (PteOps, PdeOps, DualPdeOps,
MmuConfig) to dispatch between MMU v2 and v3 formats. The Vmm tracks
virtual-address ranges with a maple tree, and the BAR1 user exposes mapped
CPU access to VRAM through a small allocation API exercised by the selftests.

This series is based on drm-rust-next.

It depends on the prerequisite series "Introduce nova-core mm prerequisites"
posted alongside this one:
https://lore.kernel.org/all/20260518180342.2387845-1-joelagnelf@nvidia.com/
Please apply the prerequisite series first, or pull the git tag below which
contains everything.

Dependencies (not yet merged):

- Alexandre Courbot's bitfield series. Tested on v2:
  https://lore.kernel.org/all/20260409-bitfield-v2-0-23ac400071cb@nvidia.com/
  A newer v3 of bitfield is available and should also work (haven't tested):
  https://lore.kernel.org/all/20260501-bitfield-v3-0-aa1076c3337d@nvidia.com/

- rust: maple_tree: implement Send and Sync for MapleTree (v3):
  https://lore.kernel.org/all/20260511143604.3848176-1-joelagnelf@nvidia.com/

The git tree (containing the dependencies above, the prerequisite series
"Introduce nova-core mm prerequisites", and this series) can be found at:
git://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git (tag: nova-mm-v1-20260518)

Change log:

Changes from v12 to v1 (split-out):

- Part 2 of 2; depends on the prereq series posted just before:
  https://lore.kernel.org/all/20260518180342.2387845-1-joelagnelf@nvidia.com/
- Kept the virtual-memory portion of v12's "Add common memory management types" patch here as "Add common types for virtual memory management".
- Folded v12's "Add TLB flush support" into a new "Add buddy allocator and TLB to GpuMm" patch.
- Split v12's "Add page table entry operation traits" into PteOps, PdeOps, and DualPdeOps trait patches.
- Extracted "Add MmuConfig trait" into its own patch.
- Moved "rust: maple_tree: Send and Sync" out as a standalone dependency; VMM's maple-tree-backed range tracking remains.
- Smaller code touch-ups across most carried-over patches.

Link to v12: https://lore.kernel.org/all/20260425211454.174696-1-joelagnelf@nvidia.com/

Joel Fernandes (16):
  gpu: nova-core: mm: Add common types for virtual memory management
  gpu: nova-core: mm: Add buddy allocator and TLB to GpuMm
  gpu: nova-core: mm: Add common types for all page table formats
  gpu: nova-core: mm: pagetable: Add PteOps trait
  gpu: nova-core: mm: pagetable: Add PdeOps trait
  gpu: nova-core: mm: pagetable: Add DualPdeOps trait
  gpu: nova-core: mm: Add MMU v2 page table types
  gpu: nova-core: mm: Add MMU v3 page table types
  gpu: nova-core: mm: pagetable: Add MmuConfig trait
  gpu: nova-core: mm: Add page table walker for MMU v2/v3
  gpu: nova-core: mm: Add Virtual Memory Manager
  gpu: nova-core: mm: Add virtual address range tracking to VMM
  gpu: nova-core: mm: Add multi-page mapping API to VMM
  gpu: nova-core: Add BAR1 aperture type and size constant
  gpu: nova-core: mm: Add BAR1 user interface
  gpu: nova-core: mm: Add BAR1 memory management self-tests

 drivers/gpu/nova-core/Kconfig              |   1 +
 drivers/gpu/nova-core/driver.rs            |  22 +
 drivers/gpu/nova-core/gpu.rs               |  71 +++-
 drivers/gpu/nova-core/gsp/commands.rs      |   4 +-
 drivers/gpu/nova-core/gsp/fw/commands.rs   |   8 +
 drivers/gpu/nova-core/mm.rs                | 108 ++++-
 drivers/gpu/nova-core/mm/bar_user.rs       | 447 +++++++++++++++++++++
 drivers/gpu/nova-core/mm/pagetable.rs      | 414 +++++++++++++++++++
 drivers/gpu/nova-core/mm/pagetable/map.rs  | 367 +++++++++++++++++
 drivers/gpu/nova-core/mm/pagetable/ver2.rs | 271 +++++++++++++
 drivers/gpu/nova-core/mm/pagetable/ver3.rs | 421 +++++++++++++++++++
 drivers/gpu/nova-core/mm/pagetable/walk.rs | 258 ++++++++++++
 drivers/gpu/nova-core/mm/tlb.rs            | 130 ++++++
 drivers/gpu/nova-core/mm/vmm.rs            | 361 +++++++++++++++++
 drivers/gpu/nova-core/regs.rs              |  65 +++
 15 files changed, 2941 insertions(+), 7 deletions(-)
 create mode 100644 drivers/gpu/nova-core/mm/bar_user.rs
 create mode 100644 drivers/gpu/nova-core/mm/pagetable.rs
 create mode 100644 drivers/gpu/nova-core/mm/pagetable/map.rs
 create mode 100644 drivers/gpu/nova-core/mm/pagetable/ver2.rs
 create mode 100644 drivers/gpu/nova-core/mm/pagetable/ver3.rs
 create mode 100644 drivers/gpu/nova-core/mm/pagetable/walk.rs
 create mode 100644 drivers/gpu/nova-core/mm/tlb.rs
 create mode 100644 drivers/gpu/nova-core/mm/vmm.rs


base-commit: 03f35250485a1f78f5055c034ce7073b4c887636
-- 
2.34.1

