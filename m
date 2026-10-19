Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7C4CCF2D4
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 04:29:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53AA710E230;
	Mon, 19 Oct 2026 04:29:53 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013011.outbound.protection.outlook.com
 [40.107.201.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D382010E230
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 04:29:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dOSPr55LiTwLj+ZZIzKyPbvdtIYuNuR7g0pAseVoaQSnBk72sUK3Fotad0l3dOn/gbz+YAdtwd+FbhOQQMXpZC1e4IIqN2ZESwAYGQxjG9QRx5qOyzj7jhgxy61pE60Rm0IDRpREAa2VmB5ZQYNv2KXexW6kUdeHiaV5u6XpYRznda1KPM6E1yIqTneytdDfeQfCBiRg1i/9lsXXCj2zQdt9YopO66zbE34Mfgd17yV+Y6R3baP/j4T9ssYxVx/nBWPUYGeWymrsdxDE77L2Y9NTJV+wfgeK5JBprKSJViKR9eXh5laJDBByL9P2KMjR6SD1qP8r3LSSiYntruVI5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HI07yxnpz7bV3Sda+hMLjAa5/YnICbtgrH/n/nU4U78=;
 b=m67AUMTasSiJ5+0Bdd6xVH6tJxwgROqKfJymz3pJFpEuEyCDempXxE2whGYzBSfP5nzGjfq900E/5bvdhGAbsH9v7KkAgP6GUQrfwHOt0wlI9bLFhZ+97h+xATHYUCBcy8vyhulN0NFdWDk2U69fbzBrgbOS89UVLzct1Ljb7Qp09eZtMYiZq4UYLkHpu4AhfugWrI/VGbwmVKDMK5rL/oR4d7kLkYMY6So5/pQuLLeMQoMvJiGYz4N/PghJNBwvsck3JAnV66q8tPvLcNuPI+s0D78YCoBwOsr6OMadatWNupY2rHGdXXhXKISJR5HE6Z5082SJuu/BgMDRW8qbsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HI07yxnpz7bV3Sda+hMLjAa5/YnICbtgrH/n/nU4U78=;
 b=GUhMt3AlVuIcyhVrmlwyzryiGUY2jAZmapfSMDPigbJz4Bl4CV74Ff2TdV2ZBHk5kcoHUOowz1nynx5/TRElw044BCQoYn9FTAxpabixSrqWK3dI0TNdnhH3wUfRBFZ/OYt40c2leQ/GRjhJ8v7h+ysxtNGG11jh9ghbCI7aDznj4CyLqhQJhz7QNKVFUjt6rXEyObgaMTk+5rc1Tm4Riiutp7S0GK2FalWYBWy4JQzOxMrJ/XQ0LYtV5oDTD+sXK2THdGseSV2px3L9Oq3DSRxPHC5nFF10yWbQiyLNNfkE9znX+onTUTYvn9fhW+K1QWhIsuCae9S3V3tPHVO/NA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 04:29:37 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 04:29:37 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 19 Oct 2026 13:29:26 +0900
Subject: [PATCH v10 1/3] rust: use Alignment size constants
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-chid-v10-1-67de9180b4ed@nvidia.com>
References: <20261019-chid-v10-0-67de9180b4ed@nvidia.com>
In-Reply-To: <20261019-chid-v10-0-67de9180b4ed@nvidia.com>
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
X-ClientProxiedBy: TY4P286CA0035.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b2::15) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|PH7PR12MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a37fac7-f908-4eff-983a-08df2d999559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|1800799024|23010399003|366016|6133799003|18002099003|10067099003|22082099003|921020|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: pAoHUeTJ5rn5PrBTuBDvc2FqVi4C2x0JQKs+rEj1ZqMDW35mt3gn1RdpuS22QXm9nkn3oFT50BI5IGNJCu23nj8WD8Q7Z8kmeypV9IF1Qg0hH7Ue5v8N9Q6GPuk/Ehk7L+n3XV98Z0zGSk7QZVs8mzXU+UP+csFrgx8JUTL/2J+mlSAzg26+HkmjcGozc7H/ZUYCVCTG1ROf/YgxNaeNoef1rKipzi7N0ZOGxPIFOwPUuGeQ2pMyLku36wdOfOtMk3Tipc0GA+hXuFdC0qgIq+SONiutTk9Z2rb824FL5/o8Q8VRDC+JDCHLPV4xJRClp2wUBcYUg2z9a8OjYxjIceJk2Xn89285vucsDP4plPJZgttjITxK4SQFEOngVhWefFV2fVMHMqjtWCeMO8zOzvqMG8ua4oLKuOsBMeWXQxHDOj0mvnvniQN5uCNs2p7QyCfB1XeKFtCaXtKIsosUcSHZ+OqAkElc1NYvgNXOKam1hnLu4kz51/pvd2Gd92k/obPLkKCHuWi/5jfOTuGBS+jldymO1XmebkwXFhcl+SY5/Zg7AMkRGzeT22caFMC+hkY8eLdj5lWpcggdRw24mI8JY9dGVW+RfjkSssPR5jooHy6bOn+rIKF9oGqUETrVSlj3KRwoBKTUkk+1TeLFShjyaEShB5W1nvscsg7Obvdx2VHepUiuLa6sBPuncKJ7dEfuQ4Bj7dohxKxrtVLiVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(23010399003)(366016)(6133799003)(18002099003)(10067099003)(22082099003)(921020)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1hzbW4rOC82RE1nNXhoeEVzQVZ3dVlMbTRCY3Vvb0J0SVp4d242TlpMMTda?=
 =?utf-8?B?dkdlUXNwVEhidHFlM2p6Q2FCYWNiM2xIVmE4WXNEbExINjFRaUZSS0Z6cEhK?=
 =?utf-8?B?M3FPSU9ZbkxwK0ZzUXNCeEVVNHgwL3czK3U1NVBuanJtb0U5RmVuMFhCV2Iy?=
 =?utf-8?B?VjlTK3RCR3JZTHdYY0JwWS9oNDErcUttVDhwR3hIdDR5TjFETVJvOVN1b1Ry?=
 =?utf-8?B?UWVGYk9HWUx1dThTdncxMFhwejdBU2lyZFRkZlpNeGU0R2RPZmhSN3BJNUlH?=
 =?utf-8?B?MCtKWitsYW92Z1pPUExBVXhEQ3Z0dWVWSzJKOGpreUdtUEtYZWRpekY3MUl4?=
 =?utf-8?B?dEFHK1VCNXlWSEhwMzFrUnZpZExVYW51OTZhVEpvdTBIRWQ5Wmg1WTdDQjRz?=
 =?utf-8?B?cmdtRE5UbXpNNnU5SHE0YkVCYmtiYURDaTQ0L1k3VURxUHZXZjMzb3ZvL0pC?=
 =?utf-8?B?WlFLUC9KZ3M1Rld1R3hJMnlCWThQS3VtRnAvcStRQ0tpUnFuSzhSRzJWd1k5?=
 =?utf-8?B?eUtmSGxCcmhpMEFSeTBrTTZmOFIyZWFOaEF2NFptd2dHVW9UbW9tYnl0aENO?=
 =?utf-8?B?NVN6MTkyY0YvSS8xakFKSkdDSGFxWHduY1lJYkFMMGs5ZjBjVUZkYnd5L25x?=
 =?utf-8?B?ZktGT2grNkN1R2lCWFR2bmc5aXljWkczUzluMzNIVWhpM055V0tRdFlYa2V6?=
 =?utf-8?B?c0wwWUd6WFdRdEVOSjdNRC9JZVpORFNkU0dWbEZncUZleTZ6blQwc0RPaExx?=
 =?utf-8?B?dTJJRmtIM0s1WVhwRDRueXpnWUh0MWFWOHVTQm52L21Jejhlem9TVXAyVnd6?=
 =?utf-8?B?T1llcUl5cnYvbEpySVZmY0VkeXkwSjJOSmJDYWJScjZoYUM3bFZEUjd2Qm9F?=
 =?utf-8?B?UjVqdlZhLzNUSVVRVWsrc200cCt0bTBjNXpmRStEYlJQMldXRzM0Q0l1bUF6?=
 =?utf-8?B?ZFJnK1FEUVhjRVZQaXNhRjA5VGRnY1BZWTNpWmQrd3I0OHBsMDBEa0hOSG9J?=
 =?utf-8?B?T0MrNnZETkdHaXVubG5PTm9MR3AwOGF4dmhyQzQ5b3BQZDJVVVl6ek5jRzVa?=
 =?utf-8?B?ZHhsTWNOR1FTcFIvNjhxdW9rS0ZFSThsT3pkU2M3bXNGM2tjRnczTGk5eEY2?=
 =?utf-8?B?SXpwSTZYWFE2dHEvM3hLSksyZGlYSlRVZjhybjdYMUxNWUlzOHRmS3QvdURK?=
 =?utf-8?B?VVExbjdCajlNU1hKQytkNmpqREtQaEpVK1p2elp0cFhodzNWa3BQVzBYaFcx?=
 =?utf-8?B?aDVZTFFjcVhCOHhoaUN5elhtVkg4ZW5Wbm9nMW1WbEtUNVdnTE8yUHhqUWU4?=
 =?utf-8?B?Qk5UVlRRdVkxa0tmSDBYdnlTODVXQU9jcENmWXRUeXpiR20wMmgzZElySDVo?=
 =?utf-8?B?SHRla1M0bWJhUnlNdDYwU2pVSlgxRXNUQi9KUVFpWGZMKzhTWnBqMTZObmxW?=
 =?utf-8?B?ZmZEOUdjME85RTNML2VaMWEzUVREbnhYUVlFR1Y1ZTJFV05TNlNiYmNIZFkx?=
 =?utf-8?B?cFdlNTVZTjhmY1d0V0szUkNseVVxZmtUaGVhMnpUMVlWSld6NzBOUDNTeTNt?=
 =?utf-8?B?cUhWOGtXV0xydVhybkJ6Z2Z5UUl6Y3ExVHhlMEwva2hycy9xaU9tWHBqR0xX?=
 =?utf-8?B?b2ZIakEwVUZqSUZtd3ltdTZ5dk5qby9OclZpTUh0c2d1azc1NjVyZlE0enlq?=
 =?utf-8?B?ZHR6NjB0SzdacEpiMWFzdE1HVk9qSC9rU2lQOEtmeS9wNVA2YnlpZ3lQNFg1?=
 =?utf-8?B?eUZHQmlHVUNrYkpOczZsT0tKNS82UFFTM1o2UTFhTmtpVHFZWEk4ViswZ3Bu?=
 =?utf-8?B?UWpKWHUrdG54RDgwNHVNWGNWb0lwUVphdU9iNG00ckowVDFwUkMzeGFqdk5L?=
 =?utf-8?B?dHJQMzNVZ2MyTFo2S3VyYUR6Skl6WEM4OEVRa1loVHpENzg5a0xLM3RmYWRj?=
 =?utf-8?B?SkJaa0xrcklZWE9TLzhxRFowV0xrbi8xNDRUQTFhaFVQVmVSMldNRWhvR1lW?=
 =?utf-8?B?UmxjZkZzZW96cEtibE5xYzd6ZnE0WXBabk8wb1lSY3ZHRWpSeVVYMjR3c1RW?=
 =?utf-8?B?ZHp2THloaGN5N1ltUVJ5RitYRzI1V3F4Vkx4dGF4ckhPSWsrZ05KdW5RUENo?=
 =?utf-8?B?MzZNV2ZLL1JBcTV0VndqbFlQaXkwOHNGd1J6OWVBeGRLZlVyeUxiNUVzWExn?=
 =?utf-8?B?UTZWdEU4aWF3UC95T2ZWSmorWmxLbkUwU0tKQWhGOHpiTXhxWjZyT0c5ZjZj?=
 =?utf-8?B?cUx1RW1jaFFSQzBMSTNFeVJYTzJlZ3lVajZESUZNMThsaGRpQUhuYnNFS0xN?=
 =?utf-8?B?THhUUlZoSi84cktWcThJRnJtUFFkNEhlS3dTUWJFQk1kcUVGSDQyQi9yRWh4?=
 =?utf-8?Q?sx0o+FnXdmtHdavqT8UuhabJ7Jut09/xNTwqCFOZpf8o0?=
X-MS-Exchange-AntiSpam-MessageData-1: y4zlyo7X4yrZcg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a37fac7-f908-4eff-983a-08df2d999559
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 04:29:37.1205 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j/idIqpxVpEA1hq9k4512RaJedpq8+UzJIPx3iy4Fgpvk/6eK2MOJ6c5vMsi3Kpa84vSWYRXG80oGvLXyn0rnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7794
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
 drivers/gpu/nova-core/fb.rs               | 10 +++++-----
 drivers/gpu/nova-core/fb/hal/gb100.rs     |  2 +-
 drivers/gpu/nova-core/fsp.rs              |  4 ++--
 drivers/gpu/nova-core/gpu.rs              |  7 ++-----
 drivers/gpu/nova-core/gsp/fw.rs           | 12 +++---------
 drivers/gpu/nova-core/mm.rs               |  2 +-
 drivers/gpu/nova-core/mm/bar_user.rs      |  7 ++++---
 drivers/gpu/nova-core/mm/pagetable/map.rs |  7 +++++--
 drivers/gpu/nova-core/mm/pramin.rs        |  6 +++---
 drivers/gpu/nova-core/vbios.rs            |  7 +++++--
 rust/kernel/gpu/buddy.rs                  | 26 +++++++++++++-------------
 rust/kernel/io.rs                         |  5 +++--
 12 files changed, 47 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index b0c0b8fe6008..5ceb7760c78e 100644
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
 
         let fw_image = {
-            const FW_IMAGE_DOWN_ALIGN: Alignment = Alignment::new::<SZ_64K>();
+            const FW_IMAGE_DOWN_ALIGN: Alignment = Alignment::SZ_64K;
             let fw_image_size = u64::from_safe_cast(gsp_fw.size());
             let fw_image_addr = (boot.start - fw_image_size).align_down(FW_IMAGE_DOWN_ALIGN);
 
@@ -245,7 +245,7 @@ pub(crate) fn new(
         let (vf_partition_count, wpr2_heap_size) = wpr2_heap_params(chipset, vgpu_state, fb.end)?;
 
         let wpr2_heap = {
-            const WPR2_HEAP_DOWN_ALIGN: Alignment = Alignment::new::<SZ_1M>();
+            const WPR2_HEAP_DOWN_ALIGN: Alignment = Alignment::SZ_1M;
             let wpr2_heap_addr = fw_image
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
index 612f70333c11..37b2ae762df4 100644
--- a/drivers/gpu/nova-core/fb/hal/gb100.rs
+++ b/drivers/gpu/nova-core/fb/hal/gb100.rs
@@ -80,7 +80,7 @@ fn write_sysmem_flush_page_gb100(hshub0: Mmio<'_, regs::Hshub0Registers>, addr:
 
 // This PMU reservation size is r570-specific.
 pub(super) const fn pmu_reserved_size_gb100() -> u32 {
-    cv!(const_align_up(SZ_8M + SZ_16M + SZ_4K, Alignment::new::<SZ_128K>()).unwrap())
+    cv!(const_align_up(SZ_8M + SZ_16M + SZ_4K, Alignment::SZ_128K).unwrap())
 }
 
 impl FbHal for Gb100 {
diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
index 3a4a10487f33..637a00b2c951 100644
--- a/drivers/gpu/nova-core/fsp.rs
+++ b/drivers/gpu/nova-core/fsp.rs
@@ -20,7 +20,7 @@
         Alignable,
         Alignment, //
     },
-    sizes::SZ_2M,
+    sizes::SizeConstants,
     time::Delta,
     transmute::{
         AsBytes,
@@ -259,7 +259,7 @@ fn frts_vidmem_offset(hal: &dyn hal::FspHal, fb_info: &FbSizes) -> Result<u64> {
         if fb_info.pmu_reserved_size != 0 {
             offset = (offset + u64::from(fb_info.pmu_reserved_size))
                 // The 2 MiB alignment is r570-specific.
-                .align_up(Alignment::new::<SZ_2M>())
+                .align_up(Alignment::SZ_2M)
                 .ok_or(EINVAL)?;
         }
 
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 4e59072cab50..9a91cff01e78 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -12,10 +12,7 @@
     pci,
     prelude::*,
     ptr::Alignment,
-    sizes::{
-        SizeConstants,
-        SZ_4K, //
-    },
+    sizes::SizeConstants,
     uapi, //
 };
 
@@ -568,7 +565,7 @@ pub(crate) fn new<'a>(
                 let buddy_params = GpuBuddyParams {
                     base_offset: usable_vram.start,
                     size: usable_vram.end - usable_vram.start,
-                    chunk_size: Alignment::new::<SZ_4K>(),
+                    chunk_size: Alignment::SZ_4K,
                 };
 
                 GpuMm::new(
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 1b548bbf146e..b4866ad21f6e 100644
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
@@ -207,10 +204,7 @@ pub(crate) fn from_ranges<'a>(
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
diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index 8a934c55169f..f53886f9ed91 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -317,7 +317,7 @@ pub(crate) fn run(
 
         let base = usable_fb_regions.iter().find_map(|region| {
             // Tests rely on this being 8 byte aligned for checking misalignment handling.
-            let base = region.start.align_up(Alignment::new::<8>())?;
+            let base = region.start.align_up(Alignment::SZ_8)?;
             (base.checked_add(SELFTEST_SPAN)? <= region.end).then_some(base)
         });
         let Some(base) = base else {
diff --git a/drivers/gpu/nova-core/mm/bar_user.rs b/drivers/gpu/nova-core/mm/bar_user.rs
index 6e9384f06f43..2e8bd2a8ed91 100644
--- a/drivers/gpu/nova-core/mm/bar_user.rs
+++ b/drivers/gpu/nova-core/mm/bar_user.rs
@@ -195,6 +195,7 @@ pub(crate) fn run_self_test(
         },
         ptr::Alignment,
         sizes::{
+            SizeConstants,
             SZ_16K,
             SZ_32K,
             SZ_4K,
@@ -222,7 +223,7 @@ pub(crate) fn run_self_test(
         mm.buddy().alloc_blocks(
             GpuBuddyAllocMode::Simple,
             SZ_4K.into_safe_cast(),
-            Alignment::new::<SZ_4K>(),
+            Alignment::SZ_4K,
             GpuBuddyAllocFlags::default(),
         ),
         GFP_KERNEL,
@@ -299,7 +300,7 @@ pub(crate) fn run_self_test(
         mm.buddy().alloc_blocks(
             GpuBuddyAllocMode::Range(range_base + sz_16k..range_base + sz_16k + sz_4k),
             SZ_4K.into_safe_cast(),
-            Alignment::new::<SZ_4K>(),
+            Alignment::SZ_4K,
             GpuBuddyAllocFlags::default(),
         ),
         GFP_KERNEL,
@@ -311,7 +312,7 @@ pub(crate) fn run_self_test(
         mm.buddy().alloc_blocks(
             GpuBuddyAllocMode::Range(range_base..range_base + sz_32k_4k),
             SZ_32K.into_safe_cast(),
-            Alignment::new::<SZ_4K>(),
+            Alignment::SZ_4K,
             GpuBuddyAllocFlags::default(),
         ),
         GFP_KERNEL,
diff --git a/drivers/gpu/nova-core/mm/pagetable/map.rs b/drivers/gpu/nova-core/mm/pagetable/map.rs
index 77431c509a89..f7774b9cc972 100644
--- a/drivers/gpu/nova-core/mm/pagetable/map.rs
+++ b/drivers/gpu/nova-core/mm/pagetable/map.rs
@@ -17,7 +17,10 @@
         RBTree,
         RBTreeNode, //
     },
-    sizes::SZ_4K, //
+    sizes::{
+        SizeConstants,
+        SZ_4K, //
+    }, //
 };
 
 use super::{
@@ -84,7 +87,7 @@ fn alloc_and_zero_page(mm: &mut GpuMm<'_>, level: PageTableLevel) -> Result<Prep
             mm.buddy().alloc_blocks(
                 GpuBuddyAllocMode::Simple,
                 SZ_4K.into_safe_cast(),
-                Alignment::new::<SZ_4K>(),
+                Alignment::SZ_4K,
                 GpuBuddyAllocFlags::default(),
             ),
             GFP_KERNEL,
diff --git a/drivers/gpu/nova-core/mm/pramin.rs b/drivers/gpu/nova-core/mm/pramin.rs
index 7f89c093d591..c83b1681d241 100644
--- a/drivers/gpu/nova-core/mm/pramin.rs
+++ b/drivers/gpu/nova-core/mm/pramin.rs
@@ -19,8 +19,8 @@
         Alignment, //
     },
     sizes::{
-        SZ_1M,
-        SZ_64K, //
+        SizeConstants,
+        SZ_1M, //
     },
 };
 
@@ -103,7 +103,7 @@ fn drop(&mut self) {
 
 impl<'gpu> Pramin<'gpu> {
     /// Alignment required by the PRAMIN window.
-    const BASE_ALIGN: Alignment = Alignment::new::<SZ_64K>();
+    const BASE_ALIGN: Alignment = Alignment::SZ_64K;
 
     /// Creates the window manager for the given VRAM region.
     pub(super) fn new(
diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 9c214b9f4dd9..a2d2d170b501 100644
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
 
@@ -291,7 +294,7 @@ fn next(&mut self) -> Option<Self::Item> {
 
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
index de8ef8e2aec4..5712478a5461 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -19,7 +19,8 @@
     ptr::{
         Alignment,
         KnownSize, //
-    }, //
+    },
+    sizes::SizeConstants, //
 };
 
 #[cfg(CONFIG_HAS_IOMEM)]
@@ -90,7 +91,7 @@ pub fn ptr_try_from_raw_parts_mut(base: *mut u8, size: usize) -> Result<*mut Sel
 impl<const SIZE: usize> KnownSize for Region<SIZE> {
     const MIN_SIZE: usize = SIZE;
     // Alignment of 4 is the most common; different base types can be added once required.
-    const MIN_ALIGN: Alignment = Alignment::new::<4>();
+    const MIN_ALIGN: Alignment = Alignment::SZ_4;
 
     #[inline(always)]
     fn size(p: *const Self) -> usize {

-- 
2.56.0

