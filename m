Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA487606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 04:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cMg5ozaj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 249D210F998;
	Wed,  4 Nov 2026 04:06:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3A8010F998;
 Wed,  4 Nov 2026 04:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793765195; x=1825301195;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=JoWiKKifH8Q2bQ/UjVrWmFcfEvcMKufmpE573KDsyrE=;
 b=cMg5ozajjYtmZLsJ3ksYp0BiQaerXbPXr9jnYI6HHfNIfQoOY4gfu8MX
 bcL9ZVzc4wjkqJ9Abv99Q/kd0/2DgouYB4MoKjbTBLvjhE5z3u7bvghVt
 BQIc3+AaDV3GpPLzyhbxGHYuAoeGttfYoA1QCY9xj7ujs6me0LtqfKOsd
 PDp97FKhmMS2OSHnFKrmO7VNlwyl2QNDE9kEzt+5aImrIK+u6uWhDuOVh
 tp8GlunI1OZ7MLBR7faUOFR3Vja+oetb4z/0qwjE1OMsUrxV8m2/BSash
 xDPEtTEf/qJwQBtod94BA7WTzUF/idk7EUeKfDIHe9XSk71p8OrWLkWGc w==;
X-CSE-ConnectionGUID: vkTxeoO2Sb6TCuvwhxxGtw==
X-CSE-MsgGUID: CVpeJtZSTA+Z24IaM4IpCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2397708"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2397708"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 20:06:34 -0800
X-CSE-ConnectionGUID: leyacXXaQBiHb5fptMbYCA==
X-CSE-MsgGUID: d+8Ts+31TVCGpGKDrUBPDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="6935459"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 20:06:34 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 20:06:34 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 20:06:34 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.31) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 20:06:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfNtl7RanBqML0nTHZzqbd7K9Zm+cgHrhNljAfPx5NMPlsUouaA94n913ROjEjGYlRcT+nwgtZ33bDwKL90xb75gfP8GOShi8lRFi5jxQmGU9+2r4J61loekrnN/u/kudrFN5GrUtd5o+DEg3Jn71J98UtYeU7xF7n2Y/wZagOmX8fqBpsAzH8XOCyRI4E+rbYTTVrUrumvaRZxKsZmEQsvc9Am6ZkBjh1Kh1P1U/dg7C5eGC0BSWA0eC9r85USUB0crAf0F0TAkb81qcfL6+xcT3jUECZHWNW5rnBoV/Y6vwlDn+HRqaKoVt8HAV0EEIp+p5SPddyN/8XjXPU1lsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJr69LBVH7yFhnd1EcYduU4BRcTVul27c6jBvtp9A/o=;
 b=C4Ug91vis7fVGj6QDCzBK8YWoGeA1ijWLGYMbpxKk9R4M3atd+POvwbcmZ9nmjaC03UOfczsG+EeZfGBt5huz1LTcsy8V03+u89Lt4qa0qbmQ8kU3xq27+1rsaHfUki7FHxWkMlTpYViWl+bZ/1SVI/Z4f3pfIoT5EPqKATZYs5mmOWJGNZPrkid7qSAvuprDoDO+HFREBmhxZp5/paf9aTQvO+hJB8VaG4bNrEMyQkJ13MpcmkgzTH1fPDIGYlxTuI/TymzmWhtuUSjdum7IprhPHBJInEOgrm4P0kWOmuywDOSygS0tcqK9GvmjBsOjLAmZhKw8OeltJswU+9Omg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by DM3PPF076C797B1.namprd11.prod.outlook.com (2603:10b6:f:fc00::f07)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 04:06:30 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0569.011; Wed, 4 Nov 2026
 04:06:30 +0000
Date: Tue, 3 Nov 2026 20:06:28 -0800
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v3 12/33] drm/xe: Add debugfs stats for DMA-mapped pages
 per order
Message-ID: <auqvRK1BVU_ec2JX@nvishwa1-desk>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-13-matthew.brost@intel.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260711025619.2540575-13-matthew.brost@intel.com>
X-ClientProxiedBy: SJ0PR13CA0137.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::22) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|DM3PPF076C797B1:EE_
X-MS-Office365-Filtering-Correlation-Id: 196b827b-a7f4-4501-6b1b-08df3a290147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|6133799003|10067099003|261102123227099003|22082099003|18002099003|261102130727099003|56012099006|4143699003|11063799006|261026140227099003|261026121527099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|261028144727099003|261009221227099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: etVqzPeuT8rUfU7lH5sho9DjZLaG38QKzArrCOZRU8sN5P5d8Yb7rJ52B1Fg1L+CONawIMV4PRdFVfyigjy444WnTD03ioGoppkMFkakkUNTkrPkMSFtCUP5A0Q1Q/7eYmlsXEkxhcenYvUG29N0zUoAXya4V7z1mwIWJBGLFeGflYjDogXKFQrE/SI48BfNd4EL75ZiJN3pwy16UmZK7bYcCR89hTF6Xfg2A54FPMkDlEvlixSWWmspkrBsQQp+i38LfUVJUKM/jQNaNDZFuHy+mFteHTwaQKZ3jsFPTgYM+xFdFy34JJsoEoSFPpqXNo9/ToBvIbnWA8ygt9gcVQcVwIjIj+ZuN78we9sZrveCPYNz1tHmrt5WM7BC96zfrK1NsQbWOI7Op9dDAumlbu9y9p2mP2zgIxwWG4lyfZcVvnyZIyUZ0BS8VjrUujwLCvac4hdxZGWhF9n1R0szbUNfj4mmada3Ox61R7Wg7Q3oLlOgaCLtjjXvgWjfuymISZbNR+fiJB0F92ZnYGweRcj6T365HG/qSB6KR17YvgzFI9tnxVvIF3CxCodM8Zg3t7csHxUnN1gzP6g8b39ISlVSNCwq2YH9ofzSt+IwlOtCiJjwtrPLDd3GawHwCf/i6MfKflSGp5R60x6kGcZ6qd9fN3Ie02stSS269NNNG7s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(10067099003)(261102123227099003)(22082099003)(18002099003)(261102130727099003)(56012099006)(4143699003)(11063799006)(261026140227099003)(261026121527099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(261028144727099003)(261009221227099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?uA0pQpKzUn9j9IBzq3CtE4mxQHibj3DEfgjUF4SgXYOXKo80UQ6vWgSsOa?=
 =?iso-8859-1?Q?1PoxROqv/Cvv+64+zr+2EDVqjkzgCBT+lTugs23sk070qHU5fE7HKIjHZN?=
 =?iso-8859-1?Q?+IyGknzprTgGFaghr9Hny9jRKbtDmlUSmpZW1ugfgLMREL7QCIzlQM8TI0?=
 =?iso-8859-1?Q?mcE3+dneIZWJrJ8qHcKOZo13xFRg2/OcV8I9JmhwyGfZJACmYHEZSJVfsz?=
 =?iso-8859-1?Q?ZLpunlJohzpDRhakBO1w5x1q4QEvOV3NuElYQR+MTFem+TChP6tcUkfQm/?=
 =?iso-8859-1?Q?xXyWXqsfAjnZjTJRznsRC5zgGpRivRWaA6EfvEps9CodORCEsZ4UMvVhB6?=
 =?iso-8859-1?Q?sEAFdOrvvZLHJMxI0hO2g4fSNPyRtic7BS78SiW+KGrQmuOtLgBBUXAur8?=
 =?iso-8859-1?Q?ECHHqcGiXY8fQ74hsj48y3zFpz3LW691H2HUQTvZNz+1FPK8hbNY8mZ7mS?=
 =?iso-8859-1?Q?EOMUtxOIsShm2qoET8AFdyWp/ZjR1HEcUHOcKSuUYtevhaJS5XsjVW3N0n?=
 =?iso-8859-1?Q?DYhNVC4xAKSCEassow/rfVzd/5mUncQO3E+PD6LruJyZsiTFDbpGcLUCC4?=
 =?iso-8859-1?Q?wsp4dp/DPfJboOi5ZIxM7laYWrHahVLP7oVcXluNEuioX7Hgz3snXysNjQ?=
 =?iso-8859-1?Q?ut5u5PP2WfqlhM4eXTlFPP9DTEVYIgoTz0RiNl4yWP5Axg1xSwyR2v8jOd?=
 =?iso-8859-1?Q?SUFjuxlCj+NSPk2xizwW4nT/CF8D760x503XzDEFSOZGUpZZ+JRI9usQhd?=
 =?iso-8859-1?Q?NHQRAb6TC/lfytACG4KHqoXaH3NordqsvZoMisLzeiKQHt3h8yhZT8qsF5?=
 =?iso-8859-1?Q?/23IVFaKOWpnU2X1NQKIiI+PGt842fK2NvWt2RBoJipvsprbrBU5O0CgcE?=
 =?iso-8859-1?Q?SRiCV8tvIC9swIqkjExbcQoyFYYw69KGebtMvCCTBTiNj4dl5/9x3d1OJf?=
 =?iso-8859-1?Q?tEAfvGhKMr1F5NLD7FlCJkGkZ4RxTtqpoDeBcd6KTsXjqDK/+JVFjhFZO/?=
 =?iso-8859-1?Q?8IOp3iB1CC4d7MSjQksqvqVAPGHdLp0m5bLJ5B30E3M+kbfcucejjj8V20?=
 =?iso-8859-1?Q?qKBemXKGBYWzNtRiNINI67fvsemKEkkMmTwmX85i6cB1noQjNlE3vbd3NS?=
 =?iso-8859-1?Q?g57h8ZDd6Eu3ds98rCFgjGQ3Jxj6Sm88ZnyaI5KtbaNNQUskV2duzD74bv?=
 =?iso-8859-1?Q?NYdxcKY9k5Qzr1z8XN+Kffh4Y3xK7g9Ds+lrwfwmCE7UoY6Z/FJJeKYzOV?=
 =?iso-8859-1?Q?r6HpUol5NZd9IOeFXe1tfkkgGPOhLd0yKv+dXh7TInX54OQl/F4MdCM1NC?=
 =?iso-8859-1?Q?a6R+dd+WV5hBKhuQG5v2WtPTM8zhetX5Pu8MK/c8cfTTwel2pnDEGO0/HC?=
 =?iso-8859-1?Q?d49DDPUNdBnenouEDfZrdiZscjctY8jbHVYChHydKuXBacIFmpYth9y0xs?=
 =?iso-8859-1?Q?HTytZfp2s6/q/oMdZLnAhvggO7O4pbgNxQZiS+GaZ3kXSHwzzfIIegx+L/?=
 =?iso-8859-1?Q?SbJaPrXWEQGvvJRJhnSfmi3VQj5tRSAfvvvNA1DdCSQGRo0lGRlStDfXlZ?=
 =?iso-8859-1?Q?al9SUPyOgPhHgivAui928LoNJVtba412W7SwNOwxKPfTGGUHap1CeMtCOv?=
 =?iso-8859-1?Q?55WOdaH/f6EnE1nJz0Wcf3if1w1MsM4mHxFh4vK/JsMCUFKcRolmWVZQiU?=
 =?iso-8859-1?Q?HOoMUGMSw9Dmg9JobGT1mWEI4QwnAogaADEVWYnulieheg4808RydUWNIk?=
 =?iso-8859-1?Q?91nTPnFt22PKPBTR4oZdwZxMeRXKOyZvVEfVIS42NuCxX91Zqkpr7TvUxP?=
 =?iso-8859-1?Q?cMewt2f+yuKhCaNfmGOvNpbeqa6IdJ8j+YGlbgI/Ar+q85/5kqXQ?=
X-Exchange-RoutingPolicyChecked: AxQWoCAPF/9EjWohQNfWHtScacC+GRp9BgwpjbzlmZCLCF+36Kug0k9opcyvfTu4hEnt3LA5gdX6E+BY1tvRfIqL1JYwITfFC8QqtqBrnsZZ03fl6DE9IU9T251O/dZT6/uTU8pfqQuJyPu81CMJmnbXLdCcjHANn8LA0J4LYoL3mSgJx2ct+Ol1NZvb6+euUMAVaq1bIck8IC+oO/dXJBcXf211cyAcMORBPpFQ/aiIP6L5V0JnEqPGZeWtjFrih5edYTMkC2yCAuXQRbEZ9Awl8qJdHkq3w5l1+24iAhvYlZ6CUEyWLjsVXjze9Q/+mW27CTVCOt68dLUqNBzh7g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 196b827b-a7f4-4501-6b1b-08df3a290147
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 04:06:30.4877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZCpajpNP+1v3QdWlisxO3FOMNGHe5H5NzmmLJ8zy/VUXA8NhcYlsfReKGfs9Y0kENdPzWk9LMmiDc2iPKmcW4fYYvimZkbc7Pi32IecbjGBZYsfc6/y5/A+530Auei2k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF076C797B1
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

On Fri, Jul 10, 2026 at 07:55:58PM -0700, Matthew Brost wrote:
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
>as happens on the defrag page-borrowing path.
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
>Assisted-by: GitHub_Copilot:claude-opus-4.8
>Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>

Patches 11 and 12 can be spinned out as a separate patch series
(for fast tracking).

Also, dma map/unmap of dmabuf imported BOs are skipped here (rightly so).
But perhaps add a comments in commit message that either self-import
returns the same BO and BOs of other device gets counted on exporter
side when it gets first migrated to TT first.

>---
>
>v3:
> - Fix drm_gpusvm_init() argument order, clamp DMA-page order to
>   NR_PAGE_ORDERS - 1, and drain DMA-page accounting after
>   xe_bo_dev_fini() (Sashiko)
>---
> drivers/gpu/drm/xe/xe_bo.c           | 46 ++++++++++++++++++++
> drivers/gpu/drm/xe/xe_debugfs.c      | 26 ++++++++++++
> drivers/gpu/drm/xe/xe_device.c       | 30 +++++++++++++
> drivers/gpu/drm/xe/xe_device_types.h | 17 ++++++++
> drivers/gpu/drm/xe/xe_svm.c          | 44 ++++++++++++++++++-
> drivers/gpu/drm/xe/xe_svm.h          |  4 +-
> drivers/gpu/drm/xe/xe_userptr.c      | 63 ++++++++++++++++++++++++++++
> drivers/gpu/drm/xe/xe_userptr.h      |  1 +
> 8 files changed, 228 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
>index 85e6d9a0f575..60e0e568aa31 100644
>--- a/drivers/gpu/drm/xe/xe_bo.c
>+++ b/drivers/gpu/drm/xe/xe_bo.c
>@@ -367,6 +367,50 @@ struct xe_ttm_tt {
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

NIT: As there is an atomic operation involved, instead of doing it under
CONFIG_DEBUG_FS, should we be doing it under a separate xe specific
debug config?

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
>@@ -396,6 +440,7 @@ static int xe_tt_map_sg(struct xe_device *xe, struct ttm_tt *tt)
> 		return ret;
> 	}
>
>+	xe_tt_account_dma_pages(xe, xe_tt, 1);
> 	return 0;
> }
>
>@@ -404,6 +449,7 @@ static void xe_tt_unmap_sg(struct xe_device *xe, struct ttm_tt *tt)
> 	struct xe_ttm_tt *xe_tt = container_of(tt, struct xe_ttm_tt, ttm);
>
> 	if (xe_tt->sg) {
>+		xe_tt_account_dma_pages(xe, xe_tt, -1);
> 		dma_unmap_sgtable(xe->drm.dev, xe_tt->sg,
> 				  DMA_BIDIRECTIONAL, 0);
> 		sg_free_table(xe_tt->sg);

There is another dma_unamp_sgtable() in xe_bo_dma_unmap_pinned().
I guess we should account for that unmap path also.
I am seeing sashiko reported this as well.

>diff --git a/drivers/gpu/drm/xe/xe_debugfs.c b/drivers/gpu/drm/xe/xe_debugfs.c
>index 8c391c7b017a..97b47c5c4213 100644
>--- a/drivers/gpu/drm/xe/xe_debugfs.c
>+++ b/drivers/gpu/drm/xe/xe_debugfs.c
>@@ -6,6 +6,7 @@
> #include "xe_debugfs.h"
>
> #include <linux/debugfs.h>
>+#include <linux/mmzone.h>
> #include <linux/fault-inject.h>
> #include <linux/string_helpers.h>
>
>@@ -231,6 +232,28 @@ static int dgfx_pcie_link_residencies_show(struct seq_file *m, void *data)
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
>+	seq_puts(m, "\n");
>+

NIT: As order-10 also prints higher order (1GB) pages, may be print it as '>=10'?

NIT: This is a rough snapshot as array elements could be changing as we print.
I guess that is fine.

>+	return 0;
>+}
>+DEFINE_SHOW_ATTRIBUTE(dma_mapped_pages);
>+
> static const struct drm_info_list debugfs_list[] = {
> 	{"info", info, 0},
> 	{ .name = "sriov_info", .show = sriov_info, },
>@@ -632,6 +655,9 @@ void xe_debugfs_register(struct xe_device *xe)
> 	if (man)
> 		ttm_resource_manager_create_debugfs(man, root, "stolen_mm");
>
>+	debugfs_create_file("dma_mapped_pages", 0444, root, xe,
>+			    &dma_mapped_pages_fops);
>+
> 	for_each_tile(tile, xe, tile_id)
> 		xe_tile_debugfs_register(tile);
>
>diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
>index ad7f3e61d457..97cc2d185e45 100644
>--- a/drivers/gpu/drm/xe/xe_device.c
>+++ b/drivers/gpu/drm/xe/xe_device.c
>@@ -455,12 +455,42 @@ bool xe_device_is_admin_only(const struct xe_device *xe)
> }
> #endif
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

This also probably good to do it under a separate xe DEBUG config instead of
CONFIG_DEBUG_FS.

Niranjana

>+	}
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
>index 022e08205897..95e7cea91cbf 100644
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
>@@ -279,6 +280,22 @@ struct xe_device {
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
>index b228a737cfd6..ebe48cb76ad9 100644
>--- a/drivers/gpu/drm/xe/xe_svm.c
>+++ b/drivers/gpu/drm/xe/xe_svm.c
>@@ -827,10 +827,50 @@ static int xe_svm_get_pagemaps(struct xe_vm *vm)
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
>@@ -925,8 +965,8 @@ int xe_svm_init(struct xe_vm *vm)
> 		}
> 	} else {
> 		err = drm_gpusvm_init(&vm->svm.gpusvm, "Xe SVM (simple)",
>-				      NULL, 0, 0, 0, NULL,
>-				      NULL, 0);
>+				      NULL, 0, 0, 0,
>+				      xe_userptr_gpusvm_ops_get(), NULL, 0);
> 	}
>
> 	return err;
>diff --git a/drivers/gpu/drm/xe/xe_svm.h b/drivers/gpu/drm/xe/xe_svm.h
>index a921556d3466..8e347137a7a6 100644
>--- a/drivers/gpu/drm/xe/xe_svm.h
>+++ b/drivers/gpu/drm/xe/xe_svm.h
>@@ -194,6 +194,7 @@ struct drm_pagemap *xe_drm_pagemap_from_fd(int fd, u32 region_instance);
>
> #else
> #include <linux/interval_tree.h>
>+#include "xe_userptr.h"
> #include "xe_vm.h"
>
> struct drm_pagemap_addr;
>@@ -236,7 +237,8 @@ int xe_svm_init(struct xe_vm *vm)
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
>index 8b2d461ea0b2..6b9e1530ead4 100644
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
