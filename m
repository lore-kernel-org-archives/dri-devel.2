Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45075C9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:44:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04FFA10E8B8;
	Mon, 28 Sep 2026 08:43:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="g1+1An0r";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011023.outbound.protection.outlook.com [52.101.57.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3959210E860
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 08:43:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUKgFKS2vDR7AinY+nCqHKqS2+xDfJmbysV1FA6zHO6KeO0Ewxlb6wRyZICO2LvqEDMSY2oMOsvQu8P53ouAmjkQskeJSGYrivburBIIGcTd4avODbj13b34bmE3uoDa+7pLz98qZE2jAmSh1kQ4yH+RNgQh7m+Vdsp+3QIMGIMpRnnABQoNfKULlYdJoC+06Kar0ZyrAAsAWVt0ryWGfTEvOR9VqyLesQ8IiUqErok8okHXBW7kAYGBAdB49l8Img+2N3UGXGMbuNt0xKeDgVxpy8L4n+c1HcHgteVmgGwa8mugb4CyqET7CZY3gA6YBBH8LmSmZo/6l7fRCW2zpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6Zctiz8euiDNmZkseoLVILEwvuTTChwgaa+QYb6TRA=;
 b=wQlDLfbPo1GMYeG1gK6ELI13rRafOJTHWWZgL6yuOlkzU8caaOpikBnY3k9wOP2mWjM7J+dzua0sEiF9Mr8Mhes2QevFlg6bwhsitTq8nQRWQvocd0jHcuTHEvpkazCkGyZ7vfFtQJlaTFHWBFIcF5+Jq8C5FjHWKGmYI/FNmvfqY7rrMJCXEbxLFhvR+w7E2Pw5/Pe8GTUwfB9JdiKdzQmo2BGil1nW8wA6XhofTnUAx4Rp4VdqqJmadmMAj+8KBqhj4qexOxL/5mthuJuU++m2qx3uY/SG9XDp9f7ImYw9tgJWRVTGZQbEi85Za9Jg7qQ4jfPGODt70k1SYtgjRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6Zctiz8euiDNmZkseoLVILEwvuTTChwgaa+QYb6TRA=;
 b=g1+1An0rGudA9HlC7Csi5sz9UVaYOdqXIMIjVrPJ+a0fqh3o/ziTLAe590KlBzS1Y1M2ydRmgA99DGHjd5osTuWdrthGsWdaWbfKSJ208G/kiV1w9wfX7m5ChOn2I8Mm5dgLsxy3w9Atyvi9Gy3xuiB/gjXCddvSpdPoFrYU6e0XP4u7AXkeWtC+dBAPwAfikLFPYxbL56eGm4I2S5RuyiclcoZT6BIiKL8Oa9AEn4N9EuwjC76wjYK1U4RZ/fanAqsb+tuV4BpXrTjy8yLK6iAQ1Z60JdymvOFJlUFUVqHTCSYiM+MxaYQMzJFKiQ8Rh2JYJ/HGmmTAT3Zzb6St/w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 CY8PR12MB8065.namprd12.prod.outlook.com (2603:10b6:930:73::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.24; Mon, 28 Sep 2026 08:43:09 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 08:43:09 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 28 Sep 2026 17:42:42 +0900
Subject: [PATCH v3 3/8] rust: alloc: add ArrayVec
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-b4-nvkv-v3-3-f04504c262c2@nvidia.com>
References: <20260928-b4-nvkv-v3-0-f04504c262c2@nvidia.com>
In-Reply-To: <20260928-b4-nvkv-v3-0-f04504c262c2@nvidia.com>
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
X-ClientProxiedBy: TYCPR01CA0187.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::8) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|CY8PR12MB8065:EE_
X-MS-Office365-Filtering-Correlation-Id: 97dc680a-ced9-4b71-04d7-08df1d3c85fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|7416014|376014|1800799024|366016|10067099003|56012099006|11063799006|921020|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: xXootskZ6eSFSXD72BE2WmiaEY9NKqg1ROdkDaY4EY6rCFvszgezRzevMJfjatE5GX5VxMmdAW5siUvzxUzpjCxkfWyNAfjQX3ZW3dcFo6BlOYv4iEvvgbFSpLpW+xAoSl0qqadGNa4FliTkhRR48z3pqTLpgpn5yKD89USmMrCKTp1ILww2wFnkZMeELSBuF+Nd4RAT70syBM1g9YI/+uxUQLgI9sazWUrVX0jfe17+U9JHlxxZ+rqW8MuCa3w9CK7NfxD+Q+BCR97Ad6KvhSqfnIr/J35Vtd7fDV20bFGvU6GIdXSTWzPqKKeFPqo1gV4WBxFQ66YuNa+Vb116WQehCzWiR6lNNoxjmm5HODy6VkdcQo/BB+VfdLxohLOZukek+koRpyZUmYfWbmL7MPqolXVSJzKCAzPeVvKh0sHPC8lHK4RPiFD05wQTvERBB8NDoCLcRbhHywVjEItkwTy162wIZGnzAA8MQF20rVILKVzxQUuoPjqZgbqP9w9Zif3tEPj4EsRBHH5mHoqC35I6I09e3/fgqJiycRoOgj9y1GYhwXD7DjgxwuQrs0TeGLoLCzXqmJj8vfAGZDv6kuB+YQ3mpaOH8LRZB3ocfb9JbQi2DR3dyVKiNNV5PHuapfQJe46LesfmMC+dVyohKcru1JVEMCllLZpk2NgeTXieWwNBq1JEQ9F+c8KSw9Z/w3mAdn/fy1hLhCH4gMcTQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(7416014)(376014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(921020)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2NZRUZLK1ZPRWIzdjhlMDJtR2s1TkZmVDdab3ZDWXl6bEZra3FLWVRqRlBq?=
 =?utf-8?B?UEQ1b0t6cjZ5MW96NjgzV1lpSTFXdzV6eFJwWUtDa0tTc3lOeFMwVDROblV2?=
 =?utf-8?B?MVZXNmI5UTQ2UDJZUGpTOTBGcncvRXVGRFB1M0hhVURVRkl3YlJ2SGdSbENy?=
 =?utf-8?B?L2FYSG13ZlZmNFkxTVdDTXY1M3dpUzh0cndxTU1RTHpSRGNSSWRrYUd4WjU0?=
 =?utf-8?B?b3pQeTMySyswbzFQUWpaNkFSYjMrbEFpZWtZRForc0JFYXJ2MDdyU2RsQ1lH?=
 =?utf-8?B?My96NERmOGRxR0ZQVURvSFMwa3hKYktWeFUrODJrWVNSRlRmbk5XSjR0Y2VK?=
 =?utf-8?B?ek1JaXo2MG1nNlRzU0FJbkJmWHhHNTFlNkQzdWlPcDVmTXFMU1BaYU5Cb2ZV?=
 =?utf-8?B?b0NtQmpkOVp0R205RFRpQlNoUzhvdlQyWGpDd1NsTFFzUGpGdkpCS1hoaVdV?=
 =?utf-8?B?elpETlM5aGhrOXFCbGNmeDdhaUd6S0JBSlBPaXlaNnJJSFlLUVBDR1FzSXRi?=
 =?utf-8?B?ZVBVSEF5SXpFcDBaL3hxZkd4Nm9lRzlEUHNZSTZGYTdOLzhRMkVyRmlQeXE0?=
 =?utf-8?B?eEJIenFrTGVKbXRHTXdpaUNhUlVUMjZ0TlhuZmFsS3pZOGM0Zm94b0xsWU0r?=
 =?utf-8?B?bEF1YnZnVEJiTVBXMkRpZGhydnNiamtRQ0VDS1hyZ1d2bWh3dmw5Tnc0NWNz?=
 =?utf-8?B?ajlWK080SXhNRnNHakRnUlVKZHFTVmZxTGlJTVNvZTJNNWRYVFB2Z1RlZHcy?=
 =?utf-8?B?MTR4cDEwZXFXUW9EckluUEZ1eXl6YXRiSk1Jb2pGdU9GVVFvY3ZjVjBDL3gx?=
 =?utf-8?B?TTQvSEZPKzVJa3lPaU0yT0ZsVEpZd3VWRm1HajFwMDYvcUFua3FXOWNYMlVL?=
 =?utf-8?B?bXJ3T0g1MWtjTjVGSFJka1podlcyenJXU1JzaFlrRjdYWEQzbUZQaTJ5MVR5?=
 =?utf-8?B?TlI4ZG5PVHdIOHJ0ajJnMWFDYjdJT3U0bmM5eDU2bUYrckFaTnZDQ0xCaTVE?=
 =?utf-8?B?Uk9ka29qNCtDcU11eXpzUG9rWmVuVkNWanpOSFhJaG5xWko1eFlibjUxKzhM?=
 =?utf-8?B?UXZRaHdxbXI1RjFVdDk3ODhNWGkyNGZWQVNCMGhNcjY2TTRLK09BaGF1YWN1?=
 =?utf-8?B?L3F4UHRMd3kzQTJ2SktXTWJYMXRFVnZnQ2UzeWlwWnFqQWk4VU1Wd3NjSDI0?=
 =?utf-8?B?bS9FbnFCS2FRdm9ncU44YUNIdTdBb3M5S3AwTXF2UVpXWU9qdVBYMG95WXVK?=
 =?utf-8?B?OXE3ajZyakVlc3F1Z3c0TlFrQlF3YndWVm1tSStnWWVoUGQ2eXhpL0hzSm5t?=
 =?utf-8?B?ZngxSGlPendZeVA4bjdaeGhEdTB3MXo0Y3p0RGtnWlZKWlRDYk5hUXlTZUpr?=
 =?utf-8?B?ZzNzOFE0bnNyL3lpK0Rka3NjTUFXVk1SM245Wk4wQ29NcTI5SkpnRkgzK0Q1?=
 =?utf-8?B?NitHNDdZQ01IR3paNVdCbW9HTEJWK1d3YzBpRjgxQjNJcEhjSUNQMXEzSFhx?=
 =?utf-8?B?UHRvalRKYS9iZXdnN1gwbllsL1RDOFRwbC9UUkU2dUJDOUQ4MUJrN0xGUk1h?=
 =?utf-8?B?TG9zdTJhaG81ZXcyTldJanlxY3JXcy90ZEJ6M21qb0Z0ZExFN2lZRFpuS1pT?=
 =?utf-8?B?cklyaVQ2RmpNNFpKdW9EOUlneGt2UkZsOUVwbmtDUWI4TTJDLy8vdVFSMCtU?=
 =?utf-8?B?bW1MRitOY2FKN3hkbks3SVpVMjdLUUR0U25YMXpXb1NzR2lWTTZZc3JnemtV?=
 =?utf-8?B?WHZ4dXdJVGtPS3RkazM5aXA4US9ja085N1dqaUw2YW9Mbm5keFBYNHBiVnJj?=
 =?utf-8?B?QTI5bTVjdlMyYjJXS3d2elNxc2xPVjQxVUR2cmNLaU5hUDJQYWFSemhabmNV?=
 =?utf-8?B?bHoyczVvL0JBaXFOamtFWm1DR3ZWdmtwVnEwMDFtWFpnbTh3VzRlaHNueXNE?=
 =?utf-8?B?NjN4QXJOb3ZoUjM3WXUzNStja3ZFQXI1cDN2aUNnK2g2SzB6OGdzeDBkYWdj?=
 =?utf-8?B?N3R5Yit1ZmZCYVBac3BLYk9rc2FZZUZmS0NxTEgxSk5Hd2t2bjhOSTJrQ0ZM?=
 =?utf-8?B?NkhTWHU2Mks3SWJlUXpMOE9hM2x5OEs1d29CRXZ1R2ZnYUNkNFhFd0IyL1pO?=
 =?utf-8?B?bEZacUlIZkFGajhoWGNEUDNiWVJsYjBrQkgrdDY0TVRNNkNHcE1NOWErOUpL?=
 =?utf-8?B?ZFphdkNoWGRjNDN6Z2FpT2FDRFUzaVI0VC9kU2FmMGVTRHFuR0U5ZHFYTTlT?=
 =?utf-8?B?WlpQYnFkUjhOeVNpa29IbEtrOEpzR0FxK3NLcXhQcURkY3MrNEo1V0M1N0xt?=
 =?utf-8?B?K3RIampMRk9mRnBRS20wb1JmcDdkWktmdU9KTUtURFRzNmc3Nmx1WStTWGZn?=
 =?utf-8?Q?KOzdKifd7ejTMcqygPj6KgIRyb8MX8ndBAlDEY3HnsbpS?=
X-MS-Exchange-AntiSpam-MessageData-1: +NU33D/1w0S3GA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97dc680a-ced9-4b71-04d7-08df1d3c85fd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 08:43:09.4337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CF6vatCF+9cI2wxd6xbqWQPL1mQyNl/3h2tCK4WkkOWHw7cKogx/v40nYnUTeGEa0nDVElddMagnVgA4Q2xL3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8065
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
 rust/kernel/alloc/kvec.rs     |   1 +
 3 files changed, 351 insertions(+)

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
diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index 1b7b3a1ca770..bb4da220293b 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -1242,6 +1242,7 @@ fn eq(&self, other: &$rhs) -> bool { self[..] == other[..] }
         )*
     }
 }
+pub(super) use impl_slice_eq;
 
 impl_slice_eq! {
     [A1: Allocator, A2: Allocator] Vec<T, A1>, Vec<U, A2>,

-- 
2.55.0

