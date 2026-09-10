Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECE8C79FB7
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 03:23:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F05DC10E83B;
	Thu, 10 Sep 2026 03:23:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ScKbid6S";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4692D10E08B;
 Thu, 10 Sep 2026 03:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789010606; x=1820546606;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=He5xQ4ge8aGULxxins2ZAYalMPmC7uSJes+NQDomnFc=;
 b=ScKbid6SD72QEpysDH94FtjKhTahTlwjn6G28zz/46NbRngW/U32moj1
 MHPKKHiqTeQ0qZVRHZQcfHiFJBn2mtLUEmyFQ4bxfddqpl3ZaG7ijMpAK
 LLID8eqpK10XbgIXMjv8bdd/7h4AzATHZG946EkruwlaEiubA6P8Wqlng
 7xMhR2tNQC+snwx5m7mzKkNvIKFZIuBlbdYVgY62L6Vvjp3PyFzmjbQjR
 DGuOD1hrrqkS72Ckd1qotyhfDMTzd8cktYOPtTvdhAtcR56f7cYPk/g2j
 rib38UDKpE3sWHRkN5+U7OL5zL1OhdNF/kIP3lyvxgp3089b/SG5ciTs6 g==;
X-CSE-ConnectionGUID: hx0Nw04/SUu9WBWCGe1Row==
X-CSE-MsgGUID: eFbQcgexTfyOoj9MOMHUcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="100113105"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; d="scan'208";a="100113105"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 20:23:25 -0700
X-CSE-ConnectionGUID: LLnsljdoTsWhUWAdGTp8dA==
X-CSE-MsgGUID: mUqdT469T/aO4yL/sfAzGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; d="scan'208";a="276747918"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 20:23:25 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 20:23:25 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 9 Sep 2026 20:23:25 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.15) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 20:23:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fq2bVJLQINUGzzu6YBg2Ryr3IAppk2/dnZIrGytvDn4Ot4OQa9AsDaWj/9RJCKRr+pb5KMElnq1seZsSTxqh3bIajA7CGo85kxeAmyrn9PQi0RjoO2FN+U65m5IPYwL3LxGeNvRvCwZ3U9w8oYAnd/u5xBP1YGyTLO3uQGeJGRbvg5K+N/Da+2etYaWcIE0AlSH4qhpAPY43sQm9FpSPVGlaAWzW6TDZgkMF7H9rtGUid0eqi/3HK+mjMGBg4mOjCUa3mPCiHH0jzuovhPkyswn3NnySsucHPWBpb9AoeX5xkwAsDgflYRqPMvm07p64YvXhNm7/VUMJ18nnte4a7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SREY71BmzSJnPkEUq4cceBnBmMQ6zIKnQAz1wH7HOpo=;
 b=m/ZA1CZHe5YManf0+5YYSOU4TFqERRANXwWSuSyEOS1WbFdlag5erSLOEo6PBcevVpSs5MDEKvSNqxwRuA9MgukgFKJ1N5PyHKnV6EVIyEUp3TAQ2eCFckD1YMNVOQ/gQLabf9NS+Bym/2qPDQDFL/gbLfVaOghtTZb89UphgSZ2rQtLPDwh/vgmgb8Sq9u/cemLZoBS5m1jRLOQ97WH4hXMAgfQSEDKerCYq7nFmsmw6zjT7iXeHvKVu+Lucb3N6B/kpsImnRpQokMSDmfjmkgfNgEeFFJ/VBzOxV4YQurCAmza/fP3iedn5DUX17zm92tR9+VKmm/DI1METQqujw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by SA0PR11MB4735.namprd11.prod.outlook.com (2603:10b6:806:92::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Thu, 10 Sep
 2026 03:23:18 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%3]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 03:23:17 +0000
Date: Wed, 9 Sep 2026 20:23:15 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: <christian.koenig@amd.com>
CC: <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <ecourtney@nvidia.com>, <nat@pixelcluster.dev>,
 <dri-devel@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 11/11] dma-buf: Inline dma_resv_init and remove allocated
 flag
Message-ID: <aqIio0VztGXvuzjK@gsse-cloud1.jf.intel.com>
References: <20260903134408.105317-1-christian.koenig@amd.com>
 <20260903134408.105317-12-christian.koenig@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260903134408.105317-12-christian.koenig@amd.com>
X-ClientProxiedBy: SJ0PR13CA0186.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::11) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|SA0PR11MB4735:EE_
X-MS-Office365-Filtering-Correlation-Id: 3936c832-e730-4f9b-7f81-08df0eeadb6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|6133799003|18002099003|22082099003|56012099006|10067099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: JEMbOUIWlM70haIIOXPWCS+ucd3fFhjNc9qBlpG4EU/gStHMBeY0l6InzT1IO35jMg0ZXPIJSmxBbUCmTTFO48YCAH7YZ3cZiM9xb+gYZkcl2xhbDvTzTq7nsRN9BRFfi/k4rAZBENjSYi1A12QGxbY7Cn1QP6l/6BFtQ1ncc0FgL7JRoy4Uwm+QeWm/dkoA1YUsgRKazz8H9UhVnSa/k/5mcWIThJuK7GfQBCYkxARiDgJlQ0dg1ADCmp9dMbMbCE8ikSnl6OAmTOmekHfMzFghGm4dm71ETA/Kn3toYzQ4kUv1X57CCYEq/0s0E88AyEndd4E+F98G7KHSPZgXQeIJ7ZIox7twhA7cWmSHRS3hRdv7qG4WWbgZ0dPRlfB2my/YWAPy74FIqSUTXmzYwNKfZIEE6Fq72CibRdPxE4MwpsgMQPEGvkfMYnmRtmEIjDbQS252aryDYB3fAoMvu33xEGwuNZBQKnQb+Y3ew/tLtrUanNXmzMl4ryRAOQKH7s0Q8wjv89b3WRYfKB6VY7wU51fwobX6VpaCTbDFOSl6AEg78BJE5xOTbIz1ZdBwmAixE7V8JtHADhcoXmS5wrl7n0ZzJmga8vxeoVSwl68Ak90WoX5pjizkd5j6q26PagHifOJ8wAeuUg7mvThQsCqlMIDc7Gy1FACjDq/D/mk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(56012099006)(10067099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?wKD79eW4MNoGCz6k0Np0KBgwKzQRoHe8jLYdBin8riCp9K29j4MjAh2S+D?=
 =?iso-8859-1?Q?t9G2eom+q3HL9abFu5KniN+7n1xuvJM7QQoopkWDORAitTNAQyKkMLlhEu?=
 =?iso-8859-1?Q?cAkZKUBu5yFZg9uX2PekjRnir1LIdHgfsB6HsxUlHHkMsG8wQMnLggOq0J?=
 =?iso-8859-1?Q?NqOoJah7+LSEL5OoBdcJps5rHX8dYrHevRB8SIC7yYbeiNCqjF2KBV0pYY?=
 =?iso-8859-1?Q?PlnSCTAelQN/8+ZUf3W/2VhRtMcbhaXJ805Kb0pEEDeSmRzg8CqqmqL8zn?=
 =?iso-8859-1?Q?Bac6ljrpYBl0qcbEKSXwauPI2bIf767X11ahBnzMXBuiLicVQ3tYopctrW?=
 =?iso-8859-1?Q?MLaCT9MZVft/SZKUeiSw1RnaR8yAf2/3YQVsD0RpUMSIUxDJKpl98X+w90?=
 =?iso-8859-1?Q?80ELnZei/RwPUVObRbXgvbY9fPN9jvb6b64ToM+9bK/Bvd6XpHr1neye41?=
 =?iso-8859-1?Q?YR2r1vZtrDFKW2Km1MZWZabqh5RON+uy/e6MM1yGYIwDSGwxLQt9q5cWuw?=
 =?iso-8859-1?Q?MPzJlRwZydyacgH/ItTqpfDGpBrrc8Of58+HxpKuubqIYhUGq3vBMs898C?=
 =?iso-8859-1?Q?HtXYMvq9/kwMP1mRbHB0y5+65DUBwTH9Wumt63SLv/gQXydtwf4iNlC+wy?=
 =?iso-8859-1?Q?EE0C+/BoxKnq5fKNxlmvtO8VAUgbVcFEUg/RwBs4potIwXE9BJdDeV58dn?=
 =?iso-8859-1?Q?rh+RWdDXkp3JYBeu+Em5X7RGnhWWa+91+a21t2KXCK5gOprlPxf2WHftPk?=
 =?iso-8859-1?Q?XWDy7ojQ2lndi3GDcaSr5J/9EY948mHkMBxtq/RxkpfYKubhmPgP1ItUR/?=
 =?iso-8859-1?Q?ElqUgMoKwWtRRGt8Z6PoQIESm0JVLDh8vORQHXKtwNdvqnjtgbx3LQxw/z?=
 =?iso-8859-1?Q?d9xqBUbpkl6eSufISfRD7WMsy+jt8jz05UJ7G6EYiz8cVKT61rJvY05eK3?=
 =?iso-8859-1?Q?POY/gYGwBVH5x6DK8Fo/cocIREofz+Y/XC2+A3OnNJdPMpRxsNbkfHfojB?=
 =?iso-8859-1?Q?LSXol3sklVI+oRA3ttxvIVfzGspsJv/V+IrutKU+FrQ1A4uUXZvxDNYRSR?=
 =?iso-8859-1?Q?dqUiK8ZUZoSsIhGm0aMstGVS2N9RweAW0XOmw+vW6Q0L9aqBuemco3GYdJ?=
 =?iso-8859-1?Q?1CMHLeYlHYszmWvCNxWeTRhX+bilvJ+NZmUhCpmQ6s1CXHgNijRSZ/mpv7?=
 =?iso-8859-1?Q?iu0ieoaRsx83Q0DMFCj5pRTqt0DsymOuM1K+Q6T+2AxLI+CfoMBFqPfVWm?=
 =?iso-8859-1?Q?wUw38gyXH5LCrpG/DDtruRRoNYrBD6OrfuzqyuEV+OoEEE8WyoDsiFj90g?=
 =?iso-8859-1?Q?g8dlg3i/WDZMryLQLuMOmjFXB/7k84sbSQcbh9LxhC/+cWkeBphcVRhdDP?=
 =?iso-8859-1?Q?ZI2nYiJmJiFlJOH+mRUuIkWC/hNtmxPubQ11DoAboMrzJgifeQZC6HxtY1?=
 =?iso-8859-1?Q?kgPL6f0BpiAlA0Z4XA3NoRzzGkw2+FKiNdMWxTQeCPS1kaoucpTuP1DbSw?=
 =?iso-8859-1?Q?PjqrARvQQFIv4Z/VebASL1qeMtdIkdTzb+5e6GL/4qBxOUtSU8tjvaLfwt?=
 =?iso-8859-1?Q?oRAYGGGL9hMnJ2rl5oZnZRCJre+VWygbTyFOYTvA2aPq/6Qhhud8/7KrWe?=
 =?iso-8859-1?Q?dJMwHdU9nA+KgAVbQHUejQAL8TkB0LdFllnDSAd7PMDx6W+eRhHcAdnnPj?=
 =?iso-8859-1?Q?QE2hhqOe383xWEEhMrLF/EgfBiVb6Iw9fk6H2ccUtLkaovaVs+6VPz1kGU?=
 =?iso-8859-1?Q?IS34RUlz2gRlhbQOdxho6UrOe+7QayeUJwkwcWLwyhqpLwgYo9j1f8MWse?=
 =?iso-8859-1?Q?TBqprMAqEum0AmNN2Ze0KS5JGQrvOBE=3D?=
X-Exchange-RoutingPolicyChecked: RK01McsLv5g9MGfRr9pwlGEv4ZEvldEPLNmuEQj40vU2P1QTeX+CCFOP8fUDYar8Y7PeNlYljbLvWJZibe9oQa67+zc/PYNyO+vTOhfTT7n5PzveqEdbGdKGFZoaNWwZDe1Ck1ekbqPyF+YDHN5G76R+13XXQEc22ZVoR0xm7QGdacc0ePOFxM/DW0vbUPUln1TVN5CXxTy4DnzxByNXDZml0y+bhj8yE5s/JYX1On+7U3IeRYxvYYOcmqfq8jLrMjZPXgB7bvCwyj1w8zKmpVMJbjz7CVefBtJkqoz/MDvocS5wjGcAG5kksa8EVkZpFIaUSgS79DhtUEk0ibDHkg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3936c832-e730-4f9b-7f81-08df0eeadb6b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 03:23:17.7213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pm0uCg6oamatydF1mFiGlsSjmYOb/f4aBtYHZxFL/iccfMt5bebVmPqgoQ0U7SHjuU9styfEnnm4HOliQN75Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4735
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

On Thu, Sep 03, 2026 at 03:28:06PM +0200, Christian König wrote:
> Now that all users have migrated to dma_resv_alloc(), inline the
> initialization code directly into dma_resv_alloc() and remove the
> dma_resv_init() function entirely.
> 
> Additionally, remove the 'allocated' flag from struct dma_resv since
> all dma_resv objects are now dynamically allocated. This simplifies
> the reference counting logic - dma_resv_release() now always frees
> the object unconditionally.
> 
> The last remaining use of dma_resv_init() in dma_resv_lockdep() has
> been converted to use dma_resv_alloc() instead.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Assisted-by: Claude:Sonnet 4
> ---
>  drivers/dma-buf/dma-resv.c | 43 +++++++++++++++-----------------------
>  include/linux/dma-resv.h   | 10 ---------
>  2 files changed, 17 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
> index 5ae5a4b40ae6..4a421b08cd98 100644
> --- a/drivers/dma-buf/dma-resv.c
> +++ b/drivers/dma-buf/dma-resv.c
> @@ -132,26 +132,13 @@ static void dma_resv_list_free(struct dma_resv_list *list)
>  	kfree_rcu(list, rcu);
>  }
>  
> -/**
> - * dma_resv_init - initialize a reservation object
> - * @obj: the reservation object
> - */
> -void dma_resv_init(struct dma_resv *obj)
> -{
> -	kref_init(&obj->refcount);
> -	obj->allocated = false;
> -	ww_mutex_init(&obj->lock, &reservation_ww_class);
> -
> -	RCU_INIT_POINTER(obj->fences, NULL);
> -}
> -EXPORT_SYMBOL(dma_resv_init);
> -
>  /*
>   * dma_resv_release - release function for kref
>   * @kref: the kref inside the dma_resv object
>   *
>   * This is called when the last reference to a dma_resv object is released.
> - * Cleans up the object and frees it if it was allocated by dma_resv_alloc().
> + * All dma_resv objects are now dynamically allocated, so this always frees
> + * the object after cleanup.
>   */
>  static void dma_resv_release(struct kref *kref)
>  {
> @@ -163,10 +150,7 @@ static void dma_resv_release(struct kref *kref)
>  	 */
>  	dma_resv_list_free(rcu_dereference_protected(obj->fences, true));
>  	ww_mutex_destroy(&obj->lock);
> -
> -	/* TODO: Only as temporary workaround till dma_fence_init() is removed */
> -	if (obj->allocated)
> -		kfree(obj);
> +	kfree(obj);
>  }
>  
>  /**
> @@ -187,8 +171,9 @@ struct dma_resv *dma_resv_alloc(void)
>  	if (!obj)
>  		return NULL;
>  
> -	dma_resv_init(obj);
> -	obj->allocated = true;
> +	kref_init(&obj->refcount);
> +	ww_mutex_init(&obj->lock, &reservation_ww_class);
> +	RCU_INIT_POINTER(obj->fences, NULL);
>  
>  	return obj;
>  }
> @@ -844,23 +829,28 @@ static int __init dma_resv_lockdep(void)
>  {
>  	struct mm_struct *mm = mm_alloc();
>  	struct ww_acquire_ctx ctx;
> -	struct dma_resv obj;
> +	struct dma_resv *obj;
>  	struct address_space mapping;
>  	int ret;
>  
>  	if (!mm)
>  		return -ENOMEM;
>  
> -	dma_resv_init(&obj);
> +	obj = dma_resv_alloc();
> +	if (!obj) {
> +		mmput(mm);
> +		return -ENOMEM;
> +	}
> +
>  	address_space_init_once(&mapping);
>  
>  	mmap_read_lock(mm);
>  	ww_acquire_init(&ctx, &reservation_ww_class);
> -	ret = dma_resv_lock(&obj, &ctx);
> +	ret = dma_resv_lock(obj, &ctx);
>  	if (ret) {
>  		/* Only EDEADLK from the error injection is possible here */
>  		WARN_ON(ret != -EDEADLK);
> -		dma_resv_lock_slow(&obj, &ctx);
> +		dma_resv_lock_slow(obj, &ctx);
>  	}
>  	fs_reclaim_acquire(GFP_KERNEL);
>  	/* for unmap_mapping_range on trylocked buffer objects in shrinkers */
> @@ -874,10 +864,11 @@ static int __init dma_resv_lockdep(void)
>  	__dma_fence_might_wait();
>  #endif
>  	fs_reclaim_release(GFP_KERNEL);
> -	ww_mutex_unlock(&obj.lock);
> +	ww_mutex_unlock(&obj->lock);
>  	ww_acquire_fini(&ctx);
>  	mmap_read_unlock(mm);
>  
> +	dma_resv_put(obj);
>  	mmput(mm);
>  
>  	return 0;
> diff --git a/include/linux/dma-resv.h b/include/linux/dma-resv.h
> index 4d12519df34e..cf689d3d4ba6 100644
> --- a/include/linux/dma-resv.h
> +++ b/include/linux/dma-resv.h
> @@ -162,15 +162,6 @@ struct dma_resv {
>  	 */
>  	struct kref refcount;
>  
> -	/**
> -	 * @allocated:
> -	 *
> -	 * True if this object was allocated by dma_resv_alloc(), false if
> -	 * embedded in another structure. Used to determine whether to free
> -	 * the object memory in the release function.
> -	 */
> -	bool allocated;
> -
>  	/**
>  	 * @lock:
>  	 *
> @@ -482,7 +473,6 @@ static inline void dma_resv_unlock(struct dma_resv *obj)
>  	ww_mutex_unlock(&obj->lock);
>  }
>  
> -void dma_resv_init(struct dma_resv *obj);
>  struct dma_resv *dma_resv_alloc(void);
>  struct dma_resv *dma_resv_get(struct dma_resv *obj);
>  void dma_resv_put(struct dma_resv *obj);
> -- 
> 2.43.0
> 
