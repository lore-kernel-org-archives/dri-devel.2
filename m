Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D78C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 08:53:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 947F910EF1F;
	Thu, 27 Aug 2026 08:53:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="qAV4CflL";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010025.outbound.protection.outlook.com [52.101.56.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9F0F10EF14
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 08:52:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HBY1oktNIZro+RKo75kmOSDr8CL2EgMxPa0SX6XYT5j04ZyIJJI7x6Z6cMnwCkHP82udJvQ5AlefdA3NuiNSBD0u+QkdS75/f1d2Tjz9t6shfs38hw3lbCrWIzrxcOrfSuTf5Wukz3NrafnktD5ATaI+eDqLmw9u6M6u6gUu8QOmFlNgRyiGMqgBz5dDCwNlhcjxLDT3lQXJk5PSH3sUH5UWSlXw3U6aLYROOyeYZMg7nGQtw04Lbc+dOWU+5RlodI1IR/+YnRnUHChcugns6fCny43KfcBCVefDmIcviKsMgX/BsDeU5F2uESCXuL6qDvxiTjVR6y0VE76004PI/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXcWjPk28ZH4wMJrhygUDgBwyZ1KH0RkEBIsQESJoSI=;
 b=g/Exc2mwJWSzfQBMrpWR2OdewqI6eWoKT5e/lwmq3CJSK8mbBQP+PPJYjS7P1dJ1A4Avm7/V5hPdsk/wbpnfSv8vba6+GXTl8av21hZB0Q3LVlckKyCGQ54mKt5hEOiwpDimX7b6T2nR2TjhD/WQFO+V/C4K7hkIYUnaDPvWRDO1Q4AL/8Qdh0rSVeJU8HYBNDWGdcwcEVyaRNjP6Pr6StTMEOtBZaPFX1kobH2WCZxNgzHnXF8LOyWkLJECh56KAqqV46hTu/hZ0TmVF/8RZ8C8BlIR3n3A8jr1l+4NW/g0VlEjwBb1STOPLAjTkJ2O57bV+cdck3wIVR5FcExu+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXcWjPk28ZH4wMJrhygUDgBwyZ1KH0RkEBIsQESJoSI=;
 b=qAV4CflLurzZ4HtkdYLz94zTE1j9VLbj5hjrVg548e0yC+ssmGyinbLjMnklgNYldXgRemMLqXWKCUG9TE0wU0/NovBEUhTHX9A5thznnOiU4Q6w5ILdFbKTeWJ91ZqQpNTffjgoQwXroNQKAuWdhWXlQWckEHiofoPfJI5l3JWjNatIpFFAEk+q2dEGLN+AgqFxCEHcQ8JtLN3i6bRl+5Rj5y7oeyELwCu1aaEegeCl4I02IyyK7sxaxR0YyX/Xdvn/vTzg1rTnjs3Daq9t0gHnky2g9he62uMETMT+crASg2cXWKDrEA+eo/7Khqdvv4RYmZgKqsGReDH8QfPufg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 BL1PR12MB5729.namprd12.prod.outlook.com (2603:10b6:208:384::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Thu, 27 Aug
 2026 08:52:34 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 08:52:34 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 27 Aug 2026 17:51:49 +0900
Subject: [PATCH v3 08/10] gpu: nova-core: mm: Add GpuMm centralized memory
 manager
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-pramin-split-v3-8-24b24d7afc52@nvidia.com>
References: <20260827-pramin-split-v3-0-24b24d7afc52@nvidia.com>
In-Reply-To: <20260827-pramin-split-v3-0-24b24d7afc52@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCPR01CA0210.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::9) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|BL1PR12MB5729:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a12c9d7-7ec7-4ad8-0766-08df04188979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|23010399003|1800799024|366016|921020|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 2YS8KaKXQNOxXr0NuOlio563q1KQj+Tk41cGyRLGZmaZs2m9mNCGqrwI6TnrS2wh88nhL42tLrP5J9W9elXPRrdOz5jUnYuBhPMauLtQ5YjNcUNhrvEjED3RIqei5Emp+dhw7p+Jphk37eQj8o+CMRfSIqnKQN9fI4hlxUVCYgg2sNpBMhJ7+gfkoodjryV0GYLSDA2P+BjU8hhUSkaBd5cRsuLcVvXRMCfY3YLPEIv6ILON45S+m1XwqoSzZhl7X98zouN4YFZfo9KAKXLMEuqmWDBP9aOK4vzndQcldaDT4vCKdn5kiHuisiv+6JmQCIPsjhYDtPXon/2A6wPTo8bFF8QDMnuE7WH4QDaKfngPue27i953lOJXcK1pld1rWS6TtAF8LuqsiFwpegSI1p00ND+3wTWNYemrGF1OvlzWfs/wOdrYytfKn1rEt8S43Gf+RmJRl+weGNjVmK8UO0ABAqzcb4gyuqCyUysxDvG0otb001SC5YBRrUDsEkXhGstzyG/awIt2nZc+nmZcyi3wIJh/+375yfRTeXLg6jggbSrBjCGzUDrffS6C8Dcpfq+MX+sB1tpri2IhYiAOuaKVmjCPlZcuH8miDAqjHyZeYgIxqwSJrSxrf3bdgZAo6ClvY1RWMTvJruMs0/fkeTTymXNhufWMQ6MC3bE2oJL61+nQ9HB89GXWZar2L2M0w+1gFPZ7e3tXgFeq88a/kw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(23010399003)(1800799024)(366016)(921020)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWYyZVh1KzMwZ29GaXNSV25BSXpRNTh5a3NDbDRISmZ5YXBwN2U3aisxTXpD?=
 =?utf-8?B?dWljTlVPdEE5eStKRzZYdHJ2RDJpdTRZcFJMNklia05JN1B0Uyt3S1RYSjZV?=
 =?utf-8?B?MVE1ZS9DbmR0TSt4bVhaRVMvMEFObmExUFFyRm1uc09ZbWgwTWxzdGducUkw?=
 =?utf-8?B?N2gyM2hkVzNQallzeUR0WmFML01icUdidS9QSEVkSFJ0S0hNWHBxQTlnRnVL?=
 =?utf-8?B?VFE0a3l3MkwwNkhNRjhjMnQzcWNDMitVNVFIQmRLdjdVU0NpanljK0lrbGtt?=
 =?utf-8?B?Q3FZZU82MndKQjlzbXdGSXNBOW5QQVpYOFZIbUJiL0czbFN4YURmVGlIUjZs?=
 =?utf-8?B?MGxnNGltcVJuWVlRMjVSbVdYN3FGRS9kb0hpalVsNmM4bzI5VmxPR3BZcFRR?=
 =?utf-8?B?TXBPVGM2b2JEVCtGNlAwL0NNdUhLMXd6bDBna1VtT0I0QkdxSktNR2pUdUdQ?=
 =?utf-8?B?Um5QeEl2OElWaUFXOFVzZkhjVUtOLzR5K0Mxa0lYWk9nd0dLdm5zbjlvWUoy?=
 =?utf-8?B?RVpXQ2I4YXVWSWVKTzFUVFo5cXJINlloRmZ4cUVGN0E4TFA1SEdXMlRXNXNW?=
 =?utf-8?B?c0NLNTdZMnBwMzI4QlBUeTh1OWhvTStxcElZUUNJZEwyaXFZL0NxeS84OTBF?=
 =?utf-8?B?TStQRllWbHArVkwrN0FmZmNubkt5Y1FMU21QOWlXQlNoSExobzIxSXpsSEtq?=
 =?utf-8?B?dXloZTdPd1lZRzlMWDAzNk5OelB2ZFh5QU5UQmUrZFU1d0J3M3U1djlTS20v?=
 =?utf-8?B?TFdZZnNMTjY2ZXFFSU1EaGdwRG03eVdLRnQrSXpnUGptVllSSkx6akI4dm9K?=
 =?utf-8?B?NmJINXBSNUNSbkYzZU90Y0IrRVFhNGVDWVRrR2VZM25XSFE4b0hBRG56N2ZY?=
 =?utf-8?B?VFZhUjEwK05qaTJIN1VNUkU5Wmo2aFJ2Wm9YMi82YU44c29kSEl2dlNCRWZu?=
 =?utf-8?B?cFVLeWd0OHpDSmdwZHJvL1BNMEgxc1VHSm9SQ1p5d2taRDIvWXFVZ1A5NWxt?=
 =?utf-8?B?K2taYldMZTI5RXRXZ2xJdHBOWXFjL1RxV0RnMXo5MlZGTkc3cmQ1Ymdkb0Mr?=
 =?utf-8?B?by9UbFVuSW1KZ1pZU3ZaVFJOSTZiaWMyemtGUElCa1dxaHdVdVlCK3F4Nzkv?=
 =?utf-8?B?ZFZHY05MaUQxaExKY1R2R2p1WGRpM0F5MW5aT3ZUb2VVV0VndGhoc0UvTDIx?=
 =?utf-8?B?WDNuMU1DQ01SaW9LYkgzaDJVcks4b0lRVVFKWGNodDdEbkVDTEZ4RDlLaW5Y?=
 =?utf-8?B?b05EdThDcWI2a0djTE5hMXVsM2JWdE5LSEhhMTlaZmtTY3k3aDVPYjNQa00y?=
 =?utf-8?B?NHNZakdiSWkzd2hVY0VvdDdRUFU2d1IxRTdvcHdNMTRUTHBvK2IwZ2ZRTlp4?=
 =?utf-8?B?dXdQa0dMQXdNVVlMZkNNUWF4WCtXOFdnVTEwN09ZR296WXV2VDlGbVIyTHJ0?=
 =?utf-8?B?aFpsSHdibStTRnFQWC9EaFNCaGlYeWpYVGdIcXNBU21kKzNUaTBSTjNqeFk0?=
 =?utf-8?B?L0pjUXNpWUFXOVJab1pJVVAybHVjVUFRdlBLa1FPNkdGamR5dk1ENERJcnNG?=
 =?utf-8?B?WmhQRklnRE9jeXQzU0czT3JuNGhPQ2syTjQyODdRbVdXWWo4UFNmSEZjeDl1?=
 =?utf-8?B?cTNmWjRndU44L3JBMEpnRHdMb0NENWNTYUtBbkExd09ZNGdTbzhTQXZiNC90?=
 =?utf-8?B?NVo0M3lYNm5sWDVXd05Nc2pycTVXSmQwcEx1Vkl5TWRvR2YzaTdvYzVPSlRh?=
 =?utf-8?B?ekZQTDFkSzBGbmJ3aUtNUzJ6TEE2RnVlVzA4ejViNUZMeVNlZmhVbGFpVndo?=
 =?utf-8?B?anovSnBMditySGRzSFpoTXF0ZEc4OGZaR1dDRUNrQ01CS2NRMVN4cWZjeXFr?=
 =?utf-8?B?U1VCbUNQQ1JPcTRDb1BqczRFMWJPdmNsUHd1TENyMVowTGhqdU4yc3VjamEw?=
 =?utf-8?B?U1dxOHdrOVdhZDZZT3VOTmgweGhPdUMydUZDN2lHeDBXQjd0ZkRIV2w5VmRy?=
 =?utf-8?B?ZERBQXB6MmlHTTlhd0NiSTZuYWh4NzFDMitTWlFKL2d5RzBEWkVFZGdNQlYr?=
 =?utf-8?B?cWwzSXh5SnJKZ2pUL1EwUDN5MnZwK0tpem5rOFpXWU5pMkowdEd1UEMza3Z0?=
 =?utf-8?B?cURiTWVzK0l3S09NY1k1YnN5UTBRNjM5a3hWb1ZEaGhYdVdtWEhRRXRBdE1l?=
 =?utf-8?B?YVM0bTFCR3VDeEJOd3cwaDJmUnNON0hmekw2RkVmVTA4N0s5Tzk2ZzBNcXpX?=
 =?utf-8?B?VUdDT09jY2piS0hzRm8ycGFGdEI3VHhoWEcxemdwNTdBcFhFMzYrcFhRS3hM?=
 =?utf-8?B?bzBPdndhaDd4Z2I1cXRwUFRnRTNwL0c3eTFjT3ViYUlJU2R5ME82Vml0bzJw?=
 =?utf-8?Q?Ia6tpHR9a8OApQeoxfvFfgWvc6gR0lH0Wot+LID8T4V3J?=
X-MS-Exchange-AntiSpam-MessageData-1: HISmndGbUAKNrA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a12c9d7-7ec7-4ad8-0766-08df04188979
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 08:52:34.5511 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vimHb+XVh4Bivm9B7WOG0UCl3Zxa0ZezstqFAcHqO+viORDXQfIUaQGzb0DALE0WtKFHjJ4kF4c44qCir51+Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5729
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

From: Joel Fernandes <joelagnelf@nvidia.com>

Introduce GpuMm as the centralized GPU memory manager. At this point in
the series, GpuMm only owns the PRAMIN window for direct VRAM access;
the buddy allocator and TLB manager are added later when those backing
types become available.

This provides a clean ownership model where GpuMm provides accessor
methods for its components that can be used for memory management
operations, and lets follow-on patches (such as the PRAMIN aperture
self-tests) reference `pramin_mut()` cleanly.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
[ecourtney: squash the total VRAM end patch, drop its dev_info print]
[ecourtney: take the maximum FB limit before adding one, fail with EINVAL]
[ecourtney: rebase for the Bar0 lifetime and ownership changes, drop Arcs]
[ecourtney: source the chipset through gsp_resources]
[ecourtney: build the VRAM region in new(), pramin() becomes pramin_mut()]
[ecourtney: declare mm before gsp_resources, doc wording cleanups]
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs             | 18 +++++++++++++++-
 drivers/gpu/nova-core/gsp/commands.rs    |  4 ++++
 drivers/gpu/nova-core/gsp/fw/commands.rs |  5 +++++
 drivers/gpu/nova-core/mm.rs              | 35 ++++++++++++++++++++++++++++++++
 4 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index fd1414004dd0..7b3e378c429b 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -29,6 +29,10 @@
         Gsp,
         GspBootContext, //
     },
+    mm::{
+        GpuMm,
+        VramAddress, //
+    },
     regs,
     vgpu::VgpuManager, //
 };
@@ -283,6 +287,11 @@ pub(crate) struct Gpu<'gpu> {
     spec: Spec,
     /// Static GPU information as provided by the GSP.
     gsp_static_info: GetGspStaticInfoReply,
+    /// GPU memory manager owning memory management resources.
+    ///
+    /// Must be kept declared *before* `gsp_resources`, so that its components are dropped while
+    /// the GSP is still operational.
+    mm: GpuMm<'gpu>,
     /// GSP and its resources.
     #[pin]
     gsp_resources: GspResources<'gpu>,
@@ -410,7 +419,14 @@ pub(crate) fn new<'a>(
                 }
 
                 info
-            }
+            },
+
+            // Create GPU memory manager owning memory management resources.
+            mm: GpuMm::new(
+                bar,
+                gsp_resources.spec.chipset,
+                VramAddress::from_raw(gsp_static_info.total_fb_end),
+            )?,
         })
     }
 }
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index ffc25fd8c47b..eea1c9ed4684 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -216,6 +216,8 @@ pub(crate) struct GetGspStaticInfoReply {
     gpu_name: [u8; 64],
     /// Usable FB (VRAM) regions for driver memory allocation.
     pub(crate) usable_fb_regions: KVec<Range<u64>>,
+    /// Exclusive end of the FB physical address space.
+    pub(crate) total_fb_end: u64,
 }
 
 impl MessageFromGsp for GetGspStaticInfoReply {
@@ -231,10 +233,12 @@ fn read(
         for region in msg.usable_fb_regions() {
             usable_fb_regions.push(region, GFP_KERNEL)?;
         }
+        let total_fb_end = msg.total_fb_end().ok_or(EINVAL)?;
 
         Ok(GetGspStaticInfoReply {
             gpu_name: msg.gpu_name_str(),
             usable_fb_regions,
+            total_fb_end,
         })
     }
 }
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index 6dc31d1bf5ae..6e85442a4b13 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -165,6 +165,11 @@ pub(crate) fn usable_fb_regions(&self) -> impl Iterator<Item = Range<u64>> + '_
             }
         })
     }
+
+    /// Computes the exclusive end of the FB physical address space.
+    pub(crate) fn total_fb_end(&self) -> Option<u64> {
+        self.fb_regions().map(|reg| reg.limit).max()?.checked_add(1)
+    }
 }
 
 // SAFETY: Padding is explicit and will not contain uninitialized data.
diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index ef5b1cad56c3..58dce211a337 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -19,10 +19,45 @@
     },
 };
 
+use crate::{
+    driver::Bar0,
+    gpu::Chipset, //
+};
+
 mod hal;
 mod pramin;
 mod regs;
 
+/// GPU Memory Manager - owns all core MM components.
+///
+/// Provides centralized ownership of memory management resources:
+/// - [`pramin::Pramin`] for direct VRAM access.
+pub(crate) struct GpuMm<'gpu> {
+    pramin: pramin::Pramin<'gpu>,
+}
+
+impl<'gpu> GpuMm<'gpu> {
+    /// Creates the GPU memory manager.
+    pub(crate) fn new(
+        bar: Bar0<'gpu>,
+        chipset: Chipset,
+        total_fb_end: VramAddress,
+    ) -> Result<Self> {
+        // PRAMIN covers all physical VRAM (including GSP-reserved areas
+        // above the usable region, e.g. the BAR1 page directory).
+        let vram_region = VramAddress::ZERO..total_fb_end;
+
+        Ok(Self {
+            pramin: pramin::Pramin::new(bar, chipset, vram_region)?,
+        })
+    }
+
+    /// Access the [`pramin::Pramin`].
+    fn pramin_mut(&mut self) -> &mut pramin::Pramin<'gpu> {
+        &mut self.pramin
+    }
+}
+
 /// Physical VRAM address in GPU video memory.
 #[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
 #[repr(transparent)]

-- 
2.55.0

