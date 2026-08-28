Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398EFC61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 03:40:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AA7410F22E;
	Fri, 28 Aug 2026 03:40:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="IEXiozcM";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7A6110F22E;
 Fri, 28 Aug 2026 03:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787888409; x=1819424409;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VCTQ8ae6slHtfwjG1UWSyno9XM45mCZkjGlEaxNn9oo=;
 b=IEXiozcMO56CMlrbSCaR1JKKAdLXoAfkT/TCVGw3hpGxeEAEaFjG8z9/
 szzP1W8IBeLfBHnnPROBc8vMpqOG+vn9O+V3Zf+TRXapfIGFanKpGFOuX
 ChE1lEZ8TwBbm0OgiccZPdN38KkQay8YGOFeBmtNlS2BJonQ1vo8HrbOU
 9BpcTEb7WFDwBxjUna7RvyDMryNmOlJinuc0BIsARbucG+E57NN1fdp/x
 yYBWZxCC65MaS+d4OC+E9qGUuucsIefclb7MdDPG6LZfjtvAy1lCcwhRq
 ha8CV9kw4o2nMGIa5ydQoXdTLemjutbuEWIVtwy00kHqWcg6aoW4vXJt5 A==;
X-CSE-ConnectionGUID: N768l0xJSM+sJBKZdflFrQ==
X-CSE-MsgGUID: /j/N1AjSTHWuUMVexk3KDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88448789"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; d="scan'208";a="88448789"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 20:40:08 -0700
X-CSE-ConnectionGUID: Guxc9KJgSIidOL6TDKZneA==
X-CSE-MsgGUID: qI8LJeWxRn2sOA/u3mhq3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; d="scan'208";a="271572572"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 20:40:09 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 20:40:08 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 27 Aug 2026 20:40:08 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.61) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 20:40:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZrB4a6yDDdkwyeqqubdGSWyyp4vl1qsV9M+quevzRR3sByxwNdOObLmYaLxkDuuFowmwN7Mg7+nomCqMmOEQRhLac9fvU6VTwnSz4PR7t5F7A80dNsEXQWpIJtShH5t/Ssgy9JUSkWoZW+ztjFpFiveZFErhBM/HAKP1n91b15IbPaBcCGG1BsMTui6xECjbWUuwZIFQNYDaPRxgimDNHziSAim49hTboxyMV4JpGjRAqdce0GuqUwrvQbHza3LBpsYh2YbUwoWZMadrSl7V73CF76nbc8sRe/dp2fzG/TO3OKXJxai1+ns2Ut1zn3w9kRwW0Xk0yvoT9RlYn33mgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPJDZTjaaK66r5Hmpd8YhYSFTSfO4iRa+rbKg7QHtgs=;
 b=qvNHE34q1d8tF7OfxK04ekA+vGCsvoG4a2HagYxVLoGPgSoC0cTgKhQsy2hleWIKfZc6KKvOS71qI4/H+gvTKj+ZhyQEVlebW6lZpErBjGJbF7cr6+4EgSwFCz9LjMG3nebJdV3gfSW/E8MqsYxfoqrh8FGXLaejlMevUViKU0vG+Uh6aOy6pbszDdSJZLdBX9/AOJwpH2pQs4tITJ0V85PTZYfqcSptCwooMGTXdER0a9WhEw931NZ3TigqIi6FSPOuhJ6fLtIoKT3f9mUEQ6HSG2qNQhOH3tXWW0R/cLXAhyeZx3XOuzq3P1yPLsEz1ZW2HAB6ef1ZJ/Dyh9VEsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5709.namprd11.prod.outlook.com (2603:10b6:408:148::6)
 by DM3PPFE9E88246B.namprd11.prod.outlook.com (2603:10b6:f:fc00::f5b)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 03:40:02 +0000
Received: from BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c]) by BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 03:40:02 +0000
Message-ID: <818c88cd-b832-47ee-b551-891ccf81d521@intel.com>
Date: Fri, 28 Aug 2026 09:09:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] drm/xe: Send wedged notification from a worker
To: Andi Shyti <andi.shyti@kernel.org>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <matthew.brost@intel.com>, <himal.prasad.ghimiray@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <rodrigo.vivi@intel.com>
References: <20260827101801.1247654-1-arvind.yadav@intel.com>
 <20260827101801.1247654-6-arvind.yadav@intel.com>
 <apC1T6XkNdVIywn3@zenone.zhora.eu>
Content-Language: en-US
From: "Yadav, Arvind" <arvind.yadav@intel.com>
In-Reply-To: <apC1T6XkNdVIywn3@zenone.zhora.eu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0017.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:179::9) To BN0PR11MB5709.namprd11.prod.outlook.com
 (2603:10b6:408:148::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR11MB5709:EE_|DM3PPFE9E88246B:EE_
X-MS-Office365-Filtering-Correlation-Id: 21fffe9a-9231-4ce5-8136-08df04b60b14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: EUBAYTDaw4gyUNpGPPWJKid9+TBdlEhIy8m8fx61rHlHt6yxVhrSSkrw3Io9pR/RVLw0Td0ZujdM94FEkqhPlI9Pe2cJGSPM1lW0XA9XZ9bq9RKAFAn/9rNhCQBqha+r88GaWNGdhAAweljww7HYR3RWzh/I0LwztEubfuw9USru3Q6jF+RdzR6ilFofTZgUhWpwiD8sGctE9ohy8/oCEONKoeniFWwgzyE9eZsQe672IPukqa4XgrdhdRZ5cP306PmXTe2r7ZUdLELI2/VKvv0MDZqmPHcKpHQN+dKKLWK2WEeacxD++Vp/6e1d6+YztEekIYMvfU/OdZnnqdJDReYTdqhVF4KNk24uww6v6QMArwaPGuiFYPlj1fxux2jI12VaiXwNVpmhVFRy6z4CnRY+W8brerNqUGngcqtSre8mN+kvjjJRIKeRq9/rkvmsuWiDLWTdNhXQNsinuQk0wtYcwMOUSsAua35bR/3KSeiNRR4JjIjQpBcMrg+rT5cRWVz47CoMlmgCZJSx49Yw5QLmMTsOkg0spHNM8pxM+TwR+G5UHHi0I/pU+TxQYn/XFPQtjTV7WyizA+fQDfMiCwVG6sijoYAFNURUp3GAp3LJ6A6RopiJa7I3SjF2wyz5MvCSeYFnWPKT1Sg7I/ce5CAZxHHex8WI4JEZIFEr15I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR11MB5709.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXYxbzhtZmZnbzVoQ3NTSm5zdDRzdUN3Q0JzS2J2K0kxUkRIK1pXemxObDRo?=
 =?utf-8?B?dkpybnNQeHRKTmhWNGlmZ2lJRjQ1eHF1S0w1UzhLSmVVSnU1RU9sYmpPbVNQ?=
 =?utf-8?B?NG5GZVA4TGM0NUdXZytQRWZWVnI5aERjaTFDRzFZUHduT2Vvc010SUROWFc4?=
 =?utf-8?B?dzRwUjZDdVQ1L3lJVDJhTWh4QnR5VjBQMUVXZXRIWFFXVGw3VGVqUTczM3Mr?=
 =?utf-8?B?Z09qTUFuUCsycTNOWldpVnc2MUxjS3dXbFdrSFhEeTBLM2VkbHV0a3RZdmZM?=
 =?utf-8?B?QU1WSTlkVURheWl3ejBtOXpFSGhyTHBmcXBwaVd6Y0gxOE84ai9nNEt0QW9s?=
 =?utf-8?B?azJWTTJqYmhIcWF2Mldyd0VpWWpPWVY1YUtKYzUvU0lib1RIbU13Y1pLZXBC?=
 =?utf-8?B?citrZnBCTllBdjkxeEZIWml5OWhucllFVUVtdDJFNENsemxrRm4zZTkrQ1dE?=
 =?utf-8?B?S09jeWlRU2JVbWZNT1lVV3pKUWNOalUrWkxrQWRDTzFXNzN5UXc2Q2tieVFh?=
 =?utf-8?B?UHdETHJKanVQUUFsZjRMUnllYkovMGttZlE0bGMxdnJKUnFKTG0rc1dmOWZW?=
 =?utf-8?B?SWl2UFV0SXRqTEhGSjAyM3lZNVoxVkZoOEZLL2dvZ3Q3cVFhVnR6alZOZDZ3?=
 =?utf-8?B?bnF0NW9iWHVGWW5oS1EwblBnYnVIYU9EMDQxVHorSU5qcCtYc1M4TGRsSFVn?=
 =?utf-8?B?K3F3eTVadnVvbkYvcjlLVXNJYkJQblNudWVJR3VYVzczU3hKbDJpTngvWEJP?=
 =?utf-8?B?SFlmdDcxekpGdzd1eVYyb2FKTmRKTytGZ0hTWmExdWtwZWM4RmplQmdBSlp5?=
 =?utf-8?B?Q1VTMVZuNWFzOFArcGlQemF3OXRJd3IzWEh0d1BqaEROZEU1TzZlK0hwaDZS?=
 =?utf-8?B?clZpZks0eW1NenFKa01ieDJER2VJM2pMSXFxUFNuV2RuVHpNWmVRclhRN0FT?=
 =?utf-8?B?WlljcC9waDlvZ0p4aDVBdzIwdTVzRDl5MHBhU0l6QzB5WHdtbXh5QjZjSjlp?=
 =?utf-8?B?N3RCdTFsOGZxaGR0VU5pNFFtVlUxR245djFka1ROV2JMWFhXdTE5NVNVUG9J?=
 =?utf-8?B?VHpjRHduenBCMlVzNDF6VXpnNFJQUWRiem12UnBYbVpYM0JmWEVKdTFyWXFm?=
 =?utf-8?B?SWZNTG5XdUF0VUlRNmZYYTJrTnQyQW0zeHFLWDdaUDZ5cWJQdm4weTdOc2NK?=
 =?utf-8?B?ckpjaDNxT2hkSmw5eGcvc0NwVzYrTGxhQ1ZKWGdoQXRJZS9EUDQvYnd3bFJD?=
 =?utf-8?B?d2VESm9YRGlCNWpYWGhRaWJsQSs1YWNMSTRNakYwWGZHajJpQm5qTTRreEcy?=
 =?utf-8?B?QjR2QWNsOXpBaUgwdWI3UXBoRXpSR2h6UXhvSkdmc1RVWjVkNHhSTGZ5SU1p?=
 =?utf-8?B?dkpHeCtuREJMQWFTTklobndVUHpvZSt1OTUvSk94RzhCSm5CYXNFUkIvNTll?=
 =?utf-8?B?T0tpclF4SkJHVkQ4eXQwSnlmMy9PZTJpSlFzY0dDbEhtZDd3OC8yczd4M3FG?=
 =?utf-8?B?MDgvSzB2WEs5a3B3L0pwWXRBMXRoSlZaakRrbXo1MXZ2dUxSRzJNUXR6VWZR?=
 =?utf-8?B?cGgwdFFTQjJITnhpdWJNNlRuQzdSOU9rOHZteDJicHdFNGxvcGZxZWlWNWdu?=
 =?utf-8?B?N3hINVJHTDF3T2R1UFdSTVh4WU52RUVHQUlodDNEbUpLNUNmNnZRaXJEN1Zz?=
 =?utf-8?B?cmdlRTlYRXB0emQ0RFpBSTluZU5jbm0rZjNENVJVQldHQjB6QmozYUhlUVc4?=
 =?utf-8?B?VlNvSjU2R0ZFcEpOd0JSYW8rNC9nK290a2Z3VEpicCtpanJRU2JIRFMyODNz?=
 =?utf-8?B?aHltZ3RqaTJ2TDhmLzVpcDBsK2ZnVDBBTTV0SWhrTDdBSWNsZTR6YzNlN05m?=
 =?utf-8?B?OHV2cU5Ic3VIQTZra0ZwTGc3eUU3VmZ2VlFweGJxYzlhaldzNHB5MVFENFBS?=
 =?utf-8?B?VmVrVzZXdjArT1ExVEpkeG1hSit2aUw3NFUzdVBaaHJidVY3OFlzUXA3K2Jz?=
 =?utf-8?B?ZkFoakM3bTBLR0ZWSUt5WklJZ2hqWE5hYnFZaEhqT0dFUEY2NkVoQ25ieDF6?=
 =?utf-8?B?Z3Fma20yWXNvYXRuUTlLbG4rV0M2dGc4aENWeHpjMmU5VXdHcmRiWHdhSEZ5?=
 =?utf-8?B?M1ZYMm1mckpzQk10Tm1WNmVNbERGZDFyNVhNRWx0dnorOWRjb1QwQ3VaTVlL?=
 =?utf-8?B?NnpLaEtKMXhkenZ3UXlGZFg5SFQ0VjlxSmo3dTZkbVl6MmR3V2JKVWpiRWFQ?=
 =?utf-8?B?Q1htbXBvMnREVDlHWTdiRFRidm81V2hmV0dJQjIraFRuNnVjUGxNZitoR1Vm?=
 =?utf-8?B?VU5mVWphcEVCU1MxdGhMRDkycklHZ1k3b0xLTndNNWpsTmcwNm85QT09?=
X-Exchange-RoutingPolicyChecked: g4P+QQL8xFNX94BAStT0ZNWRsfNQsUSJGz/zgxA0CxzoJd0X9UMa/pNdDVQ9TkFJ1BoIamfKJtEeiAbMg5Th3m1xamgDpXJPmV6meGeE5hETLuCfqKNlOaOpv7DRqmpu8l6dejxBrjQqO5kMR/Sk/nxPAjbJInZyk4FxHcfB2ubyAy6R4jp6/igM+eqIyBictZldYfxHkuFqcVWYsfCROd6oqVyg5+zuOIbRv2dw3EFvf5Hj3ySmewv3tQCNJXJLwU4UFYNFZRfuVTNIWBNwI2qdJuDtJ0Do90ISSSaY/ia9XEG/WR/Dspw14yz5NFDaAHHWU2PoGsqs0g4wEZGY9w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 21fffe9a-9231-4ce5-8136-08df04b60b14
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5709.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 03:40:02.8126 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rLYne3d9MOICV4OStuKjUkiPl3uTNiIPYbZ/z6Rx8T0DciNjFL6dSjEafb88GcA0phPNl/HZaUuMLmsJYcTkag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFE9E88246B
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


On 28-08-2026 03:42, Andi Shyti wrote:
> Hi Arvind,
>
> ...
>
>> +static void xe_device_wedged_work(struct work_struct *work)
>> +{
>> +	struct xe_device *xe =
>> +			container_of(work, struct xe_device, wedged.work);
>> +	unsigned long method;
>> +
>> +	/* Report at most one recovery method per worker invocation. */
>> +	method = READ_ONCE(xe->wedged.method);
>> +	if (method != READ_ONCE(xe->wedged.reported_method)) {
>> +		drm_dev_wedged_event(&xe->drm, method, NULL);
>> +		WRITE_ONCE(xe->wedged.reported_method, method);
> I think we need to check the error from drm_dev_wedged_event():
>
> 		int err;
>
> 		err = drm_dev_wedged_event(&xe->drm, method, NULL);
> 		if (!err)
> 			WRITE_ONCE(xe->wedged.reported_method, method);


Thanks, agreed.
I will update reported_method only when drm_dev_wedged_event() succeeds.

Arvind

>
> Andi
>
>> +	}
