Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB35ACDB471
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 07:12:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40F2210E4EA;
	Mon, 22 Jun 2026 07:12:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="OhEJVT2q";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010063.outbound.protection.outlook.com [52.101.61.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45FE910E4EA
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 07:12:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I3zLJ6C8sYAxruaYyQsmyYdt30olZxxaY1DvrWumVT5WuK5FI6+6C92lqM+dw6kcXe12SONLUACm0u30gGa6mI9Q4LVlTtVqmcsnaAuIFcfMHhPsiws4ZASTDhBI4ljJZ1kzSxLxkwqfyyNwIYD97+Ua0Oe0mL+ZZaDCdfILvqzMDCJo8E8+s50Vdyjjao6fxtZ6iydiqigP7h09b3earfaWVq9654QLh/vOgCYtVDvk6PaJxaY3nUeRZV7tcxriCfFgXGE+Qaz0VPjfWnUVMnpduv6FVJvSbWXOtdcXNE6Xs8Fo4o6thxRoHLNVC2U7A5BhxqeMGVp4p2phBhIduw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+gn92PVOepb0vWeDuYv42nDp+50Swid5gf0xSTDA3I=;
 b=r1D2n3EBgF9EA7KqGgvelpwbFgCvz7KDYEHVxZ1SENz3TUI7qrbljkJOjgHa2KtzLATIYf2a38vDdl4XY4NM8Iyw2c5arBggLGjLSjH30YI3fqnKG6AVtAZ3WeJv6h07ltEjrTioUKjTYgLZw5qGp3/Won9a94H6mdfNldKHWtpyTjKIEFpf46AHcMb2jWHhBsd8dS22cFj5db1SgQrLxRlNXgKshw+gduf0xM20qbqbgUt3rICBKq3ZJTWItG8ibVcyPXsIXF9l88XO0q3vxs7sjRUl6+DgyOfF5XIOku9CXn89aGFpijrX2MQWYq/3RhpJQ50cB2CGmXthmQgG7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+gn92PVOepb0vWeDuYv42nDp+50Swid5gf0xSTDA3I=;
 b=OhEJVT2q+a7bGISJCw1pO0QREn0gkq9JGCQjBNs493WDvg3CZ16Tlc7lDNY5u4DWsR35/OWOoDhE6Ws8kfgN+d/G94fAFSMa+K3bgM/sGNeBve7HTvYyF0WWQ139zMGgQlG9U5MjEpXqmmjNtZBiKI7InWNH25EF/GjXGeiEnxmhqf7nCPIv0CsoAYKyJpWQHytGrbgw3pTP2YgR00EhmxfNCARJZbVfdIy/fsUsUnTCGKfM8gkFrTFTE/HL3mD/PPU3Gr13iYF7E0LbOPGzrRYd67xdlWMndymFIB4XXHnAlNIbU8e/R8bL+toddzKEFEhf2RVOK6j87Yh26vsAdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by PH8PR12MB6700.namprd12.prod.outlook.com (2603:10b6:510:1cf::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 07:12:19 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 07:12:19 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 22 Jun 2026 16:10:34 +0900
Subject: [PATCH v2 12/13] gpu: nova-core: gsp: pass GspBootContext mutably
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-nova-bootcontext-v2-12-0ddeafc06f5d@nvidia.com>
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
X-ClientProxiedBy: TY6PR01CA0006.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::10) To MN2PR12MB3997.namprd12.prod.outlook.com
 (2603:10b6:208:161::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|PH8PR12MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: 85a782b7-ccb1-479d-9438-08ded02d98d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10070799003|18002099003|22082099003|3023799007|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: sPZBKFW2+NfmuQHOfYZmGH6Ug9hRsaARV2e7xIAH/aMDlKvbfxY9/MaK/U2Nt3m1QTsYPsjdTVZD813xjFBja4mSeQ+ndKSEkpCzGGHhLm/vf1AuzOrlT996obHbOsQC19zTOmEDJD6rhdhZcJHRN1ox9o4mY9JArzYJ7hsuRjruAPfBaOZG+HSSutIwn4IcctCQPC+1LImRaes5bEjvL0cfinHl6gPUI2G1fIpknblfLj9njHDMAl6Rr6SyHbxLLCnZEfAsLNJW3Gba3xXeEaYknJXhxR9nEoXMql7lN5nRTK5tK8xdWe+xpZYZjZpTE3z1Efm3eJLBScICdhLSnaKSQ71RVCiDp34TgS88MFunumkLNaGzNN26Dc0TNLAQuQds2YPSv4pMeNQPIwGT0V5hzLUAEPrgaslr3RQMNJty8JDG85Fv0vx21CqkcY2xDaMzVgbYqlipnTGmFY2fyb16YSSpDojCefPTc2ILDT/jRpyMR6qM5wyPFkW46jvz5nS5JU1d42LZLvc95FxcekgcrK5okrN6jX4wDYI4NnvejWSZVzzUVKSb4VZHKu1u2WxorF04bsyfMudIV4xwNXX9SsmbWjBlBHYiDRjElpsCaJTHQ0HM8gSCPb2k5XWKQpvBxpT/yQTJ7i/K7rK8TcHEsqmc/JflDXH7UfC1hV0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10070799003)(18002099003)(22082099003)(3023799007)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3NyUzcyWVRURHlPRzQyWDMxeStoaXlkZXQxSFdIYTlEZVFZZkJnU2t6UUtt?=
 =?utf-8?B?Zm9qa1FEeC9WQ0hvOTk4dVM2OFVGR1JlSHg1OGErbjFYR2dOZGpGYnVSSExO?=
 =?utf-8?B?K3FIUmRwajZTMG5na1RkeS9WaUZQMWwyQkhZRVA2MzBsQXpsYkZwcE5jakxN?=
 =?utf-8?B?RDZpeHpHZzFoOGluSnNIZktkS1kwQUxXQlRKVTZKL2xibEFBK2ErK0hsWW5O?=
 =?utf-8?B?OXdaN1YvcmtqZUViRnU4R0hpOUc4SEdQMWtJbUFXbDVMR1NIVTcvRmg1WkY4?=
 =?utf-8?B?WUpTOEJBYXliZWQwdW5kQlR3WmcyNDNLL2srUVIrcDJRanpJWFdBQS9wc2JP?=
 =?utf-8?B?WWtmc0ppV1BzUWpQME5Ja3hnV2lZa0hzK1EvTFZyUFhWVVdzb0hsQkVZNWxM?=
 =?utf-8?B?SXhBVHdFZDFEdnUrNkpNRG5ySFR1Tlg0WEN1amZ6c1htb0lRMkV4dDVvWE92?=
 =?utf-8?B?TkZNVnVzbTQ1NWVJblBNeHprM09KenVEaGRVRFBNUWNxVnQzMU8wQ3QwRmpj?=
 =?utf-8?B?cm9GNWpkV2h1ZVhRZ3h2T0pMR0tZeGdidkIzdmkzTG9QZXhmcXppZHFsczNj?=
 =?utf-8?B?cWo2aXBnS1l0K1pLT1kzdElCdmVrZklQdmFOV21FUkw1bWxBTWxIanFSc09H?=
 =?utf-8?B?OWlEVVdUTm1lTjVQOEdJYklxSlVtcmlTRHhxT1prOVUwUTd4Q3pvNnRVeENx?=
 =?utf-8?B?ZFVzTlN1WmRKMVpZY01xQjJpVFJaMTUzNlVIclFySEt0Sko2aWVsZk1ZVU1X?=
 =?utf-8?B?Q0lKbzZVTTkwbzMvRkN3cVorcFZYMEc3bkF3UXhEcVNIem9sVllTWmFmbEZn?=
 =?utf-8?B?bzJpampOQituQ1VOWDMzNHZKWHNheXFtNHB6RlRTcWRhU0ZGL2FYOXpnRDN5?=
 =?utf-8?B?TXllb1BZa2NzZE5sVytGZ2N6UEgwdXZUbmtoY1FvdFNlc2h4NVBrREl3M3pm?=
 =?utf-8?B?TUJ4dFRsMXZyajBOTlhIQTMzSlcwUmh6cnk1aGJiaDRRc0t6QUVUWUdWMlZ4?=
 =?utf-8?B?UGJTa3JXNE9EZGZwNjFUUlA5bUE3WGVMY0x4WDVvSEMxUGJMemhMUlJPUDhz?=
 =?utf-8?B?OEhjVWFDVnpNekdoWkRCcTBUa0NUbDd5dkdkY29QcWhMVk5JQlB5ZnlmcmZt?=
 =?utf-8?B?b0RoTVJ1NURpdzZES25zTHZ5N0RhRjJtU0dMVnJITnlQWktEVzExdk44Unha?=
 =?utf-8?B?Y0VSTnVrT0MrRlRnWUxTNWk0NlFXV3JtYTd5UHFRRWhTRXBZQkNqc201aXF0?=
 =?utf-8?B?T2tZZGkvbTFKeEFHYzhoQUJsSUZwNkFCVXlkN1ZMaFkycnNZWDhlUkJmd0tG?=
 =?utf-8?B?WTFKVzJzQ0tWQ04zbVFZc2RqMFNieUJFWkhBNjhOWWNkdGdhUmVTTTlBeDlQ?=
 =?utf-8?B?b0lqdTJZSHhtbUg2YmRWdk9CUzIwVDU5NlVtWk9odHFCSVoraG82ZkVDYjB6?=
 =?utf-8?B?OS9xZ25vODQ2S09WcnZZMUxDT2tpY0RSQ0hHK2svYmgrM1JMVVZSNTVSaVdS?=
 =?utf-8?B?aDBEMVFwUVJmaSttdDNsTlNQakpJcHBqWnVoQ3JCOEZmZUJGS0dZVFI4ZVdM?=
 =?utf-8?B?cHRiUkdrWDlvSVgrMGwyayt0SEppRGZDaXA4YzBQdFNXUFlmZGNzT0d5Y3Rx?=
 =?utf-8?B?bTdjRHZBcHRqclJLTkNaODNxR2c2NSs4RS9jVDYweVVIQVkvTHdxQm84c0hr?=
 =?utf-8?B?U2NZK0JkNjM3eGFqUjFhTDhCZGxkdGdvM1hIVUd2MnB1WjV0NDg1MDhJZTc3?=
 =?utf-8?B?Mk9KWU5xRnlVV0lGYVpaMjYrSGhEb3V2SGk2VzdGRStpVkJCU0QyekFPLzVC?=
 =?utf-8?B?bUU2Tkh0eTFEeTZUQldDbTFmeDd4WXNrNE5mdGFDTlhQdk1pUGVSYVFxZUFD?=
 =?utf-8?B?T2xxbnduejJucEJ3SmMvS1dmTVA4aTdKQU8rQ2dUeUVvRGFFVy9ucnVrODM5?=
 =?utf-8?B?dEZ6Tjl4ZnFpQW1mck9MRmplaWpiNU5ua0UrSEVoUElnNkxzVlV0bHNOd1RQ?=
 =?utf-8?B?KzhNVTMzVFJDVmVwbElLb0ptMFhrbUNiQnNEZUc0TVF1T0xMU2llOUt6OWsv?=
 =?utf-8?B?RXNmM3V6c1N3QjBXNjBVQVM3WjRGZHpDSE50ZjVpV0Z0RDdNdE1OOUtRcHJJ?=
 =?utf-8?B?ZTAwOTZDTG05T0xCbmVOQzkxNDFBUElPbUdEQStibW1IOU1UUkRydjRSZUVB?=
 =?utf-8?B?ejRieUxMdkdZNnhLQjRRMzBobk1kWVdteTZaZUN4S0MyT3F0MkdTMEE3ckFC?=
 =?utf-8?B?bEI3dEk0aHpvdEd2R2lZOXhrekl6bWNEZVlQbFpqOUdSRHpLeGhtbTN4UU5I?=
 =?utf-8?B?VkhobXVTQ2VJOXJSS2ZzYXVpVVRneVNvTTdSQmd2b0FSVmpjUFpSbytxbDNm?=
 =?utf-8?Q?oY1wyfpLJ8VqH3wJGVRwKYNw8lSO5duLgFF4AAFwzVJuB?=
X-MS-Exchange-AntiSpam-MessageData-1: xN+icvHeb6UlXw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a782b7-ccb1-479d-9438-08ded02d98d6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 07:12:19.0403 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DQMitY6oC37hFyQV2GQXB6wyt+OfVaKKkPOhsO0/33QxiAqqnrvLP0Yl7u8pLY/e17bF6SgFPIAoOe/D83+gMg==
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

We want to move the `Fsp` instance into `Gpu`, which will require
passing it as part of the `GspBootContext` as `Fsp::boot_fmc` is a
mutable method.

Additionally, we will also want to make some methods of the `Falcon`s
mutable, which will also require passing them as mutable references.

To prepare for this, make the passed `GspBootContext` mutable, and pass
mutable references to it to the GSP boot HAL methods.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/boot.rs      | 6 +++---
 drivers/gpu/nova-core/gsp/hal.rs       | 9 +++++++--
 drivers/gpu/nova-core/gsp/hal/gh100.rs | 2 +-
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 4 ++--
 4 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 336ad23c96f9..1e0d4793e96d 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -38,7 +38,7 @@ impl super::Gsp {
     /// [`Self::unload`]) returned.
     pub(crate) fn boot(
         self: Pin<&mut Self>,
-        ctx: super::GspBootContext<'_>,
+        mut ctx: super::GspBootContext<'_>,
     ) -> Result<Option<super::UnloadBundle>> {
         let pdev = ctx.pdev;
         let bar = ctx.bar;
@@ -55,7 +55,7 @@ pub(crate) fn boot(
         let wpr_meta = Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::new(&gsp_fw, &fb_layout))?;
 
         // Perform the chipset-specific boot sequence, and retrieve the unload bundle.
-        let (res, unload_bundle) = hal.boot(&self, &ctx, &fb_layout, &wpr_meta);
+        let (res, unload_bundle) = hal.boot(&self, &mut ctx, &fb_layout, &wpr_meta);
 
         // Display error for unload bundle if any, and convert to `Option`.
         let unload_bundle = unload_bundle
@@ -89,7 +89,7 @@ pub(crate) fn boot(
             self.cmdq
                 .send_command_no_wait(bar, commands::SetRegistry::new())?;
 
-            hal.post_boot(&self, &ctx, &gsp_fw)?;
+            hal.post_boot(&self, &mut ctx, &gsp_fw)?;
 
             // Wait until GSP is fully initialized.
             commands::wait_gsp_init_done(&self.cmdq)
diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/gsp/hal.rs
index 9abdafbdbb57..15c6d86c0d51 100644
--- a/drivers/gpu/nova-core/gsp/hal.rs
+++ b/drivers/gpu/nova-core/gsp/hal.rs
@@ -48,7 +48,7 @@ pub(super) trait GspHal: Send {
     fn boot(
         &self,
         gsp: &Gsp,
-        ctx: &GspBootContext<'_>,
+        ctx: &mut GspBootContext<'_>,
         fb_layout: &FbLayout,
         wpr_meta: &Coherent<GspFwWprMeta>,
     ) -> (Result, Result<crate::gsp::UnloadBundle>);
@@ -57,7 +57,12 @@ fn boot(
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
index a87d526d2310..7bba18ba2f75 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -140,7 +140,7 @@ impl GspHal for Gh100 {
     fn boot(
         &self,
         gsp: &Gsp,
-        ctx: &GspBootContext<'_>,
+        ctx: &mut GspBootContext<'_>,
         fb_layout: &FbLayout,
         wpr_meta: &Coherent<GspFwWprMeta>,
     ) -> (Result, Result<crate::gsp::UnloadBundle>) {
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index 8e732f540af2..90c734c2f63e 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -263,7 +263,7 @@ impl GspHal for Tu102 {
     fn boot(
         &self,
         gsp: &Gsp,
-        ctx: &GspBootContext<'_>,
+        ctx: &mut GspBootContext<'_>,
         fb_layout: &FbLayout,
         wpr_meta: &Coherent<GspFwWprMeta>,
     ) -> (Result, Result<crate::gsp::UnloadBundle>) {
@@ -318,7 +318,7 @@ fn boot(
         (res, unload_bundle)
     }
 
-    fn post_boot(&self, gsp: &Gsp, ctx: &GspBootContext<'_>, gsp_fw: &GspFirmware) -> Result {
+    fn post_boot(&self, gsp: &Gsp, ctx: &mut GspBootContext<'_>, gsp_fw: &GspFirmware) -> Result {
         GspSequencer::run(
             &gsp.cmdq,
             ctx,

-- 
2.54.0

