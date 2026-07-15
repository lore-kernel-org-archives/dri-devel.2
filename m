Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2304BC44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 15:54:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E80810E3C9;
	Wed, 15 Jul 2026 15:54:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="nJkoGrUy";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010045.outbound.protection.outlook.com [52.101.46.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE50810EB30
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 15:54:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qo7Tgt1jWMRAbbMe5bp//s7B8E6Waq2X9rUKhf71D7n/LgwyG9FBqKNLAPpRy3Bo1PwTVyFXthDXBfU6H0P9FEKMISN86fdlSPYf3fhu7jr33SLdhYgK0wizMnV0/kzsPvyD6XUSAL6RLc07tavUnfLfiOGOwBsZ13rc+UmmyCWJ6E0WFIiWmCi/GOrOgyThfsWcwlLyGj7J7VLY0pxyfvPpD/1DVNfSNjfq5tct1sUDF9YFFsVEV3NzaUasBcvmWH2J9wiCtikaRwzZ90fcYL5iQZdtXvGnWoEU1DOnOeIbR9eQDd6CIEpjeyjpSWYtD1weA/K+XYrtYME0o5ZbaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ah1sfaX7dHWn4S4nwD5Xgc/QaApwAk9MSaIAwCmMFw=;
 b=Q3pK3sD6zcwUf0pJgtWs17q32erKTM74veLtDl+gJ5ItQ8ofvyEQAI0xvOOpLqF2onTRsDyNG8/uPqh9T0Lgz72xN8gPFUr7YeXhq+f6dfj+p6IWvc/RGpEgrTW8No8UvyQmq3f/jvWp7CIFs6hj1FM2zw9l4Ew0oIl6bVLhmc+H3RA6WOnMib7FFJ8XiXVd4DktbMgYRvwUGjGmUdVe2dpx0/rpZdB7abYnKe61/HJk1f8xjM4I2ZeG3eyqP4cLZphdNMCcCTb7K4VDlBJ0vrB8PEM0T5JX6vKpfACWPb04oWGAFhCHN56cBC4NBVPQL/IxusMu0q9aV5fz83FvfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ah1sfaX7dHWn4S4nwD5Xgc/QaApwAk9MSaIAwCmMFw=;
 b=nJkoGrUyNNB/wvbdBZadth3UE1V7IvbLxi72IFWCnrgVMA4J1FzaEMJgXFRFnVMJ//fEhOE0lVHHqGJt3SIuzMEKHeE/eRcJgzdZuFWq9br7Ry72Enh4Pvw5ER6LZ/v2Ds+a/6+7D2JIz2h0EzNbakTdGiPCYCdA7ehhvdTiJ7U4f2hUm0Y24kA2maraRSpDR/piqKUjuCZoFNpHHQpNkJsIhWkv9lNQslVbQhHPb+bSAYvjwyB1cGgok2V9c9f0VP4t618Vn/krGhLCfi3IdyJ8c+7rKKG4869qb7mDPbKEKYQeI6byYt96fVR8ce8xA1DEQyvaMFmfosCoYULxYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by DS0PR12MB6415.namprd12.prod.outlook.com (2603:10b6:8:cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 15:54:26 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 15:54:26 +0000
Date: Wed, 15 Jul 2026 11:54:23 -0400
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
Message-ID: <aletL7odX7uIDPxD@yury>
References: <20260711063602.426311-1-ynorov@nvidia.com>
 <DJVSHL6XP43R.1INHQRXAG8UA3@garyguo.net> <alcT3HupA6TogWSa@yury>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alcT3HupA6TogWSa@yury>
X-ClientProxiedBy: SJ0PR05CA0208.namprd05.prod.outlook.com
 (2603:10b6:a03:330::33) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|DS0PR12MB6415:EE_
X-MS-Office365-Filtering-Correlation-Id: fee12921-d465-4f56-5842-08dee28958c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7416014|23010399003|18002099003|22082099003|4143699003|5023799004|56012099006|11063799006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: Xg0Rq2cFKOzqvehNvwHx2+hCOkdeRRrFdYb4XR5CbMZU6NGu9pkjRJZNR18VUB+c8ERJMCahDrz+6GZf43y3OXL6pRPF8/zpJfAbWecFubpCZ7Hd5MTVz7syJ9AKoY1lkO5XDyU1YrzDgkqt0L11o/I8PAN+XmRmYBTGgCmuYPAwFdJDBtyhRp9vC0pGLMgZUfMZcSrs6zz6j5suGbRmw85DFiP1CCwHqP5uz5CsOxMo/VzzUjEEUNLzJCSahRea0fUDkDcfeOjSttaaFLkrKz7asHHiYdF2fGbUccC+vMMZPGR7eN8WrGXSf+VTw0rtT0m6X+1gW1/PtXkCnKLWFPcyM5qzRPAOpXuo0gcOAnIBISRodVQWPoKZ344h05HYq42nqMSFITzFNUKLbKmdWW+J7RhTrWYbKG97Ka6TaXgoq9CL1JnVRDHxmNYVr15zLJvpcTk+rknTSJJtK7hLHRrQontCijxfbehKeM6P4Thrern+soKyvKXHoouLDcUb9XtTTzlUToDDAf9TuH1jHOhvau0e3NZ6lQifbvJ5TKWzH9UYwqSIAYh+IJ09JcJjIyutD4A6nq0ht6WvVt8aYa4PZkweQVbmmyeZZ3UfBoyl/SCNVBYKiThQdZA9fEjlLs+3veVfbljOVMeXHqBMTR+3g/t/cq10NTnDY+DrFA4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7416014)(23010399003)(18002099003)(22082099003)(4143699003)(5023799004)(56012099006)(11063799006)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UU5ESW9hSEttakN6dkFHMnVDeVh4Y0w2SG90SUlsRkZwV1pwOEgwTVQ2dVVI?=
 =?utf-8?B?K0crd04rZWhuL3ZuMXRXUmxSdEJlbm1jQ2ZsZ1FTelNMZVA4LzFkMGRQbE0z?=
 =?utf-8?B?RTg0RnN6VXAxMlNKRWVsM01La3Q3cDNlVE83QkNnZXRJWE9kdHJzUEtRWGxR?=
 =?utf-8?B?NUE4SHhubVFsY1hkeXN3QWNJVmFRYVRFaFh6VVNNeW02Z21USnVoaG0wS3oy?=
 =?utf-8?B?eG5ndXM3b08wMlByaU9vNGVmL1I3RmRrMGpoWHEwd1BoUTQ2Vk5JdkJseXEz?=
 =?utf-8?B?aGZMdUpRcmowc2x5OS9KQk9yZVdyZ0hFbnVOQ1doTStLbjVselhlcGR5NmM4?=
 =?utf-8?B?Vk15dkhRbHI2d2ErNndPdUxiM2hiRFpFTVlpSzhqRlV0dEpjTjNoMklRSEoy?=
 =?utf-8?B?OVorZnhUUlhtTmloWlV4UXp6NkV3bXFnOEZNTWRwdDExMG45RTFYWXM0NEp2?=
 =?utf-8?B?TWlGRXppalBuaDh3cUNQbXB3a2orUUROQWhrQ1F3WGFHN2dpeVFXUmpWd0dl?=
 =?utf-8?B?RVdGclBxNWFrQXBkZVdzYUJMdTdENGlSMWNNcmhKWUsxTisvZ2ZjTWY2MHFH?=
 =?utf-8?B?RHBGT2N0YTZSZG5sWnJJRFBNd1EwR2YxaDB1N3RwMENoemJuSkZtL0xDejl6?=
 =?utf-8?B?bnlEV3Z5VjlVUzMyZkduWURLQmFxNmk1cjZQKyszOFVqOGdxY1ZHczlyRHhk?=
 =?utf-8?B?NnNSWEhKV0tqY2hvMlBYMThuQStZVkxWdW1PUDFDKzJ1b0xUNG53V3g1ekRi?=
 =?utf-8?B?eXBRalc2azN1OVJjVjdabGg5bytMK0VDaGhIcVNIdkFUMjhrd2M2aUNlWUoz?=
 =?utf-8?B?ZlFUN1JjL00xNjZiMHlyYkE4bXNxSktpNHBmWGtjb3ZDL1VEeThTOU1VZUdH?=
 =?utf-8?B?N1Y1NllPTlp2WnlJc1YvMi8xZkNkN3YyK0N1WEowSFJIMG9WLzllaDNRcWFF?=
 =?utf-8?B?Y2dwN3NrWXpxemo1eTkzTGZ6YmpKUGpTaVFuOXNWQlZLMzZoamloWnhtNWlP?=
 =?utf-8?B?NWJtOU1SRzRWUjg4RC9sYm1idkhCQU4rVXVZY0lIQWFNaDFIKzRDellRa1E5?=
 =?utf-8?B?djJEQnVNS3dSUmxhemxSUGFZMjlhcFZKTnRONWozR3ZDdU12SDB0YkdRSTBH?=
 =?utf-8?B?cnBiUndDRTVncG5Hc25sYU1YSnNDRUo4amdCdjRaV25EYlBSWERRdjR3T1Yv?=
 =?utf-8?B?ZThJS2F3ZW1kOG9mQ0xFRVZ4S0E4VzRPZTRveUc4YjlPb2tHSnpIZ2tHREtR?=
 =?utf-8?B?QnI0NlBJTHNmdnVDM2ZCM1I2USt5cms4ZGYrcis5bG1SY04xb1RnMUtVZGFH?=
 =?utf-8?B?SDlsWFMwQjd6S3QvZGVrZzkrTXM4UVhuNk9OZUlWWVJHR3FxTUltOUlKZ3VI?=
 =?utf-8?B?aEVSQVhjOUxwTmQ1aHlOY1FRWE80UytoN0VrYWlZekF1d0lMdHh5cXcxWlpq?=
 =?utf-8?B?L0M4SEZLR0hwaTlVKzkwYzN1dWFtWmNMb1RKOFhyL2padzJZL2o4Q25Ubzhm?=
 =?utf-8?B?MlFqaG9wUGtlQkVLWTZ4dm5MZ3hlU2NGNnpWNVUvQ2hJNjJNY3dQSDcwdlhO?=
 =?utf-8?B?dWJOTldWTWFBcDBDS1BKazRFRXdSMitIc25NRFJCU3Bvc25wbDRuY0lqYkUy?=
 =?utf-8?B?d2wvbE5PSENBNnZORVRmUXQyRkgrZ0dSNTlnNDUyVjhKVS9jZXBhL0hkQmtG?=
 =?utf-8?B?NWtYcG92c011RUIvM2JwcjNiRU1jcHMwUE9UZGpBcVF0SFFLK1pES050b1I5?=
 =?utf-8?B?NjdGblg0OFNUN2Fqb3BoSVlITWhDNkJDVUcrakNGRFkyL3pTendpemI0SnZP?=
 =?utf-8?B?OXBxYmFOWHp0c25SZDhRTkRXQnptNXdJMGJpTUZZdUJXdFluY2xxTmxoM1Vz?=
 =?utf-8?B?aVh6QkFseS8wMllob3ZsM0tXRGN1MHVaeS9YZnh1TnB3SCswbzkwVEdvWWpo?=
 =?utf-8?B?M2U4TW5GdlhqTWFKaXVwbEJJUWpNNTh0N0Z6aHJxS0gxR2dqYk96K2Joc1h3?=
 =?utf-8?B?RXFYdDBERSs5Um1ZYzdFWSs3Yk8yWTdmR0RBcVFxeHIyQWVLNWwzWGdZUVlC?=
 =?utf-8?B?NVBVNFR4VVBKS0JCY3hiaklSb1pBRzRRaDhiUlJRVWpBd1lsQTU5SDkzNU15?=
 =?utf-8?B?MzdYSUFSYWZ5aEJYbEt1WndiN0VNajAxZ1JhdlplbWNpV01ManlZeC9oNmRq?=
 =?utf-8?B?NnFzZi9xQnhtb1BaTlRCbXNjeDM5aCtjRnZFOVhMYmdTOE4yaW02K3IzWU9z?=
 =?utf-8?B?NktTUUVCM1dZeXBteFNqVjBHeXphVHdDUGF1ZzdYSmpVRUM4QWEyQy9sWVFi?=
 =?utf-8?B?UmxJMVMvRFNleVdWSW1QODVMTkY0UlRmMHd6NGlnQTkvOHRwc1Evdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fee12921-d465-4f56-5842-08dee28958c4
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 15:54:26.2378 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NRyiB5n8QyGoJEDdDE5wyKBjC3BakiotcPOt/1IieLBVEmYq6/cB+DSNjoNonZ63iLgSWoLhmD12OAckEp7b5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6415
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

On Wed, Jul 15, 2026 at 01:00:12AM -0400, Yury Norov wrote:
> On Sat, Jul 11, 2026 at 02:51:28PM +0100, Gary Guo wrote:
> 
> ...
> 
> > > +static unsigned long __init benchmark_bitmap(unsigned long capacity)
> > > +{
> > > +	unsigned long count, index;
> > > +	ktime_t alloc_time, free_time;
> > > +	size_t memory;
> > > +
> > > +	bitmap_zero(alloc_bitmap, MAP_SIZE);
> > > +	alloc_time = ktime_get();
> > 
> > To eliminate possible effects of optimization messing up benchmark, please add a
> > barrier() after start timing and a barrier() before end timing. Probably you'd
> > want one between each loop iteration too.
> 
> It was never a problem in find_bit_benchmark test, but OK.

So, I ran some experiments: 5 times with barriers, and 5 times without,
and repeated it for reverse order of capacities. 

The results are:

Experiment               1,000,000             100,000
Bitmap allocate    −0.28% (p=.631)    −5.63% (p=.0039)
Bitmap release     +0.89% (p=.247)     −1.30% (p=.089)
IDA    allocate    −0.03% (p=.971)    −19.98% (p=.035)
IDA    release     −0.27% (p=.315)     +1.38% (p=.165)
Maple  allocate    +0.09% (p=.579)     −1.06% (p=.529)
Maple  release     −0.54% (p=.315)     +0.03% (p=.971)
                            10,000              1,000
Bitmap allocate    +5.19% (p=.853)    −3.17% (p=.739)
Bitmap release     −2.16% (p=.853)    −0.45% (p=.912)
IDA    allocate    −3.42% (p=.247)    −6.80% (p=.190)
IDA    release     −1.21% (p=.315)    −5.39% (p=.063)
Maple  allocate    −1.81% (p=.529)    −0.32% (p=.529)
Maple  release     +1.39% (p=.739)    +0.11% (p=.631)

The barriers were only present in allocation loops, so release
measurements serve as a negative control. Most effects are small
and statistically insignificant.

Two allocation comparisons have unadjusted p < .05, but both show
barriers making execution faster. Across all 24 comparisons, neither
survives Holm/Bonferroni correction; the smallest adjusted p-value
is approximately .093.

Codegeneration-wise, both objects have:

 - Identical text size: 2,413 bytes.
 - Identical instruction count.
 - No additional loads, spills, or fences.

The barriers only changed scheduling of a few independent instructions:

 - Bitmap: loop-counter increment moved across __bitmap_set().
 - IDA: counter increment and ID accumulation swapped.
 - Maple Tree: region_indexes[] store moved relative to the
   loop-bound comparison.

There is no code-generation change capable to produce visible performance
impact.

With all that, I'll drop the barriers. Instead, I've added the
WARN_ON(!xxx_empty()) after the release completion for the data
structures: to ensure the release is not optimized, and to
additionally enforce integrity. 

Thanks,
Yury
