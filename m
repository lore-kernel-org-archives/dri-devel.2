Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61FC1E88D99
	for <dri-devel@archiver.kernel.org>; Sat,  4 Apr 2026 12:14:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D50110E101;
	Sat,  4 Apr 2026 12:14:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yh8P+8C8";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013036.outbound.protection.outlook.com
 [40.107.201.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA47510E101
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 12:14:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6jX0FRBOzJWCa7Ahth9fwK9lI+DludbNBTEScR336k8yCTVV6lunISJORksTh495al6lOjYbc+B1kfaW/lI37NJZDO5F2BSUeDMxf3Wf/tf6llkVWeUtK2CXVxLLFSvpAcj3mQctmKKW6Ph4BGCXjVIeqOcYOtg6akZu0VBsPjok664NJ510iz8Nfcqu7p6F1N58ogGGcIQmlnFtieS5+M+IRZpZ4+QSWl6Bbv7agcc7LaAuyWi4v9PR05niPUbLLtCBzxiuubmogIb10TLUc+ZYaAXwoeUySKciMKsBeW7UPG8Gm8xTp+nYF4nt9XH3TSXX/+IvSdADQli4C+FYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=skB0jz/2qWx7Q3iAdWNPY9Y0KnxUWBWNrP9DXEsX/vE=;
 b=jch5sLTIfHVCmyh14q/BQuBEiQ5d+43binf5O09rHOTPcW8vAv/I4UIAHmUx+I9f2/tf/KB13FkvIVhLnu1KC8g82cV6tJHZR6bwWl+w30yVAIhZIqnJG1cpeDsT7/e97G6dAXfVA9XHx4C/pWXXlyGBi8R4h0d5yXjAXwiglGS61PE0tt5lfrLtrx84/nJ6CQhJtGHHlsC5/hCbbEvnMBx8qGJwhRrAHLhB5mBdjp9V5yDJXMQWiFZ5zoE8vAwC6Dz+QhsNjSEMV0YuCPmo5DXsxcgmKJzjECTj4dCHg4WZ+B/H5RlfrSzuKRWf8IDwuHC+8xNdhzpWjCdzufLEAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skB0jz/2qWx7Q3iAdWNPY9Y0KnxUWBWNrP9DXEsX/vE=;
 b=Yh8P+8C8OGpwTzB+7Bsr2zU97IYG6VNq2N3djhtw2+mFy+8Jwo2y4+1YyteZNt9MJYf3DFu1ubiGUcjOnyg50KckAAjL05aV6QsO10v0z0GQS1DD6AwIchBxE1QFOxCjS2ytuzDsU1lzCJZNe95ZwBh8VRq/roMlRNPfo+YYEB1CjmPsCh1+rpQHo+XOw8YMnop0hoCJeh5iEv8CqIJ4rXyA6FoNTL5BKzaRl70859vDZw+C9wFN/pbXh68ymgkgYNIzVHb7mr5+kAleF4h3lLsZ2bnp7C7VAfWBqSnTdrAnmrGOJnTWdUWp063VC+7VFY+YSlN4he+si9cyPssuSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by BY5PR12MB4259.namprd12.prod.outlook.com (2603:10b6:a03:202::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Sat, 4 Apr
 2026 12:14:50 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9769.018; Sat, 4 Apr 2026
 12:14:50 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Sat, 04 Apr 2026 21:14:30 +0900
Subject: [PATCH] gpu: nova-core: falcon: align firmware DMA object size to
 required block alignment
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260404-falcon-dma-roundup-v1-1-1f56d808b091@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrB2YSlDbqxQXaWbUKZpIYkpBv
 HvTdvkW/x+QJKokuFUHRHlp0uALLnUFbrZ+ElQuhoaalgwZHO3igkdeLcaQPecNSZi71thrbwh
 KuEUZ9f2b3oe/U348xe3fE5znBzl65QV2AAAA
X-Change-ID: 20260404-falcon-dma-roundup-0edd764a9840
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: TY4P286CA0097.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|BY5PR12MB4259:EE_
X-MS-Office365-Filtering-Correlation-Id: 407d2374-1d74-462c-fd53-08de9243c50a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|376014|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: VeH0ztiHJ+SErXBUceqz+X6LbK5NGgGifAdEFfMqcwqNQc3vOkWyL4heIXgVTstYeJ/24WuPT5gFymsRPO47B92Ib3CMjRqFJUTJsvTTmVyp0CkoNhiJjtIQDJmm/woUAFx8ZXeReNAslOGalyj+lucUkYLCvV4KN9aZkXbUGFWL+oQPIWZijWIofWxBthLYJL7G+w7b/tMj/y68Zxqb2wnTp4r6HpJd+xdmotiquBQxm9nyHSshNul7oC8KchEsClwgoK/sI/m1X3mZHopR/W2jAFeO37zLnFPz3pqeXZDs9kr+am4kzs5JvzoCOwBGzD8f8jVcqoXPgzPCv9gnDxTRsE4opRVk9tM9kiMmAkT9kLXdibA7ILJ6i2VPR3aLiZLehK+gK3mNLWjfukm4OQjVf8OUm574Kpu+STnkNFba1pDJRMJxgS0do06bhjgoJopSyFzQDBpjeQtEIzOgozu0/TwN0MtZx8jAhNeZKql7+mQPTDphbVAAhZ7kziM2kn+8Zk69l1t4ekpcDOgPjJWKsO3oRSro7JQG2eLCN4iBqfarAti6RMm1BDTdQIK3ehDXDpvN49d0in6RQ9VTKpNfANgaTfAcnUjUzm347u4QmSQ7bKMUo1Co99RKNWcWoiSY/drNtikKqlxHDG+h9C5HbI6x+0lqz+EcPItSLaFlKYLpNMXZZEa92Wlfqm0NhvpxUK2w6UEXZ25iPaLc6K4/wtMGSBq8+g87nfyve7M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QU1KUEJETzhnRzdBbk54MURRU2NOQ0x4M3FxdkgvVE9wV1l5MU5WNDhGVG1S?=
 =?utf-8?B?Y1NIUXFoVi9OU3ZPSURsVXh1ME02QjRlU21XdzBLRTNWK2o0ajFVVlltVXNO?=
 =?utf-8?B?bHk5WStaMFlGblhnMHd0ZzBhaVA3KzU4elBmQzZNOTE5NGpjOVVoL1BvSXVy?=
 =?utf-8?B?dVBJc0RZL3BJLzFnVXo2c3lyeWFyQ2xtMi81QWFyUExOMGkyd0g5dDZyUStL?=
 =?utf-8?B?K21Od1o3NVpYWktMaGd2MnMrQWNoT1pLU0N5MWEyL1JNbEJIU0JQNGZUalVv?=
 =?utf-8?B?UGZUN292RHM3S1FBa09UaXZRNVl2SXVwMEd4UUpCVWlwSGRSZzl4L1hqZ2Fz?=
 =?utf-8?B?Slcwb2hBaUg2YnVDZ2piS0JORURFbGgrN2RkckdpSlBRUUNxWVNseHBTb2ZH?=
 =?utf-8?B?Q3hrSW9PVktDeVdpWkt5Z3NNUjVQa1BBUFdDRCt5b1lYbk92MXF1eEpoNHNR?=
 =?utf-8?B?eHIxRkRqU3d2WThac2RvZWFTakNWbjVxZlFIZkN1dXpmdzNINXRnUWJ6ZU1o?=
 =?utf-8?B?SXdrM1FCYjFCaWJPbVY3alRHcHlKS3UxcitoTWRsaUlyV1hGalJiU3A1MXpi?=
 =?utf-8?B?L2h2bWNZeDh4bDNkU2ZFTVFMTVl2RFNpYVZ4b3ZYaExlQmVtQUswcjdYckkz?=
 =?utf-8?B?YkZqZS8wU3ZSZjUwdWZGQ0toODFycUg2U2lxTzBqN0MwSFdubW1MQmF2MDB5?=
 =?utf-8?B?ZUt2TElXaTRNVjVZMm85YXc2djBkU1hNS2R6WUpNZklwU3lBazl6UGM0RmQv?=
 =?utf-8?B?RHI0T2pvMVlkazJFNkc1Y3hMc2VYa1k4SXJZYXcveWlKOHBVSzdENDJwaERz?=
 =?utf-8?B?cmFvZjhtUGpHbkc3R1Vmb2hiMXFuRUR0QVphWUducThUZndOU3ZQemtBRmxw?=
 =?utf-8?B?V0Y3SjlqbEV5ZXd2ZlhiYkZiSTlMY2JmU3dXdDQyNjFHOGxTOGlMVmZZOExl?=
 =?utf-8?B?YXgvZFJYejM5Q0x0TTZFTVRBV0NzektWS2lzanQwT3FXTm5kbUtjdkNscnh2?=
 =?utf-8?B?SkI3NWlvQ0dpYzBETjFHUHhnaUFiaGVwWGRsVW10dW9LNjJ0d1pkNU5waHpi?=
 =?utf-8?B?bExCZXRoeVlUUm5NcnRnQ1JqbjN0eTVrV2JzTG00WlVqbkhZL3RHTmFtdTJw?=
 =?utf-8?B?TDlVb2tJRDdMSm00S1ZMYVYzNkxGQW1Nd3ZCbmEybm00L2NVNndOU0pmRG5Q?=
 =?utf-8?B?MmpLTk9lKzNKalNaTTdxZS9Yc0RlU09MUm9YR1lSZFpUUVY0R3liWTBmdkVQ?=
 =?utf-8?B?Y2tOMFRDWWxaYmNtSnA1V0pvck5PY1hSZG42cy9FK1dibndwM21MV0hlQ3Nk?=
 =?utf-8?B?YUlCWUdHMlNIdmgzSEcya1Z6TFlWdkJGT0JrZSt6azBIZmhPQ0dPeXNXYXcz?=
 =?utf-8?B?L0h0dGhTZ1ZpRTk3YzdxaW4rQVVmYmNHNWRJSkFEUS82V3dTbDQ3S3Z0aEo2?=
 =?utf-8?B?T2VjbXlONEFGZFpTOXE3SUIwQnhCb3NRemlVWEF3MHpQMGk2cS9icUlOSEQx?=
 =?utf-8?B?endpTmJWdHlyV1FyS1lLc2k5NUd5VHJVbXhZaWhOVVlHYktBT0wxTEcraUhE?=
 =?utf-8?B?clRaY3k2Z3hORWVjVUdqNStLT0xxMmFmeTZIby9mWVFueFVDRjVFM2ptUHJY?=
 =?utf-8?B?YmhCeWZpUXNteGFoY0hNbDdvREdNTGdxV2d1ZnpCN3d2WTh3RHMxMENxM3hv?=
 =?utf-8?B?U1B0dzU4V0pidDYwTldlV2E2Ujk2d3h0aXorclRwUHArVE90elJEZDc3a2ww?=
 =?utf-8?B?bTg2R0MrTkFVaXBEWlRwYVk2OVYrb0pWNkswZXQvdkY4Z3dsL1NNSUtHM2h1?=
 =?utf-8?B?eC9iTDZydm5DSk1aakx5eE5tSkJidnN3dnBSVk93alV3Q2F4SVlwc2VzUnRy?=
 =?utf-8?B?cnhKS0EzRWgrMjhndHRxTThRek1QWkNObnR0Rk5welJqT0pGa04xaXA4VFFX?=
 =?utf-8?B?aXEvUGFOMFVWZDlEMXNTUjc0UmpmWnI5YTlMcWUyaHNlbCtESU5ycVRaZXV2?=
 =?utf-8?B?bXlxcUNuSFpPUGcybkYxc0VvK2RrWURMMG54NGU1bFE5WVMvOTVSekRiY3g4?=
 =?utf-8?B?d2FLVm1lclhVZGxVN2o1ZnM4YUN5QWhkVDJIQTBYMFl6bnVGTVN0TFF5Y25X?=
 =?utf-8?B?MllacStGTU4rc2pYMDE2czNVQnpVeGtaQk1qSXVKOCt3YUo2RVZQNmxnZHhz?=
 =?utf-8?B?UUl1RnY5OEpibjEyMEcrbGFlNHJtRUdtQTNzNFVvTnBEV1c3RkVCT3dodUp3?=
 =?utf-8?B?cG5CU3JFYkZkYzdHa0NrclUvSUFMU2RnZzFNN2E0bWR6aTB1L1pOcFNpMXVi?=
 =?utf-8?B?M2ROVEZzeThGN3dZenQ5a0ZrR291QjNWT29LdTRITCtidTZ4TjRzY1R2Rkg2?=
 =?utf-8?Q?4AZkGw123gJfxu9lzOCvxJYekhMzqWbV+KNDb/tf8zuho?=
X-MS-Exchange-AntiSpam-MessageData-1: bFHdFpGVVtnzjw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 407d2374-1d74-462c-fd53-08de9243c50a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2026 12:14:50.2031 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cm0eo//7GhNa2X/BxT2BMfHcUiMRs/Rx5fOesmt7zvGZfG2rstwNyslK7HlEEk/RNpj38pWSC6wguc06bbpsHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4259
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

Commit a88831502c8f ("gpu: nova-core: falcon: use dma::Coherent")
dropped the nova-local `DmaObject` device memory type for the
kernel-global `Coherent` one.

This switch had a side-effect: `DmaOject` always aligned the requested
size to `PAGE_SIZE`, and also reported that adjusted size when queried.
`Coherent`, on the other hand, does page-align allocation sizes but
only allows CPU access on the exact size provided by the caller.

This change runs into a limitation of falcon DMA copies, namely that DMA
accesses are done on blocks of exactly 256 bytes. If the provided data
does not have a length that is a multiple of 256, `dma_wr` returns
an error.

It was expected that all firmwares would present the proper adjusted
size, but this is not the case at least on my GA107:

    NovaCore 0000:08:00.0: DMA transfer goes beyond range of DMA object
    NovaCore 0000:08:00.0: Failed to load FWSEC firmware: EINVAL
    NovaCore 0000:08:00.0: probe with driver NovaCore failed with error -22

Fix this by aligning the `Coherent`'s size to `MEM_BLOCK_ALIGNMENT`
(i.e. 256) when allocating it and filling it with zeroes, before
copying the firmware on top of it.

Fixes: a88831502c8f ("gpu: nova-core: falcon: use dma::Coherent")
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/falcon.rs | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index e0315fda576b..eb0cf1f7329a 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -11,6 +11,7 @@
     },
     dma::{
         Coherent,
+        CoherentBox,
         DmaAddress,
         DmaMask, //
     },
@@ -613,8 +614,24 @@ fn dma_load<F: FalconFirmware<Target = E> + FalconDmaLoadable>(
         bar: &Bar0,
         fw: &F,
     ) -> Result {
-        // Create DMA object with firmware content as the source of the DMA engine.
-        let dma_obj = Coherent::from_slice(dev, fw.as_slice(), GFP_KERNEL)?;
+        // DMA object with firmware content as the source of the DMA engine.
+        let dma_obj = {
+            let fw_slice = fw.as_slice();
+
+            // DMA copies are done in chunks of `MEM_BLOCK_ALIGNMENT`, so align the length
+            // accordingly and fill with `0`.
+            let mut dma_obj = CoherentBox::zeroed_slice(
+                dev,
+                fw_slice.len().next_multiple_of(MEM_BLOCK_ALIGNMENT),
+                GFP_KERNEL,
+            )?;
+
+            // PANIC: `dma_obj` has been created with a length equal to or larger than
+            // `fw_slice.len()`, so the range `0..fw_slice.len()` is valid.
+            dma_obj[0..fw_slice.len()].copy_from_slice(fw_slice);
+
+            dma_obj.into()
+        };
 
         self.dma_reset(bar);
         bar.update(regs::NV_PFALCON_FBIF_TRANSCFG::of::<E>().at(0), |v| {

---
base-commit: 7c50d748b4a635bc39802ea3f6b120e66b1b9067
change-id: 20260404-falcon-dma-roundup-0edd764a9840

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>

