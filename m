Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B3AC5AD55
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 05:07:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE82610EA68;
	Tue, 11 Aug 2026 05:07:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cl9/R56m";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011020.outbound.protection.outlook.com [52.101.52.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0932810EA68
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 05:07:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IrfefEQgj2CfrbcY3w7vwfa8AjQga09CNwHg4ngspfnYBJqIwmxMflsqcss8cZbPfKVYFtabZnwijtJ1hgWiAhd6phrgePYLjMBA0dnSJhLdiczCN4h21Vw1OyM68PEP1cRbsD1k64vfTItxFeC84oG3oTYl5N7aq6IZy24RQzz5ITLccTFSCXx5Bm2G5fQsTOCBK/V0NJSJjRaa+ijG9JYJ2sQIJxk0tjYSZA0M4/Mio6qtsiRFHchOB63Hg4L6J1eVzWi9puVObaT54tFz0FjjZhQDvxEQpTSM9lO0iBghxHoWTxb53/+PHqitnwelY4hMvX8V/tVm4uPC2aIJ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNNxWag3T26aNpfEv6HrnKIkQEuwPWgOyHWjLLC8D3I=;
 b=NYUojhhj8z2y7+xOUHEcnKan8YiSsfszHjO/26osk4BuO8I6igL3yVGhxd8F9HVmH2PR82ZNSUgIgRZFzsZYHbyAKBdSqHIQlYS9WCVYH7788B/nCFKDPPtSqlw+j86a37s9gFx4PI13Hvc7896GtlUNlmhhoe0nS+Tmz/buJvsw8yR1GzgPGHANyL/nNcdrDkeKviv9uLCC1lcSdY3rgmqR1HVnhHvYnUW06hEhneHajxOFePmR84FyeWuolCLenDHtw3Jup+AfQ1XpmWgoJkalnAcRgNrE0wdECj79RLwK65tMFqzPfKrKy3ehGGpuRHWneS1zbYyNEafeZtLgIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNNxWag3T26aNpfEv6HrnKIkQEuwPWgOyHWjLLC8D3I=;
 b=Cl9/R56mAocTcNCR3qTmF/z7hsxvIvD8xASqXYOisil4CO4WqeLmv2mkFwIgi4EtdrqfR5nzUEl2urw5VoDngbfiWq3FjY8rkuvy1DwkpwtrNVM63JZ+Qoz3oG8D3tVXMkomTIMo5Bb1ZP1eoQoLtv7iVLosMJZD37qtOFmj3rRIB8588aacKEhyoNYXy3A8OvisaNbNvx0cVtTnVJXKvqngUgGicniyi6wb93nSXSym7odzszDtL5jwR+ZcU9rVrY428eP96gtnBOUaoiaSl4cACEDKlBdyElGBiCFfXZNC+OECAvc5R8xkEBpsx89FXFJYxYuqD6Vuqv7n+9uovQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ2PR12MB9088.namprd12.prod.outlook.com (2603:10b6:a03:565::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 05:07:41 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 05:07:40 +0000
From: Alistair Popple <apopple@nvidia.com>
To: nova-gpu <nova-gpu@lists.linux.dev>
Cc: Alistair Popple <apopple@nvidia.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, Eliot Courtney <ecourtney@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: [PATCH v4 6/7] drm: nova: Use nova-core to read VRAM_BAR_SIZE
 parameter
Date: Tue, 11 Aug 2026 15:06:56 +1000
Message-ID: <20260811050657.646799-7-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811050657.646799-1-apopple@nvidia.com>
References: <20260811050657.646799-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P300CA0040.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fd::7) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ2PR12MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: 35e60a8d-4702-4b8f-b7c7-08def7667807
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2adel1t/if8N2eG147mWPyFr/pjUVoddm2Cbmu0UV7AIjnlucak/urLFr4BdoDRWpIeHpur3fMnanOitFz5QYoVcGLqVVlLtHCpeCSkDgFAqumj/6MypU999P6RbM1Cv2DXlBIaHOrBrNzJ1sIZhwjJBAhONrEaxoAldFyjY3jwCfXazr5g9JRbkWMZExpaMzGlMv/AGlnVq3ABVpxqJ5DRLXPd4/iVmrKElXz7DEiG4IYisx0+kg3w9PIOZ9peC0sP3R95Po2CaMKtVClaIclZ37HMBVHgDrtUJdvmBYjSd+sq7nqLtn6LLOjUtADaPGjsfgaLVAzAq9AHDVtebMlP7Js1LhhyYu1BMcDLVRrWYFuOuNUllQxlS9ALq16buJq3sa+4IM0H8u5iuaI289mvuBkPtIZ2ks1d+nH82kbgjP4NwT0ycO5V3pb/WbU6sn2Gvhn/mM5PjKUVfvE1FZS34uEACdQAiKM4uG/05UeDyy3U2SQjudao4wv+b1aXa86wyTzKL8nqkbMtuqKYTFO8PF+myw8Q/miNnCUc4ct85KtFEAzA7p4tef/n0v/HVV/faOcZ+AF5806KV/wnhfGiHoQ6ZGqwo5j8v+HZ0f5G9cxj5MV9MFCOrSghxFYAQd2IOpN5vVcjPkYqOUsgx1PPv+8WUUwA7Ufvf1WgiNCk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LCu7/NPFDnQeC5gP8kKCxe50jTJbJklleBptUsaSEe0dhBzyNBXiDkKkzsjX?=
 =?us-ascii?Q?T0toV4hJaPaqFcbq7I1RObppTL++yYgqJ//sMl5mZPJaGhm2Gkn4M1zLeWiZ?=
 =?us-ascii?Q?4xu4UXk/8gMca7WdLrmQLsGVLXDLI61Jl4dqpJoWU+fm4WBYFs1om5HAF+G8?=
 =?us-ascii?Q?/r96/uUht0HFHGcyWfXT2ONL+UZCCMt7iJeyjidhCwWRSDB+p+o+r0O/mLH+?=
 =?us-ascii?Q?9RAMCWFqBsRHKmZOQhaoa7+RVQ8EwiJEOjZtW1G1TmGLx7YMtbBPsXN4tsMi?=
 =?us-ascii?Q?PGk6KyBj4+3gY6s28vH32yzVHwiXKj03AYFWYNn+c4RNjowHlR1568EVVxsD?=
 =?us-ascii?Q?AcDnw1bKmFdNBkCxIu9jCrXqz4e7PVHmZWww0XRVHf6c5zuBsXXH7TPbEujq?=
 =?us-ascii?Q?9/qJJX82XDgS7Jsghr3t5SZqSKUKkRFzV9sarQvcgDZJ7i3QZ4K+EHviS5Th?=
 =?us-ascii?Q?2aNU6jwgZYp06GOvpEZ5cGkbTQ6WiKIK8RgCME7ckLXDYIoGi8Ezav85sLqx?=
 =?us-ascii?Q?YEEYUTIVp+BwLQSKqKjmBHKkOEkiRxJfQSG0uElje5o9isa05Zb8UyfCUtRU?=
 =?us-ascii?Q?usXsolYBq28qwzk5aBP+NJCcaTGF00cefCnD0A3vhAuGWtI6QNGgKvcZ6Ctk?=
 =?us-ascii?Q?WiDIFx0ZrRLRkMlL7gngDWauhf7m0OR4a/n2lw0LT/4GoSEPzGlUI6LhGHEI?=
 =?us-ascii?Q?w+r2vqDduDEylyHu49glQdOUVFhB/cWUgIGg61tNvPa80npQr4DS01ctDTOj?=
 =?us-ascii?Q?rdvrzrR9WVxaGYL1M9wTHkyFBdT39vXo6nwhgt8718EYjcWGgw1usMkWVpuq?=
 =?us-ascii?Q?AH4P34kHLkN+ZrJCQV60pmBd11REgssKGQWQbdHLiDBbXFxXje/zBIkcpmfq?=
 =?us-ascii?Q?isaL2POOvsKD8OBUTuNI63IvJ48+ieTDNUsfAU6c75/AbpdbvvJvwDOqp1Dv?=
 =?us-ascii?Q?mNBxibUIIMbH8XkEu2CEIkGzJU9Qqq/EQQUGSNbyT7n+Y0cuNWOe+JR6vp6P?=
 =?us-ascii?Q?pMW9W7mDvx3aqtNejT/nDpLUQhCnC7fVCLXHWkiOTtRsUFElw7GGLsmeyCP8?=
 =?us-ascii?Q?TmuB16ABcsj0ToGJW7eAyY8o8K8ETQJHXalAq9mnCDwha/eaT/8HehIoP9AL?=
 =?us-ascii?Q?s2AcazyuoOFT5pTJZzgtQ5xh/TMY0mpwLSZOM+S3FPVY3ks0LM8lDS6zq3MI?=
 =?us-ascii?Q?NG2ms796GLl5R7MThC6PHuGJLwqZlYWzkwcYCBAue8LmSC+viDvWLDSxISHj?=
 =?us-ascii?Q?hJ7KuINPopNXA/5ck83RUaMdtl7KKHRpU7nGCnXJuEon61bkWiEs5udWrkKF?=
 =?us-ascii?Q?TJIYvFYh4IMblXUdaqUUaRyIrMWRitkBITKWhfjeXeQNQSRY7+/QKxDKzpYC?=
 =?us-ascii?Q?HA4LDcsZnRJcx2+zZqXx2cF5nfZnIkYFurRS2jlBaTkX8L9MmVwTSX4KOAlr?=
 =?us-ascii?Q?3Eqbt4daQsnrsDY6ZyklYssnBqFJTwPfMmEjUr/dr/Ns5HuUUth7QTOBEuVb?=
 =?us-ascii?Q?b6jPIQ2Mjz4WZaWADgdbrKDEL9pHeMEVUVGAZ7b0XseAU/nMsw5a1BueO/0q?=
 =?us-ascii?Q?ITDyyxxJnIzDsKrZ3I5nkVVPaTxZVN1k25Hn+k6StNaxX3KSnaB9eIefrYOB?=
 =?us-ascii?Q?FtNX9tggIlicMl6Oqabbbpkfrvdg5BWkYR05mXP/VhI0dMu8Wpp5mS/nT587?=
 =?us-ascii?Q?RSr/SuF/KN32KTY0DfdlxnXzeHvHzLlPR7uvpwApHsb0phwhFFpNWDb1W0f4?=
 =?us-ascii?Q?7ggJBWh7+Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e60a8d-4702-4b8f-b7c7-08def7667807
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 05:07:40.6976 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CxC+urDMYCAqbW8OfzxJxti4CuYXcDYqMJtOyuw6+I3jlMt3wkyISdMVMDxdDGcBTKngV7LCyW+8m7wAtfOgGw==
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

Changes from v2:

 - Update nova-core API to use bar1_size() instead of vram_bar_size() as
   this is used internally throughout our chip HW.
---
 drivers/gpu/drm/nova/file.rs    | 12 +++---------
 drivers/gpu/nova-core/api.rs    |  8 ++++++++
 drivers/gpu/nova-core/driver.rs |  2 +-
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
index cbe45d022ac6..9e8d140e517a 100644
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
     uapi,
 };
@@ -33,16 +30,13 @@ fn open(_dev: &NovaDevice) -> Result<Pin<KBox<Self>>> {
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
+            uapi::NOVA_GETPARAM_VRAM_BAR_SIZE => reg_data.api.bar1_size()?,
             _ => return Err(EINVAL),
         };
 
diff --git a/drivers/gpu/nova-core/api.rs b/drivers/gpu/nova-core/api.rs
index f025df90dc5d..9e2a5ba7c269 100644
--- a/drivers/gpu/nova-core/api.rs
+++ b/drivers/gpu/nova-core/api.rs
@@ -8,6 +8,7 @@
 use kernel::{
     auxiliary,
     device::Bound,
+    pci,
     prelude::*,
     types::CovariantForLt, //
 };
@@ -20,6 +21,7 @@
 /// API handle for the auxiliary bus child drivers to interact with nova-core.
 pub struct NovaCoreApi<'bound> {
     pub(crate) gpu: Pin<&'bound Gpu<'bound>>,
+    pub(crate) pdev: &'bound pci::Device<Bound>,
 }
 
 impl NovaCoreApi<'_> {
@@ -34,6 +36,12 @@ pub fn chipset(&self) -> Chipset {
         self.gpu.spec.chipset
     }
 
+    /// Returns the size of the PCIe BAR used for accessing VRAM, typically
+    /// BAR1.
+    pub fn bar1_size(&self) -> Result<u64> {
+        self.pdev.resource_len(1)
+    }
+
     /// Returns the total usable VRAM size of this GPU in bytes.
     pub fn vram_size(&self) -> u64 {
         self.gpu.gsp_static_info.vram_size()
diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 435aa917d3e7..175275fd7961 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -113,7 +113,7 @@ fn probe<'bound>(
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

