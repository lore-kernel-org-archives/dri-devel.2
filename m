Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E45C1CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 11:16:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D31C10E17B;
	Wed, 20 May 2026 11:16:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Ks5jg31d";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B2EE10E126;
 Wed, 20 May 2026 11:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779275785; x=1810811785;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=lSNkvMuvkEKi16moFyMdhq+HYB+ZcJmOu2kC7OAPiLI=;
 b=Ks5jg31dH01wqigg6g5ni4IbdAQy927f9EmGR9DUdMKtpdUAHkHlS0kD
 intoE4MhlIKdVJZFX7VTHjNF/DzNgjD/nIbMPJPxBaIMiTv4prAtTieqG
 GIBqxTiiHuJDfJgzL4FQlqVq6hls2LbvMIuIRu4GgpkM9pVEmhEF2QvrF
 8NLdZvqy0Ga9w/HPQg+pkVEbW/YeGf1g8D7j3Y5PaeD4Xw8JuhRBGPpiG
 gKMKsll6NGDwfP/rT+8Hu+QXyMi5pYLrJyhVAj+J78rLj2p2coSUGBvvy
 N7MKWaw+PykdSS7SoPncZqsb2i6aYL1VXJ22urC+8nhMMiZbG+l6SsuZC A==;
X-CSE-ConnectionGUID: Jp09yiD8Tqm+7QCZlcTDNw==
X-CSE-MsgGUID: dQO5JMZoQjePK/s+JZJrlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="90867003"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="90867003"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 04:16:24 -0700
X-CSE-ConnectionGUID: KR+CrY2ZS5ilYkvAx1QPPw==
X-CSE-MsgGUID: 5Kn24HYsSciTdqW0M6ULWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="263937402"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 04:16:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 04:16:24 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 04:16:24 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.56) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 04:16:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nl1oNy7OpwoHCdm1bX+wIuCerW6CdNZolFo7CK8Eax03q7CdFywB/OJ+WPDffvMVW79khKEF6Sn7Hn15qsTylOqLWX4vaX3HRSenXsymI5s9zFkj1ZlIG7Wv0Pcqmnjd0Uci92OOYKskFTshJnk6hpyUVkborMUscDO9L2YonA5smuQo/sb6kz1FsgVimGzkRg4OvCQqSsYqipne/iXZ8dm7ImhTia0V9zzvRtiiL/fR8/OCyHiWJm2TdpUJWNCuG4zNYQcJhwsMvYm0xfX0vUVd4TRNI5TxHKdVkgpr4ea+3zCZY3N/wMIuAVPk+2kIBT4BnD8wh3xHCA5IA1aH6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsT+TB0BHqZS78PoLbiS4c++ijGC61DfEh6PglEIes0=;
 b=Bga85Ydor7Ae+aSIjClyOtzzDEky1mKuiJoPOWPqd09exUrTArR2HUEchL5ZhBQxs5OIo6Nsdmb6b0EunokH1GASJYEqjf85ewbd+NFLdQLd/3U+4D4sPdwyNfMVqkZ2T0gTmCsIjCNKxViTSrBKcfwgSPh9DUcNiOuhZeZu52+t2uOfHMARmSsYl8O4nL68WONMcdNNau18IvsGkdQvIt70xdXLhAsgn5wq8UNB4CJoXubQpMyemXWHyitnJCNAp2s0e+6x6Jk47LJjOtOD/HfBNxpp29gx9VXsqej9J1lVjK3QYPuXyUPxb+DkxRGMeBUCrNVaig5ycmEWLEaLUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6207.namprd11.prod.outlook.com (2603:10b6:208:3c5::21)
 by IA4PR11MB9059.namprd11.prod.outlook.com (2603:10b6:208:560::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.13; Wed, 20 May
 2026 11:16:20 +0000
Received: from MN0PR11MB6207.namprd11.prod.outlook.com
 ([fe80::52eb:929f:a8b2:139d]) by MN0PR11MB6207.namprd11.prod.outlook.com
 ([fe80::52eb:929f:a8b2:139d%5]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 11:16:20 +0000
Message-ID: <84771443-b109-4a53-abea-82a4d4a44e46@intel.com>
Date: Wed, 20 May 2026 16:46:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] drm/xe: Suppress Surprise Link Down on non-hotplug
 device
To: "Tauro, Riana" <riana.tauro@intel.com>, <intel-xe@lists.freedesktop.org>, 
 <dri-devel@lists.freedesktop.org>, <rodrigo.vivi@intel.com>
CC: <andrealmeid@igalia.com>, <christian.koenig@amd.com>, <airlied@gmail.com>, 
 <simona.vetter@ffwll.ch>, <mripard@kernel.org>,
 <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
 <anshuman.gupta@intel.com>, <badal.nilawar@intel.com>,
 <karthik.poosa@intel.com>, <sk.anirban@intel.com>, <raag.jadav@intel.com>
References: <20260512132614.1793083-7-mallesh.koujalagi@intel.com>
 <20260512132614.1793083-12-mallesh.koujalagi@intel.com>
 <0e5cef01-3770-4865-8571-82611f52c553@intel.com>
Content-Language: en-US
From: "Mallesh, Koujalagi" <mallesh.koujalagi@intel.com>
In-Reply-To: <0e5cef01-3770-4865-8571-82611f52c553@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0117.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a7::14) To MN0PR11MB6207.namprd11.prod.outlook.com
 (2603:10b6:208:3c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6207:EE_|IA4PR11MB9059:EE_
X-MS-Office365-Filtering-Correlation-Id: 7621f718-dc0e-4581-c9e2-08deb661382e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|4143699003|56012099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: inVdrnqot1ThTvPxC1k5/3g+OB7gCeud/l7/D7xdDGoCeekmKCYbSF72Oje59mIXqWtx4a5i/0/ewGKuvgrDRL4j2364bZxTLYKJAryZtA4BlBPlekzcSQD+ZbhGywoWzSaoLcXp+q7fxf4gdl5Ogx4qgBPRxdbZ2HxxIsdHrCCizlE6Kjhml45G48t4ggi4GSS7MG65X+j7YE8BdFAMAcqLdeCHRqqUmy98gx21tJq+SM5ZoL5MLNNPTD9dsHFMH1PeH4nJlOfw3LV0l1awfJg40wvlbMVmtSW38uVLyaNSP/Ezj9YjkEjtn+zARfD4HyF9nl++i7LykFXiPcnNJVnBg2qUeZjA2JZwhZeHWmfuVkaZ4ftiLwCvVNMPuYmRlIflerXQJxKpwrdmNOhbYwlXTpLJmZn0gRb4lEPDWcxmVH3VVM+NOh7oUdY+xoNEKShFURmuG2ZShSRVK/i1RgdPZvFssDW5zNK9YjUmkP/OgW3FTax8fQFz8d8Wto9Uh+cPmDhRXsAXTTXm69qv/CuopRhKalTYSA25UMplzYT8FBfqhyxjM2VJ+KInlvzXNyICNg9VL0s8CDLoYoMeOaFGes1JWOIbKC/3Xx1O9uDV2fJwcX+wWAG9v9q0nKcP5VDE08HrbYV8DKFokmNdujVAraK3oSvTlBY+VuALaJ2PfNWLzQ194JfsjIR2Zl2N
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR11MB6207.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(4143699003)(56012099003)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1Q0a3VXT3FvdEpPdG9vM2lWK3R0c0dFeFJKVjB6OUU2b0hRNGRtZ085TTJG?=
 =?utf-8?B?ck5MMWpJTnhMSlQ4Yk5KQU1IRXFkTnNnZWZEaG15WkxpajhFM1dycGZ6SGpK?=
 =?utf-8?B?RWprdUU0TkJ0bTVpRytFaXFuV0xjKzVGam03V3Z2YzhkZk5yWFBFa0Z5aVpS?=
 =?utf-8?B?VWkzcU1Ga1BvMkltV1hZZk1STlBhYWdSZy9HUWVxQ3lDaTB5SE9oMm4yczVj?=
 =?utf-8?B?MlI2MTR6ZEpORWJISEoxMHE5bkRLTlVZYWV5emtnMWtXaUl2UVVVcnVEM1FK?=
 =?utf-8?B?Uy9tckhmWW5wT1U0QXBZcE0vdUdZdE1DOGFPK1UwTk9Jc3d6bjdTby9IcGRt?=
 =?utf-8?B?eFVQQWdYUTVPK2ZPRkw4Mm02cGZNY3Q4VU5RODUzYnY5RWcvTUdzU3p4MHB6?=
 =?utf-8?B?U0hlTVlOZk5lNGFkN0VLV0lCT2M3TDZwajg5d2VrclhDSUlqQ1B0cFVaaHAw?=
 =?utf-8?B?MWkveXlEdHUyVDNRVkp0ZlBNc0ltQkY4NjRKRjhnaGtKVi80Tkl3S01NRnhy?=
 =?utf-8?B?akNlb0Y3WDFmM01HTnJDY3VZWHgvK2RGMElGUjFoQXFUdEtzcE9zMEVBK2ZH?=
 =?utf-8?B?RjhXQlh6b3dLZlA5cXh5WVZWdXBYcVFuQ1NuYndKVGFwWU1VdkdlNGJoZll6?=
 =?utf-8?B?TUs1M1Z5N1JKcFFFRStJTHBOTHVzOFFVZ09wN3MvNHlLTzFwbzh0QVBVWDVp?=
 =?utf-8?B?aXE3Y05LR0NXaGU0S2dvajZiYXY3cml4bERnbnFEYlhPZzJpU2NLZHkreGF6?=
 =?utf-8?B?ckJRUEFpU2JucTM2bEJVbVJ6NmhJcS9raVY0MERSSGdSNGhaL1RVenZSOFVB?=
 =?utf-8?B?MS9EWjBzSEduNm1nRHUxWXo3SCtYOHVEUDVhemJKK2VFYmswQzBxYnNnakw3?=
 =?utf-8?B?WXBKemJKQngrNTl5YzFDYSsxYkc4WEY1MUdacUt1SEN0ckZGaUdpNnF4S3I0?=
 =?utf-8?B?MU9UNmcvN1Zpc3ZqdWQ2cm5HK2FEaWRKR3R4akI2MmhUdWxrNnFXZG45a2o5?=
 =?utf-8?B?c08zSkZGUnNQb0hkZExzOS9WZmxWbkQzZDlzVVlvVnRiN0dOMWNLMnR0cjRn?=
 =?utf-8?B?azhTUFJyOGZ4K0x2NWpYWHNlOUsxNzJnMnVETVNXVUp1cWh5aUhaRHlVVk9t?=
 =?utf-8?B?VkJvcXlsV2RNZWlGdWUrTHZoMWo5VFVQa2F0eVZ0T2JycUVEcmNDOHpBT2pI?=
 =?utf-8?B?MXlRV1Q5MGU0a3U3N3habU5MZDc1c3R3dlJvaWEzS3hMbnJuQzQ5ZE1UcnJX?=
 =?utf-8?B?YUZZQjFPMmN2di8xOVBuR1JMU3RwWDhiRGVCK2NPcUlpQUc2OTl2MVY0L3Zt?=
 =?utf-8?B?UnJYbTAvSVBaNkdPTGNaQnptSU0xbCtkN2N3V3IveW9PUDlQQ3NOVDN3MzFw?=
 =?utf-8?B?NG8xVkFBUmR0STY2TlVmb2lpcysyZHlEZk1ERkVXZnpJbnlvK3dCNW5KdmR6?=
 =?utf-8?B?bVhreVBYbjlYbENYcy9lTzdSMFJYd003U2swSzB5KzdKak5pRVV0eERVYnAr?=
 =?utf-8?B?VFpmV2NGdVlUWnBCSXVGa2xWTlQ3Znp6TUpTWDMzTStydzljTzF0eFVaOUhF?=
 =?utf-8?B?Yk05b2ZGLzJkUjF3SW9WZGhjazl1azVBalZyUjU0OUdYNVh0UlNDSmRDNTlk?=
 =?utf-8?B?MFhqNk1kLzhNbzZDWEdPYmxSa2Nkd2N5azlHdnZMT0xIdlZlMG5HUXZLUlZk?=
 =?utf-8?B?a0xqN0ozNnRVRmJDMEZ3cW9acC9nSW90RWxCVlgwSFpicnAzdTNsM29CN0FS?=
 =?utf-8?B?Tnh5WWRCdmRxZjJsYk9reVB1TmxrREw1dmlBdDVEbWNVL2FoZ3JlQTN6NzVt?=
 =?utf-8?B?Zyt0c1V0RGNmb3BZOWJoTkhEelpTL0R6UzdNTTk5MGNhNDFMbmgrYzlreGJv?=
 =?utf-8?B?V3JoaGN6T1B0aUwwV2hUNFpUR0lPc2sxa2hscW5xdld4NDdRSkRrU2FkOVcy?=
 =?utf-8?B?SG82SjdGSmdXd3Zzd0x1TXVlU09qKzhwYUZLWXB1OGZKalVQYjEzUW5sOS90?=
 =?utf-8?B?UXg1MVhXeWNhbTF0UXF3V2ZQTStjVkRIU1NpY0FKTzBId3ZDYmlTaU5ieUJr?=
 =?utf-8?B?Y3pic1Bmb01vQTF3amsxNTl0eDFpQUVpWENYVCswMGxJUlFVY2ludmd5bDVo?=
 =?utf-8?B?b2J4OGdWRHNPTmR3eHFlTzZ4VTZSV2IzZldCejVSdW9xZU4zRjVlVUk3R3RE?=
 =?utf-8?B?V0p5ZGFjNG5CUGRKODBZVDBuelBBTmUyVmxXU3BxUnJYam0wYTN4L3A1UUth?=
 =?utf-8?B?RVY5cEVrZ1Noc244dmRDb3lDbjU4T3VaNmYwMjhYTmRCWEFKK1lndlpPTUYw?=
 =?utf-8?B?TGt4VWJwbU5oc3VMRU1udlp2SzFxWXgzbkxhMXp5Y1BFSXdTNnBWRGxwSWRv?=
 =?utf-8?Q?SotC39FQPwHyS3Hg=3D?=
X-Exchange-RoutingPolicyChecked: dfn2N92NUELyrWACqDQ/vuXokjzM6bb2MSNWuGOd9xzXzw6kIqQTKVyvC5CKqdI/u510tR6wRdsDWaiat4/cjspoUyDhh/1NYczKNtsAvkl0lTF/qsMFUpS/FVx1U5DrOesfJ/ap1u5yoxZqZlhC9ApvuLgzav6NAG1OjRRDzGvNfYbHYfNG8FK0XehxX+Ssee/6yGjlriBmvc/2FlAQiaT42e/LDyoWr/zBV/8J76oRGVRqO0tWRAJg68mUdcw3jxQIg9X+uUlZkolChiRsHO4qr3tF1R/P7ThvP0wwjMCC+3V6G66aZb71WPFnxTtmXgb9jdbJaikvKCL4t0DfmA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7621f718-dc0e-4581-c9e2-08deb661382e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 11:16:20.5253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lF/KRjg+knye+VoXk1TzaxEnRPfLtB+xYAoGfp5gyGdFKDSMVPwTSJC1uVyJ9zhi2xfSVcWwBmA7r2uwXnpVtEGDxwS32YGZWxJRLW8reww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9059
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

Hi Riana,

On 14-05-2026 03:06 pm, Tauro, Riana wrote:
>
> On 5/12/2026 6:56 PM, Mallesh Koujalagi wrote:
>> If the slot is not hotplug capable, pcie_suppress_surprise_link_down()
>> masks the Surprise Link Down bit (PCI_ERR_UNC_SURPDN) in the USP's AER
>> Uncorrectable Error Mask register before punit_error_handler()
>> triggers the cold reset.
> Provide more details on why. Avoid function names and macros unless 
> necessary.
> Make it more human readable.
>
Sure, will provide why part in next revision.
>>
>> Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
>> ---
>>   drivers/gpu/drm/xe/xe_ras.c | 51 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 51 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
>> index 604470565bf3..67b4f25370c9 100644
>> --- a/drivers/gpu/drm/xe/xe_ras.c
>> +++ b/drivers/gpu/drm/xe/xe_ras.c
>> @@ -224,8 +224,59 @@ static enum xe_ras_recovery_action 
>> handle_core_compute_errors(struct xe_device *
>>       return XE_RAS_RECOVERY_ACTION_RECOVERED;
>>   }
>>   +#ifdef CONFIG_PCIEAER
>> +static bool pcie_slot_is_hotplug_capable(struct pci_dev *usp)
>> +{
>> +    struct pci_dev *root_port = pci_upstream_bridge(usp);
>> +    u32 sltcap;
>> +
>> +    if (!root_port)
>> +        return false;
> From the PCIe spec
>
> "If this register is implemented but the Slot Implemented bit is 
> Clear, the field behavior of this entire register is undefined."
>
> Please check the slot implemented bit (8) in  PCI Express Capabilities 
> Register before reading the slot capability register.
>
Good catch!!, will update next revision.
>> +
>> +    if (pcie_capability_read_dword(root_port, PCI_EXP_SLTCAP, &sltcap))
>> +        return false;
>> +
>> +    return (sltcap & (PCI_EXP_SLTCAP_HPC | PCI_EXP_SLTCAP_PCP)) ==
>> +        (PCI_EXP_SLTCAP_HPC | PCI_EXP_SLTCAP_PCP);
>
> Do we need to check power controller here? Isn't hotpluggable denoted by
> PCI_EXP_SLTCAP_HPC ?
>
Yes, we need to check, power controller support for cold reset without 
that we cannot trigger cold reset from host path.
>> +}
>> +
>> +static void pcie_suppress_surprise_link_down(struct pci_dev *usp)
>> +{
>> +    u32 aer_uncorr_mask;
>> +    u16 aer_cap;
>> +
>> +    aer_cap = usp->aer_cap;
>> +    if (!aer_cap)
>> +        return;
> add debug log
Sure!
>> +
>> +    pci_read_config_dword(usp, aer_cap + PCI_ERR_UNCOR_MASK, 
>> &aer_uncorr_mask);
>> +    aer_uncorr_mask |= PCI_ERR_UNC_SURPDN;
>> +    pci_write_config_dword(usp, aer_cap + PCI_ERR_UNCOR_MASK, 
>> aer_uncorr_mask);
>
> save config space?
>
Not required, after device power cycle, it's restore it capability to 
handle surprise down event.

Thanks,

-/Mallesh

> Thanks
> Riana
>
>> +    dev_dbg(&usp->dev, "Non-hotplug slot: Surprise Link Down masked 
>> for cold reset\n");
>> +}
>> +#endif /* CONFIG_PCIEAER */
>> +
>>   static void punit_error_handler(struct xe_device *xe)
>>   {
>> +#ifdef CONFIG_PCIEAER
>> +    struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
>> +    struct pci_dev *vsp, *usp;
>> +
>> +    /*
>> +     * Device Hierarchy:
>> +     *
>> +     * Root Port --> Upstream Switch Port (USP) --> Virtual Switch 
>> Port (VSP) --> SGunit
>> +     *
>> +     * Cold reset power-cycles the slot, dropping the PCIe link. On 
>> a non-hotplug
>> +     * slot this triggers a spurious Surprise Link Down AER event on 
>> the USP.
>> +     * Suppress it if the slot is not hotplug capable.
>> +     */
>> +    vsp = pci_upstream_bridge(pdev);
>> +    usp = vsp ? pci_upstream_bridge(vsp) : NULL;
>> +
>> +    if (usp && !pcie_slot_is_hotplug_capable(usp))
>> +        pcie_suppress_surprise_link_down(usp);
>> +#endif
>>       xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_COLD_RESET);
>>       xe_device_declare_wedged(xe);
>>   }
