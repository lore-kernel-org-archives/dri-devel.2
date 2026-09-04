Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1CBC79F82
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 17:22:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DF7610FAA6;
	Fri,  4 Sep 2026 17:21:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="JSMASaLH";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F76110E55D;
 Fri,  4 Sep 2026 17:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788542518; x=1820078518;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=A3aFLc0WbDm0kTsIPp0h+mHh8fQ2o2KDSzysCXvvEWY=;
 b=JSMASaLHLUhIk/EdvI4/Ur59mb0CAScGePmibr/kBC4gk/dRbcH0fgfJ
 yICWP/HdgmLIy/Z8nGw68+GVex02cX6wGgcwsJhcdHeLXcjcxtnnfqswn
 XRLZLfHcaOiZiOH5/Ox+LzsIlwOCQeXtpkoNl+dmx/Jt8TiSPjoorTTe8
 mrM1nFwEiZxK23ZZeOPctwnFAarJDQfk8xdZqtwfitzYfJAHyh+nFt6hI
 n2FoisvHI+y9NXzHPZHTrIlyfgB3D/WcCM2sdtTlZPK6xck8822UhTG1o
 f67rxUSohvZQhK1NbZZ33U7sXFhGP8xVCi39/wmWXLGwhPR5HSv6EM8HS g==;
X-CSE-ConnectionGUID: oxZKMO1iSi6sngDG9hR+SQ==
X-CSE-MsgGUID: TyHolQTdQsi6NgA4vUm9Bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11896"; a="76607495"
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; d="scan'208";a="76607495"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 10:21:58 -0700
X-CSE-ConnectionGUID: v88aNWHaSZKBff3qGGBexQ==
X-CSE-MsgGUID: D1TiZw6zRqqAcfIRUo6JAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; d="scan'208";a="272036581"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 10:21:58 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 10:21:57 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 4 Sep 2026 10:21:57 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.54)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 10:21:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b8f6Nz+PIebFr19f1ypcdLIN+Y2AypZWt3TL/KfgRifjv/YclLLY8qou3+b6qC+nSlbvxPg4kWUH/PwwtRFQb7imDaGtjSZc106a+q+hFnZOrGD3vFFyIIkU4dfq7ZJ4haD9Ry23FKG9dMmAs+sImSoblosEKbGliQVb0j8KmGxykzBmuoGiF2AebfQg2ZiPthS69hACKqZdXBJNTconGhz7D2jJMMcmnCI6rYwWFJjBBGEa3nuovAmMDzlhHwO60xVxt4RhfPFkew8oPQ08bz9zQrstpVljic1JWMsl4yY1SkJVcXptKRbVrO5S9xne7PwpSMwtNNKNGdkHUVdBGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVzIWaVKXu6Jk5N+QfBkCXS7segInfx6q+BTxjljz2c=;
 b=tPSL08Y7CsSJTGRk2o0Qmugohw5VpySu56Sl7VEn9DBS5i0eTAzHumG/y5MkLi8nMTvlLgvZfi9zQM8U8S8tXC25sRwURBQpYunnZ9Gp1LlTu/Rpcc9H6SStlu7flo8QwC9fC6HOJt6eqh3r3MEogO9FXumPwqybAPpBggtL8Zn70KQAmZx8No7c3AUe3KyNNilUoQV0gqOmxsowjmYkIPM9rvA3J8RE4UPnQFSSjX/qfmIDMaITyYD+eqokMHxnQUxoMwZy58DpFEaOPd2bUKXWjtbvlBjYVai7xZsitUDYihIiXzvaA5etve/tkJrDh8xmZll+tk3fHidPknw3Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 17:21:55 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 17:21:55 +0000
Date: Fri, 4 Sep 2026 10:21:52 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Honglei Huang <honghuan@amd.com>
CC: <sima@ffwll.ch>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <himal.prasad.ghimiray@intel.com>,
 <dakr@kernel.org>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <aliceryhl@google.com>,
 <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>, <Junhua.Shen@amd.com>,
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v3 3/6] drm/gpusvm: let drm_gpusvm_get_pages() map an
 array of pages
Message-ID: <apr+MN1jgOKqBdnn@gsse-cloud1.jf.intel.com>
References: <20260904163956.3433293-1-honghuan@amd.com>
 <20260904163956.3433293-4-honghuan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260904163956.3433293-4-honghuan@amd.com>
X-ClientProxiedBy: MW4PR04CA0243.namprd04.prod.outlook.com
 (2603:10b6:303:88::8) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|PH0PR11MB5095:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d4bb7e8-1e56-41c3-8a2d-08df0aa9049c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|1800799024|366016|5023799004|4143699003|10067099003|11063799006|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: ivkOO32URafQ56pGvXX2R8xdhA4Vgs5vhiNhuZhhsryRmKHPo9Q6iAxZZL7N8f43SuKTLMkN7r0rz/XxUTzhiUScWBqhrfwRc1YiVXk0VkpIK7rHuGajcO3DDqv9JWfxwIsGsBrwPwoGfOKG8J36gzgZV5JmZig1vKd8rJyi1wUl2+gujij12EG4TfTPos5spiNRd1cPy0G7R/56hm0YIP8SVSXWs7gYEh5Jv9y3WICt/FBYhtyN5nIBprNkM3mOliilwrLkm3LoYPG8Ing6yQEqYUJMONxDmlh6bHxNiDdVI301tS9p7PRC/1rpVFOWMYI6U/VDzTdnsOSBnMyfv1c+iveqXtxCQIlzk/AwG1NV930q2caG7FiNAeZ4voY3XYx/DpOSpVpN+Rqil6JWMOuhqBhg76XSDxxHRbSeERp0Jl1JpJWn68ZZnwwMCYfN/7vsCT9eIKsZ2aq9y4Tir1ASCi3POpngYrpXSfkPY14t9ZvZT+FXX+Yj85kHVczNGg4z2nGmvLt/HhXGVyCaxgFgMDIIl9fPHpuvE7MghHl/Lz0NTBscpmg9QZ9hHcXSnrQO+iBIcRoeANWPmfoD/eVPNINmC11fMfi48bBAuhZE4ncE/oBN22X375GHoo3qeqVa2TN3/Z1QCvjpXI4+WnNGXNUCLphCNOMGaoktpQU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(5023799004)(4143699003)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OtNfMnbvweKWppljXZ/HN7soxffyGpY1fC2gA2oFm+7NPi64pytBedgAU1/B?=
 =?us-ascii?Q?0h00YSgrgFdyX+mBLYF/m1BebeS86VTEVgzjeLBy2A3WkgDIP4NHGWfhCdT7?=
 =?us-ascii?Q?tnLpDlZ0a67IAsrAzHO8J5T+S0R+8WHmJ1DczOInlV00eFfl+Rr+DAyE60fM?=
 =?us-ascii?Q?sWnm11UBE3Rvm1h4cJnTt15iBBa45e+ZvKhujbTL6brgvnJqR9GfGQSLg5zS?=
 =?us-ascii?Q?IL5enxctuuDQmwqcnajf2fbNRY7qMkbLxWa8wJ3Nh9piacV+kgJOwJXyLaG8?=
 =?us-ascii?Q?iiUDnmo23TfxAEpZUzJdtr6Eoa2EKtGh1ILqXEjHYEg7Nas7h4eb61toUyiL?=
 =?us-ascii?Q?K9r5BlfCjlDNBMLQlduT3s4AclUWVU//PCsmkoU0qimv725zF0268IVJqc/B?=
 =?us-ascii?Q?oej79SqFLtrrpiUlxrauxGM4KmNG69FOBedsFrcQGrgtxuPH93UHWI7ZzgB6?=
 =?us-ascii?Q?yDLrEFxeLkq5qk3zbAiGjHJrLourpKfzrMPEl7o0ATsNWFDgsgSKqabf+5RT?=
 =?us-ascii?Q?0Sh1Wvk13wkbcPwZplpH6bvKaY8aWWH//zdjXbrYUmYz3l1TJ8uz0boK01G8?=
 =?us-ascii?Q?UJ99/c6WmbAQnGc946X6ftdNkR5dPDQRhVd+QPM2HBLHEWjJaXWVLCBiXfOY?=
 =?us-ascii?Q?3vc8rG8vZnXJyqvyvP3JeF1hpO96JMyKi8pMQZRiMocaU8uAwlsubfxF9Kgj?=
 =?us-ascii?Q?0uy0rlMBJcdWJHrnIhc2kj5CEwtO7Cfdl6p1UXS65uKOlAhnAMPiGwWnOzDg?=
 =?us-ascii?Q?1ygmCKMIAF5tO8uMMT9VpVsG/VBejMrGHdvA0ByeyVi/CzINbaCunpT014r5?=
 =?us-ascii?Q?lO6dSYlBLP7bHMTGcWs+DVgOPTVcNWcv6jdlhwvO8M2mfUrK7La5a818/8H9?=
 =?us-ascii?Q?S5JhuEu2c05whet2BPtfQsepb3EJnT9+SXZ8ylnH1Fp+ou8mYCFp50S3WiOY?=
 =?us-ascii?Q?ML0Ujoant5SEpPDquiCmpu7yBGrAokkLawFN5O4W81mKQrl/c/9vwlSbCiu+?=
 =?us-ascii?Q?/IeHlV3wTgjjxeYqoPFXJoXsCGYCVjSc2DUWWCHWsrQ0SZUksW4PK1cMC+i8?=
 =?us-ascii?Q?caLYai1C+imfFHsagg1SFQX8cWYoavkyblptMJ/LS2jIYNZjL/YcMYa/YmQ5?=
 =?us-ascii?Q?LmQ6dl5rOGHXUk90VOEwjvBBCKx5OUsCLSLbIofNnQo+DYUdoDrbdCLNdPPe?=
 =?us-ascii?Q?gLEHCAa2qmyev8Gc6er/Im+ndhIxG0cMvBxxjpMDqmH7WmNoA9/h8iIdTn77?=
 =?us-ascii?Q?LnQyjzdrs1uTEIisy8dMhMID30Evq6yFwNdExweIGz3Ob5XEGz6chWm54aM8?=
 =?us-ascii?Q?VrDmXXx1fz1/DTuIFWAxSGLhZpSzA0BFm1PbkIlGH9tdpe4lKD1PHCMoq3Va?=
 =?us-ascii?Q?em9fprjbQgoKOh+/fOPFX/98yhUeoBO6cfbCfbcComTzDJ2NtpVTjYSCQJ4H?=
 =?us-ascii?Q?MaTxv5E9yM01wRiE7HoU4O1k/oFqCIvxxxMGtbXgQGstDQIxp2qe0yw0NyPJ?=
 =?us-ascii?Q?i5HLXaDba6PkXJnBfJ0VK4NJPPwIBrkszWndYlAqyOzSYcA1f7rRwRsXWfGn?=
 =?us-ascii?Q?Gx+nzh5CG4zNvYwKmItxx0jJSVZ/BGKvbYo+Y0AVYAqCJVL1xdNElxsAj20R?=
 =?us-ascii?Q?8vwYjelAMRLMzlKl6ws/WPbWJA7Ag5l+Pr7p03nLpaXIP7wErFzIPgrJs31W?=
 =?us-ascii?Q?zlqspWcQ/e7/079m/TKC/mkpPbMLzJDpeP1Lg7yXcbQGrHqrzeupzwXk1X3d?=
 =?us-ascii?Q?9hGYnBpCefLJKg/r8bQzAz4C6/ToA9s=3D?=
X-Exchange-RoutingPolicyChecked: cqCyfjVnbf9M4ko+Y3QbqEe1HIceVWtaF3EfuBG9cDi7IGw6s3fiJC5F2+4JoU3MZsUFdgdJid16b17/t4En//7IbHufkKmsx+u5jM5px1YmOPmXfe9BGtwtdeB/soJKsJyABXjdwjvkOIYR0fgTDCV3ItcnI3PLJi/B5jiXjSoKJIxFT+GIqU/SGTBDpVaJLkam0JtfPdtHLZDsPwns1ZdlGcGkMbZoqQ1uyv44m0oiicyR72W51nCJ1neTNgFmYMtcinqU4ZnfCAKkjmZuQLam+J1QbnhQS7adVEtIsNeBZcocT0yHfczMDVXKPz8lpF4HL4EjeI7HgT0PrranjA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4bb7e8-1e56-41c3-8a2d-08df0aa9049c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 17:21:55.4405 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J9cYxnGexCSNQ+ZW5CHQnpYFPZG1MP7oX3Y1Z4XYUy5dzmD48v/q/UwKa/4MAFBTfAS0puWMBmiJfWMGAMSTMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5095
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

On Sat, Sep 05, 2026 at 12:39:53AM +0800, Honglei Huang wrote:
> With the N:1 drm_gpusvm_pages layout, one CPU range mirrored on several
> drm_devices, the caller had to invoke get_pages() once per device and
> repeat the HMM fault every time.
> 
> Make get_pages() take a contiguous array of drm_gpusvm_pages plus a
> count: fault once, then DMA map each instance by
> drm_gpusvm_dma_map_pages() under a single read_retry gate. xe range and
> userptr callers are updated.
> 
> Document the N:1 array usage in the Overview, showing how get_pages()
> and drm_gpusvm_range_set_unmapped() take the whole array and its count
> while the unmap and free paths stay per-instance.
> 
> Suggested-by: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>  drivers/gpu/drm/drm_gpusvm.c    | 140 ++++++++++++++++++++++++--------
>  drivers/gpu/drm/xe/xe_svm.c     |   2 +-
>  drivers/gpu/drm/xe/xe_userptr.c |   2 +-
>  include/drm/drm_gpusvm.h        |   1 +
>  4 files changed, 110 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index 89c3061d8ef..d8ee0e5f2ae 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
> @@ -80,6 +80,13 @@
>   *			};
>   *		};
>   *
> + *		static struct drm_gpusvm_pages *
> + *		driver_pages(struct driver_range *drange)
> + *		{
> + *			return drange->num_pages == 1 ? &drange->inline_pages :
> + *							drange->pages;
> + *		}
> + *
>   *	In the N:1 case the driver allocates the pages array with a zeroing
>   *	allocator (e.g. kcalloc(num_pages, ...)), initialises each entry with
>   *	drm_gpusvm_init_pages(), and frees each entry with
> @@ -89,6 +96,28 @@
>   *	Each drm_gpusvm_pages must be zero-initialised and initialised with
>   *	drm_gpusvm_init_pages(), called once per entry.
>   *
> + *	The 1:1 examples below pass @num_pages == 1 and &drange->pages. In the
> + *	N:1 case the driver instead passes the whole array and its count, so a
> + *	single call faults the CPU range once and DMA maps it for every owning
> + *	drm_device, e.g.:
> + *
> + *	.. code-block:: c
> + *
> + *		// GPU fault handler: one fault, one DMA mapping per device
> + *		err = drm_gpusvm_get_pages(gpusvm, driver_pages(drange),
> + *					   drange->num_pages, gpusvm->mm,
> + *					   &range->notifier->notifier,
> + *					   drm_gpusvm_range_start(range),
> + *					   drm_gpusvm_range_end(range), &ctx);
> + *
> + *		// Notifier callback: mark every instance unmapped in one call
> + *		drm_gpusvm_range_set_unmapped(range, driver_pages(drange),
> + *					      drange->num_pages, mmu_range);
> + *
> + *	The unmap and free paths stay per-instance: iterate @num_pages over
> + *	driver_pages(drange) and call drm_gpusvm_unmap_pages() /
> + *	drm_gpusvm_free_pages() for each entry.
> + *
>   * - Operations:
>   *	Define the interface for driver-specific GPU SVM operations such as
>   *	range allocation, notifier allocation, and invalidations.
> @@ -232,7 +261,7 @@
>   *				goto retry;
>   *		}
>   *
> - *		err = drm_gpusvm_get_pages(gpusvm, &drange->pages,
> + *		err = drm_gpusvm_get_pages(gpusvm, &drange->pages, 1,
>   *					   gpusvm->mm, &range->notifier->notifier,
>   *					   drm_gpusvm_range_start(range),
>   *					   drm_gpusvm_range_end(range), &ctx);
> @@ -1417,25 +1446,35 @@ EXPORT_SYMBOL_GPL(drm_gpusvm_pages_valid);
>  /**
>   * drm_gpusvm_pages_valid_unlocked() - GPU SVM pages valid unlocked
>   * @gpusvm: Pointer to the GPU SVM structure
> - * @svm_pages: Pointer to the GPU SVM pages structure
> + * @svm_pages: Array of GPU SVM pages structures
> + * @num_pages: Number of drm_gpusvm_pages instances in @svm_pages
>   *
> - * This function determines if a GPU SVM pages are valid. Expected be called
> - * without holding gpusvm->notifier_lock.
> + * This function determines if every GPU SVM pages instance is valid, resetting
> + * every instance which is not so that get_pages() maps it afresh. It therefore
> + * has to walk them all. Expected be called without holding
> + * gpusvm->notifier_lock.
>   *
> - * Return: True if GPU SVM pages are valid, False otherwise
> + * Return: True if all GPU SVM pages are valid, False otherwise
>   */
>  static bool drm_gpusvm_pages_valid_unlocked(struct drm_gpusvm *gpusvm,
> -					    struct drm_gpusvm_pages *svm_pages)
> +					    struct drm_gpusvm_pages *svm_pages,
> +					    unsigned int num_pages)
>  {
> -	bool pages_valid;
> +	bool pages_valid = true;
> +	unsigned int p;
>  
> -	if (!svm_pages->dma_addr)
> -		return false;
> +	for (p = 0; p < num_pages; ++p) {
> +		if (!svm_pages[p].dma_addr)
> +			return false;
> +	}
>  
>  	drm_gpusvm_notifier_lock(gpusvm);
> -	pages_valid = drm_gpusvm_pages_valid(gpusvm, svm_pages);
> -	if (!pages_valid)
> -		__drm_gpusvm_free_pages(gpusvm, svm_pages);
> +	for (p = 0; p < num_pages; ++p) {
> +		if (drm_gpusvm_pages_valid(gpusvm, &svm_pages[p]))
> +			continue;
> +		__drm_gpusvm_free_pages(gpusvm, &svm_pages[p]);
> +		pages_valid = false;
> +	}
>  	drm_gpusvm_notifier_unlock(gpusvm);
>  
>  	return pages_valid;
> @@ -1451,8 +1490,9 @@ static bool drm_gpusvm_pages_valid_unlocked(struct drm_gpusvm *gpusvm,
>   * @dma_dir: DMA data direction for the mappings
>   *
>   * Map the faulted @pfns into @svm_pages for DMA access through its owning
> - * drm_device. Must be called under the notifier lock. On failure this unwinds
> - * the partial mapping of this instance before returning.
> + * drm_device. Must be called under the notifier lock and only for an instance
> + * without a live mapping. On failure this unwinds the partial mapping of this
> + * instance before returning.
>   *
>   * Return: 0 on success, negative error code on failure.
>   */
> @@ -1475,6 +1515,9 @@ static int drm_gpusvm_dma_map_pages(struct drm_gpusvm *gpusvm,
>  
>  	lockdep_assert_held(&gpusvm->notifier_lock);
>  
> +	*state = (struct dma_iova_state){};
> +	svm_pages->state_offset = 0;
> +
>  	flags.__flags = svm_pages->flags.__flags;
>  
>  	for (i = 0, j = 0; i < npages; ++j) {
> @@ -1603,20 +1646,28 @@ static int drm_gpusvm_dma_map_pages(struct drm_gpusvm *gpusvm,
>  /**
>   * drm_gpusvm_get_pages() - Get pages and populate GPU SVM pages struct
>   * @gpusvm: Pointer to the GPU SVM structure
> - * @svm_pages: The SVM pages to populate. This will contain the dma-addresses
> + * @svm_pages: Array of SVM pages instances to populate with dma addresses
> + * @num_pages: Number of drm_gpusvm_pages instances in @svm_pages, must not be 0
>   * @mm: The mm corresponding to the CPU range
>   * @notifier: The corresponding notifier for the given CPU range
>   * @pages_start: Start CPU address for the pages
>   * @pages_end: End CPU address for the pages (exclusive)
>   * @ctx: GPU SVM context
>   *
> - * This function gets and maps pages for CPU range and ensures they are
> - * mapped for DMA access.
> + * This function gets and maps pages for a CPU range and ensures they are
> + * mapped for DMA access. The HMM fault for the CPU range is performed once,
> + * the DMA mapping by drm_gpusvm_dma_map_pages() is then done per instance,
> + * one per owning drm_device. The retry against notifier races is kept here
> + * in common code so drivers never open code it.
> + *
> + * On error the instances mapped before the failing one stay mapped, so the
> + * caller must unmap and free every instance regardless of the return value.
>   *
>   * Return: 0 on success, negative error code on failure.
>   */
>  int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  			 struct drm_gpusvm_pages *svm_pages,
> +			 unsigned int num_pages,
>  			 struct mm_struct *mm,
>  			 struct mmu_interval_notifier *notifier,
>  			 unsigned long pages_start, unsigned long pages_end,
> @@ -1638,10 +1689,15 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  	int err = 0;
>  	enum dma_data_direction dma_dir = ctx->read_only ? DMA_TO_DEVICE :
>  							   DMA_BIDIRECTIONAL;
> +	unsigned int p;
>  
> -	if (!svm_pages->drm)
> +	if (!num_pages)
>  		return -EINVAL;
>  
> +	for (p = 0; p < num_pages; ++p)
> +		if (!svm_pages[p].drm)
> +			return -EINVAL;
> +
>  retry:
>  	remaining = timeout - jiffies;
>  
> @@ -1649,7 +1705,8 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  		return -EBUSY;
>  
>  	hmm_range.notifier_seq = mmu_interval_read_begin(notifier);
> -	if (drm_gpusvm_pages_valid_unlocked(gpusvm, svm_pages))
> +
> +	if (drm_gpusvm_pages_valid_unlocked(gpusvm, svm_pages, num_pages))
>  		goto set_seqno;
>  
>  	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
> @@ -1667,18 +1724,17 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  	if (err)
>  		goto err_free;
>  
> -	if (!svm_pages->dma_addr) {
> -		svm_pages->dma_addr =
> -			kvzalloc_objs(*svm_pages->dma_addr, npages);
> -		if (!svm_pages->dma_addr) {
> +	for (p = 0; p < num_pages; ++p) {
> +		if (svm_pages[p].dma_addr)
> +			continue;
> +		svm_pages[p].dma_addr =
> +			kvzalloc_objs(*svm_pages[p].dma_addr, npages);
> +		if (!svm_pages[p].dma_addr) {
>  			err = -ENOMEM;
>  			goto err_free;
>  		}
>  	}
>  
> -	svm_pages->state = (struct dma_iova_state){};
> -	svm_pages->state_offset = 0;
> -
>  	/*
>  	 * Perform all dma mappings under the notifier lock to not
>  	 * access freed pages. A notifier will either block on
> @@ -1686,7 +1742,11 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  	 */
>  	drm_gpusvm_notifier_lock(gpusvm);
>  
> -	if (svm_pages->flags.unmapped) {
> +	/*
> +	 * drm_gpusvm_range_set_unmapped() flags the whole array in one go under
> +	 * the write lock, so any instance answers for all of them here.
> +	 */
> +	if (svm_pages[0].flags.unmapped) {
>  		drm_gpusvm_notifier_unlock(gpusvm);
>  		err = -EFAULT;
>  		goto err_free;
> @@ -1698,15 +1758,29 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  		goto retry;
>  	}
>  
> -	err = drm_gpusvm_dma_map_pages(gpusvm, svm_pages, pfns, npages, ctx,
> -				       dma_dir);
> -	drm_gpusvm_notifier_unlock(gpusvm);
> -	if (err)
> -		goto err_free;
> +	for (p = 0; p < num_pages; ++p) {
> +		if (drm_gpusvm_pages_valid(gpusvm, &svm_pages[p]))
> +			continue;
>  
> +		err = drm_gpusvm_dma_map_pages(gpusvm, &svm_pages[p], pfns,
> +					       npages, ctx, dma_dir);
> +		if (err) {
> +			/*
> +			 * The failing instance was unwound by the helper. Keep
> +			 * the ones mapped earlier: the -EAGAIN retry reuses
> +			 * them, and the driver unmaps every instance with the
> +			 * range on the other error paths.
> +			 */
> +			drm_gpusvm_notifier_unlock(gpusvm);
> +			goto err_free;
> +		}
> +	}
> +
> +	drm_gpusvm_notifier_unlock(gpusvm);
>  	kvfree(pfns);
>  set_seqno:
> -	svm_pages->notifier_seq = hmm_range.notifier_seq;
> +	for (p = 0; p < num_pages; ++p)
> +		svm_pages[p].notifier_seq = hmm_range.notifier_seq;
>  
>  	return 0;
>  
> diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
> index 627a741293d..1c7793d8caa 100644
> --- a/drivers/gpu/drm/xe/xe_svm.c
> +++ b/drivers/gpu/drm/xe/xe_svm.c
> @@ -1598,7 +1598,7 @@ int xe_svm_range_get_pages(struct xe_vm *vm, struct xe_svm_range *range,
>  
>  	lockdep_assert_held(&range->lock);
>  
> -	err = drm_gpusvm_get_pages(&vm->svm.gpusvm, &range->pages,
> +	err = drm_gpusvm_get_pages(&vm->svm.gpusvm, &range->pages, 1,
>  				   vm->svm.gpusvm.mm,
>  				   &range->base.notifier->notifier,
>  				   drm_gpusvm_range_start(&range->base),
> diff --git a/drivers/gpu/drm/xe/xe_userptr.c b/drivers/gpu/drm/xe/xe_userptr.c
> index 90ac141fc12..9c1dac0fce6 100644
> --- a/drivers/gpu/drm/xe/xe_userptr.c
> +++ b/drivers/gpu/drm/xe/xe_userptr.c
> @@ -91,7 +91,7 @@ int xe_vma_userptr_pin_pages(struct xe_userptr_vma *uvma)
>  	if (vma->gpuva.flags & XE_VMA_DESTROYED)
>  		return 0;
>  
> -	return drm_gpusvm_get_pages(&vm->svm.gpusvm, &uvma->userptr.pages,
> +	return drm_gpusvm_get_pages(&vm->svm.gpusvm, &uvma->userptr.pages, 1,
>  				    uvma->userptr.notifier.mm,
>  				    &uvma->userptr.notifier,
>  				    xe_vma_userptr(vma),
> diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
> index b7d987bf76a..d2b6f3d2b84 100644
> --- a/include/drm/drm_gpusvm.h
> +++ b/include/drm/drm_gpusvm.h
> @@ -324,6 +324,7 @@ void drm_gpusvm_range_set_unmapped(struct drm_gpusvm_range *range,
>  
>  int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  			 struct drm_gpusvm_pages *svm_pages,
> +			 unsigned int num_pages,
>  			 struct mm_struct *mm,
>  			 struct mmu_interval_notifier *notifier,
>  			 unsigned long pages_start, unsigned long pages_end,
> -- 
> 2.34.1
> 
