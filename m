Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C9CC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 08:52:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B518E10F3FA;
	Thu,  9 Jul 2026 08:52:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="aoYQOlRJ";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011008.outbound.protection.outlook.com [52.101.62.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0E8310F3FA
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 08:52:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZyX8DPyiAEnHBiQ17d/3CjCWLj0sRtRQ7LZvX0TWBw49hkKqRRyAko6z0YDIhY85dSEw/fg0k+2dWfegN+jXPnErHr/zaOc4XWitqm7GV4OZk+AeAzb1kOxRx+Jpalg/I66t8KxzIt3Bj9qSa1Z1v35fd7rf71lyAD2oPuH2VM7skvQ1g3ktk6rro3/hgb1pI80GJcbndTOMfI0OXpX7y3W+ln+ZFGIepd0Ou3W8Ui5q15zV2Kk1txOsdq1KhJcevrvD6hUlGeK7dvJHiA6bBxnCrCsfmKHYKmLdS93PQDAefWJYxQbWVpZwR+FhRaaXhKSTyN6A/yK3Vj2RC02Ncg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0xHBlt2hGhMyN1ggPX8BGTflyqQCjRz/0G7UQXDghk=;
 b=Awek0mPBCUMset5aLFu8xv79Vv0ykowbd73QfBknlu4wbWVGTIGpn6VBDCMJZPq5mWXoCfFJKsFynI18Y3PeqDL8Zo/XK3zJzKUgtKfkWlxcyWtuXNzq7nZ2ucsawHAXgpTv9lMXwEVzN6k7C84jdo7PwDYcB5QPJ8dqxgZ2bX9QyQ8WV/58YCFH8BTNlf0kyBcKeP8F/elHomVlBzjzyP1okQ/D1gJys2H3eZSg15Sv6Pp344IxdhH6zceElUIPg6SbxLBkvsmmETXuK5yfBxOeH9fIhywL6Y0FAGpFR8RkpDmRWKotQf7c0hnLJ8FZ3Rd2Oci1DHjsVPVLQppArA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0xHBlt2hGhMyN1ggPX8BGTflyqQCjRz/0G7UQXDghk=;
 b=aoYQOlRJGn5/vTmB3UY8dIxFMmBjXfNWf0UwIS1PWZLTd3qIjSTI/Cn4bTil5p6i6kr/LUzyiJ5TUWGf4l5LFZzJpYon49GEJth1TKkc299R4kGuttNwOmuFCkf1zck6vTOp3QcI3vQK0AAqvOmMAe9LY8A/qyMYSpRoJkN14FJk9dTlxRSd/JkkwIT69t+Pji1XdgOcDys2oKs6CGuDgd22kwMorfPA2zF7XN34N22vT3fOfdi5CA8kvB9exWna2gWdsMNedEPzy3nMMV04WeGTPf/tHI4gEVpDOAh/bla8pnAUok87UQ3urDx/9zhpLM5xAA1Lp+kmrDRTG8TgEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 DSVPR12MB999283.namprd12.prod.outlook.com (2603:10b6:8:41c::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.15; Thu, 9 Jul 2026 08:52:39 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 08:52:39 +0000
From: Alistair Popple <apopple@nvidia.com>
To: nova-gpu@lists.linux.dev
Cc: Alistair Popple <apopple@nvidia.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, Eliot Courtney <ecourtney@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: [PATCH v2 5/5] drm: nova: Use nova-core to read VRAM_BAR_SIZE
 parameter
Date: Thu,  9 Jul 2026 18:52:04 +1000
Message-ID: <20260709085204.565159-6-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709085204.565159-1-apopple@nvidia.com>
References: <20260709085204.565159-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0120.ausprd01.prod.outlook.com
 (2603:10c6:10:1b8::20) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|DSVPR12MB999283:EE_
X-MS-Office365-Filtering-Correlation-Id: 480e2742-349b-468f-42a1-08dedd976e5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gIB1G9Pj0/z1d6lBcyfOMxVCa+ExfZNdAVWW41nExD2/Xhlf08G2/EgnDZACGoV2jXdNUjhrn4bfq9qI1aiy7G0mDge3SIXUtgXstBv3FFKEiqO68X0kSaW0nC0hPy4ubyGQMC5Gifn+CK9416YRgWiyRd2OnVoyrvkl4Rk7s+/lNle5Vh1MH4ByZWSIOl8UDHFYMxsftfzCAwE3U9CRvt/DzFykwcHCo/WjgMLhJCWfRJXSjen7QJqRfDKUdAXxpKTJV3BM3PKKjjqvXm31L3UHL3v1frXPz6i2U1Y4drnD3kGAFcqrhbFlP1/oQEv6f8Gn6is7K1BZfVyfi4kXSmYK9yH0Q0VbxL5kLT/Kd8F2s9gZR5dUSpEIaFxgnbWS+U82zs+sNYjzYBzS4+82+NbRPnE477/UamiTAVf5U4juALo1A0IHPpFrYIXFyXNBae98gsKmSMt2Y9wv/h1W1hcHVUa8F0UvOUHHn1VuI0/k2dxEqCLsrqpM6vMQ9iTfGvEuxxYOKyUgzDw20xshSwKHmYgm/4jzKmVbeefsxl5lM6+BtxUXDkP3egKlUfjd/BccVdCpKBGmy9ETnz5LAzUrcjIhGTd288XJdH9vMrHX00zZDKODtajjXrNV/s3JintV9FGssGOdSUEV1orK3kUdHcJAnYxIhAaWqA0HdIw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gxd6lRbn7x9TpPKT0qzZ3W4cWK4OC5BB//Q73C6KU+qDRZjwcZ7rZGZHbFLe?=
 =?us-ascii?Q?FVSti9MqYITjFDgrIyLDnq4OaGjAG8ee/YRLU8HCJXp7uwsgt2QVTdyHvfb+?=
 =?us-ascii?Q?+89Sp9kbPeE2DICr2CgP5D6L4SQzkCyjd7deJrwk1RBJCuAcxOpesxoT3Zu2?=
 =?us-ascii?Q?n/xi2wn+VQpgiGAUayj1Or9ccahvnuNheVHAnemege8+08v4g1AP6GfgRdID?=
 =?us-ascii?Q?Ue9oqI6Iy+UK1Ea6UkJHleBVd/t+5Pk/kzKSKaTfvEELXsjRlYM0bMrW1FfV?=
 =?us-ascii?Q?k7aR7Z4OZPH05OHeQvQw2dSzCTfM+CPTY37S3E1MvVKla6JXXwfQIzSovbos?=
 =?us-ascii?Q?5klcFU2nY1UhG08uzOhRW6sTvlMm3KTUexnd/FQeMCutCGQ1WDcOfC9oCl9w?=
 =?us-ascii?Q?msItCnSK6UTgt7gWsjEPvyMCQDGAFNEEoNmfs9QDm3w+df2IUTNcA/hk2aov?=
 =?us-ascii?Q?IFt1zZu+y3K69NhfmvQy8ts/NwPry3EogzM1KRXiuJuK6g3ra5uPOsvGLK9X?=
 =?us-ascii?Q?WZ3bnk7LEVmJECdYIWOX0yguTRVmkpzmOHXY7CFB5qoOSB/iYYukU9A1PJLy?=
 =?us-ascii?Q?wh3q1oehEVoMbvjT/0OE+HPvJr5KnMJ7lX1hhFwCsLdulYs4Wa2TsdInYnKy?=
 =?us-ascii?Q?ADnLR90ea5NZK35E3VhJ1BGSXnemC8aKCrANaRX/YKrJhmWr3HucgSZx3DES?=
 =?us-ascii?Q?wnkm0zvf921QW+BoNa2ZJF+800s7yEZzkmbkbknjljoODWzdolU3DZsxhP9R?=
 =?us-ascii?Q?E8EFleagQmJF5wT1W6nxvtxWRLS0TEvTNJjlz9LGYluBddYNthGOVqHEpSQD?=
 =?us-ascii?Q?EgnmNqZD8J3aFVOikObRt+Yy/NRsm79wRM0QKEv8LWfRChrwu4xwoC2D4fLP?=
 =?us-ascii?Q?oY02gOgNjZnHamn0jDPPHST+Wcxkyqm58wBldAvQ3MfcvvDj/K72RLBUwNnz?=
 =?us-ascii?Q?eh14nIX0ytht8fOp+QOldJ4lb3S0LCTB7vNw5Yxia8Vvy48TClt2Keyo1QZ3?=
 =?us-ascii?Q?mjJXH7C7hx5ZTaqEk0o0/Z8LHyc6DAhwIB70g7vjFB6A4Boq23MF+WbZNGqJ?=
 =?us-ascii?Q?46IAyShygIt4k6zGkCyl7LIKvfEZlFwKkX8Ldf2WqLtFwHLO2sA5liDL+cgJ?=
 =?us-ascii?Q?dJ+Z1VeKEEYuIYoZLpI8PP73H3SJCSk2Kebxv8cUsPRhShjgtGeRchTBi55d?=
 =?us-ascii?Q?sqf8Np2EmpPbLVrexvO/d1dgaol96vQIGFg7bmSsb8KtqoGFR53R/WqoHttR?=
 =?us-ascii?Q?Y+AaVRZDBSSw9kHTRDQo3avnurjHPkGynVZ0tNFRK2ne4Io3aobuuHdl36Tg?=
 =?us-ascii?Q?Tf7+IrUWbjFIpkCo+itvWKoyI37kf29VMF/yXGjMI1P21hFLtjn3mcuYOlGX?=
 =?us-ascii?Q?ExnWwT4XqDgYvtu9Yeow8kTdDabUPGO9eOIJGuUL5kZJ38OSI1JsbpUrpTne?=
 =?us-ascii?Q?SAYpy4A8EgvFec1sQ0167DrhDmh79HFlG+NC3DCIM1KGg+PieRhowYI6U6Fd?=
 =?us-ascii?Q?i+IN1XPUFfg4BIpRcUVjdpiEakhz+VbdfVaC8WEFRZxlhTHPs09MrgUkRJZc?=
 =?us-ascii?Q?Hu0TEc0gTFsWSuSYTcz27/E0inQtmkwORZJctRtPe5R5iB5pmYvTt98z8+Pp?=
 =?us-ascii?Q?CEg3b/UwHIdIxv7elJKALE88pu9/PiVF1HDGKWgmtclkVvw+lX11CyvCfKYI?=
 =?us-ascii?Q?qJ+Bua8K2afRo07P2NKalPz5z2M7znFH5SKhiL44XTWgAGucwwPzjRxobc0i?=
 =?us-ascii?Q?mmtECpRJZg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 480e2742-349b-468f-42a1-08dedd976e5b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 08:52:39.5921 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p6ip3ajeoXLYEzwemmASXWBZiOhJJhRrXcYAE7aBGlihI+ZZ36RHNdDL2x8BbXvQoe2mNVj9UaJBTc3rNCGKIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999283
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
 drivers/gpu/drm/nova/file.rs    | 10 ++--------
 drivers/gpu/nova-core/api.rs    |  8 ++++++++
 drivers/gpu/nova-core/driver.rs |  2 +-
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
index 31aea3283474..de645f9197ad 100644
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
+        _dev: &NovaDevice<Registered>,
         reg_data: &DrmRegData<'_>,
         getparam: &mut uapi::drm_nova_getparam,
         _file: &drm::File<File>,
     ) -> Result<u32> {
-        let adev: &auxiliary::Device<Bound> = dev.as_ref();
-        let pdev: &pci::Device<Bound> = adev.parent().try_into()?;
-
         let value = match getparam.param as u32 {
-            uapi::NOVA_GETPARAM_VRAM_BAR_SIZE => pdev.resource_len(1)?,
+            uapi::NOVA_GETPARAM_VRAM_BAR_SIZE => reg_data.api.vram_bar_size()?,
             uapi::NOVA_GETPARAM_GPU_CHIPSET => reg_data.api.chipset() as u64,
             uapi::NOVA_GETPARAM_VRAM_SIZE => reg_data.api.vram_size(),
             _ => return Err(EINVAL),
diff --git a/drivers/gpu/nova-core/api.rs b/drivers/gpu/nova-core/api.rs
index f025df90dc5d..d7b18e33b5f5 100644
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
+    pub fn vram_bar_size(&self) -> Result<u64> {
+        self.pdev.resource_len(1)
+    }
+
     /// Returns the total usable VRAM size of this GPU in bytes.
     pub fn vram_size(&self) -> u64 {
         self.gpu.gsp_static_info.vram_size()
diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index a5dabc84fbc6..84c713b23c53 100644
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

