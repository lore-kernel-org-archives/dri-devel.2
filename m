Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05295CDE008
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 08:14:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D57D010F4D6;
	Fri, 26 Jun 2026 08:14:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hzXF7PUk";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7359E10F4D3;
 Fri, 26 Jun 2026 08:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782461647; x=1813997647;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=gZya5T7a9cCEzEUqG9MR4k8TtbLs7YNiBO9Z3kGgPGI=;
 b=hzXF7PUklD+eYfTAZbsCuPpKd+lk7QGUsHlMCf3wEJRE8y53RLfVBZ6T
 8hCM87JUrMkern8VoSoakcjb9lQNn7FE7JGkAu5893/hLEMS/6LXTYfYs
 5xi5FCflDIZnpM4jodob4p25wUKDZi3qff0L7B96dPWZWPrzpZrLsa2nG
 j9KwBooh6WywhExyB4WpeO3x9nbfvoc/8sLUmvbwJwg9Jgk7EsHelVYsp
 iQr3kv8LQP35eq04/TXOabucdufHoxKO5aTfSg2PS16j7z+xTImrx/nj5
 a+TYC4qU0u5YV2/qHCc/7Ul6BJMNcVPqACsNn7L7zx9sNN99wpSODu2Ps g==;
X-CSE-ConnectionGUID: lX5yFmrSTzO8SeauBLZeYw==
X-CSE-MsgGUID: TrYwdjRvQ6Omj5rBTKde3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="93606734"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="93606734"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 01:14:06 -0700
X-CSE-ConnectionGUID: ox7ijuVTS4emC003Iae6yw==
X-CSE-MsgGUID: LXo1+zr+RZWqAwbGtUBwCA==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 01:14:06 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 01:14:05 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 26 Jun 2026 01:14:05 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.26) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 01:14:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nbLpCioIvDqWf2d/Xs+jE9lwMwrbAxd1N6n99224dETARnfl8VuvUBXR77WxnT46cy6TzAamrPkZ8jtAabNjG7SGCQfZCEL8NhNT/G5pchyOZTu3/7V7B5n08IsNGE5e2uu7ND7WX9Bs8TR1JwGo3nbohpckUxWYBlvHc8/2g0Z2rJ+bVD6Ngs3tZ91TvNsJxSPbapBghp3B4W8cMZ3R3BWH5pJBsr/DuFGr7GxMavcLp3kFzZNJRyaToE6l8TIp+cfX2OBEgra7q7Yz3t9lmImL7YV5ve2cpVnzcxVDRZIrQbmAyhMs/TYStqyEwGqNuxbhOEExCUBb4ZVIyhVqCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdTAVAcB/xPg2aUbsRocMgetcjgpug78KLLTSdzUgz8=;
 b=H0zCnDxCNs3MXsOCwSn3YqSLV2p/zKGeE2XEWcOuFUN9lgQ4OZ/KI7IZlRj0F0yZJlajsXFXdQ0XqphYkJmFGmEkXXd/GsED9335OY/f7TuPt8FJG/BDmC1YqlPw3sTy3DpQPU40UywY9V77ca2PmYG54ydgF917CU/0iV90lW1fYCMQFWsxnggAPzQhCg1NZm+v8MknBPpY44sjexi5DBYhHgXN4znFlIr00zP7csVOpWjYKRBCHb7V7hrxJJyROlHbSXXRJq/HIVwQ3Tzw8hVPQz0jy58D+/FSOy0GJ/CXIp8YNL3pJOWoIPq1JuwKqutlbJ4tBgi1hMgMTPASrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SA0PR11MB4766.namprd11.prod.outlook.com (2603:10b6:806:92::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 08:14:00 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 08:14:00 +0000
Date: Fri, 26 Jun 2026 01:13:57 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Honglei Huang <honglei1.huang@amd.com>
CC: <sima@ffwll.ch>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>,
 <Jenny-Jing.Liu@amd.com>, <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>,
 <Ray.Huang@amd.com>, <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>,
 <Yiru.Ma@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: Re: [PATCH v3 1/5] drm/gpusvm: split MM state flags out of
 drm_gpusvm_pages_flags
Message-ID: <aj40xcAiXlj6/z6S@gsse-cloud1.jf.intel.com>
References: <20260618080902.1527255-1-honglei1.huang@amd.com>
 <20260618080902.1527255-2-honglei1.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260618080902.1527255-2-honglei1.huang@amd.com>
X-ClientProxiedBy: SJ0PR03CA0177.namprd03.prod.outlook.com
 (2603:10b6:a03:338::32) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SA0PR11MB4766:EE_
X-MS-Office365-Filtering-Correlation-Id: e9d18aba-0a7b-401a-7397-08ded35ae0a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|7416014|1800799024|6133799003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +75ml/qkqiIyahg3CFUeEn850GQFlRdXhnHSAqDUJTAXVnzlhnbUUwVgLHIuTxZ8iD6xoW7NxLoZV7WQeBaNUTLhJwyPW6ClkW4si3PFytkBLCqsn+4nJtiuRvZIqi2PchwqiNdmhq1elcNqhyhAKvzpSUd8oHvxAm/nAk3rKv2O5YPdzPTM8hwuu6dY72qJLMUxiedMHSkbS+5bG4T0zP6ucZiRa+bTCh5XgmzwiQNG3dJ0ayTfSPydYcNu/cntpxRT8kLfBjp3EdWRGt/UqNtdGPWEOzyOHMUCmXYsc6NV8PXnS3qLYnMzogUBgzlHMdCH2TdazvTkAmzezSn/jR88Q+HHGILDNyfo87TUwrPZfdlCA6MZM7eyqbV7Hu8zM8K/O9ynspMLRv7gOO/8pXcLVRwzoybUfueg0oWmGXIWktbwdg5Q0ih3b9NKLzE4TUFSsDm1gQiaFgqrB5pl3MIS0IQUGqPv13HIev9kattTpt0M2TQtRQUzXTJyaAE4Hu6ColT+a5pe50uSomOoPbt5Q+urTJdeNw1VVPuHnLQpkaWvU4ggELNxNe5r0QKpouvJUH0wkc8d/WYyzDDcjSOYlGz4i6Yt+TySEel6PBb/0xMFW+++lWEKn6cSin7m
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(6133799003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zFPyvE0owmRWhf78AO8OSS1Y7Nt1gbMp8luwKL1JSI3BJQCukW/nozI5Arjv?=
 =?us-ascii?Q?IsQF1SXpEwcLiPj7RVFl3RSecVBW9NyF3/Q8hSlNk2sDrXuwB2LTsJrvOUpe?=
 =?us-ascii?Q?sr8Mu93SSaWUsf/J2o/ahfV/a90dgJbe2Xu8MBm/0XcZrAtWGfD6+zm64wES?=
 =?us-ascii?Q?GNK0yWm+yCM7uZLeBo/SarPFBwizDeFavULl7Pf5jH34xRxb92ljGXf47i1G?=
 =?us-ascii?Q?R18AZ/rHF6TZUQ+jiOod7hD03fUr/bcLYGXMvepIWbWHwQifxWA1R/GDyFNo?=
 =?us-ascii?Q?cX1Vs3Avswh1OwXeGaYxv0cWyJzrd0nt/5enxm76NcXhKYZzbd2ZthfkkkOY?=
 =?us-ascii?Q?tiEFOKIMZV6HB8Bxkq9X9cryf1bzvJ+r3MZsi9wK3bStA47A92CMZ9+O0MfU?=
 =?us-ascii?Q?YiGEioHrbKARTY2WhT9QHyOoKHO3qRBA1rkUXjPrId/7yW9fuLtGirXGbILS?=
 =?us-ascii?Q?PdAWh9IFh7RHSwdoMsBaJ8kk8vBNVtSGrne7WjV9jRkovBiS70/yMkucsfPw?=
 =?us-ascii?Q?3wN4OKnaUFNqCdR3QUWv21n9rjMGWe5svwxGQE/wwpmSOvR0JU+qHT/DkIav?=
 =?us-ascii?Q?AGUpfK0s+TQy0u1WzTTXayBDKxdU5MGcM2/yZ38F1tibJEQ+r6a4O972nC5a?=
 =?us-ascii?Q?fVGG4jKYeRWEQe3+k/yo3wyS0tI9+jH7rPy8ppizz/wMOB7dqxhQ/oaRXkbU?=
 =?us-ascii?Q?5w/UqdUlT3Rj64/6CSz+9YmWPvYhDJ/OmSz493q2J2q0MyemXtneWjB+CCoS?=
 =?us-ascii?Q?uus4Tj1Ld/nVyENys4DTnSkiP/WMotLl+kjidpuaxF0TZpr+MT1FgJpWOmWl?=
 =?us-ascii?Q?r/vK+WTwVXk9A0XpG8fbdpXmG3aHOFOuxrHCY34aZ3g2xKSP6KyE9eMjVCs/?=
 =?us-ascii?Q?/SB1RIHUzvMXym7tHTWKMRmO73HDKb8x6FoaYe+8LdqgcYifitGPWgWpbshv?=
 =?us-ascii?Q?b6RXZZB/fjP0GuXDwtRUZMp/5wla5B5xOBzAJmfitrhv5pDQaaJzI0Sgtn3K?=
 =?us-ascii?Q?Qm8Uvqgfou/OTDPj58RqNWXnV+IbalgDQCjNAyP+VeFtoOCZ0hINyJWmDi+B?=
 =?us-ascii?Q?gV5bCiWzrVTkR3Jo47VZrCT/zKfzFQCUSFltLiIgX1dNKmFxbB/zRw2RXV2v?=
 =?us-ascii?Q?SVY21CFVu4krJD3VPOsax5phCFnKkwIr5t6WB6bpbjmXbnvdNbc/PBEHsbYV?=
 =?us-ascii?Q?v8u6wCO+BtuKnd7Na9+ioiy7U9HVxu+mf7Vi7AiG9xQjIbzybGRIyBjbyJie?=
 =?us-ascii?Q?mw2x6mDhjeb8eaiURnxE1iTMfAMijBdUF0hLc1PMu6pyi/vXNmbSbVpEzLqp?=
 =?us-ascii?Q?FWjkYKn9Eq5J/5syvuXfi6zV/iarEsQDwN+dNo9mLFlrlAt9m2SBY6xQFBwP?=
 =?us-ascii?Q?yDoi6RntzTIMQUoFXa6bUdtWRw3PcT6EqXEpgUEQW76yD8MLuSIxtxUT70iS?=
 =?us-ascii?Q?h8Ya3iQ5yarqFfTVSfcN9ezkRS5VmzzeVSu58ynWaTmWw7V9YxU0fs5SEFF6?=
 =?us-ascii?Q?h0IxZAKSQwWKNCvdPyQdoi3tMvUkXdlvUxKgtPuIBR4WWj/PEWFDQNd64qxn?=
 =?us-ascii?Q?wjmaOkKra+CRL9EDNfdeRvcikZr8w+fYJ+tqET0d9mz7jARNWOlZBkkxlu5I?=
 =?us-ascii?Q?uxtAwXTPgabVtmXih/nxZa5iphmavDiKrvRjAq1GJjL0vpryUkn3dfZ0RWM4?=
 =?us-ascii?Q?EVWXLH917zPWcr0T5g4tR61zbfmzveXuWONH8gR/qORYqnNETOE22oUePLa0?=
 =?us-ascii?Q?xfMg5wXwHuGtCRq4yceQpjuKNX+LAD4=3D?=
X-Exchange-RoutingPolicyChecked: EiGrjLexlokzhxAjFpY91uLAeN677NR+r3K9o1boV1f9ewNp0qFcwko5qYUzt8Qbx4BciNMA8UhNzqiUkihcWuBJq5dZgbXw3vSaHzrhWPznAq/J0sLRjt/fQuQUcpqdyKA0LMUd9YmIV3FchjeMbG+Zms2vka1rcrTtED92ZxV1vb+/SOjx4/aHaH6m6MTuzW6ZYqel2PkZXU48gbcBNEgBMVTfdo+AEUwuzm/yXhwQXuVBijhmw4Kud1YZ43d2zRp++MumpIwqgpe1T0tR4xAurDJJ9ZT1kXEKEP1v32qMLNNbHRPY5EMqjrSZ1tbVEz09rFzZt9vVfkK7vYpLQQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d18aba-0a7b-401a-7397-08ded35ae0a3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 08:14:00.4263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZ1czwvPEowI01IfyTIbfR45/NIqkWvdiTB31XxhvTfyJ3pPK1lTUjlR5pKuMhi7/EIReDbDC0SWR1FRM++mEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4766
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

On Thu, Jun 18, 2026 at 04:08:58PM +0800, Honglei Huang wrote:
> From: Honglei Huang <honghuan@amd.com>
> 
> drm_gpusvm_pages_flags currently mixes two status:
>   - MM / virtual-address state: whether the range has been (partially)
>     unmapped by the Linux MM, these follow the lifetime of the VMA and
>     are a single per VA range fact.
>   - Device mapping state: has_devmem_pages and has_dma_mapping,
>     which describe the current page mapping status held by device
>     itself.
> 
> Keeping both on the pages object blurs the semantics of the
> abstraction of pages and VA range. So move the MM state flags onto the
> range, and keep drm_gpusvm_pages_flags strictly for mapping state.
> 
>   - Introduce drm_gpusvm_range_flags { migrate_devmem, unmapped,
>     partial_unmap } on drm_gpusvm_range.
>   - Shrink drm_gpusvm_pages_flags to just has_devmem_pages and
>     has_dma_mapping.
> 
> Side effect: drivers now need to check the unmap flags in the driver
> itself to avoid handling the unmapped pages.
> 
> Mirror that bit onto drm_gpusvm_pages so the framework can
> still short circuit drm_gpusvm_get_pages() under the notifier lock, and
> make drm_gpusvm_range_set_unmapped() propagate it to the backing pages.
> This follows Matt's review fixup for the v0 series; see the Link below.
> 
> Suggested-by: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Link: https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-2025/-/commit/623f6a50c037d9e44f6c9fbe6859a0ba7ad50177
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>  drivers/gpu/drm/drm_gpusvm.c | 21 ++++++++++++++++++---
>  drivers/gpu/drm/xe/xe_svm.c  | 11 ++++++-----
>  include/drm/drm_gpusvm.h     | 30 +++++++++++++++++++++++++-----
>  3 files changed, 49 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index 958cb605aed..df900553f21 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
> @@ -641,7 +641,7 @@ drm_gpusvm_range_alloc(struct drm_gpusvm *gpusvm,
>  	range->itree.last = ALIGN(fault_addr + 1, chunk_size) - 1;
>  	INIT_LIST_HEAD(&range->entry);
>  	range->pages.notifier_seq = LONG_MAX;
> -	range->pages.flags.migrate_devmem = migrate_devmem ? 1 : 0;
> +	range->flags.migrate_devmem = migrate_devmem ? 1 : 0;
>  
>  	return range;
>  }
> @@ -1784,20 +1784,35 @@ EXPORT_SYMBOL_GPL(drm_gpusvm_has_mapping);
>  /**
>   * drm_gpusvm_range_set_unmapped() - Mark a GPU SVM range as unmapped
>   * @range: Pointer to the GPU SVM range structure.
> + * @pages: Pointer to the GPU SVM pages structure(s).
> + * @pages_count: Number of GPU SVM pages structure(s) passed in.
>   * @mmu_range: Pointer to the MMU notifier range structure.
>   *
>   * This function marks a GPU SVM range as unmapped and sets the partial_unmap flag
>   * if the range partially falls within the provided MMU notifier range.
>   */
>  void drm_gpusvm_range_set_unmapped(struct drm_gpusvm_range *range,
> +				   struct drm_gpusvm_pages *pages,
> +				   unsigned int pages_count,
>  				   const struct mmu_notifier_range *mmu_range)
>  {
> +	unsigned int i;
> +
>  	lockdep_assert_held_write(&range->gpusvm->notifier_lock);
>  
> -	range->pages.flags.unmapped = true;
> +	range->flags.unmapped = true;
> +	for (i = 0; i < pages_count; ++i) {
> +		struct drm_gpusvm_pages_flags flags = {
> +			.__flags = pages[i].flags.__flags,
> +		};
> +
> +		flags.unmapped = true;
> +		/* WRITE_ONCE pairs with READ_ONCE for opportunistic checks */
> +		WRITE_ONCE(pages[i].flags.__flags, flags.__flags);
> +	}
>  	if (drm_gpusvm_range_start(range) < mmu_range->start ||
>  	    drm_gpusvm_range_end(range) > mmu_range->end)
> -		range->pages.flags.partial_unmap = true;
> +		range->flags.partial_unmap = true;
>  }
>  EXPORT_SYMBOL_GPL(drm_gpusvm_range_set_unmapped);
>  
> diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
> index e1651e70c8f..63da149f3b7 100644
> --- a/drivers/gpu/drm/xe/xe_svm.c
> +++ b/drivers/gpu/drm/xe/xe_svm.c
> @@ -134,7 +134,8 @@ xe_svm_garbage_collector_add_range(struct xe_vm *vm, struct xe_svm_range *range,
>  
>  	range_debug(range, "GARBAGE COLLECTOR ADD");
>  
> -	drm_gpusvm_range_set_unmapped(&range->base, mmu_range);
> +	drm_gpusvm_range_set_unmapped(&range->base, &range->base.pages, 1,
> +				      mmu_range);
>  
>  	spin_lock(&vm->svm.garbage_collector.lock);
>  	if (list_empty(&range->garbage_collector_link))
> @@ -166,7 +167,7 @@ xe_svm_range_notifier_event_begin(struct xe_vm *vm, struct drm_gpusvm_range *r,
>  	range_debug(range, "NOTIFIER");
>  
>  	/* Skip if already unmapped or if no binding exist */
> -	if (range->base.pages.flags.unmapped || !range->tile_present)
> +	if (range->base.flags.unmapped || !range->tile_present)
>  		return 0;
>  
>  	range_debug(range, "NOTIFIER - EXECUTE");
> @@ -1136,7 +1137,7 @@ bool xe_svm_range_needs_migrate_to_vram(struct xe_svm_range *range, struct xe_vm
>  	struct xe_vm *vm = range_to_vm(&range->base);
>  	u64 range_size = xe_svm_range_size(range);
>  
> -	if (!range->base.pages.flags.migrate_devmem || !dpagemap)
> +	if (!range->base.flags.migrate_devmem || !dpagemap)
>  		return false;
>  
>  	xe_assert(vm->xe, IS_DGFX(vm->xe));
> @@ -1248,7 +1249,7 @@ static int __xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
>  
>  	xe_svm_range_fault_count_stats_incr(gt, range);
>  
> -	if (ctx.devmem_only && !range->base.pages.flags.migrate_devmem) {
> +	if (ctx.devmem_only && !range->base.flags.migrate_devmem) {
>  		err = -EACCES;
>  		goto out;
>  	}
> @@ -1623,7 +1624,7 @@ int xe_svm_alloc_vram(struct xe_svm_range *range, const struct drm_gpusvm_ctx *c
>  	int err, retries = 1;
>  	bool write_locked = false;
>  
> -	xe_assert(range_to_vm(&range->base)->xe, range->base.pages.flags.migrate_devmem);
> +	xe_assert(range_to_vm(&range->base)->xe, range->base.flags.migrate_devmem);
>  	range_debug(range, "ALLOCATE VRAM");
>  
>  	migration_state = drm_gpusvm_scan_mm(&range->base,
> diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
> index 8a4d7134a9a..251a7266a73 100644
> --- a/include/drm/drm_gpusvm.h
> +++ b/include/drm/drm_gpusvm.h
> @@ -109,9 +109,7 @@ struct drm_gpusvm_notifier {
>  /**
>   * struct drm_gpusvm_pages_flags - Structure representing a GPU SVM pages flags
>   *
> - * @migrate_devmem: Flag indicating whether the pages can be migrated to device memory
>   * @unmapped: Flag indicating if the pages has been unmapped
> - * @partial_unmap: Flag indicating if the pages has been partially unmapped
>   * @has_devmem_pages: Flag indicating if the pages has devmem pages
>   * @has_dma_mapping: Flag indicating if the pages has a DMA mapping
>   * @__flags: Flags for pages in u16 form (used for READ_ONCE)
> @@ -119,11 +117,8 @@ struct drm_gpusvm_notifier {
>  struct drm_gpusvm_pages_flags {
>  	union {
>  		struct {
> -			/* All flags below must be set upon creation */
> -			u16 migrate_devmem : 1;
>  			/* All flags below must be set / cleared under notifier lock */
>  			u16 unmapped : 1;
> -			u16 partial_unmap : 1;
>  			u16 has_devmem_pages : 1;
>  			u16 has_dma_mapping : 1;
>  		};
> @@ -151,6 +146,27 @@ struct drm_gpusvm_pages {
>  	struct drm_gpusvm_pages_flags flags;
>  };
>  
> +/**
> + * struct drm_gpusvm_range_flags - Range-level GPU SVM flags
> + *
> + * @migrate_devmem: Flag indicating whether the range can be migrated to device memory
> + * @unmapped: Flag indicating if the range has been unmapped
> + * @partial_unmap: Flag indicating if the range has been partially unmapped
> + * @__flags: All flags in u16 form (used for READ_ONCE)
> + */
> +struct drm_gpusvm_range_flags {
> +	union {
> +		struct {
> +			/* All flags below must be set upon creation */
> +			u16 migrate_devmem	: 1;
> +			/* All flags below must be set / cleared under notifier lock */
> +			u16 unmapped		: 1;
> +			u16 partial_unmap	: 1;
> +		};
> +		u16 __flags;
> +	};
> +};
> +
>  /**
>   * struct drm_gpusvm_range - Structure representing a GPU SVM range
>   *
> @@ -160,6 +176,7 @@ struct drm_gpusvm_pages {
>   * @itree: Interval tree node for the range (inserted in GPU SVM notifier)
>   * @entry: List entry to fast interval tree traversal
>   * @pages: The pages for this range.
> + * @flags: Flags for range see &struct drm_gpusvm_range_flags
>   *
>   * This structure represents a GPU SVM range used for tracking memory ranges
>   * mapped in a DRM device.
> @@ -171,6 +188,7 @@ struct drm_gpusvm_range {
>  	struct interval_tree_node itree;
>  	struct list_head entry;
>  	struct drm_gpusvm_pages pages;
> +	struct drm_gpusvm_range_flags flags;
>  };
>  
>  /**
> @@ -310,6 +328,8 @@ drm_gpusvm_range_find(struct drm_gpusvm_notifier *notifier, unsigned long start,
>  		      unsigned long end);
>  
>  void drm_gpusvm_range_set_unmapped(struct drm_gpusvm_range *range,
> +				   struct drm_gpusvm_pages *pages,
> +				   unsigned int pages_count,
>  				   const struct mmu_notifier_range *mmu_range);
>  
>  int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
> -- 
> 2.34.1
> 
