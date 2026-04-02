Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98CACC6B00
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 04:19:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45BFD10F0A8;
	Thu,  2 Apr 2026 04:19:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Eg2KvTQS";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16B8610F0A8;
 Thu,  2 Apr 2026 04:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775103545; x=1806639545;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=mGRDaZHW+cr3FRkmWLv+f+HL9CNPArjUymetNV+zEIY=;
 b=Eg2KvTQSRUOeC+iDHav28STxP7pYAQ1C5lWc0NhJDm1atbndlfz9CQRk
 B7fvCpUU+/Kh5hIT+Wdvi8ZW8/IKW0unj+agonkyd5ea8R7M6Z3wL65G7
 2PFc/fE0CvAcGVXRbPiuFYzP7aFyNqsxJ51FmpgtnB3HyMC2eI4od3Ns/
 j+4X/JRwjcg9j85rU63U9m/h1riHchTIN5ODtvkPWEokRIEAgWjfMb8ty
 nHCxjd1eRg6U4FoSVE1sMN1OHkjlP0PlryjYfApWOzkVtJf+/8jZwHD0W
 1EF7FrAmuOIJUsz6IDEH1X+ysDmjXTo1Uu3laf7I79laIL0rsM5ykDt6D Q==;
X-CSE-ConnectionGUID: 6DE8PzWKQBmVkRXKdpbjVw==
X-CSE-MsgGUID: gtRW1yuXREi4aauZVRS7Xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="76042897"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; d="scan'208";a="76042897"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2026 21:19:05 -0700
X-CSE-ConnectionGUID: kjWeumUwRxK6QOHLP2iPgw==
X-CSE-MsgGUID: K8s8YdHRQDydT0YCOdA2Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; d="scan'208";a="230935069"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2026 21:19:04 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 21:19:03 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 21:19:03 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.59) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 21:19:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTdeGFIX5wynUXkzCQ8Wc0r17rYr/91b3Zh5QuMcgH0xU5PG2yQj43FcLECbK54PJiHX9NxBer9aGy2PnGLw5aX/SUl1p6Lt6QQBqWzLuAbBg/hKLM+M372TnQrZGANDl8JsIV8DAHxgB1Iqk6DXWgHPo73l6y90T9lB0Zb7Rwamq2Y4tHWduwoWdZRQ2psEZOKgNFIYhk840zxP7FTaYSC86k5jzG1+93fZwDTp1kOwDqe2KBacySp1ukvy6f+nnk6VeKwGfRKKlulhAvW/W5PH2wkqDrGacdq6RVFSTnm7+zqJzKLZeJJA+Vy/1jN1qHaDJBqJNZ5U0yQfnCwriw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cRTKBmSsnwHJbaMTWJXXHzvgUX2fklzKfK9n2wTlwtg=;
 b=Gz8yMhGktAdt25yaRJMQdTMDUvs0wnEZRnUYhpQOXfveQ4VI2iSCZdYFnathusnrj7L4+niSKJf4552kF2VffVCmIIEP21GY1Dhc6ldqIEJUIQj+cMIj9yq1OnXPYlWiUDM2hy7UeTvSaPJJvJQElwZFcUG07Lk/JmEax8D9Obtu9ANWwfvhDeb3QPXAsTN1DThIP5/LU34e4kJL93BKzz9TFRzIV62ypKwW2T/kYKBIMNWZXH5JzZW2+ngMIfnkBOGHiYRwj8Odcsp8ziflg754pEL5ypA3f7kwmIasRm9vQCmLLd9HwYe9p51GpyLOEUF06G7rq3WZIJYLsfYMKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by SA2PR11MB5035.namprd11.prod.outlook.com (2603:10b6:806:116::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 04:18:55 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 04:18:54 +0000
Date: Wed, 1 Apr 2026 21:18:51 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Tejun Heo <tj@kernel.org>
CC: Waiman Long <longman@redhat.com>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Carlos
 Santa" <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 <stable@vger.kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v2] workqueue: Add pool_workqueue to pending_pwqs list
 when unplugging multiple inactive works
Message-ID: <ac3uK2ZVRhiPfL6v@gsse-cloud1.jf.intel.com>
References: <20260401010739.1053192-1-matthew.brost@intel.com>
 <604e3d6aea8767a245160e8c6d3b4b4c@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <604e3d6aea8767a245160e8c6d3b4b4c@kernel.org>
X-ClientProxiedBy: MW4PR03CA0226.namprd03.prod.outlook.com
 (2603:10b6:303:b9::21) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|SA2PR11MB5035:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dbc3c75-622c-4404-8e5d-08de906ef3ef
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: aYJztKfh9wKz0S8wuleLTi9aiioBqVjpA/vzTGaA81QxzLEfB49ZydIxVwD/6FqV6a6UVUVFgQiXDdobHRiUou05CaqAnMYOYHIz09YxUirg9JKXZuUJwJoXzw2IT2J7ghooi0qF1ZpXUF+/SETTZ30yk85td6Fe5I+1zxs6nrNU7L62bW8Hf37j1b8jVmGPu4HjF0soIKoEzSpt+/3zCbulPPyg1x4d5eqldMkji2AMre+Sk7eA+wo3zq/ozpWGvP85hrOa7H2prGIjLp4jxoDMPPWuMu21kSuxe3yfBAzgXTzz54xMSWbR+dJhMhjhn7Are9Hj7+/ngWzeevmsSCwxAG252deN490EoRmyIZ0nmHF+gBFTuoX0Z72o9lqtgE34hR50jA3xZFVevm9ufnPIPL2d7tzEyl62+t74b8ATOBNzuV+mWhPQxbhfaZGOHp9P5wPQCOJLNDUu29XSKbywI/rV+mjNAmVYuLE48KSyMxCoak+Z7Fe5aEgknG6wigTHh6o0zupHkNF4lYAY+cRxQ6kh8Mpdtyzp05oJDCKwJq1h0lMSrDFfrXphy7CP/IgM6Gc2HM7xRNcnXjEz3gXn8ajCy9MJh5Y8CFiNhcRvZH676mo4psWXBcnRDABwEJsb+2nPx0JE2ORMwIWrox/0VO8XY5a48QoDL8E8h+pGmE4pJQzOgwBIl7eNDKCl5qkPeziPFTfmVacvGmserbM61fmiur4W2tAUmi6n9hQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR11MB6508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MQZmTdJIkSYjbDgeigyWXDoQYlRj6z51Vm7hRGK7PA7FqxgRnq5kWmyTf2De?=
 =?us-ascii?Q?OS+7cgHCjOOlpnQuCElq4QeqYTTjbd3K/b+XVMN6ny9s+xvxaMR0CkP6qryj?=
 =?us-ascii?Q?CdcPzXusvMh5y+o4MRa8VSbioMQBL1XQG34L92oCMU3AxEagPTCXoaDbQqpD?=
 =?us-ascii?Q?7Td9uwk/SovHpI/xJwPAslGUUjXLk/lJgMaDiula9DIYZ1mcJDV00hSCvOW0?=
 =?us-ascii?Q?LAh46Sc6IQF8QLXQvPW+tYOgbUM8x9+FoBvZ9DAId3iaTXFYC0U9lq6VJtOq?=
 =?us-ascii?Q?QVkMq1Yu2AkcOzhTbyZ2EiYQ6iSPOtkW/a8CFkfYPd8HErHpbBGO6CpSlnyv?=
 =?us-ascii?Q?bMOBCMmApp3zEf3PRZr3l82v2pwz+6xyFd3ev0u30TKTuKi7irmfqc8Jgjk7?=
 =?us-ascii?Q?yE0HZIbbhBc0s6NireaBNj/LRULfAORU/aCgzrQg0DzuBE6cMhhQb3n1la3R?=
 =?us-ascii?Q?hJAC3pdQA5bQ4wnUuQfO5dXffV7juqgY5Xi1xQVr0fVKe/3F+Zhgi2VY07CI?=
 =?us-ascii?Q?M7Ik7oQ77lIBIO4sBoxH+v/2S5K2qNL1wHsaCX8zvxAIKP2Ft3393dYZxn+m?=
 =?us-ascii?Q?GA213nUljcq8AJT0Pkd23VJ6JcVVg+My/fUFLRon1vsId1/WMnd5GshTxHYp?=
 =?us-ascii?Q?XNvmixZwlS1hP2O2EiRplGi34z5akoj+gd+gj5zaxsIK2b3qmY1UjRaNnIze?=
 =?us-ascii?Q?Nw9TEuZL1DsmYd8nGh6izoM7ewj3YY+PFmhkVCs55VFAt5Fm8wFqN5RXK2o8?=
 =?us-ascii?Q?yKvlTD4XPmRhyjzj471rNGEnLIRhuygkRGA3W6vgfxj1n6JPbX6DKIUqqglt?=
 =?us-ascii?Q?zEHzTa6cP/ZOWf29pXkHipK4joJva73eb+q2vNMDJZBvLN61BTsYdWeGTthi?=
 =?us-ascii?Q?9ENP57bwxPSRREcoElwiNuQwSvchauUCveCIpm/sbqgCgu7S9KKvmx49At+4?=
 =?us-ascii?Q?8kDlMpewTZ/MUp/nm5d9dFAzVj/H4KeP0KGd9aBcp79hwyALCTvT+bC0Fdbe?=
 =?us-ascii?Q?SZpVuWNMEZCye9OyZ2r62/UbxbHPmfucPyUREV13oX9mIYVFSmXItedPQohP?=
 =?us-ascii?Q?wjoxFmb6haaj4RcT/s2E8MeaeuqJrNdEFc7LH9D/A1OIBPBiZ1DO9NIkEf5b?=
 =?us-ascii?Q?lgzhVVD0PG+7iRaWzasGd4WE0W6cDRR9Q7/buTqH+ScANOLGNHayLIXz2aJP?=
 =?us-ascii?Q?s63aXTL5Qj5YeDH6y0tcOtRbKxxELaa0xGyBAjJPGUzt3LbkzvKOJvBEPen/?=
 =?us-ascii?Q?hSj1DyzP6svMmRQOvOLXmBdgFbb99dPGxpyNwknGZio2XCwqdmLb9SvnB+bp?=
 =?us-ascii?Q?mpIcjTxwboODvffjhT00X2UNoi28T6dfs/xnhrQDMeVJjejg0IngXLIyJaXE?=
 =?us-ascii?Q?VNBtv470Ovn+4am5uUiwalDh7qKBPsreGB/c55LCeZuLHzn13MlNgJmG5P5Y?=
 =?us-ascii?Q?a4588OQFNJ0tN/ulN02VMD8EwC3yCbhCochFVreoCkgLhxtpiXpUubcMVfY4?=
 =?us-ascii?Q?cWMMx5KtN3glX3JEI4Q6zs8BERnGbE1bmAKkGrvY4TXqTt1xyjQWu5Rj/rfN?=
 =?us-ascii?Q?TQjYGDxywRDr12adyrwGKu/tdCn+pOhaT39kJj2eoNm+//DTuxkeRwOevC0+?=
 =?us-ascii?Q?/mctQHyIN1FrWjZm/U2wz/acXLEu6IF/5M+JkO7nHJG8mDXV2EJoLyvABl80?=
 =?us-ascii?Q?UM2S1lLsSBS41K7E0uMb6IXum5b8i566xN07QTMx9viaGlbKWOocH+eEsHLu?=
 =?us-ascii?Q?5hJghBfMFnX74wx91euGTbL6mjxHx1U=3D?=
X-Exchange-RoutingPolicyChecked: Nzwl5AFjEaSJyeYVkOLb+a02qWMXIoOYPOWkDKtv9nMRUQ+v1/PqHNpChGVDsQAhMYGzMdeVt1hk60GXjq45JGQfJZprX/H5rar5mVYcOloc3TiOG9WsKPutC+qfDnoM2sjabZrj6PKo7JxG86e58I5lOyNJCE0E0VlxdGW9Dps3CyCMd5lTkM/bhXA/lBAzpCGgcfZXN2s4l4EBaFOcZX+iaobT9xKJjDdM5ds6jjauMZLOe/bfGldraJfXBZk4OWHEZMXUiJcLwP0f5M7agrXwa30f/jj+CX6C2BjoHN+WUItwvthGY7neM2JtIOtVgpW3C35Rr7MP1JDpE/kTOw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dbc3c75-622c-4404-8e5d-08de906ef3ef
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 04:18:54.9034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ri0ISt761FheH15zQejESM+4Iv8S5iFKrPF7f7FyTRde/T/gRqVDXJeg1CWAPccUFIfVMvbDFcIHeBK68Lq0ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5035
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

On Wed, Apr 01, 2026 at 10:20:13AM -1000, Tejun Heo wrote:
> Hello,
> 
> Applied to wq/for-7.0-fixes with the comment updated as below.
> 

+1 on commenr adjustment. Thanks for the quick pull.

Matt

> Thanks.
> 
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1852,12 +1852,11 @@
>  		if (pwq_activate_first_inactive(pwq, true)) {
>  			/*
> -			 * pwq is unbound. Additional inactive work_items need
> -			 * to reinsert the pwq into nna->pending_pwqs, which
> -			 * was skipped while pwq->plugged was true. See
> -			 * pwq_tryinc_nr_active() for additional details.
> +			 * While plugged, queueing skips activation which
> +			 * includes bumping the nr_active count and adding the
> +			 * pwq to nna->pending_pwqs if the count can't be
> +			 * obtained. We need to restore both for the pwq being
> +			 * unplugged. The first call activates the first
> +			 * inactive work item and the second, if there are more
> +			 * inactive, puts the pwq on pending_pwqs.
>  			 */
> 
> -- 
> tejun
