Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E49C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:32:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8875910E896;
	Mon, 29 Jun 2026 12:32:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="QesSOF7S";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010021.outbound.protection.outlook.com
 [52.101.193.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF87810E89C
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 12:32:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nsfrQBRO+7m1N/KB03RFUqT8N8/zQBStsHsQf89STJOOg2fYjan21ot4ql5evzT7prS2ryjx2lIKaiNMv8aGEKaq2P3tQAmpnpWRtAV1wexd2iST54Q07d1wIMM6enFIHkqOFboo6zDfoodc2wL3R9iq0t/5zUVvB265MaGag/5zD43ZKANX+fXXQmIumZFhCot8sVg6i57C9WbJtQqlxtbU7CB0Rrvnljpk7n4JLYD5W5/lrIgBfJ8/4Rut9VmGF/cZBxtTJgxyFRNHXfRdgO4cMs3GoaWl7Mrp3A/fPm0Y3Vsz6NtSw9puElpOVlsc3Ac94HB0P2TrYdUPx8JCsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZwN0O5ixNWGvU5rjEctypN9MMb7wpCehNUARTDrm5M=;
 b=cikPWZm+qC31DPVmO7IZQ6/dQL4uoYJeTf7CMb535HK1/F0ur4n9P8RX6wjkhvkeN59ko6jsDFslMaOVJFLJKyYmUR4env5/hwQxxEKPXirIhzy/aWBjP6+Io1/XLEZQMdQgbFXtYxpYVcQM1vNWSJFT+0RpF0mr5XFtyT6hzbbs1b1Gyo8MvRm2hWFwlqfYjwWswUqh7B+QjXWACOx1rEMUqdaLzEx5qk1hhw2O7Oteb3w+qWcfjGojdJ/uQaTZvVPS9683Wy8wB1DB9IPusaA9CEe9dm+LJBBWu8El0DCP3vo8UE+qF2EZFnoZwlTVETU/+vKNACeYUwOaCTcKfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZwN0O5ixNWGvU5rjEctypN9MMb7wpCehNUARTDrm5M=;
 b=QesSOF7SReOEhCenz2kPrQk7uXlptMx57AP9pyM/Gd4FvnS0YL/Rw92yPnExH7MrWiTkTPa4boj/EEQi/m5K6XLX/o7GD5owMoedNc2+zitMuSQd1/33+nFQeaTfjkmNR3v9ppVVedqOS37vm42JrAvbIKINT8XUubv+28SFEk+rRJSYjwak4cklDUK6gr3MzzNdaioK3DX4/I7H/btf+fEmM9eV9njJRyctlS7chGdZGgAbHHUU/9txnfy/BrrZiLosacdGLjTWjzTpqR9fgpOpVAyc1GfBTxvPhYafcUzMZn0J7VIZEpjx87zA5o9uMJk51yXUHjNbH5hwwcnaiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB8122.namprd12.prod.outlook.com (2603:10b6:510:2b7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Mon, 29 Jun
 2026 12:32:30 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 12:32:30 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 29 Jun 2026 21:31:52 +0900
Subject: [PATCH v3 09/12] gpu: nova-core: introduce GspBootMethod
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-nova-bootcontext-v3-9-26cb29ee8dee@nvidia.com>
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
X-ClientProxiedBy: TYCP301CA0047.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: 8563da88-486e-45da-3443-08ded5da7cb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|23010399003|366016|1800799024|3023799007|22082099003|11063799006|56012099006|18002099003|6133799003|921020;
X-Microsoft-Antispam-Message-Info: x6470+r+TASKiChIn7OlyhPxaQI/Ha0jTOsa/OgJi/goRYxsRBUhHvhUqBWJ7PGZo6rkSXVNSBzQ6p8Sl/I9VoThyR88WdSgRqmYHI8ArYWYEDP1kPw2DFgCnBnNOxbLrMAlCMjJ8VzA1483YxIzf/Mua6k+a727++leNnkJElpv0LpX7ZCYifDTs/lARLq16r/g9ucL8swGooHxJ10yYH85jvpWSiemtDZ6zqboQjoEXDpfIjkjXA6hmso1HVTORUh/10ZjpUxY6Ag80EM0eC+UqZwW679ZzFJ2jgjlEDVKnZ4wYfOY2Epzny8Sb0LrS6ZZYm2AY9TSyeNiDQFE9fagobgW3DThYvr3RfwjZSCZeD7uLaHguio7s44/LhjVWAZROkL/JuURhJh+6mCbnitDeatmtcr/MPuU5gE24aYxSwAm5WDntLKCQGwPDtctTWW4pRFNh4Ge6rsfRDCTArqceStxV32LVNnkMEjX+lTeD0Iuk19V4ckfsfcoW5V1sLkgjbJpPOeBiaXcxsvdY7UKG18RXCtzE45pDWpLivYYnIrGMJ5ahoxvNBRUEbDhmGq96j2DYTc9rf4zPz7tWeEMxaSeBG5TzXfubZQaU2qpNwcS3/fw/qbBKVrv3q9q8e7iEOtgF1AdDEAy5rQ5tmeQh4aiiLrBAGAnUv9kYx7CUqKBrwiKGiM6BiB2tytZ0NJZxkSLOsGtIJTpxRou2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(23010399003)(366016)(1800799024)(3023799007)(22082099003)(11063799006)(56012099006)(18002099003)(6133799003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mkh6Z0pGZ25oRHk1dzVQd05MYnJ1dFlFNEQ2VmRERzNrU2tubE4vUnNlVm8x?=
 =?utf-8?B?cVZHT2MrOHhUZlZ3SEtjeGd5Qjg4NG1TN2FhVGV6anpXTnVVK3NzRGk4bFFB?=
 =?utf-8?B?aG0yaC8xaVhJUmJkUWNMcTNoMkd2VzVnYk1kckx0ejVDVjRNeEVmK1hnOWFk?=
 =?utf-8?B?dGRiK3ZXZDIxU3drQkJiUjg5dHk1L0xINEdsL04rZGN3cExiOWgwdkZDQnEr?=
 =?utf-8?B?TXhTeFBvSURobzBoVXY5RzdOTWFSUXlXc3hsem53TXRxTitwckhuQXg3R2d0?=
 =?utf-8?B?bW5od2h2eU1RdGtYV0FUazlHTmRQUE1yYUZ2dlZJYTBhVUtuNS9EZ1ZaaFU3?=
 =?utf-8?B?Wk1hbnJvY1FkdXY3ZWszbE9OekY5N05HNUVQVlZROFQwdmxjMnpldGUrVW8x?=
 =?utf-8?B?QXMwRnhHUTRONWM5akVKM1h5TmRTdXhic2tUQVZtdDNsQm9aVXR3WXlDb2xy?=
 =?utf-8?B?Q2xOZzF6RlN0YU1mRm1YemZsK3B0bnRhYlBuU3B0SEp3b2owUnVpTEFIaEQ3?=
 =?utf-8?B?M09wN2xkNWFKTndMTUdzUnZhOG1ERElOb1NNSkpmRXh1aEFwU2d4aFRGbUk3?=
 =?utf-8?B?UDNTamxZK3pidU52NjhKQ2tTNElHbzB0UStSaDV5WURoeVZsTzN0YnpWSEJM?=
 =?utf-8?B?ZGoxRU9qdURLY3ZUbnNlS3ZHbVVGazdoQnB4T3JaS1hnNzBLdWk4R0VuSGNp?=
 =?utf-8?B?UzlFajZpZkgvUGwvYzl5Q2JWbTlsNW9sRyt1OW1ZdWU3UHdjZUxteWtwM0VW?=
 =?utf-8?B?V2lEcUpkOUJjSy9ZdjIycC9rZXFxaG1rb240d1k4aGpLdEdWWkJLMmdZVWh6?=
 =?utf-8?B?d2c0cFFQSnA3ZERtNUFPbHd6bUdobkVEWGlLVlNyQzVJTnJOTnhISkk1ZTV5?=
 =?utf-8?B?b2prc1pCR0VXTmFQaXhFWmVFSmNKS25tTVh6WWxOaklzN1JQLzhsRGE5REFW?=
 =?utf-8?B?b1NNYjBSd0R1akZlWWgvd2tjdUZLa1lMZFBQWlFseGVGbDk2NXdtQW52SXZj?=
 =?utf-8?B?U29NUlJqNC9TZ0JocTZJcVFhcVNOWFlFVTBSOHk1NWxCMVBPMjRIZFg0dEw5?=
 =?utf-8?B?bkgvNHBUcm85bW1BcVA4dEkxTWl6T21CUFFwMkwyenBnZUUyemFFU1RMbjU4?=
 =?utf-8?B?R21WQ1FDSDIrd0hnRW1MakJUTnVnYWcyZDcwbUV0WUwraUR1dVUwMjZOTUlT?=
 =?utf-8?B?djVzeWxpdVNmMDhYU0cxT01MZ1FSYll5NjNEbW52ZURhWTdDdXVVSFNURXNw?=
 =?utf-8?B?SjE4MjllM3kxVmZFUWhITGxLTDNWdkpNN205ZmJvRVlMcXhWaTFjckUra2Iv?=
 =?utf-8?B?bWw5dVBNdXJsZ1I1bm9Xd0JYRjdvRXZjdXhYNEVoZVhHUkJKeDdWdE53V1lT?=
 =?utf-8?B?eFJJTXRnWkQraUJHZldiR3dObFNPT2toeDlHSmQ1a0llb3czSWoyYWpMTlJp?=
 =?utf-8?B?SGdIdmhkSFA3OENwL2E5ZGtCT2tjUUhsYWVGYkJ4djhWdjd3L1BiRjY0ZUoz?=
 =?utf-8?B?cUFLaGRaVEVBblNXeTllT3I3STdXQ3NvTU9Yc2dOR0M2b1lmeDhwakVOaWJx?=
 =?utf-8?B?OUFERW1aSTV1akVIbkRLZHBmT2d5TUtZN1NRYnBrbE5EVGNNbDNWZkRGVlVN?=
 =?utf-8?B?V3BTVEJLWGJveTh0aStpSmdZVHVJb2U2YkZPR0lpZ244cmJhVEo0QUJEdzUv?=
 =?utf-8?B?NllzdE9XRm9KY1lBSDRKU0JEK0p3OE5RVzI5a1lLc1NIS1F4d0JHSFNnNktH?=
 =?utf-8?B?aThDMEdhenFiWVJtVk05djkzcExRS2MxVXMrd0QzMWhjdHBGMERqMUVNUXB5?=
 =?utf-8?B?QUVPS0Rkb2s2bkI4VEJvaWtLKzVZdURmdTJvWU1DWHZNa2pLQnhxZW5BSDJI?=
 =?utf-8?B?N211OE9xOVpzc1BPZndKeWwxL0JkRHhyWW1yVXd4QjY0aHN3SDJ5WWJJSUNE?=
 =?utf-8?B?WENJNFBZMG5pVnU3MzdDc1BRUXdZRGZtTFcybG1WU0psMzdKSHFSbGZ2RjFY?=
 =?utf-8?B?b3FadlJ1M1ZXTmZDZ24rS0s0WXpIWXNlcTZDaDZpUjVFTytVS24rczk0WTBH?=
 =?utf-8?B?SDdrVS8wY1dWOW1hWmhqWnd4UERHUDk4a0pSQWFKMDlueEtNeWR6djhrZy9l?=
 =?utf-8?B?QjVwaWY3WDFjQXRBUGJBd1E3RndZMXlWOGJNMnFMZWtxeW9WQ094R1JuL0Ry?=
 =?utf-8?B?M0l2MWtkRWE2ZUZxN2F3S0ozSFRDbHc1a0lzcTM3eDRIeW5SNzd0ME9ETE1l?=
 =?utf-8?B?b28zOFQ5K3RhL2tDaHZjWDl6OTlMNytoSEc2UUtCejBmTCtOeDQ1WkRJV1Fx?=
 =?utf-8?B?UGk5UXRpWkdHdmhHNFdRcUFlQTNVUi8rYkhEQVgvUWFROGdCcjgycW0xQ1di?=
 =?utf-8?Q?eVfX7DaiIodbYJe0dTJQaE4Irj1O0uPRI5Hnz1+T8GFp0?=
X-MS-Exchange-AntiSpam-MessageData-1: vewgM4a3Lrx69A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8563da88-486e-45da-3443-08ded5da7cb2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 12:32:30.6439 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ryVofidncoJrZHoGo7iN7YZYxRSj+XDXH4gOM4gbOs3HUtharH9fK6Uv+289FKCYMBqopZ3rAQ6bWXwCXDop3w==
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

The GSP boot method is currently determined by two ad-hoc methods of
`Chipset`: `uses_fsp` (a boolean telling whether to use the FSP boot
path or the Sec2 Booter one) and `needs_fwsec_bootloader` (another
boolean valid only for the Sec2 Booter method that tells whether the
FWSEC bootloader must be used).

This is neither extensible nor sound: the combination `uses_fsp &&
needs_fwsec_bootloader` is invalid, but can still be expressed.

Thus, unify these two predicates into a single `gsp_boot_method` method
that returns an enum type unambiguously describing the boot method to
use. This ensures that no invalid combination can be expressed, which
makes matching sounder.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/firmware.rs       | 25 ++++++++++++--------
 drivers/gpu/nova-core/firmware/fwsec.rs |  5 ++--
 drivers/gpu/nova-core/gpu.rs            | 16 -------------
 drivers/gpu/nova-core/gsp.rs            | 42 ++++++++++++++++++++++++++++++++-
 drivers/gpu/nova-core/gsp/hal.rs        | 22 ++++++++---------
 5 files changed, 70 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/nova-core/firmware.rs b/drivers/gpu/nova-core/firmware.rs
index 80e948bf7511..7a5978f93f4e 100644
--- a/drivers/gpu/nova-core/firmware.rs
+++ b/drivers/gpu/nova-core/firmware.rs
@@ -21,6 +21,7 @@
         FalconFirmware, //
     },
     gpu,
+    gsp::GspBootMethod,
     num::{
         FromSafeCast,
         IntoSafeCast, //
@@ -429,17 +430,21 @@ const fn make_entry_chipset(self, chipset: gpu::Chipset) -> Self {
 
         // FSP-based chipsets (Hopper, Blackwell and later) boot the GSP via the FMC image loaded by
         // FSP. Older chipsets use the SEC2 booter instead.
-        let this = if chipset.uses_fsp() {
-            this.make_entry_file(name, "fmc")
-        } else {
-            this.make_entry_file(name, "booter_load")
-                .make_entry_file(name, "booter_unload")
-        };
+        match chipset.gsp_boot_method() {
+            GspBootMethod::Sec2 {
+                needs_fwsec_bootloader,
+            } => {
+                let mut this = this
+                    .make_entry_file(name, "booter_load")
+                    .make_entry_file(name, "booter_unload");
 
-        if chipset.needs_fwsec_bootloader() {
-            this.make_entry_file(name, "gen_bootloader")
-        } else {
-            this
+                if needs_fwsec_bootloader {
+                    this = this.make_entry_file(name, "gen_bootloader")
+                }
+
+                this
+            }
+            GspBootMethod::Fsp => this.make_entry_file(name, "fmc"),
         }
     }
 
diff --git a/drivers/gpu/nova-core/firmware/fwsec.rs b/drivers/gpu/nova-core/firmware/fwsec.rs
index 199ae2adb664..a3a43a27ddd7 100644
--- a/drivers/gpu/nova-core/firmware/fwsec.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec.rs
@@ -388,8 +388,9 @@ pub(crate) fn new(
     /// Loads the FWSEC firmware into `falcon` and execute it.
     ///
     /// This must only be called on chipsets that do not need the FWSEC bootloader (i.e., where
-    /// [`Chipset::needs_fwsec_bootloader()`](crate::gpu::Chipset::needs_fwsec_bootloader) returns
-    /// `false`). On chipsets that do, use [`bootloader::FwsecFirmwareWithBl`] instead.
+    /// [`Chipset::gsp_boot_method()`](crate::gpu::Chipset::gsp_boot_method) returns
+    /// `GspBootMethod::Sec2 { needs_fwsec_bootloader: false }`). On chipsets where
+    /// `needs_fwsec_bootloader` is `true`, use [`bootloader::FwsecFirmwareWithBl`] instead.
     pub(crate) fn run(
         &self,
         dev: &Device<device::Bound>,
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 4ee0a43ac4b6..b3f04239d938 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -133,22 +133,6 @@ pub(crate) const fn arch(self) -> Architecture {
         }
     }
 
-    /// Returns `true` if this chipset requires the PIO-loaded bootloader in order to boot FWSEC.
-    ///
-    /// This includes all chipsets < GA102.
-    pub(crate) const fn needs_fwsec_bootloader(self) -> bool {
-        matches!(self.arch(), Architecture::Turing) || matches!(self, Self::GA100)
-    }
-
-    /// Returns `true` if this chipset boots via FSP (Hopper and later), which requires the FMC
-    /// firmware image.
-    pub(crate) const fn uses_fsp(self) -> bool {
-        matches!(
-            self.arch(),
-            Architecture::Hopper | Architecture::BlackwellGB10x | Architecture::BlackwellGB20x
-        )
-    }
-
     /// Returns the address range of the PCI config mirror space.
     pub(crate) fn pci_config_mirror_range(self) -> Range<u32> {
         hal::gpu_hal(self).pci_config_mirror_range()
diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index 73e93403601c..771b38e6335d 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -38,7 +38,10 @@
         sec2::Sec2 as Sec2Falcon,
         Falcon, //
     },
-    gpu::Chipset,
+    gpu::{
+        Architecture,
+        Chipset, //
+    },
     gsp::{
         cmdq::Cmdq,
         fw::{
@@ -217,5 +220,42 @@ pub(crate) fn get_static_info(&self, bar: Bar0<'_>) -> Result<commands::GetGspSt
     }
 }
 
+/// Method used to boot the GSP.
+#[derive(Copy, Clone, PartialEq, Eq)]
+pub(crate) enum GspBootMethod {
+    /// GSP is booted by running FWSEC-FRTS on the GSP falcon, followed by the Booter loader on the
+    /// SEC2 falcon.
+    ///
+    /// `needs_fwsec_bootloader` indicates whether the chipset requires the PIO-loaded bootloader in
+    /// order to boot FWSEC.
+    Sec2 { needs_fwsec_bootloader: bool },
+    /// GSP is booted via FSP Chain-of-Trust.
+    Fsp,
+}
+
+impl Chipset {
+    /// Returns the method used to boot the GSP on this chipset.
+    pub(crate) const fn gsp_boot_method(self) -> GspBootMethod {
+        match self.arch() {
+            // All Turing chipsets require the FWSEC bootloader.
+            Architecture::Turing => GspBootMethod::Sec2 {
+                needs_fwsec_bootloader: true,
+            },
+            // GA100 also requires the FWSEC bootloader.
+            Architecture::Ampere if matches!(self, Self::GA100) => GspBootMethod::Sec2 {
+                needs_fwsec_bootloader: true,
+            },
+            // Other Ampere chipsets, as well as Ada chipsets, do not require the FWSEC bootloader.
+            Architecture::Ampere | Architecture::Ada => GspBootMethod::Sec2 {
+                needs_fwsec_bootloader: false,
+            },
+            // Hopper and more recent use the FSP Chain-of-Trust boot method.
+            Architecture::Hopper | Architecture::BlackwellGB10x | Architecture::BlackwellGB20x => {
+                GspBootMethod::Fsp
+            }
+        }
+    }
+}
+
 /// Opaque bundle required to unload the GSP. Created by [`Gsp::boot`], consumed by [`Gsp::unload`].
 pub(crate) struct UnloadBundle(KBox<dyn hal::UnloadBundle>);
diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/gsp/hal.rs
index eddb4e8bf510..90f076f640e0 100644
--- a/drivers/gpu/nova-core/gsp/hal.rs
+++ b/drivers/gpu/nova-core/gsp/hal.rs
@@ -13,13 +13,11 @@
 use crate::{
     fb::FbLayout,
     firmware::gsp::GspFirmware,
-    gpu::{
-        Architecture,
-        Chipset, //
-    },
+    gpu::Chipset,
     gsp::{
         Gsp,
         GspBootContext,
+        GspBootMethod,
         GspFwWprMeta, //
     },
 };
@@ -59,12 +57,14 @@ fn post_boot(&self, _gsp: &Gsp, _ctx: &GspBootContext<'_>, _gsp_fw: &GspFirmware
 
 /// Returns the GSP HAL to be used for `chipset`.
 pub(super) fn gsp_hal(chipset: Chipset) -> &'static dyn GspHal {
-    match chipset.arch() {
-        Architecture::Turing => tu102::TU102_HAL,
-        Architecture::Ampere if matches!(chipset, Chipset::GA100) => tu102::TU102_HAL,
-        Architecture::Ampere | Architecture::Ada => ga102::GA102_HAL,
-        Architecture::Hopper | Architecture::BlackwellGB10x | Architecture::BlackwellGB20x => {
-            gh100::GH100_HAL
-        }
+    // The GSP HAL is entirely determined by the boot method.
+    match chipset.gsp_boot_method() {
+        GspBootMethod::Sec2 {
+            needs_fwsec_bootloader: true,
+        } => tu102::TU102_HAL,
+        GspBootMethod::Sec2 {
+            needs_fwsec_bootloader: false,
+        } => ga102::GA102_HAL,
+        GspBootMethod::Fsp => gh100::GH100_HAL,
     }
 }

-- 
2.54.0

