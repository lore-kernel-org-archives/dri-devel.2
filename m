Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC24C5AD55
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 05:07:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 956D510EA55;
	Tue, 11 Aug 2026 05:07:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="T8Us+bz6";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011018.outbound.protection.outlook.com [40.107.208.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF89E10EA5F
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 05:07:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Age1TJw7OLWGlh00sX4WMf+0lz1wa52E52dKTrzuK5rIXFhcyj4BbpYgJzTljwkMMfuJhzItf2hXee0cb8XgEz6zDhL4KBd0vhHSopd+IM1woHolFMWMeBem+NJFTLcc0UhtXaZVcmj0IZfIl3LZw2ticTyYP22KD0zjGYduL/YAPSk6sGDtaAXf+SUZ12T2IU+YUQUDCNtFb3qFKsbxAryuzyz06oqvEZpnQUyMwb9uXlXDkAqWAzPqV6hh6N6pfhAvkv6IKk3NihxwTyOJ4ehdnnlhkPBsHOYTQxPKkXlHf0ctkIGuVPyFRXScclGRFi2jAqlEgsIUvmZXrOdDNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hznI+PZgEb5kmJ/PhqFhYiakga5BB9FnzGqPomE6PmU=;
 b=Tc/m2m0CEheEuwhnUrQVRYOXh3OUHjsabPP8IOBfnkQZlQFUD40oSulXiqylIL1ISjqj4qnWZ2wzxdvXo0WoyOfKwEEab3D1B0VIgswuIvRPzDzg43I1tth6fmPeyDfU6nFZrusaJMgGrngBN5i9vW56nhhj154eXZn+RpeFSY3vqfAadvepgXEEI4F/B2sOI/lqy7h5ZFx1pXafWHWsioXilKlUfOZf6Tee1wwXJ/DzeQT5a0+MCtzEqaV6KbCyhLU4yBG2uJxaUefRoi/90KH3Q5k/17qyloPGSZjlk9ZLA6NL5h75j8G9Dz+Dalxl3KQoGKZe3Uo8mzww2XJY5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hznI+PZgEb5kmJ/PhqFhYiakga5BB9FnzGqPomE6PmU=;
 b=T8Us+bz6MxALpd6Mjsxzh9oyrOBxl9aV+IM+YLUAWba7aUvctIG6PmdTBroW2XL1de7ZO03WVUL7f74kCtLQv13DHIh4Tk54+rQuU2RyKsv9b1MPZ6D77HnP2dCZ2MP6cJCM8IAc5oekHBIzIGuyKo+6lnBxT3kJAQI1SB5f7HnXGi6ajGejpMtt6ZIXqZkVYCJWhtgJAxakshM5TsBcgvhHkAUhVs2IrlGmQczX7aJPccaugmb9QQndyJhpxEcZ0Tc65/DENUipKDbV6ZX68hl5q5K/YwYDbFzcaQ589u+py6Yq7s8Vv4RuKzzVXMMzCNMfkstfPIyKhbEkjp0vdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ2PR12MB9088.namprd12.prod.outlook.com (2603:10b6:a03:565::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 05:07:30 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 05:07:30 +0000
From: Alistair Popple <apopple@nvidia.com>
To: nova-gpu <nova-gpu@lists.linux.dev>
Cc: Alistair Popple <apopple@nvidia.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, Eliot Courtney <ecourtney@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: [PATCH v4 4/7] drm: nova: Add a GPU info ioctl
Date: Tue, 11 Aug 2026 15:06:54 +1000
Message-ID: <20260811050657.646799-5-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811050657.646799-1-apopple@nvidia.com>
References: <20260811050657.646799-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P300CA0038.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fd::11) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ2PR12MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: 69dc6584-856a-43c9-2504-08def7667193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Q3Li+U8A1lJD83zm9LuP4AD0HzfT2FwYNwI5c4rSCchZz/mmvEwJbIsqbrNzDz8jwyJbKwuGzbEIPs8QjeabTceOZuWucUg2W3GTxOnT9rGmmPpF2RURySU+fySxeraQ1j2T2aw2nh4wVUFExJTXYWrTNsnRZVArofMbNLxyh9TUOowgDAirNLfe0w1EjcPfpsPvlerZ6gxvnf2kjSov4fSgATtPplEDZ90xL74VXR/42lmRnyXnHgnDYMa76f1woIcaJNnL1ltv1l523u7EJHCyQzQb4qxbwfB+x3oFpwSUmUY4H9qYNTtQaczgGWrpOmy9sYkZMrBe1G1nIPdc3R10vmAyeEut4IdZ9FiRV8SDk7Btr+4WXv6TrkaQkZBsmca8r23zM9APqYNMOfHweCym0UF8DuWG8QLfUAemvH3LFLGZU5A+aZo9gJ72CZUZvgcclfszCfeqT7WZnvfEKzxsTAVkVan/lJ/jrEPH5N9V+rA2qksopJUlZ7LN7WtnLzBo04YW5LeZnCSUhRypNtXbLxwykfN/isS4dIziS/r4EWopkpbH4SOHO8VzrOaDMSwYCU+VJbMmIQu8AGOqmhHKXgb4eyVF7qZswtwOKFC5TrEzI1n/Ni1IQfMwR+cIErKnc57zW/vmf+wEb70H083DklXfZ12/Iu5oD0eLTOQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3qnC0y012KfL1GVGAhEGsgbk+BrobCetTF6lEJ++qNxvvZKfz6RDOS7y8w54?=
 =?us-ascii?Q?tOO6DiqxlGNuYcXNaH9OAX1G6locawuyauapejRv856EbibpasG1bjCsDF+O?=
 =?us-ascii?Q?8P6+Jojal05e++rcrplEp7U5a/iEaxNpMntvjBhv1mMyugdDLHS3j7NqbnSG?=
 =?us-ascii?Q?ByUf6/grqCXizwRtfo/tBEmJWYYbTgKB8E0Xc28L1zTxScyPfAGjBVyIcl31?=
 =?us-ascii?Q?UsiXNhRu8XoES9z26DtzdCPyfySrYBX85VQLETh6zxTch/5om/bONQPbhTMu?=
 =?us-ascii?Q?FzPa01tig4ZHVZJR3MZG5QH83wfnb382Q9i3zw2PXxslkMQ4ydcLGdy1LJgE?=
 =?us-ascii?Q?kM/VHSGpVhik4ewPj3NPAgil6y/XqBnXBQmNETH22d7qtab+uqHWppCWgzml?=
 =?us-ascii?Q?BC6F6m95Ctp+CSDRU8BcPOFu09FAGAAmCt7ljB5ppHe/NihajvY5Gb5iFD2a?=
 =?us-ascii?Q?9Bheurfz66smtAc2STlSO0dT9Kdc5Hcr2Lhs3lU35d/GIXml7dGduli0GT4q?=
 =?us-ascii?Q?PEBb6tKXUgMVOfcp2d0c0/+gY464XfeYAWRDFDO+0uYwkfeNBLbA85nmJBjw?=
 =?us-ascii?Q?TJ1pzOWDfEjnXOGgK3fpetEG97p2/TX+LMTqnYlPMx9v2EgfhkGqE5O+4j/F?=
 =?us-ascii?Q?z42b+UOOLx30oZWZRlD0treS3561bulQ//K+3lta0DVdbVWBpnsfP7IfOzcc?=
 =?us-ascii?Q?d5OeUMaRg1tnVYmWLPZArV8BRMjRvS2oGDww9wl2vv+AuS6dbiLfvjVMQAu4?=
 =?us-ascii?Q?YZk8VTxfPz88oj8no19Bk6awSMuMMdI4qwJCGZwNKXbWnBycT0CsrqBTK3Jv?=
 =?us-ascii?Q?zXsxxun4UGdmOSv2gIYQq/K1LPmlBqEiU+EvBG9HbcZsie+JuEz6qwxV0jx/?=
 =?us-ascii?Q?/HMYKjk982ZoaDT7TgnT0tiAibkcY2azBTQz3tvHyOG4ve2KA7MOUvKq5tX8?=
 =?us-ascii?Q?HccQcutZfxi4uZzDihe1hvxxdxLHHk2X/83z66pjf3WVccXkDTugqRdkuZpP?=
 =?us-ascii?Q?C/vdEzstl3OJVS9A4dRTaIixMDKPYR0zX9JsIJZDwJ8jBbl2FwAoSXQ6F/Lt?=
 =?us-ascii?Q?mzV0+wK8upPNkQBxEjlJVF9A8ThzvtvvxznIk1XHf9sNduSXXmWLca+dpVp2?=
 =?us-ascii?Q?R5KF+UcVgm+hiNnMLtf3eQ2fDgXk0qjLkBscbNaCX2lI6ugyxCqwQhInRJGv?=
 =?us-ascii?Q?VgsEFEny/6ii2ME3LtxCZ6rujvkR0an6IEOEP/241+cpxpvxUVuvxghI2uL1?=
 =?us-ascii?Q?xmuw0OHFT2GmJDDeI5tinbdraS6+nNGqaNCCAf3QkMlDFJ9J2nRdHvb0tChl?=
 =?us-ascii?Q?32+cEEGMF+f2TgTUMkk9J7Xw47Sz2gPce1eLl9RYdnWQ1fAwbefIz+ZATWhv?=
 =?us-ascii?Q?9B+Uv/AVFNK7XNykTG6/zZ2GBU8oypN2hfzi+H8QabqMoZe00Ae3Wct1GDjI?=
 =?us-ascii?Q?qza+3xXz7AJpD6iZEfRppNaGL2Zjpj+sScw5N58Z3PD7fq8oNlTWYNIrJd2Y?=
 =?us-ascii?Q?iiY7D9kYhE9zKpJHrq9YJDDrRwXK5eQovNEHmydYONDdl4kRZb1OPdNEh1W9?=
 =?us-ascii?Q?cN5aI2/e4LNi6oJBsKcl4pgBbGK05jKxdV5eMw9dMdw1Geszagj+2Xpi3iNH?=
 =?us-ascii?Q?HsYJrAiH2ZHLk7AvKtR2Tai1FPDqUUuabZaKOgQgn+6ry3DHijWt1sCH+CRN?=
 =?us-ascii?Q?F7wR4ir9NmcqxX5OouyjDWrnv9hwa3amlmPO2MTkNXDXHsXfztHvQFrFhmEu?=
 =?us-ascii?Q?fbzaq1jl+g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69dc6584-856a-43c9-2504-08def7667193
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 05:07:29.9236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0IVYv31uFo76JOdEz9b6pS7FEaHBbVynGhR9r88Wyquh9blWL7s6zOCCHtNTt1Mfi2HZJ+ICeVeiBwi0nQ+kqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9088
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

Add an ioctl to read basic GPU information. One of the first things a
user needs to know about a GPU is its chipid, so add that as the first
piece of information to return.

Other bits of information will be added over time. To facilitate this
the gpu info struct contains a size field to indicate how much of the
struct the kernel has filled in. A user passing in a larger struct will
just get a subset of the fields supported by the kernel returned. Users
passing a smaller struct than supported will just get fields truncated.

This also allows a user to probe the size of the required struct so long
as the data struct passed in is large enough to hold the size.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes since v3:

 - New for v4 - was previously returned as a GETPARAM parameter
---
 drivers/gpu/drm/nova/driver.rs |  2 +-
 drivers/gpu/drm/nova/file.rs   | 17 +++++++++++++++++
 drivers/gpu/nova-core/api.rs   | 11 +++++++++--
 drivers/gpu/nova-core/gpu.rs   |  8 ++++----
 include/uapi/drm/nova_drm.h    | 27 +++++++++++++++++++++++++++
 5 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
index 632137d1c6d7..d6dce160f371 100644
--- a/drivers/gpu/drm/nova/driver.rs
+++ b/drivers/gpu/drm/nova/driver.rs
@@ -32,7 +32,6 @@ pub(crate) struct Nova<'bound> {
 
 /// DRM registration data, accessible from ioctl handlers via the registration guard.
 pub(crate) struct DrmRegData<'bound> {
-    #[expect(unused)]
     pub(crate) api: Pin<&'bound NovaCoreApi<'bound>>,
 }
 
@@ -98,5 +97,6 @@ impl drm::Driver for NovaDriver {
         (NOVA_GETPARAM, drm_nova_getparam, ioctl::RENDER_ALLOW, File::get_param),
         (NOVA_GEM_CREATE, drm_nova_gem_create, ioctl::AUTH | ioctl::RENDER_ALLOW, File::gem_create),
         (NOVA_GEM_INFO, drm_nova_gem_info, ioctl::AUTH | ioctl::RENDER_ALLOW, File::gem_info),
+        (NOVA_GPU_INFO, drm_nova_gpu_info, ioctl::RENDER_ALLOW, File::gpu_info),
     }
 }
diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
index 1156df51c533..97688edd07af 100644
--- a/drivers/gpu/drm/nova/file.rs
+++ b/drivers/gpu/drm/nova/file.rs
@@ -78,4 +78,21 @@ pub(crate) fn gem_info(
 
         Ok(0)
     }
+
+    /// IOCTL: gpu_info: Query GPU info.
+    pub(crate) fn gpu_info(
+        _dev: &NovaDevice<Registered>,
+        reg_data: &DrmRegData<'_>,
+        gpu_info: &mut uapi::drm_nova_gpu_info,
+        _file: &drm::File<File>,
+    ) -> Result<u32> {
+        if gpu_info.pad != 0 {
+            return Err(EINVAL);
+        }
+
+        gpu_info.size = size_of::<uapi::drm_nova_gpu_info>() as u64;
+        gpu_info.chipid = reg_data.api.chipset() as u32;
+
+        Ok(0)
+    }
 }
diff --git a/drivers/gpu/nova-core/api.rs b/drivers/gpu/nova-core/api.rs
index 610cfc01111e..09da0b4e9103 100644
--- a/drivers/gpu/nova-core/api.rs
+++ b/drivers/gpu/nova-core/api.rs
@@ -12,11 +12,13 @@
     types::CovariantForLt, //
 };
 
-use crate::gpu::Gpu;
+use crate::gpu::{
+    Chipset,
+    Gpu, //
+};
 
 /// API handle for the auxiliary bus child drivers to interact with nova-core.
 pub struct NovaCoreApi<'bound> {
-    #[expect(unused)]
     pub(crate) gpu: Pin<&'bound Gpu<'bound>>,
 }
 
@@ -26,4 +28,9 @@ impl NovaCoreApi<'_> {
     pub fn of(adev: &auxiliary::Device<Bound>) -> Result<Pin<&NovaCoreApi<'_>>> {
         adev.registration_data::<CovariantForLt!(NovaCoreApi<'_>)>()
     }
+
+    /// Returns the chipset of this GPU.
+    pub fn chipset(&self) -> Chipset {
+        self.gpu.spec.chipset
+    }
 }
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 738a590e753b..34a496ec3b38 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -41,7 +41,7 @@ macro_rules! define_chipset {
         ::kernel::macros::paste!(
         /// Enum representation of the GPU chipset.
         #[derive(fmt::Debug, Copy, Clone, PartialOrd, Ord, PartialEq, Eq)]
-        pub(crate) enum Chipset {
+        pub enum Chipset {
             $($variant = uapi::[<drm_nova_chipid_NOVA_DRM_CHIPID_ $variant:upper>] as isize),*,
         }
 
@@ -161,7 +161,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
 bounded_enum! {
     /// Enum representation of the GPU generation.
     #[derive(fmt::Debug, Copy, Clone)]
-    pub(crate) enum Architecture with TryFrom<Bounded<u32, 6>> {
+    pub enum Architecture with TryFrom<Bounded<u32, 6>> {
         Turing = 0x16,
         Ampere = 0x17,
         Hopper = 0x18,
@@ -195,7 +195,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
 /// Structure holding a basic description of the GPU: `Chipset` and `Revision`.
 #[derive(Clone, Copy)]
 pub(crate) struct Spec {
-    chipset: Chipset,
+    pub(crate) chipset: Chipset,
     revision: Revision,
 }
 
@@ -281,7 +281,7 @@ struct GspResources<'gpu> {
 /// Structure holding the resources required to operate the GPU.
 #[pin_data]
 pub(crate) struct Gpu<'gpu> {
-    spec: Spec,
+    pub(crate) spec: Spec,
     /// Static GPU information as provided by the GSP.
     gsp_static_info: GetGspStaticInfoReply,
     /// GSP and its resources.
diff --git a/include/uapi/drm/nova_drm.h b/include/uapi/drm/nova_drm.h
index ea7665383644..2604e4d2698b 100644
--- a/include/uapi/drm/nova_drm.h
+++ b/include/uapi/drm/nova_drm.h
@@ -118,9 +118,34 @@ struct drm_nova_gem_info {
 	__u64 size;
 };
 
+/**
+ * struct drm_nova_gpu_info - query DRM GPU info.
+ */
+struct drm_nova_gpu_info {
+	/**
+	 * @size: The amount of space allocated by userspace for this structure.
+	 * The kernel will return the amount of data it did/could actually write.
+	 * User space can use this to determine how much of the struct is valid
+	 * when running against an older kernel.
+	 */
+	__u64 size;
+
+	/**
+	 * @chipid: GPU chip identifier. See &enum drm_nova_chipid for currently
+	 * known chip identifiers.
+	 */
+	__u32 chipid;
+
+	/**
+	 * @pad: 32 bit padding, must be 0.
+	 */
+	__u32 pad;
+};
+
 #define DRM_NOVA_GETPARAM		0x00
 #define DRM_NOVA_GEM_CREATE		0x01
 #define DRM_NOVA_GEM_INFO		0x02
+#define DRM_NOVA_GPU_INFO		0x03
 
 /* Note: this is an enum so that it can be resolved by Rust bindgen. */
 enum {
@@ -130,6 +155,8 @@ enum {
 						   struct drm_nova_gem_create),
 	DRM_IOCTL_NOVA_GEM_INFO		= DRM_IOWR(DRM_COMMAND_BASE + DRM_NOVA_GEM_INFO,
 						   struct drm_nova_gem_info),
+	DRM_IOCTL_NOVA_GPU_INFO		= DRM_IOWR(DRM_COMMAND_BASE + DRM_NOVA_GPU_INFO,
+						   struct drm_nova_gpu_info),
 };
 
 #if defined(__cplusplus)
-- 
2.54.0

