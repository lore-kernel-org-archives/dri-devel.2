Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF85F9D0C4
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 11:54:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A10010E5D6;
	Tue, 14 Apr 2026 11:54:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="SLz5/Ck4";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010031.outbound.protection.outlook.com
 [40.93.198.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E656D10E5D6
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 11:54:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQgpxvKLxssfTFXI8A+o8/QCvHT8J12RYBvG0zytF2uHwkPdEV2GluiYL0xasYw32hC07hpws2HwVrhHDDVLJqVzLJgAM4cREhtaVd9tOIaJqxwuU/0DLXuESyrEPijqPUifdP1vTnBlR3jvprnLnniy+84hQ0py5D7UzGLw2quWH2YqyiE0rH80tqNx5fONN7If95741X9psecZNxp894rFhjpeROQqKU+4DvckeF38fj3fx0K+m7/1Us1AJey4eMSU4wq9aDxoM9B2gViDQGEEn0IxTeZ50uo7is9j4w+Zl4Nwrqp4NCHvrCzvMopco/zwNaOnwDmXaIHgn3PFZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvhF4+dbxjOmvZtl7PBXUzODc9EkBziKizQsGacyR0g=;
 b=r4SuQGMue1LzqLX1ZeMw4KmOxntyOgZLi/5W6gNRZsz8UYQwJqfZeXsW4ITjBcT2XPIm6+e8Ix4pFTFsAS3gLPjxCqNMa1YryfoRcFHYGwg8PsSJbQ3ZqQtX0PMHcUvhlb0/nbJs4x9SD3uiaLRffQiRSd6C6gwkeojvYAgvLNQ+opDxHhUSV3p/Iy+QhRMzM5oDkrUBMe+WxrqwE1HShW28e9sGX87KMMSEZRFt/1ZyvHfaLYX4TmJNWS/Mr4TkGdDn/lU0OD08dEPgBEj2boP3U7fWmQqozo7YXpCSRzB3WHh9thDs/hlVK2jExQQwV6COCYINq/CiQoPBKJRmwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvhF4+dbxjOmvZtl7PBXUzODc9EkBziKizQsGacyR0g=;
 b=SLz5/Ck4Bw37KLFss5AVv0Kyl7PiT8sYuOEBxuWsOt3vYt7vKLsnoIqoc5z7LpAiDJbl7H86lWuhzyI8L00JHwLSwOcfucROxy6C1jO88lRT81aZ3dVj5g3jDU4fMFs2gyE2saJjfa0OgYP9MbaG7sRiodeSOW7LADOGj5/finTxp3kWW7kbU27tG96suWFQLmXJmQexmyonelGUfzMjPesCGj0Fa4Ibo/VZoInParSOl597g02PtT1h6zQIf0x1edbDT5pRF5UAazy7Dj345sUkB1rPbVx5ZUuleaK9ruUDZ2eSlxxjZQSWKpCYhJpmh5UsOKr8Od/nkFl7VYYUfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SJ0PR12MB5636.namprd12.prod.outlook.com (2603:10b6:a03:42b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Tue, 14 Apr
 2026 11:54:50 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 11:54:50 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 14 Apr 2026 20:54:12 +0900
Subject: [PATCH v2 09/11] gpu: nova-core: vbios: simplify setup_falcon_data
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-fix-vbios-v2-9-705d30d16bba@nvidia.com>
References: <20260414-fix-vbios-v2-0-705d30d16bba@nvidia.com>
In-Reply-To: <20260414-fix-vbios-v2-0-705d30d16bba@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Joel Fernandes <joelagnelf@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: DM6PR02CA0141.namprd02.prod.outlook.com
 (2603:10b6:5:332::8) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SJ0PR12MB5636:EE_
X-MS-Office365-Filtering-Correlation-Id: a0e6bf7c-6400-4fe7-68b0-08de9a1ca256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: s2/eFZ9tG+Ng0//GBVY0I2rL7aflyg0igCwvpMjQ7WYquEIcqvcSpqBOxadQcF019Oe4RZ6ZgZJRiaxLUHSoK/yN3ktOqN+SqPjysltkXHajsli/kiQMPo4qTMb4lb+/JShFGwWfTlwJGMoR3cxA3utvUf4qI2ePOWfd2S0ZJmFZXzp9msQh061NwaXhCLS596HB8fG2yAMZNGNbGSlEv0i6tmxCdJSxtk8mhafdnyP4bh1jU1INTC0FgK3jokQ1E+xOjCCOXZ3pmkdcTW9TvMGj++qvKYMP11rzo/Ujk4dKcld9JDB8W5lHFyWcaVGuNWB9Z+DoFPboGWkoJK5RFvPyrQ63wfYl1FeRojIc4lKfZv+DIqky0SdI5e7Z5m1pww5uGL+fjnk4ebUN0jRCwObwOeq2h5fMwRfzIGFjRBHj1BoI3Wd1omXaKDkqmkDLfosPvmBvsskdeasLeZZhRugjh7opTnnRXu5F3lyc0tlZehbiSeBpwm0gKzOLiPWpktGrTjvkfBUubGS2SkbGfOk/5KuQrj4wSKNVUAa6nqR211WLflIyLu+d6QCxrfMwhtZj/DOpmUTcn4+p81HaBVlxAe2EfwqHdubFRukUIlbXQEAUSfDmAcCpcQ7DBchsBoJF1GtPqgQ7uvKX9xsjAoKuI7sEvdbeJpb/zSiddF7DZGv5qM2jSUiq+zhy4vQywHhXZCoOvblxDm8aJotexvBLxZNhfh51y+lLJz6BMnE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTNSbXhrRnptSSs1S09jeVVIMERVem4vY3NtdkUzL0xCQVVMVTl5V2wxNzNj?=
 =?utf-8?B?dVVhSmVTTkJzVUFmc1hXeTJlcUdJQnBMc3JHdEh6OGtWMmJ6RTlkR1BQOU03?=
 =?utf-8?B?MFZUeE5IOEdwVEJpYlpUS1B5bEh2cGpEUjh2d2pIc21URzZZQ3pUQmlDaXFk?=
 =?utf-8?B?TSt4dE5XU0tIMXBJeXN3clBDRU81NG9ua3hjMFllaS9aQWoxT0psMzdEYmo0?=
 =?utf-8?B?c0F3WHJpMmQ3ekUvb1FzVjlsWWFDeVN5OXNKQXRBTzZqaU1ia1RqekpvVmRw?=
 =?utf-8?B?TDN6RXd6MFR2VktsUGJwUGVxYXk3RXI1RXRkZFlhVisxcEgySUNnSXhRdjZN?=
 =?utf-8?B?ZTkxTVVPOG9lN3pBZ04xUm1ycUM1OUtLdlZEdUozNWZ0TDJLbTBKTGxrcHhh?=
 =?utf-8?B?RFVwTFhRQTBrSlJvbjZhT1BNbVpzdG9FK01jd3pPcDM0YzRUM1RWdlNIRjZ3?=
 =?utf-8?B?R0U4L3NObnBBRytpUDlHNHg0Z3N2d1NxcUJ5a1ZRMGVtaXZoWnZMWG9kQ3Vv?=
 =?utf-8?B?WjNrWktQcjlYa2p3YnBmMjFMb2cwY3pGdmZkV1dOaDk4L2k1ZjkrQXRUdHBp?=
 =?utf-8?B?ZVdFNE9UV0M0MERDb241cmcrWUVWY2dMbnlYa0dIVVFXMGdlSGJqZmYzdFh4?=
 =?utf-8?B?Rlp4cnhGUmVaeHQyWnlJRDFNS2EvZnA2amRNMmZkT3NZZnY0WStZMjVPUHh6?=
 =?utf-8?B?RDJOMHY0MWlpQ0VvVjYwbVpmYUladXM3MVhDbitXK25UVTV4UzlnOG41djZp?=
 =?utf-8?B?R05YRWhnMzQ4R0VYZUF2ZmhZOGd6Z1pSRXFpNG5PUDY3Vi8zQzdJckEzRE1y?=
 =?utf-8?B?d3AvNldJWi9GQjVpb2FvUjRxckRMc3dJbkEwckVEVUdHTUxqQUxScGkzaFFD?=
 =?utf-8?B?bGdsZjkwanZWRjBRRDZyak82a2JwS3daSWdlQjl1ZCswb2drV2dVeVcrOU9z?=
 =?utf-8?B?Y292YUMvcDR1ZWlzcVF5d1hWZ0pqMTV0elhsc3AyNzh6cHgxOGxmN3BwUXB2?=
 =?utf-8?B?UExOY2I5RE5iaXRmYzkxamJVNlgrQ3ZlS2oyWi96KzNiL1FMc0pleWRLMVZB?=
 =?utf-8?B?VXNMMENlc1BWUHFJdmxadDhYajhZc1B3RXArYXVVVGxTMzJCL2U0VWhoOTlV?=
 =?utf-8?B?UEtGUWYwWmZUNEIzRUdIRGMyNTE2MElZUWF0Z1oxWlFudk9zVDN4Z2xvM2dw?=
 =?utf-8?B?Z0FFUmlaWU00VWV2TUsyVVlMR1crRnZ0WXVPcEd3bjNVaWU3UmxTZEViNytn?=
 =?utf-8?B?WWZNVVZHOGhxcDNyYXZMbUVpZTU2UG9paWVZQ0h2ZUdlUks0cSsveU5IZENs?=
 =?utf-8?B?WktlRzY3aEJuTk1rRElKRVpSVm90SlBRbE9jU0RPRGtEYTJwMS8wQXYxKzdR?=
 =?utf-8?B?RTc5dGNoS29XZFI5K25aSVNDOSt3VHF1MzloOTBZVTBqWVppa3BjY3pWbUor?=
 =?utf-8?B?dllabUFMM1p0K0drdzM5eExLS2FHZEgzdkcyTlJxY25yU1o4ZGZoQnMwVm9R?=
 =?utf-8?B?dlFBdXUyT1Z0R2VEd0g3RmFhdmJsVDlZeVpzdDQ5QlAvbFVBeWpoZnAwc24w?=
 =?utf-8?B?d3BPQ2NUYkpvTTNuSGt0ZzdObE5Fd3RGZXArN3ZpUHFJcTBpVmRQd2M3YzJk?=
 =?utf-8?B?RjdFTng3Ky9DQ0pCd3d5dFl5TUFNTG1yZkpxY2RDTEllU3A4UzZabUJEQllh?=
 =?utf-8?B?QjBnV0s1bUZZWm1EdDdnSE5DSndLbmJ2bmZjVkYvbDlEalNRakVMY1VSWXJs?=
 =?utf-8?B?dmlpYStBakJTWFgwSXM5VWlGUXVTaW03cVBBbmZSWjFnb2F4eFZ6TUFhaHp1?=
 =?utf-8?B?MTBrRXJtQkRFSENUR2tZY016cFdhRUlqRUQ5aDFQTTErdjRaU1hNdzlSQ1BX?=
 =?utf-8?B?a1JBSWYzMDB0YlFNa25ITmxvWUYxcUtJQ3lKa3BDTktqVGYySGZNdzFXTlZh?=
 =?utf-8?B?c3NNTnhUYUxnWUY1UDVLTzE2dk9EQjNRUXNsRVJnUjkzZldUVkVkSVY2VFFx?=
 =?utf-8?B?REJEUFVaL1k0UDVEQ3VqQkVFV0wvYTVkK0Z5S3JJU0RtYm9SMk55ZkY0enNw?=
 =?utf-8?B?NTViK0ZDcWV3Z2R5Tm5oV25VRWVML2tvTGFnei9PZFRCWDhWRVRtMUN6Zjg5?=
 =?utf-8?B?Vk5TcG8vblVxOUg5RldYQ3lZWEhENUpLWjA4aFoxTXZDN3RKaHR0c2pqcjBM?=
 =?utf-8?B?ZCtMYVk0VEFRZDRVTjdsSkRybDVIem9nOW8vSUVjR3ZsT0xyWm5OQTFiVGVS?=
 =?utf-8?B?eklFWDYyM1NpbHdLRHVQbHVkKzNuZCtKQnczNDFVcTJySWlURFBCSndscEEz?=
 =?utf-8?B?bkhNZDBrU3FDK0dhbmtlTDdlNDZPTktRRFVJSGlKMlN1a203Wlp2WVU2OGE0?=
 =?utf-8?Q?9HwlkdynaODXsJA80FZAO4GDcauJz3tiyzVcJ07j4husg?=
X-MS-Exchange-AntiSpam-MessageData-1: DMLadJz5Kf//ww==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e6bf7c-6400-4fe7-68b0-08de9a1ca256
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 11:54:50.7622 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/ovxHLiRNa3L6RwK0dzkuYl4BVcr0tRfbNZokv/0MSTlfG//3n64glBhIl1IqN/CaaFo+QQwGXTy2r0+qNE7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5636
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

Remove `pmu_in_first_fwsec` and reorganize some code.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 59 +++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 0c0e0402e715..d71ff5de794f 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -904,48 +904,41 @@ fn setup_falcon_data(
         pci_at_image: &PciAtBiosImage,
         first_fwsec: &FwSecBiosBuilder,
     ) -> Result {
-        let mut offset = pci_at_image.falcon_data_offset()?;
-        let mut pmu_in_first_fwsec = false;
+        let offset = pci_at_image.falcon_data_offset()?;
 
-        // The offset is now from the start of the first Fwsec image, however
-        // the offset points to a location in the second Fwsec image. Since
-        // the fwsec images are contiguous, subtract the length of the first Fwsec
-        // image from the offset to get the offset to the start of the second
-        // Fwsec image.
-        if offset < first_fwsec.base.data.len() {
-            pmu_in_first_fwsec = true;
+        // The offset is from the start of the first FwSec image, but it
+        // may point into the second FwSec image. Treat the two FwSec images
+        // as contiguous here and subtract the first image length when the
+        // target lies in the second one.
+        let pmu_lookup_data = if offset < first_fwsec.base.data.len() {
+            first_fwsec.base.data.get(offset..)
         } else {
-            offset -= first_fwsec.base.data.len();
-        }
-
-        let pmu_lookup_data = if pmu_in_first_fwsec {
-            &first_fwsec.base.data[offset..]
-        } else {
-            self.base.data.get(offset..).ok_or(EINVAL)?
+            self.base.data.get(offset - first_fwsec.base.data.len()..)
         };
-        let pmu_lookup_table = PmuLookupTable::new(&self.base.dev, pmu_lookup_data)?;
 
-        match pmu_lookup_table.find_entry_by_type(FALCON_UCODE_ENTRY_APPID_FWSEC_PROD) {
-            Ok(entry) => {
-                self.falcon_ucode_offset = Some(
-                    usize::from_safe_cast(entry.data)
-                        .checked_sub(pci_at_image.base.data.len())
-                        .and_then(|o| o.checked_sub(first_fwsec.base.data.len()))
-                        .ok_or(EINVAL)
-                        .inspect_err(|_| {
-                            dev_err!(self.base.dev, "Falcon Ucode offset not in second Fwsec.\n");
-                        })?,
-                );
-            }
-            Err(e) => {
+        let pmu_lookup_table = pmu_lookup_data
+            .ok_or(EINVAL)
+            .and_then(|data| PmuLookupTable::new(&self.base.dev, data))?;
+
+        let entry = pmu_lookup_table
+            .find_entry_by_type(FALCON_UCODE_ENTRY_APPID_FWSEC_PROD)
+            .inspect_err(|e| {
                 dev_err!(
                     self.base.dev,
                     "PmuLookupTableEntry not found, error: {:?}\n",
                     e
                 );
-                return Err(EINVAL);
-            }
-        }
+            })?;
+
+        let falcon_ucode_offset = usize::from_safe_cast(entry.data)
+            .checked_sub(pci_at_image.base.data.len())
+            .and_then(|o| o.checked_sub(first_fwsec.base.data.len()))
+            .ok_or(EINVAL)
+            .inspect_err(|_| {
+                dev_err!(self.base.dev, "Falcon Ucode offset not in second Fwsec.\n");
+            })?;
+
+        self.falcon_ucode_offset = Some(falcon_ucode_offset);
         Ok(())
     }
 

-- 
2.53.0

