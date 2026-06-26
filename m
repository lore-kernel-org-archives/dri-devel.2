Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC18FCDE00E
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 08:40:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5842C10F4F6;
	Fri, 26 Jun 2026 08:40:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Gr/0Gstu";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 705EC10F4F4;
 Fri, 26 Jun 2026 08:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782463207; x=1813999207;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=J9rXdTo027E2Qo2MD2fYWKgW3lq2PGpKDHDAHRaORdI=;
 b=Gr/0GstujR3WfrsaMg21oWLj2eLzba5Un9ugLhnD0SJBj9iiBYKt1ERI
 PWMee+WFdDUVsBjwCwkQTn3tslE6ZRKlFiGgNAUksPO6lnMWVRQWUt3jG
 wgE8TeaeXVTQhfq8UELtOk400sZ0SO959vI1u/oFbsWHNVhenG1Zvhnop
 jy2TpfuRmDyUSibhRPWp1M4nPzF4Sq2oLiCJwAPGf4LLKlpodU6s94VJ2
 qJQhVThngEUeHumB6/1kra6jNWscvP0SVZ6R2uINCtCWC4abWuValDPt8
 5oaIWaVLfDZ1ecbVR0Y1u4/0QOALnpFvC0sap5CcaA+r947nb+A+8Mg1E w==;
X-CSE-ConnectionGUID: DUJjT7wNT6mzy1pFtsw2IQ==
X-CSE-MsgGUID: AJDp/toOQAOsOL/lL7uf7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="93843622"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="93843622"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 01:40:06 -0700
X-CSE-ConnectionGUID: yQPXliQzTPiphHQ5hiaHJA==
X-CSE-MsgGUID: M3FKHg+WQkSU/fi1suRdsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="255269301"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 01:40:04 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 01:40:03 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 26 Jun 2026 01:40:03 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.49) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 01:40:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRzDmIMBu/iqunTQBDW1NTMjY4prukp3rgz/Anm9ocqdV9nt62kgvuEf8oogPuFQqYjySLGVqGyNmgWWkeZL4OXUtCrZiRh35WRQxCXHIRo9fHJmMKYGIuNUGCKODsNMrchGC6iu+XBW+unQO98gz23ts14RYnk6OgCWp81dELfH+G6x+uGKnQ7wlkFKBuHKnnvnntSWxuG2xrHvkSIcV/LM0DU2XlT4rwbAGZuuWWt1nMRdBMXlbzMA474M1bs5QxX4Khq74ipGhK+ayTHMkwVkx5UgSo71u+rEx5nQNc2U7f5rtr8vVBN+a6O7eMWVAw8UPwWzMuyo0H5a9KW0GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0h6Lxn0TcO2cET6+fmLqLHQt9fS58I6V0oNWbOxayE8=;
 b=RRJY+XSUtHbB5qoftkFWUQWUbu1OhcujG2orpf5gcML8yYgWYVE0ofu4HAI+LuGb5LuORSJ7cOxvVpPLES8RXHVyrgJZUbbDgAERRxb3N2yOlnWPxMkxj78H+XxPygXi67avTLeA48mU3S9H/sqwZxQJDuh41SC8jAsUzUUgOnWyRGbWvos988bYWegAzO9zrs2UX4Ck9iz+t2iEfluIQDUDhD5vVDxywJ1YjryWyF0WxDKHz0gDv1z8b67uA31GKcvY1JaILHs/dQcy3rm3b4kiIBQCZ9IsBnE7nqBR7xQeOE1epsq3GL60If4jN6V+1aXOAAbyN+PEw1O+v8po5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by CH3PR11MB8592.namprd11.prod.outlook.com (2603:10b6:610:1b1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 08:39:55 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 08:39:55 +0000
Date: Fri, 26 Jun 2026 01:39:52 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Honglei Huang <honglei1.huang@amd.com>
CC: <sima@ffwll.ch>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>,
 <Jenny-Jing.Liu@amd.com>, <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>,
 <Ray.Huang@amd.com>, <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>,
 <Yiru.Ma@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: Re: [PATCH v3 2/5] drm/gpusvm: embed struct drm_device into
 drm_gpusvm_pages
Message-ID: <aj462A8UYxZov7ID@gsse-cloud1.jf.intel.com>
References: <20260618080902.1527255-1-honglei1.huang@amd.com>
 <20260618080902.1527255-3-honglei1.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260618080902.1527255-3-honglei1.huang@amd.com>
X-ClientProxiedBy: SJ0PR03CA0111.namprd03.prod.outlook.com
 (2603:10b6:a03:333::26) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|CH3PR11MB8592:EE_
X-MS-Office365-Filtering-Correlation-Id: b76703ad-b4f7-4202-96e1-08ded35e7f66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|23010399003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: hKtXdrUPFha5wPhNiT57eUwf9h3jxgog+2UQIUFV81Owvi0+zdtn6Q3xq/7uE5rOYo9PgmbAwjpbPc8ceQGgUROcMChcy9eDTyS7bpTRCYYuVQ+aDKelH1gSOI8vVOxfLWF0876xLEE0ksprcQ+8aetqL1kNnjRJm3Y636631D8ey3JWa08WgPLLl3kVDudOuU7XwbMXJyQisxE55qhf8R1Tv3FkLGuY/XS5BUEWzzfGOz3tWQkn3+WIiJQVoldFZJfDTOxF3pZf7OxDpwAr5oJtH47oznumD+Hy4QeZtKkGBDUrOxWbGloODcqDy+PkQY8YkQpvTFOV/+gdHlwNMn2YWcKqb/DfFuNAuIHNc6ZT0VG6enZbxi+OQ06IJR27wgPRK2fnjBx3sEUXUByTL/gKdtRsqa9TU4HOZ7NQq0rc7HuTX9KFqi3WXNQ4x8jRfjhILx1o8DLoJfKXCkdTmTYMtTiRzc8SusDMfvzxKOcWV8IAfhVfLzmlPFvxn92fQeWoiCk6MaVwP2ClRAPK7kJgDQ59wgpPdnTm/WfFWaZwMHp4di3VOF1ZVfShxyy5OlaK2Yprxa/pEbAclDq9WSue8z1ziyQCxPrug3G4L+XeFVPIfXT4Qf/o4dMbEtx9V9px2L/UCLA6A2/nOsf48DXRysh9NUWYy1CWpdl+wxo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K5N2hwuwSCfeG7oGa/Qj6m+JWJmRuGwuD+iSHjd999PqPqQ8pqzah082ql2n?=
 =?us-ascii?Q?sVUmUukCswKGCv6/gk23wtc6XMX2bV3R3qHmG/54SLottdvwUdej+njP/Bty?=
 =?us-ascii?Q?O8bYnkNZaXrvfpisbRqJwEEFDGULu/CCwneNoNWkD9umjbZtNAewsm46MskU?=
 =?us-ascii?Q?on9r6hRsPMnMMyaVCh4aPzxX+ZXaV4uv0MVrGJcHupTdLixfGaUjqWtgA5eg?=
 =?us-ascii?Q?goqIa730YB3naPeR4292Lu0Yl+oz6yYTPsGWlG+Zgi6Hp8dq4m1mPcIY6uNR?=
 =?us-ascii?Q?mZGj6/w/kMP+yGORiAiqjGKocbf6Bj74EPqdksF+Ej7jeBRvbMMFv548ytfC?=
 =?us-ascii?Q?Lo9RODj8rOBkTqK2e4q8LQgyGBY0yaWSqS1kdONKV5igyQjk1vB6cwLWAMWA?=
 =?us-ascii?Q?q69rmy1/J/zfV3DhZwVLMsbyC2O8saPczjkO/NVaiiwMW7yq44MCIh4a/xzj?=
 =?us-ascii?Q?T9q33rUBsIMUVVzNT0yZc8I5P9w8KbLK81hf2ULkp45z/Ndk453xNUp3i3qd?=
 =?us-ascii?Q?DS8IL3BIhsiIGt8cVKd5FuZpoGSYimP9R4xOZln289JdK4v/IBzzwMIXncqV?=
 =?us-ascii?Q?q0KbH8EhRl6oWvRFcRqz+MpLt1drdX6XrahNCnP1cZPKl4dL34feb3pXSar8?=
 =?us-ascii?Q?+YeSuucC/VFXzJu/VfVytiGibdsE3eHAOZ47QyxSqGRacOcHOlg6DHBfHSnL?=
 =?us-ascii?Q?W9wWvh4omQWm78tSP5FBU0id77rbwNdRbC+cX8kiu5t6jrkIS09aRUi78aFr?=
 =?us-ascii?Q?Fmd+GVt3whdkuT2QtOmu3yC9lrmsfjTv6OCamKRj17MtiSTx+T0YPToPNgPP?=
 =?us-ascii?Q?SFSn7I+vyy88c0gxA3txQVtYsmaJgadt4IrrOUsKjIMIieX5bekVqrZ1iBqp?=
 =?us-ascii?Q?plO0rVcvd7YGkgqjpwP4Vewmg6waK+ZZBviVcPznpJ5431oEF5HAIhVdLOfv?=
 =?us-ascii?Q?1tBD5mYK5hLQtXttDN61gKOOh16BHUDa6N5NAGSzKJFwub+MFw/Q+tizTTKS?=
 =?us-ascii?Q?4pboVxr5VZr2oeCkgjZN/ENU59IhdyvDCqsiTNI+UpMsSRT+XRMxt9hgDQA9?=
 =?us-ascii?Q?alT4mkFTlI+sYXsx/pQxia17U28MBHkdeKNVIHzcm82R/OnxRnDOWJZCyng6?=
 =?us-ascii?Q?EFYAmk16c8GaopglHkKV62SBU9bXs/7brpbqDYkxAHTxawyxjqxRtt4akupM?=
 =?us-ascii?Q?tTNN6GmmwygMDGfngNWlBPdoL52GNVPyJJMPoEMjOSBybbNWPf04++AgMXxN?=
 =?us-ascii?Q?pBN1ygDnmkjAs/ZJFJ5iwVKMKVY6bP0/z6kd5D94uT/mLuWbEaKd6IVFy7tw?=
 =?us-ascii?Q?9uT99jBUywrbu46pH3Xs4lBma7pY3jQerqGdo8oysibh+ytHr+LhayETC0zW?=
 =?us-ascii?Q?SbuO2BqWOdL6FszBRB1RIiXhODjU1zHALycuIyTypLGNlMSEf5D05DwYIeIT?=
 =?us-ascii?Q?NF9oLkz4u9v4PKkFN1K7GkH+fgnnKE+yPVkYR3hu/azvOqSI1s4dr7F+7wYJ?=
 =?us-ascii?Q?bjk2+ecj0Z+8Cry43LLBxB088HWHQgSptc1v8WfU0+IpzaPLYCoodYndemrA?=
 =?us-ascii?Q?79iFHi5uljUHXnS76XrJ8mBZgp/GDBpT4N+I3Blt1DXPCeo+c6+bNUeL6JwF?=
 =?us-ascii?Q?FuZL1AprFW1yBN1pcqsMw8k0FnxY03IfFPtzHQWTrZ2baA0tEFRQGQsuQH07?=
 =?us-ascii?Q?c/P2y6v528JRt4pDHqQ/mAZySaGUWXKF//55Fsfn+010DQU+7w21gJ90k87/?=
 =?us-ascii?Q?wQqTT8NfVw=3D=3D?=
X-Exchange-RoutingPolicyChecked: RN1Wqt56XFReM2A98eD1ADFDRqV5NLBbBO5jLWyTkU24Iz/JOTNLboT9OoGtpfO8Hf6MdXeJ7nVIZ+uMcC/9pkfwQvBy6+/OyVJHpobZkIenuAwLWuwfjyxFHR0tFNoEOsIbDRb7l7k+IPZdy1UNe7UQ/uAzE1QrYFsXOIJcVNUyLuX4XExGwD8fXC8EsdcBjOHTJf+mEEu6LpsThSJnfXqpo+Sdr42VeCOVtagU+vC5Kjs9htgzM7O4YBghB0IQmYGXpCDLWujT0/HIqznqFk3BR0N/8Uc1YWg04Xrl9oGl7XcP3K4jH94i26fGgfktGdwcvdkPd3JVr3XnqHh9gA==
X-MS-Exchange-CrossTenant-Network-Message-Id: b76703ad-b4f7-4202-96e1-08ded35e7f66
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 08:39:55.2751 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XQXY8WsqqPpz1/r7R3yta+hayJEIgDA9DIgKwrFr8EHef1dV5SZbE9L+BdlS7AKdXffsV7Cc/u4qRXbbXSNQrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8592
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

On Thu, Jun 18, 2026 at 04:08:59PM +0800, Honglei Huang wrote:
> From: Honglei Huang <honghuan@amd.com>
> 
> drm_gpusvm_pages is the layer that actually represents physical
> pages/mappings it owns the dma_addr array, the dma_iova_state...
> With the previous patch, so drm_gpusvm_pages is now strictly about
> physical pages and their DMA view.
> 
> Since now the drm_gpusvm_pages instance is inherently bound to one
> specific drm_device, make that ownership explicit by giving
> drm_gpusvm_pages its own drm_device handle, and drive all DMA through
> it instead of through the gpusvm:
> 
>   - Add drm to struct drm_gpusvm_pages and route all DMA in
>     drm_gpusvm_get_pages() / __drm_gpusvm_unmap_pages() through
>     svm_pages->drm instead of gpusvm->drm.
>   - Bind svm_pages->drm where the pages object is initialised
>     (drm_gpusvm_range_alloc() and the xe userptr setup) and require
>     it to be set on entry to drm_gpusvm_get_pages(); the dma device
>     is immutable for the lifetime of the pages instance. A later
>     patch introduces drm_gpusvm_init_pages() to centralise this.
> 
> Suggested-by: Matthew Brost <matthew.brost@intel.com>

I think both sashiko issues are raised here are valid, but pre-existing
so I don't think it fair to hold up this patch, but these should be
fixed. If you have time, feel free post fixes or I'll circle around to
fixing the issues.

So with that:
Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>  drivers/gpu/drm/drm_gpusvm.c    | 30 ++++++++++++++++++++----------
>  drivers/gpu/drm/xe/xe_userptr.c |  2 ++
>  include/drm/drm_gpusvm.h        |  2 ++
>  3 files changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index df900553f21..155e3c2e703 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
> @@ -641,6 +641,7 @@ drm_gpusvm_range_alloc(struct drm_gpusvm *gpusvm,
>  	range->itree.last = ALIGN(fault_addr + 1, chunk_size) - 1;
>  	INIT_LIST_HEAD(&range->entry);
>  	range->pages.notifier_seq = LONG_MAX;
> +	range->pages.drm = gpusvm->drm;
>  	range->flags.migrate_devmem = migrate_devmem ? 1 : 0;
>  
>  	return range;
> @@ -1135,11 +1136,16 @@ static void __drm_gpusvm_unmap_pages(struct drm_gpusvm *gpusvm,
>  				     unsigned long npages)
>  {
>  	struct drm_pagemap *dpagemap = svm_pages->dpagemap;
> -	struct device *dev = gpusvm->drm->dev;
> +	struct device *dev;
>  	unsigned long i, j;
>  
>  	lockdep_assert_held(&gpusvm->notifier_lock);
>  
> +	if (!svm_pages->drm)
> +		return;
> +
> +	dev = svm_pages->drm->dev;
> +
>  	if (svm_pages->flags.has_dma_mapping) {
>  		struct drm_gpusvm_pages_flags flags = {
>  			.__flags = svm_pages->flags.__flags,
> @@ -1421,6 +1427,9 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  							   DMA_BIDIRECTIONAL;
>  	struct dma_iova_state *state = &svm_pages->state;
>  
> +	if (!svm_pages->drm)
> +		return -EINVAL;
> +
>  retry:
>  	if (time_after(jiffies, timeout))
>  		return -EBUSY;
> @@ -1520,7 +1529,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  
>  				pagemap = page_pgmap(page);
>  				dpagemap = drm_pagemap_page_to_dpagemap(page);
> -				if (drm_WARN_ON(gpusvm->drm, !dpagemap)) {
> +				if (drm_WARN_ON(svm_pages->drm, !dpagemap)) {
>  					/*
>  					 * Raced. This is not supposed to happen
>  					 * since hmm_range_fault() should've migrated
> @@ -1532,10 +1541,10 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  			}
>  			svm_pages->dma_addr[j] =
>  				dpagemap->ops->device_map(dpagemap,
> -							  gpusvm->drm->dev,
> +							  svm_pages->drm->dev,
>  							  page, order,
>  							  dma_dir);
> -			if (dma_mapping_error(gpusvm->drm->dev,
> +			if (dma_mapping_error(svm_pages->drm->dev,
>  					      svm_pages->dma_addr[j].addr)) {
>  				err = -EFAULT;
>  				goto err_unmap;
> @@ -1555,11 +1564,11 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  			}
>  
>  			if (!i)
> -				dma_iova_try_alloc(gpusvm->drm->dev, state,
> +				dma_iova_try_alloc(svm_pages->drm->dev, state,
>  						   0, npages * PAGE_SIZE);
>  
>  			if (dma_use_iova(state)) {
> -				err = dma_iova_link(gpusvm->drm->dev, state,
> +				err = dma_iova_link(svm_pages->drm->dev, state,
>  						    hmm_pfn_to_phys(pfns[i]),
>  						    svm_pages->state_offset,
>  						    PAGE_SIZE << order,
> @@ -1570,11 +1579,11 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  				addr = state->addr + svm_pages->state_offset;
>  				svm_pages->state_offset += PAGE_SIZE << order;
>  			} else {
> -				addr = dma_map_page(gpusvm->drm->dev,
> +				addr = dma_map_page(svm_pages->drm->dev,
>  						    page, 0,
>  						    PAGE_SIZE << order,
>  						    dma_dir);
> -				if (dma_mapping_error(gpusvm->drm->dev, addr)) {
> +				if (dma_mapping_error(svm_pages->drm->dev, addr)) {
>  					err = -EFAULT;
>  					goto err_unmap;
>  				}
> @@ -1590,7 +1599,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  	}
>  
>  	if (dma_use_iova(state)) {
> -		err = dma_iova_sync(gpusvm->drm->dev, state, 0,
> +		err = dma_iova_sync(svm_pages->drm->dev, state, 0,
>  				    svm_pages->state_offset);
>  		if (err)
>  			goto err_unmap;
> @@ -1640,7 +1649,8 @@ int drm_gpusvm_range_get_pages(struct drm_gpusvm *gpusvm,
>  			       struct drm_gpusvm_range *range,
>  			       const struct drm_gpusvm_ctx *ctx)
>  {
> -	return drm_gpusvm_get_pages(gpusvm, &range->pages, gpusvm->mm,
> +	return drm_gpusvm_get_pages(gpusvm, &range->pages,
> +				    gpusvm->mm,
>  				    &range->notifier->notifier,
>  				    drm_gpusvm_range_start(range),
>  				    drm_gpusvm_range_end(range), ctx);
> diff --git a/drivers/gpu/drm/xe/xe_userptr.c b/drivers/gpu/drm/xe/xe_userptr.c
> index 6761005c0b9..1b540e62af6 100644
> --- a/drivers/gpu/drm/xe/xe_userptr.c
> +++ b/drivers/gpu/drm/xe/xe_userptr.c
> @@ -390,6 +390,7 @@ int xe_userptr_setup(struct xe_userptr_vma *uvma, unsigned long start,
>  		     unsigned long range)
>  {
>  	struct xe_userptr *userptr = &uvma->userptr;
> +	struct xe_vm *vm = xe_vma_vm(&uvma->vma);
>  	int err;
>  
>  	INIT_LIST_HEAD(&userptr->invalidate_link);
> @@ -402,6 +403,7 @@ int xe_userptr_setup(struct xe_userptr_vma *uvma, unsigned long start,
>  		return err;
>  
>  	userptr->pages.notifier_seq = LONG_MAX;
> +	userptr->pages.drm = &vm->xe->drm;
>  
>  	return 0;
>  }
> diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
> index 251a7266a73..842353afb27 100644
> --- a/include/drm/drm_gpusvm.h
> +++ b/include/drm/drm_gpusvm.h
> @@ -129,6 +129,7 @@ struct drm_gpusvm_pages_flags {
>  /**
>   * struct drm_gpusvm_pages - Structure representing a GPU SVM mapped pages
>   *
> + * @drm: The DRM device that owns the dma mappings
>   * @dma_addr: Device address array
>   * @dpagemap: The struct drm_pagemap of the device pages we're dma-mapping.
>   *            Note this is assuming only one drm_pagemap per range is allowed.
> @@ -138,6 +139,7 @@ struct drm_gpusvm_pages_flags {
>   * @flags: Flags for the range; see &struct drm_gpusvm_pages_flags
>   */
>  struct drm_gpusvm_pages {
> +	struct drm_device *drm;
>  	struct drm_pagemap_addr *dma_addr;
>  	struct drm_pagemap *dpagemap;
>  	struct dma_iova_state state;
> -- 
> 2.34.1
> 
