Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC7ECD5BC9
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 13:58:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D98C110E354;
	Mon, 25 May 2026 13:58:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="V+rduHfD";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012065.outbound.protection.outlook.com
 [40.93.195.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B006310E354
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:58:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IkcKS/rYEqj0A/4xQHHvC9dufc17BhRsWBaEHki53OhUwK1iuWWIV3JyKVk06I9C0pvMvAgPnzOsVzQILkoyZXWAV1I2iOKSfYYWTyqQhegudcwNv8UlsfS5LFyJzw+Rnka0lbIA4//A71JFoJCCZ9ba++6xlhlGUws6aoAwDlApO7Dhp0GDt9RKoAy2vZ9WBBRDHPsL8Pirvtk2tfuUt2lIF4j3yEcw5gR9PS26I5+AFGFVC4R/yhDGQ97O4mIpLnpOo6WN7pgchV6y8kdIvZ+5UZkm4KvyRCknQFfJMHsfjYlXE5o22GJIq34jsTKsbW+qY7/a/40Sg+XNaUCKOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzQ0BY25+SCsq/oD93ojUjpEBLODGWtIgKN6A/oWX0k=;
 b=LUSFBdWQVJj52496+pZ4J5tN6Yy3O+vgUrrxqhYnvfTStrlH5N4RFCm0F4DH+U+omXc28wFvwQYwqJPnzC+x7K3R2DSIFTwJA6xD9k1NCgoxBZqRRU6iRjHOB9UnyREtWRsZ+590K3bHTSjmv4hXysJEo8Qq3bBb1x6X+aR2XfYRkQxX8+cRGg7cWtEVHoLV6QGEiMHDwlvW7VM7E08xCqIN7dYwoWnifvYbpCFRJjrKPyLkp5y/42NeLRJDATHmNVjeMtUZayMZt3EOVFQx1ezUapIJXc/taNcv7D7asi/PfztcFT+9RrpcNdRQOlJsDLF784CGY6LZlaFQqvxVKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzQ0BY25+SCsq/oD93ojUjpEBLODGWtIgKN6A/oWX0k=;
 b=V+rduHfDf7GGMMnsqni9O3Ly3i7Ipd6VabnadKqCPWpVmXxMnfZyuhU5QS+k4d30SDPwkjb2WutbDV5uWjUhcs8nktg634lJNCYU4fkWxbY3ZjRLIETcq/4IL+Z/Hlz+PPtFcszO67MuS+JHrh+VLG9bsAcq17Vs0RjGab1E4aKs9wo3D+xedeSrInHSJqq5hGXrb23Lhg83GRR8HQaUdOKKGaDTLRNQ8ORrQza2YATsgn6qOHYiPHq2uYh7dcrv4Vyz7pTanQ4Rxu54fDO4ZRT+fylT99cenk3c0C0WZSAITmA8KUCcLciNI4Yw505vJMAGyQEQznV1capxJoXW0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 13:58:11 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 13:58:11 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 25 May 2026 22:57:25 +0900
Subject: [PATCH v5 07/22] gpu: nova-core: vbios: use checked accesses in
 `setup_falcon_data`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-fix-vbios-v5-7-e5e455251537@nvidia.com>
References: <20260525-fix-vbios-v5-0-e5e455251537@nvidia.com>
In-Reply-To: <20260525-fix-vbios-v5-0-e5e455251537@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0080.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::10) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA1PR12MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: eee82371-7723-46d4-45e5-08deba65a895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: CCkvNE1esMI2rJDLPAKqucYhTZe+cmo40Uvkoe9MUPzs8G5RNIiGhYmlE7qKKQQRsXJLhQQTN53jF0g0VP2COlcizAAHSxJX2m6sJmFtIIP22bRKhcKdJJsLgUBLjc1BfeszVseQVi9fA14zcYBoBidsKR4CtdWDMsppB0RLW8EDfDdu+0mi2AgUCHn9eNOUQWWtJ/QbZdmiLZyqZy/WZEY7YFYrc7pdpK5K7lDVMO7IKAta+DQBD/xGnS8n9X38JIxWFTa4EpbwvEdEngiQxtGFcf94owvbfCBaBsdoI3a2Hl7GYavxw5kA2F7ZN+WR3peg8sH8Z+i2cLIDD5xXEw/408KGaLNCEKbAPWr6BD+td0SIQ+2NccjKPvc6dm/WAIjmtkWG78opKeH9D7FyTxTUNezbtjUvupDZ3Slbf7j1gDSuj1UGmZVTXCT7iZ8bzd3EGLq1qzGsU69RYsAG/nKbL9iyCh2HXtvcx+gLfWlggvvTzQ3ip3tvcPyBjU7mBmShmDu5n45ugz2aJzlZv5xEOSHNhF92NPVE755LKKI12dvwhReQsHtgKdzHF4CO+UFzrGcOQqeWd7lZ2RPkUesnJ2lbpQ98KcjXgBDknqTCPETx0x2QPWNJlf40sr3mS4TG/K3VQ5jlHSAIrDq/BCKuL39xBihcuKj/Ysaif9Az5hyKDE41EEGXmUaU4Bpp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(18002099003)(56012099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXhEUUdJRmVwaE55b0hjMkEyK3YveTk2UmdlK25JRUphdCtJR1BMekFlb21Z?=
 =?utf-8?B?TTcydXZuV3pqMjNrZ05WaVlDSDdMa3BKZjBiTDVVdG5sT2w2U1V2L2oyQ29k?=
 =?utf-8?B?RU9lTDY5S3JSRVRXcW8xRzRKYmlxaHpiMmlOS2ZMV1lGalVCUlBjRk9VK2x6?=
 =?utf-8?B?L1JlZ1A5bWJHNnU2ZFUvQnluQnZ3ZGhvU2x2V0Q3bzJxWG5kYnR4eUNHRmMx?=
 =?utf-8?B?OVV3TzVVTjVFYVVRYmhTbnZyaEh1VDJWRHUzVDlubmZmT202WmtKS2UvZk5j?=
 =?utf-8?B?RXc5LzlxcHh5SVpvRW9DTjJGdDVJbWRvRmhFSHlYdDlEbGdmbUtubWFGR2Nh?=
 =?utf-8?B?M1R1UGF4cEpuSzFzYmhJMDRQcS80Z3MrOUw4Y1Ntbmh0dExWUk5VWWFKY3FO?=
 =?utf-8?B?TjI4YkRrK2R6d0R1SVBOZnpWalUrbnRuVWtTTVpIdllheHR2amhRcGhwdXFY?=
 =?utf-8?B?MTlFa0o3N0dNbzBaN2tpU1FHamx1RTBGdllBcTY0QW94ajJqUzFKcXhXajkx?=
 =?utf-8?B?ZHFKMWhpWHg3S001RG1ORFd1UEFiWERyZGtjRDd2b3kzTmcyelVNMTd1NzN0?=
 =?utf-8?B?VTFYSHgrSUY1c2FUK0N6eDBNTXliSXB1QUxxVTJXczFPcWxmeWx3NU56SDY5?=
 =?utf-8?B?U1lMY1dacVBGTEJGRFZqWnJ6dU92MGRUeTRIUktNcG01ZGdZL3VpM1NBb3Bo?=
 =?utf-8?B?R2Vybm9Qdkdsalk5R0lEQUoraFArZjJEamN4NnNPemM4Z1IzUlZEQ1haNnhh?=
 =?utf-8?B?Q2NxSjQycTlrQzB6OS9PcTN4bFhUTUt5UDc3aTlpd3ZsQkpMVXEwYXpjYmNN?=
 =?utf-8?B?OEJRdXdtUWhCSlZaRnVnM2lUbGhYK3Zlb29IUUpCSjhsSkxIeDJoMGF2UDNK?=
 =?utf-8?B?dENQZGFqK2dpSGo0RGVjRzhSbzQ1d2dtMVhIcXdUVDBoeGg2M21GakhHSU9y?=
 =?utf-8?B?YTY2RXhDTXRReDU5cjY4Nzdia3krekhQUVpQV3BzcVJrVTVIbU5aUHdKa1Vz?=
 =?utf-8?B?VWJyMzA4RXhCbklUV08xa0VWa3VvZ3gyZUh4akxSOU5oR2tEZFZHenhmaGFv?=
 =?utf-8?B?eUExcGEwQ083SnlXdzBNdjJua1V0ZFhxcnJWTGR6YVUvWVRXeGg0U1FPTlIy?=
 =?utf-8?B?NWwwYUJSL2NsZ2VjZDl5Mk5vR1ZxNzgyS1dTT1NvMUt5TVFjZ01GaTZ0VnB4?=
 =?utf-8?B?UFJDaDJvNE16eHlwczNYUWRmZHpyaHdaODk2UTJCcnpWU3BZYU5CNiswUXM4?=
 =?utf-8?B?aFpvNTJLbXdsTG5sRUdLMmNmRDczNjNLYzhFMXZyTU5tV2F1ZXRZbUtyanE0?=
 =?utf-8?B?YWhPcTRURlp3TFBuMjhOT2RDUTJQYUpEZlJWdG9vNU5EMjZYQVF2RDUzVWNC?=
 =?utf-8?B?WHBoc2x4ZW9qejByaVlEcHFiTGF0NWtiY043cGFLdndxQ2NSNytLTUUvS0Zw?=
 =?utf-8?B?Q1NxcloxbkhIbnNMd3d5eVI3UnNpTlRaaVFRMU42Wmp1L1ZhM2JsUDl5cDhT?=
 =?utf-8?B?NWhxYXRZOTIwQU9xRDdGOFpYMzF1STR2L2xEejRXbDdFVGNHR2RreVNEd1hH?=
 =?utf-8?B?Zk84Njc2RitaemVTTlBRVG9LUHRBVHBLTGdzU01GZE1JblBrNDVPU3NxY0N3?=
 =?utf-8?B?c0tMOUZTaDJ3RjRhQkdNNUwweU1wdkZYTnNWcWsrb0FMZ1JxdnkyUzVOenhl?=
 =?utf-8?B?RmdialZiZG9GUDFNN1Y0SHVxak1OZkNGdDN1eHpJSk1DTVhINnA3TkJza0pX?=
 =?utf-8?B?TG96TVhVa3o1c2RkVlVlK1gyM0h4dTJ0dis4SW5WYWdnNElnMVJuemcwUzhk?=
 =?utf-8?B?cmUzTzRvMlMybGkzUmJNVTQ3dTRsMmJqbGR0N2JtMDhNWTJ3UXBoUUZwQ2Fv?=
 =?utf-8?B?Mmw0RXR5RHUzd1BUenhEUWNBZDkvQWxGTWFkby96SUVEOUhvSFk2dTZGNDF4?=
 =?utf-8?B?OXB2UVgrOFF4aEtOSmVKeFpOQkRTWUtqZDFFaGNSY09DOFhYRDdreFhDZkFs?=
 =?utf-8?B?ZEFWL2x2U2pjT2QxWTFLTWJXTzM3MWM4Y1Q4cU1QNWVxQi9QaVFoS05VOGVv?=
 =?utf-8?B?eDdITU45QmRMaU81VlpmWk8zc1llVHNMVHdMK2g3V2p1V0x1ZTRtTnFTSU9K?=
 =?utf-8?B?UjBVbytjVHQ3VVJqMXdSUllqNTJzMVlkMFNubDNUc1JFYnQ2UFZUWTZkUTFD?=
 =?utf-8?B?MDY1dStJTTkyVG42ZkxCeEJ0TmlxU0RwVFNRVGt2NXU1VEMyVVd6K1FYTDJK?=
 =?utf-8?B?aGlXU3ZucDJMZFYrZ0c1M0t6cE1FMnVXWmtsYWlsc09XQTJMam1qWm5Rdmw3?=
 =?utf-8?B?WmlBbmN2N2U3Ry91RmZxNlBUY2d2WndPS3ZqUEszNEQrZG56d01pRE1jM3V6?=
 =?utf-8?Q?4UTvxN/41npd526Gvh5FKP1YU3oM52Ym/3eCjW265uxNm?=
X-MS-Exchange-AntiSpam-MessageData-1: QEMavzs7XROqUQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eee82371-7723-46d4-45e5-08deba65a895
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:58:11.7526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r2KwDp0ehmDq5ox4tm8iJkronzTtieELwBPZYOH9fc1d2r2g0fSXQ3SaMWx4R9bvyzA1Es6E3YUrFFK4rVZuGA==
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

Use checked arithmetic for `ucode_offset` in `setup_falcon_data`. This
prevents a malformed firmware from causing a panic.

Fixes: dc70c6ae2441 ("gpu: nova-core: vbios: Add support to look up PMU table in FWSEC")
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 48a46684e279..871f455bb720 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -1036,14 +1036,15 @@ fn setup_falcon_data(
             .find_entry_by_type(FALCON_UCODE_ENTRY_APPID_FWSEC_PROD)
         {
             Ok(entry) => {
-                let mut ucode_offset = usize::from_safe_cast(entry.data);
-                ucode_offset -= pci_at_image.base.data.len();
-                if ucode_offset < first_fwsec.base.data.len() {
-                    dev_err!(self.base.dev, "Falcon Ucode offset not in second Fwsec.\n");
-                    return Err(EINVAL);
-                }
-                ucode_offset -= first_fwsec.base.data.len();
-                self.falcon_ucode_offset = Some(ucode_offset);
+                self.falcon_ucode_offset = Some(
+                    usize::from_safe_cast(entry.data)
+                        .checked_sub(pci_at_image.base.data.len())
+                        .and_then(|o| o.checked_sub(first_fwsec.base.data.len()))
+                        .ok_or(EINVAL)
+                        .inspect_err(|_| {
+                            dev_err!(self.base.dev, "Falcon Ucode offset not in second Fwsec.\n");
+                        })?,
+                );
             }
             Err(e) => {
                 dev_err!(

-- 
2.54.0

