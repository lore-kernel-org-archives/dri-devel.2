Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6793CCD5BB1
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 13:58:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE09210E37E;
	Mon, 25 May 2026 13:58:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="SKjJrcOP";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010017.outbound.protection.outlook.com [52.101.201.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 015F410E37E
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:58:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nh8OuT1Ym86x+DfrLmR+dD9qndO35iWabPBovpwDiT9MFavOyaMQgFX5CnIFBS6HQQuuhB/oInxO8ttQrXavX1gtpwq9WB9bkvpaVoVgc3yf1KvhKH4tkuheaLg2DZF4M+aEdSrwsQBY/F5XjIjLma8lSN8o/e4Yzb/lhzsovWoH4fb9Vcco3tUjk+it9WZxn1F7h0cyDRYbS3WMXtxHqoPo93L159SbzaU/qUx+lzkQKHVMFqvWTmYxkil6j9gwepr5ZeMxJdupM94ySQS9poA5WWNPVsC+X3iuCblYTnJO/bALe3g7EbnCfbdfxjPxSQmM00GLdyMWC0sz9yrr+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ByLo1hFhkWWfpp/bwPB37BD8Sv30qx0D0V6cy6zHe8c=;
 b=GiVNHNbT1Dt1SVskYsphWpyTvQgFoDu2uZ2rDeSg3FIxuWfi8drqK6raKw6hVNRdJsOkF51UET78VYArgQ1WH05DVll6YcsZBBbQDuwUDX/LQ+ovPoFhUvYUO+w1dcLozsMoiZdaNbPet7fRpl94moSdXU5X4enaW+htEHnhETdK2zmUCmTb+brefBVKt+kJgGChp2uvzuCaZv+WlQkidL/jmLU9gGapA5XZmlcedbWU7nQpSppUEZ7aCa6VTDIo/KSpS/T+hTc49qHg3vHbKEkXcdiQEW6DTODzAKXhjvr1P6IOeXuqXNuoU3vTHfVu8wUcKBBz/O6uK87N2eSk+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ByLo1hFhkWWfpp/bwPB37BD8Sv30qx0D0V6cy6zHe8c=;
 b=SKjJrcOPt/nR7xzwMwBVxWM/tH7eorPkRJixcqNHHzLzmRMCTzVtcQAQERYhrvnwWmB6UfH/zWe7Z3DKqW8NxV62oZO7LlIE6Fw4LbrRXg3rvtwwbuk7IrnkxH+4Jh4JPFLkRITHEqnHLF974cbY1l/5pJzmD3OnswI+stfryX1sJcXpIpBzulkkE/Eb9gvb+fqqCgchoOsfL+jiYR/EwG2x1iur4msXjB0nMso8o3KNx0d0MCAtTWLyIhVYzbpCOCZmS2xJnpPSFr7reaQlC0QSDD4mscDp1ysNS+PP1cAgyVy8PrwCUxOn6I6eXMexsbx4U6j7lPOqgiaRDZnuUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 13:58:27 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 13:58:26 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 25 May 2026 22:57:28 +0900
Subject: [PATCH v5 10/22] gpu: nova-core: vbios: compute FWSEC-relative
 Falcon data offset
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-fix-vbios-v5-10-e5e455251537@nvidia.com>
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
X-ClientProxiedBy: TY4P286CA0072.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::11) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA1PR12MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: e12e315c-8704-4d38-ffdf-08deba65b1a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: AzRnDdYXVS3l6SZiUkAsf7kEd6HZLPQMaG5lsdxeE+EJxpjk/5+JJ1HYRN/pWEONBIJvccdv8ilbdbyaNAAyZkiIMNrZoJJELVIUK0NcJroI8fzmYPA1D/5w/qkvRS4aUrMpBqgMcPSICvmzLl9OAR3L5JTMF6UJGvqmogbB7oO6dXgPKT6sHgynewCYWYLFwo2d+AnjOjH2y3IWjXJpz3Oi3K4Hm6sJZe6pnqXX7mdhss95mTjou1sdZ2Q5xmq70GJzl0HlSy/j9C1vtNMeIiZxM4eT62Ma2KTrGfU2+EQHaH90fVnTBavwT0n+sRVkjn2iQBO8WO6M/2VD3cg3xD7yucDiFQP5OMGHSqlx6S9WAty6FPJJlHaixmKjtiRPjYtmheCctmdxfGVe3xmd3m9LyCLIR6VgJmnidh6mZiqTYWMg5VYgxNEtKoVP6hwecnt2xZtIjfEo1TF/b4VDHaJB/Co830g06G3HviNCk+u8jBqTv/kAqx5hgUcUlZYODkVX7u81rpy8fPKM10vivExQky9vTWvud1pogttWyGz5lF5cltaL0lMXEOHHkm/hjJuFyAPGcqnmDMWU8w5uSDim1uX8aN4XTWHJ0UlCUrqdas5fxy2aUgNsMiWAWwO3oJzS+AKHJ7AvwuN7i8F6DacsBM/zl9IhSD6bq5kVGQkGBdNGQpv3dcD1R9bxn5MQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(18002099003)(56012099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUtqSXUvRWswZWhCYVlXS1hoanBEVXVTL2hDUm00KzFueEw4Ti9Ua3FqcGRE?=
 =?utf-8?B?RWZlMFEvL3FMRm41MllqeWl4Rk81L0FlYzk0M2lSY05oWnhEZkVFQlRhd004?=
 =?utf-8?B?YXkxRXlVMUtlRUlBQjIyMG8zUDZoVmFGMkpNZTZpeXQxbnp0MU1oNGtCbG9O?=
 =?utf-8?B?aFZuNmJmNG13OUxLYVFaVWord3ZQZG9iUUw4VHNjSDJjRUhuWWt1ZVladC9r?=
 =?utf-8?B?L3JHRXhjUnlhcTF3ZHFuZHlWYStBV1hYdFdXK2NYN3UwWmNJdnk4TmUza1ZW?=
 =?utf-8?B?b3pFZVJiWTdvWVd0UTgwM2RpSk5tNHFROTErdVk3UjV3ZVVrVUVqVTBYTVNm?=
 =?utf-8?B?NDFsK1U5Y2NTTExqQStiVzNsZy9Dd0o1eFlESGFOVTZHV0xMNDd1bXBqNXlO?=
 =?utf-8?B?VUd6YzI4MmFaRGROYy9nYmIwdEcraTVLRXhVOHEwZ1J5MmRKTWRPYmRvWEpW?=
 =?utf-8?B?SytzRzNSMGx6RTBmd0ovOU1lY0VDeFlrSm12MzBXMjJCREVqRmR0UVpNZjNC?=
 =?utf-8?B?MExjaG1QNCtSWWQ4eERwZlBCMlJDUzMzb0EreGxKVFMxOU5KVE9tUjgyRjd6?=
 =?utf-8?B?NFluOTk0Tk1ORnAxNmprNjR5VHo5bXR0azRZbE5CdU9IUVAyaEZhbys2ME9y?=
 =?utf-8?B?R3l0ZDEyei96bEMxSVVYRk4rVXRmT1AxRkJ4R0VVK0ZjaWUxYmdFREVURXZn?=
 =?utf-8?B?aDQyQ25xbGg1ZmNTQ0VvNklVM01Vak8zNlNDSllzazIxa2RhVDZxUXdPSXJ6?=
 =?utf-8?B?SnBRbU9ZSEhWak1LYUk3L2JXQUNBTld1d1AyZDdHejh0UnNCc3VLNCtJeUdF?=
 =?utf-8?B?M0VxVWduOVdvQlhrakNLMUJxVXhVeElWc1JiMFQrOTZjdUhHQkZYQ1B2Q0xn?=
 =?utf-8?B?ME1pQ3Q5OVJHcWlMcFIrNDdwaStMblZMY1RNdWFTaEJaVnpuSDdVN3R5ZGFI?=
 =?utf-8?B?WVFCWTgwNnlLQm5xMUhDYkM0WjdNajQ3V2I2WGw1YzFZaWJ6K0ZoK1dJTUV3?=
 =?utf-8?B?WU13SktFd2E1QThQMjhxcFdIUW1kd0F1UVZ5TTl5eCtkcFluVGs1Wjl1Y3JE?=
 =?utf-8?B?VlB5NU05a0E2NENremYxeC8yMkFObHhtTncxcmJuMW15alRiclRHWGVhZ2Fi?=
 =?utf-8?B?MWJCQkFRTjgvUGFaN1VXcWNVOExwZDR4Ukl1T3luRkZlM1h1MmtlMThBL3NV?=
 =?utf-8?B?Ny9iM1VxWGhOblNNRm1SQitaWWdYS0QxZ1UwQm1qSVVGYWhFaGoxcDdsa0lu?=
 =?utf-8?B?QW1RVjJRanlIczg0TCsxS1hXTXFlNS9WZW0vVFMyVkYxSGZVd09iTnpERGJv?=
 =?utf-8?B?MHF2R2dOS3lwYzBKOFJnbUJ4ajlUZXkzSTdGTTdYRUZkTVIycHRBdkd2U0Fa?=
 =?utf-8?B?MTRKMEtWR3dZSlFZL0RiUEIzS216eUJWMjZOZEhPOE1BZmJNb3JsYjZzd3Nr?=
 =?utf-8?B?bzd0OG9JZWNaWEcwL2xnb3J6RXNVWlZzNFVFMktpdkdERUhSLzRnN2JVQ0FI?=
 =?utf-8?B?ZldhMGRqN0c0RVRENmpsYnhQK1BaVjc0OXlhZTdBTFpRUlhZb2pXM3F0Yjd4?=
 =?utf-8?B?dis0Wmd5b3Nob2gxWGk0cUdhNmRpVDZ5bzAxY21pdzdabmltR2RON3BJRlFh?=
 =?utf-8?B?THY2L1NNMWxYQzE1Zm84Z0Z3NWVPbXBsN0VqUkM4T2hTRlJIbUpKOVI2T1Iv?=
 =?utf-8?B?SXFDWldDNHVWdnczdVJMdnUzUFJhUGhOcWp6am5kOGxIbHo3blUxN1hmNTV2?=
 =?utf-8?B?NGZXVVVYTjllemlCZVN6N0oyaDliekVDaHBLbWtHK0ZIaXBMVEtZSDlLaTQv?=
 =?utf-8?B?U0RnUmVocC9CYUFTc3AyUnl5dzFBbndiNnZWVFNvdEYrckJqeXhEdlBYQUJo?=
 =?utf-8?B?WWE0NDJCaXlibzROTHVlb2ZLc0JDeTl4Ym1PNVRBTjZhTjF1RkkycjZhMGRw?=
 =?utf-8?B?TXhsa0ZEYm9TaUNGYXRxa1cvQy90MUN2RGhnVy8yYlBIUlpoOVdkUVVraEF6?=
 =?utf-8?B?WEdhRjZZVGtWQ2tEbTdMQnFUWW90MERkTllJZExPZEZUd1hmRnRHYU9rMXZs?=
 =?utf-8?B?MlpUeGo2OHcvZldTWFFtMGoyRlptbTJmTkRwaTBQZ050MEJ5Y3FqdVplM3VW?=
 =?utf-8?B?VnVrSHBkeWN3MkgwOWdBd2kyeGYvRG00c0VoQ2d0WjRwaytSRGRGd1lJbXpD?=
 =?utf-8?B?eVNmUVk0MU5jTUw5cjlsL2srM2xKOXBSVnFzT1czN05mM3dKQ0g2c0ZRYVNm?=
 =?utf-8?B?V0FTejc3NHNIci9VNFc4RVpqS2ZBenNDa2Nnb0JjakVwa3JRVUZQVkYwQ01P?=
 =?utf-8?B?U2pNT29nUlVuOS9OMGNMc0JWb2l4VXdoSHVXRWVoNUI3SWhxKy9sVDcrcmVk?=
 =?utf-8?Q?GPykMl5KC57J0nrCQ94g7CWNfJKDBjcX8/Hb7YKgLx+72?=
X-MS-Exchange-AntiSpam-MessageData-1: IAIRmhUeI5Ly0A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e12e315c-8704-4d38-ffdf-08deba65b1a9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:58:26.9331 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UuTrOIQElCAw/5KeaYuBHNMrkz9lcWDDDQv9tQgXEK28ypz+WJZOKE4WqYPlRQR28yTnkTqFslBuuUNBdw6xAw==
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

Push the computation of the falcon data offset into a helper function.
The subtraction to create the offset should be checked, and by doing
this the check can be folded into the existing check in
`falcon_data_ptr`.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
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

