Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E7ECA5FCF
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:17:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DF9210E382;
	Thu,  1 Oct 2026 17:17:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="SKaY8LCt";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78B0D10E22E;
 Thu,  1 Oct 2026 17:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790875042; x=1822411042;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=vkznhTh0XJ/Ido/7UO7KE/NBesXtyVwlO3GdkRrIGfY=;
 b=SKaY8LCtVTUdB41xe0f8fTOW0LQgXp+rRCrsU48pAlfVHoNlr20zsz4u
 xq7FCxUwvHolapdaTTf/RNnVBQAGEqEsLYAc4BAN0nM5ULaxAq4LvYEAy
 SQTGVuOCN8hckEga+Zl7gV/XrvMA6lSV2qOVZAYvU380O+qSH661h3e1R
 DXMQbNV3LdZc9WAm9ikU8ZZZ+8181z04zQYU7L8DD7/eaRZQ+0Tx1PqKF
 7BEhHzxOHIfI3oh4wELLKc7D9f9ly2Mw10xn6FSh+ZOafu23YuIKNZvCx
 LlSjWIMnji24vaGIGcUR6gau2Ds0Ob6w73I+U664VpL51KQ4GiycA1xLA w==;
X-CSE-ConnectionGUID: 5uL8iJ0hREy3bX1R31DaiA==
X-CSE-MsgGUID: 4e+kobKTRx6U34t+wFQ64A==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="109126075"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; d="scan'208";a="109126075"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 10:17:19 -0700
X-CSE-ConnectionGUID: C8pTEAUDSqK9/2b62aQwog==
X-CSE-MsgGUID: ROJB5bH/SCK44OLswiaA5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; d="scan'208";a="305543211"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 10:17:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 10:17:18 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 10:17:18 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.17) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 10:17:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNekxV1ovDHU8vT2kM72HcN0+3plH3VGUg5UFHC/1bpnKs1V1R2pi00gfp9siM4BoSTmJL2e7n/OwjXqa9QA9gGngArbn++E7/ynkSniKN//2amL67uphU3ohYjDD6dPCNkSZFG50CwYTNy4S2PGJEcWtRsDhStvOteFsupO58KK7/z4jBA54EUX4scgtCfDOGmlOxDRooacSKN0NjSkULbis1ZKFacGfmDuo5gvgj5x0abngYkDsrnXm10N8ctISSNNY1Vc+hBbX4ygIqmcaogUVIyDyvqUFMK8ETqQrX3B+tksmp46J9JaFBg+oDO3xQ9s+HNm+BnJMc7BwRLysw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAcAXGs4f9PbX2LPm854uzpNPigHae7fGOLUzEWrU3Q=;
 b=m7LyJG2axyAh0Pt1PYErrBgdpQrxIG7sUqXghpkOpTrmJrOGHWacbW/vps3KZgY153JPrGs/y3eph2cIHwk7EsiK9tNN4RKW7Yofi2XVCwXZDJmsVDkO0vjfzkIWUJOjOB2DN+pwQeHttxdxDoUgZ7nJmhnl4b2W5EJaK/2kjquH5FkhgxgWbgiIE4knDMNaXpeWgaZ2TNicRnJjg8eOtggystN5TSBl5kEpZp2UtVqekpQEuAtRYWDwZislEY63xc0AkTTU87FROwatYjV8U/OmuA8jFALnFahiNsW8zEdO4tUrsgzy55liGV70r8kp4UkWCZDnYp2AZ88OadWVLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by SJ0PR11MB4927.namprd11.prod.outlook.com (2603:10b6:a03:2d6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 17:17:03 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0472.016; Thu, 1 Oct 2026
 17:17:03 +0000
Date: Thu, 1 Oct 2026 10:17:00 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Danilo Krummrich <dakr@kernel.org>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>, "Abhinav
 Kumar" <abhinav.kumar@linux.dev>, Alice Ryhl <aliceryhl@google.com>, "Anna
 Maniscalco" <anna.maniscalco2000@gmail.com>, Boris Brezillon
 <boris.brezillon@collabora.com>, David Airlie <airlied@gmail.com>, "Dmitry
 Baryshkov" <lumag@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Liviu Dudau <liviu.dudau@arm.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, Marijn Suijten
 <marijn.suijten@somainline.org>, Maxime Ripard <mripard@kernel.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Sean Paul <sean@poorly.run>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>, "Steven
 Price" <steven.price@arm.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 0/5] drm/gpuvm: two pass locking for exec
Message-ID: <ar6VjOgZYGeTsc+M@gsse-cloud1.jf.intel.com>
References: <20261001162001.3123877-1-matthew.brost@intel.com>
 <DLTNHRLY3O63.16FANFZDPKAPW@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DLTNHRLY3O63.16FANFZDPKAPW@kernel.org>
X-ClientProxiedBy: BY1P220CA0044.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::10) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|SJ0PR11MB4927:EE_
X-MS-Office365-Filtering-Correlation-Id: e6a8c4dc-2803-4361-dc3c-08df1fdfcfda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|4143699003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ewL8+dc/IIFO8Ph/gphmRwCXJUfMO4Spz8nSJW7+lZpLbhq0ugW2BDx4AcqG7RfHCA3Hu6OTr5rTuCGFlAxYqEc6j+UfRXrcUvL+ZZOdPhJ6lYQNAZw6fvz63nbdIHd3EWW51lNYmOFz7UvyjcrqBDTknUQNsdlIBafNkA0dwiJbutYBjpAGl7r+i3+8nX6S8QyKn0wePCg+AwdVg2xwKJEEP7enxBR9kB/WpnYLhZiEUB0K/oXlVSnetTXNrVvuHnB7LdWAlaUXvqrK4ZwqQUT8Rik7j2YYDUzRKTjPAOXworQCDcUd5XYgtCeIocgoXLH+ohgQxrspMoFMe42QeVLL2+54NFk9vcz8ar1QucvVyfr1VQhTiUznwWKai7zpoh4yGujFZ8f44eJmjeITQ+yDfZP1gmSEvUzo9nwUGnRh3TWAYW1J6h3XbJZcPgm4RBk5afvxwA/Sw2xM5uLZIMBkE8RkNmRMa7LhlYqlTfSOT2j6O87l2rYLfSlHuu/ty/92PYS2eIf+eM5mQ4HUflDrwP2QkdXHq2RqTnXcz6z3BWlYQ36bHbG2JwO1ghCryex49PFn/f/NP/6ACBPJnMok46+cY7ozw0hPf8oHBLGbvKq6UjHoOnCQMz6zdnioNoKEz9sXTMHFL6xS+WvdbFAjUKxsdH1gA466eg+L5Hc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xQEiX7gJ3DwuYQVqgKHQfzCGqTEwlJuY/kXCqaKhcOoQnI7QdzatHJeur8/s?=
 =?us-ascii?Q?1zcon8OGMlhwg/AHzTjpl06+tNOO5eujzoYkqsryH3W9x6mz5yex96MWhHZM?=
 =?us-ascii?Q?WhPlm6wt8NkQJPU0sGSOa46VS4YdECcK5Yyc5tzCdB6dW4joNly7+siBsR13?=
 =?us-ascii?Q?PHoea5XJNVLk/NlHSFRJgTGdg6D/UEY/dj5miauM2LXI5/8eDKZbrd7YWCR2?=
 =?us-ascii?Q?cCtdXcM4k5aM67lQVl9KhJ0yaETdpAyviZBfEulMDR9MguEl5yXb+/HSKz+W?=
 =?us-ascii?Q?1OI2UgqTv0zzbjsKnXNrZ2HVrn4edptoafEfen7Ec7jOQ+EIWRUkprfEd93+?=
 =?us-ascii?Q?wemkDAfh9QiAFNQee3wWLGg8xfrhuxD3nAmT+v1sZvAV0JQLumHrFmEnAXQe?=
 =?us-ascii?Q?mlfqxDo5gKLqARAmff4aUus/DU/9XfIJ6wbTisWMMqNVOzkKJJ2bCzhxYhuu?=
 =?us-ascii?Q?Z3QHIVLAju5A1l0PBqJYmdU9GpFh8bhe8n4coFAYz6mKcFm5lJ87LiefrSO/?=
 =?us-ascii?Q?mQL9/YYcNTsyeVrBgYUKQa/OD+1kmm2lMAG8iM8LTcGPWmmzwLKs/G/vHRXK?=
 =?us-ascii?Q?DZOsoinDHgGKNOGCe4Wek3n1oTIIpUA2/glEi6KEMnBmMwjfJ0MI01lP9lh6?=
 =?us-ascii?Q?AcNVOMR+DNaz/TZXyOCAb0vkMSEx3K7IGI0rinfPX7GyoVksOh0YXyg5WA45?=
 =?us-ascii?Q?YR73fH5S4EXdUVY03rM6na7ctVUT39eA5aMuChBsOtQQE1oPhxoWC4K5lNTU?=
 =?us-ascii?Q?Tsq2hpzpSNSkI3bQk8s8KiUplQ75jXKMPilOmMxx3pMkph83JPzQvl9FThkJ?=
 =?us-ascii?Q?Vhpi97r8xw6oWzOCocWV0LRs1T7Ytb+708e/aTnms6ZJF7N/av6NljAOfmA1?=
 =?us-ascii?Q?zKf5Ss68JeGNrwDWb/sLDxLRt0sK+wT/RI76Gi2Yp927Bh4lpIvf6Hzjerwe?=
 =?us-ascii?Q?AeWwblvEeqnP+9fgZ5lPTpRm0o0/WgOOzFOdxCeEA3MIF3IWGwbOhN8eY3Lx?=
 =?us-ascii?Q?UehE7CB589RK/6INhw6o0qfpgFYQWHP3Cdsl7STJqILZegGEnQJhnOLswcSL?=
 =?us-ascii?Q?Qg4WW8WFscttU+HOMtLe7im8wcMOxhhZLoSys0+K4PlH0Gr0kb4T7MB5I1u4?=
 =?us-ascii?Q?ajWFRRjQwSB3NHYhf+Nr7GHS8KcfNfiTGbsSYLA+h+cKpFKVDf3g9sq62fQw?=
 =?us-ascii?Q?KVluD/qxXlYEkIjObSMKDPMl3UByG8H13tQ2HuY7QZNm0uAAKDuuoE0e6q4c?=
 =?us-ascii?Q?6wpR4COq4Y8RBf5RKcIfzSgpM3crPOQ5h3G3fiHXw2gJmWZWgCSQktIZrRAs?=
 =?us-ascii?Q?ft/+Bq2ZUGKxfQxVNggG9FEg/52G0zM0fSPRgz+We8eU0edrnkwFoXG9U31M?=
 =?us-ascii?Q?Drkrd9cdgMakTtsVH6wTv7nueAzh67Z9K2nwMo0uvk5pqHMZQf1txZbVlwRw?=
 =?us-ascii?Q?1e8Q/7vUU8DiK9WynQMGvgmD1hd8D7o2yvJULmPHA9NuTuvuOm4wG+3UF2dN?=
 =?us-ascii?Q?xQ6VaKuKl3K7NccEkU7ve58IPWLavSPSAruQcv+wvQOy8rc7oG3nz9AEHDMs?=
 =?us-ascii?Q?/RVyIHt/ChQRtzdzXZQ6u9fhIzLravyQL4dbQvYbdsBSa6iB1zhf6pzPPz4L?=
 =?us-ascii?Q?omye/3HiiyjrSdxEACEjOF4Hf7xKTlkhhr+pUJo+OsYcMnnmyveLNMNgbLYY?=
 =?us-ascii?Q?hvxZORkhwcNuQCgjoZOn2eUg3ERUimiX/9pY9U5y62O7nB64z70G3JqoKc6N?=
 =?us-ascii?Q?WxsP0cyYyZhDou4Q0BW8g5y3a84F1BQ=3D?=
X-Exchange-RoutingPolicyChecked: MBgVTRDb7C9JbIuZmHHs3zP1Orgfj1rUHWYkqZppcmPQewwXdzS1YTJtNnsCuT9ucpUBahljY2pymmX/tySoj9uaHNfrhNkpaIbk2aEZDtF+aNoQLat9WpLAiizoLcegfpmNXsE9f6AkjfYnauKTdfMBV2WZ4HpYapDGmiMhkYqRiNaLH8wTHiGDONXalDR/8k/ENcP+2bVrFm2P2u5vdOgFm+MAUKYfeAHbLCpQ8Yt4Fl9VwLet/o0aqejcz2GrwZPiccxjhv4W6ERtktcTvzP4+9Uuc+39o53uCUwjwqgT/SklxEwXfS+tXdQdPNtGBgBfg0GcRQHh+7q8bRab3Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a8c4dc-2803-4361-dc3c-08df1fdfcfda
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 17:17:03.7059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AvuSnUo/NMEA+wPPecuklXNavI9M+HBf97f3u+rTLKEe1236f/UuP7LNsWOjtXZcP6QA7S8/pzFgNCVobL0leg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4927
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

On Thu, Oct 01, 2026 at 06:43:13PM +0200, Danilo Krummrich wrote:
> On Thu Oct 1, 2026 at 6:19 PM CEST, Matthew Brost wrote:
> >   drm/msm: use DRM_GPUVM_RESV_PROTECTED for VM_BIND VMs
> 
> That's great! But the title suggests there are other VMs without this?
> 

What exactly are you asking? If you're asking whether I updated every
driver that uses GPUVM to use a two-pass approach, the answer is no. In
v1, I randomly picked Panthor in addition to Xe to demonstrate that this
was not a Xe-specific issue. In v2, I added MSM, as Anna presented this
problem yesterday at XDC along with a downstream solution, and my hope
is that this series addresses it.

The original implementation came from a realization that this is a clear
cross-process locking problem. I've done a significant amount of work in
this area and expect there will be many upstream changes over the next
year to address related issues. My thinking was essentially, "oh shit,
this is a clear cross-process locking problem, let me solve it."

It would be great if MSM and Anna could pick up this series and confirm
that it solves the issue. I don't have hard data on my end yet, although
I can work on gathering that as well.

> I couldn't find a changelog for v2, can you share it please?

v2 - Is adding MSM support. The other patches cleanly applied with git
am from the v1 post.

Matt
