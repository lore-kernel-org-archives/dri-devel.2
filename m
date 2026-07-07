Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BC0C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:22:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04C2C10E45D;
	Tue,  7 Jul 2026 07:22:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ez4x3bGo";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010044.outbound.protection.outlook.com [52.101.56.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EC1F10E45D
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 07:21:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FMKcGXIZ908RxgYQjaQ7Ec5BrZK9TOP6BNtp9Iod+wFrEan5UfWBsBTd3UUQgjTrV5/XIX/XJOfIKoY8c7tCI4TcsyQktNCuvEF75k26oHuZeFSTvgELvLfEld2OUlq2SNfgvqsG3axoBRC1x8AKHvdL7zJFjl4r0h+v3FdfjtcQtqNH4DSPtsetWCWTWVPE8W+9Rg9qw2Wp3xkKngj7ruTjFXSdvi4ATzLGToJxxemQ5+czHJihL1E+eTOL1amGItZcj7q8gqXwIPNF/Dyphi8j3eq3LB6tjvlFAetUeKWTrAqddzaYSX0jDWOfZdzIGKVivov4EJyhdfbHmCqJEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjfe5GLrLBEL1Z6iUjyYM8lj5a9uvKCe5yUKDh+IxSs=;
 b=tftJ8Lfp+0RA2leP8+bOnLZ3QMpPR6+SQf2u7wMjhdT3z9dnQuC8CUBB7xRDq0dFwKQp+NLNtBiMBFw6ia1DfAtuv7/HkSgF6lnkE+dhI7p8G9Mj5Mf7AJ4kP70Cy3STlxpACBgGgNpiwGmTm06x5PNbcLtZXygbFRGYkNP6uayYQY2Fpo8E+7d7fGFb+PWrlnQM+jClQbXMK0A//hBTtVcYxJe28zrrs5rwb5u6mWBNqDjlmomekmK+cOLw4rG/xueZqVzDs9bThR1rRF1wbZhw1htht8VF1oosyv9m5hzV9w6Bxv81g4BAGMH7BbSTqmlmr74VF8zB3FnApM74UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjfe5GLrLBEL1Z6iUjyYM8lj5a9uvKCe5yUKDh+IxSs=;
 b=Ez4x3bGoPKSzMgrNwqXoEuVPWoSNY5YFXbaFVxs9exXfZsEYSy7kDuLVlQqIzHlmVGrH0kuj6LSGOQ7QnjHLJlNJepYcQBGZqPPuiPbmNwqG4AK8x0+7w3ZbmUsQNJcP0WaD9yUp0wM+1FgoUKPc/Ge4ZdAjUPy0x6JBoU+FS0n51yUXcpcx2SaBHe0wItYidSOudO0UaNUzn2ZDbvTy1bBDjhkN/sAXAZ+fdrV61nTHrA/qO38nJ/wTGi/tap7dGHO12Q2+whfAZWuqIf0bYnck7FM81Ijy56nlUKOVhrJgtfwTu5YMTZNLgJoKfutO8iydkilXgwH3aSP/hYhHpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Tue, 7 Jul 2026
 07:21:54 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 07:21:54 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 07 Jul 2026 16:21:34 +0900
Subject: [PATCH v5 01/13] gpu: nova-core: gsp: sequencer: use
 GspBootContext
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-nova-bootcontext-v5-1-ecad9346387f@nvidia.com>
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
X-ClientProxiedBy: TYCP301CA0015.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: 01f58343-a87c-46bb-9fcb-08dedbf86baf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10070799003|18002099003|921020|22082099003|11063799006|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: E1IsqXqejejrWC2zl8bM6y50n/ZIgjG0fDNzBtrRgHQuU3+RWtyc6clppy208QHOgXUSY/O6nG6yRfZvWZOk2U6yrBuj59sOuKTcYY9Wc6SV8vHI+ZPJiF02i0vCDnUM3Jme5+UtcHpAqEhS7bEFqDTQ42M+KNa+uiG8YpNOIX9o+QviewnVc6TfhLREVTXeUTXeeq4PGxGMMUp49H8HEdCDQLc1Qn55r90ZbDaREifvhdMf52rh/7HuOsVMyR7PkkbFj2UpyWMach7W7oXOqfCIjq18vQvo6wnDwjEMa56/Ehe/yQkaznB31HQ3UcnCRfhaxNCRQ3d9VlLZRSFkArj83xCqOCr1zxt52NZydHlJl1wQyxt9zM+jd+dl/RLgKGLze+tLIJACTkPfvzVKJRJPrk5muJAd2WNezxG7ZhqHHsEkSclLx2luHge6bnyhRocFikZe3TgU7VoRdRW7RmHnJgb/j95mX6u5GW6fMLWlqh+2hFAxF4NTzV1E6aeBZ1UKp6ei/sUKJDN2cskuAjB1eR4qeIwntP7NrAejCp2fVHo7DKYtF5XgWsqtAukx+cLzhvbpDPNI14BVhF1gk+AMDsi12BEOiUzCcDJC3Jlh+zQ7uxV0VxdL6lHwoZU2f7CosvYGi9X5HHexQIcV4jfiU7I3B7LSgWunR73GxzkvhqoRofHziHTF6s3u0pAiEvar1rPVAI/xYaykq7uAhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10070799003)(18002099003)(921020)(22082099003)(11063799006)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3RiSGRXRU93dFFRREQxTE1UU05YRUVFS1BmNVNod1JnUW52azhZNVF2bHNJ?=
 =?utf-8?B?TUJGSkpzNHR2MS9wWFAraDI3M2VZUFdvVmpLZTMzdUo1Y2t3Yjd3TThnSnUx?=
 =?utf-8?B?NEttS3RLNE9tOGFzbm41eGNoRkxwVWs0TWhUc3l6T010SVpLcC9pN0UxcmNF?=
 =?utf-8?B?ckZNY2k2Q1dlUkFCSFhJT1pSTE9oOWQ3U0p3Tk1oNlVpMzVnVGxMN3ByMVp6?=
 =?utf-8?B?am96STB1N0owZUR1cFBzSjBxRTMrUUpIcHRuNVBlMUhSNUtlVlpEZVFDUTJz?=
 =?utf-8?B?dlVyaGlYaS92cUdDVnF0MCtuelFsY2ZxMUFuaVgxaE1xWkJacm9oSVEzdDAr?=
 =?utf-8?B?a1gxVDRDU3h0SEdPVy9FOFV4NGdwVHNScExYZ2pJN0xCWjRkeldENXRSdm1N?=
 =?utf-8?B?dVQ4bHlsV2VIWXpkNXdIcTA2blNYV2F5ejBZTE1jMmp1MnFYWXM2QzN5TWRJ?=
 =?utf-8?B?eHNWVTEvSmdLY09PR2NGZkNkWjVQbW1jcnU5OUNWVkdBai9RblJza1JXSUZC?=
 =?utf-8?B?eXZlalRPd05aYU53cFd3ZlNNVkg0bTErd0s4VU0zZFllcjErNHd6ZURWeHNI?=
 =?utf-8?B?S0twT0ZHRWNtTkFaZkYxOHA3bFNTTHVodGpmUHU3cTBEQ0JNbmVXdnhOTTJ2?=
 =?utf-8?B?RU9hMzlIRUJ4TGUwOUFtWkU2aDVsOUR2YWpoNUJ2MTI0UXhOcHQ1RHB6Qm0z?=
 =?utf-8?B?L2JRZWxnaW81OWlrOE80cWMzc2NQQmpMU2JBRVdVbVBLenFsRlcvWmdnVGFo?=
 =?utf-8?B?VUR6eXFwZUZPVDFIMCtnUmRrTXYxa1hrbERwQWNDRGsxcUFGSDdtdXdqdm9J?=
 =?utf-8?B?b0NTci9xSGs5UlBXTXhoZW9FRkZBWWhmdnNoN2UreUZKbjNjMnRIWW41Nmd3?=
 =?utf-8?B?cXlpVUZ3VzI0NlpIazR0Y2xmNWVuTVJ1UGhWN1M0NTlpd1JJSHJ6K04wZWhW?=
 =?utf-8?B?Lzk2bEMyRmx6VUR1N1ZWdEFTR2l1T05mVUwzSy8rOXNZSitlSE1CNDdJZDdq?=
 =?utf-8?B?MDBiQzVHMHd0YnlxdzFhOW16NTU3Sjl4aEhqK3YyQ0xFN3BBR0NuVmY1WUxV?=
 =?utf-8?B?TFRDNStpaWF5bGUzdUg1cTMraldzOVFUcmFWRi9jNFRFci84ajZ4d1FjcVQv?=
 =?utf-8?B?eVIrR3dLY1NqaE41Yk9IWXFtTk1EcWV2NHFNZWJubVVRUDBQNTRQMHljVnRv?=
 =?utf-8?B?RHFza2dzckZEam9ORkdqdVcvdE5Wa2ZtU3FYRnlFcUJVeVRRWmZwckZteUtv?=
 =?utf-8?B?UTh2bFpZMWM4U2dSNVFuSTN6U1dXR0RkWEQyb0FxVFJsVE5HcHE0aDZSNkJo?=
 =?utf-8?B?cjltRGtpclUyWkxZbmZRdnJoSWpHd25tTFMyZ1Z3eHNqSHJOSldGcVloSFcz?=
 =?utf-8?B?dWlYelRXbDlRQUU5VmNlVmphL2x3a0Q0cHlTNEFGdWl6RlRxeER0RjBIWDFl?=
 =?utf-8?B?YUZXYWRwMG56ajVLMmZQNzJpM1RXd21vc2NQQmZpZWJYckg2Rm9LU2xrVjRU?=
 =?utf-8?B?YXRxVGJTNVRRNWo1NnB2ZVRlUmxobVorRGZLOWdGNGtGbVVNTG9MM2pOeXJ1?=
 =?utf-8?B?MEZXZkhFYkZQR3VJU1FIckF0bllrYTl6eDVHUFBVS05Mc1ZqUXU0VGswQ1k3?=
 =?utf-8?B?S0ZXSTZXM3N1VVdqSnNSK09ZZmlydktJSHI1NEoxM1c3bUZoNXFXa2k0RXNu?=
 =?utf-8?B?OS9aU3dnT2dJSHMrSE8vZ3Q0bFRiSlpFL2ErT0tZYUZYalZhaVJKazJxeVc3?=
 =?utf-8?B?am1HbGJqZUIrVlpzdVVZTjVyaFF1aVFRUzRra29MR0JxTDdqUlk5VUJ2TW9n?=
 =?utf-8?B?M1JCMFFLWWVudnk5c2lSZkJNdnFpZFRwMXJaSWJuc1dlMGZGMW12MEpMYlhC?=
 =?utf-8?B?dWpyOG5zWGdMYmh1QjB4UDNleXZZMzNkUzkvYlRETFRrRVdpRXArcUFSbVRQ?=
 =?utf-8?B?ZWZPbHdNbXNrTXFhYVp4aFZ4TWZXL3BGaTdxY2loWHYrQk9NbXVMWCt6RkMx?=
 =?utf-8?B?TjJOcURaalZ4U0gxZlpxUE1kK2pCdlNwSE4vMkZicG1ibVlPYmR3QmxRV3l2?=
 =?utf-8?B?cnA1b3p5d1o5RjdYU3VFVUxRUU5uZlJ1d05HbTRmYUg1VC9yNWo3TE5SaHNV?=
 =?utf-8?B?bytONnJEaStxNlMyMEFsUTZKYmljdVFyaHl6N2w2bWtKTEtqSmhQUXRsZmMr?=
 =?utf-8?B?KzlkbmxSaTJEaEowV1M5NUc1VDdYTnEwbGpXRXlwY2JEMjRtUFRqMnpnTjBG?=
 =?utf-8?B?SDdwVDRtZnBIOXFsalJFNDZIamxNU0VTcGl4S2NCQ1R4bVlxK28zeGUraUV4?=
 =?utf-8?B?c3hsaFZiRVo2OVlWbmlMVExJa3J4cnA3Z2h0cUlkN3d2YllHVFM3UHJBcGt0?=
 =?utf-8?Q?UKBWtICG6Q7W4uneKuM5JIUt+CPBW9ulZlyyF7ayvrzKg?=
X-MS-Exchange-AntiSpam-MessageData-1: UKbimIjWCgdNwQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f58343-a87c-46bb-9fcb-08dedbf86baf
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 07:21:53.9483 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KlbrjvAnkMfEDBPA5vN32u6yJooyhqJQy4wT1il8vgH1jT5MCLPYP19b+NpTZFmCaFnszGU84eZTWUT3yY1Q0Q==
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
2.55.0

