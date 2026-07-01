Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBB6C43602
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 00:46:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B99C10E286;
	Wed,  1 Jul 2026 00:46:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="M+JxqA0f";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A62B910E286;
 Wed,  1 Jul 2026 00:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782866796; x=1814402796;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=doIpP524x+uUhm30Gecx+P3kJ37JIrFAJZu1//l4MQw=;
 b=M+JxqA0f1fug7IQTbccwMzyUf1oz+q/P9zPD0TCyL8rRyh494Tezr90d
 D634dTG3jUKLgOYuXqbZjBtybvOo9ee0D1bs3/Nlq4UcYgkYniXLMtc+g
 I+fJD6F5iHSs1bPN5gXniHV8hng0J40W8hf83ftb8y0puS69MYQZDaVsy
 4ytO+Xg5RU0/t/RuBPO4URk/iFGVfe3GxSH4WcksIaYCmP8jRlgxzdVxL
 LfINS/BTR0O4sA25xlppCCBQaxhBR6+ek+Kw1pc5c22GZ+Xz7tWQ/FxZC
 uYTcnAk2vTKwGAfx+RpC5JSKhwOd4XUE6Vl3vZ3gM9B71wVhShkPsJU/7 g==;
X-CSE-ConnectionGUID: BLq1mAdWT1OHI5FJJawZ4Q==
X-CSE-MsgGUID: m+eJ9uJoS2+Ob/Gv1SQd+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="101134652"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; d="scan'208";a="101134652"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 17:46:32 -0700
X-CSE-ConnectionGUID: 939PqiZ8RmSc2o+BH8+AzA==
X-CSE-MsgGUID: ItVLt4yBSlOzCrPDMrKq8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; d="scan'208";a="276716128"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 17:46:31 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 17:46:31 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 30 Jun 2026 17:46:31 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.16) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 17:46:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvotZFwOELFX9KrGJthVwI1AhSH+BZBQhvFr66Vfsysi8fiMi/ostbatHXsmIK4KTerA902C8JgPGa+/XSVFqAEV4i24h368VrmJPk3uWAxOQTuUocP74h5OTlkya1RWGtEGEDECLCZ1pf6F8aIMVBcNGajNYeSSNt6BTgzJVzGDnoviEb5xDu1PNb5FwLrunPxmsI1u5wthFGPlqJ0D8jFAti9mZkDmlvqKQ5IZ1bH4nCmWfg416jwaWvKFfEwyaB1MIBSFVOYirqXsHPw98K9saoCPEKudMFVq8EkYhEG4X/3rqmAA3KFXfk/1Uf6nrU16ray9eDQL7KwyXQTNDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ik+LO7AOvFSMPBSmRLJLxk9J6Y4kIc/XBFdD3CLPuag=;
 b=X1P1DMLff1e/ilH9/1KYwN5Gj6dGaakNjc8oZi9b80VM5fXGEILDWoo3EcTDXAo0kxLxUgpCmOZnjR+Q0xmsoU7vaopDSV5E72BlTEOfOlPusMIxWsr1AigxaOikf4/keJ1GcE0+98M566JHmWHihHrL1uxO2kj1lTupblx1fSdLRXprMAzGKsBTC7qStaGPHzcSmIRhGDyaAeCxovDD+JHgDLHYFuLsx+hIcHtDxVleLVQNc9CWcuf0mfpco7x1v1JkO7aLu6l3334jO2qg6tlxXFreuhRV79o78QDwG5u2nclmjWuf9RkcxNsz9qrg9AIuoLoVrGlhnLhyglqNAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SA0PR11MB4608.namprd11.prod.outlook.com (2603:10b6:806:94::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Wed, 1 Jul
 2026 00:46:29 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 00:46:29 +0000
Date: Tue, 30 Jun 2026 17:46:26 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Honglei Huang <honghuan@amd.com>
CC: <rodrigo.vivi@intel.com>, <thomas.hellstrom@linux.intel.com>,
 <dakr@kernel.org>, <intel-xe@lists.freedesktop.org>, <Ray.Huang@amd.com>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v3 3/3] drm/gpusvm: publish dpagemap early to avoid
 device mapping leak on error
Message-ID: <akRjYiONnxxaBjA7@gsse-cloud1.jf.intel.com>
References: <20260630070859.372954-1-honghuan@amd.com>
 <20260630070859.372954-4-honghuan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260630070859.372954-4-honghuan@amd.com>
X-ClientProxiedBy: SJ0PR13CA0154.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::9) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SA0PR11MB4608:EE_
X-MS-Office365-Filtering-Correlation-Id: 24b63c2c-6e85-41ed-4430-08ded70a2fff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|4143699003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: NE7GcvtBW5l+BCoMnPgIh1D+42k5wkzN4ppYO9aRuRyXMYbZyF+in27SwPIj91LT/DX1Te1p+zcUEpzPA3mbV/cq5VqIIdOyp0MW0aS5008e1M0Mu+5Y3/x6ZeUdf2Y0dTyiE9ZC3Y9Ase7Wwv5w6UCOTxSmqGRRmWH2dlfBIgNijFLbRljzvD27xro0pZOqlbjS9JEcL9MQTI1/e4Qv57PBcFYquW9zKJg2LdbInSmLSt8HBhei4IokvQT3oruveIzZbLCAgtLEVgarRgUkLCdCIVIjln/o1Vso+Fh/ZD1nXV7tdQILVFHdkF6LKA720cGBK2J8KfCGrC4351eR9bWVdbbNn3LDy7g4JzTEhk1RuAn+qf+c8bngB0oyOiec843oELKRRLXpyzWZ/m8E2sM2NPLenF0ARiX1xfpl748kFnceJOV+dIdhjzFCzau0M7GMHcBRQSkSL8aVlyLfb4juXT1ePkeZ98VBGenSvjy9DQQPJB/EiYn152ABpRBJQbdP928qGqSrQZ8hHz1YdVgoWg4cCZS6YO9CJX2PRU+gzSkvx5EB13rwGJ6g9E53lnHael043WxCeadbG17gGejnnvgZbarcpzeg6fe1DLQoA+/FkUPXok5g2SKs115wPDQz8TjTBcIPIUKRxOPe82r8GSViaFaYQEUuTJFoSRw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EGRPAMRQ0qPsCZMmRjbmKNjXj0SEhrStP7y5Qye9683ap8nPk5pF4H5yNGcI?=
 =?us-ascii?Q?abBO3U4ruGfTehj/PK7bOlwm1dmbBxRIju5gyK0hMwR7kHUq/EvR63kQIAm6?=
 =?us-ascii?Q?s8SFwQ4bvJ9ltxNSaSiX0Zddk92IIkPjTJRux8bueeDFkZ2CobVF32mqgDDZ?=
 =?us-ascii?Q?w9TZvjgMgs+0XjxgiipSvqXJ26J2G9ix0xob4beTFafHsD0N0qj3vc88S2j8?=
 =?us-ascii?Q?WPpQIG4EkAbSK12SF3pxBrou0Bb+7ouUDGKZqasduNFvzIQWq3V75Gb22z1o?=
 =?us-ascii?Q?1K6YxnAN0kRixBh0uKD74pzQkkiw1DNpMY+kKyrE7jTwhKRkqHQuaAJxf8rK?=
 =?us-ascii?Q?9QYZns08UZYGWaJ0hHWeqgioEfJ7gg6hk4BWSMgK2wffh0ccMjTEg8rtZsS/?=
 =?us-ascii?Q?EO3Law5ZpKdsjpt/OTqlYFUViVNXjhwLtZaQlt0evJpZEr3DRwrlqHqId1cc?=
 =?us-ascii?Q?Cna9d5rf4TjUv3eWw/df0mUBfNmpSNO0OPn7nbcG+hVvmb6XcVVI74YGrDxo?=
 =?us-ascii?Q?84po3TnD4OnDcIkQ2g33PbjBWH0UAAFuCpKm8vh8tjXylVhlMGi5kekYop59?=
 =?us-ascii?Q?Jx+u4ypXh2LXZgyX5TaB98uRIZn5RbeLI0N5Trri6hSpcXq3YWZMp1a+9i36?=
 =?us-ascii?Q?yOR5EXNM++vVeH1FHNDPCH5Jl4f+4XZ2yL/pC5+mau96yENwOY5GBRVw7H3K?=
 =?us-ascii?Q?sMw0KVHGUSgwCyrPwhACvxTzkEns3vjfAGZKczLKQLHufw+I8nkHns6YI/tK?=
 =?us-ascii?Q?HuEVu09PsQ7c+d3WtzstEIOnna3DAmMYFz9PXDmg8pPuOrPWBOgiMTfzzi//?=
 =?us-ascii?Q?t2TtCh+UQnacFIHA9mUCWTgel8q/dOcl2vICGIuNyxCXXrEO2wTOxxwu661W?=
 =?us-ascii?Q?GxqVkbF7Giv0bIPtdNxISHS1Sv5WP51KzFzyq+0xBkXQ+toMWq+AFn/4Z04m?=
 =?us-ascii?Q?T8DQOCixiiptnl24cCroTxXHC+WkioKTxIHwRbIBwtfSg7MXmiXtSTRC3SuQ?=
 =?us-ascii?Q?6yje+r0TKP+YPKjlRBsTRzRBBPtgbCi89AUJ/8KbveMgq90t7VND8e5BpuJy?=
 =?us-ascii?Q?smCciw8Ig673YQ+kRpqmZrjZZZBNe1IBqXVNBibPqBgNf8Ti1MLY3ZTT/BTv?=
 =?us-ascii?Q?s4rTgDK60KKTYwvI+2Xj5VTauLiDBG1tBhzvFZA6ux0eCxaOY1NriUl4EJ3X?=
 =?us-ascii?Q?cGZ3EqWAtuRgFwEocVifFvvgbXGtKyrfj8E3d/R7AdB/RDoccf9eGYORkeTX?=
 =?us-ascii?Q?wL3e+WeY873n8OwduODIJTMVUyURkCmr8VNzOpDVy/7A+SO4DHc0A7ysS+fX?=
 =?us-ascii?Q?LUceGvAkdTXwBvnb1gemmCb9Z38X64XZTaSzoooOrNQOkiMiwSEc6iE0jtGK?=
 =?us-ascii?Q?crdYiurJmW4zhJMmh4XD4s3Tyo5LLdv+zzER0BPiPG3na9XBAGaPitGqdZOd?=
 =?us-ascii?Q?ZBn93tR0qyY6gOq+b6hgvNyPM+bbGieBs5Hds1UqBcyCwWsf+z2qwNkUER9T?=
 =?us-ascii?Q?uDoWFkk/a9AbhmrKaDu8vFQtoZM2l1R1hVjpUATlKyj2KvomJW1MF6NuCerf?=
 =?us-ascii?Q?Nu1fGywbPJ/VApUz9j85SnNGWIi4tDJnYKq+mnKyyZG/4wk4rWMfl16WLAeZ?=
 =?us-ascii?Q?HRqRiIqqSRMQvQSsnXvd14ROBJspG/MQsKFGuKvDfrDZa8M5XL+EqC3Ia7C9?=
 =?us-ascii?Q?YKF4G9Zpk9zWXE4G7mfa11pJQ1yZH1FRA7RQ6NEP9PT1XCERBTLiGGaBUPRO?=
 =?us-ascii?Q?nJ/7Ao72iA=3D=3D?=
X-Exchange-RoutingPolicyChecked: no40VLJ884fXaNVkLSeqeZtUnA+A0Gv8JLoQ3IJ/sY08qS+kdpDhRYsi8KLosSAoQuj4cH+4HFJLVmT8Fj9oPrVNGOmYjpCCMcMClcCNsT+y7UX7yu+q3Cind4dt5ttMyI+knqQhOpTuOF9BRzQfsYrf7kmvYvFZPl4eHHNtmr1t8Qk5ex1hnQVs273rMPIYNFCjRC2RtlyV1xXxzrS+QXdpXU4blYQetl3t6ExeONgSdeifsqpqHNc0O5lhygdzOcZaIi8CiDF9iU/TpKWEwswVjYARpCWpKr2YZGcChHrO45BOzTlQclJrC35sQze6titk6rPQQBtDlEhdSDJwPA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b63c2c-6e85-41ed-4430-08ded70a2fff
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 00:46:29.0482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1mtGZlfvfp9Ja+7YzS+R5xRK4ZiQhSScG3w6IblR6+W4sIloiqEgszLTPzk5WkewDhjFb6gHEwrhmYYLzGOIBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4608
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

On Tue, Jun 30, 2026 at 03:08:59PM +0800, Honglei Huang wrote:
> drm_gpusvm_get_pages() only stored the local dpagemap into
> svm_pages->dpagemap on the success path. If a later page failed (e.g.
> -EOPNOTSUPP when ctx->allow_mixed is false) and jumped to err_unmap,
> svm_pages->dpagemap was still NULL, so __drm_gpusvm_unmap_pages() skipped
> device_unmap() and leaked the device mappings already created.
> 
> Assign svm_pages->dpagemap when the first device page is mapped so the
> err_unmap path can device_unmap() those mappings.
> 
> This issue was found by Sashiko AI review.
> 
> Fixes: f70da6f99d4f ("drm/gpusvm: pull out drm_gpusvm_pages substructure")
> Cc: stable@vger.kernel.org

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>  drivers/gpu/drm/drm_gpusvm.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index 44bb19658dd..9a06ff7d260 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
> @@ -1544,6 +1544,16 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  					err = -EAGAIN;
>  					goto err_unmap;
>  				}
> +
> +				/*
> +				 * Set the dpagemap as soon as the first
> +				 * device page is mapped so the err_unmap path
> +				 * can device_unmap() the device mappings that
> +				 * have already been created.
> +				 */
> +				drm_pagemap_get(dpagemap);
> +				drm_pagemap_put(svm_pages->dpagemap);
> +				svm_pages->dpagemap = dpagemap;
>  			}
>  			svm_pages->dma_addr[j] =
>  				dpagemap->ops->device_map(dpagemap,
> @@ -1611,12 +1621,8 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  			goto err_unmap;
>  	}
>  
> -	if (pagemap) {
> +	if (pagemap)
>  		flags.has_devmem_pages = true;
> -		drm_pagemap_get(dpagemap);
> -		drm_pagemap_put(svm_pages->dpagemap);
> -		svm_pages->dpagemap = dpagemap;
> -	}
>  
>  	/* WRITE_ONCE pairs with READ_ONCE for opportunistic checks */
>  	WRITE_ONCE(svm_pages->flags.__flags, flags.__flags);
> -- 
> 2.34.1
> 
