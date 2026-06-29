Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE44AC43602
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:32:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0654110E89E;
	Mon, 29 Jun 2026 12:32:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Abtegkvs";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010016.outbound.protection.outlook.com
 [52.101.193.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCEEF10E89C
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 12:32:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BBljfVxmZPxgZrkwDp4w8ew4vXHHAn9HVWj8aRj+1VlIlxI11bdvd5MHjMj5EJDFspzxp0r+I8rYkt3mGAIJunsiaGaUeN2ovZClg5TBiX/dacXDdn3l0CgNxOTGF6Laz1aVdQkjLKAv326v4lmI8UoMyl2vcYgwuznyW8o7hTw7jAF+mr5tg2iG7vLIg+OfVgipGh1YCbcfVLZPOb5EqlgXE6hL0ubVPOZckT3einuAcrTpCsKKxH6Nq1dzWjAnA1fxSMcKdSq2LfJ6wevXK/qc72UoRM7tNYjIfG+ic/fczqfUWJiM+Cf4E5AlnMDrMDIZOm8M/aAUftB10WlwtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=if8O/WtNgxPPaNrkP93XG8Q50dNH+/1a6I60AvG96HQ=;
 b=B2g2PL6d1f1aaqwgse2ww+BWDFFBq1WbbCqJrP2/Xpdm6ouZusblXAMacI4DD5axcLr7kKy0hHyu20qr7O2YiceRrPbIBz/0CUZyW5oE5s0QRY6M4gFca89YAJyPV2PeFGLjLzpghCAd1YdI2JrskyGjDwCxeQkY2E19KZPdL0xjbYQWxkBZtqb8HI2+KIS6T+5c4+BoZxjLCRbR1zbcyhpoueVE8y2RvGzdrg5sSb2tGKFV33FtrbXAlWaER7kRd7ieZ1hzeLliv+bEPYzm+FlYnVU/fUrEZ/1htMYbo3seIbigmG8nJktIScEUYvPyrGLOTXtRDx51hPZPBILfNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=if8O/WtNgxPPaNrkP93XG8Q50dNH+/1a6I60AvG96HQ=;
 b=AbtegkvsuCYlIysUdMZF1i/Jnv8w8enHHF+zxxQ+BE/nRiDhAKNWwst+gs1xfy/9pMUERvRt/wvILwXd1fNbXIACIvabpnw3+qb/cG42e2Dsud1rMIrMgVhbMbL9iOQqT+xQuAbAVt67Z0kjMwqOk1BTUAbx+H3HbK4qTBTh8A/tPnPyKRuAMqWzgfaKFMHaNxW+ew6h2ld4MpoX/DOXtpXaBC0mlADWb8OOGi3hugUk/n2sK032EyJ1oSOjVC8J4mhLE7VAIRrizOUvmb/RlFW5pKYQczOgPa+mXELcpW1B/VWe66EKsS4k4ysa01gLF19Hgjk7zd/zIe835Tde2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB8122.namprd12.prod.outlook.com (2603:10b6:510:2b7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Mon, 29 Jun
 2026 12:32:38 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 12:32:38 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 29 Jun 2026 21:31:54 +0900
Subject: [PATCH v3 11/12] gpu: nova-core: gsp: pass GspBootContext mutably
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-nova-bootcontext-v3-11-26cb29ee8dee@nvidia.com>
References: <20260629-nova-bootcontext-v3-0-26cb29ee8dee@nvidia.com>
In-Reply-To: <20260629-nova-bootcontext-v3-0-26cb29ee8dee@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0003.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: 7054ea1f-ac62-48f2-c555-08ded5da817b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|23010399003|366016|1800799024|3023799007|22082099003|11063799006|56012099006|18002099003|6133799003|921020;
X-Microsoft-Antispam-Message-Info: N5KVafw5O98otdISzbMJ+EZrJp6SW/cR9qJxBWPzoxHan+TlvYrMUALHSQiYfLvSRJybiz7PaJDVoecqj9X4KX+dbpx6duM3uGvfGFeVh6WhY7aDir56Qh2XQkrz2n4Kmz9f+U1ybz9APY30EegvMdFquOICKHqDR0COuFeHnt/wy7GwOIV6xJO5WZ1p4sy+8/W/7XEzvJ0L3jzOCXmVppjILXh5hK+wwAq9RnhLhJ3DTRLP/EPppjvQBNhtdwIfKBErL8A0HyxbBIcniL//4DM8Yv0L1LrdzEtCitccHnl7jj6AG9azASjCUq47pwnvcw5AkFwhCnLczeqveiA2t+XK8Cg169I8kcyQJ9yn1tR6VURjISOwifn5aQ3pb/4fRak9wuuO50keA/hRBzwqdnak3lUw+H7TbgxXnEDVIJWZimmRiQ1iqhHGAI5CWvGp9z9HV31w3alYfsQF/UmMSkh9Q6PQIkrTGqygsDQ+ji9nVEhASZzRYus++oPhh2Zr9fySJwZCkd4ML1HNGXcQmDbrQwbPUhC0Hp0Wvv7TIAENProQ9FJ4ZxSQ8dJKqaLl8THQYvMw2gnvskD5Xbdf0r7VfRC1gKg8QlZXCez5OaTAOL+Hi9NuLAsd3hVFzLnEtXeyN4LjEzcEf8d5jxzvxWqio3rBrazayXYNoIggZRif3xI1EfZGehtPpSHLTozEdyg2D6eTCk6FhyKACYIOJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(23010399003)(366016)(1800799024)(3023799007)(22082099003)(11063799006)(56012099006)(18002099003)(6133799003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVNESTFVMk1ZejVEaU92UTkwTFdUY2tKNDRXV1NPbjd4VENxcU5ieUhabHNN?=
 =?utf-8?B?T3ppZGVlK0IrS1FJZ2lsb1lPYWhQRndGd0xBOFVtYnBkUzZtMjJqS0dYb1hI?=
 =?utf-8?B?UlQxVVI2eFBuYmJHZEFFRlhWK2NJY2FJMk5jZFlzeDZZcHpyRVFEOTl0djgw?=
 =?utf-8?B?RXZvbUJVVEcyaHV0dWtXQys0dUFYWkhFc1RaMlZ0TExSM2xtYk5wdWsrNDlV?=
 =?utf-8?B?b1FxNEwzSUoyelRudU0rc2VrUzhTN1BhS21KWnNRT2ptTFZwVllLQnVSeXlO?=
 =?utf-8?B?YUJwb1UvTUhMczg3czZHK3FQV2VRTGZ1TW5BbkYrenY2SE1CRVdKYkgzWFNR?=
 =?utf-8?B?dzkxdVVlTjM1dHM3UXRsTEM2ZWNLVVRGdEhJZG1PMmdKaEhUaEszY0hOSE5C?=
 =?utf-8?B?YVIzdnZmWE9xSEdpSWZOdmI0TnVZM2JjdE1tSVd5RE9UcVJ5T1BubUs0S1Bq?=
 =?utf-8?B?ZTdzeFpHUVJzYmROOHQ0bS8zTUZlZ1k5ZE5FZE44V2JPMzNxQTBGWVlhUlNT?=
 =?utf-8?B?eEtkSTRaT1hyV1BiYmppb2pYbTFSK1AxQk1nbnFIRTJIc0daR1VtRy8weCtW?=
 =?utf-8?B?WDVkYnA1aEFWM2tJZWJBYXdySVRMSlJwbTZOVTZERi8wK201QnFNcHhibG1H?=
 =?utf-8?B?UWpucXFKSHUyaFVobXc5cWUvbmdpZVJveStGQ29VQ2dCald4SlQxaXRERVk1?=
 =?utf-8?B?WGtnSmhlZEJQOWtkbUdnNE94MkV6ZTE0SWtxSUdLQm1sN01uZDdlSmlCT25m?=
 =?utf-8?B?OWdMaytuWm03bjU1RnNBNGRnSUF1M1ZPaFpNVlVWV1BJeGZLVExRcjZRRzhH?=
 =?utf-8?B?enR4WnBuQWYwVkp6Q00vTWZtWXd5Ulc1bndzNlZtUXh4Y0NKWUo0WVlUZnQz?=
 =?utf-8?B?S0F2dWFHYXQyempoWHFUditpd2hMdm5HTkg1SWNhZ1k2WHlBR3JYZGNrYVR2?=
 =?utf-8?B?NjhJY1Vaa0JmaDNITExsL0JWVjFMZThONzdwK3BlWnl5MUtLYzQzUHMzQmJ2?=
 =?utf-8?B?Q3JDWEkzak54dWhFQ2ZsQnVxa2xEZTlJL29qbllnZVlrRlRkL3BSak80RWVw?=
 =?utf-8?B?NGQySWdFaUdpeTB2RW9jWCttSFZXeVF0L01URGFlVEpYbS8ycDluUmlud2xr?=
 =?utf-8?B?SHVWRlFrZDd1UzF4KzVlUkIwb2twR3M3VlFxQlpkZ2dQRnJYZkZTT1BwbEw1?=
 =?utf-8?B?clZDM0JkMnp1MXFZVGkxQkVNczlrS0VubkpERWJOM05jdW0rclhyQlZRUFZO?=
 =?utf-8?B?VTN6eEQwRHFyZVRjTU9zZmxjUE1aTWk1WXZ2MFlOTDVrMEc0QnZ2MGIyUkd4?=
 =?utf-8?B?WnZocWd5bEJzdFRPZUYxMEJYa21tRnQ4QlN5L3NTZ2dIZ1ViaElHNi8xczVO?=
 =?utf-8?B?aHRROXhOWTQwNDIza3VBcFBua204a1hVTitaMWlFTldZRDhMMDRDdHVOc3RL?=
 =?utf-8?B?RzkyYVE4V09na3RkTzhpSUJrUVRoMnVDTUVqVzArckNCcmE5ekNFRW14aWQ3?=
 =?utf-8?B?Ukh0WUZRMElRMzZ0bGxaSTFvMHp0L2x2Vjg4MHVXZ2c0SWVRRGVLendOMGxU?=
 =?utf-8?B?VWVleks3Ylk3WUVKZ0gwMC9OUnZub1lZdnBpSTlKclZjcFlPYUVJNURicEI2?=
 =?utf-8?B?YlJNWnl1eW14aWlxUHp0SzFvaHdTc2gvWmtscU04R0x0bTJMQy9MN3Z6Z1Yr?=
 =?utf-8?B?RFgzNzhobnVOK0k3VEM1QXBqR21OZkk3ZXpEaCsvdFhaU1VSMlNzY2pLK0ZN?=
 =?utf-8?B?ankvYS94SDdTMWtIdTlDdktMWmdwRjgyVjYzT0lJcmk0VVZUL0VWblI2UVQz?=
 =?utf-8?B?Z255MXQxK0hrdTB2dmZLWElTamZnSi9RYXhVZVNYbDg4QVpDS0s4Ty9PQ2VT?=
 =?utf-8?B?V1JtemZDb3JkcE5qQitYL2h1NTdmQ1Y3M0JwR0d0M0Ywelo0ZUxhYVBCRWlF?=
 =?utf-8?B?Q1lSWTNhN2dCNnpYWWdyV0FEemxaMThmbHIzVzJUdjBvM3g3Nmpxak9IYmsy?=
 =?utf-8?B?UWNycWwvUlRoV01tWDNsV2tnR1NaUW5qZHBYVXlXN3NjWkpqWEludEI2UVBt?=
 =?utf-8?B?MTl6MldldFdrYjBSWGczR05iSmtlTEtCSlFQb1JUZlMvMERPbm5McFBIUkZJ?=
 =?utf-8?B?bnRuUGJaTTAyVUxhRGtNb0srdHlNdlF3THhzdDg2WTF0cG9neFYzbUlYSjg3?=
 =?utf-8?B?a3ZCNHFUU2NTVnJ4bFJ5MVZ0ODZnUDBqOStNN2ZBcC83WitIWHpub3NmL2Jj?=
 =?utf-8?B?dWxHRjZuVnlqR3BUZlhaYWRiN2xjQ0xPeG9jUCtSZG5rSjNkaEhmSGtacjBm?=
 =?utf-8?B?WlZOcWJXakpqUUlqNGt5OXBubVZKcVZmZ21pWlZMckQ2Uy91cnNyOUxwUU9L?=
 =?utf-8?Q?HwHIxMu24PhiU/MfIgAVAtr98+K0CdSBkqNg1XmGG5ddt?=
X-MS-Exchange-AntiSpam-MessageData-1: MNKe3aIlmKSFDw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7054ea1f-ac62-48f2-c555-08ded5da817b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 12:32:38.6686 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xOqlL8xddFZbHD/PNw0RYrIlzPen43ycq4nJwJownZ3gy5yREU+Nln6Xx5KYknfY4muzZhUtiyL2ql6CV59VRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8122
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
---
 drivers/gpu/nova-core/gsp/boot.rs      | 28 +++++++++++++++-------------
 drivers/gpu/nova-core/gsp/hal.rs       | 11 ++++++++---
 drivers/gpu/nova-core/gsp/hal/gh100.rs |  4 ++--
 drivers/gpu/nova-core/gsp/hal/tu102.rs |  6 +++---
 4 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 5f11c8e10a0a..dce07878449e 100644
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
 
         gsp_falcon.write_os_version(bar, gsp_fw.bootloader.app_version);
 
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
index 90f076f640e0..a5d0da05ef5f 100644
--- a/drivers/gpu/nova-core/gsp/hal.rs
+++ b/drivers/gpu/nova-core/gsp/hal.rs
@@ -29,7 +29,7 @@
 /// required for unloading is prepared at load time, and stored here until it needs to be run.
 pub(super) trait UnloadBundle: Send {
     /// Performs the steps required to properly reset the GSP after it has been stopped.
-    fn run(&self, ctx: &GspBootContext<'_>) -> Result;
+    fn run(&self, ctx: &mut GspBootContext<'_>) -> Result;
 }
 
 /// Trait implemented by GSP HALs.
@@ -41,7 +41,7 @@ pub(super) trait GspHal: Send {
     fn boot(
         &self,
         gsp: &Gsp,
-        ctx: &GspBootContext<'_>,
+        ctx: &mut GspBootContext<'_>,
         fb_layout: &FbLayout,
         wpr_meta: &Coherent<GspFwWprMeta>,
     ) -> Result<Option<crate::gsp::UnloadBundle>>;
@@ -50,7 +50,12 @@ fn boot(
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
index 8dfbc402c13b..a617b8f5974f 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -117,7 +117,7 @@ fn wait_for_gsp_lockdown_release(
 struct FspUnloadBundle;
 
 impl UnloadBundle for FspUnloadBundle {
-    fn run(&self, ctx: &GspBootContext<'_>) -> Result {
+    fn run(&self, ctx: &mut GspBootContext<'_>) -> Result {
         // GSP falcon does most of the work of resetting, so just wait for it to finish.
         read_poll_timeout(
             || Ok(ctx.gsp_falcon.is_riscv_active(ctx.bar)),
@@ -140,7 +140,7 @@ impl GspHal for Gh100 {
     fn boot(
         &self,
         gsp: &Gsp,
-        ctx: &GspBootContext<'_>,
+        ctx: &mut GspBootContext<'_>,
         fb_layout: &FbLayout,
         wpr_meta: &Coherent<GspFwWprMeta>,
     ) -> Result<Option<crate::gsp::UnloadBundle>> {
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index 6a114f696c22..305515ef2700 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -78,7 +78,7 @@ struct Sec2UnloadBundle {
 }
 
 impl UnloadBundle for Sec2UnloadBundle {
-    fn run(&self, ctx: &GspBootContext<'_>) -> Result {
+    fn run(&self, ctx: &mut GspBootContext<'_>) -> Result {
         let dev = ctx.dev();
         let bar = ctx.bar;
 
@@ -264,7 +264,7 @@ impl GspHal for Tu102 {
     fn boot(
         &self,
         gsp: &Gsp,
-        ctx: &GspBootContext<'_>,
+        ctx: &mut GspBootContext<'_>,
         fb_layout: &FbLayout,
         wpr_meta: &Coherent<GspFwWprMeta>,
     ) -> Result<Option<crate::gsp::UnloadBundle>> {
@@ -324,7 +324,7 @@ fn boot(
         Ok(unload_guard.dismiss())
     }
 
-    fn post_boot(&self, gsp: &Gsp, ctx: &GspBootContext<'_>, gsp_fw: &GspFirmware) -> Result {
+    fn post_boot(&self, gsp: &Gsp, ctx: &mut GspBootContext<'_>, gsp_fw: &GspFirmware) -> Result {
         GspSequencer::run(
             &gsp.cmdq,
             ctx,

-- 
2.54.0

