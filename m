Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162D6C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 06:56:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7427810F3AF;
	Thu,  9 Jul 2026 06:56:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="sgosluBq";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011055.outbound.protection.outlook.com [52.101.57.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D47510F3AF
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 06:56:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RALu3kaZXKZPl9VrRx0QhAXaQLlfuQ7eYk8XMNxVs7ZBRRfBaO6K+VBCwHXxx1/RHWernu2Ze11HSPreFERrrfuddRBegEhR8ugbuE/vk9SUATJ3RHHipFl63CPtcdqFtAAKLAWtGcwrD3KPw9nct41OzImEYYSO7crbdsJBfDqveIfsw2049OPc0eNvyHSUt5a8u0Ul15a0rM0LUHDWu41YBNMcc5CWXKMmJ1xihWF+UhPBN4DIeCBgqqhSTu6hLpBZuVf4lsYu8QpVoERmxXKl8rehMqevr9PVuxZAx7ljyjivT4Nhhu2wuSe18Sw/leAkv+h9Mj8KyRHz1RQ2ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjfe5GLrLBEL1Z6iUjyYM8lj5a9uvKCe5yUKDh+IxSs=;
 b=Jgg4JFo9sDGSeiW5IzVlDmpGfFpISgAjOboF0U62SXJiDRBLtlrQQ1PE26RRKfo/85psAA7QasubMSglQg660/u7tYbFBMvSgOUb+UWfob0q/0WQEha+Rm1tLjWx30J0eYnJcuJrEPxs0XlRtMWjAebZnUBrRJDdqC6NZBD2hPuDfHFNj5haqskh+CEYB3SGwrLv6eSB/H1xtx0+02nIH/xJZ7GoZrt4vzXOkC89ZhDO2JlIGORWw5KOOTCbFOAJbLDHE4I6sArUmNqGvglWG2le3StF6+CJz9uT4HZd/XhMiIhM7RCB3F649eOZkuKW+wYNuKkylKeNLj/3JgcotA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjfe5GLrLBEL1Z6iUjyYM8lj5a9uvKCe5yUKDh+IxSs=;
 b=sgosluBqws1ROzk7C/rlWWyuGOCayRrudKOha/ZmJXFY/X72OgSrXdWONQFwitstqAo3W1wi7ClzFx7VkuhQjqEZ1xBf6H9Mgtm3RUOuFAUSa3ovHLGFcz8ZLh3wrdwOGsV6Jgdf8l8/rXCRxaFFsppcCO7S6boNuWe38cQifTQeTYNdv3s5Hx5XgpFUuKINuQEkYDQpT4LTIE4nARzURJoGlfDGMpHB9wQhpGX8QRNISZBNpYefgTt8b6p2GywMytImZnVAprDsWb36m1WcZok3w4himgMg8622IjJ1JiEL4YriM41/GI7vZy0X/K2gjbDs1e9Ofn+ZOyOJoBIPzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by LV8PR12MB9668.namprd12.prod.outlook.com (2603:10b6:408:295::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 06:56:36 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 06:56:36 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Thu, 09 Jul 2026 15:52:54 +0900
Subject: [PATCH v6 01/13] gpu: nova-core: gsp: sequencer: use
 GspBootContext
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-nova-bootcontext-v6-1-520cbf8b9b50@nvidia.com>
References: <20260709-nova-bootcontext-v6-0-520cbf8b9b50@nvidia.com>
In-Reply-To: <20260709-nova-bootcontext-v6-0-520cbf8b9b50@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0052.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::13) To MN2PR12MB3997.namprd12.prod.outlook.com
 (2603:10b6:208:161::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|LV8PR12MB9668:EE_
X-MS-Office365-Filtering-Correlation-Id: aaa1395d-0698-430b-9c63-08dedd87380c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|10070799003|1800799024|3023799007|11063799006|56012099006|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: nHWegCjtGexqjwKlbehVDb0Mi+L1fKgN6CdHodlV8kehTE8ur7uzvmF5mVEb+WKrFLnIeiERSUh4IAvhS/RzN+/BajnLzeBYhhpEzlWB/TKhxxfbly1XTFCWL9t3C+NJLfyAxqkzVMTQpqW3WLS1j5m2St/0K3iOy7Zw9XXQWkBnM6lEo4mh9Lvx+MWcQGvwD9pGeAh3vm5n4me3R1kEBwK+vHxsi/60ZlgdFVIiF07JpZ09+CYUD5fT2fY7qirzXc9Pf/77HB/BXPgrNae3Z6hC8Tkbnvf9ydrtZh+akg1ciZwD5ZCLDm52lnN4xMtFwdlxP0Lu6UBM3IxptZE/9mpTqIAmWstvKbyoQp8ImktOy1D6XoTA0aIbHu1iiIFCOM9skgd8BHGa7l7JVQbU7lyaEGnlsBQyZedR523XM+r/RsTMIQq/R7sgDkJyg9vrFCuCpv2M6Z1O4Xke8opfEKWFAPsaUNa8PDiD4EQRTc2LvX46cJnnNBUq1eGinx/S4MLjSL4DJf1hV81ECTSw8taqWNpzLK/XhDYEA34LKjq3Q9rkzoYqQ5nyVdq8wih+aBJOByGtmD0jdbW/qp8V4I8fSYNmuK7dGB2gt/HV6rVckd+aRG58R6U/zlUpH1VqwJorhN1HzbPm1BqN0ZSHBhmx+UZWiXiOKfBm5Q3TUZ/wu0tHzS4sqNgoBZNVg0tac7k/ihk6WjG9RnVpUQntwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(10070799003)(1800799024)(3023799007)(11063799006)(56012099006)(921020)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWZLSFhFRVY2dDZKc3pLRXMvL212WFRrYUdTZ1E2M2FhaWc2RVdXV0srbC9O?=
 =?utf-8?B?RmdwVGxOZExHNjdLUjNIQXhPeGo0TkJtVGtoUURWQmZDaU1CWjROVkZPZnRC?=
 =?utf-8?B?NVRkdjNQRldXRU5iNGdjNUIwTlZKcnlDblZ4L3EwZlVHRHpnVHRSUTA1bUJh?=
 =?utf-8?B?bVBWT0pNV2FvMEJNajhUNkZZUjYzTStTRHB5QmtpM2ZUbEN0eHBPOTdVL0ow?=
 =?utf-8?B?aGFyVlZQZEd1OFptU2I1SWsveHl5b1JVK1RQcXA1MDV1QVlJc1ArWlRJZEZn?=
 =?utf-8?B?YXJ2WVJEVCtJa1VTUDErNHZIYzM1QjNRbU9naWNDOUVKM2FwWGh1NjNKVE56?=
 =?utf-8?B?MHd0b01vcTgvWjlTQzk2UmV3cnA5TFFwelAzaWk5aVN5SlcxWU83K25Kd2kz?=
 =?utf-8?B?S2xPUDRaQXhRZDdjZVY0QkFxM0F4dnQ1aU5udS95RzhNL25YalZQbG9rUFNr?=
 =?utf-8?B?dHBmc0MzSU5QM3p3VEpmTHN6TjA1Z0VXRFJ2QWJvMWZZQmxGbzZYREVVa240?=
 =?utf-8?B?eUthZ0F0OEJpTmNBTlJFazJ5SWlGdUI3ZTdNVSswUm9PcFRaUzFLWmtJRk4y?=
 =?utf-8?B?R1lvUEZ4QjB3b0lHZDZxdEkxNmtjdkR5Q2p5a1hnRitaanB4NGxPc3cyWWtx?=
 =?utf-8?B?Q2I1UXBmb202bTN0c09IeWNReGlpbXBYaUUwU2lONTRrdi9lRlYvakx4cklJ?=
 =?utf-8?B?VHVCakFEUjJKT011RHlwWGFaSGhvQXNHSURtNVczcUF6TXJqcThBb3JoWGJs?=
 =?utf-8?B?ZnZhZFRESWxTMHVxR3dHVzBLc2FmYWxrMld0bkEvdEFlbGtPbHB0UUZMcWxW?=
 =?utf-8?B?ZklZZ2FoVGFCaVhWczR6bzlKaTBUUk9FazFydytIRlpQTEJoR1FGcVhtRkRm?=
 =?utf-8?B?dzVyUlFlemF2aEo2UWdYQWt4cVp3TDdzUWp5WXBTUVVmU01wbHpSR2w2T2NM?=
 =?utf-8?B?clVCNndHWGJobHlvSVg0UGRBcTFxVWtBTWVnYTVXeGdFYzVJRXZNLzBPUkl6?=
 =?utf-8?B?SHN0WGsyeHczL1QrQUtuNWZsOWR4KzNkRUVNbmMyR01aVnQwSkZ2SmdJYkc5?=
 =?utf-8?B?WDZGelcyRW9qOC8xSElOUktRdHFncVJDZFF1UFdNZmlTQko1RXlpZndYdHc1?=
 =?utf-8?B?TXNMWThHTVhXdlp0VSsvMnAyTFczak5CbUlYdXNtdUptdVcwdVFNL2o4N0Rt?=
 =?utf-8?B?YVMyMGhvTTVrdnhqSHVPV2JRYThLczQ0aUpSZWRxUm04Zy9PRWhZVGJ0M2lZ?=
 =?utf-8?B?VWY1VUh6TUN2b1dqVEZmMWs5SjZaZ1ErNDJBNlpuWkZKeEVXZjcrRHg0WTVX?=
 =?utf-8?B?V0orcE1VMUpqNG90bS9LWW9SVVZQdm9lRjVSd0V0ck1RZy9DbHJmQy81Q2xF?=
 =?utf-8?B?aWZtZitINE5nWXRGUmhmMHJKQ1dmWlU3ZmgxZTNnVTV0cHlXVmpINEJ6alRN?=
 =?utf-8?B?SE16Ym9uZ3FGZzlrdnJUZHhNb3hTQ3l0K0YvZ1Z6THVFSHoyNFVKUjg1NzlN?=
 =?utf-8?B?MmxoSDNZR0NNN09SQjM4RVloWU80TGs2b0JrZ0R0OU1VQkZMbGNzeU10TzBh?=
 =?utf-8?B?Mzh2bGJXLzN0SkdZRmFFUjNqcnNselhZM0tCWmRvVGVxMUFFOEtzbmdleG80?=
 =?utf-8?B?VkRRODdTS3ZmQlNqT05YYzdYSTlhOHRiVlRMVHhzT3RmMEFaOURIdm9DOWJr?=
 =?utf-8?B?WGZUaTBFZ3BDWDJvWncvUGtPcTZqajIwQUFucUlvZ3F4M01xYzZQTnVxcVEx?=
 =?utf-8?B?WDlva2JwTGcwL3YrdW9zSXR0OGkrYkl5cUtzajdEWTR2cC9tZnB5L1l2UDNE?=
 =?utf-8?B?YWJNTkE1bTc2VnF3N0YxREp3KzRscVZSb0JjdE9TUG1CaW1JWWdGL2hQa2Ra?=
 =?utf-8?B?QlFRK1MxVGJEZUVTcEFIbDdUcnV1TTRnS3c4ZURaQkdXYW1pSzV6ekhGSzRI?=
 =?utf-8?B?emVCM0t2c21jTFFiUlk4cmhiNGZrekc2bEtnYmYzSGZyVkdGODU0UlhVWElR?=
 =?utf-8?B?S1h6QjlNR25uOWs4U3NTQ2p6TE5XbnBrR1FxcDlTL1F6eWwrd2lXck91Qmth?=
 =?utf-8?B?ZU5lTkVja3M5YUJMT2RLUWhDSkMvdjRSRVlBZGwyM3YzbWd5c3Z0elJOQkh2?=
 =?utf-8?B?VDlqaU9DWTQva1NGTktXMlNBYmx2bUpML1VGa2lGb0xtekY2bTZRS2VSamha?=
 =?utf-8?B?bzF0dmNwK3Q3ZmtmQkx2eHBEZEJEblgwS01TRk8wa3ZrdGR0YzhjbjA5cGVO?=
 =?utf-8?B?V1I4RkRRK3dTdHBTTGI0azdBL0FiaHdJYzFZRUFLUGNheWVzbmd1WlgzcFJY?=
 =?utf-8?B?amhkT1d0SldrUldwSXNNMDg1akJIeEdJazF5Yzg3R0dPT3ZsYWFaWHFnMldB?=
 =?utf-8?Q?WQ2Ss/HffjV5JnpWZ2C40cCuZdCh+khJGQniZ25hBd+wy?=
X-MS-Exchange-AntiSpam-MessageData-1: PTCRkb+3qwm8GQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa1395d-0698-430b-9c63-08dedd87380c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 06:56:36.6992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iIoNoNYFEa3QVtcmtb5BNGQwLMzA2Hr4s9bmJghJ5SDCdR5wnU1vx3U2hRQRbVe/4Ukktg1nJDUmWk2ynLnOAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9668
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

`GspBootContext` contains all the resources currently carried by
`GspSequencerParams`, so replace the latter with the former for better
integration with the boot process and less code.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 21 +++++++-------------
 drivers/gpu/nova-core/gsp/sequencer.rs | 36 ++++++++++++----------------------
 2 files changed, 20 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index ff71b45b5432..87ceb8878f01 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -37,10 +37,7 @@
             GspHal,
             UnloadBundle, //
         },
-        sequencer::{
-            GspSequencer,
-            GspSequencerParams, //
-        },
+        sequencer::GspSequencer,
         Gsp,
         GspBootContext,
         GspFwWprMeta, //
@@ -326,16 +323,12 @@ fn boot<'a>(
     }
 
     fn post_boot(&self, gsp: &Gsp, ctx: &GspBootContext<'_>, gsp_fw: &GspFirmware) -> Result {
-        // Create and run the GSP sequencer.
-        let seq_params = GspSequencerParams {
-            bootloader_app_version: gsp_fw.bootloader.app_version,
-            libos_dma_handle: gsp.libos.dma_handle(),
-            gsp_falcon: ctx.gsp_falcon,
-            sec2_falcon: ctx.sec2_falcon,
-            dev: ctx.dev(),
-            bar: ctx.bar,
-        };
-        GspSequencer::run(&gsp.cmdq, seq_params)?;
+        GspSequencer::run(
+            &gsp.cmdq,
+            ctx,
+            gsp.libos.dma_handle(),
+            gsp_fw.bootloader.app_version,
+        )?;
 
         Ok(())
     }
diff --git a/drivers/gpu/nova-core/gsp/sequencer.rs b/drivers/gpu/nova-core/gsp/sequencer.rs
index 13983d42b12b..f55205bd61f3 100644
--- a/drivers/gpu/nova-core/gsp/sequencer.rs
+++ b/drivers/gpu/nova-core/gsp/sequencer.rs
@@ -31,6 +31,7 @@
             MessageFromGsp, //
         },
         fw,
+        GspBootContext, //
     },
     num::FromSafeCast,
     sbuffer::SBufferIter,
@@ -335,24 +336,13 @@ fn iter(&self) -> GspSeqIter<'_> {
     }
 }
 
-/// Parameters for running the GSP sequencer.
-pub(crate) struct GspSequencerParams<'a> {
-    /// Bootloader application version.
-    pub(crate) bootloader_app_version: u32,
-    /// LibOS DMA handle address.
-    pub(crate) libos_dma_handle: u64,
-    /// GSP falcon for core operations.
-    pub(crate) gsp_falcon: &'a Falcon<'a, Gsp>,
-    /// SEC2 falcon for core operations.
-    pub(crate) sec2_falcon: &'a Falcon<'a, Sec2>,
-    /// Device for logging.
-    pub(crate) dev: &'a device::Device,
-    /// BAR0 for register access.
-    pub(crate) bar: Bar0<'a>,
-}
-
 impl<'a> GspSequencer<'a> {
-    pub(crate) fn run(cmdq: &Cmdq, params: GspSequencerParams<'a>) -> Result {
+    pub(crate) fn run(
+        cmdq: &Cmdq,
+        ctx: &'a GspBootContext<'_>,
+        libos_dma_handle: u64,
+        bootloader_app_version: u32,
+    ) -> Result {
         let seq_info = loop {
             match cmdq.receive_msg::<GspSequence>(Cmdq::RECEIVE_TIMEOUT) {
                 Ok(seq_info) => break seq_info,
@@ -363,12 +353,12 @@ pub(crate) fn run(cmdq: &Cmdq, params: GspSequencerParams<'a>) -> Result {
 
         let sequencer = GspSequencer {
             seq_info,
-            bar: params.bar,
-            sec2_falcon: params.sec2_falcon,
-            gsp_falcon: params.gsp_falcon,
-            libos_dma_handle: params.libos_dma_handle,
-            bootloader_app_version: params.bootloader_app_version,
-            dev: params.dev,
+            bar: ctx.bar,
+            sec2_falcon: ctx.sec2_falcon,
+            gsp_falcon: ctx.gsp_falcon,
+            libos_dma_handle,
+            bootloader_app_version,
+            dev: ctx.dev(),
         };
 
         dev_dbg!(sequencer.dev, "Running CPU Sequencer commands\n");

-- 
2.55.0

