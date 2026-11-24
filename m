Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B04F606A681
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hq0Tuy4E;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=K6pOft6h
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E05110F025;
	Tue, 24 Nov 2026 18:05:15 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A53610F014
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 18:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795543504; x=1827079504;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=OAh62/e/8mJfX91UHtzSt4zoZt1c1F2qniRKBd5vNr0=;
 b=hq0Tuy4EfVmjaqCKcstmwuCwEaUO1wKdpi92oX/38A29kqfkOPPe186u
 R+/25/3fQZPABnkSz1Kq1YkXZj7oiS9Ob7wizqZNjfiRKObWmV4ZLBPng
 8WpkmEkN58kg6IvyNFQ9F7KpEvARFnocY0dTn0CDc5Ca9R+FQ4V/RXDGo
 BCCcu/ni08579o1rNr6+D+ciWEAv6ly67A1LGpeRxPIJ1lJnEGw1Nn4QB
 OOX03snB9P0ZHKG2SGXxeQFl7ZJTGYkFuQl8i00FDyTDPSDKh468IEuMG
 PaNHbLtUKgyIGXGjq9XaLbXnNzz1fOSa9EpPgz64daar/kfFQqPZdRwv7 w==;
X-CSE-ConnectionGUID: pdbWthbhT++E0BJc9LUoUg==
X-CSE-MsgGUID: O/VkNfreTF2ouSqO8usZ0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4366471"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4366471"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 09:07:01 -0800
X-CSE-ConnectionGUID: F4btomKiTJyuNZyIXeAY1g==
X-CSE-MsgGUID: /5Fw6gK3Q1uLG9orgG++5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; d="scan'208";a="11810761"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 09:06:01 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 09:06:00 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 09:06:00 -0800
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.6) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 09:06:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PveqREb+sNkZ1hA7M1IklIC/K3C+wBUNcE1TPN9fRs5tZSiyML+0KB8qvYhxYspej5DqpFuX3KtFc1XNPmtPnX19I69HNAg08Z+UV83NrYeS53X/sjdwsmw6bmWKmuP4pq3atolP0hCdq1O+nGktOZIr6R8MwIu9qYPA/fQgTRvgXtG2Udh4e/G8xwRLHcivVAR2zIeB27pGsdKFwMCd9OeyXYK8szde3sZwKShaQ3gJNfrGkVx+JgAYxxHVATAYq1Us8lryEIwdc1U46hMzojMeHqLrz40fOPBzgktgF61VXwUpT86+8IwH82cpYvecwrkjNbBgVl3HyBsbO/enOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zons8+RwOEthw2mZFWTZbRkKbQX9AfRQv4l3koRtCNE=;
 b=CJZp/jL3/ocbr2M8+QoBVvgsl52TxhGgWuV9YWjAFI6CcM42bSd7kh762vFqVYKyGiefuhk8C8NNndV2a6dj6IQLdq2eRJksx+q/WSOfwfB+D7wuaP83lT7GvGBqCaWQK2aK5mSEhYV5gycXFwRwkJVMQ+QRByTm3X5A1/H5hYYDtAEQueWd0UzfXA8bB+o3azXMXYN+WrWe8mJyKda2uBPevZdklZdvx7vfrKa9Vh0GORQDQtwTihdkVmzzGfNpKTF+aer01IZT9Vo1j3YR8iroSGjZV0+StV8IqjXztpcSZmuiwQV8qXpnKY7zDAUsFFHcx6HgTAijC0JW2unhaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zons8+RwOEthw2mZFWTZbRkKbQX9AfRQv4l3koRtCNE=;
 b=K6pOft6hGDJzNhnJgjCKmca8E7zBjp4Ogx0VZsum0KKmqEc0jVM+L5IedFr3Wj/f+vivlbZ8T0qfwW4Ay7NyjUpfG8Rjx+QqGNF11wBQEZJt32e/onXsSRS6G92QMVYHk0nAjtow4xB5hYp8b3b7E5feT3Xbg2LTcwRbwk0qEN8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 DS7PR11MB6176.namprd11.prod.outlook.com (2603:10b6:8:98::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.13; Tue, 24 Nov 2026 17:05:56 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%4]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 17:05:56 +0000
Message-ID: <19ab0174-5d95-4b30-a92e-3fc9f2a88313@intel.com>
Date: Tue, 24 Nov 2026 22:35:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] drm/drm_ras: Reference-count nodes across netlink
 handlers
To: Rodrigo Vivi <rodrigo.vivi@intel.com>, Zack McKevitt
 <zachary.mckevitt@oss.qualcomm.com>
CC: <dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>,
 <aravind.iddamsetty@linux.intel.com>, <raag.jadav@intel.com>,
 <simona.vetter@ffwll.ch>, <airlied@gmail.com>, <kuba@kernel.org>,
 <ogabbay@kernel.org>, <lizhi.hou@amd.com>, <karol.wachowski@linux.intel.com>, 
 <jeff.hugo@oss.qualcomm.com>, <carl.vanderlip@oss.qualcomm.com>,
 <troy.hanson@oss.qualcomm.com>, <youssef.abdulrahman@oss.qualcomm.com>,
 Sashiko <sashiko-bot@kernel.org>
References: <20261117233442.407877-1-zachary.mckevitt@oss.qualcomm.com>
 <20261117233442.407877-2-zachary.mckevitt@oss.qualcomm.com>
 <awWrOMrRHFpOF00l@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <awWrOMrRHFpOF00l@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0332.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:222::12) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|DS7PR11MB6176:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e36142f-0227-45a5-dd54-08df4a4d3419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|23010399003|261022075727099003|6133799003|22082099003|18002099003|261009223027099003|3023799007|261022113327099003|261022105027099003|261026140227099003|261026121527099003|261102130727099003|4143699003|261028144727099003|261021121427099003|261021123027099003|261102123227099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: Ufxsk2HK2iNqRgIEXDgmN7wsOEyaAzGEWkjidlgFSK9QGOE1QRvg83ndnSEAk2qkG4t3tX9Ipdc8imufzzRrluWAWYQ3RdwdewZcDUy49fBJeMTCQF4Ca5QIfToKbUmDb3C+E0VA7xQTUJNXMrqWUxTmGK81qhvAnO5+AXqOcNU0euYcpMeCyBLeBCDfF4WMDEDOxCJBRewN8Z210uSXgXeYtl70vT8YtMd04ycS2caM6f316p92HfowWvlWs/UAH5IPGeIbM3fRUgn+RLDFxXrwZC93eLqjqM8VCklpDASkhiA81u40uRQMrLvUxaKVHhyfzLoJbLZNGajdY1UCZc/Xbx3C1ye720SpO93b25WfDjzPOLC8qfwxfyhbWyQc3TZDHoKieZHTwN/9tFwuCV0w789TazZ3MRO3hMmykW86UEOGPhN1aP/T8CDlxkLFLld/kPDPcs8M5EwFWBsOLTQCEj5pgDqmu1UNWKDtDmxo6PKRnQwFVfNdMJNQEunlguJfC5zbaMDyYxA9hZ7TnTMZB3wzAM8m7MdIVeWAbdMximuIvfi2Xc93Uscd1nnK7Rre7SQeZufgIEkwgErT9sVd5Zdse71Kh6Aa38PAstQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7958.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(261022075727099003)(6133799003)(22082099003)(18002099003)(261009223027099003)(3023799007)(261022113327099003)(261022105027099003)(261026140227099003)(261026121527099003)(261102130727099003)(4143699003)(261028144727099003)(261021121427099003)(261021123027099003)(261102123227099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUNjVndVZHJoVHMzMHhwbEtvUTRXM1FEUkkxOUpRayt6dFV3dTNub0o3cDhn?=
 =?utf-8?B?VTJaVGRvcHJ0NmFvZ0FWQ1gvYnlxOVdGQWkyWVduVHp1UC83MG9hY2E1VzNG?=
 =?utf-8?B?bVZYVmw3U0NuL3V3TTcwUWZodzlYZy8vVFZxSXRBUmZ0aTZvdHZDTjIza1pV?=
 =?utf-8?B?RFh1ZTFzdmFsaDZjeXpWTG1hcVRYQitvZW9WallsS3FvWnJqQ3hoWTYvTXd1?=
 =?utf-8?B?dDZYeDlWS3JOU2pZOGJ1R2lqOXVSZlBiRGt6VGZ0cHd3NzhWWTNsQXE1QW96?=
 =?utf-8?B?bUxhdkkwTGtQSXlMRVRvUERJMGJWZXRrZDFWa0hVejZiRUxrNWhLenBpdSt5?=
 =?utf-8?B?dVJnR3R2VWhSa1BqTkszby84d0V1Ylp0Tndpd3VKWUZlcEJqejFrbERpRFZk?=
 =?utf-8?B?ZzhvR0NSNEVGc3BzQWJlVWE1bVhzdi9mczRxb0pNVmJVMEhPd0NYV0twMmZl?=
 =?utf-8?B?cU5PV3FiTWJURHRLTUQ2d3pwNWlycmk4WEtad3N2VjFiZHAvVHJPVkxrRDF5?=
 =?utf-8?B?bnJyWk9UOVZMZWdxMTVGTFFnbldsSmdNaTl0WnB4UFg0UjMzMy9ITkhBTC9a?=
 =?utf-8?B?L3RBdDhUems2RjlhM2c3TUc5bldBakFvQkZFNzFkdWFVblBPeng3OUxWSG9P?=
 =?utf-8?B?bG1lNmJNbFJQcUp3UlgyQUNYTjJkV1RVR1J6dHRUb0Uza1h0Rmp6TllDeTJs?=
 =?utf-8?B?K0MvNHhROFJ0ODRMbjlEb25YSHIxMjhyK21wSzlFRVI3VDBSYXBmY0ZnMjBt?=
 =?utf-8?B?bUNjUUtNM2NIMDU5cHoyMnJjY3lMUHExSThYOUxudHFON0dvY1F2MGdMUGcr?=
 =?utf-8?B?eitPUHlMVk5pRXprd04yV0xwMFYvdUo1VC9aWDhuUzRRUjhUMXpRc3FSZkdR?=
 =?utf-8?B?dGs4WlFjUVNRWFZkdlYvOEVEMWhOU0EvQ1NJUjg4MDFmN3FFT0oxRFNsVnNj?=
 =?utf-8?B?NUxqQ1FlY3I4UFkzU3NFc3dsVW9FazhSZlpVdVlaSXY3bzNKNUYxbUg3K2h0?=
 =?utf-8?B?WXFoT0tCZS9yVDByNjFYSXlVd1lTd01aK1E2djY5Vk5mc2NtR1JVZzY5QXFa?=
 =?utf-8?B?MTlMaHlLbGVzKzlETDFmaHJLbGZ1cytKRTNpblhLcnhnVURvRGZqa1Vqa2N2?=
 =?utf-8?B?cGRmZG1vcUloWC83SkJPclQxcXdpc2FpQkd4OEdPZzA2OENaZEg0dnBLZ01q?=
 =?utf-8?B?OWcwcE9MRVYrVHlOd3orYmE3L1pWekJZUHJ5cXpiVGZ6bllVa0tOVlhCNHYy?=
 =?utf-8?B?dmF4ODhnWUpBbXpUeTF5dEczVE5OeURVU2VtOExJcy92OXZoVTVvajIyc1FQ?=
 =?utf-8?B?R1hmYkQ2TTR6aG9UUS9iRDlwMlZYdEFBZGxjZ1NiUEVLcGJja0NjMHhUaFRO?=
 =?utf-8?B?eVdBRktvbE5tKzJKS2JqQWc2OTRsd21WeDc1WXNHTkFGOEx2bWg3dDBBV01q?=
 =?utf-8?B?dUMrMjNuNFA0b2w1eWs3dzMyZEJEamduaVB6bTJoS05BSlpEZjFpeHhSdThk?=
 =?utf-8?B?ZktYSHZUQ0xtbGZxRTZtN2VodUIyVEhoYmlRMTZIbE15SnRyS3J3L2lpMXlv?=
 =?utf-8?B?SDlTMmdXbGFwVFZGN1RWYlVJUUxmSUt0K083b3FldFBWcXJnN2F0NUI2eDFZ?=
 =?utf-8?B?THZ4b1dVWHd1UE85aDc0akZLdkEveEVFTDFPMElsUDlZakpKT3ZNVVpFQmI3?=
 =?utf-8?B?MXlvS2d4SVZuMHpRVlo2NjN5Z3FBSU04OGZpdFdJMWU1and4R3IwNDVvLzFv?=
 =?utf-8?B?Y0RiWlBpLzQzeWl4djJUWHJxOFUrb2dqSDY1OGJoeGdzZ0V3MjFld1JnWUlY?=
 =?utf-8?B?SWVHSHRwTmRrc09MQnNtRmY3VVdaZFFlQU9wdnZKcGZSSGl6Sm9HbnZpUnZY?=
 =?utf-8?B?anFLcUVUcVlYYmRWaFlDbnI4M0FjRTlwTnVkS1lJcUxZc0NWOXF0dVdSVVZy?=
 =?utf-8?B?clNISmNBSzcra0pWb2xyVFlnbXRYMzQwTTB3eDJSd2ZyQXp5OEQyZTFMSkd0?=
 =?utf-8?B?bXFYaTA2c2VmRGJaa0pwaE5IZDUvQlNPbGNnbEF0UlFOV05Md2hFenVxOHdn?=
 =?utf-8?B?cHJZVjh1QnFFbGRhdURZQm9kR29BNDRTTUpwdnN6S0xqYWdnRjlKRTJ0UGwr?=
 =?utf-8?B?NlNYOVE3azVJbWxiM0s0V0VWNkVyam8rMmROZXZ2ekpxWUVYbmlKbGhaTitM?=
 =?utf-8?B?RStwMEV1UTdTcEh6THRDMjVEQXVTKzlOYi9SRXFqYy9tMDJJa2hnOGx6K3Nr?=
 =?utf-8?B?VlhHOEVNUG13akZTaVlsc29vOWVaREt0NHpQeW9WN1l5U1ZhenhTTFBxQ3NU?=
 =?utf-8?B?U29QQVJFNE9nZXF0MmVTdDN6TEFzaGFuMGdTa0NTS3dwVk5RV3ZiQT09?=
X-Exchange-RoutingPolicyChecked: Cv778Z8UHc9qXHxkASwYg3OSOHT+gGE0RFW+70bmhoOg4y9hfvn1u0xZJasMsvLo11h+elhU6Hed2i9wST9Ioy7rpg2QkJvaVw90EtvEXiGZ4BavnLu1AjIbZ8qih1H3C/ODycGQ3i93USVBq/Y7lxKbOxk+XzVQYC34LUFlRfUPLTtVCDllhg3xYygdSbdGMagor1WMMUrPGUCOP7CAFHpcQDr6DA961tkt+mu0K7EM2GB8z2NwnRHN4I9yKl9y4NU7VaZVaizf+10tFjRo11kvTemqjAzh27fGh82wusA/SzmoubJQmqYPeA65zNNW3ZwhgvWQfYFFh32u15trhg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e36142f-0227-45a5-dd54-08df4a4d3419
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 17:05:56.2159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fqlluoQFdEbQg51HlPzf2NPIkPO1oe4JlmYM+6ShVNCPa9T6wu2mCZeWigNWj8VwPuJiN3WqhTdZ6GTnVykYsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6176
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 24-11-2026 20:50, Rodrigo Vivi wrote:
> On Tue, Nov 17, 2026 at 03:34:31PM -0800, Zack McKevitt wrote:
>> The drm_ras generic netlink family sets .parallel_ops = true, so its
>> handlers can run concurrently with each other and with
>> drm_ras_node_unregister(). Every handler looks a node up with a bare
>> xa_load() and then dereferences the returned pointer across GFP_KERNEL
>> allocations and sleeping driver callbacks, while drm_ras_node_unregister()
>> only calls xa_erase() and the driver frees the node immediately afterwards.
>> xa_load() only holds the RCU read lock for the duration of the walk, so the
>> node can be unregistered and freed while a handler is still using it.
>>
>> Give each node a reference count. A node holds one reference for being
>> registered; drm_ras_node_get()/drm_ras_node_get_next() take an additional
>> reference under the xarray lock, which serialises them against the
>> xa_erase() in drm_ras_node_unregister() so the bump can never race with the
>> free. Handlers drop their reference with drm_ras_node_put() once they are
>> done touching the node. drm_ras_node_unregister() removes the node from
>> the xarray, drops the registration reference and waits for any in-flight
>> handler to drop theirs before returning, so the driver can still free the
>> node as soon as unregister() returns.
>>
>> drm_ras_nl_error_event() is left unchanged: it is called by the driver with
>> its own node, whose lifetime the caller already guarantees.
>>
>> Fixes: c36218dc49f5 ("drm/ras: Introduce the DRM RAS infrastructure over generic netlink")
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Closes: https://sashiko.dev/#/patchset/20261106181225.3333260-1-zachary.mckevitt@oss.qualcomm.com
>> Signed-off-by: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
> Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
>
> This overrides the series that I had sent yesterday...
> I'm sorry for the delay here...
>
>> ---
>>   drivers/gpu/drm/drm_ras.c | 239 +++++++++++++++++++++++++++++---------
>>   include/drm/drm_ras.h     |  16 +++
>>   2 files changed, 201 insertions(+), 54 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
>> index b099eb67836e..75e3403ca71b 100644
>> --- a/drivers/gpu/drm/drm_ras.c
>> +++ b/drivers/gpu/drm/drm_ras.c
>> @@ -3,9 +3,11 @@
>>    * Copyright © 2026 Intel Corporation
>>    */
>>   
>> +#include <linux/completion.h>
>>   #include <linux/module.h>
>>   #include <linux/kernel.h>
>>   #include <linux/netdevice.h>
>> +#include <linux/refcount.h>
>>   #include <linux/xarray.h>
>>   #include <net/genetlink.h>
>>   
>> @@ -60,6 +62,21 @@
>>    * - drm_ras_node_unregister(): Removes a previously registered
>>    *   node from the xarray.
>>    *
>> + * Node lifetime:
>> + *
>> + * The &drm_ras_nl_family uses &genl_family.parallel_ops, so netlink
>> + * handlers may run concurrently with each other and with
>> + * drm_ras_node_unregister(). Node memory is owned by the driver, which
>> + * typically frees it right after drm_ras_node_unregister() returns. To make
>> + * this safe, every handler looks a node up with drm_ras_node_get(), which
>> + * takes a reference under the xarray lock, and drops it with
>> + * drm_ras_node_put() once it is done touching the node. A node holds one
>> + * reference for being registered; drm_ras_node_unregister() removes the node
>> + * from the xarray (so no new lookups can find it), drops that registration
>> + * reference, and then waits for any in-flight handlers to drop theirs before
>> + * returning. The driver may therefore free the node as soon as
>> + * drm_ras_node_unregister() returns.
>> + *
>>    * Node type:
>>    *
>>    * - ERROR_COUNTER:
>> @@ -107,6 +124,75 @@ struct drm_ras_ctx {
>>   	unsigned long restart;
>>   };
>>   
>> +/**
>> + * drm_ras_node_get() - Look up a RAS node by ID and take a reference
>> + * @node_id: ID of the node to look up
>> + *
>> + * Looks the node up in the global xarray and, if found, takes a reference to
>> + * it so that it cannot be freed while the caller is using it. The lookup and
>> + * the reference bump happen under the xarray lock, which serialises them
>> + * against the xa_erase() in drm_ras_node_unregister(): a node that is still
>> + * present in the xarray is guaranteed to still hold its registration
>> + * reference, so the bump can never operate on freed memory.
>> + *
>> + * The caller must drop the returned reference with drm_ras_node_put().
>> + *
>> + * Return: the referenced node, or NULL if no node with @node_id is registered.
>> + */
>> +static struct drm_ras_node *drm_ras_node_get(u32 node_id)
>> +{
>> +	struct drm_ras_node *node;
>> +
>> +	xa_lock(&drm_ras_xa);
>> +	node = xa_load(&drm_ras_xa, node_id);
>> +	if (node)
>> +		refcount_inc(&node->ref);
>> +	xa_unlock(&drm_ras_xa);
>> +
>> +	return node;
>> +}
>> +
>> +/**
>> + * drm_ras_node_get_next() - Take a reference on the next registered RAS node
>> + * @next: in/out cursor; on entry the first ID to consider, on return the ID of
>> + *        the node whose reference was taken
>> + *
>> + * Iterator counterpart of drm_ras_node_get() used by the LIST_NODES dump.
>> + * Finds the first node with an ID at or above *@next, takes a reference to it
>> + * under the xarray lock and reports its ID back in *@next.
>> + *
>> + * The caller must drop the returned reference with drm_ras_node_put().
>> + *
>> + * Return: the referenced node, or NULL if no further node is registered.
>> + */
>> +static struct drm_ras_node *drm_ras_node_get_next(unsigned long *next)
>> +{
>> +	struct drm_ras_node *node;
>> +
>> +	xa_lock(&drm_ras_xa);
>> +	node = xa_find(&drm_ras_xa, next, ULONG_MAX, XA_PRESENT);
>> +	if (node)
>> +		refcount_inc(&node->ref);
>> +	xa_unlock(&drm_ras_xa);
>> +
>> +	return node;
>> +}
>> +
>> +/**
>> + * drm_ras_node_put() - Drop a reference taken on a RAS node
>> + * @node: node to drop a reference on, may be NULL
>> + *
>> + * Drops a reference previously taken by drm_ras_node_get() or
>> + * drm_ras_node_get_next(). When the last reference (including the registration
>> + * reference dropped by drm_ras_node_unregister()) goes away, the waiter in
>> + * drm_ras_node_unregister() is woken so the driver can free the node.
>> + */
>> +static void drm_ras_node_put(struct drm_ras_node *node)
>> +{
>> +	if (node && refcount_dec_and_test(&node->ref))
>> +		complete(&node->unregistered);
>> +}
>> +
>>   /**
>>    * drm_ras_nl_list_nodes_dumpit() - Dump all registered RAS nodes
>>    * @skb: Netlink message buffer
>> @@ -129,44 +215,45 @@ int drm_ras_nl_list_nodes_dumpit(struct sk_buff *skb,
>>   	struct drm_ras_ctx *ctx = (void *)cb->ctx;
>>   	struct drm_ras_node *node;
>>   	struct nlattr *hdr;
>> -	unsigned long id;
>> -	int ret;
>> +	unsigned long id = ctx->restart;
>> +	int ret = 0;
>>   
>> -	xa_for_each_start(&drm_ras_xa, id, node, ctx->restart) {
>> +	while ((node = drm_ras_node_get_next(&id))) {
>>   		hdr = genlmsg_iput(skb, info);
>>   		if (!hdr) {
>>   			ret = -EMSGSIZE;
>> +			drm_ras_node_put(node);
>>   			break;
>>   		}
>>   
>>   		ret = nla_put_u32(skb, DRM_RAS_A_NODE_ATTRS_NODE_ID, node->id);
>> -		if (ret) {
>> -			genlmsg_cancel(skb, hdr);
>> -			break;
>> -		}
>> +		if (ret)
>> +			goto cancel;
>>   
>>   		ret = nla_put_string(skb, DRM_RAS_A_NODE_ATTRS_DEVICE_NAME,
>>   				     node->device_name);
>> -		if (ret) {
>> -			genlmsg_cancel(skb, hdr);
>> -			break;
>> -		}
>> +		if (ret)
>> +			goto cancel;
>>   
>>   		ret = nla_put_string(skb, DRM_RAS_A_NODE_ATTRS_NODE_NAME,
>>   				     node->node_name);
>> -		if (ret) {
>> -			genlmsg_cancel(skb, hdr);
>> -			break;
>> -		}
>> +		if (ret)
>> +			goto cancel;
>>   
>>   		ret = nla_put_u32(skb, DRM_RAS_A_NODE_ATTRS_NODE_TYPE,
>>   				  node->type);
>> -		if (ret) {
>> -			genlmsg_cancel(skb, hdr);
>> -			break;
>> -		}
>> +		if (ret)
>> +			goto cancel;
>>   
>>   		genlmsg_end(skb, hdr);
>> +		drm_ras_node_put(node);
>> +		id++;
>> +		continue;
>> +
>> +cancel:
>> +		genlmsg_cancel(skb, hdr);
>> +		drm_ras_node_put(node);
>> +		break;
>>   	}
>>   
>>   	if (ret == -EMSGSIZE)
>> @@ -175,13 +262,10 @@ int drm_ras_nl_list_nodes_dumpit(struct sk_buff *skb,
>>   	return ret;
>>   }
>>   
>> -static int get_node_error_counter(u32 node_id, u32 error_id,
>> +static int get_node_error_counter(struct drm_ras_node *node, u32 error_id,
>>   				  const char **name, u32 *value)
>>   {
>> -	struct drm_ras_node *node;
>> -
>> -	node = xa_load(&drm_ras_xa, node_id);
>> -	if (!node || !node->query_error_counter)
>> +	if (!node->query_error_counter)
>>   		return -ENOENT;
>>   
>>   	if (error_id < node->error_counter_range.first ||
>> @@ -191,14 +275,9 @@ static int get_node_error_counter(u32 node_id, u32 error_id,
>>   	return node->query_error_counter(node, error_id, name, value);
>>   }
>>   
>> -static int get_node_error_threshold(u32 node_id, u32 error_id, const char **name, u32 *threshold)
>> +static int get_node_error_threshold(struct drm_ras_node *node, u32 error_id,
>> +				    const char **name, u32 *threshold)
>>   {
>> -	struct drm_ras_node *node;
>> -
>> -	node = xa_load(&drm_ras_xa, node_id);
>> -	if (!node)
>> -		return -ENOENT;
>> -
>>   	if (!node->query_error_threshold)
>>   		return -EOPNOTSUPP;
>>   
>> @@ -208,14 +287,8 @@ static int get_node_error_threshold(u32 node_id, u32 error_id, const char **name
>>   	return node->query_error_threshold(node, error_id, name, threshold);
>>   }
>>   
>> -static int set_node_error_threshold(u32 node_id, u32 error_id, u32 threshold)
>> +static int set_node_error_threshold(struct drm_ras_node *node, u32 error_id, u32 threshold)
>>   {
>> -	struct drm_ras_node *node;
>> -
>> -	node = xa_load(&drm_ras_xa, node_id);
>> -	if (!node)
>> -		return -ENOENT;
>> -
>>   	if (!node->set_error_threshold)
>>   		return -EOPNOTSUPP;
>>   
>> @@ -290,15 +363,22 @@ static int msg_reply_threshold(struct sk_buff *msg, u32 error_id, const char *er
>>   static int doit_reply_value(struct genl_info *info, u32 node_id,
>>   			    u32 error_id)
>>   {
>> +	struct drm_ras_node *node;
>>   	struct sk_buff *msg;
>>   	struct nlattr *hdr;
>>   	const char *error_name;
>>   	u32 value;
>>   	int ret;
>>   
>> +	node = drm_ras_node_get(node_id);
>> +	if (!node)
>> +		return -ENOENT;
>> +
>>   	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
>> -	if (!msg)
>> -		return -ENOMEM;
>> +	if (!msg) {
>> +		ret = -ENOMEM;
>> +		goto put_node;
>> +	}
>>   
>>   	hdr = genlmsg_iput(msg, info);
>>   	if (!hdr) {
>> @@ -306,7 +386,7 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
>>   		goto free_msg;
>>   	}
>>   
>> -	ret = get_node_error_counter(node_id, error_id,
>> +	ret = get_node_error_counter(node, error_id,
>>   				     &error_name, &value);
>>   	if (ret)
>>   		goto cancel_msg;
>> @@ -317,26 +397,37 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
>>   
>>   	genlmsg_end(msg, hdr);
>>   
>> +	drm_ras_node_put(node);
>> +
>>   	return genlmsg_reply(msg, info);
>>   
>>   cancel_msg:
>>   	genlmsg_cancel(msg, hdr);
>>   free_msg:
>>   	nlmsg_free(msg);
>> +put_node:
>> +	drm_ras_node_put(node);
>>   	return ret;
>>   }
>>   
>>   static int doit_reply_threshold(struct genl_info *info, u32 node_id, u32 error_id)
>>   {
>>   	const char *error_name;
>> +	struct drm_ras_node *node;
>>   	struct sk_buff *msg;
>>   	struct nlattr *hdr;
>>   	u32 threshold;
>>   	int ret;
>>   
>> +	node = drm_ras_node_get(node_id);
>> +	if (!node)
>> +		return -ENOENT;
>> +
>>   	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
>> -	if (!msg)
>> -		return -ENOMEM;
>> +	if (!msg) {
>> +		ret = -ENOMEM;
>> +		goto put_node;
>> +	}
>>   
>>   	hdr = genlmsg_iput(msg, info);
>>   	if (!hdr) {
>> @@ -344,7 +435,7 @@ static int doit_reply_threshold(struct genl_info *info, u32 node_id, u32 error_i
>>   		goto free_msg;
>>   	}
>>   
>> -	ret = get_node_error_threshold(node_id, error_id, &error_name, &threshold);
>> +	ret = get_node_error_threshold(node, error_id, &error_name, &threshold);
>>   	if (ret)
>>   		goto cancel_msg;
>>   
>> @@ -354,12 +445,16 @@ static int doit_reply_threshold(struct genl_info *info, u32 node_id, u32 error_i
>>   
>>   	genlmsg_end(msg, hdr);
>>   
>> +	drm_ras_node_put(node);
>> +
>>   	return genlmsg_reply(msg, info);
>>   
>>   cancel_msg:
>>   	genlmsg_cancel(msg, hdr);
>>   free_msg:
>>   	nlmsg_free(msg);
>> +put_node:
>> +	drm_ras_node_put(node);
>>   	return ret;
>>   }
>>   
>> @@ -372,6 +467,10 @@ static int doit_reply_threshold(struct genl_info *info, u32 node_id, u32 error_i
>>    *
>>    * Report an error-event to userspace using the error-report multicast group.
>>    *
>> + * The caller owns @node and must guarantee it stays alive for the duration of
>> + * this call (it is the driver's own node), so no additional reference is taken
>> + * here.
>> + *
>>    * Context: Process context only. Uses %GFP_KERNEL and multicasts to all
>>    *          netns, which is unbounded work; callers in interrupt handlers
>>    *          or other atomic context must defer event.
>> @@ -455,21 +554,21 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
>>   	struct nlattr *hdr;
>>   	const char *error_name;
>>   	u32 node_id, error_id, value;
>> -	int ret;
>> +	int ret = 0;
>>   
>>   	if (!info->attrs || GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID))
>>   		return -EINVAL;
>>   
>>   	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
>>   
>> -	node = xa_load(&drm_ras_xa, node_id);
>> +	node = drm_ras_node_get(node_id);
>>   	if (!node)
>>   		return -ENOENT;
>>   
>>   	for (error_id = max(node->error_counter_range.first, ctx->restart);
>>   	     error_id <= node->error_counter_range.last;
>>   	     error_id++) {
>> -		ret = get_node_error_counter(node_id, error_id,
>> +		ret = get_node_error_counter(node, error_id,
>>   					     &error_name, &value);
>>   		/*
>>   		 * For non-contiguous range, driver return -ENOENT as indication
>> @@ -478,7 +577,7 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
>>   		if (ret == -ENOENT)
>>   			continue;
>>   		if (ret)
>> -			return ret;
>> +			break;
>>   
>>   		hdr = genlmsg_iput(skb, info);
>>   
>> @@ -499,6 +598,8 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
>>   	if (ret == -EMSGSIZE)
>>   		ctx->restart = error_id;
>>   
>> +	drm_ras_node_put(node);
>> +
>>   	return ret;
>>   }
>>   
>> @@ -544,6 +645,7 @@ int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
>>   {
>>   	struct drm_ras_node *node;
>>   	u32 node_id, error_id;
>> +	int ret;
>>   
>>   	if (!info->attrs ||
>>   	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID) ||
>> @@ -553,15 +655,23 @@ int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
>>   	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
>>   	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
>>   
>> -	node = xa_load(&drm_ras_xa, node_id);
>> -	if (!node || !node->clear_error_counter)
>> +	node = drm_ras_node_get(node_id);
>> +	if (!node || !node->clear_error_counter) {
>> +		drm_ras_node_put(node);

Nit: use goto for consistency
Also split the condition check. drm_ras_node_put is not required for 
null node.

Thanks
Riana

>>   		return -ENOENT;
>> +	}
>>   
>>   	if (error_id < node->error_counter_range.first ||
>> -	    error_id > node->error_counter_range.last)
>> +	    error_id > node->error_counter_range.last) {
>> +		drm_ras_node_put(node);
>>   		return -EINVAL;
>> +	}
>>   
>> -	return node->clear_error_counter(node, error_id);
>> +	ret = node->clear_error_counter(node, error_id);
>> +
>> +	drm_ras_node_put(node);
>> +
>> +	return ret;
>>   }
>>   
>>   /**
>> @@ -602,7 +712,9 @@ int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb, struct genl_info *i
>>    */
>>   int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct genl_info *info)
>>   {
>> +	struct drm_ras_node *node;
>>   	u32 node_id, error_id, threshold;
>> +	int ret;
>>   
>>   	if (!info->attrs ||
>>   	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID) ||
>> @@ -614,7 +726,15 @@ int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct genl_info *i
>>   	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
>>   	threshold = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD]);
>>   
>> -	return set_node_error_threshold(node_id, error_id, threshold);
>> +	node = drm_ras_node_get(node_id);
>> +	if (!node)
>> +		return -ENOENT;
>> +
>> +	ret = set_node_error_threshold(node, error_id, threshold);
>> +
>> +	drm_ras_node_put(node);
>> +
>> +	return ret;
>>   }
>>   
>>   /**
>> @@ -640,6 +760,10 @@ int drm_ras_node_register(struct drm_ras_node *node)
>>   	    (!node->error_counter_range.last || !node->query_error_counter))
>>   		return -EINVAL;
>>   
>> +	/* One reference is held for being registered in the xarray */
>> +	refcount_set(&node->ref, 1);
>> +	init_completion(&node->unregistered);
>> +
>>   	return xa_alloc(&drm_ras_xa, &node->id, node, xa_limit_32b, GFP_KERNEL);
>>   }
>>   EXPORT_SYMBOL(drm_ras_node_register);
>> @@ -648,10 +772,17 @@ EXPORT_SYMBOL(drm_ras_node_register);
>>    * drm_ras_node_unregister() - Unregister a previously registered node
>>    * @node: Node structure to unregister
>>    *
>> - * Removes the given node from the global node xarray using its ID.
>> + * Removes the given node from the global node xarray using its ID and waits
>> + * for any netlink handler that may still be using it to finish. Once this
>> + * returns, no handler holds a reference to @node and the caller may free it.
>>    */
>>   void drm_ras_node_unregister(struct drm_ras_node *node)
>>   {
>> +	/* Remove from the xarray so no new lookup can find the node */
>>   	xa_erase(&drm_ras_xa, node->id);
>> +
>> +	/* Drop the registration reference and wait for in-flight handlers */
>> +	drm_ras_node_put(node);
>> +	wait_for_completion(&node->unregistered);
>>   }
>>   EXPORT_SYMBOL(drm_ras_node_unregister);
>> diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
>> index 1765a3130b09..449509c36355 100644
>> --- a/include/drm/drm_ras.h
>> +++ b/include/drm/drm_ras.h
>> @@ -6,6 +6,8 @@
>>   #ifndef __DRM_RAS_H__
>>   #define __DRM_RAS_H__
>>   
>> +#include <linux/completion.h>
>> +#include <linux/refcount.h>
>>   #include <linux/types.h>
>>   
>>   #include <uapi/drm/drm_ras.h>
>> @@ -102,6 +104,20 @@ struct drm_ras_node {
>>   
>>   	/** @priv: Driver private data */
>>   	void *priv;
>> +
>> +	/* private: Internal drm_ras bookkeeping, drivers must not touch. */
>> +
>> +	/*
>> +	 * @ref: One reference is held while the node is registered in the
>> +	 * xarray; netlink handlers take an additional reference across their
>> +	 * use of the node. See drm_ras_node_get()/drm_ras_node_put().
>> +	 */
>> +	refcount_t ref;
>> +	/*
>> +	 * @unregistered: Completed when the last reference is dropped, so
>> +	 * drm_ras_node_unregister() can wait for in-flight handlers.
>> +	 */
>> +	struct completion unregistered;
>>   };
>>   
>>   struct drm_device;
>> -- 
>> 2.43.0
>>
