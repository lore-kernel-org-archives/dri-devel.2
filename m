Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB43CD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 02:56:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38A3F10EA23;
	Tue, 19 May 2026 02:56:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="N2qi0VdT";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010035.outbound.protection.outlook.com [52.101.56.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC1F810EA23
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 02:56:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YC0bN6ZyMVkLRMXAQX9GPe/Dh0xlE4g6LXTGX01gY1HHlRJsAEuExiR9jN/1mfzRGt/kBI02SARaNUxUO03OfxtF9f8ZwEDf2oFHDsAQK0CNjy+bOcwXS7ZxSaVrgZ4X76IMWg6ZMb0N68Gf3VugsNXzU4F13pTxZ78rxwYGD0VuVLdLG19+bc/+xjOXJXP+mETK5RJgdE52xpnQvlDcnwv/X9xkEiCfSO7UG5TTvSiOPa+Qr7JYUQsCsFV5y45kGAjVZ064c3zXnFFP+L2LNGxYWiJh6PuL1rdlkXBNFdkMpihWXdiaIfhP6VeYYJGRrrlJDdVwyER8ffhxsQqSig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNHd19TeyU9wPjMXxolWckRRp2l7vcGctWrRvPC7L0c=;
 b=KfuMe35x9prUlME7CWtD9N0AL3owo+2fXFrux4zXBhJkGYZVe07a1NMKIxRVp0LA74mErzaKjAPvxlC9Ca026sOHAIPvVT6zcqe/HYY/oa//dq9eXTcv4RWtVLyGyNvcBB7AysG2Lb7oW0e/Vtwk7ZnSTXQd84aERHHz65gnZBOERt2NCgYAJNLheRWUW9DDbOgOjdDa4E6GwktNQqtscTph5VV5KgYJ85Sv/G1R2gY6/IjjE2lEseagX+Gof6ohNJ5eurezzjLKaTgzA/fpqGneGNaZ1kH3ROiUrjrNTFeaU+6GSs63YJUvbBMk4vImKmESuZ+6rIHfVstKRrXrsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNHd19TeyU9wPjMXxolWckRRp2l7vcGctWrRvPC7L0c=;
 b=N2qi0VdT1IaukRz9xnkZeI0K+dLD7xDIutuV/4SIeqioJ2yyzQbMdNPLWoDB5Ar3W9EfD3q6nQmo6crmA0LMQPWtxxneBXvDFyyJqsFQHgE22lm/fo1jQmzpv1N4WeLmsFiSl8pMuWYXIDe28QY57mLNGhErYp5wkUnpOdVOfk7Wd5+6mwiX3H8d5vP/oE18PsTfc3FZ0gSqDDXqGH44wuE1ZhbwhEdsFSByWbn4Jg4+WUezrGknwFnqZWi5Vo0rDkn9h/XaXlOKZv/0cW2LNnrmivHswI/XL0rF2NjYpraPOANOJ+xY3sjL4PLC4uOfHUYJTKKNSgW3eGeqUg/hQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 02:56:17 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 02:56:17 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 19 May 2026 11:55:01 +0900
Subject: [PATCH v4 07/20] gpu: nova-core: vbios: use checked accesses in
 `setup_falcon_data`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-fix-vbios-v4-7-5d3f210c5602@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0028.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::15) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: e6e4b18b-8904-4f81-4093-08deb5523281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: xx4vdDMxvlDp76zIHYk7o35JerqMNVSbTbsCiWYG+1rVh+bHjXHRKNq00Hd/CcZ28jHlQnPZoTrwBt5lTaO0oEB1psCi0WrItqxW86MsD8HVO7UZyRlj8VQDmYO+usgtMRykMb9Xg++iRM9gXfEApqvS9zVJAMiOdUhsm3OcKM8h1qCmBbeMBmIJ+mdBCrXSdYV5h76eeWhLQ6P0A+8f4IuDjbFCFWikX0Y89KIHbyCDRHMURJs7tIE9iEZwC2Lg9RdiUEiqmeZqIiikWeyxYVLgBseBMle4MZjMyKb4OhCFsx4CNGDbsofXLZYNcc3PDfYIDoQHVtGDrmuVuD+78bJ8dRYXZAn19lZqzb0wJPfqOxa6fXlnLoN0ld4qmLRupDBlmtVA3SLVQoWPdoGGSzbt2Oy8qYwbmXPgUSsbkuoiHW/bh2f3VvxzMPD1gOc9Xy+HFsKZKmGrPJ/YOOU2QQAbGmzwpAi/UeqWfUzEdul2mG0vsrK8d8OcWB6FKq2PqVSXgJSyEBLhHpy3Mjr1ZxRcLvnxwITuqFQsOj9R7v6MkbAHGRXmzXt84VR1h8duDjxJjnLIfpF1vPXimY5s2dqI0OCRcNse9uPPsnX4vT9YUIhAfeYYiPEmTnvUwTxdHVw2SAKFTq6eTeLkUN4b3bKBh/IHKQSZHwmAK4XjpAXmH9h/v8ErcXysMmyHcFFF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTNhQnB3bm9uM3ZHdWJQQXQ5RklmdEN3QlFLK0ZCVURpZFM3MlV6TzJTS2s3?=
 =?utf-8?B?eDQyTnJEWUZYcjJ2cGN4WHhCVE5RVkdha0t4Q3VCM1hPUmZIL2N5aXJ4MlZr?=
 =?utf-8?B?NlBEU3UzR0RIVUdkcU9KVmFJVmxrRmxYdkQ2OWI3NDEyOXl2Mjd4aFFIdFBW?=
 =?utf-8?B?YjVLR1h2bU1sWG1KbnhJeFphdnRHY0EycHZ3SjdkSTI3QlhQU3Z0Q1g0MW54?=
 =?utf-8?B?aHZSWDBPWDQ5SzRaYVFTN3BRaGozc2xuYjRtaHJGanFnWmRYT2xzWEZBOVFz?=
 =?utf-8?B?b0tTeFVZV25WUGw4RFVqQ1pqakdFbWFPZE5EU1hZNDlEUTdRSDd4OW4xaHp5?=
 =?utf-8?B?ZVNqRnNweWFuQTJtUHp1N2drZ3A4VlFldytPYzRRNEorMW8zV3dhSHR6aFBE?=
 =?utf-8?B?dlBMbERYQ1FraEVWQVhNTFBScTZsVGRSamZyZGYvUXE0d0tNU1JmWlBFWDNa?=
 =?utf-8?B?d0EwOWFOZ3l4eDBWcDAzRHRYL1hudFIwYzJ3dHI0U2pTM015R2xkdDNubEVY?=
 =?utf-8?B?OUhjNWxBanVuNTlBNS9zaGxBRTZnWEhBYytyOXgwZUt5N0tuVEdxeGJibkZn?=
 =?utf-8?B?SEhzY0FkVDZqR0hXL05sV3kwbDJvVFNuY1Y4a1Q3ejEvcWlreVFUb0xET1J0?=
 =?utf-8?B?NlNvOE93U0JDZ1R6OHE0eW1qTk5qR2NxbEM4eFp2VHh3VUw4enhUUWxHTlVT?=
 =?utf-8?B?a0JPTHpBR1JWczcxRXRJRlVKQ0VjZ01HdGtzUlowK1UxMmVFNTc0VWZ2VHNY?=
 =?utf-8?B?WGlBZmJ5Sm9JZHB3bXRGVUp5NjZwRFNheFltOHl5SXVIWG5nL3hSN2dESmdS?=
 =?utf-8?B?QlN5WjlaUkkrR3ZrdjFkbmJhN1B1ejEwL3c2STVsOXU5bHcrS1JFRG1NdkJ5?=
 =?utf-8?B?N1hZRVNnZFVkOHNCRURDWnN3Wlo0cVBlV2d4T0lPN05rM2FSdE93a2VWNlkr?=
 =?utf-8?B?TFNnWVJnRFNxYVlaYVJHemY3RWc1bFFrd3NqVndJS21tRGlNQmIyNGIvYW9p?=
 =?utf-8?B?SmE0RVZXeWVxelp0Vi8wSXB4WXp5S1IvN3FYd1kyZjlvU2xOVDdwZmI2QkpX?=
 =?utf-8?B?V2FaR1hjbU9VbjVDbGNvam9YSVBaVnBOb0VsdG1VM0hScjJ0cnZPVjR4Q0Fw?=
 =?utf-8?B?TEZLUDc1SWVFNnJLRVMrVjNQR0ZuOVQ1RkhmTmVVbWg4bFY3VXlNSTF0R1pa?=
 =?utf-8?B?ckhIWC8wUWcrMHExd21pUTQ4R3U4MnNrcGZpUklZU0dvODJYRU9UWmpOaDhm?=
 =?utf-8?B?YXkwdytvSjRCdXNQdGI2ZXN3OUlFQTZLbzhCY0IzbnE5V2xOV21oQ3UrZmZ5?=
 =?utf-8?B?TS9XeUtYclBGdmliTUNFZGZMMUpZbEV0NDNWLytWWGkxVGcwSllaMFdFS0VV?=
 =?utf-8?B?SkpVWUZBQ2p2cExmRnVHZjJSRHQ4dTJxa2w5QjgwVDR0dnFXOWxsTkN1aER0?=
 =?utf-8?B?dzl5Sk5jVmZXT1VHcnFxMjFpNTdwaDl2ZGw2b0tMNlYrbW1IcUlwS1pPd2NT?=
 =?utf-8?B?U3ZuVFNpQUxYeTRmRVlXbGFXK2hhVjYyYmVsay9GNWZRUUxwTG9neWxZQSta?=
 =?utf-8?B?VDdoNGltVnlCYzBIRlAxdnJsblh6aVdTVXlJYkNzTFFDa2hVSklKL3gwc0h2?=
 =?utf-8?B?Z0RaUDhnNENRZ1ZsUDk5aEVNTUxFTHFSUzJ1TVA2QVBkaC9pVlVKUml1dUdz?=
 =?utf-8?B?ZVBJb2M0S3dzcmtzNTZ0eXlUV3RIYWlKTG12bzZvV01EUUxCQ3ZnNzB6Mk5G?=
 =?utf-8?B?bTRIK1lUZi9FRldESjhlMk9QMGd1d1FqTy96SWV5dnl2blZCaHh2WGU3SFRL?=
 =?utf-8?B?VTlVUDhUMDNydzRvd2p3TGk5dG9ZMEs4L2FYeHZkYjFZeGtJa3VMdlB1aTA2?=
 =?utf-8?B?RzF2VGk2ZEZ5QkxibTF3QU5SdHlRRmxkMUNKQXFtdFJQdDAwMjNLSVVDd1Vs?=
 =?utf-8?B?QTd4SG9tUkMyVFdJdGFpYS9hVDgzSlJMSGtSRi9JNDM3SUZLMFM2ZE1CT0d2?=
 =?utf-8?B?WGllQnh1THdCRklXbXhDZW51UHBHa3d0NlRMM3RVRUt1QzgwbkpjVDdaL210?=
 =?utf-8?B?dkVlbTh6dU81NjkreVQzTFA1d0oxdktqSHRhMHl1aWkwbnhkemdJem1jVC96?=
 =?utf-8?B?dGtWU3AxajJUdG02cE5Jbno5UDJNWllQY0VHRDVzMDdLcUtuYnQxbnJ2TlNq?=
 =?utf-8?B?aFc5alh2bjZOS0Vyc0lVenZLR2pZdTZTbEdXUmU0RGJ3cHEyV3I4U293M1lN?=
 =?utf-8?B?NDBneVJKNWY1WUVJSFhtbVpNeHpYaEZrdVY1RDI2L0ZWM2NreGlSWk9keWhH?=
 =?utf-8?B?a1hKb0o2MjJKUDlCK0tTdUtGV01RVDQ4bUl2ODRXNWVieTcrVHlBeWZWdUxF?=
 =?utf-8?Q?vcjbXxK0d+K3ktA7pEDFSL2cH4CbftduVQh8trJM3/zFj?=
X-MS-Exchange-AntiSpam-MessageData-1: zXV5q2lKw4xFGg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e4b18b-8904-4f81-4093-08deb5523281
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 02:56:17.4962 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kh0OLjyIYsFrJ/QyH8KLQ98W+vJb0KIPo20o6sDyHt1wo1maOckbycpYEiSYTI1gqtYi/QkKXg2qxjsl9eYjlA==
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

Use checked arithmetic for `ucode_offset` in `setup_falcon_data`. This
prevents a malformed firmware from causing a panic.

Fixes: dc70c6ae2441 ("gpu: nova-core: vbios: Add support to look up PMU table in FWSEC")
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
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

