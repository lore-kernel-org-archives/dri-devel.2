Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB7C3C55822
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 05:45:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF80410ECDA;
	Wed,  5 Aug 2026 05:45:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="hlWRwhOy";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011033.outbound.protection.outlook.com [52.101.62.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1C5210ECD4
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 05:45:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GdsPlHUv2Thu9P3R9T4uf4m8c+j/Z6o3BsUPT4UBI3AokWV5l3TW9mH4gtia8aaeEd6/iNPZzmSG6oRhfX+ATsnIavZD3lGEvfaZzZ8ZUeVcAVVu4udybdQYIMwtRSSf5RLH40/DiJ0T+7upQUMrOIJ4RI6JWlTW2r1hGKqbtCR9llJRx2eFA1vZ4YgsDg7pHjfp+gjpSiLC6EdWOUE4Glzm0P9gaUlJJ10hJSpNYT/+4RZrG8ZHJbqvr1P/NMHXbLGBd8lZiLCGF5MqLfNboF02n9u5VuFUFW89jUx0T8lpPgZrQU28Ka+uCd1xq/fTE1QdM5ucrBFsAP6c7ljWoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHvlATAeu0qkPCZ5AX8NUgZP6iYc8IERZT3DSyy1WpE=;
 b=ZzgXNKr5z/WtE4f0akVtiv509mRJxgzlVABS+NoPYVQsDrkAH1Ks3Yg5+xo0sTHGT+vJWyasMNd+72dBsQckxTuLsE0WlamznOu1TpdGBQ3rT3mJ8aSURY5mHJIl4tIT6dSHACSyxn1bVPHJoMU5ICyk91ay5oab0MvkpyqnwaGHYLxK7hZ/OGAkA8YUGGQEc84B0nJBI0Z3ejp74R3MWK6PjORMii4OXj4NfsAnpTIWvbbtlHL08VSSTEwcwTipPdC9Lxq9L42NuHt5OGBRFfV0XdeQwye6YGs9XT/5PT/Bx1IBbAN5ZrFEUKBoLSKUXjkbaH8JvqJvnNenD2CkOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHvlATAeu0qkPCZ5AX8NUgZP6iYc8IERZT3DSyy1WpE=;
 b=hlWRwhOyjEo223QJ04tCTnB4XqxapZfV48XDH6mZT0UCk6ibL/Wf/Ra3ACpAf+dscvJvWKbcykI1ney1WgNTr8D5hRNd06mLYJh8UpjPBLKg+B1p+2ydLe3H+Mlxq1izvGqEOxxDRunK3dxlUpWomh2LuE/Z0oxlLXKul4/eKbViGENf24YHHtHM5RvmCqej7KlZ/N5jaS7Fe6ZpEG7cuLjer/VBjzWKiO9EAucpDMpOGHrwITfp63hw4ks8etCDIhrBROr3SkBxQSfj6dnAyOHtg1OF/a+Lz72TqC0OB5LUVl/L2qpd7haCKf+awS9gUKXoPrc8RiUZvmljgSYzug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CYYPR12MB8989.namprd12.prod.outlook.com (2603:10b6:930:c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Wed, 5 Aug
 2026 05:45:51 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 05:45:51 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 05 Aug 2026 14:44:57 +0900
Subject: [PATCH 10/12] gpu: nova-core: mm: Add GpuMm centralized memory manager
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-pramin-split-v1-10-ff3e84a75dac@nvidia.com>
References: <20260805-pramin-split-v1-0-ff3e84a75dac@nvidia.com>
In-Reply-To: <20260805-pramin-split-v1-0-ff3e84a75dac@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Yury Norov <yury.norov@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY6P301CA0011.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::15) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CYYPR12MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: 8df56903-b86f-4703-5254-08def2b4ceaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|7416014|1800799024|10070799003|3023799007|6133799003|10067099003|11063799006|56012099006|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: PLRPeKd85Vk3CnzTc7/o3acr/r0mGh6Zm0lazTXYnUmim6TVJutvFSeyp1rVxxavb98R0FtM+LsvzVx5fOTBATVlIbJLr7mzD+GPx5tpDqpaxs83yvcxAORBfd40B6Kk3zwEmyNJWZKZ/qqPwSPegrhNKBprTMPrsmWi45VauIqjjffAw5VWQtToDNGGWC8eararmCvOeZiykDCMvC7F3NsH88h75lzmS5DZbofr0hbz/xqT/dByi4AXQ1KPalIVXJVWwMs9Vu4cjsPj+YnyPnHHkfq2ySWrivZxG/bVoIjgEXZlcfneofyluhptgPQDjdo/GrboC7bYlluCaytfEN/pKqPOfKuLbH5bA63fn0AYWm/chHRwNXD9RbvA+MPQOhdfzXLCjEj1ofL2fKvt5Itu4mmdGwJYze39U2fyFXxyvthR1HUtOd8tzFGC2LuruSUukIygqIzSIoWdhIqC0si83OBD0ZoBKOTpu9ZvYBKVrSYMIeOJvB6Dm9WwDe0+QprQQKdV8TysKsgRCm3PoYOGd/RO9/6/npk1P64DRj5xfofON2IfTTf3C8ePIjjT+vlXT2oBGbcpO3pP+jssAIZrmmV2rowqNw7ahZFeXT/+Rbaj6KcQiARfNfFDWk//JXqzT+juBGC2Da/lJuHVkB+WTtKm2uhHenQr9aotC7Ap32HChhVSxBZ6QXBoOARV0uAP8zKYN9S9jCdzMZ5smQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(10070799003)(3023799007)(6133799003)(10067099003)(11063799006)(56012099006)(921020)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDYveWtBeWdBeXlpRExqc05rTkozRjljV1pCSThDMGhyRDJWak9LK2VQSnFl?=
 =?utf-8?B?VlY2SER3TmNQS3I5Z1ROVm5wUGpqdEZ1Zm5Dd3d6VmtQWGZEM1hRcVU0M0Zo?=
 =?utf-8?B?MCtuVnBTNE9WYXpXTE1UNzJCU0FtZ0k3am5vdENNeVJhaXh3QllCOCszUk00?=
 =?utf-8?B?Z0ZzYitISGorRSswMEZWYVNqcS9Da2VPY0dwbUt1MDBUem5YSGltRGcrdVpI?=
 =?utf-8?B?bmx5dThuT3o1ajdmb0xDaFNMN3ZueXFaWVhhY3NQQWFSdFJxR0RacVQ1L1Rj?=
 =?utf-8?B?QnJUb3lYYTBlL1VzV0pPaU54UjBvSUFKREpIMm5ENk9CQkxjUHhoRUlkd3Nr?=
 =?utf-8?B?V2d2NjZmQUZadG1VWmVKaGlMdHFRby8wbDNKTlJCRlJscjNBd0xjaENXTzRi?=
 =?utf-8?B?U2Rva2xNNTRMQ2hlTGtuSHZEQXRUMUI0YXBlcWZDWUF3Tk1rV0o4TWFkVXdG?=
 =?utf-8?B?ODAxcjVxZXFjS1pESTF1TVVhampKL05UcDlQQWFYUVJtcmhseGwydnl3Mlhv?=
 =?utf-8?B?MDBIVzNwV21tblUyRzFIZkNPUDMxK0xVUjR5SkJzUzU2c0pRZ29pQkxqMys2?=
 =?utf-8?B?eDJCbjVzMjR2VWtIV1pYemg1bC8wbEpKcFAwSEpqaVMzM3VJNlFLaXdWT3V6?=
 =?utf-8?B?T0Y5OWE0ek1sRnVGSzc2Tlhxc0lLNHprT1duMkRDam9ab21HdzZ4Z2w5b1dV?=
 =?utf-8?B?dkFOUURHRVpSb0tKZW9qdEZ0TUQvQ3VwRGQvQVFCWWNGVjJPdkpSWTFVMUJM?=
 =?utf-8?B?WDlIL2FRWVhsbEJrL3VBS2RPM3V4TXpVL0hlSU40SUxJd3pvRlBjcFl6cEEx?=
 =?utf-8?B?MnAvQlpLeFVENGVwaks1eUlXV2RyNEdsUSt5Q3pTb3VrV2tJalNQSGY1WVVD?=
 =?utf-8?B?UDJ0eDFjbHVqZ2kzV0VkREhMZkFlZnVPRkQwSGNRODdQWGhEdG5tVTdPNGFt?=
 =?utf-8?B?WXRrZFlmTUdHcDkxNnRXMFhPOGdBMjlDY3hTa1ZEZWJ6bWtKcWh1NU1CVEJD?=
 =?utf-8?B?bjF3cmNjRjlnLzMwY1MrYW1ES0tzbVVvYVdOZ3gwOEJXazVjUHlCNXIwQjlX?=
 =?utf-8?B?U0cvR2Nyc2lwYS9RcE5ZMTNjRW96VTBUODFzaWk3b1hua3hpdkd3OHBOK1JC?=
 =?utf-8?B?M2JBMHlaYzZEcDh0YnJ4L3hQUmhMTmhJcklhazdpUzNqbHhZS2ovb3gvY21L?=
 =?utf-8?B?UUVBckJja0dxOWlRcU9zaThLaXFZTlBmZG5BZURnQU44TldGVzRjT0FvSzJ6?=
 =?utf-8?B?NUNHN1VJbUw0bGpETFFwZ3FyN0l4Qi9PRjNuKy9pK0dzQlpzSzV6OEptKzN5?=
 =?utf-8?B?UjZxN2syd1lGNERTMlB6c0JSQklVTFJoemNSUjdmaGlOYmp2Y1hwczBCTWNw?=
 =?utf-8?B?dVFqbnNDa3BaUWovbjRUbWcyelpDRm1JVHNmSWhVUXg0M1c2aElLQzdJbmEz?=
 =?utf-8?B?SFdreTZFUDRhRnZqSExNaDlPL1pnR3VZelhEK2N2YlRIZkNzMjE3dTI4Qnpr?=
 =?utf-8?B?ZlFZcUxyTHM2eGJxWHVaS01JYlpWRVNzTEx1SkpKdlFiOXUreHNyQVJNZllP?=
 =?utf-8?B?ZC9CV0szdHRWeEtGelp6VGNISndNYU5uU0VyQ3QwS0RLUEhldi9qUGprOEJ1?=
 =?utf-8?B?VFU3YnhaUDRpc1ArazVmSmI1RVE0Y1ZuOTJFblFrelBqOHNiQkJvMnBFQ09Z?=
 =?utf-8?B?dkRpc3dpTnFyaEtFU1RNbDV5cmkxaGF5YXp4RThoNHQrbUdyZlpaeWZPSDVo?=
 =?utf-8?B?NGhqTy9NMU85T3BsQ0ZSeFJOa3h3NlEvWitMMUdVU3hUVUhhV3R2dC9qejND?=
 =?utf-8?B?eWMxZmdDSDA3emJNeU80RzNFeUw4Nm1PWHk5S3NnYitidW96U2Q2OFhWNko4?=
 =?utf-8?B?WVJSL0g3SWdyWFRBaHVpaHVMVTBycHVWZi9xWXlWN3ZnL3IzVXJZa2NIckVx?=
 =?utf-8?B?OG9nUzhFZU5WU2ZjSTMwUzJnSHIzNVVaeHRJUXdGUVBpVnVlSGlYN0tDTFJT?=
 =?utf-8?B?bmN6VjVYMTN4Y2E1Nng4WHZFVUxEMG44QkZLMzlqbDFNYVgxQ3p5b2RUcDRS?=
 =?utf-8?B?MEp2ZlNFTGFab1VXUzlSL3ZqVzUxUERiYXU3VVEyaDRXZ3oydnkyT2l5MUlt?=
 =?utf-8?B?ajRINDFwYU1HcTFVZUVJTHBtY2NBS3lSa0d6Y0gycXVHeDB6UUdMOWVBRU5G?=
 =?utf-8?B?TE92L1h4Rzh2cTVWcmVMenJWT0w1VXQzSjVoMlY2U0JqUHltaDJxbXdUbjBs?=
 =?utf-8?B?UG1kRXY3U1RQQVZKTmNHcEpHSmtUbWhHMVRlQmRsMmdvMkNGUmxUdnR2ZHdL?=
 =?utf-8?B?VUtNWGQzYytoRGRObWJ2WmpFR0d3TEJsT2VKVzZ1WVl5L0VNcS9WWkh5dXpW?=
 =?utf-8?Q?3df0lJnfoICKAz6g4Qb+Fr9yH9TJnlNZCSTgl9pOau3zv?=
X-MS-Exchange-AntiSpam-MessageData-1: ZISnXtBh7DFf3A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df56903-b86f-4703-5254-08def2b4ceaf
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 05:45:50.9888 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ojBAFqQAPzP21uwcpjuQlhzazy8mbTcc3qcDoQ3/yO2I4WWC88u0UDbRAJHZecfPHSHBfDU9qCL2em51s1NO3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8989
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
index 42a4cd7971fa..e29e07488e78 100644
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
@@ -410,7 +419,14 @@ pub(crate) fn new(
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

