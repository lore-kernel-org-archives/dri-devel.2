Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69297C61DFD
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 21:04:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43E1310EAF8;
	Mon, 31 Aug 2026 21:04:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cMiysF1Q";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5033E10EA2E;
 Mon, 31 Aug 2026 21:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788210243; x=1819746243;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=Sj7XIDMkvQ5asFiGlRQc7RfFHZNc0/eiIaVKZRVSs/M=;
 b=cMiysF1Qcdqyiz+Y3TuYJFq+Z+HseUda6ZSPy+rk70oKxlEazETDbIHm
 THXni6IAQ598bu9hs3901cVQYqA7BeiaIphsMHLr0MXUWBtzCNZPS/vZ8
 vJLXJuEnpQE0otT9eFNdDB1iIaGeFqbhLaHfgrckjB+77EsWQ1ICslbYJ
 NHLtzNQAfPO9D5Gf6KMN3mCDYnqeAPX5xg09M3NNt3xKQqqcxxtiRv7Zg
 fSJhlRaxJ0lmbuOQWA9QqWp6dcauQNRGO/4qU4WWTiOSpzCGmB9kU5XGW
 qjF9nknx0PJXM9G1K4h67ADWKZhXxF4XW/qVqcYifNBHN7/dwuvJrPQlU g==;
X-CSE-ConnectionGUID: k/687lTHR+WVbH49plBSBA==
X-CSE-MsgGUID: Ykh2O2v6SCu2Ib4+zVbO4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="106148777"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="106148777"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 14:04:03 -0700
X-CSE-ConnectionGUID: 4+N4GbnLRga3mSP3SIK7QQ==
X-CSE-MsgGUID: fw+2z8iCRySqBKhZd9UvwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="270814786"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 14:04:02 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 14:04:02 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 31 Aug 2026 14:04:02 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.19) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 14:04:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vO9z0JGt5Pj2/rJf8gJ9vUusA3ldRMaEuIupFjD7db1UHlEhpw2LSjmaE+tZJg5OvreBjXSxT41Wmk92hAo+X+lX4uHrNfTBsfv8kFaxMOpDxIIkut0j7FhHDNubgIswR0gApxjS0pxVDWx82Njs8tPOX4479pOnfMS6ECc4PC0qer/Ubp/3UZzLD2p8UHG1GPis44H/FznjZAFXo+7W2lJ3NqTPv1nhewsJXv3oy9i73ze6KO/U+sE+ailkxrmHvYOH4x9ne8tkTlTCdWxUVsnIoIHO2qStS/D6G3TxGOmEUo4yFSF1xaRJAO4Y0vZsj+tI9KoFnKca6eWSLeKkFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5+vWItf19QSIEhmMSSL8ptk/4Dng9EG/Cz0OwdA5d0=;
 b=sM1I8NK8vY6Iyr6rZ+XcvOwru06vwELrG9zuqqxCyJ65Eh+cdgHBJjO5/za2LG+Zl7PM1eP94L6MrT9e039L2UyIFeqxym+Y4j2wsQpRIOMBHNLr3yAOJcy1Ygnsk+qP+144NJ7hXa8hapTdPAWONo1VqaBE4vq67GPwq3NujW+Qm50+TcIuNj+mkdXSJhlxeQ38FVeoxGoMfqK810LwQq6d1S+hNborBndb6Xykq1kSVggIk6j/ESg7mJQkmn48KjZSYbacZnTv9MtIynCfhPRhUaDguMpt4VQJmJIVghTNXTowZ/KUhSoIFVe7Y5W/m7VmFKCDhrgqmnyOL3feZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by DS0PR11MB7481.namprd11.prod.outlook.com (2603:10b6:8:14b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 21:03:59 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 21:03:59 +0000
Date: Mon, 31 Aug 2026 17:03:54 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Arvind Yadav <arvind.yadav@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <matthew.brost@intel.com>, <himal.prasad.ghimiray@intel.com>,
 <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 10/13] drm/xe/ttm: Reject VRAM allocations on wedged
 devices
Message-ID: <apXsOmtkE6Za_8ML@intel.com>
References: <20260827101801.1247654-1-arvind.yadav@intel.com>
 <20260827101801.1247654-11-arvind.yadav@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260827101801.1247654-11-arvind.yadav@intel.com>
X-ClientProxiedBy: SJ0PR13CA0071.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::16) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|DS0PR11MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: f9b64345-6b48-4094-9c79-08df07a3607f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ePVomXcXXcz/MyTfwGKjIsmXr2EEKqEtxuv+mi843/uJXaBaafIv4NnBtrRabSbdbME2WBH1XHocY7nlGcM/QxTZZ9juG8oXa0P5P27UNdKUlSwWZX6aBxxnOm5VOuJDvLx+mnODCgzLa5eUT0uNdCAOt0u+iXhuG+SAY+uSk4P8WjE7uXV9hfZLh7PaEkKNHRD89sPeYsTs8j6iyFegOnhvYVN8KG8ETe0QZUPAfoc/trHAcq0uFN4r+qWBHXGPni9MVlKzIGL+8kI0O+fiITg/VCtc2ixQ2JV6qj7FKHt03XrXAOCqbi5G8h2jg+TmFrYkIZu23GmxrJ/DQcEzBQ/nGDFGdU7zl098f2AdcjJLU2gotNPAnJQMO0iM4VCwECsyGHysFnLj0PBF0kJEn1NEZ1xD5UC88ER8e++8mjAKsFZOFAgUzgm0CsRVx1+FZCdBS2mAsrzOtKOAjJcoEKf4VbRCLRPKIdRabdgEID0swZoF9BR5s6T0R9tBX77F6+Jeg86zZ1wlGksuv7RAIvjOn5UEYGJF3dFC9szPgD4x2kpNRxUfZhIOFMjQ1bkgArSDoXqOZT2dotN5y1VnWV9ACIVTUUuiwUz+icx7FOwFB8L5DpKZM1/H4HPt/u1Jm2GW+WEAx4ovY0oSAeOjTaAs1n8YgYLWCp4V8zPZmNQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?gBbxRbSmucYVLQtOHtet1oBnSJ+BW7CXXHNd3S5OINvm0yQdsVLkGgBMeH?=
 =?iso-8859-1?Q?hDWRnWJw67yXyTuA2u7sC8ZVAeuzeGp2ILlvOhXZ4Tfc0e9SV6D/mcENf2?=
 =?iso-8859-1?Q?9jPR7fPTVD88BETePcL84tRiHT1SFXnTV3CO00nzHMEw2O7AilJ2CsJ7ea?=
 =?iso-8859-1?Q?aaCvpHI4djUxWQ4uuVGXyUD219amOt2Cuc8Zr+8sDtRjuaEWC4qMUtnJsV?=
 =?iso-8859-1?Q?qPGvESxRpVOHS1hSfBg5lXKix3yZWeqWYhsffmNnY6SL0btLjorUJqdeSt?=
 =?iso-8859-1?Q?EQCTYURo1RtAFgselAFd1DqwriiXU/ptArryDMqpugGvCwvF6eyn+o6tHf?=
 =?iso-8859-1?Q?rgs0aolz9Kde2wqvBvmGtHZIFXuYhhWSNuZBOUmtMYOs2B9pCEejzryOl6?=
 =?iso-8859-1?Q?epwBJmKRVWedvuyrPBooPd8m3XXPg6gI4II6dFvh+jd7fL0hnmoY6Kj+vK?=
 =?iso-8859-1?Q?x5nMg94vjgfXmdtaZkAY5iS5v6UzbsW8CAfANcmdJnqDt9oAJX/D2Y60b1?=
 =?iso-8859-1?Q?iCeE9aUfMAlbsRvuV9niT0ypY9Ke4EsL7yot0WsB9JvmpHSlOVFzLYoSaC?=
 =?iso-8859-1?Q?4I5EGtEVmfBOvwSSQRHToe9ant7g7vctxksL3Ipssisq/INil8oHvTSy1M?=
 =?iso-8859-1?Q?1gKwY5SRfpiPe61nnetCe3tUVfXDudTp2AZCcXhsFTtu0YK/6h7wSSFsf+?=
 =?iso-8859-1?Q?oKZudledP9EPYJC/XX/QbeMAZdTjM6+s9Fe5ZZfcHt/FbpyemuLL8lyQwZ?=
 =?iso-8859-1?Q?kVl2LlZpl7HiefPk2U5DyTKj9GyVjP8/t2o1PC6JK6f9ao0fDM+wMbP1cY?=
 =?iso-8859-1?Q?oiUhYZ8XuPuESYWbRkTpNAVGXRV3hB1hnR6XOhWGWjwhCU+aXLpqy9lmdT?=
 =?iso-8859-1?Q?b2R1qsKqJR8MCg5nGCjbt11KrqL0XHHqAY01mrAec6GOKe4xRFcYRhM0U8?=
 =?iso-8859-1?Q?AVf6gGBdcvG7Hti9O5nYjSkybaQ+VK9/lSMj3WjUruN0V2zzIFQE4LgxSR?=
 =?iso-8859-1?Q?d5qyCYTJ9a7yikedboifITl6iLk7qp7zIIRSH+sm6PmKEy+/sPJbzbESPu?=
 =?iso-8859-1?Q?OC1vlo/ae8Piv9ABsPkN+fWk1OuToHaeLFJjyw7mPWRTAT/Pav1EiJtaB6?=
 =?iso-8859-1?Q?i/Y4YsrBEzRYbGWSYlvj2XmYJs9+OTcuz0vqM7st7yEZR1q/JHIKwgSEZS?=
 =?iso-8859-1?Q?zyC69wT6ia/KskRvyIauGC7w6hKnS+8f0NU1vw6Pb0F8Whujso1jwLuxrm?=
 =?iso-8859-1?Q?/oOHghZFduArLYnf6KABv56n6/XL4Lo/pDENUcDHpJfUHsrWyeTo54fDR1?=
 =?iso-8859-1?Q?GWQvZ/f74k1+BVImcCAz0VZcQlyyvPUWWHJ2LLi/ddPyLYm3ykegj3+ySg?=
 =?iso-8859-1?Q?EBfRR7aSMvW/uFg9pCAGpQMOFnZmWlhAOKb3BShsuCe4cp1KhR0P+VdHpO?=
 =?iso-8859-1?Q?eji/q9/dchhpBfv25wrrNWisAbtwk6LJdpee/16s70r7DIRgKWn3BlhtPk?=
 =?iso-8859-1?Q?0XyGxhufGLgy2vk44xnaSKUNh2iyz4refYSuHhUhNGtrJYNV8Zwh8KFv5R?=
 =?iso-8859-1?Q?x8MuFPGWqUSbniGaDxLIRYwlMyOoAWZlUg8LaKxE1JubSVR+SyrnI3Pt0k?=
 =?iso-8859-1?Q?nGNv1Z09tIsZXjeDtlABaa27w3GYXUpQ0aQ2qm0UrmvYk7++aJeGdk74l7?=
 =?iso-8859-1?Q?Uk7ySEaE18PDN27tIOZJngVrYWl78bVBe7xB5uiksMhrfvE0c6gak0wuIv?=
 =?iso-8859-1?Q?IScgJLgVBtgAwZfRb/ZOBZLjvkHmSI5AQsNC2dIneAKDdOEu0WM46kVQLj?=
 =?iso-8859-1?Q?ltWW8B9Pvg=3D=3D?=
X-Exchange-RoutingPolicyChecked: UXtNYjqwoQmNMvBwilGEaAkkj1W6JKfv0x0dPhay/6M2q5mtLy3xsJJXbuoFjH6lLbhUfgw+iItpXVjGl57fnPOVt6Vak0zQs74pf1qeODCITBSVW2E9ozWb5qcvQnPXQQslY/UpJwea9KI0CxtXnejqhtLHR/GUAQskken1HxkBdZub5EL35qSJKOd5WkqnySCFLlobPUBvLQCiPSH/kvobjsXqvQEJQXA4Xu+Lke2QAhOFVViu9IFgXFII5a7TbCeVB/VsK/hPQdg+p8xj3Z3MfVJv4MlAPjD5QCt0Wmh+dLhHlZnv7SJ99qklwRhEPgNdYddI2u0ZhvaxQhkQ4w==
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b64345-6b48-4094-9c79-08df07a3607f
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 21:03:59.2008 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iq2hE9A1iwaKwMYJnpQ4cFnv3pQviqsZZEcU873NZ2cfX9kLSHZHRJtbHz8WWdqZnIyufiGfpsdvW6XHaSXl/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7481
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

On Thu, Aug 27, 2026 at 03:47:58PM +0530, Arvind Yadav wrote:
> VRAM is no longer usable after the device is wedged. Reject new VRAM
> allocations with -ENOSPC so TTM can try another placement, such as TT.
> 
> An allocation racing with the wedge may still complete. The wedged fault
> path prevents new VRAM CPU mappings, and device teardown releases the
> resource.
> 
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_ttm_vram_mgr.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
> index 05911904c1f9..d0b266672010 100644
> --- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
> +++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
> @@ -54,6 +54,7 @@ static int xe_ttm_vram_mgr_new(struct ttm_resource_manager *man,
>  			       const struct ttm_place *place,
>  			       struct ttm_resource **res)
>  {
> +	struct xe_device *xe = ttm_to_xe_device(tbo->bdev);
>  	struct xe_ttm_vram_mgr *mgr = to_xe_ttm_vram_mgr(man);
>  	struct xe_ttm_vram_mgr_resource *vres;
>  	struct gpu_buddy *mm = &mgr->mm;
> @@ -61,6 +62,9 @@ static int xe_ttm_vram_mgr_new(struct ttm_resource_manager *man,
>  	unsigned long lpfn;
>  	int err;
>  
> +	if (xe_device_wedged(xe))
> +		return -ENOSPC;

is -ENOSPC the right return here? -EIO? -ENOENT? -ENODEV? -ENXIO? -EPIPE?

> +
>  	lpfn = place->lpfn;
>  	if (!lpfn || lpfn > man->size >> PAGE_SHIFT)
>  		lpfn = man->size >> PAGE_SHIFT;
> -- 
> 2.43.0
> 
