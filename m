Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC31606A683
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=sodha8Jt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E47811214D;
	Thu, 26 Nov 2026 08:21:17 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013013.outbound.protection.outlook.com
 [40.93.201.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3100810E457
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 08:21:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tm7euJS13iDuQROcsgLPBkLuU6ZcvUz8Qyov/ShUEPyV8BePj/9Jphq1I1esEN8kXVzghr1c7cTYtjEsuXxKa/OW9hbRyRVsyfHPEUgLG0y46zJCbPFGN8geqyOFCT8QwtmtbWa8XnH/+osDSxBZ57euH6TMJx+1r+8JeRUph9Bj5tRbyrQEwG+eB9fFPlpgLaaV1xwWbEBjMc50EWFOoKzsLgcPilahdxZf7tLcboALZlVVctIcZCoL7u/WKNUl0xrKLd+sxZSELb66Hcman1sYhHxnDliSKym9fDRfSop1M4RpTMRjrHBWX7qThecB68os6FslvfrjVs1EN1sj4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBevFF8TA5rvMdGJJPQPZiqCRmy0R5Npc2meGVNszEU=;
 b=jC4HxK/W1fQ4jFPlg4EsrQotbdMd3i3bbg4PiXZ5n8HFmUhzfdpIgT1e8/o3KaXaTTXfxC3TTmDABudRz3mj7lERitLfT6Zc0/URKSQlOw1HIgl1Y3dyPWvtRCOkorGOHg2oHdH9Rff0WLmvE5dSJgLR10Q8mbN5KAWrOJ9Ohp7rL34A6FnMCsTosUa0Xoucrbz3mwzDZF+0iBcPIyirDgxaxko3bDquhCDYHb8xnpZHKIDqccZHTPo5Y+Syysv6EYQ1Ol3smWjvG7ELO87SvjIhd4gNequ+EaSRGG29V3lwAUG7WHAIrXRIb4HrSR6cCeyDmnGf2UjdKt3/RB+0iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBevFF8TA5rvMdGJJPQPZiqCRmy0R5Npc2meGVNszEU=;
 b=sodha8JtLNFwHF90V3+mcSPN5/l7HKpGSp+9JgFoxbIKC2tqIM/i/mKR3Zn3fcFFzkQUNwYSox9h5WPfOp0lu5Xzr9gdbLe98PyfENOLxLOWFMiq4lWW+XjKIlcaFxyE1ZmL+e+c46POoo6YnhAuJM30hHqaItXVzApF0dQDE6C6ZgH2hgaJa7Qla1f+fYvBIMNvOguWXDNaI8Tr52ag7BuhMc/2g3gwLJKrR6YC8idOLzxK8qs3t9Hbtf5T/M//gFd++rDVTA0qJzXh2em+P4sHKI9OgHJRemMIw8uW2/pKac9r9r1RCA3RhM4CuLSTiKZtSFYGDOM9oBAaZW02WA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 LV0PR12MB248855.namprd12.prod.outlook.com (2603:10b6:408:603::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 26 Nov
 2026 08:20:45 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 08:20:45 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 26 Nov 2026 17:20:11 +0900
Subject: [PATCH 2/7] gpu: nova-core: gsp: remove unnecessary start of
 `gsp_falcon`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-boot-rework2-v1-2-99a1dc6c7cc4@nvidia.com>
References: <20261126-boot-rework2-v1-0-99a1dc6c7cc4@nvidia.com>
In-Reply-To: <20261126-boot-rework2-v1-0-99a1dc6c7cc4@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP301CA0048.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::17) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|LV0PR12MB248855:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b9865b3-3dd7-4bad-2122-08df4b962b16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|10070799003|366016|22082099003|18002099003|56012099006|11063799006|261009223027099003|261021123027099003|10067099003|261102123227099003|261022105027099003|261026140227099003|261021121427099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: in1GlTCsSLN5qry54mPAEdhFtxXc2dmOfSlWS5SHYMAa1E8cqMBgUdj/xJ5cCagAf7eqBXJzVmsGmSfFajgieW2lUyiJLOWGLoECe880KFJUmaGO2a+7p3KSSixOozpQ+PfN0W1IpRTjWr6t/uVeLyVAj9rHPkM89FJRfylEElAMlMiKD77+4DLWhmANLZ0Hrl5TflSITU+AGFYagj/HkKBn8MylkFtUQznaRlTqSWbhwEkKCRvYl5ERKAqMbu+oitOPLYuxDalQUEINLlofe2B58dYklZ/jv4jt3zcjnPMNSoWZY1atDK0aO4N5gcHuvNuFK8FPXivIlkpY4nnQT/lN7OWeRQYdC00oGSsorkRYaeT+12Ke+iLzriHwBvLAOBQPuURicsEPbBZTL1554veGXtaPwTsiLHhX5be0+VHef2FTQlGyTK51E2/EOBN9mzHzk9mVYCraRrzGSHwCH6M9h/UYBEGkhpaPL6yFP7buQn0NwZIGvUHjM3aJmA2F6z3Q2kTsffMnDDd1+uWlcff8qp2MdsYGq4JqLDdxoqejjcw/SKU00+IoM/madP0W2c0/R4hRLVAgsy5HFCoaOhBwJQbJCthydF/PHmhlR5K2D6vmDwCMiuWU2AT9ifGBTbGpBuNi/BJaKggfUzph9ml5Y6m611s9pE91TBOxzAY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(10070799003)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(261009223027099003)(261021123027099003)(10067099003)(261102123227099003)(261022105027099003)(261026140227099003)(261021121427099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1ZaVGV6ZjVzekFJUWhYNkZqK2RWa08rREN0c3dPTm9McHJ0cEpmV0FWa2dW?=
 =?utf-8?B?dkNzYmU4TW9mVUNKcUtLOXBzbkc2cW1PMmRsMXphcWxYN1Z6cDNHdUJLbytQ?=
 =?utf-8?B?VDhXRFRTYmhwdmZwUkRORlJiV2E3dXpRZktpbklpeTdONGJ3MUNvRFBhUGpD?=
 =?utf-8?B?bnBDRThTOXdCREhSL2JlVEQrRmNSUFZkUndFYWpNUFpYVUdpcGVIVVlnbThS?=
 =?utf-8?B?UWxHRFVLdks3YUlCK2FGN3RtYmxLcy91ZEJwQ3FWMGdNYXRFL0ZCZnkwZ2Jr?=
 =?utf-8?B?Qnk1SFl6T1F6elUrYXpaY045YlB2Ui9wazZoKzhDTEM3Wk42dExFTmlwb0Jv?=
 =?utf-8?B?Uzk1OEhCbjhLSThoNW9hUkxaS1ZWZ1V3N1d6YjhoNXUvSUg4RWdCOTQ3NWxS?=
 =?utf-8?B?TzVqMlVPZDJmNmtXelIwUHhVWFJVUHVnVGdhS2oxSFlEOWRyM2tVeURsWUZy?=
 =?utf-8?B?aFZJMUR5aSsyd0ZKbVVMOG1wU01WMFZNVGl3M2x6Rm1TS1k2dmZGMmtkWWdN?=
 =?utf-8?B?UlNZSndwVy9JNzVpditRQXN3QSt6SWxGYXhUaktyUWpENUkrRDFLQ0FsaVZT?=
 =?utf-8?B?Qno0bnBzaTdzOVNZSUQxbDlsVldyUmF4NFNkc0p4Vk5FWjUwUjRHL3k4YWNp?=
 =?utf-8?B?ZlBsdWdSRnZkRHFpWFgzQW5Sbk4yTWRpc3pkMi9LUXA0V0FhL1BqMFU2b0Jq?=
 =?utf-8?B?RWVDdlg5UGwrU0N5MVh1ZFlCcWh4SEh0b2I0MHl3RnJqaW4vUlRleFp6VDB5?=
 =?utf-8?B?M29mR0RvM3V2K1JVZGVnYXphVy9DWExaUHhrVG9aNkw0MGN1OTI0aFRRS3lq?=
 =?utf-8?B?QmdqeEUveEJscVRMRG9XYkd5SnphUEFXMXAyeEpBZXROU2RoeUlsVndZc3Fm?=
 =?utf-8?B?TEVyZG9ydVN4WkE4VmgyREhzbWNKU3puaE9vWjh5NVhrZHVNUnZOa25aQWVv?=
 =?utf-8?B?OFNqVk1JcWFXL25NVGVQQVBVcFhLOThvQ3h5MzA3blB6aFVCamRMc3ZMcHho?=
 =?utf-8?B?bmNuL2swRDhTcVhDQ1NWcEpwNGVOUXdsTXFPOStGV210OWxtQ05IdlBOSDE4?=
 =?utf-8?B?TlhzaGM5SU9qSXlRU3BMTExyaXFmejhFTjlWN2w5K1Z1cjhUaE83aDJEMThl?=
 =?utf-8?B?cHJaMVY5emlubjFXdGZjL3F4LythOG5QL0k1Ly9zZ1NJYnY4bVNtaUdkNXVN?=
 =?utf-8?B?Vit2VWFEclpjMHJncFE2SW1nZVNtMTM3OFVpZjBET096eTVFMzIyY0l1V0hB?=
 =?utf-8?B?WlNwdm91V2p2eUZkcW55Slp4cjVtVUV1L0gyeWE1S3U1K2xpOFhtS0F2NUQx?=
 =?utf-8?B?eEdCQ2FvdjgzNUd2cGlQUit2Qzd3WUhudktYbDFXVC9YRGxNZWdlczF0ajNO?=
 =?utf-8?B?czh2WEZmM0RUVU0xcTY2VzhYRDRsNDg5V3NGajVnd3BGUkQ5N0I5WjdwdEZq?=
 =?utf-8?B?Sy9qWEFheW5ZTmhXMGJTcEt0WHVLVW0yQndhS3o3dDNtUEowZURESk81ZjJn?=
 =?utf-8?B?ZzR4RTF1Qjk4cWVRbGlrNS8zL0VuL09GQU9DUU5ZNTI1Z1JLcWorRFQrcHdR?=
 =?utf-8?B?bTVjYTExNGNHR1A4eHFVVEtMQnBGU3N3aWg1Wmp5TFZqMVhBNkhpSGUzU1Bw?=
 =?utf-8?B?MU14bTZjVXhRaVhOdmxXNGZiSjFJRzBNRmVSVFB6dzljdW9CNW5vMkladGVD?=
 =?utf-8?B?MzVUUW5YWU11VnI1UWJWazFxdmRhRndIaTV1b2wzRmU3MVBCS3FKUk8reU1T?=
 =?utf-8?B?elZUVm5PNUl6NTIzSEU2SyszUVc1ci9MSnBCeXJpa2IrZTlMcU01MU4vcG5y?=
 =?utf-8?B?N21NcTY5aEFtSzZKVnpvSGI5N2JYd2Q2emtVaEJEcWxKVUMvT1kzc0N1OXZ3?=
 =?utf-8?B?cGxpZ2NSNzRIdFR0Z0lZTWJGeEhTaEV3ZzV3RUlXY2gyKzZUeTd2YU83TjFu?=
 =?utf-8?B?VXBBM3dIN1cxNk9CV3lORnc5NWkvRkhka1ZZbFlMUURFcTFUWWZOZjdwUWkz?=
 =?utf-8?B?R1ZTZ3pFV2h5cnpKanhES21MS0tVUVBzREludWZpcDR5V2VsWmhEZ2d1SHNU?=
 =?utf-8?B?TG9zTjU4UElaRW94TXlYd085M2FDU2cyanczMFowdmhQVnVFUCtBclhUSEpp?=
 =?utf-8?B?RTlYNXpxMGdRdWhONXpDOExpVXJjQTcwS2Z5MVpvSEk4NVd4eGdUTlFCeEYv?=
 =?utf-8?B?VFNqY0ExTnJ0VEhJTkk1OVBlOGxxc3grUHNJSjg3SjljUG8wL3pmaC9OZDl3?=
 =?utf-8?B?UFRERFo2dUxsMnZ4TG9tOTczTEM0RW9hYlJZV3NSWHU5bE91UjVDQlIzQllt?=
 =?utf-8?B?TVI4RkFnNUJMTkxCZmZxM014eSt2b2tPMlhteFhmelpxM2dEaWtDeURJa3VZ?=
 =?utf-8?Q?IniHCWBTAgzqT1qA32VE0bEDsrSZIaVmZCBmJdUQ/hOWN?=
X-MS-Exchange-AntiSpam-MessageData-1: CkUQZASyP8KOZQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b9865b3-3dd7-4bad-2122-08df4b962b16
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 08:20:45.1401 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8upOLX2Onb7ThciQM3kuSJ1YUzaULlfN7oO+tRY14Ek46pAnwO/dzmLhPMrY3949lhi5HAvpYnY0FMaS0ugXjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB248855
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

At this point we just need to write in the DMA address of libos and that
is sufficient for boot. Remove the unnecessary call to `boot`.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index e90db1a23032..2139279d40c4 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -294,11 +294,10 @@ fn boot<'gpu>(
 
         gsp_falcon.reset()?;
         let libos_dma_address = gsp.libos.dma_address();
-        let (mbox0, mbox1) = gsp_falcon.boot(
+        gsp_falcon.write_mailboxes(
             Some(libos_dma_address as u32),
             Some((libos_dma_address >> 32) as u32),
-        )?;
-        dev_dbg!(dev, "GSP MBOX0: {:#x}, MBOX1: {:#x}\n", mbox0, mbox1);
+        );
 
         dev_dbg!(
             dev,

-- 
2.56.1

