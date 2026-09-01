Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3979DC624D6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 19:43:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34D1810EEDB;
	Tue,  1 Sep 2026 19:43:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="EeH6us9b";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6E8510EED7;
 Tue,  1 Sep 2026 19:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788291824; x=1819827824;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=q0PGroDJD2DVbWnewwbam+zlujsWvfoRHZTe/kYZd24=;
 b=EeH6us9bjIn2wZaXS+fPOYZUapBF1YNqNA/UFV0s82IxQsBtoKghIWcM
 FIpJaZtWxWiWrsyxaF132QLsChPqdC2zczNEhZl/NiIjK/xevJ2Pxr2Nz
 oAAEKUKP0wiEIHJPKEbdAqGuPQ71+2fF0L4W27dCPeXjHDoVpv3YlQbJq
 VpFieKUmD+DYZKj1aUQi25+yBCGnyl6YDOkR6s2k9PkKEobekwxEe8r+F
 7t9S/wN2Nxe1wT9BAcZFAZDGu29fWVllqiRQFZ/7qfSkMZYGKu4DHQRTI
 5sCWJWw9toKjXHN9n+z7QpYcIRwb2C+wEj/+4/aXUkqriGuNX7caSJKfq g==;
X-CSE-ConnectionGUID: Ot32VA5xQ26bsChPEzqoeQ==
X-CSE-MsgGUID: PMRKZ6u9Sl+zYQBTBctB6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="88765019"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="88765019"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 12:43:44 -0700
X-CSE-ConnectionGUID: 5p3TBs35QY2wTy47RXHwTQ==
X-CSE-MsgGUID: yYR469HQQnuI+0PFkIHiQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="269778495"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 12:43:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 12:43:37 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 1 Sep 2026 12:43:37 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.62) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 12:43:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ino69W/Q93VzQ315FYMUuVwRQp6m+t3CVdf+Q4+OrMEvD8+eNPDhSO7OYYrenEwA7i8I+UiKugtf3fnXWiT6neiIVVzpWg4GXID8kWk2yrqCb6VFOO68ro45rbtYG6oUpYM/fZvVbvllyfBzd3V8DzGTagI3MhGd//IRpD7WHjc3ZZ/w/7WnkFYRRLLPOu6u2D4j8CesEP5YWcbvJw7I+Iu2Yro5tIJe2gcq4vEZ/x2DvaFUEaEwhknpfQADMtAiIRjAMntx2J+z8G0DqbhhLDtpj3UOARfeOS2ixxvXXgeHxwMZ1RyXttAexjqBFJscQUZfesxHv0XNG9m1rte8JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=peRf9OPbekVaqSx6fbZ+DqRF2fZ3/6MZwWNe/cU/Hco=;
 b=XGr1iChgyTjVigMxaeAlXtKaksfIR/wPfc6CyYTtyETBrsetH2mVetRxdOWZxDQDemeZKEZmHXQ2LOuVzMnn9sQrWPjsTeM6x4TCXfwa6VYQKtuFgjaN8d6T4ZXYmo3giLFZ0SR9uHA5d/HUPV8Eggev2aJkaB7ZYKjP7mDm1XXIG1BouU2rWDD5cyQ6E6SZFnTW50B7PZo6Rm+LFeVdSKxjHTXRoGHJUFoNXirix6KhWa5K6q5lV6bKrB9+Li5TKgLGz8u/yrD5k2xudWmuraI8H+Uuokqvp/M313Tuj+adIGzQlbNqLvH4KfVJDrqrS0399ItF+A95BsWgxUYt2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by IA1PR11MB8804.namprd11.prod.outlook.com (2603:10b6:208:597::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 19:43:29 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 19:43:29 +0000
Date: Tue, 1 Sep 2026 12:43:25 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Honglei Huang <honghuan@amd.com>
CC: <sima@ffwll.ch>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <himal.prasad.ghimiray@intel.com>,
 <dakr@kernel.org>, <intel-xe@lists.freedesktop.org>, <aliceryhl@google.com>,
 <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>, <Junhua.Shen@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2 2/4] drm/gpusvm: extract drm_gpusvm_dma_map_pages()
 helper
Message-ID: <apcq3TLb0SQ4Qs84@gsse-cloud1.jf.intel.com>
References: <20260901090100.2024933-1-honghuan@amd.com>
 <20260901090100.2024933-3-honghuan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260901090100.2024933-3-honghuan@amd.com>
X-ClientProxiedBy: MW4PR03CA0237.namprd03.prod.outlook.com
 (2603:10b6:303:b9::32) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|IA1PR11MB8804:EE_
X-MS-Office365-Filtering-Correlation-Id: cf422c08-9d60-439b-b3a3-08df08614c03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|4143699003|10067099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: QuiMfmEgm8hOi7v+mdorhonZGJdkSVTUlqO/IIjX0n9TzUzlG3eIVjUqk+er2GmAuA5A344iMwZGLPM8dJSo56Ly5bzJSNV/VFoEQgEpIp6L+rAL5fGfdYjwofrLvu8qnFvejpPwBeR5HjYnfu3qKgI245OYhc9S5z2OlhNvxSmlmkkrlqDxm5DpZTyDjK+cog6TAvG70RP8K61UihvpHhYn+yakIMhuYWE9HQvwgE3r7L4l6CJh+wzfC00GlRYKYjau9SWmSgWUc6A50wMutl/cvbF6/bnrXjVchsOYMKNNvhTvX+WQZ/cYXVvpBZZZ7xqrs4at+ULMBTuQAa2hKK0vhz4TPl6DbsTRias+wFl3bFwxTartyM4RS8Aegc0Lig5dpC93cbWW419XGKRCxqVdEJye59mWhi+121Q/rRHkQaxkS9Bxsj3javnjf2aK0Z21tyXjLcuUqdS2nmDyQ8xHfQ/BiW28dDzLv/GdbOwf3g74tG9T9pz1z9K1S1kbZXE79YVEk0Hwr8NuwLDCs+Kbqfbk/FOv34uO5GpUlB3drvBv05pkddpcRHFI+pqu1vcDjJHhGI36EyvR4B8pqu7AJHh1b6uAxJ/CvIZfMIk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(4143699003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rNNcg5zM9I8PO+VDT3l3hsEDqLh4dNgIXZC9lUoMHkKRaDxOTs/78memanpn?=
 =?us-ascii?Q?vcpeuVmOZnkK+vo6l3V5EW+4kFudue7Fw3UkvbtEVLZVrJg1fWnn5euM6rLE?=
 =?us-ascii?Q?+E2cejHaEGFbdbgco5QU5Et6Ux2SsaqBC4E2Z/magMlrblz7yScW0aZj/YKM?=
 =?us-ascii?Q?0vftfZO1JPiSXQSDu7JItAbrkX03QZ/c58Ei7r9d7gixfzO+KI2b+j8+W/cD?=
 =?us-ascii?Q?detrqcAcgUgqqWdrU2Y0I6WX8U3BsF1/AeSdwsfJWhCT/iE4LzLxHdZQikNQ?=
 =?us-ascii?Q?KV3+1pTtKN/YXFI0gIcPuYlZtIVPvBShEMWqSIesH37xd9pjfJXW3UUK+Eu8?=
 =?us-ascii?Q?sGIflsnEw8AAC0qvmsMKU70LRZYhJ77uYF3jzYpjKy+/OM8NneGI/w/WPprR?=
 =?us-ascii?Q?yFlMR9rrp2yoDxnou/ejd9ZreXPvFMIg4Q2ih5kg7L8EO5O4YPK6L2F0911y?=
 =?us-ascii?Q?ZXgOr8m5IdIGYmRdt+vSW06oYXrOHVXAPHQpRL1HH8oYmUqstEWCUsobI3Xm?=
 =?us-ascii?Q?RRSkjYe1fqexM2oOAIh64stRRG1pOlM9Pksg1Sz1opZvA1O2IlfHUlRTtFZD?=
 =?us-ascii?Q?vsAgBKuQQGqvmolClktTOOX2CcwDuc7NVqZeoH66vodIzOOJqiI/+db0fj3d?=
 =?us-ascii?Q?uMG33bL1cXUhpl6cLlSxMCGXyEZT4dLqDYNNN+IXlo2uYoSd5IZrunL7suHl?=
 =?us-ascii?Q?jpmI1cgaNQXkMbuNk6QN7OwlHZOcREBnq9V2B30zMXidZYjQFi20tIIlvTi6?=
 =?us-ascii?Q?+KOZEku2jkH48qNiruDUEHsF6XMIoUY6pGlcBGqK/vPOpa/5fuFBTrxT+yf5?=
 =?us-ascii?Q?Qt9pyHmqDVXiXomHc3JY4ZL7Ehq176K5T1DL9uz6C2nwExZMNGs8gUpubu9M?=
 =?us-ascii?Q?/A8AZWqRQth5//TvRqFHlTuLfHcW9NET172NSXdvgLwvT+WdGcTdobHxHmOW?=
 =?us-ascii?Q?pEt7/uRaViWQayI+ksrKqesxV1XhzSZwUWmUMXx5R1JsAon6JJOiEzOuWj/s?=
 =?us-ascii?Q?OMfO2DQdW3s5qd96Bqds6LJbUcOrMdgIjzuW4GGshH/GP7Zz1tmK/AiIpXsx?=
 =?us-ascii?Q?3pmV4IoQ+b3Azc1vMsxjK3K9OMC6NFn6jAyusE4QlsTrYbbUmX+XZFgjm8o7?=
 =?us-ascii?Q?0r+RrduZY3ri61I5kLD2tozIb7upFpgdnHAwduoPA6o/ivV1Av4dB3WyDl9D?=
 =?us-ascii?Q?V1JtJviSnY5o0L08izAb/MEKYdbJdUI2ZaepfxMqV6qH5SbTgouvCsnYKc4k?=
 =?us-ascii?Q?FtyrLZNdh30tmr3Kk5BLqFJKx6gDLtmjug/mmZu2IVf5F9F3fedtAZF2tIy5?=
 =?us-ascii?Q?tCj+a24JkpngDifqOJUxHb9TTuH5X6JbMOA+1r5erLjsV9UYR0n+c50b9WkJ?=
 =?us-ascii?Q?Lb47YroTY6+YWs4Z5a235gE4P+q2lSeDHwlPT6lVTcX6Hs2DSXfCN3aLBPm2?=
 =?us-ascii?Q?EUnhAXc5eF16e5NntNAJwg2kJVUs+TChKQu5fCCwhsb/Xw3VMog6Yal6jKCj?=
 =?us-ascii?Q?08I684akTzsc0Y6gAwlXLxkxTmpS65o9NW2Nvs8LalsXH5D7BGjA8/kIqlF9?=
 =?us-ascii?Q?/cTSAQ0bg0EbbTNnE8DUqrHi1PTKee7cciJpZ3rd+wXluHJcytSov9P3DlvL?=
 =?us-ascii?Q?psDvnnPQHJhQKU1Fs7zSbaj5exuUXHfpT9YeR2jFdZGhm1RP2+65cc05mSmx?=
 =?us-ascii?Q?ue2aunIB1SrE6W07fnkyjp0uhA7CARR3JQvMjOQP0hxA1H/saBttB7/dANI0?=
 =?us-ascii?Q?v6USiwPU2nf+8C6S5S89sQTzV3V4Fbo=3D?=
X-Exchange-RoutingPolicyChecked: Lm+kaZ+b4r40S/6EnzM3CMvf20kJ8ToVERZyvVxnUUqf+Tzx7rlWWfvugNpE4zZrKuMe2ETlr5/hLztxYpqnduuSMrT2vLznH1p+QkEBBzQKhCTBu3gE8bk+AwXiNfG9w1CuDdCQ/E08HcxkuWpMJmGDAhtXDORxilMp2zuOAsWO6ScNAP5WgqLG7PNUI+OSlxm3Iuq0EFY79j0MviovcMmh3hihqc+nDcReDv2VwU7/OUutGZTQlT8YXnW7US/pjSn7Rgal7DbISRS/l+jgUJpmQ44oiR889e3/MAZCmIj/BU8CDGJeee2hxMQJqBO6wqQti9ZeoqDifZm99BeVKA==
X-MS-Exchange-CrossTenant-Network-Message-Id: cf422c08-9d60-439b-b3a3-08df08614c03
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 19:43:29.1581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fm6qcfbZ7+FMgJZackeliYLdxO96B8W69q6b5M1/zOz7xJ/q54v/bMNeq8tvyqHDS5OZqPC/7FFL4/vFk0fQ3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8804
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

On Tue, Sep 01, 2026 at 05:00:58PM +0800, Honglei Huang wrote:
> Move the per-device DMA mapping loop of drm_gpusvm_get_pages() into a
> helper drm_gpusvm_dma_map_pages(). The mapping logic is only moved, not
> changed, so there is no functional change.
> 
> The helper maps the already-faulted pfns into one drm_gpusvm_pages
> instance under the notifier lock and unwinds its own partial mapping on
> error. The HMM fault and the notifier retry loop stay in get_pages()
> common code rather than being pushed down to drivers, so no driver has
> to reimplement the subtle fault and retry logic.
> 
> With the mapping isolated per instance, get_pages() can later fault once
> and DMA map an array of drm_gpusvm_pages plus a count, one per owning
> drm_device.
> 
> Suggested-by: Matthew Brost <matthew.brost@intel.com>

For some reason, Sashiko didn't run on this particular patch [1]. It
would be good to have it run through the tooling in case I'm missing
something.

That said, I can't spot anything incorrect, and this looks like a solid
cleanup.

With that:
Reviewed-by: Matthew Brost <matthew.brost@intel.com>

[1] https://sashiko.dev/#/patchset/20260901090100.2024933-1-honghuan%40amd.com

> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>  drivers/gpu/drm/drm_gpusvm.c | 225 ++++++++++++++++++++---------------
>  1 file changed, 129 insertions(+), 96 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index b507de539e6..89c3061d8ef 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
> @@ -1442,115 +1442,41 @@ static bool drm_gpusvm_pages_valid_unlocked(struct drm_gpusvm *gpusvm,
>  }
>  
>  /**
> - * drm_gpusvm_get_pages() - Get pages and populate GPU SVM pages struct
> + * drm_gpusvm_dma_map_pages() - DMA map one drm_gpusvm_pages instance
>   * @gpusvm: Pointer to the GPU SVM structure
> - * @svm_pages: The SVM pages to populate. This will contain the dma-addresses
> - * @mm: The mm corresponding to the CPU range
> - * @notifier: The corresponding notifier for the given CPU range
> - * @pages_start: Start CPU address for the pages
> - * @pages_end: End CPU address for the pages (exclusive)
> + * @svm_pages: The SVM pages instance to populate with dma-addresses
> + * @pfns: The already-faulted pfn array (size @npages)
> + * @npages: Number of pages in the CPU range
>   * @ctx: GPU SVM context
> + * @dma_dir: DMA data direction for the mappings
>   *
> - * This function gets and maps pages for CPU range and ensures they are
> - * mapped for DMA access.
> + * Map the faulted @pfns into @svm_pages for DMA access through its owning
> + * drm_device. Must be called under the notifier lock. On failure this unwinds
> + * the partial mapping of this instance before returning.
>   *
>   * Return: 0 on success, negative error code on failure.
>   */
> -int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
> -			 struct drm_gpusvm_pages *svm_pages,
> -			 struct mm_struct *mm,
> -			 struct mmu_interval_notifier *notifier,
> -			 unsigned long pages_start, unsigned long pages_end,
> -			 const struct drm_gpusvm_ctx *ctx)
> +static int drm_gpusvm_dma_map_pages(struct drm_gpusvm *gpusvm,
> +				    struct drm_gpusvm_pages *svm_pages,
> +				    unsigned long *pfns,
> +				    unsigned long npages,
> +				    const struct drm_gpusvm_ctx *ctx,
> +				    enum dma_data_direction dma_dir)
>  {
> -	struct hmm_range hmm_range = {
> -		.default_flags = HMM_PFN_REQ_FAULT | (ctx->read_only ? 0 :
> -			HMM_PFN_REQ_WRITE),
> -		.notifier = notifier,
> -		.start = pages_start,
> -		.end = pages_end,
> -		.dev_private_owner = ctx->device_private_page_owner,
> -	};
> -	void *zdd;
> -	unsigned long timeout =
> -		jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
> -	unsigned long remaining;
> +	void *zdd = NULL;
>  	unsigned long i, j;
> -	unsigned long npages = npages_in_range(pages_start, pages_end);
> -	unsigned long num_dma_mapped;
> +	unsigned long num_dma_mapped = 0;
>  	unsigned int order = 0;
> -	unsigned long *pfns;
>  	int err = 0;
> -	struct dev_pagemap *pagemap;
> +	struct dev_pagemap *pagemap = NULL;
>  	struct drm_pagemap *dpagemap;
>  	struct drm_gpusvm_pages_flags flags;
> -	enum dma_data_direction dma_dir = ctx->read_only ? DMA_TO_DEVICE :
> -							   DMA_BIDIRECTIONAL;
>  	struct dma_iova_state *state = &svm_pages->state;
>  
> -	if (!svm_pages->drm)
> -		return -EINVAL;
> -
> -retry:
> -	remaining = timeout - jiffies;
> -
> -	if (time_after_eq(jiffies, timeout))
> -		return -EBUSY;
> -
> -	hmm_range.notifier_seq = mmu_interval_read_begin(notifier);
> -	if (drm_gpusvm_pages_valid_unlocked(gpusvm, svm_pages))
> -		goto set_seqno;
> -
> -	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
> -	if (!pfns)
> -		return -ENOMEM;
> -
> -	if (!mmget_not_zero(mm)) {
> -		err = -EFAULT;
> -		goto err_free;
> -	}
> -
> -	hmm_range.hmm_pfns = pfns;
> -	err = hmm_range_fault_unlocked_timeout(&hmm_range, remaining);
> -	mmput(mm);
> -	if (err)
> -		goto err_free;
> -
> -	if (!svm_pages->dma_addr) {
> -		svm_pages->dma_addr =
> -			kvzalloc_objs(*svm_pages->dma_addr, npages);
> -		if (!svm_pages->dma_addr) {
> -			err = -ENOMEM;
> -			goto err_free;
> -		}
> -	}
> -
> -	*state = (struct dma_iova_state){};
> -	svm_pages->state_offset = 0;
> -
> -	/*
> -	 * Perform all dma mappings under the notifier lock to not
> -	 * access freed pages. A notifier will either block on
> -	 * the notifier lock or unmap dma.
> -	 */
> -	drm_gpusvm_notifier_lock(gpusvm);
> +	lockdep_assert_held(&gpusvm->notifier_lock);
>  
>  	flags.__flags = svm_pages->flags.__flags;
> -	if (flags.unmapped) {
> -		drm_gpusvm_notifier_unlock(gpusvm);
> -		err = -EFAULT;
> -		goto err_free;
> -	}
> -
> -	if (mmu_interval_read_retry(notifier, hmm_range.notifier_seq)) {
> -		drm_gpusvm_notifier_unlock(gpusvm);
> -		kvfree(pfns);
> -		goto retry;
> -	}
>  
> -	zdd = NULL;
> -	pagemap = NULL;
> -	num_dma_mapped = 0;
>  	for (i = 0, j = 0; i < npages; ++j) {
>  		struct page *page = hmm_pfn_to_page(pfns[i]);
>  
> @@ -1666,17 +1592,124 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  	/* WRITE_ONCE pairs with READ_ONCE for opportunistic checks */
>  	WRITE_ONCE(svm_pages->flags.__flags, flags.__flags);
>  
> +	return 0;
> +
> +err_unmap:
> +	svm_pages->flags.has_dma_mapping = true;
> +	__drm_gpusvm_unmap_pages(gpusvm, svm_pages, num_dma_mapped);
> +	return err;
> +}
> +
> +/**
> + * drm_gpusvm_get_pages() - Get pages and populate GPU SVM pages struct
> + * @gpusvm: Pointer to the GPU SVM structure
> + * @svm_pages: The SVM pages to populate. This will contain the dma-addresses
> + * @mm: The mm corresponding to the CPU range
> + * @notifier: The corresponding notifier for the given CPU range
> + * @pages_start: Start CPU address for the pages
> + * @pages_end: End CPU address for the pages (exclusive)
> + * @ctx: GPU SVM context
> + *
> + * This function gets and maps pages for CPU range and ensures they are
> + * mapped for DMA access.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
> +			 struct drm_gpusvm_pages *svm_pages,
> +			 struct mm_struct *mm,
> +			 struct mmu_interval_notifier *notifier,
> +			 unsigned long pages_start, unsigned long pages_end,
> +			 const struct drm_gpusvm_ctx *ctx)
> +{
> +	struct hmm_range hmm_range = {
> +		.default_flags = HMM_PFN_REQ_FAULT | (ctx->read_only ? 0 :
> +			HMM_PFN_REQ_WRITE),
> +		.notifier = notifier,
> +		.start = pages_start,
> +		.end = pages_end,
> +		.dev_private_owner = ctx->device_private_page_owner,
> +	};
> +	unsigned long timeout =
> +		jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
> +	unsigned long remaining;
> +	unsigned long npages = npages_in_range(pages_start, pages_end);
> +	unsigned long *pfns;
> +	int err = 0;
> +	enum dma_data_direction dma_dir = ctx->read_only ? DMA_TO_DEVICE :
> +							   DMA_BIDIRECTIONAL;
> +
> +	if (!svm_pages->drm)
> +		return -EINVAL;
> +
> +retry:
> +	remaining = timeout - jiffies;
> +
> +	if (time_after_eq(jiffies, timeout))
> +		return -EBUSY;
> +
> +	hmm_range.notifier_seq = mmu_interval_read_begin(notifier);
> +	if (drm_gpusvm_pages_valid_unlocked(gpusvm, svm_pages))
> +		goto set_seqno;
> +
> +	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
> +	if (!pfns)
> +		return -ENOMEM;
> +
> +	if (!mmget_not_zero(mm)) {
> +		err = -EFAULT;
> +		goto err_free;
> +	}
> +
> +	hmm_range.hmm_pfns = pfns;
> +	err = hmm_range_fault_unlocked_timeout(&hmm_range, remaining);
> +	mmput(mm);
> +	if (err)
> +		goto err_free;
> +
> +	if (!svm_pages->dma_addr) {
> +		svm_pages->dma_addr =
> +			kvzalloc_objs(*svm_pages->dma_addr, npages);
> +		if (!svm_pages->dma_addr) {
> +			err = -ENOMEM;
> +			goto err_free;
> +		}
> +	}
> +
> +	svm_pages->state = (struct dma_iova_state){};
> +	svm_pages->state_offset = 0;
> +
> +	/*
> +	 * Perform all dma mappings under the notifier lock to not
> +	 * access freed pages. A notifier will either block on
> +	 * the notifier lock or unmap dma.
> +	 */
> +	drm_gpusvm_notifier_lock(gpusvm);
> +
> +	if (svm_pages->flags.unmapped) {
> +		drm_gpusvm_notifier_unlock(gpusvm);
> +		err = -EFAULT;
> +		goto err_free;
> +	}
> +
> +	if (mmu_interval_read_retry(notifier, hmm_range.notifier_seq)) {
> +		drm_gpusvm_notifier_unlock(gpusvm);
> +		kvfree(pfns);
> +		goto retry;
> +	}
> +
> +	err = drm_gpusvm_dma_map_pages(gpusvm, svm_pages, pfns, npages, ctx,
> +				       dma_dir);
>  	drm_gpusvm_notifier_unlock(gpusvm);
> +	if (err)
> +		goto err_free;
> +
>  	kvfree(pfns);
>  set_seqno:
>  	svm_pages->notifier_seq = hmm_range.notifier_seq;
>  
>  	return 0;
>  
> -err_unmap:
> -	svm_pages->flags.has_dma_mapping = true;
> -	__drm_gpusvm_unmap_pages(gpusvm, svm_pages, num_dma_mapped);
> -	drm_gpusvm_notifier_unlock(gpusvm);
>  err_free:
>  	kvfree(pfns);
>  	if (err == -EAGAIN)
> -- 
> 2.34.1
> 
