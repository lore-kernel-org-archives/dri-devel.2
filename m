Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7543F606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 03:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=K8DKoWxe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB6AD10F99B;
	Wed,  4 Nov 2026 03:41:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0D0910F99A;
 Wed,  4 Nov 2026 03:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793763678; x=1825299678;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=vdazrcoxpyMMcRS7Sa98QPHG9DGOX2nYxPIQfhWrzYo=;
 b=K8DKoWxemiP8+KqyeVEeoga+83G3Wyd2KEsGmxD8z6A4HmRd4kaiM78/
 witNSvWmiuFeGDudMdOiuvsB43EnfmJKmSpaBGfb7RPqU+sT4U2tD1YJQ
 GqRWGmp0H3fmX26pPg7lAFgdvEnuLxUbwob7lSAJnVyaOt3mSkAbviu2z
 9STMSweYbs0ifYnabbL5nciCiuT9bSmSc+9dH1GJPzt8e08rwDiG6Dxu0
 0rqdBTsDKSdCQLOXzIAYYepJxrYS3ZaGhms4gzOwZdV8vVdtaOtMg5xKL
 uWa50HPCy6WBEP0PxdJBHPcidLukp70/HRQzPwQOX1VoajHZfZMZ6nID6 g==;
X-CSE-ConnectionGUID: v9IKOa9oRECdWlfK6o3lDw==
X-CSE-MsgGUID: Xws4eUlBTCK5g9Q2dk4X0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2390104"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2390104"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 19:41:18 -0800
X-CSE-ConnectionGUID: vpyqXhhWTAiPPioM3XgfrA==
X-CSE-MsgGUID: EnTNG8sFQoSXEq8b5To8Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="8392139"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 19:41:18 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 19:41:17 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 19:41:17 -0800
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.34) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 19:41:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RC0N95C3ZlD8vEW52KrEfxOQ7pO4Q74b4SwKZiSp43KeRxXmxPs+5mCS6xjYIm4EXDg+hvMsJQg3K4FxnvWxzEZq/aMEIPKR2TDUoIjfJG/rQ2xruovi07nVbnT13AaG159uRvIGCgDT0Mdm+x72xVw+UUjCSFmCVYbSS1ywZbuLt/WCSyGaB4N+0gf3YtUqLewukIig/evi2altA3cHXbE2Fqs4FSGi1r1m/gHiSXQFBNx8jXU4yu9gyijTxdsx6v/aGK5JR1Mp+N/S1TkgIdpaEb608CKywD3U44gwrjAjBDcfX4EQt2fpEOIyiDUCNS72Bf75CZ8rucGmMrN8Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pd8IGEjxhP/GW/XWfxlXwIyp6HhqyoIMyFQ/jdLMRXI=;
 b=IWE3YErKx6n92qLGExXvMjW7YKxlqZd4Bk18ladSrXuUi0R97mmszLCOczvr/JfTWmpeRVwbmDiWpd6z9l3QUCHhnw8dQt2XA1v724YAK/Kl1ckRNTctbGvp/DtcAL4pgZMiP+tTEFfXo1CJWX9Gr6MCQC61KX1KaoPB8xxzaFOg599GxcwkXtSpzyjr41nyGS24kCAnbraxG2q2QRD9WwcOQlvKhgpckFjqKEySg7B4tyuE0Yr/5e8YFm2IZtbnxZNVLGet/CFjK4QcY204blneFFH6NzhnB8F5xxiFxqysslF2Jgn+YYHTpiMzxhi6Q/dmJW0JQKVV5rdup36yAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by PH7PR11MB6796.namprd11.prod.outlook.com (2603:10b6:510:1ba::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 03:41:09 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0569.011; Wed, 4 Nov 2026
 03:41:08 +0000
Date: Tue, 3 Nov 2026 19:41:06 -0800
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v3 11/33] drm/gpusvm: Add a DMA-mapping accounting callback
Message-ID: <auqpUmz15VVS3aSB@nvishwa1-desk>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-12-matthew.brost@intel.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260711025619.2540575-12-matthew.brost@intel.com>
X-ClientProxiedBy: SJ0PR03CA0101.namprd03.prod.outlook.com
 (2603:10b6:a03:333::16) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|PH7PR11MB6796:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d010d0f-d7fa-44d6-1cee-08df3a257635
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|4143699003|11063799006|5023799004|56012099006|261009221227099003|261021123027099003|261009223027099003|261022105027099003|261102123227099003|261022075727099003|261021121427099003|261028144727099003|261026121527099003|261026140227099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: Fe9RRqEwB9DB96qEB4nSnolrNpGCTuumKzV7/R2kdA3E5FjIGKrH0yQViz1NRVwlF7r9N9IW0CbZeXFoAsxspxyVgdcUGjByR7YBRvzQjL9fpFdCkzqtQuF+w4YgqChyX0dvbfLb8VsRFGCgwUwuvPKnKUv4zeiJVYe5gQQthCkf8t+Qp0rSU9lUba8p2IxlGsCiH69SvwHeYjyq8XgUkFKDgYyCn5Ndy6mV5GbSHeLL2pJZVnEO9ccIm35Jebxr/3fpfvpOEdpTNljv/qz6abJrfJTzxgrqZIuMj60Dvh6LmlxoxzC8foe+kJpLc+op3Y4Y3kI6Oo86rSohitQBWAOylyUtB01ETgpqe87UrRoE+CXfY4i/N5ONCfr+UZV84szy1IEX2wp9iCQ+vmbFJKUE7+3cTXywEOPvjwvZ/mk8AiRzzS4kE4SABiAr2PhPk6kbnMhRjJX+MsKMtoLP/WdxFeOsV7o/GLfquTlYuiy3412W7vyF0lphk0IHZ0BNshxAqdWx1uNTZ8u2Ce4ZyrQE8gVjrWr5eSwpc7r5LRAzRqWDI0ut6FDXcBF14M+JdfcmT6X32rEsIPLg3XPWVg3rgzcfnrbMdrkcG0TRjNp91xJGxLDCyw44+H49u7WuFYhZ9PZ3J6kd+91KWzGGMLGyXFHa/HHDC4AFy5tjTAk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(4143699003)(11063799006)(5023799004)(56012099006)(261009221227099003)(261021123027099003)(261009223027099003)(261022105027099003)(261102123227099003)(261022075727099003)(261021121427099003)(261028144727099003)(261026121527099003)(261026140227099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?8VJomov+oGlwIKjvMYChY+kjkqCES5Enrsz6/DgwOjYXcB3iOd+mPIuIk5?=
 =?iso-8859-1?Q?OtdZNW5HWEnVv49Ax6cMCxUSiktR1uuP5AhK/8j9Aa0WketS9W4NUG95DM?=
 =?iso-8859-1?Q?ffxN8H0LqWBp57o42FPobAttDqmyQ1T4kzfZJ9WD9DXdei1PebgxX38ccS?=
 =?iso-8859-1?Q?ILIIOAXLMmr5SrHN5JmwXqzk21nUP8OYhOk45V6MnZWXZaDCSXPPhkOtlB?=
 =?iso-8859-1?Q?7zP02a0CSrklk3DrP0p0c+hiw7deFPR7EZopu3dCvEqjYRohb9SRouo/7o?=
 =?iso-8859-1?Q?pl2KF2h2hAF7qQzi1+dE/vN/UxTA6ek1WsnFTHD/RSKufFxtkN+5IMHmvm?=
 =?iso-8859-1?Q?VBAYZyu2n36YVukzFkfHcuVZXF2yw4VmPuPkzDa757+lA9kyao6RzRbKsr?=
 =?iso-8859-1?Q?1JnEwE7U9NIOwvBWPZuxY07qmD4jLh4GQxa//8o9AwkrxTFziHxI7wIUmT?=
 =?iso-8859-1?Q?IvpweF+Cec/A46PeYLuIY4kyvCK3WEhI5FeGnnB9UQPrClyDTKwt0vckxi?=
 =?iso-8859-1?Q?rGN9nwe0Cv10SdVjz+anNirIpaVjOi6IVdtneO6JfCqXCvtLVl+YaWxcF/?=
 =?iso-8859-1?Q?Xb0PNLegK2cdWn2o8gKARUr1lis5gEiR8vu7jNMql+wNMCdb+Qx2lha61H?=
 =?iso-8859-1?Q?Km1MlJTaKpCHU+R0XkN38OZp5xCS5Qg4uPXHKJRUkoGwZgpx6KA+xOGzuy?=
 =?iso-8859-1?Q?DRtMhqCqe5Mx6WkeFAQwkMeAz7lFyslnVYFo9aYMys/4qHka7wYmiBs0Pa?=
 =?iso-8859-1?Q?xvqAxjTZaBuC+mm2kLz/IxVj8/FEY6cja9mlwcep/AFkzZjV/fbpNDZVrS?=
 =?iso-8859-1?Q?qib7ghzcUvmM9RUCxqLwfnpLCnodHJ1FrvVwugf1R48e2hVkYmyMYD3W4L?=
 =?iso-8859-1?Q?stRyD+5iDwa6yKc9aHcEXDQQga7nBeHJ/4vZmBl3adkWtcA+kBlCDM/JN5?=
 =?iso-8859-1?Q?kAKospTI5MthUgacIMecjLYUKP36VwZUbj3Leb/OR/EYCNOZuYW3BZ62Lr?=
 =?iso-8859-1?Q?6wdhyEUxpdHammqmuFETDS3lW1/XD0GyDewGPY2aSl3W8N7HE1wg3DGBmg?=
 =?iso-8859-1?Q?C3gV3BZP7q9L4pXtaeCqOkdMwr4Y6hybxGPYf2a0u7bz+SDV5ng180Od+t?=
 =?iso-8859-1?Q?7kgnOd5QaaAcRwA3jgQYKgAb60QQ02BGQA+ph2FxOhRaJwGbI7ycKDUEl3?=
 =?iso-8859-1?Q?iYEX1hNrYyoftgUhl3A+2P/7uOko7pbPrrxxOs+hPLbvAUGcRZiPvt98rv?=
 =?iso-8859-1?Q?2vXoTu37O8+DetNoFBr/aFJ/pVrzwmLzJA2Eqok7ckFXkjybaLUe74jGgV?=
 =?iso-8859-1?Q?u5e8l0IsNyUPpJpUw8gc/BgpVNKpM524C8UYY2zTp9chKUN0S8xCUXjCld?=
 =?iso-8859-1?Q?2oa2kEP53LZygCA+mHEYrfmtz4BrzNgToV2s1zjyUGpNpHVWb3y0HxKFa2?=
 =?iso-8859-1?Q?ZSTyGt5uEW1erFI94+lEZ85MoVtmCn2VWSYxqMwzszoYoBkiuqaM6B0Gja?=
 =?iso-8859-1?Q?42XVDxgwqIbztTqiGOpv6tV9sAeXwIEQEujkG1iR73ZQcGT3YT/WxgLAk6?=
 =?iso-8859-1?Q?Tbp5IqE8hXj8yOgY4/zz5zXrmzsrVc/BKHydt+5eHTZ+TEM+PFqwxsCRcK?=
 =?iso-8859-1?Q?YIObrnwqNJJiO4Fac4NXr+VHEIQ20bc6Ih9+rAsAZEDUKVJU3rv2iSLioM?=
 =?iso-8859-1?Q?TMdYC6XTtaA2PQLspKuSYcSGDYDVyDDsF5ByHMuq5geu2nNNqZlSIKkvF8?=
 =?iso-8859-1?Q?3zfTMltrOpW1itL16dUKXn8RMp+jrYgRypIgnTTW/emAN7lu/nroO7qYPq?=
 =?iso-8859-1?Q?IGbMg4V0pcCkMz45V/x8DXLG+W8UZP+B4do12tDv0zS5gJqX5vbV?=
X-Exchange-RoutingPolicyChecked: lWEyY9vcsYoLTz6sJ0ZUeoP4DOm+P1DNrzUxbzESsTOpbk9ep7ZyXL/nVfpqM69cwveo+LfAp6B0wKJflLUWaJ2N5c/0ZKxPZDOL/V7PAl7jnd1jgjRbPagfSsSbU++624k/qaSP3geKU2cumyAClPdHjVJdExpC/HvQ5jj3UZ+//MA71LxvGoN67r/Ewt5uMlfy2KY1t4yoIdHzv5qnaJ5fewvxHD8ThxG5phUqObivi7Jw4EEo7tGCC63RUdarfTDNH0eBLBYiDJO1EZJ2fQQBGjx+eyc068njAm792XiBpEvSGA/Y3pqNiEQcEhKI2TQ+P5J9YpAGtrUJZqJ7jA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d010d0f-d7fa-44d6-1cee-08df3a257635
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 03:41:08.3576 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+GTHkgixhZNyW0U8U1PzKS7PI4KutEMYLGDLMqSq3M9FF9xxJW7GzAon2jEPOHmMiwjxgggrwhRnIUr0revMHw3OLXc9TzEy8K+UxaD7UrRG1ihf+z5m0FiZ264GpSb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6796
X-OriginatorOrg: intel.com
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Jul 10, 2026 at 07:55:57PM -0700, Matthew Brost wrote:
>From: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>
>Drivers that use the GPU SVM core to DMA-map system memory for GPU
>access may want to keep track of how many pages they have mapped, for
>example to expose statistics or to detect leaks. Doing this accounting
>in the driver around drm_gpusvm_get_pages() / drm_gpusvm_unmap_pages()
>is error prone: the number, order and kind of the dma_addr[] entries can
>change between map and unmap (migration, partial unmaps, the iova vs
>non-iova paths), which makes symmetric accounting hard to get right.
>
>Add an optional @dma_map_account callback to struct drm_gpusvm_ops and
>invoke it once per &drm_pagemap_addr entry at the exact points where the
>entry is DMA-mapped (sign == +1) in drm_gpusvm_get_pages() and unmapped
>(sign == -1) in __drm_gpusvm_unmap_pages(). Since the map error path and
>every unmap/free path funnel through __drm_gpusvm_unmap_pages() for the
>entries that were actually mapped, the accounting is symmetric by
>construction. The callback receives the full &drm_pagemap_addr so the
>driver can use the order and the proto field to distinguish system
>memory mappings from device interconnect mappings.
>
>The callback must also be usable by the core drm_gpusvm_pages-only API
>(mm == NULL), as used e.g. for userptr-style mappings. Relax
>drm_gpusvm_init() to allow such users to pass a restricted @ops that
>only implements the page-level hooks; the full-SVM hooks (@invalidate)
>and the chunk configuration must still be unset in that mode.
>
>Assisted-by: GitHub_Copilot:claude-opus-4.8
>Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

Patches 11 and 12 can be spinned out as a separate patch series
(for fast tracking).

LGTM.
Reviewed-by: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>

>---
> drivers/gpu/drm/drm_gpusvm.c | 17 +++++++++++++++--
> include/drm/drm_gpusvm.h     | 19 +++++++++++++++++++
> 2 files changed, 34 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
>index fcfe635bc195..512f52471419 100644
>--- a/drivers/gpu/drm/drm_gpusvm.c
>+++ b/drivers/gpu/drm/drm_gpusvm.c
>@@ -474,8 +474,15 @@ int drm_gpusvm_init(struct drm_gpusvm *gpusvm,
> 			return -EINVAL;
> 		mmgrab(mm);
> 	} else {
>-		/* No full SVM mode, only core drm_gpusvm_pages API. */
>-		if (ops || num_chunks || mm_range || notifier_size)
>+		/*
>+		 * No full SVM mode, only core drm_gpusvm_pages API. A
>+		 * restricted @ops that only implements the page-level hooks
>+		 * (e.g. @dma_map_account) is allowed; the full-SVM hooks must
>+		 * not be set.
>+		 */
>+		if (num_chunks || mm_range || notifier_size)
>+			return -EINVAL;
>+		if (ops && ops->invalidate)
> 			return -EINVAL;
> 	}
>
>@@ -1246,6 +1253,8 @@ static void __drm_gpusvm_unmap_pages(struct drm_gpusvm *gpusvm,
> 			else if (dpagemap && dpagemap->ops->device_unmap)
> 				dpagemap->ops->device_unmap(dpagemap,
> 							    dev, addr);
>+			if (gpusvm->ops && gpusvm->ops->dma_map_account)
>+				gpusvm->ops->dma_map_account(gpusvm, addr, -1);
> 			i += 1 << addr->order;
> 		}
>
>@@ -1654,6 +1663,10 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
> 				(addr, DRM_INTERCONNECT_SYSTEM, order,
> 				 dma_dir);
> 		}
>+		if (gpusvm->ops && gpusvm->ops->dma_map_account)
>+			gpusvm->ops->dma_map_account(gpusvm,
>+						     &svm_pages->dma_addr[j],
>+						     1);
> 		i += 1 << order;
> 		num_dma_mapped = i;
> 		flags.has_dma_mapping = true;
>diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
>index b7d987bf76aa..36f35816a569 100644
>--- a/include/drm/drm_gpusvm.h
>+++ b/include/drm/drm_gpusvm.h
>@@ -75,6 +75,25 @@ struct drm_gpusvm_ops {
> 	void (*invalidate)(struct drm_gpusvm *gpusvm,
> 			   struct drm_gpusvm_notifier *notifier,
> 			   const struct mmu_notifier_range *mmu_range);
>+
>+	/**
>+	 * @dma_map_account: Account a DMA-mapping change (optional)
>+	 * @gpusvm: Pointer to the GPU SVM
>+	 * @addr: The address descriptor of the chunk being (un)mapped
>+	 * @sign: +1 when @addr has just been DMA-mapped, -1 when it is being
>+	 *        unmapped
>+	 *
>+	 * Called once per &drm_pagemap_addr entry, when the entry is
>+	 * DMA-mapped by drm_gpusvm_get_pages() (@sign == +1) and when it is
>+	 * unmapped (@sign == -1), so the driver can keep symmetric accounting
>+	 * of the pages it has mapped for GPU access. The @addr->proto field
>+	 * can be used to distinguish system-memory mappings from device
>+	 * interconnect mappings. May be provided in both full SVM mode and the
>+	 * core drm_gpusvm_pages-only mode.
>+	 */
>+	void (*dma_map_account)(struct drm_gpusvm *gpusvm,
>+				const struct drm_pagemap_addr *addr,
>+				int sign);
> };
>
> /**
>-- 
>2.34.1
>
