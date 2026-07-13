Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C597C44507
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:37:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E3EB10E0AC;
	Mon, 13 Jul 2026 15:37:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="attJZrG2";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 321B210E0AC;
 Mon, 13 Jul 2026 15:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783957032; x=1815493032;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=R6nyJ/BqbTsBFAFctaIqX5UZ8w3N2JaToHO9L7kWFsE=;
 b=attJZrG28yLAje/HnavtJM0HkpAWYIFZgNdIvuvJok/tSuEzTVS8sO1y
 m//OhTwX4UvxcDcTtGILPvVDjwNrng/vvGZwqRSQja1hFBDqKKlIg9sqG
 cMY5o3bxzX1ZcJvnvDgDQPP1ovkC67AH+Gs8jXu2TPP86hJ54xm2xAFSL
 goMeogyU7oqRN9awC52fLGnfnM3YzOzVpmgZPagpuQrvECxlNDfQ2Yfra
 mKvwFY9Iq2I1Ntm/+1q2gACJT0p961MuUj/6YyhmikjI5kcx7rhPTrThH
 A2GeWOaZ7aMnE6BgHMcgiU9iRewHb6ZgYLFpPooaURRzsiQK0aoXrZr2X A==;
X-CSE-ConnectionGUID: oxhHVIO+R0SyOy7CiG1m3Q==
X-CSE-MsgGUID: /GXxeP7uQzySSHVTaMIWbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="87111967"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="87111967"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2026 08:37:12 -0700
X-CSE-ConnectionGUID: U4A3VtJySr6HF3l+8DyMzQ==
X-CSE-MsgGUID: Bg3GZXBhT52miZtESrBG8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="252199659"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2026 08:37:11 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 08:37:10 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 13 Jul 2026 08:37:10 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.34) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 08:37:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNVZFoH+XWRkr/6NDQplxvvOODBgE4XCyg2ou6c+e382aTbBixziFHLp2CEBi6D1uGB8iKwOvwDw6PnWQiTOws/qL0Dk2rpW9DZ1vnyPnSTEXSKpMeF0GzcX7mxSABlLOa4AI+uUjozDpetT12fO5mivuoj+gNaofQo7+v3SX35J2CcdMwR2XIJrMHVjEaJI6f7BWmnGwlv3KrHJOw5LZclaeW4Ddexogzg0ZhrcohMhjnAjx4J1IMpLR6vA4tpPjDHRTftC9Fxj6FKZzbJvPjjMK/5Zp5ySwn+xiE5/rlhJVu3fugJGBCgiNh2bZhVrf61k8OxcTyWdNNoV83zcqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixyguX0JXaggF3tL8/Oaj3kXP2ugDTf5VB9wKh9AOt0=;
 b=nQ1ilUUca89MGOtzfszxyK9Wmp6rNlqO5VbuTOPUEfnJTZ/Zhxj1ahg7kQ/ql8VSbZUreXF3nbi4wp+Db5LWWWB4bHPf8xatczZRxR7g4URGhi55bSCFodkXEqgMRuAJ3O58DWZjBOmQCLsIcevFkkhRQz9qfhnuUS4HJ3IYexeVxwtNj2f1hHjyfSxj0PX9IVvX5aYrFWnWDnw1cZ7R71Br+eKFTKntUbOXqeYN0bDQv8VuHBLmmWese3IroK0hYfYf821ShPCpZSS4sux1WIDWpJAZ8zzwXEoba+ErGea9zFZgYaNJxPKEbvitqX3QPQTiu/yZpDak/hv/lkgU0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23)
 by CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 15:37:08 +0000
Received: from CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe]) by CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe%4]) with mapi id 15.21.0202.018; Mon, 13 Jul 2026
 15:37:08 +0000
Date: Mon, 13 Jul 2026 11:37:03 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, "Heikki
 Krogerus" <heikki.krogerus@linux.intel.com>
CC: Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede
 <hansg@kernel.org>, Ilpo =?iso-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 "David Airlie" <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, <brgl@kernel.org>,
 <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <driver-core@lists.linux.dev>
Subject: Re: [PATCH v7 2/4] drm/xe/i2c: use
 device_create_managed_software_node()
Message-ID: <alUGHxyN6l7awuEn@intel.com>
References: <20260713-swnode-remove-on-dev-unreg-v7-0-6d6bc448427a@oss.qualcomm.com>
 <20260713-swnode-remove-on-dev-unreg-v7-2-6d6bc448427a@oss.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260713-swnode-remove-on-dev-unreg-v7-2-6d6bc448427a@oss.qualcomm.com>
X-ClientProxiedBy: SJ0PR03CA0062.namprd03.prod.outlook.com
 (2603:10b6:a03:331::7) To CO1PR11MB5073.namprd11.prod.outlook.com
 (2603:10b6:303:92::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5073:EE_|CO1PR11MB5154:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cd405b3-a12a-416e-d8a0-08dee0f49900
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|1800799024|376014|23010399003|22082099003|18002099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: GMDLK3WnjVR5zkrKUuVSXGIGVNc/CPeCBnxcAhR34nKNwNF9lXBbSVDMeSlYbE/wqxKZ04mOL7nXHl28aks3vFjyVkL4QuF6a9sVd0jaBwbxi/OMNd2j/PG7kI0ei9Qld4OuPh5gst65cqewOhWOgPqn2mioOmfxlCqjh/qXIP/lVm5XmJyaKY4FoVJruXGnVHyeJn+stv/HKZmvZ230f822x14o3V/iQCeApHhFw+HxMKBK1Z7kEXcvHi3auGv5K4VaQfJdSMrkPlY0IGiLlZWGipVRNW2+tFlZvJwI9ywBdpMrCNqhQ/OFvHjWLtf6r8O8SeVGa7L8LumndlOlQCyIuKBtpZC3t2B4xXxbI/MqmYj6Qy6uIh5LbYf42Eh25CskERKRW+ouMdW5njEnLo0dZtqE7s/fRui1RUz0WcFpo76/q9AZjVxN2ahR6x0XskUvFKwABuchHhv5KAzHdL/dK3N6+C5NW3xqymo4lNLILI4EdzJw4MxoX9vqTCbE9IroXXJttOUWyYxHgg5+BSttaHAMMXqrFlUVx6EOOM435s1XH3Zf4BRxKEPu0Szxzxnw6th20tGeeA5qU7Le7RVeJcNzATHgdDjqX23GpS882nhQiqkHF7b9hxqcnkdDTFCrCKRzNQZkx5CyBFVObc5CjsWdPBXwVndM8O6bgdU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB5073.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?udwFqtaZZWPCeeLqRFoxx50xhM/DKz+i35ZdNib1dfvX7vHZuYE21dK3ct7C?=
 =?us-ascii?Q?qhLtONvMmnB44mLpVWKOkHKcJH/KEy2lnU9hGmE/8lRrroDDy+Zgs/Jei+3y?=
 =?us-ascii?Q?tYwgl+es8j3ot5OsBKwYhj+OC+o5wvv6wJZcnDITBqF/SfHWuacWM/Syagyu?=
 =?us-ascii?Q?1ssNDatTeGKNVHCJj+e0abvGVv3UPopXMaliwQ3Wxw0MmTN/EkS7herMtW0J?=
 =?us-ascii?Q?5MRJpvaGjlmuquBtDLa+EWmlFFJv2o8fVrwQd1YRSJAD2v5cw6PFcDjQyezd?=
 =?us-ascii?Q?pFpmiYs0Kw9yqSujZ0HXy4GwDfdZ2IHkD6O/eRVNYxyw5o4/OMN/+SxEO1zZ?=
 =?us-ascii?Q?Wj5MVLiskh6XdaNEpSG82tqtdImJaa5rBizIG6JRr3cLgpWZIFRxBGXCDqya?=
 =?us-ascii?Q?PNTXMtdA9z5vvaDZF/r7CsjnP4wEBja093HBroLBd/8JxYqD285fJf35+Q1+?=
 =?us-ascii?Q?p5hXazqshDZSna5qaU7ga7j1UNJK1BajpmTiQIvrvrMRBYLbDe+Eh2XSI5Fs?=
 =?us-ascii?Q?MX3aFYcTRvLshxHvgPCJwrzR67vU6pWs2C2zbYugFuzlWi7q5gsnPWPMR3x2?=
 =?us-ascii?Q?KE/Kx+sxR2ntEQa2enBZXoPYwnT39M0/X3TD9wJ2L9xdromQ485TmqYGIM9j?=
 =?us-ascii?Q?gh+5TiLLZbrwPO0hnopvTMj26z6XrVy4JTe6OpYHyoG0FaOo/lEgZ7xibXPE?=
 =?us-ascii?Q?q8iiufTd1sEZGycQEThwXbSMB8Mf1IQ/cow5XhtSEhm8PdcHsnMgHFU4kEyQ?=
 =?us-ascii?Q?0/ErHahMizWfBKBRv3BPRVAg6LpYQ86wxIJhUcN1+wprgKSBubUO7rU6q/IE?=
 =?us-ascii?Q?y3l5muF7jICzXWG8G6l0bWZ2/SBUWEpXbcAF0T7lzGJnMEkZRvqVagVo6A1a?=
 =?us-ascii?Q?gCGPipQ4q8g6qtoKe70qmkAyT98i3upxp0C7Omss5a+zLNg+tIsLuxaKiI59?=
 =?us-ascii?Q?fz9VhFGR64ptBPZwP9JCEoi7VpYFIjZ5F2qU2K+bwiR34cp4QfAUSM9RqE/C?=
 =?us-ascii?Q?KG0ItDY7SG4x2qxdLPmAOV4D4DiKt+l8cGOVjP7suQyXsjCs/SDO5YrVUCiR?=
 =?us-ascii?Q?iK4rg1Ne6XcHyXZIoMLM2lGJPFHHHdpH2QGSEHQfsCsSKyERfpKKGmWjZsz9?=
 =?us-ascii?Q?FK2D+i7ZSNtG/WlbqWVLt2HBTpWTDtKaJv1MSU73qD8ZR+5H3jDnFEZ9q2tt?=
 =?us-ascii?Q?3jttRhBCdMJALrwd0Vp0HeCYctUGcHUUC2rBVQYiEw+L6/k0u1RgNy9uUQLs?=
 =?us-ascii?Q?+h3iGH/aEFLYIE4F5lAhNhFVQfg7O6WFCStTWjeALuW7FQPYur3wjTDx77Ab?=
 =?us-ascii?Q?gvq5MSkGcnG+08p2tdu+iY0gI4f7LEv6loPSuxbKsgwPD9U5f9Qwl/xxwbfc?=
 =?us-ascii?Q?+ZxdZqw7CviQuuI83V8+h6gJqjbjB0hZ7Q4YTQ5et2Xgsm+ZTNzAeisVpiD8?=
 =?us-ascii?Q?0eJhyPRhsMQ9oaZ8Aoc0Gi0beRUhMaZrkfNEKf32DHHn3mSeoZVxfNjmyLEc?=
 =?us-ascii?Q?0e1+UTQNRivUaOCo/4CdQLP+7nJ05SYobo1FalOeDvCE1oFKSNX4hmC11G+g?=
 =?us-ascii?Q?p4vM2nFAZypqElULFnPTndSMa1q5K3uStX00KKrcJsThtwQD2TbeH76afsfN?=
 =?us-ascii?Q?hHp1XNb4RteY+dzEkg3I59rW7oSmAN18M8soqjSYM1uBTBI+uPwg13C2RoOe?=
 =?us-ascii?Q?jiZvdPRaPJsxcgqpKReT9i4+u0TuHmDrPqbU87eC/HF0p1+xV/CxX5467/WR?=
 =?us-ascii?Q?wMIR8Q9okw=3D=3D?=
X-Exchange-RoutingPolicyChecked: LZ69VE0cR8Am5owj4cev/CnYdNpUeZDPYTq56TgWKYO8759xpEEdSlWv0aU5D1UrvrlOwdioZk58sOgZMN13OgbAeNLSflBDWECnI30/CgMOzVcyUf5NiEGTv/ZqlYx6NGUJx5NNlnUUwTngpWf0YLXj43yiQoWNaELATzY3iTjzOHF5XW8CogxBV8j+2Lm3xAy4bJMYFzzW4ARdh6im5p6FGp3bH6aCSOJBnjOhYcgWHNBoBLBDJ12BFptYxY3RtLYb7qtkQnxKPQVTt5w4cR1HEiW30vBDPAvaBJ6WCFcRbQDc+vkVQrDeYtkEyNSbIs0u0JEtgd+PqcmMiRBjAg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd405b3-a12a-416e-d8a0-08dee0f49900
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5073.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 15:37:08.2737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OSMFOvtC7IBVNFtw7c8SlPGKq5TViXqp+rvQYs7Yo6U+I3p6bjj1VWd5WC5Vpcr8ds/tvE3HDj59eEkwCCfHig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5154
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

On Mon, Jul 13, 2026 at 05:11:58PM +0200, Bartosz Golaszewski wrote:
> This driver intentionally uses the fine-grained approach to creating
> platform devices. It assigns a software node as the primary firmware
> node of the device it creates. Ahead of improving the reference counting
> of platform device software nodes, switch to using
> device_create_managed_software_node(). This way, we create a dynamic
> software node whose life-time is tied to the device to which it's
> assigned.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/gpu/drm/xe/xe_i2c.c | 22 ++++++++--------------
>  drivers/gpu/drm/xe/xe_i2c.h |  1 -

Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

>  2 files changed, 8 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
> index 3d80eafb9a1318996d10db11e14af4cfde07ba55..af6e973e5e68125a9c006bb646447ca6e377a6e6 100644
> --- a/drivers/gpu/drm/xe/xe_i2c.c
> +++ b/drivers/gpu/drm/xe/xe_i2c.c
> @@ -93,13 +93,8 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
>  {
>  	struct pci_dev *pci = to_pci_dev(i2c->drm_dev);
>  	struct platform_device *pdev;
> -	struct fwnode_handle *fwnode;
>  	int ret;
>  
> -	fwnode = fwnode_create_software_node(xe_i2c_adapter_properties, NULL);
> -	if (IS_ERR(fwnode))
> -		return PTR_ERR(fwnode);
> -
>  	/*
>  	 * Not using platform_device_register_full() here because we don't have
>  	 * a handle to the platform_device before it returns. xe_i2c_notifier()
> @@ -107,10 +102,14 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
>  	 * platform_device_register_full() is done.
>  	 */
>  	pdev = platform_device_alloc(adapter_name, pci_dev_id(pci));
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
>  	if (i2c->adapter_irq) {
>  		struct resource res;
> @@ -123,8 +122,6 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
>  	}
>  
>  	pdev->dev.parent = i2c->drm_dev;
> -	platform_device_set_fwnode(pdev, fwnode);
> -	i2c->adapter_node = fwnode;
>  	i2c->pdev = pdev;
>  
>  	ret = platform_device_add(pdev);
> @@ -135,8 +132,6 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
>  
>  err_pdev_put:
>  	platform_device_put(pdev);
> -err_fwnode_remove:
> -	fwnode_remove_software_node(fwnode);
>  
>  	return ret;
>  }
> @@ -144,7 +139,6 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
>  static void xe_i2c_unregister_adapter(struct xe_i2c *i2c)
>  {
>  	platform_device_unregister(i2c->pdev);
> -	fwnode_remove_software_node(i2c->adapter_node);
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/xe/xe_i2c.h b/drivers/gpu/drm/xe/xe_i2c.h
> index 425d8160835f4648891ff75f2a9c06284241710e..b28229f056c5a664e1d41dc0cc1978782fe1c2f1 100644
> --- a/drivers/gpu/drm/xe/xe_i2c.h
> +++ b/drivers/gpu/drm/xe/xe_i2c.h
> @@ -30,7 +30,6 @@ struct xe_i2c_endpoint {
>  };
>  
>  struct xe_i2c {
> -	struct fwnode_handle *adapter_node;
>  	struct platform_device *pdev;
>  	struct i2c_adapter *adapter;
>  	struct i2c_client *client[XE_I2C_MAX_CLIENTS];
> 
> -- 
> 2.47.3
> 
