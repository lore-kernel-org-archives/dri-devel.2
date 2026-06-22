Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8E7CDB471
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 07:11:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E731410E4E2;
	Mon, 22 Jun 2026 07:11:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lz8fKphI";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012044.outbound.protection.outlook.com [52.101.48.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 677D010E4E2
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 07:11:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPfxRPU7oV+95JUbu+2X6wwGugl5AB5hzUfKvnWRfEXR1y4XH3eVUD2F/X7pHzLnobsdi5x+2ZErMZ0CFYBRkHdH/MvJrCqnT7PiQrk2oJ8y9Gfehe4PJnp7AMTzXvyCVgy/KBebQeoPDQjv8CxjHz2nXB8EEISTWZT+OxB/kwf25takhZZuwlvMEH6nv6ZSDqJDD9h89XYR5772sqtM4jCGN1LW6wwFFd0Ysg1bS/tmLpswfhLMd28eON4iEYjeUj9c7PWtfzudHuecUA5n1fjbJsPZ2RvHrtKVDHhSWfFQcHUbu/y61kZ5o7+qzZUNcxjhBEY+YUPxkfmLK25xnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgzUTHUKnYZnBxD/BDRIjeWsLjA8y7DbxklLGREpqWs=;
 b=jLACruuB9cnJEsKndRpzLMdbTt2fMuBRytCamg8lp8yRpCo3VL2tn9wG0+0H/Y3kITuRvtSJFLL062SUjSUtn6xexTznEg38aKaUdQI+3461QvU0lukvl6oNfRMFipufTxvDpF6zJqy9bHo/302xEgnHqueZ8xRMdgZe1QA3+7bJ1gNir7fk8rMrFtSfWrg9IqgVXjgeSDMDZcToDCTtzRN0vePFVePljZbvWpsMcPKOAerNqF7aaaoKnW90lDOZ6HMyR+a6Dr1xNWlo3rbFL44Lchf9mQhUzS410DOcGg+niZ+aPg4TCCfqm9j06FLZhzfcoJOSNJ1Rj+8dj/mSeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgzUTHUKnYZnBxD/BDRIjeWsLjA8y7DbxklLGREpqWs=;
 b=Lz8fKphIjCsOOgSZEMGpgrTQ8PLs19S5ytvk+CVV/E2GLsCb/h5tW0QDTZwVgswQgbR9/TbZhdg1aq6FmQYtmQkRAOjhTsVrj0cKW7R/7uoq10WWOioTFbnYGtHevcIr3rKrqqmYSes7tbYt+gusXDTuytjECK6sUezty878rjGA2JcziAJGtzxWmcgHahMDajWiwJN3lM53DDs+EiSYWftJspCAJg4hdJ3M/4eg7YKzn4l1CBmBLS/Ylzdxxu5HCrqFilRRY/fotreD9V1PJ/kvHylfG5+W+Dv/iRpsMLz4gVq+WkymCGx4vS4LExF3QNbD6IZkNp+q5zEMao3aVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by PH8PR12MB6700.namprd12.prod.outlook.com (2603:10b6:510:1cf::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 07:11:36 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 07:11:36 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 22 Jun 2026 16:10:28 +0900
Subject: [PATCH v2 06/13] gpu: nova-core: gsp: make unload take GspBootContext
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-nova-bootcontext-v2-6-0ddeafc06f5d@nvidia.com>
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
X-ClientProxiedBy: TY6P286CA0033.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b7::17) To BY5PR12MB3986.namprd12.prod.outlook.com
 (2603:10b6:a03:195::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|PH8PR12MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: 297c57a7-a6dc-4caa-7ae9-08ded02d7ed0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10070799003|18002099003|22082099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: U6OSAgrOvl8FNRsAGE/ev5BImAYspXmgRBaH+FPJn0AAfLy4f+jTlfivmJsYcRpWtGQg8GiRmsZmBoRcsJQE5Je5jmLIaEAgkLPzKWotukreGbbogQNYZeGVp2TFB7rf+5UC9sTOoSebKdB41qc963Vh9kbPFTsVNcXBqXZYYSRCj802jg7WKaap7WIzY4v8JYBehaFPXLaBeBT8WX/7UDfNo0bE8prKr+tU/3EqTUf1tTSY0NWUSTG1ZDLTCJ5VjhdUVjDX+lgJcRRWW3qyaqPVbLxJlaJHOx5PPNw1ZU/i8OxWRL4V74JILhne/+myX5glLyq96q+rrdqWbUIyY+Xmwlr7MvlmP7f/IJbmSfHYmc7Vv3d0ivUyVhUHTJgt9g271N1dz0CnM+NFpPbUNH6CTSInbWnc+lRpTI8UJKqAqNXvUhl+xFyvvFnyAao/jW7hFSeLPzMNZo+tQILbIShSM+b8EjbboJ/WAd5KsToLbcGGmlHffVpxw7+zcZGmuPAQ3dy8nk9opQCMsRGjv2ZOLBCIJ/9EpIlOQa+E13EDBWdo9ZvhdDs97wj7wbz4OWQ4hZSLi52pwNH72JxfTe8iOPEA7/US5c6VNrkMhDuFeB+yMfmwAay0uHqP2k6BbX9FMaszM74rWFKYxzJlE+jPW/R3zZEU7DPOcOvwyVA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10070799003)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WW5uMTE3anJGMHZ5OEM5TmNKL0MwQ2lnbnAvSHlsc0p0cHFTVU53K3FJazNG?=
 =?utf-8?B?d1JUajFpdTBiWmRXZE9BRk1xcGptMlN1eVlEK0tDWFRRVmdIWDFGV3VlV3Zh?=
 =?utf-8?B?T0NnZHBNSmgzTlZjZjJEUS9YWWZDZWU2cnJSSHlWZnVxYVdPYmFLbG5MWDM5?=
 =?utf-8?B?ZnpXZFZXcTNPRDVzWkR1TGZ4VWpGdUh4TVhoTmg1c3d3bXVVWkw1OUNiTlVx?=
 =?utf-8?B?TFVVaXFpNWhrcUdDb3MzUys5WEM1cG5rSVdkTXJkK0szeDZkc0pOeHdQSUZT?=
 =?utf-8?B?UHZWMzVWUEF3MGsxbmh3TW9ocnNOcDFpdmZ1ZWdxWjNPVTUySStCM0lnS0NK?=
 =?utf-8?B?TTdPSU0wZ09paTdoeGFVdUNHd1lJQUkrY05KTGdFV29kWFhSOFNGVjBCMkxX?=
 =?utf-8?B?Qk5YN0JBa2VYTnRxaHpkN2ZBV0w4RCsxTmxuNzhKQzZWSUlmcU04UncxM0lR?=
 =?utf-8?B?TlhOWGl3eGUvY0lic2pxZTVtbytReDNDMkRGbjJQWFFsS28zVnlWaCtIVkhR?=
 =?utf-8?B?MXpHWWZmbHc4SUdxdEc2M2lSUHIrZ1JxQUlxaVNLT3JCRFp3VFRacng2RkxE?=
 =?utf-8?B?V3dwbUdRUWUrZXJ6enpIY3FGcEdyQXN6bFdOQkMzTVN5WHVTQU53Z1U2bWkr?=
 =?utf-8?B?K1dYeXZ6VkFIUzNmeUYzaHp1MG9DcjdtK2xRYUFiSS9UQjN1VWZjK3RsR3Zm?=
 =?utf-8?B?aG5YSG04SWQ4WE9mYlNMNmJxbDlJRHlWTUVYUUpRMGVNbjBkZXFJYy96Rkkz?=
 =?utf-8?B?N1NxbzZYK1BsQUg1VTk5Sm1wQ3lGeGsvY1lPWEhCUjczRVl3VmpkQ0pmTUNK?=
 =?utf-8?B?bFdVdURralE3L2FtT2dsWkVVQW1VZVhOejF4RWx3NDRpRHpSb05NS1ErTTdZ?=
 =?utf-8?B?YlF5NDBXd2ZQN0FwcU54emtPbE1SM3VjTkw1cWltSjRzNnpjcHBkcFZucGx6?=
 =?utf-8?B?YW9BOXNJSUNndHZQTkJwK01MdnczNjhtNHVkRFpvdjhNeXBLcTZKZVF6ajJX?=
 =?utf-8?B?QThzVEcxNlNlSG12dEl4cVc3QVo3Y3JRMkZ0R1pNNDBqTUt2K1lEMUhJTjZF?=
 =?utf-8?B?aXhBcUliVFlBQzVJOE5xUmI1YnQrYnhmNkNRckFncnIxdUpDV2xXQXhqQ3NE?=
 =?utf-8?B?bWRqWDR0MXRSMGNncmFtZzQrVGY4UW11K3FGUGhsM0ZMN2ZrYTFFM3Q4UFBz?=
 =?utf-8?B?NTkwUi8xazNFSTNhdnFGM1daelJBRUtYVkpJbXZZb05sMVNYUXNPV3pCR0cw?=
 =?utf-8?B?dmQwU2ZHRjllaE1DS2F0d3hzeHJGNFVvdi9meWxjVWlTUTY1Zm8xRWRJeVFG?=
 =?utf-8?B?UFhBMnhGK1MzMUNKSTNBUEV3NldGNld1RjdCbTdxMUpEZGRxYXBTajU5OTBt?=
 =?utf-8?B?cVlsaVJacG5NR3dIQ2xJUTB4U0xuNU1yMk1XaGhxT2FvRS9FQ2hYbGZXVWZQ?=
 =?utf-8?B?M0NsUkFpWHJVc1I5Q0VOZ1MrbFlzbW0wakdrL3JGWGpwUWFrWEJuNEl3OTZ0?=
 =?utf-8?B?ZnZRd1o5am81OTlmTnRMSWdFTGMrQ1lmMkx2eVIzMDZOUDdxNUpWRnJVcGtN?=
 =?utf-8?B?RjFUbWdrTmlpaERteVhzQlNPOFpJNFJjekNUMTJiRzZNT2tQMlJGcWxxcEha?=
 =?utf-8?B?RnoraFViT3R5M1ZOSUtkY0pYRjYwOWhrT0hORUV2WlFvSGRyaFNIcnlBUGFy?=
 =?utf-8?B?NHF5VUhkUVVWcjBWVE80UWZ1UGFMLytiK2d4WWEzWEdYTzFXNnI5WjJMZEVN?=
 =?utf-8?B?SmtUb0ZxMjk5RVY2WUlyWmVYaFA4clN1SlBTWHJzT2lvNWZJRnBPbldybzBX?=
 =?utf-8?B?VGlGT0NIRlhNdlFMR1dGTFhWK0lTMms2d21JOU1PMUtaM0RUQWJiSVM4THFD?=
 =?utf-8?B?WjVRR3p0dU9iYnpnTlZ5Y1RsdWtSdG1ZRndHN0xjOEN4Ny9sS2dDRzU5alBP?=
 =?utf-8?B?Y3M1c3B3dk56NitGK1pqK2NYbExLVHZQSUR1WXRFbEszVXAwSlY1YW0wd2V0?=
 =?utf-8?B?MG1rOHRHWmUyZ0dLSUtiUWZ2ajRCMis4NHJNK3NJSnNhaHNwUG50WjBtUm83?=
 =?utf-8?B?bjZKa2tiRE5henVIbi9tN3J3Zi9KakIraFlwdURWeTA2ZWNRbWxuc0pVRitS?=
 =?utf-8?B?b2hNYkV6N3Y1N0p4c0dZV2Yrbnc3ZlF4bkdaTnB5MWZkRUJCRUFVRXlpa0Jn?=
 =?utf-8?B?MU9LV3ptZkJFZzQ5UWxyaUFXTEhyalg2blY1WEdBeUJBUktzeGtNSlRTYUJP?=
 =?utf-8?B?bG9YYklWb05IUkVBVU1tREJmNHhkZ1hjUEI3c1kyWUdDOG9JNGNkWEtVT21T?=
 =?utf-8?B?Y1E3ZllFa0JoY0MvL25OVWFNbW5MQjFFdUNIRStpUHpFRm5xdnRSTEkrV2hN?=
 =?utf-8?Q?XiJZso6KCKL9jL52bvd/ohaoLgUKP99uMJ6+WySd/Yl/Y?=
X-MS-Exchange-AntiSpam-MessageData-1: OKATS7t2eyjLAA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 297c57a7-a6dc-4caa-7ae9-08ded02d7ed0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3986.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 07:11:36.4148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wr22JTgArz11EBGrSxvXNix4rLV9QW7EsRtMOLy7mEx7e6VKkGkTMJmOlKqF2/y4LY02l0osUVqRhD4Ggqv7rA==
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

`GspBootContext` contains the resources required to boot the GSP. As it
turns out, this is also the context required for unloading it.

Reflect that fact by replacing the arguments of `Gsp::unload` with the
`GspBootContext`. This symmetry between `Gsp::boot` and `Gsp::unload`
will also be convenient when we want to make these methods generic
over the boot context corresponding to the boot method used.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs           | 19 ++++++++++++++++---
 drivers/gpu/nova-core/gsp/boot.rs      | 17 +++++++----------
 drivers/gpu/nova-core/gsp/hal.rs       | 15 +--------------
 drivers/gpu/nova-core/gsp/hal/gh100.rs | 13 +++----------
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 20 +++++++++-----------
 5 files changed, 36 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index a34114d3afcb..7918ebb508f9 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -268,7 +268,9 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
 #[pin_data(PinnedDrop)]
 struct GspResources<'gpu> {
     /// Device owning the GPU.
-    device: &'gpu device::Device<device::Bound>,
+    device: &'gpu pci::Device<device::Bound>,
+    /// Details about the chipset.
+    spec: Spec,
     /// MMIO mapping of PCI BAR 0.
     bar: Bar0<'gpu>,
     /// GSP falcon instance, used for GSP boot up and cleanup.
@@ -311,7 +313,16 @@ fn drop(self: Pin<&mut Self>) {
             .gsp
             .as_ref()
             .get_ref()
-            .unload(device, bar, &*this.gsp_falcon, &*this.sec2_falcon, bundle)
+            .unload(
+                GspBootContext {
+                    pdev: device,
+                    bar,
+                    chipset: this.spec.chipset,
+                    gsp_falcon: &*this.gsp_falcon,
+                    sec2_falcon: &*this.sec2_falcon,
+                },
+                bundle,
+            )
             .inspect_err(|e| dev_err!(device, "failed to unload GSP: {:?}\n", e));
     }
 }
@@ -343,7 +354,9 @@ pub(crate) fn new(
             sysmem_flush: SysmemFlush::register(pdev.as_ref(), bar, spec.chipset)?,
 
             gsp_resources <- try_pin_init!(GspResources {
-                device: pdev.as_ref(),
+                device: pdev,
+
+                spec: *spec,
 
                 bar,
 
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 3f11eaec26c7..336ad23c96f9 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -3,7 +3,6 @@
 
 use kernel::{
     bits,
-    device,
     dma::Coherent,
     io::poll::read_poll_timeout,
     prelude::*,
@@ -14,7 +13,6 @@
     driver::Bar0,
     falcon::{
         gsp::Gsp,
-        sec2::Sec2,
         Falcon, //
     },
     fb::FbLayout,
@@ -102,7 +100,7 @@ pub(crate) fn boot(
                 dev_err!(dev, "GSP boot failed with error {:?}\n", e);
 
                 // Ignore errors during unload; we will return the error that happened during boot.
-                let _ = self.unload(dev, bar, gsp_falcon, ctx.sec2_falcon, unload_bundle);
+                let _ = self.unload(ctx, unload_bundle);
 
                 Err(e)
             }
@@ -136,17 +134,16 @@ fn shutdown_gsp(
     /// This stops all activity on the GSP.
     pub(crate) fn unload(
         &self,
-        dev: &device::Device<device::Bound>,
-        bar: Bar0<'_>,
-        gsp_falcon: &Falcon<Gsp>,
-        sec2_falcon: &Falcon<Sec2>,
+        ctx: super::GspBootContext<'_>,
         unload_bundle: Option<super::UnloadBundle>,
     ) -> Result {
+        let dev = ctx.dev();
+
         // Shut down the GSP. Keep going even in case of error.
         let mut res = Self::shutdown_gsp(
             &self.cmdq,
-            bar,
-            gsp_falcon,
+            ctx.bar,
+            ctx.gsp_falcon,
             commands::PowerStateLevel::Level0,
         )
         .inspect_err(|e| dev_err!(dev, "GSP shutdown failed: {:?}\n", e));
@@ -156,7 +153,7 @@ pub(crate) fn unload(
             res = res.and(
                 unload_bundle
                     .0
-                    .run(dev, bar, gsp_falcon, sec2_falcon)
+                    .run(&ctx)
                     .inspect_err(|e| dev_err!(dev, "Unload bundle failed: {:?}\n", e)),
             );
         } else {
diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/gsp/hal.rs
index 00e39cc1fbde..113d445239b9 100644
--- a/drivers/gpu/nova-core/gsp/hal.rs
+++ b/drivers/gpu/nova-core/gsp/hal.rs
@@ -5,18 +5,11 @@
 mod tu102;
 
 use kernel::{
-    device,
     dma::Coherent,
     prelude::*, //
 };
 
 use crate::{
-    driver::Bar0,
-    falcon::{
-        gsp::Gsp as GspEngine,
-        sec2::Sec2,
-        Falcon, //
-    },
     fb::FbLayout,
     firmware::gsp::GspFirmware,
     gpu::{
@@ -37,13 +30,7 @@
 /// required for unloading is prepared at load time, and stored here until it needs to be run.
 pub(super) trait UnloadBundle: Send {
     /// Performs the steps required to properly reset the GSP after it has been stopped.
-    fn run(
-        &self,
-        dev: &device::Device<device::Bound>,
-        bar: Bar0<'_>,
-        gsp_falcon: &Falcon<GspEngine>,
-        sec2_falcon: &Falcon<Sec2>,
-    ) -> Result;
+    fn run(&self, ctx: &GspBootContext<'_>) -> Result;
 }
 
 /// Trait implemented by GSP HALs.
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index 02203dfd3584..a87d526d2310 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -14,7 +14,6 @@
     driver::Bar0,
     falcon::{
         gsp::Gsp as GspEngine,
-        sec2::Sec2,
         Falcon, //
     },
     fb::FbLayout,
@@ -118,22 +117,16 @@ fn wait_for_gsp_lockdown_release(
 struct FspUnloadBundle;
 
 impl UnloadBundle for FspUnloadBundle {
-    fn run(
-        &self,
-        dev: &device::Device<device::Bound>,
-        bar: Bar0<'_>,
-        gsp_falcon: &Falcon<GspEngine>,
-        _sec2_falcon: &Falcon<Sec2>,
-    ) -> Result {
+    fn run(&self, ctx: &GspBootContext<'_>) -> Result {
         // GSP falcon does most of the work of resetting, so just wait for it to finish.
         read_poll_timeout(
-            || Ok(gsp_falcon.is_riscv_active(bar)),
+            || Ok(ctx.gsp_falcon.is_riscv_active(ctx.bar)),
             |&active| !active,
             Delta::from_millis(10),
             Delta::from_secs(5),
         )
         .map(|_| ())
-        .inspect_err(|_| dev_err!(dev, "GSP falcon failed to halt\n"))
+        .inspect_err(|_| dev_err!(ctx.dev(), "GSP falcon failed to halt\n"))
     }
 }
 
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index 984716fc0bf9..7cb322b0e31d 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -123,18 +123,15 @@ fn build(
 }
 
 impl UnloadBundle for Sec2UnloadBundle {
-    fn run(
-        &self,
-        dev: &device::Device<device::Bound>,
-        bar: Bar0<'_>,
-        gsp_falcon: &Falcon<GspEngine>,
-        sec2_falcon: &Falcon<Sec2>,
-    ) -> Result {
+    fn run(&self, ctx: &GspBootContext<'_>) -> Result {
+        let dev = ctx.dev();
+        let bar = ctx.bar;
+
         // Run FWSEC-SB to reset the GSP falcon to its pre-libos state.
         // Log errors but keep going if it fails.
         let fwsec_sb_res = self
             .fwsec_sb
-            .run(dev, bar, gsp_falcon)
+            .run(dev, bar, ctx.gsp_falcon)
             .inspect_err(|e| dev_err!(dev, "FWSEC-SB failed to run: {:?}\n", e));
 
         // Remove WPR2 region if set.
@@ -144,13 +141,14 @@ fn run(
                 return Ok(());
             }
 
-            sec2_falcon.reset(bar)?;
-            sec2_falcon.load(dev, bar, &self.booter_unloader)?;
+            ctx.sec2_falcon.reset(bar)?;
+            ctx.sec2_falcon.load(dev, bar, &self.booter_unloader)?;
 
             // Sentinel value to confirm that Booter Unloader has run.
             const MAILBOX_SENTINEL: u32 = 0xff;
             let (mbox0, _) =
-                sec2_falcon.boot(bar, Some(MAILBOX_SENTINEL), Some(MAILBOX_SENTINEL))?;
+                ctx.sec2_falcon
+                    .boot(bar, Some(MAILBOX_SENTINEL), Some(MAILBOX_SENTINEL))?;
             if mbox0 != 0 {
                 dev_err!(dev, "Booter Unloader returned error 0x{:x}\n", mbox0);
                 return Err(EINVAL);

-- 
2.54.0

