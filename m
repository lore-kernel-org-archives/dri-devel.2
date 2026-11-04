Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DB7606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 01:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lMEXMpwz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4F2610F935;
	Wed,  4 Nov 2026 01:46:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E84A610F935;
 Wed,  4 Nov 2026 01:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793756777; x=1825292777;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=SKnnlRHKN3v1CoaV4DC1MogaoC2yub1+QY5qptXkjQE=;
 b=lMEXMpwzwESBFiq+02qRd9IPpfzjTTJDFHFb2itDd7VXHiJ/nnRns2qH
 HC9SemIDPEVemMZzEw8UYHRYln5JlX7wrF/FqrRTUGcxrZT6O7ggqqA5u
 MUZNTnIAULhAOc7W+04IF5Yxw7wSVumN6/CgxIlnq35LrmWBtwwrgAQ5o
 etVOp+iUncub+6QZBXce6o6Ui8g3CPCjRLebSKF+REPnzVtE3lT90gMr5
 RdJBPtYS3GXxLwTR3H5KNDiTXrrHmPhTMW7d1BTjpwxjQPYb0xHIEASr1
 gt8fb3LSrNMjYHhuD9mRYpcKgnuPhqFqOnUDbyP3LFCIKgy2DnLeNH/zg g==;
X-CSE-ConnectionGUID: xt+lxajNSDuOCTfCOgBrYA==
X-CSE-MsgGUID: Cv5R3XhjQqKFW7aghUvb2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2508772"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2508772"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 17:46:16 -0800
X-CSE-ConnectionGUID: PqEyo/dpSnSVdfqtv+Gftg==
X-CSE-MsgGUID: DSFPMznnS+CWW7nXwttuaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="6593384"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 17:46:17 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 17:46:16 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 17:46:16 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.54)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 17:46:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQh/cj/drilhKJZ/iTYjpiJxxjTMM5RwZmOfcNNaf+ntA0NjgSBN4D3nlH3k2kAwFouhxTX9D7nnVzX4a0zlLRJ9bru1ieFRjgYvYRS34DizxnKRtZaMMdXWbIyiIsSV+RiqzNIBWT7Yaoc61RTZ4oBfUu00UMQr5B/6ZS/Nb0DVbguDcLJ6R3/YPExt9XWOtK/R3Ghz3+wNK6ha7C4s3naEM+aptTa1K6yTy8ssO2mJt5QjeoogUnZtHydOsXk7aO/kHQOy3TUIdxkABb/t82Uk54oxH0cquRlKcyAbPajgAeohPCUSzebRZYm+Jsf7shzNcxdXGDn1OJuFmYO4nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0cfB9DaPASAsaYo2EequODzvFg5Zw+Lx6M0lRYoq64=;
 b=KhNBgvYPoIt1AoLanSOruBCFv71dm3Ud8XnhHUKIPw9DLsNLRrBB94MHtjw5lUUBQcCgC51VAqnCLQklFd28B4z9U7rDe+U+mfdXk/QnA/f210uQfp9AdFg4k7Ze2ipI7l6MOo0UPvy0qXNHckS095/0P8DlxV1zZK7vcq8PmYKHjKw9ml0LtrKoEOKsYeVbm8GSNPW+q7vCmi1MantBdukqmXKz4cC9G0ziik3EqjeY8icfK5vs7R7jWpp+53/0bCbkjD6uvKhnJm2/hXta6du1rVmgh34zMMlmK1wNN6FqGdqVVtXJOdMtyMhKuBz2/d1B/oUhkix/iBg9cu3oag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by DS4PPFDB7809488.namprd11.prod.outlook.com (2603:10b6:f:fc02::56)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 01:46:12 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 01:46:08 +0000
Date: Tue, 3 Nov 2026 17:46:05 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v3 14/33] drm/xe: Destroy page tables after unlinking all
 VMAs on VM close
Message-ID: <auqOXewLpkk9gEH1@gsse-cloud1.jf.intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-15-matthew.brost@intel.com>
 <auqN6iTlYUvPKKNJ@nvishwa1-desk>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <auqN6iTlYUvPKKNJ@nvishwa1-desk>
X-ClientProxiedBy: MW4PR03CA0062.namprd03.prod.outlook.com
 (2603:10b6:303:b6::7) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|DS4PPFDB7809488:EE_
X-MS-Office365-Filtering-Correlation-Id: c2901075-1368-4c76-46fd-08df3a156514
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|6133799003|10067099003|22082099003|261102123227099003|18002099003|56012099006|4143699003|11063799006|261026140227099003|261021121427099003|261022075727099003|261022105027099003|261009223027099003|261028144727099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: 8pXujBJ/5NDSbY2qOreCDFvJHrwpQFpv0Jy4m8qGPhbIkQvEgYKOocHLxqtoJRnRG8FJ5ST+wKJ/+nrmpVS29HSR86Y0jWpJNdHQIYAWdY72w69l9Q/pdMijxc6ZApVklMVgOC+cQEw/7DXQZU0vZKXl4abihcJKkgob/mYaxXmi/wo1a8YhH2XZOE1+38ondEpDPGz/h0KQ7AT7BPJ/PnvJxaAWFWVpceVCFnxA12Y2z9GRwDCFlqbIO+OV9Ckek/m2xYHRdGgVH+pkV3j65ldJbBzBuD4JIB4G1vw4b8Ln/uMBLc53neWgttO6Jzbzo3rPQ6O9ASFC2Kc3zYSmqcmhM1BjrQiw0QsK5bHQvOaF9O0WB8EYWN5bBaK7cvLpCM/NaAwzRwqrkfGu8nuG5HGLo0clsD27/ICE3rghg2GgjNyeidmObmFp6xvXGscH05fJ6HzgPo8OsNM9qUo4A2RnwAn8dxes53FRSQA1lpjzJyyOEX8wihF8Ol086D5QWjpnYqoxjXfcqnwOcdJyaw0XT7Gbual+FkyX6Y6+ksXSqRY/Rc8bp1XKbj6J4d03gGJXi0/RmgF3XBMTHvmW76vTIllRzr9MfJNUea57H4mEZ+hsR+ETQwYatjfU7uvCBV7asoakynd6ubjgmRT42jmvTfQih4yA9BMZ6n8oAT4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(10067099003)(22082099003)(261102123227099003)(18002099003)(56012099006)(4143699003)(11063799006)(261026140227099003)(261021121427099003)(261022075727099003)(261022105027099003)(261009223027099003)(261028144727099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j5t4+x2C35Rmy/lXmniUhtxXbamg5bWdgrVrGduGVx7CZQ1ex55/Ctl5R8eg?=
 =?us-ascii?Q?e/1r2rxQtJMAYNeLb2aqB795WB+ynnGdJTYQolRh5c5z6YkvuGamTb+6arhz?=
 =?us-ascii?Q?Ct5T8DaILogxGx+0jfRnlSgNCo/E1E3JtDu1sFwngJ+B2hEyADyKWAjqIvZI?=
 =?us-ascii?Q?ZeLs7mCOBeaa06SqmZNB2g0S02Sw+K35I7BrTu7ZTG/Tt33tHYaHgblYN5kY?=
 =?us-ascii?Q?UwDXiLoDqAriViC4TbkWXJDaRj7hLY6iyqjqB2pdkHQsVLFLZCmwv8H5vAvT?=
 =?us-ascii?Q?2QPxm/FOOW0xGAUen2gX/6rY1HI9np0TS2YAGfZdWYApO+Od38zWifj9CHeN?=
 =?us-ascii?Q?Upuk04BOqDDx0KJ0ENpeSVX7vMZGV6l+GRH2vu626g2qJqOyR5XY54iCB/i+?=
 =?us-ascii?Q?mJug1kvhPiiQr6RtpcUCtfAON0gAJ2EWElcLZMtn67Mwseb4TO7OPETrFRxi?=
 =?us-ascii?Q?o9DsQgRjBkADzleUQeuOcs4vXLm9eExuqyGoyZNCGJoehwdCVddoklKlT6DW?=
 =?us-ascii?Q?ZITC3qixKyz5V1JMxJAZ5R+tw9GkiKWCA8zl1Xsb/Zd8qxrAS9/e2c9PaeDm?=
 =?us-ascii?Q?L5vwF/JZoV2NBaD6XLfNipJQ/Pc5U6UOLhJ6ZM+jepj1yb5DYj/DkJzeZF0+?=
 =?us-ascii?Q?qJu0Fm4K2vO4FKQ7ZopQrLOL2RViwA74VzKBH2LORaZsadmg8uo3KnRTPI6F?=
 =?us-ascii?Q?2VAvdx7vVhn8HzQHeYAd/SASncnWZSGtVKRaU8UKj9h+vuI0piNccO4hxzq5?=
 =?us-ascii?Q?RrPJ1zpigLlRzpXRFcWZybAN0RJTI+b/KOO5YdsJpWjx115K/2NI0zplHqIN?=
 =?us-ascii?Q?p+jZA+PLIGKtNR4YKzCvl1/z5FendCPE3vvyyTQejM+bvjldvePZ2Fmxl46c?=
 =?us-ascii?Q?kNLBwTi+/Wp79PVcvhqq8gnYr8++Bn0kgdvbCfg4869t/JfZJ1tOZp/d/soS?=
 =?us-ascii?Q?AFc7R/E/ywKmFKi1eKLwTrusEjmwWkH/2CLsWhBWj8/QMKd0L+H2qjlP2YR2?=
 =?us-ascii?Q?GGjnVA53fhzUfgTV+krSxsjxUlogTWDUcm3sUudQjcB7zOo1Tv6q0BZ+9TQo?=
 =?us-ascii?Q?wA1enUUL28dv/WSxd27yuuG0Z9o8TT1B0tBpw7KFE9a3PfNiuz2PJ6/2t7kw?=
 =?us-ascii?Q?9w3JBejeFynLFtys1ED2iTwgo9Vg9UT+WLiN/O2aoELvR9YEITBJ/Rp/LmeL?=
 =?us-ascii?Q?uhFOB7eucRVSZ/5xTfkRFuNQIjHijd26gG126pWGj7Ff3ST7QoxgARxC0FNu?=
 =?us-ascii?Q?w0Yh848plPtpGcW/8iYMfI+PXwuzyPgpWUGwjHCIUiDG9VSAzS3Yb1eJbrBr?=
 =?us-ascii?Q?hrzUNNU9DrgEHgtM/pHMUTv+0zvQQzY/2ZJQX+E+bgWfIMwsdI7BhB4Mm7o7?=
 =?us-ascii?Q?0Za2rTyuquMGGNHU4HweGji4xKxPxxj3+1cxhLrB6li8NHa4YtbBhNHLFaO7?=
 =?us-ascii?Q?30qMt4WQqfs+QYB3A2oIUtZvNIaivXxweM5ZVXu7VCX8rzLxYlh8+LntNWae?=
 =?us-ascii?Q?ciM4S2M9gKC2DuP315l8cwCZlmsPe0NaUXmJwRuWaQcL1qySK8Ef8hm2Ven6?=
 =?us-ascii?Q?D81P/Nk7TG0QXupzZOUaVxTR1ucphUQnvtwCuzOYLtWIFg5TtDsbS2/Cfvy+?=
 =?us-ascii?Q?sMi26MkBqVug+6/Hovx0PO8KTc28CNtFLLQpDOZLE71KckQFDOODrex52HKk?=
 =?us-ascii?Q?Oo7k7C00/RtGaewAFsbBZVqgWFIY+N8/DIm0aG2TJp8B3C32SsVGQohhb70L?=
 =?us-ascii?Q?6Fy/yc8hBg=3D=3D?=
X-Exchange-RoutingPolicyChecked: NQnxYwBbR9kXE1hn0cM8vjFIFUawcSa2L1P9Q3hYbI70Qg27MXJl2Nxj+V1mFGzGf4lLjSeuXftty3pA9YY5fx+j9XJAQuWIGIHhN47Q/TVG8d+R4UgfNYul6cdL6xFpDGxpUDLfxuRPz7d8jPZ86SdYSGmZnhoztdAp9iRRlL5QZ4mwIzgAu/81EJEb9sUC5F1zNySFJFk1HHhsshPAgOU6GX3tENkqHq0UEF7UDgSVKHclqbCTVjsj00untrB2xPmcd4ECmofmahJUI/sx85LYw8H2YMEj9qPAKVjYLqyskZzgC3XN+4LBFuFDQEpmyM+Dfe7Aac97SZybYWS7mA==
X-MS-Exchange-CrossTenant-Network-Message-Id: c2901075-1368-4c76-46fd-08df3a156514
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 01:46:07.7586 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7RORmXZFGPupUCnIxnkp678Y6LjblpFROtjVBPt8q0pYpiUcyfAv8wGrkbGDlbiRhEyEhgAp8R8YRQzbd7cxdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFDB7809488
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 05:44:10PM -0800, Niranjana Vishwanathapura wrote:
> On Fri, Jul 10, 2026 at 07:56:00PM -0700, Matthew Brost wrote:
> > xe_vm_close_and_put() freed the VM's page-table roots via
> > xe_vm_pt_destroy() before destroying the "contested" VMAs - those backed
> > by external (shared) BOs, which are deferred to xe_vma_destroy_unlocked()
> > because unlinking them requires taking the external BO's dma-resv lock
> > (via drm_exec), not vm->lock.
> > 
> > Until such a VMA is unlinked it remains reachable from its BO through
> > drm_gem_for_each_gpuvm_bo(). A concurrent BO move that only holds the
> > BO's dma-resv lock - TTM eviction, the shrinker, or the defrag worker -
> > calls xe_bo_move_notify() -> xe_bo_trigger_rebind() ->
> > xe_vm_invalidate_vma() -> xe_pt_zap_ptes(), which dereferences
> > vm->pt_root[tile->id]. With the page tables already freed this is a
> > use-after-free / NULL dereference, e.g.:
> > 
> >  Oops: general protection fault [...] kernel NULL pointer dereference
> >  RIP: xe_pt_zap_ptes+0x7c [xe]
> >  Call Trace:
> >   xe_vm_invalidate_vma_submit+0x64/0x130 [xe]
> >   xe_vm_invalidate_vma+0x27/0x60 [xe]
> >   xe_bo_move_notify+0x1e7/0x3d0 [xe]
> >   xe_bo_move+0x62d/0x1620 [xe]
> >   ttm_bo_handle_move_mem+0x243/0x330 [ttm]
> >   ttm_bo_validate+0xb4/0x1a0 [ttm]
> > 
> > The race is not closable with a flag or a NULL pt_root check in the
> > invalidate path: the freeing side holds only vm->lock while the walker
> > holds only the BO's resv, so there is no common lock to serialise on.
> > 
> > Fix the ordering instead: destroy the page tables only after every VMA -
> > including the contested external-BO VMAs - has been unlinked. Once the
> > contested loop completes no BO can reach a VMA of this VM, so freeing the
> > page tables (under vm->lock, to satisfy xe_vm_assert_held()) is safe.
> > xe_vm_free_scratch() still runs before the free as it reads
> > pt_root[]->level.
> > 
> > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> > Assisted-by: GitHub_Copilot:claude-opus-4.8
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> 
> Looks like this change is already merged with below commit
> "drm/xe/vm: nuke PTs only after unlinking contested VMAs"
> 
> So, needs to be dropped in this series.
> 

Yes, Auld got to this one so it can be droppped.

Matt

> Niranjana
> 
> > ---
> > drivers/gpu/drm/xe/xe_vm.c | 24 ++++++++++++++++--------
> > 1 file changed, 16 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> > index 4557a8a4d270..9f55d22cb985 100644
> > --- a/drivers/gpu/drm/xe/xe_vm.c
> > +++ b/drivers/gpu/drm/xe/xe_vm.c
> > @@ -1934,15 +1934,7 @@ void xe_vm_close_and_put(struct xe_vm *vm)
> > 		vma->gpuva.flags |= XE_VMA_DESTROYED;
> > 	}
> > 
> > -	/*
> > -	 * All vm operations will add shared fences to resv.
> > -	 * The only exception is eviction for a shared object,
> > -	 * but even so, the unbind when evicted would still
> > -	 * install a fence to resv. Hence it's safe to
> > -	 * destroy the pagetables immediately.
> > -	 */
> > 	xe_vm_free_scratch(vm);
> > -	xe_vm_pt_destroy(vm);
> > 	xe_vm_unlock(vm);
> > 
> > 	/*
> > @@ -1956,6 +1948,22 @@ void xe_vm_close_and_put(struct xe_vm *vm)
> > 		xe_vma_destroy_unlocked(vma);
> > 	}
> > 
> > +	/*
> > +	 * Destroy the page tables only after every VMA has been unlinked. The
> > +	 * contested (external-BO) VMAs above are unlinked from their BO under
> > +	 * the BO's dma-resv lock, not vm->lock, so they can still be reached
> > +	 * via drm_gem_for_each_gpuvm_bo() by a concurrent BO move (eviction,
> > +	 * shrinker or the defrag worker) that only holds the BO's resv. Such a
> > +	 * move calls xe_vm_invalidate_vma() -> xe_pt_zap_ptes(), which
> > +	 * dereferences vm->pt_root[]; freeing the page tables while those VMAs
> > +	 * are still linked is a use-after-free. All vm operations add shared
> > +	 * fences to the resv (eviction of a shared object still installs an
> > +	 * unbind fence), so no GPU work outlives this point.
> > +	 */
> > +	xe_vm_lock(vm, false);
> > +	xe_vm_pt_destroy(vm);
> > +	xe_vm_unlock(vm);
> > +
> > 	xe_svm_fini(vm);
> > 
> > 	up_write(&vm->lock);
> > -- 
> > 2.34.1
> > 
