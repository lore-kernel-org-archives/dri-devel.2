Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A112DC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 06:57:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BA5910F3B9;
	Thu,  9 Jul 2026 06:57:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="HZl2dArk";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010020.outbound.protection.outlook.com [52.101.56.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 944A510F3CE
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 06:57:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmjFrVw36cMZdwbx6ml2v+wCZUmCqpL50gzUFka/irsCMEaUeg2/rQwbIvtPu36hmCI0VWbJa9FVoBmoFGIwECRzOmqPqsQL2dexpSB2zp/Dbz0125guZ02QUj8aBwQkMRq0NrMDdnfVTqffWd4urwhp0s72vpeBEVkiqWhj+von/LkQhXw7OS3H0Q5uajLy9b7P2tBYdnjMLaL8bx4vyGwDlaN91CR3s8uJoIn6EivGnFMSkJYYd6mkjPFIwANNaVUTWt/SqOBE5CFx8NFlGZHE9Fnv1hK2rF/WoHCz0N180XlJX25MrAQ0mwMneums8vDU8T1G0ipHWXJWk7hYQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcAjJuNCZWinfYj2KcU7cj8KAssuS/v9LbNTBBo4zZ0=;
 b=emIB+MnSas3Gx7YAyRvU6yKMVU5KQTDp+uPlvao1nmK7deQTZRyA3EDzQRX1cvfCAT37bYBPxyKDX0hKcda1FL3eWvYON5jegjJJmJOYHWpIdUVBQ7CvKkEV0/CrvS75Z1Bts2fWPyfvf2YaM/m7QLIGrzj6+fR1KqB8Kkwyrp3VchkYpfu9lG+7hcFm8mfk89p1eiO/YZMLLx5IcIKaMQnasJ4MjLz0RA2HUE3mc/jUEQDytJH8yg87r3mac6GBR1TntN3hfKCUZ64HAz7X25VfVA7lrNVc6bVQoW+SQohyqTPzpsV0q6bsZ/aUh+JIDfWiZpDiGbb6PjUmWgdaCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcAjJuNCZWinfYj2KcU7cj8KAssuS/v9LbNTBBo4zZ0=;
 b=HZl2dArktNFKRYEYSQxRq61NXfqb7uJW3O5uQVG4LU9Ez82b7JTlny8HRCsCmWPalghtYB9pNlzyTqpaRGSP8uALl+BpqN0Msd+2/uFN3iwm5rKzJB6q0EDeD7WPUhB7md9bjxBLUYw9jApDZXEY6dtJYS+aGWzKJ+hy+LA10vbOZoxZm0J+hTjl++6dp/Eb2vIRGCbex5lyVd96VB/KgGLlbh6LJJIbCd4Kfb/1UMCD8SM4VB5wQLtlLbTrbmA7qfcrzjoyV6OkymX+rSpTnCGJWZXwVVdLOxvv9W9pXJksY3BFhZhxPXAAVTpNLXoEZBvhD87BC0fOZV5aiROZcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by LV8PR12MB9668.namprd12.prod.outlook.com (2603:10b6:408:295::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 06:57:24 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 06:57:24 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Thu, 09 Jul 2026 15:53:05 +0900
Subject: [PATCH v6 12/13] gpu: nova-core: gsp: separate context and GPU
 lifetimes in GspBootContext
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-nova-bootcontext-v6-12-520cbf8b9b50@nvidia.com>
References: <20260709-nova-bootcontext-v6-0-520cbf8b9b50@nvidia.com>
In-Reply-To: <20260709-nova-bootcontext-v6-0-520cbf8b9b50@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0287.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::9) To MN2PR12MB3997.namprd12.prod.outlook.com
 (2603:10b6:208:161::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|LV8PR12MB9668:EE_
X-MS-Office365-Filtering-Correlation-Id: 1920387e-41d2-418e-c57c-08dedd875499
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|10070799003|1800799024|11063799006|5023799004|56012099006|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: XKKSnH/0x2+VvGqv9zAik0OUBikeheTzhMyr/6n047D93zV6K3qAzHsUZcZhCM9xfuVFfSX+PdXu6RDWTN6N8Qy4UfBFggIizrhyZvb+I/7FCPBJ4Xi20mihaD/OtCZsiq3aa4qdc+ZfPOPyctKW6JYQIuoBgZPUp+HXhgCySmrzQiNIp0pFZG3bbCRdcAxV17AObfjVcFARN53KNmW2W7/jyAeK0gF5sxKLntdLaH7tnErfa3tpNfr3HpIv9N1Z/dSfCZ491u2klYeZMWJ0rCz38Wf8CaXuLX6ZGqtnXYnnopeIkyfIDD+Lll3sNQMhGtL16HWoQs1/wKfR/y8Xsmk6QIh8rcX2lkgUj11F2YziGy2W7xNni4C6uUmGHCYG5Q9haytKpFhkRJltaeDo/lvqgPteMCVU0bVf+m/X1eHbHzbRmlX1uiY8h9TiOby480K03Cz4Icyv4HEREjPTXDKxNRpuAo3pjoqfLKmNjEE7TP/iX2FgQlw1faH9MIeIuYWJWxZrnE9hjAHDZCgOZYF33e/ZPZBGk1TO/dhVF/1vx+RUc7ifkaY7I1gCt1mKcYP7vQUu/h6BdM69zrJQXzBzq8Dzcb1Grc4OSYllWwo2JegyopWRRd+t1AjJbXv2ODkoneiThtbJiOty1eOnWXQXecMtQ43scCTD820qzQAo1+QYaoXsGu9RTO1bhmddQfIGC+d3yn9pgn0kFU4maQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(10070799003)(1800799024)(11063799006)(5023799004)(56012099006)(921020)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXFPUlRwcFhWUHpvNWlybFVock9nOURsYXU4aklHUThRVnFjUGRRN2xSV25O?=
 =?utf-8?B?MXFQQU82SWxJL2dTTXZWa3pPREFwRjF1b0Q3azIzUkNTeXFFV2x2WkF0RGNH?=
 =?utf-8?B?UnRwckZyTnZnNjJvZHRqdEIyanZIV1pMeFRuck9JZE1HNlloMUV6QjF6ZXNi?=
 =?utf-8?B?U2dxNjRrWnhpVmhPMmRkZEk0UXdJUTBSbFBNM1l4S3NwZGEyb2hzcEZoSko5?=
 =?utf-8?B?VXVLbHlBZGN0dTJaVGR4N2V4aDVQMzNnMHZNeW95VHJnSDBsdm90NGRYYzBE?=
 =?utf-8?B?ZUNnci9tSktEbnBJQXJGSmk2eVU2djV2TTlRUnpYVDFYSDhvNVBHUkxhYXRL?=
 =?utf-8?B?bkNaTXhHZ3RGSnYyVnI1c0xYalZ6dUNrWkRleHhVbVl5dnJGUGEyZzlCL3dU?=
 =?utf-8?B?RHVXTVViMnRmWUdUME9BR2JSamE1VzVvN0Npc1hSMVBqWTBpU3RRek1sSlNQ?=
 =?utf-8?B?cEt3QnhZRnUyVGZZdW5EK0NVcGNoYWo2em9CcndOVmFyYXF2cWlXN1k1eHc1?=
 =?utf-8?B?WEVxYThoamJMV0Z0Rk1NMldseFZ0RDUyUjJ0b3pVczcyWHdyelpEWWJYYkpS?=
 =?utf-8?B?MG0zSjF2NEo0b05xbGZmRjNhU2JqcjVIOHRnUVpQQmI0UWRNSko1TUpQQi9I?=
 =?utf-8?B?cFVxd21uUUY4dHlDMW44aG1BSGxtRk1HcnhzZnlJdHFuWTRDRUkzejRCTXlJ?=
 =?utf-8?B?MzltZ01RNXplRkpXZjNGekp1RjVxUmQ2dnpkZ2Z0NzVYbkF3OHFyNUpRZ0M5?=
 =?utf-8?B?SVpUZytVSnBUajFNNGhXT2M2VmdVUHlicVRUK1N2RFpENHR2OFNRbzZ1Q3R4?=
 =?utf-8?B?Rmt1ZHpGRVNqWmlNUVlUMnJpM25OWTdJaDRKM2wwYlJjdit3OXpST0NqYisw?=
 =?utf-8?B?eE91S1NpcGVXWVRtb2J3VGtUTFBmK0FrSDF2NjdRV3VNZHRQMVFXUzRjdklm?=
 =?utf-8?B?bWQ3S21iUjB6K0RySnErcjliQ1dLcU92bTI1dS9zRU1NTDJvdkFhQ3Z5ZzlR?=
 =?utf-8?B?by9WTGxnbEswK1djMHN5MGRlZGQzOGIxNFBwL3VVTXZURVQ1anhicGtqMG8w?=
 =?utf-8?B?dFFRbnFNdS9WMTBaYTNwRVNublh5TUM5NEh1TWljeGVVRHZhZXlORGV2ZTVr?=
 =?utf-8?B?SVpEazFaY1d6RXNLT1Y0ODdudHZPbkdNdXlNMzJ3aTNnYUwwOHJqcUpFdWs1?=
 =?utf-8?B?b3NLdGpqU0R2OXNySTc4N1N3c3JyRmJ4SHpmN2tCRzgvREpUSU1Uczl4VjVl?=
 =?utf-8?B?NUtzZk14QmxrNWQ3a2xwTG1GUnE1bUcxeFhXN1NHeU1DZFlxWkdyamNBZHJY?=
 =?utf-8?B?UERnN0twU2ZDT1IzeWJLUzBMZGxDeTErWHZIZ09HREZKSHBPVXNycndNcnMv?=
 =?utf-8?B?S0VTVWFVVVo0UTltL1cxZU1BZFl4K09BckxsU00yem9sT2h0RHQ2V3E0K0du?=
 =?utf-8?B?L3ZGVCtBaFpUM3FRYUpOZlFPYkZxelQ3dzBBa25QM1pHQkN6NlJpcjFXTS9Y?=
 =?utf-8?B?WmtBb0JFZWlkSW13c1R0dXJ2WW05c3RKeGZNMkd2ZGhXcVMyZ0xRQ1RuRXRV?=
 =?utf-8?B?VkRNQmNqdVNLV3VmL1dWbjNxZ0V5eEpTYWd1L01Hd3QrWnRSL1FjaUd1WFAv?=
 =?utf-8?B?aFVIM012UDQraW93aTF3dnplSXFXUjRYUk1CTXIySzh5OE5ubE5YajZPbUxE?=
 =?utf-8?B?MVc2YmE2WjExZXlzV0M0czVQeDlvQUZqYllPcUNqMGlpQlBvM2syRkVCTzdt?=
 =?utf-8?B?TUxMa1NDRTJRdnNwZXBGeG1KdUVaRTNMd09ad3duWGJGQlYwVy84OTFjYzNG?=
 =?utf-8?B?MkpaK1J3TENEdWlEb0FyOGs5UnZpQy96aWlBYnRVbHo2d2N5MUxhK3BtY00v?=
 =?utf-8?B?N0dSR3IwOTErOEFSSEFqNXJmNXpnSjd3QkxGbTE2K3c5cUtMN2RsdjdoZTMx?=
 =?utf-8?B?eDdSZnBFbmV4d21kYlh0TTdJSXg5dTBnTnJQRnlCalpSNVpMZlFva0w1a0Rk?=
 =?utf-8?B?SVdaQjFDM0lWRG1Gc0s4VHk3M09kMVc5U1Q2S1E1SHoxMVhGV3ErQUFPQmU0?=
 =?utf-8?B?aEZTU0M5RHVaOEEzT0pDbWNRM3kyNHlxeXBFSnU5dVNidU5uUklOSDBJWHVX?=
 =?utf-8?B?MUVuR3RjZ2RteVdGWXJPQWlVYkFuZ0lxWHJYNlo1cHYwalh6UmlVa0EzNSto?=
 =?utf-8?B?QU12SVFZYmMzNldqOUw5SXQxcGZmemJMTFRmOEZiNk1xVk1ZZDJhY05GYnZj?=
 =?utf-8?B?emNIOWw3Ync2Rk9sNzdndUN2ejhUSVBmaUFhd281M0xrM3h4SSt5Y3UwQWFt?=
 =?utf-8?B?bVBCd3Bqa3VzWkFXeUhkeFU1d25ISFQvVjA0WE5VdDM0eW5ZSHprZWFDQkpF?=
 =?utf-8?Q?nUBZWaS3p4mId5IqGyfSRTOZ2KsNS6E2HGMFFkClewEvj?=
X-MS-Exchange-AntiSpam-MessageData-1: JXJmZ/4MAO9jow==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1920387e-41d2-418e-c57c-08dedd875499
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 06:57:24.4954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rwfIGuhkLi3NdyPz1nUlFhBU9B5noA6wMiZrhY2LYyIUXHsHDAtXfeziB4gDi8QstFDZ1eB6f4R4TfoP/qAaZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9668
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
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp.rs           | 19 ++++++++++++-------
 drivers/gpu/nova-core/gsp/boot.rs      |  4 ++--
 drivers/gpu/nova-core/gsp/hal.rs       |  6 +++---
 drivers/gpu/nova-core/gsp/hal/gh100.rs |  4 ++--
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 11 ++++++++---
 drivers/gpu/nova-core/gsp/sequencer.rs |  2 +-
 6 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index d5cca3c8350a..9f055a0d6cb9 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -54,16 +54,21 @@
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
index 17e589dbd483..6b7d00205000 100644
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
index 7ebdeafc1432..34b4bb82a999 100644
--- a/drivers/gpu/nova-core/gsp/hal.rs
+++ b/drivers/gpu/nova-core/gsp/hal.rs
@@ -31,7 +31,7 @@
 /// required for unloading is prepared at load time, and stored here until it needs to be run.
 pub(super) trait UnloadBundle: Send {
     /// Performs the steps required to properly reset the GSP after it has been stopped.
-    fn run(&self, ctx: &mut GspBootContext<'_>) -> Result;
+    fn run(&self, ctx: &mut GspBootContext<'_, '_>) -> Result;
 }
 
 /// Trait implemented by GSP HALs.
@@ -43,7 +43,7 @@ pub(super) trait GspHal: Send {
     fn boot(
         &self,
         gsp: &Gsp,
-        ctx: &mut GspBootContext<'_>,
+        ctx: &mut GspBootContext<'_, '_>,
         fb_layout: &FbLayout,
         wpr_meta: &Coherent<GspFwWprMeta>,
     ) -> Result<Option<crate::gsp::UnloadBundle>>;
@@ -55,7 +55,7 @@ fn boot(
     fn post_boot(
         &self,
         _gsp: &Gsp,
-        _ctx: &mut GspBootContext<'_>,
+        _ctx: &mut GspBootContext<'_, '_>,
         _gsp_fw: &GspFirmware,
     ) -> Result {
         Ok(())
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index 067bb01903e5..d134ad052308 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -115,7 +115,7 @@ fn wait_for_gsp_lockdown_release(
 struct FspUnloadBundle;
 
 impl UnloadBundle for FspUnloadBundle {
-    fn run(&self, ctx: &mut GspBootContext<'_>) -> Result {
+    fn run(&self, ctx: &mut GspBootContext<'_, '_>) -> Result {
         // GSP falcon does most of the work of resetting, so just wait for it to finish.
         read_poll_timeout(
             || Ok(ctx.gsp_falcon.is_riscv_active()),
@@ -138,7 +138,7 @@ impl GspHal for Gh100 {
     fn boot(
         &self,
         gsp: &Gsp,
-        ctx: &mut GspBootContext<'_>,
+        ctx: &mut GspBootContext<'_, '_>,
         fb_layout: &FbLayout,
         wpr_meta: &Coherent<GspFwWprMeta>,
     ) -> Result<Option<crate::gsp::UnloadBundle>> {
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index 4e2f48c27368..29bb17171f56 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -78,7 +78,7 @@ struct Sec2UnloadBundle {
 }
 
 impl UnloadBundle for Sec2UnloadBundle {
-    fn run(&self, ctx: &mut GspBootContext<'_>) -> Result {
+    fn run(&self, ctx: &mut GspBootContext<'_, '_>) -> Result {
         let dev = ctx.dev();
         let bar = ctx.bar;
 
@@ -258,7 +258,7 @@ impl GspHal for Tu102 {
     fn boot(
         &self,
         gsp: &Gsp,
-        ctx: &mut GspBootContext<'_>,
+        ctx: &mut GspBootContext<'_, '_>,
         fb_layout: &FbLayout,
         wpr_meta: &Coherent<GspFwWprMeta>,
     ) -> Result<Option<crate::gsp::UnloadBundle>> {
@@ -314,7 +314,12 @@ fn boot(
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
2.55.0

