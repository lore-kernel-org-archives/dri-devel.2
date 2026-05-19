Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D5CCD343F
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 02:56:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ACFF10EA2B;
	Tue, 19 May 2026 02:56:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="D93dY3VM";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013067.outbound.protection.outlook.com
 [40.93.201.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E1EC10EA2A
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 02:56:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PoHzhZ8pSspi5n7k5wQhV5LyvnjjMyLzjWiG4pYPi+kLnESLe8YpMNgV2lMjFlqSzDhaaWP3yxQPMSbOiBMhdd9cyMjoDeA1mbd7BN6NuA7I1oOJ2pMHj+oMSlZuiRpSJDgHeClsXtfkUuyd7eyewONJdkvbWPO7rwdRFa9aEimxThIElOP6fSJHE2vD9xsJdf368DGi884fuN2V1jNhsmoW5BC1MzE2TBfbjmt0w24rtlrQ3o1tCk5VtWTbUI24TRTlIEwhr8+5iJbMm+Jc2xbWcXmKVGsM+kPbKh3hxqnkZ+wDSIwLEVXfI0iEmmV7PrzNK/JazF63SJgW3Vdk9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AuUGHKMgCCeLwlF0BAyvNsVh4HDpHO4ft9aTSUojhPo=;
 b=DIiWKb5OD+oISBy6zAkFzZEiOKflt+b0Okfa0QQJNeDCHudmUC/BpEoa/HjsxsbX3fpQpatz0p3kZrvb7Cpsnw+7qZlEr8kLX0faZVnuHd7dtNRvPPa50sveqdD7tuU5kgGC7u+mxeMhYL/zatyEALLESs46C7PA6vFbKISt8XQIw3NFyKULgtCwCmvQ6DIVKidePz2n5J64/v4JLgCSRvPcSOYreTFYfFOKthqmfsuQOQvjhzDoT17pENOBxmXBCxYFaiXvRF4SjsD4ySok41BQy1h38anxMyv2PaRGlvdvxZhhLTFcAvJC+He+O+curOQQMl0uOucBibXqnWowJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuUGHKMgCCeLwlF0BAyvNsVh4HDpHO4ft9aTSUojhPo=;
 b=D93dY3VMTt4pgUoN2Yyi/CtHhww6BpbCBcPG0fmofJz+nlpX9Y2sAn4LqjzKbAupAGLzMRB17bUeDS/z2qrUDErKf+7/QaermqiS2SE3eGODWUFJ3LyKK8KavcABgLMGWqza/lhkA30UC0snb8aSYiluZi9rGREZ4AMnjfKhym4Q85kiZGFWubD1HpAIbxpvGbAZFfLANc7nYLMYcKqiKTCO+102Di2haI0RAR9/hdQ6gYAtt6L5il3v1mFHq+yQcGvJSu/tc5bKoyAbIbTQ845QhUM73S3O2ffBEaou//eB68VtcAoD6xcpWE4UhPxukJd+ITN86X8X0wgy/g+kFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 02:56:45 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 02:56:45 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 19 May 2026 11:55:08 +0900
Subject: [PATCH v4 14/20] gpu: nova-core: vbios: construct `FwSecBiosImage`
 directly from BIOS images
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-fix-vbios-v4-14-5d3f210c5602@nvidia.com>
References: <20260519-fix-vbios-v4-0-5d3f210c5602@nvidia.com>
In-Reply-To: <20260519-fix-vbios-v4-0-5d3f210c5602@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: DS7PR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:8:2f::15) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: 387bba0a-d715-4102-eda5-08deb552434c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: RhGaexNDel6mGR042By386CCINUA3hF0uSjwg8me0HLtSykGuaUW0sdkKhUL1llHfPBRf9G59s5ZTKjeu7ztfb3Z7xfuQ8udMyjHOiOMb4Qdzc0WAE+gmhMSjKDPOfqo20EsnFbqw5FCLqQl1eOSHRfg/mSVfT+Xlp96DI9qUmmA/m14wr57PI2AEDYw6YqMrTVKWkIi42rJ0DsQfbgOy3DLyTXyohGNPXQ4B7SJpO6BtMfFyps2uUNWM9CECrg0CPvVfTqcdDzQHUSvEl5sr9n5cYMNTABNwxxMP2Zky+e21RZtav1Pu8rcD7G0q+tfEDEh49AFb7QhKepJEFyl0NDJi4I61EIYN1LgMw7WPs4eH6TUNBlhjq4OeWGAKLao+JEJCT544cIz5Idh4MyYEpzPg9Fhm4V+VAYIpvM9oR3oRbjtd498xwkKhXOPaiyWOI1jeg1lhlk2o5wBZFcHd62gEjbFNy4QhmSriqA0kWsGUiVOlVonkKumrUmLELdcqQRFdVktw84hU+CaoZGEMwXhN/KKUTRHFIPU9kny5AKZF76vdeDfVRff6ozFUeSQYzVetdgqT+p5AKW+kPQKbIzq9ypfl0Sy7wII1qDN6CskuR/t5Pt9Sp3eZvr0WmTwEdGnEMMgmSG8LiNZOghTkfh7KC3A4mStq/Q01RArh/lR3Ezs7thTDIjr85Xzq2/r
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2JyTEVCcTN5UDlWTDJtZUpKL3dlanljd2lFSjZBVkdQTUljSlQvSi91VEZw?=
 =?utf-8?B?RWlrbEd6R1lBWkJSQXZZSE8yOHBLQUhBSWIwckdja09ZODBZbDZYTFRjbEpj?=
 =?utf-8?B?UFFyUjFFbWFXRVhLbGZVNDQzOXdNaWcyWE80K1daeTczMEJ6emgvd2NDTVc0?=
 =?utf-8?B?MVVpbWpQVSt2YTFyYWhDYkNVbDc4bmV2bnBnV25KaStGajJ2bXpYdkFMOTgr?=
 =?utf-8?B?YkMrQmZqMFBNQkRHZXgvbEYwN0JMKzhlVjRiYVMyczU1Y3EybnIrN283WXIy?=
 =?utf-8?B?aU9YNmpLQ2RtOGREMEhNL25oVk8xb1FIZnR2NzZkeVBHNlovR05oeVJzMGFL?=
 =?utf-8?B?R0RIMTZ5SU1HYU1tOHFmV3NET0JDQUliMmxiQk9HbDBvb0lEU1owY2RhaUZu?=
 =?utf-8?B?RHVWSlU5VWpIb3pnQ2h2ejVUcUpRemxUN01vQUhjWUg3ckJrM25QSGdrcEJS?=
 =?utf-8?B?eTdzaWQ0b0kxd2w0VHNRM1Jza0kvN2g0eE9JL2xNTHJmZUllUWhnTGdwZjNW?=
 =?utf-8?B?T3BUa2ZabzQrSmJubFN4THcrdTJNS0Yza0JKNldVbmhJZ1MxRzc2VllJcEk5?=
 =?utf-8?B?MEc4akorWXAwWEpxV0wvMHBCa0U0N29LbFZwdnZETUtCcVVqY0VtL1BIWDVr?=
 =?utf-8?B?UVVUNGFveFovQU5VTHFrZzBVUzdMUkZLMSt4NkJUcUtmQm9zdUZidzJLVEk4?=
 =?utf-8?B?RmtBSjVCUHhvYTIrTngzTHR0cU1LaW54WG93ancyT1dXRUp6a0R3V3ZMd1N0?=
 =?utf-8?B?U1NGc09KQURYNGxlMTkrd2x0b1dqL1RvejE2eHF2MXhCUEcybHFVYnhJOWpz?=
 =?utf-8?B?RDZIYTVpWWIrMlg4a29Ec0taY2c2eklRNXU0dWFRMnJraENwdlh6d0VNeWlz?=
 =?utf-8?B?K0ZjZTM0UnZ6Lyt2eDA5bFVpU2JXbjlLbU9yWS9NQ3hWUjVIdEJjdE1LRUpB?=
 =?utf-8?B?emlHekZ1dytJT3RtdHR1L3RvZFpZRC9zbVFIL2V1RFlyVE54TmFjY1YyQnN0?=
 =?utf-8?B?VlQ3Zlp2d05xOHBjblIxSHZROVh6aWlXOXh5NDFnOTlCVnM3bzNOYXZNUHZU?=
 =?utf-8?B?MTNlUjB3Rlg2QU5QUWRLbGRhSnFiQ0tJeUErYkdIRUc0OWNMajdMQzU0SDlN?=
 =?utf-8?B?Znh2VXpQT0xiK1dScGZXS3NGOWF5NFhGcVcvWC9FSklIbXZBT0h1bG9MS3hY?=
 =?utf-8?B?aWNlQXdBSC9FNU96ZFpyMTVKcmxDTkw5dm0xTnc5VzBoNDRnWXZJYkFRcVBu?=
 =?utf-8?B?TjNINC9mRklEM1owbUl2ZTVLNndvQXBXRnEyME9uTk9qNnUxV2h4RzVMMUU4?=
 =?utf-8?B?SWpNakNyM1FHU2lEa2Q2RUVKZlZvRU1lbnR2RmxockVMdGJDdW9VQlRCZThh?=
 =?utf-8?B?b1loaUlYbEJGZVZCb0Zrc2YrbGZ3SkxMWDJyS1NpK20rVTh1VUhHRmVVL0ps?=
 =?utf-8?B?SEV2UDNZbGxlMmlBZzlOakVsSlk0SWc4NFg3NXZUdlVhc1Y4TXlKYTBDdjM3?=
 =?utf-8?B?czZmRUtHUUs3T3RTL3c2T2JlQzlsbXR5aUFNeUtON0RVaDlLUW9uWm5DVVg0?=
 =?utf-8?B?VHUzVmFxeHNDK3JhcWFTM1FrWGdBOC9tbFc0RThUcFpLRzdxV3ljUGx0c0hs?=
 =?utf-8?B?cVZaeGZyMUtMeE1UWUFrNFZ4bURzK3N6Uk5LdE5YbGNlOUg2SjE5RzdpcVpj?=
 =?utf-8?B?djZFQWROWVZ2eXFOcDV1T3AvSk95ZG1kOVBDM0NtZTJyZ28vY1lVcW1od1pO?=
 =?utf-8?B?V1FNcFRFY29DZTNTOWpvZWtNYms1eEQ1ZVdKTTJ2TE1tWkNlZmFQVFM4eUtp?=
 =?utf-8?B?QVNTOVdDOWtPVWhURjZCMjdka3dhTEV5UkRCYzR3VW5jMEFYck5EMlFjR0hG?=
 =?utf-8?B?UldGaFQxRUxLTWIwUjFVS2JHaHJ3K2RoQUxady9jRE03clJjcUVmMDFWalFt?=
 =?utf-8?B?eVBhZjRWdUJXcmhYamE3Mk1qVTNCR0wyNENERnRzRmdXb1dFcU85UkFDVkI2?=
 =?utf-8?B?UUpPbm1LbnArM1pBRXM2ZlI5VktaV3Z5SUFlbENSWnlHSHQrbE5kdmhrSEJE?=
 =?utf-8?B?WUxzYWk2NjF6aU9NZU1tL0xHVlpSSEw3LzBmaVl3QVd2QVBLK3dReURjWGZ4?=
 =?utf-8?B?VUhjTHNoamdQdDdQQjhmZHVxby9pTHNoUUFVcEwxU1VUY28rb3p5WUZYYm4x?=
 =?utf-8?B?Z0MvRVBDYzNuZGt4L0t1ZGdKZTl6YUluNCtNUU9xMENMVFVQdTNyVHozblNU?=
 =?utf-8?B?Y0hvOWp0bVQ5L2thSjFpVHdOYno4SXJlRCswYmVVTVFpUjdselJwQWJROVNZ?=
 =?utf-8?B?eXFzcXdCbjM2dE1CdUx1MStSaXZJTVAzTU41Uzd2YnlJM3ZENlVjTUhFeVJa?=
 =?utf-8?Q?L95tKA0jLC7At+NmNZH3WKQEkmYxvgr5B7l0/OUtYxD1k?=
X-MS-Exchange-AntiSpam-MessageData-1: AqVLcQeaNlSuRg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 387bba0a-d715-4102-eda5-08deb552434c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 02:56:45.5176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vG1sEJzSQmW2FoCUiyNywkOmrd4MNM0Tq0ykYfJ/byvFxIULdBl6MZ9TEzUD/3Xm++8n/OvzGACqhteFM1MOaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551
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

`FwSecBiosBuilder` now only contains `falcon_ucode_offset` which just
gets passed directly into `FwSecBiosImage`. Remove `FwSecBiosBuilder`
and construct `FwSecBiosImage` directly, as a simplification.

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 98 +++++++++++++++++-------------------------
 1 file changed, 39 insertions(+), 59 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 1ffaf0ef56a7..c5dad9e065da 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -315,8 +315,8 @@ impl Vbios {
     pub(crate) fn new(dev: &device::Device, bar0: &Bar0) -> Result<Vbios> {
         // Images to extract from iteration
         let mut pci_at_image: Option<PciAtBiosImage> = None;
-        let mut first_fwsec_image: Option<FwSecBiosBuilder> = None;
-        let mut second_fwsec_image: Option<FwSecBiosBuilder> = None;
+        let mut first_fwsec_image: Option<BiosImage> = None;
+        let mut second_fwsec_image: Option<BiosImage> = None;
 
         // Parse all VBIOS images in the ROM
         for image_result in VbiosIterator::new(dev, bar0)? {
@@ -336,14 +336,10 @@ pub(crate) fn new(dev: &device::Device, bar0: &Bar0) -> Result<Vbios> {
                     pci_at_image = Some(PciAtBiosImage::try_from(image)?);
                 }
                 Ok(BiosImageType::FwSec) => {
-                    let fwsec = FwSecBiosBuilder {
-                        base: image,
-                        falcon_ucode_offset: None,
-                    };
                     if first_fwsec_image.is_none() {
-                        first_fwsec_image = Some(fwsec);
+                        first_fwsec_image = Some(image);
                     } else {
-                        second_fwsec_image = Some(fwsec);
+                        second_fwsec_image = Some(image);
                     }
                 }
                 _ => {
@@ -353,15 +349,23 @@ pub(crate) fn new(dev: &device::Device, bar0: &Bar0) -> Result<Vbios> {
         }
 
         // Using all the images, setup the falcon data pointer in Fwsec.
-        if let (Some(mut second), Some(first), Some(pci_at)) =
+        if let (Some(second), Some(first), Some(pci_at)) =
             (second_fwsec_image, first_fwsec_image, pci_at_image)
         {
-            second
-                .setup_falcon_data(&pci_at, &first)
+            let fwsec_image = FwSecBiosImage::new(pci_at, first, second)
                 .inspect_err(|e| dev_err!(dev, "Falcon data setup failed: {:?}\n", e))?;
-            Ok(Vbios {
-                fwsec_image: second.build()?,
-            })
+
+            if cfg!(debug_assertions) {
+                // Print the desc header for debugging
+                let desc = fwsec_image.header()?;
+                dev_dbg!(
+                    fwsec_image.base.dev,
+                    "PmuLookupTableEntry desc: {:#?}\n",
+                    desc
+                );
+            }
+
+            Ok(Vbios { fwsec_image })
         } else {
             dev_err!(
                 dev,
@@ -702,18 +706,6 @@ struct NbsiBiosImage {
     // NBSI-specific fields can be added here in the future.
 }
 
-struct FwSecBiosBuilder {
-    base: BiosImage,
-    /// These are temporary fields that are used during the construction of the
-    /// [`FwSecBiosBuilder`].
-    ///
-    /// Once FwSecBiosBuilder is constructed, the `falcon_ucode_offset` will be copied into a new
-    /// [`FwSecBiosImage`].
-    ///
-    /// The offset of the Falcon ucode.
-    falcon_ucode_offset: Option<usize>,
-}
-
 /// The [`FwSecBiosImage`] structure contains the PMU table and the Falcon Ucode.
 ///
 /// The PMU table contains voltage/frequency tables as well as a pointer to the Falcon Ucode.
@@ -954,32 +946,33 @@ fn find_entry_by_type(&self, entry_type: u8) -> Result<&PmuLookupTableEntry> {
     }
 }
 
-impl FwSecBiosBuilder {
-    fn setup_falcon_data(
-        &mut self,
-        pci_at_image: &PciAtBiosImage,
-        first_fwsec: &FwSecBiosBuilder,
-    ) -> Result {
+impl FwSecBiosImage {
+    /// Build the final `FwSecBiosImage` from the PCI-AT and FWSEC BIOS images
+    fn new(
+        pci_at_image: PciAtBiosImage,
+        first_fwsec: BiosImage,
+        second_fwsec: BiosImage,
+    ) -> Result<FwSecBiosImage> {
         let offset = pci_at_image.falcon_data_offset()?;
 
         // The offset is from the start of the first FwSec image, but it
         // may point into the second FwSec image. Treat the two FwSec images
         // as contiguous here and subtract the first image length when the
         // target lies in the second one.
-        let pmu_lookup_data = if offset < first_fwsec.base.data.len() {
-            first_fwsec.base.data.get(offset..)
+        let pmu_lookup_data = if offset < first_fwsec.data.len() {
+            first_fwsec.data.get(offset..)
         } else {
-            self.base.data.get(offset - first_fwsec.base.data.len()..)
+            second_fwsec.data.get(offset - first_fwsec.data.len()..)
         }
         .ok_or(EINVAL)?;
 
-        let pmu_lookup_table = PmuLookupTable::new(&self.base.dev, pmu_lookup_data)?;
+        let pmu_lookup_table = PmuLookupTable::new(&second_fwsec.dev, pmu_lookup_data)?;
 
         let entry = pmu_lookup_table
             .find_entry_by_type(FALCON_UCODE_ENTRY_APPID_FWSEC_PROD)
             .inspect_err(|e| {
                 dev_err!(
-                    self.base.dev,
+                    second_fwsec.dev,
                     "PmuLookupTableEntry not found, error: {:?}\n",
                     e
                 );
@@ -987,34 +980,21 @@ fn setup_falcon_data(
 
         let falcon_ucode_offset = usize::from_safe_cast(entry.data)
             .checked_sub(pci_at_image.base.data.len())
-            .and_then(|o| o.checked_sub(first_fwsec.base.data.len()))
+            .and_then(|o| o.checked_sub(first_fwsec.data.len()))
             .ok_or(EINVAL)
             .inspect_err(|_| {
-                dev_err!(self.base.dev, "Falcon Ucode offset not in second Fwsec.\n");
+                dev_err!(
+                    second_fwsec.dev,
+                    "Falcon Ucode offset not in second Fwsec.\n"
+                );
             })?;
 
-        self.falcon_ucode_offset = Some(falcon_ucode_offset);
-        Ok(())
+        Ok(FwSecBiosImage {
+            base: second_fwsec,
+            falcon_ucode_offset,
+        })
     }
 
-    /// Build the final FwSecBiosImage from this builder
-    fn build(self) -> Result<FwSecBiosImage> {
-        let ret = FwSecBiosImage {
-            base: self.base,
-            falcon_ucode_offset: self.falcon_ucode_offset.ok_or(EINVAL)?,
-        };
-
-        if cfg!(debug_assertions) {
-            // Print the desc header for debugging
-            let desc = ret.header()?;
-            dev_dbg!(ret.base.dev, "PmuLookupTableEntry desc: {:#?}\n", desc);
-        }
-
-        Ok(ret)
-    }
-}
-
-impl FwSecBiosImage {
     /// Get the FwSec header ([`FalconUCodeDesc`]).
     pub(crate) fn header(&self) -> Result<FalconUCodeDesc> {
         let data = self

-- 
2.54.0

