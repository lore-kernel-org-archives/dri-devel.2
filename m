Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F54BCA5FA5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 02:45:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD1E210F147;
	Wed, 30 Sep 2026 02:45:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZP+MKX3g";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011008.outbound.protection.outlook.com [52.101.52.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 761C910E9F4
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 02:44:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BuibJFQE/Rl2Lye3I1/S7p6/FNUIKlYf+6Oh9OQ1oW7IfACnRKR9hQ8xsGERc29kPPUkzH+Qm1lr2B8opddjZLMZWvMs1HrxFhi5btxDpPST03HAuHwnWO8w6tCecvUSxPQH4w2laR+Xo9gvCSO8QqrhbnmTOK2fLO4YACCi0ZazuX8S+Lt4XbXfRdbso3W57g+IC9iFQkdEZEIWX2yg1nrPhon7ZuvQM0Yzi+HjbMCPGK3hL7xWTDmOMG99XXGYLGOaR3aw2Ad7dLspCRHdgW8jJFYP4G9811URDjiyTfArB+FkDBjxxCwypRbjLkdKmPBrEP74a6wmHF3A45lLhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDwPtECw0jqvH+8BUByjuVTSQUOuw7KWZ4wgCaZrR0U=;
 b=uyjipCGFLTt0tarp5xqTiC+TFx3z3+oeB84pMMN/4DjkssevHjMZfvB7gGamUe8HPRooSsCoVq/JbqLpYnl7rV3s3BfMie/iQYSW+nUzUq3Lo91r0y0g4cdR2Ov9bZa5xo/LdtHvZuqfKvBvxziYuvoTuOL+qZ2kUMTi74ryvHV3uUjtVY3HKBELgRbQ4E3cX/idpuLVKJ87sDNm37bxvbQTWRV/Y/I6sCGmQRekqCoCLyBWCJYbbVo9lN2W+8lLHcL4Pg72kO26rN/Fy076ynlvY1eFVH/R69w94EOyPspeYvedwQ8u6lYBu8bS9Tq2wzPfvCYSaOYbxa/MbLUCmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDwPtECw0jqvH+8BUByjuVTSQUOuw7KWZ4wgCaZrR0U=;
 b=ZP+MKX3gAz710tCc9ip78TAkbzYUfrtA3IVVmwlPuooO9vpSAIfaeuBPzusWSAYx0CY93a+RmV3Kj/RvOsnrk/PVs/CVJmtCJgs2oZ/bDMT4/c0Nk7+p57BaPKA2oHkc5+cdg35jXNCCLXlcxVnzDMiZichRzaGOzHzlczwfKA1T23GR6xM2bNAxFRMURqe+R2S9r1xRns2f0fK+zXGRjl5eJgTfug8JkE/qkGxnkE0hXxToG/1oQeURjbrqXPUaix7DN3VbSbicqnmWpSWC/oDt6MubtOGYU7OEKez2A8skBphnhvrK37zxil+YTJF+euWFlURmJRV28TRANVGL0w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 BL3PR12MB6523.namprd12.prod.outlook.com (2603:10b6:208:3bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 02:44:35 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 02:44:35 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 30 Sep 2026 11:42:53 +0900
Subject: [PATCH v9 4/9] rust: sizes: implement SizeConstants for Alignment
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-chid-v9-4-0d6cca376cff@nvidia.com>
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
X-ClientProxiedBy: TYCPR01CA0202.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::15) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|BL3PR12MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: 206bb98c-d437-4bb6-0bde-08df1e9cc38a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|7416014|376014|1800799024|366016|10067099003|56012099006|921020|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: acPnZP2BlcIouwSgohWpVq2OUB36hciA3YdK9dC2z6fI+1BI4T0tHWxjtGz16L2KQafVurPjURiVNMKX0S/uwFwM80dchtvKQVQz23EspClfN+F1Ix8GK2GpDYxbYsaApjUATF07dmAVehghfUKBhJMsqjnNSMulHigLXCMIdi6RILyUgOOPEKa2TdPij/aWk9ED+ZyEPcm0mqHiUVxpgX8ilfyL2GD4H4Mo6OOWuz5qs9xbA3jCBb1wmCKwQyuhXCNSwTzKIRku4naltX1JfhOB17j+FNZdv6qmcr0VIvULfhpQ6pM6Rl46/07tklszWMvLCSLHidi1b7oOu7ZskepsG1+RbsunvwyRbxljavJ7B68JG4+43NG5JauAgPTdBzC4i959BB9eAZ4tir1/ZFwUhq/iHKLgsxNhLyFthxzAj8ADqXNxhzSmG2e6VQItsveC/ZvZ2pW1TE37zvAG5xn+M8gJqs9AYqsLcHgHnU1nnqiDiNdwojwWQRae/nPnf46lUytVml2W9h2hN4CTbaq94RprxAykHpCIsudpKzAz1cnKH9SsE2kkMIw54LfZ+oLwWwrmhgoD5CgcQYpBLKTHPKqfyB/tIbgz6jby8XxSTbF6Gb0ZpYeA4DffGJM0DZyvesBm1DjKaJw21q5+e1IhEILJi+uGMH5gDuNX4upB+/p/4PFvWm5FFWxW5ciAf495Amwt0tBVjoH6rVwQTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(7416014)(376014)(1800799024)(366016)(10067099003)(56012099006)(921020)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enNSY291eUR5TEJmTjRYN2p3cXQwWnhlL0V0aXBmcEpUTEMwOXh6ME5LK0FW?=
 =?utf-8?B?SGxOSFh5aUo1QXlGdXdKNkpSWmpjTThXdktKUmtLRFRicVJZTkkzbzhjTmFh?=
 =?utf-8?B?Smo3T2xaU1oxekRwcTlNTjk1Q3lKTEMrdHBYMnRZSzhMWWVtM21MYWlYTUtF?=
 =?utf-8?B?aXVzVUJvUitpZE16QWZDWktjZzZUS1VNVnZMSi81Ukt1YjBGRVo3dm1TTEVr?=
 =?utf-8?B?MTV0dXg4cnZTMjA2UVd5aStKamNTT09vYTlvMTc3VmN5elUwRmNkbnJjODZW?=
 =?utf-8?B?V0l5OU9XSDQ3NVZwY090eDd2ckFadTU3ZmhXcUs4TGF2amdXNUhsZWVNSHVU?=
 =?utf-8?B?WVJoTkdVd0RyNjFpbVpnMEVGTXRaanlVeHdsMmlEZXFoWG1NVFErbmtGUFZq?=
 =?utf-8?B?bTh5VGRHcXpLOEYxWnVBVWJ6MUR5eHVOSFNGdTBPb1JPK2xvMGpyWXQ5YjRu?=
 =?utf-8?B?QnZzaTVDdGYwbXE0U0k0c1ljUWxwNi9tcVZkTHFPMFd4UkxSZ2Q4NmdFMzJP?=
 =?utf-8?B?ZjhKVXlROEUvMjd1TnUzR1VOS3lCdGJ1MGNKamFFdFpLNjc5UDZoeSs4SnJQ?=
 =?utf-8?B?bXMxYlZjL0w5QkJZdzJSYXhQR0tWenBoYjZacktLaGNBZmY4blY4ajM1OUFp?=
 =?utf-8?B?R0pBaVNEaE95ZTNDdFR3UU5KSy9NMWJwejFKZUNkY2ppZGE2azFWNUFqRDZz?=
 =?utf-8?B?V0wvYmxCODVOb3BpV3FPYlBTUlAvUEJORmgybEhFOWFLZjdKQnZOUDg4QVg0?=
 =?utf-8?B?STl6TFptWFpTTEhsZUdwamt4ZGdPdDM1YUk0YVMxMlJLYjV0VG8wWE5GZjY4?=
 =?utf-8?B?VXFRSGcyZ01sdXJ6ZnE0cDNGRE1mVjFNVVNLeGc0eW5tZ0xJQUZZQmdIOHY1?=
 =?utf-8?B?OG1iQW9jZDJ5TFhzaHJiTDZCZTNoQ2pucEV5LzRkcjVaeVhSaUMwRHhTajdI?=
 =?utf-8?B?V2FqUkZ2VmZUZjRvUlcweUZaVTUrM1JVMGJ5KzdKVlg0RmhUNXdNdnNKUkJE?=
 =?utf-8?B?Zkd1VU41TkExNitLRmovSVBaK0hqV0hkWnBQUWxOT1Jha1FOQTJuS1B6WTZZ?=
 =?utf-8?B?QzBTOFRPS0k5UGRVWW16VFJaZm56UFNhNjBxNlo5MmdubDlLenVvSnc5MjZk?=
 =?utf-8?B?MlczMmFEUS9ZUlVvaFNCcERoRmVmT01VcGdQOHIzU29LKy9KYytQOU16UW94?=
 =?utf-8?B?UDhvbUVobHU2bUFTQ3ZXZkdrUHlxVVhQdnVmcWpYTkxhQk1xRGowcUZCSWJp?=
 =?utf-8?B?WnNvbUsxSVNhMWt0bnNTb0w1K1RUYUUzQWYzRXRLM0RVSXljaVYrN0o2R3lY?=
 =?utf-8?B?aXEva3JSb0ZRWHFjN2M1Z014Uk9ST1dBVlJ1SVpoRkJrSnJjUHFaWjRZNHM4?=
 =?utf-8?B?dnlBK051UzJCL2pxbEdadGdxWUlpbzZ0MXN1TWVtZXlrSldYczNRMW5WK093?=
 =?utf-8?B?c1F6VHYxdVdReTlQMzl1VVExTGkyL3lqTk10ZmhCR3oyNHNJWjdlRGlkYUZ3?=
 =?utf-8?B?NC9qV2N5ckJTSm9jZGpDV0pxc2N3QWVYbXJDQWx0M2xzcVFqWWVDN1Jqcnl1?=
 =?utf-8?B?N3A4TllmM2ZTV0pQOWRFT2hXK054NTZqTGpWbThKakpRQlNVdTlvbjNTYU41?=
 =?utf-8?B?T1JUU1QwS01kUE1SVTJXQkJuUGNKWDdtUE5wUm9VY1BLL2NGdThjdG9BV3Fk?=
 =?utf-8?B?VVhvb3B3eFI4S1lieUU2SElpT1h5bVBuZWYrejArQVZ5MDdzbVJ6MStRNjZR?=
 =?utf-8?B?ZzF6YjhOSEJ0amE5M2RFYlRGRm9WTjIwZEZ6QVdJVFF6T3lNYVczUWZGL0xm?=
 =?utf-8?B?ZS83VzVmU3VFcTlLWTFhSEduY0F1K29kSXUzNDgvQkdtZXBIRXBPSi93U2Iz?=
 =?utf-8?B?M1g5TEhVTjVVanhBK1JCL056L1pBNkpRRVZOZWhxMjkxU0wxdVMvSkI5Rzh5?=
 =?utf-8?B?ZjUwM0xSNW1HYWlPdzMvMXFKOWFzWWVCNjhqMGVjeC9iSG9OVzRHbFlRUkhh?=
 =?utf-8?B?eWh3akI3R1I4ZzN3RG8rb0NURnI3aGg3VGlNNktwaXJSM0c1L2kxYTFIamE4?=
 =?utf-8?B?bnZvS0QrQ2t1MTd2NGdsZlBzSnlYNjlpZjladDJ6U0xKMWEzaTFkbmhZcEZS?=
 =?utf-8?B?Q0JjK3BwYUdwNEk3ZDJkMldNM0RVZFZod0lML29neEFZSnE4clVmYVlaV0hv?=
 =?utf-8?B?cnNWSkozdFVQd3hpVXVIc2VvSktoTmxQTnZzQU9DQzNVc0xqNzFaclNSYnIv?=
 =?utf-8?B?ZUY5bXRYODZCZFNONkw5NTdFaWxTcE1IWUZXRnBmQ01KY2lML1pFb2h4Q2hM?=
 =?utf-8?B?dEpCQkZ3R3ZiaS9EVEtrYjBoRVFWWGNBQXk5cmNQZHFDMTk3QVg5R1o4Q3ly?=
 =?utf-8?Q?7jvO/eXm4ijorp3DoUbcBC3QEzl577aEzSSr+qOV5PJa2?=
X-MS-Exchange-AntiSpam-MessageData-1: bcPZHXN4lXCnmA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 206bb98c-d437-4bb6-0bde-08df1e9cc38a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 02:44:35.6010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b2CTCFFo/1wuAEYOtIU8VTEfM5pBkNEIwMIuEmMhccTlw8uY/w7thi0cNCqqzubGwH5A6VyyKIn3NlfT0/Z1lA==
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

Currently, constructing an alignment is quite verbose [1]:

    Alignment::new::<8>()

It's unfortunate because it disincentivizes using it at interface
boundaries. Implement `SizeConstants` for `Alignment` so we can write
e.g. `Alignment::SZ_8` instead.

Link: https://lore.kernel.org/an4xDp29VX8Am0uR@yury [1]
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/sizes.rs | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sizes.rs b/rust/kernel/sizes.rs
index 7d03361eae3d..188e00c2b8b4 100644
--- a/rust/kernel/sizes.rs
+++ b/rust/kernel/sizes.rs
@@ -13,6 +13,11 @@
 //! these constants as [`u64`] (or [`u32`]) rather than [`usize`], because
 //! device address spaces are sized independently of the CPU pointer width.
 //!
+//! The trait is also implemented for [`Alignment`], providing each size as a
+//! compile-time validated alignment.
+//!
+//! [`Alignment`]: crate::ptr::Alignment
+//!
 //! # Examples
 //!
 //! ```
@@ -105,6 +110,7 @@ macro_rules! define_sizes {
     (@internal [$($type:ty),*] $($names_and_metas:tt)*) => {
         define_sizes!(@consts_and_trait $($names_and_metas)*);
         define_sizes!(@impls [$($type),*] $($names_and_metas)*);
+        define_sizes!(@impl_alignment $($names_and_metas)*);
     };
 
     (@consts_and_trait $($(#[$meta:meta])* $name:ident,)*) => {
@@ -119,13 +125,22 @@ macro_rules! define_sizes {
         /// choose the width that matches their hardware. All `SZ_*` values fit
         /// in a [`u32`], so all implementations are lossless.
         ///
+        /// Also implemented for [`Alignment`], providing each size as a
+        /// compile-time validated alignment.
+        ///
+        /// [`Alignment`]: crate::ptr::Alignment
+        ///
         /// # Examples
         ///
         /// ```
-        /// use kernel::sizes::SizeConstants;
+        /// use kernel::{
+        ///     ptr::Alignment,
+        ///     sizes::SizeConstants, //
+        /// };
         ///
         /// let gpu_heap = 14 * u64::SZ_1M;
         /// let mmio_window = u32::SZ_16M;
+        /// let page_align = Alignment::SZ_4K;
         /// ```
         pub trait SizeConstants {
             $(
@@ -137,6 +152,16 @@ pub trait SizeConstants {
 
     (@impls [] $($(#[$meta:meta])* $name:ident,)*) => {};
 
+    (@impl_alignment $($(#[$meta:meta])* $name:ident,)*) => {
+        impl SizeConstants for crate::ptr::Alignment {
+            $(
+                $(#[$meta])*
+                // A non-power-of-two constant will fail the build here if used.
+                const $name: Self = crate::ptr::Alignment::new::<{ self::$name }>();
+            )*
+        }
+    };
+
     (@impls [$first:ty $(, $rest:ty)*] $($(#[$meta:meta])* $name:ident,)*) => {
         impl SizeConstants for $first {
             $(

-- 
2.55.0

