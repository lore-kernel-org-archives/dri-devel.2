Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F2E7C55822
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 05:02:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D61510E192;
	Wed,  5 Aug 2026 05:02:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="U5hbOeaQ";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011000.outbound.protection.outlook.com [52.101.57.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A0FE10E192
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 05:02:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qVSds3jjTCfMiNa+IIo/8xGGfmWyOLDNNqF7gdXFDi6F8Jot1eHEOztBHFPsgvgtzKp2yBGKxZNusVnkJiaEL1fgQYs3s7xl0VjbJF9om4Q/W3nzFr/T/wSfRf+q7TjdLtjmuqBRwh/XOb4Vv7X0dDr+23g+fp4HbcgYx79YLSedFlKDfX0G+FvtTgCvKn2G87lph4/v6mSG3Ht2BA+4IRpOsIqZ2XuEnVeX21wl0mz/O3cM3KxnHbgl2Y9yan2JSXAJIuIa+iXMOhFBLtCJnJ/6bdG1MlhZqcBnzoA16g1cL25Cduby7JmuSnuoxQwOjD0scCwSj1zWhnSJBSmhhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkbDaec2O93iGqkeQ+Qi1B39k85YIwVgAT1AxSsYwXE=;
 b=pNjuMK3wo8lwwBcJNvyBt7vbdUvQ1n8+f0l8EPFI52PUp4/rVr+dauHfscqv+VKXB/vRGO1ZL3tGCHgIaQDZ+VGvS4KbJpzfnfcpmevN0ek038S02AFsGE2jBveAPNypX4FuZVrmicV8LseO6ymwIeQP05AlttJUBkT6w9dkb1Hj8e/9tb0h5R8JZDJMk+xaXRCGPGqhaBCzRPLxrCR/WGE2qTnYnOXykKyTmTbe1Bxr3XIrFxKBWyIsFZsHyhVOmT3qENCEcps7wIKckMa2wzLnHMZZHfI/RcqPukcLvCuF9qIeC0e3a9eO03sBg5tynJ13zPCj+8mTHkU8wb+0GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkbDaec2O93iGqkeQ+Qi1B39k85YIwVgAT1AxSsYwXE=;
 b=U5hbOeaQ0FYicsWdXlpFmw9cPrlLOsrTWBWF/PVCbTbtyomMYmcXYJy+syqejnwhhMEBLG00d48h98sFtSSG+gjuLPybJxvctd23U40UOtQoFwBwkY99Cs+0MM47lowuqFFFwR3EMS5rpA8x1Ahk7m0NvyuMXBer5O9FM6gjr1thV239gqg7C4hgbhqUxslvuUi2gySAVK2/6WeVK0zwk7LIZ6hXAoC/XyQ9jd1ad4qyI1Io/+boh9egCZn9Ek2UvHtMYAe0cKYvaOnhXGeZ66Ca2MVRAzlG5bbn3pRvu0CF2NB6FiCVt4uJgq/NI6Hro+Xr4EcGELdzb1chR7ONAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB8536.namprd12.prod.outlook.com (2603:10b6:610:15e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 05:02:07 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0270.016; Wed, 5 Aug 2026
 05:02:07 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 05 Aug 2026 14:01:47 +0900
Subject: [PATCH v2 3/3] gpu: nova-core: falcon: use I/O projection to check
 transfer bounds
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-falcon-dma-projections-v2-3-4cc9f3f13ee9@nvidia.com>
References: <20260805-falcon-dma-projections-v2-0-4cc9f3f13ee9@nvidia.com>
In-Reply-To: <20260805-falcon-dma-projections-v2-0-4cc9f3f13ee9@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYWP286CA0011.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::18) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB8536:EE_
X-MS-Office365-Filtering-Correlation-Id: 6717bad7-6e0b-406c-0081-08def2aeb322
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|23010399003|7416014|1800799024|366016|921020|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: mHVgnU4WctUUAUJIHX5LstpVHDbgdVdurBZDGxo2i4U6HgIGL2rQZLosEnAn/MFAnW668YrOhdQZjYFnhQrPj/a6Ad/gXZ8yGfKqrrMVFB2CPZ5SetotXDhBnVhjBD2vz3+1Zuq30b71BtIeubtIE+g4w+jtNsRX1bomFwD46ue0ImUiTwDOXJl48uPrxfg0E5OGsnfAC618si+AukRaFjRlL58hQ2+pCL3Hm6NlHS31EzzSQnXPsIjzScfIvzRdl855/aY7sVL3mkqzSaNTjUwVx6+mcoyqC1IQwpCYSmcFBmyl6Fk4slohvF4wvoBT/wEl4YVNjlzT4tLVq9RUhBVBtU1iOcRlOEZun1d2PyQLGJiHiXVtvGmJWJQOYd0D0FCJJbkMh3s6JvDf486cOQ8onxHvqGrvhxGXVskYsE7vsyDoUJ2DaVB4uJ6wdbveS5w5CsGhuOEN1TrvxWzaST59b7P6A8OSwXKkdp6kEHT+hUie9OfU7KyIynY35xjyG2EV4LD6vNtQF4l09cDDu2GdiLSzs92/f+YskDBvTh6zG1CiDUvYzS2sj6GeJVUFhrNhE9RW/m/+k9KI9GFVr97M1BQFtGucWClVlMSIxAeZ3gX0DWe4DJZpGHw0/pF02juUM7AVSi+qRejv+vQ1HqrBjC5ndg6W4ht8qFzznWx2g1FiRhzWakpAE8WMLOLsB9TYyRj652/QWjLJD3oi8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(23010399003)(7416014)(1800799024)(366016)(921020)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ME9Ua0ZnODkzdE1meHZEMzJJZEc5TUQzVEtwaXpmcW1EYmVJdVlkRW1KaGt5?=
 =?utf-8?B?T2VlVWpPcE5qSUZITENuQTk3di92ajh0ck5zUjBBNXhNVys2WjV1Q2FQWHpV?=
 =?utf-8?B?Wi9LZVJMNFVBVWM2Tmp0cGpVaFFMU255T3hURU1BK3YweXZxRnF1S3lCQXZs?=
 =?utf-8?B?b1RlaW9oZXhHNEpaQzVyS0JxM3FIWTZidHFKeHNaYlNqNW5nZ250eTVPQUNS?=
 =?utf-8?B?c2hmUmdkVjkyNGlUd0s3eUdpSUI3dWJ2UjBadHVQbmc2MXgvQnZRdFZuNFFX?=
 =?utf-8?B?dlZxN3ZMeXRXU3Q4RTVuZW9ZdUNHSUZlY3prem1NbUU1dlV4ekVWVkd0dzB0?=
 =?utf-8?B?a3BTL25aZVhucjFSejU1aUlrbzZObDRHeE1TeTBveE5pRy9uUXBwQWJOcTlU?=
 =?utf-8?B?cTlDdXMvOHhCaVpFTTQzOEYrR2Z5dEpORWxRM0ZKcC9lMjE0aitSQXR5NWoy?=
 =?utf-8?B?UzR0aFJycGdFOS9DamUxV1dpUXdFVHRIbCt1ODJ4QTlSTjliMXN1a0xaVW1P?=
 =?utf-8?B?SjlNcHNGVXNEUzYxV1daMStqS1VmWk9FTjNMZVpjR0Q2WEs0WHU2K1RBSEZB?=
 =?utf-8?B?VVRkeDlDQWxzalpKOFRJVzRUKzJka2xBclU3cGdIU3ZacmlmdE0vNUJLYTJE?=
 =?utf-8?B?YnhWQzBTK1BxVXdBSjgwamJkVVJnN1VZRmFXWENjK0dyYXdTcGFCLytTVUZl?=
 =?utf-8?B?OHlCbTJ0TDlYV0tMRVJGQ0dXajh3M0lSQ1h2cGFxZldYZHNXdFJ0Z1NGSEFo?=
 =?utf-8?B?Z2tzbFhXN1RSaU1yQzBPUkN1dzkra3JMNVdzdG4vRzhHQ3JLQUUrNUhDTHkv?=
 =?utf-8?B?RHJkYkp3b3huSjZ6M2Y3NTBGRzlRS01HcFJGWXI5OEhTQ2VGZXMyeG9NUDBD?=
 =?utf-8?B?VVVQdDhUV1dOYUd4czRtTTFWQjZWdUFIUnB6OEovaDkxanYxRkZuNHM4d3ky?=
 =?utf-8?B?aUs2cjhQcjduNHAxWVJTQVlKajZqSk5XczBaZnd5QmlFV0NXQThmTE5mdndu?=
 =?utf-8?B?QmVCcUltQms2ZzhMc1NBUzA4bCtWTWVaVW11V1RRTllGbkx5Qmc3NFRHNzZ4?=
 =?utf-8?B?NHk0cU9TNnFhZGEvQjNVTGczdldBcGUzb2JYOXM4Wi9RcU96OFRHeHJzczZU?=
 =?utf-8?B?M3FkRytheGFVUEV5dXZWTlVzSzl5b2ZCT2dFdFFJZjkyUUZFWElsMHRJVy84?=
 =?utf-8?B?dWtMNnlHRDlxcjFVY1NjdHV6ekpxQnJPY0NJejZPWlQxNFE5d1crZHBFbXVT?=
 =?utf-8?B?ZWt3dmcwNjdOVm9CcSs2NWkrZStJTUtNaE5GVzl1MTNYRWtzWXlsa3lqRGtH?=
 =?utf-8?B?V2llTUlzZjd4RkJPVE9jRGZ6clRRaWtndzV3N3JrNXV5N0xuSHJrRExaaTVx?=
 =?utf-8?B?c0l2MWUyK25TbExoQTY5bFZPREtob1FvTjVxTk1IeFZQN0pWY3Z5dVNsdkFC?=
 =?utf-8?B?S1lJQUpmZGg2SEFyblF6Ulh5cENjRjJZQUJpZUEwRVdrSENQWjZFTlZCbjdz?=
 =?utf-8?B?bWI0S3Bic0NuTkRvMHNaVkNacFdsV0hBQytMRFVFc3hEZ2pEVlNFaEFzZmt4?=
 =?utf-8?B?czRGV2FwWXd1ZFFQaWsvVDNSeTRaMHNiTE9sOCtRM3c1R0w0dXBIL3pGVCtF?=
 =?utf-8?B?OWdJWHR5dlFYSGJjMjRJVXpSTm9yUHdpS2YzREtIcW16WGV6NnFFWEFCb0Q5?=
 =?utf-8?B?dURLQ0lkT0I2OFlBdzNaanBFc09QdCsrdXpTSXgvU1pPS0ozaEtCaGJyQnVS?=
 =?utf-8?B?V3l5ZVlSTFY3ZkliYmhZL010WGNCekNhSDNCWDlKUVJKeXJlQjQ4OWJQaHMz?=
 =?utf-8?B?YTdnK0ZTdFQ4dHJ1ZS92UlN0SjVaaXllYVdUMEg1VEdRV05mdVkyU1N3Z2dH?=
 =?utf-8?B?TlVZdk5yWkJYWnF1bGpDUzgxZDVYMk5kUk1uNEEvZUtEUzZSSUQwbGY4V0wx?=
 =?utf-8?B?QVhSbzFaNHgwQnA2cHFXcmJtamJReWZwYkx2M1RiNm84SlNEOU9VMG5wWURk?=
 =?utf-8?B?Uldycm1EdUdCNnJMRW9GbCtobndXME5vMjlCRDY4WDlBSFBmUlloeUhpMlVh?=
 =?utf-8?B?eEdUa01kWlBmcjNmR202OWNoV2NtcUhkc2R2cGRvbnB5OHVVVmlXZkhVMWtz?=
 =?utf-8?B?U09NRDFtSVc0S3IySTJxQ2hFVk9NME9ONXdDUGNYNDI5c2FnMUxJVjNuYW9n?=
 =?utf-8?B?dnpWVUJvcTl4NG5KUmxtbVNxTVNTQjJTS21nempGQ2RKeGoxaHkrVHcweER1?=
 =?utf-8?B?M1lYZHRWQVRGNytwbmhWRWRlN2xuUER4Q241YzAyUHoxd29OTXFJOVFmSUpT?=
 =?utf-8?B?U1pvQW9ZNm9xYnppL2UxVnYvM3ltdlc2UEtoMVdlT0Qra1g3N3RwNlpGT1ZR?=
 =?utf-8?Q?yjnNiHn3FH+fP8CQRz0pkLwZYoTmFglMdj4GHDjeyCVby?=
X-MS-Exchange-AntiSpam-MessageData-1: FCCakaOa66y+Ig==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6717bad7-6e0b-406c-0081-08def2aeb322
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 05:02:07.7887 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ok1SDYXXd5TuFsi4i7vQfGpnsFo/7G/Xa/b+4BsNYLlIMxMDZ8m/bBMuBtIkwbJ+fpTkGR8uRuV8tRKp0JRZWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8536
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

The DMA transfer routine was computing the start of the DMA area by
taking the address of the coherent allocation, and then adding the
transfer's start offset. It then checked manually that the upper bound
was valid.

Convert this to an I/O projection of the same region, which returns
`ERANGE` if the passed range does not fit within the coherent
allocation. This removes the need to perform arithmetic on DMA addresses
and to explicitly check for the bounds' validity.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/falcon.rs | 55 +++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index a281d316ebfd..65cb12d26e2b 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -12,6 +12,7 @@
         DmaAddress, //
     },
     io::{
+        io_project,
         poll::read_poll_timeout,
         register::{
             RegisterBase,
@@ -511,20 +512,31 @@ fn dma_wr(
     ) -> Result {
         const DMA_LEN: u32 = num::usize_into_u32::<{ MEM_BLOCK_ALIGNMENT }>();
 
+        // DMA transfers can only be done in units of 256 bytes. Compute how many such transfers we
+        // need to perform.
+        let num_transfers = load_offsets.len.div_ceil(DMA_LEN);
+
         // For IMEM, we want to use the start offset as a virtual address tag for each page, since
         // code addresses in the firmware (and the boot vector) are virtual.
         //
-        // For DMEM we can fold the start offset into the DMA address.
+        // For DMEM, the start offset is folded into the DMA address.
         let (src_start, dma_start) = match target_mem {
-            FalconMem::ImemSecure | FalconMem::ImemNonSecure => {
-                (load_offsets.src_start, dma_obj.dma_address())
-            }
-            FalconMem::Dmem => (
-                0,
-                dma_obj.dma_address() + DmaAddress::from(load_offsets.src_start),
-            ),
+            FalconMem::ImemSecure | FalconMem::ImemNonSecure => (load_offsets.src_start, 0),
+            FalconMem::Dmem => (0, usize::from_safe_cast(load_offsets.src_start)),
         };
-        if dma_start % DmaAddress::from(DMA_LEN) > 0 {
+
+        let dma_address = {
+            // Upper limit of transfer is `(num_transfers * DMA_LEN) + load_offsets.src_start`.
+            let dma_end = num_transfers
+                .checked_mul(DMA_LEN)
+                .and_then(|size| size.checked_add(load_offsets.src_start))
+                .map(usize::from_safe_cast)
+                .ok_or(EOVERFLOW)?;
+
+            io_project!(dma_obj, [try: dma_start..dma_end]).dma_address()
+        };
+
+        if dma_address % DmaAddress::from(DMA_LEN) > 0 {
             dev_err!(
                 self.dev,
                 "DMA transfer start addresses must be a multiple of {}\n",
@@ -533,27 +545,6 @@ fn dma_wr(
             return Err(EINVAL);
         }
 
-        // DMA transfers can only be done in units of 256 bytes. Compute how many such transfers we
-        // need to perform.
-        let num_transfers = load_offsets.len.div_ceil(DMA_LEN);
-
-        // Check that the area we are about to transfer is within the bounds of the DMA object.
-        // Upper limit of transfer is `(num_transfers * DMA_LEN) + load_offsets.src_start`.
-        match num_transfers
-            .checked_mul(DMA_LEN)
-            .and_then(|size| size.checked_add(load_offsets.src_start))
-        {
-            None => {
-                dev_err!(self.dev, "DMA transfer length overflow\n");
-                return Err(EOVERFLOW);
-            }
-            Some(upper_bound) if usize::from_safe_cast(upper_bound) > dma_obj.size() => {
-                dev_err!(self.dev, "DMA transfer goes beyond range of DMA object\n");
-                return Err(EINVAL);
-            }
-            Some(_) => (),
-        };
-
         // Set up the base source DMA address.
 
         self.bar.write(
@@ -561,12 +552,12 @@ fn dma_wr(
             regs::NV_PFALCON_FALCON_DMATRFBASE::zeroed().with_base(
                 // CAST: `as u32` is used on purpose since we do want to strip the upper bits,
                 // which will be written to `NV_PFALCON_FALCON_DMATRFBASE1`.
-                (dma_start >> 8) as u32,
+                (dma_address >> 8) as u32,
             ),
         );
         self.bar.write(
             WithBase::of::<E>(),
-            regs::NV_PFALCON_FALCON_DMATRFBASE1::zeroed().try_with_base(dma_start >> 40)?,
+            regs::NV_PFALCON_FALCON_DMATRFBASE1::zeroed().try_with_base(dma_address >> 40)?,
         );
 
         let cmd = regs::NV_PFALCON_FALCON_DMATRFCMD::zeroed()

-- 
2.55.0

