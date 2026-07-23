Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDA6C531D0
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 20:40:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56B9910F1F5;
	Thu, 23 Jul 2026 20:40:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="EVq7T/DF";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48AD410F1F5
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 20:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784839243; x=1816375243;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=rJdZ5ebLtA+nNyC1+0LGOY+fondjXr8zYxI52LZIFpQ=;
 b=EVq7T/DFijcTK1wLiUq4EJp5ZwY3imL0ORX9caGzqDGO70cbFni4IP1D
 2jYzi/2Fb/5Vr+QHdcs8JCTcdE6zVXDTy7+lWlAHsKwVYTFhAENq0X5rB
 nCg0nPkMQUx3oT2IYXycc5/3dgQa/2kpTab0KEXgOI9/eUnB99aXCtsdC
 G4uXh929JZyQg2qvQap32jYdtM17Fp8bH4pTaBFzocbiWO3pusCATe+eZ
 PDcY03NBZ3qIsYm292/+ZVqlisOFUdEoFBLxS2gH19MLwGcrlYtGuUJNe
 hEEJq6wPleBWBeUDRjrJZlvx0NDPhv4yPVLHyvqbo6bcih1ukQ6daYd6i w==;
X-CSE-ConnectionGUID: JB3y+Xt7QWGl0hmKjbKGsw==
X-CSE-MsgGUID: blMRgCb9RC6prAtrjO4BDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="89329964"
X-IronPort-AV: E=Sophos;i="6.25,181,1779174000"; d="scan'208";a="89329964"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 13:40:43 -0700
X-CSE-ConnectionGUID: b6UYeug6TXi3wAJnCJW10w==
X-CSE-MsgGUID: 0YE6OU+rSuOD1BQRQHzi1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,181,1779174000"; d="scan'208";a="257985528"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 13:40:42 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 13:40:42 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 13:40:42 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.50) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 13:40:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLTHKr65vJhnXM6wCYRsVd+IrrqydTvXd8fDipX5aJKg+9GWj6zgP8qxs8AoSWgevGbIsqwJXFj8pqJlK4RRva4M+5V+syt7h4AqQMv/mPPCR+gUJl46F69dQmOfHNiuEKeGxFa8vcTzMEQc+YXKQR7eoroBiYI6R7fBx586M6I5NB6w8GItrobRiDYE1ZPl4jbEhxBMCpGgV4zGlqMskE0uJUs46jcbFmi1hQKTnefgLtK6e1Ca9i7tVTcTCezvHH84DbOWLe05GvI6DMJRh4URmFOW2rvSxhA/RN//bCGB4nzB/YeFWvz/AJk2i4GE0rjf+LcUBLcczv8QKGCvlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yChXVcmbNQ3deMNQqgb6C/ktDbspjih6/nwoDC7ThXw=;
 b=DTJlo+5nX4W67lFKn0a/zUy4E/K5kwQPpDZ83jnh1GfB/jYcQXgc38l754vW1iAA3PMlUDg948DgmRdwvX8SePqE2Xf2NAfVvrGFXxHTMFnOC3cRbBnTGOvSBb7UYj7enYz5qkEri6sjImhH4kH7MCmR9Gc9mVc3v+EwTJvc+au+nGxCCiKBFmUEPWGnWaPzo5jC/GWruWCW9f5lOx44nEF04I677oWB+o68AiJdtbkkWshnUnO+pEw4IZJ5mZmMUaZ6Pbx8YeQpPJSofhKaaS8F0EeQToTzBcC7NHG0BldOvw58bQusVjvreKVhnzqgH6ZkF529+NenmsDmvOTInA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by IA0PR11MB7258.namprd11.prod.outlook.com (2603:10b6:208:43d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 20:40:38 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 20:40:37 +0000
Date: Thu, 23 Jul 2026 13:40:34 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Stanislav Kinsburskii <skinsburskii@gmail.com>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, "Himal
 Prasad Ghimiray" <himal.prasad.ghimiray@intel.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH v3] drm/gpusvm: Zero HMM PFNs before scanning ranges
Message-ID: <amJ8QrI2/W+WP1P/@gsse-cloud1.jf.intel.com>
References: <20260723-drm-gpusvm-fixes-v3-1-4346a61d093a@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260723-drm-gpusvm-fixes-v3-1-4346a61d093a@gmail.com>
X-ClientProxiedBy: MW4PR04CA0241.namprd04.prod.outlook.com
 (2603:10b6:303:88::6) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|IA0PR11MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: 56033756-40c0-411b-5c5e-08dee8faa70b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|1800799024|366016|56012099006|10067099003|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: a8JYSH5xGzeY4/jMk+4Du/s7Vj4LWnO82MHRkxvd6lTCvgOUTu10k3ddP3Vj6RCLDUKUEdgHtd8TC7rQDmh99IRfOBI2HOb1RsNUik707j+NiX7z1T+zwzw52arwjxqayUYTYedoF5mSym76oH3gq6fO9cMcsVJmGDOP1y70LzQgmBmmn5yaYAhjIxHwy7NarVq6/wt6YukoNVEkEPZyem1LsOdFjvFTKwzZWFQlKhIyzkGrwrQbkpVX7uhDfP7UWSY49HtdRNrnjxctFdD3OwkFAJCvWe87hrhyljkQUOmeWz8NXKfbB5Cxx1+lhs9iDcOgOPS153JqvwT9Pk7kac1Kov8OBontDpNJZ+b16jxVID+0amOCMjqx3mzmvUabZHOetZMTPb/+FPGYn43cnaYqkfPaLaEL+s4hv+apuISfnG25MO6Vu3K3MgUAd388MrONxVF2syyqwjQhT5FDIwFq6Jgq3m2SVutFg2vsp5jCSLT8Eeo5qg/v9gX5eaI2+NOW7ETfIf4VlJEOj9m7sEJfnwRVGjmzusqk3TvE2wwVQXCICmA1J6GND9GxqNressQCb5AYUAnce+r1IAsHXTOY5eLl/UenzLh30RQ91ZigOGiuI4a+VjpdXb8bNMMIlwWZv/pufrMEz4u2wb/wa29Zl02DR4K6FSL/9g+bbEc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VS6WzdKdce3u1c8aA63fdk/H7rV7+E/tHorxFjwvVL1Js2nexcOoERECzzlj?=
 =?us-ascii?Q?k8VY/A2rWjAPZwYB47IwlUTHyLgyUkqZB6fy8nPUgfzzNbYiEJkBCqwLugzn?=
 =?us-ascii?Q?5Q4CUMmZKteJfLtaijVPytZqmuK7RkS28u2s6As7PnY6YfcjLQ1fBciGjJP6?=
 =?us-ascii?Q?D3n6J6X+I8tyrPWW5jsMkykVQKWPpkS2FRuRAuPm1gUEG10w8SUyeAUdAjdh?=
 =?us-ascii?Q?Kos1rzpGtWHG3CcEK1xYZqFUoO73dth9IHUzcbfXeU1jon9gjfdG8F9O2+d7?=
 =?us-ascii?Q?Ml+pR3myujR6j4/6EXCZUS6ik4ckuVFUxfmK8m3sstQ0BTJOA/v6oeH/ws/D?=
 =?us-ascii?Q?mnfPnqCz9UL9h7CxS3VL2ixuWcq+PASqB2bQgWzwtX3t1vZ6r8WzVf1e3Stf?=
 =?us-ascii?Q?gThXrnMI9udb/6ESpLMu/eT21kO2r9DEOmVK2P1tYDuB1AO/AAHc7/ThvLUQ?=
 =?us-ascii?Q?BN15wwWtWjRwM2ruVBVLC09EB2LoRCUDXSJ0hrfSRHfNQm1QOXCKwHaCuwiU?=
 =?us-ascii?Q?oKwGyPh3BodHQK3+RaBLfp7VLPWn1Dd0q75CCJem+IIc2qUe3OW5SNvxrqaU?=
 =?us-ascii?Q?fbpKnLj5nNBEHI/z5sl5Tlf1yhvZEKmLWtu+0Hf6PaxbO430hxabl1aBcmn3?=
 =?us-ascii?Q?YJ0MqtWQal4lwXywpl+582ky6iMCGgyUfiGwDPyD98YexlbDB2lr8tYcd2t2?=
 =?us-ascii?Q?5GyME1jSA/YaGIwAt9uCeZLof/nl0KWu51LP4VmUT0OOwidk9ee56T4/vD+R?=
 =?us-ascii?Q?sJxJQEhHe1INAW8FpITYzrrXhE1XifNDcx86JEzE6mT7TTTo146lAre8voZt?=
 =?us-ascii?Q?4ShFIxK/JUaB4YvxzL9+nyA/uB6GDcm+LRj9Hp21q/usLIaxIsLmYXZIZaqj?=
 =?us-ascii?Q?ZtkGnWY9wPRNzSzIpLMAVmlHjx1c1R1RW0pIjy5J5SPyHb2gBtcnNgBfQcI1?=
 =?us-ascii?Q?iYYdbe3gNnefSPo7CbfoMEWqt5PkWiPlPuC1mMaZoN6CHTLY2qmmBMf2sjzt?=
 =?us-ascii?Q?kgD85nsOVglsj8FTxtlLhDz/84O6EGi2WOnwPu8QIFDhlbRzWQLWt03hVHpa?=
 =?us-ascii?Q?xATkVIQW0urtEOwZl4ajkoDXQkOWQTl0y0xv2CiIyf2D84bz1Mf12Sx0RuOO?=
 =?us-ascii?Q?PRK7vElzd3rKpeW1jflBX1CL5hOP9Ae3BUQIVrlNaOJr6vx8dJYB5uKcKzgX?=
 =?us-ascii?Q?Mlox1aeMfdVg1semSt9u1Uhb6cR75yY11D5cXhH+81sSBUkKCVmSWVm9yqKb?=
 =?us-ascii?Q?n34PB+TVH79jDbNJ6y0KufKnmGjA2iXS0S0k83v+oWCFyCACKE6PhSnn45q1?=
 =?us-ascii?Q?Rw4otpkZ7+FJjay+zfvJEdL/VnBD2j2k9br0wrlNQHz2eAIjB2JoepQooqp/?=
 =?us-ascii?Q?dMSzzNKJYcJbpKj2sn2L2OXPHseoEFGA6fSEs7pyv4kkh7V/QcrAgRzD1FUH?=
 =?us-ascii?Q?RoJYf3BSeZqZe+HhQTnTsTw1bpd1LTVa/qMXvJaD6nSdiYcPjBcpBIrDsQMG?=
 =?us-ascii?Q?e2CftDiNKP/y0eKOzGmGBjjS7152k8DH/rcg0oU/cioz99S/Zts2a/4Jo2fg?=
 =?us-ascii?Q?7fAXP8SyEeM8lL8ubqAo6dCO/rNc/7ZUsyAQPcG0wq1d4jBnFaZ5+CSOYEHZ?=
 =?us-ascii?Q?Rj/AB5JzRUl8GvgRPJO2PjwFnlzWroSf7STPAXobDTk3LEVbpHjTDlhpD958?=
 =?us-ascii?Q?l+7y07fDcUd7mBcyg/zWHKpJnyPCXGtQ+TDtcvN4FyZU/VXE5un2IajzZV1I?=
 =?us-ascii?Q?Aie1kJSX7Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: oxbTGAh4SgboLmp+ngoYXeQ7qETwg3ADBveE+pWXB5556/gBLtqSMHXOo3OqgqzXv1406iU9yQwtUMoubHtP8Nd/e+pmWZvpx7EGLK5+hhgXolruqnG9kIfJ361+W0WemfsDwhUJxmVwSdlmtGt0acXqvXuUKNLxWU55eLKD2UxD695rqh2vrisghFfoojFnWRbEjZd/4awunY1KS6tzUCgjFtyje0DIqWtIm5RJMiBk5cLufsiUB2e9du6irYYBDGTGpjF9md1rRBsptbRw9j6MHzQA/fiDfQkKa/6LYJBPetJJ38mqdN80+Nf+mw1ZjfVDarNlezZm8bwerqVl6w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 56033756-40c0-411b-5c5e-08dee8faa70b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:40:37.8952 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gMAWPI7f+pytnZ0Rqer395Ui0iFUsBpR7c124Rp2BDpiCXGBVE2w8BUcXel4ecang8mlKW7NJXenRgRIWxcldg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7258
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

On Thu, Jul 23, 2026 at 10:49:02AM -0700, Stanislav Kinsburskii wrote:
> drm_gpusvm_check_pages() asks HMM to report the current CPU page-table
> state without faulting missing entries by leaving default_flags set to
> zero. The HMM PFN array is still caller-owned input/output state, and the
> framework may preserve input bits while filling entries. It is not safe for
> the caller to hand HMM an uninitialized array and then treat entries
> without HMM_PFN_VALID as an authoritative unpopulated result.
> 
> Use kvcalloc() for the temporary PFN array so entries that are not reported
> as valid start from the documented zero state. This prevents random stack
> or heap contents from being interpreted as HMM PFN flags or PFN values
> during the scan.
> 
> Fixes: f1d08a586482 ("drm/gpusvm: Introduce a function to scan the current migration state")
> Cc: stable@vger.kernel.org
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> ---
>  drivers/gpu/drm/drm_gpusvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index b946f920b7a0..52573626387c 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
> @@ -708,7 +708,7 @@ static bool drm_gpusvm_check_pages(struct drm_gpusvm *gpusvm,
>  
>  	mmap_assert_locked(gpusvm->mm);
>  
> -	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
> +	pfns = kvcalloc(npages, sizeof(*pfns), GFP_KERNEL);
>  	if (!pfns)
>  		return false;
>  
> 
> ---
> base-commit: baa47c6547b94a164b70924e53d2bcf16f483e6c
> change-id: 20260723-drm-gpusvm-fixes-d97ddda62219
> 
> Best regards,
> -- 
> Stanislav Kinsburskii <skinsburskii@gmail.com>
> 
