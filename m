Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4314C61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:23:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4044D10F095;
	Thu, 27 Aug 2026 14:23:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="b4DTNmya";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012044.outbound.protection.outlook.com
 [40.93.195.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B63B710F091
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 14:23:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WlyatsuG5w6CYO95uD0oD+438ueNBUwHeHxDqbIvkR808hWNzZbT5Cz4l6MzsFI2HJCXwjGTtOyvDmVuC3Uf4RfnBop1qbk5jZaK/wMM82mTka3Ov6UIOiz9AE7vLOy4wyZsr2szhmeXWq39F6vukQVt4MGwE77wAiaGoCFAIsZXo64v/TeCU6tzv5Hbhyih+ZgCBS0+jeqI7nDugdRp9HTxTFPb795Yd7BsQhW+P8fRtPutNgaw5aCRZHeCIMdjIF2pGGMB40Rh412NVhswSN5OtfzeJC2uFNYIQSy254UJDxreSKLIApO1xkhBe+WT1bTUC81L8DocHfmO7FRfuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZWIhiqRlTfy1/ciYCOxsocVyXiamOvOQVMuuIn0cB4=;
 b=ysHDScaQfW+au+/qc2p1xpunWKDhGs6JVgKZX3+EL8bMHZmZBLpQWynV/XKA1DnSJWmnWEnkAYMRvUM7mKDDN/VH8jSNP/hPYgBwpj1Wu/Ie8Eq7yDLcMi0aP6WXb7xmQj532jGpvajiYOLDu6kru1Bz7I0k9a8YI5/KKqYupLsmuQO7xEDg+CLZmMbKbAyhip4fzXqhVvFRJtYAGsdtz6sD+2ky7+YGnm1zZea9Wr/8emjvQ+HpZXEoFys2CsN0XYlf0+AKHrMuLqDbbQvzq2Qd2Dmv/ozvsZXANHrrt8NW+8Iz8oeDVLiZH8NQKjMqy1tmJfmirs6Q9EWTYMpyAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZWIhiqRlTfy1/ciYCOxsocVyXiamOvOQVMuuIn0cB4=;
 b=b4DTNmya9B54GrF26rjkwE/UE4WuvpHuLUbmT3aG4eFTlA3Jjzx22bcJduxcAy+OWYZ/MGuBLSYjb5gFcMvTafw6sVzhvvGt6gkqhbbZcYgKUMDoi+K2FyVADUhEiciu6/CP6PoX4LZ9uhvmRl62xQzj9hixtN5BC9CtzctPFLXfIQyN06oVOtLq6/dcJ9hIMVP53ccEozUzaCwCJLlDCwUXbi8okr/JK5EF3kpdiFV967raS5xtmeTAgrV7rLUsQAwbEE01VhwthO3/58lZZlVi06DdlkRiwupfaTjJEN5MAeR6pFK575SwIRyGx0VKBKXJ3Fc7GNGjoocIHrutxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 LVUPR12MB999161.namprd12.prod.outlook.com (2603:10b6:408:3a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 14:22:58 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 14:22:58 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 27 Aug 2026 23:12:52 +0900
Subject: [PATCH v2 3/8] rust: alloc: add ArrayVec
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-b4-nvkv-v2-3-0de9d5c8658c@nvidia.com>
References: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
In-Reply-To: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
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
X-ClientProxiedBy: TY4P301CA0018.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::16) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|LVUPR12MB999161:EE_
X-MS-Office365-Filtering-Correlation-Id: 07e11613-3a36-4b25-3c0c-08df0446b1a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|366016|376014|7416014|1800799024|10067099003|6133799003|22082099003|18002099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info: /2oYsVMeWOtLNbN/J2mQEmSRT6hUI7P5m9ss5uEqVEYdgtxuRj0OwpNObc4UjPqTERuan70aWpBfTynXEOvaoh4bifZSuPw/bcorQkyl6nvktqWoiCOcdwl23/zKSyp369/I/NE6CPuL7droFQoXrz0PDF05vBUXQVTX4Y7yAB7/ch5ewRp2JCO8KnVfrgb/w0B5yuZRko9Q9aEmyCrTFWqk22OKtG/nLRRbSDGGPBjeoQciAnKvfecq/bnQz0XXFBy+pvxNDi+sL4Qaa3Ky0uRe8lEinCu/BQ/cigd6izvKmLLiCoUbOjWV/n0keOIDIoKmYlUH0v9/s16wJTv7VpCpk9z8N1Tx77we6IdmOxe5GplCNgED0s3U6Cu1i9wSrc8oUOnxH4VaI+7JehFQ0mFnGZ45Hp2lQJzIsB46aXdOuOid3uj77j0J8MnKU0al8+7vK5kzYbDbZWcumE44xVgKyWMNWYpbe7lGyPX1JyEYiypvhSd0Ssbnlsf6ZQxXpf9AjQtgP2Wm3ahy0ew/xtfVZH2p3pIWZktIUscfzv/SeGIV9a0S9P2Pw1xJMczMjlxk1/KjKun0ntiWXjMPcEhr1C8rwa6BnsOrn6+xv5YrU1zWOIWyC/S6F+xTKg6xRe/oC+o0Z4GAurUdyBkzb3WvkJSKVl+elnRcUS6VWb1Cd37soHWS2EbXojW/mHGxP6GlsT4aWYH2HDhx2chcDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(366016)(376014)(7416014)(1800799024)(10067099003)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2lZOTB4ZGQvMHZqb3BaZ0RQbVFoMkNUeTlGV2dtemdhL0VTRS9OTGhmWHps?=
 =?utf-8?B?REVqNEk5aVFZS3V5N1I2cUgwcHp4UlB1R1krSWlkZHRZektEMmlrREsxRkxO?=
 =?utf-8?B?TFA0VHBITEJCVlRFd0lXN1JHa0hQU05qcVRGMXF4QmlHSVZNVzdqVURYeU9r?=
 =?utf-8?B?Rys4a0l6UVNYbDZOOEJETkhDT29JOC9DNDZaQ2sxYWk0dXRpQ0ljZXU2YjRl?=
 =?utf-8?B?ZkRJUlVVVnNGcFFmZjd2SWk5ZDNwVytWODZ3aXJaR3ZuUlZCVUw5VXh3Rmlj?=
 =?utf-8?B?bGRFcXNwY1Z2N3haSkxmaXJZUHBZZzJwU3JhRG1lT1RLMGRLY09Fc1VwUXMx?=
 =?utf-8?B?eDdOcFNUaWFtdklVdk1BZ3Q0NDB2KzlPWjduVHNlclBJU09uRC9kc01xTlha?=
 =?utf-8?B?SjNqL0NOUjNSV0ZUMjV6YUIxZElYRXdrbnBPbGVmbys3RVhsKzZ6d3FYUVZ2?=
 =?utf-8?B?UEVoZzNCUnpwcGZ5ZFAvaUcyRHJsZmYvNnU4a1ZrWnVMTU0yTGswOEM5eXIr?=
 =?utf-8?B?YkFNVlAyQ2grZk5KOVVHWm4raXBHOUg0OVR3ZS9UZm9ybXFxWGlUZm1OT3Ji?=
 =?utf-8?B?aURNMXYwZ1p0SHJtSW9HQ1NyVDd1MGZzWXI4ekFKMG0wdDJLaGg1S0ZsTk9t?=
 =?utf-8?B?Tm5TUWpyZlJ1YTJra3NXdlNpQWtRT1V0WjBRaEtsazFYcHBlZWhEeWdGL3Vl?=
 =?utf-8?B?eEcwSHZ0M2gxQnRnL1ROYVVqKy8zMnhpT1MrR2QxYWZhOTJLKzlFamVRL3FQ?=
 =?utf-8?B?M1dWSm9IT29UQ0c3NVZuU2xCYm52UTlFQTF5TnErRGlXM1MrMjNXdHErQWR1?=
 =?utf-8?B?OVdqVFM3V1lLSUdjTnFzL1hxN1FhOWhaeEFib0x4dzNEdlYxRnliQnoxNm01?=
 =?utf-8?B?dHNFZmpnRUlWb0drVzJDR0hrY0dKWjJ2TXp0b3diWHZGTGtQRVB5b083cHFO?=
 =?utf-8?B?eVNhT0ZHdVMwRDl2L3k2RXBrbStYaG9Vb3RRZDF3cVJXY2lJZUZTUlNsL21s?=
 =?utf-8?B?eUt5enBGY3llcE1NUy9zZCtGV3VFZFBVSHFSNTJNM3F5YUc1QVZFb2E4czFV?=
 =?utf-8?B?ZmJmRnUyWkNnejZBZmtRcVo3cTQwSnpUTjhqaUY4MStXMzR6TGt3UUI3azZy?=
 =?utf-8?B?RkdueUNjOFVYZ1pKRUtBV3FObUEwVDNlU0l6cThjQ3FwL1VkUkJ1VVd3V25w?=
 =?utf-8?B?VmVidXNqdWxJNnFLZzBtRWF1ak44UWdLQm5udll5dEMweVA1Rml4Q3h6STBl?=
 =?utf-8?B?aW5WTURRWHo5aVhJRlZ5YXpLN09GRW9RSXhPU01Ba3VFSkZiU0RZYnhhclJX?=
 =?utf-8?B?S3cvWHQwVC9yTWJObW5BTzZ0MFJGVEVDNVlJeWZkaXFjZlRSdGRQYnppd0Ez?=
 =?utf-8?B?MWQxTitNdGJBaXh2V2JaQkNubWVXTC9GeEU2dUYxY3BYSGtRbHpQcXlId1VS?=
 =?utf-8?B?d01EcE0vdkZpNmxZNHkxdW9wQVc3ZnlHZ3NiZVFCNzhxMnF3c3FOZC9kSzF3?=
 =?utf-8?B?UGpsY09uTENrUCtnWHB6MFpDdWV5OUFYeStadlhlZFk3MjdIQWI5eTh6WC82?=
 =?utf-8?B?RGdkdFllL0tEd0tqdTI3aWlHYmcvTkNYTkJYZWdvWk0xRGN4eHFtaThlcklZ?=
 =?utf-8?B?bnZKM29vYmg4V3JvL1hyQi9oTEpFUUJRT3lpRS9ZeTJCN2xuSW9weXJINERC?=
 =?utf-8?B?VGRNdUpUbERMTzZvK1lMaHdFV0FjU2gzY3UycVpHWGFIT1pVWTVFVHdXeGdJ?=
 =?utf-8?B?Rit3d0hWVWhBNHM1eTU2UTJwVnhjWFJoaGhOUnVrbXFBTmVyY3Zob01VNU9L?=
 =?utf-8?B?M1h3anZkK3NTb0p0OHF1R3orRXJ6QjJTSVNyU3NiTXlwbDF0bE8rcFZKTFVR?=
 =?utf-8?B?aFpmZlFEKy9vUHBwdjhJakdCeDRLbE9ZdEFZV3BXYUptdkFNRVVZdDV6NXM5?=
 =?utf-8?B?aVpCeHdwU0N5MDZqR1orZS9YeVlLT2lRS1FORHFxSlA5ak9oUU1rVzFUVWY3?=
 =?utf-8?B?MytUYkpkZWwrV083bzJtVTF5Wjdocm91NlRKNDdKdURBcDU1RnM0OUtLZFVi?=
 =?utf-8?B?T3BMSzhCUFVKNUtiOVh3TzVYTjNjZVNhcjVoLy95aGxkRmlleTJyYXROYnhq?=
 =?utf-8?B?R0UvR05jdEdHZWZOWHM4cjNiM3dQaXp0VWxibEFJWkliVTlHQlBQZVp1SzVm?=
 =?utf-8?B?QXpYT2RIZnhoYjNzam9tOUtoRS9Bak5uK25EK3UycVFyT2hORXc5czFyRDRz?=
 =?utf-8?B?eFRER09GNkpHcTIwZjFLYnVlODVZNjhhRi9QVStRbG92SkEvZXVVS1BUSzBp?=
 =?utf-8?B?WlZtYk9JS3NxWDkxekRXTit6OVR1UUx0OWROTWZoUG91cHFWY05QUlgyN0xv?=
 =?utf-8?Q?mcTSZ0v8Tfz36sHLS9KS56cEHaqPkFGptkmvYiTpYtAo8?=
X-MS-Exchange-AntiSpam-MessageData-1: wfo2bXQOn02Waw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e11613-3a36-4b25-3c0c-08df0446b1a0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 14:22:58.6279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TO5QZub7C8p8rCBb3qHrIDQ0CY/n3lw8BHhGbUb60JPMm21tgmungEEE2QTyMkK9H8I+B0J9wo/LbnHejrxnfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999161
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
 rust/kernel/alloc.rs          |   3 +
 rust/kernel/alloc/arrayvec.rs | 347 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 350 insertions(+)

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
index 000000000000..4172a982e477
--- /dev/null
+++ b/rust/kernel/alloc/arrayvec.rs
@@ -0,0 +1,347 @@
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
+impl<T, const N: usize> ArrayVec<T, N> {
+    /// Creates an empty [`ArrayVec`].
+    #[inline]
+    pub const fn new() -> Self {
+        // Clippy triggers this even if the enclosing function is never called, so skip if clippy is
+        // on.
+        const_assert!(
+            cfg!(clippy) || size_of::<Self>() <= 512,
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
+    pub fn init_with<E>(f: impl FnOnce(&mut Self) -> Result<(), E>) -> impl Init<Self, E> {
+        let init = move |slot: *mut Self| {
+            // SAFETY: By the initializer contract `slot` is valid for writes. Once `len` is zero
+            // the slot holds a valid empty ArrayVec, since `data` requires no initialization.
+            // INVARIANT: An empty ArrayVec trivially has all its elements initialized.
+            unsafe { ptr::addr_of_mut!((*slot).len).write(0) };
+
+            // SAFETY: `slot` holds a valid ArrayVec and no other reference to it exists.
+            let v = unsafe { &mut *slot };
+            f(v).inspect_err(|_| {
+                // SAFETY: `slot` holds a valid ArrayVec, and on failure the slot is never accessed
+                // again, so the elements can't be dropped twice.
+                unsafe { ptr::drop_in_place(slot) }
+            })
+        };
+
+        // SAFETY: `init` fully initializes the slot on success and drops the potentially filled
+        // ArrayVec on failure.
+        unsafe { init_from_closure(init) }
+    }
+
+    /// Appends an element to the back of the [`ArrayVec`].
+    ///
+    /// Fails when the [`ArrayVec`] is full, handing the element back in [`PushError`].
+    pub fn push(&mut self, v: T) -> Result<(), PushError<T>> {
+        self.try_push_init(v)
+            .map_err(|PushInitError::Full(v)| PushError(v))
+    }
+
+    /// Appends an element to the back of the [`ArrayVec`] by initializing it in place.
+    ///
+    /// Fails with [`FullError`] when the [`ArrayVec`] is full.
+    pub fn push_init(&mut self, init: impl Init<T>) -> Result<(), FullError> {
+        self.try_push_init(init)
+            .map_err(|PushInitError::Full(_)| FullError)
+    }
+
+    /// Appends an element to the back of the [`ArrayVec`] by initializing it in place.
+    ///
+    /// Unlike [`ArrayVec::push_init`], the initializer may be fallible. If the [`ArrayVec`] is
+    /// full, the original initializer `init` is handed back in [`PushInitError::Full`]. If the
+    /// initializer itself fails, its error is returned in [`PushInitError::InitError`].
+    pub fn try_push_init<I, E>(&mut self, init: I) -> Result<(), PushInitError<I, E>>
+    where
+        I: Init<T, E>,
+    {
+        let Some(slot) = self.spare_capacity_mut().first_mut() else {
+            return Err(PushInitError::Full(init));
+        };
+
+        // SAFETY: `slot` refers to allocated, aligned memory valid for a write of one `T`.
+        unsafe { init.__init(slot.as_mut_ptr()) }.map_err(PushInitError::InitError)?;
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
+    fn spare_capacity_mut(&mut self) -> &mut [MaybeUninit<T>] {
+        // PANIC: `len` never exceeds `N` by the type invariants.
+        &mut self.data[self.len..]
+    }
+}
+
+/// Error type for [`ArrayVec::try_push_init`].
+pub enum PushInitError<I, E> {
+    /// The [`ArrayVec`] is full. Hand the initializer back.
+    Full(I),
+    /// The initializer failed.
+    InitError(E),
+}
+
+impl<I, E> fmt::Debug for PushInitError<I, E> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        match self {
+            PushInitError::Full(_) => write!(f, "Not enough capacity"),
+            PushInitError::InitError(_) => write!(f, "Initializer failed"),
+        }
+    }
+}
+
+impl<I, E> From<PushInitError<I, E>> for Error
+where
+    Error: From<E>,
+{
+    #[inline]
+    fn from(e: PushInitError<I, E>) -> Error {
+        match e {
+            PushInitError::Full(_) => EINVAL,
+            PushInitError::InitError(e) => Error::from(e),
+        }
+    }
+}
+
+/// Error type for [`ArrayVec::push_init`].
+pub struct FullError;
+
+impl fmt::Debug for FullError {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        write!(f, "Not enough capacity")
+    }
+}
+
+impl From<FullError> for Error {
+    #[inline]
+    fn from(_: FullError) -> Error {
+        EINVAL
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
+    fn borrow(&self) -> &[T] {
+        self.as_slice()
+    }
+}
+
+impl<T, const N: usize> BorrowMut<[T]> for ArrayVec<T, N> {
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
+    fn into_iter(self) -> Self::IntoIter {
+        self.iter()
+    }
+}
+
+impl<'a, T, const N: usize> IntoIterator for &'a mut ArrayVec<T, N> {
+    type Item = &'a mut T;
+    type IntoIter = slice::IterMut<'a, T>;
+
+    fn into_iter(self) -> Self::IntoIter {
+        self.iter_mut()
+    }
+}
+
+impl<T: fmt::Debug, const N: usize> fmt::Debug for ArrayVec<T, N> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        fmt::Debug::fmt(self.as_slice(), f)
+    }
+}

-- 
2.55.0

