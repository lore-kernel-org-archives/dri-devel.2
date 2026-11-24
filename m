Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79491606A333
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 21:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CL1hRLa8;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=S5hrbEh2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E256C10E840;
	Tue, 24 Nov 2026 21:01:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C68210E57C;
 Tue, 24 Nov 2026 21:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795554106; x=1827090106;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=D8vgPpA09LJ2R0/qv8NBfpuKlEdYRemt83E8sFvlKD4=;
 b=CL1hRLa8rWC92UyO8/HyMQNYF7GPf0q/0Z52m9wx6lwBlH4vVN2I7fv1
 YpWz8XzYfIcujdmEEkSw5SLmXgr2g+o3CnpKQGWxgMKKj5JND3vSj5r7M
 d0ONazE70qOOBh7uIv8NCrG4CkWzDoL4EYPR0qipF3QjoVYPA4LhPXvPR
 0myMWTXy5SbvQZD66S+oxvuVGQlYyOwWuXHNEoHKNKoAiNXszbDGmPiFl
 Sy5msFdLGrz3dfzkCPzgOo1Sdn0xhYoPZV6jz2+JCk0zk7/21VZT3Tx7J
 hC9AC64QiWuyxnm8IAjela7tjWUyu4/gq520swy+2CHqMPG42za/AdgRf Q==;
X-CSE-ConnectionGUID: kcbJXgLkSA6jSdY8XV1ybg==
X-CSE-MsgGUID: w9ftPpYlQ8m9TngiiFbJiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4470666"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4470666"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 13:01:45 -0800
X-CSE-ConnectionGUID: 21ObRtKTSkqVfCAj4DCR6g==
X-CSE-MsgGUID: MeAY+bEySO2RIq6mevJvmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; d="scan'208";a="11658254"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 13:01:44 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 13:01:43 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 13:01:43 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.32) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 13:01:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DY9xPiOzwXCsYc/uu2j80ZrkIBcYRea9uvLB2QM6qKwzXegovS1t/Wov69bmxYMf21YZKCoywb5ASIGbKD+p0hucTbp3U6z8f8pnk8gHYc3Te31j+5QUQ5Cw5bI6j5JJIcoxP9QqSXHeUgeEUWPkK+yJw47qoEqmn1Z8ord+oJc/mK1bWP2VK6AGL1PKzq9/RG+TZ9D62Tln87eI+Y4yydyutlRk2dKC+bqcd2UTdHXine2FDo1yt9wIdn5YirG6O6GIndI5UXjloOk63NgAp2jx4uWeDCr878VReRttLEytcmwHBNMR4EVBxcAlT1tbclHi40F8JYLdoTrSqmyBuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3nlLV8pUTlJeI4Ky0CHPJva03ucb3vt5+oK+KaefY8=;
 b=e5ELigGjozNQvm3VPGzQis0m9tqiay/c9KCChgrSvcMX/WTf8Cit/KT+R7H9cgVEAzOliI5p/JoaGeyIU8+pv2RzctBT6sUXDzdnG+UbP/q5P+gPOcomGZjFqGJEYzU7WQNDawH4qTdaWHeeiHMez8TOEmAUeiAE08UsLZrPXKvq86TFDL3J9bVLGlKI5C5ahxg+q67A/pc6uCPlR4g/07R8ax2z0FOKPYw0HjmM3tIJeO/+izz3hV4yS6QJCJ584zuMGAlKPRok8iq7hAZY/YyYRK+QHdITmDJo5vy0X+jhUYSoOfQ+FwcsBJnVCTcKAaEw7SBdRTWbt4WSV4Vt5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3nlLV8pUTlJeI4Ky0CHPJva03ucb3vt5+oK+KaefY8=;
 b=S5hrbEh2n0u7KKZpRdWFZw+cApDtNikKC8FSm2wunpnNGmd2S44zBZsa+OLKfZq2gsOuLU+4HEqmrWgv3GXai8xRfZpyGR6+kn3Y7L34yVLINFuSroXxEny4Z4TnRh0zcwJh1O3HNMWy1PeJGUMX17Tou/++kpPQpXjFDLRUyeA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by PH3PPFC80959CE8.namprd11.prod.outlook.com (2603:10b6:518:1::d4b)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 21:00:06 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 21:00:06 +0000
Date: Tue, 24 Nov 2026 13:00:03 -0800
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
Subject: Re: [PATCH v3 30/33] drm/xe: Add packed copy-step IOVA mapping for
 defrag
Message-ID: <awX60/7VXfIXRgUV@gsse-cloud1.jf.intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-31-matthew.brost@intel.com>
 <ave-9FuepY6oCWzW@nvishwa1-desk>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ave-9FuepY6oCWzW@nvishwa1-desk>
X-ClientProxiedBy: SJ0PR03CA0044.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::19) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|PH3PPFC80959CE8:EE_
X-MS-Office365-Filtering-Correlation-Id: c9cfcbc2-a643-4f25-9339-08df4a6deaa4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|23010399003|6133799003|261009223027099003|18002099003|22082099003|3023799007|261022075727099003|261028144727099003|261022105027099003|261102123227099003|261026121527099003|261026140227099003|261021121427099003|56012099006|10067099003|5023799004|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: OLTuKDSSuab5xYPWIItXK6OOVNmHsHVPEpCduObOboe/1FIfsbWKHzVdRCSrwlu9NaBtMsv6cc7LhpXx8YTSB9ObpZvhG5ECLojoNUa4BvC3XqMLBSgcN75CAEJGHA4ChRii8JzIWUvmTrvryAhJBh+BDjf+Mq5YdwE10pC/dWbiDApAZj6US11DWLNstVdI7O7/i8e9pROB4NseQpds8E8V9jOE5kXuDJUdBklfR5eYoVmqy2e4Uqw8RfISgt/jA8ryKeV3HTI+jg1iEWTi075zMiUqjzwfUJmm+l18x9MOqknohlm0IUl0Za1uk7u7YXmHn7lEbQPI/CwyJK4QUH4p69LGHujkCACHtwdTuy8C9qecHWVPcOsC5JvI/HYbAStz5Q6pg4DcLCOv5czDnF93Sv2GOHnUjh+XDijT5ZbspK9l63+VF1e44N4ghwhVgS/YZHvsTx9ys9fmYgZQTaNJc9PPxeP0OV4VihlH0d4wwzaOa+KFJfBuUtMilLNl3eGYLINI1gRZ4+0RnHwTDuDkN6a+hX67Buko3zVXSIdlAiA7I6QFPjRLaLpv4YeBWwt/qwAu9P4U9/qY+voIGBQlJGoCE7TUcQqnpNcC4PoHvcPylCH/r+SF5+jXNn+aTbRv9xZGIffGFk0o3R+cVNfHB0q4iVYGqILXZxIXTlQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(6133799003)(261009223027099003)(18002099003)(22082099003)(3023799007)(261022075727099003)(261028144727099003)(261022105027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261021121427099003)(56012099006)(10067099003)(5023799004)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?T7xhGax7wpBJhmZ4Q7zL6/YQDlzloK98OYT49hsSDTiEyAzmMcLD0nTgHw?=
 =?iso-8859-1?Q?+/PXJ+KhWmq9Q1WdmWReZUqnnRLQaBvXAHqUTXbwyd+xgUnTaLQLJM8UR3?=
 =?iso-8859-1?Q?ErNrnxxuM6+bjG9r1XBa4VnRYtNhMgo6XeyxOvVZSsFT35HEIFLrvw1yar?=
 =?iso-8859-1?Q?p9skk9e5OQhUD0iYUFSPbD3JyTsnlxTzsND3ZlK7xwORMthdylYUBU9AV4?=
 =?iso-8859-1?Q?of2pgCXMbKT74gLghzOP70mVspj6pdcDVwQHw0yHiTyqk53jwBWb3hctyv?=
 =?iso-8859-1?Q?y0ln3PMYaTPr5AUUnCG0EFaBsTwYJG/TbhKwYjTplyHWjLIDr729dIylTe?=
 =?iso-8859-1?Q?A1UYHZfKuVqXc4lbz3WmL9vLlZF59f8pEGYzUpTar11xZ4Nubjye3pUKVI?=
 =?iso-8859-1?Q?+1BozJxY6H1M06mZFIF7x2Dmd3WibEzcotSLYx8ORFNgvwHSTzHGYK5Kv5?=
 =?iso-8859-1?Q?8K42OIEta9HP0+vzxnW89K7ZY9FjqW/SVMGoeF14VGBR5HW47cBUUnz3sP?=
 =?iso-8859-1?Q?/TLGJ0r2ElIJ1/IIsoN8jXQ1M80DkYiH3H3PBbROgdJuftgB4OUIMqea7F?=
 =?iso-8859-1?Q?4umCudJP3zuDcgAaRspt+tT+fEdSFQ7+sNptaPAlkcQXX1uEb2mOqTn4Uv?=
 =?iso-8859-1?Q?9e7cM9z15cSrFIuAa1Tm6f45CsNPo/8i6XDU6mugsinuF7zIWaaEwj/qww?=
 =?iso-8859-1?Q?y5oqhlK1TuWkVqHXQR35OqknElECnImdPxqpQWo86kYNyNv0ega+CM76iY?=
 =?iso-8859-1?Q?eqGWXy0XjD2xpPoIGr1iiI1Za1FeYI1RoMpWMUjE9/BkYocXxU3powpzzg?=
 =?iso-8859-1?Q?E07/C/BO+nIObQmGGkybtQ9+r0JAi9A82pcXvqitgZpKn6RYVfSzJR1jFY?=
 =?iso-8859-1?Q?1B3QiXo/etxbO7mHnIvLBIIJfVZwrc5gy2FrX3JKeqeK+BEeYd7xOr4Gqb?=
 =?iso-8859-1?Q?0NZl58N6iEfgdGM16pgLxUiPtT2S81KmXI63fCy6jUYveNJCqelHHZHR9z?=
 =?iso-8859-1?Q?iEwok/1VooYEeMEKCm6xTY83XnZbxBg9geg1tU9cY/IwLXia9OKHBOMbc6?=
 =?iso-8859-1?Q?Kx6iYsVLCVY2EcI23spT8wLjva1In2SP5L2JqHDa/heUXUd3ztYboMoVY5?=
 =?iso-8859-1?Q?LtKApNsr2I4Nwsw6jwXBGdkegwAv6FvQIwhJ+QGgC8rWmAsFaOMPbLwWTi?=
 =?iso-8859-1?Q?GIQlziUKdAqDZ2jmuFcSihIok5TgtrZsuNPUvGm/6skk8twujslBj6gLc1?=
 =?iso-8859-1?Q?+aSzmMVH3zpnc4QcEsuKko1pkhZjxDGVjZ3HnuuHgXlWv//o+ZF6lpbcQI?=
 =?iso-8859-1?Q?KnZomnpQfu7O6EWsS3YE9+Pfnw8Vug7z8LHYPpq3H+h15HEdt8M7jSfuRg?=
 =?iso-8859-1?Q?Jhegt4dzUqB2324DGBMJKXS64Omd/ZC4DaUyhUXNVqbpdDWRbLWpfCir/E?=
 =?iso-8859-1?Q?hI65NeO9s81EN701mqjLB7xyNW8b72mPWGCN49QcaDc1QSLaiuavEpLr4G?=
 =?iso-8859-1?Q?oqKHmjogCv/6FCK4UETjLHM9mVEe5lXlVawmtZrQLyi9hQP3CyVg0vEc1E?=
 =?iso-8859-1?Q?CNBP+0zl+8Y8qwGbhsMRHydzVOU5Bpt+jyVN8t8zXxuOLcRw9MQjcE3qyg?=
 =?iso-8859-1?Q?ch8nq7Ki2J30s3CpQQbTcGnpEORgM3ul0Tth1KSBhln+hrLPlnLNmFuctL?=
 =?iso-8859-1?Q?ej+tefBFKt0mDm8mQ5QAlKdjMLNb4mP8RytcetlGqWPrqkJv8Mw6gHpHaT?=
 =?iso-8859-1?Q?KIR8VgAfUuRGHRFqeOc7CC3M6X67zYjvjOHTf/1eu6PWj2shQ0WpT6Cho5?=
 =?iso-8859-1?Q?YBnVLH6AhmAzSxDJw6WIZGKK6icvQSE=3D?=
X-Exchange-RoutingPolicyChecked: M3M70wAdPyEhmbqvY/0/YQi9Kec/VHvp/EdMeLwDiye9TtFQrXOrETXpdw3Rms/QdLNGBo7NLIoRbAjvl+nVL8j0TGaly8aAed8vr5EafNaz0fG0Q7We/ibWdZrGf47/5Qpt0Yq4256uxahKWsAByIaMCBgq30BXgL9aDdvk43HwfXPGFWk4MUUxQx4fV7h9/gEAsdbBLvwoyXo7SNzuxLD7FNC+RrV8+yhJV+tIVpo9MM0D3e6YszVMhddnOuqoOCnV0S7kWklefU/GxAqbdAtqJxUNLHfb1tRnkIiHnXn9lTsbc01kBOWqCw80xmWZHNYpkvmz87MuFKLUBZJJbA==
X-MS-Exchange-CrossTenant-Network-Message-Id: c9cfcbc2-a643-4f25-9339-08df4a6deaa4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 21:00:05.9739 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AyXQcYpmOgVXxQstQsNPWPkqV5rfJInK+hjZB8HowYvmkF6tXgEwt0dhIiuMiy3vtW4c3G1Vxa1Jb7yYTj2ZeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFC80959CE8
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

On Fri, Nov 13, 2026 at 05:52:52PM -0800, Niranjana Vishwanathapura wrote:
> On Fri, Jul 10, 2026 at 07:56:16PM -0700, Matthew Brost wrote:
> > Add machinery to map only changed pages during defrag when the
> > destination TT is IOVA-mapped. Only the non-borrowed (freshly
> > allocated) pages need copying; borrowed pages are aliases from
> > the old TT.
> > 
> > Add xe_tt_iova_copy_init() to diff new vs old TT folios and
> > record changed-page runs. Add xe_tt_map_iova_copy() to link
> > those changed pages packed contiguously at the front of the
> > new TT's IOVA reservation, synced and ready for GPU blits.
> > 
> > No users yet; wired up in later patches.
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
> > drivers/gpu/drm/xe/xe_bo.c | 364 +++++++++++++++++++++++++++++++++++++
> > 1 file changed, 364 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> > index c5022c16411f..c087f17ad6db 100644
> > --- a/drivers/gpu/drm/xe/xe_bo.c
> > +++ b/drivers/gpu/drm/xe/xe_bo.c
> > @@ -531,6 +531,31 @@ static void xe_tt_unaccount_iova(struct xe_device *xe,
> > 		}
> > 	}
> > }
> > +
> > +/*
> > + * xe_tt_account_iova_pages - account a tt's pages from a full folio walk
> > + * @xe: the xe device
> > + * @xe_tt: the xe_ttm_tt to account (its @iova_dma_pages must start zeroed)
> > + *
> > + * Walk @xe_tt's pages one folio at a time (the same head-page order walk used
> > + * by xe_tt_map_iova()) and account each into xe->mem.dma_mapped_pages[] and
> > + * @xe_tt->iova_dma_pages[]. Used to (re)derive accounting that exactly matches
> > + * the pages a tt is actually mapped with.
> > + */
> > +__maybe_unused
> 
> Assisted-by: LLM
> 
> NIT..I see may __maybe_unused added here and removed in patch 32.
> Maybe we can avoid adding them here to minimize the changes.
> 

It won't compile without __maybe_unused without patch 32.

Generally you want every single patch in a series to compile, thus
__maybe_unused is used here.

> > +static void xe_tt_account_iova_pages(struct xe_device *xe,
> > +				     struct xe_ttm_tt *xe_tt)
> > +{
> > +	struct ttm_tt *tt = &xe_tt->ttm;
> > +	unsigned long i = 0;
> > +
> > +	while (i < tt->num_pages) {
> > +		unsigned int order = ttm_pool_page_order_nodma(tt->pages[i]);
> > +
> > +		xe_tt_account_iova_add(xe, xe_tt, order);
> > +		i += 1UL << order;
> > +	}
> > +}
> > #else
> > static void xe_tt_account_iova_add(struct xe_device *xe,
> > 				   struct xe_ttm_tt *xe_tt, unsigned int order)
> > @@ -541,6 +566,12 @@ static void xe_tt_unaccount_iova(struct xe_device *xe,
> > 				 struct xe_ttm_tt *xe_tt)
> > {
> > }
> > +
> > +__maybe_unused
> > +static void xe_tt_account_iova_pages(struct xe_device *xe,
> > +				     struct xe_ttm_tt *xe_tt)
> > +{
> > +}
> > #endif
> > 
> > static int xe_tt_map_sg(struct xe_device *xe, struct ttm_tt *tt)
> > @@ -714,6 +745,339 @@ void xe_res_first_tt(struct ttm_tt *tt, u64 start, u64 size,
> > 		xe_res_first_sg(xe_tt->sg, start, size, cur);
> > }
> > 
> > +/**
> > + * struct xe_tt_iova_run - A contiguous run of changed pages in a defrag move
> > + * @start: First page offset (natural ttm_tt index) of the run.
> > + * @count: Number of pages in the run.
> > + *
> > + * Runs are folio aligned: defrag borrows whole beneficial-order chunks, so a
> > + * folio is either entirely borrowed (unchanged) or entirely freshly allocated
> > + * (changed), never split across the boundary.
> > + */
> > +struct xe_tt_iova_run {
> > +	pgoff_t start;
> > +	pgoff_t count;
> > +};
> > +
> > +/**
> > + * struct xe_tt_iova_link - A snapshot folio link descriptor for defrag relink
> > + * @phys: Physical address of the folio's head page.
> > + * @offset: Natural byte offset into the reservation to link the folio at.
> > + * @len: Byte length of the folio (PAGE_SIZE << order).
> > + *
> > + * Captured at copy-init time while the destination tt's page array is valid and
> > + * stable under the BO lock. The post-copy finalize job runs asynchronously,
> > + * after TTM may have mutated (or torn down) the destination tt page array, so
> > + * it relinks purely from these snapshots and never dereferences that array.
> > + */
> > +struct xe_tt_iova_link {
> > +	phys_addr_t phys;
> > +	size_t offset;
> > +	size_t len;
> > +};
> > +
> > +/**
> > + * struct xe_tt_iova_copy - Changed-page subset of an IOVA defrag move
> > + * @runs: Array of changed-page runs, in ascending natural tt offset.
> > + * @nr_runs: Number of entries in @runs.
> > + * @links: Per-folio link snapshots covering the changed runs, in ascending
> > + *         natural offset. Drives the asynchronous finalize relink so it never
> > + *         touches the destination tt's (possibly mutated) page array.
> > + * @nr_links: Number of entries in @links.
> > + * @nr_changed: Total number of changed pages (sum of the run counts). This is
> > + *              also the size, in pages, of the packed copy-step IOVA mapping
> > + *              produced by xe_tt_map_iova_copy().
> > + */
> > +struct xe_tt_iova_copy {
> > +	struct xe_tt_iova_run *runs;
> > +	unsigned int nr_runs;
> > +	struct xe_tt_iova_link *links;
> > +	unsigned int nr_links;
> > +	pgoff_t nr_changed;
> > +};
> > +
> > +/*
> > + * xe_tt_iova_walk_changed - Walk a defrag move's changed-page runs.
> > + *
> > + * Iterate @new_tt one folio at a time (folio order read from TTM via
> > + * ttm_pool_page_order_nodma()) and compare each folio's head page against
> > + * @old_tt at the same natural offset. Pages the new backing borrowed from the
> > + * old tt alias the same struct page and are unchanged; freshly allocated pages
> > + * differ. Coalesce contiguous changed folios into runs and, for each run,
> > + * invoke @fn. Returns the total number of changed pages.
> > + */
> > +__maybe_unused
> > +static pgoff_t xe_tt_iova_walk_changed(struct ttm_tt *new_tt,
> > +				       struct ttm_tt *old_tt,
> > +				       void (*fn)(pgoff_t start, pgoff_t count,
> > +						  void *arg),
> > +				       void *arg)
> > +{
> > +	pgoff_t i = 0, n = new_tt->num_pages;
> > +	pgoff_t run_start = 0, nr_changed = 0;
> > +	bool in_run = false;
> > +
> > +	while (i < n) {
> > +		unsigned int order = ttm_pool_page_order_nodma(new_tt->pages[i]);
> > +		pgoff_t nr = 1UL << order;
> > +		bool changed = new_tt->pages[i] != old_tt->pages[i];
> > +
> 
> NIT..I am seeing here and in other places, code implies
> "new chunk = union of whole old chunks"
> (new chunk never replaces part of old chunk).
> But this seems implied and I am not not sure if there is any
> single place where we ensure that and document it.
> 

I'm not really sure what you are suggesting here.

Matt

> Niranjana
> 
> > +		if (changed) {
> > +			if (!in_run) {
> > +				run_start = i;
> > +				in_run = true;
> > +			}
> > +			nr_changed += nr;
> > +		} else if (in_run) {
> > +			if (fn)
> > +				fn(run_start, i - run_start, arg);
> > +			in_run = false;
> > +		}
> > +
> > +		i += nr;
> > +	}
> > +
> > +	if (in_run && fn)
> > +		fn(run_start, n - run_start, arg);
> > +
> > +	return nr_changed;
> > +}
> > +
> > +struct xe_tt_iova_run_collect {
> > +	struct ttm_tt *new_tt;
> > +	struct xe_tt_iova_run *runs;
> > +	unsigned int nr_runs;
> > +	unsigned int runs_cap;
> > +	struct xe_tt_iova_link *links;
> > +	unsigned int nr_links;
> > +	unsigned int links_cap;
> > +	int err;
> > +};
> > +
> > +/* Geometrically grow @arr (element size @elem) to hold at least @need slots. */
> > +__maybe_unused
> > +static int xe_tt_iova_grow(void **arr, unsigned int *cap, unsigned int need,
> > +			   size_t elem)
> > +{
> > +	unsigned int new_cap;
> > +	void *p;
> > +
> > +	if (need <= *cap)
> > +		return 0;
> > +
> > +	new_cap = *cap ? *cap * 2 : 64;
> > +	if (new_cap < need)
> > +		new_cap = need;
> > +
> > +	p = krealloc_array(*arr, new_cap, elem, GFP_KERNEL);
> > +	if (!p)
> > +		return -ENOMEM;
> > +
> > +	*arr = p;
> > +	*cap = new_cap;
> > +	return 0;
> > +}
> > +
> > +__maybe_unused
> > +static void xe_tt_iova_store_run(pgoff_t start, pgoff_t count, void *arg)
> > +{
> > +	struct xe_tt_iova_run_collect *c = arg;
> > +	pgoff_t i = start, end = start + count;
> > +
> > +	if (c->err)
> > +		return;
> > +
> > +	if (xe_tt_iova_grow((void **)&c->runs, &c->runs_cap, c->nr_runs + 1,
> > +			    sizeof(*c->runs))) {
> > +		c->err = -ENOMEM;
> > +		return;
> > +	}
> > +	c->runs[c->nr_runs].start = start;
> > +	c->runs[c->nr_runs].count = count;
> > +	c->nr_runs++;
> > +
> > +	while (i < end) {
> > +		struct page *page = c->new_tt->pages[i];
> > +		unsigned int order = ttm_pool_page_order_nodma(page);
> > +
> > +		if (xe_tt_iova_grow((void **)&c->links, &c->links_cap,
> > +				    c->nr_links + 1, sizeof(*c->links))) {
> > +			c->err = -ENOMEM;
> > +			return;
> > +		}
> > +		c->links[c->nr_links].phys = page_to_phys(page);
> > +		c->links[c->nr_links].offset = (size_t)i << PAGE_SHIFT;
> > +		c->links[c->nr_links].len = PAGE_SIZE << order;
> > +		c->nr_links++;
> > +
> > +		i += 1UL << order;
> > +	}
> > +}
> > +
> > +/**
> > + * xe_tt_iova_copy_init() - Compute the changed-page subset of a defrag move
> > + * @new_tt: The freshly (re)allocated destination tt.
> > + * @old_tt: The stashed source tt (bo->defrag_old_tt).
> > + * @copy: Output description of the changed pages.
> > + *
> > + * Diff @new_tt against @old_tt and record the runs of changed (non-borrowed)
> > + * pages into @copy, along with a per-folio snapshot of their physical
> > + * addresses, natural offsets and lengths. The result drives both the packed
> > + * copy-step IOVA mapping (xe_tt_map_iova_copy()) and the post-copy finalize
> > + * that relinks the new backing into the IOVA reservation. The finalize runs
> > + * asynchronously, after TTM may have mutated @new_tt->pages, so it consumes the
> > + * snapshot rather than re-reading the page array. @new_tt and @old_tt must
> > + * describe the same BO (equal num_pages) and both be populated.
> > + *
> > + * The caller owns @copy and must release it with xe_tt_iova_copy_fini().
> > + *
> > + * Return: 0 on success, -ENOMEM on allocation failure.
> > + */
> > +__maybe_unused
> > +static int xe_tt_iova_copy_init(struct ttm_tt *new_tt, struct ttm_tt *old_tt,
> > +				struct xe_tt_iova_copy *copy)
> > +{
> > +	struct xe_tt_iova_run_collect c = { .new_tt = new_tt };
> > +
> > +	memset(copy, 0, sizeof(*copy));
> > +
> > +	/*
> > +	 * Single pass: collect the changed runs and per-folio link snapshots
> > +	 * directly, growing the arrays on demand. Changed runs are few (the
> > +	 * borrowed majority is skipped), so the geometric reallocs are rare and
> > +	 * this avoids a second full O(num_pages) walk just to size the arrays.
> > +	 */
> > +	copy->nr_changed = xe_tt_iova_walk_changed(new_tt, old_tt,
> > +						   xe_tt_iova_store_run, &c);
> > +	if (c.err) {
> > +		kfree(c.runs);
> > +		kfree(c.links);
> > +		return c.err;
> > +	}
> > +	if (!c.nr_runs)
> > +		return 0;
> > +
> > +	copy->runs = c.runs;
> > +	copy->nr_runs = c.nr_runs;
> > +	copy->links = c.links;
> > +	copy->nr_links = c.nr_links;
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * xe_tt_iova_copy_fini() - Release a struct xe_tt_iova_copy
> > + * @copy: The copy description to release.
> > + */
> > +__maybe_unused
> > +static void xe_tt_iova_copy_fini(struct xe_tt_iova_copy *copy)
> > +{
> > +	kfree(copy->runs);
> > +	kfree(copy->links);
> > +	copy->runs = NULL;
> > +	copy->links = NULL;
> > +	copy->nr_runs = 0;
> > +	copy->nr_links = 0;
> > +	copy->nr_changed = 0;
> > +}
> > +
> > +/**
> > + * xe_tt_map_iova_copy() - DMA map the changed-page subset for a defrag copy
> > + * @xe: The xe device.
> > + * @new_tt: The destination tt (must be IOVA eligible, use_iova == true).
> > + * @copy: The changed-page description from xe_tt_iova_copy_init().
> > + *
> > + * Link only the changed pages of @new_tt into its IOVA reservation, packed
> > + * contiguously at the front of the range ([0, @copy->nr_changed) pages). This
> > + * provides a compact, contiguous destination for the GPU defrag copy without
> > + * mapping the (majority) borrowed pages, and lets the whole temporary mapping
> > + * later be torn down with a single dma_iova_destroy().
> > + *
> > + * The reservation's remaining tail is left unlinked. This does not establish
> > + * the tt's final mapping (@iova_linked stays false); the post-copy finalize is
> > + * responsible for that.
> > + *
> > + * Return: 0 on success, negative error code on failure (any partial linkage is
> > + * unwound).
> > + */
> > +__maybe_unused
> > +static int xe_tt_map_iova_copy(struct xe_device *xe, struct ttm_tt *new_tt,
> > +			       const struct xe_tt_iova_copy *copy)
> > +{
> > +	struct xe_ttm_tt *xe_tt = container_of(new_tt, struct xe_ttm_tt, ttm);
> > +	struct device *dev = xe->drm.dev;
> > +	size_t mapped = 0;
> > +	unsigned int r;
> > +	int ret;
> > +
> > +	xe_assert(xe, xe_tt->use_iova);
> > +	xe_assert(xe, !xe_tt->iova_linked);
> > +
> > +	for (r = 0; r < copy->nr_runs; r++) {
> > +		pgoff_t i = copy->runs[r].start;
> > +		pgoff_t end = i + copy->runs[r].count;
> > +
> > +		while (i < end) {
> > +			struct page *page = new_tt->pages[i];
> > +			unsigned int order = ttm_pool_page_order_nodma(page);
> > +			size_t len = PAGE_SIZE << order;
> > +
> > +			ret = dma_iova_link(dev, &xe_tt->iova,
> > +					    page_to_phys(page), mapped, len,
> > +					    DMA_BIDIRECTIONAL,
> > +					    DMA_ATTR_SKIP_CPU_SYNC);
> > +			if (ret)
> > +				goto err_unlink;
> > +
> > +			mapped += len;
> > +			i += 1UL << order;
> > +		}
> > +	}
> > +
> > +	ret = dma_iova_sync(dev, &xe_tt->iova, 0, mapped);
> > +	if (ret)
> > +		goto err_unlink;
> > +
> > +	return 0;
> > +
> > +err_unlink:
> > +	if (mapped)
> > +		dma_iova_unlink(dev, &xe_tt->iova, 0, mapped,
> > +				DMA_BIDIRECTIONAL, DMA_ATTR_SKIP_CPU_SYNC);
> > +	return ret;
> > +}
> > +
> > +/*
> > + * xe_tt_iova_transfer - Transfer a full IOVA reservation old_tt -> new_tt.
> > + *
> > + * Move the (fully linked) IOVA reservation from the old tt to the new tt,
> > + * leaving the old tt without a reservation so its destroy path does not double
> > + * free. The new tt keeps its existing reservation snapshotted in the finalize
> > + * job for teardown. Called at the defrag finalize job's point of no failure.
> > + *
> > + * Also rebalance the per-order DMA-page accounting: drop the old tt's
> > + * accounting and account the pages the new tt actually ends up mapped with.
> > + * The finalize relink leaves the new tt's mapping equal to new_tt->pages
> > + * (borrowed pages alias the old tt; changed runs use the new pages, which may
> > + * have a different order distribution), so deriving the accounting from a full
> > + * folio walk of the new tt keeps xe->mem.dma_mapped_pages[] exact while the new
> > + * mapping lives, rather than carrying the old tt's stale distribution.
> > + */
> > +__maybe_unused
> > +static void xe_tt_iova_transfer(struct xe_device *xe,
> > +				struct xe_ttm_tt *new_tt,
> > +				struct xe_ttm_tt *old_tt)
> > +{
> > +	new_tt->iova = old_tt->iova;
> > +	new_tt->iova_linked = true;
> > +
> > +	xe_tt_unaccount_iova(xe, old_tt);
> > +	xe_tt_account_iova_pages(xe, new_tt);
> > +
> > +	old_tt->iova_linked = false;
> > +	old_tt->use_iova = false;
> > +}
> > +
> > /*
> >  * Account ttm pages against the device shrinker's shrinkable and
> >  * purgeable counts.
> > -- 
> > 2.34.1
> > 
