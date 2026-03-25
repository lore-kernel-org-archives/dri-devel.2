Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F152106B50C
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 12:14:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C787610E894;
	Wed, 25 Mar 2026 12:14:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="RvhcHqK8";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011007.outbound.protection.outlook.com [52.101.57.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C74910E88C
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:14:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E39tb1YKz5pRCbOqpwNCZoI4fSZ4zYdkVguZO2pN9+0LoJt57bHVc9Xn9O4rI8gx5BJjWD2fekVwr4Yk8E65Wa0EpT6+LI4japuajneRky5gPd3bxiKYUueqJMO89SguQ6ervqa7axiOv/3zgxz6EWoXn8+WAVo4yjityeAGeUAdFgFOldT7jiGWFhT7YaKEgD28Pb5SYfjm8xmKzFQ0B5oPLzEPrwM8k1RJTDG7X8NRDZPejAc5KZDlVIIhIyzEiVPTFXTGeGTyY0kolNWGhNksbzkX0LrB3e/25BbShVbTiJ3ya+nuiXxbLpYrjqpsg0Lukk0IIgXdJvaKjB9mLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5wHaLeiWym0mnWXOKFYtk17jkvO4aDmTzYsMQvU1U1I=;
 b=WGMbexU5vHQWvMsIGpK05iI1toEM7RYog9YULgL7uLK93efcbcszguT1qPR8N5/luvGot3pRNoaVCLViE9wpfkziQ9ym2T9S40ZlG6sBIVOAnHZy0DMS90ROxO4pfgOrxCna8gxVthBVei8P2d2yPmhtHO7y5MG6SK9B1XgJAXAoofzBO1xgaxQigFBrFTGqVd5TN7UrhZ+lanUjGMN5vj4n1z/xG6djwQkaD7Kc/aIqKwlx1jR4skQ+yexomrVDFTc3q3y9MTvb9eTpxisDpJmW+GoI2bZwf53iMJMHO3cNpOyQwQarLR0nDBUzGWO3zZkvbHjbeI7hPAFekPMbWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5wHaLeiWym0mnWXOKFYtk17jkvO4aDmTzYsMQvU1U1I=;
 b=RvhcHqK8rhpfXRbGfg7IOdcTGYoVkv9uyZcNIjTQz47t+QvZ6uN5+IKZBcPLRc/SUQTeiKRxOOEq+8QAdfW1OjkJpkBj8MCf4oGEipA9nPNlX75eFC6OjVcw6Uk5SR4DAyndS9JrLzUPd9TTcOCye7DkmcNRaToUNSTlPf49TOAcTYq78ws3AtpWAX180ZV5d2h4aQel1cIrb4i8HkTEhTMZeEgXnBKSl9LZILNsYB89jTfJWKO4OPsjBjtbFyRDtVAi6JvZxe2zWTHJWIZ0mjo2b/200JmB5z5oA7etIpgz9LuMvd8aceVVA6L4/u62QEwQxpnHwCQ5iVwGqzs4yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 12:13:53 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9769.006; Wed, 25 Mar 2026
 12:13:53 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 25 Mar 2026 21:13:39 +0900
Subject: [PATCH v3 1/9] gpu: nova-core: gsp: add NV_STATUS error code bindings
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-rmcontrol-v3-1-f3101093484e@nvidia.com>
References: <20260325-rmcontrol-v3-0-f3101093484e@nvidia.com>
In-Reply-To: <20260325-rmcontrol-v3-0-f3101093484e@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.0
X-ClientProxiedBy: SJ0PR03CA0075.namprd03.prod.outlook.com
 (2603:10b6:a03:331::20) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DM6PR12MB4298:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ccb2537-bf7a-43ca-cf0b-08de8a67fab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|10070799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZqRyDyY8FMNBJA928mHeLkgv35pCPVvsvnGwH3OcLNnxV38PoZ/l2Jzx9fdwOsvPu0Or15PlCacZWFdN5HweHng2YEAcD32s3sLITFfF5x30+UWEyMXTgjqqpBzKy8VbqVvbiiOnNmYecw8a5evtrjLF/bK8wBTF/Bq1pmE2RMKBQKxxG8EsSE/hIJnEzKnpiQf8LtpqsBqmOLx6QGUwX7kq0VJeAIwcBGgYSRj7uj3wefYV18HJC/O5Z3xueWSYKMqunk4b63qBmjsDZ7G76iZXF1P7AwQwUFnxzYvIEtN/s8WXGFLgLn8Sk5h3XLOcfC29X/tCA+/bdBSoB15WBAzngpkmyfMiwHnJ3lrTLvkzmlJvN1rS6YEoyBGfiWkGHPtoZLM8Z/Llbc6Ms2jb8qywcJoWgvzgTZ2GxwP4ahWiKVUZwArec/mODnZCVOJEsLLoqsO5RBZSetCVXnxJkJCQ9U3o44wMQ1H3m2sKTHqcznIGJSTSNfeBcd7GSvzDmf2GzFdJk5POPWXloHinedWDxkprUYHWf6/X57c4ut/r/ctri2mwgCMHYrmr4ws0Gp+JHIyaP0G0LSlhwXJRbwF5OacMeFzkLo+ckNaf1GKbWhrE2J4Ch9r+ODoBqptlNj4rKSQjloF0jspITqKyZZsRRttdQfFOJI59LM6U+xVzaJv3T2PIXk7+bd2cLF3aeTBMs4uTW9k6PqcDIOh4sJT5wbmvnzaaLjHRxoy9J3A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWFMQS8wY3dMRTFxbWJvclgyVTFEVkRxK3JmM0NidGVPYzFic3RwTnlybjBB?=
 =?utf-8?B?Y1FsaWREZk42TCtTTjJ0dnJBRUtwQlNhaWtWaHNyblo0Ui9xODNjRHJGd05s?=
 =?utf-8?B?RzhrQXE2S0QyZW1sb09hT01OZEQ0akFidGdpZ2FIMU5jbXRjQjVlTUVVNU9o?=
 =?utf-8?B?a1dUWlcvZk5jekgrbWlxd2ZKeHR2eEttN3pnU09LMGdzRTIvODBoanpDMTMx?=
 =?utf-8?B?em53RFZJSFhoLzF5U282bEl0ZDkzalVINkdReVNFTkE0enRCM1lMczVpN2FJ?=
 =?utf-8?B?QTA0d1Fua2ZQRDVOc0ZNbTNGVGRwNWNJQzgvRU5RNmcxWWZtazh3NThJK2pX?=
 =?utf-8?B?dUsveWlOcG5zYVROM2VYYzJpcUplaVQ2YXJERWtWZnlmUWZlaUdGd0Z2L1RL?=
 =?utf-8?B?OHdNNlZ5OHRhZWVBejFFeVRoTm9JV0hPNkxGVE0rbTZpR2VxWVhUQ0hjNWxT?=
 =?utf-8?B?S2l4VHZ0dC9BbVJianlGUnVmUnQzWmk5VFBWNzMwTHlDV3lwclJnTkFMeGxp?=
 =?utf-8?B?NzYvMXhlZ2pHY3lySzN6VWpncXpwWTcwVERRRHpYTm1zdFJoemhOM3drRjlm?=
 =?utf-8?B?NWoyaFJrNEw3YS9HcUYzMFJiWTY1LzdieGdtRm5OZVp2S1lTZlhNQzRQRWZk?=
 =?utf-8?B?ZEQyZWlGaklicm9yb2J0c1Q2eTR6L1Q1OG1mM2FmUGNlZzlqaUhzaEdnanJ2?=
 =?utf-8?B?bWUzRXlpMEtwejNlSnNzc1VJbThjelNObUJpN3FOb1FGNU9CRGoxdUtsbC95?=
 =?utf-8?B?YWZKM084Ujlwa1ROMkgydFVXY2dMZGNidGZSQUwvNS9rOWhMRGdmeGYvUHUr?=
 =?utf-8?B?T1JVUG9rdmRoVE5lUmJkdDRvOTBqdmNzOUdpODlFbStOVGl6MjRCa0RuaXVm?=
 =?utf-8?B?ZThLTzk0U2FPemxkQTl5am9uUXozcjJocTl2SWlJb2EzaVVJMGVLTlZnajFP?=
 =?utf-8?B?dnFIbkNtWlJaK01uS0MrOXVHZDRsZ0ZyaDBFNUhRNEIxSmZMN21lZmNJVWcx?=
 =?utf-8?B?amlzME4yOXp4aU5Jc01ReldjRzNMeXlXM1IrK1E5NnRyK01OVTBJZHR0cG9P?=
 =?utf-8?B?dlNOVHRPZFkwajNDSjRkSHJieE0wVVVTb2dqbnpFb09ZdUMzM2dWQWF1ZEgv?=
 =?utf-8?B?emRPSkhtcWhxZ2puZnRSUU1DUENzMkZFa3lKZWhvZ1FNbnNXWittOVdQK3V3?=
 =?utf-8?B?TDVpamlNaVR5eUNFaGpVR2loY2NyQ2NIRkl1WFg2anVxN2RUN3AxSEoyNUE1?=
 =?utf-8?B?M2c4QmQ2WVVScEkrVWNwdHhwVTF4bXlENUZHa0NDQW1DMXRRY2NhNmZRb0FU?=
 =?utf-8?B?UzZ6MFBxelpYQmVadFpuRHpWODRkcXVCYW9Ba0IyNExPZW4wK1F3R09uKzJ0?=
 =?utf-8?B?YzBOV3NON1k1WWVlNHVudzRiQjByTVcyTXZjaGQ1c05Ha3FGMmswN0NIVkc4?=
 =?utf-8?B?NGw1NkdiY2FCUFNHSzlaOWZNejhjZFJmdXhST0x1ZkxPQi9LTFZWUkRTOHNW?=
 =?utf-8?B?ek9nTFJ6aUR4ZXBuL2x3SFBVL0ZqMzhoOVlQbTJHcTJJZE4yN2UwOHB3ajZ0?=
 =?utf-8?B?dUFBTHZWSFhrbmVZeXcrWHZTbXNxenJGa2Fpb1B6N3MwdFQyY0xMZkdjZkQr?=
 =?utf-8?B?VThDTlVKejRaa1RWWjBxYmV4bytEdTJvREljYlV1NmM5QUFGcFREclYyMXM4?=
 =?utf-8?B?ZVNoZXYrM3pRcVJkeklaWnF2amxQZUNLT2oxWEJqZE1zbGZrYTRtK2hKRXd1?=
 =?utf-8?B?MElqMFQ0WkpZRWg1dDdzWGhLZXRGcHFSdCswdzZ0aVNzR1A0KzA3TVVPRGF4?=
 =?utf-8?B?d0NZaHE4bStxZDBvVC96ZTVGQW41MVR2TTNTK0lhejB3M3JSRUdiUG5aV3lO?=
 =?utf-8?B?dVl3aU9HYzFsR1RqODVvOUFiTUd1aENFUmxpR1EwVzhyQmJxUm1OckpiRndG?=
 =?utf-8?B?c05OVlJUTGd1RjFvOUNmd3JwV1NaWDJ2SjBlR056ckZFY3hTSkx1L0R0aGhF?=
 =?utf-8?B?L2NwTHo1eENudW93OVNHQ01PVy9PRFdaT1YwM3NzUkZvcVk2ZVpXRjdCRkt5?=
 =?utf-8?B?dXo5Tks5b1VlU0g0YUs2QXFKbDZRdWhzM1dJVEhxVzFrSWF0LzVwZzJxWjVk?=
 =?utf-8?B?WTdDa2R6OG1ML0ZCd0ZRM0FHWG1sWWhVYzhzNDRkOEwzUXVuTXl0QTdoK095?=
 =?utf-8?B?Y1p5TGJraGdUVUl4YWNFU01wUnRWNjVoUFR4OHFEcmdYTDI0WlkxWHFkS00y?=
 =?utf-8?B?emNsenBtTHJsMnl2Z3JQNFVuMmFJVGNwVmc1Snc5YklRWFYwRG1OQlNYUTNy?=
 =?utf-8?B?OW9EbWI1S2JpMExTY2tRVXkxaGtsQ3I1QUh5ZE83SDcwOVpFQXA4U0hDQkp5?=
 =?utf-8?Q?Q7eRx6CgwCkanfacUpFkTkOfYbAuXCZwCfJVCdx31qMjm?=
X-MS-Exchange-AntiSpam-MessageData-1: sfD6w9L8PlicpA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ccb2537-bf7a-43ca-cf0b-08de8a67fab7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 12:13:52.9219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fBgJPP8PNWDjzH5perIwxsbEQZrzztM/o3abtDZk6Ovk2qtQ/dCzjXG4JDLTOQ4id1BT5gL30+b6lXggRx5Dfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298
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

