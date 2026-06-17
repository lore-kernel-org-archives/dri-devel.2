Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A77CD98E4
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 13:25:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9882B10EA1F;
	Wed, 17 Jun 2026 13:25:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="J8Rx13Ql";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010065.outbound.protection.outlook.com
 [40.93.198.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A88EB10EA1F
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 13:25:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=InZ100tD5aI0WHNUxFbXR4HTK1M/2u1+Y+X39xjA5ktr2LCpmWOS5hXaZv/rFkICdsfqKXMzs2tmcGkkMauWfvqnxEJR28zPAE/S3SomxLOBaQvUM36VALgW9I/l7s99z+NT4V5dzlhPdBXznbBI9O6QK5gU00tAdFhYxBNgiTnGqX+ZpWFJLnvAWd/EscorJHaNf+GFcr3YEvl9StHqwqxaXyn4qgKv4vpHCtjeyqLtldoYr7KGNTfbUqiPoTB2DRM6AZ99S62Pjbs+8XSdTIXK1+Ije+jBK4UtI0KMNwDBTnH4WRETqgSGadAV+WHaZ+oafs8qCSKIrs/xAdGOkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkUGIxJ0DMOSxGV6tryE1R1KrslOdReicqxHHjOY7cQ=;
 b=NXeyD6NN0EPrqszLe7HIwOp6S3XXFj98vdXUki6LKakNlD6r232N7C+bcSC1BOO8XBBqM9sQWbAb7DoDMw9vPYboSi6UFcgbAXWS6hTvVfNG/PH0EOfWpnjYMDMyBw8/BggzFXhp7/khayI6oX1i1YTDlZeBTuQfAynFzynLW8HEZbqyT7rPy2Tv2+Mf1exDRPeCCXi55gKoxcdA1o1u0TgPTTX8U5ErCHPxg0dvxH+nqPsDNxbuwlyqladU/d0lmxZTBwrjK2O4A+HD0gJRBDxs3iJ06W27l+svwN2Fn2j3Xy8HkhbweDbLak1YJ2itTEgjH7NtMq/ys7DHdXvv2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkUGIxJ0DMOSxGV6tryE1R1KrslOdReicqxHHjOY7cQ=;
 b=J8Rx13QlFTsoHoGSnTqC/jec+FL0jplS2TqKtgrQhr/1c92dQ0j2LjYSNQyQ5czDGPcYJwHiCVWtFZUQ4usL/wMjwFHRNdi7/ehOIFsHc4epkRoolfD5OA3TAQOclkMOwyT7UHhk0CRSZbk77GIAYrrasKDsFhrkgyQOChhTrDKeE92nFhlPg7Zf5MTcMTmbklm9FMK4+jwhVyCvN4JwVdytbw7M45iUt9Q2DOObEwEXZPFRp/CuiZZexMuqvGjgmaK35o8bPdMtrFK1bkBQ7WZ3xzD8qXxs6DueG1IV4znkBzf/X+cv93D9tofMSNuUNTFkIGkp65MeZMLwrLVbtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA1PR12MB6727.namprd12.prod.outlook.com (2603:10b6:806:256::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 13:25:01 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 13:25:01 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 17 Jun 2026 22:24:45 +0900
Subject: [PATCH v3 3/3] gpu: nova-core: gsp: Extract and display usable FB
 regions from GSP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-boot-vram-v3-3-20b9ec5fe9f2@nvidia.com>
References: <20260617-boot-vram-v3-0-20b9ec5fe9f2@nvidia.com>
In-Reply-To: <20260617-boot-vram-v3-0-20b9ec5fe9f2@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCPR01CA0151.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA1PR12MB6727:EE_
X-MS-Office365-Filtering-Correlation-Id: 78fb1b3e-b5f5-4277-b65c-08decc73d581
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|10070799003|7416014|56012099006|11063799006|6133799003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: sUVc8LOpfQZhujbK9zNyP5+5JwczFAuwckiJiCeY+h7rTfZQQR8vFkyKZrC4ER9xONLofJfZpjURRtIvCNmi4NVWFCub6Ff2uwQ8HK1ocBX3emR+QQFggxO14/PLZ/FUiUyIuRlKfRIliVzrU2wnNA8ahiDTR8UfefANXjJAOgBN8mbUY3pqRV36NVkimNMazzZwQxdb4L3fbsXRWgOAJqVMYYfAKWrjwZdCVKIPo3vX+RRAMj/AF0/rXIPWUER52UJM0im3Nl7nAlSd/+mHOczPeS/GkA+zSavfDEhxX3uFMJlVPl3T0ybVKiqWeWQXe8q1PwFD9tr+qVH+EjVjAjXcH2C1m9/wh9IKlhh4R4lFFqxrXgyjS3S6D4j2MZXNTUOhGn9s0VUYTpRmncKMQEWRr8+BWscvpEVZMqPfaVg+yrRO1UHXCOW0eKMwLp2dhQ/xeo7Fbdj8wQ5IeDpoQz4cUSCc41Dt4f9CguGh1qpXAIDKygeMKdfiCA6Bp9FUBB2qWunw2fJsTgViEDuoi/kj/XDa2tuJjeb3V7zlj6UR3mGY70IE4RQWJpZ91r0bwwEj/3xi/LieqLcCyJQdmVdJJ9ETC3FiseblQ4kzjkIbzK27tAP7O96vvQjmU3KimqAk1aXIuPZhxe5fnrmVBG0tr6NwxCCfss2MKAeXZ7u5xva3Qb3cML/fsLhfe2vv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10070799003)(7416014)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmVScjBzR0d1a1J3bmJPOUc1dHAyN0I4Q2Q1WElzRHhwT3I3eWRVaTRHSGg3?=
 =?utf-8?B?MUd3aHRIQms2RjJjcXBxVGhpSG1qNFFTQ1VrUlBDZFhQdnVySjUxd2FRL2dK?=
 =?utf-8?B?aE5XZVI0STdlSWIvY0FtQ3ZoMU5zVG1ub0JyQXhWb2JudVptUzR1a2F5blBD?=
 =?utf-8?B?TzREbVFtaDZJekx2clpYdUxvZEQzV2VVaVhNR3QyendCRUFCclZmSTJsKzAy?=
 =?utf-8?B?TnQ5Tm1ZRXRCR3d3S3JZYU9oZUp3bmN0Um9xVldIVHgwVWFGc2JicnpjcDFz?=
 =?utf-8?B?dVd3L0hSVE1STFhaeGh5SktRRDluZldRY25nT04rOG5JVmpTMThUWmhGV1JQ?=
 =?utf-8?B?cmxUdUNWTzlXQUpOaXNmM0drNk0wSWhhWmJtbEdiRXBPN09MRUEraTMraEda?=
 =?utf-8?B?T1J5UnFkeXZOdW45TUJaeWNFRFlKS1V0QldVcmpEZ3lzeE4wd3lMMEYzeWhL?=
 =?utf-8?B?cWR2V1B2dGgrVVBCQlo5K0RVb21uQ3oxR2RoK24rc0QrVCt3OVRCTUdmallh?=
 =?utf-8?B?M3FaZm9LdGJNeFVoNEZOdW13S1FNdUdwdjMra1dwKzFCam1mejZYMnc1TGVT?=
 =?utf-8?B?OGROK2pMaTJ4K2NVRUZDTHNGSU1KNVkwWitlWnRQU0pPaVdFUTh5TU96MDIy?=
 =?utf-8?B?b054dGpFajdZMWV2alVDUjZoVElUUU9RNzdLWGFsMDJJQjVtNGNrK1ZiRnJy?=
 =?utf-8?B?RGg0MWVneWEvc2FtQm5kUis2Qm9xdzRqN1VGdkRzMDdZN1pHbHRteWVDTGJD?=
 =?utf-8?B?S2cyOGM4N2V6MXlGdngxZytJSUo5eXpaYTg1cEZuNzlMbFVydnFaUVM2eXE1?=
 =?utf-8?B?N2NkekRBNSs0SW1aaGUyNmpqamNKZHpiNktIb3FDaHNTUk1yQUY4dFVLVDlH?=
 =?utf-8?B?RkVGV1htb2lCVHd6aXlkUXZQbVl6ZEltdllQRjllVGxzK1NubGIzaXRTWkZw?=
 =?utf-8?B?dkEwV09SeEhmalAxYXZld0VrS3pHS0Z3REcxR3FpdEk4K0gvdzRFZGtvQndV?=
 =?utf-8?B?YkdxQU44UkZDeXFDMmZLcjI3YW90cThQYkxQS3JOZ0J6VXVtWHhDVERJRUxS?=
 =?utf-8?B?TGJhNmtoZHdRbEZRbi9YT1R4TENYU2tmWmpIdEorVkVpNGNOMVNsQnI1dit0?=
 =?utf-8?B?K2I1M0JvREVaa0JQQXJCcC9jSVE0RkdSUkNoWVFaSEJackZiR0kzL0x2Ykdm?=
 =?utf-8?B?TUxDeGlYOHMrajNQZ2lVSzFCN05Ua01ldGRINTFGR2MrcU4xWVB4OFhFVHk0?=
 =?utf-8?B?RDZRQzdRTVlrclFQdldTOG5tNHlia1dpbDFHWEFvNjltbkNhSE5zVlo1d05C?=
 =?utf-8?B?ZTJrVnVoUFUwVGZjNlRwMGFmbFNudXlWbGFKRktHTTZlbDQ5UUlGTmhqL1ZJ?=
 =?utf-8?B?TEI0VStCdjFtZjl6eDZIZ0EwdWg5V0thcUNPcm9PNW91b0kzSDFob3drOFZr?=
 =?utf-8?B?d0grdXVlOG9WL016RUU3WmFCSDhoYytpS0NwSWFxWEtjelhwWUlaMG1OekZR?=
 =?utf-8?B?L1lueGt3T0FDMVlFVmxrVzFRZFloWkJPUXRHSENoVGpYeW1kNUJBZnNacTIv?=
 =?utf-8?B?NUw5azhGcGVFeGdmS0lZZTBlK0srWktIczd6SUFuT0VEVyt2MllHUXU5cVRa?=
 =?utf-8?B?d3dWdnJyb2w5akc1d1Y5UEQ5Q0tHUWlhT3RHV21xYWhVTmpaMzIxazliUWhm?=
 =?utf-8?B?K2hpRTRhMks3NUlFcGZoMmVOS1BoLzErMk5yeVNuODE1U3NwOTFiMDRJTzlU?=
 =?utf-8?B?b2ZkbWFQWDdTaHJKWXB1S0lrL1p0Z3FaQk9IODZ4eHBIQ3pvZklwU2tadGtv?=
 =?utf-8?B?VGVZK2dSYnlWZ0IxM3VTUDgrTjdiMCtzWkgxUjR2Rk1vbGlHRGRBZGxEZlEr?=
 =?utf-8?B?NjhKdFNLZ3hjVmYra0pnMmc4L0hNTDRZR1dYYU9ENG5lWW10UHBZTjRKRUwy?=
 =?utf-8?B?MU5yVGQzdDdYU1RzbngvNHlFcnR6K3dmQjhSZ2gwSXZndGhYcElmUHVjdktH?=
 =?utf-8?B?VHhwMWFmTmhnRDNRZG5TaEhDVWxrZEVWK20rRzBPSVVtbGxxSmpubTVBaElm?=
 =?utf-8?B?R2NtYkNZTEs5MGxYb1YxWGtMaktXMWQwNlBsOFJGeVg4RHRsNXpnMUVoek12?=
 =?utf-8?B?bTlMck84ZnpFMkc2RTdzZXdTSUwxL3NIb05tZHVEV1FDVWxVYW9obWc0Wmgv?=
 =?utf-8?B?WnZEQVVFUTlleVdBSXJaZ2tiOXJodmhKcTJYV21BV1RxbjNQZ2x0dlMxV0Ur?=
 =?utf-8?B?MUE1UVlzTk9YSVcvTGVSTEVBQjFzQkxSQ0lMdFJWZXhUOEY1QUpGS1ZKa2or?=
 =?utf-8?B?Z3hPNnFocDZrL2I5eGdzR1RuenZWczQ0MktObDgyQTQ5NDhCK2pubGVEY1Rw?=
 =?utf-8?Q?zZVRqpBK6gQZ9WRPdiW2O+sRGAfgi9IbmEx/CviNN+S+c?=
X-MS-Exchange-AntiSpam-MessageData-1: DZ3dHrdFvjiybA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78fb1b3e-b5f5-4277-b65c-08decc73d581
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 13:25:00.9747 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qCiJaz5r87ksL/8gbs+E/twpQCBCcuEZ9yZNG0FIit/Ul3U3Gy4mRNh/MamCwxr8Obixmg208P1A8/X5SZHZ6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6727
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

Add usable_fb_regions() to GspStaticConfigInfo to extract the usable FB
regions from GSP's fbRegionInfoParams. Usable regions are those that are
not reserved or protected.

The extracted regions are stored in GetGspStaticInfoReply and exposed
for use by the memory subsystem.

Display the regions and their total size upon device probe.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
[acourbot: expose all regions as a KVec, display usable regions and
total usable VRAM.]
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs             | 18 +++++++++++++-
 drivers/gpu/nova-core/gsp/commands.rs    | 13 +++++++++--
 drivers/gpu/nova-core/gsp/fw/commands.rs | 40 +++++++++++++++++++++++++++++++-
 3 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index a34114d3afcb..42dabcc1b3e4 100644
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
@@ -377,6 +378,21 @@ pub(crate) fn new(
                     Err(e) => dev_warn!(pdev, "GPU name unavailable: {:?}\n", e),
                 }
 
+                if !info.usable_fb_regions.is_empty() {
+                    dev_info!(pdev, "Usable FB regions:\n");
+                    for region in &info.usable_fb_regions {
+                        dev_info!(pdev, "  - {:#x?}\n", region);
+                    }
+
+                    dev_info!(
+                        pdev,
+                        "Total usable VRAM: {} MiB\n",
+                        info.usable_fb_regions.iter().fold(0u64, |res, region| res
+                            .saturating_add(region.end - region.start))
+                            / u64::SZ_1M
+                    );
+                }
+
                 info
             }
         })
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index f84de9f4f045..86a3747cd31c 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -5,6 +5,7 @@
     array,
     convert::Infallible,
     ffi::FromBytesUntilNulError,
+    ops::Range,
     str::Utf8Error, //
 };
 
@@ -191,22 +192,30 @@ fn init(&self) -> impl Init<Self::Command, Self::InitError> {
     }
 }
 
-/// The reply from the GSP to the [`GetGspInfo`] command.
+/// The reply from the GSP to the [`GetGspStaticInfo`] command.
 pub(crate) struct GetGspStaticInfoReply {
     gpu_name: [u8; 64],
+    /// Usable FB (VRAM) regions for driver memory allocation.
+    pub(crate) usable_fb_regions: KVec<Range<u64>>,
 }
 
 impl MessageFromGsp for GetGspStaticInfoReply {
     const FUNCTION: MsgFunction = MsgFunction::GetGspStaticInfo;
     type Message = fw::commands::GspStaticConfigInfo;
-    type InitError = Infallible;
+    type InitError = Error;
 
     fn read(
         msg: &Self::Message,
         _sbuffer: &mut SBufferIter<array::IntoIter<&[u8], 2>>,
     ) -> Result<Self, Self::InitError> {
+        let mut usable_fb_regions = KVec::new();
+        for region in msg.usable_fb_regions() {
+            usable_fb_regions.push(region, GFP_KERNEL)?;
+        }
+
         Ok(GetGspStaticInfoReply {
             gpu_name: msg.gpu_name_str(),
+            usable_fb_regions,
         })
     }
 }
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index 7bcc41fc7fa0..ebdc12bcd4e3 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 // SPDX-FileCopyrightText: Copyright (c) 2025-2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 
+use core::ops::Range;
+
 use kernel::{
     device,
     pci,
@@ -13,7 +15,8 @@
 
 use crate::{
     gpu::Chipset,
-    gsp::GSP_PAGE_SIZE, //
+    gsp::GSP_PAGE_SIZE,
+    num::IntoSafeCast, //
 };
 
 use super::bindings;
@@ -129,6 +132,41 @@ impl GspStaticConfigInfo {
     pub(crate) fn gpu_name_str(&self) -> [u8; 64] {
         self.0.gpuNameString
     }
+
+    /// Returns an iterator over valid FB regions from GSP firmware data.
+    fn fb_regions(
+        &self,
+    ) -> impl Iterator<Item = &bindings::NV2080_CTRL_CMD_FB_GET_FB_REGION_FB_REGION_INFO> {
+        let fb_info = &self.0.fbRegionInfoParams;
+        fb_info
+            .fbRegion
+            .iter()
+            .take(fb_info.numFBRegions.into_safe_cast())
+            .filter(|reg| reg.limit >= reg.base)
+    }
+
+    /// Iterates over usable FB regions from GSP firmware data.
+    ///
+    /// Each yielded region is a [`Range<u64>`] suitable for driver memory allocation.
+    /// Usable regions are those that satisfy all the following properties:
+    /// - Are not reserved for firmware internal use.
+    /// - Are not protected (hardware-enforced access restrictions).
+    /// - Support compression (can use GPU memory compression for bandwidth).
+    /// - Support ISO (isochronous memory for display requiring guaranteed bandwidth).
+    pub(crate) fn usable_fb_regions(&self) -> impl Iterator<Item = Range<u64>> + '_ {
+        self.fb_regions().filter_map(|reg| {
+            // Filter: not reserved, not protected, supports compression and ISO.
+            if reg.reserved == 0
+                && reg.bProtected == 0
+                && reg.supportCompressed != 0
+                && reg.supportISO != 0
+            {
+                reg.limit.checked_add(1).map(|end| reg.base..end)
+            } else {
+                None
+            }
+        })
+    }
 }
 
 // SAFETY: Padding is explicit and will not contain uninitialized data.

-- 
2.54.0

