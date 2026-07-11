Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B153BC43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 05:27:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B844910E296;
	Sat, 11 Jul 2026 05:27:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="l9kVQlNE";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013061.outbound.protection.outlook.com
 [40.93.196.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A974F10E296
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 05:27:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K9iVukD1JGT4oOjQ3HkGgePcbt95CdRPzn1kqnWubGbM7tiSHq+AT+QYLDOfcaaFxyr3USGjx5uImzPnD/w9Ji4MXvmK7JKJ6aQhGF5Ht0Y0RtV7l9tP/j3sFpa6/+VoFv+4/rpXaz2yCsIpSTSYN1nuRlpjPMpD79VfZ56QE715uvknxgYpS/NgMqIMjs9rIT3X5y/5bA1M+b1hLBXh0BlkHBgqqreA1sg+0uZGJSgMZAz81GEn3enQyN1qCPdxAtIGieWBrLa3mxCpXJ9jVTmukvaj5CTs5xvchUw9q1f7/3XVn71P3rMTcEg1KjKsxH58PM7o1Beg+GuTtQ6QMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUyaCHlwLjs1+2qkn/RPSURIdJ8B/yqRqa+RP1Bc0Ro=;
 b=OAkl+ylZNFe5A9n8yZbnxhevPksgwRVFPBh/G+qhPlR/2Vk6c3KgQl8iwRhXysuCovdeQ3QTShEn83z5F3/i4Tih3miW3jTgIimsb/E49lpX+7B7FW5z0WS0wjosJynTZbNO77QZx075SXqJUX7cKfPnHCY0xj56d6XlzQuNWvfQYpjDZrrHbJItEUARwBlF13xgFyw1p9guh/cP6l+xE0985rPwPa/VagbQHycCM75Q8vHfMByYHM30ANTpdIa0g8rxS9sY0GIElx0Z3rXVG4V4zRZq3a7n/V8btOxfP7rr7OpaPzrA6F2N5i9or8dohvWGsNjJldQhQHXiHkig1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUyaCHlwLjs1+2qkn/RPSURIdJ8B/yqRqa+RP1Bc0Ro=;
 b=l9kVQlNE1bJfdyti8oBRyl+uC0nFvOZIkcVHWm0q1u8K1267HQobVvBkPgNMrfHwutK4a+YHlmDMdbGJDf9haHYpJFSg1+nNudnC6KEzT8+XcmF12u43T7uSLVDU6fb99koxMyQsR2u1WCZaX7aZKz7JUbpWZfK7T48FLlMQnyzSLSZF/FenCj+hQXMFTanz8OwRxTOYLUIib+Tme5+RsxWns3aJhVM4q45KM/sH9KiRNXUVyQxA/s20St4KjxRn1jkQCjTR6mzOXGRFWBIgKdzen0EriQJ16bXr6/DtBnZJW9jKCKr5Ar/aFjvBVumoyEu98ZZpeZtIvPUxorLNjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by DS0PR12MB8017.namprd12.prod.outlook.com (2603:10b6:8:146::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Sat, 11 Jul
 2026 05:27:09 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0181.016; Sat, 11 Jul 2026
 05:27:09 +0000
Date: Sat, 11 Jul 2026 01:27:06 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Eliot Courtney <ecourtney@nvidia.com>,
 Greg KH <gregkh@linuxfoundation.org>, Burak Emir <bqe@google.com>,
 John Hubbard <jhubbard@nvidia.com>, Alice Ryhl <aliceryhl@google.com>,
 "Liam R . Howlett" <liam@infradead.org>,
 Andrew Ballance <andrewjballance@gmail.com>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Benno Lossin <lossin@kernel.org>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Boqun Feng <boqun@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Gary Guo <gary@garyguo.net>,
 Miguel Ojeda <ojeda@kernel.org>,
 Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
 Simona Vetter <simona@ffwll.ch>,
 Tamir Duberstein <tamird@kernel.org>, Timur Tabi <ttabi@nvidia.com>,
 Trevor Gross <tmgross@umich.edu>, Yury Norov <yury.norov@gmail.com>,
 Zhi Wang <zhiw@nvidia.com>, maple-tree@lists.infradead.org,
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] lib: test bitmap vs Maple Tree performance for region
 allocations
Message-ID: <alHUKv78lizZeln-@yury>
References: <20260711013910.349586-1-ynorov@nvidia.com>
 <alG9NEYLCkMMYTEI@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alG9NEYLCkMMYTEI@casper.infradead.org>
X-ClientProxiedBy: BY3PR10CA0005.namprd10.prod.outlook.com
 (2603:10b6:a03:255::10) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|DS0PR12MB8017:EE_
X-MS-Office365-Filtering-Correlation-Id: d839a5e0-d1e4-4722-f5aa-08dedf0d0da6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +qYwlT000ewj7V17piwylIq3hrVHx/8ONtuZ8RTAwqk9O/fZCpICVd8R3Zso5gmCWxGcdAaF9kfJh6hVEXFQzuDC85C50pFJ+V0ImGPw0AoceNBL2uZ8RPsz06gaDYNMvcnSeG4qg27lMSZiHF8eQyCxPISYPGOF3THP4S/PeCIV1Sv75y7AMC+y7i8E3VRW7UcnT9kUDdoUX6BVHgU8AyHp/yFbrg4eorl8YUd0eo4qDhJxohMsYqQrfyTIASqtb4qhQnDFd8H7ckpy+iHeSPmzrr5CwugFzMSygzysi+8Ntp+SZo8yBXchMVHLoPw5nV9XmJykG3V1TT7UD2nsx2k7AOMzC61HVY3tXEGLScU21y6lY248PgKAQOG91n/UO1S8PUin+KFJGgrU5iSpMa1alA5C1+u+EAAO9sTkTgVGnz1YvT8tPTDSx923yUHXiA/I4bawzxwi8rcbUjiwuily71pe/nH3dijR++8pQZQSW1XK34w2S96/NV1kXuD011gai8Ls6WrJetiY1YnAPuROqH5/oXrUYBFHSnJYYUFysZ+QYajMhBayDpjRedwvQmvYUEkUx8MN4yELObrpxk5Y0gXF7ibmPImd8n1nF7xebFzJaG3I4ulvIo1LxlVcJddLQiZXy+KtliZwq1RbhqcOt5jeP17TsddmfVFm4r8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GC87rIf0JdUnM3oHI+F9cTvtrp0uRGoTg/KCAwzQ4Cg0/kEIevcGxioGkuQo?=
 =?us-ascii?Q?9DGIZyBbYG8e+KTwygNmCv7O1uT01jaoQUJxpkoqKosIFWGnYqzJRFvaHPeU?=
 =?us-ascii?Q?rq9gsqwY7K+2O6wWWKXWXpyCyg6A2yCbxtH+dQOUSV/zQlAc4e/xMIPt8u+n?=
 =?us-ascii?Q?pFgdwV4QHZehk8SrZ71zIoy09tLKT0OTkubwkz1AWWenJ3aHd29ODxN+Fulx?=
 =?us-ascii?Q?KfSrbAgMpTtlawleJ+gGIYCS+FEIg/t1VsEqG3FkySlUGd8c66OisivpA1sA?=
 =?us-ascii?Q?wioAqWZ57s/dCl5ezYeWWi6ckTIJ9q6Kyh1fkTbuBl+sYSXxEnJosXo8lDzf?=
 =?us-ascii?Q?LOBhItWn8/+2qNCVhG+crv+lUcFXSoJMuWfGXat3L+TXTN9JiJ0HzcDJsqxJ?=
 =?us-ascii?Q?oznTvmxhSt++ukllKQ1AvjoZCOOhxIgLJs6U7dXpquFwYTTDRqveOlCBNzlW?=
 =?us-ascii?Q?esH7TIdL+i2yaE01StCGR73cV1H7Hta1zTyYp/Nr6R/vqOrJJTYSPwIcnLCs?=
 =?us-ascii?Q?+JmuCOw1u7PMdUNwK18y3gX4PCjgLyZO/ZGF8D1TeJZzJfvAh7zEpUsuCsp+?=
 =?us-ascii?Q?zd6Pirn2qp7m++Ao+B8Bm1sueGOfjUT5C4ZKOFI/QgLIklr5xQPx56tYrOmq?=
 =?us-ascii?Q?sNzamHyynNBXLc3o3HvR9GTpNboTEcuc5Ap2EE37ziezVYwOw7X8aeogBdpn?=
 =?us-ascii?Q?2lCW1NAq/VeMpIbUxduI+WaCF0CNI971pM1CZPIy+iXj5aIWXt8aniVQanim?=
 =?us-ascii?Q?dQ1pRFobNSc8HQs05woMvuWycxCHE8SsU4tYLm/h2aYuIrHSHUU4BmziNmqF?=
 =?us-ascii?Q?dKZp2yGuBu1Vhp0XbcjFt96vRWTEdfkf73gJ7CYs/jwpmzLA86FzcGe4wIPf?=
 =?us-ascii?Q?oW4lM5B1bxAvF9JIOH1sJxiUMC8hDoswLazYJa+gbRvQBKFu2vl0vNxi18Iu?=
 =?us-ascii?Q?K0fIXzlPmAzVtlI1vk4pI5qbDh1MqTjuqK6omMah0gVoLOKK2QBgFWvvNDeF?=
 =?us-ascii?Q?ZptnR/Bx8oftiiXSrjx3NYJ63mupok42gjyrK5SFmhO1eJe+P0/Q7eDZPEO7?=
 =?us-ascii?Q?X27Q6UUI0zxUvIe+QdUSPwcu9CKbAK8VFkbsE/GZrudP7CBF9fGoroqfdZ/0?=
 =?us-ascii?Q?uNF0UolSjFi0C2Qeyr5ym0X1ZKL2ViBgjIrokAlgTYA0uj6PenDlKZRutPYY?=
 =?us-ascii?Q?i91L+xVZ4c6uKE3b2++W8AeVt2CgCAfb6zdGgTrTp558a2ajTO5bqHBFNOgV?=
 =?us-ascii?Q?V58Q78ea53eug3xfKib43wxeQ0HSV4/dTlG6JaA9a2HmdI9gHnNKyLpJYibW?=
 =?us-ascii?Q?CVxzvLnL+mDj6U1xWloF2SJLlwiP0RxFBPlk3abR9q+k4QJEFpAjtaLm+I1r?=
 =?us-ascii?Q?28DDSBz8sRYxXQarN95huqimtMDI2M69en/aDMkuUUB7TMsnqo34bRlD0SU9?=
 =?us-ascii?Q?GC0pgLohIY/H1N4BOJi9kcximaTPIIkQKAUFB/cwl/tzMJNIJJXZxgRlYL4y?=
 =?us-ascii?Q?Oim3JdWKKcyLB6CFLK5UJJeWKz2MB+BDIVjoq4Yo2YV1RlExkBIQ6OL+8iQn?=
 =?us-ascii?Q?Hko68jTD7IPB/gKh38IqDUY1UDPo7/+LGjsdn0Ot0NDfgoucIGnnyiLT1UgH?=
 =?us-ascii?Q?LSVjLAXO0cjuVnMbu0cqU5CNPEb8s4zl6eoypchbr//DJC9+mdyEnw5gxLo3?=
 =?us-ascii?Q?CdFxVJMEk7H7hAr/nwCnwJC+Hc9DK4gH4gMmeW4uK803CSCRSKtEVIYI9C3k?=
 =?us-ascii?Q?phruqneaRw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d839a5e0-d1e4-4722-f5aa-08dedf0d0da6
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2026 05:27:09.1382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JGsg+uI42dNWFZKnZJXps0GNKs9xE0XbMHM9cxSxsPkYKKl6aPhRVmkY+5RTDuKjIBke7Mcp5ScjQnjzCMMaOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8017
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

On Sat, Jul 11, 2026 at 04:49:08AM +0100, Matthew Wilcox wrote:
> On Fri, Jul 10, 2026 at 09:39:09PM -0400, Yury Norov wrote:
> > Compare the cost of allocating and freeing variable-sized regions using
> > a bitmap and a Maple Tree. Both implementations process the same randomly
> > generated sequence of region sizes, ranging from 1 to 32 entries, until
> > the configured capacity is exhausted.
> 
> I'd suggest the IDA might be a better comparison than the maple tree.
> Essentially it's a sparse bitmap which plays some fun tricks to lower
> the cost.
> 
> Eventually, I expect the IDA to be reimplemented on top of the maple
> tree data structure instead of the XArray.

Sure, will send v2
