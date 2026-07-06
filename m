Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F0DC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 23:14:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96BAD10E3EE;
	Mon,  6 Jul 2026 23:14:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="MghRBlLz";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BF4910E3EE
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 23:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783379666; x=1814915666;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=S3d9K6lxAiVo1vfbPyhpC3ubRZbcu/nC652fOHfsM40=;
 b=MghRBlLzb4S8udjIK8G02/1mPONJnHsrQw3ysKT2PK0slzyKePV7uAHt
 gb4ZYCBybVMX+DSiSBtqRdCtQpcjUqUfpBndKx+8hfMV6K0eSVaRpBY86
 s4zhHfvFL9ZlxfHyx73OeHnukvxTs6rN2Xg8AbTRlCc2D+/vfjtCyOtAS
 yNFdW/bnAvr71d3++j1EHiP+uJ7C/lovE1HqH5ci/PBJlJAuGFlzzGAGp
 LXvuNeRjJHf4XV1H+zqpSDWz5QZjXy7/FkO02CCetwKi3+d7GY++zjTNs
 JM1qkjzwO2yKbL0vv19faKwOwGiMUnKSbnSjRhstSl5L/rQCjOb+gqt92 A==;
X-CSE-ConnectionGUID: wXNKU/GKSuiXr79CIURK4Q==
X-CSE-MsgGUID: R4UatCa5TLOTgpSRzmyR0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="94667250"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; d="scan'208";a="94667250"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2026 16:14:25 -0700
X-CSE-ConnectionGUID: Yhhu1AivSfOmDgpZ0E43ww==
X-CSE-MsgGUID: iHBoMnn0Ru6WKYSZmTWK1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; d="scan'208";a="258155181"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2026 16:14:25 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 16:14:24 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 16:14:24 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.56) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 16:14:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nz0HZBnM0Cn/3fz/8W9daQu4MgeP3q7GRRc6YcNl+FJiOcMeeAI0tryrmM1KrLIOZtmDLHORBg0enzKDGXEBAmp3FLJPWnTKIUmmgWUrkJs2TrDP7bwYLYjvh+02mNAKIEahsv8q1KtAuoL0QZmA+y2zqjdhFQdE3DYCkxr1+I2pUCjsej9QSfpvnKbjG32aLD9YrQm7FXktr7VePBhDtDj+dW/F/9bzQDKEJ7bmppdv6C4fXrynB/ZrTdqYxxiSsgC3jQtGGPSm9HQpvVJqSe9Z8ZgEbRawwielAoQpJ/a4pAhCOfU1gMIiboAl4D5aL992jImiR/Tp5d2d4SrEZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLX31qex5tvbYy5I2m/Ajb/gzTH3qlmmV5PkT2amOGw=;
 b=itq4wLy+yMvPJGZHxS+aBtsnG5qvjak7+EtXfpaIF79lNSg8SKNfVFHSIbAngpJv23LgijUrD9e+dYIvUR2509M5YB7vhuGLDrTJgtELRnek+mtHMHDdqUcRn4xdvkFe0slIC8I/VbhXHxdbYJgUy15Cfq8Rk1BP5KqtlPb/tDTfYSgM8msCUwDRakw7sbtUPwhlJUDscwteOQ5WcMHb0ycgLc4KE9zWANgw4+I+V1QlNv6vWleU7euUwmENY1W7TCkjLVM27JLi5F8ybBq2rWw+Wb2C/XO282cFpBerRpI9KhutCuDnTL2/z9cFTfOA9uIIMgKPS7sk0HIpiFLutg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SA3PR11MB8119.namprd11.prod.outlook.com (2603:10b6:806:2f2::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Mon, 6 Jul 2026
 23:14:22 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 23:14:22 +0000
Date: Mon, 6 Jul 2026 16:14:19 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
CC: <dri-devel@lists.freedesktop.org>, Boris Brezillon
 <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, "Liviu
 Dudau" <liviu.dudau@arm.com>, Chia-I Wu <olvaffe@gmail.com>, Danilo Krummrich
 <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 <kernel-dev@igalia.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [RFC 4/8] drm/xe: Convert to per gt scheduler workers
Message-ID: <akw2yy1WHW5q9u8P@gsse-cloud1.jf.intel.com>
References: <20260702143745.79293-1-tvrtko.ursulin@igalia.com>
 <20260702143745.79293-5-tvrtko.ursulin@igalia.com>
 <akd7iFDLUgwhj6+H@gsse-cloud1.jf.intel.com>
 <e15d223d-21d8-42f1-a37b-52f515d1e86f@igalia.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e15d223d-21d8-42f1-a37b-52f515d1e86f@igalia.com>
X-ClientProxiedBy: MW4PR03CA0260.namprd03.prod.outlook.com
 (2603:10b6:303:b4::25) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SA3PR11MB8119:EE_
X-MS-Office365-Filtering-Correlation-Id: e834835d-6196-4fa2-8597-08dedbb45063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|1800799024|366016|18002099003|3023799007|56012099006|11063799006|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info: soEdty2sYYYjXZmPgj0j4iMVGWBEpeWnUpK8pI6YWgZd+GFgGZBl+IFpvcojsle8dw/YkaYmtwrBq4gD4TVGNWw+C03iWQY31eN/rrlC97dSk9VX0B9NTMUnJJUqBYIQee+F+V5yJ6aMP1W03uw9PjRebgSEVmF0cYxzo2hUHlwuvXrG54Rh4aHtI8iAJ6MDD6rH88qfJ9naxY+zH4hHabrD2f0nyGNGNA0vKYMeqw99BtIAZjVdj3J/K6j8x9iwBfQ5yAzugfrkARwyS0rmT+3y+tqTA0xM2+TZebSbcIQc0lnWJZpFFv/shMP97x9M9kZGXS+to7uS8jg+Vd7c1xIgFdf6Pw5Tn5QomRxvGfzfYOEpq+YFW/ZEpKcwkAc3THf7kJWSAgyMsiAHMmnIy30FoLDq/JDsCL8842ygz9nT6DEzzCDnAnHvWtk8Oj3jWXJUVyMf8eCQhz8ITLZX39GqgD7lYyD5uBDT/G0eFkRJN8c82a0W6JGo2zMYQcl0AT/sqILpBklScFZz8z8NYW81mHEDEjgQoqZc3MeqgMOZBMKLNKa9ELuSyL+at8JCY4ECdOuKgGrxnEB/HY0MuAmJRIvV54MZTnyfOzpc9qVf5+OF0h6bSb+xW9fUSvTu8vfjYCaiCYEk19MIYWOLw6ZlijU4zc4KMaKzmIW0LVs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(18002099003)(3023799007)(56012099006)(11063799006)(4143699003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?T0d4beSdoxzK+gkLeyoa9m8xu4NMs+E/ZoRyX9gsZUcRhxEQS36MdHL2Vw?=
 =?iso-8859-1?Q?mlmmKyiG7lkRgqwnkxBya5KVtrFZOjDPnhVdnWs2mjSKXNVfB+CBLRSIVb?=
 =?iso-8859-1?Q?M5pGaQuQr/d4fC1F4Y23J7z56ygaW6D5tKOjgHXCZSxvkZ9v79WynApZRs?=
 =?iso-8859-1?Q?T/m3htqGh+Zpr11CuQvCqNQi4FHQEBSW/oPdyd4g1pChhs/TI+9kZ5SBBn?=
 =?iso-8859-1?Q?v7mmc45bv0oAxDIwyvsZANeIboROH6vJ7R+j4Ef2763C9BKmkmk8RIWsFs?=
 =?iso-8859-1?Q?KN/oaQhq//pMv3UD6jLyXifBpUt5+t0m2QzJPR8jZsfJYr7YG85n+yVl0S?=
 =?iso-8859-1?Q?mC5dpxkHX8oOG6U9tu7qp9oTVGfpIjx5c8zmCT+UtmkAcPhmwSdxWcgLjr?=
 =?iso-8859-1?Q?23AzE7vuOzwn0Gr0f0s2KQ6qEW3xq9h0VGc2mcSdDdlUn+1qs/bPOXBD7y?=
 =?iso-8859-1?Q?7EyBCYUudv8bemL4DDyKFJIE7aon+LZKVeo4oc5Sl0RmPYkrEOG3KH9MXQ?=
 =?iso-8859-1?Q?kK7LQoiLJ87Sffu6qJxEiiWKGJrZ8XaJK3N6xnGTxtSaOOlXwRVUct4A2n?=
 =?iso-8859-1?Q?wC7hNnJCQgOUAEzROmgbggHcDknUKtA4gR77wJYW4zH+hduse5uge22AVL?=
 =?iso-8859-1?Q?aEGjZTuxe9yylgcNRMrhMiCnQmIZsWef4jgDavY5H3/+aH760LQltfVXcv?=
 =?iso-8859-1?Q?HpjwnhpTb5x/Px4BPC3FRMG6hVHWjQL7n+bsM+VfdnG7IWkdIGfEFuCx5p?=
 =?iso-8859-1?Q?NrkRJ4Xj0JAaFUF970ZWuYzSDPCubrAflC1dYFai52dYpBPeAVMGxH8UJS?=
 =?iso-8859-1?Q?H46RjR0xYYPr0CZFz/xyYzwXJPXp195aHeGFwu4KZ57eqcanHAn0XxjD6p?=
 =?iso-8859-1?Q?JdZWd8Di8DUk4nCgJpNvbBQdkHUrfKZyMP5iTDbxzqcQUEAIzvuedAovL0?=
 =?iso-8859-1?Q?MpYAvhpvPaB83QUo2ovDOXgvdj4Bbxts13lgVbTZHAT5KtVWNUff1mVXNz?=
 =?iso-8859-1?Q?ajfOfNr6UmO0ojbkusBrl9ig39kCUpBVoLNvzHUODJxXdMApo5KroEurbA?=
 =?iso-8859-1?Q?KQTGgQkLYSYbiqZq5LHMrrZxSyEJ8BLwSro7MHFUPh6rlRKpL1YYvyHkEt?=
 =?iso-8859-1?Q?agz6Pl2fiJfa9+IoHie/bTwH/PVqa3+e+CUOau4WBf9St3WTseqrA/e5Nw?=
 =?iso-8859-1?Q?l3yzth1bbnphotu36hAbNgbEWP1YGHC4wJ50fNNZgKCOwoQ7aUXT+ug9nJ?=
 =?iso-8859-1?Q?REBzRoAbYStfIqPUzuSG/OmhPsGVl60NuBhHvhS0KytOusiSwCr1GxffLg?=
 =?iso-8859-1?Q?L2kBJM+tr5QvRuZVYi0Ner+y6jyBKx0VSlXhCWYDDFthwcNBq8tzpGA4wj?=
 =?iso-8859-1?Q?cotao8VKP6NU3RcSn5OCAqXoxxQWVz1A/916YzdadTnhmjKeA8nlQ50YRU?=
 =?iso-8859-1?Q?cVfyiARiffSWUyiwmdMRmktSpnbGF1Ll+qMfJhKEoN7ES5khB9F7XyuXjV?=
 =?iso-8859-1?Q?x/guUPNhLiwtrlPAMv/R481yMmR5NjWnl443KJSS4JQZ7rcZ5J6aNBdyF0?=
 =?iso-8859-1?Q?SqAWVa0EtsznvkZmxAgur0PbIMhLFuxNd+Bc841By9WzyqKzGTwgp6j1Hw?=
 =?iso-8859-1?Q?52NqSJrgVBXuUhbsr4tltMD+KdlUjJgopjdQUfYB+POeekCsqsS/V936WO?=
 =?iso-8859-1?Q?rhm0h1ieNJ3+ZfqKAhO6RwXjqpZ6L3EUEy55Z1TnfjzmmiDu6ycsiLlZE/?=
 =?iso-8859-1?Q?/lgGmoumtYRULGErTkd5TeQ2NjolqHDG8tDeTh6gmy9GvAGfU5/QA4Mdv8?=
 =?iso-8859-1?Q?RoI7kcUWvQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: ebFa/VA/52Okbed6KTF6+jzK8VbKsxi+RxVaf+liJl7iW5h7g104ebLofPTkR4AOvqYLOQijGpfzUGaYsf4ygqGTlxtGFYdQTmEo6F6tTKHEGdGMx0P1bsClID8vek+4hjk9x2VApAOm1M+LEw0YclkFk2HdXIayreNo2Lf2MrqeItoISC0vpK4THr/8xigr+cUz2ijNhP1LEVt/EEcDl2JNoJkrId4VSLZOtd974BF2y1B5o07fH+TNlYjKVKR4RNGgQ6Z6OdLVwkrGciRcIjighrViwlHcQQTFAuco7M6TUDtlMXW1LN/r0Ql5dbHmMmmpdZy8fULHB/z3py/21A==
X-MS-Exchange-CrossTenant-Network-Message-Id: e834835d-6196-4fa2-8597-08dedbb45063
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 23:14:22.4101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XK923VD4xd81ehhiRSq/PjANKoQ/0GUYNzFwsXcleBY8RgeBtANqfpLS1GJenm6PsKCfHWQme13WD+7M/jChvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8119
X-OriginatorOrg: intel.com
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

On Mon, Jul 06, 2026 at 01:27:46PM +0100, Tvrtko Ursulin wrote:
> 
> 
> On 03/07/2026 10:06, Matthew Brost wrote:
> > On Thu, Jul 02, 2026 at 03:37:41PM +0100, Tvrtko Ursulin wrote:
> > > As the submission side of xe is serialized by the global GuC CT lock, we

Profiling shows that, without backpressure on the firmware interface
channels, guc_send_ct throughput is about 4 H2G messages per
microsecond. As such, the serialization here is very likely just a
spin-wait on a short critical section.

The work items also perform work outside the CT lock, but in practice,
for the non-waiting CT-lock cases, it may not matter whether we use a
single workqueue or multiple workqueues give the slowest point is likely
the GuC dequeuing H2G.

We're also looking at doing ULLS submission in the KMD, in which case
there would be no serialization at all. Likewise, if we created
doorbells, we would not need to serialize either.

This series seems like backing Xe design into a corner for a problem
that compositors / RT submissions have a pretty reasoable different
option (bypass). More below.

> > > can easily afford to create our own per gt work queues. Whereas before
> > > kernel could create up to the number of CPUs threads, we now create one
> > > per GT.
> > > 
> > 
> > This breaks down for any execution queue that waits in a scheduler work
> > item for any reason. Long-running preemption queues do this for
> > time-slicing, multi-queue registration, and possibly a few other cases.
> > 
> > I've looked at this before and rough divide is this works for 3D but not
> > long running.
> 
> Hmmm curious. Could you expand a bit more on this?
> 
> Where do those wait, in run job or prepare job? And on what ie. where is the
> cross-dependency?

I think run_job can wait on multi-q syncs if a sync is outstanding for
the group.

> 
> Is it related to the alien work items xe "injects" onto the scheduler
> workers?

Preempt fences inject suspend/resume messages into the scheduler queue
to toggle scheduling state and wait for a suspend timeslice.
Additionally, if the state machine that tracks asynchronous firmware
commands is in an unexpected state, we wait for the firmware before
issuing another command.

As a general principle, we've accepted that it is okay to sleep because
this runs on a dedicated workqueue. We could rework that, but I'd prefer
not to, as it simplifies the code considerably.

Matt

> 
> Regards,
> 
> Tvrtko
> 
> > > Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
> > > ---
> > >   drivers/gpu/drm/xe/xe_gt.c         |  7 +++++++
> > >   drivers/gpu/drm/xe/xe_gt_types.h   |  3 +++
> > >   drivers/gpu/drm/xe/xe_guc_submit.c | 11 +++++++----
> > >   3 files changed, 17 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
> > > index 783eb6d631b5..fb2db9eff341 100644
> > > --- a/drivers/gpu/drm/xe/xe_gt.c
> > > +++ b/drivers/gpu/drm/xe/xe_gt.c
> > > @@ -706,6 +706,8 @@ static void xe_gt_fini(void *arg)
> > >   	for (i = 0; i < XE_ENGINE_CLASS_MAX; ++i)
> > >   		xe_hw_fence_irq_finish(&gt->fence_irq[i]);
> > > +	destroy_workqueue(gt->submit_wq);
> > > +
> > >   	xe_gt_disable_host_l2_vram(gt);
> > >   }
> > > @@ -716,6 +718,11 @@ int xe_gt_init(struct xe_gt *gt)
> > >   	INIT_WORK(&gt->reset.worker, gt_reset_worker);
> > > +	gt->submit_wq = alloc_ordered_workqueue("xe-submit-gt%u",
> > > +						WQ_MEM_RECLAIM, gt->info.id);
> > > +	if (IS_ERR(gt->submit_wq))
> > > +		return PTR_ERR(gt->submit_wq);
> > > +
> > >   	for (i = 0; i < XE_ENGINE_CLASS_MAX; ++i) {
> > >   		gt->ring_ops[i] = xe_ring_ops_get(gt, i);
> > >   		xe_hw_fence_irq_init(&gt->fence_irq[i]);
> > > diff --git a/drivers/gpu/drm/xe/xe_gt_types.h b/drivers/gpu/drm/xe/xe_gt_types.h
> > > index e5588c88800a..175c42672546 100644
> > > --- a/drivers/gpu/drm/xe/xe_gt_types.h
> > > +++ b/drivers/gpu/drm/xe/xe_gt_types.h
> > > @@ -248,6 +248,9 @@ struct xe_gt {
> > >   	/** @exec_queue_ops: submission backend exec queue operations */
> > >   	const struct xe_exec_queue_ops *exec_queue_ops;
> > > +	/** @submit_wq: ... */
> > > +	struct workqueue_struct *submit_wq;
> > > +
> > >   	/**
> > >   	 * @ring_ops: ring operations for this hw engine (1 per engine class)
> > >   	 */
> > > diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
> > > index 9458bf477fa6..858f84dc8fed 100644
> > > --- a/drivers/gpu/drm/xe/xe_guc_submit.c
> > > +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
> > > @@ -1928,11 +1928,12 @@ static int guc_exec_queue_init(struct xe_exec_queue *q)
> > >   	struct xe_gpu_scheduler *sched;
> > >   	struct xe_guc *guc = exec_queue_to_guc(q);
> > >   	struct workqueue_struct *submit_wq = NULL;
> > > +	struct xe_gt *gt = guc_to_gt(guc);
> > >   	struct xe_guc_exec_queue *ge;
> > >   	long timeout;
> > >   	int err, i;
> > > -	xe_gt_assert(guc_to_gt(guc), xe_device_uc_enabled(guc_to_xe(guc)));
> > > +	xe_gt_assert(gt, xe_device_uc_enabled(guc_to_xe(guc)));
> > >   	ge = kzalloc_obj(*ge);
> > >   	if (!ge)
> > > @@ -1964,12 +1965,14 @@ static int guc_exec_queue_init(struct xe_exec_queue *q)
> > >   		struct xe_exec_queue *primary = xe_exec_queue_multi_queue_primary(q);
> > >   		submit_wq = primary->guc->sched.base.submit_wq;
> > > +	} else {
> > > +		submit_wq = gt->submit_wq;
> > >   	}
> > >   	err = xe_sched_init(&ge->sched, &drm_sched_ops, &xe_sched_ops,
> > > -			    submit_wq, xe_lrc_ring_size() / MAX_JOB_SIZE_BYTES, 64,
> > > -			    timeout, guc_to_gt(guc)->ordered_wq, NULL,
> > > -			    q->name, gt_to_xe(q->gt)->drm.dev);
> > > +			    submit_wq, xe_lrc_ring_size() / MAX_JOB_SIZE_BYTES,
> > > +			    64, timeout, gt->ordered_wq, NULL, q->name,
> > > +			    gt_to_xe(gt)->drm.dev);
> > >   	if (err)
> > >   		goto err_release_id;
> > > -- 
> > > 2.54.0
> > > 
> 
