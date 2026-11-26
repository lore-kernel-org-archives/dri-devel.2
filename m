Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D52606A6A9
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=q57gX0WQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71587112152;
	Thu, 26 Nov 2026 08:21:32 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010042.outbound.protection.outlook.com [52.101.61.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3CD811214C
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 08:21:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rztGmBdvEd803pDpXKKRVY4gYCKrdMLdj1/rVrg1wK7nP6Z4JqtZqIymZWkF9iUGpPD864ojIBQflf3PeosZAUquHIEaHSsYsvFcSkIFxhqbWyjx2pzrZl7Ll8P9ZcYhmX9yBU0mcBgQsGjwBXLKce+queynG9LDs5+zV+SGL96ezRwuuDKTliAoeGSeT1SNT/25q3BWOQN2xuyp5MvtBfRb+5zwlL3V3aV/Ya/8LVXWafz03XTI/LstJVB90Oo7YAN0rlc6/GG+khh66QZPW6OqUXVHR2PCX4oT2FHMpR35yhGIg+cBE2JobA8q7gjscSxcLf9vUhjNTAJioXhYRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oyh0kj/R8umHJj2SqUTnnQhIcSS2UaH31HjwRPx2IJg=;
 b=MNAdvi05XKYBAG80owol+kUZCXnIQyZAgBbR2y+1iLNRfc5C5bjvQq9gA7pICtLF9DpMlBG3f2wYRfm/ST4sMfbVcR56Q1IBBv1FU1Z/BusUtvNomcApwAr17FlXuQVDwJjbUWU7lBmpWjiBXbBEQBcA1BQPrq9L5o0Qor0W+uJnkgQu+BUboYuUhBZt1GJ2SNcBybt5Esl/3QoktH1VziWkIQV9KwAYINxUUkDO/80Q+iUk3r1IW9JR3U1RnMXP1gG+9j2C03SLvNpqx/Na0NDQDPKsPCTg4qKh6eV5bZJDJ8eNPsmDkOKJcK1CvhUL+JrmYxmeIIBdy6oRT2Wj/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oyh0kj/R8umHJj2SqUTnnQhIcSS2UaH31HjwRPx2IJg=;
 b=q57gX0WQisBXQrVxZJib6iRq3PH+DoJ4dhW859/cFPXwhxWE2tL4r4otTM5JkFHO8Hs8R2NW6RVUuAT19Mo3Ogf6xpdrDLEWN4+VpD1duUZY6v4z3Th799QhC7UAbzu+S2bGcxc0z+ZhcVZ8hIhyo/mpXOb9hpAA79IvgX3oGy7n74jikTlBt8n9TfEZyD+qP1tscEhNDvBJRhh8NRZJCRpQ/76HSyWu3foGOgyQ1q1ndJ4XzS+fwYL6b1sGypatslmuDNttvVj0pOMcFmq3esHImzaWGGJYbH2K9fNFHTTIZsgTJqrQKSmdMbvgY1Zds1iNRe8BTtPtXGFzvj4qyA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 LV0PR12MB248855.namprd12.prod.outlook.com (2603:10b6:408:603::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 26 Nov
 2026 08:20:53 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 08:20:53 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 26 Nov 2026 17:20:13 +0900
Subject: [PATCH 4/7] gpu: nova-core: falcon: separate staging data for DMA
 from its location
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-boot-rework2-v1-4-99a1dc6c7cc4@nvidia.com>
References: <20261126-boot-rework2-v1-0-99a1dc6c7cc4@nvidia.com>
In-Reply-To: <20261126-boot-rework2-v1-0-99a1dc6c7cc4@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0208.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::18) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|LV0PR12MB248855:EE_
X-MS-Office365-Filtering-Correlation-Id: 39780545-f222-4b33-1512-08df4b962fa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|10070799003|366016|22082099003|18002099003|56012099006|11063799006|261009223027099003|261021123027099003|10067099003|261026121527099003|261021135927099003|261102123227099003|261022105027099003|261026140227099003|261022075727099003|261021121427099003|261028144727099003|3023799007;
X-Microsoft-Antispam-Message-Info: AfnR/fTmT5JbHBcTVVY1aBATIIdv40GLZwk46df12itdtY140HaI2k+ZCrjeYFQn+7L1mx8t2qqWDomGA7QvMNt9c+QPVsvMIcFyPPT32CSz8KHfUkJPmsqfWv9fxphW8Fj8+Ep4GcLsYBx23NjaR/a1bbvZsLqYXb/s0lVeK3zsONSJnQXA+KbIlvTFSLS/98NwXiBAqbs1Z04T8j/yLrumhYchLen41UQDhhc7yNQGiyKFtgRN+/8MUnJKC2farLskuVFpORqrhdZN1vKLGSW9Vux3O7ZeC/IXFF5cmBCK55nQY5SVsTBLgcg9Gtg3SEAI0EfZrSsdGokhi/5ygXI79ZsmOGlSaJc1PVzh0bH7QnxaBNJwCC35F5xOr/Nv7cWaCdKSrYJvLNd3tYkyzyvtvcJvOXExSQh1WF/l6XrEeeYD/rkp5RWxvz5ET4r/uS4GEkOXjHZ8+E1oUJd0MdQVcFaro7RblE85ByrXeJ8sW/pphHIA9tQyR3F5WhhhD7ak22HmvNsBUC3jRdgT1X8cLe4ZAnTfNTkDS3K6LwPWo3xWuliABVR7soZtvOEkNrwP8iOVii11oqdJhymGcRe3p9tHUTz/W3w4NFWCoqa/LMlDd44iGyuuLB6MXsgAq5tyzCLO31BqD1p2iqM015G3ihh2Iad2m82s4ifSe9o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(10070799003)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(261009223027099003)(261021123027099003)(10067099003)(261026121527099003)(261021135927099003)(261102123227099003)(261022105027099003)(261026140227099003)(261022075727099003)(261021121427099003)(261028144727099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzZXb3d5UVlDTlY0dkpxUXI5TU9BblNsZGllREpwQ1FuNWdMMjdRZWRpL21X?=
 =?utf-8?B?dzRCRlhhRDhsdnUxTTRBUHhLZjlRRHdtSjMybUc3QTE5ZVd4YmNWZStwTEor?=
 =?utf-8?B?bEJlaXE0cysrcytJdTZqbzJFSEJCa0JuRHNNVEx2bm9HQVZ1NXFPc001bWZ1?=
 =?utf-8?B?dmszOS9oZW9sU0NtYUR0YVlDRSs2WCsvSkhvTCtGS2t3N2h1Yk9MRUNTQnJz?=
 =?utf-8?B?NEtmYVI1RGkzV0pQdnFKZFp0a3l2MTNyOFQxalNibTQ2QStkUGJDblZRNUtH?=
 =?utf-8?B?V01hcnVYSW1YMk41NGlqU1lTM2NyTjM4cjBGZTFBVnRmc21QWTQ3T0NkVk9V?=
 =?utf-8?B?TGVnenRKRDNBenQ2cDJVTFFDcStJTFlTQStWTFR0MEZJdUxvVllLREQ5bHRr?=
 =?utf-8?B?bmE5dUQ5a281bXNuSFdsTzFQOXY3WFMyeEFTak9UUDE2bXBSTVVnZUt0Z202?=
 =?utf-8?B?MjdXWFY1QzlwNTNQUHdqNnlvbzBjTGpYeHFxQlRTSm1laVZId1FwM2d2THc4?=
 =?utf-8?B?dzdvOUxWdmJwSEswWllBbnR3aFpPdUNhZ1pER2NLbDQzelJyLzRaT1R0aFBr?=
 =?utf-8?B?ZWxqVUI3UW1WaFdVbFpCdGZKeHlFa2JCTmZoY1A2aWlEZ3NNYys5cjdPM1Qy?=
 =?utf-8?B?WWk5cHFEM1gxdTVPSTQyemptQTN4MlRSYytyNWxsZlB0N0FySjU3T2k3Qjhr?=
 =?utf-8?B?L01DS0VCMHRXSHlRMDBNTUNvMFZ6K2Y2c2ltck9nSUF6R2dTdW5IZHltTTRy?=
 =?utf-8?B?OVRYaXdzZ2tLTG9jUmNYVkZPQkRwdXdxRnlwdzBXRHdtMkt0UUJqeDBPTXlO?=
 =?utf-8?B?MExBdHRYQ09jeTQ2NzhuWjRUNTlGd1dOc1NlOE11d3A1WUdvemI4djhxRVdm?=
 =?utf-8?B?S0FvcVF3M0c1MGxwK0RBRUlPdmhOZmJpT09XM24wcE05N1dsZ1RldDNvWlo1?=
 =?utf-8?B?NnFhRXk2MlVKcEpnKzk5OUNZdVpSZlM3NFhHSk5RdWNhczVndGx6Tnc3VjFu?=
 =?utf-8?B?N0l2THIvU2RGYzEzQW1weGZMZCt3Rk1ZQlFCTG0vNTVUU2RaM0p4VDdnSmFP?=
 =?utf-8?B?THFnVlJPV2t6NkdOTXhrbjJzOFNjTnQwalhKcmlkd0J3R0xSOWw3NVJEaGs2?=
 =?utf-8?B?cXhPcWlVMEVxZWFrd1dPSUlXZFNEblpqMHpNUy8wU1BuZnhGNDZSamJYbW5t?=
 =?utf-8?B?emJGbHprdDRzUldOSVpkOFNLWVh1MllVb1M0dmgzY3M1bUpBOUVDcFZyMFBK?=
 =?utf-8?B?OTJFbzVvTlhtR0RqTUtoSGRTSFRuWm4rMU4zQWhzRjhQUHZnNTIyNmV2QVFI?=
 =?utf-8?B?WDh4RnRKcVprb2tPYjc1K0J6MDdNRHRHaGVZVC8ySDd1ZU9RKzZXTmVNWENI?=
 =?utf-8?B?S0JXNVNlTVErYm5uKzFUWjd3MzkvL2d6R3IrRjhPcUszK25SUmhTb1NiN1o2?=
 =?utf-8?B?SEVKYUV3a2JNMzltc3BwUnE3bzhCYXlQam1LdkpwQUFlMmNzNHFIN2tkdEF0?=
 =?utf-8?B?UXRSQ0FNRmFhZTM1OWU0UU5kN1laVTFPQjVmUUNUYWlDSXJZMGhGYU5Sc083?=
 =?utf-8?B?NlV0NENXS3ArMW9yb3BuYTQrcWFPU2daR1dYcHlEZ0IyTWUybzhLQTFRcUJ6?=
 =?utf-8?B?RlV6T2FpV2RrbE9ZWklRc3IrZlIwTFQzMWVGOE9NMjVLNDB2cnRYZmxva3VP?=
 =?utf-8?B?bDBTSHRwNEh3ZjljcXZMdnU3TUlUZkh0N1dna0JTRW5EN05DbEVIM3JzMHE4?=
 =?utf-8?B?Tjh3MkJNT1crdDRYaDl6NnB2RFpIUm1Ld0gyd0h4QTBmWXRtT2RPb2FzSTh3?=
 =?utf-8?B?ZDIrUTBsRFhsY3VjVEZEZC9nZko4RXRhaHY0cGgvYUZDLzlEbG9pVVlZN1lZ?=
 =?utf-8?B?MmtxNU91YlcyU00zZ2gwN1R3TWd4NXNtVnJuUENLZ01CajRQS3I1emNaYzlZ?=
 =?utf-8?B?V0ZTYW5JTlhDbklsQS94Vis3ZkYxaEZ2QU9hekQrc2Y0c2g5aURkZ0FjMzk3?=
 =?utf-8?B?RW5lSGtiSzU2ZWZMOGhwaGxWb045RzB4Z3Vib29MZTZCVWtSK0dDNEJEY2ZO?=
 =?utf-8?B?OVZRUDBWQWdmSmVWVTdpN3VzWFdOVFJhTDlERHBDblJnaVVJTVF0czM2MGg5?=
 =?utf-8?B?N0RabEFReVZuKy9FL1lWNFlmYS9EaXRZWmFNbDhONWhuTzZ5SGVNSUxLdUpU?=
 =?utf-8?B?SUN5RDhpRVZRRGxZWG1NcTVrbG01UDhVdHZWdHAwQnVMTFVrQnQzMmErWVhi?=
 =?utf-8?B?dXhpWlRWSjhyUm9sY3ovQ081R004L2orcXJ3OGhSOFBTeXVNN3I4NkErLzJq?=
 =?utf-8?B?eDZSYjBMMXZ5czl5amF5bjhQUlJzWVl2NFBaYXBKV3pTYlRhcVdTM2Z4MjdF?=
 =?utf-8?Q?22ucHbaVXgWrfIZplrbp2jDnTyYRa1xZRfbHa2vuUrcET?=
X-MS-Exchange-AntiSpam-MessageData-1: R2NAU9hOjMllcQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39780545-f222-4b33-1512-08df4b962fa6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 08:20:52.8372 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +iXp8WKRLgFz+qk32080btEK+AdPZk+QEzOH3nT8LsD6uEO/FMIAedMhMw+gkSyQ9DMx3l4wEFLNGRaVK5X9Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB248855
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Introduce a new enum `FalconSegmentSource` that holds the source of
each segment to copy to a falcon. This replaces the existing
`FalconDmaSource` enum which mixed the jobs of knowing where the bytes
to copy to the falcon live with how they are copied (DMA).

Since `FalconDmaSource` is removed (to separate how data is sent to a
falcon from where it lives), merge the staging of the data that gets
DMA'd to a falcon with actually performing the copy. This separates the
decision to stage it for DMA from where the data is living.

This is useful for allowing DMA from framebuffer memory and sysmem to
falcon in a unified way.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/falcon.rs | 126 ++++++++++++++++++++++++----------------
 1 file changed, 75 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index 7dfe71e4cd49..f0e6f0eea641 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -12,7 +12,6 @@
         DmaAddress, //
     },
     io::{
-        io_project,
         poll::read_poll_timeout,
         register::Array,
         Io,
@@ -140,15 +139,6 @@ pub(crate) enum FalconMem {
     Dmem { tag: bool },
 }
 
-/// Where a falcon DMA transfer reads from.
-pub(crate) enum FalconDmaSource<'a> {
-    /// A DMA object in system memory.
-    Sysmem(&'a Coherent<'a, [u8]>),
-    /// GPU framebuffer memory at physical address `base`.
-    #[expect(dead_code)]
-    Framebuffer { base: u64 },
-}
-
 bounded_enum! {
     /// Defines the Framebuffer Interface (FBIF) aperture type.
     /// This determines the memory type for external memory access during a DMA transfer, which is
@@ -208,6 +198,16 @@ pub(crate) struct FalconDmaLoadTarget {
     pub(crate) len: u32,
 }
 
+impl FalconDmaLoadTarget {
+    /// Returns the data that should be copied to the falcon from `blob`.
+    fn data<'a>(&self, blob: &'a [u8]) -> Result<&'a [u8]> {
+        let start = usize::from_safe_cast(self.src_start);
+        let end = start + usize::from_safe_cast(self.len);
+
+        blob.get(start..end).ok_or(EINVAL)
+    }
+}
+
 /// Parameters for the falcon boot ROM.
 #[derive(Debug, Clone)]
 pub(crate) struct FalconBromParams {
@@ -219,6 +219,21 @@ pub(crate) struct FalconBromParams {
     pub(crate) ucode_id: u8,
 }
 
+/// Denotes where the bytes of a firmware segment are.
+#[derive(Clone, Copy)]
+pub(crate) enum FalconSegmentSource<'a> {
+    /// Bytes in system memory.
+    Sysmem(&'a [u8]),
+    /// Bytes in the framebuffer.
+    #[expect(dead_code)]
+    Framebuffer {
+        /// DMA base address of the segment in the framebuffer.
+        base: u64,
+        /// Number of bytes in the segment.
+        len: u32,
+    },
+}
+
 /// Trait implemented by falcon firmwares that can be loaded using DMA.
 pub(crate) trait FalconDmaLoadable {
     /// Returns the firmware data as a slice of bytes.
@@ -545,36 +560,39 @@ pub(crate) fn with_fbif_transcfg<R>(
         Ok(result)
     }
 
-    /// Perform a DMA write according to `load_offsets` from `src` into the falcon's `target_mem`.
+    /// Perform a DMA write from `src` at `src_offset` into the falcon's `target_mem` at
+    /// `dst_start`.
     fn dma_wr(
         &self,
-        src: FalconDmaSource<'_>,
+        src: FalconSegmentSource<'_>,
         target_mem: FalconMem,
-        load_offsets: FalconDmaLoadTarget,
+        src_offset: u32,
+        dst_start: u32,
     ) -> Result {
         const DMA_LEN: u32 = cv!(MEM_BLOCK_ALIGNMENT);
 
-        // DMA transfers can only be done in units of 256 bytes. Compute how many such transfers we
-        // need to perform.
-        let num_transfers = load_offsets.len.div_ceil(DMA_LEN);
-
-        let (dma_base, fbif_target) = match src {
-            FalconDmaSource::Sysmem(dma_obj) => {
-                // Upper limit of transfer is `(num_transfers * DMA_LEN) + load_offsets.src_start`.
-                let end_offset = num_transfers
-                    .checked_mul(DMA_LEN)
-                    .and_then(|size| size.checked_add(load_offsets.src_start))
-                    .map(usize::from_safe_cast)
-                    .ok_or(EOVERFLOW)?;
+        // Declare `dma_obj` here so it lives long enough for transfers to
+        // complete.
+        let dma_obj;
+        let (dma_base, fbif_target, len) = match src {
+            FalconSegmentSource::Sysmem(data) => {
+                dma_obj = self.dma_stage(data, src_offset)?;
 
                 (
-                    io_project!(dma_obj, [try: 0..end_offset]).dma_address(),
+                    dma_obj.dma_address(),
                     FalconFbifTarget::CoherentSysmem,
+                    u32::try_from(data.len())?,
                 )
             }
-            FalconDmaSource::Framebuffer { base } => (base, FalconFbifTarget::LocalFb),
+            FalconSegmentSource::Framebuffer { base, len } => {
+                (base, FalconFbifTarget::LocalFb, len)
+            }
         };
 
+        // DMA transfers can only be done in units of 256 bytes. Compute how many such transfers we
+        // need to perform.
+        let num_transfers = len.div_ceil(DMA_LEN);
+
         if dma_base % DmaAddress::from(DMA_LEN) > 0 {
             dev_err!(
                 self.dev,
@@ -610,12 +628,12 @@ fn dma_wr(
             // Perform a transfer of size `DMA_LEN`.
             self.pfalcon.write_reg(
                 regs::NV_PFALCON_FALCON_DMATRFMOFFS::zeroed()
-                    .try_with_offs(load_offsets.dst_start.checked_add(pos).ok_or(EOVERFLOW)?)?,
+                    .try_with_offs(dst_start.checked_add(pos).ok_or(EOVERFLOW)?)?,
             );
             // The source offset doubles as the virtual address tag for IMEM and tagged DMEM.
             self.pfalcon.write_reg(
                 regs::NV_PFALCON_FALCON_DMATRFFBOFFS::zeroed()
-                    .with_offs(load_offsets.src_start.checked_add(pos).ok_or(EOVERFLOW)?),
+                    .with_offs(src_offset.checked_add(pos).ok_or(EOVERFLOW)?),
             );
 
             self.pfalcon.write_reg(cmd);
@@ -634,38 +652,44 @@ fn dma_wr(
         Ok(())
     }
 
+    /// Returns a DMA object with `data` at `offset`, padded with zeros up to
+    /// the next multiple of `MEM_BLOCK_ALIGNMENT`.
+    fn dma_stage(&self, data: &[u8], offset: u32) -> Result<Coherent<'a, [u8]>> {
+        let offset = usize::from_safe_cast(offset);
+
+        // DMA copies are done in chunks of `MEM_BLOCK_ALIGNMENT`, so pad the length
+        // accordingly and fill with `0`.
+        let mut dma_obj = CoherentBox::zeroed_slice(
+            self.dev,
+            offset + data.len().next_multiple_of(MEM_BLOCK_ALIGNMENT),
+            GFP_KERNEL,
+        )?;
+
+        // PANIC: `dma_obj` has at least `offset + data.len()` bytes.
+        dma_obj[offset..offset + data.len()].copy_from_slice(data);
+
+        Ok(dma_obj.into())
+    }
+
     /// Perform a DMA load into `IMEM` and `DMEM` of `fw`.
     fn dma_load<F: FalconFirmware<Target = E> + FalconDmaLoadable>(&self, fw: &F) -> Result {
-        // DMA object with firmware content as the source of the DMA engine.
-        let dma_obj = {
-            let fw_slice = fw.as_slice();
-
-            // DMA copies are done in chunks of `MEM_BLOCK_ALIGNMENT`, so pad the length
-            // accordingly and fill with `0`.
-            let mut dma_obj = CoherentBox::zeroed_slice(
-                self.dev,
-                fw_slice.len().next_multiple_of(MEM_BLOCK_ALIGNMENT),
-                GFP_KERNEL,
-            )?;
-
-            // PANIC: `dma_obj` has been created with a length equal to or larger than
-            // `fw_slice.len()`, so the range `..fw_slice.len()` is valid.
-            dma_obj[..fw_slice.len()].copy_from_slice(fw_slice);
-
-            dma_obj.into()
-        };
+        let blob = fw.as_slice();
+        let imem_sec = fw.imem_sec_load_params();
+        let dmem = fw.dmem_load_params();
 
         self.dma_reset();
 
         self.dma_wr(
-            FalconDmaSource::Sysmem(&dma_obj),
+            FalconSegmentSource::Sysmem(imem_sec.data(blob)?),
             FalconMem::ImemSecure,
-            fw.imem_sec_load_params(),
+            imem_sec.src_start,
+            imem_sec.dst_start,
         )?;
         self.dma_wr(
-            FalconDmaSource::Sysmem(&dma_obj),
+            FalconSegmentSource::Sysmem(dmem.data(blob)?),
             FalconMem::Dmem { tag: false },
-            fw.dmem_load_params(),
+            0,
+            dmem.dst_start,
         )
     }
 

-- 
2.56.1

