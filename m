Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC3DC79FB7
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 03:03:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F37110E1A1;
	Thu, 10 Sep 2026 03:03:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NWgn4nMN";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EC9C10E1A1;
 Thu, 10 Sep 2026 03:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789009402; x=1820545402;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=A68MMI3gScWGYhPYXQnuin09/9+Us7+5PefacQgSre4=;
 b=NWgn4nMNl1eqyZML9ewxRrPRRt3VD1oksXdR7a2rPPMoTmTqX90xFsXc
 LYzB5+7ZiMG0sPzh2/Mf/O3OLaX8y9lCMGvUsFWQebe2aanlKpFxENWiK
 Q4KbwwpVbYZeUmul/8LAwOkNySTHrBxw9mwovIbYlBkVPE6MAmn+F7BC0
 E2VU/CzZ4g+kF/xZbUawIiS98MlVIt98xBVAfOW2XRhqO/elhNzBg1r9r
 7BOIz8r1Kwi5cZ41vqCjeU64xeWS8UMOkYk0ZT/qJxQin5Y0BfDcICPB+
 Si+GywZaJwkr7HU69ehv1GHOZulCvID0o+As821clwd3h4uiwFHhpJ80N w==;
X-CSE-ConnectionGUID: 7ZsD1yRVSF2r4LIVrE1xYg==
X-CSE-MsgGUID: OMO3LMnXRMGmZh/AkRyY/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89322364"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; d="scan'208";a="89322364"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 20:03:21 -0700
X-CSE-ConnectionGUID: TrEh8vacSNW57gbSBwFO5Q==
X-CSE-MsgGUID: nk+TIDbXSfq0OqqSrV3s8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; d="scan'208";a="271992060"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 20:03:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 20:03:17 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 9 Sep 2026 20:03:17 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.49) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 20:03:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J84734qnxvfgglwTgjP2mf3QbTNm2wnrXleQjplnUk4lm7xQZ1cSXYeSlnfBmX1XmWj2BWXFHzOOdBBf2IbmEV7arr3LWLAd4+3vYKvL/6LodkXIXuMLnh0X0UPIYtMx/rkWiJQevidF3pNdqqELjpRWMZOJnvvEfiTfr4C33YNnSr7JX7wyz1fWz8/bEUseeZDnkcXqnkQk7kJnvtplUlvE/MFtVSfQ+SQTYgcs6UtXyf7ssNL0G2C+DZs0v/cXoNDWYjoCZ3DD8oWbbbwgjem1IrpnDmctoqAXvl80t92Bwj+4b/3ke2/0yfXEDHddkBpvcw0Ac5ItafFkp5DALQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIhJafyWa5LJFzbZmw9EJCY3Q6e0NSvbJsaZ6PQLtso=;
 b=d7n57tZmUIXDrqvF/TvQhAD+Qn86n26jwYSl61LWs2OzIeMJb7LiS7sLg3nF7QzEhuJ8NCvIOQHZK7stOjFh9wLzdcDFLyNFw5tUEXfWmKN6Fmh2vvKz9IxXYg2cfKN0TOVDPBRWANO8CRew4x2oJd/VvO0TYEmmIqYZ8fz0cXwA2FjU3XI9XJ13C4QiUr103uyjvv+hrEtA1IU2U5ciV0tUh5dEeABYqwZb0iLGeylcQc1S4O7dEdNwM5aq0tJSa3jwwo1eKEHWjZ/ZXvlHC1hlaMYGR858lw6LFTSlxA1o0SdRiXkIWf+CadW65iUsGhzMOJ6enSov7S5s4D2PJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by SA3PR11MB526947.namprd11.prod.outlook.com (2603:10b6:806:595::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Thu, 10 Sep
 2026 03:03:02 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%3]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 03:03:02 +0000
Date: Wed, 9 Sep 2026 20:02:59 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: <christian.koenig@amd.com>
CC: <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <ecourtney@nvidia.com>, <nat@pixelcluster.dev>,
 <dri-devel@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 10/11] drm/gem: Use dynamic allocation for GEM object
 dma_resv
Message-ID: <aqId4079/mXgWMgh@gsse-cloud1.jf.intel.com>
References: <20260903134408.105317-1-christian.koenig@amd.com>
 <20260903134408.105317-11-christian.koenig@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260903134408.105317-11-christian.koenig@amd.com>
X-ClientProxiedBy: SJ0PR03CA0234.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::29) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|SA3PR11MB526947:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bf608c4-0814-4ae1-565d-08df0ee80715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|6133799003|10067099003|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: OmggQXTdCFVuAKBnWeBxHylX8W/66UsEajCr68X5kr+vVGteWXm1zyBrR4fybPJWvFIGXqDKqY08R1tWWE0M1BI4TgjUK6br+os7Ds2uqBqNBGH4mSv2TBvxptcZi5jpRYxW9wOi6d9iOH7pLF89xWfZGkGz3pyNScpDweeIMbVXjx3qYiUS4sCQ29+qrNVNt4hQIxjHL9TAL4nxUU9coeSQtK4KQ8VZQ02pxyjI6gaZ7fAUdjnC+STmAYXX82sgFXefz+DeJ6TsnLx/fEZRW6hw/Q+tMd6eIPAqkYyAVJdnP+ogu+hDi/T2myCvBH2q+OOoopw37W4nsfvror0WiPOjfTa0hZ91PygPe3Ew2C6ciMRGzOLFjSTc/LNHKY4UNkMOCjxNX60ZwaVAo5Dk3BXkuWsDxQcKocehs3vUxuuH56TAM65kBnVVT9iV+ZHSY3le60z/9NozyyO6mZY2jQ8sQ54EbyTd/SvKeJLCIc6MjQvzeZUD1OSdHgcuzzurbdJXVadjlJc7LROHAr92Bhv3HqJWAGPQ7Xy8HRIpkU+FvxxbHmyvsyjIVrjgrSiSEpJM91v+57CdPTOqIo4J1mjmeUi18rLEygomgp891ynhIPkLRAMUNALkzsd/4yw4OL4Y4TYP0l2hK4l/XkDauFZMcTIKQvAPMRtW26ldFDA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Yf0diSYgq8pqjK5Tp07khRdrZonMEa1JWaFa2wFQ74i4dK4XN7Mfh1ZHcq?=
 =?iso-8859-1?Q?1T/x4GH17Nt8pEgssV7go2ZwHdO/4HdIZKKn1OtofQvbomxRQt1Jgg9O8z?=
 =?iso-8859-1?Q?UVZRqJGYOuaqGiofMsUfo+4QZKnKyVkF4v2Vz97skVPS2LwskadjiNjbyb?=
 =?iso-8859-1?Q?UN7tPFTXJi5a+BbPhBOsDKOX8g3MgVyX6qaWsbVtN5VKNHhSE1/Nf7o+C0?=
 =?iso-8859-1?Q?/ezi5y8LjhllEXBBu3jHy/Z+26t1rQqUhkfvsiGSAEY2s4H0Q8Hd0ZJLfz?=
 =?iso-8859-1?Q?1ktVkRTS/Ymsjomqwp+X1apvvIFIFAnrDycYj11a/tWfPLHP7O7ZQ6gwCb?=
 =?iso-8859-1?Q?p3rplf0ARBkUVMch+vz2VVDb7xS6APf8vDmmyBFbJMu1RN7ROzbR8ffbPM?=
 =?iso-8859-1?Q?sG6yyHvChlRZybHO0AGNJZ2X4YVb+/UAlX+Txe9XW4V8m35E62JIbRVj75?=
 =?iso-8859-1?Q?8dKbXVLJT8WhYKZGZkB6OSko9b1hTp6ScccDbBzzVLD0UvH9PtYV2hopZr?=
 =?iso-8859-1?Q?U+RnaaFJ+f6s1lycxIpZTHlGi8x7Rl+BNLUUIqw5b+j6NuEY+cUyV5qy3e?=
 =?iso-8859-1?Q?8WV7ennQdCKBc8aR9XR0iyoqPLvQGug05OZa3DMCGEdINklfMAYHQKEOIW?=
 =?iso-8859-1?Q?u+smkPr25tBKhPxFQuMxtf/Zolyl3q196NeaGDZc0LAIvlzqf8f4f+lsHV?=
 =?iso-8859-1?Q?U3sgFHFkyCBLFnt80O9caqmW7jskCcjRKcfivMKnWje6hGU59PabqK34oP?=
 =?iso-8859-1?Q?bc1xp/RgH+dzFIGhgDuZN3uI4TX2hEaXixHxZtzqU2dObt2slRMQHobHZV?=
 =?iso-8859-1?Q?M0bJ4XnjWCuNfbGio7mTLA1Olzwp9sy5EQJKGsDUMSi2mtMx2wbvJGyJiC?=
 =?iso-8859-1?Q?H6ulGxshbvBfZi3VM/jSZnibbk9giDflVreBBWDksekOZFQ0ZiFj58I3YR?=
 =?iso-8859-1?Q?sgOa1ch2D+rL27JGQ878J4qdx2DJ19PjElKkUJZlReJixaFai5ChgWBgft?=
 =?iso-8859-1?Q?qyjXwTsR90577SjtqkZtTu1zeWi/JJJfPiRVk+pS/CKDSV3h5XlmvLGS0W?=
 =?iso-8859-1?Q?7mU/xsW0pguCujFmeWrfcvQBTmNM78/umzcS3WGtvvjSI9lrlYijg/tlvi?=
 =?iso-8859-1?Q?wG8ofmfcPqLCD2xmhuTRjluca5PcvAl+k0GKbJFlAtLOQhunPmHXCjhDMC?=
 =?iso-8859-1?Q?Sa77fHlhks1F0/R/LGDtOiB0dXkcq5/T3b3pgtWJ9uWA0k/MR1s/81hoId?=
 =?iso-8859-1?Q?PahMahiNGTeXfxK7cbwPGcMi3uN5+bs9qY3zk9ceK7BXNUZjcHeNFTrci/?=
 =?iso-8859-1?Q?TEl4uzWNbMQnGxP5QD1i7P/uu/PC2l82KsQ3o2W2uJnYRHjBy0NrPD857A?=
 =?iso-8859-1?Q?hJCZcAjS90+pvpHbSaxHoP6W7CA4qCCIc3GIO1xBlWoqveQ4FPFHCQOdSk?=
 =?iso-8859-1?Q?U8vVkw7rvS4IM59Mp6cU/wXCwruoot3vnj57d3QQoRA++P7vwWXc514Z5y?=
 =?iso-8859-1?Q?1Vd3DvgxRXrSUTz5bF2p//hyZlwpTKqTx4cZ7+KnRB8nWseWDo/Rx/UdiF?=
 =?iso-8859-1?Q?/CitMXHHR7a+/DWE+IK5qYorOfDBe9OV7E4OmqS70AfpgoBQocIEM6+qZb?=
 =?iso-8859-1?Q?/kNM2SGlUML0YlW3HOzvxxaYooT+c+WyK4mnZ0bGGR/FBftzekIJohR1dh?=
 =?iso-8859-1?Q?9bNAEBmDp5INdYzbaT2rf/b89EbE42lSCqWoF2qF6s4wOWLtzzSvHwbYsZ?=
 =?iso-8859-1?Q?a4xOruE6GjbOUMX8UzZIxINW6tx1AVkxqwlbqZhkeBhlP4gR14HFSIPUT6?=
 =?iso-8859-1?Q?lz4qg7LgyW12B4i65aY//cSt1Y7rjDg=3D?=
X-Exchange-RoutingPolicyChecked: cul38nt+7D4VyDd0r86dB3VGqqhpU1xUiaN+OYuItPnmPTi+wsdiCh5fqSzLH4Q5aug2v8dYVXHBi0u1QnX9kHs4lAbFnRljerKBRHoZZYkOCsl3hE6kiUEGRVcn6O94akdDsEEJybicR/yFZEwK/DzyUb/WLnsUOb6OXh6J0ecYtOUtY/ie+hw3f4jv+OhD0gFcS+FYnxI99YmUBUmMzoWBFyB4DWK3nUEzw6TrcKYrvDOeDGGBsl0RN4ajqIHq0PKhV99K9adjGqccGAVxTolX+Yk0ASKgLWZCRS+V/dWZ1WIeDVfyk/lrB5j1lfkVUS30dXRJMjkk6sMtAcQ0wg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf608c4-0814-4ae1-565d-08df0ee80715
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 03:03:02.5473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TshE8rIAkUp8BTPUzi6WqV8NalGUomoC+nPy9WvmTp3fjfAbRCkWVEpMCZxNzJsQRUdfaF7HsWBUwC+/Vf59iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB526947
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

On Thu, Sep 03, 2026 at 03:28:05PM +0200, Christian König wrote:
> Remove the embedded dma_resv (_resv) from struct drm_gem_object and use
> dynamically allocated reservations instead. This change aligns with the
> new reference counted dma_resv infrastructure and reduces the size of
> drm_gem_object.
> 
> In drm_gem_private_object_init(), when no external resv is provided,
> allocate a new dma_resv using dma_resv_alloc() instead of initializing
> the embedded _resv field. This allows proper error handling if the
> allocation fails, returning -ENOMEM to the caller.
> 
> The corresponding cleanup in drm_gem_private_object_fini() is simplified
> to only put the resv pointer, removing the redundant put on _resv.
> 
> For TTM buffer objects, add an individual_resv field to track the
> dynamically allocated reservation object for proper cleanup during
> destruction. This ensures we can distinguish between shared and
> individual reservations when freeing resources.
> 
> This change builds on the previous work to make drm_gem_private_object_init()
> return an error code, now utilizing that capability to handle allocation
> failures properly.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Assisted-by: Claude:Sonnet 4
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    | 12 ++---
>  drivers/gpu/drm/drm_gem.c                     |  9 ++--
>  drivers/gpu/drm/i915/gem/i915_gem_object.c    |  1 -
>  drivers/gpu/drm/nouveau/nouveau_bo.c          |  3 --
>  .../gpu/drm/ttm/tests/ttm_bo_validate_test.c  |  2 +-
>  drivers/gpu/drm/ttm/ttm_bo.c                  | 26 ++++++-----
>  drivers/gpu/drm/ttm/ttm_bo_util.c             | 44 +++++++++++++------
>  drivers/gpu/drm/xe/xe_bo.c                    |  8 ++--
>  include/drm/drm_gem.h                         |  9 ----
>  include/drm/ttm/ttm_bo.h                      |  2 +
>  11 files changed, 65 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 20831dbebc31..a168083edab2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -397,7 +397,7 @@ static int amdgpu_amdkfd_remove_eviction_fence(struct amdgpu_bo *bo,
>   */
>  void amdgpu_amdkfd_remove_all_eviction_fences(struct amdgpu_bo *bo)
>  {
> -	struct dma_resv *resv = &bo->tbo.base._resv;
> +	struct dma_resv *resv = bo->tbo.individual_resv;
>  	struct dma_fence *fence, *stub;
>  	struct dma_resv_iter cursor;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 6c5182d54f7d..026821f6da7c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1319,7 +1319,7 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
>  	 * So when this locking here fails something is wrong with the reference
>  	 * counting.
>  	 */
> -	if (WARN_ON_ONCE(!dma_resv_trylock(&bo->base._resv)))
> +	if (WARN_ON_ONCE(!dma_resv_trylock(bo->individual_resv)))
>  		return;
>  
>  	amdgpu_amdkfd_remove_all_eviction_fences(abo);
> @@ -1329,22 +1329,22 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
>  	    adev->in_suspend || drm_dev_is_unplugged(adev_to_drm(adev)))
>  		goto out;
>  
> -	r = dma_resv_reserve_fences(&bo->base._resv, 1);
> +	r = dma_resv_reserve_fences(bo->individual_resv, 1);
>  	if (r)
>  		goto out;
>  
>  	r = amdgpu_ttm_clear_buffer(amdgpu_ttm_next_clear_entity(adev),
> -				    abo, &bo->base._resv, &fence,
> -				    false, AMDGPU_KERNEL_JOB_ID_CLEAR_ON_RELEASE);
> +				    abo, bo->individual_resv, &fence, false,
> +				    AMDGPU_KERNEL_JOB_ID_CLEAR_ON_RELEASE);
>  	if (WARN_ON(r))
>  		goto out;
>  
>  	amdgpu_vram_mgr_set_cleared(bo->resource);
> -	dma_resv_add_fence(&bo->base._resv, fence, DMA_RESV_USAGE_KERNEL);
> +	dma_resv_add_fence(bo->individual_resv, fence, DMA_RESV_USAGE_KERNEL);
>  	dma_fence_put(fence);
>  
>  out:
> -	dma_resv_unlock(&bo->base._resv);
> +	dma_resv_unlock(bo->individual_resv);
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index d2ce18bbddea..480391df556d 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -235,9 +235,11 @@ int drm_gem_private_object_init(struct drm_device *dev,
>  	obj->handle_count = 0;
>  	obj->size = size;
>  	mutex_init(&obj->gpuva.lock);
> -	dma_resv_init(&obj->_resv);
> -	if (!obj->resv)
> -		obj->resv = dma_resv_get(&obj->_resv);
> +	if (!obj->resv) {
> +		obj->resv = dma_resv_alloc();
> +		if (!obj->resv)
> +			return -ENOMEM;
> +	}
>  
>  	drm_gem_gpuva_init(obj);
>  
> @@ -259,7 +261,6 @@ void drm_gem_private_object_fini(struct drm_gem_object *obj)
>  	WARN_ON(obj->dma_buf);
>  
>  	dma_resv_put(obj->resv);
> -	dma_resv_put(&obj->_resv);
>  	mutex_destroy(&obj->gpuva.lock);
>  }
>  EXPORT_SYMBOL(drm_gem_private_object_fini);
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.c b/drivers/gpu/drm/i915/gem/i915_gem_object.c
> index 3f37b0cbb70f..1c73f15d0315 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_object.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_object.c
> @@ -90,7 +90,6 @@ struct drm_i915_gem_object *i915_gem_object_alloc(void)
>  void i915_gem_object_free(struct drm_i915_gem_object *obj)
>  {
>  	dma_resv_put(obj->base.resv);
> -	dma_resv_put(&obj->base._resv);
>  	return kmem_cache_free(slab_objects, obj);
>  }
>  
> diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
> index 67c9d32f4f27..65e1f0c2f984 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_bo.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
> @@ -159,8 +159,6 @@ nouveau_bo_del_ttm(struct ttm_buffer_object *bo)
>  			drm_gem_object_put(nvbo->r_obj);
>  
>  		drm_gem_object_release(&bo->base);
> -	} else {
> -		dma_resv_put(&bo->base._resv);
>  	}
>  
>  	kfree(nvbo);
> @@ -385,7 +383,6 @@ nouveau_bo_new(struct nouveau_cli *cli, u64 size, int align,
>  		return PTR_ERR(nvbo);
>  
>  	nvbo->bo.base.size = size;
> -	dma_resv_init(&nvbo->bo.base._resv);
>  	drm_vma_node_reset(&nvbo->bo.base.vma_node);
>  
>  	/* This must be called before ttm_bo_init_reserved(). Subsequent
> diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
> index e0ecadccccf8..4559352e7115 100644
> --- a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
> +++ b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
> @@ -640,7 +640,7 @@ static void ttm_bo_validate_no_placement_not_signaled(struct kunit *test)
>  	KUNIT_EXPECT_EQ(test, ctx.bytes_moved, 0);
>  
>  	if (bo->type != ttm_bo_type_sg)
> -		KUNIT_ASSERT_PTR_EQ(test, bo->base.resv, &bo->base._resv);
> +		KUNIT_ASSERT_PTR_EQ(test, bo->base.resv, &bo->individual_resv);
>  
>  	/* Make sure we have an idle object at this point */
>  	dma_resv_wait_timeout(bo->base.resv, usage, false, MAX_SCHEDULE_TIMEOUT);
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 999c24251fb7..ecb5f55a0dd1 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -193,13 +193,13 @@ static int ttm_bo_individualize_resv(struct ttm_buffer_object *bo)
>  {
>  	int r;
>  
> -	if (bo->base.resv == &bo->base._resv)
> +	if (bo->base.resv == bo->individual_resv)
>  		return 0;
>  
> -	BUG_ON(!dma_resv_trylock(&bo->base._resv));
> +	BUG_ON(!dma_resv_trylock(bo->individual_resv));
>  
> -	r = dma_resv_copy_fences(&bo->base._resv, bo->base.resv);
> -	dma_resv_unlock(&bo->base._resv);
> +	r = dma_resv_copy_fences(bo->individual_resv, bo->base.resv);
> +	dma_resv_unlock(bo->individual_resv);
>  	if (r)
>  		return r;
>  
> @@ -209,7 +209,7 @@ static int ttm_bo_individualize_resv(struct ttm_buffer_object *bo)
>  		 * the resv object while holding the lru_lock.
>  		 */
>  		spin_lock(&bo->bdev->lru_lock);
> -		drm_gem_object_set_resv(&bo->base, &bo->base._resv);
> +		drm_gem_object_set_resv(&bo->base, bo->individual_resv);
>  		spin_unlock(&bo->bdev->lru_lock);
>  	}
>  
> @@ -218,7 +218,7 @@ static int ttm_bo_individualize_resv(struct ttm_buffer_object *bo)
>  
>  static void ttm_bo_flush_all_fences(struct ttm_buffer_object *bo)
>  {
> -	struct dma_resv *resv = &bo->base._resv;
> +	struct dma_resv *resv = bo->individual_resv;
>  	struct dma_resv_iter cursor;
>  	struct dma_fence *fence;
>  
> @@ -238,8 +238,8 @@ static void ttm_bo_delayed_delete(struct work_struct *work)
>  
>  	bo = container_of(work, typeof(*bo), delayed_delete);
>  
> -	dma_resv_wait_timeout(&bo->base._resv, DMA_RESV_USAGE_BOOKKEEP, false,
> -			      MAX_SCHEDULE_TIMEOUT);
> +	dma_resv_wait_timeout(bo->individual_resv, DMA_RESV_USAGE_BOOKKEEP,
> +			      false, MAX_SCHEDULE_TIMEOUT);
>  	dma_resv_lock(bo->base.resv, NULL);
>  	ttm_bo_cleanup_memtype_use(bo);
>  	dma_resv_unlock(bo->base.resv);
> @@ -273,7 +273,7 @@ static void ttm_bo_release(struct kref *kref)
>  		drm_vma_offset_remove(bdev->vma_manager, &bo->base.vma_node);
>  		ttm_mem_io_free(bdev, bo->resource);
>  
> -		if (!dma_resv_test_signaled(&bo->base._resv,
> +		if (!dma_resv_test_signaled(bo->individual_resv,
>  					    DMA_RESV_USAGE_BOOKKEEP) ||
>  		    (want_init_on_free() && (bo->ttm != NULL)) ||
>  		    bo->type == ttm_bo_type_sg ||
> @@ -316,6 +316,8 @@ static void ttm_bo_release(struct kref *kref)
>  	}
>  
>  	atomic_dec(&ttm_glob.bo_count);
> +	dma_resv_put(bo->individual_resv);
> +	bo->individual_resv = NULL;

individual_resv is set to NULL.

>  	bo->destroy(bo);

vfunc ->destroy() called and this the only call site.

>  }
>  
> @@ -1197,7 +1199,11 @@ int ttm_bo_init_reserved(struct ttm_device *bdev, struct ttm_buffer_object *bo,
>  	bo->pin_count = 0;
>  	bo->sg = sg;
>  	bo->bulk_move = NULL;
> -	drm_gem_object_set_resv(&bo->base, resv ?: &bo->base._resv);
> +
> +	/* Save the original resv object before overwriting it */
> +	bo->individual_resv = dma_resv_get(bo->base.resv);
> +	if (resv)
> +		drm_gem_object_set_resv(&bo->base, resv);
>  	atomic_inc(&ttm_glob.bo_count);
>  
>  	/*
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
> index e080ce60933e..e39448a5015e 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
> @@ -208,7 +208,7 @@ static void ttm_transfered_destroy(struct ttm_buffer_object *bo)

This is the vfunc ->destroy() for transfer destroys.

>  
>  	fbo = container_of(bo, struct ttm_transfer_obj, base);
>  	dma_resv_put(fbo->base.base.resv);
> -	dma_resv_put(&fbo->base.base._resv);
> +	dma_resv_put(fbo->base.individual_resv);

fbo->base.individual_resv should always be NULL per above comments.

Not functionally incorrect as dma_resv_put has a NULL check, but this
confused me in my analysis of the refcounting.

Can we either delete this or WARN_ON_ONCE(fbo->base.individual_resv) to
future proof this?

Otherwise Xe, TTM, and DRM changes LGTM.

Matt

>  	ttm_bo_put(fbo->bo);
>  	kfree(fbo);
>  }
> @@ -238,12 +238,23 @@ static int ttm_buffer_object_transfer(struct ttm_buffer_object *bo,
>  	if (!fbo)
>  		return -ENOMEM;
>  
> -	fbo->base = *bo;
>  
>  	/**
>  	 * Fix up members that we shouldn't copy directly:
>  	 * TODO: Explicit member copy would probably be better here.
>  	 */
> +	fbo->base = *bo;
> +
> +	fbo->base.individual_resv = dma_resv_alloc();
> +	if (!fbo->base.individual_resv) {
> +		ret = -ENOMEM;
> +		goto error_free;
> +	}
> +
> +	if (bo->type != ttm_bo_type_sg)
> +		fbo->base.base.resv = dma_resv_get(fbo->base.individual_resv);
> +	else
> +		dma_resv_get(fbo->base.base.resv);
>  
>  	atomic_inc(&ttm_glob.bo_count);
>  	drm_vma_node_reset(&fbo->base.base.vma_node);
> @@ -251,19 +262,16 @@ static int ttm_buffer_object_transfer(struct ttm_buffer_object *bo,
>  	kref_init(&fbo->base.kref);
>  	fbo->base.destroy = &ttm_transfered_destroy;
>  	fbo->base.pin_count = 0;
> -	if (bo->type != ttm_bo_type_sg)
> -		fbo->base.base.resv = &fbo->base.base._resv;
>  
> -	dma_resv_init(&fbo->base.base._resv);
>  	fbo->base.base.dev = NULL;
> -	ret = dma_resv_trylock(&fbo->base.base._resv);
> +	ret = dma_resv_trylock(fbo->base.individual_resv);
>  	WARN_ON(!ret);
>  
> -	ret = dma_resv_reserve_fences(&fbo->base.base._resv, TTM_NUM_MOVE_FENCES);
> +	ret = dma_resv_reserve_fences(fbo->base.individual_resv,
> +				      TTM_NUM_MOVE_FENCES);
>  	if (ret) {
> -		dma_resv_unlock(&fbo->base.base._resv);
> -		kfree(fbo);
> -		return ret;
> +		dma_resv_unlock(fbo->base.individual_resv);
> +		goto error_unref;
>  	}
>  
>  	if (fbo->base.resource) {
> @@ -281,6 +289,14 @@ static int ttm_buffer_object_transfer(struct ttm_buffer_object *bo,
>  
>  	*new_obj = &fbo->base;
>  	return 0;
> +
> +error_unref:
> +	dma_resv_put(fbo->base.individual_resv);
> +	dma_resv_put(fbo->base.base.resv);
> +
> +error_free:
> +	kfree(fbo);
> +	return ret;
>  }
>  
>  /**
> @@ -618,7 +634,7 @@ static int ttm_bo_move_to_ghost(struct ttm_buffer_object *bo,
>  	if (ret)
>  		return ret;
>  
> -	dma_resv_add_fence(&ghost_obj->base._resv, fence,
> +	dma_resv_add_fence(ghost_obj->individual_resv, fence,
>  			   DMA_RESV_USAGE_KERNEL);
>  
>  	/**
> @@ -632,7 +648,7 @@ static int ttm_bo_move_to_ghost(struct ttm_buffer_object *bo,
>  	else
>  		bo->ttm = NULL;
>  
> -	dma_resv_unlock(&ghost_obj->base._resv);
> +	dma_resv_unlock(ghost_obj->individual_resv);
>  	ttm_bo_put(ghost_obj);
>  	return 0;
>  }
> @@ -802,14 +818,14 @@ int ttm_bo_pipeline_gutting(struct ttm_buffer_object *bo)
>  	if (ret)
>  		goto error_destroy_tt;
>  
> -	ret = dma_resv_copy_fences(&ghost->base._resv, bo->base.resv);
> +	ret = dma_resv_copy_fences(ghost->individual_resv, bo->base.resv);
>  	/* Last resort, wait for the BO to be idle when we are OOM */
>  	if (ret) {
>  		dma_resv_wait_timeout(bo->base.resv, DMA_RESV_USAGE_BOOKKEEP,
>  				      false, MAX_SCHEDULE_TIMEOUT);
>  	}
>  
> -	dma_resv_unlock(&ghost->base._resv);
> +	dma_resv_unlock(ghost->individual_resv);
>  	ttm_bo_put(ghost);
>  	bo->ttm = ttm;
>  	return 0;
> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index 6df7ef07ec0b..422fe4bddf00 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
> @@ -1660,7 +1660,7 @@ static bool xe_ttm_bo_lock_in_destructor(struct ttm_buffer_object *ttm_bo)
>  	 * always succeed here, as long as we hold the lru lock.
>  	 */
>  	spin_lock(&ttm_bo->bdev->lru_lock);
> -	locked = dma_resv_trylock(&ttm_bo->base._resv);
> +	locked = dma_resv_trylock(ttm_bo->individual_resv);
>  	spin_unlock(&ttm_bo->bdev->lru_lock);
>  	xe_assert(xe, locked);
>  
> @@ -1689,14 +1689,14 @@ static void xe_ttm_bo_release_notify(struct ttm_buffer_object *ttm_bo)
>  	 * TODO: Don't do this for external bos once we scrub them after
>  	 * unbind.
>  	 */
> -	dma_resv_for_each_fence(&cursor, &ttm_bo->base._resv,
> +	dma_resv_for_each_fence(&cursor, ttm_bo->individual_resv,
>  				DMA_RESV_USAGE_BOOKKEEP, fence) {
>  		if (xe_fence_is_xe_preempt(fence) &&
>  		    !dma_fence_is_signaled(fence)) {
>  			if (!replacement)
>  				replacement = dma_fence_get_stub();
>  
> -			dma_resv_replace_fences(&ttm_bo->base._resv,
> +			dma_resv_replace_fences(ttm_bo->individual_resv,
>  						fence->context,
>  						replacement,
>  						DMA_RESV_USAGE_BOOKKEEP);
> @@ -1704,7 +1704,7 @@ static void xe_ttm_bo_release_notify(struct ttm_buffer_object *ttm_bo)
>  	}
>  	dma_fence_put(replacement);
>  
> -	dma_resv_unlock(&ttm_bo->base._resv);
> +	dma_resv_unlock(ttm_bo->individual_resv);
>  }
>  
>  static void xe_ttm_bo_delete_mem_notify(struct ttm_buffer_object *ttm_bo)
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index f889232e8525..8aed680bfca2 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -385,15 +385,6 @@ struct drm_gem_object {
>  	 */
>  	struct dma_resv *resv;
>  
> -	/**
> -	 * @_resv:
> -	 *
> -	 * A reservation object for this GEM object.
> -	 *
> -	 * This is unused for imported GEM objects.
> -	 */
> -	struct dma_resv _resv;
> -
>  	/**
>  	 * @gpuva: Fields used by GPUVM to manage mappings pointing to this GEM object.
>  	 *
> diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
> index 32791c4db2a9..f132caa9647f 100644
> --- a/include/drm/ttm/ttm_bo.h
> +++ b/include/drm/ttm/ttm_bo.h
> @@ -77,6 +77,7 @@ enum ttm_bo_type {
>   * @bdev: Pointer to the buffer object device structure.
>   * @type: The bo type.
>   * @page_alignment: Page alignment.
> + * @individual_resv: Individual resv for destruction
>   * @destroy: Destruction function. If NULL, kfree is used.
>   * @kref: Reference count of this buffer object. When this refcount reaches
>   * zero, the object is destroyed or put on the delayed delete list.
> @@ -107,6 +108,7 @@ struct ttm_buffer_object {
>  	struct ttm_device *bdev;
>  	enum ttm_bo_type type;
>  	uint32_t page_alignment;
> +	struct dma_resv *individual_resv;
>  	void (*destroy) (struct ttm_buffer_object *);
>  
>  	/*
> -- 
> 2.43.0
> 
