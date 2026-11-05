Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD37B606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 01:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kVh5PgxG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12D0A10E8ED;
	Thu,  5 Nov 2026 01:16:45 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ABC210E5D5;
 Thu,  5 Nov 2026 01:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793841398; x=1825377398;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=s1YYKn/t9R6/BX0jSxM9jcKXscWG/5OGopqfelfP+0Y=;
 b=kVh5PgxGACZ3jlGV/ZpvHucnwVozrkLQQ4JHKOLmTT0FV6m38ihozc+8
 IYjD3/LncOQd8woHpPWcF6kOzU2v4AAGWRfSLWzc7gWlgjkgBKmqHpDrE
 oGcpE30AmRpgWy2E+9hPfEbcDe0g2k9XUwKxI4ejzPQsQhlDMJt9KNfJv
 /GW5qHDAtCxcYP+5lEyPv7KNRQqcNKpjU5XnSRQLvdsfukUT0rgj4McD1
 9NOsgDE+YbJ9lZGswkCkjUpU8cKlTG/PMHZByyBmOnsKwwiJSbf/ihS84
 bEObJHmTujcAgDONMOUs2ylSj6Qkrl+DcS45SuhR7g6NRdJinSAEq5Mcj w==;
X-CSE-ConnectionGUID: 0TJZ3RBvQRKt5SqUa8/HZQ==
X-CSE-MsgGUID: RU/Bk5ttRhWKG7XDwEKmKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2648058"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2648058"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 17:16:38 -0800
X-CSE-ConnectionGUID: eq3dGiysSrG9AURzkbZLNA==
X-CSE-MsgGUID: lrlUUfUkQNetuJyKMVkjuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="8646180"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 17:16:37 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 17:16:37 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 17:16:37 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.35) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 17:16:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NRoI5dJaCVfeIzaRbmlITXdsnZAlDDKDZlcf5xW2RXLzYjSws1ij9cXjuaFk/1P8xGumQtEt1vssM0esmHqp11PC7/5RpxCFTDUUifFO4NSnQlQScS/WpuK9floR0UMXivkoxSkh82AD/WF3XxrR5UzwM/2v3BvCl1KJ98GLm6XnwuKWMG7kdMEzf64BsZhSBwQ6wMvcZj5PrGPf2V/qp7KJxxQonkZFEnawlmB09lDMIxJ0x3+TpuYMXMvllWK+rAxBi8iPtroCkdKX9bz7Gnfvsb1tiu2MQPTyEae8XQmTn2fqeC7XADrB2bw9Y2KHcItU7fWbUnDeLPy+puxQ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRT33vioIihO8BZnLdlV/8OhjTDi/szefz4ClOC7c6A=;
 b=nz9349ZOlk7hSsty6a5XtzkEueqeYKWJk/YNCDJApQCAnNuwP6tbcIKp2FkRfwjTWyFIjM0oi4Wa4oc7r5RXjQHTo9V0w+oEN4bp2D/AmyF0ZNJ2efBF6+9qm0ZY5m8rvMsVP+Z7Ig/XPBAUDiHzHNcaxq/88DDqZbQuivQAGl0Yrgv9xBAPy53agEJi51EkHlvZY4ZTnxFw2LGTOf6HqKt568Cg8Dh/A7+hnx03gMckf/ZOINlrwikGF68BMLYaRJh2gzPUqYo9auNFgSyVI3uSxByKfjnHCn5Ng1DQTu6p6jzZ5fH6pIjpwyP6OVeicYVk/ZuDJMAj7khrFcGGwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by LVTPR11MB9886.namprd11.prod.outlook.com (2603:10b6:408:3c3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 01:16:29 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0569.011; Thu, 5 Nov 2026
 01:16:29 +0000
Date: Wed, 4 Nov 2026 17:16:27 -0800
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 2/2] drm/xe: Add debugfs stats for DMA-mapped pages per
 order
Message-ID: <auvY60zG8V-Yq1Kx@nvishwa1-desk>
References: <20261104215228.1533692-1-matthew.brost@intel.com>
 <20261104215228.1533692-2-matthew.brost@intel.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261104215228.1533692-2-matthew.brost@intel.com>
X-ClientProxiedBy: SJ0PR05CA0090.namprd05.prod.outlook.com
 (2603:10b6:a03:332::35) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|LVTPR11MB9886:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f6e82ce-7304-41aa-6d50-08df3ada6b82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|260925022911599003|260925021911599003|260925021311599003|4143699003|11063799006|56012099006|261021123027099003|261021121427099003|261009221227099003|261009223027099003|261022075727099003|261026121527099003|261022105027099003|261026140227099003|261102123227099003|261028144727099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: qhYtvxy/VUJxWd7uf4n5fRe6Y/RywwWX7v9+feMzTmnhob+cVDibiINLraktDnQQlDiR8Q3lN6cFoawFsLzllXVpA82+mLgS1RSJLRTcoyfgvLQZz55fg1CvKX+Siv30nUBCsxHToG18BjHrlcYLAHALFIz++kE61vbqEHkU+ZEcM7YNoGLIXu9ViuMzz3vsQ6w5RKAXOyE8TIDjLf9h6WeBd9nhZQti10mVk+0ybwffsqGJ8udu3t5QJsv3j6P3SAsErChEXxo0k5hv4w9IqbNlJKcYJSQsPEN/QdCHitcHYoXxO4rdNBfY7xWcqA/yaHZFkNYw0U3uDVtTACBd13ZrLxedyDtYxpDotYSXzj6NiQ4fckBJgNi2XjXcymzyyoXY0EnYnlxmc20pD0fEsC1GImisYENkQEAqw8YUbqsFKJk5XJVwGusUFOTtsP3RBJFNt8ir9Gg0BITF2D6IaOneZoKsJC5vy35foMbTcfVtfFXRPOoKRGG3tqQad0eoDyme7cbErw5EmudD7X3TwEqZsWI8490LcMPufWTRrJnbxy3PKH7oB+NAHTcQXL/8jILuHeWCh9OvKcMCdj8XN8JJH1SWtvXFBUM+Y+qmSVybFSbdCqMi3Rbqxn7zQe4mZtHIYoAZJ8Fc4gRPJpW0cE5VT+AWNLwjAp5Dwr2uxWw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(260925022911599003)(260925021911599003)(260925021311599003)(4143699003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261009221227099003)(261009223027099003)(261022075727099003)(261026121527099003)(261022105027099003)(261026140227099003)(261102123227099003)(261028144727099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?RaHeEbygrxbtc8UH3ouSVM+2hyQ3Wk13wWYZhaj1utHKWDQpZEvE7TDsXW?=
 =?iso-8859-1?Q?zVMa+pF/SjZCVpyifwC4jrms4MZ9zxF7Oy7N5ZsxmuH7FVaaF7WJ1xjO+q?=
 =?iso-8859-1?Q?JfzAiprZ112Qtszv1Ms9Cn0PP1D5nwlfcU89FDd1HJ4PFiR0II9+DtK8t6?=
 =?iso-8859-1?Q?oMpOSWNQMTAC7K9qT5IZnvzk5wHXQqUIIUw5Uny/zFvW1anp+JLSig2SA7?=
 =?iso-8859-1?Q?JLtuOY84aNOsdroMxZxPcHEonmhzzwe5mnvG3oqlEmj6izem1ldnrauJlx?=
 =?iso-8859-1?Q?IksvEXqPkucstlDp23/XPQqqTyKm/SgB8QItnfPrsYDZaJtYFEJu3Ow2YT?=
 =?iso-8859-1?Q?htB9knz+i2HLdnGe8tn0Bdy0ClZqiSf+CJZJd4FybmEismA/ZQcoO4I2/2?=
 =?iso-8859-1?Q?C4SoDrjtPT0rL+odNMI9gvie6lp/CYdqQFfekm2hxwnaIohhk5SX1sS+kt?=
 =?iso-8859-1?Q?ZDLpOrzge6lnndx+y1uwquzESU/IEDnL5J+JGvpGSbNUNo0XIVbSV8X6N1?=
 =?iso-8859-1?Q?ljAJnLDQhw3AWfdAgi+L8+yMOQO7trLPY+Liv8vY4h+5lqxZTtfhgxWZnX?=
 =?iso-8859-1?Q?1LRy+GSShDzZ/ig8+OWlP9uJncw7cMHT3KdpU1Xk9nHze+n8w9xM3LUNuw?=
 =?iso-8859-1?Q?Wo5kvd0XHCBQlUmpbjcJcHroyHlU3ipnm4u+No66/a5vZa6e8Hpew3NC/S?=
 =?iso-8859-1?Q?pQ6EQwUkwBSAnc99V2B8VvWCn//oXswK9FvAGIl/Rt8GCP7gBdatiwaiuC?=
 =?iso-8859-1?Q?ZBbytL5e+q4VmzkFaBHt+zoSUw2P/9NJq6mgHQGbaGI3hJCQnbsL9BdWLn?=
 =?iso-8859-1?Q?7ZSnM4rlxyosgswcbVdmOwMPlmHY6Ln971hFeU69jKHwOIpfOrFAgPJBbB?=
 =?iso-8859-1?Q?MgfXk1cRaX94w40gYaGyT4O//ZXaOdCEtfQM4sGe0vRsJJCgX1qiOAJqFB?=
 =?iso-8859-1?Q?azuaP8G3dPqQ7mrqs5g1hnQkoSyiyyfircASj7pv9ig6ErnLwGpqfTPi+d?=
 =?iso-8859-1?Q?HMLNw8menEzHSlcLG6NYKaSjxkkoWppuBlLr4gp0V6NxuWR+QzwCyOqxNw?=
 =?iso-8859-1?Q?p/2OdtrfdoOpuVOrKbQLgACfFuYrcl5BFRAk/9IS1NXJd+P3dDb8IqtNoh?=
 =?iso-8859-1?Q?gOXWuy+2bFWhgx9RSpikKUWwK8WsPgf91awYqUD3c74aazWSO/JxQcTfxV?=
 =?iso-8859-1?Q?N26bhxiAFkCoxjD5f1DbUhgWf9cDqRbh9wIooMiixjbn7Nlt/BKgoaP65n?=
 =?iso-8859-1?Q?wy0T1/IFfHjjNtkcEXkiS34TxEBRNNx54mFz24fVKGTBKpyLrFM9v6DOc0?=
 =?iso-8859-1?Q?Z2DnR071ny8BjlXUgJxw56pR4GHZ988qnnG6GK1geM7fJ6fehxdgCUJMFj?=
 =?iso-8859-1?Q?E0EZKR2i/Q6rAPpvG9DO2fpvdI1YyrqJJ2psrML9QLZ0uGBGM31KvCS6h0?=
 =?iso-8859-1?Q?eKkann7zuCYaz7leq7c8TSx7CQ9UKibw2gXrlzUS2JqJgb7mq5C/Otlt5c?=
 =?iso-8859-1?Q?xMuE3BkA/zwj6KiJROOlVJ85rnbG0zqcyO2OoHoJuzh6WK/Ia7MDRtfrt7?=
 =?iso-8859-1?Q?a4ILKLlFA89UOvddOJO7djERWUiwpUILjJX12pfQZLyo4jM8mu3DavdWDj?=
 =?iso-8859-1?Q?R/GNZwNjxXSN38waCjmQUWS7BwUJ/thsmffPAhGt4vRP3UeJqzsRFrlsPV?=
 =?iso-8859-1?Q?Us8/b8mJZyKQ6r+deNoTgbz24ivdAOZhQqbkD0mTi1hkga7X4VKgWIrA26?=
 =?iso-8859-1?Q?/DHnWAv+eqUc/79Dh5m2cUAdY893OEDpecODSxoTx0JnEkG8xlbrUlMkrF?=
 =?iso-8859-1?Q?mLZnnDu5rx3UKvNYf5HFzExUQgrKTfGwwVHfCM4sKL1KDG5U+Fvb?=
X-Exchange-RoutingPolicyChecked: GrkfGtnbrNmOMf0lhyYqnlTiJl3Gge9KTrXawXXkmh/qYGgOiURCyPCmrMfhVhURblQMgJgDYVfiNxJnPbTjRfejMP8a5XExVU91VSthWxfalvxe5+cmrfG3dEp4nVzGI1sByhrg2n0/Vll8MCAV2IisQfjCsQfkmHx4qPAEl16VX0C9s1p6/imONK1O9LD/LflF26cAJGxJePFVNz17zRc6iaPucnXYJwo2VoaLxln2immtb4uIMWsrgwGOEVKGgHDbXDnGA4VAnv6zcnI7rDBkwPeKdvy+90JtaFL5oMgIa/wZo4mEWfUYcM4hdm6jMrBKyevEGZm1bMBj2+GFHg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6e82ce-7304-41aa-6d50-08df3ada6b82
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 01:16:29.2583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DI3xx6VgTA71cxGQDufKPksRZmPVTB2N2REzj1TJ8tiortvcVLUnk0Dl1QjTBvyEeC0Lz04neHVUf+P/M/X5hsuMLNOrKnjUUGc0PHAcvqtF6U0lNj6rmXNJoq0tXpw3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVTPR11MB9886
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

On Wed, Nov 04, 2026 at 01:52:28PM -0800, Matthew Brost wrote:
>From: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>
>Expose per-page-order DMA mapping counts for the system memory that the
>xe driver maps for GPU access, split into two categories: TTM buffer
>objects, and the GPU SVM / userptr ranges (which share a single
>drm_gpusvm instance per VM).
>
>The stats are visible at:
>
>  <debugfs>/dri/<N>/dma_mapped_pages
>
>and are broken out into two rows (bo, svm/userptr), one column per page
>order, mirroring the layout of the TTM pool page_pool stat.
>
>For TTM BOs the per-order counts are derived from the DMA scatter-gather
>table: each mapped segment is physically contiguous, so its page count is
>split into the largest power-of-two runs (a segment of N pages contributes
>a 2^k chunk for the largest k with 2^k <= N, repeated for the remainder).
>Driving the accounting off the sg table rather than the pages[] array keeps
>it correct even when pages[] entries are cleared while still DMA-mapped,
>as happens on the defrag page-borrowing path. Dma-buf BOs are not
>accounted for in dma_mapped_pages stats.
>
>For the SVM and userptr ranges the accounting is driven by the
>drm_gpusvm @dma_map_account callback, which fires once per dma_addr[]
>entry at the exact point the entry is DMA-mapped and unmapped. This
>makes the accounting symmetric by construction and avoids driver-side
>walks that could drift across migration, partial unmaps and the iova vs
>non-iova paths. Only DRM_INTERCONNECT_SYSTEM entries are real DMA maps
>and counted; device interconnect (VRAM, P2P) entries are skipped, so the
>counter reflects only system pages actually mapped through the DMA layer.
>
>The callback is shared between the full SVM instance (fault mode) and the
>core drm_gpusvm_pages-only instance used for userptr, so userptr
>mappings are accounted in both the CONFIG_DRM_XE_GPUSVM=y and =n (but
>CONFIG_DRM_GPUSVM=y) configurations, into the same svm/userptr counter.
>
>Since the counts are only ever consumed through debugfs, gate the counter
>storage and all accounting on CONFIG_DEBUG_FS so that builds without
>debugfs carry no extra atomic traffic or device state; the drm_gpusvm
>callback is simply left unregistered in that case.
>
>On device teardown assert that every counter has returned to zero, to
>catch any unbalanced accounting (a leaked DMA mapping) during testing.
>
>Assisted-by: LLM
>Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>---
> drivers/gpu/drm/xe/xe_bo.c           | 53 ++++++++++++++++++++---
> drivers/gpu/drm/xe/xe_debugfs.c      | 26 ++++++++++++
> drivers/gpu/drm/xe/xe_device.c       | 30 +++++++++++++
> drivers/gpu/drm/xe/xe_device_types.h | 17 ++++++++
> drivers/gpu/drm/xe/xe_svm.c          | 44 ++++++++++++++++++-
> drivers/gpu/drm/xe/xe_svm.h          |  4 +-
> drivers/gpu/drm/xe/xe_userptr.c      | 63 ++++++++++++++++++++++++++++
> drivers/gpu/drm/xe/xe_userptr.h      |  1 +
> 8 files changed, 230 insertions(+), 8 deletions(-)
>
>diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
>index 42a6aa1a2e4a..a8031cb9c74f 100644
>--- a/drivers/gpu/drm/xe/xe_bo.c
>+++ b/drivers/gpu/drm/xe/xe_bo.c
>@@ -396,6 +396,50 @@ struct xe_ttm_tt {
> 	bool purgeable;
> };
>
>+/*
>+ * xe_tt_account_dma_pages - account DMA-mapped tt pages per order
>+ * @xe: the xe device
>+ * @xe_tt: the xe_ttm_tt whose sg table to walk
>+ * @sign: +1 to add, -1 to subtract
>+ *
>+ * Walk the tt's DMA scatter-gather table and split each (physically
>+ * contiguous) segment into the largest power-of-two page runs: a segment of N
>+ * pages contributes a 2^k chunk for the largest k with 2^k <= N, repeated for
>+ * the remainder. Accumulate the count of 2^k pages into
>+ * xe->mem.dma_mapped_pages[k]. Driving this off the sg table rather than
>+ * tt->pages keeps the accounting correct even when pages[] entries are cleared
>+ * while still DMA-mapped (e.g. the defrag page-borrowing path).
>+ */
>+#if IS_ENABLED(CONFIG_DEBUG_FS)
>+static void xe_tt_account_dma_pages(struct xe_device *xe,
>+				    struct xe_ttm_tt *xe_tt, int sign)
>+{
>+	struct scatterlist *sg;
>+	unsigned int i;
>+
>+	for_each_sgtable_sg(xe_tt->sg, sg, i) {
>+		unsigned long nr_pages = sg->length >> PAGE_SHIFT;
>+
>+		while (nr_pages) {
>+			unsigned int order = min_t(unsigned int,
>+						   __fls(nr_pages),
>+						   MAX_PAGE_ORDER);
>+			unsigned long chunk = 1UL << order;
>+
>+			atomic_long_add((long)chunk * sign,
>+					&xe->mem.dma_mapped_pages[order]);
>+

Here both array index and array value is clamped.
But in the svm case below, only the array index is clamped, but not the value.
I guess here we don't expect huge pages? If so, should we be clamping here
or asserting if order is bigger than MAX_PAGE_ORDER?

>+			nr_pages -= chunk;
>+		}
>+	}
>+}
>+#else
>+static void xe_tt_account_dma_pages(struct xe_device *xe,
>+				    struct xe_ttm_tt *xe_tt, int sign)
>+{
>+}
>+#endif
>+
> static int xe_tt_map_sg(struct xe_device *xe, struct ttm_tt *tt)
> {
> 	struct xe_ttm_tt *xe_tt = container_of(tt, struct xe_ttm_tt, ttm);
>@@ -425,6 +469,7 @@ static int xe_tt_map_sg(struct xe_device *xe, struct ttm_tt *tt)
> 		return ret;
> 	}
>
>+	xe_tt_account_dma_pages(xe, xe_tt, 1);
> 	return 0;
> }
>
>@@ -433,6 +478,7 @@ static void xe_tt_unmap_sg(struct xe_device *xe, struct ttm_tt *tt)
> 	struct xe_ttm_tt *xe_tt = container_of(tt, struct xe_ttm_tt, ttm);
>
> 	if (xe_tt->sg) {
>+		xe_tt_account_dma_pages(xe, xe_tt, -1);
> 		dma_unmap_sgtable(xe->drm.dev, xe_tt->sg,
> 				  DMA_BIDIRECTIONAL, 0);
> 		sg_free_table(xe_tt->sg);
>@@ -1800,11 +1846,8 @@ int xe_bo_dma_unmap_pinned(struct xe_bo *bo)
> 			ttm_bo->sg = NULL;
> 			xe_tt->sg = NULL;
> 		} else if (xe_tt->sg) {
>-			dma_unmap_sgtable(ttm_to_xe_device(ttm_bo->bdev)->drm.dev,
>-					  xe_tt->sg,
>-					  DMA_BIDIRECTIONAL, 0);
>-			sg_free_table(xe_tt->sg);
>-			xe_tt->sg = NULL;
>+			xe_tt_unmap_sg(ttm_to_xe_device(ttm_bo->bdev),
>+				       &xe_tt->ttm);
> 		}
> 	}
>
>diff --git a/drivers/gpu/drm/xe/xe_debugfs.c b/drivers/gpu/drm/xe/xe_debugfs.c
>index e59d4964d811..1a306b6523e7 100644
>--- a/drivers/gpu/drm/xe/xe_debugfs.c
>+++ b/drivers/gpu/drm/xe/xe_debugfs.c
>@@ -7,6 +7,7 @@
>
> #include <linux/bits.h>
> #include <linux/debugfs.h>
>+#include <linux/mmzone.h>
> #include <linux/fault-inject.h>
> #include <linux/string_helpers.h>
>
>@@ -345,6 +346,28 @@ static int dgfx_pcie_link_residencies_show(struct seq_file *m, void *data)
> 	return 0;
> }
>
>+static int dma_mapped_pages_show(struct seq_file *m, void *data)
>+{
>+	struct xe_device *xe = m->private;
>+	unsigned int i;
>+
>+	seq_printf(m, "%-11s ", "");
>+	for (i = 0; i < NR_PAGE_ORDERS; i++)
>+		seq_printf(m, " ---%2u---", i);
>+	seq_printf(m, "\n%-11s:", "bo");
>+	for (i = 0; i < NR_PAGE_ORDERS; i++)
>+		seq_printf(m, " %8lu",
>+			   atomic_long_read(&xe->mem.dma_mapped_pages[i]));
>+	seq_printf(m, "\n%-11s:", "svm/userptr");
>+	for (i = 0; i < NR_PAGE_ORDERS; i++)
>+		seq_printf(m, " %8lu",
>+			   atomic_long_read(&xe->mem.dma_mapped_pages_svm[i]));

The array values are signed long, but printed as unsigned.
Should we use '%8l' instead of '%8lu'?

Also, under each order column, we are not printing the number of pages
of that order, but instead the 4kb page count mapped in that order.
Is that intended?
As we are counting huge pages in the highest order bucket, counting the
4kb page count seems necessary here. But perhaps needs to be documented.

Niranjana

>+	seq_puts(m, "\n");
>+
>+	return 0;
>+}
>+DEFINE_SHOW_ATTRIBUTE(dma_mapped_pages);
>+
> static const struct drm_info_list debugfs_list[] = {
> 	{"info", info, 0},
> 	{ .name = "sriov_info", .show = sriov_info, },
>@@ -765,6 +788,9 @@ void xe_debugfs_register(struct xe_device *xe)
>
> 	xe_ttm_vram_debugfs_init(xe, root);
>
>+	debugfs_create_file("dma_mapped_pages", 0444, root, xe,
>+			    &dma_mapped_pages_fops);
>+
> 	for_each_tile(tile, xe, tile_id)
> 		xe_tile_debugfs_register(tile);
>
>diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
>index 273e2c45fea9..c40bb8f7c697 100644
>--- a/drivers/gpu/drm/xe/xe_device.c
>+++ b/drivers/gpu/drm/xe/xe_device.c
>@@ -377,12 +377,42 @@ bool xe_device_is_admin_only(const struct xe_device *xe)
> /* Number of allocated struct xe_device */
> static atomic_t xe_device_count;
>
>+#if IS_ENABLED(CONFIG_DEBUG_FS)
>+static void xe_device_assert_dma_pages_zero(struct xe_device *xe)
>+{
>+	unsigned int i;
>+
>+	/*
>+	 * All BOs, userptr VMAs and SVM ranges must have been torn down by the
>+	 * time the device is destroyed, so every DMA-mapped-pages counter must
>+	 * have returned to zero. A non-zero value indicates unbalanced
>+	 * accounting, i.e. a missing unmap-side decrement.
>+	 */
>+	for (i = 0; i < NR_PAGE_ORDERS; i++) {
>+		xe_assert(xe, !atomic_long_read(&xe->mem.dma_mapped_pages[i]));
>+		xe_assert(xe, !atomic_long_read(&xe->mem.dma_mapped_pages_svm[i]));
>+	}

xe_assert() is only valid with CONFIG_DRM_XE_DEBUG.
So, it is kind of tied to CONFIG_DRM_XE_DEBUG. So, it goes back to original
comment as to if we should make it xe debug specific and only make the
debugfs interface part CONFIG_DEBUG_FS specific?
I am fine either way.

>+}
>+#else
>+static void xe_device_assert_dma_pages_zero(struct xe_device *xe)
>+{
>+}
>+#endif
>+
> static void xe_device_destroy(struct drm_device *dev, void *dummy)
> {
> 	struct xe_device *xe = to_xe_device(dev);
>
> 	xe_bo_dev_fini(&xe->bo_device);
>
>+	/*
>+	 * Assert the DMA-mapped-pages accounting only after xe_bo_dev_fini()
>+	 * has flushed the async BO-free worker: BOs pending async free still
>+	 * hold their DMA mappings (and counts) until the worker runs, so
>+	 * asserting before the flush could trip a false positive.
>+	 */
>+	xe_device_assert_dma_pages_zero(xe);
>+
> 	if (xe->preempt_fence_wq)
> 		destroy_workqueue(xe->preempt_fence_wq);
>
>diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
>index d99881c6e1d5..e816db751da4 100644
>--- a/drivers/gpu/drm/xe/xe_device_types.h
>+++ b/drivers/gpu/drm/xe/xe_device_types.h
>@@ -6,6 +6,7 @@
> #ifndef _XE_DEVICE_TYPES_H_
> #define _XE_DEVICE_TYPES_H_
>
>+#include <linux/mmzone.h>
> #include <linux/pci.h>
>
> #include <drm/drm_device.h>
>@@ -302,6 +303,22 @@ struct xe_device {
> 		struct xe_shrinker *shrinker;
> 		/** @mem.stolen_mgr: stolen memory manager. */
> 		struct xe_ttm_stolen_mgr *stolen_mgr;
>+#if IS_ENABLED(CONFIG_DEBUG_FS)
>+		/**
>+		 * @mem.dma_mapped_pages: number of DMA-mapped pages per page
>+		 * order currently live for this device, for TTM BOs. Only
>+		 * accounted when CONFIG_DEBUG_FS is enabled, since it is solely
>+		 * exposed through debugfs.
>+		 */
>+		atomic_long_t dma_mapped_pages[NR_PAGE_ORDERS];
>+		/**
>+		 * @mem.dma_mapped_pages_svm: number of DMA-mapped pages per
>+		 * page order currently live for this device, for SVM ranges
>+		 * and userptr VMAs (both share a single drm_gpusvm instance).
>+		 * Only accounted when CONFIG_DEBUG_FS is enabled.
>+		 */
>+		atomic_long_t dma_mapped_pages_svm[NR_PAGE_ORDERS];
>+#endif
> 	} mem;
>
> 	/** @sriov: device level virtualization data */
>diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
>index 909a602d091e..7a4988289749 100644
>--- a/drivers/gpu/drm/xe/xe_svm.c
>+++ b/drivers/gpu/drm/xe/xe_svm.c
>@@ -845,10 +845,50 @@ static int xe_svm_get_pagemaps(struct xe_vm *vm)
> }
> #endif
>
>+#if IS_ENABLED(CONFIG_DEBUG_FS)
>+/*
>+ * xe_svm_dma_map_account - drm_gpusvm DMA-mapping accounting callback
>+ * @gpusvm: The GPU SVM the mapping belongs to
>+ * @addr: The address descriptor of the chunk being (un)mapped
>+ * @sign: +1 when @addr was DMA-mapped, -1 when it is being unmapped
>+ *
>+ * Maintain per-order counts of the system-memory pages that the full SVM
>+ * instance (SVM ranges, and userptr VMAs in fault mode) has DMA-mapped for GPU
>+ * access. Only DRM_INTERCONNECT_SYSTEM entries are real DMA maps and counted;
>+ * device interconnect (VRAM, P2P) entries are skipped. The counts are solely
>+ * exposed through debugfs, so the callback is only registered when
>+ * CONFIG_DEBUG_FS is enabled.
>+ */
>+static void xe_svm_dma_map_account(struct drm_gpusvm *gpusvm,
>+				   const struct drm_pagemap_addr *addr,
>+				   int sign)
>+{
>+	struct xe_device *xe = gpusvm_to_vm(gpusvm)->xe;
>+	unsigned int order = addr->order;
>+
>+	if (addr->proto != DRM_INTERCONNECT_SYSTEM)
>+		return;
>+
>+	/*
>+	 * The CPU-PTE map order reported by hmm can exceed MAX_PAGE_ORDER
>+	 * (e.g. an order-18 1GB mapping), so clamp the array index to avoid an
>+	 * out-of-bounds access. Clamping is symmetric across the +1/-1 calls,
>+	 * so the per-order counters stay balanced.
>+	 */
>+	order = min(order, (unsigned int)NR_PAGE_ORDERS - 1);
>+
>+	atomic_long_add((long)(1UL << addr->order) * sign,
>+			&xe->mem.dma_mapped_pages_svm[order]);
>+}

This seems identical to xe_userptr_dma_map_account() except that there
gpusvm_to_vm() helper is not there, hence needs to be expanded.
Can we combine these two helpers into one?

>+#endif
>+
> static const struct drm_gpusvm_ops gpusvm_ops = {
> 	.range_alloc = xe_svm_range_alloc,
> 	.range_free = xe_svm_range_free,
> 	.invalidate = xe_svm_invalidate,
>+#if IS_ENABLED(CONFIG_DEBUG_FS)
>+	.dma_map_account = xe_svm_dma_map_account,
>+#endif
> };
>
> static const unsigned long fault_chunk_sizes[] = {
>@@ -946,8 +986,8 @@ int xe_svm_init(struct xe_vm *vm)
> 		}
> 	} else {
> 		err = drm_gpusvm_init(&vm->svm.gpusvm, "Xe SVM (simple)",
>-				      NULL, 0, 0, 0, NULL,
>-				      NULL, 0);
>+				      NULL, 0, 0, 0,
>+				      xe_userptr_gpusvm_ops_get(), NULL, 0);
> 		if (err)
> 			goto out_err;
> 	}
>diff --git a/drivers/gpu/drm/xe/xe_svm.h b/drivers/gpu/drm/xe/xe_svm.h
>index ffc1cc808102..f8b908a74ba9 100644
>--- a/drivers/gpu/drm/xe/xe_svm.h
>+++ b/drivers/gpu/drm/xe/xe_svm.h
>@@ -249,6 +249,7 @@ struct drm_pagemap *xe_drm_pagemap_from_fd(int fd, u32 region_instance);
>
> #else
> #include <linux/interval_tree.h>
>+#include "xe_userptr.h"
> #include "xe_vm.h"
>
> struct drm_pagemap_addr;
>@@ -296,7 +297,8 @@ int xe_svm_init(struct xe_vm *vm)
> {
> #if IS_ENABLED(CONFIG_DRM_GPUSVM)
> 	return drm_gpusvm_init(&vm->svm.gpusvm, "Xe SVM (simple)",
>-			       NULL, 0, 0, 0, NULL, NULL, 0);
>+			       NULL, 0, 0, 0,
>+			       xe_userptr_gpusvm_ops_get(), NULL, 0);
> #else
> 	return 0;
> #endif
>diff --git a/drivers/gpu/drm/xe/xe_userptr.c b/drivers/gpu/drm/xe/xe_userptr.c
>index 9c1dac0fce6f..40f97bd4751d 100644
>--- a/drivers/gpu/drm/xe/xe_userptr.c
>+++ b/drivers/gpu/drm/xe/xe_userptr.c
>@@ -8,9 +8,72 @@
>
> #include <linux/mm.h>
>
>+#include <drm/drm_pagemap.h>
>+
> #include "xe_tlb_inval.h"
> #include "xe_trace_bo.h"
>
>+#if IS_ENABLED(CONFIG_DEBUG_FS)
>+/*
>+ * xe_userptr_dma_map_account - drm_gpusvm DMA-mapping accounting callback
>+ * @gpusvm: The GPU SVM the mapping belongs to
>+ * @addr: The address descriptor of the chunk being (un)mapped
>+ * @sign: +1 when @addr was DMA-mapped, -1 when it is being unmapped
>+ *
>+ * Account, per page order, the system-memory pages DMA-mapped for GPU access
>+ * through the drm_gpusvm_pages instance shared by userptr (and, in fault mode,
>+ * SVM). Only DRM_INTERCONNECT_SYSTEM entries are real DMA maps and counted;
>+ * device interconnect (VRAM, P2P) entries are skipped. The counts are solely
>+ * exposed through debugfs, so the callback is only registered when
>+ * CONFIG_DEBUG_FS is enabled.
>+ */
>+static void xe_userptr_dma_map_account(struct drm_gpusvm *gpusvm,
>+				       const struct drm_pagemap_addr *addr,
>+				       int sign)
>+{
>+	struct xe_vm *vm = container_of(gpusvm, struct xe_vm, svm.gpusvm);
>+	unsigned int order = addr->order;
>+
>+	if (addr->proto != DRM_INTERCONNECT_SYSTEM)
>+		return;
>+
>+	/*
>+	 * The CPU-PTE map order reported by hmm can exceed MAX_PAGE_ORDER
>+	 * (e.g. an order-18 1GB mapping), so clamp the array index to avoid an
>+	 * out-of-bounds access. Clamping is symmetric across the +1/-1 calls,
>+	 * so the per-order counters stay balanced.
>+	 */
>+	order = min(order, (unsigned int)NR_PAGE_ORDERS - 1);
>+
>+	atomic_long_add((long)(1UL << addr->order) * sign,
>+			&vm->xe->mem.dma_mapped_pages_svm[order]);
>+}
>+
>+static const struct drm_gpusvm_ops xe_userptr_gpusvm_ops = {
>+	.dma_map_account = xe_userptr_dma_map_account,
>+};
>+#endif
>+
>+/**
>+ * xe_userptr_gpusvm_ops_get() - Accounting ops for the simple gpusvm instance
>+ *
>+ * The core drm_gpusvm_pages-only instance used for userptr (and, in fault
>+ * mode, shared with SVM) is initialised with these ops so that DMA-mapped
>+ * system pages are accounted and exposed through debugfs. Returns NULL when
>+ * CONFIG_DEBUG_FS is disabled, in which case no accounting is kept and the
>+ * instance is initialised without ops.
>+ *
>+ * Return: Pointer to the restricted &drm_gpusvm_ops, or NULL.
>+ */
>+const struct drm_gpusvm_ops *xe_userptr_gpusvm_ops_get(void)
>+{
>+#if IS_ENABLED(CONFIG_DEBUG_FS)
>+	return &xe_userptr_gpusvm_ops;
>+#else
>+	return NULL;
>+#endif
>+}
>+
> static void xe_userptr_assert_in_notifier(struct xe_vm *vm)
> {
> 	lockdep_assert(lockdep_is_held_type(&vm->svm.gpusvm.notifier_lock, 0) ||
>diff --git a/drivers/gpu/drm/xe/xe_userptr.h b/drivers/gpu/drm/xe/xe_userptr.h
>index 2a3cd1b5efbb..1e9601be5713 100644
>--- a/drivers/gpu/drm/xe/xe_userptr.h
>+++ b/drivers/gpu/drm/xe/xe_userptr.h
>@@ -108,6 +108,7 @@ int __xe_vm_userptr_needs_repin(struct xe_vm *vm);
> int xe_vm_userptr_check_repin(struct xe_vm *vm);
> int xe_vma_userptr_pin_pages(struct xe_userptr_vma *uvma);
> int xe_vma_userptr_check_repin(struct xe_userptr_vma *uvma);
>+const struct drm_gpusvm_ops *xe_userptr_gpusvm_ops_get(void);
> #else
> static inline void xe_userptr_remove(struct xe_userptr_vma *uvma) {}
>
>-- 
>2.34.1
>
