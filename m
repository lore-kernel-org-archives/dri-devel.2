Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F160FC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 06:57:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54ACE10F3CF;
	Thu,  9 Jul 2026 06:57:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="p8BtR3h6";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011037.outbound.protection.outlook.com [52.101.62.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A5D310F3CC
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 06:57:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HcM18Slz9pqYNnm3djLclvP/tPFFUOjmo27BlB/GVdlUmt6tLP6Q/yYXBga2zKSTQ0PJWuMI0WZ75do/XKQUfMwpFObnbt8CFT28/dcA5DvCIEDfyXOPCvR8R43GoVgW/RJuwBbD2iYf95PkSU4XhReyLBwEtnnffqX1d2pZJaXCXO9ET4hOjoYC1UK7VqbpEfTH6IljsDX1LHkxP94pAABA81ONQTmVkH8TYvEiaq4VUQa+P5wv/mG5jU2HNU6ybKjCWlHgq1UYw2cdAt0wc9oHWpAbLPP/94Bdhp6/JCV0S6gj8H30lX30yQVCeG2xsKamc5EThUDTalwvWiZ8sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+71CJn8/BNHkky7IqdJnlE89JwS+BM5VOqrhGTgi2gU=;
 b=yoIAcfYfKJsU6P0ZilrZ+jwpyXrUSVL0VDXAjipsUHziQXQALqmKIxJWZlR5V6yiuYObejjm7ilStTRdLNC4uldO01KTmpGZlNeC+tykVsiljbcS/Mh1x1x9gTWRcNZiWs+8LnzqyNRxOor0qvljXndXeHFoN4Kb6xNM9PIFiyUN9ksAp5LlGseb1PFs6CSpIe+NPVSS1l2z16RdHKmhC+FMXm9v4hbk6+CT9d4FB1ldlWdEeN3WVEqsITxyTT6ruBvhyrvZQj+FF3b+Do+k94u/JT8iNUjqwgdkoHPK4KD+SAfSo0dAlRL3UVDsCfBTD4aQ9berPmcyAWVFcOPuOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+71CJn8/BNHkky7IqdJnlE89JwS+BM5VOqrhGTgi2gU=;
 b=p8BtR3h6pCmpiApVAUMqGDAMYJAHLLuvW+ol9/OVoxQKZJxgUCRq7Qmk+4q2eFmpivwUwf7rvwEeFGj7E1fzjM37PALqkVprUwJMKp4ZHroqRyoNoy/lwCYCVZEnkvyczILL0yIIs7fz0wFKvffiHCm4CbebQ2MraTyfZNFnyOZQb/dRcKTJ3GZCal12OuITIaFkxTbd0I5pHp5pjLjYNI4WKdvoRP5ri8u9McOf2UdodYpeT0lE1P9IFVfowjLLRzCiWdwhAlyDfd8Vu1Lk1+Ht9wu2WAidnqV/IeF8Km+BxCPdcUUVhfS67utXNStidAiSwffnVMiX5xRJfx/tag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by LV8PR12MB9668.namprd12.prod.outlook.com (2603:10b6:408:295::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 06:57:19 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 06:57:19 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Thu, 09 Jul 2026 15:53:04 +0900
Subject: [PATCH v6 11/13] gpu: nova-core: gsp: pass GspBootContext mutably
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-nova-bootcontext-v6-11-520cbf8b9b50@nvidia.com>
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
X-ClientProxiedBy: TY4PR01CA0092.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|LV8PR12MB9668:EE_
X-MS-Office365-Filtering-Correlation-Id: c2fe88b9-064e-49ef-ecbf-08dedd875199
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|10070799003|1800799024|3023799007|6133799003|11063799006|56012099006|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: tmahugiTplAd4HnIgcjItHisZNwPzm7mzUYuX34uZKJA6iiIPNPSLfu8kUqp3a7wRJDjHzZZNxkDMSrqrTi3jjGHqrjKVYgb8MmlIIpE4uM5xugRi9CZlgDtkKAlcS8Zo7Nj4bpCjDEwYbKQlF99qTvPFxBpUCCXxk2bPBp3myIPxSbtR8qcDhfMzPIPVarFEFylfzraLC+M2HOqSYxXZuP6hsS0soj4LFGBLRr1oktE+1mtZ/O9nrhI0qRHXTo/qKXoCA4D6I4/0BLKRvTDfaCtlsKrgtbP5vlaEeLDbv++B1b5lR7LxC+c0kf/QBYu5326y3I/IEHB5ZZamRhMxuZmj7V1Pi40ZxfiaMcXdxrHhgAkxT8/o8kn8OAe0YT6zDv3JJjlHNyalkd/A8BaaS7NuZlPLiCrrVatausSGtARRh4DAOYTy6JWTUFUEfBXiBQ0neYdIWfSuF82vInxMem9R1HYwZ/rOKHd8vrhm7LuP47ew9pYQadtXqFQF1cXnOBXzB+cD7PIehyd+VdWc6oKjY4bBaKhAvhUtErc4MIUYOmJRr/kkXDEpPXRbUfYRuf/PQW/CmTjivoJf3y2ORZWEOiEKx9Skn4U8qOA08idu5dewg0X/RYakZoFtYuus+4RS8GbBYpbErBepajXAzTaUUqkXBpwGUsr1DfwV79Ci+CGzO2c882khfZwYgWYzqZuEO+Zo9jn2NIy4MbOsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(10070799003)(1800799024)(3023799007)(6133799003)(11063799006)(56012099006)(921020)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejMwVHZWZ1U4bS9pU1hSZHgzN3dISnR0MWcyamw3ZnZEdGZIUUpCWFFvbEtr?=
 =?utf-8?B?aWdNNnA0ZXlVTmtKckhIdG9SdUE3bmNYYUpqZ0hlWkZlZVk1ajBYbGE5YjJF?=
 =?utf-8?B?QzAvNCtSQkpBSlg4enEyOHZERlFQUE1qUEltRkNvdVdxYVYvVWl1bDcxanBn?=
 =?utf-8?B?MGxMSFlqSmpFWTZsMnlheUduWGpXZGwxaVdkaCtvMDFIQmZPbVVzWDZIZzJH?=
 =?utf-8?B?dThadGFuMWpMV2lOemNDcGtIUVU5d0Naa3JrQTMxbjcvcnBOamJUMkgzOFVS?=
 =?utf-8?B?WnJMeTE5aFpHM1IxU0FIT2ZkODBWSU85UHRQRFpqZnJ6Z3U1anRUR3MzekZo?=
 =?utf-8?B?RnFKMGpZbkJXdTdrWUkzZXoxNjd4UWJCb0tSaW8rVHVPUWJ3WjJNSm1rWUN4?=
 =?utf-8?B?NjFmYkZSa3o0bllmN01iNnVsSmtyUm9EaG0xR1RBTGc3UlovbVcvVVlSR3R1?=
 =?utf-8?B?ZUpmRUJVVjVaR2FSZGF5NGtFMGp4S2xVZzNmamkrcHhnY3dKMHI5RTFPY1Rx?=
 =?utf-8?B?dzlDT1VsVkV2UEJ3akpVRGFKd016NWcxMElVb0pLa2x5REZJOW82ZmdOTlBo?=
 =?utf-8?B?MldQUFpoN3lPclpVVVV0QUlOb3pDa3BOOE02QUxGQU9zTkQrY0QvbWozZ05o?=
 =?utf-8?B?SWVHcXc1Q2pmMlQybEp4eGVEdTIyM1V0TityYTdGOEJTN1QvZUxobDU2aXFr?=
 =?utf-8?B?ejh1NWNTTVk5b1BmVnplRHQ4SW5qS0p5Q2lYZkZVNTgzY3NFRTNPNFhIL3g2?=
 =?utf-8?B?bTFZd3BzRFZ3dXNSWVFXaVJ0Sms0UXJKK1g3VGVjN1B6cG9FaEZqaWJNeTBw?=
 =?utf-8?B?elVqcG90Q0J4ME9WdFppTE9hTHRtT1Y5eHhzbmU1QWRoRUhtaS8zcjIvQmd0?=
 =?utf-8?B?N3k5SHBLVEFLUThIMDhucmxxU1dZbmlqTFFxQ1VUYm1hOHVWT3NCUzU0Ykox?=
 =?utf-8?B?dG4xMURoN2hRNVJsa2NqcDhyWmJienduUG1tUUNxdndNaFNoazI4ZEI1SlZQ?=
 =?utf-8?B?SlNwMHNUcEhlcVBpeGw0QXZSQzh3NE80endiVTFNQlFCQW10V1lLOTc3dUZV?=
 =?utf-8?B?LzhQZHBtN2pLUWIvVXdSUVhvSlNPSktxMWZObmxGcUMvbjBlbXcvS0RZWGwx?=
 =?utf-8?B?dkZubWZQTW91MXAzdENETWRoMDhFZTVoWXp4a2V0a1MyYTVGUVVQWDJNVUtY?=
 =?utf-8?B?UENMZlN5S1Bxcm1JcHpDVWdJNlcrL2NYcGRXVVV3M2htcEVrbGNYVkJUMEY1?=
 =?utf-8?B?WncrL0U1QTB2emtPN0E2SFlXa0ZDeTB3dk1MWWw0d0JmdDlKS1RManZwYlpC?=
 =?utf-8?B?RitZTEF4VlViSFpCa09wcktuVTlsQmlsTkNjVlY5ckhvRXJDUVMxODFDeE9u?=
 =?utf-8?B?UzIvUjVlQXFGR2ZpZWhpVjZQZnRTbEdzQldzbVJ1bzlDMEhRaW5UZ1FjVzIv?=
 =?utf-8?B?YjZxenAxRklHdGhtMXl0SUFqd2EwM1dyWkhYYjhvcWU0NTNlWXdCbnIzcVc4?=
 =?utf-8?B?R0FtTHo4ZHFFdkZ1RmV2LzJhZ2ZWaVEvYTJZcEMvUHA1Q2I4QmFPVHRGeVV3?=
 =?utf-8?B?VmNjcGxCL2JOcGJGOWozNDJpbXFuN0ZpQnp3TURwNnY0OFJPY3ZDY014QkFh?=
 =?utf-8?B?YnVod0htVFh1Skc4T0NjcEZtalMvUjlndWhManJWMU9UU2Q4MW9NQnBqMmFy?=
 =?utf-8?B?bU1VZUtsREhRemt6UGJWYkFUWGs2dnUyOTU2eW9XVlAwNzZyOVBmN2liVkVw?=
 =?utf-8?B?NDNCRlVObElydVhBWFdOWnhtaElmQXVrcmJwUndHMUxkUEVKNG8ycjZaYW1T?=
 =?utf-8?B?YWhtbmxUZitVa1VjLzVHeVgyRjRSRjdZVjljMDQyWnIxVDFSOGhIL3lNWVpw?=
 =?utf-8?B?K1hERno2WDNmSmdSaXhnU3FlczN3aExuM01ZTW1lYnJwdnZFWDRIRnZDRlY4?=
 =?utf-8?B?d29RRTdYeXdOR0t3aC9UaFdDaFBqNUdUL2RUZ2lNRTZIQ2RBUGQ3ekxETHJx?=
 =?utf-8?B?enJ5VDhoUzRYWWhlaEt2RmZaUGw4aXBYWllZM2NaSDAvTTdFRjJWQ2RRc1M1?=
 =?utf-8?B?R2tMVDFLMTNWRVRGZzQzclBWaEowR2JZV095c0dDTUNsUmdSTWJZRFYvYm5p?=
 =?utf-8?B?QzFpYzMreVY2Vm50OFRnNXkyZklIVU10Ulp1QnN0OXRPT3BVM2R1amZjNGU0?=
 =?utf-8?B?VWVDa0NJdmFzVUQxKzJsVmxsNkJHUFUyRU5oM093aGZ4a2pDc2l5R0NoeEQr?=
 =?utf-8?B?b0kzTUk5T002dWpNbndpZmdaZkgzNjk0UG1IWHM5eTU3eGowUVV2QXZ2QzV2?=
 =?utf-8?B?WGxaT0lMWXZIYUlCQnFVRExQU0FLZ2o3WXRKN3FQZjFTTnplNzlQVzdPY3hY?=
 =?utf-8?Q?S6QYJnmCDNs3j3NO8XWQ6yngUBpg5BvR0Gqqh0ZNyaA8w?=
X-MS-Exchange-AntiSpam-MessageData-1: JdfY+ir1ebN1tA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2fe88b9-064e-49ef-ecbf-08dedd875199
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 06:57:19.6107 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bbtYIOwZAoDoqMDGuhgZGQhSKN5wHqCS4+WGSK8I/kK1/MLiZ3NiFZtvengLnmuXIUc83Ej3QnJlEYh2bCl84Q==
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

We want to move the `Fsp` instance into `Gpu`, which will require
passing it as a mutable reference in `GspBootContext`, since
`Fsp::boot_fmc` is a mutable method. In order to use the mutable
references it contains, `GspBootContext` must also be mutable.

We will also follow up by making some methods of the `Falcon`s mutable,
which also requires passing them as mutable references.

Thus, make the `GspBootContext` passed to `Gsp::boot` and `Gsp::unload`
mutable, and pass mutable references to it to the GSP boot HAL methods.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/boot.rs      | 28 +++++++++++++++-------------
 drivers/gpu/nova-core/gsp/hal.rs       | 11 ++++++++---
 drivers/gpu/nova-core/gsp/hal/gh100.rs |  4 ++--
 drivers/gpu/nova-core/gsp/hal/tu102.rs |  6 +++---
 4 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 75488a8e3c0b..17e589dbd483 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -39,7 +39,7 @@ impl super::Gsp {
     /// [`Self::unload`]) returned.
     pub(crate) fn boot(
         self: Pin<&mut Self>,
-        ctx: super::GspBootContext<'_>,
+        mut ctx: super::GspBootContext<'_>,
     ) -> Result<Option<super::UnloadBundle>> {
         let pdev = ctx.pdev;
         let bar = ctx.bar;
@@ -56,21 +56,23 @@ pub(crate) fn boot(
         let wpr_meta = Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::new(&gsp_fw, &fb_layout))?;
 
         // Perform the chipset-specific boot sequence, and retrieve the unload bundle.
-        let unload_bundle = hal.boot(&self, &ctx, &fb_layout, &wpr_meta)?.or_else(|| {
-            dev_warn!(dev, "The GSP won't be able to unload properly on unbind.\n");
-            dev_warn!(
-                dev,
-                "The GPU will need to be reset before the driver can bind again.\n"
-            );
+        let unload_bundle = hal
+            .boot(&self, &mut ctx, &fb_layout, &wpr_meta)?
+            .or_else(|| {
+                dev_warn!(dev, "The GSP won't be able to unload properly on unbind.\n");
+                dev_warn!(
+                    dev,
+                    "The GPU will need to be reset before the driver can bind again.\n"
+                );
 
-            None
-        });
+                None
+            });
 
-        let unload_guard =
+        let mut unload_guard =
             ScopeGuard::new_with_data((ctx, unload_bundle), |(ctx, unload_bundle)| {
                 let _ = self.unload(ctx, unload_bundle);
             });
-        let ctx = &unload_guard.0;
+        let ctx = &mut unload_guard.0;
 
         gsp_falcon.write_os_version(gsp_fw.bootloader.app_version);
 
@@ -123,7 +125,7 @@ fn shutdown_gsp(
     /// This stops all activity on the GSP.
     pub(crate) fn unload(
         &self,
-        ctx: super::GspBootContext<'_>,
+        mut ctx: super::GspBootContext<'_>,
         unload_bundle: Option<super::UnloadBundle>,
     ) -> Result {
         let dev = ctx.dev();
@@ -142,7 +144,7 @@ pub(crate) fn unload(
             res = res.and(
                 unload_bundle
                     .0
-                    .run(&ctx)
+                    .run(&mut ctx)
                     .inspect_err(|e| dev_err!(dev, "Unload bundle failed: {:?}\n", e)),
             );
         } else {
diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/gsp/hal.rs
index 9da078dd1059..7ebdeafc1432 100644
--- a/drivers/gpu/nova-core/gsp/hal.rs
+++ b/drivers/gpu/nova-core/gsp/hal.rs
@@ -31,7 +31,7 @@
 /// required for unloading is prepared at load time, and stored here until it needs to be run.
 pub(super) trait UnloadBundle: Send {
     /// Performs the steps required to properly reset the GSP after it has been stopped.
-    fn run(&self, ctx: &GspBootContext<'_>) -> Result;
+    fn run(&self, ctx: &mut GspBootContext<'_>) -> Result;
 }
 
 /// Trait implemented by GSP HALs.
@@ -43,7 +43,7 @@ pub(super) trait GspHal: Send {
     fn boot(
         &self,
         gsp: &Gsp,
-        ctx: &GspBootContext<'_>,
+        ctx: &mut GspBootContext<'_>,
         fb_layout: &FbLayout,
         wpr_meta: &Coherent<GspFwWprMeta>,
     ) -> Result<Option<crate::gsp::UnloadBundle>>;
@@ -52,7 +52,12 @@ fn boot(
     ///
     /// This method is called by the GSP boot code after the GSP is confirmed to be running, and
     /// after the initialization commands have been pushed onto its queue.
-    fn post_boot(&self, _gsp: &Gsp, _ctx: &GspBootContext<'_>, _gsp_fw: &GspFirmware) -> Result {
+    fn post_boot(
+        &self,
+        _gsp: &Gsp,
+        _ctx: &mut GspBootContext<'_>,
+        _gsp_fw: &GspFirmware,
+    ) -> Result {
         Ok(())
     }
 }
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index b991f160abcc..067bb01903e5 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -115,7 +115,7 @@ fn wait_for_gsp_lockdown_release(
 struct FspUnloadBundle;
 
 impl UnloadBundle for FspUnloadBundle {
-    fn run(&self, ctx: &GspBootContext<'_>) -> Result {
+    fn run(&self, ctx: &mut GspBootContext<'_>) -> Result {
         // GSP falcon does most of the work of resetting, so just wait for it to finish.
         read_poll_timeout(
             || Ok(ctx.gsp_falcon.is_riscv_active()),
@@ -138,7 +138,7 @@ impl GspHal for Gh100 {
     fn boot(
         &self,
         gsp: &Gsp,
-        ctx: &GspBootContext<'_>,
+        ctx: &mut GspBootContext<'_>,
         fb_layout: &FbLayout,
         wpr_meta: &Coherent<GspFwWprMeta>,
     ) -> Result<Option<crate::gsp::UnloadBundle>> {
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index 8480e2eb456f..4e2f48c27368 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -78,7 +78,7 @@ struct Sec2UnloadBundle {
 }
 
 impl UnloadBundle for Sec2UnloadBundle {
-    fn run(&self, ctx: &GspBootContext<'_>) -> Result {
+    fn run(&self, ctx: &mut GspBootContext<'_>) -> Result {
         let dev = ctx.dev();
         let bar = ctx.bar;
 
@@ -258,7 +258,7 @@ impl GspHal for Tu102 {
     fn boot(
         &self,
         gsp: &Gsp,
-        ctx: &GspBootContext<'_>,
+        ctx: &mut GspBootContext<'_>,
         fb_layout: &FbLayout,
         wpr_meta: &Coherent<GspFwWprMeta>,
     ) -> Result<Option<crate::gsp::UnloadBundle>> {
@@ -314,7 +314,7 @@ fn boot(
         Ok(unload_guard.dismiss())
     }
 
-    fn post_boot(&self, gsp: &Gsp, ctx: &GspBootContext<'_>, gsp_fw: &GspFirmware) -> Result {
+    fn post_boot(&self, gsp: &Gsp, ctx: &mut GspBootContext<'_>, gsp_fw: &GspFirmware) -> Result {
         GspSequencer::run(
             &gsp.cmdq,
             ctx,

-- 
2.55.0

