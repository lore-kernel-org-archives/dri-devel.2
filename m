Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA61BC5DF74
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 22:40:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D35B10E0FF;
	Mon, 17 Aug 2026 22:40:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="eVVWQPd+";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012001.outbound.protection.outlook.com [40.107.209.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9FB310E0FF;
 Mon, 17 Aug 2026 22:40:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BETrfo06bfX6DcKh8T67ufgTS6gCWUWFxd8umhmWKyLIO7OdqhHcQozwhYcxFuGywtS3Qvm9AE5SZ9Oxw16Kjw0PikJNcJ2VF70c9tfoaz3w7V2zmLM9i1CvRg5eXaIBv92kf6PTw6bvN3GmYoWMUY/hxRiB8jUvf5F1ifgp2hYaCOyDJ5Hp0h8pREyC3XcYWLdvt9PqTRShWTfRRWGPC8no8LD0FlymT5Xu8apxPNf/ZG7jrlTjk+kj+5Et4MUx+IIjybUZpZ+t/sYh8a+rbI58hiVso7kMdfQTCfwzKfxGeYhmBC5LDn/eveOqgc31OHSCelRHPAq4TtT5ZUuZZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bs2z4lyBgtGzHd7TdaAUKW1yR/k9hSDoajiNKj5vy1w=;
 b=p3Ro/iHMNvBnX2GwIqNNJaDCD0EMrpDwU/B4OxhWLdnxaxhXKH+s6Vbx7D9YyKlIeph4tFBI2lX6pjW8mGHmX/XpkNKJsZyHjwYlTmXnuhMbYJS8cQzorXW9tEN/Q6BUBYCRote31PV9RJiROmhWp0yyESlvI5RNZzYzacoDI4kxTfHr+tGXbLN1EOsJMleLWUof2KPIzM/A/2jVCQKVWWzJEbsNkriHYQMn4ijYFRQeAODFc+ANW+R1H9CNl35opL87kliQo5p3g01FecwTBc/gIV1SdaJsC4d9j2J1xjY6d4mFw1UGlYgIcnH5uyrYnmcXUKmMFGYcriqD89CnWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bs2z4lyBgtGzHd7TdaAUKW1yR/k9hSDoajiNKj5vy1w=;
 b=eVVWQPd+CJ33k52ficSIMIz5AtUbob1r9h9RDStoEkEqCb8whegNlxEovzQ0IlIWI/SS41G0DEOEdh8P6ZrZwOxFMW7821avcOgWvSJgmgC/lr+wer4aVBGL+4ww0s9KSqAyEtwB5CXJm3f0IZ8ey+bbfmcUw9gE+HYNPoIZY8WPhdLJvgABzOCE2+6pqupt0++iz/pZEGJV/Q/JBSPFQzO2/DohqTcHIQKj4UhIUSe3+OXMUr0WKAvhy8gDw8x4zRtpgWiNN+SdW4o8A7WC8FT10kcKwOEW0fXdDqw0NnoPDa0uYlGMCxpZbJQQ6Bh1oksMxiRe/4oSWME1Ub+FtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by SJ2PR12MB8651.namprd12.prod.outlook.com (2603:10b6:a03:541::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 22:40:18 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 22:40:18 +0000
Date: Mon, 17 Aug 2026 18:40:16 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, Eliot Courtney <ecourtney@nvidia.com>,
 Alice Ryhl <aliceryhl@google.com>, Burak Emir <burak.emir@gmail.com>,
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>,
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
Message-ID: <aoON0FepAUw1b003@yury>
References: <DKOECWHEEAK1.3N3JXH9MH7Q58@nvidia.com> <an7bG2bEd28AbNRr@yury>
 <an8r4VECQ8iFP8ze@yury> <DKR0ZNGYW9IT.37N7TEN97GG3N@nvidia.com>
 <DKR5W5DGAWAJ.38LHLLNPO9R4W@garyguo.net>
 <DKR6EB8OWPXG.2QYAY81UG1RF3@kernel.org>
 <DKR724N9V3Z8.1HJP6NJC5A4ZK@nvidia.com>
 <DKR7N2LLIQZH.25F7VF4CET6PO@kernel.org>
 <DKR8MCRB76L2.1TV4D7261PVTH@garyguo.net>
 <DKRA0IU4WVW1.3AOKCY38VHTKZ@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKRA0IU4WVW1.3AOKCY38VHTKZ@kernel.org>
X-ClientProxiedBy: BN9PR03CA0351.namprd03.prod.outlook.com
 (2603:10b6:408:f6::26) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|SJ2PR12MB8651:EE_
X-MS-Office365-Filtering-Correlation-Id: 840f3170-2d46-462a-44f5-08defcb08342
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|7416014|366016|6133799003|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 8rECFL7N2ajfUrQdKh5uTdXZV0dao+VdMHFYqLd8hdyB0Rc5bdWGbGQG1YT8z53JoS/3/Xy5lOjD+Yaz0U3ENXzdkbOu/OcILxklzxHXsxWrrnOedR3feKjQNHiVHW+CoKn7AzE83JWyh2Kjkq7YLOg6YSVH94hlXCL0rFAF0t0U+RliggwGH9zwU6yN/RGyXVLqh8SPlPBgT5wFwSVvQul7hHJYvSkFR/MVP5Aiy5QuZzQGbNFY0FfmQWilC+2ObVvUwkzm8r4hsAdADh5Ue1AGGv4oEkpFbDMRIfE4ZQSWjoGMjl6ogiiy6ObT1Rz/vXFNhP+1IZxUWcACcMP8aKojQatzltnH5PAxmXC+jDpkSUwAC4gLlwxm64h62WJKzGv3v/VfZpRQe/UW+316OVFgvgpr5gzRM19CBSZ58ZfBs/ShFfWH6J2IjX6QXGd9f38W8YHDPLPDScScOrv3vqW1jNrQc9WftDlWnoDZeFm0FmxmGpLDlH2OKHNRC0P3D+VFVAn2Vo7Za0uq1rEOWgB2uyImoHNTHBnyvhkhSwxm0eGoCp/9/GnaQ2PwzUlZd9mMtW0nHphJpe0gNA5r+3BorgaWzakpH2rT0a3OWMuCA2FcpRKowakPwutinDMx3DHP5EbFTaKDcaVZfl0DsN3kJ//LhSU7/5nzOnSTDeA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wvw6mtZ2bwrQgsWDllWFF6+M3oinVl/MaxRf6jsMJnI8EwrjzuQK9gsz47MU?=
 =?us-ascii?Q?jo2ethscAqSR7hTpEFEL9zxez3cFG7g7uDWG5YD/Y+/GtJJMA8Ai6Eu1X+5q?=
 =?us-ascii?Q?9XhhwysOmZUBHrLGsF+GH3L5VPGFR9GvB7LFkLWJm0zKQ7E9fH8xfc9RvWEn?=
 =?us-ascii?Q?+P9cfo/G2SR+6ke8lqv4YUDvyF1OBZerayStmDCHDJlavOWgFmsXjjFY6Olj?=
 =?us-ascii?Q?hlOxYfXZL6SwngFZKDjHO+Vw6B+WvIvtQYEC6n8gNqzlrTBoCZI/MW0TkC1a?=
 =?us-ascii?Q?TyvH3fuMRUaYh1vNHIreodBfhu3myxKkV9WPnFBovb1wkBj7J2MZmSY3FdPV?=
 =?us-ascii?Q?/gu3zOIP8WtVWkIYWtjOirheKMkNd+mruL4dxWLWfKLDpEvSoXT2N02fnPV4?=
 =?us-ascii?Q?utWxVhJobZFQbDe8CBvllXqfCjUN4Dnj4bLVqQKTUfgtsl4F9WZTJ/jtp0a1?=
 =?us-ascii?Q?gzZ/GenRMRZjcdWL5tUSOPunmYdZaQJKH8hRVJjqAq4LuoLvZ+aJDnszHTF5?=
 =?us-ascii?Q?RgRgzss3WSq9rQe4dUbXXj6ePGmRPFe1YqkeQqEL3ZEWw5IlMoS/ig4rruYZ?=
 =?us-ascii?Q?sjQTPFPCvqi/kYUNcSOZqLmOAQTKz3kwT7e0ZZec18a2U6WVaO3a3Ok/d27i?=
 =?us-ascii?Q?2ccymlWdZrr81Ni0pS4rAYgdGCgBrLYEzU3K9YeShPfsnI8ZT6DpulMZSW0a?=
 =?us-ascii?Q?C4XVLS1z37iO6bHAouqX4sGyBGCTn9H/c/zrbAzb9j7Qz5Pyxr3ikETJhFun?=
 =?us-ascii?Q?lUgWNNRqlUjhQUCMqvRR/5zYtXLJZcyNQsyEaGWoV/03jDakkDDktRDU+BPb?=
 =?us-ascii?Q?w+5+PWL9S/WBn7BCaPdfPf/ek4SwVKCb8aT8q7xzflK3UC16ooxQ+bPBokl1?=
 =?us-ascii?Q?BXHgVNZcVa3A4wVg63nxMxLd9nsEFUshxkMo5KVH9o658LiNQw/9KZLqPFqb?=
 =?us-ascii?Q?Kt8L6z5i5htwMmJSnFgG9Kx7LZIU2q6Zgi7z61PFLU0zcTRUi0WJxnPtEt9y?=
 =?us-ascii?Q?oOWuCM6fnFRkVLm0PeF1O6i4QEUfVODWneAozIWQiwMQJomsOiBPPGBNgZny?=
 =?us-ascii?Q?z0oB2GdDflDN2yaetmwujxYcIpMSNM/YuRnQWJd1BenYSjQq0eY/Hf1vw6Xz?=
 =?us-ascii?Q?ony3P9S8JTFlT8Dk7U1yru4VmICunNdkw/35YtZ3n4ml6+VDc4GlrjrDrIkD?=
 =?us-ascii?Q?S4ioFRpIi/PVe7Lq9Zf91GzuBY3zlIVbkFZQumn6U11yUdffiyMVPn223Nm/?=
 =?us-ascii?Q?qU8fdZ5LE8s7r8+oNAdNn+OvYEtrCWKY9BR49mbjIbdCPQTsgjSMSJsz/DnU?=
 =?us-ascii?Q?9xCUEWjFOA6EtMqma2egtJzmdQdO5pUKZMnfgXC1SSBe7AWM0y3jtrMPh2Ut?=
 =?us-ascii?Q?soxkjvNbLH+bjO9/BpTWlSOAVQgnw4U3ZVH6CuUWxZxYKgDTAiC6pSepcxlc?=
 =?us-ascii?Q?Y4m0UtjfIWY9xofNKEQt3LT1yMXiOIVphVbQU0AIw5nUC9bPV8UAAUqy49MC?=
 =?us-ascii?Q?K/0IRqR+hLMzf1mGFB0aMCMgZDA4yD9qaJew6H5tLLYZ/3OXG4IxKxc/CL+t?=
 =?us-ascii?Q?VCfWDY5J/M1Rjr1o7Sq/00P7GJ4lrLXClg1WaP0D9n8ABMnzyKWfjIML9J4y?=
 =?us-ascii?Q?WUgfmPiOvXWPcyV4fB0pE0sAViv6qiSZuFfre+cVmUYS360MvBvZEIClbsDh?=
 =?us-ascii?Q?UKevRjej/X7dCVUk8nUCeRCbyKHYF7KITOzzFMMjSJ4q1ziG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 840f3170-2d46-462a-44f5-08defcb08342
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 22:40:18.2245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +OyGP40ivko6uPw+Fyjga+aqsZ3wKGvBbAa2wclTP7/FOd3E1gO6ffLPadsEQbYbJmlrUBN6E3py2lYMxNysLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8651
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

On Mon, Aug 17, 2026 at 04:08:09PM +0200, Danilo Krummrich wrote:
> On Mon Aug 17, 2026 at 3:02 PM CEST, Gary Guo wrote:
> > Now, with `NonZero` or `Bounded`, we are doing none of that. The only thing here
> > is that there is a range restriction. Other than the value restriction
> > themselves, they carry no other semantic meanings. How you interpret these types
> > still fully depend on the API that accepts them. Therefore, it is very common
> > that you'd be using these with literals, and it becomes an ergnomic pain.
> 
> I agree that NonZero and Bounded are on the weaker end of the argument. But
> there's still the flexibility argument.
> 
> The API itself, i.e. alloc_area(), does not need to bother with how the value is
> checked. I.e. is it a runtime check, compile or build time check, or is it even
> unchecked (or panicking) because we can derive the invariant from another type.
> 
> > Personally I value ergnomics higher than possibility of misuse if latter can
> > be easily mitigated otherwise (in this case, by WARN_ON or just support
> > zero-sized alloc).
> 
> Both is not a mitigation IMO.
> 
> WARN_ON() is does not prevent misuse of the API in the first place and in case
> the value comes from userspace even introduces a vulnerability.
> 
> Making zero a valid argument simply ignores the problem or just moves it
> elsewhere, e.g. where the caller has to validate the returned type instead, i.e.
> the ChannelIdArea. IOW, we'd remove the invariant ChannelIdArea carries.

Let's get back to roots, maybe?

The kernel functions don't check parameters, with the very few
exceptions, because the kernel trusts itself.

What are those exceptions?

1. strnlen(char *s, unsigned count). Here the 'count' hard-stops
traversing the array 's' in case it's not null-terminated. Why?
Because c-string is the bad data structure, and it's a very common,
very well known vulnerability of C strings to have them not
null-terminated. It brings tons of troubles, that's why.

GENMASK(hi, lo) falls into the same category, for example. People
always think of it as GENMASK(lo, hi). Bad design...

2. FIELD_PREP(mask, val) checks mask for being dense and wide enough to
fit the val. It's a very basic operation, has 0 cost and implemented at
compile time. In fact, FIELD_PREP() is a compile-time macro. The
corresponding run-time field_prep() doesn't check for any consistency.

3. int pin_user_pages_fast(...) 
   {
        if (!is_valid_gup_args(pages, NULL, &gup_flags, FOLL_PIN))
                return -EINVAL;
        return gup_fast_fallback(start, nr_pages, gup_flags, pages);
   }

It's not a validator per se, like nr_pages == 0. It's rather a
consistency checker.

I don't think that alloc(size, align) matches one of the above. The
underlying bitmap is not as bad as C string, the alloc_area() is not
a compile-time macro, and NonZero<0>() doesn't look like a complex
cross-validation.

From maintenance perspective, I don't think it's even possible to pass
0 into the alloc_area(), so that it slips through the reviewers
attention. NonZero<0>() is a pure complication for absolutely no
reason.

Again, any kernel API trusts it's caller. It holds for assembler,
for C, and I don't see any reason why it shouldn't hold for Rust.

Rust is more restrictive to undefined behavior. Having that in mind,
we may want to prevent the known undef. But that should never become
a part of the API. And undef isn't the case for alloc(0) - instead
of making non-zero 'size' a part of API contract, we must make the
function behavior well defined for this case. kmalloc(0), for example,
returns ZERO_SIZE_PTR. The pool.alloc_area(0) may return None, and
probably trigger some warning.

The underlying bitmap_find_next_zero_area_of(0) doesn't behave well, so
Rust wrapper should take care of it. pool.alloc_area() doesn't call
the C function directly, it calls the wrapper. The problem must be
already resolved at this level.

Thanks,
Yury
