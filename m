Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B5ACD4F52
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 18:11:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98CC910E98E;
	Mon, 18 May 2026 18:11:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="UAoHAbxT";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010068.outbound.protection.outlook.com [52.101.61.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ABCB10E985
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 18:11:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TU6zJdpsu3uOWxZM/Cw0kEtxY7B33PnegwtdT+7mF07zMqm08qYulLtiCDQb90CcFBJXCsjmNTKEIPp3p2BZseCR1VIAnTp6l7muNJ7XPExycpa9slDyo08Q6d+Mp/kwySUtVSY4tFOsux+iw70Odlkwwy817l0XlexGvx0XTEQl+Npo9LfXm5bIvG/r6WsSp436l8W1rxNTWlQyMNk7XMpk/A7rcmcJS7FO2zifV2MyPZuUWeyrYva7p5ylsWBYgLIwWFYz2LwxYctZCxbMu0GspOwigbOenT4uyAfLEBZ5u0ePZvpdpESz3/qlp5/tp2gZYfqr2G+hZNcolZsWXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+WEBCEEnEDK5iQdhkl8VR3W3aQzlfrRqsFtphQfo9o=;
 b=MVDrwVMD4ecucFo407xw/WiC5/+m9fovyJ0LdRChJ+hooIgCC0zpptVF51WeS3arJqNd1fA07LX9NwjcKx3LCp9XmJDM7paYWE0U9zEjfPvMDHve2a2jKvSNUKZBIogGVswMj6nom4eaK9U6/JsubeertxDSYLdAu90sHFT1RTlRTdDEEDp52tOUYmvfvdiqyzKyS1blAFAQ/D+RERmJZUUEdnx7SvqoW+DrEeYAs6XYhpkiutDb0qp5Lwfoe2RcyAhl8Tyr9oWG7bVew+cP31fLbWZIcwTs0J03+8JQHJOQE3LvQEz6B4ooLdASz9cZbUWlY1U0m48/0ab+dL0C8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+WEBCEEnEDK5iQdhkl8VR3W3aQzlfrRqsFtphQfo9o=;
 b=UAoHAbxTJPymXR8SJi7oWwDjwfFiYnP8b5Gq1uedxp2eoo9RX9nfux0s3HfHVVdO2RuugiiAtVqUrYeVh3ws9bDg0Ot85Y34umnEvcl5YdcWER0YqeHpWHP7L/0Y1sDzUSd8DAX8YXu21Dtk6D+IRn4rQNIi5tQKdOeoF9ZP7z2M0XyhL6RnIRTS+MZUtoMbdEftM5IQV7Ky0ixFJj6NjqYWpXodF3px0pbCAnixyFlYyU0m6HqeuP+VoDUVB04k1b+eB5dfQl8aahBuD0AnXSuOn3MRQRNY/fqT/j6G3Ci9ieo6IY6wgcHBhpepxWi2C+SgMA11Pls925QKFzfu3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 BY5PR12MB4276.namprd12.prod.outlook.com (2603:10b6:a03:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 18:11:32 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0025.012; Mon, 18 May 2026
 18:11:32 +0000
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
Subject: [PATCH v1 01/16] gpu: nova-core: mm: Add common types for virtual
 memory management
Date: Mon, 18 May 2026 14:11:10 -0400
Message-Id: <20260518181126.2493572-2-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518181126.2493572-1-joelagnelf@nvidia.com>
References: <20260518181126.2493572-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0401.namprd03.prod.outlook.com
 (2603:10b6:408:111::16) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|BY5PR12MB4276:EE_
X-MS-Office365-Filtering-Correlation-Id: cae0e5e5-1b06-4c14-4b88-08deb508e412
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: nha5K+5jstwfj7rfy0heJZ57+lxK7A+iWg1qsZ4NA91QkbJOBtRC2gQH4VYM0C6a0s+CCaxk+x1Otko98epoDFm1kyZ0DZjvh1DzlcdMFbTV2nRC7k0BsvFSuOOSmdgiyubTdqH19uqbUbREuR/HV0wEA+0j0oAqWE2naV71J79HwC6OMkTFq7rPqZrKuBZqdw7eISLG7GmNXCi2eu/K2anDxnCX0s4fvAyiD/O8w0T6y1u/YnuSEH2vesz5eanHeecVIpNIGI7TT4sa1VaraiNUfTxfaKXoBIU7srtLQJCAtMH9H1RglVPuT14ccfzR5CkAT0/f/6JEaxM3qMvrmNGARxHyPSa1UoH5lL/0CR5H9YPi7dDkEMFf4cKsaYvNZ4WzXm7t2hxfDCOX+KnXGF2NlgvkKcnnGHZYFtfkggTKm7GKsTsyPaMERybdygPSxfIkJKRVeg4m9wT/lFEB1zh8Fz3r2t/JiEWFWRrIoaJ9rhods8LVYdAOrwruRR7Az5umXJ1Fnl5kWTTzgYbK9HFZG4fx9pxkDL3vAEVlpXjfur9gpmPqjnA50p/tG1x9m+hR9mtpo25y5F6NWsLHVvsiDkNKe4OVg10TayRA3VLr/b0MS7DhL1fsJDpm0GMvnqk38NeIejmBPJZjIOgyHgETbiDM1t5s8jI4aBiqXSxU+twkYaxeTCHQNtQtRNxk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?13m3u+8BKO3s41fAGCGd6RpnasbDXk3R+HNwSFcRpV1E2PBt7kNNO0l2HsKO?=
 =?us-ascii?Q?swh3vfunKrYPF9eiyevdRp+B4uyof+3ohOlrH4HFsRdR4h8qTsaXYlT65yl1?=
 =?us-ascii?Q?3w3UqTcIz1X6wgCC11TSg4APRtvYaAwkTsMfHdLaL368DI+itR2pHOCKXbGD?=
 =?us-ascii?Q?xsQHJ4pju/x4DB3jR1j5nq3mVY2OHxcifKvs7jwCJJU1mTw8XQMD+DSDiuYh?=
 =?us-ascii?Q?0ZF48epmEnwnn4IbOLTrqJgBUZfRYJdevQzwrr21ZLH7+yuVspOta63n6NDX?=
 =?us-ascii?Q?aWRx9zkNn8gKrxPmCgNFM4vI9EbNgDCvolaJOzkE2NY3dZG+LJLbXGIvNJps?=
 =?us-ascii?Q?2f/PpPcR87CsMjIxtlGrzSaP+LLsS4nyn8BB+SxV5vGXiMk53dfigFELgyOM?=
 =?us-ascii?Q?NLPFIdd41jSzqmsrLRbk8AZYkddNmbrbwNfpV7NDGRlN59MzJ991qppffF91?=
 =?us-ascii?Q?JVPpJsMJiTbq1iJpqiHR+LSUOEDjBbN7xiorSsDxa4Vonv+kxcJWsErhMMXQ?=
 =?us-ascii?Q?FfWt+PksXuGeYlKvpB9RTJVI6+4Vu/0Tq55Xmar3hjIDf99nEk/ZFcO6A7ic?=
 =?us-ascii?Q?5jdWt+IA3KCqNZYI/y/WO+ZJklkI14tGW72P+uH4stjsq/uX626GvXK52GSb?=
 =?us-ascii?Q?VDoxb/BqY+dS2/zkwZ16CZeI4jjsT4BBhwFL6PAkqknHBuc9u3JRn6GBZ2Go?=
 =?us-ascii?Q?LSY4DvCLY+EfcvM01P93uuJVI3Dp1CDc9DofTb9/temUvYz28MEiiFPIH2md?=
 =?us-ascii?Q?gGEB/LJLoKsf3YsJUWAP+eC31P+BdjKsVE6ruY+HISwpyTKpVv2m9m2OMTgj?=
 =?us-ascii?Q?p8KZT6OEnrUJ7vURE4wWaqYXtCYe97QaBWRPIS9W7+Qo+2dz6KiyvvEwTxWd?=
 =?us-ascii?Q?7Ur81IX9WbdpHebAch0rSwKmVH6zopPV3BgB+vGhsBN47GfRUTvHneKzRZxr?=
 =?us-ascii?Q?Ni2KzkIWbCpKD+l1wlEEkNAqNO5cJWFR0KZXt8rLz51TQxbqvCXX1WRYDDsQ?=
 =?us-ascii?Q?c2vFUFYthc88B5QrY+TUPOmsScwChJVU4elEum0hVpoosV9NCj7lrTXCUPWb?=
 =?us-ascii?Q?pUx1oHQtNj2sjUKv6EDNSYlZPYyFdZJ6Rki6TOZ9R5Qz7Jhrv+EUTLXbzudr?=
 =?us-ascii?Q?Aw9m8JDBVAMgXYOrGRs+LOJk1lBWqeiCxnBb2L9PPwGx8OkxCgwKiiWqEpH7?=
 =?us-ascii?Q?WC5sLn0Z6/HamALtxyfXzWvBT22EFo2QAZVkIjLXvM9G8nQeaIjlbGiU6d4U?=
 =?us-ascii?Q?1bIJ4ZZintE8W22JF1YGz0WMYwlg04xuoiF3uT2g62cASG7JcqBZdaJwIX7y?=
 =?us-ascii?Q?rMWz5ppmZ1kNiRXh+sqL85ZMz02438PMdQtw/CtgIuD0AFmsPtYETX6c+03I?=
 =?us-ascii?Q?ynrP9RyHMZ6Dx6duq6XPZSR3h/xxUZ1yClRp4qnJT+ZjRw+tRaPLwY8B6Eop?=
 =?us-ascii?Q?MAoeBUOH3OP70mHfqNPFbdQmKydQuAHK81SsgJx27dO6rFnakTVqijEPt0Jd?=
 =?us-ascii?Q?O+kuU6j6dx3ZLEzVJHgrpFMRo/Sh4JrSGK3jZkY0xU9zxl4BO8ARDIMn0Fb8?=
 =?us-ascii?Q?OkaKKzFPopIXEGgn9UZF/tJcKUYZlQyj4rbeIgDr85ji+Nf0JRdDAB5XS2KB?=
 =?us-ascii?Q?M/ToYXZdfvquhNaNw9n/rgfch7vWOTh1o1iYgAfLkUdmEticbixNN+/NEpp/?=
 =?us-ascii?Q?Q/OmAKrx52LyKPSDJbEG6kvS/1n4s1p3AacINOnJLGzX2dWJIcR7shcikIT9?=
 =?us-ascii?Q?o3rK9CKFFQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cae0e5e5-1b06-4c14-4b88-08deb508e412
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 18:11:32.5260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j6qfVHlHDM/nbxaJThkm4Dc5SMwvz6UHFChQlSbb470GSet5jKZEgROCcVVuCZ8zgS+URJYQSF7dLNo7oGO4qg==
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

Add common virtual memory memory management types: `PAGE_SIZE` constant,
`VirtualAddress` bitfield type, `Vfn` (Virtual Frame Number) type.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/mm.rs | 66 +++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index 08d74710f790..b23667a55ecd 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -42,6 +42,7 @@ macro_rules! impl_pfn_bounded {
     num::Bounded,
     pci,
     prelude::*,
+    sizes::SZ_4K,
     sync::Arc, //
 };
 
@@ -99,6 +100,9 @@ pub(crate) fn run_mm_selftests(
     Ok(())
 }
 
+/// Page size in bytes (4 KiB).
+pub(crate) const PAGE_SIZE: usize = SZ_4K;
+
 bitfield! {
     /// Physical VRAM address in GPU video memory.
     pub(crate) struct VramAddress(u64) {
@@ -207,6 +211,29 @@ fn into_vram_range(self) -> Range<VramAddress> {
     }
 }
 
+bitfield! {
+    /// Virtual address in GPU address space.
+    pub(crate) struct VirtualAddress(u64) {
+        /// Offset within 4KB page.
+        11:0    offset;
+        /// Virtual frame number.
+        63:12   frame_number => Vfn;
+    }
+}
+
+impl VirtualAddress {
+    /// Create a new virtual address from a raw value.
+    pub(crate) const fn new(addr: u64) -> Self {
+        Self::from_raw(addr)
+    }
+}
+
+impl From<Vfn> for VirtualAddress {
+    fn from(vfn: Vfn) -> Self {
+        Self::zeroed().with_frame_number(vfn)
+    }
+}
+
 /// Physical Frame Number.
 ///
 /// Represents a physical page in VRAM.
@@ -245,3 +272,42 @@ fn from(pfn: Pfn) -> Self {
 }
 
 impl_pfn_bounded!(52);
+
+/// Virtual Frame Number.
+///
+/// Represents a virtual page in GPU address space.
+#[repr(transparent)]
+#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
+pub(crate) struct Vfn(u64);
+
+impl Vfn {
+    /// Create a new VFN from a frame number.
+    pub(crate) const fn new(frame_number: u64) -> Self {
+        Self(frame_number)
+    }
+
+    /// Get the raw frame number.
+    pub(crate) const fn raw(self) -> u64 {
+        self.0
+    }
+}
+
+impl From<VirtualAddress> for Vfn {
+    fn from(addr: VirtualAddress) -> Self {
+        addr.frame_number()
+    }
+}
+
+impl From<u64> for Vfn {
+    fn from(val: u64) -> Self {
+        Self(val)
+    }
+}
+
+impl From<Vfn> for u64 {
+    fn from(vfn: Vfn) -> Self {
+        vfn.0
+    }
+}
+
+impl_frame_number_bounded!(Vfn, 52);
-- 
2.34.1

