Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF1BCD4F58
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 18:04:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB78C10E986;
	Mon, 18 May 2026 18:04:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="qQeFePId";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012009.outbound.protection.outlook.com [52.101.53.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 205D410E980
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 18:03:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKnhfYMriRIqOmldwpmjKh7/6tOrdqJk9R4bJwVT+5z+eUTILz3NkhUw/Ze+miEghZq0Aml2xGSjE0WIlkRLd7ouYts+a16rEFrRDD+IFdiM2GFBPL9Bq/cq6QOrpncRHQ8MBPkvajr5JWnUfTgT/AYLt4SdbLLxY7fJ5gB+G5jwmHW2CeGCUZ2kg0mUuQk6JZhPayV7jX1lEr6dD+hN8HgAz69PVDudC22mGnHOnOiljLtUcFH3XZ8j4+Ya2edL/kswHLWstzthxUbx9tjJ1ZOrRQB1AqXoFthGbYQlsTkG/kb1BJwCU41RL5dfDVKUCKcwF9PPOx3HRtGPBtPLXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/JSt0TdXE53eIkDYamAD/K5+BRXa+9lRRChTbKF1to=;
 b=P6Ilwo6RInh7Si21/gwhMe7AFAFnXIituvexKnX5da/IWoLcMLGvwX/FVAc/+TDcwiM50eqPeQ10eVNQazAYccn4gGrhAdsJdQebXoGAgPuJEazl279Kp1aX5sMe1orx8pEDtwrdQt2HdmXU1l51Tn9whnRTfmrREoiqSHP5G+Os3CgYhckNvC93xymojdiiTojhGg3iib68WT99dG/3t/4/kziaQogM1j/sxL5nKR9F1RUZc5BbZty3Yiwn5Y2pU5WxkZW0uZf86ZLjreUr6UE33meUzKJaHVHEOw3/aQ78TnQiEz+AuCBruMVMCCTnmwuqXfJwKdwckB9vr7L+oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/JSt0TdXE53eIkDYamAD/K5+BRXa+9lRRChTbKF1to=;
 b=qQeFePIdqhSfdcp7RbFBIxmyxcLnnEUoBglLndT1M+RqBs4TS1NWoT6pse0yYOylifsR95aT97FFhAvtwZfRqf0dAtFEkhGNick2PD1jiXWShoENfniA78gH44n7iX89wOWLZ7f2iLc8kn9Iew4WrI5B5aJ2uV0kydetjj0ETWhd1zlaxu8gUW4hHH43gTeOl1KwiQ1WbJ9+PH3k3rnueIbqMp1aiEdPF/TSwB0HZZjNn9PqyO5+CE5cxB/+8WZqcXIkPMmTPlfhFvPGT2rKtRY8PGco9ReG2+6+uYXxEqvhM8gpLi6CFg/2gsGI7KUZjkTzNUES8l9OB3qS+FGMag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DSSPR12MB999212.namprd12.prod.outlook.com (2603:10b6:8:376::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Mon, 18 May
 2026 18:03:54 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0025.012; Mon, 18 May 2026
 18:03:54 +0000
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
Subject: [PATCH v1 06/12] gpu: nova-core: mm: Add Pfn (Physical Frame Number)
 type
Date: Mon, 18 May 2026 14:03:36 -0400
Message-Id: <20260518180342.2387845-7-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518180342.2387845-1-joelagnelf@nvidia.com>
References: <20260518180342.2387845-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0012.prod.exchangelabs.com
 (2603:10b6:207:18::25) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DSSPR12MB999212:EE_
X-MS-Office365-Filtering-Correlation-Id: 4512bb4b-a2e0-473e-a834-08deb507d2ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: dV0pqhBrbl912h6TqB/eIfU76/n2l6RwZAsy05aEUXacP6KaowFsC62hF26DxYmKdgAc2h2ItvmO9kgApRucuwntmQrk45nKQ+ULCKqE6jhBh4ilq7BMSKAHvski4JwpWSr0fswBwmvzSq9vdDJyTQdwLnB1Oc2MMvUMh7+xA7amKhdXtikThQ/IzywyoqNqHDT3S2UeIBmHlA2yFPHMBEsQRqt35MKL6qDzm0if14kYYWP4JuTnrtr7A/DWb2Fgv+VOyCpzWsWBlOHartuaWcPhPFZKaBg45BOB3jug8TI88F3Z2SyKSXa8a5JoT/A/9atMRvrDrqgCMOtsJUtIHWqTqpLXfXIvL1Vuxc3jYCSpsotktzaKC3Rsd31v8IMIR8a8rZ6+ege07rJHGAb3284tP7YIFPsXtoXEPdVPBdl/9qyWBGbKkSQQHIEaq8Ci0Llhz1tTapP9HZc+hYzU+njsIXgS66cR4ZPt6wZwzHYB4D7bkhGRoUBlQxNKJe+cNuA2RsVP3Ja4lJXjuKmVvKxwAESdYreBcuBuDV5iwTUijeQWUeEWCXZalTAJLe18O0DKAeYbw2uFec6G5gv5JKqTIGxudxXTs/fQ/zkx3rdVvVo/+6ayMERrpYK2wsv2Yc9FUSUh4aX4gIgxORHGFGLhjsKM3FvqDYO123/rc0ImwLLiFzMkthuwNk9GAoS5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(22082099003)(18002099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ltOZLevtgTDevULBDdi4mGmrwUFUH1uuRVDyfCEkSklBwdyTjJrufEjGVDqY?=
 =?us-ascii?Q?yvCQXlhK2Yg9XtPKS7JKtYuV5sxCRGWCN3mvt6HQ4w0Kj9OpTSp9a+mQRhO/?=
 =?us-ascii?Q?V0BkVfbaUf0J83iaDJ/xo+mjJN7NicJPH1OYZHqSa8mmsgYav0n0V1aWUusE?=
 =?us-ascii?Q?SrtrXaoy83vVAou2G4ylKRMvDDtxPyHhfjTUcis8p/MEvu26Z+JszLq00hLD?=
 =?us-ascii?Q?zbd2voI1yMx3j2UGc/DFieYEZjIWXh6YGK5xBrvO6L28sQ79qIoozFAR+U7x?=
 =?us-ascii?Q?+RJG6Rh77n4icPeU/8jkSoj04qOE5D3bPydqjO2MmLC/lrUBf1sxQMPQOrJv?=
 =?us-ascii?Q?WNP8wy6YZDAlAH5JWso1WyTWbpDxzhUwTpUJko26T/qXlYY8fWgnZxouiLW6?=
 =?us-ascii?Q?QBlZGeX5yA4zN84Tq0f7CCRfBfYi/3LYWRivK5ToECeFB4aFKqf6czOl2l9+?=
 =?us-ascii?Q?NdMfC3U5kNM6W7eyXNf/aiN9npHXF8gY8a6uhpu8arL0sblUmZUAsjSbxTbZ?=
 =?us-ascii?Q?hg0rkcZApOVzPrBeD/N+4cIlK6dW5zn00gdh4EyTxSmfUO20eTPEi2v5aqUJ?=
 =?us-ascii?Q?wiL/HPEuGC7q2Z6KU2iVyY/m+8ze4/9HJObToLsQ08etJRW2HHzJzu1QpbSl?=
 =?us-ascii?Q?oxg5dx8IuJ6vv8avvN3xNkJu8KjYN7BS81Lydk2KRrjvT/6X7wHDBDs7SILU?=
 =?us-ascii?Q?YYQdJv6hWnR4f8m9o9Z0p6S7Kn2ZowpDWyYXDGi+Yx45GertI9tEEP1ot2iM?=
 =?us-ascii?Q?fXabzddXQWG2bwANXMEL1XzooADcfAPRVGrs4qgMN/TDom9+g5sHh2T8ivQL?=
 =?us-ascii?Q?oatQIJvU4E6PjswkBcDR730PI62D4OzA+vYfsId9s7YLCigQw4Eo2iN02UJa?=
 =?us-ascii?Q?BKtS4CWARGwA8DCEtIIDKA+luJ9pJDb1vBUUH7NnFUB+RDJg7OjXWeaON4+j?=
 =?us-ascii?Q?kJikqLj6kVr8igK/6Xrm4+51VpGVVVEDRztxty7udY1f7wYK/3nyyt1HkjoC?=
 =?us-ascii?Q?MWLBYfax9/lhKbM/wFah+OoZvgjJYsnzxvLaEeYLu0ujF1K3Ikjh10AO5MBO?=
 =?us-ascii?Q?WujL7OUT/0Vuu1qzUVBolZ2Q+HVm+N2LfLW1MH0wGEYmnZsy1VRxojC3NNaH?=
 =?us-ascii?Q?bYzcTLqJBzvVjLsKV7JEvEnDCySk2rrSOjOUgohdWBjbm99MminCDu3y7Y0Q?=
 =?us-ascii?Q?S0jr+2G1tZoOpUUDxAf/97O5mYrRkItqLR9ZBQvvpDpoyCF3LGSQO2NVr5tn?=
 =?us-ascii?Q?uOn2okNvFogowKyTLw59cZBA5KanfB6cDQpPgCK79RgalkioEP0gFNKm46kc?=
 =?us-ascii?Q?9X/grSeZ/YKJGUiZPABFsV5D4GVTiPtzCbZ8vP5F9we/xNPe/J/fanuNAqZF?=
 =?us-ascii?Q?MxnFA8fwy41OTALOJSRxcQn54183gQVgCIWKwv36jn2b+M4jYLizYfhpiMeY?=
 =?us-ascii?Q?R4/ScoWUUWjQTMWS0BZzWnMt9vG3Dvre55MGyxakUFkDAB50m9GYUq2qa47R?=
 =?us-ascii?Q?NqnKaSf+QoUQzgxZXM9YIQLnW5WND2yVDo6A8yWB2GESFOES9FU97yYIBiZf?=
 =?us-ascii?Q?VMs3DTx2JvlyjM0EwnzYEXp9Dyiyrze21tpWI0NjqqOzjxPwoeLsNzaSxuTj?=
 =?us-ascii?Q?zwl5Ffl4iChyrvxL4ow7aATA7v/llNgORZq9e9nm5b6wBTZlzrdXI6EctlF+?=
 =?us-ascii?Q?OQy2I4ZMKhOJ5VnrN8YvYmuBRembUW5sbvxEGN/XZ9dik+jbWRCKKAG/lPLK?=
 =?us-ascii?Q?hdmiNAyVrg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4512bb4b-a2e0-473e-a834-08deb507d2ed
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 18:03:54.4637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v8XpZFnMWujFeeGvOIZE4Lpy4aw47HGX/Mk7FSLH/3mLPVamBUnZmGJpClzoosp35MhWw6jIChXieFBqM1zBMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR12MB999212
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

Add the `Pfn` (Physical Frame Number) type representing a physical page
in VRAM, along with the macros used by frame-number types to interop with
the `Bounded<u64, N>` representation used by bitfield-derived PTE/PDE
fields.

In later patches in the series, we will use `Pfn` in the page table
structures.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/mm.rs | 70 +++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 drivers/gpu/nova-core/mm.rs

diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
new file mode 100644
index 000000000000..3b131aedf2f9
--- /dev/null
+++ b/drivers/gpu/nova-core/mm.rs
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Memory management subsystems for nova-core.
+
+#![expect(dead_code)]
+
+/// Implements `From` conversions between a frame-number type and `Bounded<u64, N>`.
+///
+/// Each MMU version module should invoke this for the specific bit widths used by that version's
+/// PTE/PDE bitfield definitions.
+macro_rules! impl_frame_number_bounded {
+    ($type:ty, $bits:literal) => {
+        impl From<Bounded<u64, $bits>> for $type {
+            fn from(val: Bounded<u64, $bits>) -> Self {
+                Self::new(val.get())
+            }
+        }
+
+        impl From<$type> for Bounded<u64, $bits> {
+            fn from(v: $type) -> Self {
+                Bounded::from_expr(v.raw() & ::kernel::bits::genmask_u64(0..=($bits - 1)))
+            }
+        }
+    };
+}
+
+/// Implements `From` conversions between [`Pfn`] and `Bounded<u64, N>` for bitfield interop.
+macro_rules! impl_pfn_bounded {
+    ($bits:literal) => {
+        impl_frame_number_bounded!(Pfn, $bits);
+    };
+}
+
+use kernel::{
+    num::Bounded,
+    prelude::*, //
+};
+
+/// Physical Frame Number.
+///
+/// Represents a physical page in VRAM.
+#[repr(transparent)]
+#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
+pub(crate) struct Pfn(u64);
+
+impl Pfn {
+    /// Create a new PFN from a frame number.
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
+impl From<u64> for Pfn {
+    fn from(val: u64) -> Self {
+        Self(val)
+    }
+}
+
+impl From<Pfn> for u64 {
+    fn from(pfn: Pfn) -> Self {
+        pfn.0
+    }
+}
+
+impl_pfn_bounded!(52);
-- 
2.34.1

