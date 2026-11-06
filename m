Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC141606A329
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 02:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IQa7CsP3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D04BE112BD5;
	Fri,  6 Nov 2026 02:35:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91C15112926;
 Fri,  6 Nov 2026 02:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793932492; x=1825468492;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=jOK+cEcib63sKBDhaVVpSBecH0dpc6GNuxcV/5Blqec=;
 b=IQa7CsP3reoPR/XR6x2Br7SLaUbHuhg6DaM4DSjdNkoRGRG7E/t3MLEs
 EOenpkwNSkikpeWKXJlM2gJtwDlxHf+4I52yPzDU37J8Y+1fJZEYkGRk+
 V4CA/KxqVSX/3XG7h+4ncOA3gN/o6L7FzASVR7ChdlIBlTHFtXAE+Rre5
 uf2t7H76YMTmWBvwim1QcENVz9KdaFJmAs/DmdvSXnDAp2W/U94r6ceW4
 WhIvWV6mND6T3fzHdDE+aViMysUaQDd0LxE3Tk5phOa9RX8NLX7geHKFZ
 bjzxPUPcaosAjxFRMkZ2dI9lt1LtOKBu1Y28PplsZOGVkeOM9gcnKvGFn Q==;
X-CSE-ConnectionGUID: qW4R0I1jTXySenUV89bTuQ==
X-CSE-MsgGUID: lrC/HyLVSsOe0i2yxiSb3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2618978"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2618978"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 18:34:51 -0800
X-CSE-ConnectionGUID: cSrqSlaOSFKzjhu7M/ci6g==
X-CSE-MsgGUID: BRFqrSOgTse2gPmODv7CPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7067788"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 18:34:52 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 18:34:51 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 18:34:51 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.57) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 18:34:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dG0/K14hwV5c2S5y21VO3TjUWiVxzNlghCNMft2GyRm/MCpnXdsyY12sOddWxO0Rve+VegXnEb4+wtGivrOQ9pBHAWz/kwR8ebqKF5Mz9nrDH4TgvYRycHkpxiGUlHjC+R8OCbUXKCiXTXsefYVukjJwSrkwNiXqf23UeAmxovDwOL2xuxtRUEOJodIxRE2Y/uk6w/KKhz4G+e54O1eVa18CbfhKlRqquISo/yHN3sVbPehCK62RD9jk6l8/2XBc9HLY50gLVljdSsn/8tJ7vvey8uDA3nKTkRpSni15ppyzWOBwMUtItyJF/WDcKNyK8yp+DSaj4t6RrW0kbpGiCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uuMY761HyEgpEy5+bUtEwARvPPUKYICOeq7Db/Gnihk=;
 b=pYreI4e2t1DjFtv4udaQpVsbm/Qr+G+AVahzQRrulHocuDppskvUAC1KVynHITebzlMK+o6f7wxK78XsBc3nQdQGWZXQ5YSdLPFAJD3OyH0eHv91sSQj2JUYqyIIYHUBlWGl6oI9QWvB+ysb6X5w7C+z2RbVBHsfojxKuvbKhhZC/FtRV2n6Ej83cOEypbOKy0kN5gRpqSJpW9M3odJj2rrmiKziOI+vB5FAeEANOMkuBhr2KshfrvJAljkFjqKkl4LD6pRhOnZ03z9h+4/kkFdnHq/Fx9TaMktqKbcb8CKCAo7X1Ml7zkNUtHMk+ciIbdVhijTRDImWnI9aTyvYRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by MN2PR11MB4568.namprd11.prod.outlook.com (2603:10b6:208:266::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 02:34:43 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0569.011; Fri, 6 Nov 2026
 02:34:43 +0000
Date: Thu, 5 Nov 2026 18:34:40 -0800
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v3 03/33] drm/ttm: Record sub-optimal page order
 allocations in ttm_tt
Message-ID: <au08wNRON0_b5wuG@nvishwa1-desk>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-4-matthew.brost@intel.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260711025619.2540575-4-matthew.brost@intel.com>
X-ClientProxiedBy: SJ0PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::14) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|MN2PR11MB4568:EE_
X-MS-Office365-Filtering-Correlation-Id: f3809caa-171d-427e-2960-08df3bae83a7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|18002099003|22082099003|4143699003|261026121527099003|11063799006|56012099006|5023799004|261009223027099003|261009221727099003|261009221227099003|261009223327099003|261028144727099003|261009220027099003|261021123027099003|261102123227099003|261022105027099003|261026140227099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: xstMLZw8wbLZ/yVqVx0EM7KziGb0EU84WIFOjJqzYCt2t4rNJi3ImhaH03pY2lETVSozYCSOeTGxYGno91XYEHQN7ORYYQqsky0qeBlrEz5Z6e1nfnQzJCggFbjOCbH3FhhLAkddQP9VEUDRo4fLa9v3xzEieJ17LKT/8dT3kacwNE6Neasz2goki7W62VQnLxvr53I0m3ABsTjhaJCdVlLo4YW6L8kEMLyVz9meRtXc/kmuoc9pjt4Nm6qDzVDDsMnfU7jZyyrniS032xIbrZwjC+OxRX2dqnaqeRFDAQEZ+GBlh1d+L8ISxZKTek4SEEu9wcP5Vz4d0w92xz1tTO7eNt50gU0EMmUsKECKKgzBEHZlZHpHEJHUSt3eC5Y076FLDMBwadf2mqD6ukm/QH38l3y2R669yuRBi/1YF0GPJiYFamBN+vhwiF9ztfeSTDU4LMKgoQjcoOJ59v1/KyyJyJR5WFs8JrjzbI+IM7EU8UaU0QR/5h5HyiPoLD2DMgk+i0FU4j0/Rtj1Hu8fQ/oW60QhLMizVoz+a5r694tLDAruFpoQki7bWQ1wjJBhBood4lq5pHFdYbYhDMuqfWIZrXjV1g7TTBQxiphox0XzlaPH+OHMa5R6v0hkYvKTi5F1k562BGdJHfpdiAMhDtlvTVCl9WbqGj+/f1OtoOM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(261026121527099003)(11063799006)(56012099006)(5023799004)(261009223027099003)(261009221727099003)(261009221227099003)(261009223327099003)(261028144727099003)(261009220027099003)(261021123027099003)(261102123227099003)(261022105027099003)(261026140227099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?+ZoogYbviOQ8vDyL87IX9hV7PgLpulPG1iPOAcANdBLlmqluK9nK7Hpq+x?=
 =?iso-8859-1?Q?0y6/iHNRfIFJDJJC6b4c3V+y68QFZ/cj39g/i427v18xc1p+kV7UI8QscG?=
 =?iso-8859-1?Q?VjtccUCJuC/jpnf4xXW7/L24lxqag6KuengHlFPW/7jN7yB8v9RRe228YT?=
 =?iso-8859-1?Q?0pLWHd3sF6pU5N33xOpIsoYQpzU9FstLLpUCEo6qMe8qY2wYF4HmmSkRmK?=
 =?iso-8859-1?Q?CK07BmaXYyQbz61JeV3fcvlLMCSgpvmqRoKL3xBFh5hGcMh+6sCq0Lr16g?=
 =?iso-8859-1?Q?zEwsBbxnBOwbo4CnyhX82b0bSXlFPcj7UOaN1gZUopkVRAezAxfDCAh/Ys?=
 =?iso-8859-1?Q?8xGXE2NuGEKuPpAytI/xEUzE7AntT5ki8CvJ54y9D23p7QICBSE8B25cwp?=
 =?iso-8859-1?Q?dUDZQjCY2QAy89CxMHlI5UA27ULBdl6vKvJHiMuivU2Aji7STrsCFskvQM?=
 =?iso-8859-1?Q?3p3jQijZgfR7A6zEMEgLchulQ9JGwrjPR1yrqoQo9qXrBuDcVrputJveSF?=
 =?iso-8859-1?Q?5gOzqRh933+cpN1q6Mv80dtAoGGP9lWemBJ9a1H8tcsYGcQe7WoZkNAfaB?=
 =?iso-8859-1?Q?ONBiFkM5XaRGiGalR8Lg1K0LwYD+1c1C7G9WU8RfUtVn2YUpWhEdXOcAmv?=
 =?iso-8859-1?Q?uJSLVW+up35Ump4rbfV8LE0DZG+QHK4lZN9ptm/H+ChzH36asm0J6OB01q?=
 =?iso-8859-1?Q?1HL+yTrAMzHQfHuMA75RBj/RZNb57sG1EiUo4fDx3y5MSgWw1F1tnf8xal?=
 =?iso-8859-1?Q?vaS0awoZYPV8nN4+2NwvqrYIq2WPeu5K4WyK4ZJu1biLwjY+DvYkVJFxMd?=
 =?iso-8859-1?Q?+6rrTRRP2v0NvaXMgFi1fqzmMW7hyPHNmidYA8etbvnJ47qjql505ojDQQ?=
 =?iso-8859-1?Q?a6GJz4v0cog5O/k4Cw66Fh0XJYZWi06qV6JOEuI71MyrLyXlPfLYbnCz+n?=
 =?iso-8859-1?Q?Tb5sizORW26dJvZNj6+eC1Xs+LYtMtyOLb+iIrNy3X89fS+su8gIyvWyHQ?=
 =?iso-8859-1?Q?HZi5HhpDPhAaTlbZieour9AC008VxPhQsYoAUhoZ6ZL3Mc5fJuYEbbmiJa?=
 =?iso-8859-1?Q?cK3yJFd8nvYbdiKGjE8bzw6l540G0KOYzdi3KseSex31T8JpZNxY9VJNUv?=
 =?iso-8859-1?Q?2RvKRnYOtxChhOU7r5OnVaKPQoHuAfMlOxr9NhcQ05GPYDn7o3+Mwsquir?=
 =?iso-8859-1?Q?p8fx4JE0gpvR7c8u7Ab1bouOXrMPyFYVuRazeQl1GhKoK6lhq4WcpWXYPi?=
 =?iso-8859-1?Q?UZMLXsb+2ANfWx9sYT7DaXyHOTJM58CuuqCYYWF6BJiOazG707wZyLllL9?=
 =?iso-8859-1?Q?3zh6ei/hpAyEVvQTJUngIZIGVRf2CoZ2EV0YhjMMzggVnYqNQ/baFTi4yc?=
 =?iso-8859-1?Q?OGXVcXPPuRVpSnjUoyRhrqErwUmwUMrlqARKnvalNneqpUskwuJFTKs6zZ?=
 =?iso-8859-1?Q?8Et7KvV1nrFhjT01y5QZa749qRnW9Be4lYIFaFWBcp/zYfK7p4jXQJFY1C?=
 =?iso-8859-1?Q?acLmZvPR3TPGQeDLlblTMH2rlnU5rCLFYqysj/GsWWk7xKdRzCiNO9Mfx0?=
 =?iso-8859-1?Q?Us9TRW46GvQDE2/I2UAh4L/yLMBknukHZpmpz2OA7muwHWrPfaHa9W0vOy?=
 =?iso-8859-1?Q?ZiWXIVS5WeDhm3Q38scsN3YvvZZOvActGyu7NkJAb6f1wgWxjPoPnPhic5?=
 =?iso-8859-1?Q?QfjyJo7oOqrsO/RAGygwWN6T6upjjURU4VAPNKtattSMFSeMENuP2LbIeZ?=
 =?iso-8859-1?Q?JDghbsKJoJjOeykll5citilTzKnXHicaTyZZ/8lmoVccOx1yxxcaOAy/J6?=
 =?iso-8859-1?Q?AZQUrLd0Qrnbww1/CY4bf/ruCZOZXUxwdzzIOd5YTQTQjI7TAOEw?=
X-Exchange-RoutingPolicyChecked: jBzRSAmxOz2wKZUyVI4raGQI0A8mz+aZmztb8wRr6mtR1MPMvvF4yKcfzvRl8NGDFtbdaGaICSUKKgCKlyz7xx9fNJ90DVFMe2UmJ5cX1D0MVBg2K1nXDnLv5zMzh0IOUx/+IXGYqJTyM261a9qwm5l5NtEz0PtzP6yjo8Hs8XbPaZoTX5zmbF9nmDhTyJorWnW3UtB0wdAayqEedvy6MiixN1aNq5M657u7gFVJLthQO+24OuUGcmsUQ2ZxpZuXOsJY54kbN+Loe9an2LfpH3t0vg0tBmgi7mnfN82foDqlHvz/L8jMOstZwovP4qt/wyYeOo+nYycka6F3zfSVYQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: f3809caa-171d-427e-2960-08df3bae83a7
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 02:34:43.2857 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3hPn7ghXOl4lHR15AZTTvE/9ipm1z4j3hTOFdZGv9jK8m9GV9vXWbk98XKnoyF0JcV5hTlh60nv7iW7nEfymjrVtp+bjwCX6jRkaB+JIkY/DfhiGIp3QD/IZTivyCXOi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4568
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

On Fri, Jul 10, 2026 at 07:55:49PM -0700, Matthew Brost wrote:
>When __ttm_pool_alloc() fails to allocate a chunk at the device's
>beneficial order and falls back to a smaller order, the object ends up
>backed by a sub-optimal set of pages. Nothing currently records this, so
>a driver has no way to know an object would benefit from being re-backed
>with beneficial-order pages later.
>
>Add TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED to struct ttm_tt page_flags,
>cleared at the start of every fresh allocation (in both ttm_pool_alloc()
>and ttm_pool_restore_and_alloc()). Set it in __ttm_pool_alloc() when an
>allocation at exactly the beneficial order fails before dropping to a
>lower order.
>
>Drivers can use this hint to queue the buffer object for later
>defragmentation.
>
>Cc: Carlos Santa <carlos.santa@intel.com>
>Cc: Ryan Neph <ryanneph@google.com>
>Cc: Christian Koenig <christian.koenig@amd.com>
>Cc: Huang Rui <ray.huang@amd.com>
>Cc: Matthew Auld <matthew.auld@intel.com>
>Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>Cc: Maxime Ripard <mripard@kernel.org>
>Cc: Thomas Zimmermann <tzimmermann@suse.de>
>Cc: David Airlie <airlied@gmail.com>
>Cc: Simona Vetter <simona@ffwll.ch>
>Cc: dri-devel@lists.freedesktop.org
>Cc: linux-kernel@vger.kernel.org
>Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>Assisted-by: GitHub_Copilot:claude-opus-4.8
>Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>---
> drivers/gpu/drm/ttm/ttm_pool.c | 13 +++++++++++++
> include/drm/ttm/ttm_tt.h       | 24 +++++++++++++++++++++++-
> 2 files changed, 36 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
>index 5b7d7f5ae53d..e9175c0290d7 100644
>--- a/drivers/gpu/drm/ttm/ttm_pool.c
>+++ b/drivers/gpu/drm/ttm/ttm_pool.c
>@@ -796,6 +796,7 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> 			    struct ttm_pool_alloc_state *alloc,
> 			    struct ttm_pool_tt_restore *restore)
> {
>+	const unsigned int beneficial_order = ttm_pool_beneficial_order(pool);
> 	enum ttm_caching page_caching;
> 	gfp_t gfp_flags = GFP_USER;
> 	pgoff_t caching_divide;
>@@ -846,6 +847,16 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> 		/* If that fails, lower the order if possible and retry. */
> 		if (!p) {
> 			if (order) {
>+				/*
>+				 * Failing to allocate at the device's beneficial
>+				 * order means we are about to back this object
>+				 * with a sub-optimal (smaller order) set of
>+				 * pages. Record it so the driver can later try to
>+				 * defragment the object back to beneficial order.
>+				 */
>+				if (beneficial_order && order == beneficial_order)
>+					tt->page_flags |=
>+						TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;

I haven't looked at beneficial_reclaim_backoff usecase yet, but this flag
gets set irrespective of whether the allocation failure resulted with/without
the beneficial_reclaim_backoff request from the driver. Is that intended?

Other than that, the change here LGTM, though I still need to look at how driver uses
this flag in more detail.

Niranjana

> 				--order;
> 				page_caching = tt->caching;
> 				allow_pools = true;
>@@ -910,6 +921,7 @@ int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> 	if (WARN_ON(ttm_tt_is_backed_up(tt)))
> 		return -EINVAL;
>
>+	tt->page_flags &= ~TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
> 	ttm_pool_alloc_state_init(tt, &alloc);
>
> 	return __ttm_pool_alloc(pool, tt, ctx, &alloc, NULL);
>@@ -942,6 +954,7 @@ int ttm_pool_restore_and_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> 	if (!restore) {
> 		gfp_t gfp = GFP_KERNEL | __GFP_NOWARN;
>
>+		tt->page_flags &= ~TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
> 		ttm_pool_alloc_state_init(tt, &alloc);
> 		if (ctx->gfp_retry_mayfail)
> 			gfp |= __GFP_RETRY_MAYFAIL;
>diff --git a/include/drm/ttm/ttm_tt.h b/include/drm/ttm/ttm_tt.h
>index 406437ad674b..ce7533677d77 100644
>--- a/include/drm/ttm/ttm_tt.h
>+++ b/include/drm/ttm/ttm_tt.h
>@@ -90,6 +90,14 @@ struct ttm_tt {
> 	 * TTM_TT_FLAG_BACKED_UP: TTM internal only. This is set if the
> 	 * struct ttm_tt has been (possibly partially) backed up.
> 	 *
>+	 * TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED: Set by the TTM pool allocator
>+	 * when at least one chunk that could have been allocated at the pool's
>+	 * beneficial order had to fall back to a smaller order. This indicates
>+	 * that a sub-optimal set of pages was chosen for this object, and can
>+	 * be used by drivers to queue the buffer object for later
>+	 * defragmentation. Drivers should access this via the
>+	 * ttm_tt_is_beneficial_order_failed() helper.
>+	 *
> 	 * TTM_TT_FLAG_PRIV_POPULATED: TTM internal only. DO NOT USE. This is
> 	 * set by TTM after ttm_tt_populate() has successfully returned, and is
> 	 * then unset when TTM calls ttm_tt_unpopulate().
>@@ -101,8 +109,9 @@ struct ttm_tt {
> #define TTM_TT_FLAG_EXTERNAL_MAPPABLE	BIT(3)
> #define TTM_TT_FLAG_DECRYPTED		BIT(4)
> #define TTM_TT_FLAG_BACKED_UP	        BIT(5)
>+#define TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED	BIT(6)
>
>-#define TTM_TT_FLAG_PRIV_POPULATED	BIT(6)
>+#define TTM_TT_FLAG_PRIV_POPULATED	BIT(7)
> 	uint32_t page_flags;
> 	/** @num_pages: Number of pages in the page array. */
> 	uint32_t num_pages;
>@@ -179,6 +188,19 @@ static inline void ttm_tt_clear_backed_up(struct ttm_tt *tt)
> 	tt->page_flags &= ~TTM_TT_FLAG_BACKED_UP;
> }
>
>+/**
>+ * ttm_tt_is_beneficial_order_failed() - Whether the tt is backed at a
>+ * sub-optimal page order
>+ * @tt: The struct ttm_tt.
>+ *
>+ * Return: true if the pool allocator had to fall back below the pool's
>+ * beneficial order when backing this tt, false otherwise.
>+ */
>+static inline bool ttm_tt_is_beneficial_order_failed(const struct ttm_tt *tt)
>+{
>+	return tt->page_flags & TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
>+}
>+
> /**
>  * ttm_tt_create
>  *
>-- 
>2.34.1
>
