Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2BC5F327B0
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 08:21:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5516610EBBB;
	Tue, 21 Apr 2026 08:21:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="E0Ras6wy";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011053.outbound.protection.outlook.com [52.101.57.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50C8B10EBBB
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 08:21:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fHYN3S9QKMVpio+r0xLsZrecHU1oll3rFOOlTsG6j3P0p/N7mZY3O811piYQk6uU80JEM/5ERcCSieZb06Vi3rm1eOPJ+cKm/NmR1QnD0Iugn5tYZn22DdRkhg2usy/If6u1oIkW7fgg5k0Y0EoK/a9KHzYQictWQhGd+U8/OEq3xchyYzBAG40VywnAlWEAeNHOlYUBmldN5+jR8iG+LFRQfxjydzf1HaLZHRgJAzvfyTnZH2Aj+doyB/PJ+eLsMwo/qwHy9H6kHf6q7f4hwwSY6fUoO9AAzwbVSQteInCqayEAZKILzOqZnny6vENXIuVHvtC2Oe+euKgo4L1D4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0zqFagrkwJ+Pk6zAFxMSA8BywMUcrv9SADWVL15F38=;
 b=xBMpvSEmfxS2MN+fdiLL3bXBTEJG+SM+i9VEyDnKpCOJHOqTKo7q84j+1SAmH+mQ7Lm0sSElbB0jQyrErMamJ7Trogg9cdPega3dL4GRQfnC8b/WiTxNjHn/XeqHvgIT2HaefJvBbSuDt2PpfEjaYES0Mjqs4XxKUyfPJdeG8AhQdvc245XK867JXnClvnnEJHXDRURSXOm1ckQ0PtUg3rGKhauo3TO8Yn3oJQn/7ZIFXFycmraPrz2CoWEs6yjkXDxFkUoQJBkxufwr5LSUDTwRACp/q99/1yiEBm1K1+1+A9TvVZm6Fni9TK6UNs/Bsy2qT2f9s2Kma4xJAj+Zwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0zqFagrkwJ+Pk6zAFxMSA8BywMUcrv9SADWVL15F38=;
 b=E0Ras6wy2sKNJnZZh17Ki//mcwHKUCoM8kyYyJJzV1Ug7j+NidB0zjTVwzaCuJ+DaexnAx4DbGHm3SDYuXaUoR+4m+Ly2yEjVUMSglNnNzQU45Y4TVE3EGwvJkRYifQugQbExMzZ3BDnA+OIGClHLDyuw9INpK1Qb2ospSszECbkaTVOAvFWogLKD0BmoMwiwcuSB/2C7M5yGdhoo0M+jJMuNCuTMEwuefqfVo4rsgXyR99Gc1AH7E0+1JdQMpOK31b8HPvKZqqYnr/XrJbZx8ZmydohgGu+VxoWXzTso6Y+CAKEjCG0TxAb72n4gS+liWyXac1m2EeQoP2epf2ftg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA0PR12MB8376.namprd12.prod.outlook.com (2603:10b6:208:40b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 08:21:13 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 08:21:13 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 21 Apr 2026 17:20:27 +0900
Subject: [PATCH v3 08/11] gpu: nova-core: vbios: compute FWSEC-relative
 Falcon data offset
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-fix-vbios-v3-8-8f648aef7a85@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0162.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::17) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA0PR12MB8376:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cb88345-9bf4-4ced-a4d5-08de9f7ef36b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: OQbZNTTTumvHBd8bqryb1mpe7vqPkZ6VGttE0wjRSPDpYhl01/xDmrNYPFN2rxHHtih45u+e9SbZwfCG/Icy2qvV77YSml9RAQcrl85ofqL3Amd4Na/t4r0FTdbBTh6aKC2FNZ1gbSQ7xQ5wfvBmtHM6dcAreCVtGubl5dBDnBfsURQ9U41buK7PgyDwg+yG3861/nzScR95o0HAv7+QHtB2G2FlUvx8JcZjJhWbuf0WXynwmJ/JOk3wVN4BjCfndzgfph6pG8XwzHnrMtR8nBPkmVkYAr16DHIc8hbKtrwhaEz59fVAchb+Tp74OMTldcvyFYi7XgJ78YdAERR+KGNdh31agkzuIl9CGcpZmvSJTodV6O1hB47Q2CVkNxYN5SzIV+qiTtMhJvzN3985uOSf/fZgKG5uElWAQ4b4x/7PNgRAvXqMJFtzkVG2z4P4Fznh3RnJwfUlNU0p4qChy1yyCXBPolvHSyyaFw9Hp9P/R+QLOTV5DVt1cXRLnhRM67vSEQ+ffNULfvlvFlLU6hy3vzJll2ZPvLTewAk/BfeN6ZxtNZcFzVV/63Oqry62Dp+UAU837LsvmCpC+k60FozsPUH5mN4/A1UCSlvlLetKxHBwjTFGHGnNTCwNIRKF+iuFq74c033Bqx4NBx9VKqVZRS0H/BHKrU/5esVlakEXZG2D937lFNlSWnPZnY/udBGwfMBc5ahDK2gNgh4/9VeDmaeCqGjiBNDH+fSn2tg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N28xRHNJS24rREc3U0tZL2gzdjZiNUFWdTU1MFljYXI3SnJOazE3Y0FFRUFP?=
 =?utf-8?B?eUZnT1U5REw3M2lhTHJWam1tb0NTZEd3NXVLRit5OXcxaU1seVBTRHg0eGhx?=
 =?utf-8?B?YmNBTmJTemw2VVhYYzhYbTZXWlJJSFU3WGdUbTEvczR5d3dLZnp1T1BrczJ5?=
 =?utf-8?B?Y3gzTW5kRkwrWVorUE5FTytFczNRWTVkRWdzYTFnT2p3WXBRUG5raW9tUi9U?=
 =?utf-8?B?Uk9XbVpSREZUdkRtYTF2VWVib29paW1iQllkK2JocWRnS0N1L3REVDUrY2Fx?=
 =?utf-8?B?WC9mZTBCaXFsVUs2L0wraEFhRjd1dmhWWjREMnBXaGVQNERMZ2JkQnR5Q3Rn?=
 =?utf-8?B?SHFNVFNUaTlGYVNza1EwdEFXbkh6c1UrbFlsNWZXNWQ0aGNSZ0ZSUkpOWG1u?=
 =?utf-8?B?YUhpR2RqTFVpMmVMTGtHNFlLMkJ5ZnNndDU4NlhCamEzYTlIeFJaMEgvMThT?=
 =?utf-8?B?OEl0Y2x2S25UWWhucHFHandSeUN4cndIclZKL01aREs1MlJ0Tk5lR0xsQTJP?=
 =?utf-8?B?ajNsaVNnTldQT3NYclRybmJ1ZHk5YVkvMUtZd0RtWi9YbWNXdk1uaXF4Znkr?=
 =?utf-8?B?YjhSMmxoLzRiUUFjVXJzaWsyRm5qMTUzMFdMa2lTTEd2ZWV3RVA2UzhLU3FW?=
 =?utf-8?B?WHNCMnU3NlpZK003RDlKU0R1aTJrbE1sTjhobjhiTjVOQ0tVbXJqN0R4MmtZ?=
 =?utf-8?B?VVg2cWIwS2dTNXpUSlJ2NnFwNVdwbEJrTFJST1hYYzlDYTU4MkgrMmNBR1NJ?=
 =?utf-8?B?MW1xVHVqQmZpcm8rOTQrR2cvSUdNdEx2ZGtVMkhkcnBIMXhQOGZzWWNqYUJM?=
 =?utf-8?B?M29TR3pERmRacVV0MWkyOTBFb2pGK1k5MlR5Y3hBbkxwR3F4cGlrOHgzczNQ?=
 =?utf-8?B?aG01NkdzbVpBU3lsYUVhQzRmU2xNckZoOFlMazhqOFFRNTE0RjRRSERndHpH?=
 =?utf-8?B?ZU9DVXM2WTFhbkNOVHhCSGhMT0J1R3dUVExMcW5jd3djakUySi9BK0NVYWZy?=
 =?utf-8?B?cjlGZWlQRktVSmFVeUdoa1JCR2Y5NzIxbFFhbGVlNmYxajNaQjFpenlFSXFP?=
 =?utf-8?B?YkI1MFZBb2REb3pVVWV3SmlWNDZJMm5NdThxNHFlVFJlbVZXRXZvem1NYnhW?=
 =?utf-8?B?Um15YXFVM014R3NTMm1rWkVCNmFVNHpVNUVJdGxPYXdpRkYzVU5TNVFxcFpo?=
 =?utf-8?B?eWtmV29TQ1RGN244MzRUWHRXeUJIWnhyQ09ZVEZUSlVDTERURHY2ZWpKV1ZR?=
 =?utf-8?B?T0MyWjlNTUJqSGNzSjdmcUFuSVl4L1FtQjA3TjdhZ2s0MVNuV2RrblhJT3VZ?=
 =?utf-8?B?bDhPZ3g4a241SlhsL1g5eXZ6Z3EvMis5VUplTWNpVWJ5TlZRWldWQldGSmJz?=
 =?utf-8?B?UjRQS3dSNnJ5VUlFMlZRRXhjNWNsQjhZT09NK3BUZk5HRG9XWStLNnl0ZFVx?=
 =?utf-8?B?UEQ4bEorY2p4aXlQNDFtblRTR0RhM1VMQkRQZG9KajQ1VWcxQ1JidGs4Uk1h?=
 =?utf-8?B?K2FSNThUY3lRMDQ5Ti9KeEt1cWNvYWYya2tLenhrT0c4M0Q3aWhHR1c1MUtR?=
 =?utf-8?B?TFJRQW41MFRWSEZGUXNBelFBODZpNCtmQVlSek9UT21uVWhydko4Yk1YZkR4?=
 =?utf-8?B?Rm1mY3YyS0hLQnBhL2FQRmRQcUwrSFdSd0dLMXBnOG9SMFc3UEEyL050dmlv?=
 =?utf-8?B?dm9JM0lqR25vbGcxM1J3bURCMnpZOEk4eG5FNE9QbkR5OVljZmUwNlpqOEVM?=
 =?utf-8?B?OForbmdLS1o2TTR5MWgxOW5NRjEzNFlUVHRYeFlBZElPU3B1cjM0NFdjQURp?=
 =?utf-8?B?enl6ZytnVGJnWENjRFJsUDVTVnBNajFqSmRLNFE1bDdzOWIvdFZodDJYYy8x?=
 =?utf-8?B?NTUyWDY3Q2FQWm1SZmg2dWY2UHlTTXJoNVI3aWVwYkNsN2JqeXBucCtjVklp?=
 =?utf-8?B?MlB3VktMNy9FUXlwazBaaHNEVmtVVk9yeUhWZzBmYzBsM0ZRNzlvVGtlVlpW?=
 =?utf-8?B?a210ZnlDaWg4YTlBWXFBVW1jazV1YS8yRHl2Qk1seW1PUllDUjVIdWszWTZG?=
 =?utf-8?B?Z1Flak1IbkdVMWdGOU9ENmthdzh3UHd5RnhXVVkzV3dxcUI1b0JqWisvd1hD?=
 =?utf-8?B?WEMyUEVkQ3hxdlpabWxwOElaTFZJdlJnUTNsTXVBdTZWQTd5WllqQThYWS9v?=
 =?utf-8?B?Z0Vvd2gyZC9BVFJ6K3BhWjg3QTVaeUlQeGg2anJ3dnJrT2NVQWZlSkg1eHZJ?=
 =?utf-8?B?REM1dW9KYklZT0gxbXFhSGJmYWFXZUc2RWZXbjJkc2R1WThwZ3BZL3ZrdTYv?=
 =?utf-8?B?MGhDVnR1R29tWFZleHR4WDZ6KzMyS29XNVQ5L2NHaTNPZFI4VkR1dGE3OXlM?=
 =?utf-8?Q?Ul2VgLZNbDf6sNxcbduli+19CUxTS/Ob+w4IDsfD5NpWW?=
X-MS-Exchange-AntiSpam-MessageData-1: vi7gSFYa+LKHgQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb88345-9bf4-4ced-a4d5-08de9f7ef36b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 08:21:13.2678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sGoWY22TFDdMhRcRAQ9GFD5UagZKL3CrB7bAXEt2iCLmP6NYc59pMB5uWOCdrExG/sbzOeboI6FOYH9X9HziTg==
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

Push the computation of the falcon data offset into a helper function.
The subtraction to create the offset should be checked, and by doing
this the check can be folded into the existing check in
`falcon_data_ptr`.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 48 +++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 01f65d50cbb3..0c0e0402e715 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -765,33 +765,29 @@ fn get_bit_token(&self, token_id: u8) -> Result<BitToken> {
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
 
@@ -908,15 +904,9 @@ fn setup_falcon_data(
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
2.53.0

