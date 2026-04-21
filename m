Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAED3F327BF
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 08:20:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09D6410E84F;
	Tue, 21 Apr 2026 08:20:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="UZHy/9uS";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010032.outbound.protection.outlook.com [52.101.61.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BD3010E84F
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 08:20:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3lVjv8GRQdggCy9f6BBvZhOriM7PHS22w7hm9iAG08he0E4Efmdz2NSvnILzaudbDOK+iaiC/I2CXegAvuwjcvLrEwl6VUyz7g7LO4LYMX/b2FZDiaKfm1TWzeXWgIINhIc1zNdyCUbV6cfQqToPYmKZVEkjVCv4q54ptuBrxrNg4PZT7bY1L2ooYVwnQgvcSeN3ve0y3CAH3MBoXcJ70v5QnplzfJsZ9L07sWopg46WkAtdCEnVeYHJg/j7RItxl7rX+uqMoC67TP8cpuwjhHPJT8dk1FvjtB6nU4X8bC0X2AawbKheR/Hay63g7fyIKsO8AJRsi1pKxL+lNGOwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmnBV8B9jQCKjM1UQz1hof5IHNM9xMnmrpvWclye9cI=;
 b=PY8/n+T3CipnwwCvi1h4LP8Jnc3+pUZKzHiJzliQjnA75EqkWf7fW8HWNDn6+gcw5C6OVgRj3Q1g4i9zZPUmdlWnNXoFz5Yrbp9mZOWjC+i6IuRgTtK8DGwqdv5VKoiDRIBG9at8CjSVFQJFghPhepuDf6V0+Z2/Cya5n/pQD/izkWgIefwPPmL6jBawKsLFT9aiv11i4IGAdU4jh3epJiD1mXT82WT3I/+ygsTCI2i7hgrUkSpTyyjCXb/34EqMk7QldYFURYEEt3hlhT4NWIAY1czL1aFkP5/ybqqSNm7uojPNJDvBNrTqSwIUc7xeoSkkOdHeeX06IhIEcNNslA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmnBV8B9jQCKjM1UQz1hof5IHNM9xMnmrpvWclye9cI=;
 b=UZHy/9uSEvD+FsuwcMm5xsRqQ/r2SeX06905G4dYwmFDE+q/l5VM2I0G9rqmf10jxIs+/nDQ58sSRAIhRRArbJuq3CF0FO7JWxQ27Ua+6UiIXFSuIfGVu/xVwmhrIULMwSzPOkmCZlZdVq8SItfnfF2n/IVz9KHT16fTAYjc7TRye3wjXCzkjln4l9bs0CGuqPGX2VzuOe1drMMiXrXVSAfb7cJQXWPbwEazoTtBjREf7nHoC73oNvQHcTJswUbBBvgBpHRQRyLCofuVV404FumlRS46v9BZEpz5Xov2Hnh0VxCEag/LGQK/8AwXwgvID1BIF1sQCB7gfl5wtz/ZOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA0PR12MB8376.namprd12.prod.outlook.com (2603:10b6:208:40b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 08:20:44 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 08:20:44 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 21 Apr 2026 17:20:20 +0900
Subject: [PATCH v3 01/11] gpu: nova-core: vbios: fix various cases of
 reading past `BIOS_MAX_SCAN_LEN`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-fix-vbios-v3-1-8f648aef7a85@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0167.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::19) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA0PR12MB8376:EE_
X-MS-Office365-Filtering-Correlation-Id: 90495b13-c4ac-4b96-a0d7-08de9f7ee201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: WQWSH/fSeFlupfIWtOfBm4WjeTjD3vZ7NBFxEDm7p7VGEEfe/RPOzShZGZYiGpDPX60M4NkznEDZ3KcvOmX5BI3uIJr1xyIyipcf3FBatqdRILoJs+cBcUr0owpPAixW0xe7kW0CBH/CkhJrHhdx2Z1Waq6nCxSiflT6MaKat3wSNs4OnCbxTA7XjM5nxgMToYS6jfHXIEeZTSvB5pgGFf2yVBrJKud2WvtBOTQNMNu0fSVSfYYJ0+ll2r41xR+NwaS+4jCLPtq6ces63Dz+m4QAhY45zoNzt96ATyyvr6yFI6jMcHBm3pkhVwquajMdi+SH8ym0BypswAXmYGrgxW5dhS6j3MPqLZmOdbnZwfm4DF2fh3mRaC9AdN8TKnqU0vKK0Lr5yUkWLql1y2SKpeRb9yrshVbPjHJOinAixgujXYRxD/1fTnGAJZI37/BOsUjkjZs0phEbou+Gx9DNBpfzzcVZWuKft7eGP5Qfr46MKEUjbXHOvmCbtwllpbrLAmjvOC/NFbhc+Pn6EDQEy9xRZyINc8Nxl2DRZocrmyvQRuRJD9iaB+Kf4u2aJH1yUCwpw5ZfwRVEnXnlW0JcVcnDK8LG7h5qotOUVHTknzuy3gjVoQXXGSPZBR7Y936Wxi/S4J1uNElOfMu3UYTZ1LAfKar/U8nq67YBI6l556bEiXBnGj+/mORPqyOY48ic/1//i4m7ZHxDproIKFDo76GGM4wr6QNQfMRBPvI0pfA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1VIZzdLWFVXNlZmQUFNMDJVdEZFV01ieXRKR2hJRDdRNFI1K1NENWZ3Ynox?=
 =?utf-8?B?Ujhoc2QzeXJVSitucEVrNzNCbWFGRHI0YmlLdzZmR0JqRWVPSTd0amN3NFZW?=
 =?utf-8?B?NnpKSlIvUHgyQUVrRzA2d1pBa3p4QjRrKzJ2QThabzl3OC90Und1ZUVML2tF?=
 =?utf-8?B?MEZnVnZzcHpOR0VuOUV4citsMnMyZnZHSlhCcGdGb2FrazZtMlNQNy96Q1BU?=
 =?utf-8?B?Z09ycDJBY1BGeWgrY2Fqemt5cWVWNldjb2lhYmE3SlRGTVBoM3Z6d1ozVGRt?=
 =?utf-8?B?VGUwdFU4ck1OcFlzbW9pSEJUY3ZaZFJHWmNlclZjeVRGakNWOWEyUmFCaUdq?=
 =?utf-8?B?MlZKb1E1dFpTZks1cGNtcHNRdEYyTFloL3FmSHdhbnlBVTIxR1p5RnVHbVlu?=
 =?utf-8?B?Q3V6dHpNQlFja2FkQlVjbnpmVnJCQ1NmbFpIM3FxY0d0VTNwdS8wSjNDeWth?=
 =?utf-8?B?REJzUXloMlFwSDFYME1DVmNKWkhzZkxqcGQ4SVNSd0RxUkZOaHZkK3JoQlJQ?=
 =?utf-8?B?bU1TdmdwSmcvNi9JRXZLdWRKM2xQQy91aXJnQTRqZFN2RkJRTGFRNnRjMXZa?=
 =?utf-8?B?OTVEa1RWdFRnU0FCRWI4c2t3YmlLNDNkVEJCVWhNeWtmdldjVURJZ292cjBz?=
 =?utf-8?B?d2daeTZQdDR4L2MyUFVIU0g3QXk5c3o1VkhwczA3RXluVWJtQnVnZ3F0clZW?=
 =?utf-8?B?eXBmOUpkekxUMnNldHBMZDlOUjNmY21oSkZ2TzJmMWZyaU90ZkhLMVI2Skkx?=
 =?utf-8?B?ajA4RTd3cWhWWEtqME02bFZzMUlSbmNHRy92MGc0SG9qQ3BRL0o5MWVEZzFa?=
 =?utf-8?B?M2hOdDMzbTJGaktYUW51UkdreHN5YnNDQnlraUVoMHBWaSsyUXFTaCtJT0Yw?=
 =?utf-8?B?TEp1b29VK21TanZSVFZRR1VERk9HMUUxN2NGUHdiMTU2cjBKWjRrL2VkbUJS?=
 =?utf-8?B?NGxTMGpWcE1oZWNLc1d1K3hjWnIwbWo4MDFjM2p3eHViOXZyc3k1TzVCSlRk?=
 =?utf-8?B?RmRvRmdvUDRxdHlXbHpyYlhWeU1mQy9rSkpTS21CYll5U1BhS1hHTEM2bnFF?=
 =?utf-8?B?eDVQNVdRTnl2Zll3eC9rOTVsWm5PNnFZV1M1QmE5ZzVqWEM1VXAyNHg1ZmpV?=
 =?utf-8?B?UjF0OVgzR2tUcWsyTWpseGVvaXNyWmlpSmhCMUlIa0VmUk1sVk5iQ2txZ1JW?=
 =?utf-8?B?dGN0MDhxU0M4NVdpNmgzVlN4NW8zMi9rQUxRc2lJNTJxMWYwSUJabmV4bG1I?=
 =?utf-8?B?Z0ZDMEZ4MDEvUlpsbUdHb0Znc3FXWGVGcFY2TC9yOHVYcm5MNUtFT0tSaWVo?=
 =?utf-8?B?aURtRVl2bWN6SlJMTUFRSnYrYW5RMmR2bHdrWnVBSk11WHZ6clBIZ08wb1gr?=
 =?utf-8?B?S3BqaVJiZ3NlaHV1MTRDTVFOQmxxaFJRUlNTVFFCRjNCbHFERFFUNnZqUGxN?=
 =?utf-8?B?YWJaaFNYQWFhMWZGcVhMUUtNczdIbm9iRVVjNkljOE9uS0tQWk1aOXV4dEtp?=
 =?utf-8?B?WmJXc1dLekZRR21idEs1ZlVpVXphSURNaTAzeWI3K09iM3B1QmFBUUFZSmU3?=
 =?utf-8?B?c2I3SHJhQWpnMUNsWnNZZDhGMzhvK1FzK2puZmx4M2dNOHJEZ0tPVUJIS2cv?=
 =?utf-8?B?enZBMzZTOHd5UzEvdlZtdHFOcmV6TzJDMXZTVEsrQzRpM3VBU002c213UU54?=
 =?utf-8?B?S1FtQWJQNFJNUTR6UXdrc3Faa3RrYm5xeWJEWStNTndhaHViaWZuZkQyeTIy?=
 =?utf-8?B?VjVnRllhZlBOaGIwR25DQldtb2ZUdERzbVBoQlFUZ3FMcEYyanFnQjFvY3Bt?=
 =?utf-8?B?UnFxaTJwSnFOTWtXekJzQkxkREtJaENaeGlJTS9tMFZUZVF5N0pMb2U2STkr?=
 =?utf-8?B?RkFkVEJGS3MvbUN5YXFFblVVa2I5eGdKSmVsVGVBMVdxR0I0TnZtRmdrajNl?=
 =?utf-8?B?alZtYk5ybE9kY3dwNXRIQjlMRzhNTWtqVzNleHhDb2ErejVGd0NSbnlhN3BV?=
 =?utf-8?B?eWhrcDRyc2o4Skc1MFY1TjZUdzRVVFJ6dVhFV1RDYk81MVBzR1VmYkx4N2Zk?=
 =?utf-8?B?VnNXUy9LTERFUWVlMlh6d0N2UGJxUzc1SkZvSGVmVmVIbnNZM3NJME5BaHF3?=
 =?utf-8?B?QXlMRHdOd044VXNRR0ZjK2xueFFlejB3aCtmSExDWXdyK1diU1h3WWlsUWpi?=
 =?utf-8?B?VFY2RTR4dUNRV0RzUTlvUG9rWjYrTEdxM2cyL21FZHlaeGQwaFlGaFliOUJa?=
 =?utf-8?B?Tm05Vlp4MkRacENOdndBOE5xQUNqTVpWNUNsNjI1TnRHSnBPRGV1NjU4dzhC?=
 =?utf-8?B?QTlUS0lIeUM0M0tGQ0doYzBnMWIwSTJPejZyUEIzN2RBU1ppUlF5UldHVE9r?=
 =?utf-8?Q?zkoPZpIFpElc9nVUxR36N+UECLK+DfdiMamSgV3lo/8Yo?=
X-MS-Exchange-AntiSpam-MessageData-1: qcZiUiE4htTfyg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90495b13-c4ac-4b96-a0d7-08de9f7ee201
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 08:20:44.0572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WOMixd0tBepbY6ozLjXV+DnKBLZ+qoev29fCkvH/rLd4i6GXm/EccNbZSVqVwJAp6+V+/CuWxvO0N03TOOPYRg==
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

Fix various cases that allow reading past `BIOS_MAX_SCAN_LEN` when
scanning the VBIOS.

Fix bug where `read_more_at_offset` would unnecessarily read more data.
This happens when the window to read has some part cached and some part
not. It would read `len` bytes instead of just the uncached portion,
which could read past `BIOS_MAX_SCAN_LEN`.

Also add more checked arithmetic to catch potential overflows.
`read_bios_image_at_offset` is called with a length from the VBIOS
header, so we should be more defensive here.

Fixes: 6fda04e7f0cd ("gpu: nova-core: vbios: Add base support for VBIOS construction and iteration")
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index ebda28e596c5..6de7e58e0da0 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -132,17 +132,14 @@ fn read_more(&mut self, len: usize) -> Result {
 
     /// Read bytes at a specific offset, filling any gap.
     fn read_more_at_offset(&mut self, offset: usize, len: usize) -> Result {
-        if offset > BIOS_MAX_SCAN_LEN {
+        let end = offset.checked_add(len).ok_or(EINVAL)?;
+
+        if end > BIOS_MAX_SCAN_LEN {
             dev_err!(self.dev, "Error: exceeded BIOS scan limit.\n");
             return Err(EINVAL);
         }
 
-        // If `offset` is beyond current data size, fill the gap first.
-        let current_len = self.data.len();
-        let gap_bytes = offset.saturating_sub(current_len);
-
-        // Now read the requested bytes at the offset.
-        self.read_more(gap_bytes + len)
+        self.read_more(end.saturating_sub(self.data.len()))
     }
 
     /// Read a BIOS image at a specific offset and create a [`BiosImage`] from it.
@@ -155,8 +152,9 @@ fn read_bios_image_at_offset(
         len: usize,
         context: &str,
     ) -> Result<BiosImage> {
+        let end = offset.checked_add(len).ok_or(EINVAL)?;
         let data_len = self.data.len();
-        if offset + len > data_len {
+        if end > data_len {
             self.read_more_at_offset(offset, len).inspect_err(|e| {
                 dev_err!(
                     self.dev,
@@ -167,7 +165,7 @@ fn read_bios_image_at_offset(
             })?;
         }
 
-        BiosImage::new(self.dev, &self.data[offset..offset + len]).inspect_err(|err| {
+        BiosImage::new(self.dev, &self.data[offset..end]).inspect_err(|err| {
             dev_err!(
                 self.dev,
                 "Failed to {} at offset {:#x}: {:?}\n",
@@ -189,7 +187,7 @@ fn next(&mut self) -> Option<Self::Item> {
             return None;
         }
 
-        if self.current_offset > BIOS_MAX_SCAN_LEN {
+        if self.current_offset >= BIOS_MAX_SCAN_LEN {
             dev_err!(self.dev, "Error: exceeded BIOS scan limit, stopping scan\n");
             return None;
         }

-- 
2.53.0

