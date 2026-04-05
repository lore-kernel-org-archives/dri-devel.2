Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63035E64001
	for <dri-devel@archiver.kernel.org>; Sun,  5 Apr 2026 02:23:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E0FF10E03F;
	Sun,  5 Apr 2026 02:23:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="c2qvvZzP";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012013.outbound.protection.outlook.com [52.101.43.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5970510E03F
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Apr 2026 02:23:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WBbVPbIhflwcBZ1SZA98v3YL8Rp5dAKoxQHHkgvdXQLRIfo9Qu1mfyC9Dp4Vtr2X1DlBg1eGPUoY2m4zg2Ivb8WpKkGHl9jodTu9MTby9bqvNDP5bzlwAeH4BcNjXBhmEa8alBtgrDvFyCURx4JxVgyeStmaOAhI+b0sSAK0pLAGW2hjEkpapaZ+ZdSKvdsq1FwLwsPeHZJ3liY6uesAsJOx4ddJoKA/xqcXG6uBZVyxl9BZAmSUnzeD0azXh3BSFk1GMyfswCL8h4wJ+hOzHLLRPZXVDh3VVGlmEYZ9YIo61Rwf4yccruFM1O7wQyKKRK/rXZ2iOzXxlBxblPQ0Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3oEXv5NaHIHHtly1gMY+3V5JZj80F1AbbaKPMqIuBDo=;
 b=h67d0bbk5ICW886JvuNIa8Ufrn964ySEy0sGcR6gFQCLowV3TqybgZnAKbuKOTG9rFicoaKrusNupzbrySQPGN43LxSrZwfhfSTB/rb3W1zExF5yA5ng8DdtfefdXDCuO/P46hzvXa+LUkzeitD7pU6Rapo3/nX1Igw3Hzgodkl7mnmU8ThvAvMppO3x5Tbsi8xG9iwCGxfeN2yY+5uhsmHkY2I3rDajH6HU/dLyKDIxwuY/YtfKIGXk9F2UgJQG8gslqW0goZWBLVgRG5xVlZzcHbrastO4SEpxAMEqQd+zpAacK0Yfgr5EwG/Oqn1KZHO4YAzZy45JUkcN3Dl6iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oEXv5NaHIHHtly1gMY+3V5JZj80F1AbbaKPMqIuBDo=;
 b=c2qvvZzPTbnDL4TXLQxWZoYG70Kxlv0EV7tK01jcGU+nmePSFOM3WGe3qZnYgcbDVrgXrLaqVBp1pppZRuN0v4MmqEibyY5Om98QWF0/GcJemChtSiyUpmlt8/DnyA15nrt49m1rz+t2LcwZXE2Z74v5ti2pxQMiGk3YM/Yxsdb/AJFLO3KirIBvUACL9Q6kJVpviwTrtU46GTiROp0PFcxjj5j2XCNkFf54aRWSrzE+FwOz2hmFrbUJ5acMrPLXux28x1EQiTxkuJ0Nf/yC9NSSObeN+Hq7UqaXRJolxQCgC4pARDs2inKdWz2Cn5n7fGzzN3fYgqqdeVMOhype9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CY8PR12MB8268.namprd12.prod.outlook.com (2603:10b6:930:6c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Sun, 5 Apr
 2026 02:23:03 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9769.018; Sun, 5 Apr 2026
 02:23:03 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Sun, 05 Apr 2026 11:22:54 +0900
Subject: [PATCH v2] gpu: nova-core: falcon: pad firmware DMA object size to
 required block alignment
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260405-falcon-dma-roundup-v2-1-4af5b2ff9c16@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NwQ6CMBBEf4Xs2ZqFVARP/IfhULpF1khLWmg0h
 H+34N3M6SUz81YIxrMJcMtW8CZyYGcTFKcM9KDswwimxFBgUaJEKXr10s4KGpXwbrG0TAIN0bW
 Uqq4kQhpO3vT8Pk7v7Y/D0j2NnvenvTFwmJ3/HNaY772/gpiLlP5SUoVVh3Xe2MjE6qzdCO22b
 V9Vo6UBxwAAAA==
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
X-ClientProxiedBy: TYCP301CA0074.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CY8PR12MB8268:EE_
X-MS-Office365-Filtering-Correlation-Id: d4e60e40-84af-4c7d-575e-08de92ba43bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: xloAxF75pY30fNLUNQoI/o3mdUdYMgd4ZpUOrLKbfTCUa+G098x8GTehZ1/PjG7yocCokWDXgJbStLEffpiZisPraWOXzwj77oChEWsGNzX/2wKGId2g9tan0ZIHMbIxl209Fl6VXt+yShgDkAsKOX5SZajJqhlio41Rs89lcAwnsZ1cnwrPDONKJB0+GimrJjIb3c7Xz0m0P7TabCpw4kNguOjlXXVP0M3naxHCwQiMRB1pQJ4f88wFXflQ2XeD+I0eAqhQmZxdrhqOq8Yo1y2yTxYkR/FhrMCuIYe6pKzKhlBSSoZin5ZykKf2IEqHoD5qdA4tF+IEd8yJhKPrcOKvq2+zyLb0Hy7jiZYugjWddqL8SJy4I+nb0lzgg6PsVWa+0D92HrP7x36crghpXrvgktoE0ddqh/ZGovznv00JS4Yh+M6hTpmphggKwKy1L3RtPk9HDMqiibQ9EyExIu/3iiFgD2GMfH+LyU0QToq1wNHy/5YTe6Kaxdyo4iM20jYv3NKpOMpdGqcoYzAjjDZYWyTykU8OVfZxEGgUIfiPHOorzU1FTOZxbL3vyUvtxpPoqGNKbZfRWw8dfxvgtNMe5I+AkM5jPAb6vdzkeCfi6BfehkyXAxh0bx8czTQvq1bf6sXvO0RVnvAru7pXSiaXqfSaOkjY4s3ub2G8hMvKeclmlOFDtkzaf2mZkkC6fc2hOa73sKef208aieCmsh34cbn74e05As+Gdk99D/E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHlHYlJNb29DaHVQb3hXbzBKTjJ0RmF1VUFLWTE3U2J5cXRNdVFPRDVwM09O?=
 =?utf-8?B?L1FTRU5BM0xwZ3FmREM1YkVRckk3V3dMdTZJMkdmVGJPWERaQ1RhNjIzNHJu?=
 =?utf-8?B?bnVjTmpFbzEweWNJd1lVRmtBdmhiTzdZQ0k2K1hPUW9HZVZ4RVhBQ3lCeW14?=
 =?utf-8?B?RHkvYWwyc0ptdkxqblJWb2syWlBkWmp0N1RHdmtTd2VNZnpnSGJ5TGxjd2tG?=
 =?utf-8?B?TXlwUTF5QkQ0dC9MSjJDbnZTV3ZVa2JMeEVLMGM2dkthWk94T2FCR2tPOWhq?=
 =?utf-8?B?aDZ5NkxkdmZhcFk1VnhiQmZXNXZRNDM4TGJrOWx1VUdLelhxNlhHNFJlR1po?=
 =?utf-8?B?Qks2M3g1VVdXRjRWSEZwTjlkRUVIbTdMZVpIMHBWMFBSanUwcVpjeUZSSkFI?=
 =?utf-8?B?TGVITkN6N1E2QTZrOXQrazBiZ2llY2ZwblVrYnJMSzM3SURhM3NnZUFGNmZT?=
 =?utf-8?B?bWMrZzNHNFVvTFlMN1dlWTVGWXFad0F6bWVkQ1A4aUJ0VWNzaEtpS1pzL3gy?=
 =?utf-8?B?WE82Z1JiSmZlS1E3L2lkV3VpMXVPWFhNSEM0S1NCQUw2T29ZUDJ6SlB1MStm?=
 =?utf-8?B?M1cwOU5ZdnpvNVN1ZmlBZVhPNlVlRU4ycTR6ZUFVakw2cXRnZERTQTRlUzZj?=
 =?utf-8?B?U0pEeDBVWkV1R3BMWDMyM2ZJMkxVSHA3bXFtMmR0SW1PUlh5ekNjb2RuaWZz?=
 =?utf-8?B?ZmdVQkljL1Q2bW5udktZNmkvV3FxMkdkaUNacHFqUjhpSVBueHJIZ0NOZXNB?=
 =?utf-8?B?clN3VEw5VlFXa3NFSHJGM2lNL0xUK3FzSS9YWEY0dS9LSEZBQnExdkltdTU4?=
 =?utf-8?B?U0R6Qk5iZTFnYjROZENGdnZwR1RvRWd5clRuTjNYYzROcTFQU2JwYWpyNFNa?=
 =?utf-8?B?RVA3cllxL3FoRlU0RE11S3EreHpmK0xkcTlYakZpVHc1TysvM1BEUTVPVUxw?=
 =?utf-8?B?emJ6QWhYZk14L080QlpKcUNlcXRIZWZ2UFZ2Qm01YUZ3K21lZ2cwQ09ROFdz?=
 =?utf-8?B?dzVYNyt1S1lYeWk5Vk1vZUVJNGVZMFZWZ0ZYMkY4R3VRTzhnNnpFcUtCOXhB?=
 =?utf-8?B?YlpSNWY4eW5vRE5JL0doSGs4UTRudmV3SjlkU3RmdWg3SG5LTUVmNmxTcDlO?=
 =?utf-8?B?YXhUdlp0Qm0rV0dyejNZWGtVSHc0cG9OaGhrY21xNXp0Z2h6ZHYvMk13U3dv?=
 =?utf-8?B?bzFSZ21vL0lRL21yZlBiTFlwRE9TbHZ6QkJOa0hNRS94aVhIblhGOGpaNHJU?=
 =?utf-8?B?U0ZyaW14QW00Z0toNlBPZzhFanJzQ00wK2dTRFN0S1BDZGVuRmVNVUk0cTVs?=
 =?utf-8?B?RlVJTE5NYkpYQXV6NjA1ZHV0emdtbEZab1ZwNFZISEdjdnFEeTJDUDZCY1Nm?=
 =?utf-8?B?WEZ1UmJLQXJERTJ3NlZBV3IrbS9BR1h3azJwbUMvLzNCQTBza2I2RVduOStp?=
 =?utf-8?B?SVNvbEx5b2hUcE85bk8zMFc5SURpbFRxSTdlTWNEZE9SSjJqcEVWRk9wUEpL?=
 =?utf-8?B?MjIvYjBBZWYzTDNEUzJRUEVhZXZHdXJMOFJqMTJCcGVKL1YyQ2VmbEx6REpS?=
 =?utf-8?B?dzFCdWNBU1Nva0V2Q1Qvd1ZEVjFzcmJSTU1henpXcmpCYXMrRWpFOVBKSm9B?=
 =?utf-8?B?QmNXMVRLSWg4eFZPUXNlZDZHL0JBU2hHLyt0bCtERk9aUjFtejRSQ21RVXdM?=
 =?utf-8?B?LzRraStzVitrbDVvbERJMXRpcEtYN1JhZnZKc21lNlNjMVFNZmxrMXdQTGs2?=
 =?utf-8?B?SkdVQU5oTlIrS0ptVzAwK0R3OUpqZHcyNUlUeC9wMzFZb2dsMXRrRkoweU1Z?=
 =?utf-8?B?U0ZpaEZvR3dtWVFhWHRKanlpVSswYkN1UlpaY3o2cndmMlQyREFUU1dma1Rp?=
 =?utf-8?B?K09yaTV4ZlNhMFNIa1Mrb0tINkJPdy96ZlZETC9sSUlBMDZ2ZXdNQTRVR1Fu?=
 =?utf-8?B?QXNVRSs0eWF6cXJ0K3crSGVHa3BWSzlTalRRTENVemNmejY0aUY4YlZPSTls?=
 =?utf-8?B?Q3BoYmNiYlF6YWh4U1l5aFNLa1J4bjVYWHN1VFF6MXgwRVNyckxsZVZmU0Ft?=
 =?utf-8?B?QkloNDNGUy81Y2N2bnlRdHp1NGg1NXV0WFord0c4RjN0em5QZ1FrV1RWRWNq?=
 =?utf-8?B?MXNBZWdmVnBwQ2NnaGJaT05CVklES1lMbU93bTRtQXVVVGFrWVYvRWFJNThk?=
 =?utf-8?B?YmhvZXNSS1VXNEhMVE84VFIzSlI3WC9FcTYvZ3ZpVXFzT2owV3Y3TnZSbVE5?=
 =?utf-8?B?VTdVazNEeVVTb0hrdCs0eHVLdUpCcXR3ZGxwdWJrVGM2NXpKVEYraEI3bVRo?=
 =?utf-8?B?MEdHN0oyME1RSU1LcDFaT2F0MWMzeEV5UFU2MHIrQTBUaW9zUFcrMWlWVk9r?=
 =?utf-8?Q?lkln4HREoySGEzWjrl8ba9lUEizlVQhAekOsqx/lebHJS?=
X-MS-Exchange-AntiSpam-MessageData-1: OlhRNpWbxNLjyw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e60e40-84af-4c7d-575e-08de92ba43bf
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2026 02:23:03.4548 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zwfnsj6JmdciSB+FbP1/OcpM4d72cj+J4bRHusbvuOTOlSayq1jLybIWfQBb77qDWZ9cMeAw/yjC9YCcgccZQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8268
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

This switch had a side-effect: `DmaObject` always aligned the requested
size to `PAGE_SIZE`, and also reported that adjusted size when queried.
`Coherent`, on the other hand, does page-align allocation sizes but only
allows CPU access on the exact size provided by the caller.

This change runs into a limitation of falcon DMA copies, namely that DMA
accesses are done on blocks of exactly 256 bytes. If the provided data
does not have a length that is a multiple of 256, `dma_wr` returns
an error.

It was expected that all firmwares would present the proper adjusted
size, but this is not the case at least on my GA107:

    NovaCore 0000:08:00.0: DMA transfer goes beyond range of DMA object
    NovaCore 0000:08:00.0: Failed to load FWSEC firmware: EINVAL
    NovaCore 0000:08:00.0: probe with driver NovaCore failed with error -22

Fix this by padding the `Coherent`'s size to `MEM_BLOCK_ALIGNMENT` (i.e.
256) when allocating it and filling it with zeroes, before copying the
firmware on top of it.

Fixes: a88831502c8f ("gpu: nova-core: falcon: use dma::Coherent")
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Changes in v2:
- Replace incorrect use of "alignment" with "padding" (thanks John!).
- Use more concise range syntax (thanks Gary!).
- Collect tags.
- Link to v1: https://patch.msgid.link/20260404-falcon-dma-roundup-v1-1-1f56d808b091@nvidia.com
---
 drivers/gpu/nova-core/falcon.rs | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index e0315fda576b..33927af4134c 100644
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
+            // DMA copies are done in chunks of `MEM_BLOCK_ALIGNMENT`, so pad the length
+            // accordingly and fill with `0`.
+            let mut dma_obj = CoherentBox::zeroed_slice(
+                dev,
+                fw_slice.len().next_multiple_of(MEM_BLOCK_ALIGNMENT),
+                GFP_KERNEL,
+            )?;
+
+            // PANIC: `dma_obj` has been created with a length equal to or larger than
+            // `fw_slice.len()`, so the range `..fw_slice.len()` is valid.
+            dma_obj[..fw_slice.len()].copy_from_slice(fw_slice);
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

