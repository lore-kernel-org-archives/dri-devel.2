Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E9DFCD0C5
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 07:16:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F30C110E6CE;
	Wed, 18 Mar 2026 07:16:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="VkEO6qmk";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010040.outbound.protection.outlook.com
 [52.101.193.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAB1310E6B5
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 07:16:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NF5h+EAMYELHS3iLKcyYYup8KLeiTzxtnciaSIK6c4YqY/vxuBS/qoR8uxoDatOnq7PBLv5XUcIsLNd47V9PwbbOlD/S6LIE5d3wRlk7UrMVw57Too4odE6WKO7jRdWXmIr7lB6Omy/JMNCQe+t6SLy7nHqmMu+Wg4ptAtm0DC6Xmk3HWbUi693m84G9oZYcisods3hOYir5Zpx4DrYkaj0m2CJ9OQGYE7CHrUDYx6vKZ1jNABTGGHsozgqdmaZ65GBabHJG2mAVgAsCYV2XY7R+ygLMZKTRZL5FpAm0rfjOEPL0mDYAUg/uBV45x2dAwU5uNiTJ6oK/QftRVgNglw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5wHaLeiWym0mnWXOKFYtk17jkvO4aDmTzYsMQvU1U1I=;
 b=Rjae1K+J0ApbMejebFESH7fr/iKbrXH3c1aNapjNH33ZLOkVsycG1J9EvhagcUQViqmVIWwJhiiAm+QK9L+gBlFu4liC6eMA7LBPZbIzVtankd32OBZBVwkCs/g2Bs0s4/wwAXE7jdb+qnFPCriO3kZ2517jxpAfPKMapFqesipVUSsZqh4K4gAZbgEb3j0ghzzYBmRY3jHJ1IyC5COEK+R6ej41jJ5NF5tcvg+0pruXUH3RMVNAXiRXU8Fxr5aBw5ecSKm/rK4W5BIbtb66U3hQBDH/3l8vepVQnkkOSQ8fROosaBEZUYr0fYHcZ/T1SZiG41TC3yHYeUctFKNBLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5wHaLeiWym0mnWXOKFYtk17jkvO4aDmTzYsMQvU1U1I=;
 b=VkEO6qmkxW0ZWSnE7ZyFMwKQDrzCixhyBzCABQ7ZsfOH21vcklFXpgHDpN27zGrLHdqZASi4+Ci9DYJ3Fzjc4a6/IzCQdmj6IssfmLKm1xEnvbyBnlQ29KaVEfrYh4fKaRyTO26xOti7kgQD833nqEBuRj3aL2U4txqrXhNzp9OhKHe1HKWDNEjy0sm3jFCNBiEOeaNm3vuLZHPYAORuMkoOQUDs6nTKdkPZSPQ9zBrTT6An63uv3ZKtmH3v/ExvZjmD7nZnC5Z9wbsM4imCI06d5jHOrPY7OT/K2QCfhg/A9FqBpU0iC9pTUH3OC1IVBEc3ICK17cz+4+6iscuemg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by MN0PR12MB5764.namprd12.prod.outlook.com (2603:10b6:208:377::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Wed, 18 Mar
 2026 07:14:40 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9723.016; Wed, 18 Mar 2026
 07:14:40 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 18 Mar 2026 16:13:57 +0900
Subject: [PATCH v2 1/9] gpu: nova-core: gsp: add NV_STATUS error code bindings
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-rmcontrol-v2-1-9a9fa6f1c4c3@nvidia.com>
References: <20260318-rmcontrol-v2-0-9a9fa6f1c4c3@nvidia.com>
In-Reply-To: <20260318-rmcontrol-v2-0-9a9fa6f1c4c3@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TY4P286CA0039.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b2::7) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|MN0PR12MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: 3919ef1b-e129-46c1-15a5-08de84be055c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2w5I5lVaTGKg3CLKDuHgX1mlMzkO6LgE7AfAXuaXh+ArNtwnTNKEyVV1oAchq3z+PqzPN35CNsZwwrSqv1C2utrfrVh7eonZ/r0HGPRxqdTNA0VJ2anVCKPk8G+DHq0r8fCAbLUoPGnBrBdyP3FGKGVvY/2+bCVni4vtFtloxS4eWo3zEwiRBvC9QoYBSB14WEEUkech+8fPudOrSmpmzEOV5WWPP0rnBSSn8vQB7nXHbzQD53QLkBm4FPxJcEAy+y4P39t1i2N75PswsUVO7zMffEJr9vyLAwlLldq+mpX+uIRlfaYGv2gDaGNAz+lhNNkq5IZ06gGE0tM8oydlEWUenZeR9x4FqfdOY+4uL9jqkWs3+xHLt3E8La5Gjfs52jiu20Ky+opG22mmB8/faCALyq3xO67c8WvGjCvRUzbFixiRRD/W/RyUjS3pJNep5lBej4TtgqpjO6YKZSRpBZcbVSo0KjUeWBPJU1MM5r5HE4dMfzGIAYHLL0x5LgqtQwfMIAebEmQWeO0DA6AeI+hdXsoErQeI9PE4JjpjO4qtI4EYR8fUimYlBjiukr41qFN7F/yv9uechEueQxOr+deY8ZzZGB4TDomo6ArBrOPRrSaVytK/lwS3QQCWuMdMs/8TP0oTuIrBlXSUmTjUZevinoWy9EZOymiccnu4BXhadFcCkvUNx7rrYw0F4DGA+Z7hTHQ21CcVwh84/NY68PQgbpt9kJgoFGJ1AmnIuqM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHJXb3hsbFhMa1BpaXYvdS9JT2Q5ajNtZlBvSW44UW9YUmVsT0hFb3p6ditS?=
 =?utf-8?B?bUc3MlFyZ0lKNUUzenQ1T3ZoTUcwK2dOR00vNlZIbWthQUdla3h0WjUwbFhS?=
 =?utf-8?B?NlVIemJtaWh6YkV2L1lXUTJ1WVNrNGdJWXNUZUVoYXk1NjZzbU1GSGZENFBO?=
 =?utf-8?B?dG9GbVNRUGYzZU15UjFNbk5RNDlDampmeHlacWNjKytFTktDUG1na0NnNk9L?=
 =?utf-8?B?ZVEwSVB4Zm1vbkgvbFpONjFaN3c4RWtrSGd2bFp0OVBEdTlXWktNQXEzZWhZ?=
 =?utf-8?B?aUhVWm1kZExBT2pJOHBCdVErOXdWTWlRYWZON2hoM2tBWUlSTWdrdk51RnFE?=
 =?utf-8?B?SVEwNVVuNTlRaDlhN2t6WE5EamtuTlJTS1ZneFM2TytVY0V4ZXJ1RXhEM0Jq?=
 =?utf-8?B?b1dXdGgwUWdvenlZZ29nQW12cEpqbWYzd08vYzdrdDVZbVJ2RjMzRFJIUFUx?=
 =?utf-8?B?Q3FsRWUxS1FreklKb3ZKNnRGUTd4dDlrdUhRSm5CbUg3UVZzVHhUdUh0TXl4?=
 =?utf-8?B?eE0rVjJWMU5vaHdJdzFkV1VTWFJheW1wZnlMWVloRnR5by8wTm5CQ29hd28x?=
 =?utf-8?B?UjNGdTNrT2FJb0h5eW9Ka1ltUFl2WTBZYmpiUXZEMzlzRExiQy9EMnNRNFo3?=
 =?utf-8?B?TDlvSlJxSDhjZEJhazhhMk9sUFUyUWZxd2pXRnZnL05EdmcvcGFHOE1XL2Vy?=
 =?utf-8?B?a1Btams4VTNUbTU0OWtXSEc3R3paOW82dG1wZGkzUGFDemh1YllpMFo5VVdX?=
 =?utf-8?B?MjF0QWJSRDFNYkQ5ZmNOYVU2cHBrd0xHTm92TThNd01oOWovcDcwbkZyWmhx?=
 =?utf-8?B?WS9oOWlFU1FCbXFrUEx5YnVRZXlsYTdhclR4YVN3OTJxQUpSSXlxZ0tkS2FT?=
 =?utf-8?B?Q0o4blp3UWlVTElvL29jZFA3REtoczRaUTFUc2JyRGFjZ2lXVTR5S21Lc1Vx?=
 =?utf-8?B?ZnhLS0I2N1JYeElwajRWaDQ1WGhtRUVFMnVhR2RTazdIbTEvU3dDQk1nY2VE?=
 =?utf-8?B?RDZBSWduS2cxbHR4ZHZweXpmNy81Nno4aWNHakNUbE1yc3J4WE5BOFUrb2R4?=
 =?utf-8?B?eTFFOVhydGFIMUVHaFZiUHdBZ2hoRmtPQ3JlRTd0bndyTTNlZ3c2aklJNDNX?=
 =?utf-8?B?b0V2dW9uajRJdVVsQ01yUURxMWd4TzJyamxZQ2lzYzFidDdpRUdDTUVVZ241?=
 =?utf-8?B?UjRYNlNuZUhFVW5wSFlrYXhhTnl2N1k3MGtVSHJIRUJ0OWpiTzVOYkthNkFx?=
 =?utf-8?B?dlNwTG5RclQ1cXk4ZnhQb0VOQmQyUjd2T3h5TWlLRXgvdkV1Z2RFWm9mYW9R?=
 =?utf-8?B?VWI3YWNOQ01uTnV4N1BrcjhDTVRBNGxZWktNc1Y1ZkV6SzZqNXpwVmJPUEhm?=
 =?utf-8?B?aFpXUGpTS2hYd2MrQ1M1eVBmbElqYTNSM0dBQksvMlU1cEl1UVpNRktvTkg3?=
 =?utf-8?B?MmdjcG5PMlY2d2twSEZiMXpWY0RRSEppbG0raVAzY3JOdDFjZVdOZWYxN2pP?=
 =?utf-8?B?Z3VuN0Z5WnpBNVJHZDNwUWdZODJUL09RaTIweEd5SGthRFAzdjFCellSRnJD?=
 =?utf-8?B?WjJnK001eW10clBRa2lxaTdvclV4NHVRQXE1eUZjc3dTL0RlWVpEYTZZcmxZ?=
 =?utf-8?B?WCs2RGF1bEZVeTk0d2RBdDI5NytjRFFTOTJRQldzenJoQy9ueGN6YStzNGtx?=
 =?utf-8?B?Ulo2M0hteURlWjBnVzNYQmh2NDhUNk04ZjBOR0lsYk9zUEFsNTh2SlhtZ3ls?=
 =?utf-8?B?WGFVbzFBNzZReFphZmRDaE9wZXQxbmRwZmprdEppRXBkcDhWVFVHdy9VcDIy?=
 =?utf-8?B?WlFCOGtGTnRvNUZoZUJSWmNjZjJEUVNjVjIwUEVKbkp5cWdRNFhKVE01cFNG?=
 =?utf-8?B?WGRENXVlMjcvQjZpR1dVVzJvamgvWTNEWkIvRk5HdVUrTnVWZUpmT1k3RXNu?=
 =?utf-8?B?N3RpS24vM2dFRUhBV2liWmNDNmtzUGJqdkxWdENxTmZRdWUzNTUxMENzNnpy?=
 =?utf-8?B?YjZubVpTRUlUN2daU0V6bjhoTXhxTXg5VHlOMy8zRzkvL050WUZBaFVibnph?=
 =?utf-8?B?dlg0bXhEcUkxYThySlNPeDFzQlJ2SjV4M2hSYVV4YjQwMHdXaTJNVktPMDc4?=
 =?utf-8?B?QTdDR2l4WGVOa29tTHFobWtsUkFibXk2eHRuYWJ6ZWRhdUErMDFLMzJNZkF0?=
 =?utf-8?B?SkZicSthMFdqMkhnV2pXWlJYams0L3V4Y0t1R1ZKWFlPZnc0SW9hT0s3d05V?=
 =?utf-8?B?Rjc3VjR3TTgvYXAzWVpWaGhqOEdmN1N5L2V3cVFCcm9VOEpzQmRWZ2p4N1pZ?=
 =?utf-8?B?NzBGQW5HT0x6L0NKOUhxOHFGUXhscDdUdW44cUMwSlpCUkRKUUFIbjFhUEJ2?=
 =?utf-8?Q?gx1o5ZsUSFaKYnLxzNmaG/YeGIxftDuIdp3iurQkTpXy2?=
X-MS-Exchange-AntiSpam-MessageData-1: IIssygaDmasU+g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3919ef1b-e129-46c1-15a5-08de84be055c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 07:14:40.3178 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8uzDIy1AWnyXx/H3pohHBp5N31Im+OqScU7WlrogNIZgbWcp+MvlX6tbtni7RANjd8Fl9bFOSSMyEbvqJGY0ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5764
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

Add bindgen generated constants for NV_STATUS. This is used for RM
control messages.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs | 144 ++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs b/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
index 334e8be5fde8..dd37a7fd58c6 100644
--- a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
+++ b/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
@@ -379,6 +379,150 @@ pub struct NV2080_CTRL_CMD_FB_GET_FB_REGION_INFO_PARAMS {
     pub __bindgen_padding_0: [u8; 4usize],
     pub fbRegion: [NV2080_CTRL_CMD_FB_GET_FB_REGION_FB_REGION_INFO; 16usize],
 }
+pub const NV_OK: _bindgen_ty_4 = 0;
+pub const NV_ERR_GENERIC: _bindgen_ty_4 = 65535;
+pub const NV_ERR_BROKEN_FB: _bindgen_ty_4 = 1;
+pub const NV_ERR_BUFFER_TOO_SMALL: _bindgen_ty_4 = 2;
+pub const NV_ERR_BUSY_RETRY: _bindgen_ty_4 = 3;
+pub const NV_ERR_CALLBACK_NOT_SCHEDULED: _bindgen_ty_4 = 4;
+pub const NV_ERR_CARD_NOT_PRESENT: _bindgen_ty_4 = 5;
+pub const NV_ERR_CYCLE_DETECTED: _bindgen_ty_4 = 6;
+pub const NV_ERR_DMA_IN_USE: _bindgen_ty_4 = 7;
+pub const NV_ERR_DMA_MEM_NOT_LOCKED: _bindgen_ty_4 = 8;
+pub const NV_ERR_DMA_MEM_NOT_UNLOCKED: _bindgen_ty_4 = 9;
+pub const NV_ERR_DUAL_LINK_INUSE: _bindgen_ty_4 = 10;
+pub const NV_ERR_ECC_ERROR: _bindgen_ty_4 = 11;
+pub const NV_ERR_FIFO_BAD_ACCESS: _bindgen_ty_4 = 12;
+pub const NV_ERR_FREQ_NOT_SUPPORTED: _bindgen_ty_4 = 13;
+pub const NV_ERR_GPU_DMA_NOT_INITIALIZED: _bindgen_ty_4 = 14;
+pub const NV_ERR_GPU_IS_LOST: _bindgen_ty_4 = 15;
+pub const NV_ERR_GPU_IN_FULLCHIP_RESET: _bindgen_ty_4 = 16;
+pub const NV_ERR_GPU_NOT_FULL_POWER: _bindgen_ty_4 = 17;
+pub const NV_ERR_GPU_UUID_NOT_FOUND: _bindgen_ty_4 = 18;
+pub const NV_ERR_HOT_SWITCH: _bindgen_ty_4 = 19;
+pub const NV_ERR_I2C_ERROR: _bindgen_ty_4 = 20;
+pub const NV_ERR_I2C_SPEED_TOO_HIGH: _bindgen_ty_4 = 21;
+pub const NV_ERR_ILLEGAL_ACTION: _bindgen_ty_4 = 22;
+pub const NV_ERR_IN_USE: _bindgen_ty_4 = 23;
+pub const NV_ERR_INFLATE_COMPRESSED_DATA_FAILED: _bindgen_ty_4 = 24;
+pub const NV_ERR_INSERT_DUPLICATE_NAME: _bindgen_ty_4 = 25;
+pub const NV_ERR_INSUFFICIENT_RESOURCES: _bindgen_ty_4 = 26;
+pub const NV_ERR_INSUFFICIENT_PERMISSIONS: _bindgen_ty_4 = 27;
+pub const NV_ERR_INSUFFICIENT_POWER: _bindgen_ty_4 = 28;
+pub const NV_ERR_INVALID_ACCESS_TYPE: _bindgen_ty_4 = 29;
+pub const NV_ERR_INVALID_ADDRESS: _bindgen_ty_4 = 30;
+pub const NV_ERR_INVALID_ARGUMENT: _bindgen_ty_4 = 31;
+pub const NV_ERR_INVALID_BASE: _bindgen_ty_4 = 32;
+pub const NV_ERR_INVALID_CHANNEL: _bindgen_ty_4 = 33;
+pub const NV_ERR_INVALID_CLASS: _bindgen_ty_4 = 34;
+pub const NV_ERR_INVALID_CLIENT: _bindgen_ty_4 = 35;
+pub const NV_ERR_INVALID_COMMAND: _bindgen_ty_4 = 36;
+pub const NV_ERR_INVALID_DATA: _bindgen_ty_4 = 37;
+pub const NV_ERR_INVALID_DEVICE: _bindgen_ty_4 = 38;
+pub const NV_ERR_INVALID_DMA_SPECIFIER: _bindgen_ty_4 = 39;
+pub const NV_ERR_INVALID_EVENT: _bindgen_ty_4 = 40;
+pub const NV_ERR_INVALID_FLAGS: _bindgen_ty_4 = 41;
+pub const NV_ERR_INVALID_FUNCTION: _bindgen_ty_4 = 42;
+pub const NV_ERR_INVALID_HEAP: _bindgen_ty_4 = 43;
+pub const NV_ERR_INVALID_INDEX: _bindgen_ty_4 = 44;
+pub const NV_ERR_INVALID_IRQ_LEVEL: _bindgen_ty_4 = 45;
+pub const NV_ERR_INVALID_LIMIT: _bindgen_ty_4 = 46;
+pub const NV_ERR_INVALID_LOCK_STATE: _bindgen_ty_4 = 47;
+pub const NV_ERR_INVALID_METHOD: _bindgen_ty_4 = 48;
+pub const NV_ERR_INVALID_OBJECT: _bindgen_ty_4 = 49;
+pub const NV_ERR_INVALID_OBJECT_BUFFER: _bindgen_ty_4 = 50;
+pub const NV_ERR_INVALID_OBJECT_HANDLE: _bindgen_ty_4 = 51;
+pub const NV_ERR_INVALID_OBJECT_NEW: _bindgen_ty_4 = 52;
+pub const NV_ERR_INVALID_OBJECT_OLD: _bindgen_ty_4 = 53;
+pub const NV_ERR_INVALID_OBJECT_PARENT: _bindgen_ty_4 = 54;
+pub const NV_ERR_INVALID_OFFSET: _bindgen_ty_4 = 55;
+pub const NV_ERR_INVALID_OPERATION: _bindgen_ty_4 = 56;
+pub const NV_ERR_INVALID_OWNER: _bindgen_ty_4 = 57;
+pub const NV_ERR_INVALID_PARAM_STRUCT: _bindgen_ty_4 = 58;
+pub const NV_ERR_INVALID_PARAMETER: _bindgen_ty_4 = 59;
+pub const NV_ERR_INVALID_PATH: _bindgen_ty_4 = 60;
+pub const NV_ERR_INVALID_POINTER: _bindgen_ty_4 = 61;
+pub const NV_ERR_INVALID_REGISTRY_KEY: _bindgen_ty_4 = 62;
+pub const NV_ERR_INVALID_REQUEST: _bindgen_ty_4 = 63;
+pub const NV_ERR_INVALID_STATE: _bindgen_ty_4 = 64;
+pub const NV_ERR_INVALID_STRING_LENGTH: _bindgen_ty_4 = 65;
+pub const NV_ERR_INVALID_READ: _bindgen_ty_4 = 66;
+pub const NV_ERR_INVALID_WRITE: _bindgen_ty_4 = 67;
+pub const NV_ERR_INVALID_XLATE: _bindgen_ty_4 = 68;
+pub const NV_ERR_IRQ_NOT_FIRING: _bindgen_ty_4 = 69;
+pub const NV_ERR_IRQ_EDGE_TRIGGERED: _bindgen_ty_4 = 70;
+pub const NV_ERR_MEMORY_TRAINING_FAILED: _bindgen_ty_4 = 71;
+pub const NV_ERR_MISMATCHED_SLAVE: _bindgen_ty_4 = 72;
+pub const NV_ERR_MISMATCHED_TARGET: _bindgen_ty_4 = 73;
+pub const NV_ERR_MISSING_TABLE_ENTRY: _bindgen_ty_4 = 74;
+pub const NV_ERR_MODULE_LOAD_FAILED: _bindgen_ty_4 = 75;
+pub const NV_ERR_MORE_DATA_AVAILABLE: _bindgen_ty_4 = 76;
+pub const NV_ERR_MORE_PROCESSING_REQUIRED: _bindgen_ty_4 = 77;
+pub const NV_ERR_MULTIPLE_MEMORY_TYPES: _bindgen_ty_4 = 78;
+pub const NV_ERR_NO_FREE_FIFOS: _bindgen_ty_4 = 79;
+pub const NV_ERR_NO_INTR_PENDING: _bindgen_ty_4 = 80;
+pub const NV_ERR_NO_MEMORY: _bindgen_ty_4 = 81;
+pub const NV_ERR_NO_SUCH_DOMAIN: _bindgen_ty_4 = 82;
+pub const NV_ERR_NO_VALID_PATH: _bindgen_ty_4 = 83;
+pub const NV_ERR_NOT_COMPATIBLE: _bindgen_ty_4 = 84;
+pub const NV_ERR_NOT_READY: _bindgen_ty_4 = 85;
+pub const NV_ERR_NOT_SUPPORTED: _bindgen_ty_4 = 86;
+pub const NV_ERR_OBJECT_NOT_FOUND: _bindgen_ty_4 = 87;
+pub const NV_ERR_OBJECT_TYPE_MISMATCH: _bindgen_ty_4 = 88;
+pub const NV_ERR_OPERATING_SYSTEM: _bindgen_ty_4 = 89;
+pub const NV_ERR_OTHER_DEVICE_FOUND: _bindgen_ty_4 = 90;
+pub const NV_ERR_OUT_OF_RANGE: _bindgen_ty_4 = 91;
+pub const NV_ERR_OVERLAPPING_UVM_COMMIT: _bindgen_ty_4 = 92;
+pub const NV_ERR_PAGE_TABLE_NOT_AVAIL: _bindgen_ty_4 = 93;
+pub const NV_ERR_PID_NOT_FOUND: _bindgen_ty_4 = 94;
+pub const NV_ERR_PROTECTION_FAULT: _bindgen_ty_4 = 95;
+pub const NV_ERR_RC_ERROR: _bindgen_ty_4 = 96;
+pub const NV_ERR_REJECTED_VBIOS: _bindgen_ty_4 = 97;
+pub const NV_ERR_RESET_REQUIRED: _bindgen_ty_4 = 98;
+pub const NV_ERR_STATE_IN_USE: _bindgen_ty_4 = 99;
+pub const NV_ERR_SIGNAL_PENDING: _bindgen_ty_4 = 100;
+pub const NV_ERR_TIMEOUT: _bindgen_ty_4 = 101;
+pub const NV_ERR_TIMEOUT_RETRY: _bindgen_ty_4 = 102;
+pub const NV_ERR_TOO_MANY_PRIMARIES: _bindgen_ty_4 = 103;
+pub const NV_ERR_UVM_ADDRESS_IN_USE: _bindgen_ty_4 = 104;
+pub const NV_ERR_MAX_SESSION_LIMIT_REACHED: _bindgen_ty_4 = 105;
+pub const NV_ERR_LIB_RM_VERSION_MISMATCH: _bindgen_ty_4 = 106;
+pub const NV_ERR_PRIV_SEC_VIOLATION: _bindgen_ty_4 = 107;
+pub const NV_ERR_GPU_IN_DEBUG_MODE: _bindgen_ty_4 = 108;
+pub const NV_ERR_FEATURE_NOT_ENABLED: _bindgen_ty_4 = 109;
+pub const NV_ERR_RESOURCE_LOST: _bindgen_ty_4 = 110;
+pub const NV_ERR_PMU_NOT_READY: _bindgen_ty_4 = 111;
+pub const NV_ERR_FLCN_ERROR: _bindgen_ty_4 = 112;
+pub const NV_ERR_FATAL_ERROR: _bindgen_ty_4 = 113;
+pub const NV_ERR_MEMORY_ERROR: _bindgen_ty_4 = 114;
+pub const NV_ERR_INVALID_LICENSE: _bindgen_ty_4 = 115;
+pub const NV_ERR_NVLINK_INIT_ERROR: _bindgen_ty_4 = 116;
+pub const NV_ERR_NVLINK_MINION_ERROR: _bindgen_ty_4 = 117;
+pub const NV_ERR_NVLINK_CLOCK_ERROR: _bindgen_ty_4 = 118;
+pub const NV_ERR_NVLINK_TRAINING_ERROR: _bindgen_ty_4 = 119;
+pub const NV_ERR_NVLINK_CONFIGURATION_ERROR: _bindgen_ty_4 = 120;
+pub const NV_ERR_RISCV_ERROR: _bindgen_ty_4 = 121;
+pub const NV_ERR_FABRIC_MANAGER_NOT_PRESENT: _bindgen_ty_4 = 122;
+pub const NV_ERR_ALREADY_SIGNALLED: _bindgen_ty_4 = 123;
+pub const NV_ERR_QUEUE_TASK_SLOT_NOT_AVAILABLE: _bindgen_ty_4 = 124;
+pub const NV_ERR_KEY_ROTATION_IN_PROGRESS: _bindgen_ty_4 = 125;
+pub const NV_ERR_TEST_ONLY_CODE_NOT_ENABLED: _bindgen_ty_4 = 126;
+pub const NV_ERR_SECURE_BOOT_FAILED: _bindgen_ty_4 = 127;
+pub const NV_ERR_INSUFFICIENT_ZBC_ENTRY: _bindgen_ty_4 = 128;
+pub const NV_ERR_NVLINK_FABRIC_NOT_READY: _bindgen_ty_4 = 129;
+pub const NV_ERR_NVLINK_FABRIC_FAILURE: _bindgen_ty_4 = 130;
+pub const NV_ERR_GPU_MEMORY_ONLINING_FAILURE: _bindgen_ty_4 = 131;
+pub const NV_ERR_REDUCTION_MANAGER_NOT_AVAILABLE: _bindgen_ty_4 = 132;
+pub const NV_ERR_RESOURCE_RETIREMENT_ERROR: _bindgen_ty_4 = 134;
+pub const NV_WARN_HOT_SWITCH: _bindgen_ty_4 = 65537;
+pub const NV_WARN_INCORRECT_PERFMON_DATA: _bindgen_ty_4 = 65538;
+pub const NV_WARN_MISMATCHED_SLAVE: _bindgen_ty_4 = 65539;
+pub const NV_WARN_MISMATCHED_TARGET: _bindgen_ty_4 = 65540;
+pub const NV_WARN_MORE_PROCESSING_REQUIRED: _bindgen_ty_4 = 65541;
+pub const NV_WARN_NOTHING_TO_DO: _bindgen_ty_4 = 65542;
+pub const NV_WARN_NULL_OBJECT: _bindgen_ty_4 = 65543;
+pub const NV_WARN_OUT_OF_RANGE: _bindgen_ty_4 = 65544;
+pub type _bindgen_ty_4 = ffi::c_uint;
 #[repr(C)]
 #[derive(Debug, Copy, Clone, MaybeZeroable)]
 pub struct NV2080_CTRL_GPU_GET_GID_INFO_PARAMS {

-- 
2.53.0

