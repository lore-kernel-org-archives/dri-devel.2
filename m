Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FB6C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:10:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0285A10E90A;
	Mon, 29 Jun 2026 14:10:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="AnmDIuGV";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010022.outbound.protection.outlook.com
 [40.93.198.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D19810E90A
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:10:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=okxNP8YJgsWhBu0aabfCeKHs0O9vPW8Zj4IGM2MjFKJuo/ICpHVl/8yFnEFK/EbbmBWG4msRruTpDuqcFq/XNeV7dvvWpIz15xd0grYj31/e4MQRkwqzIpEtfKKW27JNwjvZYITmWqlJEt1YgQhmJa+k+K+k+rd54P6vCuBazayuhtA9cOn2xS3IzRbTL0hx+EnfQkWGkc+0k55/SqVdOMVBD8ACUNXQ1tHso7uguXZFs3v4QqtIhIS0yLmW6oxYa9AlXuhzRyPw54cXscBIER8tI4Z/1kK8zfvOoglnSImCZOQ8G2WwnMTiwJ4WUUWrfPFKdt+JMmrJJyBnumKB0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0iMrkbXrS2IrALEc7rWDA816UdnacluekKAMMMbUa8=;
 b=XDaw0U6kUx2aRjtIQc5R0GxggLJaCEChblvlL4wIqjgsi4lmdZXBPlQyX6ceKL2PORvT1i2uDy45MXn/GzlVT4sQkVETdiyj5Kv5kmiiI1mbEzRDAkI+wOcl7H4KlVL2U9CiG63jeYrZsrAYEL1EfFqDNBi4CJzOSQIRfW4f5nKQZCvWjvEuVGG0vFtGBgyvhGlHPY6yNuP/PpJqET67Daaze+pveIIsH801B1vFVtJGKFv8SNeQ5wECoq7MIkT4PX3hoS9jN2HXUiRR3x8NbkZ3+N+0Cswl8MNuJo/aDGxnvrN1i4wNnh/84FsmJjpMLFuyR9+TGRFQTzHrWOGNCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0iMrkbXrS2IrALEc7rWDA816UdnacluekKAMMMbUa8=;
 b=AnmDIuGV4inwqUW5IfhmEPmWiQ4y5LGWrdWY7a8FU37t8ibnt8t8w9oz6eQdvGFeuV7Iif4brQ3Wi9K4vi+s8xDXU6FAzHH/ZhLFQEOyV1X5SY+Tgz95ordCwlNeL3TTTYJ3X9GBI9ojgJyacnXJfa4gIPDEKCMQm8orrmaMSpYr1lnFvqsEZ942n165P03LgY8/oY8Q59WoACfdDlhAUHiOt435j42vkkIbmeNQA31iIM/QGYo0oQKLdU3O8FgBrkFblNdfvixNsA2hnm83QudxqcEFxtsVweLKrnrFU1qL/YJDP9QjHC35AHWZ8P8xm5GC4RHxk2cvXIrQe30urQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CYYPR12MB8654.namprd12.prod.outlook.com (2603:10b6:930:c9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 14:10:32 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 14:10:31 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 29 Jun 2026 23:09:43 +0900
Subject: [PATCH v4 11/13] gpu: nova-core: gsp: pass GspBootContext mutably
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-nova-bootcontext-v4-11-5539d8469590@nvidia.com>
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
X-ClientProxiedBy: OS7PR01CA0183.jpnprd01.prod.outlook.com
 (2603:1096:604:250::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CYYPR12MB8654:EE_
X-MS-Office365-Filtering-Correlation-Id: 748bbb3c-a1bd-4ab1-68fe-08ded5e82dc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|10070799003|1800799024|23010399003|3023799007|6133799003|56012099006|11063799006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: vkoOucig8AJqmCB7I+YWyIpYMopU9bO1dH7z5VFBP+UYcOqv+mRlyiT+QqvPk7Ens0QZ2fgXExw/gi9Bh94mwEyxCkMjd+Xsn1P83rxL1IVh+/nU5ILfbegj4/gW9EhEV3huChZ4qenbGYn/hJiO3bfmvmQ2VYSfYgJqMv6e9Cwtx9MN/sWTZpYfqp/OBj2oefwOomswDYYJ2f9Ir8R4cCsvC+CNTQgP7znKzorW3991ER5M6OSh4sUOIym/TL0Smjo1Mv2UamrhT/N2FzPGbTwMcRYNkjhxStXhe6+5TmBSw2tVYxhVoU0BrArxibzG+PpU+n/68d879s7kgrGVYra0GITf5jj+qzI2ReILbN9slJ4n74VVdQW7ddrcw4scOTcn4tQNAqjSonAnzlZlTIYhgGca7ZWML0jVWUTUkMXihCkJDDZtnFtAh6J2H9t4kh09V49nm8hHUg17YmY26kdSUL0HRhgQOuVIYOo8cPR3WfM3h0ISfrMcxbvGyIl9KwFHysevvcWOV8JEEvtDyAB5udz68cpeqUf/dwe0KvIcUcI8JpY6Ul1J4aTn1pLjLc2ixDN0gtqxmH7jVNu8zrBopxsXKQD5DEBq1O66FIM3yBmF4tunR+dPnHn5xLhV9whukV4De6f+rHtvcPH4T4oc0SQ/bIkeqclykGRcOULEoKub0YFa1PGd15tces1e0bspWAB8UUPpv1JsbNyURQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(23010399003)(3023799007)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WktaeHc1RTRvTGNiS25KRTBYdTRHTTFhbFlGTDBRNlBlZzZib0pIbW5pK0pu?=
 =?utf-8?B?cmtaNXd0dEVhQU9aWkI4NndlQWhCTk5ZNXUvTXBNSkM4V3pLblg3RlBIVGI3?=
 =?utf-8?B?dnhtalhYMHIzeWtkUDI5ZjQyRUJHNW1EY2Q2V1dEc0RBQ1R6cXlFSEYzeXBN?=
 =?utf-8?B?bW5CRDRUWGlVSUU1OWdFSlpHMDlEQVVBcFNTZVorTklvdUtWM1pUU2ZnOXFh?=
 =?utf-8?B?QUpDRVdCOFJCVVI2L0Fsb08rSzYzVEVFa2xUTkRPZjdNWmM0MGF5R2JJOTV2?=
 =?utf-8?B?MkpNSTRtZGEya09PMTBUSUd0K0lLNGMzYVJ5d09mVTl3K1JWK0I2Q2NncCtJ?=
 =?utf-8?B?U1c0R202S1p4cklWbEJhR0kwUUVVeDhWUEc5U1crMzJ0azhxMlROc3pGRzRw?=
 =?utf-8?B?Y2J3dEloZHhadjNXeElSR243NnF0QTVzTHpMVDNXS3R2a25zOWxIMDJrTHFG?=
 =?utf-8?B?ekprb3krSGJGWXNqV2ljcGo4ZGxWYkpwRXlNTHFMUG4yRnIzbmNvVnduMm13?=
 =?utf-8?B?V1dLdnNDTW5TVGQ4aElNUUoyR0FLb2prRzl0bTZTcFZrMmsxQlV0NWxnc1Rh?=
 =?utf-8?B?T1lZeVNLVXRmM3R1UERjV21oV1N4WmpiRk44TnlRUTdRVEt6ZkVMVy9mUGRY?=
 =?utf-8?B?TGpZWGxKdSsxaWdPd3ZFMGx2UUdnZ0V0cUZ2cEtmTzY1M2hWeER6MURkYlFV?=
 =?utf-8?B?dWlvbFhmbDEwazIxVmFEVmNxcDRPRzV2eE1LMlNiWEdYbitBQjlWNXlrK09J?=
 =?utf-8?B?MXVpbWFienFENmQvTlZCOTFZejBwSGI5MzhncFlibnNDcFdRYW9wTFZOZjY3?=
 =?utf-8?B?ZkJrSnJoYVdhd3c3WEN1SmJzY20yUmg5OVlFR0g5U1dibUlEQm5JNUluTnBB?=
 =?utf-8?B?eTcxK2NpNEwyUDZQcG12SS8vNVpXZWFjMVVpamQxd1V2bWxjMlc2cmdQdHJs?=
 =?utf-8?B?enRBZ3JUR1RiL09Yem9jWmVGbWNuQ2szUXhLK0gxTHZhV2k4eXRVNVFmNjVG?=
 =?utf-8?B?UGdQYTlPT2NVUEFkRjRWdEtId0g4RTNja1ZDYU9qUXFBdGxVdnVOQXg4Wkxz?=
 =?utf-8?B?MWpRU3BEeUd5aE1TTUVBbUZpTkdRRCtzVWlkRzdaTXZwRWhMbmsvaGYzOU5r?=
 =?utf-8?B?c05sZkxpTExFMzQ5bHR4aHN6MmNya3JhT0t0STN4a3NIbTVCck9BdGR2SUZt?=
 =?utf-8?B?QzN0VWVJRmZ0UVBOWjhRYlBKZGFFeUUvQXRPMFBMb01ONkdKT0NPMFhaVzUy?=
 =?utf-8?B?QzJTNUdvcldEL2hFeHVNeml5dFFwZzNNVU5EbFZ5c3N5VXNrZU82WFk1Rkc5?=
 =?utf-8?B?Ymh4aXB6VXd4Q2V0Y0VFUy9oRU1NUUJ0Nyt6NU1zY2JON2JkSWRMNERYSDMy?=
 =?utf-8?B?K2J5eHJNd043NU9TWUhabXg5MDNjTktQN0NyanVVMVoxekxOcCszZE1YNE5B?=
 =?utf-8?B?Z0dIYXhvczNVcHd3NXRScHJNWE51QnAzVUpINW9PekFrUE83WUFza2VDakl1?=
 =?utf-8?B?MTh0c2EyVG1KUGw4WGFqZDQ5VGVSRGJ0SXllcE8yNUx1ZHhqemNkQWFKVTdF?=
 =?utf-8?B?ZjVvdER6ZEZzSzQyMjB0Z3lFdUlvN0hHd1g2T0thU0JFd2lrcWpnZXNOODJL?=
 =?utf-8?B?eFVYajNlL28wdU9jb1FaYy9KTTJreWVtLzNzYm1NdUNIRzdvNlpReUlMU1h5?=
 =?utf-8?B?ZHpXaUxpNlJsNjlDVVZxeGIvV01SZEh6T3B0eitlYy9CTWRRSUNuYS92T3d3?=
 =?utf-8?B?all3YXdqbWNuY2ZKN1k3Yk1mVHNRQmFPK0p0MGx3d2ZZYnlZYTRoVkdNQkFq?=
 =?utf-8?B?a01udy9GVjM3MWJFVGJOeFBmbDV6Q2NNUXl4Z21ueUEwTXZDZjRpdFdXZWZB?=
 =?utf-8?B?MWlHbjRnR0NUVHcrWHkvSEVOSitBVXNhQVRVa1ZPN3lBTWs4UmNEYkFvcEZn?=
 =?utf-8?B?TTNZNHhnWWt1YU9FRkkxUVZEeWRzN1ZFVUlUNDB3QUdhZ052Vi9yR0pUaHpu?=
 =?utf-8?B?UjROSW14amVuelhCOFlYanlvck0vK0JJWXpaRHByR2tzZkVZc1JzWWhsNURO?=
 =?utf-8?B?cldRMFRwT0FNRHR5VnI3M3JDUjc0QUZNVXJHU3dTU0o5TzVTZmRFNmFvbHBY?=
 =?utf-8?B?ZGZjZnRDbEkzRUFLSGw4NHl0KzVLUVI5Tk9oZmJrQ0w4dDFVUGs3cDZsTFli?=
 =?utf-8?B?dVlLODRoWXBKRjdNMTEwV2dmUUZGSkIzeE05MEpEa25GeWljVXFQc1IyaXJC?=
 =?utf-8?B?WmZoUzF3bzl2ZnZMOHZxSURGUEdvbSt3UWZvTUN6VDZUY3lhdHRRUldIYWZj?=
 =?utf-8?B?VGZyNVFoMDljd0NxbXBXTTJXUm1wQ2Y1SFJ4QTRPRkx3WGV5SSswTUxlbFp5?=
 =?utf-8?Q?V0ZKBF0shHpHqKOpZWvTQdt8fVGBEThmutCsIXt/zKiKc?=
X-MS-Exchange-AntiSpam-MessageData-1: iHmzTYP9domi/Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 748bbb3c-a1bd-4ab1-68fe-08ded5e82dc0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 14:10:31.3108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ukvzeLn8alxOObsXqSAX3q0TkJzmCan7POnnQjO9oXVE+cIzqz9cLzx/M2tsfsJtDE7CnZzYhA7VdESy1x/jHg==
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

We want to move the `Fsp` instance into `Gpu`, which will require
passing it as a mutable reference in `GspBootContext`, since
`Fsp::boot_fmc` is a mutable method. In order to use the mutable
references it contains, `GspBootContext` must also be mutable.

We will also follow up by making some methods of the `Falcon`s mutable,
which also requires passing them as mutable references.

Thus, make the `GspBootContext` passed to `Gsp::boot` and `Gsp::unload`
mutable, and pass mutable references to it to the GSP boot HAL methods.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
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
index 90f076f640e0..a5d0da05ef5f 100644
--- a/drivers/gpu/nova-core/gsp/hal.rs
+++ b/drivers/gpu/nova-core/gsp/hal.rs
@@ -29,7 +29,7 @@
 /// required for unloading is prepared at load time, and stored here until it needs to be run.
 pub(super) trait UnloadBundle: Send {
     /// Performs the steps required to properly reset the GSP after it has been stopped.
-    fn run(&self, ctx: &GspBootContext<'_>) -> Result;
+    fn run(&self, ctx: &mut GspBootContext<'_>) -> Result;
 }
 
 /// Trait implemented by GSP HALs.
@@ -41,7 +41,7 @@ pub(super) trait GspHal: Send {
     fn boot(
         &self,
         gsp: &Gsp,
-        ctx: &GspBootContext<'_>,
+        ctx: &mut GspBootContext<'_>,
         fb_layout: &FbLayout,
         wpr_meta: &Coherent<GspFwWprMeta>,
     ) -> Result<Option<crate::gsp::UnloadBundle>>;
@@ -50,7 +50,12 @@ fn boot(
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
index 411b06c22fa0..45ba8e6c15a7 100644
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
index 68274367c70d..4fb82350aad6 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -78,7 +78,7 @@ struct Sec2UnloadBundle {
 }
 
 impl UnloadBundle for Sec2UnloadBundle {
-    fn run(&self, ctx: &GspBootContext<'_>) -> Result {
+    fn run(&self, ctx: &mut GspBootContext<'_>) -> Result {
         let dev = ctx.dev();
         let bar = ctx.bar;
 
@@ -260,7 +260,7 @@ impl GspHal for Tu102 {
     fn boot(
         &self,
         gsp: &Gsp,
-        ctx: &GspBootContext<'_>,
+        ctx: &mut GspBootContext<'_>,
         fb_layout: &FbLayout,
         wpr_meta: &Coherent<GspFwWprMeta>,
     ) -> Result<Option<crate::gsp::UnloadBundle>> {
@@ -316,7 +316,7 @@ fn boot(
         Ok(unload_guard.dismiss())
     }
 
-    fn post_boot(&self, gsp: &Gsp, ctx: &GspBootContext<'_>, gsp_fw: &GspFirmware) -> Result {
+    fn post_boot(&self, gsp: &Gsp, ctx: &mut GspBootContext<'_>, gsp_fw: &GspFirmware) -> Result {
         GspSequencer::run(
             &gsp.cmdq,
             ctx,

-- 
2.54.0

