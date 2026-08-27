Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F226C61DC6
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:23:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 966F210F09B;
	Thu, 27 Aug 2026 14:23:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="n8KYf9r7";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013007.outbound.protection.outlook.com
 [40.93.201.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C87F710F09B
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 14:23:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t8J40GqhExfiv1s5rF5aNllcqa1/aQ5SqfwWeVumoLFxZ3HMc0haaxI0Euzm3xvjaeX1CDAYRhXOz7yEj2+u9bNKw9/41xFDkCxAGIeo3DB5d8HYnwUouWe2xaKXeVK0B+8oemLiRFNVty9njWQ3548O4aWatrn4nR3GcF59e+JLjK7sxC4HsFcmLgwnSoMwXuEQbsdL7YKOJwKY1Z9YgvN5uKWPJLXwg1weCynYRPvMfVCNTUFIWO8QtK1ifaWkRXqTqXpPOIpXYTiMdPXDWnua+Z7y9RE4t859XtO6vNqzxU2TVGsJ44xnBJZrMu675ovMfzARqt1wM8scQBbfKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D983f/t85unLVNPPpCPjE41y8tCVHZPXVxsZ1xeLHag=;
 b=EqmmTTAdBwmm5osSgr7TVEPusz2UG4k4+EZZRli0onlcVN4IGV0lC7KBj18u3BzBMuKTmqYlMvqcH73VpiWFhvGh+bIg4A5UGZOPk987M0BoH6I31YjYGltxNsf3YEoE2mhQRask9v1UScmpk59eCsjw/YEkE2pD2m7i9VyMzgnozveKOUc4khN1U/PThkAPy/2PAB7CZmdOJfXTLff3+mCKcsenzZnuOaOlCVC22M/konX1bkAkIdwprdTGXOm9JnEdSRdkpkau8U9RzjuJtEj+XiAQRHEvbF9PnkBYHyhjisK4UWxNLqsuBqQrQLhrOaKW/NGNAAmDfGmA4YqxsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D983f/t85unLVNPPpCPjE41y8tCVHZPXVxsZ1xeLHag=;
 b=n8KYf9r71U78+8G/KWZweMF50T5ByG/PnCu4pDZ/Ajiy3d5IGa8AtWoDt+16ITIpTIjD+le9ChLetl3qXACcccqKbwUroY0eCsuJp2pDf6oPxAkecBJavI1P4n5iXyjgg8Ez6IU1+rhn3EzlWys7Lu2WNpi7qxKj5sTnuwvuRjRE/N49VddrOr6bAQqFoLx3jZgcRi2W+5+U5E8RlqyPPCIOLK2LmiyBCK37XlNJyGvjkYrr7LMA56cOyZFGOJ/HsRuzOUN/HU3PnUqQIBSdTzTaRXM4pmj0Oq7S4XpAmm39hrp9mI89uAvjlMHOuJZoWO7WRBrKwEJdgvi1P3sInA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 PH0PR12MB7930.namprd12.prod.outlook.com (2603:10b6:510:283::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.10; Thu, 27 Aug 2026 14:23:12 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 14:23:12 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 27 Aug 2026 23:12:56 +0900
Subject: [PATCH v2 7/8] gpu: nova-core: add NVKV typed decoding
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-b4-nvkv-v2-7-0de9d5c8658c@nvidia.com>
References: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
In-Reply-To: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY6P301CA0023.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3bf::15) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|PH0PR12MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: 61ccf46a-b536-431c-e6ce-08df0446b9fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|10070799003|1800799024|366016|18002099003|22082099003|3023799007|6133799003|11063799006|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info: aPT7sso6mW/uQa8Tfz2FMa7K2u2Q6ZdhzTB1wixnlYvVJxcnOaDjNhMECqm0za8+76+3TNaBM6bI6haZZl0LM4qHDFPo7Ikiqv9iGpemWCQ59Qc4w581oM/+hDwAG7YoaTAsyAz3+Hky3yNPH/HsmTc+7KNPok4QuUWKpIZaKVfXt12pnROHTzZGKqKjHmeGZURr/SngUNEybXkZPiW5yQ8SVYKbWqOsVECw/0MpFPj6t6ApJ9oAEi6+yXLZqipGLLGpEyDzMfcXlxJddg2p/8wfQ26m8qYlDm8d+9sIxcSqQ67xjP9Vv+roJw1EUONbmcG1JSHjPf0ZVFTRAAk6qpZ7Mg+lE5B/KbIBT9d6q0N4+SAneueu8zwrGu6ujyeVLr0F/XvecY00Fa4nDb6KW3Sd3ws9lLFfOX8HlfXlhwfZwCSoxWoKSXQ/H1dgRjDhDjvMlNdbztba2ZX/aVkG9YhmMqDZFZSt0k9MXJIf9vBWZUcvDXv1gneUzRRDgrbHESyC0qbSfp0Fm2DNQxFGeLnom7fWQehuJmiFxEWlWJcDBbRevj/YsPRWZlD9XqinSP7R7ll9+s56px5DeH63LWXPbfLRTIV2ZGERIB+t5+k89HdwBHxhixcnNFiiib9MGXSBs7SBBclqdQl4BbUty5AimVCBCWLBoGeP8okzm0fTryE4l/nteA5WTgg8rCZaXjwHcUZA9Z1oDx2ZXS7DWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(10070799003)(1800799024)(366016)(18002099003)(22082099003)(3023799007)(6133799003)(11063799006)(56012099006)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0hEY3NTSGVxUWlabWlRaTFZeDlncXUyRXJTTzVEUWZjTHg2OXhnK21KcU1T?=
 =?utf-8?B?ais3MkFPMFhWcWJwZlBxeWs3L0EvT0ZwQUhlTElXclNkaElheitPYWwyU3pW?=
 =?utf-8?B?NXZOc0hDRVA1dTRLZnhadlFGSDhWNlJGZVo3WHpEQXpmUzVCZSt2S3dCZWw4?=
 =?utf-8?B?L1U5NVVmTDlqQXREVGRZWWJPdWVtbFFaZURYSzU3K1cvNDBleGwrWWw2eFNP?=
 =?utf-8?B?RzFCanY4dHdhbXpxTm1ubFFyZDNCbjhMZkRJQmxvL2FEa1NLMEpoN1lSM1Fv?=
 =?utf-8?B?TzBpVWZpMkNlblRnMkNVbjhZWE9LTmRjUDd5RVE3TTljN0ZZSm5nTFhPVlpw?=
 =?utf-8?B?bThsNlpndjg4TGFKYzhzMTFValh1aFlVdVVVWWovSDJrTklzWXVPS09FeXlh?=
 =?utf-8?B?bjlRZTdXZ1hXeHJLS2xNcGxCS3JjUWtBSWlORGpVdFl3eGgxbXp2c1R0UGo3?=
 =?utf-8?B?ZnhDeGdXdldoWlNuMHYvcmI3SVFOcmxnSk1NQXh4ajQ1OVJMZXg5V1lSb281?=
 =?utf-8?B?SWRXZWxyaW9Deks1aHFyZi9yZkFBcXlxQ2hXU0JzYkV1WlpkMlVaRTdpMHBo?=
 =?utf-8?B?RlVPcXNOd012amVFalJSZFhGYmIzUko2ZkN3d2FuSjJWbm54ck9aVmlGOUlI?=
 =?utf-8?B?ZWNCdWVKSWl5U0RKOGxOU0hPRUVRWHhwRGh6K1RXNnY0QzJHSnN2NzFsVjRV?=
 =?utf-8?B?bTRzb1NhdHpsNEpnNGVzb0doK2xjMThyNUNnTFVUU0tEendPTjNKaXlMWDAy?=
 =?utf-8?B?QkFBUzcvTzI0T2pyMk9DWHM0YUpiZUI1OU5oQmY1cldaYU0yOU94ZVZobEcw?=
 =?utf-8?B?eURSOVhONHBORG5tKzYvdldzUndFQ1B6R2Exc3h1UzNHOUY1SjFGVmJUQ04w?=
 =?utf-8?B?TTdkSStoSHNGaDdMNENsL3EvMUV2bW5mK01jUlpjQ2NGVStGbU5hQWd4R1gr?=
 =?utf-8?B?NWQ2dWFKN25WcmVtTkRMSWlneGp1NTlkTUMxYWRaV0RlOTUxZW1OaFRxajBW?=
 =?utf-8?B?VjNiQTA1c0lOUGZhYTF1ZEh3VnVMYXBYeHJ2d2I1U0xoalhBMUd3ajd5VVFS?=
 =?utf-8?B?US9hUTdZM0dxeTlyaFVBMUtJT2VqTzVlSUhRYWk3TlZDZy9pMUN0V2ZUZFgy?=
 =?utf-8?B?Rzh6SzViR2NqY01tT1QyNk02ckNlZXNEbDdrMjhKSUdSQlpBdWtTaURQeUZG?=
 =?utf-8?B?SVZ0VFBSbDdYaURaL0w2YzNXWDZGR0pScG5yVWhQZEo0akhKcEhNOVNXdmZj?=
 =?utf-8?B?cldEYzhwQUZVaHFJZ2dzWllQSVJjRlRJREpDTkZaUmc5clJlazFzMWNEV0tD?=
 =?utf-8?B?UE8zYUpHYm1KcllRTXRPaytiMkZVMmk3UTZCdm9hL1dwNlhFUkdzY2hXK1Rw?=
 =?utf-8?B?ZmpzWmdkd0tPRDIrSXpFbjdzWDQ4bVNmd0RKNE8wOFdMaDd0VEViMDhNZ2VI?=
 =?utf-8?B?bG9kcW5WU1FWaENUb3ZLK1ZDaHhHL1lYSUZ1akI0RTNtamZBUTcya3dUenpN?=
 =?utf-8?B?TWVzR29HQnhZNEovSHJ5ajFJSjgyTGFIYjFIWFQ2QmIxczk3SnFyZzU2M0Fs?=
 =?utf-8?B?RU9KOHZaSzlUT1BITTRhdlUxV1J4QTByaGNESDVKM25pTjRKNnhqSlJQd3pC?=
 =?utf-8?B?OHFaQ3RSQ1NyQmt0a2g0bDdacitiY3V1VUpBQnAvWHNuTHkvWFJJZEVJK3VX?=
 =?utf-8?B?SmZ1a3daeG5LdnRuY1daR0JXZlNoRnI2YmM4NE8zcnUycDVJcW9lZ3hXUUJs?=
 =?utf-8?B?dlI5eUpxa3k4WGpFQXkvYWpUWmhvaDY4RjY4SFRxeHFWbVlDM2wwaTRiWFpq?=
 =?utf-8?B?RTJBN2FtOFlhS0UxRklLVTBiaGxCNGRxKzJvcHVrR3hqUlN1QnV1cDBCbXB4?=
 =?utf-8?B?a1RWRTdUK0w2RFZIc2REMk9mQkJlenNvRm45UXFWWE1IUC9tTU4yZTR5bzky?=
 =?utf-8?B?L3h6OG42bCthdkV3bmJrT0dmdUo1VTN3TXFVQ1RyMDhRZ2JmSThjcGRUK21V?=
 =?utf-8?B?aFRaT3I1RTBxOUJSN3c1Zis2aFFIenNmalFqZjFCQkJBMGl3TWpQZWNCYlFB?=
 =?utf-8?B?NWd4MnpFbVFxZnh5N3dUSWtObVg4K3JyaXJyVGdLSzlraTlCaWVyUGhEV1VQ?=
 =?utf-8?B?b3Y5QVNvYkhSelVWbzJuRFJHcTJxS1FDenJlWWMyc0V2UDFjeXFYZWpjL2dw?=
 =?utf-8?B?UE96bkphUzdGbUpyZ21MdUFyZy9ncFVHa1ludy9ELzYvK0tBQ1YyV0xhQlFD?=
 =?utf-8?B?Q1hleWM5MTI2Y1lGQTBNZW1PUnZFTis1ckhtQWZNQ0xScUk2aXJRa3Q5WWhO?=
 =?utf-8?B?OUVhK1YwVUdUOVJjL1BWVHgrUC9NWGVpczh0ZEtXVlV5MnoxRFpTbjlJajVJ?=
 =?utf-8?Q?whctKMB823p9vqjPHEYc58aIKfYC8IrKhTXSLzYDvULYS?=
X-MS-Exchange-AntiSpam-MessageData-1: 49QzzMO1mbfQjA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ccf46a-b536-431c-e6ce-08df0446b9fd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 14:23:12.6309 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YpVEHiJq7X/fSYBNW+7oyX5voRxCxOvHQlUTfgl8ljYkemFls6r03i/F2cj4QLHiQD0lHtqyFjhQJQrJ6uaUFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7930
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

Similar to the typed encoding layer, add some decoding type machinery.
Add a simple macro `nvkv_decode!` which implements `Schema` for a struct
by composing visit calls to each member. Add some common `Schema` kinds,
such as `Array` which collects an array value into a fixed maximum size
array, and `Required` which fails a decode if the value is not sent.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/nvkv.rs        |  12 +-
 drivers/gpu/nova-core/gsp/nvkv/decode.rs | 480 ++++++++++++++++++++++++++++++-
 2 files changed, 488 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/nvkv.rs b/drivers/gpu/nova-core/gsp/nvkv.rs
index 10dcbb9e602c..7d58ca91cbc3 100644
--- a/drivers/gpu/nova-core/gsp/nvkv.rs
+++ b/drivers/gpu/nova-core/gsp/nvkv.rs
@@ -9,7 +9,7 @@
 //! function calls will map to some struct - for example, f(GPU_NAME_STRING_KEY, 0, b"some gpu")
 //! naturally maps to storing a &str with the GPU name.
 
-#![expect(unused_imports)]
+#![cfg_attr(not(CONFIG_KUNIT), expect(unused_imports))]
 #![cfg_attr(not(CONFIG_KUNIT), expect(unused_macros))]
 
 use core::marker::PhantomData;
@@ -21,7 +21,8 @@
 use kernel::{
     alloc::{
         allocator::KVmalloc,
-        Allocator, //
+        Allocator,
+        ArrayVec, //
     },
     bitfield,
     num::Bounded,
@@ -139,6 +140,13 @@ fn default() -> Self {
     }
 }
 
+/// A schema field for an array value under the NVKV key `KEY_ID`.
+#[derive(Default)]
+#[repr(transparent)]
+pub(crate) struct Array<T: Default + Copy, const N: usize, const KEY_ID: KeyId> {
+    vec: ArrayVec<T, N>,
+}
+
 bitfield! {
     /// The op word that starts each NVKV operation.
     struct Op(u64) {
diff --git a/drivers/gpu/nova-core/gsp/nvkv/decode.rs b/drivers/gpu/nova-core/gsp/nvkv/decode.rs
index ceb97e73e100..7f5310857764 100644
--- a/drivers/gpu/nova-core/gsp/nvkv/decode.rs
+++ b/drivers/gpu/nova-core/gsp/nvkv/decode.rs
@@ -3,16 +3,356 @@
 
 #![cfg_attr(not(CONFIG_KUNIT), expect(dead_code))]
 
-use kernel::prelude::*;
+use core::convert::Infallible;
+use core::marker::PhantomData;
+
+use kernel::{
+    alloc::ArrayVec,
+    prelude::*, //
+};
+use pin_init::init_array_from_fn;
 
 use crate::gsp::nvkv::{
+    Array,
     Index,
+    Key,
     KeyId,
     Op,
     Opcode, //
 };
 use crate::num;
 
+/// Defines a schema struct together with its [`Schema`] implementation that decodes into `$target`.
+///
+/// Each member of the struct should implement `Schema`. For every (key, index, value) triple
+/// decoded from the NVKV stream, the generated parent `Schema` implementation will call each member
+/// in declaration order with that triple. If a member consumes that triple, it will stop there.
+/// Otherwise it will keep going until all members are tried.
+///
+/// The schema struct holds the state required by the schema implementation to do the decode. It's
+/// recommended to use one of the existing Schema kinds (`Required`, `Accumulated`, `Key`, `Array`,
+/// `Indexed`) for each member.
+///
+/// # Examples
+///
+/// ```
+/// nvkv_decode! {
+///     struct RequestSchema => Request {
+///         id: Required<u32, 0x0001>,
+///         name: Array<u8, 64, 0x0002>,
+///     }
+/// }
+/// ```
+macro_rules! nvkv_decode {
+    (
+        $(#[$attr:meta])*
+        $vis:vis struct $name:ident => $target:ident {
+            $(
+                $(#[$field_attr:meta])*
+                $field_vis:vis $field:ident : $ty:ty
+            ),* $(,)?
+        }
+    ) => {
+        $(#[$attr])*
+        $vis struct $name {
+            $(
+                $(#[$field_attr])*
+                $field_vis $field: $ty,
+            )*
+        }
+
+        impl $crate::gsp::nvkv::Schema for $name {
+            type Target = $target;
+
+            fn init() -> impl ::kernel::prelude::Init<Self> {
+                ::pin_init::init!(Self {
+                    $( $field <- <$ty as $crate::gsp::nvkv::Schema>::init(), )*
+                })
+            }
+
+            fn visit(
+                &mut self,
+                key: $crate::gsp::nvkv::KeyId,
+                index: $crate::gsp::nvkv::Index,
+                value: $crate::gsp::nvkv::DecoderValue<'_>,
+            ) -> ::kernel::error::Result<bool> {
+                Ok(false
+                    $( || $crate::gsp::nvkv::Schema::visit(&mut self.$field, key, index, value)? )*)
+            }
+
+            #[inline(always)]
+            fn finish(
+                &mut self,
+            ) -> impl ::kernel::prelude::Init<Self::Target, ::kernel::error::Error> + '_ {
+                let Self { $($field,)* } = self;
+                ::kernel::try_init!(Self::Target {
+                    $( $field <- $crate::gsp::nvkv::Schema::finish($field), )*
+                }? ::kernel::error::Error)
+            }
+        }
+
+        impl ::core::default::Default for $name {
+            fn default() -> Self {
+                $crate::gsp::nvkv::assert_schema_size_reasonable::<Self>();
+                Self {
+                    $( $field: ::core::default::Default::default(), )*
+                }
+            }
+        }
+    };
+}
+pub(crate) use nvkv_decode;
+
+/// Asserts that a schema built by value is small enough.
+pub(crate) fn assert_schema_size_reasonable<S>() {
+    // Clippy triggers this even if the enclosing function is never called, so skip if clippy is on.
+    const_assert!(
+        cfg!(clippy) || size_of::<S>() <= 1024,
+        "construct large schemas in place with `Schema::init` instead of `Default`"
+    );
+}
+
+impl<T: for<'a> TryFrom<DecoderValue<'a>, Error = Error> + Default, const KEY_ID: KeyId> Schema
+    for Key<T, KEY_ID>
+{
+    type Target = T;
+
+    #[inline(always)]
+    fn visit<'a>(&mut self, key: KeyId, index: Index, value: DecoderValue<'a>) -> Result<bool> {
+        if key != KEY_ID {
+            Ok(false)
+        } else if index != Index::new::<0>() {
+            // Single values being set must be at index 0.
+            Err(EINVAL)
+        } else {
+            // Overwrite and take the latest value here.
+            self.0 = value.try_into()?;
+            Ok(true)
+        }
+    }
+
+    #[inline(always)]
+    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
+        Ok(core::mem::take(&mut self.0))
+    }
+}
+
+impl<T: for<'a> TryFrom<DecoderValue<'a>, Error = Error>, const KEY_ID: KeyId> Schema
+    for Key<Option<T>, KEY_ID>
+{
+    type Target = Option<T>;
+
+    #[inline(always)]
+    fn visit<'a>(&mut self, key: KeyId, index: Index, value: DecoderValue<'a>) -> Result<bool> {
+        if key != KEY_ID {
+            Ok(false)
+        } else if index != Index::new::<0>() {
+            // Single values being set must be at index 0.
+            Err(EINVAL)
+        } else {
+            // Overwrite and take the latest value here.
+            self.0 = Some(value.try_into()?);
+            Ok(true)
+        }
+    }
+
+    #[inline(always)]
+    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
+        Ok(self.0.take())
+    }
+}
+
+impl<T: Default + Copy, const N: usize, const KEY_ID: KeyId> Schema for Array<T, N, KEY_ID>
+where
+    for<'a> &'a [T]: TryFrom<DecoderValue<'a>, Error = Error>,
+{
+    type Target = ArrayVec<T, N>;
+
+    fn init() -> impl Init<Self> {
+        init!(Self {
+            vec <- ArrayVec::init_with::<Infallible>(|_| Ok(())),
+        })
+    }
+
+    fn visit<'a>(&mut self, key: KeyId, index: Index, value: DecoderValue<'a>) -> Result<bool> {
+        if key != KEY_ID {
+            return Ok(false);
+        }
+        // Require to be at index 0
+        if index != Index::new::<0>() {
+            return Err(EINVAL);
+        }
+        // Reject oversized and take the latest value.
+        self.vec.clear();
+        self.vec.extend_from_slice(value.try_into()?)?;
+        Ok(true)
+    }
+
+    #[inline(always)]
+    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
+        ArrayVec::init_with(move |dst| {
+            dst.extend_from_slice(&self.vec)?;
+            self.vec.clear();
+            Ok(())
+        })
+    }
+}
+
+/// A schema field for a key that must be present.
+///
+/// `finish` fails with `EINVAL` if no value arrived for the key.
+#[repr(transparent)]
+pub(crate) struct Required<T, const KEY_ID: KeyId>(Key<Option<T>, KEY_ID>);
+
+impl<T: for<'a> TryFrom<DecoderValue<'a>, Error = Error>, const KEY_ID: KeyId> Schema
+    for Required<T, KEY_ID>
+{
+    type Target = T;
+
+    #[inline(always)]
+    fn visit<'a>(&mut self, key: KeyId, index: Index, value: DecoderValue<'a>) -> Result<bool> {
+        self.0.visit(key, index, value)
+    }
+
+    #[inline(always)]
+    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
+        (self.0).0.take().ok_or(EINVAL)
+    }
+}
+
+impl<T, const KEY_ID: KeyId> Default for Required<T, KEY_ID> {
+    fn default() -> Self {
+        Self(None.into())
+    }
+}
+
+/// Expects objects specified sequentially with index starting from zero.
+pub(crate) struct Accumulated<S: Schema> {
+    current_index: Index,
+    current: S,
+    current_started: bool,
+    next: S,
+    accumulated: KVVec<S::Target>,
+}
+
+impl<S: Schema + Default> Accumulated<S> {
+    /// Creates an empty accumulator.
+    pub(crate) fn new() -> Self {
+        Self {
+            current_index: Index::new::<0>(),
+            current: S::default(),
+            current_started: false,
+            next: S::default(),
+            accumulated: KVVec::new(),
+        }
+    }
+
+    fn take_vec(&mut self) -> Result<KVVec<S::Target>> {
+        if self.current_started {
+            self.accumulated
+                .try_push_init(self.current.finish(), GFP_KERNEL)?;
+            self.current_started = false;
+        }
+        self.current_index = Index::new::<0>();
+        Ok(core::mem::take(&mut self.accumulated))
+    }
+}
+
+impl<S: Schema + Default> Schema for Accumulated<S> {
+    type Target = KVVec<S::Target>;
+
+    fn visit<'a>(&mut self, key: KeyId, index: Index, value: DecoderValue<'a>) -> Result<bool> {
+        if index != self.current_index {
+            if !self.next.visit(key, Index::new::<0>(), value)? {
+                // Unrelated key to us.
+                return Ok(false);
+            }
+
+            // Require that objects at index k have all their keys sent before the k + 1 th object
+            // can be completed. Require that objects are sent contiguously in order from index 0.
+            if !self.current_started || index != self.current_index + 1 {
+                return Err(EINVAL);
+            }
+
+            // The current value must be finished. Push it and swap in `next`.
+            self.accumulated
+                .try_push_init(self.current.finish(), GFP_KERNEL)?;
+            core::mem::swap(&mut self.current, &mut self.next);
+            self.current_started = true;
+            self.current_index = index;
+            Ok(true)
+        } else {
+            let consumed = self.current.visit(key, Index::new::<0>(), value)?;
+            self.current_started |= consumed;
+            Ok(consumed)
+        }
+    }
+
+    #[inline(always)]
+    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
+        self.take_vec()
+    }
+}
+
+impl<S: Schema + Default> Default for Accumulated<S> {
+    fn default() -> Self {
+        Self::new()
+    }
+}
+
+/// A schema field that scatters indexed values into an array of `N` slots.
+#[repr(transparent)]
+pub(crate) struct Indexed<T, const N: usize, const KEY_ID: KeyId, As = T>([T; N], PhantomData<As>);
+
+/// Copies `elems`, converted to `T`, into `slots` at `start`.
+///
+/// Fails with `EINVAL` if the window does not fit in `slots`.
+fn scatter_window<T: From<As>, As: Copy>(slots: &mut [T], start: usize, elems: &[As]) -> Result {
+    let end = start.checked_add(elems.len()).ok_or(EINVAL)?;
+    // Reject indices outside of the declared array size.
+    let dst = slots.get_mut(start..end).ok_or(EINVAL)?;
+    for (d, &e) in dst.iter_mut().zip(elems) {
+        *d = T::from(e);
+    }
+    Ok(())
+}
+
+impl<T, const N: usize, const KEY_ID: KeyId, As> Schema for Indexed<T, N, KEY_ID, As>
+where
+    T: From<As> + Default,
+    As: Copy + for<'a> TryFrom<DecoderValue<'a>, Error = Error>,
+    for<'a> &'a [As]: TryFrom<DecoderValue<'a>, Error = Error>,
+{
+    type Target = [T; N];
+
+    fn visit<'a>(&mut self, key: KeyId, index: Index, value: DecoderValue<'a>) -> Result<bool> {
+        if key != KEY_ID {
+            return Ok(false);
+        }
+        let start = index.cast::<usize>().get();
+        // Accept both scalar vs scattered array setting for flexibility.
+        match <&[As]>::try_from(value) {
+            Ok(elems) => scatter_window(&mut self.0, start, elems)?,
+            Err(_) => scatter_window(&mut self.0, start, &[As::try_from(value)?])?,
+        }
+        Ok(true)
+    }
+
+    #[inline(always)]
+    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
+        init_array_from_fn(|i| Ok::<_, Error>(core::mem::take(&mut self.0[i])))
+    }
+}
+
+impl<T: Default + Copy, const N: usize, const KEY_ID: KeyId, As> Default
+    for Indexed<T, N, KEY_ID, As>
+{
+    fn default() -> Self {
+        assert_schema_size_reasonable::<Self>();
+        Self([T::default(); N], PhantomData)
+    }
+}
+
 /// A decoded NVKV value.
 #[derive(Copy, Clone)]
 pub(crate) enum DecoderValue<'a> {
@@ -53,12 +393,23 @@ fn try_from(value: DecoderValue<'a>) -> Result<Self> {
 pub(crate) trait Schema {
     type Target;
 
+    /// Returns an initializer that creates an empty schema in place.
+    ///
+    /// Useful if the schema is too large to fit on the stack.
+    fn init() -> impl Init<Self>
+    where
+        Self: Sized + Default,
+    {
+        Self::default()
+    }
+
     /// Visits one decoded pair. Returns `Ok(true)` if the schema consumed it.
     fn visit<'a>(&mut self, key: KeyId, index: Index, value: DecoderValue<'a>) -> Result<bool>;
 
     /// Returns an initializer that makes the decoded `Target`.
     ///
-    /// After the returned initializer runs, the schema should be empty again.
+    /// After the returned initializer runs successfully, the schema should be empty again. If the
+    /// initializer fails, the schema may hold stale state.
     fn finish(&mut self) -> impl Init<Self::Target, Error> + '_;
 }
 
@@ -262,4 +613,129 @@ fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
 
         Ok(())
     }
+
+    // Tests that decoding via the `nvkv_decode!` macro works correctly.
+    #[test]
+    fn decode_typed_struct() -> Result {
+        const SCALAR32_KEY: KeyId = 0x1234;
+        const SCALAR64_KEY: KeyId = 0x1235;
+        const ARRAY8_KEY: KeyId = 0x1236;
+        const ARRAY32_KEY: KeyId = 0x1237;
+        const ARRAY64_KEY: KeyId = 0x1238;
+        const OPT_PRESENT_KEY: KeyId = 0x1239;
+        const OPT_ABSENT_KEY: KeyId = 0x123a;
+        const X_KEY: KeyId = 0x0100;
+        const Y_KEY: KeyId = 0x0101;
+        const SLOT_KEY: KeyId = 0x0200;
+
+        const SCALAR32_VALUE: u32 = 0x89ab_cdef;
+        const SCALAR64_VALUE: u64 = 0x0123_4567_89ab_cdef;
+        const ARRAY8_VALUE: &[u8] = &[0x12, 0x34, 0x56];
+        const ARRAY32_VALUE: &[u32] = &[0x0123_4567, 0x89ab_cdef];
+        const ARRAY64_VALUE: &[u64] = &[0x0123_4567_89ab_cdef, 0xfedc_ba98_7654_3210];
+        const OPT_PRESENT_VALUE: u32 = 0x55;
+
+        nvkv_decode! {
+            struct PairSchema => Pair {
+                x: Required<u32, { X_KEY }>,
+                y: Required<u32, { Y_KEY }>,
+            }
+        }
+
+        struct Pair {
+            x: u32,
+            y: u32,
+        }
+
+        nvkv_decode! {
+            struct TestSchema => TestDecodeable {
+                scalar32: Required<u32, { SCALAR32_KEY }>,
+                scalar64: Required<u64, { SCALAR64_KEY }>,
+                array8: Array<u8, 64, { ARRAY8_KEY }>,
+                array32: Array<u32, 64, { ARRAY32_KEY }>,
+                array64: Array<u64, 32, { ARRAY64_KEY }>,
+                opt_present: Key<Option<u32>, { OPT_PRESENT_KEY }>,
+                opt_absent: Key<Option<u32>, { OPT_ABSENT_KEY }>,
+                pairs: Accumulated<PairSchema>,
+                slots: Indexed<u32, 4, { SLOT_KEY }>,
+            }
+        }
+
+        struct TestDecodeable {
+            scalar32: u32,
+            scalar64: u64,
+            array8: ArrayVec<u8, 64>,
+            array32: ArrayVec<u32, 64>,
+            array64: ArrayVec<u64, 32>,
+            opt_present: Option<u32>,
+            opt_absent: Option<u32>,
+            pairs: KVVec<Pair>,
+            slots: [u32; 4],
+        }
+
+        let index0 = Index::new::<0>();
+        let index1 = Index::new::<1>();
+        let mut encoder = Encoder::new();
+        encoder.encode_u32(SCALAR32_KEY, index0, SCALAR32_VALUE)?;
+        encoder.encode_u64(SCALAR64_KEY, index0, SCALAR64_VALUE)?;
+        encoder.encode_array8(ARRAY8_KEY, index0, ARRAY8_VALUE)?;
+        encoder.encode_array32(ARRAY32_KEY, index0, ARRAY32_VALUE)?;
+        encoder.encode_array64(ARRAY64_KEY, index0, ARRAY64_VALUE)?;
+        encoder.encode_u32(OPT_PRESENT_KEY, index0, OPT_PRESENT_VALUE)?;
+        encoder.encode_u32(X_KEY, index0, 1)?;
+        encoder.encode_u32(Y_KEY, index0, 2)?;
+        encoder.encode_u32(SLOT_KEY, index1, 20)?;
+        encoder.encode_u32(X_KEY, index1, 3)?;
+        encoder.encode_u32(Y_KEY, index1, 4)?;
+        encoder.encode_u32(SLOT_KEY, index0, 10)?;
+        let serialized = encoder.finish();
+
+        let decoder = Decoder::new(&serialized, UnknownKeyPolicy::Error);
+        let mut schema = TestSchema::default();
+        let decoded = KBox::try_init(decoder.decode(&mut schema)?, GFP_KERNEL)?;
+
+        assert_eq!(decoded.scalar32, SCALAR32_VALUE);
+        assert_eq!(decoded.scalar64, SCALAR64_VALUE);
+        assert_eq!(*decoded.array8, *ARRAY8_VALUE);
+        assert_eq!(*decoded.array32, *ARRAY32_VALUE);
+        assert_eq!(*decoded.array64, *ARRAY64_VALUE);
+        assert_eq!(decoded.opt_present, Some(OPT_PRESENT_VALUE));
+        assert_eq!(decoded.opt_absent, None);
+        assert_eq!(decoded.pairs.len(), 2);
+        assert_eq!(decoded.pairs[0].x, 1);
+        assert_eq!(decoded.pairs[0].y, 2);
+        assert_eq!(decoded.pairs[1].x, 3);
+        assert_eq!(decoded.pairs[1].y, 4);
+        assert_eq!(decoded.slots, [10, 20, 0, 0]);
+
+        Ok(())
+    }
+
+    // Tests that a schema too large for the stack decodes on the heap.
+    #[test]
+    fn decode_large_schema_on_heap() -> Result {
+        const BLOB_KEY: KeyId = 0x1400;
+        const BLOB_VALUE: &[u8] = &[0xab; 100];
+
+        nvkv_decode! {
+            struct BigSchema => BigDecodeable {
+                blob: Array<u8, 2048, { BLOB_KEY }>,
+            }
+        }
+
+        struct BigDecodeable {
+            blob: ArrayVec<u8, 2048>,
+        }
+
+        let mut encoder = Encoder::new();
+        encoder.encode_array8(BLOB_KEY, Index::new::<0>(), BLOB_VALUE)?;
+        let serialized = encoder.finish();
+
+        let mut schema = KBox::init(BigSchema::init(), GFP_KERNEL)?;
+        let decoder = Decoder::new(&serialized, UnknownKeyPolicy::Error);
+        let decoded = KBox::try_init(decoder.decode(&mut *schema)?, GFP_KERNEL)?;
+
+        assert_eq!(*decoded.blob, *BLOB_VALUE);
+        Ok(())
+    }
 }

-- 
2.55.0

