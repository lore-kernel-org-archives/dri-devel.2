Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BEC6C44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 11:00:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7E3B10E8D9;
	Tue, 21 Jul 2026 11:00:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="BG3t0ykI";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010041.outbound.protection.outlook.com [52.101.85.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5AA210E8D9
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 11:00:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IDfcJOrW/yMJ71fsn8uB72A2JPU54Dmt10q7nOy7C4K0APFJNehGiP2hnck2/rGTMoahM0bKwZdVCToqpR79pvotpAJtRXl3x4odLexgVuc+QFeZ+K4IdICrWZz+crGBM+4s920jXqWQpSKuwSnqwkbHoVg9VZROx8uNexa9mKse73g6UlDUDtjqkW3023sr+VR0CvkWcqymcXamYSkYJDspBfx3oDuVmVC+cf8rtM58Kznl0hHh7/K3bdyM15X0wzALPwKZOrYDA7fO39raYFOHvoVAIWAQdRjbrNlkBlKKX4Hu84XUkVLtYxfwwKunjNa4t5LNZWxz9YAirvMeRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyKa1BSq82m9/dqjjdW8sYP2tagw8HuQ+NPSc4t44w4=;
 b=Vkj8/l64EmDkivK+vfSqosUYEOmbS/DbgUYYGLc62NigH+5qyQW5KJYT/OnF8lz84QqAxsi2xMweGCUwQFTNY4qrYtJWUEHs3pvRTIjdfx0yLSTeQw2k6kU+bGYW3R0Rvb8EAkUd1sSKLo1DbTfJDJ8kEf108LO6jCeOI8TXvWSyWfNAv02bGs798WG7IwjTcvLcEwHnkeM186AAj+sd0y2gPs4aTeoNkYjWDhQ4r9KdHensM0ajW1qM50D+DByXgM833Q9BVOqcVnw8VJnbovsPWjuZcz1t6IN7qV4SXk7O+ErMoVNfGKU8vZDMn90LMyoG/5TIEB1fi11HHSoBwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyKa1BSq82m9/dqjjdW8sYP2tagw8HuQ+NPSc4t44w4=;
 b=BG3t0ykI0IsZ3wMly8TzZpvPd4hz8NmOL+sgvN03xhAF/UpJUBX1p19HT8C2OTveSA7s39+apb/oq4KVT6TLkTuV3eh17ElaJuY6Khb7z3LA/4TNcDWB2vVenxyDqiRbqhYDdQgjUuju7/Dd7DWcrUhv9uIlrp9/185h0Rt93LX+ft9WJMGud7qze9cBZRFB51j7waP17Ybg2WwDufU/TLTWU1zPV7WaGye841odIQGtyBof97DnzmJH4YUr/pqyZFMYpdsuzHQ2TZXtv2M+erbyrc8PMikcx8c+dtgXjG4TdxxGyrlY2sWpMIcc3k2XIA2TMTccrpOFhnjD+24xFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB7667.namprd12.prod.outlook.com (2603:10b6:610:14f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 11:00:45 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 11:00:45 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 21 Jul 2026 04:00:11 -0700
Subject: [PATCH 2/8] rust: io: register: remove unused rule arguments
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-registers_fix-v1-2-3711b2317e1f@nvidia.com>
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
X-ClientProxiedBy: KL1P15301CA0062.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:3d::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d2b5854-e88a-4cf2-c6d8-08dee717502c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|376014|1800799024|56012099006|11063799006|10067099003|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1Fnt+TJuTvovwKPzca6oAlgrTa958osKTwS5ZMLTJWKNcgJ+mvMcnGeEX3onnfxrJlWk3tTeGL/h+CMC5mk3qev2cktVh9eanlC27zpF5Dg2M7zoTnXIN4YRmJCJtHLyTlVyM5ZFGNDoyQtOBR833gXPIuO9ixaJdy7Z3IPsqBBvyF5qHwa0Ont+XBXjP+rZ2r1c13rSRJVFi9hqcYLCXu5ZVziWdifJILyJyL7y6WC/XsGNbaxGwvP00bA8MQH3mgU5hTrdAIYeRMoePPvG6sIMb2OTdgOT+/6cb0USuqk9caOv+sE1jVKCYKt8adUIkLuIdJkKqmqw3iuaCPCX3VIow5/xXgDKS+fRH5Ks1Hfadzf0fm7txWY8BwN5WVb3KHjl+I0CWTKDQTaTLJ8tUPwUQ4R9McQclgq1XSKhQsJWeH7mJXnOM06rQuMwtp5rXeftzycMBu2Z1Lh6L08QNVCDWWo5w5MUqtRHJlISdeNQMDInBRRJmpoOQjkAL+IpH8JzYnrtiPUI0XjTQXb7FV/2WRHNQOcgOaV7gfWyQgT670jQEtOPg+/HlOcDLr2TOGX8jeqfy2xkLcbWcjJy1qSPgTS36o99QY0QGQJR+yQKHJVgsH+NanM6R8XFQU/NMGvTXUDslJUJKbrBVUEzq1Kw5GCWxqGPqqBUJXzkGE6A8UPSI1yTn6gootppaZp0FHCag9YE8NlsmNiJFqls6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(921020)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NS9hMklkMjV4NHVWNXJadHBpWWJpenI2cmRjUzZSTUxDYWN3QmhzVXM1TjlZ?=
 =?utf-8?B?RFNaUWhuSm0wU0R6cGFFUGhUd1h5VGwrNXNLSmF0Qk8wOGJOZnh1dWxLd0g0?=
 =?utf-8?B?ZEpnTmNsWEl1NnVrSEM3b1czbk5lRVdiWXEwcC9RZXdBU2FTMUFDUzhueEp2?=
 =?utf-8?B?SE95OG9uYW51WlE1ZEVCOEpSM0RWRFRTb3FubXNuT1lPUU5vODNuTTFxelFL?=
 =?utf-8?B?QkNKQXMvTVUzTEpkN2JQVlUyRVRsZE9MS01KV3RjcDExNXBxZkpYNXI2bFRN?=
 =?utf-8?B?dFZjajJNUkR2blBXMGpybWxNOWFqU05NUTM1YkhIU0Rvc0wxOEdyTHN2MVpT?=
 =?utf-8?B?d2h4YmptUnI4aklVUnJVRlZrNlZFRG5VSjI4TzU5NzZIbEhQOW1USjBDR2xH?=
 =?utf-8?B?T29QRWlLeFJIYlRNWDV3VUlTTkptV1MyL3hrdi9mZEM3SnB3RFgydHkzeGFt?=
 =?utf-8?B?VitIMWRPR200WXdvMkM4MWtlWm5HajdvdTJrY1FpRDYwTnlDYUZNTjdtaENG?=
 =?utf-8?B?VXZTOC83WXF1SXdTR241L1l5aW41UXFqd1p3N0VnWnRWRlJKZEszY085b3E4?=
 =?utf-8?B?cTdEUk9CdnNPLzdPSTRPYVRvV0cyWEtkazM3K05lK0VHVUdqb045TXVVNUNr?=
 =?utf-8?B?RDl0N2VqU3Y5enYxY003U25DNXd6RGJDTnBkRXoyRkdpK3pmaUdwcW9rUThF?=
 =?utf-8?B?akRrL21hQ0pMWDVuSXpJT1QyQlpEeEFmODI5QkplcEhxQXo1cTBHMktuRTJE?=
 =?utf-8?B?N0hWcEJQU0lqZFIvaTZuVXgySjN1TmZtRjl0RlFQeHI0U3N3d3ozNUt0bEV0?=
 =?utf-8?B?Z3VDc05Zak9QUUl2aFowSHhJanpNT2w0YXRDOTVQV09xTUxQQXFTRFk3Kzk0?=
 =?utf-8?B?emJ4cWdoNVVuZzlnM1hNRTJKWFYwQ3NxUVFoRm1jWGZrME9BSmpzUU5QeW5O?=
 =?utf-8?B?M3d6VXFUNXIxUDBLRk5RVjdoRjVmYm1oeGYyV3JLeWtDNUpMMGNzaWVZRVVs?=
 =?utf-8?B?cWM4T1ArbHZwOEk0cmJVbXZQbnNTaUJtS3NVbkh2UW1Wa3JINmFsYmZuMndC?=
 =?utf-8?B?eHB3dlhwSHE4aDJBK2Q2L25uamdrZkJuSDZ1VkE0UzVzUWk5NkdCTCtqWVo4?=
 =?utf-8?B?WEttVmc3dnlVSFFONEFROTI4N2ltamJvdFVDdjdOOFFQbnhCYVFGckIrV0RV?=
 =?utf-8?B?T1dKaEszNFh3eGUwaTdBL09RTEl2UEhTNzZ6NkloMjhXOVpSYTZmVlFaejlI?=
 =?utf-8?B?aEVDcWhjWlp6a0NCakRuZjY1bStkZGlQK3NvKzA2OWRwa0phTnIyb0tXR0RN?=
 =?utf-8?B?aS9pa0hQZnh4ckR6SmVHbEgvdE1zSTlld0dDbEtMWFJLMFd0SHVaczFYMVJM?=
 =?utf-8?B?aFRkV1hTeWlybjByS3B5ZFlKbTBsbzBjdlBhMjlHaWZ1cG91akxVRkN6MjVn?=
 =?utf-8?B?SHZxd0ZsSVdNNDZDT2QxRG1xQ0p6L05WNjJXdHlIeHQ3ZUF3UTR3cHRSSGFs?=
 =?utf-8?B?Q0NqWDdpYTk3VUlTcTdwSm41akJXUmF4L0VCSEM2cGhtYUhXVzJzbzhLbDhB?=
 =?utf-8?B?NU1tZmVXazE2THkxKy9SWDBLbFBVV0FQaElGSldrV2xHMWVzV3dJTlc1SjRY?=
 =?utf-8?B?Z0IwcEtxQ0ozMTNSS2VRU0MxNGdTa2VwVmZwSnBweXRzQzVTYU9XQ2Nkbncv?=
 =?utf-8?B?TTB6RmQwZEJlZXNuYktqampKUU56eE01VVYycTJrSjRvZXJTQ0JLdll6dkR6?=
 =?utf-8?B?OTlvRHdTY3BlYXdXSDh1TktPMVkyTy90d3h0NlVTVkM0SzNFMGg0ZU5FMy91?=
 =?utf-8?B?WU9rdDdBLzJnaWhWaHlpQnlsQTBRSGJJMzFYVFNua0lkVG84N0xxMG41VXAz?=
 =?utf-8?B?RDgyb0tZc3dGMnUwS1lpUXhwaDZTS2FmVmE5d1pjUm1PTWJ5V0xGMTdIRzZ6?=
 =?utf-8?B?RnFDeVZOYkNPR21NS3piWHFYbkN3dXBiTXhseWV3VFZOWUl6cDZ6ai83VmRk?=
 =?utf-8?B?dmwzUjZ2UEhpYTZNK0Z2Y0YwZ3R5dUhUYjhkZk4xSks1RkxGVHJtNGlVVXA4?=
 =?utf-8?B?Y2ZpdHJWNVhQN3lLTm1pbS9NRXhEaXluS044SE11K3pMaTV0VTMvZVZHbVlw?=
 =?utf-8?B?UjhHaXg0YXNMU0cyNWd0dFM5N2dPVC9ZYmNFU1RoYUhyRm15cEg0anhHUTJr?=
 =?utf-8?B?WkZKVzJPQzhpUys3eXEraUpyWGRzaW1PSmZLKy9waU5WVXlNRFc5QlIrbnVh?=
 =?utf-8?B?RmhkRFNXTDR3eUZza01LdHNrZzV6TzdPb21mZjFXclhiNTBmdGFnOVdaT3F6?=
 =?utf-8?B?RGhpOXZLaHg2UXo2MVpUbW5XMEtHclN6a0xjc0QrZWhvQnZkbStGQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d2b5854-e88a-4cf2-c6d8-08dee717502c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 11:00:45.2098 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6j4HHPwwxTZYvZBf4/37JDQLWtlcXTZRrFqhfd7NB2ooW1Tqp8tHHgEHdvLJW8tMsU97ZP24pm5L/SaDqG7QPw==
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

A few arguments passed to internal rules are never used and just add
unneeded complexity. Remove them to simplify the rules a bit.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/io/register.rs | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index 27a9fe45b06d..82f674aea45a 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -832,7 +832,7 @@ macro_rules! register {
     ) => {
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
         $crate::register!(@io_base $name($storage) @ $offset);
-        $crate::register!(@io_fixed $(#[$attr])* $vis $name($storage));
+        $crate::register!(@io_fixed $(#[$attr])* $vis $name);
     };
 
     // Creates an alias register of fixed offset register `alias` with its own fields.
@@ -845,7 +845,7 @@ macro_rules! register {
             @io_base $name($storage) @
             <$alias as $crate::io::register::Register>::OFFSET
         );
-        $crate::register!(@io_fixed $(#[$attr])* $vis $name($storage));
+        $crate::register!(@io_fixed $(#[$attr])* $vis $name);
     };
 
     // Creates a register at a relative offset from a base address provider.
@@ -855,7 +855,7 @@ macro_rules! register {
     ) => {
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
         $crate::register!(@io_base $name($storage) @ $offset);
-        $crate::register!(@io_relative $vis $name($storage) @ $base);
+        $crate::register!(@io_relative $name @ $base);
     };
 
     // Creates an alias register of relative offset register `alias` with its own fields.
@@ -867,7 +867,7 @@ macro_rules! register {
         $crate::register!(
             @io_base $name($storage) @ <$alias as $crate::io::register::Register>::OFFSET
         );
-        $crate::register!(@io_relative $vis $name($storage) @ $base);
+        $crate::register!(@io_relative $name @ $base);
     };
 
     // Creates an array of registers at a fixed offset of the MMIO space.
@@ -879,7 +879,7 @@ macro_rules! register {
 
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
         $crate::register!(@io_base $name($storage) @ $offset);
-        $crate::register!(@io_array $vis $name($storage) [ $size, stride = $stride ]);
+        $crate::register!(@io_array $name [ $size, stride = $stride ]);
     };
 
     // Shortcut for contiguous array of registers (stride == size of element).
@@ -909,7 +909,7 @@ macro_rules! register {
             <$alias as $crate::io::register::Register>::OFFSET
                 + $idx * <$alias as $crate::io::register::RegisterArray>::STRIDE
         );
-        $crate::register!(@io_fixed $(#[$attr])* $vis $name($storage));
+        $crate::register!(@io_fixed $(#[$attr])* $vis $name);
     };
 
     // Creates an array of registers at a relative offset from a base address provider.
@@ -922,9 +922,7 @@ macro_rules! register {
 
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
         $crate::register!(@io_base $name($storage) @ $offset);
-        $crate::register!(
-            @io_relative_array $vis $name($storage) [ $size, stride = $stride ] @ $base + $offset
-        );
+        $crate::register!(@io_relative_array $name [ $size, stride = $stride ] @ $base);
     };
 
     // Shortcut for contiguous array of relative registers (stride == size of element).
@@ -954,7 +952,7 @@ macro_rules! register {
                 <$alias as $crate::io::register::Register>::OFFSET +
                 $idx * <$alias as $crate::io::register::RegisterArray>::STRIDE
         );
-        $crate::register!(@io_relative $vis $name($storage) @ $base);
+        $crate::register!(@io_relative $name @ $base);
     };
 
     // Generates the bitfield for the register.
@@ -980,7 +978,7 @@ impl $crate::io::register::Register for $name {
     };
 
     // Implementations of fixed registers.
-    (@io_fixed $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)) => {
+    (@io_fixed $(#[$attr:meta])* $vis:vis $name:ident) => {
         impl $crate::io::register::FixedRegister for $name {}
 
         $(#[$attr])*
@@ -989,7 +987,7 @@ impl $crate::io::register::FixedRegister for $name {}
     };
 
     // Implementations of relative registers.
-    (@io_relative $vis:vis $name:ident ($storage:ty) @ $base:ident) => {
+    (@io_relative $name:ident @ $base:ident) => {
         impl $crate::io::register::WithBase for $name {
             type BaseFamily = $base;
         }
@@ -998,7 +996,7 @@ impl $crate::io::register::RelativeRegister for $name {}
     };
 
     // Implementations of register arrays.
-    (@io_array $vis:vis $name:ident ($storage:ty) [ $size:expr, stride = $stride:expr ]) => {
+    (@io_array $name:ident [ $size:expr, stride = $stride:expr ]) => {
         impl $crate::io::register::Array for $name {}
 
         impl $crate::io::register::RegisterArray for $name {
@@ -1009,8 +1007,7 @@ impl $crate::io::register::RegisterArray for $name {
 
     // Implementations of relative array registers.
     (
-        @io_relative_array $vis:vis $name:ident ($storage:ty) [ $size:expr, stride = $stride:expr ]
-            @ $base:ident + $offset:literal
+        @io_relative_array $name:ident [ $size:expr, stride = $stride:expr ] @ $base:ident
     ) => {
         impl $crate::io::register::WithBase for $name {
             type BaseFamily = $base;

-- 
2.55.0

