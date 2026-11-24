Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA74A606A326
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 20:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZlLZIumO;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Hf6z5STH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D085910E27E;
	Tue, 24 Nov 2026 20:20:17 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8C6C10E27E
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 20:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795551607; x=1827087607;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=d8xPeh0zyHlomB7shPhz5r8QDYa84/wlAlOc9qv+0Xw=;
 b=ZlLZIumOPAgp0SOH4vaO/Guww1EqQfBrAc8mjCO44jDBEAE+9v8DHsBR
 TL6r/trojSTvH8ejmvlnM6FqEEO6StyjzUcIRAPrHMDiNDrCJWpVvYP5V
 ReWP0rml+DEcMTiQgWv09dpwH88cEd4spIPz87+FjMS925cOyAJDH1AGD
 p9KGPvVrYBxv06JQkXYhWzNzs2yCFmDjQOeL4U8ETcemPhFld3ZJbxfbE
 jcsbmchf3TclW5DG2ZWOCZogNdTkjVmpFmftXTI6LlGo+qmrQkMlgm+or
 iOW3bLtexJaYNqXEDqp94EoMnjW9KwvtPZKEqnUSiGEOt7ZwJpuimaRRQ A==;
X-CSE-ConnectionGUID: lrm1MtC0S8ah6RWW7ycLbA==
X-CSE-MsgGUID: 7TLx/xlLTeq6RrWoKunTsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4381242"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4381242"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 12:20:07 -0800
X-CSE-ConnectionGUID: BZtuf0T5S960GvKuvUFA4g==
X-CSE-MsgGUID: 5XCsrGUgTpuv9YiF1aFzfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; d="scan'208";a="11857744"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 12:20:07 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 12:20:06 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 12:20:06 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.42) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 12:19:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XBehTxf9Jkw/rMOj5+9OoXQp61v0LZI5mRUssAJOMK4ujmOD1/tRlKEOkNGSftYGsGFTkc4hgaWJDlCLvEa2cT2ygaAFF4fUAPwwjljg3BB+Ysn6UAM374FWzOx7m4kXw+9eC/+yDd2PEtHZANI8V/9lwQWfSFL3HTto+U2a6JPAu+nZWy1kZYUvgpZR5GkwN5OHqt637wc21PDLGxqQhc6TlwE0B5OgTshrqpa/cIiMM0z229+71DatMu8Q5EgMtMQ5axQt2hI5v1/smXJnjsWtIxonijEP8tPjAOBUltPM8qotcDzbaGOYRU5gkflJmXBxO5UrtJ1cXHf3TDMP+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJGWGvsY5qYGghaVDaW6bK/ioFC6f4j8pQBO15xd3mc=;
 b=Mr18N2sa0so5T+Xq5ETuczTqRa+VR/6L/H5rjlexQfQLNXBvmsH3SVLxRNdMiBm2OvPyvIShfO7jDGFwEtqJoC/WVoZZAflHCfHD5iiBNdU0rkmRc2lgwVpjQ3b3J1WtNK0bCKijszsLMB1wP/q3S5RtX+YYBu8RquXzKGKVUs05aAB7BZKg/7I32epHtA82EhrDZO5GSIrAW4Raun6D7pPSB/zHXFku07euU+vB9Mr0GE/9KUu44pJALg7eQ3WPAupLNRT59uJOTqBl7OMgeeQNxXfYpZlCYCiaQGuXPWxnOrLboTsZFUM8j56nsXwAUtEdQp1RGdPrYocDZC14oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJGWGvsY5qYGghaVDaW6bK/ioFC6f4j8pQBO15xd3mc=;
 b=Hf6z5STHxjIrKnpPKyKcmPD5atxOAKrCU/PM/dYYNJV1iIeQQ+i9mtf3/jkx915SABLAwiYDQWF7z+LZeG7vZZtvCM4waqVL0ExXnMbyhUZIbn0G+lzy2FfQ+AJLm8HQUrthXfaf1uyNM5MnXVjVFf9D5GfXde5POnuareeArGI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 DS3PR11MB177157.namprd11.prod.outlook.com (2603:10b6:8:43d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 20:19:57 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899%3]) with mapi id 15.21.0639.011; Tue, 24 Nov 2026
 20:19:56 +0000
Date: Tue, 24 Nov 2026 15:19:52 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
CC: <dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>,
 <riana.tauro@intel.com>, <aravind.iddamsetty@linux.intel.com>,
 <raag.jadav@intel.com>, <simona.vetter@ffwll.ch>, <airlied@gmail.com>,
 <kuba@kernel.org>, <ogabbay@kernel.org>, <lizhi.hou@amd.com>,
 <karol.wachowski@linux.intel.com>, <jeff.hugo@oss.qualcomm.com>,
 <carl.vanderlip@oss.qualcomm.com>, <troy.hanson@oss.qualcomm.com>,
 <youssef.abdulrahman@oss.qualcomm.com>
Subject: Re: [PATCH v5 0/4] Extend drm_ras for qaic telemetry
Message-ID: <awXxaNid-CQkl2dW@intel.com>
References: <20261124180137.616249-1-zachary.mckevitt@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124180137.616249-1-zachary.mckevitt@oss.qualcomm.com>
X-ClientProxiedBy: BY5PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::37) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|DS3PR11MB177157:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c5e145a-a2d2-40b0-1c66-08df4a684ea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|23010399003|261009221727099003|261026121527099003|10067099003|261026140227099003|261022075727099003|11063799006|56012099006|261022105027099003|261009223327099003|261009221227099003|261009223027099003|261102123227099003|261021123027099003|261009220027099003|261028144727099003|261021121427099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: kxg+xItmURPX9Gy0UlJ5Q60K7DjIOdRFQ5Q+0S/UELT9E0+Uy8jrho7dYWmRLg5FuuejUnFH7R51KzucVMWEMWhd7dHdXUzqVlaA+jz8dpkBd181UheIK2LfjSaz1yujSx91q517k6UUFEzA401LhmrBZYNEK3pBgoWDM/Oypk90la60uSdOOQ1SZr4QmaquCw0lwx8rBvz5M2M6xr++TjK8k/d2L5A6A2BcEY5gQh0oY3H9zLNorgXcOkUV/F2C5IVtUfuSw2rXrbFWwC9cY/lkv8ccKVCtWJpZeL4xCUXqrg9LHQCvgmHSdCeH8RPFPtE0atahic2lvda36HHRA3C6WfiNNiDY2mhctBChkrQ+HZ3CVGSacOKTx8G5tuxWRsRLStKr33Nq4V3cEiOh1omgRov/eDp5v152EHWLQcqnls4NV06M9/fdrpTmBY1jeY5Rdk0Ugs7dJ5LqXkEbU6RMCAedf0eOSj4L0bLmA8WAyixBswzyi7Rn2m2OSP9UAgqU0IaLaGfsqzEsX+rqTfHN20uQc10/rQL1QRvZGPVTDTXJc0Xnv7SiTwyT2EPjoEBdhvxTIfDDJexKaGUby3Iv1WV0lC+EMLsF0Gs/TuypetClLQWZdmLHE7dk4YXO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB5990.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(261009221727099003)(261026121527099003)(10067099003)(261026140227099003)(261022075727099003)(11063799006)(56012099006)(261022105027099003)(261009223327099003)(261009221227099003)(261009223027099003)(261102123227099003)(261021123027099003)(261009220027099003)(261028144727099003)(261021121427099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H5rLuF8TDYlyr7S0izD2N85JAmc++dhJesktSwON2hHl9cys+R8mTEjha3iI?=
 =?us-ascii?Q?IjWmAsmX43UL/B5E7PXZvdoor8d+kAsiY607T5G+KB+QyGrzQ+GK0XaBpjbX?=
 =?us-ascii?Q?hMG0a0k5P+/spW3LtI4BjSzu0tsC4y6aTj9jXmZouh2ZxrtSqGFfhklJOUek?=
 =?us-ascii?Q?L2MZhwvq+AxKTuVJWOQuXEH9ELmqYy+Fb8hpqj4kkcN2or08eSyIWdL585zm?=
 =?us-ascii?Q?B8vK6+XwCcOg0F8O2AL2NlP1mnPFfMS+GYa+1NxjHe/LPHOJ4bqD4jJqOHyj?=
 =?us-ascii?Q?rnIpbFD5BKNJ8LI/pwAlild4wA3PHQceYbbVu08+/r6Gyfcnij5mBuarffq1?=
 =?us-ascii?Q?j8cubCIElCLrq4sG4A8G6XvgCqxsW5d0AgwS6lnmZY94NCSKRBHyc7we2gz7?=
 =?us-ascii?Q?vl2OnDlpcDrEl7L39SeJo7WxjWkqW9WuaxnrdFQFsKVp6/L/ho6BIh6Cw33L?=
 =?us-ascii?Q?QcqlvntcmszyICmaSykZX4SN+yyg5hoeajOxCv1n5xt8nwbnc1znf4ql8u77?=
 =?us-ascii?Q?+u4zgt05T/EbO/wn1Y5o9KjGSNlVYN2LdDUqz0cTthKMUmXpg7tjzaJeqOEB?=
 =?us-ascii?Q?ToZPLxrCud2NoIFGV171Yw0luVoOqREy2oLf5mbDuzNANazLZTL2KNGvV8KW?=
 =?us-ascii?Q?VmTV1oLLH5obI+2f3J+osHKLKKsUgXzLRYUee6wlE7iw6UgSsB2QNgC4wMc+?=
 =?us-ascii?Q?7V07um3K5S9KFznIwbY59s6Ltz/geD4Zn94yvSxjkASG05g5h2DUl9KlDsew?=
 =?us-ascii?Q?uZSpsbAAveHloIX5tG7IIwLabW5YrV5o0JgaADNhTKJBGmBQ9Rg9Q36l5mek?=
 =?us-ascii?Q?bEeiilLQhhAy7fVDA4nbLIGIuOcV3x/qm41mJdsSn/DT2HBAtQD4OV+bHErX?=
 =?us-ascii?Q?ffRSUHaegdaEO10o0i3ySHHqqMCs+Pec3LS9uw4ep7FjH4nzuiZTyIX+d5jz?=
 =?us-ascii?Q?YRHlo26eSi/NSU52l/KIbayTahTanJuxF1XC9p3HDSDPb95lSLa2bjgor641?=
 =?us-ascii?Q?HTVvmIkiVqmQIPjmDSABHwc656L5pcbfAENdukQSzOeVzItxsReQF4tYvMmj?=
 =?us-ascii?Q?5J2Tq5kLZy54ZWtE2m9SqGI93Sv+cfx+IFp6ItXpjPd0tzC/lK5BPoYXCZ/d?=
 =?us-ascii?Q?AXVfB5ITtgfYowiJbtRtvKU/xm7BzNzWixoc/e+tWwspstWK9AbTQ0nXKEr4?=
 =?us-ascii?Q?nN8DuvsMhbO2UXJBqOpXixj7XBjbjerLJCJjctIBFLCthIhV+SEp0KhBAujz?=
 =?us-ascii?Q?goMEj3WprAzrxCzQ1k7zGjyar1/J0lDcajUU54vGxcs6Ke6BfQskPrKb2jTv?=
 =?us-ascii?Q?I4ZqWsPAPJpm8rK90Ri1FNsEw4v0i9w4rPHSFEq7de2JN4HZZXOXx8v3nsH9?=
 =?us-ascii?Q?A9zu3dNAmkP1YiUivO+mGMkToNrdRnwQhlpaMWl90ObizV32JE+EoHMnFhlT?=
 =?us-ascii?Q?V5MutFaOrJWRl0FLmaIoj/4+5LuH21J4dnUB0eDl60mnIM/Ls2rSUlepJvOQ?=
 =?us-ascii?Q?TonbH+Qv61/N5mIJu5DXQ0i46sqArJTffGRDubJnyuKJNZOe9M6frqvj3G1F?=
 =?us-ascii?Q?DMoF3IuGyUVtFtLqaMdToUPjzUooHSVxDzxU8T3dCEMFIDiFR1Wcb7ElkjsT?=
 =?us-ascii?Q?6KJBewxFPDetb6jhnkLsGaYcTxlOqbemeUcsWxcaXDu9+T98rs/QsrTOlnbh?=
 =?us-ascii?Q?G9T9IMkVDcctbdIfZ2WhnaFkD1EVHavON82ZMnuCJLteOjakjDMO0emhA68m?=
 =?us-ascii?Q?YdLz7fLMxA=3D=3D?=
X-Exchange-RoutingPolicyChecked: EWHjDY2/wh5LIZnRTqIJiMQugxzr5NGtDQletrSD1GPVU/5OPNe5D3KHgnflmCI5JUJEG9eaAFgWZKTatk4Wna9iw8gLe3fX5z1EJZm9moS+1mJZU54Dqrlq004CluAkDanmmKYXKYne5NvBzD/gddFZZbeu/sR7AKvZVWMkUH60ahWLrtVGEKEqfgXzqPFPuhLjaq1Auts9LZjuI4ZaPX0+oMvlomnd0GBTkyKUFva5UX2QGmaGldRoGL7tuvNdy9lQql+vACNZ4lNNdG3l43UAR84VEvh7JVuy9wdUMgzyWild2+h2N1P8OuwK3USMu3NA/95AajsCwXKN955MWA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5e145a-a2d2-40b0-1c66-08df4a684ea3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 20:19:56.8548 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1S2aD/YboZJuLodpsjCusA3HlVwwHHv9Qa0qDTh7WtOtKQ66l3EseYbgt5K5cl0HJYmacUpWrwUfJJ4bpRcgYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR11MB177157
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 10:01:28AM -0800, Zack McKevitt wrote:
> This patch series extends the drm_ras netlink interface to include a new
> node type for telemetry nodes. Telemetry nodes support three operations:
> getting, setting (optional), and listing telemetry fields. Drivers may
> specify an optional predoit function to validate get and set operations.
> 
> Telemetry get operations take the drm_ras node id and telemetry field to
> be read and return the field's value and any status reported by the driver.
> Telemetry set operations take the node id, telemetry field, and value,
> and return only the status reported by the driver.
> 
> Before adding telemetry nodes, a new patch is introduced to add refcounts
> to drm_ras nodes stored in the xarray. This protects the nodes, which are
> owned by the device, from being unregistered and freed in the middle of
> a netlink doit such as getting an error counter.
> 
> This extension also removes the admin requirement on the list-nodes
> operation. This allows drm_ras nodes to be discovered by userspace programs
> for drivers that do not necessarily require admin privileges, like qaic.
> 
> The new drm_ras telemetry interface is implemented by the qaic driver,
> which exposes the telemetry fields to userspace and enforces filesystem-
> esque permission checks on telemetry operations in its telemetry_pre
> callback.
> 
> Claude Opus 5.5 was used to assist in the development of these patches and
> to address Sashiko feedback.

Pushed to drm-misc-next, thank you for the patches.

Thanks,
Rodrigo.

> 
> Changes in v5:
>  - Address Sashiko comments:
>     - Convert mode from u8 to uint in drm_ras netlink spec.
>     - Add check for qdev->dev_state != QAIC_ONLINE in telemetry_request().
>     - Flush the tele_wq workqueue after mhi_unprepare_from_transfer in
>       qaic_telemetry_mhi_remove.
>  - Small formatting fixes.
> 
> Link to v4: https://lore.kernel.org/all/20261117233442.407877-1-zachary.mckevitt@oss.qualcomm.com/
> 
> Changes in v4:
>  - Add refcounts to track drm_ras node lifetimes.
>  - Address Sashiko comments:
>     - Fix status field population when HW returns an error.
>     - Add refcounts for telemetry nodes.
>     - Update outdated commit messages.
>     - Add static to private functions in qaic_telemetry.c, and remove them
>       from qaic_telemetry.h.
>     - Stop returning remaining jiffies when device status is nonzero in
>       telemetry_request().
>     - Add mhi_unprepare_from_transfer if drm_ras node registration fails
>       in qaic_telemetry_mhi_probe().
>  - Consolidate get/set dumpits into a single dump operation.
>  - Pin telemetry node to context in pre-doit and unpin in post-doit.
>    This ensures the same node is used between pre-doit and doit calls.
>  - Change field attribute to uint and status to sint.
>  - Added NL_SET_BAD_ATTR calls to telemetry netlink functions.
>  - Reject non-telemetry nodes in telemetry get/set/list-fields.
>  - Updated qaic Kconfig to depend on DRM_RAS.
> 
> Link to v3: https://lore.kernel.org/all/20261106181225.3333260-1-zachary.mckevitt@oss.qualcomm.com/#t
> 
> Changes in v3:
>  - Address Sashiko comments:
>     - Properly return status when telemetry request is successful but a
>       hardware error occurs.
>     - Validate telemetry fields against their gettable/settable fields
>       lists when invoking the predoit.
>     - Update documentation in include/drm/drm_ras.h.
>     - Moved calls to qaic_drm_ras_register/unregister to mhi_probe/remove
>       instead of pci_probe/remove.
>     - Added srcu read locks around calls to telemetry_request() in get
>       and set callbacks in qaic_telemetry.c.
>     - Added a tele_ch check to telemetry_request().
>     - Properly handle a -ERESTARTSYS return from
>       wait_for_completion_interrputable in telemetry_request().
>     - Ensure field can be truncated to a u8 in qaic's telemetry get and
>       set callbacks.
>  - Minor code cleanups (typos, header ordering, etc).
> 
> Link to v2: https://lore.kernel.org/all/20261029203000.1763447-1-zachary.mckevitt@oss.qualcomm.com/
> 
> Changes in v2:
>  - Address Sashiko comments:
>     - Initialize certain stack variables in drm_ras.c.
>     - Added attribute guards (GENL_REQ_ATTR_CHECK) in telemetry doits.
>     - Added a valid node check in drm_ras_nl_pre_telemetry.
>     - Fixed improper node callback in telemetry_set.
>     - Now registering drm_ras node after MHI initialization.
>     - Now removing drm_ras node before freeing MHI controller.
>     - Added scoped_with_init_fs guard to qaic_telemetry_pre's inode check.
>     - Fixed improper kfree in qaic_drm_ras_register_node.
>  - Changed telemetry value attribute to sint and dropped padding attribute.
>  - Updated documentation in drm_ras.yaml.
>  - Renamed telemetry read/write to get/set.
>  - Added dumpit for gettable and settable telemetry values.
>  - Made telemetry_set optional and added admin-perm for it.
>  - Specified ynl file regeneration in commit message for patch 2.
> 
> Link to v1: https://lore.kernel.org/all/20261009173152.2436195-1-zachary.mckevitt@oss.qualcomm.com/
> 
> Zack McKevitt (4):
>   drm/drm_ras: Reference-count nodes across netlink handlers
>   drm/drm_ras: Remove admin-perm flag from list-nodes operation
>   drm/drm_ras: Extend DRM RAS interface to include telemetry nodes
>   accel/qaic: Add callbacks for DRM RAS netlink telemetry
> 
>  Documentation/netlink/specs/drm_ras.yaml |  98 +++-
>  drivers/accel/qaic/Kconfig               |   1 +
>  drivers/accel/qaic/Makefile              |   1 +
>  drivers/accel/qaic/qaic.h                |  19 +
>  drivers/accel/qaic/qaic_drv.c            |  15 +
>  drivers/accel/qaic/qaic_telemetry.c      | 564 +++++++++++++++++++++
>  drivers/accel/qaic/qaic_telemetry.h      |  14 +
>  drivers/gpu/drm/drm_ras.c                | 611 ++++++++++++++++++++---
>  drivers/gpu/drm/drm_ras_nl.c             |  45 +-
>  drivers/gpu/drm/drm_ras_nl.h             |  10 +
>  include/drm/drm_ras.h                    |  98 ++++
>  include/uapi/drm/drm_ras.h               |  29 +-
>  include/uapi/drm/qaic_accel.h            |  28 ++
>  13 files changed, 1462 insertions(+), 71 deletions(-)
>  create mode 100644 drivers/accel/qaic/qaic_telemetry.c
>  create mode 100644 drivers/accel/qaic/qaic_telemetry.h
> 
> -- 
> 2.43.0
> 
