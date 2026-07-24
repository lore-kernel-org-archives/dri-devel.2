Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D4B5C531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 11:37:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EEDC10F379;
	Fri, 24 Jul 2026 11:37:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="nj7HB0S5";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013011.outbound.protection.outlook.com
 [40.93.196.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A26610E04E
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 11:37:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTT1Gukcno7sj6uJrXqFyzj/gSecWM0dEqZfiJlDaR7UuNpfnuNnHEZkrFYpKXevwEHVtfZ98cNf2x5MxbxDpfEnGGkc7FDgcTrNl+GKrzNnOpgw55vt3znYb8zNCo3NSJEj5TwDPZ56e3VIiBR8sSzVt4GoADGiEgCaacEVpyVU4gnKQvbWWmR1/vWPxTfOWwWEsTh1jrrTeGunSmDgcl1geo/8cddf/ZGMbuAbZ9stfMEg//cP4ezTycwQZDeVbEQGx02fTInOCzZ2ae/VdTjuGJwPszPScJAcj4mB0xB1rCHTSf+argFpGSE4Z8P1bAizL3o0KqEzitgQ6Yh1gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/6Ebh2jF1Cnq2wX+MZQQgSgS/db03IYW4ILczb898Y=;
 b=Vd5O8Q+I1lS5sv3fHYqg/1PLNz6PCrOhwiisBgLZsKVFN+N9ngopfqbfitr1HhgHg54X3WoyDSEMe7v1J6G80LmFXmbBLJGNzeLO5X2L5NRWbthEbWpi60ZUqooZDhMK2EJ5//Em8w6xOJGgFiq++EAx9SwAtnLVYj86XYPnxk7sNFhpMxmvuv+J8RZT9F0jkoACTg+iSGjhsnKqhdXwn2roE/JKvJUhpuPSFQ/aUKInZmuH16zuLp5C/zKs3UgqCI1NRv2txEf0Aiy7wm+PBPqxDHIgBP0uwt3Rt2u1aB5Q4rycmoIzVLjUFzMv1FGTE5c6xOs3kF6RlRGtEF/Hpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/6Ebh2jF1Cnq2wX+MZQQgSgS/db03IYW4ILczb898Y=;
 b=nj7HB0S5xWX/gronHlQ7GUoGuWXousP0bHSpjFhrgX6cLEDm9H/Sxcj+yTIr9/ehM4q+M/5DYrLZWEn+Zt8sjmlhCeOY3LDPHyguhlBNdiOhhrSaQmNxHlMHjSPM8zNg639KtWyqRuQ7LsIXTvs8bd84WQod2mi/D/9KwvHVDGLrwEDmO7bDuFwCAXGMpIwcBU3ntMs5muPjGzLZVBIN0D1LmAqmAVnP1DIEYP4zOT903hQRwdoWgduXbjnSXpltv6zTpMgWL/ThRQAeRKOvvjlKR8JUSPs/I2nyqqMwFrU5xMh6Fbi0F+zpGarEJ0XTZQeFujPfRg0zL8teZULadQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW4PR12MB6974.namprd12.prod.outlook.com (2603:10b6:303:207::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 11:37:18 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 11:37:18 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 24 Jul 2026 20:37:04 +0900
Subject: [PATCH v2 1/3] rust: io: register: dispatch shortcut rules internally
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-registers_fix-v2-1-a0fb58b02185@nvidia.com>
References: <20260724-registers_fix-v2-0-a0fb58b02185@nvidia.com>
In-Reply-To: <20260724-registers_fix-v2-0-a0fb58b02185@nvidia.com>
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
X-ClientProxiedBy: TYCP301CA0068.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW4PR12MB6974:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b1d5b4a-0d6f-418f-f15d-08dee977eab9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|7416014|376014|1800799024|366016|5023799004|11063799006|56012099006|10067099003|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: Eynf8v8LoQ84tBf8ErqrAJQDcfDUKRldewUE4Qm9QcGKvXs/B/MKm7ioOBhJK3eL8+2ByS9xVJjvqjiHNX1JJSuycq3eIC4AxKg6aQ6THL2vPFq0aqas7wUymbBPlybCPS5DatXWPNubGN6r4uIfpfHUz7klwq4cmddCfSJ05sSJTCTYO1P4j16vfLWY5PiaHqJQlrSjlZXbUAcwh1F96Betru2XOsUg64ATEBp0z18XCYq/ccN7dxKrOG8DvKlMBDr/ZNEVjWdypxZg3i3pKLC7Lks1xzm2/ZHW0Ph1ekt3tSzELkIJMu1S6TxDQwzCZOO3LWmanM0vCARoQ4uq4n1wVKZb2n2w68mElUtXkLskqC8q3djUna+TzDPewQXIf4LKJjELCuNt0ynXG/jZrTpB2zhZnpv9qVy6Bf43B1nuFES0UO7EauxMLpH/9Jh1cm9Fe5g1r71i14PG3A71PjnyurNUYp2qXkCWRIc7anbP/chwVEAYW2tVDZbSeV3ZXwVd2LyPusnz592gZ2TfIo5in4sit2kXZj3mqWcpAWWjnS6DG29BJfrXqZfNqij9B2gMlyNXrc2gywqXX8pNVnj+oY0B7ZXpSCBy3ylnrAoPANvsFiUczy5TUM9jhI4CyAWPWvOeGpXh5B+9dXfMm4QBR/6YTMcWme43vKs0CTEP6mGsQO+2ymCLHjCp2dacHsCCYZYhJeNKtuNNFpjRVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(7416014)(376014)(1800799024)(366016)(5023799004)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0QvZmF2SmxBdWtYSWFzWDVrVVF3THBOWWRhM0RBMUVjTjdaLzUxcm5sbFpa?=
 =?utf-8?B?am0zeHVFaTJXcXl2K3g2Zk9icGsyZUZmaGxPdHFPbG1TcDhyU3M0VzNrbzBt?=
 =?utf-8?B?Mm5LNVlLT2U5OTBDZWc1bTZYQWQ2d2ptWDB2bGMrYWgrS2xsWDdsZlVzdjY1?=
 =?utf-8?B?b1R3WUJoOTNpaWFPWWV0TjVDQXprMkRxMDNPRnVMeHB4OW41S2pxNTkrZkMy?=
 =?utf-8?B?Rmd5NWFjSHB1TnFCQXN1bnhrbzN1eWRteEpmYU1yUnhJa3RQWHN5SW1WSHZI?=
 =?utf-8?B?ZkZ3cm1LaTBNa1N2R0tzbmNMam4rT0QraVhLZUxTeHZwMFg5T01UOXRFelRn?=
 =?utf-8?B?UkJHbk5DcXRYaWREVEhJdW9tNFlERW9mRy8rZ3lMOWNrcndPZGpsVjJwcmhm?=
 =?utf-8?B?bnhjS1c4ZVdHc1R4UGU5c2xXNzZTWkdGOVh3bUE2K0hLTEhPUmNnUGhRd0sx?=
 =?utf-8?B?N2JKazdJSFFZWkFIWVpxYk1YVWptaFJ1czlNaFpKcHdtRUtJTVNHQlpvM1Fh?=
 =?utf-8?B?bWdFUXFJWlFjUTJVUXNzNms5NDVBYnNNOTZJazJ3UzlCb2ZER2YyYk84L2sr?=
 =?utf-8?B?RHRZeWJtd2Z5anhwaVZFM3Z0TldNUHU0NndBbEdGRzlPUkdIQnJBVE9BM2V1?=
 =?utf-8?B?UHVXSnh0SmdWSWJKYnJqYVFMZTZ2TFVwczFLRnRCaUh2S01SSjMzRjhhY2pI?=
 =?utf-8?B?ZkxFYXNaNThIc0w2eGxYd29vRmFHNk1rS3ZCNzl1dkc5cmRuaHYyZ25xaTVD?=
 =?utf-8?B?ZDNGK0NibEtobTFjVFIzaTBCcDZZLzUxU2w4azhvS3QxdXoveDlxeDJxZEYr?=
 =?utf-8?B?TGFIdmU2QW1LNUxYSStwUVFUWTBHN3E0Z1hWK29nV1JYTngxWTZ6cFEya0JU?=
 =?utf-8?B?L2FHRXNiQzdDM0JzMlprb1JFOWVmK2lRZXhsaFpRN3JzejZTVDZjL2V6Rk5i?=
 =?utf-8?B?bkpSWmxGNTJwak9xQkxIUEdac1NjamJyVFdDWU5jOC9qeEdDdUpVU0FoajRx?=
 =?utf-8?B?MnRoWUtwMlVNZzJ4QVczbVBGdHJxeDRhK3FENEsrRDQxSUF3QkVNQmxPd013?=
 =?utf-8?B?OGxzVUY5OTk4WmI5TGR6ZFRrdGp2NkR4Wm9PRDd1cE8rc2NXai8ra2FxYlZV?=
 =?utf-8?B?dy9qOUJVMEZERVAwa0xTT0s5VUJTSDJmcjRwZVpySTRiUjdpUFRPb2xzTUNj?=
 =?utf-8?B?cFJCL2h1UnlycHZrSGJtQkNGZnhabDRES1J0WkhacDBiTVRIaGNCSEk2T2Zh?=
 =?utf-8?B?dUh6R2JBQjZLaW1DdXRweE9RVDZFYm5mNEVsL1UzQUZWeVVQd1JLa21JL3N6?=
 =?utf-8?B?enpsUVFtdmJCZ2MvN0x2M01LMUttMUliR2l5QTk3TFFkRGllWE9nbExabnpO?=
 =?utf-8?B?Yk1tWm44NjVqQVg4YzdrRGZjMVRVampESm9pTWhkN3hzQ3dOMDFzYXIxTTJa?=
 =?utf-8?B?SFl4SHRJOVlDeHFFciswclhuYzE4eEhhdjYweFlOMjdLVzAwOTd3SlJXamxm?=
 =?utf-8?B?RkpMb1VJdDNjR1ZuZEtwbmkzUzFUWjBmNjFjMmNCZkd5a3pqM1ZDZkY5VThP?=
 =?utf-8?B?eDRraForM3hZZTJRVDNYRldwRXBWb2loSU9BY1FtTnRWcVd6dlJxdVVvZVVa?=
 =?utf-8?B?K256TjlFU2Jmek5Zd1RjcGY2cHBmVWJmRDg1QWlzb2tNdDVseUg1WWVJdkU1?=
 =?utf-8?B?Sjd2dWdpUVZpa2Z1THhBQmhBR3JBUWw1VmEwRjdyUVk0OFR5aXhscmYvYTEx?=
 =?utf-8?B?azdBZURWQWlvSDkrVjByWXhCd2FqQWRLODc5Zit0K1d5K3lKcjk1Q0tmYnlL?=
 =?utf-8?B?NFE5eGF0Snh2QnRkeDNjekxwc3NBSys1a3FGWWUwRDZhdzAzZkplb1dPdUxN?=
 =?utf-8?B?dkZMb2h1a29hTUY1NmtoMDJnVDFUNG5QdnVuM3lPdHpJc1V6YnJCd0RTblhp?=
 =?utf-8?B?Y0lTMndEOW1GM2I1alJVei9Dd01BeVVXZUxQZFN1RFFQZGNBWEtCT0VmN1Fk?=
 =?utf-8?B?dUZCL3BGR25vRC9SWFoyZG5lMG1xYS83bVlMd3k4VVV6OEpUZjhlQjMrTkpU?=
 =?utf-8?B?cUsvY3ZsQ0prSXBaZWt4b3AxRHNIZlBOQ29LdHA1L1p3QUhGamM4b25QaHFr?=
 =?utf-8?B?bk5PTGdScHFQZUpLOEs0QzgwbU9YS0RpM2ErbEF4SjQvVk1aZ2NRd0JIaXJy?=
 =?utf-8?B?UlcwMkZBL2I5dmdHM3QvbzZhbHpaNWZZVEpOS1EvV3NCSzdIZnFBQ1JwdlVu?=
 =?utf-8?B?VGQrVTFCNGhWajJvbGhkSENxUzBLNTBrMGYvcnB5K2JaK1JMNzRvRFlGaFlF?=
 =?utf-8?B?cDZhSmFtVFROZnJjNUxoeTEybGo0U2l1ZE9HdmM1YTNnb2lHOFF1R0gzUzVp?=
 =?utf-8?Q?gjzsxxIs5MhfQTycN3/vzi5k5ooIwvsu3Y34RTYR6J189?=
X-MS-Exchange-AntiSpam-MessageData-1: A0ljJphwYmSlQw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b1d5b4a-0d6f-418f-f15d-08dee977eab9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 11:37:18.3033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wGrgk0kECXyO6hH0crCJngN8+EVlrH6Fb/Hb1aW27wv5F2ffXQ1qBXVUPnMMrRjpUuD8TTDlzoDNA0xTel0VXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6974
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

A couple of shortcut rules redispatch an already normalized declaration
through the public register! entry point. This is unneeded - the public
rule should only be invoked by users.

Dispatch directly to the appropriate internal @reg rule instead.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io/register.rs | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index 80e638a892d7..e9ee8c2b60e7 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -888,7 +888,8 @@ macro_rules! register {
             { $($fields:tt)* }
     ) => {
         $crate::register!(
-            $(#[$attr])* $vis $name($storage) [ $size, stride = ::core::mem::size_of::<$storage>() ]
+            @reg $(#[$attr])* $vis $name($storage)
+                [ $size, stride = ::core::mem::size_of::<$storage>() ]
                 @ $offset { $($fields)* }
         );
     };
@@ -932,7 +933,8 @@ macro_rules! register {
             @ $base:ident + $offset:literal { $($fields:tt)* }
     ) => {
         $crate::register!(
-            $(#[$attr])* $vis $name($storage) [ $size, stride = ::core::mem::size_of::<$storage>() ]
+            @reg $(#[$attr])* $vis $name($storage)
+                [ $size, stride = ::core::mem::size_of::<$storage>() ]
                 @ $base + $offset { $($fields)* }
         );
     };

-- 
2.55.0

