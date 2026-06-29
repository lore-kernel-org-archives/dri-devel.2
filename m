Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE82C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:32:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD6EF10E883;
	Mon, 29 Jun 2026 12:32:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="J9rxez4N";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010021.outbound.protection.outlook.com [52.101.46.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A725210E85C
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 12:32:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iiKm0pGCWoC8VIhxF+M/JX9Otli5tfBZEyI+1jVjCnj1nghYCOU2bWbXZ5B4niPUZ+tP4eLT4AGgNKiTkwEqwjdzpV7Ggzx4AvzX/s9Z2qh50NWhMFFbvQqJeOEavCU8dXPPrikG01qhK7FUHwH6T8zwnOjKGx581JsLPi3MZyXllZtI5x1pQXBNuz+0CaSViSYKeyv08DYlW+7C21PRg7BYPYobRFCrzvlDTdZqBuCxtNXMIoJaPhB01sg7henTU2O4A2CrmnAvdZ9kVTUsxW40FESB3Bjhm15yw7GWV3YeAIvjargQ7ZsWJXPjkn19qDq2j4Tpb84pJdEB33xOUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKGcDpHeu5NhgrTPX+XH0EjxqH41zV14Dz+IUUEllbs=;
 b=zSUXMSpCCkCop92Agt5q809fTh0y/8Z3WZGccxhw4xzdOjVrjZ2PG3MLQIZQ0tV6rxBMQMo5QvQ0oe6weBJcuSB/aFKW8MaaiO2yHAmDREEcJIabqL2/uLqXR5Z+d5ihLNzfWwH/FCfN/RuwaqkqCuysjVhtA0MHhaNBUVtzPdWKHip4HceICfl0LnnT1i42Dnhv+jQHG7VVn5lxIDBs4F7gVjHvKSHrsXsyB7llRiwn1xTDvcZSxphIGKh4qfWATiUPW2OEN1exY6yrGP3cX6X+z2xF8p/4fyexirAnr8MD/3c2miLdCGBbqajcffzBHiboaC2dj/7Ei8C7lZ8IRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKGcDpHeu5NhgrTPX+XH0EjxqH41zV14Dz+IUUEllbs=;
 b=J9rxez4NH/A+7FxdjNwHiwgYimmFwdgCKgVayJlEM1shBQFm4IRc9WqJcHcg34oFDZxWkeAwWBQmddwtcUWVRPzHa9u3ss+HhdVzHSq/SsCSPvjv08IRhh8NTFKGHLXI0xZaAnl/UvRmtYAg7Vno+6jsi3DR8C1J8MY9XAN8hiQ4iiAICFrLl61kVEav4LXjTT4VdxwnZdU2yO9Bz9tJJjKZJ/1AZML0ACRpTGv1Y8TsRQasyzStQwW3XcJz/ebNc6nZJVaE8wNaJGe9+ZJeKDUdLy+6Og/ATrtVbkaZcxgpqhZLeNkNmUxTYgYzECyFFojAQsG3C5nneMFsxueQEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB8311.namprd12.prod.outlook.com (2603:10b6:208:3fa::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 12:31:59 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 12:31:59 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 29 Jun 2026 21:31:44 +0900
Subject: [PATCH v3 01/12] gpu: nova-core: gsp: sequencer: use
 GspBootContext
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-nova-bootcontext-v3-1-26cb29ee8dee@nvidia.com>
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
X-ClientProxiedBy: TYWP286CA0002.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB8311:EE_
X-MS-Office365-Filtering-Correlation-Id: aeb0d8b3-df4d-4395-854f-08ded5da69d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10070799003|921020|18002099003|22082099003|11063799006|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: z567Rd3ffjc6YlceiKHbQDsrXSB8l5Mp0/fZH4O1pC5S+4X0HJN+obtEoZEdlHzGnuEPZ29lUM/0lhMvc8TKf+0fZC99VoMXHVFNqiwopq2gZmZDdY1aMSCsYuYrVIhnlVbyuw8xCc1hoL8DvDGCyTU7zfk/tdHPBGBijpCb5K1rW7/MWubHtwOk+IARZGmpglDHIkR9xQ1oCzAJiR3Fxqts1F2SRwz5v5P7/DCRFfRTeFldx33FyFnpLhAb/FY25lOSp0g0DZ6TgWxXUa6BJYUCdnfYkvSX/KQuXnXy5vUCDOwUiAZHIDFzuukT1We41c38Vk8fZDnq01v9VHinVzPEVAZ7nLo175Wp/aOm1GeJEn95a359hblpk+LU7t2ZNHas03BLN/5MDOOPwOQLkcXlbevdXDiis9xmQlwH2lSPc91PMbgUwboVJz1iLnyCq/1a+9UMGyIiJAcmtUXjBJ8zPodSksHbOiz1ne3HdXo2DtWmq3kyjxJc2HztYzRq/3BOOqJsWzBbAI4Oj8Nlku762yOgSCSh3m+mCCwc5N480oxA1J791QmdeHdr6CdNdOmYdJ/UJPUlVpFO5EZAwKX6Fiqdlp9/ISIcd5DrrXysOlerk6ogA+FEIAtJ5gax12DGEGxMQoIiAZmcdL0/C1xMM20etkWT4CstBVGlonxYJH+JN85j41LZO/bLe+wxPDrxzoujUkPoSBbK1jP0tQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10070799003)(921020)(18002099003)(22082099003)(11063799006)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1ErMkhMalhuYWFtYUlHdnVaOGtRVlFoSjFlMVV1dkdZZUNHbkJzYnU5eGNr?=
 =?utf-8?B?Z3hlazh6M0FNQTZyOUhsWFhhSW8xQkhYZXdTOEdPaWNzQ0FkMVBmenY5d28z?=
 =?utf-8?B?RGgyZUVyN0lyc09peEIzS0FDNkg2YmZqK0hsWERCbENmZ2hmWFpCcTFZU3Ra?=
 =?utf-8?B?aTZIV2ZlT29ZRGlaWUE1Y3dtN3FSM1hWZzNEclcrczhFS2Z0K0tEbVNuZmVx?=
 =?utf-8?B?LzY3aGZGUytsMU5FSENxWUF3VmpNbzU5MHFZMHpWSUV5emJjczhxVXlKaGVa?=
 =?utf-8?B?QjVVc0hzNTZtc1FVUCswTUhBLzkvOVhhNXRycnJMTnZBdW5DWUxPWi9ibU1R?=
 =?utf-8?B?YlY1WG9mZ2NIVGN5emtUaXJGVkVCSUdwRGU3WkxiOVNCODZYTm1QaC9qVXFT?=
 =?utf-8?B?VGdETXNXZWR0d2VQMU1meHo4YUM3bk80MkdNY0k2U0F1K2VFeGZwNDNkOXA3?=
 =?utf-8?B?bEFQSU1CLzhwTEhOLzJhK2MrK3c2bFNXYlRPOHN0eVBwV3dPNzd1SEZkK1Vs?=
 =?utf-8?B?akNDS1RwdlExWXh1d1dLODZDck5JeVl4eGtQSStRaW8ySkgrdHkyVGhGVld6?=
 =?utf-8?B?dUlZaTQzTEsvUmJvWG9icWZxYmtGWHpvZmJkWkJobmNadWFUMmNOeUdZOVJz?=
 =?utf-8?B?Q3lUajVVa1EzV29uOVhIQlVxakVqbjcyK3NITmlia2RSaWM4YyswenR4S1JZ?=
 =?utf-8?B?N3R1MXVVT0VGcW9xL0lYOW9pbmpNS3hXd2J4VEdVQlhoZzA2SlRJMGlmTUs0?=
 =?utf-8?B?TWw1aEFWaDlISVkyUDZscHBveFExK3BVc3pjMWFLODYrRW5IZkNNWHBSdE1r?=
 =?utf-8?B?eWhobDJRaFE2dFEzbURFUEwzNkZ3Vk9hcUQ4T3ROb2JBRS90QlR3ejRBR2Jt?=
 =?utf-8?B?OFEvMEVaWkFUdDhmWDhlaEpPdGZXQ050T1hLaEpqeHByY0FyaXI2Vzd2QWE5?=
 =?utf-8?B?UTAwR3E1OGZEampDNGRMaDVybDQ2T1hLeVg1M25VM09TbU5laUZPTkdSV2g1?=
 =?utf-8?B?T2lYWUk1VEZWTlRlRlVZNGhLQnBPRG9NQU9ncEcyZGlMMWpQUWx4aFNvMnZU?=
 =?utf-8?B?ZXdtREtDS1JNbDNiaEE4UmZIbjNXdTBxS3Z2MC9OUEEvV1h3WVUrMlh4V0lI?=
 =?utf-8?B?ZGlwSThjZTR0RzZFbi9vWGE3N2FYTnM3bmV6c0ltNldvODFpbUNtK3czL0RP?=
 =?utf-8?B?dXZ6MmZ3Y0MvSDVTbUJKSnh4M0RZVGtmcE9VQ2cvdHplUFRSRUk3dGVrZW8z?=
 =?utf-8?B?RUZ6NU5BTWhtb3BHQWJSR0NLd0JVTitiQmxSenZOdWIxemhuK1l1TTBlTld1?=
 =?utf-8?B?cWlYK3l4NERxSFozUkxVZ0FJUWpqL09tSWpPdGhwSGpNQXhUcTRTT0VyMXd6?=
 =?utf-8?B?MTkrMFJ5b3VMdzVWL1Jud1lMREQ0dmNwSDhhWmc4NzZxTUJ3eUttMzJwMlZR?=
 =?utf-8?B?OU5wdTY0NzhlV0VneUZHcW10WjV4ODU3ZW54SkJyc3h0a0ZYMnVQakNmd3pZ?=
 =?utf-8?B?ODR2T0ljVFY2d0N3Z0w2V2paZVhZUXlBUklIaDVNT3ZhdnozVjVQVlJuUzFj?=
 =?utf-8?B?NzJRekNXRHMxZkl0bXVHbmtWTzJ2SUoxWk9SajcwK0xPTlpSRVhOYkI1Q2tk?=
 =?utf-8?B?QitPc0F2TXpVbExmSnpNTGhYYkNHTTZaWjQ0SFpLcWgzTitxcVVCQ3hYVmg2?=
 =?utf-8?B?V1o0Tm5ML2x1M2Q0MTdIL0FDbndHMFhLSEMxbnhjZXU1UGFzSVhaSEVZL0dv?=
 =?utf-8?B?cUdqNjFhZGV6OCtlUVpvckgzOFI5WlFnN2RieDFpRllBREFuRUM3RmJKeHJM?=
 =?utf-8?B?MVhOSzlBRTN3MHVsSTJaeXNUSjl3Y1MwN1UrajJnbWJYalQ0OEpBYXdXbGQ2?=
 =?utf-8?B?M0Q0emczMDV5VGwxZXA3VnJyTWsyamJWMmJoaDU2QnYxQXF1MU9hQ3o2Y1hC?=
 =?utf-8?B?MUZ0aFV0NlhCNmwrUVlmb1k5RDJveFdzR2tESTh4WFkvYkcweDdNdjl3Vzhl?=
 =?utf-8?B?SElTUmthV1RySmo2Qk5PY3pkbW9OaWVSenZMaXd2enNoRmxBYWUyOHg2alB2?=
 =?utf-8?B?Q0szQmFlWXFQb0M2b3dydnV0OFlrZ3poNkR0VDljZUMxZ2wrbUJDMnhIT1c3?=
 =?utf-8?B?azhobUkraTBFeGRoRG5qYW9EMHUvWkc4dEh3cGlDZUVYaE9LeGVnV2d2ZTNs?=
 =?utf-8?B?Q2hOeVEvSUN6MDJnbDI1Z3hMWDFlQ1h5ckl2Q2ZObm1uMXNLc29tVkxXVTlh?=
 =?utf-8?B?S2duWTZ1VEtleWh6eXpCRGpVZTAva0VVMEtPU2tpYjRyY2hDbU4zOU14Tnpp?=
 =?utf-8?B?ZHpDVmhrZnBMWENJSnh1MzViN2ZSbEg3NDRmaHBJMmxiVzRuaTBsc1pVc1U1?=
 =?utf-8?Q?/2VE7b2y+Sye9pG/NEsvEoC5fDsUrHVxPH1Sbme5iklks?=
X-MS-Exchange-AntiSpam-MessageData-1: TuNHdXpZn7tayA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb0d8b3-df4d-4395-854f-08ded5da69d3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 12:31:59.0358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o9VhLwR/JXr55Q/sEiTGnG1dsSElUZI8XOL3geQRzCzR0y/MDP4Zj3e+BzV45Qt3ltIfoq2FtoC+e1Ya8TcdtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8311
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
index f8a8541704ee..6ed4ee268086 100644
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
@@ -336,16 +333,12 @@ fn boot<'a>(
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
index e0850d21adca..0da3c3531886 100644
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
@@ -338,24 +339,13 @@ fn iter(&self) -> GspSeqIter<'_> {
     }
 }
 
-/// Parameters for running the GSP sequencer.
-pub(crate) struct GspSequencerParams<'a> {
-    /// Bootloader application version.
-    pub(crate) bootloader_app_version: u32,
-    /// LibOS DMA handle address.
-    pub(crate) libos_dma_handle: u64,
-    /// GSP falcon for core operations.
-    pub(crate) gsp_falcon: &'a Falcon<Gsp>,
-    /// SEC2 falcon for core operations.
-    pub(crate) sec2_falcon: &'a Falcon<Sec2>,
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
@@ -366,12 +356,12 @@ pub(crate) fn run(cmdq: &Cmdq, params: GspSequencerParams<'a>) -> Result {
 
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
2.54.0

