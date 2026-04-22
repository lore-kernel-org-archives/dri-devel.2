Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF16F9EDD3
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 13:41:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 397C810EA26;
	Wed, 22 Apr 2026 13:41:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="akhSVuLb";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012009.outbound.protection.outlook.com
 [40.93.195.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58C6510EA26
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 13:41:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MA8/sAT0Ii/Bue4TKr0PBj4bwFA1y7Q5c85xnz0FMMn8Fc141J5RjTFso7LbK3bl//8MCU3JMmagEytcIVQxxei9eHkjgrjoQfIa0cCWCoSstODm0CMs4EdMfHAlm/8cysqkWBfnH7JQBG1tUXIastxX2xVl0D4moLYHhv6PLQZ3jwgeFMkPT8NVUOHTT0NyDM1rG3SWquw/sOJGRRuoWdNK223b/CoS2Y4wAIJLD99SoDwCjl8xItAhxtuVTkN5PSSbVmNbqioTYPXR2D33atGbx7hCadPz/Vl13yNMIrhjeAaAPCIu8UjecXQAXclTSPXIA9xo2mbSbk84t4w7LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vc7x6uoYP0xSBehRQcbJQUOhQ02pYsjSCZ9aDX/um44=;
 b=NQigsQM8uoHVd/0SwaBJ6Zih9NbELMq0uERFYb14V6BfAjKhWV2/aVnxES2N114AOX+vrGgAigyjRYNyj55metAkPh9+47bqhlpuAI8ZsmUyqAGPjhnGuA6HVLiQbzCKpiCNki5VA4/eNZQrCwhYYM1Cq/gmKYyECtD2kkFw9nh0XQ19xPKtOa9deVfe9rBCR43BRmT04rLlFw8PZqes3WjwDT3hoYWXtWv6DvU3ngw3Y808PlLJXJfTIYIz94kRwMDCCqiH2k2IBoxbRQkNTfVN6jSnF4yt4WiZ78bZLbS0oWYnqWSlN1Wl29mFwWZASHtHuRzJ3UZAZfK6ds12RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vc7x6uoYP0xSBehRQcbJQUOhQ02pYsjSCZ9aDX/um44=;
 b=akhSVuLbCQT4XgWknaj5jhqP402x7Y6vfGlI47i8h3ck+VYY8vT6kO6F/LqiDsDT92uCTFMFw1uF/W6GvXCo5N1tOZqIeyrtAcXmcsGdEXBT1tPfO3p2N/CiHSH7UpcLqFKl0LrV09csUkzgLvJ7fEO5MIrbsb+2AmGVrmgU2UBYwKiHrl/6Vwe/GaRsgKPNc8iktETlu9PNscJlpgolKegpw8mktDC4zW1Ck2KjS6wdg8syXhGBlamXvsnO+R6fkZ1kFvieQVfhSI1Y5hAckIistp6qzi2THsgCbXIessnMCd53iRGbFJwU+al/5tcOTDYxliMjc26W/T/LbYCMYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS4PR12MB9682.namprd12.prod.outlook.com (2603:10b6:8:27f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 13:41:07 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9846.019; Wed, 22 Apr 2026
 13:41:07 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 22 Apr 2026 22:40:52 +0900
Subject: [PATCH v3 2/6] gpu: nova-core: use warn_on_err macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-nova-unload-v3-2-1d2c81bd3ced@nvidia.com>
References: <20260422-nova-unload-v3-0-1d2c81bd3ced@nvidia.com>
In-Reply-To: <20260422-nova-unload-v3-0-1d2c81bd3ced@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Boqun Feng <boqun@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4PR01CA0057.jpnprd01.prod.outlook.com
 (2603:1096:405:372::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS4PR12MB9682:EE_
X-MS-Office365-Filtering-Correlation-Id: 71afb6c9-a3df-40d0-cf26-08dea074ce4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|10070799003|366016|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Zme0Qrec1/0L+JxK4Qwgd60aoN4eni/7dB9ggv4OtFW1x+QbuX13k+zv4VODhNGhuLmFkAyfM0o1ZgrIdPCpdAuY10g6HXMmGDYL3LDib3048zNf7OP6aZIBibftXL/UyY1UsOBePHEaiTEBGZozWx3MJUyl01HPFmcEGNNfYLgqUW92dlHkUPPQQbmCrbhtcnRXl37F7/fZ9QvkvNpUxvchBpPNF2qtQQQz3vBZFolde0LP+dxKcebsXzh53gNSModBoDfRPW6tp32j2hxRAal/EYk7SgpkDpv8C0pZojjK4kTISrgm5en2SvNYllycU1RWOXB6Bu2b0GXL3/dhKsReu6oI31mOzUAMxqRl6Yk4pqAULIS7PiIXAexd2vCAE/qp98lKKTtvSwKb/9KUScoeIhNlghzPTo1DabxhZ7Bzha7Dc3AzjdDZ5+CKbuA/EzlpzlLnIRA5BQ+yT8Am8N1Js0Mso/NsbxglrGZsaytzGajtY8jLeTYOshIbCVP+6FiXQOJY9KbNipIhFnydGulTE+850oRnrI1TyEL/mowBrHAACpN7sSjwXeP++DwxdlzG2Rgaz+B3s7AI/Se5BVmzjMo+SehaMLQp+wBW+rOaBqN4B+rxf4axfPRiKyqPl4TWSiTIomUYdfU4/AZR0KgM514XBILt79FamtljfQYhdibHj5Ru8e0OIIVt+TaJSYtRmx1iqxQv1g7lMiRsp+Ehfx2r81OOcfuqFnbkHyyNKBy9phT1iyYb3PDPJf1UC+kw5EzJGNdP3QtSq2OngQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(921020)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1VraG92dHdHN1hUSG55UjZBZnNUdjdzYXlXMk5TOHRpQ2ovSXRucDZybFVk?=
 =?utf-8?B?Y3ZvMlcvbFNGdTNJSXBHaVhxUTlwYUY2dkQ3OWRRTkhYNENmYkxGRlQ5Z2ZL?=
 =?utf-8?B?eDFGUkRqdWltb1NrUUh2V1hndUliQTNJMEhaQmdVTG1IbFNwVkRTS2h4bWNY?=
 =?utf-8?B?L0RNUmFGSjA5eTVFdmpUYUYvYjZkL0VvdFdjb2VGM3V6bFpRdjBBMzYvaHVH?=
 =?utf-8?B?Ynk0L29FT3lJbnZCY3pZeW5nRmJRTHFldXpDNzRLNTRweWczbEJRMTVNanZL?=
 =?utf-8?B?YytEbCtnK1VmUmFOWU95ajNqZm9kT3BscUt2YmQxMXUyeEpSSEVFMEZ3aG8w?=
 =?utf-8?B?bnEzbXVJaWtnaFpIekpWRmpZc2NCZ0dJVFJ4ZGplbkpnbmpjQTJHRlRRUzdN?=
 =?utf-8?B?Q3BxRy80WnZwUVAwcUdiVllpTzNaWkt6NDhzTkE3ckR2dVVEb1RoYllBSzYz?=
 =?utf-8?B?Q1JrYURmclZ3ZXkrK2RGOEFic0pCTWV5MWYwZkkzMzRsQkxnVEw3aGIyOXlM?=
 =?utf-8?B?YVdZbW9BK25BcElXMzZjaVpia1Fqcm0ySHFHMnA3Tk5ycExtamZjMitjblk1?=
 =?utf-8?B?Wm1UR3N6Uk42VXhGUGdDUXB2cnlOeVVpSG9EaGxOVG5malJ2WlBiMTNYanVS?=
 =?utf-8?B?UkxkU1BkaDl4ZlZheGFrd3lnSVB4eEhHYVBaTWdpZ05QRmdIQjE5Y1dWRStP?=
 =?utf-8?B?WXl6NG9ZTmlNazBPL0hIN0g4R1I5TjdiMHJXSThXTkFGem1PRjhsSm5wZlhY?=
 =?utf-8?B?YmMySnF4bThUNFg5TERodXVJeFhTODBJamVlSTZpRENRUGZiSVl2ZEtxL3dF?=
 =?utf-8?B?MmtGVTB3aWNIbVRDUDBlRFVmMDdtQi9NZDJ6Y1ZwRGlYTXpaWUd0TUdZYnJr?=
 =?utf-8?B?U3dnUnJEL3FlWVQwWmREZy9samljYmowVVV1S3Y1MyszSEMvM3RyaXlQQWpJ?=
 =?utf-8?B?R0c2dFF6eGVoUHVraGNZWmpXNXo0NTg0b29KMm1tYkhGZWhoQUZNZWllcUNC?=
 =?utf-8?B?U1kyZGlUSFhuR2JJKytPWnNGYjdCYWdDSTZBZHBGV1VYem5MVGpwb3hZd1Fv?=
 =?utf-8?B?SGcwL1ZySTN0b3pzYTJ5RzNsdDYydFpkeUJaL014NDg3VEpXaisrcG5rQ1g4?=
 =?utf-8?B?SjlCSFpCQTgva0E4NERtQ2NySHdrMTJYeWJyS2NrRVFrU01oMFB6K1FRUUND?=
 =?utf-8?B?MmF4aERNalZ3YmswWGR1Snp0MGdaOENNUEFGamEvREE1TTVBT0NKS3dWcllq?=
 =?utf-8?B?WEFsaWJpZGNjWm9ONlk1aEZUdnlHeUUwc29BVkNxZTFLRGJTSVIrY0xqWUl2?=
 =?utf-8?B?bCsxTUZrZGJPWWhvNWFtR1M0TUllRFJYQi9iYTQ2WUVTWWtGdGt4ZjBTWU5V?=
 =?utf-8?B?bDhIY3U4ckxLNzFlVnNhZGhxRkFnaENOdkJHZFdWQ0puUmk0WDlyQzArL1d2?=
 =?utf-8?B?QmZ4dmIyOUNTTzFFb0xxckFXMjh4UEN5MHBISjQvMjhkUjh4ZkJPYVZiMi9r?=
 =?utf-8?B?STFzOEhhRjRCUWZCMUxxeEoxdVVkQ1RvZWNVNTAwSCtaTlRIaUJnZjI2MkE5?=
 =?utf-8?B?UDZRSmQwNDVCYlkvRGZNQUdwNTB6WE54TlY5cXZSeXdGdkxxTXNpTThKTlE4?=
 =?utf-8?B?Z2YxZXAvdC9jL1VWemJOTysxNkdxTGwzdysxL1FPR2xpNWtLdG9qYVZtSkdn?=
 =?utf-8?B?NG9uY1ZETGpVbWhLOHNpNys0OWZXeW0xTUFLcDFpazVGdW5PeWUwZVJoekRR?=
 =?utf-8?B?VjFKM0hvQ3NSYUZta05LMnBRT1h4NUhxdER3THdnbUdMU0Y3b2U2TWQ4QXE2?=
 =?utf-8?B?d2VrQ2h0TEttZHAxYmVZSTJ4MjhFdzl1Vmozb0NiMUtESHNaUDFCdmpCSklJ?=
 =?utf-8?B?R2NjUVRjQk5VakE5NlZBTXBhZWRieW9xK0I4ZmNUS2V1Q0YvTXdRUnM5WnBm?=
 =?utf-8?B?Vm1odC9KYXV6Y0hkeWluZmE3ajFsVUNoQTlEWHY2Tm1FKy9ya3E4SWVwbGJp?=
 =?utf-8?B?OXY4ZVViT0cwMHl5a2w3T3NLdzhXRlMvK1hHMFhGWXYvaUJPVlR5Z0IyRWxN?=
 =?utf-8?B?akRoV3plS1ZVRkdHdklveTlpZnR1YWc1VC9ub0c1ZWN6MjRpRko4VTI5amVa?=
 =?utf-8?B?eE5BNkxjbWxOWnlCUnp1dDVhQWp6YW9VOEIySHkzMDJQdGVzdnQ0aytJRXhk?=
 =?utf-8?B?OVBucEpyNEYxUlRRR3VTeGs4cnhaMkZoRFhCdUtBd2hBMm9uSnJ5Y3RNMHF0?=
 =?utf-8?B?MUFySTVzSlBCaXo4QmNmcGlmSlZrZzRxRUtCdUlqNFRMMDEvaGV3NERpTFVO?=
 =?utf-8?B?MEZHQ1pKVUVxRzJRbDd3czNQRWozaU8ydXNRNDUrdndVdFJTNUp3eDhuNXVw?=
 =?utf-8?Q?goqOc6yAFwFMG7FzF2b3jwqZ/JOll4syiCtilaAC94kvz?=
X-MS-Exchange-AntiSpam-MessageData-1: VJj/DHk/dYyQfA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71afb6c9-a3df-40d0-cf26-08dea074ce4b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 13:41:07.2418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ah8/w0JnWR52VrZMdhxcwa7lS1CBCQFHDdLGYj8/E44SJ4aipxhsI80kfYq6zjfolsmAkHxgtTqUmfkfYJUUeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9682
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

Use the warn_on_err macro in the unbind sequence, and refactor it to
early-exit on the failure path as we will need to use the bar for other
purposes.

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 0f6fe9a1b955..1701c2600538 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -279,10 +279,10 @@ pub(crate) fn new<'a>(
     ///
     /// Note: This method must only be called from `Driver::unbind`.
     pub(crate) fn unbind(&self, dev: &device::Device<device::Core>) {
-        kernel::warn_on!(self
-            .bar
-            .access(dev)
-            .inspect(|bar| self.sysmem_flush.unregister(bar))
-            .is_err());
+        let Ok(bar) = kernel::warn_on_err!(self.bar.access(dev)) else {
+            return;
+        };
+
+        self.sysmem_flush.unregister(bar);
     }
 }

-- 
2.53.0

