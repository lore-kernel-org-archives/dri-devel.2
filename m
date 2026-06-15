Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7386CD98E2
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 14:42:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15F9410E4CC;
	Mon, 15 Jun 2026 14:42:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="oUI1RlKa";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011049.outbound.protection.outlook.com
 [40.93.194.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2133210E4C0
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 14:42:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ozFQBmt+t4XroJceAEM8WrL2dCW3qfpu3TMkIKdAQlxcepguFmgqnNu7nrbnyGfKCRarcxorHu2kLBKGWk1gNI1D1veg3sop3/wRIATnKVqKmlZOD4Yzxz0dN1KbI3mGILOiwZSEXzbIJ430GdK9dYizj1yIclB0S07DZmqu8wXvSy/H9tr+TfW95cYA1IYMEQvpKgGQUYsQZiDGmP0G8rqdOtNwBE3AgEHc23z1bmOnRsOPTqZxFP90XQytBIS+/YESSAwQ/6+AeHhhEWydl9dvvDkzeEG4vA3ezEa0o2DXkab5WMPzTgmIl+5eY2UUI7s7YHc7vXajDV8qphJw7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21OG4egrJEDcD1N5HZHOyaPjDle1Oh5YTn6XtPwQhGs=;
 b=XbB2syqyBBqiB5bYt7wC2yHrpSHT77+OSf/ArpdTmJqWUbKIcHsQ9ZdGDSVdtvEwliP980WX/gJLjw012agD/whS8N4uhB9agneGn972rpa0ieTTNPnkiH3mCWRMApK4HaR8k0aICQFL3GHPiQXqtFshc/fRKPXeL0VFj86nsUOvF8wBHsJQhWpgIprx0NfVNVxxtd7w7EPYVniE+iul7ZhPsYbnffiXebzSMAOm+r6ZkwNWpSd/SIE+HBGgVUwr9pUHIbPvdqF2EVkIKk47L1Hw3b6bbTgrl5xOfIIzwVq+CjuXQLiOwyVSbHKZCdDa6bIg1mpmNvctAfimk7vedg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21OG4egrJEDcD1N5HZHOyaPjDle1Oh5YTn6XtPwQhGs=;
 b=oUI1RlKawZsIZIgNQIgzmSaGxPom2jp430UmqyGoT8zTrBtL0sSg3IAr1KopcwGhaUP13GCCcCcwfqB7fMkuymEy7UiIZdFmMAXOsCam7VnRBfq1VNHu7WYfevJkyuAKYYNTfUaOTG73/0ecEuSTxEisSNHYi4LD/mY2/CzLOvra6KuaeghkKc2b46vIB7lX9ohfEgaFn1766B5eY3eBTomtwST5gWvaAJbmcnF6n+jjq7de20Em6PzimCpAcmHAJZlIV4fKOIIn9BEaR0Vx1jFQHLh3HUetcATP9zPiAdi0YrVwDEDOY6Sg7HakdRyP9R+7zW8oWHtGGF+YFXoRvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by LV8PR12MB9668.namprd12.prod.outlook.com (2603:10b6:408:295::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Mon, 15 Jun
 2026 14:42:17 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 14:42:17 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 15 Jun 2026 23:40:51 +0900
Subject: [PATCH 11/13] gpu: nova-core: correct FRTS vidmem offset calculation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-blackwell-fixes-v1-11-f2853e49ff7d@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0338.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::17) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|LV8PR12MB9668:EE_
X-MS-Office365-Filtering-Correlation-Id: c709af83-bcdc-4bf5-b94d-08decaec4c45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|23010399003|366016|1800799024|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: RiBBDjT0E5BTxQqrEPJxuw09LlxzKxY9n99CDf6bVjak/rIpWZnJ8dKBlgUc8hiwZM9eLZkZZlHbcSDmNdsH3CL7O5UuWwZpyTRYbilXHuO/jRAJR3sMsV1nczJ/QBv53sAyfHurHEFMOfs2ZGGMkJcpKT0o/y2Y/kf7pwtSXq7EheNavHBgZReiw74kVSy2GMiq4+VyDpq7Pz3UT5rKSFukuSPv1XysBPmBvLyIfShEL4URDwGdy7uzIju9CsW9xtOoH92wE1GeGY37Frhte/ga1SDMMn74q+yudCj21z/Vk45dTZXVvis4wfYFk3Q20hG8YkKvP8O9+e2qBwy5wT4+dW7cHcQQoWBXaxtGV8tgC0/kDDUaTK7sutsu8+PB74XK3Sw1I0z5BWINCgggq4Dg4hAmZrUtih0eBi73B5pczGSHvOKBW9PStMPslsf9JKkFEnkDpx7X2F0JXddSE8X8ne7rZe3vrFN27Mi19zl+kv3blr7cH6pS24ztW3mWsvcvosVUU1OxyNNaT5/bxTsOfewvXwuJJjWU7zbJKr2yWuFutt7/1pQMUutnghFZR7GFSee6Dm8J0glfKDSgqituiK9gdvB6rK1FjcbntfqruwkNS83WgPSWRWULXgdkAs3BixxZnRHoucfYNhsxSX/4DqrgLaJmb6jIFpndM8YpnwWQMhIflbuyEcUqunD9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(23010399003)(366016)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NndTWlMyUHc4T3RLT3BpTkxvdU54UlZ5R2U5SHgrSFZ1UVpuODdQSURZWXpx?=
 =?utf-8?B?alFGL3VDY0pKL1B5VWtXZUtZL2pqbjdQK1FNSWVVdHAveWhCWVdSOHV5TmRm?=
 =?utf-8?B?blBMTm85NHdLdUhaZGx0OFJPY0RMMFhaWlhGeXlUbkpwYnhHT2ErWTNyNE40?=
 =?utf-8?B?YzRBZlQrcURRcDNBM1RJN3dSVEdjdnRYb1NsRTJiQjlVaDUvVEtENWUwbUxu?=
 =?utf-8?B?dVBNblAyYjZPVy9oMmdpVUNGZXJGVWdiVUJwQzFwZVRxdnhSWjcvNUkwRVZ3?=
 =?utf-8?B?TVEraW9mN1VsQ3h2aG55QlNCSG9RRUpZRWY1aEJ0M0t1bEVqVys4eUVPY3Ny?=
 =?utf-8?B?bk1GYk5tdzBZRzRsRm5rUDVFTGdBdHR6U0plcllqNVF0UU1QbnpWSjlMWnpE?=
 =?utf-8?B?U1RTci9sVjZjd0NZUytQaUF1OVZTMEdlSEhreEM5UW1DMDR1R3BuZ3FVWksx?=
 =?utf-8?B?TElDNVZJQllrZjNKTmhFV3I1Q0tPaUx6VHIyWldYSExreWNsdXlnN042cXVG?=
 =?utf-8?B?MlZiTktXMmFHV2FkcHlyWlIwbXYxSnp4ZkhsWWJpYWtCb2lObHk0NS8rOHlD?=
 =?utf-8?B?VU5NbVNqU1FXdlZQVzUyZVlGd0d0M1R5c3lyYm1UZCs0cCtiZmp4UVpEaDVm?=
 =?utf-8?B?Vi9DYjU1dER2eEhjV0lDRzZKdm5hWUlOWmNYd3hFc0o1UUVDdkhkcXFPb1pV?=
 =?utf-8?B?K0pkTm05UEp2bUdwR1h4bkRXVExDeDJwTE1uSVdOSUNmbUhnK1hRNSt6YWxS?=
 =?utf-8?B?cTg1azFYVDFXc1BGdmFRdjVjOTVPMEp4SERHVHFrL2VaWWZySndVcldJQ0dl?=
 =?utf-8?B?Z2ZpQ1loVHUxWDRzWGw5UlQzMCsvNkpNUDJUQzdQUGdHbjFYZ3NGdVMyK25W?=
 =?utf-8?B?U2M1aEJRQ1VadlVhak1ld3MwMXZ4SGo0VFQreTd4Y2VaNkNqQU82ckVOMUpL?=
 =?utf-8?B?ekIrMHhSbG5UemxzajN5cjRqOWxmam4yN2t6dWhCNlhtWFBsS2QrY21td0Y3?=
 =?utf-8?B?Ri9VUXMvcURyS3dNdUdvTTIvMXdmbmorVGh0VE1mYmNCTkhzRkViYWZzRHFa?=
 =?utf-8?B?c2JGa0FySm5ObEphdFJueFROOVZhOFIzMU9rZHZwRmdKNytPMmRKTWpobGZK?=
 =?utf-8?B?TDV0MWtCbTFLL1RyYm5xdWdSNWgwSVlJVEVmSVB0c2FDRlQyYlNyV3VwMEhT?=
 =?utf-8?B?OTZFSndCb3o5RllvYXB0SlI3QXpiMmVKdk1BbnFHMDZCeTdCdFN4SWpuWmFa?=
 =?utf-8?B?cC9wL1JBYXVEeWgyZm42L0c4d0RYRUNKMGNlOFdTaUZvZ2d5bDJYeS80QzBB?=
 =?utf-8?B?SFNnSkxON04vODhiZGh5eUV0YWZ4aXorTTFwMVJKWEdmUHVOQ2RVcFVzTmtW?=
 =?utf-8?B?bmxELzYwNmdRN3FyTTVxMVZrN2JoaXMwdGRBZWNJRm92eEYwOGp1TTJZS3Za?=
 =?utf-8?B?eW80Y1RCV3ZyL1ZtV2d0ejJ0N2VBSW1BaGVyTWVBcmdzZW9vT2VmcjJGWkF1?=
 =?utf-8?B?bWcyb3VXK3NsNXF3aUluVTBJbk5aYkx0clVEQjFqZVFyOW1hVXB6Ry9JcVkw?=
 =?utf-8?B?N2UxallxNmgyaEliR1JHRFBxZ3ZzRDFoc29uQmpiY0ZMNWNXc05QdTdxQit0?=
 =?utf-8?B?eGYvdDdxNnBiYXZlbVVXQTk3MGhUcnZaanQrMGxpSVhyYmtKQVpmbjlpU2Np?=
 =?utf-8?B?MENiYlliN21xeTl1OU5kb0lLdTQ4TmxkdW1DcjBldzh6V2crSWdCUEt0OUxS?=
 =?utf-8?B?TUdMYzlFTXloZlptc2ZsR0twRU9WWjZuemxZbFdhQTU2THhxbzJJRG8vWFBF?=
 =?utf-8?B?YlJGMStkR29JS05tUGVHYmVjVU8ra2I1V3VqN2l5TUg2SUdza2NoSVUyN2JQ?=
 =?utf-8?B?K053UlozN2c0VGVKT2x6SmtJcktIdGVpWWJGMWM0MW4zQ3hVV0JKUVZYTkN1?=
 =?utf-8?B?b08zWFpLbGFaMWZHbDNwNnZCTkMxbHRlUnZaUzNsdEo3ZkM4bEhoWW1SczR0?=
 =?utf-8?B?T3hQQVlvVW1Gak1YeldLcXNLVlk3N0VMVWJRKytZNXZjWlYrcmFldlFIZ1RZ?=
 =?utf-8?B?ZkU3QjBQcGJNemFwWGFTTkp4QlV6dVk0QlRYNDN1ZUtRUnAxcEdaTjBHYW1B?=
 =?utf-8?B?QjQrQmxueVF3bnlZdjIzUFFIdVZrMTZZYmU5dHU2YkR5TU5Dbll3eVFoT2Jr?=
 =?utf-8?B?aDJwYmNzNmNDMTNTVmhpbDNleHl2dGlpVzhnNTJrWWs2SnpYVFl2cTRiNzBl?=
 =?utf-8?B?cHlKUVhxUzdFbGRHM3M3ejhlaTJkWmhrYmF0QklOOFpiQUNJV3lyMit0c09Z?=
 =?utf-8?B?SGlaWHVjY0sram9QbHczYlo5U1pZbWVTSCsvc1l4QjE4ZDFLVGVOS3NFYjhL?=
 =?utf-8?Q?4U5eU0niPKSKnvQbX2piwavBW/le3It8nJMLTqXu4looR?=
X-MS-Exchange-AntiSpam-MessageData-1: O4psZkhHQK7laA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c709af83-bcdc-4bf5-b94d-08decaec4c45
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 14:42:17.6860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C2aBqjZah9mkC0x2DiTpQaKnQrgp/l9cn0NsX4hZSxKq/VRGvubF66cyssP40Gx69Jk8mYPo6o0Z7MCTippUXw==
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

Currently, the frts vidmem offset is calculated based on the non-wpr
heap size and pmu reservation size, but this is not right. The layout
actually looks like this:

| non-wpr heap | WPR2 .. FRTS | PMU reserved | ... | VGA workspace |

It's just by coincidence + generous alignment that the values happened
to match. Instead, define a per-architecture reserved size at the end of
the framebuffer and use this plus the PMU reserved size to calculate the
frts vidmem offset.

Fixes: d317e4585fa3 ("gpu: nova-core: Hopper/Blackwell: add FSP Chain of Trust boot")
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/fb.rs           |  4 ++++
 drivers/gpu/nova-core/fb/hal.rs       |  3 +++
 drivers/gpu/nova-core/fb/hal/ga100.rs |  4 ++++
 drivers/gpu/nova-core/fb/hal/ga102.rs |  4 ++++
 drivers/gpu/nova-core/fb/hal/gb100.rs |  5 +++++
 drivers/gpu/nova-core/fb/hal/gb202.rs |  5 +++++
 drivers/gpu/nova-core/fb/hal/gh100.rs |  4 ++++
 drivers/gpu/nova-core/fb/hal/tu102.rs |  8 ++++++++
 drivers/gpu/nova-core/fsp.rs          | 25 ++++++++++++++++++-------
 9 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index facecb8b411f..2089fa1d7a22 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -304,6 +304,9 @@ pub(crate) struct FbSizes {
     pub(crate) heap_size: u64,
     /// PMU reserved memory size, in bytes.
     pub(crate) pmu_reserved_size: u32,
+    /// Size reserved at the end of the framebuffer. This is architecture dependent and used to
+    /// compute the FRTS offset for the FSP CoT message.
+    pub(crate) fb_end_reserved_size: u32,
     /// Number of VF partitions.
     pub(crate) vf_partition_count: u8,
 }
@@ -321,6 +324,7 @@ fn new(chipset: Chipset, bar: Bar0<'_>) -> Result<Self> {
                 .wpr_heap_size(chipset, fb_size)?,
             heap_size: u64::from(hal.non_wpr_heap_size()),
             pmu_reserved_size: hal.pmu_reserved_size(),
+            fb_end_reserved_size: hal.fb_end_reserved_size(),
             vf_partition_count: 0,
         })
     }
diff --git a/drivers/gpu/nova-core/fb/hal.rs b/drivers/gpu/nova-core/fb/hal.rs
index 714f0b51cd8f..aa50534550eb 100644
--- a/drivers/gpu/nova-core/fb/hal.rs
+++ b/drivers/gpu/nova-core/fb/hal.rs
@@ -41,6 +41,9 @@ pub(crate) trait FbHal {
 
     /// Returns the FRTS size, in bytes.
     fn frts_size(&self) -> u64;
+
+    /// Returns the size reserved at the end of the framebuffer, in bytes.
+    fn fb_end_reserved_size(&self) -> u32;
 }
 
 /// Returns the HAL corresponding to `chipset`.
diff --git a/drivers/gpu/nova-core/fb/hal/ga100.rs b/drivers/gpu/nova-core/fb/hal/ga100.rs
index 3cc1caf361c7..ce544cbafa2d 100644
--- a/drivers/gpu/nova-core/fb/hal/ga100.rs
+++ b/drivers/gpu/nova-core/fb/hal/ga100.rs
@@ -81,6 +81,10 @@ fn non_wpr_heap_size(&self) -> u32 {
     fn frts_size(&self) -> u64 {
         0
     }
+
+    fn fb_end_reserved_size(&self) -> u32 {
+        super::tu102::fb_end_reserved_size_tu102()
+    }
 }
 
 const GA100: Ga100 = Ga100;
diff --git a/drivers/gpu/nova-core/fb/hal/ga102.rs b/drivers/gpu/nova-core/fb/hal/ga102.rs
index 44a2cf8a00f1..82b4c6034c4a 100644
--- a/drivers/gpu/nova-core/fb/hal/ga102.rs
+++ b/drivers/gpu/nova-core/fb/hal/ga102.rs
@@ -48,6 +48,10 @@ fn non_wpr_heap_size(&self) -> u32 {
     fn frts_size(&self) -> u64 {
         super::tu102::frts_size_tu102()
     }
+
+    fn fb_end_reserved_size(&self) -> u32 {
+        super::tu102::fb_end_reserved_size_tu102()
+    }
 }
 
 const GA102: Ga102 = Ga102;
diff --git a/drivers/gpu/nova-core/fb/hal/gb100.rs b/drivers/gpu/nova-core/fb/hal/gb100.rs
index 6e0eba101ca1..a53932eaf483 100644
--- a/drivers/gpu/nova-core/fb/hal/gb100.rs
+++ b/drivers/gpu/nova-core/fb/hal/gb100.rs
@@ -78,6 +78,7 @@ fn write_sysmem_flush_page_gb100(bar: Bar0<'_>, addr: Bounded<u64, 52>) {
     );
 }
 
+// This PMU reservation size is r570-specific.
 pub(super) const fn pmu_reserved_size_gb100() -> u32 {
     usize_into_u32::<{ const_align_up(SZ_8M + SZ_16M + SZ_4K, Alignment::new::<SZ_128K>()).unwrap() }>(
     )
@@ -116,6 +117,10 @@ fn non_wpr_heap_size(&self) -> u32 {
     fn frts_size(&self) -> u64 {
         super::tu102::frts_size_tu102()
     }
+
+    fn fb_end_reserved_size(&self) -> u32 {
+        u32::SZ_2M + u32::SZ_128K
+    }
 }
 
 const GB100: Gb100 = Gb100;
diff --git a/drivers/gpu/nova-core/fb/hal/gb202.rs b/drivers/gpu/nova-core/fb/hal/gb202.rs
index 038d1278c634..1233df4303f5 100644
--- a/drivers/gpu/nova-core/fb/hal/gb202.rs
+++ b/drivers/gpu/nova-core/fb/hal/gb202.rs
@@ -83,12 +83,17 @@ fn pmu_reserved_size(&self) -> u32 {
 
     fn non_wpr_heap_size(&self) -> u32 {
         // Non-WPR heap for GB20x (see Open RM: kgspGetNonWprHeapSize, GB202+).
+        // This size is r570-specific.
         u32::SZ_2M + u32::SZ_128K
     }
 
     fn frts_size(&self) -> u64 {
         super::tu102::frts_size_tu102()
     }
+
+    fn fb_end_reserved_size(&self) -> u32 {
+        u32::SZ_2M + u32::SZ_128K
+    }
 }
 
 const GB202: Gb202 = Gb202;
diff --git a/drivers/gpu/nova-core/fb/hal/gh100.rs b/drivers/gpu/nova-core/fb/hal/gh100.rs
index 5450c7254dad..892c75ef26c6 100644
--- a/drivers/gpu/nova-core/fb/hal/gh100.rs
+++ b/drivers/gpu/nova-core/fb/hal/gh100.rs
@@ -44,6 +44,10 @@ fn non_wpr_heap_size(&self) -> u32 {
     fn frts_size(&self) -> u64 {
         super::tu102::frts_size_tu102()
     }
+
+    fn fb_end_reserved_size(&self) -> u32 {
+        super::tu102::fb_end_reserved_size_tu102()
+    }
 }
 
 const GH100: Gh100 = Gh100;
diff --git a/drivers/gpu/nova-core/fb/hal/tu102.rs b/drivers/gpu/nova-core/fb/hal/tu102.rs
index f629e8e9d5d5..8bafbeec9807 100644
--- a/drivers/gpu/nova-core/fb/hal/tu102.rs
+++ b/drivers/gpu/nova-core/fb/hal/tu102.rs
@@ -52,6 +52,10 @@ pub(super) const fn frts_size_tu102() -> u64 {
     u64::SZ_1M
 }
 
+pub(super) const fn fb_end_reserved_size_tu102() -> u32 {
+    u32::SZ_2M
+}
+
 struct Tu102;
 
 impl FbHal for Tu102 {
@@ -82,6 +86,10 @@ fn non_wpr_heap_size(&self) -> u32 {
     fn frts_size(&self) -> u64 {
         frts_size_tu102()
     }
+
+    fn fb_end_reserved_size(&self) -> u32 {
+        fb_end_reserved_size_tu102()
+    }
 }
 
 const TU102: Tu102 = Tu102;
diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
index 6778e5546cee..fed9d1e4eeda 100644
--- a/drivers/gpu/nova-core/fsp.rs
+++ b/drivers/gpu/nova-core/fsp.rs
@@ -132,20 +132,31 @@ struct FspCotMessage {
 }
 
 impl FspCotMessage {
+    /// Computes the FRTS vidmem offset for the Chain-of-Trust message. It is measured from the end
+    /// of the framebuffer.
+    fn frts_vidmem_offset(fb_info: &FbSizes) -> Result<u64> {
+        let mut offset = u64::from(fb_info.fb_end_reserved_size);
+
+        if fb_info.pmu_reserved_size != 0 {
+            offset = offset
+                .checked_add(u64::from(fb_info.pmu_reserved_size))
+                .ok_or(EINVAL)?
+                // The 2 MiB alignment is r570-specific.
+                .align_up(Alignment::new::<SZ_2M>())
+                .ok_or(EINVAL)?;
+        }
+
+        Ok(offset)
+    }
+
     /// Returns an in-place initializer for [`FspCotMessage`].
     fn new<'a>(
         fb_info: &FbSizes,
         fsp_fw: &'a FspFirmware,
         args: &'a FmcBootArgs<'_>,
     ) -> Result<impl Init<Self> + 'a> {
-        // frts_vidmem_offset is measured from the end of FB, so FRTS sits at
-        // (end of FB) - frts_vidmem_offset.
         let frts_vidmem_offset = if !args.resume {
-            let frts_reserved_size = fb_info.heap_size + u64::from(fb_info.pmu_reserved_size);
-
-            frts_reserved_size
-                .align_up(Alignment::new::<SZ_2M>())
-                .ok_or(EINVAL)?
+            Self::frts_vidmem_offset(fb_info)?
         } else {
             0
         };

-- 
2.54.0

