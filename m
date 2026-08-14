Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D1EC5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:53:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0C7810F609;
	Fri, 14 Aug 2026 14:53:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="uJSz8Nt0";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012043.outbound.protection.outlook.com [52.101.53.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92C0210F609;
 Fri, 14 Aug 2026 14:53:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vpakRn7ul6n331TTXsjAsZzWRfxgD1qxCpUovI5cxYUZG/fwLFlkXwrdYyXwdj8asixTPa8YjE047As4HpwWNazwVqYPZF+P7JbA+xHGs8GsjnETYwH8klnSIc9SqJea1LcdtAOJcxzdaKc1ScNOPaQEKaNGywcQKKBSq0au3KDrW9Ub0VuZazZzlra88AMNTGzFUj3vjCgfsRHqA3dVs+aj96oUXTM0oztARtBiUkeMfmVEi32BuoSjpUuS1CcGkZClrBBTVLkMsJVE1cn/mx615LaP1Kz4R0NA5YQV66aOWf5Yef+NYmHZ4pbD40lRdgnpMXY3lgmIVxLhbfQUzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2v69lxdqnOfcQIGRh4sLGkvX9dV11mB+9gFWwipDk08=;
 b=kcYQmEiEWmlBaOtASXaLrftnSXtU30/jzuK12JqgquvdY9lzpkizWqHIbOS9elYYrtA7aouXfdrGmfYXc1VrfThIBwEDctAUF74EsAkWu+6CkdKm+6Wb6YOBJDT6Fu/lyonI+p4ye1KsVF5gLUGDkDVUFgRinnmDC5HfdigJCsHfPhCql8w654K7VmHl1iQeZccEn8OGHUzKWGX8zORDzS09E6lDBqqii5PAERDV877cTwKCfZUNScwaN3ohvy5jUEeTuAXDLfU15FaD1WGoKgBpWQ8/6cXtzdHHpTVd3Ly+Fh4EnxwtstSk8Mz+RsePZ49pZ3TvOV5d0IWBsIKpYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2v69lxdqnOfcQIGRh4sLGkvX9dV11mB+9gFWwipDk08=;
 b=uJSz8Nt069Rxy3c7rH9dq7DN57iIMeyZOwmrhBI9z2IpoZDgTm47vdpvM5UANrhO3FbNwxb6qQNZn+ZcPZtV4rRs79D9XZCkptZOT0ZAGjJorgDiLl9NXRTW9SU5gez9ABNp6IzSkoHupJJMp+TaXYKJfLWO1Ou+ZnMdzk9K7P0zI4UXHUeEs02QkiQ+CIPZbpbXiVjO1YdMVaOn0/7LFZDcXruEBIqwIC85/ROpfYkzsWcSkICezjhqUtXKtLZG6WF23VT5uXwAX/4pTfxdZWtP5hI7XVzxvynSD+ijkKXYDe30U9wwHD8To7G1k5XYWj0zfah3iZDuijZAVjzgYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by SA1PR12MB999109.namprd12.prod.outlook.com (2603:10b6:806:4a1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Fri, 14 Aug
 2026 14:53:22 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 14:53:22 +0000
Date: Fri, 14 Aug 2026 10:53:21 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Burak Emir <burak.emir@gmail.com>,
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 John Hubbard <jhubbard@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org,
 dri-devel <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v5 5/5] gpu: nova-core: add ChannelIdPool
Message-ID: <an8r4VECQ8iFP8ze@yury>
References: <20260812-chid-v5-0-6c767770b3f4@nvidia.com>
 <20260812-chid-v5-5-6c767770b3f4@nvidia.com>
 <anzxKO0X1OrNRD32@yury> <DKNN2LHZXRIH.5LUX95CZ8EA7@nvidia.com>
 <an4NvQBt3389jP6E@yury> <DKO414SNC0B2.248FUBGJGSPLU@kernel.org>
 <an4xDp29VX8Am0uR@yury> <DKOAY7J1IFTP.DMKSXK625EW5@nvidia.com>
 <DKOECWHEEAK1.3N3JXH9MH7Q58@nvidia.com> <an7bG2bEd28AbNRr@yury>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <an7bG2bEd28AbNRr@yury>
X-ClientProxiedBy: MN0PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:208:52c::32) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|SA1PR12MB999109:EE_
X-MS-Office365-Filtering-Correlation-Id: 34707e90-29ad-40a8-7537-08defa13c98b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|23010399003|22082099003|18002099003|11063799006|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: X2zupriND6A2BngtDbaJ/wmFxJTf/xysA8uQqndHmTz+xpNcN+tSmLFXxZmvlxT7geYP8PUJ+0iUoLx9MQpt1HG8HA4YM3bOmrlmZdDB5nvGpnvH5eIGeXDOO39P5sECvFD7dDy9mWRUkfFWG3BM0c9mRvA81kaca0+T8yf8r6bTTkU2JXA2VxBCimoAjTfzDxMG2U8BSHrz2n9vWfAH2QTOnjXlmN/1Yvq/uafjTS+AMdEjXAOiwfFC/Ns8EIvfcKy2bEGTQUfazeZWqgxZeYJXYXVP+dNqBGvlsnge4ONcOPFuFcvNapykCWnCljKivMfMtmcvk2K+uvQUk0mQIPgID1P87WFRWnirW50hiIXynHc8fyy6FCDgBHCFImCm6exQEaeAKkNIAMp4WWhYDY08hjj/6GCcTMZ8My/yAe9NfcZa8E2nS6MUu0A/Gva/wY76rwg2DlSETGEayTChjzVs1krQ4H8iev2nj5c7q1TWm2ktEvAp30ZXD3QO8rycZLAxbPUGLi1VybN7NQwxQaPsWAr/h6IsMOllcVhmYcOMw9v6RBDrkLBxttF6+f47717a8WXYmiuRGklBYyM7cdGTRXdpIjp12AsquO6sSH62BqOnFQMPnvEsKR9cnFAR2DYWjFqaZs9NB7fFL8U48Hjt9pmc6Jst4pslFMPxvXQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fIvwTEz4TBiRqLIP4748vBIeAMcp6Dw7GxMUMKsVpit8S6jQVt5QVp+e4gMZ?=
 =?us-ascii?Q?1MH3nsJveZE/gDXY1IXX8dS8+KRj5ZGHEDwhCgE+wxUSuMkXjEH6M2QFmJJf?=
 =?us-ascii?Q?5svRfhqJmb9ZR/8COYoADxv7RO5xoJ9m6XgaHTP2zt+H34xPF/KEzmDTin6L?=
 =?us-ascii?Q?DPkyBHOJaTF+k324+ntb2AC/PITCGnBNrXij02rHGncAh04O5ARsJ3jpc/kh?=
 =?us-ascii?Q?dlAo3m9WkMErY59St9UfBp81gLjsx3WEKrKZQVslxA5CfsqJBiGJPLhP7OHF?=
 =?us-ascii?Q?qz5rf/G/2mQ/O19NyxroPoI/Onf/avVXV2ly4BrH43oUx2u2x6YGVmW2HzCE?=
 =?us-ascii?Q?QifkX83ZyBb0y7jn/1zVdRLGGpC/omt+LCl2jaFLi9Av5s7ZMU5m13PmoqR9?=
 =?us-ascii?Q?IH1KYyAZipJ6ypFr7ugqTyM1zUVNrrBORbm+pSXx7rcFwi2aI9FD6nx8qjTf?=
 =?us-ascii?Q?YB2tTt5WBKU4JUb8Ss8DgkHgmhRvYvCaa34YHWXJuYU2OHN5FPxLRRhLxp5M?=
 =?us-ascii?Q?7ccpieLmwBkUp+BtheITBsbysg35hFZoOd+dfY+u51bT1u5fwRiXNW54J51/?=
 =?us-ascii?Q?0EwAcoCb2H2feun3TvIs2a8E6CUz0Tgb82oURonA6nPIGqodOyV29aST40cP?=
 =?us-ascii?Q?V+Mu4Yp3RvW2mtx1WJT5Fp2I5cL8zeTo0/IXOSI/YHZERmMqiLI6kUCrX79/?=
 =?us-ascii?Q?q0I58qva6EX7dCYGQd437ywCx31Vb8Rcf6761cAhOiXR4c3YqAKQNmmOJxuY?=
 =?us-ascii?Q?LgCy1e/K/pjpwXQ8NtEoxuzOzeLS/GovCd0pWkpc40UWAYAlG5cMBJPceryI?=
 =?us-ascii?Q?lF6RrpmN1w0JdcvjILwGAFCYVoa3Zagolj17nGmASSdAO935FDVqZLu7TloQ?=
 =?us-ascii?Q?cSUs5U9vluLEnNZoEhb11U2yRmr2EFUtmOgZp8Kme7Gs3DlS/FEl88UwFiLY?=
 =?us-ascii?Q?jncm1ndxoIW9Z/LaLs4Nr54v8oS3+p3vvJedRZKhT9a7caJ2ZyKfDG/jIcSd?=
 =?us-ascii?Q?KcgFPaPKhPrg9/qZTv/MmsjSqeIAbqOZAmOVPpQ1Wyg8RN18FHChGT6HZXJY?=
 =?us-ascii?Q?ATJPt0H5X6F0GiRA5IWCHtim3SdF3WCdZFqpX5q4bAdCQ1mSp4JkrQJan56p?=
 =?us-ascii?Q?FP16Vh/SPEGCEGHAroj+ZToAH9nZALFMDcFRXVe7FwrR61C9BvYJd/B2UDGz?=
 =?us-ascii?Q?iSm0q2cwhHewdyWRL1XXbPdGBX559mocpMnI+ZmekJnqftmiPOXroztCVZWl?=
 =?us-ascii?Q?IHv4pmly4ypUR7qgioZgGwYyqrWq012CAHr9g63Vy7Qivdki7I+EwxBXHJ0Q?=
 =?us-ascii?Q?8qmQmHs1vasGibHN2qi7l+bGVUl7gGvyeXAuhY+xtGF/5sKJdJrSO5xKOirT?=
 =?us-ascii?Q?VIYGoSH6dVVOqXWbBuaMH4X20q7N8eQCoGFIu7rtnx15G0AktDVWWQeXXFZ0?=
 =?us-ascii?Q?mufs637GhL99o1PyhoS7vJbKOLRTdir3/tI1CWHkFFb2f9NLTwew9w+gTTaT?=
 =?us-ascii?Q?gLxWWS3rp54OGy4S1oLgRGTAyCNUa0/kNqAN5/0ScPzrQw5loooCohopM/mU?=
 =?us-ascii?Q?xANejKSLku9W9GXqkjYv8JmW7rxJRWNyKJvnuYEzlWnueNyEefFGBwf6Fyh8?=
 =?us-ascii?Q?IV4XZrIGgcM/nojD73b/M4jvekDskpKvkPnB58bboCjru8K74qFeklj3IAF2?=
 =?us-ascii?Q?110bZ89ZumnrOTb/VmLTlYHkSGcng5rNsBrDooSRUOVnk1tpo2qzYSQbXog3?=
 =?us-ascii?Q?LOAHypAFcw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34707e90-29ad-40a8-7537-08defa13c98b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 14:53:22.8059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WmnNJKJxkHKLuedbM3EL8RKS887p8E0E8YKu4tqmfoKkm3qbiA1m7FDo7FG4gKPXjHerGb3VrJb5IRrWGPuSLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999109
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

On Fri, Aug 14, 2026 at 05:08:43AM -0400, Yury Norov wrote:
> On Fri, Aug 14, 2026 at 01:54:24PM +0900, Eliot Courtney wrote:
> > > 1. Provide a nz! macro to create constant non-zero things. Provide some
> > >    constants for common alignments
> > >
> > > Potentially, we could use build_assert! for cases it is provably
> > > non-zero but not a literal (although tbh not sure this is a good idea -
> > > at least not do this initially). 
> > >
> > > So either: nz!: const { NonZero::new(value).unwrap() }, or, nz!: some
> > > build assert gated construction of NonZero. A general nz! macro could
> > > also help ergonomics for other use cases too.
> > >
> > > That looks like this:
> > >
> > > pool.alloc_area(nz!(8), Alignment::AL_8)?;
> > 
> > Actually found that if we implement SizeConstants for Alignment then we
> > can get Alignment::SZ_4K etc almost for free.
> 
> Then maybe pass SZ_4K directly, and allow the alloc_area() to
> calculate the alignment:
> 
>         pool.alloc_area(nz!(8), SZ_4K)?;

Even worse, you can advertise the function like: allocate a contiguous
set of channel IDs enough to represent XXX bytes of memory with YYY
alignment. And that way, you'll be able to do:

          pool.alloc_area(SZ_8K, SZ_4K)?;

If my understanding of the function is right, it would be a clear
improvement, because the user now doesn't think about ID channels pool
as a set of bits, but an abstraction over the memory access technique,
which it really is.
