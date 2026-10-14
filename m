Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7CC1CC6B2D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 21:41:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D24BE10FFA2;
	Wed, 14 Oct 2026 21:41:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A70810FF70;
 Wed, 14 Oct 2026 21:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792014078; x=1823550078;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=5Ko9KtNXTbFxJPh/YUZOGOxax2RRHO1ZPyx9+dtHEKE=;
 b=ItlLTMzpZXINUQJVpx+AuvfLf8q7n8yhenEadmqS+NxTQZiA4ewhS+OP
 78+IADy88F4xvekhMn2oG0QMSqC7Ho1gcJY9gBlSO+jIURPwRmcMNLCga
 mcIg0wzef26Sl08I/vCVp2yFuIMKsStowIld7YHMQd1bT8YFvNJbHeTux
 HXEJ4iWuSv7oG33JQzQV8KN9Y/j0q9h/YqQMatBpBKPsiuoK9h2TvgaGa
 9g7Lq7NWRds2fYTmEIU8v8tBDUTTjZ3jgEDNVWo7zGK+/khwraD96IpgE
 dMVmOR/XmAYb5L7wwPfdZEdJGOA+o+lcwO1f9SmSBxzQzoMpR2bOF0X8J g==;
X-CSE-ConnectionGUID: MNq3RmSlSU6bG2YmRCtWDQ==
X-CSE-MsgGUID: TxQPeTX3SuOUphqgedoIzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="778114"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="778114"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 14:41:17 -0700
X-CSE-ConnectionGUID: EcpY4odjQ72Fu2I/vgKH1A==
X-CSE-MsgGUID: cS0qTC18TEODSv4KmOiWVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1554920"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 14:41:18 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 14:41:16 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 14:41:16 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.16) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 14:41:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ygX3Tde2eKLT8t0lCV5h+i5OlTQK6acRQrOC2rjJ/3ZgXwjA8IU6a2kbILYQu+9/JW8XUgF0G/miBupxaSyWgzl4811iJ2ugl5HR8sdXINqEfP7Q7JIXqTW0LLzZolZpI304+HXrEYY71o3CqemM1IZoYbwVdl7GSfC0eROhX6cPTcnEBh3mJR/Bo1sa44dpLVU5ReuHhake+1IhN21P9/fu7HhFqn4WgS0MLWy3YpeC5ZxSkZGedI8sJMHS53EeoP0WeeUa/AbkD5QB3ZG+6d+MlUuhgpl8DU/pXXM6iyWJWEAIxQgjAHbyp0R5u7EG5ZxznpSE/v04O92Aruh8tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Z3XASt/xtDmgZJpCxTkxunjp05ewzE+ROTIeLk7zcA=;
 b=TzZdb34Hs0PRhXh9PjwvlVfB10Tr+8Cb0isuvn2QGWy7meoMdM9gBVkiCzVhSCQvvXh5hw70p/IKROpG7n2I6wHVwYLMsmBwRHeoojnLtTkICHR+pMQZY+Lv+rahtC3MYpB58JoUZ0bpKE2lHxq/gnLWbiaV/nDHLs1ir8RWPxPuG+p68D5W8twFvtpRl1/aurQil+2OjCRe2ZOvDqgX4en0pBye57JNxY0szG4SsczsuRyeTablr5BgCPjeDJe4JHoJiD2FSnOg/jeFXXuTLD3gbvQ31JU0k4grgSvRUcERx0bJTBEjYkyixUtAkvOOK2cdC+JHENfWBa/02/t5GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB7181.namprd11.prod.outlook.com (2603:10b6:8:113::13)
 by LV8PR11MB8678.namprd11.prod.outlook.com (2603:10b6:408:20b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.24; Wed, 14 Oct
 2026 21:41:13 +0000
Received: from DM4PR11MB7181.namprd11.prod.outlook.com
 ([fe80::89ec:90c8:3170:5f0a]) by DM4PR11MB7181.namprd11.prod.outlook.com
 ([fe80::89ec:90c8:3170:5f0a%4]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 21:41:13 +0000
Date: Wed, 14 Oct 2026 17:41:08 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <netdev@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
 <simona.vetter@ffwll.ch>, <airlied@gmail.com>, <tejas.upadhyay@intel.com>,
 <himal.prasad.ghimiray@intel.com>, <riana.tauro@intel.com>,
 <raag.jadav@intel.com>, <joshua.santosh.ranjan@intel.com>,
 <ashwin.kumar.kulkarni@intel.com>, <pratik.bari@intel.com>,
 <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>,
 <jinzhou.su@amd.com>, <cesun102@amd.com>, <lijo.lazar@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>
Subject: Re: [PATCH v2 2/2] drm/xe: Remove bad VRAM pages debugfs interface
Message-ID: <as_29EaVQuvGlaXT@intel.com>
References: <20261007080354.3072751-1-aravind.iddamsetty@linux.intel.com>
 <20261007080354.3072751-3-aravind.iddamsetty@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261007080354.3072751-3-aravind.iddamsetty@linux.intel.com>
X-ClientProxiedBy: BY5PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::17) To DM4PR11MB7181.namprd11.prod.outlook.com
 (2603:10b6:8:113::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB7181:EE_|LV8PR11MB8678:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ad501e3-6b8d-40bb-dcae-08df2a3bde59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|23010399003|6133799003|22082099003|10067099003|18002099003|56012099006|4143699003|261009221727099003|11063799006|261009223027099003|261009220027099003|261009221227099003|261009223327099003;
X-Microsoft-Antispam-Message-Info: HFxPDKpM7QwP+gWyGnwkIcbcVfez7kBTI3DSnWWf40dXcoNiuz5aWchUDVUoNG5pRXFwhms6r3UcHplcTF4v6QpVJ7sqPnUYBlf6clfrl4gLrAl+XAJj21k19DO0l7Z6WLdSBBUyPgLc3PQuCNm7K6jgCXzZlmNUsVk9iQfZBxV7DRMkluM6DnEV4qvi/dt8J9cbrAsPTMliqyrdwloIL3v7t/p2AL0RrbquAVHZk/8pyme5d9j6DpysWdQ810MfyieRoSFCvl6vsRLeGAW9P+g+MDHXkpEvZXbdOGJoLEukSybJW9gLGm3hQxZkAj2eQcb7Wvtr2+qpPpIv/m5S4zJYIIJv8N7Qx76cDFKiNVrVVZAY+bStzvVLMU3WF/7rzWiinpyg8ba+CuqaAlQhOhWfo3LR1k/VGJkGJwom8hclGFOsiWBqYM2uEFi7EoFcE/a7WbMsYti1Uv4+2+cC1BRtQawGTzV7Ao5DRV2aAQyKSL5WxPePPp7LpCcU7rFL+PtTGv7fDDOqgPgjfq5DQ1n40WDGo9iKnym71Ia91DCo6o9l3qpIu8BOnhBrSQSZfYWP0f9teb/MPsMMG7UZtwTr2FNS55MGLRyj9JdX5SqSVZlNdshabRoez8rDI9nW+MBla6KQalWEmGcqOOhXlMWHEevzdmaAtvauzcWkS4o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB7181.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(6133799003)(22082099003)(10067099003)(18002099003)(56012099006)(4143699003)(261009221727099003)(11063799006)(261009223027099003)(261009220027099003)(261009221227099003)(261009223327099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dfWlzO2vPNlLEV5oD5P02SOKCriwmFtLO9MuO5eTqKtFrv9ZpvrIR/mwktxS?=
 =?us-ascii?Q?43mrERPdhOykovredeGef0Ydc+rR06KC9qgh9uxh0Tgp5ym98SfrDwtCDqoW?=
 =?us-ascii?Q?4l0i+Y/TuWCWws2QADdPJ2vbZtgJpq9QxWs6NkO5iN9XNvkbQjz6yHpE2tKK?=
 =?us-ascii?Q?HY5qEJDUoHFINozD8AODMquCcHvjWb5KI8oP8SGgriNBQxey++C9n8ISkasl?=
 =?us-ascii?Q?HqOD7CXMoyNDdNcaDX6mvLgz9QJP+yLpN+MrCK79nLXWsRHQPHM99vV0BGg6?=
 =?us-ascii?Q?WvtJ8frcj2NrEMH/AiAnAWDlN9rWdgTC1bGmCwQUIWwSIcikUPIRufiBi5G6?=
 =?us-ascii?Q?Rtgo2ARmeyP7n+tgvApg6PfKQ0xHOl1xQ5pJDECBBy338l6Vwo44F2yho5D9?=
 =?us-ascii?Q?XTPrTubv273SDJBlqlWflJwyDUiDcag+bDwnUDL5ljrrDKx9Ay1ZTn4Nc+Sj?=
 =?us-ascii?Q?gBFJ1172doJnB/QIbBcWyDkvWOYV0QhX2BUuemig2OP2Maluordd54PKRDDd?=
 =?us-ascii?Q?7enQ+12J5zSeGtXdfpSXS1jsXRFqgxky0Me8DaRC7ARiraPcuNHu2e0MBfc5?=
 =?us-ascii?Q?vZv8jzQKt3mZqGcsaE91wFtSYEc4oCnJcYaDRIpi38wkHKJ09Wz7oAtF0R3G?=
 =?us-ascii?Q?v+tJ49E563HKzp8/0xkpxcWO8ikbGNbWMhPV8MglPZQjg4OxG0XPymXBdxHZ?=
 =?us-ascii?Q?sIPS3LuEiPEFtc5mhb52D/YVLI31iPJLRNbMyUkT1a3y8kzUaLDgTRnGrDvG?=
 =?us-ascii?Q?eIBfxQvUKOlCk9vV7k/91+cC+cnpEg1Jg9Tie2LAzzUeY1MxN/pK1w5iu/Je?=
 =?us-ascii?Q?D2EvNZmxYYhRX3wxRnpyg/5gJWu4GB66hFznsYFfDezh6DrzKgRMZaS7Bli1?=
 =?us-ascii?Q?6C2JU5KMMSowKCxUI22ZSlRAj8Yz904QA5BpIa/rM9xJJGhHGmYdkd1w1akI?=
 =?us-ascii?Q?5kzVoSJ2gskOOVaxalvPK+wZHPS+STt0klQHLDL9ygjOqTUmr2labmR1FRRM?=
 =?us-ascii?Q?EWq/hMG+LqNaeQqKvNrLf58K13W4ztnBz/IL29rdTzX3N5y/T+hnbwdbYxrX?=
 =?us-ascii?Q?+8AjO/RYIJhu5xSsvUDm2HRv307QtCW/XxUGRPZRYuY3M0HEnY7N+oFiD/7s?=
 =?us-ascii?Q?oiWk4Jbb5cKrwim6ObvoZ5ADK9WlbyI7Z50uVlwg75rIBI7xmZcF7ZwP7T/s?=
 =?us-ascii?Q?X8TTtLTI42BEthwkyWq/WufOTySwYXHKJfYMiMxWdcNCcD0XiqqlxneVQVjV?=
 =?us-ascii?Q?ToGK7vMFbSlJKE8B5xPDBIg76kJl19CsAgAcbOREncKe0b3bQ64gGmu8gT6r?=
 =?us-ascii?Q?RtcoKLOqDa9V/qIkrbDGo/cn0cRWbK2/QqHm1Dq4Tfs7occzmxjhDvK5Snlm?=
 =?us-ascii?Q?2pE91RjNLkPBXdJGAyWEbnu/xmppRYj4oGqOW8Ldis8Si0J/UpqNoaFzkY6l?=
 =?us-ascii?Q?k4YeqwCJAAyi5q/d9yvEF9krq1xeNVszXxwrLkjmX3p4wMh+N2sgE83NnH0U?=
 =?us-ascii?Q?TltS0yVBHZhKosm+B1BUbomARkgYsuKI378SC/XM6vhF5ngd2lMXeaGE3b8q?=
 =?us-ascii?Q?S3uzCW5WCnD4RPaBVpk6ITnMdF9rMMKvUO4CYeS3WM5Y/VpmSOsLsOnpvkvm?=
 =?us-ascii?Q?xoZVGpzreWgWacSj/daaC3mynk54J3vheNrQxmtF1w01b4jctZ5JmYx3bMGl?=
 =?us-ascii?Q?QeRl1x7wwGBXeGCwrcWnS5MPKFlD4JYwwAktxf5/XF4//sz6HiNkr1Ccc9RK?=
 =?us-ascii?Q?eBK3rq9cfQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: jJr4ozwa29SAWiM/6nLBKXsUuID45yVi21NKIanzcSDoM4rG4tuzVSuL3RDwUvN4AMLYxkbU3EH/PXCEb6bivu5l/OZklv6EWnXPEb0UbCQ3aiktZRhDKSq1yqsLT3fgO4yISX7U6xVdHGFtklyVBpp4K5dbUKoUFAZXOpGUW29qtvHR+La2s7LFMbt3XXndBKu56T4NpIVafU25rfmQ6Zei0bZeGe7rjSTp+Am/jnPPMXvc+OFGzihRwVx2Iw3WMjIkTueCI4e1z1SbEe8OP3qFv3CbdJspc3C6GXlP9yey5IulPhlV2LqCYmHYzcuPQahZRLeAIy1gElc8bXjN4g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad501e3-6b8d-40bb-dcae-08df2a3bde59
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB7181.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 21:41:13.4696 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BUCq9zmDTf6KssE8kOpedyUntFS8rWUQVEeKZbd90F6IHQ/5Le4yCr8hjE5PRTMf1OhczvVSJA/XxVQPMzqqOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8678
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

On Wed, Oct 07, 2026 at 01:33:54PM +0530, Aravind Iddamsetty wrote:
> Drop the "vram_bad_pages" debugfs file added by commit fb19798cc366e
> ("drm/xe: Expose bad VRAM pages via debugfs"). The retired VRAM pages
> are now exported through the drm-ras generic netlink interface, which
> is a stable ABI, making the debugfs-only readback redundant.
> 
> This is a partial revert of fb19798cc366e: it removes vram_bad_pages_show(),
> its DEFINE_SHOW_ATTRIBUTE(), xe_ttm_vram_debugfs_init() and its call site
> and declaration, and the now-unused <linux/debugfs.h> include in
> xe_ttm_vram_mgr.c. The struct xe_ttm_vram_mgr.max_pages field introduced
> by the same commit is intentionally retained: it is the FW-provided
> offline-page limit and is now consumed by the drm-ras retired-resources
> capacity summary (xe_ttm_vram_get_max_bad_pages()).
> 
> The fault-injection debugfs interface (inject_mempage_offline) is left
> untouched; it remains the mechanism for triggering page offlining in
> test.

Let's keep this for a while... no need to rush and remove it...

> 
> Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
> Signed-off-by: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
> Assisted-by: Copilot:claude-opus-4.8
> ---
>  drivers/gpu/drm/xe/xe_debugfs.c      |  2 -
>  drivers/gpu/drm/xe/xe_ttm_vram_mgr.c | 71 ----------------------------
>  drivers/gpu/drm/xe/xe_ttm_vram_mgr.h |  1 -
>  3 files changed, 74 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_debugfs.c b/drivers/gpu/drm/xe/xe_debugfs.c
> index 926020c7526e..6a19737104fb 100644
> --- a/drivers/gpu/drm/xe/xe_debugfs.c
> +++ b/drivers/gpu/drm/xe/xe_debugfs.c
> @@ -823,8 +823,6 @@ void xe_debugfs_register(struct xe_device *xe)
>  	if (man)
>  		ttm_resource_manager_create_debugfs(man, root, "stolen_mm");
>  
> -	xe_ttm_vram_debugfs_init(xe, root);
> -
>  	for_each_tile(tile, xe, tile_id)
>  		xe_tile_debugfs_register(tile);
>  
> diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
> index b56b543a56a2..9fbdf1dcde8a 100644
> --- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
> +++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
> @@ -5,7 +5,6 @@
>   */
>  
>  #include <linux/cgroup_dmem.h>
> -#include <linux/debugfs.h>
>  
>  #include <drm/drm_managed.h>
>  #include <drm/drm_drv.h>
> @@ -1120,73 +1119,3 @@ int xe_ttm_vram_inject_fault(struct xe_device *xe)
>  	return -ENOSPC;
>  }
>  EXPORT_SYMBOL(xe_ttm_vram_inject_fault);
> -
> -static int vram_bad_pages_show(struct seq_file *m, void *unused)
> -{
> -	struct xe_device *xe = m->private;
> -	struct xe_ttm_vram_offline_resource *pos;
> -	struct ttm_resource_manager *man;
> -	struct xe_ttm_vram_mgr *mgr;
> -	struct xe_tile *tile;
> -	u8 id;
> -
> -	man = ttm_manager_type(&xe->ttm, XE_PL_VRAM0);
> -	if (man)
> -		/* TODO Hook with RAS to show max_pages fetched from FW */
> -		seq_printf(m, "max_pages: %d\n",
> -			   to_xe_ttm_vram_mgr(man)->max_pages);
> -
> -	for_each_tile(tile, xe, id) {
> -		struct xe_vram_region *vr = tile->mem.vram;
> -
> -		man = ttm_manager_type(&xe->ttm, XE_PL_VRAM0 + id);
> -		if (!man || !vr)
> -			continue;
> -		mgr = to_xe_ttm_vram_mgr(man);
> -
> -		rcu_read_lock();
> -
> -		list_for_each_entry_rcu(pos, &mgr->offlined_pages, offlined_link) {
> -			u64 pfn;
> -
> -			pfn = (pos->addr + vr->dpa_base) >> PAGE_SHIFT;
> -			seq_printf(m, "0x%016llx : 0x%016lx : R\n", pfn, PAGE_SIZE);
> -		}
> -
> -		list_for_each_entry_rcu(pos, &mgr->queued_pages, queued_link) {
> -			u64 pfn;
> -
> -			pfn = (pos->addr + vr->dpa_base) >> PAGE_SHIFT;
> -			seq_printf(m, "0x%016llx : 0x%016lx : %c\n",
> -				   pfn, PAGE_SIZE, pos->status ? 'F' : 'P');
> -		}
> -
> -		rcu_read_unlock();
> -	}
> -
> -	return 0;
> -}
> -DEFINE_SHOW_ATTRIBUTE(vram_bad_pages);
> -
> -/**
> - * xe_ttm_vram_debugfs_init - Initialize VRAM debugfs interfaces
> - * @xe: The xe device structure pointer
> - * @root: The root dentry of the debugfs directory
> - *
> - * This function registers platform-specific VRAM debugfs files used for
> - * testing and debugging. Currently, it exposes the "vram_bad_pages" interface
> - * to inspect marked faulty memory pages, restricted specifically to the
> - * %XE_CRESCENTISLAND platform.
> - *
> - * Return: Void.
> - */
> -void xe_ttm_vram_debugfs_init(struct xe_device *xe, struct dentry *root)
> -{
> -	/*
> -	 * TODO: Replace platform check with xe->info
> -	 * once the feature flag is plumbed through device info.
> -	 */
> -	if (xe->info.platform != XE_CRESCENTISLAND)
> -		return;
> -	debugfs_create_file("vram_bad_pages", 0444, root, xe, &vram_bad_pages_fops);
> -}
> diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h
> index 70fae023d6a3..7a4a041b8218 100644
> --- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h
> +++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h
> @@ -17,7 +17,6 @@ int __xe_ttm_vram_mgr_init(struct xe_device *xe, struct xe_ttm_vram_mgr *mgr,
>  			   u32 mem_type, u64 size, u64 io_size,
>  			   u64 default_page_size);
>  int xe_ttm_vram_mgr_init(struct xe_device *xe, struct xe_vram_region *vram);
> -void xe_ttm_vram_debugfs_init(struct xe_device *xe, struct dentry *root);
>  int xe_ttm_vram_mgr_alloc_sgt(struct xe_device *xe,
>  			      struct ttm_resource *res,
>  			      u64 offset, u64 length,
> -- 
> 2.25.1
> 
