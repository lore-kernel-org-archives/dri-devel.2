Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A97C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:22:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA24810EB7D;
	Tue,  7 Jul 2026 07:22:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="WR2EFgFs";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012047.outbound.protection.outlook.com
 [40.107.200.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CF4110EB90
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 07:22:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A2BbpZJ2vMFcUqIO3vXdevpA+chq/YPyi4B4EWwrG1VRYi7vBkjTALEqj4rs3/t/yTInxvsJu6L/Ss/1xysm//la7trq8mqlh1TDVApILrSgK9bQgOd6ehRE8e/BN05ZqjgSpuFC8/h09PoQ15a0PaAVaflYlQkuoSybqgYKVzyrBf9j+3owscX84AnUzP82dt1EeeWWAemcGPse9gjK7Wd/w43CHxtypi+akEGpUaM3cMgarn2RRpiW6G+fRavzZLK7yobhCpMnPe9MmQ9YhENayZDExt7J2RKes6Tj6shx/RJalJDyqfCUvQEr8Yp9nzhl93KCUhvw/bu1TeIhrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVYEa9vSIbRN3sNVpjCVM2oJsmIJf/nvS7/uvpDx0kk=;
 b=IZKVtlZHxezFtp+PVtRqpsgO1MsniakOKB/lTRbwoAQs9ytukXxvcW+61s6CILivaGzyzAWr5QIFbVOtPViQlKwojFH8FaXrMMJxEkOZLzlLjmd90KzX53uJmwcTiyuxtYBVfk4GDtQFpnS06519vTcA2pj90jtSZm2P9r2zt1UGSMTTwFPbMZvuZ2PM3P+T9YLQ/MBO3XAbA1LCB/Q/ln5j8AQ8ctnMIadVcpbE/jvS17cDvyHIfzg5S7f/qMwnDfrzfQAp3JINwpOb2lAKP0BW1o2GU3/6HiywN7KozHBvQMdXaOyymMRL27JkBkgIhHeLXHkrAYhfufomDE/xbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVYEa9vSIbRN3sNVpjCVM2oJsmIJf/nvS7/uvpDx0kk=;
 b=WR2EFgFs/iQKBXsvJNBxpUdy2i11ng3GguGvy8ORfGGRikdi2MGbib8HhjhjQS2c2Vy/CmdOULwnFSXIYavWrCUivX3AiF6A6JNw7YTxg+miBaQsRh6155ruD3o2R8ASLIR5vRwVXzQZnICD9qOdRT0YFiz7+P096BiEcI+Ptwy/LeRiXxt1/MM19nFCUBXwvoum1ksu1KHVopxIX+APCbUXvD9/lvFPMFbzqYL0YOK++3LxccK9mfmHtrrIYF16wyo0xz8f+YLHUIw086b4alDtk7VSTANKhruqnfQlkpZawcpPAYEQ71R7C22bZhW0c2cZqg+1gV5eXHhgyQQwRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Tue, 7 Jul 2026
 07:22:33 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 07:22:32 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 07 Jul 2026 16:21:43 +0900
Subject: [PATCH v5 10/13] gpu: nova-core: avoid repeated calls to
 pci::Device::as_ref
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-nova-bootcontext-v5-10-ecad9346387f@nvidia.com>
References: <20260707-nova-bootcontext-v5-0-ecad9346387f@nvidia.com>
In-Reply-To: <20260707-nova-bootcontext-v5-0-ecad9346387f@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCPR01CA0147.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d318ebe-f71a-401e-90db-08dedbf882e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10070799003|18002099003|921020|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Rdj7wvDOa8hOp8Khxw6Ted81UvnOF0shm2+zk7QssvQAPDJYf2+2Qfaunjtfi1CrOsjUalyNeGojU8CbTiraEACQrRX1mYuhD88rjmmkU7DmXpqsd+wYI4bch5GW8KuBPQMi4H1XWRnpKBsqwjQoF19T9MvQQPR3ghxYngZl81fWv6O4Ax/1UWwuX31A9P1OkxY7oLCndVaBDcnenRxcJ78y/VvIzQM4c4whbbymt4+Q8co1c9x6qZVvUaMMiLe9pBNQYh2pOi6WhKU9va/AWVXeOqURNhyqNqG8NqzmMp2acE/1MTiozwxVSUqxCnLFWikiH1L6J2AP6am7GDRlrMujkUdpnxWtaSFJDHRUDdJJn0Q9dcs8Gl7fb0SO6Hr8NNvc4uAiMSi0X0cT6kzwVFaATgtZcs89RUi5OYENeVYExrSh/zLPrSl1mdPOk9Cp4FbQWio6MNOAfcaS1OBbmVXHxk6ixFvpOw3GHZrnNoPvvX0HkaJbPuiww8pY9di+Ljkzp+unsAQ7OwZvW7rr3Usfb4otofK0ryuBSaAJK509FKQc4s4RA+rWkDVsNmorcUKLLipMm2lWXy+BWrgENsu6V8o3bhUSEFfw+NdhM78X5fQIaxXxsQQr1yWlPXK6TR+CsdTJHm4wKNfF0JoJjzZmiw/M2SzchG0bYQ2DR+TOwPTNbYV/KC35HjKvO85TWDg+brlvptQWL6KjaqITfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10070799003)(18002099003)(921020)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VytwMGd5YXYvSHZVOTlEb2R0V2R0OEM4aDlkUnI1azNkWVJ2Ri85cGVlc2dG?=
 =?utf-8?B?MkJuL0NGdzB1LzViYkJwMEdwWVN1azlUKzZqRktocTF4dVRPV3VHc1EwK2Yy?=
 =?utf-8?B?bUhLNk0vQkZYelNDMm9RTnQwck11MmczSytqdWlHSGFmb0dRdFBrb25ZOVZ3?=
 =?utf-8?B?VHBsOFM1RjQ1NGpaNDZ5aTIrSmJ3TVg2aS9MOGwrY05HbUlkb005QXpYRGFa?=
 =?utf-8?B?MWhxYkFwODRubmxna2x5VHB1RDhkRGlXWjJ5RU9uNmxyT0ZGMXl4VDNLQjAw?=
 =?utf-8?B?VlM5SmxOb1F6MUFyVUQvcnEwZWtNb1A4cjZVREorVzFkQVhGYVVBNWtnYTJC?=
 =?utf-8?B?Sm1jRE5qWVlSQzFWY2F5MU9ZQ0tWbmorMGdPOEloY2NjcmRuYWJnUlVyZlFs?=
 =?utf-8?B?TW1NT3RucFovblJDZWxRV3A1Y1QxdUZFMXcrUHBVY3V4bjN0N0M5akYvY1hr?=
 =?utf-8?B?OGszUU5mampPa3pXOU9QajRlSGFINFZnSGtUTkc4RWQ4ZVViMzRRWk43dkh5?=
 =?utf-8?B?bUhkK1JjcGtRY1hYTzMzK1FEbkpVblQrZld5Qlg5aGt1Z1REL0pEMUlnaFB5?=
 =?utf-8?B?bjR4TzF4QUtRV0JmSHJwL0VnK1Nrd3UwSzFZbUxoWWFMS1VCdjFjcUJsc1Mx?=
 =?utf-8?B?WUxGN1RlTHpRZmVMR25hRGFmU3lEVUdTeEZjaDBOeE9jMDNxL3loaHdaMHg0?=
 =?utf-8?B?dkRjL05VL0NkdG9LRURwTjd0MC9wQURPbi95UFRDR0VqVHNOWE9kMzNQNW5H?=
 =?utf-8?B?RVlQdGViT2haM1Y0N1pjTVBpU3g3blRwakJkR1dDaXFMTlNFTVFDMURaOVdr?=
 =?utf-8?B?QXQ0a3pnZTU3L1VOcTc2S0NQZTB1czRsMWJ3YmpLQk9MYzZWamxmSkZMb1h5?=
 =?utf-8?B?WVVWQWpxRzczWnpMUjdFbUgzdTRpcmF4eDV2NmNyVjBRQUhERmw2c21VcVRU?=
 =?utf-8?B?ZVR1SXVRV052amsvb0pvN2RubmQ5S2E5TDYxanYwU1lzZkFUT21RcFJicFc5?=
 =?utf-8?B?aExRUFZidStiRUQ4b2x2VWRxdWR1S3gwZDZoNmExbkxFTWwvZ1dOY0RmZ2dj?=
 =?utf-8?B?dDRzR0owVGlUZkYzdGFaM1IyMU1IZThpYVpKUGMzRitaSTg1U3c0Wk5iWVZM?=
 =?utf-8?B?dzdOaTNsR01wUGpSWisxWGxFcExrcU0zNVBwcGhvb0RBaHYzZnQ1ejRPZmVY?=
 =?utf-8?B?NkNNQ3ozM0ZtMHdjVTJHK0FxaWJBQnd5WFdLQmtPREl1WDdFMzdGNC9PYXow?=
 =?utf-8?B?ZTV2Vkd0dk0xRHkraDZEcDFCTjBYZWZLa1BuMU1SR1JoU2NDZkl5bEFzSXhi?=
 =?utf-8?B?NUVaZlNNUHhCT056bzlzV251MUc4REZKR3lBcFpHV2p6K1loNGtidzY1NXNR?=
 =?utf-8?B?dzdxZUhQTnRXZUN3SXJPMXlQK1dmbEFTSWNybDBxMEgyMU1WUmtjMW44SXpi?=
 =?utf-8?B?ZmQ5ajhwY3ZnTEZqcmRBS2NpdFl0OEg3ditwcU9yZGd0RVFxVDNSN1FXSzho?=
 =?utf-8?B?MDFsd2F1dmNtb3Z6NTB2b3pOSW1RalRzZ3ZvTFpqV1ptVEhkUit6RmFvMTd0?=
 =?utf-8?B?NHN0S0JzbmlhUWJaSUg2bFMvWW1UK0xNNE9VMktQa1Q0dFVRMGg2Q3dMRFRB?=
 =?utf-8?B?YUNkM1c4NzZ3TDFpbFhkL2hJQzBkWkx2bFRhQXlGY2pYVENKd2gzOGlpZUhT?=
 =?utf-8?B?TE5DRmVFTjFFRjU4UUh1RG9mZk85MHJvWUk1VEpXU042d0dtV284N2lSK053?=
 =?utf-8?B?Q0ExeVhrTElRTFloOW45bkdZalJ6WjEyN2M5aGNBWThIWXNrTzRXSTd4dHY2?=
 =?utf-8?B?VlFrQWM0cTQ1aXJYdDlQbnB6MTluN0txWjJ4dmxiUFFJKytlQlp2WmE3NnNE?=
 =?utf-8?B?WDhwcGtCNGwzSEMrM2ZHazVpOU43TlB5WkM3bUZ1ajBsalcxWG11ZTNiQnFZ?=
 =?utf-8?B?RDAzWkFuNElJYm9pS1BEQ1g2ZUJhZUFVdjAzazV6ZURYaWRLSnU4TXA1SmdD?=
 =?utf-8?B?NG5LZHlId1QzMnZkeEVQM0M4Q1NoM0pza0JIbXlKeGN3U0xTdzdTb3VQbGl1?=
 =?utf-8?B?dzVhMkZQYm0yVzJkTy9udzRJelc4WXladHJsYlNIL2JPVVUzbXBxMzBPN1Fn?=
 =?utf-8?B?Z2J6RFFkMFMyVjdZOHlZd0NueUs4RDgvSWQ2V2dFZnJPY3E0ZXkzeGIyajJF?=
 =?utf-8?B?NGYwWVNDSDAyZTRTejlGVklEcUtlZjdvRnlwZFl4T1lsVk9xWDBDeGNsV2hX?=
 =?utf-8?B?WkMyMmpMZFp4RHZzSzcvQXArMkMzalZ0cjJHejhYcTNWb0REMkR4dnhLRkhW?=
 =?utf-8?B?U0dvMXYwdWFBcWpYNXpnVjlwTVowcUdvN01jbDd0NFZ3ZkJvdlZ1OFM1K1pV?=
 =?utf-8?Q?dIZFTWofHJ7AluA68dwNfDy/0LcRDeE1RbQmYlvH+V219?=
X-MS-Exchange-AntiSpam-MessageData-1: vyuv11k5uRCy2Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d318ebe-f71a-401e-90db-08dedbf882e7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 07:22:32.9023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yiCTm5zoB4URb5Ne7h5bSRjHan7Nfiziul2OCVxXmW/ULpT6SOTg5RooI2JjcjZBjTv95lLLcrR2vCyMGWmkzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6604
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

Add a local `Device` reference created from the `pci::Device` in the
`Gpu` constructor to avoid repeatedly calling `as_ref`.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index c04706b60ba8..fc90069bc2fe 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -317,9 +317,11 @@ pub(crate) fn new(
         pdev: &'gpu pci::Device<device::Core<'_>>,
         bar: Bar0<'gpu>,
     ) -> impl PinInit<Self, Error> + 'gpu {
+        let dev = pdev.as_ref();
+
         try_pin_init!(Self {
-            spec: Spec::new(pdev.as_ref(), bar).inspect(|spec| {
-                dev_info!(pdev,"NVIDIA ({})\n", spec);
+            spec: Spec::new(dev, bar).inspect(|spec| {
+                dev_info!(dev,"NVIDIA ({})\n", spec);
             })?,
 
             // We must wait for GFW_BOOT completion before doing any significant setup on the GPU.
@@ -332,11 +334,11 @@ pub(crate) fn new(
                 unsafe { pdev.dma_set_mask_and_coherent(dma_mask)? };
 
                 hal.wait_gfw_boot_completion(bar)
-                    .inspect_err(|_| dev_err!(pdev, "GFW boot did not complete\n"))?;
+                    .inspect_err(|_| dev_err!(dev, "GFW boot did not complete\n"))?;
             },
 
             // Initialize this early because `gsp_resources` depends on it.
-            sysmem_flush: SysmemFlush::register(pdev.as_ref(), bar, spec.chipset)?,
+            sysmem_flush: SysmemFlush::register(dev, bar, spec.chipset)?,
 
             gsp_resources <- try_pin_init!(GspResources {
                 device: pdev,
@@ -346,13 +348,13 @@ pub(crate) fn new(
                 bar,
 
                 gsp_falcon: Falcon::new(
-                    pdev.as_ref(),
+                    dev,
                     spec.chipset,
                     bar
                 )
                 .inspect(|falcon| falcon.clear_swgen0_intr())?,
 
-                sec2_falcon: Falcon::new(pdev.as_ref(), spec.chipset, bar)?,
+                sec2_falcon: Falcon::new(dev, spec.chipset, bar)?,
 
                 gsp <- Gsp::new(pdev),
 
@@ -372,18 +374,18 @@ pub(crate) fn new(
                 // Obtain and display basic GPU information.
                 let info = gsp_resources.gsp.get_static_info(bar)?;
                 match info.gpu_name() {
-                    Ok(name) => dev_info!(pdev, "GPU name: {}\n", name),
-                    Err(e) => dev_warn!(pdev, "GPU name unavailable: {:?}\n", e),
+                    Ok(name) => dev_info!(dev, "GPU name: {}\n", name),
+                    Err(e) => dev_warn!(dev, "GPU name unavailable: {:?}\n", e),
                 }
 
                 if !info.usable_fb_regions.is_empty() {
-                    dev_dbg!(pdev, "Usable FB regions:\n");
+                    dev_dbg!(dev, "Usable FB regions:\n");
                     for region in &info.usable_fb_regions {
-                        dev_dbg!(pdev, "  - {:#x?}\n", region);
+                        dev_dbg!(dev, "  - {:#x?}\n", region);
                     }
 
                     dev_dbg!(
-                        pdev,
+                        dev,
                         "Total usable VRAM: {} MiB\n",
                         info.usable_fb_regions.iter().fold(0u64, |res, region| res
                             .saturating_add(region.end - region.start))

-- 
2.55.0

