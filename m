Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD4ECD5BC9
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 01:46:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08B2910E431;
	Tue, 26 May 2026 01:46:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="gBSL+GjQ";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012006.outbound.protection.outlook.com
 [40.107.200.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A186810E431;
 Tue, 26 May 2026 01:46:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BC2vRYeXgzNKzdEDr15JAYK/p57WXh6kggi3N9lsuugHgf//n5BQP0F/5DSKx1b4vn8I6xDjAnG3RycRmdqstrkuln6qBLENMA0WZjKy6phnpUlpQV0tu6UQp/mYUpljgEl0CfowohaVgHpwmjhfNvGxviz4leKkXqTIqLwX3sZtBbkc59SG/7BX5o2ZgwHO6YkQDggfhhdu4NqrP6A5TZE+2h+hGrTMfTlsIax7JCwnpVsh5PPWgOOuh7DOCoNod+6idaid1lTyxEhqYkbpBW8SDM3sJooqdl/nV09lKA8UBdY+Qw3OhSdRdhDms4KWbA3XJsOLlwgCF5rn79B+nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cr2ET7YLCTo57DvrXfCT4sEeYtKfAZSAMMdICg5GKY8=;
 b=Ev/t5jnsv02mXljIfAC5IbZ9F9rWi/RjHANhNI+rmLDO+wkR8GkWvPUV7fExoWcKgKTti/znvhO6hIa7WSgmRx2UH4oqlacVU81/O44QyyM2d65Yr79U2wmNd2MMxjouvq1cnbr5n3nRoP6+HhhPVgprkNYcJjBIUD84t+IypfxfaC6V/c3okRfPTeOGE3p3hl46oLpt1khXpASTitWSeGI2qYKxm/hmZQVOjKCDpS9qq4BHNUFcy7MFHyt7DUr4PHXmcK7RwA8qJ21XigrM/4sASi4bxTPzLRtI640j12mKLeas8U9a+7fyZS8Dt5EsFrX/RVY9uZJYGnXj40yjZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cr2ET7YLCTo57DvrXfCT4sEeYtKfAZSAMMdICg5GKY8=;
 b=gBSL+GjQKU6kfwqrQKjKMNdW6a3XKvAKneupiYRz6SitvxP01HpzlgzPymYGQczJ/xBwoYEzPFkomhyL7bw/xvnLe3qj6JGyIzMthdbbLyir+w8GQDJQCaBvAw1p0jrHT3ojRvEepKBZkmEqMkDdUdXFXFXcgeZom1OfSHa9HXKi+yV5KwqCbHAFQ37qg2Y0w1oxs0Lcb/EzrRIpvWfiI5r3MnTH90eqDZoJGSMKIQqWGrHKGtrJ1a0/0rAx6p36g7xORUHB44Xh/M9KxFU8vRSTiGeI5aY959CHL7Jw+z/3GT4tVufX2NTLL1VlPrhBJSn8g2Yi1uUWwB7I9nQDlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA1PR12MB6185.namprd12.prod.outlook.com (2603:10b6:208:3e7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Tue, 26 May
 2026 01:46:33 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 01:46:32 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 May 2026 10:46:29 +0900
Message-Id: <DIS89FSJMG6V.32Q50TTAUI5DD@nvidia.com>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 5/5] gpu: nova: separate driver type from driver data
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <acourbot@nvidia.com>,
 <aliceryhl@google.com>, <jhubbard@nvidia.com>, <ecourtney@nvidia.com>,
 <ttabi@nvidia.com>, <joelagnelf@nvidia.com>, <gary@garyguo.net>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260525225838.276108-1-dakr@kernel.org>
 <20260525225838.276108-6-dakr@kernel.org>
In-Reply-To: <20260525225838.276108-6-dakr@kernel.org>
X-ClientProxiedBy: TYCP286CA0245.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::13) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA1PR12MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: a5aa0d23-ab1b-4f82-d01c-08debac89d2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|10070799003|22082099003|18002099003|56012099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: IaumM/OlCZwELju9tRwjSsW/NDMtd2qRPhQGXr8VDr+tjxDOatKbE6xqoW56UILLyygSDbG59HM8NraLIVaNg6Xv99srcZySTA3qfzM+U/tC+LWpPDkQXF260sRezVfj6YwSnCeHPQIAr5y3UdO3eoP2P0SERv47cOabFgGSca7gQNWaPsnnkWnOcBe1rcMnDJajOtLHRTxf4TUG0riDPG8njRt/BWtN0q89wyXi1PSAR3yLVmIthzSlLMaSe1fQl1NMA6VRvdnf+1E2JecG0T2DOvi2m4SV6QeQh9IwdeMf2oJc3C52Tv/+vxwPewQJbgpxaFw+Ta/HmdcTMa4yA5T1XbGgT8JlOuPXFiCiUaXiBMyWFl3WpIzUIGlPl5uPAK3nrrjzJnSDDFUOeb8hguUt7KYHFsvykKaa0GxbODnx5R9vs+57nwbACCH9IUvY/93uH9ud6DZYb4OqAVEkD/0hjhPG1NLSYaotMn2uM0E0VcQ3oxy/bsAzgpv2m93X2xqxEwHRPERG/Bl5bHxc841U9XgoZ0WrmPfbEz5Yv3P6/I81bpWXaxtonoWwqGQeEuWEj1d1ImZlvZv8uACJPsknv+h0oqwXy/ohI35KZpk1faWDOVkBBbjkEQzNo9sPiV7J74SUM9Xz/EBCwLMoWYMq1NJV0gSwMYzs5pq5g6e+Jfj33xg99VtvUa27gQP7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(22082099003)(18002099003)(56012099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFJCbHBvTkE0WTRNbkNud25XZFVRM3JaRStEQ20vT1Z2Vmt0ZnJqeTg0L1BG?=
 =?utf-8?B?NzUvdGlwVUZiVVJGRHY1d1FtUXRMbDJkSHAxTWFXRGJveDE5ZVBOam0xYkIy?=
 =?utf-8?B?VHhON0phRm83dGJPb01ZSW9RcThqOWxBWXlXQllVb09naDNlaDJGVW4rWFF0?=
 =?utf-8?B?UGZLdkNoa2Q2c3ArZlR3eU5DcGVEbWkxMzc5aklSSmdEdmRpWVgvZSt2LzAw?=
 =?utf-8?B?bHkyMFhCMEFmS25aeTJ5ckNEQmNTZWxwTEl2UGFHQ2dUc3lMR2FtUVZudzE4?=
 =?utf-8?B?VVJnMXJTNzdXU3FiNms1STBTVWJQT1pOT0VtdFBWUXhXdmxsZ2Qvc2F1Vzcr?=
 =?utf-8?B?RjA0ZVhkdkdrQkhrN2FRQllDM2lXTDc1OGxoRG43ZEluR0RDRHlLTWRtYmx2?=
 =?utf-8?B?TWJxblI3TjcxcjlPdENOcVJ3alhFUDROamxTNXBETGV1Zzk3RXVQaGc5ZmIx?=
 =?utf-8?B?dC96RXY1ZTR1T1A1Ny9KUUM4dkliYU5yTFNXWHlPRlFPR0pXdWM1Yjh3dENW?=
 =?utf-8?B?V3kvZTlGMVpQNmw2ZXFmamc2RW1QcTBza3lXaVA3QkFaY1JrNGdsc0tTZGpK?=
 =?utf-8?B?R25kL2gvcDJ6VzI4ZHl1UTY4Q1J1MERvUkIvbDhXeFpncUhsaVMyVzJRZlNw?=
 =?utf-8?B?R1VpclZDUkk5d2hRN3ZjbGZhek42Y3g4cUgwdXNSWXQ0NjUvYXVrbHpBN29k?=
 =?utf-8?B?c2pwNHYyQWJ3eTJna2dUUmhGaWVMWWJ1cVVjMVlUaFpHeTJhMm9xbUgzeFgz?=
 =?utf-8?B?K3NWelYyMFVFd0p4QUR1N3M2SXIrQmRnTUxPRUNmM1RQM3RRUHVZTTBaSytJ?=
 =?utf-8?B?NDlZdkJ6WE81d01vZGhNQWJ5VWpIQXE4WVRkVDRhQ0Rvb3Z5N1FUcnowOEdC?=
 =?utf-8?B?Vnh5ZENiN1lKWkl5MUhZaTNaQTFtWTc5WXcwaldTaXNsRlpoYjJndUJuSjFT?=
 =?utf-8?B?NjFmTWNmRnFyT0JXUUhHVzhHOHRibERTUzUxZFROcGY1RCtwZCtZcnVCWXBJ?=
 =?utf-8?B?UHByZjhyZFA1NlJza2h3TWR1Ty9qWGVoYVRJQytSbDY3cXZpbFEzNjZRcndS?=
 =?utf-8?B?NkFRZ2tHT2lGcUZoNEpVK0RQVjIvRGdQQ2M4U25kazJzV1FNdEJFc1VRRmNV?=
 =?utf-8?B?bWRXejBoelhRVEw2d1pQQk1JYTFYRVdJZWNob3JzTWNCM0tRbVBVMG5mZDV2?=
 =?utf-8?B?R0NmUGtXdE5qeVAvVzJCOEZCQWJ2TDNEenZ5WkZpcTRtazNKcjRlZG5HeHZu?=
 =?utf-8?B?QW5GcFFuV2tmWGZNTTNOQlN4N25qSC9rQVVFY0RXQ2txK0VGdjB3RGRiSUgr?=
 =?utf-8?B?SjRHd3E0YnQvdjdDc2JaMm9EeGczY0JmUytmRXFCWldJMzFjMlBUbEZOU01q?=
 =?utf-8?B?MmRkZVVkbTNTQ0F4M3pIZlRDUWZVV1B3K1ZDc1ZqaFlsNVFteVo5aUdJZTVk?=
 =?utf-8?B?dWpveFoyNkU4SUROU2tWa0gweUZSWlQ5VlhTYlMzMGN5WnR3N0JzdEM0VzQ0?=
 =?utf-8?B?Y1gralVvd3RPNlNCUjRKUzY2ajJNV1hKTTFUZDdTZ2t5Z045bUlPdGQzeGtu?=
 =?utf-8?B?ZzJwTTdmUDBGWWVLK29LbVd3eC9ZdHJaLzZTVEQ2dVBTc3c3ZTFjTXkxVmIv?=
 =?utf-8?B?Z3pFZHB0K1loWXJLVjFtc1JvbzFzbm5qL3pqS0tKTWw2bGYycE14NHN5SnFX?=
 =?utf-8?B?WU5lM2xwM0ZzSzdOam9yTUdjc0JBTjljNEpiRm1jZldpRk5rbS9oakRRU2NG?=
 =?utf-8?B?b2psL1FBSWtWWnJ5dWJzdUp5Y2k3emdWaTAyWmUwWTBLdmV6aC9HR0orWnIr?=
 =?utf-8?B?UW5KckZMc1FtMWFJVHRyMFZGVk5rUjluMU9mUHpnd3VXYlV0c1JqWTdFcXVV?=
 =?utf-8?B?ZXI5Z2Rvakp3Mk9DK1RpOHRZa0VxRm8vL2RXcmdibkNWOW95N1dqcUlMOXdH?=
 =?utf-8?B?NnFTNS8vL1FROC82ZldPeWhCOXZBNzJnVHExYldabWplaFBYVDNVcUlLWGti?=
 =?utf-8?B?OTNMTm9FYkhnYWdvaCtFeTVGVzMrSE12d1RweFlQVTZmSm12bE4yTTVxdTRQ?=
 =?utf-8?B?U013RVVjMitGNGYrVlgzdm5aYm54NDcwMGVIVGc4dERFaHhIa0loN2gvaE1h?=
 =?utf-8?B?dk9MczM2YWhyN3pSQkVBN1g4bXh0c0RmbTBjZjhOaVFGNGsrT1RsMTZrRytR?=
 =?utf-8?B?cUpOUDd1Q1BVaW1KQmE5QlFWRm11WENmRjhGUHpkOWY5YVhXNmN6cHZpRnE4?=
 =?utf-8?B?UnZDMVhsOEt6R1RHblBOV2g0azdpdmxIdlhJek1DZ1RBNVVxMlVNRFk0dHZH?=
 =?utf-8?B?TkRmLzdLaEVxeE9HMDFUTS9MYnZoZ1JxcjdrVEpPaVM5aHJyKzNoSHlpaXV0?=
 =?utf-8?Q?ewFLe4d1+oNL8CkuTTfdnUPwL+kJrOc0L1NsvSNc6jh5s?=
X-MS-Exchange-AntiSpam-MessageData-1: VfU9nTlZ3WCzAQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5aa0d23-ab1b-4f82-d01c-08debac89d2f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 01:46:32.7891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bwLT0V9PtRvis9BMmLZrl3qYU32Ac2a+QkgMMyRK1P9W0Ut7lTgxme++xhew7QNk8/rqZEi1NcYyYgcRGdz0Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6185
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

On Tue May 26, 2026 at 7:58 AM JST, Danilo Krummrich wrote:
> Split NovaDriver into a unit struct for trait implementations and a
> separate Nova struct for the private driver data.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
