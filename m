Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B8A606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 07:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BfTk+8xh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4887911267B;
	Fri, 30 Oct 2026 07:59:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E22711267B
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 07:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793347182; x=1824883182;
 h=content-transfer-encoding:date:message-id:subject:from:
 to:cc:references:in-reply-to:mime-version;
 bh=3kiH+sWNDUszZM7MaOlpYfjCRAL9YO9aZWATWLY62UI=;
 b=BfTk+8xhNaLvrTyrpcepvImNhDNfPb99vi+DRjEYPJ0wiwwSuSIn0gBJ
 64lYRgeVqelNDqGgFcCXikPZR4+sUy03jKhzthCf19U/trYrvOB91PHp0
 ZymdaC6JR1ZX9s/m7ReYBSGFm24wTO7CVvAw02ZYp9RqIN0J08PEqNMbU
 Bl7XW6pdfpbWz6xIF2g14oHolftne50guHwc/LwcVf0GCJDvvY2Do9ALE
 2oF8JYKUW0tdx3ocXG9YKEdBTRkfWpCOCLX1exARwcbGUWomnMGUKEQgH
 j10hNSOLwRHbNYCKp4vndyDlmA07SRr9VHRdlayEnGwFiT83oryqW6QXG w==;
X-CSE-ConnectionGUID: PDiei6WXTRGmyR54GDy9CA==
X-CSE-MsgGUID: 6TzxO8dXTlu5wAdbEynh8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="1991166"
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="1991166"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 00:59:40 -0700
X-CSE-ConnectionGUID: V1hEKmqcQ66EC65+ciJyaw==
X-CSE-MsgGUID: GbapV45cQUmNArLMQ88UMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="7159397"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 00:59:39 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 00:59:38 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 30 Oct 2026 00:59:38 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.2) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 00:59:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t0lgbdCN9XeAJxlBBpdbQCRajrVUOTfYFbACQwtFDOiGe/cyClw2naP26ahgFNHwF2kQi0EW3kPsnZT3agRzqee9YNCXeG2gtmN55ZabEMaWbVfSCPBL1vY31nBX8vGaFQllf5nivcnYUA/6BSdGvP19dKnXxPc9vUrxO5Ej2EVQEYBJ296Q8onDh8AOF/5LGLm28sRNxcBbQfg7iFCNHtNxcE3HGYu6ubumMLQPeR/vhGlI6IlPyjM2qgTn9zhL60b/mpn7hb6UD+6++4+H4s0sru2lrfcWSdNYXA4YHbrfCiQYBl/ToeeCPFSv+prF4igqstFahlLbaO0z43qGzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdyIwm52hui9araRJyIjo/uWNwbs9ZbjGjYCjRjUltk=;
 b=q2RABWvq6z7eeZxrkHTy4z45cm0j8Nd4Vwoc+LvF+q1JB414ke3jQ9Rn7BMsqhGJB1yBMPaf3mEWDl+qw+XhUiQ5uUD5aXh6iOA70AcQj+utJ1nLNUu6Qr8oOq6LVgMuwInO9OyMJ64e/2jUI9fLzS95D2DZkYE51JCVqhIaBMX4szUsK+y1mt6PwDErE5cV7KaCtakvgSvek55dP+FizKZFpNUyYqmN4oAThArd8oiC1SYyGvXbslSHzHTflybqcTiFpjQ8/C8T5x87S57BLBYiqioBkbJUW9AS0T/jUtvgD3htcGUU6Dr/hfFuf5mAOMod4p0FlnyliqR67e9kdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PR11MB134916.namprd11.prod.outlook.com (2603:10b6:8:4f0::21)
 by LV3PR11MB8766.namprd11.prod.outlook.com (2603:10b6:408:212::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 07:59:35 +0000
Received: from DS4PR11MB134916.namprd11.prod.outlook.com
 ([fe80::87f6:b354:5770:3ad4]) by DS4PR11MB134916.namprd11.prod.outlook.com
 ([fe80::87f6:b354:5770:3ad4%5]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 07:59:35 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 30 Oct 2026 08:59:50 +0100
Message-ID: <DMI0ITWM0GVE.2KY7024QB9UPZ@intel.com>
Subject: Re: [PATCH v2] drm/gem: Fix and enable CHANGE_HANDLE
From: Sebastian Brzezinka <sebastian.brzezinka@intel.com>
To: David Francis <David.Francis@amd.com>, <dri-devel@lists.freedesktop.org>
CC: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Christian Koenig
 <christian.koenig@amd.com>, Simona Vetter <simona.vetter@ffwll.ch>
X-Mailer: aerc 0.22.0
References: <20261007141043.2928048-1-David.Francis@amd.com>
In-Reply-To: <20261007141043.2928048-1-David.Francis@amd.com>
X-ClientProxiedBy: VIVP296CA0043.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:353::15) To DS4PR11MB134916.namprd11.prod.outlook.com
 (2603:10b6:8:4f0::21)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR11MB134916:EE_|LV3PR11MB8766:EE_
X-MS-Office365-Filtering-Correlation-Id: b97906d8-2f27-40e6-b74e-08df365bbd09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|11063799006|56012099006|261009223027099003|261009221227099003|261026121527099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: 6Ym+17hlMrk+kY/msR1U2/A8MlFEblehbsYQ25Uq/aWGzTgZ6jIjFNntTXkYzn8LC6KwR7vNxsJz/1dAPg2FxCaUCBt61TqkImUk3nlyNkJAhTuHm/tBeEyOkg4R7vX9nzjAQcqACQ1QibqKBmHhYMz0vOUXMk3a5f+GnycuSP0FM/z+Nk4KxKGoptDOpGhrgPXiRTsuAhOAz9BLEGdbzae/nIN2hSed+PLwCRU4FT/WaV9a8BfB0F8VeB/ba9rO8JRqlzwkk+OBh32ggq4lfAKSSKURH6ywN1IHql0AtO4aBPfPLeoOlRbFhsF8DnV0ZlIiekB9/pSJ1+FlQk1+sP2JJ3UIBZ4WkNqyYTP/IrHl8WV6NYMRvWsxyFjjL9O2imhT980ETdIPgqyPJsgkOT0byR7LROBMFMHr2P7t4h/GiMWf7LujmkRY4IQR8LBPi/7Kd09WrjU98ZaOwtH8s19oM7zswYoiGsdYPXlSDFeHzwWIrU4JpD3RHm0puGGftRVroPlDW8LPNC7T3a5JKxa3rKMlyhRbnxlVoOdyhJHKWPrtNrTSTA0GM+Kfhr7ZmS4IsF7t73s+e2jj9QlSLnVXEQivm7fCHS4F9QRyul8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PR11MB134916.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(261009223027099003)(261009221227099003)(261026121527099003)(261022075727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2xpbU9sZjVtNlptSTBuUlc5Q1M0bm9jNmJ1aXcwbWpRK2R1SkNtOC81bWRM?=
 =?utf-8?B?Wi9GdHkzbHZjcENtdytnTDM3bC9iUmlHU0NrUloyVXRxbGZkcFNTS09HczZa?=
 =?utf-8?B?RnY1dE14eXhzaTBDMm5HZHpRcWMzcEF4WlJrcHJEVnNvWHd5dWxmYmJYMGMy?=
 =?utf-8?B?YjlzNE9saHg0T29HamRDL0c3UTZBTFVrSGo1d2tDMUV5NXloUlg1MXBkNGRF?=
 =?utf-8?B?eDYydG9ZSG40ejVRbHRYdjYybVJQd1lseFFwcXBKTlRCNlQ4Z2FDNXZYTTdv?=
 =?utf-8?B?TmZjSEk5cC90bEw5WTFXMGpoRjk1MEoyWG00cnBiY3ZzbEg4aXY0V0pQdlNQ?=
 =?utf-8?B?dE44dWtCc0lKTmRaMzFSQmYrdmlGdTJHSUJWbmdJamFwVmtubnpmVmlBaGI5?=
 =?utf-8?B?UVJ3TlM5UnkrNDNnT0ZhQ0hKMzZ3eFY3S3VjYjM5N21iOHFlcnlwVTMva2VB?=
 =?utf-8?B?Y0NCNXlqS3c5dDUxblBySTlPNFhIaHYwN2NYazlKYVNpQnJiNktwN05MT2lk?=
 =?utf-8?B?MDMzQUFrcTRwTmtQT0NHSE5xbVNFMXRqMk9NdTlpMmlEVTdCaXZsZElucWk5?=
 =?utf-8?B?cFFjNnVuOGl1NmlhWVVNNm9LTVNHRlpuWldiRCtTZDhkamVKQ1o0WGpOU09k?=
 =?utf-8?B?ZW5Vd2dHelp1ZzdVL0hBVkQ1UGtLSy9IUXpOWS9BeHZhejNjVDBCbEJBN3pU?=
 =?utf-8?B?WmJVb1hiclo3Nm1ueE9qTEFoZytnWE9ocVJVOU9FTzdvRHRGeUtIcmtOREZ3?=
 =?utf-8?B?QWlNRll2SUc5bFdOQmExajNjRmllMnFjN3loNlpiemJiSVVGRXYrdlcxZDEr?=
 =?utf-8?B?QkRmMjdYbkVYTDZaNzRzS0VJWlRKZ1pocmlUZWVManNJTVpaS2ZtYWRXaHJT?=
 =?utf-8?B?WUVEbnFuempLaGN1RmtoOE5WUVdxUmMyeExWaW5vakJPMjZ2dDMzY2pFeDU1?=
 =?utf-8?B?NmxROWJaWnl3aUtMd2R3WWw3SVcvK0p5TmFGeUtKWk9BQ2FmTHY3R2d3VkFn?=
 =?utf-8?B?eTc2MnRuSHNqOFpuSVRuTVpuSzl2YytxUG1uQytmb251OThuRjNWV1RSVmlR?=
 =?utf-8?B?Z0YxVlVaYlBkZE82OEpDVjQ3RWhMYW5VR0ZKbUVjcGFkVHcxd0IyeGMxWG81?=
 =?utf-8?B?NnhjS1pwNndVNmNSelc1RlJtbnJ6MTk0SVFtZDRTZlh4QVR5VlVoWnM3M1Z0?=
 =?utf-8?B?OUhMMFRSbWhMT1psaEM1MUozQUI3WXVqbmZGbjVqY0RiRVVtM25yU2h4NStN?=
 =?utf-8?B?TkV4Y3llYTh0VHJlMENoVGhxaytLTnptN01VcXRCUkxCQ1pFSzRKbG9BaFBE?=
 =?utf-8?B?THVibTBHRS9LSzNDdGQ1aWFhN3czVVVuanFTM3RnbFBqMXpONzdiWjZONHdG?=
 =?utf-8?B?QmR5Z2V3d0wrOWVjNkljRFdGS01lVWd6SUJxN1dicXpSYXBTOERGeFVrNjBh?=
 =?utf-8?B?UzBsRGI2RTI3bDNpczFaVWNqLzFObyszT0xNS2J6T0I3RmhOV2EyUjM2cjdt?=
 =?utf-8?B?Yk5YaFppY3IyeGhPcmRjcDZ5QjF2aWtzNnUwV09xdElPOWlrUzFDWTNXcjdC?=
 =?utf-8?B?aUlQM0g2aWsyTCs1eS9nL1BJZ3AvRE81ellNT0xVMGhOcGRvZ1o0QmtnMWFO?=
 =?utf-8?B?VjJuSWlTNUhqOTA5S0llc3dhMUN5MWZzN0JWYjZ5c004Zm1OZTJ3L2UxVzB3?=
 =?utf-8?B?bjdkN2pZZ040L2dmRGpTbnozWERBOVMvQVZQUTdFLzJQVWUzVGhYWEIzYkhn?=
 =?utf-8?B?R2dCOEhEM3dSMjhTUE1jaEFXckJwRnZNTVNJNE9OSFVOK0FHclVwclk5NkJR?=
 =?utf-8?B?ZkZxS3BVWjhOK25yeTFtQ0tBTmVpa0NrSXVQL1dGSWc2WWdlTHBnSXgyelFq?=
 =?utf-8?B?WUNqa2tPTFNPenNUV3Jma21hTTRGUEQwVnBKcWc1M1NCZVlESTYyRi9zV1BP?=
 =?utf-8?B?Rml4eUZISi8vREtUS1BnR05FVlk2Q1lBcGhuOUNJV3p3WEREdzd3WWhEeG4y?=
 =?utf-8?B?YW9rVmZJY3kzcjcvQnU3R1hkeHoxWVJyaU9KSEkzTHhnaGJoTzBzWTJGa3I0?=
 =?utf-8?B?VXpEVFJjckRRbFdNckZYWHlUVWROWFhqbkN4VnRFNjdFRjRDUHhRVlRORGJp?=
 =?utf-8?B?Ty9QS3VHSEpEVFQ1SVRtaDdZMjh0b0YwTVk1amdCMEp5bVV6Y2tNMTloZksy?=
 =?utf-8?B?bmIxWWtZK3FTMXBJamVqUUpGTXNmR0FzZ2FkNURPYm1jRnNFSjZKTXY0dm5u?=
 =?utf-8?B?OXh0ZTJ4dXZidFZPc0p5RzZpOGFodVBzc1hBLzNBbjEvdjFXeWFNaXp0Vkkw?=
 =?utf-8?B?cWZDcVcvcGJqWkludllqMFZXM2JjcWl1V1JMNkdYcDhPalVWcFV6RXhZNXp6?=
 =?utf-8?Q?nchxMiLnE0Vv8y+A=3D?=
X-Exchange-RoutingPolicyChecked: W73tCSOfNRMeJynarEGNAy+wJgFjYiPjBYeZsaPWh0ulznXoyayaocHSauhiCtVx9u7KBKij7Uyknea85c1/CNuafw6+ljdNlmoS0TLeM1k5wKhcMssy1Y23YV7/kIV2rPq2HcVdwPS3V5Mfz8Dnk8aPa8w/YwcKDKfvEJWqOWKeIuf3uLliZJ4HLnHBOjr+MVAceVPswp756LSkOw5+BWEf78eD/m7CNEro2gc7fjZ6FH4kkm0d1/WNc699QJE7ZFe9wdcJ5f8ZrezhtqfF02OD1L5ZfP1QhqiJlpWOvdjsKw+C6iC00NK3bPEm2FsaEtMl+G1+Uf4q4envT6hNUQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b97906d8-2f27-40e6-b74e-08df365bbd09
X-MS-Exchange-CrossTenant-AuthSource: DS4PR11MB134916.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 07:59:35.2208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QrInzZcn2QvVZLxYM6yDgkq4nuhuYeeicOTaRDaL6DhreFC/+S2Zy5gToVjjlqdeVjuYBlzBLT89PQyPmhzRkZvUCE33G2eqeew91fYJEMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8766
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
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi David,

On Wed Oct 7, 2026 at 4:10 PM CEST, David Francis wrote:
> Make the following changes to CHANGE_HANDLE
> - reject new_handle =3D old_handle with EINVAL
> - idr_preload before idr_alloc
> - reject new_handle =3D 0 with EINVAL
>
> See also the igt patch
> tests/intel: Add edge case and race condition tests for GEM_CHANGE_HANDLE
> on igt-dev
>
> v2: new_handle =3D old_handle is EINVAL
>
> cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> cc: Christian Koenig <christian.koenig@amd.com>
> cc: Simona Vetter <simona.vetter@ffwll.ch>
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
I had a brief look at this series and it looks pretty good to me.
I would improve the commit messages so they describe not only what was
done, but also why. From my side, I ran the new tests on the try bot,
and they all pass.

https://patchwork.freedesktop.org/series/177021/#rev1
(re run doesn't pick up the new tests for some reason, soplease look
at rev1)

New tests have been introduced between CI_DRM_19403_full and Trybot_177021v=
1_full:
New IGT tests (11)

    igt@gem_change_handle@change_prime:
        Statuses : 6 pass(s)
        Exec time: [0.01, 0.04] s

    igt@gem_change_handle@invalid_handle:
        Statuses : 6 pass(s)
        Exec time: [0.01, 0.05] s

    igt@gem_change_handle@new_handle_equals_old_handle:
        Statuses : 4 pass(s)
        Exec time: [0.01, 0.03] s

    igt@gem_change_handle@new_handle_exceeds_int_max:
        Statuses : 7 pass(s)
        Exec time: [0.01, 0.04] s

    igt@gem_change_handle@new_handle_taken:
        Statuses : 6 pass(s)
        Exec time: [0.01, 0.03] s

    igt@gem_change_handle@new_handle_zero:
        Statuses : 6 pass(s)
        Exec time: [0.01, 0.04] s

    igt@gem_change_handle@race_change_change:
        Statuses : 6 pass(s)
        Exec time: [1.01, 1.04] s

    igt@gem_change_handle@race_change_create_close:
        Statuses : 7 pass(s)
        Exec time: [1.01, 1.04] s

    igt@gem_change_handle@race_change_export_import:
        Statuses : 6 pass(s)
        Exec time: [1.01, 1.03] s

    igt@gem_change_handle@sanity:
        Statuses : 6 pass(s)
        Exec time: [0.01, 0.03] s

    igt@kms_cursor_crc@cursor-onscreen-64x64@pipe-c-hdmi-a-2:
        Statuses : 1 pass(s)
        Exec time: [2.23] s

--=20
Best regards,
Sebastian

