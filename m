Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4974AC55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 05:44:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B08B410E11E;
	Tue,  4 Aug 2026 05:44:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="jpafYIpg";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012070.outbound.protection.outlook.com [52.101.53.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F28910E11E
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 05:44:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWcUMRMOV3jrnVDPz9p5qKSZWR+fU4l4zYy9WGp+Kn+88vS8IeyTrOLeZwzvF51jRZjjgq7NONw1kzSVzIOR4lJpu/dPfY/so9ar/24TabKIbE9hdyoXURpQ3lW8CpEdm0gnEr0NXqQ8cnso3ZE30TUNGyIpBS+nktQSIiwx52bt+02X0IbYS7J5gK4tQKipm04XdDquRjraDAqn6CSq7yC7ok4LjWd1gHJM0g3BhHbfJ4Z5h5M1/2MGLE917SvUWTxTOL/4K4kMfvo01/uQ7gU5HY+ePyaSjdDiSmaPBCZWvrLYU1vPRowGN0rf3DEB5pgExS2tRnCrKuCKWauVNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DahcfpKOxjhB8i4/P9GmrI8ttOIR6+vHcQHnyqz8QQc=;
 b=SEcCLBErOFKOzV0ksPNR5xorWPEnI7JN9C2MP052jQ8b99RHLIlx2Y6dFWO0v1FdnbQBvWRqITYOn5WmQ/qCifYWCOmm03V5qzYl6Nw3GYMZ6XjshPI0V9P7F/jB057PgROoUfMzEOalQQPThiIdw1gKJ/FyHHqKty0QIsRDWi5mIa3RuPv1jGzlCpY3GVKSbvLMBjbLMVTJSEezYZcVQiQu0hM7eKvpolDDGUIkqYcmpvVmzrxKKB99EA891Ol30efI7ws5SdJpSNhEQJTLk3bJVlHinBOPcOodcFHQOiwADGA04QzmOqLVx5nWBAnrq3MdZw0RDPOPysio7rxP9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DahcfpKOxjhB8i4/P9GmrI8ttOIR6+vHcQHnyqz8QQc=;
 b=jpafYIpg5yuDqn8Wit8k9Kg162h+bVPZkU4gDRHjFFQuvZowsrK2i6O1PWmeVHtxLpIIZYiZjw2V170gGVf/4qSIBSATjG5uWguXWyyy4AzNiuJoH+CAwaRZ2T4ZJlrnHwtrEsTFJHwc0G+enGlpc7UTP9JceS5VAgOn0lthjvtHml8Z02p2gIQzntWEG1dNQmz8AQd5LznKdh/0igjbdJUOMpUGWwxoE4BzwxOcJIArSOwNdUq8YIgoSm8I2Dad5dAggGsqbS98gEgCwZ/oJ5ZzAMSgo9dDfp9XdpbmH4vpFJgu7fXOJkF5rDX04LX93hlPWUXR5/yX3ffh3gxohg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by PH7PR12MB6418.namprd12.prod.outlook.com (2603:10b6:510:1fe::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 05:44:51 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 05:44:51 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 04 Aug 2026 14:41:14 +0900
Subject: [PATCH v4 3/5] gpu: nova-core: return non-WPR heap size as u64
 from HALs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-blackwell-fixes-v4-3-ac858b6a1935@nvidia.com>
References: <20260804-blackwell-fixes-v4-0-ac858b6a1935@nvidia.com>
In-Reply-To: <20260804-blackwell-fixes-v4-0-ac858b6a1935@nvidia.com>
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
X-ClientProxiedBy: TYCP301CA0031.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::8) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|PH7PR12MB6418:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f5fe5d3-81c3-469e-8828-08def1eb7fb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|10070799003|23010399003|366016|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: VD1hvLtfdyHum9Oe2U0F1Z4gheVsaH8vlgWZP2TBj4rEBmUyJlEgKTgLuUbZkdnQEDvppQxu23iV3hhUEy2e7iEblbzamaQ3IrnGM9Mz+3IykPZy9IQ+yagwAsn+TvLoyYoxZTddkKrFFq4Rzht4vfU725uwewcCqItDr0Uy1OnX17fHFsTuZ/wKXb8RV1yDp0T05Ukp3rgJEOe+FzEAhi02yoU4alGj2V/QUwvYTxatE8qSqYDFUl8DdPXmAwpjNy7H3F9JbvlLtR9eiDTLysA3RU24amUTfaEuZL8JrZimmQ9KI+H/Vuua3yoFJiN/S2jQSWyqKAmNm4TuAX9w2MaLFb5+saOcsJMB38swRoJAkga0SrUNC0YTYE+vXi+MoNVQJpSok20HNSC402Sr5mHxA28d3gAq/JSjoy4vx1tVFi7deN+89tdk3+PW1W+SvjOzsxb2i2S/maD3tiepNNQExGcQtMXCWqyT+TLGhTxbvZ1Ox3+ZFhjQ2P8Yubsld92ZpEofH8jYl0Ep+ZpG3XVzJAghb4TkJiJpIDqSt5q8cR8NS/oOwB5JTiK87IElSkf7jcLJMp2J9pPku7F0dpxfamSzNK36ohfxhm1Lak9zGwGBg0/kPKpDHlBko/FHwyJMN0U/DuL+YCZQwhulTE0VoUYNwhlBqtUDThrbNs4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(23010399003)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmhIaDZQRjBoaGRYL3lKZ0lwTHF6cEd5N0dSMDUwZEN3MXZXMVVZb0xnK1RH?=
 =?utf-8?B?OEh0UEo2ZlFtcm5FNHVzQUFjWllEMXRueVVuS0VwR3d3aXpnNWZWNlBwWHYw?=
 =?utf-8?B?YkdIdU5SY3d1aUcxeEVnS2RqdTZpT01jSXhEbGhtRWE1ZjFubXF1elE1TkVu?=
 =?utf-8?B?TjhJRTlVNXJzQ3FDeCtwaHU0TVYrQ2IzeDVWellnVjVyZmEvMlFkY0tqeUc5?=
 =?utf-8?B?Y3lLZUdRUHgza2NlSTRPSXk2YVpxZHVQalNCYjFvMVZKYVpEekJDT1RQL1ht?=
 =?utf-8?B?ZW0wamRhN3Z4VzZlMHRLRmxSK2s0MnNOL1FNN1lDY0hGbWJzcFFvdU5mYndn?=
 =?utf-8?B?TWduZUMxNmdmcGFtZURhZ01lTTFVaW0za2xmMFNQdjRXcERCMDlDLzRyQVFH?=
 =?utf-8?B?VHVkVDBhV0RBd1FUdVRvWUFSNnlVVDZXZTV0cmpDdVNqQmlOZGdKWm5nMVZy?=
 =?utf-8?B?ZU5mbEFWUUZCNlIxeXNYWGIyU29teDZvU3l5SzVEZW5UcUdFa3YrWU9pTm5S?=
 =?utf-8?B?MkF3QUoxQ0tyY0QrSEx5Z2d0QS9xcy9HOEZqa1hxYTRKWFBnY1k0NWc0L0NF?=
 =?utf-8?B?Y2dIMTFXWDF1OHVpNWozSGk5elpqOXRSMSt4aUhoQ0tjWWpmSFludzVPT25k?=
 =?utf-8?B?YUp2RDNMOENwN1NqMGN3QjNJU1MwTkJRZk9wbmVzeGhUcmcrTVNUZWp0eHNo?=
 =?utf-8?B?aXRmTEMyQmg2N2dWRWRrRTZ6eUlyRWtsVlhxZWF3dVgzallGbTBnSVN0VXJr?=
 =?utf-8?B?eHhhTGY5ZXdLT05mbVJCZkx5dlVCMEo2OWpFeWRpSDBDcFdWR1hHZmZucDJ3?=
 =?utf-8?B?YkJHakg3SkMvZDg5UXRybHJYRThQQTZPaHJ1djlrY1kwN252Zk9FTWRNYW4x?=
 =?utf-8?B?VDBrellxTWdHNXExMStDNmVVTSs4aWJHV0NSOUk0Wml4MlFLVnZnUVZhbHRY?=
 =?utf-8?B?dnIrOTVXRE5tZWdnYnBTOWw4NHJMODJEeDhQMzZQTXNpZkd2S0M2cVQ5NFNX?=
 =?utf-8?B?VnNnMGJDcWJnbWk1Qmk2NHN5OGpNcG5sbXZabG56RFJqN1VoM1lCaWIrYlpC?=
 =?utf-8?B?TklmRGJsZEQ1bjJ4dUdXNE5JcERENGI2Q2xDakFQMHNVTVN1dVRyaEY2SmRk?=
 =?utf-8?B?UFdiNTMzSFljaDV5ZExDWjljZTNkSXJiSUkzcklPTEJGeTRDbUsyL3VFZENH?=
 =?utf-8?B?WjJQYmg2dWxURWtobGpvMWZwd3F6Rjdkc08vZ2Y3UW9VSExYSXJhK1Q1UGQr?=
 =?utf-8?B?YXhEMCsxNC9pRjVUL29VVnpKRFVHUTNWOTZRWFRLMWVaTmpvRE9ZeE1ON2V4?=
 =?utf-8?B?eERreVA0cUsrL09EYktPN0xSNHNOUnBVQzJvb1pXQ3NkcHRZYkhhTTZJNEw0?=
 =?utf-8?B?YWtKam10L2lEQm92ZGQrRURyMXdhK1ZaTE5wZFJWWnZSRzlIaVMwSUZSNy9U?=
 =?utf-8?B?RFcvYWMrSEJSazkrNEhsdTBMbUx2cmJwSFVJbkVkSGxBU3ZaSHhNQUJrYmQr?=
 =?utf-8?B?TEFGaVZQaUVjUFZTdDhHK0lHaVZDaWZ6T0h6dmdvd3ZsMUV2ajV6Q00yblAy?=
 =?utf-8?B?c3Z5OWNMNUQ0QzJ0QkhudGYxanl1bmp4cmd4Rm5JYUdIVjRldUtBbUFrbFp3?=
 =?utf-8?B?QldwREJsZWkzVDI5R3pleDZ4UFlNV21aMExuK1diTkJhNWQydmFJV1R0OERO?=
 =?utf-8?B?RnF3SmpuOTRMYjM0aTZwZTJtNFI4ZytNTjRrY0tjT3AveVpiemg2NEhtekF6?=
 =?utf-8?B?eEZtc2YwN2tETTN0b1dTSEt4R3FUaXNnOVFzYS95WDBrRTRHRkNXM1llWmZu?=
 =?utf-8?B?NUxyb0FaNmM2RWJCUjFTd1VxVW9IeGFmUlo0VHZodDlDRnpCQmliNW4rL1Bp?=
 =?utf-8?B?T0wwbS9YSG5OQUdBQmJoUzNwZlp5OXV6MytmaC9vcnRjdkxNVEJmeGlKK2lJ?=
 =?utf-8?B?dlNOT2Z1ZUhIU3NoUDNsQ2ZkRlFINmR2c2FSNTgwT0lSN1pXQTFmZjlSV2ow?=
 =?utf-8?B?djJKaHFLK0xPaXBiSEZKcEpiSFVLRm50YStuRXhDRlBlU2hVQ3ZseXFKNUdi?=
 =?utf-8?B?U3hkcFpuMXFtRklTQ080angyNXVpc094Wm5pZ3ZhcGRSa1M1NGhRT01SczZO?=
 =?utf-8?B?L3RtRVpZOW5Iekh0bjFuVnpmYXpLd2N5RTVKRHRBWk9MOXdkNUtwVEJrdi9j?=
 =?utf-8?B?RVFVcGljSTQ5SGFXbWxYU3I2RThmVFBqSjRGcjZ2MndDZk10WVl4NkVFRm0r?=
 =?utf-8?B?Qk1QWk5lYzJqSHdJWVlRVjQvdFNZcFR2ZWVLK2VKdjIxVWZyVU01R2ZQWEdO?=
 =?utf-8?B?MHVQRXFOWS9XMmpxdlpFNk9Ea0hKMG9ZR3ZISDFQem4ycWliNG56UWVGbjBz?=
 =?utf-8?Q?g57koDuCyavwUiQzQdjQ0jRbUq/dS6QmIyMoeCQqGOZep?=
X-MS-Exchange-AntiSpam-MessageData-1: sW2JO5MDegiJGg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f5fe5d3-81c3-469e-8828-08def1eb7fb7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 05:44:51.6631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eojwx7ZEXLJKZxsPcYcObMNCP27fiZXZ/oUKSrJQx76MTV1jNMElIDBW5TS0kKdfBFqYQv6sw2ZWbiB3kMjbnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6418
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

This is always immediately widened to u64, so just return it as a u64
from the beginning.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/fb.rs           | 2 +-
 drivers/gpu/nova-core/fb/hal.rs       | 2 +-
 drivers/gpu/nova-core/fb/hal/ga100.rs | 2 +-
 drivers/gpu/nova-core/fb/hal/ga102.rs | 2 +-
 drivers/gpu/nova-core/fb/hal/gb100.rs | 4 ++--
 drivers/gpu/nova-core/fb/hal/gb202.rs | 4 ++--
 drivers/gpu/nova-core/fb/hal/gh100.rs | 4 ++--
 drivers/gpu/nova-core/fb/hal/tu102.rs | 6 +++---
 8 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index 4a1be29cf5fb..86d2bdaab7f9 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -271,7 +271,7 @@ pub(crate) fn new(
         };
 
         let non_wpr_heap = {
-            let non_wpr_heap_size = u64::from(hal.non_wpr_heap_size());
+            let non_wpr_heap_size = hal.non_wpr_heap_size();
             FbRange(wpr2.start - non_wpr_heap_size..wpr2.start)
         };
 
diff --git a/drivers/gpu/nova-core/fb/hal.rs b/drivers/gpu/nova-core/fb/hal.rs
index 714f0b51cd8f..99363cfb116b 100644
--- a/drivers/gpu/nova-core/fb/hal.rs
+++ b/drivers/gpu/nova-core/fb/hal.rs
@@ -37,7 +37,7 @@ pub(crate) trait FbHal {
     fn pmu_reserved_size(&self) -> u32;
 
     /// Returns the non-WPR heap size for this chipset, in bytes.
-    fn non_wpr_heap_size(&self) -> u32;
+    fn non_wpr_heap_size(&self) -> u64;
 
     /// Returns the FRTS size, in bytes.
     fn frts_size(&self) -> u64;
diff --git a/drivers/gpu/nova-core/fb/hal/ga100.rs b/drivers/gpu/nova-core/fb/hal/ga100.rs
index d13c9a826eef..a81b3e42ae41 100644
--- a/drivers/gpu/nova-core/fb/hal/ga100.rs
+++ b/drivers/gpu/nova-core/fb/hal/ga100.rs
@@ -74,7 +74,7 @@ fn pmu_reserved_size(&self) -> u32 {
         super::tu102::pmu_reserved_size_tu102()
     }
 
-    fn non_wpr_heap_size(&self) -> u32 {
+    fn non_wpr_heap_size(&self) -> u64 {
         super::tu102::non_wpr_heap_size_tu102()
     }
 
diff --git a/drivers/gpu/nova-core/fb/hal/ga102.rs b/drivers/gpu/nova-core/fb/hal/ga102.rs
index 44a2cf8a00f1..a5eeddb8a1ae 100644
--- a/drivers/gpu/nova-core/fb/hal/ga102.rs
+++ b/drivers/gpu/nova-core/fb/hal/ga102.rs
@@ -41,7 +41,7 @@ fn pmu_reserved_size(&self) -> u32 {
         super::tu102::pmu_reserved_size_tu102()
     }
 
-    fn non_wpr_heap_size(&self) -> u32 {
+    fn non_wpr_heap_size(&self) -> u64 {
         super::tu102::non_wpr_heap_size_tu102()
     }
 
diff --git a/drivers/gpu/nova-core/fb/hal/gb100.rs b/drivers/gpu/nova-core/fb/hal/gb100.rs
index 7e5b0e3ffc67..d9e4d62ae632 100644
--- a/drivers/gpu/nova-core/fb/hal/gb100.rs
+++ b/drivers/gpu/nova-core/fb/hal/gb100.rs
@@ -111,9 +111,9 @@ fn pmu_reserved_size(&self) -> u32 {
         pmu_reserved_size_gb100()
     }
 
-    fn non_wpr_heap_size(&self) -> u32 {
+    fn non_wpr_heap_size(&self) -> u64 {
         // Non-WPR heap for GB10x (see Open RM: kgspGetNonWprHeapSize, GB100/GB102).
-        u32::SZ_2M
+        u64::SZ_2M
     }
 
     fn frts_size(&self) -> u64 {
diff --git a/drivers/gpu/nova-core/fb/hal/gb202.rs b/drivers/gpu/nova-core/fb/hal/gb202.rs
index c590e5b1269c..4341ecf36188 100644
--- a/drivers/gpu/nova-core/fb/hal/gb202.rs
+++ b/drivers/gpu/nova-core/fb/hal/gb202.rs
@@ -71,10 +71,10 @@ fn pmu_reserved_size(&self) -> u32 {
         super::gb100::pmu_reserved_size_gb100()
     }
 
-    fn non_wpr_heap_size(&self) -> u32 {
+    fn non_wpr_heap_size(&self) -> u64 {
         // Non-WPR heap for GB20x (see Open RM: kgspGetNonWprHeapSize, GB202+).
         // This size is r570-specific.
-        u32::SZ_2M + u32::SZ_128K
+        u64::SZ_2M + u64::SZ_128K
     }
 
     fn frts_size(&self) -> u64 {
diff --git a/drivers/gpu/nova-core/fb/hal/gh100.rs b/drivers/gpu/nova-core/fb/hal/gh100.rs
index 2867ae058d0a..cf8e6403ef98 100644
--- a/drivers/gpu/nova-core/fb/hal/gh100.rs
+++ b/drivers/gpu/nova-core/fb/hal/gh100.rs
@@ -63,9 +63,9 @@ fn pmu_reserved_size(&self) -> u32 {
         super::tu102::pmu_reserved_size_tu102()
     }
 
-    fn non_wpr_heap_size(&self) -> u32 {
+    fn non_wpr_heap_size(&self) -> u64 {
         // Non-WPR heap for Hopper (see Open RM: kgspCalculateFbLayout_GH100).
-        u32::SZ_2M
+        u64::SZ_2M
     }
 
     fn frts_size(&self) -> u64 {
diff --git a/drivers/gpu/nova-core/fb/hal/tu102.rs b/drivers/gpu/nova-core/fb/hal/tu102.rs
index 541f163b52d3..bf5967cbffd3 100644
--- a/drivers/gpu/nova-core/fb/hal/tu102.rs
+++ b/drivers/gpu/nova-core/fb/hal/tu102.rs
@@ -46,8 +46,8 @@ pub(super) const fn pmu_reserved_size_tu102() -> u32 {
     0
 }
 
-pub(super) const fn non_wpr_heap_size_tu102() -> u32 {
-    u32::SZ_1M
+pub(super) const fn non_wpr_heap_size_tu102() -> u64 {
+    u64::SZ_1M
 }
 
 pub(super) const fn frts_size_tu102() -> u64 {
@@ -77,7 +77,7 @@ fn pmu_reserved_size(&self) -> u32 {
         pmu_reserved_size_tu102()
     }
 
-    fn non_wpr_heap_size(&self) -> u32 {
+    fn non_wpr_heap_size(&self) -> u64 {
         non_wpr_heap_size_tu102()
     }
 

-- 
2.55.0

