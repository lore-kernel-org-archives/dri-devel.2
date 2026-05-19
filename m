Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1715CD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 02:56:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11E1E10EA1E;
	Tue, 19 May 2026 02:56:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="lB5Ctu8K";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011018.outbound.protection.outlook.com [52.101.57.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4807A10EA1E
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 02:56:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7s/gUr9R/OBMfTeFFWdPgMNUixyHwZxIsIh4a30xZxMCioljvQMOz9W6a0WrjtPRuB1Uj2KlCofnchwkxkYlWaL+UWzYWZGscyiXCG8trCKK/9+AjhLX8bvUJwyWqGYaubmGyxcOm3TZaBmlzlGA06cJk5m158DNRC7S8pCZZDHVb88mfZbwHGKYE4/l1BBcMoZ7jjFaE8qskptEtkR76zVRH0OWmYMJldM+uTs5ilhKxCeyWBw6e00LKRPpxRP2eR8VVt4jIDZyMLJB29iLUdMBV6G0fPK4AGTVsEE7VU9l33U4fRIVs/fZPadbXIg7ow1mk71Wvc/Bk1htPGmtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SaTfX7o0ekrM0eOLsrk32VGCNOJnbiuHIh7WIKUdlhc=;
 b=Jtxda4Qh6TsgZkGi3lQT4wbpO3D3wB4MpwzoP02dS0YADwsQoOVEDjLTWzBZ4Jx4iBiUQlv90vOAlCr6u0Q45OC0SYN/SDoyVcIcEipihhVq+dLCBPFa5uGByyCxV0wRsxurhmKVnAAOFV/XDkDhgXQwCvSsLM2XdPofRLqGFNEBD79gQGqHo6A4Pqyg73Jgb7NZK/8/0KcIzchWkidB0T8ALd7G/vm0n0MJQgx48zx99Ffg1wB22ZZKqZNzVlrzwakQo4TAT2Rvg6lhgaHL/+cQNgtd4qsRMqICnZgB/hZv/yRvCZkN5Y9F/2oIorSJ12ZABUsE1gtIDwdd7ExaBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SaTfX7o0ekrM0eOLsrk32VGCNOJnbiuHIh7WIKUdlhc=;
 b=lB5Ctu8KkGNIzrxVclg+Mb8v1ZkHQA+DEEHK7bpemPXftuEhGBHzqolIDcJ3nVBY0dr7dXsWYn2l3aPvjXNPXdJrvGC8mRiQWh/dnp/aOorF+ijMUeooMO5e5X1jSn7SLdejXJWjnM9TYWs0G+MGFoPnLcS0JGMRWRZWVnDcDCzLc1ke96XkBE8iiYAcHpm/BIn3oWhTguci5lmD5wPjHwH6MQtAblUe0mX/pvtxFi+PDDjABFBmXCUofEz041vpSXOGfMTzWjrCcMkBhplqTa13Yq6EIHZ1zsCVeU7nhBgfnO6IqHxnfxPIwDUJbFJpqLHQMl9AhUeUvsX6F+NfBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 02:56:07 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 02:56:07 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 19 May 2026 11:54:59 +0900
Subject: [PATCH v4 05/20] gpu: nova-core: vbios: use checked ops and
 accesses in `FwSecBiosImage::ucode`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-fix-vbios-v4-5-5d3f210c5602@nvidia.com>
References: <20260519-fix-vbios-v4-0-5d3f210c5602@nvidia.com>
In-Reply-To: <20260519-fix-vbios-v4-0-5d3f210c5602@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P301CA0089.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::10) To SN1PR12MB2368.namprd12.prod.outlook.com
 (2603:10b6:802:32::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: 24792560-d404-49ab-d3f5-08deb5522c75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: /hKtZubuwYjVlM0rTsnS4T0r83g7eSC6NY45aRhr9QN1IVJIsYV94VJ4KsoZLVfmE/jk9dDtpHlpSPPeYuVINdsBgBVRRJkplcc3m4V4hD4z7R+Ye+Nn7HCG8KWJsNZyMzk9O+05XP7mnngYKBSpQHQftuGKM95tAXa5+icGPmeZdZF0S75+xRF7Fm/hYOZ4JW2FlSsXATRfwEkqnjbQogYOpdi9fF+xIJ+zqZeimvNxG6ixuB6xZfqvbe8QauP5DEYfGL4KoX67lauIgUnyxLOAzqjlMSHRw2raaKZZToKdncXv4c7YQg4NGXUxl53JioMZi5dYSlfsK/dpHtobOZPD7IbZbtYK+ZYWu8JPSTHeZ2o3/TEatP6z4Jw30HZxpoyjzWvpq3uZvvQvG8HzkIPD/yh5p3juheFXHLTsHgaof4DXbJOKhjU0Q/EHBzjZtGfkNBGtBlYwjbYTUCH2N0Idb6FDAECz2T4wXwbk0l2CT/pZ8lL1W7/dHGRMAFE45FCfe0iZulg4YC71C/3e0Bqi+vQG7fWjCk4Fb1bFObCPsEim1zf2271euoClwktXa1a7vGCcwr5CyUNsdlGCu5PeQOWI9rltQ2LiUmFtftQODhywTWt7Sc8O1QjMocXABQAf1NVrO0c5EbXfSs062hvI2SeCn1XPLessWCwUveelP1lVXxt+1brF2FLP7SS7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHNPcjZsdU5PQ1pJMlh5QTFVZlNBS0lIZXJyVytaVmpWVjI0S0I0bXVtZTNJ?=
 =?utf-8?B?dTI2Qk84VEE3dDlwYURLWU9adWJ1SGNidS9zU1c3QndwcFdUaGpLdjBWZ1FF?=
 =?utf-8?B?SFJqb3J5OFlIS0diY095VGZ2ZnlvciszbXJCbmVrQ1NBNzVKR01uYi80YmRX?=
 =?utf-8?B?L29pSE5acEZ0Ukk5Y0xpcHVyOUhVYWowTTF1NHpialkvWVluZTNsdHA1M3BZ?=
 =?utf-8?B?d1hDUElwY0RjMHgwSVFZUlQ5bDBPVGQ1QU1tMkgrLzRJSFdERXRPSzBvWCtj?=
 =?utf-8?B?Zkp4RTV5NWJUdzlCUFVnME5rb29hOW9Cdi9rekh1d2ZFZVdHZW1XYzdLN0JK?=
 =?utf-8?B?dTlrd291NVd3QTlxUzFUN21GSktpZXFFQXFQcnBFUFZPdGZqYy9MWFcwVGpU?=
 =?utf-8?B?enpYY2YyZGhWVXVlNEszWmt3ai9yOWhwN3cySG1pM0hCQ0EyV252WUxYVXkv?=
 =?utf-8?B?WTVsMzVpN2c4V2tWWUtzZVZ1aHpLbHhKZ2YzSXZoSWx0OWJrRzZvN1IxSGc0?=
 =?utf-8?B?R2JpSElDQ3o4WG9PQUd6bWd2YTB3ZWo5RTFDUk9LZjdUSTFXSTJDdmhWMFh4?=
 =?utf-8?B?NXN1MHFGbHlYZVY5b3RpYy9uMW1SUTZNcEZicDh6MjA3SXZKR3BTNmR3RDZw?=
 =?utf-8?B?S3JmRDk4TEM5TDZ4SzVNQ0NVYTNIR2RxeDJpdEx4QVp6emh5ZFFQb2lCVFpP?=
 =?utf-8?B?ODdhTlVxOHJjZXI5VXZrZFFYb1RCNlhKSzdySFd0WE5uQUt0b1FOM0I4UXZp?=
 =?utf-8?B?RkN5aU53aTJoYmNFSjF2MUEyK1FGU0Y0RzQ4L2M1dW5pSjkxTjBoVVI5enh4?=
 =?utf-8?B?aVRreE5jNGNuaHNISXh4ZnZDam9nQi9rQUNHMEpEYjRwdURSYldvTUFwcVZs?=
 =?utf-8?B?aVhSNzRFYlh6Mm82WDA3MUIwSVNiYkUyc08yMVZNU2NDbTVRZXlQMUwwZCtC?=
 =?utf-8?B?dkdpbGt2M3drTkFUR3hNeHNnSHBnek54R0pITTdiKzdpT3FGbmkwUDN3UGVt?=
 =?utf-8?B?clpJaC9ONWhmL2N3aGN3c3hiWGMyUDhTTVV3YkNwK0FWbVoya3BHWnlYYzhB?=
 =?utf-8?B?UGoyeXg5eEF4c1NBZHpIdzZBRlY2K2M3MVg3Nzg2RnFoTi9xTE51cG1lVHFI?=
 =?utf-8?B?R1JKN0ZQcDl5R1R3WHRVRVI1cmhVdnl4SUl5Nm01QkszZURmVVlXWTFoL2Mz?=
 =?utf-8?B?VU1lMjFVbHRnQzEvVmdIYk81MW5uT0dreVVIcmdUV3AzZmNQOHhSMXk4b0JH?=
 =?utf-8?B?M25uZWdJUU1VeTVINWVrWkxCTzdaRFdTRXdFUmNySlVoMlg0STY1S1hkL2I3?=
 =?utf-8?B?SVAyUTNuZE91N2NNVkxGbEZMKzN3bURibDNBVHpzQVBYVG5wMHFZV2pDdGl4?=
 =?utf-8?B?T2FDOG95VlcvaW1IVEl5cHpKM2hrVWNYcDJ6eE1jdTVHOEdKMk1HMDltOG1V?=
 =?utf-8?B?cGNySDlhMkxxdUZUNVlyK01XbmwwTStXNVZRN3ZlRlBwVmhRTCtaRFp0bFB2?=
 =?utf-8?B?WTNyditMQWg0Y3dqQ3BoZE51dnIwMHRROS9TdWc1REI2T2lLTzZWT0E3bTU4?=
 =?utf-8?B?RjlmcUJWZXhlVXUyazRaUmlvNUZJTzdmTjQxNE5YSVRYWU85c0pTR1lZMjNz?=
 =?utf-8?B?NnhMZXlIOStlZnZOL1NoZU5zdTY0SHRrL2dRbzhkc3VFUyt1WG9rM2pPT3Yx?=
 =?utf-8?B?NlBZb0diUWQ5QUpESnMrMUhrandLNU9JVzJuSTRiWElEN1pPN2xCWmhMdy9O?=
 =?utf-8?B?bi8zUHY1Wjc3cWQvOXpKU05TV3NpV3M0RHRJR2xBR2xGMFE1UkhSTHlUUCtw?=
 =?utf-8?B?RS82RzhQN3NKYkpVOFBRa1VqVGcrVW1rUHlHVW9IeXlzNVg4eHRNLzVRSVk1?=
 =?utf-8?B?RGtKTXJFc3lhbjlTZ2J5MyttK0lLK2JFYzc3SHlPbldURkpTbFVtMFVEbjls?=
 =?utf-8?B?Z1dmSDR6ejY2ckhnd1AxL1BQNGsvTFRWaUxzQ2dTL0FyQ0tVUFF6aHhFazdr?=
 =?utf-8?B?VlBxR1lWS0x1bThUd1NJOVNlSHQycHpvSk9lWlJteVRVM011SW9lQjljeFN0?=
 =?utf-8?B?NldQZW9ISTRkYkRZU3puUFFTclVHbUJjZTkyTnkvZVZURXBNQ2VmOGdYMTBI?=
 =?utf-8?B?OFYwcVo4eUdPeU5UVnNQSGNrWTdGVHdHRWRQWTNrZFdJaTFZSEZnYjNZWFp6?=
 =?utf-8?B?ZkJIV0ZSRUxOckhiVmt1Snd4a25GZDloOFBSUlgvbko5RW05bHJKYjlWUEo0?=
 =?utf-8?B?elNLVUF1dnYrVUR3SkFkV1U5ZHQzMENuWDBGZm5uM0lrUFJDa1NoZTNvQ2lX?=
 =?utf-8?B?Ky8yMlNPemRSeGlsakFCU0NhZmxaaHFiWStKZEpmQkNMajgzc1ZWd1NRclBs?=
 =?utf-8?Q?vIrQA4zPJh/Ir+acxW5NMFS+vU+U9o9/aAqFlJVy+255p?=
X-MS-Exchange-AntiSpam-MessageData-1: GMalc6XemcQAxQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24792560-d404-49ab-d3f5-08deb5522c75
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 02:56:07.5954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vtwNV1CqSDAXXX10vLtbuU3stlYmJRi1j+BY3uDc4+yDWQzixDyC9xHO3wYlYixqvwpASBcaknwwq8X0A49HgQ==
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

Use checked arithmetic and access for extracting the microcode since the
offsets are firmware derived.

Fixes: 47c4846e4319 ("gpu: nova-core: vbios: Add support for FWSEC ucode extraction")
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 2ff67273fdff..c62d918a3041 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -1110,16 +1110,18 @@ pub(crate) fn header(&self) -> Result<FalconUCodeDesc> {
 
     /// Get the ucode data as a byte slice
     pub(crate) fn ucode(&self, desc: &FalconUCodeDesc) -> Result<&[u8]> {
-        let falcon_ucode_offset = self.falcon_ucode_offset;
+        let size = usize::from_safe_cast(
+            desc.imem_load_size()
+                .checked_add(desc.dmem_load_size())
+                .ok_or(ERANGE)?,
+        );
 
         // The ucode data follows the descriptor.
-        let ucode_data_offset = falcon_ucode_offset + desc.size();
-        let size = usize::from_safe_cast(desc.imem_load_size() + desc.dmem_load_size());
-
-        // Get the data slice, checking bounds in a single operation.
         self.base
             .data
-            .get(ucode_data_offset..ucode_data_offset + size)
+            .get(self.falcon_ucode_offset..)
+            .and_then(|data| data.get(desc.size()..))
+            .and_then(|data| data.get(..size))
             .ok_or(ERANGE)
             .inspect_err(|_| {
                 dev_err!(

-- 
2.54.0

