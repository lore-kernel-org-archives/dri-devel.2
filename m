Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362D5C61DE4
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 05:07:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D74C10E548;
	Tue,  1 Sep 2026 05:07:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="tweq7nvh";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012043.outbound.protection.outlook.com
 [40.107.200.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41B1210E548
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 05:07:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kwNsKuXpgRZw9Ss4fwOORNOUJOz+2V1ya3lFbbEktbUsE1opWhcYilRZZXZyli7WAXbXUS0iQiMBpLezxt2oebqMa7jTQPYXFT1C39gMkfGi48Ax5IyuH2YP8IcYGmOLe0XnWFJLsVNSkgREzl00elwiHqEnVG7dy8iWAy0IRo1/5EoNxYy4KUJNEK5l8Ga3nHOzpUnSsTjXRr1mXJBecX8l/5HK6GbhUZAV2mMUsEMm8+gToZxICHWIJsFCI9IRPbJ/T8Dz/rAHth3gWeAc6k6YgcDRS1U0mNmb1aR4VqMXFfRjNKYwuXYuAY3oDMR8U1WrNt9zgX5uqYpSvssu4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kagjZ+EMfmaiH2nVKeat0CGL6mr/wfJtTPuNmfPWW0=;
 b=iLIykgmuzqaS22g41IuCEcI5On1cuz68JMbsgn2t4NT6Vzo9jRx7GrDQ5E1yECjll/kgZ+jfGxPpgXrsSNJcCI+XzrPuftbLjHZ13c34nX192aAQqhM6ZtMdIWy/g+BaDcg2cSM25O2wXg0CBTOPZe5t5HYABww5sY0e4dt9AK0PjzeYIkjKgxmDjQGPOvugSkfjyefcYGjly+G5c8J79OnqnDAJuAl3/QntIH9S5SQUf98mv+RWEuHNoN61OQsf2jW/0BENS0kCxQbHn3OlT1Nwl3VZ62xW4NnCQmYspcch6md2otTz389z0k36WkltGZ50/PtlMmqGovxPc6RtcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kagjZ+EMfmaiH2nVKeat0CGL6mr/wfJtTPuNmfPWW0=;
 b=tweq7nvh+CTV5WnOyENuuS5ROpNxXjKAnSuyT4rf8awQEBIIeZOMGsTfF/9jzbEgpoFesaM7Vp3T4NtDVFtGiOtqfxYKXe5zl+j1BFdP6Jtc7WHj6tZu7ygonhR7VqOOA3Y7dnHm4r1MastC85KLPqfKyGLPaNwbWjjRU4KAP7Tfe+UWxyFjB9D2vEGS+dLzWf6FXcYeaXK3cbI4fslcOCyBzhX/A2uOI07+TKeERiCsba307Ew0wiUSA4qywJNSaXAvBcYc7hm6ojkZ9JmSNqBpjMmkDZeQ3sYh+kS4ZfL0qYfLqDZ2byo2S81ibeqR0eaFgULygQrMwGKfa9YMeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Tue, 1 Sep 2026 05:07:14 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 05:07:14 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 01 Sep 2026 14:06:42 +0900
Subject: [PATCH v2 3/3] gpu: nova-core: use cv! for constant casts
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-cv-v2-3-446bc69d2ade@nvidia.com>
References: <20260901-cv-v2-0-446bc69d2ade@nvidia.com>
In-Reply-To: <20260901-cv-v2-0-446bc69d2ade@nvidia.com>
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
X-ClientProxiedBy: PAZP264CA0243.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:239::11) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|DM6PR12MB4355:EE_
X-MS-Office365-Filtering-Correlation-Id: 301dcfc4-f2ac-4e9b-e0cb-08df07e6e322
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|7416014|23010399003|18002099003|22082099003|56012099006|3023799007|6133799003|11063799006|10067099003|921020;
X-Microsoft-Antispam-Message-Info: vuvITqOa43aQvXg0w6yl7Nhsaxe+7amGFDNs+n8ux5ObHk0eYrP/SLQoubNO1Pwj6CDEIIUcv2efm8SxnXX29j2ZUEijs7jaO3jKFA1o/SC+55IxXMVqfPHhiPEcWA6Y3l2RUCJvaPkbv8OYV+rI/sM/AIlPYRPNrgLMVosqOuRAGmRAQreTgzuIqkHWDDPmj/MAWWLzKSB6X18NS8c3lHGaE9jd0CsU1Z0eq62bJvnApehgEt7114THxoXFSBjCJmhDvwhv+ZXhrYYDCKoD20cbsPAfuGsnFlJpGOOHOP6e3f8xXipF4b/sgIltCeA/HanpNCNwJgjM6ISkMAihhu4eA0jweMcbbpeiS/SQSN1hmxK6wbuV2TO84N35Pa3vryImGoVmlFVD4qEW6MJ+i+OMtgADQGPOKi6zYrqNZquZBI77AUAU+Vl6PmB4SN5gP91eNswXS8infxzf9DuMHyYo7sICXHjtSYq4hY+zEYyksJqdIkVHV/FxXDh+NBs3Z7e7Zw2/LN62B7C/qPpr/jmN9nTod4PBdEnBmwkxR/U5hHLTI6TxsdRgqdA75snNfmafNQtZT+5PWQj7ttSk3ZSlxgEX/w+p3basRLB33BGNmDZdaGI86rTXXW5y2yWQ7Pbx1lszRevnzKUtKd9biGDOIvkg356D1XHbOHDHoNqyNUEhVn8dyLn3uxWI4yDUyCXinqr9ME5zJdvqfmIZdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014)(23010399003)(18002099003)(22082099003)(56012099006)(3023799007)(6133799003)(11063799006)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tlg2aW1sT1hsRi9RbE5NVXpnV29uWDllUUh0ZC9yK0oxYXd5YmVvTXdTNVNN?=
 =?utf-8?B?SWt6OFR4UmtnbUU4N0hScnVxbzFPVkVXL1lCZUxoZFlwM1U1QnBXaGZ1RU83?=
 =?utf-8?B?ektOaGZxaG8xaVgveTFoMUVTZGFzWjBacElVS2NZY0VUcVBOS3VwS3prR2t0?=
 =?utf-8?B?YmFiYVJwQWcxMTZuNjg3YW0xQjQ2OGN3enkwZjBIRW9yRVp1N0NKOCtvR0pi?=
 =?utf-8?B?cDVZT1BVSCtzVnY3NlBkQVAwam40NzFyS21QeWgwclcvMVFtOTdWQ1h5YURQ?=
 =?utf-8?B?ZzZ6QTdVV0lIaXBtWW5XTUlKT3o5M1RRcGlnWHMxejM1Z0ZnU1NDRERiRlhu?=
 =?utf-8?B?RHhkbVhXYXNJTWNSdTJGNmhrVGJtdkpPUGs2eW5PL0svcVhOWXdEU2lnMFJt?=
 =?utf-8?B?L1l0ODFWelhVVzJoU3F6bE5GOXpSVmc4dFpLWElXVnZ6R0ZtRDZ1VkNwOE16?=
 =?utf-8?B?Z08zNjgwb3JtcTFXb1E1RjIxVGR6Y1Fpa0xKVXNFdC95dkpjemNiMEpyTFRW?=
 =?utf-8?B?U2xjS3FadVpwRUJuRTN3MnBqSUpxVCs5UWFVNDRRNVlQSC8rd3hQaTRwcEx6?=
 =?utf-8?B?VzJZM1l0N1c3UmF6MHk2YS9wQlM5VkVlOXZldDZORlJScXVYVE8vNmd2dFRa?=
 =?utf-8?B?REtpTklrY1BwcXJrZkNnUmxrTlBJdDRuKzh5WXdRTmp3ckZKcXpBUGR4amgx?=
 =?utf-8?B?bUxkZW0wTkxsUFl4OGVyZlMyMnJDbklXT1BjcjdjanJSQjA2SFlNclhMV0l5?=
 =?utf-8?B?a0dqbXdhbWIzQ0ZxL041M2FlYlUwY0dIay9kTGNBbnM4WDhhMkswSUFSYzM1?=
 =?utf-8?B?Mnl4d2lwLzR1b0xMVlM3a0Z4MUZkVk9LWWV5Rm13Y0oxdHdCTXplREcvRXFl?=
 =?utf-8?B?M05jV3V3MGhuWktZWGNaemRvY0k1R0o3SEwvMmZYNDR1OU1oK2lscDkzVzFG?=
 =?utf-8?B?cGtOYnovdkV3RGE3QXRkTi9XTnpnUnJ2TG9FZkRDR3lsa2hKZHFoT3pWdVhN?=
 =?utf-8?B?MThYOXFNU3phdTRvb1h3T25vSHU2bzN5ME1VZWt0VU8rOTlySGNaZFcrWUpQ?=
 =?utf-8?B?M1FMYWJaUjlGRkVaZjNzMmMwWFBSMlJHeTZhVFlvUEhobmd0OEFvSmM0Uys4?=
 =?utf-8?B?aFFQMEpqKzRvQXFTeXNGV1MzR3hjZ001ZmZJSVpzaU12d1A4ckpldEw1ZFVT?=
 =?utf-8?B?R096ek9WUXVpS1Z3YVBCQWRZMkFIUXM4N3dKTVhrdVYwTW1KL2NSSkV0NnVT?=
 =?utf-8?B?WnpjalRMQ0Q1WjNGbFZ0Q2YyeVJwM3ZQcVZqRGx3UGN0bjdhRmt0Z1huVWgr?=
 =?utf-8?B?OUZlVVFJREhNQWhIYUZtVmJBSWx3TTV4ZUdXcnprUHhaNVZtZUx2YStpWXVt?=
 =?utf-8?B?Tk5wMkkzaThMbnVSYm9iY1NwY1JmN3JicnZJS1krZ1NZWm5Gc0QrczRFQW1H?=
 =?utf-8?B?QjZkTXZvS09rOUJXd05jK2FaeG00ZkZkZXN3dUxmRFZpemxobkJJSG5TUloy?=
 =?utf-8?B?M3YrYjVrZXQwci83TEpCQVhoZ2JKYTViQmJ4cTIvRFI4dDIxazBBcVhrTVJz?=
 =?utf-8?B?MVB1Y3VqakptYVFMVXVIWE5ZazZYT1Y2bHFZQ2pGVnVQRThuQzNQYVhlaTJz?=
 =?utf-8?B?dUlJbzJzTURWQTc4SDczbEZJNkp4TGM1MGZzb3dTdTkrUlRNZktJaDFHbDll?=
 =?utf-8?B?UTg3L05WSUF5S3BZY0NNUjQ1M09FQWprMWVjdExHRlZZMWNVbFUraVg2VDlG?=
 =?utf-8?B?Ti94Y0FPRTlRSW9MNWgvVWRkODcydUFDMWZUdVZwYUtDT21lYUU1RXRtdFlS?=
 =?utf-8?B?ZktwSjRsL2Y1Ung1T2ppMjVRc0dtUzRoRTN5WWdTL3NXRFRMSkFNYlJvYTV3?=
 =?utf-8?B?UGVpbjJ1cXlOc0xVbE03eXl5N1RjcWlVdHhQdmJBM0xzRFI5WnFpTkdzMURJ?=
 =?utf-8?B?TlhoNTh5Tm0ycDZsNnBpYklsa0s4NWx0RElXUlVucXJNRHVSK3FLNDNkeG5r?=
 =?utf-8?B?Y3RLODNjWEJseEhhS3BpZ3FVdHpUdXkzYW1UYnNSdVkyalAxWHh5N0NQUGdz?=
 =?utf-8?B?c1hZUHlDR3BWWXlUQUpXbDVEMlpjSVc3UWE4c1JxSldKV0tNb0RkRmIrK0xS?=
 =?utf-8?B?UlJxei8xQU1zeTlsYUdTZHU2cGZaTFNva2c4K0NYbEdiY2JhSWVxVDJ3Uk5E?=
 =?utf-8?B?OW1iaUZGNlJSR0QxQnFYRlMrUmhVaHdvYVRDekhTLzU4ek8ybTMwTWUwYjFs?=
 =?utf-8?B?d3orMEhlbVpHdUdPU1U0bXo4ZjdZT1JnQ0ZzNEpKeVdWaVFsaEpqcDFsL1po?=
 =?utf-8?B?WTdySzE3MVVjdE1xb2RWUXE4V0JhVlkxQXh2eWwzVTB2R0tmdlorU1dDZDli?=
 =?utf-8?Q?B5P//4UcFzFMryvd8unmElCUY31YmYs3EfQ1BsPcosSS6?=
X-MS-Exchange-AntiSpam-MessageData-1: 9S83OnNFGm+P8g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 301dcfc4-f2ac-4e9b-e0cb-08df07e6e322
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 05:07:14.6866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ugPZP9jpaf8HKbw6cj5KPyO0RCYmIPi4d0PAs9W+bCtQ1rsiDIHNw3wyBfcmcVALKSzVcqZt+1YE4SBjRPMbVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
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
 drivers/gpu/nova-core/falcon.rs                    |  9 ++--
 drivers/gpu/nova-core/fb/hal/gb100.rs              |  4 +-
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |  7 +--
 drivers/gpu/nova-core/fsp.rs                       |  3 +-
 drivers/gpu/nova-core/gsp/cmdq.rs                  |  6 +--
 drivers/gpu/nova-core/gsp/fw.rs                    | 38 +++++++--------
 drivers/gpu/nova-core/gsp/fw/commands.rs           |  2 +-
 drivers/gpu/nova-core/num.rs                       | 55 +---------------------
 8 files changed, 28 insertions(+), 96 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index 65cb12d26e2b..0e0383331f42 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -29,11 +29,8 @@
     driver::Bar0,
     falcon::hal::LoadMethod,
     gpu::Chipset,
-    num::{
-        self,
-        FromSafeCast, //
-    },
-    regs,
+    num::FromSafeCast,
+    regs, //
 };
 
 pub(crate) mod fsp;
@@ -510,7 +507,7 @@ fn dma_wr(
         target_mem: FalconMem,
         load_offsets: FalconDmaLoadTarget,
     ) -> Result {
-        const DMA_LEN: u32 = num::usize_into_u32::<{ MEM_BLOCK_ALIGNMENT }>();
+        const DMA_LEN: u32 = cv!(MEM_BLOCK_ALIGNMENT);
 
         // DMA transfers can only be done in units of 256 bytes. Compute how many such transfers we
         // need to perform.
diff --git a/drivers/gpu/nova-core/fb/hal/gb100.rs b/drivers/gpu/nova-core/fb/hal/gb100.rs
index d9e4d62ae632..0bf00d381607 100644
--- a/drivers/gpu/nova-core/fb/hal/gb100.rs
+++ b/drivers/gpu/nova-core/fb/hal/gb100.rs
@@ -26,7 +26,6 @@
         hal::FbHal,
         regs, //
     },
-    num::usize_into_u32,
 };
 
 struct Gb100;
@@ -82,8 +81,7 @@ fn write_sysmem_flush_page_gb100(bar: Bar0<'_>, addr: Bounded<u64, 52>) {
 
 // This PMU reservation size is r570-specific.
 pub(super) const fn pmu_reserved_size_gb100() -> u32 {
-    usize_into_u32::<{ const_align_up(SZ_8M + SZ_16M + SZ_4K, Alignment::new::<SZ_128K>()).unwrap() }>(
-    )
+    cv!(const_align_up(SZ_8M + SZ_16M + SZ_4K, Alignment::new::<SZ_128K>()).unwrap())
 }
 
 impl FbHal for Gb100 {
diff --git a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
index ec4d92317a93..b51aca619a8c 100644
--- a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
@@ -14,10 +14,7 @@
     dma::Coherent,
     io::{register::WithBase, Io},
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
index ab685fb4168f..e15d0af95499 100644
--- a/drivers/gpu/nova-core/fsp.rs
+++ b/drivers/gpu/nova-core/fsp.rs
@@ -47,7 +47,6 @@
         NvdmHeader,
         NvdmType, //
     },
-    num,
     regs, //
 };
 
@@ -285,7 +284,7 @@ fn new<'a>(
         };
 
         let version = hal.cot_version();
-        let size = num::usize_into_u16::<{ core::mem::size_of::<NvdmPayloadCot>() }>();
+        let size = cv!(core::mem::size_of::<NvdmPayloadCot>() => u16);
 
         Ok(init!(Self {
             header: FspMessageHeader::new(NvdmType::Cot),
diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 6da728201281..bf8ade55b304 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -162,7 +162,7 @@ fn read(
 #[repr(C, align(0x1000))]
 #[derive(Debug)]
 struct MsgqData {
-    data: [[u8; GSP_PAGE_SIZE]; num::u32_as_usize(MSGQ_NUM_PAGES)],
+    data: [[u8; GSP_PAGE_SIZE]; cv!(MSGQ_NUM_PAGES)],
 }
 
 // Annoyingly we are forced to use a literal to specify the alignment of
@@ -235,8 +235,8 @@ unsafe impl FromBytes for GspMem {}
 impl DmaGspMem {
     /// Allocate a new instance and map it for `dev`.
     fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
-        const MSGQ_SIZE: u32 = num::usize_into_u32::<{ size_of::<Msgq>() }>();
-        const RX_HDR_OFF: u32 = num::usize_into_u32::<{ mem::offset_of!(Msgq, rx) }>();
+        const MSGQ_SIZE: u32 = cv!(size_of::<Msgq>());
+        const RX_HDR_OFF: u32 = cv!(mem::offset_of!(Msgq, rx));
 
         let mut gsp_mem = CoherentBox::<GspMem>::zeroed(dev, GFP_KERNEL)?;
         gsp_mem.cpuq.tx = MsgqTxHeader::new(MSGQ_SIZE, RX_HDR_OFF, MSGQ_NUM_PAGES);
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 05f54fee6186..33ec3d983c08 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -57,7 +57,7 @@
 
 /// Maximum size of a single GSP message queue element in bytes.
 pub(crate) const GSP_MSG_QUEUE_ELEMENT_SIZE_MAX: usize =
-    num::u32_as_usize(bindings::GSP_MSG_QUEUE_ELEMENT_SIZE_MAX);
+    cv!(bindings::GSP_MSG_QUEUE_ELEMENT_SIZE_MAX);
 
 /// Empty type to group methods related to heap parameters for running the GSP firmware.
 enum GspFwHeapParams {}
@@ -110,20 +110,18 @@ pub(crate) struct LibosParams {
 impl LibosParams {
     /// Version 2 of the GSP LIBOS (Turing and GA100)
     const LIBOS2: LibosParams = LibosParams {
-        carveout_size: num::u32_as_u64(bindings::GSP_FW_HEAP_PARAM_OS_SIZE_LIBOS2),
-        allowed_heap_size: num::u32_as_u64(bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS2_MIN_MB)
+        carveout_size: cv!(bindings::GSP_FW_HEAP_PARAM_OS_SIZE_LIBOS2),
+        allowed_heap_size: cv!(bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS2_MIN_MB => u64)
             * u64::SZ_1M
-            ..num::u32_as_u64(bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS2_MAX_MB) * u64::SZ_1M,
+            ..cv!(bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS2_MAX_MB => u64) * u64::SZ_1M,
     };
 
     /// Version 3 of the GSP LIBOS (GA102+)
     const LIBOS3: LibosParams = LibosParams {
-        carveout_size: num::u32_as_u64(bindings::GSP_FW_HEAP_PARAM_OS_SIZE_LIBOS3_BAREMETAL),
-        allowed_heap_size: num::u32_as_u64(
-            bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS3_BAREMETAL_MIN_MB,
-        ) * u64::SZ_1M
-            ..num::u32_as_u64(bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS3_BAREMETAL_MAX_MB)
-                * u64::SZ_1M,
+        carveout_size: cv!(bindings::GSP_FW_HEAP_PARAM_OS_SIZE_LIBOS3_BAREMETAL),
+        allowed_heap_size: cv!(bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS3_BAREMETAL_MIN_MB => u64)
+            * u64::SZ_1M
+            ..cv!(bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS3_BAREMETAL_MAX_MB => u64) * u64::SZ_1M,
     };
 
     /// Returns the libos parameters corresponding to `chipset`.
@@ -682,12 +680,8 @@ fn id8(name: &str) -> u64 {
             id8: id8(name),
             pa: obj.dma_address(),
             size: num::usize_as_u64(obj.size()),
-            kind: num::u32_into_u8::<
-                { bindings::LibosMemoryRegionKind_LIBOS_MEMORY_REGION_CONTIGUOUS },
-            >(),
-            loc: num::u32_into_u8::<
-                { bindings::LibosMemoryRegionLoc_LIBOS_MEMORY_REGION_LOC_SYSMEM },
-            >(),
+            kind: cv!(bindings::LibosMemoryRegionKind_LIBOS_MEMORY_REGION_CONTIGUOUS),
+            loc: cv!(bindings::LibosMemoryRegionLoc_LIBOS_MEMORY_REGION_LOC_SYSMEM),
             ..Zeroable::init_zeroed()
         });
 
@@ -715,12 +709,12 @@ pub(crate) fn new(msgq_size: u32, rx_hdr_offset: u32, msg_count: u32) -> Self {
         Self(bindings::msgqTxHeader {
             version: 0,
             size: msgq_size,
-            msgSize: num::usize_into_u32::<GSP_PAGE_SIZE>(),
+            msgSize: cv!(GSP_PAGE_SIZE),
             msgCount: msg_count,
             writePtr: 0,
             flags: 1,
             rxHdrOff: rx_hdr_offset,
-            entryOff: num::usize_into_u32::<GSP_PAGE_SIZE>(),
+            entryOff: cv!(GSP_PAGE_SIZE),
         })
     }
 
@@ -947,9 +941,9 @@ impl MessageQueueInitArguments {
     fn new(cmdq: &Cmdq) -> impl Init<Self> + '_ {
         init!(MessageQueueInitArguments {
             sharedMemPhysAddr: cmdq.dma_addr,
-            pageTableEntryCount: num::usize_into_u32::<{ Cmdq::NUM_PTES }>(),
-            cmdQueueOffset: num::usize_as_u64(Cmdq::CMDQ_OFFSET),
-            statQueueOffset: num::usize_as_u64(Cmdq::STATQ_OFFSET),
+            pageTableEntryCount: cv!(Cmdq::NUM_PTES),
+            cmdQueueOffset: u64::from_safe_cast(Cmdq::CMDQ_OFFSET),
+            statQueueOffset: u64::from_safe_cast(Cmdq::STATQ_OFFSET),
             ..Zeroable::init_zeroed()
         })
     }
@@ -969,7 +963,7 @@ impl GspAcrBootGspRmParams {
     fn new(target: GspDmaTarget, wpr_meta_addr: u64) -> impl Init<Self> {
         let params = init!(Self {
             target: target as u32,
-            gspRmDescSize: num::usize_into_u32::<{ size_of::<GspFwWprMeta>() }>(),
+            gspRmDescSize: cv!(size_of::<GspFwWprMeta>()),
             gspRmDescOffset: wpr_meta_addr,
             bIsGspRmBoot: 1,
             wprCarveoutOffset: 0,
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index 6dc31d1bf5ae..384eccf3c44a 100644
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
diff --git a/drivers/gpu/nova-core/num.rs b/drivers/gpu/nova-core/num.rs
index 6eb174d136ab..2e5c9937b3a6 100644
--- a/drivers/gpu/nova-core/num.rs
+++ b/drivers/gpu/nova-core/num.rs
@@ -96,8 +96,7 @@ pub(crate) const fn [<$from _as_ $into>](value: $from) -> $into {
 ///
 /// Prefer this over the `as` keyword to ensure no lossy casts are performed.
 ///
-/// If you need to perform a conversion in `const` context, use [`u64_as_usize`], [`u32_as_usize`],
-/// [`usize_as_u64`], etc.
+/// If you need to perform a conversion in `const` context, use [`cv!`](kernel::num::cv).
 ///
 /// # Examples
 ///
@@ -164,58 +163,6 @@ fn into_safe_cast(self) -> T {
     }
 }
 
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

-- 
2.55.0

