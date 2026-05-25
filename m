Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3127ECD5BB1
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 13:58:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97E1E10E34B;
	Mon, 25 May 2026 13:57:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="spIP3Zw5";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011007.outbound.protection.outlook.com [52.101.52.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7D2F10E34B
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:57:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c1KmE3/G5Cn49SEG83x03NePG/iBbs0Sf2BQ+ZpZymmyVVftqaOjU9SLNgzDacC85rmHKnLspO6n0qLZsl3E8XyDYeLu06Q5W6rly8O1cAXxVupn9QEmUlnxwCaYzVASCujE3mxcOKZ+7LPbXGOPdSH2IO7Ga2pg1Wy+AqtwkQEwKoSNT8ciu4IigOWhgwoVCZ6/tnfOM2K1p6uAshxIgMLtmw91kGp9bAqfLEbSLJPGgGIo8yWwpUsqHbXnoSgQ1k1f2VrfajZGpPBSzgS6+wWVtoEaBSgvtfeMHg6JuI/O0UO2I+MKHgFYG5T6scDedzv6KLTPUj9icYm6w6ziRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ea7eWB7X6/oc2QMhS3OfgJSffzEUy83po5ak8yzb88=;
 b=PDhIW/5CAU5n2AkYzXu50vF6W2kMn+a7piPsQxXSX3XMuKPqRbCJJJMu6esDf7n3jkxaafw3xYuK09RGGhsfDf+QfmA17PXAcvwQVfBZ6L1DpLMlN6si3S+F73Z2YnDiLLRw3QcRCRT0UF2XSyyp6JRnkftK7SvhhX4tLxUPK+Oip3UEZnYViZzQiAUifNlRf+fj1OUxEis1uHjLuqneUW4uFyRdvZo8ZmkWAoN5Jj0OBdsiLe2FNfW5n8BXfemIRvtLVsojG+m2Bexwy/trPU+LBgqMCfs1PDIfrWf36chKp/kSGvYZtu1pifma0fad6DmVSd67B1ooZ+tD0xT1ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ea7eWB7X6/oc2QMhS3OfgJSffzEUy83po5ak8yzb88=;
 b=spIP3Zw52ddPPs9MnmtbwoGifVjapnJPMdBJfHaunR5d0wB2i/fqZG7Bzxi/wRjpIl0waVoZ/X1ZZDlLrqtOpDN4I5VaBF6H+ab7mI82oVG2MkXUwkkC6dXlk/KyGBQ6Kv13lblBTIiuaBmxnm6FhRC6G+v4BnuhcOlBmTsWEGJGyXNPKTPAs0HcWMGZsO8UhBUZVjiaMxQuPaQDQEt+Vvk+GaSVcdq71CG1pY8+cVteVgToa9/wW7+c+VFPf3aQXWM8+Bpce97Uk075ZjN7+n1y0p5DtJBZZKjtFxiNqZpKLeeLaAnu8sP8RwKty6NAeKj5pIZ9CMD54pwgtkU9kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA1PR12MB9500.namprd12.prod.outlook.com (2603:10b6:208:596::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 13:57:54 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 13:57:54 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 25 May 2026 22:57:21 +0900
Subject: [PATCH v5 03/22] gpu: nova-core: vbios: avoid reading too far in
 read_more_at_offset
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-fix-vbios-v5-3-e5e455251537@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0233.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::19) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA1PR12MB9500:EE_
X-MS-Office365-Filtering-Correlation-Id: eae40d7b-eacf-4f8d-dc0d-08deba659e62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|1800799024|11063799006|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: nNgb2ZzeY3a3Q1I9dP3mCyPKx/PhST8vRWk7KN+dVb4MinaMvsLGsGaB8b87vrw/jps0Vd5JsHrh7qliBoxTvqKmJBjgrYskLwiHYPilAsRUJ9qw+fDvwN7lmhWS9CBPgizDfcbJ/Ccos1XhJ/5/9OSh5EVsy+yBk0h6q7XjviNu2pjnPc2q6FAf28q5vsnfQgjQ938Qmmm9DQhrEgzl4wTZf+bL9iqctCCEi/D1Kd6W6HjsBoyfaAU0rUBk1u4tFDB6mXUmMImjUYFnzfaDRF8QvoZIFUpdeskUTybDYWv3dwrngzoc3Qichrh6WHZdR5FvPXGpNB7wC4v5CtbAD+ejzwFe7wJ1fCzR2OOEnDz9ctyiNL9D7ubtFLipVDbJ9dtuS56RUjJQXC19nntaGVIapIDuwJJKyMZNJRm8cDwGZlX7XfDhF1yxaihe8B4bro15kOZb5Hd/X9IqL4AO5NPe2762jgFTdamTDN1zf3/6Wet0X/yyuLJ6sdmNWivlYAyEAQlpm4o6hk9vHhstjfjtr3P4XnEZSJtZIBbff85Mmd56GpM8YOeJ/YvNqwSP8jeGOhYKxMi1/2jB5T6v2Bm6lhhCWqkI1n9oPWkdTmRoYmPR9EOPP9ItHCQywC96Uvf9F89p2K+JPdsZDY4kE0RB+FeZn3G+OKEdcLUgKqudiy0ymOPrcJmk4tTUmD3B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(11063799006)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDFlTi8vWEpzN3pralY0bzZDR0FDZkE5Z1FHS0VPcXFkZXgzazIwV2xPdXpj?=
 =?utf-8?B?Q2ZtU2ZoQnVOTW1sbFJ3ZzRyWVE1bUk2Y1BTZ1lscysyYUk4YnBTRUt4WTFZ?=
 =?utf-8?B?Um5FZ1dwYm9rSzBuRU9LRFZJVkExYzhDRXVodi9Fbnl3QWhkTVkrU0p2VWNP?=
 =?utf-8?B?bjJKVjB3RnFabjVBRFliR3FSTU9vcE9QQ01LVGI0V1dEMmdWcElxczJnNGxw?=
 =?utf-8?B?bklMeDVVMUVLRFk2ZkRDZ05tTFVoOFBvd2Fsc1Jkc1FZd3NjYUJhVVBGRXNz?=
 =?utf-8?B?WVJjbWFIQWlCZU1YVjFyZFh1OUN4aytYU1Q2Vk45YllLVGxvYVpMendHSTdp?=
 =?utf-8?B?M2NPZ0g2UkI3cGdjZlVMUE9KYmVldWo4RkR1eDRWQVdkRkg0Tk1tU0NvKzEx?=
 =?utf-8?B?a01RS0RvdHkzZ3FPOVBqNzhWU3lSbmRQOVdXRXpMa0hRc2ZGU2VpcXE3VTdj?=
 =?utf-8?B?NTlUZVQ1STZXcUdVWG8rcTJYdG9qb3J6eE9rRjJ2ZGVWRzlFZ3REaFZrN20v?=
 =?utf-8?B?QldHSjFvbVpxSExyQXhiTGVMc1NUbEQxNWYyeTA3b09CMXNLK0FYZ1FHdEVL?=
 =?utf-8?B?VWlQL3p4SDJqaGVCQVRJN3JjZmZYbkhXZ3QxZlpCV2U1VVBiK09UMExrVDUz?=
 =?utf-8?B?dC93T2ZkMElHaDJjZW96TnBBdGZmbUVVa0V1RWlMajhKN3Z3S2l6T2tCbjFM?=
 =?utf-8?B?aHhyd1RoVXZzZGt2dGtxaW9Ha1FlMzRERnZ0NXVBUk50T2lHUUFFQTJFRnZs?=
 =?utf-8?B?Umw1T3JTYVhQQkpDRFlTcmlVSTRxQlEvWU5jbTVoMFkzb3Ftc3V1Ny9jdmdo?=
 =?utf-8?B?cmpvN1JKZ0w3cVRmalVRWFJLTHg3dGhJQ00vRk9FL1ptTng0dGl4M3R1T3ly?=
 =?utf-8?B?c2dXNUZ1RS9veVlMMHlLWnVFS1J4MCs0cXE3VVUwcmFSejR0OXdWNEp2ckY1?=
 =?utf-8?B?OGN1Y0k5MVozWHZucmlHaE1hRGZnWlJ6UEdaSGpNam9YOVk2a0tXVENPei9q?=
 =?utf-8?B?TDIrV2thY2tsV1VobW9ORjluNVR1bm9yOWJJYUhxa1psMWhZUmlqZEYrV0R4?=
 =?utf-8?B?UFkyUzZJTmZPSkNDRzlCYytVUXROSG9SWVgrT2FEQ01BRWYySUdwd0JLTUtX?=
 =?utf-8?B?bi9VS2NvMkFuMmV2S3JoWm45Sno3Y2Nkc2ZiTjB1ZlJxNHZmK0NqOFN1L2ly?=
 =?utf-8?B?bmppWmhUSkpMSTQzTE1QVCs4N2NIWVl2cHVKa1ZtYnJLZGE5aVpMd0dvMDNm?=
 =?utf-8?B?V09XQW1mUVNGaWlSMTg5UU1wd1VUeVZwWFkrYjQwR21EWXNUaUNCS003Z2h3?=
 =?utf-8?B?dVZtSldRVEIwejdyT2d2V3NOQkVsa1RZZk13ZjdGS2g2QlJvN3hBK1VuL0h1?=
 =?utf-8?B?Wi8vcUgvYVRxNXk4ZkkzQ3FaZDBKOGkrZUF1dGhTRlNDL2RhdFhmTE5GMTRh?=
 =?utf-8?B?Y2w4RkV6S3M1cTBBbnkxOUtQVGR6cFZ2YjhoUy85R3lGUlRhQ0ZWZ2JHYUZr?=
 =?utf-8?B?Wm9VRlZOa29GMzVYb0MvUkwxanlqT2FkVlpGdGx1Y3VtYkRET2I3ZElUTEE5?=
 =?utf-8?B?RHIydU9KYU42RjJzbURBMjQ4MW5YRTAvWHAzYkVMa0R0MTlMZTFHWUtMallE?=
 =?utf-8?B?QXlRQ25EWE5CWk94SFoySFJoSXFwWUN6ajhvbUszUS9keHJSTUU1bFJtWFlQ?=
 =?utf-8?B?YWpGT3piYzJjSWNTQW5RSWhlUVR3NW5HcEhkaEpDUjRJWHBaZmcyY3dCRU1a?=
 =?utf-8?B?b0M0TFdMOVRNbGlCQTdBMUZvdWk0SFZOdU1ZaUNTQ1lPZ1FWQzJPbmJsRjk5?=
 =?utf-8?B?TnFtb1loRi9XMC9zS0xJSUMrNWZqU0VkcldvK3ZHODkzR0FsMmZRMlVPeVpB?=
 =?utf-8?B?Z2gvQlFLQzhlSDl4Mm8rTGtJTXRNd0NLSTRIM0llNmFkUHZIODFpTzhKZmxt?=
 =?utf-8?B?RFFsUEVaR3I1bmhZTXIwRUV5TVZuRUQzRUtpSExydFFnV29vWFdaZ2Z5SVVw?=
 =?utf-8?B?VENHQ2pURS9ST1FucDRYK2pFeHlGSTRGMHNFMXRXOWpWdnhIdHRrN1JSa0h1?=
 =?utf-8?B?elFTVjgra2xtVzEzc2Y5a2VnWFZnd1g0NGd2ZXVKL1ltaVA1eGc0MkF3MWNH?=
 =?utf-8?B?LzFSbkVJQm5Vdm14b3BKZ1VNaWl3bnJjSXBpK3NiaGswSjdsOXBjT2dLTDZO?=
 =?utf-8?B?elQ4dkx4SFRVMm9paWZHMWFVU3ZJeUQ1V3MxVXllQndsQ0ZxWDEvQkJ4bHRn?=
 =?utf-8?B?VkV4dHBkdEJWcnM4YjRVb0hMeStOd1ZaS2ZlSFc0SlQzSkNWOXE2cTdRM3c2?=
 =?utf-8?B?dXVqdmZuWTVKVDVXR3lIb2pPSDJEQmVxaFBGV0tJaERmVTNKZnN1TmpQZi9O?=
 =?utf-8?Q?h82dHBa9FmxspcND2KQTE7HhKEp9NewU9BwD/wchGNGri?=
X-MS-Exchange-AntiSpam-MessageData-1: FNvEyCpxsikn5Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eae40d7b-eacf-4f8d-dc0d-08deba659e62
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:57:54.5808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w8E2ap5oFaaL7xiyMrcSHpvD0voppFFomPINmT2+vnH/7NmZ+DHRYjNXUHygCTP248K04E9Sn3DfNUPRy+PiSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9500
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

Fix bug where `read_more_at_offset` would unnecessarily read more data.
This happens when the window to read has some part cached and some part
not. It would read `len` bytes instead of just the uncached portion,
which could read past `BIOS_MAX_SCAN_LEN`.

Fixes: 6fda04e7f0cd ("gpu: nova-core: vbios: Add base support for VBIOS construction and iteration")
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 180928433766..79eb01dabc6f 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -185,8 +185,13 @@ fn new(dev: &'a device::Device, bar0: &'a Bar0) -> Result<Self> {
 
     /// Read bytes from the ROM at the current end of the data vector.
     fn read_more(&mut self, len: usize) -> Result {
-        let current_len = self.data.len();
-        let start = ROM_OFFSET + current_len;
+        let start = self.data.len();
+        let end = start + len;
+
+        if end > BIOS_MAX_SCAN_LEN {
+            dev_err!(self.dev, "Error: exceeded BIOS scan limit.\n");
+            return Err(EINVAL);
+        }
 
         // Ensure length is a multiple of 4 for 32-bit reads
         if len % core::mem::size_of::<u32>() != 0 {
@@ -200,9 +205,9 @@ fn read_more(&mut self, len: usize) -> Result {
 
         self.data.reserve(len, GFP_KERNEL)?;
         // Read ROM data bytes and push directly to `data`.
-        for addr in (start..start + len).step_by(core::mem::size_of::<u32>()) {
+        for addr in (start..end).step_by(core::mem::size_of::<u32>()) {
             // Read 32-bit word from the VBIOS ROM
-            let word = self.bar0.try_read32(addr)?;
+            let word = self.bar0.try_read32(ROM_OFFSET + addr)?;
 
             // Convert the `u32` to a 4 byte array and push each byte.
             word.to_ne_bytes()
@@ -215,17 +220,9 @@ fn read_more(&mut self, len: usize) -> Result {
 
     /// Read bytes at a specific offset, filling any gap.
     fn read_more_at_offset(&mut self, offset: usize, len: usize) -> Result {
-        if offset > BIOS_MAX_SCAN_LEN {
-            dev_err!(self.dev, "Error: exceeded BIOS scan limit.\n");
-            return Err(EINVAL);
-        }
+        let end = offset.checked_add(len).ok_or(EINVAL)?;
 
-        // If `offset` is beyond current data size, fill the gap first.
-        let current_len = self.data.len();
-        let gap_bytes = offset.saturating_sub(current_len);
-
-        // Now read the requested bytes at the offset.
-        self.read_more(gap_bytes + len)
+        self.read_more(end.saturating_sub(self.data.len()))
     }
 
     /// Read a BIOS image at a specific offset and create a [`BiosImage`] from it.

-- 
2.54.0

