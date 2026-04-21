Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C6FF327BF
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 08:21:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4F5110EBB7;
	Tue, 21 Apr 2026 08:21:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="EXekbclZ";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011003.outbound.protection.outlook.com [52.101.62.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BC7310EBB7
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 08:21:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/IcLiipeuPTIsYDsjWl0d3h7ECTshaeZn9eJIs1pgTNtfnYVHIua/wXPk/qC+91gFpPXei1hSKg1yn7eYPPyGx8niP9+uH+al6DFTcW9vFMt9sUXohNDJ6TnDxlMpaz6JHLdZaNLQiLhsL8sQoVAVYvKwbXcDznF2ONbD45DyiS6zDuIoMBGLnx0fiziDyNi5Na+ojXoA4LcSlGHX06mB1F2OO2iUzGwmNDvd+ycBHUkSYJQrmsO46KCWb/R72BVqJsPgo74EwSOqmkgGoCgFGdgypsbR/gBKhwpPqnXD3yZYrat5UcBOYqtCfmYsov/c/6AMhiws2uW7B17UkSOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tz3c/vr5FWkCJWxPJq8sCJjIX8dBn8j26Oqo3D5oMeE=;
 b=Bh1IHPDDAOElP4sPWTh9GRriWKELHrZdlm5TRFf6CrLI8IIxcS4aCHF6k8KPiOz/NBas7vARzOITj5LAEw0ebL97yMzQZWLjpBu4g/v7KwiyUBKMM3vfGvue5DoNXbc1Kch3xAQro1tQO4PMx04F+v3lNGsBZ5za/+djKs8wWNkN2FaU1rmI+K5ZYfRKxqRuUDX8OP4ShS8lUd+lUUA3L6yGBc1zKWUJjbiTJWZ1MthpXLf9M8ebz/V++8VRUB2qax9+N4hggSlv3bLdh31VpzbKncksqcRhBHNI8rx249WOZOI7IuaNhZ4ENAChUpza58UhqKYukRVBYY4lV0La0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tz3c/vr5FWkCJWxPJq8sCJjIX8dBn8j26Oqo3D5oMeE=;
 b=EXekbclZvM1jsaxMDyX2w4M6W9q5PtSn5oXsZtMrW2yK2Mo9JYtkmWPyr86U/0n9D9ttEvWOxYt2SeiSxeojekjDnRPBirgv676OSkUG5HQgKh9mV8d+I62JF/MhZ9DH12i2ExQ10ULMgA4Aw47KmhQQKYBkHKydsFGjr/9ZISfZ8eBw5hX0yuL+vnqgbQKD8YdUzrs3fVDbk7nNJa3C+4v9K6wwx2QGSRf2UCHhp4nYcPVj9M5zk/KPuEBD6AJ24A3MqSM6cgm6hV6OOzYsHIM3buuWWfQQJqTg4GUtBvl+/+wWEubEbfrOG9dB1PzYKKHjmKdR8SC9+YEOF4B5/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA0PR12MB8376.namprd12.prod.outlook.com (2603:10b6:208:40b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 08:21:22 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 08:21:21 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 21 Apr 2026 17:20:29 +0900
Subject: [PATCH v3 10/11] gpu: nova-core: vbios: construct `FwSecBiosImage`
 directly from BIOS images
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-fix-vbios-v3-10-8f648aef7a85@nvidia.com>
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
X-ClientProxiedBy: TY4P286CA0081.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::13) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA0PR12MB8376:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cc56f81-9a0d-406e-b0a1-08de9f7ef87f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: MF7rxIF7mKPz1PXHjP/vCvnZ53ze1Sj8J1JiyycwAZaLBKOK4x4Q/WDB8vR+Er2IyX2MGEOI3jyeydnLt25OvpyWrUpwQbEaRZrsbGc9oE3iM+A7mBPejERIFOYTCrWVRX+yAg/m8Gg5KwOaWvPkkWNUGYGMh/yLTfnlHOBjN9sZHHAh4SLuowByceNX/Pq+EQ1eQRg0w5DQEmh+gaBHTMftIllnpFccP4jdILHjK+reFCG+dr2vR5/jS6K7EGbVZhQDA4I9Poc2Hj5+WXP++FpR6kRzsDZ7tHTa0kWO35EgzQ7et7WpZPd14Ire6ABCuVdlFso3B0pehKu27YzJKR+8gXr5/VmZyJz88sns6ncx20DD+GTM2gipefWH1QhO4JBEY/kUvqVP9SeQxZaW/gLlpA2xGvGWgjmos1hz2HU4JLU7vWaE8I1lB2/b9fcqZJNxOFg3hNoVMakhjhhfKZAV9e5sOMJTzsiDnKKp2MOwknUiNqnydRcJxU4rPOyhso1wr6AzfGms6nzQ2XjfibzOdbLi+7hyaID+4/SqlMDAs/cRwLa4WnwJ4za3XyLvc4IssMLn4/Vwzhm6mxnHsPuhMKmd7MQHlqQGZ35axSzJ7h77BasKS50WgBk3DtD7FdQ1zCptZDTJ37xXaQwKAgKGpZHkRcRmtYnQInKVhfiQqmT4wScaqCxjk05Y2voK6w9rpf20k1VxdmngMkI5UCEQSaDnuvCxbIOAuOr0RJo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjNiWjBacUVEaTJQU0VmZ2pUc1h3S1BBcGJqL05IckNOQ0kzVzZEMHVoRzJN?=
 =?utf-8?B?MXVKRmp1SmpPbVYvS2dFQ3pCekVZdFdVQXo4WFlvaHpzcjcxTmdsZUdZT3Fw?=
 =?utf-8?B?WHpNZW5WQktXU1BSNDhFc2JGWjNXTk1TRzlwZ1pIWWVzYW9UOHBKY3JQVTRt?=
 =?utf-8?B?cFVKN1drTDNQMzkvd3E4RmdYSTd0Q1B1NHp4YUY2cnliclhXY1ZVajUwYWpm?=
 =?utf-8?B?VXZxS1R5VGRDQUE5QXJuTStuSU01SXM1NDhGd1NxU2dIMkVuZWZOQVVLZ1Za?=
 =?utf-8?B?Zm9xdm5ZekcybC94V2tERmtCTTJWT0tBTWZqOHcrYVpjVThNNlloczkxQnA4?=
 =?utf-8?B?Y01lamdLWDFvNk9sa2RKYkpLb2VwWGpMTFhnbjNNbUdpWlQ2V21CTTlPWVd0?=
 =?utf-8?B?YVppczZtdm5SNFlMVmJpOG9KSkNNcSs2eU1xL0ltL2NXem5sLzcvNTVSeFo5?=
 =?utf-8?B?cGxCakRUeXpOc1RmRk5WV01JaHVoc3RUcWp5NWNwYlBLVjFHV1ZVRThSWXUy?=
 =?utf-8?B?V2RuUkM5VFBUMUxpNWxaRG5hQVBDaGRaMjNtOTNjQ2VSZVhGU3RpdzE1RllI?=
 =?utf-8?B?RW92YW42TVRmL3lsb1VnNVV3RjFyWllrUVpqUGZZWWlQRGdoTHpGS0hneHNU?=
 =?utf-8?B?OThNaWFpYnVKeVZDWU15SUMrYWpJQnM2NzVOZ1JlcFlYellwRGl4Y2NIYmFB?=
 =?utf-8?B?aFFWUlBXczB0YlJBQ09IQWEzNzdOV1Mza1l5MEFkeWtieWZxTStoRlg2VzFQ?=
 =?utf-8?B?bG96THdUS2dRODNaOGlqZHhpUnkyOHlaM1loL1pvdjlSNE9HY1RzWHUzMExM?=
 =?utf-8?B?VFF1Y1ZGU0JNUDdXM3pUMXJ2dWlFZVhXU2JONjhYbHZiOUpMaG9VMEpnUmFh?=
 =?utf-8?B?bzVKQ3lJWHBwOXJSNUV3Nys1d1hDVVNEM0hoMS9pYS9Ra3hBOHRpcWtrZW8x?=
 =?utf-8?B?UkFyeHUyUzR4dTh0TmtlWitRT2t1Q2JiaXhWM1pQNVlZOHFmS2poZjloakNo?=
 =?utf-8?B?T1dBU05OYlJtUTJrRUZvSGtoZjB5cm1IeEJlaG1lQmNObVlzU3BXTDdNTUdT?=
 =?utf-8?B?aG44dkp5UjBPOURzWnF3VzM3dWQzSWk1OE92UU9EMWJxWHdvbUlQdzlJMjFS?=
 =?utf-8?B?c3J4M2V2MHM5TXpCVkVlN0FvMEFydE9KYUlpNWZ3UTcwbUptWThBQlFiMVpk?=
 =?utf-8?B?bzFTYWpBQTYzV2luZjF5S2hNanR4b2hQZmY5SEtaem45Tyt5NGo4dVZpcmk5?=
 =?utf-8?B?WHNsdkttWkdTT1BDbjlZQi8yUCtjSjUzUTZuWlRSRVY2UExmU3hvZWR5QlhB?=
 =?utf-8?B?ZTAwMk9VWVR3RzdXUW5WTWo1QW1JMC81dEx6WkM1N01YKzJhL1FUTXh0MThV?=
 =?utf-8?B?WEwyQ1AwalFwZm81d2Jhd2xlZUxEZnJRak94SS8yMjRVbjNLb2Q5cHI2OTVi?=
 =?utf-8?B?dzJxckM5NHo5UHRnOVV2NytibFJ4OTh4NGFCdWdKZ1p0WllaZXRPZlVrbnV4?=
 =?utf-8?B?UElmcVN3WDdtemdwNHA2NjNvckNBUSt2VlZpOGN2elBNenMvVFkyKzJoL0dK?=
 =?utf-8?B?WHIxaHlvb1Z5Ti9pMjRNdWU0WTloZy9tZzhZdm5xdUZRbjRYTzBxUHNjZnpK?=
 =?utf-8?B?TFc4TEJrSmtIRVF4K2pUUDVYL1NCclAwOFZKNXloenVVays1OHkwNG9VM0Z6?=
 =?utf-8?B?WGNOajFrKzZnRFN3dk1nTG9EcU9udDg4T1NjOGFHOTdJVG1oclF6Mk5EU2M3?=
 =?utf-8?B?SGJoeXlkdktZYVlRUmFCMnlJenpFeTd4SEduTDhHQ2ViVU00WWlTM3RHZGpr?=
 =?utf-8?B?YVR1VnpKV1psWmpvNHNodDVmc09jbGRaQStOUWNBd3FGazNYaHJyU0tzNGRk?=
 =?utf-8?B?NVQ5SG5tZXVZbWRlVDl2SUFlY0p2RWhyL0RQQWlhNEZNQVVYWXM0NlY3VkRs?=
 =?utf-8?B?WEFVN0w0cWZPWmdCWXVZTWl1bTI5bGtCQkpVSWxUMXpac3R4eUZYVjR4VzMz?=
 =?utf-8?B?a1BSa3lrMFhGNnB5REZUOWU4YjVSdnZFZEdaSElsaU90Nm9hZjFjcjJDNk43?=
 =?utf-8?B?eGRTV1ViWXBDTk9VcXdlem1GOUFxd21sZXRnSUIrTGhLblpSUHJsUnVkYkpv?=
 =?utf-8?B?aHZmL3pSNTdRdml1bFJGV01PUjBHZHlWRng0Z0FKL3hYcmFra25UUnQ1d0Vk?=
 =?utf-8?B?QmlPaXo0WDlWSzhEaElTcVhWTG5JNmtmMzlPNTh3N3BjNVVrOWpjT21KSXo2?=
 =?utf-8?B?QWc1L2NEaFJNVXY5ZklBSEZ5SlBSQkNSMjVSVnovcnNvWnlIOTI3bW9EOTdM?=
 =?utf-8?B?ZWFxQnVGT0xhTE9CRkpLcnd6TCtGZkwxNWVmTjN2R21pNkE1R1EzcHc4dVpa?=
 =?utf-8?Q?eqsVgkNqzb/2xMhUuoKWOSyce7CcZ0sBYRM/jWYVW8dc+?=
X-MS-Exchange-AntiSpam-MessageData-1: hjlrWY0wzvpdkg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc56f81-9a0d-406e-b0a1-08de9f7ef87f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 08:21:21.9377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zoaqvGPX3PKk5h02vS1IPjAGkKFvTVY27tmOOH9m/EtlfzGeC/H0p2g4hcPhQoW1jXLf5LPwEckgfIAhWToWnA==
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

`FwSecBiosBuilder` now only contains `falcon_ucode_offset` which just
gets passed directly into `FwSecBiosImage`. Remove `FwSecBiosBuilder`
and construct `FwSecBiosImage` directly, as a simplification.

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 98 +++++++++++++++++-------------------------
 1 file changed, 39 insertions(+), 59 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index d71ff5de794f..5cc251c73800 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -233,8 +233,8 @@ impl Vbios {
     pub(crate) fn new(dev: &device::Device, bar0: &Bar0) -> Result<Vbios> {
         // Images to extract from iteration
         let mut pci_at_image: Option<PciAtBiosImage> = None;
-        let mut first_fwsec_image: Option<FwSecBiosBuilder> = None;
-        let mut second_fwsec_image: Option<FwSecBiosBuilder> = None;
+        let mut first_fwsec_image: Option<BiosImage> = None;
+        let mut second_fwsec_image: Option<BiosImage> = None;
 
         // Parse all VBIOS images in the ROM
         for image_result in VbiosIterator::new(dev, bar0)? {
@@ -254,14 +254,10 @@ pub(crate) fn new(dev: &device::Device, bar0: &Bar0) -> Result<Vbios> {
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
@@ -271,15 +267,23 @@ pub(crate) fn new(dev: &device::Device, bar0: &Bar0) -> Result<Vbios> {
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
@@ -621,18 +625,6 @@ struct NbsiBiosImage {
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
@@ -898,33 +890,34 @@ fn find_entry_by_type(&self, entry_type: u8) -> Result<PmuLookupTableEntry> {
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
         };
 
         let pmu_lookup_table = pmu_lookup_data
             .ok_or(EINVAL)
-            .and_then(|data| PmuLookupTable::new(&self.base.dev, data))?;
+            .and_then(|data| PmuLookupTable::new(&second_fwsec.dev, data))?;
 
         let entry = pmu_lookup_table
             .find_entry_by_type(FALCON_UCODE_ENTRY_APPID_FWSEC_PROD)
             .inspect_err(|e| {
                 dev_err!(
-                    self.base.dev,
+                    second_fwsec.dev,
                     "PmuLookupTableEntry not found, error: {:?}\n",
                     e
                 );
@@ -932,34 +925,21 @@ fn setup_falcon_data(
 
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
2.53.0

