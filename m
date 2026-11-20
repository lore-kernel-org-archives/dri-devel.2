Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA99606A51C
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 06:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KlU1zaYE;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=aE1EtESX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 055B910FC51;
	Fri, 20 Nov 2026 06:09:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FB8510FC51;
 Fri, 20 Nov 2026 06:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795154934; x=1826690934;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=gN9A69vtnoW7bgSftkoNfxeWn+tb7mQjGfx2I8cXfIM=;
 b=KlU1zaYECKYjAYi0hOHuRW/MZau+P3y7eGPe1gmv4cphvQtNfDwGRmBe
 KafhhBR3ZNsIP+keK+QEoNW0CBk22qkFlCXpMKTTrZiR+oGIzC5xcA1SR
 oDwpOYdg3mbNi7MEM97dsLWCRg2aMnLIsYzBwJeOCyPTTSK9kdog+mzts
 w6O8gBe5blNaTyL8JvuERYLJXi9uzO0dF3WZvdQEn8I0qGCv9OgcTQBdq
 kmHtToMd2gWnzpxo+U2xhF1c/81h4gj0K5t+OvfYA+BiqDy3tnylQkSxd
 T/b17cirGeQAz5JQmWs8Ms2YREp3tSPfhXbdoIECGY/tcinHxzl7VpxV4 g==;
X-CSE-ConnectionGUID: iT62ZGU+RpuMhrHEMv9rLw==
X-CSE-MsgGUID: 6pkKfAcPQ5Kn0BYv0s9+cQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4107685"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="4107685"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 22:08:54 -0800
X-CSE-ConnectionGUID: h56VBpApQ4eW5cpC+3erlA==
X-CSE-MsgGUID: ByX+ozuBSu+DAU5aFqjwyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; d="scan'208";a="10522765"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 22:08:53 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 22:08:51 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 19 Nov 2026 22:08:51 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.12) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 22:08:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XVtSFBEdVBozvX4LPMogyjZ2GZRJBtuaUJYAT/nQVtrgBFGwmHeKPJtDWn/1DQbU3t87cBBMg8igrvx29Zn+pHUH8uVgh/sAQlf6EIsTR4Wy09A7ExwC4/xGccNDB3qLuzfYgLh5EIm90ZQStaek5dkwI9o4pFyXAgSX74p8T4UPbmzIvv4LEZ7YVLhQ+WdrHivZLhpV+NS2ceNEogZoW3MXtSvZzxwhkdjR/t73qVU3wRP689i9IrC7QXhodwWt1Fo5C0qtF8GSQCdCusDPSmeU5ur+5W4dArYrNRoQ8G9dRs1YG8X5BuJ9lENMwUzb6ke6u/a8TMyugmvCGhmn1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rlbZO7pNV1lTYUSlw/FximBGJb1DPj1XKj8ViDmfz2k=;
 b=pFUwCg4A1zIxs9VMm4qIFBBoe4+XnI2Xq9Xpl0PDRtXfiOV3kv/jbTZ+sUsBkIGw3ccw4BPhOqjpwfpjGGoF+jb7kHzQsh+DDED2mY55EcPCWZcpHxcNFDdiprcFiYJXSJvG2YBP5HdjKrRnfz5B5zQlMsct+gHTMxZxjBc7a/CgD9k0wKJJynS7bNgVX6mrRxrxmAnfYL1sm8WSZb6hbFYfZ2iI9Tir+SH4RCY22ojwD4fxKEmB5zB3YgfS9H/dZOszU8boil8RKICkoKsZLo1GyCKGC3ak2wpXnVgY6gNWRWewJRGo2qgqt48+U94Vt6DHpHtxAwTb7lpXRdF3+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlbZO7pNV1lTYUSlw/FximBGJb1DPj1XKj8ViDmfz2k=;
 b=aE1EtESXse6fi2oE2qMEyDXK24RmDQXs/O/hTJ8Q+uGof5QG+MvgQBDW9ulSVN0fgRJqK/44dY3FAvU278zWj2mvETpRW9eF3MtyAFjxSFMco8HGusnexJjFqd1/xdFQeqYpLelQMaWLrb3kF54Et2Ht278s6Ug8Heg5f6UFpBA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by DM4PR11MB7182.namprd11.prod.outlook.com (2603:10b6:8:112::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 06:08:47 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 06:08:46 +0000
Date: Thu, 19 Nov 2026 22:08:44 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v3 16/33] drm/xe: Back off beneficial-order reclaim under
 defrag pressure
Message-ID: <av/j7EK3KrghOu3L@gsse-cloud1.jf.intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-17-matthew.brost@intel.com>
 <au6w5cfqYazBEGNx@nvishwa1-desk>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <au6w5cfqYazBEGNx@nvishwa1-desk>
X-ClientProxiedBy: MW3PR06CA0018.namprd06.prod.outlook.com
 (2603:10b6:303:2a::23) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|DM4PR11MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f8a0dfa-dc50-49d2-8d39-08df46ccbcab
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|10067099003|4143699003|11063799006|56012099006|261021121427099003|261022105027099003|261028144727099003|261026140227099003|261026121527099003|261022075727099003|261102123227099003|261009223027099003|261009221227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: A66aOQmwhI6JPVr2HcqAkY/girDNkPgnqrkJZS6qwosptW9zkIHNm8XcyPZTDTidxkbGRlQlZvc3o/X7snKDBbuU+/Gs0/cwC79MDhUgexbXVcqdKzdIyFoklSAyTdbiupromXjY0xoug2lzW08JO8VKrt2d2F0utyYe4BXGadJT/ZG6SCK0XMOIsCtQ3K0/8l70/cgXXVC16rF4rBfqmUI6x2UWcG9hxj9nf6Z3stNteN6WfJQTDnMxhai+Qi0DskN5mpXsxHCrYznUdpeLBjV9AoZ2oiou4ldkbOhVdQ/eVaOCDHXAJHKmVVxTzLWN2AOAl+ZuF6RJK3CDzlLieEubpORbAw2BW5tutsAxh+mJJNzssL9DG7L8CLUzlkPhOZ0Bpqlb32c+HS6TP1r4xLzuRwXapyM/8dkcvIh3xtGOzaq/Vxv6YKBqMYvoSLGVYrqOi3wq4vkzPXGXTPLZEtWQN0VPCJx6RO74VBNCLfUWWtbP7akclinQ2tmHQbiOL57b91Ci73g7wIv012jvC32MVIvNsM/IyTCByrGFZPC8X/7cDACHZ9snlr0yWGUZxUu3/rDPpHekdH0d2YNtMg0IawH5aDY2EnFrVYPWGiRu0ZYQoqCPbQk/EWE81x4q6G/UT5v+vKT/qNc45XE90xrZXj8NOA5BoNsVQ5SBvEA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10067099003)(4143699003)(11063799006)(56012099006)(261021121427099003)(261022105027099003)(261028144727099003)(261026140227099003)(261026121527099003)(261022075727099003)(261102123227099003)(261009223027099003)(261009221227099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2d6WVpiRi9qRTU2enA0eXdubk1kb3FRVGtqNjRvSisrZmdEWnROUWZ0THlo?=
 =?utf-8?B?aGFtNjlieFZZTzJkMi9iSXRMODR4UG9nTjR5bC9tTjFBUHB1MWZjZGNKelQr?=
 =?utf-8?B?Y05jd3JOZVBUbDNwbk1UVk9LQmprUmMzaGg3cUxSVE9PS0sxS1ArZUJiWURF?=
 =?utf-8?B?S0VWdEFwbFNFUHVoRXdXZGtkU0pCazVqaGhNeFJaSWFjZUx0Vnh4WjlUL0la?=
 =?utf-8?B?dE9keEw3alRaRE1XdTR1Y3JIY2wyam9YNkR1VEhkcWt0dmFzNjlybTZaY2FZ?=
 =?utf-8?B?U3N0VDJZY09MNVduWUxhbUZDZmtUUUd6K3RlWTlGS0U1SlJKSS94S0pUUlBx?=
 =?utf-8?B?UHJHQ0FJdTRJWXJLMFpqd2ZEU2szMmFlbEcwUGE2VndUalBXVVdNa1RaRkVT?=
 =?utf-8?B?NHVRSUF5OXFHeUljZHo0aG9VZ3NSRzFXcTZXRHdUNzBKeXl1eEMvVXQ4WVYy?=
 =?utf-8?B?WE41RitzbGY1bDcxMXdBY1loNnFNbit3V204T2QzbldxRlcwTDRPNFEvKzJ4?=
 =?utf-8?B?VTRqczB3U0dSam9IUzJzbWJyTTRLbzVrTU9DVWtEK3J1dWtmaEF5eHhHNTl5?=
 =?utf-8?B?TnJqY3crZGMvRTlPSzlGV1IzTHRtWVd5YXQvSlZvR3FaRXl1REREQzF5WWI4?=
 =?utf-8?B?TFFBNFo2TWZCbWNyV2RwZVJ3ZENudlJzYjNZaE5nQ1Y4Q2pqekF5UEMreXJH?=
 =?utf-8?B?bDM5WG1VQk1UTVdwT3RpcHVkZVJGSkVsa2pUOGwxZmZteVpNQnNoU3hpOTRG?=
 =?utf-8?B?TDFoSHZqZ05LV2NkSDNaR0ZVdVpCVkRIVGF2M0JjN2IxTEkrcXM4cG54MzBo?=
 =?utf-8?B?aFRCdmwrL2ZrakFmWkJmbFhtR1M0UG9mRWRCa1ZuOVVJSUdVUEcyK3lwN1ps?=
 =?utf-8?B?VEUwWWJwaUQxK2RKMW0rMnhQU3lGMlpwVEIzQ3ZGNWVlM2RCL24waW4weitE?=
 =?utf-8?B?eHp3VUFEeS9zYnZuMWlPbFdxSWZzaFdNbUMxMnZ3VGR3Qm1wWm9KeFVvMWJP?=
 =?utf-8?B?dndQVkpjZmRaTzFJREhhNkk1Nm9qUkpqZHJpcDRqM2RpODNFWDBsUTF0T01a?=
 =?utf-8?B?Sy81SGpFbnpFQXNIZ25xYmVHK3BCTzlhMGdyVEtpT2JQUVg3TDJ0ejRHbUtq?=
 =?utf-8?B?dFp1NFErTVpnNUFSUXZnNmZtQVVqYk9HUFh1TlV4NENIYjVqTG85V3hqN0FH?=
 =?utf-8?B?YnBLd3NWOFBMR2Jvd2xUd0NvNXYrNWdFUXRMUndPQUt3OExLeVk3VWNxTTFZ?=
 =?utf-8?B?eWE1K2pXZTN1UWoydGw0Y0J5WWtrSjMvZ2IvWlJkK1ZOK21GeHlFeTJxa1p1?=
 =?utf-8?B?NnJHZG9LVUJ3MlJieDVHbEJqRm1xbFhVbDc5WW9yV1YvcVByWmdRY1NHZUN1?=
 =?utf-8?B?OVNwTUUvVXZLKzJzU1E5VlE1WGw3OTRqL3RDeUZqRW9ZY1BTMlRaQ1ZHNHNq?=
 =?utf-8?B?Wmg1R3pOVUt6OFBlcnJiai81ZStSOWRZcnJaR0xTaWkwa2Z6eXVzendXalpZ?=
 =?utf-8?B?Sks1aTZTNUdEYjJzbnJweGJIV2JCN3Fad2U2K1JObE96enhhdFdRNDl2Q2pp?=
 =?utf-8?B?VVF4aWpoKytoSUw0eVZ3MDFYb0p6bjFicmJRRVd3RTd6Z3RNMGpZM1plUi9a?=
 =?utf-8?B?QnNDcmtYaXpNa3hoRUJqbDZxQlpsNXRkck1jYjllR3QrZlc5cXJXRHVPeU5E?=
 =?utf-8?B?dUlIMi9GN3d4YkdNQzFCN0Y0QTFCNTBUOWhLQStPZWVGelRPWXd4RXdlVHdE?=
 =?utf-8?B?RXRld1I1OWFFWTFSZHhwOGszSXNXaUd2R0UyZEg3ME9sZnNKVEliRkpVcjQ1?=
 =?utf-8?B?V2MvcVQvTnY2TjhSMU0vYmhRSUNNWGNFUy9lK29lbVY3Q29BZkIvckdoQkxF?=
 =?utf-8?B?bndHaXQxYUxZMVVITkNsbTlNNXdoN25OenlpTmRUb0RYYjFrb1pOUUwyQzhu?=
 =?utf-8?B?dlRjTWJCWjB1bW5pSFN4VnpVVUZQR013Rm9YdEw3U3h2OEY0b001RTVkLzhh?=
 =?utf-8?B?RGg4YVNBNUZSYzR4RVNGZU9Dbk05SVZwQTFTcHNCeFRHMFp2WXdiN0theFlu?=
 =?utf-8?B?WU1BZkNRNEFQanRaTzJOVWRUOHdUSzBwN2hvcVNMcEp1MDFDL2JLMVVKQ2pw?=
 =?utf-8?B?Y3NmZXFZTHlpY21nN1BMN09PY0tTamlIZTZWQm14QjFFNE5Vby9WN1pSM3VQ?=
 =?utf-8?B?aHFsUWV5Tk9kN0plSEFyODBodFJxSFYrQ1krbnpzeW83YjB4OXlTYXpQQThY?=
 =?utf-8?B?dnF4TjdnZ2RucG1QdTJwKzRCVUk0dWZYQjF6dWpRdGdHNVFBR1ZzMXNlbTNa?=
 =?utf-8?B?ZUZIcGEyOXdyejhGRDkvdnRhOE9GN0dTTUxOTzY4d1FEZnVnSXozSjNBaWdt?=
 =?utf-8?Q?95z3HtOYJ9Ymsrdc=3D?=
X-Exchange-RoutingPolicyChecked: a+Gm1gafamMnrttbxLQknItRSw+Qd3Pxw+F98DsH+L5lq7GeQ8ttpV+yylqxsZwp1AsegTqxzbNdfh11PTw/yw9l4pVzJySiV9D43+Yr9lxKSh411U8GTAj0vGd3FikGNXxlLvKsfnILwXjkK0nGQJuRWGwVZ9CFHFkSJI83dMArSn6UftzWpYKUVGw0X/CcDQZVzIIH8Q9IBM8EykG+VDjdik2nTqyY6qZ8wv00iJIbcrppJURI9mDfLDEcY4Zf20xW3oO7RnVyWNvtrFlti34pCj8roFt9Yadt5TOREHtdeNNdAHOOX3tqqfuNA/NFZnJeLY6UHZrduPA+3gUa/A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f8a0dfa-dc50-49d2-8d39-08df46ccbcab
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 06:08:46.3850 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x8rT1J8/ieY/66ex+POqig4lkCI8j1eMWBx05tMjBLaFdKj7vqky+X1nXjwZTqwPAUJ/6CyFlLDwuUQoTsmlJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7182
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

On Fri, Nov 06, 2026 at 09:02:29PM -0800, Niranjana Vishwanathapura wrote:
> On Fri, Jul 10, 2026 at 07:56:02PM -0700, Matthew Brost wrote:
> > Once a meaningful number of BOs are already tracked as being backed at a
> > sub-optimal order, continuing to push hard for beneficial-order pages
> > during populate mostly wastes time in reclaim/compaction.
> > 
> > In xe_ttm_tt_populate(), set ctx->beneficial_reclaim_backoff when the
> > device defrag count reaches XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD (2)
> > so the TTM pool backs off and allocations make forward progress. The
> > deferred defrag pass is responsible for upgrading these objects to
> > beneficial order later.
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
> > drivers/gpu/drm/xe/xe_bo.c | 14 ++++++++++++++
> > 1 file changed, 14 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> > index ff324caab6da..02395968d613 100644
> > --- a/drivers/gpu/drm/xe/xe_bo.c
> > +++ b/drivers/gpu/drm/xe/xe_bo.c
> > @@ -41,6 +41,14 @@
> > #include "xe_vm.h"
> > #include "xe_vram_types.h"
> > 
> > +/*
> > + * Once this many BOs are tracked on the device defrag list (i.e. were backed
> > + * with a sub-optimal page order), request that the TTM pool backs off from
> > + * aggressive reclaim at the beneficial order during populate, so that
> > + * allocations make forward progress instead of stalling.
> > + */
> > +#define XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD	2
> > +
> > const char *const xe_mem_type_to_name[TTM_NUM_MEM_TYPES]  = {
> > 	[XE_PL_SYSTEM] = "system",
> > 	[XE_PL_TT] = "gtt",
> > @@ -598,6 +606,12 @@ static int xe_ttm_tt_populate(struct ttm_device *ttm_dev, struct ttm_tt *tt,
> > 	if (ttm_tt_is_backed_up(tt) && !xe_tt->purgeable) {
> > 		err = ttm_tt_restore(ttm_dev, tt, ctx);
> 
> Assisted-by: LLM
> 
> Don't we need to to backoff in restore path also? If it is intentional,
> probably add a comment?
> 

Yes, we do need backoff in the restore path. There a couple other places
in this series that miss the backoff too (e.g., CPU fault) - the divide
we want is anything the foreground no reclaim, and only reclaim in
background outside of dma-resv (defragmenter). 

> > 	} else {
> > +		struct xe_device *xe = ttm_to_xe_device(ttm_dev);
> > +
> > +		if (atomic_read(&xe->mem.defrag.count) >=
> > +		    XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD)
> > +			ctx->beneficial_reclaim_backoff = true;
> > +
> 
> - beneficial_reclaim_backoff is not cleared if count comes below
> threshold. If the same ctx is used for multiple BOs, they all
> will backoff even when count has moved below threshold.
> 
> - Looks like self-reinforcing feedback loop causes spike in backoff.
> 
> count ≥ 2 → backoff on → new populates land sub-optimal → BENEFICIAL_ORDER_FAILED
> → added to defrag list → count stays ≥ 2 → backoff stays on → ...
> 
> Is it intentional? If so, may be a comment explaining it would be helpful?
> 
> - Will there be any value is heuristically adjusting threshold instead
> of using static value (2)?
> 

As mentiond above / last patch - I'm just going rip this out have clear
divide between foreground / background setting the reclaim flags
correctly.

Matt

> Niranjana
> 
> > 		ttm_tt_clear_backed_up(tt);
> > 		err = ttm_pool_alloc(&ttm_dev->pool, tt, ctx);
> > 	}
> > -- 
> > 2.34.1
> > 
