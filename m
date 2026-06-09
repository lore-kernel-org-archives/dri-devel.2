Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A7B8CD8CAD
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:04:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71ED510E16B;
	Tue,  9 Jun 2026 08:04:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="QfXKkKwB";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010044.outbound.protection.outlook.com [52.101.56.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BE8410E16B
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 08:04:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FYc+6P8MuZD3bhTs9Xi/5nkRxjyH7GBjNK2gQouXYjPnyqzAPIKB2USxc15T2vL0Oi7ejLaYnYOC9psL+MtUOQcFKfPlegNIuGSUZZvSW+QJfb6saGgesyLCUatf8aYAbLXgMvYmMvQo26xn2l/b802FSQIgMw+FckC48fPgnvot0GVJ0g5vmdPhidyWjpHN2+AVu4GXshULX8kmjs1EaLpjQA3ZW871/y8iNKa56KtdRDKdef50UfgpIrevwzYrI8/C9JrwG2OxvPlQ9ry3Jh9TTc/pUUZQ6V6Aje9Hl7Tk9VggogXTKQ629n1eMdfM2+fW+iHOoEA6RZ8sfCf8xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1hUJZJy6TpcZdYi4FbTKyhbheQfILwuxNZodiBZ97c=;
 b=iH3HZgiDrwsLxaHCgtvvqH4Mt2I85hwD8k83v+T9K23Epff9b99QswSfdioAnAfcNU/VIpmzBykrZaeOO72QaDWI7CtIopFrNxl6OXj1tR9UoRkUXOdF7feX/6cwIB+j7KJUhdrXjKB8GBKxIUB9XFF+DMdB7KPwr6R8QGCiKm24voFOQI1BLYftw8JTV4pUN48zoSeQ4UjpB67eA9Z52uh/gOyFeumA8JKwN6lrEuvYiKSIUl+TEvT/+2gCxHn2zUw3/+yzKt6LZi4F92uz3SOiUIaVT1SznkE2BizhZtfqx4mWq4v3AkC04J+oddvFFVrOVct3XJqGNYjPTEVmVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1hUJZJy6TpcZdYi4FbTKyhbheQfILwuxNZodiBZ97c=;
 b=QfXKkKwBR6kU/pmd3RzAlDNt0rtJ0HYkH//dcKNIJP+/zn3TmIt0MTo3+eZTAYQ9OEVyYtwmmDoi0k+ELCtykxgXqA5Jy/StOK7ah0abh49i2Ve3PjGJ7o+HIFsgc2y/WhEu8oxwfT1hqjAnrU+aalXUc+1VJSxtOHhgEZJPX+X5d4MDlV57mqjEsaa8ZUHS6Alin7QXgA6S2SCw+50ynv5I+Z9jqIP0npCyKAkmvxkMpOM5pQHGQD19kzJyJcwm++WBLLslXMfeY/WrOA9ELn9FqMo3e2JIqfl6LL5RJV8bJXDx1+R8aT6BS7FdCvZ6rTJQ/AJ1C14XQATtAfiliQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA1PR12MB5616.namprd12.prod.outlook.com (2603:10b6:806:22a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 08:04:20 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 08:04:20 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 09 Jun 2026 17:04:02 +0900
Subject: [PATCH 4/4] gpu: nova-core: gsp: Expose total physical VRAM end
 from FB region info
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-boot-vram-v1-4-d9382610507a@nvidia.com>
References: <20260609-boot-vram-v1-0-d9382610507a@nvidia.com>
In-Reply-To: <20260609-boot-vram-v1-0-d9382610507a@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0353.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA1PR12MB5616:EE_
X-MS-Office365-Filtering-Correlation-Id: 175dac2c-eef1-454c-8cf4-08dec5fdb5f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|7416014|376014|22082099003|18002099003|6133799003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: fRNZMlm7bUSF95LGyDksTPVQ8jgNT5a+F0GloifheRqryTbFz3aO5GJTNOTF6zAJrHAAN31rdsSDSzYKCpbI50mnaqPZ76c6/ZWqEyHSeoPUp5oqhGNV1ltT/YRuHMsITeGgEqBArLrnbvPJpSz3XBYh2RvJQkqO1qj16MvOe4EgNsHs+oKaleHq0ez6QYlDymyooqkQTJ+l8UeV8+aXUUXe5E5/a7v3ZzMccSDSDeTlSnOdthIxSbuebXDYNtlU/vQicJlAv3DX6SO5Mk0Nj7FDtxasXXP36HzLyWb1CLN9S6gi4rMVqYsgsjiNePrMZPUNj0Iwlx/Ckqhkaf2bM5MYZeez97Hhz2+1Rcu8IK5RkJwGTu8VP41jBKa1LmD3NSpVZtf3MAXKC91tuWjPX2fe3PqxUmcoxTrvW5VXWvJUNNkm6BDW7Lf9I4HaGci2tkJUQPKhVZdF2SKLWMOP136Ac/FXhqB2+82sZJrMRasLSUFVKKveWFQso4ITANaV1UDDBpfqdYyj9BxRB+8ppmSyHoWczuUSbl6nfVhldPkyO4Q4FT0G04N+Ep4dkT7D5uw0sxmQJ3wViMiAvF/o+aSQPIu5Muuxt5P7/W4DcEXwSRJQ0Hq1XjNJT/KE3EEjc+rf6keA+BhTLiMv45RgWx6V6NzNLQ7F9EwZDNAjl8vU8JhJruNJvXRRbDcvglDO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzA0RzFCdlZHMWVLODlKR1d3UGR0T2s1dm0xNFg5Ukd3dDNmUC9GaE1oVk1o?=
 =?utf-8?B?Vkl6aWJWRkdrS0dyT2tCektFMXIxbmRRcE5sOWdoemlPMXNDZlA0Rk1xbE9n?=
 =?utf-8?B?cGtZTFYrQ1gxZi9hVldmK1dsbU5zd3h6akNDdGluRUxYUytTMUEzVklvMVVJ?=
 =?utf-8?B?eHlaME1mKzUxcXg5TXhHNFgxM1FCSEFQNG9KeDRuSlp4UnJHUVBOUGZVNWdj?=
 =?utf-8?B?bWEvTUFCQ040c1M0TDY2cnRGMk0xYzdSQ3V2d1d4aGsrSzB6dGt6MUxJQnRV?=
 =?utf-8?B?NWZHQm95UkppWWdGOVFmWjhQOHI5NkkySDJ1aTBHRFVHRW1XZUxDZzZoUU03?=
 =?utf-8?B?Y2pXb2tZSVBIcHdIODN3Vit6a0J5WDJ6QlYwUEhMN3lMNEtOU1BRcjRBVmRG?=
 =?utf-8?B?ZnhUR3A1ZUI5UnFRTzJvbUpoOXFXTC9yTnorS1o1VDcyYzRnK3ZoWCs4QzAy?=
 =?utf-8?B?M3J3b3cya3N3T1RSOUxVYVcvbVM1ZWVoeEJycmhPTjJySTl2enFQR2owTDRm?=
 =?utf-8?B?NnZackVXNFhHK2RHaXBqVlJwNzh1djdHVmlIZVpKWWh3c0pkRWw4RGpRL3FC?=
 =?utf-8?B?QlZDSXRZMzA2NmhUOFhuUUtZQ28rMkVSakNnaFBaSFZvcmIrQVZSeldhdDNw?=
 =?utf-8?B?eVhEcUhhUXhyc294UEhtMVpBQzRYYUhrVTV1c29SZVJlUm1nRUxucXBFM1E4?=
 =?utf-8?B?MVdFRVZtU2lGbXBFK1BvdTZJTmlJcWsrL0FXMGQwNE9UYU41b2IyNy84dHp0?=
 =?utf-8?B?OFAwZVV2TGlzRHYvMTh4QXJxZFRzV0VGTWJGeXV6ZmYrZnlzNUhHdnhBNmV0?=
 =?utf-8?B?UnE1dktrVitmVXEzc1l5dkhicHN6WlgrT3RueUZMbVcyaUZvaXhCSCtuaW82?=
 =?utf-8?B?ZzVyUmlNR2JXVU1DVlN2eDNFQUFCQTZiZUZLNDNJZXB6Y3lTa29nL1h1d21M?=
 =?utf-8?B?V1RkZEs5WlJIYzcxV3JxZGp4L3VGU011VWwxblRJNWR1RGc4eUtZVU5BOWNI?=
 =?utf-8?B?Qkt5SzFzWlREelA0V09uWFdxZUxYb2ZtVmthcGl5YXBURG05cGdLVDJRM1dD?=
 =?utf-8?B?TElKK1F3cHVZZUlKeHJmVkVzSFMrWjlWeHlmQWN2ZG03NWNyb0RzVE1hcDQr?=
 =?utf-8?B?enlsa0VmRVFFQVdjVkZpOVRIOWNvb2JSc3hiR1VaWTZwYlBtcG5kNXcrdnFD?=
 =?utf-8?B?c2tjV25TaW1LVzd5TEhMVGF6SnZSMHNvSnBnV3doS0xoZVpaNXBoZWlQQjVE?=
 =?utf-8?B?MlVhSU8vNkhGM1E5QTkxd0JKeUUxVU41MUFGVUJDN05DNEYvaHk5V2I1dXN2?=
 =?utf-8?B?WTNDZS9NSEs5cUh3Vk9BMGpyN0NYSWk2SXJhZ0pKbi84bnNGZUI2eU5BUjhr?=
 =?utf-8?B?NjN3TVFnWTFPNm42NWM3SkthWjN0YklaZjhOV0phTXAzMTd6RXNpUVFrcVpk?=
 =?utf-8?B?WTA4bUJEbUwrbHU4eFB0blE4ZGoxZ2Q5cDl1b3F1ZU1mVWdnakNRd0xrODJW?=
 =?utf-8?B?UEJLZXI0VUxTaklIVU5GdGMyRFpmVE45WUdVbEowVW9ZVjZMTWMxa1BWbXJW?=
 =?utf-8?B?NWtTZjlMWkJvS2U0YVNWZmQ1d3BMbVZvR0FJNndGVTBDa3dxNUtTdUZHUHdk?=
 =?utf-8?B?RTJYMUpaaGFVaWVVMmVFSmVvcEJrTEZPZEQvV1B1VTJ6UjBGSTBYK0pZTU9P?=
 =?utf-8?B?eXM4Q2lock1aSzNDSmRrZERXOENpYU15WHE4ekQ0SjdmUkdHTDN4aUVEZjFG?=
 =?utf-8?B?WFgwUk1NVHFic0lzaDl2U0ZpV1hPbE1CUE1QYzZEWW5BMC9RNUl3WHJVazI2?=
 =?utf-8?B?Z2tJWkhQbThES0dFcnN2eW9ETHhRQWkwSC8xOGRGeEl5TkFZdGdnbE85Mmcx?=
 =?utf-8?B?eE1raWtDM0hucE5TVnN1U2F5WnVrV0IrQ3VkZjJ0MVRmZFZhRU9YdFpNVGtr?=
 =?utf-8?B?dGRqa1ZOd1lPTVIxWm5ndjNiVlE4NStRMHdUc2pmMUIyVWZuMXViRUduUWUy?=
 =?utf-8?B?cEFkUm53RHlhZGNLeXltVDVwYWV3NHc2RW5VcGJva3ptakV2THVFeVdOYWxI?=
 =?utf-8?B?bDVqMkR2dWlIK2t6cUlWVGpUWi9lYWhGODZNUW1MNkZXT1NTRFVlOTltdUpX?=
 =?utf-8?B?dWg0QjlmTWVCcG14ZDR2RVVJWFdJdFl3R3pQeDF5cWdmai9TSzFXTDdkTjQv?=
 =?utf-8?B?eWRGRURPZ3RqTytSSEZNMzJCYkgzdTViZkdidVNSUEtuZXRTNnk3ZExUSnZu?=
 =?utf-8?B?aDFqZkdjdGphSXVhYnU1c0xDNm9pcTNFNXUwOHhFd1pzNkw2dzNnSzNlSDVR?=
 =?utf-8?B?eG8zNDVrM3RFMFI4cEZ3d204MXNnMWxoV3BDaFJKcGZIVFI2K1ZMMGlFUTU5?=
 =?utf-8?Q?I6YE7m/lcXZPeid4L5MzyrY5rnN68R3rMTWkl++1vEzLt?=
X-MS-Exchange-AntiSpam-MessageData-1: UNl4HhMgp93P3w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 175dac2c-eef1-454c-8cf4-08dec5fdb5f2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 08:04:20.4447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LkC8KYO4x2Rs9ugp7Ry0nHF0RGArcRUVsidVyNtwVW84lBMia7OVQ6K7E0dOu+dW9vkylKqOZgCZ5dX5E/P00g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5616
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

From: Joel Fernandes <joelagnelf@nvidia.com>

Add `total_fb_end()` to `GspStaticConfigInfo` that computes the
exclusive end address of the highest valid FB region covering both
usable and GSP-reserved areas.

This allows callers to know the full physical VRAM extent, not just
the allocatable portion.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs             | 5 ++++-
 drivers/gpu/nova-core/gsp/commands.rs    | 5 +++++
 drivers/gpu/nova-core/gsp/fw/commands.rs | 7 +++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index a0cb36cdeeea..a357a5e60613 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -9,7 +9,8 @@
     io::Io,
     num::Bounded,
     pci,
-    prelude::*, //
+    prelude::*,
+    sizes::SizeConstants, //
 };
 
 use crate::{
@@ -368,6 +369,8 @@ pub(crate) fn new(
                     Err(e) => dev_warn!(pdev, "GPU name unavailable: {:?}\n", e),
                 }
 
+                dev_info!(pdev, "Total VRAM: {} MiB\n", info.total_fb_end / u64::SZ_1M);
+
                 info
             }
         })
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index d955f52a93bb..6623c7acf7cb 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -198,6 +198,8 @@ pub(crate) struct GetGspStaticInfoReply {
     /// Usable FB (VRAM) region for driver memory allocation.
     #[expect(dead_code)]
     pub(crate) usable_fb_region: Range<u64>,
+    /// End of VRAM.
+    pub(crate) total_fb_end: u64,
 }
 
 impl MessageFromGsp for GetGspStaticInfoReply {
@@ -209,9 +211,12 @@ fn read(
         msg: &Self::Message,
         _sbuffer: &mut SBufferIter<array::IntoIter<&[u8], 2>>,
     ) -> Result<Self, Self::InitError> {
+        let total_fb_end = msg.total_fb_end().ok_or(ENODEV)?;
+
         Ok(GetGspStaticInfoReply {
             gpu_name: msg.gpu_name_str(),
             usable_fb_region: msg.usable_fb_regions_iter().next().ok_or(ENODEV)?,
+            total_fb_end,
         })
     }
 }
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index d025167927df..64154b487c05 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -167,6 +167,13 @@ pub(crate) fn usable_fb_regions_iter(&self) -> impl Iterator<Item = Range<u64>>
             }
         })
     }
+
+    /// Compute the end of physical VRAM from all FB regions.
+    pub(crate) fn total_fb_end(&self) -> Option<u64> {
+        self.fb_regions()
+            .filter_map(|reg| reg.limit.checked_add(1))
+            .max()
+    }
 }
 
 // SAFETY: Padding is explicit and will not contain uninitialized data.

-- 
2.54.0

