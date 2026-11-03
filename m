Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3C4606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 20:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HdYBAd9r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 901C110E812;
	Tue,  3 Nov 2026 20:21:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A58D10E812;
 Tue,  3 Nov 2026 20:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793737291; x=1825273291;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=rWQIXmwA7LdDgBNc8lH9PuQVB6M+cYJJPbXZWtJPOqM=;
 b=HdYBAd9rPhcXYXqTo3kzhVwyrOzW34WoezawSPYr3o2o70EO2vl4mrmJ
 rgEcHTOyCs3SdwHgXYn1K/aR67LpZaoB25qbqIRdU/sGKbOUdCDNrG0Nl
 SFCsZeaYo8tBK/kAVjKT6yg906VxTy9xMGLXJi0+YjoE49CRU3UoXvYxt
 zcHLDsOoeyFEefERx7x8LZ9qFrcic05izGCVxwikTO/hLUkTFO8rD7IKV
 KxEAC6Bqkpi5RCDGDNr8rLUnb5uBXpNGGsZWS8EfNyXoZYi62KsA7EZ6M
 JhremznmmiDDFZfYg9Cd4U8jHDGWLAE8I9bqAW0AurNUj2J6c5SwPzNFy w==;
X-CSE-ConnectionGUID: 2Y1hDyC6QiueIu6smnibFg==
X-CSE-MsgGUID: 76Mm7BhaQsiSSbHH2SCxWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2363522"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2363522"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 12:21:30 -0800
X-CSE-ConnectionGUID: VVJhYKtVQYOUkHzGKPYpDg==
X-CSE-MsgGUID: t20QKdQARlyEaLczZFf8fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6535353"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 12:21:30 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 12:21:29 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 12:21:29 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.7) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 12:21:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rp/pAIvk6LN8hkGKZiM7JuYbE47/2XWmuD+/Xzwnjj8OXFfcjhkaUHwWoRsKMJePO72+00n+z4rak4abyac1bNcGzLoYkEjQ7u4vFFY1PRh9aika3baOYJ0fK+bZsfI97O2vPCkS6VUggwpEliRnmRUv7tgtCB5/91Hb4u3I7LycKh6XBzE6wIQOfXDr+1WxnHxDMfS3M6zHCLYTZxZ6QjTS4s1JIOWwe7tQ0l/SJBZj21VvuKypdclpRwkHQ51JAFDsbql/dUeEaRLqWE1tAEJa1KSxxskbWjIpZLvoXh24jjZsIY0okQKQV4YuUekI15mvBVts6uvGBT2VtkPNaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvPU7HVJuvMOlp69qafJmbALiI4lvm4EefP2tGPzRY8=;
 b=dt66hGkHVCky88xKZGN9MacxQLSNokBA/zjL55DhYc2AZ5rezV3lKaL1Tpx3LX5jPRQ0tZ9wkJgRaDVHHfdF0MUFJmTCkVDDfXd1lC2iiWkAwr4mImeQ5iSbwrJwxEJrntgzoKbHlBJIIPFxASfYhFvSLvcmF1nQdVSCC0D8w1x+aokw6OOqAdwvI7CbhD5SnJ96fan9vrzQdXE6DEwff9xGSmM/i8DTNwwtN0AblIVDfnWOfdM/xTmw9ZXopccVE3zN7KNDS60+h9XSso8UAtX5LLvXTwIfxEjZfhMCmWKOXCHBer9Fa6QXO3K3Pb65uqMMrMIaexu+aVaWnqOoWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by MW4PR11MB5891.namprd11.prod.outlook.com (2603:10b6:303:169::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 20:21:19 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 20:21:19 +0000
Date: Tue, 3 Nov 2026 12:21:17 -0800
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
Message-ID: <aupCPWQ7v5kyCpcW@gsse-cloud1.jf.intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-29-matthew.brost@intel.com>
 <a26a2160-fb6a-4d21-b132-d00093622b22@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a26a2160-fb6a-4d21-b132-d00093622b22@intel.com>
X-ClientProxiedBy: MW4PR03CA0324.namprd03.prod.outlook.com
 (2603:10b6:303:dd::29) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|MW4PR11MB5891:EE_
X-MS-Office365-Filtering-Correlation-Id: ac95e4a4-5270-4ff5-d8b9-08df39e80531
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|7416014|366016|261022075727099003|4143699003|11063799006|56012099006|261009223027099003|261021121427099003|261022105027099003|261022113327099003|261102123227099003|261028144727099003|261026121527099003|261026140227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: pFDXetJj7LAkg8e9lQ4gp9vP3iEtA8QtJQZ/2rYonMpvjRXNmJRKvgL32ro0euWad7da5itLvffEJDkBeAMn0k+QzXcWHKNAtL/RfbQhv/A1j+CGevmYw+f79sh91kfnLip2gdDIj04Vmk82fZQfLnlOUei50HCmb1L/gKKsNBnlFLqMJOoeqpgV7jlb3IsQiNan54CiWkSOdIZTqn9Pc/nsUQyhW+eLKBhE7UIa5x+8RqL8PRqqqq8UAmWTRf1yX12r74Epx9Ll4MnHjIC68HMXmPI9Zi5PwipFmsgoHnDtRO7ZcZ3JCkmexqQuKyv8vCjvh8YdyzDkNWM7EqIytYDwBAfOQiGcXEAHiBluhJVktNFdVklq0kvhxn+JnJkYseQyuyciarfSvP3PdKCeDUZmYzgixBuHx8aP2SVI3ARD1wmMo1DXQ6l78XyEwdYiOCmwAkQSRzTsFLVWOi7Dsp7/sfqKrUO4y9M91anyQdEggy17T+KjguNRl06PuhKxPzfGwaEA5SIMQsOGF7ryfzxgyY/fZ3NMl11G8ANjcODMLkRNu9KRphfrSBxrkjpb5hYDZikej6aA0o57t8oawDDWMHQGls9tTdVGGODcfP1kw2x+yCmPqRlNf6WIZyxKUSzHemvbUngKIyHd37SXe1krhf6EF7tFoHL0J/CzlO0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(261022075727099003)(4143699003)(11063799006)(56012099006)(261009223027099003)(261021121427099003)(261022105027099003)(261022113327099003)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?tUFDy4+S4jcIfxB+arnflxDTFpAEs7+wgn3mjCrl4vrOuJy6Ou3sGspiR0?=
 =?iso-8859-1?Q?lGHui1CcTCiD8ye0lMjoADiDfzPtAvcOFiDpU+29XB6yp9FgamxdpDSayj?=
 =?iso-8859-1?Q?CbUiSU9gzu2HYKgW+KTL1ndezvyhUze5A0S2/Y/uV+GOFOnXCn4Td417kd?=
 =?iso-8859-1?Q?U9M8tG/fUxYsXK8KiNnIqlwGfZM0+coQ3rin5fO87uSve0wJiv9GG+tBFw?=
 =?iso-8859-1?Q?iOcNN9D8RYDmaaAWLRaOhlKVH9Cm3UwXfN9TuVsTakKD1F4gI2e1Q9Ll7V?=
 =?iso-8859-1?Q?5xqxx5teYBc4uc/z59Z5fJN6v/j+Yz5nWPNUl5qzGAZDj6YGUG5/Uim5SF?=
 =?iso-8859-1?Q?vDg5vMdNgjhVkHcNBUOqZeumjQ0Juw86a5DYUJ8oFWXiATB4nq5iwNxwux?=
 =?iso-8859-1?Q?7U8yxtZhqRWEObqANJvaTt4ag7gfI3BAA3JeTFKI6Ccv4+gO5ESk5ODHYU?=
 =?iso-8859-1?Q?II57giY1R2o1QG8g6q/eGOmtbh6R/Iw01HsH3rTuYWsmn90iNZ+Wj+gK3n?=
 =?iso-8859-1?Q?jqVyKJozVnQn3h4Fc569suEZi+Ag3s7nj9ZOT0S9rQrWPCKhMTI/I5KGN6?=
 =?iso-8859-1?Q?Cx8N2rAKmX3p64+Hwio7teBbvn65vj3XvQfqJ343Z7aRL4VLwzbX5TUzM9?=
 =?iso-8859-1?Q?ozt/Y/F9w+m5eQaotdc59kb51jYKovfZJdHwy1AJ2Pyh7m0Vj6vRit5WUb?=
 =?iso-8859-1?Q?qfPI3ZtMN+2B33USNi9zWMIhGGygkKKsYrVt2BP2hxoQK+iEtn1yeyFjFL?=
 =?iso-8859-1?Q?Ew51PAB6PHcIDoYpagxfBzayHrkOL3w0N2uA0fZCb4KOyOA72fUPnVMYe0?=
 =?iso-8859-1?Q?9d/K4IxqgoyRFDNKFO5XiAs7c7YcAlhQU60wq7NvMWef4/G+EnzY7agUlA?=
 =?iso-8859-1?Q?Bs5Y+978DB9ceJ/iEvlrmSd3kVIVb7Fd4GPFdAVkqkYBlNJqQe+lk8rGz6?=
 =?iso-8859-1?Q?UAtoXfYlR6NuGtwLvEReOYbCVx+RUtvMPHCskBRqEK+p2MwNBNmJRs+V1/?=
 =?iso-8859-1?Q?AtJP34KdHTMVW/ykpd0A4btGUA7gT6OYxprYZR126bCpi9vlr3aap5/ltX?=
 =?iso-8859-1?Q?2SCSkRX7Z9VkFuzup0z9FOzEEAsr+xPXuWM0U2+oN2HYv7+0XLNBOJ+Lqy?=
 =?iso-8859-1?Q?JGKkmHXtZrEssN0STPzIa4pyBmj6uKFxpfDJa9G7rC+B6Yd8GAm1WdtUqG?=
 =?iso-8859-1?Q?BmbgOuAAMDM45Hs+d9unL4oqpLATYxzkUBan35WKArkHPF/9ORk4pu5kyQ?=
 =?iso-8859-1?Q?98AOAwAvoH97h/Dizbeb2m6xMEMHwQ2TQ5Y75gFv/0SozNdLQVXVK0HSVy?=
 =?iso-8859-1?Q?hABPcCmPWcp6L7Tv4jNCekJmj0i+57ByRWtYlVqwlGsyoRQVc5DpnKiQPs?=
 =?iso-8859-1?Q?XczFmfTf69/SvEoh9z0souUyV10Pm+T5KUaoZh/1551OVbh4y9KRTgoHYc?=
 =?iso-8859-1?Q?k8gt2IWrVvg1WNPpN7P6ZcRP+qe2o2kzMPYPxfoODyBtg9VdlAVOmh3Ly2?=
 =?iso-8859-1?Q?V0LR2Cdz1pqDbCro7uBu1rHSOrMjWzF8toLPWBj6fdvwpTMzkRa7b9odzA?=
 =?iso-8859-1?Q?P+TNJMpf/Mk+TuCbDG3HLhseQj6uBtogcYufOg9D/WLA6Si3JxlkVvChEF?=
 =?iso-8859-1?Q?dl1VLaQ9qFdrq8EqMwth5IPmGyfyHteceejbkBuu4vbss0DDO7X7lvdNSv?=
 =?iso-8859-1?Q?4OSlHPt/UsVluBnb8W15rEOoXh9qz8oj4BY2/RYLeN6ms4lNebPIa1au0B?=
 =?iso-8859-1?Q?B7WzmjJVmX4h1+02LsJqTcNaFlvnnnPgwL/M8hoC0T/Lpp0aWDgkiJ5pwB?=
 =?iso-8859-1?Q?Gf1mX1uSOg=3D=3D?=
X-Exchange-RoutingPolicyChecked: J4YfzPoDWBO01TZ009zPxylOZPKwSGQDsbmkP4cpKPVKjCtsEBHkaDdtKhujiWPQhxSXbrYlL3tVbzfzpkSpcJ6qlql5cL3TM2Pk9W/yTAe5LX1UgOI3L15VexYujrFZM8hW9oZfVYOMahl16pC+/7pUNNvzQS9BMTUpfecUQrKNs5leBG4d+CyMNQDjSnLNjz5A26EJyid252CXZH6rQFsEyp6unP1E971CBv/fwlRKAG5ot8Mb5QpuJHbqm30eMGJok8GIvjkb23MqSy/9/YGrMgXwLmeOP0LURIYITas9zbeswPQYolHPn/xLxwWgiyyU2U7QePVFmXoIHso75w==
X-MS-Exchange-CrossTenant-Network-Message-Id: ac95e4a4-5270-4ff5-d8b9-08df39e80531
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 20:21:19.3840 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A6uhkhsi4Z4g6HKwFlzqaOZf+wNVwTolylITo+OqIW8YovHvFPbwmNgY1pvdgBi+fRuEDoweePwM7U1aZgqbCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5891
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

On Tue, Nov 03, 2026 at 07:00:24PM +0000, Matthew Auld wrote:
> On 11/07/2026 03:56, Matthew Brost wrote:
> > Add support for mapping a ttm_tt's pages using the IOVA-based DMA API
> > (dma_iova_try_alloc()/link()/sync()/unlink()/free()) as an alternative
> > to the scatter-gather list. An IOVA mapping is a single contiguous DMA
> > range, which is cheaper to walk and program than an sg list.
> > 
> > Whether the IOVA API can be used depends on the IOMMU mode, so the
> > decision is made once per tt at xe_ttm_tt_create() time and recorded in
> > struct xe_ttm_tt::use_iova. To keep the scope limited, only device BOs
> > that are not GGTT-mapped are eligible: dma-buf imports manage their own
> > mapping and GGTT bindings are programmed directly from the sg list.
> > dma_iova_try_alloc() may still fail, in which case the tt transparently
> > falls back to the sg list, which remains the default.
> > 
> > The IOVA reservation is allocated at tt creation and freed at tt
> > destroy. xe_tt_map_iova() links the tt pages (coalescing physically
> > contiguous runs) and syncs the IOTLB; xe_tt_unmap_iova() unlinks them
> > but keeps the reservation so the tt can be remapped without
> > re-allocating IOVA space. xe_tt_map()/xe_tt_unmap() dispatch between the
> > IOVA and sg backends, and xe_bo_dma_unmap_pinned() learns about the IOVA
> > case.
> > 
> > Consumers that walked the sg list via xe_res_first_sg(xe_bo_sg()) now go
> > through the new xe_res_first_tt() helper, which initializes either an
> > IOVA cursor (xe_res_first_iova()) or an sg cursor depending on the tt's
> > mapping mode.
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
> 
> 
> <snip>
> 
> >   static void xe_ttm_tt_destroy(struct ttm_device *ttm_dev, struct ttm_tt *tt)
> >   {
> > +	struct xe_ttm_tt *xe_tt = container_of(tt, struct xe_ttm_tt, ttm);
> > +
> > +	/*
> > +	 * Release the IOVA reservation made in xe_ttm_tt_create(). The pages
> > +	 * must already have been unlinked by xe_tt_unmap().
> > +	 */
> > +	if (xe_tt->use_iova) {
> > +		struct xe_device *xe = ttm_to_xe_device(ttm_dev);
> > +
> > +		xe_assert(xe, !xe_tt->iova_linked);
> > +		dma_iova_free(xe->drm.dev, &xe_tt->iova);
> 
> Do we know if this is allowed? I think there is xe_bo_pci_dev_remove_all()
> which requires that evict_all will correctly tear down iommu mappings on
> stuff like pci unplug and I don't think tt_destroy is called in that flow?

But unpopulate is called which unlinks / syncs (TLB flush for the IOVA).

> Does having the iova here cause issues? Also, for VRAM flow I think there is
> a tt_create() via pipeline gutting which will now create a new iova?
> 

Maybe we shuffle this around a bit so the iova alloc is tied to
populate/unpopulate. It was been a while I forget exactly why I did this
way.

> Aside from that, maybe we can land 27/28 as standalone?

Yes, let me extract these two into standalone patches today and
reworking if needed.

Matt
