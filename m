Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DF8606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 18:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jzZjP1Rt;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=E8hLzF0F
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40DCA10F091;
	Thu, 19 Nov 2026 18:47:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C16710F091;
 Thu, 19 Nov 2026 18:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795114057; x=1826650057;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=U4PMJ0WH76q8L43E2wB9nMJ1xLpdrZkyjZ7OM6WToH0=;
 b=jzZjP1RtBYKUKp3oZxTUv6NKY+h1Sr1EGESa7hSfV2R6unm8NPo761uy
 n1EW9/jbLLd28NusqMar3h9nUr6pBZj6s3Ew8/fNGC9KlB2G/4dgSNhTy
 E1oG/aseG+nt6mLt62QFxacdoa0pHBCLlrKoEr3jHKPl9q6CUt86fqhzI
 8k+ndxbaOWqlrQBMJCxKH1cu4ATe7N41yoIepR7OulE7G55cBywFeTdvo
 HN2jM9IgtatMwHeoD88buh0jlINwxxoHKDuoxM1RPjSCDJ5Kt51hy3kqy
 ZqjLMuAJQr3MW/7rLJn46V8tStChFEdI9e6P/2YeSPffKCfweB0VDBw+s Q==;
X-CSE-ConnectionGUID: DNiAEiqoQxidwdZ9d2jHAw==
X-CSE-MsgGUID: 5EZNc9/YRliNlmavfZo1GA==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3863920"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3863920"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 10:47:35 -0800
X-CSE-ConnectionGUID: W8euPgWuSxKHZSgoPyzEkQ==
X-CSE-MsgGUID: +mi1eRzaRROwz2/mXBGimw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; d="scan'208";a="12482379"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 10:47:35 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 10:47:34 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 19 Nov 2026 10:47:34 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.24) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 10:47:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmRJMShcCWCPHsnU+rEqatH6KsnkR88h9gTZVct1Nf974PhNSGc0g5b1YbpGmmSwNn9QUES1RxRto1lMCRsNhtTnav6soLdEDiS3bcpZh/4DYJclL7mO4KBYyEKtU7kxUk0mbFRFk9VF7ubeYQ0WjQeA8u+D5p3DX/gZCxaf68j9EUXdvfTbraTeQ+1vdVz2bhUk9EMPePWeZ3pVVsbK61Qo08z4Ozzc5hS+btR+R1wfgi0QWyEmIifNsw5TBbkRiY7GU9Rg0il5oEXp9a62MaEOgK2yK8OV+BoTvbobwnOcTjRrlnixKX4cz7BMxvBp5toCxhTVj/Ax9IG4I2Kwig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vul0QODBTj1sciLJ+CkcKq14k96wgNj1FLrcDNHFmZ0=;
 b=dR8cZ80Ck1HllwTuqpLqraxC+7EPFrRvwEGtgEs334t/+EVgGZh6LIjpvXR00wSgFkJKiQvMpVzwPcIZBDgMsqCdpM6zc0m019so3DQ3XEOhEemMLt+PlGUhBa1jl98ZN0Q2g+p5SebUQ9Gg6qr8Nyal+CAeT/1rYqtGc4/s6JDBgS32y7FlC7ZrtkQpDWSabdL+jxSrNkONeV9kuynrwjhspeEOxsfPAq5WCSYqloJTCwj0cYgMKvDMMje832ZYUdC+0WxN1D8Z4SCghy7WsBE+Nfb6XwGqhDxQab3dylaPU1xDR7dSa16p4D+7rJnIEKWVkQ+foF7lHXVE9IQdeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vul0QODBTj1sciLJ+CkcKq14k96wgNj1FLrcDNHFmZ0=;
 b=E8hLzF0FDSxw7bTxEeVlnPf2ASFP/JINMadhd7y/RfE3J5c8KCrb3DlNd3S7tWRucJhRDljK1T4iaf0+trXIf7WU1gTE9aH9C3xmEgyWOVn0C4ffvYik1T1dqzSYjFvvQVCIjBcv5M2w4IQlHHqoQZHPsh6Wa79ramPM0VtUWL0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by SA3PR11MB066336.namprd11.prod.outlook.com (2603:10b6:806:588::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 18:47:16 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 18:47:16 +0000
Date: Thu, 19 Nov 2026 10:47:13 -0800
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
Subject: Re: [PATCH v3 01/33] drm/ttm/pool: Allow backing off reclaim at the
 beneficial order
Message-ID: <av9EMVS6dyUu18aW@gsse-cloud1.jf.intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-2-matthew.brost@intel.com>
 <au1Bu_sIxwAzxJkc@nvishwa1-desk>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <au1Bu_sIxwAzxJkc@nvishwa1-desk>
X-ClientProxiedBy: MW4PR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:303:8e::9) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|SA3PR11MB066336:EE_
X-MS-Office365-Filtering-Correlation-Id: ebe6894e-2ac5-4b4b-3b4e-08df466d8801
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7416014|23010399003|261026121527099003|10067099003|261026140227099003|261021123027099003|4143699003|56012099006|11063799006|261022105027099003|261028144727099003|261102123227099003|261021121427099003|261009223327099003|261009221227099003|261009221727099003|22082099003|18002099003|261009220027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: aRNLUZy20Mv+P1lZnE1rZeSwDYe6L5xb2XjRIQL3febA7tFi93pvMnQKNcNBkfdtUXiQyoP03f9Yu6WQ/IhE8KX7vIKvLHuAMfDY+e8mFkltSwMoA7ijzEErkuzjIhh2rmM3FbcGZ98ZICP7t2ZGRNV/Uce5eqel6caZUxzihjNXeKKbQILIbCOTZh66mHEL84HHiVB6CfVoHFnkGsKc9mQi5fP8hgj/nJJlv9+bQ3mnqziTpzt3PEIOqcR7gv768JH9167koqMhMqrwbHflNNNGEVJIGm8yvbsJj4F0M/bxT0k2cU454IlfC5BYsn9+9nEIsnZpN1vyhJcf1rdvenHP8VhvP4fiJFiLde3xijxsOMw6MDhPNaNTOwb0SEvi52bulHABAw4EmfvRBfURVWybnfYr/bXn4v2h+/KePWt8twmKZbKDIHCIOx8UWUX4qGw/oKCD4osl/+vzNHi9lIqHXOv7PBy+r1XtAKTm8LSnf3x87e+pcZp8/emZW4AEZnmbL1OnC2VyTRcoU8iZijFMf+biz412+3+sw5fE7SogGfRVbgx8A4vJu5QPKExyLFj2GTbDRd/FaAcdUN0PJ41O8gusUv2nSzgmKv1gn/YcLJXW5OvIiKSqE1HeIEyrXFG/vF9x8c1vpFRsrM+A0lYuMZBJ18wAZtWLs0Lo2eU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014)(23010399003)(261026121527099003)(10067099003)(261026140227099003)(261021123027099003)(4143699003)(56012099006)(11063799006)(261022105027099003)(261028144727099003)(261102123227099003)(261021121427099003)(261009223327099003)(261009221227099003)(261009221727099003)(22082099003)(18002099003)(261009220027099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?KLg6XbtQ5pk2QFL2xzVar6+o61v/qij8JE/1zXV7nEhzrHAx725TRoC5n1?=
 =?iso-8859-1?Q?3Puo4agRqiAtqPGIamSpUoPtPzTj3qC1Ts7RegCyx92TbTFxEs9LLTIj0K?=
 =?iso-8859-1?Q?5DWjXlLoAhhuKuN2rP0TlYGkXp4gEQamHSA/lXfsXdibkYcei7UUGsGtJ+?=
 =?iso-8859-1?Q?3bJ+hvIi0deQdDGSIvBWjoDDYvRm2t1zwY/OJgOH5xP9lEgty74DtmRdaz?=
 =?iso-8859-1?Q?wARBU4xZeRmasWuEgpCbGQmF4AeG7ouKfDHHhejXnp4Y1KP3MILIsUkeBE?=
 =?iso-8859-1?Q?O3/1ssGEfDQyP+ZQrGy2OZhRktpphJwJ9PwCtzcqa9LdF4MUjSZD78pWoG?=
 =?iso-8859-1?Q?CvfMR+LE/ijbWPNjkVgS9p2yGjrVU/JYFgF8DGIYL/nXYPrDKUMHdCR/k/?=
 =?iso-8859-1?Q?zRrIlXQD10/isPSUikHRI3K60Y0fHsoph6bZEAr+ldw6WomWRRfVK8sD/g?=
 =?iso-8859-1?Q?FyPT9GMVLyAR/m1bklUzEJ7G2ZRJQYosCXp9rfvv4BTnaKYz1FvRMe8DXs?=
 =?iso-8859-1?Q?f55poMmK60sgVYmMavOvAjM1KAHeKlKgkEO1ozfy++/hSVNGuxZn8YyOyH?=
 =?iso-8859-1?Q?XuCzfn9My6lQ5umf9xx6EOJK3VRxsLiZv08G17CEcYo+XyQzyxt9K/0RLV?=
 =?iso-8859-1?Q?EVojphTmbAERfHg3wi1hK1hlZCpATP4e6NubqbfKfl2a349cKqfJR2kavc?=
 =?iso-8859-1?Q?HG0aCWVuEUwkoJK69XT+kI+d/Hf7oRRVAQyvPbmAUZh08J/yXB+2MWXLJi?=
 =?iso-8859-1?Q?seidcmTPaec9uqIQkNPY8To59l4Txy8WM5x5frlk3WSO4wlnpDyTzXtQDf?=
 =?iso-8859-1?Q?16qoLEyffXQBn4QeOJbOazyy2bsUETnjCThpOX0+eg9M+e88BOuEv3+B+C?=
 =?iso-8859-1?Q?PWj6B1roXtNMonOdrp8kioNbjQwJfnlxM6e8F0p7t9MjuzAvr0fnkh0fBF?=
 =?iso-8859-1?Q?2hsOfTaErvry0yXOv/orWRwNIJhFHhLBxTVSbdCuXSqorX5RdagP9oSc7J?=
 =?iso-8859-1?Q?5RXx7G6EldWO6xxvsHsdQssaMtR82mhoeQoTt28FNUTD4qkcJYjo9BSacA?=
 =?iso-8859-1?Q?MCjPL9DazIs9pZruVH/u0P6115QqPHB8vHuAKjn0KOjM4vGvG/OqHPPqTo?=
 =?iso-8859-1?Q?rSr2QV5BVlLC5CR4nEkLVJ4QpnhhldNwK++Zd6k31XmctX+8oqkBFOGh88?=
 =?iso-8859-1?Q?/2wDUw9YSvmchnQktvmk84+Pfo1wsFXjpvZJYi5nvZaZUswg68H/GFk5/T?=
 =?iso-8859-1?Q?o13H/kMI4l9dxLZBvNlF7ditB8fwXTmZZLq4YjaZMOagELB2Y14tB2wH2c?=
 =?iso-8859-1?Q?0VaLfPX5JAaQwwDblt8iKAtZbMgd6jPYYvl2y72O0TF64DrYq7OnUcCj0/?=
 =?iso-8859-1?Q?YKj30XS6imhJq5V7PRLi+fJu7MQY6Ij/ffDBOjPyxyRyqHcJkdXdxvn6yB?=
 =?iso-8859-1?Q?wPgN29V7s6DtHGgYTVMBqZwOL/aif5Xx2Y74YFFCRTVwEansuoUHxHOPHm?=
 =?iso-8859-1?Q?kGyIc+mPWz7BKljnK5KyCY2q5vNdi/4x1XQX+n8/9V461s9nE735yDdIUZ?=
 =?iso-8859-1?Q?NsIDEj2c3BlZiS6ESaFOpCngUDEAla3nxzdiCpz6JipEqJhJwaLu7Nmk7j?=
 =?iso-8859-1?Q?qDfuZbpBIbCtJyKd6u1KQ1H6ydfQ93fjPZNVjGkZaUQISU4CT1KXqHGqz1?=
 =?iso-8859-1?Q?BCpC92dh7RcOXIfY9x1vst9tApP0GNWZeCTOmsagM1AMjoDYYfGlskeTTq?=
 =?iso-8859-1?Q?pKjZIaSfNPnsowNGohOk24l1I63hz6YsX1lJi+5rTwE5vHu73qBgoun9QF?=
 =?iso-8859-1?Q?AcUAY0X8DLrzwk12CgVn+pA64eYGeM8=3D?=
X-Exchange-RoutingPolicyChecked: TlrD0S4UIIhnb/HlHKb3Xw4biInB5KQZr+qyyR3gmWrLtzH04l7+KUNLrFJ6tHS2SYsIzy5OlYAnE9HIjzpKsI7r3NLoiHqAe8XIlNEAmiB5G1LQjEK7kwmX0+5FA24dwUMp4Or1NOLs3XYxP3PKh203O6mu+fX2NhYfyZ5uhFw3vF03FZ6k2Fg86QvAWQq1ixwYozsRzMGW3bmO/Bk43kMU4dkKb812rjcivunMLEIPo2P+pPuU99gl44afgBa6D+jYDJnf0/UFJJaIuzy2Ud2YtplQwpDOrIh2MuETF9B6JqBIPSZyEvtsqAYpLCW383BH6yqtEN7TNi3eY1Ea8Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe6894e-2ac5-4b4b-3b4e-08df466d8801
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 18:47:15.9110 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qn5EHlePEq0OCl5glHdIlwMObRdg7f9eziW5XB2kuCehxuvsVQ09pCMkiPMofbo4Mvj+8KGTPwURnKlqLwRF9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB066336
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

On Thu, Nov 05, 2026 at 06:55:55PM -0800, Niranjana Vishwanathapura wrote:
> On Fri, Jul 10, 2026 at 07:55:47PM -0700, Matthew Brost wrote:
> > Allocating at the pool's beneficial order normally uses
> > __GFP_RETRY_MAYFAIL to push hard for a contiguous high-order page. When
> > beneficial-order allocations have recently been failing, this retry just
> > burns CPU cycles in reclaim/compaction before falling back to a smaller
> > order anyway.
> > 
> > Add a beneficial_reclaim_backoff flag to struct ttm_operation_ctx and
> > plumb it through to ttm_pool_alloc_page(). When set, the beneficial
> > order is treated like the orders we already consider not worth stalling
> > for: __GFP_RECLAIM is cleared so the allocation skips reclaim/compaction
> > entirely, and the __GFP_NORETRY clearing / __GFP_RETRY_MAYFAIL promotion
> > is skipped. Together this makes the allocator back off quickly to a
> > smaller order instead of stalling.
> > 
> > This is a no-op until a caller opts in.
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
> > 
> > ---
> > 
> > v3:
> > - Require a valid beneficial order before backing off reclaim in
> >   ttm_pool_alloc_page() (Sashiko)
> 
> LGTM, though I need to take a deeper look at the patches that use this flag.
> 

If it isn't clear - the end result of this series is all foreground
tasks will set this flag to avoid jank (i.e., no entering reclaim at
higher orders) on the UI and defragmenter in background clears this flag
and does aggresive reclaim pruning in higher order pages iteratively.

Some small tweaks to this algorithm will made in the next rev.

Matt

> Niranjana
> 
> > ---
> > drivers/gpu/drm/ttm/ttm_pool.c | 12 ++++++++----
> > include/drm/ttm/ttm_bo.h       |  7 +++++++
> > 2 files changed, 15 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> > index 3d5f2ae0a456..ab242ad4339e 100644
> > --- a/drivers/gpu/drm/ttm/ttm_pool.c
> > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> > @@ -145,7 +145,8 @@ static int ttm_pool_nid(struct ttm_pool *pool)
> > 
> > /* Allocate pages of size 1 << order with the given gfp_flags */
> > static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
> > -					unsigned int order)
> > +					unsigned int order,
> > +					bool beneficial_reclaim_backoff)
> > {
> > 	const unsigned int beneficial_order = ttm_pool_beneficial_order(pool);
> > 	unsigned long attr = DMA_ATTR_FORCE_CONTIGUOUS;
> > @@ -165,10 +166,12 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
> > 	 * Do not add latency to the allocation path for allocations orders
> > 	 * device tolds us do not bring them additional performance gains.
> > 	 */
> > -	if (order && beneficial_order && order != beneficial_order)
> > +	if (order && beneficial_order &&
> > +	    (beneficial_reclaim_backoff || order != beneficial_order))
> > 		gfp_flags &= ~__GFP_RECLAIM;
> > 
> > -	if (beneficial_order && order == beneficial_order) {
> > +	if (!beneficial_reclaim_backoff &&
> > +	    beneficial_order && order == beneficial_order) {
> > 		gfp_flags &= ~__GFP_NORETRY;
> > 		gfp_flags |= __GFP_RETRY_MAYFAIL;
> > 	}
> > @@ -814,7 +817,8 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> > 		if (!p) {
> > 			page_caching = ttm_cached;
> > 			allow_pools = false;
> > -			p = ttm_pool_alloc_page(pool, gfp_flags, order);
> > +			p = ttm_pool_alloc_page(pool, gfp_flags, order,
> > +						ctx->beneficial_reclaim_backoff);
> > 		}
> > 		/* If that fails, lower the order if possible and retry. */
> > 		if (!p) {
> > diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
> > index 8310bc3d55f9..fd814b5cf535 100644
> > --- a/include/drm/ttm/ttm_bo.h
> > +++ b/include/drm/ttm/ttm_bo.h
> > @@ -187,6 +187,13 @@ struct ttm_operation_ctx {
> > 	 * when multiple BOs share the same reservation object @resv.
> > 	 */
> > 	bool allow_res_evict;
> > +	/**
> > +	 * @beneficial_reclaim_backoff: Back off from direct reclaim at the
> > +	 * pool's beneficial order. Useful when beneficial-order allocation has
> > +	 * recently been failing, to avoid burning CPU cycles in
> > +	 * reclaim/compaction before falling back to a smaller order anyway.
> > +	 */
> > +	bool beneficial_reclaim_backoff;
> > 	/**
> > 	 * @resv: Reservation object to be used together with
> > 	 * @allow_res_evict.
> > -- 
> > 2.34.1
> > 
