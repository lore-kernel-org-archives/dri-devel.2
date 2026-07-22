Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C783C4453A
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 23:15:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E473910E344;
	Wed, 22 Jul 2026 23:15:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ZJNL2mBT";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73B4310E344
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 23:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784762156; x=1816298156;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=NAMW9FNXT4yajWjMqDqEk5gQxXnsGCaL6fQb4vFTfH8=;
 b=ZJNL2mBTCBBNIBZGnpMx/vxG7qjMB+5cnwRwOG3nfOAbsOrsQ+LtpyYj
 heGuf3Ehk10PS2tQghcKcFrUACDmmSrVHF+OliF2P/RJW64jtfBjnGB1X
 XzpgS054hBFbNkveuzxlD5/e+Hrsptna+iK5jjsOe+8Ck9+ARVDAwMqmh
 CE1+WSG21qjLeENtKfGGtxN9lxGWLB/UIeNSuMUb3QViJo2M+bp00o2XW
 gAkhJfHM5XExb1PplwqQw59jVXK8UL+ba+W6YD+gsSsh9uWFw7aa9ECE6
 E991wpHWHGNK4+vPNhUYG5Sw9X0qeb269IKWW5piNmbKh4CfLQJ10R7ST g==;
X-CSE-ConnectionGUID: MWUcZ97VTCWqRMLTphzPNA==
X-CSE-MsgGUID: 33P7uvdNSDSsa4y/rQtNpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85604064"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; d="scan'208";a="85604064"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2026 16:15:55 -0700
X-CSE-ConnectionGUID: s3GHVW1qTmuZ3eUNk5yGqg==
X-CSE-MsgGUID: oQVJ9/0dS/meMqs8sU9xZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; d="scan'208";a="256438542"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2026 16:15:54 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 16:15:53 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 22 Jul 2026 16:15:53 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.67) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 16:15:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pwZ9B8+WHHZPZI/9Q3XlmIJR93aJ58tS0W94Hn8XvpAZX1TXKBw3VAauDeoGcQR6zwxjDaJmxbuJKC7Yc22wAoz2CPRArq3UyCjHtia2c6IKPtHQLgwQ8v8AuVhgtx25D40W3t4oa0jznYBaI31UZiKr9M8Gl5Q3rqsGEVm3J09hUwSDZSFUT7Zsgg/yd2cH7IYmco5yLle7D14GaeKoWXCEmhMYZLBAqgMeviLv1HwVc9YUPJOPLpEfakSTLHs942VuP7iYBi53M0KQxL2Z4jzHq8fZKjgBChc4PzFa2WiMJrQ37k1pOKRnM0C3AeEXFdvHJihA3tgiu3iA3rbamg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zb4eqmgUED98p3Gp4i7Y3GQiv/6hiOpM/zYckDqgfJE=;
 b=QQGQuKAlV1sdtso5hr+ojBMkRpOW2FDeXBTCHi3bP5NEanntWfQDTabvUvOzvT0uJkkCDaghU4NMD0N8sR1Kn4exneujvNSOwTCtcX1ZiuFiz8ZyNyL6M78c6O4VgkqNyQiZHBR4d3PdJlCBUo3W6qNklzG+NEoMM/t7i74tlIcwZqE9u4O+GgDttlpUPrVjxFK48xcd2xAWwg3KPms/RPKqPv5rXxgNBPxhFsElXGcrXkw4BGg19IN/V8+3nVL7PJy07sBhQ0JU209SrHhRUIZPavbgsCLSI3glBjtTIAZqt8A37DWJud4xjjTRwOLekBlwJOWb+k5YEq5W+ZMrYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SA2PR11MB5083.namprd11.prod.outlook.com (2603:10b6:806:11b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Wed, 22 Jul
 2026 23:15:51 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 23:15:51 +0000
Date: Wed, 22 Jul 2026 16:15:49 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Nathan Chancellor <nathan@kernel.org>
CC: Mark Brown <broonie@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Andrew Morton
 <akpm@linux-foundation.org>, Usama Arif <usama.arif@linux.dev>,
 <linux-mm@kvack.org>, <dri-devel@lists.freedesktop.org>,
 <linux-next@vger.kernel.org>
Subject: Re: Semantic conflict between 04b177544a04 in drm-misc-fixes and
 0b6b1bb28482 in -mm
Message-ID: <amFPJc1NQbuYWlSp@gsse-cloud1.jf.intel.com>
References: <20260722225605.GA1910198@ax162>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260722225605.GA1910198@ax162>
X-ClientProxiedBy: MW4PR03CA0078.namprd03.prod.outlook.com
 (2603:10b6:303:b6::23) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SA2PR11MB5083:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fc940dc-36e7-4599-657f-08dee8472c43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|1800799024|366016|376014|22082099003|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: +sn1+uANq62z5eyt1jZXY8vF2TCfP2JbSuC7H3Sx8WLgwdBCN6k5rzynpVlLsiTQfO1nh6AAmaNC8awPqEN5WIdowbMgg66vCExmphRpsZTTcS0ct5OzfDBJKWX2M4+rKZy/FIiCDbotSMWox19WRgBDMOyOwnYeJEwAuQgcNXkL4YBzRlnT0eK3XFndiKNRRwDIuG7Y1ypBDI/zjXfpNVvw5uy4/PO+WgP8ScWzR7ZMmbGEw7n0U2RAVbq4wRG41LdQTUxij8k6ynT1mGKednyUArWwK3uugXeK6k9mIscUWILQa/6BFEzll6hZDQSb5LBdhtwhtkMipJGANrDOhH5qjgyy6GoYZ0h91N4OtWw/8bFIWoR/Lx9UPV+5Tuz4W6igWPBl4mstr6W6EYJFcfZaH3Sk7o87I3/y+fJBEX2GTyn7QUw85g02aIX1CnJjoVGfwJ1feaVNEjVpqzTmiq0ULi9jxrDbbE+doKXwBJWW587jLdU1aUa5pV8KQcW1jGcYccI5xfQ2FO5Rxxnu0uTQ4tkE6n4q+irU7kNGkuuatp6q+3Bcu0UFB5GnkCRWG53k+bsCtIGI2JqKLguu849EI8Aye0jCnGcPsyuqmiebETeav6mpRe4Tc5RThM1Z0y4wPvFq7UBeY66PAsyPIdbs7I2ekheFHdUKqEUk/xU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(1800799024)(366016)(376014)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+w1XOYMqCJ/19SHNFF//uBHGEppDS3U5FnuNRFTIwC+JOQ8kH8h/moBmM4dF?=
 =?us-ascii?Q?eNGTXa2wajNethnLmsyGuKXOOM5NC89xTxnX+NlRpU8mOTO0cOxEq8SLUqZV?=
 =?us-ascii?Q?yMQ18Q8u1u9n9K4GK1LVCCiS7cIC8FXtQOsb8nFASCzuTvF579pWwITfnnxZ?=
 =?us-ascii?Q?c2A97Q/Ttm75ECW2Mds1oXubZ1FuLdAvvH4qkbLb2xCrVvOcMPC8Bsa9ahFX?=
 =?us-ascii?Q?HGVo43t4LQ6fRwoZXs+PHL4FKR5n5rTd7NvRMOis2gtFkgT/XSUv7VzYCKlH?=
 =?us-ascii?Q?DGYF909NOckgflRlWmAkjHScYGnyB3KJWgwzLMHPdBgOzoP+04eUTQk4ocTH?=
 =?us-ascii?Q?sFNG2WhfC86STYaG3ctJk17FSGyAMT1xeXVZQuRvGVcjitcQa7ie2/vXAn8o?=
 =?us-ascii?Q?23guvaSQkwjrnnL7aLX0pYhhlNZpJO9qZiNj8JXwAkIOqRm2/3e9wtLHbpm4?=
 =?us-ascii?Q?IKghTztpcze7i5G5scQOjh/oHnR/PMSG/noKJZmbZi8ddwTlhWkiM2h4/WnC?=
 =?us-ascii?Q?yilOWCR1y0o9WWJgM82FS4yFEFVomXnUfpyI/j4aX1am98Gw11sUvcszfL+M?=
 =?us-ascii?Q?hJ/Q7VRpbQco93G/z85sP/2eRFG0Y+6VoCAlab6iqHcCNsdiWhKetWmWA54k?=
 =?us-ascii?Q?kJP2DTKGvpWGAzvKjHTETbAPK6Pp3BVOHBuz9kKdmJhl76Zmb0OhLUEbdlB8?=
 =?us-ascii?Q?CJSXaTXihlmgCy7tvjHWLJ9oRKnU+5qhrdde/DsDMQ/9XoB2EhELwN9RhDK0?=
 =?us-ascii?Q?Hwxr3TRBjMgaiG7/H8kG2fRG0kYzEO4V6BA1kCON4EQHKWKc67eVEO095kbE?=
 =?us-ascii?Q?Uoup8KsGYlDAiRRMNMylSjgiNt+9HfeK3mWRp2rSWzeeYGBaVLdPFkwEGRGF?=
 =?us-ascii?Q?aSTiYj9tc/yZg1/91iKZ9dm7c2ILvOU5bG37UIR3oMWyCbFTsDt0daKKGYZL?=
 =?us-ascii?Q?naLAh/K6hczSm9TlSwbFOiTIBFGhVFa02vdT1+zNJ8+6Uuf9uMY1IE7kHKKq?=
 =?us-ascii?Q?fToN1pnaiWXCKQGFntQaQzE4RoXKeK6y6jItAhq8S/pL+1/Ppc6o4nhlhlfh?=
 =?us-ascii?Q?OI++MhUgrLu89+P/FRTd0YOjRwT03volEcIDmq3R3l4hpQr2tfurlybKtUoP?=
 =?us-ascii?Q?qGtXgGKHPNrisDCrP5Gk75kkchw8h3x6C+u3r+/fK4ZrxswnDiPELk4bOKw0?=
 =?us-ascii?Q?GwvVSxnANATbz7RfIJNtpfGhNuORvPyzGvVJhfC6sc4XTTDVwDxwXkjy5tNK?=
 =?us-ascii?Q?7xtJGbflIiLHWZ3SWJVbvw2CG7R8bt97yW7bCLhFIJujQD5UqKill9sAdEYw?=
 =?us-ascii?Q?UGsC7L4pjMju90TkK7e9ilDS+elDhhR6bTRZdtdCMPytUQzPERSWDGZ0fkZ4?=
 =?us-ascii?Q?EvkB3CfRVUtP899OA6xOTBVJ+/fvqRPoLZ3ltH0U47hXk5X3pdN1QdtVyriT?=
 =?us-ascii?Q?xRgGP02M82WrYmW6gwoFkpzE89y33H0Vm1fuibOGPVJmjUtClo8Xzd6dAulO?=
 =?us-ascii?Q?RmI5m5gdbYW0Xuhnvnx5uxW/MFPYjb+iI8xhzkMB5aAUFvB1zoKpNB8evgDU?=
 =?us-ascii?Q?N1qSa3jqLksf8UK6K5l74NMTiHLnW3zZiRVgV3ti2ZxQCK/uU0ltcq9If5fM?=
 =?us-ascii?Q?RsmMRJ4IVLt7CY/gtNfEY08N3sifpY23kec4rBSx51ShWWfDNZysdUbjF3+O?=
 =?us-ascii?Q?KfO7HbghMVuAuC9IMWNPf8qHD2KEMYrxZKf+rAPPrmUan8mI6SgaThapvAV7?=
 =?us-ascii?Q?Q1t+LR4aIQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: TLUNGmtw5ks9nMu3DDpZXpWoFpzaMdJYkGy6Dk6qT4NT77RsN6/xAVOmZm1GAiiW3zZR+QcuoXzSd7Wak0/0Vz/N4YfF6Nx9ZNI/XZzhwZRDducHRj2y36DnKJgFafv3v1a7RkT93EVcuxeD3ojX84kdGZZHjBNEN3dafeW2Dwakc86LXEXctI6OfRNXQCyAThKVjlWkPDNh1d5fMdwdMcB1eejddi+bKntUuFBPXElNX5woEt8e2jh0nIxgGFR3TwZf4nLJEnIjIdk+qAyd1SrdStghgzhzclxpL3La+ybzE19/p58DDiuCwCmuk+6+l0GvNMVkq9CkHFOkyChP/w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc940dc-36e7-4599-657f-08dee8472c43
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 23:15:51.7785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8d6KPowc4zsSjxmK0+SQfMTD9Y078oUIGwPMpOA2fQWRe+VV/qSi98S4zh6wYVExyYxGWIyDZtpTMxLUR5UDHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5083
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

On Wed, Jul 22, 2026 at 03:56:05PM -0700, Nathan Chancellor wrote:
> Hi Mark and drm and mm folks,
> 

Typically to get drm_pagemap.c to compile on various configs this is
what is needed:

109 #ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
110 #define HPAGE_PMD_SHIFT PMD_SHIFT
111 #define HPAGE_PUD_SHIFT PUD_SHIFT
112 #else
113 #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
114 #define HPAGE_PUD_SHIFT ({ BUILD_BUG(); 0; })
115 #endif

So the drm_pagemap.c code could be:

-#if IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION)
+#if IS_ENABLED(CONFIG_PGTABLE_HAS_HUGE_LEAVES)
#define DRM_PAGEMAP_PMD_ORDER        HPAGE_PMD_ORDER
#else
#define DRM_PAGEMAP_PMD_ORDER        (-1)

This Kconfig has been around since 2024:
git format-patch -1 b979db1611a63

Would it be better for everyone for me to change this in the DRM branches?

Matt

> There is a semantic conflict between commit 04b177544a04 ("drm/pagemap:
> Guard HPAGE_PMD_ORDER use with CONFIG_ARCH_ENABLE_THP_MIGRATION") in the
> drm-misc-fixes tree and commit 0b6b1bb28482 ("mm: rename
> ARCH_ENABLE_THP_MIGRATION to ARCH_HAS_PMD_SOFTLEAVES"), resulting in a
> lone instance of CONFIG_ARCH_ENABLE_THP_MIGRATION with no way to define
> it.
> 
>   $ git grep ARCH_ENABLE_THP_MIGRATION
>   Next/merge.log:Merging drm-misc-fixes/for-linux-next-fixes (04b177544a040 drm/pagemap: Guard HPAGE_PMD_ORDER use with CONFIG_ARCH_ENABLE_THP_MIGRATION)
>   drivers/gpu/drm/drm_pagemap.c:#if IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION)
> 
> This results in an objtool warning (or error with CONFIG_OBJTOOL_WERROR)
> when building with clang because NR_PAGES(order) results in 1U << -1,
> which causes clang to stop generating code for
> drm_pagemap_migrate_to_devmem() when encountering unconditional
> undefined behavior.
> 
>   drivers/gpu/drm/drm_gpusvm_helper.o: error: objtool: drm_pagemap_migrate_to_devmem() falls through to next function drm_pagemap_zdd_alloc()
> 
> Mark, could please apply the following diff to the -mm merge to avoid
> this? Obviously, there will need to be further coordination for
> resolving this upstream when the time comes but it is only an issue in
> -next currently.
> 
> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> index 4a794544b7dc..f00c27edbfb9 100644
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c
> @@ -12,7 +12,7 @@
>  #include <drm/drm_pagemap_util.h>
>  #include <drm/drm_print.h>
>  
> -#if IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION)
> +#if IS_ENABLED(CONFIG_ARCH_HAS_PMD_SOFTLEAVES)
>  #define DRM_PAGEMAP_PMD_ORDER	HPAGE_PMD_ORDER
>  #else
>  #define DRM_PAGEMAP_PMD_ORDER	(-1)
> -- 
> Cheers,
> Nathan
