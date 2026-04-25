Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE8BFF885C
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 21:15:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED3EE10E201;
	Sat, 25 Apr 2026 21:15:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="QnU0p4m2";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012042.outbound.protection.outlook.com [52.101.43.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A81E10E201
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 21:15:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lmFJ5Hxt1YK7hb8xoU9/yhC7OOQ0to2Nhde6/RgBZ/9+Arq5hYJhq78yvCSvtzr49zez5KOO6OVwIGF2WGmUIdeOO5n/78b7nkfaLtWzs5kUT9c0gEOEH/881ZLPiXmiSPuE+UlBNYHBGXI3YoY+ZcrHXHxaXJUX7zdExdqD3kPfoPWwkD5cpA6521ReKR1fVjuQm6h7plA8ww9QsnZH4hvCYOLRPCeeW+3OBgkDngh25K7+60ZL9Klb9Sq/+dIBRVKQ4dpK091U6II5lX3hNrcXU7eIZ+F6X7tlPD3gBokvus+Wj5J7eW1MJr4l/9bTDTohG4PdJBLgNLNREhHGQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svXXnDDuk8TcFJQAU/jIT3VtnvrD5WcGadd0UfDHdlc=;
 b=s4RuKJxWsvEomOA/AryjYh0whFs3IdWFHrpLVyCEtmVZEw4K86HJCsHQaSVdMdnBPGto93iuAZT0txC+bbGp57RYrsGpxGuwqQlxJlLvC8Q7dvEH5lf8g3PGeBQy3ART2jivaaf97XwjW2n43z+gAarCABvgn//sMdzGCYJXBftdGVWrB6ese+tmcNY3IbcT8xuEXcGUvivvXUAtwstIF4kcHV/u7CHgLsNqqKFZdcLyNW+rwam4tdbLA1mpUn3dmDV/bbyEnsUq9DreOYvIokXyh3w05Q9kqf2mKmVJOHpJa8WIbEd7NYKHmAEE4jvkp0yu7LFHRKxZkRGaZ+sttQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svXXnDDuk8TcFJQAU/jIT3VtnvrD5WcGadd0UfDHdlc=;
 b=QnU0p4m2Ukwn8AqRJ+5OXBBDunA6CrZQUvSG7StQPDVIL6b86BhquGV1ugP4u3PUTF5GT+/7NVqi74Jn8hu8JZGrOEsKdGYrOF+oiy0LjPHLE9nZ/CY+jFmEeynRz1/NAl7qnh1tDbhcrWXHg59oFGDT3LJUge4IjIzKUABMV0ODLh5U72fvUv28tsm1WmN319cIzLzOYr0vksoY3mXhGGKc/6xo/sKBY+ztRnHhGGm+lAR94hKOx/8R//LUq7Ulh2ol99pjen7XFyGtipjzyzV28pX+Pq+6i4x9FU9gb9l2RoCTE2ZSy0V9NTd0haxTkfKi1b7SDW9j2g/NSRjLuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 IA1PR12MB8358.namprd12.prod.outlook.com (2603:10b6:208:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.13; Sat, 25 Apr
 2026 21:15:09 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.012; Sat, 25 Apr 2026
 21:15:08 +0000
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
Subject: [PATCH v12 00/22] gpu: nova-core: Add memory management support
Date: Sat, 25 Apr 2026 17:14:32 -0400
Message-Id: <20260425211454.174696-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY8PR22CA0024.namprd22.prod.outlook.com
 (2603:10b6:930:45::29) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|IA1PR12MB8358:EE_
X-MS-Office365-Filtering-Correlation-Id: d3ce6e5f-0307-4472-45ac-08dea30fbaab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: uAzf4hD8HXnyXF9tue0A4Lp33SkuSTkX8puwOJENbOQYTqCVTuKMpXbY6k2f8i4OxsMi9gBH/4yeo204GYvkBIRtkPy5dick90GwFWufPoa2wFKYnLOEh9nzFWygO8G8s8AINiqK5eEDLMRG19eZFkZFPnfNYaltqXC7E0aRoiiQt154N9vQIWvWn7w7CBU8679hMDgOaqKwLlgBI1jn7xa4mqq7y2qTctIuJBTZgJR33SWQZzKr0DiMKJD4Qoe7NpF1OK7vWt5X64YhmpfI/HFJNh3UPSL8erP7gn538emDZ+s1DvlgNcKjYe1xlV8XXcHSuRC1g61S12QX14i+wgqqdDzs4uuNv5YjDS6zqr1btUf+8p8wZ9cP4egXqe6S5Pol+gjOvVDWIybHryzB7XDhTpvzGeqRU2HtcgSeAM2AGirARBFFmPprDWRTnQ6MMQgZ4z+RcduuTNoZcG5M8JYfgDvnwM2ZN2vnphLzfy3cjZUE2IJ7oilxVRPtcrwBUFGBHLz2x61kUnISS2Oj2v/esCkqKYfZV8CzfmDLcvTjO0gGwXY7q4Yc4/bhqztBI0tIJF7UQ5nOZSM5jFEuSNBRgcKCa8Rqqx9TCgG+c6r+0Yoge549a44w8PKXMuGBc2StETVcmxC7sqYehfcVq/mnNc9WgiqzS3kSALslJMUHXyR+PYYxmtvPOQ19cpkFFkjGUvn5UNUVeZRlhEgWINW3MzkIE88H387FgUVbCyE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NA/8G3pHl7J9llsozGgDXZQKDmK/u3JrXN+QiBytQEL8vyjVMcEv5hQ8E6tW?=
 =?us-ascii?Q?JmVFGxajsW8wXp5n/OK2jKMi/+kOyNdKBhNWCq13zkHa2mleplOh7LUXTpFQ?=
 =?us-ascii?Q?f8p0Okq5qe2RL7MbFovQUcavNJiKzuw9aCu2VWroQTET5VSxVamNf929VhIM?=
 =?us-ascii?Q?9VeeBwRxD4Sk+xSA+9P1rOAHhySw6eOHJ72DCye4x/+IFRaYuhBw7r1eGTdJ?=
 =?us-ascii?Q?nMkvDcy5YVGw9L5QL/KQrrSdosHJn2FlL2ZXP7gkoIAAC0i8y9Ye/HBVvBZF?=
 =?us-ascii?Q?EHKySdKgTDr/Z+39wBxA3nnz0D0A7BadygmuW2FHmWC1HFwd3glvEhpWkU+L?=
 =?us-ascii?Q?P0IVJfkUwT4HBS8bQ01c0QlTALVMl6K9N3b4416FOYTFIBJIBukfjkTOBAPQ?=
 =?us-ascii?Q?LMC/mOiz6A3Jf7/7HZg14rgScKpi9XbhWCiQjUpeVwKnqczhaaTseqivN1XW?=
 =?us-ascii?Q?CIyvWtR4kFiFv7hMG3AQyKOwRY52x2YV7Af2PVpsp8EgedSAad1cjJFfPxnz?=
 =?us-ascii?Q?jgin9+5lgOen681+x23F3P7h5puaM6sK1RkLePFJbsGvAlQZJg8wl+7MGGkY?=
 =?us-ascii?Q?oC5P4WtiPm0o1QXV+XTfnDzj88aMVf45bIqXaZfDI9CRqojGfg1vu2ljjgzG?=
 =?us-ascii?Q?KOhzKkhbLBGO55O4oDNlAstrkRhvA2Ln7CjW+0ip+BBVH4sv/T0vYS3GpcvB?=
 =?us-ascii?Q?2+PwqnMfvNXBtVbLnbukj/aq3FYN48PA3iu16rF+zWLJwbRXiLtGZ0Uayufw?=
 =?us-ascii?Q?gBNLp5zmHfysyPLHEj8vxHJs6Ghakh30HiVR2UxfdxP26EeAPzsG/UlmcCzw?=
 =?us-ascii?Q?rsk6fbLJLwuiWOJni8Vrn1VN3O1xyUtZcCY3x7Pm03JaPg/+IH4MDbiCzNcP?=
 =?us-ascii?Q?23A5MMovxnxKCW8ztwGz7wd5xOp5nYP7PIzBbxE46rZW3+MEaGSlTwrc/xTg?=
 =?us-ascii?Q?imfN2BNJj9f7Kid0eApoPDi4sNIrBUPwwXk7PnP3X0mbZBOmYBFEZ6RkMPKX?=
 =?us-ascii?Q?odexwRAKEmMuLTizKW5maIwSy/2pkB2IhUgKjOY4KQFXUCAoNjKNZcbWb8VV?=
 =?us-ascii?Q?UuEfVbo8+euM4SVqyujGU1VYfc4D4Hsx7QGZV9BIELZHP631Yl8g/vuw+lW7?=
 =?us-ascii?Q?i11UZHQeFnDtccz/7YY2R56ylEeC9F2I8KS6hXQ9sALeRo8Uu9lIb/1jGbZZ?=
 =?us-ascii?Q?2W0GW8ChOOzCvA95MzD4ObTd7Y0afFb7a9xqLyXyvFyuBPySHamjAFBLsHah?=
 =?us-ascii?Q?IL/RwgVwQvMyThLuDFeafyhJTFVuQRmfj6jPIcXssUwR/lE+eyAMj+YJigYM?=
 =?us-ascii?Q?vzc3TxLWnX+AJ5pTLnqR+JTYSJIzGMpSdpDc5Deonfwi4LfosUIIIZx/1rHg?=
 =?us-ascii?Q?GWy6oRLV7Dd+0wNrelLvbjI/REG5rFLeFZJGk0CXlzACSs10De31pTQjIlZB?=
 =?us-ascii?Q?x+53Mrn5pz2hpB7mE+/YuHK2xolhf/IQk6I6StKILQbyWyDCycXa0sOBN7/E?=
 =?us-ascii?Q?6U5KWWwpGXMAf4p1edDUgChoC1TCGr+Fd5fdC8v7AJKUp1blA8l2h1oUWQgy?=
 =?us-ascii?Q?oYbTVY9Fvi4FAxhTLGG60vM91VO9CpUZPuPnDUx8d0xM4KsabVlqv6aobs8h?=
 =?us-ascii?Q?+zG2xUZ2Zj8x5/zXI0pmK/iS0pkNhMQ9HW8pX4ruxltbCKZwSipkctq5q5nN?=
 =?us-ascii?Q?YgKT0qM49QToCdpocDe3ek+sSpCkXj5svw9YMnUWozEXFrM7YhGWcl54BJJN?=
 =?us-ascii?Q?4wIjnt9k6A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ce6e5f-0307-4472-45ac-08dea30fbaab
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 21:15:08.7531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G7mV42ix3SgD4kuhUgZ52diGness2z3q9XfuWaGZSaSF9i4ys7pkjJaEJWfHN52SptXwgksvpWIH95WnvCNu2A==
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

The patches are based on drm-rust-next and work on Ampere, and should work on
Blackwell (with a few more patches) once John's Blackwell patches are merged,
however it does not depend on those patches and can independently go in.

This series depends on Alex Courbot's bitfield series:
https://lore.kernel.org/all/20260409-bitfield-v2-0-23ac400071cb@nvidia.com/

The git tree with all patches can be found at:
git://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git (tag: nova-mm-v12-20260425)

Change log:

Changes from v11 to v12:
- Make VMM use maple tree for virtual address range management (Danilo)
- Added "rust: maple_tree: implement Send and Sync for MapleTree" sent out before.
- Refactored MMU-version dispatch from wrapper enums (Pte/Pde/DualPde) to
  trait-based generics (PteOps, PdeOps, DualPdeOps, MmuConfig). (Eliot, Alex)
- Replaces the previous `try_access()` patterns with access() (Danilo).
- Added Reviewed-by John Hubbard on some GSP patches.
- Removed the `Static GPU information from GSP.` comment that added no
  information beyond the field name (John Hubbard).
- Removed Nouveau references from one comment (John Hubbard).
- PRAMIN doc: widened address columns in the ASCII diagrams.
- Logged FB region and total VRAM at boot (Alex).
- Dropped a useless `as_ref()` in PRAMIN run_self_test.

Changes from v10 to v11:
- Rebased on new bitfield! macro infrastructure.
- Squashed Zhi Wang's "Use runtime BAR1 size" fix with Co-develop tag (Eliot)
- Refactored page table walker to generics (PtWalkInner<M: MmuConfig>)  (Eliot, Alex)
- Changed first_usable_fb_region() to return Range<u64> with checked_add (Eliot)
- Tightened visibility from pub(crate) to pub(super) across mm submodules (Eliot)
- TLB flush: added ack_globally bit for global engine acknowledgment.

Changes from v9 to v10:
- Rebased and dropped patches already merged in to drm-rust-next.
- GPU_BUDDY select folded into GpuMm patch.
- updated code with new register macro API.
- Refactored fb_regions() to use iterator (Alex Courbot).
- Renamed Pramin::window() to get_window() to make it more clear it is
  'acquiring a resource'.
- Converted Bar0WindowTarget to bounded_enum! macro, replacing TryFrom.
  Allows to use `with_*` instead of `try_with_*`.

Changes from v8 to v9:
- Added fixes from Zhi Wang for bitfield position changes in virtual address
  and larger BAR1 size on some platforms. Tested and working for vGPU usecase!
- Refactored gsp: boot() to return only GspStaticInfo, removing FbLayout (Alex).
- bar1_pde_base and bar2_pde_base are now accessed via GspStaticInfo directly (Alex).
- Added new patch "gsp: Expose total physical VRAM end from FB region info"
  introducing total_fb_end() to expose VRAM extent (Alex).
- Consolidated usable VRAM and BarUser setup; removed dedicated
  "fb: Add usable_vram field to FbLayout", "mm: Use usable VRAM region for
  buddy allocator", and "mm: Add BarUser to struct Gpu and create at boot".

Changes from v7 to v8:
- Incorporated "Select GPU_BUDDY for VRAM allocation" patch from the
  dependency series (Alex).
- Significant patch reordering for better logical flow (GSP/FB patches
  moved earlier, page table patches, Vmm, Bar1, tests) (Alex).
- Replaced several 'as' usages with into_safe_cast() (Danilo, Alex).
- Updated BAR 1 test cases to include exercising the block size API
  (Eliot, Danilo).

Changes from v6 to v7:
- Addressed DMA fence signalling usecase per Danilo's feedback.

Pre v6:
- Simplified PRAMIN code (John Hubbard, Alex Courbot).
- Handled different MMU versions: ver2 versus ver3 (John Hubbard).
- Added BAR1 usecase so we have user of DRM Buddy / VMM (John Hubbard).
- Iterating over clist/buddy bindings.

Link to v11: https://lore.kernel.org/all/20260415210548.3776595-21-joelagnelf@nvidia.com/
Link to v10: https://lore.kernel.org/all/20260331212048.2229260-1-joelagnelf@nvidia.com/
Link to v9: https://lore.kernel.org/all/20260311004008.2208806-1-joelagnelf@nvidia.com/
Link to v8: https://lore.kernel.org/all/20260224225323.3312204-1-joelagnelf@nvidia.com/
Link to v7: https://lore.kernel.org/all/20260218212020.800836-1-joelagnelf@nvidia.com/

Joel Fernandes (22):
  gpu: nova-core: gsp: Return GspStaticInfo from boot()
  gpu: nova-core: gsp: Extract usable FB region from GSP
  gpu: nova-core: gsp: Expose total physical VRAM end from FB region
    info
  gpu: nova-core: mm: Add support to use PRAMIN windows to write to VRAM
  docs: gpu: nova-core: Document the PRAMIN aperture mechanism
  gpu: nova-core: mm: Add common memory management types
  gpu: nova-core: mm: Add TLB flush support
  gpu: nova-core: mm: Add GpuMm centralized memory manager
  gpu: nova-core: mm: Add common types for all page table formats
  gpu: nova-core: mm: Add MMU v2 page table types
  gpu: nova-core: mm: Add MMU v3 page table types
  gpu: nova-core: mm: Add page table entry operation traits
  gpu: nova-core: mm: Add page table walker for MMU v2/v3
  gpu: nova-core: mm: Add Virtual Memory Manager
  gpu: nova-core: mm: Add virtual address range tracking to VMM
  gpu: nova-core: mm: Add multi-page mapping API to VMM
  gpu: nova-core: Add BAR1 aperture type and size constant
  gpu: nova-core: mm: Add BAR1 user interface
  gpu: nova-core: mm: Add BAR1 memory management self-tests
  gpu: nova-core: mm: Add PRAMIN aperture self-tests
  gpu: nova-core: mm: pramin: drop useless as_ref() in run_self_test
  rust: maple_tree: implement Send and Sync for MapleTree

 Documentation/gpu/nova/core/pramin.rst     | 123 +++++
 Documentation/gpu/nova/index.rst           |   1 +
 drivers/gpu/nova-core/Kconfig              |  11 +
 drivers/gpu/nova-core/driver.rs            |   3 +
 drivers/gpu/nova-core/gpu.rs               |  99 +++-
 drivers/gpu/nova-core/gsp/boot.rs          |  12 +-
 drivers/gpu/nova-core/gsp/commands.rs      |  18 +-
 drivers/gpu/nova-core/gsp/fw/commands.rs   |  60 ++-
 drivers/gpu/nova-core/mm.rs                | 267 +++++++++++
 drivers/gpu/nova-core/mm/bar_user.rs       | 400 ++++++++++++++++
 drivers/gpu/nova-core/mm/pagetable.rs      | 418 +++++++++++++++++
 drivers/gpu/nova-core/mm/pagetable/map.rs  | 355 ++++++++++++++
 drivers/gpu/nova-core/mm/pagetable/ver2.rs | 306 ++++++++++++
 drivers/gpu/nova-core/mm/pagetable/ver3.rs | 431 +++++++++++++++++
 drivers/gpu/nova-core/mm/pagetable/walk.rs | 258 +++++++++++
 drivers/gpu/nova-core/mm/pramin.rs         | 515 +++++++++++++++++++++
 drivers/gpu/nova-core/mm/tlb.rs            | 130 ++++++
 drivers/gpu/nova-core/mm/vmm.rs            | 370 +++++++++++++++
 drivers/gpu/nova-core/nova_core.rs         |   1 +
 drivers/gpu/nova-core/regs.rs              |  77 +++
 rust/kernel/maple_tree.rs                  |  29 +-
 21 files changed, 3868 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/gpu/nova/core/pramin.rst
 create mode 100644 drivers/gpu/nova-core/mm.rs
 create mode 100644 drivers/gpu/nova-core/mm/bar_user.rs
 create mode 100644 drivers/gpu/nova-core/mm/pagetable.rs
 create mode 100644 drivers/gpu/nova-core/mm/pagetable/map.rs
 create mode 100644 drivers/gpu/nova-core/mm/pagetable/ver2.rs
 create mode 100644 drivers/gpu/nova-core/mm/pagetable/ver3.rs
 create mode 100644 drivers/gpu/nova-core/mm/pagetable/walk.rs
 create mode 100644 drivers/gpu/nova-core/mm/pramin.rs
 create mode 100644 drivers/gpu/nova-core/mm/tlb.rs
 create mode 100644 drivers/gpu/nova-core/mm/vmm.rs


base-commit: 74a720e00dfbb3ab92934660b4692b90331623ac
-- 
2.34.1

