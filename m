Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E025F327B0
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 08:21:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03FF410EBCB;
	Tue, 21 Apr 2026 08:21:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sc30gHLS";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011068.outbound.protection.outlook.com [52.101.57.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ED7710EBCB
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 08:21:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDjFxpkKZ0tZeJQ4f+hSGY+W+fiVHygyxNGYBS+msttRF2TlAzIedYTQUjb1JaCGYICVlVNol95pvSsatxbpvxn1RlJFZiyLEtjDmnLkQMsxdz/r+XZFw4ii6Tuk3Sf2SIen9mwhhyvcd13lRa6RpJ46DYAKGV//tHkQYnWTLE+YlKIXs0jngBbE6yaHed69o4J5ApfRfd0i0GprYC/Drkhg9vJMKUol8G//KqLHax2w02KYskQjVV6knTFwG+dDCprZzSHHPRwcHoXBBAnqiH+eFhk32FQLQz0N9cX56tnkZRJL5N9kEQrMrdFTAOWpBnEQHoA7u54Nre+varblaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OqP0qxy57FjPo4VAWIuDL8aqIlXJMvbZTTubTz5W0c=;
 b=s5RN8GTQ4kHtMattVLLTxLpEpQh+o767MiMKJRWTo1oEdyffPqnGobX+PINaNb8x0/qzBFZDvhJJQvb2vk+UBRUBcrSbnsThGQkKK6/sKdwC/GCNS9PgdHpqlaLJswAir5uY7c6U9fLLVJ9mmQqqn01UVe6d9IkuThLBe2NVNJt+Kc9VTTzf+Ximmsp8c6TbmgC9rAOLeGkWl/AbvaaeYeVutWQywuzJCpX703vMGjLtjn8rj4Lnhwd4F8F7q5rnUCn2/VHUlr33KBpJRwWg35BdTvQzHaxTuQ1midyeQLdB/eGX342AyVo2a/dRWRgKOb8J1Pz7OpBMdRE9jngigg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OqP0qxy57FjPo4VAWIuDL8aqIlXJMvbZTTubTz5W0c=;
 b=Sc30gHLSv/k9juUXcKAdrl2UWiEgy3tqx2LPInwxzInE8fOQ/ZPEugDbUghRYduThBz+lPEvHyQtV6BickMZub0f9ea9BD769DR0MCY6rmlLghumkU1XT1j8q+ba8Q8Seee6S6TIb+SM2QxaQRXULPQIfQJqS8uKUGvAYwv1MehceljNsXe3Yujhv3kGdjDtyVssY++2q1Ng6Z5SiHwBCbkta424R65eU03sYYDAlPaICPFLETZrsE/R3HKsp/4uytGg0e+JVPWh9skzUhLvkFVGZPcDGbK6JoEsqdjRIvzxW3NYiZzwUD73xf/5b7403EipFgwZV+0eAhWMfal9Kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA0PR12MB8376.namprd12.prod.outlook.com (2603:10b6:208:40b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 08:21:26 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 08:21:26 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 21 Apr 2026 17:20:30 +0900
Subject: [PATCH v3 11/11] gpu: nova-core: vbios: use the first PCI-AT and
 FWSEC images
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-fix-vbios-v3-11-8f648aef7a85@nvidia.com>
References: <20260421-fix-vbios-v3-0-8f648aef7a85@nvidia.com>
In-Reply-To: <20260421-fix-vbios-v3-0-8f648aef7a85@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Joel Fernandes <joelagnelf@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYWPR01CA0011.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::16) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA0PR12MB8376:EE_
X-MS-Office365-Filtering-Correlation-Id: 5751aaba-55db-446b-865f-08de9f7efb36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: K6CzpdUEfGwf2e/kTYpofuZ8k5uAV2LctTeFn/zfNP1A+kpSEfTYkwuSndZE/u6L8XsK7/Gn3HgqiomBxNPMig6FMACN95QSMq7raCPXyhuzBt9oCWJkRBxCzdlHpJXuBT5MCkPc4KdcF+SVLdavQe2xD+yiPd/f2W6D7eNa3HYhBvJn9/OzvluZ4UzOSVOM+ci3f1BEKza6mvrIlqW9jszef6Gp+eaPy5tayf69q3ZW2raNsGe54R8bpaqxlg8Z4QrFsZoPTCKYkkT5weO/d3w+BpiO/XNe3dm/7YXi1SuakXOI+a5lmoQ2uIEK53AzjnJCDHH2q5rzQfRkLsPN1RPSK3xsn9t8KNpuwsKKx0W/GyyxEXNZILvt/iC1slwSwAoU+OSPtRX4UKXKEpcCrIsw3jEC54seJvr4w3rWvHs3wldSXQU0BJk59Idv0itPUvgZTurPAqXHQywVhlR6Zb99LdWkuGbl61uqApzaLlrmQLrp5CflWNTEiX6RLu0/V7mPSmhtLOv8KQLVHTcUtVzfU/zPkNFJZrSUT+rYS6K0LDAXrGmzuB8642mT7AdENY0Dk+3IiqldOewbnzkyPAXmdEHk5GB3KJMzxcplATf4JCBLi6e1Qe7FocTiNAfPFugSvQAvz2/m3MTEmbQNvZ40sDk/kxzqFW13qkKbTxAMtLdOnr8GaxxgOG/dH8c/nXTYOA5YC/unNMNGujTFYLd9jnEFa86clpInVrYoBWQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVd5ZkI4OWNpYmY4ckFtT042N3NncWJSZU5ldUhkNjQ3WExzOEQrSkxxZHNy?=
 =?utf-8?B?K0VDdUVFVE9ST1RGY0pOc1RCMFQ4YVdWUHYwMmZvcVJnNldHLzMrbmZvWlY4?=
 =?utf-8?B?V0I0K283N3d0SDRnNGFxOERpL0RtcGJNY0Y2eUR2ODRvczZXNGYvVEJpTWJW?=
 =?utf-8?B?L243SlJHQStkaGFDRDFsQjkveWY3NGdYYi9SemQ5WERqNzkvQ05iQUFPd3ZQ?=
 =?utf-8?B?Q0U4dmVZUnRQYmRTT2JFdHYwcG1jNUlGYkZCRld1ZVlLOVJTYjdBMjFzRG95?=
 =?utf-8?B?bVBES1hldnl0VDhhSmpVbnM5NmhRSXBiVDlTTnBYMmhDTkZ3YWJxdVR6MHlr?=
 =?utf-8?B?STBIa1FKQWVuS3duNjFXdVNxdVZXTkNKWlozNENyVWY0V0ozTkFJUGdqMU5T?=
 =?utf-8?B?UVhhM1YvZTBweWhjMndZRzNOeS84MTQ0b0gwZXFsTitGVUhleEhMYnRFWFk4?=
 =?utf-8?B?RHhmdSsxR1RrUlp3MlA5cjVFSjg2UWZRcStqK1M4K0xKM3hPeWJkSGVsTDVL?=
 =?utf-8?B?c1I4bGhoenorYWxROXQ3ZFNJOFlNbCtlMnBKWFM2T09obWZsWlErRnFaQko5?=
 =?utf-8?B?a0RaVHNqY0s3SE9HNEFkRFp2MEt2Z2EvZzhxb3QrSURDWC9WK3BsR2NQRFJM?=
 =?utf-8?B?VEtrSTRwMDVHZXM3aE40ZXJ1dmJ2aEE4UURlM1hMZDZITk0vQ3k2NGY2YTgx?=
 =?utf-8?B?QWlrbXZFWW1pZ3FGVTZtZER3QXhHdGh1V04vcmpNTkhjMisrMFA2cWRjczhR?=
 =?utf-8?B?VnhCWWV0SGtPYXBVeHo1ck5HWXpIeGxpS1lJa3kxd1FRVnVsVmU3UEtnWVpZ?=
 =?utf-8?B?WFNyQWVCWkNwMHhjRWVjMTZ4TjlLdEhYY2wxblRRM1NkUWovMVRJTElXMGZ1?=
 =?utf-8?B?NFV5dk1OeXU4Vk5SYkpHQlo1aStjMkFUU21YbTNWNFVWV29WejZEZTBWQTFR?=
 =?utf-8?B?ZUNOWU9LS1RRWkRRVG9XdXJoa1FncWFUVzBLYyt2OFErTDR0eWJnT3RoNFpB?=
 =?utf-8?B?MW1TallzcW1XV3Y4ZkZjemJuL3R2VSs1eHdVRy96clBIQ1AxV3RCWUVlU2RV?=
 =?utf-8?B?M3dkamhQM2tpUWlKSGRkaStKMHFiNXM5MTdDdUg3NjAyc05GM2ZsUCtTN29S?=
 =?utf-8?B?cjF6aGU0WmVEalJkRjNHYWxNWHVxOEJqOVlkbHV2ckFrUy9KQ0k4RFdHRkJL?=
 =?utf-8?B?UkRSOUw2NlFuRUxFOWk0dXU5UHlYRnpSNGdrc2lDV1dGd21VNTRFV1JsZHJS?=
 =?utf-8?B?c3R4TFkydzM3OHBwR2tLU3BpMjlMWFN5Q2MrcVVNancvUGhDZ05aeEFtQzZn?=
 =?utf-8?B?NnRTcUxsdWgvMU1EV2JaczFKVTRHcmw4Qm1IRVlMb3k0Y0JYb3MzNDN3WGRD?=
 =?utf-8?B?N3g5UTZvNnRlb0lESU9rM3BWMGxQUVlROVZhdzJNZExXWVhja0RjUVYvU1dx?=
 =?utf-8?B?UUxhV2pjZ3h2SElmdXI1c3Baa1pWK0lXUC9pSkJXcUlWcEIvSzNUUnJsbTBM?=
 =?utf-8?B?VmRpZGRTRWNOdm50YmN3LzVFbUtFcklzZEVNSm9QZ2ZLMnp1aTNGRUo5cXZC?=
 =?utf-8?B?amhDVmp2NitOZURNQXIzWmlub1k1L2xtTEFFam1MZWZ3RG9zT3hrcUF2Wmp6?=
 =?utf-8?B?eUlXbnc2V1ZpNEkzcElPaWh4dDRqZkNpbUxDTHRtT1VwbmhtL2NsUU5EQkxr?=
 =?utf-8?B?SktjTEtQMXMwUTFvckNTaldJSkRnTUxBSE5tT0t5Zy84bUprZnpCR011SVdw?=
 =?utf-8?B?TmZTZ0VaVHphY1dRYlFxUlN3VTE4S1NZS2pnaXMyc0NwbEFhK2FTSTdMVWJT?=
 =?utf-8?B?Z1JDM1dVZnowcWJDVUEvbkJmMDZYQThxMnAzSmRHYndvVlNUNlBhUUIwcFEz?=
 =?utf-8?B?SEI2YXJZQXV5QlQ3cUdtK2VHdTRhWjAweVRienVJVVFBSHEyMmkyZHVsS2Zy?=
 =?utf-8?B?RGVEM2NyVTRuRVNCK0FveEFYOEN4UW9CazR0aEM5VEhIMHlhWmNraTlNZERq?=
 =?utf-8?B?Y1JzaUc2TlJsRDRGZ21LMzVqallxcFNnbFYxdE9RZi96dHNuQjNTUk5janVx?=
 =?utf-8?B?L05FMlNHbjllZ252TERRNUx1NkZiMVRyY0RVK3Uxd2FST09SUVJhZnM5cDJJ?=
 =?utf-8?B?elg4cmVtM09sVVVBekxEZWxGOVlnR1NzM1B6eGIxckVLMmtHTDc3RkIzOGJY?=
 =?utf-8?B?MEJkV1NUajM2QmgwV3lsRDZlOG94eS9uLzgxTTBkc3NTZENkYWhDL2U4czZS?=
 =?utf-8?B?WllpbHZtcndjaTdWWXFSN0tUR3MyUkF4T1g4SFkwaFA2NXJSdkUyTVlWMUJO?=
 =?utf-8?B?cnhvN1FqL1FOY3pwOUJKRUttM2NaMHdiYU1HUFRsOHU4Ny9ZbDdURk41TXFi?=
 =?utf-8?Q?qNNSP++2GVhifoO7teYbtT85X7gQjqj4TlfxKdLGINPKI?=
X-MS-Exchange-AntiSpam-MessageData-1: jpTgOyEKYrvTvg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5751aaba-55db-446b-865f-08de9f7efb36
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 08:21:26.4904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D6IXCXw23aZSRjPT4HoSIEM5JZPbH7qlAKkkMGUEC3n2ly+dGX9GLSYxiVPV1IzfpB/tAlNLWpstn6Ip9r5B+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8376
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

Currently, PCI-AT takes the final image if multiple exist. For FWSEC, it
takes the first one and the last one. Align both of these to nouveau
behavior by taking the first ones.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 5cc251c73800..8cfc75b1184f 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -251,12 +251,16 @@ pub(crate) fn new(dev: &device::Device, bar0: &Bar0) -> Result<Vbios> {
             // Convert to a specific image type
             match BiosImageType::try_from(image.pcir.code_type) {
                 Ok(BiosImageType::PciAt) => {
-                    pci_at_image = Some(PciAtBiosImage::try_from(image)?);
+                    // Silently ignore any extra PCI-AT images.
+                    if pci_at_image.is_none() {
+                        pci_at_image = Some(PciAtBiosImage::try_from(image)?);
+                    }
                 }
                 Ok(BiosImageType::FwSec) => {
+                    // Silently ignore any extra FwSec images beyond the first two.
                     if first_fwsec_image.is_none() {
                         first_fwsec_image = Some(image);
-                    } else {
+                    } else if second_fwsec_image.is_none() {
                         second_fwsec_image = Some(image);
                     }
                 }

-- 
2.53.0

