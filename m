Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1DD8C55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 06:34:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29A4010E887;
	Tue,  4 Aug 2026 06:34:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="J3kiwgSK";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14D5A10E645;
 Tue,  4 Aug 2026 06:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785825250; x=1817361250;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=ZYE4nNnSDkYpEGKhFcZ5My/uxKLrzbyPXF4Zdn6DKrY=;
 b=J3kiwgSKZ6D/gKwXHG/aqfBkNms3TF8lxNtBUSUCoMGw97CRP1Um+uGs
 Oex3DQNKtl6doDfbnahc1jphnZTkxR6dgYIcli3SCs+15l0WHInrwzDn9
 GwQ9efD6BlgHqm8uV1XuRqWun1dNYQShOFrZkN2kjBa8M5ScXX76oAeam
 E1UnJBZNhD6CDdyeiJDPDcxnwWX6tD+w7GB8XwPLeUmMTtGCwM+xlgxo4
 gpQyxMge2GT7eMP0kSQBMOh2YXd1CzY/Up6N0xQg1oJrRqyCuUTyDLS2v
 eLuVxHD8H0n6CrNZrDhrDq2fc7x9uXguSF4zWP0SdNf/N5x2mF5xnOIO/ Q==;
X-CSE-ConnectionGUID: Mo7T3CBST7SjTRv/eLdv8Q==
X-CSE-MsgGUID: OXqCNLmpQM6pIWw8cslP+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86222644"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; d="scan'208";a="86222644"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2026 23:33:56 -0700
X-CSE-ConnectionGUID: qmevrC0yTieN5Y6OyPsQJQ==
X-CSE-MsgGUID: sCsVhy+JSMC9yvlRbsyZCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; d="scan'208";a="260820767"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2026 23:33:55 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 23:33:54 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 3 Aug 2026 23:33:54 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.52) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 23:33:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AqZ9VIGvUj8jSxKUorHddBG782d0sXmxcOdClA4JytcLSjBUo0/e8J2mmiAMLdwPeCQb+Ir0ig/3DODqoDx4OuOBA2sNIQq083R2FPIQLjVVCXCOgFLVTPeUSKNz7VTCk10/wdy31OKGKLSaPNaCgQUestZWTVYo7yk+QT49Es/DI9n4mAjdkUIMiA+Wt9azfFgfiw5azorbvmdbqFiXUm0rbbQmJeRjiwcM+Q6KT1zeb/bYmW31O+mqTIQt74US2+b3BzmVr7HNFRFGpyfHZysFebP0pjuMVPupbwGCuJmWWZ748FE6BkGAnLBkiiucLqoUO965bEKB4JvTZJUwGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrIlQrIKWjHBbGdlVa5SCFQsATsNy81wKHI81fc9O/Q=;
 b=ar8gNveCDF1AUxr7lx6BbttDMxLAYkPwyaHYBTPQw50T6WGtF+A5FjqxoqvPvLGIVYnqvwP3mSWZXOtlDG6CkeZyxWGC6ejgZmZvFjVgIEb2x+f82Z/rj4WOvgbz4EEWE7dwb+cknfPut+MvI4NUkZjVLjOQNhD46Uyxv8VtdkN5xUrqkZn7x1uFVQIROCKHOTVTvajzGrHsIQOcYa8MyMit64Ml4EgwpZN4CDJN0tRrWovDF002SCH3RS5jjqHZ96YACbxHVJkT4lERj7pjB5/N+HPBgTNp+wURQhfbhmXWW++dXUt1nGyKVylEt+ofF/W7c5pywtch2YH4dHcvpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by IA0PR11MB7308.namprd11.prod.outlook.com (2603:10b6:208:436::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 06:33:52 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 06:33:51 +0000
Date: Mon, 3 Aug 2026 23:33:48 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: "Yadav, Arvind" <arvind.yadav@intel.com>
CC: <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <thomas.hellstrom@linux.intel.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <himal.prasad.ghimiray@intel.com>
Subject: Re: [PATCH] drm/pagemap: Prevent double migration of device pages
Message-ID: <anGHzKVztOpbKr+O@gsse-cloud1.jf.intel.com>
References: <20260803092553.4117408-1-arvind.yadav@intel.com>
 <anDT86fV1Xbq6fkc@gsse-cloud1.jf.intel.com>
 <anDV8wqPd8G8rIW/@gsse-cloud1.jf.intel.com>
 <c770a90a-a6e3-4a8e-bf40-541f8c1e6512@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c770a90a-a6e3-4a8e-bf40-541f8c1e6512@intel.com>
X-ClientProxiedBy: MW4PR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:303:16d::19) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|IA0PR11MB7308:EE_
X-MS-Office365-Filtering-Correlation-Id: 451670d0-9268-48ad-55e9-08def1f2595c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|6133799003|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: Lx/KzV95LQP2PNCJQp3q3P9iEhQcn3IKyHWL8HH4Wx1uWwdTARRGK7PNy0RCFMy75LsrxPRspDEooizyUKJiFtKIfDT2GptbnRzUSy+PcAXKoDefLLx9qdwXBphSSwGr1+/6Psr1Kbc8ylqqGd20AORphN5u5QHpeUfJUlTqDmkwPva/lGjluyWnKkXtQT3tUs/CsNeDlub9x6I7FwehFLvVho7BlLT3uTzh4MWJEoaiLREDCHULALdHxAMVDCqdFlKFALeHWbPMo0QJidZ+xt6maASQnK5Mh1rZRlq73T3QEB2l89rj+YxqQSyDVLB+o5yDsNyWKxn+cmPjSWt+DoOzqgGlPsmhz/E/JCJb+IojJ10izcKm7LYvjJuFsNlW8LKeUB4yEwm8/yX5P1/CPz0Fc7foFHlPfwHcoN5snEi0OZXPgC35K8ttPgCA5xelkmC7a0W0wD866MCB765TYl2DWWdmuQFEirKHxHs8xsxb/91LxdZVGQfDSfmGSZParY9xb4Prn4G7q1/aReuuayvV4bmIIa7VCItpVyJ9wIowLq3qR3MqMBvj/kF0wm3QsPn7TLaYkSn7GT9ZpU8oWzFELBk4klt16TRBZvmfBU/GoZbFAvkr4om6YpFXujfRkdKSEcex+h36JrmLAUlkgC3w9Qxn//4KvbD5FoT5PB0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?JlEojxQ3bGCnn4XqypqYr+K6KuqnCN4jb4jTRlFgdGnAwvUnpgh8C8udfN?=
 =?iso-8859-1?Q?Gbht875Dda74usa0pdRQtIWft/D1n1bQ2hBHQXd19B5q9r9Aix//R0Pl9X?=
 =?iso-8859-1?Q?rdS+OEM5S8oo3pM2sbo/8fHyimpwX6Emz8ULU2uJokUfJ+YWo6ieLF0mnR?=
 =?iso-8859-1?Q?KLSzsQ44hjf0Sanitr7pIcJ6yz8MEQ7jg7f+O82fsC4iaZqegt0AH0RLlC?=
 =?iso-8859-1?Q?Ur4POAdkGHa7Vnn3EnT5kI0PCwJEk6MQnfEh8ETjxWNLsP01kBz3WxurnI?=
 =?iso-8859-1?Q?4/V50k4pEgQpC6LZZaIDg4pUZoIReOW5mFmRgwUtt2A2XphZfPOtepKJaR?=
 =?iso-8859-1?Q?IcWO8yeF/g8LY1LPHzXu4Ba/3AlRZHp92iWQRtSVtwJjg0aHB/yzjTBp10?=
 =?iso-8859-1?Q?cMRRNcgM1+1/G5W8oy7Js5y7oS5w6CFGol88oJpPh+VCPfVSHZE6M5LEvu?=
 =?iso-8859-1?Q?lGhSb5gnvhb5KQGIAnbd//KqBzRZe3e62aZhcvLLOeeUOjDjM7S0EFnkqD?=
 =?iso-8859-1?Q?pVAvACxGTDmoR6dd6yIVXPjFUGzHfThsXivpXrvvFyf4o+RPb7xyxsL4Hu?=
 =?iso-8859-1?Q?jboi3K3Dl27RDFGsyml/67kpxysBM2tc+jSyHiUA+PhtnZTVa18hXSLSxa?=
 =?iso-8859-1?Q?qFX5VjyuOK+GJQJxtODjFGpgtepx8w+maJ8yx9kHxThvpL6JjZ+tTpT1Wk?=
 =?iso-8859-1?Q?LlupQZqYtVa3mt473swM7SnUDV44XlzKCNYJjDTmGA8lqxNdf1BLowp9aD?=
 =?iso-8859-1?Q?XdbaAyJfBxWrJkgMKPyeq5V6N6imLzb2QpNuaxjAvh3GcY4DGpqMlL/Z0m?=
 =?iso-8859-1?Q?G+CMSdxZg2bgHNC24GECg+rX1skbGCFT9d5UhA9s64d1npvkiAB8dVQdyC?=
 =?iso-8859-1?Q?Lfg40RKCmgBJWe+BKG5hpKFC53F9buyAzjXYW+YOpc6zE63qnnyT0uUfLB?=
 =?iso-8859-1?Q?3MF0JwIwWGtrexcsAr2z41qN4FVTtcHp6SpdcXpr8ilL6R0xvj1pcwxflF?=
 =?iso-8859-1?Q?trYEOT5eoG1nCaAnmlg/I/x8sppQixeGWX7HbIFAP7HV1UEH9ykP7ffR56?=
 =?iso-8859-1?Q?sT6D8TVoQtD+8JmaXXREOWjY6DhwmVck0isqKN3a9PD0YXWucPhx8c4lsN?=
 =?iso-8859-1?Q?wS/E4d71/ZuHsqTHmX1z0d+vzkSqMDhtJYW3UjKxha52XuLH8BnAGLRiQd?=
 =?iso-8859-1?Q?rVo/dPOr014zhhYCM1DFScrFsNdLVpi/XFr3U3b6vFX71p6c7B8X/aRqMI?=
 =?iso-8859-1?Q?bD6KQMZ/3i7tsAKTictvypWUf4gMy6REvQfPkB1cIue1czPZrN2zzpbrNz?=
 =?iso-8859-1?Q?iMOR8C5urr3zgOH8uawd7ljGEm03jdkR9PiZrEiGy97G3kyS8Lul08Wr0r?=
 =?iso-8859-1?Q?oAFfxtn9ayCUZ1AnkDOKQpP2NiM+BP/DEnDP3S+mRTowd6xZShh6BPnsWR?=
 =?iso-8859-1?Q?ETbJD1mLaOXstGntNrSHu9zqDdAUutgSBvlPjZpUj3vZWYMD1zBxj8aDmr?=
 =?iso-8859-1?Q?DYs4lfggASbE0jG2kGuIk1pmxjRymkL7W7O2cH2KT09zdZa4xyvGwO+P/U?=
 =?iso-8859-1?Q?1McQ+w40jqIFcxAeJ3GhZZkO+RG2Qd1tSOOUqZ2htzgJAyaCtm+Z+gdK/w?=
 =?iso-8859-1?Q?pFdhc5yvLRaVGRIbIvi9KpM60Gml1idnJ5RES5pu+S3MUALIAJOQMxNnzf?=
 =?iso-8859-1?Q?eLFpOGwD+c4bvhXu2moFZFK3ie+McDLz+shwZ13pdMkUgh5z8MOCRTc4TK?=
 =?iso-8859-1?Q?sfyFRt+2XKAnBm+gEUJyj8VEIT08o5zGCX44kVJNVRUUhl3OErubBGhcfd?=
 =?iso-8859-1?Q?jGM+cLB1hg=3D=3D?=
X-Exchange-RoutingPolicyChecked: SO/AY1JLObLcw4Fkp71kk05Qhh54JDZYaDz81SjgjGlSVKtRwp7M1dMgr7MMd+GERHGh7ubU2QtMBplu5vJBzlRtewtl2UonNpVR8mDmtF/+dUepMGRhO5yupM4aHG9WgPz/0KR+1sqZnt70Zc0atHvHvAUuRRWKPt+nxnVwZhIkgbhLGwAvolDrZuJWHjYx6Mc1JHzwvVrZqiLjjhrBjFSu8oQVUgkD+nSSS5y6+RMnC3asFxShrJmhxZmJxzWiz/SNIL7hrL87CXgBCGCj+nFpha+BKdTMeoMxgECgo1T94JYwvYjGSETiAn7bmSUYiWbGMU1zRbOr6E5spgZf+A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 451670d0-9268-48ad-55e9-08def1f2595c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 06:33:51.8674 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nm+fZM0NWvKcE3aRYX4uEnLRgk3Tjagw9/51CKaXstuSOjJIe8euW8e26r/inwt9lJEs4NQq32DPxkqe5a6zfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7308
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

On Tue, Aug 04, 2026 at 10:12:10AM +0530, Yadav, Arvind wrote:
> 
> On 03-08-2026 23:24, Matthew Brost wrote:
> > On Mon, Aug 03, 2026 at 10:46:27AM -0700, Matthew Brost wrote:
> > > On Mon, Aug 03, 2026 at 02:55:53PM +0530, Arvind Yadav wrote:
> > > > A device page migrated to system memory by a CPU fault can remain
> > > > referenced for a short time after migration completes. During this
> > > > window, the raw-PFN eviction path can select the same device PFN and
> > > > migrate it again.
> > > > 
> > > So is the race a CPU immediately followed by an evict?
> 
> 
> Yes. The CPU-fault migration completes first, then eviction selects the same
> device folio before its remaining reference is dropped.
> 
> > > 
> > > > The first migration has already moved the memcg charge away from the
> > > > source folio. Migrating that source again can create an uncharged system
> > > > folio. Adding such a folio to the LRU can spin indefinitely in
> > > > folio_lruvec_lock_irqsave(), resulting in a soft lockup and an RCU stall.
> > > > 
> > > Do you have stack trace of this lockup? It would be good include that in
> > > this commit message.
> 
> 
> Yes, I have the trace. I will add in next version.
> 
> > > 
> > > > Track successfully migrated device PFNs in drm_pagemap_zdd for the
> > > > lifetime of the device-mapping generation.
> > > > 
> > > > Record successful migrations in both the CPU-fault and raw-PFN eviction
> > > > paths.
> > > > 
> > > > Make raw-PFN eviction skip retired PFNs, preventing an already migrated
> > > > device page from being handed to the migration path a second time.
> > > > 
> > > > Fixes: 99624bdff867 ("drm/gpusvm: Add support for GPU Shared Virtual Memory")
> > > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > > Cc: Maxime Ripard <mripard@kernel.org>
> > > > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > > > Cc: David Airlie <airlied@gmail.com>
> > > > Cc: Simona Vetter <simona@ffwll.ch>
> > > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > > > Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> > > > Assisted-by: Claude:claude-opus-4-8
> > > > Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
> > > > ---
> > > >   drivers/gpu/drm/drm_pagemap.c | 188 +++++++++++++++++++++++++++++++++-
> > > >   1 file changed, 186 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> > > > index 7a056592ac66..f7040fc0dea6 100644
> > > > --- a/drivers/gpu/drm/drm_pagemap.c
> > > > +++ b/drivers/gpu/drm/drm_pagemap.c
> > > > @@ -7,6 +7,7 @@
> > > >   #include <linux/dma-mapping.h>
> > > >   #include <linux/migrate.h>
> > > >   #include <linux/pagemap.h>
> > > > +#include <linux/xarray.h>
> > > >   #include <drm/drm_drv.h>
> > > >   #include <drm/drm_pagemap.h>
> > > >   #include <drm/drm_pagemap_util.h>
> > > > @@ -66,6 +67,8 @@
> > > >    * @refcount: Reference count for the zdd
> > > >    * @devmem_allocation: device memory allocation
> > > >    * @dpagemap: Refcounted pointer to the underlying struct drm_pagemap.
> > > > + * @retired: Device PFNs already migrated to RAM. Entries remain until this
> > > > + * mapping generation is destroyed.
> > > >    *
> > > >    * This structure serves as a generic wrapper installed in
> > > >    * page->zone_device_data. It provides infrastructure for looking up a device
> > > > @@ -78,6 +81,7 @@ struct drm_pagemap_zdd {
> > > >   	struct kref refcount;
> > > >   	struct drm_pagemap_devmem *devmem_allocation;
> > > >   	struct drm_pagemap *dpagemap;
> > > > +	struct xarray retired;
> > > I don't think an xarray is the right data structure here, given that
> > > load/store operations are slower than direct memory loads and stores.
> > > 
> > > The CPU fault path is about as critical a code path as we can get, so I
> > > think it needs to be highly optimized.
> > > 
> > > I believe a bitmap [1] is the right data structure.
> > > 
> > > include/linux/bitmap.h
> > > 
> > > I'd suggest using an embedded bitmap here, sized based on the ZDD size.
> > > 
> > > For example:
> > > 
> > > /* last member */
> > > unsigned long retire_map[];
> > > Show more lines
> > > 4K, 64K -> length 1
> > > 2M -> length 8
> > > 
> > > Lastly, the only bits that are ever checked are those corresponding to
> > > the folio order. For example, if the folio order is 9, only bit 0 is set
> > > and checked, and the check loop increments based on the folio order.
> 
> 
> Agreed. I will replace the XArray with an embedded bitmap sized for the ZDD
> allocation and remove the reservation helpers.
> 
> > > >   };
> > > >   /**
> > > > @@ -101,6 +105,7 @@ drm_pagemap_zdd_alloc(struct drm_pagemap *dpagemap)
> > > >   	kref_init(&zdd->refcount);
> > > >   	zdd->devmem_allocation = NULL;
> > > >   	zdd->dpagemap = drm_pagemap_get(dpagemap);
> > > > +	xa_init(&zdd->retired);
> > > >   	return zdd;
> > > >   }
> > > > @@ -137,6 +142,7 @@ static void drm_pagemap_zdd_destroy(struct kref *ref)
> > > >   		if (devmem->ops->devmem_release)
> > > >   			devmem->ops->devmem_release(devmem);
> > > >   	}
> > > > +	xa_destroy(&zdd->retired);
> > > >   	kfree(zdd);
> > > >   	drm_pagemap_put(dpagemap);
> > > >   }
> > > > @@ -1102,12 +1108,169 @@ void drm_pagemap_put(struct drm_pagemap *dpagemap)
> > > >   }
> > > >   EXPORT_SYMBOL(drm_pagemap_put);
> > > > +/**
> > > > + * drm_pagemap_is_devmem_page() - Is @page a drm_pagemap device page
> > > > + * @page: The page to test
> > > > + *
> > > > + * Return: true for device-private or device-coherent pages, which carry a
> > > > + * struct drm_pagemap_zdd in their zone_device_data.
> > > > + */
> > > > +static bool drm_pagemap_is_devmem_page(const struct page *page)
> > > > +{
> > > > +	return is_device_private_page(page) || is_device_coherent_page(page);
> > > > +}
> > > > +
> > > > +static void
> > > > +drm_pagemap_release_retired_reservations(unsigned long *src_pfns,
> > > > +					 unsigned long npages)
> > > > +{
> > > This function won't be needed with above.
> 
> 
> Noted,
> 
> > > 
> > > > +	unsigned long i = 0;
> > > > +
> > > > +	while (i < npages) {
> > > > +		struct page *page = migrate_pfn_to_page(src_pfns[i]);
> > > > +		struct drm_pagemap_zdd *zdd;
> > > > +		struct folio *folio;
> > > > +		unsigned long pfn, nr, j;
> > > > +
> > > > +		if (!page || !(src_pfns[i] & MIGRATE_PFN_MIGRATE) ||
> > > > +		    !drm_pagemap_is_devmem_page(page)) {
> > > > +			i++;
> > > > +			continue;
> > > > +		}
> > > > +
> > > > +		folio = page_folio(page);
> > > > +		zdd = drm_pagemap_page_zone_device_data(page);
> > > > +		pfn = folio_pfn(folio);
> > > > +		nr = folio_nr_pages(folio);
> > > > +
> > > > +		for (j = 0; j < nr; j++)
> > > > +			xa_release(&zdd->retired, pfn + j);
> > > > +
> > > > +		i += nr;
> > > > +	}
> > > > +}
> > > > +
> > > > +/**
> > > > + * drm_pagemap_reserve_retired_pages() - Pre-reserve retirement slots
> > > > + * @src_pfns: migrate_vma source array after migrate_vma_setup()
> > > > + * @npages: number of entries in @src_pfns
> > > > + *
> > > > + * Reserve every base PFN because migration may split a large source
> > > > + * folio. Recording the result must not allocate.
> > > > + */
> > > > +static int drm_pagemap_reserve_retired_pages(unsigned long *src_pfns,
> > > > +					     unsigned long npages)
> > > This function won't be needed.
> 
> 
> Noted,
> 
> > > 
> > > > +{
> > > This function will look something like:
> > > 
> > > 	unsigned long i = 0;
> > > 	int err;
> > > 
> > > 	while (i < npages) {
> > > 		struct page *page = migrate_pfn_to_page(src_pfns[i]);
> > > 		struct folio *folio;
> > > 		struct drm_pagemap_zdd *zdd;
> > > 		unsigned long pfn, nr;
> > > 
> > > 		if (!page || !drm_pagemap_is_devmem_page(page))
> > > 			continue;
> > > 
> > > 		folio = page_folio(page);
> > > 		nr = folio_nr_pages(folio);
> > > 
> > > 		if (!(src_pfns[i] & MIGRATE_PFN_MIGRATE)) {
> > > 			i += nr;
> > > 			continue;
> > > 		}
> > > 
> > > 		zdd = drm_pagemap_page_zone_device_data(page);
> > > 		bitmap_set(zdd->retire_map, i, 1);
> > > 		i += nr;
> > > 	}
> > > 
> > > 	return 0;
> > ^^^
> > 
> > Opps, copy paste error. This function isn't needed and the above snippet
> > is for the function below (include there in previous reply).
> 
> 
> Noted,
> 
> > 
> > > > +	unsigned long i = 0;
> > > > +	int err;
> > > > +
> > > > +	while (i < npages) {
> > > > +		struct page *page = migrate_pfn_to_page(src_pfns[i]);
> > > > +		struct drm_pagemap_zdd *zdd;
> > > > +		unsigned long pfn, nr, k;
> > > > +
> > > > +		if (!page || !(src_pfns[i] & MIGRATE_PFN_MIGRATE) ||
> > > > +		    !drm_pagemap_is_devmem_page(page)) {
> > > > +			i++;
> > > > +			continue;
> > > > +		}
> > > > +
> > > > +		zdd = drm_pagemap_page_zone_device_data(page);
> > > > +		pfn = folio_pfn(page_folio(page));
> > > > +		nr = folio_nr_pages(page_folio(page));
> > > > +
> > > > +		for (k = 0; k < nr; k++) {
> > > > +			err = xa_reserve(&zdd->retired, pfn + k, GFP_KERNEL);
> > > > +			if (err) {
> > > > +				drm_pagemap_release_retired_reservations(src_pfns,
> > > > +									 npages);
> > > > +				return err;
> > > > +			}
> > > > +		}
> > > > +
> > > > +		i += nr;
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +/**
> > > > + * drm_pagemap_retire_migrated_pages() - Retire CPU-migrated device PFNs
> > > > + * @src_pfns: migrate_vma source array, valid after migrate_vma_pages()
> > > > + * @npages: number of entries in @src_pfns
> > > > + *
> > > > + * Record successful migrations before finalize unlocks the sources.
> > > > + * Release reservations for pages that were not migrated.
> > > > + */
> > > > +static void drm_pagemap_retire_migrated_pages(unsigned long *src_pfns,
> > > > +					      unsigned long npages)
> > > > +{
> > > > +	unsigned long i = 0;
> > > > +
> > > 
> > > This function will look something like:
> > > 
> > > 	unsigned long i = 0;
> > > 	int err;
> > > 
> > > 	while (i < npages) {
> > > 		struct page *page = migrate_pfn_to_page(src_pfns[i]);
> > > 		struct folio *folio;
> > > 		struct drm_pagemap_zdd *zdd;
> > > 		unsigned long pfn, nr;
> > > 
> > > 		if (!page || !drm_pagemap_is_devmem_page(page))
> > > 			continue;
> > > 
> > > 		folio = page_folio(page);
> > > 		nr = folio_nr_pages(folio);
> > > 
> > > 		if (!(src_pfns[i] & MIGRATE_PFN_MIGRATE)) {
> > > 			i += nr;
> > > 			continue;
> > > 		}
> > > 
> > > 		zdd = drm_pagemap_page_zone_device_data(page);
> > > 		WARN_ON_ONCE(__test_and_set_bit(i, zdd->retire_map));		
> > > 		i += nr;
> > > 	}
> > > 
> > > 	return 0;
> > > 
> > > 
> > > 
> > > > +	while (i < npages) {
> > > > +		struct page *page = migrate_pfn_to_page(src_pfns[i]);
> > > > +		struct drm_pagemap_zdd *zdd;
> > > > +		unsigned long pfn, nr, k;
> > > > +		bool migrated;
> > > > +
> > > > +		if (!page || !drm_pagemap_is_devmem_page(page)) {
> > > > +			i++;
> > > > +			continue;
> > > > +		}
> > > > +
> > > > +		zdd = drm_pagemap_page_zone_device_data(page);
> > > > +		pfn = folio_pfn(page_folio(page));
> > > > +		nr = folio_nr_pages(page_folio(page));
> > > > +		migrated = src_pfns[i] & MIGRATE_PFN_MIGRATE;
> > > > +
> > > > +		/* Keep later folio splits covered. */
> > > > +		for (k = 0; k < nr; k++) {
> > > > +			if (migrated)
> > > > +				WARN_ON_ONCE(xa_err(xa_store(&zdd->retired,
> > > > +							     pfn + k,
> > > > +							     xa_mk_value(1),
> > > > +							     GFP_NOWAIT)));
> > > > +			else
> > > > +				xa_release(&zdd->retired, pfn + k);
> > > > +		}
> > > > +
> > > > +		i += nr;
> > > > +	}
> > > > +}
> > > > +
> > > > +/**
> > > > + * drm_pagemap_skip_retired_pages() - Drop retired PFNs from a raw-PFN eviction
> > > > + * @src_pfns: source array after migrate_device_pfns() (MIGRATE_PFN encoded)
> > > > + * @npages: number of entries in @src_pfns
> > > > + *
> > > > + * Skip source PFNs already migrated to RAM by either migration path.
> > > > + */
> > > > +static void drm_pagemap_skip_retired_pages(unsigned long *src_pfns,
> > > > +					   unsigned long npages)
> > > > +{
> > > > +	unsigned long i;
> > > > +
> > > > +	for (i = 0; i < npages; i++) {
> > > > +		struct page *page = migrate_pfn_to_page(src_pfns[i]);
> > > > +		struct drm_pagemap_zdd *zdd;
> > > > +
> > > > +		if (!page || !(src_pfns[i] & MIGRATE_PFN_MIGRATE) ||
> > > > +		    !drm_pagemap_is_devmem_page(page))
> > > > +			continue;
> > > > +
> > > > +		zdd = drm_pagemap_page_zone_device_data(page);
> > > > +		if (xa_load(&zdd->retired, folio_pfn(page_folio(page))))
> > > if (__test_and_set_bit(i, zdd->retire_map))
> > > 
> > > > +			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
> > > Iterate based on nr.
> 
> 
> Agreed on iterating by folio order. I will use test_bit() here and set the

Yes, test_bit is better.

Matt

> bit only after successful migration, so a failed migration is not left
> falsely retired.
> 
> Thanks,
> Arvind
> 
> > > 
> > > Matt
> > > 
> > > > +	}
> > > > +}
> > > > +
> > > >   /**
> > > >    * drm_pagemap_evict_to_ram() - Evict GPU SVM range to RAM
> > > >    * @devmem_allocation: Pointer to the device memory allocation
> > > >    *
> > > > - * Similar to __drm_pagemap_migrate_to_ram but does not require mmap lock and
> > > > - * migration done via migrate_device_* functions.
> > > > + * Similar to __drm_pagemap_migrate_to_ram(), but uses the
> > > > + * migrate_device_* helpers and does not require the mmap lock. Device
> > > > + * PFNs already migrated by a CPU fault are skipped.
> > > >    *
> > > >    * Return: 0 on success, negative error code on failure.
> > > >    */
> > > > @@ -1149,6 +1312,17 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
> > > >   	if (err)
> > > >   		goto err_free;
> > > > +	drm_pagemap_skip_retired_pages(src, npages);
> > > > +
> > > > +	/*
> > > > +	 * Reserve retirement entries before migration so recording successful
> > > > +	 * PFNs cannot fail. Otherwise, a retry could select and migrate the same
> > > > +	 * PFN again.
> > > > +	 */
> > > > +	err = drm_pagemap_reserve_retired_pages(src, npages);
> > > > +	if (err)
> > > > +		goto err_finalize;
> > > > +
> > > >   	err = drm_pagemap_migrate_populate_ram_pfn(NULL, NULL, npages, &mpages,
> > > >   						   src, dst, 0);
> > > >   	if (err || !mpages)
> > > > @@ -1179,6 +1353,7 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
> > > >   	if (err)
> > > >   		drm_pagemap_migration_unlock_put_pages(npages, dst);
> > > >   	migrate_device_pages(src, dst, npages);
> > > > +	drm_pagemap_retire_migrated_pages(src, npages);
> > > >   	migrate_device_finalize(src, dst, npages);
> > > >   	drm_pagemap_migrate_unmap_pages(devmem_allocation->dev, pagemap_addr, dst, npages,
> > > >   					DMA_FROM_DEVICE, &state);
> > > > @@ -1276,6 +1451,14 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
> > > >   	if (!migrate.cpages)
> > > >   		goto err_free;
> > > > +	/*
> > > > +	 * Reserve retirement entries before migration so recording successful
> > > > +	 * PFNs cannot fail. On failure, finalize can still restore the sources.
> > > > +	 */
> > > > +	err = drm_pagemap_reserve_retired_pages(migrate.src, npages);
> > > > +	if (err)
> > > > +		goto err_finalize;
> > > > +
> > > >   	ops = zdd->devmem_allocation->ops;
> > > >   	dev = zdd->devmem_allocation->dev;
> > > > @@ -1309,6 +1492,7 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
> > > >   	if (err)
> > > >   		drm_pagemap_migration_unlock_put_pages(npages, migrate.dst);
> > > >   	migrate_vma_pages(&migrate);
> > > > +	drm_pagemap_retire_migrated_pages(migrate.src, npages);
> > > >   	migrate_vma_finalize(&migrate);
> > > >   	if (dev)
> > > >   		drm_pagemap_migrate_unmap_pages(dev, pagemap_addr, migrate.dst,
> > > > -- 
> > > > 2.43.0
> > > > 
