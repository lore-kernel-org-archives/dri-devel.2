Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2119C79FAA
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:45:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4C4110EEEC;
	Wed,  9 Sep 2026 06:45:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="R7cqHcrG";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011031.outbound.protection.outlook.com [40.107.208.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 070C810EEEC
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 06:45:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=adiOHZAD97isIjtbSw7ToR+TX9u4vIndvfcETmsmBiZNmC+kRkii7Z35jOHRlaZuHQVcbl64E1R4OkLeVXbWnxwcRsr8vIbDTMqQXNl9WvKAgc0TUVNPVOVy56vqAkIfRAKK46tmNoxjzXYmdKxJOfgTmdghGONaJHIUJ9MOX5GD5EQOzzszZzDREfr6yqmhy4qia2ro7+1weQUvVLVLdhnrCVWqEErbzBY/sGInpfQHxvzadHrFvd+LSVb+/Ua5uEr0cRbTd6/REQvyvqbf8QHO/JuFAiYkTfqXDRvl67kpPgRzx9iNT4t3VNYav7bsIJ7YdOeZXQU3hqSwXtG99Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dArkeSAmHo4yjvE8bRmkXJJ+qzpbY4AYLWYWYdAjnQc=;
 b=XSWhF40TzVNkl5Ia/sj3yRYbLHyc+8BqBW1JYT31/4RvsUsTQMvi4HROxgC6mh8OQwYVdYOWK8LKkCcDMTIL3HzmzY8KhCrPCKT478/1CC+zGtLysWeqNNxaNLRI8V15m2XaHn/Rai4pAOtMWl8JyA5ZKsWTa9WO5v+76fg+v8XRM+SF/7Kw8djbtJL4Qs4AiDq7oK+nOvmwq70wsgoyLdqml3siYAsM3Vmf/f+fBsemAC0610SRT+Be5wWTZuURW9rWWyGO4X60XnSHCdKqllRe4D1fND94moZpIpKphncmt8WBuLLK9OoU9bdtVQ33gQ+Wa9YM9qWuTVIBvqUhBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dArkeSAmHo4yjvE8bRmkXJJ+qzpbY4AYLWYWYdAjnQc=;
 b=R7cqHcrGj1bieieFaFXWs/KZLxZGqdWYXWUhVMTDcYax8dUTS08Nz0YJ2fvfg6uiFzLLhASeb5qLoV1gof9UeLOHmP27xXXSF7tjMTz4lDHAH6zdz0LCMo9Wky9//pFvEv4TWfIayj+X8RgsPWrkKV63O6ROORozvvyy/ovZrLAwXLWkgukqlHx+LhOxfig5LiJw7K2ZLumFvf9CjvwHu3/rdAWc97ruJSCO+bIEVdEQDVw2Lj8wYhbzGK+Hx2SiRDeQ9ISwortL85mjB+9pQ6ZnaaMCvZlGFo2g09jYeLc9mEV087l7y/ymzmL4gORzB1emYYbaaurKyRoIJmxqgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by IA0PR12MB7697.namprd12.prod.outlook.com (2603:10b6:208:433::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 06:45:52 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 06:45:52 +0000
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
Subject: [PATCH v6 07/13] drm: nova: Add an info ioctl
Date: Wed,  9 Sep 2026 16:45:00 +1000
Message-ID: <20260909064506.910162-8-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260909064506.910162-1-apopple@nvidia.com>
References: <20260909064506.910162-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0059.ausprd01.prod.outlook.com
 (2603:10c6:10:1fc::16) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|IA0PR12MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: a4dd948f-c351-42ed-b1a7-08df0e3dfde4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|23010399003|376014|1800799024|56012099006|10067099003|5023799004|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: H1f6bNSLRh1fjB5ygHv+jNBjDvpJx4ZoPS4UNyGXQSz0PAMzDd1C/B2CjD7rkL9S6/IqY8aeb2hCrcZvXqCDXYu5OrMaOHOIkGtcRrVu2uCH9YCjFNR6K+odgJmEIjVT/Ak47ul1uUbPW7oRc8ecWIU1htn5KQ6f+1gTSIPwwTDh2DJXUxJe+ZwlcrEMb+FbQqo5Fz+jGuzuOWJzIUqfbxcPnu6x6eqGVw0kcDAo8zKfS11gcaySsPb6Wzv67oOIN4DQqj8R93XDNY6MDuNwtAfkGlBVVYnZakyqWrYapAS/0vcI1QS9HnWU2OV5JZv5qu8lB3s37Db6Vjq/b7+JSywidmNEoScl0glqLNsCfP1n9CiK+6wzBaUSdf0rnI7Ge9VoLXHMY8lOTLc+A/olATHgOf+1xx8gHEP3klzI4PfwjbzmNo3IY4fehnK1WZLVM5MoAYYQjzxkjUu99C2O2+/VHkY12Om3lwLJsxNngVpr8QBAMyqg+7XLb9iUSmqJuzgYXiCqWTfiPQjQwG1nQiWepNuZpuK9tqTi+BFejxbM3WGD+fNLMfLLG+pL/RW7R9hG0seqyARn18HB8fUIaeNu+ytUNjVkDo+NVi86PogSyniY0LEMo9ftK4yrMy3e7dGNgjTGI5kBlGgRQkL0zDzHi3+uN6o1TGOSiNI7EiU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(5023799004)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P3OPjF8uweWfniCcz4iFSP+bHqWb/Qska51REntcoAVusRBE3SiK7ZsAsiEH?=
 =?us-ascii?Q?gWznHtDFpVAMhg/9DD0SQBVNAX3qYp+21VDJQ+0Px2gED/s0QEWpfMKI2epB?=
 =?us-ascii?Q?uEMJutLObzMf67EDt8chTrZ1NXuBlNT9IMxLoN9lop5ZqGS/MccM0T1Jy1gI?=
 =?us-ascii?Q?KQ9C9LV/Yf7BLC0u6/ye/GveIyL8FLv9uEltZdCQtfOvNZUqbi/pXvEElcmp?=
 =?us-ascii?Q?5eGqHmEg5q+kto9HJPs6GmgLnI6JI/xWHij196DFxsS/tXCF5JdHq72gtbYv?=
 =?us-ascii?Q?5oIy90+TLkroG4patsi1O70hVupzIHc1qFaznpWX5qpeGiKRM/yl+BVuH/f5?=
 =?us-ascii?Q?bBzaRwmP/z+1sqm/17rvK5xhGzc163M/iyfzCE8dIo+wKCyx7DINnVUVTLP8?=
 =?us-ascii?Q?P5uChKxnz8DezcVvtJ+6DE8ltK1QlXWYiP7OQdT1SFdIB0Wjg/93/+CrxTDg?=
 =?us-ascii?Q?Xm8YAOmHbXDpgmk6YY5JWseIeqX5T6Vo6aeDk3UWrk3/GlIIncTlkUzw50/U?=
 =?us-ascii?Q?y1vQdv9SIYJSA6++36XcO5VbP0TKwOas6S7p16Jt1ZIrZFv8RtIvqs6RGYob?=
 =?us-ascii?Q?QT/YXXap+4Txm+lu4TXYst7UG+I0kTOJd+kM5z+gLuNEUwgRwrzIF28znlnQ?=
 =?us-ascii?Q?euLvct4b/efam6R55gWj0oF3tXj0I18IaFp3Tt5mARZo4rSnMxCVTe3EnYjS?=
 =?us-ascii?Q?6OhYFo9arAL4Mt/6GWztP4ZMX0c3Ydk7PO5PsaymRYcrjyjqvvA1znhXUQ+v?=
 =?us-ascii?Q?sD1+z3li9FyRKesUSeJ42AZiwSoF9bLbDSK24EEqV5Gg03/NulpKcaUmk6zt?=
 =?us-ascii?Q?VIxySoEb6e2MI8WTTES2BkIOOAj1/29d7EvnB2RwqCge1V17ADkj8go5inH7?=
 =?us-ascii?Q?l+mJ+PLVXjxU0dBg3Dvwz8NOaFWYXr1WddBBqBTvfT48G3RJuCm8muHmL0hp?=
 =?us-ascii?Q?IrBOtNo/IxZkGD2GfEaqD4SMmeBQNgJLEVVOdTS36Kt8Zhcvr7MP45QhHiRN?=
 =?us-ascii?Q?kWp7JEz6vrnzO14QPb4/wc81kZV0C6rYCC8jbWhiyfzULLW3GN9jHrK01AJp?=
 =?us-ascii?Q?IZYPNCwPZNQzsi9IFR0KpP+/GkQgY4/SvVSFP00tmPkKIGr+TGoWrB3/Pmet?=
 =?us-ascii?Q?0xAX6J5EFVfnysd6wp0jsYuAksxBSBa1y2ZqQ1w4Wq94VukRHLj6rVB+PnCj?=
 =?us-ascii?Q?gsISsnu4EhwQJar7iWbgCh5LOOYq+TKy7tisJrBW+w7kPzdsTs4uFaHDjP4X?=
 =?us-ascii?Q?NrV64+TjTmlCPzwe0hnr/cFBNRLdABfbEdYBz/GBFfziv0jNKotIrPmK+AKK?=
 =?us-ascii?Q?pD8MwduHp18lGCc4nHXHRYhogW4MpOI47McA4HC0+ate5lRY+qaM3AHT1dtf?=
 =?us-ascii?Q?gr/oZNro2Xdxdis6GgSEYzPV1rbtBfe16Ti5tUGir7sEfTxdezNv28rDX6YX?=
 =?us-ascii?Q?gQqJ9634qnEHDAAmb1NtE9fpcNyDLV+juSzNniqaSwqUKn2G6u0dYKbgrfcT?=
 =?us-ascii?Q?ipAJr12aLE/cohPoqAr725mVWVEtxWCobdpYsmFeo3snXliHndWp6ZrITjhM?=
 =?us-ascii?Q?4wZaM9p5djdYbyQe8ttrd8VaKST36y7dAQkE7eYzG5iOem7wIaTk93uwyDko?=
 =?us-ascii?Q?dCm9ftO9/IiMP+bhtgju0Js5uXMRvuACA+hjtK8fG4CIOJEolvyCwG+IgNA0?=
 =?us-ascii?Q?x80025mlqpUwutqCc/uq8JQvIafm7fCdpvH/yYK1wVgHT1/jVwwfbJHC0fHI?=
 =?us-ascii?Q?h2XKKbX88w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4dd948f-c351-42ed-b1a7-08df0e3dfde4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 06:45:52.8423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ztYJvK5jV/LXnKWx453BsFca7+ZMVVw/7AsIhOBMYFxT8013WutEoT8YJiMla81p+HonrKeFMOLhzLOecJGeLA==
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

Add an extensible info ioctl and use it to report basic GPU information.
One of the first things userspace needs to know about a GPU is its
architecture and which chip it is, so add those as the first fields in
the GPU info result. The chip identifier is opaque to userspace and is
only meaningful when compared against the values of enum
drm_nova_chipid.

The ioctl selects an information type by ID and writes the result through
a sized userspace buffer. The kernel truncates results to the supplied
size, allowing information structures to grow and new logical information
groups to be added without introducing new ioctls. Passing a NULL data
pointer returns the size of the requested information structure instead.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes since v5:

 - Report an opaque chipid alongside the architecture instead of the
   implementation
 - Rename struct drm_nova_gpu_info to drm_nova_info_gpu for consistency
   with the DRM_NOVA_INFO_<type> identifiers
 - Expose a Spec accessor from NovaCoreApi rather than forwarding
   methods, as suggested by Danilo
 - Handle the size query in write_info() and pass the value by value
 - Document the NULL data pointer size query in the uAPI header
 - Drop the redundant GpuInfo invariants, as suggested by Danilo

Changes since v4:

 - Add a new info ioctl interface as suggested by Danilo

Changes since v3:

 - New for v4 - chipid was previously returned as a GETPARAM parameter
---
 drivers/gpu/drm/nova/driver.rs |  2 +-
 drivers/gpu/drm/nova/file.rs   | 60 ++++++++++++++++++++++++++++++++++
 drivers/gpu/nova-core/api.rs   |  8 ++++-
 drivers/gpu/nova-core/gpu.rs   | 24 ++++++++++----
 include/uapi/drm/nova_drm.h    | 53 ++++++++++++++++++++++++++++++
 5 files changed, 138 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
index 52550e694729..0acdd2eb45ca 100644
--- a/drivers/gpu/drm/nova/driver.rs
+++ b/drivers/gpu/drm/nova/driver.rs
@@ -33,7 +33,6 @@ pub(crate) struct Nova<'bound> {
 
 /// DRM registration data, accessible from ioctl handlers via the registration guard.
 pub(crate) struct DrmRegData<'bound> {
-    #[expect(unused)]
     pub(crate) api: NovaCoreApiHandle<'bound>,
 }
 
@@ -98,5 +97,6 @@ impl drm::Driver for NovaDriver {
         (NOVA_GETPARAM, drm_nova_getparam, ioctl::RENDER_ALLOW, File::get_param),
         (NOVA_GEM_CREATE, drm_nova_gem_create, ioctl::AUTH | ioctl::RENDER_ALLOW, File::gem_create),
         (NOVA_GEM_INFO, drm_nova_gem_info, ioctl::AUTH | ioctl::RENDER_ALLOW, File::gem_info),
+        (NOVA_INFO, drm_nova_info, ioctl::RENDER_ALLOW, File::info),
     }
 }
diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
index 1156df51c533..4a65bec0fbce 100644
--- a/drivers/gpu/drm/nova/file.rs
+++ b/drivers/gpu/drm/nova/file.rs
@@ -17,11 +17,56 @@
     },
     pci,
     prelude::*,
+    transmute::AsBytes,
+    uaccess::UserSlice,
     uapi,
 };
 
 pub(crate) struct File;
 
+/// GPU information returned to userspace.
+#[repr(transparent)]
+struct GpuInfo(uapi::drm_nova_info_gpu);
+
+impl GpuInfo {
+    /// Collects the GPU information reported to userspace.
+    ///
+    /// This is fallible so that unexpected GSP behaviour, such as a malformed name string, is
+    /// reported to userspace instead of being silently replaced with a made up value. When adding
+    /// a field, take care that a value the GSP simply does not provide, for example because the
+    /// firmware predates it, does not cause a failure. Such fields must fall back to zero or
+    /// another documented default instead.
+    fn new(reg_data: &DrmRegData<'_>) -> Result<Self> {
+        let spec = reg_data.api.with(|api| api.get_ref().spec());
+
+        let info = uapi::drm_nova_info_gpu {
+            architecture: spec.chipset.arch() as u32,
+            chipid: spec.chipset as u32,
+        };
+        Ok(Self(info))
+    }
+}
+
+// SAFETY: `GpuInfo` has no implicit padding, kernel pointers, or interior
+// mutability, and all of its fields are initialized before it is written to
+// userspace.
+unsafe impl AsBytes for GpuInfo {}
+
+fn write_info<T: AsBytes>(info: &mut uapi::drm_nova_info, value: T) -> Result {
+    // A NULL data pointer requests the size of the information structure.
+    if info.data == 0 {
+        info.size = size_of::<T>() as u32;
+        return Ok(());
+    }
+
+    let mut writer =
+        UserSlice::new(UserPtr::from_addr(info.data as usize), info.size as usize).writer();
+
+    info.size = writer.write_truncated(&value)? as u32;
+
+    Ok(())
+}
+
 impl drm::file::DriverFile for File {
     type Driver = NovaDriver;
 
@@ -78,4 +123,19 @@ pub(crate) fn gem_info(
 
         Ok(0)
     }
+
+    /// IOCTL: info: Query device information.
+    pub(crate) fn info(
+        _dev: &NovaDevice<Registered>,
+        reg_data: &DrmRegData<'_>,
+        info: &mut uapi::drm_nova_info,
+        _file: &drm::File<File>,
+    ) -> Result<u32> {
+        match info.id {
+            uapi::DRM_NOVA_INFO_GPU => write_info(info, GpuInfo::new(reg_data)?)?,
+            _ => return Err(EINVAL),
+        }
+
+        Ok(0)
+    }
 }
diff --git a/drivers/gpu/nova-core/api.rs b/drivers/gpu/nova-core/api.rs
index ae023242594e..876451dcc051 100644
--- a/drivers/gpu/nova-core/api.rs
+++ b/drivers/gpu/nova-core/api.rs
@@ -12,11 +12,12 @@
     types::ForLt, //
 };
 
+pub use crate::gpu::Spec;
+
 use crate::gpu::Gpu;
 
 /// API handle for the auxiliary bus child drivers to interact with nova-core.
 pub struct NovaCoreApi<'bound> {
-    #[expect(unused)]
     pub(crate) gpu: Pin<&'bound Gpu<'bound>>,
 }
 
@@ -26,6 +27,11 @@ impl NovaCoreApi<'_> {
     pub fn of(adev: &auxiliary::Device<Bound>) -> Result<NovaCoreApiHandle<'_>> {
         NovaCoreApiHandle::of(adev)
     }
+
+    /// Returns the GPU [`Spec`].
+    pub fn spec(&self) -> &Spec {
+        &self.gpu.spec
+    }
 }
 
 /// Expose a handle to nova-core API
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 933bd3657db1..91db64dcaea7 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -43,12 +43,14 @@ macro_rules! define_chipset {
         /// Enum representation of the GPU chipset.
         #[derive(fmt::Debug, Copy, Clone, PartialOrd, Ord, PartialEq, Eq)]
         #[repr(u32)]
-        pub(crate) enum Chipset {
+        #[allow(missing_docs)]
+        pub enum Chipset {
             $($variant = uapi::[<drm_nova_chipid_NOVA_DRM_CHIPID_ $variant:upper>]),*,
         }
 
         impl Chipset {
-            pub(crate) const ALL: &'static [Chipset] = &[
+            /// All chipsets known to the driver.
+            pub const ALL: &'static [Chipset] = &[
                 $( Chipset::$variant, )*
             ];
 
@@ -122,7 +124,8 @@ fn try_from(value: u32) -> Result<Self, Self::Error> {
 });
 
 impl Chipset {
-    pub(crate) const fn arch(self) -> Architecture {
+    /// Returns the [`Architecture`] generation of this chipset.
+    pub const fn arch(self) -> Architecture {
         match self {
             Self::TU102 | Self::TU104 | Self::TU106 | Self::TU117 | Self::TU116 => {
                 Architecture::Turing
@@ -165,13 +168,19 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
     /// Enum representation of the GPU generation.
     #[derive(fmt::Debug, Copy, Clone)]
     #[repr(u32)]
-    pub(crate) enum Architecture with TryFrom<Bounded<u32, 6>> {
+    pub enum Architecture with TryFrom<Bounded<u32, 6>> {
+        /// Turing (TU1xx).
         Turing = uapi::drm_nova_architecture_NOVA_DRM_ARCHITECTURE_TURING,
+        /// Ampere (GA10x).
         Ampere = uapi::drm_nova_architecture_NOVA_DRM_ARCHITECTURE_AMPERE,
+        /// Hopper (GH100).
         Hopper = uapi::drm_nova_architecture_NOVA_DRM_ARCHITECTURE_HOPPER,
+        /// Ada Lovelace (AD10x).
         Ada = uapi::drm_nova_architecture_NOVA_DRM_ARCHITECTURE_ADA,
+        /// Blackwell (GB10x).
         BlackwellGB10x =
             uapi::drm_nova_architecture_NOVA_DRM_ARCHITECTURE_BLACKWELL_GB10X,
+        /// Blackwell (GB20x).
         BlackwellGB20x =
             uapi::drm_nova_architecture_NOVA_DRM_ARCHITECTURE_BLACKWELL_GB20X,
     }
@@ -200,8 +209,9 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
 
 /// Structure holding a basic description of the GPU: `Chipset` and `Revision`.
 #[derive(Clone, Copy)]
-pub(crate) struct Spec {
-    chipset: Chipset,
+pub struct Spec {
+    /// The GPU chipset.
+    pub chipset: Chipset,
     revision: Revision,
 }
 
@@ -289,7 +299,7 @@ struct GspResources<'gpu> {
 /// Structure holding the resources required to operate the GPU.
 #[pin_data]
 pub(crate) struct Gpu<'gpu> {
-    spec: Spec,
+    pub(crate) spec: Spec,
     /// Static GPU information as provided by the GSP.
     gsp_static_info: GetGspStaticInfoReply,
     /// GSP and its resources.
diff --git a/include/uapi/drm/nova_drm.h b/include/uapi/drm/nova_drm.h
index e35f09a1ebe8..26a5e7ca5425 100644
--- a/include/uapi/drm/nova_drm.h
+++ b/include/uapi/drm/nova_drm.h
@@ -132,9 +132,60 @@ struct drm_nova_gem_info {
 	__u64 size;
 };
 
+/**
+ * struct drm_nova_info - query device information
+ */
+struct drm_nova_info {
+	/**
+	 * @id: The identifier of the information to query.
+	 */
+	__u32 id;
+
+	/**
+	 * @size: The amount of space allocated by userspace at @data. The kernel
+	 * will return the number of bytes it wrote, or the size of the queried
+	 * information structure if @data is NULL.
+	 */
+	__u32 size;
+
+	/**
+	 * @data: Pointer to the userspace buffer into which the queried
+	 * information will be written. May be NULL, in which case nothing is
+	 * written and @size is set to the size of the information structure so
+	 * userspace can allocate a suitably sized buffer.
+	 */
+	__u64 data;
+};
+
+/**
+ * DRM_NOVA_INFO_GPU
+ *
+ * Query GPU information. The result is returned in a
+ * &struct drm_nova_info_gpu.
+ */
+#define DRM_NOVA_INFO_GPU		0x00
+
+/**
+ * struct drm_nova_info_gpu - GPU information
+ */
+struct drm_nova_info_gpu {
+	/**
+	 * @architecture: GPU architecture identifier. See
+	 * &enum drm_nova_architecture for currently known architectures.
+	 */
+	__u32 architecture;
+
+	/**
+	 * @chipid: Opaque GPU chip identifier. See &enum drm_nova_chipid for
+	 * currently known chips.
+	 */
+	__u32 chipid;
+};
+
 #define DRM_NOVA_GETPARAM		0x00
 #define DRM_NOVA_GEM_CREATE		0x01
 #define DRM_NOVA_GEM_INFO		0x02
+#define DRM_NOVA_INFO			0x03
 
 /* Note: this is an enum so that it can be resolved by Rust bindgen. */
 enum {
@@ -144,6 +195,8 @@ enum {
 						   struct drm_nova_gem_create),
 	DRM_IOCTL_NOVA_GEM_INFO		= DRM_IOWR(DRM_COMMAND_BASE + DRM_NOVA_GEM_INFO,
 						   struct drm_nova_gem_info),
+	DRM_IOCTL_NOVA_INFO		= DRM_IOWR(DRM_COMMAND_BASE + DRM_NOVA_INFO,
+						   struct drm_nova_info),
 };
 
 #if defined(__cplusplus)
-- 
2.54.0

