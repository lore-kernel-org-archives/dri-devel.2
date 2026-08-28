Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA4CAC61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 03:36:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ECCF10F21A;
	Fri, 28 Aug 2026 03:36:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="U8ajB+65";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011068.outbound.protection.outlook.com [52.101.52.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8A3710F21A
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 03:36:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YxIhYmMDKxz6G2Aacic8jxsQN5HIajqPQCRK3YttsrQCiIcjwoKZLXwz4Hcq3szfiB9AmfNAi3ye1jPLEfT3QjMfpntuwJyGyQzVf+r7aiP6DUzM1bI+hOlPk0dHSXny9kq+jmgAlBaGeQUmSUw6R4ADUUbIDAmfUJp77E09/eSbtKoKT9JDaVtIeZYYavhn8aOU/GkTuNc1Q8MUtd2Yh0YBd+DknT24rQW83lud56uhtWGdHBjjdY82u2BcjGsVeVh3fhIPTEJGSRY4EIHOfaXoT0cux6wDDgS+SClafQYwqX4/qvQcoJIyJ4qIFVn/NxPBpH8kDHbzXD+8JDcjgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yx/a+wPFhyMO4Gd9rKtew4p9AkUIC/ogjR2bgTBxTZc=;
 b=J96A3Y5V9XUFR35osiiiYmQD89SIHYQH5v2YfsVvU32JyFtikmZyEJqiYaKVU2SR78vb/NW4YFFSoCQyK/QD8TIfGFSvv+1ySPfe+P/ka8xXyBaAIdnX/GNe7Fn01oWZrJFGvHRxmpU/K7DkGKp+90CYsH7P5Yh+iGhULwcq/5M+NQHZfpFsAtd8aZohkA6T7UjKQZKS/zkDAHKoVJ8qeO3tmejM0LWC9y3CK2deiM7hiNutob8z23dTPPrJ7wJWcVuLatwqYS2al8a6cLsyKksLrnL3o9iVM9PPG21EPAf5wtqR+OxTz6sWcydGVxYYPNWvLfTxa/zl1ZW+LJEHDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yx/a+wPFhyMO4Gd9rKtew4p9AkUIC/ogjR2bgTBxTZc=;
 b=U8ajB+65jEsqZLrm3laYeh/4cceEY8EXKZHTtyUBeTpfMyxgQSz5j/Gv1R78K1PyfUnr7wOcvTN4ZT3Hoe6Qkbgf3hhQeguYAm2CDLrR0h26JDk2B/dqJJt1J7VgE3SdLPVHkUDv/6bxlg813bg9EyopodJn7RuMcESM6JR+9bWUe2vR/3nRToDaboL2BMjFMwJtGQ3aiIL4hDM0kPKbu4x1oYoq87Q8Pc+5DaC4amjgO5sWthsb8mab4lum6myHHKTsQzDU/2t2CnhbDVPv505rZNLNfDSrujw6iE4aPjPzwkvKfc7eEIQ15dJ+26DUOGbcx2U8xb3DxbGf+YCRPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by SA1PR12MB6919.namprd12.prod.outlook.com (2603:10b6:806:24e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Fri, 28 Aug
 2026 03:36:27 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 03:36:26 +0000
From: Alistair Popple <apopple@nvidia.com>
To: nova-gpu <nova-gpu@lists.linux.dev>
Cc: Alistair Popple <apopple@nvidia.com>,
 M Henning <mhenning@darkrefraction.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>,
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>,
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org
Subject: [PATCH v5 07/11] drm: nova: Use nova-core to read VRAM_BAR_SIZE
 parameter
Date: Fri, 28 Aug 2026 13:35:27 +1000
Message-ID: <20260828033531.1117754-8-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260828033531.1117754-1-apopple@nvidia.com>
References: <20260828033531.1117754-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0013.ausprd01.prod.outlook.com
 (2603:10c6:10:e8::18) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|SA1PR12MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b7f2256-153d-4deb-2edf-08df04b58a6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|23010399003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6I6qvySt5A+U4BeW6mmAe8vsGA1lQ5FA6DuKEzFMD5GqXaU7w19AJQkmKtIQk+zzv/JEiC/75XtqNpi23OmXbpdRRyF1kpBv47ylbG0+zpLxDRMJOlo1YT6MTBLrMHphVEfIhHyVKi3FCBNGnMGa4bx+CB1Sy3xleGNm6lBADSwT2u7eN8xVPk2KwluiYLt6fTJORhFOziSRlBVAHZtZBKXf+rxi6j+2f7Uay07IXT1QM0pUUjOKW72gnHBJsLNNM8V3npvd7CG0qCLcfe5hzDY4SKpsZJt6SHf/NUFIA09p+gasCse8Vpn311jphavbb3CZqwcpDa2NJ5d8gxK5NPRo0BDsjzm0ZKPO9kRZu49V8C14iJ4xsS5B1hN2cN0zMs8Oee/0KD/QsaFdfI6wSOV8XL34StNw0WgW94hlF8WiMI+ZCmlYw5aKX12fgS6g4vad5AKRl3HVzoUYVhqabIrnrv/wMkA4HYmGJOCE3H32/ze5FpfOICyn6QaGwd2z6nEGI2g2jM7qfghmnnvNotQVLXlzsvaKbrPJepKKIK/2G8g6xjs3iHcmiQoR65KAOo7Etlkgk5jGsC6tqq0tosSM1AKDCSDEqRnXn6ELBlcqN7hXrF6xif941O/RHtYYpZrI4ZacTIXFkJcLAyTAZxNLD5yphdfA12NaHLxUKqM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xPBHhRAY0O9iOSQqIupATtszMNekh+z7WzPMQA645KBLjf6JOfLEzxIxLY42?=
 =?us-ascii?Q?EEs2IY976XMdmQkG5rx7+VdCAAJJTmOavbIbfyneBM22HzTgTh09qzB2ddj+?=
 =?us-ascii?Q?MdfUOJ06wDbjuyClJIbTjgfYUf1sC1cXLbbxBUWMg47eGbxoil1JjoYDeuL2?=
 =?us-ascii?Q?DoGJnnnXfbeIVqkz5kmhAxq6+yZjlJQg398s2f4TA/rAdglEMl0/5yVWXMID?=
 =?us-ascii?Q?ACnE/9XXphd3ET6/gJkQhUGpU2NqyM1Z1G4r/wo3QGK420gZcz0G1ue1u2a/?=
 =?us-ascii?Q?assbAXZdJf8LzQNd4n1CRopI6JLjndbE4ZQZkK6XBfyobkNqDok0jbOXKE+6?=
 =?us-ascii?Q?0+yKQ53WmAVbFm5XWb6jQVJdWOh9s/WPMsm8QuGQpUUEHvTBtpUfJnALgeXR?=
 =?us-ascii?Q?//7dl/eP4jHgB/mMkYmmSxBbFDl9GvUBb8pIAUwZz98asbX7xZX7s5ONFY+u?=
 =?us-ascii?Q?Z0pUyjpgEgheiWdwt6aXc+y26dD5DEPhSzSnwGMt01X58AlAQbBpfQ0jZdhH?=
 =?us-ascii?Q?te5I4CMqDJvadTC3zqp6lervVC7me9ApLRWSF9+eM4ItjvddYXoJaflIQW31?=
 =?us-ascii?Q?6jmXb1PgSuoVAm73BKaDEiJ0VG4jOIluBhG6tMgpGXWonnLDzbzeEStehZzQ?=
 =?us-ascii?Q?XkTadLQxb6QcR0XBZ6fzbO7ZICm6A+hIFBSQjSrIi2xREitIxRVT+lwxKPAX?=
 =?us-ascii?Q?NWbl4eB+z+Psy61qKF4LkiaBRPegn1Gy37N9uzihTB/JAb38mIGLjV1BFtWR?=
 =?us-ascii?Q?9jnSZBiFnB8dPzkBl6n1REIhSHHkPaY5T5WOmCQYrMjnU4iBj9GhfJspy2jw?=
 =?us-ascii?Q?zE/6ua1bpN0Cz3rTJYEx1F9kxA6y3FIlRMHcZxDX/DSDaM0nISlBWgJMraoL?=
 =?us-ascii?Q?RzrurEceWGRGoq8CRO94FfvsWqVMnYYfs5bUPOdTAu8+ZgPUuQe6EL0/yegs?=
 =?us-ascii?Q?7l1ofOP8iwPt4jt91/g6MmX4kyDXP1ZVAQr3mHNensQ08Iiz8LVjnpNtoBHQ?=
 =?us-ascii?Q?xsdVXdeqxpaRInnOBPbZIeR0FyFxpfuLkNUjtkiMepz5MQ6/3Xjt4sj74vz/?=
 =?us-ascii?Q?ss5yMVvhtlJu78E3FoJ0PCns8nebLAn5aKppGEd0jh4AOJRsh2DzktDYp5WA?=
 =?us-ascii?Q?SVwh9XHk3fHZsUgVveBlaLaj41GjBWdIYD3hL59KY9m5nHhTpyLNp7rxBz9O?=
 =?us-ascii?Q?FDulxP8BoYqtJ2adaq1WQMVxn9iTQxcq+sTLBnBDhv+YixvKFmSieg9bVIrF?=
 =?us-ascii?Q?6qhSZJ6WsdrhDB+BH/3WPDsbpm2Dx+jUgu5KomkwlMWsP+TcezNx+QNv2ct2?=
 =?us-ascii?Q?aq98s+I0cU4D5uOO+uI5e7ySwQD4hBYwd6yrQA/NRSBkPIE1hN25mRxqSklA?=
 =?us-ascii?Q?5P1H8V16frGTRvToseQCQcR3WXR1G1Zr/w9Xyri8+Kkmrq+qxBoT/x/SgR1S?=
 =?us-ascii?Q?lpwrh3GaUXZ57AvxJAMlW5mZzIybqrspvcHlAO/HswLnv0PHH13yu2BmYfvJ?=
 =?us-ascii?Q?w1FxnCtVWZbLQy556b0izv+FSN8YH5YW+RjaxptFeZNmuH8kDwRnmcWUVX3h?=
 =?us-ascii?Q?epOmcfPW4mPqhn4BkTwXkmYJZhfM5Gb0Xm3DlgDphuvn4WgPlUykztXBhp0s?=
 =?us-ascii?Q?5V3S/x5R4DAmPQaf2FpWGvAnTkZFsPzwrf+EtGBNDjwBOLm+00UNffsXCAGK?=
 =?us-ascii?Q?IAGE7lVcv1NrrneUsb9clVE+/s4iuaT5/6wTD/lLsdEAaG8vhTdgEYfiTODr?=
 =?us-ascii?Q?cComYdKnew=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b7f2256-153d-4deb-2edf-08df04b58a6b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 03:36:26.8879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yqaIO1zaw6eQMYg83UG9i9fzZa7A8ykiLUOGlD+7/8fFKrmUz5kdGMYP1LEzxp9gmN5NqTyxWSsuEXyPKd8xdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6919
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
index cd80c5402eba..6fc169c66d02 100644
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
@@ -68,16 +65,13 @@ fn open(_dev: &NovaDevice) -> Result<Pin<KBox<Self>>> {
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
index 1e73d27d701c..f4fd78f9c321 100644
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
@@ -19,6 +20,7 @@
 /// API handle for the auxiliary bus child drivers to interact with nova-core.
 pub struct NovaCoreApi<'bound> {
     pub(crate) gpu: Pin<&'bound Gpu<'bound>>,
+    pub(crate) pdev: &'bound pci::Device<Bound>,
 }
 
 impl NovaCoreApi<'_> {
@@ -38,6 +40,12 @@ pub fn implementation(&self) -> u32 {
         self.gpu.spec.chipset.implementation()
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
index 078a3371a7d6..e0e84f5f9c5c 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -111,7 +111,7 @@ fn probe<'bound>(
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

