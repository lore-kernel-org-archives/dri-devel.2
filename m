Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3470BC43602
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:10:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68D1C10E90D;
	Mon, 29 Jun 2026 14:10:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="bKYxvM3r";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011011.outbound.protection.outlook.com [52.101.57.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DBFB10E90A
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:10:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ba6ebe2Kt5dFANSikWHMfszbugy91VjOwqk6FbeubamIAU8jQzg+CFIqwjPVuBh2oy9xnyYd2Wfo1iyONoWj/5GYt6ELWIy0KXXs9Ff1XilAGE7rt6fep5y6XLWTueL4mQHU4/cQs9hqikqgFGrQZ1nEuNoCOt3zsz+yAd00m2yS1yddZXtEJSi3vHNf4KzSWwctvqyUbZdkduj4tp+Mbfd00iGkSz2jIl33cELbalxX9A9CRHeoEfDztWvunXsziRDoj3mjde2hkesj0qVKjeCyCPcpaCXd3yJ35jZTHG/VQwgwZY6azAIAgfmB6thDEwlwmBzKB+t4WQU8ZH4uUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xI3fH8zAhGzj6kYIg8gSh00+B6ExamTAAerTnkL3rs=;
 b=oKdNrDOVDAnWCOV1PaGfcwhpHMwqqMIX9uTTi39CYWCl1I6x6BKRrh2CSwqkntWt1y/3BCglAiYOp3V0Hg4Bm9x1vSzPznzfRxvPiLqXhPZmlZlLuCIcNY4fZxo6nB7r16nSWwqCyCnLlyWa7ZGmxeYVqPcylUnqRk4p/Vs/5mMwKjdQbj0GQ5zLPYWUd6h8WfY5fZbpFfRUzZ2wvgduN4X5p6TgLVkF/y060UHWTZSajD4ltXwYOLuaPzHbr1sERCyGV5wJXcXHveUsG1T2WoE345VXxxY6RNxUWjy5DV1Tv0BuOkVJlwKry8vIbRj092SWto8RKA2AVALai3v99g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xI3fH8zAhGzj6kYIg8gSh00+B6ExamTAAerTnkL3rs=;
 b=bKYxvM3rJno/EYwwGIqUKfQrFw2G4F3DCOrhDu0/3nuXbnSmey+RAeSSepbnhuO5tLY8pd4VDXtNUlJ73sqvAdiiybWDVfi38W4N6eHWc7O3YAFGTSFGhqONILsZgk+Cto4IPyptGihQ7RhJuOciqUjsckByTnl66qKbZfHiQkBfgSR7MZPhFvYJSmwbs6H0FGur7DYwANpcDpaPbooRr1lrgIDnugJDIw4WC1fmX6miG/HuDHv+ng5mnx3R8oE+2PzUN8QqWmULu7QdupGXT3V4VTuwfxooaXKwPo/CopRP/GXKcWJCyqHwCbnf5Bf2pWgZHH/6rqAZ3H5DNp52GQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB8404.namprd12.prod.outlook.com (2603:10b6:610:12d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 14:10:35 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 14:10:35 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 29 Jun 2026 23:09:44 +0900
Subject: [PATCH v4 12/13] gpu: nova-core: gsp: separate context and GPU
 lifetimes in GspBootContext
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-nova-bootcontext-v4-12-5539d8469590@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0229.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB8404:EE_
X-MS-Office365-Filtering-Correlation-Id: 286a0645-20d8-4122-a894-08ded5e83033
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|366016|23010399003|5023799004|11063799006|22082099003|18002099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info: H0FnYWii5oEkq/eafMPeHmRtNgoaK8FPsUGKvyhaO+ZY79JnEYMqid6xm2qj2QoG5f4vha0T0EUxfFsZ2zQtfVuKELmA6XfRTFAxQeHeD7yA4syifejhz3L+3G2i1fKiAL9USsZ8K8fT6lqO/v+4Zj1aDLVe+et2G1CSvDsldTbpH0DseIL2Z0zG2Of6JBmSgE92MnpFsMgZ2hefTI0t2sDDBQtvPTuNXdPnj5m51/nKho4w6ID+2P1rt2ICL/M4NjeSbj74ZX+0ZcW7EOnoGfi1R+qLZYPM4Blj3+lcj0X+568NOqEaWnRTe6ZjVG+vOmMGBqHefqF+EKI/Z2KDuF1qvpHoz+YZCAnh3LgUMc9AsDaLllQsFq/XJJrKxgpqK5BPuwAqgDNQbmysVGG7ADnsAkPt3eRef65q40EpTVp+6pyXx5IzBeutARoRiAw0e9c8kJLieSU68vBqk80Uev3iGmB1i5SknyTumwx9yYVZMyR3yBVdvw8gSTXebzEIU37VtVJ7l1WNcYwjJZXZqpk6FlozLu3XHJw/CR/scJtNXG/xLFtyJpUaSm55Cw6P5FiylyWJmxr1P4LnFwafHqn9Tywv5pt7Hepkt9G6wrOFk9IUSfUSQqTDHYRP+RiOziJIpVABOATRmN4iiGyY/0ZhLz2FPyk14HONUY3Ip297MIhZoX9BCnfWkKVoO9yr2oldcscWGKW6QqU7ZF67mQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(23010399003)(5023799004)(11063799006)(22082099003)(18002099003)(56012099006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zko5L1p5ZTJiazZuMFdQUlYzMW41ZDJRMVA2d2M2WVNYNktNd2IxRjFBalpK?=
 =?utf-8?B?c2JpSjdlTkc3eGlNL2FUdTRkRXdFdEl1YlorTzVEWUNGSVZocFF1YitmcE92?=
 =?utf-8?B?WTNDakFpUDEvL25JWUVHUVpHUHlUN2NlOVlLSUhnNVl3QnErcG9MNXo0dUZi?=
 =?utf-8?B?SDgzMFRZTW5LbVd5K05wRmNOdksxQjhDV3IzOGNaQnl3WEFaTlV5RWQ2UzdG?=
 =?utf-8?B?MEFwVi9rdHh3QVQrQlFOWm45NjF6eG9hZHRISlNRMU1RZk41SW93ck1rTGdw?=
 =?utf-8?B?MUphL2t2bTFCa3Rtek1Kc1ZWTFJsTSt0SWIveURDdmk2bHROcXc4cWRRYWR6?=
 =?utf-8?B?ZlV5Qld4SG9ONHBoV2lza3NMVC9Udi9zNG90SUpEK0g2MjNKYytwWi9wT0dR?=
 =?utf-8?B?dEtPV1NUZ1QvbGZzYzNnckZzQVZuNjVWS0NkUkozcjd2a0ZqYjZVWk16TXMw?=
 =?utf-8?B?L1lOcHJPblA5bHZqTW9iSDYybGxTajRWN1Q0c2FMemw4SkcxNGgyenZESmNS?=
 =?utf-8?B?MEV5OEdOeTlEZi9yNjAxRGJLUVhyYjI1OWRKY3VYM1pTK0Zmb0JRdGt0QnRa?=
 =?utf-8?B?a2duZGdld1NEQ3ZjNWVUajNwR1U1dkJEQU9PcTJhZUk5VDduMENGb1VQb2ZI?=
 =?utf-8?B?alNYVk9KakhQak5EaGw4bGdXUG4wTEVmT1J2MUJhR0FkYnhPUS9IMGxNRlNH?=
 =?utf-8?B?NjlyOVBJTHdySWVPSjVCcmIyR2JMLzJLbVU3UDZtcXdGR25pNkw3NDFiNlVR?=
 =?utf-8?B?bmJRS0RwNHZBT1hkYktLaDZRR2s3ZFVJQm5ITTNqczFaM2RXYUFBZUNLWHUz?=
 =?utf-8?B?cGRQaUdrakVIYVJhTUZPZFpsaFRvbUYrV01JYnNjNHlCVWF4YzNrWGhDQ2Fq?=
 =?utf-8?B?REd0VHk4b0RBUFRFMnh2b29qNVBiYWREMHFHUnlKbDBrUEtYVVVKMDFOSXhn?=
 =?utf-8?B?bldCd1laakVNNlgvblRCWW15dVpDWWNYYTRWNWhMeS9uQW9GdStwNEtOYkdU?=
 =?utf-8?B?cVczdVhxVTFXV2VkL09WcjM1OGllQjFvT05pTmVvcTIwYytHbGtCbCtXN0Y0?=
 =?utf-8?B?a3JFemVlemZ3WWx4V1FCQmk2MlBTaThTMlJ5QnV5VlRUaGJuMGpuVHErODRR?=
 =?utf-8?B?U083M2RQN3l2T1p5ZDhhVVJVZG52YXZjNkhlbEhTTG9lU1N6M1ZrcmNkMDBi?=
 =?utf-8?B?eVZ6OHIwRjFDd3ltdXVnZW1nYmxYNVpYWm9jVkVZWTVrZ1pPd0gveGNiTE0w?=
 =?utf-8?B?QzBUd0NhZ1lmZWZpZGwxS0tMQXF4dXRHNDhkN3ZhNTJqcGU5dCtQVGE3OVdL?=
 =?utf-8?B?elc3YnZoNXp0WkZsTlY1MDhqWFkwRXJpMnBiemZzL21RRk5VR2N0dzZ1eVV6?=
 =?utf-8?B?VmdOK0VrMy9CeGE4aUhtU2F0OTNuSlp5TjhzSk1aSHExdmNCRnJPbUFxbU9j?=
 =?utf-8?B?RzFORGc1MEpBU2RmT1k2NGs1SnMrdlRnZTE0OWxPUEVLUzlVMEgyRTBNU24w?=
 =?utf-8?B?bGcvcFMrWjBJRzBRZytkbjJyQkRFRHhMMGpDbktONlUxd2Z5Rm81Q1RuZDFS?=
 =?utf-8?B?S3A2NlRGTElSMnZtQWZBbkt2engrNGhJV3NVL012dmgwM1IvUGtXQ2NEWUJ4?=
 =?utf-8?B?MWtOalh0VHB2V2hnWGgvcnFqQVBUYUNOb2J4NWZlRUNYY2VKL1B2Z2tqRmtp?=
 =?utf-8?B?bWpMSTd6VlpBbGJhVytYbVNPWEJ1UkF3ZXcyYUh6dzM4QllFVXVnelB5NnMz?=
 =?utf-8?B?TGhHQ2lJRG82dW1yVVJyNFdYcE03Uk52bERlR2lKVVZZVGRiRUN4b3VReFAr?=
 =?utf-8?B?UHVDYVM4aGpkd2hwWUtoazRHbE9tTkJHY1hiQjZqR255Yk9XTFh0eUVybXVo?=
 =?utf-8?B?UnM1ZjJCVzNWbzNHZGs2NzBrdDBpWkZrSGJPcnUzU2N2WEdmb0gvVWRGdnpN?=
 =?utf-8?B?OENCdDRycVdPV1Vtb2d5L1NFeXUrM0grMjVxR3I0S1pzT0RtcUJXRkVwcUcx?=
 =?utf-8?B?bEhmNjJIRFRvWEZmalVGbGJOUGovSjAxdXJwM1gzSjhJQWFvMXh0bzlzT1Zy?=
 =?utf-8?B?UzZsUDV3MERjbjRmRGNGU0l5NE9BL0kxVU55UHd6ek1mdmRBMitWKzZ1U3Ev?=
 =?utf-8?B?c20xQk5jWG9VeHZyckxucXZ4ZUJpcTk0dWMrei9mcFEyblM3TTE3THU1ZjhJ?=
 =?utf-8?B?L2xia2E2R0w1QTQ4eXoySkdmZisrN1MvczVnZFcwMjZ1RndyTWRPSlZRd3hJ?=
 =?utf-8?B?Yk5hb0VabGhMZ3pNZWEyM1RHU1IzZVRlajVYWDVDMmtnSDJFc3h1Sy8xTTdw?=
 =?utf-8?B?b1NxT0R2UGpaRVVCUGliWFVxTFNsUXJKVjhLRTVZSi90MGEvOU1RaDdLcFpC?=
 =?utf-8?Q?Mnru5VS5eTPXTTo8vHBohZcbNHtSq/QUouSyg50SPKD6j?=
X-MS-Exchange-AntiSpam-MessageData-1: a5D9Thg/hFYhOA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 286a0645-20d8-4122-a894-08ded5e83033
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 14:10:35.2389 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EAGqRrs7PnPCnEMPlo2KMOGcIY8mFgrpGewdF+eRA7cjqQThVboHbN8GXG8PQbUoWTQUUl5eFFX4d20uha08MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8404
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

`Falcon` instances retain references tied to the lifetime of the bound
GPU. `GspBootContext` currently uses that same lifetime for its own
borrows of the `Falcon` instances and other references.

But these lifetimes are independent: the references captured by a
`Falcon` remain valid for the GPU lifetime, while the context only
borrows the `Falcon` for the duration of a boot or unload operation.
This distinction is hidden for shared references by covariance, but
cannot be ignored anymore if the context carries mutable references to
GPU subdevices, as will happen for the `Fsp` and the `Falcon`s.

Thus, give `GspBootContext` separate lifetimes for its subdevice borrows
and the GPU resources captured by those subdevices, and update its users
accordingly.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp.rs           | 19 ++++++++++++-------
 drivers/gpu/nova-core/gsp/boot.rs      |  4 ++--
 drivers/gpu/nova-core/gsp/hal.rs       |  6 +++---
 drivers/gpu/nova-core/gsp/hal/gh100.rs |  4 ++--
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 11 ++++++++---
 drivers/gpu/nova-core/gsp/sequencer.rs |  2 +-
 6 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index cad851e68685..c2d7a557310a 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -56,16 +56,21 @@
 pub(crate) const GSP_PAGE_SIZE: usize = 1 << GSP_PAGE_SHIFT;
 
 /// Common context for the GSP boot process.
-pub(crate) struct GspBootContext<'a> {
-    pub(crate) pdev: &'a pci::Device<device::Bound>,
-    pub(crate) bar: Bar0<'a>,
+///
+/// It carries two distinct lifetimes:
+///
+/// - `'gpu` is the lifetime of the bound GPU device, as captured by the GPU subdevices.
+/// - `'ctx` is a shorter lifetime during which this context borrows those subdevices.
+pub(crate) struct GspBootContext<'ctx, 'gpu> {
+    pub(crate) pdev: &'gpu pci::Device<device::Bound>,
+    pub(crate) bar: Bar0<'gpu>,
     pub(crate) chipset: Chipset,
-    pub(crate) gsp_falcon: &'a Falcon<'a, GspFalcon>,
-    pub(crate) sec2_falcon: &'a Falcon<'a, Sec2Falcon>,
+    pub(crate) gsp_falcon: &'ctx Falcon<'gpu, GspFalcon>,
+    pub(crate) sec2_falcon: &'ctx Falcon<'gpu, Sec2Falcon>,
 }
 
-impl<'a> GspBootContext<'a> {
-    pub(crate) fn dev(&self) -> &'a device::Device<device::Bound> {
+impl<'ctx, 'gpu> GspBootContext<'ctx, 'gpu> {
+    pub(crate) fn dev(&self) -> &'gpu device::Device<device::Bound> {
         self.pdev.as_ref()
     }
 }
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index f093e0215b66..c347558aa8e5 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -39,7 +39,7 @@ impl super::Gsp {
     /// [`Self::unload`]) returned.
     pub(crate) fn boot(
         self: Pin<&mut Self>,
-        mut ctx: super::GspBootContext<'_>,
+        mut ctx: super::GspBootContext<'_, '_>,
     ) -> Result<Option<super::UnloadBundle>> {
         let pdev = ctx.pdev;
         let bar = ctx.bar;
@@ -125,7 +125,7 @@ fn shutdown_gsp(
     /// This stops all activity on the GSP.
     pub(crate) fn unload(
         &self,
-        mut ctx: super::GspBootContext<'_>,
+        mut ctx: super::GspBootContext<'_, '_>,
         unload_bundle: Option<super::UnloadBundle>,
     ) -> Result {
         let dev = ctx.dev();
diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/gsp/hal.rs
index a5d0da05ef5f..46428c623087 100644
--- a/drivers/gpu/nova-core/gsp/hal.rs
+++ b/drivers/gpu/nova-core/gsp/hal.rs
@@ -29,7 +29,7 @@
 /// required for unloading is prepared at load time, and stored here until it needs to be run.
 pub(super) trait UnloadBundle: Send {
     /// Performs the steps required to properly reset the GSP after it has been stopped.
-    fn run(&self, ctx: &mut GspBootContext<'_>) -> Result;
+    fn run(&self, ctx: &mut GspBootContext<'_, '_>) -> Result;
 }
 
 /// Trait implemented by GSP HALs.
@@ -41,7 +41,7 @@ pub(super) trait GspHal: Send {
     fn boot(
         &self,
         gsp: &Gsp,
-        ctx: &mut GspBootContext<'_>,
+        ctx: &mut GspBootContext<'_, '_>,
         fb_layout: &FbLayout,
         wpr_meta: &Coherent<GspFwWprMeta>,
     ) -> Result<Option<crate::gsp::UnloadBundle>>;
@@ -53,7 +53,7 @@ fn boot(
     fn post_boot(
         &self,
         _gsp: &Gsp,
-        _ctx: &mut GspBootContext<'_>,
+        _ctx: &mut GspBootContext<'_, '_>,
         _gsp_fw: &GspFirmware,
     ) -> Result {
         Ok(())
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index 45ba8e6c15a7..2805a35abb79 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -114,7 +114,7 @@ fn wait_for_gsp_lockdown_release(
 struct FspUnloadBundle;
 
 impl UnloadBundle for FspUnloadBundle {
-    fn run(&self, ctx: &mut GspBootContext<'_>) -> Result {
+    fn run(&self, ctx: &mut GspBootContext<'_, '_>) -> Result {
         // GSP falcon does most of the work of resetting, so just wait for it to finish.
         read_poll_timeout(
             || Ok(ctx.gsp_falcon.is_riscv_active()),
@@ -137,7 +137,7 @@ impl GspHal for Gh100 {
     fn boot(
         &self,
         gsp: &Gsp,
-        ctx: &mut GspBootContext<'_>,
+        ctx: &mut GspBootContext<'_, '_>,
         fb_layout: &FbLayout,
         wpr_meta: &Coherent<GspFwWprMeta>,
     ) -> Result<Option<crate::gsp::UnloadBundle>> {
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index 4fb82350aad6..2b489df6d0aa 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -78,7 +78,7 @@ struct Sec2UnloadBundle {
 }
 
 impl UnloadBundle for Sec2UnloadBundle {
-    fn run(&self, ctx: &mut GspBootContext<'_>) -> Result {
+    fn run(&self, ctx: &mut GspBootContext<'_, '_>) -> Result {
         let dev = ctx.dev();
         let bar = ctx.bar;
 
@@ -260,7 +260,7 @@ impl GspHal for Tu102 {
     fn boot(
         &self,
         gsp: &Gsp,
-        ctx: &mut GspBootContext<'_>,
+        ctx: &mut GspBootContext<'_, '_>,
         fb_layout: &FbLayout,
         wpr_meta: &Coherent<GspFwWprMeta>,
     ) -> Result<Option<crate::gsp::UnloadBundle>> {
@@ -316,7 +316,12 @@ fn boot(
         Ok(unload_guard.dismiss())
     }
 
-    fn post_boot(&self, gsp: &Gsp, ctx: &mut GspBootContext<'_>, gsp_fw: &GspFirmware) -> Result {
+    fn post_boot(
+        &self,
+        gsp: &Gsp,
+        ctx: &mut GspBootContext<'_, '_>,
+        gsp_fw: &GspFirmware,
+    ) -> Result {
         GspSequencer::run(
             &gsp.cmdq,
             ctx,
diff --git a/drivers/gpu/nova-core/gsp/sequencer.rs b/drivers/gpu/nova-core/gsp/sequencer.rs
index ddce32cc4e30..422a74f9ecbd 100644
--- a/drivers/gpu/nova-core/gsp/sequencer.rs
+++ b/drivers/gpu/nova-core/gsp/sequencer.rs
@@ -335,7 +335,7 @@ fn next(&mut self) -> Option<Self::Item> {
 impl<'a> GspSequencer<'a> {
     pub(crate) fn run(
         cmdq: &Cmdq,
-        ctx: &'a GspBootContext<'_>,
+        ctx: &'a GspBootContext<'_, '_>,
         libos_dma_handle: u64,
         bootloader_app_version: u32,
     ) -> Result {

-- 
2.54.0

