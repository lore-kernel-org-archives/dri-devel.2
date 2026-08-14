Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C728C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 08:53:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E7F010E0E9;
	Fri, 14 Aug 2026 08:53:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GFGpUYde";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC78C10E0E9;
 Fri, 14 Aug 2026 08:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786697636; x=1818233636;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=PV4sGQ4N7WWtKktIRkxHHGAreVhvWFdtHX7UWrf7eb8=;
 b=GFGpUYdeRjlKnIOLE/yno2Hs8zq0hhcnOeSNSBLXLIToqfJNxm6cEwye
 mfOF0Gxq/QWkRCpCxy9IFA0D33VFL0vwTbo6JKLmVQIRhI0MyJc3H0L8t
 Pjxq4MAPQnX2gSv8hFuMXTnaicgdN7GCKS5VY8HIrerB1263l/xGsIWTg
 IakrvuxY24MtPTbUGObwa87Crof4qSII9jMPrSHaYkduFPC91Wy3VSxFd
 paKx+xVRHj4NyDQleXe4VlCTeBi96MUFuuedOy9jLICNo7jDx5GGhrJa8
 vEaOs0wUbYDaXzg7iAsJPb/0nyjfG6ArP3twUF2V0MoHvp8j/pKBBpUqy A==;
X-CSE-ConnectionGUID: NomfQauURziBiJu8BRvcKA==
X-CSE-MsgGUID: P7REcwVfSFSCdHzZw3XSLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87138403"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="87138403"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 01:53:56 -0700
X-CSE-ConnectionGUID: dX8MYydlQcW8BPnWgz+q8Q==
X-CSE-MsgGUID: fnyq35t/SA+mDVj4PUJXiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="287650847"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 01:53:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 14 Aug 2026 01:53:54 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 14 Aug 2026 01:53:54 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.17) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 14 Aug 2026 01:53:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ghclvIsEIvzk5d/XsCM0lwYEnLQLzlXuulUjxg8S4jzTUBgQtVUbCPO3i6bPuf/7BX2ooY+h0m19ZOXovDldUy17E8IHGSR2voINWI8u03ISVmPPgv5s122/TXCMQI8Vt0/tU6+stOF3Xecj8JEQ1Yw8I3qM2uhRC2N7BBElAfueFld5vzCEStMzLScP3VPLiEBiniAXQnvVnF3oP2OS0bQkSd/oJKPOjZu+1J4DfPf4MU5+CQujUrghcDxZquZRvAC2D6a9wT8HdXX2M4hqigs1ewpY2NeO/Ey+quMnEqZy9Q1Xoh6iMc6VdobiBaaudh6pwYoGLIHxetQI7GfnLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3bYGclMGkbx7dtvYgoCEH3cModBDpA6lbe7lV8nTas=;
 b=CAMGvm9Op+IqBD9vqy7e8inJhDmFlM2+7DHj+vaiUrwor2KpBuCq6rma4QayrRJVhOD1O5FLxAQhDRr1z4vmTGr3yD3TGvZ4rh12CnZFpgn4Dd8FN83qI2Wlk+Ira6s/V0dl8czn0PsHShKnq3EeRl2r2m+UWrNgrtocKMBqpdEt/4Hs6gTmMbRp4pOYrrAX6tDz8DsqHuj9rG2bYQXKVV04+YQeSiycW6Aa8+Yh2tiMryEcwO6qcSmAnVP+ZJgQ4pNhmZ/SanYIXKnaQ/IsXNDJebNVKtB0PJTZxsL4g4QitlCTUZ7TSEjt0KZTpL/B1UX0A2nmGgpwYTGh9BQmUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by BN9PR11MB5321.namprd11.prod.outlook.com (2603:10b6:408:136::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 08:53:46 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0315.011; Fri, 14 Aug 2026
 08:53:46 +0000
Date: Fri, 14 Aug 2026 01:53:43 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <kernel-dev@igalia.com>, <Luke.Wildhardt@proton.me>, Christian
 =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Danilo Krummrich
 <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>, "Pierre-Eric
 Pelloux-Prayer" <pierre-eric.pelloux-prayer@amd.com>, Vitaly Prosyak
 <vitaly.prosyak@amd.com>
Subject: Re: [PATCH 1/2] drm/sched: Do not restore unsaved virtual runtime
Message-ID: <an7Xl8fpejcUQfvH@gsse-cloud1.jf.intel.com>
References: <20260814075739.32481-1-tvrtko.ursulin@igalia.com>
 <20260814075739.32481-2-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260814075739.32481-2-tvrtko.ursulin@igalia.com>
X-ClientProxiedBy: SJ0PR13CA0224.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::19) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|BN9PR11MB5321:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d9d0157-24f9-4006-162e-08def9e18cd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|1800799024|366016|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TYKgATRz88c75e0U9V+36IHLkrVOalNPYpy9MOQAA8UZyAUJwd/4ryAKGamvu80STi27D0Pn5gc6UgVEnhY27qW4XZoro9EesJvZK4AjI+5TQtT24Yqehaqf1YX/rIea/aLYgJ6/6yPLXDCziuzIJPuzMeEGi8gIpwjsnGKmov2IcULg62E04PVvs8zrwx46n2Pd0BylMEY5gpcX7ZQ+BkMvytJPoy52xiA4npb4UPyePKBb9qbM7Nf085KBrbY9hG23fM1T0SlNj6vEv+ndNQ8Yg0AaTij3vQrVTrSrxiZa3e7jzrUon0sEd+ebG8IW/VyvhIrV9ClXZNogBRK5NzzXC++xVEIYLR9iXk2tDHrO6e5eUBp5KYFPkrqTlTmz3ppL6YxpgtGdkthWuRiYYf+QfSjQgmdbbt087BV7tn+qNa3xh6M1jJkS/lA34oxFHcOpwp5wbLtLwZi/S5Dk4w4NUP/TvzHUs+4s5qyuoD5+Gj8INRSIDnp90w3ejIGeH1RsoMpYCS//lU3YxFOm+LLwFtXOATZAVBqedhLqIDD5iPva9UC0oPTCH1px89l8wcp+dyBsuFhZ5QJGu3rxBhKHS9CBTTE49IQ5sUKgmZWO9Duy3qfBz7I34MiS1JxcPel0bs1yvLyzCbLphMI8DF8WFKWJrndcsZFNdavKX3k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?TW15c7Y7w07aveJC5Aodeyyhx01kKJr2bYTt7Rvf5BaScy1AOz2nVpc7R8?=
 =?iso-8859-1?Q?Bmv/axOYhvGbhaZjr6HKptCR/U2lSz8/DyRISvpQxy67TbEfWRz/10vkzT?=
 =?iso-8859-1?Q?V2rKafTKtePQUbvk2ewL7E9FK3K09pdJdJFozYDqMy9eCTAABPCmRwgOwO?=
 =?iso-8859-1?Q?SxZfnqRU+nUtjVgPqr6xrKwybS0i+2Lu524DRTcI+5OWlj6sy17y33Il0o?=
 =?iso-8859-1?Q?szPoDEz+Psz+4BReKLkyLxx70N9WxgVPUcBxNY+byUKus2Z9B5JDG4aeTn?=
 =?iso-8859-1?Q?AGZNBTpB34IffMS+XIEoiGAlUMtfFrTqI94zVbzMbyvitHqbkG7VuqACCg?=
 =?iso-8859-1?Q?NrNe330VHoes9iEvhbrVSvdzJnFI0IHs5uH4kpdY5q0xxUzEsQpyjD0e20?=
 =?iso-8859-1?Q?7vvgijOYdcvPvDvhJQrotqcp4s9x43ysU3JrQc85LihOKP7wOKRKdj7dIW?=
 =?iso-8859-1?Q?rMV9oFH41L6quaDOHT1hBEcbAqnkV7rMZA9AerP21nXMQo7jqvWzAyiJd+?=
 =?iso-8859-1?Q?kQQsEGNmJQKZj3RGzQwfa7IhebMiN3DBHhRw/NTgh7LFulNiOiM/1S5lBx?=
 =?iso-8859-1?Q?58LcicScSXpUXjacZk8GpO8SOSh0txl1rDyF3GFv3iXxb/RXVbXBXa13Om?=
 =?iso-8859-1?Q?/z1jJzD9BKN7hT2fovS8rVL8JoolqHaAsgblc6pBw8syh31nejK14WCNbE?=
 =?iso-8859-1?Q?TUYMrxxo3KWm88iF7+ms8Abqmt3soPalOsVZk0PqhBH4yNIj0XVaHZJ97m?=
 =?iso-8859-1?Q?CpmOYyN/tVUTzvmywQwdO/ew2XJgyOySJbRbmwXZQah455H92hk2746y3o?=
 =?iso-8859-1?Q?LKhRfNSzvhMD6zRiYwcgzNAo6o3fYzMdWPeMH+C48or9vvAskfhBnFOW3I?=
 =?iso-8859-1?Q?56SxDWIyAKxhPdSGpFlValD+as/Rt+Jch3Nl7+K94Ow3CGv9wGwqBlne7N?=
 =?iso-8859-1?Q?2Oqy5ieN/boLpIcDj8eNNOICz5J6IS1GQ6nLJQSlZymwFEjw/5QDAm7ch1?=
 =?iso-8859-1?Q?XIw++digOknHMcFMPPM0IZEN/M+KNHhGPDHsdQs703I+FfTHH1G4APbGw3?=
 =?iso-8859-1?Q?siK/WmulLz5qMOxE8HgCl37rcOQI/VVcWbfanf4ofn9aWAAbmIg1sXf8yu?=
 =?iso-8859-1?Q?ZIqLlrlGThHcDjGcHrBTmZXOy4aSu+sR/y2lJvaZw6CVU9lk/JMEJMDIqS?=
 =?iso-8859-1?Q?oSLPOR7T1nc0MywEKv2iXqD965ju2Em46lrnateII3Q3VkHp0RRwLsKRrr?=
 =?iso-8859-1?Q?n5p7hJFzFOuN7hKm/XXWctBulte6ghWhpuX9RO0it1iw+6wDXprh0yLdwz?=
 =?iso-8859-1?Q?uH68v+vPAk8zalAtLmjIrt+MKzzGNd9+4+LHp1rHZege4fXT7MgPvgQbqO?=
 =?iso-8859-1?Q?GJLfA2M+S8p8GwOsbe62YV+EXWumk/dbnEm9b6Nd8TXyD4IJprnVenospc?=
 =?iso-8859-1?Q?CgL5hzuMhdYwjRTTEbw4a64+HPcCCWUFqJBxlFr0alEHd1zr1NpSG4Ilic?=
 =?iso-8859-1?Q?U7Sp39R43YxCbf5NCnYVMwSj0dm3/KmZCaL7ZH+My570iImwXqCWeeGetY?=
 =?iso-8859-1?Q?WhyYi9raXBQ3Z5z6WmNpORDQacIQSK1gQaXg/BVZlNj7TXSSIuG2dz9zbH?=
 =?iso-8859-1?Q?3tZMOzWhj9pEmGD/L6v5FeEh5fNwq4bHzVzddOSYxde9q693gjNdn0DCRy?=
 =?iso-8859-1?Q?K+dCLp4s/qrz4IBrTIsBRKxE3Dz6EVU39WidpmgJrwv418MIZcdLn0J4PD?=
 =?iso-8859-1?Q?6pqYVNnfnKR7wrbM+pdOdXNrrnhZC3ABH/+L4hViZa9kGR/cMbPjTS5ZvF?=
 =?iso-8859-1?Q?gB3d7+qEh91W97hK7lyIMoAvBGUQSPE=3D?=
X-Exchange-RoutingPolicyChecked: FqhbXwsYFLBHISPOl+fAXnFdSGTBi/sh1Ye5Um0842t4WIlK4Oq14q+sk2+ZHAY8NlSfO5D6wmN5oLaA2uTPw0Sx/+8mIonGNvYDHwRx3606ZuAljBBfxIKxmJ8xmOZyfJ4kh0x9A40VTBGeWw1Xv+/pBC8RoHBxuCrHteK1VRN6+GBtwbHZRphOr6mGzje3DvZyRDOLgutNTk2qVvemhKAb3G4OiP3LunORtnxmjomAT7YOJCsigWMpPPom9JZFcMPtGRxYVrdbBN91hulILMLE42/lA8ZiUZgsK1JhXfV7dzIecrxz0pNsCT++vIWiFERZ3u4/QGBd3PXCUNfWlQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9d0157-24f9-4006-162e-08def9e18cd5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 08:53:46.1150 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OQZRq7jTydxMz/qL9tRkUZKDt7c6OMdfcnKf7+3M/bd3TSGZ/Pd/rDfGMh9T4JYk/8JOH6to6s02H1kbAsq3bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5321
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

On Fri, Aug 14, 2026 at 08:57:38AM +0100, Tvrtko Ursulin wrote:
> Prevent pushing a new job to an entity seeing it being the first in the
> queue, and hence entering the drm_sched_rq_add_entity() path, if the pop
> side in drm_sched_entity_pop_job() has de-queued the job but not yet
> updated the saved virtual time.
> 
> We do this by pulling the locked sections out to encompass both the queue
> push/pop and corresponding rbtree management.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Fixes: 2fa4d8e2c109 ("drm/sched: Add fair scheduling policy")
> Suggested-by: Luke.Wildhardt@proton.me # via Claude Opus
> Tested-by: Luke.Wildhardt@proton.me
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Philipp Stanner <phasta@kernel.org>
> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Cc: Matthew Brost <matthew.brost@intel.com>

Ugh. Idiom:

"How much longer are we going to keep polishing this turd?"

The revert of FAIR IMO shows it basically time for a rewrite, cough -
DRM dep.

If we can agree, I'll prioritize, if not we'll be here seemingly
forever.

Matt

> Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
> ---
>  drivers/gpu/drm/scheduler/sched_entity.c |  8 +++++++-
>  drivers/gpu/drm/scheduler/sched_rq.c     | 20 +++++++++-----------
>  2 files changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
> index a4a7efdbf229..673ca9cbf362 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -559,9 +559,10 @@ struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
>  	 */
>  	smp_wmb();
>  
> +	spin_lock(&entity->lock);
>  	spsc_queue_pop(&entity->job_queue);
> -
>  	drm_sched_rq_pop_entity(entity);
> +	spin_unlock(&entity->lock);
>  
>  	/* Jobs and entities might have different lifecycles. Since we're
>  	 * removing the job from the entities queue, set the jobs entity pointer
> @@ -647,6 +648,9 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
>  	 * Make sure to set the submit_ts first, to avoid a race.
>  	 */
>  	sched_job->submit_ts = submit_ts = ktime_get();
> +
> +	spin_lock(&entity->lock);
> +
>  	first = spsc_queue_push(&entity->job_queue, &sched_job->queue_node);
>  
>  	/* first job wakes up scheduler */
> @@ -657,5 +661,7 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
>  		if (sched)
>  			drm_sched_wakeup(sched);
>  	}
> +
> +	spin_unlock(&entity->lock);
>  }
>  EXPORT_SYMBOL(drm_sched_entity_push_job);
> diff --git a/drivers/gpu/drm/scheduler/sched_rq.c b/drivers/gpu/drm/scheduler/sched_rq.c
> index 0464d324d98d..23f46ec610e7 100644
> --- a/drivers/gpu/drm/scheduler/sched_rq.c
> +++ b/drivers/gpu/drm/scheduler/sched_rq.c
> @@ -257,19 +257,17 @@ static ktime_t drm_sched_entity_get_job_ts(struct drm_sched_entity *entity)
>  struct drm_gpu_scheduler *
>  drm_sched_rq_add_entity(struct drm_sched_entity *entity, ktime_t ts)
>  {
> +	struct drm_sched_rq *rq = entity->rq;
>  	struct drm_gpu_scheduler *sched;
> -	struct drm_sched_rq *rq;
>  
>  	/* Add the entity to the run queue */
> -	spin_lock(&entity->lock);
> +	lockdep_assert_held(&entity->lock);
> +
>  	if (entity->stopped) {
> -		spin_unlock(&entity->lock);
> -
>  		DRM_ERROR("Trying to push to a killed entity\n");
>  		return NULL;
>  	}
>  
> -	rq = entity->rq;
>  	spin_lock(&rq->lock);
>  	sched = rq->sched;
>  
> @@ -289,7 +287,6 @@ drm_sched_rq_add_entity(struct drm_sched_entity *entity, ktime_t ts)
>  	drm_sched_rq_update_fifo_locked(entity, rq, ts);
>  
>  	spin_unlock(&rq->lock);
> -	spin_unlock(&entity->lock);
>  
>  	return sched;
>  }
> @@ -343,16 +340,17 @@ drm_sched_rq_next_rr_ts(struct drm_sched_rq *rq,
>   */
>  void drm_sched_rq_pop_entity(struct drm_sched_entity *entity)
>  {
> +	struct drm_sched_rq *rq = entity->rq;
>  	struct drm_sched_job *next_job;
> -	struct drm_sched_rq *rq;
> +
> +	lockdep_assert_held(&entity->lock);
> +
> +	spin_lock(&rq->lock);
>  
>  	/*
>  	 * Update the entity's location in the min heap according to
>  	 * the timestamp of the next job, if any.
>  	 */
> -	spin_lock(&entity->lock);
> -	rq = entity->rq;
> -	spin_lock(&rq->lock);
>  	next_job = drm_sched_entity_queue_peek(entity);
>  	if (next_job) {
>  		ktime_t ts;
> @@ -375,8 +373,8 @@ void drm_sched_rq_pop_entity(struct drm_sched_entity *entity)
>  			drm_sched_entity_save_vruntime(entity, min_vruntime);
>  		}
>  	}
> +
>  	spin_unlock(&rq->lock);
> -	spin_unlock(&entity->lock);
>  }
>  
>  /**
> -- 
> 2.54.0
> 
