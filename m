Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5EFA103A99F
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 02:41:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 049A210E6B0;
	Wed, 25 Mar 2026 02:41:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="UYqenaur";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9559B10E6B0;
 Wed, 25 Mar 2026 02:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774406507; x=1805942507;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=rBPsXlVeQshUNMA5RYp2U/G9weHc2+zz5bsK5nR7Ewg=;
 b=UYqenaurPB7iej5G1yo2kMyjdedT6G1R9wYq04jhWQIPHnhW0vbArQo0
 Si1G8+7xMIfJ24GHoxbkPjSOlwwXnAyzVsOfTSocm2GwsEpzZHkX8SGor
 Z5URmfh//V+FJApmL0Y60EjnrhpHF7Jaww+wxGkAfQTIKaHLgcaLBwEAO
 arZxM84dBTr2Kl/WzpwMn/oR+C9jvOfAnrG3T5L0a3dm6j4Ddp4FsaN/8
 NdI5xI2fLLvOZR2uF9nNF5AlUH2DeTg5LDHbxbEcWOaNQu+9MyMiA2+Kg
 fx4m6/cWcPqb02RpkRm3FgRCju8UoMkS2vEUkQ2LB6yB3PxWprQa3jdNL g==;
X-CSE-ConnectionGUID: VhNOYVKST0+0Fr6Ny4BbVg==
X-CSE-MsgGUID: BOtlpRh3QHWJDfgAsStCkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="86512734"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; d="scan'208";a="86512734"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 19:41:46 -0700
X-CSE-ConnectionGUID: vPEMaGjnSTiQ1wVnVxTSSA==
X-CSE-MsgGUID: GQUWd2jVTYaG9vrV+G9joQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; d="scan'208";a="229460469"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 19:41:47 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 19:41:46 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 19:41:46 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.41) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 19:41:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QpuLxbx4sun/Cai+fM8+tErriiXYo4d8v57HNIcPK+C8WtLYW+k8izmoLWWmLO3wmtEglcUst9JfZDXPiBktwSlqyJDMG3Ku8D2FrM1wpJQ5gbtpVvYLwClSaFqapQv3s6Q4EVhtML1w8oIqaghSXDbvOldQluVpMA6NZs5oXDQJx4Ed9BUs49G3Xww0htLi0TKnnNbVhqUS/rh2snffFaNlhYPtGKv+eMmYK24lYCz77zRJVIegTv7YKb3vwLlttRl5j/XS/icfEMSKLkx2I9OEfGmUO55Ca0sFPJsar0dwPbUaS7/q3Mxr07xFtnkcMGoldLC2uXv/rYkloegy/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYrbhbjC9KIB/XMOEISqgeAz7UxMoRshY5JHdOP/Lhw=;
 b=WPPXgJnpZKEJN37Drs/LoHNUtAi9K+VXKHjmf05Gnd/OB6T7R+UY/Ix9aTSz/5nPfJPz98TaGnZv0nXVheuktBpfPwEFpFDMwhj2uRfhwLeVBD/7pdCc70uR45quJ9Suk88mhkvEm4yuPk5iMSNbUyHvbbcgR3c0xQAwYh9UtjSp5ukLh8pgxRTWWrKUT9XkPFUyabeIIF20L1OLb8iua0zOblDww86TtaC/1Hc4nf5100FWrKGRFoBvyvC6sXX7v6J/xZExo7H2k+NjICcWhH8j0aDYi49DHsXc3EpYZVAnOUF76LQqHt5SLHhMGYFmlKOvL75X43vDUDpzLoT7Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by PH7PR11MB6932.namprd11.prod.outlook.com (2603:10b6:510:207::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 02:41:41 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 02:41:41 +0000
Date: Tue, 24 Mar 2026 19:41:38 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Himanshu Girotra <himanshu.girotra@intel.com>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH] drm/syncobj: Fix xa_alloc allocation flags
Message-ID: <acNLYhXLDWG1FT9R@lstrano-desk.jf.intel.com>
References: <20260324111019.22467-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260324111019.22467-1-tvrtko.ursulin@igalia.com>
X-ClientProxiedBy: MW4PR04CA0057.namprd04.prod.outlook.com
 (2603:10b6:303:6a::32) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|PH7PR11MB6932:EE_
X-MS-Office365-Filtering-Correlation-Id: a077265b-8574-4034-a6cd-08de8a180bbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info: XvAJ6h6oYdcrtNHhB12Fbd34qy6WBIXy3nj+GGaqyXzfiWmoZslJuAlentDH8EELl14qrNiOHaEITTIzktX845bFu6hnr2OQWWBz3RT03CxfcvivsaH4V4IsM4XnIhbxx/zRa8BKSeaYpHD47uKa8X5adDwlSzBqHdGk2eolapfrrInpEExWpyZiDitZh3opaOK6i2hi7V3boZbEcKnqfxvarZs3rgE/zCHh6KT2kquwHoZP40VIsjmwkR1KtWVB+18yxtJTNvPQL5elZ2rdRDuBrMYhtCBDeJJP55JwewtLbS2hXweWIL7n3XMkIwzeS0AV63rAn2B9evZFGXYtqg9jte87kzCOmsjgZKOe6FHHmmyJBjPEIalKHdj/T/wBCnj4WEHvMYQpS1/Syw4NlmoxoJHtv6HSw8lt8ZYw9gJRzKBsFFXMpYkuHY19K4TDZfqyUuPVh/nKwmb7kAb1zBRw9BFx0OHCk0X3flhreNmeVYX1ZU3ZTGpHeCPcehLv5CB4VQz5cBR5YTkEqMootQYevtpsI1MyVeMDIGiKph+GNUSlPhMt8q5hKAPYQfXshGVOMie+C2S5VdOR+noqMYpZPEhA2YPSs80sFsTRGsowjLuOhwDpOWVUPLJpbY81bjDKaBzNe+Vq7Qmadc0Z0tuE23Xuo/XRSjPcJanlTZscDcONZLSgyMMeVxcd0DM/PoZJ5tnuXgxwW+DNnaqLw3+vI4dkXxaY8bxxN6WQ98g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR11MB6508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?/wkv87D/xh8MwcNdwNM35Gj9aD7R+c5kO6SVjwhTu+/bgsJV2a9QJkEjBM?=
 =?iso-8859-1?Q?GP/AsVyhQ4TogORhYkKGfbrMmJt0HhBxH3k+anE6eEoF3wzCxI1JyxDrsd?=
 =?iso-8859-1?Q?98kQF+CHHWcYaGpjHb8FntXkI16vQl3/4w4Qunl4jMqIEsuWwYYEj21un9?=
 =?iso-8859-1?Q?K3sQbSKXcxUnbeh0kowMpq7s4N7HPxCUINatL15jdYUyRr1H7q61aGq7/p?=
 =?iso-8859-1?Q?C36lqBg0tQDFSu5ki5ncolkLoo+BW8C7Lt4eUUTTjWhcHFSw6ux+mezynu?=
 =?iso-8859-1?Q?W65RE2EGT8c/Ixkkx3qsnoUwmGLNYPOzueAgSI1oibzZ5WaNvA7Nb4g7CG?=
 =?iso-8859-1?Q?umte0+PSEUQgsrlS0TRc32vRTxzDxlZeKJLDXDzhTsLSnVYgtfBiyX/vvd?=
 =?iso-8859-1?Q?ZwedSTecs8MiBVAlrQ9wOrdpd0Zc3NHRmVWB6tWFuMsUq7/7wCwNVx2kh9?=
 =?iso-8859-1?Q?N2E3pbWLSwrPzYQjXjaC89bdKrCyDJPMk/HpLH2wKvwI36Gc64U+roPD+0?=
 =?iso-8859-1?Q?KeWhYvWa9T6WQI/RQDbnPajgniGbHOqCT/nDWNYJetReLqkZigpjJqVyBg?=
 =?iso-8859-1?Q?GHrDgPfOLYlWOy9XaGeQcfWCp+BXPlyx0Q3mfwZNBWGmPG1x5rUGVka1vo?=
 =?iso-8859-1?Q?0nE4kZTnG9IiQxFDCLhziOOSMXC4LI28syRKvQMdC5HAGTPl+per8dYmP/?=
 =?iso-8859-1?Q?aw1XCHVcpQ3CB4y0LdrgIfvU2VPRzwO437R0nGY1IS1Qer+2C+yOMh94T9?=
 =?iso-8859-1?Q?ic/wu6qp7mfa9Z7g21c0uQaiPIYuld9CquQd/Imh9Hh5x71JfDpqWab0az?=
 =?iso-8859-1?Q?JvISFsAZfPXrDvEvEj2CJo5qyVGftqNMCCKh6Fv/iudkgSd7Hk7pC0amCn?=
 =?iso-8859-1?Q?G4DHjSIunAqS2mUyhvJb9j5yOGjzzVMt22sIxL5U4y4fQpuIA3HlIgjYZ/?=
 =?iso-8859-1?Q?4BaHeY3f5XAGmXn6STEP+ZO05csNekNSCDTeaF5ufeH9xlZ4s8QzOXICaf?=
 =?iso-8859-1?Q?DA+EAEp/xfkNM7dScZa0zZc3XvNDPyzi+vuWab4UiSoor24EqBhNdT+MKc?=
 =?iso-8859-1?Q?3+AhDJc+c6KqvpWFiR+No+sstRWjmgwMvE2GxY2b3GzNcE5shx3cb+o+D+?=
 =?iso-8859-1?Q?KponY6+oUjnw/K2SSW6vZ9Yl87cDA5tMKLQ+qywo5RRdErdRtu1/xKLMEZ?=
 =?iso-8859-1?Q?A17T/bjC3YVEv53kXVb8W3VJjwNqsWyO0uhOhlDw9hgHD2rNyqwugpR6vA?=
 =?iso-8859-1?Q?LVd+LResw7TLK/+00Tr/MuiO/YZ511K88JjZPbjGTMurTLIrySe1NMsdzl?=
 =?iso-8859-1?Q?QSh7umCJhvkzM4Nks9xLW1FBiVKopg9k2C4++AArH1lMsTTY9qmM01JFP/?=
 =?iso-8859-1?Q?RSlGNrhfg69EBIEafI+3CvJse28eQPJanNGpIb5oOiGlFKFnfwXjUGrkCJ?=
 =?iso-8859-1?Q?RbhSMD/t/OfJrGNHCB1WMnJAn+h/lKoLNuE7bfvOC/6abV2pCBZcFaYrhm?=
 =?iso-8859-1?Q?9czujrTUzGmXf3dz7bxn4jmRy4Ai+lHUfN7QqYHMawJFwVMNGrHhry5aM2?=
 =?iso-8859-1?Q?/ohs+CRhjsIwNGlOVjrxXewMy04INNwfBXF1OgREtDjpbwrtWeT+vdBDCC?=
 =?iso-8859-1?Q?9ZEAu+9A66jbndfRKDvrIG+j/dKeHivVf3Y0mvjHcICdT2grRyqoMbdId1?=
 =?iso-8859-1?Q?SdbOV81d0Y38L14At8ZrtbY6p0RMqzk4wXy+DyoIA3iilfUUGRBToWNDVS?=
 =?iso-8859-1?Q?9Jy+8Y+lVFdhf0dreGGhTsbZ/d4o87VOsOvGbgIBnVc3efeTA3jAVUVzMq?=
 =?iso-8859-1?Q?uuQX/4+z3/ieOfJPyVoOtMFvCK1PvaY=3D?=
X-Exchange-RoutingPolicyChecked: BFo7bJneudPcKDNy+ga1Q90C8QmqauP9iPvt+Ru06ZxWgkBXUvoSJugH/gselZLMZbHw0MGfw5PQRg8+F9Wno7y3xlzG9zY4yZo3uNfW0ThjkcD6AI/1q5q0SR/4X5G8Qd/38bmdcpwbN7cs1hI03WVd9FdGsndQlQ8wFpG9sUoeRK4OeChXbEftbRcuZHmjLt8w6AqJTbJ6BkU9RD+QUEYp10fUDAuEs0AyPDHyFd1FR/bREHFAqWO8KI/UttbtqC97PLUZxXOYdd9cZk7ToaNl6jM0/f4shgEodTOZkHVQFPcG7ioUeTCoaslrfVmC9kr9xw1btgNW+ZudgSCgYQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: a077265b-8574-4034-a6cd-08de8a180bbc
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 02:41:41.6157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HPLpoch0dJIMLHAkQxIbJP0YsgDPuZpTEpFsF86DcqA08eiTyarh0qqTYBZrUGKUChLiJvR2V+BaEuDR8X1s/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6932
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

On Tue, Mar 24, 2026 at 11:10:19AM +0000, Tvrtko Ursulin wrote:
> The xarray conversion blindly and wrongly replaced idr_alloc with xa_alloc
> and kept the GFP_NOWAIT. It should have been GFP_KERNEL to account for
> idr_preload it removed. Fix it.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Fixes: fec2c3c01f1c ("drm/syncobj: Convert syncobj idr to xarray")
> Reported-by: Himanshu Girotra <himanshu.girotra@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> ---
>  drivers/gpu/drm/drm_syncobj.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
> index 250734dee928..8d9fd1917c6e 100644
> --- a/drivers/gpu/drm/drm_syncobj.c
> +++ b/drivers/gpu/drm/drm_syncobj.c
> @@ -602,7 +602,7 @@ int drm_syncobj_get_handle(struct drm_file *file_private,
>  	drm_syncobj_get(syncobj);
>  
>  	ret = xa_alloc(&file_private->syncobj_xa, handle, syncobj, xa_limit_32b,
> -		       GFP_NOWAIT);
> +		       GFP_KERNEL);
>  	if (ret)
>  		drm_syncobj_put(syncobj);
>  
> @@ -716,7 +716,7 @@ static int drm_syncobj_fd_to_handle(struct drm_file *file_private,
>  	drm_syncobj_get(syncobj);
>  
>  	ret = xa_alloc(&file_private->syncobj_xa, handle, syncobj, xa_limit_32b,
> -		       GFP_NOWAIT);
> +		       GFP_KERNEL);
>  	if (ret)
>  		drm_syncobj_put(syncobj);
>  
> -- 
> 2.52.0
> 
