Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0BF1CC6B2C
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:09:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7D4310E561;
	Wed, 14 Oct 2026 19:09:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DD3F10EABD;
 Wed, 14 Oct 2026 19:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792004984; x=1823540984;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=xwPLlxi1f4sMYrzVr6b+KkzSln46HBE2mYs3pGbw1uI=;
 b=HT0q6QjjYdku2qdYzwnFFW1Bh1VxZC5F4jLVLZeIu84hwv1qwUb9wmtq
 qkyqYAtVxTCwMfoFCHkgG0VpnqmHQw1c5Sw6p3RjjaKFXMvlHOoo9qYRz
 9dPj3JAhUlsm0r9mBNu71DBETf/77SbEReg+tlBK5S9xwdetJmmz2vcry
 GWGkuB4ecoLNK4yVoqkJwKAgPT7avG3guuXJejuGcdCRQ4cnsjxUon+ka
 T+FYH3DA8R8+xvsrp8uXI97Bd21hnxiUAiZT3qavDwzgjldqWbo2vCkNp
 eDNXLPIOrlC7v45DTjjg3m81kE7ZGxFiIo5Zfb85levXNRs1MKYdaFBpP w==;
X-CSE-ConnectionGUID: 3vxKQLJlTra2Nb4ofnBqbg==
X-CSE-MsgGUID: 1oFhdy2FQ3SvBDAAMP6XCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="641764"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="641764"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 12:09:42 -0700
X-CSE-ConnectionGUID: AMmdtoyWTyipxGjPC3IkRQ==
X-CSE-MsgGUID: sOMjtUrcQKSkUwavFhi+mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1731632"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 12:09:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 12:09:39 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 12:09:39 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.15) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 12:09:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SrSxUfXC+3XIrMxxOlEnl7/vMO4ktkLcVxV4+KghSQjIt8GfVUOWSuMpBbtAubjcKOQxCHohGnarbMH8R8T9Et8luEgOqQApC3KOdyuobRYwpUP8jDII0RLMy/9WrXxxBn5KJdj8YjUczLH+tiUrDP5bSBr35zLnAuJIjbNW2eJcdzS5bMJlDt5XzxIMdiAwb91iHH6PR0D9R4DgMe1bZEZy9N9MzMbV+2XGaBPbG5iNkLvbk24XpDemm4X7aM2knt9VINYG6y5L+Ly1H57151ZH3Fs+eyXef5cIaotBo5yQ8L3hccrhI2ZbDxHrA7dlV+M/T5lzfVRb4ARrm5isSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qqXhE68/IEFQuXz9RsbF38x+VRnBiehUfzAJJL3ewk=;
 b=NurxNiJBmkEWTiPDKmE9/Xzkqm1k9jAS6/9qK6GIat8ROmX5m+In4LkLBC0Zxa9ZC7Du1Xlw3DVaO1JRJhYL18C1ICHhtOjz5cN0NA+zg0luOF6Mni7Lt5PAjXzHASV2NmaG9lkj2cLUwy2/kVOytsys9KxFKJAqJ7sz709j2Z0sYoB3xPqk9XkfZdVW7gnzvAkZ4hlBUgJuGIuyQqe5pk6V+W9iejfn+3R5sQQXtLPvlRLatHS4SVxjGCQktDP4bT8BsSHP0y9twbWqj3lKJZGSLqs7qWs/g6/S1V2qHPhECNp0sjcKTqthDvRiFQcFAoR6WS5xvdbM/m4NvwRIrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by SJ0PR11MB8272.namprd11.prod.outlook.com (2603:10b6:a03:47d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 19:09:36 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 19:09:36 +0000
Date: Wed, 14 Oct 2026 12:09:33 -0700
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
CC: <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <matthew.brost@intel.com>
Subject: Re: [PATCH v2 0/6] drm: consolidate self-imported PRIME dma-buf
 detection
Message-ID: <as_TbUzy-xM7v4Vt@nvishwa1-desk>
References: <20261013010614.1516799-8-niranjana.vishwanathapura@intel.com>
 <d93fe93e-628c-4551-9907-9872c150e530@suse.de>
 <as54iEp-iqR0ZJWs@nvishwa1-desk>
 <6184d9de-0936-43ad-b9c9-496fc65212d9@suse.de>
 <as-9MFZcI9DR5HWI@nvishwa1-desk>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <as-9MFZcI9DR5HWI@nvishwa1-desk>
X-ClientProxiedBy: PH8P223CA0025.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::13) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|SJ0PR11MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: ce4326c3-ddd1-4bc0-009a-08df2a26b01d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|56012099006|11063799006|4143699003|261009221227099003|261009223027099003|18002099003|10067099003|22082099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info: BBo9VZHO5OuQAdvXSB9+bodWR95XoiDopqceGn8Y4Q98PkWEeUctrW8lL7kgm7MaiiZyRozPySazMVgPNOsfziqjYxLyY0Rt8CA+FMkhQPLl2Sn+OiKZLNLi8GiajDX+rPmrjviE+L4sUpbHU8vZhjADLi3Hhp6kQF7fv8HDKrYgQk154hq+jInXJlgPi8Usc6aZMoeQfPWvMur+2SaC4oinD23HDb55TUEuYF16Y7CM93+IvVoq9T1O+x9QU+Cq0ftpuLJ0AxTKXlZFUgZZsJrnkRIU0Nzq+pKMF6zqcYEBVsdUvj/xXahJgy+3hS8k7hgb4POHcBPkcHsDZkSDv2ZOwXxIPfl4Cj2xZ01kKiVdqEdj4ibJRT4KlomwsZohb5soLPb2r3H7ORgwOTtMHg+3ibkGRlOO6griLoh2Nn4l/zYg5TQLHdWYFywh9xjeFJGj5+ILO1/SpgLpdTuNt/CcvWazFquFTB0NQd+sz+ht6ayBXJG24t5jnUcGmwvplZEt3/vCvPk2N75UR/lAp3k2HaYH2H07+0zjEHmpuRwB3Uf3XW4P3o+6orWpHUJfAyijN8XoVlj6PvyK2AnZiGA5jXkiitk3tZhClvScqCM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(11063799006)(4143699003)(261009221227099003)(261009223027099003)(18002099003)(10067099003)(22082099003)(6133799003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?6l1uQ2W3yHsSQO3wCaVL5oKunYeQrtGIOpzrMm/g0ZfWd2fk9iqgotkyoJ?=
 =?iso-8859-1?Q?uyKIlRlsbg/ST48A3cmpTJHHQVDphDNg1r56ssJSTcNx7vJo16jHVUNqtE?=
 =?iso-8859-1?Q?ZKIYt75pSjPM7TYHm8Z+kPaO7M005rIt4EC62gejFXpmKTJree1xOqGmtg?=
 =?iso-8859-1?Q?IvttFGqgB7U/+71Et7l8BXGe/WxJdqEMz+ImRmcqHJ4d+dcDcejwLhcvEm?=
 =?iso-8859-1?Q?E9Jd1pDBxpCCSatYvWmw92HtAXMzq9B0hOqADYa2zF6lbVDYPbIWKZtr/I?=
 =?iso-8859-1?Q?C6Ad/uxSqxXahuHY1Qr0NlzMdJ+SAkMK+DllqDRlgR2P5gQ1YUmgLJvBdY?=
 =?iso-8859-1?Q?IAxkmk40f/NHu8sLhVg74unltgb0r8KODSdvQKejqFvH6g3cZnLbvBJ7zK?=
 =?iso-8859-1?Q?KKD1zNgv7zV92M4JZ/+7YGARbKOMmtSIuuVjJSnAyfGwk1+vQqocyeuprf?=
 =?iso-8859-1?Q?VsqS6utppRDE9WWPTV1ufF93DKArZsovSu1DAa5gC80YOvAdRfsRSVJXKN?=
 =?iso-8859-1?Q?kq+fwu7VqTphU5Kn9iA58XBIFFYhcMjFa17+jdGe0Hr/OhlPGdeppHOlxV?=
 =?iso-8859-1?Q?6G/0DgUHmHXkduFgNCuegsLs+Z1bBf8smLXzaNfSKNO19NUZY1taIG83Zk?=
 =?iso-8859-1?Q?JFaGXn8i6jLoM3jyj+KUlsSbl4MaSlqqOwa3t/nNaO/Zzw33GPVMvMvKpq?=
 =?iso-8859-1?Q?sToaGdX5MMn+5aKkYAXWgDNb2gSEBPzPAlKcgaxHEm+4iXn1tlthFYODG5?=
 =?iso-8859-1?Q?8pvoX8K4CtzyrSQm902tu4tY+6UeTUQuegLxuSrytzPW84kA3lqi/UbTHq?=
 =?iso-8859-1?Q?5fVmrT2TR8WIROkpUIdsffvHUtYgMiXV0hzL6Yar82W4hMs9d36DTKl6Wq?=
 =?iso-8859-1?Q?X++cc5aiCrkO/SoEb5ImBiT+L3otd99avTRJdwnc4PX6i1ALdFkK+KV98B?=
 =?iso-8859-1?Q?PB/ine32KevWE/i/YGvq5ExxBblA1dhtSVSB/MLOoBtRRrNS8j9V5sec7R?=
 =?iso-8859-1?Q?jtsjL/ZFbWoX3NhGfQEcQCM4+2XpO9B8eJqMjZGyMBxEfu2VOanG1CjYBX?=
 =?iso-8859-1?Q?lBxDMeqY3BqRIigu+QOFlQ8dGNPbmC3C8o5lK9+F5KjXvba9TGJkvEv4g8?=
 =?iso-8859-1?Q?k2hglVTuboV32878qqQzVEPpHTbVhw3k8vzdnr+zo1Qsa88NqvoD80V6Yk?=
 =?iso-8859-1?Q?JqGi06IsI1x8KaVfS9z/ZhD0MfGO+0fpV67EKF/Xbl1h2nP2Qun17rDzXT?=
 =?iso-8859-1?Q?kBdcfDsCKC/D5/lpwQUEnn40JxsEq0mudlB5/iudQ2f7LYkM2c6bzvxYM/?=
 =?iso-8859-1?Q?UxjmrFh+UTY72fjP6suX90rKKUCWGlg0gjyCdhlMWa1D4i80LYKeWxoG6X?=
 =?iso-8859-1?Q?7yh1VIIPg/F9s/1nTAK5EbZc9frARryjlFun2CHGoUA0Orn9t9pih7e+Z6?=
 =?iso-8859-1?Q?9oc1I4jn5OiTkiUmv/5oKmeRCVGAJ8wrUS8K9DkcUWnKQwowSGv9qObim4?=
 =?iso-8859-1?Q?RE1aIdJ80sco+pWu3s+Cfzvzf/QlYnobaPR9/zULjS00XKEIdgCVA/VPox?=
 =?iso-8859-1?Q?8CgWgLM2CjXvzOkfKAai6G96EKdLY5jhJmPDSarKOEjJAXpjOfkWw/tV3h?=
 =?iso-8859-1?Q?wpfORbPZLJzUjV0MncNwGarq8Zuu/+VDnzIr5WtO1gi1Z/ajyX4tpSaZdK?=
 =?iso-8859-1?Q?Oxc0ZzukFAJcO4zB0htpHZZWdnbC+yP6qZ+Reh1EXIWnG1K2J5FEUlEtl5?=
 =?iso-8859-1?Q?DD4sXAcc/CKfADUu/fz4RQ3fUCWBAwEvlQ0pywg1Rz5dmy6FoN8W0lzFr3?=
 =?iso-8859-1?Q?Yw7kRbMvII6ClHh+eHQJ4C0P2oNNxmcv+28jW0N+02vam/q3Ixh4?=
X-Exchange-RoutingPolicyChecked: hJG0a76A+9ZkmxK2bqyLVzY7c3lxId4zSlL94sj3i8PO3IN5SyIv++svdDG11tIFUvi1INYv8ZH2Vl5ix7Z19QP/vxX8aGQ7LPtd/JsYTucK7fpP+HNe59Wu+dbrPm2v7Mxd6YZD9cRA64991TeVGJRThGx0xZluJMZDY+nxWtmoCjGbWi4j8PoIavgdT4pe8h7H23zqb34GH5oO7z7yDtr1+kWnF42jAEF8XIniBla9bYtvr3CBbVnsjIiAJn2E1O0IKqkvcqR7brKUX9Tbr056AYt7jzAbl34soiUHOxic4JJwdNspppwdOZa1scT6S18W9E0vA0Sn+yIPJyKvRA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4326c3-ddd1-4bc0-009a-08df2a26b01d
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 19:09:36.2903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MFk/l3xX6zBAEN3AswyZwUOu1H800/b07gDvNYp4Uv3K3ipJ19/LwippgHpP08wEj3qqct5wh8Q0jSWj0dSKSTUwV14IEMgO+gaoR21WQdF3B7S272PdrLbzXcaDd2qV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8272
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

On Wed, Oct 14, 2026 at 10:34:42AM -0700, Niranjana Vishwanathapura wrote:
>On Wed, Oct 14, 2026 at 09:31:00AM +0200, Thomas Zimmermann wrote:
>>Hi
>>
>>Am 13.10.26 um 20:29 schrieb Niranjana Vishwanathapura:
>>>On Tue, Oct 13, 2026 at 09:17:17AM +0200, Thomas Zimmermann wrote:
>>>>Hi,
>>>>
>>>>I don't think we should merge this series.
>>>>
>>>>Testing for the functions struct is a hack, which we do because 
>>>>it works in practice. We don't any other good identifier for the 
>>>>source of the imported dma_buf. We want to hide this from the 
>>>>outside world as much as possible. Putting it into an exported 
>>>>interface goes in the wrong direction.
>>>>
>>>
>>>Ok, I understand. Given it is just a utility function that is helpful
>>>across drivers, would defining drm_gem_prime_self_import() as a static
>>>inline helper in drm_prime.h is permissible?
>>
>>It's not about the EXPORT_SYMBOL. Please see my reply to Matthew for 
>>details.
>>
>>I think it would be OK to do something like this in the header file:
>>
>>static inline bool __drm_gem_is_exported_dma_buf(dev, ops, dma_buf)
>>{
>>    /* do the prime test here, but with the given ops. */
>>}
>>
>>Double-underscore prefix in symbols means 'implementation detail'. 
>>The existing drm_gem_is_prime_exported_dma_buf() can be implemented 
>>on top; existing callers should continue to use 
>>drm_gem_prime_eported_dma_buf().  Other drivers can use the new 
>>helper for the test, as they use the same logic internally.
>>
>
>drm_gem_is_prime_exported_dma_buf() do not take object reference.
>The code duplicated in multliple drivers take object reference. So, we
>need the helper routine to take object reference.
>

I posted a newer series by moving drm_gem_prime_self_import() to the
drm_gem.h function.

And though using dma_buf_ops here is a plumbing due to lack of proper
driver identifier, idea is to have the drivers use this helper routine.
So, instead of a '__' naming prefix, I have added an explicit comment
about it in function kernel-doc.

Niranjana

>Niranjana
>
>>Best regards
>>Thomas
>>
>>
>>>
>>>Niranjana
>>>
>>>>Best regards
>>>>Thomas
>>>>
>>>>
>>>>Am 13.10.26 um 03:06 schrieb Niranjana Vishwanathapura:
>>>>>Detecting that a PRIME dma-buf being imported was exported by the same
>>>>>DRM device is a pattern currently open-coded in many drivers (compare
>>>>>dma_buf->ops against the driver's own ops, check obj->dev == dev, then
>>>>>return the GEM object with an extra reference). This series 
>>>>>adds generic
>>>>>helpers for it and converts several drivers to use them.
>>>>>
>>>>>Patch 1 adds drm_gem_prime_self_import(dev, dma_buf, ops): for 
>>>>>a dma-buf
>>>>>self-exported via the given ops, it returns the backing GEM object with
>>>>>a reference, letting a driver short-circuit the generic PRIME 
>>>>>import and
>>>>>skip the extra dma-buf file reference. Patch 2 converts Xe to it.
>>>>>
>>>>>Patch 3 adds drm_gem_prime_dma_buf_to_gem(), a thin wrapper 
>>>>>that uses the
>>>>>core PRIME ops, and replaces the 
>>>>>drm_gem_is_prime_exported_dma_buf() bool
>>>>>predicate with it so the shmem importer resolves the object directly
>>>>>(the sole caller already wanted the referenced object).
>>>>>
>>>>>Patches 4-6 convert panthor, panfrost and amdgpu to
>>>>>drm_gem_prime_self_import(), removing the duplicated open-coded checks.
>>>>>
>>>>>No intended functional change.
>>>>>
>>>>>Assisted-by: GitHub-Copilot:claude-opus-4.8
>>>>>Signed-off-by: Niranjana Vishwanathapura 
>>>>><niranjana.vishwanathapura@intel.com>
>>>>>
>>>>>Farah Kassabri (2):
>>>>>  drm/gem: add helper to detect self-imported PRIME dma-bufs
>>>>>  drm/xe/dma-buf: Use drm helper to detect dma-buf self-import
>>>>>
>>>>>Niranjana Vishwanathapura (4):
>>>>>  drm/gem: add drm_gem_prime_dma_buf_to_gem() self-import helper
>>>>>  drm/panthor: use drm_gem_prime_self_import() helper
>>>>>  drm/panfrost: use drm_gem_prime_self_import() helper
>>>>>  drm/amdgpu: use drm_gem_prime_self_import() helper
>>>>>
>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 14 +---
>>>>> drivers/gpu/drm/drm_gem_shmem_helper.c      | 14 ++--
>>>>> drivers/gpu/drm/drm_prime.c                 | 74 +++++++++++++++------
>>>>> drivers/gpu/drm/panfrost/panfrost_gem.c     | 10 +--
>>>>> drivers/gpu/drm/panthor/panthor_gem.c       | 10 +--
>>>>> drivers/gpu/drm/xe/xe_dma_buf.c             | 23 ++++---
>>>>> drivers/gpu/drm/xe/xe_dma_buf.h             |  2 +
>>>>> include/drm/drm_prime.h                     |  8 ++-
>>>>> 8 files changed, 91 insertions(+), 64 deletions(-)
>>>>>
>>>>
>>>>-- 
>>>>-- 
>>>>Thomas Zimmermann
>>>>Graphics Driver Developer
>>>>SUSE Software Solutions Germany GmbH
>>>>Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
>>>>GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)
>>>>
>>>>
>>
>>-- 
>>--
>>Thomas Zimmermann
>>Graphics Driver Developer
>>SUSE Software Solutions Germany GmbH
>>Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
>>GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)
>>
>>
