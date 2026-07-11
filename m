Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03593C44501
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 12:40:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5822810E360;
	Sat, 11 Jul 2026 12:40:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YdKhDsUM";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4134510E1EF;
 Sat, 11 Jul 2026 12:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783773648; x=1815309648;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=4/Dk/nl+fgt7Q6GJLa/PA4Z0WvhZ6NKK1nLUXmrHgSI=;
 b=YdKhDsUM0x+cNVMTUqy/WqATk2GgWFfTGSZj8oRtyCDeJVcgHTtZfoJk
 UTM2wEtZoIvNy/6fxK4NFdVUlxKzdyjZcyb9rTACvuAa7wJIHjq84vwag
 kMbjsl43N9GYC2ztXDhGZIMphRoN8FMM38g3115Aqku1YxuEveGA5FFRB
 CEXrRBkId/5Xq6V2fdKUoiwPYVtE6CHS8bJs3wX/atG9sn0TKVM4GJoEM
 0khEXlgHt/hhb6tbpcOBdYEwh2iMtRHVwtSMxXxd2JPq1bFrQqhXkRMGP
 cM353gWTk+oftlDWAA0pNc5QySuhSp53dIzZSVA2t4FmqV6zAWbDW0hKw Q==;
X-CSE-ConnectionGUID: nEhUgi5lR2uTMGtXyRqmOw==
X-CSE-MsgGUID: JU8Lknb4SoiApledwI8jOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84504986"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="84504986"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2026 05:40:48 -0700
X-CSE-ConnectionGUID: f4EkRvvSS1yD97U+PgwLkQ==
X-CSE-MsgGUID: eDu5vbFmRLeOGz07U5rW5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="254622478"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2026 05:40:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sat, 11 Jul 2026 05:40:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Sat, 11 Jul 2026 05:40:47 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.52) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sat, 11 Jul 2026 05:40:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MR5t8SWaEJKs15pdHbSS9UChudU1Y61ApoIzLVr/t/sG6d03RG1350JFtqf1M1m1mePKxWpnWIRmt+TrKPiiUPspbu8R8Lq3wQ69PrSidGBdpgPFfCItZ7Zonzhqx37AoDkviEpR/WI7RN4vl2ObnVYB9miLJhm+Yv5c4/ROylQB8KQ96NYUMGCEMQ1RWTaoO1xK782FeCunPEzhuo9GoEdeIphe48jRQ48SgPnAjY8evQGQFHB8DKKhPfPa2z+95iqyirh4ir2c5nifxMrE1+xwQ3D0f8mFp2+M1Vbod602mD+/S0+fAfjd3pOYMA6qhaR+tbvdqvmyekFoGvXxEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRpWbPuCAKaHrwvcK3qT5JHTdwDgpodxlLMfeyLgKfA=;
 b=BTqUr9VCxLOggu+AOJmo5T1tbfVmDzPuF0JKZYQWBKhMv0Bu6FL+TrFMGGdKJ7uuepOQoz1lcKFVLiV8vUNUMS6c+/Os5LeSHQC9D1rw3mf59Kf7bKLRjGszGDV9NbomZa/A6oHnq+V/NJk6qBdxBvJ3pcWdTanke9VKeTjIcMtjF+8vLIvlerb0kHYM9m22OWx1O9Tq6SXUWVh87kWC5am7X0pllw7JvFsl4O3c794cFsjH/U8Tp9bkKB930YuDUB5imVOSOvljIGNLW2MoS2SbFykbZjRrUwC7g1O9Wpwb8YYivleRHLtqagldR7+p+yDvTJjedRpV93Flj+7LEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SA1PR11MB6966.namprd11.prod.outlook.com (2603:10b6:806:2bc::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.19; Sat, 11 Jul
 2026 12:40:42 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0181.017; Sat, 11 Jul 2026
 12:40:42 +0000
Date: Sat, 11 Jul 2026 05:40:39 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 "Huang Rui" <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 <linux-kernel@vger.kernel.org>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v2 02/33] drm/ttm/pool: Add ttm_pool_page_order_nodma()
 helper
Message-ID: <alI5xwo67h9oViGh@gsse-cloud1.jf.intel.com>
References: <20260710215442.2444235-1-matthew.brost@intel.com>
 <20260710215442.2444235-3-matthew.brost@intel.com>
 <7e1a098e-927e-4dc5-85fc-c7081c0c10c9@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e1a098e-927e-4dc5-85fc-c7081c0c10c9@amd.com>
X-ClientProxiedBy: MW4PR03CA0120.namprd03.prod.outlook.com
 (2603:10b6:303:b7::35) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SA1PR11MB6966:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d6040dd-71b6-4aed-bee3-08dedf499e94
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|6133799003|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: V6uazZQOzoo1yljsnp4Z8pEhETBL7mAA3g3Zmed7P2tcVg+p2QIMSQN5643L1Ijb+aIPsK3q0KREMKR1lDSZ88PG57hXef4/W4cZl5yx38dSOROaQlfBw+pcPiASBVrSeeqGVuIDcbTyhxgytISVS5t0HLINU2nVLC8vcDHuQhwwRG14/EkYTyRRDFsNSQcUudHGFw/97nSsn0OGhEBdUP70BJvdFKN7Jv9m6KqsAk/3xrGjQJWemVN+UNs1Gm/wU1uIbd/VVhqPML2pbARDAqM9l7GCYRSlVAo8cVHCKmEh11uVTmtQ4sjUtdLE+FbD1S8tBZ5cv6niR8hc3er4H4TgHhqyDlwxzGddl996LTECl+Chrlv296rBW5/CJ3iNqZFa+ajeqs1REy5rkD22Ain932UU/0SpOLGPjHgJTb/2VrFlxwBsnaIheZlG67r4CqDk3ivoHBH6eMU4LgKDz2hRQ8qsVzcqzmxk2cnn6Hto/wQA1M8JoHKur/+AQKA2ULwmVPVcQ3zLzzsQmzBG5HRR0nGJAH/n78/LJz5xhKO2f6hhrB/e7LxkRKJPw6ULypLLdrB0zSrxoITFTUjAzmauS1d4P08ACh2s5WwSGNhY7tGUPNSMZ4OO/fqSA8HfWR+akYWwMjjEnq/riOVq9SBOoUzSKvFFB76oF4yi+v4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(6133799003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?uoMwHJgdlvf8B9Akv9fK3LZF0LV6VLQOIZJVkST5ldaCeCxCr9ns6hUjOF?=
 =?iso-8859-1?Q?TylkLznUcXDNqZHwZyM0GF+96jqm+lk5MjpXRiWywIIAqmCk99DfPLBDoT?=
 =?iso-8859-1?Q?QvHD002hRm5hRJUtgN/7kjf1//rV6fBjgxPqViQXrxJpzSeUoJOH4Cp4s1?=
 =?iso-8859-1?Q?k00pp/H0qWKJ6zFxBzFkllVs+tIPxIVqLYWUMd0cuxdmZ5868VkQLPZ4pG?=
 =?iso-8859-1?Q?sb2YZ+pDUR5jD7WkPn0W2wToa0oW7ndbdITC9yD7a3fcUO/RfUo/0VmCYs?=
 =?iso-8859-1?Q?LcG6UXOcvSvGJLuInYvqOsEmz/WyubsBuHmR8Gkp/fft9UFJYBl99bBk2f?=
 =?iso-8859-1?Q?jIRai7cAnisNEgyuRFyGZgqYo67ZBOBNBK4jGlO0qs2bQqOCYTX7efeJtB?=
 =?iso-8859-1?Q?yZuvhrSyMtjwiDKz4gfGPI+92CAGtlfJC5/tqz9zPXMp0n+9Uzw4BT7Yrr?=
 =?iso-8859-1?Q?oRQ+YFbcl7UrNfvT6SZXq3Iz+3n12d1FxlGPzoiOpfviaKYg6wy3RSeZcc?=
 =?iso-8859-1?Q?t8UJfAnw4ypEFuz9wONSjNwQxIgIrLVpOUxWtrKGZhSqvHLuSlv8CbYzHj?=
 =?iso-8859-1?Q?2hC14d2kGdL55QI1tTU13Wu89hhrn9pWe82k6XhLN8Mhb1ziY6NQHO34we?=
 =?iso-8859-1?Q?yVcLFXbVBO0ret0ItGawdHGJeW1FF8VRSYpQkTjS8+ZvEnIJjWwZ4dKnpX?=
 =?iso-8859-1?Q?nfoV1A71mab6lnoDAP7nuKcUcuPqOnwt7qsz0jX9lfy0Pb1zjQCQY4R8+s?=
 =?iso-8859-1?Q?/Lbd+ELNn6BbHzZZU/fWUGoz8QObXag1ClUTF/Q0EbkeD32jpbsLUSHrwH?=
 =?iso-8859-1?Q?WackAcVT2cwoDuKgDdigm0HEieBNoi7mNkKBwXFzxNS1EExqXuwaNyykf3?=
 =?iso-8859-1?Q?5MY63B64JEsWGONn0WPgKKUdzm8Bx3hN8ITqS0V1Vm47IUYHYRXajoNZr1?=
 =?iso-8859-1?Q?I5zovMpvEz8oTWnsgQiq7A4VdQc961ib1R8ttF8iCFuuJSdrYY9ZS3C1HN?=
 =?iso-8859-1?Q?BGyhT7dSC6/Fy71Eo9pQpO36Ch04wce3ldgUsyJAK735G93dH0K+jHJvVF?=
 =?iso-8859-1?Q?tUOS+f7Xdjbm2ES154u501g/qeh2ropWYC7IpdFVSLqAPfFKV3WkaaDbZq?=
 =?iso-8859-1?Q?6m9UVvQpdkWf/1u3vgd10wIvxmhhIyVGalQZ0zege+okjIuSnJI32Dldyf?=
 =?iso-8859-1?Q?z+/otQuGIV1qt1yDlfYc2Am1xb6uUeQ1tAR1jUiaiZNI2y6GRQn3S1X4/z?=
 =?iso-8859-1?Q?w6vncOJBNQPoGQ67XC3xK3AcZSLVBSTUngZK9FymOPJ8+x8TfUBnoPqEGe?=
 =?iso-8859-1?Q?OO/qCW1TW2l0nCovGnGrcfmXOJfjAuvY/x85cGAwKCIPsthHQccKoKZflo?=
 =?iso-8859-1?Q?AK/XU6fUKG6SK8HGe0l9NpfCSzgvhrR8I+Jk3GYjC2/ZnNWzb5+eFU4Tf0?=
 =?iso-8859-1?Q?ork/6qxab2BfohwYJsjc5Ckw5X0HienGT4qhxx2FoCvTVY7KA/Mf1RWc/p?=
 =?iso-8859-1?Q?Jht5VIot/y6PEpNMUxDhcr0plIyQrYdxYunoayrCw6z2O2LrP1KAOUTvBG?=
 =?iso-8859-1?Q?AL6LKIlklM5PJzdYAk64/VLor6pdd6bL3JBLQWlTHnAqaqCmJGdC6B9hEy?=
 =?iso-8859-1?Q?IvYxTqA+FowzIw3zIUpVODp4B9cAk6XYMI/yOU9g3rD8YDHpo91OKdL+IA?=
 =?iso-8859-1?Q?R5N0DZ62b5TDRF9Sy6eZy961MU8aAkM8JdLxPpf7pdmGaFad3lq5qLoRhJ?=
 =?iso-8859-1?Q?AO7KGCl9SZUQz26vVISBlvEicPiU9uLCNfjn21tUfvCpPW+a79oq0NKNi3?=
 =?iso-8859-1?Q?H8qqeCtI3w=3D=3D?=
X-Exchange-RoutingPolicyChecked: VvivWm0ZUnh64VzbkwVGHUnnmdpzbohJcmIeVfa5aXUbSJt7B7JjvnDONdHX1j8EScb3xvkoa9AfPfAUT+0NPQIbUjibDH5INrC+K4mfrLtIcGAINSj/udt8MICmlofFlabtNSgsF1qWWY+zfK6lX033f4ZA0junYPtuISCUwpRuVnunnGnZkh8Bb3KLPaGlc5oN4VsPvq9RwHLdXhgRKqHYq54RFoKNvdIg7vgo54rVzacpSCfQzRRd2UlKkmKc7NE5ixujqeSG9ZULuQr8kXLLBpwIPESCtNX5fAgzsN4B2puUprUIiqYckuHjJvU1M+98JFEbTB+htkV5hBTOvg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d6040dd-71b6-4aed-bee3-08dedf499e94
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2026 12:40:42.2640 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GibBx8Q+cQi39d7vK+SYiMGQASFZz/2dIVT27Nn7BjFozhVwgNKIDOp79WTEaIjhhjlkfd8frJp/WVEKXwIkRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6966
X-OriginatorOrg: intel.com
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Sat, Jul 11, 2026 at 12:39:38PM +0200, Christian König wrote:
> On 7/10/26 23:54, Matthew Brost wrote:
> > TTM records the allocation order of a multi-order page in page->private at
> > allocation time. For pools that do not use dma_alloc the order is stored
> > directly, while dma_alloc pools store a struct ttm_pool_dma pointer there
> > instead. Drivers that do their own DMA mapping (e.g. Xe) need the per-page
> > order to walk a populated ttm_tt one chunk at a time, but cannot rely on
> > folio_order(): TTM allocates high-order pages with alloc_pages_node()
> > without __GFP_COMP, so they are not compound and folio_order() always
> > returns 0.
> 
> Well what is the justification of XE doing the DMA mapping themselves?
> 

This maps to `TTM_ALLOCATION_POOL_USE_DMA_ALLOC`, which is clear in Xe, so
we use this helper function to determine the page order in various
places. I exported this because I'd want to have fish out the pool and
use ttm_pool_page_order.

That said, Xe also owns the DMA mappings. To be honest, I didn't realize
`ttm_sg_tt_init()` was commonly used, but having Xe manage DMA mappings
has several advantages (I believe we inherited this part from Faith /
Dave PoC work on Xe):

- Using an SG list or IOVA allocation gives smaller pages a contiguous
  address space, which can then be mapped using larger GPU pages.
- SG list or IOVA mapping requires only a single IOMMU sync for a
  collection of pages, whereas each `dma_map_page()` or `dma_unmap_page`
  call requires its own IOMMU synchronization.
- Using IOVA mapping (later in the series) allows individual page
  linkages to be replaced without modifying the IOVA programmed into the
  GPU page tables.

The second point is a fairly significant performance issue. I recently
switched GPUSVM over to `dma_iova_alloc()`, and if I recall correctly, a
chain of mappings with a single synchronization was roughly 100x faster
than individual `dma_map_page()` calls for a 2 MiB region backed by 4 KiB
pages.

It should not be quite as severe in TTM, since it generally does not use
lower-order pages, but mapping something like a 32 MiB BO will still be
significantly faster when using an SG list or IOVA allocation.

The TTM core should really be fixed in this area, or drivers should at
least be encouraged not to use this path, since implementing the mapping
on the driver side is fairly trivial.

Matt

> Regards,
> Christian.
> 
> > 
> > Expose ttm_pool_page_order_nodma(), a thin wrapper that returns the order
> > recorded in page->private. It is only valid for pages from a pool that does
> > not use dma_alloc; whether a TTM device uses dma_alloc is fixed at ttm
> > device init time, so callers know from their device configuration that this
> > helper applies. Use it from the existing internal ttm_pool_page_order() to
> > keep a single source of truth.
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
> >  drivers/gpu/drm/ttm/ttm_pool.c | 25 ++++++++++++++++++++++++-
> >  include/drm/ttm/ttm_pool.h     |  2 ++
> >  2 files changed, 26 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> > index dbe977412a81..d34592d4dbc7 100644
> > --- a/drivers/gpu/drm/ttm/ttm_pool.c
> > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> > @@ -461,6 +461,29 @@ static unsigned int ttm_pool_shrink(int nid, unsigned long num_to_free)
> >  	return num_pages;
> >  }
> >  
> > +/**
> > + * ttm_pool_page_order_nodma() - Allocation order of a non-dma_alloc TTM page
> > + * @p: The page to query.
> > + *
> > + * Return the allocation order that the TTM pool allocator recorded in
> > + * @p->private at allocation time. This only works for pages that were
> > + * allocated from a pool which does *not* use dma_alloc (i.e. pages backed by
> > + * alloc_pages_node()), where TTM stores the order directly in page->private.
> > + *
> > + * For dma_alloc pools, page->private instead holds a struct ttm_pool_dma
> > + * pointer and this helper must not be used. Whether a TTM device uses
> > + * dma_alloc is fixed at ttm device init time, so callers are expected to know
> > + * from their TTM device configuration that their pages are not dma_alloc
> > + * backed before using this helper.
> > + *
> > + * Return: The allocation order of the page.
> > + */
> > +unsigned int ttm_pool_page_order_nodma(struct page *p)
> > +{
> > +	return p->private;
> > +}
> > +EXPORT_SYMBOL(ttm_pool_page_order_nodma);
> > +
> >  /* Return the allocation order based for a page */
> >  static unsigned int ttm_pool_page_order(struct ttm_pool *pool, struct page *p)
> >  {
> > @@ -470,7 +493,7 @@ static unsigned int ttm_pool_page_order(struct ttm_pool *pool, struct page *p)
> >  		return dma->vaddr & ~PAGE_MASK;
> >  	}
> >  
> > -	return p->private;
> > +	return ttm_pool_page_order_nodma(p);
> >  }
> >  
> >  /*
> > diff --git a/include/drm/ttm/ttm_pool.h b/include/drm/ttm/ttm_pool.h
> > index 26ee592e1994..753203980e2c 100644
> > --- a/include/drm/ttm/ttm_pool.h
> > +++ b/include/drm/ttm/ttm_pool.h
> > @@ -94,6 +94,8 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *ttm,
> >  int ttm_pool_restore_and_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> >  			       const struct ttm_operation_ctx *ctx);
> >  
> > +unsigned int ttm_pool_page_order_nodma(struct page *p);
> > +
> >  int ttm_pool_mgr_init(unsigned long num_pages);
> >  void ttm_pool_mgr_fini(void);
> >  
> 
