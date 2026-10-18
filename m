Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01E7CCF2C7
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 01:02:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E94D10E00C;
	Sun, 18 Oct 2026 01:02:40 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2D7D10E00C;
 Sun, 18 Oct 2026 01:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792285354; x=1823821354;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ri5Vd0p6c5Zk4T/OsCAK5l/Vtzk/Q46AsgF7arbHKn4=;
 b=Nul3vB2FTdx6/6MXG3Zj8T6U/wcvQ8lG51tDWJ0QPYEOdFDPtCgCqlX7
 5/ScnCbJTix6R1JozLeG1XAMGwV+DpcDZN3mvMaRR+RpIi0uquELhAI/z
 KwdXZwmvs1UDpOVRIXzj8Gh67ApOipj0h5LFgd17btXoByNGAjKu91XKk
 jJd0ZUBROuSCwVFMx0dBUE8xA6GUoh0U/HckjHqkHDx2ybU/takZI2Bcw
 KszhxGmOXMw1KHUvmZIvBrvZFTD/e1uGCpg3VxDbHXoM7P7PbhoYGraYO
 3idFRGIg3JCo1iZsekQz7AwQyTbGQzTebfMM8LKWzUCEMlfdM8fxnqwls A==;
X-CSE-ConnectionGUID: jLHksFykSu+Wtj+Z9AsFDQ==
X-CSE-MsgGUID: bdHj1106TFCMlgSDnqhqLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11938"; a="921855"
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="921855"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2026 18:02:33 -0700
X-CSE-ConnectionGUID: +5zP8ilARZaG8J3DVQ9gIQ==
X-CSE-MsgGUID: 02/a58jGTEKcgY+cuv6e+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="2231512"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2026 18:02:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 17 Oct 2026 18:02:32 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sat, 17 Oct 2026 18:02:32 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.11) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 17 Oct 2026 18:02:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=smKiFDGGj++uJrUBVVn2QQNFbIdoisNiWOJbn3suq3euRVxxgFjYSirUFYqNok4P3MC7AVwgU9JPBSt+I9PWHZACXc3YLbBJ9FwKFepm0XfdenQNKEEbmTyzuLltgxWolTEn956Jc5IEbFulRvupgoT6xF/vN0DoMiu9cJb1nzyO3oXdlEbyqi9fp5c0k8YUreCQz9R0c17hCAhIKthw/p28FwUpWHNX3QTHWGOhRAB0EZnVDnXCBPVChS9AfhUwktvOqGE0o9irSghDdIMItjDv1w7/FHn3n1COr0vrE9P4JjXyXi4Mw5tOclNKNdGddT3jeyAY8mgT7jwpraWs4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAiAqisSxJJgGetfuIObIcToyOfpvY2vkLlnmh5Dbnw=;
 b=y4l+OAQa/Q8F/NeaG8FGhkGCPShzwKZvOV5jqdiFj4myO8eliiZ1UtZ4QZGKMHfDHM9SxwCC7djwtZmMnH5URuP2Ti/ODBqDz3UbMe8ZukpwCkLHRJJPLyWsY78HYr7cZZeFusWVh2nBzWdiZIDUZc276W1Jp/lvB5EgrYj21MHzTEG0e3h7zR9dircVJYrBQJHk7DLxnt8liVsZmdgk/97EuJLTuN5Zd1MHaGdOOdkGypTG76FROtGDsqOfPoQsiPTJ2kMSaZvBuR/i36mLV8HX5Pb+33TkDnrTJiVjluzp3wFyahOyHB9u7Uvlq1rCGrM/TrZq2+gc5bj4XlpXVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4792.namprd11.prod.outlook.com (2603:10b6:510:32::11)
 by DSWPR11MB9739.namprd11.prod.outlook.com (2603:10b6:8:356::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Sun, 18 Oct
 2026 01:02:29 +0000
Received: from PH0PR11MB4792.namprd11.prod.outlook.com
 ([fe80::fec9:8db4:c768:8289]) by PH0PR11MB4792.namprd11.prod.outlook.com
 ([fe80::fec9:8db4:c768:8289%6]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 01:02:29 +0000
Date: Sat, 17 Oct 2026 18:02:26 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Danilo Krummrich <dakr@kernel.org>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>, "Abhinav
 Kumar" <abhinav.kumar@linux.dev>, Alice Ryhl <aliceryhl@google.com>, "Anna
 Maniscalco" <anna.maniscalco2000@gmail.com>, Antonino Maniscalco
 <antomani103@gmail.com>, Boris Brezillon <boris.brezillon@collabora.com>,
 David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Liviu Dudau <liviu.dudau@arm.com>, Lyude Paul <lyude@redhat.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, Marijn Suijten
 <marijn.suijten@somainline.org>, Maxime Ripard <mripard@kernel.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Sean Paul <sean@poorly.run>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>, "Steven
 Price" <steven.price@arm.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 7/8] drm/nouveau: use DRM_GPUVM_RESV_PROTECTED
Message-ID: <atQaohqqhgHArD/M@gsse-cloud1.jf.intel.com>
References: <20261001220632.3190896-1-matthew.brost@intel.com>
 <20261001220632.3190896-8-matthew.brost@intel.com>
 <DM7FMW8WTN5C.FSW38EU72RAI@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DM7FMW8WTN5C.FSW38EU72RAI@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0239.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::34) To PH0PR11MB4792.namprd11.prod.outlook.com
 (2603:10b6:510:32::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4792:EE_|DSWPR11MB9739:EE_
X-MS-Office365-Filtering-Correlation-Id: 74156658-9e3d-40bc-b466-08df2cb37b57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|7416014|376014|366016|22082099003|18002099003|11063799006|4143699003|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: kJI+wNXDYwar8VEzKscEX+43fj5h5xavmDlO3Jq51mJvNjbuk2WzmkjSJcqr7cdSIQqKRXLQIfwq73MGtIdgRWAEvsLSIoTozjD8Oe1NxfMRfl8O54WN15Qjy3BgMBtNsBwSk+NQFOPs//cld1sUBoOg5mxzllLMgmvmS7XZWYWNNgi/g5DqqZ4H2ziYp2NB04lfwUk2v/XMrZPf2KF4E6d3DWbZMa/FxwQVXzzN2c7+l+GVSQZY5NB6Z3jYZ9YMWh18qLkcPU4WAawHLJfQTcfipE3pgf7R/RTljrrr9R+tdmg48O87yX+osgsseewNPhjMWWdN4CzmPxogKDTXgNnaHvNBJ7icbvmOlz8srodVroY4N/a3MYvbP+KNuWHy/F0JVJL8/E4nuSi76OpJ8U7iTiMIlTH4gf5/aznY9RkAl5i8mHDTV+Q4skNRtxt1BMnENCAsuyN06ei66IXXESIAFlKU8UuyZ0ZeIVQ/6iSTIDt9aMdiDrXnGhKzcZl8UyvZ5yuyzWj2hEGFhlWiGG6IWpRddXmyJIzHJFNQFDaZ/H6/IPPhPnNMZ+1LJclqD9HPUwSsoVdOdaqsnVDmxcI+rtxjTFtdD7iWgZt+5pVGg8jtA3b9sX7Fcl0OLi5A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB4792.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(22082099003)(18002099003)(11063799006)(4143699003)(10067099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bY9q94oTwtLJsx1AzWdMC5CkDcWMpL3fSl9k8Z2L8OuyqwD44QQHzAfJvqhN?=
 =?us-ascii?Q?dAvVOhetP8hu0Rrkxm1+vdSuQ3O8kxgLe8PVM34GIqasDAoG/yFJqiofr7Sg?=
 =?us-ascii?Q?3pjdoQkTg2L2zKpkxYdNVbFk9v8bdRD/npMWd/tFQ/bhltmiXKgudJxmIxmX?=
 =?us-ascii?Q?QvZfp/6ZoRFao+64ETjCuZ43wfjV+RpV3sIXnRT3pokIxhDAefYFVt2mUzkQ?=
 =?us-ascii?Q?W2r5wGl9SxpxRDaAW30wEjp0Ed0uyCm3vgAs7CU/4UvAauYeWrBMGk497aMh?=
 =?us-ascii?Q?JRkDTyjfioCrPEMVtxlVF6GN/pXFepVCjdk5T65vi6OwhbOgnJRiW1derioP?=
 =?us-ascii?Q?srr6QTnY9BArOdwkkQQldCROPiV5fiCOEPKR6XAe295Ko5U+Ixm+pX37vfOL?=
 =?us-ascii?Q?5Sx80vUzJEPSM2z6+6uneU24+lf9F2uFu4UFOGeCGyUI40jIXHT4l/3BwoZn?=
 =?us-ascii?Q?UOzL3P2BouXDYm3iNtS5osie2QsmP2jsEAkgnsUyZOEsaTVIBAD3r0ldXI23?=
 =?us-ascii?Q?G4eDBtknyusd8eBi2l+JTbmfLGdt1gAV/orfkcM5zn/YKqvhR2zW8SD5Z9TK?=
 =?us-ascii?Q?rPxK8yu0lpiTOcCIn0TYdPOye5/4d3gH0PgWcAkW9WOF/Bt+qQ6OGqt4afCt?=
 =?us-ascii?Q?MOzGOsiwfj5EyTdm1Gv2+6wLQrGvzKrqEkS4Dz6TFhjBRQf+xUCfgmFQ1pDN?=
 =?us-ascii?Q?IEgiSoSV1N++ihmLO+G7/KhTnH+O6fTpzk7hYUqLLGeHWZaMLAgP6dmC9Xtx?=
 =?us-ascii?Q?q8Hd7cCzH2Xagzdck07Q0K52FYL4wwg0GhtQFFg7Iw72q6OmEuOUTNq1ZSWA?=
 =?us-ascii?Q?7hKhgF+r3Fogfbiw9o3iDBQ2tHq2xpwm/WNJWziuLlt6mBY4AvnA/j6c99Bc?=
 =?us-ascii?Q?Ch22xhN9KfqfcpV5ROneor4mJOeOeiC0/4PVphYgb36WOxIbJ2dfDhFx+9qd?=
 =?us-ascii?Q?JGJy802u32/+ikxhGION1Ycp3qLwmAjIZGTkazRwmWWBhQAny8f8hZizrXeJ?=
 =?us-ascii?Q?CZ4+ZRE5uOmCtDHc7k3+wCmznXHqe1JzyV0tNTm3IBf70iaL4NHy8E1NQVde?=
 =?us-ascii?Q?PToytcs26b6jiXjUWbyeiQdo/tKINeqDbncvo1et6w9vmeqSztJlX2zuYLsP?=
 =?us-ascii?Q?ulW8afHYvkXYdDgzfnms6OQVwtvna8Q9l9Qwd+PHAqUbVKbn4CKqN3VPvT3M?=
 =?us-ascii?Q?RM9fIhlR4ybfRXj/CzwoSDF7eQkpjR5r4qbwTRcfCcYLhwZosLx3svhelyQo?=
 =?us-ascii?Q?5SX2FX/sH5Y7g6iJaF8ui5YZJdI8dg08yItf2ZNq5W9mUoJf/EAuH0izplmQ?=
 =?us-ascii?Q?CXEm5Pmr08laJ6E7Qg3+qhHUXrvdUHRzAPcDn61XZnLi9+G7hgdyobAm7mvt?=
 =?us-ascii?Q?2/O8db0WD0M94WMOsX8CRQTST+YChNGw3O2W0Y3zcwBMTFalICGuGOdLh91F?=
 =?us-ascii?Q?Xu4eAevHgxJyu6+HBdRASQlODLd0E+73Rr05I/Qtay8dcFsIL9UMJ0cr5kLP?=
 =?us-ascii?Q?VN8lF+1b7iCwQNpHrtsT1+JexcW1mpqWmzIXqQvX0m8A46hB9II9Z+QX4gDr?=
 =?us-ascii?Q?WehdQzsdf9uKNETvGu8V2ZUCUKxnc1vSGAruebDcFmP6r/z/Jd3SbIwTesdG?=
 =?us-ascii?Q?gLuCIUPjteYuehohXaRqteg79u1FAb/LyiQe0f+hLo4Qc33vtTDKekDFnHfm?=
 =?us-ascii?Q?2sEEUuGNpqiDghNV1zqKiVFbhpErWg+yXOqnZUyU3QG3X5sXXcJ5HARHn8uF?=
 =?us-ascii?Q?NtBCieyRuw=3D=3D?=
X-Exchange-RoutingPolicyChecked: P+CAq4wB0hDasg2tvlunfFF0v1YpGGnJpqpgWzoGLQbXEyFocuJE4iKZqvbcHJgh6agZtI47wFELXK8Ll6ZvkwXco87gNJa3BqgKoUVoW14ELeRKU7hzsLGBYwSIpmOx10yQ++ifh3GAzVacE5NyJk9vF06yhwNSNrHMIJjcdh8fd0Wcaf9OO0iGJXkn3uedWA/1yYCT3ptHhepLlztlb301qXZRbCEjEHoD3eEgfeZmXsX1o+I5ye9qThUCnlXKFLLdcEw/bOP2OXgZ59BNTUB9vsWo5m3E+e6M8c69XWBs1fJkIzoCQDigrfD3JbS5tnmPUXZxqCtF38GyiOM8Fg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 74156658-9e3d-40bc-b466-08df2cb37b57
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4792.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 01:02:29.1560 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qm8Rkub0G6s0F4peqjgUan3D0Ohz6mJxtY3BXnxP0g7tdSFUlYPnOA/qI611QnKUjPqIzKDm97azCu2SKD937A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9739
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

On Sat, Oct 17, 2026 at 11:31:06PM +0200, Danilo Krummrich wrote:
> On Fri Oct 2, 2026 at 12:06 AM CEST, Matthew Brost wrote:
> > @@ -1187,6 +1187,27 @@ bind_validate_region(struct nouveau_job *job)
> >  	return 0;
> >  }
> >  
> > +/*
> > + * Lock the VM's common dma-resv together with the one of @obj, as needed to
> > + * drop what may be the last reference of a &drm_gpuvm_bo.
> > + */
> > +static void
> > +nouveau_uvmm_lock_vm_and_obj(struct nouveau_uvmm *uvmm, struct drm_exec *exec,
> > +			     struct drm_gem_object *obj)
> > +{
> > +	int ret;
> > +
> > +	drm_exec_init(exec, DRM_EXEC_IGNORE_DUPLICATES, 2);
> > +	drm_exec_until_all_locked(exec) {
> > +		ret = drm_exec_lock_obj(exec, drm_gpuvm_resv_obj(&uvmm->base));
> > +		if (!ret)
> > +			ret = drm_exec_lock_obj(exec, obj);
> 
> What happens if we reach this with ENOMEM? In such a case we may return without

Right, valid issue. Sashiko flagged this too.

Originally, I thought we would need to open-code the WW transaction, but
instead I ended up fixing drm_exec [1].

So I think we should merge [1] and run the MSM and Nouveau work in a
no-failure mode.

One thing I'd add is an assert(!ret) if Nouveau has support for that
(see xe_assert.h for what we do in Xe so our CI can catch things we
believe are impossible). I suppose the open-coded version would be a
WARN_ON() or WARN_ON_ONCE().

Also likey a BUILD_BUG_ON(2 <= DRM_EXEC_INLINE_OBJECTS).

Let me know if you want me to respin with these changes.

Matt 

[1] https://patchwork.freedesktop.org/series/175390/

> any locks being held and nouveau would just continue calling into function that
> expect locks to be held and hence produced UB, right?
> 
> (I think there is a similar case in MSM, but it was pre-existing, so I picked all
> other patches.)
> 
> > +		drm_exec_retry_on_contention(exec);
> > +		if (drm_WARN_ON(uvmm->base.drm, ret))
> > +			break;
> > +	}
> > +}
