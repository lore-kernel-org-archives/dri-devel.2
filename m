Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815FCCD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 02:57:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9EF810EA2D;
	Tue, 19 May 2026 02:57:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="p0eXPQZ2";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013029.outbound.protection.outlook.com
 [40.93.201.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 188A010EA2D
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 02:57:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fwTKCu8pS9af4PNkF3CJxvtRMVAflNmu5UkGOEG8Ajuov6ASB+fCN1XUfdeUoTC4xItX9OqS5QOvTFnyqcC+PQGIhXBe2TqFbEQ4VBl9Jj++SOEgD2nuPXPLmjlyfP/Gd7olH/ZsyTVSac2QQgkD81VMVTIcrgW9SaTfN8TeyOfjWSkC94ujPMoYiDKYu+C9dXsY+wFsYRA1D4ioZzKa0EfcA7Pl/Xxh0kz9lgJmgsJlzXpsnt2f4YAydHWL8chi/i2WYV9Qq5xRIn72OCAl7jUw5xU4V6augdUxSKMBI/Y8YOUyY+9gMTzskj/J0/CSW55C9zcfyZxMy/AjoRAu4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7dYxb0UEbI3yON16hYNzAuiaHJLh/M9Yf/zfLtTTCE0=;
 b=PP4YPblb3WUq8qUhvfPOYGYc/cYTXNeCCyGONiQ7JUdiI82qRzjAAMHNRwFR8ujDHWeHc4HrN6vq/MwYgBdznbUOmmCtA2TEVpDL1J3CobzcJv5HFWQO58h7D1i+mbu/Mi6N7iEGqr6U9pfz4vMqy7ydR78PGu7lX1/eWGHQ6tJk2xbXEBKQcAfTLAlIKc7dOgoKlHoLYybw65Lja2dbcPklQZ4b7sTpTv+1RwM/VGTxgKRMlo4zsh1eiKLj4STZc9ULlIMRshohjtStL4WqZ75WfJBBDbCodkUMy3srqajkZyFc19Mn+C5+V3i+vvwDWatYU8TxX2pT9qit1T8GUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7dYxb0UEbI3yON16hYNzAuiaHJLh/M9Yf/zfLtTTCE0=;
 b=p0eXPQZ2jZzbt14tectZv9TZRNrfDArNpYVRigKodPT4myqWrM1vGZaCUE81ci1pp0NaSy+Iwyy63QDgRA65FZpP/qhzqIuxA1iejojLlkEuTqTCHxFD4sKykQ7HVLGhdmwfzBqLPz4mQgDIR79Jis03r9Y9S0vGmKb3BqB7MW7NqOnQUFl795Q70xmSZn7vh9NSTzdjltenA5Mg0VCiXtOA0SgzTO5shNWLBVN5M5PeRzfRRcYLdJ+5rkaKdMLX1aE7/8KY7shhiVl5OwmEGVWRPXjMyWc9scnPvTE4a/kvoAg60fz0rKvdRe0GJdjL0dmGhPLUadUXRBUv3Thwtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 02:56:56 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 02:56:56 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 19 May 2026 11:55:11 +0900
Subject: [PATCH v4 17/20] gpu: nova-core: vbios: remove unnecessary fields
 in PciRomHeader
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-fix-vbios-v4-17-5d3f210c5602@nvidia.com>
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
X-ClientProxiedBy: TY4P301CA0041.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::15) To SN1PR12MB2368.namprd12.prod.outlook.com
 (2603:10b6:802:32::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: 078d7406-0ad5-4336-f2a1-08deb552499c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: YOPw4/otvtnnHJMzB24V5Tx40xtGPI895sygyA0oF3Oh/tSb96QQ9hGBb3JfePuC5fLWqs7e1ntYRfwzrjdDxXEYvnFCXuPrxSea0zHh5kVNjqv00zNjG08yhKIkwvjeYzgW6tudY/u3HflEXHaaTqWrOkZV1er9YbU2g6Nn+GR2uEKLlD53qPV/Iye2jL/VBEg41yX63tlD/Y4cBwllCziBz2a5aozyd4MM3F2GIg5BGp1ryEixbgeUgqJdrYA84F0RlthJApfc9OtKlDEtSzRgsUwDoUBYJeEHTTFqLuX/3DkZb8yRvS3HOop7BzIRML1hleQvYBQrHrRHD4wJVoZrHj8O6prtDj/xdcgWCgyhM0rzao4xHHmaVKxLUP27I+RtNVnGsZZUMYDHo1QNFQjBjk+FdkSH/I6bPfknKhHzgigVd/UJ5Rzoh//5ncnNJPF3K0tyoyNQvgrgqOSocS0W1xVyYGwqIr+5LdJ/SP1Edf/X4fZU/VFPpWUoSrfjPxHro4qPFKiIFWvhmzfClry/U3e/Uk6j7ImCUjDfPi2mpkVqgsDkFy1Los+b3s+kICCsnE48m7XXh6RhiqXG4K2pOHAvmHfTASl1iKo5EWzau2wnngCXdz7JRIcooiLSh5UAY3xsALLFxRGJv3FKiy874FX4aNQ+YyBHUDWjbXI8BXghIBwEbAPVvKEZI0qw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnJvY2pSYTBqM0lDSDJqdWc0azVNK0FFMk5rbm5OZDViVmxSTGJ5b1hHeWE2?=
 =?utf-8?B?WG43YStMQUZTV293L0diTGM1QTB5emVKanVNbGNkaUtEM0pIM041QjE3QTI5?=
 =?utf-8?B?aWlZMGczckJYK3BCUDRFc2k3bkZJWERYZHU2elFwdWJNTkdwaVdvMDFRY3Z3?=
 =?utf-8?B?dG5Xb3VhVkFMQks3ZzVZOStLL2tLczNEK0ZhbDJOaTlsTDJxUVJVVWhJUDcw?=
 =?utf-8?B?Z1FGSC80MXVGR0grRlAyRDBEbE5LRUl2ZVh6Q3lxTWNJVHZ5VjFUWmFNQW1p?=
 =?utf-8?B?NVdULzNwMityQzdyZGpxWHFqUk5sZ3hFTFZTNFU0UDFWL25sNG9Zb0J6WGFJ?=
 =?utf-8?B?L3JiWGtDS051S2lsWkFDVzlmNUtNYndYaFRSa0ZocnNvUTQ4d1VkbllPaVN6?=
 =?utf-8?B?UXk4NnNFZlA1WjdpTCtyYzRLR1BwcWJ2bWtYVExTdXkrK0toZjBqdDdwcDc4?=
 =?utf-8?B?VkNkZ1QxbjFkRm1IdFVYQW5hWGh0ZnpmVFdNREZPdFAwbXVvREhQNkFRcWFx?=
 =?utf-8?B?NHFJRzhnc0dLc2tWRnJOem54OVRGMzQ1NTNGM3FFUDFFQWJ4UzZ5TU9DZFhE?=
 =?utf-8?B?VmxIVjVqSHU4WHFzN3ZxYXZ4NEZNb0NveVRxN0R1bjJQaC9yd1dxZG1QNlBo?=
 =?utf-8?B?Tk9GeVE4c1gyQndOUkZHczVaSjFYNTBpU2hsVDlsT1ZqZ3UyYS9Zc01oMUty?=
 =?utf-8?B?d2tsMlVTclpZUGV6WldJcHUzWndLSHBxaDNZYzFDa244ZXBvdXhocDBxTW4z?=
 =?utf-8?B?eUFOd3VDenRsamtvU1BObW03bkhaeE9WbEJWakIvd2g4bzgwUmMxcVdleVpG?=
 =?utf-8?B?V05yenpkSTc3cjAvNmpvOXpoS2lTLzY1VHZNbUZScTJEenV3eFBLTnZ3K2RN?=
 =?utf-8?B?SDZoS3JoUWV6WHVpd2IyckQ3YUFEbUxMTVpJeUJiZmRCZXlZaGhGVXZIdGc2?=
 =?utf-8?B?UUk2bE5OTE5maFg1VnU0Ylh0TnpSWHQ0S3RYcXRsYit2Y2xvdVpCTzI2RitZ?=
 =?utf-8?B?bWZkVDh3Zzlza2pPLzlWbjFPWVllUUhuU1RPQ3dhUnVLblQ4b25UemFHeFMv?=
 =?utf-8?B?YW5XTzRuRWY5UXFIUUVpU3h0Y2VhVEFYLzRWRUlLKzhsRVhPbHdiYWhJMmJM?=
 =?utf-8?B?cExnMHZkSS9NUkYrQVhOM2h6VldlUVVOZGNqZ2VZQmFyR3kvaDJURjFUTnNp?=
 =?utf-8?B?Rjd4eCtQZjhQNE1PVkwxSkEzZVp1bjE5cDB1N1Jsb094MnlBT1NRWERKV0Rt?=
 =?utf-8?B?UGcveTFvVVNBdnEzS2lvbk84ZlhQMENGZCtPa084a2tKMFh3d29vSzloMUdW?=
 =?utf-8?B?aEd4bGdsYk9saFdjS0tLNVZMYndSaDFyMGdxK3Y1dXpjYnJrVmZzNGRGVEI1?=
 =?utf-8?B?MmVMVFgvbFl0N09sa3FaUXk0cWxtV1UrY25HYTBtclhVYTFxTnplR0NBSFhS?=
 =?utf-8?B?eW04NkREZHk1N0x6REZzSHF2UW8xU2U4T3lHRTRxRTQzcFc2V1FFUzB5Mjhv?=
 =?utf-8?B?U3Mxdmo2VE9rSDVvY0U3eXozam9CNTFCOE44TmFvNmNTdDNUSElOb09HOWFX?=
 =?utf-8?B?SVZEbFl4Ui95anNiUWZOaFUzM2JvZ29FQmlZajBwc2dLZEVLMUtFbktKMTJD?=
 =?utf-8?B?UTRUY1o4Q2IzUysvYW8yT2pNd0tjeldHMmtuWUFpenhWdnhQWXVWbmpLUUJL?=
 =?utf-8?B?dGFoZVFGdVhXOXhHdVBNUWxOeExzUWk1ZXh5TjdCTlhtZkhET3RrdDVFVjNk?=
 =?utf-8?B?ckRWcGhRU3lacjVhZG5SYWRjVVAzcCt6Q1hBek5aMW82cWNNTlhBU3Vacklq?=
 =?utf-8?B?MTJuUVFreW9LN2l6eWpUUHNVK3V5RldJRTlxeG1LbnczQWdKdjFCY1RlUDN6?=
 =?utf-8?B?dzdqOVBvWVZuTEF0cDdJcFc3RXFxcUh2RkV1c21BYW5GTUhSZlRUUFdyd1ZX?=
 =?utf-8?B?ekJZMGJSSkZNNGpLYzBuQVR6N1dPUUZ1MjJDS0gwOXRQdDJrSjVDdzdQWExL?=
 =?utf-8?B?bzIwMTAvUng1L2FOa2VPaWRjdWN5V1JVQzlHQ1M5R3BNY0lWN1pMY1g4emVj?=
 =?utf-8?B?K1ZxM0tXNlhvNkEyUFB0d2laK1hQUENWelRKMmlHN1B6UVhMb3lCYVdVM0hT?=
 =?utf-8?B?SExEbVpSNjVUNmkzU2Z5aUZoQk4ybE4va0JTU1FSSFdMOTc4OHUvU0NBaWNz?=
 =?utf-8?B?NWdtYTZ2NUF4L2wrSnNjRzNYTUJkMmdROW5rN0dyRklKMlc5OGR2OHYzRmp0?=
 =?utf-8?B?VHdEWDNlR3RFaGlGMHQzdjVtVUNyNWYzaVNUYnU5YnhQR2IrMEFsSi9PdzZl?=
 =?utf-8?B?TkRHdGVPNU5rQi9NNXJnZzJKR0RWNXZpKzhMZC9sdDFicXllR1QzcHRaTlE4?=
 =?utf-8?Q?SgWWWolF+qt/mXeAhC4esp9rjsRIHLpVTY1ScT3+/Qa/H?=
X-MS-Exchange-AntiSpam-MessageData-1: 1NU0TXx84O62bQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 078d7406-0ad5-4336-f2a1-08deb552499c
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 02:56:56.4794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QoXufXF0ZSARogEaHlZ/qsEwBjqvdbJCQhhJ/V6q30EI1T22KBXN36KfpGf1ijHiFdJ8jGq6kI0L848FQyhR/A==
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

Remove unnecessary fields in PciRomHeader. This allows a simplification
to use `FromBytes` instead of reading fields piecemeal. A lot of these
checks were redundant as well since it checks the size of the `data`
first in `BiosImage`.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 68 ++++++++++--------------------------------
 1 file changed, 16 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 64d100b6699b..1dca7933fac5 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -546,67 +546,38 @@ fn from_id(image: &PciAtBiosImage, token_id: u8) -> Result<Self> {
 
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
 
@@ -722,11 +693,11 @@ pub(crate) struct FwSecBiosImage {
 /// BIOS Image structure containing various headers and reference fields to all BIOS images.
 ///
 /// A BiosImage struct is embedded into all image types and implements common operations.
-#[expect(dead_code)]
 struct BiosImage {
     /// Used for logging.
     dev: ARef<device::Device>,
     /// PCI ROM Expansion Header
+    #[expect(dead_code)]
     rom_header: PciRomHeader,
     /// PCI Data Structure
     pcir: PcirStruct,
@@ -771,15 +742,8 @@ fn is_last(&self) -> bool {
 
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

