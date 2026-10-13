Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AFF0CC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 05:58:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DB0210E075;
	Tue, 13 Oct 2026 05:58:40 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011049.outbound.protection.outlook.com
 [40.93.194.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AF8E10E075
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 05:58:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZtLOwqacTPc/A4T8LhXWc+OsHgKeMoQmwFazyJ6OuGWZ7J7Al2nh2hTEyutQcL8l4ay1rNyZouzro4d+0E9p8ZQrI2ArE93SOz5O6ZRKmSydtuJlJ+XKUVjsM4vtSN2YIagmJaZAcIIT+zbRAsx+jB56HDqSGK7iq+fh5IfX2MLFz2qiwehURloNsLw1LYgW3wS/SkaQVk4QChLu7Ss+aMr/znCWWFl1VnpMuUpLYxdjOemOLS5nzBgdTHRji89fBHFAlxGq+uRV+2z8IZMypq9J8ZPSW4mOt/RLjafF+MicFYasO+JcAzYM1Q9U1M1psLYXxt7nRTZrn/qi8llDRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRwJPJCWuDHIgLggipR2f7ie+6oeYpVAU0TUJfSer/c=;
 b=MF4Y5s00mbNSV0RUFfH/YOXTJtDUYQl+fqz7pamCnS3ZzVOFsynJIZ9ofMDrPwIOuZsMwFsTPyZRtaQ1xeGDz95p/OyD+l6PvN0DOmDYONiRAyZdxEiwB1bM2s8M63sP7Tnxunh3Dv00ON6hfAkPa54NSZZfnvXIXS3nlJUKKR5FoBZik3Y5pELBnczLpfwyoKfEX1RM1Cl7RSeh9hH0Dbu/zfpAcHaDUdL3peorlp9V2Ked5ZMYMqSGQHbcXXPs0CyrebZKLm5w1f/iHTIAfTvYwYhtU0MNmBPnascB9OW/etWkUmeJ/QnESloNrY1iGQYLgm/vy895aKZ8bueS8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRwJPJCWuDHIgLggipR2f7ie+6oeYpVAU0TUJfSer/c=;
 b=MPMp8IclHFC/ym+V/NA3uQbid2h4ZEAaR70GdJ+9FQHDRDF74obYnZzu/swYYH3vL1bjAu0yYWglZykykADc1McJmZZC5NcND+t1DayeMmjBK0Pad8gTOk0BmtIfY2c9y0dlrQoTM+5k7ypEXPx33lWuIZEXcxOiYve227FgxqMFpBP9JC4M5aLL0KuHApxX8vTY0ziq3Xo5bLnEDZmGW5pLZdUNRceXQPzgIwqq7Dw2WFTdbKJQF1Ro+AwnkI2qWDNBtkVRPfa53zKlNUyhviWXf+Y7fCsRbVboMP0whul/qlE3TSf3tTQ00Lo7GaO13poyI1/pGH7304WRHnQVUg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 MW6PR12MB8916.namprd12.prod.outlook.com (2603:10b6:303:24b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 05:58:24 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 05:58:24 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 13 Oct 2026 14:58:07 +0900
Subject: [PATCH v5 2/2] gpu: nova-core: use cv! for constant casts
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-cv-v5-2-113a538dfaef@nvidia.com>
References: <20261013-cv-v5-0-113a538dfaef@nvidia.com>
In-Reply-To: <20261013-cv-v5-0-113a538dfaef@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0172.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::10) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|MW6PR12MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: ad4a43a9-1578-4f9e-1578-08df28eefe1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|10070799003|23010399003|921020|11063799006|56012099006|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: RajhD5or1V29osMMe/6cNuC1FWmFQiF9z2XnXtRkbziiAfwaFaHg/o1AOi95bi9cX0JiPQuHWmeU7kJRDSw5AtzzpTTb5xTBKvXFn6QqFP0a6MyObPnsU5lmN9yrSak9WDUsuPoe2AYZfwQj/EMIcImYTqBnuTBYeC6gQ1OckL26P1u6WjvopbJBhS0ttZDjtOrabbWngJRU2idiVmIR9DJj8kDQ/PKG1BvYOSZywNA/JIyZDGKYnZaixmHGToNXLustuXc9Qtlu7Rpk4Bq9QY+d/HgMyLZQx+2i7DMkyRXdIqksMtt+HIp7HDjAhZoQfBO08fyVdBvytbdvaG5zToFgkTT4naGosmDafzeSKlS6rQStESVeoD346OArzKtcDzlhvXmuhBw+4aAhE8CpT1qiQ52duWLG9NkdzAjkj5DWC95f6uufnuyK92bNAT28ERo6Q4F//4eZYEOvNmMWbgpAyy4/nEI8PxW1s7+L1uu6dlq4mKbZyct3XnupLxUi5OpF2ALBibGnmwZDCrCnaS3C3nwQKD3miM4pqrfgKqz2Uwuv8+gwx57fU2XgRgdr6JIKqNnaFtd4cPqCIqtmkqidvvvdcHuX+aFr1Fpqv5znq1SRP2csW9Xu2KKJs5luNHSUNJ8j8P6wO1ruVSHRwrZwb/Ood30LZ0hbrJ7d0QV/b/Foq6V7FH+Sa8crEtpk0xwZNqt0UXjKN+kshXDhwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(23010399003)(921020)(11063799006)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkdRWlBQZ3pJdVV2UGxJcktjT3pwdlpwWDc0SzZRT01WRGwzODVUakJVd09N?=
 =?utf-8?B?YWt2TExVSXllcjJxeXM1blJyVVI5bUkrWHFMelFBUzlEVmYrejMyTk5nVkpX?=
 =?utf-8?B?ZFVoa3M3czhKa3JGczhZWlNRUnZaQXhwdUpwS1IwUGNYbDFsNjluKzZ1cjJR?=
 =?utf-8?B?bExnNTJOblgxRUJISXhlajlGeThjTTFPeWZvM3UrN0cxODZ5elNvN0xzaFFB?=
 =?utf-8?B?c3Mzd1V6OFRjZGhSOHkvaXpUSWYxMUZQdmZPakZuY1JGcGxGRUF2dEJJS0sz?=
 =?utf-8?B?MkQ5WjlLSHhwR1NVcFQyeHA5NVdLbWhVMVlxbmN5Zkc0K1RseDYwOHEzTU1J?=
 =?utf-8?B?TXh3SW5Ea0ZZWkE1RUhmdkl2OUY3U3RVT0x3aUJSVGlTLzMxMHVEM002OEZ4?=
 =?utf-8?B?WWJDYkJvdkh3Z0poWGVScW9JQi9xYkhraDA5eDJONWlZRXdHMHFaWWxJTkpZ?=
 =?utf-8?B?K01yY1hHNFdDWG12eTYzeUxKUDFQVFVTbENwYlozVTlqZlRMMEJKVlBjVFpU?=
 =?utf-8?B?QkgydVlJdlpNdmFrT1d2bGpmZU5TUHlMSFZFMW1oZzRjQ3h2b29MOE0va2Fx?=
 =?utf-8?B?OVk0c2ZKUXpWaUZWdUx6cVdIZmd5TkRodnhYZDNoOElJMm4wZDZodStBdmRS?=
 =?utf-8?B?ZmRQU21SdzBiemV0SE9qQTZYd3B0RlRrc3RKSFBKWTBZb3ptK2FFMXYzVDdh?=
 =?utf-8?B?VjhNTENoazRXUW5Ud3NnM2xWdWlPV1ZPbTFWMG9jQ1pGeUQwMlJRWGoxa0Rl?=
 =?utf-8?B?c0RVRml6dE9KODhDR1lNRllHczc0ZVNOS01sTGpQeFdabi9QbXRGeElCcTVP?=
 =?utf-8?B?THdNU1ZORnpQY2dBRTFxeDV6ZWRDOWhiRUxKYlNEUmZPeWZCbVZFa0hsWXJL?=
 =?utf-8?B?K0FvR2RycFl0UFEzdkNRcVMreVNyZjBrZzJtTEtHODVDNUk0ZTFUUFo4TVha?=
 =?utf-8?B?bTZLOTJ3VGk2bWcwUUxmUHVrZmozRElUS2pLSXRBODMxY01wNWdPNENQYjhC?=
 =?utf-8?B?ZUVEZDM2dnJpYzBwbm11TFFWWTZabndlMWt3MDErcHVOdUlzcThkamIzeDlq?=
 =?utf-8?B?TGFESllvRUkzdjhLaTFqcHBMem9yOHczakxIWkFGanFnWmJkdzN3c0ZSd2Mr?=
 =?utf-8?B?eUZCUmVSZGpuOGRzYXBjWVBoS1MwOUdvQmNSaE9qSHdWdFhxUUMyT1NlMU9V?=
 =?utf-8?B?Q0g3THVHWkNoWFEyY0tBWWNyeEpWVFJqblZpcmdHb25QRURDV2hKQ2cxZEVm?=
 =?utf-8?B?dmh3bnNiNE4vUmhjV3d1Wi9sd1RjSGdYODM1b1lpQnBuOHFMRkJrQ2s3YlRW?=
 =?utf-8?B?c3dueHFpb2xFdDQ2M2RlYlFrcVU1dE1PK0F2ajZuNVJySnBBSi90TmFkSCsy?=
 =?utf-8?B?WDRoZ2hXRU8zMzVvT1BXdVExZWxMaFdLL1N1TGNWeUpGTlhCQXpqQ0RzbVBp?=
 =?utf-8?B?WDJxcy9OTWJqTzNMM20vWk0xOGhScGQxSUZGZG4xd3lsZzA5U2FpekZiTnVm?=
 =?utf-8?B?ak9nWHA3MlNiM01aTUNkMmhmbmphbEh6anB1R0V0SXhZOVIzM0lHU2U1NjJR?=
 =?utf-8?B?RE1CblN3NDhoSnNldEhFWkNGTmtWUEJpVGVpVlhZRzgzaDkvTXlEMGtFdGxH?=
 =?utf-8?B?UUl1MUI4RkoyK3ZPa3hoQmtTbkRKbVlsYjZOd0FKdmpjWVNLSVRxcUEyVFlW?=
 =?utf-8?B?VENPRUJFZlF1cUtCa0RnU21Vc09DVk94UTBmM1FIMzE2Y1NLSSthdVNCT3Av?=
 =?utf-8?B?bXk5cXZIL3ExbStaVEFQeXpNeGxXWjFiNUd2bjg4ZWhoQWpxS2U4Wk5ncXZ3?=
 =?utf-8?B?ZjREYVJ6OVlUSUI0b09hRk8rRStKMUVLcC9sc2t4bVFTQldjazFZL21XYUc3?=
 =?utf-8?B?Y2xneHVINTFnNmxOdEY2OXlERjB2VjFhZlZuemtQSUtxb2FZK0JUSnZnWXBO?=
 =?utf-8?B?RzJqV09aVUNROTZoaFpuTlQzUzY2SWdiV1RaNzNLZitMNmVGdnk4VDY3NU5w?=
 =?utf-8?B?RHdTd1QvaXFqZlVtTk5LYi9kdnoyYVprWG5PRlNiVHZiVnd2dmRZR1lRSUtp?=
 =?utf-8?B?Q1QvS3B4Z2I0RmtpV1BWMCszNC9LUVAxNHBHT0pQVWE2MEFKTUVHczBuYzMw?=
 =?utf-8?B?c3dJNFk2Qjg0aU1tdVVGcEZwbFE2aHREUzhFcko4RVJzU0xBcGtiU3NGYzV1?=
 =?utf-8?B?VVhOTGx3TlB1dVRMUHpTdHdQOUtjTXFDVFBZRzVkOURSUFZ3VnZyOWdCYSsw?=
 =?utf-8?B?dk00UW85dFAxUmtWcmtZcDdlZmJ4YWJSNVluc1kvSWpsYlFNdTZyQ21vUUd2?=
 =?utf-8?B?OEFObi8reUFwR1lTVmo3WWZaWkRvZkwyZGorSWxER2piSWdYUnRYRnFwNkty?=
 =?utf-8?Q?bERdUpTHVjxkHocYTLJXx8mOIH+d4tG76Mv8ggy/EC0hP?=
X-MS-Exchange-AntiSpam-MessageData-1: Z4FAVRLuRS2Uew==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad4a43a9-1578-4f9e-1578-08df28eefe1b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 05:58:24.2923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BsxZKktXQVqniS9vC5hHr+o4fLK8FWihRr2FWtRQZSsdVvcLPv46MfjkGkI0YPWeHqENfj4jXnwKSYxlrJkRYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8916
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
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
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
index 1ff04bc2c7f8..68858b48390e 100644
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
index 1b2f346a237f..090e67ac9a26 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -167,7 +167,7 @@ fn read(
 #[repr(C, align(0x1000))]
 #[derive(Debug)]
 struct MsgqData {
-    data: [[u8; GSP_PAGE_SIZE]; num::u32_as_usize(MSGQ_NUM_PAGES)],
+    data: [[u8; GSP_PAGE_SIZE]; cv!(MSGQ_NUM_PAGES)],
 }
 
 // Annoyingly we are forced to use a literal to specify the alignment of
@@ -240,8 +240,8 @@ unsafe impl FromBytes for GspMem {}
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
index 918a7ae809eb..1b548bbf146e 100644
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
index 567c56fbbfe3..b38eb716448b 100644
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
index f4169235bc24..3b3f1ed2dc75 100644
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
2.56.0

