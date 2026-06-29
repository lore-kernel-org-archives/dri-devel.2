Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C14C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:32:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49B7310E889;
	Mon, 29 Jun 2026 12:32:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="fjBAi1an";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010043.outbound.protection.outlook.com [52.101.46.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7504E10E896
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 12:32:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEaurqG0i6kmlF8gL2FgABbBws5qh5bcCPLganh2IGN6zD6qnHqMWGtEDhAPfJlH7ezdKG4Bo4rUmXQzLb+vY8p6I9pIgzKDepwRndABAAXAWOA7pEIOEIjCIq/qlXC7K7AFQV+yduX5wwWibYCGL5DUBZzH38QtM5UkIse1Cjd92e5uPSCKQT3dIe6YRjfrRl+26DvhwiXnDKJklmBJTzubdrFR+iMClQwE2N8PRgqt4alQ0akxdRADmWszpUhYKbxEIOF2Mbn0SkfdVl/pRtNBfRQl101jvW8hWA+Ktz0maALbaZoPm3M1UDjJPn2psvfbP4VT6LCSbHtxi9Fyew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9aRCjvh6ismHU6rUwKNaX+mdi9dQ+i/1dCDK22Luzw=;
 b=nEUzxNg5XZPby/5DVZ7QfaJGzCM0Ao+lCe7mv5ykBkMaN7jwx1UDwYg264r3BV+QHigi9d1bM8cH/rrUU/Jt8SH1/bCjPIpukFWC5ojq7H2YtxOj3nRJsxP82lyZrv+8jjyVOJ2D6HBJD0CuP8XQ7WcxE5N6ppFZi/IAwHQzQVWnSkUkAcAuYHdbHRMSnePrqR/GDX37yDTIwEeOg0vegkZoV9bu4am/+hAVgnk1SpXrR5cbkfjmIvSlbSd97jnAqT32STuefQ5NbBwX9J6T2C0006ouvUTBUAlv+Wswjk/vntOPwnRj7TeMA464v8ZpIJTydOIioXbURumWr0l/pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9aRCjvh6ismHU6rUwKNaX+mdi9dQ+i/1dCDK22Luzw=;
 b=fjBAi1anta2VZ8itNx9FuuqNZrX/V6qmsJZqSwkQ4MKC2k7aotwXET2epzH8FNPhOXTcFS0T6LWs1qu2SlbSmXtErSIYR6M4FoDObxsfUyyh2Vbb34XVeDXYXHLgwwCGSjoMFEEuFKMmTbiiKGFXUNPT2HTOcW4kL0/YBmDdeoZheGGmU4vnznzTHo2mDUQ4cobKNbqancTK60DWsYdP9ULExA0Qk9icrZ4dO4LvYbJzJNOGrlUKaoRkd9TlWD9pKH4EP5HOPDM2FsrlOWj0AVTNmXWK+xzBfDl0AILoEqSvDe3p8mu+lvugAlF6zfpIbyTEWm/5t08LlUx/bhOh1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB8311.namprd12.prod.outlook.com (2603:10b6:208:3fa::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 12:32:10 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 12:32:10 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 29 Jun 2026 21:31:47 +0900
Subject: [PATCH v3 04/12] gpu: nova-core: gsp: pass GspBootContext to
 unload methods
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-nova-bootcontext-v3-4-26cb29ee8dee@nvidia.com>
References: <20260629-nova-bootcontext-v3-0-26cb29ee8dee@nvidia.com>
In-Reply-To: <20260629-nova-bootcontext-v3-0-26cb29ee8dee@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0258.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB8311:EE_
X-MS-Office365-Filtering-Correlation-Id: 47893ac0-353b-4910-12d0-08ded5da70b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10070799003|921020|18002099003|22082099003|11063799006|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: v7bTfG/tJCFbM7cJPX2GZuhwcWo6EHxXYT4omRQ7L5C8gp2ciY/hUdkP0kOF86Uj0Zru0X9KuJ09HLATwg/lcYJEuoEpQmMWINkijSRf6LB9qJzAj0/Ni5Hs+7ItOhDFx11oaBQ0LBkEheRJsIt6Ob55D8yGO8Q5ysVSVUD0qpLB/nqwIeU8lBTsO+eMWdwMq8t+6BJFX3l5jysKin0Xgrx5fNxcNM6gRxCpuXyejRzgdSqwp70lx4m9qDdvW4f0Erpb4Haph5yEWfiyD3irgUxYDbmlKpj9yXCDxdkSOvuUY65NyissJ4P1GtOPpTmpyKmC4QuImTtiaXBfhqwsunJgNp2cjxlsSrZhVdyWQryunY4VLseXRTfPPATyqvNd4Vjwf46cQiC2ddzIPxthkTOt68JibaI0S6rIk+zpgYyjLpB2ABcxC2hNp3hBAo8qVqN9soU0OL9qTmb0e8hqInAUrb+hmsuosUSsY+G4XimO3REJUg3+UkwRHps69rZn0uUSOHdbgCTQjeJ7yyLhNEE11sw9446g5Azqk+lej7K2fjIeEurswSntVZN641kJipwD4G9hXFXOF+rvHfieTfw08cS4g+im/lDRUyJuLLfM83CDrCS1RjH26JCk8/87GtG06rtmKBz7pLKyZdhdGcRd8lA9Q1icofWUl8B+NeS62NYBVWlk0H05XI8K82q8fDP2mjgec8/i4Ee6jZpjEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10070799003)(921020)(18002099003)(22082099003)(11063799006)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QitVSkhqRFZpSzZobjIvYVVpeExDMU1sMlU5MUd6K0pxUys1Rm5aZUZ0cEpw?=
 =?utf-8?B?aUFxVlkwZitsTmZrbWs5bHFBWXh5Z1RUZ2tuRG5OTmJWc1NvL01Qa0NBUnpR?=
 =?utf-8?B?elh6K2hTZU9TNEJzdGh6Y0pjTDJCNENFcHVZZGFsUnUxK1BZYndjUzlYbXNz?=
 =?utf-8?B?THhaaXVydWh6Nk5ka3VPQzhicjcrL3cvMFY4akhjOHN3RVZuUmRGbi9GT3lL?=
 =?utf-8?B?Mk00K0tmblRObVdMWU1XMmlsMkM1SmowS3hrcGp4RmsyVCswaTl5TEpZbkJ2?=
 =?utf-8?B?TG9WQVBtUmpwOUhXdVBKdHozMVkzUGVhb3ZmWHdoT05MdTJpN29NSWJMM1FD?=
 =?utf-8?B?Uk5RTGVBak5tZUpkVGN5THNhL0xJTC9mbVhrSEdETVhBYStQeGhybkdNUmlR?=
 =?utf-8?B?aGlrWTdEejg0czZnYnNWd1JoczRjV2FESGVMU0dZenJ3eG5SM1BueUhYZ3NX?=
 =?utf-8?B?dlNrQ3F6UzVGZWFlZVBXQk5MeVlmVDk3YlovVXVnZ2tjR29yOCt0T0t3Z3dx?=
 =?utf-8?B?L3locHluVHE0ZmVoMHc1ZlRtREtEeDNDNGFud0xRK09aUzA3Y0E0cTBMM0l4?=
 =?utf-8?B?M3RHTi95RWk1SEw4RGtPbStpbUNUelpiYzJlaU9yL3o2eGw5ZEYwSERTalVH?=
 =?utf-8?B?NDFCd1FJczZCNiswL2VoWll6QWFnaGtiMk56RU9Ib3A2dnZIRzhsSzhCdlR2?=
 =?utf-8?B?enUwWkhxRUtJNk9pbnZ5SkNxck0ra3pTWkYwbGxEY0l5aGl0NGVha1cyMjFj?=
 =?utf-8?B?d0xWNmR6UnovZ2FvNEhKUVNqQmkxRWpBeEFERFI2Qm1uZC9PNGoxQkwyNSsv?=
 =?utf-8?B?QW9RSEVMWTcwQjRWYkhxRjRtelJzVHc5UTlYY0pJTHd4cWVOOE1IbVBJNkZm?=
 =?utf-8?B?OWFOWlowR1pkRklPcE1raVV3YjJrSUFqSW1VZWlkamVJb1pBMFYzUWhoWGw3?=
 =?utf-8?B?MnBPSFNVMmorem1aTDJtQi96QXFyL0Z4bEZ0dVVwOWY4Y0g5c1VIZGNlZFM0?=
 =?utf-8?B?bHdxN0JPQkMycDJGZjg2QWVEQTlLQmNkbm5MYllDbGY4OEt6MGZJVFNkVzQz?=
 =?utf-8?B?RG9oelFIdU5lKzdteGx1UVBkM2E4d1FJSUlMQmwyWjc1S0FSRkZ5amhsYWtH?=
 =?utf-8?B?NTAzTFI0bnVWdlVXcW5KL3c1cDF6VzBFNXVKVHVPU3p3dXEvOUlPQ29OUG5R?=
 =?utf-8?B?T2VSUnJqd1VHVkljS0UvRzduZkJTYUdWQk5NZG52dmg4SVJGd1QvaHNWNGkz?=
 =?utf-8?B?bDI2TDVteFhzTDhUcEUwaUU2a0h6eGhmcWliajRZR0gwRkozbFBXUmVJanoz?=
 =?utf-8?B?anNmU1IxSVMyVlBIRlhrditUS1VuWUMvbmtoaXlHOTFCNzBDOUphVWxyK0p3?=
 =?utf-8?B?T1FxbEpaNmlSeENJQ2pxcFkyblBEdFhlRCs2ZE1JRWt1S0IxNzFlRlArUDZZ?=
 =?utf-8?B?MVQxbVpoL2kzclJNTGRnQmxwc1Q4QTV6WUcyeXJPaHltRk9RNUZCSUtBTXJR?=
 =?utf-8?B?TkJOWms4RDFmNjJPOVp2VWFaYUVRQVZnYU9lZmdRWEVxR1hpbmZEVVFYcjd1?=
 =?utf-8?B?cnJMejlvd204ZTJGZWZhZXBPQ2h0VTBPNUFMZTRlZ245am9Vd0RMNnkvK3l1?=
 =?utf-8?B?QWN3ZDNoRmE5VW1GUXp6Ri8wS1hQdTQ5MVM3UmZJMWtkcjBkZ1dscmxMelh0?=
 =?utf-8?B?OUQyWnZIOHY1L05EN0dPK1J5Sm5lbkJsMGN5b0s1NDlXWmxPUERUQ0UyOVdV?=
 =?utf-8?B?MXFMbEpKVkJaTVpHREJldUxrc0w3Q0IwYlh3ekhHOE5BQzJJb0ZCRlFlRCt5?=
 =?utf-8?B?VjNpZmNla0hnWVBlOWI5KzdCNWoxQVVzdHlVaW0rOC9RS2NCekhoL3ZVaVJF?=
 =?utf-8?B?SlRHamZhZzNVMy82cm00TERsZDM3YlhsaUxxbUNRMmNvMVMrMXdkMTVqdldy?=
 =?utf-8?B?WXVJRGJZWlFWeEJsM3l3UDZYU2RieVVUMFhRZHNSVjlYc3NYZXJGMXcvK2x0?=
 =?utf-8?B?UURYRmg0aElkcE5TWU93cnNhNkpyeUdma2pRY2hIeXBCaEk1enQ1WGg5cU1C?=
 =?utf-8?B?V0lQOTJLbFQyZzBWTGlzclRYdnJ2K1c1NkVSaGhWWmRPNEZnYjlNZEhqTmJK?=
 =?utf-8?B?N0o1K3hNRVpIaUpkaGhTV2dkWDJPMlIzTVFDNlMzeWlERjZmS21aNk04RWxX?=
 =?utf-8?B?N1B5ckNXazFrUnF2SHlkZ2ZlK1ZlL3RWWlJ6WXo4SUs1ZFFhVVJkNjRjcG1p?=
 =?utf-8?B?MUhXOXdpQyswemg3WTJsWDlmOHVONDlyOGJGdHJQNVM5M2NsU29Fa011bFNV?=
 =?utf-8?B?TEFXQnF2MDlIdEdWUXpPV2FWcngySUdOdTMzRmdCR2VxdUNpYStLd2ZjV0hG?=
 =?utf-8?Q?bbUMF/ITNWluGvNzy4fXT2mTFf52oxelZ9w8aXHdKbcmb?=
X-MS-Exchange-AntiSpam-MessageData-1: m6+yt22cie4FoQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47893ac0-353b-4910-12d0-08ded5da70b2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 12:32:10.5087 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJVoiXz3fIhjmd//HbPXzhDyUFRc9soJbdBXJwPWihStxl25eeoKMKzzTyrZ1mV2c/GK2roH0Gv+9D+CanL8XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8311
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
 drivers/gpu/nova-core/gsp/hal/gh100.rs | 13 +++----------
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 22 ++++++++++------------
 5 files changed, 43 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 4d76be429e75..4ee0a43ac4b6 100644
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
index 0d2213fb1569..033b2ee2e2a0 100644
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
 
         gsp_falcon.write_os_version(bar, gsp_fw.bootloader.app_version);
 
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
-        gsp_falcon: &Falcon<Gsp>,
-        sec2_falcon: &Falcon<Sec2>,
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
index 0d65a32f9949..849ca224085b 100644
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
-        gsp_falcon: &Falcon<GspEngine>,
-        sec2_falcon: &Falcon<Sec2>,
-    ) -> Result;
+    fn run(&self, ctx: &GspBootContext<'_>) -> Result;
 }
 
 /// Trait implemented by GSP HALs.
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index bd15a3067ffe..8dfbc402c13b 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -14,7 +14,6 @@
     driver::Bar0,
     falcon::{
         gsp::Gsp as GspEngine,
-        sec2::Sec2,
         Falcon, //
     },
     fb::FbLayout,
@@ -118,22 +117,16 @@ fn wait_for_gsp_lockdown_release(
 struct FspUnloadBundle;
 
 impl UnloadBundle for FspUnloadBundle {
-    fn run(
-        &self,
-        dev: &device::Device<device::Bound>,
-        bar: Bar0<'_>,
-        gsp_falcon: &Falcon<GspEngine>,
-        _sec2_falcon: &Falcon<Sec2>,
-    ) -> Result {
+    fn run(&self, ctx: &GspBootContext<'_>) -> Result {
         // GSP falcon does most of the work of resetting, so just wait for it to finish.
         read_poll_timeout(
-            || Ok(gsp_falcon.is_riscv_active(bar)),
+            || Ok(ctx.gsp_falcon.is_riscv_active(ctx.bar)),
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
index 8511cc647596..ed9a3d362090 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -124,18 +124,15 @@ fn build(
 }
 
 impl UnloadBundle for Sec2UnloadBundle {
-    fn run(
-        &self,
-        dev: &device::Device<device::Bound>,
-        bar: Bar0<'_>,
-        gsp_falcon: &Falcon<GspEngine>,
-        sec2_falcon: &Falcon<Sec2>,
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
@@ -145,13 +142,14 @@ fn run(
                 return Ok(());
             }
 
-            sec2_falcon.reset(bar)?;
-            sec2_falcon.load(dev, bar, &self.booter_unloader)?;
+            ctx.sec2_falcon.reset(bar)?;
+            ctx.sec2_falcon.load(dev, bar, &self.booter_unloader)?;
 
             // Sentinel value to confirm that Booter Unloader has run.
             const MAILBOX_SENTINEL: u32 = 0xff;
             let (mbox0, _) =
-                sec2_falcon.boot(bar, Some(MAILBOX_SENTINEL), Some(MAILBOX_SENTINEL))?;
+                ctx.sec2_falcon
+                    .boot(bar, Some(MAILBOX_SENTINEL), Some(MAILBOX_SENTINEL))?;
             if mbox0 != 0 {
                 dev_err!(dev, "Booter Unloader returned error 0x{:x}\n", mbox0);
                 return Err(EINVAL);
@@ -299,7 +297,7 @@ fn boot(
         // Run the unload bundle to try and recover the GSP if an error occurs.
         let unload_guard = ScopeGuard::new_with_data(unload_bundle, |unload_bundle| {
             if let Some(unload_bundle) = unload_bundle {
-                let _ = unload_bundle.0.run(dev, bar, gsp_falcon, sec2_falcon);
+                let _ = unload_bundle.0.run(ctx);
             }
         });
 

-- 
2.54.0

