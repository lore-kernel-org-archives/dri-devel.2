Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDD4CD4F58
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 02:56:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B79F810EA21;
	Tue, 19 May 2026 02:56:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="aN6ZSGek";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011031.outbound.protection.outlook.com [52.101.57.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B727610EA21
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 02:56:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arAV2DmYJDRWFOJpWJpyxXv9UgMMzaNiIgEHq/tcf6o138dm4PRTEWorXqrTCo1zcZEIp2RteXJbBgzB3z/n0//h3aVnzex3p1v679s0zp1zU92BcQsAoh69WKoWNSJ4ZtXHBvNLjDt/MM+qggUCcDl70XQuXUOm4/Zv9r8kkjOW5TRbu5uQ+E3ziyakVldebSNE0ilyudH7cgFMhuW07nmEEmS5D2c9t2JiicpDpT6VW517TL6pc5h9Gc1QjSHJz851LWGfKqAV/inZGc625hlTS76PRCpIWiJLMmElIF6Swv3MnSDHPv1Yjon307Lpm/uQBr+vEUv+QcQIGEFwzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryEDFsZLlk/yFGi+8h5kArYkPbyO7s6gXZb1yslJogM=;
 b=ZR2s3fk6AceCuhV8m8GEV9fZJB0+olMgsl5cdknuiweuURSg9tySsMOOqAYRP/3pkGzNTWpGDsNcNKM5vksZuOLXQEsX1p079z29ZkuHC+sUZOH2NoEG5jfX97N3aITB3d6V/Qeqak2DOS6bSs4exzNg7Pvf5q0UYzv4li5QWu5N1sqJulJ0PbIKZDgmNCtnAtEXKEcj7xRtwVzY1PEU/5wLk35/S4TFTgRwJ7dtPthgrhe5MDaaawWn2Q8oERe0CZKTo0GCIz+WhzwY0xNGSU3xEff7eaV7ikzpz7wKgMDAN8Cb/aYrXQw5hSE61jozs6VkVI+BrGVTOou+w2NADA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryEDFsZLlk/yFGi+8h5kArYkPbyO7s6gXZb1yslJogM=;
 b=aN6ZSGekRb8V5a62lhPwhDD0uzIXhZJ44GVyjsvbRrKC9z/yvc5plsyoCQ5lPzlSFxF4Nr5LDxqATNvPpXc67h9Q6odDL0vibFMGdlFgcg4tX0wggxJ/v3Iu5H54ivCN+AVEsyD+Dp6YZHLeqJ2+hFd724kpBSvvU5gKNDYzIYAKOjyw4hPBcW+NaSuVTyJ1OXg86/wHRN0I1V7wT+MH8HNukk65yfZ69QxlunhEySS42Ec1VmK8b+fyqRFa2nbH4eRBDyCt8awAUFoigjWxEGUPkb1kbCDwshcI5Cn1cLsdScAz8DCwbk9VxUbGors4lIZrivieqQFGisKzyxgJxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 02:56:35 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 02:56:35 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 19 May 2026 11:55:05 +0900
Subject: [PATCH v4 11/20] gpu: nova-core: vbios: simplify setup_falcon_data
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-fix-vbios-v4-11-5d3f210c5602@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0325.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::8) To SN1PR12MB2368.namprd12.prod.outlook.com
 (2603:10b6:802:32::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: df40c49b-4da7-4983-a262-08deb5523d01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: pS+gDp2YlmGXHZzZpyEha/RSH2fS6z4WHmxasXwAGfE/NZhvbQZ+Sps+jgObPlmMUQPPcwhZWO4IxpgKg12rGSc/h4x9crPxbfTuwgowEI+H12MB65e+T6NFv5Woa0J/f3OgUlq1itQxWGrrMVnmxCMyct9/Y2M24C5U4RPI4/j4ADBCgSyjme62Olq/vPR6V2IxcVlUkqoT3InHjrJ5GLLvOrefsG2rYjmLBNj5i16Tsz/qYh8ZLikCvhTntuFA9I+oQtUfDeOl7cjGwNthrZyKAaJI7dqj90Vpu3SyWKa59uoOBsBai5OVflxz6Zu53aPI4s2GOxFueX9wqNhj9OS5gfppZsJAVIE8KIBuSrjjnm3d3toXLUG03vck8PInrSlv3EBHxvQ7NxYq1NOxwrrNsctbNjD88c8qb81na/SvlrliwrR2uZvPQtq/2KRsJwDCkQze/aGn72S6aYDTllrURa7LxbKTEtMMaHy+r+ERfGKrEqfUhDosZfFU0I9JA4AuKO3qoDufQuUvN6ou7mu9Ly5MbmunhAWgBDLTMOSSwi8zONPXenssyiZ9Z93KdKSAHDCygofno2TEVx6jAlom+jIpYR/GXOdITa0UORYMZAQ8L+7ELs454C/+fvRqjJIkbS0F/MDY+X/n5QqMb6AN2JDtZ03NRpxJu0asZ7AxI137GQgYTEns4HGgsJrv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGJUSGxIWnVlM083VFlPMEsvRjBXVWora284R0dkclJ0eTVJTHpFd0dLdDNE?=
 =?utf-8?B?MVJ5QlM1b1h1dHAyOWNEQ1VSdEpkeUJVcWpXdnJtbGlYQzZGTFpBTEw0cHdm?=
 =?utf-8?B?TW50QVpDSGdERDJDT0lzNmlGLzJ6RHBkUytVNkprVmtaK3MxdGlhY1dWbkdE?=
 =?utf-8?B?L0NMTEI1bDNUR1lTci9MWEVpckZmSUFZbUdYMFRqbWVzYnlhSHAxcWZaTTBO?=
 =?utf-8?B?SnoyODgwRWZ1MDVWTzQ5Z2g1d1VnT2tpemZXNmFTb1RJVHRDT2dIWnpWWGZQ?=
 =?utf-8?B?R2RJcks5ZXhvUHo4VGFXeWxvYVZ3cS83eWxqVFdCQnQ4ak9XVjNtTy9McjB3?=
 =?utf-8?B?d3pSVUgwQ25hZE9CWEU1U3Q5WTdBZk1qNk13ZWFtQVh4UU04c1VYWnFFYVh4?=
 =?utf-8?B?OEM2MlFHWlNzTFpqUUNVVTZvTFNWSmI3Vm5QMFZFb21xajVQbWJjOEY4NVlo?=
 =?utf-8?B?NDdNWnd3M0RETlJrNWVPTFdYSlJ2S01CRW9qOWg5MkhHUGVkZjlOM1I5UWhZ?=
 =?utf-8?B?WWltNCs3SVNOTXR6TkFFeE9pbG1IcU9PVjRUZmZ2Y1c0S3o4THp1N2xNcDF0?=
 =?utf-8?B?ZVRSb1N0cCt0YlVEaS9aSHVvVVQ4cWpqaHIwMDZTaVlQblMwYzdHblZuaDJF?=
 =?utf-8?B?R3dOaVNVU3NFQSt5a3dPR3NjeW1XbHdhRDRxcXdPNHYxTWd2dzIzMTdZUEMy?=
 =?utf-8?B?NUZqTEh3Z256cmtveHYwY2c1cExkZUg4UlJPeTFCLytqT3gwSnp1OEtMNXpr?=
 =?utf-8?B?ejFDdkN0ZjdQTUNXUFpoZ0UvS0hiWnpqYXhQekpYOEJVTEsvSDZiNkdiRWRZ?=
 =?utf-8?B?bnFQUENhcmxuTlZPVGZGN2JDOVM5RkU3RVR2MGhDUVhxcHMrSDVCTUR4TTUr?=
 =?utf-8?B?eUVzN09JUkdyVHE1cTRKbjJiTTUwblQ3Y3BxUGQvSENwMTZwV0FEVHR5VmhH?=
 =?utf-8?B?U2Q0UkltbVNTL215STBpMzdiMXlTY3Z3cytRUEJlWEFpVnE0TFYrcWhsRGxK?=
 =?utf-8?B?VlNKRVFlWHNHUGFmcVcvWnQ1RWY2dFBFU29GQ1FDUWUvbUFzMm9JQi9zbWEv?=
 =?utf-8?B?cGxxYVcyN0g0VnhUT0Yrb3VGbDhKZ2FDSmtaSjhpZURXdjRpaVJ4Z2EyaHcw?=
 =?utf-8?B?K095eHlTZGpHQzhGUk56UmFuS0I3ajQ0U09MSDJ5QXB3aHVkUWFRK00zcUR4?=
 =?utf-8?B?QWRiY3VwWFZxSEtMZ2NrOXFOYjh1RjlxSTRDSjZaT1dOUFZFRk1tNVRSUWgy?=
 =?utf-8?B?V3FOcjFvY0U4UUNjV1B2Z1J2MmhFRlhBRkVxZUZEa29Jbmcwa0VneGg3U3Jw?=
 =?utf-8?B?MTFWRE1WR251bllPQStNL05hQVY2NmJaOHJqZWQ5UjBwcjhNaTFHOFJzeXRJ?=
 =?utf-8?B?dUlmZVdMYU5oclJGTnRKWTZtc2dKdVBPRWVHRkhJRTFPSUNmdTdoWGlWWlZ4?=
 =?utf-8?B?TDVxckdOUzhsdmJ2MEpaSlozOVlDNzNjNzZraktHRHBvaUV5MTRHcmlZSDhm?=
 =?utf-8?B?c09BMjdlSm1VNkVhd0k3Uk9ONU5nTFQwUnNnS0tETlFZM2U2MmVIMUhMeTcx?=
 =?utf-8?B?bjlhc1RGMHJzWnd0bXhwVGRlT3Z1UkpvVXhDemFOQm9kVWtZYjVCZWpmMndi?=
 =?utf-8?B?RHRRaTlWaktkR3dvZjRwMXhobmdDUEdvaHA1KzdMYTc4OXBLS3E2MlhnSDRY?=
 =?utf-8?B?UVh2YXJ6bWJ4UnE0aWFES2VLVHFCVmhxREtGRG90U29pS0orYmlLMm8xV2hP?=
 =?utf-8?B?QUJsd0hHNXVkdTV2b2NOWXlXZEVJZVNMNmVRZjJIejhoVFhrWW5QMjBQMTBz?=
 =?utf-8?B?SmdPN0VtdldISWJMZVVrQmNXRmlCQ05uczVtOXp6c096OTFRYkxZZCtNTith?=
 =?utf-8?B?VFAvNithZVN1bE55cm9hQnR3R3R6L1paSXpiOExRbWZYVUNzeHdUNVBFdDkw?=
 =?utf-8?B?OVRhTkRNWFhIb0ZDNyt1bzBsdnY1ZXV4SzZ1VFpkSzYrenRkNTVNcUZ6T21x?=
 =?utf-8?B?WkhYRXhHTHZPNXpDaU1BcmhGelB6Q3BHT1RJTFZIQ3BEc2JqeVV1dzJTY2N4?=
 =?utf-8?B?VmVOalVrSlA0OTdSNHRReHd5S25VRXBQK0lEUDhLL0hwb2FkczhjMHh1K1c0?=
 =?utf-8?B?UGNaVEo2c2pxNGY0MUZNK3BhaUZoS1J4UFlrN21xNkcxekU3enFLeFhoSm5n?=
 =?utf-8?B?S1BrbTFiaXlFR3dNT2t6U0g4SnVMUGRXZXF0d1Y2alJ6anVvSWtvYU54RzhG?=
 =?utf-8?B?RTB0SXQvbDAxV3JWdmZiZjR2MVQzeFl5aS8xdjd4NGlQclJjZkREMnlSemVZ?=
 =?utf-8?B?Y2w4VE9DTUg2SjFlU0hJY0FOSUI0S1M0MG5FSEhjR3NmdWpMRGpEUEM4cnQy?=
 =?utf-8?Q?sUOW7NB+4NdUqMs3InUr7DfzBGsb/zRZ4Fh/l3A9ETPJ9?=
X-MS-Exchange-AntiSpam-MessageData-1: 3ZeDycNKylMAMw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df40c49b-4da7-4983-a262-08deb5523d01
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 02:56:35.3610 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tf/bteqe9JLw55b3QygSlaLv2Bnrm2s3qWxxscCbEtlGU9rgtCx8MI7/fzELZXceKMTaVHsxdiXpFBo9aONarg==
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

The code first computes `pmu_in_first_fwsec` or adjusts the offset and
then uses it in a branch just once to get the correct source for the PMU
table. This can be simplified to a single branch while also avoiding the
mutation of `offset`. Also, adjust the code after this to keep the
success case non-nested.

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 54 ++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index ca101b2b6095..470e0e2a81ab 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -985,48 +985,40 @@ fn setup_falcon_data(
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
+            self.base.data.get(offset - first_fwsec.base.data.len()..)
         }
+        .ok_or(EINVAL)?;
 
-        let pmu_lookup_data = if pmu_in_first_fwsec {
-            &first_fwsec.base.data[offset..]
-        } else {
-            self.base.data.get(offset..).ok_or(EINVAL)?
-        };
         let pmu_lookup_table = PmuLookupTable::new(&self.base.dev, pmu_lookup_data)?;
 
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
2.54.0

