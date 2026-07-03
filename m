Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8221DC44500
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 10:19:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC9BD10F767;
	Fri,  3 Jul 2026 10:19:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ufPJ1zkW";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010010.outbound.protection.outlook.com [52.101.46.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C306210F767
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 10:19:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wHMojftQUHVp7yrV28s3eB1GVFs6kyX/nW46zFKiNRJVDwf3mmrPdDOvcGIntW7RQivK0Tm5DRG+gl7Pj5RUbnCfjLqmVWTlZf9zxSibtMd19K0kRzjdCow7ucsTaftejf+Zfq5qexcIQiuvBqFzY1gI7r7tmsVVWdKjCt1WpyDY+L7tSSEsJyyTgBAIEFh8wW0OBvNvDJumbQUG61hmtkS18hanQtRhnIilOkDG4eTgacJtZ7AW22Lxz9P6NMMQVzfRUxKNQcUVdC/V0R7dxHYdf3at2izZQ3L16qJLf3dQqu3R7iQvCav9G+R5EB7uDZuXNGTAw/Obj/cIcpDEDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbPwUNfPNxYS7vqr8wmPDvwVUsbXiaB7+qN5zacufyU=;
 b=PbB1eV/fPRsJKIECrpH5FsC3jZ+OgQWV7sAdOFAHJpi2SQpV/5Jljc/0fTho/QYsINlB55y8dfBwLleCWvENouzcMo3ZNqVyV/Fpi3KVyWOPE5icHdIPV6TeR05HyrTPwUsPrCEo80cIZYKEzUIZcJdG8enlyUX6tydm6HJDKyFTaaZLPR8lWi85ED073tW9BFlfBvJk5wsDpj40qOLbonaClgc4qWEVfIGmtr81S2ih1UG6Enckudoo0TgyxnlUfQ0CVoamq3acIZjGLt73bsAVMGBMhwEr3Lv/wxMthynYR/8ViSLznmT6N2hldwBA3snHLgqLZx2jqGaacYceuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbPwUNfPNxYS7vqr8wmPDvwVUsbXiaB7+qN5zacufyU=;
 b=ufPJ1zkWGlPlJG4YNjzIJWaduwmIrfOjFZBD9SoLdaFdRLAGAoyAI5wBMCfQ5RykdqQrpLUDyyWHJcELcFJT6JoaWQ05JKeDBZPutFhoRI5kXPxP25k3CMDe6OmGy6zAVrsBeiahzVYBKe+R9OBvSbZE60HZREpMmU7aWN3NsZvjfnsc41zYIW2VVMHjkOUhBt6o0erjqHbjGocP16rQAhrjLNxIqZ/lyVwvgwyXUixuptz6SULl9/qd0j5gYOYintlyMXHKfSAGWnpiFYA/jYmMCK09LNZLrqbLMKjc69b+4bVzAc7EIyRjtSRnZ6gf00vfRpUE/2Vbuy5pQigw/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DM4PR12MB6326.namprd12.prod.outlook.com (2603:10b6:8:a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 10:19:29 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 10:19:29 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Fri, 03 Jul 2026 19:16:05 +0900
Subject: [PATCH 2/4] rust: bitmap: add contiguous area operations
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-chid-v1-2-84fe8259e46e@nvidia.com>
References: <20260703-chid-v1-0-84fe8259e46e@nvidia.com>
In-Reply-To: <20260703-chid-v1-0-84fe8259e46e@nvidia.com>
To: Alice Ryhl <aliceryhl@google.com>, Burak Emir <bqe@google.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0322.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::11) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DM4PR12MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: e8a69bde-8d72-4d56-729c-08ded8ec90ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|23010399003|7416014|376014|18002099003|22082099003|3023799007|6133799003|11063799006|5023799004|56012099006|921020;
X-Microsoft-Antispam-Message-Info: o1Eb8JlPoN7G2QPo1hWOu7LzEblKCCfb/abQPhs15svfJsm+nk587UJK+Y5/wDGvDeWaQZIaLqd5hPhPTvfaWaY7Mtmvsx/SBX5BP11dd72u8M8BatF40WSkdTqktCVFdk4fzbATmzkHJfo0iowg/yoEPfJ0vhjS4xqlCi7F31dw0Pjd2BvHmPmv29s+g+/kuPWcLI6FiOWSWlCiVTQkP0foBNP6pOGpem9RQF3yzAUMtldURBd/3y3euvqmF9QT/UUyZgtflNdAAR9sDErZJn0aiUfWTsp7fTCAEaeokoYbUfr61BEIfPYkTGkeNntMoEwrFiIfXHe7klF1SXAqxQiqxUUEbuQ4OV1VprtR0e9lVR3KCCuavPsQPKhMQmxhbmo8lC0Z4uxbNIAq+HWG7wbyJuwEDKIFn2MfnIn53vVk46gldJ32EJEgEjMwub9etdeyhSKnuZbf9Xa83YGQpnBqFeLlMeBmgbvPkpCsu9qbB3l3EAdBIAHPY1UnrLrm38b48Ab99yaCF70wuIS4/wMJlEyap3FnfZcSKJ67Ote7PgpYradTHXZtOPTAa8wah0XGzYhxKtHtS7PJk0TiRIw6pcWHBDm4IkeoHdL2a1BXsdvKxORPVY71Xm9LNL3J4OjRxmXpTQmQA8Qq5ZJopRbXO4U1FzJ1JtIyWkDBzkjlExF/ffA7+OBTNrkowbDD8NZf0+B9dQvK1FEn5o4D0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(23010399003)(7416014)(376014)(18002099003)(22082099003)(3023799007)(6133799003)(11063799006)(5023799004)(56012099006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmQvRWR4Qzc5bGQvKzA5aWZVTlBSNzk0ZWJPbE5Ob0kzNFA5QVZQbjRSc2Fu?=
 =?utf-8?B?cGdFWU9sT0FocCtySnh1TUFaZ1NPa3RDWDAvMGhUZzF0cnpHb2Q2Mll0b0Vm?=
 =?utf-8?B?TXllemYrcENzWHhhdHllM0padiszUVY2dEF2dTlvVGhYODRUMkpoU09qUTRx?=
 =?utf-8?B?ODFoTi9zbWJ0Q2VVSDhIZlp4Y1RmUEt5aHBxYk50TkNPWmNXVXJtTjE5czl3?=
 =?utf-8?B?VWR5dHN6ZGpQem54WTAyUGVLMEZ4K2dobEpIKzhZWm9VUzVrbFVxSG1CaGM2?=
 =?utf-8?B?VGVhRWJJYmpWUFB2cm0xck1DYmRHOHVnWUFEdC9jZmYzM3J5M1JvN1cxR3M1?=
 =?utf-8?B?TGVUVHM5cWhPN3JWNk1WWEdXUkU2UUdqb0paSkVRTDd2V0h2MWdnblg1VzFM?=
 =?utf-8?B?VmxwdkU5OFk2ZHBlbmh4bGtBM1lQM2hGWS9OekJrYmVNK3FIdFZGL1ZIRjRX?=
 =?utf-8?B?ZjZXcWxtNDhJaFNjd21aNmsvUFNVbUd3TmhqWGVsd0dzdVhOVDhTZmJNNmF3?=
 =?utf-8?B?d0p2UkNYeDI0RE82UEY5Mm5CMDRra09sU24vcWlkUE1mSzd0U2k1bVAxQXp3?=
 =?utf-8?B?bU1iVEdZak5sMmludFFOZDN2Y3d6OHJ2T2c3M3EyeWIrNkZCcTNiZE9lOG1X?=
 =?utf-8?B?T2lLa3hKTzc3a0IwbE96N3BGdXlOWlJxUHJhVXp5VHFaOEtSeThNVE1wT3A1?=
 =?utf-8?B?L0xYeEo4RTNtcEJEYnFhdjVURlVhZ0QrSEY4VWFuUWFsdGNIL1FwMStWTHJR?=
 =?utf-8?B?dXRvaEg3UXpoem1wRVZidkJWNEpSWkVTUXlVcUljemNlNVFaWFIxZDFkc3gy?=
 =?utf-8?B?S0VJcUlqRWdlK0lsbWM5aElySld1Vzd3UTZ2ZVpNS0V1cVB0Nms4TzdGTmho?=
 =?utf-8?B?UGV2NWhnVTE5NGN3UjRmNURJSnR3Z2xFbnAyNWxSTlZHQ0VXcnRMT0JjMDdD?=
 =?utf-8?B?SndIdkk4TEpTdC83dkdMT0tFZmxHb2RVN2NhZVFoZ0RLbmZXVmJtbFR0QXU3?=
 =?utf-8?B?YzNoemg4MWhJY3k3Q0tLVkVRTHQ1Qks5K2l1dDV5ekNjdThWQ1NEWkgvMy9R?=
 =?utf-8?B?MlI3YTE2aEVXSGVJcUFOSUYzWndCSHZVZVk3VmUxNmtoVWdnbWxyT3RodklI?=
 =?utf-8?B?SEpBQ1hBa3I2RDhONzdpbVplK09YY0NQcVhxQWdDeE9nV0E2QWhTRC92WWVm?=
 =?utf-8?B?RUJBWXduSzU5TGgxMjJJR29mWGlvWDkxWnFhaUhjU1NWRzNGS1BPaVFESGlL?=
 =?utf-8?B?anVLN20xaTZza3RDdGl4Uys1cjdoVlJneTR3L1NZeVF2KzI2Rzhwd0Y4bkNC?=
 =?utf-8?B?T1U3eTdWa1ZNQVd0QUc0Qmt6UUN4T1ZhK2NxeWZWN1R6YTF2MjRrM09QZ2g1?=
 =?utf-8?B?VVA1cFJaYjVZcnZSMko5ejdpdnViWEZuNDVNaUF4NUYreTRZNXlNV0hJYlc0?=
 =?utf-8?B?YWRKUEhrNEl2aElIZW5QUlEvYmdhYlBuWFlNbTdUcGZxcnNyVldwY0QvRHhW?=
 =?utf-8?B?NzdOY0tlUHYvVk5pVjJWK1FBdEcwRlpEUW45TGc0NllXalhFYWQ4b1J1SEpL?=
 =?utf-8?B?Y0draG5abE10R3ZLMHVVNnF4MEdjOWlidUx6VCtiMjB5UjBzb2ZldnZxMUVW?=
 =?utf-8?B?ZFVQSDFULytJdU1oOU8rY1FUTC80dlBlSm85SGNsb0N2TU5NQ3dXdjhZdG8r?=
 =?utf-8?B?bUd6NVAyaEx0YWlKQkVzdW5rdmRVZzRidkpuOTNQWFQ4SnFML0YzRHRZaXUr?=
 =?utf-8?B?SDloY2JNUUxScDNCQmd2aVZiNUl1L3JzclJlUTM0ZlBIc3BuNkdNYkg5MDNj?=
 =?utf-8?B?V2lXM013WTVGQkYrU0tMYmluQi9zV1NkL0xja0ZGaGZxNS9BdklrUGtDb2s1?=
 =?utf-8?B?cnlLZkJpVkRXdkw2aEM4TlY2Z1dTWjR0NGROUEJvcENFeG9iTjlZZThTRDR1?=
 =?utf-8?B?MGtYdWVweU10V0F3Ny9KS3NpT3IxYXVtZGVjSW0wS1MwK2NCSFNhT2NzS1BF?=
 =?utf-8?B?T1RMMk1lNGM3VDdUV2pOY2hYdTU3K2xoRXhkdDRoZk0zY3RMU3hqSVJHeDZK?=
 =?utf-8?B?VS90RFRDaHljME9KSGZlUFp6SUpna1ZuNDdOMjY2MEN0RlBMU1lzZnhrWnJr?=
 =?utf-8?B?UTd4eFk2RExZSU9ScnA2SklmdzFxN0F4NERtbE11YjYxWWZva0ZVaUVZT1Uw?=
 =?utf-8?B?L2NSR1A5d0pCbU5xbXJ1ZVFheXJYQ0cxYXRNTGs0b0o2UnluTXJvdnlBc0Q3?=
 =?utf-8?B?M0wvRlVNV0NHeVJMbUlBWnFLeVJQRWV2Nzd6Y09JVmExSTBuaU9reXBZSEhG?=
 =?utf-8?B?OCtWVE0yN2dKZnY3UWhJS0dHOXNiTU1wbXBVNGpXdGo5NXBEc0tEdzlScFlz?=
 =?utf-8?Q?KJCEHkbv1mfz+CQ5mIkDpb1MonaJAAzBt0U+B5NkW08oL?=
X-MS-Exchange-AntiSpam-MessageData-1: Y82oM8MqY/UzJg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a69bde-8d72-4d56-729c-08ded8ec90ea
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:19:28.9284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e5Fj84RaNWZF4AVcsbo8Tjb9L2uCy295YHiFJEGKpX2nIyrOeP/oE05VxAqN9inLZ40y1HBTdeiXDfcqNVdivQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6326
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

Add bindings and helpers for area operations on bitmaps. Each one is
made safe by adding some extra checks compared to the underlying C code
(for example, checking bounds) and with additional checks to catch
likely erroneous usage if `CONFIG_RUST_BITMAP_HARDENED` is on.

The C code uses signed integers for some parameters, for example the
length for `__bitmap_set`, so bounds check against i32::MAX. We can't
rely on `BitmapVec::MAX_LEN` because `Bitmap` may not necessarily be
backed by `BitmapVec`. There's also a few cases where a non power of two
minus one `align_mask` can cause an infinite loop in the C code (can
happen on overflow), so check for that.

Add tests demonstrating the edge cases.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/helpers/bitmap.c |  22 +++++
 rust/kernel/bitmap.rs | 219 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 241 insertions(+)

diff --git a/rust/helpers/bitmap.c b/rust/helpers/bitmap.c
index e4e9f4361270..dac5c03f2448 100644
--- a/rust/helpers/bitmap.c
+++ b/rust/helpers/bitmap.c
@@ -8,3 +8,25 @@ void rust_helper_bitmap_copy_and_extend(unsigned long *to, const unsigned long *
 {
 	bitmap_copy_and_extend(to, from, count, size);
 }
+
+__rust_helper
+unsigned long rust_helper_bitmap_find_next_zero_area(unsigned long *map,
+						     unsigned long size,
+						     unsigned long start,
+						     unsigned int nr,
+						     unsigned long align_mask)
+{
+	return bitmap_find_next_zero_area(map, size, start, nr, align_mask);
+}
+
+__rust_helper
+void rust_helper_bitmap_set(unsigned long *map, unsigned int start, unsigned int nbits)
+{
+	bitmap_set(map, start, nbits);
+}
+
+__rust_helper
+void rust_helper_bitmap_clear(unsigned long *map, unsigned int start, unsigned int nbits)
+{
+	bitmap_clear(map, start, nbits);
+}
diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
index a43bfe0ec3dc..f7290fa439d6 100644
--- a/rust/kernel/bitmap.rs
+++ b/rust/kernel/bitmap.rs
@@ -497,6 +497,129 @@ pub fn next_zero_bit(&self, start: usize) -> Option<usize> {
             Some(index)
         }
     }
+
+    /// Finds a contiguous area of `nbits` zero bits at or after `start`, aligned per `align_mask`.
+    ///
+    /// Returns the bit index of the start of the area, or [`None`] if no such area fitting in
+    /// the bitmap exists or the `align_mask` is invalid.
+    ///
+    /// `align_mask` should be `0` (no alignment) or one less than a power of two, in which case the
+    /// returned index is a multiple of that power of two.
+    ///
+    /// # Panics
+    ///
+    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and `start` is out of bounds or
+    /// `align_mask` is not `0` or `2^k - 1`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
+    /// use kernel::bitmap::BitmapVec;
+    ///
+    /// let mut b = BitmapVec::new(64, GFP_KERNEL)?;
+    ///
+    /// assert_eq!(Some(0), b.next_zero_area(0, 8, 0));
+    /// b.set_area(0, 5);
+    /// assert_eq!(Some(5), b.next_zero_area(0, 8, 0));
+    /// assert_eq!(Some(8), b.next_zero_area(0, 8, 7));
+    /// assert_eq!(None, b.next_zero_area(0, 65, 0));
+    /// # Ok::<(), AllocError>(())
+    /// ```
+    #[inline]
+    pub fn next_zero_area(&self, start: usize, nbits: usize, align_mask: usize) -> Option<usize> {
+        bitmap_assert!(
+            start < self.len(),
+            "`start` must be < {}, was {}",
+            self.len(),
+            start
+        );
+
+        let valid_align_mask = align_mask
+            .checked_add(1)
+            .is_some_and(|p| p.is_power_of_two());
+
+        bitmap_assert!(
+            valid_align_mask,
+            "`align_mask` must be 0 or `2^k - 1`, was {}",
+            align_mask
+        );
+
+        if !valid_align_mask {
+            return None;
+        }
+
+        let nr = u32::try_from(nbits).ok()?;
+
+        // SAFETY: `bitmap_find_next_zero_area` is safe to use with an out of bounds `start` value,
+        // never reads beyond `self.len()` bits, and returns a value `>= self.len()` when no area is
+        // found.
+        let index = unsafe {
+            bindings::bitmap_find_next_zero_area(
+                self.as_ptr().cast_mut(),
+                self.len(),
+                start,
+                nr,
+                align_mask,
+            )
+        };
+
+        // In case of overflow, we may get back a range outside of what we requested.
+        let end = index.checked_add(nbits)?;
+        if index < start || index >= self.len() || end > self.len() {
+            None
+        } else {
+            Some(index)
+        }
+    }
+
+    /// Sets a contiguous area of `nbits` bits starting at `start`.
+    ///
+    /// If CONFIG_RUST_BITMAP_HARDENED is not enabled and the area `start..start + nbits` is out of
+    /// bounds, does nothing.
+    ///
+    /// # Panics
+    ///
+    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and the area `start..start + nbits` is out
+    /// of bounds.
+    #[inline]
+    pub fn set_area(&mut self, start: usize, nbits: usize) {
+        bitmap_assert_return!(
+            start
+                .checked_add(nbits)
+                .is_some_and(|end| end <= self.len() && end <= i32::MAX as usize),
+            "Area `start..start + nbits` ({}..{}) must be within bounds {}",
+            start,
+            start.saturating_add(nbits),
+            self.len()
+        );
+        // SAFETY: The area `start..start + nbits` is within bounds.
+        unsafe { bindings::bitmap_set(self.as_mut_ptr(), start as u32, nbits as u32) };
+    }
+
+    /// Clears a contiguous area of `nbits` bits starting at `start`.
+    ///
+    /// If CONFIG_RUST_BITMAP_HARDENED is not enabled and the area `start..start + nbits` is out of
+    /// bounds, does nothing.
+    ///
+    /// # Panics
+    ///
+    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and the area `start..start + nbits` is out
+    /// of bounds.
+    #[inline]
+    pub fn clear_area(&mut self, start: usize, nbits: usize) {
+        bitmap_assert_return!(
+            start
+                .checked_add(nbits)
+                .is_some_and(|end| end <= self.len() && end <= i32::MAX as usize),
+            "Area `start..start + nbits` ({}..{}) must be within bounds {}",
+            start,
+            start.saturating_add(nbits),
+            self.len()
+        );
+        // SAFETY: The area `start..start + nbits` is within bounds.
+        unsafe { bindings::bitmap_clear(self.as_mut_ptr(), start as u32, nbits as u32) };
+    }
 }
 
 #[cfg(CONFIG_RUST_BITMAP_KUNIT_TEST)]
@@ -614,4 +737,100 @@ fn bitmap_copy_and_extend() -> Result<(), AllocError> {
         assert_eq!(Some(17), long_bitmap.last_bit());
         Ok(())
     }
+
+    #[test]
+    fn bitmap_area_set_clear_find() -> Result<(), AllocError> {
+        let mut b = BitmapVec::new(128, GFP_KERNEL)?;
+
+        assert_eq!(Some(0), b.next_zero_area(0, 5, 0));
+        b.set_area(0, 5); // Now contains {[0, 5)}.
+
+        assert_eq!(Some(0), b.next_bit(0));
+        assert_eq!(Some(4), b.next_bit(4));
+        assert_eq!(Some(5), b.next_zero_bit(0));
+        assert_eq!(Some(5), b.next_zero_area(0, 5, 0));
+        assert_eq!(Some(8), b.next_zero_area(0, 5, 7));
+
+        b.set_area(8, 8); // Now contains {[0, 5), [8, 16)}.
+        assert_eq!(Some(16), b.next_zero_area(0, 4, 15));
+        assert_eq!(Some(16), b.next_zero_area(0, 4, 0));
+
+        b.clear_area(0, 5); // Now contains {[8, 16)}.
+        assert_eq!(Some(0), b.next_zero_area(0, 5, 0));
+        assert_eq!(Some(8), b.next_bit(0));
+        assert_eq!(Some(15), b.last_bit());
+
+        b.clear_area(16, 0); // Zero-length in-bounds clears are no-ops.
+        assert_eq!(Some(8), b.next_bit(0));
+        assert_eq!(Some(15), b.last_bit());
+
+        // A zero-length request returns the first aligned position at or
+        // after the next zero bit, even if that position's own bit is set.
+        assert_eq!(Some(1), b.next_zero_area(1, 0, 0));
+        assert_eq!(Some(8), b.next_zero_area(1, 0, 7));
+
+        b.set_area(60, 10); // Now contains {[8, 16), [60, 70)}.
+        assert_eq!(Some(60), b.next_bit(16));
+        assert_eq!(Some(69), b.last_bit());
+        assert_eq!(Some(16), b.next_zero_area(9, 40, 0));
+        assert_eq!(Some(70), b.next_zero_area(0, 45, 0));
+
+        b.clear_area(62, 6); // Now contains {[8, 16), [60, 62), [68, 70)}.
+        assert_eq!(Some(62), b.next_zero_area(60, 6, 0));
+        assert_eq!(Some(61), b.next_bit(61));
+        assert_eq!(Some(69), b.last_bit());
+
+        b.set_area(64, 0); // Zero-length in-bounds sets are no-ops.
+        assert_eq!(Some(62), b.next_zero_bit(62));
+        Ok(())
+    }
+
+    #[test]
+    fn bitmap_area_exhaustion() -> Result<(), AllocError> {
+        let mut b = BitmapVec::new(64, GFP_KERNEL)?;
+
+        assert_eq!(None, b.next_zero_area(0, 65, 0));
+        assert_eq!(None, b.next_zero_area(0, usize::MAX, 0));
+        assert_eq!(None, b.next_zero_area(1, usize::MAX, 0));
+
+        b.set_bit(0); // Now contains {[0, 1)}.
+        assert_eq!(None, b.next_zero_area(0, usize::MAX, 0));
+
+        b.set_area(0, 61); // Now contains {[0, 61)}.
+        assert_eq!(None, b.next_zero_area(0, 4, 0));
+        assert_eq!(Some(61), b.next_zero_area(0, 3, 0));
+        assert_eq!(None, b.next_zero_area(0, 1, 63));
+        Ok(())
+    }
+
+    #[test]
+    #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
+    fn bitmap_area_invalid_align() -> Result<(), AllocError> {
+        let mut b = BitmapVec::new(64, GFP_KERNEL)?;
+        b.set_bit(0);
+
+        assert_eq!(Some(1), b.next_zero_bit(1));
+        // If this isn't rejected, it would cause a hang in the C code.
+        assert_eq!(None, b.next_zero_area(1, 1, usize::MAX));
+        // Reject non `2^k - 1` alignment masks.
+        assert_eq!(None, b.next_zero_area(1, 1, 2));
+        assert_eq!(None, b.next_zero_area(1, 1, 5));
+        Ok(())
+    }
+
+    #[test]
+    #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
+    fn owned_bitmap_area_out_of_bounds() -> Result<(), AllocError> {
+        let mut b = BitmapVec::new(64, GFP_KERNEL)?;
+
+        // Should be ignored since out of bounds.
+        b.set_area(64, 4);
+        b.set_area(62, 8);
+        b.set_area(usize::MAX, 0);
+        b.clear_area(usize::MAX, 0);
+        b.clear_area(2048, 8);
+        assert_eq!(None, b.next_bit(0));
+        assert_eq!(None, b.next_zero_area(64, 1, 0));
+        Ok(())
+    }
 }

-- 
2.54.0

