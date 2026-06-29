Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7D4C43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:32:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6741910E89F;
	Mon, 29 Jun 2026 12:32:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="fNj/kUZ+";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010014.outbound.protection.outlook.com
 [52.101.193.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B62F810E896
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 12:32:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cGKcC0o2Vtq8zEB46nC1hcDoWuMnqYE/vNW3uV013SQkYADrSRtyFDhBwgmme6YguWOlm4CEUauFwphCoo8lZvjjmnb6lljVGHoUictwJN590NcbXjLDb1Tz73CplqTk74XaJCUdoYlObi0/+dlLSyBsHoIC2W+RcXBg+1TVI/gJ69FXYlTjRELcorS45dOaNqfypi8Q8SmxQmPTx60j13bs+l3Zc6EyM5/BA5BBhZ3K4jLHz6GWS11tDqTA68v3o2T2vGMcZWxRjcSSVCYiZWSXO/ozIVP4/oTg52lo6bUM2zEQigi90BQuTwoMZXJECf4cGhJkuBzJ3Rd8oIIuqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FnWoEiMf7r42rvR2OLYbzwd8fmM8hCLtd4WN1/fbZA=;
 b=pAIr261nQMXsGNox49Sw4CkjQv80vFzUqal/CQhRk13yRqD+w//y/dOE5MRBabKYX0OBMlVSP2LSFMLk24xCAS1cE99C1TT6A6ieviPVB6qK+5lFsUY9e9BLwJso2f/cWtcnKRv7GUnRlXtWI1N71rUTViL46tfsSsGQNWkZf3r6z4LVHVPO/zTb1dQrXKUgydcA9nfPMC+2pLMNvNtc5MFnIvcYiuQSOiAMcQcnAiX9yFGWDBejYWYlp6Gtiw0MEhdrTn+FHRNGpUgruvjG9/w40ETTY2fRc/LLdX4T/AUYSFvXzOSqCFBnOFFzA2MfYEhU3LNF3mPBbwk9A3u1tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FnWoEiMf7r42rvR2OLYbzwd8fmM8hCLtd4WN1/fbZA=;
 b=fNj/kUZ+SJhlTjt3aO7JWB5QvaARKawvhPKadbro7AfhBDe/7TckYgtjrd/tkY3NqnJ4P8ubuZW0vG2XOXqUpZadarEhjpKCRCTFV/kdT+1vZGWwJe8hOej9Xrmmn212Wcx7/Y0S4V5of3U2sV6Vn52prBUV7t2+Yi9+7bEn4W0FPXYV7wigH3D9GL6sKMafvUKmsv4oMOli8Al1Qstn4IwPWmy0iLydLlNu6oUZzA+vHuwUywtrBxWDrvJ/RaxQKY38yNs/+9ZzvmjKVu8+Dzpwt3LTssNpdNpnooWThARLXblLVHBkSM6OzqLiHSASXArJe7w3wZgvCJF7vGah7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB8122.namprd12.prod.outlook.com (2603:10b6:510:2b7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Mon, 29 Jun
 2026 12:32:34 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 12:32:34 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 29 Jun 2026 21:31:53 +0900
Subject: [PATCH v3 10/12] gpu: nova-core: avoid repeated calls to
 pci::Device::as_ref
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-nova-bootcontext-v3-10-26cb29ee8dee@nvidia.com>
References: <20260629-nova-bootcontext-v3-0-26cb29ee8dee@nvidia.com>
In-Reply-To: <20260629-nova-bootcontext-v3-0-26cb29ee8dee@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYWP286CA0007.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: 37d48c62-d581-4907-0e3f-08ded5da7ef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|23010399003|366016|1800799024|22082099003|11063799006|56012099006|18002099003|921020;
X-Microsoft-Antispam-Message-Info: HSKeUQzkIC82HYSdm9UNUlURHXFp1Mmm9vivcHdW7RanzglD6Qmh/NMFHxNzBjJ3S4KQ1kwSAhd5/yBHuNXSbMj2DjPuIJEnhZFKsXrX9e8How+PPb9GNx4eU66ZObfIekZEXa5eGN0QVYCqu6XBRgbWpbC+cGCrh+gxdXdqYOHnLTL7QokafSn4Xv+Z3eiCSNeswCgIhayyZo4iJdWO9KnUkOsV+V6YXZE2bI/+/lwdH7zczcPnARA9cs9WZR2/kX/zpYk4yID7p8EltKhIyreLTFMALl9RCvODf6fXKA8qSY9nL1gMwqmUya4/2/79cMRrtUa4fp9gQuRCol22VeK2JkKdTlB9TYcEQo9iIK+R7eRGGMLu2M9K/0fiYK8sN/1J5PGvk8YwMN2xFfG7+Unks4JM4uB1NX5uE0WR9d7dck7sSrQtIoUoAYgdAeJPX4gXEK/EDat5D9l96XFHkGOdskMfRTvoiQ2Trj1GcnIP4iYQKXo8r2tkyrYHW9zW3TNXd7HIKpzJnLvMWooXPIta6aZsPi1HtFEmYJVg5dd7unzRsqqzJiUiT14y7DSBxNggmaP8sYWDUOQzDUh4pmGLCqP9TNFWbBH3CM3kzhHRyXl7a1nyp1COWrJzUAgx/hAvGOrXrHCR/nGOCnjSUsSpuNYdF+94gidr5DX1LE0dtWN1uFlIEXqEHnviOvDNenFmsEzfJqNJUBihLDQpvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(23010399003)(366016)(1800799024)(22082099003)(11063799006)(56012099006)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mi9nbldmaVhvUmpMd2V2YzBMMzNRS0Z1dlZiTkVBU0NvYzc0YVlFRTlWclR6?=
 =?utf-8?B?cUh4U1A1SVIvRnVTc1NuY2NvMnpzbkhGd1R4UmJqUzlyRFJ3RVNrNU5VdXJY?=
 =?utf-8?B?cDQ0U2I1ekVoOXd5V215RSswRFpVU0tKZ1dYWDkzcWRBQ0hsNXBrckZOeVdY?=
 =?utf-8?B?SnNrb3Q0R3ExeXlYc1pyTkNRd2VETGcxcitxVzlTejk0ait3STRub0pqUExC?=
 =?utf-8?B?OXprUFNBZ1ZlVzdOVWlyTXk2L3c3TzlYY3hMV0N5MmZESyt1UEVlK254NmpB?=
 =?utf-8?B?Z1hzV01rMTAvVWhXeGhONklWRnRUTG41M3ZtZkdBUnJzcDVJMEFaRWRGdXFE?=
 =?utf-8?B?cUdPYjA0RjZQR1ExbFFyR3M5UWxJTlhBNWZ4R0Q2TGVlWXR2RHhJeG5oUXJs?=
 =?utf-8?B?M1F0bVdERURmNWplZjUzMWNPSkdQUzRsVE0zNWdsL1BhSmxoTGxVOUtTVVhH?=
 =?utf-8?B?V2RXc2luNUFRSlMwWDlhRnNWTEVLY2Z1c2NQMFhRUVF0VUQzNFZpcGFqeGdT?=
 =?utf-8?B?QTRhYWFmbUlRUE8xVG15eW1iZU5sNDVwZVlhNUMvQk8ycVVHSXhqbXVPVVZa?=
 =?utf-8?B?OVdmMkFxblJSaHBWYVRJMEZ5dkg4N3BYVkJpQjk0d2dGaTVWcEJVWlZuY28v?=
 =?utf-8?B?OENqV2cyWURjVFJVMXZsUWp0QTBkYW5hV1dYUmRlcDNjZWdYMnE0OTZqNjNQ?=
 =?utf-8?B?dmFSdVpWUTFGeW1UR2RSQWQ1WGVmUXM0RWRaNEY2TUhFN094TUFsK0IxYVBm?=
 =?utf-8?B?cmhVQ0FPd0lLa056ODYxTU5mNGVDTDJwUUxWY294YWNpbGlvSnNzU0s4S0R5?=
 =?utf-8?B?aGJOOFR6Wk1NZXVjdjFibjBEazYyYllmSGJmcFJYeDRWUnVuWEMycHlFZFhW?=
 =?utf-8?B?RnI4SlpUMWNlY1BLSnpocVdaRnBwOXY3ZUh3ck52TzJmNXVpdmRuV3FIUmZk?=
 =?utf-8?B?TTlQWGdiWlV0LzY5MnBGTlBKenFhQVFDZ3lLSCsvOXQ4b2d5K2IxZlV1WTJR?=
 =?utf-8?B?eHc0bEZ5c0I0dEcxMS9GcU1zNjdSdVZtSXRKR09SN3F5a1JNNG9mTUZBWmU4?=
 =?utf-8?B?MldOK21oRnVjN09NYjJZdzhocmZVdGNvU08wYVZOdGRZQVhUVmhJaEpLQVln?=
 =?utf-8?B?WU1leEJWZXlSRnAwNHlIT1VEZVRiYUFYWXB6UUVUdXp0M3BGdmZLS0hnYk5C?=
 =?utf-8?B?UC9ra3dWWkE3SXUwYmpWckdRbTB2RjQ5UnB4NXhmOXBJUXdDYVZJK2hTVlBh?=
 =?utf-8?B?dDF1SUt5UHJXbDllL0lTWndGSkI5TXlnTzRrMzJpODdjNVpNYktWdVp0cW8v?=
 =?utf-8?B?cVFmWnNEMDJWQUxUWG9abG9TUDRrUmR0dXRCcW9aTjlPRHdTWjU4N0dBUCtx?=
 =?utf-8?B?d2xMSVJHcitqeUpnVC9WQjFWeFRqQXR3b1VYRWN3ZHY0LzBGQUVwMVFTellS?=
 =?utf-8?B?R0ViQ2FvTmhjMGovcG8vNkVuN0tJLzEwZ3JBQk56MC9sNnZPTzJVU1VVK2dP?=
 =?utf-8?B?RTZKZkN4c0VjcVZJb1ZKMFN6cXIydHBiMDdMZUhiTjhxb3pDalhsNG1aazZ0?=
 =?utf-8?B?dytaRmFPanZGWGxTZy9GalVLYnV1eDcvSlZNRE5EeGozRGFBMGxhNHdTVUc3?=
 =?utf-8?B?QmRhTDhhbzE4YnNTNkJ3MExVQXJ4R1pWMlhDZURzaDNrYXQ5MnJpM3BJcE9k?=
 =?utf-8?B?ZWdrd1hYWWlNTlB6L2FWQm91NG1XVW1ocUpFdWVTcE9RcFA3Z2VUcS9oQVdB?=
 =?utf-8?B?S1JZL2V2QmV5eGJlT0NQQWt0SmkyamcwN0ZMbXpmajJqRDYwTjhGd0R4VG9a?=
 =?utf-8?B?VGNUWTVxVDRzL1ozUG9hYWZ1K2J1c2gwbjJFQTEwQWN6YjFNV2Zoa3JvTVIv?=
 =?utf-8?B?Q0ZOQVRQeC9SVzRWTEhkbkxyM1hkNjFteStIUUhoYjZwdWI4ZkxzVzRLVDhS?=
 =?utf-8?B?U3ZQUGZ5d0pkQUZEMlp3bGZoT2IxUkhZdEUxU3lybFM4NlFhYnFZRVN5R3JL?=
 =?utf-8?B?azJhTzlOV1VtQjEveGtLN1MrUkdDOVh4ZWpYS2lSOVlhZlJCU09ZcUhzMmtF?=
 =?utf-8?B?KzMzNjBqL000VHdlRGN5bHJOb1AzSzJLRHV6YURGamU5RHNNK1JtdjlJZDJY?=
 =?utf-8?B?ZGpDVHV3eGdLellVS1p1QitURDdrWXZWbXRVZk9oZmNYeDAwdXJOR1psZHEv?=
 =?utf-8?B?T1pGZyt4aFhNdUhoaVNVMC9vMEVyamY5aHZHWGVJd1pHZXJnQzluQW5nSTZ0?=
 =?utf-8?B?RTdMS3Q2L1gzTkEweFpMcmVtVytDOVg1b2hQNHR6a3hsRHN5c1Z0OThDNnBQ?=
 =?utf-8?B?U25LeW9EbERCTmw5Zy9pSVAvSXhxT2JrZjZRZ0RwTU5pZjdjSWFKMXhiUU5K?=
 =?utf-8?Q?qor7f2TMaTB7E2jioAhg+P1kxxffpKL+dZIPoFRIGshu/?=
X-MS-Exchange-AntiSpam-MessageData-1: ien+Cu2f7cgilg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d48c62-d581-4907-0e3f-08ded5da7ef6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 12:32:34.4587 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IBV/MEHDBzYPY73D2tI0xhY2T8UWt8Aq/juseF15HHKDuUQMsstB+l4Fk762RcPI/rfwv9N/HxXxIX/Fiwm3/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8122
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
index b3f04239d938..cec21eadf0bf 100644
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
@@ -346,12 +348,12 @@ pub(crate) fn new(
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
 
@@ -371,8 +373,8 @@ pub(crate) fn new(
                 // Obtain and display basic GPU information.
                 let info = gsp_resources.gsp.get_static_info(bar)?;
                 match info.gpu_name() {
-                    Ok(name) => dev_info!(pdev, "GPU name: {}\n", name),
-                    Err(e) => dev_warn!(pdev, "GPU name unavailable: {:?}\n", e),
+                    Ok(name) => dev_info!(dev, "GPU name: {}\n", name),
+                    Err(e) => dev_warn!(dev, "GPU name unavailable: {:?}\n", e),
                 }
 
                 if !info.usable_fb_regions.is_empty() {

-- 
2.54.0

