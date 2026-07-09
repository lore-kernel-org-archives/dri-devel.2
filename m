Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D29C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 06:57:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43B5710F3CB;
	Thu,  9 Jul 2026 06:57:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="okbO4HFI";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011065.outbound.protection.outlook.com [52.101.57.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A70B10F3CB
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 06:57:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bp3GyoNe8qmRwQ8K7zV2X7/EBVCui6sW79iNXq+FHFaPnc2IbDxOoW25qizxmtw/5l//lAtxQbsSWg/UknEzoS523ircJ1Vs/dZCfjVrJv5vEPP9HqLNNdnFMupnqgJ7tKejUvvUaObIGUqYWIgD7o3spWwt5eNkOHytCLL70spuywLcSr8RS8k7f3xNNynjeVuto/v2gSg/hbeCd5iX5sBoCs9FnlQ49jOxsY0lQRUcWgwWwI0WA7nWPQi/iKUE9n+LNwyeDueEEUTF2czc5uDIWN8qWmaEL6bM509rwIuLm9C/Z9o/YVXf36infpDNv8InWjS24TKXaj2QQNeKrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVYEa9vSIbRN3sNVpjCVM2oJsmIJf/nvS7/uvpDx0kk=;
 b=hm9F/SG5l18k4DldFEFyrFSdDBIozAdwF8VGXsLPZwpOVRCtZINC6GQHN2NWsYnH/2zhdcbgvcCJymSsO8W3j+2Fa37d4hCWP4ksNm4f8JZoxuiz+1j2pKByaNa2Y7eNK+6Hqn3AUwH0RlcXM0MR+ji1NfXM566jYcz+RhiOO0zg01yDT2Zib07Zi9+TUurjy3tw5O1iZtcHgps2koQpszVynhVL6UK5SSV2bXh75jn+OaeEC5UsadvJWY+J2YkhgOLC4PuBwPwMKEKu0vzZ1NzC7LxwVnTAGUMVXelkdAJXVkksuNFKQ85ht0QTbsKALBoGerMJdQe776iX94jtHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVYEa9vSIbRN3sNVpjCVM2oJsmIJf/nvS7/uvpDx0kk=;
 b=okbO4HFIuvcHWyiAOD5oOsszukl2TeDAgsBd1p48vlHDwftJpX3EWYIfHrl9WZ5LT5HA/7PHeT1CrmMlpPijjnVLLKtQC0FJCxQspZhWRJpV7cV2+T3YisIMtFo44faNCve6lMOMtoR+4EnTsm7Cyd7AYLD5fcDhAcNrr7g85XYdzUaCK++Vo1wu+BchP/X5EFcDsTpI0NmW5+3rT0wVa4BAa3oswuYsvb0IRJGgfd9zYsIW1L8nMGm0SJPPzWV6KEWtDD4mESkLq80cQ0Ze+hCsNRpmb+tLIKjPSQn3BkRyATUe7i6e17dKM8FsdzinrdnNoxWKN+fV1UrntsuPKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by LV8PR12MB9668.namprd12.prod.outlook.com (2603:10b6:408:295::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 06:57:15 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 06:57:15 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Thu, 09 Jul 2026 15:53:03 +0900
Subject: [PATCH v6 10/13] gpu: nova-core: avoid repeated calls to
 pci::Device::as_ref
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-nova-bootcontext-v6-10-520cbf8b9b50@nvidia.com>
References: <20260709-nova-bootcontext-v6-0-520cbf8b9b50@nvidia.com>
In-Reply-To: <20260709-nova-bootcontext-v6-0-520cbf8b9b50@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4PR01CA0087.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|LV8PR12MB9668:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c2eadbb-9cb8-4d4f-a521-08dedd874ee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|10070799003|1800799024|11063799006|56012099006|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: CXepRUw21NpUv0IIy3X8fdXvq8wVxyf6oySYZIAPIystx2Hpg2pYiPZzlaRxneimMn5DXLHghInmxxfNUP2LHyQQ8MlcA1hVXGYwxt9mL3bh1o7s3B15mL8ErO0LZ2tqUNqTL9K37oEBOvK2eq1kMME+eulEkknISd0/NrW8Xq14GMz4a51DHFMYiK/qwAFlSWxhqc7aKKJ6O2i4a0t44RYH79jel7Y/7zCj3YFkaeNiJ24y7OPFFY9uNjKpaNwJPZmfKepf/xHKdJDo/Jt3Vhd/pXaJaILjJ+RvP1yBcL5VUsiotCWpkrCf5J0QBBF0Lg1htlqNGNdWf+DI7Fy+1uoPIIdGmMHOsDLONcJ6eWX8jQnguV/XFg4aS3DZGoNn2T71kHNIZvl0Opu+uKIV5H+/QHFhAZzpOlQXB1IRFh3e9jQscu7Xfp+fi6LsVg+tK3X3YEgB/y1dAucQfECotiP2yfdMfA52QqVMs6h9lieqB5tN+iKP6B4OdTGBnUprDIFT3zynWdeVrQ9MHvPDWEkQQcM+kzu8iP4syGCJyLYRfjSaSG1UztaOqRyFHtAgFSU/UxPIC60tCYam/bXlvib/zONPXNZCF9mIcGXFc4XbU80uyGfrF75m6qtoZ2vhidwIUWmQcPxGfNE5QJ0siPXHGz00Qpmqy2GB5+flDxjBLHRW/OZUUip25OsgEqw1lzL29JRLNaca+akEwlQzbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(10070799003)(1800799024)(11063799006)(56012099006)(921020)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dm92Q1lTYmNKY0RkYVRwNXNTRysyVU5peHlLZW1xelNpdXBRZUJWdmJSYXg3?=
 =?utf-8?B?QWpzM24vcGNhdVIyejg1dHVoRTNoRHErV2hEQUlVZE1jWHNIWmNwOUhtaHhk?=
 =?utf-8?B?d3AxRTNHWUJkM3g3OEZqcFg4SnF6M3UvUE1oeFJUOXNSbzVOM0xKeFhqS0JS?=
 =?utf-8?B?YjN4Q2MwTkJFR0c5cU9pUHlpWGVSQ1VReVVHSVA0WHRVeExLNUpraU94SEFS?=
 =?utf-8?B?Y3FwcDB4Q2V1VkVTSjk3K0l4NU5rYXVtVXNpR2xGWGl1aG5XTDEzRk4yamho?=
 =?utf-8?B?OVFOK0s4SjVTSkRoeVZ1eHNZR0V2NVNWaTFvd015QWJBMVBpanFCWHFucS9j?=
 =?utf-8?B?akpSWmJVRkVSdVBjU1pzdG0xcFM3R0hEZXN2YTRVM1c0NVhTQktRbEJDRTZk?=
 =?utf-8?B?U2JrUGFpT3JBeFlOTXZGVXU4QjFMMGxmV1BXczI1RHNaRGNpR3JlT3JJa2Y3?=
 =?utf-8?B?cGxpRDdIcFpHQVR6bzVNZExWRHJ4bENRNTduNkhlZ0VseDlscTJhZUZOdE0y?=
 =?utf-8?B?S1BjeG0rb20wVWZraWorTlhsanZGNWdoMGN3bFZrcEszUjRKZzAzME8rS0FI?=
 =?utf-8?B?ajdVRStVNllQeWNoK0I2RE5IbXd5TzlmSVczUTVVU0RDeHYrV3h5VUdQUDJv?=
 =?utf-8?B?M09GdE5INW10NmFRTXBVRlF4ekpQTUNWMkNjcXhqZWF0WFpMRXR3SUYyQmZo?=
 =?utf-8?B?b2hHdm5LQ3kyMlI5cHRSU3FDb0pkTzdHTGR4OUliUmFyWHFjYXpyaXE3b2pl?=
 =?utf-8?B?UU1zTTU1Mm1FcUhTUGs2aTFBM2JxeTRmMXhYUFN3TUFHQTh3T3F2UmMvWXRX?=
 =?utf-8?B?TlpsODVmVW40QVpuWXhVc09Td1UzbXM0ZzlkUHFQVUx6MU4vV2w3ZU1Da1VJ?=
 =?utf-8?B?UjNMY1BvMm9VQ3RxRjFWY2NQZzNXRU9na0hwTkpBcytlVTV2SXM2Nng2Vjd1?=
 =?utf-8?B?bXh5dExsL040U3kyVFhoQW9KZGI5UW82OHdqeWY3WWR2Wnd0ejRhVlBVQTkx?=
 =?utf-8?B?ZzdCbXlRUnBUbWV0VzZqRFVIUGcrMUZWRGJ4bDk0ZE9NU0NkWUd4UkJmQVd3?=
 =?utf-8?B?cHJ3UTdpUVhKU0VQcTBlTnZ3K1luTU9sZ3lKdndvVGU5WFEyZjNqRVR0QlFY?=
 =?utf-8?B?V1JkMDlibGFRZW15ckJJVzhnREFIWWNGcDhmK3hsTmljUVQvUkVMMCtWN2VX?=
 =?utf-8?B?eDM2Tm41RHk4L2EvM2J0WXpWeWNrNnozODVKaVFkYlhXZ3dMMldQbk9zdUVQ?=
 =?utf-8?B?UWtiRDJ2UjBUbXhMZ2RaUFFYb0NQZjlxaFI4a2pIVnJBTW9SNk85eDhmSy9F?=
 =?utf-8?B?aWdkVzVnZTI5UU85OFFNSHJGVWd0ZSsrdENzZXlTOFFNQUREWVpCYkJRSmFB?=
 =?utf-8?B?V2dzQzJzbFd2ZGVVcWJVeUZWeWp2aWEra2FONEhJLzlyMis4cjN1d1RIeFp0?=
 =?utf-8?B?c0VnMnorRjNTb2VLTUNIeXlRNGNFQkEyMTJVWThNcFNWZHlYcFpXTmEzOG1M?=
 =?utf-8?B?djFaNlZHTGNJdUFWbWx4aWdnaUpodFhla0FEWUhpT01RR0pqTDI3QlBmbVhq?=
 =?utf-8?B?em5taERMM2tXZ21Jam1sTnVncmREN0hJUzUyNUtEb1l2MGlwTFhsa2JNemNZ?=
 =?utf-8?B?RzNNTENrTDlsWnpOZ1YrZmlQZHoyakVUWm5aTjYvb3dzaU1nUitEdSt0MzFO?=
 =?utf-8?B?SlJlSHU5R0kyeVFzVG5MRVdIWG53Nk5CNk55d2NVRUlWMVZzNkhxcU9takpJ?=
 =?utf-8?B?QjVPdi9BdjRRQkdFSENzTGtiYThTMHBuYnlMK00wR1Fud2pPM2xqdFpNd2wv?=
 =?utf-8?B?VEF2S3NzTldsSEp0cHV4ZHkxV2J0MTdvUmhtODZCNzlCWE1NWm5kVTRTbnpM?=
 =?utf-8?B?emN0YWFGNFlNdFEwOHptMUg0NS8zWC9LbHRjOTZQRUpQWW5JMEZvNCtRTzF3?=
 =?utf-8?B?VGJnTGJJYjdJcko3anhGSkREbTFKOWlmb1JhV3pBYk9jaUl2SnRqTEpMV2V6?=
 =?utf-8?B?MkVtdlM3TDdOVzhtUW56RFNtN0JRR1RxVXRla2NPZU9oc0h0NG92MmJTaDdt?=
 =?utf-8?B?SGJ3WEQvNGxLTDlCL3VsdTFqWEpMSWNwRUtHL3hYM0pnbDJhTWpBV0JmQjRR?=
 =?utf-8?B?NTl5ZHovUGpsVjFCS3hVWm0xQ0F2LzBhOUdZTXZoMFdqTnE2SzFrUU1jNC8r?=
 =?utf-8?B?bVNiMHpXczlYcTN3WjRRRE9pU2FQWWhoaUtBNXFHZFJjVjUwbkFEUzBETFYv?=
 =?utf-8?B?aExJanRod0JBNDNjdkVKaW1Hc2lTK1JCUm5DUi9IQ253dGdvWUw5aGFaQ3lB?=
 =?utf-8?B?NHRXMUdQb1pRTXdsSFVnSXBScWZmWldGTnJGUlNzbkJPNXBzNVNrS1hpbUw0?=
 =?utf-8?Q?gixm6o6c3y7mH+tdaXTLqQpR0mW6SWfjeubLRrjQSVYNv?=
X-MS-Exchange-AntiSpam-MessageData-1: haW/YdNccy6f3A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c2eadbb-9cb8-4d4f-a521-08dedd874ee1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 06:57:15.0649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZmYIeA4f8MlyKcwZneos7WUrmCtHdWGoqaAw29lCyYpc6pZ2O6a2Byuw2Teqq/6In+dXhR0JY3BhxpeGk51RVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9668
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

