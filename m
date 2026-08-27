Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E1CC61DC7
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 07:31:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EFE510EEAA;
	Thu, 27 Aug 2026 07:31:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="JR+uDlns";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010042.outbound.protection.outlook.com [52.101.85.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26B8D10EEC7
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 07:30:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v4q4iXe4c98LpPvtc2SXA6VcUS0o4iQZve9RX8efqlCHLF79rg7Lc9e3v6BaKR1I6zLttZbinjqsCU7VI/+dGighgmqdDQJfG5bZxWjFzmWfurm+solcq14HujT4/Ilamzgf2f8KAxNjGTHAWXTax0btRQa0T7i3XkIBPfSQRqc4T3lhZ1K1f5I5D3IAX2Y5qYAnjraDZML4zzPbzzvfnOgjEozsgFJtq8tDhPHyiPeRcmGZuYCJa/KfDCbp/2w9F4uanYjkfy9Lkax/w7I6Ybmy2LmXb3pDF8h/UITKNDXWl9bdQRZzieHrzkTj9vu94sL1lv2nPKIFg5L8aCulPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhhcR2mlH9YG2shfAb0nUFZ8L6GCPadUUXs7RmKRvIU=;
 b=xww+9yfsl/Eu866KKUcG1jHYN9LI6MmCwA3AN/wju6ZZziwQjXAmPFHCyZJWxpi62ZcXCdLbWJn3tPUOWkX/9sn3drxkR5y958IBQLwA6TET4mPdLCVwJxbzGZGB3b+4drGLjEyY00Hzb1kTmhEQkcj/WOlGCZXfV2j6pSWVelqyOJeUg4EG/A7sIbl0RGgBoXZ7LaPArs8Mm/zVQ6H2rPPoJVV25qUejGBFVSofVtDfDsgwsEQwNlCoyNabkJlBBh40yKI6vcZFcqTEDhjZLc3pI+ErCjBotQvBvc2f0OhkSiLNYqWvuEsEeS6TrE5SrvG6EUXP5uwy7ST0s9T6mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhhcR2mlH9YG2shfAb0nUFZ8L6GCPadUUXs7RmKRvIU=;
 b=JR+uDlnsDvpnhUGP/NFrFMTKVTKtdIghrUj2fE5mbhJpAUSaQy5ciH4X9XZ5MzKBz5gVtOByV1MhO1c6aGNItcPd0ft54ms2SUAmvwqPRrRFbh/UxmAxtFOuHn+UJ1z7nYi1CExlmObi9pHgUH38OsDutq1h4ae+Vc6z5JT9+bTRnTfKCNdsSaUudwf0bTkKhxFjxESEIvukPIC8mfweZ39F8VUktk5w0JvSPTtoScVX4nXz9GF54fhimIJ/t0xx+G9tLq1EysxcpoQzoAg6D/KvCNcdinRRumk/igTtSUbd2N+488ybgT4Z8ui/dUhRejOEdL+Wh2zvhJZp9XwPIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 DS0PR12MB999081.namprd12.prod.outlook.com (2603:10b6:8:2ff::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 07:30:48 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 07:30:48 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 27 Aug 2026 16:28:36 +0900
Subject: [PATCH v8 08/12] rust: use Alignment size constants
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-chid-v8-8-bc74c77d0214@nvidia.com>
References: <20260827-chid-v8-0-bc74c77d0214@nvidia.com>
In-Reply-To: <20260827-chid-v8-0-bc74c77d0214@nvidia.com>
To: Alice Ryhl <aliceryhl@google.com>, Burak Emir <burak.emir@gmail.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY6PR01CA0042.jpnprd01.prod.outlook.com
 (2603:1096:405:3bd::19) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|DS0PR12MB999081:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cb8a1bd-2b8c-4149-ed72-08df040d1d85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|7416014|366016|1800799024|376014|56012099006|6133799003|10067099003|18002099003|22082099003|11063799006|921020;
X-Microsoft-Antispam-Message-Info: D02tgF+W4aFEFm94reCL9VXZkzISPqvD1niXwg7/EPQpyCvxbfwHKdDPMNPhI45+zbJYFPDb2fzsQsUtUw49e62d6QOGmO3nR2X0g0E90WmU2Ni+pDDxmc+w4xnWbeZonC7muwUQmOkaK8sSA9ZjWbaSpC2tUxQGfZ5vnIFh+s0nmk+eyCmW0Q9+LzXDBuu/IdNU+IISdk8PiiB9GmNwcIvBq3cKrgMK2Psd66WQxqwHqfi5AYGxAqFwbKkszlww5/aPHMb43G5iA9QDU4BtlluSWczZ/9q4tyhRAxm+yhlQ3Iv29B/w8XSbgLBe9BlBRSIjop7UFNhdMOnCuBjegBYpNnjPuLCY36gL8aQDp3CHk/HmAoh81RygcogIZ/KSH1T+Bw45gkXStf/4MGeu8Qrikq0ySfliQiGLj5EZ/9Bj4ianecR869bmAGzf9mcuMZF2eo1NZq0e6kFE0egAjNrozVmEmXxpsU46fuvWU77i4YcamgEDeCXLE3gBh9uqt5hmo6seAEbWhGUITotXS2s3lDom1OgKCCINIhmLHrBd4V7V3E1WvQ9OTwDJXw1F9GpEHlEqqtVvlCtmudjZZdqjdCaBVE/hJZdAww7gGXXZhf4T/v2mlbKxpvTSNWRqdRZTFF+8GJ0cUosIBFOU20G1JJPDd9k1eFFdZLQAEGK4b0RjvGUqnmU2NYfrYWzRP5mVUkWZDibfz22QeCuFqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(7416014)(366016)(1800799024)(376014)(56012099006)(6133799003)(10067099003)(18002099003)(22082099003)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEVIMFlYaVg1N1FGVFhJT2w3OHIzSWhyTzB1cUkydXU4N2YrV3NLUCtLVzZz?=
 =?utf-8?B?NDR6SUZlNmE0YmwrekNPTkhLc2gydXMvaDBvNjV0VnRQbjNLdUx2K2ZOaklw?=
 =?utf-8?B?dDdNSHJHQm9EaWp5bXJBc0Q0bnI3V0Z3RmpQaHVTUVFTVWFuQUx0TVVBZHM3?=
 =?utf-8?B?b0F5RDdjalZvVGtOWjM4Y1RUUGVuU2MyODhoQTJEWXIwL3lMdDdHWmh0UGRB?=
 =?utf-8?B?NVp2TzlnTE5XdFFzY3VPL3EwZmR5SHBKMkV2K1A4N05rTjdXZi9WK0NERHUv?=
 =?utf-8?B?QzFDbkZFVkwyV2EzVkE0M0tyRjZPUWRGZGI1UnQ0YXZVdlVsTGV6Wm9veVJR?=
 =?utf-8?B?eHM5NXdOR3grNjhDTXkxWUlpaGUrODBvV3JEeTJHVGxuRUoxbGlhbTlVeHJB?=
 =?utf-8?B?cVRVeXlGS0Y0eTRISGh6TzVMemxLZXZLVnZwSU1XT1l6WEsvTTUxWXFPQVVE?=
 =?utf-8?B?ak1qdlA2VENCdW51OFI1dlVkdGxDSlh3UGdXUk1oVTcxaFVHOTVodzlxdXpU?=
 =?utf-8?B?WUoxQUwwOERNQTdQdnpPLzIzUXE4NHc2VExZcXlta2IyY0ltVTVuNTljU2hC?=
 =?utf-8?B?ZG9LbG1XQ3c5N3hmVWkrZUtLUEowVy9GR1Y5QjJqUmgzSzZkdXZxUEc1Wk1J?=
 =?utf-8?B?MUxaeklIMmZuUWx5ZUY3L1MyMWF1bjlVbzdBZ1RySkh2YzNDa2I4aitPTnl3?=
 =?utf-8?B?U0dnaHVkUnFSMkM1Q3V6QnUvb3lsdDIvY1pISWliSWhkOWErSnpydzcwU21o?=
 =?utf-8?B?R3ZHNHpnemJrOGFqMVZlUERTbGI1Szd5K1p6ZElVaEhhSEpXaUo5eVdWWGFi?=
 =?utf-8?B?bHhLd2ZSRjBOK3RLU0RYRzU5OTR6c3RyZ2ZpV3ZoWWNFT0pQUUdXdWxoR1Vm?=
 =?utf-8?B?a3JtNlpKR0w3eGZ4dHRwZWNVdGV0WitMZFVQUHNMWlhPaXB0WXFxanRLK0dG?=
 =?utf-8?B?MUhGbmJmVVdiZ25SRUFFdmZYMlcrT0swYmNLYnF5VzNiSDAwTXlnRFpYVXRS?=
 =?utf-8?B?WUVEN3NRaytLaVMvRVlUalA5MnRlcEVFNlprUHlJQ0JaSGx5cWNSajJuUDZP?=
 =?utf-8?B?OVk2UE9VT0tIZEFmTnF3WnZLMi83eVY4Witkc0U5TzZZNU8vM2NBWTNNaWpj?=
 =?utf-8?B?dTRoZVMxeWs5SVFmcWoyZVNKaGx4RE5yVkVRa0Nwb1lESElsTUs5VUFYR0sy?=
 =?utf-8?B?Qm81NjYwenlXandZWHZWRTk3SWx6ZEhheGF2TWJwQ21CcG9xSkYxVnJjK0hB?=
 =?utf-8?B?L2ZnWG4wWEhqUXZhT1dkOEsyQnprS1N5aVh6WXFzMmlIMVZwTzhRSFp2dTBC?=
 =?utf-8?B?MXkxdS8wUFhmdHN2M1VqRXVadVBxdzdTdVQvTDhLYTRwZ1ZROFRFV1pXWnZH?=
 =?utf-8?B?cW9ZeHdrM2phRzdVQ29XMWtSM1hVQjF5TFV2THVSdHZJempkbGVCTThpWFZC?=
 =?utf-8?B?emZlTWk2cWlmWFd6NXVhRlU1YldOd3o0ajZheTNTWGFENnd2RUVxdlNPbDZU?=
 =?utf-8?B?Uk9NcG5tZmFvNXhCakxUcFhWcDdQM1hBUGY1S253Q2lLcStqZUhFMlpLWElN?=
 =?utf-8?B?R0hLYU04MGxReWdncWJ0MzB6VlFyUzFEL1BNendsRm9tWEJuQzlkenpmYmxm?=
 =?utf-8?B?RzEveXBXSzg1QlZxdkwvZVI3V2RHQlMzcUIvOWNRd09pM1NOVmtIMHM4K3Ew?=
 =?utf-8?B?UFEvakYyQ0RHdmtxbVl6SE9YUWpNanl0Z2N6Vnppa0lKMTdaQm14ZlNzeExQ?=
 =?utf-8?B?K2ljSXZCOVgycVVnU21ETXl5NnBWazBFU1dKR2NxT1hwQUhtNmZFcjZaT3FD?=
 =?utf-8?B?VGVrUmw2UVBxb2FYTnp0SkY0QnpPZVliZ1hhSUZaUmxuN0doWkZCcGZORXRZ?=
 =?utf-8?B?QURqWXdneHlSNENjM2NRcExrS21XZ2xFTnI3Q1lKQmFMUnplNTNjdDlrZkV4?=
 =?utf-8?B?VlVrK0R5WDN3V3RaTzlsWUNkTU9oMVo2bXJkTW53ckh2dGEvb0duV3I4MWcx?=
 =?utf-8?B?MkkxVkpXVHdwZjdnTFZrQTVobFE5N3d1WmNwUlhxcGNOSERmT0RiVWk2QzRI?=
 =?utf-8?B?SXFMa1NoU1A3SnQwa1Y1OS9lMWlCdnIvK1dpZE92MHVmOVg2VnZDQW0yNnQr?=
 =?utf-8?B?VFFKY0lpVXRGdzdHSTZyNitObzJ3NGY3aE8xSzVCcjVOQ2FxSlNDdFlJcnRj?=
 =?utf-8?B?NkZHZ0ErcDhVUldpeXdPT3N2NEhDVFo2WkhuZ3dkMnBYeHlvTW1rRWt6YzB0?=
 =?utf-8?B?UEZmdXVxMm1hN3Q5S2w3ajF3ZGR4b2txWEdQSUNyZ3lzMUZ4bFNCMHM0Kytp?=
 =?utf-8?B?anorMFRscm5LTFQ1aUJVMVVBdm84MytrV3BuakF0RHdCaURROTZZRGlSSVNM?=
 =?utf-8?Q?onra/tWSFQUbGU6P0mIWeVCdT9AT+icXvpaZKxP68zLW5?=
X-MS-Exchange-AntiSpam-MessageData-1: gKYepe+TzUI83g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb8a1bd-2b8c-4149-ed72-08df040d1d85
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 07:30:48.7703 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+BGXs0ssrDXT/lygPzruYM4OhaydGyDRZVVBvN1dnDO0JaGGLI14KI1nK88OIOrVFec7My+KaANJ/OSAT79zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999081
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

Use `SizeConstants` for Alignment that are implemented now.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/fb.rs           | 10 +++++-----
 drivers/gpu/nova-core/fb/hal/gb100.rs |  3 +--
 drivers/gpu/nova-core/fsp.rs          |  4 ++--
 drivers/gpu/nova-core/gsp/fw.rs       | 12 +++---------
 drivers/gpu/nova-core/vbios.rs        |  7 +++++--
 rust/kernel/gpu/buddy.rs              | 26 +++++++++++++-------------
 rust/kernel/io.rs                     |  5 +++--
 7 files changed, 32 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index 1576399389b1..70493c4a07b7 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -219,7 +219,7 @@ pub(crate) fn new(
         };
 
         let frts = {
-            const FRTS_DOWN_ALIGN: Alignment = Alignment::new::<SZ_128K>();
+            const FRTS_DOWN_ALIGN: Alignment = Alignment::SZ_128K;
             let frts_size: u64 = hal.frts_size();
             let frts_base = vga_workspace.start.align_down(FRTS_DOWN_ALIGN) - frts_size;
 
@@ -227,7 +227,7 @@ pub(crate) fn new(
         };
 
         let boot = {
-            const BOOTLOADER_DOWN_ALIGN: Alignment = Alignment::new::<SZ_4K>();
+            const BOOTLOADER_DOWN_ALIGN: Alignment = Alignment::SZ_4K;
             let bootloader_size = u64::from_safe_cast(gsp_fw.bootloader.ucode.size());
             let bootloader_base = (frts.start - bootloader_size).align_down(BOOTLOADER_DOWN_ALIGN);
 
@@ -235,7 +235,7 @@ pub(crate) fn new(
         };
 
         let elf = {
-            const ELF_DOWN_ALIGN: Alignment = Alignment::new::<SZ_64K>();
+            const ELF_DOWN_ALIGN: Alignment = Alignment::SZ_64K;
             let elf_size = u64::from_safe_cast(gsp_fw.size);
             let elf_addr = (boot.start - elf_size).align_down(ELF_DOWN_ALIGN);
 
@@ -245,7 +245,7 @@ pub(crate) fn new(
         let (vf_partition_count, wpr2_heap_size) = wpr2_heap_params(chipset, vgpu_state, fb.end)?;
 
         let wpr2_heap = {
-            const WPR2_HEAP_DOWN_ALIGN: Alignment = Alignment::new::<SZ_1M>();
+            const WPR2_HEAP_DOWN_ALIGN: Alignment = Alignment::SZ_1M;
             let wpr2_heap_addr = elf
                 .start
                 .checked_sub(wpr2_heap_size)
@@ -256,7 +256,7 @@ pub(crate) fn new(
         };
 
         let wpr2 = {
-            const WPR2_DOWN_ALIGN: Alignment = Alignment::new::<SZ_1M>();
+            const WPR2_DOWN_ALIGN: Alignment = Alignment::SZ_1M;
             let wpr2_addr = (wpr2_heap.start - u64::from_safe_cast(size_of::<gsp::GspFwWprMeta>()))
                 .align_down(WPR2_DOWN_ALIGN);
 
diff --git a/drivers/gpu/nova-core/fb/hal/gb100.rs b/drivers/gpu/nova-core/fb/hal/gb100.rs
index d9e4d62ae632..b37f11c9a891 100644
--- a/drivers/gpu/nova-core/fb/hal/gb100.rs
+++ b/drivers/gpu/nova-core/fb/hal/gb100.rs
@@ -82,8 +82,7 @@ fn write_sysmem_flush_page_gb100(bar: Bar0<'_>, addr: Bounded<u64, 52>) {
 
 // This PMU reservation size is r570-specific.
 pub(super) const fn pmu_reserved_size_gb100() -> u32 {
-    usize_into_u32::<{ const_align_up(SZ_8M + SZ_16M + SZ_4K, Alignment::new::<SZ_128K>()).unwrap() }>(
-    )
+    usize_into_u32::<{ const_align_up(SZ_8M + SZ_16M + SZ_4K, Alignment::SZ_128K).unwrap() }>()
 }
 
 impl FbHal for Gb100 {
diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
index ab685fb4168f..6bac5206a836 100644
--- a/drivers/gpu/nova-core/fsp.rs
+++ b/drivers/gpu/nova-core/fsp.rs
@@ -17,7 +17,7 @@
         Alignable,
         Alignment, //
     },
-    sizes::SZ_2M,
+    sizes::SizeConstants,
     time::Delta,
     transmute::{
         AsBytes,
@@ -257,7 +257,7 @@ fn frts_vidmem_offset(hal: &dyn hal::FspHal, fb_info: &FbSizes) -> Result<u64> {
         if fb_info.pmu_reserved_size != 0 {
             offset = (offset + u64::from(fb_info.pmu_reserved_size))
                 // The 2 MiB alignment is r570-specific.
-                .align_up(Alignment::new::<SZ_2M>())
+                .align_up(Alignment::SZ_2M)
                 .ok_or(EINVAL)?;
         }
 
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 05f54fee6186..6b92e0e0a2a9 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -25,10 +25,7 @@
         Alignment,
         KnownSize, //
     },
-    sizes::{
-        SizeConstants,
-        SZ_128K, //
-    },
+    sizes::SizeConstants,
     transmute::{
         AsBytes,
         FromBytes, //
@@ -63,7 +60,7 @@
 enum GspFwHeapParams {}
 
 /// Minimum required alignment for the GSP heap.
-const GSP_HEAP_ALIGNMENT: Alignment = Alignment::new::<{ 1 << 20 }>();
+const GSP_HEAP_ALIGNMENT: Alignment = Alignment::SZ_1M;
 
 impl GspFwHeapParams {
     /// Returns the amount of GSP-RM heap memory used during GSP-RM boot and initialization (up to
@@ -209,10 +206,7 @@ pub(crate) fn from_ranges<'a>(
             bootBinOffset: ranges.boot.start,
             frtsOffset: ranges.frts.start,
             frtsSize: ranges.frts.len(),
-            gspFwWprEnd: ranges
-                .vga_workspace
-                .start
-                .align_down(Alignment::new::<SZ_128K>()),
+            gspFwWprEnd: ranges.vga_workspace.start.align_down(Alignment::SZ_128K),
             gspFwHeapVfPartitionCount: ranges.vf_partition_count,
             fbSize: ranges.fb.len(),
             vgaWorkspaceOffset: ranges.vga_workspace.start,
diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index c03650ee5226..de46e3399ff8 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -11,7 +11,10 @@
         Alignment, //
     },
     register,
-    sizes::SZ_4K,
+    sizes::{
+        SizeConstants,
+        SZ_4K, //
+    },
     sync::aref::ARef,
 };
 
@@ -282,7 +285,7 @@ fn next(&mut self) -> Option<Self::Item> {
 
         // Advance to next image (aligned to 512 bytes).
         self.current_offset += image_size;
-        self.current_offset = self.current_offset.align_up(Alignment::new::<512>())?;
+        self.current_offset = self.current_offset.align_up(Alignment::SZ_512)?;
 
         Some(Ok(full_image))
     }
diff --git a/rust/kernel/gpu/buddy.rs b/rust/kernel/gpu/buddy.rs
index d502ada6ebbd..691bb40629d4 100644
--- a/rust/kernel/gpu/buddy.rs
+++ b/rust/kernel/gpu/buddy.rs
@@ -31,11 +31,11 @@
 //! let buddy = GpuBuddy::new(GpuBuddyParams {
 //!     base_offset: 0,
 //!     size: SZ_1G as u64,
-//!     chunk_size: Alignment::new::<SZ_4K>(),
+//!     chunk_size: Alignment::SZ_4K,
 //! })?;
 //!
 //! assert_eq!(buddy.size(), SZ_1G as u64);
-//! assert_eq!(buddy.chunk_size(), Alignment::new::<SZ_4K>());
+//! assert_eq!(buddy.chunk_size(), Alignment::SZ_4K);
 //! let initial_free = buddy.avail();
 //!
 //! // Allocate 16MB. Block lands at the top of the address range.
@@ -43,7 +43,7 @@
 //!     buddy.alloc_blocks(
 //!         GpuBuddyAllocMode::Simple,
 //!         SZ_16M as u64,
-//!         Alignment::new::<SZ_16M>(),
+//!         Alignment::SZ_16M,
 //!         GpuBuddyAllocFlags::default(),
 //!     ),
 //!     GFP_KERNEL,
@@ -74,14 +74,14 @@
 //! # let buddy = GpuBuddy::new(GpuBuddyParams {
 //! #     base_offset: 0,
 //! #     size: SZ_1G as u64,
-//! #     chunk_size: Alignment::new::<SZ_4K>(),
+//! #     chunk_size: Alignment::SZ_4K,
 //! # })?;
 //! # let initial_free = buddy.avail();
 //! let topdown = KBox::pin_init(
 //!     buddy.alloc_blocks(
 //!         GpuBuddyAllocMode::TopDown,
 //!         SZ_16M as u64,
-//!         Alignment::new::<SZ_16M>(),
+//!         Alignment::SZ_16M,
 //!         GpuBuddyAllocFlags::default(),
 //!     ),
 //!     GFP_KERNEL,
@@ -114,7 +114,7 @@
 //! # let buddy = GpuBuddy::new(GpuBuddyParams {
 //! #     base_offset: 0,
 //! #     size: SZ_1G as u64,
-//! #     chunk_size: Alignment::new::<SZ_4K>(),
+//! #     chunk_size: Alignment::SZ_4K,
 //! # })?;
 //! # let initial_free = buddy.avail();
 //! // Create fragmentation by allocating 4MB blocks at [0,4M) and [8M,12M).
@@ -122,7 +122,7 @@
 //!     buddy.alloc_blocks(
 //!         GpuBuddyAllocMode::Range(0..SZ_4M as u64),
 //!         SZ_4M as u64,
-//!         Alignment::new::<SZ_4M>(),
+//!         Alignment::SZ_4M,
 //!         GpuBuddyAllocFlags::default(),
 //!     ),
 //!     GFP_KERNEL,
@@ -133,7 +133,7 @@
 //!     buddy.alloc_blocks(
 //!         GpuBuddyAllocMode::Range(SZ_8M as u64..(SZ_8M + SZ_4M) as u64),
 //!         SZ_4M as u64,
-//!         Alignment::new::<SZ_4M>(),
+//!         Alignment::SZ_4M,
 //!         GpuBuddyAllocFlags::default(),
 //!     ),
 //!     GFP_KERNEL,
@@ -145,7 +145,7 @@
 //!     buddy.alloc_blocks(
 //!         GpuBuddyAllocMode::Range(0..SZ_16M as u64),
 //!         SZ_8M as u64,
-//!         Alignment::new::<SZ_4M>(),
+//!         Alignment::SZ_4M,
 //!         GpuBuddyAllocFlags::default(),
 //!     ),
 //!     GFP_KERNEL,
@@ -178,14 +178,14 @@
 //! let small = GpuBuddy::new(GpuBuddyParams {
 //!     base_offset: 0,
 //!     size: SZ_16M as u64,
-//!     chunk_size: Alignment::new::<SZ_4K>(),
+//!     chunk_size: Alignment::SZ_4K,
 //! })?;
 //!
 //! let _hole1 = KBox::pin_init(
 //!     small.alloc_blocks(
 //!         GpuBuddyAllocMode::Range(0..SZ_4M as u64),
 //!         SZ_4M as u64,
-//!         Alignment::new::<SZ_4M>(),
+//!         Alignment::SZ_4M,
 //!         GpuBuddyAllocFlags::default(),
 //!     ),
 //!     GFP_KERNEL,
@@ -195,7 +195,7 @@
 //!     small.alloc_blocks(
 //!         GpuBuddyAllocMode::Range(SZ_8M as u64..(SZ_8M + SZ_4M) as u64),
 //!         SZ_4M as u64,
-//!         Alignment::new::<SZ_4M>(),
+//!         Alignment::SZ_4M,
 //!         GpuBuddyAllocFlags::default(),
 //!     ),
 //!     GFP_KERNEL,
@@ -206,7 +206,7 @@
 //!     small.alloc_blocks(
 //!         GpuBuddyAllocMode::Simple,
 //!         SZ_8M as u64,
-//!         Alignment::new::<SZ_4M>(),
+//!         Alignment::SZ_4M,
 //!         GpuBuddyAllocFlag::Contiguous,
 //!     ),
 //!     GFP_KERNEL,
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 95f46bb75f9e..10fbb27a1998 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -15,7 +15,8 @@
     ptr::{
         Alignment,
         KnownSize, //
-    }, //
+    },
+    sizes::SizeConstants, //
 };
 
 pub mod mem;
@@ -85,7 +86,7 @@ pub fn ptr_try_from_raw_parts_mut(base: *mut u8, size: usize) -> Result<*mut Sel
 impl<const SIZE: usize> KnownSize for Region<SIZE> {
     const MIN_SIZE: usize = SIZE;
     // Alignment of 4 is the most common; different base types can be added once required.
-    const MIN_ALIGN: Alignment = Alignment::new::<4>();
+    const MIN_ALIGN: Alignment = Alignment::SZ_4;
 
     #[inline(always)]
     fn size(p: *const Self) -> usize {

-- 
2.55.0

