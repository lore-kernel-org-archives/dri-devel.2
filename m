Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88302606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QAs9//dr;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=lO55MGsI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0442A10F608;
	Tue, 24 Nov 2026 15:23:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F31E410F608
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 15:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795533773; x=1827069773;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=iAKfMyWQRgJlHeqnCzrrbtB4KlK+XkarrZRkmf5T/1w=;
 b=QAs9//drN9o2/MN90RbUKOpRbE4lfv2tq04R4FuhIyNChwTUj1QGwREU
 wsRRXh0lIjC8ybML7RN5NHdPHwj3aR00y/lLqWBqVpBwqnuohUB4kX+XR
 PGHKOmYleBiGkXD5v3vfRmy/5tfbo978OZCfNJfLccwAsxIjEthRZSEAn
 ysSglwHvV39CVzPJya8tdLBx9YGZXmmCAfMreNCKbN+i94qCFDZHImmyX
 +zRl0MObzNAaAQjIopNWu+Wt+5rraqeKX4jpOrSLynNhF+2eJ7WUANOxW
 p6oKnMGeS8PwJCvQOXe3wzHjgYf5VxQsAI2msR4MmEpN2hatQCnx3iovz A==;
X-CSE-ConnectionGUID: y8TI0Z/cR9KahCGRMM+0wg==
X-CSE-MsgGUID: 86NZdBskQMeA7Y+5GLGUoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4430309"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4430309"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 07:22:24 -0800
X-CSE-ConnectionGUID: xeYaUTJATNqbkBpocwRKMg==
X-CSE-MsgGUID: 72WPuRyaRYKjDxW+vV5e8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; d="scan'208";a="11793507"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 07:22:24 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 07:22:23 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 07:22:23 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.9) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 07:22:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j8f/nmLchX9nbt2u0HS/M6+WwCy6i/jeDDdtMqyVUYmkFp17Nx+3FJisYQXaGnJJZBPi7csxC57EK1AWnYMr+L2fh6RzPcYPN+xtQ4ew0kEVcfI834b1o1rfP7+3A0zWgxAd1nnVHSB+vtVWtHMeOizTRz2uzmhloI/1JVaRx8a7kr1cjdKytfHPYazy6f3ZRERDYPwqgvczqrMhn472U3XYUu4tIIWpH7Epy5ZDufkf12Vx6N2Qp3HgvtqFsI4aIM8ewJx8EkIUA62bleam1hTfYG7yuR1g1xYQ+pG6W9T496+n7nev0ZmbtWF5MsBsO8bsE9IoRHdqITZ2XyIJGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVVzP5E2yVQuErcNs8bmGQYPHrFd/KA2wOgthuMEoLw=;
 b=O7nHhPsHcmzTdpR3pysD8U8oxPBBiqye4hFBPHhNeARp7Q2hbeSrv5tKEM2R2lU89UbM7z5gzGoBaen5sB2uMnTLUyj+3YbbrpHOhxroRIDJ8c7tuHKzbnp+rkC3Rb12l5jGIvJM0enRuGDWadP0nSQIzo8eU3KMkHDUTFpdTJdzgWR4j+51hMHSoT+x3zJvASjmXmrqE4FVg+Att/Hq7gCjf0FvTVN/OlPfsa9KJYuFfRVhyEXy2b+ccse4AtoGWoqO0W/4Y3dQtskSs+XC1LYlxpQoC+lkpaSORx+AHeEyKDLH2mo/uOYiXXYyJmPfnLMQOtDEZhEVwEp1vSm8Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVVzP5E2yVQuErcNs8bmGQYPHrFd/KA2wOgthuMEoLw=;
 b=lO55MGsIdb/aqidMlHCdCVj6D4c2glwSzMUjHo9douu/o68E3XF7zas5ZTGyl1D5FNhs8GtOS/VvcBZ06c60OR4OLGKlZW+gCtg7NtGKooLa1SSUV6guFhB7VreYaGUIKX8ybErXTLjOX388lzu6963Bz5NpC6ZY/fvkpYbTGD4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 DS7PR11MB8825.namprd11.prod.outlook.com (2603:10b6:8:255::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.13; Tue, 24 Nov 2026 15:22:07 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899%3]) with mapi id 15.21.0639.011; Tue, 24 Nov 2026
 15:22:07 +0000
Date: Tue, 24 Nov 2026 10:22:03 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
CC: <dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>,
 <riana.tauro@intel.com>, <aravind.iddamsetty@linux.intel.com>,
 <raag.jadav@intel.com>, <simona.vetter@ffwll.ch>, <airlied@gmail.com>,
 <kuba@kernel.org>, <ogabbay@kernel.org>, <lizhi.hou@amd.com>,
 <karol.wachowski@linux.intel.com>, <jeff.hugo@oss.qualcomm.com>,
 <carl.vanderlip@oss.qualcomm.com>, <troy.hanson@oss.qualcomm.com>,
 <youssef.abdulrahman@oss.qualcomm.com>
Subject: Re: [PATCH v4 4/4] accel/qaic: Add callbacks for DRM RAS netlink
 telemetry
Message-ID: <awWrm4Q543mvU318@intel.com>
References: <20261117233442.407877-1-zachary.mckevitt@oss.qualcomm.com>
 <20261117233442.407877-5-zachary.mckevitt@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117233442.407877-5-zachary.mckevitt@oss.qualcomm.com>
X-ClientProxiedBy: SJ0PR03CA0135.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::20) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|DS7PR11MB8825:EE_
X-MS-Office365-Filtering-Correlation-Id: 9032a157-64b4-4948-0417-08df4a3eb3cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|7416014|261026140227099003|261102123227099003|261026121527099003|261022115727099003|261022075727099003|261022105027099003|261028144727099003|261021123027099003|261021121427099003|11063799006|4143699003|56012099006|10067099003|261009223027099003|18002099003|6133799003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 2OcdmjaBiZniwokw66q45LDFLc4geZLe5zNcbqbiAiI2ckpIyUYrDzWwotb3eZNJNdnYy5HX5GtU4eAkP+L6na5dgaLR3xbe6YVE72J7Qq+swphXvIFu0g7DrzMdzkSScxVGNU6XZ148eKSn/ceJE0gAwN+bYX14BM/NgONeiyL4AhBQBAM0vXb6p21pwsixoQP6iAOkpPxXcZL7mrTPuRB9tZTkoL9wZueRTRlZEzYcdM+nGwkvb5ky8r2X6WONAUtHacoTZjcUBlf3H5bOm88tqnUcKgT3shLD5NZx9GnyfManTQJD1F6TKIQGPnOQRYfeJYWNvsQKx7K5xN1hOh3yFV8UNQvg2YaXOw0ahT2zzGPvZJ/7o6Yv6WamvY1aVQcr2d25Io3yCkNnXSZWahegalnK6CquWZo22CchmP6wPVDGLTs/Zi/6X/XZK2eVeR1OKN/3gZ9tqvO0QEzIAUGedghmAFhlWUlPhOoJNkJ5LiQPP7WBgmyeKUYYHWjtnl6BoTWN1zKg3VKOrNvm1yfdDklk2OR2doDfrRqtYpkt9G6jciwlIJ60rFYv7HAwwVsXPdszl/+uFFXIwYpTcTXp34/2zyYJJs4ufRiASAYf7C8MUP31Df27aAb1u43aI9EBglNAEdrWszh2wu9Ybpgy5NQPFmGZqv3ciV/HKVo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB5990.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(261026140227099003)(261102123227099003)(261026121527099003)(261022115727099003)(261022075727099003)(261022105027099003)(261028144727099003)(261021123027099003)(261021121427099003)(11063799006)(4143699003)(56012099006)(10067099003)(261009223027099003)(18002099003)(6133799003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VlXuFmKWgvVb6cgF+K6vivq60ztP8c+8040uaG5LMjiiktaHGYSHtf41i48o?=
 =?us-ascii?Q?bahd8rZ1fh6QRUz/XOsDO16eHKWOZfqWdrOZQDHMtM48WrZb9Ur6H5pl5YPi?=
 =?us-ascii?Q?wmlM5yPcoWG8blh2GqwbTZqlUDcebPhKzftU3YvnLhQANJHnV6V0e1Ttq6yJ?=
 =?us-ascii?Q?0JVN0UPJaFAZTryUhwtkQCcfQaB2nBx5gSfbRZlKWmYrRkLY8ZYgDO8xinYg?=
 =?us-ascii?Q?v5NG8OB/+YnpYzGcmHMpfiBfeoS4ERLGQKDFzh3TV/nQNA7n0oqjKegPilC7?=
 =?us-ascii?Q?cMmTwTKorP5T3gd5UY2x0sgHB9l5kFGkfqvQjLy3DlkrwnzJWAqLpP1jlRWL?=
 =?us-ascii?Q?YPxITpztCwOfO/3ZN4wRxQCnT4nOqLvXZrwFkth+vTf1o7qhwrnH2LS9isti?=
 =?us-ascii?Q?/V4teKL407Jl0I7krXXqVeKn3WTHabWg4gAg3omC/Cyk8tF+EGmJsPHIDeXD?=
 =?us-ascii?Q?+MrDe5zX8rbJ6dzjlpjd8P3qe4Gly2bZz0HHfImxpW39ryBOGNvdb0kJEZo8?=
 =?us-ascii?Q?O2nC/Nt28rA6Lw9L3FPqm2wpRoDPUuf6i3vzAUk2dDX6o+HIDInWLz6hUkBU?=
 =?us-ascii?Q?OGkq8egiKI/BezvBL+g08rvdE1baT8eWA/GBUOARC+OWxvo9D0AGgskKI19+?=
 =?us-ascii?Q?pfbd/qQhgptLML4RZ31RtrWXjJv2Z1ZbMqqPoF0ytjJSo9KRQpoGQe8F5HP6?=
 =?us-ascii?Q?2nHJQb7nBm4LtuKu7yDIRc7j6widNR5Jr4F1cDpzmcHrqTrXF0m3hpmsOxo9?=
 =?us-ascii?Q?FgpAurf1XYwLMJNJJtq+oHWsrSYMxKMwvSbtc5TnTemPzxMJI9Ggm6a4FSHS?=
 =?us-ascii?Q?SARnWr/gOAnSxPKMaj0T19LGVEHPDqaoRKhWAOVwznUZnZHEFTRvn/J8utA1?=
 =?us-ascii?Q?jDXMP3nPA7J19syyPvzyAsdztV3CJMzhZyCuiGGx8TwSjUX6UcEHYrfRRO0u?=
 =?us-ascii?Q?7b6VSC4vWxvk8nMJl1JF1QYqDcSJK49VQ3qm2j++CH4fiKRVNzzwY/qujtcd?=
 =?us-ascii?Q?L3dznGBAo5M8bQ7wpscHj8t7JlUyLafBFAaywSJJQAlhJze+zX9+w6ThfJDG?=
 =?us-ascii?Q?vUhGG3oAuMtiHOeNlgLy1xm0oCQ2QL75r70N72fSf3VjJzypvx64mvHSQaa9?=
 =?us-ascii?Q?b4S8Id/XFaBFzK1u/ea2vhT6vspAFMYPTZyV4dIllm/1pfVrYduhKa6ZwhUS?=
 =?us-ascii?Q?pH10RtQEYdqRP86qV688VyuxRm3yb80YHlHQPA9snVeAdSHvlAxjko/bMrU9?=
 =?us-ascii?Q?ITWccMnNVFeroTlFyfE4+gRiv6+QKG6XT2rW5Ie1kbpZ2tSutnct5QLx4aqQ?=
 =?us-ascii?Q?+DMY8frwv+YDi4DkVOdLSccZmloojeaEpPkBL31LIvigjdJJAAGBqobEt6+P?=
 =?us-ascii?Q?cCRwI2u5wQteAxtlizGOe5rqVK2uZvWGeKeez/PukJt/PciWBNxVuygVYSk+?=
 =?us-ascii?Q?3kum1QixYOx9Jdo9Vq5xFsM8QJaZUYMrDHzJo2APcvyV+/+wQ34cJJc/FD3o?=
 =?us-ascii?Q?uMepDEFOGypxpS7/FDpQ0NKawwlGpVgFXz2sswdMLfInNvo5Tm2y0dYxHbTY?=
 =?us-ascii?Q?9HEcy3FaTrFo1SQBp5EfXkGZvhkbOwMZwymlrvB7j9lUkpGJBKW2Y4eNJbps?=
 =?us-ascii?Q?zqWHTjaGdHvKM7djXk7OAOkpVw+10FcD5cmv4ANfMCUdNW3afFEnUfUDdlKP?=
 =?us-ascii?Q?sUWlEBL2nek57zp2jZZZNkUjPheMw88fupRrmLjwU7vkHgbjWVvCym4G1WAU?=
 =?us-ascii?Q?ygaVoXxgXA=3D=3D?=
X-Exchange-RoutingPolicyChecked: TsKkYUyJNPBUN1jJrHvFWIHqTlAnTCbQ2eACvl24BtutMw2lbL/wzc5Bl99L08AQ43lxPK0RiaYr8PM90Tc1c74Ss6MeemoY+cdZn+VBbMMka2vgJYIECebGA6oGlKeFuchoKePDtpHvTZewGo0eYVkJQOcg7Cu3vMgB9AqLJE36xujA8ehfyAgZBNuLdWn2zWtiu4aPaKioEOTgGmrT/y30WyU27XFuuoUx3IXUw6QdjXA7oFYERdoO21k84mLGfZTeKaV6WOqHDe9UWuZ9Mvvh9eycWef26iLG+kcOjQQLcNJ/kUQ2PevM0HylCvlWH62hOoNWubtOHijf+cJmOw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9032a157-64b4-4948-0417-08df4a3eb3cf
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 15:22:07.8114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8q5tYwuNBD09qlR3gay2fnlVmcFjDIimDcXZMzSU7XrZZa9iUEU9JcB/H3WKi66vbYiugT43zPtFwpjNK/TOZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8825
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 03:34:34PM -0800, Zack McKevitt wrote:
> Use the DRM RAS netlink infrastructure to perform device telemetry.
> During MHI probe, create a DRM RAS node with DRM_RAS_NODE_TYPE_TELEMETRY
> type and add callbacks to telemetry_request for read and write operations.
> 
> Co-developed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
> Signed-off-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
> Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
> Signed-off-by: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>

Can I take this and the rest through drm-misc-next?

I have another series that will conflict...

> ---
>  drivers/accel/qaic/Kconfig          |   1 +
>  drivers/accel/qaic/Makefile         |   1 +
>  drivers/accel/qaic/qaic.h           |  19 +
>  drivers/accel/qaic/qaic_drv.c       |  15 +
>  drivers/accel/qaic/qaic_telemetry.c | 563 ++++++++++++++++++++++++++++
>  drivers/accel/qaic/qaic_telemetry.h |  14 +
>  include/uapi/drm/qaic_accel.h       |  28 ++
>  7 files changed, 641 insertions(+)
>  create mode 100644 drivers/accel/qaic/qaic_telemetry.c
>  create mode 100644 drivers/accel/qaic/qaic_telemetry.h
> 
> diff --git a/drivers/accel/qaic/Kconfig b/drivers/accel/qaic/Kconfig
> index 116e42d152ca..6a07db0c402e 100644
> --- a/drivers/accel/qaic/Kconfig
> +++ b/drivers/accel/qaic/Kconfig
> @@ -8,6 +8,7 @@ config DRM_ACCEL_QAIC
>  	depends on DRM_ACCEL
>  	depends on PCI && HAS_IOMEM
>  	depends on MHI_BUS
> +	depends on DRM_RAS
>  	select CRC32
>  	select WANT_DEV_COREDUMP
>  	help
> diff --git a/drivers/accel/qaic/Makefile b/drivers/accel/qaic/Makefile
> index 71f727b74da3..b2bbe9b3e077 100644
> --- a/drivers/accel/qaic/Makefile
> +++ b/drivers/accel/qaic/Makefile
> @@ -13,6 +13,7 @@ qaic-y := \
>  	qaic_ras.o \
>  	qaic_ssr.o \
>  	qaic_sysfs.o \
> +	qaic_telemetry.o \
>  	qaic_timesync.o \
>  	sahara.o
>  
> diff --git a/drivers/accel/qaic/qaic.h b/drivers/accel/qaic/qaic.h
> index 889fa51da7da..fa19c758f504 100644
> --- a/drivers/accel/qaic/qaic.h
> +++ b/drivers/accel/qaic/qaic.h
> @@ -17,6 +17,7 @@
>  #include <linux/workqueue.h>
>  #include <drm/drm_device.h>
>  #include <drm/drm_gem.h>
> +#include <drm/drm_ras.h>
>  
>  #define QAIC_DBC_BASE		SZ_128K
>  #define QAIC_DBC_SIZE		SZ_4K
> @@ -204,6 +205,24 @@ struct qaic_device {
>  	void			*ssr_mhi_buf;
>  	/* DBC which is under SSR. Sentinel U32_MAX would mean that no SSR in progress */
>  	u32			ssr_dbc;
> +	/* MHI telemetry channel device */
> +	struct mhi_device	*tele_ch;
> +	/* Head in list of requests queued in MHI telemetry device */
> +	struct list_head	tele_xfer_list;
> +	/* Req. ID of request that will be queued next in MHI telemetry device */
> +	u32			tele_next_seq_num;
> +	/* Synchronizes MHI telemetry device transactions and its xfer list */
> +	struct mutex		tele_mutex;
> +	/*
> +	 * TRUE: A tx MHI transaction has failed and a rx buffer is still queued
> +	 * in telemetry device. Such a buffer is considered lost rx buffer
> +	 * FALSE: No rx buffer is lost in telemetry device
> +	 */
> +	bool			tele_lost_buf;
> +	/* Work queue for tasks related to MHI telemetry device */
> +	struct workqueue_struct	*tele_wq;
> +	/* Netlink telemetry node */
> +	struct drm_ras_node *ras_node;
>  	/* Array of DBC struct of this device */
>  	struct dma_bridge_chan	dbc[] __counted_by(num_dbc);
>  };
> diff --git a/drivers/accel/qaic/qaic_drv.c b/drivers/accel/qaic/qaic_drv.c
> index 90c0d31e414a..6d185151a0a6 100644
> --- a/drivers/accel/qaic/qaic_drv.c
> +++ b/drivers/accel/qaic/qaic_drv.c
> @@ -32,6 +32,7 @@
>  #include "qaic_debugfs.h"
>  #include "qaic_ras.h"
>  #include "qaic_ssr.h"
> +#include "qaic_telemetry.h"
>  #include "qaic_timesync.h"
>  #include "sahara.h"
>  
> @@ -389,6 +390,7 @@ static void qaic_notify_reset(struct qaic_device *qdev)
>  	qdev->dev_state = QAIC_OFFLINE;
>  	/* wake up any waiters to avoid waiting for timeouts at sync */
>  	wake_all_cntl(qdev);
> +	wake_all_telemetry(qdev);
>  	for (i = 0; i < qdev->num_dbc; ++i)
>  		wakeup_dbc(qdev, i);
>  	synchronize_srcu(&qdev->dev_lock);
> @@ -439,6 +441,9 @@ static struct qaic_device *create_qdev(struct pci_dev *pdev,
>  	if (ret)
>  		return NULL;
>  	ret = drmm_mutex_init(drm, &qdev->bootlog_mutex);
> +	if (ret)
> +		return NULL;
> +	ret = drmm_mutex_init(drm, &qdev->tele_mutex);
>  	if (ret)
>  		return NULL;
>  
> @@ -451,6 +456,9 @@ static struct qaic_device *create_qdev(struct pci_dev *pdev,
>  	qdev->ssr_wq = qaicm_wq_init(drm, "qaic_ssr");
>  	if (IS_ERR(qdev->ssr_wq))
>  		return NULL;
> +	qdev->tele_wq = qaicm_wq_init(drm, "qaic_tele");
> +	if (IS_ERR(qdev->tele_wq))
> +		return NULL;
>  
>  	ret = qaicm_srcu_init(drm, &qdev->dev_lock);
>  	if (ret)
> @@ -466,6 +474,7 @@ static struct qaic_device *create_qdev(struct pci_dev *pdev,
>  
>  	INIT_LIST_HEAD(&qdev->cntl_xfer_list);
>  	INIT_LIST_HEAD(&qdev->bootlog);
> +	INIT_LIST_HEAD(&qdev->tele_xfer_list);
>  	INIT_LIST_HEAD(&qddev->users);
>  
>  	for (i = 0; i < qdev->num_dbc; ++i) {
> @@ -854,12 +863,17 @@ static int __init qaic_init(void)
>  	ret = qaic_ras_register();
>  	if (ret)
>  		pr_debug("qaic: qaic_ras_register failed %d\n", ret);
> +
>  	ret = qaic_ssr_register();
>  	if (ret) {
>  		pr_debug("qaic: qaic_ssr_register failed %d\n", ret);
>  		goto free_bootlog;
>  	}
>  
> +	ret = qaic_telemetry_register();
> +	if (ret)
> +		pr_debug("qaic: qaic_telemetry_register failed %d\n", ret);
> +
>  	return 0;
>  
>  free_bootlog:
> @@ -889,6 +903,7 @@ static void __exit qaic_exit(void)
>  	 * reinitializing the link_up state after the cleanup is done.
>  	 */
>  	link_up = true;
> +	qaic_telemetry_unregister();
>  	qaic_ssr_unregister();
>  	qaic_ras_unregister();
>  	qaic_bootlog_unregister();
> diff --git a/drivers/accel/qaic/qaic_telemetry.c b/drivers/accel/qaic/qaic_telemetry.c
> new file mode 100644
> index 000000000000..bcf9842f4ec9
> --- /dev/null
> +++ b/drivers/accel/qaic/qaic_telemetry.c
> @@ -0,0 +1,563 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/* Copyright (c) 2020-2021, The Linux Foundation. All rights reserved. */
> +/* Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries. */
> +
> +#include <asm/byteorder.h>
> +#include <drm/drm_file.h>
> +#include <drm/drm_ras.h>
> +#include <linux/completion.h>
> +#include <linux/fs.h>
> +#include <linux/fs_struct.h>
> +#include <linux/kernel.h>
> +#include <linux/kref.h>
> +#include <linux/limits.h>
> +#include <linux/list.h>
> +#include <linux/mhi.h>
> +#include <linux/mutex.h>
> +#include <linux/namei.h>
> +#include <linux/path.h>
> +#include <linux/sprintf.h>
> +#include <linux/srcu.h>
> +#include <linux/types.h>
> +#include <linux/workqueue.h>
> +#include <uapi/drm/qaic_accel.h>
> +
> +#include "qaic.h"
> +#include "qaic_telemetry.h"
> +
> +#define MAGIC				0x55AA
> +#define VERSION				0x1
> +
> +/*
> + * Telemetry fields defined by the uAPI.
> + * This table will be used by drm_ras's dumpit to display
> + * each field to userspace.
> + */
> +#define QAIC_FIELD_RO(_name) \
> +	{#_name, _name, DRM_RAS_TELEMETRY_FIELD_MODE_READ}
> +#define QAIC_FIELD_RW(_name) \
> +	{#_name, _name, DRM_RAS_TELEMETRY_FIELD_MODE_READ | DRM_RAS_TELEMETRY_FIELD_MODE_WRITE}
> +
> +static const struct drm_ras_telemetry_field qaic_telemetry_fields[] = {
> +	QAIC_FIELD_RO(QAIC_DEVINFO_THERMAL_SOC_MAX_TEMP),
> +	QAIC_FIELD_RO(QAIC_DEVINFO_THERMAL_BOARD_TEMP),
> +	QAIC_FIELD_RO(QAIC_DEVINFO_THERMAL_BOARD_MAX_TEMP),
> +	QAIC_FIELD_RO(QAIC_DEVINFO_THERMAL_DDR_TEMP),
> +	QAIC_FIELD_RW(QAIC_DEVINFO_THERMAL_WARNING_TEMP),
> +	QAIC_FIELD_RW(QAIC_DEVINFO_THERMAL_SHUTDOWN_TEMP),
> +	QAIC_FIELD_RW(QAIC_DEVINFO_BOARD_TDP),
> +	QAIC_FIELD_RO(QAIC_DEVINFO_BOARD_POWER),
> +	QAIC_FIELD_RW(QAIC_DEVINFO_POWER_STATE),
> +	QAIC_FIELD_RO(QAIC_DEVINFO_POWER_MAX),
> +	QAIC_FIELD_RO(QAIC_DEVINFO_THROTTLE_PERCENT),
> +	QAIC_FIELD_RO(QAIC_DEVINFO_THROTTLE_TIME),
> +	QAIC_FIELD_RO(QAIC_DEVINFO_UPTIME),
> +	QAIC_FIELD_RO(QAIC_DEVINFO_THERMAL_SOC_FLOOR_TEMP),
> +	QAIC_FIELD_RO(QAIC_DEVINFO_THERMAL_SOC_CEILING_TEMP),
> +	QAIC_FIELD_RO(QAIC_DEVINFO_VOLTAGE_CX),
> +	QAIC_FIELD_RO(QAIC_DEVINFO_VOLTAGE_MX),
> +	QAIC_FIELD_RO(QAIC_DEVINFO_VOLTAGE_NSP_CX),
> +	QAIC_FIELD_RO(QAIC_DEVINFO_VOLTAGE_NSP_MX),
> +	QAIC_FIELD_RW(QAIC_DEVINFO_CFG_TOPS),
> +	QAIC_FIELD_RO(QAIC_DEVINFO_THERMAL_PMIC_TEMP_A),
> +	QAIC_FIELD_RO(QAIC_DEVINFO_THERMAL_PMIC_TEMP_C),
> +	QAIC_FIELD_RO(QAIC_DEVINFO_THERMAL_PMIC_TEMP_E),
> +	QAIC_FIELD_RW(QAIC_DEVINFO_POWER_ACTION),
> +	QAIC_FIELD_RW(QAIC_DEVINFO_SOC_TDP),
> +	QAIC_FIELD_RO(QAIC_DEVINFO_SOC_POWER),
> +	{},
> +};
> +
> +#undef QAIC_FIELD_RO
> +#undef QAIC_FIELD_RW
> +
> +enum fw_errno {
> +	ERR_READ_ONLY		= -1,
> +	ERR_NOT_SUPPORTED	= -2,
> +	ERR_WHILE_PROCESSING	= -3,
> +	ERR_INVALID_VALUE	= -4,
> +	ERR_INVALID_HEADER	= -5,
> +};
> +
> +enum cmd_type {
> +	TYPE_READ,  /* read value from device */
> +	TYPE_WRITE, /* write value to device */
> +};
> +
> +enum msg_type {
> +	MSG_PUSH, /* async push from device */
> +	MSG_REQ,  /* sync request to device */
> +	MSG_RESP, /* sync response from device */
> +};
> +
> +struct telemetry_data {
> +	u8	cmd;
> +	u8	cmd_type;
> +	u8	status;
> +	__le64	val; /* signed */
> +} __packed;
> +
> +struct telemetry_header {
> +	__le16	magic;
> +	__le16	ver;
> +	__le32	seq_num;
> +	u8	type;
> +	u8	id;
> +	__le16	len;
> +} __packed;
> +
> +struct telemetry_msg { /* little endian encoded */
> +	struct telemetry_header hdr;
> +	struct telemetry_data data;
> +} __packed;
> +
> +struct wrapper_msg {
> +	struct kref ref_count;
> +	struct telemetry_msg msg;
> +};
> +
> +struct xfer_queue_elem {
> +	/*
> +	 * Node in list of ongoing transfer request on telemetry channel.
> +	 * Maintained by root device struct
> +	 */
> +	struct list_head list;
> +	/* Sequence number of this transfer request */
> +	u32 seq_num;
> +	/* This is used to wait on until completion of transfer request */
> +	struct completion xfer_done;
> +	/* Received data from device */
> +	void *buf;
> +};
> +
> +struct resp_work {
> +	/* Work struct to schedule work coming on QAIC_TELEMETRY channel */
> +	struct work_struct work;
> +	/* Root struct of device, used to access device resources */
> +	struct qaic_device *qdev;
> +	/* Buffer used by MHI for transfer requests */
> +	void *buf;
> +};
> +
> +static void free_wrapper(struct kref *ref)
> +{
> +	struct wrapper_msg *wrapper = container_of(ref, struct wrapper_msg, ref_count);
> +
> +	kfree(wrapper);
> +}
> +
> +static int telemetry_request(struct qaic_device *qdev, u8 cmd, u8 cmd_type, s64 *val, s64 *status)
> +{
> +	struct wrapper_msg *wrapper;
> +	struct xfer_queue_elem elem;
> +	struct telemetry_msg *resp;
> +	struct telemetry_msg *req;
> +	long ret = 0;
> +
> +	wrapper = kzalloc_obj(*wrapper);
> +	if (!wrapper)
> +		return -ENOMEM;
> +
> +	kref_init(&wrapper->ref_count);
> +	req = &wrapper->msg;
> +
> +	ret = mutex_lock_interruptible(&qdev->tele_mutex);
> +	if (ret)
> +		goto free_req;
> +
> +	if (!qdev->tele_ch) {
> +		mutex_unlock(&qdev->tele_mutex);
> +		ret = -ENODEV;
> +		goto free_req;
> +	}
> +
> +	req->hdr.magic = cpu_to_le16(MAGIC);
> +	req->hdr.ver = cpu_to_le16(VERSION);
> +	req->hdr.seq_num = cpu_to_le32(qdev->tele_next_seq_num++);
> +	req->hdr.type = MSG_REQ;
> +	req->hdr.id = 0;
> +	req->hdr.len = cpu_to_le16(sizeof(req->data));
> +
> +	req->data.cmd = cmd;
> +	req->data.cmd_type = cmd_type;
> +	req->data.status = 0;
> +	if (cmd_type == TYPE_READ)
> +		req->data.val = cpu_to_le64(0);
> +	else
> +		req->data.val = cpu_to_le64(*val);
> +
> +	elem.seq_num = qdev->tele_next_seq_num - 1;
> +	elem.buf = NULL;
> +	init_completion(&elem.xfer_done);
> +	if (likely(!qdev->tele_lost_buf)) {
> +		resp = kzalloc_obj(*resp);
> +		if (!resp) {
> +			mutex_unlock(&qdev->tele_mutex);
> +			ret = -ENOMEM;
> +			goto free_req;
> +		}
> +
> +		ret = mhi_queue_buf(qdev->tele_ch, DMA_FROM_DEVICE, resp, sizeof(*resp), MHI_EOT);
> +		if (ret) {
> +			mutex_unlock(&qdev->tele_mutex);
> +			goto free_resp;
> +		}
> +	} else {
> +		/*
> +		 * we lost a buffer because we queued a recv buf, but then
> +		 * queuing the corresponding tx buf failed. To try to avoid
> +		 * a memory leak, lets reclaim it and use it for this
> +		 * transaction.
> +		 */
> +		qdev->tele_lost_buf = false;
> +	}
> +
> +	kref_get(&wrapper->ref_count);
> +	ret = mhi_queue_buf(qdev->tele_ch, DMA_TO_DEVICE, req, sizeof(*req), MHI_EOT);
> +	if (ret) {
> +		qdev->tele_lost_buf = true;
> +		kref_put(&wrapper->ref_count, free_wrapper);
> +		mutex_unlock(&qdev->tele_mutex);
> +		goto free_req;
> +	}
> +
> +	list_add_tail(&elem.list, &qdev->tele_xfer_list);
> +	mutex_unlock(&qdev->tele_mutex);
> +
> +	ret = wait_for_completion_interruptible_timeout(&elem.xfer_done, HZ);
> +	/*
> +	 * not using _interruptable because we have to cleanup or we'll
> +	 * likely cause memory corruption
> +	 */
> +	mutex_lock(&qdev->tele_mutex);
> +	if (!list_empty(&elem.list))
> +		list_del(&elem.list);
> +	/* resp_worker() processed the response but the wait was interrupted */
> +	else if (ret == -ERESTARTSYS)
> +		ret = 0;
> +	if (!ret && !elem.buf)
> +		ret = -ETIMEDOUT;
> +	else if (ret > 0 && !elem.buf)
> +		ret = -EIO;
> +	mutex_unlock(&qdev->tele_mutex);
> +
> +	resp = elem.buf;
> +
> +	/*
> +	 * telemetry_request() is called from Generic Netlink .doit callbacks
> +	 * rather than a syscall boundary, so -ERESTARTSYS is never translated
> +	 * to -EINTR before it would otherwise be serialized as-is into the
> +	 * netlink error ack.
> +	 */
> +	if (ret == -ERESTARTSYS)
> +		ret = -EINTR;
> +
> +	if (ret < 0)
> +		goto free_resp;
> +
> +	if (le16_to_cpu(resp->hdr.magic) != MAGIC || le16_to_cpu(resp->hdr.ver) != VERSION ||
> +	    resp->hdr.type != MSG_RESP || resp->hdr.id != 0 ||
> +	    le16_to_cpu(resp->hdr.len) != sizeof(resp->data) || resp->data.cmd != cmd ||
> +	    resp->data.cmd_type != cmd_type) {
> +		ret = -EINVAL;
> +		goto free_resp;
> +	}
> +
> +	if (resp->data.status) {
> +		switch ((s8)resp->data.status) {
> +		case ERR_READ_ONLY:
> +			*status = -EROFS;
> +			break;
> +		case ERR_NOT_SUPPORTED:
> +			*status = -EOPNOTSUPP;
> +			break;
> +		case ERR_WHILE_PROCESSING:
> +			*status = -EREMOTEIO;
> +			break;
> +		case ERR_INVALID_VALUE:
> +			*status = -EINVAL;
> +			break;
> +		case ERR_INVALID_HEADER:
> +			*status = -EBADR;
> +			break;
> +		default:
> +			*status = -EPROTO;
> +		}
> +		ret = 0;
> +		goto free_resp;
> +	}
> +
> +	if (cmd_type == TYPE_READ)
> +		*val = le64_to_cpu(resp->data.val);
> +
> +	ret = 0;
> +
> +free_resp:
> +	kfree(resp);
> +free_req:
> +	kref_put(&wrapper->ref_count, free_wrapper);
> +
> +	return ret;
> +}
> +
> +static void resp_worker(struct work_struct *work)
> +{
> +	struct resp_work *resp = container_of(work, struct resp_work, work);
> +	struct qaic_device *qdev = resp->qdev;
> +	struct telemetry_msg *msg = resp->buf;
> +	struct xfer_queue_elem *elem;
> +	struct xfer_queue_elem *i;
> +	bool found = false;
> +
> +	if (le16_to_cpu(msg->hdr.magic) != MAGIC) {
> +		kfree(msg);
> +		kfree(resp);
> +		return;
> +	}
> +
> +	mutex_lock(&qdev->tele_mutex);
> +	list_for_each_entry_safe(elem, i, &qdev->tele_xfer_list, list) {
> +		if (elem->seq_num == le32_to_cpu(msg->hdr.seq_num)) {
> +			found = true;
> +			list_del_init(&elem->list);
> +			elem->buf = msg;
> +			complete_all(&elem->xfer_done);
> +			break;
> +		}
> +	}
> +	mutex_unlock(&qdev->tele_mutex);
> +
> +	if (!found)
> +		/* request must have timed out, drop packet */
> +		kfree(msg);
> +
> +	kfree(resp);
> +}
> +
> +static void qaic_telemetry_mhi_ul_xfer_cb(struct mhi_device *mhi_dev,
> +					  struct mhi_result *mhi_result)
> +{
> +	struct telemetry_msg *msg = mhi_result->buf_addr;
> +	struct wrapper_msg *wrapper;
> +
> +	wrapper = container_of(msg, struct wrapper_msg, msg);
> +	kref_put(&wrapper->ref_count, free_wrapper);
> +}
> +
> +static void qaic_telemetry_mhi_dl_xfer_cb(struct mhi_device *mhi_dev,
> +					  struct mhi_result *mhi_result)
> +{
> +	struct qaic_device *qdev = dev_get_drvdata(&mhi_dev->dev);
> +	struct telemetry_msg *msg = mhi_result->buf_addr;
> +	struct resp_work *resp;
> +
> +	if (mhi_result->transaction_status) {
> +		kfree(msg);
> +		return;
> +	}
> +
> +	resp = kmalloc(sizeof(*resp), GFP_ATOMIC);
> +	if (!resp) {
> +		pci_err(qdev->pdev, "dl_xfer_cb alloc fail, dropping message\n");
> +		kfree(msg);
> +		return;
> +	}
> +
> +	INIT_WORK(&resp->work, resp_worker);
> +	resp->qdev = qdev;
> +	resp->buf = msg;
> +	queue_work(qdev->tele_wq, &resp->work);
> +}
> +
> +static int qaic_telemetry_pre(struct drm_ras_node *ep)
> +{
> +	struct qaic_device *qdev = ep->priv;
> +	struct inode *dev_inode;
> +	struct path path;
> +	char devpath[24];
> +	int ret;
> +
> +	snprintf(devpath, sizeof(devpath), "/dev/accel/%s", to_accel_kdev(qdev->qddev)->kobj.name);
> +	scoped_with_init_fs()
> +		ret = kern_path(devpath, LOOKUP_FOLLOW, &path);
> +	if (ret)
> +		return -EINVAL;
> +
> +	dev_inode = d_inode(path.dentry);
> +	ret = inode_permission(&nop_mnt_idmap, dev_inode, MAY_READ | MAY_WRITE);
> +	path_put(&path);
> +
> +	return ret;
> +}
> +
> +static int qaic_telemetry_get(struct drm_ras_node *ep, u64 *field, s64 *value, s64 *status)
> +{
> +	struct qaic_device *qdev = ep->priv;
> +	int rcu_id;
> +	int ret;
> +
> +	/* telemetry_request expects the field to be a u8 */
> +	if (*field > U8_MAX)
> +		return -EINVAL;
> +
> +	rcu_id = srcu_read_lock(&qdev->dev_lock);
> +	if (qdev->dev_state != QAIC_ONLINE) {
> +		srcu_read_unlock(&qdev->dev_lock, rcu_id);
> +		return -ENODEV;
> +	}
> +
> +	ret = telemetry_request(qdev, (u8)*field, TYPE_READ, value, status);
> +	srcu_read_unlock(&qdev->dev_lock, rcu_id);
> +
> +	return ret;
> +}
> +
> +static int qaic_telemetry_set(struct drm_ras_node *ep, u64 *field, s64 *value, s64 *status)
> +{
> +	struct qaic_device *qdev = ep->priv;
> +	int rcu_id;
> +	int ret;
> +
> +	/* telemetry_request expects the field to be a u8 */
> +	if (*field > U8_MAX)
> +		return -EINVAL;
> +
> +	rcu_id = srcu_read_lock(&qdev->dev_lock);
> +	if (qdev->dev_state != QAIC_ONLINE) {
> +		srcu_read_unlock(&qdev->dev_lock, rcu_id);
> +		return -ENODEV;
> +	}
> +
> +	ret = telemetry_request(qdev, (u8)*field, TYPE_WRITE, value, status);
> +	srcu_read_unlock(&qdev->dev_lock, rcu_id);
> +
> +	return ret;
> +}
> +
> +static int qaic_drm_ras_register_node(struct qaic_device *qdev)
> +{
> +	struct drm_ras_node *node;
> +	struct pci_dev *pdev = qdev->pdev;
> +	const char *device_name, *node_name;
> +	int ret;
> +
> +	node = kzalloc_obj(struct drm_ras_node);
> +	if (!node)
> +		return -ENOMEM;
> +
> +	device_name = kasprintf(GFP_KERNEL, "%04x:%02x:%02x.%d",
> +				pci_domain_nr(pdev->bus), pdev->bus->number,
> +				PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
> +	if (!device_name) {
> +		kfree(node);
> +		return -ENOMEM;
> +	}
> +
> +	node_name = kasprintf(GFP_KERNEL, "qaic_telemetry");
> +	if (!node_name) {
> +		kfree(device_name);
> +		kfree(node);
> +		return -ENOMEM;
> +	}
> +
> +	node->device_name = device_name;
> +	node->node_name = node_name;
> +	node->type = DRM_RAS_NODE_TYPE_TELEMETRY;
> +	node->priv = qdev;
> +	node->telemetry_get = qaic_telemetry_get;
> +	node->telemetry_set = qaic_telemetry_set;
> +	node->telemetry_pre = qaic_telemetry_pre;
> +	node->telemetry_fields = qaic_telemetry_fields;
> +
> +	ret = drm_ras_node_register(node);
> +	if (ret) {
> +		kfree(device_name);
> +		kfree(node_name);
> +		kfree(node);
> +		return ret;
> +	}
> +
> +	qdev->ras_node = node;
> +	return 0;
> +}
> +
> +static void qaic_drm_ras_unregister_node(struct qaic_device *qdev)
> +{
> +	drm_ras_node_unregister(qdev->ras_node);
> +	kfree(qdev->ras_node->node_name);
> +	kfree(qdev->ras_node->device_name);
> +	kfree(qdev->ras_node);
> +}
> +
> +static int qaic_telemetry_mhi_probe(struct mhi_device *mhi_dev, const struct mhi_device_id *id)
> +{
> +	struct qaic_device *qdev = pci_get_drvdata(to_pci_dev(mhi_dev->mhi_cntrl->cntrl_dev));
> +	int ret;
> +
> +	ret = mhi_prepare_for_transfer(mhi_dev);
> +	if (ret)
> +		return ret;
> +
> +	dev_set_drvdata(&mhi_dev->dev, qdev);
> +	qdev->tele_ch = mhi_dev;
> +	qdev->tele_lost_buf = false;
> +
> +	ret = qaic_drm_ras_register_node(qdev);
> +	if (ret) {
> +		mhi_unprepare_from_transfer(mhi_dev);
> +		qdev->tele_ch = NULL;
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void qaic_telemetry_mhi_remove(struct mhi_device *mhi_dev)
> +{
> +	struct qaic_device *qdev = dev_get_drvdata(&mhi_dev->dev);
> +
> +	qaic_drm_ras_unregister_node(qdev);
> +	mhi_unprepare_from_transfer(qdev->tele_ch);
> +	qdev->tele_ch = NULL;
> +}
> +
> +static const struct mhi_device_id qaic_telemetry_mhi_match_table[] = {
> +	{ .chan = "QAIC_TELEMETRY", },
> +	{},
> +};
> +
> +static struct mhi_driver qaic_telemetry_mhi_driver = {
> +	.id_table = qaic_telemetry_mhi_match_table,
> +	.remove = qaic_telemetry_mhi_remove,
> +	.probe = qaic_telemetry_mhi_probe,
> +	.ul_xfer_cb = qaic_telemetry_mhi_ul_xfer_cb,
> +	.dl_xfer_cb = qaic_telemetry_mhi_dl_xfer_cb,
> +	.driver = {
> +		.name = "qaic_telemetry",
> +	},
> +};
> +
> +int qaic_telemetry_register(void)
> +{
> +	return mhi_driver_register(&qaic_telemetry_mhi_driver);
> +}
> +
> +void qaic_telemetry_unregister(void)
> +{
> +	mhi_driver_unregister(&qaic_telemetry_mhi_driver);
> +}
> +
> +void wake_all_telemetry(struct qaic_device *qdev)
> +{
> +	struct xfer_queue_elem *elem;
> +	struct xfer_queue_elem *i;
> +
> +	mutex_lock(&qdev->tele_mutex);
> +	list_for_each_entry_safe(elem, i, &qdev->tele_xfer_list, list) {
> +		list_del_init(&elem->list);
> +		complete_all(&elem->xfer_done);
> +	}
> +	qdev->tele_lost_buf = false;
> +	mutex_unlock(&qdev->tele_mutex);
> +}
> diff --git a/drivers/accel/qaic/qaic_telemetry.h b/drivers/accel/qaic/qaic_telemetry.h
> new file mode 100644
> index 000000000000..07803e44ab66
> --- /dev/null
> +++ b/drivers/accel/qaic/qaic_telemetry.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +/* Copyright (c) 2020, The Linux Foundation. All rights reserved. */
> +
> +#ifndef __QAIC_TELEMETRY_H__
> +#define __QAIC_TELEMETRY_H__
> +
> +#include "qaic.h"
> +
> +int qaic_telemetry_register(void);
> +void qaic_telemetry_unregister(void);
> +void wake_all_telemetry(struct qaic_device *qdev);
> +
> +#endif /* __QAIC_TELEMETRY_H__ */
> diff --git a/include/uapi/drm/qaic_accel.h b/include/uapi/drm/qaic_accel.h
> index c92d0309d583..5aac05101426 100644
> --- a/include/uapi/drm/qaic_accel.h
> +++ b/include/uapi/drm/qaic_accel.h
> @@ -51,6 +51,34 @@ extern "C" {
>  #define QAIC_TRANS_VALIDATE_PARTITION_FROM_DEV	19
>  #define QAIC_TRANS_VALIDATE_PARTITION_TO_DEV	20
>  
> +/* Telemetry fields */
> +#define QAIC_DEVINFO_THERMAL_SOC_MAX_TEMP	1
> +#define QAIC_DEVINFO_THERMAL_BOARD_TEMP		2
> +#define QAIC_DEVINFO_THERMAL_BOARD_MAX_TEMP	3
> +#define QAIC_DEVINFO_THERMAL_DDR_TEMP		4
> +#define QAIC_DEVINFO_THERMAL_WARNING_TEMP	5
> +#define QAIC_DEVINFO_THERMAL_SHUTDOWN_TEMP	6
> +#define QAIC_DEVINFO_BOARD_TDP			7
> +#define QAIC_DEVINFO_BOARD_POWER		8
> +#define QAIC_DEVINFO_POWER_STATE		9
> +#define QAIC_DEVINFO_POWER_MAX			10
> +#define QAIC_DEVINFO_THROTTLE_PERCENT		11
> +#define QAIC_DEVINFO_THROTTLE_TIME		12
> +#define QAIC_DEVINFO_UPTIME			13
> +#define QAIC_DEVINFO_THERMAL_SOC_FLOOR_TEMP	14
> +#define QAIC_DEVINFO_THERMAL_SOC_CEILING_TEMP	15
> +#define QAIC_DEVINFO_VOLTAGE_CX			16
> +#define QAIC_DEVINFO_VOLTAGE_MX			17
> +#define QAIC_DEVINFO_VOLTAGE_NSP_CX		18
> +#define QAIC_DEVINFO_VOLTAGE_NSP_MX		19
> +#define QAIC_DEVINFO_CFG_TOPS			20
> +#define QAIC_DEVINFO_THERMAL_PMIC_TEMP_A	21
> +#define QAIC_DEVINFO_THERMAL_PMIC_TEMP_C	22
> +#define QAIC_DEVINFO_THERMAL_PMIC_TEMP_E	23
> +#define QAIC_DEVINFO_POWER_ACTION		24
> +#define QAIC_DEVINFO_SOC_TDP			25
> +#define QAIC_DEVINFO_SOC_POWER			26
> +
>  /**
>   * struct qaic_manage_trans_hdr - Header for a transaction in a manage message.
>   * @type: In. Identifies this transaction. See QAIC_TRANS_* defines.
> -- 
> 2.43.0
> 
