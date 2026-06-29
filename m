Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B4EC43602
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:10:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 283CC10E91F;
	Mon, 29 Jun 2026 14:10:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="KQqoDrUt";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012057.outbound.protection.outlook.com [52.101.48.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85E6F10E8FD
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:10:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tmj5rwA7YAxBooGXTH8KgmX9UzzhLcxWILlCu3A8xfsQq8C23bEGC4CyYfXmV/VSN368YH5zVvozvdgFbrz6M2vOSdvbP2rnnrI/IweAwR/qcoW2wRC2pGbUZRJ9LMPporv5T/P7usa9wZWCSP31xmnCzGC6wiyn0mIi/JJOdPUblxXM5qqCJTqZuTKEi8TO4NeoF2cm2mGNQLGmRbUZhsLEmYV2//V0OKZpT/jyjtPFSERDwwJOQ701Pb4HZCneR7zrDer5UyF/ONXJgVQdngm0HozY2vfpa7qK8w4wuHz0wmfp7C1J3Hc1gJPjyrb4W+Y4LcbodWLM/XVPMa5LtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSF7TAeFiDMjX4/dmxY2WePWM2XP+jWwSY0Evu+AT5s=;
 b=jWF27LbNEF/ukQ/AOdvUrDVLnXZ5ayeltumhwVrTgouxGtSkS4NLx+oc0prT24lpjE1k7ckc6GdNRvO1RADvRoA07xBUJHQkDGCB4wOv8PyKb+Yw8OKIXGJcHVBN5f8AwtQuB2O/JXrChYi9+jkat1D0JrhGv4tcI//EWF9LR9hUMGzMV63olOC0wN5QmvvZ1ct0kcjc/MUKhM6ZajHcMqjcyl+YCMY4cSiPNgN2qDUki9E9umseRYd0qdhb4brnit8Kr1otPoSYql5de2NxlrgF7JjMfEubxopFoGs3uRt3oVAe5tbD9Kp8vKBB4Fda2tr7jVTsiF/3LfRxpMe72g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSF7TAeFiDMjX4/dmxY2WePWM2XP+jWwSY0Evu+AT5s=;
 b=KQqoDrUtv9xmF3jfAhpi7uj2zOkB9B51aXvF1A+GqOs4nnoj5T+LURLBF2POFRaii0LUHfuAr5JIyLvmk4RfMsuKX53HQz8Uuu9WF4EhJi1g6YAghxFB//NDlFwy33r1QuKQhD4ptJRi2VCFmHs3494tVcrNF0/s/AEomxk/BYYuFgr5yiRC6QsKVx7BKt9SZEDcEuZDpDYMAJfy4z0vz1NSWeigzVPOdTbEgUjJFQej5zYlLlCYP2Rktek/mhmlwWKhmXLkjzUM+zzSwJ4HwfxPWClWJ5RsesLsqu1X+fQwgGLaQKHNC0XuIlhbY4aGFzBytpDqBlEc8vDb8YWn1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CYYPR12MB8654.namprd12.prod.outlook.com (2603:10b6:930:c9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 14:10:10 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 14:10:10 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 29 Jun 2026 23:09:38 +0900
Subject: [PATCH v4 06/13] gpu: nova-core: gsp: fold TU102 unload bundle
 construction into HAL method
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-nova-bootcontext-v4-6-5539d8469590@nvidia.com>
References: <20260629-nova-bootcontext-v4-0-5539d8469590@nvidia.com>
In-Reply-To: <20260629-nova-bootcontext-v4-0-5539d8469590@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: OS7PR01CA0235.jpnprd01.prod.outlook.com
 (2603:1096:604:25d::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CYYPR12MB8654:EE_
X-MS-Office365-Filtering-Correlation-Id: 39605e1b-638c-48a3-27c6-08ded5e82181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|10070799003|1800799024|23010399003|56012099006|11063799006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: iiyU2DobHmyZ53dVSpKt+r+woZ2aUfIHB87I1mwqLxxoEacsB34R3dc6Fr8ooJFa38FDK3Dr8yq8MD8hdxWc7b3FGxWzuovV+lUhY6D2GS4EQJXw0LS+dnn9qbrHveogDmVgY8f8gaHGpRSpCxakl7smOss0YAX4qwH1vbx2C2p6q0FOduSss/geJ9/LYfLd682x2jGv1+/AsRdiu0+ArdgkP1LW3iiZkOW0LEVkDDwptPD8211ukjXpE7/PHwnTMecqc4445PYcReNa+yBsc19T1wQCTyEWW0Zigsvw14rkLD9JQO7z+QnZrBvAWLagIYioroqLqa9N7d+qUted8LKLSqEQMCDaIXcHvYql4B4cbxfdRmNg+eldtzDS0IcL9Bu6J3wy+6DHPLUh2VothCyGF/jrw/GeWGDXIeLyFOol7E8pCoUXo7M9Y0LWqtpWEdPXY+Gjgb86LanLNuUFH478myFRWwPodw6MRXsAu/cyZkbbQxkzzA4hU8zwqtEpievCu4ledaOnZe1RXtzeBJgsSXKNPteRDdpNNmN2dKkh/KX4F06U3l5Cfp6NggcYExKpVdrik0yxADeiUmMHsQt7y+GtSn3iGTJbioN2Z+TEgV9CFREawWx53UakYfL1qfxm8dorfDV4EczYx0JDtS+Z+1ABYyc8DRQ2OZuY1hZXMJegnkpcV7ElWaOI/qod1ZJ93XkjjqgD7LSFQmzMvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(23010399003)(56012099006)(11063799006)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0txdmg1RlZDenhjbGJCVjhZS1pRSEs5U3dVUGpST0ZiOGFjYmN6ZUpEVmFE?=
 =?utf-8?B?RnUzeEpPK1VUdmIyTVFWT3RGa1RiQnpqeFJ1NlNVRkFYQ1JJM0c4YjZNUlZw?=
 =?utf-8?B?aCtFS0pQK2N3RnpVeWF1bkpWaWE4a0hXbWk3Rlg4UWkxZmgvNkJrZHIxTlRI?=
 =?utf-8?B?T2hpdW9RR1RleUE3SC9wVjJBZE5Eak5VaFVtOVhlSHJpUnNGY3pIMFhnS2Uy?=
 =?utf-8?B?eWhQOVhoS0dscXMxaWVxdURhTUxSRmcwQ1AwZUJWZUoxUWhlTnhKWTBDd1V3?=
 =?utf-8?B?QVl1NXM0RlNadnY5NXY2VUMrTlY0V0t4TTVHMm5jZFFhVmVwa1J5bENTT0pG?=
 =?utf-8?B?UHluRzdCLzN5c0xUd0JTUDBxU0R4TUI1SzNaMVVxTk55MCt4RUgyZEJqQWVH?=
 =?utf-8?B?UC9ZOTl6b2FsK3I0ckJIeTM4U0NqSW5sL2hRRFdlMnVubUMyTTd6YnhxMWJk?=
 =?utf-8?B?UTRhaks0VGR5d0NHZnJ4dkdFTzgwdWZNR1ZLbEFmUWZ3K2EybW4yZ2t3STEv?=
 =?utf-8?B?ci84Q0V2YUQzZGZ6clloV3Avenh0OFFzMnhxdXMwYTNiMDJRVUVwSDVlTHdl?=
 =?utf-8?B?R1ZvazcvakxkaGl3QzJRMkJlOFFZN3VnRDl2L0I2M21FTG1HT1lrMjc4Q3oz?=
 =?utf-8?B?cExIRnEwWkYxTUtoSGNFd1BjMGhXaFpjQ2NRaG1Vc1h0d2pOcm5vMm5BR1Ix?=
 =?utf-8?B?Qnd0SlZ2SGE5VXFSdllodi9mUDFQcXlrQWNvczBiR2VFdXd6SGRHa1NodXNa?=
 =?utf-8?B?RThkS2N0dXMwL1p2OThhcFRwcm9zL0g1T3BVUUFGVUZ3M2ovL3B0ZDhoeUov?=
 =?utf-8?B?Wjh1cldMYVBKN2ZaWkNWN1ZDVzZ4WE5Gd3F3ck1HTXZMYTNlc2hkVVpFOWNY?=
 =?utf-8?B?ZkZvdmlhb21BL1R1NEZFUmxFcWJ2YmFHSHp2a3R3YUh2Smk1TjIzSldYWTEw?=
 =?utf-8?B?OU9hWmpkT1NYWUVrdy9hRFFoMStrcnBkTm1zZldXU1JYTUpzNUJvLzZPOXRs?=
 =?utf-8?B?SktWUWpmWjVJN2g5dVhjdlRTcGhCM2VQZ1hUMXFPK241U3A3K2J2UnVFZXVH?=
 =?utf-8?B?R0RDNE5TUnRWWjQ1Y1RaWkZEamdpS1lVR3FrMTcrUGpJSlJBQnFkb0lzQzdP?=
 =?utf-8?B?Z3NWOUZOb041M01FQTdCWlRjY3VxcGpuSzRQQWV2QnZNRGV6Y2ZaR21VTzB0?=
 =?utf-8?B?NEszQnpOTjdyWis2Y1R5bXpvYzhpZW9vcldIRDY1VHY0eG1ySS9WVzI2UFRh?=
 =?utf-8?B?YVMybHBNcXRreVRrVTh0N0ZpMEY5OGRhZ24wWlpCeUVRQ2FQMkpWSC9VU0c4?=
 =?utf-8?B?OWlSVXRwZTNXYTNEZldyV3ZieHZBb3I2QkNTUVJOa2tueEJJMDdwd05CVXhV?=
 =?utf-8?B?L1ZIbCtBQlVCMDBqeE9Ha0VhRUdiVk5FTUp3c2xBZ0o0SjVxZHBhWFdSVjZy?=
 =?utf-8?B?RGJ0bWlnRGNkcXpXUFRZeCswV2tvM29Cd2o2NXF4ODdVOHJ1cTk2SDBFNmQv?=
 =?utf-8?B?alNUaTg1Qlo0WmV1b1dzV1paWXBBbVVnOUdCUTZpUlAwb2lWdTdTeFRpUERQ?=
 =?utf-8?B?UmdSbW43Y1pGWkd3V2RTYkJiOUROeVdNRm5odVBMcmp6ZzA2dE9uNmY5VUN3?=
 =?utf-8?B?d2RpTFZwejFLcXVxUWtDbFdaV3ZkUjlKTDA4SGoyT0lSajViOGJrTmIrd3p4?=
 =?utf-8?B?ekxINkxKRTBhWUNRRDhoN3FxMkFaQmxpVHhYdnR3QWVDdG1aSlFac1IyclE2?=
 =?utf-8?B?a0ZybktEelFLZ29od2NlcEI4cmJJUHpoaE9qSVJBOFNEb3pUdmlPWFA3Mnp4?=
 =?utf-8?B?MkdHY2hENUtkbExLcXRkcWRKTmJWZURJa2hWK1lsUUNBak1PTWpGcWFsS2VU?=
 =?utf-8?B?QitNdlhZWk5OVVhObndiMnlFZllWREVsbTNKTEpxTi9hV05SelYreWVjRVhJ?=
 =?utf-8?B?ZWY5WjRKTWNhaVZFTjc0RDBTOCtFK3RpSmVzS3JsbU1sNFpxUXNpK3BZdjA2?=
 =?utf-8?B?QzhreFZobUhBOFpJd1Z6dEV3ZkVTUXlwdzRuQWF5Z0ZkbElydG1VcUFmOE1F?=
 =?utf-8?B?S3JEd29UczBKOHR3bmg2VGM2eFJncjVpS2s3ZVoydWJPLzhyaS9iQmNWTmZp?=
 =?utf-8?B?SFdyeVZzakFDMWR6RnpTWU96LzhLSnFoNlBLU1V4QWs2K2F2Tm9mbmFtbmlD?=
 =?utf-8?B?UjhsT3M4RlpUUGVIZmNSOVR5aXRHZG8zLzd1TVJPdDkvUW9sSjRtc3JSWGJW?=
 =?utf-8?B?ZjIyZFRaWXB3UjExTktjV1o0NVNQbHFBVExiWWJ6R0R3OGtVakhVVnd1MUlB?=
 =?utf-8?B?RTlBVkt1eklnZ3IzdHVEZmtVSnFZc1RVWENQWmtUMENEVUprMXU0L0dFZXY5?=
 =?utf-8?Q?r/111K8BgAPkiv+WzLx2QXa8aouxGLotswebJNtjolD8o?=
X-MS-Exchange-AntiSpam-MessageData-1: t5yzXyWaYIi75w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39605e1b-638c-48a3-27c6-08ded5e82181
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 14:10:10.6952 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4DHIEsVZ/MtO6hZDOvP6VoMhrEE9V4xbOBqjMFFpH7yHAHVz0yO7idh6EVtMmxP7c5qDmOfpN8LQ4Vq+Br7k0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8654
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

The construction of the unload bundle is currently a bit convoluted and
could be done in one function instead of two.

Additionally, turn that function into a method of `Tu102`. A following
patch will turn the "use FWSEC bootloader" property into a flag of the
TU102 HAL itself, and making this a method will allow the code to access
it instead of querying `Chipset`.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 87 ++++++++++++++++------------------
 1 file changed, 41 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index ef465b99af05..0505a5beee6e 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -56,22 +56,6 @@ enum FwsecUnloadFirmware {
 }
 
 impl FwsecUnloadFirmware {
-    /// Loads the FWSEC SB firmware, as well as its bootloader if `chipset` requires it.
-    fn new(
-        dev: &device::Device<device::Bound>,
-        chipset: Chipset,
-        bios: &Vbios,
-        gsp_falcon: &Falcon<'_, GspEngine>,
-    ) -> Result<Self> {
-        let fwsec_sb = FwsecFirmware::new(dev, gsp_falcon, bios, FwsecCommand::Sb)?;
-
-        Ok(if chipset.needs_fwsec_bootloader() {
-            Self::WithBl(FwsecFirmwareWithBl::new(fwsec_sb, dev, chipset)?)
-        } else {
-            Self::WithoutBl(fwsec_sb)
-        })
-    }
-
     /// Runs the FWSEC SB firmware.
     fn run(
         &self,
@@ -93,33 +77,6 @@ struct Sec2UnloadBundle {
     booter_unloader: BooterFirmware,
 }
 
-impl Sec2UnloadBundle {
-    /// Load and prepare the resources required to properly reset the GSP after it has been stopped.
-    fn build(
-        dev: &device::Device<device::Bound>,
-        chipset: Chipset,
-        bios: &Vbios,
-        gsp_falcon: &Falcon<'_, GspEngine>,
-        sec2_falcon: &Falcon<'_, Sec2>,
-    ) -> Result<KBox<dyn UnloadBundle>> {
-        KBox::new(
-            Self {
-                fwsec_sb: FwsecUnloadFirmware::new(dev, chipset, bios, gsp_falcon)?,
-                booter_unloader: BooterFirmware::new(
-                    dev,
-                    BooterKind::Unloader,
-                    chipset,
-                    FIRMWARE_VERSION,
-                    sec2_falcon,
-                )?,
-            },
-            GFP_KERNEL,
-        )
-        .map(|b| b as KBox<dyn UnloadBundle>)
-        .map_err(Into::into)
-    }
-}
-
 impl UnloadBundle for Sec2UnloadBundle {
     fn run(&self, ctx: &GspBootContext<'_>) -> Result {
         let dev = ctx.dev();
@@ -257,6 +214,44 @@ fn run_fwsec_frts(
 
 struct Tu102;
 
+impl Tu102 {
+    /// Load and prepare the resources required to properly reset the GSP after it has been stopped.
+    fn build_unload_bundle(
+        &self,
+        dev: &device::Device<device::Bound>,
+        chipset: Chipset,
+        bios: &Vbios,
+        gsp_falcon: &Falcon<'_, GspEngine>,
+        sec2_falcon: &Falcon<'_, Sec2>,
+    ) -> Result<crate::gsp::UnloadBundle> {
+        // Load the FWSEC SB firmware, as well as its bootloader if required.
+        let fwsec_sb =
+            FwsecFirmware::new(dev, gsp_falcon, bios, FwsecCommand::Sb).and_then(|fwsec_sb| {
+                Ok(if chipset.needs_fwsec_bootloader() {
+                    FwsecUnloadFirmware::WithBl(FwsecFirmwareWithBl::new(fwsec_sb, dev, chipset)?)
+                } else {
+                    FwsecUnloadFirmware::WithoutBl(fwsec_sb)
+                })
+            })?;
+
+        KBox::new(
+            Sec2UnloadBundle {
+                fwsec_sb,
+                booter_unloader: BooterFirmware::new(
+                    dev,
+                    BooterKind::Unloader,
+                    chipset,
+                    FIRMWARE_VERSION,
+                    sec2_falcon,
+                )?,
+            },
+            GFP_KERNEL,
+        )
+        .map(|b| crate::gsp::UnloadBundle(b))
+        .map_err(Into::into)
+    }
+}
+
 impl GspHal for Tu102 {
     fn boot(
         &self,
@@ -277,10 +272,10 @@ fn boot(
         //
         // If the unload bundle creation fails, the GPU will need to be reset before the driver can
         // be probed again.
-        let unload_bundle = Sec2UnloadBundle::build(dev, chipset, &bios, gsp_falcon, sec2_falcon)
+        let unload_bundle = self
+            .build_unload_bundle(dev, chipset, &bios, gsp_falcon, sec2_falcon)
             .inspect_err(|e| dev_warn!(dev, "Failed to prepare unload firmware: {:?}\n", e))
-            .ok()
-            .map(crate::gsp::UnloadBundle);
+            .ok();
 
         // Run the unload bundle to try and recover the GSP if an error occurs.
         let unload_guard = ScopeGuard::new_with_data(unload_bundle, |unload_bundle| {

-- 
2.54.0

