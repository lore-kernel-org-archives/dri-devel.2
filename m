Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA22CD5BB1
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 13:58:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7414910E388;
	Mon, 25 May 2026 13:58:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="IHmQQgpe";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012020.outbound.protection.outlook.com
 [40.93.195.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B80110E388
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:58:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AsYpBVr9cXMxTAKP4p9B5LXJ0BYZRidYQbVI7XfwZFXEfnlU7DGhVelyChKl7o0SCh+jXOigVUY7VwfE8yb7r14NqtZDXYReWgM/cLXircnWbfxeZYiivjgLyxk8YRrPqxjzugRrnHNc8WH7ipYZuX4B1qKYd8E6my133wH9qN8p5he6lFF3DOwJ9GrmRRqTDbc7OUYAD+yzSxN+GB6+BqSHPUonDmsKTCg9nbOdYyIGjikfKyd7kPAaIImAl9m40ydzx4v8nfJEA9pxACLo3cXdL26TAiwU1X0BAimxz4sQT5WEQIHIgublZ0wBGbUo/9BDnguCSmvmA5Zixmz4Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LUMrVT3mmx8YalNsoeGbN0Hu7ceb3QaGI+JRWxbxGA=;
 b=Vn9QFZYK2WUTvil8p+OJndLz7WU5IgLeqia7WxffUZ+zuZ7hSnT19NVCH3hDPOhIDlTraDl5xgDsc3X2+Z4F+9iQkdHjlICJ+9lUAR0G14tTKRoQsm09IFRecjBbqIrBT9FAViJTpN2M3ypd6UcD+Moc75UGx8REpqRvcFeD5UNbIDSzV9hlfXmF02zKmnnsXhpxCLXBfSW1m4dHR0sptBt59N8nPE7gj/k5ChZhUyN5zHkQoUW11DjumLxghrjh7Qliuv5ZpUzldGHOcH3tLpiluez2cyq89uXR8oL36wFsGR2EyEUcc/64f7+nhO3do4VRCZVIBfWahgudyJmojA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LUMrVT3mmx8YalNsoeGbN0Hu7ceb3QaGI+JRWxbxGA=;
 b=IHmQQgpehcIiL+3JTrHSa9swWhX2Yy65Yg3YnWiNwDWHGSd3UOgQQJgzn1Hbm1N7bCfX17EtFoT/Ii0B/nm2gD00zWsyPC5a1S0igxXPCyGO1SWoQpzyRzSwHueDQFFmM2lYdOUMu8GkPOpiLKRh/TywuBAul/zemuPNuO1dMdh3QUBDeDW2xucHW+V8vuKzw4tNLRlpGaVwak/2Oya2yaFPDDbSaXRRuSQvoWoNNKGFFdvYJgC12v8bnwFfToMAZUd0EINndZcMOAjO59r9WKSIIwkV1F4y3+3VTD535U9ak01sCgcp+BEZ3XPVjJCEJqRbbswyOHvuz+J3aqaRsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 13:58:43 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 13:58:43 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 25 May 2026 22:57:32 +0900
Subject: [PATCH v5 14/22] gpu: nova-core: vbios: construct `FwSecBiosImage`
 directly from BIOS images
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-fix-vbios-v5-14-e5e455251537@nvidia.com>
References: <20260525-fix-vbios-v5-0-e5e455251537@nvidia.com>
In-Reply-To: <20260525-fix-vbios-v5-0-e5e455251537@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP301CA0010.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::13) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA1PR12MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: ab552876-b4fe-470f-c989-08deba65bb80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: whXZHJ+DxNylHtfxtkElgtqPKkR9W6lc0EoyJLTIxXs4JMwMpucRfG+Vf0uDlwHspNGfu+XdKM9gsxs4ageIl+DWVCdmuOH0YjWCqkRhbPh+bMjERZpVqiuGHo0OZymYO5331rVaKb76sDfoBiE3G20VNj4pZEqIIuPOAtvdFJb2Bh5g9usGtNpB5DwU61w5vJVcqAKW9/1lvWCQ5ue2N2EawRvrIwzSgiKCjfRNp13nv7qI/AfB8grLyDF9rE3Z6VcdSObFZwvGP+Llhzyg/EB81ZrrhBqb3xwrUGq+aZAcYq1aJHXZUz0zQjjHASoP4Z2Qx0hI2CxDiPTC0tYmgYXQVN/6HqL/R/TcER7ywl6V0jPcCrk6UJG86NiavDdx9ZT4qQZrI4tY9D/i4BGbJz13zqdXIwQwSKyJwknT052BULVMOfImFGsrPmvYYjreSse16lQi9wQEZ/9217cUNOxeqtCGJupUKdDRhZ47HIvrAXpWullFy1XQUibeHnLX/y6cQubRcJ9Eh4qurRqSbX2yLyutr0TR/ZZKzUE/7iXFK96GQnAEMErNvcR3EQvEcJGO4AT9AtIDV/OJll3pHKox0R3qvTwHBJOq8FnuHwDEiIuarziMwxvp/Q5TgOHQA+DCVJ7kacNboEw4U5sFq3atEn/F8/t3lcl/5/uynVqNsKQVY+Qsfh85rniu2D3I
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(18002099003)(56012099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1dEaWltQzNwVGxEcWptTUs4TmxxaWU0c1JobnZCRUJacXdRYncrU3BXbXA1?=
 =?utf-8?B?T1V5ak9JV3N3VXhtcmdJTGQ0ZDBXc293U2pNcWwzdXhnT2Z5dDlwS2xWZXBy?=
 =?utf-8?B?dE5KcStGSHJkTVBXZDR2a1liQ0RHRW1DWXNKR2pxTzg4TzBJQUZzK2Z6SUhN?=
 =?utf-8?B?TG5CMys0VGk3TFdLRFdVRjU2MXBwSHFNTXJja0ZJdTRrUGl4Q0JFTzZvMVNm?=
 =?utf-8?B?dUl2YnN1dUhtL3NUMGt4NVlMM0hBdGFQQ3o2QndaK1Yvc01jT0p6VzRrTlhI?=
 =?utf-8?B?eUJ5T1dHRm93c0FNamhPWjRVbHpXMGVsTVhML2szQ0RMZm1lVnpBM0hFZllw?=
 =?utf-8?B?TGFzcXJLeEhrT1pPNm12ZThQTFErS21veHNyaEZNaHFLenFJRmNXTHVCOEF3?=
 =?utf-8?B?ZG9oNGlLYWVVU0JxbmNMSWVZclBOMGpraTRaSWVNQkR2UGRGSkVMWWhKYjMx?=
 =?utf-8?B?TnVFcWU1cHJvT0NsYys3NFdHYU5HbjlkTUNVMUdYeFpNU053dWpxaWk2TU1V?=
 =?utf-8?B?NE1SdDBQTUw1VE1oZFFIZGFZcGhhQUJLcUtQWDJOand3K0pzY3UyU3I1RG1w?=
 =?utf-8?B?YVJSaEVhUU9UckV5UWVOYTNrZFRrdFJxemtwQjlpUkhIZzVYajR2V29Vcktw?=
 =?utf-8?B?OGw2WVkyWFgvblY1NFVHU1dNWExtejhZOVUyNC9RTWpVQWJtM0trUWpEMmdl?=
 =?utf-8?B?SDlrVHlESU9pYmdxSXZtZ25MeUtKMWdWVTl5Mk5DeHdXdWRud0xWWVVIY2Fi?=
 =?utf-8?B?YS93VHkzaGlyL0xIbEtWWlhza1JHb3RuMHM3RWhVS2dsVHFhUEVXY1dtM3Zk?=
 =?utf-8?B?Y3BoUXNIRnJzYytGbm5pN0x5N2FIbTVwM1d1UlRMdXJSWlRVQlFUWlhaL0Rt?=
 =?utf-8?B?ZzRHZTI0VDc3YWFGa3ZvUk84ZWtneWpSZEQzTkVqMVZzTklqZjZrdHg4QlpO?=
 =?utf-8?B?UHFLdXBudThyK0lHUDV4S1VpRDJtT0NiZHRwUkpENUg3eXFpcHNHVVlCRDRC?=
 =?utf-8?B?a3UrQUhKbDRZR2g1OUZLcWxzaURWR0c5SzA0L3FEa2o5RWNxb3V1bVFGWE5o?=
 =?utf-8?B?M0dGdkdXOFRxLzA0V1pRZ1FDR1ZoZWhISnJuS3BWV3Y1c0hWTmdQZkNjVnd4?=
 =?utf-8?B?aFVjVGpuUU9kekpGQlRZclFOQWlWNDh1NEZiQVhSSHJFWUljekpBdFpmUVN6?=
 =?utf-8?B?STdZR21Da2xpazdMS0o2andidWhnKzF4SWpCbkpzWjlYcUdKeFEvY0VzTlN6?=
 =?utf-8?B?cVV3QVMxeVZSVHE5aTFlbldYUHYvckNZSkgrOW9tVFh5U00xUVJYTWU5NlBr?=
 =?utf-8?B?amZ0R01qTDRvVk9FRFFHaFdqRUVXcm04VzFQdkxVSkJLUG5WWWNwMWVkM0Jv?=
 =?utf-8?B?aC80SEZ5bC9uQU9WTG9tOUkwZzFlaDNXcGRKbmo3bEhscUYzcUIrTXB2bG9p?=
 =?utf-8?B?VW45TjRBQVoveGdDVmFvU2VBb2FRbVB1VnkyVzR4cVJJUzE2QTVINmF3cEEv?=
 =?utf-8?B?eEpmcHplb0FnOUIwNjd5VDhTZTlLMVJwUEJ4SWYrWDduNTBHZWkwSnV5QkY2?=
 =?utf-8?B?MHVlcUpCK0Q4bWM3djVjZmY3R1RNNFdTSlFwUGd4ZExDZEdoQzhlc3ExNmc1?=
 =?utf-8?B?UTI4alQyVXRoVVoydWlPZzNCeGFzd1FVUmRKZmxOQmlWSmhDdmRaMmdKWDVK?=
 =?utf-8?B?NzhiY1F1RGtHZUhWKzQxMGM4Q1RscllxUitRWjMwQ2ZjZDR3Qk9Ib2MxZ0w1?=
 =?utf-8?B?WDkzNE1jUk9nd2dpSjY4QTJKdlY0R0pXTmRFZ3VMWnhwZlJqU2xRdzhsRnBw?=
 =?utf-8?B?L0JVc2dSNVc2UEVlb25oWXpsWjBYU2FRWmZQTXA5anlHOE9GR0VJTjErN0ls?=
 =?utf-8?B?RUFzL1hTWHBhb04ySFNOOTRHNEtRbVVrUzJEWVZOTndWSjFPd0tGbGFGbjVk?=
 =?utf-8?B?Wkp5dTNpSmtXMHZzSUJ6K0kzN0dPTkdpTkVDUzFuTGlUT1RZSVVpaHBTclB3?=
 =?utf-8?B?K0RoZnlTdTMwdlA1UzFFaDRkQnZwU2ZoMHJnT2FjdEtsbnY3N2RZRDJKbjNR?=
 =?utf-8?B?MmZOZDVUWGUxR0Z3T050VUlaQUpOQnUzSW92SWRqZFM4cE9zdmZGQmtZYnl3?=
 =?utf-8?B?Yk9LSHlKZFdEMEpMOHNPMVJYTGN2S0NDVkZlZndRTXBXaGNZNzFGaVYwOFlY?=
 =?utf-8?B?T0xMWUF2d0lqYUhIT0R2b2ZFMzFWc09LbXRHVjE2N2duNkRxbk1qMFdkZGNt?=
 =?utf-8?B?NDdERlUrT244ZWQxdkhqRUp1djZtUVNvc2kyVUVZRVArd3lYb0VRRUFPQUUr?=
 =?utf-8?B?c24xM0dFWG92S2pjMmRWZ0w5SUJjNm1vZzNFRWV5ZGRCZDFpbnVaSzc1MExD?=
 =?utf-8?Q?g/83QH4pgUlt0LOjfmRJK9DNGXPWpKEVKHclOXHMtTnQz?=
X-MS-Exchange-AntiSpam-MessageData-1: FxhLE0Ram82dew==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab552876-b4fe-470f-c989-08deba65bb80
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:58:43.4758 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wG23BmptbkRp/KBAfgSbQPrweyEoAjKKycxj78xaVwoUhch4RVmYAk+V4ubO933Ad+8hw1ywxblbtLwRJKgUxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6628
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

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 88 ++++++++++++++----------------------------
 1 file changed, 29 insertions(+), 59 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 1ffaf0ef56a7..9c5281e7a0d3 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -315,8 +315,8 @@ impl Vbios {
     pub(crate) fn new(dev: &device::Device, bar0: &Bar0) -> Result<Vbios> {
         // Images to extract from iteration
         let mut pci_at_image: Option<PciAtBiosImage> = None;
-        let mut first_fwsec_image: Option<FwSecBiosBuilder> = None;
-        let mut second_fwsec_image: Option<FwSecBiosBuilder> = None;
+        let mut first_fwsec_image: Option<BiosImage> = None;
+        let mut second_fwsec_image: Option<BiosImage> = None;
 
         // Parse all VBIOS images in the ROM
         for image_result in VbiosIterator::new(dev, bar0)? {
@@ -336,14 +336,10 @@ pub(crate) fn new(dev: &device::Device, bar0: &Bar0) -> Result<Vbios> {
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
@@ -353,15 +349,13 @@ pub(crate) fn new(dev: &device::Device, bar0: &Bar0) -> Result<Vbios> {
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
+            Ok(Vbios { fwsec_image })
         } else {
             dev_err!(
                 dev,
@@ -702,18 +696,6 @@ struct NbsiBiosImage {
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
@@ -954,32 +936,33 @@ fn find_entry_by_type(&self, entry_type: u8) -> Result<&PmuLookupTableEntry> {
     }
 }
 
-impl FwSecBiosBuilder {
-    fn setup_falcon_data(
-        &mut self,
-        pci_at_image: &PciAtBiosImage,
-        first_fwsec: &FwSecBiosBuilder,
-    ) -> Result {
+impl FwSecBiosImage {
+    /// Build the final `FwSecBiosImage` from the PCI-AT and FWSEC BIOS images.
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
         }
         .ok_or(EINVAL)?;
 
-        let pmu_lookup_table = PmuLookupTable::new(&self.base.dev, pmu_lookup_data)?;
+        let pmu_lookup_table = PmuLookupTable::new(&second_fwsec.dev, pmu_lookup_data)?;
 
         let entry = pmu_lookup_table
             .find_entry_by_type(FALCON_UCODE_ENTRY_APPID_FWSEC_PROD)
             .inspect_err(|e| {
                 dev_err!(
-                    self.base.dev,
+                    second_fwsec.dev,
                     "PmuLookupTableEntry not found, error: {:?}\n",
                     e
                 );
@@ -987,34 +970,21 @@ fn setup_falcon_data(
 
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
2.54.0

