Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED84C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:09:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE51010E8F7;
	Mon, 29 Jun 2026 14:09:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="BUknnzzg";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012038.outbound.protection.outlook.com [40.107.209.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95B2A10E8F7
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:09:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kxBef8B0qHpKi+EApxE1K7UQG4/v4u7T27W47NHJLc1OWfv5Da66kSPzveesYFoYMnq9Lrv/4UA1xMr8/vhZoKUhlerd5dE0tvuFbXEenmaLfItVQahVsd3K23NRTwbVFOCAb1DpNWOJdQw9lA6p2iu3cdR8+0o/OXGizsnCKjz5kwkItdS8TXWTIVLNzDHckKC6CQzI4UEy34y9GO5RgVJwxGaaXgqBg7Mv+vIDgcETn1662RQTliIqB5u6V/XzDjLXgnZkz4bqCvui4lT2IPhKg9RZmCj22WmARKintqFFpP5XZPb1foOzqmirKiCv+n4TuQNwF1N5N9EBQ4fn9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2J7L3n1wUQD7Z3stAo14e1/SK1Zo6jEn5CE7MRF+nsQ=;
 b=Ys8Zh5H7QKEHvfX7h79OQJzEmY0/ZAEca+UCV3Qkt63CYnqqSvpOGp3bluI1pd1mdKaWoakHv8PaGWIqb/Ptbr/BbmmGEEJdSzRDNVfqv0nWtjkqdWxR6c4C97DKSsxrZuyOuCT0UCF7bLnNwOUTnXrb8y2ls+4qaGgDmmnFjzrEl77NzbpyDPMhk+STLQ1b+eDxanwRMSSASq5VmijxlZ71XcJxXm5nc9bod5GAq9sDjVtMGsry1k4BpAyS+p47qCpZhbj2TnE6/gHJCXnALto+mij03z5G4dtAR6YkD02Zyv0gzj9N48ZRX0B3UHlIS6n/CtynrQKSbsn5h7LFjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2J7L3n1wUQD7Z3stAo14e1/SK1Zo6jEn5CE7MRF+nsQ=;
 b=BUknnzzg/zCgltaSx35sRxJVqrL/uVr2fOMryGudVd7xTwmPFQfBE4USwzM06v8/izdqU9+cRaml7PltftjtIkMnkKgrD7snM/yA/K/wV15r+zCf/soEtipDOZkJ3UKnFWGMNY3En4XlYUbkzyPtJ2iASNv0qDCgpfHdvZExyuEpqrK9aN4BcTV26g2JVwY5d4dwLHR8m/AuTBea0Id8LuBW+vbj3pKPtXk2tJR0GKmsvrVSznJRJ6gx+8QeCr65HAM1mwpYJzYuV1Zgs7BMKyljcM+8EkbGezBVrqihbZD6E269QnRi4QRKT+KrnyabVv2Dh5ApbIJRXNc4eS/zbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CYYPR12MB8654.namprd12.prod.outlook.com (2603:10b6:930:c9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 14:09:48 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 14:09:48 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 29 Jun 2026 23:09:33 +0900
Subject: [PATCH v4 01/13] gpu: nova-core: gsp: sequencer: use
 GspBootContext
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-nova-bootcontext-v4-1-5539d8469590@nvidia.com>
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
X-ClientProxiedBy: TY4P286CA0096.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::18) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CYYPR12MB8654:EE_
X-MS-Office365-Filtering-Correlation-Id: d7321d94-0e5f-4c2e-b554-08ded5e8138d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|10070799003|1800799024|23010399003|3023799007|56012099006|11063799006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: pbtribdqDXtXIHNr0roEB/hk7x4WuRyU7UzRDl/HjV+W48t8WkYUWRX7WYeqAD6ebfYuuz2m5WnqpV52Xmt7IDukJZeNs6VFmkBFWAEXRN78jjVcg4X7hwN+RDxZwGz/KyW4HZpcSOULtUJhL+alBh3XV7L/I7kOPMoJNYO3M8LCgdBgRboaF7ZOfWv5yATSqRhGe6SYXyfDXoFUWgyiK+rSj+waFVt9f4hBWmqBPcrrjpElovAx9l8S51lfgeOJxc5kCSArJIZLmljM4OQKmVHvzUS7gpvt3m71YkuZ7IKWCDKoJ6Gk1U25llNKAhdSRDKmYxtYoH7kf2vL7JgtCFxBvTPrE7Cz6/z1iZGE8AR8PE5BdhqePoTk/ayhwqqyFb/BFvPdXwhdJJSRU9PjWRH/thmzGeL+j+2kFRfVCeoO5XqPhfAHAKoIQWtiEBAYe5iy/kRUwk3xm82DB3WBXjmxhyPtXM1avZdk1UP14s/e0mUalmnTMVaUYP3+0Uy+/pQPthR3TaWBquz1nwucQZqimLXHKwAgh10l9OEUMKRA1YXHRCqx+iAOo256o4F0qmh+RATMqa08FGI2kvx8WxEbBAKSWMvdByN1wYdeYznTYYSXLccuaXIBkyP2JWxcZnIqhvy7Oo7L0Zn/KAKV3ukHN1Lw1L1s2YEvU9lca16IklVkZqgD80wHwMduUvWayMeWIVHQzMUMzTl4ZU/5Fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(23010399003)(3023799007)(56012099006)(11063799006)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmZiaC9SQy9nZk9Wek8xdzFPbGJQTmdERlFPTjhoYTZsZ0V6MExnRW1Hd1d4?=
 =?utf-8?B?RUJlUERPUS8vazFlZDJGdkRlcGZsZmxIWWRHUnNhNEFOY2dpS0FtaGR4dE5Y?=
 =?utf-8?B?TGE2WUZRUTBjZnV1VjNUNkZRSWp0SlFOeWsxOUFOTW8vaVUwOEJIaWg4aUll?=
 =?utf-8?B?SUplTkpGSit5RE9HRnVhV1F3QUR0ZjhBNXF2VmFpeEdCTXlPbUl2djNFdDdm?=
 =?utf-8?B?YUtSU29MbWd5RzlNN1JMWUNoWlh4YThuQThFK0c1QkxmRzhra0dnRXNQM1Ar?=
 =?utf-8?B?czZ0MnVEaWpxNElSemZMUnUva3d1VVl1QTJuTzVMdlJSOXFvYWs0QlZsVVdo?=
 =?utf-8?B?U3BVNWpPVzlpWThrSkE3dUpMZi8ySGNGbHlpS1VHaUJWMHhIRnNxVmorQkpu?=
 =?utf-8?B?T3JOMy9wanc4WnJ0emlIbWJpMWh4K1paNW1TNThiZUMrRG03dWRFNUtZdStr?=
 =?utf-8?B?Nit5SDJqMllBTEhYQ082M05tRi9HSTJxZ0tWQjAzSmJ0dHcvV2ZqemRuUkp0?=
 =?utf-8?B?SEp6cXM0d21KVmhJS3ZPWDBFZHYyNVFHYWk5KzFiMHlJeTF5TkVLN083aFpX?=
 =?utf-8?B?aFhhREROZFR2bVJmNjNCWnNFUWRZQUFjcFJxc3hDUm9kdnR5WWxUWlcveU9G?=
 =?utf-8?B?a1JTK1V2K21ZS1VQSG9BUGU0dklXdGdEOUJCOXJiSkNROUQrRHYyS1RsZDlh?=
 =?utf-8?B?bGVwMUlyQnRTSUV1a1JjQ2lTeHJtODVSTU50OFlCbXBIei9BS0JEUzFCbFZ2?=
 =?utf-8?B?VFhuN0JUaHB0NDh1YWVaVzBXVU1HbndzZTJUQXBrOWsrdmVram9tZnRmS1ZN?=
 =?utf-8?B?NGdaa0RDOGxReWlVaGw2OWs3UGl1TjNiQTRwQWR5RzBuMUZFc1ZjV0dHQzFE?=
 =?utf-8?B?dEt3Q2lhV3BWNzBSWTdBcVd1TU9yaVVsam13ZXlkSWd6RXI1Q3JoRkR4WFAr?=
 =?utf-8?B?ZWtITk9DYjZtMGgrRGZjR2dXZHE3YlNQR3MxSkF6MGdwUXVBc3NpNndmUWdH?=
 =?utf-8?B?NExhRHRRYi85bFVuRXl0UG1YNzMxWnd2NGV4cDRxNVlhcHBTTW1ucm1FWTRH?=
 =?utf-8?B?SHdUajNPQ1J5ZGhtaGliSmx0MnBURXJjMkNvenVsdUk3OXJUMHdYdTltcGRR?=
 =?utf-8?B?bExSK21TdmtLSlpTT29mWWxXVkZyQ3V1K0ZadXRZbGp6b1ZlQ01YSU5kdzFZ?=
 =?utf-8?B?S1IvU2IrQjVhRm50T3NFcjVJN0JBeGVWWUZQMXFqNzRVSDlZb1ByYjhuVy9a?=
 =?utf-8?B?dHpucHkvQ3gzT3dFaWRDOXlaSDhGZ3FudXA5WFVWK1l3aGVNQ3N4WFBLU2gy?=
 =?utf-8?B?elJ4RTNQbkl2QkdNemRCRmk4dXFiVmZ5OHkrSFNpcWl4ZDU5amJnMDR3QmtR?=
 =?utf-8?B?MmdPRXdUYm9YTURSZ0Zadk4zdkR0STlNUjhaTEFaZE0zTG16aEZKejBVdkZw?=
 =?utf-8?B?VU94OVlJRnJpWk1qNVY4NFllQkF2eGpvZTR6QkhyR2x3T01JaWhuUnNCZjFp?=
 =?utf-8?B?OFNJN1JLOTFyMlpiYkZ1UTRlZWhHUDU4QmpyM3lNWjI5RzJHQnNsZVZRalRn?=
 =?utf-8?B?cG5kTW9YVCtMMjE4UTNqRkZBdEdKWVFTanlicGVhT3grTlA3bUljdFNIL3BD?=
 =?utf-8?B?QmRPdEVxWmVTQUJjMUtuQnNua3hHUFdQblVLTmlJZ2J0QWFxWmIvQUJva2lX?=
 =?utf-8?B?LzdwK2NiaG10RG9jZ1ZHWUpqQTM1YkJ4RmZrNWFxdnh3bjBVWFhKUVFkZTAw?=
 =?utf-8?B?bFJURWI2VFNvOTZrRTVFWWNYQkNGRXhRQXQwZVNVUThxditGR2llaTJhSnh5?=
 =?utf-8?B?a0tNb1ZnajBlVndOK2JXQk1QRG5vcFgrSXNtN3VkWDVTNGVmY25acjR6ck8z?=
 =?utf-8?B?cHZEVUJ0V3FpaVhqTGtGeTkySGJwVXRXTVU1R3BXbldteHFZVXR3YXBEQnYw?=
 =?utf-8?B?QUJVaGhHVGJzRTUwSmdtRVJrcG8zT0JjSjNYTmhheEI0eGpxR2NtbjJDSGY4?=
 =?utf-8?B?Z3l1MWZVYnRqY05WRHZnTDJRUjR3UGM1NlNwc1lXWHR0ZjBTT0JkajNNQ2V2?=
 =?utf-8?B?eVhoZXJyR1RVNW9tWGNlVlkyTS9XZWxOdmdIN3Z6N0JrZ1FJZFVTK054ZHd6?=
 =?utf-8?B?eVVxalFsTnFNU3BqOHRMenM3Y1BTUWw3cEQ3RUdIdHgzeFNjUk9tbmc5SWM1?=
 =?utf-8?B?UUNyRWI2SGpMZjc3OFBZajZ1bUVvaFdaUFpOOFZTKzRJcnhaakhITVpMSjhi?=
 =?utf-8?B?TFgrYVFlc3pad3VyenBEN3ZYUERqUXNqY01rUUVwdGRpdXMxTGI4Vzd1aXNu?=
 =?utf-8?B?U3ZJcHRybkpxdEN2ZmN5dU15OS9uOXA3SXRoa09HUnB5OXAyZTg2QlZDZHBW?=
 =?utf-8?Q?8YJMCVgPTKIoeFSCfzdq3zsi7gjhZtr3fbCUn3cNiidIx?=
X-MS-Exchange-AntiSpam-MessageData-1: ibWaTVpgLkAl3A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7321d94-0e5f-4c2e-b554-08ded5e8138d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 14:09:48.2899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gZTYjYKZdLRT1fJ791XbBHtWw18D1tAuv0t3YZpYlA/EmMsTr9r+Xfzq/VPKp+xmqh+zEBkE3quIsv7FX9Ci7w==
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

`GspBootContext` contains all the resources currently carried by
`GspSequencerParams`, so replace the latter with the former for better
integration with the boot process and less code.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 21 +++++++-------------
 drivers/gpu/nova-core/gsp/sequencer.rs | 36 ++++++++++++----------------------
 2 files changed, 20 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index ff71b45b5432..87ceb8878f01 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -37,10 +37,7 @@
             GspHal,
             UnloadBundle, //
         },
-        sequencer::{
-            GspSequencer,
-            GspSequencerParams, //
-        },
+        sequencer::GspSequencer,
         Gsp,
         GspBootContext,
         GspFwWprMeta, //
@@ -326,16 +323,12 @@ fn boot<'a>(
     }
 
     fn post_boot(&self, gsp: &Gsp, ctx: &GspBootContext<'_>, gsp_fw: &GspFirmware) -> Result {
-        // Create and run the GSP sequencer.
-        let seq_params = GspSequencerParams {
-            bootloader_app_version: gsp_fw.bootloader.app_version,
-            libos_dma_handle: gsp.libos.dma_handle(),
-            gsp_falcon: ctx.gsp_falcon,
-            sec2_falcon: ctx.sec2_falcon,
-            dev: ctx.dev(),
-            bar: ctx.bar,
-        };
-        GspSequencer::run(&gsp.cmdq, seq_params)?;
+        GspSequencer::run(
+            &gsp.cmdq,
+            ctx,
+            gsp.libos.dma_handle(),
+            gsp_fw.bootloader.app_version,
+        )?;
 
         Ok(())
     }
diff --git a/drivers/gpu/nova-core/gsp/sequencer.rs b/drivers/gpu/nova-core/gsp/sequencer.rs
index 13983d42b12b..f55205bd61f3 100644
--- a/drivers/gpu/nova-core/gsp/sequencer.rs
+++ b/drivers/gpu/nova-core/gsp/sequencer.rs
@@ -31,6 +31,7 @@
             MessageFromGsp, //
         },
         fw,
+        GspBootContext, //
     },
     num::FromSafeCast,
     sbuffer::SBufferIter,
@@ -335,24 +336,13 @@ fn iter(&self) -> GspSeqIter<'_> {
     }
 }
 
-/// Parameters for running the GSP sequencer.
-pub(crate) struct GspSequencerParams<'a> {
-    /// Bootloader application version.
-    pub(crate) bootloader_app_version: u32,
-    /// LibOS DMA handle address.
-    pub(crate) libos_dma_handle: u64,
-    /// GSP falcon for core operations.
-    pub(crate) gsp_falcon: &'a Falcon<'a, Gsp>,
-    /// SEC2 falcon for core operations.
-    pub(crate) sec2_falcon: &'a Falcon<'a, Sec2>,
-    /// Device for logging.
-    pub(crate) dev: &'a device::Device,
-    /// BAR0 for register access.
-    pub(crate) bar: Bar0<'a>,
-}
-
 impl<'a> GspSequencer<'a> {
-    pub(crate) fn run(cmdq: &Cmdq, params: GspSequencerParams<'a>) -> Result {
+    pub(crate) fn run(
+        cmdq: &Cmdq,
+        ctx: &'a GspBootContext<'_>,
+        libos_dma_handle: u64,
+        bootloader_app_version: u32,
+    ) -> Result {
         let seq_info = loop {
             match cmdq.receive_msg::<GspSequence>(Cmdq::RECEIVE_TIMEOUT) {
                 Ok(seq_info) => break seq_info,
@@ -363,12 +353,12 @@ pub(crate) fn run(cmdq: &Cmdq, params: GspSequencerParams<'a>) -> Result {
 
         let sequencer = GspSequencer {
             seq_info,
-            bar: params.bar,
-            sec2_falcon: params.sec2_falcon,
-            gsp_falcon: params.gsp_falcon,
-            libos_dma_handle: params.libos_dma_handle,
-            bootloader_app_version: params.bootloader_app_version,
-            dev: params.dev,
+            bar: ctx.bar,
+            sec2_falcon: ctx.sec2_falcon,
+            gsp_falcon: ctx.gsp_falcon,
+            libos_dma_handle,
+            bootloader_app_version,
+            dev: ctx.dev(),
         };
 
         dev_dbg!(sequencer.dev, "Running CPU Sequencer commands\n");

-- 
2.54.0

