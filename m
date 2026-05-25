Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC5BCD5BC9
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 13:59:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2975F10E38E;
	Mon, 25 May 2026 13:59:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="jZxMj7d6";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010056.outbound.protection.outlook.com [52.101.201.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29DD510E38E
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:59:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lce+ZNGXNxCxphFRTaPPnVmIw9COABwyzHSaGCra5Gxu0ZGd9Wu1VihdSrAom3KwkS5wmA2RxmUaxkjMl3qNuJ6xv3qceHZmU1vXmnf1zznKPAjBh7cZ/1m/7pGdT91nLN2HF4xWxyqv/tcg3aJ6GemLHBdcwhu7QRoTn/YZHKlDQFNFQT/oNhMTtLu+324GJ9G/BayzC/X7+H/9zfIuqNz5JQ38lP/UUwhEDpexh6WJF+e0vkzHT1HrUVQenyedYuysvs8LBEIKYarJ9y7jFxJvaXoAC/Zn3WAvRFvWLbgZbG+orFo2RG5JM7BLDpi8vtpp8uE9X+yN618lIYsDtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1VTe80hMYMTVM3LcTcIbnGGIJ+ZCwaDxQb6OzDURdc=;
 b=mIDOBKvJk/siVCXBD2KrIS/r9u6RmevCpWFodmXx54/xtHvgmbZ5uvit2tlNGTO91a1Aob8uDGH0pSUfkr3YbnDGdydEHisWfNetpTcv54XY3XR+Dj5s2iARPmX5ya7QrT0NplbzbgZCS97k4aCeb3LkuBVfVuyQiPJ2QGz/dqk9hnKaaRhAoPb2w2tAwF7hpzsUG7h8qQGykn+2UA7zBTJ1zoMU9UI9mQ+QouNwq7eHNeUxo/zXzgd/mRU9Twv+AyGDg7vPvVdh7g0dDZLaNXgJZ1EKnmBlnb8GXOnwXrsWkbv+77M2MXSH+VVf3uYRbYWTwITjp6hyfXGIE3JICw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1VTe80hMYMTVM3LcTcIbnGGIJ+ZCwaDxQb6OzDURdc=;
 b=jZxMj7d6D5l0WLgvbB85bZDJrFJPOhMku3gswitFw5ZGbWURJ9pSM8pSv+W00XvcYcZg/Yakmg0hpQQOSKdnggaCFOAqR7fzvXTr2hYfzOUq1KZAUBMNi2hgXHPKbDg3Gw3Ft2WW7dB1/Jt2harExXcm8UKRmqrWCjI407iIz7x/ioz2fNDUBf/LSXyxDoWLGy2fhs5z/QXCK9PJE/4A4gzfDBxdQumpMrzxoC9sxLAwAvPT5eUuQCqgoEDqnwDw0iixC1UuVagS7axyDBRbCReJdojr+eR6zcrd8Rih6NQS7+I5DJrO5uKroUcE8NvjSyGS6xYVuRtVP5OthF0HEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by MW5PR12MB5681.namprd12.prod.outlook.com (2603:10b6:303:19e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Mon, 25 May
 2026 13:59:15 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 13:59:14 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 25 May 2026 22:57:39 +0900
Subject: [PATCH v5 21/22] gpu: nova-core: vbios: move constants and
 functions to be associated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-fix-vbios-v5-21-e5e455251537@nvidia.com>
References: <20260525-fix-vbios-v5-0-e5e455251537@nvidia.com>
In-Reply-To: <20260525-fix-vbios-v5-0-e5e455251537@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0042.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::18) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|MW5PR12MB5681:EE_
X-MS-Office365-Filtering-Correlation-Id: 1944c386-fc9b-48b8-172e-08deba65cde4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|56012099003|22082099003|18002099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: u3J4CL+B5s5Uc+WUwcrer5kq5nuJM9TXvMsKB9VCVAD3i35UVjATl6VpD++06WEEnmYTzvIEWWr9EK0p/IeSPV3eSIukZ3BRHuJsLLCG43WRZuCGZ3oeh0ZwDgXkZNcOJJ//ekLz2Tps/NnSRZ9tx8kq2mJ45HM4nfF8Fs5Tu1XYpMRlgL/MwucmHf8v0FpwFvYlKaXDqRrmK2fE3S5DeE5PM+vmsEMp+ndcN8XykN/5hq3WGRAOvx+y18dnAuJa/T5AViIZpZZY3B0mMJh58nL69Qby5dGqh+nII0UOSXFj6RArZjHn23Im3ysKg3HzVU4oH7jX8VUtbHqL4ggRlSIy/p8hnbt7nTk0IWL5SX6kj5rRi2Mv5RkkaKeJsYFUucdcA0aqfZtEUgw0uPhocwm+SOvgrMkiimSPVUiiKm4NlbFXghbITS42I/uh9sUJ3lkOcD4aZClveX1npUYKVyKlZoF5aXYsrwjs5hFQ4Y8JWi69Uim7Ze7/niJkKUKamQ5s863w4Zme+a6CWnc5ajIzWQcT34XuSFPThdYwqkS0zM1iaQPXH//oaZARYrPuaXBSyXFOVTnADixfVZrS77C6GeupzxjQLDqznUR6JYG6L6vPAebmvs0hdljT553uELQF/CvW9UD0YzxGV+VQEDJhTmu7XVHD1JElZqjx9JZui2nDxIC9ZtjI5zhaW8lE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(56012099003)(22082099003)(18002099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eStsdHBKVEFHVlZlR0hNVnJvbFZKZzJybmxtRGpGUmxBR2pXUDlTdkNJRUdm?=
 =?utf-8?B?ZFZ1M2RUOWZpODNRZkMrRkxFTkxtbWhwTWZoRFFMczBTWnhRMGI3TXMxNUFp?=
 =?utf-8?B?MmNFci9hU2ZZWFA5MW40N2luYUpzdFVHWUM4VXFmbm1DQU9IamZHOGs3SkRo?=
 =?utf-8?B?TjBZMXBGeFRWQzhxWnk5emtBZEdRTWZsQ01hNHo4MTZ4QVB4QWRza1paZUlo?=
 =?utf-8?B?SWMxSzRSa2djNklVRG9nYUpjb3N6eG54dUdKM0N1YUJXRzJRZGZQOHJVbXlx?=
 =?utf-8?B?MG9qczNoS1kvZnhVbWlpUm5aSnlPVTg2U2t3S2hkYmhwSjZEbWkyYkNIMDUv?=
 =?utf-8?B?djVjNTI1UGFXSVp5bmkwNit3aDhUdjNvT2lLb1owaElIREs4RDNVQVhVL3FF?=
 =?utf-8?B?clVUZVFGQ3paUzZKRUhDOGRpeFFORGo0NEgwajQ0L1Q5ckJnMmFmcVF2Vnov?=
 =?utf-8?B?WGdvQ1Y2VzVOQS9DWHhoMHpLdlhCbGtJSStQNXV1QU9iYk5RRzhpb2lJZVdD?=
 =?utf-8?B?VkxyM0t4RW1HM3dlaDdkMEZ2VFQ2WWppRlA2TldEc0JvZDFBNjlLVnlhVFFv?=
 =?utf-8?B?R0NzWHdkSnhJVER5bWlkc2pZR0tqQkJtZUZOc0xqd0dEZXFXdWdsS1dvZ0hm?=
 =?utf-8?B?VnlzRG0vUE5QWXhiRTBlRGo3YW9zcFpMR0xXc1ptODVpVDJ4QnpOdm9hZ0Mw?=
 =?utf-8?B?M0RScTMrVmhRYWkyMkEvU0EwblVOT3RkSnd3MmFWUFhSalRLdmhaaGVFZVRZ?=
 =?utf-8?B?Q2tGWm9FR0lzN0hxNUdiZVdHM2RrOGJpTzBWTk9MbmhvK0syb3BlTXhjQ2Nm?=
 =?utf-8?B?ZGtzb01PenlNL0NNSmtzMmZmcUFDd3gza25kdURaREJpbDFoVmlYT1BydUs3?=
 =?utf-8?B?c3F1UXJxQjYwNkdtd0JJVzh5eThHajhiYkhEMlZnWTNFTm8xN2FJUU9naytt?=
 =?utf-8?B?SEFPbGRXUVM5bUNVYmF3Njl4Sk9GdlhROTYzWkYzVDFSRHVDcmVmRHhTU3dh?=
 =?utf-8?B?QXk1akpaUFVCTWM2czUyUE9yN21nNW1lSk52dHdyKzdVUUU0Mm5XWjlLQk1P?=
 =?utf-8?B?dVQ1VnloZzVNRHpLYU9INnVEeW5GdHhzQldocHFXZ0NaYUxoTE5nOUl1cFh6?=
 =?utf-8?B?RFFXWjBhTURZOWpBOEJTeWlYT3RSczZxNFJwMTIwZTNkdFZ3ME5FSGU5Q0pC?=
 =?utf-8?B?eFJyTmIybkoxQlVGSWVuZlF0U1h4SGpIK2UrRnZTcVdoR2M2SVFhV1BqVks3?=
 =?utf-8?B?ZjlhNTVhYVhVS3FqaU9SNTdSc2VOdnRPSFVjUjU5ZGNJZ1lLTG5aSklBd3RE?=
 =?utf-8?B?L2ljV2dSRHR0Nk80Y0hTUzhoVGJ4Uk1HV2hidEh5cDl2a1dpdjdDVXJGbHo1?=
 =?utf-8?B?TUUrMEpuRXFPL1czUTJXNGpkVGpkcFYwVlRKWUxNdGg0SXk1UDJqTnQ0bDZl?=
 =?utf-8?B?Z08ybXBIL0FEbU5DemxuT3ZoaVowVUpnKzRkNy9ITXBhUTFreXE4VWlGbTJs?=
 =?utf-8?B?amtxNjRLMUdPanpETi9VVEdzUzdxQ1EwVVB4UEl3QVBQenJheUFIOTBoR080?=
 =?utf-8?B?cWs1UXJwYWloSWRkbmdyRVVyUm44MVNCRmlsTTlHSUNNZUpIK1lSalNkTXRy?=
 =?utf-8?B?aDkzYTRzU0pzaGN0QkE2QzhjbDRYWFd6bytuTEV5UVVJLzR2cVpRdkh2THND?=
 =?utf-8?B?M1djc0M4ZHZld0ZxOFpsUXJCQlVUbkxyMC9BNklSYmliUzhWTFRTaGRUUE5R?=
 =?utf-8?B?WmhHM1RSZXkzNFZZOVdDcDdsS1NYM0ZYeVdteG96NEQ5RU9oMVZSVi9KenRK?=
 =?utf-8?B?MDM3cnU0WVowQ00rdms3Myt5TmF3NFFUZytIVkR6YytKNUhmNFdOTmZ0ZFVh?=
 =?utf-8?B?TUdKMmVsL2docWlNVGVJTkZWeG9LeWxUd0lRZ1ZHRVE4ekh6cXRObTEwWWx0?=
 =?utf-8?B?Tk80WC8vS1EyQ3p0ZlhxcEtMYWFKc2RteXM5WGZDWW9KT0Rnbm1ianhONWdJ?=
 =?utf-8?B?SWlPWTh0YVFtS2UyR0RDcGxMUEJsMlFmUGJRZTJleHRlNmF2MFk3bmdiN2do?=
 =?utf-8?B?ZDhKTHF0ZGVoTDBnWEp5RTZMT043M1hDVVdIVTdZWGo4UlV2QXE2b3ZzaHNS?=
 =?utf-8?B?TDYwcDZlK2xONlhpL2xOMXp5OGFiQkFXSVhpMmJkTFdaVnlwUktWSVpaK3NL?=
 =?utf-8?B?RUUyajhhVnEvK1BpaFV1d2R0QWJGVE5Ndk8vYWFhVG9lMGROMlNKeDNLSjBU?=
 =?utf-8?B?SjFsTXk0bzA5RDlWZTloejhXOEpWdGp1TWF1aEdFWHp6aXhYVWpQcHllQVBm?=
 =?utf-8?B?WDBCRGRhNDBoQ2NXRGsyblc2NVFLZG9wR1FOWUxsL1hBbE5NKzdrcC9RWnpJ?=
 =?utf-8?Q?RQPWUcH+5vARttDZ31KTaMV1si9DD6oCjKnXEtmO7S+j0?=
X-MS-Exchange-AntiSpam-MessageData-1: LMQoNkGyTm3WRA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1944c386-fc9b-48b8-172e-08deba65cde4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:59:14.3217 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GyB/Gp0U36p6h1GllVdeQVP/Fi9A/82rlCIY4tgIdQPdy++ovV8NbUhROsziTv53jk70qrpbHhQ/iGagrUi+5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5681
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

Move constants and functions to be inside the impls of the types they
are related to. This makes it more obvious what each type and value is
for.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 Documentation/gpu/nova/core/vbios.rst |   2 +-
 drivers/gpu/nova-core/vbios.rs        | 220 +++++++++++++++++-----------------
 2 files changed, 113 insertions(+), 109 deletions(-)

diff --git a/Documentation/gpu/nova/core/vbios.rst b/Documentation/gpu/nova/core/vbios.rst
index a4fe63422ede..9d3379ccfb30 100644
--- a/Documentation/gpu/nova/core/vbios.rst
+++ b/Documentation/gpu/nova/core/vbios.rst
@@ -232,7 +232,7 @@ Falcon data in the VBIOS which contains the PMU lookup table. This lookup table
 used to find the required Falcon ucode based on an application ID.
 
 The location of the PMU lookup table is found by scanning the BIT (`BIOS Information Table`_)
-tokens for a token with the id `BIT_TOKEN_ID_FALCON_DATA` (0x70) which indicates the
+tokens for a token with the Falcon data token id (0x70) which indicates the
 offset of the same from the start of the VBIOS image. Unfortunately, the offset
 does not account for the EFI image located between the PciAt and FwSec images.
 The `vbios.rs` code compensates for this with appropriate arithmetic.
diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 6492f158d11e..b14f9ebdc68f 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -27,16 +27,6 @@
     num::FromSafeCast,
 };
 
-/// The offset of the VBIOS ROM in the BAR0 space.
-const ROM_OFFSET: usize = 0x300000;
-/// The maximum length of the VBIOS ROM to scan into.
-const BIOS_MAX_SCAN_LEN: usize = 0x100000;
-/// The size to read ahead when parsing initial BIOS image headers.
-const BIOS_READ_AHEAD_SIZE: usize = 1024;
-/// The bit in the last image indicator byte for the PCI Data Structure that
-/// indicates the last image. Bit 0-6 are reserved, bit 7 is last image bit.
-const LAST_IMAGE_BIT_MASK: u8 = 0x80;
-
 /// BIOS Image Type from PCI Data Structure code_type field.
 #[derive(Debug, Clone, Copy, PartialEq, Eq)]
 #[repr(u8)]
@@ -65,14 +55,6 @@ fn try_from(code: u8) -> Result<Self> {
     }
 }
 
-// PMU lookup table entry types. Used to locate PMU table entries
-// in the Fwsec image, corresponding to falcon ucodes.
-#[expect(dead_code)]
-const FALCON_UCODE_ENTRY_APPID_FIRMWARE_SEC_LIC: u8 = 0x05;
-#[expect(dead_code)]
-const FALCON_UCODE_ENTRY_APPID_FWSEC_DBG: u8 = 0x45;
-const FALCON_UCODE_ENTRY_APPID_FWSEC_PROD: u8 = 0x85;
-
 /// Vbios Reader for constructing the VBIOS data.
 struct VbiosIterator<'a> {
     dev: &'a device::Device,
@@ -89,94 +71,99 @@ struct VbiosIterator<'a> {
     last_found: bool,
 }
 
-// IFR Header in VBIOS.
+impl<'a> VbiosIterator<'a> {
+    /// The offset of the VBIOS ROM in the BAR0 space.
+    const ROM_OFFSET: usize = 0x300000;
+    /// The maximum length of the VBIOS ROM to scan into.
+    const BIOS_MAX_SCAN_LEN: usize = 0x100000;
+    /// The size to read ahead when parsing initial BIOS image headers.
+    const BIOS_READ_AHEAD_SIZE: usize = 1024;
 
-register! {
-    pub(crate) NV_PBUS_IFR_FMT_FIXED0(u32) @ 0x300000 {
-        31:0    signature;
-    }
-}
-
-register! {
-    pub(crate) NV_PBUS_IFR_FMT_FIXED1(u32) @ 0x300004 {
-        30:16   fixed_data_size;
-        15:8    version => u8;
-    }
-}
-
-register! {
-    pub(crate) NV_PBUS_IFR_FMT_FIXED2(u32) @ 0x300008 {
-        19:0 total_data_size;
-    }
-}
-
-/// Return the byte offset where the PCI Expansion ROM images begin in the GPU's ROM.
-///
-/// The GPU's ROM may begin with an Init-from-ROM (IFR) header that precedes
-/// the PCI Expansion ROM images (VBIOS).  When present, the PROM shadow
-/// method must parse this header to determine the offset where the PCI ROM
-/// images actually begin, and adjust all subsequent reads accordingly.
-///
-/// On most GPUs this is not needed because the IFR microcode has already
-/// applied the ROM offset so that PROM reads transparently skip the header.
-/// On GA100, for some reason, the IFR offset is not applied to PROM
-/// reads.  Therefore, the search for the PCI expansion must skip the IFR
-/// header, if found.
-fn vbios_rom_offset(dev: &device::Device, bar0: &Bar0) -> Result<usize> {
-    /// IFR signature.
-    const NV_PBUS_IFR_FMT_FIXED0_SIGNATURE_VALUE: u32 = u32::from_le_bytes(*b"NVGI");
-    /// ROM directory signature.
-    const NV_ROM_DIRECTORY_IDENTIFIER: u32 = u32::from_le_bytes(*b"RFRD");
-    /// Offset of the NV_PMGR_ROM_ADDR_OFFSET register in IFR Extended section.
-    const IFR_SW_EXT_ROM_ADDR_OFFSET: usize = 4;
-    /// Size of Redundant Firmware Flash Status section.
-    const RFW_FLASH_STATUS_SIZE: usize = SZ_4K;
-    /// Offset in the ROM Directory of the PCI Option ROM offset
-    const PCI_OPTION_ROM_OFFSET: usize = 8;
-
-    let signature = bar0.read(NV_PBUS_IFR_FMT_FIXED0).signature();
-
-    if signature == NV_PBUS_IFR_FMT_FIXED0_SIGNATURE_VALUE {
-        let fixed1 = bar0.read(NV_PBUS_IFR_FMT_FIXED1);
-
-        match fixed1.version() {
-            1 | 2 => {
-                let fixed_data_size = usize::from(fixed1.fixed_data_size());
-                let pmgr_rom_addr_offset = fixed_data_size + IFR_SW_EXT_ROM_ADDR_OFFSET;
-                bar0.try_read32(ROM_OFFSET + pmgr_rom_addr_offset)
-                    .map(usize::from_safe_cast)
-            }
-            3 => {
-                let fixed2 = bar0.read(NV_PBUS_IFR_FMT_FIXED2);
-                let total_data_size = usize::from(fixed2.total_data_size());
-                let flash_status_offset =
-                    usize::from_safe_cast(bar0.try_read32(ROM_OFFSET + total_data_size)?);
-                let dir_offset = flash_status_offset + RFW_FLASH_STATUS_SIZE;
-                let dir_sig = bar0.try_read32(ROM_OFFSET + dir_offset)?;
-                if dir_sig != NV_ROM_DIRECTORY_IDENTIFIER {
-                    dev_err!(dev, "could not find IFR ROM directory\n");
-                    return Err(EINVAL);
-                }
-                bar0.try_read32(ROM_OFFSET + dir_offset + PCI_OPTION_ROM_OFFSET)
-                    .map(usize::from_safe_cast)
-            }
-            _ => {
-                dev_err!(dev, "unsupported IFR header version {}\n", fixed1.version());
-                Err(EINVAL)
+    /// Return the byte offset where the PCI Expansion ROM images begin in the GPU's ROM.
+    ///
+    /// The GPU's ROM may begin with an Init-from-ROM (IFR) header that precedes the PCI Expansion
+    /// ROM images (VBIOS). When present, the PROM shadow method must parse this header to determine
+    /// the offset where the PCI ROM images actually begin, and adjust all subsequent reads
+    /// accordingly.
+    ///
+    /// On most GPUs this is not needed because the IFR microcode has already applied the ROM offset
+    /// so that PROM reads transparently skip the header. On GA100, for some reason, the IFR offset
+    /// is not applied to PROM reads. Therefore, the search for the PCI expansion must skip the IFR
+    /// header, if found.
+    fn rom_offset(dev: &device::Device, bar0: &Bar0) -> Result<usize> {
+        // IFR Header in VBIOS.
+        register! {
+            NV_PBUS_IFR_FMT_FIXED0(u32) @ 0x300000 {
+                31:0    signature;
             }
         }
-    } else {
-        Ok(0)
-    }
-}
 
-impl<'a> VbiosIterator<'a> {
+        register! {
+            NV_PBUS_IFR_FMT_FIXED1(u32) @ 0x300004 {
+                30:16   fixed_data_size;
+                15:8    version => u8;
+            }
+        }
+
+        register! {
+            NV_PBUS_IFR_FMT_FIXED2(u32) @ 0x300008 {
+                19:0 total_data_size;
+            }
+        }
+
+        /// IFR signature.
+        const NV_PBUS_IFR_FMT_FIXED0_SIGNATURE_VALUE: u32 = u32::from_le_bytes(*b"NVGI");
+        /// ROM directory signature.
+        const NV_ROM_DIRECTORY_IDENTIFIER: u32 = u32::from_le_bytes(*b"RFRD");
+        /// Offset of the NV_PMGR_ROM_ADDR_OFFSET register in IFR Extended section.
+        const IFR_SW_EXT_ROM_ADDR_OFFSET: usize = 4;
+        /// Size of Redundant Firmware Flash Status section.
+        const RFW_FLASH_STATUS_SIZE: usize = SZ_4K;
+        /// Offset in the ROM Directory of the PCI Option ROM offset.
+        const PCI_OPTION_ROM_OFFSET: usize = 8;
+
+        let signature = bar0.read(NV_PBUS_IFR_FMT_FIXED0).signature();
+
+        if signature == NV_PBUS_IFR_FMT_FIXED0_SIGNATURE_VALUE {
+            let fixed1 = bar0.read(NV_PBUS_IFR_FMT_FIXED1);
+
+            match fixed1.version() {
+                1 | 2 => {
+                    let fixed_data_size = usize::from(fixed1.fixed_data_size());
+                    let pmgr_rom_addr_offset = fixed_data_size + IFR_SW_EXT_ROM_ADDR_OFFSET;
+                    bar0.try_read32(Self::ROM_OFFSET + pmgr_rom_addr_offset)
+                        .map(usize::from_safe_cast)
+                }
+                3 => {
+                    let fixed2 = bar0.read(NV_PBUS_IFR_FMT_FIXED2);
+                    let total_data_size = usize::from(fixed2.total_data_size());
+                    let flash_status_offset =
+                        usize::from_safe_cast(bar0.try_read32(Self::ROM_OFFSET + total_data_size)?);
+                    let dir_offset = flash_status_offset + RFW_FLASH_STATUS_SIZE;
+                    let dir_sig = bar0.try_read32(Self::ROM_OFFSET + dir_offset)?;
+                    if dir_sig != NV_ROM_DIRECTORY_IDENTIFIER {
+                        dev_err!(dev, "could not find IFR ROM directory\n");
+                        return Err(EINVAL);
+                    }
+                    bar0.try_read32(Self::ROM_OFFSET + dir_offset + PCI_OPTION_ROM_OFFSET)
+                        .map(usize::from_safe_cast)
+                }
+                _ => {
+                    dev_err!(dev, "unsupported IFR header version {}\n", fixed1.version());
+                    Err(EINVAL)
+                }
+            }
+        } else {
+            Ok(0)
+        }
+    }
+
     fn new(dev: &'a device::Device, bar0: &'a Bar0) -> Result<Self> {
         Ok(Self {
             dev,
             bar0,
             data: KVVec::new(),
-            current_offset: vbios_rom_offset(dev, bar0)?,
+            current_offset: Self::rom_offset(dev, bar0)?,
             last_found: false,
         })
     }
@@ -186,7 +173,7 @@ fn read_more(&mut self, len: usize) -> Result {
         let start = self.data.len();
         let end = start + len;
 
-        if end > BIOS_MAX_SCAN_LEN {
+        if end > Self::BIOS_MAX_SCAN_LEN {
             dev_err!(self.dev, "Error: exceeded BIOS scan limit.\n");
             return Err(EINVAL);
         }
@@ -205,7 +192,7 @@ fn read_more(&mut self, len: usize) -> Result {
         // Read ROM data bytes and push directly to `data`.
         for addr in (start..end).step_by(core::mem::size_of::<u32>()) {
             // Read 32-bit word from the VBIOS ROM
-            let word = self.bar0.try_read32(ROM_OFFSET + addr)?;
+            let word = self.bar0.try_read32(Self::ROM_OFFSET + addr)?;
 
             // Convert the `u32` to a 4 byte array and push each byte.
             word.to_ne_bytes()
@@ -267,7 +254,7 @@ fn next(&mut self) -> Option<Self::Item> {
             return None;
         }
 
-        if self.current_offset >= BIOS_MAX_SCAN_LEN {
+        if self.current_offset >= Self::BIOS_MAX_SCAN_LEN {
             dev_err!(self.dev, "Error: exceeded BIOS scan limit, stopping scan\n");
             return None;
         }
@@ -275,7 +262,7 @@ fn next(&mut self) -> Option<Self::Item> {
         // Parse image headers first to get image size.
         let image_size = match self.read_bios_image_at_offset(
             self.current_offset,
-            BIOS_READ_AHEAD_SIZE,
+            Self::BIOS_READ_AHEAD_SIZE,
             "parse initial BIOS image headers",
         ) {
             Ok(image) => image.image_size_bytes(),
@@ -403,6 +390,9 @@ struct PcirStruct {
 unsafe impl FromBytes for PcirStruct {}
 
 impl PcirStruct {
+    /// The bit in `last_image` that indicates the last image.
+    const LAST_IMAGE_BIT_MASK: u8 = 0x80;
+
     fn new(dev: &device::Device, data: &[u8]) -> Result<Self> {
         let (pcir, _) = PcirStruct::from_bytes_copy_prefix(data).ok_or(EINVAL)?;
 
@@ -426,7 +416,7 @@ fn new(dev: &device::Device, data: &[u8]) -> Result<Self> {
 
     /// Check if this is the last image in the ROM.
     fn is_last(&self) -> bool {
-        self.last_image & LAST_IMAGE_BIT_MASK != 0
+        self.last_image & Self::LAST_IMAGE_BIT_MASK != 0
     }
 
     /// Calculate image size in bytes from 512-byte blocks.
@@ -492,10 +482,10 @@ struct BitToken {
 // SAFETY: all bit patterns are valid for `BitToken`.
 unsafe impl FromBytes for BitToken {}
 
-// Define the token ID for the Falcon data
-const BIT_TOKEN_ID_FALCON_DATA: u8 = 0x70;
-
 impl BitToken {
+    /// BIT token ID for Falcon data.
+    const ID_FALCON_DATA: u8 = 0x70;
+
     /// Find a BIT token entry by BIT ID in a PciAtBiosImage
     fn from_id(image: &PciAtBiosImage, token_id: u8) -> Result<Self> {
         let header = &image.bit_header;
@@ -591,6 +581,9 @@ struct NpdeStruct {
 unsafe impl FromBytes for NpdeStruct {}
 
 impl NpdeStruct {
+    /// The bit in `last_image` that indicates the last image.
+    const LAST_IMAGE_BIT_MASK: u8 = 0x80;
+
     fn new(dev: &device::Device, data: &[u8]) -> Option<Self> {
         let (npde, _) = NpdeStruct::from_bytes_copy_prefix(data)?;
 
@@ -614,7 +607,7 @@ fn new(dev: &device::Device, data: &[u8]) -> Option<Self> {
 
     /// Check if this is the last image in the ROM.
     fn is_last(&self) -> bool {
-        self.last_image & LAST_IMAGE_BIT_MASK != 0
+        self.last_image & Self::LAST_IMAGE_BIT_MASK != 0
     }
 
     /// Calculate image size in bytes from 512-byte blocks.
@@ -786,7 +779,7 @@ fn get_bit_token(&self, token_id: u8) -> Result<BitToken> {
     /// between them, so subtract the PCI-AT image size here to convert it to a FWSEC-relative
     /// offset.
     fn falcon_data_offset(&self, dev: &device::Device) -> Result<usize> {
-        let token = self.get_bit_token(BIT_TOKEN_ID_FALCON_DATA)?;
+        let token = self.get_bit_token(BitToken::ID_FALCON_DATA)?;
         let offset = usize::from(token.data_offset);
 
         // Read the 4-byte falcon data pointer at the offset specified in the token.
@@ -833,6 +826,17 @@ struct PmuLookupTableEntry {
 // SAFETY: all bit patterns are valid for `PmuLookupTableEntry`.
 unsafe impl FromBytes for PmuLookupTableEntry {}
 
+impl PmuLookupTableEntry {
+    /// PMU lookup table application ID for firmware security license ucode.
+    #[expect(dead_code)]
+    const APPID_FIRMWARE_SEC_LIC: u8 = 0x05;
+    /// PMU lookup table application ID for debug FWSEC ucode.
+    #[expect(dead_code)]
+    const APPID_FWSEC_DBG: u8 = 0x45;
+    /// PMU lookup table application ID for production FWSEC ucode.
+    const APPID_FWSEC_PROD: u8 = 0x85;
+}
+
 #[repr(C)]
 struct PmuLookupTableHeader {
     version: u8,
@@ -900,7 +904,7 @@ fn new(
         let pmu_lookup_table = PmuLookupTable::new(dev, pmu_lookup_data)?;
 
         let entry = pmu_lookup_table
-            .find_entry_by_type(FALCON_UCODE_ENTRY_APPID_FWSEC_PROD)
+            .find_entry_by_type(PmuLookupTableEntry::APPID_FWSEC_PROD)
             .inspect_err(|e| {
                 dev_err!(dev, "PmuLookupTableEntry not found, error: {:?}\n", e);
             })?;

-- 
2.54.0

