Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5691C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:22:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4531B10EB7B;
	Tue,  7 Jul 2026 07:22:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="jtTo/7R3";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012069.outbound.protection.outlook.com [52.101.48.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3699B10EB7B
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 07:22:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eILI2MjCRUuevbPFY4qshFtND7NgpIilVON6V13Hs/8/9UJOwgGfpF/jmFP98jMfiSMr7c4oMprqVTbsqODHFPq34OdtLus7tgnipKgtvfkk1Kq5i40ib+znXB+lxUeFuuVXNSbegGNEr65M9NpXMu9ulA0QuWZ07QuTED4ftV0uSuzazme+Mq2o4wuujESQL0m7DvGRpkn3QV4G5pVtd9DXaL2VxKuSuYDTWp30JpAp0lw+IMb70uujHv04l+WrbsBoFqxwIy8bVu5V8DktVvivDmiCteuOV3I5fR9HSr19Yle9EUjX9P3wGZ0weeXx4LYtRazBD75R6h3tTHEvYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rVUzNbaQfI14D2lQ5cApoiaxgZxPG1uISN1+9krlMU=;
 b=Cb3HysCRWkZthWvAMoH0mupd958jrGLo9cnf23sZRXAb/eWWr2IHd63tD6nQtaMzAdFKHP2lU5eZNAC5ztikn2OHidudLZJ92MqakdgEBCOCs4YEpxEY10HrDMR4vnRiCwJxfJJ+d8b1siPySJxbnnK69rtVF5ynNGtAlsKP399cP1TrgPnqMqhjGKVM30/+QX8INRH68q7dTHYpnUEosltmystASXgGe5NbWJEOZpMRKXEDSf/xXBTh+0NIHXn43TaUB2JuXq1F0sNmjFpnT2gSVUOtLzZ6p05to7CmVeLE5UgIMYK5Vm+KCtAt/SQi92rlgnhkytT7hNpfy7SB6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rVUzNbaQfI14D2lQ5cApoiaxgZxPG1uISN1+9krlMU=;
 b=jtTo/7R34CXdpqDZCwhX+q6VEd2S5hmPTC6kb7yx4hE61mb7I2N2Rmerwu5446MxjrC4IoOqymBTDFsIgdhNBYg3rJV/uVRb5vt/T5O2ofE5nCY91BU1QHAjoG783v/T6rP5NDmwI8lVmtcsfoBsmVVyLHEbz172E7hE1QZXZLb914+ZpZ8La7HT1nBwtb8VtQ+hDhIcJThU0m0+oGV0mnXmoGJMOa8SgYNIAdrgRipD/W3JYTbheeRG8ePXcro8fFI4LN+pIZadmb8tMf3VZElYosNTX7h7tgQ0hLItTykBb2xbPTZ+1UtN0nzUvtB6FFUFEDalDDN6vGI+Be5C/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Tue, 7 Jul 2026
 07:22:18 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 07:22:18 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 07 Jul 2026 16:21:39 +0900
Subject: [PATCH v5 06/13] gpu: nova-core: gsp: fold TU102 unload bundle
 construction into HAL method
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-nova-bootcontext-v5-6-ecad9346387f@nvidia.com>
References: <20260707-nova-bootcontext-v5-0-ecad9346387f@nvidia.com>
In-Reply-To: <20260707-nova-bootcontext-v5-0-ecad9346387f@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4PR01CA0033.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b7293bc-b033-402d-0b42-08dedbf87a1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10070799003|18002099003|921020|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: i/JrUb+huS9OVMVXrJdzhj/wNLA1XhInLt1jBroc/9X1GnLYPyeFvg+kUNUyuvEYDyIY/SrtKVCCvFuFSYCUcFdLVpOq5H2MkkUA8DjI+RdzKFAHzd4Pwp+qUyjLyzcdNCxwxNduYICOaLDW8QK3BXucamRTHF9m87b4AObC52ad+zIG7teI3XYAtlCNOF+iErGc11IgxqSqUbsYBTXl2QFRDO8MNBkJUC8Kg6d5wZnrd9hcGohWAN/Rytp2lxyyG+DTAGE+BVDFwVIFQmfQABNlmJd4OdUgkUL8u0tRyrGZ2CZ/M4hMmO0yLauuyV0Qgt28JDJIa0kISjt3526+qNlnMwCINtuzDg61K5Gs3mS19Lny3/ccJZG8QPRpZJC22Nj0mvQwOFcxT0V/RZKGGPq7nn6CFcvyE5jSr26iwffzL2ZnnjLsW3lApNBl8+a86YQWNSGVKx1504gdY48ngWOfmaNNMDK0ucRuaWJx+7bsS7FaShAXpu95cv6itFniDiAl48t5ViwtjnnN296Sk8H2uTLZVCxvO5cdsMbijY72VWNJmJ+iOAr3y/wQD3/qafo5tjQ8vg8ZYqXUbVO4SNQph8ufiwPb4B8zQ4Q1ptrh2qXpaHN57NT9Ho2NaSn32Glxa40/y339gHRTLkUfVImzbFkCplb8+oD47NBi6MGjyUjw0WWrWtsik0Sq9b6aIr9YDGB3sgO+mMJPNqjgSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10070799003)(18002099003)(921020)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlRJbE5iUCtYMU56VmhOYi85bGZQNVJkU3NXRTNOUU52ZUtzeHZ2NS9VUXEy?=
 =?utf-8?B?Vk1IbGVxRndVWmZObVdTQUtaaUprdzdveTlLS0Y2MEhFZTFqZm5VbE9rUnZT?=
 =?utf-8?B?OG9xL3Rjb1FXTXd6ZXE4ZC9GTlN2ajlCZklJRWlOalJEamp0cWgrZC8xY1Jy?=
 =?utf-8?B?WkhyZCtTb2cxSzJvQStVYm9UYW41Mm9MRWorUWpTY3ZCcU9KTjExWFdoV2R1?=
 =?utf-8?B?a1J2UnlMS21PaEhtS0oxdHdNT1YvWERSMDY1eW1HLytJeDM2bkJmcnI0MjVq?=
 =?utf-8?B?bjV3ekw4alZRRVJobVhVbWNvNzJLSnQrS0FUbUI3RVdMdWRBVkVUd0lBZFEy?=
 =?utf-8?B?WFUxd2E0eXpZVnFTMmgwNE9MazVWdTNEMXJqNExBMTd4RUVXYngzdWRCaGl6?=
 =?utf-8?B?dlMvQUorOVJ2OVo1NUU5WGN6K1NLaURMM3FLWDB4WGRTdjNEVTRqMmtkZUNB?=
 =?utf-8?B?aTZWZzlId3hvbXZLQ1J5VGErUisvSlJzbmNlakNXS01Bd2NBUi9INmhNTTJB?=
 =?utf-8?B?WFJkQ3MxSHNWUWIwYkV3NzJsT0tPTUpLVWo2U3psSWNONkYrbXZMdXR2eVM0?=
 =?utf-8?B?SEJJQzE1ZzYvTVA0emtvSHZBR1lCY2RPU3dXazE3SldiSXV3TUlSb2tvMmVn?=
 =?utf-8?B?YWhZYStNd1ZMTFJWUnpzbXVMREViRDh0Uk44RDhnaXVMeHd3VU1QWC9oMlhB?=
 =?utf-8?B?bnlTbUo3TjZybnRJeE1oWlVZRVhWZmt1dFhvL0JldHIwWWpDNTF2QUt2Tmdu?=
 =?utf-8?B?eDQrNkZCb1ptbTZOcjdpbkFMWm9rUjZNY1J4dlRyV1FZQ2xaY1VUa2g4TnFJ?=
 =?utf-8?B?NWZFaVE4YmRuVlllWE1YL3QwaWJ4a01MMVZETTB1c3R0dXE3aVlYTUZwclNV?=
 =?utf-8?B?MFFJVHNlTGxoUkNLVU11Wms3WXFQMS9NSkhsMllRTHJubW1NZUpzME1pVzRn?=
 =?utf-8?B?a2o3eURQSkV1UWhCYVlQWEsydktDcng3RlNWblFZR3dQQTV3WVQrRFNPdTZI?=
 =?utf-8?B?ejFhRU9yVlVIVFZSSkNvVFdFbklOV3YzcUxldVhkWGNTdUdiRzVYMXRaY1Jv?=
 =?utf-8?B?ek9tS2RnanVRejVGRlhvcENXU2pLMkRLYXBMWjZkQjE3Ym4vamV4TmhhNTJk?=
 =?utf-8?B?VFRQUzJnS2VKbFhvS3ZQV3ZFd2hqVStYT04wVXJyaDhDbFJrU2N3YTZ3cWFJ?=
 =?utf-8?B?TDJyUk03dHZLeGowbVRjQzlGbzMrT2hyN1FnV2lMai95R2lvbjJKVk9Vb2dz?=
 =?utf-8?B?UHc5WTBUZk5ISTZPN3N6cjI0U21SM25ZREd6Y2dXMEpYZ2Y2Yy9xV0lvdTZB?=
 =?utf-8?B?UzJFcFRXRlkzbFpUTFdXbHBjSlozdGZjZEIxcDNHYThOZExncjAyNk5iYWcr?=
 =?utf-8?B?QmFFVDFjemRyb1ZKYk5QZ2RMTnNHV3c0ZFVVd1ZmbGhGNEdCS2d1MWNFTXpR?=
 =?utf-8?B?bUJVMHBvZEdiUjNqa2tyN0g4L2hhSk81OW1wWXVCc21MUGtYd05ZREJXU3R1?=
 =?utf-8?B?S1ZBaXZLdGxUZVQxNytDQTNQRUdzNEgwNlc5aXJiVWJycktUemVKNVJhR1lu?=
 =?utf-8?B?dWFLZERmWVRvbWdhUWJMMER4ZW43UXlpZloxb0RGaE5HdE5TNXM3ck45NFBJ?=
 =?utf-8?B?dzF5dlJhNWQyZk5NZ3BYQUFiV0s5MURnZ1FwNWk3dmVPQ05JNThVU1hCNDU0?=
 =?utf-8?B?OHVpRG8wSkcyN08vb0d1QysvVWZnV0FKYlM3MG1pSHNVcnMxOVJNajNDUHo3?=
 =?utf-8?B?c2ZLOUdjNitSeldGUDhQMnJueEVFMHlCcUlrS1FHWTdsOGIvOTk0c0xNUk1n?=
 =?utf-8?B?UCtuajAvSWRRN2ZoVnNveFFmYm1PWXoxWGFaNk16cVNKMjBPaXdwZElueVdV?=
 =?utf-8?B?N3BZNlAwWVBaQkdaTXcxUU1VQ2dIbWdJQTZTQlpBMFg2YVJXRExXSU1DRTRQ?=
 =?utf-8?B?U3o4bi9YSnRvSlY4RHFManNwM2EvOWNnV3dxWnBVNHNFRHluWTBFME1nVUVh?=
 =?utf-8?B?K2VFUUR3bU9JaXUwZ0NpbG9leFhRN2lWYXdYbXFwOGJFcGgwS29LR2JaNHRa?=
 =?utf-8?B?Y0EvV1ZlY3JGdnRjYm8vaFI5c3lweGFIN2pxNEpMeDNhZ0U2Sm9IengxOC9t?=
 =?utf-8?B?cDBXRnZua2Y4MHNqRzlveENJU1RuamMxYm1yd05oTHJPYUpFalE1RnlQS3VQ?=
 =?utf-8?B?Um1iTTlteEZQcEZGVzdTdjN2bHJvWi9FaVR1alh3UG9OQmJPeVhzRC84bXRu?=
 =?utf-8?B?aTJFRmVwUW00SHZRL1dKZmtqbzFTeUgzY1pCNVA3VzFKV0MrOFVIa1dTWEJz?=
 =?utf-8?B?MUNYck5NMTh4eWZ1eWg3RjhOLzFSTzBTdVVyeXBYdFptcU8waXovWlZTZ3Za?=
 =?utf-8?Q?96FB1pDlwZooNyS1oxZkdbkclZcsb3F1+nXhhP6RUjEDl?=
X-MS-Exchange-AntiSpam-MessageData-1: sLPX9Jh4HSlapg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7293bc-b033-402d-0b42-08dedbf87a1a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 07:22:18.1726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oXPCqckQ+ZX29lLW4DYSCDBspe1TYaxJqKnzk8VEXF7/jg0cF6EpCVB5XnFDJDd1v41MJmw5djSjkSLqzaG/nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6604
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
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 85 ++++++++++++++++------------------
 1 file changed, 39 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index ef465b99af05..c8c7a4f45809 100644
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
@@ -257,6 +214,42 @@ fn run_fwsec_frts(
 
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
+        let fwsec_sb = FwsecFirmware::new(dev, gsp_falcon, bios, FwsecCommand::Sb)?;
+        let fwsec_sb = if chipset.needs_fwsec_bootloader() {
+            FwsecUnloadFirmware::WithBl(FwsecFirmwareWithBl::new(fwsec_sb, dev, chipset)?)
+        } else {
+            FwsecUnloadFirmware::WithoutBl(fwsec_sb)
+        };
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
@@ -277,10 +270,10 @@ fn boot(
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
2.55.0

