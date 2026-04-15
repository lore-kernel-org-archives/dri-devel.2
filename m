Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C4FBF428D4
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 19:58:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDE5310E771;
	Wed, 15 Apr 2026 19:58:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="cbqrHZsu";
	dkim-atps=neutral
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020081.outbound.protection.outlook.com [52.101.196.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1692410E18F;
 Wed, 15 Apr 2026 19:58:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bqKyx3tps78lKZGeaZtQlfH9tXg44GBlIwG/D+Puf9A8k1IihrY+j3DhkVt9otz52QuBem96eQeVbO2fSzLyHyeoa/yeItzcD4JmU6/f75ZcFdU4cwlF9WSofPmG371zt0ORw5tFlhL2fbLv7weziFpeYCe0jhVOV2njWDyCCsjIYzA5NIiBcz6aqeytCsU43qa5Gw+G2BLQdFbXQLvX06p9g9TENC2sLsrx3BcshF1oPqixXYvvAiUkenpoiFMUFezZcgJrS+h6SKSmrUwhUXAjz1urvONe0mmzY5LgsdI36T8yzGmLtgKNwzir+kCRnXZdGaxxSJpmWJ9JojnOOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkuGSN8Tzs9O7o8HsV+r4BP4flEu/cuHTywGn45uTPw=;
 b=YbitpMC4v0qwGO5X9VpEqh0AAmN/RurXUbjFbUIncITBfyKdvD7wZ/6kIxI6tqTJMNBAIVYRqyM/TTlr5UidvWYkY2rXm0CxQY0w/QnM5T7pINUMAsIm9GrXxtr1iD7zgHMgUenEv8ymVapbfQOUZYhrRArBIBLvC+ekq/yjd2gG5/U6OyyT2G2mxwEcC9eMhilTES/1HGBHeizeQCiPzEusHUn2PyEyc9GEQf6kLZHS+/8SsxcjMiqg2K/TdVvTRRbwcnmBf4JPfq/KFxpkJ/OdG+rHJQKJUeBRhAcdWAJvW6sXBwPrRDdC5+wHVR+c3pcXyOQOEnRDiCDBwRfZxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkuGSN8Tzs9O7o8HsV+r4BP4flEu/cuHTywGn45uTPw=;
 b=cbqrHZsuKZKGwxp7tXgx5lWmVc/nml2JOh9yaxwfMAhgzmjDDicLnZUXCNCQ0Yj0XpipJ0MpSvN8mnWvuqVMlNWKgL2SqPqKUp1Ca1wgTesc0WqyZmo2T6xtVAt0lYfLWz7b4M4BLVKI0eOQULEK48EQ0UtPoY8jklOXors93Ac=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB1910.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:32::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 19:58:06 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 19:58:06 +0000
From: Gary Guo <gary@garyguo.net>
Date: Wed, 15 Apr 2026 20:57:12 +0100
Subject: [PATCH 1/5] rust: ptr: add panicking index projection variant
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-projection-syntax-rework-v1-1-450723cb3727@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776283085; l=11209;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=MOjbHddF+m9qiX05U6dx3Wp0/wpA5Unrwl+MI6qb0cQ=;
 b=D65/MEx+U5dO0JrbYBlVLwxcIIJ3wDDUeuXmUH/9nJg6HKzRGNiIytAwyiwNcgKNRmhRLzsAW
 BV5blrxEQduD9YEl20l6W+vUeASKEilF5hLNyq8IjCImKFEF3OclSnW
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0276.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::11) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB1910:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c11dfcd-115e-4f05-9ae7-08de9b294f64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|7416014|376014|22082099003|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8Ola3aaNpsQZKJpB4aEpwriAqVgSCl9rLTpIElK63x2LBIRokI2SRYGZl2ks3JtzlfqTdVfo+E1ZwI1pkynTuHo5XOY1GgCTbueKWG1Hjh8H6wtIwQr6x1j7xBjet/erqeXz9urBe9LAYuOWuNhHo2ZH5JcL8xiXeSxRITjdhG/r9qgpD7Hh6fhOZEIarCarOfg/FVowfp27uxcgTxS8B3DsXpNzvO3cDpJNQjgebNWT1xLzLiKaaFhlui1qRKGQRsZPfx7a57xxWs31BcuOfddLg/6KzxMnoEJU74/7Fzx0d5EX8wPyM7ELfy1r8MEMc0YcYsI4/YxQ7A6R8blBwnh5eXl2IH5T/2xZfroo3ED7af3ylaGw4lF0BU2uHXTuHPtSPLWfi6z0lLcfnm01xmGgn0/0h+QiyTReK8q4bQWbT3uAu1/MzfeVWQZ80ri2RAAUHOFnuW1f3Jh3axSmQSBRoEbkZNCT9yvFO1ExXe2TYGUNK9Avb3QmB5XYOZXZSH71BzwtilP0uuhZskiMkSUjGEid6ZUTQJw0GjoFTPX9ET+4a8xD8Sg/tlp67UEGQuWlkBpDpvPnAHfXZ7m0OE6g3wrHLvbKqXO/iwdsRdIA3h6Y5zMbNtxGQHgVE4BoRKSvPgLa8gqDqF4brgDtL+ryVgNLr5+DmOef7XO1tKA2tyd8hPK12P8uLkQFsekVd99f0Og49W7Jq4o8VCMTBowwzNmC2eayzqdS/DPBlsE3Z6e74zhxq1BJ1CMgTG2ZoihfpEI/OnhO2XBhrn3t7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(22082099003)(921020)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N09PSVJJblFBUHZka3o4SUNlQnM4UTd1RG5DencxVi9tcVZRdHJ5eHVUZU9F?=
 =?utf-8?B?WGFsTTE0aE8xTXdGR2cwNEp3b0pmcEZ2K0FNaWJuMW9OWFA1b05yTnowV3Rr?=
 =?utf-8?B?b0F3TTUvcEppVFo0UHBEZGVZUGh1OWxnWGhaZ09oZ3A5U2NTaFRxYTNlZXZK?=
 =?utf-8?B?NW5QWE0wMUxQUHl5Z1NBdWZTYzhsd1BiR1RXYzdIWnVhdmFPMmx3aVBDY0Iw?=
 =?utf-8?B?RWdNcW9WbjRUd3VEbkEyV0lRK0NLdUMxQ01mclBxb3VVRXZyNkR3S2QvY1ox?=
 =?utf-8?B?c1U1VHo3ZDFHOFhyejRhQWVpYXJyeGd1OFgxS1ZMZ1hhcVVwbEpOTE8vSlF4?=
 =?utf-8?B?YVArMUc5ZVN1ZWljWUFBblc4UWxNekYxOGtjVmlIbGlPcHRVVkZkYkFlL0pW?=
 =?utf-8?B?dXFzWHBQd3RLRmZBRS94eEg3WjMvQ2Nyd3VMM0NzNy9xeStyV1hBYWxuVEYx?=
 =?utf-8?B?QXU0THFXMW9pbE1kUHhueHF4ejNiSU1ORldsQ3hOMzc2VDd4c01taFF6Y3VT?=
 =?utf-8?B?anVmcDdzNmQ0cVo1a0xkMW5vZTFyeThPRFdTbm44aDMvMC9QSjNOckkzZHlq?=
 =?utf-8?B?SWVNeVg3MDBtZngwK2tLU1dUSzJLTjdObDFpT0FjVnIrcVRESFVQNkJXY0Rq?=
 =?utf-8?B?NzBkV2tiS3N3UVF1Sll6cFQ3ZEdkWVpOM0FUZG9kVzJEK1VSUUhEZGdST2RY?=
 =?utf-8?B?cEFzeW8zNU1DaFFUNHVIWGV6QW9SWGUzTzlJa1JDNjRRb2IveUFLQ2NFSHFU?=
 =?utf-8?B?c3U3RGU4QVF0NkJvYlJSSmpySXFxSkZlcFpIZk8xRGZTU005ZnRXbUVyZVlj?=
 =?utf-8?B?T3hvWi8xL0xDb1VtMmxkZERTTXNyUEJkODVCZjFlckI2Ny9QTW14VnZHdFlU?=
 =?utf-8?B?aHp1QUVqdGd5THYyV01BdDJDR2lJMWQ5eElYaUI3QThFS256NnVMSU5RK1h0?=
 =?utf-8?B?aFBXbFl4SVJwL1dwYm9mT01raWRYMUNVSmc1aGhBb0hTQUp0RzI5VXpwNSsx?=
 =?utf-8?B?L1VpaGh5L2xRcDFJU3l0ZnBiTm9XdDJhN1BOZTZmVDRTbmZBSkZDQ3NJZUZz?=
 =?utf-8?B?K0lJRDFncmxEUmd4cGZXTit5QysrNGpXd3diSkN6N2pJOWlhUVFxSUZqTk13?=
 =?utf-8?B?ZWx3ZHk1d3I2NmNobU1NMDA4MzMvUU5sZElwY3JjUHRkaVBEVlZ1VmZNZkNS?=
 =?utf-8?B?Q0t6cWtwcEhMTmJ3TXNnamw1MjVDY082cEIwb2M0T1dhVkVTK01ucTR4UTFW?=
 =?utf-8?B?aFlZNlV6aWsrcERJdnlrMDVHYURLUkFybGpJVjdiV0JDNkNiRGxwendLK0Mr?=
 =?utf-8?B?NlA2ZGtuUm1oeFpibzRadXJPL0JReXVSRUEwc3hrQmJCVU92MHpRUUpvc3dE?=
 =?utf-8?B?T1JlTjJnaVJjMzhmUHd3SnVpZEhWUnJFZVlhbTVHUU5NQ21PVDJXNGdOdE9x?=
 =?utf-8?B?c25hQzVETk5BNHhMMXBBSGJNbTIvcWhGU0U5d3lqK3NZYklYVHR0cXh2U0Y1?=
 =?utf-8?B?bEc0OXp2THZIQVNTNjBFN29GMmtRYnRiZUc0ZEdkYUxxRlNwOUFyL0J6ejFv?=
 =?utf-8?B?NllTMWZBM0RkMlJXeGpjWHdCUm0zTVM2ZG1wQ2tWYWZBcEx4Mzl6d2ZLc0s5?=
 =?utf-8?B?NWtaV3lncWxGb0t6RzkzZEFwR2VjRytDTmJmT1lDSDcxRnVQdVJTenlzbjRL?=
 =?utf-8?B?MUErajMxSnQ3YUZPYlVoaFY0cGhBU2ZhVWc0L2YvY1lrNWhZck84UlVrZ0oz?=
 =?utf-8?B?aXdxNTk3ZmwzQldVY3MzS21UeU5PZTFwejNHR0pQVnI0a1VpVnFVSUtiK3J2?=
 =?utf-8?B?Ymd1cGRIbENKNE1vNHdtaVExRGdGeDhuQ2FnNXZoa3lCTzFnaytpN2grVlVu?=
 =?utf-8?B?L2c2T1RSVmNwYjBIa1RpTTdPM3JCWUNLWHdGV09XWjFwN1R5eVdES1JMbGV2?=
 =?utf-8?B?cVFveGRMS3cvdmc5bW9QMXdOM1creVhPWVRhaDZ4citRM0dwY2xVdmJ4Yktm?=
 =?utf-8?B?cUZSdGRIV0p1ejhTTWNlQldmZ1gxd0lzZHZvOENqUWlXbnlNWjJhWlJqZit6?=
 =?utf-8?B?VUovcWFEeW90Q2MrN2V4VjRrbkFOVTJFVzgyeFFybGFZRTNFZG1jLzdmWjF3?=
 =?utf-8?B?OXNjUnFNMWhPNWYwbm1mN2ZCVlB0NldUcy9jeVluamJFOXViNDBGOVZqeGg5?=
 =?utf-8?B?eVNsQWJSeWIrRnFsZ2dIQjE0RERSejYvUXB5UnhIZTE3bjNEUHRRd2M5YUNp?=
 =?utf-8?B?UlBnMUJzNUF6SjQrUldsdGdGOEFxMlFRYjhKZTBVVFNzQmZhalR1ck1iNGJq?=
 =?utf-8?B?U2FNanh5ZFhWYTdueVRDNUw2VEJMR05oRVF0Q2MwbVAxT0M5UXFXZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c11dfcd-115e-4f05-9ae7-08de9b294f64
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 19:58:06.1917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1jQ1gSmMa787laCq90oIyTYUyi6jqV9ohGkgQ9SbmfJNCrhMTgCgyr/ftIuTisSRkavyd6l6hx8C1+1KhKegAw==
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

There have been a few cases where the programmer knows that the indices are
in bounds but compiler cannot deduce that. This is also
compiler-version-dependent, so using build indexing here can be
problematic. On the other hand, it is also not ideal to use the fallible
variant, as it adds error handling path that is never hit.

Add a new panicking index projection for this scenario. Like all panicking
operations, this should be used carefully only in cases where the user
knows the index is going to be in bounds, and panicking would indicate
something is catastrophically wrong.

To signify this, require users to explicitly denote the type of index being
used. The existing two types of index projections also gain the keyworded
version, which will be the recommended way going forward.

The keyworded syntax also paves the way of perhaps adding more flavors in
the future, e.g. `unsafe` index projection. However, unless the code is
extremely performance sensitive and bounds checking cannot be tolerated,
panicking variant is safer and should be preferred, so it will be left to
future when demand arises.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/dma.rs            |  3 ++
 rust/kernel/ptr/projection.rs | 98 +++++++++++++++++++++++++++++++++++--------
 2 files changed, 84 insertions(+), 17 deletions(-)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 4995ee5dc689..3e4d44749aaf 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -1207,6 +1207,9 @@ macro_rules! dma_write {
     (@parse [$dma:expr] [$($proj:tt)*] [.$field:tt $($rest:tt)*]) => {
         $crate::dma_write!(@parse [$dma] [$($proj)* .$field] [$($rest)*])
     };
+    (@parse [$dma:expr] [$($proj:tt)*] [[$flavor:ident: $index:expr] $($rest:tt)*]) => {
+        $crate::dma_write!(@parse [$dma] [$($proj)* [$flavor: $index]] [$($rest)*])
+    };
     (@parse [$dma:expr] [$($proj:tt)*] [[$index:expr]? $($rest:tt)*]) => {
         $crate::dma_write!(@parse [$dma] [$($proj)* [$index]?] [$($rest)*])
     };
diff --git a/rust/kernel/ptr/projection.rs b/rust/kernel/ptr/projection.rs
index 140ea8e21617..845811795393 100644
--- a/rust/kernel/ptr/projection.rs
+++ b/rust/kernel/ptr/projection.rs
@@ -26,14 +26,14 @@ fn from(_: OutOfBound) -> Self {
 ///
 /// # Safety
 ///
-/// The implementation of `index` and `get` (if [`Some`] is returned) must ensure that, if provided
-/// input pointer `slice` and returned pointer `output`, then:
+/// The implementation of `index`, `build_index` and `get` (if [`Some`] is returned) must ensure
+/// that, if provided input pointer `slice` and returned pointer `output`, then:
 /// - `output` has the same provenance as `slice`;
 /// - `output.byte_offset_from(slice)` is between 0 to
 ///   `KnownSize::size(slice) - KnownSize::size(output)`.
 ///
-/// This means that if the input pointer is valid, then pointer returned by `get` or `index` is
-/// also valid.
+/// This means that if the input pointer is valid, then pointer returned by `get`, `index` or
+/// `build_index` is also valid.
 #[diagnostic::on_unimplemented(message = "`{Self}` cannot be used to index `{T}`")]
 #[doc(hidden)]
 pub unsafe trait ProjectIndex<T: ?Sized>: Sized {
@@ -42,9 +42,12 @@ pub unsafe trait ProjectIndex<T: ?Sized>: Sized {
     /// Returns an index-projected pointer, if in bounds.
     fn get(self, slice: *mut T) -> Option<*mut Self::Output>;
 
+    /// Returns an index-projected pointer; panic if out of bounds.
+    fn index(self, slice: *mut T) -> *mut Self::Output;
+
     /// Returns an index-projected pointer; fail the build if it cannot be proved to be in bounds.
     #[inline(always)]
-    fn index(self, slice: *mut T) -> *mut Self::Output {
+    fn build_index(self, slice: *mut T) -> *mut Self::Output {
         Self::get(self, slice).unwrap_or_else(|| build_error!())
     }
 }
@@ -67,6 +70,11 @@ fn index(self, slice: *mut T) -> *mut Self::Output {
     fn index(self, slice: *mut [T; N]) -> *mut Self::Output {
         <I as ProjectIndex<[T]>>::index(self, slice)
     }
+
+    #[inline(always)]
+    fn build_index(self, slice: *mut [T; N]) -> *mut Self::Output {
+        <I as ProjectIndex<[T]>>::build_index(self, slice)
+    }
 }
 
 // SAFETY: `get`-returned pointer has the same provenance as `slice` and the offset is checked to
@@ -82,6 +90,14 @@ fn get(self, slice: *mut [T]) -> Option<*mut T> {
             Some(slice.cast::<T>().wrapping_add(self))
         }
     }
+
+    #[inline(always)]
+    fn index(self, slice: *mut [T]) -> *mut T {
+        // Leverage Rust built-in operators for bounds checking.
+        // SAFETY: All non-null and aligned pointers are valid for ZST read.
+        unsafe { core::slice::from_raw_parts::<()>(core::ptr::dangling(), slice.len())[self] };
+        slice.cast::<T>().wrapping_add(self)
+    }
 }
 
 // SAFETY: `get`-returned pointer has the same provenance as `slice` and the offset is checked to
@@ -100,6 +116,18 @@ fn get(self, slice: *mut [T]) -> Option<*mut [T]> {
             new_len,
         ))
     }
+
+    #[inline(always)]
+    fn index(self, slice: *mut [T]) -> *mut [T] {
+        // Leverage Rust built-in operators for bounds checking.
+        // SAFETY: All non-null and aligned pointers are valid for ZST read.
+        unsafe {
+            _ = core::slice::from_raw_parts::<()>(core::ptr::dangling(), slice.len())[self.clone()];
+        };
+
+        // SAFETY: bounds checked.
+        unsafe { self.get(slice).unwrap_unchecked() }
+    }
 }
 
 // SAFETY: Safety requirement guaranteed by the forwarded impl.
@@ -110,6 +138,11 @@ unsafe impl<T> ProjectIndex<[T]> for core::ops::RangeTo<usize> {
     fn get(self, slice: *mut [T]) -> Option<*mut [T]> {
         (0..self.end).get(slice)
     }
+
+    #[inline(always)]
+    fn index(self, slice: *mut [T]) -> *mut [T] {
+        (0..self.end).index(slice)
+    }
 }
 
 // SAFETY: Safety requirement guaranteed by the forwarded impl.
@@ -120,6 +153,11 @@ unsafe impl<T> ProjectIndex<[T]> for core::ops::RangeFrom<usize> {
     fn get(self, slice: *mut [T]) -> Option<*mut [T]> {
         (self.start..slice.len()).get(slice)
     }
+
+    #[inline(always)]
+    fn index(self, slice: *mut [T]) -> *mut [T] {
+        (self.start..slice.len()).index(slice)
+    }
 }
 
 // SAFETY: `get` returned the pointer as is, so it always has the same provenance and offset of 0.
@@ -130,6 +168,11 @@ unsafe impl<T> ProjectIndex<[T]> for core::ops::RangeFull {
     fn get(self, slice: *mut [T]) -> Option<*mut [T]> {
         Some(slice)
     }
+
+    #[inline(always)]
+    fn index(self, slice: *mut [T]) -> *mut [T] {
+        slice
+    }
 }
 
 /// A helper trait to perform field projection.
@@ -208,9 +251,12 @@ unsafe fn proj<F>(_: *mut Self, _: impl FnOnce(*mut Self) -> *mut F) -> *mut F {
 /// `kernel::ptr::project!(mut ptr, projection)`. By default, a const pointer is created.
 ///
 /// `ptr::project!` macro can perform both fallible indexing and build-time checked indexing.
-/// `[index]` form performs build-time bounds checking; if compiler fails to prove `[index]` is in
-/// bounds, compilation will fail. `[index]?` can be used to perform runtime bounds checking;
-/// `OutOfBound` error is raised via `?` if the index is out of bounds.
+/// The syntax is of form `[<flavor> index]` where `flavor` indicates the way of handling index
+/// out-of-bound errors.
+/// - `try` will raise an `OutOfBound` error (which is convertible to `ERANGE`).
+/// - `build` will use [`build_assert!`](kernel::build_assert::build_assert) mechanism to have
+///   compiler validate the index is in bounds.
+/// - `panic` will cause a Rust [`panic!`] if index goes out of bound.
 ///
 /// # Examples
 ///
@@ -228,17 +274,21 @@ unsafe fn proj<F>(_: *mut Self, _: impl FnOnce(*mut Self) -> *mut F) -> *mut F {
 /// }
 /// ```
 ///
-/// Index projections are performed with `[index]`:
+/// Index projections are performed with `[<flavor>: index]`, where `flavor` is `try`, `build` or
+/// `panic`:
 ///
 /// ```
 /// fn proj(ptr: *const [u8; 32]) -> Result {
-///     let field_ptr: *const u8 = kernel::ptr::project!(ptr, [1]);
+///     let field_ptr: *const u8 = kernel::ptr::project!(ptr, [build: 1]);
 ///     // The following invocation, if uncommented, would fail the build.
 ///     //
-///     // kernel::ptr::project!(ptr, [128]);
+///     // kernel::ptr::project!(ptr, [build: 128]);
 ///
 ///     // This will raise an `OutOfBound` error (which is convertible to `ERANGE`).
-///     kernel::ptr::project!(ptr, [128]?);
+///     kernel::ptr::project!(ptr, [try: 128]);
+///
+///     // This will panic in runtime if executed.
+///     kernel::ptr::project!(ptr, [panic: 128]);
 ///     Ok(())
 /// }
 /// ```
@@ -248,7 +298,7 @@ unsafe fn proj<F>(_: *mut Self, _: impl FnOnce(*mut Self) -> *mut F) -> *mut F {
 /// ```
 /// let ptr: *const [u8; 32] = core::ptr::dangling();
 /// let field_ptr: Result<*const u8> = (|| -> Result<_> {
-///     Ok(kernel::ptr::project!(ptr, [128]?))
+///     Ok(kernel::ptr::project!(ptr, [try: 128]))
 /// })();
 /// assert!(field_ptr.is_err());
 /// ```
@@ -257,7 +307,7 @@ unsafe fn proj<F>(_: *mut Self, _: impl FnOnce(*mut Self) -> *mut F) -> *mut F {
 ///
 /// ```
 /// let ptr: *mut [(u8, u16); 32] = core::ptr::dangling_mut();
-/// let field_ptr: *mut u16 = kernel::ptr::project!(mut ptr, [1].1);
+/// let field_ptr: *mut u16 = kernel::ptr::project!(mut ptr, [build: 1].1);
 /// ```
 #[macro_export]
 macro_rules! project_pointer {
@@ -280,16 +330,30 @@ macro_rules! project_pointer {
         $crate::ptr::project!(@gen $ptr, $($rest)*)
     };
     // Fallible index projection.
-    (@gen $ptr:ident, [$index:expr]? $($rest:tt)*) => {
+    (@gen $ptr:ident, [try: $index:expr] $($rest:tt)*) => {
         let $ptr = $crate::ptr::projection::ProjectIndex::get($index, $ptr)
             .ok_or($crate::ptr::projection::OutOfBound)?;
         $crate::ptr::project!(@gen $ptr, $($rest)*)
     };
-    // Build-time checked index projection.
-    (@gen $ptr:ident, [$index:expr] $($rest:tt)*) => {
+    // Panicking index projection.
+    (@gen $ptr:ident, [panic: $index:expr] $($rest:tt)*) => {
         let $ptr = $crate::ptr::projection::ProjectIndex::index($index, $ptr);
         $crate::ptr::project!(@gen $ptr, $($rest)*)
     };
+    // Build-time checked index projection.
+    (@gen $ptr:ident, [build: $index:expr] $($rest:tt)*) => {
+        let $ptr = $crate::ptr::projection::ProjectIndex::build_index($index, $ptr);
+        $crate::ptr::project!(@gen $ptr, $($rest)*)
+    };
+
+    // For compatibility
+    (@gen $ptr:ident, [$index:expr]? $($rest:tt)*) => {
+        $crate::ptr::project!(@gen $ptr, [try: $index] $($rest)*)
+    };
+    (@gen $ptr:ident, [$index:expr] $($rest:tt)*) => {
+        $crate::ptr::project!(@gen $ptr, [build: $index] $($rest)*)
+    };
+
     (mut $ptr:expr, $($proj:tt)*) => {{
         let ptr: *mut _ = $ptr;
         $crate::ptr::project!(@gen ptr, $($proj)*);

-- 
2.51.2

