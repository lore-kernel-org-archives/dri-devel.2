Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F4F606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fzK2IsA3;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=gOQUEg67
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8614310F0BE;
	Mon, 16 Nov 2026 14:25:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1C6310E908;
 Mon, 16 Nov 2026 14:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794839093; x=1826375093;
 h=date:from:to:cc:subject:message-id:reply-to:references:
 in-reply-to:mime-version;
 bh=+7Sh1xAPI/90+ES/+zI6/HMQsv9xUNlJagpA10elZ48=;
 b=fzK2IsA36TqP0OAjlEscwdpYKn2LgUKOdmKdCHFqa3/5dG+2Mg/cn0zL
 PW7QiU2ZOLU8ESMf0MSzYi/kGCVoQD2fWrGZSyT0qTAhhsPyOi0tcqvvI
 9jsMq3Awa5LI6zI9YR1GFAzFHdGhXmdjEbEsUAwX8Gm8dswXfaueP356p
 Yb8/CsV2K+JblaFsaOaepSCfnP5GSKa/ZJCVTLhJvyB7vywO5kEr4qo6P
 Re0h3DmWH3dNh1KIOmuqquhPK4IwdWYL7L1jkK8MhPRcib5Y9XgCuCCEX
 6dd7a+nHrIQr7yh4G2u1N/62blN3UI/kKEa6Rof0litBIRGSsND4i3EkN Q==;
X-CSE-ConnectionGUID: TVo5v8eMQviRXVaegpHBlw==
X-CSE-MsgGUID: 6SGmjPeOSridp4Vx6DdAzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3585831"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3585831"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 06:24:53 -0800
X-CSE-ConnectionGUID: oMxiJk0rR+SrRTI2nDA1rw==
X-CSE-MsgGUID: vjDETxRLTwaEmf4K4J6mJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; d="scan'208";a="11352810"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 06:24:53 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 16 Nov 2026 06:24:52 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 16 Nov 2026 06:24:52 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.19) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 16 Nov 2026 06:24:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XBCZqYMLrvWm9DoKja0tbXZG5oK/FX0EnkT4O7E1wJae8id/t3sC3l7uV/xSRQLauBnL9avYDwp3mzWcKzBgPOpJ4HvafCS2gT9trpAgYebDRk60wivSJftx62gwlTa75jkhTeLmOvJw+y4tqd9heUoau0GMUJ9vycULruOH9F8CZfdm2FtPaPt+nHuc0HAI3gYDIIYeu9y7FRLokYZ6M94hBtYUMo1gI20jSC8zP+cC6OilfIleXqHBTMKe0lAiZZh6BdoZwFZejTMo8h1DrfA+eoFhCSFo+kjtDmowXQixQFATSNskfYNpO3WLVkUc9Bk0q34lNKpiP5zJOIkmNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rr/zCuwNGMyO99Gprs5QWO6st1ZaLobILTAiBmQFUI=;
 b=Tx1ffxlw32lW3Vt3L0TJplFVgmafMAYa7Wc5J69gtduU7OaQvo0lsM+I0wqMfDOgSvMSt+Y46kLlvy/N462VkJvaLIBGMr0lR8KkzUcM6BG14zlq1P3vD/F+8chFOvB2Sx3kvzmLAHi1NKZaTc8rAMTHUr3GoWj9M+vZcVgaBmJ0RIk4GSv+ZOVW23/sWPeyyc5Lnt7fbdIieF6HDWeYUJ6D+NRhbCIhw+RI5xCf8ox+mXcfDJI79jeuRCYcRqvcFc6qkTFuakF4hNh5zaRY52xc7j7PWvx7BTItbtf5tcz+voopALBVG/NyFyFNXWeRLKOHs3FDuRed/K8MspS9Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rr/zCuwNGMyO99Gprs5QWO6st1ZaLobILTAiBmQFUI=;
 b=gOQUEg67TxUeLqTkxxsegHHduNEs7HuoG+7ygdoPPCQH3C5wmd33YHFVF0ahy7UIKkLITA8x3bUWjcAcWKD1UbYMwt66SovRJ4yYwJRhrtqKEEzoeme+0gqjI0LDVF1buvD4QYxfsYhhP/I7jCN3VgkmXBa1ZqbGC0lJOXQiRBw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9273.namprd11.prod.outlook.com (2603:10b6:208:573::17)
 by DM4PR11MB6432.namprd11.prod.outlook.com (2603:10b6:8:ba::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.10; Mon, 16 Nov 2026 14:24:50 +0000
Received: from IA3PR11MB9273.namprd11.prod.outlook.com
 ([fe80::31a4:58c:e3b5:43fa]) by IA3PR11MB9273.namprd11.prod.outlook.com
 ([fe80::31a4:58c:e3b5:43fa%6]) with mapi id 15.21.0615.009; Mon, 16 Nov 2026
 14:24:50 +0000
Date: Mon, 16 Nov 2026 16:24:43 +0200
From: Imre Deak <imre.deak@intel.com>
To: Frederik Schwan <frederik@tty42.de>
CC: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <regressions@lists.linux.dev>, Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [REGRESSION] i915: UHBR training fails with TB5 dock after
 1fd440de4e02; source FFE update skipped?
Message-ID: <avsSK1OE97meC40e@ideak-desk.lan>
References: <aveDNRBLx1a-9hRQ@mail.tty42.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aveDNRBLx1a-9hRQ@mail.tty42.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
X-ClientProxiedBy: GVZP280CA0012.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:272::15) To IA3PR11MB9273.namprd11.prod.outlook.com
 (2603:10b6:208:573::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9273:EE_|DM4PR11MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: 604832a0-9aaf-4912-b118-08df43ed5f72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|10067099003|56012099006|5023799004|11063799006|260925022911599003|260925021911599003|260925021311599003|261026121527099003|261026140227099003|261028144727099003|261022113327099003|261021121427099003|261022075727099003|261021123027099003|261022105027099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: jJqMpqTMJCSf1nhrqK5VqA+AgqpU/86JCI9Q/2zojtZEsL1e+zpJaVR9C6rIIUCShOCNrX5B6IXyL5ometaHZcVeuzrjbtvU6DO8qcC8kEi8Avac53Yjn+7QP+3v7T2ELT4stPfrXXkswMJkacWmrhB+IPU0tXSOp5K1WZYH22BDIp4iz81tFwdgiiKWHmion1nTiLNjthY59GftXw7bvqsuIudEq3zbMUHzMgqH5V5NfCSB4IOosOpQyD79HXIrg/nt0Gzra9svqVdCub2TvPZigp1j91v4V7/On5/cV0wuwelJ7jFCAYLpEmkaMtizP2YiCzal3hLDJQwK3lQO9YnEkuWxjcnD9Z8h6Bnf+yxosZfJMD700lt/sq5sI6Q6x2h9Zw/+g9jDd5GON2BDlFuJqodfZ3ZsIlu2IGJjvqq8J3LwQ6jl5Nlk/D9lonyKj8ejnNhmIdPcESfAxhCSOZ7D8F941lQ7MWITQJrxmvrkwaFJJPqx8aTaoLR+iONSyvUbmAvy8E9iSD+uPKCX8Tn3eupHCznazMiYeSOEF4VTuPvAB4ALdjZlMndTM/IkyfjW5QL9LJFxQbWsBL66ms4FYwczKynlYPJ/cGNnzGUDnK2fw8yt7GWT3tMRr+pVx6bJyM7Btryy8OJKUroeIw8IPk+KLzc0+Ffqbb9T/fU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9273.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(56012099006)(5023799004)(11063799006)(260925022911599003)(260925021911599003)(260925021311599003)(261026121527099003)(261026140227099003)(261028144727099003)(261022113327099003)(261021121427099003)(261022075727099003)(261021123027099003)(261022105027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tsc0JXnF33ELHLXjjsq2hbGRrDuuU7h4YIKgQ9D+uBdDh8tELQjz/8Kjeemt?=
 =?us-ascii?Q?w4RUpONzetEdpoxP8lr+nm9tVCzy+eGAnP5Y4gsdjFYaCLOOkD6PpgtHb53q?=
 =?us-ascii?Q?6iVcEMjR6iavnEcRkRX8vF55CYO7pWLH0KMos1v8HYUkhJCAE45YuB3dJSUq?=
 =?us-ascii?Q?8HZHzj9L/KyFikAuCx0Q8KjW1GFQKwh4e/mTWb+cy/BeZ+lxrEyRAXnyrNTF?=
 =?us-ascii?Q?lBbTGGgfk2zvQ4sIx98NoKjWJ14jzkhF8G+DCXgktxFwpCd34Hg93Ua0soOC?=
 =?us-ascii?Q?5C3Urx+5Jei2KxjFPi/fBsXF7xGOsycBdm+vAv47/UcWcF6eAxB/iD99p8wz?=
 =?us-ascii?Q?4KPr4+6C237hR1Gl/G8Dpo4X20RWdmlWLErlJlZe9Dh1H6V75ZY+hziUHXF/?=
 =?us-ascii?Q?eWdcrm30yihkUDIYTp3BeO0J2z8GQawsovOCHpadDXz/yVjSrO5JuYEBkftl?=
 =?us-ascii?Q?DJGfRw2fR/Fa07Tfh5bhwt9UoQMI4C76E1bx5HsL5DzT1oEwHNwXt1UC55Ed?=
 =?us-ascii?Q?BgjvDcNjPJ3xxMAMWoT+QT950tIMoj0ycpOAmvJLEqgXhLJkm28nI84q95Ry?=
 =?us-ascii?Q?jYz1b7d8qgCo2UOv/84vnmfwWli+D3MBiibVs6YID74m0qzrD5FhxvkwOOfi?=
 =?us-ascii?Q?ro5ApBFm28oBRQvnMF0JBdArKxIeotmdepxcWcy1k8sYamiGgIlMQR9JKfgk?=
 =?us-ascii?Q?lDgcgoj67vCaRv+SaC1XavdiITHVyQmLksc3q8bta9Yl3Xm3gk/b/gA0XhGZ?=
 =?us-ascii?Q?HvhVwyBJmOZYhN11EY+bmARi+3GLFj5obmaObGjLhGW524MHYAfQguBIlDVx?=
 =?us-ascii?Q?XWyUDzBlQamQS1aE6lowMUXBkLTs3EZa17SnPP3psFgNoT95Tp7vhs3HVPcG?=
 =?us-ascii?Q?AVbO/r8muGX6K+rCAElZrt1FDYJaAgtWPrvDXF7fpjUYuVJlQqQVq98o73xv?=
 =?us-ascii?Q?OHwf0MXthuFW2n65TtWbVT7c05MVKfYVK2MI9QzNEJQfCQCKlYCHIz+v+ew5?=
 =?us-ascii?Q?AV7iVoEwjs92ZrQYXUmyAS2RYvBObCcvP4thc7DVQpoDunmwJRsR0uXaJdO3?=
 =?us-ascii?Q?HO9pJ8xAHG7V9Qp2rnFt9h2RXsiFNnKBBFMPIfgHM8ktYCCrmGiSyAbKvZ87?=
 =?us-ascii?Q?PZ/RKaQkx7/arg47RRMwIHMEmVhSOEZM8XP2zl6PM/bf+50Z9wnikJeT4/aO?=
 =?us-ascii?Q?/QO7Jk3SLKhBXBdoyFa+oMTJgH6t747Xyg762L8lHQMKATbtQIuqfadz7uaV?=
 =?us-ascii?Q?siQJadhyCSeUVFnJLSQTodlphKxwMZHHu/DyV+FQjxMWRNw+rftk+nKpPAUu?=
 =?us-ascii?Q?YFjPiZf39C4F8jgBXZxRt1eeeOoLW6oBFbkU5oKyQmpc+9Rdqrbwx/KQUHRJ?=
 =?us-ascii?Q?PeMOgRekZipk4/FaNTATmP42QOpk8tG4R3ArZ706pNZCyYb4aHdOkAZTJkF4?=
 =?us-ascii?Q?h1f2N0LkDxCgZ6ytP7RHv7E8HMeo/uILeLkmcO6VEZWyhJRuTUmXyQVBwc9O?=
 =?us-ascii?Q?QlAnxyr01Bp33T0cSms/xaf6f9QqTuWbVtVNOZbzRrBbxj8RaoTsnZqAm5b+?=
 =?us-ascii?Q?L6s53pn56RZB+9GepKGZARXHCNwUiOABk4jpb55qCxjikCE1YmyLAJIOvZph?=
 =?us-ascii?Q?gKOoLGjk+xiIj2DH6swx7RYQklbEitE+pGrh8iimw2v7339gWrdQzPOW/QKh?=
 =?us-ascii?Q?NcUsVXGlIE8AyggvDR3mScktFY2OoLe70zT9hdXkqpPyo92ZTm4aq4Kxlcb5?=
 =?us-ascii?Q?V2ngVl/+gg=3D=3D?=
X-Exchange-RoutingPolicyChecked: oz0M7eFBupw7bVY1/Evhb4HmL92HxwN5e1NkI8VlLEmvWjHd4/RPalJER81ODo/aBD8MmJ6gAWvezwIAqfXd29On8HFOrJQdBm+tOjDdlZKxwpGdv2jr855KjBXotZz7/N/dLW9C8ATzS/g/drj9hZIUg5xGb/E6XavDbKAPoSfsNzJ/ob9UiZ/eHySol17TnPyvlfYWrOSCRit8ZLUyiMYFnpa9kaF+VXbCs4HWwE4DaV981/U8lwBMU+rnYaEaSa9fazLwUKALDws7Is4DbbQM0CRBrdatSuo7fFKnhzN6quCpW/ysymmC+vAovVNqaNEKveOc1ajFB4w7LGrRvg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 604832a0-9aaf-4912-b118-08df43ed5f72
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9273.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 14:24:50.1355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3lIvuHrmpImYmpAPg32PfluqynDwWob4F7LIsxX573t46/cloB7my4K0jlETOQRoT1CLZdmcnX3ruNwKnYqV2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6432
X-OriginatorOrg: intel.com
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: imre.deak@intel.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 13, 2026 at 11:08:15PM +0100, Frederik Schwan wrote:
> Hi everyone,
> I just upgraded my system to 7.3.x and found a regression with my notebook/dock setup.
> 3x 4k displays are hooked to the dock, 2 by DP and one through USB-C (I guess that DP-alt mode then).
> 
> Until 7.2 all displays worked. With 7.3 all displays work until kernel switches from fbdev (?) after
> which the 2 DP displays have no signal anymore but the USB-C one still works.
> 
> Bisect:
> 
> # bad: [c03c1a14507dfaf8b856c2608f9ac216021fc222] Linux 7.3
> # good: [8d3ae59288f1e7d58d76558a6ee96d533bc5019f] Linux 7.2
> git bisect start 'v7.3' 'v7.2' '--' 'drivers/gpu/drm/i915/display' 'drivers/gpu/drm/display'
> # good: [bbf51a67d1fe895f3d27402d2560259a619b6dba] drm/i915/dp_link_caps: Use max common lane count from link_caps
> git bisect good bbf51a67d1fe895f3d27402d2560259a619b6dba
> # good: [d6a1bc7c9b4ce71674a633242251d8a804ced82d] drm/i915: Throw away the BIOS fb if has the wrong depth/bpp
> git bisect good d6a1bc7c9b4ce71674a633242251d8a804ced82d
> # bad: [f0cabcc880aba3f05ca59d735f6d166b7fceca80] drm/i915/fbc: No surface size restrictions from LNL onwards
> git bisect bad f0cabcc880aba3f05ca59d735f6d166b7fceca80
> # good: [b0b6d44646dc7750df4f052d17688fb7e7569a74] drm/dp_tunnel: Add UHBR tunneling support
> git bisect good b0b6d44646dc7750df4f052d17688fb7e7569a74
> # bad: [662560bad9be29c3e1a2668806392d2ed9a743d6] drm/i915/bw: Fix spelling mistake "threshod" -> "threshold"
> git bisect bad 662560bad9be29c3e1a2668806392d2ed9a743d6
> # good: [47fff2b1749e9ba5dfab7528960555cc865360b5] drm/i915/dp: Disable UHBR link configs with 1/2 lanes
> git bisect good 47fff2b1749e9ba5dfab7528960555cc865360b5
> # bad: [8b9bc7786adef4e2df3a23293c0682efac6dcc83] drm/i915/dram: Interpret 0xF populated-channel count as 16
> git bisect bad 8b9bc7786adef4e2df3a23293c0682efac6dcc83
> # bad: [1fd440de4e02efab97874bbda0a4daf59d228fa3] drm/i915/dp_tunnel: Add UHBR tunneling support
> git bisect bad 1fd440de4e02efab97874bbda0a4daf59d228fa3
> # first 'bad' commit: [1fd440de4e02efab97874bbda0a4daf59d228fa3] drm/i915/dp_tunnel: Add UHBR tunneling support
> 
> I collected logs as well with `drm.debug=0x10e log_buf_len=32M thunderbolt.dyndbg=+p`:
> 
> good: v7.2-rc1-263-gb0b6d44646dc.log
> bad: v7.2-rc1-268-g1fd440de4e02.log
> patched: patched.log
> 
> #regzbot introduced: 1fd440de4e02efab97874bbda0a4daf59d228fa3
> #regzbot title: i915: UHBR training fails through TB5 dock when source FFE updates are skipped
> 
> I was desperate and thought I'd give it a quick try with help of Codex which ended in a rabbit whole of DP protocol investigation for me :).
> We came up with a patch which I tested successfully.
> 
> I've attached the patch and the "report" codex created in case you're interested.
> 
> Best regards,
> Frederik

> From: Frederik Schwan <frederik@tty42.de>
> Date: Fri, 13 Nov 2026 22:57:12 +0100
> Subject: [PATCH] drm/i915/dp: Update source FFE presets during UHBR training with LTTPRs
> 
> UHBR link training uses intra-hop AUX replies at the DPRX address even
> when LTTPRs are present. However, intel_dp_set_signal_levels() only
> programs the source transmitter when intel_dp_phy_is_downstream_of_source()
> identifies the receiver being trained as directly downstream of it.
> With LTTPRs present, this check rejects DP_PHY_DPRX.
> 
> As a result, UHBR training updates the requested FFE presets in the DPCD
> training set but does not apply them to the source PHY. This causes
> UHBR20 and UHBR10 training failures on a Meteor Lake system connected to
> a ThinkPad Thunderbolt 5 Smart Dock 7500. Enabling UHBR tunneling exposed
> the existing assumption in the source signal-level update path.
> 
> Always update the source signal levels during UHBR training. Preserve
> the per-PHY check for 8b/10b training, which trains downstream receivers
> individually.

The fix is correct, however the above explanation for the root cause and
fix isn't clear. The actual one is:

128b132b links (i.e. links used for UHBR modes) are link trained in
LTTPR-transparent-mode, even in the cases where LTTPRs are detected on
the link: In transparent mode the DPRX PHY is link trained directly,
without link training the LTTPR PHYs first separately and so the source
must set the FFE parameters during the - single - DPRX link training
phase.

During a non-transparent link training (i.e. on 8b10b links), the link
training signal parameters (i.e. vswing/pre-emph) are only set for the
first LTTPR PHY, directly downstream of the source, if LTTPRs are
detected on the link. Such LTTPR PHY link training phases are indicated
by phy being set to one of the DP_PHY_LTTPRx values as opposed to
DP_PHY_DPRX. At the moment, according to the above setting the source's
link training signal parameters are skipped whenever a PHY other than
DP_PHY_LTTPR1 is being link trained on a link with LTTPRs detected on
it. This is not correct during a transparent link training (i.e. on
128b132b links), when the port is in the legacy or DP-alt mode (in the
TBT-alt mode the Thunderbolt subsytem owns and programs the source's
PHY).

Please update the commit message according to the above lines.

> With this change, the affected system completes four-lane UHBR20
> training, including channel equalization, interlane alignment and CDS.
> 
> Fixes: 1fd440de4e02 ("drm/i915/dp_tunnel: Add UHBR tunneling support")

The change is not limited to tunnel scenarios, rather to any case where
a 128b132b link (i.e. for any UHBR mode) is used in a legacy or DP-alt
TypeC port mode (i.e. not TBT-alt port mode), with LTTPRs detected on
the link. So the above Fixes: line is not correct, instead the patch
should be backported to a kernel version in which the 128b/132b (i.e.
UHBR support) in general was enabled.

> Signed-off-by: Frederik Schwan <freswa@archlinux.org>
> Assisted-by: Codex:gpt-6
> ---
> The analysis and patch preparation were assisted by OpenAI Codex. The
> reporter performed the bisect and hardware tests.
> 
>  drivers/gpu/drm/i915/display/intel_dp_link_training.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_link_training.c b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
> index cb92cff90614..92b8a8a1af3d 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_link_training.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
> @@ -1019,7 +1019,13 @@ void intel_dp_set_signal_levels(struct intel_dp *intel_dp,
>  		       TRAIN_SET_PREEMPH_ARGS(intel_dp->train_set));
>  	}
>  
> -	if (intel_dp_phy_is_downstream_of_source(intel_dp, dp_phy))
> +	/*
> +	 * UHBR training uses intra-hop AUX replies at the DPRX address, even
> +	 * with LTTPRs present. The requested FFE presets apply to the source
> +	 * transmitter, unlike 8b/10b training of individual downstream PHYs.
> +	 */
> +	if (intel_dp_is_uhbr(crtc_state) ||
> +	    intel_dp_phy_is_downstream_of_source(intel_dp, dp_phy))

Introducing an is_transparent_mode() helper and adding that to
intel_dp_phy_is_downstream_of_source() would be better probably, but
that's a bigger change and should be left out from this fix.

intel_dp_get_lane_adjust_tx_ffe_preset() should be fixed similarly to
the above.

>  		encoder->set_signal_levels(encoder, crtc_state);
>  }
>  

> i915 UHBR / Thunderbolt 5 regression investigation
> ================================================
> 
> Provenance
> ----------
> Frederik Schwan performed the bisect, built and booted the test kernels,
> and supplied the hardware logs. OpenAI Codex, an AI coding assistant,
> analyzed those logs and the kernel source, identified the skipped source
> PHY callback, prepared the candidate fix, and ran the source-level checks.
> This report was prepared by Codex. Its interpretation is offered for
> maintainer review; the hardware results below come from the supplied logs.
> 
> Setup and regression boundary
> -----------------------------
> Host: Lenovo 21Q8CTO1WW, BIOS N4EET24W (1.10), 2026-06-29.
> GPU: Intel Meteor Lake, i915, PCI ID 8086:7d51.
> Dock: ThinkPad Thunderbolt 5 Smart Dock 7500, connected over Thunderbolt 5.
> Display topology: dock MST hub feeding two DisplayPort 1.x displays.
> Affected upstream display link: DP-4 / DDI TC3, four lanes, one LTTPR.
> The GPU-side state dump shows tbt_mode: no: the physical source PHY is
> in use, rather than the integrated TBT alternate-mode PHY path.
> 
> The bisect began with v7.2 good and v7.3 bad, restricted to
>   drivers/gpu/drm/i915/display
>   drivers/gpu/drm/display
> 
> First bad:
>   1fd440de4e02efab97874bbda0a4daf59d228fa3
>   drm/i915/dp_tunnel: Add UHBR tunneling support
> 
> Immediate parent tested good:
>   47fff2b1749e9ba5dfab7528960555cc865360b5
>   drm/i915/dp: Disable UHBR link configs with 1/2 lanes
> 
> The final patched hardware capture identifies its kernel as
> 7.3.4-arch1-2, built 2026-11-13 20:51:44 UTC. NVIDIA modules are also
> loaded; the affected link and training messages in this report are i915.
> 
> Failure and unsuccessful experiments
> ------------------------------------
> Before the source-FFE fix, four-lane UHBR20 training fails, including a
> retry, followed by UHBR10 failure. Representative six-byte link status:
>   UHBR20: 33 33 00 08 ee ee
>   UHBR10: 33 33 00 08 66 66
> 
> The adjustment bytes request FFE preset 14 or 6, respectively, on all
> four lanes. Lane EQ bits are set but alignment is absent. The sink-status
> bit 0x08 is DP_INTRA_HOP_AUX_REPLY_INDICATION; these are intra-hop replies,
> not proof that the entire downstream path has finished training.
> 
> Experiment 1 (dmesg.log): remove the legacy alignment-bit requirement
> from the UHBR lane-EQ helper, preserving it for active-link monitoring.
> Result: training advances to "Lane channel eq done" but then fails with
> "Interlane align timeout". This did not fix the problem.
> 
> Experiment 2 (dmesg.log.1): restore the original helper and repeat the
> 0x2215 capability read after LTTPR initialization, logging tunnel caps.
> Result: coding=01 rates=03 before initialization, after initialization,
> and after the extra read; 0x2215 returns 00. UHBR20 and UHBR10 still fail
> with "Max loop count reached". This did not fix the problem either.
> 
> Failed runs fall back to HBR3. Although HBR3 training passes, FEC-enable
> polling subsequently times out with status 0x04 or 0x00. The logs show
> 8b/10b coding selected and intra-hop mode clearing; there is no evidence
> that the driver simply leaves UHBR coding or intra-hop mode enabled.
> The cause of the fallback FEC failure has not been established.
> 
> Source-level finding
> --------------------
> File: drivers/gpu/drm/i915/display/intel_dp_link_training.c
> Function: intel_dp_set_signal_levels()
> 
> The existing code calls encoder->set_signal_levels() only if
> intel_dp_phy_is_downstream_of_source(intel_dp, dp_phy) returns true.
> That helper accepts a link without repeaters or the source-adjacent
> LTTPR, DP_PHY_LTTPR(lttpr_count - 1).
> 
> UHBR lane EQ calls the signal-level update path with DP_PHY_DPRX, even
> when repeaters are present, because it uses intra-hop AUX replies.
> Consequently, with one or more LTTPRs, the existing guard skips the
> source transmitter callback. The debug print precedes the guard, so
> "TX FFE presets: 14/14/14/14" does not establish that those presets
> were programmed into the GPU PHY. The AUX training-set writes still run.
> 
> For this platform, the callback leads to intel_cx0_phy_set_signal_levels().
> The lane level is derived from train_set through intel_ddi_dp_level(),
> and the corresponding transmitter settings are written to the PHY.
> The integrated TBT alternate-mode path has its own early return there;
> that is not the path shown by this system's PHY state.
> 
> Candidate fix
> -------------
> Allow the callback whenever intel_dp_is_uhbr(crtc_state) is true, retaining
> the existing per-PHY guard for 8b/10b:
> 
>   if (intel_dp_is_uhbr(crtc_state) ||
>       intel_dp_phy_is_downstream_of_source(intel_dp, dp_phy))
>           encoder->set_signal_levels(encoder, crtc_state);
> 
> Neither unsuccessful experimental change is included in this fix.
> The bisected commit enabled a path that exposes an older assumption;
> it did not introduce the original guard itself.
> 
> Hardware evidence with the fix (dmesg.log.2)
> -------------------------------------------
> First successful sequence on DP-4:
>   20.224632  Lane channel eq done
>   20.271570  Interlane align done
>   20.297496  CDS interlane align done
>   20.297680  128b/132b Link Training passed at link rate = 2000000,
>              lane count = 4
> 
> Second successful sequence on DP-4:
>   33.891635  Lane channel eq done
>   33.934586  Interlane align done
>   33.956537  CDS interlane align done
>   33.956747  128b/132b Link Training passed at link rate = 2000000,
>              lane count = 4
> 
> The first sequence reaches status 77 77 8d 00 11 11 at CDS completion.
> There are no UHBR training failures, fallback attempts, or FEC-enable
> timeouts in this capture. Earlier Thunderbolt DPRX-read timeouts and
> unrelated NVIDIA messages do appear; this is not an error-free system log.
> 
> The result strongly supports the skipped source FFE update as the cause
> of the reported UHBR training failure. It also demonstrates that the
> DP1.x monitors do not inherently prevent this upstream link training at
> UHBR20. It does not establish long-term display stability or validate
> UHBR-to-HBR3 fallback recovery, which was not exercised in this run.
> 
> Validation performed by Codex
> -----------------------------
> - Built intel_dp_link_training.o using a configuration copied from the
>   running kernel and processed by olddefconfig.
> - git diff --check and scripts/checkpatch.pl passed for the code change.
> - A standalone harness extracted the source functions and mocked the
>   encoder callback. Before the change, all UHBR cases with 1-8 repeaters
>   missed the callback. Afterward, those cases passed, and tested 8b/10b
>   per-PHY callback behavior was unchanged. This is not a KUnit or hardware
>   test and does not validate electrical signal quality.
> - The code patch applies cleanly to the v7.3 version of the source file.
> 
> Supporting material
> -------------------
> Primary attachments:
>   bisect.log
>   i915-uhbr-source-ffe.patch
>   v7.2-rc1-263-gb0b6d44646dc.log (known-good capture)
>   v7.2-rc1-268-g1fd440de4e02.log (first-bad capture)
>   patched.log (successful final candidate on 7.3.4)
> 
> Optional experimental captures:
>   dmesg.log (lane-EQ helper experiment)
>   dmesg.log.1 (0x2215 refresh experiment)
> 
> Logging parameters:
>   drm.debug=0x10e log_buf_len=32M thunderbolt.dyndbg=+p
> 
> Retain full logs, preferably compressed, so reviewers can inspect the
> capability reads, AUX transactions, topology and ordering. The source
> filenames from the bisect should be interpreted together with the actual
> kernel banners and bisect.log.






