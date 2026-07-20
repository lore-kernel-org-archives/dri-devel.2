Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BDAC44520
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 22:08:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A90310E201;
	Mon, 20 Jul 2026 22:08:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RDJd0EnM";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3062010E201
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 22:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784585313; x=1816121313;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=eblDg82zSHBL5bIgpn3AjYBIlE6PnNBUcgX1cokc918=;
 b=RDJd0EnMoSUsaFD1kmwYMSG+hLiwN1qNsdpjhD0LEUaegylFOiK7KatC
 qx0WIngdbbsymegGt53invnbcqWZAJ6q7mi/6Ct+7O92AD/kSUTRV410/
 ohtNrmHBwpB2NEHdCRz0ak+LWHHoFeCuIdStpADzxeMUF3o3OrzPyREF9
 GDWp20m5q3iunpDSy8FiVs1RAK2YRQs/tBtVNGiJiVgrwQRAKcUF1f7A2
 uRbpzEscsdwsDeG5LA+orBTg2DQYHP3XdhHDENHbQjypkhMTsNeMt8Wrt
 k7H7HybXeXiQgYqwT+C3RoAke9HuNdfrhlh0ooNvnQb5opEmHPTeVLnmm A==;
X-CSE-ConnectionGUID: +Xa4TgEkTjePMMjvoITNKQ==
X-CSE-MsgGUID: OCFwl6VRT4+cVgjqmsM1xQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="84940527"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; d="scan'208";a="84940527"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 15:08:32 -0700
X-CSE-ConnectionGUID: MH63P73vS++8iJQKZUhy8Q==
X-CSE-MsgGUID: arThAml7SgaRxhcAbvjxIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; d="scan'208";a="282059963"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 15:08:31 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 15:08:30 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 15:08:30 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.40)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 15:08:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ccan+t3IEdGh7gXUevt8vus8A4ylzTsg8naRYsVHGziNQ1gYpz1wPqSxA2hjBN33fifnNeMna9Cn/XI6kzR73nT5QZDGnCeF9wNJkfZql+6UwYDrZfQX/Np4akaxrmSXaSxrxuA4m5vovbomYDBaWvUbizGv0785KIjb/EMeTqrxtYtGt8E9I9geEuxVqlE/JatQ82eFPTLJuqmreRTOJDSNQdKq6gC+M2/2bbq+xvov/HArKSq8AE2OiEFfsyyFcL5vKSgHBc58urm9bSeNO5qZTV3uFiaBgcq5snsx5czBePNBvAcKNyvKjR9qPnM2wf3xGBAk8al8nlHZul/eiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxMVfG+Ulm7Vwx+qk2+RjeUkNaQZNGikIFGgtCuB3D4=;
 b=ov6mbkLbmKBK3hB/7ATYZQvqq+JdZoXBAg9VwOSNX4L1GlnfaEKZURR5YrZAWLB56nScmW3gi8FtmOSblR33M4W2T5FkFKZMyH6Kc9hB4jVKXpDjIfVc5Mm3tP00OQlZabrAXsaP77hadgOkMdGXEl0x+HccSK3EZuvPvPaI0/axthKGbyib1yKhbrWkvTRfcvLpNYJYeRdIFZflQTHkT4fyFxYycesryv8ML9hgym3DJdQMap1sAAs6tL4WldQNPo2h2/OX1GSHP8XwIayJjYm3DSxjFUjfR83Ev7onNS+Do08WMRCWGpmbtAvsr5ZZrRVlOHcEnG4MbsL8483kQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DS4PPF25B1C4D24.namprd11.prod.outlook.com (2603:10b6:f:fc02::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 22:08:25 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 22:08:25 +0000
Date: Mon, 20 Jul 2026 15:08:22 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Wilcox <willy@infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Mark Brown <broonie@kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, <linux-mm@kvack.org>, Christian Koenig
 <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: linux-next: manual merge of the mm-unstable tree with the
 drm-misc-fixes tree
Message-ID: <al6cVnNv2TuhuiV3@gsse-cloud1.jf.intel.com>
References: <al4jGBGNG_QACaNL@sirena.org.uk> <20260720144141.GA16699@lst.de>
 <al40qCMTxhEP3Kx8@casper.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <al40qCMTxhEP3Kx8@casper.infradead.org>
X-ClientProxiedBy: MW4PR04CA0243.namprd04.prod.outlook.com
 (2603:10b6:303:88::8) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DS4PPF25B1C4D24:EE_
X-MS-Office365-Filtering-Correlation-Id: 81724a44-d6ca-4c00-0135-08dee6ab6b77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|366016|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: XXOHexTfywLk47SZsSksQbA0ffSuejN4PSkM9/NN3YsNDJEoaZR+y1IBJZDSJghhuPczHD3UCi1ZmnhA+xmcrXERDW+1RvtDgmmtnDg40F5M4x0tQXQVmJZLDbRJ1iBJQqx0zPWJB/5zz2mc7707KznUU5+Oi/O/WQH6ETURgljtVzfpdVQ2A+kM3z+d28v+9Vt/cvx3YpWhQt/Quy7Zm/DxBG4xMDmlowxtkSLR6K7d0ui3Ahc04EJIRn2Dgiq1LKZJFGL08V4Cm0dcLtyJDMCfm4M4np7RNkONrSDzBXhmNgBtbMH/vS87GplQ1c/TqYoDED1F0emo+ataEs4s4TGDjlFx5BdLzCuPmYvY558QfWxGhQKoLLOpRcdW3legixtq4kGqAIce1s49V09q2IE9A88TuBXC8yZbyIJoHaDWwVvd/pu2HZit7/q/67D2iHyaG6JnCQ9Zks+XCQwnzPZwrajdwVJWMwFuk2uErhg2giQWUIOGxpZCB3xQ0i/AjlbBffmst9MHnJ+ek7+IGGZwD21SJzzairhvor8slMrSFf/a2EyynT2MdMSChqJAjI84vkpA8HeUlCHQSJ2/8CkPen3GmSnIbKTOI90ASs3CatvVWFfigKcFk9cH7gthL8VMbkE5Xup4+Ufk7Wupe04x7o709y872CpD3u8EKcw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pyjO9Vvmjf5L+YwSLt2B/9wZmyc6CiPGQGODF9cGA1giPFpCR2RE+a3ejyrg?=
 =?us-ascii?Q?Nw8R3v1mm2z0LtW8FABFtZ6S/qPP+r8w6j/Odw/p3amgTHjb4xRHMVLHTR/R?=
 =?us-ascii?Q?yDc5HN6c8lneZVMNUWezd6VUhXU8yhzBvcUmMQ/bQ9+mlMTxClEO+QqXqQQk?=
 =?us-ascii?Q?QyOGC5+oIkpLQuhMrck+6X9+ol07Av8meyrN0zx1/AcBpixBVM9xr+Pb1xj1?=
 =?us-ascii?Q?3Ws5pWGRnVvJVMcPCNyCkGfDOI3fhlEyUMMVGjcFiQjG35e7oo5DizdvlWa2?=
 =?us-ascii?Q?6TVRWBYZGyPzPeU9T4zaU3rjHXGzwGW30riwD296sBseJIvcet4VngUyh8lG?=
 =?us-ascii?Q?JfVOifCwNN5XUdiqqhl1EBL9LMzbY/UyvYPDScs13Xvd13NZ3Q/RQIca6WV5?=
 =?us-ascii?Q?4h9zlugX9Ymn59klL7QAOEzWPjgEVruMiR27Nc7a+FJ0QMAZ8eFGC5N6UMrs?=
 =?us-ascii?Q?iOczizaCAUO9DasRvjlGWML4KXsHuSQKh33Ysp3uypQCX4hv1dwrxFaCIIjN?=
 =?us-ascii?Q?KhqITf9YJANr5POpUz34LAUVqzRpD5K1OHzXYjPkBjG+8vBl0wmoqWTwY4nQ?=
 =?us-ascii?Q?9FMnsZrYflVbZqFBvpElcaecFI3BXVvSGzYIRTHTNlOWRDm2kOi8um7C/xvG?=
 =?us-ascii?Q?2ZWHxwCGtqE+swF/ahGmCfWdEmecLwQUdJ/URW+ADxFd2cCFJO/uulZX+ZIG?=
 =?us-ascii?Q?jjLO2/CUjobxLPuPn3j2GZTdu/64xt6GcezGfNK356PMvsY/cFp0bYbBAKeV?=
 =?us-ascii?Q?2Y5omCFj1Lr+jpnFi2XB7bwZAh7QCsXorfqWMfGrhyhkLBM4XPtb33corlss?=
 =?us-ascii?Q?fhNhC57t8Gpo3gKfd/6pbufWOc2qur9ZALdB+JE5RY0Ss5U8sC0rMxPQP2LY?=
 =?us-ascii?Q?opSOZK0GzLrR/cz9l3Hi8n2EgZv2BiwQkMjA6LPmPxEDc5fdJa3+4p0xHcsw?=
 =?us-ascii?Q?voRBWKVqcl3OjOFby6S5E1B7sALSOY/fwlig7bOumLBtiMkRb2SmxnmomI7q?=
 =?us-ascii?Q?wiNg5UjfADZdEc+AY5eTYtxnIknjVsB3A+kPCq/Bo+g53loAYbIRzNlw1W7M?=
 =?us-ascii?Q?64fNzD3P34oq86NF526uymrPzfoZyAFl0n/YevV2//1QhiO/qqhnyUMtDQov?=
 =?us-ascii?Q?TDZ9B6mH8clsxhbS7sCPdPsswetOGMFzbjWcaeuNWGXlzPwyNDK6r/P0Uyy8?=
 =?us-ascii?Q?6rIGc1dBCIvmp/mWnTKwwa944ihEBuQ7ppBEgp5g4V/5/VfseziECGLKbPTE?=
 =?us-ascii?Q?2Xvt2bCN+1KtKt9Rped2gS0fk4AATC07Y2tJla9ZRYf+pjOPPvxoalTDDRKy?=
 =?us-ascii?Q?4HCi5N7OXgwamqBhEEIq4s8H4NhAGZdYUJff46ef1H3wi5vQP1Buv5RDL6rJ?=
 =?us-ascii?Q?c9FyumOXZzYFN/y4pRJJT9K7lJgsf9FX3himrb626qvqr67HgU4J+WxPqxod?=
 =?us-ascii?Q?4oVERWZ3Aum29S2tN3XJg6yOmL80JYwO6RBUyp0AvbWbciDw+6h8PVKtSdG4?=
 =?us-ascii?Q?UqQ4V/sloViiD/soVIJOSGeeCkWidleSck1nvCPfCGUwNbZuD0580nksFHKg?=
 =?us-ascii?Q?jHTRd/lPbsxd+3hsFPGElTJ8DkebYPaw0WbRNbwiGQ5WTZgcpy/TzTiaOkTA?=
 =?us-ascii?Q?uvgG1W/n0pcPf5glNoSnmiQ9p2l6Q2DapcSZNrhqvIA6Kzz5LmVfH/fZFSIa?=
 =?us-ascii?Q?cTeIAYzQDVK8dNaB0Fm38hdDklp9+/Nz0mDUNGrtz8eopxUuvnFVFG8eEi/s?=
 =?us-ascii?Q?hxBVR3H3Ng=3D=3D?=
X-Exchange-RoutingPolicyChecked: rP4jDAxBJXuzioZriNbNi9xZuo22HxxHoHwp9ZLIW847/l4XutGzW02KlcahErp2gQ3NRvfcKNfjfeme8wmB3a8qSOGdcAGxq1OiPPYPK4FXyBF4/26XukP3F5X0U1e55EBP39p/rXl+Ylp7E3OEfZYi59T2m4kbjZmd84Vh5AyvHPFxPxSFyVDwKIPQzunzkcUBAQ06vJmJrZAIhTqaJvgCLxMn3VyqpqAuIegpX3CXXddzFfx6G3eYe9DSTOoabxIPb6bRROgRGEvSOMHtu5eELvr2cf8waVmjIMarzaHTTtaazHGVlpFV2WGjAKr1BLVmhhyuwew5zzFFeg1RnA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 81724a44-d6ca-4c00-0135-08dee6ab6b77
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 22:08:25.1019 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ++faZiPtlelUAtw1nSJPuixwuv0M8jsHju9FsKBtKsLZlH0uj1bs0zE3p+WXh3EHvUmQMJ61BODEfKqAfq09pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF25B1C4D24
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

On Mon, Jul 20, 2026 at 03:46:00PM +0100, Matthew Wilcox wrote:
> On Mon, Jul 20, 2026 at 04:41:41PM +0200, Christoph Hellwig wrote:
> > >   /**
> > >  - * ttm_backup_backup_page() - Backup a page
> > >  + * ttm_backup_backup_folio() - Backup a folio
> > >    * @backup: The struct backup pointer to use.
> > >  - * @page: The page to back up.
> > >  - * @writeback: Whether to perform immediate writeback of the page.
> > >  + * @folio: The folio to back up.
> > >  + * @order: The allocation order of @folio.  Since TTM allocates higher-order
> > >  + *         pages without __GFP_COMP, folio_nr_pages(@folio) would always
> > >  + *         return 1; the caller must pass the true order explicitly.
> 
> Wait, what?  This is just broken.  TTM should change to allocate using
> GFP_COMP.  Why can't graphics people ask questions before writing stupid
> patches?
> 

To be honest, I have no idea why TTM doesn't set GFP_COMP. This
predates my work in graphics by nearly a decade.

I found the following comment in TTM, which was added in this patch:
`git format-patch -1 bf9eee249ac20`

As far as I can tell, setting GFP_COMP would make things a lot easier in
a number of places.

Christian, who maintains TTM, is out for a couple of weeks, but this is
something we should probably take a closer look at.

Sorry for sending a stupid patch.

Matt
