Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB06F459F6
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 15:58:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E36510E24E;
	Fri, 10 Apr 2026 15:58:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="JpQUnQm0";
	dkim-atps=neutral
Received: from CWXP265CU008.outbound.protection.outlook.com
 (mail-ukwestazon11020078.outbound.protection.outlook.com [52.101.195.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CC5110E24E
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 15:58:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GjwYfiazancZltXZB2kkBo9KwsK4ivaP3OkO5Of5t8s5fRWIgCiiBm8GclsacShBs3Ms3j8aSfl0Xcgmibo5GJiqHW1Q3tqTqeufejXkc25aGQbLlkTcC9q9uKbkztge4ydn8k20KIUE3xE9QylfXa/EBWvb0D/cY4WItFUDRIZF+B1fjUxjzfLfJXR2dxFkHvBCnftTlN+LsIc82SLkLDZ7jaqY6LyvQK3pX6IKdWk0dvCT5qJfK1nVhzbnBTwkMYBT+t1QPrN4eacielDMMjMRK5wl0PRgcCN5kuC/bwpMiJ7QBvNwJf34u7OUzIIztXw4YRf7+vcH6mYC+Z07bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygl1fnrcA65GzKpzpddOexrslUyLSHOhESCogqUyEws=;
 b=ioutH+JRt7+Ei213foArZ7mJ+U/hAoF5s+zVNv+6JTUv632yXPOBgRMuQsEWvA5KwIZ63y5hX5Bx7CO5YKt3LnPoZ2Sr9sHRvcIZSzw+xgLozAHY19h+0O8mNLJjZ5pF+HFzKfK6senv/QNFRt1CxcXI7jaCEsf+tY904F0VhB/O9AhmnoyQV2IHfASSD8YIyEsugwWATEGR4wwlF7NsCP9wRnzfcxykMWX3p24KEx8bMiwvK0FN2x2otn9iZ/fzYiEG9ZHhWq9eiIlBkOmrtaRXD1iAFinVyuHyNWXqRaDXRbNESQb+2zLR0ZDZ06Djj1r5eucTFfV6047/XESxrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygl1fnrcA65GzKpzpddOexrslUyLSHOhESCogqUyEws=;
 b=JpQUnQm0dY4RbmtOjZMt7J1xvN1aEdPVKXeowr8DBb7mDpr+hbI+xodbHq6SfRX/3Qe/R+/EONpeJz6mW02UkHaesoqiHdj89Lp91854FjNFkWTvxgp7mqYaUiKNiSIEvqtNN4oEpJarEmqDOU6OZQp+utv6UUD7JymJO7I5fNA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by LO2P265MB3261.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:157::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.44; Fri, 10 Apr
 2026 15:57:57 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.20.9769.035; Fri, 10 Apr 2026
 15:57:57 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Apr 2026 16:57:57 +0100
Message-Id: <DHPLKB40FM08.1L3H2S589WUW@garyguo.net>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpu: nova-core: fb: make sure to unregister SysmemFlush
 on boot failure
From: "Gary Guo" <gary@garyguo.net>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>
X-Mailer: aerc 0.21.0
References: <20260409-fix-systemflush-v1-1-a1d6c968f17c@nvidia.com>
In-Reply-To: <20260409-fix-systemflush-v1-1-a1d6c968f17c@nvidia.com>
X-ClientProxiedBy: LO4P123CA0488.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::7) To CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:27c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CW1P265MB8877:EE_|LO2P265MB3261:EE_
X-MS-Office365-Filtering-Correlation-Id: d872c271-57d5-4269-6f4e-08de9719ef31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: zBSBnyygh8m7rAn/ub5fLOx0wARjl2z6N8VlAnfzcRd1to/hRTZd/yDqjdubUW+mBlmOkU1/I91b+6rRy/D8KbgXSLpcXJAUomABo7PLL1zQm93lR4+yUv5iRwM79X7jzEGXxqDNIDnbUj6BGTJRPQ5Ga7nYte9nKBHuj6InXRCoMjmmEKexkJsVPXLGokdwgwJPlhHcRtKkT7umufGSFxnMdSaFss+FNEEOrg5cdf8l85fSoCIobus07LDPEoXaH10cGeyFAdW8CA/q08cKFxElT5Y3gfzJp484gkbHL3Ujot5I6TpnFA0fI9xQLTxibBa/DoPcAwTlI4iTbtbzh8+g6rTmmfSNZ74guf9bmDsx6YJkvR8t+6/Lxa4xnaRRE+GVrf1vda3aLPTYiCnJ69nOLREadhxAn2dFsOY91CZ0gGt3N27WmUGZCZxFWY8ZkgQREp5f/9b9R6tdPwP5lzbTt2OGE0+gUO1Q9LOS2FNzRPxOvb6Bsb+6D8lQFvvdh0gZ9lLn6IT8O/tV+1ixMS8/21vT8awvhDToixNZQDdxecRNBtbr4IodTjlHyQ930EWI7QGcy7MlDqxIKiefRXzkHZKN8sjbS6N8v1od+yXevsG0hJ1c4lds6aXNShOMCZvtINja21u2VRLHDxlulCE7R7tzZB7fSjRTKdJTyMJzqqml2Qa40CZE/hjX3+7v3r1YqjFmD5+hriUwl7GrJkUwE3MYQSUqlLztDqENhfQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REZsL0ZORjcya1AzY2JoVTNtb0tkNnFqdU51a1lhbUlDRUhIUVBnekEzSWNi?=
 =?utf-8?B?YWpreVRPdld4SFJLSEtaMDQwc1RleWtsM0pwbjRrYnE5N2ZibWJXaU9VVThX?=
 =?utf-8?B?U2o2L2RGbEVEZVRoK21sTVc1dmZtNTlpSmxOaVR3ZVdNV0xTTmpyeENFazBk?=
 =?utf-8?B?ZW1BZWovK3BUaktsNGdDSVdZVmZGSGtUR2F2M2pnVnUzUEk3ZUNoWi82YXlz?=
 =?utf-8?B?VW9FK1I4WVZOSFh4bUtPVy9xUUIzTm55V3JCOHU5Tmk1ODZIWFlUMXZ2U3Jq?=
 =?utf-8?B?bHphRUFvUjhObDZmOXhkWHZpcnFqSXhSY1ZJa2dkazM2UnNnNVFaWFFNblVl?=
 =?utf-8?B?MDAvSTd4SnJORHRyeGlHN2s0S3J1dXg1S2VGanY4YXdVc1hxdE8vS2dENnRr?=
 =?utf-8?B?aEQybjRaWVY0OC9WbWxiS3g3SXdFS1FaMmR4OGgxbTBKdzZ1eEt3UmNSQXBK?=
 =?utf-8?B?dHM2TWtoRm9NOWdjSXVxaFBKNU9JRXRRZ1c4WE1iQ2V3ODVWbTFHRU9IS1Rj?=
 =?utf-8?B?NUZCNmdEOFhHYU5qa091andzZ3krUWs4aGczY0VLRzZjMlc0U1dRcWNCVU15?=
 =?utf-8?B?S0NTTjVOYVNvdDBrcStsQnpYV2hSTjc5ZTZlb0tHYzlzSldKbTVtd1NoODFX?=
 =?utf-8?B?L0NsOUxyb3FENEZYUExJVEFVQzEzc05NZ2lMa0FncUFtS1ZrUmZzdmhFaU9C?=
 =?utf-8?B?TlBVMVhLZXQ0M05EME1hNlpXYlZwekRIZ2Q5RWxqbnJ1eTJOd3NCb0k4alBu?=
 =?utf-8?B?dHVZUWlPUFRZK0grZHdnNWtCZGNVbWVlUGZaTFlKM2tqazNPY2t4ZnRKT1U5?=
 =?utf-8?B?ZzYzMXZsdEhyTUxISkxCZWJmZzlLNW5wRkZsYXhER29xdzRoNnZUS294M0VV?=
 =?utf-8?B?K2dycG52bVB5Uy8zWVcyQS9GOFpoNlBqSlFJTWdqRzN0cDJ0RU1FZ01mdUE0?=
 =?utf-8?B?cHpjZ0ZJZHV5MmwrdDhjWkpySUxVUlNIZmEwZUFTN1I0dnFqV1VYT1NSZXVB?=
 =?utf-8?B?anpWejROUllzT1RoVHhxYkxIZit6T2FaTmtadzcxbS9BRFZ5OFhVMEZFMjkw?=
 =?utf-8?B?M29pUXVORmR3OXdzZ1hGVHI5cVA2WVI3MDFMVDBYUXNXNHlsZ3VmakdmNnY5?=
 =?utf-8?B?Vm1IV0FESkJTTnVQSHlxd1hzSm1yWGtWRzNzYzhseHRrOUYvQ3kxZHZEamNL?=
 =?utf-8?B?K0RMN3E4N0pRTDRLQlVXQXRBVndOU0h1WUY5S2F3eDdOZWpuT1FxRkhLb3RO?=
 =?utf-8?B?bGQ4Nml2cnlVcW9jZFVqMHkwcmNHbFc5Z0pFUTdwWDNIL2hEa3FZT0ZVSEdC?=
 =?utf-8?B?MU15UURwV2ROVTJRVy9qVjYrSlRQM3hEUVBjdGUrTnFjalI4ZWRBYTFsWHNR?=
 =?utf-8?B?SlJ2ZDErSDh2aFNGOENwd0ZpclhzblpQR2sxNnZDRXpBUzRJNzl3VVQwUzZR?=
 =?utf-8?B?dE5EWVRCWGJTMFRMRWdTWVVrZkUyRlNTeEprMHNsMlNPOG9kZDM1THEwSzdu?=
 =?utf-8?B?S09IM3Z0UHRYcGFGR25ZOFBtNnZ2Tm8zd1pmbUtCSzVOaHphT05CeG9FVHc4?=
 =?utf-8?B?SG51MWcrNDZJaGFzeTFtU20xVFQ5QjVYVFdGWE1VcXhQMi9ER0NTSEE4bDk3?=
 =?utf-8?B?VWN0VkRJRUtJREhQZHRNWFQ5OWRoZGl3bTBHLzJrZ2M5UzFOeTZsQXM4Qmo0?=
 =?utf-8?B?R3RDc0VxZmpKZzJGdzVPU3ZDT1l0MWwvWUdISTZvelp5WkNNNFZ0a2RONnRB?=
 =?utf-8?B?dkR0Y1E4ZlpNUFVyRkZ0dk9TMVFOKzJSSy9TMXA5Z1kzeGIyQWxpU09PTkpq?=
 =?utf-8?B?bkV4M2V1VHRvTVhlWm53L2s2SjJmaExpaTNBMitEbDJqWTJjWUc0alJFZUhi?=
 =?utf-8?B?RTZXbHorcjJlb0YwbHJySGtpVEc2V0piaGR0RnBhODl0cFJGRk9NQmRnV25D?=
 =?utf-8?B?bnl3UzlnTkFNVFdxNDFWSVZ3TllPeXRoUWVCQm1Zc0huNGJPa0QxT2QzM2dM?=
 =?utf-8?B?akZlNVJ3SnNrZzdLSkJ4Z3RTQmhEdENiSE9wZkF3MWt4SWVEbG01WktvV1Jh?=
 =?utf-8?B?UHNxZ1NXK0FDVEJjUHdQcGNDOEhockxmQWx2czU5ZjYycDFzRHFia09yZFQ4?=
 =?utf-8?B?NGRxSDVyL0ZNanFaUnJDL0hpOVN5bTlUeXY3MWxVUmw1UCs1MzB1VEdqakkv?=
 =?utf-8?B?TkN2RnpPRDMwTjZuOWdJVlR3SHhlK2QxdVR0ZDdsZlFpZ09FTVVZdDdPWXh1?=
 =?utf-8?B?dXF1cmdVUkxCaGdGOGgzNFhCUDNWYkxkK0lmSERvQi94eWYwcExTNTB4MnVl?=
 =?utf-8?B?UU4yUk9CZXphNGo1bVBiU0R4d0k1L1dQbHBWMjhzUmN5cTdkZnorQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d872c271-57d5-4269-6f4e-08de9719ef31
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 15:57:57.7249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gwEUyJdPYf28gnxlEMAyxWkbK9F4fYJ7ZtH96+C8VtnhZNtyoMH0ZFGswYdVhc4GqQDbAhBWeUNUeKBiGrXW9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3261
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

On Thu Apr 9, 2026 at 1:15 PM BST, Eliot Courtney wrote:
> Current `Gpu::new` will not unregister SysmemFlush if something fails
> after it is created, since it needs manual unregistering. Add a `Drop`
> implementation which will clean it up in that case. Maintain the manual
> unregister path because it can stay infallible, unlike the Drop path
> which depends on revocable access. In the case that `Gpu::new` fails the
> access is guaranteed to succeed, however.
>
> Fixes: 6554ad65b589 ("gpu: nova-core: register sysmem flush page")
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/fb.rs  | 29 ++++++++++++++++++++---------
>  drivers/gpu/nova-core/gpu.rs |  7 ++++++-
>  2 files changed, 26 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
> index bdd5eed760e1..edfbdc9a2512 100644
> --- a/drivers/gpu/nova-core/fb.rs
> +++ b/drivers/gpu/nova-core/fb.rs
> @@ -7,6 +7,7 @@
> =20
>  use kernel::{
>      device,
> +    devres::Devres,
>      dma::CoherentHandle,
>      fmt,
>      io::Io,
> @@ -16,7 +17,10 @@
>          Alignment, //
>      },
>      sizes::*,
> -    sync::aref::ARef, //
> +    sync::{
> +        aref::ARef,
> +        Arc, //
> +    },
>  };
> =20
>  use crate::{
> @@ -46,12 +50,14 @@
>  /// Because of this, the sysmem flush memory page must be registered as =
early as possible during
>  /// driver initialization, and before any falcon is reset.
>  ///
> -/// Users are responsible for manually calling [`Self::unregister`] befo=
re dropping this object,
> -/// otherwise the GPU might still use it even after it has been freed.
> +/// Users should call [`Self::unregister`] before unloading to ensure un=
registering is infallible.
> +/// [`Drop`] performs a best-effort fallback using revocable BAR access.
>  pub(crate) struct SysmemFlush {
>      /// Chipset we are operating on.
>      chipset: Chipset,
>      device: ARef<device::Device>,
> +    /// MMIO mapping of PCI BAR 0.
> +    bar: Arc<Devres<Bar0>>,
>      /// Keep the page alive as long as we need it.
>      page: CoherentHandle,
>  }
> @@ -60,6 +66,7 @@ impl SysmemFlush {
>      /// Allocate a memory page and register it as the sysmem flush page.
>      pub(crate) fn register(
>          dev: &device::Device<device::Bound>,
> +        devres_bar: Arc<Devres<Bar0>>,
>          bar: &Bar0,
>          chipset: Chipset,
>      ) -> Result<Self> {
> @@ -70,18 +77,17 @@ pub(crate) fn register(
>          Ok(Self {
>              chipset,
>              device: dev.into(),
> +            bar: devres_bar,
>              page,
>          })
>      }
> =20
>      /// Unregister the managed sysmem flush page.
> -    ///
> -    /// In order to gracefully tear down the GPU, users must make sure t=
o call this method before
> -    /// dropping the object.
>      pub(crate) fn unregister(&self, bar: &Bar0) {
>          let hal =3D hal::fb_hal(self.chipset);
> +        let registered_dma_handle =3D hal.read_sysmem_flush_page(bar);
> =20
> -        if hal.read_sysmem_flush_page(bar) =3D=3D self.page.dma_handle()=
 {
> +        if registered_dma_handle =3D=3D self.page.dma_handle() {
>              let _ =3D hal.write_sysmem_flush_page(bar, 0).inspect_err(|e=
| {
>                  dev_warn!(
>                      &self.device,
> @@ -89,8 +95,7 @@ pub(crate) fn unregister(&self, bar: &Bar0) {
>                      e
>                  )
>              });
> -        } else {
> -            // Another page has been registered after us for some reason=
 - warn as this is a bug.
> +        } else if registered_dma_handle !=3D 0 {
>              dev_warn!(
>                  &self.device,
>                  "attempt to unregister a sysmem flush page that is not a=
ctive\n"
> @@ -99,6 +104,12 @@ pub(crate) fn unregister(&self, bar: &Bar0) {
>      }
>  }
> =20
> +impl Drop for SysmemFlush {
> +    fn drop(&mut self) {
> +        let _ =3D self.bar.try_access_with(|bar| self.unregister(bar));

I feel that this is the wrong solution to the problem.

The thing we want is to *ensure* that `SysmemFlush` Drop is called with dev=
ice
still being bound.

It's not yet fully clear to me how we'd want to guarantee that, but one API=
 that
might make sense is to create a DevRes API that allows you to reference an
existing `DevRes` and have driver-core making sure that the tear down happe=
ns in
reverse order. So inside the `Drop` the `bar` can still be unconditionally
access.

Best,
Gary

> +    }
> +}
> +
>  pub(crate) struct FbRange(Range<u64>);
> =20
>  impl FbRange {
> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
> index 0f6fe9a1b955..5bad5a055b3b 100644
> --- a/drivers/gpu/nova-core/gpu.rs
> +++ b/drivers/gpu/nova-core/gpu.rs
> @@ -257,7 +257,12 @@ pub(crate) fn new<'a>(
>                      .inspect_err(|_| dev_err!(pdev, "GFW boot did not co=
mplete\n"))?;
>              },
> =20
> -            sysmem_flush: SysmemFlush::register(pdev.as_ref(), bar, spec=
.chipset)?,
> +            sysmem_flush: SysmemFlush::register(
> +                pdev.as_ref(),
> +                devres_bar.clone(),
> +                bar,
> +                spec.chipset,
> +            )?,
> =20
>              gsp_falcon: Falcon::new(
>                  pdev.as_ref(),
>
> ---
> base-commit: a7a080bb4236ebe577b6776d940d1717912ff6dd
> change-id: 20260409-fix-systemflush-de66dc90378a
>
> Best regards,
> -- =20
> Eliot Courtney <ecourtney@nvidia.com>

