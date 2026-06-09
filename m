Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23EE6CD8CAE
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:04:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C38510E16A;
	Tue,  9 Jun 2026 08:04:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="SL0tsxej";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012064.outbound.protection.outlook.com
 [40.93.195.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C359E10E16A
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 08:04:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uWyA/1rje6WPJSG1fooRa0U05/qrNQy2qYehkdZIH+IoPuoldKfyF2fqgqBjDOn4Jc3Ttc9m2CuIkKJdhmGRLFOt4Hht5AKvuUWkUbcvQQl8+n9G3F0AyK1ex/3OVr4x7Og1iGOoJ6VMUqyQTiDu0GMvjsKSgzSUIErLiLPg3OBMeO6TgmEf03QkSPZ0FBFzZtRN8J/2rCCj280P0nOCLbRKf+3G8wKRngw4YIsxinBz04ZLtQ2I6ciICg8+ujAGYv/zCiKtFAQEjXhLozUXoe1KHuIE+jpeJiHqzXbcs7Xtxf45vZiE8eeYrR1hStDBnH7mET8bYrxst0theL5Y1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHU7Fr2kuxPwpVSAmgjnenAffxN4ui13RmIPGr0iZ58=;
 b=H3HuTt1lii8/LnEyfcYJjnrh4JJqfHSkgurHMhX1vg0qXEFsXBTrlUE0a++aR5lU7W5GcHZaxqb1kBPTsTLJHqw8i0asID2Inp0mAEFQ8/H9YoN2h9qeNjcBWz6H33hx/4BmHaeKvNoEy0fK79S8M66gKa+8CO8vsTfKZJjlUnkctKlIXfnGvEVqdcjYPl4nZxdHTm4NAGtFc/7SMWHDjaospd77f5GrV1dSl2hWkIwFTZflhD2+nHjgXBuOAw0py+RwO3cFienVkv6F624URi+QqUkCDc5ck1u5MgbfkaE/+h5rrzCFsV2Dkmr3FmQshdvpjN/+OsukvwfkUxsr1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHU7Fr2kuxPwpVSAmgjnenAffxN4ui13RmIPGr0iZ58=;
 b=SL0tsxejsVTX28Pr3fZzXllIbTAYMv3FYITGo0nOY5Duz7lERGngdOPIsyZkNeugRSObA9VTMKoZbY5htI8V9SoqyA7defGTAe1EvQiP0O216afMhHfprb7lbGH1tkDEj7Fwmd9OTckUkdgH1D60pZZJTIOlCOYPuU2kVazrskep9EI3ncU6GD3CLZF1xveh+pVQI+M+072rJ+5Y9TIoek0APUsV6Gm3h+qr2vnHFTbD+dqmIhA3z1iVzf7LvtMqb1e2osDoxSn1ASZRBf97x10Ct2TR2SpV1IS2mu8r/lOZo1x2FWL6cLBCVjBQ1HOFp6vlJ5PanUoqvG0nUwOuLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA1PR12MB5616.namprd12.prod.outlook.com (2603:10b6:806:22a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 08:04:17 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 08:04:17 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 09 Jun 2026 17:04:01 +0900
Subject: [PATCH 3/4] gpu: nova-core: gsp: Extract usable FB region from GSP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-boot-vram-v1-3-d9382610507a@nvidia.com>
References: <20260609-boot-vram-v1-0-d9382610507a@nvidia.com>
In-Reply-To: <20260609-boot-vram-v1-0-d9382610507a@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, John Hubbard <jhubbard@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCPR01CA0126.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA1PR12MB5616:EE_
X-MS-Office365-Filtering-Correlation-Id: c5730ea9-5638-41b0-e372-08dec5fdb3d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|7416014|376014|22082099003|18002099003|6133799003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: /T3dNDfjHN/1F94NpOVE5suaCMBXkqJGzKhgvS8DQSHvQ1HtNNcxwOFbv8mF4YxX7CM6vaCX6dlG1ocQ0z541RSKynJ1sglglf4jTiGO2t+lZvvB7SB0HhadMH5pu7P4cOSsH91ML4+59WpOnHZWoZKvzR/aStadnitZQtv1bytBnIkFqx9f4iRr6KHyLfbMihJnwwJqXznI5yAuoVag0HFjeaDUo750NNDh5DEswN3I9LDGMaAXCsx/5amWLAS1u3NXjw6dKhnzzVhra8/86+fKi5kWsvnL5o21rQtZctgtQv86ZUfSpGgxrnY0PYEgDt4fG8GJdMcn803BH9meWfzKRJpShGgtqpdwQW5ddhiCkQJRXA4lmob6pskGxzO8oirNtyMw1jhK8XBS/C6ezE+/n0Sr2nT8RcR6kfJqSolqk9wqUZhPPQo5Ep0JiXd0L3vlhSCQ+ZWGzF9Ua4leFoueQ6825j/ngONIH/YBWKPQXZjf4wYGNilxgOv6eFxvGdMc3MthxbqArEBzJj0WnEdcKE3QMglYtoglWeGL+hXDJ9hRLR7oB1oe5XfgBnNooUCHrZzqiFfG/7cgd1zUFGz38jWVElHMynLH9jCtutqRu6ovMfMbmaiurYROmHAera1a9aNRk+SU7yF+RJEDPMEUcekGvgKUSEMofky6O3CrM9pI+/Xbi2WrlJF+DCzn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R25ONjNaczlEUjdydFNEZTdKOXJuUVNDY09KWnZra2tRQzNtUHhpQXFERzg1?=
 =?utf-8?B?cUhSKzUvYlFHSlhEamovc29lUi8yRW5jRjdDRU5lYVZ4RDFad2puNGw2YUUz?=
 =?utf-8?B?Z1Z6MmZHbTJiZnpxbjFvc2xrSkdNQkdYNWVpS0xJQXFpMzhKY2pHN0tsQ2l4?=
 =?utf-8?B?RkpVNHhuVUs5OWxnajdwTkhxT3dEa2dtR1U2WDF3alc0Q0FtU055dXJHQll2?=
 =?utf-8?B?NTBNaVNoOFh3UlAva2JDOTIwYm1PYjZZL25GVnYyS3p3RHlicWt4V3FsclhV?=
 =?utf-8?B?VUpCQW1oQWloZVJQL1hKTFdzTUZQclloaGl6SFp0TEVOMEl4SmVUSDFXZzFJ?=
 =?utf-8?B?bjN0c2tkY2ovNjN2RGJ6OEJUM0xmT3JLMkpTSHMwbWdKUGxHZVEybzJMK3dF?=
 =?utf-8?B?VkNVK0c0dmlIcDdSMXkrYVhJc0Mrc1U3L2RHcCs0OTFoeVNTdi9kWkZLaE14?=
 =?utf-8?B?UWlwcjlQUWdoTCtGSndFQzlWaUN0K1N3eGY1NU5iME9TVitDR05PQVd0MkxB?=
 =?utf-8?B?ckJvS1U5a292bTY5cmxQQk5pMXhhajhxY2owNFhycmFjMjhCdTVuQUd0NGt0?=
 =?utf-8?B?WWlDcEozVDJVdm1nWWVDRUtNQlB4MEsySHdYMExhK0thcEt1R0tQMkFOTkNE?=
 =?utf-8?B?QUo2Q0s5YTR2Zm45MGk5SEZwTTlocVdVM0xIUkpseWMwWWVHcitqRmNzUUYr?=
 =?utf-8?B?RmxCZW9kM2RpRjVpeHVsV3orbGdjZ2VmMmEvN0RrZU5GMGl6ZUVSUThSQlM4?=
 =?utf-8?B?ZFc4d2dzeEVmZFlQUENIaWRueDdTdUxiNFJoZlkxVjZGd1BPSTUzMzFLZmU3?=
 =?utf-8?B?K1JTUXJFanNFN25pT2J0VHAraFZ6aVJxZDBrZUU5dEZMbWJIbzdkRnhkRVg1?=
 =?utf-8?B?OVFpaGZDNkJHTG1MMHlwN0pmZTBQWWg2LzdGMStJejVCaDB0ZGRZZE15UWdp?=
 =?utf-8?B?SzhGNmlnYitZR2FqWTRXRHVjdndZL3BwUUQrYngyV3NheXNtR1YxSjM5OE13?=
 =?utf-8?B?cGlGZjcxMHdnYUg3V1ZIRlRMWlkzY2pVWGE3WEJ4MDJlRWpkTmhSMDBKSjVP?=
 =?utf-8?B?SGZRd01Uek93TllHUmJ6ZzF3WlR5V3hOajdWY045OVZleTZlU0crVXJCdWhr?=
 =?utf-8?B?UWhGcDdnWGVlSG5IU2I1YnVhY2gyMGN0SzEzNTZ0S0d2UUhvVTRlT3BzSk1I?=
 =?utf-8?B?SkxBc2lQSkN4dlNtVXpnVVhacGhNaVNpZC9PQVlIaDZMeVAyVzBRaElEYjg3?=
 =?utf-8?B?aXZZbjRWK3ExRjUyS2x3V3JtNXByOUswWm52MnF6MzZEZ01XRGE5YWlsa0ZR?=
 =?utf-8?B?TlZSWXc1WXFvNDVON1Jmekc3elUvbmJQTkYxbDFIYUZaVVd3ZVN6aHdoVGZx?=
 =?utf-8?B?UnEwQVFzbitsbm1GVTJjTGZvWHNHcTFtRDhORkhoeEdOb2txMFhjbVFlN0p1?=
 =?utf-8?B?K1JmUEdJeEhKeVVRY0IyRUllbnJYZWxMRExhVjdBTHltQU0zNGtTdUJSKzNx?=
 =?utf-8?B?a1V3UEJ3UmdlSXRMTkNLR0RHTGVCVVJDVVJiT1Yzc0s4V2NBS0NTVDA5UjJs?=
 =?utf-8?B?K0Q5ckZJRStReVpvT0tWU1RJcU5iY29ncWxRbDBzeFNwU2lGOFB2Y0pXZGh4?=
 =?utf-8?B?Q0tNWDF4dnRGUjJsWW1hNmFYdjAvdndSMmcwZTlZR21IemN3NmxuZ2FjR3Bu?=
 =?utf-8?B?azc2MmVGL3NPdE1WUmhDSWxSdTlJekkyeElLQ2JJanhUT2RZVCtPWVNNUjRW?=
 =?utf-8?B?MDhDVUNCdS92aUFMMEhSeU9od2VFcStXdFVDbVhYMDNhOHRIRmRDTEpuSTlI?=
 =?utf-8?B?V09hOVJkU05acWlXUE5HWE1NWDNmZjN5NzJ1dk1LOUZORHZRTks1VHdPTHFD?=
 =?utf-8?B?a01vSGxBUEFHTHFMeDZFZ201N01GSW5rS3hKa2NWVmpxQ1pVVXhYYjdKMnBV?=
 =?utf-8?B?YXYxcGFYUjgvcHBCSWE4dU91QklHR21JN3RKRVRQVU9JUWorOUdaRXRYcW5S?=
 =?utf-8?B?YlpCVnYrdmtyZ1VWQnFDZStCU05RNW5wTXV6TjlRUWVhdWZxc3piSzRjM2NE?=
 =?utf-8?B?UTNvNTkxMHA0azJneUNFZEFKRlZkNmFaNmxnK3dJcG1qYXNhazI2QlpDTmhi?=
 =?utf-8?B?a1RTT0pLbGhldCtGaERrbzFab1lRei9lZTh5elRkZDdmc0MxUE1ta3hEaGVw?=
 =?utf-8?B?WGhMV0RsN1lQVDIwMGNHc056a08vc0tWR3VYcnNyTzVkTjV1MHg2M016a3Jv?=
 =?utf-8?B?SDFCOWVxWWRrenRFU2pJYVJHd2crQmhUank2SVJoWVA4TFhVbjlPd0dnOW13?=
 =?utf-8?B?UkY3NmRmV0JmWVJUUGcwOExFS2dhUVR2YTRjYXJoaFY5bnNOb0NUZVZpWjRz?=
 =?utf-8?Q?ldlfjD5pp4KMPt/BqHlxK/MuPTwl1tHuA5/7osusjNFmz?=
X-MS-Exchange-AntiSpam-MessageData-1: GtCU0nBCM2Vzgg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5730ea9-5638-41b0-e372-08dec5fdb3d9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 08:04:16.9488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oo5AVEEvhpFWAGI2cKLGYKqZ03+YtGSePIlqL22ZPY0G/Y2AkJPnTkmHpGJWwDQKhud9v8ixEQqdT7gkIKvVCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5616
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

Add usable_fb_regions_iter() to GspStaticConfigInfo to extract the first
usable FB region from GSP's fbRegionInfoParams. Usable regions are those
that are not reserved or protected.

The extracted region is stored in GetGspStaticInfoReply and exposed as
usable_fb_region field for use by the memory subsystem.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/gpu/nova-core/gsp/commands.rs    |  9 +++++--
 drivers/gpu/nova-core/gsp/fw/commands.rs | 40 +++++++++++++++++++++++++++++++-
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index f84de9f4f045..d955f52a93bb 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -5,6 +5,7 @@
     array,
     convert::Infallible,
     ffi::FromBytesUntilNulError,
+    ops::Range,
     str::Utf8Error, //
 };
 
@@ -191,15 +192,18 @@ fn init(&self) -> impl Init<Self::Command, Self::InitError> {
     }
 }
 
-/// The reply from the GSP to the [`GetGspInfo`] command.
+/// The reply from the GSP to the [`GetGspStaticInfo`] command.
 pub(crate) struct GetGspStaticInfoReply {
     gpu_name: [u8; 64],
+    /// Usable FB (VRAM) region for driver memory allocation.
+    #[expect(dead_code)]
+    pub(crate) usable_fb_region: Range<u64>,
 }
 
 impl MessageFromGsp for GetGspStaticInfoReply {
     const FUNCTION: MsgFunction = MsgFunction::GetGspStaticInfo;
     type Message = fw::commands::GspStaticConfigInfo;
-    type InitError = Infallible;
+    type InitError = Error;
 
     fn read(
         msg: &Self::Message,
@@ -207,6 +211,7 @@ fn read(
     ) -> Result<Self, Self::InitError> {
         Ok(GetGspStaticInfoReply {
             gpu_name: msg.gpu_name_str(),
+            usable_fb_region: msg.usable_fb_regions_iter().next().ok_or(ENODEV)?,
         })
     }
 }
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index 7bcc41fc7fa0..d025167927df 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 // SPDX-FileCopyrightText: Copyright (c) 2025-2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 
+use core::ops::Range;
+
 use kernel::{
     device,
     pci,
@@ -13,7 +15,8 @@
 
 use crate::{
     gpu::Chipset,
-    gsp::GSP_PAGE_SIZE, //
+    gsp::GSP_PAGE_SIZE,
+    num::IntoSafeCast, //
 };
 
 use super::bindings;
@@ -129,6 +132,41 @@ impl GspStaticConfigInfo {
     pub(crate) fn gpu_name_str(&self) -> [u8; 64] {
         self.0.gpuNameString
     }
+
+    /// Returns an iterator over valid FB regions from GSP firmware data.
+    fn fb_regions(
+        &self,
+    ) -> impl Iterator<Item = &bindings::NV2080_CTRL_CMD_FB_GET_FB_REGION_FB_REGION_INFO> {
+        let fb_info = &self.0.fbRegionInfoParams;
+        fb_info
+            .fbRegion
+            .iter()
+            .take(fb_info.numFBRegions.into_safe_cast())
+            .filter(|reg| reg.limit >= reg.base)
+    }
+
+    /// Iterates over usable FB regions from GSP firmware data.
+    ///
+    /// Each yielded region is a [`Range<u64>`] suitable for driver memory allocation.
+    /// Usable regions are those that satisfy all the following properties:
+    /// - Are not reserved for firmware internal use.
+    /// - Are not protected (hardware-enforced access restrictions).
+    /// - Support compression (can use GPU memory compression for bandwidth).
+    /// - Support ISO (isochronous memory for display requiring guaranteed bandwidth).
+    pub(crate) fn usable_fb_regions_iter(&self) -> impl Iterator<Item = Range<u64>> + '_ {
+        self.fb_regions().filter_map(|reg| {
+            // Filter: not reserved, not protected, supports compression and ISO.
+            if reg.reserved == 0
+                && reg.bProtected == 0
+                && reg.supportCompressed != 0
+                && reg.supportISO != 0
+            {
+                reg.limit.checked_add(1).map(|end| reg.base..end)
+            } else {
+                None
+            }
+        })
+    }
 }
 
 // SAFETY: Padding is explicit and will not contain uninitialized data.

-- 
2.54.0

