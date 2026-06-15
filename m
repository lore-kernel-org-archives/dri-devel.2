Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADDCCD98CF
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 14:42:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD57810E513;
	Mon, 15 Jun 2026 14:42:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="JSmvf+0k";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010018.outbound.protection.outlook.com [52.101.56.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02EAA10E4F0
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 14:42:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bmGD0cpOykLKKuWyhtZxc3ShTdABABOXnbSA8hwwoiJuvYfoMqs3ohArktCzuwFfL/yt19VUlDTG6liN9p6C9wDdHGui9LZdBz+yZN+QEo3wO0KBlBXjgNln3ER+G1BRGsTYek4TIjgpIQ6AyM5HnyLN8on5F5cTzBun0+oKKHdBrw5IOk9075xVxV/EamiA983+QzMpexX8z00EpK2vyoL8knJZYpB9yC2fl1HjEV4UmEwSxSgnRQ+VBRwuZdsdj2e4Bc7/7E68yxLdLSf6dcETL0/60ejHrkT0sJ0UtaVde5n+ltMr03grhiP0GaOn7wbZ/1yX8sVZjYfqozyUpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jA1Hwzt2/L0npSvmrodylHgtuNpkVDFO1ER2YLVpz1A=;
 b=K7d+qdlNz0+izjlGaUxe1vrGQzjheqmkGliTFWPu2qTdhBEe/ULeMXOYvEdFFa1oSVlluagr4rby0BPiNQMK6EjjwS8gUutqh0cxo6b38lXl8mNyQEzq2eICRcqB4xS1DYqWEIf9Squ9qEBOriczbiWHhlMu5TagHk6CdK/QKfZ0eHJacijGnqA/Epx9eFMFJm2V5aJZstobbUdUL4UY9sayTEO3w4kbTR8efzoEzClEXereabCgMq+vzrfNgs2SH4SgwBkm+6fuWpOaFixAsJI4CnIxklg0RnDbi0LG53XmbfTVl0FiClJpGWhlz3eoh1Rna+XaZFtt2gDOzrd+9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jA1Hwzt2/L0npSvmrodylHgtuNpkVDFO1ER2YLVpz1A=;
 b=JSmvf+0k81naOwtNw7Rc5ZFXzFxHD0SH47ugAn+xwtm0tTP0XpIW1VVIT+p8KiBufAnDsYOQBkfN4h+kVDB0t1NgqE3PELkTaznyMZz+VP9pJM8KRJDfujRg/CD3EoeV3c68a6BfasCz9dvceDGApUUjmZu4/yNK0DDjCxmKMIVP7jEzhNDXbneN+gZSxCYVD/L4zDktcriTep8mcceTPUuVWEl2bn+XAb4rA91rL1UlFhvztMfw7IieZdRA+sIKEH0hLctIS56pRLpLZH/R3vzzjNSCLiCOUhcV2fmOfHn6PxeDBjwOi801A9wMpMrmRKmYr1/oHd5+DEZ9kQ0i9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by LV8PR12MB9668.namprd12.prod.outlook.com (2603:10b6:408:295::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Mon, 15 Jun
 2026 14:42:05 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 14:42:05 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 15 Jun 2026 23:40:48 +0900
Subject: [PATCH 08/13] gpu: nova-core: gsp: ensure LibOS DMA allocation
 lives long enough
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-blackwell-fixes-v1-8-f2853e49ff7d@nvidia.com>
References: <20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com>
In-Reply-To: <20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P301CA0124.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37e::14) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|LV8PR12MB9668:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ecadf33-4a93-4b1e-daea-08decaec44fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|23010399003|366016|1800799024|11063799006|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: h18UJOU6sh3EZfbLnFc/jnoC8yhIU2YoIe09GRllxoB7YXRjEt2lRR/mWr3AMI9leWDAXMFgrR62QZNqgpqN4DZwkdnZ60t0dfx8DaZsVFfNwfhkQ55ojRcjMNm9FKK9Eozm0CJIJTSuvl8vqqBsbenXFW7nT9pOMTA4fuC7K3zrHMpwf7UGMFdFrSvF1PSj++VcKbv1T4j++fO9yc7oZrT/rejoNJog7oObJ9NeHN/rAkefR8ZG4T4MdKtv4GQTgZWxLG3mcmuJbTNVbsBj6E+igvHIDGs2+JugEDQsLaKCsds/l3MpZ1RyJ7N0ZRwFi2ZvXWhHWm0dFM3jMzKc9MP21kiY9IDos1FhrlWQ/S/coovIHryp5KyQ22h73EcN+zc6vCVAfktXAzgZtn/LBj18X27ZRBygExtEkcSt1wVECaYn4UwwAzMuSUM2xZthRGLqO+KNiwFqOm35v47pSfMtl9S66VPgNbCxXsGSdwSVcIfJtIoKJ75Jm/wFR1+Dyaxagb/Tu1SrEuwzljOpnc2Donn3i7SjEOxSZQAjXaB2ZkOpU2otmmymsBRE+t+jPk4J0pJ6beZJVJW6iRWgF5KvuRrwp9ldlfslyHUJD1A9s8CuncqhX929xUSd2gi0mP4LVDjACYDBIhJYDK4NeSYkxwcbz8WAf+K5B7hGD6n1ViAZFBIKgvl7sBHOD719
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(23010399003)(366016)(1800799024)(11063799006)(6133799003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0gvZjZua3grUFdOUmJwT0FKWnpTVVEvSlNCRm5qLzB0em41YlEzWmVERnVr?=
 =?utf-8?B?dW1OWHlRdDdocFR3SldIY1JtcEFOMUNEb1FVNDM3K21XVTI4SEhYbjhRNU9p?=
 =?utf-8?B?ZzVlK0d4L2VoQjlkTVpmaWhBNjQzdzEyQmtRZ0cvL05IRXNmVGRqaXRYWXFG?=
 =?utf-8?B?TUhYS052czRuZ2FkR3BpYmZQTGRpWktOdjU3aGtNZkZLbWhKQmdQUXg1ZHBO?=
 =?utf-8?B?bUlCS3IrdUc1VWt6dmtrTCs5QkN6Q3hJdWFHcTVGV2xhaFJKREFFSjRBTXp6?=
 =?utf-8?B?Sml2Vy9jTklzNXRJWUF3UVEwdWUySHM2dHB2Q0ZuNmhTSWxQOGlkMmJoYmpy?=
 =?utf-8?B?NzArNVRNYkN0S1ZIWkpkeTJ4VjRwUkFtNktLMFkxVVdjcWRHVmdYSE1HNTN0?=
 =?utf-8?B?WU1kZmFHbzc4RlVpRnI5RkN0NGdRcjBNKzBFVDNnYkh6VG5xNlJSYU12RHhq?=
 =?utf-8?B?dytjbGp0MG82bEk1MkZVSE9zclhkRE0weDdyWlhOME5uQy9RY3grcWx6M21K?=
 =?utf-8?B?NUptSjh2MXBxQTV0bHRRWnpHYXBqcUM1ejhpNGI3akRiM1NndHlHdHZOYjhx?=
 =?utf-8?B?cS9Za2RoTXpoWUp1cnhCSnpWdXYxVzdjNzk1dnBSSG51MVpkNjZNdHhoUVJJ?=
 =?utf-8?B?Ylp0bHpuZlJBQTVSY1VwME5Bait3bCs5TCtJVHIwWWNLK3JNaXJVcHdwRDFq?=
 =?utf-8?B?ckh1Um1yK2E0UEZlTFljZkw0bGsvMllLSEQ0aW5sbHpuNGpPSmgyZWhqUEZi?=
 =?utf-8?B?OFp1aHY1VVhOYXlPR25XQXNZck9SOW5RbURNa1FzN2I2MzMyY20xQlNqOURU?=
 =?utf-8?B?K1paVFlmeWswVS9SQmVwdWJpQkpDbFhmMmNXQVUxWXVIaW1zTGk3dzBIaVZp?=
 =?utf-8?B?bHdsZmJ6Vkw2VEZncWFFbU1TanY1NXVBOWpkV2dVT1NGbUxxNmQ5QndYTEpq?=
 =?utf-8?B?cHlQVHg5Y3lncHVPcU1IeEdKQkVDVUc1OEFMN050NnA5NnliZDE3SGlaWEZC?=
 =?utf-8?B?MzZWOGl6eSs2SW55YU9VRGNPZGw1bmxKdVM0VTNzdlcyWUlRUmdrb0dKN3Fi?=
 =?utf-8?B?SE9DQ3ZJQ0orSzhIakNYa1hUdDZVS3BaRmNGSk51ZHBOamVFTVYzWVVhNk16?=
 =?utf-8?B?cU5pWUl1cGtGMG1yakNDMTJOY1RCVlF3WUUySWw4RUM3eHpnWUN3MWRicVlh?=
 =?utf-8?B?QnlmVlBjYTR2a3k0eEQvQ1orNGdTY0wwUlZZTUZ3UWM1cjJYVUJFK2FCeXg5?=
 =?utf-8?B?NzVjYmpyWktBMUY3aHl6Q3JnVGFTOHNGN0xPWHlvMmxXT1ZxWmVuQ2cxU2xz?=
 =?utf-8?B?ZzVYSFlVWDhmTW14T1kxQjZDNDYvUUZ0andHNFlsNk9pUFhJRVBlSDRYbys4?=
 =?utf-8?B?TjU2NEswUGJkKzl1M2dnVWpzY2ttYi9sUTJLNGRXZXA4amVka1RPY0VVSUtq?=
 =?utf-8?B?YTlSY3Y3V3lpMGkwVmZkWlNwc0txQVkrOWFPOXZETTF1M0hydGpwMnhPMWJY?=
 =?utf-8?B?STh4bUp0N2ppTmpWTTJZVjQzSVI4b3NxcmNJUnV0Z0JuaGtHeVJyemlRSDZx?=
 =?utf-8?B?TXJsRDc2UlQwN202Rys1dERiK2V4UnF3Vmttb0JobjdBbStYeHJHMlU2Yjcx?=
 =?utf-8?B?UGhVd2QvakE3SEltbTE4aUlpU3RLYXhHZGRROWFNbGtZL0NEZERpSklRRjNx?=
 =?utf-8?B?ZkpRNGlFeW1jTzg0dFlkVXZLd001WGcrTUlwelVjOXlGZ3lZbWpDdlZsWmNl?=
 =?utf-8?B?aTZhYkUwWUZPSVQrdWlERHUwaXZxeklIYUM5YXVieGwxT2t4bjhvS3NaMVVT?=
 =?utf-8?B?U1pOcWZSYW5BenRiSERLYXhoYkQvRjJuNS9pMmYxdHlLOEFGL01lSnU4dnkx?=
 =?utf-8?B?b1RFUWxBV014WDdyVUE0RFZWN0F6TS9tZ0RCVzdaV1M5MExrK3RzeDByMkN1?=
 =?utf-8?B?eFUvRWdJWXlhS05vU3lDM2ZtNTFEQjdneHk3Mng1Vk9veWdNeEs3cjU2VnNs?=
 =?utf-8?B?TVRRNllBbEJ1Z2JTZjcyVzZBeE83ZWhiMEJNRFZxZHpuZmhFL1MwNSticG5q?=
 =?utf-8?B?SlhzQ3k1M2FsYURleTMzNFplT2hqTTNaMHMyOEdrNXNsVCtxU3J5VEdrdFQ5?=
 =?utf-8?B?c2RmbmgrNFNEWk5JZDNwS0ozdE5nQ0thczRpRWdSUjVlNmcxK0dLK2hFY0FS?=
 =?utf-8?B?YnFqTUpjQnFid2JGTGRJTHNTZE4vYm1ydk5VREhqQmMxckFNSEpBaVJUcWZq?=
 =?utf-8?B?eXVMQUlGN2QzSlNPZWovMVlHVmVTOEhKVEVOYmhjWTBYYVh3ZTRyQzRtYzBP?=
 =?utf-8?B?cHRoOXRjQjBjaVNGVm1NWDh1NGExRkd1dFZEbGtHNTlzUkR5WkJnNDcyMitx?=
 =?utf-8?Q?53cRkQZRqWco8ojN1R49t437MKog0pATfacGzSEKnOWST?=
X-MS-Exchange-AntiSpam-MessageData-1: 5VQEznOxpZ8FsQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ecadf33-4a93-4b1e-daea-08decaec44fb
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 14:42:05.2643 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sfM6MEwsWMuH5S8QUgfc3nlZ5ND3W3TTEMWHVY3jN3LIvE1WzkCi3HdRdJZ6qa2CblwNhTjWhFHo9RTVYajsLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9668
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

Currently, `GspSequencer` stores a raw DMA handle. Instead, store a
reference to `Coherent` to statically ensure that the allocation lives
long enough.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/hal/tu102.rs |  2 +-
 drivers/gpu/nova-core/gsp/sequencer.rs | 18 +++++++++++-------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index eb7166148cc9..1e08c482fd39 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -344,7 +344,7 @@ fn post_boot(
         // Create and run the GSP sequencer.
         let seq_params = GspSequencerParams {
             bootloader_app_version: gsp_fw.bootloader.app_version,
-            libos_dma_handle: gsp.libos.dma_handle(),
+            libos: &gsp.libos,
             gsp_falcon,
             sec2_falcon,
             dev,
diff --git a/drivers/gpu/nova-core/gsp/sequencer.rs b/drivers/gpu/nova-core/gsp/sequencer.rs
index e0850d21adca..ddb6abc45a37 100644
--- a/drivers/gpu/nova-core/gsp/sequencer.rs
+++ b/drivers/gpu/nova-core/gsp/sequencer.rs
@@ -6,6 +6,7 @@
 
 use kernel::{
     device,
+    dma::Coherent,
     io::{
         poll::read_poll_timeout,
         Io, //
@@ -31,6 +32,7 @@
             MessageFromGsp, //
         },
         fw,
+        LibosMemoryRegionInitArgument, //
     },
     num::FromSafeCast,
     sbuffer::SBufferIter,
@@ -136,8 +138,8 @@ pub(crate) struct GspSequencer<'a> {
     sec2_falcon: &'a Falcon<Sec2>,
     /// GSP falcon for core operations.
     gsp_falcon: &'a Falcon<Gsp>,
-    /// LibOS DMA handle address.
-    libos_dma_handle: u64,
+    /// LibOS memory region init arguments.
+    libos: &'a Coherent<[LibosMemoryRegionInitArgument]>,
     /// Bootloader application version.
     bootloader_app_version: u32,
     /// Device for logging.
@@ -233,11 +235,13 @@ fn run(&self, seq: &GspSequencer<'_>) -> Result {
                 // Reset the GSP to prepare it for resuming.
                 seq.gsp_falcon.reset(seq.bar)?;
 
+                let libos_dma_handle = seq.libos.dma_handle();
+
                 // Write the libOS DMA handle to GSP mailboxes.
                 seq.gsp_falcon.write_mailboxes(
                     seq.bar,
-                    Some(seq.libos_dma_handle as u32),
-                    Some((seq.libos_dma_handle >> 32) as u32),
+                    Some(libos_dma_handle as u32),
+                    Some((libos_dma_handle >> 32) as u32),
                 );
 
                 // Start the SEC2 falcon which will trigger GSP-RM to resume on the GSP.
@@ -342,8 +346,8 @@ fn iter(&self) -> GspSeqIter<'_> {
 pub(crate) struct GspSequencerParams<'a> {
     /// Bootloader application version.
     pub(crate) bootloader_app_version: u32,
-    /// LibOS DMA handle address.
-    pub(crate) libos_dma_handle: u64,
+    /// LibOS memory region init arguments.
+    pub(crate) libos: &'a Coherent<[LibosMemoryRegionInitArgument]>,
     /// GSP falcon for core operations.
     pub(crate) gsp_falcon: &'a Falcon<Gsp>,
     /// SEC2 falcon for core operations.
@@ -369,7 +373,7 @@ pub(crate) fn run(cmdq: &Cmdq, params: GspSequencerParams<'a>) -> Result {
             bar: params.bar,
             sec2_falcon: params.sec2_falcon,
             gsp_falcon: params.gsp_falcon,
-            libos_dma_handle: params.libos_dma_handle,
+            libos: params.libos,
             bootloader_app_version: params.bootloader_app_version,
             dev: params.dev,
         };

-- 
2.54.0

