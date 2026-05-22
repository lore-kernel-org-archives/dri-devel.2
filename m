Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE2CACD5BAF
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 06:59:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A587610F4C4;
	Fri, 22 May 2026 06:59:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ahrDKBFa";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010012.outbound.protection.outlook.com [52.101.46.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C88410F4C4;
 Fri, 22 May 2026 06:59:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QxtpdkCvk0zrCSH4IraYe/kC/x732swJ1tMZ0+m8pDNPCJsG81H7UwFfFrfar9PSzrLjpfqH3S8r/QjPrVmR3+UNz/JfyosdcvWprzArMlP92mCnOCkLUZq/8rC3xi3vGvf4y1sdPQaPvP6l77wedI4tRfBQsvCLUdZ6C4D7KqMH26z80lZMcxkavSR/5yD4QLD9ErzOufbHDtwbVIdS/aHQ9lxQwimfqZ2mqL1T4yJGPhPUBofuhXCxDI8zU3UUF9GOe/T7skltcd1GC2ER42svpywgAnTZg1LdnjgrdPkgss6wFYTCqBBFzKIM9V6a6tsriJRQtve4la1bTInijw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+SR2LXzM+Si8ZM9ejs86YmvdcqFAp3bO/FlZghvpgg=;
 b=DBNGNeEjEkzflsPK3xnj1iXyfd5neVdOx/txOxZaZwQIjJ3JJM4Hy9pnpegTypEgyjaoS5+2CRB/1acFaTw+0rmPSe+EOhSSzxxoQlgk04WQ7u5VThkARFEZFjckT5j6depXYY0tahIOTCot4s5gaF+cPiRCiDMR0xg/qwdKAP37V8SXL5+EYkupNmWNzd6nKatRPMrlvNBQT+g9iJY7YTHgA0hlFTnHEv688+2JKu79qyOK1dTxbuY71RKMTfJp7WpbBHFkNmsuOH1KwSyE0s6THGQmwj/dQP+r+saK9ObH/F5uVXhQIz9w2tcugHIvUwweSYJxTHHyAPu/CzNPsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+SR2LXzM+Si8ZM9ejs86YmvdcqFAp3bO/FlZghvpgg=;
 b=ahrDKBFaqOUooRykwnqMMkh44+RZjLvgF5kIfaBEZ+btd27b3MiXoD2Y+MICstigr7PbW/oGorUJMguj0ycxEa9yG64ikypHvFA4Fa4RZIhZqzJ4DXpiRoggDS2JrZfrAGRmtHlMOG1xHwZ8ylM6UBUd/NAxJazPxfijYwG7MbYOXvAjfQOWRrDCf/gIzzEaRRgxUOuolEBVWVcKyYPep1bvBaosw7GJA0mU2fwy1U1eOvXIUvxgGtbACNMGPLegWk/xLEpFFG3d/E9HwanxqsPsIACoZJ0K5MaHmOMq3xP5U/wYsFLaY6JNaJ16TSFHcPpfGvYS5QOsfBC5v08b/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Fri, 22 May
 2026 06:59:21 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 06:59:21 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 22 May 2026 15:59:18 +0900
Message-Id: <DIP0EROV7VSK.1WYD6SKNI05UD@nvidia.com>
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v6 7/7] gpu: nova-core: run Booter Unloader and FWSEC-SB
 upon unbinding
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260521-nova-unload-v6-0-65f581c812c9@nvidia.com>
 <20260521-nova-unload-v6-7-65f581c812c9@nvidia.com>
In-Reply-To: <20260521-nova-unload-v6-7-65f581c812c9@nvidia.com>
X-ClientProxiedBy: TYWPR01CA0045.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::15) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DM6PR12MB4090:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d50e470-8980-4c6d-4a5e-08deb7cfa665
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|366016|3023799007|4143699003|22082099003|18002099003|11063799006|7136999003|11062099010|56012099003|6133799003;
X-Microsoft-Antispam-Message-Info: u8bzfwwNUBcJSrWEG+I6MsJD5aCkk+FmTgNq+1pKCVrEllibAR/fjLQo8VQksXhE0mkaGdphP1oeQA5sctTn/jKvcCB6uu0v6Hw2m2rRChi5gpQSiNMSOhDZSWZeeNrQR93PJdTRPhXRcIRYDQD33gVMwG+xvRGOPjn3kqE7C5wXs7YSa14D9/yfzDCUuDjmN6bKttNwH1tjrTlxAiZEpVPGexTyy4z7owwNpkm7YQUDk1MzjcXXCr+2Zg/KhbMhZtVEd1450KA49yb6WgcXWmbgt6CYNklC4uBr2fajrTwV2EHrl/gSr1legOy821Alw3h2dsxKh1BJvFX9crI0jV7auSrWeClEMWWLZ16egdqzT/U74yS4UG+eCWV62LEArRJ/H8f4nWKyh+BYnQddA37P91iQTYa4AkFT+fAHfpTDvVYYk1n2hMq7yaBPqPukzjRCbnHIWv3sJ+Y+tvy7VV2v2yOtJWu+etAJ/XYTz4yKiRNZsEdzZMOvolmhTE/FQVoDpcRa6DsyFZvQZiQVk8yN+UJHIq5kvfU+QN8rmbqDGiMY6Sojl/Sk95+4GjFAXFYHEZF6zZsjrk7gA8vfe4adlCCXvkpdBEk0FFF50MujiwvqHY6zWSw+fU3VKIZy38jhDm4Vk7JWHoSIVP4n/gy9Qi7xH9XwwbxP2woPuReSNhUyKrI6FEdQ18QpQ7mq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(3023799007)(4143699003)(22082099003)(18002099003)(11063799006)(7136999003)(11062099010)(56012099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZG91VkY5MzRZUm1HMGZGVlQxckZtRGFsUVVqSzFhTEsyMis3UWgrQzhRZlhi?=
 =?utf-8?B?Z0NvS29GVzFqTzdBNklFYU9wY1ZiRmdnc3FkeHlYQjFObllHem15M29SdSs0?=
 =?utf-8?B?QmFDMmgwOWdKc0lHUG9TZkNHbWc5V1ZTK3M2NjFMTWhJbmFjWStoRzAvUVRZ?=
 =?utf-8?B?TUkxMktVeEVmcEpTT2pHU0hmUkgxb05GcFlNc2hvZGVuc0FEcGFJSFQ4VFNC?=
 =?utf-8?B?bkt5S1JKS1BzZU9aKzFseFZlbjZQM2FIZDRhNlVIV3dyenE5aG1ZUjc3OXRv?=
 =?utf-8?B?bEhZV0xxNGhCdzdOVEZTbWRiR2puYzU5K0lwRzQ5VWxvd1FmREVlQ3lmaVRS?=
 =?utf-8?B?Ym9ScW5sS09DSmd0RTM3NG9zS1U5UUFkMGpvTi9mZUxRc0RsWHZyMTdWUnVk?=
 =?utf-8?B?WU5DQXZWcDdGbFZQZFBGZ0lCZmx2c1dzRVM5TWw2ckc3TkZBbXIrSDVmVWlZ?=
 =?utf-8?B?VEdWVHRpVHFPUUVhUkVZNmZSRk1qbzhGRGNYTXBvbCswcXMrY05ySWxONWto?=
 =?utf-8?B?VFRXUllaVE9PSVZ0SnlKT0hmcHA4R012S2R5UXhnR21TWFNHWXhjSS9JZm1t?=
 =?utf-8?B?eEN3VUsxQWkrRVd4V3NZVnFUWWJFZC9jRTlBbE5STnF3MTJielNmY2tqeWNj?=
 =?utf-8?B?ODFhakJCamtVSkhKL0RpcFY3VnJGK3lDdHR4elAweWZnVVptY0tDNVVZVGgw?=
 =?utf-8?B?ZHp6aGtpTVQrY0xrSWQrNzEwaXFWUXRrWWRSNDNYSC94MVpVQUlkS0JPNjdK?=
 =?utf-8?B?WlJ0VTJ5UGNodVI0ZGZha2xSWmMvUm1GQUtRLzV5aExXVXcrM0JhNnRpdGhN?=
 =?utf-8?B?YlBkMGtLN0trY0VKUUQwR3RSY1hhMkRQSDlzKzVidnJ6a2prWWo1eXYyTGxS?=
 =?utf-8?B?MU9ZOFQ1MkFyemw2Y09SV2lNMXRwcjM1SXFkMHZ3c2pCakx1cjZrUDY3RU5h?=
 =?utf-8?B?UUk0UEpKV0V2TDEyZlcrY3MySEY1MEZSa0JvQlNpQVNhVzl1b2hSNEwyTVlJ?=
 =?utf-8?B?U21URHBtcVd6RU14RzUxdjNOS01UcSsvRS9QY2FrMUh5KzI3MWNnNkViZ1F6?=
 =?utf-8?B?WDRNVVZCclQyMVJWT3Y0QVhYWTZFbjEyL3d4eVFOOEdiaU1MYytwRDgrMEJS?=
 =?utf-8?B?anZaWEZEbVBnaTc5cUNCTkcyc256Y2YxUmtBTGlDb3d5SmJUc3NtL1pURm4w?=
 =?utf-8?B?Z0pQUUJ2YlFsV2VhWGYzcDBNem9LaGo3U0UrU3NmcjhNL1FTbVo1em1uL2dI?=
 =?utf-8?B?dDE2VXFpVUJqOW9xQzZiY1RNOW9Bb0w0em10QTZKaEVHQVdER05wRld0Uklr?=
 =?utf-8?B?TWltbGJwMGVUQ0w3ZjZzb2w5RWxkRHQxQnQ3aU1NVDFSNFlUKzA0WTlpRmVw?=
 =?utf-8?B?bTZrcnNielh0M2RuejBnS2FtKzZnZUNtSThESmpCUlk1eVBxbTF1M0dCQmp0?=
 =?utf-8?B?ckdIRzA0U2s2S2ZneHRsSU5RSlNVZFJLbm9nVlNpdm1Ta2Z0amtKUUo2ZnpI?=
 =?utf-8?B?Z3RzMWh6Z1R3eEIyejZCaU9DeFhlSG4xeWlMT2ZLSTdKSkpaaGszUDNhWmV2?=
 =?utf-8?B?SXRXdEJIcHRXeWlWMnEyOGZCcXlOdzArS0ZyNVhIRG5sZjdpTDJNeXVBcDJq?=
 =?utf-8?B?eGQ4WjBLRWJqSGZhd3RnYkF6Zit1bktxRnllRzhsRmhzb0ZCbzlKajBvQ2ht?=
 =?utf-8?B?UTNGSldncTZsalY5S1RnRFd6YkNmL2hveHRFWnRCcHViOUhPMnhkTERMbjlP?=
 =?utf-8?B?cEZTa2JUaXVhN2FOd0s3TTFWYUFDcElhK01lSkVvTEt0eWp0Y0l3TjVuVFZa?=
 =?utf-8?B?Wk9DYi9KY0pUUitENHN5NVRKK1BSaVFhRC8yWnBoQ1dUcVFFUkJyK1ZHUUI3?=
 =?utf-8?B?RWpGOFE1SFUzMTJsNXNpZXRtQTFiZlFwZzY3QkdXQWQvM2JVRm00RGtxRk9X?=
 =?utf-8?B?aHlvdngrdkF4VDVqSzVMbmZKN2hKK3dYOW1UWUNBQ21ROG5wNjRpQ21mVGFw?=
 =?utf-8?B?YS9TdmJQcDJWY2RvQU1VUWM1cGlCdXlmU2tGUXlsbHJRRTJCNlZiSHlITW9w?=
 =?utf-8?B?ODFNOEMzUVkzaUx5MmgwbHpuQUxvelh1VVo2ZU91bU9JS2ptSjBVcGExVDlF?=
 =?utf-8?B?V2Q0Y0MxMm1jbHF1UjdwTTBDa0NWTytWUFF1TkRUUnRDbGNYUXp6WG1rMkNa?=
 =?utf-8?B?ZFhWVGVRTzAzV3h4Tzd6Zmk2WDNpY2c5bTN2SDJETUVscFFzc0UwNTNueGhS?=
 =?utf-8?B?U2Zoem5VWEw3b1RVZVRZVW9qa0JDRGUyVzNWWUhBbGxoRTNhT2pUY0VKRjYv?=
 =?utf-8?B?Q2VmY08vYmI3cjE1QXFCN0gzNW5RTW81N0VJK1JuYVlUOEN1aytmSGhTK3VZ?=
 =?utf-8?Q?F8C6HOARGv299HQee40mZglEH9swiYYHWA78duzczpABO?=
X-MS-Exchange-AntiSpam-MessageData-1: gFf2xUB4agJ1MA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d50e470-8980-4c6d-4a5e-08deb7cfa665
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 06:59:21.3493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W9dmLc1QGN2gYIj4jE9NcJ8CBsfWxuwVfB9FYJrtEA4ijYaz5XPdn16SaUMhQWaq62xYxir+QK/jxbcU75Heag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4090
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

On Thu May 21, 2026 at 10:50 PM JST, Alexandre Courbot wrote:
> When probing the driver, the FWSEC-FRTS firmware creates a WPR2 secure
> memory region to store the GSP firmware, and the Booter Loader loads and
> starts that firmware into the GSP, making it run in RISC-V mode.
>
> These operations need to be reverted upon unloading, particularly the
> WPR2 secure region creation, as its presence prevents the driver from
> subsequently probing.
>
> Thus, prepare the Booter Unloader and FWSEC-SB firmwares when booting
> the GSP, so they can be executed at unbind time to put the GPU into a
> state where it can be probed again.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---

After seeing the bundle moved outwards, I realised that it has the same
issue that SysmemFlush does, i.e. if probe fails it does not reset the
GSP. A lot of the time during development I will break things badly
enough that probe fails, so it would be nice if this is supported. OTOH,
this gets the probe suceed and unload case working which is important
and this is a definite improvement, so for this version and the previous
version of the patch:

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

I also had a brief go at making this work on Drop, here is the diff on
top of this series. I can send this as a follow up if you would like
after cleaning it up, or lmk wdyt:

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver=
.rs
index 20d38a64dcc7..6571a8c59d09 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
=20
-use core::cell::Cell;
-
 use kernel::{
     auxiliary,
     device::Core,
@@ -23,10 +21,7 @@
     types::ForLt,
 };
=20
-use crate::{
-    gpu::Gpu,
-    gsp, //
-};
+use crate::gpu::Gpu;
=20
 /// Counter for generating unique auxiliary device IDs.
 static AUXILIARY_ID_COUNTER: Atomic<u32> =3D Atomic::new(0);
@@ -38,10 +33,6 @@ pub(crate) struct NovaCore<'bound> {
     bar: pci::Bar<'bound, BAR0_SIZE>,
     #[allow(clippy::type_complexity)]
     _reg: Devres<auxiliary::Registration<ForLt!(())>>,
-    /// GSP unload bundle, if any.
-    ///
-    /// Stored into a `Cell` so it can be [taken](Cell::take) without a mu=
table reference.
-    unload_bundle: Cell<Option<gsp::UnloadBundle>>,
 }
=20
 const BAR0_SIZE: usize =3D SZ_16M;
@@ -103,8 +94,6 @@ fn probe<'bound>(
             // other threads of execution.
             unsafe { pdev.dma_set_mask_and_coherent(DmaMask::new::<GPU_DMA=
_BITS>())? };
=20
-            let mut unload_bundle =3D None;
-
             Ok(try_pin_init!(NovaCore {
                 bar: pdev.iomap_region_sized::<BAR0_SIZE>(0, c"nova-core/b=
ar0")?,
                 // TODO: Use `&bar` self-referential pin-init syntax once =
available.
@@ -112,7 +101,7 @@ fn probe<'bound>(
                 // SAFETY: `bar` is initialized before this expression is =
evaluated
                 // (`try_pin_init!()` initializes fields in declaration or=
der), lives at a pinned
                 // stable address, and is dropped after `gpu` (struct fiel=
d drop order).
-                gpu <- Gpu::new(pdev, unsafe { &*core::ptr::from_ref(bar) =
}, &mut unload_bundle),
+                gpu <- Gpu::new(pdev, unsafe { &*core::ptr::from_ref(bar) =
}),
                 _reg: auxiliary::Registration::new(
                     pdev.as_ref(),
                     c"nova-drm",
@@ -122,15 +111,7 @@ fn probe<'bound>(
                     crate::MODULE_NAME,
                     (),
                 )?,
-                unload_bundle: Cell::new(unload_bundle),
             }))
         })
     }
-
-    fn unbind<'bound>(
-        dev: &'bound pci::Device<kernel::device::Core>,
-        this: Pin<&'bound Self::Data<'bound>>,
-    ) {
-        this.gpu.unbind(dev, this.unload_bundle.take())
-    }
 }
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 5af04901b512..605eaba5d90a 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -246,8 +246,10 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Resu=
lt {
 }
=20
 /// Structure holding the resources required to operate the GPU.
-#[pin_data]
+#[pin_data(PinnedDrop)]
 pub(crate) struct Gpu<'bound> {
+    /// Device owning the GPU.
+    device: &'bound device::Device<device::Bound>,
     spec: Spec,
     /// MMIO mapping of PCI BAR 0.
     bar: &'bound Bar0,
@@ -261,24 +263,23 @@ pub(crate) struct Gpu<'bound> {
     /// GSP runtime data. Temporarily an empty placeholder.
     #[pin]
     gsp: Gsp,
+    /// GSP unload firmware bundle, if any.
+    unload_bundle: Option<gsp::UnloadBundle>,
 }
=20
 impl<'bound> Gpu<'bound> {
     /// Create a new [`Gpu`] instance.
     ///
     /// `pdev` is the PCI device for the GPU, `bar` is its `Bar0` mapping.
-    ///
-    /// `unload_bundle` is an output parameter, where the [GSP unload bund=
le](gsp::UnloadBundle) is
-    /// to be written. The driver layer will pass the written value back t=
o [`Gpu::unbind`].
     pub(crate) fn new<'init>(
         pdev: &'bound pci::Device<device::Bound>,
         bar: &'bound Bar0,
-        unload_bundle: &'init mut Option<gsp::UnloadBundle>,
     ) -> impl PinInit<Self, Error> + 'init
     where
         'bound: 'init,
     {
         try_pin_init!(Self {
+            device: pdev.as_ref(),
             spec: Spec::new(pdev.as_ref(), bar).inspect(|spec| {
                 dev_info!(pdev,"NVIDIA ({})\n", spec);
             })?,
@@ -303,24 +304,24 @@ pub(crate) fn new<'init>(
=20
             gsp <- Gsp::new(pdev),
=20
-            _: { *unload_bundle =3D gsp.boot(pdev, bar, spec.chipset, gsp_=
falcon, sec2_falcon)? },
+            unload_bundle: gsp.boot(pdev, bar, spec.chipset, gsp_falcon, s=
ec2_falcon)?,
         })
     }
+}
=20
-    pub(crate) fn unbind(
-        &self,
-        pdev: &'bound pci::Device<device::Core>,
-        unload_bundle: Option<gsp::UnloadBundle>,
-    ) {
-        let _ =3D self
+#[pinned_drop]
+impl PinnedDrop for Gpu<'_> {
+    fn drop(self: Pin<&mut Self>) {
+        let this =3D self.project();
+        let device =3D *this.device;
+        let bar =3D *this.bar;
+        let bundle =3D this.unload_bundle.take();
+
+        let _ =3D this
             .gsp
-            .unload(
-                pdev.as_ref(),
-                self.bar,
-                &self.gsp_falcon,
-                &self.sec2_falcon,
-                unload_bundle,
-            )
-            .inspect_err(|e| dev_err!(pdev, "failed to unload GSP: {:?}\n"=
, e));
+            .as_ref()
+            .get_ref()
+            .unload(device, bar, &*this.gsp_falcon, &*this.sec2_falcon, bu=
ndle)
+            .inspect_err(|e| dev_err!(device, "failed to unload GSP: {:?}\=
n", e));
     }
 }

