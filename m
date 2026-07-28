Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE28CC53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 19:25:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45AF310E5DC;
	Tue, 28 Jul 2026 19:25:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="h9YOXQod";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39C7D10E5D7;
 Tue, 28 Jul 2026 19:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785266713; x=1816802713;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=sHg7Uj9jyKhC3bUWuAcJWFSRW8DFBVo4BM40sEKo/do=;
 b=h9YOXQodmvLHtEhk6XNPI/alUIKx9fNzNXMfW9iwmPG7Y9ZlpIOzszvH
 ar2VjBnv/eXbHXdYaIgQNsSo3/GKwqLF1d/AO0wb2R03ysmex7QMUV+Lb
 N8qgmj0vWcaqfCpve/LQ0HZcCk6La5NkCKu8soPF/f9vA2r6oinFNN06r
 G/gy6flBlGjNO+3HR3R6PGJZQS9+kcTuGn3gi7Dxfof7iju3Pf1Sn9ZOs
 D1Rzyshh82VDsvtzIcJ77v+6zg0eNs/seXFmx4AzyJ8b5d8eDbo7zZdAV
 MYY059rg05/s9N+0MHxjMEVwGe3pPX1/EegRpB0LT76hZB5X8qixFQVKR w==;
X-CSE-ConnectionGUID: Gdn9mVWUTYeHI5jR+0SU4g==
X-CSE-MsgGUID: +OvmKkC+TsKHW/zU2D9zIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="86055772"
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; d="scan'208";a="86055772"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 12:25:12 -0700
X-CSE-ConnectionGUID: +g8Rj/gfRE+5/SSQlS01Cw==
X-CSE-MsgGUID: mjee+6v0TSmvecktjHY5vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; d="scan'208";a="264809348"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 12:25:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 12:25:10 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 28 Jul 2026 12:25:10 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.61) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 12:25:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3RGJlB6Ghx9GJMrcmrqqRja5gbYluDWmk3WOt5Jwgc14iChOV/hhDYmtXT6XsZhe/iPtGVdPAPtPz0HS/TviQFEsoZHOLs2L/w8pvj+f0IQBpTYvCjvRulfk1G61Kq5+tc8qdb5aX0dXD+qIXvciMh+5LjXIVbNm5Ba6zjL/mVCwIbDIv1k0CNSs2k/XRJsiWG3yl6xLdU0LzjBV5t4mSlltnx81SJ7wtG/5m9oJrZ/pFwHN9/2jp5/lRJ+829IL36isSNEAxa4j/BcfyUxUcNYEIZrodQwm22cLMz8fGIsdGxOe5/BsxIMDAQW4kTupBt+0DGHxZ0+nokijEB7sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZPDVV/VaJyRNddM2mxdGRgHh6zJ2knZzKxSsZsyJD4=;
 b=V9dT86uvQBpwvbzpSGZj4uPx7QqtHJXEwS6AQ1Hc6MUoUQn+aQo2NA6ozf10fOO0u6c1Xb+tYfNCU6lmEuaceif0rpqjj6zANx4O4JnTnaqBqWDv1OC6XrNt5TkIdWsMETtclNRlYP+odzmJy59yijgLy/sZ9EQ2FxD43eAYKz1fdhVf4DzK8yKMZeAeLAu04NcPHvPICQ8WSjxhsHHzKVsZ+zZT0JQFABjFaDw1r2usi3DLcEv8YFVV42xoKa1kNQwyt42qByLFwqdPEexkrta249jRLCxZJr6ZIvIhw7x1PyL6kHM6Bi0C+JnQgK9gWe/vwbdfGrCCT/vepBjQ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23)
 by DS3PR11MB9623.namprd11.prod.outlook.com (2603:10b6:8:38e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 19:25:09 +0000
Received: from CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe]) by CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe%4]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 19:25:08 +0000
Date: Tue, 28 Jul 2026 15:25:03 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <andrealmeid@igalia.com>, <christian.koenig@amd.com>, <airlied@gmail.com>,
 <simona.vetter@ffwll.ch>, <mripard@kernel.org>,
 <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
 <anshuman.gupta@intel.com>, <badal.nilawar@intel.com>,
 <riana.tauro@intel.com>, <karthik.poosa@intel.com>, <sk.anirban@intel.com>,
 <raag.jadav@intel.com>
Subject: Re: [PATCH v12 4/4] drm/xe/ras: Use fault-inject to trigger punit
 error handler
Message-ID: <amkCDzvNVZOXNz9N@intel.com>
References: <20260724100302.706685-6-mallesh.koujalagi@intel.com>
 <20260724100302.706685-10-mallesh.koujalagi@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260724100302.706685-10-mallesh.koujalagi@intel.com>
X-ClientProxiedBy: SJ0PR03CA0243.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::8) To CO1PR11MB5073.namprd11.prod.outlook.com
 (2603:10b6:303:92::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5073:EE_|DS3PR11MB9623:EE_
X-MS-Office365-Filtering-Correlation-Id: b794fce7-c19c-4fbb-652d-08deecddef68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|4143699003|11063799006|56012099006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: R9wc4tbnNEea0vqz4bXbbFGsy+VFpsob4a/4Mmd5ZzI0G23gkqoumv9JXdS2qKxlIyqQosI9pJGvi9v7m3vtfeAgd113wDDZrkDLq9cuytpy/C47MmZqU18zTvX+5TLOSLjyJxANn84nvTX2SeO+H4zsBzinz/U97cYvCjWMSUFo2FYVJ1D7UfYE/aFji7svUpREg74/UMIezn/+grI8xzMpuscmairbauavBr9kgyv3EHznX9eKpdyZx2R3i0t2KV1uCGW3UpwhEjJ4NlP54YcGBgyKDB0+UN4/ro2vURhdGV0DU6axeGwU4maHlgE4IbvnE6CuZqQypUBleKz+9cj/ZLpJuK/SVld7FH3LdRqtilcP2wlF8xfbTDbCJt+tUcvG2LmsxsRf5DfKWnoImFKdQ5plbuoY4YQ8us2qWO05nseavE24KXooMMNRZ2bG679nVQMNlZj0Am80bOtfXX4qUToHK1Mf5NodGVWOuKoAo50q+jYep9bCe8wgLysr6cFT2pRVbwvnRLENRbq+FYuoUWagDAiv/H+RcKojagtUhewKIRpx5zenOlpSGVEP+cO2SdfFza2fhsd6Pfz+m0/ItEi7eQZDkPQ8OgDJvh2XqAJGHNmasY8dvHjo2GtTeBXvonQ3AamGWJqUExFBHTIWsosX7SOrdO1Z3kGKXE0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB5073.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(4143699003)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?rSu4XYQ9X0+9+wVIFYc2GsEa/AjHICUk7iAIoLRWOj7t3GGPQ2TohcSSon?=
 =?iso-8859-1?Q?fShnDkDDuQDbEwqGTY5JyFsOO5kceeGDHnrX8ZqCl/fXJl81fkYLNOCdIM?=
 =?iso-8859-1?Q?Pzq3aVQtVvfOV+bB41FZFCTu3qZwbhBPr8a4+sZbX4KR4BLRFm7SdvViMn?=
 =?iso-8859-1?Q?njoAYlHx1Kbk76yyOlcmSKS5OOFvIemqLBdoJHvvIIqJJjttt9Q4IVNvMv?=
 =?iso-8859-1?Q?t9Hg4wQmI7NnNvcYyDGOnUQWyOZFiMvmqi7A3zhgUh7F0uNPztkwQhGL0V?=
 =?iso-8859-1?Q?2eI90mbVkK+bkW/9dxADVz21bL43EW7kWE10tGP0Hi3yE744H61IrGI5Nc?=
 =?iso-8859-1?Q?u835ZSBYez8l5H/3UQkhiK+DUKrr8oa+EaXfTbFq62NOBMRHulpUALALTk?=
 =?iso-8859-1?Q?l4C07Rjd63x0jLA21le9ecHLtRL1hPu3SZSUa3KlKq/NgznSHRpEnOJJOo?=
 =?iso-8859-1?Q?EcscJnhJWeE1i55SDgVhPhA8oLXKW4cLvP6wTCu4MDnDcyabKZJLklXfy0?=
 =?iso-8859-1?Q?morc37V4CdQe/codHPTUDBQv1FujEYvV8zDurtVnuzTnNrt+pAf4N+Cttx?=
 =?iso-8859-1?Q?7R+zDbRTOSeJnnvXr5WjrfLiAn/kPCxoPdN8UUQupt45/xEz13GiYUubP6?=
 =?iso-8859-1?Q?kgT72PZvOiQjrlS28capJEq8k88hY9gp/OUmhRB8jLeJR74n4tZ//AzyrP?=
 =?iso-8859-1?Q?i56wbQw8fjHMkmJ+F1dOlozBjNGR/Z4DoWsMktJ2OitobMiIGHTtNTXOpN?=
 =?iso-8859-1?Q?DjEux3qkFkymKiwooKa8qzxdLNXd8+NEkf2Lj4ejCT509XAZL4MqityhTY?=
 =?iso-8859-1?Q?VOyS594aAYK3VIIUYo9UqSf/k22f4W7qnmIjhQIXdGTJMNnL5Q1+kHizWX?=
 =?iso-8859-1?Q?aqp4CaF6Gi4+QZdXrcS2FMx6gclLGNhcPafVJCRmsS5YaS3ytSYJz3C9lK?=
 =?iso-8859-1?Q?WInu/YnUjyB7kjAKmQPZKBywj0bbhGdY7KxUF4lyDZEp8f13AaaLxlAK5f?=
 =?iso-8859-1?Q?8AOHpxC3YqjhqALA9a0JbBLmqhTff1azwLqyWsuCQFmXtQ+8A8v6neZFCl?=
 =?iso-8859-1?Q?zWv079vxSr2/ZJXybYcuIJBpBp32d+H/+DAFLsBSiKJOGyKdGyrnUAvIoI?=
 =?iso-8859-1?Q?8dHRCo6BjNwpfOccApXerPciZ+w1S+5pDU0ss4q3rqfMREryl1PGKtCaSN?=
 =?iso-8859-1?Q?k/+wYONgrrOJ1fTL4TJpyZYq4JGt1V2BC1+w5wBOIBdYhYo6JIqUgpskct?=
 =?iso-8859-1?Q?tL/KRSqp0ot6M4C3HW7h+6K40XXReCCivqJwHQU/Wh/mxNzYkRT9QjGp6f?=
 =?iso-8859-1?Q?2Ki/FryZgrG+zhFEna7OQlODdwLnYsGQiqfG0deJnlmWulM0w5/Upwz+Q+?=
 =?iso-8859-1?Q?EDLA5IZcFKlqjQ05uNaLwp02GU+9VxMj9HlsI2/KW5EH0enSN8tF2V5AJ6?=
 =?iso-8859-1?Q?VWkegoyqY+bRn+ewhq4sexdOQJqRYfm2HQViSgccNB0HCSIKj0Au0VQjR1?=
 =?iso-8859-1?Q?gckgR2mcQP9O7ZOnSi+TEq/Ag5OcSNsUTh6TdQV6pHGmpjTht62iLeQGQq?=
 =?iso-8859-1?Q?z3wvWFkCg/w1hgSTNOZdeK/q6eSXXbTZ+8xY0NHWiqn/7DK29RASGqN/fr?=
 =?iso-8859-1?Q?2hP06ezOGklbuCat2ms0hRUfkMwEW9uBGk4YBUmlfPXd73NPaoEeT9dtvd?=
 =?iso-8859-1?Q?mA/+J6zk2alc16QLBg0BDgGLxsvttVoAksHme652sKJM8pLuiIbQqhcz2T?=
 =?iso-8859-1?Q?8yQ/hLcRmZthNxXUDLqHvUlH0JSmF+TMyuhfBJSHr1mHjlAofDf1doQnUQ?=
 =?iso-8859-1?Q?JKG99iMwNg=3D=3D?=
X-Exchange-RoutingPolicyChecked: hQbdwLNvsecYrnJOz4gxRWAJjaOnapA5dfcJZGFGYWc/4rPQG90o9DVQs8W/f69OZF2SDcglXZM3mLem1Lt6uN716x0LS4FzuxHl6qN5yIRxBxD5oQva8FoHIIn92+6qBdThE/Fk7JXIVrXqa90qvk79fsDZYUsywcMrDMvS+ffWQ61estDs+GyvxQWm7f1m1MW+GRHQ9kzRfqR3xYA6bmIt3oUsAInx4lxM9QWWH+gRNUJCw4pZziGpdObThexX4eORIMBZgPthaOClyyim0gagMXsi3LXoixyi2nXeh/7aU1dxlhzxt2GEAphzdJHgYeV3d0pGB91rmEer0FCIgA==
X-MS-Exchange-CrossTenant-Network-Message-Id: b794fce7-c19c-4fbb-652d-08deecddef68
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5073.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 19:25:08.4572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k7mPSO2V2BYMFEyTTdt2a9+XOoxiCUjol9c1aiJpN26uHY8+A+pd/SSYVYjQXlRx07VyCmMQgYoeBzxj8gF1cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR11MB9623
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

On Fri, Jul 24, 2026 at 03:33:07PM +0530, Mallesh Koujalagi wrote:
> Use fault-inject framework to trigger punit_error_handler()
> for testing.
> 
> Usage:
>   echo 100 > .../inject_punit_error/probability
>   echo 1   > .../inject_punit_error/times
> 
> Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_debugfs.c |  4 ++++
>  drivers/gpu/drm/xe/xe_debugfs.h |  2 ++
>  drivers/gpu/drm/xe/xe_ras.c     | 17 +++++++++++++++++
>  3 files changed, 23 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_debugfs.c b/drivers/gpu/drm/xe/xe_debugfs.c
> index 5a3877fcb0f0..5599d493feca 100644
> --- a/drivers/gpu/drm/xe/xe_debugfs.c
> +++ b/drivers/gpu/drm/xe/xe_debugfs.c
> @@ -42,6 +42,7 @@
>  
>  DECLARE_FAULT_ATTR(gt_reset_failure);
>  DECLARE_FAULT_ATTR(inject_csc_hw_error);
> +DECLARE_FAULT_ATTR(inject_punit_error);
>  
>  static bool csc_hw_error_available(struct xe_device *xe)
>  {
> @@ -62,6 +63,8 @@ static struct {
>  	{ .name = "inject_csc_hw_error",
>  	  .attr = &inject_csc_hw_error,
>  	  .is_visible = csc_hw_error_available },
> +	{ .name = "inject_punit_error",
> +	  .attr = &inject_punit_error },
>  };
>  
>  /*
> @@ -76,6 +79,7 @@ bool xe_fault_##name(void)				\
>  
>  FAULT_ACTION(gt_reset, gt_reset_failure)
>  FAULT_ACTION(csc_hw_error, inject_csc_hw_error)
> +FAULT_ACTION(punit_error, inject_punit_error)
>  
>  static void xe_fault_inject_debugfs_register(struct xe_device *xe,
>  					     struct dentry *root)
> diff --git a/drivers/gpu/drm/xe/xe_debugfs.h b/drivers/gpu/drm/xe/xe_debugfs.h
> index cd56f7442b99..dd57914dd4f2 100644
> --- a/drivers/gpu/drm/xe/xe_debugfs.h
> +++ b/drivers/gpu/drm/xe/xe_debugfs.h
> @@ -13,10 +13,12 @@ struct xe_device;
>  #ifdef CONFIG_DEBUG_FS
>  bool xe_fault_gt_reset(void);
>  bool xe_fault_csc_hw_error(void);
> +bool xe_fault_punit_error(void);
>  void xe_debugfs_register(struct xe_device *xe);
>  #else
>  static inline bool xe_fault_gt_reset(void) { return false; }
>  static inline bool xe_fault_csc_hw_error(void) { return false; }
> +static inline bool xe_fault_punit_error(void) { return false; }
>  static inline void xe_debugfs_register(struct xe_device *xe) { }
>  #endif
>  
> diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
> index 92b4181026cb..da06c16cf7ed 100644
> --- a/drivers/gpu/drm/xe/xe_ras.c
> +++ b/drivers/gpu/drm/xe/xe_ras.c
> @@ -3,6 +3,7 @@
>   * Copyright © 2026 Intel Corporation
>   */
>  
> +#include "xe_debugfs.h"
>  #include "xe_device.h"
>  #include "xe_drm_ras.h"
>  #include "xe_pm.h"
> @@ -391,6 +392,22 @@ enum xe_ras_recovery_action xe_ras_process_errors(struct xe_device *xe)
>  	size_t rlen;
>  	int ret;
>  
> +	/*
> +	 * Only allow the injected PUNIT error once the DRM device is registered.

That entirely defeats the purpose! :)

Sashiko identified this corner case so I asked you to ensure that this is covered
and to prove that you should provide a fault-inject with test case.

But then you are skipping exactly the corner case. That makes absolutely no sense.

> +	 * xe_ras_process_errors() also runs during probe (via xe_ras_init()), before
> +	 * drm_dev_register() calls device_add() on the DRM minor's kdev. At that
> +	 * point kdev->kobj.parent is not yet linked into the sysfs hierarchy, so
> +	 * kobject_get_path() returns "/card0" instead of the real sysfs path.
> +	 * drm_dev_wedged_event() would then emit a KOBJ_CHANGE uevent with a wrong
> +	 * DEVPATH that udev cannot resolve, silently dropping the event and leaving
> +	 * the cold-reset recovery broken.
> +	 */
> +	if (xe->drm.registered && xe_fault_punit_error()) {
> +		xe_err(xe, "[RAS]: PUNIT error injected\n");
> +		punit_error_handler(xe);
> +		return XE_RAS_RECOVERY_ACTION_DISCONNECT;
> +	}
> +
>  	if (!xe->info.has_sysctrl)
>  		return XE_RAS_RECOVERY_ACTION_RESET;
>  
> -- 
> 2.48.1
> 
