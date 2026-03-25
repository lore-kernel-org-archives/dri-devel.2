Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDDE103A9A6
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 02:46:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5124410E6B8;
	Wed, 25 Mar 2026 02:46:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yp64j1pc";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010058.outbound.protection.outlook.com [52.101.61.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A9FB10E6B6
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 02:46:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wW6/TtJRswzjGgEizKarFRff2zJ9e134UXcCmMVhJ7qo3L+FUFZ06IH09ZHD4+mLbWG8jV+i5MnqxRSwVBrnAclstNs0J7JPvtGHcdwO0VyNKt9X0ZGjYHPp4ig8Y1NJQfMIrizOO4WOrgG7FRFBadSZ/OuQQQoCaFH87uUIpOozpPWH+TgOr1qrPnIrRoQquMKg1E2HiK3AGjcB9T8BjQyoo6P0AXOxvD9HraXw1wRCbs2QaIuYh9NWCLNBmCP4/BXA6cYTx+XryFTsZGobRZZo7HkZcO13mR0vi9bJauq3oeJWVid4/NNODMWvlSF/QP4BZtR/ddYibFcK98X+kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWWOA9wpvH4QqfLr6Zky4Ozk9vK7ksrG0x69IZG5fyo=;
 b=ZwRYw93Nmtxss6EikiCOywsGXictkrEi3gPxqCk2HQBW+3NJy9nYmJFlIoGOr9E7du8eKsaoeBV+MAf1jEd4mOor1E+VAcxbBsGoC6xSgJlLkBD+i6jcxGaOot5U2piw0ESjPggYEZm6aUzmEtGx0tDWod/+cpXNZ0DqXsRHI/aVsJyWpcRj9lPLkY54V3rzYg0kHmOruitmz95JArYuniGrsvU01XWdSvEJ96oFh0Tuizo3NNmQWvFvdC0L6sW8Ni6tSKN5r4NAYSYjEkyXWRz4uhCGjxt8oetyYQa/6w56nMRvBtuW9QYt8DmOPWQlObvor/vyn5DG3RBOGNyaxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWWOA9wpvH4QqfLr6Zky4Ozk9vK7ksrG0x69IZG5fyo=;
 b=Yp64j1pcZOP4BgJHs9gfy9lpPyzJRgPd4Tx8XOPpWlDx716v0BbSkdeUE4mNOQUKLfdduqeM9jJn2WaCaFFw4s+lxRu7FsuupU6+hpieqRQLVghItLZlAFCbIIEelxQgfK6pKQIllOU7/aphm0oBD4cQSlhfm7Qn5VeWdt5AMLphF2Qi7mUQB4pghNVTTAP9F//yTMqOoAZdPeI9Obni91Z6Iq05IF+DfSk1wCVpq0MMcFajr9zCxzKrgWZIiHIg638v4/PBKpJ64Dd7huRxxA4SQ2i1LuaFFmFgTO8nGeHVuJeutyXftoZ39nar3fpzCR1Ok5qn6BR+xsTN87m2kQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH8PR12MB7448.namprd12.prod.outlook.com (2603:10b6:510:214::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 02:46:47 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Wed, 25 Mar 2026
 02:46:47 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 25 Mar 2026 11:46:16 +0900
Subject: [PATCH v4 03/10] gpu: nova-core: convert PBUS registers to kernel
 register macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-b4-nova-register-v4-3-bdf172f0f6ca@nvidia.com>
References: <20260325-b4-nova-register-v4-0-bdf172f0f6ca@nvidia.com>
In-Reply-To: <20260325-b4-nova-register-v4-0-bdf172f0f6ca@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.0
X-ClientProxiedBy: TYCP286CA0015.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH8PR12MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: 59c3baf8-a348-4076-9dce-08de8a18c1dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|10070799003|366016|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: Pf9wVGyTfTb5VIuOs8S/JOJARphV620NyJz5ZI3/Gi74Grstr051evu9nquloWFSGNqPDSp0BM3QsDP+a8Hcp2gPIIxhSXtQmgRoiBh+rN+hJQuHVTBKJ/zweMTLcfaf1cGN6Z+9dC9i18LeIx1sk2qMhEUvrCnoxxTaLNX692PRDED/677uz3hYQYhlAPXJ5gdZmQoHUNrhpsyB+wuCAoTYo+4IeCT9Fh27cT7mLfRncR/XioOHYlbeZmaa/Bopz+a/FZ8Pl66NIsci4RkScg7iLiC9queKUJ/LY4hTv0Q5XyeYa25UBnP0+P58Ew0nh1GquRP9W32Dd9hjGNkaSuZC73ir3s5yQeueTR3gkO7Ka7KGeSSP/9o49ZEHznzxjofxBseZlwgh+s5icfewCqzmriK9vvUuQKqoaHotMZ3UbtzgC6Ni3BpSKSrhU5OhVdo5yr5PY/6gMTnogXnzcCVWe1fOd+670Qg/VxEifThQHsFrjL4Epnjy/H8AApHNCZP+R+OdbvdRcAOHx2m+rsLH10HDpyTKMMN6iiCT+9V0rECJIPHr6hRxFMBKel9umSNQq6uBUdgHEOnCTJnH7lQH5zDPmt80oefSEx1ZGrBsiLTmoAYQofWSKUexBK2YIY4/1/+YfXM3KUbISIxKz0jT8BbEVdEhgskpHKr8qGG9/w9xq9rzkzI7SJ5HWXD0WWE9LaISxwvuqqP0yEPRjutBiaBaQlJh71b4rvcNj1CL/KmTztFGZLxaDBOWeG9oPOnBWst3yQ1e4WZL0aOeEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(10070799003)(366016)(921020)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVRacng2bHFUM3FWZFlzTkRkTVhFNzZDajBOQXEvVlNXQUFOdVhxaThHTjZC?=
 =?utf-8?B?RjRNN3pwOStjbHJlTFJBRGNqbEd0WmY0dzdnd3Voc2JJM1pJTDVsdzk0YlJK?=
 =?utf-8?B?TkVadk56UFU2TERTcnRHcnI2VW8zL2JKdStpQzhacm1lNWhCdWlYYWVCWmx6?=
 =?utf-8?B?N2s1VDJWaHdXaVVpcDdsdTI0RzAvZnpjZXlzWXJUYkU2L2kxeTd1ZFErTmJT?=
 =?utf-8?B?VXNseWo3eFFZUFlIb0NOdlpkRG9INXVKeTJzUjc1RFVOd3pXSHBKS2granYr?=
 =?utf-8?B?K1ZENEZwemhYWDltYlpBT0ZiM2QyRk5PdkhUVCtXSXZYSDVhdEVFS0FFSXNr?=
 =?utf-8?B?TGc4TlNQWkp1QkpkdE1BdzUvL1QrUjZlTkNwRnQ2Ukl1QmNDNjMwR3RieDFN?=
 =?utf-8?B?Y1NDcGdzdHlFWnE0THZ5dXFqUVhNQ1lIa1p0TDhJSUhOZ1ZvSlpkcmovTXVE?=
 =?utf-8?B?SW5BdmRyTm52S3JSbHM4a3lsZjNIajhkNnVLSGZ3VWMzSVFiUlljcTVMcndQ?=
 =?utf-8?B?SE4wbkFYRXZTd0p1c2owczlBc3pWNGZWNnIwK1NVVjZFa2lZbGYzMDgyWmZn?=
 =?utf-8?B?QWE2bmFnYXlra3prcWhiTGEwdHNidlFBeHRiSi9HUS9nVHlmclpKSS93SXdr?=
 =?utf-8?B?dlVacmdRckQvcjlCSXVnd3lQcUg1RGhhaWxuZWdNMXJzQjhCODJMVmJwV3M4?=
 =?utf-8?B?QitXUDQ5NXBmR2V4L1I4ZDdMLzZKT2tMSTdsZVMydkVTaGtlWkFHUCs5aTJp?=
 =?utf-8?B?bGtaU2dwd3Z0cGNsSnhVVTZQRUUraWNFaGNVRGtWUitLZ1Uxek9DK0tjdm5N?=
 =?utf-8?B?b204NzFZRHluVi93RlJXWGFXeFY0UDJEc05weUQyeEZiQzR5cVkzZTQyRW94?=
 =?utf-8?B?bjVtb2lDeThUZmFScUdtem1pM043WlI4eTJxNzU1VXZNeWJXNERzdDUwZ3Bv?=
 =?utf-8?B?RnRleE9yK0dPT2N1Z0p4cktkcU1JUWtZOXRJTkN5Sk56b3BaTko1NzY3RTBT?=
 =?utf-8?B?dDliQ0RuVDFDcFFJc1kyZjJpSFpSZGhyWXF6YWsweU1rZHgwZjBPSXpkRWVK?=
 =?utf-8?B?YU1oamhuaEZaR2FMSEJ2b1NTVC95RVFOQnA5VDFJaGgvQW9iQlZZdEhld2ZO?=
 =?utf-8?B?R29LUFBwOGJLSTk1enZZcklVSS9YenBpZFVmOFBNMW1GU2VIVGlKTHdEeXVI?=
 =?utf-8?B?dStiU21QSHVjMDlyUnhqSDF5SzNFOTBlNS9RVWFOR0Y1bUxoVnpLNm9tbHFY?=
 =?utf-8?B?emNtRUhnS2o1K01ZSkY3Ykh5Q2RrZ0RYbmNHa1BxR0FiSUlFZzBUVUxqcUJk?=
 =?utf-8?B?QnZHa2pucDlRNEt4Q2dndHZZcU1tYjE3QmgwaXp5M0VvY1pMRHJkSEdqcC9x?=
 =?utf-8?B?RExsaXp3L05sT1ZkaGxKQndkSFhOVU84ZWtoMXREVDNtenlrcmRiODBaaGN5?=
 =?utf-8?B?cEd2SHlIaUFmR01xUVdLVzV1cVU3S1hjSHZDV0xlVE44VzNwdkI4dzdsYi9E?=
 =?utf-8?B?cVhQcnZQcExxUW9QcmhyVWs3WXZhUUFqTUVHOFVxRzIvcmhJVjVMQVF0SW5r?=
 =?utf-8?B?bys3ZG9jMXNzcFJ4MFVHclVYblYxUG0yN2tIQmVvYXAwMVdha1hUTWVtMnhx?=
 =?utf-8?B?WHk0Z3ZsbUdjU3BONGt3eVVIMzB3R1lXRngza09CNTB3Q1BYbFRCZ014N1pL?=
 =?utf-8?B?NHBWWFhKZW5aajZaUUxFSndsc015NHpOZmQ5VmEzRTFtd1Ric0JJTG1FTmJa?=
 =?utf-8?B?dEJZUEFkMjZPdkh1K2MveUg1TnpvNFdjMXlOVmhERWhqUlJ4UVdsSGhLRGow?=
 =?utf-8?B?STN4Ujg1V0FVUmN3S2E3T3hYeEdyYy9MVUZuN3h6Wkh6NWFqTlFaOGVkdWJZ?=
 =?utf-8?B?VmhXQjZzd3pTR3plMEQ1bmd1Mjd6MDNXQktWbUdpTllJYlJvZ2Uwa3p0Vk1a?=
 =?utf-8?B?TnI1Z0xmUU1FUFdCcUtoaGN4eGExZ1FpY05OeDZZRDVOVFZnZnVUS1RwV3Fh?=
 =?utf-8?B?S09XVU00N0lvRTJOU3BpZmZFRVczc0RvZDFxcS82THZPQUVwaEVCK3VsREUv?=
 =?utf-8?B?T0dhanJ2N1pBR1ozOEtyeEV1MiszOGhZb1U0UFZlR2hUR0RjN3Z5eFBqaHJw?=
 =?utf-8?B?bTFYMDNHcTZBRXVYdFE3STA5c09NUDdpamRZNkdSclNGYU9EcVNkZWxDcVFp?=
 =?utf-8?B?cHBhN1U3RFNKcXYzNjZpcDRsdWtqaWk5bVBKQ0hDQ1dEdUxlby8wZlFOcHJo?=
 =?utf-8?B?ZHVFaFM2ZmVONWd1anNBVUZoVUhON201QzN5d3lMckVaVk9Fei95cGFvWU4y?=
 =?utf-8?B?NWRQNlpsRENWWXFYMGxERVZLeUdGdEo0RFBxSG9CSmxmcTJVdkVzT1NUSFZP?=
 =?utf-8?Q?E3bzGcXrJsyLey0xp+yb6MMOdhUAIrQSzkV4XHSXiD9YE?=
X-MS-Exchange-AntiSpam-MessageData-1: VUVLgu/B7Dx2vg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c3baf8-a348-4076-9dce-08de8a18c1dd
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 02:46:47.1108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3RVHI3kMoKSWDaMXbCo3AZjgdtAWjpNVHofOmuCgChwjIkwEDfMDh4aUG8cIpp8dyORfDko728AqL1CCw/vmPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7448
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

Convert all PBUS registers to use the kernel's register macro and update
the code accordingly.

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/boot.rs |  5 ++++-
 drivers/gpu/nova-core/regs.rs     | 12 +++++++-----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index e55210ebb6d1..3a0124818956 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -4,6 +4,7 @@
     device,
     dma::Coherent,
     io::poll::read_poll_timeout,
+    io::Io,
     pci,
     prelude::*,
     time::Delta, //
@@ -86,7 +87,9 @@ fn run_fwsec_frts(
         }
 
         // SCRATCH_E contains the error code for FWSEC-FRTS.
-        let frts_status = regs::NV_PBUS_SW_SCRATCH_0E_FRTS_ERR::read(bar).frts_err_code();
+        let frts_status = bar
+            .read(regs::NV_PBUS_SW_SCRATCH_0E_FRTS_ERR)
+            .frts_err_code();
         if frts_status != 0 {
             dev_err!(
                 dev,
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 58fb807605dd..533d912659ba 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -109,12 +109,14 @@ fn fmt(&self, f: &mut kernel::fmt::Formatter<'_>) -> kernel::fmt::Result {
 
 // PBUS
 
-register!(NV_PBUS_SW_SCRATCH @ 0x00001400[64]  {});
+io::register! {
+    pub(crate) NV_PBUS_SW_SCRATCH(u32)[64] @ 0x00001400 {}
 
-register!(NV_PBUS_SW_SCRATCH_0E_FRTS_ERR => NV_PBUS_SW_SCRATCH[0xe],
-    "scratch register 0xe used as FRTS firmware error code" {
-    31:16   frts_err_code as u16;
-});
+    /// Scratch register 0xe used as FRTS firmware error code.
+    pub(crate) NV_PBUS_SW_SCRATCH_0E_FRTS_ERR(u32) => NV_PBUS_SW_SCRATCH[0xe] {
+        31:16   frts_err_code;
+    }
+}
 
 // PFB
 

-- 
2.53.0

