Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 846FEC55172
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 05:45:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C810910E59A;
	Tue,  4 Aug 2026 05:45:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="HaDl71c9";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010050.outbound.protection.outlook.com
 [52.101.193.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6981510E59A
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 05:45:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CXOUKzP0+nMqgm5N4GymLCa1xp+hNJbovEOZxBj4IJQ96tAghWRACS0FF/pcwnjb10MaoS6XVU24Kj9Kf3Zod93G5IlOCMvY1mvjTmSOU0gCmaDC5/ZLrKYv/0IaOkJjs138LioCh/BG37vIHDsaXq41E3PAMUl5yV6EmV1JJYcAcHMpWHuSMJtdH8+gHS52jrwu/Osxyz7NEFXT10UXsCoyk+JeN76B10Umm8ybS3za48hRpO+DV+bzMes/7cnr2Qj/rRBZCkU70wcDqyIpiKzqEnyiufxuP7eZVKTPW1nrCKnU5IHfiLI6EXg8kvtW6rv0IyyUicfmBCli+Gtsvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5idYYqjOjKP0x5vcRC+Qt9d+TFx68JSGfm/Jb2lFNo=;
 b=xuDc/px8tEKyKqa68ORreSipW5FQ3yXnbifgaaUyIgKd6CvKkCbunGYmVWuhgsbNcAW0v4BNg6gAtCRaTRK67sVeG4ybZKsvDm7jwon8Fd6wvbmuCEmygT4NZAKyCIro14tIEAH47G/zgr2KEZns2Cny5RmlinkZTTcOImdOXNE0hOpPo9wBmQX7mZyMe9HNm03jKjQ6/Y20u09i2+UqhzOIR+DorR+T6LfkXUb+8ag4OEhsG5ukZJgqhj84W17gwkFL6a1G7Jy6ihRFJe6OKNsmqKi474dq/J0j2eI0F4hCWrhhW5A3qQRhahkekC4rVWKNK9xwpcoAuJiEFgzslg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5idYYqjOjKP0x5vcRC+Qt9d+TFx68JSGfm/Jb2lFNo=;
 b=HaDl71c9UA1Hgx44mucnJW2gNfZqIYb5OoaZ/o56DIwBfB6E+VRFWFG2ISAdXrjrJgDlj6ZO3RL8GelhwcXobupqSfomSc2LBrnku8UeyvcOoIlc5vN+6YgEGYRSBs1LyFrcAoYTHae4ueP8zrdz1f8CHiKr6WS3VKQUzerOoHmOFJXnZBUMq3s1xMVga6jQZIgz6kE8H3uLDvOcRN6es4/ntZRmGLc6j8o1paa7TH4g287tXUd+Rsxj0wAKsBJaPpdrYixNBMn65ze4cYjEgN+1i61mOwUFaUdV+O9lxWjH7zkt0D0AyCPoWePwHaxLsNhKN3Uo+otEKarBKAwqjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by PH7PR12MB6418.namprd12.prod.outlook.com (2603:10b6:510:1fe::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 05:44:55 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 05:44:55 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 04 Aug 2026 14:41:15 +0900
Subject: [PATCH v4 4/5] gpu: nova-core: split FbLayout into FSP and non-FSP
 versions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-blackwell-fixes-v4-4-ac858b6a1935@nvidia.com>
References: <20260804-blackwell-fixes-v4-0-ac858b6a1935@nvidia.com>
In-Reply-To: <20260804-blackwell-fixes-v4-0-ac858b6a1935@nvidia.com>
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
X-ClientProxiedBy: TY4PR01CA0091.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::11) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|PH7PR12MB6418:EE_
X-MS-Office365-Filtering-Correlation-Id: b21a04dc-d437-453d-55e2-08def1eb832e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|10070799003|23010399003|366016|18002099003|22082099003|6133799003|3023799007|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: Nc52fCuO2vFs/HLabIv27P7EdxC1m3KC3oJChYMUh9woBBCHq8p68bgOUOZjW2pKPr2U9Wh6tiXYTa5+0Hb1k2ZG1k2rHYxa2Vj2EU6lGjESSHw3n/u7PAGa5gxIB9unNvW+iT31fuaecwqS8FLZeo7zHRcnE7fFUvZSIQ3SmFTqbc9co41YI6XALdylLP3Bz/SjBHGr+KByIHM0yHVFydkOcb+1nEKM7Ay/tpN4fAngp83ZjfYxua9cw409LSgDNv9k7F6fRFbnTUOFKssHhLjGnNj/bfdCOs9jKOXgKDqQ6N9aDWYrjZWE04j2yy48RJhq2N40+FDEJihcqYYGmTPcNnU7eImhDixdB+E0baMTByWWFqjqB0Gzho3G4iC+ZpdGAuMv5QVjWSd+v+6mgvoP25qfacF1CC0fhCcI5Tb1a6b+no3QD1NzlZALiSZU+emLJjcvmMqIPlo3BCE7vvjeFOtnjb8BhXl61qakHicuUss9Q/9PxSp7gTc2hegYj4EnvVbknliMFpmToby69UOnZhR+V33Kre6LzTCF195skDLzbcJv9//vg/YrTn836WIsWQE/nmmiu1CzRv/ACIjWVGJmmdeGizW9w44s66UQb4J3+HXmzDwuAydfiiUBK0EZjwIkMZfy3WtZpQYjviB1HOAPXWnr1MkCcUet8gY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(23010399003)(366016)(18002099003)(22082099003)(6133799003)(3023799007)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGhPaGY2Q2NOdzl3SEFEYWdOTjBHMzllZWZKYmtFMG5wenorOElOOGxRZm9r?=
 =?utf-8?B?WThzVVBodGxUNlg5YVpmeExJZUlUSE1vU0tVaGU5RTdmamJ4aDBsK29xd25i?=
 =?utf-8?B?Szl2RnpwdFhNZFZNbkNGSUVKNVg1VXlQZDlyc1NLYzY1YXJ5TkY4ZHltOXNk?=
 =?utf-8?B?RVRCWUhaNEdhSEtrZFFNK09CeThPazk2bFlFMU9IS2lpZ0tBVmg1Y2lYTHYw?=
 =?utf-8?B?TFA2ekZtaXgxbkplOGlUUUY0YWQ1b0JZR1lHWE1qV09yc04yL1Q3TFBsbFJj?=
 =?utf-8?B?dWJmZE1seDREQktySHVrbjB6NWwxaEZFeHRpbjMvSVFRN2Q3eGJCWVoyRDdw?=
 =?utf-8?B?MVFBK3EyY0kvcXBKVkZNOGtra1FvUGNFNGhvd0tWQXlEVUZGUlBmVTJMNS95?=
 =?utf-8?B?NnFlRDdOSU5PUDl1T3diZTJGbW40UEhLYnlUTDNtcVVQbkVRcDIrcEV5NHp0?=
 =?utf-8?B?dU1YaHpvbWovU2tlbmJWK1BLN2N1WEpNanFvM014YS83bE5UUXkwQkJXMDZL?=
 =?utf-8?B?dXJrelZPWElqeXM0NFlsWVNCblp5SmdDSjBFbnB1dlJCVEVhYUtjeXZpL3pj?=
 =?utf-8?B?blM4SEMwZGlVTU1PWWxVVm9MeTgrZlpkSUJ4aGFZQkdOOCsvRGN6QkxtM0lk?=
 =?utf-8?B?aFV3ZmVEYVBJajhPNE45dzZ3aSsyMWlpZ1VKT0VMWWZ0MThidzJPb2ErTU5z?=
 =?utf-8?B?YytJVTIzbm9mS3VFOFFKZ2UyZ0VMR3M3RVNwcWJZMlR4VTNqeUt3a3VMbHpq?=
 =?utf-8?B?OTFZS3E0c1VhdlJmZ01WV1JKZjR0cFlGVXlvTDBxNW42WW5UWTAySFFtcnh0?=
 =?utf-8?B?MnRCYWcrMENBbGRQMmVPWEsyNlVlaHJZSkFSekJuZGdFdnJQTUc0TUhZQ2pF?=
 =?utf-8?B?TG80d3dkS0R4YkliMU1MU3lrQjRocW9OcUdWSkF2VVVDQjNGRkVRSFR4bXVj?=
 =?utf-8?B?eUhRM0wxbGdIZWJkY3VPQ2picG90V1htMWlwWExkbVZHNDBWdDlaMXJjNHpF?=
 =?utf-8?B?Z1hRd1dZTFBsa0sxWFlwQU9zTTF4THhVRmd6dUlYU0t5WnhoLzNsZm91a2xt?=
 =?utf-8?B?Rkw1SFhiRGpLMlpMQUQ3OStLUFlJNnkwUWlQUEMyYjdNZHk1ZVM3T3hTa0w1?=
 =?utf-8?B?L2Rpbk15SlUrN0orak0renRXOWlycnRBVm1ScWZxUkd1eXpnNnZHRFFsc3Vr?=
 =?utf-8?B?OEQ2WjdyQWNreGh0c0NjS24ydE42c1BpRTJ5Qm1LVFBvYVJZNGtubEVTdkNP?=
 =?utf-8?B?NE5GVElmTWFvV1FRMjVmT0gyWnNPNzJBSHB3d285b2k4NlNyTUVqYWc0Q3k3?=
 =?utf-8?B?Tm1DV3p2K3ZwbFZQUGpVZC9kZG50VnFGUkVHMkdKQi81MTVqa0dETjZKOVBU?=
 =?utf-8?B?MkN2VzZVNDZFcnd3cHpPWFM0MDJ3UXc5UWNsWHBFSGN6Zy9zZmFwNDR2TTE4?=
 =?utf-8?B?NUYzVmZESS90SEYza0JvU2ZCWWxiZVdXWFROdWd6d01GUGVHNkZyR2lidExQ?=
 =?utf-8?B?WmVSUE8rNXRvbytsaDhWcEF3SVNmeHVJTytxUEY2S0NnTC9xaDAyV3B6Zit4?=
 =?utf-8?B?NExFa0RId1JNb0Q4ZkF3di9rY2JjajJRdmp4MXdGaHBUa0tYVW9KOUY2YTMr?=
 =?utf-8?B?QmhHb0hhWHpNT050S2FlQVo2cjhHV2R5dC9WZHlBRkNad0ptcVEvb0wvWTJK?=
 =?utf-8?B?K1M4dzV5SHAvUDdlU2lVWU9ZRFU4a3lwK0QzYndJNUJaMC9kSFd5aTAwTnVi?=
 =?utf-8?B?VjNIRjM2N3Q5MDY3Y2FxQ1hXU05ZSHdyYk9JbmVBK2lMbzVrTWtwd2ZJYXFz?=
 =?utf-8?B?enlKWXFBUDRNb2JpSVQ2WnNXWENqQjJCRkYxbksyOFFqTG92bTJtaEhuM3VW?=
 =?utf-8?B?bWY3NitZQTc5OWxOOUhQalFURjNyMWt1enQrWmg0M29DcjRDOXFoSWtoODdC?=
 =?utf-8?B?UWpvamEzWnJ2T3FMZ0cxcEl2WjFBRnVweHNlVFVKcDIxbzIwU2NMMjc5NDJN?=
 =?utf-8?B?WnpndHBQby9zOFNiYXRpdkJvZXpWb2F1RmF6MmlBaDdhUXVCR05Pc0lZZmtH?=
 =?utf-8?B?MEdWTUoyZkZHUHJXektrYys0bFZQbFJUanVzSmZmZFhodERwbVVNRUYrQ0Y3?=
 =?utf-8?B?cXkzR0FRYnl1SjBOMFpRTGhzaXMwazF4R3o5bTVKZ2p1S015Z1ZLb01GVVpL?=
 =?utf-8?B?TzJVeW9MdndETTNRZzh3cXN5SytaMzV4dS9FNlB5NUlFYkVYVm5KZDVpZ1Z4?=
 =?utf-8?B?ekFaYU5kSXh2Wm9VWksyZnF1SXhESjdkbkNPb09LMnJhY3NBdTJYWEk0ZTJy?=
 =?utf-8?B?b3ZkYVFGQWNqUFRsT3NTNk0vZUc2ZGR6K0tqeDZ0NndWNFZ0UEFHT28rYnJL?=
 =?utf-8?Q?89qAOtj8hsVGiQz9MEf4BrEot3nCmbxuLB5E53mTmPWCh?=
X-MS-Exchange-AntiSpam-MessageData-1: 1sPFV+6JM+Qyxw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b21a04dc-d437-453d-55e2-08def1eb832e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 05:44:55.6608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s7csu0ooeszb8c3YwNBcZLZ6TcKkPIXWLISiRsntrYDVopvIUzaGlSDtq9QGtMZbhGRgCWAWimBnKZxXTL9rjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6418
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

`FbLayout` is currently used for both pre and post FSP architectures. It
contains ranges for each region of framebuffer, but on post FSP
architectures, only the size is actually used. The region locations are
decided by ACR, which runs as part of the GSP-FMC, not by the driver.
The driver only provides the sizes. So, for post FSP architectures
`FbLayout` contains essentially guesses for the offsets. Instead, make
separate types so that we only store the information that's actually
needed, rather than keeping around offsets that may not be correct.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/fb.rs            | 65 ++++++++++++++++++++------
 drivers/gpu/nova-core/fsp.rs           | 21 ++++-----
 drivers/gpu/nova-core/gsp/boot.rs      | 28 ++++-------
 drivers/gpu/nova-core/gsp/fw.rs        | 85 ++++++++++++++++++++++++++--------
 drivers/gpu/nova-core/gsp/hal.rs       | 12 ++---
 drivers/gpu/nova-core/gsp/hal/gh100.rs | 17 ++++---
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 32 ++++++++-----
 7 files changed, 170 insertions(+), 90 deletions(-)

diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index 86d2bdaab7f9..77447a6567a4 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -149,7 +149,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
 ///
 /// Contains ranges of GPU memory reserved for a given purpose during the GSP boot process.
 #[derive(Debug)]
-pub(crate) struct FbLayout {
+pub(crate) struct FbRanges {
     /// Range of the framebuffer. Starts at `0`.
     pub(crate) fb: FbRange,
     /// VGA workspace, small area of reserved memory at the end of the framebuffer.
@@ -164,14 +164,16 @@ pub(crate) struct FbLayout {
     pub(crate) wpr2_heap: FbRange,
     /// WPR2 region range, starting with an instance of `GspFwWprMeta`.
     pub(crate) wpr2: FbRange,
+    /// Non-WPR heap, located just below WPR2.
     pub(crate) non_wpr_heap: FbRange,
+    /// Number of VF partitions.
     pub(crate) vf_partition_count: u8,
     /// PMU reserved memory size, in bytes.
     pub(crate) pmu_reserved_size: u32,
 }
 
-impl FbLayout {
-    /// Computes the FB layout for `chipset` required to run the `gsp_fw` GSP firmware.
+impl FbRanges {
+    /// Computes concrete framebuffer ranges required on non-FSP booting architectures.
     pub(crate) fn new(
         chipset: Chipset,
         bar: Bar0<'_>,
@@ -240,16 +242,7 @@ pub(crate) fn new(
             FbRange(elf_addr..elf_addr + elf_size)
         };
 
-        let (vf_partition_count, wpr2_heap_size) = match vgpu_state {
-            VgpuState::Disabled => (
-                0,
-                gsp::LibosParams::from_chipset(chipset).wpr_heap_size(chipset, fb.end)?,
-            ),
-            VgpuState::Enabled { total_vfs } => (
-                u8::try_from(total_vfs.get()).map_err(|_| EINVAL)?,
-                gsp::LibosParams::vgpu_wpr_heap_size(),
-            ),
-        };
+        let (vf_partition_count, wpr2_heap_size) = wpr2_heap_params(chipset, vgpu_state, fb.end)?;
 
         let wpr2_heap = {
             const WPR2_HEAP_DOWN_ALIGN: Alignment = Alignment::new::<SZ_1M>();
@@ -303,3 +296,49 @@ pub(crate) fn wpr2_range(bar: Bar0<'_>) -> Option<Range<u64>> {
 
     Some(wpr2_lo.lower_bound()..wpr2_hi.higher_bound())
 }
+
+/// Computes the number of VF partitions and the WPR2 heap size from the vGPU state.
+fn wpr2_heap_params(chipset: Chipset, vgpu_state: VgpuState, fb_size: u64) -> Result<(u8, u64)> {
+    Ok(match vgpu_state {
+        VgpuState::Disabled => (
+            0,
+            gsp::LibosParams::from_chipset(chipset).wpr_heap_size(chipset, fb_size)?,
+        ),
+        VgpuState::Enabled { total_vfs } => (
+            u8::try_from(total_vfs.get()).map_err(|_| EINVAL)?,
+            gsp::LibosParams::vgpu_wpr_heap_size(),
+        ),
+    })
+}
+
+/// Framebuffer region sizes needed for GSP-FMC boot.
+#[derive(Debug)]
+pub(crate) struct FbSizes {
+    /// FRTS size, in bytes.
+    pub(crate) frts_size: u64,
+    /// WPR2 heap size, in bytes.
+    pub(crate) wpr2_heap_size: u64,
+    /// Non-WPR heap size, in bytes.
+    pub(crate) non_wpr_heap_size: u64,
+    /// PMU reserved memory size, in bytes.
+    pub(crate) pmu_reserved_size: u32,
+    /// Number of VF partitions.
+    pub(crate) vf_partition_count: u8,
+}
+
+impl FbSizes {
+    /// Computes the framebuffer region sizes for GSP-FMC boot.
+    pub(crate) fn new(chipset: Chipset, bar: Bar0<'_>, vgpu_state: VgpuState) -> Result<Self> {
+        let hal = hal::fb_hal(chipset);
+        let fb_size = hal.vidmem_size(bar);
+        let (vf_partition_count, wpr2_heap_size) = wpr2_heap_params(chipset, vgpu_state, fb_size)?;
+
+        Ok(Self {
+            frts_size: hal.frts_size(),
+            wpr2_heap_size,
+            non_wpr_heap_size: hal.non_wpr_heap_size(),
+            pmu_reserved_size: hal.pmu_reserved_size(),
+            vf_partition_count,
+        })
+    }
+}
diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
index a81b51028282..9add62736892 100644
--- a/drivers/gpu/nova-core/fsp.rs
+++ b/drivers/gpu/nova-core/fsp.rs
@@ -31,7 +31,7 @@
         fsp::Fsp as FspEngine,
         Falcon, //
     },
-    fb::FbLayout,
+    fb::FbSizes,
     firmware::{
         fsp::{
             FmcSignatures,
@@ -253,11 +253,11 @@ struct FspCotMessage {
 impl FspCotMessage {
     /// Computes the FRTS vidmem offset for the Chain-of-Trust message. It is measured backwards
     /// from the end of the framebuffer.
-    fn frts_vidmem_offset(hal: &dyn hal::FspHal, fb_layout: &FbLayout) -> Result<u64> {
+    fn frts_vidmem_offset(hal: &dyn hal::FspHal, fb_info: &FbSizes) -> Result<u64> {
         let mut offset = u64::from(hal.fb_end_reserved_size());
 
-        if fb_layout.pmu_reserved_size != 0 {
-            offset = (offset + u64::from(fb_layout.pmu_reserved_size))
+        if fb_info.pmu_reserved_size != 0 {
+            offset = (offset + u64::from(fb_info.pmu_reserved_size))
                 // The 2 MiB alignment is r570-specific.
                 .align_up(Alignment::new::<SZ_2M>())
                 .ok_or(EINVAL)?;
@@ -268,20 +268,20 @@ fn frts_vidmem_offset(hal: &dyn hal::FspHal, fb_layout: &FbLayout) -> Result<u64
 
     /// Returns an in-place initializer for [`FspCotMessage`].
     fn new<'a>(
-        fb_layout: &FbLayout,
+        fb_info: &FbSizes,
         fsp_fw: &'a FspFirmware,
         args: &'a FmcBootArgs<'_>,
     ) -> Result<impl Init<Self> + 'a> {
         let hal = hal::fsp_hal(args.chipset).ok_or(ENOTSUPP)?;
 
         let frts_vidmem_offset = if !args.resume {
-            Self::frts_vidmem_offset(hal, fb_layout)?
+            Self::frts_vidmem_offset(hal, fb_info)?
         } else {
             0
         };
 
         let frts_size: u32 = if !args.resume {
-            fb_layout.frts.len().try_into()?
+            fb_info.frts_size.try_into()?
         } else {
             0
         };
@@ -537,15 +537,12 @@ pub(crate) fn read_vgpu_mode(
     pub(crate) fn boot_fmc(
         &mut self,
         dev: &device::Device<device::Bound>,
-        fb_layout: &FbLayout,
+        fb_info: &FbSizes,
         args: &FmcBootArgs<'_>,
     ) -> Result {
         dev_dbg!(dev, "Starting FSP boot sequence for {}\n", args.chipset);
 
-        let msg = KBox::init(
-            FspCotMessage::new(fb_layout, &self.fsp_fw, args)?,
-            GFP_KERNEL,
-        )?;
+        let msg = KBox::init(FspCotMessage::new(fb_info, &self.fsp_fw, args)?, GFP_KERNEL)?;
 
         let _response_buf = self.send_sync_fsp(dev, &*msg)?;
 
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 727b8ae4bcb7..97f6e7ef4ead 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -3,7 +3,6 @@
 
 use kernel::{
     bits,
-    dma::Coherent,
     io::poll::read_poll_timeout,
     prelude::*,
     time::Delta,
@@ -16,15 +15,13 @@
         gsp::Gsp,
         Falcon, //
     },
-    fb::FbLayout,
     firmware::{
         gsp::GspFirmware,
         FIRMWARE_VERSION, //
     },
     gsp::{
         cmdq::Cmdq,
-        commands,
-        GspFwWprMeta, //
+        commands, //
     },
 };
 
@@ -50,23 +47,16 @@ pub(crate) fn boot(
 
         let gsp_fw = KBox::pin_init(GspFirmware::new(dev, chipset, FIRMWARE_VERSION), GFP_KERNEL)?;
 
-        let fb_layout = FbLayout::new(chipset, bar, &gsp_fw, ctx.vgpu.state())?;
-        dev_dbg!(dev, "{:#x?}\n", fb_layout);
-
-        let wpr_meta = Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::new(&gsp_fw, &fb_layout))?;
-
         // Perform the chipset-specific boot sequence, and retrieve the unload bundle.
-        let unload_bundle = hal
-            .boot(&self, &mut ctx, &fb_layout, &wpr_meta)?
-            .or_else(|| {
-                dev_warn!(dev, "The GSP won't be able to unload properly on unbind.\n");
-                dev_warn!(
-                    dev,
-                    "The GPU will need to be reset before the driver can bind again.\n"
-                );
+        let unload_bundle = hal.boot(&self, &mut ctx, &gsp_fw)?.or_else(|| {
+            dev_warn!(dev, "The GSP won't be able to unload properly on unbind.\n");
+            dev_warn!(
+                dev,
+                "The GPU will need to be reset before the driver can bind again.\n"
+            );
 
-                None
-            });
+            None
+        });
 
         let mut unload_guard =
             ScopeGuard::new_with_data((ctx, unload_bundle), |(ctx, unload_bundle)| {
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index a7637bf3f3df..998293656794 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -36,7 +36,10 @@
 };
 
 use crate::{
-    fb::FbLayout,
+    fb::{
+        FbRanges,
+        FbSizes, //
+    },
     firmware::gsp::GspFirmware,
     gpu::{
         Architecture,
@@ -174,10 +177,10 @@ unsafe impl FromBytes for GspFwWprMeta {}
 
 impl GspFwWprMeta {
     /// Returns an initializer for a `GspFwWprMeta` suitable for booting `gsp_firmware` using the
-    /// `fb_layout` layout.
-    pub(crate) fn new<'a>(
+    /// framebuffer ranges `ranges`.
+    pub(crate) fn from_ranges<'a>(
         gsp_firmware: &'a GspFirmware,
-        fb_layout: &'a FbLayout,
+        ranges: &'a FbRanges,
     ) -> impl Init<Self> + 'a {
         let init_inner = init!(bindings::GspFwWprMeta {
             // CAST: we want to store the bits of `GSP_FW_WPR_META_MAGIC` unmodified.
@@ -196,25 +199,67 @@ pub(crate) fn new<'a>(
                     sizeOfSignature: u64::from_safe_cast(gsp_firmware.signatures.size()),
                 },
             },
-            gspFwRsvdStart: fb_layout.non_wpr_heap.start,
-            nonWprHeapOffset: fb_layout.non_wpr_heap.start,
-            nonWprHeapSize: fb_layout.non_wpr_heap.end - fb_layout.non_wpr_heap.start,
-            gspFwWprStart: fb_layout.wpr2.start,
-            gspFwHeapOffset: fb_layout.wpr2_heap.start,
-            gspFwHeapSize: fb_layout.wpr2_heap.end - fb_layout.wpr2_heap.start,
-            gspFwOffset: fb_layout.elf.start,
-            bootBinOffset: fb_layout.boot.start,
-            frtsOffset: fb_layout.frts.start,
-            frtsSize: fb_layout.frts.end - fb_layout.frts.start,
-            gspFwWprEnd: fb_layout
+            gspFwRsvdStart: ranges.non_wpr_heap.start,
+            nonWprHeapOffset: ranges.non_wpr_heap.start,
+            nonWprHeapSize: ranges.non_wpr_heap.len(),
+            gspFwWprStart: ranges.wpr2.start,
+            gspFwHeapOffset: ranges.wpr2_heap.start,
+            gspFwHeapSize: ranges.wpr2_heap.len(),
+            gspFwOffset: ranges.elf.start,
+            bootBinOffset: ranges.boot.start,
+            frtsOffset: ranges.frts.start,
+            frtsSize: ranges.frts.len(),
+            gspFwWprEnd: ranges
                 .vga_workspace
                 .start
                 .align_down(Alignment::new::<SZ_128K>()),
-            gspFwHeapVfPartitionCount: fb_layout.vf_partition_count,
-            fbSize: fb_layout.fb.end - fb_layout.fb.start,
-            vgaWorkspaceOffset: fb_layout.vga_workspace.start,
-            vgaWorkspaceSize: fb_layout.vga_workspace.end - fb_layout.vga_workspace.start,
-            pmuReservedSize: fb_layout.pmu_reserved_size,
+            gspFwHeapVfPartitionCount: ranges.vf_partition_count,
+            fbSize: ranges.fb.len(),
+            vgaWorkspaceOffset: ranges.vga_workspace.start,
+            vgaWorkspaceSize: ranges.vga_workspace.len(),
+            pmuReservedSize: ranges.pmu_reserved_size,
+            ..Zeroable::init_zeroed()
+        });
+
+        init!(GspFwWprMeta {
+            inner <- init_inner,
+        })
+    }
+
+    /// Returns an initializer for a `GspFwWprMeta` suitable for booting `gsp_firmware` using the
+    /// framebuffer region sizes `sizes`.
+    ///
+    /// The region offsets are left at zero: the ACR ucode computes them when it sets up WPR2.
+    pub(crate) fn from_sizes<'a>(
+        gsp_firmware: &'a GspFirmware,
+        sizes: &'a FbSizes,
+    ) -> impl Init<Self> + 'a {
+        /// VGA workspace size to reserve at the end of the framebuffer, in bytes.
+        const VGA_WORKSPACE_SIZE: u64 = u64::SZ_128K;
+
+        let init_inner = init!(bindings::GspFwWprMeta {
+            // CAST: we want to store the bits of `GSP_FW_WPR_META_MAGIC` unmodified.
+            magic: bindings::GSP_FW_WPR_META_MAGIC as u64,
+            revision: u64::from(bindings::GSP_FW_WPR_META_REVISION),
+            sysmemAddrOfRadix3Elf: gsp_firmware.radix3_dma_handle(),
+            sizeOfRadix3Elf: u64::from_safe_cast(gsp_firmware.size),
+            sysmemAddrOfBootloader: gsp_firmware.bootloader.ucode.dma_handle(),
+            sizeOfBootloader: u64::from_safe_cast(gsp_firmware.bootloader.ucode.size()),
+            bootloaderCodeOffset: u64::from(gsp_firmware.bootloader.code_offset),
+            bootloaderDataOffset: u64::from(gsp_firmware.bootloader.data_offset),
+            bootloaderManifestOffset: u64::from(gsp_firmware.bootloader.manifest_offset),
+            __bindgen_anon_1: GspFwWprMetaBootResumeInfo {
+                __bindgen_anon_1: GspFwWprMetaBootInfo {
+                    sysmemAddrOfSignature: gsp_firmware.signatures.dma_handle(),
+                    sizeOfSignature: u64::from_safe_cast(gsp_firmware.signatures.size()),
+                },
+            },
+            nonWprHeapSize: sizes.non_wpr_heap_size,
+            gspFwHeapSize: sizes.wpr2_heap_size,
+            frtsSize: sizes.frts_size,
+            gspFwHeapVfPartitionCount: sizes.vf_partition_count,
+            vgaWorkspaceSize: VGA_WORKSPACE_SIZE,
+            pmuReservedSize: sizes.pmu_reserved_size,
             ..Zeroable::init_zeroed()
         });
 
diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/gsp/hal.rs
index 34b4bb82a999..11e436651a69 100644
--- a/drivers/gpu/nova-core/gsp/hal.rs
+++ b/drivers/gpu/nova-core/gsp/hal.rs
@@ -5,13 +5,9 @@
 mod gh100;
 mod tu102;
 
-use kernel::{
-    dma::Coherent,
-    prelude::*, //
-};
+use kernel::prelude::*;
 
 use crate::{
-    fb::FbLayout,
     firmware::gsp::GspFirmware,
     gpu::{
         Architecture,
@@ -19,8 +15,7 @@
     },
     gsp::{
         Gsp,
-        GspBootContext,
-        GspFwWprMeta, //
+        GspBootContext, //
     },
 };
 
@@ -44,8 +39,7 @@ fn boot(
         &self,
         gsp: &Gsp,
         ctx: &mut GspBootContext<'_, '_>,
-        fb_layout: &FbLayout,
-        wpr_meta: &Coherent<GspFwWprMeta>,
+        gsp_fw: &GspFirmware,
     ) -> Result<Option<crate::gsp::UnloadBundle>>;
 
     /// Performs HAL-specific post-GSP boot tasks.
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index 22b60f9233de..be10d278f567 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -16,7 +16,8 @@
         gsp::Gsp as GspEngine,
         Falcon, //
     },
-    fb::FbLayout,
+    fb::FbSizes,
+    firmware::gsp::GspFirmware,
     fsp::FmcBootArgs,
     gsp::{
         hal::{
@@ -144,19 +145,23 @@ fn boot(
         &self,
         gsp: &Gsp,
         ctx: &mut GspBootContext<'_, '_>,
-        fb_layout: &FbLayout,
-        wpr_meta: &Coherent<GspFwWprMeta>,
+        gsp_fw: &GspFirmware,
     ) -> Result<Option<crate::gsp::UnloadBundle>> {
         let dev = ctx.dev();
         let chipset = ctx.chipset;
         let gsp_falcon = ctx.gsp_falcon;
 
+        let fb_sizes = FbSizes::new(chipset, ctx.bar, ctx.vgpu.state())?;
+        dev_dbg!(dev, "{:#x?}\n", fb_sizes);
+
+        let wpr_meta =
+            Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::from_sizes(gsp_fw, &fb_sizes))?;
+        let args = FmcBootArgs::new(dev, chipset, &wpr_meta, &gsp.libos, false)?;
+
         let unload_bundle = crate::gsp::UnloadBundle(
             KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn UnloadBundle>
         );
 
-        let args = FmcBootArgs::new(dev, chipset, wpr_meta, &gsp.libos, false)?;
-
         // Wait for the GSP RISC-V core to halt in case of error. We create this guard after `args`
         // to make sure that boot args are kept alive until halt, in case they are still being
         // accessed.
@@ -167,7 +172,7 @@ fn boot(
 
         let fsp = unload_guard.1.fsp.as_mut().ok_or(ENODEV)?;
 
-        fsp.boot_fmc(dev, fb_layout, &args)?;
+        fsp.boot_fmc(dev, &fb_sizes, &args)?;
 
         // Wait for GSP-FMC to release the GSP lockdown, indicating that `args` is not accessed
         // anymore.
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index 03133f723faf..e3c365cf4a68 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -19,7 +19,7 @@
     },
     fb::{
         wpr2_range,
-        FbLayout, //
+        FbRanges, //
     },
     firmware::{
         booter::{
@@ -143,7 +143,7 @@ fn run_fwsec_frts(
         falcon: &Falcon<'_, GspEngine>,
         bar: Bar0<'_>,
         bios: &Vbios,
-        fb_layout: &FbLayout,
+        fb_ranges: &FbRanges,
     ) -> Result {
         // Check that the WPR2 region does not already exist - if it does, we cannot run
         // FWSEC-FRTS until the GPU is reset.
@@ -161,8 +161,8 @@ fn run_fwsec_frts(
             falcon,
             bios,
             FwsecCommand::Frts {
-                frts_addr: fb_layout.frts.start,
-                frts_size: fb_layout.frts.len(),
+                frts_addr: fb_ranges.frts.start,
+                frts_size: fb_ranges.frts.len(),
             },
         )?;
 
@@ -196,12 +196,12 @@ fn run_fwsec_frts(
             return Err(EIO);
         };
 
-        if wpr2_range.start != fb_layout.frts.start {
+        if wpr2_range.start != fb_ranges.frts.start {
             dev_err!(
                 dev,
                 "WPR2 region created at unexpected address {:#x}; expected {:#x}\n",
                 wpr2_range.start,
-                fb_layout.frts.start,
+                fb_ranges.frts.start,
             );
 
             return Err(EIO);
@@ -253,8 +253,7 @@ fn boot(
         &self,
         gsp: &Gsp,
         ctx: &mut GspBootContext<'_, '_>,
-        fb_layout: &FbLayout,
-        wpr_meta: &Coherent<GspFwWprMeta>,
+        gsp_fw: &GspFirmware,
     ) -> Result<Option<crate::gsp::UnloadBundle>> {
         let dev = ctx.dev();
         let bar = ctx.bar;
@@ -262,6 +261,17 @@ fn boot(
         let gsp_falcon = ctx.gsp_falcon;
         let sec2_falcon = ctx.sec2_falcon;
 
+        let fb_ranges = FbRanges::new(chipset, bar, gsp_fw, ctx.vgpu.state())?;
+        dev_dbg!(dev, "{:#x?}\n", fb_ranges);
+
+        // Declared before the unload guard so that if Booter fails while running, SEC2 is reset
+        // by the guard before this allocation is freed.
+        let wpr_meta = Coherent::init(
+            dev,
+            GFP_KERNEL,
+            GspFwWprMeta::from_ranges(gsp_fw, &fb_ranges),
+        )?;
+
         let bios = Vbios::new(dev, bar)?;
 
         // Try and prepare the unload bundle.
@@ -281,8 +291,8 @@ fn boot(
         });
 
         // FWSEC-FRTS is not executed on chips where the FRTS region size is 0 (e.g. GA100).
-        if !fb_layout.frts.is_empty() {
-            self.run_fwsec_frts(dev, chipset, gsp_falcon, bar, &bios, fb_layout)?;
+        if !fb_ranges.frts.is_empty() {
+            self.run_fwsec_frts(dev, chipset, gsp_falcon, bar, &bios, &fb_ranges)?;
         }
 
         gsp_falcon.reset()?;
@@ -303,7 +313,7 @@ fn boot(
             FIRMWARE_VERSION,
             sec2_falcon,
         )?
-        .run(dev, sec2_falcon, wpr_meta)?;
+        .run(dev, sec2_falcon, &wpr_meta)?;
 
         Ok(unload_guard.dismiss())
     }

-- 
2.55.0

