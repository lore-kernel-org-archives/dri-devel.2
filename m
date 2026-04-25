Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C75FF885C
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 21:15:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C54C10E48A;
	Sat, 25 Apr 2026 21:15:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="AVjYKLZs";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012070.outbound.protection.outlook.com
 [40.107.200.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8D4510E489
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 21:15:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f4eJuqlL4yR961WAQRSDnNipmb/cplTI9q84oFw97q3EmG9xpDv0OQoImiaQeNuNx7FtuokKTWb4fnVNjFEW8Q4mqWoaAwGhmmwpRo8d9NYeS0wnT8WATST3xv5Dvd+0XZWDhxlHF+WwZP+XnJmBxar25zvcLU90HlpTbU1TLTbN++lSAMMncRkDXlUNsRIRyPTjiGwt13fB4xapKKTJvDSMX4joo+kVbmenHK5p1eidEEhOVMjIESjp0H8ipYIWsuYcXalJesnbo0/a3w1fJz/Hozd3e9iXiMH5EhqGYoZivhQjf238vNafbKXfIN3K94I1cL82Opftz0eqaTcH0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYQ20uu3lVGRMK1ef93FbMwOsjyP9gT56IvlFdaoOcA=;
 b=OaKgedvUeIl4K8KeZbVv9OH90mgRRKEtRTMLXoGw0O4lQLyQElYQEg8shz1/Pz1iFyZOIFHiYzcFKk6zemg95y7ZO8ppopJNsgxeDPAh641ihtlcLPSJCqNGqm8XXsEagL3xEInRWBtN1wa9TKyNaEywSq6euLCQS9L2LyvAKwyfSmWg2XFRQMO7RN9dvUcbYki3A3CBPWEiDKb5inPQFniCkfwp+zim/t1h8tIiZb4qbhZUBAYoF+ALtFM4UJabsDgbFfPHycW4QnhZTa/GCjpHz9lBAgP4d4sIELCVvpNr8yC62jYmnVWVbv19GaEsCIIY8TjJPu7mjS0bl7kJnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYQ20uu3lVGRMK1ef93FbMwOsjyP9gT56IvlFdaoOcA=;
 b=AVjYKLZsfCtN/pbj01Y5LsvtGTLTNssPqdvWCg05sIKEQBCqxcZ3uqFFYK97LEo8xRy3Wqv5je4n/6bSzUUQsu2oPMZ7VcCjWbXI+7nLTDhwkIvIcUYv46QSSnWbYDG/wvR3tY9QKEGk6Df0Qk41g4C2Fy4NGP2AduyM227sRP/Y8KDynupI3cGzsPfAhpWJWtFwL4IdLNE1YDa6TI59enkFhAcnZlKeWj1IROdJaVOQ/TbT0b2a7QvdtJBbod6iE3zcNatAfcUyyyGi96X8uKEQeBaRuwcvtQtSJJFb2MqWIslZMMgUgbwBvU17zx0OPP4qkNJLrHvrA/MXCW5i8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 IA1PR12MB8358.namprd12.prod.outlook.com (2603:10b6:208:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.13; Sat, 25 Apr
 2026 21:15:23 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.012; Sat, 25 Apr 2026
 21:15:22 +0000
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
Subject: [PATCH v12 07/22] gpu: nova-core: mm: Add TLB flush support
Date: Sat, 25 Apr 2026 17:14:39 -0400
Message-Id: <20260425211454.174696-8-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260425211454.174696-1-joelagnelf@nvidia.com>
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CYXPR02CA0047.namprd02.prod.outlook.com
 (2603:10b6:930:cc::14) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|IA1PR12MB8358:EE_
X-MS-Office365-Filtering-Correlation-Id: 6162bb68-67dc-4e69-72f2-08dea30fc324
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: aB7HzKQJWczcUTEcuXQFhiBDmrIdiRG9PzmiYYRxMA2dKLv4LgF8O5yJXw9Dok5t7Rq9WopZDF8tTvqMbULoqfMNB70VHUnuu36Lu4XMVjc7YigXxY+53+YzwV7Z+/wU+8dmogjKqacFVQetoyP1xHZGzWL+db4exSU8R2xzMAC1GDCiYxruNiyJ0v4ujprKhhE1U+8g17uox+jXN5lSJ8KFEPRKcNPjiyoXsMbVrWnKNOnWZrfFjTvCadOIvOAkEj8EWKKdrrwb2zlOdfPQAouZ9CdJftRpwVhqKZDytFRRSN0ns5d0Wva72KeeO8WJeqMmBQLXNa2c78dmUoqB9/9hNPmzX4Mgil+bo85dPozeP9qxc/kqh3FN32TbrriGKmQhS5kY4sKqY9piHwOakioUN0thWAoFr5R45hMREjlQyWdsh8A5XMYffY0n3hmHUtzGuCY01hVbk4Q3VJID0dh//AYMxsaa4LvVhqymPmOV4g8Z5SQ3ZjT6TMncGup4/0Z/oa+Xu1B9eK0f4f4JCw7unNUzcaZ2S5IkFpqM8qHwh8dl1pidOs7qIahqFCeTnFuV37tmTgBHmv19A45lWPK0YwO32Zlk7dRlVjIW601mWjtfUrPHTHONeGNjBQ49fkan0b7rMi6c3+atvilhcvBW/HCc4R7r5shKQwILSKXYDEo8sokjA1GWKRZR3AIDXRfvpE4v3iTrgsirbvQQLtrYdXuBIW91O2bcGNWgY0Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1NUaWdGdll0MVpIK1ErMmlIVTZna3g3QVIybXNjK3FvRUtscmtvTytCU1Uz?=
 =?utf-8?B?ckZVM0lsWlMzS0toZGdCa3RyM3FpeVJLby9oRC9DUDBHK1lmRmFVNC84dnFj?=
 =?utf-8?B?REkvUXhwbmJmc3R5bkZySTlEZWd6R2dIL2g4VjBKV0RhTWpPQlRvSzlDZ1l4?=
 =?utf-8?B?b3NGdHRtbkhibjd6ZXloS3Z3S0QrNWlCQldubDkyTWREUmRoQk5rTVBUMWZN?=
 =?utf-8?B?VytXSmlUZitycWhsaEE2M2F1SllIUEtDUXJJMU9lclRoeVZGemtyTVFMS3A2?=
 =?utf-8?B?Qi84clMycnljMXVFZTRDUUJ1aUhDMzNmMHRhZzBQbHcrOGlYUjZieDkvRjl3?=
 =?utf-8?B?eDQrY3RMd0o3QVVmOHR5cHIxOElHTGY5REFybmxZQXNnNmVtNkluaVNPZWNv?=
 =?utf-8?B?Ny9ZSGkwSTF6SExSTFJIYVE3VkZOc3gwMFZlM3l4ZjRTb1BLc3cydDJLSXdD?=
 =?utf-8?B?TWdGKzkycjZnelNyZjNVa09wd0lVSUVTL3BXOXYwWmM5VHIxV0xxTW9CSGUz?=
 =?utf-8?B?bEpUVmwyNkpjdEJhMTNBR0J6QytXZ2NLbXE5NEU3QVBSWXVMYVlUWFpDVXdZ?=
 =?utf-8?B?VFhvRkNWeXFIVG9pUEZmS0V2RUt4RHdaQ1JhekR4ZDcwVi93N251S1huQnNy?=
 =?utf-8?B?a0dwZFVvK1dEb09OMm1XVWN6bDMrR2dLbXdpellwU3JZUFpBMmZzWENUeGYw?=
 =?utf-8?B?MEduNUdKdFh0WjdFL1oxQ1cybVBVdjZiMHZMNEFmUksyVk9uNzExSFcrR0VZ?=
 =?utf-8?B?M21RKzNpcHAxYTJ0d1dOY0hXZEFBaXg5cVMvNUxBUWI3N1kzV25na01uVEpP?=
 =?utf-8?B?dks4K0NucDBnMVNoNlFrVTBlWHZVWmxxbTcrTXVBSjI0RjRTcW82dmpHRjhL?=
 =?utf-8?B?VVE4Ukd5VERZVEl2UkxDeVlKZkdheVZwb1NGZklWSTBWOTdUdWM0UFJicWFT?=
 =?utf-8?B?M2hyTFcwSnVNOTVhaE0waVpVVzN5VWcvY29FVFB6Yy9EblRadzJwVjB6NHNS?=
 =?utf-8?B?R0dYTnMrbVJTRnQwcG13WHRkdnNpRjM3TWdDYnhkcmlqQkYweVpKMHhIVUdU?=
 =?utf-8?B?QzUrNWtQemxVcUs3YzVhaTBUKzBIZ05kS2k1c1R6QWd0aGIyc0laRUlzWkRG?=
 =?utf-8?B?c2hIOVpKOHEzbmtSaGRtd2p3U00yc3JBaXpMeVh4OXQ1dEZQRVBoVUdWQVcw?=
 =?utf-8?B?dk5vZGxvTHo2OTlYdUMxUFYxazJMK2Q5djRyZ3dJSSs1VGpjZWpzLzVTS2JK?=
 =?utf-8?B?b1p1Y0x3RDlFUjI5blMyalh4bXc0aGdub0o2ZkRVZytUeWM0dDRVcnZCTXdk?=
 =?utf-8?B?T29jZjJnQnJuUENRU1VCWjlUVXNWL1c0VndVYVFBRm5hcHlvTGN1ODVmTzg5?=
 =?utf-8?B?UlNKdndKS3VvVFVscEdRMGVhcm5wL0EzSjJEOUVHZ2lVRzNkNWwvcG9CVlh2?=
 =?utf-8?B?ZmFkOUYweGhCUzkvb0ZKY0ZnUWJuOGpQa3ZUU1VWcUNuOEVMVHZCa0c4aG9L?=
 =?utf-8?B?cnpKN1JEY25Bd0FMSjVabHRPMVI4QlBVeU5lYkNaQXFlOTJuNDJmeUZkVEFq?=
 =?utf-8?B?bklmQTAzK0NKbkI4MFpPejZKaVptNnE0UUIybmFHT0dCbFRvUEk4WThBa25q?=
 =?utf-8?B?NGgyalF2Q2pUakgrcldWRGxNa053STJZMlRJZnBPNnpwUmQ3alQrK2pHRXZz?=
 =?utf-8?B?ZUtaVXFkNUNhTCsreTFtNSs3K1FLVDA1cDN6MDNsY3h3QXlhMXpRem52RVFj?=
 =?utf-8?B?WG9mMi9zS3R0c21pRStmTWhZTDB2VmZvMk9YUE1rbGxleGlRSEpkNGNnQ1JE?=
 =?utf-8?B?VjlvU0N4Y1cyajZXYzA4TVNJY0RTMkZuYXpzNi8xNkVQYTNydWg3SFl6UStj?=
 =?utf-8?B?QVcyWmNxcXdOUFFrNlBNMXFTYmhNT3lHeWRFaUZkVVlJVXBZUE55T0orTU44?=
 =?utf-8?B?QW84OGpSczFLZGVtMmdjUUtOclA1bTZURkhUSmptQVNJeTkvWk9iSy9kdW1U?=
 =?utf-8?B?K0NxYWhIOXVaQThFSHo0ZE1ZTnY3N2x0VTB5ZStiVmdza0pxcHBNc3JYWFl6?=
 =?utf-8?B?dmZVQk9ZSGNMOU9DTWloOWR2bnowNWJwVExiL1NIUWRCclh3cFB5TnlnUndu?=
 =?utf-8?B?RkQyZytLNjcrTEVVRFE1ZDVFRExKTTcwUmZFbHhhTEVqUURCeEs4eXRtamJE?=
 =?utf-8?B?T0tXV1lnOGFZRnc2T3h0NTZBMmg3d0M3ZzNIejV1S05VcGgrMCtsTDRtd2JE?=
 =?utf-8?B?cUdidUVzdllDQkhFaTVBOFphZ1ordVJzOUJTMkYxSEtZYTFjcGllaFN0K2hy?=
 =?utf-8?B?WU5Ta1o2YkdHSzZJNTFrcXJ5Q05QblNxWFh4Ynh6SWpSdE84M01Gdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6162bb68-67dc-4e69-72f2-08dea30fc324
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 21:15:22.8199 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HoykwAGzQAyrfJKC2NVNEv+BoSqqvL2+RtBKNnq9Fk09HNSnvKwJ4AuF2t+pS5QJBTrvdSMcHqYpSaMHZeFcUQ==
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

Add TLB (Translation Lookaside Buffer) flush support for GPU MMU.

After modifying page table entries, the GPU's TLB must be invalidated
to ensure the new mappings take effect. The Tlb struct provides flush
functionality through BAR0 registers.

The flush operation writes the page directory base address and triggers
an invalidation, polling for completion with a 2 second timeout.

Cc: Nikola Djukic <ndjukic@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/mm.rs     |   1 +
 drivers/gpu/nova-core/mm/tlb.rs | 130 ++++++++++++++++++++++++++++++++
 drivers/gpu/nova-core/regs.rs   |  69 ++++++++++++++++-
 3 files changed, 199 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/nova-core/mm/tlb.rs

diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index 23e731bd7d22..2a8b228b1916 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -33,6 +33,7 @@ macro_rules! impl_pfn_bounded {
 }
 
 pub(crate) mod pramin;
+pub(super) mod tlb;
 
 use kernel::{
     bitfield,
diff --git a/drivers/gpu/nova-core/mm/tlb.rs b/drivers/gpu/nova-core/mm/tlb.rs
new file mode 100644
index 000000000000..53c6fe6084b8
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/tlb.rs
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! TLB (Translation Lookaside Buffer) flush support for GPU MMU.
+//!
+//! After modifying page table entries, the GPU's TLB must be flushed to
+//! ensure the new mappings take effect. This module provides TLB flush
+//! functionality for virtual memory managers.
+//!
+//! # Examples
+//!
+//! ```ignore
+//! use crate::mm::tlb::Tlb;
+//!
+//! fn page_table_update(
+//!     dev: &device::Device<device::Bound>,
+//!     tlb: &Tlb,
+//!     pdb_addr: VramAddress,
+//! ) -> Result<()> {
+//!     // ... modify page tables ...
+//!
+//!     // Flush TLB to make changes visible (polls for completion).
+//!     tlb.flush(dev, pdb_addr)?;
+//!
+//!     Ok(())
+//! }
+//! ```
+
+use kernel::{
+    device,
+    devres::Devres,
+    io::poll::read_poll_timeout,
+    io::Io,
+    new_mutex,
+    prelude::*,
+    sync::{
+        Arc,
+        Mutex, //
+    },
+    time::Delta, //
+};
+
+use crate::{
+    bounded_enum,
+    driver::Bar0,
+    mm::VramAddress,
+    regs, //
+};
+
+bounded_enum! {
+    /// TLB invalidation acknowledgment scope.
+    ///
+    /// Controls how far the hardware waits for the invalidation to propagate
+    /// before clearing the `trigger` bit of `NV_TLB_FLUSH_CTRL`.
+    #[derive(Debug, Copy, Clone, PartialEq, Eq)]
+    pub(crate) enum TlbAckMode with TryFrom<Bounded<u32, 2>> {
+        /// Fire-and-forget: no acknowledgment required.
+        None = 0,
+        /// Wait for acknowledgment from all consumers, including remote GPUs
+        /// reachable over NVLink.
+        ///
+        /// Globally is strictly required only during unmap or permission
+        /// tightening, because the backing memory may be reassigned after the
+        /// flush returns and a stale TLB entry could let the GPU access freed
+        /// memory. For new mapping or relaxing permissions, a stale entry would
+        /// merely cause a redundant fault and retry, so [`TlbAckMode::None`]
+        /// would suffice.
+        Globally = 1,
+        /// Wait for acknowledgment from consumers within the local NVLink
+        /// fabric node only; skip cross-node ack.
+        Intranode = 2,
+    }
+}
+
+/// TLB manager for GPU translation buffer operations.
+#[pin_data]
+pub(crate) struct Tlb {
+    bar: Arc<Devres<Bar0>>,
+    /// TLB flush serialization lock: This lock is designed to be acquired during
+    /// the DMA fence signalling critical path. It should NEVER be held across any
+    /// reclaimable CPU memory allocations because the memory reclaim path can
+    /// call `dma_fence_wait()` (when implemented), which would deadlock if lock held.
+    #[pin]
+    lock: Mutex<()>,
+}
+
+impl Tlb {
+    /// Create a new TLB manager.
+    pub(super) fn new(bar: Arc<Devres<Bar0>>) -> impl PinInit<Self> {
+        pin_init!(Self {
+            bar,
+            lock <- new_mutex!((), "tlb_flush"),
+        })
+    }
+
+    /// Flush the GPU TLB for a specific page directory base.
+    ///
+    /// This invalidates all TLB entries associated with the given PDB address.
+    /// Must be called after modifying page table entries to ensure the GPU sees
+    /// the updated mappings.
+    pub(super) fn flush(
+        &self,
+        dev: &device::Device<device::Bound>,
+        pdb_addr: VramAddress,
+    ) -> Result {
+        let _guard = self.lock.lock();
+        let bar = self.bar.access(dev)?;
+
+        // Write PDB address.
+        bar.write_reg(regs::NV_TLB_FLUSH_PDB_LO::from_pdb_addr(pdb_addr.raw_u64()));
+        bar.write_reg(regs::NV_TLB_FLUSH_PDB_HI::from_pdb_addr(pdb_addr.raw_u64()));
+
+        // Trigger flush.
+        bar.write_reg(
+            regs::NV_TLB_FLUSH_CTRL::zeroed()
+                .with_all_va(true)
+                .with_ack(TlbAckMode::None)
+                .with_trigger(true),
+        );
+
+        // Poll for completion.
+        read_poll_timeout(
+            || Ok(bar.read(regs::NV_TLB_FLUSH_CTRL)),
+            |ctrl: &regs::NV_TLB_FLUSH_CTRL| !ctrl.trigger(),
+            Delta::ZERO,
+            Delta::from_secs(2),
+        )?;
+
+        Ok(())
+    }
+}
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index a3ca02345e20..fcbd407fc494 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -30,7 +30,10 @@
         Architecture,
         Chipset, //
     },
-    mm::pramin::Bar0WindowTarget,
+    mm::{
+        pramin::Bar0WindowTarget,
+        tlb::TlbAckMode, //
+    },
     num::FromSafeCast,
 };
 
@@ -548,3 +551,67 @@ pub(crate) mod ga100 {
         }
     }
 }
+
+// MMU TLB
+
+register! {
+    /// TLB flush register: PDB address bits lower bits.
+    pub(crate) NV_TLB_FLUSH_PDB_LO(u32) @ 0x00b830a0 {
+        /// PDB address bits [39:8].
+        31:0    pdb_lo => u32;
+    }
+
+    /// TLB flush register: PDB address higher bits.
+    pub(crate) NV_TLB_FLUSH_PDB_HI(u32) @ 0x00b830a4 {
+        /// PDB address bits [47:40].
+        7:0     pdb_hi => u8;
+    }
+
+    /// TLB flush control register.
+    pub(crate) NV_TLB_FLUSH_CTRL(u32) @ 0x00b830b0 {
+        /// Invalidate every VA in the PDB selected by `NV_TLB_FLUSH_PDB_LO/HI`.
+        0:0     all_va => bool;
+        /// Invalidate TLBs for all PDBs (ignores `NV_TLB_FLUSH_PDB_LO/HI`).
+        1:1     all_pdb => bool;
+        /// Restrict the flush to the HUB MMU's TLBs; skip broadcasting to the
+        /// per-GPC L2 TLBs.
+        ///
+        /// The GPU MMU has a two-level TLB hierarchy:
+        /// 1. The *HUB MMU* sits at the top and serves memory requests from
+        ///    "host-side" engines: the host/channel interface, copy engines,
+        ///    display, and BAR1/BAR2 accesses.
+        /// 2. Each GPC (Graphics Processing Cluster — the block that houses
+        ///    shader cores / SMs) has its own L2 TLB that serves requests from
+        ///    the compute and graphics engines inside the cluster.
+        ///
+        /// When set, only the HUB TLBs are invalidated. This is a performance
+        /// optimization for flushes that only affect HUB-side mappings (e.g.
+        /// BAR1/BAR2 windows), where fanning the invalidation out to every
+        /// GPC's L2 TLB would be wasted work. Must be false when flushing
+        /// mappings that may be cached by compute/graphics engines.
+        2:2     hubtlb_only => bool;
+        /// Invalidation acknowledgment scope. See [`TlbAckMode`] for details.
+        8:7     ack ?=> TlbAckMode;
+        /// Write 1 to kick off the flush. Hardware clears this bit when the
+        /// flush completes; reads as 1 while the flush is in progress.
+        31:31   trigger => bool;
+    }
+}
+
+impl NV_TLB_FLUSH_PDB_LO {
+    /// Create a register value from a PDB address.
+    ///
+    /// Extracts bits [39:8] of the address and shifts it right by 8 bits.
+    pub(crate) fn from_pdb_addr(addr: u64) -> Self {
+        Self::zeroed().with_pdb_lo(((addr >> 8) & 0xFFFF_FFFF) as u32)
+    }
+}
+
+impl NV_TLB_FLUSH_PDB_HI {
+    /// Create a register value from a PDB address.
+    ///
+    /// Extracts bits [47:40] of the address and shifts it right by 40 bits.
+    pub(crate) fn from_pdb_addr(addr: u64) -> Self {
+        Self::zeroed().with_pdb_hi(((addr >> 40) & 0xFF) as u8)
+    }
+}
-- 
2.34.1

