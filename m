Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9322EC44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 11:01:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8B6010E920;
	Tue, 21 Jul 2026 11:01:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="lp0fPofI";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010022.outbound.protection.outlook.com [52.101.85.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79D9810E92C
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 11:01:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E92vkY3SK9XXWpdS7sWDbP4KTf+MDSKoKhRJ5cZ7sQJE5UyDdM0Tr+wR2F9x0pHuuRX6hzErKRsFNVfEVGFTAdW7XKcNjhAwOmVo8nyFHusFOJNdVCd0Due8YHy+F1pbId4Z9NBmPdr7FpGAoa9qra7nhQzZ6/4zx29ZqPVl9Nzd5tijr+zIjr0HSc4ZKbvnJmqJGshu6NKGq5Xi6pEmDpPzMc+rQavcw/+NZ/mWEhLb2Kr/5v3y2s6+lyCPC63hJGW5z5ReX96ez4qGRjlLCvrxK+fQA5XYwLysAl11KBBvUuRVBGmiKBWvGO7wku7r4y24zj6XZy4uusL3iJ5sSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qtPw4WvS/IJUeKdZuUP7VnjY20rtwIw0y8xhQcyJZQ=;
 b=UgaAEBDfVrkricEfzZ2o8Ahn1ip/gLiDZAodK7dVcn1T3kly+c0yLcuL5xtlswQ03mDPlMGESB1yvVGBv0AT/qh0CgPKnKJwByXXYpguqnY9a2x+9j2NBn3XnnTgn2MXXJmL6q64jAvsIlqpiwVf3sFy8q0iXOk8R6FaDOrirKpTviON5Sy4NetHPkV7/1Kz3Zuu4nk2OykN/Ll9a3W6gGA964X53f9dTZmbBfuHZ9GvpnUqUsohZrot5N2+xbe9U3p7M1x5gnViWMjmaLHEPzBn+2LxZ0kHyRnetwf6eESXkw83TUCBqNZuL9xNF/TwF82aAKPikCXIONfhx+mIYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qtPw4WvS/IJUeKdZuUP7VnjY20rtwIw0y8xhQcyJZQ=;
 b=lp0fPofIrrQtQRD+Xd9bPDF5fc0ph4mCU7TWuRNeUoVJdFB3PvsMEcecCQoKhdP0ksQ/dr7+TkORESreVE8XGT0V+giN9ubHMcfe/lwij2xo3uXfuNQiQZ8hzgP0YzWkg9c0d2gbPwh8VBNS7k4SryGKVH0olypecoXKE5nzIX4IzrS/3VI5Tpm1KS6pNU8HHDfozAPK734rFckX+BKAWC2/jI/232ZRbTyjK0eK/EymhtfTdNwft+NuJCunY0lrTxaPDmPfiS02cD+7U5WyP+cy0IK9WNYdsvGmCyAgK/ahQ8l44lxV3tJ+Z0k2dKHcyentrYO+VnFoOo/TpFiQvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB7667.namprd12.prod.outlook.com (2603:10b6:610:14f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 11:01:22 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 11:01:22 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 21 Jul 2026 04:00:17 -0700
Subject: [PATCH 8/8] rust: io: register: remove deprecated relative
 register rule
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-registers_fix-v1-8-3711b2317e1f@nvidia.com>
References: <20260721-registers_fix-v1-0-3711b2317e1f@nvidia.com>
In-Reply-To: <20260721-registers_fix-v1-0-3711b2317e1f@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: c9276800-8fbb-4d3f-1c5e-08dee71766ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|376014|1800799024|56012099006|11063799006|10067099003|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qBeAtGQk0s1WcRxfooRJkAcfXbryFG/27F06NckVfxAjyXCV4H+9x0IDynlrNeoYtKqqxepvr3khaWK8FyGSR4remOo5e2X0RiZy+AQgALJIQA/W0ByviphMzXnB7MEgRk5/QwwWxKP5cKbUHHPbXp/5aZS7pYUUqF9qMCkNXKTCePMrkWTiDKA67E7Y33m18nAYvChFgVwq2g93hV6sXfDd7+7ti2+4FxnR1G1SXnTqkz0WxYpVI4RUN5Cf5H3Nw/o7L1ykAbP69o0AUMUO3HMrY7qFMmouJ57mR9t7PwtlnINaEDed3tSWOQeaRpHZSg6cmJZqcyAz1V+2v1uSZ2H2xOF3sZ2lDUIfaUrsiqlfECTDkDwrzvoXs/eBzVX/NyM5m9+y07CwuvpfkHCzFsaRFZbUplVPNmqVRr7eYKX+WRpa0UPu1VQQbCtogUnnyNNkbDZG1BDAF1OScThGdY+FtXtnZBmXp3Y2ZMuMrEw4NtxTFcVgfeaMIYDR6Qpiu8YpgU4e/nP7XIFisRrW6g/lyhjg7IDz4tBS15z3QhUADwBhcylKHhsun1wsPs2i2mPS8ST4yvQuCFOHtDRPwGXa+6sPS8uoOnWG/DGWZxLBD3Lb1Yjmt4q9P6fUVCoOG7az7EnBE/S3eEMX/62JDitogBTGNrMGWPHIjfa4a+3pFMUZxVQFRGJy4X/eUU50ldlXCUVdaiJDuunXX0ooQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(921020)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVBGVGkybDFJKzY2UkZqcy9oMTB6U3Ftd2VnVFg4TFpmVXptNmxoR1lTZFVx?=
 =?utf-8?B?bmhrK1h6SVI4ZElOZDhmVExHbHdMaWtCWS9UQ3ZTVWxjK25RVGswQ3dHd3c5?=
 =?utf-8?B?N1A4dXRkaFk2Zi94T3lXM29OTW5yc1FWdnNNcmpxb200VFVFY2FaaWRhb21X?=
 =?utf-8?B?NHYyMHdsVkt5VEU5aFFlL3kyd0djN2pNelcwOVBkNk9ubUJ5aC9ZVFF2bmpR?=
 =?utf-8?B?UzZOWGRUZ3JYcG53Vk5HWXoydmR2Qjc5d3doMnhUL3llTDZDOXgwbWNsbXpO?=
 =?utf-8?B?OHhnanJvYjk0M241cSswSkJ0SzQ2U1ZpNDJjazhCRzBnQS91bmd0dFZ1eTJR?=
 =?utf-8?B?TjZVSlNpNk1mb2lTc0R0MHZROXdQaVFEYlpXSzRBM2pESFFKV3lxV2hlbmxh?=
 =?utf-8?B?eVBxc2N1a1BsNXNsYUFlRHVzMUZsalYrVUs0U0FFc0paSHdhcWN0dXkrdFlw?=
 =?utf-8?B?cjBpaHovNURaZmJLNS9hVk52dW1Xd0Q0K1Q5ODNvQWNtckZEdEI5RTJTc1BN?=
 =?utf-8?B?QWZqcDQxWUVwSHFHdVJ3dTRGUUpweG1STXQ2T1pXc0dlbTlwazVhMmNOY2d0?=
 =?utf-8?B?ZEd2QmFyMDhpaFRZYm5YOHNzSjUzSUdIWUo0R3hQWGx6eVVZRjhSczN1aW03?=
 =?utf-8?B?d2VEKzZjR1pxWTZDN1FSekNCSnM4aFhmTjJDOVZwWWRlK3pWWnpXSCsrZENZ?=
 =?utf-8?B?V0U5MmpkOTBRTFJPWWZwcXJyZHNmU1pMbDQ0Uy9CZ3l3YXpDUHVXYWRHWXNh?=
 =?utf-8?B?eS80VmY1SXpsMTZCZUZLbUpDL1VkRVpxRkhtU1dHSjNHM0p3QUJSRjY1RzZi?=
 =?utf-8?B?eWNNSjk0b25INXZZVlh0akFLL0RaaGcwNlRwRkZkY1Zid1hrTUQ2dEtnVTNP?=
 =?utf-8?B?SERQZFV2QWEwV3gvK08vd1ltNWlBYStrcXFxM1ppc3o5OHdlRncwNXQ0Nzgx?=
 =?utf-8?B?d2FiMFd3UkpaSEJ0aDRGbkdHZnNGT1ArWEFwbzdqTlB0aTdFWEF4bjNZTHRw?=
 =?utf-8?B?UENzK1FFNTdVZGo5ZFFjcm0xdzYzdVVpSjJrdDVuUlJuYlA4WjlobnJVUmJs?=
 =?utf-8?B?MDBIekR3am91S0p5cU9sVENFQlVZN0dLbWdrNEttUGEzeW5BOW1JeHhVcDRX?=
 =?utf-8?B?N21Gd3pBOUJvRytPMEp6NFVITHVhR2tkS3R0blFwTVFubzJDa0ZHcHRDVjFU?=
 =?utf-8?B?WU9iZ3hLZjdId1NCVnMzRUkwendKUEM4SFNDSzdwVlBlM2tvd0ppaWcwamo1?=
 =?utf-8?B?bFZyeUJoem9pZ3pEUWxLRlF3NDM0ZEYwQ0pqcUNQWnppM2FVbmpGZkdmaHhx?=
 =?utf-8?B?cmFhTE5MY3MwUlZpeEtsQlJqWDNCZHhDblU3aDZBdjl3YXFhd0l1SW00R1pO?=
 =?utf-8?B?S1dpT0ZzSWhFNUt5djRZb0UxelBjYXJQSDQvRzRIb1RuR3lETHBGcEJCT1l0?=
 =?utf-8?B?cmlLMVN4MzRiaXVOcjFqR1NrZnluWVhjdHFJV2liSGg3TkVEeS9TemowMG0r?=
 =?utf-8?B?MkNjQ1NzZWhoVitEM1NNRXV5enNuZWdJTG1abnM0SVVuUXEyaFFKbHkvWXpZ?=
 =?utf-8?B?c2pIL2I2YmcxWStoNUhuZGJBTkZtVjhFTSt6bkkzUUpIczAyOGpudUcvRGZ4?=
 =?utf-8?B?SUh4Wm4zQkQ2VVZFSEo2dnZmUFNjU1FxNmRiUG4yK0Vmano1SlhSSEp0TUZy?=
 =?utf-8?B?T09MM09BdDc2RjJnV000bFJ1R2U4eWF3V2ZhUEdKVG5FOU05Tm1GMWx3NHNr?=
 =?utf-8?B?V1FhZlJwZHlTWWpzOGhPTmtNWHhBUU8vcXVmTGlZZVpaMUxVZjc4YjFKUnRa?=
 =?utf-8?B?b2JlbU5mQVNuaGFJVk9WZys3NE42WGdLOGllYk5pUGw2cFFIb1BGcmlTWDlh?=
 =?utf-8?B?aWpBZjF2ZlBJVTlhOGlpblZBelFwU3h5a2t6NWp0MXM4ZnJvTWNWaFArNVRq?=
 =?utf-8?B?aHlEV3JUUzFYTEkzbzlyaTVhN2ExVWdab2lxc3A4N0NEb3ZNSjZDTHRNWDVD?=
 =?utf-8?B?aUJyWGJUdXN3WDEyU3hPc2ZHZCt5Mmw3ZUVxL3NwVDAzUVNDaURMNDlOWExT?=
 =?utf-8?B?Zlo3RFFpemN5alEyVkpXUjI4T3Q2UWlKKzU2V0poUjk4UmprQWJpbHZyUHJ4?=
 =?utf-8?B?bWxSL2JwaThKWFh6dUVOT2VTNjI5UVFpTFZzYnExcUp0Z3ZFcktxdkdhLzBP?=
 =?utf-8?B?Wjk0bUY3U2Z5YTB4SDZFWTlReXQwclR6TytkbzhlZk9XWWxibnZ5eXVzQS9T?=
 =?utf-8?B?VWx3ZDBmd0VRTXBkdnZrQy9ER3dVZkxwYUFrVis4SG12SGY5MVh5aXhVZlpx?=
 =?utf-8?B?eXF2bHFYSE1wa3VmQVpzWlNqMW42U0NYc3l4dXBPSDhRQnJsVGNhUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9276800-8fbb-4d3f-1c5e-08dee71766ba
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 11:01:22.8295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /7hRjwNoJ4WP+bYG3Spxe3G+C7mWPWVPviO7oJc1iNKVQpJcBrYpxJ6+8saT4s3WIljHrHEHH07pnX/GUbWylg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7667
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

Now that all users are converted to the new syntax, remove the
deprecated rule for the `Base +` relative register base syntax.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/io/register.rs | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index eeb7f859f8b9..2c88ebf0057e 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -801,26 +801,6 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 /// ```
 #[macro_export]
 macro_rules! register {
-    // Deprecated `+` syntax for relative registers and their aliases.
-    (
-        $(
-            $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
-                $([ $size:expr $(, stride = $stride:expr)? ])?
-                $(@ $($base:ident +)? $offset:literal)?
-                $(=> $alias:ident $(+ $alias_offset:ty)? $([$alias_idx:expr])? )?
-            { $($fields:tt)* }
-        )*
-    ) => {
-        $(
-        $crate::register!(
-            @reg $(#[$attr])* $vis $name ($storage) $([$size $(, stride = $stride)?])?
-                $(@ $($base :)? $offset)?
-                $(=> $alias $(: $alias_offset)? $([$alias_idx])? )?
-            { $($fields)* }
-        );
-        )*
-    };
-
     // Entry point for the macro, allowing multiple registers to be defined in one call.
     // It matches all possible register declaration patterns to dispatch them to corresponding
     // `@reg` rule that defines a single register.

-- 
2.55.0

