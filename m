Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C178606A901
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 20:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W+/nPSPA;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Fx/yoAcD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F9E910E184;
	Thu, 19 Nov 2026 20:49:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 564D010E14E;
 Thu, 19 Nov 2026 20:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795121368; x=1826657368;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=BjtVVnOGPbgj2Jj7ybalJN6gkNdOW2GXibseDY2BoCU=;
 b=W+/nPSPAlPrRef2wZJ9au920YoNyG1lfyptbD7vE/Q2hK6JkANGVz5yL
 bAd9y0YJ2LptIyJLQA7KPRs7AAYKC1Yl4IVAMXecYpSDbdh6cUj8J+9qv
 9xe1wKmud87X+QevpLGwQuiZAXCkjtaLztsxHZfYqyiKoGN19MztNcY6H
 WxRyEMbEmyOlc5mgpmThqEgkUuCTsfVKcpesL2/f89b331obSCsHmABKZ
 V0JFxpBktNWxbjydXBUasVnPerFujiW11Qfhevj5jhpeNKnt7LnKkr+zW
 1t8Vnf3Kr2A21kmAAuI1Nd9+oLz6XoXOiwPFWxK+sP2sdkMVg3W/pcMhR g==;
X-CSE-ConnectionGUID: uPZvG0qxT8GFlJwoUNfwiQ==
X-CSE-MsgGUID: uVw8B31ZQFexCktELgPdqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4007451"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="4007451"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 12:49:28 -0800
X-CSE-ConnectionGUID: WPJ2XPTSSBWe8IkZ8X9Kwg==
X-CSE-MsgGUID: gzAC4vszRhSTWpXyFeavgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; d="scan'208";a="10611396"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 12:49:28 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 12:49:27 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 19 Nov 2026 12:49:27 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.24) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 12:49:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bBc+uR8UHoN2HJOWEspL3IDv2qYsnxqKLU8XjIW0Ruk5XI6a0ERTb1fOycGhnvTC+rs8duB6Llaj/gDL26u9Utwv6AsxDEMNeK6JGw006x71PpG7npRABm1IbYJ1sCvRjAYX6ninTIzpNyYkce7Hg11/itIESeL+JZgyDWf/0MotAZa6O2UYIxw77KeYoJd/iDiCddfmBkzDbwelvDmklUNoxOCbSNm5HWptRsprZDBERhqyPI5/Zq03zclUMJ2Ixdzyzuu9lrxdlpG9TgkCV2ZX7o/ggJ1RyJdiCEwGg2dDwFbbFvHTD4/seNdPHNznP7WARHzhQJcqcylZfLaM7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3NFjqICYTE75PwJNp3lXIyZWpaIRyqeMzK8Ab6RNJbU=;
 b=ndkkcVtzGyaNXXLTyW+I8cwWw1vFauRz+WllsK+ENC13JRt2E3ozvpBLXA8U5nmvinohb8l4K4JKfVsUQyy6YSrDpEX3l/ClsnLCUkiqRXpCq8ZLCjj8Q6QCa2ESxqDt0nwutJEJW5OrdjBsc1L3uK/biyWB5pJF1Y/236qrjYl+aD+DqbLeGaiD0iLlMlXe52VojHGgq04zaJ1vC3WzuUWz4cwrA25IqhOlcSMQb1P7/BWu1ZlD4bHFTwTWikKcMOQuSLlSOqalW4jAEmsPmFozS5hPrIWNukFxUCcUVrx2WarlEV2NyepSUm4VeCID+H7kH6wIJKgHyu3S0hn9Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NFjqICYTE75PwJNp3lXIyZWpaIRyqeMzK8Ab6RNJbU=;
 b=Fx/yoAcDGWIgeNyMq8xhWy0kaY6DZX6umcYIE1DpHuulm8kGNjmASdsJR9bfbleRzrFwIZoVIh4yUMcvDwlKPgMSwLafeIz8mG/AdsOgRzt3zhTWRnJat/ZXPBFoMr1XpBnY27nvYYDDJTayvcc27dH692QmpUgbtn9uBfBLZGc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by DS4PR11MB298041.namprd11.prod.outlook.com (2603:10b6:8:508::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 20:49:22 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 20:49:22 +0000
Date: Thu, 19 Nov 2026 12:49:20 -0800
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
Subject: Re: [PATCH v3 06/33] drm/ttm: Add fault injection for
 beneficial-order allocation failures
Message-ID: <av9g0IzQtppjI7Xd@gsse-cloud1.jf.intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-7-matthew.brost@intel.com>
 <au1BdOeD319qwsYa@nvishwa1-desk>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <au1BdOeD319qwsYa@nvishwa1-desk>
X-ClientProxiedBy: MW4PR04CA0166.namprd04.prod.outlook.com
 (2603:10b6:303:85::21) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|DS4PR11MB298041:EE_
X-MS-Office365-Filtering-Correlation-Id: ad1207a3-fc92-4e07-8fd7-08df467e9700
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|56012099006|261022105027099003|261021121427099003|4143699003|11063799006|261026140227099003|10067099003|261021123027099003|261022075727099003|261028144727099003|261102123227099003|261009221227099003|261009221727099003|22082099003|18002099003|6133799003|261009220027099003|261009223327099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: S/RJmRQyDshT5L38FnvNq1S+TaOc8P1cz81h08shTNP3fEtMClcnY5jyFenbWxwXlRB7TcSgpVBK+argsiAOl3OYTT58fa8sms7VkQl+H6PVeh9+mKFss+pDxAd+5dGvfkzriuINCUyjF5BVjjmBPSCjYKPorhI4L3fjzEBJTQVs6WSZRla/Vh/aEdq4n57+b7rpk2rwWGUjkzc5rN5iDVLz2uyhXYr4Hzq5hQFRrwmWU0FT29y2rCPzyFpSaQMqvFCovx/jEPCJW670CX0d5onQ2elwnA8qGVAB/B3GEpRTIF+EvM/U02cddE6KIy6PusxYcSdcRvvI/FC5a6HjRYpnWh0BRNLXNBSkK45N6BTUWuq+SNewNq0cvc/GPc8JVIZrZ9UNXb7QamZJBv28A1hq5AJEEFco0ZWI3fPiSxHHVnEJyE6/3TzzRTIm2XSZmIAuzCC+wEvJYq5jTm/PJUW/CR2L4ctNqNX4oy50zk3wK+2k3jW4dce2NBdbC4M/KsRQPe5tBguUnKbTh+BMFmfUcwrcxSeofIrAE9jnIqhEbKtgliDE+AjTopYBXynaON0WDmyk3z2kAhyOMja+UKZi7oTTEALgVdlJg13zfWhSn9myHtFGvHdVDXM0NreRIXtq7nKI3KEV95FrYVJCj8VAvz2VhpKBB2v2xXtUfKU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(56012099006)(261022105027099003)(261021121427099003)(4143699003)(11063799006)(261026140227099003)(10067099003)(261021123027099003)(261022075727099003)(261028144727099003)(261102123227099003)(261009221227099003)(261009221727099003)(22082099003)(18002099003)(6133799003)(261009220027099003)(261009223327099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?BLiPrBGzr0jFFab3/IDkRwdk+FPi3kVj3Ouvn9q2kqoQIki86lFxxhHwo5?=
 =?iso-8859-1?Q?m4pYvQtQWzk3yIKEakEU5A9c3ghdlDYICP7AhXWVFlkztUzZIR4XRs7gPZ?=
 =?iso-8859-1?Q?gT07gieeF16RCxDV6BihqCTJjgtLo1rBlZeYLiQ0h5LTcFl02LuJHnVMo1?=
 =?iso-8859-1?Q?wxyNAbI+Fr2X4MrylXhlSdofQSeG3qP9rHT9a5qPmBNL01CM3zyCA3SpK/?=
 =?iso-8859-1?Q?quXSI1H5Z+/zCmfdjyoeCee64+sNGtfJV7NgCcigbkgOKMRO6UbtX+0c/h?=
 =?iso-8859-1?Q?EDoMkqGweVLYYKjrj5lMxzKhIUxRDz5IV0GLCFxxD9Y+osCoqiyzUeZldU?=
 =?iso-8859-1?Q?pDU3tfNPtByEfDit1YLZKVwrPXee82PApHgoQ36hL+E9YnK5nATUE4xV/6?=
 =?iso-8859-1?Q?cgvCxEC9CKMg9jKnPpoMexZQxVkcUviZhsadzVrdotuLXVz8pwpoanbsgf?=
 =?iso-8859-1?Q?c4OKbfWrW71HN4+casJ/iEW9qQazQc/cpvA/YXsvKCO1K7Rb2VXaMJbkBZ?=
 =?iso-8859-1?Q?FfbIDYi+yVxUi4b/8uLB+TX0333oON1pHS/rexfA9w5cI/GyIXTxOWguuo?=
 =?iso-8859-1?Q?0DSp//gy7k7guvuklPJett4EeK1Biuy3yWmKx16CBUxzFT6iHfIHyKijiJ?=
 =?iso-8859-1?Q?1TnheNrk04Ei3ifxzYNsM8sDfpFiMrR/RYStqSvsESpmTPiq5HEWXlIbRT?=
 =?iso-8859-1?Q?8JjScrDf69qNuIARbC5kmnRC0LH3CV3jvvBTkfaweyvVXXEAnFzC7A0zN/?=
 =?iso-8859-1?Q?3wLXsoS9FvQJZain99JAvXPgH0itwT5ewdXUJT0FTeBO3okYQwV451AahP?=
 =?iso-8859-1?Q?4gl2TzGSwLSm3yzABPsrokYAQ5h06KpramRqvSeCMh3nXhqfGIKoDlYC+J?=
 =?iso-8859-1?Q?PwocFFMY+opcP5ii4lr9qiBVCcxJTPSsID9wh6tlxDoDjnfW0OYqQJkzpu?=
 =?iso-8859-1?Q?dx8WqKskvs8kk1hXCFhbt5dnbl8xbLHFZ2/f058UWGOOpXrtHdj4ZTd07P?=
 =?iso-8859-1?Q?xpP3vCzzFrhHbsMa0QW7zVmqRC/FQoq2zye1mf2F5VgGfHuhuuqE8AwSJy?=
 =?iso-8859-1?Q?MtuTLWvTFe9azpHGgXGqU455cx+yvInKEQOMto3a9/Q7qzz87VG7SxaMwP?=
 =?iso-8859-1?Q?rE1cZ4WJyJ7Zj1bIEzZN3fRXLDUmlCppTbxTqNRNnjDHsFqv9MbTyMc0wJ?=
 =?iso-8859-1?Q?C2m8GNO2Jx000+YpILAhuwT93yTlFOsOUzvmPKxiAhwnn1kx+RzNA574nA?=
 =?iso-8859-1?Q?okVskbfjp67oc9s+v1yrVkkjlWRJbpUncXx5y5szVS+YqlBYUgVNq9IPpM?=
 =?iso-8859-1?Q?6bikgaG+AGnnRXOu4n8SVmqT0TvFdIdoLCCv9taH/BkKSBLhBHLfYSD0Ep?=
 =?iso-8859-1?Q?paVhRYMTt6RJB3W/8yZ3TKiMTyoGe25yjuUs+xPsGRnQBMz6t240NmCsZc?=
 =?iso-8859-1?Q?GKDAHxmrENxOtODc3g2A5lcx+TujsrMmkibVHMCILV140bgoYZqS9NLbaT?=
 =?iso-8859-1?Q?KmqjNPbvT21bMSMUgSBWWXmuvYWob50ZiqZqRau22r9EwpLbX9cZNxjh2X?=
 =?iso-8859-1?Q?FQZ2ia1FJUj8Qhmrxqpn4AYxgi6BliKZGORs+IZ04SeJrIGtvrSMtsQTyI?=
 =?iso-8859-1?Q?rqI3f6KFaLNMhiNasPpFMqvpp1O+KUepv+UPxhJH4ENvigkIcEndf61Nui?=
 =?iso-8859-1?Q?VpWQvDNeYZ9XohH2Ur1tC+tcPLN5xsKUFpoS1IrvEBnR2Rjh/Dgq+MPy+6?=
 =?iso-8859-1?Q?/J7DD7Aimi6GQVgQscNUWR2qaghdESMTrjs3E1jt8Smpzb0cvYmyKGDIC7?=
 =?iso-8859-1?Q?WL9Qks0QPQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: Z5+RlIqz40QTJIsSsw4VcdAdhJqUAFnaGYKGRoolGWDoel7GfArkJ9MLj3FR8QGVczCcY3M6lafc8DARV+59QADVgX3SN80ORhMLl5E3pEuuXxu9s2F0goLJHvvD731KzF1iJLQG4txixM116RZ9TIUA/ymbt/vwwuCsITIGgK/M8tHzKFl52IXXjklVXQuOQ4g+lTR2oFwDxsJgL3NYJlon+njK5YElXh3z4F+P2BmehC7IAkdYjzDMPLP+9XqLr4W++4lfRx4VAp5HcvDHHqD5FKJAy1sZhFaAHdwY3QtrHzxLgHcuZmyFULGsi1zcSBkqRpfRgHMQA3KhfyAWgA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1207a3-fc92-4e07-8fd7-08df467e9700
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:49:22.5142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0g8rojKw3bTNfJOYCQjSXgAVRdvrVwLUJgVGWNbQBcgJ7imFKWfBtlv1zFWoM91uK9WhceSzoGVgbddBTcWIAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB298041
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

On Thu, Nov 05, 2026 at 06:54:44PM -0800, Niranjana Vishwanathapura wrote:
> On Fri, Jul 10, 2026 at 07:55:52PM -0700, Matthew Brost wrote:
> > Add a beneficial_order_fault_inject debugfs fault attribute, mirroring
> > backup_fault_inject, that forces allocation at (or above) the device's
> > beneficial order to fail in __ttm_pool_alloc(). When triggered, both the
> > pool take and the system page allocation are skipped for that order, so
> > the allocation falls into the existing lower-the-order path that sets
> > the TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED tt page flag (and bails out with
> > -ENOMEM for defrag moves).
> > 
> > This lets the TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED tracking and the
> > driver-side defrag path be exercised deterministically, without having to
> > drive the system into real memory fragmentation to provoke a sub-optimal
> > backing.
> > 
> > The knob is registered at
> > /sys/kernel/debug/ttm/beneficial_order_fault_inject and compiles out
> > when CONFIG_FAULT_INJECTION is disabled.
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
> > drivers/gpu/drm/ttm/ttm_pool.c | 35 ++++++++++++++++++++++++++++------
> > 1 file changed, 29 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> > index d045105afc24..2598d2f33767 100644
> > --- a/drivers/gpu/drm/ttm/ttm_pool.c
> > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> > @@ -53,6 +53,7 @@
> > #ifdef CONFIG_FAULT_INJECTION
> > #include <linux/fault-inject.h>
> > static DECLARE_FAULT_ATTR(backup_fault_inject);
> > +static DECLARE_FAULT_ATTR(beneficial_order_fault_inject);
> > #else
> > #define should_fail(...) false
> > #endif
> > @@ -812,21 +813,34 @@ struct ttm_pool_alloc_iter {
> > 	unsigned int order;
> > 	enum ttm_caching page_caching;
> > 	bool allow_pools;
> > +	bool fail_beneficial;
> > 	struct page *p;
> > };
> > 
> > /*
> >  * Acquire a single page for the current order, leaving it in @it->p (NULL on
> > - * failure). Tries a same-order pool page, then a fresh system allocation.
> > + * failure). Tries a same-order pool page, then a fresh system allocation. Fault
> > + * injection can force the beneficial-order paths to "fail".
> >  */
> > static void ttm_pool_iter_acquire_page(struct ttm_pool_alloc_iter *it)
> > {
> > 	struct ttm_pool_type *pt;
> > 
> > -	/* First, try to allocate a page from a pool if one exists. */
> > 	it->p = NULL;
> > +
> > +	/*
> > +	 * Fault injection: pretend allocation at (or above) the device's
> > +	 * beneficial order failed, forcing a sub-optimal backing. Exercises the
> > +	 * beneficial_order_failed tracking and the driver defrag path without
> > +	 * driving the system into real fragmentation.
> > +	 */
> > +	it->fail_beneficial = IS_ENABLED(CONFIG_FAULT_INJECTION) &&
> > +		it->beneficial_order && it->order >= it->beneficial_order &&
> > +		should_fail(&beneficial_order_fault_inject, 1);
> 
> NIT..Looks like IS_ENABLED(CONFIG_FAULT_INJECTION) check here is redundant,
> but other fault inject case is also using it, so, should be fine I guess.
> 

I believe the thinking is immediate short circuit on a static Kconfig so
the compiler can optimize all of this out. Maybe it should_fail is
enough but following the style that exists in this file for other
injection points.

Matt 

> This patch LGTM.
> 
> Niranjana
> 
> > +
> > +	/* First, try to allocate a page from a pool if one exists. */
> > 	pt = ttm_pool_select_type(it->pool, it->page_caching, it->order);
> > -	if (!it->p && pt && it->allow_pools)
> > +	if (!it->p && pt && it->allow_pools && !it->fail_beneficial)
> > 		it->p = ttm_pool_type_take(pt, ttm_pool_nid(it->pool));
> > 
> > 	/*
> > @@ -834,7 +848,7 @@ static void ttm_pool_iter_acquire_page(struct ttm_pool_alloc_iter *it)
> > 	 * this also disallows additional pool allocations using write-back
> > 	 * cached pools of the same order.
> > 	 */
> > -	if (!it->p) {
> > +	if (!it->p && !it->fail_beneficial) {
> > 		it->page_caching = ttm_cached;
> > 		it->allow_pools = false;
> > 		it->p = ttm_pool_alloc_page(it->pool, it->gfp_flags, it->order,
> > @@ -851,6 +865,9 @@ static void ttm_pool_iter_acquire_page(struct ttm_pool_alloc_iter *it)
> >  */
> > static int ttm_pool_iter_lower_order(struct ttm_pool_alloc_iter *it)
> > {
> > +	bool at_beneficial = it->beneficial_order &&
> > +			     it->order == it->beneficial_order;
> > +
> > 	if (!it->order)
> > 		return -ENOMEM;
> > 
> > @@ -860,13 +877,16 @@ static int ttm_pool_iter_lower_order(struct ttm_pool_alloc_iter *it)
> > 	 * pages. Record it so the driver can later try to defragment the object
> > 	 * back to beneficial order.
> > 	 */
> > -	if (it->beneficial_order && it->order == it->beneficial_order) {
> > +	if (it->fail_beneficial || at_beneficial) {
> > 		it->tt->page_flags |= TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED;
> > 		if (it->ctx->defrag)
> > 			return -ENOMEM;
> > 	}
> > 
> > -	it->order--;
> > +	if (it->fail_beneficial)
> > +		it->order = it->beneficial_order - 1;
> > +	else
> > +		it->order--;
> > 	it->page_caching = it->tt->caching;
> > 	it->allow_pools = true;
> > 
> > @@ -1536,6 +1556,9 @@ int ttm_pool_mgr_init(unsigned long num_pages)
> > #ifdef CONFIG_FAULT_INJECTION
> > 	fault_create_debugfs_attr("backup_fault_inject", ttm_debugfs_root,
> > 				  &backup_fault_inject);
> > +	fault_create_debugfs_attr("beneficial_order_fault_inject",
> > +				  ttm_debugfs_root,
> > +				  &beneficial_order_fault_inject);
> > #endif
> > #endif
> > 
> > -- 
> > 2.34.1
> > 
