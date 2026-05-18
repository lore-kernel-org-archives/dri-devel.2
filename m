Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C425DCD4F52
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 18:12:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 841A010E99B;
	Mon, 18 May 2026 18:12:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="JpqmX9Y9";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011056.outbound.protection.outlook.com [52.101.52.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DDFE10E985
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 18:12:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cmt4zJjdocTEKOU+6vfbsLfSQLTannaRshZXJO8UEusvD5WFXtqR5otrsqVO1BnrTfK1uxK1sd4K1Q0mMGBoQvhnYYEqLATJ97evYJTE70jP+aEDLvJ81UsSLsJnZQXRQtV3E4qXovD/JgS69skemD+wzkLSI3gew2K6Dv6NxWRsfGrwU6ByjoNGE1vmmQ/vwv85o4r5X+72uAw7pCa9Rfyq5DfVflPwj2dnk7wo2hulZnNQFEv2C6QOVjTLT/yHRS0EGC47lZGl359dNN/3M6HyunKpuacRG40nRchpwSVgZNp/H/Fwcrod1HU/326aXStOIugk1fnsZZxV8zz+kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QE0fPvoW04e3Vqv2Go07XYlDSGEZpr3r3QwfIHnp9XA=;
 b=KRED+6CGaH1On7q6UfvRAcvcWtKF4KqSzdfAQ80YJmnFb7eolYNehQ0F6VGjqzZjhb+FOcJQ2eDYwj9v3mrTjf2RrNafl71R5kjB6m1dU6kaEL1n1NqaVCX3KZwj5yoxfTXogA3TZV5J0qMAD5bMyDpQQqprKzzNW3O5y4ql/Gwa6eIxf99YAohwJ8FyVbqvsSXs2jHt9WRCdzcuq/Yh+U9bJKHn8isKsIykDWyxATm/4v5lOgqEMWTz5UpkMbnzC64gVy+oQNxD3Tng3rvLVADQuZjElTpR0zzBHJxtl3ljsXJ8Oi8hRDXvH8iKFkMWP2kmhsaOuz25V5wAXLuY6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QE0fPvoW04e3Vqv2Go07XYlDSGEZpr3r3QwfIHnp9XA=;
 b=JpqmX9Y9wSAJ1BHzkHIKcTjqJ/XgberwOMkI23IAijvnZQuZEP+gFANm2mBzNZ8h5X+1K56O1ArCVmhqvkkADmnqmtJVM3vOCyjy796aSxS9E2lXdg3iQnLoqcI4aElhCw9IBmaOjTL+iva0vCU4HByLwxwMmVut68SX9dqqtwI4rhASGHclW00VYscvSq5yNmU8YF6f0kiNkzT5kR2yie58j4vih1Ir2CCOk3E2yhzWUjWmbupLO2T/lWtZp1Mt9nF1CYLZmhNQTeQ+hmVxpbJZuDTOaJQH9UI0/DRvrt61wlr/xUpizORQqlO8F1LLNf6nvhlBbQUmBhHA4RDFYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 CH3PR12MB8727.namprd12.prod.outlook.com (2603:10b6:610:173::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 18:11:55 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0025.012; Mon, 18 May 2026
 18:11:55 +0000
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
Subject: [PATCH v1 16/16] gpu: nova-core: mm: Add BAR1 memory management
 self-tests
Date: Mon, 18 May 2026 14:11:25 -0400
Message-Id: <20260518181126.2493572-17-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518181126.2493572-1-joelagnelf@nvidia.com>
References: <20260518181126.2493572-1-joelagnelf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0303.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::8) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|CH3PR12MB8727:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bad6efd-490b-44a9-c7d4-08deb508f159
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|11063799003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: R7iYdxZXTn7swmvaLH+MoZ6z7gf/u81LHwTUmRemyvlWiaXyx1D5eMsYezpkZLZyr0Mmtb9ji1k3Rza/g6UVmdIhtJWGnMfJ0PffFmuYWTT9XZBZM9b+I/e8/gZj2y9zmkvYrbDKASRRdlswetrmbx94jy7Puyq7Hebr16c9B/WUpH7Iw8Jqpp645dxpDUMHxnJR06MDaYcS4//GYPnlFHvBtLyBhzge4zIgRlh3F0/cnO6d/1YE0MuJq6EG4WK4dbqfLjuAErevhnS95USXM03pIjRcGpc+oGCrCiJWrLzs/bW7ygvxWqydcqj52fFDAn2rgK7DlpbMFH63C6MiOcSmS4KLIC5mkt6ZHWU+cp2HMG0BxHNKR1UKMfeYIiJ7Je9NTXVtV5cbxaZJihWj48Z4ahP6vLmVxNZa49iwFGbPIMw6j8f3uHW4fz+c8tVeoZ5W8QenvmjCqCE+efgWYkOXqsLNJ1DFQWg4ynjNWPSO/B/QIfu79sEj/K2VKVY7N7yuOgyn7p7ljdRFzYB3Ipvzmhuue5B9Xs596FElRj13Q2hdwfIZjrG6ITWvYpwQlhlLvRd6Lhq57yF81iuidTguAXjrbps1OCiFLXcKSiUN8hSU8jogf2kB2t8tvEv/fnMkhllo+aNfP+MjKD8ARVf/pEGTU/qHdHsXadgUXX8o7ftYyvc8guQ0nDx3cUCN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(11063799003)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1FmV09ZRGszSEQvSGNJTXNLRi9LeXNlSnppbzB6SkxKTHMzMlB1ZTZGMUtY?=
 =?utf-8?B?eHpNT0dRcSsyOUFCcER2bHpzV016UmtIVGU3ZEg3OC93Y0JwdnJ4VkxGZTVm?=
 =?utf-8?B?UjE2ZHN4NnN1emxCMGxya0pJK285a1JheGJCdEdKZmsvbnZJRWQwaTBEZVFn?=
 =?utf-8?B?c0EyY0hWaXdSTnZHQ09vVkgyZVcyc1M0cytHbi9hcFNBcUJUNldLSTFReGVQ?=
 =?utf-8?B?R0hWNFNIZzVNcFdSWWtjZmthMmswenlZeGRvV0FvanBjL3dya2pWdjhheDB4?=
 =?utf-8?B?dU9HS1RtRFpuWHFuRHI1Myt1RnhWamY0N3NISHh2MXJEZHJONWJWd2NmeEpm?=
 =?utf-8?B?TlNpSngyVnBLVEpqWE1LZzBOWTAyMXUyNnd4QmQyekx3WmUxMHZHSXVSZTRy?=
 =?utf-8?B?eDhLQ1lLck9FaW1pY1p3MSs5SHE3VjFBcWxobWd1ZXU4MmsvNWtTbFhJSVYz?=
 =?utf-8?B?SW1XL3cwNFhmNFZqYXREOTN0R0MzOHBRKzdOMGZjMy80RlExNmFxbjBGSFRu?=
 =?utf-8?B?RFYwQXdRMlQxTytLc3NrS3lsUEpwWE9JbmsyQ1V0MG1NSklxYWR2Wko2R3Fm?=
 =?utf-8?B?UTU5TzlnbDc1empoT1lENDk3QmE5UWRrLzFHRXAvRDBiQ2VlZDBMa0JNVG03?=
 =?utf-8?B?WlVUTGJTU3VpWXFxTlo3RU1QaCtsQzdHUjE1cHJSdnBNeDEzNTB6aGw5ZklN?=
 =?utf-8?B?SkJlQTc5UEoxVGFIYjZlOWVqYzhoU2x1YVZCZXhMNHRFMVgxc1F2VlYzWDY3?=
 =?utf-8?B?dUtQM1FLcDhybFp3MmxOTk54UVVnRXdKSzVjcitCUmdML09iVVZIYnAyRkp0?=
 =?utf-8?B?VlkzNWtKQytlUk5PcGJyb2Z4Nkl0K29nZWY0Z2ZkY1dGU1JzdFppM1A4Tk5T?=
 =?utf-8?B?MGFXODROVVZFeFlxNzg2V3pHT1BZNWtIbCtUc21KRXZOUUV2Y2d2c25EQkt1?=
 =?utf-8?B?eW1RdTFUWXZlWUxuYUJEK2lwY3BrUjhQZjIzakZ1aGVWUTVDY0hsOTh5SEZa?=
 =?utf-8?B?MGdrajB5akZnNGRPVXBKaVlVWHJLckhaSWlWY3NpV0VoNXBrWXA2ZXluT0Zv?=
 =?utf-8?B?QW1uYjVZQkd5akwvUnBWWDhKV1dzSm9BR0w2alJwc25uN2dCSklKL21XL25N?=
 =?utf-8?B?S1hwaUhEUHVoM2RwYWhBU0NaRjdyRnlSTDRjRWZTMmZuVW1NRk9ya2pYTFk1?=
 =?utf-8?B?MjY2Wit4TWRmNHVyeVpOVlpidmpzaDBsRk9nVEVpVjJaM3dtaCs0YWYwMmk3?=
 =?utf-8?B?Ni94cDFrQmovSkozWTNWY21mek5XV1F3YlUxT2FCRDhkQlpjaHJzSklnTy9o?=
 =?utf-8?B?QVVDallnbTB0ZkkyamIvSS9UT1BnZnZmbXBkcnBzVXNiV0dSWHhweGdNaVZj?=
 =?utf-8?B?dHVuZFZCamhoYmYzVXFTTCswdTJNTnMyNG1tNGtHYVgwODdQTkUrVVBRUDY0?=
 =?utf-8?B?blY4ZU9kNmExTjdZRjViUjdqQTNHb1ZaZkJGcW9sT2pudUFuTUdJeUo5cGx6?=
 =?utf-8?B?bUJ2NnFrb01PNHc5N1BpSWY1bHFhdzNwQU5yM1hRbGppZk5vdDBmdXlmUVd6?=
 =?utf-8?B?VDFSTFZLRTNoV1d0ODVuTUpydDh1emR5akp4UWkzTzZTTXdUMG8yWTdBaXE5?=
 =?utf-8?B?dzh6cUF1YkZqN3o1cTEyZnVCZFl3MWg2QzZxWk9ROVJRVHRrZ01KNUM5VU5I?=
 =?utf-8?B?Qmp1WnNPSU0xbWRhSWNOV1YzMDBRNmMzZEgwMmMrTnYxM2REL1h5NEdIMCtq?=
 =?utf-8?B?eC9yZGhyRFp5ZnpsRlc3QWlNSUFEZ3IzOWNEdlI2S0RTMER1bXNXSGxoekJL?=
 =?utf-8?B?aVRUaDd3TnFpYTBMcEJ5TzJBWEc3M3ZzWkRUZ1gzVzdpbXo2emkxczUwQjVa?=
 =?utf-8?B?Nm1RN0w5YWVEVnp3QUxJU09KYjlGeFlwMHhFN29GY0l0Nmg4STFUVmpmVUFF?=
 =?utf-8?B?Q0liZS9VN0dmSmhVeVhsWjk3eTBpMlROTGhSMElpdUxGWjZ4RXZVNWpxYXdx?=
 =?utf-8?B?aG5kWkxKOUtjWWc1dVpXdWM5Skh3Nm9ENWUyNVQxbENKWDFRYTdBNTllWDhL?=
 =?utf-8?B?MVl3VnJkUmV3eDRyQnlzRjljOG02enorMUlYaUZHL2g3eHlzcFd6NEROVk5V?=
 =?utf-8?B?bXpRRnZWWkdmV2VPTGFwWkw1REFMbENCRG9FMmwrQWJsT0Q4RXlHd1YwUHhP?=
 =?utf-8?B?cnhIcmRJRmh4ZGRuNWlGc2N5bW5CR3haZUo0cGZ3VVZwYi9vUVhEQkJpN3ZY?=
 =?utf-8?B?Qk5UR3RRSUtWWUJkYmFSWHVJUXVRK3JIVHB1UHVJejZFUkdCZmJtbUlvbC96?=
 =?utf-8?B?ZlJIaEttMWJxNENnNTdSZktaOVpqd2xCRWtkVnI5SUU5TC9wd2REQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bad6efd-490b-44a9-c7d4-08deb508f159
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 18:11:55.0361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7zPg+AmSaYLbCXw26q47YK5BXQsA7+8+gMu6Wd+AMXpsApEyEogeQYdsJZLMF3rpk5quhVWqzuI6Vvvyy0W+fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8727
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

Add self-tests for BAR1 access during driver probe when
CONFIG_NOVA_MM_SELFTESTS is enabled (default disabled). This results in
testing the Vmm, GPU buddy allocator and BAR1 region all of which should
function correctly for the tests to pass.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs          |   8 +-
 drivers/gpu/nova-core/mm.rs           |  12 +-
 drivers/gpu/nova-core/mm/bar_user.rs  | 253 ++++++++++++++++++++++++++
 drivers/gpu/nova-core/mm/pagetable.rs |  33 ++++
 4 files changed, 303 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index b0eebe6406e5..6ed486503957 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -405,7 +405,13 @@ pub(crate) fn run_selftests(
         self: Pin<&mut Self>,
         pdev: &pci::Device<device::Bound>,
     ) -> Result {
-        crate::mm::run_mm_selftests(pdev, &self.mm, self.spec.chipset)?;
+        crate::mm::run_mm_selftests(
+            pdev,
+            &self.mm,
+            &self.bar1,
+            self.gsp_static_info.bar1_pde_base,
+            self.spec.chipset,
+        )?;
         Ok(())
     }
 }
diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index 4741ef60593b..ed77162db848 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -55,7 +55,10 @@ macro_rules! impl_pfn_bounded {
 };
 
 use crate::{
-    driver::Bar0,
+    driver::{
+        Bar0,
+        Bar1, //
+    },
     gpu::Chipset, //
 };
 
@@ -122,10 +125,15 @@ pub(crate) fn tlb(&self) -> &Tlb {
 pub(crate) fn run_mm_selftests(
     pdev: &pci::Device<device::Bound>,
     mm: &Arc<GpuMm>,
+    bar1: &Arc<Devres<Bar1>>,
+    bar1_pde_base: u64,
     chipset: Chipset,
 ) -> Result {
     #[cfg(CONFIG_NOVA_MM_SELFTESTS)]
-    pramin::run_self_test(pdev.as_ref(), mm.pramin(), chipset)?;
+    {
+        pramin::run_self_test(pdev.as_ref(), mm.pramin(), chipset)?;
+        bar_user::run_self_test(pdev.as_ref(), mm, bar1, bar1_pde_base, chipset)?;
+    }
 
     Ok(())
 }
diff --git a/drivers/gpu/nova-core/mm/bar_user.rs b/drivers/gpu/nova-core/mm/bar_user.rs
index bb9742c036b7..96e1389dcbe9 100644
--- a/drivers/gpu/nova-core/mm/bar_user.rs
+++ b/drivers/gpu/nova-core/mm/bar_user.rs
@@ -192,3 +192,256 @@ fn drop(&mut self) {
         // identifying the leaked VA range.
     }
 }
+
+/// Run MM subsystem self-tests during probe.
+///
+/// Tests page table infrastructure and `BAR1` MMIO access using the `BAR1`
+/// address space. Uses the `GpuMm`'s buddy allocator to allocate page tables
+/// and test pages as needed.
+#[cfg(CONFIG_NOVA_MM_SELFTESTS)]
+pub(crate) fn run_self_test(
+    pdev: &device::Device<device::Bound>,
+    mm: &Arc<GpuMm>,
+    bar1_devres: &Arc<Devres<Bar1>>,
+    bar1_pdb: u64,
+    chipset: Chipset,
+) -> Result {
+    use kernel::gpu::buddy::{
+        GpuBuddyAllocFlags,
+        GpuBuddyAllocMode, //
+    };
+    use kernel::ptr::Alignment;
+    use kernel::sizes::{
+        SZ_16K,
+        SZ_32K,
+        SZ_4K,
+        SZ_64K, //
+    };
+
+    // Test patterns.
+    const PATTERN_PRAMIN: u32 = 0xDEAD_BEEF;
+    const PATTERN_BAR1: u32 = 0xCAFE_BABE;
+
+    let dev = pdev;
+    let bar1: &Bar1 = bar1_devres.access(pdev)?;
+    dev_info!(dev, "MM: Starting self-test...\n");
+
+    let pdb_addr = VramAddress::new(bar1_pdb);
+
+    // Check if initial page tables are in VRAM.
+    if crate::mm::pagetable::check_pdb_valid(pdev, mm.pramin(), pdb_addr, chipset).is_err() {
+        dev_info!(dev, "MM: Self-test SKIPPED - no valid VRAM page tables\n");
+        return Ok(());
+    }
+
+    // Set up a test page from the buddy allocator.
+    let test_page_blocks = KBox::pin_init(
+        mm.buddy().alloc_blocks(
+            GpuBuddyAllocMode::Simple,
+            SZ_4K.into_safe_cast(),
+            Alignment::new::<SZ_4K>(),
+            GpuBuddyAllocFlags::default(),
+        ),
+        GFP_KERNEL,
+    )?;
+    let test_vram_offset = test_page_blocks.iter().next().ok_or(ENOMEM)?.offset();
+    let test_vram = VramAddress::new(test_vram_offset);
+    let test_pfn = Pfn::from(test_vram);
+
+    // Create a VMM of size 64K to track virtual memory mappings.
+    let mut vmm = Vmm::new(pdb_addr, chipset.mmu_version(), SZ_64K.into_safe_cast())?;
+
+    // Create a test mapping.
+    let mapped = vmm.map_pages(pdev, mm, &[test_pfn], None, true)?;
+    let test_vfn = mapped.vfn_start;
+
+    // Pre-compute test addresses for the PRAMIN to BAR1 read test.
+    let vfn_offset: usize = test_vfn.raw().into_safe_cast();
+    let bar1_base_offset = vfn_offset.checked_mul(PAGE_SIZE).ok_or(EOVERFLOW)?;
+    let bar1_read_offset: usize = bar1_base_offset + 0x100;
+    let vram_read_addr = test_vram + 0x100;
+
+    // Test 1: Write via PRAMIN, read via BAR1.
+    {
+        let mut window = mm.pramin().get_window(pdev)?;
+        window.try_write32(vram_read_addr, PATTERN_PRAMIN)?;
+    }
+
+    // Read back via BAR1 aperture.
+    let bar1_value = bar1.try_read32(bar1_read_offset)?;
+
+    let test1_passed = if bar1_value == PATTERN_PRAMIN {
+        true
+    } else {
+        dev_err!(
+            dev,
+            "MM: Test 1 FAILED - Expected {:#010x}, got {:#010x}\n",
+            PATTERN_PRAMIN,
+            bar1_value
+        );
+        false
+    };
+
+    // Cleanup - invalidate PTE.
+    vmm.unmap_pages(pdev, mm, mapped)?;
+
+    // Test 2: Two-phase prepare/execute API.
+    let prepared = vmm.prepare_map(pdev, mm, 1, None)?;
+    let mapped2 = vmm.execute_map(pdev, mm, prepared, &[test_pfn], true)?;
+    let readback = vmm.read_mapping(pdev, mm, mapped2.vfn_start)?;
+    let test2_passed = if readback == Some(test_pfn) {
+        true
+    } else {
+        dev_err!(dev, "MM: Test 2 FAILED - Two-phase map readback mismatch\n");
+        false
+    };
+    vmm.unmap_pages(pdev, mm, mapped2)?;
+
+    // Test 3: Range-constrained allocation with a hole — exercises block.size()-driven
+    // BAR1 mapping. A 4K hole is punched at base+16K, then a single 32K allocation
+    // is requested within [base, base+36K). The buddy allocator must split around the
+    // hole, returning multiple blocks (expected: {16K, 4K, 8K, 4K} = 32K total).
+    // Each block is mapped into BAR1 and verified via PRAMIN read-back.
+    //
+    // Address layout (base = 0x10000):
+    //   [    16K    ] [HOLE 4K] [4K] [ 8K ] [4K]
+    //   0x10000       0x14000  0x15000 0x16000 0x18000 0x19000
+    let range_base: u64 = SZ_64K.into_safe_cast();
+    let sz_4k: u64 = SZ_4K.into_safe_cast();
+    let sz_16k: u64 = SZ_16K.into_safe_cast();
+    let sz_32k_4k: u64 = (SZ_32K + SZ_4K).into_safe_cast();
+
+    // Punch a 4K hole at base+16K so the subsequent 32K allocation must split.
+    let _hole = KBox::pin_init(
+        mm.buddy().alloc_blocks(
+            GpuBuddyAllocMode::Range(range_base + sz_16k..range_base + sz_16k + sz_4k),
+            SZ_4K.into_safe_cast(),
+            Alignment::new::<SZ_4K>(),
+            GpuBuddyAllocFlags::default(),
+        ),
+        GFP_KERNEL,
+    )?;
+
+    // Allocate 32K within [base, base+36K). The hole forces the allocator to return
+    // split blocks whose sizes are determined by buddy alignment.
+    let blocks = KBox::pin_init(
+        mm.buddy().alloc_blocks(
+            GpuBuddyAllocMode::Range(range_base..range_base + sz_32k_4k),
+            SZ_32K.into_safe_cast(),
+            Alignment::new::<SZ_4K>(),
+            GpuBuddyAllocFlags::default(),
+        ),
+        GFP_KERNEL,
+    )?;
+
+    let mut test3_passed = true;
+    let mut total_size = 0usize;
+
+    for block in blocks.iter() {
+        total_size += IntoSafeCast::<usize>::into_safe_cast(block.size());
+
+        // Map all pages of this block.
+        let page_size: u64 = PAGE_SIZE.into_safe_cast();
+        let num_pages: usize = (block.size() / page_size).into_safe_cast();
+
+        let mut pfns = KVec::new();
+        for j in 0..num_pages {
+            let j_u64: u64 = j.into_safe_cast();
+            pfns.push(
+                Pfn::from(VramAddress::new(
+                    block.offset() + j_u64.checked_mul(page_size).ok_or(EOVERFLOW)?,
+                )),
+                GFP_KERNEL,
+            )?;
+        }
+
+        let mapped = vmm.map_pages(pdev, mm, &pfns, None, true)?;
+        let bar1_base_vfn: usize = mapped.vfn_start.raw().into_safe_cast();
+        let bar1_base = bar1_base_vfn.checked_mul(PAGE_SIZE).ok_or(EOVERFLOW)?;
+
+        for j in 0..num_pages {
+            let page_bar1_off = bar1_base + j * PAGE_SIZE;
+            let j_u64: u64 = j.into_safe_cast();
+            let page_phys = block.offset()
+                + j_u64
+                    .checked_mul(PAGE_SIZE.into_safe_cast())
+                    .ok_or(EOVERFLOW)?;
+
+            bar1.try_write32(PATTERN_BAR1, page_bar1_off)?;
+
+            let pramin_val = {
+                let mut window = mm.pramin().get_window(pdev)?;
+                window.try_read32(VramAddress::new(page_phys))?
+            };
+
+            if pramin_val != PATTERN_BAR1 {
+                dev_err!(
+                    dev,
+                    "MM: Test 3 FAILED block offset {:#x} page {} (val={:#x})\n",
+                    block.offset(),
+                    j,
+                    pramin_val
+                );
+                test3_passed = false;
+            }
+        }
+
+        vmm.unmap_pages(pdev, mm, mapped)?;
+    }
+
+    // Verify aggregate: all returned block sizes must sum to allocation size.
+    if total_size != SZ_32K {
+        dev_err!(
+            dev,
+            "MM: Test 3 FAILED - total size {} != expected {}\n",
+            total_size,
+            SZ_32K
+        );
+        test3_passed = false;
+    }
+
+    // Release Tests 1-3's Vmm before Test 4 constructs a fresh BarUser on
+    // the same PDB.
+    drop(vmm);
+
+    // Test 4: Exercise `BarUser::map()` end-to-end.
+    let bar_user = Arc::pin_init(
+        BarUser::new(
+            pdb_addr,
+            chipset,
+            SZ_64K.into_safe_cast(),
+            mm.clone(),
+            bar1_devres.clone(),
+        )?,
+        GFP_KERNEL,
+    )?;
+    let access = bar_user.map(pdev, &[test_pfn], true)?;
+
+    // Write pattern via PRAMIN, read via BarUserAccess.
+    {
+        let mut window = mm.pramin().get_window(pdev)?;
+        window.try_write32(test_vram, PATTERN_BAR1)?;
+    }
+
+    let readback = access.try_read32(pdev, 0)?;
+    let test4_passed = if readback == PATTERN_BAR1 {
+        true
+    } else {
+        dev_err!(
+            dev,
+            "MM: Test 4 FAILED - Expected {:#010x}, got {:#010x}\n",
+            PATTERN_BAR1,
+            readback
+        );
+        false
+    };
+    access.release(pdev)?;
+
+    if test1_passed && test2_passed && test3_passed && test4_passed {
+        dev_info!(dev, "MM: All self-tests PASSED\n");
+        Ok(())
+    } else {
+        dev_err!(dev, "MM: Self-tests FAILED\n");
+        Err(EIO)
+    }
+}
diff --git a/drivers/gpu/nova-core/mm/pagetable.rs b/drivers/gpu/nova-core/mm/pagetable.rs
index 042584e5178b..fb573f07b4cf 100644
--- a/drivers/gpu/nova-core/mm/pagetable.rs
+++ b/drivers/gpu/nova-core/mm/pagetable.rs
@@ -17,6 +17,9 @@
 
 use kernel::num::Bounded;
 
+#[cfg(CONFIG_NOVA_MM_SELFTESTS)]
+use kernel::device;
+
 use crate::gpu::Architecture;
 use crate::mm::{
     pramin,
@@ -379,3 +382,33 @@ fn from(val: AperturePde) -> Self {
         Bounded::from_expr(val as u64 & 0x3)
     }
 }
+
+/// Check if the PDB has valid, VRAM-backed page tables.
+#[cfg(CONFIG_NOVA_MM_SELFTESTS)]
+fn check_pdb_inner<M: MmuConfig>(
+    dev: &device::Device<device::Bound>,
+    pramin: &pramin::Pramin,
+    pdb_addr: VramAddress,
+) -> Result {
+    let mut window = pramin.get_window(dev)?;
+    let raw = window.try_read64(pdb_addr)?;
+
+    if !M::Pde::from_raw(raw).is_valid_vram() {
+        return Err(ENOENT);
+    }
+    Ok(())
+}
+
+/// Check if the PDB has valid, VRAM-backed page tables, dispatching by MMU version.
+#[cfg(CONFIG_NOVA_MM_SELFTESTS)]
+pub(super) fn check_pdb_valid(
+    dev: &device::Device<device::Bound>,
+    pramin: &pramin::Pramin,
+    pdb_addr: VramAddress,
+    chipset: crate::gpu::Chipset,
+) -> Result {
+    match MmuVersion::from(chipset.arch()) {
+        MmuVersion::V2 => check_pdb_inner::<MmuV2>(dev, pramin, pdb_addr),
+        MmuVersion::V3 => check_pdb_inner::<MmuV3>(dev, pramin, pdb_addr),
+    }
+}
-- 
2.34.1

