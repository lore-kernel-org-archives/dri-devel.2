Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7179CDB46B
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 07:11:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 310E010E4DF;
	Mon, 22 Jun 2026 07:11:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="N9tM4ZxM";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010014.outbound.protection.outlook.com [52.101.61.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4498710E4E2
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 07:11:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Msdm1G8OqFRddja6BP7aTsqQJBdGCU0Iw7MkI8V/Wor68E0Rd/MfPI+0mrm5RLsSlIcFnrZmnX+6P00owbhFtwgeRuzjW/CEtDyX+lti5aI5nqBJdouvY5Bzp+8PnQFEUEKlGNH5wop4N5bPwAWYmtyexHkuX3YDwS6Gi6j7BI9FB948Dv6rwCbju60869YhvmRVMubVU1r/A587zF+pIuVv7fFY0VKrkbtUyGY3UqVsA+Hf3DtyDFkmDJRctraZgnIcoyaCEhOgWb/uYJej+6s7vrT27mnBAXgZbTqFR6Pku0ZejX8sUBXmDBW+p3suFS9vzxhz+UokZlaUJWHuEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KYn0/EbxFshFwFTdedBnGOml9WC8M9oW4Sr0HDAvMS8=;
 b=ewZfzD7aQXayrapeJCLoabrMOX/Ubsh510m6wX94NL2MZ2cuDaXnD3wkgWhk1HRbL3zaHWexHH9DLH62k39XA4wybGQH/93jcG5jGixjWaOgl0RjzPZc2asSkr4jEWKa2Eih4YBL/RU/9XEbYCxB4fmhZ2EP2HyRDncUPb7QbgnPWPWOSLlrT2cN5kTXoZH1kul45fRCVLgQp4Vvg4tZehZ3HvzAkX2taRNY/0K2iwqwxDvyovbyZh4+PXzxucG6yZOqvFq24pEg7QFrogUBTZrKu3eURtaz2tCWdRH6bZ+MFPfkfDA0p0CM3MKOWh8M7xnH/rzHhCxZ/D6hrMrLAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYn0/EbxFshFwFTdedBnGOml9WC8M9oW4Sr0HDAvMS8=;
 b=N9tM4ZxM/uk1cOMHft7c0//PlAlVDxzhe4JJDPsER3ewjPdSYmO8Yj+a0af39vtNsPu+gD8+VemhiTRNgvqp/1n+dm8KIRup0FHf+xR95ftCPdsG7JvXF7cfFwRruY46nnJ/6ktkPrJWbFISobeMN83Tyz/VuUmyA5KsLhaJ7G+Ws8REFBJDvYw5uGWABJpv1iMx9mK/BjrtMRHbDD38vXVFZYbmvobuj8avbtEOTNvIbgijUv325qPxgbZeVxmVTebuCH/Dlf406ZqqnFchCX/iIYmDMEu4EDniIAqrpc362kIpOcxBmzVtC34Q5Cr/WpiP8xV4cbkOjX/W1aRR7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by PH8PR12MB6700.namprd12.prod.outlook.com (2603:10b6:510:1cf::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 07:11:16 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 07:11:16 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 22 Jun 2026 16:10:26 +0900
Subject: [PATCH v2 04/13] gpu: nova-core: gsp: replace BootUnloadGuard with
 local handler
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-nova-bootcontext-v2-4-0ddeafc06f5d@nvidia.com>
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
X-ClientProxiedBy: TY4PR01CA0100.jpnprd01.prod.outlook.com
 (2603:1096:405:378::6) To MN2PR12MB3997.namprd12.prod.outlook.com
 (2603:10b6:208:161::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|PH8PR12MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: fae48b19-4722-4e66-6d59-08ded02d7362
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10070799003|18002099003|22082099003|3023799007|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: gVRe/t8mMfsfR8mBqDJA7hZmwbXduuuK8jbz76N2dLR6vVdxqFpmuNzdxbluobpFJDx0twkSM7jeke/7xAZSmEbUEdtQN0hXOniCavUOAXhRDy8hup9Kl9KDi3yHXxamUQlvxpjbTYp7T4dUmP13ouPiPmSK77cBdx1PnCs96qlIyew/wUMDSy3mPlRIRYxYa2BX5c0cKAUGnfSZCqbsoAGxwjDLmSfFG/VMZPS134JPjcFGSYobb9i9t0PxMe2ww3HDhK383bfH3isjZeN1L2mfWENcfiy84KZkc+6vAkAUqBNRsvmiGl/9xhnFpeoIuHaG9lepxxIzZeuLyJE92XFzF0QsMP+CCrzD+PEftumefRkbkAOa9jbTqPEheB6k+xlt/53a0oa6DLVdsbdkho51QDRAcQL7NMiJMc+gfIUIgz1rLbszAchq2QU+IFcf7efynV2cR3wgaI3kAGcIBR6EF7s96X35KbUY/AkizQybRWH8AAiaS8vEzkQPWk6bwhEL50S3MV0YnzkATCCBXBAstwFFKcuzx5Tbd+qZfLJkoTP+28f5yfD8YIMp80IUEDjTim/pVC8L2sBgKO7rmROJyaezm/qSXyftsIQjQVdfnfJ4vhL/elLs2ulcBNowV4jmmSNoAG2dAEtpT9sna4iy9UnF3jrPiVFaRvGmRks=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10070799003)(18002099003)(22082099003)(3023799007)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wlh2ZlMrbDZkdHlFSHk5MFc2YmdESE1jTU81alhPeDE4bHhGdmRTVFE1VnRW?=
 =?utf-8?B?NFk1SVRzRG5BU2pBMGZSQmdXT0Njck5IcmZaUDk0YmNEeG9mcng0QUpUMTQ4?=
 =?utf-8?B?K0F3aTgrZUM5dDM3ZTBXKzM0TVA0MytVcHF3dEZnWTZEMmVqdUk1b0N4a0hN?=
 =?utf-8?B?ZFZnbzNqYk5KbXpOdmxrWnliTmNOZ2JrNTdRV1c1YkFIREZiNU5YVUtGS3Nw?=
 =?utf-8?B?VTN6R2RNVkoxREJMNzk4T3hINW03NjlzVUx4SlhvcEZLckdDcFNoemhOQjR5?=
 =?utf-8?B?YldWTXREMjduMWFjVWtORFBuTncrSFJWTlhzUjBhRlVaWkVJdmVqcU5VeUh1?=
 =?utf-8?B?a2VhejZ1NnZJdlZTeWo4RkpsSVlDQWowWlFNdFVVeTR1S20yVTh3YU5vWU1m?=
 =?utf-8?B?bVR4ampyd28xL1NWbGdxL0srSXo0OWFvMmxSTGpRenVLaUFzcWE5MTh1VnFl?=
 =?utf-8?B?K29nRGhRSXVkbFEyM2tveGRoODhwTW4vcHJmaFhrTFFKS0FJVitlZGZGK0Nq?=
 =?utf-8?B?OWcrTlBzMzJWeWNUWjJjb2hGQVBjZ2lER3A0bzRyWnNhdG51TzJEa0pINit2?=
 =?utf-8?B?d2NJT3F6TndJRHUycU9WdTBmbnFPWGREWStkWUJlaXNJSEljZ1VHb3ZxTDNO?=
 =?utf-8?B?M1R3dWwvbFlsZUlwYUJoR0hVb2NHOEtQKzhhSklzRklPbXU1OXY1cy9zVkFx?=
 =?utf-8?B?MjBNMWxvMHNKaUErWHZ3aXRsZ2FaeEM5d3g0YlVZMWxHYVE0bmYwangzZEJw?=
 =?utf-8?B?VFlUNDNqRzg3ZFpYZTJvYUFVNkdxTklpYXhzNnYrSDZzZFNtNm4yOWpTVnpM?=
 =?utf-8?B?cVFPZk40bHNDSlBJZDdxbXQwL3cxdEtVb0xFVjdkK2h1WXZNNWI2bkdnUmla?=
 =?utf-8?B?MHV2c2Q1dVZTcnh4d01iRUE5M2VMNkZwSDRaVE1ueEFORlJJOVRJNzhHdENU?=
 =?utf-8?B?akw3U3ZpTFQ3dG9XYU1wTFZRblFNNGlXd256ZE9qVzFNOUhicVZ1Q0lIaVFY?=
 =?utf-8?B?eWV2Tk9yMVo3amVKRjRRdzZCekQzR2hCS2VDNGd1TU9Fd2l3eWFEYjN6QXVq?=
 =?utf-8?B?V3hzU1A0ZFY0RUEzZVFoaG0rRlJZcDhmajhxSHZ6MGU2bWs2bXg3Tnl1K3dN?=
 =?utf-8?B?TUZmRytBblVDZ1JrK2Zrc0N4cCtSa05CbUcvOUs5ZlE0b3Vjaitma3JFNTRZ?=
 =?utf-8?B?cEcrTWhxdFRHektaeXViSEFtZWhDc3plSmduWjExVHpvQlQ2UFM0dUtDMnBQ?=
 =?utf-8?B?WW9EQVhkV0M3NTN1N2VoMmJ4b3pDNUp4MjdMOGZ2MmJkaXNObHN0V0h4VXkr?=
 =?utf-8?B?T3FLbW1Jdk1CVGZkWk13ekY2eVRCRVJUY2phMjdXY01hZGZTUVdHZjFHYnNE?=
 =?utf-8?B?OWVJbFoxaXF0bU5vY1kvYkFmL2FvVmE2V0VvNzFaNThRT1dMait6NmxwblAr?=
 =?utf-8?B?enJ5SDRlUEQxZGsvUGVJRk1wTjJJbjVBN2NyUHU4NSthajF5R05Ud0YxVGFG?=
 =?utf-8?B?SzlUVHp3Z3Z5by9RRjhtNXJndCt5NDBVUUUyOXhTZDNZcjJRSnRRNTN5WC95?=
 =?utf-8?B?b1NKWDh0NGt1VGFKb1U0VmQ5b3FVMHRscXVueGlNQzZDWlcwdUZzT2VhMTd6?=
 =?utf-8?B?WUZUOEx3Y3U3Qmc1d1c2L01rRnBIb1dmdi8vSkdBRi9yVko5OWdSQzluYUhr?=
 =?utf-8?B?NTRDSlRxdFR2U1VPd2E4YW80TzRCYlJEemt4ZkxXdUQ3ZExvd3NMZUtoVmtq?=
 =?utf-8?B?NjFDNFdCa1g4eTh2bDBrRFdtS25NWFB6TEZSMHVkb1JUSUUwZTh1eUpqeG5Q?=
 =?utf-8?B?NDRwa0Q4T1VpRHllNW5ld1pSRVJET1loWWRzMWVhY0YvNW1NQ3VhMS9FOGFz?=
 =?utf-8?B?SWw4cnNXR0hsMzNJV2kxRXRRYnhjS25aU0swNzErRmFabm9kdGZBSzcrb1l5?=
 =?utf-8?B?NjBJWU5yN2d6ZnVVRzcyWldvMHh1M3c1a0VnVWZwYllzbzFLTDFIMFBOcmJB?=
 =?utf-8?B?Z2UzZGRDNEpYRXBtQnRCSTRmVjNsM1ZrN3hHK3Q5ZFRFci9vWFNpNHFsbFox?=
 =?utf-8?B?OHRWOXJ4YjRqQ05mcHFDVGh2SDVSdFdaY0VYek1uSHVlVCtybk04aS9ZejFZ?=
 =?utf-8?B?RzRyeDYyallGamlPSGJDS0YxY0lBWjErWE5HUkdmRGNiVk5pMlFJVzdjb1NN?=
 =?utf-8?B?cE5hQWZQR1BHRk1aY2hHM0lOMFpHUmZ2Y1ZEYlZBaHVTWUhyZjYydDZaN3R4?=
 =?utf-8?B?YjFOVWQySWtNU0t1MVVUVFpCK0tYWHBDSjFWdm05blV4K010N2tZRVFpNGl1?=
 =?utf-8?B?YXArUjBFOEIycHluZ0k2bmh3bExjYWJLQ2EwN1FFQy81NTh2YkE1Q0tXa1Y0?=
 =?utf-8?Q?0THnNsAH1KuhrHnZJJBrA39lsWfG/6RVeSQ5nhKZF+Bo6?=
X-MS-Exchange-AntiSpam-MessageData-1: 7t7k0W/4QqEbRA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fae48b19-4722-4e66-6d59-08ded02d7362
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 07:11:16.2107 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +hBHGEwOpGXI6mm82yTsEHP+xTYV2pKyJ9up/art01VgkMg8K6wgQ8+dX8AuMA2Qvun5dG+96HNG98vwx9w3aw==
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

When adding the GSP unload capability, we introduced new types to
support what is effectively an ad-hoc behavior: that `Gsp::unload` must
be run if any error occurs during the boot sequence.

Furthermore, `BootUnloadGuard` is problematic because it holds
additional references to the boot context, notably the `Falcon`s. These
extra references stand in the way of making some of the `Falcon`'s
methods mutable, since those methods would require exclusive access. As
this behavior is only needed in one place, introducing dedicated types
for it is distracting and unnecessary.

Thus, take advantage of the local closures introduced in the preceding
patch to run the unload sequence in `Gsp::boot` if an error occurred at
any step of the boot process.

This slightly broadens the failure cleanup path, as `Gsp::boot` now
attempts a best-effort `Gsp::unload` even when the failure happened
before the unload bundle was prepared.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/boot.rs      | 81 ++++++----------------------------
 drivers/gpu/nova-core/gsp/hal.rs       | 20 ++++++---
 drivers/gpu/nova-core/gsp/hal/gh100.rs | 28 +++++-------
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 23 ++++------
 4 files changed, 47 insertions(+), 105 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 9eccfd634b61..3574f1a87344 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -7,8 +7,7 @@
     dma::Coherent,
     io::poll::read_poll_timeout,
     prelude::*,
-    time::Delta,
-    types::ScopeGuard, //
+    time::Delta, //
 };
 
 use crate::{
@@ -30,66 +29,6 @@
     },
 };
 
-/// Arguments required to call [`Gsp::unload`](super::Gsp::unload).
-///
-/// Stored as their own type to avoid repeating a long and tedious list in [`BootUnloadGuard`].
-pub(super) struct BootUnloadArgs<'a> {
-    gsp: &'a super::Gsp,
-    dev: &'a device::Device<device::Bound>,
-    bar: Bar0<'a>,
-    gsp_falcon: &'a Falcon<Gsp>,
-    sec2_falcon: &'a Falcon<Sec2>,
-    unload_bundle: Option<super::UnloadBundle>,
-}
-
-/// Guard that calls [`Gsp::unload`](super::Gsp::unload) with a
-/// [`UnloadBundle`](super::UnloadBundle) when dropped.
-///
-/// Used to ensure the `UnloadBundle` is run during failure paths.
-pub(super) struct BootUnloadGuard<'a> {
-    guard: ScopeGuard<BootUnloadArgs<'a>, fn(BootUnloadArgs<'a>)>,
-}
-
-impl<'a> BootUnloadGuard<'a> {
-    /// Wraps `unload_bundle` into a guard that executes it when dropped.
-    pub(super) fn new(
-        gsp: &'a super::Gsp,
-        dev: &'a device::Device<device::Bound>,
-        bar: Bar0<'a>,
-        gsp_falcon: &'a Falcon<Gsp>,
-        sec2_falcon: &'a Falcon<Sec2>,
-        unload_bundle: Option<super::UnloadBundle>,
-    ) -> Self {
-        Self {
-            guard: ScopeGuard::new_with_data(
-                BootUnloadArgs {
-                    gsp,
-                    dev,
-                    bar,
-                    gsp_falcon,
-                    sec2_falcon,
-                    unload_bundle,
-                },
-                |args| {
-                    let _ = super::Gsp::unload(
-                        args.gsp,
-                        args.dev,
-                        args.bar,
-                        args.gsp_falcon,
-                        args.sec2_falcon,
-                        args.unload_bundle,
-                    );
-                },
-            ),
-        }
-    }
-
-    /// Disarms the guard and returns the [`UnloadBundle`](super::UnloadBundle) it contains.
-    pub(super) fn dismiss(self) -> Option<super::UnloadBundle> {
-        self.guard.dismiss().unload_bundle
-    }
-}
-
 impl super::Gsp {
     /// Attempt to boot the GSP.
     ///
@@ -118,10 +57,11 @@ pub(crate) fn boot(
         let wpr_meta = Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::new(&gsp_fw, &fb_layout))?;
 
         // Perform the chipset-specific boot sequence, and retrieve the unload bundle.
-        let unload_guard = hal.boot(&self, &ctx, &fb_layout, &wpr_meta)?;
+        let (res, unload_bundle) = hal.boot(&self, &ctx, &fb_layout, &wpr_meta);
+
         // Run from a closure so we can retrieve the result, and run the unload sequence of the GSP
         // in case of error.
-        let res = (|| {
+        let res = res.and_then(|()| {
             gsp_falcon.write_os_version(bar, gsp_fw.bootloader.app_version);
 
             // Poll for RISC-V to become active before continuing.
@@ -143,11 +83,18 @@ pub(crate) fn boot(
 
             // Wait until GSP is fully initialized.
             commands::wait_gsp_init_done(&self.cmdq)
-        })();
+        });
 
         match res {
-            Err(e) => Err(e),
-            Ok(()) => Ok(unload_guard.dismiss()),
+            Err(e) => {
+                dev_err!(dev, "GSP boot failed with error {:?}\n", e);
+
+                // Ignore errors during unload; we will return the error that happened during boot.
+                let _ = self.unload(dev, bar, gsp_falcon, ctx.sec2_falcon, unload_bundle);
+
+                Err(e)
+            }
+            Ok(()) => Ok(unload_bundle),
         }
     }
 
diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/gsp/hal.rs
index 51a277fe97bb..a76be4e43272 100644
--- a/drivers/gpu/nova-core/gsp/hal.rs
+++ b/drivers/gpu/nova-core/gsp/hal.rs
@@ -24,7 +24,6 @@
         Chipset, //
     },
     gsp::{
-        boot::BootUnloadGuard,
         Gsp,
         GspBootContext,
         GspFwWprMeta, //
@@ -51,15 +50,22 @@ fn run(
 pub(super) trait GspHal: Send {
     /// Performs the GSP boot process, loading and running the required firmwares as needed.
     ///
-    /// Upon success, returns a guard that runs the GSP unload sequence if GSP boot does not
-    /// complete.
-    fn boot<'a>(
+    /// Returns two things:
+    ///
+    /// - The `Result` of the boot process itself,
+    /// - The `UnloadBundle` to use with [`Gsp::unload`], or `None` if the bundle could not be
+    ///   created.
+    ///
+    /// Note that the two returned values are independent: it is possible for the boot process to
+    /// succeed while the unload bundle couldn't be created. In this case, the GSP won't be able to
+    /// unload properly and a full GPU reset is required before the GSP can be booted again.
+    fn boot(
         &self,
-        gsp: &'a Gsp,
-        ctx: &GspBootContext<'a>,
+        gsp: &Gsp,
+        ctx: &GspBootContext<'_>,
         fb_layout: &FbLayout,
         wpr_meta: &Coherent<GspFwWprMeta>,
-    ) -> Result<BootUnloadGuard<'a>>;
+    ) -> (Result, Option<crate::gsp::UnloadBundle>);
 
     /// Performs HAL-specific post-GSP boot tasks.
     ///
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index 776f61b8b9d7..ece40403b831 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -23,7 +23,6 @@
         Fsp, //
     },
     gsp::{
-        boot::BootUnloadGuard,
         hal::{
             GspHal,
             UnloadBundle, //
@@ -145,27 +144,24 @@ impl GspHal for Gh100 {
     ///
     /// This path uses FSP to establish a chain of trust and boot GSP-FMC. FSP handles
     /// the GSP boot internally - no manual GSP reset/boot is needed.
-    fn boot<'a>(
+    fn boot(
         &self,
-        gsp: &'a Gsp,
-        ctx: &GspBootContext<'a>,
+        gsp: &Gsp,
+        ctx: &GspBootContext<'_>,
         fb_layout: &FbLayout,
         wpr_meta: &Coherent<GspFwWprMeta>,
-    ) -> Result<BootUnloadGuard<'a>> {
+    ) -> (Result, Option<crate::gsp::UnloadBundle>) {
         let dev = ctx.dev();
         let bar = ctx.bar;
         let chipset = ctx.chipset;
         let gsp_falcon = ctx.gsp_falcon;
-        let sec2_falcon = ctx.sec2_falcon;
+
+        let mut unload_bundle = None;
 
         let res = (|| {
-            let unload_bundle = crate::gsp::UnloadBundle(
-                KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn UnloadBundle>
-            );
-
-            // Wrap the unload bundle into a drop guard so it is automatically run upon failure.
-            let unload_guard =
-                BootUnloadGuard::new(gsp, dev, bar, gsp_falcon, sec2_falcon, Some(unload_bundle));
+            unload_bundle = Some(crate::gsp::UnloadBundle(
+                KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn UnloadBundle>,
+            ));
 
             let mut fsp = Fsp::wait_secure_boot(dev, bar, chipset)?;
 
@@ -179,12 +175,10 @@ fn boot<'a>(
 
             fsp.boot_fmc(dev, bar, fb_layout, &args)?;
 
-            wait_for_gsp_lockdown_release(dev, bar, gsp_falcon, args.boot_params_dma_handle())?;
-
-            Ok(unload_guard)
+            wait_for_gsp_lockdown_release(dev, bar, gsp_falcon, args.boot_params_dma_handle())
         })();
 
-        res
+        (res, unload_bundle)
     }
 }
 
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index 9b24361f924b..fca8da281e16 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -32,7 +32,6 @@
     },
     gpu::Chipset,
     gsp::{
-        boot::BootUnloadGuard,
         hal::{
             GspHal,
             UnloadBundle, //
@@ -264,19 +263,21 @@ fn run_fwsec_frts(
 struct Tu102;
 
 impl GspHal for Tu102 {
-    fn boot<'a>(
+    fn boot(
         &self,
-        gsp: &'a Gsp,
-        ctx: &GspBootContext<'a>,
+        gsp: &Gsp,
+        ctx: &GspBootContext<'_>,
         fb_layout: &FbLayout,
         wpr_meta: &Coherent<GspFwWprMeta>,
-    ) -> Result<BootUnloadGuard<'a>> {
+    ) -> (Result, Option<crate::gsp::UnloadBundle>) {
         let dev = ctx.dev();
         let bar = ctx.bar;
         let chipset = ctx.chipset;
         let gsp_falcon = ctx.gsp_falcon;
         let sec2_falcon = ctx.sec2_falcon;
 
+        let mut unload_bundle = None;
+
         let res = (|| {
             let bios = Vbios::new(dev, bar)?;
 
@@ -284,7 +285,7 @@ fn boot<'a>(
             //
             // If the unload bundle creation fails, the GPU will need to be reset before the driver
             // can be probed again.
-            let unload_bundle =
+            unload_bundle =
                 Sec2UnloadBundle::build(dev, bar, chipset, &bios, gsp_falcon, sec2_falcon)
                     .inspect_err(|e| {
                         dev_warn!(dev, "Failed to prepare unload firmware: {:?}\n", e);
@@ -297,10 +298,6 @@ fn boot<'a>(
                     .ok()
                     .map(crate::gsp::UnloadBundle);
 
-            // Wrap the unload bundle into a drop guard so it is automatically run upon failure.
-            let unload_guard =
-                BootUnloadGuard::new(gsp, dev, bar, gsp_falcon, sec2_falcon, unload_bundle);
-
             // FWSEC-FRTS is not executed on chips where the FRTS region size is 0 (e.g. GA100).
             if !fb_layout.frts.is_empty() {
                 run_fwsec_frts(dev, chipset, gsp_falcon, bar, &bios, fb_layout)?;
@@ -328,12 +325,10 @@ fn boot<'a>(
                 sec2_falcon,
                 bar,
             )?
-            .run(dev, bar, sec2_falcon, wpr_meta)?;
-
-            Ok(unload_guard)
+            .run(dev, bar, sec2_falcon, wpr_meta)
         })();
 
-        res
+        (res, unload_bundle)
     }
 
     fn post_boot(&self, gsp: &Gsp, ctx: &GspBootContext<'_>, gsp_fw: &GspFirmware) -> Result {

-- 
2.54.0

