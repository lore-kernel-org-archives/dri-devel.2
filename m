Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF3F606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 03:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OA9VQJdH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A847010EDF2;
	Thu,  5 Nov 2026 03:04:51 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67EA710E0D3;
 Thu,  5 Nov 2026 03:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793847885; x=1825383885;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=3L82b3WyfOfR7gz9iCENsxANJ/8680khTPCcES0tU6M=;
 b=OA9VQJdHGvJ+J0vyI74Svz/2dMk/+A3aFbib9A4J48+O8Oys8A9TUZqF
 81NpFfb0agM0NfLF6moPA7dCzPV5ZlscHegZMxI4hukYTEc4MVDeNNRDO
 cjVSzwMymU1qUYkRpwKo1hYjgaJS0CHuonTngaEvunb9TqrR3V+fM5ziQ
 4at4MxP7ylEHD1dezZqdkFQMcnKL2swCcShj97P6PBBXrI3f7iIX40wnP
 xdGKEmfguc5bC4YRAyq6Yii1QtoAj5PImNY1SCKUCMEsudMgL810H4Frj
 AFLcB/B3PrkB6jnBoSXt7nq3y9gubRXOgNM/0j0tseiEH7xeArwRSgXmF Q==;
X-CSE-ConnectionGUID: hIdnp51rT0G02MMIxQPg1g==
X-CSE-MsgGUID: pTK6vrtLRImDpLyWc8/B0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2616672"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2616672"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 19:04:44 -0800
X-CSE-ConnectionGUID: HLg9FbBGTZStcU1Z42f5bA==
X-CSE-MsgGUID: PdZXemSFSb+tldbIaVwalg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="6765219"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 19:04:44 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 19:04:43 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 19:04:43 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.33) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 19:04:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uouB0yfM7l4ikIfQ7npxGEzq0zfUcryuBjw1Um39MMqQ8RFGVujhkgPMqDVRdnWrYKgVFgMhr9DJEveckBrDsO2rp4VHEapE6zVb2ZCI0W0TPZuDSpll4wJJbX7rhLeV9BPT7PCGLTL0TXVzMgOfl3FoXblcvQbFfc4MW2TwkJzx1HbXAH72Dg+RYBEqrO9Dmd7eHzlyQSCpDM7acTYOkk6gmUBqrK1VsZ8sxO1dy2wrlIYX/CYU68pgwLyFeYKmofYYbm3ji/Ij1+aFwwsAfIqH29DkhZJ9/lZg+uaeycAuqbVs/LyIFENvbh3xdPDU4TSpukf5vrbJwzckXQsQYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgtLlVE/IXWr0WRfK3ZSihp9ud2lYrKg7gO8EgXYm74=;
 b=i8CDO0uWY88ghcrRhs68L1fLjUGH0PvHI+kEssl61i64qMVD4qlCNcC9NRpXLOUvjMZSvG7A/3YR2LyzlbEUl/ppkplem1pk/IEwprq8Kto+Jo8U7KlgqiOG++I3Yz0tJYKuZmM1ARnwDUJE2yanhg+96MRLhsUwoAZoGEgO8MvP1OB/dKTA2jjHTzpP1osTMmNDYv59U/GJViGboEkmyloyQzIxVJGzn6Cz9al2xsxdQlhkS7Cz48+jogbpaqpyhqF15d8SnHZzdP0fo+RhZczK/ilrxvt0lc2hzh4lA3pua6SeU0q14uwO5o669nLTWpSCEC1PUAK/VfJ2j3+Kow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by IA0PR11MB7861.namprd11.prod.outlook.com (2603:10b6:208:3de::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 03:04:40 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 03:04:39 +0000
Date: Wed, 4 Nov 2026 19:04:37 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 <linux-kernel@vger.kernel.org>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v3 28/33] drm/xe: Use IOVA-based DMA mapping for eligible
 tt BOs
Message-ID: <auvyRQSLB18mWIeJ@gsse-cloud1.jf.intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-29-matthew.brost@intel.com>
 <a26a2160-fb6a-4d21-b132-d00093622b22@intel.com>
 <aupCPWQ7v5kyCpcW@gsse-cloud1.jf.intel.com>
 <7f567052-f8a8-488f-beb8-aff8f099fe0c@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f567052-f8a8-488f-beb8-aff8f099fe0c@intel.com>
X-ClientProxiedBy: MW4P223CA0006.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::11) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|IA0PR11MB7861:EE_
X-MS-Office365-Filtering-Correlation-Id: 5897f05e-3715-4755-e096-08df3ae9881e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7416014|23010399003|18002099003|22082099003|261009223027099003|261021121427099003|261022113327099003|261022105027099003|261028144727099003|261022075727099003|261026140227099003|261026121527099003|11063799006|56012099006|10067099003|261102123227099003|4143699003;
X-Microsoft-Antispam-Message-Info: P1+hvo/6P3UTt9JRphJhNovLFzquW/izwI5Tqpai064HeT9hwN8VWO+ua14gPWaejFvWeoSFM0GTwYocRRS0RocAD4ZsPQroeoTWt/ewnAOL1gTuJd1H60/g8AD/NhzO0zFhCb9JSXK8O/ld2lXRqet3a2iG2qhqI9S+qtA8z7qWJkDtjFsx5IP/cn5FlpFgp9seIt5A1fOhiUBe1KQ5PgCtRYoeBsl4/nLBsu3+zrVFPnoSy8L+POwGY0eP6fa3PYueQy5FNbu/EDRc0kjNkuIhFvrDCEchAXJ58RxiW1YKujIe9ocgOjPzOVKKcWtxAbLBXMoUXtYxC1R57VBgM/TXesVHhLGEBXLOczKVBIPrrJWiUngHzxWtQ6Nprdwdx4+gAkLHChGeEgHros5+uNI38WHozD9YvOQMAeQaSxLFzHvg80QWMH2wyIjZHBAhUW83Z1Cl05OoExVZVAFN5PmFjYxtmi9//qznpUpI1IULutEucZfiFqubpSm8kzN1fMx4+uf6lXAEZvAOk/LktbeuUUNjqALLdxP6RvlluDCFpXu3Y42vjMqYf6FT0NxTwkV60tRV07SDH6edsKeHsTByoCpatOWDWGqTP6F/dOo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7416014)(23010399003)(18002099003)(22082099003)(261009223027099003)(261021121427099003)(261022113327099003)(261022105027099003)(261028144727099003)(261022075727099003)(261026140227099003)(261026121527099003)(11063799006)(56012099006)(10067099003)(261102123227099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?JrICf294QzHXpndjEwk/m0jzjCg1MP0dESWyD8QYlsXpA2R6Z0MAaBc/ot?=
 =?iso-8859-1?Q?2VXj9GAfeMpbL3p7kEAJnMj8vmiY8jR+xWW6mjbtr4voHIjUe9ddo/vGAK?=
 =?iso-8859-1?Q?vXHId1+0FEszIiv2FYrrFw99bgrsMxIiVYT79vBEYkJM7woOw+eqXS8Zt4?=
 =?iso-8859-1?Q?a4GUe+esJRJQ3t5T+yd7QBUK2HOzvip6i5ORg3tFpwBaS2HE35kaPtHHg9?=
 =?iso-8859-1?Q?N1SYCLqBadQbV9SOPHz7ERYv+k134Lj+gTqqkQNCysI6w4pEZ0J/mnob+J?=
 =?iso-8859-1?Q?cqACskntSYK4osPukKPfUmbtwW1ibqf6D3Uii4E/VleTevdDWjccvwhVz9?=
 =?iso-8859-1?Q?hrGVxS7Y+RZV4NgaL41aLO9VsgVXKQAGWs49VNQZ0LGHk9zx3aG9iGSt7t?=
 =?iso-8859-1?Q?o9qdxm60FKNb/qAQ74hGxlIZVfd8KXP0QnFIUBpeKdipNsSBx3S8EthMC9?=
 =?iso-8859-1?Q?QnB5rV+YLxptfvhfdmxYVMl9lBePPT9kUuWNM9JTtIq7KBQfemkm0SeYvy?=
 =?iso-8859-1?Q?b3Me+6itou0VOB+kXD8uvgshZMhFs+hrrr/M7GbH2HtrduSMK/dZ2eKpTd?=
 =?iso-8859-1?Q?fAPhpqirhi99IX7lBxqrpyQMk0oHNQtJYYHFibCLeQy7i/DchESpcM/bLr?=
 =?iso-8859-1?Q?/IqlFa1jkwGFQLWOjl0/wN3vFhuf6H4HObrqKV+drjqGSfixEQ82Q8VrGJ?=
 =?iso-8859-1?Q?YV/avzDsJiv7iQSx7QoZ75u2Sm7YcVNxmNp5gFEN4kQrG9eAtzhoFO32hT?=
 =?iso-8859-1?Q?baeuLb4eoEq5q3TwCr+OZlHwOP9I1KgDXR0Oi/7YL2nN5TFoMxZoHFXlM5?=
 =?iso-8859-1?Q?e4ibHAipenn8Fm0aC2fichg4FbgoU6yiR/3l/gvhchXggzpQN4ybsjuq+o?=
 =?iso-8859-1?Q?Q1bhauMekU8SxFN+Vv4hg/yxDyqFc8Fk6eS6CtQ+neEOmPhpJ8RH5CTIKi?=
 =?iso-8859-1?Q?s33MJ6CIbs3ZIc/EF2tRAgXoByfr/iLcFSRPu0lM9HC003YgVpogFmo+lG?=
 =?iso-8859-1?Q?AsSGHnJCPOOHcksJWEIlo3Uv22rKrkK+r0zLvAR7IBvPEUeMdU049iteo5?=
 =?iso-8859-1?Q?Y2YzbdKZxYfLksKiXOjMxrk56fsfwadlDPp8939BusTvhFjBOPugkIRo8D?=
 =?iso-8859-1?Q?vXRxONwNirRCbx9gDySZuCa4S1SViMHGeh7PtutTqpW/tEysF5vAfNA6ps?=
 =?iso-8859-1?Q?5mysLogMnUeLaTtG6sk73VeWxihudZPse82Lq6W2yIWBYwzanII7RNdyLm?=
 =?iso-8859-1?Q?xoMa4UpHM/qnqqmwPAO/Cbh1iNPvUoqYQemGQLjsJPVY+jrJyNaEl9aZEE?=
 =?iso-8859-1?Q?0bb8c7iWCRfFF8cx4gKXCkCyUDXqnyJIJP2lprXHycbNLkiE/PfoC6yu13?=
 =?iso-8859-1?Q?pu20ZPlwpkjH4S/RvH+g+1+Trgz/m0WAxclFikioFHWiYbrjqkYCSHZH0I?=
 =?iso-8859-1?Q?xl6e7iRoC/SDC9TaD2fb1dKCqig24RZKOEPQGKGxq+6Ga5MyACboHjWDFr?=
 =?iso-8859-1?Q?eHt2YcUU8CpSrTL4i0u1kVkoU92RPIhc4ywVL76/+teR8YEIa61q2mE1V3?=
 =?iso-8859-1?Q?TPbWvDfVEKOKI6rl5T0Hh6/nmxtmsLksOUs1F5ASXS3kQgpyQy3tbLgwOt?=
 =?iso-8859-1?Q?/ItlyNmY0IysopkeNAx86p6I/+UpVVeR1hry5blGsxxdItQOvLXkP5wvKD?=
 =?iso-8859-1?Q?y61ziCJ4KCAKsn9xnfC4h/qev26fbPxctQPr20hH7az5Gd97uqrNlZJalp?=
 =?iso-8859-1?Q?z4K32tL70t27FAhKPmYH6p1kb05PhbBqGZ+JU9+5GyWz5BS/ag6MEFuNE8?=
 =?iso-8859-1?Q?aYZcjdbGcw=3D=3D?=
X-Exchange-RoutingPolicyChecked: oOjKNzUH7ZMuSxnFm1/xT6FClxynJfDH8s44JKt0jZrRMMADf7cjRHiQB+eIzBzJDEGRBc+BsiqxpYAC3DIpT1L9vpr2cr3aEBLFRvVA3yW5VCd046olvtY2bDaZwFtE1ZJCC+F5KmsNEhjaiVcKnbXomkBRoLw5I56nZ6YkNyaJ6eFPNw/Lz2Int47PehzfkXkARkLsuGJZpjwY5Kf5Bl/aHYfQB8MhErfh0jA8V5ne0+L9L5C7fp1bVwWp5yMS0qpnem6gLPnWQd/o+aCSICLZSeg8hF4z96QgQywH9+qMUz0TCeEEWyaCX+vGAYzsO2xEEDDt/qGZQow9VbK71A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5897f05e-3715-4755-e096-08df3ae9881e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 03:04:39.8319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IkFJRYOwu9mEcA7dnEMpoX2UKLQXZoeeSh4IuPE1J1yWqX6uL3QP+zAlOtnfRvu9hEolvqLa+blZ2833Mb2pBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7861
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 11:39:30AM +0000, Matthew Auld wrote:
> On 03/11/2026 20:21, Matthew Brost wrote:
> > On Tue, Nov 03, 2026 at 07:00:24PM +0000, Matthew Auld wrote:
> > > On 11/07/2026 03:56, Matthew Brost wrote:
> > > > Add support for mapping a ttm_tt's pages using the IOVA-based DMA API
> > > > (dma_iova_try_alloc()/link()/sync()/unlink()/free()) as an alternative
> > > > to the scatter-gather list. An IOVA mapping is a single contiguous DMA
> > > > range, which is cheaper to walk and program than an sg list.
> > > > 
> > > > Whether the IOVA API can be used depends on the IOMMU mode, so the
> > > > decision is made once per tt at xe_ttm_tt_create() time and recorded in
> > > > struct xe_ttm_tt::use_iova. To keep the scope limited, only device BOs
> > > > that are not GGTT-mapped are eligible: dma-buf imports manage their own
> > > > mapping and GGTT bindings are programmed directly from the sg list.
> > > > dma_iova_try_alloc() may still fail, in which case the tt transparently
> > > > falls back to the sg list, which remains the default.
> > > > 
> > > > The IOVA reservation is allocated at tt creation and freed at tt
> > > > destroy. xe_tt_map_iova() links the tt pages (coalescing physically
> > > > contiguous runs) and syncs the IOTLB; xe_tt_unmap_iova() unlinks them
> > > > but keeps the reservation so the tt can be remapped without
> > > > re-allocating IOVA space. xe_tt_map()/xe_tt_unmap() dispatch between the
> > > > IOVA and sg backends, and xe_bo_dma_unmap_pinned() learns about the IOVA
> > > > case.
> > > > 
> > > > Consumers that walked the sg list via xe_res_first_sg(xe_bo_sg()) now go
> > > > through the new xe_res_first_tt() helper, which initializes either an
> > > > IOVA cursor (xe_res_first_iova()) or an sg cursor depending on the tt's
> > > > mapping mode.
> > > > 
> > > > Cc: Carlos Santa <carlos.santa@intel.com>
> > > > Cc: Ryan Neph <ryanneph@google.com>
> > > > Cc: Christian Koenig <christian.koenig@amd.com>
> > > > Cc: Huang Rui <ray.huang@amd.com>
> > > > Cc: Matthew Auld <matthew.auld@intel.com>
> > > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > > Cc: Maxime Ripard <mripard@kernel.org>
> > > > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > > > Cc: David Airlie <airlied@gmail.com>
> > > > Cc: Simona Vetter <simona@ffwll.ch>
> > > > Cc: dri-devel@lists.freedesktop.org
> > > > Cc: linux-kernel@vger.kernel.org
> > > > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > > > Assisted-by: GitHub_Copilot:claude-opus-4.8
> > > > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > > 
> > > 
> > > <snip>
> > > 
> > > >    static void xe_ttm_tt_destroy(struct ttm_device *ttm_dev, struct ttm_tt *tt)
> > > >    {
> > > > +	struct xe_ttm_tt *xe_tt = container_of(tt, struct xe_ttm_tt, ttm);
> > > > +
> > > > +	/*
> > > > +	 * Release the IOVA reservation made in xe_ttm_tt_create(). The pages
> > > > +	 * must already have been unlinked by xe_tt_unmap().
> > > > +	 */
> > > > +	if (xe_tt->use_iova) {
> > > > +		struct xe_device *xe = ttm_to_xe_device(ttm_dev);
> > > > +
> > > > +		xe_assert(xe, !xe_tt->iova_linked);
> > > > +		dma_iova_free(xe->drm.dev, &xe_tt->iova);
> > > 
> > > Do we know if this is allowed? I think there is xe_bo_pci_dev_remove_all()
> > > which requires that evict_all will correctly tear down iommu mappings on
> > > stuff like pci unplug and I don't think tt_destroy is called in that flow?
> > 
> > But unpopulate is called which unlinks / syncs (TLB flush for the IOVA).
> > 
> > > Does having the iova here cause issues? Also, for VRAM flow I think there is
> > > a tt_create() via pipeline gutting which will now create a new iova?
> > > 
> > 
> > Maybe we shuffle this around a bit so the iova alloc is tied to
> > populate/unpopulate. It was been a while I forget exactly why I did this
> > way.
> > 
> > > Aside from that, maybe we can land 27/28 as standalone?
> > 
> > Yes, let me extract these two into standalone patches today and
> > reworking if needed.
> 
> Quickly double checked this, indeed looks to be needed:
> 

Thanks was able recreate this + verify a local fix.

27/28 has one TTM dependency [1] and also is staged behind dma mapping
accounting [2]. So maybe once [2] lands an updated 27/28 can get posted
as standalone.

Matt

[1] https://patchwork.freedesktop.org/patch/739339/?series=170216&rev=2
[2] https://patchwork.freedesktop.org/series/177790/

> [  808.058892] [IGT] core_hotunplug: finished subtest
> hotreplug-lateclose-with-load, SUCCESS
> [  808.058928] [IGT] core_hotunplug: exiting, ret=0
> [  808.059673] BUG: kernel NULL pointer dereference, address:
> [  808.061068] RIP: 0010:iommu_get_dma_domain+0x10/0x20
> [  808.061141] PKRU: 55555554
> [  808.061144] Call Trace:
> [  808.061146]  <TASK>
> [  808.061149]  dma_iova_free+0x18/0xf0
> [  808.061153]  xe_ttm_tt_destroy+0x23/0x40 [xe]
> [  808.061231]  ttm_bo_put+0x242/0x3d0 [ttm]
> [  808.061412]  ? drm_gpuvm_bo_put+0x199/0x200 [drm_gpuvm]
> [  808.061418]  xe_vma_destroy_late+0x89/0x90 [xe]
> [  808.061476]  xe_vm_close_and_put+0x5de/0x920 [xe]
> [  808.061534]  xe_file_close+0x105/0x190 [xe]
> [  808.061712]  drm_file_free+0x218/0x260
> [  808.061717]  drm_release_noglobal+0x6d/0xd0
> [  808.061721]  __fput+0xf9/0x270
> [  808.061725]  task_work_run+0x8b/0xb0
> [  808.061730]  do_exit+0x229/0x8b0
> [  808.061735]  do_group_exit+0x8b/0x90
> [  808.061739]  __x64_sys_exit_group+0x17/0x20
> [  808.061744]  x64_sys_call+0x18c6/0x18d0
> [  808.061749]  do_syscall_64+0xee/0x350
> [  808.061753]  ? __pte_offset_map+0x1d/0xd0
> [  808.061757]  ? next_uptodate_folio+0xbb/0x3a0
> [  808.061762]  ? set_pte_range+0x20d/0x290
> [  808.061766]  ? filemap_map_pages+0x8e1/0x9c0
> [  808.061772]  ? count_memcg_events+0x7c/0x1b0
> [  808.061776]  ? handle_mm_fault+0xbde/0x14f0
> [  808.061781]  ? __se_sys_close+0x7a/0xe0
> [  808.061785]  ? __se_sys_close+0x7a/0xe0
> [  808.061790]  ? do_user_addr_fault+0x272/0x6c0
> [  808.061794]  ? irqentry_exit+0x3f/0x640
> [  808.061799]  ? do_syscall_64+0x42/0x350
> [  808.061803]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  808.061808] RIP: 0033:0x7f95428c71b8
> 
> I assume this is dev->iommu_group = NULL post unplug.
> 
> > 
> > Matt
> 
