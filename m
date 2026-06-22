Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D83C4CDB46B
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 07:11:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FDE910E4DE;
	Mon, 22 Jun 2026 07:11:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="WhK+HrYO";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010063.outbound.protection.outlook.com
 [40.93.198.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 122CD10E4DE
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 07:11:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SEz9GLq6PPcUXWovGOpcGHXhQjzYCEJcc0cbZgs7XNLeBpit8LUkPSsPu4EHV+CcTsvkA2/8eTRZ4bu/CkfkKOjdM/xqmDXwo8VFDsmn72O1q/moi7kmIE2IDrLtlhQko6al86hajQZ4sGXwA3A0WqSYstz9w9w9die/bCLK9DbvEd09606Osl0S8l98Ic2AyFfp15aXw2l8Q4P9YHZ0oeINKUypAzRdctH/JdaPimDPCH7i/lmeV8OdMO7cWmE7g2k78ezFFCdVo0f4wAQHyZCQAfwi2h8/45TBGP5xOKsxapQGL9t8J61Z8jHM1js8HZ6R4/eDdWTAW68LvvCJhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0W8ubI1UiJmIAH6eS5ZLodqKhwfHng2ao5EK9YIOe0=;
 b=oIL/5qxLW8Mak9GttwB93WnvN7dVppp/QrqUTUsNEAaRWYMUBW3Bktc4eQKwjbKVx7NXAfjAJT64ZQeUy9+ktdTNM9IqOHJ+E5VS50bKPmwN3Il/8Rd6VfvvxAXdUG+YhCEKLc76HqLeAi087L2KCMxy6w2EJx+r9GViL87BkTTIIAQHaC+cQ3emN1nmaYXxP8XdxduBRHn3jAfeqGVzaX9PNY2AIR4iXvYaV1spcX/Aird2XQJ4QKDHCSO7mF3qfCI8H3AQjmEGXjVAeXOw0mruebu8nKVYr5CG3JKPpSbrLHmnH9s337wdGkie5D5kkG/RQXXCKu1hEjVUn87f9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0W8ubI1UiJmIAH6eS5ZLodqKhwfHng2ao5EK9YIOe0=;
 b=WhK+HrYOMmUN3HQwXjWNiC/WrEy0juvy+GuYKPbN0LMbpZDYCD4V5Z0BeAdMu8RJnw10VBHIIbnvCs6mDmLQChePe5/kH+m9uJHe9972/H6h+4RFlyKbB2/StmYF1AUo9DI/DW06zRl4tssMXFbqiJ4tMgNtoWFlVsGMvJAt21Z6oaneQcILDS1xM5ygbs/piJ+j7I+1rweTskj1ntOxEOPheaRubPIpgyw6g4TPLv3jSBeXg2l/y4Op/LqPCEhspP+e0Z0oEO3bTLNQax6nAvIv7bRyliOJnNBAaD8MeWGJK1v8/zWf9dM0rMgnnWHkCBEmza5uLC8qRDeQ5CjFxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by PH8PR12MB6700.namprd12.prod.outlook.com (2603:10b6:510:1cf::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 07:11:25 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 07:11:25 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 22 Jun 2026 16:10:27 +0900
Subject: [PATCH v2 05/13] gpu: nova-core: gsp: move unload bundle error
 handling to Gsp::boot
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-nova-bootcontext-v2-5-0ddeafc06f5d@nvidia.com>
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
X-ClientProxiedBy: TY4P301CA0076.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36f::18) To BY5PR12MB3986.namprd12.prod.outlook.com
 (2603:10b6:a03:195::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|PH8PR12MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: 540446da-184f-4240-c6ea-08ded02d7828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10070799003|18002099003|22082099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: LrVhOqnhsBPkuYgwUEJ7iN6/yU2ft97aa4YIxGwrtYJbuBWPyIV1MaxpAOu0IVDnfTiAQSZtDo3IyNZUnu3UabyFN2vobT9uII9sO0EygzR6DXLWq40QMNghIxRha6vmprKMh4tLydlkOSNDA4Go9zMEpKiV3jMKdgzXaIo1vsgo8ZgfiNtqoyot6bBunSLfOyF9NrCpQkq3MhsnF/V7rPilsXTwHnXQ7TqXdMWSDB63I2SE4SN/qRuBJWM4FxsFEtjQOGwEz6cTEC5nPvtvVDJeMRA8ysZr8NS6i2JaiQHUcVtA2hQNi//YjjIa6Igqi4bA6cUDEBxXIBJUhnKGL3gONSORxQTE5ApKpvWTFg4PBghPItjHyG7JGxome7ZV5acN7hRPr63o3711ZvJ0KjUwP9nlVBTsPJEyB5ohxttWutxfvvNRP2TsTcSCTaxZg6lYvRwHqpGKWXCKikspLlodkXeiAy/iwih14dAMeTVSbgO1DC4PDg5u4aeNCQbxtrZUJsMXmwU6JQ1qNHyWVsEL3Kzi9oJnQc8CA64/yBDBsoir5zNX74x5p1e3RKkoY17yMk3csHjPDTbhm1VS6YKkd7Y9Cyjydmo0aJUKL0qJ2WGJ2bzuPzLvW/S8tkpCzMcwxPelzB5lQvtH7Q7lnFYGivJjMREmeMe+m8963D4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10070799003)(18002099003)(22082099003)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFk4NjdUMUhiUGc3eTdBMWhVMHFZZ3VoSGxmYlpkeUlld2dWeWtZaW5yaGN5?=
 =?utf-8?B?ckdmMEw0RkNGMVN3ektsWXBYSVFoakxQQU8yalhnWDVyN29ab0VZNGZxVXFP?=
 =?utf-8?B?UkZtczdCUTk1aUV1TWNXdUNjODg0dFZWRVBwTVp1RFhNK2c1NkxsV3g1Zk9C?=
 =?utf-8?B?UzlNUmttSWs2UlpiV2JObnNGNUpRNzVZYXZkZG8veGUwcFh1WVVkVU9WSFRB?=
 =?utf-8?B?SGpzSzRlSThtZFpJdEVrcjR3Nkg0Y1F6eFQwMUpEUmh6M3FsVGRYM3Y2eGk0?=
 =?utf-8?B?WXVuT1RmWURDUSs4YTZtVVU4Q3dIV2FvZ1AydnNFbUpjcG9UbDI1ZkZNakgr?=
 =?utf-8?B?clA2VHA4YUZaRTlud2VObDdXOTZBY2E0V2c0WkYyT0prMUYwQ00wRU1xOUNK?=
 =?utf-8?B?YktJTjBHK2JYRG9Ya3ZMWDhvbmh0TDZoelVHanNvTjExZjlkaWhNaDlmMlRU?=
 =?utf-8?B?Q08veVJVVjJXcFdCTDIwTG9hU2xMdEJOb1pGRFhTRWtrQ050ZjhNeWNlb3l2?=
 =?utf-8?B?aVFVQk5LQjJMVzlNTENKMmtnNGNYU1lVYWtpTW5LZW9PVmdXQVVMdHRXWEhG?=
 =?utf-8?B?OXpQSVYwWTEyMHdYVFhxbTlqT1ZkMXp2SmtIU3NJTVpDWDVNV1pkN2tnL3Ja?=
 =?utf-8?B?VXdWS0hHMFc3RlhuQk1ubm9sb21TOUxsNFRWbktRRnlxYklvZ3RHV3diSzBX?=
 =?utf-8?B?cWIyNGVWdXIreHA5NTBWR1dPTU1kSkN2Z29SSzRuV0x3U0dEOVZBZnJIS2p0?=
 =?utf-8?B?U0doblB5RFU0UjB4TGk0SmF2UjltQzIxN3AyRE50bmg2bnE2Y2RDZHRsWnN5?=
 =?utf-8?B?N09VWmhZVnBSdDg3cGF1akRyRkZuRTBNM0xRdWhIdWx4TnFyNk1GTWtZNjhY?=
 =?utf-8?B?N3ZmYjUwbkxMVUo4TXRFUnJUV0crOWM3blNTWk1lc0JWNWF0M1NoYWdvSXNV?=
 =?utf-8?B?UjhvUWF1RkNQb09KbE94aTJYS2xJU0ZEenFzTmJZYjhnSmRGT2JOOXdrdTkv?=
 =?utf-8?B?UUx0MHkrK1dKcDB2cHJKbmRpSHBWNnlvdzBDckpDQXBOK0NoU2pSUHkxdnE5?=
 =?utf-8?B?RWJtZmYzRW1Xd01SU091MEx5REJHa2FobWlmdXhmZjlNU1lqblhacDlSN0cz?=
 =?utf-8?B?UFhPdGpQRGR1TThNcHkvUlhlNXp5RVJxM09HWlJpU1VwcnUxdnYrYzZTekRN?=
 =?utf-8?B?ZjNkZVAxVlZNZkc3SUJQT29JZzFQTWo5THZXa2l3bnBQblhmeXR6WHFxWTlu?=
 =?utf-8?B?TU5OSzU5R3NSTTRHb0t5eWVHNGhXWmlNVFNtRTV0NEk5ZzVQQStyNkN3Y3Fr?=
 =?utf-8?B?OE9pSW9hdVgwNUlQdTd2elJ4cVlWaFZjNGNMMlBIWjVTeXpNZDlENmN0RnIy?=
 =?utf-8?B?bzFZQ1FTTzNRWHhpT2xQNmNOZHVWNWhvTEhqaUtkdStUL0Z4YlBTNFVnNUpK?=
 =?utf-8?B?Vk52N2ZCWFNneU5KYjVHdnllcWtBWUw0R09Tei9QV1gwOFE2Y0J4MzBlcGUr?=
 =?utf-8?B?ZVkxMUhhZ1NaNnJXYVVJbjhTc2Y0eUZqN1pDVkIrbFFEaXJHbWtQQ3BkWVpu?=
 =?utf-8?B?UitjN2QxbTFDUisvY0VsYi9pdUZEWjI2SE02YWYyemVRaXJiUjFoMEhnQ3k1?=
 =?utf-8?B?M1NkUFVkWTI1SS9ra2xFMVlZWTlicWpiOTNKZUpKR0MyaDlXanRnOWxJOTJY?=
 =?utf-8?B?Qmk4NGY4UVRKOWUxT3gyQ0w4OUtJbkxRakF2NUpZS3ZzU0t2VHRJYktZTUx5?=
 =?utf-8?B?LzlsZnZ4VG54a2RrUnNrVGZDaERvQXF6UlBMajhqcjhXMUtCV00wRmErL3dW?=
 =?utf-8?B?SEZkOWplQjVFQUViTVhMUFdzeGJZdS9ma2dmYUUyQ3ZWY1BHRU1DQlp5eXA1?=
 =?utf-8?B?L3liTzA3MTFUNzUyeGFyTUdHdjJ5eHlRanBwL3pMVit6ajIwYzRITmVicVA1?=
 =?utf-8?B?Y0hLREUvWFNlVUw0TVdPaHNTQUE0VmtPVFZzbDZ2ODdWVXJBeXV1bjBEWTdY?=
 =?utf-8?B?eEVQSmVtdUhxb09xb1Rld2lJL2V2Sk4yRHEvdXdyaThCOVpaRm1XMHFnWmh0?=
 =?utf-8?B?K08zK0Q2N2M5RUhySEtXeUliZVlRRzMrUSs1alh2RjlPbnBpcGlDelVjOVUx?=
 =?utf-8?B?VzROU0xOaitPSklyQ2dqaXQrcTZ1cjVjcW5vTGp6QmlUN3ZnWGFWTkV1RjdK?=
 =?utf-8?B?ekRFT3Z5SjlBMHBHQ0RsaU9hbVozZGZIK2NvcTQza3JOSjRod1MxMi8zbWtZ?=
 =?utf-8?B?WHpMN3I0eXh1a0s3VFZwZitWRkFHb2tyK2g3ZkdjVWx0U1lMOE9lSDJGUm1R?=
 =?utf-8?B?SHpxc2RBYlM1ZDdXaGtUY3VjckJrYmhvL3F4SFNJRXI2TGNEVFRyQkc5cmp1?=
 =?utf-8?Q?J/vv6Kqelh8cNwc7eHKcfAgkhRb34vIAMgCqxy1LReraO?=
X-MS-Exchange-AntiSpam-MessageData-1: /rsTtt1PRDdoNQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 540446da-184f-4240-c6ea-08ded02d7828
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3986.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 07:11:25.2283 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0jPL9+SEPGVZzQu5wXL3h9cvKPN7/etEX6+aQ3Hvgc4efU3VrlEX3N9vLn97zuEXK7J6FgPD8Q7b/e1fzCC2og==
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

The warning emitted when the unload bundle cannot be constructed is valid
regardless of the boot method, but it was local to `Tu102`. Move it to
`Gsp::boot` so it applies to all boot methods.

This requires the HAL's `boot` method to return the `Result` for the
unload bundle's creation, so `Gsp::boot` can display the warning.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/boot.rs      | 12 ++++++++++++
 drivers/gpu/nova-core/gsp/hal.rs       |  4 ++--
 drivers/gpu/nova-core/gsp/hal/gh100.rs |  6 +++---
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 13 ++-----------
 4 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 3574f1a87344..3f11eaec26c7 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -59,6 +59,18 @@ pub(crate) fn boot(
         // Perform the chipset-specific boot sequence, and retrieve the unload bundle.
         let (res, unload_bundle) = hal.boot(&self, &ctx, &fb_layout, &wpr_meta);
 
+        // Display error for unload bundle if any, and convert to `Option`.
+        let unload_bundle = unload_bundle
+            .inspect_err(|e| {
+                dev_warn!(dev, "Failed to prepare unload firmware: {:?}\n", e);
+                dev_warn!(dev, "The GSP won't be able to unload properly on unbind.\n");
+                dev_warn!(
+                    dev,
+                    "The GPU will need to be reset before the driver can bind again.\n"
+                );
+            })
+            .ok();
+
         // Run from a closure so we can retrieve the result, and run the unload sequence of the GSP
         // in case of error.
         let res = res.and_then(|()| {
diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/gsp/hal.rs
index a76be4e43272..00e39cc1fbde 100644
--- a/drivers/gpu/nova-core/gsp/hal.rs
+++ b/drivers/gpu/nova-core/gsp/hal.rs
@@ -53,7 +53,7 @@ pub(super) trait GspHal: Send {
     /// Returns two things:
     ///
     /// - The `Result` of the boot process itself,
-    /// - The `UnloadBundle` to use with [`Gsp::unload`], or `None` if the bundle could not be
+    /// - The `UnloadBundle` to use with [`Gsp::unload`], or `Err` if the bundle could not be
     ///   created.
     ///
     /// Note that the two returned values are independent: it is possible for the boot process to
@@ -65,7 +65,7 @@ fn boot(
         ctx: &GspBootContext<'_>,
         fb_layout: &FbLayout,
         wpr_meta: &Coherent<GspFwWprMeta>,
-    ) -> (Result, Option<crate::gsp::UnloadBundle>);
+    ) -> (Result, Result<crate::gsp::UnloadBundle>);
 
     /// Performs HAL-specific post-GSP boot tasks.
     ///
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index ece40403b831..02203dfd3584 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -150,16 +150,16 @@ fn boot(
         ctx: &GspBootContext<'_>,
         fb_layout: &FbLayout,
         wpr_meta: &Coherent<GspFwWprMeta>,
-    ) -> (Result, Option<crate::gsp::UnloadBundle>) {
+    ) -> (Result, Result<crate::gsp::UnloadBundle>) {
         let dev = ctx.dev();
         let bar = ctx.bar;
         let chipset = ctx.chipset;
         let gsp_falcon = ctx.gsp_falcon;
 
-        let mut unload_bundle = None;
+        let mut unload_bundle = Err(EAGAIN);
 
         let res = (|| {
-            unload_bundle = Some(crate::gsp::UnloadBundle(
+            unload_bundle = Ok(crate::gsp::UnloadBundle(
                 KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn UnloadBundle>,
             ));
 
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index fca8da281e16..984716fc0bf9 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -269,14 +269,14 @@ fn boot(
         ctx: &GspBootContext<'_>,
         fb_layout: &FbLayout,
         wpr_meta: &Coherent<GspFwWprMeta>,
-    ) -> (Result, Option<crate::gsp::UnloadBundle>) {
+    ) -> (Result, Result<crate::gsp::UnloadBundle>) {
         let dev = ctx.dev();
         let bar = ctx.bar;
         let chipset = ctx.chipset;
         let gsp_falcon = ctx.gsp_falcon;
         let sec2_falcon = ctx.sec2_falcon;
 
-        let mut unload_bundle = None;
+        let mut unload_bundle = Err(EAGAIN);
 
         let res = (|| {
             let bios = Vbios::new(dev, bar)?;
@@ -287,15 +287,6 @@ fn boot(
             // can be probed again.
             unload_bundle =
                 Sec2UnloadBundle::build(dev, bar, chipset, &bios, gsp_falcon, sec2_falcon)
-                    .inspect_err(|e| {
-                        dev_warn!(dev, "Failed to prepare unload firmware: {:?}\n", e);
-                        dev_warn!(dev, "The GSP won't be able to unload properly on unbind.\n");
-                        dev_warn!(
-                            dev,
-                            "The GPU will need to be reset before the driver can bind again.\n"
-                        );
-                    })
-                    .ok()
                     .map(crate::gsp::UnloadBundle);
 
             // FWSEC-FRTS is not executed on chips where the FRTS region size is 0 (e.g. GA100).

-- 
2.54.0

