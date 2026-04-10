Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1631BF45A08
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 20:02:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CEFB10E1B9;
	Fri, 10 Apr 2026 20:02:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ey3IrQ2w";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D518B10E066;
 Fri, 10 Apr 2026 20:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775851326; x=1807387326;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=WH72gzxzQoh8OMaq6U/WuePz9nZ+cp8rER4gATdyiVQ=;
 b=ey3IrQ2wbhdgFblSDPLrljfXdxPQaPOlRrXqnOE9Cjpukw/HzTApwT+r
 8y7v0JxRNiI0A7KokYuQdsDel6DheHX/iqh47oNSpP1YJbUZov85KFjgd
 Py5PlAfbaM8ur8NBWFanQg9DMH/hMmWoYT1fvAKIZCLVRa74TqjLeb3oj
 FgGzv6iRdMwUrHOy0WRvDETgt/FzOQ7RUIMxX8Ry1IAOeyjf7BOH8pZaH
 j6KOMX5GtH7DC1N1Sd2wl/hYJrLVIexwRd/gg4J8cCkHrYHyRw7hF/tvn
 lJOz+tAamRlE/beGBQyFLIpCvqNkiruAfHdGaeFkAL1TYhLTk++nkFsFh w==;
X-CSE-ConnectionGUID: v+Qak7EOSXOET/wwinSkdw==
X-CSE-MsgGUID: 0GbHLfKvQ2Ky20LdmMAkfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="87507553"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; d="scan'208";a="87507553"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2026 13:02:06 -0700
X-CSE-ConnectionGUID: OmZkwax8TKmc/JaWQFPJPw==
X-CSE-MsgGUID: HWDRY3NjSTmOuMNfO1lzNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; d="scan'208";a="233244692"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2026 13:02:06 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 13:02:05 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 10 Apr 2026 13:02:05 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.23) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 13:02:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P13Lo4jtYlAqz4/4TUdNHIivsRR5Ll3c7sGikZR41T6EN3X/kYmvL9A35YiHcJR+KHD3JPLquMjrRzaXLdrCaUNsopsGjTXghOv9pIgAa5rZRvCWbDcDeaOlG/fE4wyiVQ1NEHgwEsUB8cZcUU6hRo6tZzJ2Ce12+PM/KG8skkbB7JbQ64g/8okWk28OIptGLSeOfFcwpYzEpSIMA4ZFIjiXI2WURx6bstlTmd9dyBhkvA08CnJihLWqHSz4NH4FppJHH9ag9hc5EYQX6evGpP3nyorxrxo/t6WKxSXPSIIVjxBrjOl5dUA7MoVh1cgFOGh+SztXCoj8o5M73BkGSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJ/CXgnfITS43+1l73qhY+h+wV0KZjwhiR8SmQuvxmY=;
 b=WblqywX4iZ6SONrxcDuvXTxriBUpCgArqWNSKy3s3H3DQXArfqKF11dicDW7LZ5bDL686QNTw7RU7xVCw1y7zuTgZb0EfM4F9Gk2/VvmRXNRrECwjz9ySA3zLvBARsD/+B5J97dhJ0kC5ewYj/BGzw7BbihEQKEE3lbfSnPCWJcXUhYJcBe9MhEIjaimRQ6r5ZyCn8XWjFYAhP+byrDpWELzs/bTZpYZgOEegM1m7I9O5Ov5kqow8d+QrZu4+fL2MF5J3HjRMFlDE3on3Eyise0XUqPq3mZg914EjVtiyGGSbt8+qAambW+mj8ohCNYuP1gvNkC+l8mAaelgCs+svA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by PH0PR11MB9704.namprd11.prod.outlook.com (2603:10b6:510:399::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 10 Apr
 2026 20:02:03 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9769.016; Fri, 10 Apr 2026
 20:02:03 +0000
Date: Fri, 10 Apr 2026 13:02:00 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Francois Dugast <francois.dugast@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <himal.prasad.ghimiray@intel.com>
Subject: Re: [PATCH] drm/gpusvm,pagemap: Do not assume DRM pagemap owns
 device pages
Message-ID: <adlXOEreUjrofIhc@gsse-cloud1.jf.intel.com>
References: <20260409015512.3670302-1-matthew.brost@intel.com>
 <adjxPkmE94e1dybe@fdugast-desk>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <adjxPkmE94e1dybe@fdugast-desk>
X-ClientProxiedBy: MW4PR03CA0311.namprd03.prod.outlook.com
 (2603:10b6:303:dd::16) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|PH0PR11MB9704:EE_
X-MS-Office365-Filtering-Correlation-Id: e3670401-5015-46e9-5e61-08de973c08ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: bL6HqsPJ0kinDSJMwhk9b8ioo2RGp5R7Nqz8Sml46H7dl1XiG4/NpKMyby5WFgfKhxVQsqmws5NSxF7/zusGrDde8zg5e4FSsFTzmeEyIPAVZ8y+dxtTVFocIl+zZLo1my2rbPVw8gdjw8O+YuH13oJKB8yGlkjjqxDBXvcKtaswl8V3A41fh8CW3eW7MrpsD9JZjhdcfX/nirUKE9aZ3dDyOTeYGxYwj1eT7KCm1Ya/F7koOCOcgzXs7oThI97X9BgTJw2dWnfb9ZpF1nMHT7xHT4jkpTSMEXk14eAedE9MsxURi724cg14MDsOpC4qHofrR6OZfVla5mkrB/pj1IkPlHKoG12dl3ge+X9bHk/U0Zcl1WUP4nLZ4Rhv+cgDMa0qXrbBVP9LHpDhDISDB84zGTL1wLjs1mPS5c2mNbOFWi3LeCo1QxpAcVK6Z3SLHi3ZYaESXypY4wemYkZoVA8EqInoRVY/r8pNJBVAQI7u3+l7QTtzuTJZqJ+3Oz4v5X154I88NhR01F8DRczDCYI6oaz5zZBQVS/53CAP/FGyueFJPl8jSwmgEznyjWnrDtI3Z4a81UMXUo25uji+W78KCtXrkPBQaDg3QVc4ucUW0df3GysJtivpqbHejf38NKWNpXFlx95umqvSvjjZVLvsycUF4Ja4/elFQvOfbIu7dCXfojGeO3qNDkcnPgGQ8u/VybaFYL84I8s9dwQ3xLqTPRvoFpTM/dLvRljl/RU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR11MB6508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DOv9R/GOlw2SQFwEPA0FTtjYJsnKQBqJ8cLRqt3T9Uw5dxmATg8p6IFGCXpm?=
 =?us-ascii?Q?72sLKMGRsC3GsbIitEa+6q0gS0rWToVKO4MgiVhiKVXx5WfO5GrC0hfb17t+?=
 =?us-ascii?Q?7YCPqdildFeSEvxBNAjHHwvPJQvexj76hHnB0SSmZk6lrR4/wMo3iGKxBpiK?=
 =?us-ascii?Q?kj0kiIT3AAbVVx/2ioRn/XqdooB/UgW6Dnfo2vff8xd2Xpb96BPicr9Nnn0F?=
 =?us-ascii?Q?YNC+7/4FE97Y/0gsqjsPtzXaAVqC7RnkkDd3twHnAF2kEPXePKSOlBmtarU0?=
 =?us-ascii?Q?0r7ohMMCzfJyJkwZn0x45Jedygh5wDZK3K+Je2REM9QsLEWAOx5oZLG8Os11?=
 =?us-ascii?Q?uKesYSLzZEMCe/jlQV3tyksgROUEK8LwBR9d0sYNSyQYPTb3DMwsbkwUdxiX?=
 =?us-ascii?Q?g71nlEScsVJoFjs0eSixJEWt1DnSJDwuAL0YJ/Ha1mbFzUxLYtfA2mWx8FrP?=
 =?us-ascii?Q?qNCrIXnmmD6jA7rL8tTXz+HuEVQJltosBvRnyAkJMO+5Y7E0ODdV0VPfk5kK?=
 =?us-ascii?Q?OS94Cjw9/TUCW76J81RSCu8o6C3g4qRqUws7hpw9ssJ/ZSoeC1jPhIhcXbB9?=
 =?us-ascii?Q?29zflx5wZzdhQqpRMx82XyMUlslhBYwPHINxjh3236pfZMeqzJoi1wQGbpA9?=
 =?us-ascii?Q?ZcO5VLSPnlcbVFMUdPbwz2G3j89p69amsC6kwV2Cgme9+OMm9R61O/uLYFCF?=
 =?us-ascii?Q?yhcEu8QB7nrI2a8thL/OaDvg01cadawIzmHTIwzGIH6lmrlVgjHW8ddOxXkx?=
 =?us-ascii?Q?wzH860vDQzGnb1wh+XcblEmdVSWxW+NPnz+DhrS0NrhZ8aKelYbSnfaIi6cf?=
 =?us-ascii?Q?iNDXTyBWSrHpa0HGVKLciGf9Aky3wEDkww4gKGsy+CjD32GGKs/Hcp5K7kfc?=
 =?us-ascii?Q?MmqCMADVAkin9PYA7EYdfZdz1oyXnTczaeOEXEpdT4P4e8eOKR0VkRBb31FZ?=
 =?us-ascii?Q?x8iDKzQd8r3GTmYrsCQ84pv2Anh9TlYIOm07vvnQ7u6OXoiqbO9bC0q1ur9Q?=
 =?us-ascii?Q?ztd6Zv+Pq8vZUc8rKWgzpchdUi6I/Sd4LOLMUaFweOQXQz8XnJHcqgvaZZ2M?=
 =?us-ascii?Q?8vtb3+b6UoTuKtGmo5YKSe9JrRuOvZ6VgYGvHKl4yexYThb6a6jiZ7Fd+tPF?=
 =?us-ascii?Q?q0MIpotZMiYisVyH5YJ1oyEiFvHVQDN/7ZNC7oUhX8S4eRaCHZW+x1fHvDXf?=
 =?us-ascii?Q?Igiw6zUA5ksKK0EbhMZgR8RXDTSB3Q1E8H6iFLsgXjdQB1tXZPI6lzszHdIv?=
 =?us-ascii?Q?mpMNPZZmgzEUUjjGH2M5QY2iVxhsWisenAJJMdUpksk2xf3Ailt2N0wqUpCV?=
 =?us-ascii?Q?vr4DDQ7lywLwrEdzIxxmRvCOB/QKT+lPsuFE2Lt1Y2HnCIlwm8tM+YVco/gj?=
 =?us-ascii?Q?wieiZHzPYMeFYzGi+/1ARA364QuMqCkXMz20mwbsyMRFLmV2TKzl9Ac9O9Nb?=
 =?us-ascii?Q?tWurjHMVx7whLfypiYRi0eKrfnLJRokWAyFHErvsYoXnHvwlYwj9UGceCjru?=
 =?us-ascii?Q?scI1bcWEMbJivcm1s8ZTHJIOn2cgrIXvgITvwQhMOgF8t1d4YJ+AazupLm8w?=
 =?us-ascii?Q?epfMsrpLLX7DQSfp0i8cyfFKydszPi8rADqhA4/Ks9ANYUhEOI1RlbGmIyrh?=
 =?us-ascii?Q?ZoH+fSeyXNGrWPtpV87Usl66jviKqq765g+8ph6bG5Szx92DgbT+GTrBdqmd?=
 =?us-ascii?Q?VTUrqIREgcjdClpxE+JiGh14EG9Q63296ViPnX07MndstTlCxtdP06jqGwoH?=
 =?us-ascii?Q?pb9F7e5y1A=3D=3D?=
X-Exchange-RoutingPolicyChecked: YSbdclncI0Q3SfddR/Kwx07vcn0kjORPghYYd9A2/kVZfKV82TlqwkgvI/vsl4vca/mT2/wItkNMwWVBYVS+INR4PJq/GXXLvCY5Vcz5ZaSR+eUy7yovKsbpQeEbBAdsMQ5sVVSzilTKYhiP6eWCXe6ao+w9dMnARfO3Rpw7oMFgf21LIM8MAt7NIwzvxhOrAo+AUfOnLrPBfwM/wuHgDcaCNJ/t8KGSyjTqv8QeOeF+kH+81jh4oeEr97A22SHcLoYGmuwAPTQq3xJuCeKEeCMKEnUAUpKB/QLKo5sXsek3/Puv6Nod7qwKdj9oMgd5RMaGeyduJCL+WeiCiRnZLA==
X-MS-Exchange-CrossTenant-Network-Message-Id: e3670401-5015-46e9-5e61-08de973c08ca
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 20:02:03.6747 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UFQZuSwYVRhvMufxj5QgVPKLyPaRQr+yJ3sdFPpG3phvp79ZbrwT+CbhHZLQg7pVEnDKKM14yIm9a3zQtcYcgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB9704
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

On Fri, Apr 10, 2026 at 02:46:54PM +0200, Francois Dugast wrote:
> On Wed, Apr 08, 2026 at 06:55:12PM -0700, Matthew Brost wrote:
> > Update drm_pagemap_page_zone_device_data() to derive the pgmap ops from
> > the page and compare them against the DRM pagemap ops. If the ops do not
> > match, return NULL.
> > 
> > Also harden two risky call sites by checking for NULL after
> > hmm_range_fault() or migrate_vma_setup() when migrating to device
> > memory, as it is possible to encounter device pages that are not owned
> > by DRM pagemap.
> 
> Shouldn't we also harden other calls to drm_pagemap_page_zone_device_data() in
> 
>     drm_pagemap_migrate_map_device_private_pages()
>     drm_pagemap_migrate_unmap_pages()

We sanitize prior to this in drm_pagemap_migrate_to_devmem or are
operating on pages handed back via populate_devmem_pfn.

>     drm_pagemap_migrate_populate_ram_pfn()

Operating on page handed back via populate_devmem_pfn. Also wouldn't
NULL ptr reference.

>     __drm_pagemap_migrate_to_ram()
>     drm_pagemap_folio_free()
>     drm_pagemap_migrate_to_ram()

These are in the vops path of pagemap we check against.

>     drm_pagemap_page_to_dpagemap()

We sanitize prior to this in drm_gpusvm_get_pages.

Thus all the above sites I figure a warn is enough as it would indicate
a fairly serious bug in drm gpusvm/pagemap/calling driver which this
code completely controls.

The case where I do sanitize - after collection via hmm_range_fault,
migrate_vma_setup, I think it could be possible an outside driver has
moved pages to private (very unlikely) and this driver also tries to
move, so abort rather NULL ptr dereference.

So basically mitagated the 2 risky places with sanitization. Ofc we
could check this everywhere...

Matt

> 
> Francois
> 
> > 
> > Suggested-by: sashiko.dev
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > ---
> >  drivers/gpu/drm/drm_gpusvm.c  |  5 +++++
> >  drivers/gpu/drm/drm_pagemap.c | 14 ++++++++++----
> >  include/drm/drm_pagemap.h     |  5 ++++-
> >  3 files changed, 19 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> > index 365a9c0b522a..b3cccd047a21 100644
> > --- a/drivers/gpu/drm/drm_gpusvm.c
> > +++ b/drivers/gpu/drm/drm_gpusvm.c
> > @@ -1506,6 +1506,11 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
> >  			struct drm_pagemap_zdd *__zdd =
> >  				drm_pagemap_page_zone_device_data(page);
> >  
> > +			if (!__zdd) {
> > +				err = -EINVAL;
> > +				goto err_unmap;
> > +			}
> > +
> >  			if (!ctx->allow_mixed &&
> >  			    zdd != __zdd && i > 0) {
> >  				err = -EOPNOTSUPP;
> > diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> > index d82ea7ccb8da..95c951c5b569 100644
> > --- a/drivers/gpu/drm/drm_pagemap.c
> > +++ b/drivers/gpu/drm/drm_pagemap.c
> > @@ -753,10 +753,16 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
> >  				own_pages++;
> >  				goto next;
> >  			}
> > -			cur.dpagemap = src_zdd->dpagemap;
> > -			cur.ops = src_zdd->devmem_allocation->ops;
> > -			cur.device = cur.dpagemap->drm->dev;
> > -			pages[i] = src_page;
> > +			if (src_zdd) {
> > +				cur.dpagemap = src_zdd->dpagemap;
> > +				cur.ops = src_zdd->devmem_allocation->ops;
> > +				cur.device = cur.dpagemap->drm->dev;
> > +				pages[i] = src_page;
> > +			} else {
> > +				npages = i;
> > +				err = -EINVAL;
> > +				goto err_finalize;
> > +			}
> >  		}
> >  		if (!pages[i]) {
> >  			cur.dpagemap = NULL;
> > diff --git a/include/drm/drm_pagemap.h b/include/drm/drm_pagemap.h
> > index 95eb4b66b057..9b7c50932db5 100644
> > --- a/include/drm/drm_pagemap.h
> > +++ b/include/drm/drm_pagemap.h
> > @@ -367,12 +367,15 @@ int drm_pagemap_reinit(struct drm_pagemap *dpagemap);
> >   * drm_pagemap_page_zone_device_data() - Page to zone_device_data
> >   * @page: Pointer to the page
> >   *
> > - * Return: Page's zone_device_data
> > + * Return: Page's zone_device_data if owned by DRM pagemap, NULL otherwise
> >   */
> >  static inline struct drm_pagemap_zdd *drm_pagemap_page_zone_device_data(struct page *page)
> >  {
> >  	struct folio *folio = page_folio(page);
> >  
> > +	if (WARN_ON_ONCE(page_pgmap(page)->ops != drm_pagemap_pagemap_ops_get()))
> > +		return NULL;
> > +
> >  	return folio_zone_device_data(folio);
> >  }
> >  
> > -- 
> > 2.34.1
> > 
