Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7065DCDB471
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 07:12:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFAE310E4E9;
	Mon, 22 Jun 2026 07:12:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y6gR3dCA";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010059.outbound.protection.outlook.com [52.101.201.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7BEB10E4EA
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 07:12:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zM/m0fCKq+hmj18na4M3lWDlRfSBzStJhBnQGRe17H40Hm1KuCJs2/5fUopHHpDIDXDyTVrXrHIru6QoolvoL1DRFE9TkIVumNo8w7u9GBW32TgI/ZBxDAGwJd44Kn63OxmJcL+M+1GIdlR02Q8JJ+Zr6fZN06jDeE0FYziZNkgrfZ7xjCW/iNr1iEtaQS3etcZH0+FMNMssSPawjQ7Nj/8GtxIJcsfdHWlX4QUAGzRWcmuGch9Vfw1ZICIvuxwLL9GMrrpopo3R627zbYBTs/E1UhnLzSzu+0ClwNtib6HfUv+riaXAgIvz/t1YH3OiwrJ8nZRSfz3ZxXRsWsgAqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hY9HsiAx2MobF2+3eHJXOPHWQgp13EFjqlNCj7apT04=;
 b=JpZ8Dh++2p/Noq/L/S7qjV3oPDzWM1hIhdH1xB8ZPR+JYkVpZghnLFIVIi7raK8yNzKwXB9BPhhrhM+ClVinMYGZOXs/w7XkjYnKsLUgNMC/qsd1UgQ8mq3acSUpVjcCa0UX+LTOE3e76gbrfaUZvaZRImoEzvEMB07/AoU6d4xBAV93VEd2sfZSeE/ZvXPv3uU6KYx+uKSKQ3aPN8zPVqRB/91aOP4YfLW3CYmOY+EHA36m+pKPJAaVwErxoWSrz5IHkocv2xjaGP9yTevTgCqXGaggw088PzFp04+Crww5YRlGZdOaO4O4uVqjtrIk3aDaQvSbFo/O6gozkr1oig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hY9HsiAx2MobF2+3eHJXOPHWQgp13EFjqlNCj7apT04=;
 b=Y6gR3dCAo0UMCgrnqoqOp1vu2Lt29Pe0oG59AkJpWwfkZ/CCdcsJH12nhMMi4Rw6iheU+uNPuxpBW5fyrDLNZF4B6GFVSjpnhemr6ncCnTkSXY/fg9z79zVquLSL6icPDN1SZJP+LbBLJ6LOFWHVxLGkleSp3OEsOzLM+Kcwx7FBRy0kyyW37ERLKfldpBP7Qt4FAgbQSp8DfV5Z9aoQAwoG4ht72io0TzdpmSxgF1/ChqGoam/Hrm2rxzxv6foDAg0Ik0PtZ1/POgNRO3Fkda01ziqNe9dnLzBCik0CuIyoLqf4Bom0RFwy53oD3892qttyAw728BNuW5Wn1e6WbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by PH8PR12MB6700.namprd12.prod.outlook.com (2603:10b6:510:1cf::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 07:12:15 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 07:12:15 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 22 Jun 2026 16:10:33 +0900
Subject: [PATCH v2 11/13] gpu: nova-core: avoid repeated calls to
 pci::Device::as_ref
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-nova-bootcontext-v2-11-0ddeafc06f5d@nvidia.com>
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
X-ClientProxiedBy: TY6P286CA0041.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b7::18) To MN2PR12MB3997.namprd12.prod.outlook.com
 (2603:10b6:208:161::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|PH8PR12MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: 42418d15-9a81-4678-7a58-08ded02d96a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10070799003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: VTop8h5ETwgDXdMpmH3RwMKkDLtwREDocRuudadtgK76rE4Wy5kWE0pPFwIJrBAzh2kM/Nrt/+1qx26P6caYDoDYRpOajzSW24gzYb5EVjQfbGEOF4pDGHyCWAqBZj9N9vPyTsnEjEJZwoFs9RY8mXwRnpfainZcCr0LOlvbMdaWTVi4flz6UmbdRTBXD34TaXfGCEBRIo2pmSlQHFAriFNgC/feVOazLIFy3G/CJua3QzIIomfRGp+tgLoEOHVScrY8XPDRe74QT1uABlAyxeaWu4w4OjXZjoOid1vGFVAgK0yuoXZAtOWDZmJssHQV6njUh/4zxWhmZFPtB8PKzNiuTMjPEtVSmb43WJqQrdI1zMfzqq+37DZ42BptBs/I1ELGK/gcauHONmSxu06cZxs0wg9+Md0Hruwms1bUZqZyircC4QHGr0nZuf8gZuEHv7IrrRmIrD745NKnJOj4q332RMpsZXugHPV3oHrPXnfG1JxeifYkXUox/LjrG3nSonhAkli/qCmaMu2mpILE0FFSefo1QKRjAIrlNQdK6agEo/ph96BUEswf6kNb5akVW4L00UYdUMnBB84pQvohSrQ6UPawVzWA/dPwtOYaRfMgxXDwu5aiSLHGSgTqjUex5FVVVbVajKSOoE8AYomxsqGJF9KNa4ql1MZnicRvSKM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10070799003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWpIR05pTENxTitiQ3QrZnpZSWdJTjIyMU5melkyQVZzNWVlOGJiem90MUhs?=
 =?utf-8?B?dkN2M0EzdFJjWit3U0pjQlhZQkg1eTJuampnRTlQdFRKRG1JYVJCeFdibUZO?=
 =?utf-8?B?eVlUU1BsTjRKQUV2Mm4wdFJxZzBaN0pRQ3RQbFk1ZUNyQlNHZU9qSEw5UWsw?=
 =?utf-8?B?N0tObTQ2S3B4eUo3RkNFTjdSMGlzUGJwczdGdmdmL2Zad3lSNDUrTlJ0d2M5?=
 =?utf-8?B?V3h4T2RlU3BBUEJRcE9QaEsyKzZSb21DVzcvWTVOZU91NXJHeFMycUtlakx5?=
 =?utf-8?B?WGllMmlOOXNMOExNNlNHS1N1ZXJqWTY2cmJCV0lCK0hBdTlPSGJDQ2dNaWFC?=
 =?utf-8?B?WW9SY3hNNy92bFByc1FmViswR1FmZlpZekgyZjJPazhNNGovWG9Na2dudU82?=
 =?utf-8?B?N0hBMGVlQU5hRnYvZWlORjBZemYwQkFoaVZoUGsvVTFnMFFRMU50M2tBb0VO?=
 =?utf-8?B?T3RyTmdRMTU1VlB6YzRKbnVsY2RYcVN1S0FXNWVYbmdITDBjQzlEcDVFSy9u?=
 =?utf-8?B?Z1VaV292cHBpaHltTEJJUTU3UDZhQm54L2FScnRmdmFHbDBiRVhVWWNSRkJ2?=
 =?utf-8?B?cCtxR2tESk55emlyMVVDUGFEMWZBUDNNY3BuNVYxR3E2bEpRM05pbWMxZlNT?=
 =?utf-8?B?VmJtTlN3VUFkdTIrTDdzL3JvS0pFNGp1YmZlMzFHeHNxK01QRWRxK3hVZjI4?=
 =?utf-8?B?ZjdaSE9HV1Q0UXZULzB4Sm1WZS9QMDQ0YzNDcXY4MGU5Mk44TXJld3VzQzJn?=
 =?utf-8?B?b0FuN3F0UHpDT3YwejF4SEdIYmwxdXlDZGs4eVV6NjBFT05VVVZ3eENtQkhB?=
 =?utf-8?B?ekp1RjU2dUM3SjM5bXU3VU5mbVJCa0l1aytxTEJHSm9lY084NkxueXZpUkFp?=
 =?utf-8?B?cXdNZzFPMEdRMHErS0QvTnRQNGFDZFpUMlVlMWFjQ2lyZ3FFQ2NiTlNjazcw?=
 =?utf-8?B?R3IvdEUyMFUvR29RbnVWRStIL0VDTUtPRXkreXBIay9DaHVzQk9Yd2xOaHIr?=
 =?utf-8?B?Uit3cy9IdnRSaE84N0ZkTEl2Qjk1REwwYmR5aVE3VU9qQ3FYaGFjcmNXaWpw?=
 =?utf-8?B?NlBaUXF6ZDVBblY1bU1qUlNZdXJxNEo2Q1NtSEZLQUNUeTJjWjVFSVI5Y0dk?=
 =?utf-8?B?bVJDSEFaTGN5ZlVFNE1oR3dDTWZZeE1sbngwaWwxS3h0OVYwOS9renkxa2NR?=
 =?utf-8?B?RnZ1dDJTZ1h0MlhRaWxITmw0dWVBZUxNZ2IwdjA4dEdSZlgyRmFlZk5iL0JP?=
 =?utf-8?B?em41YUVjRkFXZDd6Q0RqeXJ0Y3NyQXdRSGovd3EyZFlBRzVUSlhMaTUzTXhX?=
 =?utf-8?B?TDNhdXJLVnVFb2tLQUxqNVV1aEYrSkEzUXA2Zm1RQlBINnoxOWtFRkNhcUhw?=
 =?utf-8?B?MmhnK2xHNXVqSnpNZGtkd29odEJBcjl1SDI2NmhINXpOSTZyclBzNXl0M2w2?=
 =?utf-8?B?UzNVekdYRUZZSXJ2enVodEwrZ2Zkdmtyak5HTnBNUng2YzU5dXdpS0V6Um5G?=
 =?utf-8?B?KzQya2dYM282WE1zcXV2MFhGQ0RTUE5YbWplTUVkQkk5cUhZMStYUGo3eEFp?=
 =?utf-8?B?NEpRS2VXNENGeHNXVFVmUG9PZ1N0bUk1QUhMbm1hVHYyQ1NPbFdvUTRJSkRs?=
 =?utf-8?B?aERBT1cwcnk2WVBjRmNpalBISldUVEw0UXhHSXFvUVdrczhGTGNiSitnVmI1?=
 =?utf-8?B?QkhHUUJDU0FyU3pFU0J2VU1SdzFVSzdCWFRwVDFCUFdDc1Rtd3Z1V3hKd3gz?=
 =?utf-8?B?UTI3cjlvbmhOcGt4L3VOYWJ1U0U0Z0taWThPYVJrTjRCNk9qSHZuTmtSemMr?=
 =?utf-8?B?VWNwZHdmeDdwSTJNMFpjaGFWSVduRmEyQXdPZ3c2OGhHUTBPMm1pZ1JkSEky?=
 =?utf-8?B?dnRZVmpLSnFQMDkxVjlNU0NoVUIwdlM5WVU0ZmUvaTA0VEE2d2dMdWR3TUl0?=
 =?utf-8?B?VjNNWjNIdTRQbTJoM0QzWUcvSS9uc1RXQzY3QVpYaVBmaktoY1EvRVo3LzVh?=
 =?utf-8?B?OTBVaEFvZ2x2MDlRcG93K0N2Z2NGamhTeVJBcmVSUHJRbXhFbTl4bG9mUGll?=
 =?utf-8?B?bVc0SWFqZzBZbWtjWFJnR2JnbVZoUVpjZHFqcGd1UmJQNDBxUFpuOWViclM1?=
 =?utf-8?B?dXV3RjJ2TkhYQmxjSUJKaGpOK1k0UEV0T2MxSnF2M3B6SXVOZHlKQlR2MmJC?=
 =?utf-8?B?eVhmNy9rY3dKeHFiak9lUHNOd0tUb2JDaFRlNFkvRFozVWJjWW1ZczcxczM0?=
 =?utf-8?B?RlpuZGk5N1E1L24vTGpINkJIY3huR1Y5b0gxZk9sZzNCbEhOdXR2ZjdVUWlO?=
 =?utf-8?B?M1g4a3ZRREpGaGNGWEREeWlXUVlqOC9RRWtjN1ZhM2JwNXp4U0sxdmcrN2Nj?=
 =?utf-8?Q?swmUNfRxHwvaml0PoZbUVIKeSNdJ7aFHN5XWzJtqqj8tR?=
X-MS-Exchange-AntiSpam-MessageData-1: 6FaHUOLCxsmGIg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42418d15-9a81-4678-7a58-08ded02d96a1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 07:12:15.3440 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVUpRuPKi9Gcj1xKM8dkVWsJj9OxYCq7XxB4sRghKXFBk2ffLIEo0E1GgTgOvaz/r3gIm3rvftXwg9FNDyFNSg==
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

Add a local `Device` reference created from the `pci::Device` in the
`Gpu` constructor to avoid repeatedly calling `as_ref`.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index d80c6dbb4cba..2e76e4bf79b2 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -316,9 +316,11 @@ pub(crate) fn new(
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
@@ -331,11 +333,11 @@ pub(crate) fn new(
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
@@ -345,12 +347,12 @@ pub(crate) fn new(
                 bar,
 
                 gsp_falcon: Falcon::new(
-                    pdev.as_ref(),
+                    dev,
                     spec.chipset,
                 )
                 .inspect(|falcon| falcon.clear_swgen0_intr(bar))?,
 
-                sec2_falcon: Falcon::new(pdev.as_ref(), spec.chipset)?,
+                sec2_falcon: Falcon::new(dev, spec.chipset)?,
 
                 gsp <- Gsp::new(pdev),
 
@@ -370,8 +372,8 @@ pub(crate) fn new(
                 // Obtain and display basic GPU information.
                 let info = gsp_resources.gsp.get_static_info(bar)?;
                 match info.gpu_name() {
-                    Ok(name) => dev_info!(pdev, "GPU name: {}\n", name),
-                    Err(e) => dev_warn!(pdev, "GPU name unavailable: {:?}\n", e),
+                    Ok(name) => dev_info!(dev, "GPU name: {}\n", name),
+                    Err(e) => dev_warn!(dev, "GPU name unavailable: {:?}\n", e),
                 }
 
                 info

-- 
2.54.0

