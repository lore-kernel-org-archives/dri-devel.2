Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF197C79FAA
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 03:12:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E36F10E96B;
	Tue,  8 Sep 2026 03:12:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Zsy+17/K";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1D0010E0A0;
 Tue,  8 Sep 2026 03:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788837159; x=1820373159;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=5VzLsbaesXAvaFfy/keNnI0bhicEkerfqZaR3gsZLUM=;
 b=Zsy+17/KFVBjAGwGUpw/+o0fR6lUhwpBv9UVU7pSlq+pTBNmob/6BTH5
 /bTWJtoZqJ8BEAYKK4weBrNGSGdw6mnaOIllkG+mCReKrOLTCBUHw5qvU
 ZFnqEonxYgep8x1UTjG5VRy61SjLc1k8NCs+jEDe7+iKsEIlQkpTLjWVv
 pITe5PjtSz/wxHVR0GOFDCk1jdACygVAMXLsfSdWfAQ90y0lZ3/o+alSc
 hK6x8St2mdWz3Kd2JB+UAAVCV3PpzrCYmT2NkBa3NDznz7Yvm17BZQyCF
 s8Hv+GvjJBbnwxuoeNYRVKptwhB21k+//jfdk+wN5/TFWAqhRfrU/WUzm Q==;
X-CSE-ConnectionGUID: 7dtwQup6TJ+ScVPjxa3c6A==
X-CSE-MsgGUID: 9PtZcmNsQDuSDKFw1Km70A==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="99563512"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="99563512"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 20:12:38 -0700
X-CSE-ConnectionGUID: UzMpYxKyRN+TMg+a2Wxd8w==
X-CSE-MsgGUID: cIwRjYTER1uv4Ycitkq1Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="300739854"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 20:12:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 20:12:36 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 7 Sep 2026 20:12:36 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.32) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 20:12:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EosUpntDlKce6C4p+bGirZQdJweafPs88weV4FXR/JhluB7Qi5vjOX23sbNdhxje+b7L4n3BHVCYXFT74vtjX1Q2tzE8ZieJHTurqPREshrJRjAjsqEX14lHDz0AzQPirsST9Pxt6ANd8ke+j8tIyDjwil37HLrL9JOoYHK5q6h1hbjlaT4PCWVV1jHUGjoQps/HRB3zI0X9vejxoMEpzeBtVqpLBbsGIcJOL8RSaU4TugqJ7J6vox18L6puGjz0RxJx+NxNv2Odk5ALlpMoIvSuGbybwMY+170ZtkFy7XDLbsMNpnbENJY5qD4YdJG7h/SEILI1BAzrc8uhaOvHwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GojCxKjQBG7wurwa9LmoVmVrpyfSQSSk2IGpPEY4Nag=;
 b=tRCB/Q0QtjLKQsx9SAA5D/do98Ejt44dGS2e42UDz0IX12uDHjyqgZIaIA6xMG7n0uJQKXT5nqNWT/SLV9PQpTQRYG1yN5vddP/CyF2326npYslc6AIWkcj03/fzix9569t0OnO3N0TwxbB5x6q+eDzBxRHCJxs5BcvGFasUGH8pkzfrgieU4dxjMVFwRC5RN+DtjQ/aU7xpY+puvROJGtqIeRYYd7NyK5gltlu/mW63luYn9gYttNYDBvtNGa4kgPc2gan+4H+uQJgn1cOkuLXqXYXNxMTg9GaQp2q8+Z2BMgCVcwit2zObQDm9NTRCoNa58asNDS5D1WaQU8K2gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by SN7PR11MB6969.namprd11.prod.outlook.com (2603:10b6:806:2a9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 03:12:32 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%3]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 03:12:31 +0000
Date: Mon, 7 Sep 2026 20:12:29 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Honglei Huang <honghuan@amd.com>
CC: <sima@ffwll.ch>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <himal.prasad.ghimiray@intel.com>,
 <dakr@kernel.org>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <aliceryhl@google.com>,
 <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>, <Junhua.Shen@amd.com>,
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v4 5/6] drm/gpusvm: keep a single DMA mapping inline for
 THP
Message-ID: <ap99HVgI0GBq5Vma@gsse-cloud1.jf.intel.com>
References: <20260905133142.3628027-1-honghuan@amd.com>
 <20260905133142.3628027-6-honghuan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260905133142.3628027-6-honghuan@amd.com>
X-ClientProxiedBy: MW4PR03CA0267.namprd03.prod.outlook.com
 (2603:10b6:303:b4::32) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|SN7PR11MB6969:EE_
X-MS-Office365-Filtering-Correlation-Id: 3534d0b0-538c-48f9-bac5-08df0d57054d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Jwr+AY0XicTqi6DDiq7RYgMfrYldz7e6CAp2gFDMEd6Bh4XcXLnRfsafNE+YZ2z4HwmuRvgXjfYIHek8u+Sj/H9OP5sNn5qkdMyOqToKLtNgQjBZdpaj7J/vIPOeR50f36gk3TuADDoupskQbDgjzYDq2moY8/Yh2OgAUxEa1uAMqhg2S6fQSs6v7N7aTWPPjPFHt/YqwFuZBb3SVh7GmOzL/DSHzsCUBnleMTbMpWoDmsfa9pv0Et91TdYT8NpZwnK23Sov+Ji5+TEH/R8iE+I0Y5I6XTYlxQNifJvxQLEFeCTLdpK+RsFDdfCrRZL3RUGXntMqSLcugkHGoyTNMAfmvPSQpgCgdefmk3vucejWmLKUeOfH6zzXPjdZCv+joENHiefdJR5LGAuGgYCw6jc6mXWrFfPPuHKuPGwQTCMQPs9BYu153LMOZEbD6jrs2keS/SuGmoRrHORmcVWwmz2JEDv028HFRn0DDi8/Eq0px7jm3RPX3OA+rE7Qp7F4VUd7f0sQgrm1FldQA2Syyd+xg0nc6j/uDc2yTCMdAc8o7CTZ4JcXoz/LWKKPnrhZHy7vIlwZD0AAARCzA+GNh+1gbrzdCDvziAbz/OdMomsuLNR+w9aCnd+7XFZ+3jlq9L1nwLdHx4uenWqnSYAUhHK5WVRB91OsCiOw2NBE4sM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sd96oOqB5INcHgiwt0VfakDkVtUx7o93jNwmH8qiK5FKDDZgM6R3fY/IKgUQ?=
 =?us-ascii?Q?6DJo2Biam7wgN5vRgkbzUbVo58lOoKiFLZyT6hAVojNUaeGGSHSmO97Nj4ky?=
 =?us-ascii?Q?tH2Zap+tTUsOW5wcq8IA+nfQGxGA66RiglUocOSenOYHvkhdnSZfzv6GBQyd?=
 =?us-ascii?Q?ZtY6CNIX1+DHBS31wLtTliZ/gj/JfFxXRtbnCt4UL9grBJ7uoYixRIynOPqJ?=
 =?us-ascii?Q?4jG3bAeJ6V3clPUdBaxcdOceeQMDa7bBANcC87x61aUBdKsYVnlPuGgz3PiK?=
 =?us-ascii?Q?uZNI5aXUhJDuk/UZX8SujQkopHwCxU40Fz2+znptGOnp7hM7KNQ0W6pZjyP0?=
 =?us-ascii?Q?DjATLxnYyBrzsEkKkb8XZWlBOedpDW1uZGHop2lijpp4cdDPnEnUh7Htkb97?=
 =?us-ascii?Q?cRrCStyegB3/UDTS7AU3S729llCpdvf6ogpy3p6YdBMs1m0oUR97AXi7jkfW?=
 =?us-ascii?Q?oL6NygzfGglu7IB1sKo3T2h6mMLfCc2APX6owizqmDpUhc+ItMsjsSqn5Xf6?=
 =?us-ascii?Q?fL6Ob9zemWrGTp6WeMYBh1HxO0/IaBw+M4OxeNipsyiyu3n+SczQWqiAByOe?=
 =?us-ascii?Q?9y73kjXY1mJGCsc4bvSy9jV+D9UaFa0FH7BrRAbVwF5KeEamksRuUFtj+ize?=
 =?us-ascii?Q?UaF/sL8WcSiSNoE2SYbUa9nWxl18ag6dYJYha7lZYEQonIYaGwF9kBKu3f24?=
 =?us-ascii?Q?97dkVwirh6rgaeQJ4h4EQwkfnsS/mQzgY6Pbl5i46mqjxrsE6SUDBjHx+P9d?=
 =?us-ascii?Q?47olVjS2lpCYfQI+c1vyJU76/zBaATbG6o6k07HA5Mh9AtgI8TsjTXeXantn?=
 =?us-ascii?Q?EIIrTxckLpLGTN1EfYnd51cKRm8vy97vP4Dkqz4dAs/sPs29WlUcEPQxc+t3?=
 =?us-ascii?Q?U82PHyye/bDHkolaF669JvEatDG7c2X1LESV02TZaZGvaUYoJcRVVbJfcXES?=
 =?us-ascii?Q?cq0KuVQcYTcP/dE+HS7Ou4NAJiKLHcsU9rXeIGD/w8QgUcehBFTr93af8/hS?=
 =?us-ascii?Q?NZiIfOs93XQ+/R+Xl29yYZ4qmFC5RD9s0qR+WgrbvkRnkeJVkckLcwVv0PVp?=
 =?us-ascii?Q?Xdcd9OL/PJKHzB1N3h2uRhJTTpuH7a2/dx5r7yYU7IEmxkrcw2tZVTkfCJyT?=
 =?us-ascii?Q?8jqI9+u/fMUmNHRapSttGqec8YUyhKRFDaS1DI60nOD8hvEQSvcU0ltvGxfv?=
 =?us-ascii?Q?DYXi96UZ2CIX/EeGdtVeyEqx7FLmZRnyVBcOsPuwL5c+EJsXxqq33VZr3bW2?=
 =?us-ascii?Q?wVCofoun13m79w8WoVPAcqS7Bpo5fz0051Wue1RAKa+x9nzwcbo3AHioCyn7?=
 =?us-ascii?Q?rkAH/FMvyeR8nppO1O4eaZz4wwbWOMNFf5yC0Nob4vNkSo/RMrwt4Y8TIFZo?=
 =?us-ascii?Q?BGmX7MRQAskzTsKWqdWVa9dJstbPIR1JDQPHhds8b781OkALSmyaNnlFxavj?=
 =?us-ascii?Q?6ns8LviQEU6VWxPRWNQGdK8OXj9qp6OTS+Wy5a4vFZS6Chf7lIwppp6hizFA?=
 =?us-ascii?Q?p/GcDin9i21dXlf1SFzkimyHgo2hlA8hgINg9ijHmq020xcpwyYWJvAZV+s0?=
 =?us-ascii?Q?zOglOTJhT4rlkhPEl03efCI7F/re9bY27cqXNUoFfWy4arwDbzXBZgt2rjpE?=
 =?us-ascii?Q?+noUyNh0m3eZo0PC0W9VORN1Wrxe9YAKwm3ooUTkY9PQLZ/znoaa+N0ZnHFT?=
 =?us-ascii?Q?gr2o0iC4/zfRBBfaBlpSLmeDSQbe3VHl1DFKy26xjfHUiEXbytAcX8vE5rZE?=
 =?us-ascii?Q?cLpWw1khuw=3D=3D?=
X-Exchange-RoutingPolicyChecked: kvpJ7vaMfDkZ+T+Fcg6wHXuks3xiZR30CTyCazJ1CbUUt+DknSa56WS+jLHuBmwe9XIdIZE3XuxRNXgdBgnWvWLPU7FncqP7W0pWHPscHVw4/du5Jg0/CwQaL1sQUsFTVcUvQ2k90+zptoMuWOgdL0vIFno38ERjNI1Y0cupfOSdTschyfZMhEp1fGhQRksLO62Yehv1jSU/hmo4DUPCbPF+Y7xqb4WvWQMSexxc7BQX9peaeU9xys5AT2BluWgW2OVerf6PSZasDsvfVOYqBp+whFPsWPD0gX/dDrgJYfFZNLSa/jakor2gJrY7VGmy+vkyvFtkD2DKY5eugj5Ndw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3534d0b0-538c-48f9-bac5-08df0d57054d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 03:12:31.4293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eh3IfuSKrWPVhOcDoPYEHcFIZMmK+piL3jkCzief40LRHm9AS5gfI23johABMxK+kSIcJ38P/349OVHB+OJbRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6969
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

On Sat, Sep 05, 2026 at 09:31:41PM +0800, Honglei Huang wrote:
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

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>  drivers/gpu/drm/drm_gpusvm.c | 48 ++++++++++++++++++++++++++++------
>  drivers/gpu/drm/xe/xe_pt.c   |  7 ++---
>  drivers/gpu/drm/xe/xe_svm.h  | 18 +++++++++++++
>  include/drm/drm_gpusvm.h     | 50 +++++++++++++++++++++++++++++++++---
>  4 files changed, 109 insertions(+), 14 deletions(-)
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
> index 5d990c1c374..fa4b29da0b6 100644
> --- a/drivers/gpu/drm/xe/xe_pt.c
> +++ b/drivers/gpu/drm/xe/xe_pt.c
> @@ -831,7 +831,7 @@ xe_pt_stage_bind(struct xe_tile *tile, struct xe_vma *vma,
>  			return -EAGAIN;
>  		}
>  		if (xe_svm_range_has_dma_mapping(range)) {
> -			xe_res_first_dma(range->pages.dma_addr, 0,
> +			xe_res_first_dma(xe_svm_range_first_dma(range), 0,
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
> diff --git a/drivers/gpu/drm/xe/xe_svm.h b/drivers/gpu/drm/xe/xe_svm.h
> index 2a0dc0d125c..7eb80d4d6db 100644
> --- a/drivers/gpu/drm/xe/xe_svm.h
> +++ b/drivers/gpu/drm/xe/xe_svm.h
> @@ -220,6 +220,18 @@ static inline unsigned long xe_svm_range_size(struct xe_svm_range *range)
>  	return drm_gpusvm_range_size(&range->base);
>  }
>  
> +/**
> + * xe_svm_range_first_dma() - Resolve the device address array of a SVM range
> + * @range: SVM range
> + *
> + * Return: Pointer to the first device address, NULL if none is populated.
> + */
> +static inline const struct drm_pagemap_addr *
> +xe_svm_range_first_dma(struct xe_svm_range *range)
> +{
> +	return drm_gpusvm_pages_first_dma(&range->pages);
> +}
> +
>  void xe_svm_flush(struct xe_vm *vm);
>  
>  int xe_pagemap_shrinker_create(struct xe_device *xe);
> @@ -436,6 +448,12 @@ static inline bool xe_svm_range_is_removed(struct xe_svm_range *range)
>  	return false;
>  }
>  
> +static inline const struct drm_pagemap_addr *
> +xe_svm_range_first_dma(struct xe_svm_range *range)
> +{
> +	return NULL;
> +}
> +
>  #define xe_svm_range_has_dma_mapping(...) false
>  #endif /* CONFIG_DRM_XE_GPUSVM */
>  
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
