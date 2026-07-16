Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A64DC44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 00:53:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70BAF10E0F6;
	Thu, 16 Jul 2026 00:53:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="nW0p2Pln";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013020.outbound.protection.outlook.com
 [40.93.196.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA72310E0F6
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 00:53:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNCIpOLpKfwC5CtazBTjhuN1CqCvhv+bdZmiyNL9zpSmiVm2exdk3LgzQo1qSxkeHZ1ELzUEJksdObzTCKCsUaio6nWkBlCXbPMTia/syoQNPR+AOgv9Bx3e4cTlVaHKZb6ab/7iBSiQTadHVM1R3Jzs8QUnHx3LKihfH+YPWd4ud0iaTkWJpJ2/uyfPPdFFmPBIumpfUGvXoLWMrEbZAs5fxq/6SD0enyxbS+yqFHeujdhSOYvyx5sP6ASWat9H0oEYhKEpdn6cjDjPnmFH+lrorkoyBPJdeCI/kz0pCis8uEn+w/G2BVNkvuqsRDiL/R6NNbElRUDBf3LxESixxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMsMaVHEsbz1VEVS3LHfC0mtRJIHPXSGzTnTouu5QaU=;
 b=foQzL+1tqDh9sHEkZpLirQz91ca09BFRlSVN7MMOowsDn70eavfZ5f0RwuHHsiIw1dtCjJomzSaHaBiWOAWgRpxPZshSMtAppVNbRFX4ORmU3bYuKOwhT6CEumNsWzV3xn7frp2KNqAJyNNlLL5xqUfHExSYztLCGB8ixTsrxRTyu7Q8MoSfMiyywKbChcg1DMOaV4cz7dI+3vw4puIct0U2gqI8TNJPrk0n1895Ym/3cyfSfac3pgfepo1P8e3qJxBaxSdi/DJt1S3JX/dULyMjZMoclw8bmf58IcxcUVCDqwUP+nLKpkDUF45/D4GxttnUrbHShqFcoFh+Cpg21w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMsMaVHEsbz1VEVS3LHfC0mtRJIHPXSGzTnTouu5QaU=;
 b=nW0p2Plnqc+QEqnLr1Jvubd8FtWFXdEqV7IOXqFU4wOKZkX2dkulnqLL7uy6EeltrmlEvnLy2mvgeWpy+zKzhlrM6guchDYR+RxtCuRU8jP4OSi2Eqep2f+czlfxfklmLOKJFEgD3Ae4XvrUzz9Rg+i2/hqyRk2hecHp6BsoX0skc+jnkLubIjEOiUSm1mUTRDKje3zjCpYOxDkXAk7TTTJQHgLkdtFLa/4W1EUQGbJRfLMMwDxXvjG2+L8q2gVn8zyq1fEjCPM/2896CvaYKXCk3mL80MiHQm0QF5U38n5u7xleBF6F0vMrssD3ggmEz9jGaWzLtv7af+h6v+Okbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by MN0PR12MB5932.namprd12.prod.outlook.com (2603:10b6:208:37f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Thu, 16 Jul
 2026 00:52:55 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 00:52:55 +0000
Date: Wed, 15 Jul 2026 20:52:52 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Pedro Falcato <pfalcato@suse.de>
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
 David Airlie <airlied@gmail.com>, Gary Guo <gary@garyguo.net>,
 Miguel Ojeda <ojeda@kernel.org>,
 Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
 Simona Vetter <simona@ffwll.ch>,
 Tamir Duberstein <tamird@kernel.org>, Timur Tabi <ttabi@nvidia.com>,
 Trevor Gross <tmgross@umich.edu>, Yury Norov <yury.norov@gmail.com>,
 Zhi Wang <zhiw@nvidia.com>, maple-tree@lists.infradead.org,
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2] lib: test bitmap vs IDA vs Maple Tree performance for
 region allocations
Message-ID: <algrZLHyYcR2mwzX@yury>
References: <20260711063602.426311-1-ynorov@nvidia.com>
 <alf1lUH0EDf3CRMl@pedro-suse.lan>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alf1lUH0EDf3CRMl@pedro-suse.lan>
X-ClientProxiedBy: SJ0PR03CA0171.namprd03.prod.outlook.com
 (2603:10b6:a03:338::26) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|MN0PR12MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: a1a45843-54c0-4acb-d12f-08dee2d4923d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|23010399003|22082099003|18002099003|3023799007|10067099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: vWDP1F4x8FHd0qIlaV6sPBFQU6c/p6WkaH2IsRRE0/RymcyCSWVy0SZKkeq4GZ9z152x/frU86s4wMkX4Fv31z7uziRkPgGJBSsQWoMU0NCDG5f5IN5dNcuRrR1EtH9Msvl1MM8OCNCbLh/l11oFJnSMQjmnZYY5yAkCX4oJsuJSeKHR13xLhgA4mQsYHFC9A/noz2KiDl68Nt4fQf9JKu1/XgMRFORr74E+waCQYhEexW6fkR+Glz7fUc+U/GrnfVp0P7UZGTWfKQVbLfQp7IZt3R6Bs+YrPnXReto0GxUIUTZQ5pCemGIopxG/AaTf7i/ksHIugPuMv9dLL65ocDcwar7IbaGFbVyGjGZTdIIjsZeJPznHSHqJ4dAqgCnIe1IRTQks32Av6908z/SRx4xd+ghWqMV/HeTEOCgldxKiCO4/5AZoAIbyi/m3+TISHv64FBfDwNVC3X9k4gHUp6aa987RvVTqR08lMS6WJKcn9Vvhu7QyPdLyXD8T6ML3PTp09lN3DhASQBItf1Z27o2ufrFjATg++Ns/mBDZWjQ0gQViPBHufifF2MxFlxlLR12+QQJtmo9n4L87JSuIO8sqoHj20nnI1ALILOEBO/IgQVuiKjhPYq1nKh3ZJxBFHcPB2/woYe9TT87kyLYP2VFPG6Z+zrUFq4eS8ESLkEk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(23010399003)(22082099003)(18002099003)(3023799007)(10067099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kUFKHJA/urU2DXYy7WEIuWIPY+Kci01kqiRwYaRkEP6FSmXXiPFcE8nXJtkb?=
 =?us-ascii?Q?Lt3vldFhZ5RdWK8aV/sU6QW9WeiqRnCtMhRAOzsNILTM0LS5sCF3wYBP2uLB?=
 =?us-ascii?Q?EdgtMGgpkh1cmEg1e9I5OLOHCP8CRIpU+2NoJTwtJfWfC+t7p7bcb/wwjiue?=
 =?us-ascii?Q?ZMMS9GI5O70x864GJ1Dxnao/LqucjPJdSCLi1Tf0k7KfHo4pOeg5YDc6aN5j?=
 =?us-ascii?Q?A70rfhFOkO0b0gPamWkjsZ2GSgPHZZAdkkS7PN8V5b8VSfIDvItRmwR8dahP?=
 =?us-ascii?Q?BvDK9hEJB8sAVjqTJZK74H2ocSZtMP08azBg29Nzc4cC/CpHtIaQqLDg2r+2?=
 =?us-ascii?Q?1r0wX41/Upics6wFwRng4UBBZWV6f7eP04nnXp27bSlevqV9rYQCFO7Xz2zB?=
 =?us-ascii?Q?SkNyuL7nTJBlYBS2IVoEX9U1F9Xd2aO6NnjyZyHVTEnwjqEK+83n+vXwtDN1?=
 =?us-ascii?Q?js9kVUMCcyMcWfIx5jeHNvQJysLjJsWsyqBj6CETI0L2xBVdvEVkSVpHndH9?=
 =?us-ascii?Q?1aj8xkIfYv0Fmgzi147fCyypmcnL06CqDSbxvQUCh/3sV+N1mDyFddVgNkI3?=
 =?us-ascii?Q?HQVCYzulPdTDPWAfHqFDm3oi+Z/ZgAxWQ1DxShvf0AhcNYjx69+Ywvkn72Sr?=
 =?us-ascii?Q?hCXryFiomEFTMbakajVLGpwm0er2TQ03GjD4/lSOKLBSl1rnihr+D6r9gqEN?=
 =?us-ascii?Q?Z9AzvjejYvXyp+dgsJlPOX0vo0Rn4LOWOtnqAg1XDcdGKARWSXTWfSLokXPB?=
 =?us-ascii?Q?TvSTSZ2uvUiC+znnPgUlUDmF1jMIZ/6IJ/RUXkeFEj3APi46SMG9s/mEi1xB?=
 =?us-ascii?Q?j8YKnI47e5brNow8lt/cJ9pO2YAse2R/cEhaIrzbhAfN5Iql6Cn9TcGbGUeK?=
 =?us-ascii?Q?+BKlvykeHORyoFfC4IX0STlHKf4QZsuF+49sQG3g8EEXWmVpb7kyIAXB/YVF?=
 =?us-ascii?Q?JU9v4alAzwViNncmk2PRtkZ+91swTu+nJD+hUIQp9i870yslbNx6V76DJXZT?=
 =?us-ascii?Q?0NUnVFfJN0G+pBiqrq1JVvBp3nbWPhq7ey6q1eT0sYmHzyKRaYYEXSFz/ilK?=
 =?us-ascii?Q?W+BQxDxc5V+MX1feqxZgrvop808o98/tlXcstELcaEN0b1Dcl7t+HN44UPkm?=
 =?us-ascii?Q?qI1GNgEjhJ4vPPa1YUPNNiplhRuSDTATftQF9Kpw8M703rMJFXEA87j3iJhF?=
 =?us-ascii?Q?tht4lZN5x5bSp28mMTMJB4u3nArJkMVRaHXZP7rscgfv7b2/MyDLBlj7BkCf?=
 =?us-ascii?Q?BJCEsF3Xnd3U76yKKkvJTVbb+ChfVM/Nq4HOPisNKWTcTPUc83wMwyjCsiLq?=
 =?us-ascii?Q?ef1Rqtgd2sOK07uRFGxqfqv+S4OD+UcfAfNQlFqtoRQrpv2+YHC8CkQdDMhf?=
 =?us-ascii?Q?cN1RH+1Nl6M1h80Cwwsn0fW/kNaGox0tFzdgl/gtTl/+o39n9VNm9F/tvxkl?=
 =?us-ascii?Q?ukOjaxMg3y76tN8SJA9GKPwj9jLWPAGNgE0snfe40GDMdnOJBgzL0ivbsB+J?=
 =?us-ascii?Q?h3jl0e1SlsdK+pwfazKB+3nFuNbAjksk4loIURoRH37dYbZo5D0ZJ0MQ3Kzo?=
 =?us-ascii?Q?ZEkZ4/BNjNgt43MJA3QMI+Ol/aAzcmPcYcajQUD8GRTwSwz+rwRyAsBcwHGL?=
 =?us-ascii?Q?ulvYhOoYKVF6TMqgP2daMhYUKfoaiYbdrXu+EhVP4mzp2+QNNlDHuPbkW94k?=
 =?us-ascii?Q?RZ0uJoyfWgcmsfoSJ3LU9bi9QMRJNqJiGrVKx2Pejv3zK4QzrZvwNpymRE5v?=
 =?us-ascii?Q?mnzKcUNkqA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a45843-54c0-4acb-d12f-08dee2d4923d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 00:52:55.0126 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z7Qvr+ZcTvyix5mZNzIi/w3YmDvmrNjnGISuZgElRrf3hLhj+FqWFSqXwnSzMfMKNb6OHYhS7QfvMLIVWzywqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5932
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

On Wed, Jul 15, 2026 at 10:41:01PM +0100, Pedro Falcato wrote:
> On Sat, Jul 11, 2026 at 02:36:01AM -0400, Yury Norov wrote:
> > Compare the cost of allocating and freeing variable-sized regions using
> > a bitmap, IDA and a Maple Tree. All implementations process the same
> > randomly generated sequence of region sizes, ranging from 1 to 32 entries,
> > until the configured capacity is exhausted.
> > 
> > Run the benchmark at several capacities to show how the approaches
> > scale. Report allocation and free times separately because bitmap,
> > IDA and Maple Tree removal have substantially different costs.
> > 
> > On x86/kvm, the output example is:
> > 
> > type       alloc (ns)      free (ns)   capacity   memory (B)
> > bitmap      179573071         342105    1000000       125000
> > IDA          46555636       33931498    1000000       134864
> > maple        18629665       19741396    1000000      1548304
> > bitmap        1630912          30933     100000        12504
> > IDA           6144785        3354590     100000        14288
> > maple         1745026        1825032     100000       155408
> > bitmap          28448           3374      10000         1256
> > IDA            418978         333641      10000         1872
> > maple          185398         211138      10000        15632
> > bitmap           2253            610       1000          128
> > IDA             42755          36432       1000          144
> > maple           19728          23474       1000         1552
> > 
> 
> I don't understand the comparison. bitmap, IDA and maple are
> completely different data structures for completely different purposes.

Sure. Please check this link from the patch description:

https://lore.kernel.org/all/20260710-chid-maple-v1-1-4ee869055268@nvidia.com/

The test is very well motivated by that discussion. I'm not saying
it compares apples to apples. I'm trying to quantify the answer to a
very specific question: what is better for NOVA ID allocator. Or more
broadly: what's the best data structure for range ID allocators of a
given capacity.
 
> 1) IDA is 16 bytes when empty, maple is 16 bytes when empty, bitmap
> is $size bytes
> 2) bitmap is statically sized, IDA and maple have to deal with actual
> allocation and freeing of memory
> 3) xarray and maple (especially maple) are optimized for RCU usage and
> have different tradeoffs
> 4) IDA does not support ranges
> 5) xarray (the underlying data structure for IDA) does not support ranges
> in any optimal way
> 6) maple is not optimized for 1-sized ranges, nor ID allocation; it
> actually stores data, so instead of 1 bit per index you get 8 whole
> bytes.
> 7) maple and IDA both handle locking implicitly

Yes, this to some extent follows John's arguments why bitmaps are
preferred for NOVA Id allocator. I'd also add serializeability, if
it's needed.
 
> There are also other pressing questions about the benchmark itself:
> it's pretty much the ideal scenario for bitmap.

It's pretty much the worst scenario for bitmaps, because the test
starts searching for a region from the beginning of the bitmap on
every iteration, making it "Shlemiel the Painter" algorithm with
O(N^2) complexity.

If I wanted to cheat, I'd carry the last allocated ID over the loop.
It would make the complexity O(N). I could choose to start searching
from a random ID, saying it's 'more realistic'. It makes the complexity
converging to O(N*logN). This is how cpumask_*_distribute() works, btw.

So no, this is far from being the ideal scenario.

> doing the find in
> bitmap is essentially testing how far the CPU can speculate, and how
> large the cache is. It's pretty darn large on modern hardware.

Yes, it's a very effective data structure. That's why it's the 2nd
most popular in the kernel, after spinlocks.

> Since you
> never actually free the ranges in any way, every bitmap branch should predict
> extremely well. Fragmentation in the bitmap can very quickly turn into a
> nightmare, while maple will eat it up just fine.

Assuming "fragmentation" is the uniform distribution of free areas, it
wouldn't "turn to nightmare", it would asymptotically turn to O(N*logN).

> These are very different data structures and picking between them requires
> understanding all the tradeoffs. I don't think this benchmark helps with
> that.

OK, I see. You seemingly think that I want to throw all and every data
structure away from the kernel in favor of the bitmaps.

No, I don't.

Thanks,
Yury
