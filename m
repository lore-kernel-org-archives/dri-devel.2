Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C64606A6BC
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TmQvus4Z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 264EC11214F;
	Thu, 26 Nov 2026 08:21:32 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010042.outbound.protection.outlook.com [52.101.61.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D512B11214E
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 08:21:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M7PLL4jHYTU4lJZRDwY8H7P35fTweZLWfopUPppuVx+EMR2Z3HOQbD9fkdctgrK2U54+V5k5wBXTURRG+LJFhhO8JPL2rS1DjnR+LV1mIGEFadDIylBMip2xmK07h8ESaEzMg0n6wYRaOWkL0/uUlT4yS3IMtAAV/HBGlVE26rPI+k2Vr2YBkEZzXNSKxNAP+aK8985bPfh+UxsH6J8GMmUbGq1OmvngQFv9HD9DO6s5OjJx74K5134bRuGzeYy0FweDFZqw7GDwjF9zguoD8awPgF7KHNGXU0ATF64VDIhozwUwiGD2xnyokEI0fAdjFj0OvNRMwkqyTRjzJuYJzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4N7DvZehHLExJoGyGPsVUyxtz1zY4Arl8lhBlEr3V4E=;
 b=ec9U9shg0IdbG+iDwA30YGZylDWiJs2ldn58vT4efFE+c5ccm9awixeqsT2Gw1WrbrHDknS3DTi3tG4P60TjiTOio88ALSDqtNWFWlhfAGxlSVGFq4EKDSAnmpJZXxdIUUhvyWBvCVUiYVIo+L8Wqb4UdVabjC1o6/8Zw9TNDAjh7wSMh8YA8tS8ob9bZtb7NkadYmIggcdpMXcgvA28oAXoSkHHcfYCVVaVuuSqFYEQjJRy2rh/anztSn6ZFORACAZeF/pgmhhWV4O62AOQoRucjSaralYw9m4Vh0Gzo7AeRurH3zgDpImuvgHOwKcIwgHsSotCUXHOaTjtilUneQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4N7DvZehHLExJoGyGPsVUyxtz1zY4Arl8lhBlEr3V4E=;
 b=TmQvus4ZD4JzlIChk6wpEKc7tKYQPjsUGIfjEKO51BITUHw5kT+plSqrpu2pc215LSHok28J8IFD2g4uIjJ/YFD7DYk0saot41cM7Oxj6AY6ZH7uihgsGCSuOI9sE1gHwlqZoDCM+8ugTjEV31yyhLZf2zbtxFQoURBCH8gQ0w6NeJivMYfHwETEiKlRQ10PkDVP9fGPNBDyLvXF3IUexm8pAtL0KgX3hV8SUfxeUhpZz9E7SXI4ESr7OsjKt3S5lalTYT5y7I9Lj+UHs4WkuB23LLhKaDAA8+V/Txa21eoAgYyyz/ZgP6azaAoP8HuvArZO+y1sQtPsKAnJVoPrVw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 LV0PR12MB248855.namprd12.prod.outlook.com (2603:10b6:408:603::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 26 Nov
 2026 08:21:00 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 08:21:00 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 26 Nov 2026 17:20:15 +0900
Subject: [PATCH 6/7] gpu: nova-core: falcon: rename FalconDmaLoadTarget to
 FalconLoadTarget
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-boot-rework2-v1-6-99a1dc6c7cc4@nvidia.com>
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
X-ClientProxiedBy: TYCPR01CA0175.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::15) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|LV0PR12MB248855:EE_
X-MS-Office365-Filtering-Correlation-Id: c8876f5b-f171-41bc-9742-08df4b9633f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|10070799003|366016|22082099003|18002099003|56012099006|11063799006|261009223027099003|261021123027099003|10067099003|261102123227099003|261022115727099003|261022105027099003|261026140227099003|261022075727099003|261021121427099003|261028144727099003|3023799007;
X-Microsoft-Antispam-Message-Info: 7O0RAkyKdfYotihdz+sA3NrToEAkTwJH78T+DoGhQUWVQbAGClPSdtrjnbSrphLx5WE+ayLqeaIFd2sDahq4vQJNblfM5Nw7lNxE4Gkh4IUz2v8SttMGyF2mTcoFrwxuT9XHx4Nk2Bxj4DFBznJ8Q3BrKRsKt1ylUTxSVfZM1MQroeoU9ZeDJlrTcUpXHbXAmVcT98ce/ystSLlu20eEhIUywdFgJYhN2pEGE9WAE+WNgyBZTIW8h8X1eKIfMPWbg+78dliPF69l9UiiKyQmjo+izcx5REEd7bom0Rh3NVtGwha3jiV/tZD9nEUWIyZFmJdAoIQanwt9J2B32Wpa3NtPI+yyrpO/vEvoloQEXbllv8phsD1+dmWDHcYQItwdGGEfs+Gq298IxKRHb5ktaxxRf+Uruo05Pfb5YcRK+KY1J9vj6Go3ZV0kl8mv5eTnQJTji1IWKIjsHlOEIz5s4WDZvyTyOpvTkmHYPnFUgfvoy3PZFmxZ5A7PzVuJXh+cmLSa/PoLUU3G4dc558yHu6HKxWS/gjQRKRjTYumVp2Iju6kXXBYzxpYoxExrt0fmNorzP729SstoSUq84SnqMnqhfJ82qbMj+PokOYAgPF+keONcV78PXEqb8I+NkZsb14lMc3uKx2Z6S6R9BhmEJp6QLUUihuDtuNm7/q+2t04=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(10070799003)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(261009223027099003)(261021123027099003)(10067099003)(261102123227099003)(261022115727099003)(261022105027099003)(261026140227099003)(261022075727099003)(261021121427099003)(261028144727099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWtLZno3d2dKNEhMUjJ3S3UvSUZMY3liZWhVUEY1VTJnUTdib0NwdWdSc0o5?=
 =?utf-8?B?bUlYcmdxQnprMHJ0anFSRDRPYmg5d211UWpReG9ucFQzdTJCWlZaYlROSWgw?=
 =?utf-8?B?M1VVaWVqUHl3NTRVQUQ3K3RxUGtxbkI5ZGxMZXpWYzRqVXpKVGZlNmNoYmNv?=
 =?utf-8?B?MlBZRU1mUlJGdE9wUUpQYmVkZ2U5Mjc1bVdqNUNCK2c2SjdXVDYrSEJVRlZX?=
 =?utf-8?B?bmZHYzZZYkdZeGdhVWZhWkNGdm5UOG9SNTFOdU1GcWdtdFdyNk5IRzNpYlEx?=
 =?utf-8?B?b2hUMERtRXMwWEZjaEt1TUJicTRzOXFORk40c01VS0hyUVFiUkc4RzgxTVZp?=
 =?utf-8?B?QVRhMXhXdVlscDNKMmZMbmtDQjk0SjZNZ0l2akQ4enJEMkZQTWpEODJRd1Jy?=
 =?utf-8?B?akl0L2RYbTV4UDV1VWhONDJaY0xZSm83ZzRkUkFSemd1L0JsR1BFN3JBR3VX?=
 =?utf-8?B?RGVaelZUM1EzaDU2YVJmWjdVT3JUMmRMTjIyd2pBYVk1ckYrbXJMUmlScHpY?=
 =?utf-8?B?Y3AyMldKbzRMdHVuVGJ6M2pqT05XOFZQdW1SUU85MlJFRlBMYTZVM0hNOGtU?=
 =?utf-8?B?eHB2YkM5S01rZ2Nhakl1RjFQVE5Zc1BVNWhrTTF1V25SZDhmTTdKNGdmOU1M?=
 =?utf-8?B?dFN0aDl4YVNkMGJ4MUNLSFZteFN0NkViWEJ4U1k3YmcyZEtqVGJlSkxqWlJv?=
 =?utf-8?B?Zk1VWUZJbHlMVDJoS0UvZ0Z5c0xlL2J3aGpsSDNROGx5VndjbUIvYkhkTnNC?=
 =?utf-8?B?OVFxbmc2RmUwbGtraWZZdGdBNkZROUl0ejhSSzJUdGtOdURUT29nWU0vdnpz?=
 =?utf-8?B?WE80SFkzUlVEeTJROE9xeXdLblB1TWNiWk5yT1I3emdaUEFnNXNqWGRPNkdY?=
 =?utf-8?B?RDRyZUhZUkplenpoSmNKWXMxdjg1YWhnYlZJcEgrVnYrOWxzQ2NLMFpza2dR?=
 =?utf-8?B?eHhMc014dG1WaXU3cnRjalFyVmRqN3MxOHF5WGpxcGZxeVFyWXo5R3hqeWNK?=
 =?utf-8?B?Y1lwZWcrQVI4aVBqaDBrWUJiNzZKTWR5TEh0cHpXTmdnS25WaGpyR2pzK3Y0?=
 =?utf-8?B?TXMydjlseDVCbk9sejNBVmFEN1lCK3pobnBaeFJTNGdHQWp5L2hFSUNLUnhj?=
 =?utf-8?B?a2JobFNpeTZlOWI1TE45ZmQrUzhCQnc2RE82K1VxbktFdmp6bWltUWdiNlN0?=
 =?utf-8?B?QzI1SWd6cEpUNHQ0K3BJQXB1eEs3K2twcmNnTkZ1SmhEM1JwQnNQblJ4Mmkv?=
 =?utf-8?B?Q1lBVFJ0dHZyekcvb2g1ak8vTjNLemdkbCtQeHhjblNYS3VFeS84WFU1ejVZ?=
 =?utf-8?B?TFNSaU9MN0daS1pPZlpYN1lNZ3kydmE1MHVJT1ZXS1pSQmc1SS9wRS9ha3BH?=
 =?utf-8?B?cElFU3hjY3ZyWmRRREowWVlIUmU5Rk9sRHhLbmJrNVRrMmJBZitadmZXZkZM?=
 =?utf-8?B?Zzc0L3BNZjFxUGZSdStZWmVIemd3U0grUVRmRmdCczdBYWpqdXVkb3ZlQ0pT?=
 =?utf-8?B?TzBHR1UzdGh2ZDNDa2V6U2dRQzNwOE1zVEVKL0hZNFk1MUJwU2JXWXF3RTNp?=
 =?utf-8?B?clgzVWZyS01FQkhvakZ0dnRubnRnRXk5c2hCWk16Rjd6VExiTHZjKzN5c1p3?=
 =?utf-8?B?RVhmZVpGRUt6S05GR0xORHBXTU8rQWllaWFIREtMWk9JMUgvZU1JMTRBQkdP?=
 =?utf-8?B?MHpUTzdjN0VyUUQ5Q1VSK3VoWXZFTGo4RFFBL3NaR3FSKzkvbDhyTlF2dlpX?=
 =?utf-8?B?RHdCQnlEMXJGZi8xSWdxRmNFdzg2bmRqaHo0SGFOdFlxdUpkZHpUclUrOG41?=
 =?utf-8?B?cUs5NEtpa0pVUFRwT3JBYktZalZNWS9FS1RuUzF3bm9Xc09JOXMzaWFSQWhh?=
 =?utf-8?B?OHpxQmloZW9ObXRON2VTT3hzMjlXZksyNGk4Y09hbytkaGgrNVB3MEtEcitO?=
 =?utf-8?B?eEFESkhmbGVVOXhVbWZ5dk93b1JtTVlXWGNFU0x4UXYzMGlXRFdzM0d0dVcy?=
 =?utf-8?B?b1VVNWllUmhHUzhuQVVGVDQyQXVlczFJM1RIOFAwZmJUa3RjdnVCTXJVMFRk?=
 =?utf-8?B?M25hbTNJZ2luL2YwUXB1a0JRdFd1WEpCdmUzRVZkNW5nUnd0S2VjdS9zOFFI?=
 =?utf-8?B?QTBoM05kZjFvL0o1UWs2a3F3U21VYXZMdHp0dFk4TnhJc01vMnhEa1kwU2Zy?=
 =?utf-8?B?SGovbzRaRTlIeExJME9tTTcyT0hpTmtrL3BNeDduWEQ3S0xHQXFtVXVmNTkx?=
 =?utf-8?B?TVJpVWdNdEFrN0Z1SU1UL2hnN0RhbVg1d3dRR2RBdm1CVEd4aHVWU0tvMlA4?=
 =?utf-8?B?aVdGUG1BTVpVbVJxL1haQmI5WERLamZmRXRpK2VETlNNTlEySHpsQlhpdGRB?=
 =?utf-8?Q?JL9xF3c1tAOP5fNCiLSzdNmVw639FAFRNMwvIo0vXYE5r?=
X-MS-Exchange-AntiSpam-MessageData-1: iis3h7FUHGJ35g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8876f5b-f171-41bc-9742-08df4b9633f7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 08:21:00.0597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OAqGS8WJVYfZM1sLNK8ZmNGrVwY9XMEWl4B1IHGmC/x4w/FPiM5Y6q71QFD0CJmdv+DsJy+DYD13e4kQMzUTmw==
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

After decoupling the source storage of each segment to upload to a
falcon, `FalconDmaLoadTarget` is no longer DMA specific, so rename it.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/falcon.rs                  | 11 ++++----
 drivers/gpu/nova-core/firmware.rs                | 32 ++++++++++++------------
 drivers/gpu/nova-core/firmware/booter.rs         | 16 ++++++------
 drivers/gpu/nova-core/firmware/gen_bootloader.rs |  8 +++---
 4 files changed, 33 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index 337d13359fa5..b1ba94fd2bcd 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -181,10 +181,9 @@ pub(crate) trait FalconEngine: Send + Sync + Sized {
     fn pfalcon2(io: Bar0<'_>) -> Mmio<'_, PFalcon2Registers>;
 }
 
-/// Represents a portion of the firmware to be loaded into a particular memory (e.g. IMEM or DMEM)
-/// using DMA.
+/// Represents a portion of the firmware to be loaded into a particular memory (e.g. IMEM or DMEM).
 #[derive(Debug, Clone)]
-pub(crate) struct FalconDmaLoadTarget {
+pub(crate) struct FalconLoadTarget {
     /// Offset from the start of the source object to copy from.
     pub(crate) src_start: u32,
     /// Offset from the start of the destination memory to copy into.
@@ -193,7 +192,7 @@ pub(crate) struct FalconDmaLoadTarget {
     pub(crate) len: u32,
 }
 
-impl FalconDmaLoadTarget {
+impl FalconLoadTarget {
     /// Returns the data that should be copied to the falcon from `blob`.
     fn data<'a>(&self, blob: &'a [u8]) -> Result<&'a [u8]> {
         let start = usize::from_safe_cast(self.src_start);
@@ -242,7 +241,7 @@ pub(crate) struct FalconImemSegment<'a> {
 
 impl<'a> FalconImemSegment<'a> {
     /// Returns the code of `blob` that `target` describes, to be tagged with `va`.
-    pub(crate) fn from_blob(blob: &'a [u8], target: &FalconDmaLoadTarget, va: u32) -> Result<Self> {
+    pub(crate) fn from_blob(blob: &'a [u8], target: &FalconLoadTarget, va: u32) -> Result<Self> {
         Ok(Self {
             source: FalconSegmentSource::Sysmem(target.data(blob)?),
             dst_start: target.dst_start,
@@ -264,7 +263,7 @@ pub(crate) struct FalconDmemSegment<'a> {
 
 impl<'a> FalconDmemSegment<'a> {
     /// Returns the data of `blob` that `target` describes (untagged).
-    pub(crate) fn from_blob(blob: &'a [u8], target: &FalconDmaLoadTarget) -> Result<Self> {
+    pub(crate) fn from_blob(blob: &'a [u8], target: &FalconLoadTarget) -> Result<Self> {
         Ok(Self {
             source: FalconSegmentSource::Sysmem(target.data(blob)?),
             dst_start: target.dst_start,
diff --git a/drivers/gpu/nova-core/firmware.rs b/drivers/gpu/nova-core/firmware.rs
index 358c9b8db0b8..b72bc54925fa 100644
--- a/drivers/gpu/nova-core/firmware.rs
+++ b/drivers/gpu/nova-core/firmware.rs
@@ -14,8 +14,8 @@
 
 use crate::{
     falcon::{
-        FalconDmaLoadTarget,
-        FalconFirmware, //
+        FalconFirmware,
+        FalconLoadTarget, //
     },
     gpu,
     gsp::boot_firmware_files,
@@ -149,9 +149,9 @@ fn size(&self) -> usize {
         ((hdr & HDR_SIZE_MASK) >> HDR_SIZE_SHIFT).into_safe_cast()
     }
 
-    fn imem_sec_load_params(&self) -> FalconDmaLoadTarget;
-    fn imem_ns_load_params(&self) -> Option<FalconDmaLoadTarget>;
-    fn dmem_load_params(&self) -> FalconDmaLoadTarget;
+    fn imem_sec_load_params(&self) -> FalconLoadTarget;
+    fn imem_ns_load_params(&self) -> Option<FalconLoadTarget>;
+    fn dmem_load_params(&self) -> FalconLoadTarget;
 }
 
 impl FalconUCodeDescriptor for FalconUCodeDescV2 {
@@ -183,20 +183,20 @@ fn signature_versions(&self) -> u16 {
         0
     }
 
-    fn imem_sec_load_params(&self) -> FalconDmaLoadTarget {
+    fn imem_sec_load_params(&self) -> FalconLoadTarget {
         // `imem_sec_base` is the *virtual* start address of the secure IMEM segment, so subtract
         // `imem_virt_base` to get its physical offset.
         let imem_sec_start = self.imem_sec_base.saturating_sub(self.imem_virt_base);
 
-        FalconDmaLoadTarget {
+        FalconLoadTarget {
             src_start: imem_sec_start,
             dst_start: self.imem_phys_base.saturating_add(imem_sec_start),
             len: self.imem_sec_size,
         }
     }
 
-    fn imem_ns_load_params(&self) -> Option<FalconDmaLoadTarget> {
-        Some(FalconDmaLoadTarget {
+    fn imem_ns_load_params(&self) -> Option<FalconLoadTarget> {
+        Some(FalconLoadTarget {
             // Non-secure code always starts at offset 0.
             src_start: 0,
             dst_start: self.imem_phys_base,
@@ -206,8 +206,8 @@ fn imem_ns_load_params(&self) -> Option<FalconDmaLoadTarget> {
         })
     }
 
-    fn dmem_load_params(&self) -> FalconDmaLoadTarget {
-        FalconDmaLoadTarget {
+    fn dmem_load_params(&self) -> FalconLoadTarget {
+        FalconLoadTarget {
             src_start: self.dmem_offset,
             dst_start: self.dmem_phys_base,
             len: self.dmem_load_size,
@@ -244,8 +244,8 @@ fn signature_versions(&self) -> u16 {
         self.signature_versions
     }
 
-    fn imem_sec_load_params(&self) -> FalconDmaLoadTarget {
-        FalconDmaLoadTarget {
+    fn imem_sec_load_params(&self) -> FalconLoadTarget {
+        FalconLoadTarget {
             // IMEM segment always starts at offset 0.
             src_start: 0,
             dst_start: self.imem_phys_base,
@@ -253,13 +253,13 @@ fn imem_sec_load_params(&self) -> FalconDmaLoadTarget {
         }
     }
 
-    fn imem_ns_load_params(&self) -> Option<FalconDmaLoadTarget> {
+    fn imem_ns_load_params(&self) -> Option<FalconLoadTarget> {
         // Not used on V3 platforms
         None
     }
 
-    fn dmem_load_params(&self) -> FalconDmaLoadTarget {
-        FalconDmaLoadTarget {
+    fn dmem_load_params(&self) -> FalconLoadTarget {
+        FalconLoadTarget {
             // DMEM segment starts right after the IMEM one.
             src_start: self.imem_load_size,
             dst_start: self.dmem_phys_base,
diff --git a/drivers/gpu/nova-core/firmware/booter.rs b/drivers/gpu/nova-core/firmware/booter.rs
index 0e7a839c644b..9c02a7a6a977 100644
--- a/drivers/gpu/nova-core/firmware/booter.rs
+++ b/drivers/gpu/nova-core/firmware/booter.rs
@@ -18,11 +18,11 @@
         sec2::Sec2,
         Falcon,
         FalconBromParams,
-        FalconDmaLoadTarget,
         FalconDmemSegment,
         FalconFirmware,
         FalconImage,
-        FalconImemSegment, //
+        FalconImemSegment,
+        FalconLoadTarget, //
     },
     firmware::{
         tlv::{
@@ -53,12 +53,12 @@ impl<'a> FirmwareSignature<BooterFirmware> for BooterSignature<'a> {}
 /// The `Booter` loader firmware, responsible for loading the GSP.
 pub(crate) struct BooterFirmware {
     // Load parameters for Secure `IMEM` falcon memory.
-    imem_sec_load_target: FalconDmaLoadTarget,
+    imem_sec_load_target: FalconLoadTarget,
     // Load parameters for Non-Secure `IMEM` falcon memory,
     // used only on Turing and GA100
-    imem_ns_load_target: Option<FalconDmaLoadTarget>,
+    imem_ns_load_target: Option<FalconLoadTarget>,
     // Load parameters for `DMEM` falcon memory.
-    dmem_load_target: FalconDmaLoadTarget,
+    dmem_load_target: FalconLoadTarget,
     // BROM falcon parameters.
     brom_params: FalconBromParams,
     // Device-mapped firmware image.
@@ -153,7 +153,7 @@ pub(crate) fn new(
         let (imem_sec_dst_start, imem_ns_load_target) = if chipset <= Chipset::GA100 {
             (
                 app0_code_offset,
-                Some(FalconDmaLoadTarget {
+                Some(FalconLoadTarget {
                     src_start: 0,
                     dst_start: os_code_offset,
                     len: os_code_size,
@@ -164,13 +164,13 @@ pub(crate) fn new(
         };
 
         Ok(Self {
-            imem_sec_load_target: FalconDmaLoadTarget {
+            imem_sec_load_target: FalconLoadTarget {
                 src_start: app0_code_offset,
                 dst_start: imem_sec_dst_start,
                 len: app0_code_size,
             },
             imem_ns_load_target,
-            dmem_load_target: FalconDmaLoadTarget {
+            dmem_load_target: FalconLoadTarget {
                 src_start: os_data_offset,
                 dst_start: 0,
                 len: os_data_size,
diff --git a/drivers/gpu/nova-core/firmware/gen_bootloader.rs b/drivers/gpu/nova-core/firmware/gen_bootloader.rs
index b5c8621574b1..f2dd88d27098 100644
--- a/drivers/gpu/nova-core/firmware/gen_bootloader.rs
+++ b/drivers/gpu/nova-core/firmware/gen_bootloader.rs
@@ -22,13 +22,13 @@
         gsp::Gsp,
         Falcon,
         FalconBromParams,
-        FalconDmaLoadTarget,
         FalconDmemSegment,
         FalconFbifMemType,
         FalconFbifTarget,
         FalconFirmware,
         FalconImage,
         FalconImemSegment,
+        FalconLoadTarget,
         FalconSegmentSource, //
     },
     firmware::tlv::{
@@ -97,9 +97,9 @@ impl BootloaderDmemDescV2 {
     /// layout, because the bootloader uses the destination offset of each code segment as its
     /// source offset too.
     pub(crate) fn new(
-        imem_ns: &FalconDmaLoadTarget,
-        imem_sec: &FalconDmaLoadTarget,
-        dmem: &FalconDmaLoadTarget,
+        imem_ns: &FalconLoadTarget,
+        imem_sec: &FalconLoadTarget,
+        dmem: &FalconLoadTarget,
         code_dma_base: u64,
         data_dma_base: u64,
     ) -> Self {

-- 
2.56.1

