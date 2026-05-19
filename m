Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD37CD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 02:56:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74E4910EA29;
	Tue, 19 May 2026 02:56:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="aBh76E/d";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013055.outbound.protection.outlook.com
 [40.93.201.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F331510EA27
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 02:56:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PmWywSqlf7q65nfLF8YzSbk3rQjffPLXlhwfEIqdEXCixTQ0pZOWwAULOKFC3hCghAzGopZ/Tsbg45cEpdET+Ngck0KGAV8eM1eIpExwcacRqlnjEDQvbZrmfzeWQqGhTnxkxiKxJRbDHw5xwtpKwGIJTJ/jXQGiDuG/j63LwcUxp07f9iXnQBXrey0RPSl0JmiMt1xhvveQiXdl6VO8sbmGPJHNdF2V9kwaDQFGPpbmpoVTFUqNmaZrIc4k9ETiPdfRYBZNHAL2PilsCknIrq66KyPf8zv+TOgKT/EDEsW/CECI9uIC4OVLt0M628aO5l5sOkIzHsx6cSWUZK5xUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brNkSIBTkhotVADSJ+tuRahs5m+yIuPheFS8GVaCZnQ=;
 b=m3J65Bv4E72vecQo5tPjP3Fmyyh+2gLqkg4APCG9wTR5131Wv7dPrGEUP+lLItwmIp00RSwN8lfxVI0Gu6hrjzUNBQkp1NMbndZoPLSYU2D3XP6bRZrNN02WYMl68ndJWivz3iGll0gEO+V2fIdQlU7/BagP4qEi7pqELZXcUQ6OQ3K14rqT0iN5ka8my91kgDgErOINK+KvpZfRb8md4/z73LCkHlgvkINpVJmZR0QQ51MMxCRBS+LDKKO9PZhwfJ6zbMeSjmPo3RtRbKhRP6NlznOZb6BHMrWoadMo7iAGv5PT3vaWr4ChTlCPE/7Waf0XwLB1u0B85hLbw1v6tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brNkSIBTkhotVADSJ+tuRahs5m+yIuPheFS8GVaCZnQ=;
 b=aBh76E/dSVhmq4jiqaxYomSx0rxAYl0v/KZQNPzs5obFloLWQM1DO4PMJa7q+OpVI+nu3Qqz/YchA+VpnZdw8X736/oGzUWkO3OfNigPtj7Q5+Z/z05jArrqI5aaLaOGaOR48TtpXOgBt7xcqLKmZXU2AP6uW8krDNgNDF0h+/nnfGbEK3pz655/vNSV2fxp+NjgVqWIzJWQjDoV1cEYnIplcV+BOtXPhYtGuKgLWz6yaOm27XMFW6X/uZXs2u8ZuopW9yJ5Q/yxicudvbxtZMSMAhLfSjpwiyWOccC5Wq6kqDz1G5Y7Ud2VqPGrj5InXGK+qY1Tadi/vBUxtynolw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 02:56:40 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 02:56:39 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 19 May 2026 11:55:06 +0900
Subject: [PATCH v4 12/20] gpu: nova-core: vbios: read PMU lookup entries
 using FromBytes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-fix-vbios-v4-12-5d3f210c5602@nvidia.com>
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
X-ClientProxiedBy: DS7PR03CA0169.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::24) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: efaf3b8d-fc71-4154-2040-08deb5523f73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: /kD+07EUb+iM1BPuefm0yjy5WK3+SY7KDJiwoXq/npXt9T96R5y7V8UOkB0MeLavgcwVQOnw3iKwYLVf8i5MVicm65OSkbQoNM705wBhzmMa8pJd2NClLTkOHDO0/ycf3xP5dCP/cr/08p0B0snWAFgHzZc10KBc2DZeSsSJt9mbhQdqRmj9xMFCJOSVhQfUpm3y1EsSugxjHXpI3VBN9C1t2Ce85BU/99+/1o/4I7isd/0uP5kFx6Rnd1sWpBzFF43cDT14M1I1n814c/Cr7YbQnnA9SvqtNBW9tK9qx2hRBmgiD6yaF1/HDFkzw0x1CiGnEcSavARvjtxPlGNexpkkUpQ/rtQ3wWIu1rZL9OYsVJDBjvQMixVpmVfHJfW1J8cF9XSvH6/fdRKtOl8/SAo4oC0glmzdeLTyMpLPtWQZxh1KWIz0vBPchh6ZvMRr5iF4nRBzOJjyV0wfTV2asEbj2WkRpPgP082YbM16jcHXPd0VXBUUwmNVgJs9mVjYPTdZ+Wx7BF6XdYmPuFbqRUAy7fopLkU1Ckn321caGMlrt4GmZKx9EVc2iZes2BCDSm0OhbvlNVBWPcDdmiH/14W5R6XJTsAIJI7Ea47f+fLJvKP/6Ory7VtzFdQW7jsAuTRtfej46sxuQ3+gbTH1NN/j3Ig7Th+tFpjOmhwSbRtgW4AwEPjk2bPulIn+P6IT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1ZJbWdLclkyVnAxbDVBZHo3UXBJSTNtTy9PMTlqK1hhbGcrcllEYlZPU0Rz?=
 =?utf-8?B?WHZxd1hEOVpOdktrdklVVDRNcHR6bVpyeWJUZTFDTmlGZE0vZ29PYTlQaitS?=
 =?utf-8?B?Wm1QbVowTUQ4ODZOc3lzZGZpTys2OEMxV1VPNjVJV28rVEtLdlNmR0l0aW5m?=
 =?utf-8?B?MHUrYmU2UTZpQVlIMCtVNGYvcmh3U1RVdFN4SGJxUDZEb0xPanZWSURIRStR?=
 =?utf-8?B?SUFOYkF1bVcxSEwzUVdHaFVFOWY4c2F2NUkweVRJUk5CaHRpTTNObEtPSkEv?=
 =?utf-8?B?Zk4zQ2FERXZ6R1pHRkhicW9WUmo2VXQyT3d6U1VoM3ZyQVZkNGc3dEpTZTBp?=
 =?utf-8?B?RFVqbUdFL091RjBZemt1MTYyOGRHMHF0SHdWd28wem1taVBrK1lJSUZwMjh1?=
 =?utf-8?B?bUk2VzRsMnVJRmI0c3lHbzgvUjFOQTRqR2kwd0Zsem5ucTlSVmJCMy9SY0ZX?=
 =?utf-8?B?a25OdllVaGR2SHdxM1BIVThCUFZ4QnYvVnBlODNEZ28vcHZ3N0FHR3l2WXYr?=
 =?utf-8?B?SEJNM2lqRS9NWTVBVWx4dnk4VzB5QUZ0emZZVHIxUE52S3M3bVNMcy9lamUx?=
 =?utf-8?B?RnhIcVF6NXozTFVEcXRkTXhpSnRmSDE0aVNIWC9LWmE1cjhzMUNQL0dOd2dj?=
 =?utf-8?B?WURIak9yOW5KZGp1cmFWZ2FNbmNXWnZFTVdveW1Hb2hQWERKdXdUWHdRbnlI?=
 =?utf-8?B?RnNGRE1CcUY0SmowYkxWbHRuOVVmQzQzdkJHZUU1R25ZZC8rSzIvOW1VVmx1?=
 =?utf-8?B?MlJhZjFlTHZrWHpsU0dMb0R2U0lPeEkwNEdtaEo1NWs0ak1GM2pabkpVWWQv?=
 =?utf-8?B?Mm5NcGlLUFl2dUJRRVlJUDl3cWlnY1dLQkk1djdsR1U0SEVwdGFCUXdzWkJq?=
 =?utf-8?B?bXN1dzk2ZGh6ZGRnb3VTUjRtTmxJakVZcDRTT2NEYXJVRTdXeS9SZUZ4Q29r?=
 =?utf-8?B?NWFEMHpTQVpPUG9sMy8vWHJ1djBxTlBmdjhmWk5nZSs4dCtLOVd3MWRzVFA4?=
 =?utf-8?B?L3VCUlJKeDNyZXArNEdWOHV6b2VtQ21SOG5aQnZwZkdFUjZ2Y0l5c1drNExy?=
 =?utf-8?B?bmdNeU11NFdwZFgzS2NPbUJmWVc1MGo4RlM1bVZ6bW9ZeStlN0NUMmZra1dG?=
 =?utf-8?B?NU1qclQyaHN4UHpmV21nOU12UDBUR3g1RVo1OXpxSWRqcTRYQ2taZm0wRXRH?=
 =?utf-8?B?VndLajd1NTljMlNrb1NqOEw5KzlnTEp6bFduVktrYTJuNmt4Mnp4a0RhaDVl?=
 =?utf-8?B?a2FUSXY0a3BNWlZpRlI1bGlpa2RQcWJFYlB4a3Q4cElLOTZjczNSWEQ3N1B4?=
 =?utf-8?B?dmMxMjVVMHl3L1FDaFpOR2lKQ3pKVDhVRGJtK2J5NFMxSG5xdmUya0xnTThC?=
 =?utf-8?B?NW80Rit1ZnA4T3lxZEZXY0FWZk9HOVM2bThocElUaW1icEN4VkdqTjFheTAr?=
 =?utf-8?B?WkhzbjZRbDErT1B3NWI0MGlJNVl4dDhFTmNhb3pvYjNIU0tydzRVQWp5aVdi?=
 =?utf-8?B?TWxUdUk1NGd5UjdkOUFmNHA3N3JCWGZKS09ZSjZ5WlAwNEh1QWxNblBrNUhp?=
 =?utf-8?B?Qy9FYUx6WFEvOWlEYStZWUJvL1BWdmF4ejhUNXdKTlhoeU8xeUpHZHpBN0VV?=
 =?utf-8?B?bzJ6M0NZOEdENkZlTXk4ZHVqQVY1ZjBLekhhcldmZlRBWkdPanQzVGxmTjMz?=
 =?utf-8?B?NFIvcFN0TUdzMXBSTHlyQUUvS3RBZXdFRGR0VDJnZ0VYcU9QNm4xeW9tZXVJ?=
 =?utf-8?B?dXVKYVdVQ2daTDAzTmd5SDZ1d1R3RDNSOGdKcVpjMmxGczB4NEhybHg3alM3?=
 =?utf-8?B?YXNrTkdOYWFhZ2t1bzJZNHJmeUl2NWZ2R3RFZE1TQW55cnBCeDk5RVQyWGJS?=
 =?utf-8?B?TmtuWStBbzQ1OFF6SzFhSXNRbjduUVBVK01XV081MWJVS01pVFJVYWlrZ3hj?=
 =?utf-8?B?eVA4N096OWZNQWI2dk5mNzRIZ1FneDBReUNxR0FsT3lGUEREM0VqeUlUcTFt?=
 =?utf-8?B?TW9oSXBZR2hDS2FwSktZRmdXOUhEZzdMMnorVkRpRE9OajlSUFByUXpUcXlY?=
 =?utf-8?B?Y3R0aFhYbmdaV3ZmSzc4dmV5QWRFVGZTU2M3SGQwdXZLZnZNTUFnRjh2ZGRF?=
 =?utf-8?B?S01tMkJrREhqVGx1Q1QxWm1INEFhZmZxVjU5THJMSjFGYWJZRW44L2VWRmZP?=
 =?utf-8?B?RXE2RE8ydFVtaHdSWnlRZUhVMlpLRTZQVmhXajUwS2VrQmRydFU4TVh1WnEw?=
 =?utf-8?B?RUZLTTZBK0VLWlBIeFB4N2hQUk1PZ0RneFI0dUJhNE4rQVJ3S2tBdXNsYVEv?=
 =?utf-8?B?U3VEcDZ5WFp4VllITWxDaDhjcUJ6TUVEM2FSQVJNY1k1d1V3WVR0c2VaaW01?=
 =?utf-8?Q?+MFyUE5f9iSMF9qOlOLvVoMBiy33yMekPC7Xh5vMoGQxx?=
X-MS-Exchange-AntiSpam-MessageData-1: dZ928mZ0ggH0Nw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efaf3b8d-fc71-4154-2040-08deb5523f73
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 02:56:39.0541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mAWMKNdSWJQFThIxyMNUEz95Bu6SoPUbImJpR7cwUlS4x3EXDvMCN1kfYHW9MlaCG+6fBJOMX/v9ZavAv4z6Ow==
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

This simplifies the construction of `PmuLookupTableEntry` and is
allowed now that the driver can assume it is little endian.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 470e0e2a81ab..987eb1948314 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -897,19 +897,8 @@ struct PmuLookupTableEntry {
     data: u32,
 }
 
-impl PmuLookupTableEntry {
-    fn new(data: &[u8]) -> Result<Self> {
-        if data.len() < core::mem::size_of::<Self>() {
-            return Err(EINVAL);
-        }
-
-        Ok(PmuLookupTableEntry {
-            application_id: data[0],
-            target_id: data[1],
-            data: u32::from_le_bytes(data[2..6].try_into().map_err(|_| EINVAL)?),
-        })
-    }
-}
+// SAFETY: all bit patterns are valid for `PmuLookupTableEntry`.
+unsafe impl FromBytes for PmuLookupTableEntry {}
 
 #[repr(C)]
 struct PmuLookupTableHeader {
@@ -963,7 +952,13 @@ fn lookup_index(&self, idx: u8) -> Result<PmuLookupTableEntry> {
         }
 
         let index = (usize::from(idx)) * usize::from(self.header.entry_len);
-        PmuLookupTableEntry::new(&self.table_data[index..])
+        let (entry, _) = self
+            .table_data
+            .get(index..)
+            .and_then(PmuLookupTableEntry::from_bytes_copy_prefix)
+            .ok_or(EINVAL)?;
+
+        Ok(entry)
     }
 
     // find entry by type value

-- 
2.54.0

