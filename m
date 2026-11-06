Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E60606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 20:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Gnt2bwCa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F127F11285E;
	Fri,  6 Nov 2026 20:06:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 924FE10EA32;
 Fri,  6 Nov 2026 20:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793995590; x=1825531590;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=aikV/rgn3Z8nBWqJTwrgZcErIi5t2WmNngQw+mc5vYo=;
 b=Gnt2bwCa5zALSkwfiYJIy44ZFxtgAyUFtonnKOUw7OOBJDJL8sFy98qD
 U/a5EyWGW7xRYr6hYH4s9q+WqJRDGFeTTiJUQGq48C9AtQdNTKTQtjUB2
 ko/x8scyRSgrIw/7318/+mrNzTDU59ygaj5sFXgev2p5a9rCpi8JSDu1J
 3uVZpUhtqNk9ZdtLxWAfQXPRVGr9SegpSvf+3O8mA7aCaxytn1xMqTXQW
 VxLCHA5ZMHdoHrwBeNJ0ZO0tHxF55CmAUsZ0ktn1L2kcdoIBOrnqq/uVa
 kAj//AYvTvLH/8SekSOX3QZynIfiILXVY8QdyvHv3nk+hhi+QxaRfCdvw w==;
X-CSE-ConnectionGUID: aREW5DI9RWCuo6GQyEsjpg==
X-CSE-MsgGUID: GC7PcJ2xS92gbEcBNv/Wmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2693729"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2693729"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 12:06:29 -0800
X-CSE-ConnectionGUID: qHKDjbXFSKu/8aer28tULQ==
X-CSE-MsgGUID: lQ5HewMrTBmtqqy3qNe9bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="7681735"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 12:06:29 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 12:06:28 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 12:06:28 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.16) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 12:06:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Br0jvQjwUG40A2sqE7V4lWBaGuHB+iJ//r66N3xAODYY4KEGxd1dhrJUTBTtkFW4NTcmlhnm19GKqkU90xbm9Jc6U6rPs2ao5K9xkzN1HV7gFiD3bJ/ZaDn/bYa8EqO0eU7aBmLDJKWjxBPkH0bwPZuXp23KSY2pqdr4hj5jxNgkVrMe9Su5aFiFJ4Ae2aekB2zO6B4fPVv1tWikBsJStRQf858CCLwlBQoeOsaTH7nopKhy0fpxYuh7LCbj6CxEgq4KtMXT8JWaadAqqp+GF+ifNo6TJH1kpOTgj9c8/PuGnc6J7wygM82CjCa1327GXs8Ovcbst7z/UYWyO9E7Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wi+ywu4X+tDx0P1vhJjMk5lh3LO8FWlCCBofepvHODg=;
 b=EZUIMPK/Iar26TpcT+M5HW3K6V79OmHtt2MJt4z4oCmECmgcjeAEyfs/YLZCyU/HMcJNDjlmOxEFWs+IfRGJzMiRKmpjS2tsLQgTchRx8BxIKnHyUOCpsyJtqdq4IdRCWbciCMsoZ7WIxaKa/MMhhR5ZZVWwVRMHWwvv4+JmvaMVQ3dt0KpA9QKRS/DdMTrxajTWkHKe8BUaazq+w6B/sD3Onv+GioQd+GYjoi1gHRV7DCzNjiv+G8KxKtWOEUrIXqw6Q5b/db5PIgCKR7N555TLOI1MdAa/Kyesb1Yjj5xKybI30vEnF5shdbQyeHJ2GBrtPJSlWryByjME4NGcjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by PH4PPF99AA64034.namprd11.prod.outlook.com (2603:10b6:518:1::e69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Fri, 6 Nov
 2026 20:06:21 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 20:06:21 +0000
Date: Fri, 6 Nov 2026 12:06:17 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
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
Message-ID: <au4zOQ0X2Lq+PsZB@gsse-cloud1.jf.intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-4-matthew.brost@intel.com>
 <au08wNRON0_b5wuG@nvishwa1-desk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <au08wNRON0_b5wuG@nvishwa1-desk>
X-ClientProxiedBy: DS7PR03CA0132.namprd03.prod.outlook.com
 (2603:10b6:5:3b4::17) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|PH4PPF99AA64034:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fe4f432-15c0-4104-2d78-08df3c416d57
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|22082099003|10067099003|18002099003|261028144727099003|56012099006|11063799006|5023799004|4143699003|261102123227099003|261021121427099003|261021123027099003|261009223327099003|261026121527099003|261009220027099003|261009221227099003|261026140227099003|261009221727099003|261009223027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: WZFr0kJdZTPKS30f4Li8Jgni8JYtsBWz4oLyE84CzZdrm5QgmwD1kS4sVWQljpd7yA2n9457nvSYD+XdA7zz8hldmWDWrTsvkuxwqfi9M67cK7BvNTV7dkrcHdaV85FcBm/wyTvEFu9iJLzFtV51sLI1r3vFsp2zQ/S9pRXEhoooZFwM0LA6hNRU7HwyXAjkERKoElJyjqo53/JNklsvJiFXmdhnlO6bzHEhySQUn2vr/IpRanrBdhx3xTrdcjtCWcu2uj5iIbRF0tv6PmrA3BdrqlzVLrgiyGzCuPV1/w1z4rOiTJZRNsxVTVr94rWlt4j8WBvjnvbBQru4e1yVfoiKpupbb9SHd11d88+ddn8f6RsN7Ve9GNlNKdCmOsmEqAvCWdt8qfDvisKv4ReFeRXvxLrL4UFkpqJ67E3D9gDN8XkJtOJ/s7g2r9RFCqHPDuJ8dL3BlkezdvDCrrltWJVdVB0Ifnq0SEAa52jhDJDG4YQ3oeYHm+wFs6lDXx0g7CuKm+G2qcssbe+tv2PVGx1uPxpuqUI4AzdaRFNIWgzb1ZXxad6ayyRcX151OFwm1Z8Y1vWjI3yqAFSzMZfIawjVAT9Pc4qoKhR6QQVizaI1tM5sXRLkx9afSzT679fGi0FkT1VhNxQWGpJZzA0W/jMfsuuH0TlJ2Mwf2r8M7zk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(22082099003)(10067099003)(18002099003)(261028144727099003)(56012099006)(11063799006)(5023799004)(4143699003)(261102123227099003)(261021121427099003)(261021123027099003)(261009223327099003)(261026121527099003)(261009220027099003)(261009221227099003)(261026140227099003)(261009221727099003)(261009223027099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?J3W6SDfLaysbiyKZMQikE8CbZxZDcBcykFCHNKMbrqWFulxLAhu8Bjl09n?=
 =?iso-8859-1?Q?S6Z17cnVHIMyD4U0IH++938KF73dzNuuTTn5c++yqZZrIaGnapqwPvwItZ?=
 =?iso-8859-1?Q?nWd7QJaHomY6z4QT1XQo/5ZzXw62FJvoERmlcBik+akECepaKg/L+dOXAc?=
 =?iso-8859-1?Q?yoiKLrh6uZwfOpHJinIsZ8EZE1F/iO8hiUg0YWAeYAfLIbOLhxddCNpJ1P?=
 =?iso-8859-1?Q?cT89Ou/f4tf3YQk1o1nd2FQSW6lFKNy2un8fU2TBBPI8073DcGeL7H3TYl?=
 =?iso-8859-1?Q?37Kt1uyZo2gyBOlER0zaa8y1o8RoHVXjQDrU53ZUpHm0RWL4rlOOFPTGvx?=
 =?iso-8859-1?Q?qGC1nl0eph3zYOchUyvaFHNPzZM1FURfdifyEG5ko0eLF53bCjNGB4c/l0?=
 =?iso-8859-1?Q?4hhD8cZScwdfOIvOH4GxvxO9QVzYLQDIo+SM5EgwDQFYqik3N2RDNSzsvs?=
 =?iso-8859-1?Q?aVODL1PHM4TZXRPtpVCHf5jiPn3agrgiEzzcrJKGAmd76StbljcVhf+Uif?=
 =?iso-8859-1?Q?oG/JYRlz1MelxfrQAxB3fborp1ImxEexUh3Ngx2kQyA8MjncSsvZDa1iyx?=
 =?iso-8859-1?Q?pR1LfprzuH7yeQkr4bLd6y5Rqgz4IagSH7e+3j/7gZc8KP1a5wQd82w7h7?=
 =?iso-8859-1?Q?F2FEnyGOn1bR/DVr9Jklb335q0y2X7vGpl+6A+FzqDwTtyoCUUCDhq8Lmr?=
 =?iso-8859-1?Q?Rd51BMNbIYI4AyLNMLpN6G+O9+RW6z7GAw/slVH2S9K3c/oKQQ5ObSiAyh?=
 =?iso-8859-1?Q?bcWrZibJc1oKm8ObtV/XnLdN8W48ZqgIJ3Z/xUI08oEn4jeWuCIE7M0Lg6?=
 =?iso-8859-1?Q?pu+iPqYokStg8JndvYEhD4WcP1rekvSK3VHlbhvAh/v7m4IeOwymcf08vn?=
 =?iso-8859-1?Q?fFk3hakJODpaKfLDCsj2c6IccaZrOCqOuP67Fy4hysudSRbNAWNkPsqqa6?=
 =?iso-8859-1?Q?gRCeOcn+jdzO/cTmzAy6byrdctdmtI0rhAbdKk2Gc02kawyVzx0Mt4xtfD?=
 =?iso-8859-1?Q?f+rz5wF8byKQ3oPHtRqsfsMhqIbjSoIUuOKa6xtilkKTfUy6DoRTqfRPL1?=
 =?iso-8859-1?Q?vOz3CqvXdP1cu6cRAem0ToTlj6acqGPbhAbkLjop3gcUUh4nf47fCUSAjD?=
 =?iso-8859-1?Q?oXcSJcf4hzi6hFa3qbmdeuNGSqaCRFDMc49/D3UrvWn8dFiR4PBE2C1QJY?=
 =?iso-8859-1?Q?ZvujmYN+3r8n28+eQ8EhDvIhAwMcDYEcF8Dk5y/7S7nT/x3FRlNBYFoJ6l?=
 =?iso-8859-1?Q?ci6T88DfHMpWMus7e1gM4YGS13RYzU7icK69jayS8jVA9ksovfS/52RtdY?=
 =?iso-8859-1?Q?Nk9XKULmbeUyWyrzKv0wgjJYVMhzzyMOPNtaMlFtxpHK/0ShVOoxr/awp2?=
 =?iso-8859-1?Q?gUl9vVVFxopyKCZbbEKjixjtHVhedukqns9BFguoglnPI0hE29FoLU3fvy?=
 =?iso-8859-1?Q?p692ixkMI3FSzgpsiizWgOTXaP2GmFjQdtjy90WrqCZLITcEVeED3yaxGi?=
 =?iso-8859-1?Q?0EXHAVcss2shYV/cRBzvVXEXAPXQY9pP7AjmDH+LBmv8XF58fotupcTOhv?=
 =?iso-8859-1?Q?Uw+k0/+febTE6/ryUkXu3QDQUeCGTAwwZBgi4yFn+PLwghEINRc3CWrXBH?=
 =?iso-8859-1?Q?6RhcRESYJeXZ2nzIo3t9KM3FBqYm68Cid6FXOn6zs3+2iVKOXXO0iMan8h?=
 =?iso-8859-1?Q?oaUpeVKIa6tKx2ozutVhNRPmeDqPzDgC9LrToBzw3pbu5syOvKsqPx14Ab?=
 =?iso-8859-1?Q?BjI9/T2KCyfSgv+tJFtQd7ntKpGziBK3v9ftNK8Z4m3HITMFtx/Y8vLoux?=
 =?iso-8859-1?Q?47889jpRXg=3D=3D?=
X-Exchange-RoutingPolicyChecked: fXa6Et8RwwxHIRC/ygsxjsuXOI0bbCYDRdD0qS7TRH76EIhL9LHN+QzTt46cO+0bwSpCde/kdbCD2H720aV62nq5EwfqCLF0Y+1CrxrfXX6tmsx1mTJyfzmbfifLrNeW0LwOIBssIdwdByXt2DkU7xCfsGXh2aRne/oGj+wy6/1hvJtUmnj+B3H1c0zYfAlXijrjsbifp90BG0d4AP/RI4Xc0uMLq8p3iruTvVOKUVYpJp4WWScAEiBXjQTZ6zQ6uuiWbyMLuzFTavJwzvNOu1Aa1Td5phl7azemcSyP2FhqcRwsnzc2UiF6vjJ9Cc1/qh60cabR2jBBUyc3xJrjfw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe4f432-15c0-4104-2d78-08df3c416d57
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 20:06:21.7280 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+ABlY2ArdaSF16F8tTq0KIIvVd0/j9oBy8pGb4o5NjPrgkt6wh479Nkk+vk8mH1ln6ci3R0O0Cvz7p8Uo7XLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH4PPF99AA64034
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

On Thu, Nov 05, 2026 at 06:34:40PM -0800, Niranjana Vishwanathapura wrote:
> On Fri, Jul 10, 2026 at 07:55:49PM -0700, Matthew Brost wrote:
> > When __ttm_pool_alloc() fails to allocate a chunk at the device's
> > beneficial order and falls back to a smaller order, the object ends up
> > backed by a sub-optimal set of pages. Nothing currently records this, so
> > a driver has no way to know an object would benefit from being re-backed
> > with beneficial-order pages later.
> > 
> > Add TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED to struct ttm_tt page_flags,
> > cleared at the start of every fresh allocation (in both ttm_pool_alloc()
> > and ttm_pool_restore_and_alloc()). Set it in __ttm_pool_alloc() when an
> > allocation at exactly the beneficial order fails before dropping to a
> > lower order.
> > 
> > Drivers can use this hint to queue the buffer object for later
> > defragmentation.
> > 
> > Cc: Carlos Santa <carlos.santa@intel.com>
> > Cc: Ryan Neph <ryanneph@google.com>
> > Cc: Christian Koenig <christian.koenig@amd.com>
> > Cc: Huang Rui <ray.huang@amd.com>
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Simona Vetter <simona@ffwll.ch>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > Assisted-by: GitHub_Copilot:claude-opus-4.8
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > ---
> > drivers/gpu/drm/ttm/ttm_pool.c | 13 +++++++++++++
> > include/drm/ttm/ttm_tt.h       | 24 +++++++++++++++++++++++-
> > 2 files changed, 36 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> > index 5b7d7f5ae53d..e9175c0290d7 100644
> > --- a/drivers/gpu/drm/ttm/ttm_pool.c
> > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> > @@ -796,6 +796,7 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> > 			    struct ttm_pool_alloc_state *alloc,
> > 			    struct ttm_pool_tt_restore *restore)
> > {
> > +	const unsigned int beneficial_order = ttm_pool_beneficial_order(pool);
> > 	enum ttm_caching page_caching;
> > 	gfp_t gfp_flags = GFP_USER;
> > 	pgoff_t caching_divide;
> > @@ -846,6 +847,16 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> > 		/* If that fails, lower the order if possible and retry. */
> > 		if (!p) {
> > 			if (order) {
> > +				/*
> > +				 * Failing to allocate at the device's beneficial
> > +				 * order means we are about to back this object
> > +				 * with a sub-optimal (smaller order) set of
> > +				 * pages. Record it so the driver can later try to
> > +				 * defragment the object back to beneficial order.
> > +				 */
> > +				if (beneficial_order && order == beneficial_order)
> > +					tt->page_flags |=
> > +						TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
> 
> I haven't looked at beneficial_reclaim_backoff usecase yet, but this flag
> gets set irrespective of whether the allocation failure resulted with/without
> the beneficial_reclaim_backoff request from the driver. Is that intended?
> 

Yes. The end goal (the series on list needs a slight Xe side tweak) it
everything in the foreground (new memory allocations, swapin after
shrinking, etc..) sets beneficial_reclaim_backoff (no reclaim). In that
case if we don't get optimial pages, the defragmenter in the background
does aggresive reclaim and then prunes in pages it finds at
beneficial_order in a way we don't miss page flips.

Matt

> Other than that, the change here LGTM, though I still need to look at how driver uses
> this flag in more detail.
> 
> Niranjana
> 
> > 				--order;
> > 				page_caching = tt->caching;
> > 				allow_pools = true;
> > @@ -910,6 +921,7 @@ int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> > 	if (WARN_ON(ttm_tt_is_backed_up(tt)))
> > 		return -EINVAL;
> > 
> > +	tt->page_flags &= ~TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
> > 	ttm_pool_alloc_state_init(tt, &alloc);
> > 
> > 	return __ttm_pool_alloc(pool, tt, ctx, &alloc, NULL);
> > @@ -942,6 +954,7 @@ int ttm_pool_restore_and_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> > 	if (!restore) {
> > 		gfp_t gfp = GFP_KERNEL | __GFP_NOWARN;
> > 
> > +		tt->page_flags &= ~TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
> > 		ttm_pool_alloc_state_init(tt, &alloc);
> > 		if (ctx->gfp_retry_mayfail)
> > 			gfp |= __GFP_RETRY_MAYFAIL;
> > diff --git a/include/drm/ttm/ttm_tt.h b/include/drm/ttm/ttm_tt.h
> > index 406437ad674b..ce7533677d77 100644
> > --- a/include/drm/ttm/ttm_tt.h
> > +++ b/include/drm/ttm/ttm_tt.h
> > @@ -90,6 +90,14 @@ struct ttm_tt {
> > 	 * TTM_TT_FLAG_BACKED_UP: TTM internal only. This is set if the
> > 	 * struct ttm_tt has been (possibly partially) backed up.
> > 	 *
> > +	 * TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED: Set by the TTM pool allocator
> > +	 * when at least one chunk that could have been allocated at the pool's
> > +	 * beneficial order had to fall back to a smaller order. This indicates
> > +	 * that a sub-optimal set of pages was chosen for this object, and can
> > +	 * be used by drivers to queue the buffer object for later
> > +	 * defragmentation. Drivers should access this via the
> > +	 * ttm_tt_is_beneficial_order_failed() helper.
> > +	 *
> > 	 * TTM_TT_FLAG_PRIV_POPULATED: TTM internal only. DO NOT USE. This is
> > 	 * set by TTM after ttm_tt_populate() has successfully returned, and is
> > 	 * then unset when TTM calls ttm_tt_unpopulate().
> > @@ -101,8 +109,9 @@ struct ttm_tt {
> > #define TTM_TT_FLAG_EXTERNAL_MAPPABLE	BIT(3)
> > #define TTM_TT_FLAG_DECRYPTED		BIT(4)
> > #define TTM_TT_FLAG_BACKED_UP	        BIT(5)
> > +#define TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED	BIT(6)
> > 
> > -#define TTM_TT_FLAG_PRIV_POPULATED	BIT(6)
> > +#define TTM_TT_FLAG_PRIV_POPULATED	BIT(7)
> > 	uint32_t page_flags;
> > 	/** @num_pages: Number of pages in the page array. */
> > 	uint32_t num_pages;
> > @@ -179,6 +188,19 @@ static inline void ttm_tt_clear_backed_up(struct ttm_tt *tt)
> > 	tt->page_flags &= ~TTM_TT_FLAG_BACKED_UP;
> > }
> > 
> > +/**
> > + * ttm_tt_is_beneficial_order_failed() - Whether the tt is backed at a
> > + * sub-optimal page order
> > + * @tt: The struct ttm_tt.
> > + *
> > + * Return: true if the pool allocator had to fall back below the pool's
> > + * beneficial order when backing this tt, false otherwise.
> > + */
> > +static inline bool ttm_tt_is_beneficial_order_failed(const struct ttm_tt *tt)
> > +{
> > +	return tt->page_flags & TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
> > +}
> > +
> > /**
> >  * ttm_tt_create
> >  *
> > -- 
> > 2.34.1
> > 
