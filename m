Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CFCC55822
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 05:45:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 955C010ECD3;
	Wed,  5 Aug 2026 05:45:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="JrYE3cNd";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011025.outbound.protection.outlook.com [40.107.208.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BEC110ECC8
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 05:45:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HUSGsQfvJ0Nz4xLxKgcc/nZYk4xlCgY1YHD/7To+h7iQBiUYVtEI7tlRJKeBdCl9lZXTT/xEChud4FrjmWTzzxcuGyrgmWJjkeKUDh8ufxSPG1ejpjjogNHKFFYEw27hiINud4z1lv4xdCt+mYVZtljSppwDMRVGFJ6FPASGKEAC6soGHd7u9FvjACF4M4bE7FHq/YfI9Qj0vLi9MCVr89jbKbVtGPtjJFfhy6Z0O7mMNBnHzYEReGNy/kbCQSXbe6MhMQqyh5OaPCh6SXJH2PocGpMsedZfpVdMt9lM5Ur9I0CL3OiMZhWam/UBYsZ2GcZdJMVsHubINkpb8km4oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0fgXmsKFV2BxVeLhnIu2GgXX11Qr5ZU/UI6snNAkOE=;
 b=dpGGxBPAvKCzlmAUd1CHMrG3PdmdKhIxXetD2PK6ihIvlfSY2gVgMfJOuRuGZ7NK21IzUQMUkiHo6pInpsEoTNtqnEDRXnXkzZjwIGgK19UqWWg8W0lwbnojt7nYXElY9wtLFty+jD6sKwBy49rC0cmICV294hrY6BZ4j0kynjeJZ3Rl/iI4xun2Ii3dgc89BpZE9yI81qUhDAInok8pVxQYCXmaF3lPQ21bcZPaavo9wL0X9zCQe0iU/HtYJwuN3GycH3MY3Pu99ctdJz1hyxqc4DdAnjtJmrbqus4ebRJm+tJEAHrgGVNKfpSc2WfxID7nC8xtEAl1IWdKqbVmZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0fgXmsKFV2BxVeLhnIu2GgXX11Qr5ZU/UI6snNAkOE=;
 b=JrYE3cNdzugYU2T/b7+S6ffZmUcmzLRM+k1mEFDenepUmGtNZr9nIuwVyjNZKfFjUzpAMLfKUVHNoH7ThUbKk9R43owBNJb7/MI4mncLw0bNFitzmQPAonz+ULJSNHwyOv/u7h/Vv0grNjeJktK/b1cLgW4Cmb16BKeNRP4AZsRWp/JtRGvrsFu03Ko0VN0zAzNgVjZVdK1do1uSov2Zc0Q9Ip12KGRXZuhcRGuvyTA7uhcfHJ7zYmeMxKigb9qDVAWsEVfB9awebI0PhyESftB7co9K7yb2v6sxSmRY+6IfF051CTMqPNj4lXD5eV+cdDVIXq8v62uujWzlgyPBVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CYYPR12MB8989.namprd12.prod.outlook.com (2603:10b6:930:c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Wed, 5 Aug
 2026 05:45:43 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 05:45:43 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 05 Aug 2026 14:44:55 +0900
Subject: [PATCH 08/12] gpu: nova-core: mm: Add support to use PRAMIN
 windows to write to VRAM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-pramin-split-v1-8-ff3e84a75dac@nvidia.com>
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
X-ClientProxiedBy: TY4P286CA0081.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::13) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CYYPR12MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc8a182-6bf9-4836-dc3a-08def2b4ca21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|7416014|1800799024|10070799003|3023799007|10067099003|11063799006|56012099006|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: MZkwF5LPmkxkuJxLQ8KUQ8tU7vF7w7Q5oQI3BhYAblzPU8QSenpvuMMpNOo4nx8JTd1SOaY1dGWoXitEUSk5nxxCnVE6vwmELScVD6Bzs8tlOU2bfVXwClbt4cP56g+HnNzgTRna3gX8tewXjamLrg0znpQSdty9xQCNagw35OVTSomD4UFau7nP2+gX/fUNMmysn2uYuhXUZhvomU1oWM9f/v8RnN5pzyzIVyfEPiYnf6fhhREyP2ynwJ0EdAtFYRPZMnbiTzIvCbA74bP4zKnCs2UItTItlSrMN2Z6BRVg4bvwy+8k2Qw0q6LiF+yz//cHyfJKPxxwdluVimIaZR4p4AvpqJ4s5+2nshTlk8bONhfkdyrw8cFSJnmH0CSOW+20aZWPePRG+FiXI+csT1du1v8AfyQWbvPD5ZjJcCb06N/F0eR6ibCjhVqQG11LplbKjCXwj4idW5i0eEGCeO29E3wYxvDgzoFogTaAY0PXV7zUBhi8UnUSCrY08/HOCdIpHD5x6QbIETLvZfH6WdTtGvNu3GteAMg1wK46vdAyw2EEfUB2ff6ulDIkmar4sl0uG5PkTZlr1neUHEdNPfDPNv/Ru50RtYhG2WodfDnwNQkAwhoPT26Wd/OKHhGfAw49Ph1OM0hp17aWx+re/WvBLD5VodArusqI6DQsUEhd8caH4+u/LA8V4KeMxo3aCx2OON+uo2HkzPSHKq5ZNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(10070799003)(3023799007)(10067099003)(11063799006)(56012099006)(921020)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3J3UkYyMTNyM1oxdzZXL0VZQUZ1dW9qMEM4UTJybExYQldYbDdJS2VzVkRZ?=
 =?utf-8?B?SlFNeDlWZk9iNGZFQ1J4ZUdqRjJ3RFJQZmtlVUxtY2Y0NVdFRXVHTy9vSzNU?=
 =?utf-8?B?WDFScHA0ZEdGWGxkYkw2OUQwUElPd3JMaVBBcGtxVXFlaVpJMjYreTZLL0Rw?=
 =?utf-8?B?N1BxSDhpNitTVFlpbHJqai9CdnV4MnFNaXQ2UVZBYXU0bkVHTTBqM0JKS3pT?=
 =?utf-8?B?YUFUNmlheXlGWUw0WVBURG1TaUJqSlo5OUJlYWIwR0x6QitRWi9jdHR0b0lj?=
 =?utf-8?B?S1hWMDRKWGJZVHNqQ256RzBsT09xK1prbTlYQURINHhQZDhvSjl5S3NMcXl2?=
 =?utf-8?B?Rzl5WUMvZmdVTEEvNWVZS1IvSFYvcUZ3T2pDekd1RzAwYWtmcTcxQ25LUjBK?=
 =?utf-8?B?UWdDSktST2xsSkJBWjZ6UXExaU1kSG9ENjlib2xhU2Q4ZWR1NTI4NjNMVkZD?=
 =?utf-8?B?V3lzQkQzaTlOM2tIMk1pZVVERzBaR2FaMmZFdUdSdWs1VGRoeTZ3ZDRSN2hy?=
 =?utf-8?B?L0pZRFVTL2xtSkJZSmxEUVVmR1pZdExqUnZHM2NkZHhjQUN3VjRoWDVyOE9x?=
 =?utf-8?B?cTVVZ0JKS1FWcFgzOWZEYWN6YmJaeWcveTJWQVY2RWpxYnlhN2N4eGVmNlRY?=
 =?utf-8?B?YTA2TWNsL3ZnbEMza3g1bHQvVVVuS1ZteHRPNTF4VUczV0JUZXFYN3RKdGZF?=
 =?utf-8?B?UGFyVTRSdnloMUNPdXFTb0ovY3F1Y1lLelJodlZPVk92bEhvc0hUaHZBRHIz?=
 =?utf-8?B?VHlLRlZCTDIrQjhvNUpvUCs4Z3ZJaFhEUFAyQU1tbGVSeHl1bGtkSnpMY3da?=
 =?utf-8?B?bkNJQnBBQzYzVVhXZCt4L08vK2FMb1Y3U1dVWk1RK0dsaUsvRVp0bWV0WWZl?=
 =?utf-8?B?N0J3VStYSmJ1bEdCNlNJUUFWMXFqRzlMbm00ejBZNWhpM3dlRnVCMWk0MHBa?=
 =?utf-8?B?NmdDNStSZkRYRFVsdVVKY1lGaTFRR2J6VzNuTTRVYmpVeWRZSjZwMEN4aVhi?=
 =?utf-8?B?R1oxMlpYVzNRblV6NkxzQnpBVzVDM1g5T3FGNDRhaDRvczBRd084SmxOeTZZ?=
 =?utf-8?B?a3EvbCtORFNvMDRjS0lUUUhuWDRJL0xabXQwMTZFRVkyWDczWDBXWS80MXdh?=
 =?utf-8?B?ejRuZ2xyRGZhWjNNdVFtNFJwbWlpdERvQ2FSNmJxbFM2Sk9xdWRFN1JybkxD?=
 =?utf-8?B?TWd1TDI3Ykdxa2RQOE91OE0vcm03RHNYVkJtSkNYbFU1Y2ZtQmQzM25MeXBn?=
 =?utf-8?B?Wlc3WkV6VHdCck5iaE95bXRaSzlzM1V3R1hhZEhIVndydUlDQWlKYnYzWGVq?=
 =?utf-8?B?eWJZU3RQejFacUFia2JYQXNhLytxMCs1dDNyVTlIS0ZiSnk5M2FSajk0MVlw?=
 =?utf-8?B?VElQU21ySXUwOFhwZHk0YUJCenNWQzFsdjFKUG52ZUpQLzFkS3Q1OGVVZEtV?=
 =?utf-8?B?OXh0TzVHU3ZyS1cwSC94ZFA3RlRmdHFJTFJaamdrWlRZRDltVEdNVW1oN3ZS?=
 =?utf-8?B?cGhwUlRtZ1JzV2xkOWNZdUNKanAxOGZJcXhMQzA0UVRNaWlwOTJMYXJpcGFk?=
 =?utf-8?B?KzdvR1lHYjdHZy9MdklsT2hDSXNEdk80N1RjZEc3VWJ1MVgzU1dsYkNKYW5v?=
 =?utf-8?B?WmxOd0FYR1ppSndCVjZXbkNvUEZuS1ZUVnhacFYxbmVMeVlPNHZHS3BpbXAv?=
 =?utf-8?B?WVdGTWFVSnNWeXNZTUJ4MGZiNGhQblpUVGFBWGw4R016bkU3WkY0NDhGQXlw?=
 =?utf-8?B?akJuS0RBdmNnejZpWFZVRG5YVnNZVU1WQjFiREU5WVRxelc4VjhWS1hMSDZ5?=
 =?utf-8?B?RHZLUlZpTXV0Mnlpc00vbmFNVzBybWtxcWM3cXpQaGp1VWFhQi9obkwwVzd1?=
 =?utf-8?B?emtUYzdHbnY5WkQxZmFUQ096OTVtRmZpQXVseUkxNldSVEI3MkNyaEs4VUVp?=
 =?utf-8?B?eUMwcEUwaENFTWIxVm1VN1RvR3VNTGhmSzBWcFpxS2owSGxBSUJ2NWZnNUh4?=
 =?utf-8?B?MU9VbFdFaDlUU0ZqT0xWeHlFeEUzRmNBeHQyL1hoYlBqdE5PYnljcG9LNkxM?=
 =?utf-8?B?aVc1VjVoYWU0N05ndG5STVZRQ25pNXpEelBaSURUL0pqZkJHVVB5Qkh0ZUUw?=
 =?utf-8?B?VEpGT0RXZ2tTYXBTNzhpMzcrVG92NjJnMlNLN1F4NkZiejkrK0w1czdTNEtG?=
 =?utf-8?B?MmVsaU1PR2ErZDlFMUdlMFZGcEdaTHR2b0FvRjJRZHpaUmVTbENIUjRndjJO?=
 =?utf-8?B?a2JxclVXMk8zUFlGc1RyRTZxaHpEclNuMXpGdWdyenJWZ3Q1ci9aSTBvSFYz?=
 =?utf-8?B?cGorYzRSUjhrNHRxUHZNRDU0M0lJM0FzN1B5NFhtbXhwOVpab0hsQlRJaEZM?=
 =?utf-8?Q?qgMZ0O2JMSFiWj4EuLyERTAVgH9z0h5HmeepUYqGu9CfD?=
X-MS-Exchange-AntiSpam-MessageData-1: JSwPMYsRPQ93jQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc8a182-6bf9-4836-dc3a-08def2b4ca21
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 05:45:43.3606 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CG3X2seCA+9gFwzjYxguFg6LLDTL11NTLndtFSznO72y0rd3/qdUgwiN1cokmJ+J0e0Ynbc3wosuKLM70DhiSQ==
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

PRAMIN apertures are a crucial mechanism for direct CPU read/write to
VRAM. Add a `Pramin` manager whose `window_at()` returns a typed MMIO
view of VRAM through the 1 MiB PRAMIN aperture in BAR0, validating the
view against the VRAM region and repositioning the window as needed for
the accessed address.

A view borrows `Pramin` mutably, so the window cannot move while
the view is in use, and it inserts an ordering point on Drop.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
[ecourtney: split the registers and HAL into the two preceding patches]
[ecourtney: rebase w.r.t. Bar0 lifetime changes]
[ecourtney: drop the window guard and mutex, use &mut self]
[ecourtney: position at init to avoid reads, reposition in window_offset]
[ecourtney: return typed MMIO views instead of read/write accessors]
[ecourtney: insert an ordering read when a view drops]
[ecourtney: rename the aperture constants, drop the doc examples]
[ecourtney: add the copyright header, doc and naming cleanups]
[ecourtney: the pramin module is mm-internal]
Co-developed-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/mm.rs        |   1 +
 drivers/gpu/nova-core/mm/pramin.rs | 156 +++++++++++++++++++++++++++++++++++++
 2 files changed, 157 insertions(+)

diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index 07dce4ce2473..ef5b1cad56c3 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -20,6 +20,7 @@
 };
 
 mod hal;
+mod pramin;
 mod regs;
 
 /// Physical VRAM address in GPU video memory.
diff --git a/drivers/gpu/nova-core/mm/pramin.rs b/drivers/gpu/nova-core/mm/pramin.rs
new file mode 100644
index 000000000000..2aa1bca22fa6
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/pramin.rs
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! Utilities for accessing VRAM through the PRAMIN window.
+
+use core::ops::Range;
+
+use kernel::{
+    io::{
+        Io,
+        Mmio,
+        Region, //
+    },
+    prelude::*,
+    ptr::{
+        Alignable,
+        Alignment, //
+    },
+    sizes::{
+        SZ_1M,
+        SZ_64K, //
+    },
+};
+
+use crate::{
+    driver::Bar0,
+    gpu::Chipset,
+    mm::{
+        hal::{
+            self,
+            MmHal, //
+        },
+        VramAddress, //
+    },
+    num::IntoSafeCast, //
+};
+
+/// Size of the PRAMIN window (1 MiB).
+const WINDOW_SIZE: usize = SZ_1M;
+
+/// Owner of the PRAMIN window state.
+///
+/// [`Pramin::window_at()`] repositions the window as needed and returns a typed MMIO view into
+/// it, holding the manager borrowed for the lifetime of the view.
+pub(super) struct Pramin<'gpu> {
+    bar: Bar0<'gpu>,
+    hal: &'static dyn MmHal,
+    /// MMIO view of the PRAMIN window in BAR0.
+    window: Mmio<'gpu, Region<WINDOW_SIZE>>,
+    /// VRAM range to keep the PRAMIN window inside.
+    vram_range: Range<VramAddress>,
+    /// Cached window position.
+    window_range: Range<VramAddress>,
+}
+
+/// Typed view of VRAM through the PRAMIN window.
+///
+/// Inserts an ordering point after previous writes through the window on drop. Views returned
+/// by [`PraminWindow::view()`] cannot outlive this access, so the ordering point covers every
+/// write made through them.
+pub(super) struct PraminWindow<'a, T> {
+    view: Mmio<'a, T>,
+    window: Mmio<'a, Region<WINDOW_SIZE>>,
+}
+
+impl<T> PraminWindow<'_, T> {
+    /// Returns the MMIO view of the accessed location.
+    pub(super) fn view(&self) -> Mmio<'_, T> {
+        self.view
+    }
+}
+
+impl<T> Drop for PraminWindow<'_, T> {
+    fn drop(&mut self) {
+        // Insert an ordering point after previous writes through this window.
+        self.window.read32(0);
+    }
+}
+
+impl<'gpu> Pramin<'gpu> {
+    /// Location of the window inside BAR0.
+    const BAR0_OFFSET: usize = 0x700000;
+
+    /// Alignment required by the PRAMIN window.
+    const BASE_ALIGN: Alignment = Alignment::new::<SZ_64K>();
+
+    /// Creates the window manager for the given VRAM region.
+    pub(super) fn new(
+        bar: Bar0<'gpu>,
+        chipset: Chipset,
+        vram_range: Range<VramAddress>,
+    ) -> Result<Self> {
+        let hal = hal::mm_hal(chipset);
+        let window =
+            Region::try_subregion(bar, Self::BAR0_OFFSET..Self::BAR0_OFFSET + WINDOW_SIZE)?;
+        let base = vram_range.start.align_down(Self::BASE_ALIGN);
+        hal.write_pramin_window_base(bar, base)?;
+
+        Ok(Self {
+            bar,
+            hal,
+            window,
+            vram_range,
+            window_range: base..base + WINDOW_SIZE.into_safe_cast(),
+        })
+    }
+
+    /// Check the window covers `len` bytes at `addr`, moving it if needed.
+    ///
+    /// Returns the window offset at which to perform the access.
+    fn window_offset(&mut self, addr: VramAddress, len: usize) -> Result<usize> {
+        let end = addr.checked_add(len.into_safe_cast()).ok_or(EINVAL)?;
+
+        let inside = |r: &Range<VramAddress>| r.contains(&addr) && end <= r.end;
+        if !inside(&self.vram_range) {
+            return Err(EINVAL);
+        }
+
+        // Reposition the window if the access falls outside it.
+        if !inside(&self.window_range) {
+            let base = addr.align_down(Self::BASE_ALIGN);
+            let window_range = base..base + WINDOW_SIZE.into_safe_cast();
+            if !inside(&window_range) {
+                return Err(EINVAL);
+            }
+            self.hal.write_pramin_window_base(self.bar, base)?;
+            self.window_range = window_range;
+        }
+
+        Ok((addr - self.window_range.start).into_safe_cast())
+    }
+
+    /// Return a typed MMIO view of a `T` at `vram_addr`.
+    ///
+    /// The size of `T` must be a multiple of 4, as required by [`Region`]'s type invariant.
+    /// Returns an error if `vram_addr` is not aligned to 4 bytes and to `T`'s alignment, or if
+    /// a `T` at `vram_addr` does not fit within the VRAM region.
+    pub(super) fn window_at<'a, T>(
+        &'a mut self,
+        vram_addr: VramAddress,
+    ) -> Result<PraminWindow<'a, T>>
+    where
+        T: FromBytes + IntoBytes,
+    {
+        const_assert!(size_of::<T>() % 4 == 0);
+
+        let offset = self.window_offset(vram_addr, size_of::<T>())?;
+        let view: Mmio<'_, Region> =
+            Region::try_subregion(self.window, offset..offset + size_of::<T>())?;
+
+        Ok(PraminWindow {
+            view: view.try_cast()?,
+            window: self.window,
+        })
+    }
+}

-- 
2.55.0

