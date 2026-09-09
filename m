Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21747C79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:46:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46A6610EEF4;
	Wed,  9 Sep 2026 06:46:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="FSFKkICR";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010017.outbound.protection.outlook.com [52.101.56.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4308510EEF2
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 06:46:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mchunf+lJE+3V7GaNVeY3Z8/nAKf4i64COagmfEG7ujH4zDlC85+OF2JWK6GW1BAJdWVNhZHsxwjW88vP6rHzzLSoB9+be4CatQRdNotitdqUUE95nY8WimkjtVkZnLTlK5fhPrt9qtrb5gt6tlUkCOcQKm5N5QAVT5pkWER7efPTL29lberB6Dv+X+7xLUBK1+k0YE/YtL/9Ol6QUFbTSdSQXfLK/GInoOwwyxmem3LmBdfnhAY0pd/W3hjbguyk0ihqmSIotdBgZD94Bi7V2x02NsCqw73ecJg8yJ/1hksvld4OietbaSRlRWryeHN8/XnWWRoGqm6SW2sXAB9BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZG0f1cdL3kUlzF/0Xb3RnBtDNCvfaA4y/FN4iAPdZsI=;
 b=q8VzomwdlbUxBtQ4IDiiXV+SFPfkRMAJH/I8wWJDeaPgROthgf3rkj6BGOGz9ryMla79dBu9oKF9oYdxmlNrkg1P6Wt3EoUBEGow4sb4tcimve/k7nz0vIdT2JYqq9pfFQ3bG8Dsjv8bvpfZRwS5m/XZd9ClSaNdpfbRWixaksqID1CggqsYTU4w/x6b23E2xGrvHWO6h9AXREAhfXmIfvIN6VdDaYLHbgXeOg6gXuABQLNqWWym4XhdVGbP8/BAXLmg+2xX4rc9uI9cbYCWa3ZPIHSX2thv9TkIdI7jShZ7WCtYPRrIGvReVUv0A3ycZJIC3SLJsecr2PDb/0w5Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZG0f1cdL3kUlzF/0Xb3RnBtDNCvfaA4y/FN4iAPdZsI=;
 b=FSFKkICRGZq5K6vohn5B6dNsQ6KzU7qhVP9ZOBpOfT/9Zzb05PmhZgjj2eDOplHCuhN1V3S5/MSn8c9uIBaLgvXlWYIA06yGJVCsueD7G4nYjOe6vdL3hy5hxNOmQIlZ9/VlE+xW0ZInuSl+phWDvhHsvnm72cYC4Hf5Dsb1drpMEZ8QfJRjtaTpyLlLZxnVPh7Byhe9dEcLI99cQBOvoKAMApY034WfIrMWHztg1ByXhBv7XNXsC9m52gQQay13YON3zWdLJUDY+9KErRdjcTH0+fTHXWoI+nAdI52P83WCrf4RG+wAGOnZxFwppgrYCAQvNxbpcfLE0pFMqIPhWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by IA0PR12MB7697.namprd12.prod.outlook.com (2603:10b6:208:433::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 06:46:22 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 06:46:21 +0000
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
Subject: [PATCH v6 12/13] drm: nova: Report GPU short name in GPU info
Date: Wed,  9 Sep 2026 16:45:05 +1000
Message-ID: <20260909064506.910162-13-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260909064506.910162-1-apopple@nvidia.com>
References: <20260909064506.910162-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0055.ausprd01.prod.outlook.com
 (2603:10c6:10:1fc::15) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|IA0PR12MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: 02ad602a-dd28-4e3e-8fd6-08df0e3e0f12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|23010399003|376014|1800799024|56012099006|10067099003|11063799006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9Dne2rF+YYjlMeQvqg7Ia1d6KJeGRuYwSix93GDBLw81oAtFcUkdu8+yQxr2RHPZLHR+nRiWhv31/q/RlT4ggmXxIzEIbyyQU4E+8tvpgSw5pqg8Nx61xc29akMNMKjn40zpwyHmtmafzt+vv8d5mo3PSa8DkjsE4Part/MGa36cCAK5Ny9F11QlwG5yJ3RyN0uohQiauHJTJxCh5hWbR7vDklqXzVNKrPKKRtMnDHH7tVMKJaIEz8zoiTesfigpYoYgxPdrs8lrLPWXq94Mh5Jwi5bnjUl+oOMwI8P7T/jzja/wEnmRP/jdZAXVlXiO+kENG13uHvUeT/5U3T0Mi5vTceDJNcGELRCg6pFU/QNAvPYhpri3tJ0jm7CFGnDPu1rD0gQg9EusDl5AfFrpMwMpuMj+Tw/pxJSbao1AXY8o0mjGgalM12rquyH2sPQDsArmkbURoQTaIxwQRbs5T44YoYhqZaUZYraw3bRCC6RLsve+0ou/8KqJFL5s6Nrcljvmhc4sSgCCbpUaYpN/uPjdmU+OuxoO3u+KaOf+Dpoo5bo1l2ODtZrwfulVw1J473cIis/W3zXQ6I/qCSDcK6l05+XKZA4VKUBYlsKXGaVgpygqogHMBqn8TuFDX+Y6G9+zfZhvuWX5ia68JNTic+l9wvOfXZ8nAH/LR04JdIM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JAV6yAw5eft5r9xkfcfxggCA59lP3CzCIdgkoZE6gScozhD9YIY0YKw+78VJ?=
 =?us-ascii?Q?I3EBvt/7e85nr3UMSwAPpAzy/wGxCidjwjTxtJdl5tDQplZ5dA9CjiaX/pKj?=
 =?us-ascii?Q?tSsq/jEHBbpm/h82yWxVKAuCdJzw3k1/lk1QYojR/JXTajEuhDZhiwQDuSX+?=
 =?us-ascii?Q?qESumM8q9zb/BP5NUgGsSoeGILx7xR/em5PzpinO2/wNKj7UFSbMovlGoJMx?=
 =?us-ascii?Q?xztPM2p/a5/p42EmUGxo2lHQh7VpElGz5+gyRkhwV52y1LtnVuEquxkdy+Ju?=
 =?us-ascii?Q?eDNZjemafME1lhQlxK+zYFMYbo2Hh3hIAbBo+uyHkeYAhyGu4AXWfif8dz2t?=
 =?us-ascii?Q?HdqAzILe0vDgTP51KJZ54NYIFWDC0vjMOE0mrZGQAeP3nWWNczJsIOpnrCQb?=
 =?us-ascii?Q?H3wmAowj0necqPzL2oocyvhdmuaBD9SYrw2OE7whZrAftqJko0p2QHGDG2lR?=
 =?us-ascii?Q?JDUU9CiACUzmKTLder9hGxo26YL4z7faidWJuQmjxfEL/F3dDxsVWimN5mR1?=
 =?us-ascii?Q?NtaM9uSgw2O6q3v9OJbgHpcShw7nAsFpC9SKLBPj3GUEBjkU0uqVyE0POybp?=
 =?us-ascii?Q?s6nap8U9+mSKq3w9iNSAysWjSvAGUibP2XJkBSsxua01ZV9B9CfVKTJXHusw?=
 =?us-ascii?Q?XEDTXLmxX60CO8mHsARwPQW/mIiPFbi/caXH5w02fzHEtLGx7qblmDEaKjAy?=
 =?us-ascii?Q?5wv491Hv6EFHPOr+S7NDXTi2K8+TpwwbDtaylo79WI1G2GkwuFH3jA2O+z/K?=
 =?us-ascii?Q?b4UXdOZgJeP5b7bmcfa7QWW9K/wbOkhFb4EWMPClfx0JtFAs5xBLdrByzDCr?=
 =?us-ascii?Q?0ySOBzKRcVlWNR/q4vmkb+BAEtGRIs6+RA492xJUZTe3U7aeE8OYjKGdCGkQ?=
 =?us-ascii?Q?wpljWvOKAIf4tjikX/zVVCh2FH7dZAeuw4VzF6XJQAkaPvSs5sswmUhtM/RQ?=
 =?us-ascii?Q?1zwkAniznbd+pZimnNkp8/tA1Bo3Ws9DUO11h3uoiS3ESJgyp6plG5N0hO8v?=
 =?us-ascii?Q?48x6jt0p1mGc1waDWVka9ecQMLXy5KCpezJL4C4IknAwtC+DfVF7r80MB9Vp?=
 =?us-ascii?Q?iraFwU1iQgYdbCKblGwkeXqB72aebLR0PqOIC3WtrOVRurvtaRcEk4JzR6AQ?=
 =?us-ascii?Q?yREIEUx8/BUPr3OuSsQ0j5l72mmtGjn2/HuOokVzAfDKJomUEQ+3fIyCk1Ms?=
 =?us-ascii?Q?q1kQiK/sFe+ewbEI9sWMWDcqVCmZzA+EUj4IrI4bnTUabad2fYDzx2RzzrvW?=
 =?us-ascii?Q?BY6ISCotHBzxzQoTO/iDnHCFDWyM5/M/LKz5JU6J7oPbUfufJ8XlTzTEjBBq?=
 =?us-ascii?Q?d7+Kq7YZC3YOWZXnBPeyN96Q2QW7APb6ePkeRyiHHdijexr7fTxtuT/ku/B7?=
 =?us-ascii?Q?Xm6/n5/VkpHFqwNu7hEgAtsEko7KBNIHg41MKVgSL0hLhNVOh3Rk41VTp/t7?=
 =?us-ascii?Q?hf3ZQu4cqjZ/TbG2bZqqMW6SkoDFtzamCVK0VvkUtJirufBcFO8RC2PPJ0RX?=
 =?us-ascii?Q?EMhO3h/TdGMMM+N+Nbl+LX739gi1aX6W8DcV0BX81l4ksSwmPJ99Pfb8p/q3?=
 =?us-ascii?Q?1hgOBe/GqWB5aT2iL1+ZKi4cTzSG2LtNxmgyUYkfKK5UJFPx3f9j38cZP1lp?=
 =?us-ascii?Q?OgbLDmX7L2SnMs6TC3HZvA3I82v7mEZA93Vv6SKlEEAGAf9K62aXgDZO38+1?=
 =?us-ascii?Q?jnxdPDVvh9o8aSKw5pljvsjVuB0YkOtvaVXxQluASpxmKYFk0uPeDVyCWSDR?=
 =?us-ascii?Q?nCvfRsrHiQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ad602a-dd28-4e3e-8fd6-08df0e3e0f12
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 06:46:21.6702 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZdmrLmyeaexN5Ts9HoubSjqKkFA22qISMew/+Y6eLCQK02iP7L4SLWb2tYkJ+CWU5pUUxrBaxtOznqHyKtG7w==
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

Add the short GPU name to the GPU info structure. As with the full name
it is copied from a validated, NUL-terminated string extracted by
nova-core rather than from the raw firmware bytes.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes since v5:

 - Add a validating gpu_short_name() accessor to nova-core and use it
   instead of exposing the raw bytes, as suggested by Danilo

Changes since v4:

 - New for v5
---
 drivers/gpu/drm/nova/file.rs             |  5 +++++
 drivers/gpu/nova-core/gsp/commands.rs    | 13 +++++++++++++
 drivers/gpu/nova-core/gsp/fw/commands.rs |  5 +++++
 include/uapi/drm/nova_drm.h              |  5 +++++
 4 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
index 4753d9bca13b..d2e1f9f798a4 100644
--- a/drivers/gpu/drm/nova/file.rs
+++ b/drivers/gpu/drm/nova/file.rs
@@ -61,6 +61,11 @@ fn new(reg_data: &DrmRegData<'_>) -> Result<Self> {
 
         copy_name(&mut info.gpu_name, gsp_static_info.gpu_name().map_err(|_| EINVAL)?)?;
 
+        copy_name(
+            &mut info.gpu_short_name,
+            gsp_static_info.gpu_short_name().map_err(|_| EINVAL)?,
+        )?;
+
         Ok(Self(info))
     }
 }
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index 00cfcef260c5..5ea0f625f7df 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -214,6 +214,7 @@ fn init(&self) -> impl Init<Self::Command, Self::InitError> {
 /// The reply from the GSP to the [`GetGspStaticInfo`] command.
 pub struct GetGspStaticInfoReply {
     gpu_name: [u8; 64],
+    gpu_short_name: [u8; 64],
     /// Usable FB (VRAM) regions for driver memory allocation.
     pub(crate) usable_fb_regions: KVec<Range<u64>>,
 }
@@ -234,6 +235,7 @@ fn read(
 
         Ok(GetGspStaticInfoReply {
             gpu_name: msg.gpu_name_str(),
+            gpu_short_name: msg.gpu_short_name_str(),
             usable_fb_regions,
         })
     }
@@ -261,6 +263,17 @@ pub fn gpu_name(&self) -> core::result::Result<&str, GpuNameError> {
             .map_err(GpuNameError::InvalidUtf8)
     }
 
+    /// Returns the short name of the GPU as a string.
+    ///
+    /// Returns an error if the string given by the GSP does not contain a null terminator or
+    /// contains invalid UTF-8.
+    pub fn gpu_short_name(&self) -> core::result::Result<&str, GpuNameError> {
+        CStr::from_bytes_until_nul(&self.gpu_short_name)
+            .map_err(GpuNameError::NoNullTerminator)?
+            .to_str()
+            .map_err(GpuNameError::InvalidUtf8)
+    }
+
     /// Returns the total usable VRAM size in bytes, i.e. the summed lengths of all usable FB
     /// regions.
     pub fn vram_size(&self) -> u64 {
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index 6dc31d1bf5ae..f62fb85f4473 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -131,6 +131,11 @@ impl GspStaticConfigInfo {
         self.0.gpuNameString
     }
 
+    /// Returns a bytes array containing the (hopefully) zero-terminated short name of this GPU.
+    pub(crate) fn gpu_short_name_str(&self) -> [u8; 64] {
+        self.0.gpuShortNameString
+    }
+
     /// Returns an iterator over valid FB regions from GSP firmware data.
     fn fb_regions(
         &self,
diff --git a/include/uapi/drm/nova_drm.h b/include/uapi/drm/nova_drm.h
index c692cacaa552..b0af9945b6c5 100644
--- a/include/uapi/drm/nova_drm.h
+++ b/include/uapi/drm/nova_drm.h
@@ -191,6 +191,11 @@ struct drm_nova_info_gpu {
 	 * @gpu_name: NUL-terminated full GPU name.
 	 */
 	__u8 gpu_name[64];
+
+	/**
+	 * @gpu_short_name: NUL-terminated short GPU name.
+	 */
+	__u8 gpu_short_name[64];
 };
 
 #define DRM_NOVA_GETPARAM		0x00
-- 
2.54.0

