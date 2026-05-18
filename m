Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C862CD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 18:11:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAFBD10E945;
	Mon, 18 May 2026 18:11:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="QJVIQuQm";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010007.outbound.protection.outlook.com [52.101.56.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F19DB10E945
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 18:11:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Id6V8xjJOC0foOsX2X7J9H6yI6YqU0OWPXsYYe6FVLUIGhkrbKXH4Q8A+FRTXBJGPSZDFV3Y8y6J8r0cBYAnEbQHqRJO7+Pk4lxyG5Kot0lrpZWuK9lPveNw+i3c55YciH3VAgf7RbpQLsPUeqWTy6iiRu2Qu1DPGQnEXMsU36HSxwuQkqAZ5ahynYTHy9W6OrvaNXzwm70eIz6IcRAGbHFILXG8XLDN94FHWp4SmkreLu/xGUJzQBc3fqz0d1Ab/zzSvGzUgrOV1vtJjbSCXUhiHRTJ3j7VPFv1M8du4LuXG2u2zTwcECTSwzedhnS8gpK92hy4WTLluqz+bxS4Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6dBX2Ku01wzzmyF1Gzcwfuod/hD7kT7GtEYq0kTnp0=;
 b=Uy9jrBbpUlQbs8PtgIv4TTdAH4PUgXgoCLf+kETfVa+VulN43/yLjxRAgcphpEbnQYo4GSUyh1CEb51Nlrm4HtZoQzv1uoGFeDjqZMMcgHobNbr9oy6nlpF7FhQwOuLXMf6Wo4bVx2y2Zl2JlnwTPj3fZW9U2QRtXSY1PLMO4kDKV7iapRfPHt5q9TdTgVtLMnqfxjqwy55dJZv4fOhkjtRTWqKVktCvbZHUNirjQq28BtQBvfJvfkbFAlWEdpjicclnf/0PeIlwPunEeN6uWHUAu3UI+D63/+GH4PBGfpvyseJwbxYy7A/n3zoiaeGlMUa+dYRQlksdxCnsNRD92g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6dBX2Ku01wzzmyF1Gzcwfuod/hD7kT7GtEYq0kTnp0=;
 b=QJVIQuQm3WqkRqoXjPjp8rgm9PZkbw5uZvZc50ij36eSaEeIyUNDhCk5x8/dk9CNjtyIUtTMNySQRAYthihMHi8AoIvzufdyc3WtSMBUdhgIDSToxDrjBE/46iVyUkQeCnJiejQJph6XuKDWV4QLMwYSs/M+L/irUnhvTYD+m+s0UzkUDV+KKgEvtOOE7qHF+DxNZNDI0u7VvMo7hH6JQEl+cDw6acNSrvIc+COzS0464I1ufDjxVuK5G0t5iI/O6Itz+EA4p11m1iSurjVo8ptoMqvMJbUc8kfixhf7I5LyWk30FCcvAkyKtVSQJnAtpWTfvgC+4UXIMtKLGXlmrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 PH7PR12MB5952.namprd12.prod.outlook.com (2603:10b6:510:1db::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.23; Mon, 18 May 2026 18:11:37 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0025.012; Mon, 18 May 2026
 18:11:37 +0000
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
Subject: [PATCH v1 04/16] gpu: nova-core: mm: pagetable: Add PteOps trait
Date: Mon, 18 May 2026 14:11:13 -0400
Message-Id: <20260518181126.2493572-5-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518181126.2493572-1-joelagnelf@nvidia.com>
References: <20260518181126.2493572-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0115.namprd04.prod.outlook.com
 (2603:10b6:408:ec::30) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|PH7PR12MB5952:EE_
X-MS-Office365-Filtering-Correlation-Id: aeb16326-6368-4afd-6011-08deb508e6b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|11063799003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: izjG80nGq1dK+qPHbJvC758XheE3j/pKqwfG654tX58TrWeUXbrZALdaHzS6aG23QXBPvnjPmMv+2Wj7Uy5HdFwzQBPbnR6gZkmIBHauf6tnf+XIAnOR+oUmgMZIglPvQTeZ0BYTbdCxOcy+NKHs1pzNMO8HDCh9JP0jYSfM7Nk3xWgMhIiy+nsTPIakLDhKsaEknJczWZr73Qh3idn4rKVoDFHnTGKsjMtvYM6c5EyEUHBl1K1C4vIvcbeOPoM+yEFj2fooBHx9mQwN5/42sNauWnBg6pc1bXlZxk08MKzEW5PEdWwa5CImWzk8nIqWfi3A7bCB3VwdDDafp9j4p2n+u/6N/6VvpBsZlaBGuOKnNQUkhQn7+vklETG43iN5NG4UKAfo22QkCK1QnP6h/2D96LzeXFsYZdkso/xN1ztxrUEq4Njhh1YQs5ppj/0zUUtCVY9omPFUEalxfiZUKPKQYlke0IeXVTfHtq9YBCRbFH0JKHrX0dGdV9DroKIzVvOIEhQ5sioNRA8asybPNStR0Z3+7T64cbD/UDoi+djIelnNVOct58snpqK2KWUpJk5Krp6wJZFqR/WgszcZ2kofRepn4iLADZLEp5SWepDYxVOCeF20EfBw94BufJJbar0LxBIRdoA0VVfc+7dwAP2XXV84qWvnODyJY39IpfzdxPDuy5N1Vo7jzsuARilY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(11063799003)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3Upw8KXlCJRqWALBl50F0JHbyTRSPR8aAA7854bru+76s5nnFq3Hy4dLKbCB?=
 =?us-ascii?Q?iXPmOkBfbXmI9yAsLm8jt0Q8etzJGmFnTTHPwaUCfwdcS4PGzjcP+WmdU+wx?=
 =?us-ascii?Q?IYJe++WV0ej6nTz1uYUepKcLGqyPnQ5EbAhE2tEUE5JmNUT81RoYoZx3LWEs?=
 =?us-ascii?Q?40luN6xZG2AB70uqboPHNjz8k9y2jtaXe612XrRk6/SuhoDNsMFt423NPJYP?=
 =?us-ascii?Q?2uaPVQGRQEyItEDk62P2cv+ejBp7kdouUf+elDFs+vnK+kfy0xjp+MsRQDm1?=
 =?us-ascii?Q?MlCtaoj4sV7k9GnROfnA0yQNNT4zdedF9BPgOPW26oyF6mOrW0FDOjLC3nvZ?=
 =?us-ascii?Q?ZBFDwguuVFQQ0LpfbT3hLsXWqW/761gCn67FniB49o+0nVe8ryaHtO3iC249?=
 =?us-ascii?Q?6R2mqz60FJt7MRvrMxqzs61gp9iic9uzwYDZ1h0bxjqxFNbP/JKsXOi7gh/N?=
 =?us-ascii?Q?XMv4LNNpH/PIi8px4XmycDdqMq+/xpeSB1OADRgWefU4Iq06FCi2r/QIpE3x?=
 =?us-ascii?Q?+LnBk6wz7bTqSQ725aRVKMbbhiTYQTSMS6WaC+WJ0QwE2c3eMqEwa949pGM9?=
 =?us-ascii?Q?coX3xfNyQQoeW0zRr0nqEIgkXg6RgRzpNxBFGrh7y7FxNYJOwyAA48ROy/WY?=
 =?us-ascii?Q?oqEelYgY6St6sKtyCHCbXvf2DYMJf/bJt+7wMXKA5isl3iQR98zNWi6RxO9M?=
 =?us-ascii?Q?m5H4rTpIaif8Kk/xwf0jnjvCe2oqp0DgJ7B6MYu6yRQL5QqWhPLuWtzRhTfy?=
 =?us-ascii?Q?0B2Ug+48TNZtdeaAlULqVNuaoKZbAqQSCQDA5RNIJI03RPZoEFttE1GMKO/x?=
 =?us-ascii?Q?NkuKyydneCn+3YX7+NjbwwHjV37yh/yqjkP3vp/Qz0zCQde9eXfxSm485abh?=
 =?us-ascii?Q?yPmGrjLIeUio+VrytjBjx3tuqnEPeMBpou3u5gxZPgyGmLSQT8ZPVX/cHHbP?=
 =?us-ascii?Q?JDRMy81mr1++knpCq9fcrMDPPz/Syn9kSzMOs9hbvcmfvjjwK0FU5QggNyJK?=
 =?us-ascii?Q?Xp4Hm1yGG8wyMeXzFk7rN9gxhZwgLs9MltxSGe89oQC5wsFYuwLUrGU39SGU?=
 =?us-ascii?Q?DZbrmOK5qjAUAKtlv3msCwudy2T2wDvgvuekYX4TBLGwS9cU/0jEet1Djmwp?=
 =?us-ascii?Q?HfyKtRVWh+qvMs1lsn7EtnzMf2HNqsRiNQFfTczhD8NKZLcBOoJV1/yrwDFe?=
 =?us-ascii?Q?1J+EwajlNakT4Aw1hXBlSJPCn0qrNw5VOjXra6Uvbhk1OCQ5M80DP9UN726y?=
 =?us-ascii?Q?SXZP7V1HfInO1c4xcYzVxNqviP0T69sq34HXAZsGDqq8/zx+f8qUd8reY17b?=
 =?us-ascii?Q?pHll37w1C+0hUf+ly21ATmUSEZp4Tmf3ECjvhrtKYzxZ8D6ih3MfqBqH0ruW?=
 =?us-ascii?Q?oRqnMmGM9z4T5I32syr07vsV7ap2CoFKrX0sbZ864duDSVrXRhIpuiwyxxBS?=
 =?us-ascii?Q?XQ4kPbwyHFChfnbTrI3ytBMSs4uTsV7eM99e92/QJYVGv+fShArzKGbeWeN5?=
 =?us-ascii?Q?0/3JlCYnE61IMkiZwOvbDlcdRWgRnOh5DhPOQwYQrBb50YJs7XxVF1PiBQoE?=
 =?us-ascii?Q?tHcialsdb7qZhDy7h706sPkY1V/mzEHYeNQklycRbxC5TYdlhPmvdF2lwxER?=
 =?us-ascii?Q?w9MT3fnpcITlx833pXoMHTlUOTlmOPoBx6LQhnb3uGguKThCTd3niQWtcQYF?=
 =?us-ascii?Q?1+IPYCrTCvqHEEf4sCRPHt7XByK6r5mgsNk5A5zCc4vlnMlEPInB+tJX1nhP?=
 =?us-ascii?Q?XyzeAcI/yw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb16326-6368-4afd-6011-08deb508e6b2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 18:11:37.0359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10gUdSoqdmhgci1Hr5nzZE6Wkjaj3GGUFxrESV3viv2e63cJbcBFRUVN9WXwivyjCkw7RHrLRJaCGW1x4Hy04Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5952
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

Introduce a trait for GPU Page Table Entries (PTEs).  New
`read()`/`write()` helpers are provided that go through a
`PraminWindow`).

The forthcoming MMU v2, v3 PTE structs will each implement `PteOps`,
allowing the later page-table walker and mapper to call PTE operations.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/mm/pagetable.rs | 38 +++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/gpu/nova-core/mm/pagetable.rs b/drivers/gpu/nova-core/mm/pagetable.rs
index ed0f3d731c63..a92add82eb10 100644
--- a/drivers/gpu/nova-core/mm/pagetable.rs
+++ b/drivers/gpu/nova-core/mm/pagetable.rs
@@ -8,9 +8,16 @@
 
 #![expect(dead_code)]
 
+use kernel::prelude::*;
+
 use kernel::num::Bounded;
 
 use crate::gpu::Architecture;
+use crate::mm::{
+    pramin,
+    Pfn,
+    VramAddress, //
+};
 
 /// Extracts the page table index at a given level from a virtual address.
 pub(super) trait VaLevelIndex {
@@ -84,6 +91,37 @@ pub(super) const fn as_index(&self) -> u64 {
     }
 }
 
+// Trait abstractions for page table operations.
+
+/// Operations on Page Table Entries (`PTE`s).
+pub(super) trait PteOps: Copy + core::fmt::Debug + Into<u64> {
+    /// Create a `PTE` from a raw `u64` value.
+    fn from_raw(val: u64) -> Self;
+
+    /// Create an invalid `PTE`.
+    fn invalid() -> Self;
+
+    /// Create a valid `PTE` for the given memory aperture.
+    fn new(aperture: AperturePte, pfn: Pfn, writable: bool) -> Self;
+
+    /// Check if this `PTE` is valid.
+    fn is_valid(&self) -> bool;
+
+    /// Get the physical frame number.
+    fn frame_number(&self) -> Pfn;
+
+    /// Read a `PTE` from VRAM.
+    fn read(window: &mut pramin::PraminWindow<'_>, addr: VramAddress) -> Result<Self> {
+        let val = window.try_read64(addr)?;
+        Ok(Self::from_raw(val))
+    }
+
+    /// Write this `PTE` to VRAM.
+    fn write(&self, window: &mut pramin::PraminWindow<'_>, addr: VramAddress) -> Result {
+        window.try_write64(addr, (*self).into())
+    }
+}
+
 /// Memory aperture for Page Table Entries (`PTE`s).
 ///
 /// Determines which memory region the `PTE` points to.
-- 
2.34.1

