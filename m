Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33453CD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 14:41:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C44210E4AB;
	Mon, 15 Jun 2026 14:41:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="cCULOeCp";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011009.outbound.protection.outlook.com
 [40.93.194.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D71810E4AB
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 14:41:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LG9BCvorb5zDhp3kkwhEVOH2Em7+8IhhzWEWeaJmf3brKoKNAQQzjSO+IGdA2kg0kZLva5J+92H0Xn44PlNHBbhbvrmS5gXnYYcX0zF63poij8j7VSRTiMTpEsDIJrJIvP1eoSwplUfxLhfwfm7kSN36HFHxTWPqKwM6WhMT5PaDairV4lYKw4iL3FCsqbE/Ci5qQx56kSAEXntobckA4et4F/l3ZErVdJJP2WnBWfR8scO6or4Ydh07k4N2ZOyGogpUTzIQpDivEOVC5a0rxG6Q9iRvt3MwfzJH9gqXztU3PMK3X6qizAb1lhTBKWIwYBtKHfve0dv80P8NiZzGUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpcVK8ZeDqpxG6DfW26h/G17dioSKULYi+BcIwJSIl8=;
 b=MM+SoQH3B595hM2g3eUjH6M1yfb9S9Ur4RqT3ytkuVZY3lMab8C6sqvboQxzWV/8WvnVdWrJ6CpxRevU1TJQbXhbXtCITTK92bFOfk46e2kY56ldq74duU2HwyKYTLDE0VO60tTJkrCwtO9E/4++hBqFJqeI2c6nZlcMvcqwYNS3/fwFmPOcp4EgiJdaew6HO5WuJonWixKsRuEZRzPOzZGeoTgg9MTVedUlxqXQeePb/QPcXSuqpjVkx5C+FW0blxF8CSZ/TRWoxRxqrxX0yRrhMwcr+aSFao8+eB4c7R07wnvGaDqiGt89OF8ZaESmMkryXaHgyFgrSfsLEK0d4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpcVK8ZeDqpxG6DfW26h/G17dioSKULYi+BcIwJSIl8=;
 b=cCULOeCpnPD4DD6AVa1xxoX+Dbhu7v1ET2cgeeYmOGdOaTWjBGcdTQtW8rT3oaFBZYaYujrkdnkt6vtkF1RjpUHk1DdDmOUI7m2+wvTfpRDmNqh/26PZh4OVq6GHIS2Me/DqPEobM7fLxjnWd4aXB6R/Y7eWVMwaIz+09eQ0fukYo/zdPZRr5QmlrQ3e7Pkf6x+rXvBicKl+vKF+fu0/u6yh9pc+nfTYsDk9RJlV30/gplHZxGtisos72RQMzKihjS7NnRL4fYAo3Ont7mTlj1Vd66D6FGX41cWYIjN8UBPU42kjK/DwFyG3L2Df2qJ/3mXv1rPUX7PoKXpJQVSWrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by LV8PR12MB9668.namprd12.prod.outlook.com (2603:10b6:408:295::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Mon, 15 Jun
 2026 14:41:45 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 14:41:45 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 15 Jun 2026 23:40:44 +0900
Subject: [PATCH 04/13] gpu: nova-core: falcon: gsp: move PRIV target mask
 constants
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-blackwell-fixes-v1-4-f2853e49ff7d@nvidia.com>
References: <20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com>
In-Reply-To: <20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0104.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::20) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|LV8PR12MB9668:EE_
X-MS-Office365-Filtering-Correlation-Id: 667d0803-fb75-4b72-4ec0-08decaec38f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|23010399003|366016|1800799024|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: GlgrVwJT6Pduuv7sbpegSKzS/XV1BjV7byYy34xyFhyqezM/oHcyc+CN9drbNio6nlAvV4oEpKpdlhDPQkVjYlURMXOj0PZKT1qTZv/sgbTbVpp0cmzKkAsFNMEZdNdplUI/SFEbUXNdmMajdz6XmLOIxujPLJfFB8D8wGrr70UJj3bv8G7EUgnEGep2VQW/s5sLzLonb+WS+XO5hmoKF3a7NE8rRSaEA+BVLpUCKCRZU7wdvfZzc76POW7kaklF11CxKatI1GZ5Sk+JYELGEbKrWYFfX4bxVf6u5P05Iz25rgrs44PZrpcAWvGpqGN9s5d+0HdksRtRl4Y/5+9vs/NckeybvnyBb47h2D/CDqneJZJqE0wowpc0JP58nKi36GSO9tbC24eVBKxzSUUfKID859jIO/RABfroM0va+xuch/slZz1s/5gjxK+D1hoIyuqwU5IdSMFnJ4T7MAxRH3snpzDwy3QDLj/nDJlW8qt2vIK2faFYUyhKGVKSR1wsH5s+efHQfRDHc2iXPgUtQq9i9wbwsU3rwftlzDGltgOa45U6yHOY/PHefT+ulUFQ/2QuXDyVBrSI7Lw/YTZ0EamQ2S9ck9Jid3HX5i70qepYbId4TkexPuJk6Am6U/igefDdpLGHO6ViUnim6Ru/wkBXOWVqNY5m0F4tM97IiCNkTLJPPbCc74yC8ay2wkJJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(23010399003)(366016)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGV4YjEzQ0NDZFNmZ3cwcjYwSTdKMDBqL2JGMXRucThSdEIvSWdydWpEaWc2?=
 =?utf-8?B?bHV2R3Vqc250N2Yzdzdxd3lBZHA4eTk2SG9mTDdJQUNqRkMyRDlwZkhnUEov?=
 =?utf-8?B?OXdRMCtCbnpDWTk5NWpmaC9TdHJ3Uno3TVdMWngramt4bks4dDcwYU1OZkh0?=
 =?utf-8?B?V1pCZzdQemR2L2pxN1Nja1NQRlB5a0hwb29BY05OcmtUK04wcjJVZXRaWXY0?=
 =?utf-8?B?dnN6bFAvMC9DZUhMMTQzT1lWUXRVeUpYZVFQdDAzK3BhWXdMckFpZmx4K2RM?=
 =?utf-8?B?SW53VWhFUGpLU2VZdFErZGNnUVVJbSt2SG5WclA4R0JJd1l6MlZrYzFvL0wy?=
 =?utf-8?B?bXZIT3NLcGo1UkNhWkYzQjY2K253TDMrd1d2OHo5a1hnejV2OW9pdnpmVU42?=
 =?utf-8?B?L1BrTjRUdW5INlgxd3RjaFpYbWhHbzJuaVc5VWl3Qjg3anN1V0lzS3BjWXdB?=
 =?utf-8?B?a0k4eDJ0ckxGMVRLdVpaRWN3eXVZT1daSUhKODZCZm9vUkN2bjk5OFo2Misy?=
 =?utf-8?B?M09ZZXRObllGZmJ5OUNFbThpa2RpNjR3Ky9UZklsQ1hwTnl2ejZzWnpxRXNX?=
 =?utf-8?B?YnkwMWZwaWdRWUg4OTNWeGRDQ1l6RVJZNUVwVG82a2pOcTBNM1hhTjMyTmRM?=
 =?utf-8?B?a2lEYkRqa2hsWFllSFE2bkhSQU1VVU1LZk5qY21vS3R0cVpUZU00S2dwL0pv?=
 =?utf-8?B?UkVKdzl6ZDZPcUFhb0VKSzFCRzJVTU1ZQmVSQlZNVXBXRXlya3NGd1ZJc0R6?=
 =?utf-8?B?Z2d2RUpzSTFGb2VFcmR4NWdYc0JmRnY2TFdaN2hXNjEyMmdZc3c3MUhtTG5v?=
 =?utf-8?B?d0ExdTR6cWh5dmpFa2MyREZJdS9iMUpwOWVuRHlUSlZnL1NYQlBUNGVuQU5w?=
 =?utf-8?B?SGZBRGtFdXVEUWJPajg1WGpSWVhKTjV5SHJuQVNhMkhCSkt1YVFSTjFIM1Mz?=
 =?utf-8?B?NEN3NjJuY3dKajFGSEVjZkZkakwvNnE1MFVGV3EzUmFiMDZ3TjdzNTZNR0xk?=
 =?utf-8?B?TEJuMFNpNU5Za3dobHJjb2NaZ2tJUEpxaEhPUmtIQktJTVFOQWpRbkk4ak5E?=
 =?utf-8?B?WEdyMmRUUFNwR3cvMnFQdSsyTSs4cjBEeEdyOFRTMWhaNUJGYmw4TlJvTGxX?=
 =?utf-8?B?ZU9hV2dobUpmeUdsYnY5YnU4K3FYQmRsVXBUczQrUHNQRTB5ZDJIWnpxVVpF?=
 =?utf-8?B?TlY3cGdBd0FwM01TZkdVN1g2NVpJVU81ZE1hcEo4cTJHMVkyaUNUQ21JaWhu?=
 =?utf-8?B?OTBBYmkrN2RCRVNhYXhyc1FGVFdMM0xJektROGZWa1U2SFdsaUhQTUV4Z2RW?=
 =?utf-8?B?WG5Od1pNcTdzUDN1TStFeHZjUDVSZ2JVS3lqM0hKRk9Hc0pUaVFWTmx1QnpJ?=
 =?utf-8?B?d2JoN1hmMTJJejZmRTU2Vm5hTjFwVzNHcHpBUExycDhKZVNZZDBFeTVKZUlo?=
 =?utf-8?B?dkVBK2h6ZmNYV0I3MW0zYi9ubENhWXJTazlmeWNBRHJGNGlIY2J6OEFLdnFw?=
 =?utf-8?B?MHJ0bmpMMDhwNkt1RUhPNnRnb2F5MG84ek5CczNnTkxUZHV3bWJCenlCV21Q?=
 =?utf-8?B?VTkxbjBJMCtIVkRNY1RNeDg2UlNCY2M0ZUM1OE5Nc0hSTFRWOHJuNE9rZnJ0?=
 =?utf-8?B?RjVxb1dKL1hBQndPWUY2RjhzOFZHS1NMd05zbzJRZElvKzF3REtDcmxTNThj?=
 =?utf-8?B?eXJQbU9PWlpHZXNmdVVjZzlFaHZtbVBtb1JycU45TnROMFU2U3cxbHRrU2gz?=
 =?utf-8?B?Zlo1QzlGMmNZQ21JTkdjTmRtUThUalFWYWxLeEZqVkdTbi80V2h0SVJoTWZO?=
 =?utf-8?B?WkIvNWZYamsvZitCU2lXL0REa3VLOUFMUzhmd2x6eGIwN2tNZi82ZnloT3RN?=
 =?utf-8?B?RnE3RGw3NzIyT1lnTHkvc0FmTmdFVTFHVVhQdVIrZVdIaTJWWWsrM3ozeHR3?=
 =?utf-8?B?NFpoWlcwMjg4ejZrelJacSt0V1RzcVZ4MGpWVUxBbGZnQnNFdlh1SmtBZFpo?=
 =?utf-8?B?b1RiOUFpZzJNOGdacnM4NnJaZ01WeU1scDZUZGJQK0xqSkpkNnVGYStUK2lu?=
 =?utf-8?B?clpEdEd5bTdBNG9qVkxmQ1h4dHV2S1lHMSs1Vyt5TFdqSnNOVUNhWmVNdmhU?=
 =?utf-8?B?OGFHN1dhSmljNlZaYVBGNDhNeTlEVDJSdXVmcFBGUGxqM1gwQlFNc3BMZVor?=
 =?utf-8?B?YWhjU0JkdnJleXFhd3JMSVBpMzNEcFdBMDNPYjl2SjJ5NXdZZG9aR21RekNt?=
 =?utf-8?B?Y3p5dXVLWmRoR0FyYytRV055UjZ2MkhVY3ArWVVtMzBtWUd5ZldXWFo1MHRW?=
 =?utf-8?B?cGdlaXFPR2FtbDcveUs4SUluYXVyT0xkZGx2c0dOTEZsc2J1QTcxelNqdmhn?=
 =?utf-8?Q?GhZZHfXcddjWKoKhIbaHj9zMLYTLg+MAhJQSEqBK4jNpD?=
X-MS-Exchange-AntiSpam-MessageData-1: c25PreQesrVB8A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 667d0803-fb75-4b72-4ec0-08decaec38f2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 14:41:45.2709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dvNSVEBl8Hg8iQFCZz8iUv8wJGax4N+P4XQpQsYYoKUtHWuen57xD8/pLrUIuyD2TVByReJtl3RSGomtynjYmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9668
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

Small cleanup to move these constants which are only used once closer to
their use location.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/falcon/gsp.rs | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon/gsp.rs b/drivers/gpu/nova-core/falcon/gsp.rs
index d1f6f7fcffff..f788b87bd951 100644
--- a/drivers/gpu/nova-core/falcon/gsp.rs
+++ b/drivers/gpu/nova-core/falcon/gsp.rs
@@ -24,10 +24,6 @@
     regs,
 };
 
-/// Pattern returned by GSP register reads while the PRIV target mask still blocks CPU access.
-const GSP_TARGET_MASK_LOCKED_PATTERN: u32 = 0xbadf_4100;
-const GSP_TARGET_MASK_LOCKED_MASK: u32 = 0xffff_ff00;
-
 /// Type specifying the `Gsp` falcon engine. Cannot be instantiated.
 pub(crate) struct Gsp(());
 
@@ -70,10 +66,15 @@ pub(crate) fn riscv_branch_privilege_lockdown(&self, bar: Bar0<'_>) -> bool {
 
     /// Returns whether GSP registers can be read by the CPU.
     pub(crate) fn priv_target_mask_released(&self, bar: Bar0<'_>) -> bool {
+        /// Pattern returned by GSP register reads while the PRIV target mask still blocks CPU
+        /// access. The low byte varies; the upper 24 bits are fixed.
+        const LOCKED_PATTERN: u32 = 0xbadf_4100;
+        const LOCKED_MASK: u32 = 0xffff_ff00;
+
         let hwcfg2 = bar
             .read(regs::NV_PFALCON_FALCON_HWCFG2::of::<Gsp>())
             .into_raw();
 
-        hwcfg2 != 0 && (hwcfg2 & GSP_TARGET_MASK_LOCKED_MASK) != GSP_TARGET_MASK_LOCKED_PATTERN
+        hwcfg2 != 0 && (hwcfg2 & LOCKED_MASK) != LOCKED_PATTERN
     }
 }

-- 
2.54.0

