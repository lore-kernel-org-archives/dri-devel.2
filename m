Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DDE4CD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 22:30:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 860AC10F69C;
	Thu, 28 May 2026 22:30:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FonVK7hI";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6303110F69C
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 22:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780007407; x=1811543407;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=7U8ezof03aSFFELrq/uVz6b8ST+a4ErGRA4KH8wvyEc=;
 b=FonVK7hIcL/nMHQRPxE1PAmOjH2601qL+sAHd7RCS2xJBXj+H4W/ZK9f
 hda8uTR/wP1uwXLw4G1zdLkFN224Q5uBd1bId2ZLAJIVOkuZNZPAOGUkZ
 aVwcNw2rqjC1Yq1ShA6uKLbi7Dw6Pphj8wuMYNs1H9ZYrvwu7b0BO+K57
 seQPL3gFHK36toLl4lFEITyqphqopSezb0WLkv6ysEdON1Wg22MiQIIjU
 JNKS8Wb1M4ydyquzB08WhUcoRmVLdg6JDuzS9KA7DPqciC3DzRbtqEk3k
 0Zllcfi3Udfcl5d55duUwpHQEnqolgQk05qirRKLu9qbnw8d25RkJTfx8 A==;
X-CSE-ConnectionGUID: us1W0uiCQvah47S+QTZpGg==
X-CSE-MsgGUID: vGcyr5PETvGx+56Cz06uzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="81043795"
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; d="scan'208";a="81043795"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2026 15:30:07 -0700
X-CSE-ConnectionGUID: nXC7a66LRKCTo6jgl6AKxA==
X-CSE-MsgGUID: 1+1ontknTOSuzB+f5s+qOQ==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2026 15:30:07 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 15:30:05 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 28 May 2026 15:30:05 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.41) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 15:30:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YNLWnFtDeqdyCgU0lUnjbIsbm5kBBWnWz9euusq9qfD6mpYdivRIYEwv7zOLCVSeXndjQNpykmv4QsXSpB0eq2iYunEKEpHrsdtFFKZy7fHIlj9sDgjPwl05hy+Q8uH0PkbRuC0p756u608RyXbYpsURhZYVpnWJzTQGgZw6O834ot5Zfn0jsExwpYIMEZVDo2HcJSz6zYieYMu/Weyaawa/pDLWBcQRTSUTp0DQBFeLJDQunK/S94ZzizB8j0PV9UKfMSr6c1lShumF/2/7NLlkIA3B5WQ7XjRxUEQxT38Riz0Gq2/EsFITFZQ2CvLG0NqoXZsXXKOH95hnxLtxVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9OKd3UIfLPwivuvNn/x0zuMVQeS0xCK14Pa0tQKZNc=;
 b=Om6PElviQfOeipgh6VDwGWT9QHubt1TeXtQu1qSMk7IkMN3UNjGSvnJLJFyQcUpwjwDy4hU/yOpsG3msIC5r13zyEAxXMi9mQPoD7muSL7tumK/tezlLW7/df9oUeV83ybVWwTmK5xjbxf2z6bBiO+ADBdRhQY7xiL4ZUhlFUxeiBdDXw373jy0qYoFK5jV01sX9eW1wNStcpTCaYVVEGHbbJhWOFUtCUQ1/WVOQIJXHrT1pR+s80vYK/eYk+OsqA9sNd8SQJ7kiW7D6a3bu4TDXGhZA/WgpprLlIsCKVRnC9tG/YB/7fTQm8obj44Dz6gZaQwwqilIQTHSfrS+9hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8287.namprd11.prod.outlook.com (2603:10b6:510:1c7::14)
 by SA2PR11MB4938.namprd11.prod.outlook.com (2603:10b6:806:fb::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 22:30:03 +0000
Received: from PH8PR11MB8287.namprd11.prod.outlook.com
 ([fe80::a0e5:e99c:ee7b:620a]) by PH8PR11MB8287.namprd11.prod.outlook.com
 ([fe80::a0e5:e99c:ee7b:620a%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 22:30:03 +0000
From: Gustavo Sousa <gustavo.sousa@intel.com>
To: Jonathan Cavitt <jonathan.cavitt@intel.com>,
 <dri-devel@lists.freedesktop.org>
CC: <saurabhg.gupta@intel.com>, <alex.zuo@intel.com>,
 <jonathan.cavitt@intel.com>
Subject: Re: [PATCH] drm/xe/rtp: Check hwe before calling match_func
In-Reply-To: <20260528213412.3709399-1-jonathan.cavitt@intel.com>
References: <20260528213412.3709399-1-jonathan.cavitt@intel.com>
Date: Thu, 28 May 2026 19:29:58 -0300
Message-ID: <87mrxj5frt.fsf@intel.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0138.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::23) To PH8PR11MB8287.namprd11.prod.outlook.com
 (2603:10b6:510:1c7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8287:EE_|SA2PR11MB4938:EE_
X-MS-Office365-Filtering-Correlation-Id: e18350c0-f007-4355-128c-08debd08a947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|6133799003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 3idN+d4nKQATCLb1pwL6ey+eKoJo+ZnxTVqBBsD9rz8hhc76ks7CQnhZ3wsQkNtiL2NGrbMz7QEv16SdDvnpbdCg3+qWVXY84msZyV1Cyrj5syfs3EPgM9BW6VeWF2+p6QViCuiQuFmsGLm3HvZRvuUCEMNfBB0jX1lUv0XGssiuSmRfK1fysZuY77rxHcdGwxTUGULx0Wm3vTBNXvFkF1taTIBIiR8AfuVxoZUgwp6KxtfPToQG2c7+6mRcCeLQZVsx6vZe4B5J25sa3aImUNEQPh9aBILg3objdveByMTlYM8EdLvpUw1e5gHJZ3YPa/66VIrDjTxBgupSNWVqCpHwcmvEh9gnqHLAgl/YuLe9qSdHf73oSD9dNLRGspamTtQpKKAs5GcVcpoH8svOqSlcgK7EvBQ9/nuIkdw7IkgTKE0jxtKjmYqvuQVF87SDwi236ZKtxzQyxJjkCQyp94XQx/OUTHb+91a75Zq2wI9a/3DM8XpdL73pC359P/NkKxjUss6ebyG63gth9pCNBNqQvo23/45KI+DBM4riKI4P+34MUHkbSZ2yvH5XwnJ1SwcPwbrYrWfhCjT1QVVyBPfiqM6FnFu32A79U47L3uRj8LNAllFHrAeRMqN8aQ8mqoE7bK3gjqieTSIWZGFfzeNtPSuEvSBih2ZonAA8KdRW30hy4vH2ZKH0Yf0JW3QU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB8287.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(6133799003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j8bJPKvaCFw1Ys9UR0052KMUQKn0SJqwfYJkaqmpklCeeyKXqfYbhoTiGQOm?=
 =?us-ascii?Q?Eqiuf01Y/E8riYdadsL5os/XWt8hNJJ6zZz1xITGc32DtjyOF548ZX/cvnF3?=
 =?us-ascii?Q?JTXIGpX1kvHzamB+0taQXFalnqtA7PQoEim9EwWba4Bw5lWKKkprLXQaGmPq?=
 =?us-ascii?Q?Y32/qd5NGsiKNOMbBmwdbfzmpXb1Lh1Tc96nMa+kkuFHHG0f0TYfOUI4yqSF?=
 =?us-ascii?Q?x2pgDf3PiCbyOO0tqpBgEdN85sPinD5rzme3O55ZBDVKir+lcrwrQnLZkCEX?=
 =?us-ascii?Q?8CPJqZKJTUiUGANZRKXUh6N5vBZ3WPx3DBvnmJaAZ78XsE+OGL2ufCGnrorQ?=
 =?us-ascii?Q?UjlHUHTpH3LAfTa7A+wPgmmVLvFXoBf5iLD3aY4/o1c22gAcwWkdSSQIVk7I?=
 =?us-ascii?Q?oXFT+uhqI9G8L1tKdz/qynXrvqbskDKFMtGuFZnD+3qByi548p8YGkr56Qw+?=
 =?us-ascii?Q?zDN07TuUCQ4c6MWmxeMb97gKz8iy/rB2k3LOoxUpdpajXhvEaVi6dFyilljg?=
 =?us-ascii?Q?6ihnKUf1LxWcNelGWkTJZ2uyn53BzTgMsU48dvPfGXkAfvMFIpQnF9JsvIM/?=
 =?us-ascii?Q?X2Ezlh96u2wtOVJaH/TkM8SwX02H3dg9G2LVe4JfixyFzbgnyp9RE7WzkaXn?=
 =?us-ascii?Q?JF/wLWK9euiTrQZ2I92gpL2Mo9ELr05dtm9TrcqzNdTcay5ANFaneVjgdnra?=
 =?us-ascii?Q?C0O/Wt9/OZX5L9ErU8/KpxzVbyYncv74NI+LQDHt8N/R/UxScJ5Jrqhrrek1?=
 =?us-ascii?Q?M9GlEtIfODKL3nq5+Ov1VpeSRXTORt4ZfgNtQY1Gs24tW4JyHaz4FztEWA/v?=
 =?us-ascii?Q?Grp8OESRfRT5ByxcSgrQ89jjmWHgvI6lmKkoZdIdy6yZKSInPwdhMi0uRcBo?=
 =?us-ascii?Q?XgLq2mRoA7gFp/vJtnBsi1FRA/SDxkLfqDniNAYHi9UyCKIsfde/CZubgiiu?=
 =?us-ascii?Q?zW9GIYYs0rKaZwjk7Xw5nogQFP49iizE9SWAYJiLFKWcFg/PCrOafvfSyt/r?=
 =?us-ascii?Q?w0L/QEesusDlQbpSTk8UFpZ41fy1uoab2mR9ZtnJE1JpnGZOdV61bvwQRTge?=
 =?us-ascii?Q?K1DEke8S3u2WKJJv0PoGfUb4idTzwLVvXn3HPHDTveMy84O3el0Ef7iKM0kL?=
 =?us-ascii?Q?S1NBbxWXI5fPguV8ncb9mOkaJ/OnnzV+L5KjzfqTKpxrEi9AIjX+IzbhzsWB?=
 =?us-ascii?Q?U2PIKfv0M8XOQFwVcTOA9k2fGqcsHI0l5fZXrxBJEfvyBL+LmdcaGzmEF99N?=
 =?us-ascii?Q?QpZ8BbdzGMHvaxwPUiBQJZQc3YSSZO85XK1ZdImpG8pED0aVIIKGTnIJH8/l?=
 =?us-ascii?Q?oqtB45o16/b3Uf36mrcJ3gCjkhyRYJnlElG+xwtjScqdmees3Dp3AJWlYhQT?=
 =?us-ascii?Q?gJahURRkIcisRDtqlk+y0R27DhBh32SY8NkSCAUCEYiI3g3M3AiQwRKFxHX9?=
 =?us-ascii?Q?jh7jgLilcTpOklSfPDFa03lwU6v8+bBk4y6psbh3Wc4buzOWqGtbKPcJsR3V?=
 =?us-ascii?Q?EZhMM+7IpDQQAf/NflljXmKPXgkp+TpBNkT42kksngyObEqoTlYWklv3pfHM?=
 =?us-ascii?Q?rqQoheqx/3SbMI8Q+LH2vXB0qvUNvnP2QlrVq7O/IqqDiUIXAIZGWQF8X1Ia?=
 =?us-ascii?Q?aXfUPPunv8whrXngkR7fkaU0IIVmx6bPKJ/XXr+d5T5MxHHXU4RAp2QCPuhI?=
 =?us-ascii?Q?0whHDcq67MbZc7OhtbEjeLMQNn755x87dBoBJbUrOWjOFSm5tes0ToFr2NHV?=
 =?us-ascii?Q?3ek3/ch/CA=3D=3D?=
X-Exchange-RoutingPolicyChecked: gRbwad2an7ELr0V5EwxBDZXMxyWa9NlAZQmGdAtuRe5kZBl+LBLMfEvfT4G8l5aAF/XWa9ER0yo2whZ2I/SExPy/G3uwEmKDJ52q0JNd3lpWVOLFkgbCyGtauAU9dJRvxfByM/9cOC7KBUmQOWRwUZBTsUh7uXVzN7i0LpSyccXv0hRhQf6ABIPZEKSvApNME3uHOeFLgONefvo++FN8exq7k7gU1vEgVUmTluHai28BjE8OuaB2S2i5cBxQjpphpphtd5ScZJHau+2HLPROiNLUhGKuuIaIfGjTUN0eft2/6cquOxRs6LIDiLO1DPuGauY933SyaNYpuR9Z5xtYBg==
X-MS-Exchange-CrossTenant-Network-Message-Id: e18350c0-f007-4355-128c-08debd08a947
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8287.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 22:30:03.1844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gu97p2PsgcXQJB5iHcvzIcmJKdITL8bUwATJItE5VDvTMuMI6mseJKYtPzKHfwOJcmJ9RV35jo4ABTHI/taf/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4938
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

Jonathan Cavitt <jonathan.cavitt@intel.com> writes:

> XE_RTP_MATCH_FUNC may attempt to dereference the target xe_hw_engine.
> Ensure the hwe is not NULL before calling the function, matching
> XE_RTP_MATCH_ENGINE_CLASS, for example.
>
> This covers a static analysis issue.
>
> Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
> Cc: Gustavo Sousa <gustavo.sousa@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_rtp.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/xe/xe_rtp.c b/drivers/gpu/drm/xe/xe_rtp.c
> index dec9d94e6fb0..2cd26db113d9 100644
> --- a/drivers/gpu/drm/xe/xe_rtp.c
> +++ b/drivers/gpu/drm/xe/xe_rtp.c
> @@ -129,6 +129,9 @@ static bool rule_match_item(struct rule_match_ctx *match_ctx)
>  
>  		return hwe->class != r->engine_class;
>  	case XE_RTP_MATCH_FUNC:
> +		if (drm_WARN_ON(&xe->drm, !hwe))
> +			return false;

There are several functions passed via XE_RTP_MATCH_FUNC() (i.e. MATCH()
in definitions of RTP rules) that are meant to be used to do checks that
do not depend on hwe.  Returning false here is wrong as it will cause
those checks to be skipped.

The developer is responsible for not passing a function that uses hwe in
a context where it is NULL.

--
Gustavo Sousa

> +
>  		return r->match_func(xe, gt, hwe);
>  	default:
>  		drm_warn(&xe->drm, "Invalid RTP match %u\n",
> -- 
> 2.53.0
