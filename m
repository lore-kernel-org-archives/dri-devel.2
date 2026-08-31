Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1909BC61DFD
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 21:09:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D19B10EB4C;
	Mon, 31 Aug 2026 21:09:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="TEk7NQxB";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15B6210EB47;
 Mon, 31 Aug 2026 21:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788210590; x=1819746590;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=OQzQgvtZ76SMKd1fnj8DhnM163b6l/1U/MCYtC+hLkc=;
 b=TEk7NQxBnHVCXaSRk+YJzyUdZvtAoznRODS0JJGUG6Kc2/PBqGWaGScA
 jiGsY1jKIEXtdcffRXm0yxjQNrwy+EZrMwj8GNNe5UjFxICrmLTOU0/6W
 Rt6EidhJle6bSyNU6h5SH5ewDzIdP2Vl3weD5xk5+bVf/fMJ4wg1JUhXj
 YHomyobbkzIEnBbEFp8hOcM0E6qwA62eFR4vyYoNSRdcdXBfY3kSaX4jt
 VuoWSRGLgK1MUgVWjO7TSDm+ndCRFzyuCJIEktLwUYGIEt6lOfxDX+KGH
 kfBW+F7U8R8WHpicd95dPbY1zYzKhDne7BGrce+9uWpQSxDIKjPoAZ9s7 A==;
X-CSE-ConnectionGUID: C8sLR/2QRgOUA3fkkrS8oQ==
X-CSE-MsgGUID: l2xMwJ+fQPKAfcIhT8twdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="106149281"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="106149281"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 14:09:50 -0700
X-CSE-ConnectionGUID: uOvyEgQsRSukz11PbYiSWQ==
X-CSE-MsgGUID: pphgl9E1Ry2lGSsI4yWGbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="270815761"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 14:09:49 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 14:09:49 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 31 Aug 2026 14:09:49 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.24) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 14:09:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHFsgIC7plZkZGs+mNp/Nk/MIUZK/geIQtPsRD3DX85LyPx7zt3a/ygBXwULI3PfeaOfsYvkuJEgCLWM8ezc5fAeIqwwYpRNPV5NmJlKPwpsi7p0LZyv30NmE74CkrvF9edrfUFF11q05gMx6qLbbvqhyY8BlmTUF6gbatQ9+TZaFlsJk8pwEhD90Ff3wQeMRQvKjXTaQj3oaGhVGUqPSzJd3dihoaqisHF8lb1gNAqRJoiEi5u1Z8w+2G7XqiOpLwb5Kzg72hpbGQ3UEcC8xjAaK2ZLoYjsHWrzTrQ1jWxx1si346izj7H+KDgA/kYQkAgKYOGmE/j2u6Oxl9Gwew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4d8rCwFWTLbX6qWk0Ye8/jMeldbDvLBO0dFgRWV+W0=;
 b=jHdc3OI8neX8XMuoKrI0uE0mKiAe6sHPgE7ECf1TNuvVGgR2FvV5+48216ZY2tcCASNCCRG0N3sOGYDrubLfuYUx220lpRyGCCxrWW3oDcfW/K8ClUGMwHdjejC1uKMA23gjtx0D/c009QbJQTDAZwt5Kmk5RHh7/L6RpaQEtdnmvkSh4vEFctHqXSBDm3Kk3fjHFOJJvo9DyzuSy7evkQoAbII8lRGDFutSrUZwPoT+f4NZS2QeoPEH+SRXosOnh1+5sVKaSTC83kNAOPAgnslwLTmU0cq7p9x4fSpW1n/VWOJrTbl17ci93zxX+KlN6K1GGvG2vufo/fCcpy/kBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SABPR11MB9938.namprd11.prod.outlook.com (2603:10b6:806:4ee::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 21:09:47 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 21:09:47 +0000
Date: Mon, 31 Aug 2026 14:09:45 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
CC: Danilo Krummrich <dakr@kernel.org>, <thomas.hellstrom@linux.intel.com>,
 <ecourtney@nvidia.com>, <nat@pixelcluster.dev>,
 <dri-devel@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 01/10] dma-buf: Add reference counting to dma_resv
Message-ID: <apXtmV+O3Hmns4Fd@gsse-cloud1.jf.intel.com>
References: <20260827124910.2245-1-christian.koenig@amd.com>
 <20260827124910.2245-2-christian.koenig@amd.com>
 <DL0SABOU2QO9.20AA8OP9CXXA5@kernel.org>
 <apHe5YcWWiZF4i2Z@gsse-cloud1.jf.intel.com>
 <apHiw91fFbKuogDJ@gsse-cloud1.jf.intel.com>
 <c359b608-c6af-4cb8-a750-a29b5b26180e@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c359b608-c6af-4cb8-a750-a29b5b26180e@amd.com>
X-ClientProxiedBy: SJ2P221CA0002.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:a03:5db::12) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SABPR11MB9938:EE_
X-MS-Office365-Filtering-Correlation-Id: 411c6184-b431-43ad-0105-08df07a4302d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|4143699003|56012099006|10067099003|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ej8H98IBcfGlQQERPx2y1vC+mhyDFlguWSPbHTiAqO1ERHOAoRr30tClxjPwVJh0aAGPxyhdkLBepTZXuF20xWXxCaE7doZzPbD1C4nGs/5uBM3F+1VaqJ/VrypbCi0M41QkJnwkqH7AsbEFXk7RlfpYDvlgBKbXm0lT+sucf7wY0K038laUllzQPuc44dHubo4QCYTmYv4tCJB6b9aA0ki5047NfOrya4/4rp2QgHaqn99xnFTJ7UWzKZh3Kw9SQB1I7AxGJHuHZDeZ5mVl1l74BDXn+vHVwFkwoxzH5914mLSnrixxyrBMALMG4hA9/HjsSRuK9Emme+4sIcFM/BqlHp/Cv/SHlFrCoZFLehJbFNd9yTu4CFVmnlBBY9lx4EiwA1UctIs51pceaAqb6X7Asx2s/iF/6/mJNT7Sjnty3je0KrgyokLtVHnZ93O4UTMvpKBhYqE1j5wiYq2gj0xBDjNTxIL3a9sZHqx0AB9XZ/DSqSvCuOvnOCP274u/bj3v86ziVD3Zj1v4zhLl6Q7FTWJEO9gLkmAWbHKD9OJFlwoYH9P2jWcZTFwA/ebA9hQ78gJpdVoqfbP/S1wnj9cVccw35q249993yb7sgzaDT07DCj0WRERmMD830Jvu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(4143699003)(56012099006)(10067099003)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?z75BO6gm2EwXuKQTq12z2VIqmVEMpb96fAm3tBaRNmam3NLjrAgKwgM8fu?=
 =?iso-8859-1?Q?rKj7CeTCOVz1y1FOr3om0InSB/GDzspMO1u1zX5cSGKDIlIqWUJfZU4AeC?=
 =?iso-8859-1?Q?NKPpHfovqOM+9qjeLL7wGOpRrs6+CI77uJv0WvMyhjTq0chQtUW6NDoKzu?=
 =?iso-8859-1?Q?y7fztR2qXtEwJ7EF7v6P+9thR6fcuvE0aLP/tVO4JpFUbn5kZBV52saE3B?=
 =?iso-8859-1?Q?3OJkbsBB0gjEg0SE+oaA+cqcdtNuoBh1kj9iNw23+XJC56PE1GQBSVW/go?=
 =?iso-8859-1?Q?b8D9NX9aDn8HiyPXOkC0P47dJYJbmHqiwIZSs6PV2U9KQaE+ZIqrxpVl0q?=
 =?iso-8859-1?Q?mOT2IfekVqqfEeeU+6xBlpOKeGQgH2Y0i3GFng7619TyXR7qA+DFAwfHKn?=
 =?iso-8859-1?Q?lzAa+ynKX+mC13dM5aEDa8epBMt8nVL/0GpdZDqEJyoBTG4skTGcq1KVco?=
 =?iso-8859-1?Q?rEgWS1bq7CMxKTs4up6mUgAY8sHgnA8WrfFibPzKZLmPsjQBIQ+AFl88Sa?=
 =?iso-8859-1?Q?HsdIszNTK8Bq4CJC0rjFd+4WCqLeIfmx9oy5ZgKfuYU5t4vmSHqGRWXH++?=
 =?iso-8859-1?Q?rMiVLaqtdTBqt/XblIInOBH6CVY3ceKp3jvxZgWgGRYGvjFB/47rS/8gSr?=
 =?iso-8859-1?Q?P0P97i/tr2ybytUKXxSdlAdoddHG8/dOqVYnNvOkDpjaVM0h5V4gmdw9bq?=
 =?iso-8859-1?Q?x/jGZowecBlNzZMpku/6OZdkkkzeDcJqWp5yNxEm9WAyoPSmfujGPDpuT3?=
 =?iso-8859-1?Q?LWkP6NGJz+SJN1W2LVbzHiXpvqVKERjf6hTSpD96vu8TtYyPRf2qbp0zhB?=
 =?iso-8859-1?Q?CMWmmqmrg9WH+aNLa7BwC0VyKgM/NHGPJ3sW/8LgnePeMN89cVnWmVtmLf?=
 =?iso-8859-1?Q?p98uy2Jw8QIOTVyJA4anBo3wpH2LFNUzvvcbTwBtsAvkxGaDRGgUeaCp8/?=
 =?iso-8859-1?Q?KsSysgBAxoFn44TO1HpZI4rOOPU3cZpiASrinvSNDLfg1i774ldq42LmJM?=
 =?iso-8859-1?Q?Rh+cmXbGTrUs6yPtb8UxQ8udj0wsikSSE5+hGnnpAoQyJ5iTKBwFOJRGDr?=
 =?iso-8859-1?Q?u+ZbJr4S/rDjdFn4JQUoUP2SgSUpdIRaNTd0IvBm/nJt5BDEWzp058SucW?=
 =?iso-8859-1?Q?vs8YZgnxi2RyBVz/Yf97GMA5yQCzDUoVIH0qX9839ee4ZJaBl/ELKn5DP5?=
 =?iso-8859-1?Q?hMUQIfOSRS36DBs9HKomthawlH6AoImaxdSLKDJWMg4TmGGvJ5YVhiTqqk?=
 =?iso-8859-1?Q?tb2v7Uxrz9P60mxdMeMkrepb1QccZH+NwTZG2XHnqh8npCjeQhOqSKMj4V?=
 =?iso-8859-1?Q?0jOYLOVGVkRhbI/jqtoKEQUOzpaONOABJnq0LMNFGHL4MIXGL3sGMKVbZE?=
 =?iso-8859-1?Q?dIhORaib5BahYSbiGx97vhG09/czE+tUeV4vwvVBFKtHKCphat1ccxTYoE?=
 =?iso-8859-1?Q?QeD8GK6IimYSHJ4xPPA3H/XSVKI9bhqaizLLKgr7yEBPNVQ4s91FA/hTzB?=
 =?iso-8859-1?Q?iNnfs76SefaOQBJEPom1fgVAmYPYbTPjFmqpnV2/K4+Iz9yd7xhgEKogAS?=
 =?iso-8859-1?Q?vYgEPtZ0sLY55Vdnc/368x3b8IJOnjXg0nQwZ5XCmMPK83P96aFEuDTvMn?=
 =?iso-8859-1?Q?Mk0JrM2HS67BajMNTH+Eps7T/IO1KdQJaaGoPVVsU7PTYMks5kaLQ4OXxm?=
 =?iso-8859-1?Q?mStoZ9SpVJH4aSv0qXuHob/2Z8c7af5hJj9czCWg8MBfAzx0TuZuOZiv94?=
 =?iso-8859-1?Q?hw8Euzq7O3h5ymiC5IW0j7santNvRjO24IidS0ZPTkO2PtloW38wnkEkDK?=
 =?iso-8859-1?Q?94Fe7jOjM3QqEkZ/nKNsThKFTmEj0TU=3D?=
X-Exchange-RoutingPolicyChecked: 0jeiKI9L/Mx+jzi9aYTadc88UL8cOsNdcRZLHn3quDlPrAR7o7xMFU8MCI1h5jef9txwHfEHcWtjb+71equkn7g8UW81jeDRFqZ45O9kv1BjR82o72jXwnjkO7ki06YO674A8zVJHIhnd8f/1RRETjIFvHuQ2SDre7XobWqWovOtZSYXD1zbh52ep6rVgtE6PxnhhO1cD4USONdxV57FMz7X2lQfkrCyYOMVbhtqmPBF/H3kMqjANMQoAVFwGEHqBrpMeqvnCKVGsvoH5b0Fk71aKGhjRFXLVlZjiMYYDEJSh551y942bpoKIokJWNoWQobpCY8TSceE3AA8vSLuKg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 411c6184-b431-43ad-0105-08df07a4302d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 21:09:47.6445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9mSRaGO2qDfDbkzhFw6HhFKRu6M04WT4sOBXIYZxE4C//OKp7gM+DXy9o25YAEGr2YjTFI/AmhANS0A10fSDYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SABPR11MB9938
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

On Mon, Aug 31, 2026 at 09:37:10AM +0200, Christian König wrote:
> On 8/28/26 21:34, Matthew Brost wrote:
> > On Fri, Aug 28, 2026 at 12:17:57PM -0700, Matthew Brost wrote:
> >> On Fri, Aug 28, 2026 at 08:21:17PM +0200, Danilo Krummrich wrote:
> >>> On Thu Aug 27, 2026 at 2:38 PM CEST, =?UTF-8?q?Christian=20K=C3=B6nig?= wrote:
> >>>> This provides clearer ownership semantics and makes the code more
> >>>> maintainable by removing the embedded allocation hack.
> >>>
> >>> Again, fundamentally disagree; please see [1] for details and reasons.
> >>>
> >>
> >> I think Christian is doing this incrementally rather than as a single
> >> change across the tree. The last patch [2] in the series removes
> >> `dma_resv_init` and the `allocated` flag. I believe that was the main
> >> concern, and it appears to be addressed now.
> >>
> >> I'm taking the series for a spin now, as our CI [3] had trouble applying
> >> this patch. I'll let you know what my testing shows.
> >>
> > 
> > I ran our basic CI suite and didn't see any regressions. I also ran some
> > eviction and shrinker tests that stress interactions with active fences
> > and exercise individualization paths, and those passed as well.
> 
> Thanks, that is exactly what I wanted to know. The whole patch set was AI generated and I still distrust its quality.
>

For sure, AI is generally yes good at getting most of boilerplate stuff
coded, then a human needs to jump in and tweak it.

> The interesting thing is that most comments come from Sashiko-bot, so AI is now criticizing the quality of AI generated code ^^.
> 

Yes, Sashiko tends to find bug in other AI generated code with its prompts.

A brief look, some of Sashiko comments are definitely correct. I didn't
run with a full debug Kconfig + plus run tools to check for memory
leaks, etc.. but I suspect if I had if would have backed up a few of
Sashiko comments.

You can just feed the Sashiko comments back into your AI coding session
too... But general I'd advise against that, or at least scrub the
Sashiko comments for valid or not valid first.

Matt

> > 
> > Matt
> > 
> >> [2] https://patchwork.freedesktop.org/patch/748868/?series=172875&rev=1
> >> [3] https://patchwork.freedesktop.org/series/172873/
> >>
> >>> Besides that, I don't really know what to expect from the series. The cover
> >>> letter says "Refcounting dma_resv v2", yet there's no changelog telling people
> >>> what has changed since v1. On the other hand, none of the patches has a v2
> >>> prefix, so what is it?
> >>
> >> Yes, change logs / cover-letter would help as Danilo likely could have
> >> spotted the above change.
> 
> Mhm, I though I added that in the cover letter.
> 
> Regards,
> Christian.
> 
> >>
> >> Matt
> >>
> >>>
> >>> [1] https://lore.kernel.org/all/DJVRML4G11GZ.Z7FTZH7I1LZN@kernel.org/
> 
