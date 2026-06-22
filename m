Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7ADCDB471
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 07:11:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A499D10E4E5;
	Mon, 22 Jun 2026 07:11:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ukXvQhTZ";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010017.outbound.protection.outlook.com [52.101.201.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7B3010E4F1
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 07:11:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zIbCKTlW1m6maD03LR0fBUhD0EPE2nxhmvQ3ifDlraHhA1CmfzF7pb37glcxCj8VXYxAAubi+or28fl3yHjgLHC0uouu4UJ2NmETPHujZT7fwcviC+JcBje4KE56i2sKBf9wejxQsOgmKFTDlVSPIiaodVJI2cGBcHfOsmBjJPKC+VFOIhiSAym0S/HTZ71UDWXpCA+/SMsur2kF8ZtTnNdR44AvAP2Xg8SBffJYevFpT7rizwe+UCng2vrZRVO/er5yQKKgrZ2HvSVvPZKxKBjRbUinmsXkOic2Dc0rI5k/diYly/ZxNRV5lHz24wt9nEjLPOT49i/6gBp+DaYsBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Swu5cgaNeMkxSQQotLisAhyprNSyb9elRje/k0p4aM=;
 b=Dx3qkwQ3I9pgnmL7xMbCsoHFxjBjBL8MQYJ9NtjDvJ9xZpoDIKtwEt7DAqqhP1wV043SVmk0bFNdQo9N5bMLtZqp6o+6OECLRXp5pJhvqMVowNNst+AqCoN+VQcqq1PXnP4sHLG2BdFhvnqbhFiRxGgreaobgI9S2smMZUMZhnrsQrTkCAyjyOf9OiGW334JzSG7X7dbJOZowJcH797R7Yc0dziiByP1BmGxUHL+zq+2IsjPJPQfsrVPZVqKAZh/7itMW9ECCuuM3AAw7FDRjeQLvrpxIaWtsV4nf3vQI702ay9PGWU3ZS7psnqq2uhT4FVYGXs4+LpMct0h72mp3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Swu5cgaNeMkxSQQotLisAhyprNSyb9elRje/k0p4aM=;
 b=ukXvQhTZYTotBpdzfsBWHnAYDVmqyYZ/wLpE9ScIJL41cnBPdD6IZN2R9IzNu7ttiT7dbIXkOuIgDF2TkBea6Xzn+Kc6til7VPkEDFQJ5cKmIQr5FmVrgDN93Cp1WAa36YNrPTjvfpsBXmRpx2AVZYlztAm4e0KMY4YUzoEzFYIqk1k4t1cmCUXlcFlkrwFV+IOPQg/zndLj8sa5Pf1KHIjsQ7MT7T/Of05bu0XeWv3iJRxM8MjxqPBH7NFzu4myJ2C0JtCbeXNAS6SYKe584owK25gNbjVNL4SQoqwunBdta/KT1n1Hr+eqVHgCbloOR0lKfhgaE04UxDoFJZUkbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by PH8PR12MB6700.namprd12.prod.outlook.com (2603:10b6:510:1cf::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 07:11:07 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 07:11:07 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 22 Jun 2026 16:10:25 +0900
Subject: [PATCH v2 03/13] gpu: nova-core: gsp: move boot code into local
 closure
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-nova-bootcontext-v2-3-0ddeafc06f5d@nvidia.com>
References: <20260622-nova-bootcontext-v2-0-0ddeafc06f5d@nvidia.com>
In-Reply-To: <20260622-nova-bootcontext-v2-0-0ddeafc06f5d@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYWP286CA0029.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::17) To MN2PR12MB3997.namprd12.prod.outlook.com
 (2603:10b6:208:161::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|PH8PR12MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: f4b9e179-1f95-47d0-7946-08ded02d6e2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10070799003|18002099003|22082099003|3023799007|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: nJVUvliqiBL3bGVGRaHq++1/FLBw6ihdH1YKMKFSmQPbBSI2jg/EGY/CE5FGkpeYbK/+5GwwYZd1Kit+YNogN++nziDUgaseu2wQhFdq65Aasnv1Ol6EOjAO+S4HeEgxg2MlDuPlHkHo9alb5um0pQ3ALTVIAPDtXF/1RfIIm7DmIg89xrb4Fu/IkgyeQyjiNyruutFmv2jxiVQ56nkdPDpR0MoPsuHyVk7wKQ4SKRhc9OJ8OS9lYUFIljt4p74ChEAPnatOP04f0+n93rDpnlbNquZXlZGcXCoS3v5AhpxBytj4WMCcLxyMM965vCjuxYvlh5z1h/f5cK4tfYr8HJMZOhylC3O831MEYRLh3Sl6mFe8MUhv7NErDvGo/2AYLklmJJt+T3Be+WOwck3of4gP3Ke5WXH9aY1khC5yiqkehoEk/7snyrERaSSzNMlz5/TUOGX5zKEzKEu2vT132Se62ds7dUSW+N+xqwOZpVSkub3CilScfYlrMR/2EbTUSQbnDt4UiG85x71ihbzwwcMcXQwxVgpKFzHyPrhzOMe22QNFzIXx4XYSsu5LFxiOt5SZ66zQQF+gOU4nLcCq66dbVJW6WEvS0VxeytrIhJPcM5619VS3eC7JCOGVnJDrNTNbBlbZ8z3++5Jg97wWFdRLTHd33DJPmuRHJCKOMgk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10070799003)(18002099003)(22082099003)(3023799007)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzJmRCtWZUhFRnduRXRwVG8yR1JacnJxNFNGSUx0em9vWVBaS3F2VXBUNWw3?=
 =?utf-8?B?TDFtZGpnMHV4VGwzS0ZHSjA2dm52NUhsbjJpaStTdUd6Wk4zK2lGUXRqYU9L?=
 =?utf-8?B?Z0V5dHJOZG1LalVxcUJ0SkVzVktpNGFkZC9SNUlYMFV3SklRTkpScjdvQUxy?=
 =?utf-8?B?ZkJHNVdXVE5TOTgrVllnTlVoMjhWeGxGN1NZSG50aDV5VldFcUVNQlQ1b3pY?=
 =?utf-8?B?YU5makw1Ym5FcVNndHNMVDFuWlUwT0llY0xPNlBHRmx6dFRlb2dpRmRHV3VB?=
 =?utf-8?B?RWVaQmRiMGJXbm8yVzVmTGN6OHBOZDBrUGR5elp5ZU1XRnhFZUg5RGNGL1ly?=
 =?utf-8?B?U0kyYjRZTUlVWGhkajZyS3h4MVEwRVBiMTRIOFdtcWQwZTExTi9rTUtYeVQr?=
 =?utf-8?B?Q1NRa3NQUmNVdlRIRS9NcStieE80NHo2eER6MU9BV2J6OWRtY2ZxNDdxUFoz?=
 =?utf-8?B?bVI1dHM4LytXVm9xS1RhaENsZDQ4ZkNMeXkyWDRpMnBjZ25kemNrbzZzTHpv?=
 =?utf-8?B?L0s2bmxrcjlKRHlHUGsybTdJQ1VUdkw5dVdFQmJ2ZHR1R3NuZUo0ODFyaGtk?=
 =?utf-8?B?aThsenFHS25oUlY0RExDK3kxWVJxenhCUnBMZzhDeEY0WG5DU09LMC9ya0cx?=
 =?utf-8?B?ZGJoSXBrUTM5d0V1TVNtZk5sYlVjSDY4OXY0b05ZaDZUMjl5OGJjNVVxa0RR?=
 =?utf-8?B?MnUyQS9iakluSjQyaC84S29rYXBNcWtxUVVNQytRbjJjY01JWjdsL3pHTmQw?=
 =?utf-8?B?UFlVNllPdkZGYllqdVozUkFFOVhWTnRsNzdIVW13ZGVtTk82Y0dPQ3ZCVlds?=
 =?utf-8?B?cEt5aUtBVTk3R2YwayttRlVVL2tUVWhRL1VWZmZXakRTL1lLQ2ZiRHRLSEhv?=
 =?utf-8?B?d25JR2k3SWxxTGZUM2Y2bUpPRFdtSElkcFlPb2JMWXY0dmEya3lteGliT1RK?=
 =?utf-8?B?RjVicnB3V2xsZ2xQZFpoNzRjbWRJQWhaYjgvY3JqVk8xZ1BnUmxYbmNJVHIr?=
 =?utf-8?B?QWtOR0NMWmpPWEh1Z2VvaDUvQzh4eWw3UFNldTN4UFB5UkI3NnYrQTQvQ1pu?=
 =?utf-8?B?aGtQbWpVbFVaQjJsQVpvREk2eTU4alByZzBVRDNtdXYxMmpudEVrSEl0T3p2?=
 =?utf-8?B?U1ZCQlF5Vit6bTRBbjM0QWRWRnYwMUFVZUZsRzF4ckhpcThHbmYzSEdhQWNn?=
 =?utf-8?B?dlJ3bk5JVWlFbDd1d1JFNkp6ZnMzSWxLVjBZYXR2K3N2T1orNUlSVGdxb09T?=
 =?utf-8?B?Yk42VmprSUtRZ3QyYVN6a1V6eDN4ZU9IWlI0M2ZJTHBpNE5SR1pyL0VDc1dG?=
 =?utf-8?B?SnpIRFAzY2xUK0tWdkR4RE9ieS90V1g3WElSd3JvTWk5dXdlR29td20xMDM3?=
 =?utf-8?B?OXJvUUU0TG5vdHVJdzlielJ1dFhteDlCck15Y2IxUFVWS0tLeStXNHJ1djY5?=
 =?utf-8?B?YzAxUDVVNmsxODg2ajNGTWk2cTZhanBHQ0swVlVES2ozWXhWSGdwdFZSQ1dm?=
 =?utf-8?B?QnZSL3JBNEFyY253VHdUTFZ2MUdRY0dFZ3VIdHlhRE44M0xaTzFHdGI4ZHRk?=
 =?utf-8?B?YmtibU5kUUZTeTNsRTV1UjN2Y1FVakc5Q093MlR5d2puVS81d09ZUnhoblZV?=
 =?utf-8?B?dmF1b0s1TUhGcmU1NXpTT0tyOGhXbk5YTHRkSEhoOW5MNEFCeHhScXN5Q1N2?=
 =?utf-8?B?YkpoRE5iSFo2RTQ4a1RYQTZqY0FLc2t2WkFVV3EzV3hld0JJNUpwdjJQWUtE?=
 =?utf-8?B?Mzh1czRDU0o2eXFlQm55UWFrMENXV2E1WU5kQ0R2eXM1QnFDRjVyRTV0eFFU?=
 =?utf-8?B?aEVTQjVUVStYL0JpUlJaTVF3NWltcmtoemYxQWdHYzEwZktxSkZnSnhUb05Z?=
 =?utf-8?B?SVRiaUF4eU1oOXNHeVFJNjNzVk9IN3Z4dkE3OVQvS0hScm4xc2xQTDRydy9V?=
 =?utf-8?B?akYzeWFiTk50WkIxeDVEd2ZqWUl5MHpCSUp6TWthQVFDR284ai9PUmNzQWky?=
 =?utf-8?B?N3JmK3RzY1lVZ1h1bFNETE5xRHdMMzhaWmhRSlU4UTBWcEErSmpXazYxNnYr?=
 =?utf-8?B?RHhaSk1wUG1sMHo4NWt1TW16Mm9Qem5Xb2ZrSjBDOEZSQzNFTzJxTEpxMVhq?=
 =?utf-8?B?UzNjZDQxNDBJdnQ5RlZudnI5Ymh1OERLWGpQOEdlejMzVzFiaEliUXRxdW9l?=
 =?utf-8?B?UTU3aHZkZFFPVTdUbHp3cWdGL0lOK1JJYXZTb0NTeGRrQzhreWxCSUwwSlpR?=
 =?utf-8?B?N2VPRnVNSE16eVJRNlkzTXVpOWRRcHR4bE9XaFUvVmpWWkk3d00wWWw3VVJm?=
 =?utf-8?B?cEFMRTBJYU1xNFQ0cVN1WkllMDlZakxrY1RsQ1N0T3RucURuc1IrZVhoUjJz?=
 =?utf-8?Q?24if+0sjmZeh9aDburfK8X7iL0L+U6VruI6AKr3prkiK9?=
X-MS-Exchange-AntiSpam-MessageData-1: JX4XGT+gRxN1iQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b9e179-1f95-47d0-7946-08ded02d6e2b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 07:11:07.5055 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RrBhDeWrbzQffAowXMvgSynUEBU5QBhO5qVBfirfkaE2liBGwLr8rh01Ee8g6f51QwHff7/xo5ZwYXQPmjKMTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6700
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

The next patch aims at replacing the cumbersome `BootUnloadGuard` with a
more local and less intrusive mechanism to run the GSP unload sequence
upon GSP boot failure. Doing so requires running the boot code in a
local closure, which changes its indentation and would make other
changes difficult to track in the diff. Thus, this preparatory patch
moves said boot code into a local closure that is run upon construction,
so the next patch does not need to re-indent code that changes.

This is a mechanical preparatory patch to make the next patch easier to
read. No functional change intended.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/boot.rs      | 42 ++++++++-------
 drivers/gpu/nova-core/gsp/hal/gh100.rs | 38 ++++++++------
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 96 ++++++++++++++++++----------------
 3 files changed, 95 insertions(+), 81 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index bb2000b7a78b..9eccfd634b61 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -119,30 +119,36 @@ pub(crate) fn boot(
 
         // Perform the chipset-specific boot sequence, and retrieve the unload bundle.
         let unload_guard = hal.boot(&self, &ctx, &fb_layout, &wpr_meta)?;
+        // Run from a closure so we can retrieve the result, and run the unload sequence of the GSP
+        // in case of error.
+        let res = (|| {
+            gsp_falcon.write_os_version(bar, gsp_fw.bootloader.app_version);
 
-        gsp_falcon.write_os_version(bar, gsp_fw.bootloader.app_version);
+            // Poll for RISC-V to become active before continuing.
+            read_poll_timeout(
+                || Ok(gsp_falcon.is_riscv_active(bar)),
+                |val: &bool| *val,
+                Delta::from_millis(10),
+                Delta::from_secs(5),
+            )?;
 
-        // Poll for RISC-V to become active before continuing.
-        read_poll_timeout(
-            || Ok(gsp_falcon.is_riscv_active(bar)),
-            |val: &bool| *val,
-            Delta::from_millis(10),
-            Delta::from_secs(5),
-        )?;
+            dev_dbg!(pdev, "RISC-V active? {}\n", gsp_falcon.is_riscv_active(bar),);
 
-        dev_dbg!(pdev, "RISC-V active? {}\n", gsp_falcon.is_riscv_active(bar),);
+            self.cmdq
+                .send_command_no_wait(bar, commands::SetSystemInfo::new(pdev, chipset))?;
+            self.cmdq
+                .send_command_no_wait(bar, commands::SetRegistry::new())?;
 
-        self.cmdq
-            .send_command_no_wait(bar, commands::SetSystemInfo::new(pdev, chipset))?;
-        self.cmdq
-            .send_command_no_wait(bar, commands::SetRegistry::new())?;
+            hal.post_boot(&self, &ctx, &gsp_fw)?;
 
-        hal.post_boot(&self, &ctx, &gsp_fw)?;
+            // Wait until GSP is fully initialized.
+            commands::wait_gsp_init_done(&self.cmdq)
+        })();
 
-        // Wait until GSP is fully initialized.
-        commands::wait_gsp_init_done(&self.cmdq)?;
-
-        Ok(unload_guard.dismiss())
+        match res {
+            Err(e) => Err(e),
+            Ok(()) => Ok(unload_guard.dismiss()),
+        }
     }
 
     /// Shut down the GSP and wait until it is offline.
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index 2187e11168b2..776f61b8b9d7 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -158,29 +158,33 @@ fn boot<'a>(
         let gsp_falcon = ctx.gsp_falcon;
         let sec2_falcon = ctx.sec2_falcon;
 
-        let unload_bundle = crate::gsp::UnloadBundle(
-            KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn UnloadBundle>
-        );
+        let res = (|| {
+            let unload_bundle = crate::gsp::UnloadBundle(
+                KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn UnloadBundle>
+            );
 
-        // Wrap the unload bundle into a drop guard so it is automatically run upon failure.
-        let unload_guard =
-            BootUnloadGuard::new(gsp, dev, bar, gsp_falcon, sec2_falcon, Some(unload_bundle));
+            // Wrap the unload bundle into a drop guard so it is automatically run upon failure.
+            let unload_guard =
+                BootUnloadGuard::new(gsp, dev, bar, gsp_falcon, sec2_falcon, Some(unload_bundle));
 
-        let mut fsp = Fsp::wait_secure_boot(dev, bar, chipset)?;
+            let mut fsp = Fsp::wait_secure_boot(dev, bar, chipset)?;
 
-        let args = FmcBootArgs::new(
-            dev,
-            chipset,
-            wpr_meta.dma_handle(),
-            gsp.libos.dma_handle(),
-            false,
-        )?;
+            let args = FmcBootArgs::new(
+                dev,
+                chipset,
+                wpr_meta.dma_handle(),
+                gsp.libos.dma_handle(),
+                false,
+            )?;
 
-        fsp.boot_fmc(dev, bar, fb_layout, &args)?;
+            fsp.boot_fmc(dev, bar, fb_layout, &args)?;
 
-        wait_for_gsp_lockdown_release(dev, bar, gsp_falcon, args.boot_params_dma_handle())?;
+            wait_for_gsp_lockdown_release(dev, bar, gsp_falcon, args.boot_params_dma_handle())?;
 
-        Ok(unload_guard)
+            Ok(unload_guard)
+        })();
+
+        res
     }
 }
 
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index 6ed4ee268086..9b24361f924b 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -277,59 +277,63 @@ fn boot<'a>(
         let gsp_falcon = ctx.gsp_falcon;
         let sec2_falcon = ctx.sec2_falcon;
 
-        let bios = Vbios::new(dev, bar)?;
+        let res = (|| {
+            let bios = Vbios::new(dev, bar)?;
 
-        // Try and prepare the unload bundle.
-        //
-        // If the unload bundle creation fails, the GPU will need to be reset before the driver can
-        // be probed again.
-        let unload_bundle =
-            Sec2UnloadBundle::build(dev, bar, chipset, &bios, gsp_falcon, sec2_falcon)
-                .inspect_err(|e| {
-                    dev_warn!(dev, "Failed to prepare unload firmware: {:?}\n", e);
-                    dev_warn!(dev, "The GSP won't be able to unload properly on unbind.\n");
-                    dev_warn!(
-                        dev,
-                        "The GPU will need to be reset before the driver can bind again.\n"
-                    );
-                })
-                .ok()
-                .map(crate::gsp::UnloadBundle);
+            // Try and prepare the unload bundle.
+            //
+            // If the unload bundle creation fails, the GPU will need to be reset before the driver
+            // can be probed again.
+            let unload_bundle =
+                Sec2UnloadBundle::build(dev, bar, chipset, &bios, gsp_falcon, sec2_falcon)
+                    .inspect_err(|e| {
+                        dev_warn!(dev, "Failed to prepare unload firmware: {:?}\n", e);
+                        dev_warn!(dev, "The GSP won't be able to unload properly on unbind.\n");
+                        dev_warn!(
+                            dev,
+                            "The GPU will need to be reset before the driver can bind again.\n"
+                        );
+                    })
+                    .ok()
+                    .map(crate::gsp::UnloadBundle);
 
-        // Wrap the unload bundle into a drop guard so it is automatically run upon failure.
-        let unload_guard =
-            BootUnloadGuard::new(gsp, dev, bar, gsp_falcon, sec2_falcon, unload_bundle);
+            // Wrap the unload bundle into a drop guard so it is automatically run upon failure.
+            let unload_guard =
+                BootUnloadGuard::new(gsp, dev, bar, gsp_falcon, sec2_falcon, unload_bundle);
 
-        // FWSEC-FRTS is not executed on chips where the FRTS region size is 0 (e.g. GA100).
-        if !fb_layout.frts.is_empty() {
-            run_fwsec_frts(dev, chipset, gsp_falcon, bar, &bios, fb_layout)?;
-        }
+            // FWSEC-FRTS is not executed on chips where the FRTS region size is 0 (e.g. GA100).
+            if !fb_layout.frts.is_empty() {
+                run_fwsec_frts(dev, chipset, gsp_falcon, bar, &bios, fb_layout)?;
+            }
 
-        gsp_falcon.reset(bar)?;
-        let libos_handle = gsp.libos.dma_handle();
-        let (mbox0, mbox1) = gsp_falcon.boot(
-            bar,
-            Some(libos_handle as u32),
-            Some((libos_handle >> 32) as u32),
-        )?;
-        dev_dbg!(dev, "GSP MBOX0: {:#x}, MBOX1: {:#x}\n", mbox0, mbox1);
+            gsp_falcon.reset(bar)?;
+            let libos_handle = gsp.libos.dma_handle();
+            let (mbox0, mbox1) = gsp_falcon.boot(
+                bar,
+                Some(libos_handle as u32),
+                Some((libos_handle >> 32) as u32),
+            )?;
+            dev_dbg!(dev, "GSP MBOX0: {:#x}, MBOX1: {:#x}\n", mbox0, mbox1);
 
-        dev_dbg!(
-            dev,
-            "Using SEC2 to load and run the booter_load firmware...\n"
-        );
+            dev_dbg!(
+                dev,
+                "Using SEC2 to load and run the booter_load firmware...\n"
+            );
 
-        BooterFirmware::new(
-            dev,
-            BooterKind::Loader,
-            chipset,
-            FIRMWARE_VERSION,
-            sec2_falcon,
-            bar,
-        )?
-        .run(dev, bar, sec2_falcon, wpr_meta)?;
+            BooterFirmware::new(
+                dev,
+                BooterKind::Loader,
+                chipset,
+                FIRMWARE_VERSION,
+                sec2_falcon,
+                bar,
+            )?
+            .run(dev, bar, sec2_falcon, wpr_meta)?;
 
-        Ok(unload_guard)
+            Ok(unload_guard)
+        })();
+
+        res
     }
 
     fn post_boot(&self, gsp: &Gsp, ctx: &GspBootContext<'_>, gsp_fw: &GspFirmware) -> Result {

-- 
2.54.0

