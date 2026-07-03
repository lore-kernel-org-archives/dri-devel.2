Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C6B2C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 10:23:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B317F10F777;
	Fri,  3 Jul 2026 10:23:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="b2pOA9z2";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012023.outbound.protection.outlook.com [52.101.53.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A651B10F783
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 10:22:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqoyHGrxYt+pbAD/0A86cwjX1RWWp1shYePhLmw7YqvN4DWzPRCoins//x/g5OCGRUMzR5kAePf/eGB92LZ4thWNHaRRbwOT3guscJ7cJKJlxnswikv172867hzP0WRUPhqrY5c+vEbL5mSm7wTcvPh4IxENSUozaY88sY9kIOqMHn29s7Wd7TdvzGKI/H9uv5OvxKJnKMYc8FyOe4ujmOGz01PIlbbwCBxlpAvNml7EFxt8Bg21KVjGk2LBTtpVR3zhtlzxoIUpUv6+ObHQ3LhMzGQABSdxtm7jGZSuy9SII/PQ7lg5CwzludbYsIwcq7f7JxqFwMXTIzfW1bSrqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e194jysV3KL770YbovHXAphbFYu+QVn/EBW4p2KLZXo=;
 b=v1nDghU71QMmJ8AAUlJEprQfMlyH6u/3t46dCGFNPu5lcoW6khgGO2H5CWNEO3hP/lvBfZisbiUW11fr07xTFNLvseefCvTTBm5feUHOV9sFUY4KM4XfNld4VBjYV5msB5WSb75w6qxm5xeyke3e+XkzY98y6NNb60FwEZHMnoisy76257hbpEsTbCGmxBaXYAj8wT/r/Kgw9tWJwfyG7vQwDyYMBnTogoNixdEb/qq3MF3JtDXt/kTb0XaSnifFhGjqHF9+Ajrb2rZb+qG2MW5MbbT2BWiZGYTXKq0mep6wdRUz83fUo+2P9BCiiuIbtF4dKNP63PaTTwzCc4nsvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e194jysV3KL770YbovHXAphbFYu+QVn/EBW4p2KLZXo=;
 b=b2pOA9z2lZKbRGv7XrNZgbR6QlxbQg2IZ1KL6nGetV9avWC+owx2OiWwl6sBUdWpgB3PgNJtVGuxTxiLCsjRUfxuttPSmWy9IEpV5lJiwsCRxP8d8R1iX3JqvfI99Ykkr2OzBICPF07AjKIuubkd9e5FgU+I5/ub/Z3U7os5xjmmoqmAg2f/i/BXGM7QUCSGcbw162z6lDPNGB7aD1HLzR6FhBHwKaLYcAefVRCpU4DogKENGXkvHOjw9KO4BKhEeQhoiBH9oMub+kMKvxPX+jVmxmfRr8XaK+a2u6ZH7jr4j9PNXkcCWzRc212/P4F5HH1ZG//kZPUK7/Hv8i+PBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DM4PR12MB6326.namprd12.prod.outlook.com (2603:10b6:8:a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 10:22:55 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 10:22:55 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Fri, 03 Jul 2026 19:22:12 +0900
Subject: [PATCH v2 08/10] gpu: nova-core: return non-WPR heap size as u64
 from HALs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-blackwell-fixes-v2-8-8e3d8bc32bb9@nvidia.com>
References: <20260703-blackwell-fixes-v2-0-8e3d8bc32bb9@nvidia.com>
In-Reply-To: <20260703-blackwell-fixes-v2-0-8e3d8bc32bb9@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0116.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::8) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DM4PR12MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d55fa06-1d8e-4f9c-f638-08ded8ed0ba3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|23010399003|7416014|376014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: B2UgSq2ougv0lyNwL/uEVVuUa6YVh+XpKyFe2iM+t92bjU+O6wEpb+1/pDsaAifi2yEsm3DkoFlsZAZv/eyK71GbwVVxwXx1Jyy3sTMfsmL/d9yGRwtZkynCuGHP+nLmEo19i69j6mPKBTsSwCeeUffrAF2EOAgP+H5Xg5IrzST9EeM1gPkp57zFMnWbndKoLUApZVzf3sed6Ihi/bKE+7ISJwjOeQa3S94XGGwFb3Ka8hCEfHjvtMsZ/zdwHQJGJSTDxd+u5nhGBVvXtYRWLwg+KixXnMQtzGMVdVbSXgh1OT8hagzI1vDhglHeKLyHPHGv2X2YRYnHcuEj8I3w16iL/0hLBf5DHSsKpL6tF1amdtY+yTHsEKpgTCgaqxxcGlS3rcK7cOI25iOj+jUsKYKHk1tijQ2QrBvgUE6OWJCqIQAwvqYd1pPyyqQhEAH3eXt+leqJti/LzxSTzmN50+W4e9LoNnBaARXdGlttQeDm6YqAv5oPwDKbutVAQ9mNcu+gqTdEiOQ1Tzivp5oL1vZ4gp5MdhQ0mUQnCrdscAj5E6vkLp9/vyfMbFhkaJiJiw2sMM5fWZWL9L/ziwHIib9fZJwTvUAoyV629yoB22LyfKnlLNe5YsKISD+GFJeffkhOdiSon+ZXDewuJb0ymTwXFZbyWaEKdtF9thnFld8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(23010399003)(7416014)(376014)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkU3WmFNckpnVmlVd2Z4bXhVZmJZNjFZWnhpanhCdTJXVTdMMjFNQ3RDczFk?=
 =?utf-8?B?SUtVMzJXTmF4K2VaWk40ZEZ5RnJTRWFDQ1NtbkFNeGJqWFI0VVlYSmU1Q1ha?=
 =?utf-8?B?SDZuVW43TStLWndsclpBZnlMcHZFMWR6ZitJMFI1dXlsV3ZKTlRrdytPL3Ew?=
 =?utf-8?B?OXJQU3g1WTBRY0V1c3lnYWhDbnNuY3hMMzBrQ1NUYytQRnFUMTU0azNvZDFP?=
 =?utf-8?B?aFFlQVZiSUU5UERGcmI3RFVINEVWREwxK1ZDeGtFSTlaZEpuUGhabUJZNU12?=
 =?utf-8?B?eUdxaDZORVFEMC95Skk1OGRBVW9KNnlMcWk2Q2ZnN3lNakVTWWEvWVRkMjd1?=
 =?utf-8?B?d01QR2lVQzN2MkVyN1Y3aTlSZ1NZVEkzRU9CQmtlbWhrTmdqQmFvVXdCamRZ?=
 =?utf-8?B?TnlIdmNHdFBGK0w1WWU0ZU5kb3RiRWJmYWZvOGNHdFVlYkNlRUdRU2NMWVpE?=
 =?utf-8?B?K1VkbVlvNEZkS1hMMjNJZ2RWOUpnaHl1TFY5NTJ5RkM3NEt4NzRPWVNLWVkx?=
 =?utf-8?B?SWh5MDh1Z09oZFc4Q0tkY0NzZTdmODFBbnd1Ujg0Ni90eDd4aVdiT1UzRi9j?=
 =?utf-8?B?RnRoWk9oMXJuOGJ4WmhXTjZYTUp2S3djNHZLTCtWc0VhZGFKeWxLUXhtbGNT?=
 =?utf-8?B?VnIzVkdzQ3BXd1p2ZFhLdGplaE1IUTloZnV4eU9uODZrL3FlU0FWcHh4cjdy?=
 =?utf-8?B?QlBvUVVESGJKS1NUYmRvc3ZPV1owelVFU3N3ME5SVWRLbjFQWDY2VG85MFhC?=
 =?utf-8?B?UXh6Y2U1STllZFpKY05iU2t0N2p1bEhBTlhGaUZwWkF1UjlRWTF3aUVVbERk?=
 =?utf-8?B?bEVPMzJ5TGRjL0RmYmtjMjRxMjN5akxiNXNMUUp5VFlWcXpneW10YXk1RmZP?=
 =?utf-8?B?QjhpRDhwK3MyU0sxV1NEWXFkSm1vMU9hdVhpOGdZUm0xOEk5SmVRRHhhbmFz?=
 =?utf-8?B?dXJ1dDBrZjVyOGppVG1WNXhVT0dwZmthR3RUWVJUK0ovcEZjbWQ1NW5nOUdC?=
 =?utf-8?B?SVA3WE5UbHVOam95YmdUeHJia2V5WkFrd3FwSWFRZ2xsaUN6RjFSNVdja05x?=
 =?utf-8?B?b1NuTnFLS2phb0gvajd4K0g2RndmT2hlMzdNTE12NUduT29BQURZeDRGcXdW?=
 =?utf-8?B?MTJaUk0wdDhpa09GcThMZTBBc0YydVMwcWlZUnVkOW8yd2thUGRTOVNrOWhO?=
 =?utf-8?B?NFU3Z3BPWG9qK2RHMG1lbFlnajN3RmJDQUt2ckcxMi85cVYzVk9tTXRMQnZP?=
 =?utf-8?B?b2c1ci80Zm1uU2RxeUpWUVlDTHVvaEFIQyszbHBHMW8xWWZObjd2c0Z3Mnc3?=
 =?utf-8?B?RDdkNzNMNmEwaWplcWprZ2xBeHJQWkUvSFRkemlkazl5bHROMVdxTnc1T2Zq?=
 =?utf-8?B?a0h0SSszbGEzYkgzSktHVEc3TFhuNjBIM2V6eHNWeTBtdGJvVkFXWGRqYXRt?=
 =?utf-8?B?YWxwV1U3T0RyV01IcXFqWDVFWGtnRjFNZEdHTXBUdzV0UE1qZ09tTmFzblVM?=
 =?utf-8?B?NVNLVXYyTW13K3ZZTVlEMUcyUUZpZGlVUVRDRllEMktrZ012VVEydUlXTktl?=
 =?utf-8?B?YnJEOHViMTRybWZNM0t3VlYxZnE4VDRUWUZCempJQUN0VjRaNndsbHpBajhE?=
 =?utf-8?B?SEJPaGdzS0RJRk4wWE0wZFhWbHk2NWlibHJjZmZGRmxsWjJ0UDZCOCtGSmlV?=
 =?utf-8?B?VkJZeE9qeHlNakhFejRGZlYwVldZc1I5QXRRZ1pzdCtjbXpJQVhMNjg0eUF0?=
 =?utf-8?B?bHBpYUxDai9LYnlsUklkTmpUUzJZZnRZVEhnUXZiN0xEeVJ6NmoyWTlEdkpw?=
 =?utf-8?B?UUs4N1J3dGZzU2ZWaWFrVVNnczFOanNrVmFrcU9zK2VLazdiSGFhUkdTeGJz?=
 =?utf-8?B?M2hwTEN5UDR2TTQ0dGJxU25mWHhjUmJuR2M0emZRakF5Q1doTUlhNkpPdTFt?=
 =?utf-8?B?engraUxrL09uREt6eng3U1BHWm9qRzlaN1F1QVVpS2JML3hXOXI1SVBSRWZX?=
 =?utf-8?B?K1ZhdlMrSzZBM2JRak0xSnVTT00raFJiVDhpUitOclRzWjVjb2xOajNkcXZs?=
 =?utf-8?B?bmduNHN5aktRZnhUQkd1bHpSMk82Mk9NZUJqZkdVVkVQa2pDamVEcWhkZ1gr?=
 =?utf-8?B?QWpGL3F1ZFoySG5sY3FYSTVzWFhobU9uR0hUVzNzb2VsM2hya1FxT2Q3U0RS?=
 =?utf-8?B?OXRIeVprMXlBbXZMalRWM0ZFU1dNODZLZ1dDUlVsdGRsbjJ3eDBFeFZ4VHZL?=
 =?utf-8?B?Q3Y0T0lnTkw0M3hIeXJUNjdPc1B5QkNxSyttSmpPejNXK0ZwNWRTaEQyczNy?=
 =?utf-8?B?SFR3ckk4VysrTUlEZjlUS2pCWFMvU2xuNnhrNnBJVXhmRGYybjR1SmwvMWRj?=
 =?utf-8?Q?ozbk7OGVWGsIoE+5OZnuqjhPS9t18hCVG2CBWaAJEfe7T?=
X-MS-Exchange-AntiSpam-MessageData-1: UIDWtcaOBK7qOA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d55fa06-1d8e-4f9c-f638-08ded8ed0ba3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:22:55.0187 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dlYIIVPceqSBtzN4csv9pJpn/ryzKqFepznHOV5qbUfBM4qFuPQJ9j0J5CGLOCEvmr5CgXEO0e/IkU5wY5x8YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6326
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

This is always immediately widened to u64, so just return it as a u64
from the beginning.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/fb.rs           | 4 ++--
 drivers/gpu/nova-core/fb/hal.rs       | 2 +-
 drivers/gpu/nova-core/fb/hal/ga100.rs | 2 +-
 drivers/gpu/nova-core/fb/hal/ga102.rs | 2 +-
 drivers/gpu/nova-core/fb/hal/gb100.rs | 4 ++--
 drivers/gpu/nova-core/fb/hal/gb202.rs | 4 ++--
 drivers/gpu/nova-core/fb/hal/gh100.rs | 4 ++--
 drivers/gpu/nova-core/fb/hal/tu102.rs | 6 +++---
 8 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index 431828cad1a1..815ca0c79287 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -273,7 +273,7 @@ fn new(chipset: Chipset, bar: Bar0<'_>, gsp_fw: &GspFirmware) -> Result<Self> {
         };
 
         let non_wpr_heap = {
-            let non_wpr_heap_size = u64::from(hal.non_wpr_heap_size());
+            let non_wpr_heap_size = hal.non_wpr_heap_size();
             FbRange(wpr2.start - non_wpr_heap_size..wpr2.start)
         };
 
@@ -323,7 +323,7 @@ fn new(chipset: Chipset, bar: Bar0<'_>) -> Result<Self> {
             frts_size: hal.frts_size(),
             wpr2_heap_size: gsp::LibosParams::from_chipset(chipset)
                 .wpr_heap_size(chipset, fb_size)?,
-            non_wpr_heap_size: u64::from(hal.non_wpr_heap_size()),
+            non_wpr_heap_size: hal.non_wpr_heap_size(),
             pmu_reserved_size: hal.pmu_reserved_size(),
             fb_end_reserved_size: hal.fb_end_reserved_size(),
             vf_partition_count: 0,
diff --git a/drivers/gpu/nova-core/fb/hal.rs b/drivers/gpu/nova-core/fb/hal.rs
index aa50534550eb..ff05292a3a19 100644
--- a/drivers/gpu/nova-core/fb/hal.rs
+++ b/drivers/gpu/nova-core/fb/hal.rs
@@ -37,7 +37,7 @@ pub(crate) trait FbHal {
     fn pmu_reserved_size(&self) -> u32;
 
     /// Returns the non-WPR heap size for this chipset, in bytes.
-    fn non_wpr_heap_size(&self) -> u32;
+    fn non_wpr_heap_size(&self) -> u64;
 
     /// Returns the FRTS size, in bytes.
     fn frts_size(&self) -> u64;
diff --git a/drivers/gpu/nova-core/fb/hal/ga100.rs b/drivers/gpu/nova-core/fb/hal/ga100.rs
index ce544cbafa2d..16ef0e0d2c05 100644
--- a/drivers/gpu/nova-core/fb/hal/ga100.rs
+++ b/drivers/gpu/nova-core/fb/hal/ga100.rs
@@ -72,7 +72,7 @@ fn pmu_reserved_size(&self) -> u32 {
         super::tu102::pmu_reserved_size_tu102()
     }
 
-    fn non_wpr_heap_size(&self) -> u32 {
+    fn non_wpr_heap_size(&self) -> u64 {
         super::tu102::non_wpr_heap_size_tu102()
     }
 
diff --git a/drivers/gpu/nova-core/fb/hal/ga102.rs b/drivers/gpu/nova-core/fb/hal/ga102.rs
index 82b4c6034c4a..8653d0d404d8 100644
--- a/drivers/gpu/nova-core/fb/hal/ga102.rs
+++ b/drivers/gpu/nova-core/fb/hal/ga102.rs
@@ -41,7 +41,7 @@ fn pmu_reserved_size(&self) -> u32 {
         super::tu102::pmu_reserved_size_tu102()
     }
 
-    fn non_wpr_heap_size(&self) -> u32 {
+    fn non_wpr_heap_size(&self) -> u64 {
         super::tu102::non_wpr_heap_size_tu102()
     }
 
diff --git a/drivers/gpu/nova-core/fb/hal/gb100.rs b/drivers/gpu/nova-core/fb/hal/gb100.rs
index a53932eaf483..93fe708895c5 100644
--- a/drivers/gpu/nova-core/fb/hal/gb100.rs
+++ b/drivers/gpu/nova-core/fb/hal/gb100.rs
@@ -109,9 +109,9 @@ fn pmu_reserved_size(&self) -> u32 {
         pmu_reserved_size_gb100()
     }
 
-    fn non_wpr_heap_size(&self) -> u32 {
+    fn non_wpr_heap_size(&self) -> u64 {
         // Non-WPR heap for GB10x (see Open RM: kgspGetNonWprHeapSize, GB100/GB102).
-        u32::SZ_2M
+        u64::SZ_2M
     }
 
     fn frts_size(&self) -> u64 {
diff --git a/drivers/gpu/nova-core/fb/hal/gb202.rs b/drivers/gpu/nova-core/fb/hal/gb202.rs
index bc0832ce04ab..c952480db34f 100644
--- a/drivers/gpu/nova-core/fb/hal/gb202.rs
+++ b/drivers/gpu/nova-core/fb/hal/gb202.rs
@@ -69,10 +69,10 @@ fn pmu_reserved_size(&self) -> u32 {
         super::gb100::pmu_reserved_size_gb100()
     }
 
-    fn non_wpr_heap_size(&self) -> u32 {
+    fn non_wpr_heap_size(&self) -> u64 {
         // Non-WPR heap for GB20x (see Open RM: kgspGetNonWprHeapSize, GB202+).
         // This size is r570-specific.
-        u32::SZ_2M + u32::SZ_128K
+        u64::SZ_2M + u64::SZ_128K
     }
 
     fn frts_size(&self) -> u64 {
diff --git a/drivers/gpu/nova-core/fb/hal/gh100.rs b/drivers/gpu/nova-core/fb/hal/gh100.rs
index 0ac36d858791..16a3e3b6e3b1 100644
--- a/drivers/gpu/nova-core/fb/hal/gh100.rs
+++ b/drivers/gpu/nova-core/fb/hal/gh100.rs
@@ -61,9 +61,9 @@ fn pmu_reserved_size(&self) -> u32 {
         super::tu102::pmu_reserved_size_tu102()
     }
 
-    fn non_wpr_heap_size(&self) -> u32 {
+    fn non_wpr_heap_size(&self) -> u64 {
         // Non-WPR heap for Hopper (see Open RM: kgspCalculateFbLayout_GH100).
-        u32::SZ_2M
+        u64::SZ_2M
     }
 
     fn frts_size(&self) -> u64 {
diff --git a/drivers/gpu/nova-core/fb/hal/tu102.rs b/drivers/gpu/nova-core/fb/hal/tu102.rs
index 8bafbeec9807..d98974827373 100644
--- a/drivers/gpu/nova-core/fb/hal/tu102.rs
+++ b/drivers/gpu/nova-core/fb/hal/tu102.rs
@@ -44,8 +44,8 @@ pub(super) const fn pmu_reserved_size_tu102() -> u32 {
     0
 }
 
-pub(super) const fn non_wpr_heap_size_tu102() -> u32 {
-    u32::SZ_1M
+pub(super) const fn non_wpr_heap_size_tu102() -> u64 {
+    u64::SZ_1M
 }
 
 pub(super) const fn frts_size_tu102() -> u64 {
@@ -79,7 +79,7 @@ fn pmu_reserved_size(&self) -> u32 {
         pmu_reserved_size_tu102()
     }
 
-    fn non_wpr_heap_size(&self) -> u32 {
+    fn non_wpr_heap_size(&self) -> u64 {
         non_wpr_heap_size_tu102()
     }
 

-- 
2.54.0

