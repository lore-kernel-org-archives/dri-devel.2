Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604CF606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 00:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mNT3YIAy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7283710F690;
	Wed, 11 Nov 2026 00:39:58 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD6C410E02E;
 Wed, 11 Nov 2026 00:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794357591; x=1825893591;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=SuBAgtKwlhunRBT5kF2i+p3wHQjcMZAQHkpfwzefYnA=;
 b=mNT3YIAyEytuMnjD3yzl6Ox/En7dd7yTx3bYhWS1DkMwb0YymzHBfxFa
 GaQzJC/ZqR0nRz8wxxt3KDjcrV4nQxewBprI0t8UqeuYcG/xtZUliHXO4
 PM3xwL095q2OLiv23mtYYm7VTUqDR26c+NW8EMyOA0BrynxFBhLd7Uehq
 s93ex+FiBHJpnip6teIm2Rtb8U66AWi292j+jziYSi4NesfCA3rrBiHl7
 N02kalFw4BD73JD7hem18qqJqAbRfFQ05cRwy4B2TkbWglCU94JFRHFXm
 3TNupOV01boTHdzwCNjI1aNNvYjmZB408rbOrnHksWDzz+YWhhIAkbT9P g==;
X-CSE-ConnectionGUID: kMQk9xnYSOGFZXNYKNOd1Q==
X-CSE-MsgGUID: GhqmYH6vSE2G/4hPoP2VjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3038558"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="3038558"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 16:39:50 -0800
X-CSE-ConnectionGUID: H3k+uiEtSryO0OeS9/Vghg==
X-CSE-MsgGUID: vsjsfVjTTayj9B2/gRHRbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="8859668"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 16:39:51 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 16:39:50 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 10 Nov 2026 16:39:50 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.67) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 16:39:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZoHGJ9QBGIFFCsfqJoHk7eDSGiX1TSbPLVT2NXro8OyPEwBFo+v/hOSBQZSHVK5u3OUyIYJZ5unpQ1Qi4GrwlDS3phINPhq7u7g5eRTrSlMWquLbsW9Sgv9gZTcB4Iber4kGpQ1aAZ/TbmQwKqOX8AQC2gf57a+08hh3vdRWplYvfN0B21ti7EB+vkH0mk3DeC7HiGQccf/vQAriHmV6kzYsMCauRUpi04d/HZeGQfjKHCm3XLfPQRXMw1UIq4K1nfd7J5APnQlbq3hwChh7gZEilQvUP3n0FISEWSrJWpxzIUw6lU7YW1oNmv7BSwx7p/MkayEP9h76hH/1fs9LzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2dkOZIrFaNiz9+ipqR7DUjhr4MZ762asWSniGBhi1Y=;
 b=AwMhAzRNG7EnunJ3yscgyLz+FwT1qM6TobbmxfFsarGHHZb6tfDDcR7v2ECMui91qNRga74Ar33ZeIavO3nS/ru69g30bwvtLIwgIriSObYbSSjEccNZVFKsOue5+Qra2lU8sEocNzAW3gHF4XxgQQOk+m0MFwb99rnZMah+maucDjLX0wtQXnkjQtL0V7ucrHbQHZFsLz3TJWxbSvWtePuo6moWQLA/yNYYlCr+uWuJYeWxlyZMmb6dHsMjcWpJW6es1BadEtMW8kd8x1cxxXjadE5Rb/uCc0D28YhmVqGJLoImNRdkxifhjAhniId/oJbRi/2NUGB0DDJ5AKgw8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by PH8PR11MB9608.namprd11.prod.outlook.com (2603:10b6:510:3a0::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 00:39:42 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 00:39:42 +0000
Date: Tue, 10 Nov 2026 16:39:39 -0800
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
Subject: Re: [PATCH v3 23/33] drm/xe: Defrag using out-of-lock page
 preallocation
Message-ID: <avO5S8WLjcUSGF0f@nvishwa1-desk>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-24-matthew.brost@intel.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260711025619.2540575-24-matthew.brost@intel.com>
X-ClientProxiedBy: BY5PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::27) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|PH8PR11MB9608:EE_
X-MS-Office365-Filtering-Correlation-Id: b4ac7c09-1741-4206-8622-08df3f8c4695
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|1800799024|366016|11063799006|4143699003|56012099006|261022105027099003|261021121427099003|261021123027099003|261026140227099003|261009223027099003|261028144727099003|261102123227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: JgGWY6kbKEk4IPqqUWc3UkIlfkzaKzw58S90IWL3xhLaLI77cLZgaosMrtnNBbWap3FKMv3vzdkJa/eU/ARa+mZQWu2DtjmRB9fjbbD327N7wkQXjKzGUwFiqdtAY42ZcjrjnPy+BxvLm4L3437tRT1pT5vKZmBAQ3N8vJwecvFxoSq5T4znkiirDpwFl18IeTo9VBtYE4NF84twlvXhw2/IDLc+2FCn7Bbqq3gIYNaznM2wAYOLtsS5cSR+oo2C+V/B857CI2w72YjwPZQM7fDYCBZJklO2MS0SYd5dV/CKpFYGV0jvMQMdHu3aDfRSghQPPjSToEkwO4VnjpeHpE8RJOPyA8KCeSLyPE8+6WG6fu5Sj/qGFU062/IRZYlehh8WKUvJquegOnrkxx927qkr2ZTcA49vQxE1n4g4vw0A2tDiHeV8BeElEWIOgR3VfWPvtBOXyklNN+2u3/Yc/dfpkunihAORBvq/Kj6/T2EXeqSiR0TfJW74h/BW8F+U+WoPkEfs0jNRWqYJB27kNFZZrm9YsahTKni2CQaohGZAbLvxK/wvuajwqU+iBAlv9A4Tgzf2UCKPMyoJvMy8fq8CiUDDTrlQRJ43cPz6IO1l2Hb2WpOHzpVfOGUU4IeUHFMcZwFy2ICt9qBMWKA3I/q9tZyo3X1qkAZD7axT884=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(11063799006)(4143699003)(56012099006)(261022105027099003)(261021121427099003)(261021123027099003)(261026140227099003)(261009223027099003)(261028144727099003)(261102123227099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?uoHL+KSgwp02PmNw/d4DEJHrtrE1V6qL99Q6vA2bYq217/alowBB2/AOvj?=
 =?iso-8859-1?Q?aM2sAljDN7zQ+B++EaSQqX1jggTk6jHNfVBNdQobB+D8cKXedtqMPA+8wh?=
 =?iso-8859-1?Q?Q0FUyFUgD7zuMwcb36jfYakn8M9/YG8KMLxAs0b/vRzM+DC4xQvFnHlonF?=
 =?iso-8859-1?Q?ProQK5WE0dj/npXF7IqQcOvDjbPxyPruvCk0X5Cygca0k8kdQaGR2RMcaS?=
 =?iso-8859-1?Q?xPpO9yVvzL9fwSkWbDb74N0dulU0XEB8ZQq4JhsN1x1y60NhiuALpVYy9W?=
 =?iso-8859-1?Q?QbUsoaT7+FAhONrx/UBtjxW3ercUdHoQ1wyTthOoGtbihJTkoR5ZIW0R00?=
 =?iso-8859-1?Q?Gyi4Tb1o7qx34BmKtC5D1lnRX/TDyDlSaAOduGesOhWl84TWbzbxPFBY5B?=
 =?iso-8859-1?Q?0tzur82iAJ0qipzH12KmFMWUDNgU6waYshy0z7bR83GRBpZN5WzGUaVLPu?=
 =?iso-8859-1?Q?FUlN0M6ppHsvAbvYNh/rieJeaoFbZK9i4nCd7D/EUisI2gCZZmmIG/J2Wf?=
 =?iso-8859-1?Q?Qhg7oWogeHaitIot6DIemPJXVdb7WzMEFLql7RPPenhuvheQi1LO/JZWlz?=
 =?iso-8859-1?Q?3oevh/k67ZBV1TgKL34znj+1Z7FSZUzRf91Uz1Jf8ntWciOy6xcWt4uHvA?=
 =?iso-8859-1?Q?q7Pcu182lU3+xqd82YAEEAh7H8geWgy+N/x7hABjIuOti5QKUWnMnarOzV?=
 =?iso-8859-1?Q?K8WobQIebHrZpco8UbHGh7KTW6JYtbXWvnNKu9qMfAX1/bN846XV16tZ3I?=
 =?iso-8859-1?Q?9zGA5JXmU/RzSkJ6yl0df7ktOce6QQWtmiaFUOnRRr8ZiZ7sgPhil+0W/z?=
 =?iso-8859-1?Q?Kfmv446shlLYU2b4ggi/7KMZd/XRDQ1ZHWE6iPXG0atbWdPqzmj0Tpf+6r?=
 =?iso-8859-1?Q?FDEGJu1KjpRPBfxcwC8dvZ0BrVvt4dSkq6vYHHQMNhIbzUhjO+6b1DFwyN?=
 =?iso-8859-1?Q?aEFAtLM89DTb/F+LAW11awVilHxzWjJ/haUC5nzLshfQGjUNCkyr5AH902?=
 =?iso-8859-1?Q?IZkV/oPEGAQul1JH7jvWNFdefQ/46Rj5kis/P27tTlOMtcqOuuLyLWAtk0?=
 =?iso-8859-1?Q?05LX+nMHlfJ2gI0dd1rfGKoRIOzbAhfNufcuSD3gaYabJXLtuUsBDy7IM4?=
 =?iso-8859-1?Q?VvfN3w9kd2IPTM77Yoc/N7sGwCKfkUpiEc0Bn/AqruSpaK5uH6Ds4yGCNk?=
 =?iso-8859-1?Q?ZOnXRILHSmmrkgB9SJo0u5KaYUp+dhhplI+rDVxAPZLwTwhVGMMoWK6Xgr?=
 =?iso-8859-1?Q?5UK+d0AgFhiWoKs8nwEGmvg9o46kLlDmJKKjhPNRM/urzw19KJdbC4ji/+?=
 =?iso-8859-1?Q?F2eAndX20q+ol0cnGHGv7wC9pRw8ljZnb85jMQaIzHy/XY5pU0GRR2SEGp?=
 =?iso-8859-1?Q?KlJ9l1ngTbGHHjZWLWT7bVlVBEl9CGiLXahVnmGdIU4+EKcyepKXZeNEKX?=
 =?iso-8859-1?Q?uMW4E/iXegNmXtkv0OzWrC8RG//BIcmTjp40uPoTHf/AlllSIkssQjJEP0?=
 =?iso-8859-1?Q?IHnAE+e2fOGEMDa8G/TVUjYkKdLoXwKixFRXR4bolW60zwJXGODr/LK5Bq?=
 =?iso-8859-1?Q?QWp3quJgWck46PW0Me2AguYZWuq2NzVpGmQXyj4Cu+QHhRl0quepTwTlUl?=
 =?iso-8859-1?Q?osMjxVhUraXNo+G1PcffZ4l9md0t4AoH2FnLmw8+NLduio0V/f0zvh8Cuf?=
 =?iso-8859-1?Q?Yzf8VXrM54j/enRSC2mkMVXUYAG57XivSusO6EwdC40xXAr7Ign8X8VSRJ?=
 =?iso-8859-1?Q?rukixC3nNsaI/TanvY8f1vGZsxKLhkmz7dzNS1OLfkw7YSMKH0vZCnYIIR?=
 =?iso-8859-1?Q?AtAgFbilzvqcKgQyzI48CBQflgdfttjtRZObYVFQTVTGpT1NQRFj?=
X-Exchange-RoutingPolicyChecked: KZ+HNZjuCjNaAc/+dAjsu53Zw73hD4N221lOMUP0lAOHjL3MRGwQinKoUeumXzx7w+5xybd8VQaHyBiIeqfvZY9U3HEjPFyfcH/Aa9mun3OgpjPUbL1btbsi+MGZJO4X+Z6QwpMF3V+pHPKKuhOYi5KLSHCDPzV1nDljbBoqQGiQjfbZnRZv+0BBfQc1UR1JAH+aKBOTDZc3RodWolw8uHSg147zpBx6+7OiMd/5tgfVgSiqOLZEpE4OcU3i4Ph+pzoK+n+CYDPiKMJBFbUpFQWPuETnI8vbYJeeXvmw3yj8JUcNZblp09RgvzdZGyxMp6wXsa6kO4KNGHvOOuKl5A==
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ac7c09-1741-4206-8622-08df3f8c4695
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 00:39:42.3524 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LhyGTuMjU1USwJW8YMrXBJedD0jDXPf+9xWvsPXn3mj9dmRr3/XicOQQDhbRBnc6BWE0W50U7YKbxNdH1QTHNk+IV/g3QKEDaucsGxp+PfwVVZGBTI1tvHfvR13rt8xF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9608
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

On Fri, Jul 10, 2026 at 07:56:09PM -0700, Matthew Brost wrote:
>Convert xe_bo_defrag_one() to a three-phase scheme that moves the
>expensive beneficial-order allocations out of the BO dma-resv lock:
>
> 1. Under the lock, re-check eligibility, capture the tt cpu-caching and
>    read the exact sub-optimal page count (ttm_tt_suboptimal_pages()),
>    bounded by the run budget.
> 2. Drop the lock and preallocate that many beneficial-order chunks via
>    ttm_pool_prealloc_fill(); reclaim/compaction stalls and the cpu
>    cache mode change both happen here, outside the lock.
> 3. Re-take the lock, re-check, and validate consuming the prealloc bag.
>    Any shortfall harvests the old backing instead of reclaiming, so the
>    move never stalls under the lock; the BO re-queues for a later pass.
>

Assisted-by: LLM

But as lock is released between phase 1 and 3, there can be BO mismatch
between phase-3 and phase-1. More below.

>With both allocation and caching hoisted out, the BO-lock held time
>drops to copy-bound (median ~0.27ms, p95 ~2ms); the remaining tail is
>lock-wait behind active rendering, as intended.
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
>
>---
>
>v3:
> - Use DIV_ROUND_UP_ULL() for the 64-bit preallocation chunk count
>   (Sashiko)
>---
> drivers/gpu/drm/xe/xe_bo.c | 46 +++++++++++++++++++++++++++++++++++++-
> 1 file changed, 45 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
>index 0bdd1c920404..8b89d34f37d4 100644
>--- a/drivers/gpu/drm/xe/xe_bo.c
>+++ b/drivers/gpu/drm/xe/xe_bo.c
>@@ -1258,16 +1258,56 @@ static int xe_bo_defrag_one(struct xe_device *xe, struct xe_bo *bo,
> 		.defrag_bytes_remaining = budget,
> 	};
> 	struct ttm_buffer_object *ttm_bo = &bo->ttm;
>+	struct ttm_pool *pool = &ttm_bo->bdev->pool;
>+	struct ttm_pool_prealloc pp = {};
> 	struct ttm_placement placement;
> 	struct ttm_place place;
>+	enum ttm_caching tt_caching;
>+	unsigned int order, want = 0;
> 	int ret = 0;
>
> 	*consumed = 0;
> 	*needs_more = false;
>
>+	/*
>+	 * Phase 1: under the BO lock, re-check eligibility and estimate how
>+	 * many beneficial-order chunks the move will (re)allocate, bounded by
>+	 * the run's byte budget. Then drop the lock so the high-order, possibly
>+	 * reclaim/compaction stalling allocations happen unlocked.
>+	 */
>+	xe_bo_lock(bo, false);
>+	if (!xe_bo_needs_defrag(bo)) {
>+		xe_bo_defrag_remove(bo);
>+		xe_bo_unlock(bo);
>+		goto out;
>+	}
>+	tt_caching = bo->ttm.ttm->caching;
>+	order = ttm_pool_prealloc_order(pool);
>+	if (order && ttm_bo->ttm) {
>+		u32 suboptimal = ttm_tt_suboptimal_pages(ttm_bo->ttm);
>+		u64 cap = min_t(u64, budget, xe_bo_size(bo)) >> PAGE_SHIFT;
>+
>+		/* Prealloc only the beneficial-order chunks the move replaces. */
>+		want = DIV_ROUND_UP_ULL(min_t(u64, suboptimal, cap), 1UL << order);
>+	}
>+	xe_bo_unlock(bo);

As mentioned above, BO can change after we release the lock here.
So, 'want' can be less than what BO needs. This is probably ok, as if fetching
from prealloc fails, TTM will fall back to fresh alloc.
But if tt_caching changes after releaseing the lock here, it is never checked
in phase-3 and page cache setting will be different than that of the BO.

>+
>+	/* Phase 2: preallocate outside the lock; */
>+	if (want) {
>+		ret = ttm_pool_prealloc_fill(pool, tt_caching, &pp, want);
>+		if (ret || !pp.count) {

'!pp.count' is treated as error but 'pp.count < want' is not. Should we?

Niranjana

>+			ret = ret ?: -ENOMEM;
>+			xe_gt_stats_incr(xe_root_mmio_gt(xe),
>+					 XE_GT_STATS_ID_DEFRAG_FAILED_COUNT, 1);
>+			goto out_err;
>+		}
>+	}
>+
>+	/*
>+	 * Phase 3: re-take the lock, re-check, and validate using the prealloc.
>+	 */
> 	xe_bo_lock(bo, false);
>
>-	/* Re-check eligibility under the BO lock. */
> 	if (!xe_bo_needs_defrag(bo)) {
> 		xe_bo_defrag_remove(bo);
> 		goto unlock;
>@@ -1277,6 +1317,7 @@ static int xe_bo_defrag_one(struct xe_device *xe, struct xe_bo *bo,
> 	place.flags |= TTM_PL_FLAG_TEMPORARY;
> 	placement.num_placement = 1;
> 	placement.placement = &place;
>+	ctx.prealloc = &pp;
>
> 	/*
> 	 * On success the move reallocates the backing at beneficial order and
>@@ -1321,6 +1362,9 @@ static int xe_bo_defrag_one(struct xe_device *xe, struct xe_bo *bo,
>
> unlock:
> 	xe_bo_unlock(bo);
>+out_err:
>+	ttm_pool_prealloc_fini(pool, &pp);
>+out:
> 	return ret;
> }
>
>-- 
>2.34.1
>
