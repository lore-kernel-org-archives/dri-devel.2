Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A44BCA5FA5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 02:44:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F3BB10F00A;
	Wed, 30 Sep 2026 02:44:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="V1D0StSR";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013010.outbound.protection.outlook.com
 [40.93.196.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A65A10E9F4
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 02:44:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WKWMVpWq+ysJnZ86EYIvp9vzNoLY5WHkaPAOUtZ6D9VPma1BUJqlWpXwqDCDspndqv6o93YGAlRdBm2Qh4cFK5CBvqGSNdUnB2WBo97kOOAVW9eNPfkOegO3ck0Pb3GOn0Ydkh7LXG8iO89gmfPJY2BmaSpzR9u15tHnCOU2pGOmTXqfJJozL3qFz7G5aCE3kI2bFfURY6t/acSKhlYhJqE2zKSIPPVZyRoQMCdSFF7p7rz3VMDyCUHMsVAXNdO60QXQ8SRV0Enuoqkm04Ad5IUPI1W+24d0YKPVttZnglwK4iIeKvXf2F9XqMA9icze8TSPinaNU+1mP8JqRAAgEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5aLLm7ugufMFPvjCTovVkma4So9mGCQdTkhGB6v5r4=;
 b=XgffXd1nUtJYwYecPB4XJugnskLB8gJtuEMWEbvi2TS9UhBWgBkvCKXDdERl2aGbyp6o2a+tHQzjwXiMc0JGAmyzhF7WlF10XNJxzWjXnCx3ctMhYM9bj+20x+OIGF2ubCo7ZNdLh88PLBvMMbEplPUHSharVfON3ZzA3X+VB4RtMKChlzGujywUhVSfaibVhrP92ut1wVPnrV9+1EwGvtMYM4RdiudOCdpijMbCGh7os7zml6LFKlbYljD+yTqUH9ExwRXGf4m5cceu5GRkvYIghzhz27FJ/JKu8AAthZmyNBZrCYioMoNl2Xv8xTQC/RPIAt7ty9BHOTAK8h64iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5aLLm7ugufMFPvjCTovVkma4So9mGCQdTkhGB6v5r4=;
 b=V1D0StSRA1Z9fxHjk1UfRvCkvFM/hh+wx55cN5Axzz0uqSR7LMgg1SH7iNORnPF6Zo0AKdk7NDYrBV/4YtaUzQdIr9N7AQdYVgmZACwUlRwainSiu+knykVZ8xvU6jMDlmc8RzRkrx/v9bqv3NVRFsqp10NvbPd+FirpG+zDIcLVWy3Dk83HtVCb3KIMKVI2eu7Hqu1W9CiUI4b472uFEIBCkSriRs9nLllNiJnsw4l+dvW1oj1gj/BWLGtz4BglDeGAIPGZOLQNnf15jJMXXwx/853SnjyHG1wlc/fHmlvGGIQacn9U20yZuO/rBTGswxhip51KiUOaC3LamX1KQA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 CH2PR12MB4150.namprd12.prod.outlook.com (2603:10b6:610:a6::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.26; Wed, 30 Sep 2026 02:44:28 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 02:44:28 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 30 Sep 2026 11:42:51 +0900
Subject: [PATCH v9 2/9] rust: bitmap: restrict bitmap length to at most
 i32::MAX
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-chid-v9-2-0d6cca376cff@nvidia.com>
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
 Eliot Courtney <ecourtney@nvidia.com>, Yury Norov <ynorov@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0117.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::15) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|CH2PR12MB4150:EE_
X-MS-Office365-Filtering-Correlation-Id: d13e0115-eb85-496f-81b7-08df1e9cbf05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|1800799024|10070799003|366016|10067099003|56012099006|11063799006|921020|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: L8pGmxmM4ltewwqxmCFFtqyeDKsb1oOoZlFjzIfWar7S1uPokqBg7QRwQPMKxeItWWv4wwCcfMbSvYPA293sitHCDswV/8cfEY/0ErjgPPmKCgkcre5JiYAygsw9u69GAtJrdt1yJDZTgpnbiIT8shlfwoTVj2gZ5dtSGt09/td3C9MzpE5F5/0Bgp+j4wxziBHln7zQLofkB5q8omGoVIJVwFgdKspDX8vXtACc+I0+zrCNqt149fMA+2qxAU3iI9HaUoWBDIEYNuCBW+ZBs7ybhGAfTMx6nQ3Mnwto53rBiLYf9LPl1WFTBW4ljlZOwSHw3Sa6YgP6SqGss6Qhw8g7Q7ULHZI/MESTj1akWDIOVJdwIDM6m9eK036Li41LeiqRl7c5Hlps2r+gd1rpHVz+MV1A3F30AYsSxNvH+HwEVwwKSb4dHYIOap930+QjJbvjryACz9Cbk4sy3FMP6qoD6f5G99x1ooisYXzv8oDBCxQYqD9Ir4HGYOo6WLEk2XsjLbB1aymav6dnIEOOdhAsEaBxeTF/qKdbr22YhAlE0eznBxQNe+yCGoQKfTmHtQt5EP6N+zaX1VGTPgS37thieBCIojM4zH0Z5mYNSM3Dc6pnREMj18jP6PIYJhK0tecBegKuvEDOXVNOASE4WGj73IY3gFJRijQ5V9jxFf4/XNIcC7dbvTbpgoB3HWGNMoW8KbvmoPpjd0ebsuVudA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(10070799003)(366016)(10067099003)(56012099006)(11063799006)(921020)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDYyLy8yUmZOZUhRUWRiY1hCMGI0UmdwZHlFRGdTUnhzK2Zjby9ZT1kyYXFE?=
 =?utf-8?B?aFhpUVFIY1NDMCsvODA1RGNQa3RJbG1oLy90SUg4QVRMWi9HRWtjdjJ1Vmt2?=
 =?utf-8?B?RlpTc3prUFFOOTYwVC9BaGZRY2FSajErYTM3dERxRDYxRE11eGRKYnB5c0E0?=
 =?utf-8?B?MC84OWlqdVUrZzFVL01Dd05CaldVNHQ1cC9FZ3RlZ3pOcy9PVUVUc25MODli?=
 =?utf-8?B?ajd6RDJQRHlmL2JRVkJjbHJwRUx1NDBDbUdYN3d0bjIxdVVrTVlHcGNnelB3?=
 =?utf-8?B?K2lmU2cydU8wVDA4c0c1LzV2RWVHOXFwQ2RScytrS2R5cGdwQ2RuM0UzaTVh?=
 =?utf-8?B?OEZPd3NMZWlFcGFjTmJmTUwxaEdGRkRJcTI5dDhucEx2Yjh4aTIxQzBjWXlr?=
 =?utf-8?B?WS9nTzFYVyt5Vm9QWWdwWWE0QjFkOWhHL2p0TTREY3lFM3hKajhxZHlRRFla?=
 =?utf-8?B?Rm16eTB4OWRQVStUNUwwQWdiRFFubTRsMGdha3Q2REc0UDdZRGJoOG0yU1do?=
 =?utf-8?B?dy8rV2U0eDE5QnFlazk3UEtkNGlLYW92L1pWR2haSk1SV1BwYk8zT3REbzB0?=
 =?utf-8?B?S3lDSndtY2pVT0MzZnNYNEo1N1N0SHh4SnJQQlBXUFI2S3FWTTd0KzFCbEdj?=
 =?utf-8?B?d3JFM0xlSHc1cjdvSmgrdnM0SmEwVU92M3dUQjJQeno1Ly85UXFzbUpGL1hZ?=
 =?utf-8?B?UGwvM3gxVTl4WlZRcEwyRTZBMXpBKytSclZFUlBOQ09GZlVwNGpYcllFa0x2?=
 =?utf-8?B?VHpXUStTSHJEUmFlRTl0NHYvcFBsaUlNYTBDYytIODFuVTh4MDg3TnRKQURp?=
 =?utf-8?B?czI1aTN1VzdRRFBQT3hEUEYyYmQ0NTZ5eng0MDN5eEFaOWZ0MEhhTHJmWHg2?=
 =?utf-8?B?eUEyU1FBLysvUis5Q3oxZGUxOCtKaVZvWGplSFRFRkxGa0ljRERTWTgvSjBL?=
 =?utf-8?B?ekpFYUlSUGRWQkNvSFBFUjRYQlk2UzlDTkNwZ3VMZlBlWXExL00xeUdKUzQz?=
 =?utf-8?B?YnA4Z0hVWjZOYzQ0c3JYcjROY2pzcGJQdGczWVhoZnROa1NHRzdTeWVIU29J?=
 =?utf-8?B?MCtWQlE1TGtmOUFKbGhqNUJTeWgwVmtNVEJwdnZuSUZBbWVOQ1NuZ0FRdk1M?=
 =?utf-8?B?UVpVcU1pRTBWa2laVlM0bks3SVE0OHZtSmRudllmejYvOS81ZlpjVTFocDd5?=
 =?utf-8?B?NmtBZkVrYjM3Z05DOSt4OGh0YWJveTBITlJDRkJzdExCM1kvdGxKR29hRU1t?=
 =?utf-8?B?Q1FZclRKeVN6Nlo3OWpBSGxscmxxeEtwczZCKzQrNXFOanducjlmZ2ZxN2t1?=
 =?utf-8?B?azhLVVQrTmwxY1JXK1F0TjNUbXVaa1hkeFpDeDZubThjMUtlOW9mTWM3SXJ4?=
 =?utf-8?B?VklmQVVwczBRZDU2eTR2SytFWS9ocVNsWkxtL2wyL1lWNXRxN3NmMGxBSmVv?=
 =?utf-8?B?MTZsOGlURHMzTGYrU2MrLzlWVUtFMUVCMkpBOE9IREp2Wll0TmllUjNpcmcx?=
 =?utf-8?B?czlHZXlBM0FUbkJnTHdnbzFKZ3dvMUE5TDJia1ZweGhvUmNKM25JNzlrR0I1?=
 =?utf-8?B?U2hvbW9TKytGZnQ0cnl6aWcySUlCejF0WEZaaU5GcjdETTVxQWhPc2wrRkRw?=
 =?utf-8?B?OE9IRUM3OTJTang5NStmejU4dmRjMlhnQUFVQi9Na2tWZGpLM2FPYTVrUVJW?=
 =?utf-8?B?enRvc1FlcFBHS3NDWHhVOW00eXhSOTVROUh5UTFwQWR2Rk91RnJqcG5JU2M2?=
 =?utf-8?B?SUl5UkJoc2FTTk9XT2xCMjJQV1ZoWmphYkNGM0NjUmhaT1ZsdW1mb2ZLa21N?=
 =?utf-8?B?RmtVWkxZNGhLZTExcnJ6SWVwdEoycWVmcHMrTDJsSzdxUjZJb00zWTFTV1Zw?=
 =?utf-8?B?V05GRDlYUUtUV2p1UW5XZ1YvT1c1Lzlkcm11c0c0MTltRVRjdHlTK2Vta0pm?=
 =?utf-8?B?cmdJS1YrT3dEZUlxYkdaSWdlNDllUjRFeFZ3eVdWSkVhcWVmaUZFR0ZidHds?=
 =?utf-8?B?Umt3cXZzZnpjSkx6SWZnelhPWEl3WU1ITlRTVk0zVUF4V2tXMHNOQWFyS2pL?=
 =?utf-8?B?VXkvOWtReEhITWtUY2Qzd3czL2NvQ3orVFFmMml3YXRnMVdPcTQwYVY0QjlM?=
 =?utf-8?B?clU3eThYdDlsS0ZzS3hESW5UWTV4NVBUT1lhcHRwZXk1RTdGeTFCRVFwbWk0?=
 =?utf-8?B?Y015bEpuYnVFQjY2NkRBSmxYZVIrelQvdHpPL1FCVjNnVmp3VlZ2eERNSVBm?=
 =?utf-8?B?dlowRGI1MGhmd1l1QXRtWVgxb1g2MTdBUGk4WWhsbXk1RnZrczF1dTRvU0Zn?=
 =?utf-8?B?dGpNbXZRdzlUZ1hYRFg3VHFoUmhiakxlSkdhSmZQSW5MdTJHZXpBWHZ3SHNO?=
 =?utf-8?Q?xBUeMtsjPtIotTlZ7oUaqBojMWof3AnTLDbu87H84GCNo?=
X-MS-Exchange-AntiSpam-MessageData-1: eCbbFmYqM9jpJw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d13e0115-eb85-496f-81b7-08df1e9cbf05
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 02:44:28.0224 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hR2Dk/arrFoDyJQqc4ae8Q6lJ0hn3X/MvapnsOAM+dbV+vTA3rv54RufbP69oEp5CCjgrRgLugRXWWC7yKXzUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4150
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

It is currently possible to construct a non-`BitmapVec` backed `Bitmap`
using `Bitmap::from_raw` that is larger than `i32::MAX`, and it is not
part of the unsafe requirements. Restricting all bitmaps (even
non-`BitmapVec` backed ones) to a maximum size of `i32::MAX` simplifies
a few things and matches `BitmapVec::MAX_LEN`. For example,
`copy_and_extend` truncates `len` to u32, which is wrong for > u32::MAX
size. `__bitmap_set` and `__bitmap_clear` need i32 for `size` and u32
for `start` - so they can't be run on a `Bitmap` with a > i32::MAX size.
Rather than adding runtime checks to account for the case of a non
`BitmapVec` backed `Bitmap`, just include that in the requirements for
`Bitmap`.

Add that requirement to the unsafe requirements on `Bitmap::from_raw`
and `Bitmap::from_raw_mut`, and to the invariants on `Bitmap`.

This also fixes u32 casts truncating in `copy_and_extend`, which could
otherwise lead to OOB writes.

Fixes: 11eca92a2cae ("rust: add bitmap API.")
Link: https://lore.kernel.org/DKG0U8RLO7LZ.2I1AIH0S38PAP@nvidia.com
Reviewed-by: Yury Norov <ynorov@nvidia.com>
Reviewed-by: Burak Emir <burak.emir@gmail.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/bitmap.rs | 70 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 21 deletions(-)

diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
index a43bfe0ec3dc..df5505ec7a96 100644
--- a/rust/kernel/bitmap.rs
+++ b/rust/kernel/bitmap.rs
@@ -17,24 +17,59 @@
 /// # Invariants
 ///
 /// Must reference a `[c_ulong]` long enough to fit `data.len()` bits.
+/// Must not be longer than `i32::MAX` bits, so offsets and lengths used with
+/// `Bitmap` functions fit in the int and unsigned int arguments of the C bitmap API.
+/// This also matches [`BitmapVec::MAX_LEN`].
 #[cfg_attr(CONFIG_64BIT, repr(align(8)))]
 #[cfg_attr(not(CONFIG_64BIT), repr(align(4)))]
 pub struct Bitmap {
     data: [()],
 }
 
+macro_rules! bitmap_assert {
+    ($cond:expr, $($arg:tt)+) => {
+        #[cfg(CONFIG_RUST_BITMAP_HARDENED)]
+        assert!($cond, $($arg)*);
+    }
+}
+
+macro_rules! bitmap_assert_return {
+    ($cond:expr, $($arg:tt)+) => {
+        #[cfg(CONFIG_RUST_BITMAP_HARDENED)]
+        assert!($cond, $($arg)*);
+
+        #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
+        if !($cond) {
+            pr_err!($($arg)*);
+            return
+        }
+    }
+}
+
 impl Bitmap {
     /// Borrows a C bitmap.
     ///
+    /// # Panics
+    ///
+    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and `nbits` exceeds `i32::MAX`.
+    ///
     /// # Safety
     ///
     /// * `ptr` holds a non-null address of an initialized array of `unsigned long`
     ///   that is large enough to hold `nbits` bits.
+    /// * `nbits` must not exceed `i32::MAX`.
     /// * the array must not be freed for the lifetime of this [`Bitmap`]
     /// * concurrent access only happens through atomic operations
     pub unsafe fn from_raw<'a>(ptr: *const usize, nbits: usize) -> &'a Bitmap {
+        bitmap_assert!(
+            nbits <= i32::MAX as usize,
+            "`nbits` must be <= {}, was {}",
+            i32::MAX,
+            nbits
+        );
         let data: *const [()] = core::ptr::slice_from_raw_parts(ptr.cast(), nbits);
         // INVARIANT: `data` references an initialized array that can hold `nbits` bits.
+        // INVARIANT: the caller guarantees that `nbits` does not exceed `i32::MAX`.
         // SAFETY:
         // The caller guarantees that `data` (derived from `ptr` and `nbits`)
         // points to a valid, initialized, and appropriately sized memory region
@@ -51,15 +86,27 @@ pub unsafe fn from_raw<'a>(ptr: *const usize, nbits: usize) -> &'a Bitmap {
 
     /// Borrows a C bitmap exclusively.
     ///
+    /// # Panics
+    ///
+    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and `nbits` exceeds `i32::MAX`.
+    ///
     /// # Safety
     ///
     /// * `ptr` holds a non-null address of an initialized array of `unsigned long`
     ///   that is large enough to hold `nbits` bits.
+    /// * `nbits` must not exceed `i32::MAX`.
     /// * the array must not be freed for the lifetime of this [`Bitmap`]
     /// * no concurrent access may happen.
     pub unsafe fn from_raw_mut<'a>(ptr: *mut usize, nbits: usize) -> &'a mut Bitmap {
+        bitmap_assert!(
+            nbits <= i32::MAX as usize,
+            "`nbits` must be <= {}, was {}",
+            i32::MAX,
+            nbits
+        );
         let data: *mut [()] = core::ptr::slice_from_raw_parts_mut(ptr.cast(), nbits);
         // INVARIANT: `data` references an initialized array that can hold `nbits` bits.
+        // INVARIANT: the caller guarantees that `nbits` does not exceed `i32::MAX`.
         // SAFETY:
         // The caller guarantees that `data` (derived from `ptr` and `nbits`)
         // points to a valid, initialized, and appropriately sized memory region
@@ -96,26 +143,6 @@ union BitmapRepr {
     ptr: NonNull<usize>,
 }
 
-macro_rules! bitmap_assert {
-    ($cond:expr, $($arg:tt)+) => {
-        #[cfg(CONFIG_RUST_BITMAP_HARDENED)]
-        assert!($cond, $($arg)*);
-    }
-}
-
-macro_rules! bitmap_assert_return {
-    ($cond:expr, $($arg:tt)+) => {
-        #[cfg(CONFIG_RUST_BITMAP_HARDENED)]
-        assert!($cond, $($arg)*);
-
-        #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
-        if !($cond) {
-            pr_err!($($arg)*);
-            return
-        }
-    }
-}
-
 /// Represents an owned bitmap.
 ///
 /// Wraps underlying C bitmap API. See [`Bitmap`] for available
@@ -415,7 +442,8 @@ pub fn clear_bit_atomic(&self, index: usize) {
     #[inline]
     pub fn copy_and_extend(&mut self, src: &Bitmap) {
         let len = core::cmp::min(src.len(), self.len());
-        // SAFETY: access to `self` and `src` is within bounds.
+        // SAFETY: access to `self` and `src` is within bounds. Both lengths fit in `u32`
+        // because a `Bitmap` is at most `i32::MAX` bits, so the casts are lossless.
         unsafe {
             bindings::bitmap_copy_and_extend(
                 self.as_mut_ptr(),

-- 
2.55.0

