Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707A1FF8865
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 06:57:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1EB710E59D;
	Mon, 27 Apr 2026 06:57:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="oDNOnEga";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010058.outbound.protection.outlook.com [52.101.85.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6E3110E59D
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 06:57:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=onlEXYDv9fZz3usxRRUe7BdhXJ5oNscJyCiE7QeJp1oHgFy3cRKknhp2B8OS2mhSHorqHGBoy6quWtk5mXh6++eZAdl4Ntyt6nQUwVc0PF14rooaCsCaUVuEkUNCRUexL9Db/q4w3KOqIVWmegZmqpIkvQq8WgN6/EfqApqqMWT8yVEOE5NqjYtIQXe+qWrUR0zPF8GAiySFe5OPRiIvX1VC5HIhqp96vPcCGGaF1SjcITe2YCkMLy0snihRbPZAgEa35lMjTvYxRLlrhs+ZTGlsJcPdOlumVrdiw3lnMY4CjFzyhgSjNdQBJCVkJBPvNc0yM2ALNZD9g884y+PwyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CoXf1NQmIG3zIUKQD/8dfTl/es+JGlSa8OOOiO0Vtdk=;
 b=eEcI1Zf/f0xiL95YZzy2d3FsP9l4zQM+YCpHAvmzqFzwK8uu6r1KrJY6dtBZaGjeJ4Ctv4U5DtrvmP/1r6E5HsLgW+e3ZUBP91J4Uh8pQvFQiwhsSw3oahmZ12nNFuI1wcPfIWYVw7V9VE6XeWzch7kFL5pGXbRacC9CxbhS6/e5HDCEXDv6byqnI1LWA2iEJACnq6lztYLBtdnSxIc1lEYvOE1WjqxHvpnkTtzaoOUoIdDnSCNL/v0rIHOEtxdk+FEF/3ZOmY8bnfl1LDjG2iNvlB09IKCDb6alUmshPHFb42ERzlj4iIzJGgDt1g5oijzuVQq8S+FGKg0mZI4lGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoXf1NQmIG3zIUKQD/8dfTl/es+JGlSa8OOOiO0Vtdk=;
 b=oDNOnEga3/oo/VZt/MT4akhmzUONOgprAnk4JBLcECFMlFjKtz7jbl1JiVCFoifYJ9LQ6sWzPFU1/XyErgph9GxeMVejaRZ3g9raC3Mmi+GhaXEA03nChrodEqTJcCrwLhdIZgzcvPQ+19gLiYiwumM8Mdhbzdll3CxoOkfMvtdonmMgKO1b7WGNSDmb1n0kPyoyAU6IGQwsNtWXPxgZ1LpkJ81oBh68mW2YhVfrot0z/x164SmQ9kiCDsHLeC+ORJAHtDTtk7BwIMoR5gX2rVspvyziMKAl/CnskY0szT0mck3ha/ktReesysIv7snbE+fzM0nUNhCK972r7bm2UQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB7655.namprd12.prod.outlook.com (2603:10b6:8:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 06:57:29 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 06:57:29 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 27 Apr 2026 15:57:02 +0900
Subject: [PATCH v4 5/8] gpu: nova-core: refactor SEC2 booter loading into
 BooterFirmware::run()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-nova-unload-v4-5-e145ccddae66@nvidia.com>
References: <20260427-nova-unload-v4-0-e145ccddae66@nvidia.com>
In-Reply-To: <20260427-nova-unload-v4-0-e145ccddae66@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0178.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: 1caecdca-1224-49b9-138c-08dea42a3f71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: pfbBVO1pXXTfAKKRzcfOO3tQII2LlWj2I6F8xzNAILiD5fWD2c+ATPrvEzm+CcZJ40WCpRHNm+6kwJnCxjyLpLfJSXiTova9o+0iGb0tBOfj3CASR/RUaihqNOeksgIQnEzi3wdOFY6JE8yA+RfB2Gcdl9PrjIryJr6gkj+pPv08DivLpT8PaThhwvnz9S2m2VfV5npJDT0prJ35oGP2uH+OD/fB7Jd+at9R+j/qu9jae5GnttD6185ZKGZp4bBXme1VYBte7e5V+qZJZvBIlIU/TCFOoN83WuMLoOSjFWcjIJQwzec81cLqcHsnXbrMebItGKM0k9P9LK3ELRNSOZVTvXUpc5+RalQCBFssw0EC80YgsZIJIqiUjjI9HXg3dxccn4f7iuceFr5jK7Wkre28eRNqCkB7UJ7CDHZKLb2LjEiOoORQnSpdkTsbk8fxYn7ZUqDUu45WnKv+aMQz/lhwdm29c9kw1XdpVqioyl+kg+nqL41Nc8fDbqd0Y/rPgL//RtVY8jDJTyO30QPTKGINQ+oRGJH0JCFbJYNm9GE+CdUEYCHDoAV3B95nRUIbrTkobp6A2X8DN3OmB/D3XO0smCZuxrQF9yfl2XVUh4tpBaigRW8EuGrLyUzIxLfm283o/xOUSxs1KGTR/c/XYqiALWCE3KW+mch/ULul694zaU50CuYcg6PuNL2XIsAYw+qCJByvaQjGwYDxrqRdyiEiOtSFRekblc2ErI0Z0TM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXh1Mml1N3hvUTNHQmoxdWdVczc3RUdHbU1oS21vRERLeFVCa29oR3ZRaUwx?=
 =?utf-8?B?T05RYzB1TnZZcC9vdmk0Y1hQVWtKdVZndXhhZG9rK1RxZ0JldFB4OVZKelRY?=
 =?utf-8?B?S1o4eEdJNW9ZaE1oUnN6SFNscGhhSTJBZEdjRTZHLzh0bGJLV2pNOTErdWRX?=
 =?utf-8?B?ZW1kWFd2Vjlld1RnZG83alVZVyswWVNUMGFQQTVXZzl2N290Z0lKYVFOL1lo?=
 =?utf-8?B?Rzg4aDNuaFJGYkRlRWNRbnJ1Q05lb1VKNktYL0Y4SVViN0NNclI3a2xFOFJS?=
 =?utf-8?B?SU8rY3hlajJ5NDVHdlFEVUlqT1g5VWxjRkNaUHprTVJhQ3hwQmV2N2ttSGk4?=
 =?utf-8?B?Rkk2OGYxZVdJMnNXVjR1N3daWHlRZjVJVUZIVHo3T1J3YVF2bUdkcTA4UldK?=
 =?utf-8?B?STFwUkVBelp2OElTbk0xZ2NWdkh6OG9ZZVJSc0lqQ2QxY2UwOGV1UHV4bEs2?=
 =?utf-8?B?SjZhM3RON09sREVsdUZVQytObEtQZWpyZW41NW9OSEphVEVHRWFlUjhiaFJC?=
 =?utf-8?B?OWFvbU5RcVJIdTNXSUFuRVNmMmpHdWlZVjlLNmEwaVRiV2YxN0JtK014OFJ6?=
 =?utf-8?B?S0dwRTVVK0I2ZnQzUkNGek5Lc3N0NU9yY2ZtM1FydVNWaG5wU2R4YklDTUlC?=
 =?utf-8?B?c3BLTjVZd3kwclNYWnFOMy91SWRUSHRvSzRIajM4WVAxYzJ3WGs3ZXdMTmlI?=
 =?utf-8?B?UXUxalovSXkrN21iWUMwbml0djRxY1RWbHh3SndNVWNHNG9rZDhsaE5VeWtP?=
 =?utf-8?B?UGJKRnlPclhnZWtHNklSUTU0ZmNiOHRSL2FnU0E2NjdTbDJKQmVLbHp1NE93?=
 =?utf-8?B?YmhnQ1hxMU9MWkNMV293U3M5bmJwOHA3cmNOVnQzNU5BZXJTTXUvL01QMktX?=
 =?utf-8?B?eVA3R0M4TDFFYTY5VFZZbUZ3bVVvR1g2dnB2Zlc4aDNyUWdZL3VXbUljQktC?=
 =?utf-8?B?NlJEemFCc2ZVNVFkZEVtSlZCV25pSHpmdFZSU21CczNZUUVQMDRKUElIZXFW?=
 =?utf-8?B?dEhwWjRhQ1diUVpnSTZCUy9saTQ1Um5IWCt2ZlJ1NEtaUHBHSHhBOVR2bDU3?=
 =?utf-8?B?MUhVTkxYVW0xNXZ2ZmtCSTc4cUhLaTlFRU5DVDVkWk9ZWENJN01QNVZOUExL?=
 =?utf-8?B?WVNBcnUvSWZjSENWZHUrL0w3eU82NU1CQ0NWK0U4U3cvZ2REODhrcFNseThu?=
 =?utf-8?B?c0J4cXhVYURrdmVxU29vVHV5bEtQNFBIMms3eGhSZEtQYWgrK3VYcjZCVXI5?=
 =?utf-8?B?Q29OR3p6WGFvaDc0d29oM1lIa0J2VTNQbWh0c0hzZ0FoelZRNGp3SkIwSWhE?=
 =?utf-8?B?eFhvZmV2Z2RoRWFwMW1NcCtMcHdPVmkwY0QxRVdFSE1MTEIvbm1rYlY1ejUx?=
 =?utf-8?B?Ymo0R3V1U1IvMElIMkxkbWtqUG15N0NYdk9tQ1dJRDl3Uy9ETFQ3MldJZWRP?=
 =?utf-8?B?NHF5eUFZNDEzcGtza3czeTlyVjJhN3J0VEo0cTBlTGhHK0N6dnJDK3p1RnIz?=
 =?utf-8?B?cWlGc1JBbGtVeC81U0lJQmp2dVB1dFhSTHpISmxxekc1QjhzUm9PdU9hU0NB?=
 =?utf-8?B?eGlnbTRrQXNRaFdVcVBzNWFEdkJTaWlPaE5BaDZaQmhmaTNqNjVJYncrTnVv?=
 =?utf-8?B?WEV6UVREWVQ4UVl4TmtPenNaM2tLZ3k1c2F6M3I1M1FITkh0V0ZRNCtVOW1M?=
 =?utf-8?B?TU90MHdpMkNFNVYvZU9zK0hhWTIvVFd0VGRRSXpnZGk4Z1QwSkRwZXkvaiti?=
 =?utf-8?B?eHJJTUZvcUVYajVSQTdnTzB4TnN3Nkp3SC91ZDdhek14QWVzWnM4WFZsbGFI?=
 =?utf-8?B?NGVpMjc1ODBHSEZRYTNMR0xNVGtGR01mVW1XcEhrQjlIZ2ptUEVleDJoenNr?=
 =?utf-8?B?MjFYM00yRjQ3UFlkUHc2USs2RkRwbFZ0WFJGQzQ2cXo3UER2RGx2T3pJcnJ0?=
 =?utf-8?B?VHJlM0UzNFJrMGFHY1h6a0ZFRjh1WnUrUkQwM1BjYWNieS9jY1dYTTYyVjZy?=
 =?utf-8?B?aUV5aWJYU05rb1d0UUN2YW5Dam95ckp4WVA1dStnSy9mbWtzbzlvVUVvRkdG?=
 =?utf-8?B?SWpnSWRiNEo4d2hpTjBpVHFFa0I4K1Q1RFM1a0dtUEEyVVI3U2lmZGU2UDlO?=
 =?utf-8?B?ZTlSOGQ0Z1praHhlQzBRZ21pRGRzei8wcE92L1VpVU93eU80TU11ckhkT25R?=
 =?utf-8?B?UHNMSzROUGxyZVNIeEoxTFJJdXZXekt5NDMwR2loRmozeDJ2TCsyVHQ3Nkhk?=
 =?utf-8?B?Qm9RclV4dnlwWDFxQTJXZ3JnRU1SQUhPU1k4RG0zR2pVVmd2WlJJMTBWUDdZ?=
 =?utf-8?B?NWFENVJYNWZYaDlHYUliSy9xNi9ldFZuc2x5Y3A2SlFmQVByV0EwREtXSFU0?=
 =?utf-8?Q?UtFMJy9/OIhsQQBiXCkuH/d7OKzKC+w9ebhJ+SU9e+NzX?=
X-MS-Exchange-AntiSpam-MessageData-1: Ihf+sRe5qnHRng==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1caecdca-1224-49b9-138c-08dea42a3f71
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 06:57:29.4839 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qeMELg2ulaR0hC5AkKT2t1T/XS/SPS+TkIMYXEq0+MziI8OIwiwlCJGOoHJ+QPNbmz5kRY7endcJEWcPf79S7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7655
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

From: John Hubbard <jhubbard@nvidia.com>

Move the SEC2 reset/load/boot sequence into a BooterFirmware::run()
method, and call it from a thin run_booter() helper on Gsp. This is a
pure refactoring with no behavior change, done in preparation for adding
an alternative FSP boot path.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Co-developed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/gpu/nova-core/firmware/booter.rs | 30 ++++++++++++++++++++++
 drivers/gpu/nova-core/gsp/boot.rs        | 43 +++++++++++++++-----------------
 2 files changed, 50 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/nova-core/firmware/booter.rs b/drivers/gpu/nova-core/firmware/booter.rs
index de2a4536b532..6a41690e72c6 100644
--- a/drivers/gpu/nova-core/firmware/booter.rs
+++ b/drivers/gpu/nova-core/firmware/booter.rs
@@ -8,6 +8,7 @@
 
 use kernel::{
     device,
+    dma::Coherent,
     prelude::*,
     transmute::FromBytes, //
 };
@@ -396,6 +397,35 @@ pub(crate) fn new(
             ucode: ucode_signed,
         })
     }
+
+    /// Load and run the booter firmware on SEC2.
+    ///
+    /// Resets SEC2, loads this firmware image, then boots with the WPR metadata
+    /// address passed via the SEC2 mailboxes.
+    pub(crate) fn run<T>(
+        &self,
+        dev: &device::Device<device::Bound>,
+        bar: &Bar0,
+        sec2_falcon: &Falcon<Sec2>,
+        wpr_meta: &Coherent<T>,
+    ) -> Result {
+        sec2_falcon.reset(bar)?;
+        sec2_falcon.load(dev, bar, self)?;
+        let wpr_handle = wpr_meta.dma_handle();
+        let (mbox0, mbox1) = sec2_falcon.boot(
+            bar,
+            Some(wpr_handle as u32),
+            Some((wpr_handle >> 32) as u32),
+        )?;
+        dev_dbg!(dev, "SEC2 MBOX0: {:#x}, MBOX1: {:#x}\n", mbox0, mbox1);
+
+        if mbox0 != 0 {
+            dev_err!(dev, "Booter-load failed with error {:#x}\n", mbox0);
+            return Err(ENODEV);
+        }
+
+        Ok(())
+    }
 }
 
 impl FalconDmaLoadable for BooterFirmware {
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index d39da38c8918..e75c4b235aab 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -136,6 +136,25 @@ fn run_fwsec_frts(
         }
     }
 
+    /// Load and run the booter firmware.
+    fn run_booter(
+        dev: &device::Device<device::Bound>,
+        bar: &Bar0,
+        chipset: Chipset,
+        sec2_falcon: &Falcon<Sec2>,
+        wpr_meta: &Coherent<GspFwWprMeta>,
+    ) -> Result {
+        BooterFirmware::new(
+            dev,
+            BooterKind::Loader,
+            chipset,
+            FIRMWARE_VERSION,
+            sec2_falcon,
+            bar,
+        )?
+        .run(dev, bar, sec2_falcon, wpr_meta)
+    }
+
     /// Attempt to boot the GSP.
     ///
     /// This is a GPU-dependent and complex procedure that involves loading firmware files from
@@ -173,15 +192,6 @@ pub(crate) fn boot(
             Self::run_fwsec_frts(dev, chipset, gsp_falcon, bar, &bios, &fb_layout)?;
         }
 
-        let booter_loader = BooterFirmware::new(
-            dev,
-            BooterKind::Loader,
-            chipset,
-            FIRMWARE_VERSION,
-            sec2_falcon,
-            bar,
-        )?;
-
         let wpr_meta = Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::new(&gsp_fw, &fb_layout))?;
 
         self.cmdq
@@ -203,20 +213,7 @@ pub(crate) fn boot(
             "Using SEC2 to load and run the booter_load firmware...\n"
         );
 
-        sec2_falcon.reset(bar)?;
-        sec2_falcon.load(dev, bar, &booter_loader)?;
-        let wpr_handle = wpr_meta.dma_handle();
-        let (mbox0, mbox1) = sec2_falcon.boot(
-            bar,
-            Some(wpr_handle as u32),
-            Some((wpr_handle >> 32) as u32),
-        )?;
-        dev_dbg!(pdev, "SEC2 MBOX0: {:#x}, MBOX1: {:#x}\n", mbox0, mbox1);
-
-        if mbox0 != 0 {
-            dev_err!(pdev, "Booter-load failed with error {:#x}\n", mbox0);
-            return Err(ENODEV);
-        }
+        Self::run_booter(dev, bar, chipset, sec2_falcon, &wpr_meta)?;
 
         gsp_falcon.write_os_version(bar, gsp_fw.bootloader.app_version);
 

-- 
2.54.0

