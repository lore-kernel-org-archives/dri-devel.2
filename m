Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30009606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 05:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VJO4nKja;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=bv3U/Mgq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 856E6112095;
	Fri, 20 Nov 2026 05:48:41 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD405112058;
 Fri, 20 Nov 2026 05:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795153710; x=1826689710;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=DTHjXhTLDbJgu3x8v319RwtuxAsuGoPu/SAktDo053Y=;
 b=VJO4nKjaj1pxH/4qMt0dqZ9Vq9vs5b2K9f4vckFXgGWPOlqmhW8jMyYO
 hbrIbYRYZ/DU+IbB67G6+JwqressvUCl8y5PCzKzKvS/cJmO9St5vwcCd
 nNrZrmdMw+bToKQir6+v/D+9Ha0XMeANJDwBWrNP3mOGKS0jIjFzPJTjG
 GNAiD2rjotdnai4teQcj/8LKVRTe94oLRjXReKQ7YbZcdF0Hg+aMYk3ru
 NwQRRz5600gi0xotVjEbq9CnxoYZXEdgiXVXFPfEki0jmF/jrrelDjCMr
 yykrcpTutM1EVbabixdc5g+3rmg1pRI4eHclVf/ZIz8Qo2VN9+Jyd/NzA w==;
X-CSE-ConnectionGUID: MX1z3gviQdKT23LzGuOFFg==
X-CSE-MsgGUID: 7XABN4h5Qo+wurkbc5X2bQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3915206"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="3915206"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 21:48:29 -0800
X-CSE-ConnectionGUID: +SoLMOOZTD2aleIW95Bx8w==
X-CSE-MsgGUID: QD0PUh0tStmdm6NnlbTomA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; d="scan'208";a="10969381"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 21:48:29 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 21:48:28 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 19 Nov 2026 21:48:28 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.44) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 21:48:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rlhVI9Q9JKqS1EdIO/2xfl11oXVHbjMti50f3rMohBuLGhSbZP+0OsYMYZPy8KLQTB9UFtwJMV7Jd3Q825oY2Sv0RJxSgmhsM+D2PgsY1AKoClIj72JIsRZJxlRgUqoNxV8bRqpTA/l7tBicLLpsUSVJ5xXFoCWI7T2cotyrGKNDS8lSzM3Gcyxv7zs2xzrI6qJY32o51mOudxy9rpKFfCVzU8Utvl1yYOgRERx5CA9tOjfGTE3pyieBBzH6mUgagJx8+XFA8rrcfSgc/jJL1xwvJr4HqB8CAbwCJD7eXRy4tIiwc7dmN9q9NjdqeEDiAFdjy1yVAagJnyzgu1MmRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNZ6LwaQTFvf+u9rmH01wwovEJ6BdGvBEHd+MudzASU=;
 b=uQReeIcEYuQGwWN+SHAtfINPPoqf+UWiionTd5Vri3IHu2n8XUn8qYcxTMSkOoLFekZAZ0PEbfZnhE7r3bM3ZoCpBx55lWY4hEf7Io7o/TtS0iMcnrPtfe4Ky5nHpYnCBVIdK9DGHoaKPTsAPA7Xm2IHB4klyjWfy2998BlrRg6vDmpimqjb3na42m63RwIC4hccuzV6+0B7z9q39HSDjjWP7deZ9jv++UJrW7s4qI9Kgyys6t/8fWX3Euh9NnngiBK+2Fla0EX1SbYQVg5KiqcVsuoBneue+0x3TbKqXTodOtmqfnrE3PAon3g8V8KUHgLiv0ORPfmw74nwT9Ohdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNZ6LwaQTFvf+u9rmH01wwovEJ6BdGvBEHd+MudzASU=;
 b=bv3U/MgqxYz9rxF+ov6dV9uHnpKm2mrGDpW5sBfemyPEhY5J3R9c3p5UcQhrAp5tFm7+XZrcKm5cPd4aB6yPX8MYAbDqkMm199XbqV+n6myNWRG4LaOuq7k1gfzRbP6M9FOPG9AEelFPuel1FgLRzSg6YrdRwJleOO2GHsVIv/M=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by DS6PR11MB931270.namprd11.prod.outlook.com (2603:10b6:8:413::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 05:48:25 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 05:48:25 +0000
Date: Thu, 19 Nov 2026 21:48:23 -0800
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
Subject: Re: [PATCH v3 10/33] drm/ttm: Add full out-of-lock preallocation for
 ttm_pool_alloc()
Message-ID: <av/fJ28fT1/3FtD1@gsse-cloud1.jf.intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-11-matthew.brost@intel.com>
 <avQZ6cCNt2H8vBtG@nvishwa1-desk>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <avQZ6cCNt2H8vBtG@nvishwa1-desk>
X-ClientProxiedBy: MW4P221CA0019.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::24) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|DS6PR11MB931270:EE_
X-MS-Office365-Filtering-Correlation-Id: 76485288-e14c-4f6a-3e9a-08df46c9e4df
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|1800799024|366016|261022075727099003|5023799004|11063799006|4143699003|261009221727099003|261021123027099003|261009223027099003|261021121427099003|261102123227099003|261102130727099003|10067099003|261009221227099003|261009220027099003|261009223327099003|261026121527099003|261026140227099003|261022105027099003|56012099006|261028144727099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: RdhMUrPNkum5W9w23f3tfpXmtv6dwsamPeBCC2xPzYeGrQu54iJ2eAlV4hQtnqGsp31Jq4eVbRhJbxaxzMv3evX7dAherFuvddnGsnQGl3zu3HFfnHl5pwv6SJ5jWavSfWy8LWMmCAJxQQasXhn1TNgttTbSKBieIYmc/82D+ItGit24jfK5Q/vARAk8XH3Dra741H/vDzMNq9MfK2/yrrwjy7d6EPnoyd/yqg+dd6wxfXJVh/XE/2n2y/UybN0Y2HaR+GDoM8aY8lJdxT7ix/vOQHaBpQr+oBxw3MOjPLhLAaaqXqhvNj8h13Cjk5sA+cz0DG4YegFx41ijBaCwAif9itNUCGNKEqvOcU7zze8Dj5m9h2wIMNtn02clbNcyeQhp6UzTzlcNeRx86J+wx7ITaOznAE/j27zYO067o5IZ2klcfZVyZ+LCGMoEx2HXE+VtNv6Yq6IyLulwVU5Wa8fzePKkqd7+Btj5GCe6y21EYG3t8OSCUmfOmwWDzrLxK5VVPH8wADsRYqGSwOaFVZI5jB/DXqz3CBOaXsK+4n5lB42e0v5ixweGgN/kxEbJIsuV6NlbWhYCNu4a69xu4cfT9GaXLaX/4ZTU16pAvHqRcw/lmy4NNUyko7VQFtQCehTEsU1fODuz+Kg/svkNDKd7IciGfloRi8UKXhPgxqs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(261022075727099003)(5023799004)(11063799006)(4143699003)(261009221727099003)(261021123027099003)(261009223027099003)(261021121427099003)(261102123227099003)(261102130727099003)(10067099003)(261009221227099003)(261009220027099003)(261009223327099003)(261026121527099003)(261026140227099003)(261022105027099003)(56012099006)(261028144727099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ZQ9t0vzkjgLaRnB4fjtxigXneoIRxRGMSJkbbBStHMkjtCJSlSoX8Uh+bZ?=
 =?iso-8859-1?Q?il0nXpGLIEqKUNklXpO+OLi6wRNRDgBfi+to2WhIFll6mSqY0UtXgVJ9Dc?=
 =?iso-8859-1?Q?2ZfctJ0Y8NHIvbBuDGi7OsCMkAzg/jcdrhp+RZuOY45iEznSMvBOPtPZmS?=
 =?iso-8859-1?Q?a3yf5sWFerCOIB6L9OjwtcCCs0411raVQfAA5GxLWaQ1NzIcu3w5Re83et?=
 =?iso-8859-1?Q?cMADFEmfY7FR9I7oHOCA5/5vE3s1EXCKsgq1KGVWp2tiUiuZ3amoR5TzMo?=
 =?iso-8859-1?Q?Acr7NsJya3IYZcjvDqAX1w6NtHZafROcL9fX7p2z7Zs0MfKEHk173fXFvP?=
 =?iso-8859-1?Q?2a5LCXJQtsvj7Knl6cEwb0rxq0INgJO8+WeGs5Su79Dmdp1Ph0S+WvGHMl?=
 =?iso-8859-1?Q?hE/ncYUban7seT2C7/xtohL8maip/nU3cEg2OC7KG+gl8gUs4Z3rL+ah7t?=
 =?iso-8859-1?Q?Pn4pervSxBl6dmTUoytE6Rv62Vlr9nJ+3axa1Ij3YJpBnYlsHAMOKoo3W6?=
 =?iso-8859-1?Q?hxTppyxT1fybEE25+Ab0Z5q7zpsFfqQJb9+lvWWVEjceWLhUhBpRr/vZnw?=
 =?iso-8859-1?Q?eaDHwLc5wJ8iFpN/LwDGa84eII0UlitDPgtJJRwXjMfImc2eLmxhfau/kY?=
 =?iso-8859-1?Q?yoSJAHK55/GmUc4vswofjuZUErGa+XZHccAOmbUIZizYLKe2CGb5EmXuPs?=
 =?iso-8859-1?Q?2vjIIwyeSOYY/gzxJ3QIJEFrbYi+4mbVqUqYNnMP9lNHAaq5MG+1UKJTp5?=
 =?iso-8859-1?Q?5A3/PLyOZL6WywBkPeyfze904d05x7Znvl+OgjQvF5cUunO9b2y/dbmiuQ?=
 =?iso-8859-1?Q?YjcTH7hryIYTTDGVM/MrLxYOdW7nVUh756x2ZUDGtA9itUcuFW+nlRZzlI?=
 =?iso-8859-1?Q?DVCrEF3S17F9lv64C1dVlIwL3R8jszgO/Caq1GxILGSf4Xy4BqqSe8MmM2?=
 =?iso-8859-1?Q?MeL83V7XH/mCo0BKjMsahsQHmNnCyESNeki9EoO92QyF2bSeLVjamu/Hmf?=
 =?iso-8859-1?Q?VlVNyxuDLcRSaehzbp1KOJB/FAsbzFe1pymMPwOInpSYvbbQs5uY2fpP6u?=
 =?iso-8859-1?Q?E3O+TANthPlyML9sxfUR1ZYwHKfIyo0N7bjFKlKMZyhPoPk/NxhPzFI9iM?=
 =?iso-8859-1?Q?eC/5nqwrNX1Ft7WXc2+VG3uMIaGko+nzv0RoIRwrJlShlRbhGB4Xrtjzv/?=
 =?iso-8859-1?Q?vCNpHSulrpFWUwVGRzCoP13Z0kicGSqkWZHfdpI0vG0HceEXCaVOFhXsFJ?=
 =?iso-8859-1?Q?Gs20anuBIbUiV/S3wiwnqSMAjc5w7xbH6nS8Y9GLBxGj1I5VGZqkLXJ4H4?=
 =?iso-8859-1?Q?5mTSaDw3L3Lg314ML7YCWFt97CgBEflsbIuD5bLwtHXmzi8X3KNIzgrf26?=
 =?iso-8859-1?Q?mmmKl1izbJYWApP28Q1EileBs+QJbZtCXNewupQuKoJooDuqtizchIQzBF?=
 =?iso-8859-1?Q?Dj+93exh8VJU3bhY4ySH8VbBSyZ7F7hk3ULZrESCFwfca9/fJgZbXQbvsN?=
 =?iso-8859-1?Q?bfS/JdPKc/MmhIUfBQsbCoTVgHCCWp2snol4y4UMxE0gQgJ0Ey0oBL6lOa?=
 =?iso-8859-1?Q?lMjAeQtP1ha+sm4p96RijwvH2JbdXndXJJ+zbchOYGzz59pKaZpgfwXiKg?=
 =?iso-8859-1?Q?PMlzc6i3Z9xyV1K0fbGVcKjVPaoh3KISTeo18PfFLVVA3RQE2eTPzg0eLQ?=
 =?iso-8859-1?Q?77axDwLFwdkWueH82eeOZLTe/0C6hinUHQo/789taXNwmRWRPqA3mflPvv?=
 =?iso-8859-1?Q?3RVvoIdkNO6amAwK0uYcwEIXMj6PGrgb0CICYrv76bNw/+ulOYi3HuGVCD?=
 =?iso-8859-1?Q?vR0N+ghkLkhOQEy4oJj68bhXClMYs04=3D?=
X-Exchange-RoutingPolicyChecked: mAFjH8zAIDC+XYUFoR/NAQnH/m2tzvVsNwTXfE3j6Y7Xi11WiocZd5tu6hU0lvJogPISdvm4Vj7RHFKK5heFQ+FNwal2884VL+Cov05O78eslAvYuHmXx1aFCIrRs2WDUM1VRJR+fwfV905v87y4ro/I8aDWQCcfEl8lkHE1iiy2s3o3W4D0jQiOqCFjcX3nwcU5f3bsEfUarXHMIVM4frPVFTi22FY1ftETiaAYPWKAgHRxNrjuvmWqwYZywXI7qRouYC3npFEREt+NeBhhNlcIYEmRB4g1yZlvSlFLR0/+Utf8lnLYI90sAraXsyhiz3U+Xr2/0IddGzhHhsi9Bg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 76485288-e14c-4f6a-3e9a-08df46c9e4df
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 05:48:25.4195 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LxkMLbb22INFp0W3pHke2qavvc0M3nD5/U38C89bqcstNmmjAjaGJ8CGAIPXr/3JXsrZGszmcGfiut+5ySGsQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB931270
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

On Tue, Nov 10, 2026 at 11:31:53PM -0800, Niranjana Vishwanathapura wrote:
> On Fri, Jul 10, 2026 at 07:55:56PM -0700, Matthew Brost wrote:
> > ttm_pool_prealloc_fill() lets a driver preallocate beneficial-order pages
> > outside the dma-resv lock for a defragmentation move, so the high-order
> > allocations that may stall in reclaim/compaction happen off the critical
> > section.  That bag is deliberately partial: it holds only interchangeable
> > beneficial-order chunks and the allocator consumes it opportunistically,
> > falling back to in-line allocation for everything else.
> > 
> > An ordinary populate of a system-memory buffer object has the same
> > problem - the whole backing is allocated under the dma-resv lock - but no
> > way to move it out of the critical section, because the existing bag does
> > not cover sub-beneficial orders and does not describe a full tt.
> > 
> > Add a "full" flavour of the same preallocation mechanism:
> > 
> >  - struct ttm_pool_prealloc gains a @full flag.  In full mode the bag is
> >    an ordered tiling of an entire tt at mixed orders (pool pages
> >    included), rather than a set of interchangeable beneficial-order
> >    chunks.  The per-chunk order is recorded on the page itself and read
> >    back at consume time, so no parallel order array is needed.
> > 
> >  - ttm_pool_prealloc_fill_full() allocates the whole backing for a tt of
> >    @num_pages pages up front, mirroring the in-line allocator's order
> >    walk (highest order first, capped by the remaining page count).  It
> >    reuses the existing unlocked helpers (ttm_pool_prealloc_gfp(),
> >    ttm_pool_set_caching()) via a new ttm_pool_take_page() helper that
> >    tries a same-order pool page before a fresh system allocation.
> > 
> >  - ttm_pool_prealloc_fini() frees any unconsumed tail at each chunk's own
> >    order when @full.
> > 
> >  - ttm_pool_prealloc_fill_full() takes a @beneficial_reclaim_backoff
> >    argument, plumbed to ttm_pool_alloc_page(), that lets the caller
> >    allocate higher-order chunks without aggressive reclaim/compaction.
> >    This suits a driver that upgrades suboptimal pages to beneficial order
> >    in place later (e.g. via a background defragmenter) and so has no need
> >    to stall the user context reclaiming for contiguity up front.
> > 
> >  - __ttm_pool_alloc() consumes a full bag with a single early branch in
> >    ttm_pool_iter_acquire_page(): install the next chunk as-is (order
> >    taken from the page) and return; once the best-effort bag is drained
> >    the loop falls through to normal in-line allocation.  The defrag
> >    harvest and reuse-old phases are inert here as there is no
> >    defrag_old_tt.
> > 
> > Like the defrag bag, this is best-effort: a short fill is fine (the pool
> > allocates the shortfall in-line) and DMA-alloc pools are unsupported
> > (caching is applied on the kernel mapping).  No functional change for
> > existing users; the new fill routine has no in-tree caller yet.
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
> > drivers/gpu/drm/ttm/ttm_pool.c | 232 ++++++++++++++++++++++++++++++++-
> > include/drm/ttm/ttm_bo.h       |  19 +--
> > include/drm/ttm/ttm_pool.h     |  27 +++-
> > 3 files changed, 258 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> > index da7d132c8297..4746f5d8cd7e 100644
> > --- a/drivers/gpu/drm/ttm/ttm_pool.c
> > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> > @@ -1046,6 +1046,7 @@ int ttm_pool_prealloc_fill(struct ttm_pool *pool, enum ttm_caching tt_caching,
> > 	pp->caching = tt_caching;
> > 	pp->count = 0;
> > 	pp->used = 0;
> > +	pp->full = false;
> > 
> > 	/* Nothing to gain without a beneficial order or for DMA-alloc pools. */
> > 	if (!order || !count || ttm_pool_uses_dma_alloc(pool))
> > @@ -1102,6 +1103,187 @@ int ttm_pool_prealloc_fill(struct ttm_pool *pool, enum ttm_caching tt_caching,
> > }
> > EXPORT_SYMBOL(ttm_pool_prealloc_fill);
> > 
> > +/*
> > + * Acquire a single *@order chunk, trying a same-order pool page first (already
> > + * carries @caching) then a fresh system allocation (write-back). Runs unlocked.
> > + * When @beneficial_reclaim_backoff is set, higher-order system allocations skip
> > + * aggressive reclaim/compaction (see ttm_pool_alloc_page()).
> > + *
> > + * A fresh system page is write-back and needs the tt's caching applied later in
> > + * bulk; *@need_caching is set true for it and false for a (pre-cached) pool
> > + * page.
> > + *
> > + * On a genuine failure *@order is left untouched (the caller lowers it by one
> > + * and retries). Fault injection instead pretends allocation at (or above) the
> > + * beneficial order failed and lowers *@order to the beneficial order, so the
> > + * caller's next attempt lands below it - mirroring the in-line acquire path's
> > + * fail_beneficial jump and exercising the beneficial_order_failed tracking
> > + * without driving the system into real fragmentation.
> > + *
> > + * Returns NULL if no page of *@order could be obtained.
> > + */
> > +static struct page *ttm_pool_take_page(struct ttm_pool *pool,
> > +				       enum ttm_caching caching,
> > +				       unsigned int *order, gfp_t gfp,
> > +				       bool *need_caching,
> > +				       bool beneficial_reclaim_backoff)
> > +{
> > +	unsigned int beneficial = ttm_pool_beneficial_order(pool);
> > +	struct ttm_pool_type *pt;
> > +	struct page *p;
> > +
> > +	*need_caching = false;
> > +
> > +	if (IS_ENABLED(CONFIG_FAULT_INJECTION) && beneficial &&
> > +	    *order >= beneficial &&
> > +	    should_fail(&beneficial_order_fault_inject, 1)) {
> > +		*order = beneficial;
> > +		return NULL;
> > +	}
> > +
> > +	pt = ttm_pool_select_type(pool, caching, *order);
> > +	if (pt) {
> > +		p = ttm_pool_type_take(pt, ttm_pool_nid(pool));
> > +		if (p)
> > +			return p;	/* pool page already carries @caching */
> > +	}
> > +
> > +	p = ttm_pool_alloc_page(pool, gfp, *order, beneficial_reclaim_backoff);
> > +	if (!p)
> > +		return NULL;
> > +
> > +	/* Fresh system page is write-back; caller applies @caching in bulk. */
> > +	*need_caching = true;
> > +	return p;
> > +}
> > +
> > +/**
> > + * ttm_pool_prealloc_fill_full() - Preallocate a whole tt's backing outside any
> > + * lock
> > + * @pool: The pool to allocate from.
> > + * @tt_caching: The requested cpu-caching for the pages allocated.
> > + * @pp: Prealloc bag to fill; marked @full and tiled with mixed-order chunks.
> > + * @num_pages: Number of 4K pages the tt needs backed.
> > + *
> > + * Unlike ttm_pool_prealloc_fill() (which parks a bag of interchangeable
> > + * beneficial-order defrag chunks), this allocates the ENTIRE backing for a tt
> > + * of @num_pages pages up front, at whatever mix of orders is available (pool
> > + * pages included), so that the subsequent __ttm_pool_alloc() under the dma-resv
> > + * lock merely installs the pages without stalling in reclaim/compaction. The
> > + * chunk orders mirror the in-line allocator's order walk; each chunk's order is
> > + * recorded on the page itself and read back at consume time.
> > + *
> > + * May sleep/reclaim freely as it runs unlocked. When
> > + * @beneficial_reclaim_backoff is set, higher-order chunks are taken without
> > + * aggressive reclaim/compaction: the caller relies on a background
> > + * defragmenter to upgrade to beneficial-order pages in place later, so there
> > + * is no need to stall the user context reclaiming for contiguity here. A short
> > + * fill is fine: the pool falls back to in-line allocation for the shortfall.
> > + * DMA-alloc pools are not supported (the bag stays empty). Returns 0 (release
> > + * with ttm_pool_prealloc_fini()).
> > + */
> > +int ttm_pool_prealloc_fill_full(struct ttm_pool *pool,
> > +				enum ttm_caching tt_caching,
> > +				struct ttm_pool_prealloc *pp,
> > +				unsigned int num_pages,
> > +				bool beneficial_reclaim_backoff)
> > +{
> > +	gfp_t gfp = ttm_pool_prealloc_gfp(pool) | __GFP_ZERO |
> > +		__GFP_RETRY_MAYFAIL | __GFP_NOWARN;
> 
> Assisted-by: LLM
> 

Yes.

> __GFP_RETRY_MAYFAIL is bit confusing here as as ttm_pool_alloc_page()
> is expected to suppy it (patch 1). I see that only applies to
> beneficial order, but here we have mixed-order and hence it is set
> here. May be add some documentation to clarify it?
> 

Ye, this is a bit confusing. ttm_pool_alloc_page will change these flags
based beneficial_reclaim_backoff / beneficial_order. In general I chose
to set __GFP_RETRY_MAYFAIL here as a default to avoid the prealloc to
avoid any chance of triggering OOM - i.e., if prealloc fails for
whatever reason we fall back the traditional TTM alloc path which I
think is correct.

So maybe '__GFP_RETRY_MAYFAIL is set to never trigger OOM on prealloc'.

> > +	unsigned int highest = MAX_PAGE_ORDER;
> > +	unsigned int remaining = num_pages;
> > +	struct page **cpages = NULL;
> > +	unsigned int ncpages = 0;
> > +	int r;
> > +
> > +	pp->pages = NULL;
> > +	pp->order = 0;
> > +	pp->caching = tt_caching;
> > +	pp->count = 0;
> > +	pp->used = 0;
> > +	pp->full = true;
> > +
> > +	/* Caching is applied on the kernel mapping, so DMA-alloc is unsupported. */
> > +	if (!num_pages || ttm_pool_uses_dma_alloc(pool))
> > +		return 0;
> > +
> > +	/* Worst case is one order-0 chunk per page. */
> > +	pp->pages = kvzalloc_objs(*pp->pages, num_pages);
> > +	if (!pp->pages)
> > +		return 0;
> > +
> > +	/*
> > +	 * Fresh write-back chunks get their caching changed in a single
> > +	 * set_pages_array_*() after the fill; collect their constituent pages
> > +	 * into an unpacked scratch array (one entry per 4K page) since the
> > +	 * packed bag holds mixed-order chunks. Cached tts and pool pages need
> > +	 * no change (and non-x86 handles caching at map time).
> > +	 */
> > +	if (IS_ENABLED(CONFIG_X86) && tt_caching != ttm_cached) {
> > +		cpages = kvzalloc_objs(*cpages, num_pages);
> 
> Same comment as in patch 9.
> cpages is tansient memory and unlike patch 9, it is not bounded by 'budget' here.

It is not bounded by any budget rather by the number pages in the BO
size.

> may be it can be avoided altogether by using a one static 4k page in the
> pool and flush it with set_pages_array*() as and when it fills up?
> 

I think that is the wrong trade. set_pages_array on x86 does some
hardware interaction which is rather expensive, thus the entire reason
TTM pool exist to avoid calling set_pages_array on every alloc / free.
i.e., more tansient memory vs 1 hardware interaction is the right trade.

> > +		if (!cpages) {
> > +			kvfree(pp->pages);
> > +			pp->pages = NULL;
> > +			return 0;
> > +		}
> > +	}
> > +
> > +	while (remaining) {
> > +		unsigned int order = min_t(unsigned int, highest,
> > +					   __fls(remaining));
> > +		bool need_caching;
> > +		struct page *p;
> > +
> > +		for (;;) {
> > +			p = ttm_pool_take_page(pool, tt_caching, &order, gfp,
> > +					       &need_caching,
> > +					       beneficial_reclaim_backoff);
> > +			if (p)
> > +				break;
> > +			if (!order)
> > +				goto apply_caching;	/* short fill */
> > +			/*
> > +			 * Genuine failure: retry one order down. A fault
> > +			 * injection lowered @order to the beneficial order
> > +			 * above, so this drops it below - landing on a
> > +			 * sub-optimal (defrag-worthy) chunk.
> > +			 */
> > +			order--;
> > +		}
> > +
> > +		pp->pages[pp->count++] = p;
> > +		if (cpages && need_caching)
> > +			ttm_pool_prealloc_stage_caching(cpages, &ncpages, p,
> > +							order);
> > +		remaining -= 1u << order;
> > +		highest = order;
> > +	}
> > +
> > +apply_caching:
> > +	/*
> > +	 * Apply the requested caching to every collected page in one shot. On
> > +	 * failure the pages' caching is indeterminate, so drop the whole bag
> > +	 * (freeing restores write-back) and let the consumer allocate in-line.
> > +	 */
> > +	r = ttm_pool_prealloc_apply_caching(tt_caching, cpages, ncpages);
> > +	kvfree(cpages);
> > +	if (r) {
> > +		unsigned int i;
> > +
> > +		for (i = 0; i < pp->count; i++) {
> > +			struct page *p = pp->pages[i];
> > +
> > +			ttm_pool_free_page(pool, tt_caching,
> > +					   ttm_pool_page_order_nodma(p), p,
> > +					   false);
> > +		}
> > +		pp->count = 0;
> > +	}
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(ttm_pool_prealloc_fill_full);
> 
> It has lot of code common with ttm_pool_prealloc_fill(). May be extract common
> code to separate function/s?

I see what you mean, but the algorithms are different. One tries to
obtain N beneficially ordered pages, while the other fills an array with
any set of pages regardless of order.

I'm hesitant to force the code into helpers or create a single unified
function with conditionals just to save 70 lines of code. In my opinion,
the abstraction is already at the right level.

> 
> > +
> > /**
> >  * ttm_pool_prealloc_fini() - Release unconsumed preallocated pages
> >  * @pool: The pool the pages came from.
> > @@ -1111,9 +1293,13 @@ void ttm_pool_prealloc_fini(struct ttm_pool *pool, struct ttm_pool_prealloc *pp)
> > {
> > 	unsigned int i;
> > 
> > -	for (i = pp->used; i < pp->count; ++i)
> > -		ttm_pool_free_page(pool, pp->caching, pp->order, pp->pages[i],
> > -				   false);
> > +	for (i = pp->used; i < pp->count; ++i) {
> > +		struct page *p = pp->pages[i];
> > +		unsigned int order = pp->full ?
> > +			ttm_pool_page_order_nodma(p) : pp->order;
> > +
> > +		ttm_pool_free_page(pool, pp->caching, order, p, false);
> > +	}
> > 	kvfree(pp->pages);
> > 	pp->pages = NULL;
> > 	pp->count = 0;
> > @@ -1251,9 +1437,10 @@ static int ttm_pool_iter_reuse_old(struct ttm_pool_alloc_iter *it)
> > 
> > /*
> >  * Acquire a single page for the current order, leaving it in @it->p (NULL on
> > - * failure). Tries, in order: a beneficial-order page preallocated outside the
> > - * dma-resv lock (defrag), a same-order pool page, then a fresh system
> > - * allocation. Fault injection can force the beneficial-order paths to "fail".
> > + * failure). Tries, in order: a chunk from a full out-of-lock prealloc (populate
> > + * of the whole tt), a beneficial-order page preallocated outside the dma-resv
> > + * lock (defrag), a same-order pool page, then a fresh system allocation. Fault
> > + * injection can force the beneficial-order paths to "fail".
> >  */
> > static void ttm_pool_iter_acquire_page(struct ttm_pool_alloc_iter *it)
> > {
> > @@ -1262,6 +1449,39 @@ static void ttm_pool_iter_acquire_page(struct ttm_pool_alloc_iter *it)
> > 
> > 	it->p = NULL;
> > 
> > +	/*
> > +	 * Full prealloc: the entire backing was allocated (pool + system, at
> > +	 * mixed orders) outside the dma-resv lock. Install the next chunk as-is,
> > +	 * taking its order from the page. Falls through to in-line allocation
> > +	 * once the best-effort bag is drained.
> > +	 */
> > +	if (pp && pp->full && pp->used < pp->count) {
> > +		it->fail_beneficial = false;
> > +		it->p = pp->pages[pp->used++];
> > +		it->order = ttm_pool_page_order_nodma(it->p);
> > +		it->page_caching = it->tt->caching;
> 
> Same comment as in 23.
> We should ensure caching has not changed here after prefill
> (ie., pp->caching == it->tt->caching). Though it is not expected to change
> in gem_create_ioctl call (unlike defragmentation case of patch 23),
> probably it is still better to check to ensure TTM prealloc() and
> pool_alloc_page() interfaces work correctly together?
> 

We don't have formalized assert framework in TTM like we do in Xe but
perhaps we should - I'd like add one in a follow up as there as so many
undocumented invarients in TTM...

So...

/* TODO: formalize invarients in a common TTM assert framework */
WARN_ON(it->tt->caching != pp->pp->caching)?

Matt

> > +
> > +		/*
> > +		 * The full prealloc tiles at whatever orders were available
> > +		 * without stalling in reclaim. A sub-beneficial chunk only
> > +		 * means a sub-optimal backing (defrag-worthy) when it sits in a
> > +		 * beneficial-order aligned region that fully fits in the tt -
> > +		 * that region could have been a beneficial-order page. A low
> > +		 * order in the unaligned trailing tail is expected and must not
> > +		 * flag the tt (mirrors ttm_pool_harvest_remaining()).
> > +		 */
> > +		if (it->beneficial_order && it->order < it->beneficial_order) {
> > +			pgoff_t bnr = 1UL << it->beneficial_order;
> > +			pgoff_t off = it->tt->num_pages -
> > +				      it->alloc->remaining_pages;
> > +
> > +			if (round_down(off, bnr) + bnr <= it->tt->num_pages)
> > +				it->tt->page_flags |=
> > +					TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
> > +		}
> > +		return;
> > +	}
> > +
> > 	/*
> > 	 * Fault injection: pretend allocation at (or above) the device's
> > 	 * beneficial order failed, forcing a sub-optimal backing. Exercises the
> > diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
> > index a80304f179ba..52ec7e5c0d2d 100644
> > --- a/include/drm/ttm/ttm_bo.h
> > +++ b/include/drm/ttm/ttm_bo.h
> > @@ -238,14 +238,17 @@ struct ttm_operation_ctx {
> > 	 */
> > 	s64 defrag_bytes_remaining;
> > 	/**
> > -	 * @prealloc: Pages preallocated outside the dma-resv lock for a defrag
> > -	 * move. The pool allocator consumes these instead of allocating fresh
> > -	 * beneficial-order pages under the lock, moving the (potentially
> > -	 * reclaim/compaction stalling) high-order allocations out of the
> > -	 * critical section. NULL means allocate in-line as usual. The pool
> > -	 * silently falls back to in-line allocation for any shortfall. The
> > -	 * allocator consumes it for beneficial-order chunks of any populate;
> > -	 * drivers only set it for a defrag move.
> > +	 * @prealloc: Pages preallocated outside the dma-resv lock. The pool
> > +	 * allocator consumes these instead of allocating under the lock, moving
> > +	 * the (potentially reclaim/compaction stalling) allocations out of the
> > +	 * critical section. NULL means allocate in-line as usual. Two flavours,
> > +	 * distinguished by ttm_pool_prealloc::full:
> > +	 *   - defrag bag (full=false): a bag of interchangeable beneficial-order
> > +	 *     chunks consumed only for beneficial-order chunks of a defrag move.
> > +	 *   - full tiling (full=true): the entire backing of the tt, at mixed
> > +	 *     orders, consumed for every chunk of an ordinary populate.
> > +	 * The allocator silently falls back to in-line allocation for any
> > +	 * shortfall.
> > 	 */
> > 	struct ttm_pool_prealloc *prealloc;
> > 	/**
> > diff --git a/include/drm/ttm/ttm_pool.h b/include/drm/ttm/ttm_pool.h
> > index 71670350eb15..777d5aa08f6a 100644
> > --- a/include/drm/ttm/ttm_pool.h
> > +++ b/include/drm/ttm/ttm_pool.h
> > @@ -83,18 +83,27 @@ void ttm_pool_free(struct ttm_pool *pool, struct ttm_tt *tt);
> > 
> > /**
> >  * struct ttm_pool_prealloc - Pages preallocated outside the dma-resv lock
> > - * @pages: Array of @count beneficial-order pages (or fewer if a fill fell
> > - *         short); each entry is the head page of a 1 << @order chunk.
> > - * @order: Page order of every preallocated chunk.
> > + * @pages: Array of @count preallocated chunks; each entry is the head page of a
> > + *         chunk. In defrag mode every chunk is @order pages; in @full mode the
> > + *         chunks tile a whole tt at mixed orders and the per-chunk order is read
> > + *         back from the page itself.
> > + * @order: Page order of every preallocated chunk (defrag mode only; 0 in @full
> > + *         mode where each chunk carries its own order).
> >  * @caching: CPU caching applied to the pages, so leftovers can be restored
> >  *           to write-back before being freed.
> >  * @count: Number of valid entries in @pages.
> >  * @used: Number of entries already consumed by the pool allocator.
> > + * @full: When set the bag holds a full, mixed-order tiling of an entire tt
> > + *        (produced by ttm_pool_prealloc_fill_full()) rather than a bag of
> > + *        interchangeable beneficial-order defrag chunks. The pool allocator
> > + *        then drains the bag in order for every populate, taking each chunk's
> > + *        order from the page, and falls back to in-line allocation only for any
> > + *        shortfall.
> >  *
> >  * Defrag pages are interchangeable, so only a count of beneficial-order chunks
> > - * is needed. ttm_pool_prealloc_fill() populates this outside the lock and
> > - * __ttm_pool_alloc() drains it; any unused tail is released by
> > - * ttm_pool_prealloc_fini().
> > + * is needed. ttm_pool_prealloc_fill() / ttm_pool_prealloc_fill_full() populate
> > + * this outside the lock and __ttm_pool_alloc() drains it; any unused tail is
> > + * released by ttm_pool_prealloc_fini().
> >  */
> > struct ttm_pool_prealloc {
> > 	struct page **pages;
> > @@ -102,10 +111,16 @@ struct ttm_pool_prealloc {
> > 	enum ttm_caching caching;
> > 	unsigned int count;
> > 	unsigned int used;
> > +	bool full;
> > };
> > 
> > int ttm_pool_prealloc_fill(struct ttm_pool *pool, enum ttm_caching tt_caching,
> > 			   struct ttm_pool_prealloc *pp, unsigned int count);
> > +int ttm_pool_prealloc_fill_full(struct ttm_pool *pool,
> > +				enum ttm_caching tt_caching,
> > +				struct ttm_pool_prealloc *pp,
> > +				unsigned int num_pages,
> > +				bool beneficial_reclaim_backoff);
> > void ttm_pool_prealloc_fini(struct ttm_pool *pool,
> > 			    struct ttm_pool_prealloc *pp);
> > unsigned int ttm_pool_prealloc_order(struct ttm_pool *pool);
> > -- 
> > 2.34.1
> > 
