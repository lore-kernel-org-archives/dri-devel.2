Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E169AC5DF85
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:56:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5333110E227;
	Thu, 20 Aug 2026 16:56:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z+V47ETw";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010058.outbound.protection.outlook.com
 [52.101.193.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37A4710E227
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 16:56:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kl6GXsJz3vKw38yk+XtJCl4jh65+99XrftYm6UVw94wPbQ2C6kZwr1PXEUhwnhEc6bNuffIAsi1qAQQyQjCmxfeXLhV/OzyMQQVjr882NC07fMCHNHz4ojlEQ3RLxcdvw+4Y9RjSSMQnfBM3MNjCo/ZH8Fbjh+0PVfcBUp4JL/hVe1Azr2hva3ierJLI4JjY8DE1yyS5lOyaKWolbkiZ1PCWhypLPegwOAZ0eHWZxdbObc8wJ9qLvM4falnJbh4ODb5cPwo9QTQBSffODEbfzxrs13EPNIWIQ8wVvw89/eGeC9OrgbqXfyXtWdQSnPuQgl6txFM2LTeqzgx3B8ml3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1Rgk3rfpmXzDH86F2FS7kdD9r2K10EjW8nbWDaDurI=;
 b=WITyomwpMNfrtKc9x+SbNfy0A7NBtuyjHNIUDxbXTXdKZmRBINiCZGH17L7cA+cIZcJzcCKuY+bl32xp5smgmrOnhDGhuHA3gK/BYGne1x3wLsu7m2RwvXg7n6VRyQ6v/WsXp6+wFO6tQgSqnWOm+mnRdisAPAOkZuGpl68o9A7Q+1bkGbUfH4Ee51JnVQ+4jnfXWBdF6qqu8Hjfr1hm3MJiTOueeKeEw8CVnRwrFppbe4oSLCk7xp4QyQa49G3iLLl6lIUynuQ59E3yoaYk38H0BVG8CMdrC9OxcR9KxM8yt2cKdMF6HcehT9s8RJIM8BVTKRIyRM7jk8NHKBy/vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1Rgk3rfpmXzDH86F2FS7kdD9r2K10EjW8nbWDaDurI=;
 b=Z+V47ETw/57PRDPoXBVCTy+YXxvC+veBeQykXfCqTM895i6XMB/Ax998gMau85nG3FfHjNSd7EeZsKxsCuONP/fLuSrSvbwtjMkqUxchNzULrRvGI9sRqPlsDFWcr/N+9YNS7MhTQ7S5g6pM9wwB6peWYH78Zq4dL8BCdcF/kgp+w35Pi959+jN1YaI5KJ8p/Gb72i3HUm14kdNrPEUFRz6jGbIlVgcIKTsXCxooRijLS7uYCkP9zd6LgfZCreEzVEeqzZVAh/EsOfWrL1xm8/k0sN1XPDlotnBnnaA3+c3K+tkA50uSkERNaAHSNz/ysum7LxeIIeSKxt0M9JytLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM6PR12MB4418.namprd12.prod.outlook.com (2603:10b6:5:28e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Thu, 20 Aug
 2026 16:56:22 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 16:56:22 +0000
Date: Thu, 20 Aug 2026 13:56:20 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steven Price <steven.price@arm.com>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Marc Zyngier <maz@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Gleixner <tglx@kernel.org>, "T.J. Mercier" <tjmercier@google.com>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>,
 John Stultz <jstultz@google.com>, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH v2 4/4] dma-buf: heaps: Fix shared system heap allocation
 rollback
Message-ID: <20260820165620.GA973874@nvidia.com>
References: <20260820150034.88729-1-steven.price@arm.com>
 <20260820150034.88729-5-steven.price@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820150034.88729-5-steven.price@arm.com>
X-ClientProxiedBy: YT3PR01CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM6PR12MB4418:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b7b2034-f2d4-49cf-483f-08defedbf679
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|376014|366016|1800799024|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: be8KHRK0WTJXHiD+GkuG6apvPmhiAX8uW9IfN2N2p42eKJOAl5RMehemSAj8rjWFiAJjFvz7FIF6aHTEg6JHRixtO077bEAIk7GmJfVhY9QjXuP3kaxlkysIFMxXujb+rM1sDPglfr76sZWF0fufhxNRmhTizKj8FaCuPmWIKmFoZV7aofU8ew24v2vhtw8kW2XZYf4vmkjHGJbY7NH/w4nBPwTTgUYg4mEdxBvDa9zuMrycrpBLIxAyEkyokc8seOo+gGal3nMtK/zhkSGj3DgiaqZlE0bzV2dqt0Q8nEo8Yc+LRaQxlG8U4OwnLLjA5Bf5jGWQ72mWiAdL8BE95khUr41/X6yU4fz/Jy5ZxWYfJ9TxTO7Gc14qp8gUR4fryKId/De6GHCU/lCK6Gn8rRq45PyCmqPXgaCx6762/szOz9hdLNZUYCLCixWctXZvqz8F+VFhrPC66JcYuMD7G1U6oUUNuE1za3BlkqhAhTMfySSlzr3NCsVpzm8Q9wBQ4UrxCsuJ1wZj5sFRYZ7IQolGgF8C5DGttQ7UdSjxegVj4EvlJAFIN7dZ0FFc+HX6THekynMVIltQD0xJ4c9NRhD4Stl8W9h6TAO31Un/DxkMjNQB+yICJ3ahxfFK7KS19J5bvtoPDALJ+c+OtP7qm52AFdjRNrcbXskOuVlg6BQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR12MB9620.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y8Cj/Vjb4D+yErJTNg13TsklrVPx0Cbv6Yvu3+ZYrHgvb28Xc/CyJ7K0POBO?=
 =?us-ascii?Q?JGfAB8TFy7uBiWkZcxLWdTC+axhu8RHxW2zA4Wh7aYw9hGkbONQFTHEf2DBh?=
 =?us-ascii?Q?6WIY5tfZkAKiQ1DH/IbgCpye3xq3ch1LyKACHLxaW0WjEpJ2C/n4K0UNum1A?=
 =?us-ascii?Q?nEKbQ+zz/yA0U6aNlIJeQY8AJysLqkidySyupGU+ddZY3+IhgFtEaZFGF9Ae?=
 =?us-ascii?Q?hAbjHHL6n27MyJfUURDs12et0sf4WsAdGGhqqUcJtfCycfizhMSwTyifTnKf?=
 =?us-ascii?Q?mUiAXM+v3V1ACvy3pn9NTKU1ngOCVtU68c+zLQN9fdgN/lZaJnLVOHPULKg0?=
 =?us-ascii?Q?mKDcSklqLca8TaFfzfpSAlHq3cdxVZY688SQYOK01mUQLf0Boyh9o1QR1E94?=
 =?us-ascii?Q?V8ueTs093mVVl3Coxt6HEDeNAFbsqfZCxXuqt+IFlFRaeTxi3lJiAjWt1VUU?=
 =?us-ascii?Q?bLsUbaDNQPL+sBel3iY/+zx4dce7BLe9y8yrW+ws6pEtF3LtFKxd/XOWZT5l?=
 =?us-ascii?Q?VFf0zeqBKuMpqLknprmCJyr9Ye5nOjh2tAnkMjk8BgCsvVByh75bdf6dMn57?=
 =?us-ascii?Q?Msq3/XKZU/3cE8R+KIHWq6zKSsLhohH6pwwolMP5N8nq50I4w/BKlj3HFbS0?=
 =?us-ascii?Q?LRCdZpsOVxKUfZNUwiWgMRRYcCR9/LYTA2U+/3Sk5b7k+lLgAfwtQUxB5/wE?=
 =?us-ascii?Q?RR/gGUnueuAnEv9aAtLKzl7umeNtacJpBFRLFpGF1WdWBcTDm4//8wt3OHrq?=
 =?us-ascii?Q?kLH7vkzAo6F5+psVueqRxMN3zYVDN+rl6del6iMg8eUzmjvOvZY6spy4nMb6?=
 =?us-ascii?Q?NJKyaxghTwbpk0jkBI7S8JmZt0qro5YC718WpHhWYRrU1LrccqM3/U6Y4JXo?=
 =?us-ascii?Q?IUx++1ZGuMR7J+3Vqwaq5Q4d25sn+3f2tJR3JKXCcr1gbiiIu9HkI9zc3OHA?=
 =?us-ascii?Q?P21udS/FLAoaena4WBHyONKJIUEKrzTXjrtHiWfdHkygHcVrbWPUWDRxc7RG?=
 =?us-ascii?Q?V4Ol+HQ7PrGu9UNSMhWgbyIgFGMQwaUHEqMCr62mCW5bTkj1I10Mhawyh7HF?=
 =?us-ascii?Q?cwGgQSS2lf3r5BvkUUyE1oGryklVr2meaLTGPUmAFSJpZl2Pw6lKZy4U5fRG?=
 =?us-ascii?Q?xZ8SMPLlWLPePgi9BVdHvBah+SYxxlXrq2oMhWfbUYDp9SAh4ECqqmm8gAw2?=
 =?us-ascii?Q?E8zXenCdGnvdfgTLbFGK73SbYS6kTzUPHYU/5lVkYod3Eo5ojN28BrxlZoyx?=
 =?us-ascii?Q?E4prxOWrLr220c1OsdTMjqioMGT71BXXscYK9WPa1n8yanadQRpkw6ZZEGIP?=
 =?us-ascii?Q?hzX5KQH0geD2z8jxQgagFS4klAqrEj0rf8EeUHxctieeAx95r3dCPIEkFRft?=
 =?us-ascii?Q?bnWAKwGMinDyn/91Lzp9p3+lMivH6318esh0McHxLbGbI9sVOwMTVELHmJns?=
 =?us-ascii?Q?DKdRjl80/F3x73NVm1DxlnW8SL2uXXhBrVEpMMH0juK6AH11CXLawgF0Ld41?=
 =?us-ascii?Q?KX0FJT9O3zGEufy9nlWlRVDGS7Q80N/aMWH1LyOlrlRrRjJV9LoZDckELwZC?=
 =?us-ascii?Q?aWpnVo5yw8RysX+ysciap8ZJmiPD/P9axd1P5iFMfUZ++sPrTsWcLDroHLzR?=
 =?us-ascii?Q?CWvg73sd84Iwx0uO9d9jJx7SoqN9pkmxYpS1yJcXzozCDo3PIUp5eRYwo60Z?=
 =?us-ascii?Q?K2kQVLPLEP+q+CDDpT+HWVfPXd1Tdn5SDZy8jN0aNW7I2TsB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b7b2034-f2d4-49cf-483f-08defedbf679
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 16:56:22.1742 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uUJpNUjggZkxLVcZ4E3eopEpAJyk2zm6TMOYkddsgT5XlBlK2H41CS5P3mfFGWZq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4418
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

On Thu, Aug 20, 2026 at 04:00:33PM +0100, Steven Price wrote:
> If converting one of the allocated pages to shared memory fails, the
> cleanup path attempts to convert every page back to private memory.
> Pages after the failed page have not been converted yet, so attempting
> to convert them back can fail and cause otherwise reusable memory to be
> leaked.
> 
> Count the pages converted successfully and only convert those and the
> failed allocation back during cleanup. If converting the failed
> allocation back succeeds it can be freed safely; otherwise it is leaked
> because its state is unknown. Allocations that were not converted can be
> freed directly.
> 
> Fixes: 78b30c50a7ac ("dma-buf: heaps: system: add system_cc_shared heap for explicitly shared memory")
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  drivers/dma-buf/heaps/system_heap.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
