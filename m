Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E8AC44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 11:01:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C63F610E8F7;
	Tue, 21 Jul 2026 11:01:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="AA7e7TH+";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010040.outbound.protection.outlook.com [52.101.85.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2928910E8F7
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 11:01:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fj1jMa5oRMWmTf1nOJS0mxzz8+dmIMF0U5ON8NpUuqwg1a3797BcOorT8JZcRojHEEq5KMlpvoAkQ/HUqVMEHegyU2/Wi0jmUrgUgMLEeKOJSbTeuZVZPSSvdLBdZbum9XInMHnCASv8YKgpcJwSNmIulvKwAGsdZox0uRhS83Aj81NEeQFKLCLQiAt3XT6WOphppFK4xa3EMJy24yU1f9vPg+bmkwgYNWUF2EdcV+QdlsHMve9ur+B20mqNVtCpSIHm6K+lAFXrU1fL/iKAw3ChcknnuR4qsG0RgX3U5ktkz+ORQZDAAswjR6sV5wKdASs2l83Pa6WepM8dXhdpdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAeLg/yYoYWetpIFYa06Idbw51eJQ8r4V8vit4cOMlc=;
 b=GIRLxkRtw3ym9OK2xgcVz6ngjEo8nH7iEsiKn06dbt18WdXN2eLI+D1LKn9F7spGhqud40ow6VKwd/8oamwxGoPkTIg2LfvhbIxvC8NINhVP5NluWvJmIAZIA/uf2Tvd9Mj+fKwqSMGwbayU4Afn3932Hsbupsxzd53UjBRpQzF4FaUYioeCC43r9akg+6nE+KgvDGvAL1sTdedfiR1wgD60EibGrS3rN8qDEPFDfnNx3LSteA0IA5qB8edZiNf3gRCscdqiuIs5ylzzaMa05qZWCZAmSXuWwQAMNzM5sryIcwcGMO8G8/3FAulP5XWzD77XlSikIFl5EBMLtjvsLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAeLg/yYoYWetpIFYa06Idbw51eJQ8r4V8vit4cOMlc=;
 b=AA7e7TH+5Zf7vkZhGY7XueYQITMJDiYSpWPmpSERIGR1ghs/uB+wB4oNszNKW+EtZxKt639thsgHk6lKwlFMu/lJED3vDIlxJOejDDI/e5ByoqsLQpVmz3hILd/sQd0OVH6/URRAD6CThA0Kl3ND3VH2kbeaX3tW3Tiitn4a973OGe+VxuYobLZoJ8wvPLDu8OKBGIPG/dGR3AA8zaMYwsGsOsFe8xOqzLCZ91N5FqlxkiirCQndc2+cd8oYpTD4GmbiXqCyiC5J498b6qPhM+F2BJMtaANg0vFf+Iz4pAvlgtKaBgIzpzKuCByRJLWDeHtfOpQIxrBCYLRZ0NKxjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB7667.namprd12.prod.outlook.com (2603:10b6:610:14f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 11:01:00 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 11:01:00 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 21 Jul 2026 04:00:13 -0700
Subject: [PATCH 4/8] rust: io: register: use path fragment in relative
 internal rules
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-registers_fix-v1-4-3711b2317e1f@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 24fd754b-1e4d-48c4-6acf-08dee7175917
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|376014|1800799024|56012099006|11063799006|10067099003|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: K29Jled9ywm7ju3s8AJjA+6muYpcDVyAyQI488go2FRGcVYOeAcXuOG9Rq8h9CmIWC5h+yOhpJnEhfO/mbXZAj/hBtkAMTHlqERDNaqQG6FpgX10zXGgOdIWcwtexwSjEmvicgaEjjO0Qyda5ynAYG8lgQmHE3611JUc2c0AVemKMjZgfR5U8ttdwLAF49gsX1FXKnTMTOXTwCRGPehsriHPcLEPGaBzXH07caMv11ajvowICslfh+yMmLKRY+qL0CiirKPosf0UTrYQ4gM8yMvLC/xrv7mFVnfi5XA2hVnkrTGhGdYrUEzEqOPcdbbLSLiou0PlCAge9wA5NzBaIklWphuTjcFt06MDq+uO3f0v+oe6H+6Mz72NHBs/3SaxJMrcxLYV1jy3sBRC+mRYHl/eXbCabodnRoZK5EdaZyGFNLNQy+F6aSKZNrt2SsEhFbQFhpAPOrcwNmqqUkXw+mwyTVIHrg4YM5pI4ISNZcHJnYjx7Fic9MmSvVCPL8KhNK5etjdNFh6kcCP/ewHR1ZUOkkaZDJZpy9KpR25zC9m7zrMClD7spXd4DkHsSEndGtWRDg6UjGfEm01WWLvAZVGKLwFHzGqYs1tXdw3dc5XzubwUkAMZs+KyAjD3gTxEbnxNWc0o3eZlJzaFJV/VecRIRApyo9Y/MUUxoLTdiP5xtkG1hhZ0QQUG2d1DOJF1/pqHH8CU6usJNj7znbHggw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(921020)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFR1MGNTLzRiQjZaTU9SZ1czZ0UxUWRsV05XZmxFWkhlT2E1ZzZpQmd1RXpq?=
 =?utf-8?B?N2tlWmdVZzFPbFozbmQxYzR0YTdZY2dqcG5FMGMxbi8xbnNYWVJmZVY1Ulcx?=
 =?utf-8?B?eWJjYXVyOVUrRGpHTWV0SHZjamdEeDZoY3ZNNUVNZ3JIMUtZd3NEZjR0RFpa?=
 =?utf-8?B?SFc1aGNiczh2bDFGRUczMkFXSlNoWGFKVDBuV0lvTDFCN1NVSzd6aUEybFlK?=
 =?utf-8?B?Z001eWM5bWZGWCs2clp3eC8vR1JHaW9aRFFaejAyRTYrVUVoUEtHUzZLS2ZW?=
 =?utf-8?B?RTBYTUxDakt4QU9MTEN4alo5dVZoRUQxa2RyV1Z6c2dhcUpxMEVRaW9KK1Q2?=
 =?utf-8?B?eEt3ZDlSc0NGNkQ2d2RIUU5nMENhRVRNa0lCNm4vZ001dUxhZEU3S29iZ2p2?=
 =?utf-8?B?b0lwSktRMERFOUVROENHVzR3NWJ2anlaVXI4UWVMRlliQXdEY25YaEtZaW8w?=
 =?utf-8?B?cEUzU3J4bDgwOHo3Y1FrdTdwcUs5VTg4UEQ0Zk5CcVlhVVB2a2d4blBqcVMz?=
 =?utf-8?B?eE1BbWpqZGtBOVNvVllwR3h5TkRTdW9xdk4waGRQNWJsTUVDQ05uUVZQV2RQ?=
 =?utf-8?B?MXVSSmNmdFhmbHBmOVk5SmEvd0FQdlFtYTdVYVF3US9aRkVLQ2laYm9FYzI4?=
 =?utf-8?B?bk53R1hJWmhoTDcydWZnQzZVU3ZZNTZ3cWU0NDNZVVYvYkVPVXBkZ3Y2SUhP?=
 =?utf-8?B?Y2pEQ0tjNXAxSG1QbXdqRElCZnhhem56ZzIzTWtmdnVjRjFTa2UvLzNBUzBW?=
 =?utf-8?B?cGc5eWs5Z3d0V1grRjBkb2lTSVhydzltdHkrcE40WGFySFl2bWF6Y2c4Y0o0?=
 =?utf-8?B?aVJ2T1V6ZjBBSTkyTE1WM0ZlUEc5NmdCY212TWlzSHM4aXlvYWR5TWpPcjdC?=
 =?utf-8?B?cVAwWVdZTk0vRjdKMndLSGRFcGVXZEFNMmdiZ1M3MDdCTzF1a2IyaDFFU2tD?=
 =?utf-8?B?MWZCbzhmUTlEWHVCUDdhZkpKd3JzMWxDQ3MxWkpzSk1rcXdaR0M1eEJTckFI?=
 =?utf-8?B?SDFhdkV0dG5hbmlMS2xTTVZ2RHJ4aEVISUYwZWNIRHh0YkxQTWZJTThNVCsr?=
 =?utf-8?B?dmlTK0dPOEZGZGk3bVhYWjFteEdVenMrbytYYW1MbG5rd2pmTzR1TWl0UlpB?=
 =?utf-8?B?cFJiYlkvQ3h0dXhaM1hPUEtzeElmK2xsQzZ0OEp4aHo2RS9nT2oyanJiZ0tz?=
 =?utf-8?B?bTR6ZTFvemUrYWlDZktCaEttZ25EQk1pUVZhRWpiNkF3Wjdvb3l0VUlFMTBR?=
 =?utf-8?B?TCtjUUZTS1l3YzIrOWpRQS9tZUFFQ2lzVHFEMjY5MVkvZ0grTms1QXAzaVZS?=
 =?utf-8?B?RFM1aUZBU1AxQ3ZKdldmQlZ3MXExV2tld3VCdXZSZExKZTlLQ091Q1Zzc01R?=
 =?utf-8?B?QWQyQmlrMXlCalZQREhBazVtTGVvZm84bUh1d2tzb1Erb3R2Y1BnVXlJYTdP?=
 =?utf-8?B?Y2gzTWlyaFBNTnQ0dzY3NnJTVVFvTFU2a3NSaGNuK2pmVmlocGdVaXIyUS85?=
 =?utf-8?B?ZzdHSTdHREtTU1ZLa2VpbVZwb1NpT0hSMnNoczRWMnFlWGdCQmxSczNkQUsv?=
 =?utf-8?B?U3hxb1MrYWtJR1UvVFE2UDdKUXYzSWpLampCeDBYZFlXRzBSb3hYVi9oSWVv?=
 =?utf-8?B?anBnbktlTEFyc0xtSTU5eWMzS0pQTW9keEVORlFaWUEvdG04ejhPc3dtajNi?=
 =?utf-8?B?b3llNGZpYTF4MzYzMW9KTzdyOXdUYmF2VDV4NnRKdFk2Q2JFYlEwZ0RTbE9D?=
 =?utf-8?B?cVJBWjBpMmlzdHFtdEhaK2xGdTltOEVLZFNSYlllSFRGNFNEODk4QVZJa2tD?=
 =?utf-8?B?N25YUVBZd1FrUE9mZVhvWlJpOW1ZRXk0dTRkY2pDNWpzY1pTcFBHMzVONlp4?=
 =?utf-8?B?U0lyVFlWdnRwNHRhK2pJVTN5K0JjYjJlL1pyKzJOUmRyaWFCankrNUMwV25r?=
 =?utf-8?B?bk4rY0RUNFNzSy9wSk5yazlWMTUwOUhReUY5SEFmSUpvVExvZG5LenVRaVhT?=
 =?utf-8?B?VHZrVDlPVE95RUJQdzN3VC9xcUJVdzJsbmhXMkNlbTRKczhuK0VWNzgwYVRG?=
 =?utf-8?B?b2ZCeGo1Z1FRWWVlSC90dm5ndVZkQ0M3TmQxcXBqcWF4MG5BVHV2TC9IRndt?=
 =?utf-8?B?aDlWbVFJN0ZBMjk4WlAxaEZrY0Mybmt4bDk0RGhIT0xvRGJ6TnFkTngySThr?=
 =?utf-8?B?K2c2VG56YUtRS25lT2JrVXJ0VEFpRkVGaUY4ODA4bFNIRGZ6ZGk1NGNVUjg0?=
 =?utf-8?B?T0hwOFpFV2I4UzVUUDhLbytHeUlyR0ljcVlhclZJdEg1VGdHU0JwaUs0Z1FX?=
 =?utf-8?B?ZnVBMjZUMUpKL01BTnJNNXJiL1lLc3ZKNXpMSmNQTitCSmpuRURhZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24fd754b-1e4d-48c4-6acf-08dee7175917
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 11:00:59.9629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KspKD20IqZWhf6AgG3HctB31PVVZpQFrXs+g3xos44ajECM5GSzEhMY58LXkfswqnzToTPMMn/GzWnV2ncEpdA==
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

The base of a relative register is a type, but its current fragment is
`ident`. This prevents referencing bases that are e.g. declared in
another module.

The `path` fragment is more accurate to represent relative register
bases, but bases are currently followed by `+`, which is forbidden right
after `path` fragments.

`:` is another separator that can carry the desired semantics, and is
legal to follow a `path` fragment. Thus, replace the `+` separator with
`:` in the internal rules so we can change the fragment for relative
register bases to `path`.

The public rule still uses the `+` notation and an `ident` fragment, so
there is no user-facing change yet; only a minor replumbing of the
internals to better support the new syntax introduced in the next patch.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/io/register.rs | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index 1e0e23e4233f..62208f52752a 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -816,8 +816,8 @@ macro_rules! register {
         $(
         $crate::register!(
             @reg $(#[$attr])* $vis $name ($storage) $([$size $(, stride = $stride)?])?
-                $(@ $($base +)? $offset)?
-                $(=> $alias $(+ $alias_offset)? $([$alias_idx])? )?
+                $(@ $($base :)? $offset)?
+                $(=> $alias $(: $alias_offset)? $([$alias_idx])? )?
             { $($fields)* }
         );
         )*
@@ -850,7 +850,7 @@ macro_rules! register {
 
     // Creates a register at a relative offset from a base address provider.
     (
-        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) @ $base:ident + $offset:literal
+        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) @ $base:path : $offset:literal
             { $($fields:tt)* }
     ) => {
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
@@ -860,7 +860,7 @@ macro_rules! register {
 
     // Creates an alias register of relative offset register `alias` with its own fields.
     (
-        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) => $base:ident + $alias:path
+        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) => $base:path : $alias:path
             { $($fields:tt)* }
     ) => {
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
@@ -916,7 +916,7 @@ macro_rules! register {
     (
         @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
             [ $size:expr, stride = $stride:expr ]
-            @ $base:ident + $offset:literal { $($fields:tt)* }
+            @ $base:path : $offset:literal { $($fields:tt)* }
     ) => {
         $crate::build_assert::static_assert!(::core::mem::size_of::<$storage>() <= $stride);
 
@@ -928,11 +928,12 @@ macro_rules! register {
     // Shortcut for contiguous array of relative registers (stride == size of element).
     (
         @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) [ $size:expr ]
-            @ $base:ident + $offset:literal { $($fields:tt)* }
+            @ $base:path : $offset:literal { $($fields:tt)* }
     ) => {
         $crate::register!(
-            $(#[$attr])* $vis $name($storage) [ $size, stride = ::core::mem::size_of::<$storage>() ]
-                @ $base + $offset { $($fields)* }
+            @reg $(#[$attr])* $vis $name($storage)
+                [ $size, stride = ::core::mem::size_of::<$storage>() ]
+                @ $base : $offset { $($fields)* }
         );
     };
 
@@ -940,7 +941,7 @@ macro_rules! register {
     // fields.
     (
         @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
-            => $base:ident + $alias:path [ $idx:expr ] { $($fields:tt)* }
+            => $base:path : $alias:path [ $idx:expr ] { $($fields:tt)* }
     ) => {
         $crate::build_assert::static_assert!(
             $idx < <$alias as $crate::io::register::RegisterArray>::SIZE
@@ -987,7 +988,7 @@ impl $crate::io::register::FixedRegister for $name {}
     };
 
     // Implementations of relative registers.
-    (@io_relative $name:ident @ $base:ident) => {
+    (@io_relative $name:ident @ $base:path) => {
         impl $crate::io::register::WithBase for $name {
             type BaseFamily = $base;
         }
@@ -1007,7 +1008,7 @@ impl $crate::io::register::RegisterArray for $name {
 
     // Implementations of relative array registers.
     (
-        @io_relative_array $name:ident [ $size:expr, stride = $stride:expr ] @ $base:ident
+        @io_relative_array $name:ident [ $size:expr, stride = $stride:expr ] @ $base:path
     ) => {
         impl $crate::io::register::WithBase for $name {
             type BaseFamily = $base;

-- 
2.55.0

