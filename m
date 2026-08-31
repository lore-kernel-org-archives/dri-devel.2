Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A414C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 21:18:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16DFD10EB0F;
	Mon, 31 Aug 2026 21:18:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HsF4terr";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E013910E2B2;
 Mon, 31 Aug 2026 21:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788211130; x=1819747130;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=bZn6yqmt76xjgbEDq/oyDY3jvkWlPb7ZzSoswfGYrUU=;
 b=HsF4terrJ6ncCbn5+hp9H7JGBzgf/XD5EXJOMgQkKBRUh8GwWP4NgSP3
 40FSIBquBtwRO8dCColJyUZtFAjIWb+Zq9jGPAYNa1bgViPIR3nEUkRyG
 Kz9m9VVTaDkG/6BD5EeVARHP8XvvUtGrlxw4YKKbpH/WJgXdAymC5pNzM
 W4JOc2clrF1o/mv7TnP63v3JHvPgJSgGX+yGIn0IiJQewY+/EZEhAlwed
 NaE7yHhzgK3CXKQpeupkP/M4NDNFatgdA3FNDqLTBY5C21SiPw52hvJUN
 IhFchVUvAYnsaYHWc8njQpVwJbEciov9zpzv9ZBz8LRtBb4cfN1kUMAxL w==;
X-CSE-ConnectionGUID: /lTPUMwvTxqgRjgj4IobyQ==
X-CSE-MsgGUID: jDe+ejxmRyGdG+EQp5C6Cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="99979375"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="99979375"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 14:18:49 -0700
X-CSE-ConnectionGUID: nSH5f6tbQXaHM0lwD1Y1/g==
X-CSE-MsgGUID: twYVGq4+Qd2QkKXi+gYPSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="298794173"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 14:18:49 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 14:18:48 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 31 Aug 2026 14:18:48 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.24) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 14:18:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMCAou3UhbTWeZaUA/wEiQsbwQPRnOKCuBwqW4WlpvNSMT+zwtruw0bvS4Z9QMCKpDtokFOvzL4nWwK295lQbPM7PvI2UKFjIBVHYjwNJ76lSe0VMWX9NVjJyGu+iKY33w0umnu19RX5yi43Kcpbe5oqW1y4S+I6xNxvfqRmC6qKEAt+CL4U0g5v8NQ6JhFAvv6pllsGBBbUfTYG8uOGxL9XTmKUfMKoZVM5YYtAcBeN4FhUTitlSdQJ/V5M+ERf4LaplYT3DfbLVqOIvFEXR2g+ZzAcMxlqWz+G+2wGFH2Aq4MU9j+mG/PcqsbnXUc4DU2Ur7JxOvn7P4i6oSZx/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7eTbyPMs/BvmF3qPJVOprDRZ0f1Fm46b2BR60Xrsbs=;
 b=Urpie0PyeuocjMDuxrzUq7IbBtYN75LoXk/WjZp+MUKsfFw2Slo5W+AW71S7bUBDsUjv+UkcRUQWJJErYCrThvSstligLkQiqHAGo5xzDyey0gTWi1yTqIr5iF+EZ4mSo8NGExDeBzCZSe4CQyg69MvJtK8iSHQDlovp9Nd5PAZQ4Gjtb7N8coCDNW9i3kPYhIl+ozy0ZKATW6oWZIBhNW8iC0Wpbx0UF4D9FOCpByxMkn9nDfULAABJ1HHH4m9CCQr0bMlki/LlXmqHOVKnJX+IG3/Fq89fJo1N407LMtc8O3mkXAXOaeMI6335WIYq68tHpVwHtdwDiDYkkBUXMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by SJ2PR11MB8514.namprd11.prod.outlook.com (2603:10b6:a03:56b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 21:18:38 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 21:18:38 +0000
Date: Mon, 31 Aug 2026 17:18:34 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <yaolu@kylinos.cn>
CC: <ashutosh.dixit@intel.com>, <dri-devel@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <jose.souza@intel.com>,
 <linux-kernel@vger.kernel.org>, <matthew.brost@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <umesh.nerlige.ramappa@intel.com>
Subject: Re: [PATCH v2] drm/xe/oa: Remove sysfs entry on idr_alloc failure in
 xe_oa_add_config_ioctl()
Message-ID: <apXvqnzYi56oQ0L1@intel.com>
References: <apGuQY7vZRIUZghZ@intel.com>
 <20260831014218.28515-1-yaolu@kylinos.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260831014218.28515-1-yaolu@kylinos.cn>
X-ClientProxiedBy: BY5PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::31) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|SJ2PR11MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fb34ae0-0611-42f1-3d69-08df07a56c6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|18002099003|22082099003|4143699003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: K06a8OIy1d8xUkmOF50IrBGBEkBi33I+UaeNb2lP74c4Z8+bKweYN7+esxf2oUg6yQXT93mMESq8grHwBEkarGh9RvODgG90Btum8mGM9FoxAsdUhikLsD7xB3mAXsG2aD+U2pN4Wyan2kLxs1I99G8S379tWHbFMdIADWgcFp0ptoz/+Kp9Pg6ZYJFK3nMRJ03ps5xaGpcEd1kRt8JbDXM6dQjvdVsuJn+BQEodLbB9triTJ2IIWsUXgQ6oxXAFyjuiuQhkwVhyfMk7VFOSF8WcQ68fIgMlnXRNpzEIFtNxm0RJe6MijxMwr2i/eG8veOIPIJ9gLNEH02bWuifRkVhKXd7wP6qv8H8tG46r7+r30HRaBpLSDVzZwLKK2lJCFbCsNlQjIJDTBY8a+be+k/KIRmm4/+ECFw1TDf44LXNqLPT+2PtPSo6NoR0gMOr95Y317yOxlGXDgaQ5lSodVBXrqekYbIZL0LXsrwnjP21mGXP6Q9YPVP6aMuLnyV0S+3cCyr4FQaSr4J3l8TlHn1+6PFp+d0C38cCVmfgsG8DFWTKl6usWugA194g5WlRGmyMIu7efA1UEzoGqFEFN3ylqg6V/sKtkQpK++pFCu8UYKnYrbDN1xUqThz/4MCPalqJjYsHk52/x1hxzg8aYT+BnIKa2VRBd+KUOSYK7p7c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TNhL2NXaVgdOg03hiVuK+CY61Yj1AS3swaxEUea/kUpE2mInyXNVp75ldY7p?=
 =?us-ascii?Q?JdQKZRZ3FirDO50Rb1BIPOO+9qDNU5QFW6G942OvWwZsRa4pQiYABO10WAZP?=
 =?us-ascii?Q?gRkPOw25o2Um76x2OOAlJIZ+XR6T7D3gF1OCph3KuOS52XYuiTJezLAJKJqI?=
 =?us-ascii?Q?3vsG4mZ1ozPagd/FExHrhLD6xNK+CwfMxX52IoeX22ZvmWBbaP0GwmGFX9MV?=
 =?us-ascii?Q?e+27h8dCYmVUd/gbWJbOmKY3HCZH99rXM4/R7uhbBbzGRxpSj84BBjQoLHYP?=
 =?us-ascii?Q?Q9iib+AJ0HztC0NeWUFKwET0u3dRPr3ovpXwVpYmtj5AQfdbHbDFqqzRmzYu?=
 =?us-ascii?Q?W6C6me+2FSNMmlxPTh05Cr1VHqgLpfvj7m52YhwFutH1VpvMfyAziF3rL1fs?=
 =?us-ascii?Q?UR2ld2MivZ50hp2qwuQxCqRYkhAGVVk4k/OSW3WSAWZyXwy62S3porom6+7a?=
 =?us-ascii?Q?l5mrUmuRd0SWN5TAwIT6M81tr7fXjQ8XrCMW8R6VLFTL7YzBcB3ogStKKIow?=
 =?us-ascii?Q?YfIEyA1ooFrIwkHqmoGFTB88rKz9T4+YmFaGlzveIMCf8Ny40lgvtuqwTKo6?=
 =?us-ascii?Q?AIADCluaIKNPBYj82mhCs3hrZy7ziAmQTRmTsrBpaTjqzLTS+jLxHHNTRK/5?=
 =?us-ascii?Q?eAKYJ5wzRh+RCrYmIBIu1RlZ83Xxvg+Iw5NqNa+MIAQbV+YI8FhfebfjdMcJ?=
 =?us-ascii?Q?+eJmbv81ybLA132a/1piAWv3GF2v56WrZxQpy7oI2t9Pl88VklZfVcr+8tb5?=
 =?us-ascii?Q?CQZIjjTVQtD2SmwwQbb0rPQDUp/xq79jpTOaLXSDm0AWxSvLHjT3OKmRGWEK?=
 =?us-ascii?Q?N+9bT+Cp4nFmBrCXqXzH+qXc9i0T8xtl4fRJyNbiS4FEujGrO85qqWx3YiGB?=
 =?us-ascii?Q?RrwHNHSWCmRY76aw/jUwToiub9bnmbySjP5yyHYWRmDeHGB61Au3NJBfvzN4?=
 =?us-ascii?Q?Pp4ibmql3HhJ2RTR5xlMry6aZiE59CNOgBwKOzF9PpR60xH7e1CXi9n2ne8f?=
 =?us-ascii?Q?3cX8p2GPvUyEHyrMjp48bWkRExtCDj4p5lZv2513c2qPBTGYD1Ttr1X4hjRB?=
 =?us-ascii?Q?UOSh39d7HxHCAR7Vybu+kKl5CNC2sEaOF+ZMQCVoK4EjVgcWw+OD7mpdia8v?=
 =?us-ascii?Q?1oKUXscECzOorVL23OGNm8M1zguKdkr/KDa15NBlm8vqQuFt9wUOQsYbFOQF?=
 =?us-ascii?Q?1FJ43VKb+CRSsTIWQgaV5hcatIQZcQ/9f8e7KSuzRRKDPwKPyX6x58WFhnt5?=
 =?us-ascii?Q?hsoHxUWJXZ9DQ8ikuS91Dj1/CYpPYPNtHmQ38btGb2/pdKiyXrOXjDP0P4to?=
 =?us-ascii?Q?WYsRgZVhU4KIjYDfeKJBRONpTaUBnz0RsMqbpeQC0evcjUWmQMZSyPBGrquD?=
 =?us-ascii?Q?QzPtCqvPHZM4hHkQU+2L6dMdNaBudAw3xN8rZszfNPdgckqtFpOUjMAA6Lay?=
 =?us-ascii?Q?qPRl2XjhI/ECnv4ZR1JIavv1HFcNIuJlsKMXi8KBee0ZlIWDf86s/qqV6Mz7?=
 =?us-ascii?Q?twlwNQMvm9KmkhM+FD6mrds9pUYbfOdD01rOx7JYCuAFudC6551YjiL/bx11?=
 =?us-ascii?Q?iSPgVfOFnGnSDogmbnLS89sesulbyXY2m35ZEMCiAClUT9ZYTFMfgDWDwWOf?=
 =?us-ascii?Q?KrP5ogPkq9OotXWLofRsFB9F21+mFMf6LYQc+XbQKnbUmNxs1TAi4tB8iQgU?=
 =?us-ascii?Q?N3YmpNzZ4ZrAzy0PnNoXV7YTZ+BCzzd9VBv9h/7/s2FUsaIw++0cKR9+qnyT?=
 =?us-ascii?Q?zZ5N27jVJA=3D=3D?=
X-Exchange-RoutingPolicyChecked: KImAx023ac5mr0wMU9+iSsGaiaGVmHC/1vV0W2sSzrESjPAdh5OmvGWcXS9U2NbKjMKoeNddydned/F/nnOT7bz0icOCcw5wnfhhzhJYHiM7NK8BQWg1z0IkJXVvwV1PAJkKmla1epaIoja/1y0PuB6++WCEKu3BYlC11qsXkSanWg+TPC1g67cWjcarW/LAdBfPNPZZj5wbnu2/2v9djw/VAVX57dIqfzZ0veBm5VffAGARspQdrMOsDSG8zSfFlAGUdiC7JadMjLwee2YSgTToCbYeJ9uEA9DvmlMlvz0oamFD0EkYoiK2gwdjMrzVSjyW0uqucO8VENBM7yvNxw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb34ae0-0611-42f1-3d69-08df07a56c6f
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 21:18:38.2010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uh6DS4OJN0x073iZ1zMHHG6y4dX0fEYaAnlGIRbRRyxJnNnrSO0GV0B2LeGrtk0JaOPe1bLpucGgOa6Rvarrug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8514
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

On Mon, Aug 31, 2026 at 09:42:18AM +0800, yaolu@kylinos.cn wrote:
> From: Lu Yao <yaolu@kylinos.cn>
> 
> If idr_alloc() fails after create_dynamic_oa_sysfs_entry() has
> succeeded, the error path frees the OA config without removing the
> metrics sysfs group.
> 
> Remove the sysfs group before releasing the config, and fix up the
> misleading error message copied from the sysfs creation failure path.
> 
> Fixes: cdf02fe1a94a ("drm/xe/oa/uapi: Add/remove OA config perf ops")
> Signed-off-by: Lu Yao <yaolu@kylinos.cn>
> ---
>  drivers/gpu/drm/xe/xe_oa.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> ---
> v1->v2: using a new goto suggested by Rodrigo

Thank you

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

and pushed

>   Link: https://lore.kernel.org/all/apGuQY7vZRIUZghZ@intel.com
> 
> diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
> index 9c5384b95c63..ab09dcff5860 100644
> --- a/drivers/gpu/drm/xe/xe_oa.c
> +++ b/drivers/gpu/drm/xe/xe_oa.c
> @@ -2435,9 +2435,9 @@ int xe_oa_add_config_ioctl(struct drm_device *dev, u64 data, struct drm_file *fi
>  
>  	oa_config->id = idr_alloc(&oa->metrics_idr, oa_config, 1, 0, GFP_KERNEL);
>  	if (oa_config->id < 0) {
> -		drm_dbg(&oa->xe->drm, "Failed to create sysfs entry for OA config\n");
> +		drm_dbg(&oa->xe->drm, "Failed to allocate id for OA config\n");
>  		err = oa_config->id;
> -		goto sysfs_err;
> +		goto id_alloc_err;
>  	}
>  
>  	id = oa_config->id;
> @@ -2448,6 +2448,8 @@ int xe_oa_add_config_ioctl(struct drm_device *dev, u64 data, struct drm_file *fi
>  
>  	return id;
>  
> +id_alloc_err:
> +	sysfs_remove_group(oa->metrics_kobj, &oa_config->sysfs_metric);
>  sysfs_err:
>  	mutex_unlock(&oa->metrics_lock);
>  reg_err:
> -- 
> 2.25.1
> 
