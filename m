Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E966DCD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 02:56:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6144010EA1D;
	Tue, 19 May 2026 02:56:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="NFUP6PFk";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012041.outbound.protection.outlook.com [52.101.53.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 403FF10EA1D
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 02:56:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MmcOa4w9K1c+IECj2E7QeAopp9Uf4U3EMpQ8XtWaRyVp/An2l8D+h0g9wIKhXUo1Ru5XoUv6HdWcmhn4RpJXBaGwBN8Iivkk6FcWa47YypzU6zmRNMlDhV92vC6dusePJcHWAfrNylBnWtlsHkX2B/SiGoIXVK1jJVYbPbpSGTc1+3vqTYMMyrzsrvWjOXazfvy3dtLe7cjuquvJp/s/fpmntDfaRjTRROvPk0YRVhtf2tiOjZmY/pHCDgrsTpXVv3gxZhYXYr2ZPy+cbd999a395H0rgo8uctorSV+Kmp8hW6ZoV+LWCjRS+i6ln24w4hq9S5Sww5zvSqbakS8xig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uMsPIQCu/JHYxpRM1YyfRV5WveX/lrksBJJo2QpfJv4=;
 b=BRWQtdh0gpT5xt2ITxdiDBnbcWbRcBY+P40MJpsEFtdr4FeiqnT6ZU0KCluQZoIuHfhKQPmv6s6s1d/sk87quGPysq13POQA8sI2F3Fy7o7QIhugkYvu7bd7jbf61VCJ+wN12yQFq+6FSMS8cJqurkYBIWkwcvf0BuAT1qzXXb4mDHEQtDO2kiJBxP3Xfqz4EEW14jLaIGce+KIVwrwDlMcrKXPnKmNJ8QNGTwh1JN2Yvy4DQjwq9ehXJEmJFNTY1CcnmMYedkHSnXHQXyOcSSDBX7OMyqxNmOMo+MqDoUSlSjD6ikA2jz4YD866o+cFyYHOrhZEwvhD3nSh2aTLYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMsPIQCu/JHYxpRM1YyfRV5WveX/lrksBJJo2QpfJv4=;
 b=NFUP6PFkLdsLHpurq6fnZKZZtYEYnQPu8Zp6tscFGAdqC0ETyjmzeCjQH/yuI8t3+E5fotJsdEMjcg4W9yMIpqFAwiD2VREPfGk9dImkQyGQHNvDTDB9v42UsJTZOolo2rv18S4hc1fRZVWlX9gJYK++59iqXz5MGnLSRSb7yBAB3CuemTyMQSNa6elKunqCL4e3XIDPyDnAKbr7pdT/xxsB3grCJqINyJkRM/IZLvRcJqrWkJebuy6uN002ErYSx74VZK4HIJcFzMq8T/JKSYnLrcLM7uSjf0Re6eVxB/qFlrytDGTcd0Yd64aHIOZl086670tAPWH9QVQTbdEkKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 02:56:02 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 02:56:02 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 19 May 2026 11:54:58 +0900
Subject: [PATCH v4 04/20] gpu: nova-core: vbios: read BitToken using FromBytes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-fix-vbios-v4-4-5d3f210c5602@nvidia.com>
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
X-ClientProxiedBy: TY4P301CA0098.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::18) To SN1PR12MB2368.namprd12.prod.outlook.com
 (2603:10b6:802:32::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: 68eb54bd-095c-4df5-cb9b-08deb5522990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: bXKSJIvcCnGHMm31/2b7Z9ni/VSYIbJ8QNsiHt40zPTLjnoRW/c1v3iATV5yGN8w/3ETafLPXBBLOuA6SftNLFkH7KGJ2cPBGzWE6cekyW+wJQKrpBPDaz1iHvkCsiuRqNGodjb+cUdJAJiRLY8Kg1UTZDhLRU8XpgnUIg8aJFFJInwSwm38+n+3IEXi9pCETAckB4bx+uewISmT1eE8X2u0Rix07bRKZixHqYaduHJ47aYJJ5tT2rRn/zgpOxh3gDmPc7le3Mrhpd+e8L5MWiaOxO1BqUP2qYWEOwdJZqY6QmSc3cnYkfmtXigAUg8bpGyqHx7Ng7F/KmSvfcG6VQLJ7D21VNIfcyIN41G47vevf2z7b7GRtjvn1L0EF1n1IlA5BbNktlJm4u5NW0AHf5Dn03l8YmItzvhodFcn7BpnBOPCCm6IR+l03s0NTl0V9DDOLyWOW6cqEcfKRisYU6CnM1Wp1b2Q6hcWayj4L8ETf0AZiwQpPnLwrVRVT31kBjJg2G8vNTeY+5QcjbjEkowd15UqrBBBe13dr8BXv4HaGWf6L3RRuYkMANcdcCE8p7PjBkPq/MP2mhkjSbn0y8s0Z431RpFrR3pO+FuekpTh8izoPJGEWYujP5viRP3eoQvzCInvIODO/fRMxsWM7vTkwfKZsNFPameObyDB5F7yg7VYUNO1ebhV5y4lxfxy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Umk3UFM1WmpRZDNXYm9LdFdrYk1Vc2xhWTR3U3hnZzdlRW4wNlNnRFg4Yis3?=
 =?utf-8?B?Mkl5UVBiZTBNUkUyQ1Yrb1ZpNWpUZzAzOVVXcnVXRm4ydWUzT3MyUFNseWJ5?=
 =?utf-8?B?Y0dzZzVFT2VkcWI0aUtHa1dyU1pTQ3prVmxnNUZqb1FVTDhNSW5JN0t6dFhQ?=
 =?utf-8?B?M1IybTM1YS9qY291VysyZ2pvdzNPSWpZZGVPZk1ZK3lsR1ExVmRLVm50a0I4?=
 =?utf-8?B?MGdyUUF6djRUeDU4YXRmOUFpSDd2WEZMNURPbnA1NnB5dTR6ZnJsODVtbFBh?=
 =?utf-8?B?bDUyakpDeFRLU2h0VFJJNnF5NFhobDI5SDBEd1ZlbExEOXR0SUZTeXNaNTdz?=
 =?utf-8?B?c0hYVTIwUTRsSGxFcVgxTFdmR2dJaW9qaFpEekQ5SG1FK2U3b2ZZaFFmd2lj?=
 =?utf-8?B?dFRJRGRjVmY3aUxWUlRpOGMyMDcwQlpzQnZvaTdFenhMcWo3U1F6NlF2OURR?=
 =?utf-8?B?Ym5wZHYyZ0x1MllkRnFsRjY2OVlyMXovdU1EYXJiSm1tY2luNFAraUI1T21X?=
 =?utf-8?B?NFJNSnNSb0VXaFFld1NLUmRFdEY4MHBTeExHRmxGRld1V2RiYU44WUVObEhp?=
 =?utf-8?B?U25QeDBjcS9sTFV6blRMbmVTdGJvcXEzdCtsNGplTDExUGd4dzRuckZBdkRw?=
 =?utf-8?B?UjBtMXVnZUw0TzJML1k4UStlN28rc2hhdUN5K0xTTWJ6Mk1JV09UcWdPb2xj?=
 =?utf-8?B?N2w1b05MMDE0N1BndTR1aVRnRDlmLy8zQzJsZFZIY290UGRqY3NaWmNvdGVN?=
 =?utf-8?B?ZmZwdndEZENUL3FpZEk5ZHJQUFRucXRsSHVoWW5QNEoyM0tsZWh4azlxZjhq?=
 =?utf-8?B?RnpkUmZMTUhnYnJaQVd0UmJ5VitrT0xLU3QzeGVqVGwyMmZ2bVd6STNtNVZr?=
 =?utf-8?B?UE5jTUNQVGN5M2d6M1NUVHJ6L1pqK3h4dWlObmViQVczZlpQSU1TZWgwQmdv?=
 =?utf-8?B?ZWRXSTQwMUFsOHRqUFlGOTJ6S0ZseWpxKytnWnliZHlleGNSN28wRmdHUDdj?=
 =?utf-8?B?V2hGSmNQRWFZQThBdXdvQnVoQjhBY0xUS055SlM1Wlp4UFk0TkxjVCtleE5n?=
 =?utf-8?B?NXRBYzNrUUxHc0QxMDBVd1FDUDVJY0d0SStrZnZjb0JtOGkvZ3VjT1RZVlE1?=
 =?utf-8?B?K1dwTlMwYWxlQ1FKSG94Qk1hOUhCcnlmREZUU2JBOTJLS080czhlWEhCR3Fa?=
 =?utf-8?B?V1dzSmlTYU1rZ09CUjdCYVJscHZ4TVN4SHZPb3JOdEtqOSs1ZUxFUkVibEk3?=
 =?utf-8?B?N3YzMDc5NGtPRUFCNGVKMUV4U005NlIrSGNCdXpDK3JNZkxPTzdid2dlQkdW?=
 =?utf-8?B?WVpPbHhpMXJvZTJkMjJsL1RiN1hETWlRU00vNFlPQWoxWkZ4c1UxSVhkR29H?=
 =?utf-8?B?NzdFaWNQckxSdXVWaHErdDlCVEZ5YTU5MWtrQXNBSWhzbXk2OHorRFRsTW9U?=
 =?utf-8?B?ZUlnUGY5ajBlK3RWRk1vRUJRNDBNQVQ3cnlEV1hqbUw5NUEzK3VOV3dQL3dQ?=
 =?utf-8?B?WXQ4c2RhRW9lUGdGK2N5d2JtV3pOYlRyZkZWekVTazNvcTVxSnp5R05Uei8x?=
 =?utf-8?B?NXN3bG9qMlY0bmNUbVpIVU9hQUFsZmkwQmRXOHRPYlBBYjZVR0ZNa0VBODFU?=
 =?utf-8?B?OXZuQVJPazY0d3pXN1JzTTdPcng2amVBVUlNT3dDcVVyZGdkanV4NzFxVFRD?=
 =?utf-8?B?L0MyVlZaK2E2OTQrYUZsTS9CQ01xN1o5UTV6eWRldWNYT2J1NEszcGlCSXhi?=
 =?utf-8?B?S1cvcFZvemt4UWVtZ01hbEszOW9xQ05ia3V6aTBUNlJHcVhlQTJmZXhRa0l6?=
 =?utf-8?B?UFcvTmpTeVBmSWU2WmZyWElrT0t0eVYvNmtRa1ljMmxFRitYVlh1OWM2d3ZL?=
 =?utf-8?B?ZFhFNkd4alA1N1hkYldWZ3dvR0ZQRkVmc1dnM1BhV0dWUGxqa2M1bUxNWXA0?=
 =?utf-8?B?NTJmL3VNY0VvQ3V4elBvdUQ5RCtkTWhXMFdPYXl5cWhlUDlPb1NaWWF1eXVK?=
 =?utf-8?B?NjZTL0pURlQyNU45TFIvY2R0NXV3QUFOM0pBdjBJdHdKR1ZLTHdHWmtFdUli?=
 =?utf-8?B?R2poM1VXY0JRZWpZVWEvWkd2WHFZWGJjK09ISFMvelRUcVYwaFp5SGdIUVYv?=
 =?utf-8?B?NGRtSHlEMm1aZzIrTFhCd3JwM3NqbzBjMG05SlpySTdoQjlpZmh2Mm1kaUEv?=
 =?utf-8?B?MkFjU3piVDJiTjNNUk4wRE43UHZDNmxXSlUzVFlTRE9zRXJZOVpVQ2FBdWEw?=
 =?utf-8?B?UDZMNkZIMzNsWGNiQ09BSU5KNjd2ZnRFTU9SUFlIOTRHeVhUaEpITWpxY3Y1?=
 =?utf-8?B?WXZ4bkRpaEFjKzBrSUpaUk5JME5PMUNjVkd3MXBBUDhoZHdNdUw1TDFCanZB?=
 =?utf-8?Q?Bm8vDqjuSa4+N5Cj5g4lXr9gWHBgXB8+JSWvHYe889X5Q?=
X-MS-Exchange-AntiSpam-MessageData-1: Uy6FXrW13EIzRA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68eb54bd-095c-4df5-cb9b-08deb5522990
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 02:56:02.7387 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P7s8dlHwfnWlDhJIRBNbaGRVUo7uhm92jbVk2bPA+5yXIaBBuaiebv+Dtic0T2Mh8010mDwzgkSVmhklQRBjcQ==
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

If `header.token_size` is smaller than `BitToken`, then we currently can
read past the end of `image.base.data`. Use checked arithmetic for
computing offsets and simplify reading it in using `FromBytes`.

Fixes: dc70c6ae2441 ("gpu: nova-core: vbios: Add support to look up PMU table in FWSEC")
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

