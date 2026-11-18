Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8252606A336
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=O3elm7Gj;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=edrTfRx3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2703610E769;
	Wed, 18 Nov 2026 12:38:03 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAAD610E769;
 Wed, 18 Nov 2026 12:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795005472; x=1826541472;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=pukie6f6bBm/YGWJgUrIHDPCwBmgxNAfjGVgK2l0lc0=;
 b=O3elm7GjfpZxc68w3IOMWGS7iTlOu/N9PrZQ0+9Qw6cFD45+JebgXUip
 QO7X6n4nDRxuzxuX5p2NCkvJph6ivzjYRJQZM6z5l9W80S83Op1iX2r7Q
 CFVv/jkB1XRR7Ej6a8goR251vyzyTV61vSJ/C3xUxwXIK8PCUNnqEi5k8
 yQRJmNiHeclv2BKECI0F713fxjBBmj+ATWoDuvLYFqUf8L5Odel9RaBHs
 ROwFGJ/FPzsxCbTmbo/C+bfjWqnA5lJVifFPK0PP+i2DVPwjZZyFhJDVX
 jlOQ3LrBi/jmdZ7e1S28yWb8OtRHWujsvT9JN0J9zZZV3tV4C/jK9XmV2 g==;
X-CSE-ConnectionGUID: eKpAVVXmTeecJEAcxyApcA==
X-CSE-MsgGUID: U3xvd97/ReK/Bgzmj/H6HA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3693225"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3693225"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 04:37:52 -0800
X-CSE-ConnectionGUID: JV+xnt/DTvS7CG4hUHIzQQ==
X-CSE-MsgGUID: hU/eTXJoSdyaSI2oIJKYLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10531614"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 04:37:52 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 04:37:51 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 04:37:51 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.22) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 04:37:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4RGmz3csxVrUYYiR0oIbQW7rmTkWDrHIXj2sJBjnvAZ6Max1zyeXJ5psUiBDjNZ/a71ZI7G8rCCMoCCtC0ofghIIr5tZlCaonbkrWd+C00+87FchlZ/xcTiPYnCMxCBAgl42uGd+tH4MLt7mOPm7S4WcB7BEXVnSVm/dH78xbh5gCJJYJ0HltHhAuMeEKNiD9/RpAxKk/+9KmRLwEX2v8mFZImBATyA8Z3npqvTQyB+jNX70y4N9i2JF22yO7qnXT6Wb5z2LDo10dYS6y6PEgz1C+dtFP2Kdq+Hu2+A/Sd4KxUIezkHGnHhDTuPT2CxeEN1UGl0E0DZOMgNpHcIvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pukie6f6bBm/YGWJgUrIHDPCwBmgxNAfjGVgK2l0lc0=;
 b=ErIiCwZJ88xLxT74TpaQWbNZaJMp7qSJTc45MoaHIaLHe6u9YHIDNIqlisQIdU0IjvGG7uA216tGUWkKPtpXxlbDUxAHzqItlO9HRXo9A63WR8YDgDghVkdvxJcyIFlFo7UasPCHwZH0WXziNXNX52PhXKAuSkez823z2sJsqxG+fBlvYH7eOfQ/AZD8fnIg/FHpi0i2ByBuygT6R2Hwq6Bc0qdMyxSUfV1yMCPGpbp9luOUnIpZJUQQKLFvLM1uCfYkaH7YFB1w8bV8eE6ICmeOvJxRAI8/xLGDB5glDb0nvNduWlArmGBi92bVxeSmJlmirkMczaUrA8YtIOsUnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pukie6f6bBm/YGWJgUrIHDPCwBmgxNAfjGVgK2l0lc0=;
 b=edrTfRx3xpWHzoz5vh5OtnCCEcrVeGsXgrHLecWXNPCkXBloFlz9Wf2i42DulRr0PdEAxR21gunlR+7FD/d04s6ZwNZ0sRkg5F2ZUX6ji0jzC8Qy12UzU9KyK8oul8EHTosXgrJ94fmNknojwDETJhAfhYEgQFNvof6sOcoe4Ds=
Received: from LV2PR11MB6024.namprd11.prod.outlook.com (2603:10b6:408:17a::16)
 by BL1PR11MB6004.namprd11.prod.outlook.com (2603:10b6:208:390::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 12:35:47 +0000
Received: from LV2PR11MB6024.namprd11.prod.outlook.com
 ([fe80::38ad:3190:bbb2:412b]) by LV2PR11MB6024.namprd11.prod.outlook.com
 ([fe80::38ad:3190:bbb2:412b%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 12:35:47 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Manna,
 Animesh" <animesh.manna@intel.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>
CC: "Kandpal, Suraj" <suraj.kandpal@intel.com>, "Nikula, Jani"
 <jani.nikula@intel.com>
Subject: Re: [PATCH v7 13/20] drm/i915/alpm: Program LTTPR count for DP 2.1
 ALPM
Thread-Topic: [PATCH v7 13/20] drm/i915/alpm: Program LTTPR count for DP 2.1
 ALPM
Thread-Index: AQHdZQyUw07JkJdk6UqJync1mejcQrcz6JCA
Date: Wed, 18 Nov 2026 12:35:46 +0000
Message-ID: <29afc763f4bf8e9b44eac7bfb1e4c77c2c8d3a4b.camel@intel.com>
References: <20261026054001.799894-1-animesh.manna@intel.com>
 <20261026054001.799894-14-animesh.manna@intel.com>
In-Reply-To: <20261026054001.799894-14-animesh.manna@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6024:EE_|BL1PR11MB6004:EE_
x-ms-office365-filtering-correlation-id: fe30704e-7153-4669-224e-08df45707884
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|261102123227099003|38070700021|56012099006|4143699003|11063799006|261026140227099003|10067099003|261028144727099003|261021123027099003|261022105027099003|261022075727099003|261021121427099003|261009223027099003|18002099003|22082099003;
x-microsoft-antispam-message-info: RrL/2kK/JfcjsQ/DiFW8VH2723KiZsZEwaVar2n/ccCZz7+VK+0N7T2VpLus9iTwwne0poHo/qFkTj55EI9OvnnpsGxgj0ui+11fUUAB4VjJJFe34zp6IzvCu/J/TT4qew8NwfcTr111kMszOP6KKBNceUe/xKl4xKZCM0bMuRaqmndUzqeupUEDPvAlfgpGCtT2z3+Daoephcsd1275HA+vYDN9S+v2wYILjKbdmLldnuUd0KMJtaVgdtWp+T+ds0vaTlwR/+VCAUF+ir85mDsxNZqBDT5cFm6C3yu3aajnCKZNds8wE4nvUKi85KqlDc7ccRiH0qraSa9gqA+LNLMWXhdAmxoSnv9LQdVOykYB80XB7C4jamvpaBhm02qOkSo98fbTHM9tTf4TM8YOGsDBUEld/54eECx7C3wHkGI/N7aWPBeWYB4Z0mZBExJ/MS1js98+EGcYyRMkrpJttC2Ko0e0y5R7r0ZrFJaZ/3aJ0OKZhTGZPvr2ETxSQSvS3m13dNvr5c7JyQpuQECllEg8FSYXjCjzut/oOBKLUS/RY64xPWMhwOoMVfdzAIBVRwjif+9kXQEDExYoXH3pibwfSgXADkRG3q8y1mtmq0T9rXRzMVFDIYO9JbRFyl0NA93ALDXmHu3S/cbxZ3VsskGFmCfmlGUfm0Zg1dQuuPOOdjBDWN7X4xqEMcVNPXF5rRIY7xFpS6RMjKnpeA/Dc1YtjcJjawPUsTOx3qMjHaI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB6024.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(261102123227099003)(38070700021)(56012099006)(4143699003)(11063799006)(261026140227099003)(10067099003)(261028144727099003)(261021123027099003)(261022105027099003)(261022075727099003)(261021121427099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXZOd3c3cXZ2OFFvaWIvM1ptMVgvN0NpUVZOSWN5NFpGT3hWWS9CSFJXMW4v?=
 =?utf-8?B?YnR3ajRQTUxtZzY0Sm1xVlBaaVhkaTRzdVcrcU5VQnJNdjNYRHQ1QTVrQVVN?=
 =?utf-8?B?VmFXUmE0TUlNYWNZdStYUmhpN1Vpc1BpU1ZFSHBJUHJ2NThzd0FjeHBIY2s0?=
 =?utf-8?B?WURXRm5qbFB2Yk0yTkdkRXBmYzRsTVBCTkE1TjF6U3d2V0VmeldIVHNYNjBX?=
 =?utf-8?B?aGp6SlhtNWlPakc2Mzl4bE9BMnJXdFRVenkvMzF6QmJXVi9nWnRySDh1QXpC?=
 =?utf-8?B?RG1RRERGdkp5YlBNTjFXOWt1ejBRQmlsMjFwa2JteHVTT0ZTSThyL2xUajll?=
 =?utf-8?B?KytycFE5MUZwQ3Jrcm9XOHRhRWZoNGU3SHVwbkRiV2hJOVlydW9RZU1zK1E5?=
 =?utf-8?B?c01vdWtKZHFZb0NtVnhOVlBwajFzbzJSSFgvanpXTnUzUE8zNjRQL3RNcGhT?=
 =?utf-8?B?TUtHZXZVRHZLWEZKQTd4QXcxUWV4YmxiOGhKazRtK2dsVnNLdlJzUTc1WDVm?=
 =?utf-8?B?ZzBaUmhpTE1HUVhJRjl0ejRYY3U3WmZWVkUzazZOU1NGRXQ4bEIwemdiSElj?=
 =?utf-8?B?dHpyTmo1eDUxNVZxV2lFa3lGR2VzR2xoWWwvd01OUEZScjNCRUVZNXBBUkJM?=
 =?utf-8?B?bytraWI3bjdPbi96L3JnZDNvVERBUWNwakZvaTFkVEl0WG5ndVZZbzF6RjNv?=
 =?utf-8?B?S01EYkFHREpYcWJCSWc4QUpMT3lxVWt4TFdlV2VWTFVnQTJSZ2t0SWhzd0dP?=
 =?utf-8?B?K0lsMThReTdiU0w4eUhzNEx1dUx0eXBQeCtXVHk5aGIzQkhJRFRUVXNqK0RV?=
 =?utf-8?B?MStQUFVVN1V0QURGQ3c2RkNSNGpQcTEybmhWWDZvWXA0STJyUEF5aEU5S2RB?=
 =?utf-8?B?bnRyYWJqcGNVUkh3Nm44ZU5Ia2twRC82Ym5jdzFWUWpFV1JrS0VlUlBxQ2hG?=
 =?utf-8?B?RU1hZFJ6OUMxUkdYa1grL2ljV3QwTTZQQ0xjK0tHdWZyWExXOWNDR0R5Wit2?=
 =?utf-8?B?TUg0WUJTUlVmMEVZWDlHV1d4Wko1TzNEK1Yzd3dPT2cvUlpMNkZ4V0dnSVNy?=
 =?utf-8?B?REdoeUxldEFDbUFzQ2d4M2tNRm1yZExEcmhFbDI2Y1NOLzIvL3JyNTBBZlBG?=
 =?utf-8?B?T2psOE01U002eGZGa3ROSW50ZGM2SHVQNGNKR3Q0VlRQRlpVMWJKWFFYdmVo?=
 =?utf-8?B?R0FuWmV5WTFncUpXNUhqb21OdFpYdTZ5NThEQTlwK1VuNFVzY05NdzYrd3BD?=
 =?utf-8?B?b3JBeWYrRE5MM0s1MEl4TStqV1lNb2xldGE5R29TZ2RZWVRpeTdVZWNPYWh0?=
 =?utf-8?B?QmJKbnEyNGovMTBpa3RFR0NHTllVaFVnODQrOWFUbjJhV2VUNUJhbUZpOGNk?=
 =?utf-8?B?VXp0NW9kdG00NWxCZ0had0l5Zkt3bkpYVzluM1hvcHl6dy94dHE0ZE9aUzZm?=
 =?utf-8?B?MDl1WlR6ckJEVDIzclJPYkZEUUJkRjVyeDQxU2FRUmd5YlozVGE2ZVBVTTZN?=
 =?utf-8?B?VGFmSnVXbGlWdzBCZE5yeWZ2TXVKVEN3OFI5OFVFVjBkZlEyUG5jaVQwUDVz?=
 =?utf-8?B?RnNRTzlScG9OSnF2Rkg2QVdxb0cxcHhwbHlsZWlyUUZ6VDZITUJFTy85aXhh?=
 =?utf-8?B?UnpxVlhHWHdZc01BNUtNL1pERlA0TU5XWk1ncHVXcW8zd1dPME9samZmZ3Fi?=
 =?utf-8?B?RWpTOU9ndEQ0ai93Z3RBUGZhNjVFamhvZ3VkSWVhSld0ell6TGtHcjR1c0NE?=
 =?utf-8?B?cjNtaGk2SzBHQktCajBvUVFwTXV6aENUS25FTWRLeDVCSzJ0SGs5bHJxNTR6?=
 =?utf-8?B?bDY2QWpnRTRlV0xFZkljbFBqWDdnVWZKWWl3YnpEQWwzZ0xkUEM1SUFvRS9R?=
 =?utf-8?B?SjVyTUZwS3hvUGozc2VvMk1icFdaaytPUU0zQ2laY29OMW43NzROTFE3YU93?=
 =?utf-8?B?MHFna3JEVFdBdEpSZWhULzNzcUUxcjVCb0ZKejUwZUlvcDMzTW9HVGNPeERH?=
 =?utf-8?B?SC8vVjkwNHg4MVdTUldmZ2U4a3crSVBCQUlUT04xT2MyTVJsSUlMaXRNUmxN?=
 =?utf-8?B?M0pWYUkrWVNLRUlrejdTZ0hvZzJJM1pRWTByWWNucUxScjd4aE1ld0l5OTE0?=
 =?utf-8?B?T01NNTBraEsvTnRYSUxlMHZDaEI0Nkp5a2VvWENXa1NQWWlTU28xb2l1MEEr?=
 =?utf-8?B?dDJvWWhyTnY3UWxkeEN3M3RsN0h4TkVjTTdEdFBuTnJsaGh2aG42VUpucnh4?=
 =?utf-8?B?YmxtUmwwM0w3anNLTmsxZHRONkluaFE5bWZ0R1dDaHc3Z1pZb0FNWnFpdTlq?=
 =?utf-8?B?SDRjSDZCc1Npcy9sLzlHYWwzZ0hJMStGZVE1MGM4d0QzakJHNkMvVzZDaDda?=
 =?utf-8?Q?wjtB4GrvDar/J8TA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <16234B901B100C4BA335AE935C3471DA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: xNnADm94KFslk3ByCPCQTLSffKrl44i9teyHgt78Yw+S0Mq/6oPMReGGiH28Au3lZb9QWgBPqIh86Hl4aLkyhpCge52RsiojpFDKHKAK1vfcKB0WezbCfK9BAyeNYxczznG54ItQKxOhadna0rjUMhKY5sI9mOghSlmmb0nTBDqLkQhA18FncWWpcY0VngLRVzQuhlPTzn55jWdAsPJuK3ioPdYCOu+POKQKwD9FQsxjiXv+yxlPVz4MejTEJp00quid9fPbe0+owEXeTMCXsaSciCSXyZBgtwbkAKNi2XbZpplHRHQ++CTCNjhSki/v2wai4KxQKN5XJHGfvOzpug==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe30704e-7153-4669-224e-08df45707884
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 12:35:47.0102 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OPuJt2UB5Q17lRT29mpWgLLb3lTtGGHbhdC6uBKxu90EPfmcA+MXpMZgrwb7dI/+SZSYWjP0Hj+AYN5dwKuw+uFwVxUiUPowrRA8I/PjXXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6004
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gTW9uLCAyMDI2LTEwLTI2IGF0IDExOjA5ICswNTMwLCBBbmltZXNoIE1hbm5hIHdyb3RlOg0K
PiBJc3N1ZSBhIEFVWCB3cml0ZSB0cmFuc2FjdGlvbiB0byBEUENEIERQX1RPVEFMX0xUVFBSX0NO
VCAoMHhmMDAwYSkNCj4gd2l0aCB0b3RhbCBudW1iZXIgb2YgTFRUUFIgYmVmb3JlIGxpbmsgdHJh
aW5pbmcuDQo+IA0KPiB2MjogQ29zbWV0aWMgY2hhbmdlcy4gW1N1cmFqXQ0KPiB2MzoNCj4gLSBV
c2Ugc2FtZSBlbmNvZGluZyBmb3JtYXQgZm9yIGx0dHByX2NvdW50LiBbSm91bmldDQo+IC0gQXZv
aWQgcmVhZGluZyBhbHBtX2N0bDIgcmVnaXN0ZXIuIFtKb3VuaV0NCj4gdjQ6DQo+IC0gUHJvZ3Jh
bSBEUF9UT1RBTF9MVFRQUl9DTlQgb25seSBmb3IgRFAsIG5vdCBlRFAuIFtKb3VuaSwgc2FzaGlr
b10NCj4gLSBEcm9wIHJlZHVuZGFudCBsdHRwcl9jb3VudCBjaGVjay4gW0pvdW5pLCBzYXNoaWtv
XQ0KPiAtIENoZWNrIGRybV9kcF9sdHRwcl9jb3VudCgpIHJldHVybiB2YWx1ZSBiZWZvcmUgcHJv
Z3JhbW1pbmcNCj4gwqAgQUxQTV9DVEwyLiBbSm91bmksIHNhc2hpa29dDQo+IC0gRml4IExUVFBS
IHJldmlzaW9uIGNoZWNrIHRvIG1hdGNoIHRoZSBjb21tZW50LiBbc2FzaGlrb10NCj4gLSBVc2Ug
ZHJtX2RwX2RwY2Rfd3JpdGVfYnl0ZSgpLiBbSmFuaV0NCj4gDQo+IENjOiBKb3VuaSBIw7ZnYW5k
ZXIgPGpvdW5pLmhvZ2FuZGVyQGludGVsLmNvbT4NCj4gQ2M6IEphbmkgTmlrdWxhIDxqYW5pLm5p
a3VsYUBpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEFuaW1lc2ggTWFubmEgPGFuaW1lc2gu
bWFubmFAaW50ZWwuY29tPg0KDQpSZXZpZXdlZC1ieTogSm91bmkgSMO2Z2FuZGVyIDxqb3VuaS5o
b2dhbmRlckBpbnRlbC5jb20+DQoNCj4gLS0tDQo+IMKgZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlz
cGxheS9pbnRlbF9hbHBtLmPCoMKgwqDCoCB8IDEwICsrKysrKysrKy0NCj4gwqAuLi4vZHJtL2k5
MTUvZGlzcGxheS9pbnRlbF9kcF9saW5rX3RyYWluaW5nLmMgfCAyMA0KPiArKysrKysrKysrKysr
KysrKysrDQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRl
bF9hbHBtLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0uYw0K
PiBpbmRleCBmM2MwODg0OTg5Y2UuLjgzMWRmYTVlNjc3YiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9hbHBtLmMNCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9hbHBtLmMNCj4gQEAgLTY4Nyw3ICs2ODcsOCBAQCBzdGF0
aWMgdm9pZCBsbmxfYWxwbV9jb25maWd1cmUoc3RydWN0IGludGVsX2RwDQo+ICppbnRlbF9kcCwN
Cj4gwqB7DQo+IMKgCXN0cnVjdCBpbnRlbF9kaXNwbGF5ICpkaXNwbGF5ID0gdG9faW50ZWxfZGlz
cGxheShpbnRlbF9kcCk7DQo+IMKgCWVudW0gdHJhbnNjb2RlciBjcHVfdHJhbnNjb2RlciA9IGNy
dGNfc3RhdGUtPmNwdV90cmFuc2NvZGVyOw0KPiAtCXUzMiBhbHBtX2N0bDsNCj4gKwl1MzIgYWxw
bV9jdGwsIGFscG1fY3RsMjsNCj4gKwlpbnQgbHR0cHJfY291bnQ7DQo+IMKgDQo+IMKgCWlmIChE
SVNQTEFZX1ZFUihkaXNwbGF5KSA8IDIwIHx8DQo+ICghaW50ZWxfcHNyX25lZWRzX2FscG0oaW50
ZWxfZHAsIGNydGNfc3RhdGUpICYmDQo+IMKgCQkJCQnCoCAhY3J0Y19zdGF0ZS0+aGFzX2xvYmYp
KQ0KPiBAQCAtNzI1LDYgKzcyNiwxMyBAQCBzdGF0aWMgdm9pZCBsbmxfYWxwbV9jb25maWd1cmUo
c3RydWN0IGludGVsX2RwDQo+ICppbnRlbF9kcCwNCj4gwqANCj4gwqAJYWxwbV9jdGwgfD0gQUxQ
TV9DVExfQUxQTV9FTlRSWV9DSEVDSyhjcnRjX3N0YXRlLQ0KPiA+YWxwbV9zdGF0ZS5jaGVja19l
bnRyeV9saW5lcyk7DQo+IMKgDQo+ICsJbHR0cHJfY291bnQgPSBkcm1fZHBfbHR0cHJfY291bnQo
aW50ZWxfZHAtDQo+ID5sdHRwcl9jb21tb25fY2Fwcyk7DQo+ICsJaWYgKGx0dHByX2NvdW50IDwg
MCkNCj4gKwkJbHR0cHJfY291bnQgPSAwOw0KPiArDQo+ICsJYWxwbV9jdGwyID0gQUxQTV9DVEwy
X05VTUJFUl9PRl9MVFRQUihsdHRwcl9jb3VudCk7DQo+ICsNCj4gKwlpbnRlbF9kZV93cml0ZShk
aXNwbGF5LCBBTFBNX0NUTDIoZGlzcGxheSwgY3B1X3RyYW5zY29kZXIpLA0KPiBhbHBtX2N0bDIp
Ow0KPiDCoAlpbnRlbF9kZV93cml0ZShkaXNwbGF5LCBBTFBNX0NUTChkaXNwbGF5LCBjcHVfdHJh
bnNjb2RlciksDQo+IGFscG1fY3RsKTsNCj4gwqAJbXV0ZXhfdW5sb2NrKCZpbnRlbF9kcC0+YWxw
bS5sb2NrKTsNCj4gwqB9DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNw
bGF5L2ludGVsX2RwX2xpbmtfdHJhaW5pbmcuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rp
c3BsYXkvaW50ZWxfZHBfbGlua190cmFpbmluZy5jDQo+IGluZGV4IGFjMWFmZjZlZGYwNS4uMGRi
YzYxNzRjNDAyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2lu
dGVsX2RwX2xpbmtfdHJhaW5pbmcuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNw
bGF5L2ludGVsX2RwX2xpbmtfdHJhaW5pbmcuYw0KPiBAQCAtMjI3MSw2ICsyMjcxLDI0IEBAIGlu
dGVsX2RwXzEyOGIxMzJiX2xpbmtfdHJhaW4oc3RydWN0IGludGVsX2RwDQo+ICppbnRlbF9kcCwN
Cj4gwqAJcmV0dXJuIHBhc3NlZDsNCj4gwqB9DQo+IMKgDQo+ICtzdGF0aWMgdm9pZCBpbnRlbF9k
cF91cGRhdGVfbHR0cHJfY291bnQoc3RydWN0IGludGVsX2RwICppbnRlbF9kcCkNCj4gK3sNCj4g
Kwl1OCB2YWw7DQo+ICsNCj4gKwkvKg0KPiArCSAqIFByb2dyYW0gb25seSBmb3IgRFAgYW5kIHJl
dHVybiBpZiBMVFRQUiByZXZpc2lvbiBpcyBsZXNzDQo+IHRoYW4gMHgyMA0KPiArCSAqIHdoZXJl
IDA6MyByZXByZXNlbnRzIG1pbm9yIHJldiBhbmQgNDo3IHJlcHJlc2VudCBtYWpvcg0KPiByZXYN
Cj4gKwkgKi8NCj4gKwlpZiAoaW50ZWxfZHBfaXNfZWRwKGludGVsX2RwKSB8fA0KPiArCcKgwqDC
oCBpbnRlbF9kcC0+bHR0cHJfY29tbW9uX2NhcHNbMF0gPCAweDIwKQ0KPiArCQlyZXR1cm47DQo+
ICsNCj4gKwl2YWwgPSBpbnRlbF9kcC0+bHR0cHJfY29tbW9uX2NhcHNbRFBfUEhZX1JFUEVBVEVS
X0NOVCAtDQo+ICsJCQkJCcKgDQo+IERQX0xUX1RVTkFCTEVfUEhZX1JFUEVBVEVSX0ZJRUxEX0RB
VEFfU1RSVUNUVVJFX1JFVl07DQo+ICsJaWYgKGRybV9kcF9kcGNkX3dyaXRlX2J5dGUoJmludGVs
X2RwLT5hdXgsDQo+IERQX1RPVEFMX0xUVFBSX0NOVCwgdmFsKSA8IDApDQo+ICsJCWx0X2RiZyhp
bnRlbF9kcCwgRFBfUEhZX0RQUlgsICJGYWlsZWQgdG8gd3JpdGUgdG90YWwNCj4gTFRUUFIgY291
bnRcbiIpOw0KPiArfQ0KPiArDQo+IMKgLyoqDQo+IMKgICogaW50ZWxfZHBfc3RhcnRfbGlua190
cmFpbiAtIHN0YXJ0IGxpbmsgdHJhaW5pbmcNCj4gwqAgKiBAc3RhdGU6IEF0b21pYyBzdGF0ZQ0K
PiBAQCAtMjMxMCw2ICsyMzI4LDggQEAgdm9pZCBpbnRlbF9kcF9zdGFydF9saW5rX3RyYWluKHN0
cnVjdA0KPiBpbnRlbF9hdG9taWNfc3RhdGUgKnN0YXRlLA0KPiDCoA0KPiDCoAlpbnRlbF9kcF9w
cmVwYXJlX2xpbmtfdHJhaW4oaW50ZWxfZHAsIGNydGNfc3RhdGUpOw0KPiDCoA0KPiArCWludGVs
X2RwX3VwZGF0ZV9sdHRwcl9jb3VudChpbnRlbF9kcCk7DQo+ICsNCj4gwqAJaWYgKGludGVsX2Rw
X2lzX3VoYnIoY3J0Y19zdGF0ZSkpDQo+IMKgCQlwYXNzZWQgPSBpbnRlbF9kcF8xMjhiMTMyYl9s
aW5rX3RyYWluKGludGVsX2RwLA0KPiBjcnRjX3N0YXRlLCBsdHRwcl9jb3VudCk7DQo+IMKgCWVs
c2UNCg==
