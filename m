Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12B3C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:10:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4642210E900;
	Mon, 29 Jun 2026 14:10:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="AjbrIHdD";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013054.outbound.protection.outlook.com
 [40.93.201.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35F1310E900
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:10:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aP/BLlsqEfIWbKEbvBE/uM/5/Cdxxgoc9DMUex478reHmEfLr6dVBKJTCaIu5TImZeXR5Y/NjAFzdyvy+QDj9x4BKrgzmBMo7n89xSZeyoo9rBoUsCAnfpvULz3khmPakxvi+ttDyq/61ZAgBE6NbtMv25L1cI1t3vc/c5BVK9Yw4VpH+LA/JYp4YqWyxRdHnJcluv1K2C1iyQB8XL7kUioAfttvoMrf723UU/cUBQ1AG1RrwQMdQqjhKbE5NJOyYMCeAC0gkeQR+4z+zeGb/0Co/U8BUsHsxo4RdxBDx8iIn34nk1e+hzt1TKgWaUL/b+j4U2yqOgAHSGBNsdtIeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GGuLHakNj88pjfhSROwrfl9Gel6Tn6rm2cqTZy2QQw=;
 b=siGFcSi72YBJFYOg4i7iTNBU1dF/xewe65MSxlqpFoEXaepklXS8iADpB4HGte4rkiOoecXraR3vNFzoCLuAL5Z3RUCki9i7aLMF7upqhGlpRuqAPrb6OStySeZDzP4R++WrF+nXm2t6gCkaibZUY/k/T7LzymCQ0QPBMlJT1EOpRqmE6HRlNQ6f6mBJtH4LbRCyAIBu40zhJDu4333fxDrbuE+sfbhtalF8Aonw4vIzHbQimwd5fwNA/GGYEpFW3efMW/SXzQNAjxIhtVH9w+/aMPuTVpi4W37Oxjb8LaAqvWZRdr4D7oevUJUc5/7ydvP93vwUja6UyO6ivWecOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GGuLHakNj88pjfhSROwrfl9Gel6Tn6rm2cqTZy2QQw=;
 b=AjbrIHdDuy/nblk7Wqn5Ty4Rj3/MW9rL5LLN/p/evqnoXTauEXB5vD9lac4QTKqMOyr8Ib9KVmnc5PdT3HEHuLIjKjoSqrTbDxe1HoCmBg8qRfBWPWhGEc9JYQx4hGFUhXRxfyFkg1YduLxdL3vWv2EqL3uTzHkXV/0dE8sg6y1azvYxTYILjSWYCUtH1BaDNx5z4dWxuRUip47IjsJDJ6AgAV3WXNW8rwoddK6NFzBpUkbAl/lkI0rhpd3aoFzrPenimQ7EHg7ZkoFoHLOqWmEEmem3KaSLGdTDvBguGIU/nOE6wJ9gcIEoyrkkXjbLwOh84y5nWAXtUgfyhr5XUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CYYPR12MB8654.namprd12.prod.outlook.com (2603:10b6:930:c9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 14:10:02 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 14:10:02 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 29 Jun 2026 23:09:36 +0900
Subject: [PATCH v4 04/13] gpu: nova-core: gsp: pass GspBootContext to
 unload methods
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-nova-bootcontext-v4-4-5539d8469590@nvidia.com>
References: <20260629-nova-bootcontext-v4-0-5539d8469590@nvidia.com>
In-Reply-To: <20260629-nova-bootcontext-v4-0-5539d8469590@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: OS3P286CA0084.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1f6::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CYYPR12MB8654:EE_
X-MS-Office365-Filtering-Correlation-Id: b88a1608-d1f8-44c4-7351-08ded5e81c5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|10070799003|1800799024|23010399003|3023799007|56012099006|11063799006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: 1bNb9osZrYZky4kDaOQlVdJPZ+XX7RWKyoTp5nKeru3sMLT2JIQoM1SzhMMvHJduOZnqvFoThfjMoVg/sfN7dl3cWWEVRadttRY+Xwoad8ieixnb6BBZskt3FOtfNvJ/onDmqvpcKzhsYd1nR/akzryXpRjUY8Cd3aZ7DsFL4cHnvDFIxz6te/gkvCHU/F58jX8yzSHjCiC5V5n+XPZ9kEfJuzRz4t5YV5M4HOHDYflbpUh9kI/lIPeZutNF9UjWKwRyNbVw50eNGAggDYmsZPOn1pBsAo9+BxEapsRd+9PbhGIM6SawMM5gV65lLtywQKHRGArUVzXWup/bvrmDWCXsxHHY11Htdg4kahXYyrl2mMJYSLcOsvI058r8+e2odNc/k3WI2qVXn/+KL2L9yeZ5nIvcHUyQWiBIO7+uuMck5AmE5SS1KDpl3qgLwxRkjLZwtXjfn6Tygrmun2JkCi5d9f3RQEGb2o1nRcHLWeTriZ3pNN9amCk2uXwFwbkr88dIHUEOzxt7+34cH9BlVzl83L1IDDyzGyiMF4DJb53zz6Ej2cnhS5zpw27DlnwJStAewvdvNfIyMxXjJM8rKUogrjq1aTCyH2sLUTEXrvzsAp6ABaXZ7l7RDhQ1vcMk4eBlJUAKrK7LNpPDv/OcbqXrILfyolUPscGXQ5mN9402+ma2NRg/q8KgtgtQRuC6CJoN6iSzuvExUJ2w2nCJqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(23010399003)(3023799007)(56012099006)(11063799006)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFExRFVaamp2cnRhMm1sM2U2SFVHSE5hczBBK3Zka1l3OG04emFKWHpxNVJo?=
 =?utf-8?B?SjVMT1hnVFpCdWw5c1NQalBGa1VVZUpLZDd3cWVQNkhHdlg2VGZyU1hRVnpq?=
 =?utf-8?B?NTlXcFhLWXc5TkQra0QvTGpMNWZBVCtwNXliQ0VlcUpXbWNIMi92QVptSW1C?=
 =?utf-8?B?Nk9nRzNwQmJLVi9adG9XMXdwVHVBSjFBVTNVdjlSMzVTcEtIWk1XUXduYWxh?=
 =?utf-8?B?V2I4ZXFaN29mMkNFbzRCdCtaR295cmIrSk9YQlY5Y3JVbDA1Uk5GRzBGaVhp?=
 =?utf-8?B?RU1VYWgyZ25YeUt1ajNScXlmN2RJUjdGVXlXR08xZjZZVE1GUHpkQ0xKQ3F5?=
 =?utf-8?B?THkzcTZjbFJ3UXM2SndwcFB1azRuYjBrNGxsQkc3T2FzY2xmekZyd01YLytL?=
 =?utf-8?B?ckRScmxwUWYwU1BUUmQzWlRaV1JoSktXSkg5SWtUelRKc1RqdDBHSDg2S3hj?=
 =?utf-8?B?bHBSQ3lGaTBSMlFYcUVIZDUreGIzTUh5S0dYdVh5OWJoWGVqNWd2VkZnb1dw?=
 =?utf-8?B?MGVyMEl5UzdRRC94TDhZakNzWHEwTjVMRisyenF1VDZwZmhNWDRNU0syQ2Yy?=
 =?utf-8?B?MnhaNVNNdk43STBoQVNtczhQTUg4VFRLTWo3aVdpTVJlYWx2ZExGeWpLRi84?=
 =?utf-8?B?NFppK2RTcGptRUdET01kdkJBSW9yUmMwNjBMY29uVkU1N0R0MjVqR2h5Wm5v?=
 =?utf-8?B?eW9CVHhqejJmNExaSDhlS1JKL09WME0wZzVpYWRyTEdKUEpvZDM1Mys0bXBE?=
 =?utf-8?B?MmVHWHFESW94WVpMZndTUXppWThTa2JpVHVCMTdEMkdhOUZtNWRMTXNOVDhP?=
 =?utf-8?B?Z3hLTHFTRzlDOHEvOEhiZ2MrMkd3QTQ1ZUxYaUVyOFdCYi9mWjRwdTNEZ2gx?=
 =?utf-8?B?T0htWExRUU1Ja1o0NXVKWVU0OTVSdzhoa3l0OTlod1o1MjhRSzU3ZjZ3TDVl?=
 =?utf-8?B?cWEyWlF2VllISWJwbjhwWkl4dllHZGZhRklLcy94VmpPa0ljQW1YcnBHaDU1?=
 =?utf-8?B?cmhhOHc0M3lWQjJqRjNZQjh6VXZ5T0V2SlZLeGo3clJZQ3Fnd1RNTUxMZW1W?=
 =?utf-8?B?ekpYTnQ5bnVPbzBIb2FGTGw2N041UWQyNXpxR2JmblFFdjBVZEdSeW1nVDA1?=
 =?utf-8?B?V3hzNXBVQURTMVpvZ0liTUltcVRsbFpMK21ja3dxdG04cG9OQUwvcUdkQy93?=
 =?utf-8?B?U1dIMCtlWktYTkpEeHVGVjJuSHROVUJCQXFrMm15cGk5LzhmK0ZPYnVOclU1?=
 =?utf-8?B?MVZEemhiRE5zU0psaElzZUsxR2NTQUxSYXFCbmhKbU5xU09JM3BqeWNyZHNW?=
 =?utf-8?B?cnNldnZNaVk5YW80bDZqcksxVWFQSjJXYVpDbVppNnJWb2ZaZ0srVS9wWklW?=
 =?utf-8?B?eFB6SFA1bVJWNmI0aWtMSTZYdTlBN21yc1hRK1NYbEJtYjhlNjVySVF0TWVQ?=
 =?utf-8?B?QW90dnE3UFpsOVJqdC9RNTRyWnBGLzh3aEh3N0FSZmJLaTRJdmh6VGlBMEFG?=
 =?utf-8?B?NGwzQ3dwZXNWTC9VMCtFZFZMS1NEaTVKRmdiazZ1dHQ5N1JsNWgyYmhMYlo3?=
 =?utf-8?B?dS80bldQZkxOcmJTazJLWGZBUWtyeXpRNjM5THVtczhBRzhZRU9sSUFscXFV?=
 =?utf-8?B?OEdNZGxjOGdHYmY1K0h3MVI0dHJnblpsc3Z6WUVFSmZGQWovRFhqeUEwL1Bl?=
 =?utf-8?B?MStiSUkrYnNHQWFDMWk2c3hRZC9Xc2xnbGRZSGtKZlR5RlFuRHVkVjEyT0xK?=
 =?utf-8?B?eFJPeGNoQXZuUXZYN2w2WHNRc1BscnA0blJHazY4SEdWcFpBYkNMQkFiUVI4?=
 =?utf-8?B?bWRIY20zSmpuazJpVEdQOGk3am9ibDRIaFFON1ZKUFlBOVR1VzBxR2l6MGR2?=
 =?utf-8?B?anhnN3FLL3h4b2syYzYvWXR5YkNlMEVzVWhRdzkvVHhoTStUV2xXdy9zNTBs?=
 =?utf-8?B?V2pzOEJQaUp4dmMxTkcySmVxMHZVcHVNd2NWdDkrejd2K3ZlZjA4ZU51QkNR?=
 =?utf-8?B?RmZVayszZWRQNmp6ZzFiTTFwaWsrSG1pYlVQVHZzVFNqaTFHdEwxVHU2dWJu?=
 =?utf-8?B?cUt0ZXBzc0VFR21zenJ2bHpkd3Z3bENwejkvRWZSQm9vaEhIcVRDMjJ5WDNi?=
 =?utf-8?B?SmJMeGpQNnpHcmo1amZBUXJ6MEg1ekcrbjU1czErbzFPdzdvbXpTa2U2Ry9U?=
 =?utf-8?B?YlB5UGpodk1SVVpXVFF4SnU5R01HYndrazVHOG4xMnc4aFM2cmlxZVVYdWlj?=
 =?utf-8?B?TlR4bTdPSWZwWW5tTlpFYUY0QnRVM0VabWp6bkMrR3VHUlZuM2UvL2MyQWNO?=
 =?utf-8?B?SVN0dDZ3WFR5bGRVd1NJYnlEQ1R2YmNHZTZSaDAzUEwzVFNLeG1rRms0S2hn?=
 =?utf-8?Q?Msn5WNM9oeTFvzndrsh47Tx5Chx4NpPTfbsBVYm6vyGnI?=
X-MS-Exchange-AntiSpam-MessageData-1: /S2hVFf64yLk2Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b88a1608-d1f8-44c4-7351-08ded5e81c5b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 14:10:02.0091 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yEmPz3LgRubBnd5frdfi0Qk+kOUAUYSvTJnI5gKQxuAL6NjcAxNN6RXxmtf37Es1Kzy0w00cvP2HNApSFc81wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8654
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

Reflect that fact by replacing the arguments of `Gsp::unload` and
`UnloadBundle::run` with the `GspBootContext`. This symmetry between
`Gsp::boot` and `Gsp::unload` will also be convenient when we want to
make these methods generic over the boot context corresponding to the
boot method used.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs           | 19 ++++++++++++++++---
 drivers/gpu/nova-core/gsp/boot.rs      | 28 +++++++++++++---------------
 drivers/gpu/nova-core/gsp/hal.rs       | 15 +--------------
 drivers/gpu/nova-core/gsp/hal/gh100.rs | 14 +++-----------
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 23 +++++++++++------------
 5 files changed, 44 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 43c3f4f8df71..32bfa0be2357 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -269,7 +269,9 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
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
@@ -312,7 +314,16 @@ fn drop(self: Pin<&mut Self>) {
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
@@ -344,7 +355,9 @@ pub(crate) fn new(
             sysmem_flush: SysmemFlush::register(pdev.as_ref(), bar, spec.chipset)?,
 
             gsp_resources <- try_pin_init!(GspResources {
-                device: pdev.as_ref(),
+                device: pdev,
+
+                spec: *spec,
 
                 bar,
 
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 536f2e341c01..75054424a951 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -3,7 +3,6 @@
 
 use kernel::{
     bits,
-    device,
     dma::Coherent,
     io::poll::read_poll_timeout,
     prelude::*,
@@ -15,7 +14,6 @@
     driver::Bar0,
     falcon::{
         gsp::Gsp,
-        sec2::Sec2,
         Falcon, //
     },
     fb::FbLayout,
@@ -47,7 +45,6 @@ pub(crate) fn boot(
         let bar = ctx.bar;
         let chipset = ctx.chipset;
         let gsp_falcon = ctx.gsp_falcon;
-        let sec2_falcon = ctx.sec2_falcon;
         let dev = pdev.as_ref();
         let hal = super::hal::gsp_hal(chipset);
 
@@ -61,9 +58,11 @@ pub(crate) fn boot(
         // Perform the chipset-specific boot sequence, and retrieve the unload bundle.
         let unload_bundle = hal.boot(&self, &ctx, &fb_layout, &wpr_meta)?;
 
-        let unload_guard = ScopeGuard::new_with_data(unload_bundle, |unload_bundle| {
-            let _ = self.unload(dev, bar, gsp_falcon, sec2_falcon, unload_bundle);
-        });
+        let unload_guard =
+            ScopeGuard::new_with_data((ctx, unload_bundle), |(ctx, unload_bundle)| {
+                let _ = self.unload(ctx, unload_bundle);
+            });
+        let ctx = &unload_guard.0;
 
         gsp_falcon.write_os_version(gsp_fw.bootloader.app_version);
 
@@ -82,12 +81,12 @@ pub(crate) fn boot(
         self.cmdq
             .send_command_no_wait(bar, commands::SetRegistry::new())?;
 
-        hal.post_boot(&self, &ctx, &gsp_fw)?;
+        hal.post_boot(&self, ctx, &gsp_fw)?;
 
         // Wait until GSP is fully initialized.
         commands::wait_gsp_init_done(&self.cmdq)?;
 
-        Ok(unload_guard.dismiss())
+        Ok(unload_guard.dismiss().1)
     }
 
     /// Shut down the GSP and wait until it is offline.
@@ -116,17 +115,16 @@ fn shutdown_gsp(
     /// This stops all activity on the GSP.
     pub(crate) fn unload(
         &self,
-        dev: &device::Device<device::Bound>,
-        bar: Bar0<'_>,
-        gsp_falcon: &Falcon<'_, Gsp>,
-        sec2_falcon: &Falcon<'_, Sec2>,
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
@@ -136,7 +134,7 @@ pub(crate) fn unload(
             res = res.and(
                 unload_bundle
                     .0
-                    .run(dev, bar, gsp_falcon, sec2_falcon)
+                    .run(&ctx)
                     .inspect_err(|e| dev_err!(dev, "Unload bundle failed: {:?}\n", e)),
             );
         } else {
diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/gsp/hal.rs
index 851d1f24c137..849ca224085b 100644
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
-        gsp_falcon: &Falcon<'_, GspEngine>,
-        sec2_falcon: &Falcon<'_, Sec2>,
-    ) -> Result;
+    fn run(&self, ctx: &GspBootContext<'_>) -> Result;
 }
 
 /// Trait implemented by GSP HALs.
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index 5fe445d73599..411b06c22fa0 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -11,10 +11,8 @@
 };
 
 use crate::{
-    driver::Bar0,
     falcon::{
         gsp::Gsp as GspEngine,
-        sec2::Sec2,
         Falcon, //
     },
     fb::FbLayout,
@@ -116,22 +114,16 @@ fn wait_for_gsp_lockdown_release(
 struct FspUnloadBundle;
 
 impl UnloadBundle for FspUnloadBundle {
-    fn run(
-        &self,
-        dev: &device::Device<device::Bound>,
-        _bar: Bar0<'_>,
-        gsp_falcon: &Falcon<'_, GspEngine>,
-        _sec2_falcon: &Falcon<'_, Sec2>,
-    ) -> Result {
+    fn run(&self, ctx: &GspBootContext<'_>) -> Result {
         // GSP falcon does most of the work of resetting, so just wait for it to finish.
         read_poll_timeout(
-            || Ok(gsp_falcon.is_riscv_active()),
+            || Ok(ctx.gsp_falcon.is_riscv_active()),
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
index f78e2489f5a6..c0956fb1c9cf 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -121,18 +121,15 @@ fn build(
 }
 
 impl UnloadBundle for Sec2UnloadBundle {
-    fn run(
-        &self,
-        dev: &device::Device<device::Bound>,
-        bar: Bar0<'_>,
-        gsp_falcon: &Falcon<'_, GspEngine>,
-        sec2_falcon: &Falcon<'_, Sec2>,
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
@@ -142,12 +139,14 @@ fn run(
                 return Ok(());
             }
 
-            sec2_falcon.reset()?;
-            sec2_falcon.load(&self.booter_unloader)?;
+            ctx.sec2_falcon.reset()?;
+            ctx.sec2_falcon.load(&self.booter_unloader)?;
 
             // Sentinel value to confirm that Booter Unloader has run.
             const MAILBOX_SENTINEL: u32 = 0xff;
-            let (mbox0, _) = sec2_falcon.boot(Some(MAILBOX_SENTINEL), Some(MAILBOX_SENTINEL))?;
+            let (mbox0, _) = ctx
+                .sec2_falcon
+                .boot(Some(MAILBOX_SENTINEL), Some(MAILBOX_SENTINEL))?;
             if mbox0 != 0 {
                 dev_err!(dev, "Booter Unloader returned error 0x{:x}\n", mbox0);
                 return Err(EINVAL);
@@ -293,7 +292,7 @@ fn boot(
         // Run the unload bundle to try and recover the GSP if an error occurs.
         let unload_guard = ScopeGuard::new_with_data(unload_bundle, |unload_bundle| {
             if let Some(unload_bundle) = unload_bundle {
-                let _ = unload_bundle.0.run(dev, bar, gsp_falcon, sec2_falcon);
+                let _ = unload_bundle.0.run(ctx);
             }
         });
 

-- 
2.54.0

