Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD80CC6B2E
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 21:12:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9283E10E45E;
	Wed, 14 Oct 2026 21:12:11 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A8C110E45E
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 21:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792012326; x=1823548326;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=0Ec4Nix9+hwGJ/8l8plOJyk+dL+qZ3MvNNEGj6VclDA=;
 b=KqoNcv2XiaiCvb2w6vSgrUjDXMXztQh4N6pt34Xux9OlUeZ5Ta2FM13T
 7130b8pkOkHEQBq7eMgwyo7dmtoaSAWvq6S2LWI1r/IZbW+Wk8q42u51C
 cdeIbMIJ3xH7Bmrk3gOMRF8LiUOTQGZMKyd7mhI6JCLjx1qHcnFYe3iyZ
 tMe7SjAmR2/PU2GIBHPUUfbveN7MARB0IIgXBpYvwmuTPEHd/8NrvS+AQ
 feQ6KZn1qwZ8HrSz9S6VZKPglz3shCQDTW6rWjc4tNJtD3+Rv3brISOWb
 7kmjiCIpYTDn8YZPOOhBmuxwh0mpbV5bnXt+f+Gri7MLAgFMpKmX41X9S w==;
X-CSE-ConnectionGUID: RKX/0JfiQrySbOgxG3pwDg==
X-CSE-MsgGUID: z9wmOkG2TnqNbyx3hemgjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="775577"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="775577"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 14:12:06 -0700
X-CSE-ConnectionGUID: JlNiCejBQPOgB4Ebk8S1Bg==
X-CSE-MsgGUID: 5LzzQEEGQl26ijRt6CI9GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1585790"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 14:12:05 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 14:12:04 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 14:12:04 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.25) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 14:12:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PYX10Yc74ZcoTz2xPaZm15cVMCT+oLR4T9JC6ALkalFLl2jlCqglIg2nw34f/oO0UPU570fGH55qCCANVj8MzWQInAo8FKQpdvwaJuozYrIg7Y/v3GCqOuIn9Rr8r0PF/+4HJav0shazmIdcfoQh1Oz5q+fbr0KQ4OTXcAgq01TkhWjkdC6WdbUaSEjYNt9NidsQ7jdY8Apjh8Vz3kZ287zW/Qjja+pWOkRQ5xvDR1kxyebUkEzQE0NOUGNbA5BP+F05YkC3MjlYfvynVp4aiD6300sP8//TIeJFELZi62X2FYn852/0nYFNNwA9vOXw/Q+91OQJ2nWGPtnD0L3YLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laauOWbRZ/EMURJQ4jUx8xIem6EfLlQ5ljQQtLUMhNY=;
 b=BHLn8BYJfhoMLzHtA4htozTXjZIc75TBcTKI1Adb5+FI2xFnvauWwYDZwDY/u3F2npeJ/xSHr23bKQIfOWwPEhXF30KngVrcKImNwPk+t300YkM8BUkmpe5/bs4HNUB1wskP/Ctuo70vfpRjE0oZAiYaKx13axlHKkHugxkDcWrvQkbH1S8KeZLKIGkSjRh3RB6qms806YeAJqYSyFO5mGFJ69DoHPwghHHNLcBaNzTSMNZC5nd4pUDFeK8Vdojf7orYEI8kZYhY9sHsoL3tIgJG8/tfrqJb1H+qEHGyFi70wZ1PcPg7o7NzV0Z5uOXlqvgj130pnjS6pGzxopE31w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB7181.namprd11.prod.outlook.com (2603:10b6:8:113::13)
 by BL3PR11MB6337.namprd11.prod.outlook.com (2603:10b6:208:3b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 21:11:59 +0000
Received: from DM4PR11MB7181.namprd11.prod.outlook.com
 ([fe80::89ec:90c8:3170:5f0a]) by DM4PR11MB7181.namprd11.prod.outlook.com
 ([fe80::89ec:90c8:3170:5f0a%4]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 21:11:58 +0000
Date: Wed, 14 Oct 2026 17:11:50 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
CC: <dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>,
 <riana.tauro@intel.com>, <aravind.iddamsetty@linux.intel.com>,
 <raag.jadav@intel.com>, <simona.vetter@ffwll.ch>, <airlied@gmail.com>,
 <kuba@kernel.org>, <ogabbay@kernel.org>, <lizhi.hou@amd.com>,
 <karol.wachowski@linux.intel.com>, <jeff.hugo@oss.qualcomm.com>,
 <carl.vanderlip@oss.qualcomm.com>, <troy.hanson@oss.qualcomm.com>,
 <youssef.abdulrahman@oss.qualcomm.com>
Subject: Re: [PATCH 1/3] drm/drm_ras: Remove admin-perm flag from list-nodes
 operation
Message-ID: <as_v_sj_D-1MyS9z@intel.com>
References: <20261009173152.2436195-1-zachary.mckevitt@oss.qualcomm.com>
 <20261009173152.2436195-2-zachary.mckevitt@oss.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261009173152.2436195-2-zachary.mckevitt@oss.qualcomm.com>
X-ClientProxiedBy: BY3PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:a03:217::7) To CH3PR11MB7180.namprd11.prod.outlook.com
 (2603:10b6:610:148::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB7181:EE_|BL3PR11MB6337:EE_
X-MS-Office365-Filtering-Correlation-Id: d6f9904b-7522-4821-a680-08df2a37c6bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|7416014|4143699003|56012099006|11063799006|261009221227099003|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: +hE94+JL92r/KUh7oqDIRdXXQ/FR6vs6Bd2UA7M/GRsQhFQGUJnrRYOqfWSioAhgF5FAYUl9YhcFtfyytgwrZaaCeVO9hXAm7UFw/w59GIzF26v7N3HpHopZvfG/RJQ1X2Amv8dsY10nt65dN2VSkfoBTksAiyTuoKTp5UZCmR088ixPLZTKFUnFA3pxyo0z0vLezRnADsXtgqG7EWLKhX+Pk77//hLyQUsaG2DJHHRHhh9HHOGOfbc+sxLQJCXv3EVu4tOc3bEv4qlf7EHU2dp3Sivrj3hTuCuU7hBW2hJA1xDKg+lradRdCRZ8LVazqYcRWQZYfTvgnfGCCMhn4yGt1Ujh/A8j7Pa3CWH3y8f7JL99yeMBJvDrgpHly5guI5G7Pi20CAkw35XxGeewBc2pyw6CY7WU8x7qqK6qpRzRyWmuA4aXh8QDoza4FzwV+ApVvt/Fx5Nnpq7IDmyS9GoIE0luh4j61I2mpZ+0loKqYG4Dn8tvzlH7SPkPF6dM0n0qOauXXPBNhcQwGfdmzMidAhQl8kLeQOOIkK6gglZzlzcZcIpnY7isemz3/eqYnCaXt35A6PH2ezcEZdU4/X89q0hTZHWt0T7jEuxGqbgRimD2jd4FiGVy5gY4w447/rrl7/T69UbmslppgP/+8OrbJJYwOPGupFKsPu339jU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB7181.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(4143699003)(56012099006)(11063799006)(261009221227099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FTzD1jRYZyWqMjKuCuFk89g9TZMTYEKTQg3qRJpwzFWvALU57HvcK3ictLS4?=
 =?us-ascii?Q?XWMFVJqNz8zEOc0VGe7uwZkLtN1DYUcHMMudwHAq38OEUS0+foKO9Y6muHpM?=
 =?us-ascii?Q?4U2YWSVVmgYeeVpJDkjlqg43oVQyqMkOoTenL7lqPLI9m1CcQw7taAOW1Jx+?=
 =?us-ascii?Q?+X1O0GRjH2V1yk3+a4JincSjP4jM88JoNR5PAgxsp0IDipArpu8aXyxj+G3C?=
 =?us-ascii?Q?B/TWBAo7/wyrQ5yOJNwkCRCR9vo7N6Zuoy4Xl3/XGoox3Zq2wgJy7Kedw3Cp?=
 =?us-ascii?Q?fQuRDl9pv6Eh0TS89LWXyy905kD9eOSLbGx4fEPM02XlBpZVjUvpxwOaygtC?=
 =?us-ascii?Q?JbhM8IyFcWB41AJVcLsnsHb92pxFDMaeUJ1LEzAL9bYq6zjzRNdkTTmXjN+E?=
 =?us-ascii?Q?mJFHWlRS3oLyCiiyWTHCrtoZg0pFE0pB5CPDKcaugkNDHqvpVuIHEM5IzQ/k?=
 =?us-ascii?Q?7fuyk/yTlSAPWCGpdMmoUfLlFQ/n5gZ0vppNO2CQDtJyfukgzhjONhLd1VqS?=
 =?us-ascii?Q?1K9ACJd0eOJcAeW/DYuwXY8GaTmbuWx3kD/Myu53i7Ra9mkaFqThXSfpQUmc?=
 =?us-ascii?Q?zmwHsQjNLS34PuzmgVs78+vFyhwGrisUQKAho7xRjGI1cyqozlheTO6aVuFz?=
 =?us-ascii?Q?nD7R8DrNiAyb9bQposo8OB7vVDWlIFxPQ6zlUZxE9Iz3LjK0msf7asarnFOi?=
 =?us-ascii?Q?Xg7tCZ8A9Mah6f8j9jHe6zcTbK+8N4+DNe9KHQIEAiIJbkFdRyFYbEQrdnRk?=
 =?us-ascii?Q?vjB6dq9ur+pYyIxeIxGxJ9x/NbyJgG7SWObavoXAhX0wEwK23lig1x4bExk0?=
 =?us-ascii?Q?MmjE4ZLLCdji8hEb1t5RSRgsWs0PdA6cHfAfAbIVwRu3dVp4wy/kHfpg0U+F?=
 =?us-ascii?Q?vtVD3oC2E1CwbNNJc1kSuwXc7eUDItIRUoqNx/cUYQ2Ir9Thin/DybEnAFuS?=
 =?us-ascii?Q?Z6yTe9iAQP68iOZvKRn9Sn5vBl6E2I6vv9yarRaHa7VummRz6ERSpPO+TyP6?=
 =?us-ascii?Q?BAdTT3DzEgGXU1UamYYFmjQTxWkVDpJ1Iww6Rg0zd4xtIi2us5u4zldMQw3j?=
 =?us-ascii?Q?MMwDwiB0i0IWitZU4ksWhoHRaySmpEx501ZxJz/lM/SBfUkWz7not4uCbeDi?=
 =?us-ascii?Q?xs//yElVP9v8kQm72ajR3LdUgoQr/vmtTrWnfSR5XuCXJwVLv2a2vdVuYVH5?=
 =?us-ascii?Q?SrbnVsyzyjY57PLxPoF476D24U6TW0EYlAF+yin81bL/3J0OJz4RM3eP7X6q?=
 =?us-ascii?Q?naQFMIaitucuC6buJgQeSCANKIaBULpoWMGyLvU5/sIdm7X24pMzQkNt+mhx?=
 =?us-ascii?Q?73zdSrc3cd+HO/ilGDVsTSbShS0Gs7MqQBcLr4P2ZDVTMMDr0D4Khr+5Mzm8?=
 =?us-ascii?Q?mecac6KspGzxcRIszcCJj9ZnKbk6vT+QecApP6cGtWau+RP2sqomJvbBfm+O?=
 =?us-ascii?Q?WPlWMqM1s3gTmpJ7P21WVPfeQGEQMXvhasM9uQCj5/33brN6O4z0djuosO23?=
 =?us-ascii?Q?QsMhnh2Hsm/eKziGYMykaETGXXA3CzipTrYrU4UxB/+l41h8Hld0d4LfI1oE?=
 =?us-ascii?Q?igEFD09xfzcoMz9u0/2DJiyaOWCtTpBYStzfHQL9pEAK//dBbsSX9c3iABNT?=
 =?us-ascii?Q?+TpyyVPXSSDHO5ilpu101Oio7axUh1LfdVtPsmIyCIpiBGnreT9RGA47fF53?=
 =?us-ascii?Q?A2dwFX+/4DP7cFCzjYRw7y6P2yiSLS3Ujkjb7+GGwgvLMbYqhd7ACcpSTOH7?=
 =?us-ascii?Q?n9+6GSWUxg=3D=3D?=
X-Exchange-RoutingPolicyChecked: lSy1fSMFogXgI8LIlistul+tWuaU9LKlHeDWnbgQtbfbIZnJVEbBLPz+UV0Kyr4sjSZNwCpePyFmFClT3bXFmryt8CcPYVg3giydO+gbO5Wv0Us/tp+C1FtUP1v+jlhKp71oT/x+ulyImUC/RKuf1I4SVGBtJDKpiN0ljIFlp69EM9VNrM68/bj/gyfJYkk11iL6Y/dCeLzZXnYMin9hdHEWv6ZihvKm1LbYPjrBReBeNSWybklhDii3sy+hrhEQQ5k1X15DckNeHTylgPuXn8lmxRnktuEOV9eRNjsJa5GUC7MUJn5g80owYWM/60OXykwzuENHEuDdP5RwYIT2YQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f9904b-7522-4821-a680-08df2a37c6bf
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7180.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 21:11:58.6554 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CULaLnFH5Ax2fsJJUGz/RENA6WLpK8hBME37mEz6tO+Odx5WvVf2K8xMXrFuGMm3AsafRujtmByGovFuLLjcyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6337
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

On Fri, Oct 09, 2026 at 10:31:50AM -0700, Zack McKevitt wrote:
> Drivers may want to avoid requiring CAP_NET_ADMIN for subsequent
> drm-ras operations. However, userspace must still be able to access
> the list of RAS nodes to determine the node IDs. So, drop the
> CAP_NET_ADMIN requirement for dumping RAS nodes so that drivers
> with different permission requirements are still able to use the
> interface.
> 
> This prepares the interface to be used for telemetry by the qaic
> driver.
> 
> Signed-off-by: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> ---
>  Documentation/netlink/specs/drm_ras.yaml | 1 -
>  drivers/gpu/drm/drm_ras_nl.c             | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
> index 4c2ac9a1ba3f..a88fdab7a1c7 100644
> --- a/Documentation/netlink/specs/drm_ras.yaml
> +++ b/Documentation/netlink/specs/drm_ras.yaml
> @@ -112,7 +112,6 @@ operations:
>             the node IDs. These IDs are required for all subsequent
>             operations on nodes, such as querying error counters.
>        attribute-set: node-attrs
> -      flags: [admin-perm]
>        dump:
>          reply:
>            attributes:
> diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
> index c9f5e0ceb3b5..ff0dc406c27c 100644
> --- a/drivers/gpu/drm/drm_ras_nl.c
> +++ b/drivers/gpu/drm/drm_ras_nl.c
> @@ -46,7 +46,7 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
>  	{
>  		.cmd	= DRM_RAS_CMD_LIST_NODES,
>  		.dumpit	= drm_ras_nl_list_nodes_dumpit,
> -		.flags	= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
> +		.flags	= GENL_CMD_CAP_DUMP,
>  	},
>  	{
>  		.cmd		= DRM_RAS_CMD_GET_ERROR_COUNTER,
> -- 
> 2.43.0
> 
