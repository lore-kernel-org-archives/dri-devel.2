Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC17C43602
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:22:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6C9010EB82;
	Tue,  7 Jul 2026 07:22:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZwZhNMSE";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010027.outbound.protection.outlook.com [52.101.56.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C45C10EB89
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 07:22:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7g2Zwi8ythsyjnQclfv41J1SHF2bMA9kyq1bCkn/3DPwNhfkm8TlQ/rzzLQmgEmXlRhOUeBKmpIfi2kKC81TgRk0LO83Y6Ns1EWOH20puXrB625zAMIKJHpFM9ZiqKtuz2ypoAt6jfqclMdtjyIBepzQw5zSUG8Y+pKi45StPDmwy3kgJq4oGUDnA1t5c7ujlKefvR6LmXHsknJN5hKK0fALQwILMHaglaoeDFnw009ZWg6o0YQLKM2FH9ebM9YQdKguN/cwp9XVF+Yb4oQwWf+rkRdUpi5XpIYN+ZcyRHdtZoek6K5McIG6UoOqCZEjZLJeqqLI4u6PoPiTW0w1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZI5mlq9+eA+SvFLqSsX/b7DeyL1zhELUSWZVOzZCh18=;
 b=zJOASl3YoRoPK7L6qWJhVEfsbq5F9l8pdkX+OYnCY2ImSvhideepinbpt9Eez90lHw1yJXgX5P65pf7PJMqZDIW1HtyTuvgRgjrStQrJDyouDm9ArCthxJqtFheG65w/W0zD41J0doOphjMhrfNOnT5vnpLYnQS9QAb3YEmVVj+h1xterA7hSKaln/cFXOf3ow7B/mv+lhEeBrWu8/+9H/FgW0MRNnj4aUm3DAateLw+ufWafr7QjN1vp+FSZiAXWfjUPFLutwvVrwQuc4nNQSoCN6IrO6NjSf8W9jFoweMd/MpMh2sgW0uPHn+X5Tncacmtp+fM0QIklxULAyigbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZI5mlq9+eA+SvFLqSsX/b7DeyL1zhELUSWZVOzZCh18=;
 b=ZwZhNMSEJ44OSDYOEeMIU9E3nSdPO6mieJ79aof1ZNjnoNSjEc80+TdzYFWOLYG/+9g1IP54vYYQUaG1J8elqTapQt66GeUkrI23LFeOSrb1tafmERV2fpkagKr2KKgti1wKScBarLzz8m2Zy3q2ZdBuRjGbG9URXPWuNl9heWz2AMc5p1axkNTn7qBDdDNlbqqlqOdANzfqL37YLJRQWxmkBjbwNcjSy7mrPfulbyv1AQhzCXgt+k6wWUjFlCjDLIyrLDOjOKTeticQkb0Q/CcrmRXqa7QXeed+I2OUWhT74YrC3ndYeyrF8wH6ljWyOHQpyqswHb4J9GH64Ufovw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Tue, 7 Jul 2026
 07:22:37 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 07:22:37 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 07 Jul 2026 16:21:44 +0900
Subject: [PATCH v5 11/13] gpu: nova-core: gsp: pass GspBootContext mutably
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-nova-bootcontext-v5-11-ecad9346387f@nvidia.com>
References: <20260707-nova-bootcontext-v5-0-ecad9346387f@nvidia.com>
In-Reply-To: <20260707-nova-bootcontext-v5-0-ecad9346387f@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCPR01CA0146.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: ab0e7bb8-5cf5-4d0a-e5d2-08dedbf88553
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10070799003|18002099003|921020|22082099003|11063799006|3023799007|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: vx4qUk4oOhMR67ATBEbpC4KiEjZ4iDDLFXX/kKDGdac7wX8T6MVNCUkrJn8iBPuNaa3mM1PF3jQwc8yqznveU7bRbq1pNxos+uOIpSd5xqVIwfZtSGH90LT86cmVslezzAQ9vF4O5//j90Rbuzl85Y87fAYNTsXR5Sr+PW0sJXMgya4NUVVuGitY2NrZr+m5vnipwS9x8upBPPxer3PUPwIjBa3KNKNYDYAlpa5SlJyHELjj/oRrpVbcENgNAAKiNsHsZMMZc+3Vf1GGt/sKmCWgdj6udlQ0SxqDGlFy7kb73ZnOFAVn6NwKHSaX2AMmy73wtySA6YSetzq03LS7oe/mHUwrxvM+id8LcDZZ9sj69usl2FsebgW0f6/bv9hqoHafrFt4iqgPMaIyWfFTYRalNqwDCXMAnw2Ba8nfN3yuvWCu2JT84nzJWj+2yVi4wf0f7sXvSawdgkCWRJz4kUrzZpTpy0+tdh9xGw6blnSOwP6Ff4h4FztXAMS3G6/i35rki1dVJQrn0V++PWGS6HA2wE+//NzvDip4l1tKL1RK01zPIW/Nj/Ux5E3CCw3u+wuE292vmbvoLCZhitpxP6+Kqwfcki1aw94Don0IltbfJPi3Do1VJuKvYwo5Vp5x4wKaBoH5DYBVKkiZQneVRuyyufvltNGBllcCTzMlRz5exNsD+8l2ZFkhFP279aBEPbMc8sX0SZDM6PnvOKorzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10070799003)(18002099003)(921020)(22082099003)(11063799006)(3023799007)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnN3UWk4a0tSWTg1ODdaSG9yQ1UxZ0U3TWZPRU9GdWMzUEVGeVVlUGZYclJW?=
 =?utf-8?B?eWlSaFIrZkxLWnlWV1lFSjhYVVBFbGZKenF5bTh5TU90MERlZ3BuMFNlbmxi?=
 =?utf-8?B?a09VcnBrZVU0ZHJLMFFlT1BqM3QxaFpvOE5oRGV0bkNIelNvTEp4eDBpUTlX?=
 =?utf-8?B?ZFBUb3g0ZlpSQ1JZaVhDRFRiTnVpT2xJaDQ3UFR2RGtEMXFCcTU2QU00ZC9k?=
 =?utf-8?B?SndkU1dJSGF2VXh2eTQvdVFwT0dtQ3JtcU1ySzVaWTNQS29hUTByRFBQM2Jy?=
 =?utf-8?B?Y1RTcU1HdENNQmtzVHdjdzRxUS9oSjFYNlVxSkIzaU1BZDcvd1JXS3Y1NElx?=
 =?utf-8?B?bzIxR3h3UjMxcENKYmRyVnA4eSsxMU04UWpxN3FNRFUyclNBZE5jUlRNR1lp?=
 =?utf-8?B?S0hRSVIxbUM3b0tVcHRQa2h4K3pXWFBsTWNBbVQrc0E2NVhuQUMvcTY1V3Nj?=
 =?utf-8?B?blFXQUJ4R2d6VzJRMUExL3lnR1JpZVJFZzMzMXZrd3hnRnZnTlB5ZDc2WFd4?=
 =?utf-8?B?Yk4xdUQ5b0g1MmoraVFyVHlFdC9PWk9wcDBSeExtQVowVFJoWUJkZmZPS2p1?=
 =?utf-8?B?RC9ZVVA4Q3JJZWhvTnQ3ZjNjM09nTkRkckh3MnNNUSs3MXc3S2JHbStESnNX?=
 =?utf-8?B?dzdBalNobWhiT29Mc1ZXSGhNME5jQU13anN0RXRFQVpLWkZtaXQwdXpGL3Fn?=
 =?utf-8?B?Y2JDc01Tc3JVUjFoaERlR0lwd0VzSHAyZXp2Sm1BdVhSQVY4UmRnSlJmQjVN?=
 =?utf-8?B?UUNhUy8yMmY4QTlOc0thdkt1dDRXVDBaRTk1QWYyVi9ocnZ6TEhpaExYVGRE?=
 =?utf-8?B?M2dwUW9LQnJHdmFiT2x4ektWeGRtQWpCTlpnb29wdkc4dGxiZ0Q0UEdWNnhZ?=
 =?utf-8?B?RG83N0lSTW1PU3pJaWVxY2E4MTU0dWZUOERraDk1RWlDSSs1SzhEU0lFOHhk?=
 =?utf-8?B?MmdsTWlmbGtib0xlWC85K3A5ZXFKL0Y3aGxGSmdsWnFaVHgvbXJXZHhpV1JG?=
 =?utf-8?B?d21KWlh6QlR3empwOXRrSWZUeU9OMC92RzZZMXE4dUFsYjRrM1ppY05Pek11?=
 =?utf-8?B?cG9XTDlLMlA5dGRzTU44MFFNdzJ1aUZYdGxjNXowZU5mUzFpbVFDT2ZWZGhp?=
 =?utf-8?B?UCtzYUxVbFZvNFVmVVE3OC8rVEZzaEVtS3JleFhnVUlaUVVxSVNwWWExWllW?=
 =?utf-8?B?ektsTWltWlgyNzRZd1F4S25xSFdIQ1daWW9wQkFnM3dXNWcwN1FYRlhLcmJ2?=
 =?utf-8?B?b1lYWDloK2hQbTZvd1hSSFAxUFpWS0pBcVQza3FkTi9KS0JFSzlESk1rVHYx?=
 =?utf-8?B?aGd5K0xDQmJraW1oRGNiVk9WNVFWL01rN3ZEeDg1NG55VVFEQjQzOCtFMGZn?=
 =?utf-8?B?TWdZdkNERlhSMlVuT05yTE9IVTIyTy9aMGxaSkxuNTVQMmNSckVxNE5UNEtu?=
 =?utf-8?B?U09UOElZY0VZaFJxMHl6ZjNNQjBrUmg5bW1ZR1B1Z2VtVnVsMkVQQldnb2Zh?=
 =?utf-8?B?djVoVlliTWpqZDZESis1cXZzQWpZMUh1REE4N1pnV2xxelJPK0o5cUFSalhY?=
 =?utf-8?B?N2lTUFFSdU5LdEtuaU9pcDdlaU9CTXNkS0drVWllTnl0T3FkeTB6d0dBVzRB?=
 =?utf-8?B?Y2JtMDhEaGNtNzRHTmJXVmwvdXcwWGlFL1FlVGpWS3pLdGE4RU5QK2tTbTVs?=
 =?utf-8?B?dFFnbEpEVzJQbWdlT0ljMmRmSm42NjBsMW12SlhocmdSbjZNN28wT2NLUGxv?=
 =?utf-8?B?YXVPaXlsZHdSNzE2VEkvR3lWWkx1TFhGcXcvN3RSRjNLUno4bDhXSG4xR0Mr?=
 =?utf-8?B?ZTdGUTNLcWpWNUgzTmRhUXBFZnZzZ0xpQ3lnZlpUVG1sL2JQcG9XMk4rVUow?=
 =?utf-8?B?L1RCR1I4T3BLclRRRHN5QmExanl0UUVvL2l6ZXJ1dHFrbDhUbkdqaGwyMkVV?=
 =?utf-8?B?dFYvb25tTEEvWWVXa3FtQi9uMVlqNmduSlNqczg0UlRVbzh3TSsyT0pWTkxn?=
 =?utf-8?B?TVlNTEtSSDZwbHAzblFUcHR5RC9CeXJpd0pacGVwbDF2WFYvRlJmR3YwQTJz?=
 =?utf-8?B?MVUvOVk0R2lOZVo2d1NHNzVIMTJ5RC9KZ0NkNTBVeTBrUGxVcTNvWTNmcHVG?=
 =?utf-8?B?Zmtxanp0S2FxQVZ5VHlIRVZlbjJxN2NwYXJlUDZhTisrYUZOSjM1RVkxSTVB?=
 =?utf-8?B?YjNCTVpyQkZ1WVJYaEh1S0xncmY0cStndmRRREFkTGwveGx4M0QyWjZ6U1Iv?=
 =?utf-8?B?aTcvQllRc0ZETTZibU5iOFdwbkV4cDBOZEVRQTFwenplbU5ZbmVUU0I4ZU5q?=
 =?utf-8?B?UVppVXRBMUhSM1EyeitndllWN3lUQjBhck1XQkxOckFWTFNFZC8rcDhnTDJT?=
 =?utf-8?Q?RqLK4RIzmveD25rHoVMRlvOS5ft9XVsj/9wqmRczNeeDR?=
X-MS-Exchange-AntiSpam-MessageData-1: jn+VMtu0t4oGQA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0e7bb8-5cf5-4d0a-e5d2-08dedbf88553
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 07:22:36.9881 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 46/5BW6AwQU1kRpFVCex/Y6euz1iTi98g3eMfuAqBjsO0mheG8II9/Xcpf5IbqaVnz20N4ET8mmT4ZlIDqr7bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6604
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
index 430ffc57b136..f093e0215b66 100644
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
index aabef45202f7..043a15dda5be 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -114,7 +114,7 @@ fn wait_for_gsp_lockdown_release(
 struct FspUnloadBundle;
 
 impl UnloadBundle for FspUnloadBundle {
-    fn run(&self, ctx: &GspBootContext<'_>) -> Result {
+    fn run(&self, ctx: &mut GspBootContext<'_>) -> Result {
         // GSP falcon does most of the work of resetting, so just wait for it to finish.
         read_poll_timeout(
             || Ok(ctx.gsp_falcon.is_riscv_active()),
@@ -137,7 +137,7 @@ impl GspHal for Gh100 {
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

