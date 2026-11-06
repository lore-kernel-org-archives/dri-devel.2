Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDAB606A329
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 02:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HQxKHIQP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D685112C1A;
	Fri,  6 Nov 2026 02:39:29 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 082DC112C1A;
 Fri,  6 Nov 2026 02:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793932764; x=1825468764;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=wD5X7mXeEl2AuByVXZZvyqvViDH9nvWbrYwzGySu5wI=;
 b=HQxKHIQPmhhTIlg8KK47oqx6fqo0wbCosyrdTb0iVFGsIjzMBHOZ8eYa
 NpFsmoykpUOG0IJrbKcZFIK7RvPStDSrB79vJYkAEMSbIX34/pjFZCvFx
 VG+uSW4WrNJnOuZYi3RhoSbvlLVgLKEIb/0scvRTFy0FREtio8Ke7Ca2C
 Hu5+1q+Vi+9ao5E6T+ApXaohSV8beBl97msXsotnngpzs2JwBGx4/pxQK
 v7oczNTuWQ6T3OJrBshJ7vJnhGZfGfWUbp+XlBZ+Cc60ALFUdNAv92v4v
 nF2wqeq61qsbBmQk8sljdcMsjDdgX85wW9hjlW/z7e7DXpsZy/q87lCCp w==;
X-CSE-ConnectionGUID: OnyAeQ/4QjyQelI/QpKANg==
X-CSE-MsgGUID: 5kRti8ayQJCvDz0+3/fG4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2841375"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2841375"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 18:39:23 -0800
X-CSE-ConnectionGUID: Bi7eKiSFR7qQ8fBHfSgRbA==
X-CSE-MsgGUID: 3jo6+JsVRQ+P7JQ+KLceXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7073437"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 18:39:22 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 18:39:21 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 18:39:21 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.5) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 18:39:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G9H93ynM7TBGooafg58IIPKp2IrJ2ridU24sg2kctAhcVNxOUMUMANd8I/1/cjQR8J8vit4j4++vrBo0/nqBrM8d8mqBnSkUmlTQkj8XwIssAuzWNuJar/Fvqexjmoi4aGS1eYBeQyWJf+CrRtY9dZ3wInXRO59oXpXtMZ4inOd4cTEHRGqVYWjYDvo4p9vnVwMkhdUNjLWAIJzY259ftDnbBgYBxgTN654jEuMdHglg899/ipXrr4NS1/342zIMOWwGC3sen2/Uz5PhbGidSOE0T3P/uAelZc4qd/WT4tJ1fwVHZ18OZ8UHvUGO5Sr5Xhm9BHZ7S1F3sxNBE8ei+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tv7QbmTQomQcbatk185n44eeo0lx1Z2LsmlJjweTzXA=;
 b=lTUFmaPLDd40SgF6gE9T8XMFwoj/0ECl6yU5etV/H7X7tL+HCNCdCMLXOPHMbFQQO8ZEPPBiFtsmh19sAxMcvLD0YpW7A2LUt60ZNGs+VVSFiT9AkCymwzUYXli3PvCZItUurmdsCJa+cMMfeAPjgQx+zJBiSJc3Q1tGuQAkDPFupUUAlXprkuCJ8UpbksxJ65uZ6tkcbJu/W/ukf1rSesJAO4mekrLEgJGGzAX79XKJ3CtwOANoiOznk6RZtCEX9RAX2V5NrrOS4bM+jvFTAE22InzNxjYaFkLiDwngVRwt8yyNCjnTvtET4rjRKgjMg4jIoPRYO5EB+KlPCV5jHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by MN2PR11MB4568.namprd11.prod.outlook.com (2603:10b6:208:266::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 02:39:18 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0569.011; Fri, 6 Nov 2026
 02:39:18 +0000
Date: Thu, 5 Nov 2026 18:39:16 -0800
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
Subject: Re: [PATCH v3 04/33] drm/ttm: Introduce ttm_pool_alloc_iter for
 __ttm_pool_alloc()
Message-ID: <au091GIzweGostC0@nvishwa1-desk>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-5-matthew.brost@intel.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260711025619.2540575-5-matthew.brost@intel.com>
X-ClientProxiedBy: BY1P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::13) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|MN2PR11MB4568:EE_
X-MS-Office365-Filtering-Correlation-Id: 5569aee6-139e-4610-b00d-08df3baf27e9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|18002099003|22082099003|4143699003|11063799006|56012099006|261009223027099003|261009221727099003|261009221227099003|261009223327099003|261028144727099003|261009220027099003|261021123027099003|261022075727099003|261102123227099003|261022105027099003|261026140227099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: Arw2ru0MZGsLG7EBuRef0ZrAUz3pTdvYDUQDGoF9FmwNLSJk66dhKM3ES9xXeGr3jMP4dLINsZyq8AUvjc0bNYH6gRv9pa3LtXE0XMujTBVQUFHsMKrkFxORhJ84ZDbBINLcQ/B1Dd0pX4zhSgppnITID9Cko7MnrQcgA+Fi0P4YFbdnnjV0ILqvX0iIkBzol7MQYFyrpGFODVL1ttZuU719s+ilh9UUNHgoBrfsewQ0Y96u9QYGHCxT5vig0GFddOEyumpkvz5Wy6kIKNAw0fl+BBWp1tzrcgsEjw7nrPaDd1xcVvHc+ONrtPX4v74nUXB7esfGBhiPVg0p0p8dHS337e/0ylnG9VXH+W/NnAlVdX5SF0mrZ4VK0nWwsMGwjbs0dNSZEwwL0O3UfKpTP//CU0fHQixjKMi3DiCirhMXKHkyE5UheyTQfmGigGZFskqtZORH86CE1LbYD2a4/shJEUfY0aW8QRBVDa6IMAUFYrYvRlcNvyVsarfdDhkPeIm5/f4Tv6yVOr3M4dBWn5avJWj+boEihNGbVGUMhbXTLnZWnpgJUI+o6E4uYhwwoXyu2D6AkzZ1ic3eP1lLG9JndSqobl0/Xtmvlr5rhrS/kxmCNU59RyMWSvnZgw3VHCr6T0T+5jTq7OrNNFEw+q6FFc6yjWCMzMoGMS3CyCk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(261009223027099003)(261009221727099003)(261009221227099003)(261009223327099003)(261028144727099003)(261009220027099003)(261021123027099003)(261022075727099003)(261102123227099003)(261022105027099003)(261026140227099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?jdTiFbEFltYkfT4LLXAivZl1o6EoZg67rF5U/qq998p8RWmOjNwaxvdbiJ?=
 =?iso-8859-1?Q?S44PwtHVgqI9GKrF1VAXvweOuhvxB7nkzwPgWMGIDj3IhANviXQjJZ76zT?=
 =?iso-8859-1?Q?pXkEybLQ+XNPuSScANbEgbtK1X3wm/Tiw2KJc9cC7S+/eiEAMhlYK5m8Ks?=
 =?iso-8859-1?Q?Mu2ebzfUHNk+bX8icNWTCLum9GXhoHOnU4pJFJYAL1FkB23qUCd9XS1XrM?=
 =?iso-8859-1?Q?uJMCX705O/QOPH3HvRUqKyTeShXWDRXtE3LJfjrQh0cgwJwKBuWN9w2jxi?=
 =?iso-8859-1?Q?GHqpxnJx0mPxm/vbUXgvi+7pBBzPlQxZAk2RbX1FIZsZBbVhCS0U8t8b7c?=
 =?iso-8859-1?Q?uPrcEAsWnSRj1G2uQxcYX3VAkAuWICyzCdeWbFmBhr+4AVJvCSEVCgY6iz?=
 =?iso-8859-1?Q?2ojkxXov61VyOMy+01K56PXgNsYftfciaC2UbxVk+dNkuwJch6dksCzcvb?=
 =?iso-8859-1?Q?9fMafwsk1vWrXIQUt4foatT64zgeY/Kszy/NQE5Bt3rVUnqAKJ9VYyrY5l?=
 =?iso-8859-1?Q?SGEHu5DIcI/6XWrUjIgh3+2lRUWUPNlxYtLNP5RZ1DiTNRRu4rkMFP2gFa?=
 =?iso-8859-1?Q?bDSvqCSTveQZArwvusWrCY3WSmYpP33kXxMRNTn1zRF3n8LWBbvRobNpEt?=
 =?iso-8859-1?Q?7tjrTsVWaJSCeOPROdyyhvC9uiKUI5l6qgiqqcYQfCgGe6RHd/sAjVR+oU?=
 =?iso-8859-1?Q?53p4WQM0YLvzNlX9ZeTBAXy1QrRD1zHmriu/zW024q5npZggYonSZkrOi+?=
 =?iso-8859-1?Q?9cJvNwKqo1ZuKAtBuL3bKymX5PLJTImrlQuFL2pPU4B5IRWpqKYGnMRRCC?=
 =?iso-8859-1?Q?NXomoOpHs3yxfCAOHrOE0zLa/LfLthO5/yvmybgZW+l0/no+vq8i3NBGcG?=
 =?iso-8859-1?Q?saSSqLSqXqkowTiww4vuYAH1hVzlaxIVi76/MHkjJqKnSuM+1T6Dk3anYM?=
 =?iso-8859-1?Q?YWDQo1LqsLj89bqRR/B7yUDuF3xdyyQc4Di7oINb6qBzoKletcYGbt2TJ4?=
 =?iso-8859-1?Q?RU228Ji308WqS8NyMowwmRMfqsNcqhyn3xuhY34mWp5FRtxadJXLSZnme+?=
 =?iso-8859-1?Q?wIOGy4OX9zUtoegq7iTFKXxXPzWEHdrpFUgcIX/Xj2YivIR3IcMyIVmHEY?=
 =?iso-8859-1?Q?tbxAv8Dzvlad7Pp4XUBqThco9iX9az0eCClZlXhqPoHuz5WysgS3eUNPu4?=
 =?iso-8859-1?Q?tApftJ5wiN57JhG8OmaXU6pt0/9IpIOR7D17hkp3QnXqTRKwSslvdNbXqg?=
 =?iso-8859-1?Q?E7zxgK2JllQZ46GhnADabgxBawcq8+0k0MkY/JxcaytahglDvvzEt5vYUM?=
 =?iso-8859-1?Q?zgAMuioL5pAJgw2gwns81c46RslGx85NOS8hRH8Yr8OY8qXONjYpBFtdOG?=
 =?iso-8859-1?Q?y7ptYSHFTyysiV3yM8wz8Sr48t/UE3/ptw5Hx2XhYWZcWi/7YFX6fuZV4V?=
 =?iso-8859-1?Q?74x9MDW+pnJvxeyxJ+nN9f1Hhr/tVwvvxvymWdlXMuMY9qI/Wxifvnas8Z?=
 =?iso-8859-1?Q?qi78a6wzMrN4Lluh9P8LeNawLg2lvTNWuqPWS42qzdPuciIuRSgUZCerSB?=
 =?iso-8859-1?Q?7K5VhUeCEVtRavnvREy8fpm4WhW9iRYD660D2TXBA+6Oq72K7wWPLMO8gY?=
 =?iso-8859-1?Q?peNp0/3ie6S0n24tr45HTwi77UAqfzb5GhkEnDRWYG8RcOd53PIJYPdXDA?=
 =?iso-8859-1?Q?QeMsfRV6Vo+fAl643nYoLX27xVnZHhPvZVrn41ycXM2X68dVtBZuGyhDAk?=
 =?iso-8859-1?Q?UiXvJh+pTXMZYxbPcyngNpV4mX+fQq8CPf/0p5DoHr7efHIcTKibTcW+Kz?=
 =?iso-8859-1?Q?ZIEZESIj9gj5VRewlngtxgGjdFEwkH+xe9b/BrO50aRQ5BnQ3PJ/?=
X-Exchange-RoutingPolicyChecked: DlxvWB1NRmlwCC2hR1DL87+Ny99AwbtjRuaNAA9MaFuBvcS/ST3A+OHLxCauOHQm1LqGEowp7Axg8mGde1og7QmxcX87xDZDsGX7bCwQBWYBwMWwOZVe62Ep5lQYuMSKxl5zyvTYj3qNsQjhYID6JbAacgvkBGvSV/brLeRxO+Nkkbxr/1+iSdB1wWkFFPOEUTVgRIrc/abhju7a535e0UxcCXp3A/xuE+lwTakaPlZlSg+E8x4sgdjR0jxddXIkFGMTmIwNVHsFDY7LfJ69zQXhltoiG1PnqOeIFqbVwzFPhb1HWi7e66gUDPRhjdyosyd8P9GCpaz6FwscG9b8Kw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5569aee6-139e-4610-b00d-08df3baf27e9
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 02:39:18.5927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4JbFMpjVa1beX7fO4UsQL9cRdpm2yJp9jxZ3HNnUPYY6/3EGfMUeE5cjcsI0GNV6OElbjq/7ORBfLl/PZPUmfZCRMe7chrrXT0aw+Nhy6ZVCGzCN+rFt6APtZEP34UAP
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

On Fri, Jul 10, 2026 at 07:55:50PM -0700, Matthew Brost wrote:
>__ttm_pool_alloc() walks the page orders in a single loop whose body is
>about to grow several defragmentation phases (reusing old pages, a move
>budget, out-of-lock preallocation and fault injection). Left inline these
>interleave into one deeply nested block of gotos and combinatorial
>conditionals that is hard to follow and extend.
>
>Factor the loop's working state into a struct ttm_pool_alloc_iter and
>pull the per-order page acquisition and order-fallback into small phase
>helpers, so the main loop reads as a short sequence of named steps. This
>is a pure refactor with no functional change; subsequent patches extend
>the iterator with their defrag phases rather than nesting more logic into
>the loop.
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
> drivers/gpu/drm/ttm/ttm_pool.c | 159 ++++++++++++++++++++++-----------
> 1 file changed, 106 insertions(+), 53 deletions(-)
>
>diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
>index e9175c0290d7..0ca63f5ce73c 100644
>--- a/drivers/gpu/drm/ttm/ttm_pool.c
>+++ b/drivers/gpu/drm/ttm/ttm_pool.c
>@@ -791,18 +791,102 @@ static unsigned int ttm_pool_alloc_find_order(unsigned int highest,
> 	return min_t(unsigned int, highest, __fls(alloc->remaining_pages));
> }
>
>+/**
>+ * struct ttm_pool_alloc_iter - Working state for the __ttm_pool_alloc() loop
>+ *
>+ * Bundles the immutable inputs and the mutable per-order state that the
>+ * allocation phase helpers share, so the main loop reads as a short sequence
>+ * of named phases rather than one deeply nested block.
>+ */
>+struct ttm_pool_alloc_iter {
>+	/* Immutable for the duration of the allocation. */
>+	struct ttm_pool *pool;
>+	struct ttm_tt *tt;
>+	const struct ttm_operation_ctx *ctx;
>+	struct ttm_pool_alloc_state *alloc;
>+	struct ttm_pool_tt_restore *restore;
>+	unsigned int beneficial_order;
>+	gfp_t gfp_flags;
>+
>+	/* Mutated as the loop walks the orders. */
>+	unsigned int order;
>+	enum ttm_caching page_caching;
>+	bool allow_pools;
>+	struct page *p;
>+};
>+
>+/*
>+ * Acquire a single page for the current order, leaving it in @it->p (NULL on
>+ * failure). Tries a same-order pool page, then a fresh system allocation.
>+ */
>+static void ttm_pool_iter_acquire_page(struct ttm_pool_alloc_iter *it)
>+{
>+	struct ttm_pool_type *pt;
>+
>+	/* First, try to allocate a page from a pool if one exists. */
>+	it->p = NULL;

NIT...Looks bit odd to set this to NULL here and check for '!ti->p' below.
But I see subsequent patches add more code here, probably should be fine
or add a temporary comment until then.

>+	pt = ttm_pool_select_type(it->pool, it->page_caching, it->order);
>+	if (!it->p && pt && it->allow_pools)
>+		it->p = ttm_pool_type_take(pt, ttm_pool_nid(it->pool));
>+
>+	/*
>+	 * If that fails or previously failed, allocate from system. Note that
>+	 * this also disallows additional pool allocations using write-back
>+	 * cached pools of the same order.
>+	 */
>+	if (!it->p) {
>+		it->page_caching = ttm_cached;
>+		it->allow_pools = false;
>+		it->p = ttm_pool_alloc_page(it->pool, it->gfp_flags, it->order,
>+					    it->ctx->beneficial_reclaim_backoff);
>+	}
>+}
>+
>+/*
>+ * The current order could not be satisfied. Lower it and retry, recording a
>+ * sub-optimal backing (so the driver can later re-defrag) when we drop below
>+ * the beneficial order.
>+ *
>+ * Returns 0 to retry the (lowered) order, or a negative errno.
>+ */
>+static int ttm_pool_iter_lower_order(struct ttm_pool_alloc_iter *it)
>+{
>+	if (!it->order)
>+		return -ENOMEM;
>+
>+	/*
>+	 * Failing to allocate at the device's beneficial order means we are
>+	 * about to back this object with a sub-optimal (smaller order) set of
>+	 * pages. Record it so the driver can later try to defragment the object
>+	 * back to beneficial order.
>+	 */
>+	if (it->beneficial_order && it->order == it->beneficial_order)
>+		it->tt->page_flags |= TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
>+
>+	it->order--;
>+	it->page_caching = it->tt->caching;
>+	it->allow_pools = true;
>+
>+	return 0;
>+}
>+
> static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> 			    const struct ttm_operation_ctx *ctx,
> 			    struct ttm_pool_alloc_state *alloc,
> 			    struct ttm_pool_tt_restore *restore)
> {
>-	const unsigned int beneficial_order = ttm_pool_beneficial_order(pool);
>-	enum ttm_caching page_caching;
>+	struct ttm_pool_alloc_iter it = {
>+		.pool = pool,
>+		.tt = tt,
>+		.ctx = ctx,
>+		.alloc = alloc,
>+		.restore = restore,
>+		.beneficial_order = ttm_pool_beneficial_order(pool),
>+		.page_caching = tt->caching,
>+		.allow_pools = true,
>+	};
> 	gfp_t gfp_flags = GFP_USER;
> 	pgoff_t caching_divide;
>-	unsigned int order;
>-	bool allow_pools;
>-	struct page *p;
> 	int r;
>
> 	WARN_ON(!alloc->remaining_pages || ttm_tt_is_populated(tt));
>@@ -819,59 +903,28 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> 	else
> 		gfp_flags |= GFP_HIGHUSER;
>
>-	page_caching = tt->caching;
>-	allow_pools = true;
>-	for (order = ttm_pool_alloc_find_order(MAX_PAGE_ORDER, alloc);
>+	it.gfp_flags = gfp_flags;
>+
>+	for (it.order = ttm_pool_alloc_find_order(MAX_PAGE_ORDER, alloc);
> 	     alloc->remaining_pages;
>-	     order = ttm_pool_alloc_find_order(order, alloc)) {
>-		struct ttm_pool_type *pt;
>-
>-		/* First, try to allocate a page from a pool if one exists. */
>-		p = NULL;
>-		pt = ttm_pool_select_type(pool, page_caching, order);
>-		if (pt && allow_pools)
>-			p = ttm_pool_type_take(pt, ttm_pool_nid(pool));
>-
>-		/*
>-		 * If that fails or previously failed, allocate from system.
>-		 * Note that this also disallows additional pool allocations using
>-		 * write-back cached pools of the same order. Consider removing
>-		 * that behaviour.
>-		 */
>-		if (!p) {
>-			page_caching = ttm_cached;
>-			allow_pools = false;
>-			p = ttm_pool_alloc_page(pool, gfp_flags, order,
>-						ctx->beneficial_reclaim_backoff);
>-		}
>-		/* If that fails, lower the order if possible and retry. */
>-		if (!p) {
>-			if (order) {
>-				/*
>-				 * Failing to allocate at the device's beneficial
>-				 * order means we are about to back this object
>-				 * with a sub-optimal (smaller order) set of
>-				 * pages. Record it so the driver can later try to
>-				 * defragment the object back to beneficial order.
>-				 */
>-				if (beneficial_order && order == beneficial_order)
>-					tt->page_flags |=
>-						TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
>-				--order;
>-				page_caching = tt->caching;
>-				allow_pools = true;
>-				continue;
>-			}
>-			r = -ENOMEM;
>-			goto error_free_all;
>+	     it.order = ttm_pool_alloc_find_order(it.order, alloc)) {
>+		/* Acquire a page (pool / system) for this order. */
>+		ttm_pool_iter_acquire_page(&it);
>+		if (!it.p) {
>+			r = ttm_pool_iter_lower_order(&it);
>+			if (r)
>+				goto error_free_all;
>+			continue;
> 		}
>-		r = ttm_pool_page_allocated(pool, order, p, page_caching, alloc,
>-					    restore);
>+
>+		r = ttm_pool_page_allocated(pool, it.order, it.p,
>+					    it.page_caching, alloc, restore);

Looks like iterator has a 'restore' field that gets set, but it is not used here
or in other places. Is that intended?

Other than above comments, the patch LGTM, though need to look into other patches
in this series which makes use of this iterator.

Niranjana

> 		if (r)
> 			goto error_free_page;
>
> 		if (ttm_pool_restore_valid(restore)) {
>-			r = ttm_pool_restore_commit(restore, tt->backup, ctx, alloc);
>+			r = ttm_pool_restore_commit(restore, tt->backup, ctx,
>+						    alloc);
> 			if (r)
> 				goto error_free_all;
> 		}
>@@ -887,7 +940,7 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> 	return 0;
>
> error_free_page:
>-	ttm_pool_free_page(pool, page_caching, order, p, false);
>+	ttm_pool_free_page(pool, it.page_caching, it.order, it.p, false);
>
> error_free_all:
> 	if (tt->restore)
>-- 
>2.34.1
>
