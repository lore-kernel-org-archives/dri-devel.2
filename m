Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754F3C61DD9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 19:34:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD42010E51E;
	Fri, 28 Aug 2026 19:34:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="JQa1SnDM";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4465F10E4E6;
 Fri, 28 Aug 2026 19:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787945679; x=1819481679;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=POfdMBCBEwcVJc/QH9jV0WXa1Y4+3g44/jWVRYSDedw=;
 b=JQa1SnDMC1bV/bx5QkmbGt7ySzsnHvipv/gMRQ+O1engqOVpvDPfHG1s
 9bTO8IYmwgUXQpK1lD+bqrG988jHUT1Io/vP8brBhcY0jDDxlNXzRNtD2
 DIlHvDqs8wNlqrNgNSdxRSX7XL6VHk2TTYbprPB5FDkoXDcEXK4DpngmD
 2HQqKu1y+YZAHsnv0o7S/O03ky/nk/5GtkwV+71TNdwHlq6lr5Jr2bpCb
 SMiTdPnYPfLkz6xnXyaS6xWPhje/1TLu9qxgOEDwSidgfcI6jrtYoGy5K
 zcnCsHp7kGRaTWGsQ1Cn20oeTq0CJqEWBEzKn0NGRFDyrT2HsjPtjNc+O w==;
X-CSE-ConnectionGUID: 5XS8xTXOTDSWwcTsQh1TZQ==
X-CSE-MsgGUID: 1px8pvAASKWYCBBLZalXJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11889"; a="111234933"
X-IronPort-AV: E=Sophos;i="6.25,249,1779174000"; d="scan'208";a="111234933"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 12:34:38 -0700
X-CSE-ConnectionGUID: YJdWm4j6QL6u2bvBbtFDoQ==
X-CSE-MsgGUID: Pc8CFF6SR4qrvNzuWplrDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,249,1779174000"; d="scan'208";a="267679049"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 12:34:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 12:34:38 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 28 Aug 2026 12:34:38 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.46) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 12:34:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qTZCsPPTC0g8z7ATFMKSt6zUG5Re93AX3mHaLI12gvS+RY6dMS9CecyYRZ74Jik730nwbmdft7v910n+yFPhg8JbVTg/SxQg1ibZo0aZAhJ4vwkM8zeQZVMK/jYdMDJpDoeGh0aWX7hC6UdHj+XlCvhNdII651ljzITeEdRTeLemDJs7kKFiZsq9ZVbCxMwKjvKGvBog+sNNizTBUiF1jo49yjiiYN1oCYcT0+ypmKxTsMfRzXu/llq4a0rhYycOCbowqU2XpZJv5wzwHSgBfBSqZ2zGIwpH6Jt6L4yRqrRz1ohDwhIaLd/ojBhxXS8S97dIYpJWmuEhWBzP2KjjLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7EpNFooops/G4uFROQOCsTfVTdwO5dl03aF5pqPSSuw=;
 b=J8bN46R9BIOnRNvfHmFIVf11MjB5C+uad2UDNn+GgzZ+buAbWKq5dWgBrBv4WIXR3WB5WZpaH7sMGhRyNH25Ed4WXqA+x2Ii7ym6/f/4MtluplKZur4rVDAPIUu140Uduc+u7Gz1nc1cNsoruy4/UeAapf9JzXCjC908fzRAI6paavPChrnspZxJJCEXwn2MzLGriiTKjucHZL0jsoOOKE3bTZY9dkQNqFj6NEbrAuBToyviWjwM/E8xJemnzxbFCxF9yRfHw/dI8Gp7P1x0+nIKjtI5TNBds1M0vT49YtBnTKI89e/4jG2nOIXfgFEU+U4vUDy6pINhkXdZIJUaaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by PH8PR11MB7142.namprd11.prod.outlook.com (2603:10b6:510:22e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 19:34:30 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 19:34:30 +0000
Date: Fri, 28 Aug 2026 12:34:27 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Danilo Krummrich <dakr@kernel.org>
CC: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 <christian.koenig@amd.com>, <thomas.hellstrom@linux.intel.com>,
 <ecourtney@nvidia.com>, <nat@pixelcluster.dev>,
 <dri-devel@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 01/10] dma-buf: Add reference counting to dma_resv
Message-ID: <apHiw91fFbKuogDJ@gsse-cloud1.jf.intel.com>
References: <20260827124910.2245-1-christian.koenig@amd.com>
 <20260827124910.2245-2-christian.koenig@amd.com>
 <DL0SABOU2QO9.20AA8OP9CXXA5@kernel.org>
 <apHe5YcWWiZF4i2Z@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <apHe5YcWWiZF4i2Z@gsse-cloud1.jf.intel.com>
X-ClientProxiedBy: MW4PR04CA0363.namprd04.prod.outlook.com
 (2603:10b6:303:81::8) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|PH8PR11MB7142:EE_
X-MS-Office365-Filtering-Correlation-Id: e9fa386e-958d-4a76-4299-08df053b611c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|7416014|1800799024|10067099003|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: EPYzuylv6DEQc4EdD8yV+faUHdRCx4J3hGLso0wIsGDlkSaTiwcf0EVNtI8cq0DTsaTlZ3dfHiBwsv/nnorkbJsrofJC7HXDsHItTMtFm+T4rkc+oiJGXzJ6KzTOS+FDQdCDl0w21LRUY0YoRlmTWogkiJiVd+l2BOcWAvKRxsjpSqsMETrBLbuuN2iGgCBb0tORabAi+7Idlefm2xZbzPXb8AqC4Z9EQlYaBetjfFiCRduFXN3Lj+OBkS8DKAXtr3xnef5bc+F8b8wFsnm2FU4P0Kl+aqPhWmv9wW8EWwb96vIhY8AJlkwnowAgmU0qMKpEO4BCg4W+AlYOcMAjp6Znzivb01Mv4Y1q55JPVtWYbGIAawcU4Esjz7YAITl2mukjQySgzFhLjc93t1uRUD/hu3Zo930dRvYkcP/P1GlG7iX0ZF9vWze0pPT6FijXu3LAUTzUDqZ0aAOyLcp0gXyjqNWqULcwG0+Rv6qgn59b2zDtlnV84Pv3XnkLaJ6QuaeRpDN124lXz9eg6uT/vv9jic9hzudwyJsZ4u5ZZ7j+dUpmA3tMvH1NT7BBrH3qVj8C5aaPgnktr94nbFpvLn9bzpLJSavac+31dY4t+zcQQFRUjabNYpdX38Cpeqa8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(7416014)(1800799024)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ul8RFs1OB4Rm0omm5DuQ3HEtfoLVZd1IWkaeM3HdHGahLLXOGWXOzTw+YuLg?=
 =?us-ascii?Q?wabW/G/JhyqcaDos9Is91gIN4qzLrJ2TEPMBJdj/wGWOSNvRaGxE5sqiahkO?=
 =?us-ascii?Q?WSwuLxsQlN+v/7lRA1c3zIz3C9CqDA/BeZ0NxTfMyPVXYV6+VsLoZUoYl8Ag?=
 =?us-ascii?Q?KhGeK3FBY0XfRnRjzqFirr9I6GYbaCOuR8gI2vgnSV0Xt3z4qtwb1U3oh+SF?=
 =?us-ascii?Q?XpnfLPATnl21t1Ohui7FqCVeFaNN8BAoThlmTrQ5eqYrvrFfzLqzKhp7SXIY?=
 =?us-ascii?Q?rRtiVGAM4lZ3dMu7HKh6oU1bwMQxGxU9qSdrzW5HrH/mk86ZKNLcsmgyKBRp?=
 =?us-ascii?Q?ot1ZWVKb6ZV78xNAf0MHV1pfb9MpAYhONIygSUztJg7yEmixErrnVMoeluvw?=
 =?us-ascii?Q?J8TXnYEY6CJL+xcCDxGOIYFQR0WJa/NycO3a4dLX6KV6vTXBqxRAWpZATKcB?=
 =?us-ascii?Q?B64lBo/AQFPWwMeVQ90sL/ImPaUqGUY0iRT6ss5UqMMqH9RmsjDNrTAPGL3B?=
 =?us-ascii?Q?j3RcjhtF7ZYciWyqqBAJmOuPatfCxxhW9yMWds5p2hxAZPe81ZX2hyRLHKt8?=
 =?us-ascii?Q?k+nFNXQM3jII4tjCf0veQHfsYz3XKy/mLHgVEoA9kMndxsOsBs7nh4RxdCal?=
 =?us-ascii?Q?jByMv0GnWtADzQuJjM1+X2XKYAZwclXaaowq1/J9f8AZ3w8Iw9MLCEpaUM7M?=
 =?us-ascii?Q?tbIC7cdzbI6hQLEtBmp4kCzYl5UDBGFPoztfbIIR7FQklWZf1P8tabstjOCn?=
 =?us-ascii?Q?CIsyZ5a44xcwgf074pVplwI2iRImnYygu1SCh6U16Z8S6vpD+sIcch6ceKGV?=
 =?us-ascii?Q?xFwkGgTe7PQbshPVwlbLe20aKWsHB8oNGADrtR26KW1mvZuYjVsVorl/bYVV?=
 =?us-ascii?Q?FuZaZFXHhewa91ud50hiPRQFDjfkWi/ZknQUwkhUZrRIXvOVqnafYZbCLjjZ?=
 =?us-ascii?Q?871NtstcVTr6MlKJQEI+L3mi64UgUMq9lkwPuTveAn7eIcFLtQfzQ20CMfqI?=
 =?us-ascii?Q?qHdQNT81jK9PO+rP0VON7/wcHuDuNtaCC39xG0dCTXeEbZNU91q6i3+iVDFo?=
 =?us-ascii?Q?ehhUAlIrIsj/Zubd9gdpTLW38Sp49Oju6chUJTqWNjZ5FoDIW4GRIueuvfeb?=
 =?us-ascii?Q?Wtn21JZF3JaA5tsYF59V+qZoyTOR4aSUzQQyRrr68ekrX/Ew1UKeT+4hsdGd?=
 =?us-ascii?Q?ukTxIDiPyuS54ZY5eS6RCRIeTNZKA1N2Uydee62J/pFzWf+/rLlbWJr9Ydui?=
 =?us-ascii?Q?o7q5wLYonSPdYl2N1upIz1PbEY3fmuoys1u5jijgfQrYhLpfUK8zFNDA7hWo?=
 =?us-ascii?Q?9XdYUEKqo/EXCHomPN6icrS1LSq8x837C0dzaiSb5wzhfXg51gRT8Xjvkt5b?=
 =?us-ascii?Q?0jfUxHsLpWQD4AzXb2wAGglS006BD1asoqrqWB7FSvsvW8hjjNGFGxBRlbuW?=
 =?us-ascii?Q?M+SMRHtVW5sbMXGHv+tYP1ZniCZ4BQ4eNeKb1OGEEqpJ37n8vZu5SvvSmfi0?=
 =?us-ascii?Q?SCXKntRcUzl+EG+bzrbW2GNJkwEJLfnDPN8/DPbd6j0lOme5JOrCtp6FflIz?=
 =?us-ascii?Q?J3hf+mQg5rhURuz+CXoofdJ0wogbEwuo+nPeJn0Hywm2vYhgBgztAUmxIZ6p?=
 =?us-ascii?Q?7FDNYnxBjz0eLOoas/8lCGjs26hOH2vVxZUNLZgLg/YzvgG38d4mGErmA4yu?=
 =?us-ascii?Q?SVvyGmmrUUvCM9BF8Kt9QQee6poGKQwOxGY2mc0rhZ/qhoqwiArpxukUuPKD?=
 =?us-ascii?Q?+ql7x3oP9YLUcocttjOzVBlrdHzWOO0=3D?=
X-Exchange-RoutingPolicyChecked: loYhzU7HdOCKI+JMrGka2mxuSdAt0ZMpA0HPFMVuSE1zr8nu6I9qNvkEqoX2vktmA5G9nPxxvhpv366FlT43qaenG5m7G/tu9Wer9uS25vMriRQBDOpgVBS/2YR3Mw6MbhPn5UxHgOOckIS85PpE8fANarGy93raJiHABZj91bgSQbTeJMLmYuJlwjaPBgWj2ipKEg4hKwH5zErLSRMF4sShzQcGGGvS7Y3j+EvToqem6TdN2kqhcX4N46HIim+6G+Efc0TM/GcsF1lja/WrB9rMOcvoKCyFggc8yvw52OMzGsnNzFxzkge7PqSaRfqpLoUg69xlt7mWYbQb0QT8uA==
X-MS-Exchange-CrossTenant-Network-Message-Id: e9fa386e-958d-4a76-4299-08df053b611c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 19:34:30.1851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sPG+qx0FTnXaZJpwrCxd8eaukRZeq6HtsgmYfQywus9wEvna9tLbSjSn/kFH/PaFnPEM9i5RhmKnfhdLEBvycg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7142
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

On Fri, Aug 28, 2026 at 12:17:57PM -0700, Matthew Brost wrote:
> On Fri, Aug 28, 2026 at 08:21:17PM +0200, Danilo Krummrich wrote:
> > On Thu Aug 27, 2026 at 2:38 PM CEST, =?UTF-8?q?Christian=20K=C3=B6nig?= wrote:
> > > This provides clearer ownership semantics and makes the code more
> > > maintainable by removing the embedded allocation hack.
> > 
> > Again, fundamentally disagree; please see [1] for details and reasons.
> > 
> 
> I think Christian is doing this incrementally rather than as a single
> change across the tree. The last patch [2] in the series removes
> `dma_resv_init` and the `allocated` flag. I believe that was the main
> concern, and it appears to be addressed now.
> 
> I'm taking the series for a spin now, as our CI [3] had trouble applying
> this patch. I'll let you know what my testing shows.
> 

I ran our basic CI suite and didn't see any regressions. I also ran some
eviction and shrinker tests that stress interactions with active fences
and exercise individualization paths, and those passed as well.

Matt

> [2] https://patchwork.freedesktop.org/patch/748868/?series=172875&rev=1
> [3] https://patchwork.freedesktop.org/series/172873/
> 
> > Besides that, I don't really know what to expect from the series. The cover
> > letter says "Refcounting dma_resv v2", yet there's no changelog telling people
> > what has changed since v1. On the other hand, none of the patches has a v2
> > prefix, so what is it?
> 
> Yes, change logs / cover-letter would help as Danilo likely could have
> spotted the above change.
> 
> Matt
> 
> > 
> > [1] https://lore.kernel.org/all/DJVRML4G11GZ.Z7FTZH7I1LZN@kernel.org/
