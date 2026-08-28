Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B2FAC61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 05:33:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A832310E484;
	Fri, 28 Aug 2026 05:33:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="B9oONZ7k";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010045.outbound.protection.outlook.com [52.101.61.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C7B110E484
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 05:33:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HrTJxPPp7LHRuy3060Cd4s2n1WrzapAt+Ys+RizWGGEqItguXd5rRxWeU1VvnfRjAmN5HCIDIJQsiAC7DVt6o4XPtTo+A9BiUQ8z8/J69rNvdHtJBJnYKtPaNKhU/80ctcXkeVRplK97rr1U5WKK0dv2cuOSe6d4HsputhIg/ijE+O+RIfaw2blC2OfkluGw1c/OqoXlsp3ACQPOwtz5+xbywXsv9X+glgCsldCWeMkg3sBRmLMp/ExfDWGFsOv0rfTWtjYXlt0dvA+zndgqnM3DJGZ46urrOt6FPk0MTbye+TfJxOtF9ffDggHvqQpdjigmltYKE59XHDsdf9ZYwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9A59GKO3xUMcRMf/pkVce8Fjy9XIUITF+pUJQ18ITw=;
 b=wAn/5bbjbMXXFKjddcW7zMkT+Gkt6QWCWTiXuLqOyxJ/aRSB3MUdvL0wjb5psSOUaxztONEoQFzxNia3QyhxZPUf4Kvyucc/To7x+YLww3W1UhTPBqdj0a2cSr80IJUcDnX4N8R/0Bgk2F//kObtHppF6GZ9WgHb6aTueqdQJweDHab/ucREDtgqHJEtpOEIKGoDvvMgeUeKWuBnk0FrDqr238lRJSJThXUOrcOXjcF9xDM5rLkpl+tdr+/uAiNApgaFqdray2gpO0IVTsWd0vRqVSFX8/b5x8ozyXB4JUrQp82yCIM0utln9coBenAJvTu7Xty/6yULfFpz+i4ZBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9A59GKO3xUMcRMf/pkVce8Fjy9XIUITF+pUJQ18ITw=;
 b=B9oONZ7krmrdA70VX5518ylmm5i9AWyBBwYNlMZCyyguGW27zl4Sbwl4m49CjWpIvRBJWtBeSjG8oa3Z7o92T9daz/kcpI9gSl1PiYJgQOvbHUyLuhcbCwYTgesgOnyvoE8rkmKDjy/IcMw60tkL+cxS6unRVhYHlxr9JtsFfPorkGMdDBQA+hJu7l/oTHKzBAWPS2CiqD5rYjOTDjaTgJE4DZ9080uo++9p/d5NzCLMoskGTzoyeKcZb7Dhkkn7Aobf8671Ca4IdEdqxSBaUzsK2KULzJzRx53+TnevqxK2qeAaH2T7VWHEqlXG+uZy4cMb/bAYXFSfmvB7rmbXEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by PH0PR12MB5607.namprd12.prod.outlook.com (2603:10b6:510:142::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 05:33:24 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0315.014; Fri, 28 Aug 2026
 05:33:23 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 28 Aug 2026 14:33:14 +0900
Subject: [PATCH 2/2] gpu: nova-core: use FromSafeCast wherever possible
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-nova_num-v1-2-e21f17ba4127@nvidia.com>
References: <20260828-nova_num-v1-0-e21f17ba4127@nvidia.com>
In-Reply-To: <20260828-nova_num-v1-0-e21f17ba4127@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY6P286CA0027.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b9::10) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|PH0PR12MB5607:EE_
X-MS-Office365-Filtering-Correlation-Id: 1735c2d7-502a-414a-7d3a-08df04c5e0e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|1800799024|23010399003|366016|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: myewAuvNJHGaugZhcWZkGBD2C0OezLBmHSZI10uxryiMLgG1c6WeU0TMyF7WRN5BK0RYxCFX4lKLQw6E10FhJzblMMZqiHTAMC1uwAP30w1IbX3fCYLRiR45CI49gFH9VXPiGPoQbfbyduCdVw3ac0TtJKpcoW0d6fat4COI4rO23JFaMZOZM4o9Dzu05X2+E20aP22kVIxIzrL8ovhFd9nrHZyuvdJMiBNRsljz3dVEo2VZWEUX5A2K3tdEfMVsIOFqdWHPtW2dDBhU5CUELKDfaIkGyRDTQh3Yk/I92bVpg0rrFRy74ijVztY64jyHinpMHov7jUoe6XS4mZEKPjYFM6VbllmJ1Q+iplfG7nGXLBenLeJuoxJkeE2SrHEG5Bm2+2hAodW6zZfz7E3qOCXFnJ+afbO5CFL6w89/HL1nwjCfY9+b58g9e/Bg0N75kKVc27fMJpq/RluVqVEswfuScrFWvMmTQUHhoCO10QcXLGECBOln+JY4I/MtAl2FEsx+gPxcViBTnIS4MH2sBT9YtRkDsp57WW0MuuVXcnZJuyifZaUyeQMWz4T8+HArI7EZPiXuTSCSOt3BPcXx18B4B8jnPZLPBTN4nx/dnGtTk/oTLl3do9PkjsB82JrsEV8iovnS1vzq2k5uhsJqkHn8QZNmjVI4DmQMrjR81hU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUl5SWh0cXRZQWxDaFJudEV0L09jK3FYMXJsVjRkU1JML1ptWkR4ckZnd0lq?=
 =?utf-8?B?c1VPS002eFIxOHNyU0orcVlYcG9HME5OSWhkUnF0RlZ1bEdhZTd2V0IrNkRw?=
 =?utf-8?B?ejkyS2lxZk9TelJkcU9tWGwzWnhMYUtvdE90WldUdlNWa1dXeTZWcm9oSEx1?=
 =?utf-8?B?L2lTbkUxUjZoLzFpKzl6b0NoUUpsNXFrUEsyNzZiNk5YdFN0QktTL1N4WWdi?=
 =?utf-8?B?UlVsK3pwRDJVSlFKVmFmMDNYRnJTNGJTdko3SThncmdaNG1rU0daYStvV3BE?=
 =?utf-8?B?dHpJRllyanQvZ3FvaGxpeEs0WS9xSm5CTUJ3SVlSU1BqeTNVOWpSTEwyMjk3?=
 =?utf-8?B?RERmaTRsRkZMOTFUZGN6UG5hdVQ1cm5pdTRqcCtGYSs0Rkwrc3lwNWFTazQ2?=
 =?utf-8?B?cm5rUjk4cjJzcEY4NU9GTWZQNlo0REh4YkhZSk5UNG1SenZJNks1Ly9Rckp2?=
 =?utf-8?B?dWNVSUJ6U0lyeDVyVC8vSkQ5d1VnaVkyVTY2ODdpOSs2Qk1rTDBEUk8vb0dE?=
 =?utf-8?B?T0xSbjlFK2JKbVJ5dUdRUjBwVVUyWWNwWEx3VmlYdGRZMW1DaXJpbjNkaGZl?=
 =?utf-8?B?NnFFMi9jcVRscmwzbVZLWEh6NUdBNUNPTSttV2FZb2pkbnNkN040WUxhVjU1?=
 =?utf-8?B?OWFVYmM0WncvVklNdFJPSENYSzd0b2llS1FTUXJLT2t5YzFmb1NNbzJyOW9S?=
 =?utf-8?B?b0tySXQ4TmdOTGlnV2YwSzJTYW1FOG1LcFVqMThVcGFVbDdHQzFPS09Vd3Y0?=
 =?utf-8?B?ZE5qNVVYVkFCTVY2b1VVRkVlUE12Z0ZzTjEzLzZvbkFleGFiNTZPdUNsZTk0?=
 =?utf-8?B?Z0pKY2E3WDJTSGRkQXhYOU1JU25CMzNNcDcvNmZyWStldktDQmM1NmRoYVhp?=
 =?utf-8?B?TVc3djA4bzdRMDluZVVSVGxFNUZFcEdoeTJoQU9DazV6TENGS1VjblhBWjFJ?=
 =?utf-8?B?RDBTOXRjbUZiUlpEMnVPQTBVRDA3NHRGSmhmdDBvUzUxZUlUbGpxRFVUaVBp?=
 =?utf-8?B?TU5saXgxMFRva1BNYlBDSnlRbVNIQzdZMzBHSk05V2VhcDFxSVZWT0lMNDRV?=
 =?utf-8?B?Mkt2MVdiUTd6V3V6djhJb2F6T2YzWEtnM21hK0wzMEtPRTlrR3o2enV2ek90?=
 =?utf-8?B?aXVNMFRYTklIVkFsUURoTUNQNU9xazRjSGtvd0JQOENGeG1MMUZBNFRjV3lY?=
 =?utf-8?B?QVBzVVFhd3UzbU9qYkZ3MXRPWnh5NUlJaklrN1JzWFpjSjlqdUMwN0R1NTR3?=
 =?utf-8?B?OXJrYjZhYnNGcDh0TkE3aTltLzJMamJnS1JxbmlQNzVKNVZHamI2NFd3Z1Fm?=
 =?utf-8?B?YmpYb09LWGdFZjVTck9lR3dJK0pYRi9JQVB1b0lTZkp1RS9DTEllOFlvbzBl?=
 =?utf-8?B?TXJTeVpDVUovOENVSHZDV2FnckFta24vbGdGR0dDbGxJdTljdmxQTi9sUXN2?=
 =?utf-8?B?VjVocEdSOWwxbFdSVXBTWktnUGU0MGQxdm1aRWg3UXBLbkN6d3lHSW8wbVNw?=
 =?utf-8?B?Q1BxOHB5NFBMVkZBcFNTRVpKSkZLTE9BRVRMS3dxVmwvRHJ1Rmo1alpSOStl?=
 =?utf-8?B?K3czRmhBeExrR1EyaHAxa2NTQWhoV3F1QzhEdStqL05LNmZjTWozd01LalJE?=
 =?utf-8?B?U1BRSk1FeXNpMysycldvV2NkRmtHZHpEelY2YVhtWW53U05lMENBU2xudXQx?=
 =?utf-8?B?bnJab3d5SnB2L0s5UVo0UmdSZWVBRFozbG4wS3VTMVIwaXFwSEtDdXlOOFo0?=
 =?utf-8?B?emhOYVg3UlU3NGdUMi9wM1ZtOWZhcllYZWMwbWRqc2JjeDU0MDVJdGIxZE5i?=
 =?utf-8?B?WXlMQkFsdElOL0sxNDVnV1dyL2RLQjRDOGRHT1B6UE1WZzluY1g4R2x0VGhW?=
 =?utf-8?B?eWNPS3ZFanVXZGtNTFIvNTJxQVg2c3RubndlcUxlMEd6ekl1Y0hueTMwdHQ2?=
 =?utf-8?B?WnMyOHRsM1B0cUFaTmdXbVM2VFZhc0lvL1IrcWUvYmdxb3dRRXp6eE1zWEVn?=
 =?utf-8?B?ZjRveXFIVXpqVHpLNjBld1BwcnRuZUt0d1NXWHJoaUV2VU1XcCszUmtUNFdK?=
 =?utf-8?B?RzVjNUo5Nkk4MlBHanVwenJoVWhGdUdaMEpBTm4xbDVPNmxMb1NqWEFuRDIy?=
 =?utf-8?B?UCtSQk1lTVYwNndTaDNudXY2Ym9nK1lXWmpNVklZenN2TWR1WkRBMXZpZm9K?=
 =?utf-8?B?Kyszb0k4cW16aDFaWEhMaGFlMXpJSU1OcE9FbTZhQVpGYmhZZno2dFdGQzVJ?=
 =?utf-8?B?eWJKYVdONlVLUDJPTUdmb05hVE1ubEVqcEc5Zi9yeTU5Z2xRSjRWK29PNkFq?=
 =?utf-8?B?elNWU1d3UlpIdWlsY2YxRXJHSnZOUTJKWHNMZGxLdE9uc3loaGhobTRyYlhy?=
 =?utf-8?Q?gptAPScbnBjdV3JEutuHbE4EZ+MqZ94EPq4eHVYiQ2O7t?=
X-MS-Exchange-AntiSpam-MessageData-1: l6ZUqCQGbRb8QA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1735c2d7-502a-414a-7d3a-08df04c5e0e3
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 05:33:23.9220 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00XuvsCsu+rZS+LVZcnIOmbXI/yPiVpsYuRcGdsqva+CAgi43uMcuYmptb+1cjvHIyA8fmpsKpATPFmNVGjOfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5607
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

`FromSafeCast` should be preferred to the `*_as_*` family of functions
when it can be used (i.e. in non-const contexts), as it requires a
single import to perform all valid conversions.

After this patch, the only remaining references to the `casts` module
are those done in const context, which means the `casts` import can be
removed once these are converted to use the `cv!` macro.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/falcon/fsp.rs   |  4 ++--
 drivers/gpu/nova-core/firmware/tlv.rs |  4 ++--
 drivers/gpu/nova-core/gsp.rs          |  4 ++--
 drivers/gpu/nova-core/gsp/cmdq.rs     | 19 +++++++++++--------
 drivers/gpu/nova-core/gsp/fw.rs       |  8 ++++----
 5 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon/fsp.rs b/drivers/gpu/nova-core/falcon/fsp.rs
index 2470ac511c98..ece95b1ea8cb 100644
--- a/drivers/gpu/nova-core/falcon/fsp.rs
+++ b/drivers/gpu/nova-core/falcon/fsp.rs
@@ -16,7 +16,7 @@
         },
         Io, //
     },
-    num::casts,
+    num::casts::FromSafeCast,
     prelude::*,
     sizes::SZ_1K,
     time::Delta,
@@ -165,7 +165,7 @@ pub(crate) fn recv_msg(&mut self) -> Result<KVec<u8>> {
             Delta::from_millis(10),
             Delta::from_millis(FSP_MSG_TIMEOUT_MS),
         )
-        .map(casts::u32_as_usize)?;
+        .map(usize::from_safe_cast)?;
 
         // Don't blindly allocate more than the maximum we expect from FSP.
         if msg_size > FSP_EMEM_CHANNEL_0_SIZE {
diff --git a/drivers/gpu/nova-core/firmware/tlv.rs b/drivers/gpu/nova-core/firmware/tlv.rs
index 6653c10e3e0a..7dff8871e338 100644
--- a/drivers/gpu/nova-core/firmware/tlv.rs
+++ b/drivers/gpu/nova-core/firmware/tlv.rs
@@ -5,7 +5,7 @@
     device,
     firmware,
     num::casts::{
-        self,
+        FromSafeCast,
         IntoSafeCast, //
     },
     prelude::*,
@@ -52,7 +52,7 @@ fn parse(hdr: &[u8]) -> Option<Self> {
             return None;
         }
         let len_arr = <[u8; 4]>::try_from(hdr.get(4..Self::SIZE)?).ok()?;
-        let length = casts::u32_as_usize(u32::from_le_bytes(len_arr));
+        let length = usize::from_safe_cast(u32::from_le_bytes(len_arr));
         Some(Self { tag, length })
     }
 }
diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index fc8648de84c2..0f5275dcb41c 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -17,7 +17,7 @@
         io_write,
         Io, //
     },
-    num::casts,
+    num::casts::FromSafeCast,
     pci,
     prelude::*, //
 };
@@ -92,7 +92,7 @@ fn init(view: CoherentView<'_, Self>, start: DmaAddress) -> Result<()> {
         for i in 0..NUM_PAGES {
             io_write!(view, .0[build: i],
                 start
-                    .checked_add(casts::usize_as_u64(i) << GSP_PAGE_SHIFT)
+                    .checked_add(u64::from_safe_cast(i) << GSP_PAGE_SHIFT)
                     .ok_or(EOVERFLOW)?
             );
         }
diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index f85fde09aa6e..658d0a9b2cfb 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -23,7 +23,10 @@
         Io, //
     },
     new_mutex,
-    num::casts,
+    num::casts::{
+        self,
+        FromSafeCast, //
+    },
     prelude::*,
     ptr,
     sync::{
@@ -289,10 +292,10 @@ fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
         unsafe {
             (
                 core::slice::from_raw_parts_mut(
-                    data.add(casts::u32_as_usize(tx)),
-                    casts::u32_as_usize(tail_end - tx),
+                    data.add(usize::from_safe_cast(tx)),
+                    usize::from_safe_cast(tail_end - tx),
                 ),
-                core::slice::from_raw_parts_mut(data, casts::u32_as_usize(wrap_end)),
+                core::slice::from_raw_parts_mut(data, usize::from_safe_cast(wrap_end)),
             )
         }
     }
@@ -307,7 +310,7 @@ fn driver_write_area_size(&self) -> usize {
         // `cpu_write_ptr`. The minimum value case is where `rx == 0` and `tx == MSGQ_NUM_PAGES -
         // 1`, which gives `0 + MSGQ_NUM_PAGES - (MSGQ_NUM_PAGES - 1) - 1 == 0`.
         let slots = (rx + MSGQ_NUM_PAGES - tx - 1) % MSGQ_NUM_PAGES;
-        casts::u32_as_usize(slots) * GSP_PAGE_SIZE
+        usize::from_safe_cast(slots) * GSP_PAGE_SIZE
     }
 
     /// Returns the region of the GSP message queue that the driver is currently allowed to read
@@ -343,10 +346,10 @@ fn driver_write_area_size(&self) -> usize {
         unsafe {
             (
                 core::slice::from_raw_parts(
-                    data.add(casts::u32_as_usize(rx)),
-                    casts::u32_as_usize(tail_end - rx),
+                    data.add(usize::from_safe_cast(rx)),
+                    usize::from_safe_cast(tail_end - rx),
                 ),
-                core::slice::from_raw_parts(data, casts::u32_as_usize(wrap_end)),
+                core::slice::from_raw_parts(data, usize::from_safe_cast(wrap_end)),
             )
         }
     }
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 88f083ff1f13..61064b6a251b 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -681,7 +681,7 @@ fn id8(name: &str) -> u64 {
         let init_inner = init!(bindings::LibosMemoryRegionInitArgument {
             id8: id8(name),
             pa: obj.dma_address(),
-            size: casts::usize_as_u64(obj.size()),
+            size: u64::from_safe_cast(obj.size()),
             kind: casts::u32_into_u8::<
                 { bindings::LibosMemoryRegionKind_LIBOS_MEMORY_REGION_CONTIGUOUS },
             >(),
@@ -851,7 +851,7 @@ pub(crate) fn set_checksum(&mut self, checksum: u32) {
     /// Returns the length of the message's payload.
     pub(crate) fn payload_length(&self) -> usize {
         // `rpc.length` includes the length of the RPC message header.
-        casts::u32_as_usize(self.inner.rpc.length)
+        usize::from_safe_cast(self.inner.rpc.length)
             .saturating_sub(size_of::<bindings::rpc_message_header_v>())
     }
 
@@ -948,8 +948,8 @@ fn new(cmdq: &Cmdq) -> impl Init<Self> + '_ {
         init!(MessageQueueInitArguments {
             sharedMemPhysAddr: cmdq.dma_addr,
             pageTableEntryCount: casts::usize_into_u32::<{ Cmdq::NUM_PTES }>(),
-            cmdQueueOffset: casts::usize_as_u64(Cmdq::CMDQ_OFFSET),
-            statQueueOffset: casts::usize_as_u64(Cmdq::STATQ_OFFSET),
+            cmdQueueOffset: u64::from_safe_cast(Cmdq::CMDQ_OFFSET),
+            statQueueOffset: u64::from_safe_cast(Cmdq::STATQ_OFFSET),
             ..Zeroable::init_zeroed()
         })
     }

-- 
2.55.0

