Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29BF1C61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 07:30:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48B1A10EECE;
	Thu, 27 Aug 2026 07:30:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="DnDqlGHh";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010051.outbound.protection.outlook.com [52.101.201.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CF1F10EECA
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 07:30:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njSZWQtXWi4V6NV5uk1MNIgzCXSn7t3jrrW/rqADGpYO6L6uy4wTtea6+imXmCIABS9lK2Yl60fyP0JI7/4q27+J3I/rSx4q+G0QrRqhimrwMWoSxsg1ISGJpULgW5UO/jQlv9muSd5iMF72eutbEFUP0FM3H2S0PKX0LHLsBYUJ0mfcQ9aU2v5PkXkLVFRUF4kQKvHZkiE5S6JU/D3aa/Cu3dtkcKxTyL4nPy/84RNEvEKNRgchXxW3INMPg8xUNBzmCfojFmiPTgmAqjEoTOWMV2XrKxS1GcCbbaFjY4HeJtEf1I5+Cbm6ZTiyP3Jq2MICJq0pfR8AQFOHnRJuew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vv+SQPi3gHtp8gmvjW3PQLcX00eggQ7Eu4WRxiTh7RA=;
 b=KuwpW4fjvl4CJCW+5PG5ztceS0h3BeQpph5O8uiwcgGm3Tqfko501GQw21Fsi5D4X/Wr665zA4dmaTE61ledm5hDsNSQXp1QvC2pIN6QBOQiohvCJ/5fcxplElZwsiUhMJIupN6n/wEfqRrikMUtKDPpDS2x/DUzg2Y1Pvbj1cA1fJC82LFQP5HiFB7Fo545VCmj+H+EbOQu7RRqE6VZpN2r/rtFb03afPrVkEhiS1+Yp2GDjn++J59TWnfV1y5u5K2+Y2TTJWWxa2+oxoazJ9iYzUl+gAWZe6ouok4sPAR6Hb0F7LNjokasYESSG5vOdyjn59VZrHJUTvt/x9q6Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vv+SQPi3gHtp8gmvjW3PQLcX00eggQ7Eu4WRxiTh7RA=;
 b=DnDqlGHhj+nt2IhtpShNBqTc0245Bg2/E323hS2qs+Bau5wglczaZONj+yQXidJ5nKFO+OhcTBgYNluTfPyaX/LanszVAkofEaoJb3a2+g1aa/9a3q8KQ2nJeoogbG8taazJvP+6D10MBh9O6uWJz5TXY5/P/pkvQ0R8Dbyh5VP8QC7nZFlU5j3utQnqb+zR+tdEfqKW9G38jVXPgxa745D09yuDvRL8MWQ/372l0eSwReI/bra3ecUuHwXZjJWLdaAnuZ89HJKKjkQSP/DNbI5D/MiP69vwMxDnSsXXMnG3xVzXKzkwPF/ChetHd3HfjB0yvVUiROESZaeZPRYgrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 DS0PR12MB999081.namprd12.prod.outlook.com (2603:10b6:8:2ff::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 07:30:37 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 07:30:37 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 27 Aug 2026 16:28:33 +0900
Subject: [PATCH v8 05/12] rust: use cv! to build Bounded values from constants
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-chid-v8-5-bc74c77d0214@nvidia.com>
References: <20260827-chid-v8-0-bc74c77d0214@nvidia.com>
In-Reply-To: <20260827-chid-v8-0-bc74c77d0214@nvidia.com>
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
X-ClientProxiedBy: TYWPR01CA0002.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::7) To IA1PR12MB6411.namprd12.prod.outlook.com
 (2603:10b6:208:388::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|DS0PR12MB999081:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e433d0d-1c24-4cc0-67d0-08df040d166a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|7416014|366016|1800799024|376014|56012099006|10067099003|18002099003|22082099003|11063799006|921020;
X-Microsoft-Antispam-Message-Info: MdPBKgBNyFqfZLmrm8aA6Zm6jYnzNVTvolHrn9Wckd60t+FQ0AoUX0Hovc2R2NcgPzFpk7lIn9w0ghI/650K6hjemQkYMDNawyv9KJLlZRcJdaCTaAPRNxdPGMooPmkvTpvlZDIbL1G/owH2DurQ3flRFEqn3UuXVmvBZtWzdOShbZcpq2wPvTIhH7se2G62kUKLiJnfgRaeiEvT69Un9gQc97quz6MWDjMYB40Gm89N2fiKrpDsyKvT8Z4a57vFLU3gW6Epcof1tNxv+tco3WguoQDFdIjCUg7jizsOwMWDCYk/Y3H4gD0PTiAjEJt21L0s0vyDOz8kmZ3iwboyxUPRWzSsIn8T+63AYVmTJnrsG4BGOYy/ylJ3Rk96F1cCckWtW6apwFK6+Ga4RV8J91e6gaXQgbVKUDHl3cd5Ji071f8/mmp2nYl7Mxdn6PZ33o1YGq3w9mxrLu2l29REUyBSgk32GtnUeDhczdr1L0eOifS+nva2LEj11w/NYs5Et4oQ2OfKh+CBIKNIEM50oGJnlAUjCmYJsMp6Bw5VIDBkg4XLjGsAgZlPrIj9/ng8Ekl6BU90QYrYLKaoGZGoDpP7STrYetaErOLQSpsmoCuSV7OuXeO+ZWQPI+sJF2sJeqjTV/vzru/F4vRuydFmOxtM0iIS8z4ungFmHLUhRykvwjpqi6esaU0KPtWhyZJDxr4ga2qVRTmlIIFtgL2Khg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(7416014)(366016)(1800799024)(376014)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXRjSnZ6Qzd6b3I0QURvc2hlWEg3QjFmSTlRU3Uyd29QRlFER2gxcEFMWXpE?=
 =?utf-8?B?citabnMydVlwZTZJbDdxUFZKWGUyTlArYVBoM0F3WEh5U0JXZVY5K3AxTWNW?=
 =?utf-8?B?VmZLckovcmt6YjI5c0lJY1h6Uzd0cUdZdkpzNmxLaGVWdXBrZGx0alFUM1ZO?=
 =?utf-8?B?OVZFejBybmhnRFdSMFVLRFpCQTVwdUZHNkJpby9DTlFuREw3NElZMm1MUlUr?=
 =?utf-8?B?SU9FZFRMUUF2NkEvZW5RTnl0OEpPRk9PVDNMUlo0V09YWU1ZejI0VlpGVUlZ?=
 =?utf-8?B?eGRtL0JaNnNCQ284RUNsTzg0RnJiWE1MMXdDVHFhdXN6MGFSRmVDYUhuUWRp?=
 =?utf-8?B?MXlqZStzQ0pqWlJwL3krbXN6dE9ZcUVOU0dVOC8vOFBuMlVOTmpQQVAyeUs3?=
 =?utf-8?B?b3FIU3VvenRvdHRUb0lCa2tZWU03SVhBdThCbS92SkR1RVNTWWtlVjc3eGI4?=
 =?utf-8?B?VFhaRk9SSTM4R3Awamkwek8wdFlESUVlMmFOVktGelFMU3YvU2lFTDRrQUcr?=
 =?utf-8?B?MERzSjNWYU1NaG8yZVVRV2I1SGExMndrRjFrNmlyeWl0Y1ptSFFkTjVsSVlu?=
 =?utf-8?B?UG0rd2JDbWZjdXQ4L1BtQnVSZGRYd2VWNW4waUdTTUxLblgydEpXTVpxMURs?=
 =?utf-8?B?M2dMUmF3YVFibzJ3VlZDT3A5QkUza1dJaGloOGUxd2sxMW1HdUE5S2g5YjBz?=
 =?utf-8?B?M3NndE84elVLZEcvMm1OVGpiektXS09IL2hBdHp0TGVwZmFtSUwyaE14UEdI?=
 =?utf-8?B?bUdYc2VYQWIydGlxSUJPL0NxdUpQNU5zeFBtRXlRUjMwVHhqZ3ZlUDFvRzk2?=
 =?utf-8?B?Q2NaOU9lQlJqNmNpeWRPTUxWbldnNUlTd2pSVXBYcnBIdUNveTVXc0V4bnVp?=
 =?utf-8?B?Y3NWd0lCQ1MwcGhTODZjSkRhR0FuTUtOU2NoOEZ6R1JYYm1YTXVsYldVVTZv?=
 =?utf-8?B?UHRpS3BuWWlhNXg1Q2szdE42eG80TlNpQUFCNUl5aFBjcVhnL2tlSGVRTUlh?=
 =?utf-8?B?YkhmMHhoMmdTRzhJYTlvQ3NTbjVUa2ROSFo0aXhCZytYdDhMRFZyWmhTYzBR?=
 =?utf-8?B?c1ZmT2NQRXJINW9haEFWOVJCYU93My9YLzVkQ2h1NW56YVQwOWhDNE05dHNt?=
 =?utf-8?B?cXEzdUJtYWx2TWlMVm90c0hkTVhIejBROHE5aDNtWDBGWHlaUy9wOGN1Y01L?=
 =?utf-8?B?T215cStoMkt5VGdkTURyamFub1FpZXZMbDE2RmRXS1Z1ZGg0WkhmblJQZjAr?=
 =?utf-8?B?RjF1SjgrMHNta01JcDlqeU9KMW9oem8yaE1CNFhzRVdtaStLdndTdmFMSTd2?=
 =?utf-8?B?QzVXOUptZWdjT0FVdE94cnRIOTNwZnovR1BybnZhaFI2NS91Ym96QnpQeWNU?=
 =?utf-8?B?Y3psR2FBQ3F0MGFmVmpMNi9CblJTU09YTVRUZmFPdG5IK25ZRnRkdTFkRGp6?=
 =?utf-8?B?Y0VPdVdIZmlmTTNqMkJmcVh4TTFmSE9uNmlsMUxZSEhHMHVUWitFR2NscERG?=
 =?utf-8?B?cmRSM05XbkYwQ0dkS0huMmdNckpVWDNtd2V1L09qcEsvZUxxOEduNDlKQ2tI?=
 =?utf-8?B?TGJqbEVtVTduYlU5U1BmVGVUTnJWSDV0MVg1QWFQK0IyUGc4eDZLQzRQWStL?=
 =?utf-8?B?amJ6NkdGUUJJQXRhSHpuMkxVZzVaRXhhSVlXNERRYlhtT1B6b1Fkdk1vMnlX?=
 =?utf-8?B?Q2Q0R20wMDFFU3RPam1oYitJcTZxeFZyUVZmYmFhZy8rZzBiMGF2T3VXTkZC?=
 =?utf-8?B?OW5Gb3A5RWx4Wm1GakYzRzd6UHZkcENtd2hPQm01T2x3S0lOMVI1NzJCb3po?=
 =?utf-8?B?VVp5aXA5SGE0dXMzRnNlRWwvWnVrbkpVS1ZQZ2VHS2FHT2FOM0w3dGp4QlZ2?=
 =?utf-8?B?N3c2cndYdmc4ZzlQL3pEeTZQcnRPTit0bXI3MTRKclhOOWQyYUVRaDFYOWVW?=
 =?utf-8?B?VkF6cU53M2Z2aDRLWnlKUVBvU1pxbm5TM2tOMzFPYlRjU2pPQkNteG94dWhL?=
 =?utf-8?B?L3U1NDVkT1BaWGhNb2Z4T1BycUJpUUN6d0orNVFpRElxeXlNdDhnbEsvN1hy?=
 =?utf-8?B?a00yNE5CTXBNSGlTTlR5aUMrMEZyZUg2dzRMUXNCcittQ1JhdmdFZEpLZ2Z0?=
 =?utf-8?B?NmIvRExpVmhna2VQdzNOWUdlcE01ZzR5WktBTUhNNGVSd29QVWxzbEFWN0ph?=
 =?utf-8?B?SDY0Q2RYS0o5d3ZJN0VSTDFYMzMwdWt2cERkcld6aEJPWUY2a2V6Vitab2ZU?=
 =?utf-8?B?TzNLY29QclBrb25IVzl5N2lscnZGdFl4Qm1ISlMyTHdhYWtieVdja2p6UWNh?=
 =?utf-8?B?blhTUXJaMFh3enkyZHJuelFDdU1kaDVXdklkZ2F0aDlJVTMyRS9NTlRRdTc0?=
 =?utf-8?Q?LMtbrm75M09XcXXsvdkVF405ALFESQ0XCPN36IJ9PSRO1?=
X-MS-Exchange-AntiSpam-MessageData-1: NHaHh8GLqFIvLw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e433d0d-1c24-4cc0-67d0-08df040d166a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 07:30:37.0637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t//yDdEcbRdXb1Ggi7sLNsTnvmE3UqyzMbMBobU1BWS/p3wtu5v0YxVK83ZQ1kgXnF+ZHLGKz20cnnahb/rEuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999081
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

There are some locations which use Bounded::new() which can use the new
cv! macro, so convert them.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/num.rs | 3 +--
 rust/kernel/bitfield.rs      | 8 ++++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/nova-core/num.rs b/drivers/gpu/nova-core/num.rs
index 6eb174d136ab..03a7e7b3ff8e 100644
--- a/drivers/gpu/nova-core/num.rs
+++ b/drivers/gpu/nova-core/num.rs
@@ -240,8 +240,7 @@ macro_rules! bounded_enum {
         impl core::convert::From<$enum_type> for kernel::num::Bounded<$width, $length> {
             fn from(value: $enum_type) -> Self {
                 match value {
-                    $($enum_type::$variant =>
-                        kernel::num::Bounded::<$width, _>::new::<{ $value }>()),*
+                    $($enum_type::$variant => kernel::num::cv!($value)),*
                 }
             }
         }
diff --git a/rust/kernel/bitfield.rs b/rust/kernel/bitfield.rs
index 35ede53f2b8e..5331df986579 100644
--- a/rust/kernel/bitfield.rs
+++ b/rust/kernel/bitfield.rs
@@ -21,7 +21,7 @@
 //! }
 //!
 //! // Valid value for the `blue` field.
-//! let blue = Bounded::<u16, 5>::new::<0x18>();
+//! let blue: Bounded<u16, 5> = cv!(0x18);
 //!
 //! // Setters can be chained. Values ranges are checked at compile-time.
 //! let color = Rgb::zeroed()
@@ -229,9 +229,9 @@
 //! impl From<Mode> for Bounded<u32, 2> {
 //!     fn from(m: Mode) -> Self {
 //!         match m {
-//!             Mode::Low => Bounded::<u32, _>::new::<0>(),
-//!             Mode::High => Bounded::<u32, _>::new::<1>(),
-//!             Mode::Auto => Bounded::<u32, _>::new::<2>(),
+//!             Mode::Low => cv!(0),
+//!             Mode::High => cv!(1),
+//!             Mode::Auto => cv!(2),
 //!         }
 //!     }
 //! }

-- 
2.55.0

