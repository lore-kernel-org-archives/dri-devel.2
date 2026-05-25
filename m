Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6490CD5BC9
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 13:58:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63ED010E387;
	Mon, 25 May 2026 13:58:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="DQNsNuzb";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010003.outbound.protection.outlook.com [52.101.201.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D58F10E387
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:58:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZGl5q2jLKMbzWq++UyYMRcTP+i3JpnnVgGb8F9B57gmEH+IxnpOnLVV7FBicFY9DmtkqImOOdo1CbomJHywWPa8Q1FIYUoofy6HkS6X5BdqH1ogUf466Dix4xqg2qWXK8++Jkapv1UsNIz334Rc0STIc1EWAgAnaUhQZ7HXD0yCnnde30M1gXM7DA7KodHvKXyFfdCl7s6qYFRfdY9N/3/pQUJ/k9oO2jL5xoQbu+r4uGP3Zj1Kq1H6GuoJkBu8tCN2fqU/fdqURU4sHL3ky0DxEdIVMxUetFksio8lUCMi/EShO0g2nX+poD6bP7dRrHJ2eXM0dYtfmuM5E8aiUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5Dw4H1jc7BfXPVxDG2BXsI9VqdihIuBtz3y9bBPnlQ=;
 b=k5LE1bU4FlGRahEWK1yaZ7cKsLYSLAbCqezj9o4uF/qy/eWxvnSPCasrXtnx/UM1VPFhpe+HhsdqLRMuPlzTkI/8mRua/bmvd5gVIxUQZk8LmaX8qwISx8l0bQUoCXLXCDwZQjRSHp+enERSNswGvbU+6bLDGSrGsLZNvfBNAqnNjYb/e2jMYkkFzsDXvomycxM8IErWWJqn1gVhsKp5aV+xyGmx3CmqjgHjvGtxa+Bs/1Wt54xxGqTMTyCuIkUQHJ4Gkc6g2/P/fESRlgg6Fzy4J4mJnLhhx39aOgiuiZISBxYAoKxMY5K+xBHJbmaejyk2lp1T1IJsLZAGzWfarw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5Dw4H1jc7BfXPVxDG2BXsI9VqdihIuBtz3y9bBPnlQ=;
 b=DQNsNuzbMp+2iZflzG1UH1DcBTYmGeZLJMFxDw84lbSgsHh+1DDb7Zy0wpoArz5n02NUsnTdH7HG/TSQG2cD0VfHeP9iiQA3cmzaoBCG/l9fSbMYl0yClLlxvHfhfY/U+QyzOWRJN1j2EZp3hNF3g37DySU+VaT64+12kRlboB1LGhMx+9KhFP0lnqOztjafpGgXLS5t1xA5gfcv3veplsnMveMpB/xF0mJx/bWfFjAIyhcTMCQ08oPW9vFnxUu4RHpx37rLLpKYbBWY7ZKh/gukL9pD6OAGW5sn0KnbY+O82gEdKZC/5PfCjIHw35hq/Qe+3ofYFdFbnUJaaz63Fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 13:58:39 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 13:58:39 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 25 May 2026 22:57:31 +0900
Subject: [PATCH v5 13/22] gpu: nova-core: vbios: store PMU lookup entries
 in a KVVec
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-fix-vbios-v5-13-e5e455251537@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0115.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::19) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA1PR12MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: 3904c5c3-1a88-41be-fe62-08deba65b90c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: HCYmXInW44n4MKBQbq125nvQBS5zBtDLd06sLplolQh8pQjaLSXSUXRb+eMGn4nIn6qfoUV4G9T9aQk2a0+gYcftp9Zh9lTUJM60zqQ1B6jIGH3y1UBo/wn9k0Lj0d92GIbfTu0ZHgWsj7348fcUoyegDZKmdj4qJkSpSY+tC4M+tZn4sHQCd2HxKJ7oiRQEI4/hS0qz77Qlqr7hJMFxaiUgEtqNtXpi+Xgz/ozWt4c57J7IECUP2PbOCnuazDMNzfIeM6TDtD5KZQBouqVCkjo71ipF7v/6qIeN7A2U3LN//EnwvCuvRjcdDbhbfhycVntaTAcb/0F5sGM9NgsP2ZSUNb+D6uOhcfr7h6CygYg8UToN9CYU5GPfp7B2hYR4ffsKq8+2xly1L3pBHKP0LIu777BeumaJHPkUlwUA/e4I39UAbNNtWzrkrnnFT1jGcY+j1Xt1CL447oVA9xqSflDSbmn7UOnUYHP9R4lEv/3hzYA1RPYFVFTfX/B5RgoS7SFMI+boN0e8hxQrD68VobKIIK7LpzO+xQVu2JzP6VnEfX3o3BatvCJL8R7D23RHAwV+qWCP5pb+o0TNkPjMbqxEpD7/XGJ9e2Zh21YvqJ7Sjr0XQjZEYzt1A+suYrFxmR6s3yuL3yZShQwO51jsIku/6YShLXl8Uz4SZr1atdZF/xgaXkv8Ig5cNLPtQ0Wt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(18002099003)(56012099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlFZQnQ4UmhGR3M0ZW4wSnR6RDdIc0srZ3R1alRCbmN2empHT3BaNW54VGZo?=
 =?utf-8?B?OWlzNWNFcFg4YjVYRDNwNGZrMW93Q01sVlhHc1ZKdVZScHJXRzhyaVpYbnI3?=
 =?utf-8?B?dXFjUU16V2JMOStnM1o0MCszL2o5VFdMWjVjMXVZRmViMlpvaGNHQkYwQ3By?=
 =?utf-8?B?Wml1eXlmN1RvdUFrL3VDdi94ZE93Yno0NkRiQi8wNThCemp0cDhYeW8rRVpF?=
 =?utf-8?B?Y1QxUi9PWE83M0kvUUE0OEdpNlFwZlhTZm9NVWdKVDE2ck5kb3hLQ3JvdG9U?=
 =?utf-8?B?L1dWREFlSkJMNjEwRFJKTTExVjBkYzJGV1djYzF5TnBvbk9wdDRtKzZlc0R5?=
 =?utf-8?B?UkJPdHU5R2NtUlZuUEw0cm1HRWdnTy94OTVPbUp2Z3JUZGxaODl0VkMrUFor?=
 =?utf-8?B?cWI5V3BiMU9XWGUzRFRKRTRONE9nWkdQcEtvVEl3bTFZNVpnTVZoRDdMSzBl?=
 =?utf-8?B?NzBhSi9tQzFsQzk3eEoySkZzc3pSMEFuMDdVeDBLeEY5SUE1OGhTRmwwZjJr?=
 =?utf-8?B?SXQ5ZFRDNE1jektrNUxsUXZtTnMyaENXVk5LSVVzVDRVeHhDeWNicy84ajJt?=
 =?utf-8?B?dFVQK3FVa2tNbXFaZXBHUG5MQlJRSnpOTFkvQ3NHb2h1SEdhRnlsVU5rOTFP?=
 =?utf-8?B?UnhHSU9VYWFEVG1FSVdSaTBPQW9UUjdNVVFXbHU3SlFYZGpCWDNkVXMrSXJ1?=
 =?utf-8?B?YW5uMG5rdFF3Qm14cVZ2V2JYTk5XVzJjTFpFaWtYRXVOMTd4ZGRSQVh5bmRK?=
 =?utf-8?B?aFdDNFdReDkyQ0VSQnV3NXVpZjJwVjRiRWNhZ3ZhVndYRjlJVnNhTDZSSU5H?=
 =?utf-8?B?ZzVsTWNqNkJ0K0VDM3BKcjYxMGxJSStqcEN6OG9ZMzhIbGk3ek16bjhoT3M4?=
 =?utf-8?B?TUIzU1FsZjBVVXZiSENEeFR5L2ZSRXlzR29hdzhYWjcrU3RDWDZFMjEvT1dy?=
 =?utf-8?B?TWptWFh1bkEwL0hWVHlsN2h1KzA0ODRFUUZ2RjlONC9VcTBoRThqRVdUTVhF?=
 =?utf-8?B?ME9hNmlGa0ZCdktreUNsTFJtV2c1QWVWR0xWTzhQZHFGZU9zY1g2eTZPMzB0?=
 =?utf-8?B?aDJ1MEtIVEEveW5hY3d0ZzlXL0hVb090RUxIckJYcUJhMlFaM2kvd3V6SnFX?=
 =?utf-8?B?MFBwb3oyMjFGb3B5WHlMMDRNWGFjUStXN2R0WTErZ2ZDU0ZubWo3TTJ0SVFk?=
 =?utf-8?B?Tk5aQnBVbmlPMGRtNFlVRmFEL29EYWxrZW1RUVFhRHI2d3VFS2RDbHlma0F5?=
 =?utf-8?B?dmk5ck01Mm1WRUZOMmtxTGlMV0ozeklYMlpNOTBXalR6UklyYWJHMTdsc2NN?=
 =?utf-8?B?Wnp3amVVUG5FT1d5NjdkQlhWMVhoTWowdXdNdjVXQUZKUE04Y29QY0hPSWMr?=
 =?utf-8?B?TTN1amlPWVJOc1crNXh5YWtHYUhuaGxRMGJwUnpXc3o4NWVpL0dhd2F5TXIw?=
 =?utf-8?B?NnFqeEVFMnY2VzgvSzFQY00rckU1bUhFbGtXaENQL0lHQ0hTc2lYUDZ6alhN?=
 =?utf-8?B?UDZyUFFZWVVIZnZRQk1Md0I4RXZRNFRPYU5mRGp2NlRqazh2OHZnUWVyajg4?=
 =?utf-8?B?aWRrbGlkSGZTUHUveFdpSDNwZ2pZLy9XMytHbUtSYlMzd0xlWU1mQTNMQjFC?=
 =?utf-8?B?RlZHNml3SDNzN2FCcjNYd3QraUx6cmtYeFJZcEM5WGwwSkg1ZWVGODQ2RFVX?=
 =?utf-8?B?MGJtbWVockVmZm1VVjVWR3RBaitzUFdNbnRJSHAzNWcvbVZveFZ2OUJQS0ZJ?=
 =?utf-8?B?QTliMHJVMGlQRldzYVMwdkpjOC9HUG1sTHFFQUplOEpIVXFmV2RXQUJIT2JO?=
 =?utf-8?B?ckNPUk9SaG05WGlXZjl0SEljZTBGSGtMUHZBc3JXbnVoWDN6WFZIVldDS1dI?=
 =?utf-8?B?RFhFNFV6YmhKUmN3RExybldpa2wzcG9WQW1hV2FTc09SZnFBbGxmVVVoUEdF?=
 =?utf-8?B?TEd4czZiWER4ZWJzZWVGRllCRnNGaFlVU29McmlpTnkwUHlBRWdJS2ZLYUZL?=
 =?utf-8?B?VHZ0ZlM2eHBkV245aVYxYnlIckFqQmNJdTRQWEhXdm1JYUJwN2JXN202U2hQ?=
 =?utf-8?B?TWMrTHRla0ZWL253M295ZG1Va2pGVkV0SThSWFZsL2d1R3lVdEM4R08zRE54?=
 =?utf-8?B?ZGRQYXVMdTNjVXFGTUp1bEpSRmV0S0YzSVA4SVdtSWNCL2FzL2poQ1hNdTB6?=
 =?utf-8?B?ZW1xWGs2ZGsrQWFySTAvZ1dRaU9IY1Z6RGY2U1ZDL1NNMUxTTGl2Uk13NTJH?=
 =?utf-8?B?bHRjRk9LeEtvNGVpQitGbitONGhLa3VNYWpNay8vK05NZXE0U0Y2V1FQQmdP?=
 =?utf-8?B?SHhaR2Z4V2RmUGVSSTlEaE9PZlpoU0VlSHNKSEtDMDRKK0wzVExYZjh6Q2pa?=
 =?utf-8?Q?IIl+w+Axfbijez/1iZr4PoPgm4OEWSshVn8C+mnfeA692?=
X-MS-Exchange-AntiSpam-MessageData-1: 4qIdvY8sR6S+Cw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3904c5c3-1a88-41be-fe62-08deba65b90c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:58:39.3281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s4MYJfQkVMczR/bNMAQCdPNyI2otEVlxrmn1tYdmfEAkja/0XMJbjS5s/UEM0iKwbVGVEtJ9rwJTdYzWsRQe7g==
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

The current code copies the data into a KVec and parses it on demand. We
can simplify the code by storing the parsed entries.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 56 ++++++++++++++----------------------------
 1 file changed, 18 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 987eb1948314..1ffaf0ef56a7 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -917,8 +917,7 @@ unsafe impl FromBytes for PmuLookupTableHeader {}
 /// The table of entries is pointed to by the falcon data pointer in the BIT table, and is used to
 /// locate the Falcon Ucode.
 struct PmuLookupTable {
-    header: PmuLookupTableHeader,
-    table_data: KVec<u8>,
+    entries: KVVec<PmuLookupTableEntry>,
 }
 
 impl PmuLookupTable {
@@ -929,48 +928,29 @@ fn new(dev: &device::Device, data: &[u8]) -> Result<Self> {
         let entry_len = usize::from(header.entry_len);
         let entry_count = usize::from(header.entry_count);
 
-        let required_bytes = header_len + (entry_count * entry_len);
+        let data = data
+            .get(header_len..header_len + entry_count * entry_len)
+            .ok_or(EINVAL)
+            .inspect_err(|_| {
+                dev_err!(dev, "PmuLookupTable data length less than required\n");
+            })?;
 
-        if data.len() < required_bytes {
-            dev_err!(dev, "PmuLookupTable data length less than required\n");
-            return Err(EINVAL);
+        let mut entries = KVVec::with_capacity(entry_count, GFP_KERNEL)?;
+        for i in 0..entry_count {
+            let (entry, _) = PmuLookupTableEntry::from_bytes_copy_prefix(&data[i * entry_len..])
+                .ok_or(EINVAL)?;
+            entries.push(entry, GFP_KERNEL)?;
         }
 
-        // Create a copy of only the table data
-        let table_data = {
-            let mut ret = KVec::new();
-            ret.extend_from_slice(&data[header_len..required_bytes], GFP_KERNEL)?;
-            ret
-        };
-
-        Ok(PmuLookupTable { header, table_data })
-    }
-
-    fn lookup_index(&self, idx: u8) -> Result<PmuLookupTableEntry> {
-        if idx >= self.header.entry_count {
-            return Err(EINVAL);
-        }
-
-        let index = (usize::from(idx)) * usize::from(self.header.entry_len);
-        let (entry, _) = self
-            .table_data
-            .get(index..)
-            .and_then(PmuLookupTableEntry::from_bytes_copy_prefix)
-            .ok_or(EINVAL)?;
-
-        Ok(entry)
+        Ok(PmuLookupTable { entries })
     }
 
     // find entry by type value
-    fn find_entry_by_type(&self, entry_type: u8) -> Result<PmuLookupTableEntry> {
-        for i in 0..self.header.entry_count {
-            let entry = self.lookup_index(i)?;
-            if entry.application_id == entry_type {
-                return Ok(entry);
-            }
-        }
-
-        Err(EINVAL)
+    fn find_entry_by_type(&self, entry_type: u8) -> Result<&PmuLookupTableEntry> {
+        self.entries
+            .iter()
+            .find(|entry| entry.application_id == entry_type)
+            .ok_or(EINVAL)
     }
 }
 

-- 
2.54.0

