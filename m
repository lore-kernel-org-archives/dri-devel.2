Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555F4CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 13:42:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFFA610F5F8;
	Fri, 19 Jun 2026 13:42:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="PD3SJqyw";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010045.outbound.protection.outlook.com [52.101.61.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC58A10F5F8
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 13:42:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mj14PPEqMY0RhbfCEKaMFPTN0ZXE3/JTOYzoNCL9CRwWvukOtV45y59qi/7GHdNW8Qh5tHvibBmjCcyN3zVDhmx0l+wU+kjKjouLIRjfbQK6bMLDlkwIojulnxmGtDUY+6qX/t1Ms1pslVYGMfZOsFGeIRuGLP0wuRKd9kb5AhUj2rw6St1sg3+0UY9w0RICfUCnk2x4kogrTB1JYBy4tBFPeXMGPk/ODZ1zAqUyzpWq5LiLkQWyw4X3+CxsQldJP9cPDMDUyzEohJF8Q2xBqUq91Vspxt287neJV9tEUT4nycP8TmMGqlS4Zm4nXh6jNhi5GKGKKEFMXm1hDLcXOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TywFwxI0B9oMETHTidFog42WHgnJ7yrhzBxBKgwDCDo=;
 b=KQ0gTnOxGHUJEqn/zo/L4tGDdbWzDe7XLP+YYjd/+z/yYa6hPoUk5kN5v6Eb7CYAVorhoJ2+WZLrn6/fcfKHx7HztxoYtPV3emgUW76gBJ7LHrONtgfMiehbs7T1QC/B+4vDYvbywHir0K9DAjbxki9nzqTG0cO+wiSJKl0sSjjJJs2+9wLbSiqHThHxk88mw2+rcKP2/J6jx+SdSSd5WPyDyeRSogDhAUCARgs4DL7hWZCN9tzWUgRdIatU76ajkN3wn7jNeEyGXfGIzH1wufof10aEeTnoD7HSCzTffD0KoMrBn7N0b6Obw4M18OOTlKBJ2QxYEc+AXsEAmqEiuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TywFwxI0B9oMETHTidFog42WHgnJ7yrhzBxBKgwDCDo=;
 b=PD3SJqyw2yH6IRqTOqU7k7gXyKQOCCugBGUYL0SxaEQ3viywj7zieITjQDac8CBcfjQi/BSObcJhV4WfWDKIwnXviUNcNYe7eOb7Ii46pP0GkXIa57iASQP/AEN3RH3KIeePBtcC+ejpF3FEBPPsIuQ/46oTp3myhvMEQMQtbMu3nblCfy59W+8bTYcUhAm1TtCUR8JxuYPpvqs2CxhWAdr+69qb93vnvY8SDCdjDfhaf9yx579s8719aCllJYPV/F1U2BZVSMSz3R6tSbdhNFDFBBMTXuuas3vtBPT71oTtLGDLQA+3T+Atp3wyOCDBLxQYx3ZiDXWz4WJXK6Dy7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA1PR12MB7367.namprd12.prod.outlook.com (2603:10b6:806:2b5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.12; Fri, 19 Jun
 2026 13:42:48 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0139.009; Fri, 19 Jun 2026
 13:42:48 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 19 Jun 2026 22:42:20 +0900
Subject: [PATCH 5/6] gpu: nova-core: gsp: move unload bundle error handling
 to Gsp::boot
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-nova-bootcontext-v1-5-45193cd0a2e5@nvidia.com>
References: <20260619-nova-bootcontext-v1-0-45193cd0a2e5@nvidia.com>
In-Reply-To: <20260619-nova-bootcontext-v1-0-45193cd0a2e5@nvidia.com>
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
X-ClientProxiedBy: TY4P301CA0018.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::16) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA1PR12MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e60c446-339f-45fd-934e-08dece08a645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|23010399003|1800799024|376014|22082099003|18002099003|56012099006|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: nQ6ySP4nvl3H92QGIjsOfyMTtw4Iuce4giTALLo9STVtMk9LAKDMYc/GnIHQJgnd5npuT2Xxqmrt9oNK6VlZjG/5Pk7tbOwtSNrYTe+pF0AGz8Bb+VPOMck26RxzUd/9x6kuoHpAlqUT+y9CGsIm9OtJwELNaSWTiu/JFx9eudkuhkQz3+v+aX0I4NOYSufQwQqpsCxidgucaN2v2OX5vVyWGipMx2mkde3LMwHWtsZumcjmdikntrydnk42h38nuoFbVYaVXkxNtAZ7uHdX2cjQf5Gd1FwO60ruP4/xVSNEIZp2ef45Oq/LsDgSZ4l4eVeuf5TWLWnd8DyBex9QYtpffvurwUm1/xEglkzvE+2Ix3XtphXmqXGCIheAqrb890NR3SlAlrEmtiQUR56qvwBLCMTS8DzxqY1WH1umNA26iqS+6LTdh0aSJonuuPnZY/rQECxqaa3TM0EcD9F/zeVRAgcNg0DJybTo+JU0atmbIuug6AeMpBE3PXHW/xUGBcPYBjzodvYc334JonYoxxGrKj14iiphorULt59GQIm+vFwutP6eniLSt5iAQOx5aVNQxCrRICkQALo8PqyajUt3G2302s6/KrI+yeb/sAfLH3vw3/yTHlCgi7r/DCB58tJG/H/RmIjqgkxptSde73OtLidnSQUgQ937WAuIxA4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(23010399003)(1800799024)(376014)(22082099003)(18002099003)(56012099006)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bk5haUVuWkpURi81VE1ScUJpdDA4VExKbGE5UXhVOUswbDQ4S1ZFWVkxQ2Mx?=
 =?utf-8?B?dU1oU2tsYXZ3Uk1ZNWRwSVdSWnRWdjErNnN3WEpBOGQ4cjAvTmJTUkY0b0Ex?=
 =?utf-8?B?VmNwUDkwbmxGSWRNbWNtOGo3QkdsdENSaytQTzlGRXgzL2dmeGdGZVJmcTRP?=
 =?utf-8?B?bSs1UWhJMDkzZUFLd1Q0bFZTdUZjbWowaHNza2ZyOFY0OG9NVDlzYjZhRytV?=
 =?utf-8?B?eS82Snd2NEhQYVcyZndkWnh5Y3RnUzViWWFRdzY3eHJ5ZVlNdWZFT3EvYzdP?=
 =?utf-8?B?Yi9tUTRsRVlhOVhVdFJVMXRkcldXeUxXbnpObjE1Vzk0WkJvOHliMksxK1Zp?=
 =?utf-8?B?ZisrNVdVYldERUtLS1ZuSnFQMUVYL0cybHJwT0lVMDZIUzJ1bEVzdVk3Vyt4?=
 =?utf-8?B?VFFvOEx0dWVQR0doYlJ3NUF0SkJIY1UxdnhnOERNYzUwK0x0MmI5NU1jUkMx?=
 =?utf-8?B?VjcycmtmTUEyamIxRVkrSEFrNjF4R2l1cElXbHZCcEsya2JTdG9NcEpQeEZl?=
 =?utf-8?B?em1ma1dNeUFCQlhMNU9QVGs3OGxKWCtrVG5SZzNRcW5nQ01xSEVveEUvdlZI?=
 =?utf-8?B?WUh5OTJkekYyeVloYzRVVHovSzg4YlpNZmlabHFDQ3JqVFZ5K0xINWIxQUo4?=
 =?utf-8?B?WUJGRFNONG4xK1k3TVdwbkZDWVlDYVFBRGxQNGdhL01sTUpKQStObHNYOVBy?=
 =?utf-8?B?RkI1WVBLamZEajR4OThVUnN3NHZNRlJQTnhOOXhYNXY1b28ydm5XRkN6UVVh?=
 =?utf-8?B?azlkVFN6NTltY0crQUhhYStCdlBBTFVnZ3M2K2N6Qzc0WVpucDFrTHZkblRD?=
 =?utf-8?B?RVF4d3MvaVFDdTJROWZ3ejFzT1RZdWdCUkNUdThheTBHMDdhM2lZZDBDSE5x?=
 =?utf-8?B?L1E2VXh4QU95ZHdFaUZublF0ZGhHVmd6aWNHNVVLVDlQdWFHZmlGcllVL3pl?=
 =?utf-8?B?MDQ4VEJwOEkwZ2YwbTVWS1p0UjJ2Y1p2Wm9seXRSc1BYZExPdUtIbC9aSWda?=
 =?utf-8?B?UXI3TlUwRmdvWFE4ZXdiZDI1MzJPeGE3QXExcFIyZ0FJTVY3WVUxcVhZalN5?=
 =?utf-8?B?am5NM2VtckwvZG1sVjBYT2VoWGFiY3pJZzBPdmdZSm5OT29EMjZxUjRSaGV0?=
 =?utf-8?B?U2N3NEc0QXV0eWg3dTVsU2VaRm9uZWVFajN1V3A2U1hSQVFuU1NJc1NlWHY3?=
 =?utf-8?B?ODdsdXRMbm1IRWhPRXc3NEJ3MklSUFArY1UrM3R5S0FBWTh3QW1rMml2Zi9H?=
 =?utf-8?B?SkROcDVnem9aUURjdGkzL0VweFZ5YmpRT0ZQanJmQ0NFUXltQ0V3NzhEMWIv?=
 =?utf-8?B?RGR5TXFhWWUxeWxFRzlyMkdmcVlpbWFTc2hHMlVScVNabG5JWE1rdUxpS21x?=
 =?utf-8?B?VVQ0R3J0QkljYVVxdFBJVmQzdnpid2w4aDZDMzBzQjRxVEF6S3lYM1gxZXQr?=
 =?utf-8?B?L2F4NDJ3Yi9kQnh2MWtaeXcvYVc1S1JCK2ZoVTY0SzJsazhCUTl0WkxiOHJ5?=
 =?utf-8?B?MEp1VnJyM1pjckFBb0JjdlBHRW94Mys5SzhnMDZvL1dVK1p1Y0NESmFiakc5?=
 =?utf-8?B?ekJOWDRhRkNZRDJMZ2pVaURWVmF3cThWR1NPWnhIQUd6WWJ4QmNHQVVuK0F0?=
 =?utf-8?B?QUoxMXJ5VC9hc1poL2tCZkowekdJTWc2Y1ZkQjFLcjZaYTMrM29DQ0JoWjhv?=
 =?utf-8?B?bVI2UFBackNWUVUwRCsyMlFXTXBrdTFVeEpPVXdOVnBXeXlmOWFxN3U3eWZj?=
 =?utf-8?B?a05VS1dwVXZVLzVCRE5hVTVDV29TYlJmNExIRTVxajZhR3B2MHRGY25lSTIv?=
 =?utf-8?B?dGhSeFJ5UkduR1o1ZDAyVzB4ZlJyZjNJN3BNaHMrdW5NdHpIbDRzeUwwbTht?=
 =?utf-8?B?U1NHb0NIMFVSL0JWVFhwWDBwU2toS2p1eG9KSkIzdGdZQ1RPWWp1bVZ4R1BX?=
 =?utf-8?B?SVRaZ2hscHlXQXdvM0JpKzRiVWFoN3I1dXJUdHI2MUxjNTFCR3VEUkJPazl6?=
 =?utf-8?B?MmJLSFdsSk5rNGljOUlWWCtvcVJQVTZ0dGw4ZDAwanhBSTNreUtIOTM1MHVG?=
 =?utf-8?B?N1ZlS1RndkEyUC9wZm5QV0Z3NUs0dHl2QXlpN09ub01QZEgrR1lCTnRFSllr?=
 =?utf-8?B?eXR6R0czVTA5c1BoZkt6N1ZKR09mYjRkeUdwR25XSnNrRTMxUDQycitKT3Ri?=
 =?utf-8?B?ZU5lMUhqRHhUcGh4SURqMis3dG8xYnl3Y3RZazBIN3lzK2FRVlc4R1BhTkp4?=
 =?utf-8?B?cXZNeVQ5dmRLNDdvQ0pyN0ZaOXZVenE2eGhtMjlXNFY5MjdIVFVzcVduclk0?=
 =?utf-8?B?WVZPSWZwVUJVQ215VlV3Y0NMS1oxS2FkYmVCb2lTKzQvU0l4Q1NkS08yenZj?=
 =?utf-8?Q?vE7cLclYB01HHHY0yODi8qE2Yrk2dZcDEtUmoBSfrEd/x?=
X-MS-Exchange-AntiSpam-MessageData-1: ySMydywguq79nw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e60c446-339f-45fd-934e-08dece08a645
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 13:42:47.9183 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qEGxNS5L4tM/fzxwoJUp+Gjzr39/EZOat465C9jNyfV4C3PpDoo3ajJz7khfTMupDScnZCEq6UtyN2tlnmGA3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7367
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
index 3ed2433feabd..58cef3859d49 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -154,18 +154,18 @@ fn boot(
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
+        let mut unload_bundle = Err(ENODATA);
 
         let res = (|| {
             let fsp_fw = FspFirmware::new(dev, chipset, FIRMWARE_VERSION)?;
 
-            unload_bundle = Some(crate::gsp::UnloadBundle(
+            unload_bundle = Ok(crate::gsp::UnloadBundle(
                 KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn UnloadBundle>,
             ));
 
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index fca8da281e16..4cc140d08370 100644
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
+        let mut unload_bundle = Err(ENODATA);
 
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

