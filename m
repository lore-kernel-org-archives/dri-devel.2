Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E7DC9830E
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 01:00:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D4C910E0BF;
	Sat, 26 Sep 2026 01:00:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="JYkucG5b";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2487D10E0BF;
 Sat, 26 Sep 2026 01:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790384436; x=1821920436;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=1FWA+A/P/3uaiAfp/yW4enBXaOIMKpp/EbEZPihCpY0=;
 b=JYkucG5b1oFoykei5RuuiKCOQ4p8L2bZQ8kk/92ho9dyPltq38PFnPtF
 ZkcB24tm9ZwgdHrXJCLvWoEoqy0nRF1/c6QgueQ2xKAvddlkSRDg7igO1
 BgYHntydalPDbMaDGvVuZomCHkKTp/x5OI9W6+/tRf1ZwkjwWYhzEcJeG
 CXTYdlY7tAm4s8DA+jc+wpp7ZbifuYA72OWFNSG2Bh17mtN33UDP1yRxC
 rgHycNAA4THY3AxJWWro/oLyrY5PedSJPB1AaXmbis2KjYKqb9is+O9dH
 UNZmlCmhP0zRhfWgNmBvh68f52nlVqYqngZ8d5X6T/Q1sZsH9d8omwtzc w==;
X-CSE-ConnectionGUID: QJBe5vk4QfeRQZOM3+OvnA==
X-CSE-MsgGUID: LsTmDvAxRiKnp+ZpIh6K0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="90234751"
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="90234751"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 18:00:36 -0700
X-CSE-ConnectionGUID: DOpdoXqyToWp2e2bMkoxxA==
X-CSE-MsgGUID: 5N7zN3DzRFeFebcP9IxIDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="274043927"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 18:00:35 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 18:00:34 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 18:00:34 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.35) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 18:00:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PVMebVQGLHbtcMH6bdOLOfLAZDZL6SpeijNcuDWE5sZlVILCMcenotHXmu9pMsB4FD/KGwcX5VLT0AUDcyxX11VqJh6QiAMYPJhV9X1KOqgulfmOLPrsJwUyELijnK5W3SQNiHIl6J2/M7A9KmNvcFYXwsXrIamCSUNLcfvBS5C/MRU2owyw0WvGSQ0IlAO9kG4oC1w9fd9YkRhWZECjTwyOuW6NiXiK2bu8bXtTDAOoALFep5z1p7oet9hYruEVFaSXF0f/Dxf6Q5fqN7YpKFLKTFX/lKIGMY1LVw/25uVEXoXcupeb6f6mdKXm2Ou8m36gWXyAntIz+zLdhd9dUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrHvhT95aiI/Req3L5SJYL25l6Ziv7wXbscLByjO1ks=;
 b=pB+fJa6PlGpN7o0hHPeqoyE01d0idX0djuYxUE9TAwM2T/fgMhPnjT+UaE4tUtIb1GjM492oLIGYMAd+hISLelUNQ2gsEEfZgX6Hdz9jaPsPFi3zIbR/1O+6S9Q0DMbKCxCWapbsD8T4rDTDtJt4IP9luIHWT/BF/uK6ifhnkaOyHgZHgJF7wGlPvjJAuCtOMqfM2PWjSNZ3hdJTotKXVS97oWgZ6QYOti2IJrDnIqJAVsF6Cz0epsDmJuITdEhO0i0nkL7l5EkzMUeq3DOYCbktv/9s346wr4BUySNFRhGvrtWkFngsoRk56XFWcSXUfs4Ld+IL9qScsrxMtvti5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by SJ0PR11MB4976.namprd11.prod.outlook.com (2603:10b6:a03:2d7::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Sat, 26 Sep
 2026 01:00:30 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0451.014; Sat, 26 Sep 2026
 01:00:30 +0000
Date: Fri, 25 Sep 2026 21:00:15 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
CC: Matthew Brost <matthew.brost@intel.com>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, <brgl@kernel.org>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Heikki Krogerus
 <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH] drm/xe/i2c: use device_create_managed_software_node()
Message-ID: <arcZH00cGFL5aSYF@intel.com>
References: <20260922-xe-i2c-reapply-swnode-unreg-v1-1-1bdda5d44701@oss.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260922-xe-i2c-reapply-swnode-unreg-v1-1-1bdda5d44701@oss.qualcomm.com>
X-ClientProxiedBy: SI3PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::18) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|SJ0PR11MB4976:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d386366-34b8-443a-78a9-08df1b698f22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|260925022911599003|260925021311599003|10067099003|56012099006|22082099003|18002099003|11063799006|260925021911599003;
X-Microsoft-Antispam-Message-Info: OfDJfblckIew64Sc523OyxuvHjQMo2ILlwR10m8pFPntk0Z/NDN1dIRomAGqscPyN3YXlW97MHK/8E6xpIA15k2JXpcLrGqfLXjFMjW//dyDCu2BhB3nD4znmlif3tTLzxr9372zciV+YrzbxqN7mqRQWtNkM4/pp1U+oyZsJ4rypEE6MYBj1i1D0+D52xWn3CtGslwsPCkdMJObGcZe28oXlMx16yHKJi/oXKpV/r4LJBq/dqzGOotPuXCZoB1hELEw9I2ras63+84bvwEAexk0nzTxtmFbEli15HVGurYgDqe/lr/OYaFlo+bIIyJqorWNPoK2fJIcfW4P8/uQUlWM8F2F4H3XJHgyC2dmCO1rew58NbjvJgPbDTk7jF8GgrIb7Z9DEwkaHLISRyn+NtHNP0KIXtRjpuVaW4gbPGPaZ++Oi6ErMpRjmDR41n4lGIP12NHtiN8GHG1GF/8Ak8/OYucxRJkAe8n2INMz4pzEoCnC3ZP34WXVhF7qADRzjt2rOksZSLHXRZQf7wfp0AQXOv3iCGe2gimoHc8B0+50GbesZ304/BypbtIncqXHnWSjDTSa5UydiDQEJooSHwiePprbYaqWl1lOllJbBHn+B2N/RqdqrDtDGSG2WLQucQWZXCvf4rnkMlFikoknqx9pP3ZCjdy1hd3qMSfeLiw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(260925022911599003)(260925021311599003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006)(260925021911599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bk1HCPjf6nfeY4yNtuAhOr3N5BNijSLPVJFaLNu51eJvxm+ZrJKBTp/1kjLR?=
 =?us-ascii?Q?e+aUxM3L8okakk2hhrWRXI7y7J68H58ucKAgOeFarpdiofV/+Z3JiyEDrXfp?=
 =?us-ascii?Q?OgUAa8O649FO9GlfEo+OibG4e6fsVgMT0k6JYiokzVZGQvzmPzpu9dOpNwSx?=
 =?us-ascii?Q?bYWMhtvbA46tLF6XSc2SGnsDJWFXXxsMvnPf8SG+i/SKxUC1IUVxOKFhJytj?=
 =?us-ascii?Q?CsAmJE64HmzgZmoptfzPagvAd43F+Svr5FlXIlSz+Ys10ROHLnNxvRrSxVRs?=
 =?us-ascii?Q?/hOXrGxx/1RgkIjmS4lkHOFfynY4YT+k8Ci47jdh0ICPM0dagQN/huf7MiAL?=
 =?us-ascii?Q?yzG/LgSH+oivLk45p4km9n0is7bbOe4C3suvq6fC0HdQDXGj5hX7XdUanGHC?=
 =?us-ascii?Q?o6Fdd1E0OQEdg4GTfiPiM41ZtLEPtHXxaWMAwMHiQY0KLzF0uWw52x/XBIO1?=
 =?us-ascii?Q?RpBV1QLmag1f1XvL+OnxnzwgMAb1dmDZaTEUisrsF1goBZsiuOIMM3Y54udS?=
 =?us-ascii?Q?PmfIgpf351of6OMsMLgTSawfYuPjK3OsyR7u831jYJZ6TBiPI++wKRcSoPi6?=
 =?us-ascii?Q?7iZzOIFSndo5nt4V1RTYHiTwF82lE1GGsdg4O+4bat/kCu1xataTdD5VrBAd?=
 =?us-ascii?Q?4D0yQlEHiDzHDRCchsTeN6iynUPWt0uJ/ZG4iHfLHPvS253natmJir0fsWFg?=
 =?us-ascii?Q?ysot7xeHZJLQUyhA1BYm9U15Sp9w47mJEjAksLDDT+jPdIkWGi1Kn3F01cTS?=
 =?us-ascii?Q?v14DOOxmRsjD8DlXSEFRT0EusLf0mgVwOPZfg46xNknzBKiZLxgGyK/yu3tS?=
 =?us-ascii?Q?WjnKdguGjYgs0ivq+5DcpB26VnGInOXn8rM/AU3/j9vYX5y7Y4Axnb2vDbS0?=
 =?us-ascii?Q?U77g+68Yh0YAczszRkUnHtoJ/1J3EHBllim8323IyDW9KFhPWVXP0d6mZbLl?=
 =?us-ascii?Q?6N5f+IhwlQ4h0rDnyBW+6qRjVP7Z8+4Upwzc+sTMFVuimgocRWG8Okpgb6Vk?=
 =?us-ascii?Q?yObgqVufDtQwp2GP2oe7tvp9xOVaU+sqlDfwjFILPK1jOyzACAcwoKjt4g3r?=
 =?us-ascii?Q?uIJgsohrvhLf7ZoAmaI7PTITsLUIDO/4ii7zBx64lgkJh899ht+3X+/H9IHG?=
 =?us-ascii?Q?iiRYXA8FNpJbwbLrhi4lOKghr8oekmfkj5Wz5s7YxLQC70t03tsOQjEuYte0?=
 =?us-ascii?Q?kgTovBnjsWw2QmGzWQWqae0iKLq+wpN62r+CB7KdtdbzcloEUL/imbH/raZf?=
 =?us-ascii?Q?lPwZP296mOfTlEgSOSVJekWXQ/MNhYuvGhGFEUmQeUTUkaBgui1QAEWs/oRS?=
 =?us-ascii?Q?WhE8tygOnW0VrsRFHgNtwm5C4OYiWsc24xSPHT8uhecopHtKFCLrq1NcU+3U?=
 =?us-ascii?Q?NmRf5tMd3/nCs8Xa9U5CwC46IxTZo2Qh8OwxU/ImATxXD/pifwQLraIszFJ/?=
 =?us-ascii?Q?BePZRHXcwO502RhXi/lFJtthb74U2b2ugdseO/4Ba2sMfpJIQJyDa86feaNB?=
 =?us-ascii?Q?UgPTnka9+T8hnisLzEAgUDkA17pgS38pFJMYtPyKkw0sBsDjxq2pr/G3YN+n?=
 =?us-ascii?Q?Nn2mhTMXjuNc1jgV2BjuoCnR43H7Yz2HXcQGqj38ReH2iE8R+hNIqzylQexd?=
 =?us-ascii?Q?GX7u30lLKwMe2FdRKa/RO4wf7LCvZJIBn5IteuFzfwyAsWyWk/uK1uy+tkKJ?=
 =?us-ascii?Q?oZpj83dR0NVTQp21Yi/sMJJQGgPpXVHr8bxKavESQl4TqujIpN50Vkxactp1?=
 =?us-ascii?Q?hMsqLIrggFycjgvNGMb83S6kARON0SU=3D?=
X-Exchange-RoutingPolicyChecked: ye0lB/e2z69wrQ5D+Exojw/y11tAC/tjoADCy2SyE2qQh0Oh3h5fGXAZCLkBaKT0PR+39ih7/TZQ7EEV1BwOW8niOw31vp1FCL4X7sUuQ1p1ZlT2nHNuZp3PgJwUqBCrIa9OovtQ8on3aXcVJsnbdXr4DeGeLXFRxfKSvLQnU5RRAf+aMZNM0l2/X1jXfm5BeBo/+8tOyG+sIvxgmgmbwoMW6/t6aAk9CIyjQU70Q7EwGkroPM0tZoPY0GRELRweNR0xaRFLbZ0cqQQ8v6aLqPu0C4t5D0wApkPYBPXjlVB69i84797t8BgKsOq7h0r0ITx0bnLSGuCz55cuTVxJFg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d386366-34b8-443a-78a9-08df1b698f22
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2026 01:00:30.1906 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vfn4b1TID7wd4UM6QbuT7RGnOCIGYAnicb2Zrva+yOtTQMU+sZnvqRutajkTlzUPYcg6trSf8x1s2p3B/PKrIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4976
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

On Tue, Sep 22, 2026 at 04:25:55PM +0200, Bartosz Golaszewski wrote:
> This driver intentionally uses the fine-grained approach to creating
> platform devices. It assigns a software node as the primary firmware
> node of the device it creates. Ahead of improving the reference counting
> of platform device software nodes, switch to using
> device_create_managed_software_node(). This way, we create a dynamic
> software node whose life-time is tied to the device to which it's
> assigned.
> 
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
> This patch exists in mainline as commit fc90ce2d ("drm/xe/i2c: use
> device_create_managed_software_node()") but the code got silently
> overwritten by merge commit cc467969646b ("Merge drm/drm-next into
> drm-xe-next"). It should be reapplied.

I pushed this back again, but modifying the commit message to reflect the
history.

> ---
>  drivers/gpu/drm/xe/xe_i2c.c | 22 ++++++++--------------
>  drivers/gpu/drm/xe/xe_i2c.h |  1 -
>  2 files changed, 8 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
> index 51ca9fb73b708317c5dd8613d0ba060b8dc2028e..f4f3819882897f7f19a7bd3043a936e3c7eec553 100644
> --- a/drivers/gpu/drm/xe/xe_i2c.c
> +++ b/drivers/gpu/drm/xe/xe_i2c.c
> @@ -111,14 +111,9 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
>  {
>  	struct pci_dev *pci = to_pci_dev(i2c->drm_dev);
>  	struct platform_device *pdev;
> -	struct fwnode_handle *fwnode;
>  	int ret;
>  	u32 id;
>  
> -	fwnode = fwnode_create_software_node(xe_i2c_adapter_properties, NULL);
> -	if (IS_ERR(fwnode))
> -		return PTR_ERR(fwnode);
> -
>  	id = (pci_domain_nr(pci->bus) << 16) | pci_dev_id(pci);
>  
>  	/*
> @@ -128,14 +123,16 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
>  	 * platform_device_register_full() is done.
>  	 */
>  	pdev = platform_device_alloc(adapter_name, id);
> -	if (!pdev) {
> -		ret = -ENOMEM;
> -		goto err_fwnode_remove;
> -	}
> +	if (!pdev)
> +		return -ENOMEM;
> +
> +	ret = device_create_managed_software_node(&pdev->dev,
> +						  xe_i2c_adapter_properties,
> +						  NULL);
> +	if (ret)
> +		goto err_pdev_put;
>  
>  	pdev->dev.parent = i2c->drm_dev;
> -	pdev->dev.fwnode = fwnode;
> -	i2c->adapter_node = fwnode;
>  	i2c->pdev = pdev;
>  
>  	ret = platform_device_add(pdev);
> @@ -146,8 +143,6 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
>  
>  err_pdev_put:
>  	platform_device_put(pdev);
> -err_fwnode_remove:
> -	fwnode_remove_software_node(fwnode);
>  
>  	return ret;
>  }
> @@ -155,7 +150,6 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
>  static void xe_i2c_unregister_adapter(struct xe_i2c *i2c)
>  {
>  	platform_device_unregister(i2c->pdev);
> -	fwnode_remove_software_node(i2c->adapter_node);
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/xe/xe_i2c.h b/drivers/gpu/drm/xe/xe_i2c.h
> index d63adacfefe71b3ae695987f104f978959a7e2c5..5969054a6b6b3f184857defd4ad3f6489f05aca0 100644
> --- a/drivers/gpu/drm/xe/xe_i2c.h
> +++ b/drivers/gpu/drm/xe/xe_i2c.h
> @@ -33,7 +33,6 @@ struct xe_i2c_endpoint {
>  };
>  
>  struct xe_i2c {
> -	struct fwnode_handle *adapter_node;
>  	struct platform_device *pdev;
>  	struct i2c_adapter *adapter;
>  	struct i2c_client *client[XE_I2C_MAX_CLIENTS];
> 
> ---
> base-commit: 5c4d4169604b335c38bbc79bc1fc03042981fc6f
> change-id: 20260922-xe-i2c-reapply-swnode-unreg-8e18b542549f
> 
> Best regards,
> -- 
> Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> 
