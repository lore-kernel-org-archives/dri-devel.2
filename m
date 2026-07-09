Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28AD7C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 06:57:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7325A10F3D0;
	Thu,  9 Jul 2026 06:57:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="mdof3l8z";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012055.outbound.protection.outlook.com [52.101.53.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52F8410F3B9
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 06:57:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xr+l+JKI+/isjKLDu/mWOpHW5QHZ1Zttl+33I5EVhnNw96aLwK/LzpNlS2w9Q1ILmieRw7GbtWc5F+O6lhjLecNEsTQdjWKAtUeymwVHIx/hZQy+B7B350dI0qMudnqKNkOWltuXSi/EIbu0MlY7L2BRl9I/ndLFyrT10HLUDpy2i1rDGN162IiRcoc8Kjkalbbf1ppbnxJ+/WR6zYKtSXBB+XW5Hhc53tDq9dHEzkWPJAiRYpdlRiBOh6PEOROuanXubWhNB1xrV2RbRCfwSXum9/K4/sCsLIh+QaRU444JdJOgpF5Zo56K+iwI+E6hypvuizpS+uw/de0Nj3e8sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tktASvqt36sPElYTWYD4D5AqqYuN3MC8djNurtyfAKI=;
 b=PJd8e0LkuTOKAbgiTxIBB9kbStOB+EYQylhHGzlt2YDHvaDNaHm8hl4BqPIOnOhFbnklojiI+hiQ/gXukNnsGlz9R7uO/dp0ySUcRrouWn+lq8BhSjqcEDxC92MMLR0CuBBtmX34/yx6aRfiq4+ksOLWDjrqJJEFgWAhxSYx2vRIGuG+hnpu1s9A4/ygRm+LRMoeY5Drx8hMdCOZaYPxzxibugE5jTQQq1cL6z1dS17o41OJOmO3cjNyKfJINu3qlu9i9xuJOVuWAquRQeFCOlaBEv8HfAHb44Ktf+MwTh3ZEkc6utyKa+jkDSjT5LkxA9PYg9Hozxj9gGBqZWohUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tktASvqt36sPElYTWYD4D5AqqYuN3MC8djNurtyfAKI=;
 b=mdof3l8zc8cC4LdDSDFMr6Bgq/VKM1NkwZ/dzc7AxJXllhRxLdmF+avhJR7wjiKJuxK8XBpG3Vc+GSWaXG0JxP6AN6P5YDiQ//9NP7lGTgFmjKQsfPnTvG5kbrVZ1Y5XRuQxBLKIIeGeGqRYBHZPkd1bZvSJ9Zk6M/c3kck6sj2MgPLdaW4R93eTJGLpq0UK5eQmLe4rlaeXvmQKnPxIedXKuaMoZrSl5b9HT8YADIfeLBzG/eXdyIB83jQbwIEteWyhO7OgVwYk6+OUsSBM6C2vXdUm22jPjW/C6Ai0EHdRqrq1iu54U1ASugGGHgFUaEau2ZWzLap2GrgygNQWuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by CY1PR12MB9626.namprd12.prod.outlook.com (2603:10b6:930:106::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 06:57:29 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 06:57:28 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Thu, 09 Jul 2026 15:53:06 +0900
Subject: [PATCH v6 13/13] gpu: nova-core: store Fsp instance in Gpu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-nova-bootcontext-v6-13-520cbf8b9b50@nvidia.com>
References: <20260709-nova-bootcontext-v6-0-520cbf8b9b50@nvidia.com>
In-Reply-To: <20260709-nova-bootcontext-v6-0-520cbf8b9b50@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP301CA0083.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|CY1PR12MB9626:EE_
X-MS-Office365-Filtering-Correlation-Id: e4a7bc00-76b2-4df2-10a8-08dedd8756cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|23010399003|376014|921020|56012099006|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: YOd8k+D3+Bt1XQ+I/zFhdsL3DDdgcyiXH2i8IXaD0H0aBySAJjjPDZPgUaRLEUSE2STLBetKEHzZmzYyd9wV3CwR/RJjcTcPci1xBta83EaPaHFtv5fjof4REFIX/c/UsgMWUGKWB9jXhe3uL3743lJZKnMZ4p1hsiYpWWeh2rEgSX85jGyh10v2JPwaK2mZHwVMnRRHpVaiqbzaHavc4cPVhWUsjO8JaTHcOS1/OYZZHEchiDROqSvl4aK/cPPKymXHbmVKsRhYrnrs6KsGi75zbG7TGv3Xd81cWloVzUlQSS50akdM2OdA9M9EnW8yKFeErsIHQq3yFIqmI1wxF9ok8DarFk7wSnjrrC5FzxzQS+jlWg2pD1/d3KNYax9GA3KOhr3CvXS71AzK6eShm8rOCEWmD5tQEBs1X0c1DYEmVEgWDMkFwa8r65hsRaQKQ3N92j2W+4ffHDYeni+eDFm1XBKGDs8aBAqS6iJCFfdi/ibZ3xlSXL/IanqTpK4rKH522zVzY/3xWex+2FNVqJW67rM3r/YOtKqAYMtw1AAs+9HS8uVY6yIqBYrGXML3q3SMkR1hXpFs769ggswWzWLW2hxHsQj5PHt8iBMH+/C5eLziNZGIaeBElP2yI6t4PshTJXmwhXBzd/H/CgzCFHzydOas/0nxMHsy81VucnbSM4TGoLm2auIxMJDRphBdVxAU//H5scWorkBaj8MCkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(23010399003)(376014)(921020)(56012099006)(11063799006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enRrV3NnTUdqOFNqL2tka1J6ZEZDUDBnWFpoMEtzZVVUQ3F3TlFhNzRSNHd0?=
 =?utf-8?B?Q3pHWFBIZS8rcXI3RmZwcE93TTNoZ0lpZkpFb0Z3cmZNdUc4cW1HNHZxNUt1?=
 =?utf-8?B?V203dCtZdnlxdFBhRVdaRkdiL0RvS3oxeG1Lb3lBbFp3b2Y3TXRVRDV1THJZ?=
 =?utf-8?B?ZTg1UUJ3cEpvYUgvN3N4eUpoZ29Mb054bGhSYWhtSWZ1UldOcHpEelAwVHpP?=
 =?utf-8?B?eVhadUVlSHhMWWM2Uk9DVHp5UHhmcU5LUXRSVU1EeTRvaktLaUVJVlVSbnB5?=
 =?utf-8?B?R2N5VUQwWGpBNytjUXJYZHNFTTkrbkY1cTRSU0xoM1d6T0NtU0FFZzY2U1FT?=
 =?utf-8?B?bndlY3dZZVFhQzNkYzFJMXRxYytleTRxOEw4bCtGWElMQ2tEeityUXBkRXNN?=
 =?utf-8?B?c2hFVnEyYWVFR3JjbW5Ja0U1MmhaZ0oySFBMd2E1TWJaOHNiNkZJdVFLVW1r?=
 =?utf-8?B?WnRMTXhGSW1qbS83Sk4yTGVUQTNISjFMNTdCTFRsTXcxQnk3UnE1bmZBN1R6?=
 =?utf-8?B?Z2RsR214Y3A1MnZlakFKaVF6WkwyaWhsUjBNOE42YmZHb0RkWFVtaFNFMW1F?=
 =?utf-8?B?MndDMEd5cjZBaFl0SnFycGtoV1VsUlgvUGFNWU5IbmZQak51Ymo1VHA3S0hJ?=
 =?utf-8?B?aituTTNxS0dZMHgvS1ViSDJ0UGdCZGx6MjJVY1IrdU9zY2hsc3QwOTNLRkpW?=
 =?utf-8?B?N1ZTLytYMWhvUGFKbnZrWkJGTDBkblA2WVl3Nzg0S29Zem55aW1IZS95Vng0?=
 =?utf-8?B?VjdZOGR4dm1IdjNOUy90YTRRS2s1QjN4RjVWSWorME5iVEV1Mi9xNnhZRi9N?=
 =?utf-8?B?TTR1SE1tWjY4S1lXL0ptblpCQ0pxMDV0UUE0aHBvczF0ZkwzUklGWWhTREQv?=
 =?utf-8?B?YjQxNVphdThwWXdvdlcyTXlNRjR2Sm45VklGR0VoSTlJQm83YU1ReVhBVEln?=
 =?utf-8?B?RFlOdURsN3ZjYmY3UXRIN09IaFh3UURuZVlsNHFOenJTdEJhcCtqL2tCUkpT?=
 =?utf-8?B?MDVsSXpTK0pjalozV3FBT3lVYlkzTENtTGZoQmx1N1FaQXBaUUpRTWxkcmt6?=
 =?utf-8?B?bFdHcWFDS3FaUXdZWUgreUxmY3lsUEF5eTBFOTFyN2dpM0xFbVZiV2dyOFBn?=
 =?utf-8?B?Y2xDMHl3aUVsMmN4Mko1Sk5WU0krUDF6ME9LYW41emdLQ1V1MW5abWtaNXoy?=
 =?utf-8?B?TzZvTSt5L0ZRNjJyN3RkMHJTd2VIOGlLV2lHM0ZyMXoreXpxVWlGV254YUNC?=
 =?utf-8?B?ams0Z1RQbjljMGVoT21xa0p0aWRta1lIazJoNEorSS9CQndRbnhIWVdYNE9U?=
 =?utf-8?B?ZjFvRG16M1hzMmtjSUZrek5DczVONlFNL0RweVdqOEVnSTYveTRBQmk2YVhZ?=
 =?utf-8?B?a1IzRWU2RGpnTnRWUm16RjB0ZVJjU2lRaTdpZ0VsdWlaU0JVS3NSL2lxV3dq?=
 =?utf-8?B?Y1pXeGlZSlFodHMxR0s3UUloak9Ca2dRQ2tLdFg3Mi95R1R2NWV1aXFUQ1Rh?=
 =?utf-8?B?NmRYMGc2SW5CUlFHT3MzWTU4NWRqWklyYUgyb01BNEJra2ZMOGd6Z3hJWlNx?=
 =?utf-8?B?Q2lWRG1KbVloQnNNb21jbDBaVXUwZTZtU1BkMlI2VlFRR1Z4MWJybURQRTBw?=
 =?utf-8?B?WTZDL3FQYXErL2J6UWlSTVpTSi9WdUpKeDNlY3Y2YXliTnFhcVhPbFF6djZn?=
 =?utf-8?B?YWpCeE04cHQvcTQzUTVVN2FrRTJqeDVQbFp3QVp1ZEhMbnYwQmpoQUYwbnV0?=
 =?utf-8?B?blFDWHh2ZUpnR3NlTXIzOThWSjRrNmJMdDZ3RDNrT1pKcjBpZDNqYlZBR2xl?=
 =?utf-8?B?YzIxMTlTa2NUcWY2S2U1OE5NSEJNcE9kWGxQTmV1RGFxSVJTUTdLSmN6VFly?=
 =?utf-8?B?aGJYRHRBbmRRcUx4c3Rwc2NJN0YvTVI4RnNWbndtaDRJSlVsWE1TOEVvdmd1?=
 =?utf-8?B?WFRUS1BEdGtnOTVVUG15M2ZwZ3FkRHdTTW8rbHEzSmRaeTFzV0dQRXkydHJo?=
 =?utf-8?B?cW1kMmZ1dFVNODVYbTk0U0V6VVF5KzRnUjF2aVhKcUY0WmgwRXRBdXA3eFdW?=
 =?utf-8?B?YW40dUpwNDcwVmM3Nk5JM1pHUHpPYk4weVUyQlpNS3VqbFUzZlErempJdVB0?=
 =?utf-8?B?Sng0c05VUG1IVjRtK0hsUHUzSXdTbWJXa2IrMXk2Y0NWaHZ5dmFkVVQzbkJ1?=
 =?utf-8?B?andwMFVRSWZUV1RSeVQzb2h2SUgrZHpsUnFKR3RMeHJrakJtbTExTDVLQ2Fz?=
 =?utf-8?B?dXprTngzc2JPMnlwRk95bjlSS3VDZG5LVm9hQXJHQnZGYksxRXl1dmtMODVK?=
 =?utf-8?B?RU90TzdlL1NKQUgyeUlwcXQ4Zk1DQm9WR05qWkhBdXFuZTJSY3RFQkhKV0JM?=
 =?utf-8?Q?H0mbikpRe8wzb9qwCQrnuUM/rSlqJyDMKlvmPcRWt3sER?=
X-MS-Exchange-AntiSpam-MessageData-1: TCYNZDKX10YTeQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a7bc00-76b2-4df2-10a8-08dedd8756cc
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 06:57:28.5164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YHsysmbl+Gx/yfIdKkZoyuCfvG5xKsfbdlS3/dDe+S2EgrNrcNl8hwnnY6jg7TaHdZEjd02QkZJucSlaZn+4aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9626
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

The `Fsp` instance was only used in the Hopper+ boot path, and
consequently built locally (and immediately dropped) in it.

This worked well as a temporary measure, but the FSP is a GPU
sub-device, so its lifetime should match the GPU rather than a single
boot invocation.

It will also be needed in other parts of the driver, for instance vGPU.

Thus, create the `Fsp` instance in the `Gpu` constructor and store it
there, passing it to the GSP boot as a mutable reference using
`GspBootContext`. This makes the `Fsp` available even after the GSP is
booted.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/fsp.rs           | 21 +++++++++++++++++++--
 drivers/gpu/nova-core/gpu.rs           |  9 +++++++++
 drivers/gpu/nova-core/gsp.rs           |  2 ++
 drivers/gpu/nova-core/gsp/hal/gh100.rs | 19 ++++++++-----------
 4 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
index 08f4acef09f6..afbd75879d16 100644
--- a/drivers/gpu/nova-core/fsp.rs
+++ b/drivers/gpu/nova-core/fsp.rs
@@ -231,20 +231,37 @@ pub(crate) struct Fsp<'a> {
 }
 
 impl<'a> Fsp<'a> {
+    /// Attempts to create a `Fsp` instance.
+    ///
+    /// This can involve waiting for FSP secure boot completion, but should be instantaneous in
+    /// practice.
+    ///
+    /// If `chipset` doesn't support FSP, `Ok(None)` is returned.
+    pub(crate) fn try_new(
+        dev: &'a device::Device<device::Bound>,
+        bar: Bar0<'a>,
+        chipset: Chipset,
+    ) -> Result<Option<Self>> {
+        match hal::fsp_hal(chipset) {
+            None => Ok(None),
+            Some(hal) => Self::wait_secure_boot(dev, bar, chipset, hal).map(Option::Some),
+        }
+    }
+
     /// Waits for FSP secure boot completion, then returns the [`Fsp`] interface.
     ///
     /// Polls the thermal scratch register until FSP signals boot completion or the timeout
     /// elapses. Returning an [`Fsp`] only on success guarantees, at the API level, that the
     /// interface is not used before secure boot has completed.
-    pub(crate) fn wait_secure_boot(
+    fn wait_secure_boot(
         dev: &'a device::Device<device::Bound>,
         bar: Bar0<'a>,
         chipset: Chipset,
+        hal: &'static dyn hal::FspHal,
     ) -> Result<Fsp<'a>> {
         /// FSP secure boot completion timeout in milliseconds.
         const FSP_SECURE_BOOT_TIMEOUT_MS: i64 = 5000;
 
-        let hal = hal::fsp_hal(chipset).ok_or(ENOTSUPP)?;
         let falcon = Falcon::<FspEngine>::new(dev, chipset, bar)?;
         let fsp_fw = FspFirmware::new(dev, chipset, FIRMWARE_VERSION)?;
 
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index fc90069bc2fe..442c0979f9c6 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -22,6 +22,7 @@
         Falcon, //
     },
     fb::SysmemFlush,
+    fsp::Fsp,
     gsp::{
         self,
         commands::GetGspStaticInfoReply,
@@ -262,6 +263,10 @@ struct GspResources<'gpu> {
     gsp_falcon: Falcon<'gpu, GspFalcon>,
     /// SEC2 falcon instance, used for GSP boot up and cleanup.
     sec2_falcon: Falcon<'gpu, Sec2Falcon>,
+    /// FSP instance, if on an arch that supports it.
+    // TODO: use different resource types for each boot method, and make the relevant Gsp methods
+    // generic against them.
+    fsp: Option<Fsp<'gpu>>,
     /// GSP runtime data.
     #[pin]
     gsp: Gsp,
@@ -305,6 +310,7 @@ fn drop(self: Pin<&mut Self>) {
                     chipset: this.spec.chipset,
                     gsp_falcon: &*this.gsp_falcon,
                     sec2_falcon: &*this.sec2_falcon,
+                    fsp: this.fsp.as_mut(),
                 },
                 bundle,
             )
@@ -356,6 +362,8 @@ pub(crate) fn new(
 
                 sec2_falcon: Falcon::new(dev, spec.chipset, bar)?,
 
+                fsp: Fsp::try_new(dev, bar, spec.chipset)?,
+
                 gsp <- Gsp::new(pdev),
 
                 // This member must be initialized last, so the `UnloadBundle` can never be dropped
@@ -367,6 +375,7 @@ pub(crate) fn new(
                     chipset: spec.chipset,
                     gsp_falcon,
                     sec2_falcon,
+                    fsp: fsp.as_mut(),
                 })?,
             }),
 
diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index 9f055a0d6cb9..d89cc3ba7c72 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -39,6 +39,7 @@
         sec2::Sec2 as Sec2Falcon,
         Falcon, //
     },
+    fsp::Fsp,
     gpu::Chipset,
     gsp::{
         cmdq::Cmdq,
@@ -65,6 +66,7 @@ pub(crate) struct GspBootContext<'ctx, 'gpu> {
     pub(crate) chipset: Chipset,
     pub(crate) gsp_falcon: &'ctx Falcon<'gpu, GspFalcon>,
     pub(crate) sec2_falcon: &'ctx Falcon<'gpu, Sec2Falcon>,
+    pub(crate) fsp: Option<&'ctx mut Fsp<'gpu>>,
 }
 
 impl<'ctx, 'gpu> GspBootContext<'ctx, 'gpu> {
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index d134ad052308..ad04904b5af4 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -17,10 +17,7 @@
         Falcon, //
     },
     fb::FbLayout,
-    fsp::{
-        FmcBootArgs,
-        Fsp, //
-    },
+    fsp::FmcBootArgs,
     gsp::{
         hal::{
             GspHal,
@@ -143,7 +140,6 @@ fn boot(
         wpr_meta: &Coherent<GspFwWprMeta>,
     ) -> Result<Option<crate::gsp::UnloadBundle>> {
         let dev = ctx.dev();
-        let bar = ctx.bar;
         let chipset = ctx.chipset;
         let gsp_falcon = ctx.gsp_falcon;
 
@@ -151,8 +147,6 @@ fn boot(
             KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn UnloadBundle>
         );
 
-        let mut fsp = Fsp::wait_secure_boot(dev, bar, chipset)?;
-
         let args = FmcBootArgs::new(
             dev,
             chipset,
@@ -164,9 +158,12 @@ fn boot(
         // Wait for the GSP RISC-V core to halt in case of error. We create this guard after `args`
         // to make sure that boot args are kept alive until halt, in case they are still being
         // accessed.
-        let unload_guard = ScopeGuard::new_with_data(unload_bundle, |unload_bundle| {
-            let _ = unload_bundle.0.run(ctx);
-        });
+        let mut unload_guard =
+            ScopeGuard::new_with_data((unload_bundle, ctx), |(unload_bundle, ctx)| {
+                let _ = unload_bundle.0.run(ctx);
+            });
+
+        let fsp = unload_guard.1.fsp.as_mut().ok_or(ENODEV)?;
 
         fsp.boot_fmc(dev, fb_layout, &args)?;
 
@@ -174,7 +171,7 @@ fn boot(
         // anymore.
         wait_for_gsp_lockdown_release(dev, gsp_falcon, args.boot_params_dma_handle())?;
 
-        Ok(Some(unload_guard.dismiss()))
+        Ok(Some(unload_guard.dismiss().0))
     }
 }
 

-- 
2.55.0

