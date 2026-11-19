Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56814606A331
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b3Sat3jj;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=jbJK4CHI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BEF8112290;
	Thu, 19 Nov 2026 10:54:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3BF711228B;
 Thu, 19 Nov 2026 10:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795085656; x=1826621656;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=c0rCdJgOKU466thAezw/0Hvimxyh1I9hhikTBpfmKmM=;
 b=b3Sat3jj15DEXHHEG7UJbFdfF9M0AmrW7kMnTN8cMaFvW8DdZ6DLMnB6
 t3oQtwTUFgIqavXyH3+Dosjw1LPDtoDe8F3tWDdaPd466QPLY/E7d/c02
 zeHoOzyL7upXUPyQvNJrZXgpOttD4xq2NtCztssKBEt+56l6fJwE2JzP1
 IwKekDIvEjbab4xvQc9qcd+0UXhgTr3kApz1zDjsiBBZeSDWWmQ8/MuAG
 Zx3G2lZ00ps0WJR8AxhuyNKdbRjRd2S5dFYoWoPyZs4lHb9dOCLpRDvwv
 fM1p4LKJt1twh4gGjAT/lEC/7WV358N2GduI4wn/8TtoIWrNVDntBgWPP Q==;
X-CSE-ConnectionGUID: BqKpJmrbQ2mqeTOwKNBs1g==
X-CSE-MsgGUID: 9trBHwHITzSH4cuw56E7mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3825865"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3825865"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 02:54:16 -0800
X-CSE-ConnectionGUID: J69DQ+xVQWm6t79UMqY4Hg==
X-CSE-MsgGUID: trujw5GeTJOybVp7zBu7AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; d="scan'208";a="10214151"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 02:54:15 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 02:54:15 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 19 Nov 2026 02:54:14 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.38) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 02:54:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+iG4GMx8kcGL0CMda7B0wd2hDSpdrWEYhyKILXbUrsDoRtLaHkHShatsfen6fT1lEigEprkNYWVwyLCz1Al+IPFHvxzbpr15NtjhjguYzrsm9DigVGpXfTHx1l/UBF6C8fi8NhbEB6dQD6XzJiZ6x+jlqe+xvb2inYMKKO1x/8wJ1VzN3oEhuH3xQienS11FRyD2pWosx1GJGcFkX2lWP9qajdbVCORqgUZludNBK/aWTkvx4cddGNIYixs0ckzjTjvIeiSyk8SY2c8TmukJ/e+toDLEGgQiXzMnODawE4cQR6cTHwUA4qjCTzvekX7RhA5GLKiotJdS+KwxT6gAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DeBI9tXPLVUjnrZsvnKkoM6nUtxsQOgEvc02pi4dtw4=;
 b=gvWctjKde19IdQCLXRtWVvTREOKKY+qelIHbonHz0pXgZEM196SIVLBKMHFT6xjuWU4kmU69MHLIzluUmERxrZqCtF66tb/npeDzujk2fwT2DE0tnYbvkWIdAUcCcNhDz7n/gauuuLhoHebUVXWp4ln8K0xVCvLRgrt8mnd5LNFTMs7YUDl7B0XZFFAozjc80YXN5iyv/+A32phC/6Ha1owUQepUgBszqeW3Oeg/j9dHa1S3LhOvdTEe7oRRmkaZ/RJAVOY3M3IFtuaug6XNwDSHuC5hBuraYbLqtT7OcP4WtNGmGqN55GaJtuowe+nv2G04/wrPJq5WqstI86CtDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DeBI9tXPLVUjnrZsvnKkoM6nUtxsQOgEvc02pi4dtw4=;
 b=jbJK4CHIwqo5HoDif9uhDn2uxZsZrilzdIK7wQh3FqgKGgE2ySu4g8cJJvPtoORsIaGEXTgIsWIIF9mGJeiK0ODHsnejsDf5ZLZvHW+Brg/U3k4Pl3NSzIR4tuPOcUOnUMqo5ugBnTykQzcXM84GbkJqbfl9uassqtv0EFo5V10=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5709.namprd11.prod.outlook.com (2603:10b6:408:148::6)
 by PH7PR11MB7478.namprd11.prod.outlook.com (2603:10b6:510:269::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 19 Nov
 2026 10:54:07 +0000
Received: from BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c]) by BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c%6]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 10:54:07 +0000
Message-ID: <21fa98f8-ad3c-48b0-91f0-b5245d64ca9e@intel.com>
Date: Thu, 19 Nov 2026 16:23:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe/guc: Do not trigger TDR from the memory CAT error
 handler
To: Matthew Brost <matthew.brost@intel.com>, "Summers, Stuart"
 <stuart.summers@intel.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Vivi,
 Rodrigo" <rodrigo.vivi@intel.com>, "Ghimiray, Himal Prasad"
 <himal.prasad.ghimiray@intel.com>, "Upadhyay, Tejas"
 <tejas.upadhyay@intel.com>, "thomas.hellstrom@linux.intel.com"
 <thomas.hellstrom@linux.intel.com>
References: <20261116102020.1567127-1-arvind.yadav@intel.com>
 <04c50600f64b0798c62f92995aa36bb0f56c434e.camel@intel.com>
 <av5xQK24zmMYCEv3@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: "Yadav, Arvind" <arvind.yadav@intel.com>
In-Reply-To: <av5xQK24zmMYCEv3@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0209.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b0::8) To BN0PR11MB5709.namprd11.prod.outlook.com
 (2603:10b6:408:148::6)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR11MB5709:EE_|PH7PR11MB7478:EE_
X-MS-Office365-Filtering-Correlation-Id: fe92bea4-4b9d-4b15-205f-08df462b6f62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|261022113327099003|261022075727099003|261021123027099003|11063799006|4143699003|56012099006|261026140227099003|10067099003|261028144727099003|261021121427099003|261022105027099003|261026121527099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: LLB4njQV/cyr4+DjkOP2xOxmHgkJWW0qPWnDCGwd0qAaRKKWOCU64v3wy6dxleisLnxpJkStj6IN5WO2pTg1sjmVAGfLLghxZuDnZ83J28gfQX0Nrf9nAi2a5nu2ezTYlHHNC4kV6pXt1jPwiehl3PyLw4xi+eWYf9T6Sb6oWpyYVk4oA/g4ZUcTHru51xbyoGBjAVsDO7fnyZAr/kLOvJ2RdTv5TTkjPzovnn6hk9BbVH+xVl5KP7B6kvQ/UGlQUo2XrUNM4VLLDmwRuWjDdbZ1/SHZxZZQV39Q8vygu+Q9u+JN/sn8W/mfbdEqd17o19NmYz48EC5Eslz+LaaJo81c5LcCN8QoMx9nUls+R+8bKO4kBDDnxxM2HFBod1n2uudWet7LZKO085hFKdCIPMIZ0aEYesqNnPxBDhAbxJG7wIZTE4KXvUJ7r12sMviCowcLZoUDMjjfW8oXUhrQ10WHH044jBtC43xG4J3JpLVQeCvdJzSvDyH1OCZRkjvtpY5AwqAxCsxet0/JGq5llNMpHEtzcSFop0ZpElUiuRS0v4e/nW4j4OiCUVTXF+Eqpljfeo3moZkhm9XOVSIGLWZiwqTrX3YSUsrQ/BdxE9XRYp0pHw9KHP7mLyVzw1cUH+hMCDfOvyYpakmqvnK1sJCXHRzil9UwxaYDZwLZe2E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR11MB5709.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261022113327099003)(261022075727099003)(261021123027099003)(11063799006)(4143699003)(56012099006)(261026140227099003)(10067099003)(261028144727099003)(261021121427099003)(261022105027099003)(261026121527099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3FvcFFDRm5DeUVnYnAvTStwWlFuNWpVWXp1a1E3WmkvMWxXY1hRS1p1R2ta?=
 =?utf-8?B?K01YMlY2aGZya0tjWWJ6YUczVFRjRHg3QWIvWmZ5QytJQ2ZQSExwdG14SStT?=
 =?utf-8?B?c3JRUlgxOGpvckIrNVlUeGlhQjVmWm5aUVpwWEtlZWtOQnMvdGM1dzZOUldu?=
 =?utf-8?B?dHFvenlOZUJMMHZUcE9kOWNnZUNKaHRpRklSVnB5dXQ3a3h3cE1hTFpxSThS?=
 =?utf-8?B?SnNtMC80Q3oyMURNZTJwQVVnY21DOWIwWStsOEVOVlg3MUNBSzlBc0ZUTjE3?=
 =?utf-8?B?TjArWmZZTzBaZTFnUG0ycStyelk4VHo1VDNUMmYvWmpwVVRLS2UzMzJlbUUy?=
 =?utf-8?B?RlZqN2puOGF4KzFLcmdSQVpZdHJodG9LNjVKbFUycTdyYU14K3ZHaXV2Q3N6?=
 =?utf-8?B?SWJwbHAwcThobnl1TlRMOGNrTzZZdjBlY2NOZ09SaGZXVW5WOE9SL1JRMHFU?=
 =?utf-8?B?NUttT1FMOThDSnRUTUF2aFByY2F5ZGk0QlY5dE5jRHptR3BRUEthd0JJbFFB?=
 =?utf-8?B?K0gwdUZxdkl4bDVNeWd3VHdDUjk3d05RRERxSm9yci9NN2NCK2t2ZnFMTmdz?=
 =?utf-8?B?aTJFRTZJS3VxTHY5bXcxRG8zM2JRdXo0dVBSS093aUVjNjdzMHE2NURsZWxm?=
 =?utf-8?B?MGZ4Wm5yUmRVS0VHcEQzUjZvQ21zK0tRdFFQOEFSMkIxLzZraXIyNW5WRVdW?=
 =?utf-8?B?MlFSMGplYkdFb1Z2ZzdpTWp3aU1LUE1xU2VrZDk3QWZFYTRWMnZYdndrRnJR?=
 =?utf-8?B?TXYzQ1hubXE4KzlBSkV5M0p0MmxvWWtGeElNSHBFL0lrRWJxazFLaTN6aDE5?=
 =?utf-8?B?eDZHbHV2S2NqbjcrOW9DRTI2NEpZaXlGVGt0MDJoYVdVYkRidzk2TUJRWlFl?=
 =?utf-8?B?eHlMczdrdkxEbG4wMFVobk9ua0ZXZjBPd2ZKZExhS0dLVTFBTWM0cVpZaUZx?=
 =?utf-8?B?WjBENkNwa3JuLzBhcEIzV2lNK1pZcUdIMDl6aTNUZm1XL1YyazczT0JTUkNX?=
 =?utf-8?B?RDhuK2Q0SEZpdHBQMWppOUJIdm9YOHNSZUt3dmd1b2tDd2luM1NnNUJQeDBM?=
 =?utf-8?B?WFpNNGM4YnBBMjVjWkhMdEplQm1jWGI3MlZSK2ZXZVhmZ1ZOcUdKQzlxZDg4?=
 =?utf-8?B?WFJvN041QXljcGNld1dQeEdIS09rdVRsNGFpRXRxL1ZLZXBjeE5CNjJiK29v?=
 =?utf-8?B?RmFsY2o4T2JXMGI2NXNlQmtJOXpFRng0eWlhQUtWWHozMlAvYnR2aFhMRzRj?=
 =?utf-8?B?MG56aGxWTzEvQXozN0M4QTFyT2xGc3hwNWJxV2U3TXZxVWsvQVpnVXJKSzhS?=
 =?utf-8?B?QWtha3hNaVJhOG9NeGtaZCt6b0RWeXlieUNYUXZSblBsZUc1VXNFZFpZb0hZ?=
 =?utf-8?B?cXgrWmdWRUo1OU5xQ211bXJjSWtvRE1STThUVnM1UlIxK1REdUZISWQwV2F3?=
 =?utf-8?B?OC9WNVFhcG54RnYzRGhFQU5hTkl6VEJLdExaMld5Q3JWNFBIUzNqaERxc0hk?=
 =?utf-8?B?S0NiOWI3NDQ5bTZQdjlUeE1EUlRjN1dnaW50Vk8xOHZFVDd5T0o2OTZPa1Nl?=
 =?utf-8?B?OEFkN2ZDcmhwRXhtbzNCeDFUVGEzOEZkdWFXTXIreHZ2dlRvM2N2UU1QYjQx?=
 =?utf-8?B?R2d5VUVOeThtK09mUTAzOExBS3Q0bFJhUzlPb1JyQktpcks1ZGduMmdzbHlC?=
 =?utf-8?B?M3lGWjhvVXh2Y0w5ZkdOM3o3RDFZNEVaTVUvc05Xa0VrSWQ5TlJlODBjOElK?=
 =?utf-8?B?MFhoUTVZcWl1Z2x5OUp4R2krWlFEV3gzM09ycU5KVWdxVUNadmRXczJ1QUFx?=
 =?utf-8?B?WTZxQURRcUdNNUNRYXNiZEw0NFk3ZWdQRzVHeC9SRlFpZVZENkcybkFkUVlm?=
 =?utf-8?B?OHU3YTZ6dHdDQ0FSSlRGNkxsYnZQTWFpZWZzcXJGTmQydytVVzRvTHozcmlC?=
 =?utf-8?B?Q3ppL09UaUxjbkV1S2NJdFUwa2lqNnBlenZ4Q0hvVXMvamw4TURKKzZZUEpM?=
 =?utf-8?B?VDN0WGxSMVFrYWoyWG5oWUgxY2paUmtkNzJ5aDN4ZzdhNjR2WUlQd1Irc0g5?=
 =?utf-8?B?Q01sV09EZDdYZXJaeUxGNTRGSkNIc3BIZ2RhME9VajU1NUtVazBvUWZtbmVx?=
 =?utf-8?B?OFk2SmdpQktLSllSUDF3cUNGc3Y5cVhYZ1VrN3pyQUpweWJpUTk3VlF6RHFU?=
 =?utf-8?B?YVkyV1RseGRpUUhQMmMrSmpZeVBMeUEwaGlmN1lSSThmN1N0emY2U0lOSndC?=
 =?utf-8?B?QkJVS2d1UTRFdHp3TWdzVHoxWTZWWXU1aUFzUENuWDR0cnhHVUdOTGtDQlFr?=
 =?utf-8?B?Mmk0R2hudmVERDdjNWp0MG15Z0xKUTdjNHFSdjRsQTYyYjNHdzRUQT09?=
X-Exchange-RoutingPolicyChecked: l0mwLEhquc+x3ekKLLZD0ONuSBr4WWonQlHcXKP0U3xu0AafzIn3d3ukU9hQ1tnM6CVGe0v0GBS5F/TEYvdb9WKW/9j3MAQkD4O/OBjaT0TlZGCjv6VVfLmGAXSH7J0AilylQMQnc4ZbkVI9iYUJf7gxUSQ0B7CAQvKYd29ml+j0+fcEYpF5s6ER9LluLY3uqmRG4NbR7O4JLCpHGtFFhl37VsgH1Bi/KbYZh9sFO9IEdiV/vEPSI71knzX3yais2PTcXfRGMrPU1lyP8kSYu2ybebul4FP+RRcqb9YBs/2qZG+4xUkfgbP9+RRba6osb2uQays8ysmsPv1266NbIg==
X-MS-Exchange-CrossTenant-Network-Message-Id: fe92bea4-4b9d-4b15-205f-08df462b6f62
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5709.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 10:54:07.7541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AznAXH0X2V3Yc5thDh2qdek7/Q3ZO+JZtr4pykz+qSe5Mg9PqtsWSA6dMvecoMiVH5eul8teWSYTiFOnL5H3Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7478
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


On 19-11-2026 09:17, Matthew Brost wrote:
> On Wed, Nov 18, 2026 at 01:38:30PM -0700, Summers, Stuart wrote:
>> On Mon, 2026-11-16 at 15:50 +0530, Arvind Yadav wrote:
>>> The memory CAT error handler uses the same cleanup path as the
>>> context-reset handler. This immediately triggers the TDR, which can
>>> send a scheduling-disable request before the context-reset
>>> notification
>>> arrives.
> So as below - a CAT error is immediately followed by an engine reset
> G2H?
>
>>> On a BMG dGPU, an early disable after a CCS memory CAT error is
>>> associated with subsequent contexts being enabled but never starting
>>> work. Recovery occurs later when a scheduling-disable timeout
>>> triggers
>>> a GT reset.
>>>
>>> Separate waking user-fence waiters from triggering the TDR. On a
>>> memory
>>> CAT notification, mark the queue reset and wake waiters without
>>> starting
>>> the TDR. Keep the existing cleanup triggered by the context-reset
>>> notification.
>>>
>>> Leave the uncorrectable-error and CGP context-error paths unchanged.
>>>
>>> Tested on a BMG dGPU using a standalone SYCL reproducer with two
>>> separate processes.
>>>
>>> The first process submits a kernel that reads an unmapped GPU
>>> address,
>>> causing a page fault followed by a memory CAT error. It then calls
>>> abort() without waiting for the kernel to finish.
>>>
>>> After that process exits, a second process, called "victim", starts.
>>> It submits a simple kernel that writes 7 to a device allocation,
>>> copies the value back to the CPU and checks the result.
>>>
>>> Without the patch, the victim can hang and reach its 60-second
>>> userspace timeout. With the patch, the victim completed and returned
>>> the expected value in all tested rounds where the first process
>>> triggered
>>> the fault.
>>>
>>> Recovery without a context-reset notification still needs
>>> confirmation,
>>> particularly for LR queues, which have no normal finite job timeout.
>>> Independent queue-kill and cleanup paths are unchanged.
>>>
>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>>> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
>>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>>> Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
>>> Assisted-by: LLM
> Fixes: ...
>
>>> Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
>> This isn't right... I'm not clear on what problem we're trying to solve
>> here. Is it that the engine reset happening after CAT error is taking
> I'm little unclear too. I haven't looked in depth - but are we saying
> every CAT error is also followed by an engine reset? iirc - that is some
> GuC klv option. If we always get a CAT error + engine reset G2H - this
> patch is generally ok, but TBH as with Stuart I'm a little confused what
> exactly the problem is here but Arvind appears to have data back to this
> up, perhaps a GuC or HW quirk. Assuming this some quirk, I'd say we get
> in this into the GuC spec if has programming flows section.
>
>> too long? And where is the schedule disable originating? If it's part
> The schedule disable originates from the TDR.
>
>> of the TDR that means we likely want to re-arrange the TDR sequence
>> rather than just skip it.
> Well the TDR can't signal any fences (this is the job of TDR) until a
> schedule disable returns to avoid any possible memory corruption which
> infinitely worse than a long hang as that can take down the OS.
>
>> Engine reset is required after a CAT error to recover and the driver is
>> doing that as part of this flow (vs an engine reset due to a preemption
>> failure which originates from GuC and the driver just reacts to that).
> Right, iirc we always get a engine reset after CAT error - but my
> assumption was schedule disable from the TDR was the source of the
> engine reset, not from the CAT error.
>
> So TL;DR, I think this patch is fine with a bit more explaination and
> possible GuC spec follow up.


Hi Stuart and Matt,

The issue in GSD-14189 is that the next application hangs after the 
faulting process exits. On BMG the first process hits a CCS memory CAT 
error. The CAT handler queues TDR and guc_exec_queue_timedout_job() 
sends a scheduling disable for the faulting queue.

In the failing trace GuC acknowledges the disable and deregisters the 
queue. It then acknowledges enabling the queue for the next process. The 
first job on that queue never starts. The process reaches its 60-second 
userspace timeout. During teardown the disable for this second queue 
times out and Xe requests a GT reset. The reset itself took about 13 ms. 
Most of the delay was spent waiting before the reset.

During debugging I found that the next process hung when Xe sent the 
first disable 11 to 18 µs after the CAT. In a round where Xe sent it 
1.5ms later we saw a reset G2H and the next process completed. I then 
delayed only the first disable by 5 ms and the next process passed all 
100 runs. In a separate test v1 also passed 100/100 with no added delay. 
It removed the immediate TDR kick from the CAT handler.

This points to the timing of the first disable. It does not tell us 
whether GuC had already started the engine reset or whether the disable 
triggered it. I have not confirmed that every CAT produces a reset G2H. 
I will check the order of the reset G2H and the first disable for the 
same queue and follow up on whether it depends on a GuC KLV.

I agree that a CAT alone does not mean the context has stopped. I will 
keep CAT pending separate from RESET and preserve the disable 
acknowledgement before TDR signals job fences.

Please let me know if you see a better way to handle this issue.

Thanks,
Arvind

>
> Matt
>
>> Thanks,
>> Stuart
>>
>>> ---
>>>   drivers/gpu/drm/xe/xe_guc_submit.c | 50 ++++++++++++++++++++++------
>>> --
>>>   1 file changed, 37 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c
>>> b/drivers/gpu/drm/xe/xe_guc_submit.c
>>> index d76f125f9c3a..aa382634a235 100644
>>> --- a/drivers/gpu/drm/xe/xe_guc_submit.c
>>> +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
>>> @@ -557,17 +557,39 @@ static bool vf_recovery(struct xe_guc *guc)
>>>          return xe_gt_recovery_pending(guc_to_gt(guc));
>>>   }
>>>   
>>> -static void xe_guc_exec_queue_trigger_cleanup(struct xe_exec_queue
>>> *q)
>>> +static void xe_guc_exec_queue_wake_ufence(struct xe_exec_queue *q)
>>>   {
>>>          struct xe_guc *guc = exec_queue_to_guc(q);
>>>          struct xe_device *xe = guc_to_xe(guc);
>>>   
>>>          /** to wakeup xe_wait_user_fence ioctl if exec queue is reset
>>> */
>>>          wake_up_all(&xe->ufence_wq);
>>> +}
>>> +
>>> +static void xe_guc_exec_queue_trigger_cleanup(struct xe_exec_queue
>>> *q)
>>> +{
>>> +       xe_guc_exec_queue_wake_ufence(q);
>>>   
>>>          xe_sched_tdr_queue_imm(&q->guc->sched);
>>>   }
>>>   
>>> +/*
>>> + * Allow callers to wake user-fence waiters without triggering the
>>> TDR.
>>> + * The memory CAT handler uses this to avoid starting cleanup before
>>> + * the context-reset notification arrives.
>>> + */
>>> +static void xe_queue_trigger_cleanup_for_reset(struct xe_exec_queue
>>> *q,
>>> +                                              bool trigger_tdr)
>>> +{
>>> +       if (exec_queue_banned(q))
>>> +               return;
>>> +
>>> +       if (trigger_tdr)
>>> +               xe_guc_exec_queue_trigger_cleanup(q);
>>> +       else
>>> +               xe_guc_exec_queue_wake_ufence(q);
>>> +}
>>> +
>>>   static void xe_guc_exec_queue_group_stop(struct xe_exec_queue *q)
>>>   {
>>>          struct xe_exec_queue *primary =
>>> xe_exec_queue_multi_queue_primary(q);
>>> @@ -653,7 +675,8 @@ static void
>>> xe_guc_exec_queue_group_trigger_cleanup(struct xe_exec_queue *q)
>>>          mutex_unlock(&group->list_lock);
>>>   }
>>>   
>>> -static void xe_guc_exec_queue_reset_trigger_cleanup(struct
>>> xe_exec_queue *q)
>>> +static void xe_guc_exec_queue_reset_trigger_cleanup(struct
>>> xe_exec_queue *q,
>>> +                                                   bool trigger_tdr)
>>>   {
>>>          if (xe_exec_queue_is_multi_queue(q)) {
>>>                  struct xe_exec_queue *primary =
>>> xe_exec_queue_multi_queue_primary(q);
>>> @@ -664,20 +687,17 @@ static void
>>> xe_guc_exec_queue_reset_trigger_cleanup(struct xe_exec_queue *q)
>>>                  WRITE_ONCE(group->banned, true);
>>>   
>>>                  set_exec_queue_reset(primary);
>>> -               if (!exec_queue_banned(primary))
>>> -                       xe_guc_exec_queue_trigger_cleanup(primary);
>>> +               xe_queue_trigger_cleanup_for_reset(primary,
>>> trigger_tdr);
>>>   
>>>                  mutex_lock(&group->list_lock);
>>>                  list_for_each_entry(eq, &group->list,
>>> multi_queue.link) {
>>>                          set_exec_queue_reset(eq);
>>> -                       if (!exec_queue_banned(eq))
>>> -
>>>                                 xe_guc_exec_queue_trigger_cleanup(eq);
>>> +                       xe_queue_trigger_cleanup_for_reset(eq,
>>> trigger_tdr);
>>>                  }
>>>                  mutex_unlock(&group->list_lock);
>>>          } else {
>>>                  set_exec_queue_reset(q);
>>> -               if (!exec_queue_banned(q))
>>> -                       xe_guc_exec_queue_trigger_cleanup(q);
>>> +               xe_queue_trigger_cleanup_for_reset(q, trigger_tdr);
>>>          }
>>>   }
>>>   
>>> @@ -3523,7 +3543,7 @@ int xe_guc_exec_queue_reset_handler(struct
>>> xe_guc *guc, u32 *msg, u32 len)
>>>           * jobs by setting timeout of the job to the minimum value
>>> kicking
>>>           * guc_exec_queue_timedout_job.
>>>           */
>>> -       xe_guc_exec_queue_reset_trigger_cleanup(q);
>>> +       xe_guc_exec_queue_reset_trigger_cleanup(q, true);
>>>   
>>>          return 0;
>>>   }
>>> @@ -3601,8 +3621,12 @@ int
>>> xe_guc_exec_queue_memory_cat_error_handler(struct xe_guc *guc, u32
>>> *msg,
>>>   
>>>          trace_xe_exec_queue_memory_cat_error(q);
>>>   
>>> -       /* Treat the same as engine reset */
>>> -       xe_guc_exec_queue_reset_trigger_cleanup(q);
>>> +       /*
>>> +        * Starting the TDR here can send a scheduling-disable
>>> request before
>>> +        * the context-reset notification arrives. Mark the queue
>>> reset and
>>> +        * wake user-fence waiters, leaving that notification to
>>> trigger cleanup.
>>> +        */
>>> +       xe_guc_exec_queue_reset_trigger_cleanup(q, false);
>>>   
>>>          return 0;
>>>   }
>>> @@ -3644,7 +3668,7 @@ int xe_guc_uncorrectable_error_handler(struct
>>> xe_guc *guc, u32 *msg, u32 len)
>>>          trace_xe_guc_uncorrectable_error(q);
>>>   
>>>          /* Treat the same as engine reset */
>>> -       xe_guc_exec_queue_reset_trigger_cleanup(q);
>>> +       xe_guc_exec_queue_reset_trigger_cleanup(q, true);
>>>   
>>>          return 0;
>>>   }
>>> @@ -3696,7 +3720,7 @@ int
>>> xe_guc_exec_queue_cgp_context_error_handler(struct xe_guc *guc, u32
>>> *msg,
>>>          trace_xe_exec_queue_cgp_context_error(q);
>>>   
>>>          /* Treat the same as engine reset */
>>> -       xe_guc_exec_queue_reset_trigger_cleanup(q);
>>> +       xe_guc_exec_queue_reset_trigger_cleanup(q, true);
>>>   
>>>          return 0;
>>>   }
