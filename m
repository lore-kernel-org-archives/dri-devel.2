Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0714FCD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 02:56:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E4AA10EA19;
	Tue, 19 May 2026 02:56:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="SIyafHOO";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010055.outbound.protection.outlook.com [52.101.46.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E66DC10EA27
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 02:56:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nX4Okmn9z7VpmzQGm6w9m8y6afTvms+YDSeuO3E7Rgwn4YpYAZfaoe3roFtOcgZCqp+OYn1fyiQTeZGClTgXR1IAmSeQwcfNfOSe8ufUfzyUVk2x+mZKgx3ysBslv7kTFroyxEeyNceNk1rJiN4tJe9IuMsEgWFXKjkny/BwKRv0tYRGzJZeXYqVj6phwJ9WNLYtzbVrc7wiP+Q2Q8HI+9lR1RU6BSo2J8ltOFnywmwBjwT93MAX4ZhEWpSwS0JQO3GzrAwxKJh1/4/su3221QMOEO+9jwa2OlbJIKGQPqQg9umL5zBBWLmM8lw7SDG2S4CTvTIcZ8eIFp8ZAa7mDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=655A+G+trSoTbk7oF5v5Hqze1bGhHNdcIPS9BGrphMI=;
 b=HGlvGKanb+4SpoJv37WZga/vSwxaxpgseeFs8oZo6tKBsCexLN1Aa43pVVdoYxAh155fbyMPHgXEJSWaA3gDZZFngRKS0TmEB69JX5sj5eQtt+VKX82AwDdWXtYruOubsNjPjpgPHWUgEymdHevK8usogdHXTIFccQ1ncMV6R7AEe+/8WiBigVd4U0VT/wfKFiuWhPTSg+fgk+Xt89nWb7zQguJ6jv+IhFrLiGfWu4yi7pcOpay4WzkCBmVUHabOzHFd02+yg1YMXlVSOuMQwiF0avwgzQgtbix+agOMiYwbdt2gKpgy6bjMOcI1SR2EcRTmRUKDfBWJta5zaIu+XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=655A+G+trSoTbk7oF5v5Hqze1bGhHNdcIPS9BGrphMI=;
 b=SIyafHOO8R56Qu5UBju1pl7KhRIktIiHC+WbwipcRx7nuK+/gXzdyj90NXkQ1w5gllcqO7JCqdcidzxzORJWtaOe/9wQcBhpkvd0ITIdB/Sp56gv/TP6KCl1XHm6Ed5Qhwzs/Dq+pvtTfMIELC/gCYVk1LKaRLXoz3kt3oL3qv03nbVmSO2QLFLZ2/Y+lgUxlm4F+aCtI5fTcKqfT7xW18p45vcfeyxFyD0buZAvobzJVoYq7zSMSZq6AN39bKwCHUSuI8SfgkJcUZEY4vWS5uoD530b3Z7eAkmyyttm3N8mJIcKTMIE6YbiWA4Qw4yTKp4joCW5dD9Me9227CkhEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 02:56:31 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 02:56:31 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 19 May 2026 11:55:04 +0900
Subject: [PATCH v4 10/20] gpu: nova-core: vbios: compute FWSEC-relative
 Falcon data offset
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-fix-vbios-v4-10-5d3f210c5602@nvidia.com>
References: <20260519-fix-vbios-v4-0-5d3f210c5602@nvidia.com>
In-Reply-To: <20260519-fix-vbios-v4-0-5d3f210c5602@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P301CA0052.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::15) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c171324-65ac-4411-8d51-08deb5523b0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: 9faQyb3Fmy75/2Cs65dhjKf+O6XYa+kYtILTAXDOYbExlT68acxiWO3OxBJVce+kB19BpfPqedp5yL9AeWpXfo+15hi7ZiYZWb7AZBorwKZKzEXjxOXg1CGsHDa2X6NhrPcb9h002Tu1z9Rm4Yu+hRRvobx7AXfrCnP+9NHj1n3a8PE+fKuMqE/MtTtFi7F769xncJKycqUQImrSjHgQ6kF57PGbpfcC2M5tmnWytVHMWIziWT8KcMYJKZpt9ZffFoiLG/ReBRvX8Ce6/VI1cRafP4OEyqa+1wxTbTfFG3P89VLQhZeSNZoaLL5F3UPBi9QjJ2yjjmx0M89PsIgiP4Iwv9bI8kKtkpNmj0tkrnzQxXUuHY1JdRwXq8um16iBAy1qBLfTdcyGlxQFa2Thsl96EFNkUOXWc43fmvz21XHknprkeFFQeSFFYWR0u2iHeSfIi8ujoOAdHme56cnzzn0dVvJI7AY87LCm/sjR0Vpf3Tv1uJqvhRbD8E+oNIDUQBQJ74cmlpg5i/4ZG3Xr1/miK4ZF9uMfI8PODt9dHPWEGa+nh+bfjIun1sr72tNVQc3w2ZM9ZpFL5rWd6TDP3vgRNWAw8NfIHhF3zXg/Z8v+pgjphrlILGbQReKuORklAVF+k6P2keloUZStDMG/jftDgnhQSSncP/wH2D9IfQVXKr27ZU773lNh+RtvL1gk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enpnUndSdC9XVWt5TUhjL2crUWdvVjNha2h2YUFwTWptV08yUlA1dlRrOU0w?=
 =?utf-8?B?Vy9tRnNRQVNxN1NDUzhXNyt6OEZHZ1RPQ2trSU1YRWRscDhLRGV1THhMTzQ3?=
 =?utf-8?B?d1BLaGN3Q1lzbjlIN1BQc3pIbU44NFpBQ29qWnY4aW5aTmphcnRQa2lYcnpI?=
 =?utf-8?B?WWJ2WXJZZEMyZUo3NHV6SEdWeDVTV2RweXZzazBCMnVZcmhQc3pJZllwanVa?=
 =?utf-8?B?bUlJTVFaZXZBNTZSM2tTMlpyVGpWejhsazRSRk9WSHZ5NWs5UmFwK1dvbk9i?=
 =?utf-8?B?T0RUVnBhbmtrbGRpcGZQUC9LMkNzSkFjUk8rUkhXRVhyZ01OQWVNcmFOWXkr?=
 =?utf-8?B?OCtzQjlNTXJjUEl2Y1pUU2VYQ2NPYkpXem1WZlVTUEh1cHg3bC9TaXdHeU5m?=
 =?utf-8?B?b1Z4OUphSDZBazl2bkpmNGg3cHdleHhlcjcvdS9uUjhEV1NzOERwdmRUbkxM?=
 =?utf-8?B?TzEwRVNJU3ZoWWhiM1pxT1Ywclh4NnBnOU1HZFJNaDZGSWxlMSs5TVZNODlw?=
 =?utf-8?B?Qm1nbVNGZWJEYW8yaEliclNWdUhlU0g4TWFOOWtucVdWWm5MQkd1VHNzZWNI?=
 =?utf-8?B?TkkxcmNENStXUUNEakJHTW5vUnFFTW5EVis4OEtvZGliZWhuU3hwV3JLaU9D?=
 =?utf-8?B?TGw3UnpvZFNTd2pGMjlkd25Md0RQVC81c0wxQkFxTnFyQUFiTzE4NXI3WjNW?=
 =?utf-8?B?djdvN1dMSGJMMVQwekVIVEVGSEVMQ0hzUjhiaGRiQkJWWVFnMnNqdUxDYk12?=
 =?utf-8?B?bC92YUdSNTF0RHpPK3hDT0crYTRvUDVwVzQyMnVCeDA0VVpKY3FvR2dITGZK?=
 =?utf-8?B?cXMzblZlZkhDZWZWVmMveGhWb20vZlFPNWovbE03bWR0NHFQeWVhWkc5YTFJ?=
 =?utf-8?B?MXg5U04yTDhJcmNDMzV6eXFWVVk5b3VabFFGc24yM25FZUZyL1NLVDd3RXVa?=
 =?utf-8?B?WmVtWnpNR2EzaEgwcTFmSWR3dm5PZVJ0citSNm8wSlFEczFVSWVzL0lOL3RF?=
 =?utf-8?B?NDhqZFdWZDArN2VQSitwZUhwWkROVmQ3QnUxdzYwNzJYN1BVVmhXbm56c1ZC?=
 =?utf-8?B?OFlIV2hXOTBiMmRPR1J0ZFc4OGxMMCtnRXVLSmtib1loSTdUSkVhOHRnSFpS?=
 =?utf-8?B?L2VDUlBpQThKcklXcHh0cU9ybTFvM2xjM0Q2R1pBUGl3UnkvcnBDSi9tUjZL?=
 =?utf-8?B?TVF3UWlkYUxCZ1ZXWmJaZ3FOWFBlTm13K3Q2Z3VvQ2J3bERleWJmWk1SUGNN?=
 =?utf-8?B?VXUvdXZ2MmF0R0lWanNHdTJWY21yTGxtQWE5ditGYk8yR3phei9GZlZFWVRT?=
 =?utf-8?B?RFpGeW9OWjh4YzJITnpmaGlrczZhd25aNFM5RmpjemZreVFtMG90cHZKdERW?=
 =?utf-8?B?M0N0dlJZa2N2N05RZVZmSm9nU1VBazIrZjBkUktjZStBZHVHUU1hVGR2T3FU?=
 =?utf-8?B?NEdaZ2RVWUxBZlVmTzhFMmxVNHN2YTk1TGJDVUJMd3dhcDVEdCtlb0FxRlNK?=
 =?utf-8?B?eXR0UmNwcTlYMERIeklmd0FyeHNoQXBxTzdBdmFkVzRCanFCdG12RWlSbW9K?=
 =?utf-8?B?RGcyQk5Ka1duejJOWStMQzVGSVJ2ODlFQ1JCZ0xaaW1xTVJGSHJaSnEvRGhO?=
 =?utf-8?B?aldJbmY4VHJUdjlUYnlGaFFTVXZEbFBRZ2NSMHlEVGNGT2RBSmw0WjJXNWhl?=
 =?utf-8?B?aitKNUM1aUxpQkdQRGNZdEQ1WExyMnlGSjdrckJwTW04KzJyRTR1RXB2UmVN?=
 =?utf-8?B?VlNNZ1FaY3oxQU4xa29IUS9BRE4xUUVibnE2OWVpNmpxY2lMNGt1K0lDYWpr?=
 =?utf-8?B?RWhSL0hlWDdlN2pnV2owZUl5cmY3TGhzeVFWdG90NGZBR0JpVFdTU3N6dEFa?=
 =?utf-8?B?SmxWZURxZDlpMDM0NWprNTRsR1pVVEtqQVVHWGMwbFVwbTIrNTRyOGZPOUFz?=
 =?utf-8?B?NUlURXkyV2t1VjVwMk9MN0M2U3IyWXE0cEtjRjlZRUFpQjAxRFJOMUsvL2l1?=
 =?utf-8?B?VnFxTG9HblFLQ0UzTTJzRFpIU3dTZ1pMUkI0UHRBUFRjNkpTdFJtY3JER3Zp?=
 =?utf-8?B?VXJRejJFWS8vKzcrckJlek1kUGZidWQrYlJVUUY3SGNZNFBZM2xsOEI4cFJj?=
 =?utf-8?B?REVJV0tNK2lKZjN3cWliUndJY0ViMkVEdkQxOTRKZWhIeGlXeUFuVjNNT01G?=
 =?utf-8?B?NitySlRPcncvaHpNZTFkV2dPcm00UHc0UCtwckl1ckpuR0pqZ1hNT2dQNXN5?=
 =?utf-8?B?R21zZkJBMFhCTVBlbnh4TmhGRnVJNjhNQndzaGZKbmtlZ2UwSHgvcFFDVnRy?=
 =?utf-8?B?QWczckowem9iZHJ3QjVBM1NIT1VldEljRFVoRGRiNVBxamFnb3RRdXFlUWVO?=
 =?utf-8?Q?eewOLDWxupgkNwx3jHT2MHsIAYdUNuBlS3o/UgQ/eW8H/?=
X-MS-Exchange-AntiSpam-MessageData-1: AwxEv2x7MAmCPQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c171324-65ac-4411-8d51-08deb5523b0a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 02:56:31.6563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RU/xw+wjKCYXdXAqq94XTVF1jAnXIxrXXEjZ9+oPqrfi16kfPTlldMPhlOaegn3SkqUUkM3ptcXMSb45/8BEig==
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

Push the computation of the falcon data offset into a helper function.
The subtraction to create the offset should be checked, and by doing
this the check can be folded into the existing check in
`falcon_data_ptr`.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 48 +++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index cadc6dcffefb..ca101b2b6095 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -846,33 +846,29 @@ fn get_bit_token(&self, token_id: u8) -> Result<BitToken> {
         BitToken::from_id(self, token_id)
     }
 
-    /// Find the Falcon data pointer structure in the [`PciAtBiosImage`].
+    /// Find the Falcon data offset from the start of the FWSEC region.
     ///
-    /// This is just a 4 byte structure that contains a pointer to the Falcon data in the FWSEC
-    /// image.
-    fn falcon_data_ptr(&self) -> Result<u32> {
+    /// The BIT table contains a 4-byte pointer to the Falcon data. Testing shows this pointer
+    /// treats the PCI-AT and FWSEC images as logically contiguous even when an EFI image sits in
+    /// between them, so subtract the PCI-AT image size here to convert it to a FWSEC-relative
+    /// offset.
+    fn falcon_data_offset(&self) -> Result<usize> {
         let token = self.get_bit_token(BIT_TOKEN_ID_FALCON_DATA)?;
-
-        // Make sure we don't go out of bounds
-        if usize::from(token.data_offset) + 4 > self.base.data.len() {
-            return Err(EINVAL);
-        }
-
-        // read the 4 bytes at the offset specified in the token
         let offset = usize::from(token.data_offset);
-        let bytes: [u8; 4] = self.base.data[offset..offset + 4].try_into().map_err(|_| {
-            dev_err!(self.base.dev, "Failed to convert data slice to array\n");
-            EINVAL
-        })?;
 
-        let data_ptr = u32::from_le_bytes(bytes);
+        // Read the 4-byte falcon data pointer at the offset specified in the token.
+        let data = &self.base.data;
+        let (ptr, _) = data
+            .get(offset..)
+            .and_then(u32::from_bytes_copy_prefix)
+            .ok_or(EINVAL)?;
 
-        if (usize::from_safe_cast(data_ptr)) < self.base.data.len() {
-            dev_err!(self.base.dev, "Falcon data pointer out of bounds\n");
-            return Err(EINVAL);
-        }
-
-        Ok(data_ptr)
+        usize::from_safe_cast(ptr)
+            .checked_sub(data.len())
+            .ok_or(EINVAL)
+            .inspect_err(|_| {
+                dev_err!(self.base.dev, "Falcon data pointer out of bounds\n");
+            })
     }
 }
 
@@ -989,15 +985,9 @@ fn setup_falcon_data(
         pci_at_image: &PciAtBiosImage,
         first_fwsec: &FwSecBiosBuilder,
     ) -> Result {
-        let mut offset = usize::from_safe_cast(pci_at_image.falcon_data_ptr()?);
+        let mut offset = pci_at_image.falcon_data_offset()?;
         let mut pmu_in_first_fwsec = false;
 
-        // The falcon data pointer assumes that the PciAt and FWSEC images
-        // are contiguous in memory. However, testing shows the EFI image sits in
-        // between them. So calculate the offset from the end of the PciAt image
-        // rather than the start of it. Compensate.
-        offset -= pci_at_image.base.data.len();
-
         // The offset is now from the start of the first Fwsec image, however
         // the offset points to a location in the second Fwsec image. Since
         // the fwsec images are contiguous, subtract the length of the first Fwsec

-- 
2.54.0

