Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077C1606A31F
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 14:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LAn+Pjhq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F2FC10FCCA;
	Wed, 28 Oct 2026 14:02:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3365F10E101;
 Wed, 28 Oct 2026 14:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793196129; x=1824732129;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=usfeySVEYy8nc1SPBma0C8CTIptfuNu7Z+/2+pYwmAA=;
 b=LAn+Pjhqpy7JprowDMoI42jHG0gndfJFoFWCsySistVcnN2WQ95kbT6Z
 ryP15g7Gqq81m1BXcpLYmKhjXALtRlaweN5yVIpfT4y5WkTQ/gs+XiwT8
 +HIDbN2UjYBj1uIiypU8or7Hy5Cqd6NhmjLEzQICNYtCVm3A+lTYwtZpz
 qKe+R+YuDsWDEfCfcEDhrhgZc2KuHlKygRUXj1NiSD1qWcPO0EbyeHoSJ
 DzkVQPaHUPk3wEQC59LndBPwZU8GbMMKu6k9Vl4wzojqgQXY/qs7qUF3J
 LwTZX78Bmj7Y6JnPyz+NdLp7kl/ChKoc2upOEyGrqkHnoyk0RtNp8Fgjp A==;
X-CSE-ConnectionGUID: cf9EcRAxQC6GHwu/cTtA9Q==
X-CSE-MsgGUID: /AlOdSI4TlyCXLmP48w5CQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1907481"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1907481"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 07:01:55 -0700
X-CSE-ConnectionGUID: BjccmJMyTAetusKv/G7LCQ==
X-CSE-MsgGUID: vdAOXRSGSmKcRXLrDMAauQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="6620899"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 07:01:54 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 07:01:54 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 28 Oct 2026 07:01:54 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.4) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 28 Oct 2026 07:01:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3y6lrlwQFdER9ixlxgD10EFh5JerSEIMjeYpxm97BIib4+D61PFVhNkmpMnbO+eiuaKUkec/qbC1J16OiC0iWYhCRwLbfYiY2nCXA97RZEAr6XBWTHmD51X3S1cK1PMR1rPIRpnWS04mbUQtVeRuAB38DR3MWUTuW11WGN7y/4uzIgYb5f9u+qQirI6I0+46XP8FtDgmfBlzSLF6kmKxzOTVoE3lKmfFQxejkj1E1sAhP7ZOBK+peztl3aM8G/k6OvTVcdtEAUr9pxAaLEOxPPlt8sUVoo2C9/LJ0UNQ7MhdJnMmpdm3xW/DvAnZGHRBXcfw2xLf33lT2yD+jrZMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=av9bCDmCDJl1xX9uWD2JFhyhhjnIhf5mUdRuc11iY5Y=;
 b=h82RNMsRPia7tQ9X6T2TMJC+/FPbNMHsZYF3x6QbTdZPmmxOjElnSdRji1jxJ+DoXQEct1cEMtiAD154U6w3Ctr7JE+yf+E+3XAi2ef40QXou05/A6lS+p+OkJVTRc4SSS3XXhy7U/bxqwku52ID81wrXHWWzEd8JXqgdWyyW1oV9zO8onGyyYh0sDq4jShJXTwAIZvBDRtpPcZwq/sni0vGVNm5s82lO+/2aBDtCrqBbR8rEAR2lG2CfH+zAfmHwOz92Qlycf5PltIbxLfSwhqNx7gA1UWA7pqtKAH3KDggqHHH2hNUbix9hMlfnupOSM1YdqMi2AgJwG32vT77uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8208.namprd11.prod.outlook.com (2603:10b6:8:165::18)
 by DS4PPFAC42FDD50.namprd11.prod.outlook.com (2603:10b6:f:fc02::46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 14:01:52 +0000
Received: from DS0PR11MB8208.namprd11.prod.outlook.com
 ([fe80::ecb0:7475:84de:ca9c]) by DS0PR11MB8208.namprd11.prod.outlook.com
 ([fe80::ecb0:7475:84de:ca9c%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 14:01:52 +0000
Message-ID: <88084c20-7981-4d44-94db-fbee2c355f50@intel.com>
Date: Wed, 28 Oct 2026 19:31:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] drm/xe: Defer VM teardown until exec queue cleanup
 completes
To: Arvind Yadav <arvind.yadav@intel.com>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
CC: <rodrigo.vivi@intel.com>, <matthew.brost@intel.com>,
 <himal.prasad.ghimiray@intel.com>, <thomas.hellstrom@linux.intel.com>
References: <20261028122125.3772832-1-arvind.yadav@intel.com>
 <20261028122125.3772832-5-arvind.yadav@intel.com>
Content-Language: en-US
From: "Yadav, Sanjay Kumar" <sanjay.kumar.yadav@intel.com>
In-Reply-To: <20261028122125.3772832-5-arvind.yadav@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0152.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ac::16) To DS0PR11MB8208.namprd11.prod.outlook.com
 (2603:10b6:8:165::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8208:EE_|DS4PPFAC42FDD50:EE_
X-MS-Office365-Filtering-Correlation-Id: de6f88cd-a7d7-4bb5-0ddb-08df34fc049c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|11063799006|4143699003|56012099006|261009223027099003|261022105027099003|261026121527099003|261026140227099003|261021121427099003|261021123027099003|261022075727099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: C9GK+px7l+HZBakUFurnr8MNQGWCPM6LK9OerwZa72phjIi/RPYRieVdG9E0I7EHIcrbaTVYb9b70hHz+vC3Z00OeWRWoaVuMyH0QfYd3ybcgASraQ9WP6LBclTRHgoeiqLAAMNteWmoCvBo6YtBOkiC+0S03Qqmy4Mg0jvVj1C25CX8Ee/IQwrN/x2goPMbIFjeevL9lNju4uLRmBq8TJuVD3O3khsJ4qAmvNi2C4rbCHOwVnvlYNu1gVStZJiWwG41WTfd4YZJLjQSEebtCH6SIxW642Bnt1w1QrFCD9oPWaJWff3ZXnvtCK4l9kgRpoIHQ2eDZaZPJO7Zs7AfytfKHzMEv1pbwKgVpx17JYSwFnUsM0Xa9V26DBxWTSmOl6S3z6mSdIavLsvE3rrtK8NAV51SGV//YETf0B9YQkzrcVyy5i6WrnoMhPf9b3waAvVO6EC2V38ZZjRDIuNpYdNASWPijWxPq4eHtLjTJ+QZHcacl6XJtjhjC4KefQmp/+riif7HMFvsZBIBFsEtkRELAR3xCxidm8xmHSQaJ0yKD0kV8wn9/rAigkcV0MQ3XXpIqNz3YLLfEvkCSJlqq11cFgh6P9T2XEepcZzBDqyvFXLEy2cVMGEmiZZNY0eX+e6MxwMz8XeXs1w5SPfBr5gGgX9YatoopoiklNTqPgg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8208.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(11063799006)(4143699003)(56012099006)(261009223027099003)(261022105027099003)(261026121527099003)(261026140227099003)(261021121427099003)(261021123027099003)(261022075727099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajlSbG1jWEowSjRoays5RHdyQkl6S3d4WFljdGhXUWVvblBidC90VFhCRzRl?=
 =?utf-8?B?elRBZnVCU1Y3ZFZzanpvSkRkTzhzRFA4cmozR0dsdDhoS0NWOVRLZzlXY3BY?=
 =?utf-8?B?eGErcmU4dUliRWJsZUVlWC9wY3lkV0JXbkRDdWZYM09SQU1HZkdSdEE0bTRi?=
 =?utf-8?B?cDlZajNlSEwzUUxURzVhL3h3a1EzQ0NGbHVRbm0zYjZycG0rTUVyRElxaDRw?=
 =?utf-8?B?YWtyWHFYQU9sOEl6UUhLc281aDJIWk5YaUk2UjFNZFlEcFZudGI1bFRmUUFv?=
 =?utf-8?B?cFBYYUNKenpncStQNWdzZDlnSUhuMkUyZlFsa3RFUEpQKzFVRitMNzZFaGxW?=
 =?utf-8?B?U2Q3M2dGR0tadTVtTVRvZlcweTdBcE5STmswcWxISWx2UGQ5YndOYXhNWExz?=
 =?utf-8?B?RUFwL0o0amtPdVQ2aWlya0t3Y1hEN1NMejYzUS9vdFZjMi9ja2hGY1NmTjRO?=
 =?utf-8?B?c25TeXorM3kvNDNGZ2c1WnVXQUJFdGtHMWkvS1pibzZqdW9neVNkb2x0cUU1?=
 =?utf-8?B?OUdTbzVKOUdMaW9JeldKVGlZbVFLWm1JRDJILzk3d0Q1d3NjODFQa1QzNWhT?=
 =?utf-8?B?RHBsTVZZTEFGY29PT1c2aFAzM0hOSVBPQllhcStnT3hQc0tpWWFiZzhDYTRy?=
 =?utf-8?B?dGo0ODBhVnUwZ2RpSW9LakNtUzV0eXhMTEJJbm5sbTVSeGVDL0FCRUJEQ0Yw?=
 =?utf-8?B?R2ZwOXFFT3htKzI4VVpBaWhGcE5DWmF3UGhua1JJenFaalZyN2pwTmNOS2VC?=
 =?utf-8?B?QVdyVVhVWnFKTitqUEJNaXBlRXpmZm9TcW04c3RtRXNoTWxWQno3RU9uZ2xK?=
 =?utf-8?B?enllOWpjcDhGeDNxczRDanhmRzYzN243S3ptaFd4M25vMXJFZW1ieVMzQk9k?=
 =?utf-8?B?bzQ5RU9QTmtxaUZ6SnlzdzNnV1IzTUxjMWVWTzNXVzRUaXRpWGRkbDd1b0JI?=
 =?utf-8?B?RlZNSzAzYW1udzh4cTJhOWNJa0pUQ052TnA0SFJSVTRUSURzZi85YnJySEo5?=
 =?utf-8?B?enFUb1dxYWdEak9rckZHeHJ4cGpNUVpCeVYzQ2FDVjUvOTRKc0NjeW5qejdH?=
 =?utf-8?B?ZjNVZzFyVE5iMTg2c1BDQU1lUUJNRUx1dEFpbmxtNXZFRXZZaW5sMnZlMy9W?=
 =?utf-8?B?WVIyUlVWYVhSQ3cvREpQT1l1MmZBeTdaQ3B6a2UyNC9oTEtBU0hrNzBGRDkr?=
 =?utf-8?B?Ym1CaGUwVjhzQWpna2xkMlcwM3BXNVlGTllhZXZrdmVpYWY2UHhoQ0MyaWtC?=
 =?utf-8?B?bHE1UHJ0aDFqM3ppV1FIK3lBSDRVdXIxVkZnTHhRSC9VaTgwNTN1RWZySXZa?=
 =?utf-8?B?cU1UNlNtTGNRQ2dZbTh4OTY4eTdZeVQvanZhY29OM1VBOG9Bc1VTZmpNSVJ3?=
 =?utf-8?B?dVgwVzZhL2IyVTdoQU5kNW9sNk9Ic05sRmZvNW5SU0xLK3RHR3d0bjJzK2pH?=
 =?utf-8?B?ZjMyK3NCL0orVlhNdWZsbHdpSSt6c2hhZW9CaC91bFRYRDVlWGQvL2d2NHYw?=
 =?utf-8?B?MkhuVGpCdHNZOVBDYXFlcVh0VFgvTW1tTzlQZDlKZGZjY0NxdGxhVlArMVcv?=
 =?utf-8?B?UW1NZEQ5N25oY29ITDZJY0NwU3hRV2xFZ2dLUEtueElLalRPUUgrL3VNRldr?=
 =?utf-8?B?am5VeGh3R21CTUtUL2wvdUJMZkp4L0l6TzgrMVNxSDFyK1I5RGpnbnprRy96?=
 =?utf-8?B?aGJvSFBJSVlaZXlHQTNUeWRodjVaL2gwanQyUTdYOEhkR0k3N3hGaGZYSzJL?=
 =?utf-8?B?b3U0TTBqSHZVZjgvUjl5TGVnMVhZZld4V2NjYndRc1VRTmMvUUUyYVAwWHBH?=
 =?utf-8?B?dVJDM3grN2JVWEdhZTJuT2RqRlJpc0lRT3VjV2phMVIyRnBuemlrYW13alAx?=
 =?utf-8?B?cFZZZ1NiU1I1T3AxakQ3U0ZkL1ZoVXhveGRieDNWVElJQzZWY3FCSTJ6RDQ2?=
 =?utf-8?B?MXl1RGh4bFhxNGQ3UGRQMENRUXJaUjJrMEpGUzE1U29LZVVvd2plYU14YWl1?=
 =?utf-8?B?aDlLRUZWUGZzbjYxd0FaRGtMYThHZkc2Z0NXdWhpSVJ3VWNrS2ZGQ0lzcnI1?=
 =?utf-8?B?cmd2QXlpTE5POTBHcmwxcm1SNzg1UkIyeW5ULzd5Vkpjd3VqTnhVZ3NxVytv?=
 =?utf-8?B?emZLNVV5ZEErQk9BWDB4anFSbUhxQUkvc09TMDNaUjhmR2hHR2RTK3BMalUy?=
 =?utf-8?B?UXd1NEtYYXQxYkM4REpTMldjMTBzdXBBbVhnTDhhWXc3TjE3WnAwd1M2QVBr?=
 =?utf-8?B?UllKMnVZbGgwclJ1NzFVR21aN1BOK1pGSzZHWUw0RE9EanRTYzB2SFJtWlZ6?=
 =?utf-8?B?eUhBaVlqUjVHTWFKZFU5TndZMmNlVEUyNkhOSFlDM0dpR2V0Tmt2ZVFDZzdz?=
 =?utf-8?Q?+Wu19s2znZMhHaoo=3D?=
X-Exchange-RoutingPolicyChecked: Gdh51jPX4C/36R2YGybHmrVt7eBz2eNt0fQk1OiZrD7LreOQ2efwL903gxKvkZZrNkhi5kL9daMBYzEFKkaS+nCG6POWS9794ymz4/CHbjPbUwJCYjfLIjJ6M0YdQbxKNpnmnU8uikzWaKstUGX232RkcOstgDqBo/QjAH2G+w/EvYIny8/9cTM4hCUAypc7FQuTiqrKHQJgYPo5kcqklE3lVUf/dnCnCpeEj/SjFf+G4Udo5bfEa82GvcS9qR5JjyZCFfk5Z2H8TParFyxfQ9+gKt9m1i7BqfZOfF1YJMgOlLNMSllztb4X2xREWnC/2LWvJyVKga/be6TELR+5Ig==
X-MS-Exchange-CrossTenant-Network-Message-Id: de6f88cd-a7d7-4bb5-0ddb-08df34fc049c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8208.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 14:01:52.5158 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gxymAHPEbheHxr3ccOhIp65wnsWKjfz15jvuFTHE6/3KaEXX7hyuvHu+Qt7uCeMfVdZp1NlIcdTX0TuGQVxsIReAxD/HFxWzouOBtUHfNT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFAC42FDD50
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


On 28-10-2026 17:51, Arvind Yadav wrote:
> Exec queue destruction is asynchronous. Closing a VM immediately after
> killing its queues can remove mappings before GuC cleanup has finished.
>
> Track the queues using each VM and keep the bind queue's user_vm
> reference until final queue destruction. Start queue cleanup before
> removing the VM mappings.
>
> The count includes VM-owned bind queues. Release the VM's references
> to these queues before waiting for their asynchronous cleanup.
>
> During file close, use one five-second wait budget across all VMs.
> If queues remain, defer VM close until the last queue is removed.
> The existing runtime-PM reference remains held during this wait.
>
> VM destroy does not wait for queue cleanup. If user exec queues still
> reference the VM, its mappings remain after the ioctl returns until
> those queues finish cleanup. Userspace must destroy the remaining queue
> handles or close the DRM file to release them.
>
> The five-second budget limits the new queue wait, not the lifetime of
> the retained mappings. Recovery continues through the existing GuC
> reset and teardown paths.
>
> Run deferred close and final VM destruction on the module-lifetime
> destroy workqueue. Hold an extra VM reference until the close worker
> has released its PM and unplug guards. Final VM destruction retains
> the device reference until cleanup finishes.
>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Assisted-by: LLM
> Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
Tested-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_device.c     |  21 +++-
>   drivers/gpu/drm/xe/xe_exec_queue.c |  22 ++--
>   drivers/gpu/drm/xe/xe_vm.c         | 162 ++++++++++++++++++++++++++---
>   drivers/gpu/drm/xe/xe_vm.h         |   5 +
>   drivers/gpu/drm/xe/xe_vm_types.h   |  15 +++
>   5 files changed, 202 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
> index 7b4913d7665d..6cf0ce293738 100644
> --- a/drivers/gpu/drm/xe/xe_device.c
> +++ b/drivers/gpu/drm/xe/xe_device.c
> @@ -8,6 +8,7 @@
>   #include <linux/aperture.h>
>   #include <linux/delay.h>
>   #include <linux/fault-inject.h>
> +#include <linux/jiffies.h>
>   #include <linux/units.h>
>   
>   #include <drm/drm_client.h>
> @@ -177,6 +178,8 @@ static void xe_file_close(struct drm_device *dev, struct drm_file *file)
>   	struct xe_file *xef = file->driver_priv;
>   	struct xe_vm *vm;
>   	struct xe_exec_queue *q;
> +	bool close_deferred = false;
> +	unsigned long deadline;
>   	unsigned long idx;
>   
>   	guard(xe_pm_runtime)(xe);
> @@ -197,8 +200,24 @@ static void xe_file_close(struct drm_device *dev, struct drm_file *file)
>   		xe_exec_queue_kill(q);
>   		xe_exec_queue_put(q);
>   	}
> +
> +	/* Start all bind queue teardown before spending the shared wait budget. */
>   	xa_for_each(&xef->vm.xa, idx, vm)
> -		xe_vm_close_and_put(vm);
> +		xe_vm_kill_bind_queues(vm);
> +
> +	deadline = jiffies + HZ * 5;
> +	xa_for_each(&xef->vm.xa, idx, vm) {
> +		unsigned long now = jiffies;
> +		unsigned long timeout =
> +			time_before(now, deadline) ? deadline - now : 0;
> +
> +		close_deferred |=
> +			xe_vm_close_and_put_deferred(vm, timeout);
> +	}
> +
> +	if (close_deferred)
> +		drm_dbg(&xe->drm,
> +			"VM teardown deferred while exec queues are being stopped\n");
>   
>   	scoped_guard(mutex, &xef->mmio_gem.lock) {
>   		if (xef->mmio_gem.pci_barrier) {
> diff --git a/drivers/gpu/drm/xe/xe_exec_queue.c b/drivers/gpu/drm/xe/xe_exec_queue.c
> index 9a8efa2bf2bf..4bb773dc9543 100644
> --- a/drivers/gpu/drm/xe/xe_exec_queue.c
> +++ b/drivers/gpu/drm/xe/xe_exec_queue.c
> @@ -154,9 +154,16 @@ static void __xe_exec_queue_free(struct xe_exec_queue *q)
>   
>   	if (q->vm) {
>   		xe_vm_remove_exec_queue(q->vm, q);
> +		if (q->vm->xef)
> +			xe_vm_remove_close_queue(q->vm);
>   		xe_vm_put(q->vm);
>   	}
>   
> +	if (q->user_vm) {
> +		xe_vm_remove_close_queue(q->user_vm);
> +		xe_vm_put(q->user_vm);
> +	}
> +
>   	if (q->xef)
>   		xe_file_put(q->xef);
>   
> @@ -252,8 +259,12 @@ static struct xe_exec_queue *__xe_exec_queue_alloc(struct xe_device *xe,
>   		}
>   	}
>   
> -	if (vm)
> +	if (vm) {
>   		q->vm = xe_vm_get(vm);
> +		/* vm->xef stays unchanged until final VM destruction. */
> +		if (vm->xef)
> +			xe_vm_add_close_queue(vm);
> +	}
>   
>   	if (extensions) {
>   		/*
> @@ -619,8 +630,10 @@ struct xe_exec_queue *xe_exec_queue_create_bind(struct xe_device *xe,
>   			return ERR_PTR(err);
>   		}
>   
> -		if (user_vm)
> +		if (user_vm) {
>   			q->user_vm = xe_vm_get(user_vm);
> +			xe_vm_add_close_queue(user_vm);
> +		}
>   	}
>   
>   	return q;
> @@ -652,11 +665,6 @@ void xe_exec_queue_destroy(struct kref *ref)
>   	for_each_tlb_inval(q, i)
>   		xe_exec_queue_tlb_inval_last_fence_put_unlocked(q, i);
>   
> -	if (q->user_vm) {
> -		xe_vm_put(q->user_vm);
> -		q->user_vm = NULL;
> -	}
> -
>   	q->ops->destroy(q);
>   }
>   
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index 6e548fd8a809..f9bb677bcab4 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -1622,6 +1622,7 @@ static const struct xe_pt_ops xelp_pt_ops = {
>   	.pde_encode_bo = xelp_pde_encode_bo,
>   };
>   
> +static void vm_close_work_func(struct work_struct *w);
>   static void vm_destroy_work_func(struct work_struct *w);
>   
>   /**
> @@ -1765,6 +1766,10 @@ struct xe_vm *xe_vm_create(struct xe_device *xe, u32 flags, struct xe_file *xef)
>   	ttm_lru_bulk_move_init(&vm->lru_bulk_move);
>   
>   	INIT_WORK(&vm->destroy_work, vm_destroy_work_func);
> +	atomic_set(&vm->close.num_exec_queues, 0);
> +	init_waitqueue_head(&vm->close.wq);
> +	spin_lock_init(&vm->close.lock);
> +	INIT_WORK(&vm->close.work, vm_close_work_func);
>   
>   	INIT_LIST_HEAD(&vm->preempt.exec_queues);
>   	for (id = 0; id < XE_MAX_TILES_PER_DEVICE * XE_MAX_GT_PER_TILE; ++id)
> @@ -2010,19 +2015,7 @@ void xe_vm_close_and_put(struct xe_vm *vm)
>   	if (xe_vm_in_fault_mode(vm))
>   		xe_svm_close(vm);
>   
> -	if (vm->q) {
> -		int i;
> -
> -		down_write(&vm->lock);
> -		xe_exec_queue_last_fence_put(vm->q, vm);
> -		for_each_tlb_inval(vm->q, i)
> -			xe_exec_queue_tlb_inval_last_fence_put(vm->q, vm, i);
> -		up_write(&vm->lock);
> -
> -		xe_exec_queue_kill(vm->q);
> -		xe_exec_queue_put(vm->q);
> -		vm->q = NULL;
> -	}
> +	xe_vm_kill_bind_queues(vm);
>   
>   	down_write(&vm->lock);
>   	xe_vm_lock(vm, false);
> @@ -2092,6 +2085,140 @@ void xe_vm_close_and_put(struct xe_vm *vm)
>   	xe_vm_put(vm);
>   }
>   
> +static void vm_close_work_func(struct work_struct *w)
> +{
> +	struct xe_vm *vm = container_of(w, struct xe_vm, close.work);
> +	struct xe_device *xe = vm->xe;
> +	int idx;
> +
> +	/* Keep the VM and device alive until the PM and unplug guards unwind. */
> +	xe_vm_get(vm);
> +
> +	if (drm_dev_enter(&xe->drm, &idx)) {
> +		xe_pm_runtime_get(xe);
> +		xe_vm_close_and_put(vm);
> +		xe_pm_runtime_put(xe);
> +		drm_dev_exit(idx);
> +	} else {
> +		/*
> +		 * The device is gone. Drop the VM without a runtime PM reference.
> +		 * xe_vm_close() guards its own register access.
> +		 */
> +		xe_vm_close_and_put(vm);
> +	}
> +
> +	xe_vm_put(vm);
> +}
> +
> +/**
> + * xe_vm_kill_bind_queues() - Kill and release the VM bind queue
> + * @vm: The VM whose bind queue should be stopped
> + *
> + * Callers must serialize teardown of @vm. Later calls are harmless because
> + * the first call clears the VM bind queue pointer.
> + */
> +void xe_vm_kill_bind_queues(struct xe_vm *vm)
> +{
> +	struct xe_exec_queue *q;
> +	int i;
> +
> +	if (!vm->q)
> +		return;
> +
> +	down_write(&vm->lock);
> +	q = vm->q;
> +	vm->q = NULL;
> +	xe_exec_queue_last_fence_put(q, vm);
> +	for_each_tlb_inval(q, i)
> +		xe_exec_queue_tlb_inval_last_fence_put(q, vm, i);
> +	up_write(&vm->lock);
> +
> +	xe_exec_queue_kill(q);
> +	xe_exec_queue_put(q);
> +}
> +
> +/**
> + * xe_vm_add_close_queue() - Track an exec queue using the VM
> + * @vm: The VM used by the exec queue
> + *
> + * The queue is tracked until its asynchronous destruction completes.
> + */
> +void xe_vm_add_close_queue(struct xe_vm *vm)
> +{
> +	atomic_inc(&vm->close.num_exec_queues);
> +}
> +
> +/**
> + * xe_vm_remove_close_queue() - Stop tracking an exec queue
> + * @vm: The VM used by the exec queue
> + *
> + * If this is the last tracked queue and VM close was deferred, schedule
> + * the deferred VM close.
> + */
> +void xe_vm_remove_close_queue(struct xe_vm *vm)
> +{
> +	bool queue_close = false;
> +
> +	if (!atomic_dec_and_test(&vm->close.num_exec_queues))
> +		return;
> +
> +	wake_up_all(&vm->close.wq);
> +
> +	spin_lock(&vm->close.lock);
> +	if (vm->close.deferred) {
> +		vm->close.deferred = false;
> +		queue_close = true;
> +	}
> +	spin_unlock(&vm->close.lock);
> +
> +	if (queue_close)
> +		xe_destroy_wq_queue(&vm->close.work);
> +}
> +
> +/**
> + * xe_vm_close_and_put_deferred() - Close a VM immediately or defer the close
> + * @vm: The VM reference to consume
> + * @timeout: Maximum time to wait for VM queues, in jiffies
> + *
> + * The VM must already be marked closing, and callers must serialize teardown.
> + * Release the VM-owned bind queues before waiting for queue cleanup. Callers
> + * may release them earlier to start cleanup for several VMs before waiting.
> + *
> + * If queues remain after @timeout, keep the mappings and finish VM close
> + * after the last tracked queue is freed. This consumes the caller's VM
> + * reference on both the immediate and deferred paths.
> + *
> + * Return: %true if VM close was deferred, or %false if it completed now.
> + */
> +bool xe_vm_close_and_put_deferred(struct xe_vm *vm, unsigned long timeout)
> +{
> +	bool queue_close = false;
> +
> +	/* Drop VM-owned queue references before waiting for their final free. */
> +	xe_vm_kill_bind_queues(vm);
> +
> +	if (!atomic_read(&vm->close.num_exec_queues) ||
> +	    wait_event_timeout(vm->close.wq,
> +			       !atomic_read(&vm->close.num_exec_queues),
> +			       timeout)) {
> +		xe_vm_close_and_put(vm);
> +		return false;
> +	}
> +
> +	spin_lock(&vm->close.lock);
> +	vm->close.deferred = true;
> +	if (!atomic_read(&vm->close.num_exec_queues)) {
> +		vm->close.deferred = false;
> +		queue_close = true;
> +	}
> +	spin_unlock(&vm->close.lock);
> +
> +	if (queue_close)
> +		xe_destroy_wq_queue(&vm->close.work);
> +
> +	return true;
> +}
> +
>   static void vm_destroy_work_func(struct work_struct *w)
>   {
>   	struct xe_vm *vm =
> @@ -2138,7 +2265,7 @@ static void xe_vm_free(struct drm_gpuvm *gpuvm)
>   	drm_dev_get(&vm->xe->drm);
>   
>   	/* To destroy the VM we need to be able to sleep */
> -	queue_work(vm->xe->destroy_wq, &vm->destroy_work);
> +	xe_destroy_wq_queue(&vm->destroy_work);
>   }
>   
>   struct xe_vm *xe_vm_lookup(struct xe_file *xef, u32 id)
> @@ -2284,7 +2411,12 @@ int xe_vm_destroy_ioctl(struct drm_device *dev, void *data,
>   
>   	if (!err) {
>   		xe_vm_close_start(vm);
> -		xe_vm_close_and_put(vm);
> +
> +		/*
> +		 * User exec queues can outlive the VM handle. Do not wait for
> +		 * queues which this ioctl does not destroy.
> +		 */
> +		xe_vm_close_and_put_deferred(vm, 0);
>   	}
>   
>   	return err;
> diff --git a/drivers/gpu/drm/xe/xe_vm.h b/drivers/gpu/drm/xe/xe_vm.h
> index a8b33cb2b559..028c17ed1df7 100644
> --- a/drivers/gpu/drm/xe/xe_vm.h
> +++ b/drivers/gpu/drm/xe/xe_vm.h
> @@ -221,6 +221,11 @@ int xe_vm_get_property_ioctl(struct drm_device *dev, void *data,
>   
>   void xe_vm_close_and_put(struct xe_vm *vm);
>   void xe_vm_close_start(struct xe_vm *vm);
> +bool xe_vm_close_and_put_deferred(struct xe_vm *vm, unsigned long timeout);
> +void xe_vm_kill_bind_queues(struct xe_vm *vm);
> +
> +void xe_vm_add_close_queue(struct xe_vm *vm);
> +void xe_vm_remove_close_queue(struct xe_vm *vm);
>   
>   static inline bool xe_vm_in_fault_mode(struct xe_vm *vm)
>   {
> diff --git a/drivers/gpu/drm/xe/xe_vm_types.h b/drivers/gpu/drm/xe/xe_vm_types.h
> index 6ca9ef9d0c0b..6ebc6714534b 100644
> --- a/drivers/gpu/drm/xe/xe_vm_types.h
> +++ b/drivers/gpu/drm/xe/xe_vm_types.h
> @@ -14,6 +14,7 @@
>   #include <linux/kref.h>
>   #include <linux/mmu_notifier.h>
>   #include <linux/scatterlist.h>
> +#include <linux/wait.h>
>   
>   #include "xe_device_types.h"
>   #include "xe_pt_types.h"
> @@ -314,6 +315,20 @@ struct xe_vm {
>   	 */
>   	struct work_struct destroy_work;
>   
> +	/** @close: State used to defer VM teardown until exec queues are gone. */
> +	struct {
> +		/** @close.num_exec_queues: Queues which can access this VM. */
> +		atomic_t num_exec_queues;
> +		/** @close.wq: Waitqueue for exec queue teardown. */
> +		wait_queue_head_t wq;
> +		/** @close.lock: Protects deferred and work scheduling. */
> +		spinlock_t lock;
> +		/** @close.deferred: VM close is waiting for queue teardown. */
> +		bool deferred;
> +		/** @close.work: Completes a deferred VM close. */
> +		struct work_struct work;
> +	} close;
> +
>   	/**
>   	 * @rftree: range fence tree to track updates to page table structure.
>   	 * Used to implement conflict tracking between independent bind engines.
