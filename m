Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A677CCDE013
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 08:17:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6B3410F4EA;
	Fri, 26 Jun 2026 08:17:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="MZhxb13T";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1900310F4D8;
 Fri, 26 Jun 2026 08:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782461846; x=1813997846;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Y8A2wQS5NcEX5wqO1gLzhUhKSacpzIOR1zOOoBNFjxQ=;
 b=MZhxb13TcG5mMyipHZImEtDx0njoBbGUwVfWn4ie2XGBIGGIY3h4stWn
 SGX6XxmiZICsEN3oeW46vLUQbUdJsVYvWnSBLu13i88AZaZ079jcSMLbf
 N99BS97ZfPN1ouTBAnPZG2hYQh5GoyMlI8T1a7LdY3f5zmtvezPAEd+MU
 n/xjewFNGc6vQp+lDIhCvoJsPR1/zJbQLU4K46kKttUD66lDhO6PsAKmM
 7nVXocSY8FUWFgS4L3Kp2VwhWIzlMxF81UVMW0CGkBYo14XcyhHAh4jCD
 G5CM+Cj6iQ2+dL8T8uKQ9U51m+yA53pNDSG5vjHzll1RTvQHyGpEz3AP2 A==;
X-CSE-ConnectionGUID: ex+/HbeaSfC1Pmea32aa/w==
X-CSE-MsgGUID: 8xqJww04Q7iXaLen7HzZMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="93841807"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="93841807"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 01:17:25 -0700
X-CSE-ConnectionGUID: lYYifXlPQ76/CuicPv5nOg==
X-CSE-MsgGUID: zMpCEp4+RXCHxQNlFWfNKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="244878854"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 01:17:26 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 01:17:25 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 26 Jun 2026 01:17:25 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.65) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 01:17:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dLFTBNmBswv+jwCzjjI8CbZe9cHTt5Z5xTqE/n5BgaBAc+hbz525qx9auItlPIrhT1Jax4uwUpVPMklV4Wu2mVDUwCz3dKjoGHgNkmUO7yPfUykcWbcBJ4rWH2FKtwaShXJ4SaNIE4mzdnuBF+1XAwwjiqZ0A9hh0wWUgY1OrD9NcRl2NK+WVxB/729oCLDgh4GsUVzK3OjHkvGDyufthr8m8DcfUztb7Z5OhpQzQ8LjpSQDti55Aj+FDU9yOU9r4uJEYVyBKYlDjiu+bujUiZxyI2k7Ufr/OrY9II9bvDtjPlbBgD/yvutnY0rzfV6gWAOEDOe8xCkPiah1odqmuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7W3Twpz4coivDPEWchm4T+C2SAGdNvxa/teuYsdt58=;
 b=RYJchyqCZObrUaaX0xUP7mBcnoFh2Zdoio01Q+UGcZd4h6vsof/8Mb3QkgWVjAqaES2mHeuB1sN5FY241nM/UMzok/pXhK6H9VWyLeJqL/drBVAVpNJs4ygjNTYCVTVo9MdooKSwEk5woH5M7YuYzGA6yL9TjuCK6HCnRHRdJHTjvnPbzs5DDF+WeF4lcCoT2tvQdHKW4pqdQDVMVbmCLL3t7Tn6RQxwiUfG+Q1jOyjA1EasR3O13D2QcqeSO62TLVLrUhK/3dKP1aHf0MXOAw0hc5D1d5/8AtDrAXHqNIbp+KUAIiFHhFleTkQOowZQvSmn++DB5pQ0KAC1WHweVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SA0PR11MB4766.namprd11.prod.outlook.com (2603:10b6:806:92::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 08:17:17 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 08:17:17 +0000
Date: Fri, 26 Jun 2026 01:17:14 -0700
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
Subject: Re: [PATCH v3 5/5] drm/gpusvm: let the drm_gpusvm core context
 purely MM level
Message-ID: <aj41ij15HgTtc1FW@gsse-cloud1.jf.intel.com>
References: <20260618080902.1527255-1-honglei1.huang@amd.com>
 <20260618080902.1527255-6-honglei1.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260618080902.1527255-6-honglei1.huang@amd.com>
X-ClientProxiedBy: SJ0PR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:a03:331::24) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SA0PR11MB4766:EE_
X-MS-Office365-Filtering-Correlation-Id: f9e4d621-05d2-4c86-404f-08ded35b560f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|366016|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: C36aCwhCRZzvzXvn437bEJhQO3AVuz2zFNOFK6QLZj5Ex2KGw9UqnvakPuWLMCFZpIYmf4n4AWt19kzI4kepnILyvTNV8amLFrTeWtyvaSKK5cdStJBtViGFlDXlPYxz+9FUFLRu0rZSpCcXexpUGV9wr2sETjmD5zJwtpPAC6G8i4CWj87bta6OFanwVtBp8OWj7fl3iCadU8HNz/rlnzpOr/WBGovJJQEb+sdCdeY+E0ZhIk00IH/PG1n2d55kYbIfhDvZ7ROf8eOWlsS8BV1OJwG5gaDQbVR6yyCI7gysKiSwU20ZmkcLkVDmEJaYKDVxcCA3/8x4ppdnE/y60koIG199/U35zFyjawGMB30vWEYHH6+GzEQZLRBSjsQLatiOSKexKLSwHXgY35QZ0N9aFU/MAoNdXooGRREp4HR3OrU8smTGX7H7P8Yzk1LH8u/HQumy9ZBcCc4+BHFR+p6+DrBNVn92CqR1h5YLAyS1qxYUf1pTsRpe0yTTcaragQ4iL7uVO4C21htY6+CBsW/4AxaUaHcMD/hvE++aadykwSdcXMebgLx9Zd/Sc557vc9TQoKnhNeFOLItFt/acIjFQabsanosndW4eWCfoeSxQNX6pVfFq2UIFtylWViFKqgJYJSv4n2PBUlpfYMNIwpBn2ca0QKPEpouBltPRaU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ltGihkH4Xg8Iyc9ILw/sk+15iM5XEC6jZTu7wBVRPYmsJ1r10CqrZgFLK5wB?=
 =?us-ascii?Q?Z6ihSQtT6ROgPcYlaKiVVEDIcceyNqoomBC/PAgL3oO+zowd8pv6FwuzYNGu?=
 =?us-ascii?Q?6kYT/OIeYSrb++3z9JPZQsC2XeIG2S9LdQ+X8rmqPJJLlej8ujIgKM4uMvyr?=
 =?us-ascii?Q?3X3h7Jj1WZacWrKSA+rxAo9yFRNb5bGiSAb92MadSGcA6Epn/ycjVlm6L6jM?=
 =?us-ascii?Q?rO+MWTmy3TITcC0lvspnPIHCGsn9ppD4bg7o1ho5jHwQILgYu+sQ0w24+4Jk?=
 =?us-ascii?Q?/WPfnVsNbxNglNaCwUCOHT0Uw5EQMaf9Sc3VBIujIaq2Leg2g75c1gLhP2Kl?=
 =?us-ascii?Q?Fqbwddbe7tflTbOR4egC9pTVDxqGdYGQSc1AHGlHfQbHrUKtALNUT2bXmFs6?=
 =?us-ascii?Q?0nbYk/LRZp+IH5h1VN5LJ6/DBfuAm+rLPkE7dMLsqDkk7h/ppC+RGas0MbWh?=
 =?us-ascii?Q?j2ZAZwK0eKo6+47T9n6S+Q1DhFIKDyy3M+LNxmy03J/QCc0ui4txi3/5LHC9?=
 =?us-ascii?Q?U8Ik9I3HK3djPbSMcnNtnGnfoN8Bxk0VxTqyE6EtP9NKMMaWKwvh1IsemM4r?=
 =?us-ascii?Q?LkNsG3ZmsypYY7ShSaVjOmTkI5cE331MTONpgYpj1/LUqXBOeBqem36vfC4z?=
 =?us-ascii?Q?rGyWyUCSKs5cWyU9COSGH4psVtJ4vsaw8RQfBbIPHPxz7J1GKH027GTf/OC3?=
 =?us-ascii?Q?nT368JjeOo372xVRwuTumtqx3/U0hMTNNdaypFYl2J/xQaKd+Jct6uG+g3Pu?=
 =?us-ascii?Q?ckWGV7Kg06uv7NVbex9c7hFEfpy7G5txP88rd78HCFCF3wZRJEPOaWYRS4Yo?=
 =?us-ascii?Q?8eC8VsdFPhf4eMIlsRoNpo0MrwxTO40UxQ6fnLiKgrIiUQDQpSvkKiU78U8V?=
 =?us-ascii?Q?ThDHvZwpds1oHVRVUIP2mGWndsA4InZVgq/gsSIFuYkpfpwz5hCxoBujEjK9?=
 =?us-ascii?Q?VH3DZ6FUGILbUGUJVQMHdj9/I/b4g26lnT1RMflgX+mLlK3t2wvY13xr6m+j?=
 =?us-ascii?Q?AXcO/+Sc+iYiUk/5rvKE9grMps2XiqKfP5NQScuKcnOqDw3/xFSjjMe+fOEi?=
 =?us-ascii?Q?gMMXzBVOSO0ODCXdQXpjV3k/3DcYmEFLRjuCS7YRkybZtKwX08VoRtKVYgMG?=
 =?us-ascii?Q?z8nYYBfPCehXB7vs/dxHT9RPzQk2eHvF+7Q/TqIwnK/BnZhPYCP5NDJQyEkS?=
 =?us-ascii?Q?zl9Wq5FtqTs4BmY3QrSL/p5BH8CoVIgUclcdcwtX/CHfxlFNXvMTLbuTSZFw?=
 =?us-ascii?Q?KoQGyB8eJeeVAAeOaErzPThC2zH4p4VfCW5CiJzDaHXE4Xwf5kcDuL9o4B6W?=
 =?us-ascii?Q?9YmoaTDcdZdvlIovF81hdn2NumMpx0vQ6ofNdADQWlwxwM7+0KqGSyDX3uHK?=
 =?us-ascii?Q?iWrfLQ5VbeV1GBXntXSqjaIBpF/dGJmT5ytiXa4aUUdZ0Y29CcsA782hjqaB?=
 =?us-ascii?Q?BV4J+ERC/i5aPxqGgoj+iO43vD3i3eKnrzMJWBb0Xwck5IQjd0GDQVxehYm0?=
 =?us-ascii?Q?ehWOmgOZgd+rpzC+Hkwke4FDCHzNm7iEUmecuTfIrHeEDlcCjtuf+PtgtVbC?=
 =?us-ascii?Q?MTQp9WYSIK772IvA5fKdTu6QF960tpsP1Fb3fPq6N8g971V3qIK/8SFwm0tm?=
 =?us-ascii?Q?szJWFpoZl6/8ZsUgaY4edQDLOQtAm5/RjZHkxvZPyXkvYbVAOTy8Rc+Ix9I0?=
 =?us-ascii?Q?49HY3l+l5A+/E1ReNvXQ8UhgWrmvB8r97PyG37gHpYpazWb/C9jav7dFQzJe?=
 =?us-ascii?Q?InhnUHNMlA=3D=3D?=
X-Exchange-RoutingPolicyChecked: V27gZp90yf7FNLNzmG1g5QpB9Jvt3ckilU1iNikDPt1ZxnWHjg4rUQQZ7Y+3ynx+U+UfFfdvfH3wy/q5Z581zyFvytBt3BP3uzIGkZ9fPbhrE9fumRXrpHsslTk4STjlSbrWmZh37cxXlDV56FM5FsVuayznMelsy05fUDGek70YZWb00bszodbuoe4nOWMbOZNGKUcSrKEiV5sDA7qU1aRGh2GA/ZdhWj3isAoDO4+oUvQoRIBE0GxOT61Ssunp0AvTdO07fKw5QutxUvWcYlGFT0hf9JOoWBx0iJI6U0QxnU032ztZEFIz3k9UrzbiXL3D0TMSLYAVTnekbC3Ikw==
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e4d621-05d2-4c86-404f-08ded35b560f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 08:17:17.4298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fBV+i37uMhYbUqFU++Z1jiv0pFFtJ3se7Fms1/9PG99UCL1OntOx1rFzcOzhS28DKRYpY9MmO1qoEXH7OkqbTg==
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

On Thu, Jun 18, 2026 at 04:09:02PM +0800, Honglei Huang wrote:
> From: Honglei Huang <honghuan@amd.com>
> 
> The core mechanism of drm_gpusvm is HMM, which is fundamentally an
> MM side subsystem. A drm_device, enters the picture on the device side at
> DMA mapping / GPU bind.
> 
> So move struct drm_device from struct drm_gpusvm in drm_gpusvm. Let
> drm_gpusvm keep its core neutral and leave device side decisions to
> the driver. Make drm_gpusvm a pure MM level object.
> 
>   - Move the drm_device from struct drm_gpusvm. drm_device now stored in
>     drm_gpusvm_pages.
>   - Drop the drm parameter from drm_gpusvm_init()
>   - Update the xe call sites in xe_svm_init() and other callers.
> 
> drm_device does not disappear from the framework, it is
> relocated onto each drm_gpusvm_pages where DMA actually happens.
> 
> Suggested-by: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>  drivers/gpu/drm/drm_gpusvm.c | 8 ++++----
>  drivers/gpu/drm/xe/xe_svm.c  | 4 ++--
>  drivers/gpu/drm/xe/xe_svm.h  | 2 +-
>  include/drm/drm_gpusvm.h     | 4 +---
>  4 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index 842bfb37a36..9d5badb038a 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
> @@ -433,7 +433,6 @@ static const struct mmu_interval_notifier_ops drm_gpusvm_notifier_ops = {
>   * drm_gpusvm_init() - Initialize the GPU SVM.
>   * @gpusvm: Pointer to the GPU SVM structure.
>   * @name: Name of the GPU SVM.
> - * @drm: Pointer to the DRM device structure.
>   * @mm: Pointer to the mm_struct for the address space.
>   * @mm_start: Start address of GPU SVM.
>   * @mm_range: Range of the GPU SVM.
> @@ -447,7 +446,9 @@ static const struct mmu_interval_notifier_ops drm_gpusvm_notifier_ops = {
>   * This function initializes the GPU SVM.
>   *
>   * Note: If only using the simple drm_gpusvm_pages API (get/unmap/free),
> - * then only @gpusvm, @name, and @drm are expected. However, the same base
> + * then only @gpusvm and @name are expected. The @drm drm_device for dma
> + * mappings is bound per-pages via drm_gpusvm_init_pages() before the first
> + * drm_gpusvm_get_pages() call. However, the same base
>   * @gpusvm can also be used with both modes together in which case the full
>   * setup is needed, where the core drm_gpusvm_pages API will simply never use
>   * the other fields.
> @@ -455,7 +456,7 @@ static const struct mmu_interval_notifier_ops drm_gpusvm_notifier_ops = {
>   * Return: 0 on success, a negative error code on failure.
>   */
>  int drm_gpusvm_init(struct drm_gpusvm *gpusvm,
> -		    const char *name, struct drm_device *drm,
> +		    const char *name,
>  		    struct mm_struct *mm,
>  		    unsigned long mm_start, unsigned long mm_range,
>  		    unsigned long notifier_size,
> @@ -473,7 +474,6 @@ int drm_gpusvm_init(struct drm_gpusvm *gpusvm,
>  	}
>  
>  	gpusvm->name = name;
> -	gpusvm->drm = drm;
>  	gpusvm->mm = mm;
>  	gpusvm->mm_start = mm_start;
>  	gpusvm->mm_range = mm_range;
> diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
> index 77af0a8de63..7c4e40809e6 100644
> --- a/drivers/gpu/drm/xe/xe_svm.c
> +++ b/drivers/gpu/drm/xe/xe_svm.c
> @@ -906,7 +906,7 @@ int xe_svm_init(struct xe_vm *vm)
>  			return err;
>  		}
>  
> -		err = drm_gpusvm_init(&vm->svm.gpusvm, "Xe SVM", &vm->xe->drm,
> +		err = drm_gpusvm_init(&vm->svm.gpusvm, "Xe SVM",
>  				      current->mm, 0, vm->size,
>  				      xe_modparam.svm_notifier_size * SZ_1M,
>  				      &gpusvm_ops, fault_chunk_sizes,
> @@ -920,7 +920,7 @@ int xe_svm_init(struct xe_vm *vm)
>  		}
>  	} else {
>  		err = drm_gpusvm_init(&vm->svm.gpusvm, "Xe SVM (simple)",
> -				      &vm->xe->drm, NULL, 0, 0, 0, NULL,
> +				      NULL, 0, 0, 0, NULL,
>  				      NULL, 0);
>  	}
>  
> diff --git a/drivers/gpu/drm/xe/xe_svm.h b/drivers/gpu/drm/xe/xe_svm.h
> index 1423ab2f1d6..63ea991e2cb 100644
> --- a/drivers/gpu/drm/xe/xe_svm.h
> +++ b/drivers/gpu/drm/xe/xe_svm.h
> @@ -235,7 +235,7 @@ static inline
>  int xe_svm_init(struct xe_vm *vm)
>  {
>  #if IS_ENABLED(CONFIG_DRM_GPUSVM)
> -	return drm_gpusvm_init(&vm->svm.gpusvm, "Xe SVM (simple)", &vm->xe->drm,
> +	return drm_gpusvm_init(&vm->svm.gpusvm, "Xe SVM (simple)",
>  			       NULL, 0, 0, 0, NULL, NULL, 0);
>  #else
>  	return 0;
> diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
> index 5edfa7d0c36..f40b52e3ae7 100644
> --- a/include/drm/drm_gpusvm.h
> +++ b/include/drm/drm_gpusvm.h
> @@ -195,7 +195,6 @@ struct drm_gpusvm_range {
>   * struct drm_gpusvm - GPU SVM structure
>   *
>   * @name: Name of the GPU SVM
> - * @drm: Pointer to the DRM device structure
>   * @mm: Pointer to the mm_struct for the address space
>   * @mm_start: Start address of GPU SVM
>   * @mm_range: Range of the GPU SVM
> @@ -219,7 +218,6 @@ struct drm_gpusvm_range {
>   */
>  struct drm_gpusvm {
>  	const char *name;
> -	struct drm_device *drm;
>  	struct mm_struct *mm;
>  	unsigned long mm_start;
>  	unsigned long mm_range;
> @@ -271,7 +269,7 @@ struct drm_gpusvm_ctx {
>  };
>  
>  int drm_gpusvm_init(struct drm_gpusvm *gpusvm,
> -		    const char *name, struct drm_device *drm,
> +		    const char *name,
>  		    struct mm_struct *mm,
>  		    unsigned long mm_start, unsigned long mm_range,
>  		    unsigned long notifier_size,
> -- 
> 2.34.1
> 
