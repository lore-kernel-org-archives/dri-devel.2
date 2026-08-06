Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E16D2C56208
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 21:13:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52C0C10E119;
	Thu,  6 Aug 2026 21:13:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="e7Mm62cq";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9248210E119;
 Thu,  6 Aug 2026 21:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786050801; x=1817586801;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Lcgj/NWUXb48SKchVbiifMvF0LUu21/re6l3PDKxG30=;
 b=e7Mm62cqj6OQsIRxOS1qnATuK7mBZzHhWVqxY4Tyfvd3K2UxMi7tKeJ8
 2rBlFC+K+rmKPRQ1/YnGCk1gIKFzok6atENcJiGmjqitWDcu3hWZGxubW
 L3Rm4BQ7WQ1xljsmkiBx9ZKpXnEXKVdY0fEvwAefHi2MrRs9JwQH+b20j
 c7bs1xAdmS3V+RTVOis2cGmkcRDCkdN+jeT41JtVT2lEVWkLjltg20zQB
 3HpuiqHGhWs6Di6ZfsvVP68BfOkmxXGS0mzJFNKANAg0NjIXBur0c1x7U
 6mq/iQTUzai95fUCOUou+1zHjHWHZZ2ey92dS8WzI3F7k1/yRKJNo5+JA Q==;
X-CSE-ConnectionGUID: HoBfg4OMSA6NkW9BzUXLzw==
X-CSE-MsgGUID: RV2/z4lESaehY8dCGZPAqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86667672"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86667672"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 14:13:21 -0700
X-CSE-ConnectionGUID: zLXRf+SeSJmbexV8OAuLBg==
X-CSE-MsgGUID: f+uAD20KS12bVC0v+hFhMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="260440695"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 14:13:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 14:13:20 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 6 Aug 2026 14:13:20 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.46) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 14:13:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPz4ksbjCD2nVVLLOWUq96PRyiEgTXSHGqu2pMsYm84qaojuZMSRREgmlR1kidaeRGyht6uRY7R111A0ibFDg0NSn2ird6E5MKEQD0lDCtKqxWnBCwI9s+jDS0XCpCLtOkuhc1oM3+d+VfqtukeH+wZzXldcS3MYFCLMlHb7Lk+UUdfNk3lv0aJHT4mh33JCX/IwKUVYhCIMcNJYyxJhEA55uIZ3BoxPyXD0itkOOMV8ouhr7EbKdhtERd9U8w0bA5L/p8W7wRnbufqXgfsLc8ep6NN2NNhxnQKAdPJ7SJgmhibcOJARpFJYDtcn39m5150XptgqMeRVZ79NNKKsbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEhqllggAQ2e+zywnybm5oDoODn24mYcZZcXjRn9GyA=;
 b=JDkZ/LQ1tkz7X4bmPZhq3dW+nOsM22IwOzjYG2Rx/3SnQdCAqXmEQHxtjJgg7vbGEMGWsJEtF38Sdysy1MViGjL0Y86YCm9caJIQbw1t46Q/kD6ooi2if9ml9FLV0VohZ1/3d68NCkG6HQ9lgW2eQrIiCbp9u7iIS4iJoasGhUHF4T2AN/7lYRnwBcUebDQ0idJWfVmf5JVkI0SJHOu4yS3WQluk6Nh1TOd5N8nNTPKtfzaeic41Cb1Hki3Vy5Ck1htshnJN9U5gStoObKmtV1/P/cUYJZSoWn2dGE0s1Mqx4X2/7rUY68RLNvsimtAH1NANaG7wlq/wr1RPUryD4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4979.namprd11.prod.outlook.com (2603:10b6:303:99::16)
 by IA4PR11MB9321.namprd11.prod.outlook.com (2603:10b6:208:566::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Thu, 6 Aug
 2026 21:13:15 +0000
Received: from CO1PR11MB4979.namprd11.prod.outlook.com
 ([fe80::ed0a:e4ab:fde6:edcc]) by CO1PR11MB4979.namprd11.prod.outlook.com
 ([fe80::ed0a:e4ab:fde6:edcc%2]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 21:13:15 +0000
Message-ID: <3ee610ea-1707-4ab7-b0cf-20852b7c971f@intel.com>
Date: Thu, 6 Aug 2026 14:13:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] drm/xe: diagnostics and workaround for GuC TLB
 invalidation ack stalls on ARL
To: =?UTF-8?Q?Tales_A=2E_Mendon=C3=A7a?= <talesam@gmail.com>
CC: "Summers, Stuart" <stuart.summers@intel.com>, "Brost, Matthew"
 <matthew.brost@intel.com>, "intel-xe@lists.freedesktop.org"
 <intel-xe@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
 "thomas.hellstrom@linux.intel.com" <thomas.hellstrom@linux.intel.com>,
 "Filipchuk, Julia" <julia.filipchuk@intel.com>
References: <20260804021441.3054424-1-talesam@gmail.com>
 <c0c50dff0f9b64a2db8e1470d75e450ba35cccde.camel@intel.com>
 <anJZSDD+lmzbaE7b@gsse-cloud1.jf.intel.com>
 <176e54adc75dc9b947caadbf95333df1b60c0240.camel@intel.com>
 <cb06c8e0-0cf8-4dc2-a586-77aafc95f0c0@intel.com>
 <CAHBRX4ErWF0e4X9DCXyycyqJUHaVcv36J=X0PRrNANqZxrzidg@mail.gmail.com>
 <49792f00-d8e3-41c7-ab2d-1d7efe4b5aca@intel.com>
 <CAHBRX4ELrBJcRj-8LLryKT_0Jnc-8R0ZFLc4N4fu6yDb6f=wDQ@mail.gmail.com>
Content-Language: en-US
From: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
In-Reply-To: <CAHBRX4ELrBJcRj-8LLryKT_0Jnc-8R0ZFLc4N4fu6yDb6f=wDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0382.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::27) To CO1PR11MB4979.namprd11.prod.outlook.com
 (2603:10b6:303:99::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4979:EE_|IA4PR11MB9321:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c18f73e-6111-4e26-37f2-08def3ff87bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|11063799006|5023799004|56012099006|10067099003|6133799003|3023799007|18002099003|22082099003|4143699003|13003099007;
X-Microsoft-Antispam-Message-Info: SMw5XWsGr/M7/6gcNJo2p7BSeQQQJANGk07PoVWKxKQ8YiQ2WNS/A42aCC+ziZI+CoDGMShQfpAn0KTSP3z7cWtq74Apfi9TiNrjsHlKxqYIXRcHAGqNzAX1Qom6RZNhv+eE7MAExi3fN2HzckOhr7q9Ek83edDxJEH43PIbEhsFEWRdpqU1n1wcYXBR06NGwCNPmA80YR147gmtoX6OVOG57sPw4MJSPcrU3H0IGSY/aBRwD4ksCAbDzdyf495zPb74C8QyVA9LH6qvc6zO4XldnHAAiMBLz1nbr8WabZiEoDvWejPRSoD7sB5XX7F23rlLCS/JW9t2gq2Ed9S48/fyiRiNSZI9c3x2SKFgj4FN0BOMFlIJESrSA5ItEHXHv/2fSday/JwVCcB5Ay7WE1i3L4ujETUBxywsi03ii5xZ9IFTzkfZhXjMKUlqiwRSWmrVEaI0teHcQ4kMdno/05Jx7LuWIlKkN54vknmXi6SX0xXsgGxmCs8mwYTq7PCKo235Qgc4rd7jJvGQX6Ub67s4QWvLSp0xTbELVOA2ZdpzWomm4K4+XsrrCQEfB67sUYPUKPCVtKtT/o3hwHneXtQSro1NXthog4O0LR3EVY0l/JPO3HS/UU3wrb0n8Q8MYdnw6fXXIVAqRUcyoeOQktNCKSSfo6Vf1hQ/NJ6drYU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4979.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(11063799006)(5023799004)(56012099006)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(4143699003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmE1ZjcvZW1kWk1PQmNlOUg1czNiMUMvWDRwa0wyZlMwS2hWN0lDaTN5NnVE?=
 =?utf-8?B?WFBDckI5QmpQM09rMU1UODZjWWhrQnQ3UnRZelJxWTV4bnVtc2NQaFRUN0hk?=
 =?utf-8?B?enhrc3B6MHpmM2E5dFdycURRVDVXcE9LYnVRR2huWGRhWCtSK3pFVHRmVW9k?=
 =?utf-8?B?LzQvMzhLQnpiOUVWSm5UUE1kdjROS20yVStaOE9ReDJLWHhZZkZrb3Rnc2hn?=
 =?utf-8?B?VC84NTIwM3U3SmdST0lxWHBVSGJCd0oxZHNDUmFBR1lmQ2NkUzRwVDBLWVpK?=
 =?utf-8?B?SFNNWlRqMGpPOUdNb1lUaFEyVys2cDhYMHBpbEtpdzZ6bGRFYU9UOXc4SHZL?=
 =?utf-8?B?NXhCN2FRalhpWGpPMXN6cWtKUXhEOVd0M0k2R2ptRXVaeERxbTcrdEsrbWE1?=
 =?utf-8?B?SVV6L0RKem83d3o2S1lGTnc5WEpRZnlUQWRDVHNaaTkzRHpWQW1GWXNsNVVt?=
 =?utf-8?B?MXprTm94QjFoYjRIUldiQ0Q1YllwRUlaMTY4Q05aTTdYZlJiUFVuYnVhUUVU?=
 =?utf-8?B?QmdpMmhMTEUxRVMvMWlydVdiTjd1VzZuMGpwbDJGWmplOVdVYmdYVGM5Q1o0?=
 =?utf-8?B?QmpTMjdYQjQ1b0ZBck9kUTBQZ3dhemhucXBueUUweUdQeEJTOU1wRUMxS3cz?=
 =?utf-8?B?TnlwQlF6Z1JvUWF1MzM5ZVBDOWFOTy9aL2NWbWVYWFMxUzFzNFNwVHZJRFdk?=
 =?utf-8?B?SnRSeHVCeEpRVUlud3BhZ1BxdS8ybTJtS2lMU1RlanpiQ0hydUtBcmQ4czZr?=
 =?utf-8?B?K1h4TllITURnMDAxVGRNV0Ura1JqZy9yUXNmeExzZkJUWE1GNEFCVVBJbmRM?=
 =?utf-8?B?RHRPSXJYK0MwZVNaSUNkRjk1VXUrdlVQM3lJWUZ4T29VOHdTZDZKbXQzYmJy?=
 =?utf-8?B?c0xYZWx2cGhmcVZxemgwMHloZ1RSOERtMFJMYmc5VmFwWXBUOEo5YitCZ212?=
 =?utf-8?B?S0pFRVh2K2VnWkVhWnJvb3QxL3Npem4rOE9DVE05SEdwQlVoNjVWVDd3bnRh?=
 =?utf-8?B?WDV0WnJiWUExNVRtSTBRZTkzczB1dFNTU3F2dlhQK2dGSzVqb09LV2hzN2Vu?=
 =?utf-8?B?TE1uRU1MWndHblJkSzRsS3VKNTBrYno3SW9UQWwxSlFtMjRoZmtpRkdzOHRp?=
 =?utf-8?B?VnR3STFRM055Z3R3ZDF4ckE5dUdQN2lhVlpqUVdodXBMcDNkLzRXQW1wOEZU?=
 =?utf-8?B?S1dtUU51ZGFsTGMxZWxpZjE2eExGdnlNc0FvWW55MkJxOFhSMlJjdVRVRVR4?=
 =?utf-8?B?OVBVSDJzMnpZK2p5cEZrMFcrem4wK2REcFYvQWVJSEpiZVNZamRZNi9QYm4r?=
 =?utf-8?B?UFdSeU5KNURMZTl1dytJdWxvR1MrOWlWSzYzcCt6RG91bWZMU1RYQ2tyaCs1?=
 =?utf-8?B?aUg3SDFKN0dWUWFZd2RWRkp5bDU2K2loVEJPTUhkUERMS0Q3VkNaY1NxTjN5?=
 =?utf-8?B?K1V4QnlaL0ZyVDBNczk1SXFPY215VWI4MC9nR3RQUmRGTmFEOTQwbFY1MHZG?=
 =?utf-8?B?UVVGaVZrWnFsUjdLUm9XNEVaZlRIRUYzR0RyRjFRMzBJMTFmN3JnZGR4S3Fh?=
 =?utf-8?B?YTk4cWFZcTV5dzNQazN0Y1BnNlJWVFVQZjFueUl0U2l2bHdSVWo5akgzWDl3?=
 =?utf-8?B?bmJIU3dEWG5WVU1xMUg0bVpvWnlXdnVIREh5SGNlZDNKSVVNOHhRaVo4UHdW?=
 =?utf-8?B?U0Fsd3FNYlFrNEZYVjgyZVB5R2VqWEdXUTlYYjViM1dxZW1RU2QwUFVQbXkz?=
 =?utf-8?B?ODR3Y1VjdEdyQ0pIZmhTNlh1QjBFVXlBcnozSVRLYkMwcUVlVjRoWTRiUkNq?=
 =?utf-8?B?QVFrY0w3eHNlNzRvUDV0RVpLbmlaK1JRWjVnUDlWaDVXNUpMUnBjay8vYjVB?=
 =?utf-8?B?cmFEbEdEc3VLOHB0dlFraFgyb0JuZWhQemtFb1RpTzRHRzJhY3NsVUliZS82?=
 =?utf-8?B?U3Z1ZUJ3NzJlQkQvd3VDZzBlT0l0T2R6UFFvREMrZ2NKeTBMVTNmTTZYZHBq?=
 =?utf-8?B?YkNySzhRY0wvZG1CVklOdjdyN0oremRSZlFBSXR2a3ptOXd5TXZXS0pWZmMx?=
 =?utf-8?B?NC9vc0pSNmVYUWdpWEN0RzFTdGl5bUIvRnJyNEo2cWFRVlJMaEZNcThNYkxQ?=
 =?utf-8?B?Q0lyZDlsMXJMYU5ia1ZPQTJBMXVMdkJWdGV3SzMzbjhqV2VOTHBYckVLYjh0?=
 =?utf-8?B?cDJpb01IcmhUNS9rL09nTnR2NmZkdGNSc3JQc1N5TzN3dlJla3FtT1FNa0Vo?=
 =?utf-8?B?czdEekY4TXdqdFZiaWF4S2d2N2lhanFIWGY0L1RQSUdnOUFCWlg3WmxmejRs?=
 =?utf-8?B?U2dycHFERERudi9zeGtLT2VzZHpRZVRmemducUVKY0hyS1hPRnc0b1VpaW0z?=
 =?utf-8?Q?3004eZeqWIYl6qcw=3D?=
X-Exchange-RoutingPolicyChecked: I9U3ZEeK6RijXlBJQgZ/MxrSk9/0AFKMfRGHpuk+V5/t624sNzJK3LSarfpmTGgQyM0ufojROKNqanS7/lRQOJTDXGS1QQWBlSbAzuUZ4k8lzcU/sc6Kd9eURyF2ICnCtbK1DWv1mT6uBI1aCVlDBpSaXEEClFWTx9jrQ7ErnM7jCen6lIGkO09zdYNleOM3lGJNfKVJ74/Da/IZ5IRTfvpx7ozjhhl2rG5Xjj+adLcjr7gFULI/tjXwZG99mJBWs82/NUqTsaxzXPOwFuTh8dC3s0TCb4LzlD34YsaSk1kE/WgAFgmEDX7nKuoaIS62nMyYEz1Kz9G4R8Rf2ZDtRw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c18f73e-6111-4e26-37f2-08def3ff87bb
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4979.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 21:13:15.5735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zGVpUiMo1W3EvAQzxeg5vreGWMgItDBJgbuAU4YpWT0YmIKCXLVYIaNIHePf1zvxBCp8RBMFLDAvOsVD+1kwwmJTY4pJtNXff86NFnfRtSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9321
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



On 8/6/2026 10:36 AM, Tales A. Mendonça wrote:
>> That would definitely help, because if the issue does not happen on i915
>> it likely means that we're missing a WA or something like that in Xe.
> Two data points on that, pulling in different directions:
>
> * My second ARL machine (7dd1) has been running i915 for 7 days now,
>    with the same GuC 70.53.0, and there is not a single TLB invalidation
>    timeout or GuC error in its logs. Caveat: i915's TLB invalidation
>    timeout is longer than xe's 2.25s, so short stalls could be silent
>    there.
>
> * However, Matt just pointed at i915 MTL issue 14469, which looks like
>    the same problem on i915 - so it may not be xe-specific after all.
>
> If it helps I can also boot i915 on the primary machine (7d51), where I
> can compare against days of xe statistics on identical workloads.
>
>> Just a bit of a terminology update here, to make sure we're on the same
>> page: we usually refer to the notification you're sending to the GuC as
>> an H2G interrupt and not a doorbell.
> Thanks for the correction - I will use H2G interrupt from here on and
> fix the terminology in v2.
>
>> It feels like when the
>> issue occurs something is stuck in HW rather than GuC FW and triggering
>> the interrupt causes the HW to get unstuck.
> That fits a pattern I can now see clearly with more data. Since
> enabling the bigger GuC logs (~1.5 days, 35 stalls): 12 stalls were
> unstuck by one of the H2G interrupts within 0.3-1.5s, but 23 ignored
> 8-9 consecutive interrupts and ran to the end. And in those severe
> cases the request-to-ack time is nearly constant: 2.28-2.34s, every
> single time. It does not look like congestion - it looks like a fixed
> internal timeout expiring somewhere and releasing things.
>
> Related: an A/B experiment I ran earlier (holding forcewake across the
> whole GT, C6 residency pinned at 0ms for the whole window) still hit 9
> timeouts in a row, so GT-level RC6 avoidance alone does not prevent it.
>
>> Also, would you be able to capture the GuC logs when the issue occurs?
> Done. I rebuilt with the debug-sized log buffers (8M event data / 1M
> crash dump / 1M state capture) and xe.guc_log_level=3, and the series'
> patch 1 (devcoredump on TLB invalidation timeout) captures the GuC log
> at the exact moment the timeout fires. I attached three devcoredumps
> (4-8.7MB each, containing the full GuC log around severe stalls that
> ignored 8-9 H2G interrupts) to the gitlab issue:
>
>    https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678
>
> I have more captures if useful (9 so far).

Do you happen to have the matching dmesg for those? I decoded the logs 
but there are thousands of invalidation calls in them; I looked at the 
last few but from the GuC POV they've all been handled quickly. Dmesg 
error should log exactly which invalidations were delayed from the 
driver POV so I can just look at what happens around those.
Also, I have noticed that the failures seems to all be on GT1. On MTL, 
there is a caching bug on GT1 and we do not implement the WA for that in 
Xe (Wa_22016122933). Not sure if this is the actual root cause, but the 
fact that it only happens on GT1 makes me suspicious (i.e., it is 
possible that the GuC is replying in time but CPU doesn't see the reply 
because the cache-line is not correctly updated, or vice versa). Not 
sure if there is an easy way to implement this in Xe to test, that's not 
really my field of expertise; maybe adding XE_BO_FLAG_FORCE_WC or 
XE_BO_FLAG_NEEDS_UC to the CTB allocation could work as a quick hack? 
But I'd like either Matt or Thomas to confirm.

Daniele

>
>> I have pushed the latest GuC FW for MTL here in case you want to give it
>> a go:
> Downloaded and staged - I will switch to 70.72.1 via
> xe.guc_firmware_path today and report back with a few days of data
> (this machine currently reproduces 20-35 stalls/day under my normal
> workload, so the signal should be quick).
>
> Thanks,
> Tales
>
> Em ter., 4 de ago. de 2026 às 20:50, Daniele Ceraolo Spurio
> <daniele.ceraolospurio@intel.com> escreveu:
>>
>>
>> On 8/4/2026 4:00 PM, Tales A. Mendonça wrote:
>>>> Are we seeing this on i915?
>>> I have not tested i915 on the affected machines yet - the
>>> instrumentation that measured the stalls (late-ack logging, kick
>>> results) is xe-only, so I have no comparable i915 data. I can boot one
>>> of the ARL machines with i915 for a few days and watch for TLB
>>> invalidation timeouts there, if that data helps.
>> That would definitely help, because if the issue does not happen on i915
>> it likely means that we're missing a WA or something like that in Xe.
>>
>>> More generally: both machines here reproduce reliably (~1 stall/hour
>>> on a desktop workload, much more under memory pressure), so I am happy
>>> to test anything on them - including any GuC build the firmware team
>>> would like data on.
>>>
>>> On Stuart's masking concern: fully agreed, that is why patch 3 is
>>> marked RFC. Patches 1-2 are pure diagnostics and stand on their own; I
>>> am fine holding patch 3 until the firmware side has been looked at.
>>> The data point it adds is that a doorbell ring unblocks the ack in the
>>> majority of episodes, while the severe ones ignore 8-9 consecutive
>>> rings - hopefully that narrows where to look inside the GuC.
>> Just a bit of a terminology update here, to make sure we're on the same
>> page: we usually refer to the notification you're sending to the GuC as
>> an H2G interrupt and not a doorbell. I'm making this clarification
>> because the GuC supports a separate per-context notification mechanism
>> that is referred to as doorbell and which we currently do not implement
>> in neither i915 nor Xe.
>>
>> When receiving the H2G interrupt, the only thing that the GuC does is
>> look into the CTB and process anything in there; however, you've said
>> that the contents of the H2G CTB are processed immediately, so the
>> follow up interrupt should result in the GuC just bailing out and doing
>> nothing because there is no data to process. It feels like when the
>> issue occurs something is stuck in HW rather than GuC FW and triggering
>> the interrupt causes the HW to get unstuck.
>>
>> I have pushed the latest GuC FW for MTL here in case you want to give it
>> a go:
>> https://gitlab.com/dceraolo/drm-firmware/-/blob/f783b931555be057dafc2400b7eb4d445c953fec/i915/mtl_guc_70.72.1.bin
>> . You can override the GuC firmware used by the driver via the
>> xe.guc_firmware_path modparam; the path is relative to /lib/firmware/
>> and the firmware needs to be in initramfs for the driver to find it at
>> boot. Note that we haven't tested this image on MTL, so it might have
>> unexpected results.
>>
>> Also, would you be able to capture the GuC logs when the issue occurs?
>> The default guc log size is relatively small, so you'd have to capture
>> right when the issue happens. However, you can make them bigger by
>> building the kernel with CONFIG_DRM_XE_DEBUG or by simply modifying the
>> xe_guc_log.h file to pick the bigger size by default. If you go with the
>> latter, please also set xe.guc_log_level=3 on the command line (this is
>> automatically added by the kconfig).
>>
>> Thanks,
>> Daniele
>>
>>> I will send a v2 addressing Matt's review comments (the
>>> __xe_devcoredump unification and the fixes on patch 2).
>>>
>>> Thanks,
>>> Tales
>>>
>>> Em ter., 4 de ago. de 2026 às 19:08, Daniele Ceraolo Spurio
>>> <daniele.ceraolospurio@intel.com> escreveu:
>>>>
>>>> On 8/4/2026 2:33 PM, Summers, Stuart wrote:
>>>>> On Tue, 2026-08-04 at 14:27 -0700, Matthew Brost wrote:
>>>>>> On Tue, Aug 04, 2026 at 03:02:44PM -0600, Summers, Stuart wrote:
>>>>>>> On Mon, 2026-08-03 at 23:14 -0300, Tales A. Mendonça wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> This series is a follow-up to the TLB invalidation ack stall I
>>>>>>>> have
>>>>>>>> been debugging on ARL, tracked in:
>>>>>>>>
>>>>>>>>      https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678
>>>>>>>>
>>>>>>>> Summary of the issue: with GuC 70.53.0 on ARL (reproduced on 7d51
>>>>>>>> and
>>>>>>>> 7dd1 machines here, plus an independent Arc Pro 130T report on
>>>>>>>> the
>>>>>>>> issue above), TLB invalidation acks intermittently stall for
>>>>>>>> ~2.3s.
>>>>>>>> The H2G request is consumed from the CTB immediately and the G2H
>>>>>>>> CTB
>>>>>>>> is empty the whole time - the firmware simply does not send the
>>>>>>>> ack
>>>>>>>> until much later. The fence timeout fires at 2.25s and the ack
>>>>>>>> lands
>>>>>>>> tens of ms after it. Userspace blocked on the invalidation
>>>>>>>> (compositor
>>>>>>>> buffer unmaps etc.) hitches for the full window.
>>>>>>> Firstly, thanks for the patch!
>>>>>>>
>>>>>>> I haven't looked in to all the details of the sighting you were
>>>>>>> debugging, but we have had similar issues that were fixed in a
>>>>>>> later
>>>>>>> GuC version. I think around 70.60.0? It might be worth trying on
>>>>>>> something later than that to see if that helps... (+Daniele)
>>>>>>>
>>>>>> I think this would require an AR on our end to make a new firmware
>>>>>> version available.
>>>>>>
>>>>>> The upstream repo only has 70.53.0 available for ARL [1] (iirc, ARL
>>>>>> aliases to MTL for firmware). (+Julia too).
>>>>>>
>>>>>> Presumably, the GuC changelogs should indicate whether an issue
>>>>>> related
>>>>>> this has been fixed. If so, we need to update all GuC versions across
>>>>>> both i915 and Xe.
>>>>> Right... I guess I'd still like to see if we can test this in GuC (or
>>>>> get confirmation we can't for some reason) before committing something.
>>>>> My worry is we will prevent bug reports like this by working around it
>>>>> and miss critical bugs that need to be fixed in the right component.
>>>>>
>>>>>> [1]
>>>>>> https://gitlab.com/kernel-firmware/linux-firmware/-/blob/main/i915/mtl_guc_70.bin?ref_type=heads
>>>>>>
>>>>>>>> Patch 1 adds xe_devcoredump_gt() so this kind of hang - which has
>>>>>>>> no
>>>>>>> Is there a reason we don't just re-use the main xe_devcoredump()?
>>>>>>>
>>>>>> This is my suggestion: the main devcoredump infrastructure is job-
>>>>>> based,
>>>>>> so it cannot be used for hangs that are not associated with a job.
>>>>>>
>>>>>> In my opinion, this is a gap on our end. Introducing something like
>>>>>> `xe_devcoredump_gt()`, which can be used for non-job-based hangs
>>>>>> (e.g.,
>>>>>> TLB invalidation timeouts like those addressed in this series, or
>>>>>> more
>>>>>> generally any GuC protocol hang), makes sense to me.
>>>>> Ok makes sense. We can do that here. It would be nice to have a more
>>>>> inclusive implementation that lets us call this from anywhere so we
>>>>> aren't duplicating things around for different use cases. But not a
>>>>> blocker here.
>>>>>
>>>>>> I haven't looked at the patch yet, but at a high level, adding
>>>>>> `xe_devcoredump_gt()` seems like a reasonable approach.
>>>>>>
>>>>>>>> exec queue or job to blame - leaves a devcoredump with the GuC
>>>>>>>> log
>>>>>>>> and
>>>>>>>> CT state behind (Matt suggested capturing devcoredumps when we
>>>>>>>> discussed the issue; devcoredumps from both machines are attached
>>>>>>>> to
>>>>>>>> the issue above).
>>>>>>>>
>>>>>>>> Patch 2 logs when the ack for a timed out invalidation finally
>>>>>>>> arrives. This is what established that the acks are late rather
>>>>>>>> than
>>>>>>>> lost.
>>>>>>>>
>>>>>>>> Patch 3 is the RFC part: a delayed work that pokes the GuC
>>>>>>>> (status
>>>>>>>> register read, CT flush, doorbell ring) every 250ms while an ack
>>>>>>>> is
>>>>>>>> overdue. On my machines this converts the guaranteed 2.3s stall
>>>>>>>> into
>>>>>>> I'm a little worried we're just papering over something here that
>>>>>>> needs
>>>>>>> to be addressed in GuC, particularly around GT going to sleep or
>>>>>>> something around the time we're expecting a response, so the pings
>>>>>>> on
>>>>>>> registers might be prematurely waking things up which is something
>>>>>>> we'd
>>>>>>> want to happen in GuC, not the KMD.
>>>>>>>
>>>>>> In general, I agree with this. We should avoid papering over the
>>>>>> issue
>>>>>> and instead fix it properly in the GuC. That said, this workaround
>>>>>> provides a pretty strong data point, since it appears to get the TLB
>>>>>> invalidation unstuck.
>>>>> So if we hit this issue I guess we're already going to have some
>>>>> performance degredation and the workaround makes that better. I need to
>>>>> look at the implementation, but we could be potentially introducing
>>>>> performance penalties in other areas doing these pings.
>>>>>
>>>>> Again, I'd like to see if we can fix this in the right place before
>>>>> implementing a workaround for it. Hopefully Daniele or Julia can give
>>>>> some direction there.
>>>> Are we seeing this on i915 at all? Given that Xe does not officially
>>>> support MTL/ARL and is missing several critical WAs for those platforms,
>>>> the approach so far has been to only update the GuC FW if it is required
>>>> for i915.
>>>> Looking at the GuC release notes, there have been a couple of
>>>> TLB-related fixes after 70.53, but they're both marked as only affecting
>>>> PVC and Xe2+ platforms, so no fixes seem to be available for ARL (or at
>>>> least they're not listed in the release notes).
>>>>
>>>> Daniele
>>>>
>>>>> Thanks,
>>>>> Stuart
>>>>>
>>>>>> Matt
>>>>>>
>>>>>>> Thanks,
>>>>>>> Stuart
>>>>>>>
>>>>>>>> a
>>>>>>>> sub-500ms hiccup for the majority of occurrences; a minority of
>>>>>>>> severe
>>>>>>>> episodes ignore 8-9 consecutive doorbells, which points at the
>>>>>>>> GuC
>>>>>>>> firmware being internally blocked for the whole window. Full data
>>>>>>>> on
>>>>>>>> the issue. I am happy to rework the approach (different delay,
>>>>>>>> tying it to the G2H handler, dropping the status read, etc.) -
>>>>>>>> mainly
>>>>>>>> I would like the firmware side investigated, since no host-side
>>>>>>>> poke
>>>>>>>> can fix the severe cases.
>>>>>>>>
>>>>>>>> Based on drm-tip. Tested for several days on both ARL machines
>>>>>>>> under
>>>>>>>> desktop and VM-heavy workloads.
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Tales
>>>>>>>>
>>>>>>>> Tales A. Mendonça (3):
>>>>>>>>      drm/xe: Capture devcoredump on TLB invalidation timeout
>>>>>>>>      drm/xe: Log when a timed out TLB invalidation ack finally
>>>>>>>> arrives
>>>>>>>>      drm/xe: Kick GuC while TLB invalidation acks are overdue
>>>>>>>>
>>>>>>>>     drivers/gpu/drm/xe/xe_devcoredump.c     |  68 ++++++++++++
>>>>>>>>     drivers/gpu/drm/xe/xe_devcoredump.h     |   6 ++
>>>>>>>>     drivers/gpu/drm/xe/xe_tlb_inval.c       | 131
>>>>>>>> +++++++++++++++++++++++-
>>>>>>>>     drivers/gpu/drm/xe/xe_tlb_inval_types.h |  42 ++++++++
>>>>>>>>     4 files changed, 243 insertions(+), 4 deletions(-)
>>>>>>>>
>

