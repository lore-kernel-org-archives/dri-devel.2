Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0265CD5BC9
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 13:59:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37CD610E38C;
	Mon, 25 May 2026 13:59:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="VetinHlQ";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010060.outbound.protection.outlook.com [52.101.201.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3D9510E391
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:59:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3BOlfBLUPk6xSPmivN3SlaMKGcZ9Lji6KEloHREI4QC6tbjgHFJ/hCI+AbBu8AgqNl06+Pc6DkHcNxq1Q4NWQNZrgZ9vWqArezxCWVZgYTQf5MBS5DtogS6co4TABTYcnyz1hVsIjQ3BoeIdOLOsxj+b6gNfkz3/v90uNr8tVibMUhBEmiCcy7Pll+UI6CCLZrXXVSYFNxM/O+IBGyZLJRucz6mbPe/dSZGEQHGxbWyiyoVyGI39Jp6CZiWkFfTDyEdSEv0o05PncDIpHRxNQUG8fRxAFqNS6dLBrMbEwgvJ73bsBQCJlS28E5Ns0pLpLYzmzIY3a454OtTDMe6gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phryEJSMrpag6W1sICkYBfVPmwIqFPylhh1v8/Xcn3Q=;
 b=m60DO2qeh+4qv/866WxUQfvYdSMfb4gcAZnnL9pY2esvbx6l5O34aEhFHnOkGPDQZxk0xQm2VCQYApb6K1elNxtZX0AO8Yigov7sTxvvrTBOEtfspeVgNwPIAbip1zg59AST6CdJxa26VFy1Fi7kN/Z9hPFU/93m1l8m47/vKNiD4xEjoGrMZSdq7jvcHVDSDZvpwavdZWXCRyVDijbqO9voVTBNTzhk8VnNShhuDJXTYszdxoYmrTHUObh10dhjRWTa5jaaEjxcDJTrBULtZ34M2FuIj9byfbNZl6VL9fQlS3r4xkd6N0buC3pIDkzfJ0xpAj8o563cHAHmU2D5gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phryEJSMrpag6W1sICkYBfVPmwIqFPylhh1v8/Xcn3Q=;
 b=VetinHlQ+QXHHJtG4gmJ24Aupj1JWrA0cj+dTsQPBHH6isTFzV9Gzc64YClrQL3ldb5CtLL1ea6Q75og8u7Hnf9XzCMgWhLxmi+3qrG8CvTHgENUustKq+x5pjd0PJqKDL0S1pGe77vC8AyfoVF81RsGvDBj1WIGZY8mVDuVjT2aIiltaLxMmvcrVVHdLBQDw8FxzVswq/LnLd83rEjl+fl7Ge/r7BxQZLvljlcqscqQBOe+edU0DL8qh0WG3M/+j8EOtydIVUajJpAbKDu0u0iSPe0otGc8TufYSOm6xh2zwDv1652+mm/XZTvQoGSfYYJ6pBlT9kKGRh4zwnSuFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 13:59:01 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 13:59:01 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 25 May 2026 22:57:36 +0900
Subject: [PATCH v5 18/22] gpu: nova-core: vbios: remove unnecessary fields
 in PciRomHeader
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-fix-vbios-v5-18-e5e455251537@nvidia.com>
References: <20260525-fix-vbios-v5-0-e5e455251537@nvidia.com>
In-Reply-To: <20260525-fix-vbios-v5-0-e5e455251537@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYXPR01CA0044.jpnprd01.prod.outlook.com
 (2603:1096:403:a::14) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA1PR12MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c6b6e18-88da-4591-5090-08deba65c5f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|18002099003|56012099003|22082099003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: nPz84Mk9ObOVqMz7cfYec9jx98vouBrUt1mlGCtOK5F9tfQCgA+Fy69QEc7zW72XzPGaudPaoOw9I4c2Ax9ltIKGS4cOpjtnx5+9//ij7+hW1nasVbieAbRyRyKeOrXB7jdPrAW4cGF+/VySqcT1RqixIXRJxlIU/3IOOxYNe8cFrfKANSArxZEutzxnQrL4HUnz4EPN9jAULeLImpbb/g7GcGljMZjXRsIPREk0Dadz5gZ0IB0bxk+rI7vpFScVoSZ7pCLxTaaQiTMIU5SLagvxEXhx/XAga/thORUXQWRrRAu6jPfwh5ywJfVjmJfFpirgl5ZWNnVr/fXEZojisWu5VmbT2UXs0o/ucFQHV9jnWskzeUSTzPsxhYX6HVf2ZPBv4g3Pa4O6gikQ68TebOyDUFqfQKKYY+iFbaJXFHxDEmKYVLQ7NSd0yBM8SKK/4A3jaIRjdsf7zhSmjvCC7WpfWMHvDRIFjwkB06R67XA+43cBkTvyW/FqFB6SjbSz1SdAipw2JRBdiaDw5ctRnMR83n/qB+7f1LFBXfPc6WUcvjYIRBiVPU6+l8ZV2aEB1sWIlRv4odp1zwHqY16Z8sqDpLyPJjbCUOqurWq9BpvNK8Do82SEq7Dyx8fwHqfiGq8OHSV5NsIYXHUPOof4qHFNXX0BtfM08CxvaRjKGyiR2QPbOwmgSLODW9hkszrM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(18002099003)(56012099003)(22082099003)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlFaMnRzdEpqTmpWeVFCN1hxQXYxSHIvU3JBUExlMkthb2xDYnIvcVR1TVlX?=
 =?utf-8?B?ditWdWIwUkFlOCttN2VTaXgvK1VoTXMwRjZ3WEgwaGdJU3VkajN0ZkJCcHVJ?=
 =?utf-8?B?b3FqbW9Qc0tVRnZhd0lPM0VkekNlVkZrRzlEVkdINkhieEJIU0dSa2hJTmwv?=
 =?utf-8?B?Y0loSkFoUnNvVW9DdVRhMmRPUHJKaXlpb1B2UGI5Q1MwcEVqdjlVVXNnQTZu?=
 =?utf-8?B?ZEo5LzBGcElHb0VnL090MGVoQWdsTGsxdjA0NEg3blBheCtSMjJMcjZZOGNv?=
 =?utf-8?B?cnJpZmdMQWVORWFwVzdjclV4VHUwTFVjbGhScmtYbTQrUUhqNDladzlya2N2?=
 =?utf-8?B?RWJSK0lMSmp6TU5WekgxbVpqc2xNQUNCQlhLUWRUaHdCc21LVXdnUThURFVD?=
 =?utf-8?B?NVJvNzhxZmZBOUVpYTZKQkJMYjVpRnZSUEJNWGo2YlY0RnpZTDMwWVVndCtN?=
 =?utf-8?B?R3dlUjhFMUs1b3FpaURKdE83eGRYSGg4WmFFQkVSbERxOEpTcEZBNTR5V0Zw?=
 =?utf-8?B?SUhhM1B2dkhDWk53NURyeklaNm1IendFeTFjMDJIYUZrVkhsU3Z0M21ONHh3?=
 =?utf-8?B?RElKTTFvYW5oZlVlNDFkc09MK3RZRGw4c2dJSTdGVGU2WDJrUE9HU3pqNVIv?=
 =?utf-8?B?NEhTRGhFSWh6OXV3blNNOFFzVU53N0VZNTZuZENCTmlaSldVODhtdW9NNlNp?=
 =?utf-8?B?YVljamtMakZiU2p2WitEaWRvODVESUVacWFydS9pV0JHMWlSc3cza3BxRkYy?=
 =?utf-8?B?b2xzUVUzNHB6NjNFaEhvazRHaDZwQnNjYzNKNHNHTHBvUjAwN2lkVC9paHZP?=
 =?utf-8?B?WGJTbC9kcklZWTc4WDdCM1lqOVdCY0lkWGR5V3NJcjZ1VWk3TE1PSUdHVTFq?=
 =?utf-8?B?V2JGai83K2ovemdmdXAzLzZQTlk5bWJ5eTRldTRMNE9XaFAzTDRqQm1Wcngw?=
 =?utf-8?B?TFordkYrNVdVUVFxcllQLzUrcUZqSmVwRXQ4d3RtTmllWjlxUTBzd0d2V1lH?=
 =?utf-8?B?dW4xTEhkdUZxMjlncVhXNnhHYzBSdjBaUnNETk5kZ01OUSsycmRPZDVlSGFQ?=
 =?utf-8?B?QTErcnA1K095OE1KalJhbVk1TTBSZ3l4dHluV0JEdVNjUS9tM2tVOEt4d2Nk?=
 =?utf-8?B?L2JXOGl0bENLVlNOQVVwVE4wVkc3ZldoSDRLYjNvZzNsUHUybzBTTUtHak4w?=
 =?utf-8?B?a1FXYjFneGRnTkgwenRBOHRJQ21semlZQkdjMHVzTXdpUzdwWEFVT2tKOWQr?=
 =?utf-8?B?OFpCWm5Ybk5KZUc1aEZzUW0vSGd3RW9PZHVrY3RLTHZWTXZ0eHpsTW9hZjJr?=
 =?utf-8?B?VDZrMUJIc3lBOUVpZXRjc3B6VE5aTHJNMS9iMGNPbUV3UnJ3TFhkWXpzalpN?=
 =?utf-8?B?cWhsV2Q5WWNVWmFYaWZxZ3hiSkxYWERkSkVFNHVZbktya3JxSktiOUk3N0RV?=
 =?utf-8?B?cWJVNDZFQlRqVG0yTytJSXozdW50OTRwN3I0ajEvanhJRkI1SVNjb2xjQ216?=
 =?utf-8?B?TFp5czVENGkxV1lQS3MvMEpUVDQrdHJuaE1QdHJxK3FleDBHaTYwK3I1UDFq?=
 =?utf-8?B?TUk3M29USXc1UVpyYU5STzZKT1pzYkY4cG5hc1VORGVaNmdMNU15RjBQamE5?=
 =?utf-8?B?T3hMcEo5NHlLRElFUFE0VXpFWUVIMTA3eEwyREdDL2RsWXVGTmFHMGhrQnhm?=
 =?utf-8?B?a20wM2ErczQrZE5sWG9NZHdtcmZMbXV0Z0hQb3Y0aDlYUjNBc1c2cjcxYm9z?=
 =?utf-8?B?MDBDaWt5K043dnZuOW9tcElxKzRmWHMvdjRORnlKcWM3M1dJYXpXUS8rWVRQ?=
 =?utf-8?B?RTZSQXZWWnVjYzN6bng1dWFpODZ5QkZ1UG5BeDdqREtFdjdHSDNCRE83RWxM?=
 =?utf-8?B?cnlDYW5YU1R5cE0xYk9yRzRHd3BBOUpKTkRuRStnWUFraVhwUFg2amE3bHZo?=
 =?utf-8?B?L0Zoa3BTQWw5ZUtWR0tJTEtxT3ZET1FSKzlDdGdhVjloc3dkRU56Ui9IWk5L?=
 =?utf-8?B?MGJ6WU9CM1Vvb0lENS9nbkkrL1ZVR2Ryd2s5cTltR25mbnBTUmNRNE1UUjh2?=
 =?utf-8?B?SkQyUkpDWUErUXVLK1BkVGZVUlUxS1cvNW1lWUJzNG5pUVFuenB4SjZjWC9h?=
 =?utf-8?B?bmwyOEV4K1dTMnlCaXlraitVYWl4bHQybDFqRzlpZzJ2RVl5aUg4WWJ1aDBi?=
 =?utf-8?B?WCtUVU9Ldjh5VEM0ajA3QUtoRktrRTd1TzJnT3phYldHMlYzRUJZOGlFQzRT?=
 =?utf-8?B?ZlZ0cjg4Zk5UL2xtdEExZ2hsRjMwcVdNbk00WXlXa0p2TWk2akU5MnZLRzJD?=
 =?utf-8?B?K0tveHBIOHlwazlEendPc05qbm92Tm1SRVNHSXFDMm5zTkRueG9uTFczdElH?=
 =?utf-8?Q?9DGqNX3pNB1JF2Q15k/habaOdmqCVz1WzLxN486sO8Eam?=
X-MS-Exchange-AntiSpam-MessageData-1: KgHa9sBs1NraHg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6b6e18-88da-4591-5090-08deba65c5f6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:59:00.9871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+IiUspVJBlmZrn46+SBNYSy5XMm1ejoIlGUn7HfDZ8qYG3pFivTEhgPlGqFTNIHlH1F+rNEwAu9wK8kylV3MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6628
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

Remove unnecessary fields in PciRomHeader. This allows a simplification
to use `FromBytes` instead of reading fields piecemeal. A lot of these
checks were redundant as well since it checks the size of the `data`
first in `BiosImage`.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 68 ++++++++++--------------------------------
 1 file changed, 16 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 52e33fdd4f5d..7399f2d087a9 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -533,67 +533,38 @@ fn from_id(image: &PciAtBiosImage, token_id: u8) -> Result<Self> {
 
 /// PCI ROM Expansion Header as defined in PCI Firmware Specification.
 ///
-/// This is header is at the beginning of every image in the set of images in the ROM. It contains
-/// a pointer to the PCI Data Structure which describes the image. For "NBSI" images (NoteBook
-/// System Information), the ROM header deviates from the standard and contains an offset to the
-/// NBSI image however we do not yet parse that in this module and keep it for future reference.
+/// This header is at the beginning of every image in the set of images in the ROM. It contains a
+/// pointer to the PCI Data Structure which describes the image.
 #[derive(Debug, Clone, Copy)]
-#[expect(dead_code)]
+#[repr(C)]
 struct PciRomHeader {
     /// 00h: Signature (0xAA55)
     signature: u16,
-    /// 02h: Reserved bytes for processor architecture unique data (20 bytes)
-    reserved: [u8; 20],
-    /// 16h: NBSI Data Offset (NBSI-specific, offset from header to NBSI image)
-    nbsi_data_offset: Option<u16>,
+    /// 02h: Reserved bytes for processor architecture unique data (22 bytes)
+    reserved: [u8; 22],
     /// 18h: Pointer to PCI Data Structure (offset from start of ROM image)
     pci_data_struct_offset: u16,
-    /// 1Ah: Size of block (this is NBSI-specific)
-    size_of_block: Option<u32>,
 }
 
+// SAFETY: all bit patterns are valid for `PciRomHeader`.
+unsafe impl FromBytes for PciRomHeader {}
+
 impl PciRomHeader {
     fn new(dev: &device::Device, data: &[u8]) -> Result<Self> {
-        if data.len() < 26 {
-            // Need at least 26 bytes to read pciDataStrucPtr and sizeOfBlock.
-            return Err(EINVAL);
-        }
-
-        let signature = u16::from_le_bytes([data[0], data[1]]);
+        let (rom_header, _) = PciRomHeader::from_bytes_copy_prefix(data)
+            .ok_or(EINVAL)
+            .inspect_err(|_| dev_err!(dev, "Not enough data for ROM header\n"))?;
 
         // Check for valid ROM signatures.
-        match signature {
+        match rom_header.signature {
             0xAA55 | 0x4E56 => {}
             _ => {
-                dev_err!(dev, "ROM signature unknown {:#x}\n", signature);
+                dev_err!(dev, "ROM signature unknown {:#x}\n", rom_header.signature);
                 return Err(EINVAL);
             }
         }
 
-        // Read the pointer to the PCI Data Structure at offset 0x18.
-        let pci_data_struct_ptr = u16::from_le_bytes([data[24], data[25]]);
-
-        // Try to read optional fields if enough data.
-        let mut size_of_block = None;
-        let mut nbsi_data_offset = None;
-
-        if data.len() >= 30 {
-            // Read size_of_block at offset 0x1A.
-            size_of_block = Some(u32::from_le_bytes([data[26], data[27], data[28], data[29]]));
-        }
-
-        // For NBSI images, try to read the nbsiDataOffset at offset 0x16.
-        if data.len() >= 24 {
-            nbsi_data_offset = Some(u16::from_le_bytes([data[22], data[23]]));
-        }
-
-        Ok(PciRomHeader {
-            signature,
-            reserved: [0u8; 20],
-            pci_data_struct_offset: pci_data_struct_ptr,
-            size_of_block,
-            nbsi_data_offset,
-        })
+        Ok(rom_header)
     }
 }
 
@@ -712,9 +683,9 @@ pub(crate) struct FwSecBiosImage {
 /// BIOS Image structure containing various headers and reference fields to all BIOS images.
 ///
 /// A BiosImage struct is embedded into all image types and implements common operations.
-#[expect(dead_code)]
 struct BiosImage {
     /// PCI ROM Expansion Header
+    #[expect(dead_code)]
     rom_header: PciRomHeader,
     /// PCI Data Structure
     pcir: PcirStruct,
@@ -759,15 +730,8 @@ fn is_last(&self) -> bool {
 
     /// Creates a new BiosImage from raw byte data.
     fn new(dev: &device::Device, data: &[u8]) -> Result<Self> {
-        // Ensure we have enough data for the ROM header.
-        if data.len() < 26 {
-            dev_err!(dev, "Not enough data for ROM header\n");
-            return Err(EINVAL);
-        }
-
         // Parse the ROM header.
-        let rom_header = PciRomHeader::new(dev, &data[0..26])
-            .inspect_err(|e| dev_err!(dev, "Failed to create PciRomHeader: {:?}\n", e))?;
+        let rom_header = PciRomHeader::new(dev, data)?;
 
         // Get the PCI Data Structure using the pointer from the ROM header.
         let pcir_offset = usize::from(rom_header.pci_data_struct_offset);

-- 
2.54.0

