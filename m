Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07925606A333
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 02:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=d+VX9B+U;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=fTB46yjU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4503810ECFE;
	Sat, 14 Nov 2026 02:03:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C511910ED0B;
 Sat, 14 Nov 2026 02:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794621769; x=1826157769;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=+lKy5bZUsPZyu7K4YsLLgrV7/ag6SrIgFJmu3aL9z+4=;
 b=d+VX9B+UPU10jl//ZmTVPcyNK/R/DIo1Aqu5g+7sjyDKt877MDUM8Kbz
 WOHhwuctDLMsydF/eddYlMT46nyasOtUkDW8vg0D1+qnSpa+hmwof0E27
 SKIgm4VuYI9K/t5iJ+YCZt1TTbhIbOarPmyQ8nudI+c65WiJMMd7On5au
 +unMAAjjowcpxGvg+ugV5WfYlBumqLOmI8R3p6GCOGwXZ92gasvdh5CxN
 Bouw1wSckmlJvdUN8+z5YbHaqZcrWiX2/DLm6tT+A0mL31cKKg1SEovOs
 7DH3ZXVYzErRYoSu21Krz5Lp28jVGB0x9deiZboLyOArRFbHYgWuw53gs A==;
X-CSE-ConnectionGUID: JQ0KztK6RUOcpRCn8gRuzg==
X-CSE-MsgGUID: 0bs4wTZ1ScS52TFl6kqscQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3473347"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3473347"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 18:02:48 -0800
X-CSE-ConnectionGUID: 3xuwcQt1RyKgLKaHTsc94A==
X-CSE-MsgGUID: b58wlapBTDWTWUN5Tq03Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="9390796"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 18:02:47 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 18:02:47 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 13 Nov 2026 18:02:47 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.30) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 18:02:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYz55MQnD205+iDqh0UFkKdorCoPTsK3xxYEv3geoHzoBuqExSm2zTGaU1y0XtSf+GZFHRBf8HakuSNYLOF+sQe6Hhmhor/LBpvXRHp2w8pEQ84FYr/4BjXHymJGQA5i/IDkTnB4+tXgqV/FjVcAsV05AEkfxFwhKmlEiveD89W+tzPIyOrpUTXTiXNMcjkZepQgYjW+yDFph/A5ZGQTQ4R05t3XCZ3QqkY97w0NAssz+8LroI6YkAVY86ZsXP7bG89mexDtqj2H+81vUydTUgpIcGyU8SxwIqG+evGOeeE+DeF22ss1DCgM9WlMAn3joEaUp3ZmMcj3f9YycwJ7NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JH9d1k0AeRxkrXlyErVQldqVKA80cY0Xw2XjXKhg9t0=;
 b=V3lMDdsinYyuywFbVlVzxQFjXdTgmeETcPk6NrftizuTwwmy5f/2iAhQ05mfaAsvLZFf1yI9V4NfBvh4xrtklj4NtkgeFtkjAjWFVBD1vv/Cq00t8u1WW+pEuM9MkfXDE7zHkAqAASTY4bMgKG5Q3buAfI2wkGkTysNuW9gSXVneo5QtyhEgdxfYJAhuadNaTDjjkQeB8nKqgauLr0qUvrkWREVsX3HpI1y40lwJ5XHlV2UqKyaGgz46tqZTWblgDrn45v23kPNrfhE/31Qa9T2kuV/v2fZFxMwy9KN9KqAJJi2jHDbO035hnjEZCRaD4GYMG91tzLaTyUHU3xhrSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JH9d1k0AeRxkrXlyErVQldqVKA80cY0Xw2XjXKhg9t0=;
 b=fTB46yjUKzvgiQ2L9CE0i4Hq/5BV14/e+p19YcvhhEhvbveJLd8MYPiRewMZPdaVnWEB5SJsx2yHkqEP/xfC34yk8RjQ/E9Mj6aPrMJE2D/G6Zvn2nFp1CCxyddZzYzmo0l+T6ea79g0HfVInZfXtQpwMGrDaQOmi9oI+WaSoNA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by DSM1PF99912F31C.namprd11.prod.outlook.com (2603:10b6:f:fc02::14b)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 14 Nov
 2026 02:02:30 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0615.009; Sat, 14 Nov 2026
 02:02:30 +0000
Date: Fri, 13 Nov 2026 18:02:28 -0800
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
Subject: Re: [PATCH v3 32/33] drm/xe: Finalize defrag-IOVA moves with
 post-copy job
Message-ID: <avfBNLDPLhl8_mkb@nvishwa1-desk>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-33-matthew.brost@intel.com>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260711025619.2540575-33-matthew.brost@intel.com>
X-ClientProxiedBy: SJ0PR13CA0084.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::29) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|DSM1PF99912F31C:EE_
X-MS-Office365-Filtering-Correlation-Id: 7db7afdd-b1db-4838-bdfe-08df41f3573c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|1800799024|23010399003|261009223027099003|261026121527099003|261028144727099003|261022075727099003|261021121427099003|261021123027099003|261102123227099003|56012099006|4143699003|5023799004|261022105027099003|261026140227099003|6133799003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2QSi9Wfvw5mQSfF5xY8Sk6+eCopZrRJG2/qSkEeGaxJQGpSRaxaza2hYB4Ddta5wFmwVbNijRN9xK7FlkreuFqrT3wAfo3R1mxGBQ3AKV5Hq8rFXTVfopg/zRSrqo8y/ZcKXEs52zLKo5r+z8ARd53+HR6xmUdPgb5SsMgQ+p2OUuZuBcZtt/SjZ1Af/HQtJTeOmm3ojNy/j4KtZ3T/BsH7cqHng1Z9FzI1ZnlEp0NvGlwvdMI74YgLj4yRHlCLcDXJnA4ARTxBLyq26UEXlFEqxooNy22vhFBVixuV5JllIBRusH44fMLTnJneYYsXBHkd/JAGWU1RxtT3KmAaLoT4BDoPughjTvPFTgcwojXJfF/hr5+QgKIFxFRurlryl/GU2t30p9S9CQVW5C5JsqqvmvLGstJKmz43fdOIFTZtwDq9TqhpD5vkbdpQmTuqSZQs4+XoGX55usZu4B0G7eQ+z84jWfsa8zzBKhQvnuQDCi+pa/PoYkCFBbj+VQZYvVnogYRqFQlQjzG6ztNYfaSVAxXlmTbOWtmrxkU/H7NYe/zBziijbbh2mpvRXvUXA9Hxb+xnJhAygIysX00f1SshfVH95Hy6lxfvGpcG4wGvlCyUr2uk0kIKILK3AfPWT7pUCQ++3nmbe4RcAxdvhDs213r4irsIt3imoCuQ+ZOY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(261009223027099003)(261026121527099003)(261028144727099003)(261022075727099003)(261021121427099003)(261021123027099003)(261102123227099003)(56012099006)(4143699003)(5023799004)(261022105027099003)(261026140227099003)(6133799003)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?H+sztovi0RAaZJcJHWP2EbJ24Cyfy4JmtMaKRoxyLmFFNzp3uHsIfEGUWa?=
 =?iso-8859-1?Q?Q7+1K9z4HNK7KKNFl4ClsInwbdY1DAqgiX7vcZptAlVPzdqKO+PgNXU+wV?=
 =?iso-8859-1?Q?4KejGigkWrSBg650WZ9a2TgMgrEVkMuu+BN+SjVgLBlAL84bN8nz/xs8+O?=
 =?iso-8859-1?Q?hlz3FoY/Tm5xNm5UbmHTPl5/R7DbZ9jhFmnCi2B1OkPQ/I5DAtfnViYcZB?=
 =?iso-8859-1?Q?/J2Gs6gOeOb891WrDZLHQGULw2lKeyIKetVDVf6/ryN0hZOoR4PAKKYI++?=
 =?iso-8859-1?Q?f+kukTfgDbr8YXTLcvlpZjO7TmVnIifvcroQBpn8UKsFQjRF2KF8llf4zw?=
 =?iso-8859-1?Q?d4xhzsKGUqmP+9LMUZcHY3Q833S+zIw58YGWniHEAUztf1nfWBs3tB3NbW?=
 =?iso-8859-1?Q?23rRHw/xIfTazHbyE7DD0JnW4ImBjrfK+RGBRuZF5J1LLgtpPp2TfIxPcG?=
 =?iso-8859-1?Q?+NYs3h2IDOJcwWmUmKEVmUtmi42YP4Udyf4IxK5+xsWF9/wq129g1dBvMp?=
 =?iso-8859-1?Q?0SoFHFCQv9tK44F+cWi0jw4TgYY8MCsnyvbVepL6MBXXsHdQF31h4mqKtO?=
 =?iso-8859-1?Q?kVAGKddCewHoaA/laZkifjHspGWZ0a45G8+hx5TJGflfqZ3v0sUOjpNfHu?=
 =?iso-8859-1?Q?vknXnve3vpVWEojGgzgvKJP288+hwKV/2TVA+DUgJ8bltAN8c0djEsfysT?=
 =?iso-8859-1?Q?shr/Oy8po0gZayH2tEOS21hYRwmal+w1xjkUh36hK8UeYqMsZBrBOqAbLr?=
 =?iso-8859-1?Q?+uycybaUrnXj/8y1i6L14jNBCUrVNKZXTnYAi/S0pjl6Z2hWAO9eS9svAV?=
 =?iso-8859-1?Q?JK+Wo63BpOD/ulEPkWWeBM7u7Y4I8nNkT687VsSk8y1DljMfoKZUHccv6R?=
 =?iso-8859-1?Q?8++SGDEzFY7fbl4ljG5o/HLI9IqLrmfNI5GlmBbF2/jeTGiXz1o3IjvIhU?=
 =?iso-8859-1?Q?0dQtZ74lyozqMKleP4ObD2J1FrVtA2sUmwNljZ1zfDQxQRGd8OP7sZd/DL?=
 =?iso-8859-1?Q?I3DTASIbPyMRdXyzSkO2njp0SpR502CORUAVu9Z0I/7OsJdPhwhPYkwwPw?=
 =?iso-8859-1?Q?uwB15ta/5+JUFYw864dW7y3EwpD2b2UY6StigiMIL2qvg6gbstn6iwLmhY?=
 =?iso-8859-1?Q?quCiruKvPiACHQ+084dDCoxEI4ds61iicPXcHF99WQLvtV/ClJaNrBnGTE?=
 =?iso-8859-1?Q?BZB0oS7N7IGHORpZq2Mmtv4pSQc8+LI6fshK41BbjUHeO3DQQLvWEpRWdH?=
 =?iso-8859-1?Q?NxY2HSA7Ijng8i2veRXACpkPXi8/6Yac4l8QfRW2xZP6z4RGsKXqTbB8dO?=
 =?iso-8859-1?Q?tvtEvBiykXlJ+yTqA5e45b80yVPe2a+NNUr2KDv3NTdZqd5jeppoanWkDW?=
 =?iso-8859-1?Q?7Q/IkUkUz7akRoUBCCDFI6Pof+KJ1U27DUHZduYtYrG7d4l7dckKcPo3DW?=
 =?iso-8859-1?Q?UxFfGBEnuFEQXLR+xuRQd2pC+0KL+H9jGS1/tb+WI32sJOrHunlTMsNg76?=
 =?iso-8859-1?Q?3D6mkzquXN6YjbrxSkuC9MJBEF7Fi7NlU9AnThkgx04mKVDe9++pGxIVJS?=
 =?iso-8859-1?Q?vF4pOdCNtZ+8tmS63RwQmW4vRy3ywKhd13T3ZLGM9QFwCmol67EpDUYvic?=
 =?iso-8859-1?Q?b4+r/nQcS1m8znFnPG5kptnCS51DplLg3ES4PO1Xc4ft/izL7Oz7lynxbf?=
 =?iso-8859-1?Q?dW+0aRIL8YHGENV2qKxz7ETweK7oLikw61iHy9zP1PMya2N8ZszuSCx6bz?=
 =?iso-8859-1?Q?cWu//KTPOnzHd4/VuLKjsAZS0tHLbQx48OxL4KV4No+KiXjJeGFMOSXJ20?=
 =?iso-8859-1?Q?seREsDmrqTYKif/QJG+kPRFCHdOvYypOgl8kpZoxvP4usKyc7H+7?=
X-Exchange-RoutingPolicyChecked: 4zD8BBKsZa61O3tpVIT6cBN67JeW0k5md0mqOIgoC5MmgOkpDlkpG6oNemlDuI4QhEHOICvP2HeafLs65k3wi32SWfQUhH863SzUr1YnopYsE7yI1yyRd3QhVnCNIcP8KMdCOmbQUxQCjXImNpYe4LIanq3p2BzOshwdigHm56A16KTdnPNjaABhsEGfP00mXPS+UyXb5VNNFGUiiiI1me9FeWtsjjnCtsnRu7f48NB2c4kku+Sn/U5tOS86hum1witcufucMsi4elyp2CIAUrhM7MgMbdHp6GvDQqp/oM7J+DqORn7jvz+BfdkMgIF18AQ9nscX/zlPf4i+dayvDQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db7afdd-b1db-4838-bdfe-08df41f3573c
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2026 02:02:30.7807 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dm658HUTKnMvX5JyG7LE40Q/xwsxqNEYjBQ6LETjab4hVTgdZjWzkiUNG9GZmtjJ8DY/6LzVI91JRcLJV8n/fbwHL8YCDZbJ3r0088+B9+STlIygQc6seOofL+nmA7sH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSM1PF99912F31C
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

On Fri, Jul 10, 2026 at 07:56:18PM -0700, Matthew Brost wrote:
>Wire up end-to-end defrag for IOVA-mapped BOs. A defrag move
>is eligible whenever the destination TT is IOVA mapped. The
>packed-copy step moves only changed pages; the IOVA reservation
>is transferred to the new backing so device-visible addresses
>are preserved, avoiding GPU rebind overhead.
>
>Add xe_bo_defrag_use_iova() to select the IOVA defrag path.
>Add xe_bo_defrag_iova_copy() to drive the move: diff new vs
>stashed old TT, link changed pages packed, blit them, then
>queue a post-copy finalize job.
>
>The finalize job tears down the temporary packed mapping,
>transfers the full old TT reservation to the new one, and
>relinks the copied pages at natural offsets.
>
>Borrowed pages skip the copy and simply adopt the old
>reservation.
>
>Since reservation transfer preserves device-visible addresses,
>xe_bo_trigger_rebind() skips drm_gpuvm_bo_evict() marking;
>GPU PTEs stay valid.
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
>
>---
>
>v3:
> - Check dma_iova_sync(), wait the copy fence before unlink on error,
>   and gate the fast path on old_tt->use_iova (Sashiko)
>---
> drivers/gpu/drm/xe/xe_bo.c | 325 +++++++++++++++++++++++++++++++++++--
> 1 file changed, 311 insertions(+), 14 deletions(-)
>
>diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
>index c087f17ad6db..36290f58ccc1 100644
>--- a/drivers/gpu/drm/xe/xe_bo.c
>+++ b/drivers/gpu/drm/xe/xe_bo.c
>@@ -13,6 +13,7 @@
> #include <drm/drm_dumb_buffers.h>
> #include <drm/drm_gem_ttm_helper.h>
> #include <drm/drm_managed.h>
>+#include <drm/gpu_scheduler.h>
> #include <drm/ttm/ttm_backup.h>
> #include <drm/ttm/ttm_device.h>
> #include <drm/ttm/ttm_placement.h>
>@@ -25,6 +26,7 @@
> #include <trace/events/gpu_mem.h>
>
> #include "xe_device.h"
>+#include "xe_dep_job_types.h"
> #include "xe_dep_scheduler.h"
> #include "xe_dma_buf.h"
> #include "xe_drm_client.h"
>@@ -542,7 +544,6 @@ static void xe_tt_unaccount_iova(struct xe_device *xe,
>  * @xe_tt->iova_dma_pages[]. Used to (re)derive accounting that exactly matches
>  * the pages a tt is actually mapped with.
>  */
>-__maybe_unused
> static void xe_tt_account_iova_pages(struct xe_device *xe,
> 				     struct xe_ttm_tt *xe_tt)
> {
>@@ -567,7 +568,6 @@ static void xe_tt_unaccount_iova(struct xe_device *xe,
> {
> }
>
>-__maybe_unused
> static void xe_tt_account_iova_pages(struct xe_device *xe,
> 				     struct xe_ttm_tt *xe_tt)
> {
>@@ -806,7 +806,6 @@ struct xe_tt_iova_copy {
>  * differ. Coalesce contiguous changed folios into runs and, for each run,
>  * invoke @fn. Returns the total number of changed pages.
>  */
>-__maybe_unused
> static pgoff_t xe_tt_iova_walk_changed(struct ttm_tt *new_tt,
> 				       struct ttm_tt *old_tt,
> 				       void (*fn)(pgoff_t start, pgoff_t count,
>@@ -855,7 +854,6 @@ struct xe_tt_iova_run_collect {
> };
>
> /* Geometrically grow @arr (element size @elem) to hold at least @need slots. */
>-__maybe_unused
> static int xe_tt_iova_grow(void **arr, unsigned int *cap, unsigned int need,
> 			   size_t elem)
> {
>@@ -878,7 +876,6 @@ static int xe_tt_iova_grow(void **arr, unsigned int *cap, unsigned int need,
> 	return 0;
> }
>
>-__maybe_unused
> static void xe_tt_iova_store_run(pgoff_t start, pgoff_t count, void *arg)
> {
> 	struct xe_tt_iova_run_collect *c = arg;
>@@ -933,7 +930,6 @@ static void xe_tt_iova_store_run(pgoff_t start, pgoff_t count, void *arg)
>  *
>  * Return: 0 on success, -ENOMEM on allocation failure.
>  */
>-__maybe_unused
> static int xe_tt_iova_copy_init(struct ttm_tt *new_tt, struct ttm_tt *old_tt,
> 				struct xe_tt_iova_copy *copy)
> {
>@@ -969,7 +965,6 @@ static int xe_tt_iova_copy_init(struct ttm_tt *new_tt, struct ttm_tt *old_tt,
>  * xe_tt_iova_copy_fini() - Release a struct xe_tt_iova_copy
>  * @copy: The copy description to release.
>  */
>-__maybe_unused
> static void xe_tt_iova_copy_fini(struct xe_tt_iova_copy *copy)
> {
> 	kfree(copy->runs);
>@@ -1000,7 +995,6 @@ static void xe_tt_iova_copy_fini(struct xe_tt_iova_copy *copy)
>  * Return: 0 on success, negative error code on failure (any partial linkage is
>  * unwound).
>  */
>-__maybe_unused
> static int xe_tt_map_iova_copy(struct xe_device *xe, struct ttm_tt *new_tt,
> 			       const struct xe_tt_iova_copy *copy)
> {
>@@ -1047,6 +1041,133 @@ static int xe_tt_map_iova_copy(struct xe_device *xe, struct ttm_tt *new_tt,
> 	return ret;
> }
>
>+/**
>+ * struct xe_iova_defrag_job - Post-copy finalize job for an IOVA defrag move.
>+ *
>+ * After the GPU defrag copy into the packed copy-step mapping completes, this
>+ * dependency job runs the CPU-side IOMMU fixups at the point of no failure:
>+ * tear down the temporary packed mapping, then per changed run unlink the old
>+ * pages and link the new pages into the (transferred) reservation at their
>+ * natural offset.
>+ */
>+struct xe_iova_defrag_job {
>+	/** @dep: base generic dependency Xe job. */
>+	struct xe_dep_job dep;
>+	/** @xe: The xe device. */
>+	struct xe_device *xe;
>+	/** @new_tt: The destination tt being finalized (owns the reservation). */
>+	struct ttm_tt *new_tt;
>+	/**
>+	 * @copy_iova: Snapshot of the new tt's original IOVA reservation that
>+	 * held the temporary packed copy-step mapping. Destroyed by the job
>+	 * (the new tt itself adopts the old tt's reservation at job creation).
>+	 */
>+	struct dma_iova_state copy_iova;
>+	/** @copy_bytes: Byte length of the packed copy-step mapping. */
>+	size_t copy_bytes;
>+	/** @copy: Changed-page description; the job owns and frees @copy.runs. */
>+	struct xe_tt_iova_copy copy;
>+};
>+
>+static struct dma_fence *xe_iova_defrag_job_run(struct xe_dep_job *dep_job)
>+{
>+	struct xe_iova_defrag_job *job =
>+		container_of(dep_job, typeof(*job), dep);
>+	struct xe_device *xe = job->xe;
>+	struct device *dev = xe->drm.dev;
>+	struct xe_ttm_tt *xe_tt =
>+		container_of(job->new_tt, struct xe_ttm_tt, ttm);
>+	unsigned int r, l;
>+
>+	/*
>+	 * Tear down the temporary packed copy-step mapping and free its
>+	 * reservation. The new tt has already adopted the old tt's full
>+	 * reservation (transferred at job creation), so this only touches the
>+	 * snapshot taken before the transfer.
>+	 *
>+	 * This mapping was the GPU blit's write destination, so tear it down
>+	 * with attrs 0 (not DMA_ATTR_SKIP_CPU_SYNC): for non-coherent or
>+	 * bounced (SWIOTLB) mappings the device->CPU copy-back / cache sync of
>+	 * the freshly copied data happens during unlink, exactly as
>+	 * xe_tt_unmap_iova() does. Skipping it would silently drop the
>+	 * defragmented data on those configs.
>+	 */
>+	if (job->copy_bytes)
>+		dma_iova_destroy(dev, &job->copy_iova, job->copy_bytes,
>+				 DMA_BIDIRECTIONAL, 0);
>+	else
>+		dma_iova_free(dev, &job->copy_iova);
>+
>+	/*
>+	 * For each changed run, unlink the old pages (still linked from the
>+	 * adopted reservation).
>+	 */
>+	for (r = 0; r < job->copy.nr_runs; r++) {
>+		size_t off = (size_t)job->copy.runs[r].start << PAGE_SHIFT;
>+		size_t len = (size_t)job->copy.runs[r].count << PAGE_SHIFT;
>+
>+		dma_iova_unlink(dev, &xe_tt->iova, off, len,
>+				DMA_BIDIRECTIONAL, DMA_ATTR_SKIP_CPU_SYNC);
>+	}
>+
>+	/*
>+	 * Relink the freshly copied new pages from the snapshot captured at job
>+	 * creation. The destination tt's page array may have been mutated (or
>+	 * torn down) by TTM since then, so it is never dereferenced here.
>+	 * Borrowed pages are shared with the old tt and stay correctly linked
>+	 * for free, so the snapshot only covers the changed runs.
>+	 */
>+	for (l = 0; l < job->copy.nr_links; l++) {
>+		int ret = dma_iova_link(dev, &xe_tt->iova,
>+					job->copy.links[l].phys,
>+					job->copy.links[l].offset,
>+					job->copy.links[l].len,
>+					DMA_BIDIRECTIONAL,
>+					DMA_ATTR_SKIP_CPU_SYNC);
>+		/*
>+		 * Point of no failure: the data is already copied and the
>+		 * reservation ownership has been transferred. A relink failure
>+		 * leaves a hole in the mapping; there is no safe recovery, so
>+		 * just warn.
>+		 */
>+		drm_WARN_ON(&xe->drm, ret);
>+	}
>+
>+	/* Sync the relinked changed runs into the device's view. */
>+	for (r = 0; r < job->copy.nr_runs; r++) {
>+		size_t off = (size_t)job->copy.runs[r].start << PAGE_SHIFT;
>+		size_t len = (size_t)job->copy.runs[r].count << PAGE_SHIFT;
>+
>+		/*
>+		 * Point of no failure (as with the relink above): warn on a
>+		 * sync error so a stale IOMMU cache does not fail silently.
>+		 */
>+		drm_WARN_ON(&xe->drm, dma_iova_sync(dev, &xe_tt->iova, off, len));
>+	}
>+
>+	/*
>+	 * All work is synchronous CPU-side IOMMU fixup, so there is no hardware
>+	 * fence to wait on; returning NULL makes the scheduler signal the job's
>+	 * finished fence immediately.
>+	 */
>+	return NULL;
>+}
>+
>+static void xe_iova_defrag_job_free(struct xe_dep_job *dep_job)
>+{
>+	struct xe_iova_defrag_job *job =
>+		container_of(dep_job, typeof(*job), dep);
>+
>+	xe_tt_iova_copy_fini(&job->copy);
>+	drm_sched_job_cleanup(&job->dep.drm);
>+	kfree(job);
>+}
>+
>+static const struct xe_dep_job_ops xe_iova_defrag_job_ops = {
>+	.run_job = xe_iova_defrag_job_run,
>+	.free_job = xe_iova_defrag_job_free,
>+};
>+
> /*
>  * xe_tt_iova_transfer - Transfer a full IOVA reservation old_tt -> new_tt.
>  *
>@@ -1063,7 +1184,6 @@ static int xe_tt_map_iova_copy(struct xe_device *xe, struct ttm_tt *new_tt,
>  * folio walk of the new tt keeps xe->mem.dma_mapped_pages[] exact while the new
>  * mapping lives, rather than carrying the old tt's stale distribution.
>  */
>-__maybe_unused
> static void xe_tt_iova_transfer(struct xe_device *xe,
> 				struct xe_ttm_tt *new_tt,
> 				struct xe_ttm_tt *old_tt)
>@@ -1078,6 +1198,154 @@ static void xe_tt_iova_transfer(struct xe_device *xe,
> 	old_tt->use_iova = false;
> }
>
>+/*
>+ * xe_bo_defrag_iova_copy - Run an IOVA defrag move with a packed copy mapping.
>+ *
>+ * Only the changed (non-borrowed) pages of @new_tt are DMA mapped, packed
>+ * contiguously into the front of its reservation, the GPU copy blits them from
>+ * the old tt at natural offsets, and a post-copy finalize job adopts the old
>+ * tt's full reservation and relinks the changed runs. Returns the finalize
>+ * job's finished fence (the fence the move waits on), or an ERR_PTR on failure
>+ * with all partial state unwound.
>+ */
>+static struct dma_fence *
>+xe_bo_defrag_iova_copy(struct xe_device *xe, struct xe_migrate *migrate,
>+		       struct xe_bo *bo, struct ttm_resource *old_mem,
>+		       struct ttm_resource *new_mem, struct ttm_tt *old_tt,
>+		       bool handle_system_ccs)
>+{
>+	struct ttm_tt *new_tt = bo->ttm.ttm;
>+	struct xe_ttm_tt *new_xe_tt = container_of(new_tt, struct xe_ttm_tt, ttm);
>+	struct xe_ttm_tt *old_xe_tt = container_of(old_tt, struct xe_ttm_tt, ttm);
>+	struct drm_sched_entity *entity =
>+		xe_dep_scheduler_entity(xe->mem.defrag.iova_sched);
>+	struct xe_iova_defrag_job *job;
>+	struct dma_fence *copy_fence;
>+	struct dma_fence *fence;
>+	struct xe_tt_iova_copy copy;
>+	bool packed = false;
>+	int err;
>+
>+	xe_assert(xe, new_xe_tt->use_iova && !new_xe_tt->iova_linked);
>+	xe_assert(xe, old_xe_tt->use_iova && old_xe_tt->iova_linked);
>+
>+	err = xe_tt_iova_copy_init(new_tt, old_tt, &copy);
>+	if (err)
>+		return ERR_PTR(err);
>+
>+	if (copy.nr_changed) {
>+		err = xe_tt_map_iova_copy(xe, new_tt, &copy);
>+		if (err)
>+			goto err_copy;
>+		packed = true;
>+
>+		copy_fence = xe_migrate_copy_defrag_iova(migrate, bo, old_mem,
>+							 new_mem, old_tt,
>+							 copy.nr_changed,
>+							 handle_system_ccs);
>+	} else {
>+		copy_fence = dma_fence_get_stub();
>+	}
>+	if (IS_ERR(copy_fence)) {
>+		err = PTR_ERR(copy_fence);
>+		goto err_unmap;
>+	}
>+
>+	job = kzalloc(sizeof(*job), GFP_KERNEL);
>+	if (!job) {
>+		err = -ENOMEM;
>+		goto err_fence;
>+	}
>+
>+	job->dep.ops = &xe_iova_defrag_job_ops;
>+	job->xe = xe;
>+	job->new_tt = new_tt;
>+	job->copy_iova = new_xe_tt->iova;
>+	job->copy_bytes = (size_t)copy.nr_changed << PAGE_SHIFT;
>+	job->copy = copy;
>+
>+	err = drm_sched_job_init(&job->dep.drm, entity, 1, NULL, 0);
>+	if (err)
>+		goto err_job;
>+
>+	err = drm_sched_job_add_dependency(&job->dep.drm,
>+					   dma_fence_get(copy_fence));
>+	if (err)
>+		goto err_job_init;
>+
>+	/*
>+	 * Point of no failure: transfer the old tt's full reservation to the
>+	 * new tt. The finalize job (already armed below) destroys the packed
>+	 * copy mapping snapshot and relinks the changed runs.
>+	 */
>+	xe_tt_iova_transfer(xe, new_xe_tt, old_xe_tt);

Assisted-by: LLM

We transfer the ownership here without waiting for blit to complete.
Probbly we should wait for copy fence to complete?

Niranjana

>+	memset(&copy, 0, sizeof(copy)); /* ownership moved to the job */
>+
>+	drm_sched_job_arm(&job->dep.drm);
>+	fence = dma_fence_get(&job->dep.drm.s_fence->finished);
>+	drm_sched_entity_push_job(&job->dep.drm);
>+
>+	dma_fence_put(copy_fence);
>+
>+	return fence;
>+
>+err_job_init:
>+	drm_sched_job_cleanup(&job->dep.drm);
>+err_job:
>+	kfree(job);
>+err_fence:
>+	/*
>+	 * The GPU copy into the packed destination mapping was already
>+	 * submitted; it must finish before we tear that mapping down below,
>+	 * otherwise the blit would fault or scribble on unmapped IOVA. (Reached
>+	 * only with a valid, submitted copy_fence; the IS_ERR(copy_fence) case
>+	 * jumps straight to err_unmap with no GPU work in flight.)
>+	 */
>+	if (packed)
>+		dma_fence_wait(copy_fence, false);
>+	dma_fence_put(copy_fence);
>+err_unmap:
>+	if (packed)
>+		dma_iova_unlink(xe->drm.dev, &new_xe_tt->iova, 0,
>+				(size_t)copy.nr_changed << PAGE_SHIFT,
>+				DMA_BIDIRECTIONAL, DMA_ATTR_SKIP_CPU_SYNC);
>+err_copy:
>+	xe_tt_iova_copy_fini(&copy);
>+	return ERR_PTR(err);
>+}
>+
>+/*
>+ * xe_bo_defrag_use_iova - Whether a defrag move should use the packed IOVA path.
>+ *
>+ * Eligible when the move is a defrag (stashed old tt) and the destination tt is
>+ * IOVA mapped. The IOVA reservation is transferred to the new backing, so the
>+ * device-visible addresses are preserved and no GPU rebind is needed (see
>+ * xe_bo_trigger_rebind()); this makes the path worthwhile regardless of BO
>+ * size. A flat-CCS aux pass, if needed, is migrated packed alongside the data
>+ * (changed pages only), so it does not disqualify the path. Otherwise the
>+ * full-mapping defrag path is used.
>+ */
>+static bool xe_bo_defrag_use_iova(struct ttm_buffer_object *ttm_bo)
>+{
>+	struct xe_ttm_tt *xe_tt, *old_xe_tt;
>+
>+	if (!ttm_bo->defrag_old_tt || !ttm_bo->ttm)
>+		return false;
>+
>+	xe_tt = container_of(ttm_bo->ttm, struct xe_ttm_tt, ttm);
>+	old_xe_tt = container_of(ttm_bo->defrag_old_tt, struct xe_ttm_tt, ttm);
>+
>+	/*
>+	 * Both tts must be IOVA mapped: the packed copy reads the old tt's IOVA
>+	 * and the finalize job transfers the old tt's reservation to the new
>+	 * one. use_iova is a deterministic per-device decision taken at tt
>+	 * creation, so for a given BO the old and new tt always agree; the
>+	 * explicit old-tt check guards against ever routing a sg-fallback old
>+	 * tt into xe_tt_iova_transfer() (which would copy an invalid iova).
>+	 */
>+	return xe_tt->use_iova && old_xe_tt->use_iova;
>+}
>+
> /*
>  * Account ttm pages against the device shrinker's shrinkable and
>  * purgeable counts.
>@@ -1357,6 +1625,7 @@ static int xe_bo_trigger_rebind(struct xe_device *xe, struct xe_bo *bo,
> 	struct drm_gem_object *obj = &bo->ttm.base;
> 	struct drm_gpuvm_bo *vm_bo;
> 	bool idle = false;
>+	bool defrag_iova;
> 	int ret = 0;
>
> 	dma_resv_assert_held(bo->ttm.base.resv);
>@@ -1369,12 +1638,25 @@ static int xe_bo_trigger_rebind(struct xe_device *xe, struct xe_bo *bo,
> 		dma_resv_iter_end(&cursor);
> 	}
>
>+	/*
>+	 * A defrag move that reallocates IOVA-mapped backing preserves the
>+	 * device-visible addresses: the IOVA reservation is transferred from
>+	 * the old to the new tt, so the existing GPU PTEs stay valid and the
>+	 * BO must not be marked evicted (the rebind paths in xe_exec_ioctl()
>+	 * and preempt_rebind_work_func() would otherwise needlessly rebind).
>+	 * Preempt fences still need to be triggered, and fault-mode / L2
>+	 * flush-optimized configs still need a TLB invalidation below, so only
>+	 * the eviction marking is skipped.
>+	 */

The commit is bit confusing compared to the code below. Eviction marking is
not completely skipped, it is only skipped when it is not needed. May be
update the comment?

Niranjana

>+	defrag_iova = xe_bo_defrag_use_iova(&bo->ttm);
>+
> 	drm_gem_for_each_gpuvm_bo(vm_bo, obj) {
> 		struct xe_vm *vm = gpuvm_to_vm(vm_bo->vm);
> 		struct drm_gpuva *gpuva;
>
> 		if (!xe_vm_in_fault_mode(vm)) {
>-			drm_gpuvm_bo_evict(vm_bo, true);
>+			if (!defrag_iova)
>+				drm_gpuvm_bo_evict(vm_bo, true);
> 			/*
> 			 * L2 cache may not be flushed, so ensure that is done in
> 			 * xe_vm_invalidate_vma() below
>@@ -1394,6 +1676,8 @@ static int xe_bo_trigger_rebind(struct xe_device *xe, struct xe_bo *bo,
> 			if (!ctx->no_wait_gpu &&
> 			    !xe_vm_flush_vm_bo_tlb_async(vm, bo, vm_bo))
> 				continue;
>+			else if (defrag_iova)
>+				drm_gpuvm_bo_evict(vm_bo, true);
> 		}
>
> 		if (!idle) {
>@@ -2120,6 +2404,7 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
> 	bool needs_clear;
> 	bool handle_system_ccs = (!IS_DGFX(xe) && xe_bo_needs_ccs_pages(bo) &&
> 				  ttm && ttm_tt_is_populated(ttm)) ? true : false;
>+	bool defrag_iova = xe_bo_defrag_use_iova(ttm_bo);
> 	int ret = 0;
>
> 	/*
>@@ -2168,7 +2453,12 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
> 	needs_clear = (ttm && ttm->page_flags & TTM_TT_FLAG_ZERO_ALLOC) ||
> 		(!ttm && ttm_bo->type == ttm_bo_type_device);
>
>-	if (new_mem->mem_type == XE_PL_TT) {
>+	/*
>+	 * For a defrag move using the packed IOVA path the destination tt is
>+	 * not fully mapped here; only the changed pages are mapped (packed) for
>+	 * the copy, and the finalize job establishes the full mapping.
>+	 */
>+	if (new_mem->mem_type == XE_PL_TT && !defrag_iova) {
> 		ret = xe_tt_map(xe, ttm);
> 		if (ret)
> 			goto out;
>@@ -2278,9 +2568,16 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
>
> 		fence = xe_migrate_clear(migrate, bo, new_mem, flags);
> 	} else if (ttm_bo->defrag_old_tt) {
>-		fence = xe_migrate_copy_defrag(migrate, bo, old_mem, new_mem,
>-					       ttm_bo->defrag_old_tt,
>-					       handle_system_ccs);
>+		if (defrag_iova)
>+			fence = xe_bo_defrag_iova_copy(xe, migrate, bo, old_mem,
>+						       new_mem,
>+						       ttm_bo->defrag_old_tt,
>+						       handle_system_ccs);
>+		else
>+			fence = xe_migrate_copy_defrag(migrate, bo, old_mem,
>+						       new_mem,
>+						       ttm_bo->defrag_old_tt,
>+						       handle_system_ccs);
> 	} else {
> 		fence = xe_migrate_copy(migrate, bo, bo, old_mem, new_mem,
> 					handle_system_ccs);
>-- 
>2.34.1
>
