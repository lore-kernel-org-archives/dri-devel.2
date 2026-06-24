Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C65ECDB47C
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 02:56:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C48BA10E004;
	Wed, 24 Jun 2026 02:56:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ji/rt5Kv";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBE5110E002;
 Wed, 24 Jun 2026 02:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782269760; x=1813805760;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=l0ahyTxL28jUJycwCwYnm8hxhRc5Iev9UsIFnSw4/SM=;
 b=ji/rt5Kv0OM0JXG4YYQongva4wAoURW+y+m+Ep6rsbjuyigZOLadIDFp
 0DIjrSnXiMA5UOlbNJ5iIq8b6+7LW5I117aMZ1bceN3FMkqhU6K8ebbWT
 wwJonOaNy0qhvicCcl8VOvwDKHmEcbRP82tUozZywguEMgprsWGLdBKAN
 9UZCiFvDaEJVxwJfzWzlcW5HaKo3B5Ftw3c+gVditMrJ/P7qH+pOtLKzJ
 rfV4SuJaSJX9hKAU8nY/841Z5vDJoH7Y/t2UnE0V3xEpb/g8bzm+tam0o
 QwheSsK6JXHRaq1CPS2s8B2mKksp3cHjOKLN6r2mDOhPsOhBcyLR3jg8h A==;
X-CSE-ConnectionGUID: WLpHx3HgTOisDovBAF2w9Q==
X-CSE-MsgGUID: v0CmnbQjRc6P8WrrgxVfWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="83061721"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="83061721"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 19:55:59 -0700
X-CSE-ConnectionGUID: ef2qOHaKTIuPOSQ5HuA8DA==
X-CSE-MsgGUID: 3htY1PMIT8+Gx3GMKKYO6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="247342227"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 19:55:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 19:55:57 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 23 Jun 2026 19:55:57 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.35) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 19:55:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+G5aCeWaEay7yHxXG5CD5vnQcCTkagXPWwFnvR2AMDYdO15wCY4cZWZAIRqI+2Dzdxw2vyjtRoNAe/uIs/Je4xbO3TPz1IDzHA44DRsYfFq6dkm/9BPB367UxgLka5qTabVcGeAzOfzFbGbT+nSNYlu4yqws6Lqtgj/Y4gWUx2h+OqGe1iMXDtJQ1YSb5VFHo1aZMrZEooKUL4OtEMBuxdBtr16YtpQoT9/59TOuxEoW0E8xAajAIP0zKbD9+sMnnEDHRJlHpPBAyEOOeD4yAErp5/jOOqa2xZXjR8v98kkYxeywcjC3lMXunMQ5RcLFn40z5VbiUpgaPpFrPLOFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tizw3YEiPo8A5FOS/43+oCPP9WQ0Aiazsv+1k060XhQ=;
 b=sAal6x2MACLobWpm6xbIvKuIS1uZ23LyQNtWHcdwdz5A3vrlME/eqMxN4KQU/LosqNNWNeDH6e+TKmOC3yTqHuJot7l4xUQj6ipbwfsh0ZV2sRtNMOLJGlwvLaV2LoVt3Y+/IsTm9DvxiHQfbI9udsnatBo+dMnn5hjXesQubnnFh6T1dZpY6HKuJDtvl0tFV1zLUM7kzfcoixQKgS+P6oyfUDN9LxW1E3Nz1BDHHIlGBx3qO7bVzZFD04NA03dSoyNW7DwVWszCCOYceorI2Q1Osih1kZcSMb0fH/4+/K2vfeDfC/Tv/FTrqSpUPLZN+qO2oYQUUr1FZWhRf1PLpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by MW4PR11MB7007.namprd11.prod.outlook.com (2603:10b6:303:22c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Wed, 24 Jun
 2026 02:55:53 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.21.0159.007; Wed, 24 Jun 2026
 02:55:48 +0000
Date: Tue, 23 Jun 2026 19:55:44 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Jonathan Cavitt <jonathan.cavitt@intel.com>
CC: <dri-devel@lists.freedesktop.org>, <saurabhg.gupta@intel.com>,
 <alex.zuo@intel.com>, <mripard@kernel.org>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>,
 <intel-xe@lists.freedesktop.org>, <Rodrigo.vivi@intel.com>,
 <maarten.lankhorst@linux.intel.com>, <thomas.hellstrom@linux.intel.com>,
 <tzimmermann@suse.de>
Subject: Re: [PATCH v5 1/2] drm/xe/pagefault: Add SRCID to pagefault struct
Message-ID: <ajtHMFu2O3A02r21@gsse-cloud1.jf.intel.com>
References: <20260623164610.1019512-1-jonathan.cavitt@intel.com>
 <20260623164610.1019512-2-jonathan.cavitt@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260623164610.1019512-2-jonathan.cavitt@intel.com>
X-ClientProxiedBy: SJ0PR13CA0240.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::35) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|MW4PR11MB7007:EE_
X-MS-Office365-Filtering-Correlation-Id: 126e0c93-2567-482e-aad3-08ded19c1822
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: cTe4WxM+8xUMAJm+GAQhWjRuWYwOIhZRbvx5aT2UBsuHdU9+0URNkO1RH7eJ8YlIouRYpxPBFHcOo3a4Ji1zC3dpRFccavyxuaX8pu+XnziGcNj9C8p1mNBDidl1QBZJH7C8tsOKREvZKRe6po+VrUpM9XmLIargVtcyGVjb3HVrBdBuk+mUmO4Ev6oM5lKcUilUGm12ss+ssXdUPqU+bVd+u6OPJAzEojLWEp4BfsVC+OV2M3q4EZyqcixvtgXpRDEfOf4UW8qu6sJ4bzYsXukAn1mB7VBY+x4qGvi87ZBK/KtHNRvkiPFEI1ApmTejUaleYnWPte9BmIcOeF8lu9/MXrr1TmcgU66R2mKVH6/8tyo+tkzR8OJzOaE3B5rolKzir25PoH9BT8dEvp5SOKbbKJTjER2Cov3HHnf4BPNbbznrzOrLjnAMfOEAZ2bhw0ta4R+dV5BwMETl7uuEyHAV+SCJ59zL73zRcEi9+wxajVwwJAwsC2E6h7w/Oa8HTcWAyBKKMhCt8bd5wKxnUgBuTqOmfMUX8RjzUweyxpI9rkSnnWfDV2z0FKoCru/UJhTxedxuSxKVBQ6iV4NKF9LkcCmdBWl6FZ/dVmFsL04rbp5jrrOJPijJ+WrCm78YoGmuunT13qliReX86cTU4oLqpDDCcGb70u7aXWr5E5g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR11MB6508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ndzIk/91uTLOXLG6GwdLaxSIBUOHD0OdXcD8SM0qs79AkQmt9AxTzK1l4V?=
 =?iso-8859-1?Q?m0AGliccSy5KMJ4ofvfaIMqO2TRLOEohtppjKnWRDD+8S+YyqzbZyEFq80?=
 =?iso-8859-1?Q?eXo9qkTLUnLYk5POGkrL9CoM2Qt2SsDFofYVUw8Y0Ebjmz5YOhNMWn8NUF?=
 =?iso-8859-1?Q?Z7ZjYoV5fUQgt4TfkNAP8Z7lp8hGIok7nQ4NYvE/5psWAzkDj5QcI1TC0T?=
 =?iso-8859-1?Q?QdhCu4CnO7jgIjqXDQdMDr8ZS3zhWcqH/d/TSoYQiMb95ScH6f95wE6aSh?=
 =?iso-8859-1?Q?AILtYnWc6IVeWAYKT9BriIukfEbNRveY1r5IsbOPdcgndewPFlDmvn4HyV?=
 =?iso-8859-1?Q?ypsvq+ZHH71BwEDjrBWLTfgXJR229gUOuRNr5nxOEFjFsurVR2Glc2BvP/?=
 =?iso-8859-1?Q?MHucISWx/s86PyNeZzGvMXQpRLXqro4p5Yoqnsjc/hxbRd3bfXHw1Flupv?=
 =?iso-8859-1?Q?ijp4R3Bor/HDuTV2i16lcHLgOHhbw0YVyb69kqJZff6dvgkcCScUjNcYYW?=
 =?iso-8859-1?Q?cCUJLvaJNzd+hZvMDnxjI7Iws6/PAK+VXGrBEPhDPbK0X1E9YzLDL12w9l?=
 =?iso-8859-1?Q?+2/64CumscNskibeqMZr4xbD/aox5wp97acvrA5VckUP7ZL2eg2WezCoBC?=
 =?iso-8859-1?Q?wcp+nI6IBfq4KnKdJsTyoCt2QCcscZztmlUxX4kuAHmRzRxLcz3rHgwB3G?=
 =?iso-8859-1?Q?ypKvM0RLzCeM6yMKqkjcfljcv0JgRU6awfwwqdyiu2eIw08sm0i3wStG17?=
 =?iso-8859-1?Q?QHN+tOWLxmxorJMZ3ycJDsTQVlqxA8Jx0uc9SArZ6MCp7wLpJSLq3dUY+u?=
 =?iso-8859-1?Q?u2r25uJ0M+gsLoQ17gO5OdtpW8sh8KKZE4mCkuWoJaOb5jA1AcrEV3P8xm?=
 =?iso-8859-1?Q?miRfTG3r9paZ5KwJooK7Qtv0T2mDfS2/pR6vdZvkmolqBVKADJxuhAZFXZ?=
 =?iso-8859-1?Q?5bxoMxK9iHvI1xRVOCU5VFmLTrMyZJzXP3a3rcBzmf1BufUWcijIgGTftC?=
 =?iso-8859-1?Q?oefjgUSRL27uY3xS10ycgulh+RiOT4R92LvEzLYEDRDCB62fqRGMmxk0fo?=
 =?iso-8859-1?Q?PZPxSRrUZQJajETqfYSRXS0ZndGKPWe6NeVuFZXITJk0fPHF98QkvCvcMW?=
 =?iso-8859-1?Q?sdpW3Yd1cpFgB6+PKZY3XSGTIfSkf5oj7ISmKxZu/JErICrk5MwgV5O+p0?=
 =?iso-8859-1?Q?XkmWRjt5Hl24ENmjD4W8PG47x0TIrkTGjRtu9XzphV8Qslb0eUctx0L+Cl?=
 =?iso-8859-1?Q?0IO3G2RqcfWc7Axr5BfmS5Z6NQb32g+GPT/rrYGQNDFGecEoxKaWWwpfNt?=
 =?iso-8859-1?Q?AKLDdsslCmLdbXgajoPTLXCAE+ecxLXcLX/KDIK0wbCPsUd4qzTKTc6MfC?=
 =?iso-8859-1?Q?FFo11mDyXYUCZmr6uYPIoo8sjFjVr3zY30EIaMnyErYYIa5edlH6lj6a3C?=
 =?iso-8859-1?Q?CRODictNx6HPFrdLFcf3N/C3P6x+aBlHipZDOuPOVw1DO7eDXBhKU8EAJZ?=
 =?iso-8859-1?Q?JndGdzIlgEd/W+lEeHDe4zRIPgLLYvcVq3TOxE4mQkBuBLlk8kayyOmIM8?=
 =?iso-8859-1?Q?CMH3vwT4vFaV0Bb677dMh4LvYyrYJstQ0OpWQ5WvDNmPeOBZmPhWSMSGQX?=
 =?iso-8859-1?Q?yvkOmCqoMXQqn/pSh0gR3xU9g1W3Pj/qvtuSBlAQ5V41B0NMBId/a/6h3+?=
 =?iso-8859-1?Q?BUxvMhW9aTxUTXaodGU8709hKgcy0UxGkOZNxR1wVV3mv73wUOf68KbBvP?=
 =?iso-8859-1?Q?lFMPqMfmX9DCDhkSqON9xGIAk1Wo5Cz4WPy175NNaayZbVyLNEqIcbUxwq?=
 =?iso-8859-1?Q?onuoPRukdA=3D=3D?=
X-Exchange-RoutingPolicyChecked: HxgBgsUq3r5Ao0IWNHPtrccUHktGMUY2taLNMcaMdxyrQMbH9HZ9M/f6t2MQMFK7fBUKjzphLNZYS1g9PmX/B4KMlWAku2fO4H4wgvyf3sIVQVo8zN1IUAecIf0KgYE7YOalJYaSo/00CB8SnyJTtFXWEunviQwckEZfMBWik8LedeFvz9GCCUeruvOfV/Bks/lxNJBzl326Nce0cAkLIEE/ERYFbS/uhTj0LbgP7DCBu6N0GcE0ihBDCiHb0EBro5SWNhofFQqOEtWVQncc0F41bajLO76+IFCOqgwiqU/Olgpked1Vtbd+UyIX2sj2hM6Axnk32cpLqc58ArrDlg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 126e0c93-2567-482e-aad3-08ded19c1822
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 02:55:48.5978 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pHly/pSyscKVgsBiSG7D9vK342xhdpmFqZMSS/XoV0PNaoa+qSSpjU8dRgFt5UUXOe1Dc31UgWisNVxvV6crTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7007
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

On Wed, Jun 24, 2026 at 12:46:09AM +0800, Jonathan Cavitt wrote:
> Add SRCID information to pagefault struct for the purpose of reporting
> the hardware unit that resulted in the pagefault.
> 
> v2:
> - Squash SRCID with ASID to keep the struct compact (Matthew)
> 
> v3:
> - Use BUILD_BUG_ON and move ASID definition in one function (Matthew)
> 
> Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> ---
>  drivers/gpu/drm/xe/xe_guc_pagefault.c   |  8 +++++++-
>  drivers/gpu/drm/xe/xe_pagefault.c       | 23 +++++++++++++++--------
>  drivers/gpu/drm/xe/xe_pagefault_types.h |  9 +++++++--
>  3 files changed, 29 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_guc_pagefault.c b/drivers/gpu/drm/xe/xe_guc_pagefault.c
> index 607e32392f46..f36aa17b5b3e 100644
> --- a/drivers/gpu/drm/xe/xe_guc_pagefault.c
> +++ b/drivers/gpu/drm/xe/xe_guc_pagefault.c
> @@ -78,7 +78,13 @@ int xe_guc_pagefault_handler(struct xe_guc *guc, u32 *msg, u32 len)
>  				      << PFD_VIRTUAL_ADDR_HI_SHIFT) |
>  		(FIELD_GET(PFD_VIRTUAL_ADDR_LO, msg[2]) <<
>  		 PFD_VIRTUAL_ADDR_LO_SHIFT);
> -	pf.consumer.asid = FIELD_GET(PFD_ASID, msg[1]);
> +
> +	BUILD_BUG_ON(XE_MAX_ASID > XE_PAGEFAULT_ASID_MASK);
> +
> +	pf.consumer.id = FIELD_PREP(XE_PAGEFAULT_ASID_MASK,
> +				    FIELD_GET(PFD_ASID, msg[1])) |
> +			 FIELD_PREP(XE_PAGEFAULT_SRCID_MASK,
> +				    FIELD_GET(PFD_SRC_ID, msg[0]));
>  	pf.consumer.access_type = FIELD_GET(PFD_ACCESS_TYPE, msg[2]) |
>  		(FIELD_GET(PFD_PREFETCH, msg[2]) ? XE_PAGEFAULT_ACCESS_PREFETCH : 0);
>  	if (FIELD_GET(XE2_PFD_TRVA_FAULT, msg[0]))
> diff --git a/drivers/gpu/drm/xe/xe_pagefault.c b/drivers/gpu/drm/xe/xe_pagefault.c
> index dd3c068e1a39..3b0510f2a72e 100644
> --- a/drivers/gpu/drm/xe/xe_pagefault.c
> +++ b/drivers/gpu/drm/xe/xe_pagefault.c
> @@ -175,12 +175,13 @@ static int xe_pagefault_service(struct xe_pagefault *pf)
>  	struct xe_vma *vma = NULL;
>  	int err;
>  	bool atomic;
> +	u32 asid = FIELD_GET(XE_PAGEFAULT_ASID_MASK, pf->consumer.id);
>  
>  	/* Producer flagged this fault to be nacked */
>  	if (pf->consumer.fault_type_level == XE_PAGEFAULT_TYPE_LEVEL_NACK)
>  		return -EFAULT;
>  
> -	vm = xe_pagefault_asid_to_vm(xe, pf->consumer.asid);
> +	vm = xe_pagefault_asid_to_vm(xe, asid);
>  	if (IS_ERR(vm))
>  		return PTR_ERR(vm);
>  
> @@ -242,14 +243,16 @@ static bool xe_pagefault_queue_pop(struct xe_pagefault_queue *pf_queue,
>  
>  static void xe_pagefault_print(struct xe_pagefault *pf)
>  {
> -	xe_gt_info(pf->gt, "\n\tASID: %d\n"
> +	xe_gt_info(pf->gt, "\n\tASID: %ld\n"
>  		   "\tFaulted Address: 0x%08x%08x\n"
>  		   "\tFaultType: %lu\n"
>  		   "\tAccessType: %lu\n"
>  		   "\tFaultLevel: %lu\n"
>  		   "\tEngineClass: %d %s\n"
> -		   "\tEngineInstance: %d\n",
> -		   pf->consumer.asid,
> +		   "\tEngineInstance: %d\n"
> +		   "\tSRCID: 0x%02lx\n",
> +		   FIELD_GET(XE_PAGEFAULT_ASID_MASK,
> +			     pf->consumer.id),
>  		   upper_32_bits(pf->consumer.page_addr),
>  		   lower_32_bits(pf->consumer.page_addr),
>  		   FIELD_GET(XE_PAGEFAULT_TYPE_MASK,
> @@ -260,7 +263,9 @@ static void xe_pagefault_print(struct xe_pagefault *pf)
>  			     pf->consumer.fault_type_level),
>  		   pf->consumer.engine_class,
>  		   xe_hw_engine_class_to_str(pf->consumer.engine_class),
> -		   pf->consumer.engine_instance);
> +		   pf->consumer.engine_instance,
> +		   FIELD_GET(XE_PAGEFAULT_SRCID_MASK,
> +			     pf->consumer.id));
>  }
>  
>  static void xe_pagefault_save_to_vm(struct xe_device *xe, struct xe_pagefault *pf)
> @@ -273,7 +278,8 @@ static void xe_pagefault_save_to_vm(struct xe_device *xe, struct xe_pagefault *p
>  	 * mode, return VM anyways.
>  	 */
>  	down_read(&xe->usm.lock);
> -	vm = xa_load(&xe->usm.asid_to_vm, pf->consumer.asid);
> +	vm = xa_load(&xe->usm.asid_to_vm,
> +		     FIELD_GET(XE_PAGEFAULT_ASID_MASK, pf->consumer.id));
>  	if (vm)
>  		xe_vm_get(vm);
>  	else
> @@ -474,8 +480,9 @@ static bool xe_pagefault_queue_full(struct xe_pagefault_queue *pf_queue)
>   */
>  int xe_pagefault_handler(struct xe_device *xe, struct xe_pagefault *pf)
>  {
> +	u32 asid = FIELD_GET(XE_PAGEFAULT_ASID_MASK, pf->consumer.id);
>  	struct xe_pagefault_queue *pf_queue = xe->usm.pf_queue +
> -		(pf->consumer.asid % XE_PAGEFAULT_QUEUE_COUNT);
> +		(asid % XE_PAGEFAULT_QUEUE_COUNT);
>  	unsigned long flags;
>  	bool full;
>  
> @@ -489,7 +496,7 @@ int xe_pagefault_handler(struct xe_device *xe, struct xe_pagefault *pf)
>  	} else {
>  		drm_warn(&xe->drm,
>  			 "PageFault Queue (%d) full, shouldn't be possible\n",
> -			 pf->consumer.asid % XE_PAGEFAULT_QUEUE_COUNT);
> +			 asid % XE_PAGEFAULT_QUEUE_COUNT);
>  	}
>  	spin_unlock_irqrestore(&pf_queue->lock, flags);
>  
> diff --git a/drivers/gpu/drm/xe/xe_pagefault_types.h b/drivers/gpu/drm/xe/xe_pagefault_types.h
> index c4ee625b93dd..2213cea886c7 100644
> --- a/drivers/gpu/drm/xe/xe_pagefault_types.h
> +++ b/drivers/gpu/drm/xe/xe_pagefault_types.h
> @@ -65,8 +65,13 @@ struct xe_pagefault {
>  	struct {
>  		/** @consumer.page_addr: address of page fault */
>  		u64 page_addr;
> -		/** @consumer.asid: address space ID */
> -		u32 asid;
> +#define XE_PAGEFAULT_ASID_MASK	GENMASK(23, 0)
> +#define XE_PAGEFAULT_SRCID_MASK	GENMASK(31, 24)
> +		/**
> +		 * @consumer.id: address space ID and SRCID, folded into one
> +		 * to keep size compact
> +		 */
> +		u32 id;
>  		/**
>  		 * @consumer.access_type: access type and prefetch flag packed
>  		 * into a u8.
> -- 
> 2.53.0
> 
