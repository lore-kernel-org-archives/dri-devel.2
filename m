Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DA7CD98F6
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 13:42:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 931DC10E0CB;
	Fri, 19 Jun 2026 13:42:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="hAimqIq8";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010016.outbound.protection.outlook.com [52.101.56.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99D8E10E0CB
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 13:42:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jyQJQQMNzxnp+EoNYQCPKuLHf1aosRIN+6gPmPK8OMcgKPa0lAxl+KGm6NwaYHSg3oVV8urvKsOAd6ljAzX5f8k7Kq9EFZEhFbm8R9Lv/pr47q67Y/+7baWqEKmQtygFMC2/PoFQdrYflz+TU4n2XaHew0dYn9ujMsRJ/WkfswE22jNZEm3IgXZs/hGagCac9EjToTFUoy0BKCahaHN7lwZ7CDFyYhq7EcTx4RFHcZ5Ih74/e22/T4dIC2agSqLRST3mE6aGl0c4hq8lD/InzTG8xW/mbpgcUMu4R4fhABWgF4C/W3WU6i9HLV25r1fQShm08gYTRxsUAZIeoLYnuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVyaC7JdYRvjb2Ie0I5Vq9Srn5tEjPT/9r693RFEGVs=;
 b=XX850WSUyAVpL4FAvy+iG7FLdlgE53MWdaHmy+Ok54CeD0yocylkRfyi1R36yIN47Czz7ApTSRZMD5ITfKnMSMR1/UND65Br0xEuGGc0uOVHHinfjvyK4z1kdg+XL8Fgm6vpe0/0pEyLeNqeYFcKQ22VOkkh54n7Erdb6bi4l5aUjaf/cPbk/b4yGz8WGCtj5h4E28reZwjwFLSx96z4vA5lu94rozrpyC/AT/4lXl1kF1VtMxlW/3N0uRrjeo/imMAV4qDmZvUypSnM431mBqm+nCJB4pTNvuWNZN6k94xZ2YwalWiITZfar0hgRaA44BUaGuZmOlcDbaSUYXlNmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVyaC7JdYRvjb2Ie0I5Vq9Srn5tEjPT/9r693RFEGVs=;
 b=hAimqIq8YsPjTH6aYjDMcK5iJ0P7/hUj48vm580niuB5a3S5PKpe03AML57fJ+Xl9LPkRD+8jbDKQ6zv2iHFqbDqDnjMBGk184hFcBm6PtI2JWHUGh7MkyyBUb9FESj683pCxGhRe0WrAvGHjuG/8LZ48GnRqYHKnQuEEZWxf40NbVueY1evMo4Wjt2927piRJmAyuQFMERPeLWhd4ldTISv67cPgXHihgw/t3KFV/NIObvSGOfAoxV2TiMxLe7pkYVDkgyV4JFwXvSuojZpQF9VH3YcQz6N5v2D9DyJx0tG/kpJ1eRqYGng6GaxNqvz1sbtEiiGssV65L4euTebvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SN7PR12MB7450.namprd12.prod.outlook.com (2603:10b6:806:29a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 13:42:32 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0139.009; Fri, 19 Jun 2026
 13:42:32 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 19 Jun 2026 22:42:16 +0900
Subject: [PATCH 1/6] gpu: nova-core: gsp: sequencer: use GspBootContext
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-nova-bootcontext-v1-1-45193cd0a2e5@nvidia.com>
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
X-ClientProxiedBy: TY4PR01CA0050.jpnprd01.prod.outlook.com
 (2603:1096:405:372::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SN7PR12MB7450:EE_
X-MS-Office365-Filtering-Correlation-Id: b2d056c6-df5a-4d43-aa59-08dece089d12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|376014|1800799024|366016|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: Yot+4QeWcig/WdvDp2tY3VFhubkHNqPF48tJbKZCI/RGZ+HzgUCMoFrNpWB5JrT2g7f5L0s1I+7SbvA90Eetj0iZmfvlXeYd7Hw/+Qra7L+5r3ViDqM1KxXVy9900Vuki8Z+segIljT18Z97UBM3SJeLeHXrrqeJxgXnGj7zog/qjIHyzkJ5x/SZAv2z7wrkNfW5mdeblNSJycE54lsU0bzj3Vch430ma+1q5c9rb5tgQfXgD2dk11bGeiNDbQNOKoGjoSZ7+6z5JLEh2CSjCXrL+iP4MdE8DOz4NoKO6mwTl9Aivka933bCUbgca5R322ji+MIIQ5T7gBSfGW3r5Wy0UY94CkKezzEO1ZFY9YzFfkJBUUNEB8znKmPmZmOpDLkrSYxvtgYAF0YNh7DVWH5Mdx/WEmzrRSCLMTHFtm5leLDsYEU41gBWMeLzqwbxgr/hnbHAfffiai3eraGQGpbI2i8DOSyQvnR7LZ8HAbntpIaSBB2TRK3GObma2S19VipPp1KwUFsmJYhK2EtthideTgVJJOmQ4N6x/088X54VmMSaxXqGDaX4N+HY7/NuZNwRkyYOs7ChFlF6YUCElBi9QAydkrEMjbK80oxIwSaJJ5sI7/QYmiQsAkz1rbJsv2RPPHNlbxZjTNDygROYYdVZK5tUfKS0sejyywWly2E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(376014)(1800799024)(366016)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjNpUkVsWWErYTl5Nlg2UVRnRzJLSmMzZEphMmRoejhDZ3Z2S2xDcjRHTW0x?=
 =?utf-8?B?ZGc0eTd6c1lBZllzK0tqZnNOekNGWWlETDIycVE2NysyN0ZsRnhMVDA2dk0x?=
 =?utf-8?B?a0hhTno2YmZqR2w1NFE2UjF5R1BZQ1JFNXNWdVppMkhReitGVzN0RFkyQkNm?=
 =?utf-8?B?MnJ2RXFzSmNyNG1YVFhtQUFSaDMxTkoyT2luVGU3MnBDaXl0OTRUUEZZWnJF?=
 =?utf-8?B?VjJSazMwdHllcVJYQ1ZNd3dmMnNOUW83WWdRek5UQVBwK1pzamtwR1I3Tkly?=
 =?utf-8?B?TWN6ak9Kd2Z3UWlsM3FRaHdHVDRDZGZScU00VzFvc2ZKQk9PMmpLblQwWXhh?=
 =?utf-8?B?YTdYYWFqV3NFWFNrTXpuTUQ1SThNaFVWRnhBelNkWkNlUndIUG8vWUdHdGhu?=
 =?utf-8?B?R0NQenFmWkFBOC9mdU0zd0hQRnlDWEtxTFNxSnJxWG1DbWdUdW40SG03Y1B2?=
 =?utf-8?B?dHVIb3JJcnBoT2grUTRlQi9tcjkwdkY4eDU3VzVDaHZic1RyUG5JNktPdHly?=
 =?utf-8?B?QmtHRnVWd1luem5QT3VHM3lua3NpWFZuWEtRU0dsczRyK083dGI0TXIvSEZL?=
 =?utf-8?B?amZoTjFodU1xQUFLcXJFZHVSQWJMcmpYeWNIeGFUOUZsbU14Q3NPbTdoUmhH?=
 =?utf-8?B?NXQvRWdpWE1qUVNyMndoczBKWGFTMXFXYWJpQ0xQNWRPclVaS0VmMDhONXZv?=
 =?utf-8?B?cy80REFmSC9qWmJMdE91SnlJTldhU0hvY3hucjYzS1luT0RWald0b0ZNeHpP?=
 =?utf-8?B?SHgyMEhqMG1WOVlKN25HTE5FTTlJNkRVR2psV0NkMFpFWTNWbDlJL3JiMWVY?=
 =?utf-8?B?THdtR24zYmZtQmdqd0FwUmIzUExWaUsrZUZuMGg2L3AvZDhUZC9saDl5ditp?=
 =?utf-8?B?WFpSVVNBTTdpbllubFA1SGVrMmZiL2JIRGE1a1NsZ2ZCbU9SZzFqSU0xUlRF?=
 =?utf-8?B?WFZEVWtkNHN3VGhqT3BQZDZJeWoxbjJwWE9jSFcvcklJZ0cybGZJM1l5bTNq?=
 =?utf-8?B?VHVYWHBjTnRhN2FCbHVqdlFFaGdYNTUvSEN2TFJRaURLRHFCRlJtd1l3a3My?=
 =?utf-8?B?My9wVmE1R0pybnVYMUh3UzQ2VFhValRVSVNhV0ZuR01HcDBleWV2VmU4MmxK?=
 =?utf-8?B?bXFwN3VtQ0RxN0RicXNoYnAzYzg5Q0d0SzZveXQzemU1cyt1MG8rdFZoWTRQ?=
 =?utf-8?B?RkFqcCs5ZVpVS3IyTW40RmcyZHprZWkwdkhnTW9QbmxoOTNEZ0gyWlMrYzhD?=
 =?utf-8?B?TyszR0N2U1h1b3VJRVk3MUhOZy9ubWpacHhrZ21uNENxNVhxck5DTFFqeG5k?=
 =?utf-8?B?RG4wcEw0MnpyZmdxUlk0U0cyZ2d1S0xGeDQ4dGJuN3B4UkFiRWVsbUtocWVx?=
 =?utf-8?B?S3Z6SDhSeWlVWklqOTViNGFPYXJyUy9LQTFNTEE4Sm9KWmNzb2FGZGptVlIv?=
 =?utf-8?B?VDhKSkZLY21TdStMbFVqaDRUMFNOa2ZZdm81VmR2Y3BSZm5wNWlmQit5SXhW?=
 =?utf-8?B?SDlhRkI2c3JvekNHZkZUcTFVaHZ6ZUFZZ1haSkF0dTR3OEV6TTlCYzdadHMr?=
 =?utf-8?B?aWk5ZnV4STF1aEhtTG9SblpDY1pNTyttTy92anFmNkpEUDVoQ2NkdjlMVm9X?=
 =?utf-8?B?M2xPOFRweGpsbU1DRTloUW91Q2M1aUJrV29TOE9jNU9HN2NnNXY4eVkwK1ZU?=
 =?utf-8?B?R3VjU0tURWtJRk1LL25PSkFaMUlTVk0zb0ROWEhZUlVsdTdqaWFCL3JENHR2?=
 =?utf-8?B?TmkzblVlS3VIMnVkb1hJTGUyRm1GQkpTQXZwSjhrUU1kTUlCZUE5UmpQSGlw?=
 =?utf-8?B?VjFoc0dCSkM4YU1XRGpqNER6ZVJQYmUwYnhQWWNOWjg5bS8vSUdxYVF5U09C?=
 =?utf-8?B?TG9Pem9LTHNiOFRzT1dSakQ0eU5jVXVNWDNqZGwwTUl5MGRsMG1PNVlVcTVI?=
 =?utf-8?B?eFNjU1JrNzN6d1ZPaVlqTTR2OC9mUE53aXZHaDhkZ0ZRVlAyNGdaMzlEVzJl?=
 =?utf-8?B?bTI3OEZzWlVyNEphak5FMUFRUVRjWUFZNGNic1hSSWE4T0NFRnlJb1NpbXRN?=
 =?utf-8?B?SnpVZlp5V01QMTNNZFJoTmZlQkp5OTUwMXAwS2ZwQUNMRzZRd3VsdTVpbDl5?=
 =?utf-8?B?b1hJdDFwaTh3enVZRUZ5dHhNTm4vQXU2dUpFYWM0ZTI3SlFScUNZdkNCKzVu?=
 =?utf-8?B?UHB1bURyZVkzakFVcyt4aUVaQ2REN3M3bDZLRFhXYlRXcVJsZXEvdXlyV2tU?=
 =?utf-8?B?cjJTbXVVbDBMVURQd0dCaURKYXRKeWtWeWQ5d0pMMnR1aHpSMVArSHVSYmp1?=
 =?utf-8?B?RnVkcm9oS0N6SEZ6TEtuNEM4cDhxZWhKcEN2R0E3NmE3SWt3U3BJeTF2VDd4?=
 =?utf-8?Q?Fsp+SNaUtkWYQZbxIxQHybNEBuR5alIhfObTpIxX/yeDI?=
X-MS-Exchange-AntiSpam-MessageData-1: TfhvUHcAN2Ep+Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d056c6-df5a-4d43-aa59-08dece089d12
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 13:42:32.4901 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XjPD15Nj142DRozABNadU5y5qXJWzSJ6jMP69cCp/OSJKMcRLHPMjPxkxRj0Cflh++Ys8ZR20Z8KuBRDlWbRYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7450
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
---
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 21 +++++++-------------
 drivers/gpu/nova-core/gsp/sequencer.rs | 36 ++++++++++++----------------------
 2 files changed, 20 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index f8a8541704ee..6ed4ee268086 100644
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
@@ -336,16 +333,12 @@ fn boot<'a>(
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
index e0850d21adca..0da3c3531886 100644
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
@@ -338,24 +339,13 @@ fn iter(&self) -> GspSeqIter<'_> {
     }
 }
 
-/// Parameters for running the GSP sequencer.
-pub(crate) struct GspSequencerParams<'a> {
-    /// Bootloader application version.
-    pub(crate) bootloader_app_version: u32,
-    /// LibOS DMA handle address.
-    pub(crate) libos_dma_handle: u64,
-    /// GSP falcon for core operations.
-    pub(crate) gsp_falcon: &'a Falcon<Gsp>,
-    /// SEC2 falcon for core operations.
-    pub(crate) sec2_falcon: &'a Falcon<Sec2>,
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
@@ -366,12 +356,12 @@ pub(crate) fn run(cmdq: &Cmdq, params: GspSequencerParams<'a>) -> Result {
 
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

