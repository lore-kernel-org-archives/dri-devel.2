Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD2FC53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 22:05:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB08410E5F4;
	Tue, 28 Jul 2026 22:05:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="X04r+lDE";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0E2810E5F4;
 Tue, 28 Jul 2026 22:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785276346; x=1816812346;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=1ulvnnJlAbf8YAqn/mOOiYw2LNDVw/+WjJ7BDjgsj6I=;
 b=X04r+lDE69lpbhVXPOZO4o/6g84G0UDCppoeeoxH9kzZwT0cF+pDow0Z
 VC6xvr+Gfp4WSEgbYq7pCJux/PWT6wDqCJRkzJdu+kM3QrkuuZcJh3zEr
 dfVeNArr6mYc7uHLIybE836sSRoezB+79QSV4UzyKFH3P0UZFSphnbztB
 JeLjtztKHIq2WuIDZfVvdpZEsIwp6oEcgAnFsZb+9JFhYko1FNwJf6egi
 /+rxP7RSMxtd6CkEH1zh82+Ft53VdR1md3WVMgVQBRYLF/uyuAmwIAUPC
 JurJNnjl56O+dzvVwFV/C+qF7Da5j+n3CncL0GXWpuqOMWlVM/r61gPnv A==;
X-CSE-ConnectionGUID: Kn5bynaaROyctfl8TEFvGw==
X-CSE-MsgGUID: OFyIiyhZQHiPdlASbC2Wrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85003085"
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; d="scan'208";a="85003085"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 15:05:46 -0700
X-CSE-ConnectionGUID: vZWLUlYGTUWek7wzXhm3zg==
X-CSE-MsgGUID: PnAqZzoJQQONQdxmkooZ/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; d="scan'208";a="289782785"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 15:05:46 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 15:05:45 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 28 Jul 2026 15:05:45 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.7) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 15:05:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+UTgfWsZAjJocijLzH2zW3XeNJ1p3DNwre6zD3vripSBn0/A6I90NBVVPY+5GcYKBAlbmkDMVhAi8frc95Hr91MbJr28L3loXQI+EmuM7nBC1cEsr+44yM8uez2tElFQdV8VpaxveVEpfHTK56WSmg4oQQB79ksa+D1352dcUE8F9suZYDwKjLo1/DZY17l11ZZm7g92+f+juDzH4vyzxdBWkPlLQZwZJJpBGk2xdX3F8pYXltn4jUZCyqZeMmw9OJNIS1UMvaWPptbgCHN6mwJSUg3vAONWZidHOlNUsnaJfKHIcC6WgKOm/5hT34+QoPVP7bK3I8/XhpHBm6+vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spqLgG7EaM+cOOkSMJX3AWoYS7+uO1GwDKNNy/PsVBc=;
 b=K5LWuR9zkhek5mwuwyD5y+XfvRsDkPF8fFnO3u/DnDWdRXM05J3IW4Sk/RNGJ1gF/g/DjYyYCWYD7z/RdwqFhDBADf2IIoC0yEhu5Cyc//lgiGQ19GqRUxGc6fm/idDypRxtjk+EZ9zdKpKmvqT0wzlI7hnX7wkGMrW4CEbNDGyFsWBzX+w9m1OOo3EnP5gY9YRI5JXL0mleJVOAvAx+gpH7QiN0LAFgQy04ankg+CEyCGNfDsBTeP0b+BiiDTq3XFm9iWGquS1081kixxFoMWehJ+ju1Tyv9kxapfg6sBjImCLvHMqoFkCLxScKRhzxUx8NIykusmraPOLPvzIL7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by PH0PR11MB5079.namprd11.prod.outlook.com (2603:10b6:510:3d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 22:05:42 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 22:05:42 +0000
Date: Tue, 28 Jul 2026 15:05:39 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Arvind Yadav <arvind.yadav@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <simona@ffwll.ch>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>,
 <maarten.lankhorst@linux.intel.com>, <himal.prasad.ghimiray@intel.com>,
 <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH] drm/pagemap: Reset migration page count on eviction retry
Message-ID: <amkns0g0yHlAKbpr@gsse-cloud1.jf.intel.com>
References: <20260728090304.1264759-1-arvind.yadav@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260728090304.1264759-1-arvind.yadav@intel.com>
X-ClientProxiedBy: MW4PR03CA0332.namprd03.prod.outlook.com
 (2603:10b6:303:dc::7) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|PH0PR11MB5079:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c04bdd6-a204-4278-1ea6-08deecf45d92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: jWm3kof1IWQyTFDzmZ+vnZJeYKXrocVG0Quq0RFmm7TfRIggmFuGaHa7WEnzp46ZPqXGrTDOXal0e8Sb/I3SIgohUMA6qEcEgS94Lv1fkp+v5rwoQfb08nEBMvaI8kkya1rv/Xf3Fwiw0AgGMtYHRFeWsYMocgwjT8sMp93KaLwoABhRziEhQui8Tx9niBah/+2CjX2b6/TPw86IMphx/2+crQpCUQ37BuXq/bB1uiQtdPnYuA8XRNX7d/XckLtYs1ma4xOgPaNqHKT0/rSMvjr3hwG+rZrlz6Vhpc2r6afMxapNHWPXXuX3abxtx4a+Mh+Gz0CUeTG0txjuMJRum/ioXc5TNf3FfFW1OnScaRTSn0L2tNEvmE3N+FCyAv/qTqHv05klXG3hPRSR3GGlsKI6T2j1YRJ3jbc9EUcJ+9qa+8hHRZbKccFroWFUFmImxCT80RbCshGa6cD2IiDqInQ7QWLexbCOYp0mcadKyQK+DflJzni2s/bf/4L+PF8rq7gJD/mC37HCePkXexvrsFCEW3hdS4h9FqLKjpbjvtF8jgm6yzaseKsYDa0LLKHhP0N/Mp2jPxWzTtSd57hCt9ldlC7P/KqcXOKJM07+FVQDVYb2iiHOFgYFORhEHfJ82G2vwtz4kiqH5Ec88IusmBrK2vULNQPZJLXLefOgZtY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?znlSX8uZXnMZXTi9dtr3QhPW6vSgqGu2drljjxMP48j3yhFt35ZqvSCUMV?=
 =?iso-8859-1?Q?1ntoaiC6ZGULtld5scd2z7tQu1msdLg0G6pB8AtApOeCnxrvn2nQLZ+XT0?=
 =?iso-8859-1?Q?PZvbwxcJzzqS6OnP1kf37PZqMGSK67N/FiiD00IiMZlvLTZTHSFT9bMSvr?=
 =?iso-8859-1?Q?jLjLOQ3Ilkwo1aqU5+lX/SDQ0eSv0Fjlg2HqaU8Usiu4hxbiKSMhxXfzew?=
 =?iso-8859-1?Q?JkvZ9HZFhv+9c/Uz/qvA8FA2BiMcVZejX87SGpXFAqWq7Li6y7PWIwitGV?=
 =?iso-8859-1?Q?P3UziS7VtCHymQMaG5iSmYVVztxTBsqy6xx0AnQM64j22M26d/0hV1ySIY?=
 =?iso-8859-1?Q?LAKKeZT9kePHuR0KOnGpUGcBhybBAw707YWrR+CVcSxKg1q82cTEfxTKwT?=
 =?iso-8859-1?Q?eIEkZAdgl3SbopiQUQ11EEiZ0EUlqKg54EeaB+xTJvJdyw9WdgicwPjviF?=
 =?iso-8859-1?Q?Bks+Ht/C0j3U772RoFcFYJP/ezpJjyIcLTATBe9Z+cxJJrWEHEca64545m?=
 =?iso-8859-1?Q?pY0u//n5MdpWOMu5bY3pSB03nO9ufMf59G2Ct5Kt7tBXEP3PX8kqMS+wrR?=
 =?iso-8859-1?Q?6chWFDdd1ShoFqSH4imolFmkn+WrVWmehl0pAzwLhzBvMpPeTFbHXNlW7N?=
 =?iso-8859-1?Q?erR8iHhDlzZzwt/32McjLlMVYsE1CowMxm0W+9WGuyod5TpOEqE+q8szyO?=
 =?iso-8859-1?Q?rSYeV8TwJxoCCE80tzIBEyxdgjY2RwMuovS4FELCpFccWBP77TmLjFCz4g?=
 =?iso-8859-1?Q?ST7poZVdxl0tn5nG1u3boELF8wDBXeqvDVQlzQKW88NqIWMI67YK9+9ypn?=
 =?iso-8859-1?Q?O6CrCrthNBzJAW15rJOv9r6VQqHNjTUR6wzTZhsOex2jPHpWkst+4OdPKv?=
 =?iso-8859-1?Q?FqoKloI6Gt8cw660rqe3Ra7wU2ewSzp2y+fmEBEXtggqniBhAwLqjRNbRT?=
 =?iso-8859-1?Q?1vNP/uuacYPOwPpWy76KNkpJ63o7ADdwVorMmCymeCDmRXzkaLvEOwzXYE?=
 =?iso-8859-1?Q?RSnLy3P/GWQYSdohffUgwAXt++MLn6s2xZGyHmIqHgOFGG0gNIjnwyt1AQ?=
 =?iso-8859-1?Q?linyEfev4IEO20Oi3VsH4E53/XVJjvAI2qHndKl3XF/tIp6Fw+ljF7fVuQ?=
 =?iso-8859-1?Q?JAAgchxNSoWFiZwEwaT3ozReAUZ/ZRkS2fw7LSeSMQeiBHqiIn+jAMuF4x?=
 =?iso-8859-1?Q?rS6L8as7ITwEyH8/G3AIWQU1JCSuLXb4JlCcp43UyTmxGivxd+VTjCvkIr?=
 =?iso-8859-1?Q?Ah3RDuNPdK+2wMLLBiK/FRqb5KoEyaVl5wESkqc0cgso9eqqj4hsDYgblf?=
 =?iso-8859-1?Q?on/AGrdIZIh1CsmWwnDDmpG4kU4eV0gFsDKgRG2EIlWAV0hk+jyeLBpuj/?=
 =?iso-8859-1?Q?F91a83zfVAP76McUueaA3ljJYizvtGHDpWzkQttFx4C7cDheWD7j4y66AZ?=
 =?iso-8859-1?Q?pRTw6BPiVDSIU4U4apz1mMhABCuAmhL2k3MhZv2t7anwFw/O5LhywGBJdK?=
 =?iso-8859-1?Q?FGygUxDx5g3uVwlty+439of1eKDMdJhOp/2tGFZCk9c63UPFfjUZ5D66k2?=
 =?iso-8859-1?Q?B9NwvAyUkQLU6RyYBFIU50fN78Qa9m2cIIem1JwZNvlsdwtb/kR02VuZQy?=
 =?iso-8859-1?Q?jzhtGimUmq5T0c6o6VqwLydNz/xqx48xImioNnBUMYk9v7wPBOLiHWXxGZ?=
 =?iso-8859-1?Q?ufzMfra0blXGVLM9MAGrcmt43CGypRbkpZq5Np5JzvftB7nUTzDl3ih+BR?=
 =?iso-8859-1?Q?2/JSdnVtYad1TcMXMtnKLttUh8s6L+Kfv0OaGI3s20ma7tZabOJfS1Ckju?=
 =?iso-8859-1?Q?UaoCKKvzWf/z86t7QRqqwerDA7VgKVM=3D?=
X-Exchange-RoutingPolicyChecked: TWZAIAIbmaK17/9yi6a8iz0AJXNsVl+nVeQED9cac2/6nFsE6ANal+UjI7AEmuhcibhIzN9rGbXO2FsljZWXvfbMnA7yH8vqqvp6kjEq+WUISB9aYSV3BeUjMn1wVQNMF6GTjFaXa2iXFuOZK72Jc0vGCkTyR6m1eBnsaMdFdnAjKvW2ckWyFxKzANlTn/1YOj7ZnzBDgphZ/BxNqVZg6s42b8dmlOjOu4fVbxguQ+6yX67mlZA9x5VHUmhw9BfiGWhQyWu6fq6iOlGUT3F2I6r9kHY9CXD6zS7qgl+yUpEQHRbZeMC11ijMJWGhHtCpc5MlKiX3JuthDS7MHCiaVw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c04bdd6-a204-4278-1ea6-08deecf45d92
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 22:05:42.4687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y8RSzOlVkhV5Rnls1EQnmWx8vWkcInKiJ8IiJvBuXDjvP/4Shmi6esgb3M9SXURHlPgZ9TwsUf3ZhNWED+X1Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5079
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

On Tue, Jul 28, 2026 at 02:33:04PM +0530, Arvind Yadav wrote:
> drm_pagemap_evict_to_ram() may retry eviction, but mpages retains
> the count from the previous attempt. A retry can therefore continue
> to the copy path even when no RAM pages were populated.
> 
> Reset mpages at the retry label so it reflects only the current
> attempt.
> 
> Fixes: 99624bdff867 ("drm/gpusvm: Add support for GPU Shared Virtual Memory")

I think you also want the patch which moved drm_pagemap to its own file:

f86ad0ed620c drm/gpusvm, drm/pagemap: Move migration functionality to drm_pagemap

> Cc: Matthew Brost <matthew.brost@intel.com>

Fix itself LGTM:
Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
> ---
>  drivers/gpu/drm/drm_pagemap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> index 4a794544b7dc..7faba4acd59f 100644
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c
> @@ -1122,7 +1122,7 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
>  {
>  	const struct drm_pagemap_devmem_ops *ops = devmem_allocation->ops;
>  	struct drm_pagemap_iova_state state = {};
> -	unsigned long npages, mpages = 0;
> +	unsigned long npages, mpages;
>  	struct page **pages;
>  	unsigned long *src, *dst;
>  	struct drm_pagemap_addr *pagemap_addr;
> @@ -1133,6 +1133,7 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
>  	npages = devmem_allocation->size >> PAGE_SHIFT;
>  
>  retry:
> +	mpages = 0;
>  	if (!mmget_not_zero(devmem_allocation->mm))
>  		return -EFAULT;
>  
> -- 
> 2.43.0
> 
