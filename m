Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEAAC44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 11:01:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86FD510E8D3;
	Tue, 21 Jul 2026 11:01:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="eqHW+oRV";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010014.outbound.protection.outlook.com [52.101.46.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 071FD10E8D3
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 11:01:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DXQP2XpQ2YnF4xhHhzzTDocYWF9ZJ7JkMUmnIyOffpo7cyA3Mu5zMWbOG1vuKCGmRZ27zL2TWK9PNc4yX7dGymQedk6TMSGRDyt10oS3VOG82buZkMHS28dDpSOu4y9OzEWeywy2GhMePXfWirKBNuXGS8hWbHA3Tu1xodKtCD0Kxh3fsbAKcN9dMF4gHfTehYbOpRUDkGhx1gRVOrmumbRCmeP2CYg9vOX1UB7rJh+iYOH2Y6z1pLUfHNXEVrcjgUxA5wmz70Czweys6vNxgdhlRFhaLyEnXzeI1ZxWmX05EUFqbOKxXNRxBuh6expJ9d3JGU0T0Upazv9KetITvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDitVsv9ey9jfk8U6j1+CCawDAPGDz1fktxgkXsaYkc=;
 b=e+zHFUL8qXH48HTL+xbBHSPYSq53Pve+EMGmDin3vldtkgnsg4Yce/FchmUixmDkH/OP5hnqOE9JATECVdRxatfVsv3IzUlUVLzUqY8GsCCwtZf05YzNy0Ak8vWobDomDWi0STUEUWvFf/PFFDCkviJsJv+JRnUyEbspheY7gUReoL2omLXqh8MbwXB8xgrEVLhfpwdNECXY8fvOS1w7Y+EDJwJoOYWd/bCwLYLY9zPGE0P+BxrxYcIV1PPBSoDwd+ahB4ZxcP295iGufNnruIUZHk5+rCaak2mY/pv+HDKRg9qLldgHJTuuVD0S58yVwWQR/NiS/zmOxJYkubew1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDitVsv9ey9jfk8U6j1+CCawDAPGDz1fktxgkXsaYkc=;
 b=eqHW+oRV3PS2HtqGEGrFy/C4BwPMkduLmeKe1O5+r4gwG0iRPRZhFfUpRtqz/P050ANFmxqiutKxbQakUlhKZmks0jlb9nsLteNQzdAC/2vAcsF+zqJanRL2MnfwTMlW6Ie3JrLezIxNA2t9apkoDyiqbQZejBLJsi+LeQNJbGmjausifcNMhoJCHzgFNc+zHQujP7i3zlxz0kVtP12IzCZ9hmFeOdSyKAb5vzmURUdM2z9isK60MmVe6U9WVOorXW4V2R47EQn2HdovUd9wERMDR4HZUxgCW3b4MoeIBcLYqdRLKZDkaqVVbXn7LMzzMJYSyqeC24DqwRT3HUiBcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB7667.namprd12.prod.outlook.com (2603:10b6:610:14f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 11:01:05 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 11:01:05 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 21 Jul 2026 04:00:14 -0700
Subject: [PATCH 5/8] rust: io: register: allow paths for relative register
 bases
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-registers_fix-v1-5-3711b2317e1f@nvidia.com>
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
X-ClientProxiedBy: SI3PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:295::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a645807-75aa-460a-596a-08dee7175c6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|376014|1800799024|56012099006|11063799006|10067099003|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +OW7WBh0YrQfaRbT/QymUg4M4VI3qg6mEMblPpXfch5FbkGmr6wyGJltWOgnZawaSSdh/UKeCp02UWJ8e9jslPfSbahOA6c8eHvMhYc70C0mIez3tx5Fu8UtQTUnMmBGlDVpJiIi649BAm/HwkjC/QU6+NPVnm9cqzzmqpXtVN0ie6Aggvw+Sk1q86uZBzVf+aStFOBZ6Zegw3KhUcpdDQKgjL2Pw0IcfMQrtnY2E7/nTRChQ1Zy7uo+lAIILUj69cu8nOOQ6as0Gh6rpmdpbSZD4gzCWAAGkmGmU0BPyhmTNRHURZw7ju4CFxKvQDm5XYqpiwaModcQh2yy5j96mAZ2VGOAmTI2PuZKsN1d8R4vPMNFuMpM3qOT+kfp2ImkbV1vXd0lQ/8R2FjCg244G8Onp5ZdKubFBlIi7w7GyzjTjDGTnDWGp0pFxBFRQ5SAbk4I+E6vRFqXNjbVMXgpqcn5No46dX7/YofL4ClKi/kFSzxft4oYZ/OjNWgMT2vPrys6lMjDxqrxiCSPhCz4H1F+Hq/THO5y7H72WPKetNy6DB62uXIR6dpswsU0NhzmCKWU29rqgvLnh6k1UWTIrW3PaqjoevudEA1ggU4rBrmdnSeUwPtIyyKO1VlCzhfy6JqTDuj3i/udgnXLZs3qSYextiXqGqjX+OZaEtMq+owutDPvXoy7Cj4z9JCKOJlr2qd8DUmEAK/2me6Nlwt5+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(921020)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnYxRlREa2s2YlVzbk5JY0NESnEzVFQ3LzNDZnlUdnRDSStiT1RlR09pNGdY?=
 =?utf-8?B?NS8xOWYrT0I4eVNxTzJPREZYRjlnUFh6WnJUSSs3VHZCMUNqM0docWEyUVpV?=
 =?utf-8?B?YzI4NVNiSmU4enJhcWIvUlpZK2RzanE1aDdFVFdWMzBBRThGbDZNaUszTEtJ?=
 =?utf-8?B?SmV4MUNhNWhUb21tNndTd0hKSU9QMG1aUldyR2I1MnA3Mk9DUlN2SEZ1eU9T?=
 =?utf-8?B?dDZqcWpzb2JXMFBSWTVFMmNUV3NVOTJKcUY4U215aUl4WUtsYll6aWt4RU9m?=
 =?utf-8?B?dG83L1ZNSC90RGx1V0ZKeS9hMGs4MVZ2eDdCS3owdnZaT01mU3pCVi9IK0RW?=
 =?utf-8?B?R3dIK2N5a1FVMnhNb1I3b3ArcnRzSDYwb053c1UyZ0NuVldsd21wQTNQbUNV?=
 =?utf-8?B?QnArdDl0cU9EeFVXYUZkanpsRkhKSmYvcGxqOWhSMUZRYUFHUHBWaVJVS05G?=
 =?utf-8?B?c015US9wcGs0dDh6YmNHZVQyWTBBWC9tcStKTitBTWszSVhDY0tSYmhTVHBG?=
 =?utf-8?B?NjJpTWFaemFpSDBaRVBmUW5XcGVDa3BXVjJYYWY0VFAwQ0lhRHBWekpmRCtq?=
 =?utf-8?B?MEQ5Q3YySkx6M29nRnBscUFUWWxpUGNjNUJGVWNEZjEwdFdCdU9KTWVveGZM?=
 =?utf-8?B?Ykl2TzRZR1l0WUpjZWFlRmljNGhSVDViQWlhc1BkZXN2VUVRLzExRlUxcnZP?=
 =?utf-8?B?ZW4vclllU2VBc1N5eXRFejNxeGJXbkFPbWk3UjdZS3pRTjFUc3l6SVNESXM5?=
 =?utf-8?B?RjRZaXVBcXpHVjRwRWNvTGRkVnlTaW10Y0YrTTVnWmNLYk1BeFc0RGtqRzNP?=
 =?utf-8?B?RHZGV1JZOE9nVXlQVk1YUXZGZGpScW5lakR4bjNZbGppK3JpNVJMR05SNHdq?=
 =?utf-8?B?VzdONjBHY0pwMEpFWk9aZWFrUnlzVzYxd2dSd1o0QzVYc1d1UDRkdDVUZVNx?=
 =?utf-8?B?QTNZdXE0R2Y4TlFLSFpQWjJyWmVOOGVITUQ4dURKR3YxZDhFY1hnQkxxTHda?=
 =?utf-8?B?YzEwbi9nNGl3ZjhoSjg0enlsTUxzUUNSMlFOZXFkaGpBUGJrdUhIdTFXdDdu?=
 =?utf-8?B?cWxnKzd2ZDBFL001VjBWME1XSVJNMG1ZVjJBZDlaQWtiN28xRy9QdGEvUUJB?=
 =?utf-8?B?b2UxSEtMOEJzNjFqdkRodEF3d01YL2tLL3lTQVRabEFZb2Y1UG12YVIwVldj?=
 =?utf-8?B?dHp5S05JdUhDdHJQa04yN3gvOFNEbjB5ODBwUnJFTS8ybEdxT255aXltUW5F?=
 =?utf-8?B?d0c2VzAxanc2SGduM1pCaENvYTJKdHBCTGt5Q3RZaXh2V1hDMnA0TWNrYlpQ?=
 =?utf-8?B?RmdrM21nUElMK3M2UmFBZHI5cldoWS9WNzVudHRBalA0R1V3QmtQQWZGRk03?=
 =?utf-8?B?cytIWGUrRDg3UzlBdTYxQmpXL0UrWGVSRFJwNU5VMXNTSDdBaDdTRE9pZlMy?=
 =?utf-8?B?MEVEdU9Yd0xKZ0ZOTkFwNm1TdlQyT1FnYkhHMGhkM2Rxd08wb2p4amh1MnY2?=
 =?utf-8?B?L0dQMEQwem1EUFIvTmV1clpMYmFxT3JaRjZDZytIK21HTmxYVklMallBYVdJ?=
 =?utf-8?B?ckNIK2VUZmNKd1VrbG9XSXlZV1lubnozWnh5c3JiTXpVWkxCZ3gvODhDaW5S?=
 =?utf-8?B?R1RYTGpEbFZYRFBqTFV1ZnpNZVV4QTBpM3JKVDUwN2pEam5iNXYvbmtPVWla?=
 =?utf-8?B?cm5KVFVlSGc5TDc4Z0NDc29tZmQyb1F3N3NKcFdISlpWZlBpT3NLNGhKejRm?=
 =?utf-8?B?VlhLNERVbUhyZElMYzR6Wmd0OTcwSHZkSEJBNEc4ZEluN283NzJPUUpGZzFt?=
 =?utf-8?B?NTZOd2FaUWU0TVZTR09FSllIdHc2eWNac0dNQUIrejcrdkNMMkZzbWlQeWNv?=
 =?utf-8?B?SUlaNEV1b29CM2Y2RFNQNmQycW1mSzhoVnBSRWIxZHFQVTdIYzNiRGNBMHFS?=
 =?utf-8?B?TDQ2bUxtZ1djbE15WStuYXJCQkRGZFpvNGZDWDZQek9BY3k0M0wxY0RqSGZ5?=
 =?utf-8?B?MDZ4bk5rMG9PMG1KV2lBTzdhZlAwTkF4UmhJZ0dNOXRzTFZ3REVaRlRUT1kx?=
 =?utf-8?B?Z1Y1am9vUnBiR0RRUUZOYlorbHFJeDR0dWRmeXplMS9vYmlXUW9pLzRNTGtH?=
 =?utf-8?B?a05MYlBkdWtib05YV2RWTXVWVFk4c2F0bUg2bm51eFA2QmVzelMwbWxtVy9C?=
 =?utf-8?B?bVgra2RVR1dCNWtKbWJYQWk3WXhlK0ZrQzFrOFhvNU5wbXE0OStwMWY2OEJp?=
 =?utf-8?B?YzRMdFBtNE1hazE4ZFlFRCtlVmlibk0zYkJKK3BiN0VoS1lIaEtLbGQ2bGRU?=
 =?utf-8?B?YlVNdzFNOElXYnpYaTA3MldJbHBVS3ZTTkhTdURqNFBtaWQzM0VKZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a645807-75aa-460a-596a-08dee7175c6d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 11:01:05.8034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lyAA6qOu2atn8D3SHqoFshSn9EqEhPnbA6ii4IRsknfuYn9GOn6dkRyQrmPr/kR/adkNc4qvCapElPbTJ83u9A==
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

Relative register bases are currently matched as `ident` fragments,
so bases declared in another module must first be imported into the
current scope.

Add `Base: Offset` and `Base: Alias` forms whose bases are matched as
`path` fragments. A colon is used because macro_rules! does not allow
a `path` fragment to be followed by `+`.

The old form continues to be accepted temporarily so in-tree users can
be converted in subsequent patches.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/io/register.rs | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index 62208f52752a..4070fabb00f4 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -801,6 +801,26 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 /// ```
 #[macro_export]
 macro_rules! register {
+    // Deprecated `+` syntax for relative registers and their aliases.
+    (
+        $(
+            $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
+                $([ $size:expr $(, stride = $stride:expr)? ])?
+                $(@ $($base:ident +)? $offset:literal)?
+                $(=> $alias:ident $(+ $alias_offset:ty)? $([$alias_idx:expr])? )?
+            { $($fields:tt)* }
+        )*
+    ) => {
+        $(
+        $crate::register!(
+            @reg $(#[$attr])* $vis $name ($storage) $([$size $(, stride = $stride)?])?
+                $(@ $($base :)? $offset)?
+                $(=> $alias $(: $alias_offset)? $([$alias_idx])? )?
+            { $($fields)* }
+        );
+        )*
+    };
+
     // Entry point for the macro, allowing multiple registers to be defined in one call.
     // It matches all possible register declaration patterns to dispatch them to corresponding
     // `@reg` rule that defines a single register.
@@ -808,8 +828,8 @@ macro_rules! register {
         $(
             $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
                 $([ $size:expr $(, stride = $stride:expr)? ])?
-                $(@ $($base:ident +)? $offset:literal)?
-                $(=> $alias:ident $(+ $alias_offset:path)? $([$alias_idx:expr])? )?
+                $(@ $($base:path :)? $offset:literal)?
+                $(=> $alias:path $(: $alias_offset:path)? $([$alias_idx:expr])? )?
             { $($fields:tt)* }
         )*
     ) => {

-- 
2.55.0

