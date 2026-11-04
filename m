Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A887606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 04:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dpsLGJYl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C668A10F99F;
	Wed,  4 Nov 2026 04:10:59 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4CDB10F99F;
 Wed,  4 Nov 2026 04:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793765454; x=1825301454;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=azZi5xI7LwOmzH7C2LJ2WsOTrwUiHaSy4+Az9IanSc8=;
 b=dpsLGJYlZG5yXsxINbrR3/buwB0M95qnMiH8SwMDoNBPkwYuamkxe7io
 p457cPxFlJgBteiiOiQV8HveZlyW1UuOIZXWaOTObhQ1SaEk2uIAyj/kt
 QSvwg287XhrSBOxn/yPLRq0EClGaVrBzcZDw9VrEAc/g38bM3yik98Pcv
 3B/wSqWmYanvNi+WjPbsxWJw+SErK30neY0f9cDlHnvChyCX8tQPUNbzJ
 eU/fXxHoLLqmnBp2izhbcT6XFU7S7iimptiuG4ZSRoX3HCmW+sXfXVi9a
 7XyR1ZNgfh9EUyz8a0uwOqdP9aUnAXSrpEYRvXjMw9+8tK5HQVFh/0dNH A==;
X-CSE-ConnectionGUID: 4yMDBUjnQlyYy1k9Lycg+Q==
X-CSE-MsgGUID: N9R0CHAJRs+mxdYP65WrLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2386069"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2386069"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 20:10:53 -0800
X-CSE-ConnectionGUID: b550IrfRTESNs9vN5Z/pww==
X-CSE-MsgGUID: jiWWK76iR3KDieyK7CvMBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="8402954"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 20:10:53 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 20:10:53 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 20:10:53 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.29) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 20:10:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pDb0jVgjepDW3pEGjTFnAREYJr5ZnPQC+ahc1AhKxJpXHumRC3icBr1RQ+he/HyWtq6JBtOwSBes6U55EwBpFeZhAorunpMKNeTpXOpVEyGHURUf1dgnxtdV2n3OXU+nuaFjCzLFlVakGuWw4csNs7Pdsoh99uVV/JhoSONr+x/mPGbdiOuKSmwZnhZ2QtUwWPomSc2TqsTVl/QMEngqof9H5aFexWBOsjwyn6eeMyJ21rQ52+9atOGzheweCSbMgj9cvdQ6bwnzbq3mUEF7mGJpiECdFu/nIFQaEs+aDOIPq4v66UQnyvn4vi9YsXZ3qaSkamils6Sl3ZEO+IjImQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1T6jxfx9mMOUwlVkJpSBw+ptgl2FotiZNaDMwLMUiPk=;
 b=ZTjUVIeitr6YkBA0JqQ8xTm+NjuAvSNIcDz4ItCPmjBTFWIgzEzSjex+vzNyR/uDB4Hx/k83Drwx8yZ+3aYVb0Owa4kQmUHbZvLmFhaHxfa+Xa2V2bAgqR5xTye8YivgKq7EZ13Z3tHV6YVVgzV21CA2EcmrraBrVPtuY0vA3mvH2S8ASOzk0qdUadnDX2Cxh2zTtsGoXts2i0WtnDCga+kmg+67JPyvW6ohHGmTUVmP7NPWWwFAT0PCTDg7WlxnDePNcW/QEBRg2dfYno7kdP6eO45BmU03uRgOkL5+tSZAj07IUoA+O7UStTG5fvL7uPz+z73G/fjJ2NIspZXTcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by DM3PPFCA4893B55.namprd11.prod.outlook.com (2603:10b6:f:fc00::f4d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 04:10:50 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0569.011; Wed, 4 Nov 2026
 04:10:49 +0000
Date: Tue, 3 Nov 2026 20:10:45 -0800
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v3 11/33] drm/gpusvm: Add a DMA-mapping accounting callback
Message-ID: <auqwRZJRXoQPmVxJ@nvishwa1-desk>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-12-matthew.brost@intel.com>
 <auqpUmz15VVS3aSB@nvishwa1-desk>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <auqpUmz15VVS3aSB@nvishwa1-desk>
X-ClientProxiedBy: SJ0PR13CA0164.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::19) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|DM3PPFCA4893B55:EE_
X-MS-Office365-Filtering-Correlation-Id: e305678f-03b8-4f02-4e2b-08df3a299af1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|5023799004|11063799006|4143699003|56012099006|261021123027099003|261021121427099003|261009223027099003|261009221227099003|261102123227099003|261022075727099003|261022105027099003|261028144727099003|261026121527099003|261026140227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: uX9drQ85dAc0Ffd0mYkJKqBh043mTdbarXGmXwE8i2FTh44prGvTuY4LQ78KbRtm3t3Gh2zQF4k4WZh97GHlHRPLIrr6oEuDDnHuC8WQw1efmCW4qdlDKfuEdju/GI89XYzk4+p0Hy86XxAVeX/L9Tsve/huPLaF29dQHyrH+ECPLZ2wtQDOZ+RS0GEOtlvG33yJvek39+yRNfcn1Pjod5BoRz3y9wWKoLSDF4g8Jkg5iyQyL6z17CyhMfv/dn8Oe+a0ZjZeOPDYpLJaosqU5ewY879ub0hks6z1WrO/peROMR3rzHsBga4i//Se0O1SY+rRtevL8R8dKBflL6B7++Q7cEWSGkn/KrooBi2Bn/WsFJLS3QnwsPCd4QDm3vjnLB+D9j+4DemW1grLsYC/65NkCmcLLMjrGO3pSA0ToD0tKXAapjlbFILW6zUvz99C3lw0Xug41/YGl9oCQ3F7FvEhSoHMJurBONgiBxhxiVYviYXlqK6+GR8o0XRVVU8GncsQs9CGERAyzhjYcCy1N9cQeidAeAg4QfMsyiy6460pSWH6tENm23gv4VbmS/XMdaChRrO6Kh2SXxsD/2UTskcZNUAWCkWpuUTYU9O0nCuFXybqvNWuO9PZXLutYm1D0ReuUXb2zMskcdS+bH68EKl9sFlNTTYHjUBKGe8I6Ro=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(5023799004)(11063799006)(4143699003)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261009221227099003)(261102123227099003)(261022075727099003)(261022105027099003)(261028144727099003)(261026121527099003)(261026140227099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?jcJ6KoA/ggwSRiL+aBatonD+0MLyhE42hKE+OYmQoef2PInea6ytFWYk+w?=
 =?iso-8859-1?Q?PapxeKBr0xWq1FK3ehhIL3KrNPVJEyg8KZIRXaEVlrLlLLwq6GxpLJftZt?=
 =?iso-8859-1?Q?Zt4aESP+IYokT1aCRZoZeif2RD5mZJ5zxbnTSgpaHxHkjWJHl3tmOgAlwN?=
 =?iso-8859-1?Q?3/egobKCdJ6kEIZvkddjQUIsz4Qsj8Q1MrWyvCI7ZDEd3wfEv4CXYICeFd?=
 =?iso-8859-1?Q?uYfp99s12fNAjy2ahs+X6YBR7dioR9J4yOMo9RpPluWUpkF+VhioPsCqp/?=
 =?iso-8859-1?Q?Zk5B6T5b+JEpnMdjgIb4bD32xkfvMuo4NyxecEdzF6C+hrW0LeG3gaXnjN?=
 =?iso-8859-1?Q?dpTYhz5TFmCraReXB85t7TQEAJfTeNXvdaC95tteWovyszaOepQe52wcbT?=
 =?iso-8859-1?Q?8kk/HeMxmvDiOoGg0ZQeD1hJMyOgItVbMf5ulHqkwNYMS8x61u4v68Si7h?=
 =?iso-8859-1?Q?aglkCJe3Jd69fohaRfOddGSK0oDJaxqGXC8upe/1FcyfJAIov6Se+ef9b7?=
 =?iso-8859-1?Q?4sN+eWoJcvwGDmbH2KxMdg0hcXPKyZ76mU6EwZ/nIpk0y/Oa8GHoRazhDV?=
 =?iso-8859-1?Q?Xt0RzZzehjbb7cHdhxhbfIvKIzUFezcT+lr2k0/h9FkOXNsb7eSDos5t7d?=
 =?iso-8859-1?Q?bYJhAyCydK1D+/FMx1rtCDQgK85tJ+ufw16KjxNu6QBFNNvLw6qN/l9Xoi?=
 =?iso-8859-1?Q?eCPtPw5byzpEgq/9HqsbTJl0oi4HG1KAid87qr3Yp/2XKTzTTYBCcvGkne?=
 =?iso-8859-1?Q?0YZpIoivqeaKQh3C9lIyDdaKH2xOHZiIZwwDNfTraL49AQ+DBEXBbhqauU?=
 =?iso-8859-1?Q?9pscKXg5Yr3Ci7XxR/MWBDWEzf2HZIzp8D38SI58ZJ97i3cYjvrCqAGyl5?=
 =?iso-8859-1?Q?kLNtBjrTifCg4CD/0J/lkv96wHGo3kV5H/MI6P2UXk/7+0o6z/MwMCTTA7?=
 =?iso-8859-1?Q?uc2Ne/fQuXOgTris5K8QjEfv3Wk14/IZbXri5ajSRYv7KBn6yK9bCigyIY?=
 =?iso-8859-1?Q?zMorL63Doj+GKyXh/QcMcqfdWhKz8rVIeCwpNGcggIeYKsjgzPAFe0Falf?=
 =?iso-8859-1?Q?DXdyF5ZmyHwodpzpfowAaOqT1bfB6WrRx7x+JFEaXhWBOaiiielX2SQ2Uj?=
 =?iso-8859-1?Q?ze4cOAat3Aq0yvGysaDiWoNeaIYnFQk8Y9/FVEcpmDWrJqOA3s5bIrn34O?=
 =?iso-8859-1?Q?xbhm1O07z8n4ZFl8ca5fNMx7NzYx+TIGYDruViKx4ArZGf8POe0xWEmkOA?=
 =?iso-8859-1?Q?C9xIxlZax9P+SAnWIpdghkkJH/6z/kke2maFfKHyAZlhYW5lLJcAkL7Hs6?=
 =?iso-8859-1?Q?DiFpSL06IUJqKnRx2m+MTn9FvwxPUlFwHxnJ8k2tJvaowX/SRT4TzR85yH?=
 =?iso-8859-1?Q?ce0i9Ow0Hx5516cq+JA9EzKWW57cbT8posX8moilKY5bJaGaqwRKH4cuMA?=
 =?iso-8859-1?Q?9Aq5SqzD/uYRKWah5xiwoFKQjN3Mt3xpQfgVLEUk2zfJQxh64+fSfDMxkU?=
 =?iso-8859-1?Q?qqU3fkXPwtTOIoKnquJoqN8qzvqa/J4WlsEYtksNVR97ApHFVWQDjlavJM?=
 =?iso-8859-1?Q?qwrNtUGiCMmvhzVNltp0frE0LIijbWvfNm1jSmVkXIpCBcdEJtCnOFNG3E?=
 =?iso-8859-1?Q?uefnhNa/xzxdDXQCM2jjIuW2OBUWwqr0bnO6cIPVhhfBn8PxO/FM7Xbnnn?=
 =?iso-8859-1?Q?rXZ4Fx5A1pOPectPBI7ScTHMbl/dAq2NlNwmWH+CFRSaljuyxyvVHNaflZ?=
 =?iso-8859-1?Q?MGkxCyjuytO2Bv5UDSPYMuTJc9CQ2IXQr8cNKUa5szSt8iPE75U5TUpx0/?=
 =?iso-8859-1?Q?4OFvD5SLbQYq9WQ/jdCMnyYbZZ5OYnrdZmKZ0hYUdnxXt8LSAPSQ?=
X-Exchange-RoutingPolicyChecked: mPsGzRipWFegORXFhJemxvr9mL9F+3i+YeiIyE3OW5fBOjNPoEYtcJe2gYqrxaz4D2rWUofC/CGi84Rp+MY0d7PwcFif8t3w48rnwJtYZTDrlb9wPd3vU1OCAVC9VKa0Wf+yLdhGqwjhrjp/9FqnIFqAFMrxHGa9CWjwOfrmP9HdApBMrTne71OoiDzmYawHhpp0q7zGuZr8z0lqhwFEtAmtxkjx9IUg0OBBbTG3ZSBY2KVmD8Ofg3Q0vOGCyyhGLrNUqmr16z2tygDihAQLXyEN+i27G4EdfOHgEYX1dlc7P1y1Oa2AIgybsNyAyECQhDpvP9yN7cGKy/FT7rC+Vw==
X-MS-Exchange-CrossTenant-Network-Message-Id: e305678f-03b8-4f02-4e2b-08df3a299af1
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 04:10:49.8457 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B7HJntLb5XycDYCRvj621D52nSmekP+gZoezztDbeCL/u5VjCRZHJXq8l6vF1WnJP6nFoeGX4LN0rQn9m1N6jK/ACH7kvHfxXIg6rZBRMIqloswdOjW+GyMS9ZaNboC+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFCA4893B55
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

On Tue, Nov 03, 2026 at 07:41:06PM -0800, Niranjana Vishwanathapura wrote:
>On Fri, Jul 10, 2026 at 07:55:57PM -0700, Matthew Brost wrote:
>>From: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>>
>>Drivers that use the GPU SVM core to DMA-map system memory for GPU
>>access may want to keep track of how many pages they have mapped, for
>>example to expose statistics or to detect leaks. Doing this accounting
>>in the driver around drm_gpusvm_get_pages() / drm_gpusvm_unmap_pages()
>>is error prone: the number, order and kind of the dma_addr[] entries can
>>change between map and unmap (migration, partial unmaps, the iova vs
>>non-iova paths), which makes symmetric accounting hard to get right.
>>
>>Add an optional @dma_map_account callback to struct drm_gpusvm_ops and
>>invoke it once per &drm_pagemap_addr entry at the exact points where the
>>entry is DMA-mapped (sign == +1) in drm_gpusvm_get_pages() and unmapped
>>(sign == -1) in __drm_gpusvm_unmap_pages(). Since the map error path and
>>every unmap/free path funnel through __drm_gpusvm_unmap_pages() for the
>>entries that were actually mapped, the accounting is symmetric by
>>construction. The callback receives the full &drm_pagemap_addr so the
>>driver can use the order and the proto field to distinguish system
>>memory mappings from device interconnect mappings.
>>
>>The callback must also be usable by the core drm_gpusvm_pages-only API
>>(mm == NULL), as used e.g. for userptr-style mappings. Relax
>>drm_gpusvm_init() to allow such users to pass a restricted @ops that
>>only implements the page-level hooks; the full-SVM hooks (@invalidate)
>>and the chunk configuration must still be unset in that mode.
>>
>>Assisted-by: GitHub_Copilot:claude-opus-4.8
>>Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>
>Patches 11 and 12 can be spinned out as a separate patch series
>(for fast tracking).
>
>LGTM.
>Reviewed-by: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>

One other point below...

>
>>---
>>drivers/gpu/drm/drm_gpusvm.c | 17 +++++++++++++++--
>>include/drm/drm_gpusvm.h     | 19 +++++++++++++++++++
>>2 files changed, 34 insertions(+), 2 deletions(-)
>>
>>diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
>>index fcfe635bc195..512f52471419 100644
>>--- a/drivers/gpu/drm/drm_gpusvm.c
>>+++ b/drivers/gpu/drm/drm_gpusvm.c
>>@@ -474,8 +474,15 @@ int drm_gpusvm_init(struct drm_gpusvm *gpusvm,
>>			return -EINVAL;
>>		mmgrab(mm);
>>	} else {
>>-		/* No full SVM mode, only core drm_gpusvm_pages API. */
>>-		if (ops || num_chunks || mm_range || notifier_size)
>>+		/*
>>+		 * No full SVM mode, only core drm_gpusvm_pages API. A
>>+		 * restricted @ops that only implements the page-level hooks
>>+		 * (e.g. @dma_map_account) is allowed; the full-SVM hooks must
>>+		 * not be set.
>>+		 */
>>+		if (num_chunks || mm_range || notifier_size)
>>+			return -EINVAL;
>>+		if (ops && ops->invalidate)
>>			return -EINVAL;
>>	}
>>
>>@@ -1246,6 +1253,8 @@ static void __drm_gpusvm_unmap_pages(struct drm_gpusvm *gpusvm,
>>			else if (dpagemap && dpagemap->ops->device_unmap)
>>				dpagemap->ops->device_unmap(dpagemap,
>>							    dev, addr);
>>+			if (gpusvm->ops && gpusvm->ops->dma_map_account)
>>+				gpusvm->ops->dma_map_account(gpusvm, addr, -1);

In the latest code, there is use_iova path and unamp there doesn't seem to
come here for that case. Something to take care of during rebase.

Niranjana

>>			i += 1 << addr->order;
>>		}
>>
>>@@ -1654,6 +1663,10 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>>				(addr, DRM_INTERCONNECT_SYSTEM, order,
>>				 dma_dir);
>>		}
>>+		if (gpusvm->ops && gpusvm->ops->dma_map_account)
>>+			gpusvm->ops->dma_map_account(gpusvm,
>>+						     &svm_pages->dma_addr[j],
>>+						     1);
>>		i += 1 << order;
>>		num_dma_mapped = i;
>>		flags.has_dma_mapping = true;
>>diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
>>index b7d987bf76aa..36f35816a569 100644
>>--- a/include/drm/drm_gpusvm.h
>>+++ b/include/drm/drm_gpusvm.h
>>@@ -75,6 +75,25 @@ struct drm_gpusvm_ops {
>>	void (*invalidate)(struct drm_gpusvm *gpusvm,
>>			   struct drm_gpusvm_notifier *notifier,
>>			   const struct mmu_notifier_range *mmu_range);
>>+
>>+	/**
>>+	 * @dma_map_account: Account a DMA-mapping change (optional)
>>+	 * @gpusvm: Pointer to the GPU SVM
>>+	 * @addr: The address descriptor of the chunk being (un)mapped
>>+	 * @sign: +1 when @addr has just been DMA-mapped, -1 when it is being
>>+	 *        unmapped
>>+	 *
>>+	 * Called once per &drm_pagemap_addr entry, when the entry is
>>+	 * DMA-mapped by drm_gpusvm_get_pages() (@sign == +1) and when it is
>>+	 * unmapped (@sign == -1), so the driver can keep symmetric accounting
>>+	 * of the pages it has mapped for GPU access. The @addr->proto field
>>+	 * can be used to distinguish system-memory mappings from device
>>+	 * interconnect mappings. May be provided in both full SVM mode and the
>>+	 * core drm_gpusvm_pages-only mode.
>>+	 */
>>+	void (*dma_map_account)(struct drm_gpusvm *gpusvm,
>>+				const struct drm_pagemap_addr *addr,
>>+				int sign);
>>};
>>
>>/**
>>-- 
>>2.34.1
>>
