Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075C9606A335
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pEWJSdGC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84D8C112151;
	Thu, 26 Nov 2026 08:21:17 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010042.outbound.protection.outlook.com [52.101.61.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68602112148
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 08:21:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LtzbNHgArY+HIok6xVZzlyZvNXFnRnlYczvoS/QA491i2l2G7FUA8qLXsRgQK9TKvDajQEiARQlNVCqm1/ULw8HGHktOxyf2i+hYRxJCNCTYH1IXkRnnHrQC89V2eW21t48pUqyTrs7uIHLEUbftg83s3L/x3bLyx4rjtN+3iNUvfQY/zeiAndshSvYl2DdNyBOKq39FRlOkjTVFUo8hNPwhfcxX+kp9MyYMiO96OqmXw33Iy+ALjuXT8TuP0PR/4hfPvd4DyTv2nxb/+nfjh68sxIKab5d/vS2P/EFfkgCDnNeGY/7ozNUcGR2yFa+4ICKqaOTb5nnYumpfeh/VnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcJO/AqNevuF56bP4aqM3aC4RXR4jBAczHvZVFQhyuQ=;
 b=ld3sw1I3rOn8fmEDw90TSyn+Lbn63vPnJhz/akfmCnAR6LvTWzA2g51GcQ3r/iHEWHe4+/v6YKUICCga0TJ43o+69Z0Cm8sKM7YHIODyzhGXBpBiRFa7nSLtqMl+yT4UjVC7Ox+iWUC80PODYMvp1dr9zCothhN50QFOcQsjtYlL6yatawkhVyQOMuyUqbF8TnEfSLVzn9N8LJJ0li4WDazx0aEnu2JJzmUpLosaIGcRkiH+RIH6DJ3WMEGEDMb4lkhpj/a9pxxKof80TBbvsp6GJnAPRC8FMxyDvHmAVijWoCAVASYPEgdLerArIKV4wu3I5QOpgABD9SgV2e/M+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcJO/AqNevuF56bP4aqM3aC4RXR4jBAczHvZVFQhyuQ=;
 b=pEWJSdGCHSqVGrAIKQXaEm1gVSwnX/C6EHvtvfCmhxq3cayQ7fZxmlWwNOq7O4KbFiNy+2vQfPq6z9paVeRj7bhwv3s1xp/wrJOz1QwYGk99HShHCSYsv6EOBueAv11QXQ0GkfzP8ZC7EMB4NabqwvNIvOHMaY8lJOEy0O6diPnfusQi4w2A3MiEDNct3uIuLejF0tfuHuRMMAgp4WU+5U+rtfJuEew0dex+v2R0uqYp8zjM//Dscpgtqg0pKRW1glMlPbKnNLIb7sGzAmP3H5OkKIEZBBWVsV3ViwBBLbnoQFsX7X0u3IHUfuygWJlPYmajB3zfG2E9gWwIYvEvow==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 LV0PR12MB248855.namprd12.prod.outlook.com (2603:10b6:408:603::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 26 Nov
 2026 08:20:49 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 08:20:49 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 26 Nov 2026 17:20:12 +0900
Subject: [PATCH 3/7] gpu: nova-core: falcon: program BROM and BOOTVEC in `boot`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-boot-rework2-v1-3-99a1dc6c7cc4@nvidia.com>
References: <20261126-boot-rework2-v1-0-99a1dc6c7cc4@nvidia.com>
In-Reply-To: <20261126-boot-rework2-v1-0-99a1dc6c7cc4@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0225.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::13) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|LV0PR12MB248855:EE_
X-MS-Office365-Filtering-Correlation-Id: a98b4fbd-86da-4ad5-f2d3-08df4b962d69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|10070799003|366016|22082099003|18002099003|56012099006|11063799006|261009223027099003|261021123027099003|10067099003|261026121527099003|261102123227099003|261022105027099003|261026140227099003|261021121427099003|261028144727099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: UJojjaEzB06L7nbSWoxApkCW+u1aD+x7p3Ztd9QgUNj+sf/eEn6QJg2sbcUZZwvX7LhQP8rahI+P4L3MteC7xYEbcAB+VYU8/bbZpNHU2/fIEbVPFd5wMr+/02wGFXcpd1txdotvM5sue6DJp2oJZFO0FFdQ3JCd2pLT47NAo8WBldgssMvhqZlrFlzevrJYKFHnH3c16MGYUXPg5QHQ1Ixa4g3+7MNYMXCqvI+LT4uIHMJqZnznXV0Gz4zY/xPDzC1rLlDSZNNuxxWGH1GGuXDJRSuqp/7uwoGLnCtBosWckzexY4MbQczgWFM7p7uHucJJKwkmwkQX2HkLkYLJGDY8Zobmvq7G/jUZ19CgBsE0OxoMjc0zy9RkEViuUFsBOebJRpeqy8pO19O01iyaKhjLspLVXLfupd8TL/qaIV7/cdG4TYAXYPGQoUmVjOHFzCbIZPhuoi7KiHEzWAFOftU0HikzCuzJCxz/RtaJiR58HTy4RpCyko3UF8NrVYeoa7oWCZ00zLIzFB/2FS0aS3Tzvow0i3f6dzEhFoBwAzHyJ1Ig6OtD3JmJYYBiEEknGLv4lZ3R6+ZEJBSm06j3Yt3xw/4MnC/x0Wi9kihTabN5/6hfe24H9/8tf5I2shdIS5/G5cueIADeHEwUlfce9a/FD1oW/3Wb8QWo1KzXFxM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(10070799003)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(261009223027099003)(261021123027099003)(10067099003)(261026121527099003)(261102123227099003)(261022105027099003)(261026140227099003)(261021121427099003)(261028144727099003)(3023799007)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjUwcURLdTFKUU5GdHcrYzJPSWhGMGRBVWxDNC9WZ2xyaVlsNTYzcDBjSGRV?=
 =?utf-8?B?WGZjMllheEwzTVQ4VFZlRlJCS01SaW1KL2ZRTUxFV2Q5OHV0TUZ5MjhpSVlE?=
 =?utf-8?B?VGh5T3pPSXREWjl3QVBlU0tnWlFuSnBTb2xPa0oxM1o4cXpIaFR1YktOUjJ1?=
 =?utf-8?B?eXJ1cFhwN2lEZldxdXFESldUdnZyR3AzZGlxNUx5NmhESnBLYzAvZTQ4OUVV?=
 =?utf-8?B?V2lwTi9JdmtxeXRFYUl5aklsVzFvbmNjaGtBWGl3QkRYaXdNWUFCMVM0OVFZ?=
 =?utf-8?B?RTJSMnBRQjN3aXdUYWc2aTQwQ05VcTRpNGJETDhoQlBUY0FqNWxTM3YydnQv?=
 =?utf-8?B?cHp5d3lMejBDVVg0Q0VnUkF1azVZdFpyNGhMNGYwQ0JjcmtJYjQwSVczVERW?=
 =?utf-8?B?ODFYNGVDQmQ0c0tMY2dSUUVkS0VQZi9nSFJWb1FXUEQ0eXJrNCtTWkt0RkJ1?=
 =?utf-8?B?SWRTS1BKNzJXaTNYNU5GSDBpa2Mxd3lVaHZqckhmdm5yQzRGT2QvelloYjYw?=
 =?utf-8?B?WDhSdUFiaERVaDlxVTkxV0llaTNsSWg0bGRoMmdoV2hDdGsyeFZDcElVQnhq?=
 =?utf-8?B?V3hldXdwR25veHEzRENWKzRnNzdXMjlsMzE1WkRiM0NTRWhJWXpUNU42K2RY?=
 =?utf-8?B?eTVOcjd6ZTYrQkgvR3lHWDQ3NG9oenhXQ1o3VUNIWUtVNDhGVHR0QXlDTDBM?=
 =?utf-8?B?TGZYd1NmZzdreVRHLzRRbEdNSUNlcnJiQ0xJTGdseUtsSklYaUlQaEhmWXp0?=
 =?utf-8?B?cWJtWDdsY0dMeFNMNzU4WWU3MmUya2U0RCtPK0ZpV0haRHJRQVptUncvNmVX?=
 =?utf-8?B?cmJjM2diaUFEM0g3NW8xY2s3OHBxNTY4OThqb29CM3VPWE5sbEVhUmkzb1VJ?=
 =?utf-8?B?MHRBeXc1Z0QyN2xWVUFnMEczQTVoWlBDSlNMcGdjWjh0L1dqV2pTZmh1dEo0?=
 =?utf-8?B?czVMMlhSRGl3YTFGY1YyaWR5cHZKVDRiOWlMV1lmcW8wSjhQTUc3TlZmYlNH?=
 =?utf-8?B?dStCczBFTnp6OUxiWVltbm9OZ2tWZWNLM09OSStEeG5kREoyelo5bEFvZG1K?=
 =?utf-8?B?WnF0TnlEUHo5TVBySkoya3BtYS8wcExiZzhxUVdwbEEyMWU1cEZ2QzVBOWE5?=
 =?utf-8?B?TW50a2pQMnFCZUxXREQ4Wlp2bGVPMitKM1NFSkMzSi9RWFdaSFdxRS9waFlK?=
 =?utf-8?B?bFRid3ZlbXZ4c1FreWNodFhtb01YZW1WT2VPS0VMaUozbngvTWswcUdwa1l3?=
 =?utf-8?B?b1RXTFcrVmVKaGRUUG5oTDAzUzM3b29MU2F2L1NlOUZrSldrL2xHOVYvZEVQ?=
 =?utf-8?B?NW1aaDFZUVBEb0JYb1ZZYlIvUC9EazNZbVdrQ0V0UERrSmZldlpDdzRUWHE3?=
 =?utf-8?B?OVFmbmZkb09LQXlsc3lvanFyWGZxaUhHNVlFelVlOVRtSnQvQzZWbzBHSmNQ?=
 =?utf-8?B?KzdUTW9kK09jYmZDVTlmOHY5T1ROU095cXZ4cStadmtWZDBZVVNqcE9XdC8r?=
 =?utf-8?B?QUlOSTlnb1ZLaVF2STk1bEpUbUxodnEyL1VyTVE5TnZ5dkpYVXNhSWJHUGVH?=
 =?utf-8?B?aGxLbjJBOU1Nd2ZadjRwU2ozVGs4NlZpQmJZR3gxTk5rdHdFQW5XcHE5c1BU?=
 =?utf-8?B?NmJDMjVaUUg2bHFLM09LeHVBdEI2N2Z6WVUvek5uQXQ4UjFLbUh5ODB5WUk3?=
 =?utf-8?B?ekRKSzAvdUllbTZscTVOOXhuRVZvUzRWQVZzWHZQMW4xa1FkZzNpa1dyN1pY?=
 =?utf-8?B?UzJlMXFQQlhORS9KOWZIRzZCL2NUUVJSV1IwSld3UkdFeWozU2NqMWUveHJp?=
 =?utf-8?B?c05nRlJOS0JqTnE2RGFhckY1RzNHNGVoWmVPalBwQlhVL2pzYWxPL3dsbWtT?=
 =?utf-8?B?bDRjUEtlREtXSU9HaXJtejBFbVhuREJqYnkyZENXN2I0RWxTemRvY2ZuRUhT?=
 =?utf-8?B?MkdiM3JoMFBLZnBNbHUxRHRhNTJ4empxZ04wN1hubXIxZjNMWmM2azRuUWV2?=
 =?utf-8?B?a1lSWEdROGF0TTR3dkp4akd3MUhmbytKWE9hTjJXaThyaDBqZ3Y4WkNkWDJR?=
 =?utf-8?B?L1pJQUJDeUFXc2FGTFpMSm1nRzVrZmQzcEd2SFRZdjN3WjRCN2haVi9iRHBl?=
 =?utf-8?B?Y1B5QlhyYVBxcHJKdVg3VnJZZEdSc21yZTVOMldJSWgzVTFaRWduT3IwRXpx?=
 =?utf-8?B?YURSVDJ1TDFjNENvNmpzNjExdTRRV2dSQ0x2NEpQclVkaGdDRXpLL2d1aXlD?=
 =?utf-8?B?Q0ExRnpUUnN2cTdCdHRUS1RqcGdBSVNDRmtqcmNEdWxUQWFqalBSVlZ1K1Vv?=
 =?utf-8?B?MWM5eGRNWWRqRnM4R0lGK2s4UVNlSnUxdEEvcXlBMkY1MWhvYmZXZ2Q1bEdY?=
 =?utf-8?Q?PFecZL2lGGLtbyZSS/sBJCFbaslJrR6ysNHY1Vot4+vPd?=
X-MS-Exchange-AntiSpam-MessageData-1: hzQX4TMrGtvpgw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a98b4fbd-86da-4ad5-f2d3-08df4b962d69
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 08:20:49.0459 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0t8ySaNXvkbnGCx/1xB80XQTEM+w/4TiRX4dU4tvDorqA7+eWOcD4lLJY69xy90OvqakHsQW2IJJe9vzODrhyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB248855
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move the programming of BROM and BOOTVEC into `boot`. This is in
preparation to merge the `load` and `boot` calls in `Falcon`. To do this
requires passing the firmware to program to `boot`. A later change will
make the `load` related functions private and have `boot` call them.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/falcon.rs                  | 35 ++++++++++--------------
 drivers/gpu/nova-core/firmware/booter.rs         |  1 +
 drivers/gpu/nova-core/firmware/fwsec.rs          |  2 +-
 drivers/gpu/nova-core/firmware/gen_bootloader.rs |  7 +++--
 drivers/gpu/nova-core/gsp/hal/tu102.rs           |  8 ++++--
 5 files changed, 25 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index 8bcc9240d1bd..7dfe71e4cd49 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -494,7 +494,7 @@ fn pio_wr_dmem_slice(&self, load_offsets: FalconPioDmemLoadTarget<'_>) -> Result
         Ok(())
     }
 
-    /// Perform a PIO copy into `IMEM` and `DMEM` of `fw`, and prepare the falcon to run it.
+    /// Perform a PIO copy into `IMEM` and `DMEM` of `fw`.
     pub(crate) fn pio_load<F: FalconFirmware<Target = E> + FalconPioLoadable>(
         &self,
         fw: &F,
@@ -512,14 +512,7 @@ pub(crate) fn pio_load<F: FalconFirmware<Target = E> + FalconPioLoadable>(
         if let Some(imem_sec) = fw.imem_sec_load_params() {
             self.pio_wr_imem_slice(imem_sec)?;
         }
-        self.pio_wr_dmem_slice(fw.dmem_load_params())?;
-
-        self.hal.program_brom(self, &fw.brom_params());
-
-        self.pfalcon
-            .write_reg(regs::NV_PFALCON_FALCON_BOOTVEC::zeroed().with_value(fw.boot_addr()));
-
-        Ok(())
+        self.pio_wr_dmem_slice(fw.dmem_load_params())
     }
 
     /// Programs FBIF context DMA slot `ctx_dma` with the value that `configure` returns, runs `f`,
@@ -641,7 +634,7 @@ fn dma_wr(
         Ok(())
     }
 
-    /// Perform a DMA load into `IMEM` and `DMEM` of `fw`, and prepare the falcon to run it.
+    /// Perform a DMA load into `IMEM` and `DMEM` of `fw`.
     fn dma_load<F: FalconFirmware<Target = E> + FalconDmaLoadable>(&self, fw: &F) -> Result {
         // DMA object with firmware content as the source of the DMA engine.
         let dma_obj = {
@@ -673,15 +666,7 @@ fn dma_load<F: FalconFirmware<Target = E> + FalconDmaLoadable>(&self, fw: &F) ->
             FalconDmaSource::Sysmem(&dma_obj),
             FalconMem::Dmem { tag: false },
             fw.dmem_load_params(),
-        )?;
-
-        self.hal.program_brom(self, &fw.brom_params());
-
-        // Set `BootVec` to start of non-secure code.
-        self.pfalcon
-            .write_reg(regs::NV_PFALCON_FALCON_BOOTVEC::zeroed().with_value(fw.boot_addr()));
-
-        Ok(())
+        )
     }
 
     /// Wait until the falcon CPU is halted.
@@ -742,14 +727,22 @@ pub(crate) fn read_mailboxes(&self) -> (u32, u32) {
         (mbox0, mbox1)
     }
 
-    /// Start running the loaded firmware.
+    /// Start running `fw`, which must already be loaded into the falcon.
     ///
     /// `mbox0` and `mbox1` are optional parameters to write into the `MBOX0` and `MBOX1` registers
     /// prior to running.
     ///
     /// Wait up to two seconds for the firmware to complete, and return its exit status read from
     /// the `MBOX0` and `MBOX1` registers.
-    pub(crate) fn boot(&self, mbox0: Option<u32>, mbox1: Option<u32>) -> Result<(u32, u32)> {
+    pub(crate) fn boot<F: FalconFirmware<Target = E>>(
+        &self,
+        fw: &F,
+        mbox0: Option<u32>,
+        mbox1: Option<u32>,
+    ) -> Result<(u32, u32)> {
+        self.hal.program_brom(self, &fw.brom_params());
+        self.pfalcon
+            .write_reg(regs::NV_PFALCON_FALCON_BOOTVEC::zeroed().with_value(fw.boot_addr()));
         self.write_mailboxes(mbox0, mbox1);
         self.start()?;
         self.wait_till_halted()?;
diff --git a/drivers/gpu/nova-core/firmware/booter.rs b/drivers/gpu/nova-core/firmware/booter.rs
index aa4458bb3312..a52c965093c9 100644
--- a/drivers/gpu/nova-core/firmware/booter.rs
+++ b/drivers/gpu/nova-core/firmware/booter.rs
@@ -192,6 +192,7 @@ pub(crate) fn run<T>(
         sec2_falcon.load(self)?;
         let wpr_dma_address = wpr_meta.dma_address();
         let (mbox0, mbox1) = sec2_falcon.boot(
+            self,
             Some(wpr_dma_address as u32),
             Some((wpr_dma_address >> 32) as u32),
         )?;
diff --git a/drivers/gpu/nova-core/firmware/fwsec.rs b/drivers/gpu/nova-core/firmware/fwsec.rs
index 7a931f22f629..45b088f30b76 100644
--- a/drivers/gpu/nova-core/firmware/fwsec.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec.rs
@@ -396,7 +396,7 @@ pub(crate) fn run(&self, dev: &Device<device::Bound>, falcon: &Falcon<'_, Gsp>)
             .load(self)
             .inspect_err(|e| dev_err!(dev, "Failed to load FWSEC firmware: {:?}\n", e))?;
         let (mbox0, _) = falcon
-            .boot(Some(0), None)
+            .boot(self, Some(0), None)
             .inspect_err(|e| dev_err!(dev, "Failed to boot FWSEC firmware: {:?}\n", e))?;
         if mbox0 != 0 {
             dev_err!(dev, "FWSEC firmware returned error {}\n", mbox0);
diff --git a/drivers/gpu/nova-core/firmware/gen_bootloader.rs b/drivers/gpu/nova-core/firmware/gen_bootloader.rs
index 751335c97e35..cfc1b99c015c 100644
--- a/drivers/gpu/nova-core/firmware/gen_bootloader.rs
+++ b/drivers/gpu/nova-core/firmware/gen_bootloader.rs
@@ -223,13 +223,14 @@ pub(crate) fn run(
                     .with_mem_type(FalconFbifMemType::Physical)
             },
             || {
-                falcon.pio_load(&GenericBootloaderLoad {
+                let fw = GenericBootloaderLoad {
                     bootloader: self,
                     imem_dst_start,
                     dmem_desc,
-                })?;
+                };
 
-                falcon.boot(Some(mbox0), None)
+                falcon.pio_load(&fw)?;
+                falcon.boot(&fw, Some(mbox0), None)
             },
         )
     }
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index 2139279d40c4..80936194806a 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -101,9 +101,11 @@ fn run(&self, ctx: &mut GspBootContext<'_, '_>) -> Result {
 
             // Sentinel value to confirm that Booter Unloader has run.
             const MAILBOX_SENTINEL: u32 = 0xff;
-            let (mbox0, _) = ctx
-                .sec2_falcon
-                .boot(Some(MAILBOX_SENTINEL), Some(MAILBOX_SENTINEL))?;
+            let (mbox0, _) = ctx.sec2_falcon.boot(
+                &self.booter_unloader,
+                Some(MAILBOX_SENTINEL),
+                Some(MAILBOX_SENTINEL),
+            )?;
             if mbox0 != 0 {
                 dev_err!(dev, "Booter Unloader returned error 0x{:x}\n", mbox0);
                 return Err(EINVAL);

-- 
2.56.1

