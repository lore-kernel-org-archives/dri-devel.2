Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42239C79F82
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 17:16:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 017F410FA8D;
	Fri,  4 Sep 2026 17:16:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="I31U/Jq2";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1FE610E55D;
 Fri,  4 Sep 2026 17:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788542168; x=1820078168;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=3x/B7kxHPC4jb/FU+Q7hHoF2gfJh4kt1fztcL9Nifyo=;
 b=I31U/Jq20gy7ddJOadUhk+9VDyv5OczcB3ZhOmDlvJInMDDmSt22ANlL
 ryXoKC+b2pfkqXD+S4Ps0KqlA8Hv0kiFeZ+SkhLpdgkvvNnTWtq2l9+as
 HA1ypj3L3tfpmH973i+2/LXXS69s8AVgDEdQ6mPRfshutW76QLX7R1Rzv
 x9u/Am00BfBijpIKIY2GX6mvLDybxuoUFbx1MIMCVD2hmli0dTTmAIqV6
 uB4iJpuvH90rdt6/MMhcNyBJw9ClIphy1yUB0A03IWS0d1GjT3IQHf2Qy
 Pn945J3CihaaJh/NojkP2G+Q5H3RuhdBJXZCWbsrFmT/p69FlxTywnS7s w==;
X-CSE-ConnectionGUID: sYaNXeI9Rv2CJtTjv7Ztzw==
X-CSE-MsgGUID: 4DlV70s/SV232+0uSvyJAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11896"; a="92919935"
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; d="scan'208";a="92919935"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 10:16:08 -0700
X-CSE-ConnectionGUID: 0LV7lFsTSiOrm/iEfzfEZA==
X-CSE-MsgGUID: Cxb40cyiR4iAUcABUNArGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; d="scan'208";a="274246565"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 10:16:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 10:16:08 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 4 Sep 2026 10:16:07 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.4) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 10:16:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBR+vVWsmskf6xW4qlLt6pXB2uPd0yrvmpEJAZqrxl/Uair0qZGVDmW8XetBXsgbJ4eTUY1/RNpmcBEw2YlxbjJqzDL+2bBJbjk7+tLU4s7ZL4FWB+fqp54U+ZGkFchLZpxG29yNzfmrcrJWGifxom3F1AOYdeGypI9jed9rtYBxLi2+1hcF2XnwIPVXll1MxU3vDNL/ObGyahY+KaHLoRjrGqousEnFv8sVc2sCCqYxFGMAwr1+nOX7n1KYPcjJ1AkIRvXPtSAk6V+RW3TOzo9YHPAKe/Lsf2ELNXpFRfCfaAwSG6UY3Dmu/S231Smi9M61HRFHP877FEgTVTpImg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=myRWiv/O/q9lO3p4TdbOBgJhEIXQA/T+WacerW703EQ=;
 b=G/CApwAsaQLCC/f0rvvPg3XgQCtmrNFAJufZ1+OMIN6avELzAyt91XCxSV7DQai9/D1KpULEItTbIi9qi1dHJgWznLxx6HgRR46I9av1eKebFJQjZy8oTVX7vlq7mcMTNrdHwril/QOhYavLGegvF148xD+nYBEq8OW4lUC0LtA2tx61H5xJbZ1WMHada9g84BB0EyGvolvkiM2bInDkMlCWm8qaa2pmls1yAVrOEcHvnLC0/YOdra/LH7AtOIzxIPoPzT657spu8XjVxURcF6edhg70y0OhhtDf3Fnpti3WQtvIkokMcyi9apnE0tXtbtV+cM6MroP/2EhNuvBHPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by MW4PR11MB6692.namprd11.prod.outlook.com (2603:10b6:303:20e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Fri, 4 Sep
 2026 17:16:05 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 17:16:05 +0000
Date: Fri, 4 Sep 2026 10:16:02 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Honglei Huang <honghuan@amd.com>
CC: <sima@ffwll.ch>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <himal.prasad.ghimiray@intel.com>,
 <dakr@kernel.org>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <aliceryhl@google.com>,
 <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>, <Junhua.Shen@amd.com>,
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v3 5/6] drm/gpusvm: keep a single DMA mapping inline for
 THP
Message-ID: <apr80lC17/7mduPU@gsse-cloud1.jf.intel.com>
References: <20260904163956.3433293-1-honghuan@amd.com>
 <20260904163956.3433293-6-honghuan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260904163956.3433293-6-honghuan@amd.com>
X-ClientProxiedBy: MW4PR03CA0327.namprd03.prod.outlook.com
 (2603:10b6:303:dd::32) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|MW4PR11MB6692:EE_
X-MS-Office365-Filtering-Correlation-Id: ea2e6c74-ee86-42d5-a341-08df0aa833d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|23010399003|1800799024|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: yFjZlUqHmM79Qn9PYEHDbhSkm4XD/0c+GuRLGfeo+QOqFR0qrSsZk1UfvGDbdaKg1MijXH7lNOmXPnY0/yKG59yud0Qz9G0NUdicFrO20GzkMYKm/gpXaMU3Wc5ALH+FAUHx4Fq3CJEouHgj0y+i8oAH6bKJOycw41PLn4rxGdA9QiwDgPTaik9kVs9q5KBP0nuRgfV8NUTnng0md5T+vLm897nEeqzpWPUquDPk4gxKPqid1E9vHN2yM8HLxgDE6Wi7c5WkqXb57wupeRv7HKNkEtpbZ2KCTGIH5ugRgaJfrU/RsXJDKh2J2Na8MLRiBwL1iuLzQCYCvkXgd8W+y8qPvmY9UxKJaS9UBlD2e0XEODNfxstc9s/wkmaTEL7spg0N5cvhuhxwFwx/76FI4EgNsaIJKHZSkSsmZjYhjUP8kbIjJKsVExJp/cIHBqhVzoK8ofvn+YARLMTY2ikQr4svXTQOPRYBWEt7fTVCD/jG2a89EWmSbwLry42Rhcn06KdyevJbrTQwSD9RgxFssf7LjCRHJGgpsoRSjldGm1fPeVWAH2D/rUbnN57kq6NHBw5pq63ZdzE0WRlKAFL6cLST63kB40IteHTt/gUjEf1YDewq0IOxEGl8anTh9FORzmpwZxqC/5O3Ms2GnlQeEx/bNCWthVtY19xnxnfFmzo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UEMagfqYMR8k6uGevdNTiROCp4jda5F8dygqWQiPqsxGfpUx5G7Kjjgtr7Q5?=
 =?us-ascii?Q?lVmru+9QEEoEgPAI3LzRYC/gnD2p4vIVRYRutqNP7xQWC1kKdMtCmo0pdDZ+?=
 =?us-ascii?Q?2OJH/Z8ka9e7U0kTAR2u3bmWInbGSSPgN1DRq6/PCrap80aCvG8hWyHFCszH?=
 =?us-ascii?Q?OF+U7oHAn7rr+QXknaqs62wG6DJzVTqu5YqjL8L3XxDy2mcIu8o374NM15bR?=
 =?us-ascii?Q?PpdSjqf/TePWKHdexvx1ySBay6tq5OCcBdrnsEC9nED2aITcpnFtnFqZLgjB?=
 =?us-ascii?Q?sGD7FqaKUmEw7Vp5gpipJt3XLOv8nO6RLk4FZ/jPTFaEHQMhnUhgqGqQzjEm?=
 =?us-ascii?Q?ysMxuz4LJWbXMbU5YSqPPpK82P6AotNMvWeDASwdEA9tTsGckTHjM1IlZaT8?=
 =?us-ascii?Q?CpVM7rGd4Wl7yJT3zoDTNIWdZeRyCC5hSzKkBqbpbTAVN60Y2N0zTBTHu8m1?=
 =?us-ascii?Q?ioi6N9xl6lTq1c8TpTTVxf+KhGCJ/eMDxkCxKzEv5yBj6K++rAsWNhNFHzhN?=
 =?us-ascii?Q?DLp3633jh3X9a5LFbHDYtLJZCPGcWwbIB7dHC3AEaBAv8nu1v9SiztFAdUTv?=
 =?us-ascii?Q?+AeI3Cx3d/UhuLooMMmov1FS8CWBthZAtbkt4oI1oGc410yHPYf3b985nutR?=
 =?us-ascii?Q?H6SYVGFFQVSpMXO3Ab+gZpsRWofhvQSMhqyh7S4Qif8UGdtntfI8Sify6A8p?=
 =?us-ascii?Q?fER9yBASbCpqOKNc4c1OPkgWIxBSZqtDc0OrNkggheB2T3OtlC5je8jkGFXF?=
 =?us-ascii?Q?y0ERBKdqaoRRM1pQ9BSyO2OOhPaOm+MZ5MCwsgBfmlIoMbMh01xQqbZUUtNl?=
 =?us-ascii?Q?JbSxRwAls8r6hHCSPp8Qyck0S8wasKaG4A2D7P6jqZ1mlR/1B1TO+duV62M+?=
 =?us-ascii?Q?yGLA2qtW6h0KfMNDPtYPE43w2Qd7J/2AuatHo3ZUL2RIWmgk1pB2bqXX0xvY?=
 =?us-ascii?Q?J9YHU6FvGTOp9eJzZ+6fg++sbgSUKpRCsRvAbr0/lVK3YMev1aVm4NztTcuW?=
 =?us-ascii?Q?nv7YaI/X4nPsd0UdVUCxugHMXwgHfEFky38+cMBFUTwZ6Bq0TV2YN+proskg?=
 =?us-ascii?Q?0jZx/Bp0rKU2GFt/+MDRI+liy9cbR/882RwiunoUXSDO1GzU47FXSFnfBGR0?=
 =?us-ascii?Q?qQAHzMHBs/51DjgCvTfCvU+Hr6X5Ie08a21ScU1afZN1RY2xq56HOGOjuu1i?=
 =?us-ascii?Q?+OXjS2JvOu5kgULzuuMoW+lZhvaujt5OhhGFg3nVL93TK1jbGACASCgJ2YOA?=
 =?us-ascii?Q?jAnR0A7EFDwHpB4r0G3AoR2N36Q4jMowOUIEFm4JQ7XgOFeqF8drJuoqAW4L?=
 =?us-ascii?Q?SVFVFkiSzi6+KRMK9WFYk/wTssIxnWH5RPlU40VHR2O9tCSHKGBM4nXuLs3X?=
 =?us-ascii?Q?vJ/AxfR4NVg94KhY6JAcAcJD2VIslnIkCqXLW77j7StH+hYoN9WGPaDbWbCh?=
 =?us-ascii?Q?CoaEqFZ9LPyeZUgliXJpK/cQW9xzLn4PmUdTmbJhoKdq+vlijkzgoX5xxhgp?=
 =?us-ascii?Q?HeWuFJmHe0eznyAELAslw34MoQqektJy2MqlYDs3w6/ETJnTXZHVDpNw+H49?=
 =?us-ascii?Q?09XTTLJMKRVdLx/TKdzQd6Rbb9yW16IgpAaUVjoQmDfOt6p+AHlYusXUz9KE?=
 =?us-ascii?Q?K6H7ocxmq3tApFb+2KLw9oIBDgF3hVYadTwp5yIPbBYarYEdHqktEej2BwOi?=
 =?us-ascii?Q?OStCAFs2LdVewDqPhRnLsZ6uQqNuZNJZUxbEKW4hhvUb/H4Arir0EIyrtMvI?=
 =?us-ascii?Q?DpQWaDNO1b6qCOHTNylJL6KuVLc9j+M=3D?=
X-Exchange-RoutingPolicyChecked: eSu/VhfdyRbXSL7H3Opsu4M55l6cceeSP8oxw6sOlx64nIu3RZ4xLjOOUitNUjXwskC70PT1r4LxS2PvEdoOHbD1cz8q8AsJyKdwveLdROT3Gcf8MZ+YZfDDWO2pAu3g370SwirOUe/QQz+X7l5UjAVNaf/8tyZ9+99ECo6ZEMqKJr5Fjtcl0lCvW83Gyc5D7CpA+aSrWzNOeLhu5kPUdPwSFL/WZrr6wCisvjbI/0n6ac6sbIkZ+4uWfhR8NCcB8wXXDDy/Vd1vSrAboUVpBB0Mz0zOVGSDuj8rIopupuDSKpOx7a+LXBL++6fyADMv5xe0vl776R7OJ6mc0IKoPA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ea2e6c74-ee86-42d5-a341-08df0aa833d4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 17:16:05.1679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3F3jKCfymYF13L5KQDpxDI7Ga0QN4EaHUTMf41duVXl78S3FATv3mBBExDCv9TYTiXFgIXXY+TIkdaUHzfe1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6692
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

On Sat, Sep 05, 2026 at 12:39:55AM +0800, Honglei Huang wrote:
> drm_gpusvm_get_pages() sizes the dma_addr array for one drm_pagemap_addr
> per page, but the mapping loop advances by page order, so a range backed
> by one huge page needs a single entry. For a 2 MiB THP that is an 8 KiB
> array holding 16 bytes of address.
> 
> Union that entry with the array pointer, discriminated by a new
> inline_dma_mapping flag. When drm_gpusvm_dma_map_pages() ends up with one
> entry it stores it inline and frees the array, after the last error
> unwind, which still walks the array form. An unchecked dma_addr read is
> now type confusion rather than a compile error, so reads go through the
> new drm_gpusvm_pages_first_dma() accessor, including the two
> xe_pt_stage_bind() paths.
> 
> Only get_pages() and the free path write the union, never the notifier,
> and both run under the driver lock that every address reader already
> holds. The unlocked short circuit in drm_gpusvm_pages_valid_unlocked()
> goes for the same reason: it cannot resolve the union, and every instance
> it rejects has to be reset before the allocation loop reuses it.
> 
> Suggested-by: Matthew Brost <matthew.brost@intel.com>
> Signed-off-by: Honglei Huang <honghuan@amd.com>

We have one build issue / CI failure on the Xe side, Sashiko also
flagged the issue (replied there) but other than that LGTM.

Thanks for doing this.

Matt

> ---
>  drivers/gpu/drm/drm_gpusvm.c | 48 ++++++++++++++++++++++++++++------
>  drivers/gpu/drm/xe/xe_pt.c   |  7 ++---
>  include/drm/drm_gpusvm.h     | 50 +++++++++++++++++++++++++++++++++---
>  3 files changed, 91 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index 7efc35507f1..2c7c4c89dc4 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
> @@ -1241,6 +1241,8 @@ static void __drm_gpusvm_unmap_pages(struct drm_gpusvm *gpusvm,
>  		struct drm_gpusvm_pages_flags flags = {
>  			.__flags = svm_pages->flags.__flags,
>  		};
> +		const struct drm_pagemap_addr *addrs =
> +			drm_gpusvm_pages_first_dma(svm_pages);
>  		bool use_iova = dma_use_iova(&svm_pages->state);
>  
>  		/*
> @@ -1253,12 +1255,12 @@ static void __drm_gpusvm_unmap_pages(struct drm_gpusvm *gpusvm,
>  			if (svm_pages->state_offset)
>  				dma_iova_unlink(dev, &svm_pages->state, 0,
>  						svm_pages->state_offset,
> -						svm_pages->dma_addr[0].dir, 0);
> +						addrs[0].dir, 0);
>  			dma_iova_free(dev, &svm_pages->state);
>  		}
>  
>  		for (i = 0, j = 0; i < npages; j++) {
> -			struct drm_pagemap_addr *addr = &svm_pages->dma_addr[j];
> +			const struct drm_pagemap_addr *addr = &addrs[j];
>  
>  			if (addr->proto == DRM_INTERCONNECT_SYSTEM) {
>  				/*
> @@ -1299,6 +1301,18 @@ static void __drm_gpusvm_free_pages(struct drm_gpusvm *gpusvm,
>  {
>  	lockdep_assert_held(&gpusvm->notifier_lock);
>  
> +	if (svm_pages->flags.inline_dma_mapping) {
> +		struct drm_gpusvm_pages_flags flags = {
> +			.__flags = svm_pages->flags.__flags,
> +		};
> +
> +		svm_pages->inline_addr = (struct drm_pagemap_addr){};
> +		flags.inline_dma_mapping = false;
> +		/* WRITE_ONCE pairs with READ_ONCE for opportunistic checks */
> +		WRITE_ONCE(svm_pages->flags.__flags, flags.__flags);
> +		return;
> +	}
> +
>  	if (svm_pages->dma_addr) {
>  		kvfree(svm_pages->dma_addr);
>  		svm_pages->dma_addr = NULL;
> @@ -1463,11 +1477,6 @@ static bool drm_gpusvm_pages_valid_unlocked(struct drm_gpusvm *gpusvm,
>  	bool pages_valid = true;
>  	unsigned int p;
>  
> -	for (p = 0; p < num_pages; ++p) {
> -		if (!svm_pages[p].dma_addr)
> -			return false;
> -	}
> -
>  	drm_gpusvm_notifier_lock(gpusvm);
>  	for (p = 0; p < num_pages; ++p) {
>  		if (drm_gpusvm_pages_valid(gpusvm, &svm_pages[p]))
> @@ -1480,6 +1489,21 @@ static bool drm_gpusvm_pages_valid_unlocked(struct drm_gpusvm *gpusvm,
>  	return pages_valid;
>  }
>  
> +/**
> + * drm_gpusvm_pages_inlinable() - Whether the dma address can be inlined
> + * @nentries: Number of entries the mapping loop produced
> + *
> + * A THP maps as one huge page, so the whole range needs a single device
> + * address: the dma_addr array can be freed and the address kept inline,
> + * which is where the memory saving comes from.
> + *
> + * Return: True if the mapping fits in a single drm_pagemap_addr.
> + */
> +static bool drm_gpusvm_pages_inlinable(unsigned long nentries)
> +{
> +	return nentries == 1;
> +}
> +
>  /**
>   * drm_gpusvm_dma_map_pages() - DMA map one drm_gpusvm_pages instance
>   * @gpusvm: Pointer to the GPU SVM structure
> @@ -1632,6 +1656,14 @@ static int drm_gpusvm_dma_map_pages(struct drm_gpusvm *gpusvm,
>  	if (pagemap)
>  		flags.has_devmem_pages = true;
>  
> +	if (drm_gpusvm_pages_inlinable(j)) {
> +		struct drm_pagemap_addr addr = svm_pages->dma_addr[0];
> +
> +		kvfree(svm_pages->dma_addr);
> +		svm_pages->inline_addr = addr;
> +		flags.inline_dma_mapping = true;
> +	}
> +
>  	/* WRITE_ONCE pairs with READ_ONCE for opportunistic checks */
>  	WRITE_ONCE(svm_pages->flags.__flags, flags.__flags);
>  
> @@ -1740,7 +1772,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  
>  	if (map_dma) {
>  		for (p = 0; p < num_pages; ++p) {
> -			if (svm_pages[p].dma_addr)
> +			if (drm_gpusvm_pages_first_dma(&svm_pages[p]))
>  				continue;
>  			svm_pages[p].dma_addr =
>  				kvzalloc_objs(*svm_pages[p].dma_addr, npages);
> diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
> index 5d990c1c374..96ea9735f34 100644
> --- a/drivers/gpu/drm/xe/xe_pt.c
> +++ b/drivers/gpu/drm/xe/xe_pt.c
> @@ -831,7 +831,7 @@ xe_pt_stage_bind(struct xe_tile *tile, struct xe_vma *vma,
>  			return -EAGAIN;
>  		}
>  		if (xe_svm_range_has_dma_mapping(range)) {
> -			xe_res_first_dma(range->pages.dma_addr, 0,
> +			xe_res_first_dma(drm_gpusvm_pages_first_dma(&range->pages), 0,
>  					 xe_svm_range_size(range),
>  					 &curs);
>  			xe_svm_range_debug(range, "BIND PREPARE - MIXED");
> @@ -866,8 +866,9 @@ xe_pt_stage_bind(struct xe_tile *tile, struct xe_vma *vma,
>  
>  	if (!xe_vma_is_null(vma) && !range && !is_purged) {
>  		if (xe_vma_is_userptr(vma))
> -			xe_res_first_dma(to_userptr_vma(vma)->userptr.pages.dma_addr, 0,
> -					 xe_vma_size(vma), &curs);
> +			xe_res_first_dma(drm_gpusvm_pages_first_dma
> +					 (&to_userptr_vma(vma)->userptr.pages),
> +					 0, xe_vma_size(vma), &curs);
>  		else if (xe_bo_is_vram(bo) || xe_bo_is_stolen(bo))
>  			xe_res_first(bo->ttm.resource, xe_vma_bo_offset(vma),
>  				     xe_vma_size(vma), &curs);
> diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
> index ec7b81957b1..aaad5c9b510 100644
> --- a/include/drm/drm_gpusvm.h
> +++ b/include/drm/drm_gpusvm.h
> @@ -10,6 +10,7 @@
>  #include <linux/kref.h>
>  #include <linux/interval_tree.h>
>  #include <linux/mmu_notifier.h>
> +#include <drm/drm_pagemap.h>
>  
>  struct dev_pagemap_ops;
>  struct drm_device;
> @@ -18,7 +19,6 @@ struct drm_gpusvm_notifier;
>  struct drm_gpusvm_ops;
>  struct drm_gpusvm_range;
>  struct drm_pagemap;
> -struct drm_pagemap_addr;
>  
>  /**
>   * struct drm_gpusvm_ops - Operations structure for GPU SVM
> @@ -112,6 +112,7 @@ struct drm_gpusvm_notifier {
>   * @unmapped: Flag indicating if the pages has been unmapped
>   * @has_devmem_pages: Flag indicating if the pages has devmem pages
>   * @has_dma_mapping: Flag indicating if the pages has a DMA mapping
> + * @inline_dma_mapping: Flag indicating if the pages have an inline DMA mapping
>   * @__flags: Flags for pages in u16 form (used for READ_ONCE)
>   */
>  struct drm_gpusvm_pages_flags {
> @@ -121,6 +122,7 @@ struct drm_gpusvm_pages_flags {
>  			u16 unmapped : 1;
>  			u16 has_devmem_pages : 1;
>  			u16 has_dma_mapping : 1;
> +			u16 inline_dma_mapping : 1;
>  		};
>  		u16 __flags;
>  	};
> @@ -130,17 +132,27 @@ struct drm_gpusvm_pages_flags {
>   * struct drm_gpusvm_pages - Structure representing a GPU SVM mapped pages
>   *
>   * @drm: The DRM device that owns the dma mappings
> - * @dma_addr: Device address array
> + * @dma_addr: Device address array, valid while @flags.inline_dma_mapping is
> + *            not set
> + * @inline_addr: Device address inline address, valid while
> + *               @flags.inline_dma_mapping is set
>   * @dpagemap: The struct drm_pagemap of the device pages we're dma-mapping.
>   *            Note this is assuming only one drm_pagemap per range is allowed.
>   * @state: DMA IOVA state for mapping.
>   * @state_offset: DMA IOVA offset for mapping.
>   * @notifier_seq: Notifier sequence number of the range's pages
>   * @flags: Flags for the range; see &struct drm_gpusvm_pages_flags
> + *
> + * @dma_addr and @inline_addr share storage, discriminated by
> + * @flags.inline_dma_mapping. Driver should use drm_gpusvm_pages_first_dma()
> + * to access the correct DMA address.
>   */
>  struct drm_gpusvm_pages {
>  	struct drm_device *drm;
> -	struct drm_pagemap_addr *dma_addr;
> +	union {
> +		struct drm_pagemap_addr *dma_addr;
> +		struct drm_pagemap_addr inline_addr;
> +	};
>  	struct drm_pagemap *dpagemap;
>  	struct dma_iova_state state;
>  	unsigned long state_offset;
> @@ -365,6 +377,38 @@ static inline void drm_gpusvm_init_pages(struct drm_gpusvm_pages *svm_pages,
>  	svm_pages->notifier_seq = LONG_MAX;
>  }
>  
> +/**
> + * drm_gpusvm_pages_first_dma() - Resolve the device address array
> + * @svm_pages: Pointer to the drm_gpusvm_pages.
> + *
> + * drm_gpusvm_pages use unions to optimize the storage of DMA addresses,
> + * this function abstracts the access to the first device address. The driver
> + * should use this helper instead of reading dma_addr directly to prevent
> + * array out of bounds access.
> + *
> + * Only get_pages() and the free path switch between the two union members.
> + * Both hold the notifier lock for read, so taking that lock does not stop
> + * them; callers need the driver lock that does, which every reader of the
> + * addresses holds anyway. The notifier never touches the union, so the
> + * pointer returned here stays good and can then be used under the notifier
> + * lock.
> + *
> + * Return: Pointer to the first device address, NULL if none is populated.
> + */
> +static inline const struct drm_pagemap_addr *
> +drm_gpusvm_pages_first_dma(const struct drm_gpusvm_pages *svm_pages)
> +{
> +	struct drm_gpusvm_pages_flags flags = {
> +		/* READ_ONCE pairs with the WRITE_ONCE of the flag writers */
> +		.__flags = READ_ONCE(svm_pages->flags.__flags),
> +	};
> +
> +	if (flags.inline_dma_mapping)
> +		return &svm_pages->inline_addr;
> +
> +	return READ_ONCE(svm_pages->dma_addr);
> +}
> +
>  /**
>   * enum drm_gpusvm_scan_result - Scan result from the drm_gpusvm_scan_mm() function.
>   * @DRM_GPUSVM_SCAN_UNPOPULATED: At least one page was not present or inaccessible.
> -- 
> 2.34.1
> 
