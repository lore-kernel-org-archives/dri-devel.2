Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2084CA5FA5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 02:45:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46F1010F135;
	Wed, 30 Sep 2026 02:45:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="GbK1YNkx";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012058.outbound.protection.outlook.com [40.107.209.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 442BF10E9F4
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 02:44:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PxNFLm3TVJmc5oVo8uTuxsq6ikMl3Al/ZH7f2OYzkbqftkXYeQt1TOQZ0fiar7NbRhnzu7t9kx6AaHNel5yxNFcD93P6o1v/wMBQLNTmAF0qtLRAQbipZW2dfI0p/ii0QqZbu6YTUj6sPpcX/fzo/IGPgHFsXq1YO1rIq/H8JjGO5HqZqsBt+zjnGsuCQPxSgBdKG+88Tel2pRw1CCh3cF8Qfuk3UNsmJITw6/+B/QnSA0uMoZKPQmBYy8B/anUrxNyLza5EAT1co7JrdNKyY3/AluRYm72IuZvznuKUFU00QaDo+HxT+ZhlKbpJ+3TsGFZa4zeTaGBpf2QW9gM84A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Y9HWLj8CuT0Jqtkjv0uqNaXQWOeFc2SxMxakslgRLk=;
 b=PFEMpa9DkKkOq0RJ4lZxwP7aeOPLkZgZqnSbnsBQj95aZ4uYf6upzzI6uCa6ucsLAkh8WKM8bHG+IgcpypoVPZjgmWfWo0VCGf9xF6vbphm3MXkfYGhrsWY2YivGPHfRiIV266x6nMa5klgrCuh5LQ0uuu1mNkJUoSFUvAo3cZ2P5D93GDwUT63gLRTSqZMtaEWVEm6bMELzfkAjGwypyW3xRzDcgBTM2uPzDO1Vq2V3s+17I52x1T/783JA+q/Js63zmYiIqQcIZ2rHwL7WiowBduGNIGkxTUsxD18Xgmd3fo1HTNk32xdOYmpRLJnPDDsJQ+oTlSdsKPNHVfcS6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Y9HWLj8CuT0Jqtkjv0uqNaXQWOeFc2SxMxakslgRLk=;
 b=GbK1YNkxfMLHUYAaGKAO7KHRoMQKNYAXYhqh7hvyxZ5WwOmZ20BKmkh0NAHNcRGkojYRkFWVHchhOhFXC2ay0PfTWt3JNldriI7M6IxrlnSawx8Y7C039Rb9Pbdt/lPJSHp2LvX/2q7u4kvYLP829jhRL4ng7wumYWO6BCdj+l3QdL6HCS0w3nOmAF2h4IXEwFFG1lfgvcB+1ATwLFrhc/FqYb+sX9P+D0veCvrGeuku00MKmfm8rD1RjDGQnqH2GQNHoPkZbRF/qPGvqpvwjycFRYRhTKwK5Hb3L8A/6dWEeC+Y0bI/vUoqlRf8o/J3gWJnj7p2AMFk96t3mCQDtg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 BL3PR12MB6523.namprd12.prod.outlook.com (2603:10b6:208:3bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 02:44:43 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 02:44:43 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 30 Sep 2026 11:42:55 +0900
Subject: [PATCH v9 6/9] rust: bitmap: add contiguous area operations
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-chid-v9-6-0d6cca376cff@nvidia.com>
References: <20260930-chid-v9-0-0d6cca376cff@nvidia.com>
In-Reply-To: <20260930-chid-v9-0-0d6cca376cff@nvidia.com>
To: Alice Ryhl <aliceryhl@google.com>, Burak Emir <burak.emir@gmail.com>, 
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP301CA0006.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::15) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|BL3PR12MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: c7d14b6e-7b3f-448c-cf44-08df1e9cc86d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|7416014|376014|1800799024|366016|10067099003|56012099006|921020|6133799003|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8qKG4DoHOVXbDIEW0cXke/H2IPsXAyHZUFCtpBvvZhO1I1DxjbsVl+hgy8PLVipK7PVi2TaZbJuhUC3GI4mE6QrXmcPeLH7lN8xQttmhDpR0DcVNm4H6c8bltZ+FeVNUkQu2zTCRgs9k8TvNiAoYzjDCj7wI3l2VUhfK8L8cIcIF2gFHZtBU3sZMh4LRi1WNJpYKDfwy++FvQAj++81YHZ4ugsjNoiQw4SiCydXWZsmgTmPf/5kFhFrwYouf9rAYCjF0UfLIurfHF2Ll5KqzZY4nHsQqmzYaqBt75OV7wnULn8mV02AD+QIm28KLWuI7KgewjHGsMcB92dEXLvisY36k/V1BUqUMoOdv+iTuN0g8NT3eKf+CwcsbvQ0ER9IBZkyrpufgWQtYCW5vXSUEaOjEkk6lFJ9V8t6onwtef9ZBnpue6B9ydvxRP7zeEs7eEg5jUJbvr20JfyvspAlDJKYzPJzT4xepURG5hvAfGuBQQcfZ2cZvwamMYVcG8v9WhUicVjiIF2xrLKTfM1gRWPFDcBsMffkqastL4OzL/MLa26dJAL48pIduIPUBBEaRn5wpAYmt+2HCs0kgi0JauZ58e+PI1B2XcA8+kqudfPCPdrwVdrd2rAYbdin+rnDRiRGqgfUkRUxgxYhv3qfInXiGTcwHvs13g58cljdCZBetYMCWH/mekLhHumgfbf5JRwAlAjEGmhW0GDpxAeyWcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(7416014)(376014)(1800799024)(366016)(10067099003)(56012099006)(921020)(6133799003)(5023799004)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bm84eGNRc1RPZktpdGQ1SEJSREttRDhuUzgzWWVXeGJPMlNxR0FZUW5yRFpJ?=
 =?utf-8?B?d1d4ZEkyZ2RRTGxQREI1MXcvZ3E1U2Y1SWkrUTErRTFBT1FlTzFsV0s1a00y?=
 =?utf-8?B?aXo4MlFiN2YxMkpRTTdJOHlmYUh5OU4yWTFLNUJuOG9FUkFUb3Y2SGl5M002?=
 =?utf-8?B?ZHhGTEdhQTBSdXQxTjR2KzVNc2t3RjV3WnR4bU96TW0rc0hXb0hPZHp1N0Ji?=
 =?utf-8?B?WHdkUmxkNzMvbjkySW1nbTRNVWowZm9aYk9qcktrZ2RDL0hSWVJ1VWZYN3gx?=
 =?utf-8?B?UG1vUk45L0JNS1IrQ2dNM0g5OVkvSjJMblRhcVVPQThIY1NzUXFPdiszYXhi?=
 =?utf-8?B?Q3hZRGZhZ2p2OFJYdldrVnlkSmRpNTkrZVRSQ0RlVWhXU2t2RTJqVUM1RDVC?=
 =?utf-8?B?QVJROE1uSHdPaVBBNkdxcGdnMUhqR1g2WG9xTjdMRHRUOFhLWkRaRHhKbW5q?=
 =?utf-8?B?QkZqckRZeU40djBXWEFYSkpqRlNIUUJBeUN0QlBKOGk2MVd6WlN4bjVNRml6?=
 =?utf-8?B?T2E4SVVObXVEdTFDVGVGYzNER2pWYXZLUnJycjFhVU5PTEVFZnBKNStPKzhi?=
 =?utf-8?B?U2xidlhFK1lkdlc5WU01TU5Tdk51NGhib0NnRmN5V0UyZUhpMnN3cXljN2hK?=
 =?utf-8?B?Skl5bnpZV3Q3V29qWm9MUWkxd3IrZFBkYnExS1JaSk9qQWhocyt2MW44Uk5q?=
 =?utf-8?B?WkJhUWVZZEFEa1ZZakpmSkJaWGZRbDluNlVhT2ZiZXRFdGFMUFFieHMrWkNO?=
 =?utf-8?B?blAxakZhWHRIcmhReHZxU3loellGYTlGUDhsbHFrYm9hTFRLaTE5bUFncjJK?=
 =?utf-8?B?Ym1OekRHdHNnUWk5TUtTdWdMMkZXVHNxMVVaZGNLMzVOWmdKdmhOR1RTaGNn?=
 =?utf-8?B?S29UTGJzb21mOUQwWE9zUGE5b3lWdmF6dmR2R3lzeVNoQkZLR0hPMVRqbys2?=
 =?utf-8?B?S2FlWlVINzFvQjJzbWlVWUIzUzM5MGRlc3dOZXZ3ZXFsUlk0RitJbXk0YXBL?=
 =?utf-8?B?by9XNE1SdlhEQlgwclR4RWhrbGVoN3krU0dSNTBrZjdSM0RaLzhLMzlpSFpr?=
 =?utf-8?B?bkNpVWRTUVYwNm1wbkFCcmlJRUJsNmRreFJSbGdQT25YcjlWNU84SDI3cVdv?=
 =?utf-8?B?RmVoN0lVdE04SEt4U3RiNUIxbEdldTJ5N1RCRmxSVCtTSjN4ZzByVWo0cHl3?=
 =?utf-8?B?czQvQ2x4MmdrcE9kRUYwaFFWZWlTYzNOVnJPMlI5dUsrYWI4Rm4xL3FYdzh3?=
 =?utf-8?B?KzZOQi9ZcWVMOFZiV21hZ1V0dGRiY3ppNzhKNVJFSVFyMCthNHJ6OGNFKzhB?=
 =?utf-8?B?SHUrN0Y2a1RINnNwOVUvenhBZVpkS1hoc1pydHdENTZva25IN2FCZnBOSXVm?=
 =?utf-8?B?ZGRjNTBkRWtJVUx3VGswdUw2ZVBVMzR1MkZvNkRzeVFkVGcxU0R6OG82S21M?=
 =?utf-8?B?S3E2WHljdGo4aVJrdkh5c0lZbVllRkdzMkV6OU15RzZ3YmJNK1MzNFBvZG1J?=
 =?utf-8?B?RmxpRUNwMXJUTFErSW11TFJyL3lPdXBUSVJ0WWJ3RnMzWTZtR3dNdjJFQWFL?=
 =?utf-8?B?bmcvczZ3QTJudW1NVkJvRC9YcXdoUmZIUmJ6TmJwaDV4Wkt4bFlKS2tETHpQ?=
 =?utf-8?B?MjB1Uk54NmlKMTFYZ1hTWjdaTnExWGUwZUFRSUhicjRuSkVkVFhXZlFGZi9h?=
 =?utf-8?B?VlhxSUprVXN2bHRWczNpMFJPVXZDSy9aRkphUGNqUEhQWllta2F1d0kyWmtr?=
 =?utf-8?B?R2l5UDJBUURNWGlnWkRkQTN0aWhuM0VvS0JiekppU0YrUjIyYXc3b3ZSMXc0?=
 =?utf-8?B?NndweG5XU0IrM3c5ZTZuOTdwMW4rc1QvS0lxQTlVb1ZCOGZOWW5GVjdWejll?=
 =?utf-8?B?amVueWtyTHZEYmxRU05kdmI3QlV4enRsak5rWXRUamFCLzUvRTdPQ3k4eS96?=
 =?utf-8?B?cG1CNTNKR3Jyd3BiMXZkNE50Q1QwK250V3R6aUE4TnNqcm84UWJyZ2ZsTS9X?=
 =?utf-8?B?Q2pGQVN5SWFpaEp6L2FsaVFMeE1uckFicGxQbk9xZVRmcmZ3alRyanpKUlFz?=
 =?utf-8?B?bjBycTErL2QzQUwzRkcxWG1rcFppbG5OTUI3aVVVVkRhbWxrcnoydEZna2Uz?=
 =?utf-8?B?TTBrWkFoSElWTUt0L29nWENpTVFwYlNxeGE4QnRhUVJmZWFnRUtZdm5DNGtJ?=
 =?utf-8?B?Ni84SS9qREdVL3lGMW50UkxVbUxUMVNwT3VDanZsdGJINHNjUTNJVkFCTjVT?=
 =?utf-8?B?a1FRRmt5enJ2a1BpMlJtSjRyenN2QitsRjVKdUVNTDA1N0Q1QVUxL3YvaVdm?=
 =?utf-8?B?USs5M0xObXkzemNHMXNYbk5oeDl2dzYvMXZ6MjhqdTNCTk9UdGREaXh2Y0ZQ?=
 =?utf-8?Q?67qPJ7qugWVRix4nmqS0kpDD5A9sdKIxZaXPLDeuJy+o6?=
X-MS-Exchange-AntiSpam-MessageData-1: oq24gFDysomEfg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d14b6e-7b3f-448c-cf44-08df1e9cc86d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 02:44:43.7453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GrMYmPqCEQNYix37/vUqH7SaiZjDF1BUrXtoroV0kJX43lRKrDNl345QJSbLrUXp/FJU1iYaEtAihlOf4enlwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6523
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

Add bindings for area operations on bitmaps. Each one is
made safe by adding some extra checks compared to the underlying C code
(for example, checking bounds) and with additional checks to catch
likely erroneous usage if `CONFIG_RUST_BITMAP_HARDENED` is on.

Add tests demonstrating the edge cases.

Reviewed-by: Burak Emir <burak.emir@gmail.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/bitmap.rs | 241 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 239 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
index df5505ec7a96..23c2b43a98ac 100644
--- a/rust/kernel/bitmap.rs
+++ b/rust/kernel/bitmap.rs
@@ -10,7 +10,11 @@
 use crate::bindings;
 #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
 use crate::pr_err;
-use core::ptr::NonNull;
+use crate::ptr::Alignment;
+use core::{
+    num::NonZero,
+    ptr::NonNull, //
+};
 
 /// Represents a C bitmap. Wraps underlying C bitmap API.
 ///
@@ -525,13 +529,159 @@ pub fn next_zero_bit(&self, start: usize) -> Option<usize> {
             Some(index)
         }
     }
+
+    /// Finds a contiguous area of `nbits` zero bits at or after `start`, where the area plus
+    /// `align_offset` is aligned to `align`.
+    ///
+    /// Returns the bit index of the start of the area, or [`None`] if no such area fitting in
+    /// the bitmap exists.
+    ///
+    /// The returned index plus `align_offset` is a multiple of `align`.
+    ///
+    /// # Panics
+    ///
+    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and `start` is out of bounds.
+    #[inline]
+    pub fn next_zero_area_off(
+        &self,
+        start: usize,
+        nbits: NonZero<usize>,
+        align: Alignment,
+        align_offset: usize,
+    ) -> Option<usize> {
+        bitmap_assert!(
+            start < self.len(),
+            "`start` must be < {}, was {}",
+            self.len(),
+            start
+        );
+
+        let nr = u32::try_from(nbits.get()).ok()?;
+        let align_mask = align.as_usize() - 1;
+
+        // The C alignment and end arithmetic must not overflow, or it can read out of bounds.
+        // Overflow is only possible on 32-bit.
+        #[cfg(not(CONFIG_64BIT))]
+        align_mask
+            .checked_add(self.len())?
+            .checked_add(nbits.get())?;
+
+        // SAFETY: `bitmap_find_next_zero_area_off` is safe to use with an out of bounds `start`
+        // value and, given the overflow check above, never reads beyond `self.len()` bits.
+        let index = unsafe {
+            bindings::bitmap_find_next_zero_area_off(
+                self.as_ptr().cast_mut(),
+                self.len(),
+                start,
+                nr,
+                align_mask,
+                align_offset,
+            )
+        };
+
+        (index < self.len()).then_some(index)
+    }
+
+    /// Finds a contiguous area of `nbits` zero bits at or after `start`, aligned to `align`.
+    ///
+    /// Returns the bit index of the start of the area, or [`None`] if no such area fitting in
+    /// the bitmap exists.
+    ///
+    /// The returned index is a multiple of `align`.
+    ///
+    /// # Panics
+    ///
+    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and `start` is out of bounds.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::{
+    ///     alloc::{AllocError, flags::GFP_KERNEL},
+    ///     bitmap::BitmapVec,
+    ///     ptr::Alignment,
+    ///     sizes::SizeConstants, //
+    /// };
+    ///
+    /// let mut b = BitmapVec::new(64, GFP_KERNEL)?;
+    ///
+    /// assert_eq!(Some(0), b.next_zero_area(0, cv!(8), Alignment::SZ_1));
+    /// b.set(0, cv!(5));
+    /// assert_eq!(Some(5), b.next_zero_area(0, cv!(8), Alignment::SZ_1));
+    /// assert_eq!(Some(8), b.next_zero_area(0, cv!(8), Alignment::SZ_8));
+    /// assert_eq!(None, b.next_zero_area(0, cv!(65), Alignment::SZ_1));
+    /// # Ok::<(), AllocError>(())
+    /// ```
+    #[inline]
+    pub fn next_zero_area(
+        &self,
+        start: usize,
+        nbits: NonZero<usize>,
+        align: Alignment,
+    ) -> Option<usize> {
+        self.next_zero_area_off(start, nbits, align, 0)
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
+    pub fn set(&mut self, start: usize, nbits: NonZero<usize>) {
+        bitmap_assert_return!(
+            start
+                .checked_add(nbits.get())
+                .is_some_and(|end| end <= self.len()),
+            "Area `start..start + nbits` ({}..{}) must be within bounds {}",
+            start,
+            start.saturating_add(nbits.get()),
+            self.len()
+        );
+        // SAFETY: The area `start..start + nbits` is within bounds and a `Bitmap` is at most
+        // `i32::MAX` bits, so the casts are lossless.
+        unsafe { bindings::__bitmap_set(self.as_mut_ptr(), start as u32, nbits.get() as i32) };
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
+    pub fn clear(&mut self, start: usize, nbits: NonZero<usize>) {
+        bitmap_assert_return!(
+            start
+                .checked_add(nbits.get())
+                .is_some_and(|end| end <= self.len()),
+            "Area `start..start + nbits` ({}..{}) must be within bounds {}",
+            start,
+            start.saturating_add(nbits.get()),
+            self.len()
+        );
+        // SAFETY: The area `start..start + nbits` is within bounds and a `Bitmap` is at most
+        // `i32::MAX` bits, so the casts are lossless.
+        unsafe { bindings::__bitmap_clear(self.as_mut_ptr(), start as u32, nbits.get() as i32) };
+    }
 }
 
 #[cfg(CONFIG_RUST_BITMAP_KUNIT_TEST)]
 #[macros::kunit_tests(rust_kernel_bitmap)]
 mod tests {
     use super::*;
-    use kernel::alloc::flags::GFP_KERNEL;
+    use kernel::{
+        alloc::flags::GFP_KERNEL,
+        num::cv,
+        sizes::SizeConstants, //
+    };
 
     #[test]
     fn bitmap_borrow() {
@@ -642,4 +792,91 @@ fn bitmap_copy_and_extend() -> Result<(), AllocError> {
         assert_eq!(Some(17), long_bitmap.last_bit());
         Ok(())
     }
+
+    #[test]
+    fn bitmap_area_set_clear_find() -> Result<(), AllocError> {
+        let mut b = BitmapVec::new(128, GFP_KERNEL)?;
+
+        assert_eq!(Some(0), b.next_zero_area(0, cv!(5), Alignment::SZ_1));
+        b.set(0, cv!(5)); // Now contains {[0, 5)}.
+
+        assert_eq!(Some(0), b.next_bit(0));
+        assert_eq!(Some(4), b.next_bit(4));
+        assert_eq!(Some(5), b.next_zero_bit(0));
+        assert_eq!(Some(5), b.next_zero_area(0, cv!(5), Alignment::SZ_1));
+        assert_eq!(Some(8), b.next_zero_area(0, cv!(5), Alignment::SZ_8));
+
+        b.set(8, cv!(8)); // Now contains {[0, 5), [8, 16)}.
+        assert_eq!(Some(16), b.next_zero_area(0, cv!(4), Alignment::SZ_16));
+        assert_eq!(Some(16), b.next_zero_area(0, cv!(4), Alignment::SZ_1));
+
+        b.clear(0, cv!(5)); // Now contains {[8, 16)}.
+        assert_eq!(Some(0), b.next_zero_area(0, cv!(5), Alignment::SZ_1));
+        assert_eq!(Some(8), b.next_bit(0));
+        assert_eq!(Some(15), b.last_bit());
+
+        b.set(60, cv!(10)); // Now contains {[8, 16), [60, 70)}.
+        assert_eq!(Some(60), b.next_bit(16));
+        assert_eq!(Some(69), b.last_bit());
+        assert_eq!(Some(16), b.next_zero_area(9, cv!(40), Alignment::SZ_1));
+        assert_eq!(Some(70), b.next_zero_area(0, cv!(45), Alignment::SZ_1));
+
+        b.clear(62, cv!(6)); // Now contains {[8, 16), [60, 62), [68, 70)}.
+        assert_eq!(Some(62), b.next_zero_area(60, cv!(6), Alignment::SZ_1));
+        assert_eq!(Some(61), b.next_bit(61));
+        assert_eq!(Some(69), b.last_bit());
+        Ok(())
+    }
+
+    #[test]
+    fn bitmap_area_exhaustion() -> Result<(), AllocError> {
+        let mut b = BitmapVec::new(64, GFP_KERNEL)?;
+
+        assert_eq!(None, b.next_zero_area(0, cv!(65), Alignment::SZ_1));
+        assert_eq!(None, b.next_zero_area(0, cv!(usize::MAX), Alignment::SZ_1));
+        assert_eq!(None, b.next_zero_area(1, cv!(usize::MAX), Alignment::SZ_1));
+
+        b.set_bit(0); // Now contains {[0, 1)}.
+        assert_eq!(None, b.next_zero_area(0, cv!(usize::MAX), Alignment::SZ_1));
+
+        b.set(0, cv!(61)); // Now contains {[0, 61)}.
+        assert_eq!(None, b.next_zero_area(0, cv!(4), Alignment::SZ_1));
+        assert_eq!(Some(61), b.next_zero_area(0, cv!(3), Alignment::SZ_1));
+        assert_eq!(None, b.next_zero_area(0, cv!(1), Alignment::SZ_64));
+        Ok(())
+    }
+
+    #[test]
+    fn bitmap_area_off() -> Result<(), AllocError> {
+        let mut b = BitmapVec::new(64, GFP_KERNEL)?;
+
+        b.set(0, cv!(5)); // Now contains {[0, 5)}.
+
+        // The area plus align_offset starts at a multiple of the alignment.
+        assert_eq!(Some(7), b.next_zero_area_off(0, cv!(8), Alignment::SZ_8, 1));
+        assert_eq!(Some(5), b.next_zero_area_off(0, cv!(8), Alignment::SZ_8, 3));
+
+        // A zero offset behaves like next_zero_area().
+        assert_eq!(
+            b.next_zero_area(0, cv!(8), Alignment::SZ_8),
+            b.next_zero_area_off(0, cv!(8), Alignment::SZ_8, 0)
+        );
+        Ok(())
+    }
+
+    #[test]
+    #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
+    fn owned_bitmap_area_out_of_bounds() -> Result<(), AllocError> {
+        let mut b = BitmapVec::new(64, GFP_KERNEL)?;
+
+        // Should be ignored since out of bounds.
+        b.set(64, cv!(4));
+        b.set(62, cv!(8));
+        b.set(usize::MAX, cv!(1));
+        b.clear(usize::MAX, cv!(1));
+        b.clear(2048, cv!(8));
+        assert_eq!(None, b.next_bit(0));
+        assert_eq!(None, b.next_zero_area(64, cv!(1), Alignment::SZ_1));
+        Ok(())
+    }
 }

-- 
2.55.0

