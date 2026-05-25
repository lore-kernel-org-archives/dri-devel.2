Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40EA9CD5BB1
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 13:58:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A064710E34C;
	Mon, 25 May 2026 13:58:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="TofsEeUk";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013066.outbound.protection.outlook.com
 [40.93.201.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD14D10E34C
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:58:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cly/SWgqQYc04ySnmzAbl5+BueFlskauQlwc/UM3mWZosIN05Z2jzGP1bGDEf/UlMpjUGIUQzRWDHh+bqVi2hxMBlWHsv7NSQ3cRbbr9B0yCaP4XP0QMajjcUindL940L89I33NWxbuqTN65DXCjVBAAYxCM+RkL5XFse7p5HfSIOIGWX8HfgEcTmv9L6hGUL37dTqXICfOJELWs2pCQP1fqGJsminl5kMaTyBLvyrGGPzV41lTj6LVv28Ib2IkoSClzATOfHvDUAk1jAyMACGA1IRWBlx2KPCke1ey+QPSQl6uDloziym3cruSEHkY+8D2BJ2YqOmNPAZMC36R5Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzYn3fiVkOtWM7EJXAOb0HBVUrEKfyyMkfKpsmqs1Rc=;
 b=Mdef75BKngpw+L9bSCUV5JbUAmkt2QDO23vbTH4MQahA4xeNhrea4n8aBErtho1I4zKxTRHE4htydBDAlgC9Jc3thfSBajMuH9rx7hUgpYR9AMTOHdW3VN/kqTL4Re6a4GO0eXETXRGlGyyo6/OkCkOr0riAerEXjRaXYPt7norNoR6x0UMDfEYSiZjVHOaAq6Gr1Gxy5p/TkLbFxXJ2rU9oWFys0SPRD/IDXiraZ2Ey8ka01C093ScmZP6q1fhXkB6EyvGcuah0uCXw6Z8KoeMDOHmXRxj1JK+o4B5TvoUdKdOm8SayGyiZ8v7tNE2Xd54lsKFC7bOY7G6SC3VscA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzYn3fiVkOtWM7EJXAOb0HBVUrEKfyyMkfKpsmqs1Rc=;
 b=TofsEeUkpHYg5fSQZlYnWOniiKaJTsn5mdxIZnEjE9IHabvRUrouMhB1w3RcVtCuwmjoN4dIBhr1AraxMfHgiJoex+sqQJR8WsVZRipi3xwOAgaE0okjBApkgJeTrwRjj6tZOoz77QKs4AVwirUTOIZ4sHgfh2awNQB4A0hNpmwYp4f02VSxDnIJ29BBvMacrDR2s9y2U6Cn0wqlXVs2gpSUMASdCpw347PHIsU4hngJFvSuy6DuK5rgRUlwQpmMVUB0A4xiSyZCJeejMrrzogobACYPBh4+3t5XRFJlu5llApNy/u7r5GIgsg8q8DvHTdHmExIqOpsBirM7hgSkmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 13:57:58 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 13:57:58 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 25 May 2026 22:57:22 +0900
Subject: [PATCH v5 04/22] gpu: nova-core: vbios: read BitToken using FromBytes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-fix-vbios-v5-4-e5e455251537@nvidia.com>
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
X-ClientProxiedBy: TYXPR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:403:a::21) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA1PR12MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: f059ace5-404c-49cf-f20b-08deba65a0ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|18002099003|56012099003|22082099003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: dgm0hYdbF1KwOiiUTZYZkY3i6SwDSYRB1qaJZLTkbbJLwDXScbhVgOpLbFSEv//2VtWJmml5qPWrm7tvhD+coL49uL+tliN0UB4BshDHENg5uC4uiOt3t3H2b23LzwHv7KqrW+OKvqG2VgXjU17vjLwuOwEoJbcZa8FvIXOKYO0SNawYR8PczAEXeJnMNvR4dMgX+HfcByDlABC3imjLiBLApq+CrONpgde0oOQ9EbKK6WBdHn6Hbiip9lXQOwBHNi8HEt8HR28+vs1X+Iy+h6YoVZwskK8GmSBs3LB50qJ6NIV9+Q5sYaZeqRVwnzMyxg/CT6MD64dkN0DO0HV1ePZQuKOeTU6cmJ6kwvgjd9BmCqjcusfXyKRYJIAnVF0ei9RjtR7YtMxXGb4vKUHPsf117qMQur0Ipgco0ghRgSocM4tab0mnH/B2C1Y+rRcDAGGCYT/M90DOtj/1UTLg3OiQmFJL7nDl9DK1U+BoASURl6ti+yCgdjC4/Sttz7gNhIBA4AQKeD+Ugpy4LXOgdSHVYMlOVYeD2phXlUowJ8DwL6EuB/xjitFQWepbZvcgald7k+KjWxQy6WLCPFO8wpasSkFPZtXrgmBYYsQygWIUTgqZ65fGYiGicpE8YdKcb5J2q47K+M/+r5VhZetG4HIIvrxYbHg782T3r9tEl5EpYHvsVjB9bUtixmpj8wBL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(18002099003)(56012099003)(22082099003)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXE2UEg1NFU4Z3I3SU95UTd2SlFiL2dJV0VhTDRaK1FOQ25GWlBNQnk1cStM?=
 =?utf-8?B?dFp6bGUxSVlFeitiOUlYMDEvbmI5RjYzMDFPQ0hLNVlYN2tPVi9rWjdrdmpX?=
 =?utf-8?B?SUtDSVY0M0JCTU02KzdSNWZjRVdlOUhLYmpGdXIzclZSUjIzSDFsTEpQN2E4?=
 =?utf-8?B?Zm54WEg0bmN3STFrUXgyZUp4ZmZodDlPN3BwQmdPVkk0dkxxY2RDbGNzSXU3?=
 =?utf-8?B?aytMN0x4dHdhUWUzODU3SjlzWnlHS1VWZTNmN0FUdTROanVOYjBJOHRyaU4z?=
 =?utf-8?B?V2hsdFlxN1dDc2diakExUVhjRHpXN2k0RFZKcUJWVXIyRVJ1Z1BDcHR1SHpr?=
 =?utf-8?B?L01GVjI3MnpXdW9SRitKcDJQaGlma3lqNFpvRGhWMGRNTy9tNmwwMEhQSktz?=
 =?utf-8?B?K1o1L0Y3VzVRWEo0MHlKMjQwQTA1ZUhDWksyVHExTUhXT2s2ekI1c0p5YUhN?=
 =?utf-8?B?QVA5MGJQa2d6djRZVG5tQWZHQmR6anh1K1hldmlHQlZ6VDY0dHYwMXY5ckNU?=
 =?utf-8?B?TWJscWZKRm1mVWFQTHF5N1hvTGdDM24vM3Azcm1wdUtsMXdVbEc0TUVDK2dD?=
 =?utf-8?B?dHk4WU5zUlZJTVN6NjhTaGpXVDE5T3ExY1hTTW5ldnNTVFdzRDRMZzNmRXFM?=
 =?utf-8?B?ekZWSW1QS0lHOHY0TUxIbkNCS0tDL3V1TGx0d1hhRkRESGhoQmtJVHl4cHBn?=
 =?utf-8?B?MVdYOGRCMWhaMzZDUFVEMElwM0hhQ0t5MG8xN1U0Q2lLWGxBTjdwYTVvVnN1?=
 =?utf-8?B?bC92REFTTmZXanArU21xMGVOVlRMQ0liU1BseStuRDVyeVRITnRBVzNPS1kz?=
 =?utf-8?B?UGU4MlMvam52WGdyc3gwODBuZXBLNW96bnZuUUkxTm54TlNHQlFwZC9pY0FM?=
 =?utf-8?B?K3NXNDg2WUsxalcyaXJBWU1oNTIyMXZnNDBmZkQ4QjlSL0tqaE55ZDdsbXBC?=
 =?utf-8?B?VXhnVW9EcUgyOWNFNWVVUzdJY3UxSVU4bVRBSTNrWXlmUFNvVTJNNiswdFV1?=
 =?utf-8?B?Z0Q1d0JRNXptMEVKa2E5TGlEbGRhSVE4emNnWVo4ejd4Q2pPaFJrQjM0cVJs?=
 =?utf-8?B?MjJ0WjlwNTdDS1lJOTcxNitVTzdKRkZyRnNvUWp0VHNKQ3VWSG5hMTI0QlJi?=
 =?utf-8?B?Tm40b0NHdmNIaWRhV1RRZTZQd3RGdjA3Ykp1L0ZONzB2UmtqajFpc0dzUnov?=
 =?utf-8?B?QzZzZCtPV0Vlck9CWDU3MFJBNjIxVVE3cHJoeVVCSXlGYjhDVHlWeHFpd2Ex?=
 =?utf-8?B?RTlCREdQUnQrMjVISEhUMXIyZzJMSkQrR2ZIejhyNldnbXJsZzE0MkdqTWxW?=
 =?utf-8?B?bmlYMjdtcWQ1RGZYTUc0MEM4TitUelB1c255TXpPRWo5KzNsL0ZZN1RrVDhl?=
 =?utf-8?B?L085YVBjUlRhUHJWVXl6OFFvZG9zczJGNkdrYTIxUE5XQTNRK0NLV1d6ZzJh?=
 =?utf-8?B?MXZWU3loR1cwb0lseEVYOTZTU2cySDhac21BZk85NDNSQkJuL3AxekhVTU9t?=
 =?utf-8?B?VFJDRFp1TlM1OUZ3eUJEK1FPSk9ad0pHbVF0dG94VFcyc1NoZkhydzJ0VG1L?=
 =?utf-8?B?a0ttbmtWRmx5ZVF4Q3JmREJNeVBITytXYTBWT0wrV1VZUVRJa1piYVYvajhZ?=
 =?utf-8?B?MTFMZWdUcXF0L3hzaytEd3pxN0twMjRhdTd0UUdPQ2VFUktMSytBYnZSSjFy?=
 =?utf-8?B?Qjc3Tjg3L3NyYkdhcWd5TEN6d3lzMHF5SFBEVkdjdjJJWnh4QmdRZlprV2Rq?=
 =?utf-8?B?SnkreDJyNUY1djJBNXZMZTBZQWsvY1hwaTNTdUJZYnZJL0YyT0JZcnRpSDhu?=
 =?utf-8?B?YnkyM3cvb0I0M3VsV1FTTXdOd0w3VkZjbFRjbm0vbzhYRTBORzdrblBid0hL?=
 =?utf-8?B?Yjl5UVlTWGl4bHhjdmEvTytVMHFwU1BySmtydXdmM3Nqam5LSU5KRlE0QW9H?=
 =?utf-8?B?bm5Sby9lRFpsbTdyVE9Hd0F3cHFSdTRMVWJEWGxFbVMyeTNLc29MNXFsR0lL?=
 =?utf-8?B?OTI4SkRlMzFkTDliWTk5WHVyWnljUitCQnJjQ0RYTjdxQkxFQlprM0hXQXMz?=
 =?utf-8?B?WCt0NVpJTlBXa3BTMUlMdllmMGdVa1JIV1BkVFdNUmxyWGRaNEFWQWlyS3Nv?=
 =?utf-8?B?Q1JYTTRtNmRsV3pLa3AybFE1N0xLQ3Nidit0Q0xhSVUwbVZEVDRtRC9PMmc0?=
 =?utf-8?B?ZlBTQlRRUGJOL29KQXV2cHRxZkJvOWlCUTRmQ1FlcUNpaGRrT0ZrY0FvM0w5?=
 =?utf-8?B?aHNnLzlVZndiN0lxWHNxUkszdlZJR2x5eURScWZhTkhCWWZMSnhnUkhTek9W?=
 =?utf-8?B?bUpML1pDRGo0Y0RCbnVDWEM1ZEtOOEFkb3RYZWVsMWVmN1NpZmxNalZHZVZ6?=
 =?utf-8?Q?i/YFfRjVuzvljM8oOv8JEtP+ITi0xoUGLDm8R0oEl0ryl?=
X-MS-Exchange-AntiSpam-MessageData-1: 3AwCRwuGDH+6yQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f059ace5-404c-49cf-f20b-08deba65a0ea
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:57:58.8607 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MfHHgcjz5OqcJxbIWWKo3ZVYl7xd6mUB3rzo/RikKv6uDgiIqyyp4fuAk9HuQEVqkK5ByJCLkEhNI5CUg6vY0w==
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

If `header.token_size` is smaller than `BitToken`, then we currently can
read past the end of `image.base.data`. Use checked arithmetic for
computing offsets and simplify reading it in using `FromBytes`.

Fixes: dc70c6ae2441 ("gpu: nova-core: vbios: Add support to look up PMU table in FWSEC")
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 79eb01dabc6f..2ff67273fdff 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -486,7 +486,7 @@ fn new(data: &[u8]) -> Result<Self> {
 
 /// BIT Token Entry: Records in the BIT table followed by the BIT header.
 #[derive(Debug, Clone, Copy)]
-#[expect(dead_code)]
+#[repr(C)]
 struct BitToken {
     /// 00h: Token identifier
     id: u8,
@@ -498,6 +498,9 @@ struct BitToken {
     data_offset: u16,
 }
 
+// SAFETY: all bit patterns are valid for `BitToken`.
+unsafe impl FromBytes for BitToken {}
+
 // Define the token ID for the Falcon data
 const BIT_TOKEN_ID_FALCON_DATA: u8 = 0x70;
 
@@ -505,32 +508,28 @@ impl BitToken {
     /// Find a BIT token entry by BIT ID in a PciAtBiosImage
     fn from_id(image: &PciAtBiosImage, token_id: u8) -> Result<Self> {
         let header = &image.bit_header;
+        let entry_size = usize::from(header.token_size);
 
         // Offset to the first token entry
         let tokens_start = image.bit_offset + usize::from(header.header_size);
 
         for i in 0..usize::from(header.token_entries) {
-            let entry_offset = tokens_start + (i * usize::from(header.token_size));
+            let entry_offset = i
+                .checked_mul(entry_size)
+                .and_then(|offset| tokens_start.checked_add(offset))
+                .ok_or(EINVAL)?;
+            let entry = image
+                .base
+                .data
+                .get(entry_offset..)
+                .and_then(|data| data.get(..entry_size))
+                .ok_or(EINVAL)?;
 
-            // Make sure we don't go out of bounds
-            if entry_offset + usize::from(header.token_size) > image.base.data.len() {
-                return Err(EINVAL);
-            }
+            let (token, _) = BitToken::from_bytes_copy_prefix(entry).ok_or(EINVAL)?;
 
             // Check if this token has the requested ID
-            if image.base.data[entry_offset] == token_id {
-                return Ok(BitToken {
-                    id: image.base.data[entry_offset],
-                    data_version: image.base.data[entry_offset + 1],
-                    data_size: u16::from_le_bytes([
-                        image.base.data[entry_offset + 2],
-                        image.base.data[entry_offset + 3],
-                    ]),
-                    data_offset: u16::from_le_bytes([
-                        image.base.data[entry_offset + 4],
-                        image.base.data[entry_offset + 5],
-                    ]),
-                });
+            if token.id == token_id {
+                return Ok(token);
             }
         }
 

-- 
2.54.0

