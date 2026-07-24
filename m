Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17169C531FC
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 11:11:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AD6310F367;
	Fri, 24 Jul 2026 11:11:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="fK4Gy3hk";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011010.outbound.protection.outlook.com [52.101.57.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A325810F367
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 11:11:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ta3EOWWDkkkyhEsAGK/uUNgE2VrJQoSuGlmKB+S5NPL9ScA5LJCmN8hGKn5Ylh2ZapNqhE2JLG67xq768n69dBw39qHyswPORzayh4YuaKwZQIDEZZ1mBQ5UHhq+FY4JLcP3QC6vf+fDBqvCQLF6PnI5ZwqAyR1DS94a55aJGTswfUQTqvhQS+Ask+qnrlfIykdm2S0WMpt6sIAQUvo8sscJv2z0O0t+w0iOWN5ml0gSAFXFG/xbIS1zqxa+dhClUZSD9RUBC9G4D4ZPrc2TL3QBd4ykxkgXoTV3NvXElBqCG7O8GCjUOCcWqxyJ42bAlX7Hef6y3iLFCPMAwDfspA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmFw7Kyryi2PJMyxaxGplyYN15y1HaeQv/SLAl/QWYg=;
 b=vBRgE2C3vd19cirAXDANe2p9RHbkJobJGdI2wGHETBm9elkhOmbvSiYd9sHGBrff7ao0YJ96HEoPNO19VOk5hwH1d6PzmLQyjbRjl+SBZwzsdm9l4nRTiU8ihwDuW2x8u4MxD/KV/In1YmmD5+4aE4S8znbQzo6Qyz0qgWTx3f+bstW6Ck2mwS79sBAUWjA6VaexR/3R4t76XehjrUSE/zThZJWT8qLY575Fi+ucMTWOiiPR4kzrNY2wYO4bNpYMbYT/XvCI0/pDs73rBdB2V4m59tWeB58d4HR9XtQLinQs8bL8lGvNskT6cIRvCq5rIhlKpXef9QwIttjZ8B/t0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmFw7Kyryi2PJMyxaxGplyYN15y1HaeQv/SLAl/QWYg=;
 b=fK4Gy3hkJ7NhKtjd5xOnT9UBrUxbQsmxPtXpF9DcvV1D1mohE1K5BOx0KvTTOFUz2zj7EuI5/iYbau6nzAJv5rf3px5XY7xE7ABny5tP0JgGFhb/2YIUOr7bTAljEWKAoWbz1mNNAG56TJWQ9b4XZtVfGNGceBlb6S9QBzjWXostPQvxLANXSdsZ3xdnP4qqphy3T8MFPCrF7LoaKbiel3bLhN42c8hGpjtaLwtczIvXiv5NW+9V1HOE7BCdK1n70trt6Saj5Ucra0QlHplq2923L42+0QGoMv3Fqf7PS67agu+eMNehUOA2yLzZMuDuJiZ8uqCFLwkYbhWj6ejoDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW4PR12MB6924.namprd12.prod.outlook.com (2603:10b6:303:207::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Fri, 24 Jul
 2026 11:10:56 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 11:10:53 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH 0/2] gpu: nova-core: falcon: use I/O projections for DMA
 transfers
Date: Fri, 24 Jul 2026 20:10:48 +0900
Message-Id: <20260724-falcon-dma-projections-v1-0-957028a7c0a7@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QqDMAwAf0XyvICrMtl+ZewhS9OZsbXSqAzEf
 7fOx4O7W8AkqxjcqgWyzGqaYoHzqQLuKb4E1RcGV7tL3bkWA304RfRfwiGnt/BYCkOha9M2HNi
 TQImHLEF///H9cbBNz13fb7CuG/B8xd96AAAA
X-Change-ID: 20260724-falcon-dma-projections-ea9343cfcdae
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Gary Guo <gary@garyguo.net>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP301CA0036.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::20) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW4PR12MB6924:EE_
X-MS-Office365-Filtering-Correlation-Id: e11b002d-3c1d-4905-b3d8-08dee97439d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|10070799003|366016|1800799024|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: xIqzd2UcG5sacrP3a89mB/BtKjzqevOL6TkcnVBZM06yKWs1+8Sg6rxGkF+U96BwdGnBiH0D25pwWnCbH4nUxV+VTw6wFH/PulZ1CBi0bC5U8lY+tLNLHK4IpMBcjPxSdhbpRx68ApwiofziJE+nQ7C+lDKgj3vKa38hhW7MOk+c0y+hCsnAp1HhrVzY18LMgekAAuSGADbdQfdX9bBuqq/F4QPWN+2WsGJHHfXy58dadw8K+WBv3Nw+Zifi/seSCgSwEafWHA1ycp25lLX6UO7itfDqo91f930fqPStrMVyt0hdUZURjFET+/auJEdICaLzyFc4uHXtlZy0qooa+QdmvIqhleoiugkQ/BPUfVgzI8wDRDU7Ec2sigpQwONTyFsBpcnzNq+EUGL0Zbkjlgj5hCbeNWyvS0nmRiUJeWlWDQtdfBv24mhcedfDgXwxeVSvJ8M0q+fGvp9F9YQf2XhZYcrTemVSbWDzUivl8jZQvbI56pRdoH4K8w55UcqRNtLx6jNAqdKk1xJr52bJiahYPrsWVN8ZGlF2n1v2EP1bKrtKnbxhTrb0xpX+dkLc6gz/d4IfcyQpmuGrxK1U7+vEpZSPD8j3FYEQB3emDteZHE6b01ujuc/SXPnObcdAdHGVP9KACksLDAHxmkm/yr/qFfezos+/X9AWE2+UYkw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(10070799003)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3VDc2RRWHdBOEhLWkJOUlArRmlNQ0tlTmhURGlTWTRVeG1zakdIT1FLWDcw?=
 =?utf-8?B?YnF3MkFOTk9KaGd6eDY0VGh3TXlwaEs5REFKVkt5OUlKUG40NGJVR0tlRE03?=
 =?utf-8?B?anQxenI1ZE82RkpqQlBFS21zUUVESGZVclcycEVwMml1U0tqNTFBYlAxVmQ2?=
 =?utf-8?B?eVUrSUZoYzBGbUZHQTN0U1JLd2xMOTQ0QTRIbjJiRnJLL3JJbU9VR2M0Wm5H?=
 =?utf-8?B?MndvZDlMd3lRai9HcDZ6WDRtOTIvSll0MWd1cjNMMTc5VG14NFh6TGttYXYx?=
 =?utf-8?B?TGFVd0RaMUdKSTRGWlhkSWFMVHJORUJjMmZEMmZwQVpmNFBNRnkvUUgrOGd3?=
 =?utf-8?B?N2RYRURZQzJPb3ZFbUNydFg0Z0RzNTQ0K2oybjBsNDhPWm03L0tpNVFGbXp4?=
 =?utf-8?B?Y0pIMmNzQ2liQjNEYkRxOVpPSll3akpXUHA0dkpndTI3Tjg4Nmx3Z0E3dGNx?=
 =?utf-8?B?VFN0d0VVZlMrQXB1dXdlTWswWWRFaFcreG45SUNBUjk4N3Vtend2U1RyRkNi?=
 =?utf-8?B?NVJjajhDYTByQXVsNzdhUU9JeiswaUlFVEhmZ29rU0pFU2JlS1hNeFl6TUIx?=
 =?utf-8?B?d0YzMTA4L2luQUlHRnJNWnI4QVhjUDdnMlRkZUVBMW9qQmtPb3JBTzZDVDVi?=
 =?utf-8?B?RFJmQ0JzWjRMQkFlemtESndpUytNNHRIbGl3TllWRlEweHB4Qmp1L3VPRFJS?=
 =?utf-8?B?NDhoNTY2cnFxRDUzUGpBb3NsZnVyZ2JUblJRZG1CZmVVTlJxVDllS3EwZ1Bn?=
 =?utf-8?B?anVkaVNNM3I5Qy85emVIRkRPWkJNcFdWN2YxNnE3MmRobDUrUDkrL01mNU5M?=
 =?utf-8?B?WkthWUZGMm9uSEVwUXBPR2h0aW5QU0dMSG12amljUkJGc3hxSlhNNTk1NGdv?=
 =?utf-8?B?N0taeFNKaURvRHkrVXh0QXR5NEc5bllrSzVzaWp0andBWnAwZFFlSU5LVmIx?=
 =?utf-8?B?MGt5WnJKczRsVUtSV280aTl0WHNUcTA5OHRFZFB6eW1jMzVnZ2hUNXBwRm1B?=
 =?utf-8?B?L2daRjBCbXdFUkRXS3Qxb0R3R1Zmby80dEpmdXNMUzJySktEd2VJRGt3SUxZ?=
 =?utf-8?B?bFMyZmxKWTh3TlkzL2FwNXVKaHZ6NGV5Q3BtVkpNQ0F6OXRORDhOamNibnVx?=
 =?utf-8?B?VHh5eDljRWFKTTNuZWdkWkM0R3FJZ3JxMUcrMTZiWDEyRWpDdUhjaFJDekxh?=
 =?utf-8?B?MU5EQ1p4TUM1V1JJcmk1RjQvb3ROUHVnQjlscEdFTStQbzE0UU1DL0FITzBH?=
 =?utf-8?B?OC9jcnBWT3cvZkxqQW1icDhVNjQzVTgza21zaVI5Vko1eGtvOGFuazdwUVBl?=
 =?utf-8?B?dkpVQ1RhUzNtUHNhUTNwcmFKYjVIZjlic2J5THdDL1JsVlBBdFM0LzFpT2Z3?=
 =?utf-8?B?L0UwQzFJODZrMlhmTmZ2a3h2ZHE3Y0VNN25xSjJkU3NnR3VHQTFpM21QVVIy?=
 =?utf-8?B?cVVnWU1qRlF2NjBra09TZUwxT2JIeEhwQVJTWDl4V2JhTUE5MHh5Nm5uU3Nx?=
 =?utf-8?B?VTRZcHFueFFkd3BnVFRCTGNISm1IQmVCa0xNY25zeERmRlVDVVRDZFBmUmZI?=
 =?utf-8?B?VmtDMzcrc0hlRldrRGdQMTA4aCtRMVdrZGd3aDYxdzVaWUhZMit6Nmx4Q0ZP?=
 =?utf-8?B?ZUhLdGxpVjZsdTdGRlJ5bmlFS3duSDNpNlBaWkhGdHZvSUljdlFRRk9SRDA4?=
 =?utf-8?B?TkNDVlNJTHJUNGpPOFNHdVZvL1FDbE1BQ05yd20zNmQrV3FxT1RaZUp1ejdB?=
 =?utf-8?B?akVKWGFCUUw4ZTRJUFhMenVhUE1KSi9vU0RnOXpGRFN5OHlUWGFGVU1mVHRB?=
 =?utf-8?B?a3hBVisvMWcyK0lYT3BTUWhKOGNiakJQTnI3UzFhY1Zpdk94SndZS1haUm5B?=
 =?utf-8?B?UzJ3Z2dvckRQNzZsUDh0bFpDbUp6TWI2Q3NBUHVNVFJUcnFES1BBWjFIeXpy?=
 =?utf-8?B?RmR4eWRvSDd6OVFBVU9vb2w5UU02QnVTUlR5aVJKcUJ1MlF0cUN2VjNKdUFW?=
 =?utf-8?B?cVRqazA0cXE2U1c4VitKUTFEYlBsUDRYdDAwcTdoZ0NISk1IMGg2TENCRm1I?=
 =?utf-8?B?R0RJNEltWDJNSGp6MGJmbUFQdm1ySm9lQVBydzFLRy9GMTRlOU1SVkNWZ0h6?=
 =?utf-8?B?S2NUeFVzUGlmMlMwNnJFak4xb0N3a284NkM0T2NMemlrc09RU3hEOEMreDU0?=
 =?utf-8?B?MXZEamRUWXlUOFMzME9FaVorVHpETjQ4MFh4Z2R4Nit3V2hwbWVSUWRtaFAx?=
 =?utf-8?B?bEpUTHdYeStRLzhZQzBIc1pienpHeHA3cFRKU2dSbTQ5bWI2aG9PdnZIN3hk?=
 =?utf-8?B?RFFTcTYxdk5yREpnYUVqVGVhTXV2MG56cm10ZDRVeWdrcGNzVy9vdytQWFJl?=
 =?utf-8?Q?oja/id0lpknw24SltJxVlbLdQykAICPZiDHlw4Q9G3v6y?=
X-MS-Exchange-AntiSpam-MessageData-1: OwYrRfjZ7Mlcgw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e11b002d-3c1d-4905-b3d8-08dee97439d3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 11:10:53.2615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V96OO0eoFX4m9BG5jvwwgfhvIXY4UgYjl6GRVtACEm2Ca7YXH3GZuKZspMTcUNfen1E5x7eirCWc9AEv/3qp2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6924
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

Falcon DMA transfers were using cumbersome handle arithmetic and
explicit bounds checks to ensure a requested transfer is valid. This
series replaces this with an I/O projection which, if successful,
carries the same bounds guarantees and does not require performing
operations on DMA handles.

The first patch removes a redundant check that is covered by the
register's `try_with_...` family of methods.

This patchset is based on top of drm-rust-next.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Alexandre Courbot (2):
      gpu: nova-core: falcon: remove unnecessary check
      gpu: nova-core: falcon: use I/O projection to check transfer bounds

 drivers/gpu/nova-core/falcon.rs | 64 ++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 40 deletions(-)
---
base-commit: 6dcbb4b1320fa91fee349462a52bb69135f2e45e
change-id: 20260724-falcon-dma-projections-ea9343cfcdae

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>

