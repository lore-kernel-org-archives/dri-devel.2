Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7293BC79FAA
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:46:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A58B910EEF0;
	Wed,  9 Sep 2026 06:46:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Pxvqmf/5";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011012.outbound.protection.outlook.com [52.101.52.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30B2B10EEF0
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 06:46:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DL+KjonTxO4f9siuuEzRsnPWIhC0BBtGgXzEIxkZpHyMDLRImKcHASbMRlfv6oWvcg9f7KMZFc+mPPTisjmt/+pmnu5ef9kbnB8S9aFptitBgkbXCzbUY7anqP2Rryo0xtmX/tiWX+rAHtP8gSB/ECIeQqIEo74p24BmyvoYn79E7IrIZbCgAJXeLRWfOMQGpl9mya1jjbxRhAjXh10wt/Nlg401wj57go0Yf02/VjGTw+x64s8ROx9ySkETjLbXtrh08nSZGBTwDx9KJRmTKq7Y1BoyjVlcMnv9amIiTVBX/3D8927O+K7j8DaIiEj9yD3zXeTrZIJkDc4tzSjx3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7eYzb5oIXtT+tpJHo0L0TV98OQ0M+5jnxfUHKcbXwAw=;
 b=X8yiebMo3Fnw3VxTmISdBVRU43+Km3z5KzoZhKgD9xsQJY7KeUrJiem0U4fP6Q4+P47j3/sMWZNplLfX/2fMQ9iD4Theo/9XAc+SiIYhQgN5Br6+rENSW3aNSqPsEFOBesRLRwg0vGKtpnLa+dOhrCVty+dIeuwkZ8MF6AduBwJPGUoGi0gAEM+zxziuv2GxJA9zMebyUKeWXN5JzAJLF8df26DhGUVkTIXwUL689FHfs0cNqJ3/kk5qbpeCZrnQHke/vm0kxCRWzzMX5locTHm5C2G+M89ZmQ0p3BqnxY34mgjT2TFBCHy7ITkvMiWpruae+7ZPtlrZXkWb/cVg/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eYzb5oIXtT+tpJHo0L0TV98OQ0M+5jnxfUHKcbXwAw=;
 b=Pxvqmf/5PScuUxqFn15G7kZDkAK4pep6KFs7CXtRnf7Sn+IGzl9fMIJQuIMdTZskPrH8YIqg0dLLZ2Sne+gJTZkWcwlObKiH7MJOYzZD6hno0wsk9QlFhWTXv0Xdju6ltCDUfbSnLGcG1vU2V0Br2QuOdf4GMLFRS+ukdb4swLzGYgDFSBQRNgx5fME5kK2LmYjwTyOr+MphhsrLPvGawZKxh/NNOPAKsCGRVkY/g+qUIvtTzLVKXfK7AiN9cBexbz+WhGa6MozjDJhJWKOsMtGF/bgmM7J50lzYz1l0mfMgaCZDZRHIRzdD13Ft8qtxZamKT1+THafKcFeAEhW6SA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by IA0PR12MB7697.namprd12.prod.outlook.com (2603:10b6:208:433::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 06:46:05 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 06:46:05 +0000
From: Alistair Popple <apopple@nvidia.com>
To: rust-for-linux@vger.kernel.org,
	nova-gpu <nova-gpu@lists.linux.dev>
Cc: Alistair Popple <apopple@nvidia.com>,
 M Henning <mhenning@darkrefraction.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>,
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>,
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v6 09/13] drm: nova: Use nova-core to read VRAM_BAR_SIZE
 parameter
Date: Wed,  9 Sep 2026 16:45:02 +1000
Message-ID: <20260909064506.910162-10-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260909064506.910162-1-apopple@nvidia.com>
References: <20260909064506.910162-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0063.ausprd01.prod.outlook.com
 (2603:10c6:10:1f4::15) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|IA0PR12MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: bb2f1e4c-1447-4589-20d2-08df0e3e04f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|23010399003|376014|1800799024|56012099006|10067099003|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: QG+EebKV0/3WjtyZXtVq0R3CFCZsAWXknQhpRlYIJezA5gKZnQehkbBjJb01DgEfxDoRRQG353F7VuIuuh7xOb1+oYPKcSbWjYY+DzrbE/ynJNJ1BJIKFg+lnyBkftg4DVkLKgR/Qrn+xPkYVEbi1uPvMt3dRA9OSrryGzPnO0thmfYoBeV7ryBFUJCNgcE75AClYy3RBt7PSOXVFOEVFuEyQ9jok9hNx4nWTu5cHZa0b0KNqgwRZy2pBy5iQI8oUA3b9fLgLgA7wFAKYY2WfrJgvSF2QgH0WYK6mxrF35pi21/V7f5+5KEdvDPTMfEFcO5r014H78wzrUOuCgISoUYD6nU26IvOKK1mEhGLqRzQcYoIfyPa2o1pOcEOpQOyshfarkVERNEeZiZJ6oyz4/DZeZjYLQi1fQkE42mcZqv45euinkoKU3DDVytGdzmaocWia66m1z1abEdMcZxI2M6tw4flr79CHtErIajFiBlTRY5pmgk+gHKyGxl2XHdpMjlKpw9ogGk//yvxWNfgZRfAKFwX3gt9vajGK7l9OhR4k8eOyGw8ET1cx7Q2IBKQ17NYjPooT2uxuV/4jGWV3ViEs0ucjCx2V6IGBIbLCROr/wcViOcbXnJRdyySVnOosu0GYPeIhlEG0Ugjn7rwvHWG6+LBXE2pSuQFzsv2cIs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kTIkZp1BUbfg94s7ln/lNpfJs6MKNGRqVSVq6lX/I3/7o+5yDJxiPydTd/hi?=
 =?us-ascii?Q?Vw+IyZNOrPbdDH30BArWdHxlOtdsybGZWGe4R940V8MtWEEZH8b/IbaNhoiE?=
 =?us-ascii?Q?XhuVCnIQrlrolN2sa8tRBa85ciFWBMH6KtjRkeXSnx30tprYEQ7MPMMxcBkW?=
 =?us-ascii?Q?WSDNPg4ifoIXGlbdwmplzgbQlQFPhzQmPmHBOV0zZBtpUpNz3aSgt5aqc3fe?=
 =?us-ascii?Q?nqT898KSBPjFAZEbl4qR7FZs6LwlEmcHjThDo1WshpRUmUBMEKMMWyDpdfcT?=
 =?us-ascii?Q?lSaTIuDsq9loYSxanxQchO0EU4I09yz1AHxaxuCNg3X1Z9EE4PqA9WdBzaL0?=
 =?us-ascii?Q?jOgWFs04LAFi0f1xGRqZWebbYZhxNhk3teQbml3PXaod0VESpDjJpasxodKq?=
 =?us-ascii?Q?IndIDArY5vrf2RMrcllcoWuaMCm4eZvUYzqanhT8iQk+XCqZyMk2J87gqk1u?=
 =?us-ascii?Q?a6PamV6SrrtTT2jCBOqzxtAV7+2Bhx14LHF/NMN+Ct3C29tYfsKBShP6LRPo?=
 =?us-ascii?Q?2yPOsuzcosaj/kZvBH5i72CNSjVs1AJ9ca42jOmeyXNcmlXLpEN+56qEvfYz?=
 =?us-ascii?Q?HB3SteqiVch67G0tQsb75n5el1/+LRNBJqoXHxZtXVyxW67TusLAgT389otj?=
 =?us-ascii?Q?8K6D9xltlHxmXYlnBvjvoea27ad0GyaB3Vy65ZWWbd6bj61qQKXgoWQEEvFK?=
 =?us-ascii?Q?ORrrW5ceHFkG07yGKw8KOfg2mxU0wmPRqBIWqU+qGRGA5Bauk04IMl1I6mVA?=
 =?us-ascii?Q?uNCidBAUHLy1EUd4wSPc5xHS2cP7OVQHyzPlWxvpO2DnZZM7WRq4iok1XiHv?=
 =?us-ascii?Q?g6/lKn+7qM1u73MHsBhtsZXSh7/1hGOktQMypjkCZUIvLzKDXGhRZ2yVlCaK?=
 =?us-ascii?Q?LCuHlB7m8xx30Z29xWQ7Y3z7apBNO6XYd1KmhhA/R4ls5hp+37CkeJ59sc03?=
 =?us-ascii?Q?ndhBT0rj+xqPsZX1Pa8SGMzF/MzzjFQ2pOBgPI18iawSipjuD5z9tpLIUnNh?=
 =?us-ascii?Q?j+qjUD9UJaJpN0Z6qbbzWcLyoEYd+ltPjTAO8w6+5+3nMQaIKL7YpJvnnk35?=
 =?us-ascii?Q?hyZVQu8CwCi6co37OYKNO0CwS+/jXun1Yx3biGT7MgyrWhCvw5GUJNIlW6U5?=
 =?us-ascii?Q?+40HTf1PmG9KYyX07uGe3XQO7S+gjf7xMecOg/5PrImhOhi4DEsxrecn/Yl5?=
 =?us-ascii?Q?yHb06Y2DMbyOHLjhdKezWvg1KJEgSkkxdV+0MNYv+wQ5FDYmDO4pM/UwZhnv?=
 =?us-ascii?Q?I8zJlphF9uBFfFU15qk5sb75oKw2jY71mlBUggYthojTtKCLRH3KApVGnxAr?=
 =?us-ascii?Q?JPxM9qdgI0uFZwUsKTkMs3wWoipafITGCHg1pe4RPpVzW0Btl+Zz95Wk4n1w?=
 =?us-ascii?Q?Sf3RyxbUH0qzOehCHNxJWgRm4X6h6p7R/2C4cuJCazBVCzQ3UUfgfwDNXwC6?=
 =?us-ascii?Q?uc6u1tMYNYX7c+RBkaewJPRFTAjqtDXVgVJYjITWchn8sYLaHMWK2eVMIdNy?=
 =?us-ascii?Q?rwziXW6sGJTGiRBd/gYfKRiP6qpEVZbdujPsTBV4941Cq9sU2G+zpkg4lmsl?=
 =?us-ascii?Q?Nz2aIVqALec7C3GOPuFW58TitMHr6ptqs/FjZVH7UQ2LEbMA/lI20nlYokDJ?=
 =?us-ascii?Q?d2ZZmOtuCMPtEqGNyVMRy6kEuT/WXOHr4IFUwsUwkpH9aqLJCMjHe/Hft4Uf?=
 =?us-ascii?Q?X1cuKaLN1ovJNWjIrZY7ImdJIAvNDsGSPCcr2skWuVeKPHphMapHzcuwGroA?=
 =?us-ascii?Q?kc0xPnX2og=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2f1e4c-1447-4589-20d2-08df0e3e04f6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 06:46:05.2079 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: agY3uLtzY4KIiDG3tUsELkIyE5FRMVoXxpBq23ih2tkBflz1evJ2DOdh0xUVufs0AebpHlGzaj9Q3YGlKuAatw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7697
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

Currently nova-drm reads the VRAM BAR size directly from the PCIe device
which requires trying to cast the parent device into a PCIe device. This
obviously requires the parent device to actually be a PCIe bus device.
Whilst that is true today it may not always be the case, and there
is no reason to make this assumption now that NovaCoreApi can hold a
reference to the bound PCIe device.

So convert nova-drm to using nova-core to obtain the VRAM_BAR_SIZE
parameter.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes since v5:

 - Call bar1_size() through the NovaCoreApiHandle closure

Changes from v2:

 - Update nova-core API to use bar1_size() instead of vram_bar_size() as
   this is used internally throughout our chip HW.
---
 drivers/gpu/drm/nova/file.rs    | 12 +++---------
 drivers/gpu/nova-core/api.rs    |  8 ++++++++
 drivers/gpu/nova-core/driver.rs |  2 +-
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
index d0ab3df6bcd2..dad3c83c920b 100644
--- a/drivers/gpu/drm/nova/file.rs
+++ b/drivers/gpu/drm/nova/file.rs
@@ -8,14 +8,11 @@
 use crate::gem::NovaObject;
 use kernel::{
     alloc::flags::*,
-    auxiliary,
-    device::Bound,
     drm::{
         self,
         gem::BaseObject,
         Registered, //
     },
-    pci,
     prelude::*,
     transmute::AsBytes,
     uaccess::UserSlice,
@@ -80,16 +77,13 @@ fn open(_dev: &NovaDevice) -> Result<Pin<KBox<Self>>> {
 impl File {
     /// IOCTL: get_param: Query GPU / driver metadata.
     pub(crate) fn get_param(
-        dev: &NovaDevice<Registered>,
-        _reg_data: &DrmRegData<'_>,
+        _dev: &NovaDevice<Registered>,
+        reg_data: &DrmRegData<'_>,
         getparam: &mut uapi::drm_nova_getparam,
         _file: &drm::File<File>,
     ) -> Result<u32> {
-        let adev: &auxiliary::Device<Bound> = dev.as_ref();
-        let pdev: &pci::Device<Bound> = adev.parent().try_into()?;
-
         let value = match getparam.param as u32 {
-            uapi::NOVA_GETPARAM_VRAM_BAR_SIZE => pdev.resource_len(1)?,
+            uapi::NOVA_GETPARAM_VRAM_BAR_SIZE => reg_data.api.with(|api| api.bar1_size())?,
             _ => return Err(EINVAL),
         };
 
diff --git a/drivers/gpu/nova-core/api.rs b/drivers/gpu/nova-core/api.rs
index 64f9ea442278..f02c6c7c7e51 100644
--- a/drivers/gpu/nova-core/api.rs
+++ b/drivers/gpu/nova-core/api.rs
@@ -8,6 +8,7 @@
 use kernel::{
     auxiliary,
     device::Bound,
+    pci,
     prelude::*,
     types::ForLt, //
 };
@@ -20,6 +21,7 @@
 /// API handle for the auxiliary bus child drivers to interact with nova-core.
 pub struct NovaCoreApi<'bound> {
     pub(crate) gpu: Pin<&'bound Gpu<'bound>>,
+    pub(crate) pdev: &'bound pci::Device<Bound>,
 }
 
 impl NovaCoreApi<'_> {
@@ -38,6 +40,12 @@ pub fn gsp_static_info(&self) -> &GetGspStaticInfoReply {
     pub fn spec(&self) -> &Spec {
         &self.gpu.spec
     }
+
+    /// Returns the size of the PCIe BAR used for accessing VRAM, typically
+    /// BAR1.
+    pub fn bar1_size(&self) -> Result<u64> {
+        self.pdev.resource_len(1)
+    }
 }
 
 /// Expose a handle to nova-core API
diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 922068df7707..025ba2869d6c 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -110,7 +110,7 @@ fn probe<'bound>(
                             // never recycles IDs.
                             AUXILIARY_ID_COUNTER.fetch_add(1, Relaxed),
                             crate::MODULE_NAME,
-                            NovaCoreApi { gpu },
+                            NovaCoreApi { gpu, pdev },
                         )?
                     }
                 },
-- 
2.54.0

