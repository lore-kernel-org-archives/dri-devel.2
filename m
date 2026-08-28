Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D3DC61DC6
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 09:16:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4353410F314;
	Fri, 28 Aug 2026 09:16:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tv2SAZQF";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010053.outbound.protection.outlook.com [52.101.85.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A5BF10F312
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 09:16:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ala/3vF0efJNt94YlaIFaa41z/8jfPzmqCuYmDwWJLR6Wd59mnlOyP4+l0E3FZO3zaVTm5sTv/vM6SkEuTbAzU1/p7Fg80plbhk1perltnkRfpViBptV5xaoCNTauHEt3rT9rS2tPd+NF29PHFzMyZGG3+IVjg2R6UwfMzRssrTES9Sl/OiZlHiJBn1SuJG2HMevjvhgPxbSszvSMb/ib1WBRSbiAceMN8wB3tHE36IHAwEMBjqGng5DnTmRhZskQLyKC5rxq7CD/jC+mHDWFd/8GyclJHfYFcBDtGmSq0km9F1MZusA2bdn/tptR5nRESwe03VKYq+edvpma8/Zfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpuYVw0GHvsi79crKGa9I42i3zElFHK1O8+CP3rzea4=;
 b=FC3A9/I43NaQMC059bFKVVMEWCdUqWZNv4Z0ZBuaF3ptmNqC7k/pYErnh915p7I0DNetEi8gxKuygj7TnjH9H5zVhId8sZDez+IRzlLkTakRdttihAbRvUrksNmJ6CSpi0hwPLlutKNTOM+M4MkSdIsB530YWrljBa8rztMQWmYVUmtV1TpE6DuKWBigelpOPbrj+yhq9iKEcxSpeakQ7/pbmDNYKy270/vxCMxkVrKMVPPtuaoftdzZIW663CJ02A6JVkje3btCypBhmnsRyWxHZALa19KXSe1QLbNiAKgomjnM4H2zTatEdkCx8kAZW5Kl2KgMF/fEJEQ+bWGM/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpuYVw0GHvsi79crKGa9I42i3zElFHK1O8+CP3rzea4=;
 b=Tv2SAZQF+TMWVCmfvW0sPeQL+91tiV4O+zqpP1pME02yPzsY9cbNxzgWXD46Me2FQKmqMx+5B46jCFGSSgs8p2TFwBXwxEVGKUaceKFoIKYnjTSwnCIaf9kWnyif0PbhvQdfYYHYC1HnoXAcFka14ISNXwobdHV7XNMliRoCQIH9J4+Bmnv71EJjjs7u2eJCU4Gth8uqHTesAWydYA0z983gsmDL4hMZnWI0bi0YIwzKaLCE1qq0fXqMJ1wYXwqK/vpj3eGM6D+D76JKhvwp2zvSYPVDD6Q9XkOCqOkM5AMEBuTeExg8rteSYzETMoKtAlHKQrLakCGVy1TuMrJ86g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 LV5PR12MB9755.namprd12.prod.outlook.com (2603:10b6:408:307::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 09:16:51 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 09:16:50 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Fri, 28 Aug 2026 18:15:58 +0900
Subject: [PATCH 3/3] gpu: nova-core: use cv! for constant casts
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-cv-v1-3-48a180dfc4c8@nvidia.com>
References: <20260828-cv-v1-0-48a180dfc4c8@nvidia.com>
In-Reply-To: <20260828-cv-v1-0-48a180dfc4c8@nvidia.com>
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
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCPR01CA0203.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::12) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|LV5PR12MB9755:EE_
X-MS-Office365-Filtering-Correlation-Id: ad4e408f-540a-49ea-20a9-08df04e51816
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|23010399003|366016|7416014|376014|921020|10067099003|11063799006|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 4LBqphHUYGOHPDcxOZezAECiYm/c22Np5TrPHDHTmRlW1piXkkFokANXvLQ2UmXyRdL+69FvlTI8JKPMxESF/5mi6+YqvK6R4COaueHYyitlRxJqvPNPfZXhRgfeBKvl3ujwHVJZHBzDeNAdckbjavzKCSfpvUjQxMrwv0BsBEMU8oQC/6YuuSgGj/G9CWqCFJay5mb8rgUpCwlVHigUfNWwEBCnOMJ515SAvy66UVA6CkPM+GtolJTefpHglj8uOIjNtAD1ir23EQSrQHo4fum7A2wwuayAmQPFfBG4jklX2nca4YDvLI1XZaQYOjRAl92cVg9nAc65AHrctfSJPwpfaYqMs6nF3mR/Nxoeh+cACe+BMUVhxbNma3mPaNyWsv9A6o6k2rpTMmWPN6i1gDMs/SS103aZ/PosCGHgAWmmmTRfzZWMHfZX13UmvSkBXsocQ+WfWApkacCVmX/eBEehl7KSWsiMdpPTXaTT854ahl9h+kYGlqg3q6kog3SuJgswRRJKPeaHIxEOV+xml4ffl4VkOxhoQosQyYrJHqoCocOy8r6iyxydJo/43D9TUXm4c8zG0ELGgPnBUC9Eu6OqodE0AIfs75Jo0MpgG+kTQE8haSwxxNokZCPA5gR2fLIjun9Ae1vef0YnALQ6pFcXd5wopb+1F+vqVlhqZHQn7GAvlkeu+2Mu3d69vvcwwvs9k66S+yuIqiRLbQtgvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(23010399003)(366016)(7416014)(376014)(921020)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1ZhN1RLUGlIUWI4ZnZlZ1hQWk53WFBId0FHdTR2YVJDZko1K21wSFNQQUJj?=
 =?utf-8?B?UTlWdFZtS3pIa3I2OGN1Y1IzcXlyVmVIUFJhSGllNXlXdmF5SnZYNnhhOFlC?=
 =?utf-8?B?b0dYWXN4Y1dhNTAvTHgwSmpUVE9rWlh1N0djQk83SDF6KzVaVFRUNVNCcEg0?=
 =?utf-8?B?Nm9zL1c5eG5saUNEOVZjM1dZWncrd3lPNEVOWVhNN2hwaXh1RWNsSURITkcy?=
 =?utf-8?B?cmRxTDFJVmN5MGxjaUN3QXNJbWNPOVFwejBFVGVzWjJxUkRKcHlkTUc1ZVB0?=
 =?utf-8?B?ZytRUkxVZ3lpUUFTR3M5LzJNN1BpQlh2OEw3Ujdob3NTeEpneFNDS2JBam1z?=
 =?utf-8?B?T3Z4MWJCWGErYTJYSjNrdVNVWmVtaktERnYvN1RuVDhGTGNBNXliQWxob09z?=
 =?utf-8?B?UlNRUVRobkthVHl1MjRlV3BLVlB1aVJLUHlTZHFoZWxoWkpXdHlUS0RiKzhM?=
 =?utf-8?B?N0Iwc0Q3bmk5SHVPdGpVemxwb1ZWcGpEdWNNSXNpU2wvSXRObFhsN3JhUU5t?=
 =?utf-8?B?b3pHS2lGazdVQmxkYjA2aVdjZmVEZ05SdDRVN3hGZXlZWFFwNjJEUVBiU1VH?=
 =?utf-8?B?aVpUZFRiNkd6b1FKejRYQ3pJUzk4dDJRSC9mL3NOeDJMb3NuK25WVE9QOUZn?=
 =?utf-8?B?Q3U0TkNxVnRBYkwyNWptcEgvQmJXQlNiTHArTXgrbzNuaHNkNU9vZ2M3T1FK?=
 =?utf-8?B?TXMzRGVDSnJGVVkvVTRpYlZZa3U5c1dIR0dPd2FvbXlNVUp5Q081NkpGNkE2?=
 =?utf-8?B?a1M1aDB3UW1ZOUFoeTNBR3F6T3hka2llTmkrSHZzUjUrY091YUJ2cHhzLzhW?=
 =?utf-8?B?cUtPUnpBK2pyVWJabGRIWkxaVmpXNjZCMllONVQrS2J4bU9TeHZnaHYxdWFh?=
 =?utf-8?B?cjVTeTdERHpmUjcxcUw0c2tWNmZTb3dsUVJPZjFOSHUxWmUvNzN3ZytVNG5z?=
 =?utf-8?B?alpmYXM3MkdBVU52MFZnd0VtcEpWSnpxdEhMcU9WM2JZcnV0QzI1amVVbUVz?=
 =?utf-8?B?Q2E5bFp4RDh4aHpJUUtCblRuM2NuVlJKVzdlNHpWWGwvR3lkMnNWOFZRZm92?=
 =?utf-8?B?ZWVpbloxYWZUTUhCTUV6dzBVUE9TVjB3RURMSnRsLzE3U1dXd01jTWE0VXFk?=
 =?utf-8?B?R2lMbDJoSVBJc052RUM0aHpiOVB2Mk5ycGFHcU0rU0Y4bjFWN3VKTitSZ3o5?=
 =?utf-8?B?TmhuMHBhSTkyR01YaFZ6Q3BKa3gyWjkzT2hLYnNNR2pKWWkyY2p5eFZ1YitY?=
 =?utf-8?B?MjhRc0k2c1NreityVGpFRDhGanFybDlaaXBnc1dCSXRoZ2tRNElQZytQeGNx?=
 =?utf-8?B?RHhoZGRHdVlNTi9yZDBDWGZVVU9ocW1xcjVyMEhkMU9CclFLb3ZRVUpzNWhk?=
 =?utf-8?B?N1AyM21aNDFMOU5pc1ZCUC94OTVRVlhzTnFySVdISnFxMnpUZGlEd2w1elN5?=
 =?utf-8?B?RjRmVEM5dmJIcnd3TGVmR1Y3SGVFTzh1NWhnZXFsV0dYeEVXSnJYUkZrQkRH?=
 =?utf-8?B?Q21YclhJeFNvSnNoY056eVVxL1FwL09tVmVPYm8vMlVYaWFPK2liK3oyVlZL?=
 =?utf-8?B?VHpiVkpGeThoK0V1Zmo1dUJwNDB5MXhQa1dTWHZSSWdnSGV0WFo5b25VSFU5?=
 =?utf-8?B?eXhHWVBqV0paek52T1lEVEl0M3g5K3R3OTdLYVo1akU2bUZHeXN6UHFIRmlS?=
 =?utf-8?B?WG90YktyMTN1Ni9qZFFmY0c1UmZYaEtZV3VqclkvWUNkM0tlVlVpb1ZhbjVw?=
 =?utf-8?B?NGNHazFURjFma2NvRlJ1NGFoM1BwVDNxMTMwL3oyK0VXMHNnTnNzZTg3elM4?=
 =?utf-8?B?d0tUbXVObnljWjFkTmNpUmRTc2tqeGJCaE1Ha2dZTzl3bUExQ1NUeXV5ZjZ2?=
 =?utf-8?B?NjBZSnZCeHhCcGt5R3NkSzk0ZkxxMHVQaDN2SnFPUVQ2VjZXdTZuTEIrVjdZ?=
 =?utf-8?B?aUdMQVl0cWpaNDQ2SGlaRGxVMkNOMGUvVmYvSXp0SEkwcXllem0zL2FLcVVn?=
 =?utf-8?B?QnZNQjBUMkw3KzgzUkJQandtTHhZSDVXY0lkU2g0UEdQbE5yWmpqUkZNUE5m?=
 =?utf-8?B?T3ZhTWd0MWFHS0hiT3hFaXRFRy9kaWV1Ymh0eTJmc2ZIOFZvdkxpblZZVmgw?=
 =?utf-8?B?bis0bU9aTWdHZitPUDVCcHdsT1pBMTZVc3laeGk1NFl2V1BONmJQeFpsK28v?=
 =?utf-8?B?cTRNTGxudlpMbUltTkRzRVJoZW9RRDVJUEZFNnJibDlOWTZlSFNGSHcxL2Vm?=
 =?utf-8?B?SC9UTHlGSmVmNUgxTXNteE1KLzZnbG5FaVY2cStBL1dTakRkbmtGUXVJaHpm?=
 =?utf-8?B?SFpuazlJbVRaU3gyaFZ3dS80UTNGem9SWUhaeFZZbGh5WDNwcDU5M28yalZW?=
 =?utf-8?Q?ahYlikqenw0KTV/L2bgGOBvRwLlpQhEi73QUCsCPahEEA?=
X-MS-Exchange-AntiSpam-MessageData-1: tYpo5yo2p39Asg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad4e408f-540a-49ea-20a9-08df04e51816
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 09:16:50.9064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tM7C8scmfj1whye951sAOjVPapgeaHPmvT9RMONFu7/np3ND8qUx3y49X9LGe9M9zH1e893s1UQIi86n8fWNYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9755
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

The new `cv!` macro allows safe casting of constant expressions in a
const context. Update code in nova-core to use it.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/falcon.rs                    |  7 ++--
 drivers/gpu/nova-core/fb/hal/gb100.rs              |  8 ++---
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |  7 ++--
 drivers/gpu/nova-core/fsp.rs                       |  7 ++--
 drivers/gpu/nova-core/gsp/cmdq.rs                  | 11 +++---
 drivers/gpu/nova-core/gsp/fw.rs                    | 39 +++++++++-------------
 drivers/gpu/nova-core/gsp/fw/commands.rs           |  2 +-
 7 files changed, 28 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index dfe4d2e6f82e..e07537346ec5 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -20,10 +20,7 @@
         },
         Io,
     },
-    num::casts::{
-        self,
-        FromSafeCast, //
-    },
+    num::casts::FromSafeCast,
     prelude::*,
     time::Delta,
 };
@@ -510,7 +507,7 @@ fn dma_wr(
         target_mem: FalconMem,
         load_offsets: FalconDmaLoadTarget,
     ) -> Result {
-        const DMA_LEN: u32 = casts::usize_into_u32::<{ MEM_BLOCK_ALIGNMENT }>();
+        const DMA_LEN: u32 = cv!(MEM_BLOCK_ALIGNMENT);
 
         // DMA transfers can only be done in units of 256 bytes. Compute how many such transfers we
         // need to perform.
diff --git a/drivers/gpu/nova-core/fb/hal/gb100.rs b/drivers/gpu/nova-core/fb/hal/gb100.rs
index a53d8b435dc2..0bf00d381607 100644
--- a/drivers/gpu/nova-core/fb/hal/gb100.rs
+++ b/drivers/gpu/nova-core/fb/hal/gb100.rs
@@ -11,10 +11,7 @@
         },
         Io, //
     },
-    num::{
-        casts::usize_into_u32,
-        Bounded, //
-    },
+    num::Bounded,
     prelude::*,
     ptr::{
         const_align_up,
@@ -84,8 +81,7 @@ fn write_sysmem_flush_page_gb100(bar: Bar0<'_>, addr: Bounded<u64, 52>) {
 
 // This PMU reservation size is r570-specific.
 pub(super) const fn pmu_reserved_size_gb100() -> u32 {
-    usize_into_u32::<{ const_align_up(SZ_8M + SZ_16M + SZ_4K, Alignment::new::<SZ_128K>()).unwrap() }>(
-    )
+    cv!(const_align_up(SZ_8M + SZ_16M + SZ_4K, Alignment::new::<SZ_128K>()).unwrap())
 }
 
 impl FbHal for Gb100 {
diff --git a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
index d1fb7d2d7480..d637cc4ce312 100644
--- a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
@@ -15,10 +15,7 @@
     io::{register::WithBase, Io},
     num::casts::FromSafeCast,
     prelude::*,
-    ptr::{
-        Alignable,
-        Alignment, //
-    },
+    ptr::Alignable,
     sizes,
     transmute::AsBytes,
 };
@@ -134,7 +131,7 @@ pub(crate) fn new(
             let code_size = usize::from_safe_cast(tlv.get_u32(b"CDSZ")?);
             let code = blob.get(..code_size).ok_or(EINVAL)?;
             let aligned_code_size = code_size
-                .align_up(Alignment::new::<{ falcon::MEM_BLOCK_ALIGNMENT }>())
+                .align_up(cv!(falcon::MEM_BLOCK_ALIGNMENT))
                 .ok_or(EINVAL)?;
 
             let mut ucode = KVec::with_capacity(aligned_code_size, GFP_KERNEL)?;
diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
index b9ca298dc97f..e15d0af95499 100644
--- a/drivers/gpu/nova-core/fsp.rs
+++ b/drivers/gpu/nova-core/fsp.rs
@@ -11,10 +11,7 @@
     device,
     dma::Coherent,
     io::poll::read_poll_timeout,
-    num::{
-        casts,
-        TryIntoBounded, //
-    },
+    num::TryIntoBounded,
     prelude::*,
     ptr::{
         Alignable,
@@ -287,7 +284,7 @@ fn new<'a>(
         };
 
         let version = hal.cot_version();
-        let size = casts::usize_into_u16::<{ core::mem::size_of::<NvdmPayloadCot>() }>();
+        let size = cv!(core::mem::size_of::<NvdmPayloadCot>() => u16);
 
         Ok(init!(Self {
             header: FspMessageHeader::new(NvdmType::Cot),
diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 658d0a9b2cfb..4a471efe237c 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -23,10 +23,7 @@
         Io, //
     },
     new_mutex,
-    num::casts::{
-        self,
-        FromSafeCast, //
-    },
+    num::casts::FromSafeCast,
     prelude::*,
     ptr,
     sync::{
@@ -165,7 +162,7 @@ fn read(
 #[repr(C, align(0x1000))]
 #[derive(Debug)]
 struct MsgqData {
-    data: [[u8; GSP_PAGE_SIZE]; casts::u32_as_usize(MSGQ_NUM_PAGES)],
+    data: [[u8; GSP_PAGE_SIZE]; cv!(MSGQ_NUM_PAGES)],
 }
 
 // Annoyingly we are forced to use a literal to specify the alignment of
@@ -238,8 +235,8 @@ unsafe impl FromBytes for GspMem {}
 impl DmaGspMem {
     /// Allocate a new instance and map it for `dev`.
     fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
-        const MSGQ_SIZE: u32 = casts::usize_into_u32::<{ size_of::<Msgq>() }>();
-        const RX_HDR_OFF: u32 = casts::usize_into_u32::<{ mem::offset_of!(Msgq, rx) }>();
+        const MSGQ_SIZE: u32 = cv!(size_of::<Msgq>());
+        const RX_HDR_OFF: u32 = cv!(mem::offset_of!(Msgq, rx));
 
         let mut gsp_mem = CoherentBox::<GspMem>::zeroed(dev, GFP_KERNEL)?;
         gsp_mem.cpuq.tx = MsgqTxHeader::new(MSGQ_SIZE, RX_HDR_OFF, MSGQ_NUM_PAGES);
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 61064b6a251b..880764c2e5b1 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -19,10 +19,7 @@
         io_read,
         io_write, //
     },
-    num::casts::{
-        self,
-        FromSafeCast, //
-    },
+    num::casts::FromSafeCast,
     prelude::*,
     ptr::{
         Alignable,
@@ -57,7 +54,7 @@
 
 /// Maximum size of a single GSP message queue element in bytes.
 pub(crate) const GSP_MSG_QUEUE_ELEMENT_SIZE_MAX: usize =
-    casts::u32_as_usize(bindings::GSP_MSG_QUEUE_ELEMENT_SIZE_MAX);
+    cv!(bindings::GSP_MSG_QUEUE_ELEMENT_SIZE_MAX);
 
 /// Empty type to group methods related to heap parameters for running the GSP firmware.
 enum GspFwHeapParams {}
@@ -110,20 +107,18 @@ pub(crate) struct LibosParams {
 impl LibosParams {
     /// Version 2 of the GSP LIBOS (Turing and GA100)
     const LIBOS2: LibosParams = LibosParams {
-        carveout_size: casts::u32_as_u64(bindings::GSP_FW_HEAP_PARAM_OS_SIZE_LIBOS2),
-        allowed_heap_size: casts::u32_as_u64(bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS2_MIN_MB)
+        carveout_size: cv!(bindings::GSP_FW_HEAP_PARAM_OS_SIZE_LIBOS2),
+        allowed_heap_size: cv!(bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS2_MIN_MB => u64)
             * u64::SZ_1M
-            ..casts::u32_as_u64(bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS2_MAX_MB) * u64::SZ_1M,
+            ..cv!(bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS2_MAX_MB => u64) * u64::SZ_1M,
     };
 
     /// Version 3 of the GSP LIBOS (GA102+)
     const LIBOS3: LibosParams = LibosParams {
-        carveout_size: casts::u32_as_u64(bindings::GSP_FW_HEAP_PARAM_OS_SIZE_LIBOS3_BAREMETAL),
-        allowed_heap_size: casts::u32_as_u64(
-            bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS3_BAREMETAL_MIN_MB,
-        ) * u64::SZ_1M
-            ..casts::u32_as_u64(bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS3_BAREMETAL_MAX_MB)
-                * u64::SZ_1M,
+        carveout_size: cv!(bindings::GSP_FW_HEAP_PARAM_OS_SIZE_LIBOS3_BAREMETAL),
+        allowed_heap_size: cv!(bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS3_BAREMETAL_MIN_MB => u64)
+            * u64::SZ_1M
+            ..cv!(bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS3_BAREMETAL_MAX_MB => u64) * u64::SZ_1M,
     };
 
     /// Returns the libos parameters corresponding to `chipset`.
@@ -682,12 +677,8 @@ fn id8(name: &str) -> u64 {
             id8: id8(name),
             pa: obj.dma_address(),
             size: u64::from_safe_cast(obj.size()),
-            kind: casts::u32_into_u8::<
-                { bindings::LibosMemoryRegionKind_LIBOS_MEMORY_REGION_CONTIGUOUS },
-            >(),
-            loc: casts::u32_into_u8::<
-                { bindings::LibosMemoryRegionLoc_LIBOS_MEMORY_REGION_LOC_SYSMEM },
-            >(),
+            kind: cv!(bindings::LibosMemoryRegionKind_LIBOS_MEMORY_REGION_CONTIGUOUS),
+            loc: cv!(bindings::LibosMemoryRegionLoc_LIBOS_MEMORY_REGION_LOC_SYSMEM),
             ..Zeroable::init_zeroed()
         });
 
@@ -715,12 +706,12 @@ pub(crate) fn new(msgq_size: u32, rx_hdr_offset: u32, msg_count: u32) -> Self {
         Self(bindings::msgqTxHeader {
             version: 0,
             size: msgq_size,
-            msgSize: casts::usize_into_u32::<GSP_PAGE_SIZE>(),
+            msgSize: cv!(GSP_PAGE_SIZE),
             msgCount: msg_count,
             writePtr: 0,
             flags: 1,
             rxHdrOff: rx_hdr_offset,
-            entryOff: casts::usize_into_u32::<GSP_PAGE_SIZE>(),
+            entryOff: cv!(GSP_PAGE_SIZE),
         })
     }
 
@@ -947,7 +938,7 @@ impl MessageQueueInitArguments {
     fn new(cmdq: &Cmdq) -> impl Init<Self> + '_ {
         init!(MessageQueueInitArguments {
             sharedMemPhysAddr: cmdq.dma_addr,
-            pageTableEntryCount: casts::usize_into_u32::<{ Cmdq::NUM_PTES }>(),
+            pageTableEntryCount: cv!(Cmdq::NUM_PTES),
             cmdQueueOffset: u64::from_safe_cast(Cmdq::CMDQ_OFFSET),
             statQueueOffset: u64::from_safe_cast(Cmdq::STATQ_OFFSET),
             ..Zeroable::init_zeroed()
@@ -969,7 +960,7 @@ impl GspAcrBootGspRmParams {
     fn new(target: GspDmaTarget, wpr_meta_addr: u64) -> impl Init<Self> {
         let params = init!(Self {
             target: target as u32,
-            gspRmDescSize: casts::usize_into_u32::<{ size_of::<GspFwWprMeta>() }>(),
+            gspRmDescSize: cv!(size_of::<GspFwWprMeta>()),
             gspRmDescOffset: wpr_meta_addr,
             bIsGspRmBoot: 1,
             wprCarveoutOffset: 0,
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index 201594fa437b..60b0355d1d2e 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -82,7 +82,7 @@ pub(crate) fn new(offset: u32, value: u32) -> Self {
 
                 // We only support DWORD types for now. Support for other types
                 // will come later if required.
-                type_: bindings::REGISTRY_TABLE_ENTRY_TYPE_DWORD as u8,
+                type_: cv!(bindings::REGISTRY_TABLE_ENTRY_TYPE_DWORD),
                 __bindgen_padding_0: Default::default(),
                 data: value,
                 length: 0,

-- 
2.55.0

