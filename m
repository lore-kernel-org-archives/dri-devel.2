Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E58F7CD5BC9
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 13:59:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 333FA10E396;
	Mon, 25 May 2026 13:59:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="XELgjNoJ";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012030.outbound.protection.outlook.com
 [40.107.200.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E06AC10E391
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:59:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUiHu1OJ3ndR0NE0MCjD9QrWThH+Is7r9qsJ2evwnTZFjd0j1Q99ZUxbl68faW8RkgUI4Rm9m3o62L0I4bBfzPeYLK6ibhaU3f9s7iEfz+ULUzYQ0EgGMRI/jO/f1t/iWLPI6rhjY6PxuvZgErnPdclTGl9cTEDjQhN867FEA57uDnYWkff8WL/LWpeLOIphnPN9Dr6wiSoNgiG4hW4xYYyx//OebaMe2+3qC2dyr4UBMIuU3oIOLmLHzrMRlKd3PT06Bi5H7jx5MFnOfh2w1C8b4GzTw5OGyJXoSPQh2oZeZ5C/Pdwu2Vk7VJuCta/I0rfcMBBIyHGpO0UPWVQU7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUrkY/63W0QI8we9xlT2wHDsylVH+l+tgYLHEMTPQL8=;
 b=cEL0vzWJ6sVD4HoY5Kv1gx/5+5cyA7ZC51n3iDBsBOW5a02T1KYSWqQ+VAbYho6AcYb6W1QjMS8GQrkZoBqN5qts57p7T6KzJM8KQXSC+4aFWIB3lQkPeL47UG4vJGDO9sP936SJRNg/+gzqgt7zLRTudZdqfvCuv/nSAILiCybly+u2hsQ5dcsK61+ae80N0gUhe5BGEZr0P3qK/AULGVQMTDm1U573lF98qk+CJLNaBUzOMCu0bwVPzFDtA9LTF8ISatgAdc1v4OL2b2ukQpug+s0Nwv5X6+sfZG/B6ubldlIoLE45ZQTLEroQPS1MsakNbYLb1walo3A8dW2U+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUrkY/63W0QI8we9xlT2wHDsylVH+l+tgYLHEMTPQL8=;
 b=XELgjNoJlbziXtvk/VSb4yvQnHO4JCiCnGJY7q3MR+uB+nmF548shIMdid7ISJFr86Vxc/oO6uebjbXLT/L0PZD1vXaqnlA3kuzGcFILzfZULC51hvEu3srofVo91zuJlwIKT999jDe4Hzuin1At4Rm62aXJ4+QJLkd31ZdVwoyI1SM8jVRUjTOqCt6QizI6jaaDlKLSVjYMODY70GtX8ioIFpsK/oSG5OY/9OqmJgU9eWM1rairdkVxRm+hHrNGb+jn2icJQucmwKoNNMhDQDBkD0tlFwUkkVpcsKoLrXAafvmCPjmoox32alT9Qq0syvZSo1kTf0Wc0k+5xnzTRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 13:59:09 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 13:59:09 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 25 May 2026 22:57:38 +0900
Subject: [PATCH v5 20/22] gpu: nova-core: vbios: drop redundant TryFrom import
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-fix-vbios-v5-20-e5e455251537@nvidia.com>
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
X-ClientProxiedBy: TY4PR01CA0125.jpnprd01.prod.outlook.com
 (2603:1096:405:379::7) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA1PR12MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: d9900b65-a3fe-4c56-ed29-08deba65cac1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: 7pAmBpPfBFTh/oAwPpooq8Fm5F+Cfap3tn9gjLop6wJaZljmKNHl95v4EdNSUSFnx12zoU4igeKfxkpxheLV8IHPBSQ/LzAcOP5HZOL7RWb+XzIx71aOtx4nseh+43JQMqOJ3IuZMT0a+vqd+rcGVctXopbjEYz/joTAB9B5W2peDvO1YExZWsTyrFxH+pC6UghMdA10ReCAaSvndKaOgNYZtm/mhMMoH9vKTM/EKKJBXTLukczAnOvjEBpUQK6ABaV14CZUndSxsqMNX0zEZGyL+5e1XFICKA4wv6TBW1X6drjS0+9o09EFGHZtTUG3VA6s8qEvFdRCEZjoMMuCSp5sM2mIXnil+p/P/Br4rkUi0qKiDp6dLuIFEwzI1qsnrjNiBsbjRJcjlYRs5XLqCpv9qiCSRwieLa7VYruF6I7vaYrjfzBW7vjHm1F17U6qFkA6IutXTZ0pImpyr3pQLvYXwsUlVFLojzEkC2WaqmlvxSG65D73xUiy7jnNN68FG3WUX3L6LjPxyK92sOakg8x+788vzDMcrP+xBHyn2V3QXxKe+RfIvT2VAN042KhmVyrgBqpyoaeFyUvwJF7VhXnsyJ27TkE+O5YD4sbZtRwpnXcrTk37DNJLvsiraOl50ezl3dnCjQB6hOsE1hxTJslPAibjfg3EhoHANDznnBvLIZp4P49IrjJGxaD1yf1r
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(18002099003)(56012099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MU1oVG1RNUJqcnJRbmc0V0NKNVM3M0xpdDIrdVZGTFdZQldKMVNFVElWOERQ?=
 =?utf-8?B?SFBVS29KWUtuK1VMWXU1Tlo4QURUMm9OOTl2aFp1QmF1ZDJ6elFJbEtYakNm?=
 =?utf-8?B?dTVyWGJRdUdTcFdNNGFLcHFuREN5NS9ld3YrRUw2N2dYaFRCT1VNSXJEWEtJ?=
 =?utf-8?B?RDJtcXN6dDdyWE5aNFZDTzVGRVI3bzc4MU5XcUFVMkhOSDNMZ2tsdE5aSmNt?=
 =?utf-8?B?WGZyQkR1dENHSzVTeWVxWEVXeS9KdVcwYnhuMXJhWHBxUmhMUWl0b29kTThK?=
 =?utf-8?B?dzhlREdWTnJTT21PQWRvWk5nNlc5bHJzenl4cnJCQXJmYkpWT2lJcnh0SFZi?=
 =?utf-8?B?TDZ3TEpnRjk2dkQyKzFnd0hPTy83V0k2S1IrL01EMFZDbzFPWGhOMUhuNm80?=
 =?utf-8?B?c3dsUHduclZONmhOVVpJcEdGNjVpMmsyNjIxYTA0UXJ2bU1NR1VZNWNOaXFO?=
 =?utf-8?B?L2hQM2ljRTF5aStKT1QzZXJIRURlcjl2UW9rSi95K1VZQUVxL0ZNQnVlaWdm?=
 =?utf-8?B?b0tPZnBpNTd0dVhDOHNDdlc0MTU1K1g3bWpJT1hjdUlxNXA4Q2xBREhuaWRm?=
 =?utf-8?B?ZTNZT1Q2RWYxc3gvSzY5WTYwcEdOMXFXeWZhMThUQ0N6aHpuMUhoeXhmLzZJ?=
 =?utf-8?B?cXhkWGtDTTNuZU1oY2lFclEyeGRxaGpncG02c1JBMTZVNGZrYy9OZjNwZW95?=
 =?utf-8?B?S1dHMU1SemJGaW9GNkRReUhkZG91dVVPMDBQUGRmYTlOT09HSnh0SWZNcXRT?=
 =?utf-8?B?ZE5kNnFOQ1l4ZzMrUDBJLzBNc29jaGZ1QUlvTndlNEUxL0hVSVVOSHNaZk4w?=
 =?utf-8?B?OEZ4Z2xoRVJScXNKV2RBYjlRS2IxMEJzN2ZNVXVmMGphM1FxdDhQaTVlMzg2?=
 =?utf-8?B?dVJCUFFHUENRUzNwcjNET1NUek9BRmdaalByd1Bxem5sTHF2NlczQldvOVBV?=
 =?utf-8?B?USsyRU5xbjNPeTVLZzFJMXpRRDRlVXRNejZaY0htRGVmOVN5aE4wZ3NCOU90?=
 =?utf-8?B?d2MxWTRhenN1eWRPN3hkK0REeVUxZmp6VDI2d29kZUFRMkxDTE5ZKysvcUUv?=
 =?utf-8?B?NCtvYm9uSTFENlZ5YUl5SU02VnlsYzFmUWcyUElXM2liSyttZWZuL1hTTlNh?=
 =?utf-8?B?WXV5SW9peXBIZFhtc2lCNE5PRmU0aTd2NjFKdGJKMVIySnlCOG0ycFFhRkc0?=
 =?utf-8?B?UmFHZDNBL1MvZlAvKzIrTm50cEdrYU1ZMndTWE5FT29QR0hkSUF6Uk9Ga3N2?=
 =?utf-8?B?OFZuZ2pIK1U2MWlHdnVVeTFmSFgycDZ1MnUrb2lmOHA5R2M3L3c5dDVlMnlQ?=
 =?utf-8?B?U0syRDlTV0szTEU5c1FJMnUwdEw0NTdsT3ZDc1lBbUJiUFdRNUlDNk94U2h0?=
 =?utf-8?B?NXR1TXk4Y1VPL3p1QWxaQVZQNlE4L2h3Q0JPdVlpTXFUdk40b1crYWVPbllz?=
 =?utf-8?B?bmc4YkpRSVZ4dDRJSmtsaVYrUjBheGsvMkZSRnU3WGh5TStaOHIxcFgyNXpK?=
 =?utf-8?B?UXlQaTZZL25yb3YvUmY3bmhjTHROTFRleEJjNTBGQitkSUg3eEN2YzloTGRW?=
 =?utf-8?B?dnZEVjd1T1RWMDVFVVNJMnNVQTRBa0k2TStrU3FjQmRmYzQza0YwS01qY3lF?=
 =?utf-8?B?N1hPd2RzZ3I3SjdCRVFtb3lmb0Vtb1NaWEF6TFYwZGxFblQ0emFBYkRWMjRQ?=
 =?utf-8?B?aSt5UTlzQnROVTV5Z1h3Y2ppdGJuNnFnVEhOckVNR1FlOU9LQk9UdDZ0QkhV?=
 =?utf-8?B?YnJNaWNRZGNmWUlBYitENTl5L05Ha0wydjdxdHR2WU5BazlibU5FVm84eGkr?=
 =?utf-8?B?VXdnb1ZpVE1QRDdOWHo2am5GZ00yM3BGZjlFVW5DeWN5dUdTWU5tUkJ2UEpv?=
 =?utf-8?B?ajBnd1B3TkJCRTRkdXV1M25WRXJCOElSanJTUE5UWnlnczczUlFENnJoWXhC?=
 =?utf-8?B?cDBnUVFzeEh2bUZuamxvRVl6ZURzMW5qVkI4OUx6RmJreGw2dWRia3lXMUZP?=
 =?utf-8?B?dEEyVGJjbExMMll2Z0s0eDYyR05MZWhzYTdFVmdtWTFkcWlPN0N0K0tmNWhS?=
 =?utf-8?B?WnZGMGdwYUNLem1LMmtBam9yeFBLTUtwYlNCY0YxVUZ2VVg5alhaWWJSbjFQ?=
 =?utf-8?B?UGNBTld5R0x3UkU2K2M0ZVM0SG12THI4L0lDMmNFSkFYYlhJOGdSY1NOR1la?=
 =?utf-8?B?eDJPVmxlaE9BYk41VFp4blA0MDkyaDltdUw5S3pvT21LdllsMDl2QkFzUk01?=
 =?utf-8?B?ZFFqdzk5VkRQNVJ3VkJWZHowMFljMTBzcThDZGp2Tm9MRFBPWkJiU3R4a1ho?=
 =?utf-8?B?a0dOSkpSa214RkNmcGlSMUorOThYK3VoK0dxKzVyeU1rSHVyeTd6VE0rd0Fv?=
 =?utf-8?Q?c/B9JiJW7tcjgpvZ6VLesLanjdXcM1cRKWgd1yA5QHjHi?=
X-MS-Exchange-AntiSpam-MessageData-1: JbFb1KafXBeTRw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9900b65-a3fe-4c56-ed29-08deba65cac1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:59:09.0498 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tZ6wtXNLXPCLYRL0c5EHYpkQy7dFwlwMjy6pKJXuDavPCVLJ2JFAxAN4ItFUw+yPKXpljFUjVrJJBCdMER6+Cg==
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

This is unused.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 5401702acee4..6492f158d11e 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -2,8 +2,6 @@
 
 //! VBIOS extraction and parsing.
 
-use core::convert::TryFrom;
-
 use kernel::{
     device,
     io::Io,

-- 
2.54.0

