Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 762EDCD98EE
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 06:43:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C977810EE48;
	Wed, 17 Jun 2026 06:43:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="TPKB7wti";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D822F10EE3F
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 06:43:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hbGBKu84ZwEY0SD7XCx54FufEaXGjql2A0sIrmxzFKex8hNxAW1J2gcMdSc/DENClGoxgtIzMszssOsYqtu6SYeM+mOG0k5vkxaxF/HOOeBYNJhcr1+TbhKjG7Mc2T95X0aYinqu28kgkEM2MiW5hYbEwHSrOSCN+xPCSFdWGF6sV8L2yFJecv3n+Sln3qWNBGimcDu/irM9fzgQ9M9U3sSjrRDauamA303PIgiH19K5ZGv8FfPpFZzz9WzYSfxoxFrBLFxXAy22AJQ5z+BM8X461nigkIWuqa1E25sG+Bi2HQrtZBBfhawGJrJiMgU07/0yKqRCCHT2On/X/MYKCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eY7XpQuDIx3/F+b71ymzl5e4+uqZ+vll8Hs3pX/rhZs=;
 b=sD8WzexA++u4TM3C1bxjJ0RaTonk6MEu7IxuwiuJoKWVOtePnjF8nOZiSmkLXKa/xnDtUiNtL7eiIeG0uv7tVpi8aC4xsBJ9mpvN4NCb5OABKk6pie0w7xDChGZLqduVPhhBggM/kuuKDfpLsMoR7bggDYigyn1hb7VSPEi2gj417diNP/qAXwiS2sGAT7JqS3b+zLF4jzMbWdxwGS0xIrF2XjCZMh7zRE1FrIkUfAOkJPH+e1zj1v2QNyfcL6seKdo8fqss+ykckZk61rwiuP8uS0SJifkHyBludfoFziVbrl65n1ewDmwICOTVC6pOuGNGRBBAhl0CYaOLFnHw6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eY7XpQuDIx3/F+b71ymzl5e4+uqZ+vll8Hs3pX/rhZs=;
 b=TPKB7wtir+lTo2t8u0JqKT8d2nTkfUaWwPotQxSN/5zC5UxrI25zqxS8/zzSTPIsBloawZ23KbIf3eDUB6xdEHl7D10nFSbn3fkUXUpzAl6m+wQhKx1K0cCUh6IwKLadQFqQ6UdQY3ZUBfvSwtFvGjBXbh5inb95M+BOAt7iyQ93uEhkBzoqhUpM8zFqcnRtz3UL/v/32Dkv+MESf8cV5FpTFd8B/lqmLMwAu2lB2GZFrN5+V8N2/nEH3sNxgIyQak/8zRLB4CzdK5SVgSNjw1hNtS06LE2hyeIzTR2qmLQh9HSal7acWyWj34KVB8Bta/NRPKLVhGV+rPceiBp54Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB8272.namprd12.prod.outlook.com (2603:10b6:8:fc::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Wed, 17 Jun 2026 06:43:28 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 06:43:28 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 17 Jun 2026 15:43:13 +0900
Subject: [PATCH v2 3/3] gpu: nova-core: gsp: Extract and display usable FB
 regions from GSP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-boot-vram-v2-3-15c979001c70@nvidia.com>
References: <20260617-boot-vram-v2-0-15c979001c70@nvidia.com>
In-Reply-To: <20260617-boot-vram-v2-0-15c979001c70@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0348.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e0e14a5-8bea-4bb6-02c1-08decc3bbd0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|23010399003|10070799003|1800799024|56012099006|11063799006|6133799003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: GVuWQeIluFkl5GCyUX4c5fb5dDGU00hKxxNqOewkqAtvMcZ2sBOR8UVQs/F+cbYJ3qlJkV7y3m4McTUeVH9tBLWexh4lTOxGHPZkfQgo1UcUZIlEcCE63CDrQ4i1SnPRT88I8RkBy/MBlue36st1Ck1eTsaKRoP8jVpuXDa7wwOPejoLYTwjgs9DtimalXkVyiRGDdaYNFDMHRrNDrkGRE21DPKQQYMrxeJnQKDDtbxJjzVFamgoiCr/Fdej9NeNQ6HSYg9QH1vyuSIcZqwwuNJyV6ARuDs9wvJumAXLgV31lq31WL0mc/dvlSq6Zmc0fPR42xfCPH34POsWk7ZftpRJhVIw5sSiPg5m6i2zaF9udzbXWCdVTxn6pRHVSHFiz3kSgLp+kbwHh0ljexQbK+8tK6fxknzLOcodcxwbqscAOuZEQhGMn/ocgSmLLpIa1ybvYIbSouV1i098xdajnEownJDhN5JLTLdwDNv5BcuHBkpRxs+WNmp5TbKN2GwvjuN7q7u+/vrrhhZT7W9h7SLR6+R5hR3rU+5mOF8LbZPKosWX//wnYoI49uWQvVzrH1YtKO+jZoM4NQvCpVKTQiIkRcTjU18XqFrWplGLVG7zaf10UBAyVh0OC2rytHXb56aqGdrgt2/qmBfR73xac7jDnaZuj9sqCX5IiOzimFTPI+6ffNvvhQ7AbWIjWtpp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(23010399003)(10070799003)(1800799024)(56012099006)(11063799006)(6133799003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0Nna1liWlJKRUJVT09CSVEwT2VPK2NOb2l0djFRSkptdTlqdDRpOUFHY01H?=
 =?utf-8?B?dWp6dVAvcTFoNHRkYWV5SjZVbXBaVEdlV2hzMXJubmEyMnJvSVl4UStCSklo?=
 =?utf-8?B?OUJhRWtPdFNpYTFOTkVRRllmVDdZcWI2UHFIZzNrcDFmTUtYakIzQVJWVlY0?=
 =?utf-8?B?RStuNjVLY0dMb0pjVllvOE9vdXVtcDRKcUVsRzdnZGdQNXhYSXdyMVVxYTBS?=
 =?utf-8?B?a2M1N01OVEZ2MXk2SlNFZE5TZ1JzY1ZObExEOWJBQlZYTy9PbiszMTdwci9v?=
 =?utf-8?B?NXVoQjdUSWtleCtvTTBtYXZRL09IcVBna284eWQxM3ZxMW1FNWU5WCtYSnZ6?=
 =?utf-8?B?WmdSSnVaQUV4eSt5N3dvSkdsMzZ3Vi9WVEhyb21yY3g0cVl4Q1NmTWo4NDhr?=
 =?utf-8?B?WWpiZDFTcnBqM0R2eEFWZDg5WFo0V1hkUVRkZWhWMkJjeDBEK3hPdHE1ZWVY?=
 =?utf-8?B?WEhySzRYY1ZrRW9FUHNQbFR1eXlaZFZxcGw1RmZSd2JKMlJYVXI5dFFPa05a?=
 =?utf-8?B?QytnMkVDNTNCS3dxQ1JiZVpzcnZuL2F4NXBkVWw5QUNSRVJUQmo2OFNGNk00?=
 =?utf-8?B?bEtqL3I5ak5CN3NKMklmNXZGQlVCenluanhrZWdXQ0kwT2Nvc1ZaS3Qwb0lq?=
 =?utf-8?B?Z0VvYjlIM0RXc1lWb2tsdmw2UlBPSnFiU3lEc0V3Tk9uVDJYTTk1S3RzNkxN?=
 =?utf-8?B?ZStOOUM3dm16dllIenk1YnVzWmJmU0ErVmFUck9ibHU2d2RlT0RYMGZVMnNR?=
 =?utf-8?B?bFlUQmhFTW9GZjRlZDUvdUxJWmhZdXdWQU14aTl6RWJCbUVNSE1hWHZ5cWhR?=
 =?utf-8?B?L0wxYnlQem1hTUNpRGtBN3A1SENsUjdrVldiczQ5ZnVlWjhSODFGZUtScWNV?=
 =?utf-8?B?VHVuZC9ZUGNiMDV6aHhyZ3EwRG9TOER4N1VFZGp2Zk9UN24wSUhGNUIvSUVw?=
 =?utf-8?B?Z3IrRnN2MDd3UXhaYUVGQmRveFR6R0VtbTBZaEdodFh6aGYvck9XdFEzcmw0?=
 =?utf-8?B?d3MwbXF4aFZ3TUl0WlVnOXdrSGlxS2RiakJ0b05WTnNZZkJTVDRveHVrbWsv?=
 =?utf-8?B?cjFIZDBlTm9ZNTgrcjZUeUVmSDRNcEsxVmQ2ME53VndtUHdJYkVSOW5iQ0Zl?=
 =?utf-8?B?Z25HWWkvNnRyV1loZTN1N0pBYmZ2SHhjS0JmNG9SSE1UNjRQZXM4czhqWnpa?=
 =?utf-8?B?MGdMTXpzZHh3Mlk5LzVBUzhPMUNqb0RGNUJzdjdna3Flc0FmSmxaL0RFT2ov?=
 =?utf-8?B?Y29YNUl1VzgxWlNwSUZZUVJJWElSU0NveFU0RjBzVzdocHl1UmFadmNWeDVU?=
 =?utf-8?B?Tng4WVZyYlpsRys3RlhqLzZBWWR1NGFuNWhSYmdOamV6L2ZmOXE0aVBQbU0z?=
 =?utf-8?B?dlcvaXAyOWdrV3ZCa3A0eVFNUDFFMWlPT2ExWWU1WmpVbVFMWG5iTUtzWGxx?=
 =?utf-8?B?a3pTVmZhUkxVMUxLelB2UjdURFBpZUg1b3R1L2hFM2JHY2pCd2FFKzViMmpD?=
 =?utf-8?B?cXFoaGIxbm44NTNFVk9Ia0dsZHJKNjhETFRwdTFUbnBGc0ZEL0QwVXBMb3ly?=
 =?utf-8?B?QWEzTUNhbmUxSmd5Ykd5TVltZTFieU1ST2V2Q24rUDU5VFJZcVNWRVNMU1Br?=
 =?utf-8?B?RHA5RjhWYlU5WDRwcXJrM1VqakR1YzBkNzJnbG1RQW9rWTlVRUdtWHI3VjVu?=
 =?utf-8?B?TTlmYk5IZTdSZDdsK1FmTDVhK1B6eEVGNTl3cW4zU1Q0dHYxbXFBL1gveEp0?=
 =?utf-8?B?b3FNOU1aSWNIdkdQSysxRXM4MzFNNWRhQTlHL1hXRzVqZzIrZjZVTWl5RkFB?=
 =?utf-8?B?UGNuYVhZWmFPem91Q1BXOGhMTVdFZGJHS3VUbGx3L1JjVlZaVHpQTWV2ZUZ6?=
 =?utf-8?B?THlWMStwa0lIeGVrODI4VHJGRlJIVEhadGl5UEFzNWtoK0p3Q3lSazVQNnpV?=
 =?utf-8?B?eU4xaldHTVdCeE1ieEtJYmhaaGFkUnYvWXRNZmFkK0pHazBhYTJodmVNZ3kr?=
 =?utf-8?B?NHY4ZkxFbWhwa3pvWkVRbW1DYjNicEJMM0FYZE5yd2JvQXpEK3J0OE5xdWVX?=
 =?utf-8?B?ZW9FaFRoMDNtcVhIQXlKRldyQUUrTFo1azN1UGJucC94bk1CRmoyVlRXcG94?=
 =?utf-8?B?dEdkVDJqTGZKbVREOUtNSmhoVGRCR2hUUlpwOWFJRTNkTGtRYk1oN1N2Nnht?=
 =?utf-8?B?eC9rYTh5eGtFR0xlN3l2Y3pmTmlzeUREeGYxWmRBZTdVblYrelhNbTRxU2I3?=
 =?utf-8?B?bFZGRmRQTEpNZ3ArdVphbkNrN1lUenRlNDN6ZXJvVno4MzhsdlNZWXAwRisy?=
 =?utf-8?B?SWVJWnBmUzI1RGFpWDZ6NnI5UytFTXBjOEpsenRwNnlIMmptblNEdmZaSXEy?=
 =?utf-8?Q?RxuHx44oCckRrix6HaXtzC/GUWzrxiKiWPX/q7gfmWVl5?=
X-MS-Exchange-AntiSpam-MessageData-1: yB4lNTBgsojS2w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e0e14a5-8bea-4bb6-02c1-08decc3bbd0c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 06:43:28.3774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tY4j9BfcEv4lc8yFBIq9BnB/ISi+rf7CbVqtHoKvI4q75Y/WVZsK6q3W/3ICt5YD1xqMVSasFpg45MgErJayHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8272
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

Add usable_fb_regions() to GspStaticConfigInfo to extract the usable FB
regions from GSP's fbRegionInfoParams. Usable regions are those that are
not reserved or protected.

The extracted regions are stored in GetGspStaticInfoReply and exposed
for use by the memory subsystem.

Display the regions and their total size upon device probe.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
[acourbot: expose all regions as a KVec, display usable regions and
total usable VRAM.]
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs             | 18 +++++++++++++-
 drivers/gpu/nova-core/gsp/commands.rs    | 13 +++++++++--
 drivers/gpu/nova-core/gsp/fw/commands.rs | 40 +++++++++++++++++++++++++++++++-
 3 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index a02a86f556e7..075821f371f7 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -9,7 +9,8 @@
     io::Io,
     num::Bounded,
     pci,
-    prelude::*, //
+    prelude::*,
+    sizes::SizeConstants, //
 };
 
 use crate::{
@@ -370,6 +371,21 @@ pub(crate) fn new(
                     Err(e) => dev_warn!(pdev, "GPU name unavailable: {:?}\n", e),
                 }
 
+                if !info.usable_fb_regions.is_empty() {
+                    dev_info!(pdev, "Usable FB regions:\n");
+                    for region in &info.usable_fb_regions {
+                        dev_info!(pdev, "  - {:#x?}\n", region);
+                    }
+
+                    dev_info!(
+                        pdev,
+                        "Total usable VRAM: {} MiB\n",
+                        info.usable_fb_regions.iter().fold(0u64, |res, region| res
+                            .saturating_add(region.end - region.start))
+                            / u64::SZ_1M
+                    );
+                }
+
                 info
             }
         })
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index f84de9f4f045..86a3747cd31c 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -5,6 +5,7 @@
     array,
     convert::Infallible,
     ffi::FromBytesUntilNulError,
+    ops::Range,
     str::Utf8Error, //
 };
 
@@ -191,22 +192,30 @@ fn init(&self) -> impl Init<Self::Command, Self::InitError> {
     }
 }
 
-/// The reply from the GSP to the [`GetGspInfo`] command.
+/// The reply from the GSP to the [`GetGspStaticInfo`] command.
 pub(crate) struct GetGspStaticInfoReply {
     gpu_name: [u8; 64],
+    /// Usable FB (VRAM) regions for driver memory allocation.
+    pub(crate) usable_fb_regions: KVec<Range<u64>>,
 }
 
 impl MessageFromGsp for GetGspStaticInfoReply {
     const FUNCTION: MsgFunction = MsgFunction::GetGspStaticInfo;
     type Message = fw::commands::GspStaticConfigInfo;
-    type InitError = Infallible;
+    type InitError = Error;
 
     fn read(
         msg: &Self::Message,
         _sbuffer: &mut SBufferIter<array::IntoIter<&[u8], 2>>,
     ) -> Result<Self, Self::InitError> {
+        let mut usable_fb_regions = KVec::new();
+        for region in msg.usable_fb_regions() {
+            usable_fb_regions.push(region, GFP_KERNEL)?;
+        }
+
         Ok(GetGspStaticInfoReply {
             gpu_name: msg.gpu_name_str(),
+            usable_fb_regions,
         })
     }
 }
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index 7bcc41fc7fa0..ebdc12bcd4e3 100644
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
+    pub(crate) fn usable_fb_regions(&self) -> impl Iterator<Item = Range<u64>> + '_ {
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

