Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B45CA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 12:43:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A04B411210C;
	Fri,  9 Oct 2026 12:43:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="rEodKmTD";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011053.outbound.protection.outlook.com [52.101.57.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55FD611210C
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 12:43:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RG/VvCXpG8MU+ROaddPvftaGPx8c2S/8EyKlNi2tTwvjLRW7k6Q+jF6xn2RWNRKR72ZjXUHNild2SNTVhCB4ZrrPoH3Hf3ealujDdTrLvdFPgghCcqn4PotO1w7/61mSe4JNSqrZqcqTd1pwPhJM7abv8VJNxVem3PnvOY2tDp/DnvIFyz4t2UKVqAhpWoUzRs/roXVpLJJdU70ajcqYoDKpYt/EFcUPjwAniFa27SkXrmd/lNRMqAXR4CGCWhHNYNgC6XbhKk7fj69X2U0JkNdHf19coCjhao/OQtR5cXD33AF+kX07L3V1uMyFhfu+1Brnomx2cD3hi9maLIiX7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pI5tChPEUlpTMEYNVy6w2w71wHc7Z6vMnGpuimTjnTY=;
 b=qKBCc7C092yM3DqLqYY4CWcJEuhJoCQniAlp+rgvTxpLQS8GtH1p53DOS/7JoKxsDDT94vo9fFuliSKezmpj8FsTqGcAX5he0bnWT/OTwUc+YfUvsWP153Xwc/ppYl6dRmRE5Zd9/TklIR+Z1f0/jK4tPPflBntUVLZTnHxKR6BWyG9ssRKYlKRwHgLnHiyyhBdeN+lCD9shevGDwqp+PV4N1ruUW2FnLG+JZkGwHJgTcNh9LeEZHrSVOsDCrhzBtiyGR8x1Gc9BaUUAzXZ8nOCDCSa6FprZSxZstbSiM83vPDnld6klKJOu3JL3Zs/d7rn9NH9rGimyq0qXSHJqLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pI5tChPEUlpTMEYNVy6w2w71wHc7Z6vMnGpuimTjnTY=;
 b=rEodKmTDWaaFkoxpsTvUCKU5fC2e+l782fn3ABeR1EEz6TYYl96Sb7mgbyP1KzN2naaxPs4UzHG4jSCeEqlgxQ5VmK3mRoJt5xz9Ul4ByGThJHOCTNCiiaWO2Pty7IAiPNbZKxX1QtPWXjV+0CLK5Fe6c0P3qJRLTOiM2KvPEKgTL7pEI6Ru6xTsUnebYEXqGrhbQIHbzBVRhR8qniFz1+cZUAF6yXvYYzytBcTcjGJCE3ZziGZzvlXS67ldYxL2OYpV6a5g13vA95le/sWg9rnv2h7tiFyFRg1wkWSSyLwhhCEBQYNFc9eufSjbRM+l5Bq3QX2xPmfBc4nxDMRfKw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by IA4PR12MB9834.namprd12.prod.outlook.com
 (2603:10b6:208:5d3::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 12:43:00 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 12:43:00 +0000
Date: Fri, 9 Oct 2026 09:42:59 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Rob Clark <rob.clark@oss.qualcomm.com>,
 Jianfeng Liu <liujianfeng1994@gmail.com>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Vinod Koul <vkoul@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] dma-buf: add a warn-only mode to DMABUF_DEBUG
Message-ID: <20261009124259.GA13920@nvidia.com>
References: <20261005064133.7305-1-kmehltretter@gmail.com>
 <20261005064133.7305-3-kmehltretter@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005064133.7305-3-kmehltretter@gmail.com>
X-ClientProxiedBy: YT1PR01CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::30) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|IA4PR12MB9834:EE_
X-MS-Office365-Filtering-Correlation-Id: 0146c645-e4a5-4d2c-b912-08df2602da7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|56012099006|4143699003|11063799006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: zHqca0ROzhb/b7FfzqrRyDyyv7/GXORm7XupIRcMGghUKVC6hQVNyLgQBbrzsPx+wip5z13YeYcsktuGZlWwqI285j9Y+NdW6RXCbzL6X1g7yvXkeubs7yJ+CDK3v46Kwii0pJ0a7t8dxdjJpTEknQPxR9Z2j6t756pMXAQaMYEiYFuG7vb2zx5zftS72F74yklECjdXA+xuQsjDZ+8EC9gCt70HMWo4jk3KlqXvObwKTNxbB7fAZstbWn5XjbvWdFn1FZNdb8+e2JFUvvFMSyeq+nU35vmOsjZ0LS7k6adIeprCA8Vj6CpPk9dWh5Q7P2TNf3w43Ovthp4octikrI6TXfwT2g2Qe1RcVTcgMmiQBJtUnS6wfBGjkrmkCm29ia/gBuo2XM1qvQIygeMZrE0S76bJumh2aC8MO+nsFA5Kn/aXgnS0LEVmhTEoFDJro6BfEu4nzmZZGk5saLgSlID01Cr8M4ZFZ0PAK9iXMsgBBdcJBZquZ9P1TIY4I7vnovHdHp94Jn7Bze9Rajs3bV4gUcSE5xk0iF1OTBZqW9jdRoIEmRBc4+oaNQR0kSIOZvcGZqK07hZYxJ4LtQGuuiF8TT0yfv9hl+iNn6hMKiIJvQsn+etcIOyu8mUCWG91/4Z4X1npd0iE+5T0phP7Oezjt7teq3qk65boKD6xesc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHBPR12MB731189.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KRNVnf3E3nPzfTSpGK668WYEXxn0CgclMmQbo1DRn9xH3+vNm+KzZTLhix49?=
 =?us-ascii?Q?UR6GqHD9wano7H5J0oEIllbOHA7XDOlderKNwFmKb4pBUCuHTRsCzlWpS7qW?=
 =?us-ascii?Q?YAlSbquSjlRRB55Q0V5lwi4kTPgaBHmxgICsqM4x86Hv7zf73+5gRPrDpm5S?=
 =?us-ascii?Q?LU0+qJOlIuwrBNP57Vkltil29gfqRn6GM0NrHto2M69mER9v2KlQCVYodWwj?=
 =?us-ascii?Q?6XzLOGC3iZG1AwCJ+eS2Or8VRCWmvTD6geNoIkZwfitXfJITIe4/YNpThXCz?=
 =?us-ascii?Q?fy7OmofMFiacd/mg+lJFmPuTVgeu2Si/lbSLrCBFAkqHoyYY6KfEVZJVT4yW?=
 =?us-ascii?Q?adIzqF6cU86jAJ/2mbbI13R4WlmZAZ+Td3vjfl+0f2JWcqahG97eZhveIhHq?=
 =?us-ascii?Q?yjsdbp09u0RZRxB9ZidejeFLjCJJwjepWOvRC5AZz4YN8JgMp/cqrgl6fI/X?=
 =?us-ascii?Q?IbT/wbjxvCOgppT73fhIfF/H3u3DR025tlSJP+g3oqTqohVUzPuUMATvGegh?=
 =?us-ascii?Q?lD2awYc50PpuAeJZBmRrjfaAgbO6Mt37Yqk0sRp06IYqPcRAVdgINaV1PPXk?=
 =?us-ascii?Q?d3fFkD38stsHGwyj5+Z/j3AGZhTX1JmVui3S33ezDlGZ49ZYYsRH+TdBBwuC?=
 =?us-ascii?Q?133mFy4ZsT9ZqeNZYGgNruv4j9EiH0uZkt/ZbZuwfeRMAw3X15hgkq2HVYYE?=
 =?us-ascii?Q?A71u8Dxz78LIl39IlZlN/oAD2m2g1JM7zRt3UwrfRBa6ePHaxzkCp5tIv4f5?=
 =?us-ascii?Q?eyuE4Wr08e2lroyNS6Ygf6pPifcw8yvpySfRszDWXgxavSBRDN2A1a5Ea4jv?=
 =?us-ascii?Q?EI63Xk2nIu9nOo6r0YLBDYn2eh7G4evv9mlG12/n+CkA0wuNUid/h9jjvDbK?=
 =?us-ascii?Q?Uopsd54s/EyGIuEGthPQ1w+AvSiwDhv1MM0v4CbtOUWDYXD6Z6sbtmdUwKOP?=
 =?us-ascii?Q?O7/hL7JarFeJ7nyyxGSQqif5SCBBAyVCRDgZt9RORkl6eN6LoJxrZZbJQIZ4?=
 =?us-ascii?Q?sVRIqfNupeiwUkQ1e/30mUhkBx2Uf0rsoFPSAZKxStNOpS0hCA+UANAKFUbr?=
 =?us-ascii?Q?WuuFPwZg1ElvS8dEXIxPkWtSaNRSG/J2yk9ChNleEhS/IibRx41vi2lrlFRo?=
 =?us-ascii?Q?FbSxzs8R6Oxokd02sF2tzXX0eGAOC6/jUZMuTDa/pkWgygt5HIX5KpH9JI+G?=
 =?us-ascii?Q?YUL6DKkSVNHHVt+z0i9lRBTL+LblPPEo8I8psAxqCzAyiAMgSCbt27IliWRj?=
 =?us-ascii?Q?8XT7AWAk/8PiM43CXyF72lKpILBgTrVJxqBoxZhJCL4PD3HfdgMuF99JQNhZ?=
 =?us-ascii?Q?TQvTJv2O80xTm9Vfd57gF+IB1NgEjfON0dY3uHkPeAORTf4Jy6klZEY93a63?=
 =?us-ascii?Q?pwXn/5KBYmqhiQaMB+YY6BuN3/18kP0TQv001JzIRS5tR0E1anoxU5797Q/X?=
 =?us-ascii?Q?UgNb05yXCpbnxLgT6N8BYixqgoTAAMRr2/CDQAS1pApzO5n+MkAGVnpr0hhU?=
 =?us-ascii?Q?1xMoBdlmkvJ+sng7aEWJvKEx8kYicRHsYHcgS5VjlIKydERNugtndZD9Z4he?=
 =?us-ascii?Q?nwJOXajAQ6SQB4CAVftyerzV5tcG1yhwRhZIacrjp7XtqN1SVWRLN7n83skI?=
 =?us-ascii?Q?HeMJrr1938TcgoNDMZN592aO3K1vqXaDcj7HV9qj5oKCiXJBzEvv/eaWJios?=
 =?us-ascii?Q?MJFVQRTeOvIRQn//PPtSwI/Yu+SAsYtmnHMXe1b5zvcre9Lu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0146c645-e4a5-4d2c-b912-08df2602da7b
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 12:43:00.8390 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /syFiWzKHq/jLDbwCR4wPlPvUanvhDyyCOJXdshZq+ZKB0nyscB4f+HoSk6Unan8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9834
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

On Mon, Oct 05, 2026 at 08:41:32AM +0200, Karl Mehltretter wrote:
>  static inline struct page *sg_page(struct scatterlist *sg)
>  {
>  #ifdef CONFIG_DEBUG_SG
>  	BUG_ON(sg_is_chain(sg));
>  #endif
> +	sg_dmabuf_cpu_access_check(sg);
>  	return (struct page *)((sg)->page_link & ~SG_PAGE_LINK_MASK);
>  }

I'm not sure I understand the overall intention here, I get what this
patch does, but no distro could turn this on by default when it
touches *everyone* using scatterlist in a performance sensitive spot,
and anyone doing testing can use the existing option - so what is the
point?

I certainly don't like this patch, and I don't like the word "DMABUF"
in the scatterlist at all. If we want to add something it should be a
general mechanism under DEBUG_SG that allows anyone to 'hide' the CPU
list from any future access.

Jason
