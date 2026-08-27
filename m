Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A80AC61DBD
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 02:01:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE3E110E382;
	Thu, 27 Aug 2026 02:01:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Q4LLDdwW";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EE9410E380;
 Thu, 27 Aug 2026 02:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787796094; x=1819332094;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=yC1n7A/fhmvgRzr3TLxH8HiE/70gObsG5VGHYD7nwXE=;
 b=Q4LLDdwWCMTob/A6Zr7pDIQ9hu4MOfQVa9deWu1Lvd8BNH3MQlqTk5Pa
 YPJrzn4yjQp2Nluw6xWccr80HJQEfa10cX6QfxvvaaFjQOt9b2wKq18nK
 DE6eaF1R35TRBITaNZ8BsqJkHt59gsZakNg+DUNYhiBc9btPTqNBFRTuT
 Ss/gnZciKdicMjlLyyl4KtEk+ayE1dDLlBv0tt/SZ5D4+LVQIZneFOdTh
 InKbUktP9UWqWsmcKFzar/8GA0cxBXKdNrvMqUjc4A8MLgxcY064841Bd
 d+OGkArQfVWp61GHKw5oQQoh2Zmr5o4GM9bN3NQ5ITpmTX+My01P2lVtr w==;
X-CSE-ConnectionGUID: gjDZXW+DRvG7BkR9SlwIsQ==
X-CSE-MsgGUID: Dmu8f4KVQ7WPZ/IAdfk2Kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="98889070"
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; d="scan'208";a="98889070"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2026 19:01:33 -0700
X-CSE-ConnectionGUID: jR5Lgl42RFO5UCIxNXMrVQ==
X-CSE-MsgGUID: mDlIeSHuRiCvzN2LSMi/FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; d="scan'208";a="269659215"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2026 19:01:33 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 26 Aug 2026 19:01:32 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 26 Aug 2026 19:01:32 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.11)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 26 Aug 2026 19:01:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DteKWLRQVIhhXE6Srt8QRfDbIsIzJscOblNCESRj6BTctOH0F6tPfmD0TwVsUMfmONsD1sXWvXX8ejmaUK850lE+5xtD96HNynagHCfZWOE/yhjsn4VTbxeGNCyz1rtweyYrOPsS+ymNkHE1u3hM0ztYVtox43i4cOIapXn5jfgRFGF4hfEEkdk4XT5WzAWLL9Th5w5bUZ2LQC17oX4LH/02R3eWo043xMwb6YWyF8bJS9VYniIqIWGC/IwMRcNPE1+xuwuNeGtGFkX6CUgOewAA4XF4KDKND/5c+D4iXw+t/JS7Rr5RA2x2Tr9Mt54rIA/LFNuaWxr4UKhTZZwKAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyjdkL146aYfaPs2TjTzcEwSbQ9uKg5O7MZoQvpJQyQ=;
 b=nl5f/p22midpDjRXwS3Zy2NVRPOpPMZ997Wk880V98ncjWKKOwDmzaFphjhAYblrh3tHOLTlLV2+qxPFiGu2tr4h3RmkvEDhwmIsDsa+20XaHRgxW7L3K6g0wYkkkylm6MCiWlx2V/qzj0XWkVWdenqzQOi4/OkTV2UXah11aS77nYzQOx/s6l9DGRqHuD1z6vm3PkADoQI6vP1h68rFxG63AB49/D5EGUZytYNdf06XVRmJiQ9qfnMS25eKks74JmB/xEVuSu/Svw+5LyDO1ZzSpqtJh5BPum1W/uIpNxsNBIEgrA/MjEfGcWD7KTgWcy1IWoOUTSV3A+hUbgX4yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by MN0PR11MB6277.namprd11.prod.outlook.com (2603:10b6:208:3c3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Thu, 27 Aug
 2026 02:01:25 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 02:01:24 +0000
Date: Wed, 26 Aug 2026 19:01:21 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Nathan Bourgeois <iridescentrosesfall@gmail.com>
CC: Dave Airlie <airlied@gmail.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Rodrigo
 Vivi" <rodrigo.vivi@intel.com>, Christian =?iso-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Matthew Auld <matthew.auld@intel.com>, "Simona
 Vetter" <simona@ffwll.ch>
Subject: Re: [PATCH] drm/xe: Fix unnecessary host-side population of ttm_tt
 on non-TT resources
Message-ID: <ao+acQG/wyZYNYfW@gsse-cloud1.jf.intel.com>
References: <20260820031901.1018324-1-iridescentrosesfall@gmail.com>
 <aoczaCuoaZfUkfm5@gsse-cloud1.jf.intel.com>
 <CAMpTW2cxRrG4oJ0HrRoKhHrVHxWO01-L+QDoWMLCAUaSfw75sA@mail.gmail.com>
 <CAMpTW2fxFRrpn1b5WGYBrtLLMfUo_fmx9s2D0b552GJp-sF5qg@mail.gmail.com>
 <8b7001c68c94491095f41d2a3dff45090c0a95cf.camel@linux.intel.com>
 <aoeUdfrPX+0ZnZMr@gsse-cloud1.jf.intel.com>
 <CAPM=9twBded3B553KYzwDtVd0NbhbAwbiVDGw_bdrmBnOKgtKA@mail.gmail.com>
 <CAMpTW2eXS9tBzppJvvfZ-FiwoJ5MKOAdB9sqYgCDPVQ_+___ZA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMpTW2eXS9tBzppJvvfZ-FiwoJ5MKOAdB9sqYgCDPVQ_+___ZA@mail.gmail.com>
X-ClientProxiedBy: MW4P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::34) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|MN0PR11MB6277:EE_
X-MS-Office365-Filtering-Correlation-Id: ba7dde49-171c-4f2c-ce43-08df03df1900
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|6133799003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: MltLHaWdELFmhtprSOC5q5QBrPF6ARwi1RRFEQfUYkON3s6JbBOJ/uuRwPUEbKCsNVFTWTj+DErigLoS4fTl2/eBdZ9buoHNRENhalODQYASwy3UX2X2/stm9nv4R3p7mnJtJeObzeG1os3AIFSLnSIq1pbmIQTdFxpIpQ4kC7mNoKFMOKVw4V88nDigfHAmHii7ickPJHJw6/5yMNGvjyh+hU12wbEIdEDfHzEdjzB5+HAgR28Y4L2FIVK3iSBCSYbO+4qP+8uilnl/G5gl9u0sMkqmP0UR/yDelJX/OK098MAlfhK43nibNXRvP2BNSE7Of/elKugo71bWlWq9AmZHzMZi4R0j+SXfLJ+fxHxFKo8hKP9Tk1yJ3uULlwRPbtV1f17A3ol6nepzjeL+Ze827DuB3p4/XK0DJ3fm+5TtZhxBkS808sNTDhJ8NrDstDGybpXmMQv+p52jl96HLd9AjBgsowKDx8xNAFP4qp4gX+Nq3y5JyqJeOoaZmX3W85O6M3H8ZZBuabbF2PeElXLXDG8x9rokdNMElfSP3P6LUGYPhiagPCMuUfpX5e44hKDojS04vdrLf0ZqKJi6bpVfkwLvzgSaU8JVU4wDiW4pkjugLkEuto55nLTUAvM0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2JFbGVwNDJSYWtTTDd5YTBCQ2xTeUJBYVgyM3JMUmFNMjRWRDVhZ2FjUk45?=
 =?utf-8?B?aHRkQ3NaWjRZb1hmOFJaZzBMZHBXaE0ydFR5ZEwvdEJHeG4xTEZ0YlB5QjJr?=
 =?utf-8?B?R1p0M1loczNzeE9zZEpIRUFCOUZpTkZDaE4ydG96YzMwbjRxWjRObThCZ2x6?=
 =?utf-8?B?ckJaVkhNUm1mWU5kODBqMnZkWVgxTkt1dmdZeEdIbWJ5aDFaQXBzUVErdTVM?=
 =?utf-8?B?cjYxRWdqZ2tHQUlaMUhuY0lOWXMrZUxWNzhlVWZOTzAxclcvUXYyM0EzUFdu?=
 =?utf-8?B?MTlYdWd2RXRUb1ZOL00zYXVLc1JOSmh3Qi9UVHQrT1d2UVAzS05pYk5KNUs3?=
 =?utf-8?B?ay9ScTNVS3U2VWdxRnluOUxaWkN6elFXT1pTaVJrcSszL2NCc3g5TlhyTi9K?=
 =?utf-8?B?dkp1L2dGTGdJT0p6UkFienFSSDNoT25qaEVzQkVhaU9UTzRVYVNoY25ZWDlh?=
 =?utf-8?B?UHM2TXBId1Z6bmkranBmUXBTYTJJcXYxaWdhYlBiWlh3V3diRTM3Nm9WVlFM?=
 =?utf-8?B?QkVqRGhDcjZXdUNhZlFGdWRieWFyN1Jha1gzU2xXQVhOMzhYQVY2dFlDYits?=
 =?utf-8?B?R1Z0bGc3SHhsbFpLL3d0ZUtMKy8zUWk2RGhOSHByYm9nM3FicTh5V3hITHVI?=
 =?utf-8?B?T3ZYRHZiUm4rM3NTc1c4cGt4WGV6Rm1aRXJlV0VKQ2hyTEMvN3piTFQ5TDNV?=
 =?utf-8?B?ejNyd0F4cmZDMm54QTkzdmF2aFRVbDJsTk9KeFRYMVArb2VqaSswR0gwNGFH?=
 =?utf-8?B?TTJQWTk2YmhGbmY3K3VjWGc0MHJsMmMwcXg3Y0tRc1E0bjFSak9oMjFvYXVu?=
 =?utf-8?B?b2lvQk9jOEs1eGVIRmxkQWJFNXV0VmYvOGxNamxuSFNmNGhOV0t5dHpDUDNN?=
 =?utf-8?B?TklNa2w1Sk1EQmdnSmJTNlJ4YTV6SFZ1ZjVjazhrUGFFMzNnaW1TcTZxcm9l?=
 =?utf-8?B?aWkyelBjRUZ0TWFCSmNLeWFQVjhhZVVaUGU2S1FobG5BclRXdkhKbFU1Q1BF?=
 =?utf-8?B?TlR0akRBRmNlYkQzb3QveFdMZ0dodWZrWU5NcGxDc1cvM1MraUNaREtDY2NE?=
 =?utf-8?B?VzhlNHRUUWY1RkhKSExyR2tGbVN3L0FkSTdVeTg3N1M3UjdkQWVNVDBhWTZz?=
 =?utf-8?B?MFNqaGhYcFRabGhnOHY5OVVsVEtpOVZHNnkvL1ZwbnZQcDYxZ3p6S2UwNVdq?=
 =?utf-8?B?amluZlRBcGFsSTVYVDB0b2U5cFdKODZsdU0vbTBsWkgza1lTdFRna244dUl3?=
 =?utf-8?B?YnFCdENWRUNtcFgrZFFGZGhEVUVGZlhZRHNCcUdBM082S2Rkd0FKVGw5WXEz?=
 =?utf-8?B?aFVkQnd0MzRXZjRTRGgyNTIwYzBURExleGZVR1E0c050bkQwcFhPbXZ4dmZj?=
 =?utf-8?B?Ynl5WC9INlFGclUwQ2g5RGIvWU9Wc2FEVTZwY3c0OVdHWG01N0NvWisraUls?=
 =?utf-8?B?NmRmM0VtMWMrZ2dteUNIWFZ4MHBvdWFCcXltWHRKRFo1VjhVTC9lK1dLOTV0?=
 =?utf-8?B?ZzZxR1ZTekJQbkx6V3hJYmtCN1hVMGJyNE1zenZuajl1Q3l1MWhvWUF5ci9J?=
 =?utf-8?B?ZU9TL2hPYlU5elRTVUNjWU1FMEt0dExkQzZwN3RFcTNJUENSZ1J0WXRRZlpU?=
 =?utf-8?B?dHhsbVRnMjZHUVVCODN4OWQrZ0FEdGIxdmJrZzQyYkVqQWVoWmovQUJZRitO?=
 =?utf-8?B?YnZvMk0zQXpuU3BSd3RTb3VsZVozYVhtOUU5Q1JCTGZNZ1FLOXQrdThTRlhF?=
 =?utf-8?B?R1pMRVVjcnl4Uyt4WnpvczBXQ0xEaUVqZ21Xa284QmpoKy80MGtDL0lwUVFQ?=
 =?utf-8?B?anRYM1FCYjBieU1NN3J0WXRiTDkvWTRwd1hDVTFkRmJBc0QvOFp3Mktkc1BJ?=
 =?utf-8?B?eWdLaE5TOEpYZWlXcS9jOE5YZ1cvUGJmZjVITFc4MzRkVStabThIY2liaXlB?=
 =?utf-8?B?VjRaVDZzQWU2L0NRVTVnVm5ZaUdHd2ZaUVBETXd1WUgrUkUrMmh0TWY2SnRk?=
 =?utf-8?B?aXhqYndLQlB0RlJOZ3c1bGU3QXhKT2Zvd2d5ZUhHdE9kU3pjRUprL0ZUUXFl?=
 =?utf-8?B?aEQ3anlhOG1ib2M3OGg5Z3NoWWZydHFaWHZYdmlXUUFWNmUrTVJWN1hyck5o?=
 =?utf-8?B?ZXREUnNET2tmVG9kbUh3aGtHMlFOTzdJdDNNdE80K3NzNVdTYzd2MmlsSEMy?=
 =?utf-8?B?djMvVllXWnFSOGZQaXhmRzltMjZLS3JKMDRXZllkNFRGNU81bEFEWkZlME1z?=
 =?utf-8?B?NmtzazJ5MmNLMVZTQnlxTyt0TmRNRUJmbkMvcjRMTURBTlBkbUVHZWlGT1hi?=
 =?utf-8?B?Z29sU2pPQ2NvWTFIRmw0MWtuaElweGlya1dDUkpNK1U1V2dBL3ZqSTNYYzF1?=
 =?utf-8?Q?7/nFcD3EYXNeustE=3D?=
X-Exchange-RoutingPolicyChecked: 1SSY6KbJ9zpcWX1WsJtx485SubEt/cF9mtLVIhyhGV+OOd3XcJn525t6s0EwRSeq4zuZwi8nrUmUi2daTH4Vpk2wP8bbxPHIhsNzIH6i7xbyF3S4K/1R715PSgWmmlpr4zHHj6q04z4Ary/HEqxHyfibBAYDrL3B/H3pyzK6Eti4fF0DMGhmplmYyU6iFPtRHDDPEUSfvFfI4/64+uTuCXHpLsCmQO6trNjvLu+mirmC00MlToVIH3GTBlPcQdO6Bw2/+Mtcw5jDDpSmJVVwMhdn8omlS2h73YpNiOQUFH9VHeLT8qsk+2c5NbXS2wGiY8y9J+BMrm4+f5LyN8QdOQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: ba7dde49-171c-4f2c-ce43-08df03df1900
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 02:01:24.4690 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 60ru/3ebrp30BWWTrWceSRsxxq34qw+ygt3toSdMgOEm72KZCYzfBVxThmnJVPPv9ejZZ/BVDvuDkQs6Qp8OsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6277
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

On Thu, Aug 20, 2026 at 10:34:49PM -0400, Nathan Bourgeois wrote:
> > Shouldn't we just be calling xe_bo_validate() here instead of
> > ttm_tt_populate? (With the correct xe_validation_guard() wrapping).
> 
> > Yes, this might be a better solution, making ttm_bo_setup_export()
> > completely unnecessary.
> 
> If ttm_bo_setup_export() is unnecessary, I'm happy to change the patch
> or make a new patch. I will attempt to implement and test this locally.
> 
> > This part looks good as different patch from what I'm assuming will be a
> > TTM fix.
> 
> Regarding this, what do you recommend I do, assuming the patch
> remains local to drm/xe? I'm still learning the ropes of contributing.
> 


For Xe I believe Thomas and I aligned a xe_bo_validate with a correct
xe_validation_guard is the Xe preferred solution in the existing
design... But a question to Dave below before I commit to anything.

> Nathan
> 
> On Thu, Aug 20, 2026 at 9:08 PM Dave Airlie <airlied@gmail.com> wrote:
> >
> > > Yes, this might be a better solution, making ttm_bo_setup_export()
> > > completely unnecessary.
> > >
> > > It's also a bit odd that, in flows where we don't have backing storage
> > > on export, we populate with pages and charge the system memory cgroup,
> > > only to move the data to VRAM when the import attach is triggered,
> > > resulting in a copy and a change in cgroup charging.
> > >
> > > I guess the question is why was ttm_bo_setup_export() introduced over
> > > just a validation at export?
> > >
> >
> > I'd like to think I had an answer for that, but I don't. Likely
> > because I wasn't thinking about VRAM charging at all, and just
> > worrying about making sure we had populated some pages for system
> > memory ones, so the other side couldn't DoS us.
> >

Dave:

We don't charge any cgroups yet, right? This would only come into play
once a version of [1] merges, correct?

What would prevent the pages populated for a TTM BO from being
immediately reclaimed and discarded? I'm fairly certain Xe's shrinker
could do exactly that, since we don't pin those pages. This seems to
imply that we'd need to store the cgroup associated with the TTM BO at
creation time and charge allocations to that cgroup, regardless of which
task ultimately triggers the page allocation.

Another option, instead of validating, is to revert
ttm_bo_setup_export() entirely and rethink the overall approach as part
of [1].

Matt

[1] https://patchwork.freedesktop.org/series/169831/

> > Dave.
