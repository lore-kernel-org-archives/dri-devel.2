Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2EE5C44501
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 13:27:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30B4D10E388;
	Sat, 11 Jul 2026 13:27:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="AeijeUw/";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58F5B10E386;
 Sat, 11 Jul 2026 13:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783776447; x=1815312447;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=bveeKeF5iNdt3W2RvCUZ9ViaAe1ijOOdnlOX48qPsyM=;
 b=AeijeUw/zKMH1UyL66stSt/FU2owHWKGXlfVTq79FiUDe/oCiQdnee9f
 ArP6+onPMeQE5MToARe+PS5JMxmHexPvFbLNcTk9Qsvo6a2sb6cTD+Nvk
 OjucWD7cLYHIeIaOUTt52Ai/c4DSFNv+i0dLabjA98gbOjTXcJs0xtMxP
 sON+tTGamveJS5cXRG5kSvaNuPyGBC9iy8QgPCOEChRJpoLg1ZhKh/T78
 cV7FUmf31px6Qb+CUQw74pMoWTS0fZKQqxoKU4JzQY5f+5XIuVWCdPsz4
 R+vEskJV2rPSqW0g9eaT9YMORFBHLS6o8uSSkXiRmRjusU8mrKfDPQPak Q==;
X-CSE-ConnectionGUID: kpUYpmcLQGKdSpWX9YZMkw==
X-CSE-MsgGUID: /JCGUvosRf2AXedJdoMR0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84310591"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="84310591"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2026 06:27:27 -0700
X-CSE-ConnectionGUID: OTk/SueTTweH+2uUwsqhsg==
X-CSE-MsgGUID: RLB6sxOPQqqIMpTY027IEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="254627670"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2026 06:27:26 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sat, 11 Jul 2026 06:27:26 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Sat, 11 Jul 2026 06:27:26 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.20) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sat, 11 Jul 2026 06:27:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yOJ25cwoF2DxFliJUfXwQMorWZ213+P19BZyGw9eQKQ6d93Qv+9k6t2Fkj9rFphX6WCyF1IcIXLseEhbIwK09QgTqKKvwp7Dw/FxCV19EidGVy1Tl4t4Sl8ElR0uDPSXnDwESuHm26SX2vEhuxernV440rn/KQfKW6ZV1GlOfBCqH49Wop70rz5Cx5Lu8csVBtu9UChDA5hm6/T0/yHD9cVIKOZ8tCjQeJU6jCrI5RiDIIVCWiG8SxHVG0jU9Z0mEmHMbva3u1DZ+VNTw3Kabk6dqQL1cSHVITXoJstru5pu1JTcq8AETRCEKTDv2ZB6WNVYcOW23Y/XHTWZHaWnag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncSuyVJ4HlTck9IjCPPC6f8YkEalpYtH+P8Ml6TVMEs=;
 b=h1jewXj3eO3Rty341fUrjsVrGcfDLFW4SQiXGPdIgIdbtS6iCLHmeLxbXt+l99vyIEsdfoYtcG/h2tLIKfoZsRukpgRgiqQMFN5DgrpEq2Qqyt1U7GwN3/lHKTKinYY+0TC1fDcmKLwXyd7+B7M36b2P7dheWuepMP9kD0nFIgoB607MckDyr18aZDFLkIOkABC40iRbpRlanWDGYPn/re9cJOxl8TyqDZfrDMNjSln5kXHhzei4PzmFcPXNwK7OUcKG/qAlXAXOPvABqmP5P1XFg6h0DwQOko55M+vRmnlrnC1w/eVHWIxZBFI3yxLOdKRE4xK+hDFDf9j/gQPQ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DS3PR11MB9817.namprd11.prod.outlook.com (2603:10b6:8:365::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.19; Sat, 11 Jul
 2026 13:27:22 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0181.017; Sat, 11 Jul 2026
 13:27:21 +0000
Date: Sat, 11 Jul 2026 06:27:18 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 "Huang Rui" <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 <linux-kernel@vger.kernel.org>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v2 01/33] drm/ttm/pool: Allow backing off reclaim at the
 beneficial order
Message-ID: <alJEtsrtLIsPYfEm@gsse-cloud1.jf.intel.com>
References: <20260710215442.2444235-1-matthew.brost@intel.com>
 <20260710215442.2444235-2-matthew.brost@intel.com>
 <731fc65a-ab8a-43f6-be6e-03b7fc08698c@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <731fc65a-ab8a-43f6-be6e-03b7fc08698c@amd.com>
X-ClientProxiedBy: MW4PR04CA0157.namprd04.prod.outlook.com
 (2603:10b6:303:85::12) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DS3PR11MB9817:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ad36fbe-5a9a-4d4e-0d64-08dedf502362
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|4143699003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 3ybT263p8pMPlmKbncPnLJ7W7UESDcar9ATMr+IT1d9Idmg/tixUd5pzawdVSb0ErvYBdDs4r8YTU7izZLP8yjb3iYgJmpBGjyeVY7d6EJXszso5IGQAneeRb4GEIeIN0oMaU0K1R4B49lk6mfBKtVnSpzrX62s/FqlOGyiYXjHXmtWJRhqWIbY9gpHuy94k9mC3pFJctaDbhNO+kYw9+CbB1zE6MoaxFxE+XFrWhL8QGlcrcZ+1NnKo4q7L+uS8Yc1s3ru1AIAbKcZYylS7XZGtOdNIoBp+9btkeWAmql54MaNlwIxlrrVGDYAyflmtCoty/5LQdI8sr2T8JYaaKVvIwktpDJHmkkBtXWafIMx2ypjQ19h40cuxZ8bo+p/00fHvgdKXIz4Ld77NRjbl6CafxUpr4w8Lxl7Y1HKVq5A49oq2MZrXLN3VCYd3puyGDR3a0gLR2tG+VDYLYWMKB070N6JGzbdOIEzM2xekt/GNZBn3CI5SrPiWI+kWpo0ZlMlbEtySgmH9icJW0E4ZE++acM44vLX3FJydXDbnrXIHWkkDnRIbqx0186Se1HGEO7y13M65vIVxJN+OxX6bv04XKNN81lRhpMog8rONVKDVhTljo0fUHWajen5ug6myaiDudGtnNVv7Am//GhsUC8cy8z4SgICXP5rQaxxupyg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(4143699003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?2hNfMxoOiduNTeCry7UR0xXVOnoyIMtWqZkrUiuQY3GTyN5zrBjOdi7iAy?=
 =?iso-8859-1?Q?bUVrL+BVlj/vZo/n5Mxb9fPaVoUVcOXa9RknfplpNa3wNwLh4grAVHFxP7?=
 =?iso-8859-1?Q?1F3REJhio7WHThbI7Ovx+PNXRFJxQNI6TK36nsOeLU+WkclnZYRF6BpwNz?=
 =?iso-8859-1?Q?VH6Gj6af7mXmky5VFQEBY6a2HuZC97V083GjYp8zJCLAKgjrwfVj5btIWI?=
 =?iso-8859-1?Q?kJt5HGzYfoVk0qhCJNaIVfvRku26HQdo05sdYKea3ux0OYdoIt0VUTVMRj?=
 =?iso-8859-1?Q?Y63D/hEe7S0ypdKIFivjPFo408upmskLGEXjqKTogoEwrW5YVJTjDf4KOT?=
 =?iso-8859-1?Q?+Spzz27tk2Y1s1g80shevFtrOZ+Qc2ZMqY0dBriN2aO5s89/Iir6UdR6AN?=
 =?iso-8859-1?Q?Nq4XmNEMcDvkF4Hd2lbDWGclT10OY07jdb1cSxsQHQYCTQNzctHtn7Ev3n?=
 =?iso-8859-1?Q?EOK6du1504q1ltN2Rwjrqpd4DotxFfeDonUYPDD3eeJmIPRvUn7ud821jM?=
 =?iso-8859-1?Q?7sbMXk0FYaFIsyF2DzwPbhq00hadxDhfe9HKWttiPF+3LTJ0sLAwuGXdgU?=
 =?iso-8859-1?Q?oOUbdLg1g7dKYMzNUf9MsRPLIM8j2dYW5sqWEtvHwwQqgB+I8hjbZmkVOq?=
 =?iso-8859-1?Q?tLPTfkQ0h7sbs0iswwmH2V8/xbeQktDBa54W1rJjERRLVmtTLD1KyzZykQ?=
 =?iso-8859-1?Q?lvkMNAbCpPevL0JdgjJk8HOD7aPms5N32tThnV6a65/LgHCN8x4U6s8Wlg?=
 =?iso-8859-1?Q?rUjvT05TlvB8aHnxJIGwAx08U2bfuNCfThErGw7WDCjGV9vHfXW0qVlFTx?=
 =?iso-8859-1?Q?mreDcAME0g5JvnPhb3WYWkmO7vF4Sx4fCxqC4mKjfk25pWnWPeLlDPuV1v?=
 =?iso-8859-1?Q?SOIwkQjMcZXXdaNtXi1GoOnMf+aneniyTcHsaYnYQ9ixJuRN73qssPOaND?=
 =?iso-8859-1?Q?68VrXSZlBSydRgPO41F18uUetL3X/5Vr7RotX7giArPh8HIevnc/Ii8x7U?=
 =?iso-8859-1?Q?YJdVlNpwlUFaAvE4Qi/5Nz1ANN89FOuEVnQbE/epoW+jmv7Y8lekLc6F+G?=
 =?iso-8859-1?Q?cYgkkT0a+CukQ77EiuX/NiiRCdoywxj/JRXyEgfWfYHkz95zBBa9AJWQxx?=
 =?iso-8859-1?Q?e570/2Pz6GxMKiSuG1cGTbSKmPyulstsGRyUoLNqJJ32wW4vISgsr9FLFY?=
 =?iso-8859-1?Q?7bjxtqiNVvGWsGBJbVlgViXV38ThMhkNrwe2UJTruaWxY4ql//6OFrONrI?=
 =?iso-8859-1?Q?jBWUQSwDC4C4BsQTiQBYaqagsmA1VxqhWqdI+fJdiQFycxNCM8fJ1SnFaW?=
 =?iso-8859-1?Q?VmciRiNjryxR88VVvGYb3yKQwOQVqNOTV2+HqKpDaxDDxwftNcPgR0AEM2?=
 =?iso-8859-1?Q?+u78aBQg/57IYTQG4+2nLLZADfOR591DeCfQm58MUz9N8dNQFUk9dtt0tn?=
 =?iso-8859-1?Q?mtJ5nACDpsPjsu7/kl+DdH044DwLowcPds8fOGq86ou7zKniwg9zvZft94?=
 =?iso-8859-1?Q?G2dePSngDVfq+mjt5bvarBC/P5mYOaNBjVyoYLZczDWQldusW55Q/aDvC/?=
 =?iso-8859-1?Q?3zbp4dMjnNNYNlh0Vp0f4zMQ23n1IbwFvldKRCtfrQG2RyWxgnm4B9SZxA?=
 =?iso-8859-1?Q?ewVOyWyNG9GhnFZSJzIL9im5KnXYdUnDEbOZEGw7blTRcLtX2csvcqPGMl?=
 =?iso-8859-1?Q?Mqr8wNEOsb0v4uO1gpSeOPFdY9I761sC5/JznHjKiiueqoFvFrWq31JrpL?=
 =?iso-8859-1?Q?VTSA4tkAYYUYQscdjSs0G80IvuNb6X4j56s3iFT/+weUQbSul+FnLQ5n2V?=
 =?iso-8859-1?Q?Mynh3/Iouw=3D=3D?=
X-Exchange-RoutingPolicyChecked: YwPLC4jws0MQRpe0JGTtBs3ZEbgujghShb4TkyAmtFCmuMaDlxZEiVFczd0ubxigZ5MojLlFOCFMrBWWV0ugpCjctp1st/fA9ozt1arHXAyvc+NGgfL0VEeoTg9i3Hi0DrZh9b35VPBFVy6zMsrV4NPznvHWEWZObWTaA5RhwduUKB6UTVIF6iIXljWW+e+oF5M2BQcG2Dw7NG57yvoYSosXaBeGINCrE6AVytaB8zhKpjmUAcLgGHSXg+wZMcDngRgDd0cLNtqk4cqcEJW5ti0oTp2RehReBiWRPTgk6XzrSlwfzt8/gqS1t2x9Th1OscCBBH0jryVzEn4FwRg//w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad36fbe-5a9a-4d4e-0d64-08dedf502362
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2026 13:27:21.8782 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQFYzSyAEtN8J40tRCkxAHnT48b+yuapYPH26TPkdtw75W/WGUAKp3YZKGcI0LjnLijqeshASC7Y+BqU6xvOOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR11MB9817
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

On Sat, Jul 11, 2026 at 12:38:10PM +0200, Christian König wrote:
> On 7/10/26 23:54, Matthew Brost wrote:
> > Allocating at the pool's beneficial order normally uses
> > __GFP_RETRY_MAYFAIL to push hard for a contiguous high-order page. When
> > beneficial-order allocations have recently been failing, this retry just
> > burns CPU cycles in reclaim/compaction before falling back to a smaller
> > order anyway.
> > 
> > Add a beneficial_reclaim_backoff flag to struct ttm_operation_ctx and
> > plumb it through to ttm_pool_alloc_page(). When set, the beneficial
> > order is treated like the orders we already consider not worth stalling
> > for: __GFP_RECLAIM is cleared so the allocation skips reclaim/compaction
> > entirely, and the __GFP_NORETRY clearing / __GFP_RETRY_MAYFAIL promotion
> > is skipped. Together this makes the allocator back off quickly to a
> > smaller order instead of stalling.
> 
> That makes no sense at all.
>
> You first give a beneficial order from the driver and then later overwrite it.
> 
> What could be done is to make the beneficial order part of the context in the first place, but I don't get what the use case for this should be.
> 

In this series, the use case is that BOs have already ended up in the
driver-side defragmenter due to suboptimal placement for one reason or another.
In my testing, it is fairly easy for higher-order allocations using
GFP_RETRY_MAYFAIL to still fail. If the defragmenter already has several BOs
queued, there is little point in continuing to try aggressively for higher-order
allocations. In that case, it makes sense to back off, accept smaller pages, and
fix things up later through defragmentation.

I could drop this part, but in my opinion it does make a reasonable amount of
sense.

> It looks like you propose that TTM should accept smaller chunks of memory initially and then comes back later on and re-allocates things in huge pages.
> 
> If that is really the case then I would clearly reject the whole idea. De-fragmentation of smaller pages into larger ones is the job of the core memory management and *not* TTM.
>

Of course the core MM subsystem defragments memory. However, the driver-side
defragmenter serves a different purpose. It relies on the core MM making larger
allocations available, then coordinates TTM state updates, asynchronous copies,
and mapping updates within the execution pipeline using fences.

What the defragmenter solves is the "once placed badly, forever placed badly"
problem. Without it, allocations that end up fragmented or otherwise suboptimal
tend to remain that way indefinitely. The defragmenter allows those allocations
to be reorganized over time as better placement opportunities become available.

TTM is simply a transaction layer that does what the policy layer (the driver)
instructs it to do. It is not responsible for making policy decisions itself,
nor should it attempt to impose them on individual drivers.

Matt
 
> Regards,
> Christian.
> 
> > 
> > This is a no-op until a caller opts in.
> > 
> > Cc: Carlos Santa <carlos.santa@intel.com>
> > Cc: Ryan Neph <ryanneph@google.com>
> > Cc: Christian Koenig <christian.koenig@amd.com>
> > Cc: Huang Rui <ray.huang@amd.com>
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Simona Vetter <simona@ffwll.ch>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > Assisted-by: GitHub_Copilot:claude-opus-4.8
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > ---
> >  drivers/gpu/drm/ttm/ttm_pool.c | 12 ++++++++----
> >  include/drm/ttm/ttm_bo.h       |  7 +++++++
> >  2 files changed, 15 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> > index 3d5f2ae0a456..dbe977412a81 100644
> > --- a/drivers/gpu/drm/ttm/ttm_pool.c
> > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> > @@ -145,7 +145,8 @@ static int ttm_pool_nid(struct ttm_pool *pool)
> >  
> >  /* Allocate pages of size 1 << order with the given gfp_flags */
> >  static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
> > -					unsigned int order)
> > +					unsigned int order,
> > +					bool beneficial_reclaim_backoff)
> >  {
> >  	const unsigned int beneficial_order = ttm_pool_beneficial_order(pool);
> >  	unsigned long attr = DMA_ATTR_FORCE_CONTIGUOUS;
> > @@ -165,10 +166,12 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
> >  	 * Do not add latency to the allocation path for allocations orders
> >  	 * device tolds us do not bring them additional performance gains.
> >  	 */
> > -	if (order && beneficial_order && order != beneficial_order)
> > +	if (order && (beneficial_reclaim_backoff ||
> > +		      (beneficial_order && order != beneficial_order)))
> >  		gfp_flags &= ~__GFP_RECLAIM;
> >  
> > -	if (beneficial_order && order == beneficial_order) {
> > +	if (!beneficial_reclaim_backoff &&
> > +	    beneficial_order && order == beneficial_order) {
> >  		gfp_flags &= ~__GFP_NORETRY;
> >  		gfp_flags |= __GFP_RETRY_MAYFAIL;
> >  	}
> > @@ -814,7 +817,8 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> >  		if (!p) {
> >  			page_caching = ttm_cached;
> >  			allow_pools = false;
> > -			p = ttm_pool_alloc_page(pool, gfp_flags, order);
> > +			p = ttm_pool_alloc_page(pool, gfp_flags, order,
> > +						ctx->beneficial_reclaim_backoff);
> >  		}
> >  		/* If that fails, lower the order if possible and retry. */
> >  		if (!p) {
> > diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
> > index 8310bc3d55f9..fd814b5cf535 100644
> > --- a/include/drm/ttm/ttm_bo.h
> > +++ b/include/drm/ttm/ttm_bo.h
> > @@ -187,6 +187,13 @@ struct ttm_operation_ctx {
> >  	 * when multiple BOs share the same reservation object @resv.
> >  	 */
> >  	bool allow_res_evict;
> > +	/**
> > +	 * @beneficial_reclaim_backoff: Back off from direct reclaim at the
> > +	 * pool's beneficial order. Useful when beneficial-order allocation has
> > +	 * recently been failing, to avoid burning CPU cycles in
> > +	 * reclaim/compaction before falling back to a smaller order anyway.
> > +	 */
> > +	bool beneficial_reclaim_backoff;
> >  	/**
> >  	 * @resv: Reservation object to be used together with
> >  	 * @allow_res_evict.
> 
