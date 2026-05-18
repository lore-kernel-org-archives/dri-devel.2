Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02F3CD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 18:11:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31A4D10E997;
	Mon, 18 May 2026 18:11:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="e2nRzR/a";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010068.outbound.protection.outlook.com [52.101.61.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9984810E945
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 18:11:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kxVAaRqOWq4OV35lccP/XaAJuAhdt6sXG22r1UeJMPs5Qbf39KU+tDjoOIfxNptow+HWhVVuQcQJYjwWmBFyqkaB8D4TziA7U23JkpH0AuY8vUdVbh2Foy+E2T97odFkjlGqi8K3cGKEHq1unuWy3TugxGd6SLIfNNflFQKXc9j3D3qM6YMBed8JoWEGpwU3jCnVWSa0yGd5zZ7YwYjjLNraENycxKMbQ1VfhQqJ09i3hosoEm9z3DiPqVP4dHhGpogsAXcHsort/gGPSfHhoGN60WJKet/NrNjfFsfjF0DM5p3P7U9zPkSFI281JInbk0XgIR85gLJaI90rDcjoaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bty+alcoW3H0/ivEC/+c7u8BK6422zaczNk+Z9FwBm8=;
 b=YIilJclTTFAzfKH1eBowx7PqgArhn3KYo4HJuKhZ6tTcQwcK9geKQUdeLwpqFKx9gUW9JWxCrXBE38gg5G2kM1X10+mTKQt0SkC9xj6n18FKfrv1NE2DdzGDEq086zR22gFsdBF1lBgzuS0ZonQ3GpYY5zbcTGQS/VxuCERjquaz8Gy/Wa/kQZL2SmJ0BJyALqH/lqquWtJw3c6w5T5Iwe/H+pdXnEtMGypZ4MbSn012IJlfq0FK6vPD85Rkq2QAnet6c4fwa/DoPmMB2rUPiCSbx1/qB6lhTlqAZ6oqsLscdyX3GU2qXAZ3FG2BV+t8P0bLvFdb7xZo0uXPaea17w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bty+alcoW3H0/ivEC/+c7u8BK6422zaczNk+Z9FwBm8=;
 b=e2nRzR/accID410vjMLeQKYSEXykRD9QqWQ7WnLaczLy2gasrslovjuXVHCjyzT27Nm/pDpCEVH+GULL83qYn1MkvMSeYs1KDghak4UlWw64gWwWySqDZVscOqo/ONIBq8QS8NoCW9nxoAGUm7bkWpAqWpZ+8jaM+gGCIrQBd23JCJKTEbttuwHC+9hER/TRbW7RDTSfYxBwmuKwOmD/oUbw2/JA+SGf+rDTp5E7KrLRTo9fVnMFzuQf0za4lf952xT+2pjUeQ+/7kvkmS7f/J+LFQ+Ubgsl8IIAYzizA339JJ+dFj8D3Ogi6H6zn97XvhVIGwymQ/bUwU7iitsPoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 BY5PR12MB4276.namprd12.prod.outlook.com (2603:10b6:a03:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 18:11:33 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0025.012; Mon, 18 May 2026
 18:11:33 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 nova-gpu@lists.linux.dev, Nikola Djukic <ndjukic@nvidia.com>,
 David Airlie <airlied@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, Edwin Peer <epeer@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Andrea Righi <arighi@nvidia.com>,
 Andy Ritger <aritger@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 Balbir Singh <balbirs@nvidia.com>, Philipp Stanner <phasta@kernel.org>,
 alexeyi@nvidia.com, Eliot Courtney <ecourtney@nvidia.com>,
 joel@joelfernandes.org, linux-doc@vger.kernel.org,
 Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH v1 02/16] gpu: nova-core: mm: Add buddy allocator and TLB to
 GpuMm
Date: Mon, 18 May 2026 14:11:11 -0400
Message-Id: <20260518181126.2493572-3-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518181126.2493572-1-joelagnelf@nvidia.com>
References: <20260518181126.2493572-1-joelagnelf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P221CA0029.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::20) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|BY5PR12MB4276:EE_
X-MS-Office365-Filtering-Correlation-Id: 88999ec3-a8fe-4f57-c57c-08deb508e4cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|22082099003|18002099003|56012099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info: tQRPTI40zqAHcZP14G8A2oy6pBAESjHwSnAXGk+NhFkPHw8dTpKlRe2oGE9dtXms20S2mOsSGHQRYmgUD3B689dg3VYU9bMmU+W1JWhghFfs20yYZc0sf7njeG2ahd4YqwcHdW6vjyT7Sz36585TKZiE7DB7wwMgAE5gbGUNMJjICmLA98xBA3Zl04YknnemsX9ppwdwOUde7ci3KVSzuSrd8urW+O/X3mj9qToe3mm6+PE/KJQD2j2bRG7I8jkX6YqDnkztCsyB163q5o/OkUeYFZl4xtC3sxKRshYYqt9yJaNWw4uCVh74EW3hxXbOXEiJYhZe5gVvrN1uOpxX8KW8iHjE1vU/Own+Lt94h/LK0lbeCm0n8asZtUAf8wgyJxTxdYDsDMEk0baXMlfasQSxl07Ij/HmOXKrmKZGuGHKhlBmZGJm/r10xKoE/kKAN6DwL+PpAJGZkIQCyDp+35+DxKdsFYzXl2KCIKX4bVWftddbssSrkiL+OK+g8f1Jtf+/fvjhRuM+RvtpEF/8CvgxixueG1XSl+XIBrfzI1wahdSyC6sQxQOIqzw6AswABeBZM89IPYFBaSEVoydx2daaZZmDnpwIM/oKECCBY8RrP1fi1OtxEdW9VZtG4LN0CUIrjwO52FydDXVtDnKvBh9DU65ouYL8i7vao+wTW0CNEE/mWUt1nYru28A/CSbc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(3023799003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1ZkdWRMSlNQN2RLN0MwcXBwMWxhQ0libFJhNkpRMUp0Tk9oUk90MGQ4amUr?=
 =?utf-8?B?c1lSZzJ3OTJhdXYvbGtJT2habXJsemphVG1pU1VXbmxxdkxlMVVGdFU5RVhz?=
 =?utf-8?B?TmQ5VHJYTmpRWVFmbXF6RVRvYkxxcVpkRlJ3V3ZpVGxsMk9hWG90ODVDTVM1?=
 =?utf-8?B?WHhYUGpUSmVnVDVET3RIWUF4OTYrWnAwb2tyREtMditjSEtjV3d6bVFodVR2?=
 =?utf-8?B?YmhQWHlORFRlaXcxOGdVYnY3N3BObGNvSjRZbDBZMlNXZGFLdzdIZzRKQmtu?=
 =?utf-8?B?OHpCbWdlWG5Sc04zYWxpa3RCWXIrdUZuUE9FT1JzSGVzSkRHcmpRT3NyZE55?=
 =?utf-8?B?bkFBbldSelZyQnBYWTVqZWNQL2NNYWljTTkrSDdWTG1oKzBjT0VHa2xndUNs?=
 =?utf-8?B?SXFOdThOdGh0ZitNNjZOcitoK2c0MkY3aWhsMW96WVdUZmpzYWp0ZXZrR0Yv?=
 =?utf-8?B?NTlxc0ZCRFhnVWs0and3UDRVdzBNODhWV2FSUm1tRU51am1lbGpoeHUvZjY5?=
 =?utf-8?B?dVg1ZFJDUk14LzM1V2JWOVM3aFRzSHhuME1vYUdJcmVBNEg1MlZjOTB4UjBM?=
 =?utf-8?B?UGpxZ2ZsNjdHaGQwM2FxcDVHMThDSWxoaHB0MGJ2VExmMHhOd1ZFaDdYNFNp?=
 =?utf-8?B?N1hUQnJ5WXRtdHFPbDcvTEVoV1NVcC83YjJOMTh6Mnl1WjhwTmVpTDhxWEFY?=
 =?utf-8?B?blJrMVVnbVJQUkR5ekxMak5TTUJtcnM3eGh6S0ZzRS9aMlBGbmZhZUYwWEhT?=
 =?utf-8?B?ZWlrdlpzWmQ0ODRYakhEd20vaVNrYjBHMHpzeUFBMU5iRUZTQ3VxOVdMV0cz?=
 =?utf-8?B?MmFBcVd2WEpjYzFQdXAyRnhkYlE5NVRzUTZBZ0Y2Vm9oU0hLTDJ6TnR2aXY0?=
 =?utf-8?B?ZFNXcjQ1NGY2SFQzOWNIdlZIakx0MmQzcGdFVUM3ME5WMWw3MmFPd0duR1VC?=
 =?utf-8?B?RldDdHJyTFVGVURSd0NORkVDVHRUZHNiby9XZml0akpYN25BNWNtSG5mamF0?=
 =?utf-8?B?SkpRYXg0M2k2ejBxaTl3QXlhbVAxbDlqcEd2QmhQY3ovZjZHVW93eUIxQzI4?=
 =?utf-8?B?K2Y4azFaMVNuK05NMXZyWi9LM0hFak1lU2gxNThFRStVQ0pBWnZQemZWK2ZZ?=
 =?utf-8?B?M1VQS3FLNGdvZjZEaHRyWmFOTkY0b2VlRDB6bW9WRVVjNVkxK25JNmo0c1dZ?=
 =?utf-8?B?K2U3anU0c1g2THRQV09MaVRCc1I1R3cyOXViTGtwd0xlMm14ckNJckFUUGpn?=
 =?utf-8?B?czAwekZSM3ppTzl2Szd0NGNtUHBDS0VleUtPeFk1VXVHZzVnenJWaFdCTnJ5?=
 =?utf-8?B?dEZCcDcvR1dnZHo2ZjlrL1dXY2pEd0w1L3UxeUFqenRZcnA3UU1ZRkdOY25H?=
 =?utf-8?B?VmtiSEFmRjgyaXQyUHFOblFaSnZSVjc3ckswaHVsdm1XcmJ2RXFRdjFUZkJw?=
 =?utf-8?B?WllFeXpCczdScGpyZUVPaE5vSlZzcnlGc2MrN1hudExHKzhKWmZ6S3kvNHRK?=
 =?utf-8?B?dGZtRUlYOXQzS2FkNDY4NmkxdUc3MjFDSjc4ZlJzRnBBVEJEWllmdjhONjg1?=
 =?utf-8?B?eURkOGQrLytyb1NPbUxlcHhjaDQycUxOOU1Xcm9MbEF6S1hBVWtkbkczd05P?=
 =?utf-8?B?WDZPT3FBQTBUdXl6MWY5Sm1MdEJScUx2d3did3d5TTZiMUp4emtwdmxyTjU1?=
 =?utf-8?B?bUhrTktmTVVhRWRZZWpwYU9RbngzK0JXZzYyUmNRdkt4OElMbWhYU3F4aHBR?=
 =?utf-8?B?bGZQUDRJaWk2ODM4b0ZOSHRZZlhYTWljRERKSFJ1TlVQTkUyOXpvZC9rWmFC?=
 =?utf-8?B?N3lGUGdvYWNQYXJTazVXM1hCREFLL0cxajd6dGEzQ0lQdWk4SUF1NmRibGxS?=
 =?utf-8?B?SVZKZ3JKeVU4cG5DYXNHTWg5RENkcjIvWFpJY0pPNjQwenFheXE2bkl0akVF?=
 =?utf-8?B?aWIyZ3NBcTdzOXN4VGRuRCtyM21WelpBK3VUbXEzS1pDUUxtcENFWWZoZXIw?=
 =?utf-8?B?TnlqeHlubktYNm0rQkxNUk5tZ3djRjZlVUNpa09kM2ZsTURjL25QSUNJdU9C?=
 =?utf-8?B?K1ZGY2pIK040M3FKdTk1R3ZPNFhtZmNVeEYwVDJ6d21wSThDb05CU0pnUHRR?=
 =?utf-8?B?SnZUQm9JbTRtQ2I4ekhHRWdoYW9JdjFnc1VFbERrcXFzZ0lIS0FBZnJGc0pD?=
 =?utf-8?B?QzdLczJFME5Bb1FHMTlxcWg0SWtTbllLRCt2cEdIVjhiTlFhdjhYZGJFL0RV?=
 =?utf-8?B?WmNrb216T284S2huRDNCNk1uZWUzZmZVRUg3eUh2c3VXV0xkR0ZnZGU3Z25a?=
 =?utf-8?B?TDk1d0V3RC92YXBpTWFGODVGcExscGhjbDZBTFFJczltejhSaHE5Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88999ec3-a8fe-4f57-c57c-08deb508e4cc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 18:11:33.7686 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: imZC/YlA7BbIsstkKjTmU/wfSwyhfMdVaOQklwKmirbX40ti7WUwy9znEo9IpEc6HtXwI+uI363HNDuGzbVuaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4276
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

Extend GpuMm with the remaining two memory-management components:

- Buddy allocator for VRAM allocation.
- TLB manager for translation buffer operations.

PRAMIN was added in an earlier commit; this completes the centralized
ownership model with accessor methods for each component.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/Kconfig         |   1 +
 drivers/gpu/nova-core/gpu.rs          |  22 ++++-
 drivers/gpu/nova-core/gsp/commands.rs |   1 -
 drivers/gpu/nova-core/mm.rs           |  27 ++++++
 drivers/gpu/nova-core/mm/tlb.rs       | 130 ++++++++++++++++++++++++++
 drivers/gpu/nova-core/regs.rs         |  65 +++++++++++++
 6 files changed, 244 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/nova-core/mm/tlb.rs

diff --git a/drivers/gpu/nova-core/Kconfig b/drivers/gpu/nova-core/Kconfig
index abf10e82647b..8eebb430856a 100644
--- a/drivers/gpu/nova-core/Kconfig
+++ b/drivers/gpu/nova-core/Kconfig
@@ -5,6 +5,7 @@ config NOVA_CORE
 	depends on RUST
 	depends on !CPU_BIG_ENDIAN
 	select AUXILIARY_BUS
+	select GPU_BUDDY
 	select RUST_FW_LOADER_ABSTRACTIONS
 	default n
 	help
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index aa047fe91054..f789d956cc49 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -4,11 +4,16 @@
     device,
     devres::Devres,
     fmt,
+    gpu::buddy::GpuBuddyParams,
     io::Io,
     num::Bounded,
     pci,
     prelude::*,
-    sizes::SizeConstants,
+    ptr::Alignment,
+    sizes::{
+        SizeConstants,
+        SZ_4K, //
+    },
     sync::Arc, //
 };
 
@@ -305,6 +310,13 @@ pub(crate) fn new<'a>(
             gsp_static_info: gsp
                 .boot(pdev, bar, spec.chipset, gsp_falcon, sec2_falcon)
                 .inspect(|info| {
+                    dev_info!(
+                        pdev.as_ref(),
+                        "Using FB region: {:#x}..{:#x}\n",
+                        info.usable_fb_region.start,
+                        info.usable_fb_region.end
+                    );
+
                     dev_info!(
                         pdev.as_ref(),
                         "Total physical VRAM: {} MiB\n",
@@ -314,14 +326,22 @@ pub(crate) fn new<'a>(
 
             // Create GPU memory manager owning memory management resources.
             mm: {
+                let usable_vram = &gsp_static_info.usable_fb_region;
+
                 // PRAMIN covers all physical VRAM (including GSP-reserved areas
                 // above the usable region, e.g. the BAR1 page directory).
                 let pramin_vram_region = (0..gsp_static_info.total_fb_end).into_vram_range();
+                let buddy_params = GpuBuddyParams {
+                    base_offset: usable_vram.start,
+                    size: usable_vram.end - usable_vram.start,
+                    chunk_size: Alignment::new::<SZ_4K>(),
+                };
                 Arc::pin_init(
                     GpuMm::new(
                         devres_bar.clone(),
                         pdev.as_ref(),
                         spec.chipset,
+                        buddy_params,
                         pramin_vram_region,
                     )?,
                     GFP_KERNEL,
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index 172411d7b475..5abd7950320b 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -194,7 +194,6 @@ fn init(&self) -> impl Init<Self::Command, Self::InitError> {
 pub(crate) struct GetGspStaticInfoReply {
     gpu_name: [u8; 64],
     /// Usable FB (VRAM) region for driver memory allocation.
-    #[expect(dead_code)]
     pub(crate) usable_fb_region: Range<u64>,
     /// End of VRAM.
     pub(crate) total_fb_end: u64,
diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index b23667a55ecd..ea415a88b221 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -32,6 +32,7 @@ macro_rules! impl_pfn_bounded {
 }
 
 pub(crate) mod pramin;
+pub(super) mod tlb;
 
 use core::ops::Range;
 
@@ -39,6 +40,10 @@ macro_rules! impl_pfn_bounded {
     bitfield,
     device,
     devres::Devres,
+    gpu::buddy::{
+        GpuBuddy,
+        GpuBuddyParams, //
+    },
     num::Bounded,
     pci,
     prelude::*,
@@ -51,14 +56,21 @@ macro_rules! impl_pfn_bounded {
     gpu::Chipset, //
 };
 
+pub(crate) use tlb::Tlb;
+
 /// GPU Memory Manager - owns all core MM components.
 ///
 /// Provides centralized ownership of memory management resources:
+/// - [`GpuBuddy`] allocator for VRAM page table allocation.
 /// - [`pramin::Pramin`] for direct VRAM access.
+/// - [`Tlb`] manager for translation buffer flush operations.
 #[pin_data]
 pub(crate) struct GpuMm {
+    buddy: GpuBuddy,
     #[pin]
     pramin: pramin::Pramin,
+    #[pin]
+    tlb: Tlb,
 }
 
 impl GpuMm {
@@ -70,19 +82,34 @@ pub(crate) fn new(
         bar: Arc<Devres<Bar0>>,
         dev: &device::Device<device::Bound>,
         chipset: Chipset,
+        buddy_params: GpuBuddyParams,
         pramin_vram_region: Range<VramAddress>,
     ) -> Result<impl PinInit<Self>> {
+        let buddy = GpuBuddy::new(buddy_params)?;
+        let tlb_init = Tlb::new(bar.clone());
         let pramin_init = pramin::Pramin::new(bar, dev, chipset, pramin_vram_region)?;
 
         Ok(pin_init!(Self {
+            buddy,
             pramin <- pramin_init,
+            tlb <- tlb_init,
         }))
     }
 
+    /// Access the [`GpuBuddy`] allocator.
+    pub(crate) fn buddy(&self) -> &GpuBuddy {
+        &self.buddy
+    }
+
     /// Access the [`pramin::Pramin`].
     pub(crate) fn pramin(&self) -> &pramin::Pramin {
         &self.pramin
     }
+
+    /// Access the [`Tlb`] manager.
+    pub(crate) fn tlb(&self) -> &Tlb {
+        &self.tlb
+    }
 }
 
 /// Run MM subsystem self-tests during probe.
diff --git a/drivers/gpu/nova-core/mm/tlb.rs b/drivers/gpu/nova-core/mm/tlb.rs
new file mode 100644
index 000000000000..1c4f8944a01b
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/tlb.rs
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! TLB (Translation Lookaside Buffer) flush support for GPU MMU.
+//!
+//! After modifying page table entries, the GPU's TLB must be flushed to
+//! ensure the new mappings take effect. This module provides TLB flush
+//! functionality for virtual memory managers.
+//!
+//! # Examples
+//!
+//! ```ignore
+//! use crate::mm::tlb::Tlb;
+//!
+//! fn page_table_update(
+//!     dev: &device::Device<device::Bound>,
+//!     tlb: &Tlb,
+//!     pdb_addr: VramAddress,
+//! ) -> Result<()> {
+//!     // ... modify page tables ...
+//!
+//!     // Flush TLB to make changes visible (polls for completion).
+//!     tlb.flush(dev, pdb_addr)?;
+//!
+//!     Ok(())
+//! }
+//! ```
+
+use kernel::{
+    device,
+    devres::Devres,
+    io::poll::read_poll_timeout,
+    io::Io,
+    new_mutex,
+    prelude::*,
+    sync::{
+        Arc,
+        Mutex, //
+    },
+    time::Delta, //
+};
+
+use crate::{
+    bounded_enum,
+    driver::Bar0,
+    mm::VramAddress,
+    regs, //
+};
+
+bounded_enum! {
+    /// TLB invalidation acknowledgment scope.
+    ///
+    /// Controls how far the hardware waits for the invalidation to propagate
+    /// before clearing the `trigger` bit of `NV_TLB_FLUSH_CTRL`.
+    #[derive(Debug, Copy, Clone, PartialEq, Eq)]
+    pub(crate) enum TlbAckMode with TryFrom<Bounded<u32, 2>> {
+        /// Fire-and-forget: no acknowledgment required.
+        None = 0,
+        /// Wait for acknowledgment from all consumers, including remote GPUs
+        /// reachable over NVLink.
+        ///
+        /// Globally is strictly required only during unmap or permission
+        /// tightening, because the backing memory may be reassigned after the
+        /// flush returns and a stale TLB entry could let the GPU access freed
+        /// memory. For new mapping or relaxing permissions, a stale entry would
+        /// merely cause a redundant fault and retry, so [`TlbAckMode::None`]
+        /// would suffice.
+        Globally = 1,
+        /// Wait for acknowledgment from consumers within the local NVLink
+        /// fabric node only; skip cross-node ack.
+        Intranode = 2,
+    }
+}
+
+/// TLB manager for GPU translation buffer operations.
+#[pin_data]
+pub(crate) struct Tlb {
+    bar: Arc<Devres<Bar0>>,
+    /// TLB flush serialization lock: This lock is designed to be acquired during
+    /// the DMA fence signalling critical path. It should NEVER be held across any
+    /// reclaimable CPU memory allocations because the memory reclaim path can
+    /// call `dma_fence_wait()` (when implemented), which would deadlock if lock held.
+    #[pin]
+    lock: Mutex<()>,
+}
+
+impl Tlb {
+    /// Create a new TLB manager.
+    pub(super) fn new(bar: Arc<Devres<Bar0>>) -> impl PinInit<Self> {
+        pin_init!(Self {
+            bar,
+            lock <- new_mutex!((), "tlb_flush"),
+        })
+    }
+
+    /// Flush the GPU TLB for a specific page directory base.
+    ///
+    /// This invalidates all TLB entries associated with the given PDB address.
+    /// Must be called after modifying page table entries to ensure the GPU sees
+    /// the updated mappings.
+    pub(super) fn flush(
+        &self,
+        dev: &device::Device<device::Bound>,
+        pdb_addr: VramAddress,
+    ) -> Result {
+        let _guard = self.lock.lock();
+        let bar = self.bar.access(dev)?;
+
+        // Write PDB address.
+        bar.write_reg(regs::NV_TLB_FLUSH_PDB_LO::from_pdb_addr(pdb_addr.raw()));
+        bar.write_reg(regs::NV_TLB_FLUSH_PDB_HI::from_pdb_addr(pdb_addr.raw()));
+
+        // Trigger flush.
+        bar.write_reg(
+            regs::NV_TLB_FLUSH_CTRL::zeroed()
+                .with_all_va(true)
+                .with_ack(TlbAckMode::None)
+                .with_trigger(true),
+        );
+
+        // Poll for completion.
+        read_poll_timeout(
+            || Ok(bar.read(regs::NV_TLB_FLUSH_CTRL)),
+            |ctrl: &regs::NV_TLB_FLUSH_CTRL| !ctrl.trigger(),
+            Delta::ZERO,
+            Delta::from_secs(2),
+        )?;
+
+        Ok(())
+    }
+}
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index fb42d96a59b2..277eb1a064f7 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -37,6 +37,7 @@
     },
     mm::{
         pramin::Bar0WindowTarget,
+        tlb::TlbAckMode,
         VramAddress, //
     },
 };
@@ -659,3 +660,67 @@ pub(crate) fn pramin_window_write_base(
         }
     }
 }
+
+// MMU TLB
+
+register! {
+    /// TLB flush register: PDB address lower bits.
+    pub(crate) NV_TLB_FLUSH_PDB_LO(u32) @ 0x00b830a0 {
+        /// PDB address bits [39:8].
+        31:0    pdb_lo => u32;
+    }
+
+    /// TLB flush register: PDB address higher bits.
+    pub(crate) NV_TLB_FLUSH_PDB_HI(u32) @ 0x00b830a4 {
+        /// PDB address bits [47:40].
+        7:0     pdb_hi => u8;
+    }
+
+    /// TLB flush control register.
+    pub(crate) NV_TLB_FLUSH_CTRL(u32) @ 0x00b830b0 {
+        /// Invalidate every VA in the PDB selected by `NV_TLB_FLUSH_PDB_LO/HI`.
+        0:0     all_va => bool;
+        /// Invalidate TLBs for all PDBs (ignores `NV_TLB_FLUSH_PDB_LO/HI`).
+        1:1     all_pdb => bool;
+        /// Restrict the flush to the HUB MMU's TLBs; skip broadcasting to the
+        /// per-GPC L2 TLBs.
+        ///
+        /// The GPU MMU has a two-level TLB hierarchy:
+        /// 1. The *HUB MMU* sits at the top and serves memory requests from
+        ///    "host-side" engines: the host/channel interface, copy engines,
+        ///    display, and BAR1/BAR2 accesses.
+        /// 2. Each GPC (Graphics Processing Cluster — the block that houses
+        ///    shader cores / SMs) has its own L2 TLB that serves requests from
+        ///    the compute and graphics engines inside the cluster.
+        ///
+        /// When set, only the HUB TLBs are invalidated. This is a performance
+        /// optimization for flushes that only affect HUB-side mappings (e.g.
+        /// BAR1/BAR2 windows), where fanning the invalidation out to every
+        /// GPC's L2 TLB would be wasted work. Must be false when flushing
+        /// mappings that may be cached by compute/graphics engines.
+        2:2     hubtlb_only => bool;
+        /// Invalidation acknowledgment scope. See [`TlbAckMode`] for details.
+        8:7     ack ?=> TlbAckMode;
+        /// Write 1 to kick off the flush. Hardware clears this bit when the
+        /// flush completes; reads as 1 while the flush is in progress.
+        31:31   trigger => bool;
+    }
+}
+
+impl NV_TLB_FLUSH_PDB_LO {
+    /// Create a register value from a PDB address.
+    ///
+    /// Extracts bits [39:8] of the address and shifts it right by 8 bits.
+    pub(crate) fn from_pdb_addr(addr: u64) -> Self {
+        Self::zeroed().with_pdb_lo(((addr >> 8) & 0xFFFF_FFFF) as u32)
+    }
+}
+
+impl NV_TLB_FLUSH_PDB_HI {
+    /// Create a register value from a PDB address.
+    ///
+    /// Extracts bits [47:40] of the address and shifts it right by 40 bits.
+    pub(crate) fn from_pdb_addr(addr: u64) -> Self {
+        Self::zeroed().with_pdb_hi(((addr >> 40) & 0xFF) as u8)
+    }
+}
-- 
2.34.1

