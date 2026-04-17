Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69112F436B4
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 15:33:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC82A10EA73;
	Fri, 17 Apr 2026 15:33:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="aIFvvR2P";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011013.outbound.protection.outlook.com [52.101.52.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE43410EA73
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 15:33:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3niIko38qyHkqzFjBcw+jf494i2dOsnkgSNkVATFaGwlW8Ro0xvlxQG0V0dJL0mdQRrDzp9Iwr91Zh4k6qS5LPBzvU1GB2IxtM81TndJMCtTI/FjMNKlOOcm1lf6WOXcbc3QpZhx0sjd5XmXqCuzeMqbCZI9YmKfgHVCOC/nI/nn0CM1TdzAy5CCt0cWQ7zICsUvjAMUoEpibLo1URyKSzg6LKQ4WNTCz1fOeMIwWUXab2z2oEcLndAx1zhSpk4UBNhu5u1H/NqndRNiW1/7PZdhcpGAB3p4OFAP8TIyQIK/Oja74tUl7FDscBQEmCf/3jUUETXnTolJndNHtnTfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdE0hiFNZoD2/5avIlk9I3tBhV7eKZ7QaryF5h05bAg=;
 b=MsGZt1dVlGh9FVZgoPt+IrR3KgWUKuU6j/g7v/JY7wXvBtZP+YrXgy/o/GU+6aHYJoC4agQzm6jwIPceseFgBvy142aNk0O1HFSDlu+sUUOs31ADdNEaEaaljHhrXeCeKIQzTNhVb1CqGF0w5L2MhLkwZegGQ6T+OZ+tchJ888ny6mbxkZ4xXvFIlwfl4ZpTkR0iuECpqx/AHGw0rR+d0pxHYs6G6SHCOh34//K+bq/MkXrBslKrXvX2zp6KsoHHt6mgsGLOUsHorRdAZEOrw6FHKH40CxCKqJuyPMlcQCcHJX2QL0glqOwiQ6JJSDMKwX7JHOGt/qEDuEMUPz//8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdE0hiFNZoD2/5avIlk9I3tBhV7eKZ7QaryF5h05bAg=;
 b=aIFvvR2Pbfl5cC7R52vEiZ3VInIQP9s3WCVQnV7utbOTBkNwJI6/WWLWkn4t9MyFrCEkEHEaO6Y79vFAW5TZReF3R/Jt+MNfuKWSL9Ph405cNMgdDsjqT6VtBARd/721L7/nGx4oD8qyFxSyaX/k9FMJ9cheY6N2q3yY9rCtkizb6ZGqMwKqYbp67oOBKAyMLAiNp8wrVakfx6ZLm/LazmAqxNIkCfQMIe0bYOHt6LpsGjVEekGnlK5n24Tu9TNi9uNiyyF9YxTMkSkkVY6T71OajeZrASnXTXhYsp566Bewp2Ebb1DCt11b0j3WRE4PELgCnwSUdksk9BBO6NqOpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DM3PR12MB9389.namprd12.prod.outlook.com (2603:10b6:0:46::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.25; Fri, 17 Apr 2026 15:33:35 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 15:33:35 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Sat, 18 Apr 2026 00:29:19 +0900
Subject: [PATCH v4 1/8] gpu: nova-core: gsp: add NV_STATUS error code bindings
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260418-rmcontrol-v4-1-fda8c76dbb95@nvidia.com>
References: <20260418-rmcontrol-v4-0-fda8c76dbb95@nvidia.com>
In-Reply-To: <20260418-rmcontrol-v4-0-fda8c76dbb95@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYXPR01CA0062.jpnprd01.prod.outlook.com
 (2603:1096:403:a::32) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DM3PR12MB9389:EE_
X-MS-Office365-Filtering-Correlation-Id: b36a8f75-ba4e-4249-eb54-08de9c96b019
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 91zW1ffOI9drU4ON7HpQHhN9iIJPTrzoSj7E+F6y2D32YkDQouH5MlwnQ4JEO6lZ0EZpR06rtWdp0j+Opdr4Hrb11VT9BKgF+BSJvXWslJ9/DppEmYIKDe3e4kUzvDfpps4/yegQbI9I3jLmkkfLYG3s3yV9iepE49i7k547Im9Cd2uQKaYlc1cxl3SQw1t+NRMtJPkD/aQsHLf+CXPKJUgXT5cclqDXmWdqPKiXa9chO/DMgw8GcFNHg/dRA6GJfo5tu5JSknFvv1JLo/b4zvSoGN2Ix9oOlZFeGFsmSKYiV4uQzQ38hnQY6ina1iyulryLQL0mvMWFVtdQ9QCVU8GVMhx5o8XJq7Frht43R0fAqtn2WH4Zb4+a4XRNFzQjEN2URaDJZujqQe2swLBY7Cps0hJe9BJ0xAOUVj8nO+EbFwdvpeDsqooLgpznkPskS9E5KQilhx7FOVJxgfMEfjZCyQPG9il3Sa40uLSJ/yVGCs7Qmqugo0pxKA+vmlWEAxs9izxnDxNx1Bcfbr3+13Q/MQQj8QskqNjcSS9/w63NGZjNyg0miqV3IfSMJ81nyMg/laeezJf7W8T1QL3LZN0PYI/AsXRJw8sW3sXKqFEoUqQUukjTG9eZ4ZRM2IM/LlQNODNokcb+1S+2kQwUqgEdTM7BKieCBmdiGvoZ6N5X1ov2GHFOr2wuMsVChH5FVykQ3RoMFJM19bRDCx4QUNWctVioE76Sdg4HXJaEz/4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2RNMXdqbzFNTWF1NjZ1TW0vdlAvbUt2eTdjNjVrMmQ5NFdzM094Ynh0MlVs?=
 =?utf-8?B?UHZOS0NPNEwzamJ1T1Z0MnJ2N2xMZGNsNnR3NFNHalNveHVVNllTNGp4Wmxq?=
 =?utf-8?B?eitQVklobVdDYzRlbnhjeXdXVnhtY3NCbXBXdFVkcWlOT0w5cnVQS1ZyanpS?=
 =?utf-8?B?eXpDQlJ5cm1IQ0d4Uk13YzNSdXlZU1huM04zcXJsTUd5bmVIVmFHanJCdnA4?=
 =?utf-8?B?dzI3WnpLN2Fid3dqL1FjNVhZTXVrak8zWDI3bjVLVkR0RFUzUW1vS2dvaDB5?=
 =?utf-8?B?MXI2S2RBeUw4eTBkVGZ6bHZYbTFJSWFhWldoWkhKdmVZOTJYOHlOc2tXbXFF?=
 =?utf-8?B?U2F1OGptSmFKK0ZvK1NnMjdqUnZhVkVNTnBuSTduRFBhN2lkc3RTVi9SYXpt?=
 =?utf-8?B?TTVoMnF0cjBpeEp6a0VNTVVDZUNNMTlLd0ZYaURLOUZXN0tHZ3Rha1pmK1JW?=
 =?utf-8?B?N05xTzFqWTNUditkTW1oWjBxdDlEMVJxa0MxYUk0MXBUVVYwSzAzekFXalJL?=
 =?utf-8?B?UzJCQzR2TWpRcGlxTFZWK2F2YWlUUUFsNHF5SnZqd3U0R0FYWjRDbFNkcTRs?=
 =?utf-8?B?dC9xeWltRjJ1TXVSMFg4OVdpQkNxTHd2Z2lkalFrazRSOGdmcVJ0L1lXZXJy?=
 =?utf-8?B?V0prTGJwb1FtZXVVcy9hMkMwUlFwY2VncnhIcnBqWXFYVStUczI0enVVWENr?=
 =?utf-8?B?OFhtTkdXUis1NXpLMDlWZHAyUlJGVU4yNWVzRzd6emdxNk9QTzVIb0E3VUZz?=
 =?utf-8?B?UUx5dHpTekdXckNRaWdVUHZBSmJyL1NrUU54dmJDcG9XQ3dudkt2Mlg0Y3Zx?=
 =?utf-8?B?Z2lGQzI4NzBYMC9SaVBMQkgzRzB5RnlBSEVaMUdBRnZFZ0daeEhxZUxmbXNE?=
 =?utf-8?B?U3RyV0hqcnIyb2NHRDQvUzYwTmNoWWhoc21MTW5LZEhxc0JDcGNXd0RHN1Zz?=
 =?utf-8?B?SlROcThJWWNpNzFXQklHWGhjbGYvbktkMEc3eGgwSHFLZ2U0WUowVjNrcGxa?=
 =?utf-8?B?ZUpiOXhValV3SThVME1HcFk5bnVaMkRoQVFteHZqZytkZ2E2K2ptT0NJK0FC?=
 =?utf-8?B?dWF0WW1JWjFQQVpJWUk4OWV2TWt4bEVXMWlldzY0YnI5SHNIZ21UYU95WURv?=
 =?utf-8?B?VVEyQTFhUElOSzdGdlQ5SU00UVZpNEVDRTdjSDJDL1RLMjdQeXl5blJSSHRB?=
 =?utf-8?B?eTRXTlBNMUlCTEdsQ0FTNlp5RGhPeUh0cUJialY0aDNQTFg3TUxNK1F3MTJv?=
 =?utf-8?B?NjlBaDN1N25vYThZVDlvTTEzUTA0V0IwS2szRHR6UWRlS0VGcEdCMGY3RTJz?=
 =?utf-8?B?RGxVbDB2RGoxTUxBUWlnWDBsRFZWcjV0YWl1Q0dLMU16eDVCSTErUzExa0Z1?=
 =?utf-8?B?NVdmbWxieHVmdXNlZmF5T1crWVluaGFMMUZpTjl1ZEpKUmMzMnRHY3dPZklZ?=
 =?utf-8?B?SDFEM3RZODFQWUVIR2NBeFIzR2F6a3Y4UDc2UVlsMmw4V2ZUdjBOdXkycUky?=
 =?utf-8?B?MmRSbHYrS0p5UldIbVk2d1ZIZDRjRGFZWHphMkt0a0dEZzNHYUppWkpaQUcx?=
 =?utf-8?B?bDZ2U2MxazZFSy8rekRqMGhFa2dxcnExMHNNbzdzcHdvcVFUVTJjUG0zcUlS?=
 =?utf-8?B?WlZsbHc2RmRUWmYxY0RlM01KcC96MGJBZStqSjVUd0dya1RjdWJ1VzdzMmRj?=
 =?utf-8?B?a0wwOGtBMHNwV2J1dDlEcFJYbG5tei8xSjlzcitlbTdWR2dXSDFqZFc3QWkx?=
 =?utf-8?B?ZHhRMHJwT3ZrQnJUKzdVa3ZESzQxcXRmNzNVMW1RMlFHT3NsL0Q0V1M0RCsr?=
 =?utf-8?B?czEwWVJlYTdHejlZYVRESDZVOHhZb2lCc3Jjcjd4Ull6ZlJSeFBZMUJvZmFQ?=
 =?utf-8?B?cDg1dkRBTUgveGk0Rm96Qi93c0VFQ3YzNE9oS3lMQ212OVhPMkF4aFNFeC9Q?=
 =?utf-8?B?bTFLYUFENkFMZW80YzgzTEFrMkY1aHYrMjlTZnBMbFdlMWRnWWRvRFp0Q0hs?=
 =?utf-8?B?MmMxOXhSemxOcDFhVnd2UkJyYTgzRnl2OUdzUlhGYlZEbHE1cGlyeFdvTDBT?=
 =?utf-8?B?MGo0cWpuMENRS0s4Z09KVkt5Qk5KdnFacTFVMjMzbGdhaDRha1VqYWlVdE5U?=
 =?utf-8?B?ZmpBbW5ZUWJSZVBVTHFWajFyZ1BpTS8zbnN5dDJaNVI3RW9pZ3BtS2hrZjRS?=
 =?utf-8?B?NXNSUWM5Z0ZMMlJtNHF1alY2RlNWRWJ5N04vZERKd3pmT3pFMnp4YzFEK09M?=
 =?utf-8?B?dDlsVVRsdi9EZzdvK20vRHA3SkJQUXB1MENUbk5yVnBoK0xQVnBEOW4zbTJD?=
 =?utf-8?B?SUt2YUhlNk5QcGthRUxEdVd4c2R1dlBoUHRNV1RMejQyRDJsMkpBL0x6NUhI?=
 =?utf-8?Q?1m8wshy/lnn5sUC6+eQWFBKlVQWMAkSQk4QuzZIHqyf5k?=
X-MS-Exchange-AntiSpam-MessageData-1: P7XS6bAMvwR/Vg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b36a8f75-ba4e-4249-eb54-08de9c96b019
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 15:33:34.9306 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xti0vTbRxPFAToMR9mlpHqGa4Z4PFHvBGeDbRZ+ypMFPIwhYqKInCl81T27a4gcGJvepDi39WEPX1/4QnlBkww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9389
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
control messages and also generic RPC status.

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
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

