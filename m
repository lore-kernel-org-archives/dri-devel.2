Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FBCCD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 18:03:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7348C10E97F;
	Mon, 18 May 2026 18:03:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="dERgIHb7";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011027.outbound.protection.outlook.com [52.101.57.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA88810E978
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 18:03:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4JQnMcJ8ShQxmTuh8Pd6c+SbTqtaPAjMbSNy4MuRMLieglsgCPOyG511a1zTIuGr6U83eY45cKrsEJTeju6PNWO6tqR1cVNAxoHSXu503shq9v5o+S3tRQKIsCj08pyV1bgarR+6VMJ7iHylhWP35CRLmtKUg9Zt9rQ7hBfBzmXHZWooQIm8OVCMAs5NW8F8CccJNCT5orr4VAL4JbH/3HYKMVNUd/YsGRYVJlfhyFYSdWqkENLtp+/YpRvcZowMg2FjwU5WFs0tfnImHZ9FQdb5P+3fsBT01j/EM79bab0Ja8yH+2qyX8Wo7ZMTVzI/3IOnghTM4YDjLJXL3mlyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYpNt8B/QpjJy0kxD96rJBPekJhaixqpFKeUv9opSII=;
 b=Ss0N+0nOmjtIW+CB6oL40lc1vUh1paMPT/KZW+c4sWVNlom297m9V2dSMiEwKJK073L7j/1NwJbKzKHYB+IHxMHMrH+rjdjKlYTIqD3vwKkwbxgMl6oNzI77jMh/OnnQ5NBqM8mZtNrTmXzZ+aeyAEinFhuO7m+gS2+9vAM5UvvnSVBf12DUglvg/R74x75a4muHlSHTwgbgQ+5IzJkvpyaTy/uHR4GwkuRcAbgG1e6Xf7XuO+M5NI5H7KwS20n4h5Bvee2wqfLOkGGceBFunNAKT7B0MkvKsEjr09TnJ7CUnT7XYG3lR2PwOhlH+vsrzTluT2Sw89gwfqGywKmjnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYpNt8B/QpjJy0kxD96rJBPekJhaixqpFKeUv9opSII=;
 b=dERgIHb7vyMrkyp2G/Go+qzj0AAlXqXCvsKj+M0QJPdDzCyQ9JxEn8Akbsvh/pWJf9HzsIKPc0mR9e80QnqNhevqV5K0MIp6EAeqsV3eV10RQNTrp4GKaOskjXO+KB+bsWDHfd+QPGqfsk0QOZoJ5vrqvo/xgBsRQn7FXq4k7WBXBpG9sV2c9o3m+eNYaj78bEBqhnFMn/uqBQjkx/8aO4tLiEsD6LepPQMA03yaEGjWxjDNHadCN/1mYHNfv8cnyagHzWErhv989Qy+4Yo+u2/GQ6tVEB7UaSVvT859N+m+geYcsHRcLfpAXMRYF7OZvG6ylmmoCbN4UfhMgOJ6/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SJ0PR12MB8114.namprd12.prod.outlook.com (2603:10b6:a03:4e8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 18:03:47 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0025.012; Mon, 18 May 2026
 18:03:47 +0000
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
Subject: [PATCH v1 01/12] rust: pci: add resource_flags accessor
Date: Mon, 18 May 2026 14:03:31 -0400
Message-Id: <20260518180342.2387845-2-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518180342.2387845-1-joelagnelf@nvidia.com>
References: <20260518180342.2387845-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0051.namprd20.prod.outlook.com
 (2603:10b6:208:235::20) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SJ0PR12MB8114:EE_
X-MS-Office365-Filtering-Correlation-Id: 2601a36f-deb6-46b8-13a1-08deb507cede
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7416014|22082099003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: umy1JQZp6gf2UH+Dye22Pvd/vTyc/OJxKYDen4HRiemZnPRK0qNvZloBn+5BDrZXD6rgSxeJLq3+tgRnjs6s+TWt2dSzMvyZHc8nafRkt5cYjXB0L14aS4u67vQR7VvWuc4LdYswz+u84YptW/W0Jz5dD2HuCURpR61EiC+sftgNwnBGRrQddDGIo+KQ/M9RHmbl12OkLJtVid3+/pOtVUeD98IBbdN1/dA1WWcJFrOpI1ruBJ9n/gVh8EQHY6UXxVcL0UzEKM6VRnuRzzuv3ZdSH5Eyx+1bF0DF/pXx/yYx3avLwceM38LdgI9Bi7+okV81DLEWOkzNJTUvYfxifG8S//vdRhL7XXz5GER1VuQM9EAuBRQb4FqIHf1UM1GxNUFv3YNFIjmV1inuJR6c3jgQnTc340CopRQSZQaPIzM8UgxH/ade7wRVHayfBa+5tFgZSmimhsiz8boxiBdDneXsasxKQA7QkhP3EPDuVtRA4toemoOAptAB8paXLNloB5nIJTPj9pfYdhOuVYzbUVpwiioR2uqpIgu2XCv6QiEOAzWMbu50dlf80Sbxpaa8VcLeWd9oH0Wl9ZmuziPzIhIWSEafHID41yTIzOi7RHyM1rjFesdbIHT6HGz2bbbQS8sPxGBku8vkJcfcWlemp+tqFEOX7MntXBXXFqz0kLliAMBrjQaS1pYb5+2FxJSx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014)(22082099003)(56012099003)(18002099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hnTwYI4Bqxlj97NgoKC6MNjxjUiEWAuGfdHsrvvre5YaIF4Am1YqPv9+hMM6?=
 =?us-ascii?Q?fQxVDJTF91kdCRHBvhU7FyLUDZjCS1jAOPz6ECLznS06hfu7rea8xLtllGIq?=
 =?us-ascii?Q?NCN/vi1iL/Awg/U75EL+pXA8jX5fHrxrU7GmwSDJ8k0NDFJ8UKDIenuVOV0a?=
 =?us-ascii?Q?tUh2J51ZlHtDQT3NEr4emUC6VNI8uVrI0HMsyUOgQouxJ8HPXl8ZXpK6Ps3c?=
 =?us-ascii?Q?3CkBVub6VI44V4ynfZ3Wqr6myHYGrFUGXy9Hl2ESYzVuQx372xFTbr6ALQVf?=
 =?us-ascii?Q?1TsYSxr0KPjiFXsDio05xN8A4fi1Cg7Tq8uKrSDjwMfWstFAaewmPwgC1YBG?=
 =?us-ascii?Q?I+3OGvsEMRm9KyEEZogTooo9O/HlOX9jg+TbqX6qS8ZPLF7wUplY/fV4Ediw?=
 =?us-ascii?Q?g4SRYBWLexwxEY20VP7ZWTcxEY9KNQoo4z3erHv0QP7kLCB65ZqnkKhJmy4e?=
 =?us-ascii?Q?meO1JWYv+3AO/IUXV6cqFoDnp5Ak/bgxtZX2Adayd2N3DP3VXnbKFT37ARLN?=
 =?us-ascii?Q?4qxzVLv6vQF93KhIQLig6dpRcc0MFf6UaT8S+KcWise9d7uMko/9SiKceZIH?=
 =?us-ascii?Q?r+aYj2T9PKpSMNvtT7H6C18ObDdKSPZCutRIgDXwcyv33R0KWGSFKWe6Xc2Z?=
 =?us-ascii?Q?XusJyYk2NbHg+RIIp17+SsbwoLkShky1Tch2vIe55al0+UmvcDRmRjHsorCi?=
 =?us-ascii?Q?RYMalOuVc5ihZLtg0vGkfb0CBhaEao+jsPJPR0g4Andhx0CYmlEXNjT1HDak?=
 =?us-ascii?Q?/+hNtvQ2jo5sPWOIVsJEXsYmPOu9O5Zc006GSR//CA/+/mFAd2u/VryWzueU?=
 =?us-ascii?Q?hthQqWYDxiGcP0o/NHlOYxz53QmsIaDRk3pBqJD1+3rBYUhL7+o47tiH14Vb?=
 =?us-ascii?Q?FyfppLcPm/wqXQHaLby/3ZtxXwM0lMXLDZbGgT0hxSPc8m2816wbjMcrifh7?=
 =?us-ascii?Q?SLJKMstmTEye53jcM+Hxh8DaKSVT2ly5rOU9vRksiwVAvbN3hpTiO++f7dfY?=
 =?us-ascii?Q?w6/0AYtxKPVEgZ1mAxrn6zflhGlY/A5VIB/zW50bj9IsoglP7MoJRWwRB6B0?=
 =?us-ascii?Q?1hx/q1uIJLM6tA7u0QyzpLaxJ+8qTnmWwCpg7DuLc8kJ2Ls6zqjw4DkDa5MC?=
 =?us-ascii?Q?5JL60DHudd58d26UqQL2STBzqf5NrReoa66llmjeBeB+le7um4LlS2IAsqb/?=
 =?us-ascii?Q?d/5TN5g2P0+r+dFYBxao9x2prEYtMiugwvDFu5/AaqEGmLlh4Zgk6+5Sc6Qk?=
 =?us-ascii?Q?psiSR69vGCrNLJRU7LtW4Z/kG1Uh7IjYdWKycX5IXrdDh+/uIiwk+OhTpKPu?=
 =?us-ascii?Q?KPEL4OGY1X22mgUBLBuub63gffhmRPjoF5u++aAxfGtMkgz7Uwg717NGH9eY?=
 =?us-ascii?Q?LqfsmGhCwyTX41VjnGZv8QoJ1nKU9snS/CmK8CRgeq8s9D/cByPcVmF3k5IY?=
 =?us-ascii?Q?UDxONZyhvM9DDTLfiiHCMpOX5T2S8V7p1BTHguG0pirGELoWWxPBAC9q/ype?=
 =?us-ascii?Q?4lxW5lngAh/W4MgGSF/XU0M3OTyWuBeLNKplFbeTbmWOjVvQgRaRfupZORbf?=
 =?us-ascii?Q?PMBopqr7eo8Ev0Jzah1mPADRcFXaeOU5OfSB0CRijXyt6fXtTtrCX9IhZu4A?=
 =?us-ascii?Q?QIXtc8dq3Yv83rDpJWjl8i7MLd6GukR5ZUMF8TGrKNIblsHI4t5Bd7KVE4XM?=
 =?us-ascii?Q?XLZwjVb2ZlxDAs68DvdKhrQ1d9JeuCu2WwYubSUq390d6Wl5vSCOEDRuo6Tf?=
 =?us-ascii?Q?0qIuEGwzFw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2601a36f-deb6-46b8-13a1-08deb507cede
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 18:03:47.5564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EfIrUKY94kimbQRWVeXUWn/YTIbUDMSmMnqF1xkROdYyTGhGuSGXS41ujJaW1pdatzbyHDBQXgMeD4+Y2uTwDA==
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

Add a `Device::resource_flags()` method to the PCI Rust abstraction,
wrapping the C-side static inline `pci_resource_flags()`.

The flags returned correspond to the `IORESOURCE` bitmask carried by a
PCI BAR's `struct resource`.

The immediate motivation is BAR layout discovery on NVIDIA GPUs: a
64-bit BAR consumes two consecutive Linux PCI resource slots (the lower
32 bits at index N and the upper 32 bits at index N+1, with the latter
having no flags or size of its own).

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 rust/helpers/pci.c         |  6 ++++++
 rust/kernel/io/resource.rs |  8 ++++++++
 rust/kernel/pci.rs         | 14 ++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
index e44905317d75..51148987618a 100644
--- a/rust/helpers/pci.c
+++ b/rust/helpers/pci.c
@@ -19,6 +19,12 @@ __rust_helper resource_size_t rust_helper_pci_resource_len(struct pci_dev *pdev,
 	return pci_resource_len(pdev, bar);
 }
 
+__rust_helper unsigned long rust_helper_pci_resource_flags(const struct pci_dev *pdev,
+							   int bar)
+{
+	return pci_resource_flags(pdev, bar);
+}
+
 __rust_helper bool rust_helper_dev_is_pci(const struct device *dev)
 {
 	return dev_is_pci(dev);
diff --git a/rust/kernel/io/resource.rs b/rust/kernel/io/resource.rs
index b7ac9faf141d..78f353d1605b 100644
--- a/rust/kernel/io/resource.rs
+++ b/rust/kernel/io/resource.rs
@@ -226,10 +226,18 @@ impl Flags {
     /// Resource represents a memory region that must be ioremaped using `ioremap_np`.
     pub const IORESOURCE_MEM_NONPOSTED: Flags = Flags::new(bindings::IORESOURCE_MEM_NONPOSTED);
 
+    /// Memory region uses a 64-bit address (consumes two consecutive PCI resource slots).
+    pub const IORESOURCE_MEM_64: Flags = Flags::new(bindings::IORESOURCE_MEM_64);
+
     // Always inline to optimize out error path of `build_assert`.
     #[inline(always)]
     const fn new(value: u32) -> Self {
         crate::build_assert!(value as u64 <= c_ulong::MAX as u64);
         Flags(value as c_ulong)
     }
+
+    /// Wrap a raw `c_ulong` value returned by a C API into [`Flags`].
+    pub(crate) const fn from_raw(value: c_ulong) -> Self {
+        Flags(value)
+    }
 }
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index af74ddff6114..d76a1377195e 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -17,6 +17,7 @@
         from_result,
         to_result, //
     },
+    io::resource,
     prelude::*,
     str::CStr,
     types::Opaque,
@@ -437,6 +438,19 @@ pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
         Ok(unsafe { bindings::pci_resource_len(self.as_raw(), bar.try_into()?) })
     }
 
+    /// Returns the resource flags (`IORESOURCE_*`) of the given PCI BAR.
+    pub fn resource_flags(&self, bar: u32) -> Result<resource::Flags> {
+        if !Bar::index_is_valid(bar) {
+            return Err(EINVAL);
+        }
+
+        // SAFETY:
+        // - `bar` is a valid bar number, as guaranteed by the above call to `Bar::index_is_valid`,
+        // - by its type invariant `self.as_raw` is always a valid pointer to a `struct pci_dev`.
+        let raw = unsafe { bindings::pci_resource_flags(self.as_raw(), bar.try_into()?) };
+        Ok(resource::Flags::from_raw(raw))
+    }
+
     /// Returns the PCI class as a `Class` struct.
     #[inline]
     pub fn pci_class(&self) -> Class {
-- 
2.34.1

