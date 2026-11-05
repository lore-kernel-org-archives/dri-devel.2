Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E1F606A329
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 03:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=m20nfX8P
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F247510EF24;
	Thu,  5 Nov 2026 03:21:23 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 605D710EE2E;
 Thu,  5 Nov 2026 03:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793848877; x=1825384877;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=fnwY+YjqvsZ0cnvPOv4zB0ZExpa+iCBtembBvVB88Mc=;
 b=m20nfX8P9Cbi4gXIkNbYBF+YwNbL3ySsF/ExOXMdtdFVHzYXulfIwJMi
 l1QzV/DzxJCd+SUiXOF5iQIdaVr/XcBB1QzQKlsDDgdOOAA7EBWduXC1Q
 5h5zC/wOfsggI+ceJf8OSOHc44x7u3QcLFZNKzWCtDDhTywM4vD37b/MU
 AvODXzM07gsMIjVEHPV3HS//08C58souLdBSyQx5Ga0bucZu/gzB0ekcW
 ykAVomoHXgZvkSZXhGiHqeAYadZMTDrpXTdHn/pkJbzTMmEVRjXrMOWcY
 DOJGMr7Fl64DSRUSTBuzzMfmuPVjcaW9iVV84efJtRCR6SFcEPQUpZcud g==;
X-CSE-ConnectionGUID: Vx2LR7eCRkem4y0M7RDNow==
X-CSE-MsgGUID: PFjGO2hsTZmHyqm3d4ECeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2524682"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2524682"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 19:21:17 -0800
X-CSE-ConnectionGUID: TV8sxM6GRt61A58ZegDTZQ==
X-CSE-MsgGUID: zOFBANTgQzq+g/t6pcsltA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="6791285"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 19:21:17 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 19:21:16 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 19:21:16 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.10) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 19:21:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cZ3n7x7KdE2leDvzHlOJ9iffRJoS1zXPQ3NeNtr0lLyMLpes7KQ5AtZUxBiPlKBxbp4qe+7Bc9CUKGpdTCYO0mLStkP05ajD7dmR2Xw9EjAtpGmaYdw5PCcPSuOmSEWs16qPsR8AxQQ+lhc/1jkO3/Rotf2NllQCgqaGNC4Md8Altm+eCD5X+SSSyZ79m7GhqMkgz3NlETPCkh8Lw87fPM7Rp93JWRSrNgXIkYCPpPf/LtpCDjqTNV7QaMTBTPCCK3sS6Ys86XuOyFSZk75KqD8DRhqwxBTj/MuoZpgb/Zh3Tcm68JtnTgkVRKUuD/Bp57ZAN/wXerCMeC/JlJhjVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPwc+GzKyq4QLK6mt40C0L4/7o7Yy2YLZxar0YZ7+bg=;
 b=Otai7uUfoAsF7n9VGCNmVad0omevBgbb8n3FakaBkoDSZnUVnG4FupeHW9f2gq39TvzgRoMH5Uc2uPEpmdZB5cZnuJgajS2OPZvL3bQXNVIt5kjlZmwB/8UjRgQmcAtLoumykEISknDpuxiXN3qfsGuCARtDOn0TVvMuO+bXRR6Dg4FKxgME8SIPywheH5aMm0zZgiyabhCuJK1IIIZM5cKlfgfuuDOH1QT+KQVc+FkJkGUarb34My221L/PR/WYgiNR5UyTJMqWjPi1rR4xwMjBxQ0j7OwTD+JkO9+3nVyxzOfCi1Iaau+NXyKmtnXIHfkgUzoNJFhScFHliX2Mww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by DS6PR11MB689623.namprd11.prod.outlook.com (2603:10b6:8:46a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 03:21:13 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0569.011; Thu, 5 Nov 2026
 03:21:13 +0000
Date: Wed, 4 Nov 2026 19:21:11 -0800
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 2/2] drm/xe: Add debugfs stats for DMA-mapped pages per
 order
Message-ID: <auv2J_i_6XMY97km@nvishwa1-desk>
References: <20261104215228.1533692-1-matthew.brost@intel.com>
 <20261104215228.1533692-2-matthew.brost@intel.com>
 <auvY60zG8V-Yq1Kx@nvishwa1-desk>
 <auvuqP4O68IfuBek@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <auvuqP4O68IfuBek@gsse-cloud1.jf.intel.com>
X-ClientProxiedBy: SJ0PR03CA0297.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::32) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|DS6PR11MB689623:EE_
X-MS-Office365-Filtering-Correlation-Id: 376ff4a8-b266-490c-8917-08df3aebd855
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|6133799003|18002099003|22082099003|260925022911599003|260925021911599003|260925021311599003|261009221227099003|261009223027099003|261021121427099003|261021123027099003|261028144727099003|261022105027099003|10067099003|261022075727099003|261026121527099003|261026140227099003|56012099006|11063799006|4143699003|261102130727099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: u2AdX1ghKZ0TsCMrGABwdRpqdLlVXSngTDwrmevKw6bH4o5vKQbdFpYZ1i8m500ZFIMJtxSsRm0myCxLXQgh0HXK7Wr0NkTgVpCmNGrcapWCahxeuZ51fTKTEWDv2d1riSZ3qM3kiuj6TBxM/7kVwTO7OpxgDKo7Gj/zN4TnR4UYo4Ogv6q0P1jAT6EaRMmE0+CI9tAjT4+z52Rq3+IEiSdax99tllCmkKDa3JaRlyOMKv5ChzX69VHinGM00f+KNnP/A9iiTQ+h8k7Xbcv+KTOHdScNXhnLLHWmNrsSYbWt6dsqswpx3KbS8R2M9/FSU/Wj/1758Colr8d6eiZoHjctCnBL6g3QH5J8R88LlDFJAqNolUC8Rujk8kEG7Cwznue5uvkPlpI4AbqMoNpqQuat/ocRNAV/+bMZDk0n0mzRfga2fdI7nvHU5w5MEdnpgm1kwIRIEB6VYtUzLEOWxa2suISN5o51TxFnObnBLM4R3e/wNRP4x06V8MAeWDrkvXV0wLF58VAV2RJc4d85/02sunsyHadGfoq/Yd2+itwUlQhxNDezBtys39IMxCZWZ+7hsqtn+MvSTuvjjPL4wDufsOC84lGbIrmcEbKj2m2xxjpMTekg8HwUxfcogvuKsr9ca6zvyUZIV/nmRHic/vvYYaB20QQaraDTYfeXdcA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(260925022911599003)(260925021911599003)(260925021311599003)(261009221227099003)(261009223027099003)(261021121427099003)(261021123027099003)(261028144727099003)(261022105027099003)(10067099003)(261022075727099003)(261026121527099003)(261026140227099003)(56012099006)(11063799006)(4143699003)(261102130727099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?8imv5+GhZigjUwxFelsuTo3Xi5yVsYir3/vqJ608aumoZhPw3dJz0Hokpn?=
 =?iso-8859-1?Q?k3wfQPVJe323ix6nyE7sSfDccufJ0lYoqIYy+xkQUthouNAEOD+gM3sfxB?=
 =?iso-8859-1?Q?slszMXvauzqN9vpujlwwucWQiwa5DLlGO4O3vohojaAfl4Yx159waVjyGH?=
 =?iso-8859-1?Q?KI0HnBbwrMrQh3fxIzbSDn6qjOcaVj4y1FWo8AlSpsfTOrXgWdW4Y83tSE?=
 =?iso-8859-1?Q?qkzJxfdxXYtipizebzRBUbtAOkEyMQdADkXu/Sa8eBMDTiybPJ9jbV282g?=
 =?iso-8859-1?Q?COQGOw/OfBZsSzmu+Tnn/QGzJPe43V6BF8WeQZKcTgQqGV/Pwf+59kFNKa?=
 =?iso-8859-1?Q?GiAl6dXIfpOi+eqOV9kU2n32ZJbhuRK1gIB3WB5uo7ckmhsQkg7Q+ohhoU?=
 =?iso-8859-1?Q?cZ2kDvguLLr8f/uNsqPSDmmDdRcwPD39vTXXuMUUMG2nIMtivf5C1pSBXv?=
 =?iso-8859-1?Q?t5gOJsdLfARJGp3iQj8zcD+BpA4hkURZ/JN03xkIcmJGvlRFof0myE9ZZX?=
 =?iso-8859-1?Q?+VS71hTaP0rY87HwQ7ftH0yiK0iFrmGpp1C729asXjYsGm1XRKuQs/70gl?=
 =?iso-8859-1?Q?dgGCzjWxBT6/snN5YTtB1d4jyuDdhOh7sTgGGYUD453AvYoqRIoLDMp5QE?=
 =?iso-8859-1?Q?WaL++B5WMHc+ycceqOhzQLiFgRpRwOES7PrTDwF2FL11vz7t65CGf+FztG?=
 =?iso-8859-1?Q?tih9p0uObi+5zYn0U79DhQ1TmRFPETWfyMt6fbYRRY23HtCZxdsHd79eO1?=
 =?iso-8859-1?Q?en8gQwOiBYoygp6zJrZ+iEsHgpxWxLwVgo08afDBa1EllOLSPRnP/PQnfb?=
 =?iso-8859-1?Q?6S4NvA3C7N6fwfllfz4kH2swOjdmqu6yKqmxXvxmDws9Qk0aiH9aH/JV64?=
 =?iso-8859-1?Q?JQHUfzAUT6pVo4HljAyoZ6gn3Pis3cOv5f+d4wRirlbNtU6yQwi/lDYpI4?=
 =?iso-8859-1?Q?ST4IOvALwwfxq1bpJ/TxQOya8TUBaswaQYKzSpK04RmU2LrXQ2Jso3SBYI?=
 =?iso-8859-1?Q?Lqro/djrhI4W2slFuT4bsTJxajAf/rJQj2Zg9i67wLteQKBt2JsIOhE57V?=
 =?iso-8859-1?Q?4dAT1VL33GvHsRhU/sZhHfEaLuCVB2G5dOwPHyevWHG2qZolNjfo+tCb/s?=
 =?iso-8859-1?Q?g9N2Z1aipsKUrK0XDO8LevekSpNv2I0zg/B1ah5VkCJe15Td0BCUrIX4x3?=
 =?iso-8859-1?Q?Wp2+R3Pmv1LV0qM8E8YiI2VVRam0fhIA5tKkCaLyw1SdB5LROsjObrm3Vz?=
 =?iso-8859-1?Q?bOWsL3Fn4E5bw5v6I+yJ8M3utlxt+6DVcrlo/mkB088jfvTkcCslNzTB9A?=
 =?iso-8859-1?Q?MfUkahoqnm84nw68qzlDt2Af+18pzIE6GRrlvzsEgijzBgqBx09NWTzveQ?=
 =?iso-8859-1?Q?rYcaThSHE2HP/gKRdiNvPM3G1LB9mqpqtEknavQnUJG6ZpM/gj98GmTqy8?=
 =?iso-8859-1?Q?oJBwCGuNAjHnQHOeqDIYT2S9WiMLPH7FzueDZ5PZzb/rAjHzTMqfNRKCJ+?=
 =?iso-8859-1?Q?NMGRIb48SuaUrFbtBYses4WSUG1ykGbTe8Q569Sv0UFQk1Gaj4U4qtOECG?=
 =?iso-8859-1?Q?7Jw7Uh9BbhkDpuZutkhmBPKFCdrsTjB/3DKf3qwgBQ3/h9cNouirNaghkw?=
 =?iso-8859-1?Q?BObylmKzuCIPCmtDwIllF0mXjmt0Uj78xl609joCY9h6o8GXtLxwVhf8KO?=
 =?iso-8859-1?Q?tl7yjNwWLayzkNPVlgolyJf6KoMEDWH1wy9rAtlBl0U8H5vl+C4irCMw3f?=
 =?iso-8859-1?Q?4ktZ3tTwHLzznCxUKCdGBw0mBnfy5XD2VmGeMjZC5/uu82t3ea6w0emjrT?=
 =?iso-8859-1?Q?GlB3s2nM8b+W7Z65qgBxoxB2QJYiCY75QAmj/0ouR0x7T6M3n4Ad?=
X-Exchange-RoutingPolicyChecked: SuBtv2HGvVnKlkbksK1lob7Ce4KqUL+qTNU/3g7ax+2Lo9bTL2PCFy8gWcJQE47UmsVCHJ9yFflrQNjN6+gGeAGYYXl3WWR14zRdFsXnTlejNbnA4xnSzRiO24QXO31mDtVYSjOc2Aep/0/ctrvgFyBqwk3r0cZNO91jh4wN0bkBe0gghDoQqceTWwv/EPNj9D73doko8Ug40P1qEnHksSOsxDpD2qP+1xgpSCTewkFzNzGdsBzZj76CbSq1QsrS8MkmwH3YBioO8cTq+vyOYmoPcexqEdcHCJqBfQWtg48t5YbQYE8uqAAiyMLvXiBUKnbE5bPefKGMKlLUALR0AA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 376ff4a8-b266-490c-8917-08df3aebd855
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 03:21:13.2885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5YJHVvvO42X0kyrLgR8TcU9G5py0S4pXfzApo3YCbqlAawIe3qTNfZgGjt4VEalzbxAdl3TLcFpjP9XkN6C2fd+Olt/La/qN+7f19ux+Qqcl2imPgmrkGKzgi1B1bkrV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB689623
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

On Wed, Nov 04, 2026 at 06:49:12PM -0800, Matthew Brost wrote:
>On Wed, Nov 04, 2026 at 05:16:27PM -0800, Niranjana Vishwanathapura wrote:
>> On Wed, Nov 04, 2026 at 01:52:28PM -0800, Matthew Brost wrote:
>> > From: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>> >
>> > Expose per-page-order DMA mapping counts for the system memory that the
>> > xe driver maps for GPU access, split into two categories: TTM buffer
>> > objects, and the GPU SVM / userptr ranges (which share a single
>> > drm_gpusvm instance per VM).
>> >
>> > The stats are visible at:
>> >
>> >  <debugfs>/dri/<N>/dma_mapped_pages
>> >
>> > and are broken out into two rows (bo, svm/userptr), one column per page
>> > order, mirroring the layout of the TTM pool page_pool stat.
>> >
>> > For TTM BOs the per-order counts are derived from the DMA scatter-gather
>> > table: each mapped segment is physically contiguous, so its page count is
>> > split into the largest power-of-two runs (a segment of N pages contributes
>> > a 2^k chunk for the largest k with 2^k <= N, repeated for the remainder).
>> > Driving the accounting off the sg table rather than the pages[] array keeps
>> > it correct even when pages[] entries are cleared while still DMA-mapped,
>> > as happens on the defrag page-borrowing path. Dma-buf BOs are not
>> > accounted for in dma_mapped_pages stats.
>> >
>> > For the SVM and userptr ranges the accounting is driven by the
>> > drm_gpusvm @dma_map_account callback, which fires once per dma_addr[]
>> > entry at the exact point the entry is DMA-mapped and unmapped. This
>> > makes the accounting symmetric by construction and avoids driver-side
>> > walks that could drift across migration, partial unmaps and the iova vs
>> > non-iova paths. Only DRM_INTERCONNECT_SYSTEM entries are real DMA maps
>> > and counted; device interconnect (VRAM, P2P) entries are skipped, so the
>> > counter reflects only system pages actually mapped through the DMA layer.
>> >
>> > The callback is shared between the full SVM instance (fault mode) and the
>> > core drm_gpusvm_pages-only instance used for userptr, so userptr
>> > mappings are accounted in both the CONFIG_DRM_XE_GPUSVM=y and =n (but
>> > CONFIG_DRM_GPUSVM=y) configurations, into the same svm/userptr counter.
>> >
>> > Since the counts are only ever consumed through debugfs, gate the counter
>> > storage and all accounting on CONFIG_DEBUG_FS so that builds without
>> > debugfs carry no extra atomic traffic or device state; the drm_gpusvm
>> > callback is simply left unregistered in that case.
>> >
>> > On device teardown assert that every counter has returned to zero, to
>> > catch any unbalanced accounting (a leaked DMA mapping) during testing.
>> >
>> > Assisted-by: LLM
>> > Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>> > ---
>> > drivers/gpu/drm/xe/xe_bo.c           | 53 ++++++++++++++++++++---
>> > drivers/gpu/drm/xe/xe_debugfs.c      | 26 ++++++++++++
>> > drivers/gpu/drm/xe/xe_device.c       | 30 +++++++++++++
>> > drivers/gpu/drm/xe/xe_device_types.h | 17 ++++++++
>> > drivers/gpu/drm/xe/xe_svm.c          | 44 ++++++++++++++++++-
>> > drivers/gpu/drm/xe/xe_svm.h          |  4 +-
>> > drivers/gpu/drm/xe/xe_userptr.c      | 63 ++++++++++++++++++++++++++++
>> > drivers/gpu/drm/xe/xe_userptr.h      |  1 +
>> > 8 files changed, 230 insertions(+), 8 deletions(-)
>> >
>> > diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
>> > index 42a6aa1a2e4a..a8031cb9c74f 100644
>> > --- a/drivers/gpu/drm/xe/xe_bo.c
>> > +++ b/drivers/gpu/drm/xe/xe_bo.c
>> > @@ -396,6 +396,50 @@ struct xe_ttm_tt {
>> > 	bool purgeable;
>> > };
>> >
>> > +/*
>> > + * xe_tt_account_dma_pages - account DMA-mapped tt pages per order
>> > + * @xe: the xe device
>> > + * @xe_tt: the xe_ttm_tt whose sg table to walk
>> > + * @sign: +1 to add, -1 to subtract
>> > + *
>> > + * Walk the tt's DMA scatter-gather table and split each (physically
>> > + * contiguous) segment into the largest power-of-two page runs: a segment of N
>> > + * pages contributes a 2^k chunk for the largest k with 2^k <= N, repeated for
>> > + * the remainder. Accumulate the count of 2^k pages into
>> > + * xe->mem.dma_mapped_pages[k]. Driving this off the sg table rather than
>> > + * tt->pages keeps the accounting correct even when pages[] entries are cleared
>> > + * while still DMA-mapped (e.g. the defrag page-borrowing path).
>> > + */
>> > +#if IS_ENABLED(CONFIG_DEBUG_FS)
>> > +static void xe_tt_account_dma_pages(struct xe_device *xe,
>> > +				    struct xe_ttm_tt *xe_tt, int sign)
>> > +{
>> > +	struct scatterlist *sg;
>> > +	unsigned int i;
>> > +
>> > +	for_each_sgtable_sg(xe_tt->sg, sg, i) {
>> > +		unsigned long nr_pages = sg->length >> PAGE_SHIFT;
>> > +
>> > +		while (nr_pages) {
>> > +			unsigned int order = min_t(unsigned int,
>> > +						   __fls(nr_pages),
>> > +						   MAX_PAGE_ORDER);
>> > +			unsigned long chunk = 1UL << order;
>> > +
>> > +			atomic_long_add((long)chunk * sign,
>> > +					&xe->mem.dma_mapped_pages[order]);
>> > +
>>
>> Here both array index and array value is clamped.
>> But in the svm case below, only the array index is clamped, but not the value.
>> I guess here we don't expect huge pages? If so, should we be clamping here
>> or asserting if order is bigger than MAX_PAGE_ORDER?
>>
>
>What? I'm not following this at all.
>
>The SVM case we clamp the index to the highest order + add the actual order.
>
>Here we decompose a segment to into individual orders, clamping at the
>highest order.

I mean, in this case, the value is 'chunk' which is based on clamped order.
In svm case below, the value is '(1UL << addr->order)', where addr->order is not clamped.

Niranjana

>
>> > +			nr_pages -= chunk;
>> > +		}
>> > +	}
>> > +}
>> > +#else
>> > +static void xe_tt_account_dma_pages(struct xe_device *xe,
>> > +				    struct xe_ttm_tt *xe_tt, int sign)
>> > +{
>> > +}
>> > +#endif
>> > +
>> > static int xe_tt_map_sg(struct xe_device *xe, struct ttm_tt *tt)
>> > {
>> > 	struct xe_ttm_tt *xe_tt = container_of(tt, struct xe_ttm_tt, ttm);
>> > @@ -425,6 +469,7 @@ static int xe_tt_map_sg(struct xe_device *xe, struct ttm_tt *tt)
>> > 		return ret;
>> > 	}
>> >
>> > +	xe_tt_account_dma_pages(xe, xe_tt, 1);
>> > 	return 0;
>> > }
>> >
>> > @@ -433,6 +478,7 @@ static void xe_tt_unmap_sg(struct xe_device *xe, struct ttm_tt *tt)
>> > 	struct xe_ttm_tt *xe_tt = container_of(tt, struct xe_ttm_tt, ttm);
>> >
>> > 	if (xe_tt->sg) {
>> > +		xe_tt_account_dma_pages(xe, xe_tt, -1);
>> > 		dma_unmap_sgtable(xe->drm.dev, xe_tt->sg,
>> > 				  DMA_BIDIRECTIONAL, 0);
>> > 		sg_free_table(xe_tt->sg);
>> > @@ -1800,11 +1846,8 @@ int xe_bo_dma_unmap_pinned(struct xe_bo *bo)
>> > 			ttm_bo->sg = NULL;
>> > 			xe_tt->sg = NULL;
>> > 		} else if (xe_tt->sg) {
>> > -			dma_unmap_sgtable(ttm_to_xe_device(ttm_bo->bdev)->drm.dev,
>> > -					  xe_tt->sg,
>> > -					  DMA_BIDIRECTIONAL, 0);
>> > -			sg_free_table(xe_tt->sg);
>> > -			xe_tt->sg = NULL;
>> > +			xe_tt_unmap_sg(ttm_to_xe_device(ttm_bo->bdev),
>> > +				       &xe_tt->ttm);
>> > 		}
>> > 	}
>> >
>> > diff --git a/drivers/gpu/drm/xe/xe_debugfs.c b/drivers/gpu/drm/xe/xe_debugfs.c
>> > index e59d4964d811..1a306b6523e7 100644
>> > --- a/drivers/gpu/drm/xe/xe_debugfs.c
>> > +++ b/drivers/gpu/drm/xe/xe_debugfs.c
>> > @@ -7,6 +7,7 @@
>> >
>> > #include <linux/bits.h>
>> > #include <linux/debugfs.h>
>> > +#include <linux/mmzone.h>
>> > #include <linux/fault-inject.h>
>> > #include <linux/string_helpers.h>
>> >
>> > @@ -345,6 +346,28 @@ static int dgfx_pcie_link_residencies_show(struct seq_file *m, void *data)
>> > 	return 0;
>> > }
>> >
>> > +static int dma_mapped_pages_show(struct seq_file *m, void *data)
>> > +{
>> > +	struct xe_device *xe = m->private;
>> > +	unsigned int i;
>> > +
>> > +	seq_printf(m, "%-11s ", "");
>> > +	for (i = 0; i < NR_PAGE_ORDERS; i++)
>> > +		seq_printf(m, " ---%2u---", i);
>> > +	seq_printf(m, "\n%-11s:", "bo");
>> > +	for (i = 0; i < NR_PAGE_ORDERS; i++)
>> > +		seq_printf(m, " %8lu",
>> > +			   atomic_long_read(&xe->mem.dma_mapped_pages[i]));
>> > +	seq_printf(m, "\n%-11s:", "svm/userptr");
>> > +	for (i = 0; i < NR_PAGE_ORDERS; i++)
>> > +		seq_printf(m, " %8lu",
>> > +			   atomic_long_read(&xe->mem.dma_mapped_pages_svm[i]));
>>
>> The array values are signed long, but printed as unsigned.
>> Should we use '%8l' instead of '%8lu'?
>>
>
>If we ever underflow that is problem, I guess %8l would have that clear.
>
>> Also, under each order column, we are not printing the number of pages
>> of that order, but instead the 4kb page count mapped in that order.
>> Is that intended?
>
>Yes.
>
>> As we are counting huge pages in the highest order bucket, counting the
>> 4kb page count seems necessary here. But perhaps needs to be documented.
>>
>
>A segment can be larger NR_PAGE_ORDERS, thus we clamp large segments
>into the highest order. I don't we really need much an explaination, the
>debugfs clearly shows if we getting higher order pages, which is the
>information we are looking for during debug of perf problems on iGPU.
>
>> Niranjana
>>
>> > +	seq_puts(m, "\n");
>> > +
>> > +	return 0;
>> > +}
>> > +DEFINE_SHOW_ATTRIBUTE(dma_mapped_pages);
>> > +
>> > static const struct drm_info_list debugfs_list[] = {
>> > 	{"info", info, 0},
>> > 	{ .name = "sriov_info", .show = sriov_info, },
>> > @@ -765,6 +788,9 @@ void xe_debugfs_register(struct xe_device *xe)
>> >
>> > 	xe_ttm_vram_debugfs_init(xe, root);
>> >
>> > +	debugfs_create_file("dma_mapped_pages", 0444, root, xe,
>> > +			    &dma_mapped_pages_fops);
>> > +
>> > 	for_each_tile(tile, xe, tile_id)
>> > 		xe_tile_debugfs_register(tile);
>> >
>> > diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
>> > index 273e2c45fea9..c40bb8f7c697 100644
>> > --- a/drivers/gpu/drm/xe/xe_device.c
>> > +++ b/drivers/gpu/drm/xe/xe_device.c
>> > @@ -377,12 +377,42 @@ bool xe_device_is_admin_only(const struct xe_device *xe)
>> > /* Number of allocated struct xe_device */
>> > static atomic_t xe_device_count;
>> >
>> > +#if IS_ENABLED(CONFIG_DEBUG_FS)
>> > +static void xe_device_assert_dma_pages_zero(struct xe_device *xe)
>> > +{
>> > +	unsigned int i;
>> > +
>> > +	/*
>> > +	 * All BOs, userptr VMAs and SVM ranges must have been torn down by the
>> > +	 * time the device is destroyed, so every DMA-mapped-pages counter must
>> > +	 * have returned to zero. A non-zero value indicates unbalanced
>> > +	 * accounting, i.e. a missing unmap-side decrement.
>> > +	 */
>> > +	for (i = 0; i < NR_PAGE_ORDERS; i++) {
>> > +		xe_assert(xe, !atomic_long_read(&xe->mem.dma_mapped_pages[i]));
>> > +		xe_assert(xe, !atomic_long_read(&xe->mem.dma_mapped_pages_svm[i]));
>> > +	}
>>
>> xe_assert() is only valid with CONFIG_DRM_XE_DEBUG.
>> So, it is kind of tied to CONFIG_DRM_XE_DEBUG. So, it goes back to original
>> comment as to if we should make it xe debug specific and only make the
>> debugfs interface part CONFIG_DEBUG_FS specific?
>> I am fine either way.
>>
>> > +}
>> > +#else
>> > +static void xe_device_assert_dma_pages_zero(struct xe_device *xe)
>> > +{
>> > +}
>> > +#endif
>> > +
>> > static void xe_device_destroy(struct drm_device *dev, void *dummy)
>> > {
>> > 	struct xe_device *xe = to_xe_device(dev);
>> >
>> > 	xe_bo_dev_fini(&xe->bo_device);
>> >
>> > +	/*
>> > +	 * Assert the DMA-mapped-pages accounting only after xe_bo_dev_fini()
>> > +	 * has flushed the async BO-free worker: BOs pending async free still
>> > +	 * hold their DMA mappings (and counts) until the worker runs, so
>> > +	 * asserting before the flush could trip a false positive.
>> > +	 */
>> > +	xe_device_assert_dma_pages_zero(xe);
>> > +
>> > 	if (xe->preempt_fence_wq)
>> > 		destroy_workqueue(xe->preempt_fence_wq);
>> >
>> > diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
>> > index d99881c6e1d5..e816db751da4 100644
>> > --- a/drivers/gpu/drm/xe/xe_device_types.h
>> > +++ b/drivers/gpu/drm/xe/xe_device_types.h
>> > @@ -6,6 +6,7 @@
>> > #ifndef _XE_DEVICE_TYPES_H_
>> > #define _XE_DEVICE_TYPES_H_
>> >
>> > +#include <linux/mmzone.h>
>> > #include <linux/pci.h>
>> >
>> > #include <drm/drm_device.h>
>> > @@ -302,6 +303,22 @@ struct xe_device {
>> > 		struct xe_shrinker *shrinker;
>> > 		/** @mem.stolen_mgr: stolen memory manager. */
>> > 		struct xe_ttm_stolen_mgr *stolen_mgr;
>> > +#if IS_ENABLED(CONFIG_DEBUG_FS)
>> > +		/**
>> > +		 * @mem.dma_mapped_pages: number of DMA-mapped pages per page
>> > +		 * order currently live for this device, for TTM BOs. Only
>> > +		 * accounted when CONFIG_DEBUG_FS is enabled, since it is solely
>> > +		 * exposed through debugfs.
>> > +		 */
>> > +		atomic_long_t dma_mapped_pages[NR_PAGE_ORDERS];
>> > +		/**
>> > +		 * @mem.dma_mapped_pages_svm: number of DMA-mapped pages per
>> > +		 * page order currently live for this device, for SVM ranges
>> > +		 * and userptr VMAs (both share a single drm_gpusvm instance).
>> > +		 * Only accounted when CONFIG_DEBUG_FS is enabled.
>> > +		 */
>> > +		atomic_long_t dma_mapped_pages_svm[NR_PAGE_ORDERS];
>> > +#endif
>> > 	} mem;
>> >
>> > 	/** @sriov: device level virtualization data */
>> > diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
>> > index 909a602d091e..7a4988289749 100644
>> > --- a/drivers/gpu/drm/xe/xe_svm.c
>> > +++ b/drivers/gpu/drm/xe/xe_svm.c
>> > @@ -845,10 +845,50 @@ static int xe_svm_get_pagemaps(struct xe_vm *vm)
>> > }
>> > #endif
>> >
>> > +#if IS_ENABLED(CONFIG_DEBUG_FS)
>> > +/*
>> > + * xe_svm_dma_map_account - drm_gpusvm DMA-mapping accounting callback
>> > + * @gpusvm: The GPU SVM the mapping belongs to
>> > + * @addr: The address descriptor of the chunk being (un)mapped
>> > + * @sign: +1 when @addr was DMA-mapped, -1 when it is being unmapped
>> > + *
>> > + * Maintain per-order counts of the system-memory pages that the full SVM
>> > + * instance (SVM ranges, and userptr VMAs in fault mode) has DMA-mapped for GPU
>> > + * access. Only DRM_INTERCONNECT_SYSTEM entries are real DMA maps and counted;
>> > + * device interconnect (VRAM, P2P) entries are skipped. The counts are solely
>> > + * exposed through debugfs, so the callback is only registered when
>> > + * CONFIG_DEBUG_FS is enabled.
>> > + */
>> > +static void xe_svm_dma_map_account(struct drm_gpusvm *gpusvm,
>> > +				   const struct drm_pagemap_addr *addr,
>> > +				   int sign)
>> > +{
>> > +	struct xe_device *xe = gpusvm_to_vm(gpusvm)->xe;
>> > +	unsigned int order = addr->order;
>> > +
>> > +	if (addr->proto != DRM_INTERCONNECT_SYSTEM)
>> > +		return;
>> > +
>> > +	/*
>> > +	 * The CPU-PTE map order reported by hmm can exceed MAX_PAGE_ORDER
>> > +	 * (e.g. an order-18 1GB mapping), so clamp the array index to avoid an
>> > +	 * out-of-bounds access. Clamping is symmetric across the +1/-1 calls,
>> > +	 * so the per-order counters stay balanced.
>> > +	 */
>> > +	order = min(order, (unsigned int)NR_PAGE_ORDERS - 1);
>> > +
>> > +	atomic_long_add((long)(1UL << addr->order) * sign,
>> > +			&xe->mem.dma_mapped_pages_svm[order]);
>> > +}
>>
>> This seems identical to xe_userptr_dma_map_account() except that there
>> gpusvm_to_vm() helper is not there, hence needs to be expanded.
>> Can we combine these two helpers into one?
>>
>
>I guess one of files can export it and they can share code.
>
>Matt
>
>> > +#endif
>> > +
>> > static const struct drm_gpusvm_ops gpusvm_ops = {
>> > 	.range_alloc = xe_svm_range_alloc,
>> > 	.range_free = xe_svm_range_free,
>> > 	.invalidate = xe_svm_invalidate,
>> > +#if IS_ENABLED(CONFIG_DEBUG_FS)
>> > +	.dma_map_account = xe_svm_dma_map_account,
>> > +#endif
>> > };
>> >
>> > static const unsigned long fault_chunk_sizes[] = {
>> > @@ -946,8 +986,8 @@ int xe_svm_init(struct xe_vm *vm)
>> > 		}
>> > 	} else {
>> > 		err = drm_gpusvm_init(&vm->svm.gpusvm, "Xe SVM (simple)",
>> > -				      NULL, 0, 0, 0, NULL,
>> > -				      NULL, 0);
>> > +				      NULL, 0, 0, 0,
>> > +				      xe_userptr_gpusvm_ops_get(), NULL, 0);
>> > 		if (err)
>> > 			goto out_err;
>> > 	}
>> > diff --git a/drivers/gpu/drm/xe/xe_svm.h b/drivers/gpu/drm/xe/xe_svm.h
>> > index ffc1cc808102..f8b908a74ba9 100644
>> > --- a/drivers/gpu/drm/xe/xe_svm.h
>> > +++ b/drivers/gpu/drm/xe/xe_svm.h
>> > @@ -249,6 +249,7 @@ struct drm_pagemap *xe_drm_pagemap_from_fd(int fd, u32 region_instance);
>> >
>> > #else
>> > #include <linux/interval_tree.h>
>> > +#include "xe_userptr.h"
>> > #include "xe_vm.h"
>> >
>> > struct drm_pagemap_addr;
>> > @@ -296,7 +297,8 @@ int xe_svm_init(struct xe_vm *vm)
>> > {
>> > #if IS_ENABLED(CONFIG_DRM_GPUSVM)
>> > 	return drm_gpusvm_init(&vm->svm.gpusvm, "Xe SVM (simple)",
>> > -			       NULL, 0, 0, 0, NULL, NULL, 0);
>> > +			       NULL, 0, 0, 0,
>> > +			       xe_userptr_gpusvm_ops_get(), NULL, 0);
>> > #else
>> > 	return 0;
>> > #endif
>> > diff --git a/drivers/gpu/drm/xe/xe_userptr.c b/drivers/gpu/drm/xe/xe_userptr.c
>> > index 9c1dac0fce6f..40f97bd4751d 100644
>> > --- a/drivers/gpu/drm/xe/xe_userptr.c
>> > +++ b/drivers/gpu/drm/xe/xe_userptr.c
>> > @@ -8,9 +8,72 @@
>> >
>> > #include <linux/mm.h>
>> >
>> > +#include <drm/drm_pagemap.h>
>> > +
>> > #include "xe_tlb_inval.h"
>> > #include "xe_trace_bo.h"
>> >
>> > +#if IS_ENABLED(CONFIG_DEBUG_FS)
>> > +/*
>> > + * xe_userptr_dma_map_account - drm_gpusvm DMA-mapping accounting callback
>> > + * @gpusvm: The GPU SVM the mapping belongs to
>> > + * @addr: The address descriptor of the chunk being (un)mapped
>> > + * @sign: +1 when @addr was DMA-mapped, -1 when it is being unmapped
>> > + *
>> > + * Account, per page order, the system-memory pages DMA-mapped for GPU access
>> > + * through the drm_gpusvm_pages instance shared by userptr (and, in fault mode,
>> > + * SVM). Only DRM_INTERCONNECT_SYSTEM entries are real DMA maps and counted;
>> > + * device interconnect (VRAM, P2P) entries are skipped. The counts are solely
>> > + * exposed through debugfs, so the callback is only registered when
>> > + * CONFIG_DEBUG_FS is enabled.
>> > + */
>> > +static void xe_userptr_dma_map_account(struct drm_gpusvm *gpusvm,
>> > +				       const struct drm_pagemap_addr *addr,
>> > +				       int sign)
>> > +{
>> > +	struct xe_vm *vm = container_of(gpusvm, struct xe_vm, svm.gpusvm);
>> > +	unsigned int order = addr->order;
>> > +
>> > +	if (addr->proto != DRM_INTERCONNECT_SYSTEM)
>> > +		return;
>> > +
>> > +	/*
>> > +	 * The CPU-PTE map order reported by hmm can exceed MAX_PAGE_ORDER
>> > +	 * (e.g. an order-18 1GB mapping), so clamp the array index to avoid an
>> > +	 * out-of-bounds access. Clamping is symmetric across the +1/-1 calls,
>> > +	 * so the per-order counters stay balanced.
>> > +	 */
>> > +	order = min(order, (unsigned int)NR_PAGE_ORDERS - 1);
>> > +
>> > +	atomic_long_add((long)(1UL << addr->order) * sign,
>> > +			&vm->xe->mem.dma_mapped_pages_svm[order]);
>> > +}
>> > +
>> > +static const struct drm_gpusvm_ops xe_userptr_gpusvm_ops = {
>> > +	.dma_map_account = xe_userptr_dma_map_account,
>> > +};
>> > +#endif
>> > +
>> > +/**
>> > + * xe_userptr_gpusvm_ops_get() - Accounting ops for the simple gpusvm instance
>> > + *
>> > + * The core drm_gpusvm_pages-only instance used for userptr (and, in fault
>> > + * mode, shared with SVM) is initialised with these ops so that DMA-mapped
>> > + * system pages are accounted and exposed through debugfs. Returns NULL when
>> > + * CONFIG_DEBUG_FS is disabled, in which case no accounting is kept and the
>> > + * instance is initialised without ops.
>> > + *
>> > + * Return: Pointer to the restricted &drm_gpusvm_ops, or NULL.
>> > + */
>> > +const struct drm_gpusvm_ops *xe_userptr_gpusvm_ops_get(void)
>> > +{
>> > +#if IS_ENABLED(CONFIG_DEBUG_FS)
>> > +	return &xe_userptr_gpusvm_ops;
>> > +#else
>> > +	return NULL;
>> > +#endif
>> > +}
>> > +
>> > static void xe_userptr_assert_in_notifier(struct xe_vm *vm)
>> > {
>> > 	lockdep_assert(lockdep_is_held_type(&vm->svm.gpusvm.notifier_lock, 0) ||
>> > diff --git a/drivers/gpu/drm/xe/xe_userptr.h b/drivers/gpu/drm/xe/xe_userptr.h
>> > index 2a3cd1b5efbb..1e9601be5713 100644
>> > --- a/drivers/gpu/drm/xe/xe_userptr.h
>> > +++ b/drivers/gpu/drm/xe/xe_userptr.h
>> > @@ -108,6 +108,7 @@ int __xe_vm_userptr_needs_repin(struct xe_vm *vm);
>> > int xe_vm_userptr_check_repin(struct xe_vm *vm);
>> > int xe_vma_userptr_pin_pages(struct xe_userptr_vma *uvma);
>> > int xe_vma_userptr_check_repin(struct xe_userptr_vma *uvma);
>> > +const struct drm_gpusvm_ops *xe_userptr_gpusvm_ops_get(void);
>> > #else
>> > static inline void xe_userptr_remove(struct xe_userptr_vma *uvma) {}
>> >
>> > --
>> > 2.34.1
>> >
