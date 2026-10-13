Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7F7CA9ED0
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 01:37:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 907A610E70F;
	Tue, 13 Oct 2026 01:37:21 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61B0510E70F;
 Tue, 13 Oct 2026 01:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791855435; x=1823391435;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=PduSgKnkkOxeIaoU5NgPHrOOakLZY2HxiB9AOIZxcaE=;
 b=iL2k2rhQ93MxZwKoJj4eNSmf2ICSo6ClJFbHMERCjDQiDOEdPzP0kdc9
 KMZYe5U5KBaR8fK9Of25T8ByBlwyJwObqiiIyXyd8LHwvUTf0s5aVubGV
 DsbR7XzytgRceGGdy5WqVAA832EzgXRXBjjIn100LwYS+YugLAOQiExpc
 CHEZdVTUisYKtvwEv1+xGBoPNOVnr64Qwwex2V6WmaSOm7HujI12aX7CH
 KClzsGMY54Td/QHWTWVecKrb30YVYjMSRgwTfVBGo/GwkZPoRqwStRGKG
 8n0C9LfmgvsMDvP0ImONRQcOQ4x2n3AiFyWZHL5UdJREiUQFkSM5z6OoW w==;
X-CSE-ConnectionGUID: WHPvw4kdS92CK3vqCmR/0w==
X-CSE-MsgGUID: PY85iUPxRNORciL2n41e7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="565784"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="565784"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 18:37:14 -0700
X-CSE-ConnectionGUID: V5TNyR81SSqND/PIW/AEFA==
X-CSE-MsgGUID: ZPBNNncITWahB0Ro+dJWDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="1509121"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 18:37:14 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 18:36:58 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 18:36:58 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.36) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 18:36:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yVye2IKOKfaEiUpFSQqTrkEte1uh/Cql/SotfqSn2AISHcbptfuRPeZqQuG43tjq3wz5I+fDAFcfbh1hcaDOb0V4DBHtenTdkZMsomL7SjrH3ajGMxNwUZYcV8Re4/r/I/+UsjWVHu/YLmbiex2ln/yOagMalCob9M0Sdq5agJ4iPOWRZmXT7SCJy3nZvAR9BGeYVPjtJ4u0UVzE9MmgvptF960Ijc87KEZYSAfTy46WSpNtsL4y+b36U8HazrQQ9QSVq6oSUlG2vFNHt8+LT7lSIcXf9x5IZjOwefi6sVW2Ez3VwjhPx/dC2BnV4fjHkwpX1KY+3yDPUBZ76x6b0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPy7CgkwbjZ5ESTG5RRedoQXTHLlvHsN93cPl9cmSkg=;
 b=LIDfWIttRLloDfkgM92fPzfYvbPnrUDqKuhGdHp6LXVjRi1qUiCrcVF8XSx5nxNHN0baqPhKxZSTfWDzvO6TeGBIuRjCR7XsRYt6yBF3T5b99YsHfyG3eH7mlsncpHUpBCCm2bpzpVm94MLMNK6urT1BmBVYUcSQV2/Zpb1B/6gNN6/GbNiHxu1D23i6mG2EtkiA+3LunqUpxfYekwqsHy3aw0vD5dVZp7SfAH4ZgYj5g/JxDqXuLTPE32oYo8HhN0ZdeW2NB31VVweZyV19WUZtBgdmuJ73uhizdUGuLerbDFzEp2sOljvVRWffZu6m/W7ivrum7YvAI/MYyFceog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by SA1PR11MB7015.namprd11.prod.outlook.com (2603:10b6:806:2b8::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 01:36:50 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 01:36:49 +0000
Date: Mon, 12 Oct 2026 18:36:47 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
CC: <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>
Subject: Re: [PATCH v2 3/6] drm/gem: add drm_gem_prime_dma_buf_to_gem()
 self-import helper
Message-ID: <as2LL7IIs6EcL6Pj@gsse-cloud1.jf.intel.com>
References: <20261013010614.1516799-8-niranjana.vishwanathapura@intel.com>
 <20261013010614.1516799-11-niranjana.vishwanathapura@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261013010614.1516799-11-niranjana.vishwanathapura@intel.com>
X-ClientProxiedBy: SJ0PR05CA0120.namprd05.prod.outlook.com
 (2603:10b6:a03:334::35) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|SA1PR11MB7015:EE_
X-MS-Office365-Filtering-Correlation-Id: 77f12b59-8c57-432e-0f49-08df28ca7387
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|10067099003|261009221227099003|261009223027099003|11063799006|4143699003|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: pkctWvMoNXL8iyGtREQIEswTac2gWKeyv4cPFvy2NE/+LYO3XBh/5V/D3brmVWyZ6keE1558OQXHgRClASmdiRdOCJEUgti7csa3g0UY78Zewao80UYTfsZCIxddP62s52BVnYdh9KZm4Jdlv8OUgfs+fgIHDWNpeN7ewjWFKlglbyhD2IZeczztXPV3/MOnBjbPWlQYCIWanD77HIHoUBV6QQBQJwgnZkdWSZXnQp/ziOyxtXdEd+/fBm82C4W5iRr8jt4ZHCF35y4Eh34s7jHWzOkNWDvNmmQ/moLld4IzUQNDxJa6Oy7SlPc1fWlrukD8LT8t6c4wPR8FuYC7e94I1SVPepRqQPSwBLl1Ds9doF0umKb9PuRlW8cu0+x2a1tDfp5yQ+PK12AfoddQfpk1RB/uS4I4WaBUkw8TpbYKsTGNtRH4opc3G28XsWWz3l8UWtIM9i6piW20uRzAhr347e2v85Eiguv86Eq53ib7CtezkF4YKpnSOuQUnHwWLzcyei45zh4wBqrVy4ssExdISmL/zqMrWEXFinQ8kF0HvPHSDwPJtiZl3XdzhbOanLFK5Rub1k2+9OaS7WHjmuj059NbeOHI3oMTiJvblUUdVTfOPnIM4GS4Nuz7VXwh779onWtmHXeL5cUNu2KR0sKFiDeFQT18PJ0BdTBCM80=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(261009221227099003)(261009223027099003)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8x+IGjHuHqBjsR11t94eIlDlA8jp+he0JNSZMoD0cWHDvGPRhyb1MTGfZHI0?=
 =?us-ascii?Q?2Hw8iuolDwP4SjMCQa7hP7nq8ZiBe4E46cyJQyqNdyyzi1CevISpWEhDAu8s?=
 =?us-ascii?Q?74wput3AcWXez+d/KuvEtnn0+tpd8k6V4cArjtyQ+wrksSUq9Gr34AleZLv2?=
 =?us-ascii?Q?0EgGqL1eKGDgM0W9Xjlz58kG4OFqeKGtAh9thzAbUO9epe+dIIOSDEjGe7fv?=
 =?us-ascii?Q?J5NWeih6flLDR5Dlx8Qr5Gtx5e9XKKc0h+yRtULsGGN1qvoOOod9bRDlmiQ4?=
 =?us-ascii?Q?ZCk6oWPB7MGYCaQ6aRWnUctzWEFXns7Q7EDr4lH4axH2x9+fwxrvXRRfhDou?=
 =?us-ascii?Q?Qg3V7lO78vt2ZdGFSmgLza97dUj4ct4jpL6wFJbqpVzcawXnZdlBIPVVmYlH?=
 =?us-ascii?Q?jm0HgeaU7Ec3j0yXszwl/0BRAXg+y3g665CBzm9DU/5W+NEoecoOG7Z0tNdV?=
 =?us-ascii?Q?MF4WUnCehMQDRUEpPbgebAWm1db3j2Ur3bpnnCgTCPUHvoHrP6Oec92jFOt0?=
 =?us-ascii?Q?zgQUqTuUiPfjRvRviM3/YHPCtwp+vJgasmUyBaLGCIbhuX0ekhtUEHo5J8Vg?=
 =?us-ascii?Q?7/79P95naY6QTEx3HxXSKGNJ0GWC9Hz+eSCObBFTzWU/TjFHVm5+bQYR05yq?=
 =?us-ascii?Q?hFgso+SGPnshnjUZ8tzCdkQkz8XItEQj444tshog51xjNLFOhZwgGYWk2bkx?=
 =?us-ascii?Q?Yke73xWuqLHXo7UGNcOHjKMKOxw7l/LvppnQwmQYaiZAL/X7w2cgbncrdwSw?=
 =?us-ascii?Q?annOVEMVzDjuKIRLBl/wv2qY3yFqbuxTthXNQbiL/CrrrsH2ZF9G8kJq41ZG?=
 =?us-ascii?Q?UArJZCSaxQo4lud4tB/CYOOPx0JXOgYO5Vok1L+Qhykjd6LAaMO5Sb/B2QVD?=
 =?us-ascii?Q?InJtUfEQedtRBhsm5h8XnlRcp0VNrZ+unC/vEsTfOe+ZA9pb3fAATYlzG0yT?=
 =?us-ascii?Q?KU+oCd5SR5ql3CeZ+WpR7u+CVPVcBjs6r3eEioiGyDL6p0fPXwqas/f8wgPE?=
 =?us-ascii?Q?WuvHoiE4AK8IS9hZZK4MeazLIrSPYNY7cpAXm0HCXlctEjg1j5v8a1xZra5D?=
 =?us-ascii?Q?VDFF4KCwYYtxgsyMkpcUOjwfJCmUIgVyS8FjOxVbY18rqaoPr35WarwqstbA?=
 =?us-ascii?Q?BV6i+kMWhRw5Ot3RqW+syUESWM6sLWlCjOkpzfJe4xFtmA88122Hw1+TIbOx?=
 =?us-ascii?Q?H/CdS5LqLHqma7XDSA0XwbsumoZ8Nqv2r+x9MUgYvMtdCJRnl5a15b13hsi3?=
 =?us-ascii?Q?RQoJG9JXIuC0QQAH6ZbhfdFQzyCmQL5ljPiRbIyzRXEY5Tc5EAXsKVuqQu1E?=
 =?us-ascii?Q?yFRbbPQIAykkx0YfF5S1K2WoZWlM+cCgGGH3P/JcmvJLj/Yk/QU0GbLgfASh?=
 =?us-ascii?Q?C5GiXDiJzeDgwyT+E8H49SLC4kk6F2Rwz4muRP0zRykkxtjtB8kkMZ8Ehsy5?=
 =?us-ascii?Q?s3G9dMyMkPEWavfOdxZYEPpH6Ois/BEyynRXTzXLswKqlJ7EsChf5whFvLLZ?=
 =?us-ascii?Q?gdhXW7Rp+nmTgNXQOZUn+uHvAISR6vvI7OBVClV27OH4324cM/FQGrQx9aoj?=
 =?us-ascii?Q?EtBwNPA/YIJ9jZmJHt3P5/sKLPGz9bj9P8lCDmMUd1Vm4GIoCQCmbQgCa3TM?=
 =?us-ascii?Q?6uZ4rMOsD/gSX3kWNHVlVbK9ggT43jKIRat8eXWG7va8VB5QOrXj2+zeAM1c?=
 =?us-ascii?Q?6fW9kYupuGNMDvXMW4IZj7Wb26Ughtws0SJAb5quXk/avIrXcO5SoqTlGsIx?=
 =?us-ascii?Q?87mZdgxTNtLHrf/53KMGN05HPN7CNjk=3D?=
X-Exchange-RoutingPolicyChecked: Q9kkdwooRjjxJ+3GCMP+A3MlPdZ1w2CSNVcrSNV/aPn2rM/BUr65vxVSwFMRIaRQ1mFg86/0qVfF/Yx5HvZE6uoJw22nDspg4+8znSWiR9hhHCZ7V4QhPMVDQ61ckRZQqRTgfAHcJfw0QKQvgAdZkcV1UBbmyN9BINxUtkM3BqtgykuspOHQ4r8Vuuo8yHCpBMH5Gev6ThU/G7nr2GFOToaCCGp+i4ITZoUw0eAEdvsBMJ1NM7GEFK8mwyoW4i5bR4SUYZxd+iMjlgiLROS/ojeI5L6jlfy9fywYT/7CRSYA/EcMjihyrCyfqYjxw1wEDQdmqy0QiucpcrhHwUaOCw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f12b59-8c57-432e-0f49-08df28ca7387
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 01:36:49.8551 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UbM6DwGcg5wdbHzL8dDlS7WZXxaA7E7Hl0LFHGm00ygyyhOVAxVHhBzSUicd8g/ut2UYWBj23e7cdX01yuaiuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7015
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

On Mon, Oct 12, 2026 at 06:06:15PM -0700, Niranjana Vishwanathapura wrote:
> drm_gem_is_prime_exported_dma_buf() is a bool predicate that open-codes
> the core PRIME self-import check. Its only caller, the shmem importer,
> then repeats the dma_buf->priv lookup and the reference get.
> 
> Replace it with drm_gem_prime_dma_buf_to_gem(), a thin wrapper around
> drm_gem_prime_self_import() that returns the backing GEM object -- with
> a reference taken -- for a core-PRIME self-export, or NULL otherwise.
> This consolidates self-import handling onto drm_gem_prime_self_import()
> and lets drm_gem_shmem_prime_import_no_map() reuse the object directly.
> 
> Unlike the removed predicate, the helper takes a reference on the
> returned object; the sole caller already wanted the referenced object.
> 
> Assisted-by: GitHub-Copilot:claude-opus-4.8

Assisted-by: LLM

I was going to suggest this last rev too as I noticed
drm_gem_shmem_prime_import_no_map called
drm_gem_is_prime_exported_dma_buf which should prefer the new helper but
shmem couldn't look at drm_gem_prime_dmabuf_ops.

This is a good cleanup:

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Signed-off-by: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 14 ++++++--------
>  drivers/gpu/drm/drm_prime.c            | 26 +++++++++++++++-----------
>  include/drm/drm_prime.h                |  4 ++--
>  3 files changed, 23 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index d654a22a30de..a0e161f2333e 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -954,15 +954,13 @@ struct drm_gem_object *drm_gem_shmem_prime_import_no_map(struct drm_device *dev,
>  	size_t size;
>  	int ret;
>  
> -	if (drm_gem_is_prime_exported_dma_buf(dev, dma_buf)) {
> -		/*
> -		 * Importing dmabuf exported from our own gem increases
> -		 * refcount on gem itself instead of f_count of dmabuf.
> -		 */
> -		obj = dma_buf->priv;
> -		drm_gem_object_get(obj);
> +	/*
> +	 * Importing a dmabuf exported from our own gem increases the refcount
> +	 * on the gem itself instead of the f_count of the dmabuf.
> +	 */
> +	obj = drm_gem_prime_dma_buf_to_gem(dev, dma_buf);
> +	if (obj)
>  		return obj;
> -	}
>  
>  	attach = dma_buf_attach(dma_buf, dev->dev);
>  	if (IS_ERR(attach))
> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> index 588910c250b8..275c5661528d 100644
> --- a/drivers/gpu/drm/drm_prime.c
> +++ b/drivers/gpu/drm/drm_prime.c
> @@ -933,23 +933,27 @@ EXPORT_SYMBOL(drm_gem_prime_export);
>  
>  
>  /**
> - * drm_gem_is_prime_exported_dma_buf -
> - * checks if the DMA-BUF was exported from a GEM object belonging to @dev.
> + * drm_gem_prime_dma_buf_to_gem - GEM object backing a self-exported PRIME dma-buf
>   * @dev: drm_device to check against
>   * @dma_buf: dma-buf object to import
>   *
> - * Return: true if the DMA-BUF was exported from a GEM object belonging
> - * to @dev, false otherwise.
> + * If @dma_buf is a PRIME export of a GEM object that belongs to @dev and uses
> + * the core PRIME dma-buf ops, return that GEM object with an extra reference
> + * taken, so a self-import reuses the GEM object instead of referencing the
> + * dma-buf file. Returns NULL for a foreign dma-buf or one using driver-private
> + * ops; such drivers call drm_gem_prime_self_import() with their own ops.
> + *
> + * The returned object carries a reference the caller must drop with
> + * drm_gem_object_put().
> + *
> + * Return: the referenced GEM object on self-import, or NULL otherwise.
>   */
> -
> -bool drm_gem_is_prime_exported_dma_buf(struct drm_device *dev,
> -				       struct dma_buf *dma_buf)
> +struct drm_gem_object *drm_gem_prime_dma_buf_to_gem(struct drm_device *dev,
> +						    struct dma_buf *dma_buf)
>  {
> -	struct drm_gem_object *obj = dma_buf->priv;
> -
> -	return (dma_buf->ops == &drm_gem_prime_dmabuf_ops) && (obj->dev == dev);
> +	return drm_gem_prime_self_import(dev, dma_buf, &drm_gem_prime_dmabuf_ops);
>  }
> -EXPORT_SYMBOL(drm_gem_is_prime_exported_dma_buf);
> +EXPORT_SYMBOL(drm_gem_prime_dma_buf_to_gem);
>  
>  /**
>   * drm_gem_prime_import_dev - core implementation of the import callback
> diff --git a/include/drm/drm_prime.h b/include/drm/drm_prime.h
> index d378404f8ab4..02665205aed1 100644
> --- a/include/drm/drm_prime.h
> +++ b/include/drm/drm_prime.h
> @@ -101,8 +101,8 @@ struct dma_buf *drm_gem_prime_export(struct drm_gem_object *obj,
>  unsigned long drm_prime_get_contiguous_size(struct sg_table *sgt);
>  
>  /* helper functions for importing */
> -bool drm_gem_is_prime_exported_dma_buf(struct drm_device *dev,
> -				       struct dma_buf *dma_buf);
> +struct drm_gem_object *drm_gem_prime_dma_buf_to_gem(struct drm_device *dev,
> +						    struct dma_buf *dma_buf);
>  
>  struct drm_gem_object *drm_gem_prime_import_dev(struct drm_device *dev,
>  						struct dma_buf *dma_buf,
> -- 
> 2.43.0
> 
