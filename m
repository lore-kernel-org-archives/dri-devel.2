Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B476606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 02:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HBwv15nX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8864B10E1B3;
	Thu,  5 Nov 2026 02:50:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEBA910E1B3;
 Thu,  5 Nov 2026 02:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793846996; x=1825382996;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=qRgIQLOsv4KTlpFCOwv+NfGOpF+oz3WpsXy8CzUdZKk=;
 b=HBwv15nX4cHNQFw4w/xOq600lx8xma7hH8/izyyeSlWUidf+0BMLKqQJ
 cJTPRDoAYeNVh7sHmP8KcGtnx+J//z3bh2l6XIqII3x3A/9sT630cDRqU
 tTgJf7twzpTmMa/lgWV4wxfmR0cGARvYXrp5+BEOQsDZ3D0WXH6ZozmMg
 ZMIOeDVs0necrK0V7jlEbUypNY7jV77/wDGxmTd5ZQ6TucBKI00p2Vliw
 sgIP2S97iuGWsJgzcCzgiBn0YO6lqkOD9Njk/4yVMkiM+x7/wkNHsCSj8
 yuwRG0Wk24rdkuW91wguwpfavU4wbfr4d2LunxtbRas66YOlpBqjrYHVE w==;
X-CSE-ConnectionGUID: /vcpxleuStOzTNFO2oHahg==
X-CSE-MsgGUID: XM7tTXFrSfuGeD/UsJ/SNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2626766"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2626766"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 18:49:56 -0800
X-CSE-ConnectionGUID: xIaSfto5TlutqmmsJIqkRA==
X-CSE-MsgGUID: J9beepZvRUGMeoZN+7lwRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="8743126"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 18:49:56 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 18:49:55 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 18:49:55 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.40) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 18:49:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9Ju5gpebA54REYYdWyd5FT6XFmj+3EsW04SKGjLq5lZFf0kEWZ1EDDDsNVD37hatddcPx7XSZqN2ce9Q7Szhx146V3rHLMgaocvNsScHazZmN2TVRMQM6uJlJjFWig4RmLzBcpEQbU/UXBFCYIZZVlFLFZtyTr+axVsN2KLdBCrn02Kk08qp9DmSo4NjNeI0aD4VyeM2/IINDKaQQfmsKGksNfvS1LACQG56SRacWoiPZpOnPm8gP2jvt/WBD9FiMmxPnoMlhyOgus7LKpC2lTsQRhwouFmoJHNNdMW3l18sjusXzZQjLxCVug4LLQebYh+Xd1BKAE26X5hby8LwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLGmekgjehjpM4k3mLmBncWU4bmzK++1lHnxUGsI7Is=;
 b=bQIyFgtYf9wonBmp9o7vFZM1TRGQVOayMdjjb0TKpEOO4N8b1QVtl/J0nf8MKIHKh8VMQzjcafVWPsicfI8e3f9bLzbVpxmxrut7bT00kj/zB9cgYdWr6laOMeM6OiacyX8lxqtNllQ+SRzL9akzzLWHld18rtbXkAmFdvmQtUXwPTt0bRsvGauAdfYOHCFCxe+6TTz/vIne18TGFqY5anIeG5H7ebCnZuBlQLimUAZJQTEZzJ7CGtS6NIY8nz/eLcP/hU2R+cQwI6yEIx29nHMl2j5SWkKoOBWpD+ulwuENtYWk6ona4SXd4DgZEImHeqJx6NLyz9kv+qJC3p2JlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by SA1PR11MB8373.namprd11.prod.outlook.com (2603:10b6:806:38d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 02:49:52 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 02:49:52 +0000
Date: Wed, 4 Nov 2026 18:49:50 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 1/2] drm/gpusvm: Add a DMA-mapping accounting callback
Message-ID: <auvuzoZz1xpKkeRI@gsse-cloud1.jf.intel.com>
References: <20261104215228.1533692-1-matthew.brost@intel.com>
 <auvSfdjtHnHbq8FC@nvishwa1-desk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <auvSfdjtHnHbq8FC@nvishwa1-desk>
X-ClientProxiedBy: MW4PR04CA0203.namprd04.prod.outlook.com
 (2603:10b6:303:86::28) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|SA1PR11MB8373:EE_
X-MS-Office365-Filtering-Correlation-Id: ad6d0b8f-8dcf-437f-36fb-08df3ae77783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|6133799003|10067099003|22082099003|18002099003|56012099006|11063799006|5023799004|4143699003|261021123027099003|261009223027099003|261026121527099003|261102123227099003|261021121427099003|261028144727099003|261009221227099003|261022075727099003|261022105027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: +1icFR9Zl+fKyMNA/BCNecDUgPGGEHsDXBuMd0Lq7iN6/GRxN1ylEEpblC1Lb5WDj8pPbxzVrNR7FKJBC2YXsvlCr224yWTLZ7SRKKFLtY7sY6iAo5PJIJAvK9QD6i00Hs/Dbz4r9+1cMhUh83/yAkn6TvO3s9d/xJaTKqAxEwhS9zP6XY+YMODZChxlqpHN551GGZiVGMM0Cl6qDLzcElCb0IS+EcvyPKQrL+6eIV/Vx2wtKQ1IyH5G1O21svRpBnDPmrrHh6OoFmQq+SIl79Djj9wCYowhtEsS0riuAH2983nSZHGHwmqKNJxSz1+7GF3MZGR08kLmbcYNBYIFJ8NWRdE10TrbXMKeuQrPhUgOzshsRxSL2e+YIV3VLiKQ0xRs6L1yDyI54k/9rCnkxxWN/YQOdNC2KdRFWrUikDmUw72BTPO05pufe41qHWmUWfrD9oWvpnsqs9Fj4iLfAEjOV+K97xxOOS6+/hwIJ7ZmYty2hTHkFmMUh2hENFTth5SSBst57y6bqTZOy1OH15GUF/nsMmpWNx5tmzM6uIEoqO4i9tHO185isbNeM2Z8J20oBUvtbwZbZ0WBeIJM2l5otRF4YNMEraRcYmRyPnsUDp7RHEmfmsaEzKw5U0zo2Ifl5Sz0J3098aXzhhCZrTHtKpdy0QMOp+i45p7wmmU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(5023799004)(4143699003)(261021123027099003)(261009223027099003)(261026121527099003)(261102123227099003)(261021121427099003)(261028144727099003)(261009221227099003)(261022075727099003)(261022105027099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?VQGKnj4LzWz8xNv2DQG4pozPkuFAChrHXxug3xAqkrz3OxgkYo2pJFBWPh?=
 =?iso-8859-1?Q?Hl0G05MGjiOQIVIPtxeLbfWYjo+hSfPRjaKVAlOVlYpnkHYmdopU8l7h1f?=
 =?iso-8859-1?Q?CuoPD1ZzG2g7lNG1PUW+tve/pBBIh2PPytWEs16rhuwz/yt0IcuuQq/3iC?=
 =?iso-8859-1?Q?p6TybXQ5W/M5VBjnLbzaFTdt8XWIMXWD60436dAFIX/0aUw/r6TBprLn0D?=
 =?iso-8859-1?Q?fn6VUlKjAwFVGXe/G/nA+MLJfIRIkHOnMAc2dnDTUoJ0XbnNS5RFrGy8y6?=
 =?iso-8859-1?Q?FROJjz8JVM59d84APbv1IROY/nWcuHAW6rfuKxUqysocDB9ZdUTohaZM81?=
 =?iso-8859-1?Q?L5YEt8fu87WsGb6jVi3YJvt/a9Ut/x+G9fBLsk72aENCUxI8ToeW31MAeG?=
 =?iso-8859-1?Q?m27qdKnXGy3z9bUaMaWK5XFFuAzZnwyfUEtY4nhdHDc7t+Dec91WdNIptH?=
 =?iso-8859-1?Q?qcUIrYHpYGgytxnhCcNxsNTjVdoECmiDswrnIy2XdOUEAHhqlScIsdUBdf?=
 =?iso-8859-1?Q?dvS7U6qy84IYbkTVTGo5YpTwfCfnVRlUG+ngE0/e9wYVtPr1ONXc+DkAWr?=
 =?iso-8859-1?Q?2jKfV7AVPkScPZVa1sIzJDOk/TJGnlYKs/zjNRlL/QdQrUFdac1ZdctgT4?=
 =?iso-8859-1?Q?fendbdyvkAFrlVJ4YNZnDPxKw/Bx526000fsPj1jslu26TVh/1Z73UD0Yb?=
 =?iso-8859-1?Q?tj/bnsU7u4ZdE/PAOHOfreB+uAJorW6AkIe6ept53iJV42P3McTZdcFYC/?=
 =?iso-8859-1?Q?u8lhsrvp6ubGAoOaNZTlf2bchaJPrJw6+6tVctD73FM893V5VT9LkUHYW5?=
 =?iso-8859-1?Q?8RfPIAep8ToqdEJLf2Q/C/ZgTPaC2ZBydf/22NIWYhXre4TupgJqsfmvUO?=
 =?iso-8859-1?Q?oGeumPq75C/aEh2I+1l9U+WK/TKBs53NdfUYm+suTfrMJBcDd4dXQ1Km2/?=
 =?iso-8859-1?Q?/Fh3LpDYJkjktCrxWDylVboML4YRDdpZqF9dKTS6id/BsRPCWnFThxAn+t?=
 =?iso-8859-1?Q?TDfSwPuXxmhz2tgA2C5nDa3zRDhY/HfGdCoSblmrgI6WS89H/oCBEKjbnQ?=
 =?iso-8859-1?Q?viEmA1+MXq3ka4eqX6lTOJ3IPPYMaDAMrHO3pX3Bc0KITBRs8YQJl9vFSz?=
 =?iso-8859-1?Q?o0hocxEf+93YwkJhvfHDJkui9j9r4gt6k+XDQt7303lT85UXHNtWQ6SY8A?=
 =?iso-8859-1?Q?QG5lEjwBrvL0neA3ccSHpGMw3f8tIIrWhO4ydfclNZUziXkJR3NxNZYnuW?=
 =?iso-8859-1?Q?FabO8l99+RgwPoZW9fKcuwwfrgsY39rBT/0ZsWZ+KA7gkggkxH/NrzOIUd?=
 =?iso-8859-1?Q?b+800qrSWn70RqiqLXlPr+Vn1DlZeLVXi07jYgXv/AuHd6hG3Wvy+v/na4?=
 =?iso-8859-1?Q?CE02dlP2ewODODPoQU73mDNgvQGrohQMDS1eJYz31yGhOWwpIpByh0x9bu?=
 =?iso-8859-1?Q?OFntfpWedzH4kZAua2OHVrQs5c4Y7f+vrCWXL/5i16b1Eq7RwQUJDEim7I?=
 =?iso-8859-1?Q?N/1yyZsXvTX8Oh2bvwoLtHSiT6WWODzJNRMh8MmsVR1f6JmSCnCX2qoaGo?=
 =?iso-8859-1?Q?HvyD5y6w7+625+u5mafzvBilmZQr7DxHMCxMLKPh7ghZTXHPqjhWFNDMAn?=
 =?iso-8859-1?Q?rnq1SxmHqlMINJAFWlEeBxwecAg4X+XLmxeBXqmA+zs7YPFPZJs6koorxa?=
 =?iso-8859-1?Q?kiXNXWmaO9b4y/3VihkPf3TjkkoeGVN5+/1NPCiuyNps+Z5q13S333esQo?=
 =?iso-8859-1?Q?wHP38EhCCe3jzJY1nuP8V+lD2Hbu21j7zQw7/piIzYDnwI0eXdXRe7RCrh?=
 =?iso-8859-1?Q?6gxqSKhvww=3D=3D?=
X-Exchange-RoutingPolicyChecked: QUx5SgX3oESdL9sXS/dtpBP3brWCAl6hYafoYWNQThmsBUwB4aHCdHTnZ67YLSGWYHIS5zBx6/mzlBLOeqT3cIjgvCGN3r8Ie2QrpRJmvSRX797HJNzuxMlTUYZ1IoOIeLfLmuE6/qdvCda4r5L4EVjG8JYH0QbZg8OLlDt98Rdbzw1Jd59i3lDgShhdxb3T2UFnkWok1YAPqawOR8mwwCU9+Ij27y+tkV7n1X3BeHwZ20TQmNfm+xCVBRBFpQF//RYYy8sSGL6EZh0uCDyQp3Lc5zAA5PZe5J0QVPOTKz1Fmx7U0a3vK66gITiSD0phFdFhBIKrKUqovfmIATj6UQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6d0b8f-8dcf-437f-36fb-08df3ae77783
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 02:49:52.8382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NL45mjfLWBLWW13OotDLL8EuqLor/xARCqIszPjQP3q9RERjURocZ6Wa/a6hpCfY11FZNHQNLptbWzKwzKrgmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8373
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 04:49:01PM -0800, Niranjana Vishwanathapura wrote:
> On Wed, Nov 04, 2026 at 01:52:27PM -0800, Matthew Brost wrote:
> > From: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > 
> > Drivers that use the GPU SVM core to DMA-map system memory for GPU
> > access may want to keep track of how many pages they have mapped, for
> > example to expose statistics or to detect leaks. Doing this accounting
> > in the driver around drm_gpusvm_get_pages() / drm_gpusvm_unmap_pages()
> > is error prone: the number, order and kind of the dma_addr[] entries can
> > change between map and unmap (migration, partial unmaps, the iova vs
> > non-iova paths), which makes symmetric accounting hard to get right.
> > 
> > Add an optional @dma_map_account callback to struct drm_gpusvm_ops and
> > invoke it once per &drm_pagemap_addr entry at the exact points where the
> > entry is DMA-mapped (sign == +1) in drm_gpusvm_get_pages() and unmapped
> > (sign == -1) in __drm_gpusvm_unmap_pages(). Since the map error path and
> > every unmap/free path funnel through __drm_gpusvm_unmap_pages() for the
> > entries that were actually mapped, the accounting is symmetric by
> > construction. The callback receives the full &drm_pagemap_addr so the
> > driver can use the order and the proto field to distinguish system
> > memory mappings from device interconnect mappings.
> > 
> > The callback must also be usable by the core drm_gpusvm_pages-only API
> > (mm == NULL), as used e.g. for userptr-style mappings. Relax
> > drm_gpusvm_init() to allow such users to pass a restricted @ops that
> > only implements the page-level hooks; the full-SVM hooks (@invalidate)
> > and the chunk configuration must still be unset in that mode.
> > 
> > Assisted-by: LLM
> > Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > Reviewed-by: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
> > ---
> > drivers/gpu/drm/drm_gpusvm.c | 40 ++++++++++++++++++++++++++++--------
> > include/drm/drm_gpusvm.h     | 19 +++++++++++++++++
> > 2 files changed, 50 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> > index 03dbe304e4b8..5ef9d7233491 100644
> > --- a/drivers/gpu/drm/drm_gpusvm.c
> > +++ b/drivers/gpu/drm/drm_gpusvm.c
> > @@ -503,8 +503,15 @@ int drm_gpusvm_init(struct drm_gpusvm *gpusvm,
> > 			return -EINVAL;
> > 		mmgrab(mm);
> > 	} else {
> > -		/* No full SVM mode, only core drm_gpusvm_pages API. */
> > -		if (ops || num_chunks || mm_range || notifier_size)
> > +		/*
> > +		 * No full SVM mode, only core drm_gpusvm_pages API. A
> > +		 * restricted @ops that only implements the page-level hooks
> > +		 * (e.g. @dma_map_account) is allowed; the full-SVM hooks must
> > +		 * not be set.
> > +		 */
> > +		if (num_chunks || mm_range || notifier_size)
> > +			return -EINVAL;
> > +		if (ops && ops->invalidate)
> > 			return -EINVAL;
> 
> Other than 'invalidate' here, should we also check for other ops like
> range_alloc, range_free etc?
> 

Yes. Let me fix that.

Matt

> Niranjana
> 
> > 	}
> > 
> > @@ -1240,9 +1247,12 @@ static void __drm_gpusvm_unmap_pages(struct drm_gpusvm *gpusvm,
> > 		struct drm_gpusvm_pages_flags flags = {
> > 			.__flags = svm_pages->flags.__flags,
> > 		};
> > +		bool contiguous;
> > 		const struct drm_pagemap_addr *addrs =
> > -			drm_gpusvm_pages_first_dma(svm_pages, NULL);
> > +			drm_gpusvm_pages_first_dma(svm_pages, &contiguous);
> > 		bool use_iova = dma_use_iova(&svm_pages->state);
> > +		bool needs_account = gpusvm->ops &&
> > +			gpusvm->ops->dma_map_account;
> > 
> > 		/*
> > 		 * IOVA is reserved for the whole range but only the linked
> > @@ -1260,14 +1270,18 @@ static void __drm_gpusvm_unmap_pages(struct drm_gpusvm *gpusvm,
> > 
> > 		/*
> > 		 * With IOVA and no device page the unlink above tore every
> > -		 * entry down, and that is also when the range may be folded
> > -		 * to one entry, which must not be walked per entry. dpagemap
> > -		 * is set before the first device_map(), so it is also right
> > -		 * on the error path, where the flags are not published yet.
> > +		 * entry down, but the per-entry walk is still needed when the
> > +		 * driver accounts the mappings. A folded (inline) mapping has
> > +		 * a single entry describing the whole range, so it must be
> > +		 * re-read for every iteration instead of indexed by @j.
> > +		 * dpagemap is set before the first device_map(), so it is also
> > +		 * right on the error path, where the flags are not published
> > +		 * yet.
> > 		 */
> > 		for (i = 0, j = 0;
> > -		     (!use_iova || dpagemap) && i < npages; j++) {
> > -			const struct drm_pagemap_addr *addr = &addrs[j];
> > +		     (!use_iova || dpagemap || needs_account) && i < npages; j++) {
> > +			const struct drm_pagemap_addr *addr =
> > +				contiguous ? &addrs[0] : &addrs[j];
> > 
> > 			if (addr->proto == DRM_INTERCONNECT_SYSTEM) {
> > 				/*
> > @@ -1283,6 +1297,10 @@ static void __drm_gpusvm_unmap_pages(struct drm_gpusvm *gpusvm,
> > 			} else if (dpagemap && dpagemap->ops->device_unmap)
> > 				dpagemap->ops->device_unmap(dpagemap,
> > 							    dev, addr);
> > +
> > +			if (needs_account)
> > +				gpusvm->ops->dma_map_account(gpusvm, addr, -1);
> > +
> > 			i += 1 << addr->order;
> > 		}
> > 
> > @@ -1705,6 +1723,10 @@ static int drm_gpusvm_dma_map_pages(struct drm_gpusvm *gpusvm,
> > 				(addr, DRM_INTERCONNECT_SYSTEM, order,
> > 				 dma_dir);
> > 		}
> > +		if (gpusvm->ops && gpusvm->ops->dma_map_account)
> > +			gpusvm->ops->dma_map_account(gpusvm,
> > +						     &svm_pages->dma_addr[j],
> > +						     1);
> > 		i += 1 << order;
> > 		num_dma_mapped = i;
> > 		flags.has_dma_mapping = true;
> > diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
> > index 4d31c6bba745..637c19f7169f 100644
> > --- a/include/drm/drm_gpusvm.h
> > +++ b/include/drm/drm_gpusvm.h
> > @@ -75,6 +75,25 @@ struct drm_gpusvm_ops {
> > 	void (*invalidate)(struct drm_gpusvm *gpusvm,
> > 			   struct drm_gpusvm_notifier *notifier,
> > 			   const struct mmu_notifier_range *mmu_range);
> > +
> > +	/**
> > +	 * @dma_map_account: Account a DMA-mapping change (optional)
> > +	 * @gpusvm: Pointer to the GPU SVM
> > +	 * @addr: The address descriptor of the chunk being (un)mapped
> > +	 * @sign: +1 when @addr has just been DMA-mapped, -1 when it is being
> > +	 *        unmapped
> > +	 *
> > +	 * Called once per &drm_pagemap_addr entry, when the entry is
> > +	 * DMA-mapped by drm_gpusvm_get_pages() (@sign == +1) and when it is
> > +	 * unmapped (@sign == -1), so the driver can keep symmetric accounting
> > +	 * of the pages it has mapped for GPU access. The @addr->proto field
> > +	 * can be used to distinguish system-memory mappings from device
> > +	 * interconnect mappings. May be provided in both full SVM mode and the
> > +	 * core drm_gpusvm_pages-only mode.
> > +	 */
> > +	void (*dma_map_account)(struct drm_gpusvm *gpusvm,
> > +				const struct drm_pagemap_addr *addr,
> > +				int sign);
> > };
> > 
> > /**
> > -- 
> > 2.34.1
> > 
