Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C3EDC531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 11:11:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A9BE10F36C;
	Fri, 24 Jul 2026 11:11:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="eEeXArI3";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010065.outbound.protection.outlook.com [52.101.46.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2619910F36B
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 11:11:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fUdSOK/3h9OjqcC0Ka7OS16i6KWsWCuuzaysEQCCgbkf0vlLZRXiDj3VCH1DDhw29MNU9q9UQ/kNmlvCX4ZzHUrdnMI0vxa7N4UUK2z5tOssN4VpawyLiN35n3uO7EbvIJlxSoh17wuA8kdXCvONV/AOJ3qMIkeWGmiiZ1d58M1whnILHVAo1uOXqIQxVlsZmBDZOKgtc6pmEbnJk1Nz6o6nir+upDQanIkr62Gt4+mbbqHstZJ+fk8MN32UN2xnwVidTQMsEP1JyyoKLVrttWVt7TBsEUrORGFc0Zb5DJlLPRIX9xWnoMEBUaDVzZZfwWMPzmCuiEMTwfLhFHmNAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9r0KhhaVBRImZbL2dex52cc2QT4SBmFC+/21PCuZCw=;
 b=FhUKZz0X3rjO31kZUVaLmzy5LenITaNWYlKJiXht6v+xxKCPSOepxeNnfGs24c6COJ7z9gCPB0uUFNhmqNFn64vGYqVtveAN/JjBOUhPI6hGO+jgRokkKzMKHKeYzg3NvDh2BBRTlRKy+7/h7H9RKdOsBjNfcOhHBSoefo3csrsQiBchiGuYaflYw/wHHAQlpJ808xqcRyNbr41O/GCxUTf+rrBJa9OdV3ZSydagB1l2ImUFTgTi2R5Mchc/BxvovGWa/cxcc31UHz5hpFL3/f2uskWaxbk7QbGNV55pZMKtwMgP/fN354o4/l0FbrqOl3HDnZlMhhELZnxwcHRmCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9r0KhhaVBRImZbL2dex52cc2QT4SBmFC+/21PCuZCw=;
 b=eEeXArI3rzwjgutIPayvKAjO70VUCqILH57/C64GCCy76pBykpwfhTye4wnbtzpS5NqMF8VPxlioo5xUy12/RSLAsq84Zt0gByraEgwGKuG83GE4v4ResBFyhN/wny1nKbN5S471G9dKTk3Pu6ZQnQXi1j+EVTDHsb639szg59vsnnZ9EuB7DUdKOruifyua5cDoK186erY5yUAYHIZoKEo3/wTdA3/mVvxd/qoVb1daOqgfawwMVYRXVd74kSa6IBji+D/urswXuuBzLuO9up++3DsWymnbtzItjzB0JRjQMqaRie5b+GQRl8VfKzvVF2XrKn1/lQExGagWtcA4Iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW4PR12MB6924.namprd12.prod.outlook.com (2603:10b6:303:207::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Fri, 24 Jul
 2026 11:11:02 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 11:11:02 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 24 Jul 2026 20:10:49 +0900
Subject: [PATCH 1/2] gpu: nova-core: falcon: remove unnecessary check
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-falcon-dma-projections-v1-1-957028a7c0a7@nvidia.com>
References: <20260724-falcon-dma-projections-v1-0-957028a7c0a7@nvidia.com>
In-Reply-To: <20260724-falcon-dma-projections-v1-0-957028a7c0a7@nvidia.com>
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
X-ClientProxiedBy: OS3PR01CA0061.jpnprd01.prod.outlook.com
 (2603:1096:604:de::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW4PR12MB6924:EE_
X-MS-Office365-Filtering-Correlation-Id: 51fe977e-2917-42cd-a89b-08dee9743fa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|10070799003|366016|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /XhhpFb/GEmXTgtBI004q8THmlbZhbWLVZn6AltBlH0AKhbJ8enI+iI93Qe1Ym9lfa6fQ72bQ9+GFabJYL/ZQ91ph5GeXPhujN8AKlqNZp85mQxUIFGbz1SGjENRBv2ZiqmvbWi9JhmA7lzbLpKcNou+2zv3cbNE8isfCb7qo2fckqNzqAuRDsdtpIg5ZNq/6YSXFB/tqzpyR/DlINcdFVbf+090YBeWHq1uiM/3IhslaOBRx/E+zIU3B0WEj+1lFhBmSvt1r/525ukLDSI/y7hRpQBI+lGsaEACdrG6RT/7Fk+2FRkpMABuV6efJXdPZLsebBM692rCKofvfexoXKOBP/qADuSv21GwhYHQ/Nko6EF5yoQCU0i/+ktKzAfVpslZ6qpXYFyysgIytvWzxpiM7yrf7VlVAJmcMv3TvfeHwXPadbg1PJ9Lb+prjixv7zKp9gL83/pgLxmN55o2nalUflK8nH8RUonsfMe/dQKkAPBMQnA8wXITh3LzY09wHRK5ZopTlFM5xoDsAgp7IQ9ZTQxvPwRmqKj4+udqFCkJaVoItvCyo/B/pjkZpHWL9dokr+281z3JjSMJIbzeQw+tZ+U0cf5uxMmtnrVBOFsmHyTu6HcUk62Ma+nOB/sdrGUD4DqlENdlu6UvhhabhoWPArL/K0vzeAkm/+oow3s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(10070799003)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0xUTy9oLzZMa1dwb3NCZzBLRzM2UXBmUUsvVm50TUtIQkZ6NmEvN1p3a2Fj?=
 =?utf-8?B?Rjd2cm51SElMKzdYK0M1bFFSOVROTThwMitXTVp5TmFoSmd3WXpSRjlOaFp3?=
 =?utf-8?B?a0xoTUczM1o4OTVadE5xRDZGNzRDYkJ1THM2eEJBT1JuVTlTREl4Tm43aTVN?=
 =?utf-8?B?SkMybVFqY2cvNThJYUFnQzNqUWNoOHZJQk5QNUI3NG5KeVBSekZrRlZwYVpR?=
 =?utf-8?B?ckYrbFM1UEFrVzRsWWJCTHBMcGQrMjVRalRFOHo5eWZkTS8xTWJ6WllBUUJF?=
 =?utf-8?B?bHQ1WTlJZEdDRExNN0RLR2VDZTNtTGViWEpPWFJBeGoyTnM5Nm0wb1k0RC9Y?=
 =?utf-8?B?NzFoakhQYWNLY3Z3QkhhbTZBcktHVk9vbXZLNjBzZGQwNm1PeUNCUU1aVUUw?=
 =?utf-8?B?WVFyYTFiL1hxY1crSVBOQTk0Q2F5dmFHazlXb2RnTmhYUmJkekJtZVRFdnYz?=
 =?utf-8?B?YVpjZUxaWUtrMkJGY0lZTzNPcmg4Mk9XUEFqWUlNcGI0T3dzVnBSQ2tnUjZO?=
 =?utf-8?B?Ykkrd2VldVd6VmlkVHRtZUNqMjRwRFZoc29XaThPY25WVXFhQkFPcStuQk1u?=
 =?utf-8?B?cXRHOTRQT2t6bkJzaTBWTlBPNngyeUJ4M1BpOW5Pck5nZlA4Znp5UENILzRk?=
 =?utf-8?B?UXJxbitpdUR6SFp6OFdSaDBGYnd2b1pXeGFGRDArZ043ZlZ6OVZaK1ZGcVps?=
 =?utf-8?B?TVZOQUhjSFU4dk1JYUhZV09jV0d4ZE5SNGNsUDhrQytnOXJSZjNuMUtGdkZY?=
 =?utf-8?B?cVNLaTQ0d2N6UWFEU3pEWW9ySC9WdHNTeHZRNE4rY0tnTnoyYitWMFZXUUVp?=
 =?utf-8?B?SEc3dXl4RHU3ZkZBYUczN3ZRanFKcGM2ZFZlRG1lK29DR1NmYzQ2UG5mZjI3?=
 =?utf-8?B?dXN6Qm42VjlDL1EwTXVaK1dxTGg1cDI5dHNxTWF4TUhKZTc1NDBkLzZUWDNW?=
 =?utf-8?B?U1dYMTBLMWhsN3lMWW91RWFuYmxvN3BVa2FjUjRTc0c2Z25hdTZNbytkREI2?=
 =?utf-8?B?aFBqcFlzRHh5YlcxQXEwUlVMenkxMXpIRGdwTXJEU2FycmUrdjJmaE9rTE02?=
 =?utf-8?B?R3pKZWtIZWI2ckRCQ3JmOTVvdEJuNzFoVmRCL1JxTzBvWEp3MGN2TkRGZkdH?=
 =?utf-8?B?a1FFQWpsamgzck9hRkF4TG5tS2xoVHZBZklOMlhSMEtZZGdmdkVGcWFVRERa?=
 =?utf-8?B?akl6T3ZEWHBnS1JZY250dHpCeWhERzdRSmdxWlVrMWNPdmE2UU05aUl2dzha?=
 =?utf-8?B?Z3FMMG5icTF5aXpmNzJ0V1RRU2VEeGIrL1RsWXV0QllJMFhFK3lLUDlyM2pj?=
 =?utf-8?B?SjViUGN0WURNWU1aOTNuSnM2S04yWWdXOTk1WnR1QTVhYVZMbnNqWStyQ25y?=
 =?utf-8?B?TmgyWXNXbjRDRGhrT0E1VkZob1lJRE1mT1k4QmgxNTNWVktPaENCZzhiUEh5?=
 =?utf-8?B?Z2pKVUVKL3daTTNiU3NWeGpEQUlIeVBIa3RXVDVxbmI5SzVqQ3R0UGRnODhj?=
 =?utf-8?B?czNqVHQ0c1d0R2VYSnZTVGpHVCsyWlozRTdrS0Q1Rks1RWZDMi9SVG1SQkxn?=
 =?utf-8?B?S3NCT3Y2K1pHSjVWMWpSWE9vNysrL0tGeTNvcW9pM05qbDVUWCtGWnVmR2xC?=
 =?utf-8?B?OXpaTnRScnZ4UlNIU1lLaHNVK3hXZDlLL1dsY1dkV0xMUGFQcmY1Ym1Ga3F4?=
 =?utf-8?B?SXZ0L1BLd3JPdE9BVVJ4ajdmU0c2ZnNLMENMQnJWekM1Tk5xTVFGbFpRVUxy?=
 =?utf-8?B?K0JLRTdJcnNtODlZblArZEFhNXRVMzFYYVhvTitmVEtyR3lwZzhudUp6Zmd0?=
 =?utf-8?B?WlBvN1ZmMlhVeDBTa1RnQmpMWm9jV1J2d3JmeFA5ZUh1Wlg0ZGMySGxNUW95?=
 =?utf-8?B?SmhjM0ovdlRpME9nVjRUZGM0V1dqSkdQV2paRWZBNkRycnk5ZFQ3akppdzlM?=
 =?utf-8?B?NjI1MzZDRXF2NVdtUDkrZGdyRUN0cXN4KzY3aFRxV3FlazBtL2lMa1hMWnFT?=
 =?utf-8?B?TlhwbFFsc0JQbTUrTHZVU2NpR3ZndFlFUC83bGhwMml4emFrMEs0SFlqakwr?=
 =?utf-8?B?NUcyYkhvSkdEY2xiR1Z6Szh1NUQ1N3RxRmxFTFg5cE5PL1EzVXZNdFhyTnRQ?=
 =?utf-8?B?ZXhXR3hlcDZiYnd1cGZRdGJ6UTJyNTZqSHlWVCtHRFRqVWNJMVlXOFNLT3RH?=
 =?utf-8?B?S0R2U0Z3V29HMWFtb3A0dVpLMjRJWWhDSU9FY2pRcm40NEg1U3hkNHVqb1gv?=
 =?utf-8?B?bnNsWnU1YjNpU1E3OWx0YVd2bzE5NGsrOGd6QmRkMFpBVXMwSHRhQUNUU0NP?=
 =?utf-8?B?NmkwampQaGxjQWQrb2hzRnFsTGdJdTVmbjNxRXZyaGkwenRUMUkvcmk3cUF3?=
 =?utf-8?Q?h7YC9vDdGxUszofT6J8yC4t+SJyF26tAkDeYj/hm/JYuc?=
X-MS-Exchange-AntiSpam-MessageData-1: dproo5fUoq0PVw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51fe977e-2917-42cd-a89b-08dee9743fa1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 11:11:02.7676 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R4i43M6VBimH0yOdOWPZ37Rm7QtO2W+HsbwigIAqCKTcXmLPPjVDZ0RHG3lzI708K7a9G5Ij4U+ne0p3pn5puA==
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

The `try_with_base` call performed on `NV_PFALCON_FALCON_DMATRFBASE1`
already returns `EOVERFLOW` if the address is too large for the
register, making this check redundant.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/falcon.rs | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index a91cbdd5d636..cd05985f5ee6 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -9,8 +9,7 @@
     dma::{
         Coherent,
         CoherentBox,
-        DmaAddress,
-        DmaMask, //
+        DmaAddress, //
     },
     io::{
         poll::read_poll_timeout,
@@ -534,12 +533,6 @@ fn dma_wr(
             return Err(EINVAL);
         }
 
-        // The DMATRFBASE/1 register pair only supports a 49-bit address.
-        if dma_start > DmaMask::new::<49>().value() {
-            dev_err!(self.dev, "DMA address {:#x} exceeds 49 bits\n", dma_start);
-            return Err(ERANGE);
-        }
-
         // DMA transfers can only be done in units of 256 bytes. Compute how many such transfers we
         // need to perform.
         let num_transfers = load_offsets.len.div_ceil(DMA_LEN);

-- 
2.55.0

