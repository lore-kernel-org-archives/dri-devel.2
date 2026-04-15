Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75954F428CE
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 19:58:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 897DD10E747;
	Wed, 15 Apr 2026 19:58:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="dvxF3rvC";
	dkim-atps=neutral
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020081.outbound.protection.outlook.com [52.101.196.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC8D110E18F;
 Wed, 15 Apr 2026 19:58:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHin922yTK7lyWBpYmVQuwAWzsaKPKxosvP5Iahc43Cl4gcgeh+kl6fjnPspDFyFRrttC+PFpJ4r/3/tQn1bU9+BB7j7+tuZZprY9V4HTTf10C5LXgzooqmvL+Iix8NxJ92ziq9wqZpUYU+IKr+grzt1GItfjwlvSeaVbqoQeV39kuYgepedZLYSWTH7myPL0sdz2jPvbTSR1FM8rhOgPa1JxZw/ullSxTrixqBEN/6Tz8LLLDBawggKnO7Z9OPAEUcYDpVv/j/y/todAqWIIET+LGlGN6qV4xXuiHjwBQEupM9Z1EtjNndhCP824e/FwCHED9Vny81UHRCUaso9Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VijXKOez8JTXMULaaSBbV1rN3Xbqrnh93V3PKryyH1M=;
 b=XbDjhCkZ0d6ami9/k6o4pPlTeQVEo+pWto8Wgk3B9SM7OGawPTrxhxFDX+jVxYbiMOoIQn+bsxJh/eeA2BoGjyCmJvUIscTn0/ITMxmMk9uBNcfl5h0+3N3kJd2a3InIZT3qxB1Iu5Om+QVa5Sq8gfaQNE7h1huwDebaAIyLgQ0zNAh94c32OfMjLKiHHqxKLJ1X14XJ91bH1O6gWgnGk/ZkHuPhOkduy/mvg1GmszR0xN5KoILmHf5kcGhN+BKPF81SG9YWiYem/mfJAbZAFK5d59XUxpmUGE2hRFdzJmNck0Ffp144OPRA2cn8QHFkagrb7uGvw/3yJKpoAKWPyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VijXKOez8JTXMULaaSBbV1rN3Xbqrnh93V3PKryyH1M=;
 b=dvxF3rvCavCD00NB1QKgbPPZ/myBv0ZObJWJ10GXmiCRNss6haV4nsZjhY+jh68k0g6uZSPKlONwplrc0/+tw2NygId5u0M0l2k0QPOrOdPuDH2gKp2mjnEqIbIrM2PNla8i5TSbUc6hFwDKoMgF5uW5fFyPG1Oq+m9nEpggei0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB1910.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:32::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 19:58:07 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 19:58:07 +0000
From: Gary Guo <gary@garyguo.net>
Date: Wed, 15 Apr 2026 20:57:15 +0100
Subject: [PATCH 4/5] gpu: nova-core: use pointer projection for command
 queue code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-projection-syntax-rework-v1-4-450723cb3727@garyguo.net>
References: <20260415-projection-syntax-rework-v1-0-450723cb3727@garyguo.net>
In-Reply-To: <20260415-projection-syntax-rework-v1-0-450723cb3727@garyguo.net>
To: Danilo Krummrich <dakr@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Alexandre Courbot <acourbot@nvidia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Gary Guo <gary@garyguo.net>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776283085; l=8687;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=3TvcefFkmp7SinnBoGCfQImBR8tVtz38PnzWPJ/7XgQ=;
 b=bX/mQCL+8UnTRSligegKb+kaVbYMdqfHiCmIe3gDbLwwU/NrzOlHoFzKp3fDB+QGvT2XjUgus
 rrW+o8Cp62uA+UOVO4VO2f2shwSYBaifV6xH4fX0fUKpqN535FsuYiS
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0276.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::11) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB1910:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c30c28f-c652-4b44-97dc-08de9b29501a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|7416014|376014|22082099003|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: C0ukyxpKbRIWaeOB+adwSY9rixGbDSJOI7nNvXX1kGdSZndYHVWdCtmmn6S9G7T2/byBMzq62kXumbCudrSGxjLM5kFitPm3kbo1HxoyD7WBUSKmA4NGDgT9JzFVRRxjUNWpyGIrx2ah9RdWvUj5MzUk1Ke6gOua0SFpsN9wg0mUzxTVkWqGZRmcYa/RGHZCaLkU1jq85NwZHr7jdlRIZ8U9rcerNcJNzUqVgF0ZsPXdmjk7X0RCXR2yndB1wv5Ss9q7gS6/WjUecD4MWIrrVx/QrrrNiq1vN7HpeGCPG2/1d6rcAZVFciMtai4hFSGyVv8g3JHteyscX9aamzWNtF44h/xSRtaxXwV3y8aOOa132sSKiRfbPPNOZolgO+UR17Ha102gU6o2SSNHxif1lF1fqJ27AV1RKg2tq37Hpkon4JAN4h38FYObqrUWpgUIZDxvBsu8xTez33FUV5by9bb0YhUAPaFcqJVib6xYtae/kg9guq4LNH4tYneXzPhd+CF6ABEuWyTUcl8GZtNDPOqralx8ElDJ7IOhoq8rFJbEj2KrVaT9tPGUmdJJN97D3ko/MJXMfUinnOpMDOM2hyaE6oR8wY5YbZn85IQZDjtX2ieKhphaRmVE1z1Ywpb2arjc3ibwi3M6uvkZsFIWSqx/H5FSHbySaZdN89nYqtHPQUhgiOyXJfQO2wCNGA3lidjMYYYenVQSPoIkf7FPPU1FxLWUea021y5aZdY6p5+VOitOVMrs/Pn0GTPjVeWduC1kJybuAQlL3r9V1lLAkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(22082099003)(921020)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djNLTnNnOG12QjRQT0p6d1dwdUgwbU90S2MxUzRzcXdaZG1OSUlOUXM0QzZx?=
 =?utf-8?B?K0ZmMElsZlQzbkhUdGxyVjREV2VhZkEwSzRuSWtDSXQ0dmJ5MkdkalV0NTZC?=
 =?utf-8?B?ZkpDWXp0Q1NubHloazkvTlhMbkRHTmtYaElwbnpySzVyS1Jzd0tpa0g1S3l6?=
 =?utf-8?B?Z2VJRGRGVUJOV2YwcHg3MEZtT2lEZndFSlExWmtwR0FsQnEwUjhaaFA2T2lr?=
 =?utf-8?B?VFF0NTFkdW9PQ1A5LzRIY25IejNiV0cwT21aVFVjVC9mVk5EbEkrL2xnT2py?=
 =?utf-8?B?clF6bkNoS0VjV3pWZldMcmxHTU5wcXJ5WG1Kb1ZUTE8vRWVsNXVqMnpPYkYx?=
 =?utf-8?B?UUFiaG54WlVNdUJWajMwSHMzTUJsTStxSlFxSHVtRnk3VGlNS3JFckJEUnhN?=
 =?utf-8?B?WGlPM0twWGpLcHZuVnZyUlBOTUpIV2ZQeC9LVU5BOHpnSld2SmJHOTd3L1pP?=
 =?utf-8?B?Nk82VnozTlFLUDlxLzVHRzM3MVFZNHh6ZUFwUjc0VzlIa0RLSmpUbnV3THFQ?=
 =?utf-8?B?bFVCcUlmcTN3Zm42Qlk4a0QvZmFlemM1MGQ5NWtpZjNyVWJYeDhDNEYzUHV0?=
 =?utf-8?B?M1J1YmlkZG54S3IwR2t1emtoY2VSRWRQSUZYZ0FyT3pDVlorMjYvTjhyRnRw?=
 =?utf-8?B?eGxNdlBUc0dyNmt0RTNMV1p5YWo5OVlNaFcvZFdFcEJpa0RXNkd2b2NzdkVt?=
 =?utf-8?B?SFVuZzU2QVREY2Q5L0F6UG5UM2tSYU5YRVhOWTV2ODZnc2NwejZLY0k0Ry9j?=
 =?utf-8?B?TFNiWHVnaDdyemZSY1JncEJ2RmgxdjZFSlBMaEFpUUJuQ1M3TUpYWmZ6cDlC?=
 =?utf-8?B?VVlUaXhGN2hYSDhWVEhtRGF6OHFpRUFOT3NwTERZV1hYM3BicEV2NXJONE5L?=
 =?utf-8?B?RU04VlgwWERzRC9NOTRBRUN3eUFTMFN3ZCs3VGs2QnQvZXRIM3RSQzdMVEE0?=
 =?utf-8?B?SkxWQ1BiNEZHRGpZRmNhQnpkZlVQYlU5TGdUSFNRZkFJUGFrMldrT2NscVQr?=
 =?utf-8?B?R29wL3U2Y2FjcURSVlhuelhNYWs2d2VZS2J0SUM0SlVGSFpEeUxhZmErZjhU?=
 =?utf-8?B?QWF3S0VBcmVmc2pIRytyendZYlhNMEFtcGJsb0VyRHFrbjk2MG5EeXJjajVj?=
 =?utf-8?B?MGZUaDY0Znd3SmJVenBJRnhFQWFDd1RPWElyZEM2V3R6U3BubzRWVU9nSUpT?=
 =?utf-8?B?SGVGa2RyWEVHNWpZaitVNGdyQkVBRU9TRnRTNzh3K2xqSEJtR2VNK2dNUjlC?=
 =?utf-8?B?aC90bDAzNElVK1ExbTYzblQ2U0ZFRi9iQWNsemViUTQ5dk9kZ1NpVU9odUVt?=
 =?utf-8?B?ck5JdG1KcXNkbk5OQ1dKaDJ4YjBPYjk2RmRxd01IOFdyMmo3NTJWdVA3Tks1?=
 =?utf-8?B?dlNPNDZnS085NHJEOWZUQ2hsREFuaGxFMW9XcHIrR3F1MmpteGpDTnNBWUZE?=
 =?utf-8?B?QUJ0aEhlL1JJUFpEaHh2ZnBLbUlPbTBMWk8reXU5MURncFF6Ui85MWRwanBs?=
 =?utf-8?B?VG9iejIvR3d3Sjdkc0VXVFFhdzZtM3AwVXJXZkJYYTdOU21VTWlmc0dJNERn?=
 =?utf-8?B?bUFzZG9FbUlMVDlCZVEzaXg0TkNqak4vRy82WGx0VUpxczVJVm5xckxDMHUv?=
 =?utf-8?B?aGdWb09mekRkUndNOFk4TE5Vb05NKzh0SDRFUzRkandJZ0tJaFNJOEhlZVJz?=
 =?utf-8?B?K2Erb0x2VkJ0SUliQy9PdmY2eUZ3S1grZXB2QmZ5cHVoQVJqOWd3SmNuT3JO?=
 =?utf-8?B?akJjNHdUWnlsZTFjUHNYM1dpUzlWOHRURFNqTWtLaXY3UW5iZDNHd3hQelNl?=
 =?utf-8?B?SXZiaStGaUFXc2VFbHVsMEVmUW5pWVpNY3U1bHVwVGt4MVYram5lR1JRRVZZ?=
 =?utf-8?B?TzdES0lrUFMwTlBMTWFhZUNtRnBwcHBSYUt3MThlWVZTejNNdEhySkc4bjBu?=
 =?utf-8?B?S1JMQW1DS0VrNTAzNkVYSkN0endFby8yTVFxNWpjNllDOXpIUGZsWmhHbzdE?=
 =?utf-8?B?eld2WmFlZytmYUtiSVhYOXRMOWxrLzA4eElKazhXSHJBVEZYazZJTzZlTHFk?=
 =?utf-8?B?enUveVpVb3gzNUthYm43OU9oYmg5MEREdXJyMHNVUTFoc1RVQTRZV3AyekRQ?=
 =?utf-8?B?R1lzRVp1ckV1QmhWY1VyaDFXWWdMV1lBOEFGK2RrdTNRazdiekcxWDNXaEh3?=
 =?utf-8?B?UUhCMmFOL0YybURmTXE2dUUxVXJ5dndiUVVhdzRpUW1TSzJxc2I4RGtINWpG?=
 =?utf-8?B?SWlPOGlBdUhBQVN6TVpGUkpvajNGbExOZVVkVjRkQldNM0lHOXdYdFFTWE4v?=
 =?utf-8?B?SjVoMkxEOVQ0VjhRcjJzVjNxWG9lM2UvQ3pFU1dsOWowMCtYdlRwdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c30c28f-c652-4b44-97dc-08de9b29501a
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 19:58:07.3725 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HALnzlO/VhvmQ4I7lB/Ic4n5BuHnGcXOvKfULkwqniYap7KY5HTwTcILRj3+F2AIHOKTfiU0CcdmNGuLLlg6jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB1910
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

From: Alexandre Courbot <acourbot@nvidia.com>

This has been previously attempted but missing compiler optimisations for
older LLVM versions cause build errors. With the panicking index projection
variant implemented, replace the manual pointer arithmetic with projection.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Co-developed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 106 +++++++++++++++++++++-----------------
 1 file changed, 60 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 1c9b2085f5e4..0b51e10e2cfc 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -256,47 +256,60 @@ fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
     /// As the message queue is a circular buffer, the region may be discontiguous in memory. In
     /// that case the second slice will have a non-zero length.
     fn driver_write_area(&mut self) -> (&mut [[u8; GSP_PAGE_SIZE]], &mut [[u8; GSP_PAGE_SIZE]]) {
-        let tx = self.cpu_write_ptr();
-        let rx = self.gsp_read_ptr();
+        let tx = num::u32_as_usize(self.cpu_write_ptr());
+        let rx = num::u32_as_usize(self.gsp_read_ptr());
 
         // Pointer to the first entry of the CPU message queue.
-        let data = ptr::project!(mut self.0.as_mut_ptr(), .cpuq.msgq.data[build: 0]);
+        let data = ptr::project!(mut self.0.as_mut_ptr(), .cpuq.msgq.data);
 
-        let (tail_end, wrap_end) = if rx == 0 {
+        let (tail_slice, wrap_slice) = if rx == 0 {
             // The write area is non-wrapping, and stops at the second-to-last entry of the command
             // queue (to leave the last one empty).
-            (MSGQ_NUM_PAGES - 1, 0)
-        } else if rx <= tx {
-            // The write area wraps and continues until `rx - 1`.
-            (MSGQ_NUM_PAGES, rx - 1)
+            // PANIC: per the invariant of `cpu_write_ptr`, `tx` is `< MSGQ_NUM_PAGES`.
+            (
+                ptr::project!(mut data, [panic: tx..num::u32_as_usize(MSGQ_NUM_PAGES) - 1]),
+                ptr::project!(mut data, [build: ..0]),
+            )
         } else {
-            // The write area doesn't wrap and stops at `rx - 1`.
-            (rx - 1, 0)
+            // Leave an empty slot before `rx`.
+            let end = rx - 1;
+
+            if rx <= tx {
+                // The area is discontiguous and we leave an empty slot before `rx`.
+                // The write area wraps and continues until `end`.
+                // PANIC:
+                // - per the invariant of `cpu_write_ptr`, `tx < MSGQ_NUM_PAGES`
+                // - The index `end` is non-negative because `rx != 0` in this branch.
+                (
+                    ptr::project!(mut data, [panic: tx..]),
+                    ptr::project!(mut data, [panic: ..end]),
+                )
+            } else {
+                // The write area doesn't wrap and stops at `end`.
+                // PANIC:
+                // - per the invariant of `cpu_write_ptr`, `tx < MSGQ_NUM_PAGES`
+                // - `end >= tx` because `rx > tx` in this branch.
+                (
+                    ptr::project!(mut data, [panic: tx..end]),
+                    ptr::project!(mut data, [build: ..0]),
+                )
+            }
         };
 
         // SAFETY:
-        // - `data` was created from a valid pointer, and `rx` and `tx` are in the
-        //   `0..MSGQ_NUM_PAGES` range per the invariants of `cpu_write_ptr` and `gsp_read_ptr`,
-        //   thus the created slices are valid.
+        // - Since `data` was created from a valid pointer, both `tail_slice` and `wrap_slice` are
+        //   pointers to valid arrays.
         // - The area starting at `tx` and ending at `rx - 2` modulo `MSGQ_NUM_PAGES`,
         //   inclusive, belongs to the driver for writing and is not accessed concurrently by
         //   the GSP.
         // - The caller holds a reference to `self` for as long as the returned slices are live,
         //   meaning the CPU write pointer cannot be advanced and thus that the returned area
         //   remains exclusive to the CPU for the duration of the slices.
-        // - The created slices point to non-overlapping sub-ranges of `data` in all
-        //   branches (in the `rx <= tx` case, the second slice ends at `rx - 1` which is strictly
-        //   less than `tx` where the first slice starts; in the other cases the second slice is
-        //   empty), so creating two `&mut` references from them does not violate aliasing rules.
-        unsafe {
-            (
-                core::slice::from_raw_parts_mut(
-                    data.add(num::u32_as_usize(tx)),
-                    num::u32_as_usize(tail_end - tx),
-                ),
-                core::slice::from_raw_parts_mut(data, num::u32_as_usize(wrap_end)),
-            )
-        }
+        // - `tail_slice` and `wrap_slice` point to non-overlapping sub-ranges of `data` in all
+        //   branches (in the `rx <= tx` case, `wrap_slice` ends at `rx - 1` which is strictly less
+        //   than `tx` where `tail_slice` starts; in the other cases `wrap_slice` is empty), so
+        //   creating two `&mut` references from them does not violate aliasing rules.
+        (unsafe { &mut *tail_slice }, unsafe { &mut *wrap_slice })
     }
 
     /// Returns the size of the region of the CPU message queue that the driver is currently allowed
@@ -318,39 +331,40 @@ fn driver_write_area_size(&self) -> usize {
     /// As the message queue is a circular buffer, the region may be discontiguous in memory. In
     /// that case the second slice will have a non-zero length.
     fn driver_read_area(&self) -> (&[[u8; GSP_PAGE_SIZE]], &[[u8; GSP_PAGE_SIZE]]) {
-        let tx = self.gsp_write_ptr();
-        let rx = self.cpu_read_ptr();
+        let tx = num::u32_as_usize(self.gsp_write_ptr());
+        let rx = num::u32_as_usize(self.cpu_read_ptr());
 
         // Pointer to the first entry of the GSP message queue.
-        let data = ptr::project!(self.0.as_ptr(), .gspq.msgq.data[build: 0]);
+        let data = ptr::project!(self.0.as_ptr(), .gspq.msgq.data);
 
-        let (tail_end, wrap_end) = if rx <= tx {
-            // Read area is non-wrapping and stops right before `tx`.
-            (tx, 0)
+        let (tail_slice, wrap_slice) = if rx <= tx {
+            // PANIC:
+            // - per branch condition, `rx <= tx`
+            // - per the invariant of `gsp_write_ptr`, `tx < MSGQ_NUM_PAGES`
+            (
+                ptr::project!(data, [panic: rx..tx]),
+                ptr::project!(data, [build: ..0]),
+            )
         } else {
-            // Read area is wrapping and stops right before `tx`.
-            (MSGQ_NUM_PAGES, tx)
+            // PANIC:
+            // - per the invariant of `cpu_read_ptr`, `rx < MSGQ_NUM_PAGES`
+            // - per the invariant of `gsp_write_ptr`, `tx < MSGQ_NUM_PAGES`
+            (
+                ptr::project!(data, [panic: rx..]),
+                ptr::project!(data, [panic: ..tx]),
+            )
         };
 
         // SAFETY:
-        // - `data` was created from a valid pointer, and `rx` and `tx` are in the
-        //   `0..MSGQ_NUM_PAGES` range per the invariants of `gsp_write_ptr` and `cpu_read_ptr`,
-        //   thus the created slices are valid.
+        // - Since `data` was created from a valid pointer, both `tail_slice` and `wrap_slice` are
+        //   pointers to valid arrays.
         // - The area starting at `rx` and ending at `tx - 1` modulo `MSGQ_NUM_PAGES`,
         //   inclusive, belongs to the driver for reading and is not accessed concurrently by
         //   the GSP.
         // - The caller holds a reference to `self` for as long as the returned slices are live,
         //   meaning the CPU read pointer cannot be advanced and thus that the returned area
         //   remains exclusive to the CPU for the duration of the slices.
-        unsafe {
-            (
-                core::slice::from_raw_parts(
-                    data.add(num::u32_as_usize(rx)),
-                    num::u32_as_usize(tail_end - rx),
-                ),
-                core::slice::from_raw_parts(data, num::u32_as_usize(wrap_end)),
-            )
-        }
+        (unsafe { &*tail_slice }, unsafe { &*wrap_slice })
     }
 
     /// Allocates a region on the command queue that is large enough to send a command of `size`

-- 
2.51.2

