Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C862CD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 18:11:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6E7C10E98F;
	Mon, 18 May 2026 18:11:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Si9ZtBGN";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012028.outbound.protection.outlook.com
 [40.93.195.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7879E10E98F
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 18:11:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNokc68T8euCJf5Jm0HlB7vV8MDZyo/ggzid+g8ih7c9OrCi0ajzBVxo3E2HKX2TsZe9CGolblyrP7xJXa+x08bwHo0iprYChCytHkdVr7oXWkSxVAaxdTi4qiyFucgW/wq4HXXvXKTZy94D+ufUGF67Ra47fUWFrB7ul8ba5OIxTTKiyQP0UL/wblgOQ3uDBWkizz7G4MfdYurgUIYzKf882s4AQaIhMtQmmGhTb5n01WJNdvUoxcrZ8u0XSjEk+pQktJpMGPlFBSrzu2VaAyimQ4b6kJGWa2wwkUWmRdozv3HjaxSbX5BCs5Ha7tb5V2YbZsw6qW/4ieGMZ8IKHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBW7pWoxOFgGQM3PBbQqMnhUI3dYkbqbl2IpBEzfP98=;
 b=bH7RRERnCdHhjY1fMxWoX2pxVLbQbvO6XD9TgZxl8ABQJfjXmYVOJVf2hLKhr+nWk9pUyl1wDjRLqZO1QgpcsxnDvkoDZe9nEs9+y2ijuwzJb+Vrc/+gggTnoZ+0i4eNArw5xXPSnF8G7g8JH4FD/oYfSkyYeNTr93CVgSYExGGKACm2GTcAFtYXpc729cdmVca2ZCDFTYO1pG/07b26lGoWRC/U3Mlf9xkjq3FqAt++CLc8W3lRRIw5eD9pw0UBHXDNXdZCNC35zbw1SIGCjn+/ODnX2dBXCSvPC3HZ2WhzwQwDSrVENgxTtl2ZPZbBZkva3UhC9zRpNwxiw52E+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBW7pWoxOFgGQM3PBbQqMnhUI3dYkbqbl2IpBEzfP98=;
 b=Si9ZtBGNa1AXKoYpz44L7BtzRb0G7JRpdSe/mpytu/Ety0OgBIknu0iPcYns7Bw94kfCJtifMmzH8wY483fY4kjf0lk/C4Ug9ZgEUj/DeiYyXtd7HTHubynmgizDEOiflgXrJBp1UNTaDiQLCK7ZRGzDpf0EW9yVbZZHRVoK6CaLLh4YVnDd+3hkYY9+f3HGii10fD1F6z6jJIU5SUdsejkM/vjfolVf0zNE26+/h4MzoqE/462JkABfD9cMSVougx4/RT2kAc8boLhSAXzKrcdB7DioNcODN8GpWpzZTb9XYOzxkpGVeZmmUTnX5UCtHWoyoVMLtb0SKkgSleyvuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 BY5PR12MB4276.namprd12.prod.outlook.com (2603:10b6:a03:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 18:11:40 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0025.012; Mon, 18 May 2026
 18:11:40 +0000
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
Subject: [PATCH v1 06/16] gpu: nova-core: mm: pagetable: Add DualPdeOps trait
Date: Mon, 18 May 2026 14:11:15 -0400
Message-Id: <20260518181126.2493572-7-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518181126.2493572-1-joelagnelf@nvidia.com>
References: <20260518181126.2493572-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR06CA0002.namprd06.prod.outlook.com
 (2603:10b6:208:23d::7) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|BY5PR12MB4276:EE_
X-MS-Office365-Filtering-Correlation-Id: 11247170-c539-4385-1d4e-08deb508e88b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: P0spCZ0skEf/Lf2epxvICUC0xfoXVUUukW3ppLNIQj/mqyQpVqglLlWYlrvgr3jGcdewr9VO8L+n0X5cWl+p+GgbSvrXSv3qelTbK3x2bEtDwW4nSomgTJhAEtia5g97Sx4bK0kqZi4nzBxDfXOvqj5XJOhOqn6D+We3RaNfIO4C6Xevg+YD06QPXSrNxf8iMvqODgR7TOzlgU4cuhxZL8uwEJ8xoavXtH1uJg0FPvV9Ubv9cskOW7Jm7sYrRFaJSXr3m8iSdxN+8sWDTcSfwzxBAZ9tkz0sl5q44bS9RD0MLH6KVoVJY5Z6BeQt4gfyxlYrYIGOi58CmcmstzWsLk3HMsoxw3A5H5p7s/nPh18w8wGvPO6ro9GEHk5C3HAFn7ehAWpHwJPuaLRhaa52muEl1p2obYc7rUsga4kt0I6h/knWo22eefFxvtIm2hEh7exFTxb+6fAgFON56gK/BMPfASwB1o6Gh5KYi+f7dIW9LEMj+fVLKSHoxBOOZ8kGwk55AMNs97BvHMDyAi10AMyveiZrNdCiDqkeaoTt8O6dZ/B1bFwUY7egDq6sST3FbFzF0uADhO/O9IAROuKf5zhdYykM9bgxJ6bQiOz5mMiMAvdlJpZ/0llamYKYBiTDjSJCTJrtLIKfV0Jie/u1o5RwI6jsib4FIPtxS4QrlU+boZkVLJiFHiHJLcQ5lhXd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y1zAWE935mGC/6cBygrlpo2+h6qCKsoh9sConplLNJUWCzptTZf4Xgpc+NsX?=
 =?us-ascii?Q?PE6wknEcSWe8OTD+/hW+rnYwq9xzuNDT/XQLP4sDoP+esPW7D9r8bL9X+BKl?=
 =?us-ascii?Q?T1PkVktIsHlIzmmtf4sCKSY1IK2i8NtdQSEyKjtAZ/lHmDuMEkZttPsFAHpl?=
 =?us-ascii?Q?Fm/n36ewzAhcwCBKN4uciFjs/zVUHyMkJEPGfkzMvp/Fz+85L2By1uQLtgQ6?=
 =?us-ascii?Q?Bm5ilmAn/SsFtv7UVkv9xOISE5C474K+I93i8Gkqfk0/teRqb+AwFfRfGVMp?=
 =?us-ascii?Q?iXDa+kfVkxfgHfbTYld25r9IgZwKr9SV9NyHoNzb2Si9D4orCpzFanH7ZGRI?=
 =?us-ascii?Q?tdaMqKouxjgUhvFp3Pfn934SRte45zE4xelPO+h6cbOENeyvShz56Ti6qiV1?=
 =?us-ascii?Q?M+KnhQ5X1MLvIIc7GPzFiC4mHg1QmGAeYaHJ5p2DrN1UQAL7y6DCN5SW/Ejg?=
 =?us-ascii?Q?oq9L704Wse13DQZtReXRXYuUZq1is4Nxw6njpCIIQTNj8X+fru3quXxdvT4B?=
 =?us-ascii?Q?aKKX4SxYH7YnpV1AveUkpfBbaG+P7qPCkDb5CwZLs51XdTpIYEb12jMsMrGF?=
 =?us-ascii?Q?vXLRmja8cqwtFPpyzHfi05SVoTTcX3Rs6S3Qd3oRHY+doNS6DmP6rVVNvZEJ?=
 =?us-ascii?Q?VEHmEO5Ola1uUTbJWxhYGdsL2oq2fhxf9P8dhp8kxLUZVZ8TwPMFZVniWO27?=
 =?us-ascii?Q?w2im0+ZZluNqTF1VhiQM1NN3Cwf25Jety2+o5hDggKdgEBgPBQZy8nLzZfz0?=
 =?us-ascii?Q?evsjpc86C5hq/Vpq+8GfPtnsOQgjkKguBRUYeoqA/rYx0MlOgJ2B8z9rFFwh?=
 =?us-ascii?Q?brlrHlqvOtBUV6wvNh4tdMFsRlGntmMuPV25f3MKWu9PLCQngbX0L823sabG?=
 =?us-ascii?Q?JLSFOTFi2jXbWNo2X681/KvUcsPloD1XQVH/YCa3QWeXkoIvsfjH9CpDGa60?=
 =?us-ascii?Q?zlogEceQNKi5qXQdB68CLRw6MmdJy+IpYf+AiX0DADBS8VDyn0L9G5K5oTg+?=
 =?us-ascii?Q?a8YuSK/U3vhubBIdKcUBIE5+QzZ3L8lDqbkPD8sx4voFm3hnKSFJb9DNBT5z?=
 =?us-ascii?Q?SaY/a5KxAkMkWD+XWF3pdWAel5iaVYz+FeJLi0QTFULe1qSCqUUr4eS6DZ6n?=
 =?us-ascii?Q?jNhyE3cgWvlAt0rW65GowmbvmWAxJKK2F+fBieOa7cj/q5cDKGm5cKth76CC?=
 =?us-ascii?Q?/3FVH3Mioc7pjIAH4rZ0NIqvlh8yWkVE94JLO04/MYQARKN5l6DYfrmOYdFg?=
 =?us-ascii?Q?Cu+yX1bv9kKeEQODnXWCGg6ho7ajcgu90xHlD0vj6OoHzYqKdn4kBPtM+lrE?=
 =?us-ascii?Q?qL2t+XjV87SrNbIIfOVtKmUWAYxh2u2gQmdSXVjqayyjQ+xnNzdBaQFl++IB?=
 =?us-ascii?Q?rBw5R1BEXYzG+79MFMxJbUD1xCfXYVEVsPPFDcd1b5ZZwsYakSvuYVjGc5Ko?=
 =?us-ascii?Q?zj0zb4J1doU0PRe9RC1jKVe+pV9GoTrkFGuv8O861zAkrAKAQu82UoauY/WQ?=
 =?us-ascii?Q?8zBTBxy5VgiVg7iWkiGPhX1A8BZ6MjGcRj+mshMth9gnnaLY5FPVNfibACSj?=
 =?us-ascii?Q?DqrwwitWvnBJduNxdFzN7vOCbsEqS8xejb2NANi3pdAeLdaIAx6WHk0js3or?=
 =?us-ascii?Q?gG33DZp4YvqvKFeQkrQOyijGG7+jm6C1uRAJmiGDhbMvvrDaCSfNi5c+i7Li?=
 =?us-ascii?Q?aDkIZW8DCLlnRBvaD42vb1O5o/W+rlXANHt5xva5Fg8hP01aXlp87d/Qlt/E?=
 =?us-ascii?Q?E9dO2FB3YA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11247170-c539-4385-1d4e-08deb508e88b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 18:11:40.0152 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YjCxttxTEJ8KIRzPbnF9WfGMZ02s/ETAUNB5rFRF5OcgVtgus1uVIDWpa+xPgQUMnguXpfLItktDD7XcA1GW3w==
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

Introduce a trait for 128-bit Dual Page Directory Entries. The
`read()`/`write()` helpers issue two 64-bit accesses through a
`PraminWindow` to load/store the 128-bit value.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/mm/pagetable.rs | 34 +++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/nova-core/mm/pagetable.rs b/drivers/gpu/nova-core/mm/pagetable.rs
index 1c94b3afa8b2..7ea090024d91 100644
--- a/drivers/gpu/nova-core/mm/pagetable.rs
+++ b/drivers/gpu/nova-core/mm/pagetable.rs
@@ -159,6 +159,40 @@ fn is_valid_vram(&self) -> bool {
     }
 }
 
+/// Operations on Dual Page Directory Entries (128-bit `DualPde`s).
+pub(super) trait DualPdeOps: Copy + core::fmt::Debug {
+    /// Create a `DualPde` from raw 128-bit value (two `u64`s).
+    fn from_raw(big: u64, small: u64) -> Self;
+
+    /// Create a `DualPde` with only the small page table pointer set.
+    fn new_small(table_pfn: Pfn) -> Self;
+
+    /// Check if the small page table pointer is valid.
+    fn has_small(&self) -> bool;
+
+    /// Get the small page table VRAM address.
+    fn small_vram_address(&self) -> VramAddress;
+
+    /// Get the raw `u64` value of the big PDE.
+    fn big_raw_u64(&self) -> u64;
+
+    /// Get the raw `u64` value of the small PDE.
+    fn small_raw_u64(&self) -> u64;
+
+    /// Read a dual PDE (128-bit) from VRAM.
+    fn read(window: &mut pramin::PraminWindow<'_>, addr: VramAddress) -> Result<Self> {
+        let lo = window.try_read64(addr)?;
+        let hi = window.try_read64(addr + 8)?;
+        Ok(Self::from_raw(lo, hi))
+    }
+
+    /// Write this dual PDE (128-bit) to VRAM.
+    fn write(&self, window: &mut pramin::PraminWindow<'_>, addr: VramAddress) -> Result {
+        window.try_write64(addr, self.big_raw_u64())?;
+        window.try_write64(addr + 8, self.small_raw_u64())
+    }
+}
+
 /// Memory aperture for Page Table Entries (`PTE`s).
 ///
 /// Determines which memory region the `PTE` points to.
-- 
2.34.1

