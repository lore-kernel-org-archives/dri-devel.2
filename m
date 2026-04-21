Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B529F327BF
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 08:21:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7580810EBC8;
	Tue, 21 Apr 2026 08:21:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qplhcy0I";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012009.outbound.protection.outlook.com [52.101.43.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCBA110EBC8
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 08:21:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQJtqf0z7OvuXmELVl7eEVyx8ANlKDDnuxCJHKZ8m6UKKv39UeyRV4csBRW6XLw6HMkONb6dC67KGnYTrNYvi/GK4rRKYmWXWywIQ2LrQ0jMqk2lLrJXjbyHhx53IdaZwfMrvKZE1A9BvGBOz/YOT2wGbR2NguhqWQMz5P34GBHRf+V4fzr8hW8ML76XWG0uLPsgFgfPezQG51xGuU8n9bfcvb0+zAsjtjYewuYeGwZCQzOtp2KQfjapH6qx0PGr35jqSQhVXD+oApjBMDIwTQGhbEw+QDUaY2kSS94NVaP8PpJfeajVWv244P4SJEQPkp7Dzen9wTrYN5hcLCSkzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULcnFrY638WiTfYu2AeFETWibgeXuNcqXxmDYTitRvY=;
 b=PucOXx4/1B14Sq6QFiu0l8PHhUY5q8rgMIxiqH3dRRUXKv2vi0j1WTIxQW/QhTmbvlefrqmnkOCJNHML5mu0RdD6n6qqWkyCSmtocWHG3k8Xz/mf+TIQe5l0oK1C7ohWfmWsKeQ559Jm3R+xpfPSVWGzoOtzKVyTnYz53LmldC/JH2UvP7dnuM2gWf0KdKo4hBhVtSGDITc6ClQOSrpbLEfaJu6gHPPQSvjc+U/fkcVwOON9WikDhQanrxGHBrBjYiqCETbiy3U3jXHAdTdlCieNm3uXSRpdwuUelNCVJhqg9lyuA//o9bdLzYGNTTaWd0bT7uZUs7tNrsSEsobimw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULcnFrY638WiTfYu2AeFETWibgeXuNcqXxmDYTitRvY=;
 b=Qplhcy0Ib6oQ3DVlX3+JSTUbgH20o+UNrsE+Ju4ptYvvTuqSm8yvElal/lJzOiHpSz+CgepI68LBrTkyYy3qFG2KrzfgDbMCoIy89YAPmhvaFaa+UEhCsWwq9FW1s8YRyfzO/hoEXgPEaKtxHm97mYKUQCgpdxDqc7n2dEoaPylfsriz7gZjeaKvH59sAgkja38aXK7hbMpsu8T+uJiqijyABeNE8m4elBEUidUVFczJGHC9kybcERt5i5GNMw5vPDC+JExTzRzUPzvbah2vJuHcqx+ZxaFrimmgve6yioSa0MD4Oiq5xKIcYJVt17uCcH2zqoo4QPNmZkgUKeO2SQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA0PR12MB8376.namprd12.prod.outlook.com (2603:10b6:208:40b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 08:21:17 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 08:21:17 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 21 Apr 2026 17:20:28 +0900
Subject: [PATCH v3 09/11] gpu: nova-core: vbios: simplify setup_falcon_data
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-fix-vbios-v3-9-8f648aef7a85@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0155.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::13) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA0PR12MB8376:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b7be4a1-1681-4fd8-526f-08de9f7ef5cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: TtLTW9rDfFlkilZn+IpkYM8TY9rlpDt24U9IiHPI8ILUKy971lfvdHR3m1qGxr6+3VaHgtfg4MaacnPTmXBzttGTVPf9Ekb5vDDWvQsTs3FQk9DF78cllLb/Lw0imWURfniQoEgvQgbs64gSI5YuC1yK3FDXOrAzzccK8Id7ns1N2bcBQwL5MeUaLu2SwG0vfUFVDz+hgudx3UZZety25xtiP9FK41NLWGb6RPU1WYqmybvh2UWMiKUlFv4CscZOgNko0jq5gC29V5R4QQJCTcKjeu6zLP6Zu+bxpoSHGvBGPizaa08xcQPs9SwhkbR3UZZ7IHL1j0KqUVomP89TRxpI+DIFYyQz7D+iqGYu9qUmFUiGBHZlbDtyGoJLpvvLf8vut3AD7UfgyeJc24h50HB2h75eA0IEA4QaT84SOAmqqTUCCTL9wrueV4BJm4KLzR7J/NgSJ78XWg8bQhPZCgFNzpq2CT/G+70Z7z4s2XsrrBBN3k68/3K2xM9NfRa/OPfl34YHb4/GKIYS0d6mG60hxl7hnhVIOfQzbrdDV2wGHNio3z/no5FotDxLIyxxw77xkSNirnWdCnQtUmcscH5j9Owf+Q3JZr56RtI8dusMAea3qZh/BMbVBxAcq7OmsANSeUdTqHJ78JHrjwgvjaNpNiunKAuT9g7/eYqpc7G33ibix8E4YltxGGY3njQTP5gF59dfz7n1nqbwGqIZ9AIw19eQPEgY4fzOlZYTR+Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkV0ZHB1N2U5YlJyRDl1Qjc2L0tyekhwWWw3WW9tQ3JWYzBRckN4b08weWND?=
 =?utf-8?B?V0hQZk1XOE9LVVJENjVnRzFsZWt4aitsVThWM3RaQll3N1pZTWpMSSt4ZUVn?=
 =?utf-8?B?VENqZFBNWFFldUI2ZmRodGlXQjZtYmptSGNndkMvSmJPNjBLeWhwS2RUaGZw?=
 =?utf-8?B?M3BRckRsWktQd01ENUlVaDlQaVpSbTdFRlFpeE9ZSnptRWpVbEZIWU5zZlgv?=
 =?utf-8?B?c2pOVy96QkNUVUlId2tXTXdpM0EvU2VZRjRCdVAydkdualNCN2o0a3ZSb2du?=
 =?utf-8?B?RWp3N0ZBczgyRjFRTWlDZW5ObUgxTEZaWnVnVjBlMjZ2bWgrZGtCTHFNM2gx?=
 =?utf-8?B?ZEZNYzl3TFkxVGVzbk5FOTFPMEkzaXJ0aUQ4K0E2b1NGekpvOTljT3hSK1lu?=
 =?utf-8?B?TCtiVi9FaTVWaUo3S005K2ZPTS90QldQSlplY3E1S1ZqKzkvdDU4QkRKbnkz?=
 =?utf-8?B?SllTanQ1dXZZUXVWaGFQWEV6dE91S0tzM3JIVDRyRVlvN05YTmRjZmxvWHB0?=
 =?utf-8?B?R0Z1YWJUUGlsYloyV3VjakxscHEyY0JxQ3JZNFVtaTlrVFkvV0d3YXJwbm95?=
 =?utf-8?B?U1F3M0tYUlhIampSUmpBZHRxbW9GZzJCamhvYjhWMzAwdWVGWTVnd1ZDeVpl?=
 =?utf-8?B?R2xCWEFPWThkd2QwaFd5SlZTVXQzaWswcVJQblVzVVEvYTlTbkVLWG15R2JI?=
 =?utf-8?B?aXNwaHl4Si9veHlzVCsyL2hlOFN2SzBmeE0yclZqNlVLTXlOK2JCbkRacUpD?=
 =?utf-8?B?S0d5dEl5NEZ2UkllMi9mKzYwdHpRdG9sMzYxY1RXOEhQM050Q1lsdzNPVHd1?=
 =?utf-8?B?U2xyb1V1bWdQRm1DZi8wSTNuc0hVWW80UkF1L0d1YUg5V1lzR04yK2paWG1x?=
 =?utf-8?B?bzNwNnpWWHpjY1h3Q05rb1d6VlE5V3pDa0gveWd2Vnhzd3hXdldrUUc0NWhz?=
 =?utf-8?B?TGhXWU94QmI1ckJ6VVhpUWRqN1JtSDQ0UzVrT0pmZkZrM2lQNCs5aXUyRXlL?=
 =?utf-8?B?T05tRk5mV0NsaEZuQjZyV3ZFRE56TGJYZjFxaXpqUXc5QitJMUpqbTNhNHpq?=
 =?utf-8?B?ZjNIbnpBSklOMzFOVUZmNWExYzErc1F0T0o3L0MxUjR5ZExocitzT0I2ak9v?=
 =?utf-8?B?bEhDbHVZbHRoSTRjTWt6dDVROHh4Zlo3Yi9scWZJZ0R0MkExT0srKzAwSElo?=
 =?utf-8?B?YVpucjB5RjZEeEtLRG5XSlFSc3lkK3hGcjBNQ0FHZ21oU3hZY3FwU1AxRTZC?=
 =?utf-8?B?RUNpOFFOTnJEOWN2TzlzQ21TTHJyZDBqd1djL1A5OVl2TzZEdTNhelFoZHBj?=
 =?utf-8?B?NndSbWZHOEJXR2FYZHE5MjdBaTRaNVZvTnpXOGtGV2F1RWJnMm52WWdUVjJU?=
 =?utf-8?B?UGlKNXhnUy80QUlUREFKTmE1RUdDa3NWRmc0Y0NQMmhEdGZIcW9Cb0lFZG02?=
 =?utf-8?B?aDgzRzRURFBYL2FxbWEwYzF6Q2RtRXh3VVZDZWdDOHpVZGkyYVkxaXFVaTFp?=
 =?utf-8?B?VXQ3R0c5SGE4c3pTRmdaNnFKYzhMMTFiY3RVZXFOTWxmZzJSb1c0eE9FV09S?=
 =?utf-8?B?ZkRhWnAyK3h3L1ZSZ2lXQ1docXRDVDFkaldQMFpaN2pyN1F2ZU1CcVdlNUZx?=
 =?utf-8?B?OWZCSXJGb0QrY281YWl6ZFZRL3RKS2RDY2x6alJkejVVRVJuMXhOMDFMNXlB?=
 =?utf-8?B?U1E4UHY3d0x5dUR4andKVngrcXVIdjFhZlp4a2ZyL3JoRTREYzErVi9mVE82?=
 =?utf-8?B?eW9ZVGVFTXBoV1ZoUDhQbHdDbmxCRnpFSllhUHZ3aTdyTkRqV1A0YitERjRW?=
 =?utf-8?B?MjR2VElpektIZmxGUFZEbW9Yb24zQ3IxbTdHV1B5d2FrQ21kNytkajM3LzN6?=
 =?utf-8?B?cVVodi9lYzVudTcwY1RXaEhhbUxTKzdtb0UyUVJqZG43cCtoVksxZHVKVng1?=
 =?utf-8?B?azBqQjR0M1BRMXhwQ3lQdk5zVzYxY2FtRzdmcEpHL2M4c3JDeHU5dktGK2RW?=
 =?utf-8?B?d0oyNUxhQ3llYk56MXZaV3Axc0hBNXNLNENvTWQwQ2NBSGZHZENEcVBITG9P?=
 =?utf-8?B?REQvTnJqL1FxWlBuV0ZTSVVyNndoQmVwSDdPZHVKYWtDTWsxQ2l4Vnovdmdy?=
 =?utf-8?B?MDFsR2VxVkV6YnhIZm55VHEzUmdPd1phZHlBWERFMFBCdGwzSnFkUHR3azZW?=
 =?utf-8?B?WHBMSy9qdWZhRVZZWDcrdVgzNjBaZUNkcTRnbkhtaHhqWGRLaEYvQjI5TEVK?=
 =?utf-8?B?WWs5RmdIS28vYm9sUFg4WjF6dkdVKzBkMkRyTll1VVFFRk5BL1dxNi90d09N?=
 =?utf-8?B?cDFZaUlYc1RSUWJoNUJVLzExeVlXQm1OalZpSSt3T2JPSGU1TmQ4TXoycnc4?=
 =?utf-8?Q?U1sm29NUko1siuG0Gt2oKTlZ2dPoSM0qO7w1mf916ESBJ?=
X-MS-Exchange-AntiSpam-MessageData-1: yEATV2cRxf+VfA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7be4a1-1681-4fd8-526f-08de9f7ef5cf
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 08:21:17.3470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lGBkan6q0ZR27B2DYg4qOJVXbq4T+FWIauTsozQ/G0LIMyDgSscSeLfIxjWhGtR9M+2wDsbgUzYbhhqwOJHoUQ==
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

The code first computes `pmu_in_first_fwsec` or adjusts the offset and
then uses it in a branch just once to get the correct source for the PMU
table. This can be simplified to a single branch while also avoiding the
mutation of `offset`. Also, adjust the code after this to keep the
success case non-nested.

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 59 +++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 0c0e0402e715..d71ff5de794f 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -904,48 +904,41 @@ fn setup_falcon_data(
         pci_at_image: &PciAtBiosImage,
         first_fwsec: &FwSecBiosBuilder,
     ) -> Result {
-        let mut offset = pci_at_image.falcon_data_offset()?;
-        let mut pmu_in_first_fwsec = false;
+        let offset = pci_at_image.falcon_data_offset()?;
 
-        // The offset is now from the start of the first Fwsec image, however
-        // the offset points to a location in the second Fwsec image. Since
-        // the fwsec images are contiguous, subtract the length of the first Fwsec
-        // image from the offset to get the offset to the start of the second
-        // Fwsec image.
-        if offset < first_fwsec.base.data.len() {
-            pmu_in_first_fwsec = true;
+        // The offset is from the start of the first FwSec image, but it
+        // may point into the second FwSec image. Treat the two FwSec images
+        // as contiguous here and subtract the first image length when the
+        // target lies in the second one.
+        let pmu_lookup_data = if offset < first_fwsec.base.data.len() {
+            first_fwsec.base.data.get(offset..)
         } else {
-            offset -= first_fwsec.base.data.len();
-        }
-
-        let pmu_lookup_data = if pmu_in_first_fwsec {
-            &first_fwsec.base.data[offset..]
-        } else {
-            self.base.data.get(offset..).ok_or(EINVAL)?
+            self.base.data.get(offset - first_fwsec.base.data.len()..)
         };
-        let pmu_lookup_table = PmuLookupTable::new(&self.base.dev, pmu_lookup_data)?;
 
-        match pmu_lookup_table.find_entry_by_type(FALCON_UCODE_ENTRY_APPID_FWSEC_PROD) {
-            Ok(entry) => {
-                self.falcon_ucode_offset = Some(
-                    usize::from_safe_cast(entry.data)
-                        .checked_sub(pci_at_image.base.data.len())
-                        .and_then(|o| o.checked_sub(first_fwsec.base.data.len()))
-                        .ok_or(EINVAL)
-                        .inspect_err(|_| {
-                            dev_err!(self.base.dev, "Falcon Ucode offset not in second Fwsec.\n");
-                        })?,
-                );
-            }
-            Err(e) => {
+        let pmu_lookup_table = pmu_lookup_data
+            .ok_or(EINVAL)
+            .and_then(|data| PmuLookupTable::new(&self.base.dev, data))?;
+
+        let entry = pmu_lookup_table
+            .find_entry_by_type(FALCON_UCODE_ENTRY_APPID_FWSEC_PROD)
+            .inspect_err(|e| {
                 dev_err!(
                     self.base.dev,
                     "PmuLookupTableEntry not found, error: {:?}\n",
                     e
                 );
-                return Err(EINVAL);
-            }
-        }
+            })?;
+
+        let falcon_ucode_offset = usize::from_safe_cast(entry.data)
+            .checked_sub(pci_at_image.base.data.len())
+            .and_then(|o| o.checked_sub(first_fwsec.base.data.len()))
+            .ok_or(EINVAL)
+            .inspect_err(|_| {
+                dev_err!(self.base.dev, "Falcon Ucode offset not in second Fwsec.\n");
+            })?;
+
+        self.falcon_ucode_offset = Some(falcon_ucode_offset);
         Ok(())
     }
 

-- 
2.53.0

