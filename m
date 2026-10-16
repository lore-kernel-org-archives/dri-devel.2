Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E9ACCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:54:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30B5E11255A;
	Fri, 16 Oct 2026 01:54:41 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012053.outbound.protection.outlook.com [52.101.48.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B5EE10EBAE
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 01:54:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mlXCv7areOkp4I3im8TxUa2ucpjvw3bxpb4jqAxcWvGmiKvA8722eIqIkEZYwnuj/cTpZZXE3/UU+cpqCeFB/k5kSDHkpGKus1HTeA3zx+YWJrYNN/w1WQxSzvFgxbP1pO7VaoGIWOjDou7PdOdZR3J5OAoWU9xJ68ebZeN8H/A/1k/cwRKWU5l2EFJnm/Ki23DjBt8LkIxHRhsg1RHXUCy+YTV0WHVwQEwkKp1+tVUG1bOBHhq2GnLuLZMZG0ue8RfsiPTAbQIFLyTWTt+pWhNNDKiU9GCkFUGY1OfcD6xGBsK9VPAzNU+jrk1C7gH0Zw30ZjPu8djkWm+IgvDmYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7le30eyTxPCMHKUv1rtjFDk1i4D2xAPMejGCyo/JCKU=;
 b=ONCOxk1ISdtC+Xnz5z5/q4lJQagtFUt9Sw5fcCEI7tvEW6v5bug7IrovhmqQ1Nfgq+nF2WosxahjK3MaMyJbISg9/eD4oqmh0/QPAA93LlHyb1JptSe8ra0isQAFagdoRMeEfGrATuLHZHrNFGAe6MbBuLEELoTEGiCXej7yezHkZhRfbF4nyuyG0qCQigBiS9aZ8pwrb6EBoezDZUl0aM34b2Sw52pzkiuK1emrCVlNIx4dGfnR0L7+jkpzhDvvUIviITnZpB783jPNZVf4nbgXmD6Itu5t6B+NGLljM3mEsciqcWAkc55nprDxhQs8cx5fHA04aoBPtw1GAN/MMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7le30eyTxPCMHKUv1rtjFDk1i4D2xAPMejGCyo/JCKU=;
 b=a9iGRK6+3P7lJYdmAlD3ql2WmINf5WrbZX4bcvVBHtEU1hz2X55L50EYeLIbgSLCc5KARmy8o3iuXz8otFZZLBLA0AL5xBCdoF/eRCfezItYQ8so2I40VI+VabYd2r13Xsr2TyrUwXOGGbYrlo8zNDNcD5hPWKnzMJntkYyr0KaCi/S8vpPIpam1U3YJ5C4ipvJPfYRiO3c8CktVwtYBB1yTO9oINj5ccdmNXHHAp8jdem3UCl4xOSCArvh8xuSNQ3Zt5Vlz+IFHI01qFXSQcJ2tQb4eTVdP6L2fjf8PRv0hZtpYw/357B2Gjt/dzENg6J4w2C0CQ0jwFJ5HC+sTNw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 SA1PR12MB999230.namprd12.prod.outlook.com (2603:10b6:806:4de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 01:54:14 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0496.021; Fri, 16 Oct 2026
 01:54:14 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Fri, 16 Oct 2026 10:53:38 +0900
Subject: [PATCH v4 2/7] rust: alloc: add ArrayVec
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-b4-nvkv-v4-2-e8b92b91aa5b@nvidia.com>
References: <20261016-b4-nvkv-v4-0-e8b92b91aa5b@nvidia.com>
In-Reply-To: <20261016-b4-nvkv-v4-0-e8b92b91aa5b@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0143.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::19) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|SA1PR12MB999230:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f74e4cf-2490-4cc8-c45f-08df2b286120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|23010399003|10070799003|366016|376014|6133799003|18002099003|10067099003|22082099003|921020|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: /M7aEbKYPmMT70ADCKNcOUM2DbMBAZJ4XhbQV4ywXI8820r/GWRIUmopJh+K4AUMYtL8r3P1Q+dmBRa+XVzeCbsfQfbjnTnfxq+KtnfAyHK2nnz31NLHmKDxFlAi0BRTfK88ZGcPUYQ83iql/NE27WZnGoL+BOa32n2MxYIK1IMs5EAjv5ydCSB/huRu2YGOfw2W1gqyAOvAw6g5VcaAGqwJtukMZ3cWW01YWtrFFsJTwKLXD2cbRxoauHmDOtl+mubsFluRBztQB4ZU8SxNSw/JYTDWv0Ciwl+3F0Wm6xwygMmx+MNvOI/lKFxOH1aSFGOlsPpEeDkbkca3Czkx7JXy1dfyD6Skg2+7H2hmBb5djiDxDhSCBeRmNc9lnyYLfpo/uGz2ue8G582NsCcmO9sEFtoLHT5FY2tkmNUGAsr8PKtjl3LcKsIVZtB6NoRvE2kZuJtgy6Za4WaYizITljksZyE8O3WQO6F+xDXJS0S7+ENhgcmlv9H2LcH3F812/SCaUiR5AceQnpa6YfDGhIzr8TfRdrsfTWWan2JecxoLGRjMEr4ybvXBQJX202xRuLWAsVLmXHaZtLdxALd3gpzi3nhUs13Bx3K6UdhGuV7JEuTsNYOFrD4Zt48GWnlNVyT2HIVQBi71b3JxNl7ZeC5HK7iK/92Ug+sV23C0HcdZzKg5C2V6dmlOwNFmydWS1oWWziUt5gZ3dxVVZQoszA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(23010399003)(10070799003)(366016)(376014)(6133799003)(18002099003)(10067099003)(22082099003)(921020)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S29QbS9pZjhqZGNYbWpDOU5NdnI4cW03aXlpRGRUU1ZLR3RVOW02c0JRSCtl?=
 =?utf-8?B?anpBdGlwS2xIVTVsVGVNMWE4b0pRL0pmcGlwKzBNRmE1ZjE2QVZZZEp1M1Jt?=
 =?utf-8?B?ZVEwUjFIMXZMK0R1M3NxUm9SUEtuTVRRREo5Sk5aU3ROSUVTSjJON2NVclNq?=
 =?utf-8?B?MlJhWFBnVlBmMmQrU0NjMmdhRGdHKzBaUjh5Z0lLNlJxcWdXdnk0ZXVFTkxn?=
 =?utf-8?B?azVsSUJ6NFhuNS9WejhFV1dJZXpUMkI5MkVvWkJpczluQW9oY2YrTVp0dDB1?=
 =?utf-8?B?TkxXa09kb2daY3BjVElaMHFEOVpvTndtZFhWWGMzaUFmOWUya2I2VU1mQzN1?=
 =?utf-8?B?cEVTVmE1b0ZuVS81UStwd2RRLzJZNW5Fc0lOOTdCeWNYbXNCWXRMYUh3aUdn?=
 =?utf-8?B?cElrVVBNWXgxNG4yaUJINVVudXVBMUJzT3JNclVFakNjVWwvQ1BjS3BsV3h5?=
 =?utf-8?B?WTlNUnB4QmJuZTdDRGJYM3BEaVg0aHNJVzBVRkZTd09Tczk2N011V2YzV2I4?=
 =?utf-8?B?STlsdmg2SW95UkUzUlgzUGJjbzkzTFo3TkJKN0NBbkFDWTh4akYzcjdSMEVP?=
 =?utf-8?B?bksrZHNlellmQVB6NWJ4RlAxZWhGSHJ0NkRmL0pVMkpScGxtV2RzaXhmN2xY?=
 =?utf-8?B?QWVqc0tKaDBiQ0xtQVZBYWtBaC9TN2kxNUt5cU1ISGJVUnRIclM0SXBWVEg1?=
 =?utf-8?B?d2dCd20vMXBRSFF3eWJucTNnQUhZc1o0TXRIcjFRSDF4b2RqQXNRZkg5Y3BB?=
 =?utf-8?B?aWlNTkEra1diQTQwS1RXTVNwQ0xWZndaRkovWWx6OTgwMGhNWUhDZ3ZleEh5?=
 =?utf-8?B?bHdWYXV6RmhFZ0JncnczSkcyMFBSQmVwZjV0K1R6aDN2ZDM5cEZ6Z0VVMVNL?=
 =?utf-8?B?cDlTQXBWN3NrVEhmZklmMW42WmNnVXpNa2JLT25IclhvRnpGRzBnU0s2S3lI?=
 =?utf-8?B?U0IrbFBtNHFpeFRwd3pmNEwzZlNyTmhmRWU2SC9JdzliV3RjaWt4R1krcUhr?=
 =?utf-8?B?ZVpWNXpDS3pmd0tEL3lrN3VtZHIxbmpmUEMwdUVrcHBFWnY3cFFIeFUwLzFW?=
 =?utf-8?B?dDRpVDVrcE1UMmxkRDNBZ3RGV2ZTblYvb2NzNzVVMTc1YldiUlJVS1ZGZWNl?=
 =?utf-8?B?VWFlcHAybmtOcjAzNnQxdDQvNHJ0Sk0rVEIrSzlHU3RudURWeUNOdHVjeUl5?=
 =?utf-8?B?VjFJQVNCVTBCUVJmV1ROZVlRMXozSEQvaDR2cVpXZzBvVWZ3RXdpa0sxMXRx?=
 =?utf-8?B?RXJ2M0ZkR3VZOWc3cVU0dkFsb21zNS93ZVdJaFZkOFIwT1ZMSmZ1N2FEa3VE?=
 =?utf-8?B?ZUFKdTdvc1VodlRZQVRoSFJzRXo4MTlVTjhrdlFPUUNFS0JkdWdCVlRyUzZ6?=
 =?utf-8?B?YkdYYVJHVCs5eTF5bWkwVnhabkxOWXBCbFA2b2JoVXM3eGcxMUwrWjJBcGhE?=
 =?utf-8?B?ek95akF5VGs1bWY3aXJFZS93M2dmU3pZWDdCWlVXUllha21US0tQUDZGa1JF?=
 =?utf-8?B?OC9vVDBhQlFuUy8vTFR2N2pUaWlpSmVEbG5YL2o4MG5INExMT0tMbERDSGNq?=
 =?utf-8?B?SXJXSzJ1NlB6N0JWTDUzbFI4aXVQOUpUWndYRWhSWGVueEwvWDl5eXcvbGdM?=
 =?utf-8?B?QzRibk1PTlFhajkzNFcvZUZEVnU0eEUvNkR2U1JMVUtwdS9CVFRQU3hMWVVy?=
 =?utf-8?B?YVBrbVlKb0xoY3A1ZElEOXIxdW9qT291MDVzeTdNTFU5OEQ2elB1SDdpemFp?=
 =?utf-8?B?Qk5QQ1pzQUU2c2xZdEl6MWhTTnlvd2VvZkZ3am9YaC94cDk0dzhJUGNiK2lC?=
 =?utf-8?B?R1dwK1JOMlo1SU9TK0tQRFZjd1o4TDFnRHNBMEJjYUNmamxaTk4ybTZuSWs0?=
 =?utf-8?B?ZitTYkNXM2lIa0tvSnRrL1dBK1BBcnR5WHFWR3hmV3FCTjF1TS8yS1FXa2hS?=
 =?utf-8?B?YWRxaUl5Y29BcTJSWWVDYkRLRWlLVFF0NWxsSGRaNjlLQ3JOTjl0RVBSMThT?=
 =?utf-8?B?RlkrbVlYOTk5NVR3K0gxL0pwQ3pQV2w5VGtGdEIvMzkxS3dyem4vWkx6UWo2?=
 =?utf-8?B?R2pQVmxYd0NVYW9KdTR2WDFIVVpLYVpNc0hBSzA1aWE3d29ONktqQ0RZbGxY?=
 =?utf-8?B?bmRDT25oaFhvb2J5Qm5BV3dCYkVZMmxKNjM0UGU0MVoxckhTZ2JuRFIxbGRp?=
 =?utf-8?B?SzNib0cwZWszZUIwWEpHekFieGp5V2xMUkNDQ3FnUTZQOVR0cXBHVjVxdjhY?=
 =?utf-8?B?UWJxWWNQbE8yOGJmbndlUUJzYkJNZEtSRmgrdE5icVcvVXZPM0V1aUc0OTR3?=
 =?utf-8?B?WTM0MnNqNmZCN21UdmlNKzg1MkVjZkhNUU85RTF3Tm4zUXFNN0oxT1ROTGNK?=
 =?utf-8?Q?hE0NHwMupS+9mM2IDBNpkdHPBwwf76xenUGLOv9Zi+PTe?=
X-MS-Exchange-AntiSpam-MessageData-1: gwyBTJecexA2+Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f74e4cf-2490-4cc8-c45f-08df2b286120
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 01:54:13.9345 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i0s/7GU6iPpcQX9YmSxX2R3HVo9bS7e50XeN8iRh9UbS3oNuDs0Zsxhz8sLYgpsOtFXHW/qfdyhJe91sJshCNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999230
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

Add a fixed capacity vector backed by [MaybeUninit<T>; N]. The ArrayVec
is also initializable with a closure, returning an Init instance, to
avoid constructing it on the stack. ArrayVec is useful for small but
varying size arrays stored on the stack, to avoid a heap allocation, or,
for larger varying size arrays initialized into caller provided memory
but not wanting to provide an allocator.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/alloc.rs             |   3 +
 rust/kernel/alloc/arrayvec.rs    | 338 +++++++++++++++++++++++++++++++++++++++
 rust/kernel/alloc/kvec.rs        |   1 +
 rust/kernel/alloc/kvec/errors.rs |   2 +-
 4 files changed, 343 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 21067bde6860..510e2c7f9f72 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -3,10 +3,13 @@
 //! Implementation of the kernel's memory allocation infrastructure.
 
 pub mod allocator;
+pub mod arrayvec;
 pub mod kbox;
 pub mod kvec;
 pub mod layout;
 
+pub use self::arrayvec::ArrayVec;
+
 pub use self::kbox::Box;
 pub use self::kbox::KBox;
 pub use self::kbox::KVBox;
diff --git a/rust/kernel/alloc/arrayvec.rs b/rust/kernel/alloc/arrayvec.rs
new file mode 100644
index 000000000000..8793adf4d27b
--- /dev/null
+++ b/rust/kernel/alloc/arrayvec.rs
@@ -0,0 +1,338 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Implementation of [`ArrayVec`].
+
+use crate::{
+    alloc::kvec::{
+        impl_slice_eq,
+        PushError, //
+    },
+    const_assert,
+    error::{
+        code::EINVAL,
+        Error,
+        Result, //
+    },
+    fmt, //
+};
+
+use core::{
+    borrow::{
+        Borrow,
+        BorrowMut, //
+    },
+    mem::MaybeUninit,
+    ops::{
+        Deref,
+        DerefMut, //
+    },
+    ptr,
+    slice, //
+};
+
+use pin_init::{
+    init_from_closure,
+    Init,
+    Zeroable, //
+};
+
+/// A fixed capacity vector that holds at most `N` elements.
+///
+/// # Invariants
+///
+/// - `len` is at most `N`.
+/// - The first `len` elements of `data` are initialized.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::alloc::ArrayVec;
+///
+/// let mut v = ArrayVec::<u8, 4>::new();
+/// v.extend_from_slice(b"abc")?;
+/// assert_eq!(*v, *b"abc");
+///
+/// assert!(v.extend_from_slice(b"ab").is_err());
+///
+/// v.push(4u8)?;
+/// assert_eq!(*v, *b"abc\x04");
+/// assert!(v.push(5u8).is_err());
+///
+/// v.clear();
+/// assert!(v.is_empty());
+/// # Ok::<(), Error>(())
+/// ```
+#[derive(Zeroable)]
+pub struct ArrayVec<T, const N: usize> {
+    data: [MaybeUninit<T>; N],
+    len: usize,
+}
+
+/// The maximum size in bytes of an [`ArrayVec`] returned by value from [`ArrayVec::new`].
+const MAX_STACK_SIZE: usize = 512;
+
+impl<T, const N: usize> ArrayVec<T, N> {
+    /// Creates an empty [`ArrayVec`].
+    #[inline]
+    pub const fn new() -> Self {
+        const_assert!(
+            size_of::<Self>() <= MAX_STACK_SIZE,
+            "use `init_with` instead of constructing a large ArrayVec on the stack"
+        );
+
+        // INVARIANT: An empty ArrayVec trivially has all its elements initialized.
+        Self {
+            data: [const { MaybeUninit::uninit() }; N],
+            len: 0,
+        }
+    }
+
+    /// Creates an initializer for an [`ArrayVec`] populated by `f`.
+    ///
+    /// `f` gets an empty [`ArrayVec`] and can fill it in place.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::alloc::ArrayVec;
+    ///
+    /// let v = KBox::init(
+    ///     ArrayVec::<u8, 4096>::init_with(|v| v.extend_from_slice(b"abc")),
+    ///     GFP_KERNEL,
+    /// )?;
+    /// assert_eq!(**v, *b"abc");
+    /// # Ok::<(), Error>(())
+    /// ```
+    #[inline]
+    pub fn init_with<E>(f: impl FnOnce(&mut Self) -> Result<(), E>) -> impl Init<Self, E> {
+        let init_empty = |slot: *mut Self| {
+            // SAFETY: By the initializer contract `slot` is valid for writes. Once `len` is zero
+            // the slot holds a valid empty ArrayVec, since `data` requires no initialization.
+            // INVARIANT: An empty ArrayVec trivially has all its elements initialized.
+            unsafe { (&raw mut (*slot).len).write(0) };
+            Ok(())
+        };
+
+        // SAFETY: `init_empty` fully initializes the slot and never fails.
+        unsafe { init_from_closure(init_empty) }.chain(f)
+    }
+
+    /// Appends an element to the back of the [`ArrayVec`].
+    ///
+    /// Fails when the [`ArrayVec`] is full, handing the element back in [`PushError`].
+    #[inline]
+    pub fn push(&mut self, v: T) -> Result<(), PushError<T>> {
+        self.try_push_init(v)
+            .map_err(|TryPushInitError::Full(v)| PushError(v))
+    }
+
+    /// Appends an element to the back of the [`ArrayVec`] by initializing it in place.
+    ///
+    /// Fails when the [`ArrayVec`] is full, handing the initializer back in [`PushError`].
+    #[inline]
+    pub fn push_init<I: Init<T>>(&mut self, init: I) -> Result<(), PushError<I>> {
+        self.try_push_init(init)
+            .map_err(|TryPushInitError::Full(init)| PushError(init))
+    }
+
+    /// Appends an element to the back of the [`ArrayVec`] by initializing it in place.
+    ///
+    /// Unlike [`ArrayVec::push_init`], the initializer may be fallible. If the [`ArrayVec`] is
+    /// full, the original initializer `init` is handed back in [`TryPushInitError::Full`]. If the
+    /// initializer itself fails, its error is returned in [`TryPushInitError::InitError`].
+    pub fn try_push_init<I, E>(&mut self, init: I) -> Result<(), TryPushInitError<I, E>>
+    where
+        I: Init<T, E>,
+    {
+        let Some(slot) = self.spare_capacity_mut().first_mut() else {
+            return Err(TryPushInitError::Full(init));
+        };
+
+        // SAFETY:
+        // - `slot.as_mut_ptr()` points to a spare slot, which is valid, uninitialized memory.
+        // - If `raw_try_init` fails, this returns without increasing `len` or touching `slot`.
+        // - `init` implements `Init<T, E>`, which removes the pinning requirement.
+        unsafe { pin_init::raw_try_init(slot.as_mut_ptr(), init) }
+            .map_err(TryPushInitError::InitError)?;
+
+        // INVARIANT: The element at index `len` was just initialized, and the new `len` does not
+        // exceed `N` because a spare slot existed.
+        self.len += 1;
+
+        Ok(())
+    }
+
+    /// Appends a clone of each element in `slice` to the back of the [`ArrayVec`].
+    ///
+    /// Fails with [`EINVAL`] if `slice` is longer than the remaining capacity.
+    pub fn extend_from_slice(&mut self, slice: &[T]) -> Result
+    where
+        T: Clone,
+    {
+        let Some(dst) = self.spare_capacity_mut().get_mut(..slice.len()) else {
+            return Err(EINVAL);
+        };
+
+        for (d, s) in dst.iter_mut().zip(slice) {
+            d.write(s.clone());
+        }
+        // INVARIANT: The next `slice.len()` elements after `len` were just initialized, and the
+        // new `len` does not exceed `N` because the spare capacity was enough.
+        self.len += slice.len();
+
+        Ok(())
+    }
+
+    /// Removes all elements.
+    #[inline]
+    pub fn clear(&mut self) {
+        let elems: *mut [T] = self.as_mut_slice();
+        // INVARIANT: An empty ArrayVec trivially has all its elements initialized.
+        self.len = 0;
+        // SAFETY: There are no references to the elements since we hold `&mut self`. The elements
+        // can't be dropped again because `len` is already 0.
+        unsafe { ptr::drop_in_place(elems) };
+    }
+
+    /// Returns the initialized elements as a slice.
+    #[inline]
+    pub fn as_slice(&self) -> &[T] {
+        let ptr = self.data.as_ptr().cast::<T>();
+        // SAFETY: `MaybeUninit<T>` has the same layout as `T`, and by the type invariants the first
+        // `len` elements of `data` are initialized.
+        unsafe { slice::from_raw_parts(ptr, self.len) }
+    }
+
+    /// Returns the initialized elements as a mutable slice.
+    #[inline]
+    pub fn as_mut_slice(&mut self) -> &mut [T] {
+        let ptr = self.data.as_mut_ptr().cast::<T>();
+        // SAFETY: `MaybeUninit<T>` has the same layout as `T`, and by the type invariants the first
+        // `len` elements of `data` are initialized.
+        unsafe { slice::from_raw_parts_mut(ptr, self.len) }
+    }
+
+    /// Returns a slice of `MaybeUninit<T>` for the remaining spare capacity of the [`ArrayVec`].
+    #[inline]
+    fn spare_capacity_mut(&mut self) -> &mut [MaybeUninit<T>] {
+        // PANIC: `len` never exceeds `N` by the type invariants.
+        &mut self.data[self.len..]
+    }
+}
+
+/// Error type for [`ArrayVec::try_push_init`].
+pub enum TryPushInitError<I, E> {
+    /// The [`ArrayVec`] is full. Hand the initializer back.
+    Full(I),
+    /// The initializer failed.
+    InitError(E),
+}
+
+impl<I, E> fmt::Debug for TryPushInitError<I, E> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        match self {
+            TryPushInitError::Full(_) => write!(f, "Not enough capacity"),
+            TryPushInitError::InitError(_) => write!(f, "Initializer failed"),
+        }
+    }
+}
+
+impl<I, E> From<TryPushInitError<I, E>> for Error
+where
+    Error: From<E>,
+{
+    #[inline]
+    fn from(e: TryPushInitError<I, E>) -> Error {
+        match e {
+            TryPushInitError::Full(_) => EINVAL,
+            TryPushInitError::InitError(e) => Error::from(e),
+        }
+    }
+}
+
+impl<T, const N: usize> Default for ArrayVec<T, N> {
+    #[inline]
+    fn default() -> Self {
+        Self::new()
+    }
+}
+
+impl<T, const N: usize> Drop for ArrayVec<T, N> {
+    #[inline]
+    fn drop(&mut self) {
+        // SAFETY: The slice holds initialized elements that are never accessed again after this
+        // point.
+        unsafe { ptr::drop_in_place(self.as_mut_slice()) };
+    }
+}
+
+impl<T, const N: usize> Deref for ArrayVec<T, N> {
+    type Target = [T];
+
+    #[inline]
+    fn deref(&self) -> &Self::Target {
+        self.as_slice()
+    }
+}
+
+impl<T, const N: usize> DerefMut for ArrayVec<T, N> {
+    #[inline]
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        self.as_mut_slice()
+    }
+}
+
+impl<T, const N: usize> Borrow<[T]> for ArrayVec<T, N> {
+    #[inline]
+    fn borrow(&self) -> &[T] {
+        self.as_slice()
+    }
+}
+
+impl<T, const N: usize> BorrowMut<[T]> for ArrayVec<T, N> {
+    #[inline]
+    fn borrow_mut(&mut self) -> &mut [T] {
+        self.as_mut_slice()
+    }
+}
+
+impl<T: Eq, const N: usize> Eq for ArrayVec<T, N> {}
+
+impl_slice_eq! {
+    [const N: usize, const M: usize] ArrayVec<T, N>, ArrayVec<U, M>,
+    [const N: usize] ArrayVec<T, N>, &[U],
+    [const N: usize] ArrayVec<T, N>, &mut [U],
+    [const N: usize] &[T], ArrayVec<U, N>,
+    [const N: usize] &mut [T], ArrayVec<U, N>,
+    [const N: usize] ArrayVec<T, N>, [U],
+    [const N: usize] [T], ArrayVec<U, N>,
+    [const N: usize, const M: usize] ArrayVec<T, N>, [U; M],
+    [const N: usize, const M: usize] ArrayVec<T, N>, &[U; M],
+}
+
+impl<'a, T, const N: usize> IntoIterator for &'a ArrayVec<T, N> {
+    type Item = &'a T;
+    type IntoIter = slice::Iter<'a, T>;
+
+    #[inline]
+    fn into_iter(self) -> Self::IntoIter {
+        self.iter()
+    }
+}
+
+impl<'a, T, const N: usize> IntoIterator for &'a mut ArrayVec<T, N> {
+    type Item = &'a mut T;
+    type IntoIter = slice::IterMut<'a, T>;
+
+    #[inline]
+    fn into_iter(self) -> Self::IntoIter {
+        self.iter_mut()
+    }
+}
+
+impl<T: fmt::Debug, const N: usize> fmt::Debug for ArrayVec<T, N> {
+    #[inline]
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        fmt::Debug::fmt(self.as_slice(), f)
+    }
+}
diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index c8b312f64657..cd0c57a9ad90 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -1255,6 +1255,7 @@ fn eq(&self, other: &$rhs) -> bool { self[..] == other[..] }
         )*
     }
 }
+pub(super) use impl_slice_eq;
 
 impl_slice_eq! {
     [A1: Allocator, A2: Allocator] Vec<T, A1>, Vec<U, A2>,
diff --git a/rust/kernel/alloc/kvec/errors.rs b/rust/kernel/alloc/kvec/errors.rs
index d24dfe22834a..f5c44fdc7016 100644
--- a/rust/kernel/alloc/kvec/errors.rs
+++ b/rust/kernel/alloc/kvec/errors.rs
@@ -7,7 +7,7 @@
     prelude::*, //
 };
 
-/// Error type for [`Vec::push_within_capacity`].
+/// Error type for a push that fails because there is no spare capacity.
 pub struct PushError<T>(pub T);
 
 impl<T> fmt::Debug for PushError<T> {

-- 
2.56.0

