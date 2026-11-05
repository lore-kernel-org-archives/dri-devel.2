Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5675606D801
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 00:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZE3r3ZEs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F9C010E4CD;
	Thu,  5 Nov 2026 00:49:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0A0E10E311;
 Thu,  5 Nov 2026 00:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793839754; x=1825375754;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=+QAuvJWSS858eZC8t0wJL+lGU/PrgH2Drn/IteGEC7M=;
 b=ZE3r3ZEsIfFCWz1PmV92EfWlXwPSU/wxnAHyT9/YG64A0K4/aq9A8bB+
 WrhuAVbvmfSUyR84S38+uQT41IRkRPush/jh7d32K1SHvC2fSKevMHWCQ
 4DD+lzR9ftgMD/uibWvnDEgcjd8rvvT28nSt5Bl45CTTJGsOSa0q4/w5t
 q0wfc3iHBTDcVjxNIWArm5jZN3gexfr5RgUbPiRfj44hkl5im9TsaywP8
 j1O+asapToclRUjnyfU3s1Kwfkv1DswqMqg5knCtQMBcFEpZ81VfySbyK
 fxVWnjCyoF8OpHXgtJ9gnY/464SC5V3NmlqBBbeGj8x4KNC9hOPNChvbF Q==;
X-CSE-ConnectionGUID: oJ4QDZQCRKONuTVb0M6OzA==
X-CSE-MsgGUID: RKXTBgQNQwiKK3iyMSMkWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2609804"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2609804"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 16:49:14 -0800
X-CSE-ConnectionGUID: isBfxj7IQ3qkegywJgi60A==
X-CSE-MsgGUID: ETh6k6/qRcSYRKeS74McJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="7173101"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 16:49:14 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 16:49:13 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 16:49:13 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.69) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 16:49:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lpo3y2zKAJj/jzkNmmGXrtYF280inP2z2dWNnwePtLdSMOwjZsw1gBa0R6E9KIXu6Zy7ACjV4LGDnZdPzUW0HyDcSgx7x1V0X0hvFvhKlcIV3JiUvzvvOWXfUKaEgWO+WdwF+LKDuXOMhekcanuBGfkFVDTHpM5fXJafQlQ4sMVjduyU0yar9091D2yP/gAjJql4/c5Gta72G1XJgXEmqIRc487qq+rYy3lWqza5WwIhKE6FOn2AsFLG5LSH+JYg6kNiCR6F4aDnOXaZSQiM4mpGK1Wvn3974nqiRTBkbWv9eLnaicFeNPDX4NrIoh7ObKHY2vNWgjMROP1UQQEMQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjE3O1RWL0D+8+0hrNKsiocButCVQ3xjy+8Bs3hAbgA=;
 b=XuOBSDbet1Sv8bx13OEgVXCeFT/M+vligc/I3I79g22N6BKsn4OnSg0bbUIJSpVWpRib6mMSMP8SvZQ36S0ZAiUOKH44TC7GPEpKDjqqYbPxoIXvViOuT8wdhsqO74Adz8EtSE5LcRzIprZG3P8aQrHC7Og6Sm+Lq9FsEFOQ1uy5HYm5MHRsGA6VRu+zedOXAqLR5a4S6El8Mv+8DV7p1BD/88pqIUwEY2P0v4zDByBahMewyr61F+iLYHtcNaikw+JckoRsHiivH4XhVJByVpQ92Crmi0cT9bLA427esXyXoFwsUPS0+gkYtfnF/lZA69jioENN40YAReUmGHs3OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by SA0PR11MB4559.namprd11.prod.outlook.com (2603:10b6:806:9a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 00:49:04 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0569.011; Thu, 5 Nov 2026
 00:49:04 +0000
Date: Wed, 4 Nov 2026 16:49:01 -0800
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 1/2] drm/gpusvm: Add a DMA-mapping accounting callback
Message-ID: <auvSfdjtHnHbq8FC@nvishwa1-desk>
References: <20261104215228.1533692-1-matthew.brost@intel.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261104215228.1533692-1-matthew.brost@intel.com>
X-ClientProxiedBy: SJ0PR13CA0092.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::7) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|SA0PR11MB4559:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e665e90-e395-49de-579d-08df3ad6969f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|18002099003|22082099003|6133799003|56012099006|11063799006|261022075727099003|261022105027099003|261026121527099003|261102123227099003|261026140227099003|261028144727099003|261021123027099003|261021121427099003|5023799004|261009223027099003|261009221227099003;
X-Microsoft-Antispam-Message-Info: ANu7JAG5FR6PHdKItN38E3SAYqcaMUPnGDOFyGiqEV2Wult0H+14tCt5XQuV2jDmG3WLZJAWma53JH0eCrN5Sy2TUviwKEqDfXS8vhsigXOyAJOaGV6R02DZPZtUvntpi4YuGEqo952ckb+Iv49ZAtH5O6ch93NCRmzbdckrFNG9rXacjOKvFrSznUkI0Izbw8ib5XgYBWnxORVOvBiWNlu9geBoivUw/hggDgfAl0fUmcMDinhiuNXbY4rBYJFNSCqNol+6UZV42aNow6jLYM/SSaGjuA/zyGnrEYZKjx9Hj7q69+3gfjLoQSXLOTnjc6DKQmm06nuITVYxym7UqKh0UHCggflUUBqKfHCVUt+hFxE2g6S+bqgG/nrXxiKkeTP0NWSAOeJtFbW4dZfAtBqLzWnlm+q4Tf/LYoe+RXY4MVgYLtwBHD6sAvxCGPy1+uo+UxkKqA8l9Hy474VQsoesHR8Cd/NBq2gDr7rMw6vRmZmZHK9EDhqKWqVq0ev4YQkI0sSwnfiPY3MXLxBr4Iybrttn3Jw35/lMZLFhexwvrDmWyobAGDiq+7PsbXI1pj8qOgOqSvC8rwhuPMcQ3bdagC5DgRwsZ5MqS7WQzGGd9M4HdxEpEZono8sNk7MsBdLtdXdCcXhmuYgPp0Ll6Y1QR74YcfzYemV5AcGBK9k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006)(261022075727099003)(261022105027099003)(261026121527099003)(261102123227099003)(261026140227099003)(261028144727099003)(261021123027099003)(261021121427099003)(5023799004)(261009223027099003)(261009221227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?wVOHBHA+TBCjj8ZzGU7f3FNb7OHA79OTAYXocb/5O9lc1bnSzAGPQCBP8c?=
 =?iso-8859-1?Q?AUycbgkpibmpbu5eyC6ohEuUWuNQeVuItWYDKkjVZmJk4FFukC7POVd8+j?=
 =?iso-8859-1?Q?yfFumDjptfs2EOfXU+XfbO8ryi0+w/FMD973+GMZq/WGqYzYVnObN0/UyM?=
 =?iso-8859-1?Q?CVKO0+3qHS1Y/Les5BXQXGOpykR9sEaygdQqV9tJDr5WJ7CclYHBxnNHTL?=
 =?iso-8859-1?Q?Pg13jVciLN27HndoMLkGlsPOL3fVUWyzKLP8pXxdixyDIYNkPhSuNrbaNX?=
 =?iso-8859-1?Q?A2t5blwvRTih34MDVJMx6Bi+wsWg2dWSAptFB0ml2urzXYMOcbO79n93Hb?=
 =?iso-8859-1?Q?1vxFciXfMPDnk+d9Ud0QHq2wdIodPO2m27dRNC6b8JOpY9CXvAr3djwMBO?=
 =?iso-8859-1?Q?QIrvja3454Zyf5o25C6r0qs+pPc3ja5cjwsaXeEAQO8yWwK4W4OE//maDM?=
 =?iso-8859-1?Q?RX4DwwWlER9yzZmhP0QlSXF2kPLdC8v5uO6JcSFvDoD2m5fT+beL1TwfLT?=
 =?iso-8859-1?Q?XoFnSsKqp0S0uKudGLcm6YX53anTFciwC62mIOYslZx+8VAQdhhOgFPse/?=
 =?iso-8859-1?Q?S2MaT0uhAtmWbGEXxUiSVaSNX1tH6mVUImkBt+GRC8s9Uxievqw2YTEifV?=
 =?iso-8859-1?Q?38pJPqh+snbxgiEMnJbIWxItldL1Qxc/HddGWpQR7lkfxpgu9o1e+7sZvE?=
 =?iso-8859-1?Q?RJSAIJ4nKeW8umbT0PvxMb2dHhi837I+j+yHY08jk7kmF5gYc3VirQaquQ?=
 =?iso-8859-1?Q?ysF870i20qizLahVyVOn3e7SmifL8sQvRjHEpawWIlN2VBL79SvUju3seN?=
 =?iso-8859-1?Q?zRHdsdr9mCWm9rpR8Io3aHrv31lVA5isK7tuCM8n2kAwZQ/8ft9u3HKol5?=
 =?iso-8859-1?Q?sHW+0y4ykw6Uc/KdAmsFSdgE2LfJVXENwYNExMiD8WPwOUy4o7bicni0VN?=
 =?iso-8859-1?Q?JYGHa1K4y5bVbHlF9gr2lTlSBX1OiZmmpgfWJ4bSD9HjyqUyf4yKdaYYaO?=
 =?iso-8859-1?Q?ZoSX4afSfXnt62LowGPiT0cR/BX3oQrDhR1+Y64kQabo8ofvqBGHMqRlne?=
 =?iso-8859-1?Q?t2Z5BV7Bly4V0t3sPOQ1lgpFZKIYntNPATbYqorEa+kHfDuTABYxLic8VN?=
 =?iso-8859-1?Q?n8mbQ/xPZWhXOjaaMuMB0p7Bhl6UbUmcv7jN+SWYFllI/5Tg+lnylajutD?=
 =?iso-8859-1?Q?nMR6i+7BFVvskmQ8H2T+WJZvqWnsUuSxBxs8AkYOUUgLnDIP0ibSVb7wUt?=
 =?iso-8859-1?Q?ctDiufNOZB02rNq1vbg7RmjyHHjYODR8vfIPSzTLamioWsYIf9L47hiJNX?=
 =?iso-8859-1?Q?IB19J0VqYg8dY2DSDBPObO9ejpLHnKyMYcs0OayBGrFNt1JIhCduaDsHxx?=
 =?iso-8859-1?Q?BBMSYWwtlgC4wMOP9ezNtg98FG4C3grdPOXCUhcATk/huxvI7rNBDcpYgi?=
 =?iso-8859-1?Q?TVj68qPHRl3UJDzCnpQ1b63NcrrHPeE0Sq4Or8er+6rHJhv2mUJrypV5kj?=
 =?iso-8859-1?Q?5SCtHHyPqgCFyiVrzZUrvnoDKOzi35JxD/v075kXT5/1mjIvzlnAHEcipl?=
 =?iso-8859-1?Q?0/yzcOvBbQEvkWafJa1OGTJiUwItch4pxXivWHOgqW2JuHmUVIGa+v0bsC?=
 =?iso-8859-1?Q?jWhpkXG1JYDlIkiJBvXo1lNmMIJ0BzbYVEWx6sULUcYekD0BHNx53POizk?=
 =?iso-8859-1?Q?I8HXxbYZKZyJOAtaY/7gjjY7qjlxVEGZcoMQ9nW3H4qkkoNklff2v0XoSV?=
 =?iso-8859-1?Q?rOf+uEGnB9OEkDwGbIp5ewKejYf+IuXe0IxTlyrVNlYbWBbmP66y8DXdRw?=
 =?iso-8859-1?Q?5p2KzNSJVQ7adCuqqXrWlEsDQxuDkIZxjSRpeK27XrG22z+BWR1W?=
X-Exchange-RoutingPolicyChecked: A1aE4r+TiWFrqFASWFynfaMFIfYYv6PNBqhk67RUmiAGS6Fbv3nYun2BsxUiPP1noDypmGduBi62+iBuxxdGXarJtOs+bk29zvXSwLh1bVTDAC9IgK4ePyT9lqFnsHREbHkc4Otr4VTKGUQQpBoxnvP9RY5JvFfANx+watzOYSnlmt6Ls+k30jCYoANBk1vkF/iQ0AFuzU4ZNH1gZCLktzS/GLcpODclyJSRc8NdJls1jQmgQc/YQ0WBEht7ltla5UStWk2ueGgDducZUbJ2iZKz7U4645DgEi0jDWNlcUzPfFmRolDsjml1T8LX6pp/kaWHjLdxVm/HxUvuV59org==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e665e90-e395-49de-579d-08df3ad6969f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 00:49:03.8096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BNicU7ldlje9ciEQxfWaeaxpK2YEN52JfXs13aL/UfZHlU/43/yRh4I5LJVLyAKPp8yLOHyDRligI0riJ/xOcxPCpOqO3+KOsls7r3DR8xo7dvxLjT3nTNqmKPmjbD7e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4559
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

On Wed, Nov 04, 2026 at 01:52:27PM -0800, Matthew Brost wrote:
>From: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>
>Drivers that use the GPU SVM core to DMA-map system memory for GPU
>access may want to keep track of how many pages they have mapped, for
>example to expose statistics or to detect leaks. Doing this accounting
>in the driver around drm_gpusvm_get_pages() / drm_gpusvm_unmap_pages()
>is error prone: the number, order and kind of the dma_addr[] entries can
>change between map and unmap (migration, partial unmaps, the iova vs
>non-iova paths), which makes symmetric accounting hard to get right.
>
>Add an optional @dma_map_account callback to struct drm_gpusvm_ops and
>invoke it once per &drm_pagemap_addr entry at the exact points where the
>entry is DMA-mapped (sign == +1) in drm_gpusvm_get_pages() and unmapped
>(sign == -1) in __drm_gpusvm_unmap_pages(). Since the map error path and
>every unmap/free path funnel through __drm_gpusvm_unmap_pages() for the
>entries that were actually mapped, the accounting is symmetric by
>construction. The callback receives the full &drm_pagemap_addr so the
>driver can use the order and the proto field to distinguish system
>memory mappings from device interconnect mappings.
>
>The callback must also be usable by the core drm_gpusvm_pages-only API
>(mm == NULL), as used e.g. for userptr-style mappings. Relax
>drm_gpusvm_init() to allow such users to pass a restricted @ops that
>only implements the page-level hooks; the full-SVM hooks (@invalidate)
>and the chunk configuration must still be unset in that mode.
>
>Assisted-by: LLM
>Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>Reviewed-by: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
>---
> drivers/gpu/drm/drm_gpusvm.c | 40 ++++++++++++++++++++++++++++--------
> include/drm/drm_gpusvm.h     | 19 +++++++++++++++++
> 2 files changed, 50 insertions(+), 9 deletions(-)
>
>diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
>index 03dbe304e4b8..5ef9d7233491 100644
>--- a/drivers/gpu/drm/drm_gpusvm.c
>+++ b/drivers/gpu/drm/drm_gpusvm.c
>@@ -503,8 +503,15 @@ int drm_gpusvm_init(struct drm_gpusvm *gpusvm,
> 			return -EINVAL;
> 		mmgrab(mm);
> 	} else {
>-		/* No full SVM mode, only core drm_gpusvm_pages API. */
>-		if (ops || num_chunks || mm_range || notifier_size)
>+		/*
>+		 * No full SVM mode, only core drm_gpusvm_pages API. A
>+		 * restricted @ops that only implements the page-level hooks
>+		 * (e.g. @dma_map_account) is allowed; the full-SVM hooks must
>+		 * not be set.
>+		 */
>+		if (num_chunks || mm_range || notifier_size)
>+			return -EINVAL;
>+		if (ops && ops->invalidate)
> 			return -EINVAL;

Other than 'invalidate' here, should we also check for other ops like
range_alloc, range_free etc?

Niranjana

> 	}
>
>@@ -1240,9 +1247,12 @@ static void __drm_gpusvm_unmap_pages(struct drm_gpusvm *gpusvm,
> 		struct drm_gpusvm_pages_flags flags = {
> 			.__flags = svm_pages->flags.__flags,
> 		};
>+		bool contiguous;
> 		const struct drm_pagemap_addr *addrs =
>-			drm_gpusvm_pages_first_dma(svm_pages, NULL);
>+			drm_gpusvm_pages_first_dma(svm_pages, &contiguous);
> 		bool use_iova = dma_use_iova(&svm_pages->state);
>+		bool needs_account = gpusvm->ops &&
>+			gpusvm->ops->dma_map_account;
>
> 		/*
> 		 * IOVA is reserved for the whole range but only the linked
>@@ -1260,14 +1270,18 @@ static void __drm_gpusvm_unmap_pages(struct drm_gpusvm *gpusvm,
>
> 		/*
> 		 * With IOVA and no device page the unlink above tore every
>-		 * entry down, and that is also when the range may be folded
>-		 * to one entry, which must not be walked per entry. dpagemap
>-		 * is set before the first device_map(), so it is also right
>-		 * on the error path, where the flags are not published yet.
>+		 * entry down, but the per-entry walk is still needed when the
>+		 * driver accounts the mappings. A folded (inline) mapping has
>+		 * a single entry describing the whole range, so it must be
>+		 * re-read for every iteration instead of indexed by @j.
>+		 * dpagemap is set before the first device_map(), so it is also
>+		 * right on the error path, where the flags are not published
>+		 * yet.
> 		 */
> 		for (i = 0, j = 0;
>-		     (!use_iova || dpagemap) && i < npages; j++) {
>-			const struct drm_pagemap_addr *addr = &addrs[j];
>+		     (!use_iova || dpagemap || needs_account) && i < npages; j++) {
>+			const struct drm_pagemap_addr *addr =
>+				contiguous ? &addrs[0] : &addrs[j];
>
> 			if (addr->proto == DRM_INTERCONNECT_SYSTEM) {
> 				/*
>@@ -1283,6 +1297,10 @@ static void __drm_gpusvm_unmap_pages(struct drm_gpusvm *gpusvm,
> 			} else if (dpagemap && dpagemap->ops->device_unmap)
> 				dpagemap->ops->device_unmap(dpagemap,
> 							    dev, addr);
>+
>+			if (needs_account)
>+				gpusvm->ops->dma_map_account(gpusvm, addr, -1);
>+
> 			i += 1 << addr->order;
> 		}
>
>@@ -1705,6 +1723,10 @@ static int drm_gpusvm_dma_map_pages(struct drm_gpusvm *gpusvm,
> 				(addr, DRM_INTERCONNECT_SYSTEM, order,
> 				 dma_dir);
> 		}
>+		if (gpusvm->ops && gpusvm->ops->dma_map_account)
>+			gpusvm->ops->dma_map_account(gpusvm,
>+						     &svm_pages->dma_addr[j],
>+						     1);
> 		i += 1 << order;
> 		num_dma_mapped = i;
> 		flags.has_dma_mapping = true;
>diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
>index 4d31c6bba745..637c19f7169f 100644
>--- a/include/drm/drm_gpusvm.h
>+++ b/include/drm/drm_gpusvm.h
>@@ -75,6 +75,25 @@ struct drm_gpusvm_ops {
> 	void (*invalidate)(struct drm_gpusvm *gpusvm,
> 			   struct drm_gpusvm_notifier *notifier,
> 			   const struct mmu_notifier_range *mmu_range);
>+
>+	/**
>+	 * @dma_map_account: Account a DMA-mapping change (optional)
>+	 * @gpusvm: Pointer to the GPU SVM
>+	 * @addr: The address descriptor of the chunk being (un)mapped
>+	 * @sign: +1 when @addr has just been DMA-mapped, -1 when it is being
>+	 *        unmapped
>+	 *
>+	 * Called once per &drm_pagemap_addr entry, when the entry is
>+	 * DMA-mapped by drm_gpusvm_get_pages() (@sign == +1) and when it is
>+	 * unmapped (@sign == -1), so the driver can keep symmetric accounting
>+	 * of the pages it has mapped for GPU access. The @addr->proto field
>+	 * can be used to distinguish system-memory mappings from device
>+	 * interconnect mappings. May be provided in both full SVM mode and the
>+	 * core drm_gpusvm_pages-only mode.
>+	 */
>+	void (*dma_map_account)(struct drm_gpusvm *gpusvm,
>+				const struct drm_pagemap_addr *addr,
>+				int sign);
> };
>
> /**
>-- 
>2.34.1
>
