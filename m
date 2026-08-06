Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E6D5C55838
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 07:36:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90FE110F10D;
	Thu,  6 Aug 2026 07:36:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="QWX0Zn4A";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011040.outbound.protection.outlook.com [52.101.57.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3708210F10D
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 07:36:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OGDuLAM8NAaUdr4p6uEljN5CoRRNPjlvCDOM1CxaVkHwSm8iNs9eKTRDCCXsl67f1mLq1Ewz5UulxcnwTIllRcsEY3y4QZGWQDSGNnZOi8wRZWioui7lCvi41eNSImZF02ueomEqFfOPO61UnsNBNOvcbn/lj+GVgQodZajcegQura8WKUpqHjBzxmwjW9TxJiMGlaICORv1i6H4dCaBeYWuABS7lIHGMbAIUu/GQbsqouqs7g6hjfYL2OSkkF0OAvuBH95Yl+F8Jbjysm0yfiP4Pcp6Kyq9ewk91+f3i3/9Ut+JmA9yroRfcBhHC8KD0ynUlXm/PcKVXXxq386zjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2x0K2C+2AUoj+aDSk33iAFJm31vdhGpz60oxtJcjmAg=;
 b=rQCZk4qGZ3ffaHoa3T249DSZxHsWvYLI6OZ4BTz/EUsqGAWsmSXdDLIPxKwc75QMF2X33f/39RExVmHg9AMWek+SkgirggXBniRFkr/3eHHq2L8kF8Jmf19YdbnUXae4GKHAIfe5906Kw1+SyFefazp0knODybAS7o1gTgckU+DrxrKKVCqGXM4H7rMRoUmtenCSpjonFUMFl8resU9j6Zb0P1Lh7J+cAeoVOIwbJbkTukrXPp2khzO5spXnseIwP+mNyFvVVdOpqIDsJU5Rew/g9g9XMmixRb4Q+O89Rw25v2D3v+sHT75AbMqCf3FzM6obz442QW66foRN7/PS5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2x0K2C+2AUoj+aDSk33iAFJm31vdhGpz60oxtJcjmAg=;
 b=QWX0Zn4A1hNYBxPcBETV+CvdvTuWovks8FJsi3z6/ryv/0OPT3Xm4/LdGR3+9Qao/GShjBckKtJr0hAVYr3NvqtwIJ9htvWcV+SRv7LyVnfq92Vg4rJdl5YVN9ZFzYhK1SAAWW173O2ASvDekpYP1/NIcGsCr6B1jAPkA7qvv1/6CCALPcVsu/zS18bhaYgfu9DmicyaONOx3boLp5aijFplRdFr7GPy63+4zJcWeXNfUmyK3zBdGFeYAktnozG1QnwDtTfUv4zXcI0Bg5bH54gBJVB5JYVnNOFwEyfFBiOQzKDmVrlBSrCIb3VDgFZ2Aev54hb9uv9JOAx2GzMlLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB8878.namprd12.prod.outlook.com (2603:10b6:610:17e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 07:36:35 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 07:36:35 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Thu, 06 Aug 2026 16:35:54 +0900
Subject: [PATCH v2 2/2] gpu: nova-core: use kernel lossless integer
 conversion module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-as_casts-v2-2-cb76a4d3a6ef@nvidia.com>
References: <20260806-as_casts-v2-0-cb76a4d3a6ef@nvidia.com>
In-Reply-To: <20260806-as_casts-v2-0-cb76a4d3a6ef@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4PR01CA0080.jpnprd01.prod.outlook.com
 (2603:1096:405:36c::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB8878:EE_
X-MS-Office365-Filtering-Correlation-Id: 35035d9b-7b83-4086-d00e-08def38d7114
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|10070799003|366016|1800799024|921020|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: hpMsi8MbXu55oYlR/VoHFu1Q5ce0i0EhGJS9NIi6vZxgaYyzslA1HTfI8NAD73UZAb8BBLyTQGYUuHI6dQDpI+N6yz1nRVIfVbC6jbDXgOydU4Bk3JM6eVzWqA5mcfiRavoFw//VUe8DGhrh9k50ypjm3n5yVRJJdsZo+hiK71+zq1p9aesaXB4S5NUZ1yxjJMSo+pZKuVnvN7Fvz+m0dHiRynw6bezRZwo7NFF4wmOf6bSRspM1TreYpWGCu0IataNnfDVcHOIGn1VzE2nooWjytNBqSQDmqbT0CWooy20/B7DPWYjkrNs6beRl5wVq/TA0bvvRJcGFcifFD64wwN4heY1nwgWopvV2hoQs0crMlFqyp6YpSxpX3pae31Sj/hOYQ+OuelbAw7nYUzdKxeoLuspNNuWSzMts3K4pUsMi+j62NdPNQR/mFNTm8S5MF64oH5nZ64CCOOHpsmkSLmnTDudqbXhFkjUnRBArLKXbuGoS8nOnhpwXfdegNvYzIhduMLzPV9/xPujdwsH1vv3vkWX9y9Z1jONjx6LENIg9fq0puGtAcXa1rSKRchqtV8aK94CDQo9KnQFJbGQNr4FlvYGqIZntjNSHTLPDPNzgEHPUlVIW7KwjBNltd/3LxvipPClpzoksRvhD8APv2eyGvc9EKnw0+NrnQ8pXterzU8pivDrwNuySJTXhcF4869yRAbeSk41iIxkHfIKQyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(10070799003)(366016)(1800799024)(921020)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkJTQU1WaW1JS1BqcUlZeXU5OTJjS3gwWFFPUXNia2hVMHNXSDMzeE5aRnI2?=
 =?utf-8?B?bjJLeTVGMkxrSFp6cW9BcXhtNmZhTDVHTDMwRVFKSGxCQ3RxUmR5Z1RVdkRE?=
 =?utf-8?B?L0c4UnJTM1hIOUpZRnpZU1ZZTFBlYWR0SzZTeisrV0Y5aWRQVnl5TnRheTAv?=
 =?utf-8?B?SlVRNUZKNXQ3ODlJR0dyMWFXYXQ5WERDR3h2UEx6QWFZS1NFVFdCd1l2d0Vx?=
 =?utf-8?B?c1M5WjZ5M1BETWZMSDdFckhCNlkwK0thYytDbVBKVit4WFBHQnA4cFR0ZmNt?=
 =?utf-8?B?djRqV2xMc2ZyYTFpUGlVMWYyM01QeWVXWlNjeVRxUzBkRGtaRVFRVlhRMUc3?=
 =?utf-8?B?L2xlYlRCZzVyQzFLQmxJMWd6WkxRZDRPK1czVUo2d0pNbnVJRk45b1NNc04w?=
 =?utf-8?B?NFA2QzhhSGdOOU02ZzZONmlwTlorZUZ0NUtUM3QrZVo1YnJDOVlYM3RCTG1u?=
 =?utf-8?B?V1ZyVlB6em9OUGxwRms2TFg0b0hTWTFjM2pRaGw0YkYyUmxTT09EZjRLY1M0?=
 =?utf-8?B?UUhwdGlzR3JpWSsvUGY0dlM4U0RVT3JKQ0NvQTVVOFcwelI2dDRLSG1RSXVu?=
 =?utf-8?B?TVJHSlArWWdQRVBucFhQUVRySS9RaW5JSFVtdldld2pOM1Q5cGRUTUVmc3Fk?=
 =?utf-8?B?ejJjazRkemtrTXpsSWRsZlM4Uk5tU0p1ZW1veENUY0xyeUp0ZHFQQ3ZNRFA3?=
 =?utf-8?B?Y2Fhc1ZLR3RhbFN0SGFMYzZpK21laVYxbUs5UkV0U3ZXTmg2QU9yZitnczJ2?=
 =?utf-8?B?NGxJQ05GMWFrYlEwYnVnQmxDbGg4RUZsT3NwSGRkTW9hMTBaNmxQeEtJb1Bj?=
 =?utf-8?B?NXVIYVI4SVNsYXE3MENLS3gxNkhKam5IZ3k2Z2F1cjNyLzJUekE4NUdQUTBh?=
 =?utf-8?B?YnAyZk11d055SXA3bXVvMWs1OHViNk1mcDQ5U081RUxYdkQrRGZ1dzFWanJP?=
 =?utf-8?B?a21FQTc5NjRORk5mN2paMVI5ZmFBWjBKU1ZKUUVNbW1ycDd5aXFmZlB5QWhs?=
 =?utf-8?B?VnJiOUtqYlMxUGFUZk1FSHlyemhJOTNFNTlBdm80Q3FId0tZbUtIR1lZKzdx?=
 =?utf-8?B?QThqS2k5Q3RsMGdadDMxUjNoNm5JaFFoeWVxMFdjckNSbGZEMEd0bDROYUhO?=
 =?utf-8?B?UTJzQzE1MU1rNjNieHlqYlpjNG5TSi9wejcweEFFWXUrNFljZ1cxWVFQdndy?=
 =?utf-8?B?OURhdGh6UExXMGdGVS9XSzllelB6em5KRWd6SzRBQ0hwVnBYbk9ZUk1YeTVX?=
 =?utf-8?B?ZUROWjArWDdKejc3SnFXa0ltRUdoSXlmb1UydExYbTJiRURIRWUxSUpIYk5u?=
 =?utf-8?B?dU5mczk2R3FXeE9raWhpenhCSmpTV3JjKzFQcmVTUVNvcWE3a3J3azFXY08y?=
 =?utf-8?B?Z3Z1cFF4V3d1Q2hJalRBZ0U3dUg5TEJZWWlqdHVGVysxZjhpZjlRbnFMSVJ2?=
 =?utf-8?B?UDEvMno3dGdETmc1OE91OTR4aFhLQk0wdnlUcE1kdkRhbnphL1cySnpwZXN2?=
 =?utf-8?B?dzZ4YThSMmpSYzBRaFY0YTRhc3BFUVgvZytKR01mVEpyc0pWa095VHNURjdw?=
 =?utf-8?B?WXY1S0hUbTdWeGNpYzBaZU90THBZdWJBOUY5YzNnSkNwTlpWYW1zMFhrUTdD?=
 =?utf-8?B?bndnRTJyY0J5SmtQVzZPcjdRWTdoNDVrR1dEbTRBTDVpOVhmaVgvWmdLUERx?=
 =?utf-8?B?VnBEM0lKYkVPRmt3OUV3QlNMalZhaHIyamo4Sm5vcGFyU0VNUTEvbnZiYWhV?=
 =?utf-8?B?UmZ0dHR3NGhJREs3V0VRZ2RveUEwejFlZGJ6RjdhbHNHOTB0TWJaQkN2OUpD?=
 =?utf-8?B?eUZSNlFUUjNVbzlLbm0yb3BaTmorV05qNGlWK1BVRy9xLzk4OE9ScXkwWmdv?=
 =?utf-8?B?V0YrQ3FiMlBQSzRKV0kyUlFjclV1ZmlGZTNEemNVRm90VHp5NzVoMU12bDNZ?=
 =?utf-8?B?UWV0ZTRXZkgvMS9VbEloK3ZkcUJ1d1hVVXZSclZJSENwNnR6aEkrYlJETXFK?=
 =?utf-8?B?S2oxMDNBa2QvT29LcVUrNmR4cmlVZ05WQ0ZMYzQ1U2JlOHFWc1pLbFVOdlNP?=
 =?utf-8?B?SVJWSWF2OEh6b1Q0a0tPd2Jkd01vUExXSkZENWpGRFJ0bkptc3o2MUMzQXdi?=
 =?utf-8?B?ZDN0MVJzVUFWSFRPMFdETU5iV2tLdWk0UnRiWFUwRW9veEgrUCs3ZzFRUFdr?=
 =?utf-8?B?SnM0bndqYnYvb0JoZWJNZmlCWGZuVjdSRnBPdzE1SExWZGlHZ2tnTmpvbHdQ?=
 =?utf-8?B?bHoybngvRmNlREVoVUxLelpFaVoyd0FPRVExTzRBSGhZWkYvNERISnVDWVhZ?=
 =?utf-8?B?K1lZb2ZIMCttSlF4bDgxS1lUc05HNVM2Z2NJS0ZSekpNVnNHN2F0ejhjN2hO?=
 =?utf-8?Q?d5iwpEs0w9mk7Z9wDsc+834IHSqkE8VvqnmvNxjdkVJ0D?=
X-MS-Exchange-AntiSpam-MessageData-1: 2OP5AGS3G14Yjg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35035d9b-7b83-4086-d00e-08def38d7114
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 07:36:34.9571 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AEbmWCA/GngFSgvg+/2pbtJt/Qb90FN24gkIYxDXKe+463LykokKXlbusESLjgTZpsrYtt3VoqGRJ/FvgYkfTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8878
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

The `kernel` crate now features a copy of our lossless integer
conversion routines. Switch to the kernel version and remove our own.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/falcon.rs                    |  12 +-
 drivers/gpu/nova-core/falcon/fsp.rs                |   4 +-
 drivers/gpu/nova-core/fb.rs                        |   2 +-
 drivers/gpu/nova-core/fb/hal/gb100.rs              |  11 +-
 drivers/gpu/nova-core/firmware.rs                  |   8 +-
 drivers/gpu/nova-core/firmware/booter.rs           |  10 +-
 drivers/gpu/nova-core/firmware/fwsec.rs            |   2 +-
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |   2 +-
 drivers/gpu/nova-core/firmware/gsp.rs              |   7 +-
 drivers/gpu/nova-core/firmware/riscv.rs            |   6 +-
 drivers/gpu/nova-core/fsp.rs                       |   4 +-
 drivers/gpu/nova-core/gsp.rs                       |   4 +-
 drivers/gpu/nova-core/gsp/cmdq.rs                  |  24 +--
 drivers/gpu/nova-core/gsp/fw.rs                    |  42 ++--
 drivers/gpu/nova-core/gsp/sequencer.rs             |   2 +-
 drivers/gpu/nova-core/num.rs                       | 211 ---------------------
 drivers/gpu/nova-core/vbios.rs                     |   2 +-
 17 files changed, 73 insertions(+), 280 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index 94c7696a6493..e352b300f763 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -23,6 +23,10 @@
         },
         Io,
     },
+    num::casts::{
+        self,
+        FromSafeCast, //
+    },
     prelude::*,
     sync::aref::ARef,
     time::Delta,
@@ -33,11 +37,7 @@
     driver::Bar0,
     falcon::hal::LoadMethod,
     gpu::Chipset,
-    num::{
-        self,
-        FromSafeCast, //
-    },
-    regs,
+    regs, //
 };
 
 pub(crate) mod fsp;
@@ -518,7 +518,7 @@ fn dma_wr(
         target_mem: FalconMem,
         load_offsets: FalconDmaLoadTarget,
     ) -> Result {
-        const DMA_LEN: u32 = num::usize_into_u32::<{ MEM_BLOCK_ALIGNMENT }>();
+        const DMA_LEN: u32 = casts::usize_into_u32::<{ MEM_BLOCK_ALIGNMENT }>();
 
         // For IMEM, we want to use the start offset as a virtual address tag for each page, since
         // code addresses in the firmware (and the boot vector) are virtual.
diff --git a/drivers/gpu/nova-core/falcon/fsp.rs b/drivers/gpu/nova-core/falcon/fsp.rs
index 52cdb84ef0e8..00bfd56c52a5 100644
--- a/drivers/gpu/nova-core/falcon/fsp.rs
+++ b/drivers/gpu/nova-core/falcon/fsp.rs
@@ -16,6 +16,7 @@
         },
         Io, //
     },
+    num::casts,
     prelude::*,
     time::Delta,
 };
@@ -28,7 +29,6 @@
         PFalcon2Base,
         PFalconBase, //
     },
-    num,
     regs, //
 };
 
@@ -155,7 +155,7 @@ pub(crate) fn recv_msg(&mut self, bar: Bar0<'_>) -> Result<KVec<u8>> {
             Delta::from_millis(10),
             Delta::from_millis(FSP_MSG_TIMEOUT_MS),
         )
-        .map(num::u32_as_usize)?;
+        .map(casts::u32_as_usize)?;
 
         let mut buffer = KVec::<u8>::new();
         buffer.resize(msg_size, 0, GFP_KERNEL)?;
diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index 725e428154cf..6301ea3ddfb0 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -10,6 +10,7 @@
     dma::CoherentHandle,
     fmt,
     io::Io,
+    num::casts::FromSafeCast,
     prelude::*,
     ptr::{
         Alignable,
@@ -23,7 +24,6 @@
     firmware::gsp::GspFirmware,
     gpu::Chipset,
     gsp,
-    num::FromSafeCast,
     regs, //
 };
 
diff --git a/drivers/gpu/nova-core/fb/hal/gb100.rs b/drivers/gpu/nova-core/fb/hal/gb100.rs
index 6e0eba101ca1..49b85968e919 100644
--- a/drivers/gpu/nova-core/fb/hal/gb100.rs
+++ b/drivers/gpu/nova-core/fb/hal/gb100.rs
@@ -11,7 +11,10 @@
         },
         Io, //
     },
-    num::Bounded,
+    num::{
+        casts,
+        Bounded, //
+    },
     prelude::*,
     ptr::{
         const_align_up,
@@ -23,7 +26,6 @@
 use crate::{
     driver::Bar0,
     fb::hal::FbHal,
-    num::usize_into_u32,
     regs, //
 };
 
@@ -79,8 +81,9 @@ fn write_sysmem_flush_page_gb100(bar: Bar0<'_>, addr: Bounded<u64, 52>) {
 }
 
 pub(super) const fn pmu_reserved_size_gb100() -> u32 {
-    usize_into_u32::<{ const_align_up(SZ_8M + SZ_16M + SZ_4K, Alignment::new::<SZ_128K>()).unwrap() }>(
-    )
+    casts::usize_into_u32::<
+        { const_align_up(SZ_8M + SZ_16M + SZ_4K, Alignment::new::<SZ_128K>()).unwrap() },
+    >()
 }
 
 impl FbHal for Gb100 {
diff --git a/drivers/gpu/nova-core/firmware.rs b/drivers/gpu/nova-core/firmware.rs
index 1e89390209f5..454d08ad8542 100644
--- a/drivers/gpu/nova-core/firmware.rs
+++ b/drivers/gpu/nova-core/firmware.rs
@@ -10,6 +10,10 @@
 use kernel::{
     device,
     firmware,
+    num::casts::{
+        FromSafeCast,
+        IntoSafeCast, //
+    },
     prelude::*,
     str::CString,
     transmute::FromBytes, //
@@ -21,10 +25,6 @@
         FalconFirmware, //
     },
     gpu,
-    num::{
-        FromSafeCast,
-        IntoSafeCast, //
-    },
 };
 
 pub(crate) mod booter;
diff --git a/drivers/gpu/nova-core/firmware/booter.rs b/drivers/gpu/nova-core/firmware/booter.rs
index d9313ac361af..46fec211a4c2 100644
--- a/drivers/gpu/nova-core/firmware/booter.rs
+++ b/drivers/gpu/nova-core/firmware/booter.rs
@@ -10,6 +10,10 @@
 use kernel::{
     device,
     dma::Coherent,
+    num::casts::{
+        FromSafeCast,
+        IntoSafeCast, //
+    },
     prelude::*,
     transmute::FromBytes, //
 };
@@ -31,11 +35,7 @@
         Signed,
         Unsigned, //
     },
-    gpu::Chipset,
-    num::{
-        FromSafeCast,
-        IntoSafeCast, //
-    },
+    gpu::Chipset, //
 };
 
 /// Local convenience function to return a copy of `S` by reinterpreting the bytes starting at
diff --git a/drivers/gpu/nova-core/firmware/fwsec.rs b/drivers/gpu/nova-core/firmware/fwsec.rs
index 199ae2adb664..fca127d96e55 100644
--- a/drivers/gpu/nova-core/firmware/fwsec.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec.rs
@@ -19,6 +19,7 @@
         self,
         Device, //
     },
+    num::casts::FromSafeCast,
     prelude::*,
     transmute::{
         AsBytes,
@@ -43,7 +44,6 @@
         Signed,
         Unsigned, //
     },
-    num::FromSafeCast,
     vbios::Vbios,
 };
 
diff --git a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
index 039920dc340b..0fbc7971477b 100644
--- a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
@@ -17,6 +17,7 @@
         register::WithBase, //
         Io,
     },
+    num::casts::FromSafeCast,
     prelude::*,
     ptr::{
         Alignable,
@@ -51,7 +52,6 @@
         FIRMWARE_VERSION, //
     },
     gpu::Chipset,
-    num::FromSafeCast,
     regs,
 };
 
diff --git a/drivers/gpu/nova-core/firmware/gsp.rs b/drivers/gpu/nova-core/firmware/gsp.rs
index 99a302bae567..39f50c927b72 100644
--- a/drivers/gpu/nova-core/firmware/gsp.rs
+++ b/drivers/gpu/nova-core/firmware/gsp.rs
@@ -8,6 +8,10 @@
         DataDirection,
         DmaAddress, //
     },
+    num::casts::{
+        arch::FromSafeCastArch,
+        FromSafeCast, //
+    },
     prelude::*,
     scatterlist::{
         Owned,
@@ -25,7 +29,6 @@
         Chipset, //
     },
     gsp::GSP_PAGE_SIZE,
-    num::FromSafeCast,
 };
 
 /// GSP firmware with 3-level radix page tables for the GSP bootloader.
@@ -175,7 +178,7 @@ pub(crate) fn radix3_dma_handle(&self) -> DmaAddress {
 fn map_into_lvl(sg_table: &SGTable<Owned<VVec<u8>>>, mut dst: VVec<u8>) -> Result<VVec<u8>> {
     for sg_entry in sg_table.iter() {
         // Number of pages we need to map.
-        let num_pages = usize::from_safe_cast(sg_entry.dma_len()).div_ceil(GSP_PAGE_SIZE);
+        let num_pages = usize::from_safe_cast_arch(sg_entry.dma_len()).div_ceil(GSP_PAGE_SIZE);
 
         for i in 0..num_pages {
             let entry = sg_entry.dma_address()
diff --git a/drivers/gpu/nova-core/firmware/riscv.rs b/drivers/gpu/nova-core/firmware/riscv.rs
index 2afa7f36404e..43015ea5c831 100644
--- a/drivers/gpu/nova-core/firmware/riscv.rs
+++ b/drivers/gpu/nova-core/firmware/riscv.rs
@@ -7,14 +7,12 @@
     device,
     dma::Coherent,
     firmware::Firmware,
+    num::casts::FromSafeCast,
     prelude::*,
     transmute::FromBytes, //
 };
 
-use crate::{
-    firmware::BinFirmware,
-    num::FromSafeCast, //
-};
+use crate::firmware::BinFirmware;
 
 /// Descriptor for microcode running on a RISC-V core.
 #[repr(C)]
diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
index 8fc243c66e35..581ed301d37a 100644
--- a/drivers/gpu/nova-core/fsp.rs
+++ b/drivers/gpu/nova-core/fsp.rs
@@ -11,6 +11,7 @@
     device,
     dma::Coherent,
     io::poll::read_poll_timeout,
+    num::casts,
     prelude::*,
     ptr::{
         Alignable,
@@ -42,7 +43,6 @@
         NvdmHeader,
         NvdmType, //
     },
-    num,
     regs, //
 };
 
@@ -128,7 +128,7 @@ fn new<'a>(
         };
 
         let version = hal::fsp_hal(args.chipset).ok_or(ENOTSUPP)?.cot_version();
-        let size = num::usize_into_u16::<{ core::mem::size_of::<NvdmPayloadCot>() }>();
+        let size = casts::usize_into_u16::<{ core::mem::size_of::<NvdmPayloadCot>() }>();
 
         Ok(init!(Self {
             mctp_header: MctpHeader::single_packet(),
diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index 69175ca3315c..5fafd6716ba3 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -11,6 +11,7 @@
         CoherentBox,
         DmaAddress, //
     },
+    num::casts,
     pci,
     prelude::*,
     transmute::{
@@ -36,7 +37,6 @@
         GspArgumentsPadded,
         LibosMemoryRegionInitArgument, //
     },
-    num,
 };
 
 pub(crate) const GSP_PAGE_SHIFT: usize = 12;
@@ -61,7 +61,7 @@ impl<const NUM_PAGES: usize> PteArray<NUM_PAGES> {
     // TODO: Replace with `IoView` projection once available.
     fn entry(start: DmaAddress, index: usize) -> Result<u64> {
         start
-            .checked_add(num::usize_as_u64(index) << GSP_PAGE_SHIFT)
+            .checked_add(casts::usize_as_u64(index) << GSP_PAGE_SHIFT)
             .ok_or(EOVERFLOW)
     }
 }
diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 070de0731e95..39326e3007bd 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -16,6 +16,7 @@
         Io, //
     },
     new_mutex,
+    num::casts,
     prelude::*,
     ptr,
     sync::{
@@ -26,7 +27,7 @@
     transmute::{
         AsBytes,
         FromBytes, //
-    },
+    }, //
 };
 
 use continuation::{
@@ -50,7 +51,6 @@
         GSP_PAGE_SHIFT,
         GSP_PAGE_SIZE, //
     },
-    num,
     regs,
     sbuffer::SBufferIter, //
 };
@@ -154,7 +154,7 @@ fn read(
 #[repr(C, align(0x1000))]
 #[derive(Debug)]
 struct MsgqData {
-    data: [[u8; GSP_PAGE_SIZE]; num::u32_as_usize(MSGQ_NUM_PAGES)],
+    data: [[u8; GSP_PAGE_SIZE]; casts::u32_as_usize(MSGQ_NUM_PAGES)],
 }
 
 // Annoyingly we are forced to use a literal to specify the alignment of
@@ -229,8 +229,8 @@ unsafe impl FromBytes for GspMem {}
 impl DmaGspMem {
     /// Allocate a new instance and map it for `dev`.
     fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
-        const MSGQ_SIZE: u32 = num::usize_into_u32::<{ size_of::<Msgq>() }>();
-        const RX_HDR_OFF: u32 = num::usize_into_u32::<{ mem::offset_of!(Msgq, rx) }>();
+        const MSGQ_SIZE: u32 = casts::usize_into_u32::<{ size_of::<Msgq>() }>();
+        const RX_HDR_OFF: u32 = casts::usize_into_u32::<{ mem::offset_of!(Msgq, rx) }>();
 
         let gsp_mem = Coherent::<GspMem>::zeroed(dev, GFP_KERNEL)?;
 
@@ -291,10 +291,10 @@ fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
         unsafe {
             (
                 core::slice::from_raw_parts_mut(
-                    data.add(num::u32_as_usize(tx)),
-                    num::u32_as_usize(tail_end - tx),
+                    data.add(casts::u32_as_usize(tx)),
+                    casts::u32_as_usize(tail_end - tx),
                 ),
-                core::slice::from_raw_parts_mut(data, num::u32_as_usize(wrap_end)),
+                core::slice::from_raw_parts_mut(data, casts::u32_as_usize(wrap_end)),
             )
         }
     }
@@ -309,7 +309,7 @@ fn driver_write_area_size(&self) -> usize {
         // `cpu_write_ptr`. The minimum value case is where `rx == 0` and `tx == MSGQ_NUM_PAGES -
         // 1`, which gives `0 + MSGQ_NUM_PAGES - (MSGQ_NUM_PAGES - 1) - 1 == 0`.
         let slots = (rx + MSGQ_NUM_PAGES - tx - 1) % MSGQ_NUM_PAGES;
-        num::u32_as_usize(slots) * GSP_PAGE_SIZE
+        casts::u32_as_usize(slots) * GSP_PAGE_SIZE
     }
 
     /// Returns the region of the GSP message queue that the driver is currently allowed to read
@@ -345,10 +345,10 @@ fn driver_write_area_size(&self) -> usize {
         unsafe {
             (
                 core::slice::from_raw_parts(
-                    data.add(num::u32_as_usize(rx)),
-                    num::u32_as_usize(tail_end - rx),
+                    data.add(casts::u32_as_usize(rx)),
+                    casts::u32_as_usize(tail_end - rx),
                 ),
-                core::slice::from_raw_parts(data, num::u32_as_usize(wrap_end)),
+                core::slice::from_raw_parts(data, casts::u32_as_usize(wrap_end)),
             )
         }
     }
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 4db0cfa4dc4d..ad659293aae1 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -11,6 +11,10 @@
 
 use kernel::{
     dma::Coherent,
+    num::casts::{
+        self,
+        FromSafeCast, //
+    },
     prelude::*,
     ptr::{
         Alignable,
@@ -38,10 +42,6 @@
         cmdq::Cmdq, //
         GSP_PAGE_SIZE,
     },
-    num::{
-        self,
-        FromSafeCast, //
-    },
 };
 
 // TODO: Replace with `IoView` projections once available.
@@ -99,7 +99,7 @@ pub(in crate::gsp) fn advance_cpu_write_ptr(qs: &Coherent<GspMem>, count: u32) {
 
 /// Maximum size of a single GSP message queue element in bytes.
 pub(crate) const GSP_MSG_QUEUE_ELEMENT_SIZE_MAX: usize =
-    num::u32_as_usize(bindings::GSP_MSG_QUEUE_ELEMENT_SIZE_MAX);
+    casts::u32_as_usize(bindings::GSP_MSG_QUEUE_ELEMENT_SIZE_MAX);
 
 /// Empty type to group methods related to heap parameters for running the GSP firmware.
 enum GspFwHeapParams {}
@@ -152,19 +152,19 @@ pub(crate) struct LibosParams {
 impl LibosParams {
     /// Version 2 of the GSP LIBOS (Turing and GA100)
     const LIBOS2: LibosParams = LibosParams {
-        carveout_size: num::u32_as_u64(bindings::GSP_FW_HEAP_PARAM_OS_SIZE_LIBOS2),
-        allowed_heap_size: num::u32_as_u64(bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS2_MIN_MB)
+        carveout_size: casts::u32_as_u64(bindings::GSP_FW_HEAP_PARAM_OS_SIZE_LIBOS2),
+        allowed_heap_size: casts::u32_as_u64(bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS2_MIN_MB)
             * u64::SZ_1M
-            ..num::u32_as_u64(bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS2_MAX_MB) * u64::SZ_1M,
+            ..casts::u32_as_u64(bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS2_MAX_MB) * u64::SZ_1M,
     };
 
     /// Version 3 of the GSP LIBOS (GA102+)
     const LIBOS3: LibosParams = LibosParams {
-        carveout_size: num::u32_as_u64(bindings::GSP_FW_HEAP_PARAM_OS_SIZE_LIBOS3_BAREMETAL),
-        allowed_heap_size: num::u32_as_u64(
+        carveout_size: casts::u32_as_u64(bindings::GSP_FW_HEAP_PARAM_OS_SIZE_LIBOS3_BAREMETAL),
+        allowed_heap_size: casts::u32_as_u64(
             bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS3_BAREMETAL_MIN_MB,
         ) * u64::SZ_1M
-            ..num::u32_as_u64(bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS3_BAREMETAL_MAX_MB)
+            ..casts::u32_as_u64(bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS3_BAREMETAL_MAX_MB)
                 * u64::SZ_1M,
     };
 
@@ -678,11 +678,11 @@ fn id8(name: &str) -> u64 {
         let init_inner = init!(bindings::LibosMemoryRegionInitArgument {
             id8: id8(name),
             pa: obj.dma_handle(),
-            size: num::usize_as_u64(obj.size()),
-            kind: num::u32_into_u8::<
+            size: casts::usize_as_u64(obj.size()),
+            kind: casts::u32_into_u8::<
                 { bindings::LibosMemoryRegionKind_LIBOS_MEMORY_REGION_CONTIGUOUS },
             >(),
-            loc: num::u32_into_u8::<
+            loc: casts::u32_into_u8::<
                 { bindings::LibosMemoryRegionLoc_LIBOS_MEMORY_REGION_LOC_SYSMEM },
             >(),
             ..Zeroable::init_zeroed()
@@ -712,12 +712,12 @@ pub(crate) fn new(msgq_size: u32, rx_hdr_offset: u32, msg_count: u32) -> Self {
         Self(bindings::msgqTxHeader {
             version: 0,
             size: msgq_size,
-            msgSize: num::usize_into_u32::<GSP_PAGE_SIZE>(),
+            msgSize: casts::usize_into_u32::<GSP_PAGE_SIZE>(),
             msgCount: msg_count,
             writePtr: 0,
             flags: 1,
             rxHdrOff: rx_hdr_offset,
-            entryOff: num::usize_into_u32::<GSP_PAGE_SIZE>(),
+            entryOff: casts::usize_into_u32::<GSP_PAGE_SIZE>(),
         })
     }
 }
@@ -829,7 +829,7 @@ pub(crate) fn set_checksum(&mut self, checksum: u32) {
     /// Returns the length of the message's payload.
     pub(crate) fn payload_length(&self) -> usize {
         // `rpc.length` includes the length of the RPC message header.
-        num::u32_as_usize(self.inner.rpc.length)
+        casts::u32_as_usize(self.inner.rpc.length)
             .saturating_sub(size_of::<bindings::rpc_message_header_v>())
     }
 
@@ -927,9 +927,9 @@ impl MessageQueueInitArguments {
     fn new(cmdq: &Cmdq) -> impl Init<Self> + '_ {
         init!(MessageQueueInitArguments {
             sharedMemPhysAddr: cmdq.dma_handle,
-            pageTableEntryCount: num::usize_into_u32::<{ Cmdq::NUM_PTES }>(),
-            cmdQueueOffset: num::usize_as_u64(Cmdq::CMDQ_OFFSET),
-            statQueueOffset: num::usize_as_u64(Cmdq::STATQ_OFFSET),
+            pageTableEntryCount: casts::usize_into_u32::<{ Cmdq::NUM_PTES }>(),
+            cmdQueueOffset: casts::usize_as_u64(Cmdq::CMDQ_OFFSET),
+            statQueueOffset: casts::usize_as_u64(Cmdq::STATQ_OFFSET),
             ..Zeroable::init_zeroed()
         })
     }
@@ -950,7 +950,7 @@ fn new(target: GspDmaTarget, wpr_meta_addr: u64) -> impl Init<Self> {
         #[allow(non_snake_case)]
         let params = init!(Self {
             target: target as u32,
-            gspRmDescSize: num::usize_into_u32::<{ size_of::<GspFwWprMeta>() }>(),
+            gspRmDescSize: casts::usize_into_u32::<{ size_of::<GspFwWprMeta>() }>(),
             gspRmDescOffset: wpr_meta_addr,
             bIsGspRmBoot: 1,
             wprCarveoutOffset: 0,
diff --git a/drivers/gpu/nova-core/gsp/sequencer.rs b/drivers/gpu/nova-core/gsp/sequencer.rs
index e0850d21adca..3944b396f67c 100644
--- a/drivers/gpu/nova-core/gsp/sequencer.rs
+++ b/drivers/gpu/nova-core/gsp/sequencer.rs
@@ -10,6 +10,7 @@
         poll::read_poll_timeout,
         Io, //
     },
+    num::casts::FromSafeCast,
     prelude::*,
     time::{
         delay::fsleep,
@@ -32,7 +33,6 @@
         },
         fw,
     },
-    num::FromSafeCast,
     sbuffer::SBufferIter,
 };
 
diff --git a/drivers/gpu/nova-core/num.rs b/drivers/gpu/nova-core/num.rs
index 6eb174d136ab..3921ef6f238e 100644
--- a/drivers/gpu/nova-core/num.rs
+++ b/drivers/gpu/nova-core/num.rs
@@ -5,217 +5,6 @@
 //! This is essentially a staging module for code to mature until it can be moved to the `kernel`
 //! crate.
 
-use kernel::{
-    macros::paste,
-    prelude::*, //
-};
-
-/// Implements safe `as` conversion functions from a given type into a series of target types.
-///
-/// These functions can be used in place of `as`, with the guarantee that they will be lossless.
-macro_rules! impl_safe_as {
-    ($from:ty as { $($into:ty),* }) => {
-        $(
-        paste! {
-            #[doc = ::core::concat!(
-                "Losslessly converts a [`",
-                ::core::stringify!($from),
-                "`] into a [`",
-                ::core::stringify!($into),
-                "`].")]
-            ///
-            /// This conversion is allowed as it is always lossless. Prefer this over the `as`
-            /// keyword to ensure no lossy casts are performed.
-            ///
-            /// This is for use from a `const` context. For non `const` use, prefer the
-            /// [`FromSafeCast`] and [`IntoSafeCast`] traits.
-            ///
-            /// # Examples
-            ///
-            /// ```
-            /// use crate::num;
-            ///
-            #[doc = ::core::concat!(
-                "assert_eq!(num::",
-                ::core::stringify!($from),
-                "_as_",
-                ::core::stringify!($into),
-                "(1",
-                ::core::stringify!($from),
-                "), 1",
-                ::core::stringify!($into),
-                ");")]
-            /// ```
-            #[allow(unused)]
-            #[inline(always)]
-            pub(crate) const fn [<$from _as_ $into>](value: $from) -> $into {
-                ::kernel::build_assert::static_assert!(size_of::<$into>() >= size_of::<$from>());
-
-                value as $into
-            }
-        }
-        )*
-    };
-}
-
-impl_safe_as!(u8 as { u16, u32, u64, usize });
-impl_safe_as!(u16 as { u32, u64, usize });
-impl_safe_as!(u32 as { u64, usize } );
-// `u64` and `usize` have the same size on 64-bit platforms.
-#[cfg(CONFIG_64BIT)]
-impl_safe_as!(u64 as { usize } );
-
-// A `usize` fits into a `u64` on 32 and 64-bit platforms.
-#[cfg(any(CONFIG_32BIT, CONFIG_64BIT))]
-impl_safe_as!(usize as { u64 });
-
-// A `usize` fits into a `u32` on 32-bit platforms.
-#[cfg(CONFIG_32BIT)]
-impl_safe_as!(usize as { u32 });
-
-/// Extension trait providing guaranteed lossless cast to `Self` from `T`.
-///
-/// The standard library's `From` implementations do not cover conversions that are not portable or
-/// future-proof. For instance, even though it is safe today, `From<usize>` is not implemented for
-/// [`u64`] because of the possibility to support larger-than-64bit architectures in the future.
-///
-/// The workaround is to either deal with the error handling of [`TryFrom`] for an operation that
-/// technically cannot fail, or to use the `as` keyword, which can silently strip data if the
-/// destination type is smaller than the source.
-///
-/// Both options are hardly acceptable for the kernel. It is also a much more architecture
-/// dependent environment, supporting only 32 and 64 bit architectures, with some modules
-/// explicitly depending on a specific bus width that could greatly benefit from infallible
-/// conversion operations.
-///
-/// Thus this extension trait that provides, for the architecture the kernel is built for, safe
-/// conversion between types for which such cast is lossless.
-///
-/// In other words, this trait is implemented if, for the current build target and with `t: T`, the
-/// `t as Self` operation is completely lossless.
-///
-/// Prefer this over the `as` keyword to ensure no lossy casts are performed.
-///
-/// If you need to perform a conversion in `const` context, use [`u64_as_usize`], [`u32_as_usize`],
-/// [`usize_as_u64`], etc.
-///
-/// # Examples
-///
-/// ```
-/// use crate::num::FromSafeCast;
-///
-/// assert_eq!(usize::from_safe_cast(0xf00u32), 0xf00u32 as usize);
-/// ```
-pub(crate) trait FromSafeCast<T> {
-    /// Create a `Self` from `value`. This operation is guaranteed to be lossless.
-    fn from_safe_cast(value: T) -> Self;
-}
-
-impl FromSafeCast<usize> for u64 {
-    fn from_safe_cast(value: usize) -> Self {
-        usize_as_u64(value)
-    }
-}
-
-#[cfg(CONFIG_32BIT)]
-impl FromSafeCast<usize> for u32 {
-    fn from_safe_cast(value: usize) -> Self {
-        usize_as_u32(value)
-    }
-}
-
-impl FromSafeCast<u32> for usize {
-    fn from_safe_cast(value: u32) -> Self {
-        u32_as_usize(value)
-    }
-}
-
-#[cfg(CONFIG_64BIT)]
-impl FromSafeCast<u64> for usize {
-    fn from_safe_cast(value: u64) -> Self {
-        u64_as_usize(value)
-    }
-}
-
-/// Counterpart to the [`FromSafeCast`] trait, i.e. this trait is to [`FromSafeCast`] what [`Into`]
-/// is to [`From`].
-///
-/// See the documentation of [`FromSafeCast`] for the motivation.
-///
-/// # Examples
-///
-/// ```
-/// use crate::num::IntoSafeCast;
-///
-/// assert_eq!(0xf00u32.into_safe_cast(), 0xf00u32 as usize);
-/// ```
-pub(crate) trait IntoSafeCast<T> {
-    /// Convert `self` into a `T`. This operation is guaranteed to be lossless.
-    fn into_safe_cast(self) -> T;
-}
-
-/// Reverse operation for types implementing [`FromSafeCast`].
-impl<S, T> IntoSafeCast<T> for S
-where
-    T: FromSafeCast<S>,
-{
-    fn into_safe_cast(self) -> T {
-        T::from_safe_cast(self)
-    }
-}
-
-/// Implements lossless conversion of a constant from a larger type into a smaller one.
-macro_rules! impl_const_into {
-    ($from:ty => { $($into:ty),* }) => {
-        $(
-        paste! {
-            #[doc = ::core::concat!(
-                "Performs a build-time safe conversion of a [`",
-                ::core::stringify!($from),
-                "`] constant value into a [`",
-                ::core::stringify!($into),
-                "`].")]
-            ///
-            /// This checks at compile-time that the conversion is lossless, and triggers a build
-            /// error if it isn't.
-            ///
-            /// # Examples
-            ///
-            /// ```
-            /// use crate::num;
-            ///
-            /// // Succeeds because the value of the source fits into the destination's type.
-            #[doc = ::core::concat!(
-                "assert_eq!(num::",
-                ::core::stringify!($from),
-                "_into_",
-                ::core::stringify!($into),
-                "::<1",
-                ::core::stringify!($from),
-                ">(), 1",
-                ::core::stringify!($into),
-                ");")]
-            /// ```
-            #[allow(unused)]
-            pub(crate) const fn [<$from _into_ $into>]<const N: $from>() -> $into {
-                // Make sure that the target type is smaller than the source one.
-                static_assert!($from::BITS >= $into::BITS);
-                // CAST: we statically enforced above that `$from` is larger than `$into`, so the
-                // `as` conversion will be lossless.
-                build_assert!(N >= $into::MIN as $from && N <= $into::MAX as $from);
-
-                N as $into
-            }
-        }
-        )*
-    };
-}
-
-impl_const_into!(usize => { u8, u16, u32 });
-impl_const_into!(u64 => { u8, u16, u32 });
-impl_const_into!(u32 => { u8, u16 });
-impl_const_into!(u16 => { u8 });
-
 /// Creates an enum type associated to a [`Bounded`](kernel::num::Bounded), with a [`From`]
 /// conversion to the associated `Bounded` and either a [`TryFrom`] or `From` conversion from the
 /// associated `Bounded`.
diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index c6e6bfcd6a1f..e67a82fcc8c0 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -5,6 +5,7 @@
 use kernel::{
     device,
     io::Io,
+    num::casts::FromSafeCast,
     prelude::*,
     ptr::{
         Alignable,
@@ -26,7 +27,6 @@
         FalconUCodeDescV2,
         FalconUCodeDescV3, //
     },
-    num::FromSafeCast,
 };
 
 /// BIOS Image Type from PCI Data Structure code_type field.

-- 
2.55.0

