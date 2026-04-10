Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 452BBE99055
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 08:39:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E62910E8ED;
	Fri, 10 Apr 2026 08:39:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="MEUwh8/Z";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010015.outbound.protection.outlook.com
 [52.101.193.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 618ED10E8EC
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 08:39:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RyeOouiPU4P8M68x0M/IjpsbsQKF7kpmq0G9bsoHac9t7VBCl4epBQ9a1bejuXtBfZ6FPrBoTGJASK4ybCyMh6NI44PEMehX880aAmaFqeH83rtCtAkcT1zxEkL40HrttJ5Kyz2qOn88duB2UtPrYLJN7k0H4YJJ8ubVeDtZInzy9xplo0Ubk1zEEdgMX+VtqUdfiSgvmTqOURHj8pF7ytsmZDxnGGwTF9bK0e44cqQt55go+z0/fnyGv/sPgBjst0CpzW4VymzUBoUm5NzflFqrEt5Q5WEQk3LLSyxucaHJicYozvC3vK9Jh4vmlUBDI4DFWtxS6nfU/uQWYcVh1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+XeYFUOBB3kR9uHCrtYrcfUUK5mZgjN08mJPDv0LdQ=;
 b=X4qo9p4L/kN3RFA8h5e7bPQ9BeuRsJo52ZEQNPRmLjtCHdOO5oeYgKqNzEAIzSPOzEczJr7HMk6vpLQ+iJbZINg/SZCAL6MIcBZxlAC3gGvxTPq7yJXsZBAW2eko6NBWSDa5n0tuWYfk+Dd/EdJyze1yv9f51Ey6lKPZaOkzpEVmDn7P2SlCNnj83uVGfn2ZB1Cx29hyhDb3o7dIeLCbq5XozuOVB5misnmwRm2noLQuz9wDIQIX86jeBdpifVtDZPBzSFUiy15hoztHWV6nWzXU6XO1usO6SWeSrgBAo+PwWNPI2XH7A88gC6SZYXKLmZWrx+fuJumaiN14v18y7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+XeYFUOBB3kR9uHCrtYrcfUUK5mZgjN08mJPDv0LdQ=;
 b=MEUwh8/ZaTdeT7wa3pVCfaDOi8FX2NS93DysP7mnb3DoceeIWUIrVJGOnUaluyTDSmqE6RCh4WKVDKJMIYjUeOCP//SsKcyau/pCOoTeUQnJkZJrhwRPD7RUWbVur9jYPU5NS4F310O1D3zEvafp4rkp8lpmLU1bmWIR096OBO41AYX3/wJIB+Yl1B3A284qIeXbYG/pq8cRZZCbznXudS3DkYGhxcZTOW2/3uSKdaXeHzmBOvp5g+EzJr8t/GrCzfgTsKPyXt3IAChdijd6hyVBK1z1tJCp+QNyr/CgNmAomQ7q7N3yokB/4NfjV8Flycm6IS5nXCH8F0LkqOOSyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SN7PR12MB6861.namprd12.prod.outlook.com (2603:10b6:806:266::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 08:39:15 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 08:39:15 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Fri, 10 Apr 2026 17:38:50 +0900
Subject: [PATCH 1/5] gpu: nova-core: vbios: fix various cases of reading
 past `BIOS_MAX_SCAN_LEN`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-fix-vbios-v1-1-bc6f71d153d6@nvidia.com>
References: <20260410-fix-vbios-v1-0-bc6f71d153d6@nvidia.com>
In-Reply-To: <20260410-fix-vbios-v1-0-bc6f71d153d6@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Joel Fernandes <joelagnelf@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: DM6PR18CA0029.namprd18.prod.outlook.com
 (2603:10b6:5:15b::42) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SN7PR12MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: db4f1ca9-0e2c-4378-42e6-08de96dca596
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|10070799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6A+rKQRGOu+BEBrv92FK0jPe+oqnHK87rUtbDGMu77j1LAZgidkoYzZC7vUHei+m82TwTmPWlG3034WZmYKuK0OW4H6zYTKmzppJg9eZjtpckj98KZckvy8bdZEH/7U8QbYv6bgK80Euo79p2hCk4L6sV4GDTK8v/qd1LzUeNUT0zTEh2ihAoVzjRAyx8zDD5+8Vuo+6OMpaVUmy3Jrpg6iBaqziHiJU5xoLQ9xjtWl0QqYbrsv3X0CMABpHiy1YJIRgISO551dKMoaqJ3/M5DZWHfSQ16D2MioxjD3SRH8l9d461Zn2M8FxE5vV9fXiPrx/lUu0AanWspwwokZgKr/0gBEGbDOC7qrIIx2OhiY5W5weU540D0S6rif+ZVdlUdUO/Mx8hT5I2bcU1vqlbBg+8u58eGiLSC1LvE9wF9jY3Y/JGTpoGwhWxJQp03q3rymLXyFa6/gIdvIDMMigULzO12fQcnD/fF+XxX9jF+1W7wTbFZxVe65wHe6+SXS2bL2VWPb5BqKyntlSGPW0LpD3FifpM2ZS2Vn3l2BiO3nCY1M9SSJCMOG2EUUcEenzhxm15qGEN1h/PWz9oSvb3UxKhot9ge5pPQMzB6Vzc4e74f9mNEF+cw1zCz50UzF0LwZrT+o6jqxCP22WlS3coPHRQezEHsuXsHLfSNHW+hj94dPR1ISleqK4pYCJ0URLMrZjxPfnf2pXZLIGgWhYY+85voZwVPwYZgqH42AFHrI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmN3OFRvNVZHdEhTbFFZWmxXWm8wK2RlUHJ0THl4Sm51YlBYMlF2a2hFd1Yw?=
 =?utf-8?B?TEhaald1NTI0RkpzUHhKUlZUeC9tZG1ZeERkTktzcWVSdDhqNnpMYjBJbFhO?=
 =?utf-8?B?Q3ZyUlF1VUt3SmZZWVlIcjlaY29DT1dnLzdvMDRRR2NTRWhJdVBIcUduclJE?=
 =?utf-8?B?TS9Yb3NPMTB1MmowZ0g2ZDhUMUVpbHRJT2hNR1RMSFROVHVIYkR3dHhiU0tN?=
 =?utf-8?B?aXBxZWpONHZtVlkyNlRlbzZkVzJQT04xNHUyVWwzNUdyU0dRVmo5T0V6bXRD?=
 =?utf-8?B?dC9uR0NZSjZYeGJ2NVdWamI4WXU0NEV6Z3ByODE0d3VqRDF0S2FoMlBoZEda?=
 =?utf-8?B?OW9uOTZRWEVuZTVUdXpsQ1VIcTVCT1hGZDBDeTVVMDRKNmVUQ2d2K3doMi9V?=
 =?utf-8?B?Y0RyN2kzMUIvNG5rQlF4Z2hpOU1RYUI1b1UxWjhEZnU0SUIyZUdhc0pqWXpE?=
 =?utf-8?B?cDlHWm04TlA5bGZXSlRwZTRORWNWeHlIZUJzS3EwdWtUL0dTdUF6ZEtJeXd6?=
 =?utf-8?B?T2NWeHQ0bm1DYzNRYVdBNXE1MUtMRlQyeTZvYUZCNFpwdFhZcHU2amJLUG5o?=
 =?utf-8?B?dGtZTDljQXVYN3hmbDRxMGQ1SlpjR3FKVXNUQkZIYmUrQjZZYzZBZFdpZWw1?=
 =?utf-8?B?S3VicWNYNlZrMHYxYXZLSzVXSjE2UHYyRExjbytBYTBxR1I5QlhITXRrL2ZR?=
 =?utf-8?B?QlgxZGNyc1NPTmlydWFXM2JCUEp1NmR3TTh2VVNrR0hMOTZRa2VoK1JkUGNM?=
 =?utf-8?B?QnNQeHF1NkN0UHdQeVdic3FHaTZKVXZEcXJEclpnY2ZiSkZzNUo5cjJocHhJ?=
 =?utf-8?B?aUE1Q3hTREVUR0RsYnZCaXF4alJOUmhsd2Z5cnRhdVVHQ3ZQSG1Wdkd4NGw0?=
 =?utf-8?B?NlpHNXdqYnFOOFVsSDBEUlM5STh1R3VHM0RGRngrZUI3TTE2Tk5mMXpjMjcw?=
 =?utf-8?B?dEpsQkJmdVh5dEpsZXdQbDdPYkoyKzI2SXVwSXdrQ3crekd2alAwc1JCNXhZ?=
 =?utf-8?B?ZENmRGVEdi9RL2ZQdE84QVg5ZjFCOU4zTnl6bndEWk5FdjZyWmVONDRuZzRV?=
 =?utf-8?B?NVE3SndvMTE1WFdlSTFiR2wyL2JicWViMDFHS0tvSi9mUCtqemJmcS9SYkpm?=
 =?utf-8?B?WCtMSG43ZlVlZGNqdWxHdFdTNy9LUlVFallBKzJpSURSRmRTNnZYQWFPOUdT?=
 =?utf-8?B?UkpyZ2I4eW1waFdzRDdPRDZMTHpHbFpJS1pGQVRGMVhZQUV2L0kwL0NCN000?=
 =?utf-8?B?VnlHTWlERS9LcEdHVHd2UGNVVmV0d3lxQUVxU0dNK1orbStMMEE1dGFISW55?=
 =?utf-8?B?a2ZVei9TMmQrOFlkcnpoMmVUOGlDRUV0VEtuUnh5Z2twdmxpVTd3YTVNbSth?=
 =?utf-8?B?dUlBb2hVem9kM3RRR0hPNW1DNlJOTjVMMXYvci9sZzdHS2xXOE1kQlpjY2I3?=
 =?utf-8?B?NGF3Q1FVWFlNSE5JT0NlNlRPV3BmZ1ZUQmdjZDhBdXB5TTM5ZFhaK1FwWFpZ?=
 =?utf-8?B?cUVpR2t6aEpGQmFkZ0dxMWZxNnBFdk9Cb0xwRldlLzh0d2Y3OUdUNjRocWNZ?=
 =?utf-8?B?L0Z0SmlJNEpraGxVM1hNV0VHN1VyMTBoMGM3djhWeS9OczFSejhDdERLOGIw?=
 =?utf-8?B?UDA4MnpVWFZuV3pCSVZMbUQvdklhb0puTFdna2JUWTdwbUltLzVQUUZVMlZ1?=
 =?utf-8?B?dDN2dDcxQ1hnTU4zYjJvT0V6SmtJMVBnU0k0ZlRHSUYzQkpwZVVrSnRGelBx?=
 =?utf-8?B?VG1UQlVUeTh5a0IwZ1ZLTTVSdTlaem1XaUpBWmJoV090RnFZV3NZUHZmSE5J?=
 =?utf-8?B?MVM3QXJ1K0JJTlpXdVBHNWRGamg1M1BraUYwdnRtZHNEREs3a2Fsb0hoSC9C?=
 =?utf-8?B?UnlseEFWd3lJR2lvaHNFVjZMY3g2ZitYOERzY29rZmZWRG9ua1IvRG1DQjRo?=
 =?utf-8?B?eTBRVHloTCt6VnJvTmppQ291SHpGc0Zra0pKRUdMR05JSUt2blJteFhWRERv?=
 =?utf-8?B?OFgwRExha2Z4OGUwM0g5dXBTdDlTYkZDWWNwWFFjdzRqRlZFeUVmLzFLYU9Q?=
 =?utf-8?B?TWV5R3FTWkJXYzF3R1pvYzlwOURTdHJKS2c5bzJCOTN4Z0tXcWpSNHZ1UkIw?=
 =?utf-8?B?ZTF1bHkvUk8xVDBhTU53Nm5NS2MxSEJkSlJVOGFhaHR5Tk5TK25NSk5XRTR0?=
 =?utf-8?B?YW42M0dJZzFMMGRDcDRCU0Y5ek9jaXIrWVU4VUhxVWtDempkWEFKMVpvRW5P?=
 =?utf-8?B?ZFpzSlZ3WHlTbHpqY1ZIeXh3VmlydDdRRGsrWDlTblI1eDJURXB2ZEttZGNE?=
 =?utf-8?B?bE92Wkp5NzJlUkVDQzRaeDVPeHVjaHd3SjNWRnJ2Y1ZMSDVVMEZCWnplb05q?=
 =?utf-8?Q?ENqvgYRYUEdP9USr6awFmgx3z5sm7yqGNVUxJVvRUbM+o?=
X-MS-Exchange-AntiSpam-MessageData-1: H/pg5KcaMqOqXg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db4f1ca9-0e2c-4378-42e6-08de96dca596
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 08:39:14.9435 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10T52K5wy+EQ5tpVlDqqXK8bd2gazgMyNqB3pluJnkt4g4Vnio0+VIth5Tn4evqZw2GQ4r6ULbnISldlZOPbZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6861
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

