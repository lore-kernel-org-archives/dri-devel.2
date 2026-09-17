Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D34EC982D2
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:35:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E53110EC74;
	Thu, 17 Sep 2026 08:35:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="CpIcKBIS";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010055.outbound.protection.outlook.com [52.101.201.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B2CD10E663
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 08:35:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJwgZzZ2EhyOQWDZxYuwGXP2azWw6YLhAWKCZ8X6lvWzKue1RhVbH14a/n6RTY4AAGuqgZfnuacvHnZzNAVUKC9E+/BbWRPL9KvRHrzeOAEoEo+u1yE++yPwsoz5YxXldHnT5Xv+1U0QeGFjBUXgABcvIPjqPW6l3lqM3OIekEJi7xFeuwy/L5ZOM/lwp42kasB1gb9tYuovPC8Uiag/ZUuPMieOczHYFpdCKFaAKuA2kF4cC8BX72uieEwIIQcHN0gOyam17fmcVzF2WYSC2PBW3ltAJstaoBfgroIXp5h38AFhqpZOoJzzIuM3IjAnPwDx//cvh7frwQVAW7L2sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQ/SwdTfDHb0DLot1l3ciHVfNbIYKzXb1zX4QVILZSM=;
 b=iFrNVYCCHjxvRuIvF9mHn6KilDuXWHC90gVC9rIlB4zFAAZuiEo/SQHrc1F0JtwNxdG64pRFMw9v8AnFDBzG9f0k+n08T31G+YdIUnW4hsRHe3aKzcNToVIALUIzhKOdO7Hwbqs5N+/yU4GLgvZIZFzMzBcmgU1DhVvaCP+SLahP692kTla3OHFxuUOGfbHjlQiBlB1OzzcF/J0iMZYxWlwihWRMV6naB7coX0NDK7cgF/Z7K4fnf2nBqtVQYM9mEoYWLJ/tUZ0Xv0KeS3idPU3moz7UD8M7HXEnrNxWw5MXZ4ulG4x979fTtUlw3jCtxsgmpVW+63biWwl4GDdNvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQ/SwdTfDHb0DLot1l3ciHVfNbIYKzXb1zX4QVILZSM=;
 b=CpIcKBISA9UIL50Q4u0M7tz5TeXv4V3QSxQuK40LWeduD1cExeX+uacp6UlhhlU2Pg9nSwq4zAnHJA20coGGLYOMGy02D39sHY+cKsJz1oWn+w2c2C6kMT3qd3ZFxlRUDEWjwyv3qjuqNJQRYVCaQgpOsnBXfRbHVgcYmr6ZGHnKEavImkbO40uA7cm+EJ32lkacrgDP2DgUYmMNhOR/tF/5vKBfFHmAVo2ytx/ndkwoNBjdbXGcGAwrZ1w2kvIKEjeYJd3W24P3lJmYR4SFruA21mk18hPsflQeoemnzKoJmd4XximhpUCfZq2uUs5nPb2qK6UvRbe6Z9ggvwHv0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Thu, 17 Sep
 2026 08:35:18 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 08:35:18 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 17 Sep 2026 17:34:51 +0900
Subject: [PATCH v4 2/2] gpu: nova-core: use cv! for constant casts
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-cv-v4-2-547ef5727451@nvidia.com>
References: <20260917-cv-v4-0-547ef5727451@nvidia.com>
In-Reply-To: <20260917-cv-v4-0-547ef5727451@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P286CA0039.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b2::7) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|PH0PR12MB8800:EE_
X-MS-Office365-Filtering-Correlation-Id: 25b7c317-13fb-4574-c258-08df14969ad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|10070799003|366016|23010399003|6133799003|18002099003|22082099003|3023799007|921020|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: f8L2LMD+ItrMlJjmecWwkS8YHQyNO2liSJIad9KIrfyog6XYn/0Am9OAAEI4Chu6/ZngRnCdC5s2gTmIhwGTFzAaytR5mZQfjfA1TUnHl0kyLKsKu5Qc+0iBE2nJNAcdt1rNaqiaqCBjS/eGm8X4L2pod13gMBuEdKoZLd32783ph2YtrYCULo+jCdU72HGecyLoh4UvUA6tlthCAhqoyiZpiM59V7q3/SaOiM/gBd6DQdKn7PCdqtUUGGH4/509HAihAAFy/YlruM8GGyEinKZw2T766Zj3ZHin/pJ82Msx6MT0Tvh6KRJ8FlD0WViy7W4nK7wIVOOpPKr0ppWxODCbkonA3DLZ7MVNWGCXxIqpAbwbhJ3+d5kK5nlsBcck8VPiTRPo6LAEU6fYpTo8IQYwaOPKQ+mQ+krQZe5SQPSbsnBHNGXkvWtWelSeyrn45fPMnUXa0JXo7E/TRmAUvreUk3YWvlrAXFA9dPECT7QffeLn2L1s28giM7D5AmHiwARZAvwjWcZdPsyysdcmn6xQaIZis7JN5LuusIS1BqJTh742kD46p7OIL8QgsYgNHv03AdVvhk8AyBsgr85BXyz8w6HZ72JvujLYeoP87paKuI7rMPyLK9ysvFWyq6UfGY1aY2DPRFU1ulpQUrSB4PZvf2t1TTUg5xOTBJaPX82lbQwY3koYwRhHsIQNitm2eCHx1x14qIXHCReTnQXyEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(3023799007)(921020)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDNLYWZBblZjVVBEc0RzWGVPOWtuRDNRMzVNS2FaNUNIaU1hWFMvK2dJMlli?=
 =?utf-8?B?WE1kMFo5eklVZ09mUGZnWmg1NG1WWmpQL3ZBN0RaWXhXNkwrT2VPVHdnekdM?=
 =?utf-8?B?RmZHRVdkRllISTFtMlpIR2UydDFMdFlxbyszaUZnZEE1aVVYMHJVblBqNFk1?=
 =?utf-8?B?Qlc1blhzTFNna21mRjVhS1RMc1hnc1R6L0M4ak11Z3FUWUZZU1NmYm02ZW9k?=
 =?utf-8?B?WUs3SWNYbUhVRUczb3l2V29kbTFxMmtMVDlhMWNTZGhESnUyRmVhcXV4NUVX?=
 =?utf-8?B?bXRFNnJaUUJRSTZ3aVRuVklCZTNodTcrQm5zVDh5dnJYbERZMWJUa04waDI0?=
 =?utf-8?B?UEMydC9naDN0c0tXWjdjbEsyT2NqSmNyRWRmZThEUzlLMlJMaVk4L0hOQVNG?=
 =?utf-8?B?WjlzMTdnL3ZVdlExRWRNbGwrU01TUkd5UVJMOTc3VmFZUEtKNWlTaHpOei8v?=
 =?utf-8?B?QUhxQ1g0SFFxd1U3VU5VeVBSc3pqUEhuUUZ6aDNaSm5MTktZQWxqTStiVDdp?=
 =?utf-8?B?bDFCSGt3NW8xSmUyMGdkK3Z6RzBwcnlNWndhK2NtT05SZzNvVWJzZnY3cEEw?=
 =?utf-8?B?TmRxZHFXTW1pZ2tPdTVxRGZUZVJoVlFzbHdYMzJ6Vk9GMElQdlJGb005ZEZl?=
 =?utf-8?B?SHFwNVg0WmZEdjhpY3ZWaVRxWU1VY3M0VlFMR3Nrb2EwYVU0RW1zaTYwWVBU?=
 =?utf-8?B?RmRzZDlEYis2NWw4NE1uS28rK01qSTNWa0VoNTErQnR0L0ZBUFFDNUxqVWVm?=
 =?utf-8?B?TjdCVCtXU0YvcnZOZlpYKzhDN29ya0RoZ2xuNXl6dnJsSWt2Q3I2MVJxelU3?=
 =?utf-8?B?cmlKTWJvYkk5SDZXZU8rYlE3bWFnanF4YnVMaFhvM0NFM1V5bzJLTTMwVkNP?=
 =?utf-8?B?UGJqTGtxWStlSDJEN0U5K3h2ekZGWXV1VjZWNDFpMkdBaFc0MXp0Ty9uTURp?=
 =?utf-8?B?cDdMb3g0bWZGVFM3ckFpTmtNNm9YcDlBU05uWjBSVko5SkdoK2U1WHlsUm92?=
 =?utf-8?B?MnNuNkRaYlZqS05qallFdW1iWUZsSlhyUGpZWEpLMDhidnR4ZGVrK3JQVkhz?=
 =?utf-8?B?S2RRQWVRS3FJdkdJQURxb25DU2Z4aGRjaDM1anNmVkFQdEV2MXZBVXBteVRO?=
 =?utf-8?B?ZElwa01TS21Xd0tDVVBJckNhMjdXYkNvQk5MR1hEdCt4RnhVYjBxVE9ZK0hm?=
 =?utf-8?B?d0p1ZEs3UkhmcGNsdStMaTZvb0pMYUFsTVA3bEcyWURrM1c3WEgwc3d2WEpM?=
 =?utf-8?B?empralN2amUvN2NIc2NyclJrSHlNTER6M3I2dUpuYVB6cW56TzdLa0xHWG1B?=
 =?utf-8?B?TGpJT25DS1dCTFlldkhjNHVTQ3VMOEV4bkE2MzduVWEwVTNyWUVsZHVwSnUz?=
 =?utf-8?B?eXMwNmkrWDJ4Y3dtam5yZCt5aWphTjlhaTdkUU9YaWZBbnZGcHEwb0Q4RjE0?=
 =?utf-8?B?QlVybzJHejRIek0wZnVQNW5DZjNsYTJFQ1J1ZlVmbGxiTmsvVncxbDNzaS9B?=
 =?utf-8?B?bE9rdXlUcnFVOEtaMlpQbEc5TUFzNW5Na2trZy9WOWJnVjIyRGoxSUtKcXJW?=
 =?utf-8?B?eGlXdkdIUTVMU2txaTRlb0dYTllxYjR2ekJuRCt0VGVvbTZ0emIvNyttOU5p?=
 =?utf-8?B?VnFzblBhY0YxdDNVbUJTWHJoT2hIUEwzVnVyczUra0gzMXBYTWZHZGRKTmto?=
 =?utf-8?B?cUE1ZjNkOUZTenJ5bGdpU1l1TEE4WnRpblhXR2NLN1NDOGhjMDVTdzRWeXJp?=
 =?utf-8?B?aFUzV1J2K21rVDdyUStGQjNBclRBZXRFS0s0QnhWaGxRM1FoeVdBVG9uaEJm?=
 =?utf-8?B?ZE9rNVVYdzlHYlE0bUQ2WWlNSjdCV0ozOUNlelhIbVM3ODk5blNjczVaQUM3?=
 =?utf-8?B?bkpCS1prd1E2Nm1KekJLc2paNFBNdWFrLzhQekdWQnRzdnNuVVoxemNTWHVW?=
 =?utf-8?B?UW1NMU9TSkJBZEtkMlJJSU90S3IydFFQZUMyeThHc0UyZFZLY1AyK1A4eHo4?=
 =?utf-8?B?T0toaktCSUhTN0xKaDFUdk9OMGV3dE4wQWxZVmczaW9FQjdZRU9TMjQzTm8v?=
 =?utf-8?B?ZXBEMUFlV05yYklESmFMMWlNbUxHMGg4b2Q4SEFmNExXR2Z4alQ5WGZDMzMw?=
 =?utf-8?B?d2g1VTFsTTMxcDFpUmc3OXNrSDNsNWJxSVRpSllNQjVKanYyeVZKVmdSL3Ax?=
 =?utf-8?B?d1VwTjF5eXUwWFhNVDNyeXV0Ukd4YUwvSENZWXJwcUxZaUsvNmpzSEM4K21y?=
 =?utf-8?B?NlBGL1dINi9tUFZhNGpWQ1NQK0htUTg3L29oQTgyRU93eStrdmJxTUw2WWNN?=
 =?utf-8?B?b0F2dnZ1VEM4bUNSVXNtejFYeGc2eTRVOWVJc25pNzQrUXVTZU1JTjBFQTJ2?=
 =?utf-8?Q?JWV3SsYypzdQb+Zzwc+rUet2H2yNiBiC7bLT8GHJ3i2d6?=
X-MS-Exchange-AntiSpam-MessageData-1: IX1cr2yBuTQKZg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b7c317-13fb-4574-c258-08df14969ad8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 08:35:18.7713 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZFIxvaQ0XtNnEp3iXmUdC+2403qet5YohxwYlsrSEs7laUP2qmutTPV+59fRy0HuwOQDaFkhFqoiUrbZLN/AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8800
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

The new `cv!` macro allows safe casting of constant expressions in a
const context. Update code in nova-core to use it.

Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/falcon.rs                    |  9 ++--
 drivers/gpu/nova-core/fb/hal/gb100.rs              |  4 +-
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |  7 +--
 drivers/gpu/nova-core/fsp.rs                       |  3 +-
 drivers/gpu/nova-core/gsp/cmdq.rs                  |  6 +--
 drivers/gpu/nova-core/gsp/fw.rs                    | 38 +++++++--------
 drivers/gpu/nova-core/gsp/fw/commands.rs           |  2 +-
 drivers/gpu/nova-core/num.rs                       | 55 +---------------------
 8 files changed, 28 insertions(+), 96 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index 9015de965a53..0b377bd6524a 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -28,11 +28,8 @@
     driver::Bar0,
     falcon::hal::LoadMethod,
     gpu::Chipset,
-    num::{
-        self,
-        FromSafeCast, //
-    },
-    regs,
+    num::FromSafeCast,
+    regs, //
 };
 
 pub(crate) mod fsp;
@@ -515,7 +512,7 @@ fn dma_wr(
         target_mem: FalconMem,
         load_offsets: FalconDmaLoadTarget,
     ) -> Result {
-        const DMA_LEN: u32 = num::usize_into_u32::<{ MEM_BLOCK_ALIGNMENT }>();
+        const DMA_LEN: u32 = cv!(MEM_BLOCK_ALIGNMENT);
 
         // DMA transfers can only be done in units of 256 bytes. Compute how many such transfers we
         // need to perform.
diff --git a/drivers/gpu/nova-core/fb/hal/gb100.rs b/drivers/gpu/nova-core/fb/hal/gb100.rs
index 9fa094939600..612f70333c11 100644
--- a/drivers/gpu/nova-core/fb/hal/gb100.rs
+++ b/drivers/gpu/nova-core/fb/hal/gb100.rs
@@ -28,7 +28,6 @@
         hal::FbHal,
         regs, //
     },
-    num::usize_into_u32,
 };
 
 struct Gb100;
@@ -81,8 +80,7 @@ fn write_sysmem_flush_page_gb100(hshub0: Mmio<'_, regs::Hshub0Registers>, addr:
 
 // This PMU reservation size is r570-specific.
 pub(super) const fn pmu_reserved_size_gb100() -> u32 {
-    usize_into_u32::<{ const_align_up(SZ_8M + SZ_16M + SZ_4K, Alignment::new::<SZ_128K>()).unwrap() }>(
-    )
+    cv!(const_align_up(SZ_8M + SZ_16M + SZ_4K, Alignment::new::<SZ_128K>()).unwrap())
 }
 
 impl FbHal for Gb100 {
diff --git a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
index a87878fe2aec..35a813584baf 100644
--- a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
@@ -17,10 +17,7 @@
         Io, //
     },
     prelude::*,
-    ptr::{
-        Alignable,
-        Alignment, //
-    },
+    ptr::Alignable,
     sizes,
     transmute::AsBytes,
 };
@@ -136,7 +133,7 @@ pub(crate) fn new(
             let code_size = usize::from_safe_cast(tlv.get_u32(b"CDSZ")?);
             let code = blob.get(..code_size).ok_or(EINVAL)?;
             let aligned_code_size = code_size
-                .align_up(Alignment::new::<{ falcon::MEM_BLOCK_ALIGNMENT }>())
+                .align_up(cv!(falcon::MEM_BLOCK_ALIGNMENT))
                 .ok_or(EINVAL)?;
 
             let mut ucode = KVec::with_capacity(aligned_code_size, GFP_KERNEL)?;
diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
index b738dcabcdef..3a4a10487f33 100644
--- a/drivers/gpu/nova-core/fsp.rs
+++ b/drivers/gpu/nova-core/fsp.rs
@@ -50,7 +50,6 @@
         NvdmHeader,
         NvdmType, //
     },
-    num,
     regs, //
 };
 
@@ -288,7 +287,7 @@ fn new<'a>(
         };
 
         let version = hal.cot_version();
-        let size = num::usize_into_u16::<{ core::mem::size_of::<NvdmPayloadCot>() }>();
+        let size = cv!(core::mem::size_of::<NvdmPayloadCot>() => u16);
 
         Ok(init!(Self {
             header: FspMessageHeader::new(NvdmType::Cot),
diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 9f99e6bbb4fa..cb757bea0ad4 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -161,7 +161,7 @@ fn read(
 #[repr(C, align(0x1000))]
 #[derive(Debug)]
 struct MsgqData {
-    data: [[u8; GSP_PAGE_SIZE]; num::u32_as_usize(MSGQ_NUM_PAGES)],
+    data: [[u8; GSP_PAGE_SIZE]; cv!(MSGQ_NUM_PAGES)],
 }
 
 // Annoyingly we are forced to use a literal to specify the alignment of
@@ -234,8 +234,8 @@ unsafe impl FromBytes for GspMem {}
 impl<'a> DmaGspMem<'a> {
     /// Allocate a new instance and map it for `dev`.
     fn new(dev: &'a device::Device<device::Bound>) -> Result<Self> {
-        const MSGQ_SIZE: u32 = num::usize_into_u32::<{ size_of::<Msgq>() }>();
-        const RX_HDR_OFF: u32 = num::usize_into_u32::<{ mem::offset_of!(Msgq, rx) }>();
+        const MSGQ_SIZE: u32 = cv!(size_of::<Msgq>());
+        const RX_HDR_OFF: u32 = cv!(mem::offset_of!(Msgq, rx));
 
         let mut gsp_mem = CoherentBox::<'_, GspMem>::zeroed(dev, GFP_KERNEL)?;
         gsp_mem.cpuq.tx = MsgqTxHeader::new(MSGQ_SIZE, RX_HDR_OFF, MSGQ_NUM_PAGES);
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 8778c4bf79c0..29759882920b 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -57,7 +57,7 @@
 
 /// Maximum size of a single GSP message queue element in bytes.
 pub(crate) const GSP_MSG_QUEUE_ELEMENT_SIZE_MAX: usize =
-    num::u32_as_usize(bindings::GSP_MSG_QUEUE_ELEMENT_SIZE_MAX);
+    cv!(bindings::GSP_MSG_QUEUE_ELEMENT_SIZE_MAX);
 
 /// Empty type to group methods related to heap parameters for running the GSP firmware.
 enum GspFwHeapParams {}
@@ -110,20 +110,18 @@ pub(crate) struct LibosParams {
 impl LibosParams {
     /// Version 2 of the GSP LIBOS (Turing and GA100)
     const LIBOS2: LibosParams = LibosParams {
-        carveout_size: num::u32_as_u64(bindings::GSP_FW_HEAP_PARAM_OS_SIZE_LIBOS2),
-        allowed_heap_size: num::u32_as_u64(bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS2_MIN_MB)
+        carveout_size: cv!(bindings::GSP_FW_HEAP_PARAM_OS_SIZE_LIBOS2),
+        allowed_heap_size: cv!(bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS2_MIN_MB => u64)
             * u64::SZ_1M
-            ..num::u32_as_u64(bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS2_MAX_MB) * u64::SZ_1M,
+            ..cv!(bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS2_MAX_MB => u64) * u64::SZ_1M,
     };
 
     /// Version 3 of the GSP LIBOS (GA102+)
     const LIBOS3: LibosParams = LibosParams {
-        carveout_size: num::u32_as_u64(bindings::GSP_FW_HEAP_PARAM_OS_SIZE_LIBOS3_BAREMETAL),
-        allowed_heap_size: num::u32_as_u64(
-            bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS3_BAREMETAL_MIN_MB,
-        ) * u64::SZ_1M
-            ..num::u32_as_u64(bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS3_BAREMETAL_MAX_MB)
-                * u64::SZ_1M,
+        carveout_size: cv!(bindings::GSP_FW_HEAP_PARAM_OS_SIZE_LIBOS3_BAREMETAL),
+        allowed_heap_size: cv!(bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS3_BAREMETAL_MIN_MB => u64)
+            * u64::SZ_1M
+            ..cv!(bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS3_BAREMETAL_MAX_MB => u64) * u64::SZ_1M,
     };
 
     /// Returns the libos parameters corresponding to `chipset`.
@@ -682,12 +680,8 @@ fn id8(name: &str) -> u64 {
             id8: id8(name),
             pa: obj.dma_address(),
             size: num::usize_as_u64(obj.size()),
-            kind: num::u32_into_u8::<
-                { bindings::LibosMemoryRegionKind_LIBOS_MEMORY_REGION_CONTIGUOUS },
-            >(),
-            loc: num::u32_into_u8::<
-                { bindings::LibosMemoryRegionLoc_LIBOS_MEMORY_REGION_LOC_SYSMEM },
-            >(),
+            kind: cv!(bindings::LibosMemoryRegionKind_LIBOS_MEMORY_REGION_CONTIGUOUS),
+            loc: cv!(bindings::LibosMemoryRegionLoc_LIBOS_MEMORY_REGION_LOC_SYSMEM),
             ..Zeroable::init_zeroed()
         });
 
@@ -715,12 +709,12 @@ pub(crate) fn new(msgq_size: u32, rx_hdr_offset: u32, msg_count: u32) -> Self {
         Self(bindings::msgqTxHeader {
             version: 0,
             size: msgq_size,
-            msgSize: num::usize_into_u32::<GSP_PAGE_SIZE>(),
+            msgSize: cv!(GSP_PAGE_SIZE),
             msgCount: msg_count,
             writePtr: 0,
             flags: 1,
             rxHdrOff: rx_hdr_offset,
-            entryOff: num::usize_into_u32::<GSP_PAGE_SIZE>(),
+            entryOff: cv!(GSP_PAGE_SIZE),
         })
     }
 
@@ -947,9 +941,9 @@ impl MessageQueueInitArguments {
     fn new<'a, 'b>(cmdq: &'a Cmdq<'b>) -> impl Init<Self> + use<'a, 'b> {
         init!(MessageQueueInitArguments {
             sharedMemPhysAddr: cmdq.dma_addr,
-            pageTableEntryCount: num::usize_into_u32::<{ Cmdq::NUM_PTES }>(),
-            cmdQueueOffset: num::usize_as_u64(Cmdq::CMDQ_OFFSET),
-            statQueueOffset: num::usize_as_u64(Cmdq::STATQ_OFFSET),
+            pageTableEntryCount: cv!(Cmdq::NUM_PTES),
+            cmdQueueOffset: u64::from_safe_cast(Cmdq::CMDQ_OFFSET),
+            statQueueOffset: u64::from_safe_cast(Cmdq::STATQ_OFFSET),
             ..Zeroable::init_zeroed()
         })
     }
@@ -969,7 +963,7 @@ impl GspAcrBootGspRmParams {
     fn new(target: GspDmaTarget, wpr_meta_addr: u64) -> impl Init<Self> {
         let params = init!(Self {
             target: target as u32,
-            gspRmDescSize: num::usize_into_u32::<{ size_of::<GspFwWprMeta>() }>(),
+            gspRmDescSize: cv!(size_of::<GspFwWprMeta>()),
             gspRmDescOffset: wpr_meta_addr,
             bIsGspRmBoot: 1,
             wprCarveoutOffset: 0,
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index 32856ff74183..f50cf110a822 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -82,7 +82,7 @@ pub(crate) fn new(offset: u32, value: u32) -> Self {
 
                 // We only support DWORD types for now. Support for other types
                 // will come later if required.
-                type_: bindings::REGISTRY_TABLE_ENTRY_TYPE_DWORD as u8,
+                type_: cv!(bindings::REGISTRY_TABLE_ENTRY_TYPE_DWORD),
                 __bindgen_padding_0: Default::default(),
                 data: value,
                 length: 0,
diff --git a/drivers/gpu/nova-core/num.rs b/drivers/gpu/nova-core/num.rs
index 6eb174d136ab..2e5c9937b3a6 100644
--- a/drivers/gpu/nova-core/num.rs
+++ b/drivers/gpu/nova-core/num.rs
@@ -96,8 +96,7 @@ pub(crate) const fn [<$from _as_ $into>](value: $from) -> $into {
 ///
 /// Prefer this over the `as` keyword to ensure no lossy casts are performed.
 ///
-/// If you need to perform a conversion in `const` context, use [`u64_as_usize`], [`u32_as_usize`],
-/// [`usize_as_u64`], etc.
+/// If you need to perform a conversion in `const` context, use [`cv!`](kernel::num::cv).
 ///
 /// # Examples
 ///
@@ -164,58 +163,6 @@ fn into_safe_cast(self) -> T {
     }
 }
 
-/// Implements lossless conversion of a constant from a larger type into a smaller one.
-macro_rules! impl_const_into {
-    ($from:ty => { $($into:ty),* }) => {
-        $(
-        paste! {
-            #[doc = ::core::concat!(
-                "Performs a build-time safe conversion of a [`",
-                ::core::stringify!($from),
-                "`] constant value into a [`",
-                ::core::stringify!($into),
-                "`].")]
-            ///
-            /// This checks at compile-time that the conversion is lossless, and triggers a build
-            /// error if it isn't.
-            ///
-            /// # Examples
-            ///
-            /// ```
-            /// use crate::num;
-            ///
-            /// // Succeeds because the value of the source fits into the destination's type.
-            #[doc = ::core::concat!(
-                "assert_eq!(num::",
-                ::core::stringify!($from),
-                "_into_",
-                ::core::stringify!($into),
-                "::<1",
-                ::core::stringify!($from),
-                ">(), 1",
-                ::core::stringify!($into),
-                ");")]
-            /// ```
-            #[allow(unused)]
-            pub(crate) const fn [<$from _into_ $into>]<const N: $from>() -> $into {
-                // Make sure that the target type is smaller than the source one.
-                static_assert!($from::BITS >= $into::BITS);
-                // CAST: we statically enforced above that `$from` is larger than `$into`, so the
-                // `as` conversion will be lossless.
-                build_assert!(N >= $into::MIN as $from && N <= $into::MAX as $from);
-
-                N as $into
-            }
-        }
-        )*
-    };
-}
-
-impl_const_into!(usize => { u8, u16, u32 });
-impl_const_into!(u64 => { u8, u16, u32 });
-impl_const_into!(u32 => { u8, u16 });
-impl_const_into!(u16 => { u8 });
-
 /// Creates an enum type associated to a [`Bounded`](kernel::num::Bounded), with a [`From`]
 /// conversion to the associated `Bounded` and either a [`TryFrom`] or `From` conversion from the
 /// associated `Bounded`.

-- 
2.55.0

