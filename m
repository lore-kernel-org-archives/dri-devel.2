Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3A9606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 00:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NIm0Nq7b
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2A0C10E3A9;
	Wed, 11 Nov 2026 00:29:23 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADD1310E02E;
 Wed, 11 Nov 2026 00:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794356958; x=1825892958;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=wSuzEkeIaKC9wLCt4B7EplZE6JMeIgYLw+o38Psp5/Y=;
 b=NIm0Nq7bXLje5CkyTMScMKkICgg1EpiKTEzFtUWI9Lw0x1LKYxMbgPoH
 gvwqBK7MfJ0p/pg+XoZnPB38qJ8VGj8FAImoMlB3MZ5mU7KIZ0tqSw2/K
 X675PGobfvGABLQ669nwJv7tXhr5KVNAZidhQ/tdY6Dv8nxuP5baZ+h44
 CG3EKY4KpFY4hzWC0YJG0zz2uYYZHdz4gD9js3z90Spr9ZkQtTvm/l/dR
 5PqFr7AsvhqwawQX0qQ/3y/ZgYOFN2JSsQo8AueyA4lqMqy2Iya/diMsu
 Z2usc9c3lIY1dWSWqyjvavb+893CaHLYqiUYLE1oji4h0LqqHUABIjqEs Q==;
X-CSE-ConnectionGUID: bZaj+SEERDmElpokGEEKFQ==
X-CSE-MsgGUID: vA6ZLQOARsCcQ2J6ENZxxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3124138"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="3124138"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 16:29:17 -0800
X-CSE-ConnectionGUID: X81uEXQBR/mYdj0uQDHWdA==
X-CSE-MsgGUID: ZubT4X1zS3OLq4/fjSInWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="8453027"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 16:29:17 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 16:29:16 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 10 Nov 2026 16:29:16 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.35) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 16:29:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yj1JG7YmQJwl4/54x3V8BlU1ikK/Vvc/TpBxS0Od34WmMzJz8br5YrCudltoQrKJ9XjV8EC7dlll6K0Zq1f2kLPjZfWrB8AlI6e4LqSLKkETTJ3lB7XH9syEE+kM5N6OUYXQXizdkvrQUlj9Mixe4DN81OvPEF4+ZubGY+rFm991YT8K6yH9VgZLJ+2p9OSlrylLkFJrdBGWte8eEpneniovwxZUzpbSkgEHtF4GzN5ZQIdaHNk7BpMIzvdZbmLZADgBxcIKkFXd7d3u9z/5lvUPFcUKz65AVYL/5dsNVCMtKi2HDv4Qqw1CYZzo5rD94RMzSG+lWAR2613MuMxWXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVf5eVchTBhOZBpUEcUHHHDrsmCwfx2OAO+h/x99Klo=;
 b=wtHzrmLrmD1oxfzwxVPcumMsrVap/7M7vud9rIFMmFmGnuz1MYbpgSOrugMvQshaH+sHxqNVN2QCMEBGHGg37Qk1zJH/THCNVHSRUzvlMrMIeDMRpooDp9IXEVQdmqYS5c3IGajyxFuI2lIpF7J88CiNonNhBXQCoNZYZWN3ysFfBDcjFOLUQGnq3KJk6qBjng5F5A7FoxUGVjo3m4+i+eu8oh9zH08bN0CpK6IncZUfCcel7I6iH6epLp/bRPmUHq7gKsWc0R/LOieZE21cwow3cVYjQjXW5y/2ixM5nK7Do2JoNtbHHZCJ3ozryEQaZ42eXAH4YWDMFqFdhgtcxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by IA3PR11MB9205.namprd11.prod.outlook.com (2603:10b6:208:573::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Wed, 11 Nov
 2026 00:29:13 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 00:29:12 +0000
Date: Tue, 10 Nov 2026 16:29:09 -0800
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v3 09/33] drm/ttm: Preallocate beneficial-order defrag
 pages outside the lock
Message-ID: <avO21YykLwQbPbZx@nvishwa1-desk>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-10-matthew.brost@intel.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260711025619.2540575-10-matthew.brost@intel.com>
X-ClientProxiedBy: SJ0PR03CA0037.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::12) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|IA3PR11MB9205:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a143901-c52d-44b3-b069-08df3f8acf3b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|1800799024|366016|5023799004|18002099003|22082099003|56012099006|11063799006|261009223327099003|261009221727099003|261102130727099003|261026121527099003|261022113327099003|261022105027099003|261021121427099003|261022075727099003|261026140227099003|261021123027099003|261009221227099003|261028144727099003|261009220027099003|261102123227099003|261009223027099003|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: DAwSvSvPnZPK8ehCmxgHDFN1JU/mHrJiv7OgX5sjRX2KiwkGueUsR9BWJ+Mg9oTmz48UgoQp/1/qnk1IZxV+wnbGe02YRV6nebhx6huopa3ZwGV0u6czedekIq/qvjRfbkPt7ZSaaoFpG5yvdPDAJbkE/TvmyAvQd+S9mmqB980mZxuuF3AP3pnM/JBeUIzEm5zYww7hVnzxBG23LmkmPE6S1fnjj7zyh54Q+o5zhorsq/1aoPuCPBUzjeGrUgM73UZYy+GAhcFXCH4SpOTgWAoJkMaen8az2Le5M/Q9ziFbSV7AqMLQIYJ3bWeACQmEFNAT6bYrcV+wVIRx9gKMWMppmEK8z+pyb70ii/S3jwmaqJCKmK4NTynP5BRwf6SvUclqBdr3lImH6TNnZRlIu7HkEKA1/EPjz5HI+MNJjgxO6H/iE6qV44HXF00Mf6fLuiWXVPcwO1LTTvsr6RSRvfIQT1EU0/F9WEHw27MA0veMAmDm6fI+eXWloy9xHlxTNSTgMgTjk9dP+Ic2Dz1GeAZdwJI/knv8SSWf+ih7O2OvXV6w43waMGVSpQmzxt8xrLFEq7MIn8sbOs9u5xH/xvXNo+frT+N2a6CYhnTdg3L/i09bVyo4nHh6qnB+d3BmkXNg9vhfMOyVPHHb1s+9D6pW3V5EC57Tsga2FZpN1kI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(5023799004)(18002099003)(22082099003)(56012099006)(11063799006)(261009223327099003)(261009221727099003)(261102130727099003)(261026121527099003)(261022113327099003)(261022105027099003)(261021121427099003)(261022075727099003)(261026140227099003)(261021123027099003)(261009221227099003)(261028144727099003)(261009220027099003)(261102123227099003)(261009223027099003)(10067099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?lyGjMRrRA43MCsJNkXzbLJawxlxJp7CsDuOVnf6hwtufd81wi6yo6wF3mw?=
 =?iso-8859-1?Q?jMUWJkweP/+MYxYrErcIPH/XeXykfyY5TVPotMSjdJJa7ChWeIMLkQXJOi?=
 =?iso-8859-1?Q?XkIpD8PvcBTfoa6mIhDCKaWeMo1ElQdJhBX2XkbfJ+Px3/5MQoVlmJnV+S?=
 =?iso-8859-1?Q?L+R51vLW45u99o8/gJo4N0fn3W+LdaacmxmS9RvYcsytRCgfB+33/YQC1S?=
 =?iso-8859-1?Q?/M+2XeIaxKPRl7HfOZAesiTg0njP0bGkcDo0g6be8kNSwHn438kt8/rulB?=
 =?iso-8859-1?Q?EwZUeb7NtOwRfX+fnusmjsohLtEyDTRmt2ltMc+0xjkqpriRBYTL/t+nVL?=
 =?iso-8859-1?Q?kd1gWl+fqKCnDjXxhoEd856SPZ6rAadgPE7jCGU+9+A/KSJ/j6PhE9pCSM?=
 =?iso-8859-1?Q?/ZI3lDTzvvv2TzJ188mBtQGcFsdaFs4slDZixjEYnewROLeNDFcSCairuR?=
 =?iso-8859-1?Q?9wbs/YCtcDtBEwsGKNlXE8fyGuav7jwnzyoayd1oVF6zxA3NBwm1aU2Qms?=
 =?iso-8859-1?Q?tEZcb5T59Wh0f1DsyX4g/wTp1es2kUMqGSDEzGYmnOxSYNipGfolHTADT6?=
 =?iso-8859-1?Q?i04ii9b2Ldzl4AtFp9ZglqthW6zdkQLOPfDthp4F4kltqUebYOPzoYyUBu?=
 =?iso-8859-1?Q?x7OY47scoq/IrZQ05Bcog6w8J7atVT1hbbpNTLbIiY2jteWc60cpCwJekW?=
 =?iso-8859-1?Q?0YnbXNEaw756pc6G9PZtOatcZkltHw4NmJGN5CxFUtiJqLtfAWafds10ra?=
 =?iso-8859-1?Q?6095H7ApaQQVkSuKag/s1Jx/KDHxLMpH40GeFoxpcXtQKL14X+qdH6O6kK?=
 =?iso-8859-1?Q?Vl8g/F0uGknUNiqLpbVrkdVfXwQ1I0vjovTSMsmlhtysXe9BMeU+Pgg752?=
 =?iso-8859-1?Q?43FWMPrJZfzquAY+vNheWPDmnklZM3mpljOAPniKLjkX5eliscjGI8Wksd?=
 =?iso-8859-1?Q?sULRUMQdmk5ziFjKrGjLGn7wnvzyA/M7We1omgIsewXuiHawK71I243zGN?=
 =?iso-8859-1?Q?FKygl14gbQEBtxo7YP+fh8IkP+5ccBH3yrNd6AZy+QZiz0XSh71LJDdsHV?=
 =?iso-8859-1?Q?lI3zxCCJVy+q3fCiqvTXzL9nWRvPKCnDz178hIhvT+Nq9D4EsiNbGfkcPY?=
 =?iso-8859-1?Q?YgKkn3GNmyJsh/ArFqrne5Y0fn4cZVqSxTSZjUlC5wNdBI/fed0JULhJ7O?=
 =?iso-8859-1?Q?XnWYNuty0hcBVtpFdItjQ5Rd0xwwh95BlH31Ge0IE2LR1ywNlYdVtO3bxx?=
 =?iso-8859-1?Q?d1SmmnSOs9Xr0KA4pJiX6Gi+DPa/AosUlBlRq6X+IWNbjfrs+F+L+EwaI7?=
 =?iso-8859-1?Q?xspcStTawzhAu7P4D7VdCWr4+QMOFqpyitmK/QBqi3ung5c6VOB+zPJyZl?=
 =?iso-8859-1?Q?QMWW8Hpwm67ybb7f7PdWbsm9RpwajO3G+1QpLndRF4xxsDblD6El+/YfFz?=
 =?iso-8859-1?Q?SzjbNHZI33IPTmw8cEqcFTuwaHqNKl1XKy0rZxZd4vWpCzy4o24h5AfYdO?=
 =?iso-8859-1?Q?z6p077M9gcxHGAJhrYqNGpFu2gPK7B4m9mtwx++OODUvZ+SI0H+loynECV?=
 =?iso-8859-1?Q?CtpRVUuXPY9vpBlKL7WTfbI70iWOVrSTOtqdMnrxHDEN+j2yb/mn5ENEjF?=
 =?iso-8859-1?Q?YcwOE3DjOSRDp+GTXfwuIB5MGXD37sfZ9OMIvzL9QX3WUnOe+TF8Q7N+zi?=
 =?iso-8859-1?Q?0nBVbwvm6JmNdA8ouN266qodcyg3CCrzVpYupZ7NjdZg7CjwzbaP625Lqp?=
 =?iso-8859-1?Q?BY0QA2PZH9bvZcH5wLaQ+BYtSD62lE3MHXaf3WjrNHFA2Heua/nqp52O4H?=
 =?iso-8859-1?Q?ImSSGJZiJNGPAI86g/BV1k4Fzu3f4rhWOXz8/9vR8EntiTCodli+?=
X-Exchange-RoutingPolicyChecked: GU+PkhEJwXZRroDtpXCUsQzvLtJPmaoIpgKcKSCUoVfC+Ds0oPXsPVbluJuNEygMgmzgi6nEt5IZM9MU+j3hsjSGdwO/olnsrgCg9gu0Recw1mUrSZiaJy9CIa4LLN+ctXAIJfk+ke9CTbsyiYpO9ssDKwz9tX80piPVkY5csvYO8QvpEHybYEkAj4VOzV/FXRGWac4+5nSSSZw/IO3j0VmAflJxxqJkJD9gLg6mdVucad1nFOpX64PKbY7cUEqLwl/OwyFh1XNYRvhR5sNfXhWeyNy39eFY3cy+/oxXF/jBb9JbTCfjiu4QHzslGr/bqvnerCOW3+WtsoChe9vO7Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a143901-c52d-44b3-b069-08df3f8acf3b
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 00:29:12.6645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /VRJ5rx8v6fnm2SzTnRUzAWs9okXgMPHw/2uNcWDB2lfKK19NdoDbQ5BxRJtTddebIvheoXGNxk/Kn0LDj2ic+BTv81994Bk/LG+WHiBD7PNjaGf2oUCqYlQf+0SBieT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9205
X-OriginatorOrg: intel.com
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Jul 10, 2026 at 07:55:55PM -0700, Matthew Brost wrote:
>Defragmentation moves reallocate a BO's backing at the pool's beneficial
>order. On a fragmented system those high-order allocations frequently
>stall in direct reclaim/compaction, and they run under the BO dma-resv
>lock, holding up concurrent rendering. The defrag worker does not care
>how long the work takes; it only cares about minimizing locked time.
>
>Add a preallocation bag so the expensive allocations can be hoisted out
>of the lock:
>
> - struct ttm_pool_prealloc carries beneficial-order pages preallocated
>   outside the lock; ttm_pool_prealloc_fill()/_fini() allocate and
>   release them. __ttm_pool_alloc() consumes them via ctx->prealloc.
> - Apply the requested cpu-caching to the bag pages during fill, so the
>   set_memory_*() cost is paid outside the lock too; consumed pages are
>   already cache-consistent and leftovers are restored to write-back on
>   free. Bag pages are never highmem so the kernel mapping is always
>   valid for set_memory_*().
> - Record the exact number of sub-optimal pages on the tt
>   (nr_suboptimal_pages) at populate time so a defrag pass can size its
>   prealloc precisely instead of guessing.
> - Once a defrag move exhausts the prealloc bag, harvest the remainder
>   of the old tt rather than entering reclaim under the lock, and flag
>   the tt sub-optimal so the driver re-queues it for a later pass.
>
>This keeps all reclaim/compaction stalls and cache mode changes out of
>the dma-resv critical section: lock-held time then tracks only the bytes
>actually copied.
>
>Cc: Carlos Santa <carlos.santa@intel.com>
>Cc: Ryan Neph <ryanneph@google.com>
>Cc: Christian Koenig <christian.koenig@amd.com>
>Cc: Huang Rui <ray.huang@amd.com>
>Cc: Matthew Auld <matthew.auld@intel.com>
>Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>Cc: Maxime Ripard <mripard@kernel.org>
>Cc: Thomas Zimmermann <tzimmermann@suse.de>
>Cc: David Airlie <airlied@gmail.com>
>Cc: Simona Vetter <simona@ffwll.ch>
>Cc: dri-devel@lists.freedesktop.org
>Cc: linux-kernel@vger.kernel.org
>Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>Assisted-by: GitHub_Copilot:claude-opus-4.8
>Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>---
> drivers/gpu/drm/ttm/ttm_pool.c | 244 +++++++++++++++++++++++++++++++--
> include/drm/ttm/ttm_bo.h       |  11 ++
> include/drm/ttm/ttm_pool.h     |  29 ++++
> include/drm/ttm/ttm_tt.h       |  17 +++
> 4 files changed, 287 insertions(+), 14 deletions(-)
>
>diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
>index 1673e81b8df8..da7d132c8297 100644
>--- a/drivers/gpu/drm/ttm/ttm_pool.c
>+++ b/drivers/gpu/drm/ttm/ttm_pool.c
>@@ -82,6 +82,9 @@ struct ttm_pool_dma {
>  * Pages harvested (borrowed) from the old tt are free and do not count; once
>  * this drops to zero the allocator stops upgrading and harvests the remainder.
>  * On completion it holds the unused budget. 0 means unlimited (no defrag cap).
>+ * @nr_suboptimal_pages: Number of pages backed below the pool's beneficial
>+ * order. Recorded by the pool allocator after populate; a defrag pass reads it
>+ * to size its out-of-lock preallocation exactly.
>  */
> struct ttm_pool_alloc_state {
> 	struct page **pages;
>@@ -90,6 +93,7 @@ struct ttm_pool_alloc_state {
> 	pgoff_t remaining_pages;
> 	enum ttm_caching tt_caching;
> 	s64 defrag_bytes_remaining;
>+	u32 nr_suboptimal_pages;
> };
>
> /**
>@@ -787,6 +791,7 @@ static void ttm_pool_alloc_state_init(const struct ttm_tt *tt,
> 	alloc->remaining_pages = tt->num_pages;
> 	alloc->tt_caching = tt->caching;
> 	alloc->defrag_bytes_remaining = 0;
>+	alloc->nr_suboptimal_pages = 0;
> }
>
> /*
>@@ -852,7 +857,8 @@ static unsigned int ttm_pool_defrag_old_order(struct ttm_pool *pool,
>  * pages stay owned by the old tt until the move commits.
>  */
> static int ttm_pool_harvest_page(struct ttm_tt *old_tt, unsigned int order,
>-				 pgoff_t off, struct ttm_pool_alloc_state *alloc)
>+				 unsigned int beneficial_order, pgoff_t off,
>+				 struct ttm_pool_alloc_state *alloc)
> {
> 	pgoff_t nr = 1UL << order;
> 	int r;
>@@ -887,6 +893,9 @@ static int ttm_pool_harvest_page(struct ttm_tt *old_tt, unsigned int order,
>
> 	alloc->caching_divide = alloc->pages;
>
>+	if (order < beneficial_order)
>+		alloc->nr_suboptimal_pages += 0x1 << order;
>+
> 	return 0;
> }
>
>@@ -934,7 +943,8 @@ static int ttm_pool_harvest_remaining(struct ttm_pool *pool,
> 		    round_down(off, bnr) + bnr <= num_pages)
> 			*suboptimal = true;
>
>-		r = ttm_pool_harvest_page(old_tt, order, off, alloc);
>+		r = ttm_pool_harvest_page(old_tt, order, beneficial, off,
>+					  alloc);
> 		if (r)
> 			return r;
>
>@@ -944,6 +954,173 @@ static int ttm_pool_harvest_remaining(struct ttm_pool *pool,
> 	return 0;
> }
>
>+unsigned int ttm_pool_prealloc_order(struct ttm_pool *pool)
>+{
>+	return ttm_pool_beneficial_order(pool);
>+}
>+EXPORT_SYMBOL(ttm_pool_prealloc_order);
>+
>+/*
>+ * Build the gfp flags used for the high-order, possibly reclaiming, beneficial
>+ * order page allocations, matching the in-line defrag alloc path.
>+ */
>+static gfp_t ttm_pool_prealloc_gfp(struct ttm_pool *pool)
>+{
>+	gfp_t gfp = GFP_USER;
>+
>+	/*
>+	 * No highmem: prealloc applies caching in bulk via set_pages_array_*()
>+	 * on the kernel mapping, so the pages must be permanently mapped.
>+	 */
>+	if (ttm_pool_uses_dma32(pool))
>+		gfp |= GFP_DMA32;
>+
>+	return gfp;
>+}
>+
>+/*
>+ * Apply a tt's cpu-caching to a batch of freshly system-allocated (write-back)
>+ * prealloc pages in one shot. @cpages is an unpacked array of @ncpages
>+ * individual 4K pages (the constituent pages of the mixed-order chunks, expanded
>+ * so set_pages_array_*() sees one entry per page), since the packed prealloc bag
>+ * holds multi-order chunks. Prealloc pages are never highmem (see
>+ * ttm_pool_prealloc_gfp), so their kernel mapping is valid. No-op for cached
>+ * pages and on non-x86. Returns non-zero if the caching change failed (the
>+ * caller drops the whole bag and falls back to in-line allocation).
>+ */
>+static int ttm_pool_prealloc_apply_caching(enum ttm_caching caching,
>+					   struct page **cpages,
>+					   unsigned int ncpages)
>+{
>+#ifdef CONFIG_X86
>+	if (!ncpages)
>+		return 0;
>+
>+	switch (caching) {
>+	case ttm_cached:
>+		break;
>+	case ttm_write_combined:
>+		return set_pages_array_wc(cpages, ncpages);
>+	case ttm_uncached:
>+		return set_pages_array_uc(cpages, ncpages);
>+	}
>+#endif
>+	return 0;
>+}
>+
>+/* Expand an @order chunk into its constituent 4K pages for bulk caching. */
>+static void ttm_pool_prealloc_stage_caching(struct page **cpages,
>+					    unsigned int *ncpages,
>+					    struct page *p, unsigned int order)
>+{
>+	unsigned int i, nr = 1u << order;
>+
>+	for (i = 0; i < nr; i++)
>+		cpages[(*ncpages)++] = p + i;
>+}
>+
>+/**
>+ * ttm_pool_prealloc_fill() - Preallocate beneficial-order pages outside any lock
>+ * @pool: The pool to allocate from.
>+ * @tt_caching: The requested cpu-caching for the pages allocated.
>+ * @pp: Prealloc bag to fill; @pp->order is set to the beneficial order.
>+ * @count: Number of beneficial-order chunks to attempt.
>+ *
>+ * Allocate up to @count beneficial-order chunks, parking them in @pp for a
>+ * later __ttm_pool_alloc() defrag move to consume under the dma-resv lock. May
>+ * sleep/reclaim freely as it runs unlocked. A short fill is fine: the pool
>+ * falls back to in-line allocation for the shortfall. DMA-alloc pools are not
>+ * supported (count stays 0). Returns 0 (release with ttm_pool_prealloc_fini()).
>+ */
>+int ttm_pool_prealloc_fill(struct ttm_pool *pool, enum ttm_caching tt_caching,
>+			   struct ttm_pool_prealloc *pp, unsigned int count)
>+{
>+	unsigned int order = ttm_pool_beneficial_order(pool);
>+	gfp_t gfp = ttm_pool_prealloc_gfp(pool);
>+	struct page **cpages = NULL;
>+	unsigned int ncpages = 0;
>+	int r;
>+
>+	pp->pages = NULL;
>+	pp->order = order;
>+	pp->caching = tt_caching;
>+	pp->count = 0;
>+	pp->used = 0;
>+
>+	/* Nothing to gain without a beneficial order or for DMA-alloc pools. */
>+	if (!order || !count || ttm_pool_uses_dma_alloc(pool))
>+		return 0;
>+
>+	pp->pages = kvzalloc_objs(*pp->pages, count);
>+	if (!pp->pages)
>+		return 0;
>+
>+	/*
>+	 * Every chunk is a fresh write-back system page of @order that needs a
>+	 * caching change; collect their constituent pages into an unpacked
>+	 * scratch array and issue a single set_pages_array_*() after the fill.
>+	 * Cached tts need no change (and non-x86 handles caching at map time).
>+	 */
>+	if (IS_ENABLED(CONFIG_X86) && tt_caching != ttm_cached) {
>+		cpages = kvzalloc_objs(*cpages, (size_t)count << order);

Assisted-by: LLM

NIT..cpages is tansient memory. Though it is bounded here by 'budget',
may be it can be avoided altogether by using a one static 4k page in the
pool and flush it with set_pages_array*() as and when it fill up?

>+		if (!cpages) {
>+			kvfree(pp->pages);
>+			pp->pages = NULL;
>+			return 0;
>+		}
>+	}
>+
>+	while (pp->count < count) {
>+		struct page *p = ttm_pool_alloc_page(pool, gfp, order, false);
>+
>+		if (!p)
>+			break;
>+
>+		pp->pages[pp->count++] = p;
>+		if (cpages)
>+			ttm_pool_prealloc_stage_caching(cpages, &ncpages, p,
>+							order);
>+	}
>+
>+	/*
>+	 * Apply the requested caching to every collected page in one shot. On
>+	 * failure the pages' caching is indeterminate, so drop the whole bag
>+	 * (freeing restores write-back) and let the consumer allocate in-line.
>+	 */
>+	r = ttm_pool_prealloc_apply_caching(tt_caching, cpages, ncpages);
>+	kvfree(cpages);
>+	if (r) {
>+		unsigned int i;
>+
>+		for (i = 0; i < pp->count; i++)
>+			ttm_pool_free_page(pool, tt_caching, order,
>+					   pp->pages[i], false);
>+		pp->count = 0;
>+	}
>+
>+	return 0;
>+}
>+EXPORT_SYMBOL(ttm_pool_prealloc_fill);
>+
>+/**
>+ * ttm_pool_prealloc_fini() - Release unconsumed preallocated pages
>+ * @pool: The pool the pages came from.
>+ * @pp: Prealloc bag to drain. Consumed pages (< @used) are now owned by the tt.
>+ */
>+void ttm_pool_prealloc_fini(struct ttm_pool *pool, struct ttm_pool_prealloc *pp)
>+{
>+	unsigned int i;
>+
>+	for (i = pp->used; i < pp->count; ++i)
>+		ttm_pool_free_page(pool, pp->caching, pp->order, pp->pages[i],
>+				   false);
>+	kvfree(pp->pages);
>+	pp->pages = NULL;
>+	pp->count = 0;
>+	pp->used = 0;
>+}
>+EXPORT_SYMBOL(ttm_pool_prealloc_fini);
>+
> /**
>  * enum ttm_pool_iter_action - Outcome of a per-order allocation phase
>  * @TTM_POOL_ITER_FILL: A page (@it->p) was acquired; proceed to fill it in.
>@@ -975,6 +1152,7 @@ struct ttm_pool_alloc_iter {
> 	struct ttm_pool_alloc_state *alloc;
> 	struct ttm_pool_tt_restore *restore;
> 	struct ttm_tt *defrag_old_tt;
>+	struct ttm_pool_prealloc *prealloc;
> 	unsigned int beneficial_order;
> 	gfp_t gfp_flags;
> 	bool defrag_capped;
>@@ -990,16 +1168,20 @@ struct ttm_pool_alloc_iter {
> };
>
> /*
>- * Defrag move budget exhausted: the upgrade can make no further progress this
>- * pass. Snapshot @defrag_capped is set only when a byte budget was in force at
>- * entry.
>+ * Defrag move budget exhausted, or the out-of-lock prealloc bag ran dry: the
>+ * upgrade can make no further progress this pass. Snapshot @defrag_capped is
>+ * set only when a byte budget was in force at entry.
>  */
> static bool ttm_pool_iter_defrag_exhausted(const struct ttm_pool_alloc_iter *it)
> {
>+	const struct ttm_pool_prealloc *pp = it->prealloc;
>+
> 	if (!it->defrag_old_tt)
> 		return false;
>+	if (it->defrag_capped && it->alloc->defrag_bytes_remaining <= 0)
>+		return true;
>
>-	return it->defrag_capped && it->alloc->defrag_bytes_remaining <= 0;
>+	return pp && pp->count && pp->used >= pp->count;
> }
>
> /*
>@@ -1056,7 +1238,8 @@ static int ttm_pool_iter_reuse_old(struct ttm_pool_alloc_iter *it)
> 		return TTM_POOL_ITER_FILL;
>
> 	it->order = harvest_order;
>-	r = ttm_pool_harvest_page(it->defrag_old_tt, it->order, off, it->alloc);
>+	r = ttm_pool_harvest_page(it->defrag_old_tt, it->order,
>+				  it->beneficial_order, off, it->alloc);
> 	if (r)
> 		return r;
>
>@@ -1068,11 +1251,13 @@ static int ttm_pool_iter_reuse_old(struct ttm_pool_alloc_iter *it)
>
> /*
>  * Acquire a single page for the current order, leaving it in @it->p (NULL on
>- * failure). Tries a same-order pool page, then a fresh system allocation. Fault
>- * injection can force the beneficial-order paths to "fail".
>+ * failure). Tries, in order: a beneficial-order page preallocated outside the
>+ * dma-resv lock (defrag), a same-order pool page, then a fresh system
>+ * allocation. Fault injection can force the beneficial-order paths to "fail".
>  */
> static void ttm_pool_iter_acquire_page(struct ttm_pool_alloc_iter *it)
> {
>+	struct ttm_pool_prealloc *pp = it->prealloc;
> 	struct ttm_pool_type *pt;
>
> 	it->p = NULL;
>@@ -1087,7 +1272,18 @@ static void ttm_pool_iter_acquire_page(struct ttm_pool_alloc_iter *it)
> 		it->beneficial_order && it->order >= it->beneficial_order &&
> 		should_fail(&beneficial_order_fault_inject, 1);
>
>-	/* First, try to allocate a page from a pool if one exists. */
>+	/*
>+	 * Defrag move: consume a beneficial-order page preallocated outside the
>+	 * dma-resv lock instead of allocating one in-line (which may stall in
>+	 * reclaim/compaction). Falls through once the bag is empty.
>+	 */
>+	if (pp && !it->fail_beneficial && it->order >= it->beneficial_order &&
>+	    pp->used < pp->count) {
>+		it->order = it->beneficial_order;
>+		it->p = pp->pages[pp->used++];
>+		it->page_caching = it->tt->caching;
>+	}
>+
> 	pt = ttm_pool_select_type(it->pool, it->page_caching, it->order);
> 	if (!it->p && pt && it->allow_pools && !it->fail_beneficial)
> 		it->p = ttm_pool_type_take(pt, ttm_pool_nid(it->pool));
>@@ -1164,6 +1360,7 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> 		.alloc = alloc,
> 		.restore = restore,
> 		.defrag_old_tt = restore ? NULL : ctx->defrag_old_tt,
>+		.prealloc = restore ? NULL : ctx->prealloc,
> 		.beneficial_order = ttm_pool_beneficial_order(pool),
> 		.page_caching = tt->caching,
> 		.allow_pools = true,
>@@ -1193,8 +1390,8 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> 	     alloc->remaining_pages;
> 	     it.order = ttm_pool_alloc_find_order(it.order, alloc)) {
> 		/*
>-		 * Out of defrag budget: harvest the rest of the old tt as-is and
>-		 * stop (the tt is re-queued if the remainder is still
>+		 * Out of defrag budget/prealloc: harvest the rest of the old tt
>+		 * as-is and stop (the tt is re-queued if the remainder is still
> 		 * sub-optimal).
> 		 */
> 		if (ttm_pool_iter_defrag_exhausted(&it)) {
>@@ -1211,7 +1408,7 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> 		if (r == TTM_POOL_ITER_RETRY)
> 			continue;
>
>-		/* Acquire a page (pool / system) for this order. */
>+		/* Acquire a page (prealloc / pool / system) for this order. */
> 		ttm_pool_iter_acquire_page(&it);
> 		if (!it.p) {
> 			r = ttm_pool_iter_lower_order(&it);
>@@ -1243,6 +1440,8 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> 			alloc->defrag_bytes_remaining -=
> 				(s64)(1UL << it.order) << PAGE_SHIFT;
>
>+		if (it.order < it.beneficial_order)
>+			alloc->nr_suboptimal_pages += 0x1 << it.order;

NIT..This counts any tail bytes also as suboptimal. Should be fine as it only leads
to extra prealloc, but just noticing that TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED
is not flagged for tail bytes.

> 		it.alloc_count++;
> 	}
>
>@@ -1306,6 +1505,9 @@ int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> 	/* Report the unused defrag budget back to the caller. */
> 	ctx->defrag_bytes_remaining = alloc.defrag_bytes_remaining;
>
>+	if (!ret)
>+		tt->nr_suboptimal_pages = alloc.nr_suboptimal_pages;
>+
> 	return ret;
> }
> EXPORT_SYMBOL(ttm_pool_alloc);
>@@ -1358,6 +1560,15 @@ int ttm_pool_restore_and_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
>
> 			if (ret)
> 				return ret;
>+
>+			/*
>+			 * __ttm_pool_alloc() counts each freshly (re)allocated
>+			 * chunk against nr_suboptimal_pages, but a chunk whose
>+			 * backup copy was interrupted and is finished here
>+			 * resumes past that loop, so account for it directly.
>+			 */
>+			if (restore->order < ttm_pool_beneficial_order(pool))
>+				alloc.nr_suboptimal_pages += 1U << restore->order;

NIT...'1U << order' vs '0x1 << order' in other places. Should be fine, probably
good to be consistent.

> 		}
> 		if (!alloc.remaining_pages) {
> 			ret = ttm_pool_apply_caching(&alloc);
>@@ -1367,11 +1578,16 @@ int ttm_pool_restore_and_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> 			kfree(tt->restore);
> 			tt->restore = NULL;
>
>+			tt->nr_suboptimal_pages = alloc.nr_suboptimal_pages;
> 			return 0;
> 		}
> 	}
>
>-	return __ttm_pool_alloc(pool, tt, ctx, &alloc, restore);
>+	ret = __ttm_pool_alloc(pool, tt, ctx, &alloc, restore);
>+	if (!ret)
>+		tt->nr_suboptimal_pages = alloc.nr_suboptimal_pages;
>+
>+	return ret;
> }
>
> /**
>diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
>index 6124d2627b47..a80304f179ba 100644
>--- a/include/drm/ttm/ttm_bo.h
>+++ b/include/drm/ttm/ttm_bo.h
>@@ -237,6 +237,17 @@ struct ttm_operation_ctx {
> 	 * @defrag_old_tt is set.
> 	 */
> 	s64 defrag_bytes_remaining;
>+	/**
>+	 * @prealloc: Pages preallocated outside the dma-resv lock for a defrag
>+	 * move. The pool allocator consumes these instead of allocating fresh
>+	 * beneficial-order pages under the lock, moving the (potentially
>+	 * reclaim/compaction stalling) high-order allocations out of the
>+	 * critical section. NULL means allocate in-line as usual. The pool
>+	 * silently falls back to in-line allocation for any shortfall. The
>+	 * allocator consumes it for beneficial-order chunks of any populate;
>+	 * drivers only set it for a defrag move.
>+	 */
>+	struct ttm_pool_prealloc *prealloc;
> 	/**
> 	 * @resv: Reservation object to be used together with
> 	 * @allow_res_evict.
>diff --git a/include/drm/ttm/ttm_pool.h b/include/drm/ttm/ttm_pool.h
>index 753203980e2c..71670350eb15 100644
>--- a/include/drm/ttm/ttm_pool.h
>+++ b/include/drm/ttm/ttm_pool.h
>@@ -81,6 +81,35 @@ int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> 		   struct ttm_operation_ctx *ctx);
> void ttm_pool_free(struct ttm_pool *pool, struct ttm_tt *tt);
>
>+/**
>+ * struct ttm_pool_prealloc - Pages preallocated outside the dma-resv lock
>+ * @pages: Array of @count beneficial-order pages (or fewer if a fill fell
>+ *         short); each entry is the head page of a 1 << @order chunk.
>+ * @order: Page order of every preallocated chunk.
>+ * @caching: CPU caching applied to the pages, so leftovers can be restored
>+ *           to write-back before being freed.
>+ * @count: Number of valid entries in @pages.
>+ * @used: Number of entries already consumed by the pool allocator.
>+ *
>+ * Defrag pages are interchangeable, so only a count of beneficial-order chunks
>+ * is needed. ttm_pool_prealloc_fill() populates this outside the lock and
>+ * __ttm_pool_alloc() drains it; any unused tail is released by
>+ * ttm_pool_prealloc_fini().
>+ */
>+struct ttm_pool_prealloc {
>+	struct page **pages;
>+	unsigned int order;
>+	enum ttm_caching caching;
>+	unsigned int count;
>+	unsigned int used;
>+};
>+
>+int ttm_pool_prealloc_fill(struct ttm_pool *pool, enum ttm_caching tt_caching,
>+			   struct ttm_pool_prealloc *pp, unsigned int count);
>+void ttm_pool_prealloc_fini(struct ttm_pool *pool,
>+			    struct ttm_pool_prealloc *pp);
>+unsigned int ttm_pool_prealloc_order(struct ttm_pool *pool);
>+
> void ttm_pool_init(struct ttm_pool *pool, struct device *dev,
> 		   int nid, unsigned int alloc_flags);
> void ttm_pool_fini(struct ttm_pool *pool);
>diff --git a/include/drm/ttm/ttm_tt.h b/include/drm/ttm/ttm_tt.h
>index 55c35bcf134d..81a5446ca693 100644
>--- a/include/drm/ttm/ttm_tt.h
>+++ b/include/drm/ttm/ttm_tt.h
>@@ -135,6 +135,12 @@ struct ttm_tt {
> 	enum ttm_caching caching;
> 	/** @restore: Partial restoration from backup state. TTM private */
> 	struct ttm_pool_tt_restore *restore;
>+	/**
>+	 * @nr_suboptimal_pages: Number of pages backed below the pool's
>+	 * beneficial order. Recorded by the pool allocator after populate; a
>+	 * defrag pass reads it to size its out-of-lock preallocation exactly.
>+	 */

NIT...may be not 'exactly' as patch 23 rounds it up.

Niranjana

>+	u32 nr_suboptimal_pages;
> };
>
> /**
>@@ -201,6 +207,17 @@ static inline bool ttm_tt_is_beneficial_order_failed(const struct ttm_tt *tt)
> 	return tt->page_flags & TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
> }
>
>+/**
>+ * ttm_tt_suboptimal_pages() - Pages backed below the pool's beneficial order
>+ * @tt: The struct ttm_tt.
>+ *
>+ * Return: Number of pages a defrag move would (re)allocate at beneficial order.
>+ */
>+static inline u32 ttm_tt_suboptimal_pages(const struct ttm_tt *tt)
>+{
>+	return tt->nr_suboptimal_pages;
>+}
>+
> /**
>  * ttm_tt_create
>  *
>-- 
>2.34.1
>
