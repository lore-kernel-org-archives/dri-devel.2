Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C29C606C937
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 21:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E6cPBybF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D74E910E208;
	Wed,  4 Nov 2026 21:01:49 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3FD410E208;
 Wed,  4 Nov 2026 21:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793826104; x=1825362104;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=UchDe5bGdoz8ijfA3QTMDuqngo9H6tU+maCFVpbGuhM=;
 b=E6cPBybFNqVZ/6GHVBGFiOqI2UpNW2DXZbd1vKtj/o+dHNHLGsCNVN6Q
 cLWEQFyrJrUgUOOOFWtPYKpJQShjj+v1a6XypNhUeCFubO6CMu2sXXoqo
 M9FTc+CyiG5bUPXyJkKzcYow5jtJIMqyY89xzz1Tx4JOiPYrCyL5D8mA7
 MUSfruh6pJHBTMa/0qP6s2vhrHCfkmXSQld5AMcXu31VgeX+9H/SOSiid
 GkSNj0cyvSCY/8quV7MG6iRLRQl4EyDQ2DasFB1+xR8BouOegQk5h0Zxt
 W74RDbGwiXuVo5bHR4u2YFbW61CLFOgnvThmbZOfOmsXzQghpkqIpW51c Q==;
X-CSE-ConnectionGUID: 31iRs4dMQ1WxI5p9BoZG2A==
X-CSE-MsgGUID: vivZ3GXgRJC1ijoMQmF6Bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2471031"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2471031"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 13:01:37 -0800
X-CSE-ConnectionGUID: l1lC6lmKSbOgIemkO+YwfA==
X-CSE-MsgGUID: bom1Qlu2TkS0yrIU8HM3nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6679050"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 13:01:37 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 13:01:36 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 13:01:36 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.67) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 13:01:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=firNpFlvPOgtRoU1GGJUjfqu2m8CnZYJbzVvE2KdKRISdox4jso7LW1jKPzVUiXOrEatjtoVNAeqJ3KC3fB1zca7BBMT4kwHvwUdjwCIIkdhXgCiz4NdpJovn683CMyHtIbqVIdOwOQNG/5soG2/iQ7sYmF1jT2VkPh3QCvFCgBm+vuThrkxc/Z6FZVFn7FQufFqxxk1XJqbxpDNwDHSZSUKV6jxwZvHQOd4N6T3kUeCZQhpQE9IexlvXdMOJgo1l9dl9qCftgD3QXGSlAGey+O9UCyBV/TD7P9HWlQUIbyIymNLxR/y7s55sNsqRfBDeeduLJUOlDEPLS9XUOXdgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bF8cLinm9I7bfG+3gD+hDdPVZ0Y+miRw7xm/lsWqs40=;
 b=Ir5b1jjH1Dg5QRfJYCVxAwqixXDGXdXMGHIXYej4/8QB3vdQI1SvUD6h/td6sd6itnFIIMmvAKrILZ3NMByE1eQMIHUn6R3XOxZ2XOs/ebEhOv4na6JsNAKlcec5FnRWCNGvukNwkeTRuh17nJZ8SybqIdwLJJ9lHi2Xw+F6lDaELYNos86x4Bs0m25CHGdyKpfFL1pkuTF0uOF7iSY1pGy19A5dPXtWEg/dTLiZbJo9ufJv2g83RRzQxg4ieGvYeS5ZJ5eCqL7mu3Y3beZbCMz5w4S3Ph+qZr4e85CWt+X7yrgMvLxYu0qtUSXajJBR8degVq3LtFd3bhfc6czqDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8019.namprd11.prod.outlook.com (2603:10b6:8:12e::18)
 by MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 21:01:33 +0000
Received: from DS0PR11MB8019.namprd11.prod.outlook.com
 ([fe80::fce1:3bde:b383:e801]) by DS0PR11MB8019.namprd11.prod.outlook.com
 ([fe80::fce1:3bde:b383:e801%6]) with mapi id 15.21.0569.011; Wed, 4 Nov 2026
 21:01:33 +0000
Date: Wed, 4 Nov 2026 22:01:26 +0100
From: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>
CC: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 "Jani Nikula" <jani.nikula@linux.intel.com>, Andi Shyti
 <andi.shyti@linux.intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v6 1/6] drm/i915/selftests: Use gt_*/drm_* prints in core
 selftests
Message-ID: <auuTKdclVIl1enWT@kniemiec-mobl1>
References: <20261104111104.946617-1-krzysztof.karas@intel.com>
 <20261104111104.946617-2-krzysztof.karas@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20261104111104.946617-2-krzysztof.karas@intel.com>
X-ClientProxiedBy: DUZP191CA0066.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::9) To DS0PR11MB8019.namprd11.prod.outlook.com
 (2603:10b6:8:12e::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8019:EE_|MW3PR11MB4684:EE_
X-MS-Office365-Filtering-Correlation-Id: 61060160-4a60-4b56-b24d-08df3ab6ce53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|22082099003|18002099003|56012099006|261021135927099003|11063799006|4143699003|261022075727099003|261022105027099003|261026140227099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: +si9pBJGMr3LAqLp+yJz1WyyRz2BiH1tNCJ/ArLnNl2kuPcbPqTrF28nPQmywQ/UTWcyblZFoZLv4/fe7TgKd4n9uWWp7uo1QitR73CsYnfBU2k/9O/rhB04jBW9bvjgADm7hq1oozyFRpatn54PlIVZ97sbZ/o6UwHecXUjY9kpLPK5QEOHOd4AdAO1WKYbYjB+d7MByvKFsv2T9+4qUmD+6A8fnCvyJQlAwWeGFY1BC3D/pZQEx3Ke6REM/74tfc81jsEWIb98mVh5+zRAOrnARPgbnljjyXu0B0eLCFx9kOeAHZ9o9EblQ6ZxzUCUB/wnUea7xgeO6lf09YY6R33QwAeVZZOjTlITtBWNWnqHhBtMYeXni6ceKTjGY4/xDGO3DT8jnu83Oe8mjlrYHIjRLukIDv5oxHfnxGYvdKnuZdivjpu77puW79KYqiaal9ggjcG6GJdWhWdOGn4L9qMb2PODdsfhh3AHYOjYW+PYcMl0U+v5WH4ozfdLMLKiP5DvDK1rp1ZiUgI0k/qAByQTHkyidH5uaDmEMlBMlNhFBjLLLKRY+VXZS//lzFlIx/3SP1vjdqAy6NaXyH9eB8Dg4m0r1/KyQREwi4kFLrCGtZr0nC5IIE2DmtZnGbKV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8019.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(22082099003)(18002099003)(56012099006)(261021135927099003)(11063799006)(4143699003)(261022075727099003)(261022105027099003)(261026140227099003)(261009223027099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVNmQkFya2pxZStBbGlSM1VHT0FGbERkRzFpK1dTc3U1QldWaHJzVm8wdW9H?=
 =?utf-8?B?OU9xbmlQWjdHbXZjUXZDQXc5QldvUUo0bTRTWVNvcVEvREIyVlFDOEdiS1FL?=
 =?utf-8?B?YzlDeStuVU85aWo5dUxDMG5xVm1JeFJKYVp4aitTOW9NQjBFbVJaanVrU0hv?=
 =?utf-8?B?Q2xZR3RRWlhYZWdLMFBGZk5sSzZUTHN4WFIxR0srenFSSkNtS2M4MmFjYURN?=
 =?utf-8?B?OWJCN0dRREsyTjRWczBQODdkeEY4ZVBETytCL2VsYkNLZDBKV3RZTlMwa1FE?=
 =?utf-8?B?aG5kY2ZKd1JRd2IzNjZyb1RGTHEvWmUyTFlaWk0rNDEyQk1sQ01uUU9qOWJp?=
 =?utf-8?B?M0dvWFVLY1l0U0pTUGF4bWJGRHNSTDY4RDBjRFVoZzVueVBPN3puMGltS2RE?=
 =?utf-8?B?cTdvVGZMekVIdTdYRkdBSzcxT1Y0LzFUNGZ4eWhYcUNjeW5Ea1Y5LzZKTStk?=
 =?utf-8?B?SVRiWm9BMDFCUUxSYTBrYUVRb2RiMi9WOUFaQ2VsUTMyWEpJRXRlT0VvY1Zw?=
 =?utf-8?B?dGFMSXZxd2ZXTGhscGpHZ09EcStCeTVFT1ZHYWcxejFDK095M3hpY2RFanJr?=
 =?utf-8?B?Q01qYzRQV3p3R2ZvT0w0WkZsZUxvYlliYUdramZEZ1dPOGwwc08zRGwya1U5?=
 =?utf-8?B?eXVFZ3BDd2dCbUZSQjBoU09uNFlXU3NOY095S08zeGRpVUE2M3NTSjBSQXBm?=
 =?utf-8?B?SWtKZGY5d2xiT2hISnRXeTZRcEFlVEx0ZlRsdlJDZWw4RmNCb0RpenhTUmx6?=
 =?utf-8?B?Mkl1UUVTM0kydEJsb3pHV3lvaDN0RDkzSC9iUnUxR1FTc0tCY2N3QzVzWXV2?=
 =?utf-8?B?aDVRUjN1ZFA2eW9KelV3OURRWjVlQmxKeDRhWjIwUlY0ZjNDUEl0cUF5QTBR?=
 =?utf-8?B?M2tIVnhBZmlocWxWY2JyNjdXUTFqamdpQ1ErRTQvNG4vZmVaSSt3TWxwcFRT?=
 =?utf-8?B?MzlmUXZiVk91ZGhVZ2hhZVdDRWlzcGZVSmdHWVpUZDZLTm0zUlNvL0dxQzZq?=
 =?utf-8?B?T1lDUUEwU0VXSHZ5V1kwTUNmbloyRUNESW9Gc3JvSWk0bEV6YTJtVUViMjRV?=
 =?utf-8?B?V1Ayd2pxWjhjNExRazEyc1ljTmVuZEpWWmE1YVBhdHF6MCs2ZVY0ZFUyRjNF?=
 =?utf-8?B?eDhBRTZtZHBZdDdYMUpkVlVzN1ZIbWJrWitiOFRSNkNDS2ttUUZOUXVtWUtB?=
 =?utf-8?B?UjVsRXcwai9zeEp2STcxZDZXSi95OTJyRVEweHh1WVhtMXZUcVhDT0Y0NW9Y?=
 =?utf-8?B?MU5wK0ZPbE1WZmhLNkw0SVVXcmNHQldtYzJ5THFENUo0V0RPaWpqUUxvWUth?=
 =?utf-8?B?aGVHZ0FTNmV4bmxDaldROUVZQ2IvL09NU01iTW1HNitZQWc3a0c4MHVialUz?=
 =?utf-8?B?VWMvY3BEVUo4Smg0bnFXNDBFM0FkNjlrZUJES2pOdUVOL1JGMksyOXAzRjE0?=
 =?utf-8?B?TkJwWDh3WHlHVnJLVU1xZ05TMS9KSTNOVnJSbDM0RnlqR1pKTW1CK0dteTNi?=
 =?utf-8?B?VndCb2tYQTc2ZDNpVTBwMkFPSnFuRmJNaVc2aTFZRmhTWm90dGhYaGR4eW9W?=
 =?utf-8?B?U0R0dkhiR2tnM004THF6ZVNzcGxGV1cvaTV1cFc5VmlHTng2RDRUYWdkTEUz?=
 =?utf-8?B?Q1NxeTBKUXFmUlNSdGJhRTh4WXl0bFJ5Ykh6Y3VNOUg3MXluWFpGTWRQb09w?=
 =?utf-8?B?dnRCSXdVZkRKNWw3WDRmKzJmSyt1M1FqMmNmdFpaSnFEVCtOOUVGL3YzU0Er?=
 =?utf-8?B?R09Ba0NMN2hSc2x6eDliQTIyY3U1OG1jOTM5L2xURXd4V1ZpOGp3c1J4SXNF?=
 =?utf-8?B?VmlHZmJmY25ZOFdpb1QvN1ZHRDBUVUl6R0p1Y0puYnlWZ01lQm5Bc0RMZ2lq?=
 =?utf-8?B?N2kvQnVjd0NEMEd0VDJTdnB0dzFlOE4yTW1Ob3pWTm9kNWFPY1BocW43bGpF?=
 =?utf-8?B?OXJTZXNqQzYxQW8rSzBaaWZKanZvZjRmS3lVNlp6QkFEOGJJZVJJOTYvTlht?=
 =?utf-8?B?VmhzNTd0cHhrWW8yaHJsVEJFQlQ2TGdueUZsRVVVRGlxcHRWTnRrOHFkaFhT?=
 =?utf-8?B?VFY2aEt0QThDNExaOUVPOU56ZW1tU0QwRmwxZW1ISVRCZzFDVG0xbTV4OFlo?=
 =?utf-8?B?YzE4bnM0ekdJUStaaHZ4VnA3YTlJNlo5NUw4cGtYRkV6ZmJUWUZ1dDdOaGJp?=
 =?utf-8?B?RWRJRHRuYmFzaUNTbEJKSnd5Z1RCdkhNenFRbDZiSE5JZmRCNTNJS0lyaUor?=
 =?utf-8?B?SDYxSWpnaHNWT3JNUFNjdEY4bjJYempCc0Ivamc0Rjl3eDlaR0tPYUtVR1JF?=
 =?utf-8?B?V0o4Wi8ya3d1dXVGUDloNk9pL2ltZVcxRFNnR3ZzNVZJZXRMOVl2dXZkeVdx?=
 =?utf-8?Q?denhBsGsxgYTKWJM=3D?=
X-Exchange-RoutingPolicyChecked: N7aODbs4YvKSL0qWITuyjbuFe9+6MC6ASmdGMYZmOwcePB+hUejLJhRouUvr2ZSXEYm3mbWvAQF0pG8Nfrol183mXR1MxQRHY7CdGmPaPWtsxDckGDyNLeqDjy2P5Nb68CeTSL0aZJA5Lwohvg2B5EDVd7GDQijHO4WS2h9gtkmA4doYK65JkpQPIXa8hrz+DFtHs8klFEB0noPx4x5Drrs4LcgZ4rFGtdHpfJdNL+ePBHnVS/j5ljsspwLwbweUAJNOx/SgVqM7HIPuE7A5oGWVkeaBy4ShT2Ys5d24uQ3Qruv5p7QLaM5oQqKbbFIFQ0XN+NqHYiGvxV2UZWWXxA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 61060160-4a60-4b56-b24d-08df3ab6ce53
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 21:01:33.1879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JWU8qTpOhb4gWDMUjVFldkEi6VqWxEjADf8pVqWThBOu2D66r7sdzgym5J9dtzm1tga1VFQRHGoIvvC4cadAZ0pXbwB7OWowUbFW7kTTGsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4684
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

Hi Krzysztof,

On 2026-11-04 at 11:10:59 +0000, Krzysztof Karas wrote:
> Move away from generic pr prints to GT aware gt_* versions,
> which tag each message with device and the tile it came from.
> 
> i915_perf.c now uses drm_* prints, as it reports on a device
> wide perf stream with no GT to attribute the message to.
> 
> Ensure that 80 character line limit is respected wherever
> possible.
> 
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> ---

LGTM with one note:

<snip to relevant file>

> diff --git a/drivers/gpu/drm/i915/selftests/i915_vma.c b/drivers/gpu/drm/i915/selftests/i915_vma.c
> index fc068dab27f4..aa2527314ab0 100644
> --- a/drivers/gpu/drm/i915/selftests/i915_vma.c
> +++ b/drivers/gpu/drm/i915/selftests/i915_vma.c
> @@ -28,6 +28,8 @@
>  #include "gem/i915_gem_internal.h"
>  #include "gem/selftests/mock_context.h"

<snip to relevant function>

>  			goto out_object;
>  		}
> @@ -1080,7 +1143,8 @@ static int igt_vma_remapped_gtt(void *arg)
>  
>  					val = ioread32(&map[offset / sizeof(*map)]);
>  					if (val != exp) {
> -						pr_err("%s VMA write test failed, expected 0x%x, found 0x%x\n",
> +						gt_err(to_gt(i915),

Note, not nit, but I think it's worth saying: technically this might run
on multi-gt platforms (so non-mock) where to_gt() might not be always
correct; however in this case the VMA comes from
i915_gem_object_ggtt_pin() which uses hardcoded to_gt()->ggtt anyway [1], so
this is functionally correct.

Again, not a blocker, you just can't assume mock device here so I'm
explicitly stating the due dilligence check for this.

[1] https://elixir.bootlin.com/linux/v7.3.1/source/drivers/gpu/drm/i915/i915_gem.c#L909

All in all:

Reviewed-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>

Thanks
Krzysztof
