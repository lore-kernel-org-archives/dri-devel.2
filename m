Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 582FFF9D0C4
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 11:55:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAE9C10E5D5;
	Tue, 14 Apr 2026 11:55:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="mnMy0CBC";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012010.outbound.protection.outlook.com
 [40.107.200.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20CF610E5D5
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 11:55:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eFLEhqtxTS8R+wHQaOP+gkm3QGY9t5J8Gju7MPlHX0WbCtSw349jBQzTpHE0FHf+bAgWuAW28a0c4boacNUChzvIb6C74nsTppZRuSDq5ESLgUp+XtsIJebw+G2wdWALfbXCTdYOVjN/t5y3MvGcgYqHvkrwgkNxBuQKYeDu2XMoCWAIk95acvK4sLrj8/xabKcQY6//LnQOUL/2fJ8dhvRrGTQ5Y1KYcuvH5+HVZ3mp91+7p55h14HXs1dnqVi6golwlViWppOW03sf/H+34SbDwuUfZk4PkJkESyG9LFfg2UB+FFOYSA2egvIVYlLMIAbKxRbACUezXn0iX6/JUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pk+xizTETqPHAOBT1+M127GSswaa6SBqtydg9r2CX/E=;
 b=BexuZUwdSC10rP+PI7hJ63JmfZHrtdVOmhNY8MaRgcTJNYyB/g8bjd9U7UIbGj0Lw5X0FjgLEFHtYCYSjkfqxQQNgO34exHlXeUOlEr+5W/Kf01hBSymW9kinCMOKww/fJHGe4Iye3ok8d2oDmq3J8t2+hTB0MEDZVeyqfkd1VMytMrE5xWq4q4PYl+w68ZlF6/OTKOj68Cuh4rW/Ij0OMiQS+pqyMJMDJ5HaHXu9F/mYNJgfG71zFfOWwokGHxsKAcTll6jcC21ir9cvgUBq4U0Tof7qLKJ/5WUngg3MOzPrwRvn2ZwC4/eUdCiKgDfnirqq2zWth+zKf4p8XMHuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pk+xizTETqPHAOBT1+M127GSswaa6SBqtydg9r2CX/E=;
 b=mnMy0CBCuc7u4qomf6JjDjzNGFMW59v74LIO3cjDhQWKXDtsOz7QbBj+Ly40dIszArZhyosPBFO7p4IYZVF/zHu6ylEMAfLfw8ivAxpmhTQzKeZNzB7QQcK1RPWEfOr9Tm7kKYo5MQsmVA0RCYk+eYXAo3rDU2rrhQmui1ADT4/cKnrxz4lM/5uYi0bjmEeZxGDqqdj72uvUw/6XR4YmVI343wGY/M4xV7reFLDicTl1tyll5g212lFaosTLUbBskx6FVT4x3xsbKlF1zgDuwaXmkTQre6CCBZR5FSnrI3YBQTkwc0PkGG+FAfCO7H60nd6splzk7fgEwlqyTSXMig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SJ0PR12MB5636.namprd12.prod.outlook.com (2603:10b6:a03:42b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Tue, 14 Apr
 2026 11:54:55 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 11:54:54 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 14 Apr 2026 20:54:13 +0900
Subject: [PATCH v2 10/11] gpu: nova-core: vbios: construct `FwSecBiosImage`
 directly from BIOS images
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-fix-vbios-v2-10-705d30d16bba@nvidia.com>
References: <20260414-fix-vbios-v2-0-705d30d16bba@nvidia.com>
In-Reply-To: <20260414-fix-vbios-v2-0-705d30d16bba@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Joel Fernandes <joelagnelf@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: TYCPR01CA0102.jpnprd01.prod.outlook.com
 (2603:1096:405:4::18) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SJ0PR12MB5636:EE_
X-MS-Office365-Filtering-Correlation-Id: 880306ee-8fff-4c40-8229-08de9a1ca4cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 8WMkFIRaGqHwzPVdhrh1duuG+7sBC8GkUMLbDvo9xER/52n55Nw+647ku4vRy7rE8t5unLQrE3j3Ys70pBVdvJy7YzwsAXDyTc+QVMO/LuMzHx4WQjTEHwUIdHWwVWIdhjeKLlKbYCXJnrxwuB+ljeXULOwFLBQBlmy6M7NMvsUnj0S8IsGwIP3X5xgmvr95tKkgkUliSE2wYjWoQ67bM9M7ldO92UjNkHNNXyLFogimRqgX6w2nfBnuBh49Y3m7aUp0VzRUNN7wbT5c+3DdFBudT+KZDfszQAUJ5Xyon7fK87dBG6ItcOhJgHURHD3t0a0YZjnG5w7UNFPX/spVXBKUrwuSHYiXNtEwUnDJEvVkF1GOkqE7+5erl4t0HqqSb+eamzDpa0OAKIJ/fQte3ktCSRmmPn5DbFR+gtVLN0w5VG/RnflFQHjNYixV1ESCFIOr7rLshDxHl3uOZvxqEKokj9St5nhFUiICqKe0Rux/JHvB5g21WkzRySYUb8nzCd1cJkW1QVgxjCt5ktwXrztjkb9FZMx6gamJStTSTV6oenN0vwXJ+RlwSKcnq0g7sT6v6EU0X5+A7iSEYBht1f1RArW39UsUHn/KS0YwCbURk3QQT2oHf8b9D10mVrWnlT3WReSbLVKWtsfrDx40VhxXgkg2Ang0DIUbDlK1+fH5kQjc7dUm/3RQyzLgj/5fualc8FFr7KUJ3vHatt0zU4NL7XPeWpPdxmfCroyeVLk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGpyTy96NGVxbXF0bkNXczlIOG1pd0swS1ZSTDUwS0RwaWhMUE0wNHJMcFhy?=
 =?utf-8?B?TmVFQ0Y1aURPOGNOWVI4dkRzRkpJVkN1c3ExS0k2enBFN3VJRG50aElmVFhX?=
 =?utf-8?B?WUpUWm9ud09ITTlZVVk0WHZGUXBXSnkrZ3JDRzlUQUYzWlhkeWNBZUNBQnN3?=
 =?utf-8?B?L1VKb1hKdWw2TWE0Rm5INW9oUXJjUDFVTDBRdXViU0szdlVNTlVQeThCMmdG?=
 =?utf-8?B?Y2Z3ZHU4dFhSWEEwRjFSYTkzS1RKY1paZUFYZ1NzQ2toeWVLVXZxWFdjK1cw?=
 =?utf-8?B?NFRTL3F4dlNyUWhTRFFzNTFRcXVoQmVwYktsVWg5a2oxQitqVmdwdGlqbzBN?=
 =?utf-8?B?ZWp5cGhHV0xSUzhZWXRSMmNFa2lMbHJqU3JuSWlJcEpiZldNMGN0R0dhN1Yy?=
 =?utf-8?B?OG92bkY4Yktaa2s2dVpvOTN6WGgxSExTVEpvRk5HVHNRSXhCWUUvRWVTWGZq?=
 =?utf-8?B?eE5XTFVaWlhlQVBqWDhVNWhQTEZraThsaWQyTjlXSHBHMkk1RFZHVHFqSFN1?=
 =?utf-8?B?SzhOdmdOc202bnIvWkEraWtZRmJjUkd6MEZQVGFuYUFEWitqRnJSUisvMndW?=
 =?utf-8?B?Zk9TVHVidS9qN2poSnBtemdlUEJCUmpCd2hVSDQ2cnkwTXVlRXorWmhMTG5k?=
 =?utf-8?B?aXdOOEZFa3BPRm5hRmdsYjNhdUNJaWZmazBGYXdkV0FFdzJRZWs5K3RMRGNF?=
 =?utf-8?B?RWJ0UWxBZVArYXlwOG1RbXl0eldSNWJ1K0JJZmViZE1rcU1Qb0U5MExxZjlV?=
 =?utf-8?B?WDdZa1k0bDZzY1dTT2VQdzZtM3FsdXYwOGZ6ZHEyeElZVXpJOGVONnhqeDN6?=
 =?utf-8?B?TzViQXplOGMyYVdqODBpeHlEckVKVEliaDNRa1RJSGhkeG5SZURhby9zVnht?=
 =?utf-8?B?YUF1bW5RTC9HUitPZ3lWcm5ua0Ztczk1d1QwR0t3cmx0elBqZlFzRnFDb3I3?=
 =?utf-8?B?MisvZkJwc1RxL1lZM2JtOXd2NTFZbi9mT2hNUnpKU0ZkdTZkNDdCZnZpak16?=
 =?utf-8?B?d1dqMTV2cnFQbVRxME9qS2lvRVVOV0hlS2RsRG5LRml5MnBQYjlVN1pXU1kv?=
 =?utf-8?B?UGxOVng1UXJwVWo4TnBtMDAxTDJjTVkrQmtOU0ttM21NaGlLVkVuYnU4NXJs?=
 =?utf-8?B?Mk1wQ2h4SzVWc1ZVaXBtVXVmQk1sM2RDZlhva3lsbjZ5OFZEQnZ1RXVKM09I?=
 =?utf-8?B?bG4rVklGQ2ZGS3cxdi9YMkg2MlVBTjM5UFVyRFJtMXUxbnphOXRBRGR5M3hn?=
 =?utf-8?B?d0tHSW95aUJaRWpOTEhXUmVQQmdLcFVpdFZtaFh1Y2Z6M2hNb3BpKzJMakMv?=
 =?utf-8?B?UkZVL0M5SVpBRDlLZEk5a2hBTDJhdThVUmdmUFVjaGJhL3ZMMzhERVpxQWI2?=
 =?utf-8?B?OFhSNHdac21YL013d2VyNyt4ditwTzhSQkUveXNxVkhsNXBTOGZSSitKa2Iv?=
 =?utf-8?B?eVFsQTZiUVNCazA5ZHJHZHhaZko0ejFpaDhWdFNtc2ZtUVhhMWkvaTVub0dP?=
 =?utf-8?B?Y3kxNHkvdWJrL29qcHdDVndDbC84aS8vTHY3dmIzNjZnMUFCclNFYUx2Mzk4?=
 =?utf-8?B?RllSOXdEWmcxQnVpTGtSa0RTOWdEU2p5VVNianFOSVJxWkNFNHhFMDVzOXVM?=
 =?utf-8?B?V2toakRxZ3N1UHd2UUxuM0VrdXlNOGlITkNRWVdiVXVULzBXamNJb2E3Q2Vt?=
 =?utf-8?B?NjNtRTAvSFZvdEFiU0oxcWFvbHBLa25YMnJTUDJ1WjFUbXpYUWpuRHdFTXVD?=
 =?utf-8?B?dWJSRmM5YnBNSGwyWU9LdlBaN0tHUGQvNXdXVnk4aG9XWWlzUXc4c3ZTSzlE?=
 =?utf-8?B?U1ZYWjFrWENhTDA4R3NUbkpLb0FiL1M0WmV0Mk1EeUhSZHd3ZW1JWUowYzlG?=
 =?utf-8?B?ZitvdmN3YktkMkdVNGt1cEx1NCtTWi9Mc2c2Q2dRdlU0VGdZdWJmV0xwME9i?=
 =?utf-8?B?bFNCZ1I0enhWS041eHdHbFhWanBDaWx3N2VMZzZkN1pBUnBLM0dNSHozR09p?=
 =?utf-8?B?cTJFZWoxemc4SEdOZDlCTjZpeElmVE9ISmhDR21kMlM1c2NLYktqN00rVWhi?=
 =?utf-8?B?Ly8vMTV0djFnZzVMZ1hHTHJvdHJEM0FYRzlTOU0rdHd1TUZ5VTc4QnZtZkVx?=
 =?utf-8?B?MWlENDlnQkJsUE54ME1pQ3Y0WkpUZE8vQ3liZGxBU01oUmRBbXFvMGpQTGtj?=
 =?utf-8?B?Ymx3MWFRQjhRSURCMnQxank5OGYvWXJLQkFyQTdGQUlCSXBGalZQSWt5M3R0?=
 =?utf-8?B?bVFIbEhHbDZrcU9XRjJQNjh6MVBCLy9LZWFZVDJzbElKNEZWdjllUkh0K1dL?=
 =?utf-8?B?aGNzb3ZoY0xvb2tzV3VQSjdXeFY1U01mTFh3aFhiM1Z2QUtOb0tWTmtmZjFw?=
 =?utf-8?Q?kkw5YVBrxIwSChHZnB/KQWk4c4gyaXLNUKc/X5V97w9s0?=
X-MS-Exchange-AntiSpam-MessageData-1: LnFxb2FLxqQitQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 880306ee-8fff-4c40-8229-08de9a1ca4cc
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 11:54:54.9130 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R8zuKRRkLAaOcY811Bh6tdpmxsdY+rt9bGwCSxGlPSZWMMcxa0heKhQCD1pcL3y3Z9LV6i6oMXZrX0c3qwC2sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5636
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

`FwSecBiosBuilder` now only contains `falcon_ucode_offset` which just
gets passed directly into `FwSecBiosImage`. Remove `FwSecBiosBuilder`
and construct `FwSecBiosImage` directly, as a simplification.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 98 +++++++++++++++++-------------------------
 1 file changed, 39 insertions(+), 59 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index d71ff5de794f..5cc251c73800 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -233,8 +233,8 @@ impl Vbios {
     pub(crate) fn new(dev: &device::Device, bar0: &Bar0) -> Result<Vbios> {
         // Images to extract from iteration
         let mut pci_at_image: Option<PciAtBiosImage> = None;
-        let mut first_fwsec_image: Option<FwSecBiosBuilder> = None;
-        let mut second_fwsec_image: Option<FwSecBiosBuilder> = None;
+        let mut first_fwsec_image: Option<BiosImage> = None;
+        let mut second_fwsec_image: Option<BiosImage> = None;
 
         // Parse all VBIOS images in the ROM
         for image_result in VbiosIterator::new(dev, bar0)? {
@@ -254,14 +254,10 @@ pub(crate) fn new(dev: &device::Device, bar0: &Bar0) -> Result<Vbios> {
                     pci_at_image = Some(PciAtBiosImage::try_from(image)?);
                 }
                 Ok(BiosImageType::FwSec) => {
-                    let fwsec = FwSecBiosBuilder {
-                        base: image,
-                        falcon_ucode_offset: None,
-                    };
                     if first_fwsec_image.is_none() {
-                        first_fwsec_image = Some(fwsec);
+                        first_fwsec_image = Some(image);
                     } else {
-                        second_fwsec_image = Some(fwsec);
+                        second_fwsec_image = Some(image);
                     }
                 }
                 _ => {
@@ -271,15 +267,23 @@ pub(crate) fn new(dev: &device::Device, bar0: &Bar0) -> Result<Vbios> {
         }
 
         // Using all the images, setup the falcon data pointer in Fwsec.
-        if let (Some(mut second), Some(first), Some(pci_at)) =
+        if let (Some(second), Some(first), Some(pci_at)) =
             (second_fwsec_image, first_fwsec_image, pci_at_image)
         {
-            second
-                .setup_falcon_data(&pci_at, &first)
+            let fwsec_image = FwSecBiosImage::new(pci_at, first, second)
                 .inspect_err(|e| dev_err!(dev, "Falcon data setup failed: {:?}\n", e))?;
-            Ok(Vbios {
-                fwsec_image: second.build()?,
-            })
+
+            if cfg!(debug_assertions) {
+                // Print the desc header for debugging
+                let desc = fwsec_image.header()?;
+                dev_dbg!(
+                    fwsec_image.base.dev,
+                    "PmuLookupTableEntry desc: {:#?}\n",
+                    desc
+                );
+            }
+
+            Ok(Vbios { fwsec_image })
         } else {
             dev_err!(
                 dev,
@@ -621,18 +625,6 @@ struct NbsiBiosImage {
     // NBSI-specific fields can be added here in the future.
 }
 
-struct FwSecBiosBuilder {
-    base: BiosImage,
-    /// These are temporary fields that are used during the construction of the
-    /// [`FwSecBiosBuilder`].
-    ///
-    /// Once FwSecBiosBuilder is constructed, the `falcon_ucode_offset` will be copied into a new
-    /// [`FwSecBiosImage`].
-    ///
-    /// The offset of the Falcon ucode.
-    falcon_ucode_offset: Option<usize>,
-}
-
 /// The [`FwSecBiosImage`] structure contains the PMU table and the Falcon Ucode.
 ///
 /// The PMU table contains voltage/frequency tables as well as a pointer to the Falcon Ucode.
@@ -898,33 +890,34 @@ fn find_entry_by_type(&self, entry_type: u8) -> Result<PmuLookupTableEntry> {
     }
 }
 
-impl FwSecBiosBuilder {
-    fn setup_falcon_data(
-        &mut self,
-        pci_at_image: &PciAtBiosImage,
-        first_fwsec: &FwSecBiosBuilder,
-    ) -> Result {
+impl FwSecBiosImage {
+    /// Build the final `FwSecBiosImage` from the PCI-AT and FWSEC BIOS images
+    fn new(
+        pci_at_image: PciAtBiosImage,
+        first_fwsec: BiosImage,
+        second_fwsec: BiosImage,
+    ) -> Result<FwSecBiosImage> {
         let offset = pci_at_image.falcon_data_offset()?;
 
         // The offset is from the start of the first FwSec image, but it
         // may point into the second FwSec image. Treat the two FwSec images
         // as contiguous here and subtract the first image length when the
         // target lies in the second one.
-        let pmu_lookup_data = if offset < first_fwsec.base.data.len() {
-            first_fwsec.base.data.get(offset..)
+        let pmu_lookup_data = if offset < first_fwsec.data.len() {
+            first_fwsec.data.get(offset..)
         } else {
-            self.base.data.get(offset - first_fwsec.base.data.len()..)
+            second_fwsec.data.get(offset - first_fwsec.data.len()..)
         };
 
         let pmu_lookup_table = pmu_lookup_data
             .ok_or(EINVAL)
-            .and_then(|data| PmuLookupTable::new(&self.base.dev, data))?;
+            .and_then(|data| PmuLookupTable::new(&second_fwsec.dev, data))?;
 
         let entry = pmu_lookup_table
             .find_entry_by_type(FALCON_UCODE_ENTRY_APPID_FWSEC_PROD)
             .inspect_err(|e| {
                 dev_err!(
-                    self.base.dev,
+                    second_fwsec.dev,
                     "PmuLookupTableEntry not found, error: {:?}\n",
                     e
                 );
@@ -932,34 +925,21 @@ fn setup_falcon_data(
 
         let falcon_ucode_offset = usize::from_safe_cast(entry.data)
             .checked_sub(pci_at_image.base.data.len())
-            .and_then(|o| o.checked_sub(first_fwsec.base.data.len()))
+            .and_then(|o| o.checked_sub(first_fwsec.data.len()))
             .ok_or(EINVAL)
             .inspect_err(|_| {
-                dev_err!(self.base.dev, "Falcon Ucode offset not in second Fwsec.\n");
+                dev_err!(
+                    second_fwsec.dev,
+                    "Falcon Ucode offset not in second Fwsec.\n"
+                );
             })?;
 
-        self.falcon_ucode_offset = Some(falcon_ucode_offset);
-        Ok(())
+        Ok(FwSecBiosImage {
+            base: second_fwsec,
+            falcon_ucode_offset,
+        })
     }
 
-    /// Build the final FwSecBiosImage from this builder
-    fn build(self) -> Result<FwSecBiosImage> {
-        let ret = FwSecBiosImage {
-            base: self.base,
-            falcon_ucode_offset: self.falcon_ucode_offset.ok_or(EINVAL)?,
-        };
-
-        if cfg!(debug_assertions) {
-            // Print the desc header for debugging
-            let desc = ret.header()?;
-            dev_dbg!(ret.base.dev, "PmuLookupTableEntry desc: {:#?}\n", desc);
-        }
-
-        Ok(ret)
-    }
-}
-
-impl FwSecBiosImage {
     /// Get the FwSec header ([`FalconUCodeDesc`]).
     pub(crate) fn header(&self) -> Result<FalconUCodeDesc> {
         let data = self

-- 
2.53.0

