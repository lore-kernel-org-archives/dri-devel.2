Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707E2C44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 05:00:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A462210EE9F;
	Wed, 15 Jul 2026 05:00:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="dQirrTxI";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011059.outbound.protection.outlook.com [52.101.52.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60B3A10EE9F
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 05:00:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cy7vPnRi4H0FZGv5zHUuNpSewkGaelHMhfjtxJ8poqPAM2+vb8RvN+8BOxljWYRTSOGsXI+aFdu02cEKqOyHyH+2AVrmoEV19NKG/99vzJ7k5Jl2rXwH+gApmr3Tc06bMIxEbhF83iMDt2yaN98T2WhMWC0uZStVjAOYVMuMXpOqcc5CtJe2/u+8TvrM62LMTJpA7vhDA6HetD1Nu6SZzerPO6EOyABInQuwNdxD+TvS64bxMsw5rERK1lIG3xEYGtqLIFrYHZMkkM1B7OIZBQMgsOw+6/ba86amud8jL33sYtUc6ylmTJETgn4UQe+SixUaREWgD0XuS8sx19MoJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2b/e6+bnSYw4j7KDSygNg9yE6UUAwIHZa0itrO7YQ1w=;
 b=GdmL68qGr1xC7BPfhz3YFhpQkbj9SfV59/JoLnir1+YmmBQwIqm2MQpWvWOzwe+Ip/rtZ6LDMN5xnO44NMfhsojHxefTyDa3vwlwkwbFiFBMuoSXFeAz/CaX5DHEZRd5RSx0z2dp4Qxi9x13qNVBWppH9Xjs4DExCK4CIKCV/6untyhuoZm3S7aUtnfBVYijrIq1Mag5D2olLv5xhF/76RrZ23U9OL8LxCeu68biahlafwpnxJYYh7tm4h+V8Bu4nDd+BBZTyi+97bCPFeR8Aq2lcRAxNV0uNEQPEwRxrH/9+DCag38aOIRmL8uTXrlgGS6fiVzx4iWESxTpeuBa8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2b/e6+bnSYw4j7KDSygNg9yE6UUAwIHZa0itrO7YQ1w=;
 b=dQirrTxI0/MpkQEQ+1SQfHIA3IHJj+GuL5NYRoM2qj70QA/sRzMG4hsYmwRSewWIBwR9/tGfU2pNevQCb+A6Z5WsUyS2gFAem0VQue9eUNL1PYQjW9v9hlaTjR/33O3cHJ+fJd30GMgNRxt4Sy6nd+HMI4v7WGKyGsXeMJRAUW399krOUmKbs4JyCz91PSsojHe8wYWh1R94Wa5qXL/Q9IPx/q9eFtOduRmJgBrPi6hJNDa6V9Q4FCZcENDgLShf7e4U/H62jsy16ekQuZlG1TSbgXKy4DRws0Paz6CXzX/qr8yyWvqgDIr4P94D+HraAoDNDUewTe5LnvvLcHgygQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by CY5PR12MB6454.namprd12.prod.outlook.com (2603:10b6:930:36::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Wed, 15 Jul
 2026 05:00:15 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 05:00:15 +0000
Date: Wed, 15 Jul 2026 01:00:12 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Gary Guo <gary@garyguo.net>
Cc: Eliot Courtney <ecourtney@nvidia.com>,
 Greg KH <gregkh@linuxfoundation.org>, Burak Emir <bqe@google.com>,
 John Hubbard <jhubbard@nvidia.com>, Alice Ryhl <aliceryhl@google.com>,
 "Liam R . Howlett" <liam@infradead.org>,
 Andrew Ballance <andrewjballance@gmail.com>,
 Matthew Wilcox <willy@infradead.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Benno Lossin <lossin@kernel.org>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Boqun Feng <boqun@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
 Simona Vetter <simona@ffwll.ch>,
 Tamir Duberstein <tamird@kernel.org>, Timur Tabi <ttabi@nvidia.com>,
 Trevor Gross <tmgross@umich.edu>, Yury Norov <yury.norov@gmail.com>,
 Zhi Wang <zhiw@nvidia.com>, maple-tree@lists.infradead.org,
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2] lib: test bitmap vs IDA vs Maple Tree performance for
 region allocations
Message-ID: <alcT3HupA6TogWSa@yury>
References: <20260711063602.426311-1-ynorov@nvidia.com>
 <DJVSHL6XP43R.1INHQRXAG8UA3@garyguo.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJVSHL6XP43R.1INHQRXAG8UA3@garyguo.net>
X-ClientProxiedBy: BYAPR21CA0005.namprd21.prod.outlook.com
 (2603:10b6:a03:114::15) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|CY5PR12MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: e6fd0e72-a140-422d-6c7c-08dee22df528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|4143699003|3023799007|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: mKmOuVRKDudZccPCw/biSxjCLdt0q3pERMlqYbYGRRrAFF4XZZ6fb0u2VjAIhBifM907kX9t7WohLBDPmkuS6NASqEgR9KmGKFMXhjIDg3Upnbm5Rc0CtxvcXy8KfmlY4e2BX+7m9pndQXaSMHMpdSgjdMSOGQc7Ja8JDKvcXURxUiPSOgCkjEuvS3sm2+sTnZiBKZ2eDVVH45deswb8X5+C2rtSvjVmtUS3GhtlInRCmOsaVsoKCHesTPrVhSmXoQpVLSiG2UkvvcApf0A3l6wELbScvGJaEa/ekKr7RUYxKHJhnpuhukvrKGDnZ5ilinROCpji0Ws6GtTRpD+bAIBBq91nAIfOWwN2ji1cizLdZWOjnj1jRleEoWq1V3OiPw2EB4/2954negkVR4UsPEYWCt1V91vb7OYbEiHbMCcnKmvOUImYml/In2C8lzfXQdokKZWUKuBzaou0ZV9dgRehJUh2izLagVzAsBltFWAlmNz2iWj7O4mfqUfRxIKNTKb//nbELfJTl0VyJ7jNr003tlojsCHJDclhKvAhx2LRR39qRUSVBXu1EYbg/2KNiSggHH/EN1LqnNsDDXf9vD2lHs/e0WSaxrp0irmZfTalp/53gdHG76ta8idCS4Q5zoW5YxQEPMhqO2sfrWle4mx+ChFIiKXKIzuCX7b+RqI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(4143699003)(3023799007)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YFHzUjDR4VHuKb1+oho2Q/1rYwOwz/sCmjl8usAxAJmxW/fxNqJ4rR83hIlz?=
 =?us-ascii?Q?kAOg3UTZ8nPbxuJZmaL1n4Y3dBHpw53hZDZmgZmQKkXnb+/Pti/a1WxlosS7?=
 =?us-ascii?Q?wAptm5e6Hhhp4dnp0oRcLeyFZ2MeihjxY3ZLcAAVDWXjdvRrCQCwVA4hyhEA?=
 =?us-ascii?Q?1rOtRuO+a65w8wWLCe8HrXUnb2ro6YuZKfziOGU7JVaGnmaTlLsUewM0MGy/?=
 =?us-ascii?Q?puSEzRbfsUtBd4XlPXFyi1tOgHP8HiU63y9XSsieeo/VsHxJIxrA0YsffUsW?=
 =?us-ascii?Q?fOgq4eG2XXCwmJ/VC21O9LjLq1UP6X6U291OcwVonKwOrUx1v4L8Su4JAah5?=
 =?us-ascii?Q?ekdO0Y+TVtYvySfEIFjvRmLhMklhi1B3Zhv7xHEtKqjtJ2oHx5yGFk/fETNb?=
 =?us-ascii?Q?w69NTQ4tyZF+mk6uS+DEif2Px96nxxm9hQTy+2fkkGDBFtPw3fKToO/vWxUo?=
 =?us-ascii?Q?6DzVWmhJAHYtgR9Wn+Tke/oe2xkiXubZLCT2Xl1/ivYW6xDUO0JcYmn9wSgA?=
 =?us-ascii?Q?ZR/RuNPBNj+L6/rorltbtLhVJAp0e+N4G3xxRovb7SjvSYPhF+ZvGOJL35ij?=
 =?us-ascii?Q?mVrIMTvooWNn/tcuqW4YHKLL+J4iEtvIjF2F4lx0acrXpC+IIBiMdVgk07sQ?=
 =?us-ascii?Q?/NwvjRy3Q+l02H0xxsYWMCkUBXFBW8NkLsVVf3k+1ZSOqD2AF5vH9aSO2xXK?=
 =?us-ascii?Q?e/0266b/XiDd8v8BTGM0QaAwtktr+hWxt2k1qoKz5UHaAL47opm68XksfqAi?=
 =?us-ascii?Q?fxa3qVmVaXiRNi4r1ITsWDCbnMCzSzJP8xzQ4XtqTVhEOLr5u2hH/57Mo2Us?=
 =?us-ascii?Q?GcTMzwpemB0MX+iHu+kao/hZmVE2TaKtDw9hA/nKOAVete4LK0Ukr1Ae4Kiz?=
 =?us-ascii?Q?5B/u+tnsVznwnuVc8OytwNBJqL5ovCGs/YADwwXSG8WUMrCrdHbgC2wvvNs4?=
 =?us-ascii?Q?2ufky34kqMw+8U7AbQVm3o25pUnBlbR0jb92E+sMfJQVbmBoHa5SGvu7VAd0?=
 =?us-ascii?Q?cVwmXcw+jyxiKyRm/BKiMVV/bWR/+2GsrErbUtZkOyxg10J60rRLVz7rVutq?=
 =?us-ascii?Q?YqBu/yHEyM5oTq6fb6My9Wa8MNaA71AZ1cVcsT0S04VlwObG9kGbonrFYJii?=
 =?us-ascii?Q?/rNQ0D6Lu8Dj1qs56SmtNUsKM9jjh5FdHE+Do7AC0daFRFZURxH3FNBILwMa?=
 =?us-ascii?Q?cSFmM3G/WfskDYxZ7BEow7NLTxZhBvOstlPrRmNRpAdXIqiX4+uYvg5yfLku?=
 =?us-ascii?Q?YjiDsYsVdcjosARcAdaRQju7SC+ybV95lbAH8DKM4NHf2lzS32eOsv9qCgM+?=
 =?us-ascii?Q?fCNd2FP9CaANVBsgoE720/64CeT7W+qyq4cEYHvG0ewwuZdYdjKZ0u4at01r?=
 =?us-ascii?Q?B1YYcX+WslHyWOaD79YfYhlr0WcpZk9rtS3T+Qopif927PyPOArOGl/BL2+H?=
 =?us-ascii?Q?a/7dm1nwnty1a2EzqWmbZinBjwdXfu+hkP8QlZ7MeXZli/MWTzAJXfylaCK4?=
 =?us-ascii?Q?OE781irUwoA2bjvTpVPyKZPYrk91Qk9J+HHc50zubmI+MFwFnKjEXyIj82Oq?=
 =?us-ascii?Q?WTE+BFoKROESDTa0K93MbE1m9H2P4DG9MV+VhYo+FfWuSEB/rXN8vH4ma0O5?=
 =?us-ascii?Q?q8VnC5aoYcLa5nCenRZKUvIo8uXWJwfHqPTG6bowyxgzdrL0305etqMdyeAb?=
 =?us-ascii?Q?JbZ4pny7vQrYlq1rTeUUU1/P25a7f/jCGLOXpKe9ehjCLuZJHXJhh4Hbk1z6?=
 =?us-ascii?Q?OZtADkeZHQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6fd0e72-a140-422d-6c7c-08dee22df528
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 05:00:14.9815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xj4/jW1RejFpqnisqikQut8olPPy/5wnu88lA8EomxX2Uz7WlAVduaKGglbFtMVC/uieKenPk26MkaGV6hvu6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6454
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

On Sat, Jul 11, 2026 at 02:51:28PM +0100, Gary Guo wrote:

...

> > +static unsigned long __init benchmark_bitmap(unsigned long capacity)
> > +{
> > +	unsigned long count, index;
> > +	ktime_t alloc_time, free_time;
> > +	size_t memory;
> > +
> > +	bitmap_zero(alloc_bitmap, MAP_SIZE);
> > +	alloc_time = ktime_get();
> 
> To eliminate possible effects of optimization messing up benchmark, please add a
> barrier() after start timing and a barrier() before end timing. Probably you'd
> want one between each loop iteration too.

It was never a problem in find_bit_benchmark test, but OK.
 
> > +	for (count = 0; count < ARRAY_SIZE(region_sizes); count++) {
> > +		index = bitmap_find_next_zero_area(alloc_bitmap, capacity, 0,
> > +						   region_sizes[count], 0);
> > +		if (index >= capacity)
> > +			break;
> > +
> > +		region_indexes[count] = index;
> > +		bitmap_set(alloc_bitmap, index, region_sizes[count]);
> > +	}
> > +	alloc_time = ktime_get() - alloc_time;
> > +
> > +	index = count;
> > +	free_time = ktime_get();
> > +	while (index--)
> > +		bitmap_clear(alloc_bitmap, region_indexes[index],
> > +			     region_sizes[index]);
> > +	free_time = ktime_get() - free_time;
> > +	memory = BITS_TO_LONGS(capacity) * sizeof(unsigned long);
> > +	pr_err("%-6s   %12llu   %12llu   %8lu   %10zu\n", "bitmap", alloc_time,
> > +		free_time, capacity, memory);
> 
> I wonder if the numbers could be more useful if it is somehow normalized (e.g.
> by how many iterations are performed?)? This number can be computed by adding
> up the prefix of region_sizes until it cover all capacity.
> 
> Also, the capacity should probably be made part of the report header for all 3
> ID allocators. Given this is randomized benchmark the single line, when taken
> out of context, is not very meaningful anyway.
> 
> Something like this might be better (fake numbers below, you might also need
> some fix point printing):
> 
> capacity = 1000000, regions = 100000
> type       alloc (ns/region) free (ns/region) memory (B/capacity)
> bitmap              1795.730           3.421                0.125
> IDA                  465.556         339.314                0.134
> maple                186.296         197.413                1.548
> 
> capacity = 100000, regions = 10000
> bitmap               163.091           3.093                0.125
> IDA                  614.478         335.459                0.142
> maple                174.502         182.503                1.554
> 
> capacity = 10000, regions = 1000
> bitmap                28.448           3.374                0.125
> IDA                  418.978         333.641                0.187
> maple                185.398         211.138                1.563
> 
> capacity = 1000, regions = 100
> bitmap                22.530           6.100                0.128
> IDA                  427.550         364.320                0.144
> maple                197.280         234.740                1.552

I can add the 'regions' column, mostly for completeness. My experience
with find_bit_benchmark is that people mostly ignore it.

Your version may look more 'human friendly', but the reality is that
people understand the original version quite well. This "nice"
formatting is a substantial complication for the log parsers.

Printing anything else, except for the raw test output numbers, is
simply wrong. I don't want to force people to *my* analysis. If you
believe that ns per region is more informative, you can do that
trivial math yourself.

For more serious statistical analysis, one must take into
consideration measurement errors, distribution skewness, random
variables correlations and all that fancy statistical things.

In your example, you divide one random variable, ns, to another,
number of regions. Each of them has its own distribution, and not
necessarily normal. Simple divide operation becomes not so simple,
if you do it right.

I'm not saying that this simple test requires an analysis of such
complexity. I'm saying that raw output numbers are always preferred
at data collection phase.

Thanks,
Yury
