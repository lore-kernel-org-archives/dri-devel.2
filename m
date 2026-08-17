Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E052BC5CFC1
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 07:04:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4380710E689;
	Mon, 17 Aug 2026 07:04:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="VF/nY8K/";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010000.outbound.protection.outlook.com
 [40.93.198.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 312F410E689
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 07:04:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lMofENZdsbxx3dox5i+m/IwYlexSSrM9JjWyXIYPaIunIQQqfJwu+lzlCHaT+wnZz+bFejcvGBamlO14RHFRsKNjmlBKnam1UOSP2jG6ZoimR3sxInC6BtyTYRTpJyK6AQIfU7vdds6TWjd6AvPuJhvUW08NLGlKN2BdvfRHv2lkc9VPLX06kJ8yE5xAgFYCXYcOgZgVqVZl2Q9Q1GGM+l0cqupSyC6qObeKzXSp5z69FPOmppshRkQ0lAwoB1loDkxgoo/4t8+Jw/2sXtM7kfFSjIGFxvuTRqMkPAKXVMjbzpfr5iuK0iDAoFOZ5ttDmAjV1VRZip+OQvT4lImuPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4CEEOyYYQXTbzEpKw2zMZEOe8DY1XbC0D12CuV6rbs=;
 b=nsVMysEdLjRjo5r0pSqX8Pvxn6fZlaiqyL2n334LeiSKLBHKbKtQ9VLQ5c3636GTuMdTIa8bKrn5jJEI1bomEc48GgAj0WK3RniSRvh4b/uzru3mPjBoWgsftHtyYR8zwwNSM7XehrtgL2nC2vybwqWBczCSMA+/NlABiUyXReIs5WsvYto8j0TDN8DLtenW40udVsn8oU+96r3dP69aiHRL1tb6/vJIsnm2WFhP5pLY+CCbMfm0RA657pC+Ro6SK6h3jKTNj4RGTFF40GbHO3zfLmW/hLQwk+1AQ9vbbm6wjZag0ie1G0ILsbG/06f4ej+3vOBXBy7rN8rGOaFtZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4CEEOyYYQXTbzEpKw2zMZEOe8DY1XbC0D12CuV6rbs=;
 b=VF/nY8K/WfA4suDb6CEZlrvk3felDSfr1LvuGr/EPbutfTy8qtIFwwFiVfr4A5DDk68RZh6vdyDX4WhgEPANNHDVMwwJBANntDuSg+EtOEbmuI2Hj5Bil6cLy96o+ViRmtQtJGdBAR/dk7kofOp3s0jNcnh2rVW1r4nFijaNOWsiHCgrcMw1iSMn7Jic8C+SZaTsMzt8ofzDBvkMfq+hT+h+KHVVIVXp7dZbhLf8NATpxpyQY9npnLr9QmVpv2o/bmkCv52mbItBJZdDf4pwLESJpTxvT6TVbUStLASyz1XN1SfZi8Of6W+bVDICA8vUbdYkFQ2D48vtZBJH0A0i1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by MW4PR12MB6732.namprd12.prod.outlook.com (2603:10b6:303:1ea::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Mon, 17 Aug
 2026 07:04:26 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 07:04:25 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 17 Aug 2026 16:04:15 +0900
Subject: [PATCH v7 01/10] rust: bitmap: use function-level cfg on kunit
 test
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-chid-v7-1-a5872e64d8f4@nvidia.com>
References: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
In-Reply-To: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
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
X-ClientProxiedBy: TY4P286CA0078.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::19) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|MW4PR12MB6732:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b32c9c6-5e8a-4bf9-cfa4-08defc2dc5d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|1800799024|366016|10070799003|376014|921020|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: H3yO5vbBpIHlAn4PYICmyWDA0MamkudLJtx26iKBEm96lNM4XsmDyS8tA+zPDP3b0p8F+gDSK4x2A6YFK9xv7V/uPNMU1p0PhImxRcojpWgCgAtBmrUpK+z1abmniI/k4lxrF3InM5UjQl0lMcDqXFwS2w+HjmA6bcXCaAokEswiMAbPk9pQcy7Wz5ZiXrv33At0b1zZLh2gidcMDvJVoO/HexZwxqCoAQ0uQ5A0msICjiVEZ38aLyiuIz2bT6q2XuEYPV3wzdE9uDQkX25DNYqR+vSuP8M/AQ7FMgDd1OPn4IC9apJ2eqXE0fRH79A95VPErwCYTzH8Kbnfdhh9fSb/t273v5p+cQsuwbwh5sGQStGIgUcq3Xw7sGHj15E1bPOLKBuesht9z31brofBEIgYfJMjeCBcQNhygIXPu5AB/Z7wxGOIz90geo3q/+w0rRx22+hgxD/2U0VRhZS9mlpmo8+6hkF6POYO5s93LjJUohj9s8/BcsjzWnQJcEfcrFXPn0u9et+q0jspLqJ3OiVhNjBZYv30Gg26x6L8j8RDdXX+TiY+4/Uoe4YHynvD5ImaivtdQw6Ag2VL4snf9SfAZJ7ks5KPLXJUdtwaZFR1iHhv8HY5M7VgPRMuZ1PQ7yCvIygVFIx1YVOExxFVSq54dRlvGuxOBDQPbhjCv0r5OvGKzI4xelgV6ykET7pDsRUtgJDXz7HTn03H/2CREw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(1800799024)(366016)(10070799003)(376014)(921020)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2VzbVIwR3VkOGJ3dUNNbVRLYXdDam9Yb211YktpSURaMmFDN3pIQmVwTXE1?=
 =?utf-8?B?dlFiWmxsOWhlMW9jUHdQdU1BU05zcmlhS2F4d1puMVIvV09DcVIzaE1zd2Vj?=
 =?utf-8?B?THUxY3FPN1liWUFlbEIwdlQzOG5Ba2ZSaUVCQ3A5QzZkUi9QMkR3U0pRUVJQ?=
 =?utf-8?B?ZytvTGZ0SE5xUkFGTGhMbSs4VURncHdSeElodUR6SXgxaFI2TGFiZVdzWklt?=
 =?utf-8?B?RWRyb3hOZlo4YmlCcE5LRXdqYk1aVWdMczd6dCtPS04rNWl2VXNqb252NW1Y?=
 =?utf-8?B?d0YyWm94VjlndCthMGN2bC9JTFRid1l0YzI0eGtPRHNaQ1ovb3pHTWl0dmZJ?=
 =?utf-8?B?WHBNVXB4TlhSd1J5cWtuQkwvVnB2bllncEpERG9TQU5sZEVVVytDZnhqaTNR?=
 =?utf-8?B?WUc3bmhNdWQ5aXNSN3ZlSG5SdHN0d2x3QjVBM0YvZnBzOUZwbDlFeGEwSDI3?=
 =?utf-8?B?VEJ3TXV0R2JnSDM3VmhhMC93SHphNXFtSmx4UFV4MVBGb3BsalE5TUVLVUM5?=
 =?utf-8?B?TU5rZEYyR0NsUXhQcmdUT3F6UTJiS1JwTlFvMmtEUVFqcGRiYVhlWGhOVjU4?=
 =?utf-8?B?UnVMNmxBYld0bEtYckJPekdzNnhPQlN0TkZBbG12KzBZZmxUa1dQSE9ma2VJ?=
 =?utf-8?B?QjU4a2NaODNzMis5NGRMQTVKR3grY3ZtOTFkd1VyNUFWcHBmc1lXOVZhUk9N?=
 =?utf-8?B?RHhRNXFSa1BGMlFlMGMyVjdGbCtjWk5DYkRSZldxc2N5RTc4NkJTZTd6dVQ0?=
 =?utf-8?B?b0tkQ3p1RWlZaTA5a3dnSk9JeW9MYVhvaHBHNDBwTExMY1hJSEc3VnhYTTlj?=
 =?utf-8?B?a0g4Q3NBVFlwd2h0TUJHbmNDRTVVNlJmWFp0L05aQzdrR1hDOXVYaFpRY2o4?=
 =?utf-8?B?TTVBUmc5RW9IVitGUXVFcHYycmxuOWRDaHNCRm9UbWJaa2hyOTUrNU5RK0pr?=
 =?utf-8?B?di9LYlZJd0JSdFFmUEhjSlpicUlaZDNMczR3cloyZ2RobUcrRjVRQjVjYldy?=
 =?utf-8?B?UXJCbXBVZXAwYVpUMnVUeG94OG1zNnpSM1A3NU5QZzJlK0FOODJnL21tSStD?=
 =?utf-8?B?azdNd3c5LzR0Q3hEZHd6V0I4b3hVNUxKeFlneFdTY0FiNHJVZjAyOHZmVXBq?=
 =?utf-8?B?NjczR0xpRjcxTGkwV3hZc0tCRDR0VW4yTEdVQndEaXJmNFlENW9uMURRTk05?=
 =?utf-8?B?bllJTzFrV1FrNHd0TXppWnE0amNvQWpXMEZqNk0yNDdVcHdLZFRoWjBwOXRJ?=
 =?utf-8?B?TTc2TTc1QVp2eGFZd2k5TC9Xc1M3TnpEcXFDUnJ0bnZiL2NGcUJIdk00QWEw?=
 =?utf-8?B?TFB1ejZNNlpRTUhXRzIzTTdPUkZJWjFmQll6K2VWK2g5eVlCdzhLWCt5L2x6?=
 =?utf-8?B?OGFHMVVpN1pVRGhrUFI4VU9TTjlEelVBQ2FWKzJlemQ3MlF4Uk9RMVU5bDM5?=
 =?utf-8?B?OXBxa0dndTBFdmJBRjRnNlQ5ckc3VW14bW8wNEZibVI4SC9uLzR4bEpHWnUz?=
 =?utf-8?B?MTRnUUU3YU1jdVlub29CSG1NVmJFNHBCRk1qWm1lbXowZ2lNUzlxc3F5aEE4?=
 =?utf-8?B?ZzNNQkJYMVkrbjhrMmd0VHZ3RkhiTHNnRktpdUVCdUxvVnhxcjRCMTFjb0k2?=
 =?utf-8?B?cUVKajFvZmlwZ28zNml6MFNYOHRRZVhqSDhHV0lGOWJheU1OY08rd1dzRGk5?=
 =?utf-8?B?Yks4azlPNC8rRmJBUjRxdWRnZlJ0WWVSUDhEbGRmV0tObFZ5NHBvRnc1R2JY?=
 =?utf-8?B?WkNVRm1tS3hkaktpNzRBeHBCdFdHaFFNVVN0Y0xPR1RtVGlYN0NhSk52SE5B?=
 =?utf-8?B?RDZFT24wZnVzMVlSZ0NWTWNxMjRtVm43dStOMm56S0dsWUtyNWdlTDQ3b0t0?=
 =?utf-8?B?TUhmTzNIL2JSNlBJbWpDSFE3c2wrOW8vbjJhZUY2WjgxbXIvZWovb2wzZTlo?=
 =?utf-8?B?SmVIOEZBWGZXWU5HRittbFNuZ01QT1hpR1ZYRjlwR21xZS9QaWE4Tm5PTEdY?=
 =?utf-8?B?bUVzR3o1MlE3d2x6eW50T1Y1SlEzcWxjTjRZd3BtaXROYVJxUnUzQ1E4WmpL?=
 =?utf-8?B?MGtiYXl1Y2R1bzJXcktjM3Y0UmtZUG1CU3FvTzJUd2cyOFpEblkrRjVxQkJh?=
 =?utf-8?B?NG9NTitQOTJZeUdaU2d4NHZta0xpZHU1WmlKdmw2ZGpHNy81S2U2ZldHVEZm?=
 =?utf-8?B?cVV6TFEydTFtNmNnaTdiUXdhUVBhQU9TR09pUSt6SGJUdjBIVWYySi9QU0hK?=
 =?utf-8?B?Q2wwV0JqcjUxdi9jZThCRlpTelNpcXpicWVNaW4xblM0K2pOc0ZjbzJpK1U2?=
 =?utf-8?B?eFlKQ2hjODhqb3Bjdmk0YUJKeS9iem1yVUdyR2ppZGMxcVhlTVRMd0p2MHpx?=
 =?utf-8?Q?eq2S5orffmCAz4EVnl5LNvW8ViZFglWtdzRsduIwbedLe?=
X-MS-Exchange-AntiSpam-MessageData-1: iCeBv6ndfUMmjg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b32c9c6-5e8a-4bf9-cfa4-08defc2dc5d9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 07:04:25.9088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BDcWYyKJ2/78aiWPW0SaMWu2wU1vY/zBo8BgbbTDRZUbHiTfGPt9x1ILVSh2WnSi7XcGSqatb4aKHzneLw4cqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6732
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

Since commit c652dc44192d ("rust: kunit: allow `cfg` on `test`s"),
we no longer need this workaround.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Yury Norov <ynorov@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/bitmap.rs | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
index b27e0ec80d64..a43bfe0ec3dc 100644
--- a/rust/kernel/bitmap.rs
+++ b/rust/kernel/bitmap.rs
@@ -572,24 +572,21 @@ fn bitmap_set_clear_find() -> Result<(), AllocError> {
     }
 
     #[test]
+    #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
     fn owned_bitmap_out_of_bounds() -> Result<(), AllocError> {
-        // TODO: Kunit #[test]s do not support `cfg` yet,
-        // so we add it here in the body.
-        #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
-        {
-            let mut b = BitmapVec::new(128, GFP_KERNEL)?;
-            b.set_bit(2048);
-            b.set_bit_atomic(2048);
-            b.clear_bit(2048);
-            b.clear_bit_atomic(2048);
-            assert_eq!(None, b.next_bit(2048));
-            assert_eq!(None, b.next_zero_bit(2048));
-            assert_eq!(None, b.last_bit());
-        }
+        let mut b = BitmapVec::new(128, GFP_KERNEL)?;
+
+        b.set_bit(2048);
+        b.set_bit_atomic(2048);
+        b.clear_bit(2048);
+        b.clear_bit_atomic(2048);
+        assert_eq!(None, b.next_bit(2048));
+        assert_eq!(None, b.next_zero_bit(2048));
+        assert_eq!(None, b.last_bit());
         Ok(())
     }
 
-    // TODO: uncomment once kunit supports [should_panic] and `cfg`.
+    // TODO: uncomment once kunit supports `#[should_panic]`.
     // #[cfg(CONFIG_RUST_BITMAP_HARDENED)]
     // #[test]
     // #[should_panic]

-- 
2.55.0

