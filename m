Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 715EAC531D1
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 15:05:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C981F10E584;
	Thu, 23 Jul 2026 15:05:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Nh98EHUh";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE44410E110;
 Thu, 23 Jul 2026 15:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784819108; x=1816355108;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=IP6TJCaGS7sLPITn0lffLKCLcEZYRTE6IykS6SS/Pkw=;
 b=Nh98EHUh/uyJGxbjHotCskUlUvTlrVT2V+qVhNWQMCJu6A0H0XoZWgL0
 CzvER7bzztRK+T07UkMdkgUyJn234w0evIr6gGMEN97dycwhhaDQwI3PE
 InbiEN+uccW7Q3U3zEc+UeuZY1ssOrAmwVrKrXQPCuGSExakowpO1csRw
 8UX825gVA4swb6RJY01Sa1A1OoznhIhAJ+6WZid208FRyR0XN/lp+rWoI
 yPEXGMx7VaA41UKxt4VCIP6ZZnX8OMCB6UO8+V2umhS/4Bm7gMybGPTiT
 +k4LiR7M0AZWOZW3OSv+/nTn//qEDjCnV39gNg7mBRe55vFCb8ROZ2jWu Q==;
X-CSE-ConnectionGUID: AyUdR55uR4SDcipq2yr7uw==
X-CSE-MsgGUID: hK1ozBx0R66ILXaPiDhCkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="95831460"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="95831460"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 08:05:07 -0700
X-CSE-ConnectionGUID: VNyshCiVTqmcPwMUmpldCA==
X-CSE-MsgGUID: sGejLgKvT4KUqZRuTcJTzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="257907537"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 08:05:07 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 08:05:06 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 08:05:06 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.57) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 08:05:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sySBqit/zVIW0/uU7Kv91sBcLC/+PesPkmFer3TPPO28v6xF0lBuWDPlZG8vuKfJJ7cnePgXA1sOk7pRkg3svjfDTFvUOsDx8cSj2GW9UWzmf+rMwkdQlRx6Q6NMR+UpKISMXxzm4+qh9Oa+gpAFhhaaMvIOXWwvjEmY/6aX5wy/c0T1Pm6lyc49eboWyyCstlkisCwiEa+3Cou+IH5owyLwu9vc9NLKu/loMJmeMOtfcn/+2mBWdVkQrH7njKc/cPmWR3Bwl+jH8v/EwCgEAKb/4P0HaDVz9BCYNHSZYdU5L4u41ZFs8ic3R8BYDRY/rIT7+LzhQZ+HjM3Fwfh7Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lz4h+ZGVN5dB65daWv420Dm0495I5nDK2k+wqQK6CBA=;
 b=BDgg7DZef1/5rZNn1U7LoZK2MhUozbfQVo6eCo0DM4pw2z/WiLFMB7Rh4N9gqBYnvvxTewuiHEGT8hS/GI52ARwuGuPlBzYKr+MHGfLC0uHP/0YPKamT8VcJraA/FyiOXG3VwrdM2Q+irXyWJ9rJIbf9I2uycDoTB5ptgmhud/1ztkqoZFIFLi3/9WAfaX6yN//t+S+K/07rhw1hEhL2AnVztv9/9oTjpiDgwqNYd1qJZ62fUou2ZFPGVl9+kyYpke4fPtdcrPpG1cOPVBidYT0/+61IJpiFjBJEUMqvHrP4nHJ/VMEdT6lfnvI1dIOgdKaiyNvhTWnFiZYZTIx7Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 IA4PR11MB9057.namprd11.prod.outlook.com (2603:10b6:208:55d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 15:05:01 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 15:05:01 +0000
Message-ID: <f08a30a8-afca-4cad-8353-5c3ce091a9ef@intel.com>
Date: Thu, 23 Jul 2026 20:34:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] drm/xe/xe_ras: Report correctable/uncorrectable
 error events to userspace
To: Raag Jadav <raag.jadav@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <netdev@vger.kernel.org>, <aravind.iddamsetty@linux.intel.com>,
 <anshuman.gupta@intel.com>, <rodrigo.vivi@intel.com>,
 <joonas.lahtinen@linux.intel.com>, <kuba@kernel.org>,
 <simona.vetter@ffwll.ch>, <airlied@gmail.com>, <pratik.bari@intel.com>,
 <joshua.santosh.ranjan@intel.com>, <ashwin.kumar.kulkarni@intel.com>,
 <shubham.kumar@intel.com>, <ravi.kishore.koppuravuri@intel.com>,
 <maarten.lankhorst@linux.intel.com>, <mallesh.koujalagi@intel.com>,
 <soham.purkait@intel.com>, Michal Wajdeczko <michal.wajdeczko@intel.com>
References: <20260722094134.3036087-4-riana.tauro@intel.com>
 <20260722094134.3036087-6-riana.tauro@intel.com>
 <amDglMC44EIWChvp@black.igk.intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <amDglMC44EIWChvp@black.igk.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0200.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b2::15) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|IA4PR11MB9057:EE_
X-MS-Office365-Filtering-Correlation-Id: bdad415d-b414-411c-3c4f-08dee8cbc507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: DVcm7EqtaoTZSS31AI9erMSUwk3wIrRq6s/0ILqN9+s7wRClQyvbFB14v12Ehn2XTRJ87TuN9xvc1iFvvFIRoZeott+hGs544y+fahGN1cAopJrsEH7pxPKJckrV5MCg1uWKMEB3C7zKDrOEuJjpvJ4adoioUeABWMOMKb1F031Vkikqt7P9uGigdld/DyHS20l6PVf24TOe4sMf0IjELVs3Ubn7UI6nttc6Rj0o//WufqJYDISIQznMvYFpfz3IXesGxFwvbB9wxhbfGPMAl6IxS8u20x1WvgctIlzpDveBtKFFp6kiv0N2FTkb9iBZiQglquB7iK26LEyJvwSGAzP9RGhc6ChU8zKOgfvFkP5az4qlk6H54pXSl+i5Rdu/giy6/Vk10Pgkoa2UTJoyiSZBnT4mA5zbPRU8LlPrlYjqNDpSA0/Sq+ElJWfJyNeovi8Ohsmo0NWahBagiLcbSP8GYHst2o/x80ob/AVCIi5X2jo3mXNdYTPNm3WRBVgBUQgnEObjqTT2m0MoSeJz/FTt5g8ERjXw16sfcCAX3es9u8ZBfaKvqJRZsxdGh7cddDZp1vCe+ntNHHW3NW1MiiSWaJiFqEJ7xM3j1S9WkWLfGk0ogsl3v5882i5CCbEHSptwy0lpV7//7koT/1xJ1bIZl5s8lGLJAX1GOK30PPo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7958.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTBQYkpldHRBczI1eHY3Tkl6NlE1YXFQUndIL0o1Vy9lTlJGcEplT2x0Z3E5?=
 =?utf-8?B?a0xTWGZ5d01oVDJZdmVBTzZ4K0VVUmR1WSttWnUzS0J4QTY4R0t6ZTBVN3la?=
 =?utf-8?B?d3UyRC9rOHdEbGk1cWtNM2k4UXlQK1pZbkxDWFFpVlFZSFZlMDVMZHpjMy81?=
 =?utf-8?B?SlMrNXQ0T1lHcExjZ2Q4TEdzZnNBb3JyakI2ajhuNElVeGJ6U1Bwa3dUdHVJ?=
 =?utf-8?B?d0FOTkJnOFRkUDlTUi9xNGQ4ZGFQdmREUFRRbmNLNzhrZE0wY2lpMUZZRndB?=
 =?utf-8?B?Mmg3Uk53NkJUb2Y1emZra0N2dEdGd0UydDJLVHMxQTlBbHc1THErdlM5Z2U2?=
 =?utf-8?B?NXVQQ1RQRFhpVDVSWitOODNwYUw1OEd2UkI2VGcrNXFoMlMvZ0Z0a2h4cTFw?=
 =?utf-8?B?bHdCeFBHcnVQTXpWRjllME9McUFFTUlLM2dhbG9zRDRUcWNESXRCWTdKdU9U?=
 =?utf-8?B?WEVwRVlYRktxcWtLZlhWa2xjZDFrN0dRb05vMGZJY09BN0JYeTUrUlhSVG14?=
 =?utf-8?B?WEZweGdmT2NWaWY4SmZXV05kaFo3MllKYlg1UVB0QjBCMExBYUVPc2NCWS9D?=
 =?utf-8?B?ZnVEZ04waERRcXpyVDJzdENSMElvdzBvNk54d1NFN1pVaVN4SWxSeWN2WVlF?=
 =?utf-8?B?N2M0QnV4dzhVSktFbldlMVVsV1VsMEI2ZEVmZ3ByMGJoSUpVWFlkR2Z5eDQ2?=
 =?utf-8?B?RkE5eTZoc0pJenc4bUlzUWt4Um9sVCtyZ09nd2xjdWhIZHZnYmQyRkxCYWJJ?=
 =?utf-8?B?M2YzclFJUUNscXlqM3ZydHMwMzBCS25uYXA0a3cwQ25sNUUzNTlPZ3R1TnJ2?=
 =?utf-8?B?NUZtTXNQaG5PSytjdUJGTDY0RzJIcURmbTBmSUxGZWRGemo2QXhjVjJqT1JW?=
 =?utf-8?B?RW15WmlEdE1MZjlwVk9VbnNiWTZiZ0RQQXFGZE9wRDVNa3k2amUxR2tKVDZM?=
 =?utf-8?B?SkhsejZhK1JrTVg4VDdtRjVkLzhidUxCd3RqRlRHOW9ybmZpYXhYUVJvODVU?=
 =?utf-8?B?a20yM1ZxU0RYZXR0MVVXZkF6UUg0RHhBTjJGbENsWTJBTE9HYlpraTc2K2kr?=
 =?utf-8?B?U1BvK2V3TklaRmZnbDhuWFJHYVdINHR3b2Jmdkw1NnF4QUR3dTY1ejBsam96?=
 =?utf-8?B?YVZpRUZCZkZkd1lKSWJBS2N4RW5FdnUyWW5RSnkwZG1aU3JSQmxHdkhMWUpt?=
 =?utf-8?B?MjZYMTdxKzFscUtSaTdpSEtBUHFpQW1uU3lSbHE2YThENVg0STNmT3JOVU5W?=
 =?utf-8?B?QnRKWGJ0bWJqRXpwUmJETGtSOGJUVGpUamphNzJCUUdrRzd2ZmNwdlpUWHRB?=
 =?utf-8?B?bklnRGFkcTR3cmJ1Nzg4RTMybFByWTBLVnJ3cDU0WEhzMllnTlNkSlMvNDV2?=
 =?utf-8?B?SjR2blNLcmc0ZytoblFiYWFkWFdnODlveFRiQ2xqY2N2ZFZsZUtCb1hySGFU?=
 =?utf-8?B?ZVV3QmZoZ0ZyRG1rakg4UG5MY2g5L0NGL3RuRlRLRFBXbDlzNVluSThKdlha?=
 =?utf-8?B?SWVLYXpQbUozYm50TzhvZ0V6YXd4amtvTk4xMDBXYVRpbUI3enhIT2ExUlU4?=
 =?utf-8?B?andFMldTVEw3TkdmSXdHTm53aXNaSFdqTXArMzZ2TDdvS1M2QURtTDcrdGlw?=
 =?utf-8?B?MHU5dk1xVlVLKzdOT0ZEcmpNS0hUL2FZQ0l6U2xPL0VVYzFoUEpYTU92MTN5?=
 =?utf-8?B?dC92N2d2c2drbjF1K2ZKYkVLSTNoRCtpc3ExOGljdHozSTNTdTk0RlRHb3JF?=
 =?utf-8?B?TkRNMHo5UlEyQlArTVpjaGxUVFRUQ2trWnl6UGEvVXhmS3RXRWlrWlBoMUJP?=
 =?utf-8?B?c2U3azZrYWJNUndvMVY4SkdEQmN6MVF1S2ZHNWtlMnVCa1NmbmFRQ0p6QzhX?=
 =?utf-8?B?YjEvaFZwUU5lYTJScHNwaTkySWdxVzVSMTlDN2tlR0I2UEdsSkhZYlFUYVgy?=
 =?utf-8?B?UWw5NDJ1aDlNQ3o3VVZhUk1oS0NaQmV2VGE1TVZSVm9BeHpVY3JPTGlxYTRl?=
 =?utf-8?B?QTlsZUpkR3RCOExiNFpzK1EzWmJ0WkVQeHNENnRlaENvMmlNem1USmlPaXd3?=
 =?utf-8?B?MnZHMEhaZ1M5ZGlNSS9BUW5BancwT1UyNUxaWDRmYjBkQjhCcCt1YmxTc2ZR?=
 =?utf-8?B?a1RjSlNVWnlielE2NHp1VXNZVFl3cjNUa2xhMFBGaWZFNUQ0RnRDNzI2WHYy?=
 =?utf-8?B?Z2FjbXMrWWxQVm1GZHBhb2NIS0RLWWZIdHZUUmcvSFMrc3NXRitiNmFIMjVN?=
 =?utf-8?B?MFhWNjFSaHFPUWJUd3FBWC9KRUlIKzRCaWJ1VS9keU94Q3QvM2llaEtwWG5o?=
 =?utf-8?B?N0xXZWMvQnZ4QzBHVVdjTnBPS0xsN2QySWU2TzR2NEs1TkJsNzZlZz09?=
X-Exchange-RoutingPolicyChecked: ludUkaUJQ2vfmm4N1JPb5XLFi+ZIrClOEcLJQDsM12JaGJdqOFKhPVWwUblqhcerr7CcC1ssx9jbVZUBK7hcmpIx2VDPljGYyeJjODkB03p0IJ9ZjVjbvw8Nx3UKUohDDh8d38Mvv3UH4EX3/zK8DskBBYy4JhctvYmeGZ9w7YFnBdM2LBSL4JszkzsFGQ3wy7Te6a0abD6eILREpwLZL2EdBfkAwWf3sJJsJIN4HwUZ9PQvSd4YZXS3XEkTyuiJoBOxl6bH1p/8SeM9Kag9leyIVa/5fqWncowIqLQt8DvmpgplTNwsy48nSaW5ds/IGwW/zWKgDZfAuX1aaJvyFQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: bdad415d-b414-411c-3c4f-08dee8cbc507
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 15:05:01.6256 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gKW3CHaePh0r1NQTu5WHOZG2QQpLr64F+5Hk5L1ixfuUHrEOqQc1fCuGR8VZwJF0hKXjlAim+Ew2TYGVvB3SIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9057
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


On 22-07-2026 20:54, Raag Jadav wrote:
> On Wed, Jul 22, 2026 at 03:11:37PM +0530, Riana Tauro wrote:
>> When an interrupt is received for correctable errors indicating that error
>> counter has crossed its threshold, read the current counter value and
>> deliver a drm-ras error-event to userspace for each affected component.
>>
>> Also send drm-ras error-event to userspace for uncorrectable errors on
>> receiving an AER.
>>
>> To avoid sending duplicate events when the same component appears multiple
>> times in the response, Send the error-event once per component.
> ...
>
>> @@ -425,6 +487,12 @@ enum xe_ras_recovery_action xe_ras_process_errors(struct xe_device *xe)
>>   			xe_info(xe, "[RAS]: %s %s detected\n", comp_to_str(component),
>>   				sev_to_str(severity));
> Similar to threshold crossed case, we should probably have a BUILD_BUG_ON()
> against XE_RAS_NUM_ERROR_ARR.

This is already added part of correctable. Seems unnecessary to add it twice

>
> Reviewed-by: Raag Jadav <raag.jadav@intel.com>

Thank you for the review.

>
>> +			/* Send event once per component */
>> +			if (!(sent & BIT(component))) {
>> +				sent |= BIT(component);
>> +				ras_send_error_event(xe, severity, component);
>> +			}
>> +
>>   			switch (component) {
>>   			case XE_RAS_COMP_CORE_COMPUTE:
>>   				action = handle_core_compute_errors(arr);
>> -- 
>> 2.47.1
>>
