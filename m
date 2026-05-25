Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB017CD5BC9
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 13:58:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 425FE10E376;
	Mon, 25 May 2026 13:58:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Oa1YLF8S";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010031.outbound.protection.outlook.com [52.101.61.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70E2E10E376
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:58:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G46h25Pkd2m5bVe8KOA3MObIVNLDkhQHN83IW3mYESXMnLZWPKjWDel0Ydu3/L6IEXopkZVQogdJPKMjmQZOgQvhGlU/czJwuYO6RZRKQvC2AbEYFJAu8fM8CLDZSlnrAfZ0docqoVjVCg2rc1oFhj5C8DIrMBUJffUdynBwh/UYdExXw2wxVEJR0IfzhnC2dF+XijmjnXVKIbOarFrRasvAh2Q0U0dlwhv9GPb8I2ScOUASS8VRhXtdctCaCjkOauE9T5fOC/KPYYlaaSsd0+9skVjmUEdzzPKUovJ4wqDxH27wNGw+75as2vTbd3AcnWz+I0m6akmnJ7tmTK61ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cmo2IlJBcwtJXMwfctTubQN5NWXZg4+Znv4fSifq6vc=;
 b=ABVNDx/mqnVFw5M8je7W79cMlUy2c72SqLBhBIkXvFO0v1Zwii37XUAvrFAk6MV4SDV/OoRXwHjn46BonbZ49BxXcNQPgaiTLfLVT1gPAISU2Il6kC7H5tLUtSLu/wCkFcum0dUZxQEETLhasjN7sWld6h/3BPK6P1e/o+Jyxsulb8wplZOfTyX7UyfjmDyOXcxiK0mywI5XQzJaZoB7Ak0N1soaFG5Nf+iVwyrNBVr8zcw3y8zAoWg/YQ+N5iGNxLqL2VpZdFaiZgjfDcS8NKwImI/R/qhF8xcnkN8Eaop8oT8zs/RVZu6oKTI0dQdXJZgIJPwa75ML9N3OpGGBpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cmo2IlJBcwtJXMwfctTubQN5NWXZg4+Znv4fSifq6vc=;
 b=Oa1YLF8SZBq3eO4iidVdztGPuMsaDaQreXY8Ge1DNaTiPEGklpIFi8EWmpemXmhjb7FJ83/331RJz2bTH2DW+4D4S5YuP81Z/p2dAaF9JrAuRgPbhEqZwgaH/KWT8GEPGrefCvIvRS3++2KoBxazMw3TzJTCR6HxpZbt/bDHOVTpkmGcDhUE+q+Jo1qPwQcwnD95Wc1SRm/z+vEt/RambLP+EX4w+hdPwy2mOG6KmTQGyecUvbnCNLY+fle9PqlMlTI7ls5+8UgEYdu/83xwqPhQDwUXP6ubGfzqZuqRZ2uWLfU5zYTcjJ+/xIADz07vUqpI/8yjhJJMafqTpnWWFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 13:58:15 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 13:58:15 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 25 May 2026 22:57:26 +0900
Subject: [PATCH v5 08/22] gpu: nova-core: vbios: drop unused
 falcon_data_offset from FwSecBiosBuilder
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-fix-vbios-v5-8-e5e455251537@nvidia.com>
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
X-ClientProxiedBy: TY4P301CA0051.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::12) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA1PR12MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: 23238181-1a75-4319-b0ec-08deba65aafa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: k0yDlGk1AOW5tMOrbUj5XZIb7kuoC9QU85wnv1K0scVN3d7U4kw1TCnY37Ht8x1fImaYYevcq4qU3RW+d/m2dW3PAuAskr/HSpGMtKUsXXIuYrMpxzFqy7DkW846yp39InZlsyBquYFNZM8IQUoO3r8yzYSmlGNLuzm8riPCSVxE7OgJ9PLJeNKIjeHRu67R5tSSSh64ssNDDwqyaW1YU6sjPwqlgBM2rYZOGhLy00zyoi0yjqy6gJIBa+M8KEqghj15avg60M1yvvemNoHLMXt8mZWuNcU1BVc5oP2qRgfmqoqplgHIKt7cyPfQT3cJ/bjvbHmXCyp+HNgN9KG0soIpiS81M7LSVcVCrJVDNQ7tjRz3UAyXiuqN+fO10GncHXnWjzUtOak2nOnFP+GKB/1s9mBHxCykv2DwN5ZxII3v3eaWCLUZyGUZ+/cAvd8Zh7EFlaiwopK+ENnLNYpYYSYkF6l+FH3/mrl6GsZy3QSHDP4cryUvmKTppnpvAKTpSQr68oUIpyI33p2Ls2+07PQAuGWuC1P4hi5uWXrionwoT1Ivuoel9Gb7Nn9mxN6m3ecIdqnHenN3SK1t9YVs3LB/ZUhwl3+ZnkLKQ0qACKT26izFMIomLufr0Nof3h/Ckqgyp5BCR0tEUCeFrDdSHtq5H4tGhCMt1TEMdwCK21+T2RF5YESyBkBGGwdpnZkH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(18002099003)(56012099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZURaM2o2eVBUVHBRMTdzeFFhMlRQaHR4dCtBdG9mOTlUbzczMitsSWxpWDMx?=
 =?utf-8?B?alVscTBHVU5ndHROeWxKb3hpQklrWXZMQnNaamZOdnlWZjNLQVF1b0c1aE1G?=
 =?utf-8?B?Si9RTTJkTGI1WHFvMXNUc3NVU2VzUVBISEEzSVJ2OUVmNGJQTW83a05ORzY0?=
 =?utf-8?B?MldQdWFJYS9CWk9xeGNUazBEdEoyRjNoUTYrMmU5d0c3UnpBSEZsc1ZVejBy?=
 =?utf-8?B?RVhSaWFZNWo4eFduRWVEbk9pTW5mengzbEVUOXlWWmFMbnJrUVh3dXZHV3BR?=
 =?utf-8?B?L1pUeU5ZUWtIa2dESmxORXBPZ2VPemRONXQveXNWSWxlMjlQTkdOMExuNlND?=
 =?utf-8?B?cHNSQVZCRDkxTG1iZnpWajVNYnpybWhTWHZjZ1lMVW0zNnB5MXdMNnNVTDIr?=
 =?utf-8?B?d0ZVdFBhRnFpdzJuaUhNaU5zMHRqL0NPeE1CbDNTY21IS2htZTY3V05qTmNP?=
 =?utf-8?B?RWVJYnJrbmc2cXViYVdYU1dCQTVJczJnWDBDcVkzVlRGZzg4aG5BNm1DenZp?=
 =?utf-8?B?aGRxVVZDWmNRbU1SSVRGZEpib0QrK01CWlZyN1ZaMmhMMDBsakY2MHdIaTAz?=
 =?utf-8?B?OUt3bVh4Umo2NmRFVlVZenBGcnFRR1BFOGVNaEtKMUN6ZnNKVVdQYzZISnoy?=
 =?utf-8?B?Q3pmMEcxNnR6NldGclgzNFZRWDk2aW1QRkd6ZWl5ckViZlpGMXgvaU5xNWdl?=
 =?utf-8?B?bVdpQnZUYXk0YzVmSGFLenZyRDREUzZ3bDNBeTQ5TFJTRVFoeUxRMUxEcDFK?=
 =?utf-8?B?dVRrdUV1WTJwcVBKVXYrZUdCWTBUdDRrTmdJNDVsS0k5NzJ1eFhnQlZMK3pY?=
 =?utf-8?B?UGNHTjlmZ3U0RXlObDYwdGZ3dkM1ODZvdUVMZEJyRGcwYy83a1ErU0Rna0VM?=
 =?utf-8?B?ampObDFIbmk4TTdlSk5lbmx5VGdiam1JQjV6U1p2ZThCOEEyNnlFZW92YkV1?=
 =?utf-8?B?Ymt3M3ZmRUFFM0lUZEJzeDFVcERVT1R4Mm1IRkZvUzBRekc3cGFZYkw0S1du?=
 =?utf-8?B?MWtPZWlEVjVHVFgvZmpMd2RSdlc3SHR3bGlGeHhET21HblhGZXB2SjU1Q1lz?=
 =?utf-8?B?NXRud24wNDNBaXNISXJDTDFKb1RYTTdjT1BCNldSUlE3K0kxbFBIeFk2RzVs?=
 =?utf-8?B?cmxoaWFNUEJMNE54UmtpN01uN0hlakpYL2RxWnhjVDFOajdwTDNNbHR5WnBU?=
 =?utf-8?B?VHV6VFVCZUJEa1lobGZwRlkxWDB0VVNuVklaS2tvZFE1Qko1T25jU2lDRUFF?=
 =?utf-8?B?M0V5Q3RmR3lyNkNFanNCQ2ppbWQ4N0hWbnVTcmZkZVNxV0F4Y2JKSkpHV0RK?=
 =?utf-8?B?ZmMwSy9VWS9RaG9hMGE1eXdydTVnd2tpVTlWQ3gxNmxiYXBnSVRXaFhjcW1a?=
 =?utf-8?B?MzBWdHNXaGVDQktNTWZGZk50U2Z1WnJWczlkYU45enQ4R3dxcmUzN2c2b2o2?=
 =?utf-8?B?TVVQVHBGY0VqY1dKNTVUWnNFR3lMcGVxYlRXd3RteHo2MEZjd0I1NzJOWGk0?=
 =?utf-8?B?QjZYN3V4UUtSd3RaSWlxeG0wRGZOaG9tdkEwcjgwL3hyWDRDSHBwMjRmWGN3?=
 =?utf-8?B?T3JaV1psNTNaM0wzakg5b3BBR1V4V0xLeWdvcUlUdXM4ZFlXNWU4S3ZLSVox?=
 =?utf-8?B?cmpOVXk1VzY3NXlaWTBHaDJYcXIxV1BESTJmcjhKK0ZZRDdNNFR3Qk1aQkNB?=
 =?utf-8?B?ZkxQZWJZOXhlYmlSY3ZQZUhVL2lZVEJJNmVlZlhHNnAxMWJFbjQzQkZ1RFlI?=
 =?utf-8?B?Nkk5dnR2OERrellDYmFRZ2xzZGdtd29iQVFkTEg4cG5KWnZpWHM1ZW9rSk85?=
 =?utf-8?B?SXZmM1BHdUJnUXdCRjFTNWdsMFZqem5oYStHWFNueWlVQ2JuQW9Wd2VCUTNX?=
 =?utf-8?B?RkgwME0wUzNmREJranBzSHJuazdGNHdQa2VFYjJNNkxjK3A5eE41Q2w0VEFK?=
 =?utf-8?B?K0d4OXFETWZtMFJEbVdkSCtNM3RaUlpKc0JwU0t1SHIweFd4UUlqRXJhZnZT?=
 =?utf-8?B?dDZMbmtvRXdKSVRQYzZrSXNONWx1Zy9LLzdPNG8rVnA5Zjk2V2NMZjJsMjFU?=
 =?utf-8?B?cVRnc3k1SFlHMTJ1amdLNzhESDc0Z3BDSkhvai8zUitEOVZhbTRnTUpIZnNQ?=
 =?utf-8?B?ZzdZTERqcTl5QmNpVlcwQUp6Zis5Mi82dkRSSmRYTm0zMVlYdzBjVVJZV3FD?=
 =?utf-8?B?VVl6NEJRaHIzMDBzZ29IaTdteFZwekRBSG92djJZSmFlK1NXQlRDeFFKSXJH?=
 =?utf-8?B?aGxWYXBmSk14dU90N21Iekp1K3VJemFDK2c4SWcwZEVmNTEyajVUUkV2dkJJ?=
 =?utf-8?B?R3VzMjFSamxvS1VTc05haG1xN1NoeDhIeWE1WDJkZ29CY2JhRkcrZldBSDVV?=
 =?utf-8?Q?qJnqIRl6kDXpAY8VBMqLTNrdSM3wrxwEmpNeUZQ56BeTp?=
X-MS-Exchange-AntiSpam-MessageData-1: 22WsjT5iJjdxvQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23238181-1a75-4319-b0ec-08deba65aafa
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:58:15.7383 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e4VkN/ZOpZSVAqNoOdXNpSGt/5/z+9kMl1TOMbb4tbRR7UMtRwZKA0PZrJG0ETHXHwPzWpcXCSFvfugYl7ZqCw==
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

This is unused, so we can remove it.

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 871f455bb720..8a0e16e6c9e8 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -338,7 +338,6 @@ pub(crate) fn new(dev: &device::Device, bar0: &Bar0) -> Result<Vbios> {
                 Ok(BiosImageType::FwSec) => {
                     let fwsec = FwSecBiosBuilder {
                         base: image,
-                        falcon_data_offset: None,
                         pmu_lookup_table: None,
                         falcon_ucode_offset: None,
                     };
@@ -712,8 +711,6 @@ struct FwSecBiosBuilder {
     /// Once FwSecBiosBuilder is constructed, the `falcon_ucode_offset` will be copied into a new
     /// [`FwSecBiosImage`].
     ///
-    /// The offset of the Falcon data from the start of Fwsec image.
-    falcon_data_offset: Option<usize>,
     /// The [`PmuLookupTable`] starts at the offset of the falcon data pointer.
     pmu_lookup_table: Option<PmuLookupTable>,
     /// The offset of the Falcon ucode.
@@ -1015,8 +1012,6 @@ fn setup_falcon_data(
             offset -= first_fwsec.base.data.len();
         }
 
-        self.falcon_data_offset = Some(offset);
-
         if pmu_in_first_fwsec {
             self.pmu_lookup_table = Some(PmuLookupTable::new(
                 &self.base.dev,

-- 
2.54.0

