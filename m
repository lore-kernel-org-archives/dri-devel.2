Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E0DCD343F
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 02:56:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4153410EA27;
	Tue, 19 May 2026 02:56:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="rnUQc4s1";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013040.outbound.protection.outlook.com
 [40.93.201.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD88310EA27
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 02:56:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AgY/9/0DfTLay/TfD0lj6dEmeJ9tgWdTgPjfzSxpki0AOrSsmBzRioKWiEtgk9ViYrP2L3Izj1OSmLBvOUlD8SiCyK1On9ViqUT+J52gmIcmokTQibtYJ3yqrXRvAcPVXixiMV+FW99FOdLJ4aC3YW4FTZwbU3IJEzPaKrc1OhbQTVHcpEDXdnJUvvBd+7J18e125IZvhXMbcmgNvUJOxzex69/U5Y2HcgaWH0jy1iGbClnZV22LOFZPXvo8hqoSa4cIN8upjStooWpi1n9CNH1a3S8Gto83aDd4xCBYQKY/5Z+dr9sANbMdD+4tkyHlB0J1M37Cg7vu0EA1/THr3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEfa62HoTMZJSCetwgDtZT6HnrbtvzV7CBoii9s0FCc=;
 b=UIll69rJRpNmt9il9hW073hGNJ3Pci929AxjnHY2Cta8kjXPU8EJQTIf4o7vLcbJfmuJy8spbwUv6IDWU8CKNpje9T31krTIJRYOnID0+M/ONspl/cguMkk6vzgm8Of2XMr9CLQ+yIddZ77mvv22/19wJr2IiVGgzfv0FKqizgU5Lvoag+HWCZUuOFlMXXPnhdFlA9VXfcRdMSn7Kt3LJZlqqmN57nZEbdX8l5iZvGdbHGciwP1z941YAARngTs3m2WKg0Owygk5pOTpTw/tTM+e9CtmIIqM0eIoBGzltkS4AIBUuOnr7MCIOGLY+9ZBYIo8c0LBuocwIBS2D9JCoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEfa62HoTMZJSCetwgDtZT6HnrbtvzV7CBoii9s0FCc=;
 b=rnUQc4s1II9rc8AZhlNThMgAs5+ajPnqDLiJvfk0aE+o5Lou41Ueh0qkWWYTEWJ2yDWsr1BBKjAdSiXXhmI9ojcmn4iWpKjrBWz5oSL1HDR265QmV6OOKzVeKp80xnJU55AwiLPK8esK53b9h75Uc/IuokiZR4GUvg9Cx5paKCbJ2Cq7g63DSKxqNhx7KxzgTcv99kU8N7b6D3fivQPxYuHswzO7tkPqmAr/5TLJCo5eZeoltkd6F+l78LTjOEPjx2R2ecWiozgjorSpiz5G02pdDi/8Y13dKe8Jc8wywc48i91p9Z6c+LbHeTNRNZxr3qTrEiMGIHwjzwpdKh0wcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 02:56:42 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 02:56:42 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 19 May 2026 11:55:07 +0900
Subject: [PATCH v4 13/20] gpu: nova-core: vbios: store PMU lookup entries
 in a KVVec
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-fix-vbios-v4-13-5d3f210c5602@nvidia.com>
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
X-ClientProxiedBy: DS7P220CA0046.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:224::21) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: 10ce906b-a70a-48a0-21c1-08deb5524176
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: z8mVPfTFu6ELcvDIv2Cq+M0CQ8wehQ3hsXxbgSfMAE4shewdDNgFMlh2DEY8xQPvkGlUAF0jJ9RUTyll+wrkxA4Lbz6z+MrV5o4QbG1MRlnE4WND73D6zGPdqRRChUbHOIpedHQwjrAkmLhmcdplPmJZ0R6F/VtGF9UySf5VW1VpjRjbwoJQEe4uJXoF+BmNUaXY7lD4TZ7VnefK9MiJntmBy0zqe5Mdc29yWSvvdEtk6bM3e4j+0bcVOfiCFE78JJz3wbPgUzU6zJyQozeTmM0jHJZ71iX+yuJYwUrdXrNgU8VTt3jkW/o6QZaC8woXNCiG7oyUGFQHfy+rBq/C6MmbZ5ZDsLgW3gNeS3ZpkwXMcC6I5w98Zr6TsB1fY0UKZl9SFfMXDlWV7LFOp3B+h0mGUW4ok98uOD72oQKIzt54Q//CRJJxoDEAjB1A0MAUGWsQ5IXv7nG9nX9FF8fpgibWWTSuuNyq/2Hh9xm8g2VGZNAyjcO2GZHrrAExldFdkWd4KOxiUEbOaBl5Nzlyue0FsD5r4tU9G2sd6asCLp1D0jJ2UNPL6WmxNTwLBFeZUZMa1ljv4V4SN5upHa7QrNg0m9DTX/5wZd93yQo5x8H8VHb1JnhvIRXeZnYIBOwQ6sf/9IGoAlzlxLbsCBlMlt3tEe1Xq0XU3R2RR0sL8JVziPWkBO5NZoDMxSKGmJJI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEdtY1JlQm8reTFSQm9vb2tOOXY4VzlnVWtLbWRJQzM2WXFZaElVVmFteHlW?=
 =?utf-8?B?SU1WdjRwdXZqMHhHQ1hwUDJ0ckRLRENtNEd6VGhaV1pUV0Jzc0ZxdWVYbUxG?=
 =?utf-8?B?cjhmMCs1NXJleVBJUGlFSTZsMW40QXlITTZrUHA4c0l2V3lKcGlvSDhTYy9z?=
 =?utf-8?B?SVo5MWc1UkdRaWVsbzhCRUZWVjlHdFFGUXdhc2hZdlZrTWFMMkhMbGJXWWY5?=
 =?utf-8?B?bWdVR21JWURjWjNxNHB0ZWxVNS9pazJaU0d5N0xuQnF5dHduc2l0SjZPem1p?=
 =?utf-8?B?bmluMGJoUUZtUkVpbitWbWxjOGcwaTVDcFlScG5zN0p3RDRDY3k1S0NrRUh2?=
 =?utf-8?B?Y3lpQnlnRHFsYVR1VXZIV1ZSWEFWOUlJdVQ3NWVreFBBQmxuU0lLNVRqai8v?=
 =?utf-8?B?TWNhVlVTV1RxVDhXOGlIemxZYXREeDhIRTJGakp5UVQxOWtaKzZLU1B0NW9R?=
 =?utf-8?B?eXQ3MzZ1VjltOFN4OWNNTW1tdlRLMUdzQlVweDhvYzhvbFgzd2F0eU9aRmRZ?=
 =?utf-8?B?SCs0TUFValIreFN6V2JQd1VlZTYyQndEczZ3cFZ5d3VzSkovcXBXN1J5eGZw?=
 =?utf-8?B?NFVpbmxqMHlZU0N3Ym5KdU9qRDdOWXpIOE9vd01aZFpUWHdaYmNDbG4yZi9n?=
 =?utf-8?B?MzhFd21pMHJWSE1LZHU5RkFrdStLRjZaQ2xtKyt0QStrZlFVNnBad1F2SHFU?=
 =?utf-8?B?RjlzOUYxQkZqcmdrbVJLbVk4ME9KbmpuVUxQWjJKS0NPUk5KTk42MUpxeDNO?=
 =?utf-8?B?bVp5NlpaQWVOYnBBRGFEZXREdFJVdFVVYlNkazMyeDBHYWk3cnY2Q09hS3Rm?=
 =?utf-8?B?SytYdDlFaWd4d21GeU5LbFdIU0ZJR1Y0T0VLYmlSVmJhNitmdUlqaHI4aGQx?=
 =?utf-8?B?VmkzSGIyRzZyd3pTNWxQaVJ5dXViTnYxaXBtYlF6VkR2b0lDNnRGYmhzbGh5?=
 =?utf-8?B?T05ucnhvbnJpR2FqcjJacXFNOWFObG53cHowUER0QzBYRWJWSkRkNDIxVE04?=
 =?utf-8?B?MGw3eWRHbzhCT1FwNTZnOWlaS3o2WEJCUnBUTTJ6SUdaMGd0REc3OFhIbzZR?=
 =?utf-8?B?OFVBQzBKNDVyaVZweEtOZ2VMaUFPOVErV0N0YjJsY0VUVnpMd09ick1DN3pH?=
 =?utf-8?B?WWpKbmJ2QmNrRHdQWEJaTHdnL3dDdUkyUGQvMy9IRzg1S2tBMTkrS0xtajNM?=
 =?utf-8?B?U3MyZGs4ZUhwblkxUk1na1A5alNPTWpuWjN1QmhVSUNiTUIvMWhFUDdHOWJy?=
 =?utf-8?B?Q05DQjU4c0l6V2ZJd3YrUnl5L1o3Y0dSRkRjaDBScXdhbW14U3NMb2FTa2ox?=
 =?utf-8?B?N1BNU0hlTXNhOVEzcFlXcTJveDRacDFCNGZyWXU3RzhwWURScUYvalZ4YndI?=
 =?utf-8?B?UU5HWGxTbFRiNE5lcGlWQ1lVOCtEMWZoNjJyQm9KRnhGU1dXZHNxdkhGTTZo?=
 =?utf-8?B?SnpzTHVZMG5ob3doZE1FdkRGdUhxZEVaeldSdnljOGtxSkEwQndpYlBPRVRP?=
 =?utf-8?B?MzB3a2hLVTlmL0dWVE14MFJveGk2RWY2cDhnRUphd2hzRnRvSW1KRlRTWWFG?=
 =?utf-8?B?MGhScW9mRVdKRVNjOUhXWjZSUFlsdFZiY3dUM2sxTDNvaXo0ZUg4RE9KdVV6?=
 =?utf-8?B?Tk96dmxseHJCM01wOUIxSi9rTG93eUJTKzQrTUlDbFE5VUNENy9hMFl4eUs4?=
 =?utf-8?B?Q3plUXg0Vms0azczMU1yekZiREVxQ2IxWEw3akVZa00ra1BZUStuQkgyZjgv?=
 =?utf-8?B?cCtTU3RCVXoxRUNXVnhsL3VqTEc1VTVKYldMNHhVUFVlOWdZc0JlbThpWXIz?=
 =?utf-8?B?c2JHVEhEYU14R0ozTnBVd1BhWGExc2J4SndmOEp0UkpFSlFkVXB5Y0xGd25y?=
 =?utf-8?B?ZWR5RzE3TnZ6RktLUzNsR3RXK2lSUzJzUkhOdmhQMWVYY1pQTU0rWlFUM3h4?=
 =?utf-8?B?TjdCMDg1NmtSY1BkdDZtcUZIWnN0cEhidnVLSEQ3S1dxdDc1RW1Gc0VqbzVv?=
 =?utf-8?B?WnF5RFplajh2cHAxQTRtbEtQaEtRMDYrdzRNUlRkYkJIT3VTQVhlZ3NwWlM1?=
 =?utf-8?B?RXo2WHNBc2ZMUGczQmdoajAzRkJ2bU1LUHZPYk9VdGZOeDQ5M2RuZFJaREZU?=
 =?utf-8?B?VmY0M3J3UHdNOElkek9JWXNvMFFZbzhKTnZlbktOVGxpUXBlNVdtR2lvSnkr?=
 =?utf-8?B?NTFUcnhVdVJ6UzdhTnAvVTNZZEtjK3NGR00vTExncEhyWjIxRENraUpHdHl1?=
 =?utf-8?B?NUErV3ZBc0FsQmlmM25MMGcza2VRelRuWVBhWkZURURTSWZzWDRNWWNoRkFi?=
 =?utf-8?B?SWlPS3ZuTkdqUHgxSjZCZHpMR3NsWElYOElTS2k1bWZCYktmeDhQZ2JCYTYy?=
 =?utf-8?Q?44FBirhp5NihGDexNVMlqbdsX1JIu3dSiqmeSI2yGBxyf?=
X-MS-Exchange-AntiSpam-MessageData-1: rRzXWK3/3yA+ZQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ce906b-a70a-48a0-21c1-08deb5524176
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 02:56:42.4283 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jox4ETqG11scFm8fJfkxfAE7qfvKGtzndqDR4UnPOzV4eHsoupbeC+mJBWUe8b8ogoRvmt1L8m+xpnR5KXj7fA==
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

The current code copies the data into a KVec and parses it on demand. We
can simplify the code by storing the parsed entries.

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

