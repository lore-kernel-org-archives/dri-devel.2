Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65486E98FDF
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 09:58:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7AAD10E749;
	Thu,  9 Apr 2026 09:58:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mroqNveH";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D006E89798;
 Thu,  9 Apr 2026 09:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775728725; x=1807264725;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=0jN/qkw1QT4LecEgCaXlEjGgb4HiVZOKu4K9a/KN9mw=;
 b=mroqNveH86h7JgNZxm0pHAbY8QbUFB4R0MkXv2Ar5bzw2VNWhSEU6JLN
 wmh1LUwuMevOqjLpmXwmRN078z5OVrYleJOkSrADNxx4ZNU06Y53Cl2HB
 ZlnBw6E/vBLbJ3mvOwXyanM82HB2SzsEEdyaVkdkUc6rHnX4dtKn8rIey
 gK21Fw3zxd7a7WJ1pgms0j5ckXaNRVl7wEF2Dx50Y0D1ibl/oZHip8rpT
 Mrxj8C/NioXQInqAD+7pHVSqQQiT5CoLb+wc6GD96Xh3jTwcaFoL/cHC7
 Jz1UQi8HOXNlHUqjiPpVGxBxsmAeH1YVX8xtidWUHTRpR+6JwIFE9Q71v Q==;
X-CSE-ConnectionGUID: x48mAK40QxGeW+V07YiZsg==
X-CSE-MsgGUID: QwJeGsZGQyaJJpZ5Aufljg==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="94309253"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="94309253"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 02:58:44 -0700
X-CSE-ConnectionGUID: 5ByIQPmPRxyKjqxpqmosWQ==
X-CSE-MsgGUID: 0/Rkvh/UR0Kj239+Vitasw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="233622936"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 02:58:44 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 02:58:44 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 02:58:44 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.16) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 02:58:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MA9O6XRWL+rlmlVrCxx3NX/EgDKpwIaVf5dzFKxwX/yjVHGhjzJE3/LgCtr61j0ZTPw2/OrcrODvSFA80lrFKzBXq6LgRprK3WLBe33Bo4qhxXSblBhO4++EDyw5J1gi+oYcC8LGOKVIHMj5UbalKhWuj4gMp2YmIiXNfDbUdosSM9mECP5Kic+pa0lUK8KsjgecpEHV3uwuqQ7fydQJLpcZWxcEnBuxNnAhZYiVKtbsGSHCK9uhDhHEPZgReUFrCtKBszQsfGv17A/xLXayHsVprIEnajIuCYqDDrpzz8RKX6gjnD3n5woFnrHUwoNAxW+qrfCY4YgToC3rubQhUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ab+6HoDW2t8aukNQRBqs8VvIAhzBRMCIYyjafLBjolo=;
 b=ZJ9e1jDIAPMjPxLcIGlyV/trn6QRPoXEnhnf5/aJdlxs4XIMw57Z/F4ZZkp6eZk6YBP/qI0ugAXF6ruTS2m+hLquYuXUDUz6jF3+qjkHpLulhAB6by5mC0/X7n0P9dm2rN/DT+O0n81vI36D8gNFgZ2VLEsOR23YsybfMdUqdEsD0jpIC6JIeukQgW47ZY8pfZD09fpFAwWlaKnSfc9AOjlGEX3SVQrKCLaHmXPaACoZWcMaNV658zNvO86+LweXKKzGIAiPkq64es1KRCMZDNCdiI/CUlVNFqb35O6f9U1JO2Y7aJ2y1gX27sHhA5W0HS9aH2EAjesARvYKOq97FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7828.namprd11.prod.outlook.com (2603:10b6:930:78::8)
 by SA2PR11MB5099.namprd11.prod.outlook.com (2603:10b6:806:f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 09:58:37 +0000
Received: from CY8PR11MB7828.namprd11.prod.outlook.com
 ([fe80::1171:db4d:d6ad:3277]) by CY8PR11MB7828.namprd11.prod.outlook.com
 ([fe80::1171:db4d:d6ad:3277%3]) with mapi id 15.20.9769.020; Thu, 9 Apr 2026
 09:58:36 +0000
Date: Thu, 9 Apr 2026 11:58:29 +0200
From: Francois Dugast <francois.dugast@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v6 5/5] drm/pagemap: Fix drm_pagemap_migrate_unmap_pages
 kerneldoc
Message-ID: <add4RSnGEnTy7sz1@fdugast-desk>
References: <20260408201537.3580549-1-matthew.brost@intel.com>
 <20260408201537.3580549-6-matthew.brost@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260408201537.3580549-6-matthew.brost@intel.com>
Organization: Intel Corporation
X-ClientProxiedBy: DUZP191CA0057.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::8) To CY8PR11MB7828.namprd11.prod.outlook.com
 (2603:10b6:930:78::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7828:EE_|SA2PR11MB5099:EE_
X-MS-Office365-Filtering-Correlation-Id: f2bb0674-a6c9-46a6-28c2-08de961e9171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: MB8qBvcXG7Pz0gxWFTa2YS25Tt+IpHlwvLvF+0iS+kos/93JmlDVDdnCgYFP1RkDXwUFKfO3ozw2ZyQW/5kVp0tkp0FtA51zpusTL3DfFRQxc8kh9YRem0XBVeF1pyPEC9CAdhz+z1z7vEG+zLrL1SjiAkgvpepat9zJ6ma/8tn9BNzD9C0TvkdNanuInCFVtAFGp/UpCXj8Gtq0d4KvzFt+OilDl6ISUlVgAHZCud9N5a0GHKv9QVk/XmWTAWS+oWyhy7kcN7774ZKD27BFzu1IRTEirXgCiPVTuy1NT9rWiZEXPI6xftyss15CM6xYtjXsOqvc3GqDuIS0d0fx9aVHoMH2BZMPltBDn1R2RzQ9BqrFvxDSHlYgXHVu3mBpeIFGeTBjF6syfNRDu+l6gdukH6vrhu/hoUqIRgLYVrJxdC+diVbdVKoHZNfy1ytdJI8g7hBomuePvKunK4G9H7LnQ91GKrjACyP4YQWjiGwavPrXl106RTnAWJjLtaa7oR6tstlD3VTTGDD0DidaY+iVh13bSmIkPTMgPTX5/oTomFbN8yJtl5KJqGGadHQm3fJ+swIlAdtiWpp/F97Vgac7797LX85SFLhLKPeBpctGcLm8iIgYz2jf8xiALFvZw7UhbjQVM7nkCtlNHM+RLLqS426A5VcE7SSEhPBnkwCRXA/UWmGu0AW7s4C8v56gjyVxHJ6zMIHmn2Bx5h8SFbtTt1558M/oBVKxf7D23BU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7828.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TWZC+GozkmgesAMRh02qYtMr5pMULZHTNcmIi8YyPsonx8FIbdUeQPpWphOO?=
 =?us-ascii?Q?G07AQPSQ8jJ0qesLef6fice1ZJuwilqkc7Na4g0pPw67SXk/XlfATVbh3z7m?=
 =?us-ascii?Q?+E0CqLXu4b92zGmDPXC5W7rewM512qg35GC7HhIzJL1VJ3F7gBFRTbjMVbcN?=
 =?us-ascii?Q?HFtU/uDwsSlIcOwYjsWZlEg6KfN4OHXaHsgrQ0PePCFowLDMs8d2PNEOis94?=
 =?us-ascii?Q?yE90/sB3dS6fRaFnWpwUNNY17q+GYMgSXD+2XpRFbW2+jC8YkWdeYwmNY1SR?=
 =?us-ascii?Q?VJdfivyBaUj2XI6MynKu9M13MkrQw7mJZTWSwfObKbG60eXtiRaFNjGmdOT/?=
 =?us-ascii?Q?xlcUxQvgVjw3lXZ7OagrAzx47hy+dYuBD78JyCo+FjxiyKWSRXwdJV6Jd9jI?=
 =?us-ascii?Q?0R0VX+FQvsvmneV30CxIaGIKGKx1J3YJh4BoW4ptP0zMWa4fIzLezdXA/tLJ?=
 =?us-ascii?Q?rmJZbdwvRhtO82JkkUMp7vtrSVXBG+YyBxJlhdGbAN4jkwl4j8wUUAEcThhS?=
 =?us-ascii?Q?FI9yQP7te2J0xHVnO1e/J44+IheWeeb+T54yFlSrufly919NaGZe2Juoqx+4?=
 =?us-ascii?Q?qIAQq7cKZjOKIeBFGJ7TTk7S8YM2MIy1kns59kS15JgqBO1wgwbgcrptvepM?=
 =?us-ascii?Q?UiSLK42XRELO+zi4gkwnqgkMFzX4jViK6fuqzBnIB0s0D4NA0G8FA6LAm2oU?=
 =?us-ascii?Q?hBYnkV+iBdlP6c3jDA4fjTE3yYRy9F6Vc09HkDDpYZENY4WdekOW598GoVFj?=
 =?us-ascii?Q?lNVpMqRQgEcgeACoZivy0OKVYWdUov4uPAVx1cRtt2tdrqHjtm//R+b+HvT6?=
 =?us-ascii?Q?AA6sy1WiX9t1O1XnOkFkJPL+SXXh+jljDXWA4s++YHclBGeyimI4X9sIBOfd?=
 =?us-ascii?Q?ZDL9YqTltIFgsoTIj1OVtmvrMo+lwcAsCbuTPISj9rxdc3IGa3B11D9oKaMo?=
 =?us-ascii?Q?2LSgIA45dn7w5oxk9Z3KcEA6FaBy22pJFXcv6wPP+BN8AYbpKW7VkedKAzwX?=
 =?us-ascii?Q?HrrdRn+pJsOLynB37Qu+d4e5y5fScj1AdrC6SyacAaceXTLsjMsYmdkx3z2V?=
 =?us-ascii?Q?BfikONdOnI/xXuq7P8aJcq1ha6fg/RADW+agQjAh147dTTPP000K09f0CRfU?=
 =?us-ascii?Q?zs8sRBdH69/vPz2hq8di5OaHnGxBY9rR8nzJorS/YlgG4CXrud7LJNvCaEY1?=
 =?us-ascii?Q?I9xyBeEjOCxJl5PYJF6dGDU8QvcK7otg/qiQINPMdLQAKZXdPLD2kc+jSLoM?=
 =?us-ascii?Q?JzoN8lRXIgRoKocV9m+AJDH0ogdMCQ/Xu01yIpNy84pb7Be2vSzwERt0JhCM?=
 =?us-ascii?Q?qDVOy9s8DAeJK64d4rRQpR7a72Kh614tost4EBh2AJrbWIa6BpHcraWOQfY2?=
 =?us-ascii?Q?x23aLl0wKmjjGUrOToPa3GvdkW3onoEK8JhgUx3Yt0zkWBAzjXke2PcQ2y9V?=
 =?us-ascii?Q?MfUNGR+Bm5boZXadxRf6Go65AQIZF/1gTKA9aqre3KoUXzjA2JvuaxwvbYPo?=
 =?us-ascii?Q?cXN1G0ju7fgZhvZahxVoezW+z0Jc+U6EvvA7HfbW8h4YgaRpfLKVgT3+zcbk?=
 =?us-ascii?Q?NL1+oVF9dZqAjax70lGjpSh8Bsl5bT4m8jNRSPN2C6GHxzRijmGBluEsEMTx?=
 =?us-ascii?Q?50Ixd8PiH79eXq59OrYaV2cPuiHNICAfpUMbmmeHBxHuv30R4mc5+WOAxVYP?=
 =?us-ascii?Q?3oz5plqDgZhcAcIIYevygYLPfZ4/Tb8PzXwHJ5hDb9Vrx4JAblRMfLaiqXx/?=
 =?us-ascii?Q?gawNGTb2aocSTnzBZ2voQclNqVRBB4o=3D?=
X-Exchange-RoutingPolicyChecked: ln+NWNQRYYgWDwuPxwghD85mJWeygJZmtPjgmoIhRut7oeXufgifhZLkQaGArFirxa4pEkhPhPjuVTeGzQhQANbzHqk9V2UsAXGzzQY4nCMA9X6A9vPTfe0IgsO19h5mpowYAAK6cgeCMODdUXJpVcUp8rHfSsx+revx0AJohnMBY2kSKrtPa7w/ESSlInmf0JXAOJ7um6fTgP0craNEtehSOp+OsNBfhPLIP0CPvNHPeHUr0tnv2QbFdnvH5MAhDmj3M05Y44T9z/3CkLNkGuspis9sJn45Vmpp+dOnZUR0EUgEotg3edcakapnkuXK/mIYshT8He7L9N0fwuIGmA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f2bb0674-a6c9-46a6-28c2-08de961e9171
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7828.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 09:58:36.7593 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 22ejf8IYktzelNBhVtIRtKzVFyaFca2hFbxAik9v+mhMH/sQpBmtw70zwROS0g3bMuuHD2dI826yjoR0ktbVJNiHxW8g+/lKuwZ6pyqsd7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5099
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

On Wed, Apr 08, 2026 at 01:15:37PM -0700, Matthew Brost wrote:
> Replace @dma_addr with @pagemap_addr in the function documentation,
> as @pagemap_addr is the actual name of the function argument.
> 
> Suggested-by: Francois Dugast <francois.dugast@intel.com>
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Francois Dugast <francois.dugast@intel.com>

> ---
>  drivers/gpu/drm/drm_pagemap.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> index ed62866b52f6..172e8e81a71c 100644
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c
> @@ -397,8 +397,9 @@ drm_pagemap_migrate_map_system_pages(struct device *dev,
>   * @state: DMA IOVA state for mapping.
>   *
>   * This function unmaps previously mapped pages of memory for GPU Shared Virtual
> - * Memory (SVM). It iterates over each DMA address provided in @dma_addr, checks
> - * if it's valid and not already unmapped, and unmaps the corresponding page.
> + * Memory (SVM). It iterates over each DMA address provided in @pagemap_addr,
> + * checks if it's valid and not already unmapped, and unmaps the corresponding
> + * page.
>   */
>  static void drm_pagemap_migrate_unmap_pages(struct device *dev,
>  					    struct drm_pagemap_addr *pagemap_addr,
> -- 
> 2.34.1
> 
