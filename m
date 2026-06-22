Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF477CDB46B
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 07:12:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4521010E4EB;
	Mon, 22 Jun 2026 07:12:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZHKPyYtg";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010008.outbound.protection.outlook.com [52.101.61.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF86010E4EB
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 07:12:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sVAol3wUibYn3OK5suVdlYpCuVgeFtB83naTW/7UggbH7+TvlkZT6W3H4d9plEEWe/dYBK+hh+pNYntk3sjKIJ9SKYDY5aSGDMG9QaJkWNNysheC4dSrU6nXchAAt8AxuASCxeTvJO2ex7MwsWrAfXjtlKWJByhJzmCsWgH3rf21xZJheK2HFDZ7t2k8cmkqIMIHIDjY2QjEneSBVKVvP4YTNP8Y33Ps4vIK/iahvG3/qXx0FAcAcRPOsqeGw1Pf3XClbPUexDaC4eXIzVMpvFnRe/RaeyUTn2NTnwN0csrBzYvQeNCEAPwD99MsDYH90xT78+sFbIf7H6sKSN2Auw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEzGS/1z5JKu1cOKG0hSQCytaR4xh3MYpjOYljb7WN4=;
 b=eFB3uuz7dVA0lKp/wQQ0sUAoNTnI/JGmXIbMtU2V1fZIuyxtP42GPQur9tEBWdojmw0Mk2fDMtMkrnV3faGtrLHTCi32tI3CQhhSwtRZso4IVxntYzXHil9uDziVgSgKvdp7sXBszmzU2uNbjR1Maz16RGJf84Gekdqo3TvrJMQOP/oAyooaC18SaTo9Yf9rkHjy6hSucw1wvayhMaiS62Ix6aGBzhYpb7mucEQvHaM7VYAytUHhPDMF2VBCYfLXsM2jj1E0+FiwxRfh7qYrGxD1egCGNyRStsptjkUjxzH3P0KruiED5B+Zdn1iEwIj3yPWSfgOVUziEuO83XFxEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEzGS/1z5JKu1cOKG0hSQCytaR4xh3MYpjOYljb7WN4=;
 b=ZHKPyYtgvglPtLOz1EQ9RoWrlKDbcb9jDi7KYxYHQAZ/jUBev2W9o8c+1i+ks6MIeOY9FsdHSZhxOxdxvj0S326SC8/j+deeB5fo7XVUlERvSGU7dqjaJXm00J/U8xHutAxbwJHWFsDeL8WfXiFnHL3uGUQH69d9a2cDrhl7Z4bGziwOFW9rwMlp25BTRY2sjZ6bZfc2hJRcLQY2kncZ+mjptMolJY8qEHWQFLH2cMI95iznvvzixasW4Abps/3foISfns6o853GHru4v/3mjOC/v7ILAkTVUWmhT1XRnubkmBRBD21RHxFzvL04a9fxfC90njPbJMbcO/XE+SrHqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by PH8PR12MB6700.namprd12.prod.outlook.com (2603:10b6:510:1cf::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 07:12:23 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 07:12:23 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 22 Jun 2026 16:10:35 +0900
Subject: [PATCH v2 13/13] gpu: nova-core: store Fsp instance in Gpu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-nova-bootcontext-v2-13-0ddeafc06f5d@nvidia.com>
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
X-ClientProxiedBy: TY6P286CA0040.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b7::9) To MN2PR12MB3997.namprd12.prod.outlook.com
 (2603:10b6:208:161::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|PH8PR12MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: d10363df-ef63-4386-2d83-08ded02d9b3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10070799003|18002099003|22082099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: JMIzTJNvFpxpdIWg7kUT8fr8lJbBgPanIWMd/yYWFWHImsrEeIlrx6cqYrgNgeFAp0ECBhhxoQVyts1Az/tO5gVF8bBJDbvqxAWH14hy/NQJW2oi8Un8611VySJQ8+kljdJXIqB23StsjE50TxNn5CjutnrZGQonLppEpZyHdM6D2QCbymYpB8iHFiz9xLl6PYYo3PhC/K5D/JIdXSRTLOqCPTBfb5JEIt8AFUwPTm2FqAJKoOh6Ja23jE1sf12fArAEtTvwWLmsv4b0rdAsEy+KQklz43mwXBxYkV8aQePZSHoeWO9/w5NZ6xlOLm5lMDyg6CX85rPRDTWQARf9m0palX1i3oiKZwILBADajigsINJRZXw/AdD0aWIVATzQ7/+5VAg5uYYRXd2gsI4xIyWUBK+GkkjWDOWWdiwO6mzzudMM4nK4g3APuh891WWy1bqRDoeso86+6J+9duiCecl/hH2F4VHYg3yYAyLWNmQK5wMn2MJvdXLKpBd3X94C3xnnwHHtNgh1qOTecpvj6iRu3Cn/VSrpksESp1oJtNYcwRuVSlbQa/Dp8sOhafkCn129Tzm0lJ2i1RKttKgyFq3CDGkXxE3KeVWAz9RVeirA3WEs3m0XjNZ8+FGGkkMP5t6vIhpPbIU9HFQoO8//90RwSYhFaTCKnvE62QP5xGM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10070799003)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWhpaU5pYjZmOUpDdjN4YUJXZVNsaVhoV21keUkwa0tXZTRrcS9XNUZlTlpX?=
 =?utf-8?B?UUZnSTIzNDFsUTlkZ3l1Kzh1cjFicDdacHBpUnVIRU1vL0daUHlDR3F0MmZ6?=
 =?utf-8?B?cUxkUXJkSUk0VXArSTE5OWpoVFA2cWcvRldVNEJkNG9DZlZDQVZTWHMzbnh0?=
 =?utf-8?B?dDd0ZTJhMmtoakJzVytJVVlXMk9VMldCMnhPcHAzakEzNGFabmZXekhLZTQ4?=
 =?utf-8?B?WkJXOThsT3lab1c3aktnQlB6QTlOOVljRXNKenFUSmRzNmU3WDV0UEZmM3BR?=
 =?utf-8?B?ZnltRUJaOWgzQW9HYVcwY3loalg3d2pvWXl2bVZlaHJ3SmFLQm5mYnBSOW01?=
 =?utf-8?B?L28vMFNIb2lPQ3F6aTZ0WEtwZGZEdlZ0VFB6VGlLY2VieWkrRmlIdVFHZFpw?=
 =?utf-8?B?MkJJWVhtbU1paXBJcFhZR21VTVl4cU1RQldyMHJyVnNHOXd5S0NhU1Fycld3?=
 =?utf-8?B?T1pPSjhhMDd3QWRlZ0VHYXNCMXlvZHFrUDNiYkFjbnBMT3A2bkRXalIwKzUx?=
 =?utf-8?B?RHFIK25wQTM4MUtWOHJzdG1YbUFDK2MyTUJqKzAydmRXU0trOGNyUnEwcnc0?=
 =?utf-8?B?VmthdkpoTDgyUHVHdVZ1NmR2ZlkyOGpVZE5TVlFZb0pJejJTMStwbVBWbGpD?=
 =?utf-8?B?NDV6VkZIbGlMMThpV3ZQN245ejJXaXpWUzFBeHdJR2krVXRSNjJQTGVpc2ZY?=
 =?utf-8?B?UlVRQ1FEeWM3YlBuNGl2anZqREJlYW8wU3FOQU0yazJQNlRKL2FjRTVEMWs3?=
 =?utf-8?B?VDA2YkNIUGJ3c1lQV0xsd2Q1VGxES1BiZkI4Y3ErRmJKRzA1ZnZWU0JQbXNP?=
 =?utf-8?B?Y2VFbTZXTGlBK2NVdDRIZWd6OURwMjgrcW9ESmc0WmFNYnU3clRJRGgrM0t6?=
 =?utf-8?B?bXkvU1ZaaUJmUGY5T2QwZjd5RFdJa2ttbXF3d0VHSTY1a2VHR2s1S0phRmFO?=
 =?utf-8?B?eitUVkk4bEhtaEE5T1ZvTXluYWUvOW9TTW1HWXp2eHVINzdORG5MaFZtdjZL?=
 =?utf-8?B?Uko3SmRkeDE1eG5td1Y5YmM5VHZxVTlHb25OOGN3eHg2aFJ2WFVwYkJaWW1B?=
 =?utf-8?B?NW1PNTFJaFVMRkJvYWY5QVRxVnZOR3hvUEN6S3pHYW85VGJ0aXpERzNXa2Z3?=
 =?utf-8?B?QWdKS3JMWFdFOVdVT052VmVmS1VkT1BXaFZma2hlNCtlMXBSaUZEd0FEeWlQ?=
 =?utf-8?B?RG55L0NPU21iYytLNVMyWHNPdXhDakNFdFltMVhEOGtVMGJXb28yUmFENVlI?=
 =?utf-8?B?K1YvZVhqRExSTGE5NXQzOHg2eEJEVGN4enZUdVZrZGtBN2dFWUtOY0xPd01T?=
 =?utf-8?B?dHBKNmFwQ1BpMy9iZXlIOS9sNjQrYzE1czNSWng0Z0JyMElxZnU2ZnIvUDZp?=
 =?utf-8?B?Q1doSFUybGJ2Unl6WVVFK2xMalFSaFdYeER3MnNpZThUdlM5OHR1N1BPNTBy?=
 =?utf-8?B?OHVtY3BWdngzeEVQMUJaMHRJeWxhQjQvcWFGN0Jla25LNGpLZEI1TUExRTZo?=
 =?utf-8?B?WmtMT1FhajZwN3dCY1dJRVZYN0p6UmNDZm96R1JSYTQya3ZTY3JZSHRjNUZN?=
 =?utf-8?B?TXllZnpGOFpZckNrWnNFeVFYUVFIWjE2TWNyVmlLYXJlRUlsaURwUlplUEFS?=
 =?utf-8?B?SjlYdHFIQWViS3pkKytQS0lDU3d3K21DS0syRGVxN0FnZCsva2xJRnN4bmI5?=
 =?utf-8?B?VnprOWw5NjNveHpXelAyc3lEa0ZnUEg0VXNZYUdldzRFQWREUzhkVFBwcERq?=
 =?utf-8?B?S1VJMW01YjRJQWdxUzFaRjJyVGgzbHFUQkFxZllrczlkM013bnUzYWpJaGFj?=
 =?utf-8?B?STFaYW9Gb0xkYVR6KzBYMGQ0QnhUd2xpQ01lYU5hL2tNMEpidElzbTRkL3BL?=
 =?utf-8?B?RzZTanpmLzZXKzcyUFJiM3RLTG53RU03S3R1RThuN3dwekVxRUJCVkFWM3I0?=
 =?utf-8?B?dHdYSWRrU0JIMmJvU2FkcXlJdk9sYWhTQk9pZ0hIR0M0d1J3QkpjcExjYzN0?=
 =?utf-8?B?T0owQVd5My95TXZORlJyTW1FN2FBdFlmR09BUmlNSzVUWks3MmxIdDdvM3Ru?=
 =?utf-8?B?MzN5a1dSVXErcmtYNmxUOUZyN01Jem1DaDF2MUF4Y1o1K0h5Uy9LamxIZmp2?=
 =?utf-8?B?M0JiMlE4dUZWYUdrYklqUk9IYVdGNldGTTNMK25XS01zdHlkdVpKcTc4dnJs?=
 =?utf-8?B?anFrcGdBQlRNcDc2RFRGandLeTF0MjZHRHgxeExXRjgrZWRsMlRZV1c5UGNR?=
 =?utf-8?B?WnUrMjBxUG8xa1YxMUlWcGptU0U0YUVkUjgrdVI2ZW84OFJqWUdnTEVMK2p6?=
 =?utf-8?B?RkVPcjRHL0pRdnJ6dUF3azBVL0g4VEJicUVNbDZCck1ESytLM1p0Q0p2YWkz?=
 =?utf-8?Q?Mbya2oAp+lWuFBrD+smXngrHRzyB3O+2PTuC84Ya9TMVT?=
X-MS-Exchange-AntiSpam-MessageData-1: RtVEXYit71PI5g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d10363df-ef63-4386-2d83-08ded02d9b3e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 07:12:23.0735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubbpL0FRlK644l6aEN/MOq6QdsRRMbcNwcjCRAICoGQDULnD1wv35UwkTpEFECO5Kb7xytib4q0VNUHm86tAug==
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

The `Fsp` instance was only used in the Hopper+ boot path, and
consequently built locally (and immediately dropped) in it.

This worked well as a temporary measure, but the FSP is also needed in
other parts of the driver, for instance vGPU.

Thus, create the `Fsp` instance in the `Gpu` constructor and store it
there, passing it to the GSP boot as a mutable reference using
`GspBootContext`. This makes the `Fsp` available even after the GSP is
booted.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs           | 15 ++++++++++++++-
 drivers/gpu/nova-core/gsp.rs           |  2 ++
 drivers/gpu/nova-core/gsp/hal/gh100.rs |  9 +++------
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 2e76e4bf79b2..e5ebd79c9020 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -21,11 +21,13 @@
         Falcon, //
     },
     fb::SysmemFlush,
+    fsp::Fsp,
     gsp::{
         self,
         commands::GetGspStaticInfoReply,
         Gsp,
-        GspBootContext, //
+        GspBootContext,
+        GspBootMethod, //
     },
     regs,
 };
@@ -261,6 +263,10 @@ struct GspResources<'gpu> {
     gsp_falcon: Falcon<GspFalcon>,
     /// SEC2 falcon instance, used for GSP boot up and cleanup.
     sec2_falcon: Falcon<Sec2Falcon>,
+    /// FSP instance, if on an arch that supports it.
+    // TODO: use different resource types for each boot method, and make the relevant Gsp methods
+    // generic against them.
+    fsp: Option<Fsp>,
     /// GSP runtime data.
     #[pin]
     gsp: Gsp,
@@ -304,6 +310,7 @@ fn drop(self: Pin<&mut Self>) {
                     chipset: this.spec.chipset,
                     gsp_falcon: &*this.gsp_falcon,
                     sec2_falcon: &*this.sec2_falcon,
+                    fsp: this.fsp.as_mut(),
                 },
                 bundle,
             )
@@ -354,6 +361,11 @@ pub(crate) fn new(
 
                 sec2_falcon: Falcon::new(dev, spec.chipset)?,
 
+                fsp: match spec.chipset.gsp_boot_method() {
+                    GspBootMethod::Sec2 { .. } => None,
+                    GspBootMethod::Fsp => Some(Fsp::wait_secure_boot(dev, bar, spec.chipset)?),
+                },
+
                 gsp <- Gsp::new(pdev),
 
                 // This member must be initialized last, so the `UnloadBundle` can never be dropped
@@ -365,6 +377,7 @@ pub(crate) fn new(
                     chipset: spec.chipset,
                     gsp_falcon,
                     sec2_falcon,
+                    fsp: fsp.as_mut(),
                 })?,
             }),
 
diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index 771b38e6335d..ff438506070a 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -38,6 +38,7 @@
         sec2::Sec2 as Sec2Falcon,
         Falcon, //
     },
+    fsp::Fsp,
     gpu::{
         Architecture,
         Chipset, //
@@ -62,6 +63,7 @@ pub(crate) struct GspBootContext<'a> {
     pub(crate) chipset: Chipset,
     pub(crate) gsp_falcon: &'a Falcon<GspFalcon>,
     pub(crate) sec2_falcon: &'a Falcon<Sec2Falcon>,
+    pub(crate) fsp: Option<&'a mut Fsp>,
 }
 
 impl<'a> GspBootContext<'a> {
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index 7bba18ba2f75..8673a749dbac 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -17,10 +17,7 @@
         Falcon, //
     },
     fb::FbLayout,
-    fsp::{
-        FmcBootArgs,
-        Fsp, //
-    },
+    fsp::FmcBootArgs,
     gsp::{
         hal::{
             GspHal,
@@ -152,12 +149,12 @@ fn boot(
         let mut unload_bundle = Err(EAGAIN);
 
         let res = (|| {
+            let fsp = ctx.fsp.as_mut().ok_or(ENODEV)?;
+
             unload_bundle = Ok(crate::gsp::UnloadBundle(
                 KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn UnloadBundle>,
             ));
 
-            let mut fsp = Fsp::wait_secure_boot(dev, bar, chipset)?;
-
             let args = FmcBootArgs::new(
                 dev,
                 chipset,

-- 
2.54.0

