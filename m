Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D72ACDB46B
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 07:10:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8483310E4D3;
	Mon, 22 Jun 2026 07:10:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="pD1S4QVH";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010036.outbound.protection.outlook.com [52.101.85.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5712D10E4D3
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 07:10:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVxZ66ArCcuSNUD0qvzR3AXdovVsttZB6E8Wsthze3wrNCdfs0HupknEoqIT3KCpkdYJqgDCsbYY9WbZnHjMDD+ktxFbOOWd00jiFtiU+a+xWjcHJY/uYsSIHJuksZURkxEugInPvM6TTURyvfDb2eXpOrnCXLkukOhXVTR/cB6jJEirwEFACLTRZNSAS30A9RLToiMTzHKHKmZ4DuEHhNfYP2uN8jYGKoIOHVhjpUWT3o/Ohsue4tPt9ThoUbUoz232PozuoD2j76NB4MmOgsBIubf3nyR+NXZwmFoYY9pz9IX10xFW0nx91EOjmCCPIQergM/GcPegn7UCLEiRQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVyaC7JdYRvjb2Ie0I5Vq9Srn5tEjPT/9r693RFEGVs=;
 b=CTsGeez8ZeOmcIMz4QOtpplq1rTl2ZH2SbiV92MTLcBNXuYBab53Ztq0uU9wzQlgE1yKJf1SjJcsGoZUGJvR6Ui9V+OC35IJ0NfHiJPEKyM+VOp6PAb2LBg6g5EiGneUUrOJcPuFCLzrhapyd5uovrUcB/0zi1ObW5NeJlINBaiHcMdIGaXeS3f0AjaqzpUKdkgDt6JZG7al/eesrM8qKNjX83Kta7GNMNYK+IWfclQHU0v3WkVUOJAIZJwVxQnh5X7xCecndzmZzG2LV3N1ezVx7v3IaBMm6xkj9Gp7qo0UR5zVlocbbNZsidrLaEwo5GFqSLDt5tZ+0IFs3g0NMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVyaC7JdYRvjb2Ie0I5Vq9Srn5tEjPT/9r693RFEGVs=;
 b=pD1S4QVH/JFeqBDMTdf8RsQ+kzlaW2CWhaWHh+1m/VJAWN1DEgyz0mJgZZ0IcsIl4lZ2Rzdg1l9xhQukNb/0RxccGVBARsEt/XompHhJz0KcAdYlS4x5JMe5eu9Ny/nHKksnwwGH9taOBY7uvLru0dLrqJZvJN2sJi6yK4WzJlLFkl2IgDFNjlkARHph/DfMpXWxwujnUGCCVMbhlBMeeh4Q7yMV/Yeq/l6pgwrhjkFqNiX9xvBQaDT0s52zUTmlqWEKSb6UcsUpGL20HY1UA1Wq7agnxUUMbd/KTkFAYiwC99ozoRjv3X/lGZEamTVCD6Jxs3x/UBsaycGyWvHsHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by PH8PR12MB6700.namprd12.prod.outlook.com (2603:10b6:510:1cf::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 07:10:52 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 07:10:52 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 22 Jun 2026 16:10:23 +0900
Subject: [PATCH v2 01/13] gpu: nova-core: gsp: sequencer: use
 GspBootContext
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-nova-bootcontext-v2-1-0ddeafc06f5d@nvidia.com>
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
X-ClientProxiedBy: TY4P286CA0112.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:380::11) To BY5PR12MB3986.namprd12.prod.outlook.com
 (2603:10b6:a03:195::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|PH8PR12MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: e778bab0-053b-4d4b-a97c-08ded02d645e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10070799003|18002099003|22082099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: imYJcxUAVVqG5m07EKMJ1XII1XHEPaagh32NSWYRRkmBJBTibNVLCZz2soQqtkNWMUvz06E5Aqs4xnPPrE561sok49XbZ0Ou2FiWvVOr7CHPYkxE4aNC6yeP8VDY9xfus1CFyVxhLn5XKT+/Fq1A5CCTI4p0ZYZVLplGE2x3ykskkk5Ao/hwWph2526hR0gVvaPP/wxTBzVXJj/JIFHgW7ZUEF8eEMy5vqBIpjdIWtePoa+eeSSbgFlwkdyZwsTU52ktUb3165lEp95gyJDvcGTGi/tKz4JtZuU84ox00Of50vev//QpP2BjHjM2GSUX8Pxb3DMzw1e2slt5mPqbxh3dZDwv9ExYkcjSUt5r3S8OXxTzwljVBGnPFb94YuATakpafwwzm8B5vY1fUTpBJZ/hzjMHCQIeRXJuQgRhP4xy9EyEOTuX6/tB1KyurMdbAUwdBRwlsodzdZLtJvMoqx0J1oPfEWUJuB9z2LlOXcsBFgle6HwsBxAgbUXeoVbRmTsEGVVlO2SCUt/xA9JcYdky6Fvdtli0J6++yTEcZo9sqp8jcw27t975/JFnxFQFc5TrTgfWJ1Tyyi58/EPjFiLF6HETVEtQzBBvJm7tkqnXKfsdjLUPF4+h7fi4tHtKo5E3K0j4TOs+9UIBxnAY6KQWzoeBiMmcNLhiAaLOBJQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10070799003)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDh6L2JMVk9INXJOTW1XS0tvK1dKa2NaL01UbkY5NG5LdlVaS085VDhzMUla?=
 =?utf-8?B?R2l0d3lEOU90MFdYUzZHVFBTUElzRWFtekhoMzhSRmNDRk94M3dleVJ5TTZO?=
 =?utf-8?B?Y2RkMWE4c0N2dTVLMDhNaXV0Z0pWQ1d2aENSM0JTSkZTZ1NwN1FBeGthRWVq?=
 =?utf-8?B?WURTWHFORmI4TGdwUy9KcTdtUXh2TFNMZWVjL0szN21CemR3QnZzMTE1LzJo?=
 =?utf-8?B?SWRqMzJnQ1VmUFRNSTB1bzBoRWE5VnpEaXRGeXN3anVkQkRVbFpoQkd3YjNI?=
 =?utf-8?B?M0xrKzNOS0doY01KclZYcmpnZEdTZjhIRlpRN3hLSHZZVHdnNWVxRys4SFVX?=
 =?utf-8?B?QWJpL3VrSmpPUnc5QVJudElxNEp6d0lOd2E4OFg3bk9vclJzUHVQdXUvVVJp?=
 =?utf-8?B?SW10MjBma2o0UjRML2lSelBhWlpJQ0NxREdod3pFb2dwOHFKWittKzgxSFpQ?=
 =?utf-8?B?aW1HWko2cUlHQmpxV01mMWZjcW03ZkIyZDJ4QU56eVZDL3E4L2xhY2JLSWo1?=
 =?utf-8?B?N3dpcHcrR0tqVGM1UTVOZFVKcyswdFJieDZLbnl5QmQ1T0JyM2t4WGd5WUt3?=
 =?utf-8?B?c3JrV1hxYXBielM0UUtxM0FJTE5QSURBa1NVUVZGa1ZkSWlXUnFNNTZJZk9j?=
 =?utf-8?B?U2hPSUNwMWpsUThUU01ITTlsQloxdGVCVHc0ZEVTQnY5YURoSVVhUmlWL3RW?=
 =?utf-8?B?NjhSUEtKcGM0bmFWTk5JTHM5Qnp6MzZaS0dmdGlEQVpwYVhQbDN4ZUdHbU44?=
 =?utf-8?B?UXNFSkxtV3JXcFlVM2JDcnp0SUhqeGNqOUY5Z2RWaGJ6L1VXVmd5ZkxTN2lr?=
 =?utf-8?B?MjRYcW5kUVpWYXplSUFQNW9RVGZnSENiSmkyUWRub1AvL05icjZ2SlFhVW9S?=
 =?utf-8?B?Q0twMGRvU0FRQVNQNXZNM3JSUTlBekhET2g4R0JnYWwvV3ltczBlWjAxdVlu?=
 =?utf-8?B?VWVLaWxjMHV6alN3MktGTmZYajhuUTJZSmZTWGhSdG1Tc3ErYVY5dDhQWTFp?=
 =?utf-8?B?SStpalloajJ6a1pzQTVLcHVWQ2NpRjgwUzJZam4wWlZTQUIxV3BrdENiR2JV?=
 =?utf-8?B?YjhkRU1hcUd6QlJKVnA2WktaS1VGUllWdW1ESG56cDd0MTgyR3R6dnpJeVZK?=
 =?utf-8?B?U08vWG1WL0g0b3ZRRmNTOXc0QlM3dlZGYWlUbnBhWDMrMTltUDhRRU5xUFR5?=
 =?utf-8?B?NzM0YmhUR3Jld002cFBndTNralYyWnVWVnRLTkFlS0JIUjJsTVVTN3UrSitn?=
 =?utf-8?B?VHlLL2tuT2ZUai9UYWdEUFJJSmdLTHBhRzg2dlhIN1I5RUdNVmpUb2djOTJa?=
 =?utf-8?B?RFp3YWM4NmVzNFhSR0tLd3ZTR1ZvUWxTbHlmb0twTVEzZFY0Ky8yVDNMK1Nn?=
 =?utf-8?B?UnVYL2xUenRnaWJZS2lqZjJUaDlUSTR5RmdtdmxDNHg2M1QvN1FhVXlmNmk5?=
 =?utf-8?B?TlBOZDAxRGpCckJrMnZ1RHpSVUVQVHZhMm5rczdVTENaWkFVOXlJWTErUXN0?=
 =?utf-8?B?OWxrSFpFM3NhTkt5b1d0YTFkQnBiN0laRTBVS3paQUNoMStjU2xXdVNXOXJw?=
 =?utf-8?B?OTNidndEU0RKaVBmREkrb21YZkMwcy82dnJaV215QmhaOFNDVHJiUTRMdVAr?=
 =?utf-8?B?Z2lFTmdVYmQ1Ry9jQ010d2NNY3h4WUJGUVdCYzczK1lrelczSG82MFhCWTBr?=
 =?utf-8?B?eTNyRXhJWEM0VGd2MnlXQzRFTExqbXJFTk1ndUFyaGRFaTQ4eXFoMUR4ZGR1?=
 =?utf-8?B?cGFTYlE4U0pRZUdKLzBHRmZsY3I1SVFXMkRtK3pxWW9Dbm01THdrbVlCN3gz?=
 =?utf-8?B?MUVyZ3JMUWJEVmtRY0Z0T00zYUluY3JuRHZjb1oxdzdWYS85bENLbVRJOTF4?=
 =?utf-8?B?S2liYVNDaFdhRTJ6RlJ5eFhUaFpMdjJZazVFY0pTUDdpTzV3SGpKRGFyTkgx?=
 =?utf-8?B?QmxTcjRxUndaVEpVdU9iMUVEdkVyVFE4eUQvTFU1RlBtNUFMK0EyejFTRU5s?=
 =?utf-8?B?YXhkWHNXcFJQcStQSEhEeHlLa0IveU1vQXpGanlzZllvZnd5Nks1aDBPdkRy?=
 =?utf-8?B?djhYZVZvOWJUalVtT3VHT2QrbVczekVMQTk3ZEJwbXpDWUFxVkFsSnpzU3F2?=
 =?utf-8?B?VlRTQWMvZ1ZCMGxOSUUyZGJMWWpNR3huZnZSQVFhYWpkVVMyZURPM1JhMkts?=
 =?utf-8?B?TWd4VkdSZVpmS3dPMEYwRklmNUM4OXY5YTl5eDM2bUFTQWRmV3hTaXByVTN3?=
 =?utf-8?B?WStGVDM2VGhDNUl6bkJoRndiOXNtVTA3NGNGeHp0UE5ZU01VcDJac3ltd1Ji?=
 =?utf-8?B?VXE1Vk45c3UvL1dCc25iYVdPYkVhM3J5dWpmZitPUGppcTEyb21idzlEVDNq?=
 =?utf-8?Q?sqIUDxcF7Q9RfCQb/Wvk6KjNNeB1NdRq6/MooaQXhtLJA?=
X-MS-Exchange-AntiSpam-MessageData-1: BKduoiuSQHX4tQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e778bab0-053b-4d4b-a97c-08ded02d645e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3986.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 07:10:51.9967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +uzFlQePDwANDP0WeQZc/PR2gJWwB/ueIDsUemXCxZd3hMM/X5pcLq8Gsy3rqpH33M0trPbqSZWYWNdA8EaStA==
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

