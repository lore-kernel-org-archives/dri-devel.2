Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70004C44507
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 20:48:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DF5C10E1F5;
	Mon, 13 Jul 2026 20:48:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ISM89Tf7";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5363E10E1F5
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 20:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783975719; x=1815511719;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=yFm+xOvbDEqfhr9y/BQfpmoc1U8cEIH6eJczMFRrF3s=;
 b=ISM89Tf75gC2fwpTJt6lQ7wHz7bNbwPLutc3zYirGnaD8SJCajPp777O
 EZsFFyHI7c90wgnvHuTozuW5dKuTyqZaAy9McJE1DrxMz0CvHWbRzprL7
 4Q+h2NwlvWZQSbwknuYLUcySOT3GWIgng/jqPFfdPzointtZ6VNAF8URQ
 OkbghU0MkeIOuBNxp8Ewds5IGKFout/nQKOOXb6X6n7jKUbH6tfW9gg0O
 Zi4KJnJ832HzYi0mrOtRyohMRvb6+alLH4u3v15RHJ4aTdSSLcuiO4INy
 ce43MyeHNxIgRrAFrQQtJoNEVeQzHcKJ7PSxmG46qDwlVODUGrTIMytYU A==;
X-CSE-ConnectionGUID: Hy8MWlVWTyG4nY5pIhcNig==
X-CSE-MsgGUID: Y74flc6tR8+4POEQk5P4Tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="94946175"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="94946175"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2026 13:48:31 -0700
X-CSE-ConnectionGUID: wTfo9c9rRA+7SVPNb2WZ1w==
X-CSE-MsgGUID: 9P93AkOBT8W4p4tvsYHHTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="255157903"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2026 13:48:30 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 13:48:29 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 13 Jul 2026 13:48:29 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.34) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 13:48:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fBjgIBsdmINIRSi0rh/Se2xgctnfMppZzDa7X0Kfuvc1JjrTUC6rQoOrB9y44ND9vOsJq1ikgeUPkJOapAE35CPoQwB/zXlSdl0BY2wo7Hhko69STUTPeyHwhv4jJIM3qu6s+EekKIh5nQF5T/emXbrtDxyw2Tup1HzHhGI0uebVOwWlSisTmmvfCwlZ1+jxANsaMwXc7kMABKSpkS3W9eQpqto4TT+p5HRfr8kpnH8dDAtU289DkL1HzCYh5VjEhrSQ6Z33uWacmTt4s+cIxaB9cbiN3L0tGgEYlckQ3EW4LaOXYseYU0OAwJPX7J+fUYQth5Xnrt40PeK6lcv8jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34+UWYB7SWs9VxiPpZhfl7Sdi5apYRWz+jHRaXc97SU=;
 b=Y6fPo+9ww1/1kjmAILBj/ICGOTKOIDt7tBs38nTboHso4r+hiV6crm/QB5IaReY6v1+zPQPvCqnK2jdiRIe0sqcC/lQZoUl1wqeyj6LAZH5rl76lo4DoFGLT2+UVAenoiF7kbhcz2YNINY/dba9NuoRqzhueiC7HfsjwML3XxxBGPyyIMMyNtIU9OL4scEsKJksWHl4moSeKqlSqQvQMhBoKBYahKQd/RCL5CULL5CFTdESZlGFxjie9/ZGm8byxEY7oWdOkjENY70B9nKni5nu/mmrKL6gKaWuSQtcF5quZE2RfoBTKdplyinqzQ46fEcjWmIwfwJStQPqg2i1CbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SJ2PR11MB7716.namprd11.prod.outlook.com (2603:10b6:a03:4f2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 20:48:23 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 20:48:23 +0000
Date: Mon, 13 Jul 2026 13:48:19 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Tejun Heo <tj@kernel.org>
CC: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 <dri-devel@lists.freedesktop.org>, Boris Brezillon
 <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, "Liviu
 Dudau" <liviu.dudau@arm.com>, Chia-I Wu <olvaffe@gmail.com>,
 <kernel-dev@igalia.com>, <linux-kernel@vger.kernel.org>, Chia-I Wu
 <olv@google.com>
Subject: Re: [RFC 1/2] workqueue: Add support for real-time workers
Message-ID: <alVPE2d7AKrDCgGO@gsse-cloud1.jf.intel.com>
References: <20260713141436.21547-1-tvrtko.ursulin@igalia.com>
 <20260713141436.21547-2-tvrtko.ursulin@igalia.com>
 <b3e5bcb21184d13c7c631daac955f465@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b3e5bcb21184d13c7c631daac955f465@kernel.org>
X-ClientProxiedBy: MW4PR04CA0380.namprd04.prod.outlook.com
 (2603:10b6:303:81::25) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SJ2PR11MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: cb444110-f8a9-4974-8bc4-08dee12013da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|7416014|366016|18002099003|6133799003|4143699003|56012099006|11063799006|5023799004|22082099003;
X-Microsoft-Antispam-Message-Info: LlANogBzQfzNIHDMTar46oxNLFpqC0/ebptoQkqd4qMMCmMfuQeHmp1/p3KDqeO12ExOcmnLL6xPMK+gKE/ddc5XAX8t+lS3R6LioTTDnm5f2pr2v6qUQ6HpI2g9n4U0OxBq94iYD9CCSSwomSxybhEV/F4Ip0vf22BKWVhtW7SukQW8zkJdnLfwmUxUQEsLv7kMX1Wy+ceKslaCHrBhsgmbOqKeJtYYFn40WlEg3KBz+alT4FVuZQo6rMyouuS0BWrHyHfEzrmdhCEyP97g/iBfrH816NPGWIldmeHNZJcd/LpCpEUoQ3TkcZ4GAWBJZB5rA6u8jQf8OLymdpyCWEQatrKPZvliNnA0cXaUfS3obZ/U0htx2KnjWQKkVkY1nTF55poJdHHDpYYdHRSNh3WSFklFVfyaaoNlVUcLIZAArs3fmr/A3JVBGGpxJapyk2Ke5eLfotxIZpifRzj0reCYuPaQeotJ8ksost8xp/5QU2Lezubj2sqHtrsEVUSbZQ9OmiyJ9Ls253vT4agkdfXnGTZa0D4s99fEQk78hZ16hjOsyO+JcVwTzl+dfypIg22gQHEQhd4HfAfGwi9F2es7AzgPu249o5yCQirXHudfooTUzVFJWyNyJI6UXvb25tbxq23kNTDbbLyUp3j26+635rY9GDcC6b1oF8uMx3o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(18002099003)(6133799003)(4143699003)(56012099006)(11063799006)(5023799004)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aZMbkkOoju5XrScdP1pwLXxDdG0gMhVDvBR2CpkrnJ3AexnY/htdaMkzZKQx?=
 =?us-ascii?Q?u+Mi4wdj5xp/vr55NDsAwtUfec5W8SypGwoYv1uL5dR4VvYuYP2hOlpY+XSc?=
 =?us-ascii?Q?7PNQposT+zdMwtomoA4DdLDpmyR16U4Pvm84mgjmfSyyBMixeQNRQvjOwXd7?=
 =?us-ascii?Q?mpXGgs9+F1Ehn5DB7CDHTc3meut2SrQx0Xli46xUMdkBncFtGoAsOC2m27Dr?=
 =?us-ascii?Q?/5dPVfq7ETilMTIEvD4MXDWvzeFnZxLJHfWW1FWikU6vM6PLG7So2MVMT3+v?=
 =?us-ascii?Q?3B8HXKnkpdJ3vJdYpSK4K5zLxvF2aaB8AE5jR3T805kXs6lCkcV7uPvf+bl7?=
 =?us-ascii?Q?0V6lUibx9VS98Mu+1UxV2bx7RgKTEfIGTPxLaHU5Jej/ovzCtHOHfXRNYMvK?=
 =?us-ascii?Q?RxGzOTmJNy3STzXAqaevAI90Kig2rj1GOU9gIaPnU+rxR9/lBkPuT5apCOcU?=
 =?us-ascii?Q?TCh0n9rGaRf+sEO2mhnmzGiQ1hJss6UY1Zh/i0qfSBQcb1DuMTPXAvIBbEqV?=
 =?us-ascii?Q?5qBsI6YvjdY3bDpxSsCDb7yv9WPRuhloxJ+ka44t5bIOsTaFF56h6+8kEC7a?=
 =?us-ascii?Q?44oZCZ0E8JZOTDz5tI5lViaDcjDkdYSdOJF7ZYhftjUZ3kaA6mFwbcy5G4K7?=
 =?us-ascii?Q?WIG5+t4xCWmECp8wdn5yFYR32lztTXzu8JPHBEdNE6vY+dW5WUQjivvSNb54?=
 =?us-ascii?Q?hD1P++TCHvNqJiA4pGc8EHq2+3R+/U7810ggpLt3qAxJOWk7BnHsamTkcmXi?=
 =?us-ascii?Q?qRVBYw6Aa2A3irvdttwAHeZ8ntKzQNzkJNXM5fTjbEnE65uVeQTONO/tvfQ1?=
 =?us-ascii?Q?hFgdGDHyVYxkrjJgd92xAlheha4/KkPKVzZitd3PDW9//mYkzbpmu3t7nizk?=
 =?us-ascii?Q?v2NzIjQfghi2jfFuW8B56XVruMqKjohdJprcVFt9YLq52Rk8De+h6zZAZArP?=
 =?us-ascii?Q?XSwMe2miv46AaQ1eKaglgMtmnPPIY2YiVY57xVoVa32Rd6FIkvz4wC08bHkE?=
 =?us-ascii?Q?9V34TG0/3v6OnDru5o5uSpEuEJzW060pLAJ7cEGlvqaT5TKvVgIiPzk/BfG7?=
 =?us-ascii?Q?57/XPTq6P1cAeunckypRF+G4hvJskw9pRoxKHxjlkWK2E8ZmjczfAblF69GU?=
 =?us-ascii?Q?hWvlzd69+bTjDR0XOFfwYuGv619ARHDBm1KRsbU9+IMGpRbvtO7QozJRC5/P?=
 =?us-ascii?Q?03YluWtpRzygSWOJO0Kg3wvF8eNFFPnUSQTtR6rtUzHUJ7dQq1aEWMAKUS+A?=
 =?us-ascii?Q?jKa+8tmPmYA5PV3eSThFpQAIBqMBvcOgjrHqpwnsMwJOpqLWJY67p27JW+cR?=
 =?us-ascii?Q?ZBq9pRmq7UjFSYINPuvjfdN93a/7QqK2NUc9oOJPIS0YfonbO5eYG+GUd68/?=
 =?us-ascii?Q?WjUWZwvm64J8MeOyze6X/IeJaHwY6kZT/bNIUh06CCWhqYtadOPV1op0p+GR?=
 =?us-ascii?Q?fH2A93ympmT2W9LOJineQOjkOBL7uJx20t/8t3ib4rTKMnfS7qYeGxSLByAq?=
 =?us-ascii?Q?D9sDqEq3ebTqbT0PCjJ5ZI9YAPi6k0T5APmHNpjzyCPku0UJkvBJBZrWcUoN?=
 =?us-ascii?Q?S84sb3t7BMaELSzEzZW/be9dKmecUBkmKQYDws6NKAVbBc2rrebrdnWvoYjN?=
 =?us-ascii?Q?kqW75yZMU9eT29HVDBhfo1EnqzLHAcTP/oShmMY4cgyN77EWjBRS/eLPc3rC?=
 =?us-ascii?Q?DZ6JNiTonxkC9aBErZS18QWAdNxTlw1UtmWvGUnkdOlvP/pVhb/cNqZ4+JBA?=
 =?us-ascii?Q?zYj5xiLx7OzpF+E48rd0RFYAQbkV3KQ=3D?=
X-Exchange-RoutingPolicyChecked: h5jdhgl4seG+rjdk61B2YpR4D6YCmcaApyCI9k2Kw3eQQODUsH8Ea9vkRKGfHcJG8agIxTOVzutCa/QuHMgrjWdTb+yZytSfraCMCyWZqPR4YP427uy98SNmOY5bGVhYCj0BhUgLsTnWaN/d/fE8WxMzC0Bd04pSp82QUkHA9lPWnAG8No18JuEN+KcCjWZq3DrnYsx5GUnHg35bH/tSCDcSxvOm4P7dTZoBLsfef3PXt4OEc70bRwnR7ZTHb0M1baosF88xBNWpX5EuMkKQB59Fx21o9rlHmnbI+5tm1SEGUDYdz4vV0KVMpnBmIM+gurTGMTGaUQSJFTe58o80Tw==
X-MS-Exchange-CrossTenant-Network-Message-Id: cb444110-f8a9-4974-8bc4-08dee12013da
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 20:48:22.9599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fv3eOB1/aBIh1Vdwg6kYBQFhpUcGqViLCRkfMztGcS0Zu6rQ3CnV3Bl+a2j+ajgIcAkRynwLfK5rw17ztVFhgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7716
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

On Mon, Jul 13, 2026 at 08:59:58AM -1000, Tejun Heo wrote:
> Hello, Tvrtko.
> 
> On Mon, Jul 13, 2026 at 03:14:35PM +0100, Tvrtko Ursulin wrote:
> > We use a mininum priority level since we only care about winning the
> > contest against normal background CPU load. We also limit the number of
> > instantiated threads, both per workqueue to a maximum of two, and system-
> > wide to a maximum of either two or one less than the number of online
> > CPUs. The idea of that is to prevent system wide starvation cause by
> > potentially misbehaving work items.
> 
> Do your use cases need concurrency management on per-cpu workqueues?
> Concurrency management is what per-cpu pools do to reduce the number of
> parallel worker contexts when there are multiple pending work items
> competing for the same CPU - the next work item starts executing only
> after the current worker blocks. That doesn't seem applicable to RT
> usage where the point is running each work item as soon as possible.
> 
> If it isn't needed, how about supporting RT only on unbound workqueues?

The DRM cases I can think of are all unbound workqueues afiak.

Matt

> Where per-cpu execution is wanted, an unbound workqueue with the
> affinity scope set to "cpu" and affn_strict on behaves like a per-cpu
> workqueue sans concurrency management. That'd leave the per-cpu worker
> pools alone and confine the changes to the unbound side.
> 
> The following is an AI review of the patch:
> 
> > For use cases such as the DRM scheduler submitting work to the GPU on
> > behalf of low latency userspace applications, where latter have sufficient
> > privileges to have had successfuly obtained realtime Vulkan global
> > priority, competing with random background CPU load can create large
> > latency spikes which gets in the way of a smooth user experience.
> >
> > For these situations the existing WQ_HIPRI does not bring a noticeable
> > improvemet and a stronger hint is needed.
> >
> > Lets add WQ_RTPRI which creates workers with a SCHED_FIFO scheduling class
> > to improve this.
> >
> > We use a mininum priority level since we only care about winning the
> > contest against normal background CPU load. We also limit the number of
> > instantiated threads, both per workqueue to a maximum of two, and system-
> > wide to a maximum of either two or one less than the number of online
> > CPUs. The idea of that is to prevent system wide starvation cause by
> > potentially misbehaving work items.
> 
> A few typos: "successfuly", "improvemet", "WQ_HIPRI", "mininum",
> "cause by".
> 
> Where does the "per workqueue to a maximum of two" limit come from?
> __alloc_workqueue() clamps max_active to num_online_cpus() / 2, which is
> four on an eight-CPU machine; the two in this series comes from the
> max_active the panthor patch passes in.
> 
> The system-wide limit also doesn't seem to apply to the panthor use case
> at all, see the POOL_RT questions below.
> 
> > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > index 33b721a9af02..0473c009690f 100644
> > --- a/kernel/workqueue.c
> > +++ b/kernel/workqueue.c
> 
> [ ... ]
> 
> > @@ -2863,7 +2868,11 @@ static struct worker *create_worker(struct worker_pool *pool)
> >  			goto fail;
> >  		}
> >
> > -		set_user_nice(worker->task, pool->attrs->nice);
> > +		if (pool->attrs->prio == WQ_PRIO_RT)
> > +			sched_set_fifo_low(worker->task);
> > +		else if (pool->attrs->prio == WQ_PRIO_HIGH)
> > +			set_user_nice(worker->task, pool->attrs->nice);
> > +
> >  		kthread_bind_mask(worker->task, pool_allowed_cpus(pool));
> >  	}
> 
> Doesn't this stop applying attrs->nice to WQ_PRIO_NORMAL pools?
> 
> Unbound workqueues have a user-settable nice level via the sysfs "nice"
> attribute, and wq_nice_store() still accepts it for non-RT workqueues
> and stores it in the pool attrs.  For example the "writeback" workqueue
> is WQ_UNBOUND | WQ_SYSFS with normal priority.
> 
> After this change, a pool created from attrs with prio == WQ_PRIO_NORMAL
> and nice != 0 spawns workers that never get the nice value applied, so
> the existing sysfs knob silently stops having any effect.
> 
> > @@ -2876,6 +2885,9 @@ static struct worker *create_worker(struct worker_pool *pool)
> >  	worker->pool->nr_workers++;
> >  	worker_enter_idle(worker);
> >
> > +	if (pool->flags & POOL_RT)
> > +		atomic_inc(&total_rtpri_workers);
> > +
> 
> [ ... ]
> 
> > @@ -2909,6 +2921,8 @@ static void reap_dying_workers(struct list_head *cull_list)
> >  	list_for_each_entry_safe(worker, tmp, cull_list, entry) {
> >  		list_del_init(&worker->entry);
> >  		kthread_stop_put(worker->task);
> > +		if (worker->flags & WQ_RTPRI)
> > +			atomic_dec(&total_rtpri_workers);
> >  		kfree(worker);
> >  	}
> >  }
> 
> Is this decrement testing the right flags field?  worker->flags holds
> enum worker_flags values (WORKER_DIE, WORKER_IDLE, ...) and no worker
> flag uses the bit that WQ_RTPRI (an enum wq_flags value) occupies, so
> this condition is never true.
> 
> That means total_rtpri_workers is only ever incremented and can never
> drop when workers of an RT pool are culled or their pool is released.
> The increment above keys off pool->flags & POOL_RT, so the two sides of
> the accounting can't pair up as written.
> 
> > @@ -3110,6 +3124,19 @@ __acquires(&pool->lock)
> >  	mod_timer(&pool->mayday_timer, jiffies + MAYDAY_INITIAL_TIMEOUT);
> >
> >  	while (true) {
> > +		if (pool->flags & POOL_RT) {
> > +			unsigned int max = num_online_cpus();
> > +
> > +			if (max > 2)
> > +				max = max - 1;
> > +			else
> > +				max = 2;
> > +
> > +			/* Global cap on the number of RT workers */
> > +			if (atomic_read(&total_rtpri_workers) >= max)
> > +				break;
> > +		}
> > +
> >  		if (create_worker(pool) || !need_to_create_worker(pool))
> >  			break;
> 
> Three questions about this cap.
> 
> 1) Isn't the cap already fully consumed at boot?  workqueue_init() runs
> create_worker() for every per-CPU standard pool of every online CPU, and
> with NR_STD_WORKER_POOLS now 3 that includes the new POOL_RT pool:
> 
> 	for_each_online_cpu(cpu) {
> 		for_each_cpu_worker_pool(pool, cpu) {
> 			pool->flags &= ~POOL_DISASSOCIATED;
> 			BUG_ON(!create_worker(pool));
> 		}
> 	}
> 
> On an N-CPU machine total_rtpri_workers is N right after boot while the
> cap is max(N - 1, 2), so for any N >= 2 the break above already fires
> before the first WQ_RTPRI user exists, and with the decrement never
> running (see above) it stays that way.  A side effect is that every
> machine now boots one idle SCHED_FIFO kworker per CPU whether or not
> anything uses WQ_RTPRI.
> 
> 2) What happens when this break fires while need_to_create_worker() is
> still true?  The code after the loop is:
> 
> 	timer_delete_sync(&pool->mayday_timer);
> 	raw_spin_lock_irq(&pool->lock);
> 	if (need_to_create_worker(pool))
> 		goto restart;
> 
> so the manager goes back to restart and loops forever.  Nothing in the
> cap path sleeps, and each pass re-arms and then deletes the mayday timer
> before it can expire, so pool_mayday_timeout() never runs and no rescuer
> is engaged either.
> 
> Since worker_thread() only starts processing work once
> may_start_working() holds, the first work item ever queued on a per-CPU
> WQ_RTPRI workqueue would leave its SCHED_FIFO worker spinning in
> worker_thread() -> manage_workers() -> maybe_create_worker() on that CPU
> while the work item is never executed.  Nothing in this series creates a
> per-CPU WQ_RTPRI workqueue, but __alloc_workqueue() only rejects the
> WQ_HIGHPRI combination, so this is reachable as soon as one appears.
> 
> 3) POOL_RT is only set on the per-CPU pools in workqueue_init_early().
> get_unbound_pool() never sets it, so neither the cap nor the accounting
> applies to unbound RT pools, which is the only configuration the panthor
> patch in this series uses (WQ_RTPRI | WQ_MEM_RECLAIM | WQ_UNBOUND).
> 
> That seems to invert the commit message: the system-wide limit doesn't
> restrict the posted consumer at all, while it permanently prevents
> worker creation in the per-CPU pools it does cover.
> 
> [ ... ]
> 
> > @@ -5842,7 +5884,12 @@ static struct workqueue_struct *__alloc_workqueue(const char *fmt,
> >  		pr_warn_once("workqueue: name exceeds WQ_NAME_LEN. Truncating to: %s\n",
> >  			     wq->name);
> >
> > -	if (flags & WQ_BH) {
> > +	if (flags & WQ_RTPRI) {
> > +		/*
> > +		 * RT workqueues are limited to max half of the online CPUs.
> > +		 */
> > +		max_active = min_t(int, max_active, num_online_cpus() / 2);
> > +	} else if (flags & WQ_BH) {
> 
> Can max_active end up 0 here?  Two ways:
> 
>   - With one online CPU (nr_cpus=1 or maxcpus=1 boots),
>     num_online_cpus() / 2 is 0, so the panthor workqueue created with
>     max_active == 2 gets 0.
> 
>   - Passing max_active == 0, the documented "use default" value, stays
>     0 because the "max_active ?: WQ_DFL_ACTIVE" fallback and
>     wq_clamp_max_active(), which enforces a minimum of 1, are in the
>     else branch and are skipped for WQ_RTPRI.
> 
> With wq->max_active == 0, wq_adjust_max_active() returns before
> activating anything and pwq_tryinc_nr_active() can never succeed, so
> every work item queued on such a workqueue stays on the inactive list
> forever and flush/destroy hang.
> 
> Also, num_online_cpus() is sampled once at allocation time, so a
> workqueue allocated before secondary CPUs are brought online keeps a
> limit computed from the momentary CPU count.
> 
> While in this area: for WQ_RTPRI | WQ_MEM_RECLAIM, should the rescuer
> get SCHED_FIFO as well?  rescuer_thread() runs at RESCUER_NICE_LEVEL,
> so under a mayday the work this flag is trying to keep low latency
> executes below the promised priority.
> 
> [ ... ]
> 
> > @@ -7284,10 +7339,14 @@ static ssize_t wq_nice_show(struct device *dev, struct device_attribute *attr,
> >  			    char *buf)
> >  {
> >  	struct workqueue_struct *wq = dev_to_wq(dev);
> > -	int written;
> > +	int written, nice;
> >
> >  	mutex_lock(&wq->mutex);
> > -	written = scnprintf(buf, PAGE_SIZE, "%d\n", wq->unbound_attrs->nice);
> > +	if (wq->unbound_attrs->prio == WQ_PRIO_RT)
> > +		nice = INT_MIN;
> > +	else
> > +		nice = wq->unbound_attrs->nice;
> > +	written = scnprintf(buf, PAGE_SIZE, "%d\n", nice);
> 
> This isn't a bug, but is INT_MIN the value userspace should read from
> the nice attribute of an RT workqueue?  This file has so far only ever
> produced values in the [-20, 19] range.
> 
> [ ... ]
> 
> Thanks.
> 
> -- 
> tejun
