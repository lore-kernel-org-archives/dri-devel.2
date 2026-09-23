Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A83CC9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 16:01:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70A3610F134;
	Wed, 23 Sep 2026 16:01:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OJAZIuNj";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67F2410F134;
 Wed, 23 Sep 2026 16:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790179305; x=1821715305;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZfUF4MV/8fnnH+i0LwKOXWj92WF6xPYKX4h91RUHnw4=;
 b=OJAZIuNjgbRwVg2aZZ+2qk7lrV9UisSpErM9svaxU24rzUNbuaE/fMqg
 L7NU4hW0+Z1OTEVgaFQ8rSO2SC/FGQajV6i2vSPani7CiXHbvyy+oOtH5
 BQaBy0I+U2fUYGgVk21kR5Lm4kzgSB4/+KRGVHab6timtAfqR0H3V+EG/
 WWfqP1gqu0uK+EqT2tD3oL+eje6A1SxHfVZ2Er9G2j8ZPsuALeaW5g27o
 r92lEzGgizlAuuk9KXBPL8q5TltZyV1Pa8xMLlPVhENet3OJ6jyzjFfTr
 lP3zlLSpqPoYJw2yOTosLWFmOglItR9o6ycyUoZXVcB27+h++TI2Gm1FJ g==;
X-CSE-ConnectionGUID: IMSPC16QQHW/Q00IUryqOw==
X-CSE-MsgGUID: ITNRRfCPQjyAQo4iiExO0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="93393114"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; d="scan'208";a="93393114"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 09:01:44 -0700
X-CSE-ConnectionGUID: FZIVAt4VToOivFfiFIQPMw==
X-CSE-MsgGUID: hjEU4roDS96nOBIJ8ptWZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; d="scan'208";a="301606111"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 09:01:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 09:01:43 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 09:01:43 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.26) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 09:01:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o25/junDNVYcyPJGotuaw8KVysyHDQbdK51+/YMXmyv6v7nSvLQq9zFbIQDgBC0ajH0fCfflE4hk/j1JtVDvQskjPi4piivU4ZC5CiZuy8/eaWSSxPi3QnKou6DNqh7+0sUr3E0MSdx4XEnbI4/Ji3TmMPpX/SiRsh1vXp8IXJ9GFM4PKxmSCnUM9qJuEjmGWUUWmlX0A2V6YzzUzjyp/osEN+GafYWpkhoQVaHORSa6M3JdtRoO8kWr7Gt7JmVbo8+mpoGTsKV8729pywDVChSaR0jSVGrFxqv3RgEVO3OZv6pCI17SZwt4/54odiY8+VRepcOT8Jbm69AfoZKk5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfUF4MV/8fnnH+i0LwKOXWj92WF6xPYKX4h91RUHnw4=;
 b=C35txe/eXszUefIKon7aeA4RTmRRyuimtbdJqSCBDWS/T7OdILbGRFojk7u6/vIUSWGXa9QMuwq6bondmHN/+ZkBmeXs08akQ/LTLBMyrm3ujovwMq4C2Y3iQKDY9asZdOLVWLmu1DNGl/WdYIQFnmF4qGlLO/BxCpLby6FPkbNKeNlRB8/HhRYY3oBiojSDzw5Xww1IIJWGAqgdi/QNJX27CjR0r3l7MMJXG16z3X4ZVpB7kKUOK7TDqT7hfCKeeKcxbYdzVoHdlQYj4k72yCx7a805Wo5Mp5HPL7HMkr3kzB5kwPWQSvigFad/E8Z/+m9g+LP3meSS/DqprSxRjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8040.namprd11.prod.outlook.com (2603:10b6:510:238::11)
 by PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 16:01:34 +0000
Received: from PH8PR11MB8040.namprd11.prod.outlook.com
 ([fe80::89bf:2274:1371:50c5]) by PH8PR11MB8040.namprd11.prod.outlook.com
 ([fe80::89bf:2274:1371:50c5%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 16:01:32 +0000
From: "Yao, Jia" <jia.yao@intel.com>
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 "sashiko-bot@kernel.org" <sashiko-bot@kernel.org>,
 "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Roper,
 Matthew D" <matthew.d.roper@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>
Subject: RE: [PATCH v9] drm/i915/dg2: Add per-context control for
 Wa_22013059131
Thread-Topic: [PATCH v9] drm/i915/dg2: Add per-context control for
 Wa_22013059131
Thread-Index: AQHdCOF1lbPxpopA/0itXMF8igkPpbZXtN2AgADdC4CAAE7mgICA67EggADd+4CAAH5VAIABFYaAgACQNQA=
Date: Wed, 23 Sep 2026 16:01:32 +0000
Message-ID: <PH8PR11MB804034417C9C4625B7F20F2BF4822@PH8PR11MB8040.namprd11.prod.outlook.com>
References: <20260630223946.2107382-1-jia.yao@intel.com>
 <20260630225349.984AB1F000E9@smtp.kernel.org>
 <178290749714.224587.15234445443946207851@jlahtine-mobl>
 <178292444166.273574.16738251742448073960@jlahtine-mobl>
 <PH8PR11MB8040EFAAE8210F2C6B53AC1BF4842@PH8PR11MB8040.namprd11.prod.outlook.com>
 <179005959984.27165.4749331452130832177@jlahtine-mobl>
 <PH8PR11MB8040A8F215B997982530CE44F4832@PH8PR11MB8040.namprd11.prod.outlook.com>
 <179014632773.19856.4107893493544612438@jlahtine-mobl>
In-Reply-To: <179014632773.19856.4107893493544612438@jlahtine-mobl>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: joonas.lahtinen@linux.intel.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB8040:EE_|PH7PR11MB6605:EE_
x-ms-office365-filtering-correlation-id: a48d41d5-049a-4043-4155-08df198befe4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|42112799006|376014|10067099003|11063799006|6133799003|22082099003|18002099003|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info: yUWoF0e1Bu+oab+0T9FC6qdQIosPP3l32JljBF/07pTv13E8UQwkXR3wHK7tYJwVruSwatWln6j2idhtJJVCE2zC9r2FkQGJahZWbIK0vpGwDSo2zFer3vlCTnXFdywEbmcOLhZBrcUYRFb3NRf9sxR6Ed8YhBOah8Ps6cMZ1wZ+5UPJirWF3Ao2DUh85zkoVoUUdKO7Fg4Xc9amZWmvRvZBhrRQIZe1frvPVLx3glxHmSlsGK6BEahhwuInm+K2Ux39ow8ETq1t7QsFHcVsRnbYTb56ucY0QxPK9oVQj1FriKIUuD39DxQsT8k3YvjXKZuG6nu2RMmNqEYAhFsRZAC/8pLBvGCDE7nt1YiTDKEmuWIUuHGqBnkih7x6xad164MiY/Pd+EX8ppXxzkRK4s1qNW7HMYP/ygr+1NZYhG1TLUSbrNGYlbu2qr9m6BJLq/8F+C1n9/YtmR1zoz1DUD3kUPGkcxHO/+Tpv+ToEe0/RKj8DjupZxNXeVuwdMLqLHWehd2hxQJOIznf+gKpqZLt2q+g+WSyFuumwzgWwqizod/imzmqDmdTzd8HlNHtSwQANe/HOzpMY6eF90eETuXusOzjNIL8nct8Puav0bZaURQGlgS90YJVYses3p8HH7+nPomQGdQflwVquYnpSdgIj+ABsUMbU7V0pUvEvABZRMJbxoFdr/ov00Epg1RCWC1m3cojrVaIGPTNohTUlVMl3j1D+i4+sWFJTgFohZw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB8040.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(42112799006)(376014)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekxKb2Nqak5xWTYzWE1qcC9aT1ZOc3lYanhRWEtWZStTaEx2cy9qMTJ6SzRE?=
 =?utf-8?B?ZUFmV3lzK2tCTi9qVTdvMXlqSGFUTjcxUVdGKzVsRkoyM1NrSmFHOEZsc29a?=
 =?utf-8?B?amdvYlFvMGY1RHhnWk9lQjNkWUd3WkRvTzEwUVNaY2tsVWV0TzZCR1dncU51?=
 =?utf-8?B?QldwcS9MbC9rZnh6T2JMVE5EZXdiZTFaaVdEVEVhVVM3MktBL3dHY2pnMnpQ?=
 =?utf-8?B?Ymw5bElIUVA3SEVYL0NBOVdlMVdNKy9aWlh5M1A4MVVEWGEwd3dxZ0pNNjAw?=
 =?utf-8?B?VlVocjlSaE5FeWF2T1VMcm9ReXRjWk1LeEZrbFVvdy9mVFpJVHo1UU9RMmRV?=
 =?utf-8?B?ODFZYVMwTlMxSzdOUTV1WXpJYUkwNEo1R0VNanFzcklJL01SNkFuN2xFdWpB?=
 =?utf-8?B?Q043MzJJeVdYS0h4QjdkVVVaelE1NGZXMmNYdG55dmExNUE5VTBZbG5tUGRV?=
 =?utf-8?B?ajRjSXZFU05iUjEwcU9NUTRpaGs2aHFRcVRBNE9MMTAxUlEyNFNLb2FUS1Iw?=
 =?utf-8?B?cEQxeTVlWVdMc211d2ZWSlFGTTRRUWVRL0F5MW11ejJTbVVUSGJHc0w2NHhR?=
 =?utf-8?B?YzhtK3VqejQ4QmZCOVRuN3BNVStGOGJrYWkrY0o3SGRYekJsREdFdU5oZjE1?=
 =?utf-8?B?ZVd4bVlqRXFCSVpSc0JlTFo4VE42WXpVV1grdmJ4R3BFbWFYTzZaU0d5Uksy?=
 =?utf-8?B?d2RVSHVqTUZZaFA1WnhHTDJHcFVBYkxjdXNFV2JaZW5VQ2laOU5mK1A4ZStz?=
 =?utf-8?B?eWx0UElYUFhrUXIxaXVPempadVJ5a3ZiYjc4eFduSzRjU2NwRVNDSFZhYWlH?=
 =?utf-8?B?bWF5N3dadHlRbVFEQjJ0am5LVlJ5eVo1L3lKSEt2Y1pCNC90RHkwaDRiSUhx?=
 =?utf-8?B?Yk9MVDRjVm5uZE9BQ0g2Q294dVFhVXlYS3kzVTVzQ0ZVZllEODhvY0hrY2hm?=
 =?utf-8?B?VWFEMFpORE1WYk1DcUZjeUx1dDNQMHBCVTV6MFlrWU9VcUVVY2dsZWZtZzM0?=
 =?utf-8?B?dUFnZkhMYkZUSG4rN0c2N1VvcWlob3pTOHVzZGJGLzdRcDVPS2lRNmlmUmI4?=
 =?utf-8?B?UW1XLzFFeEJ3dmFDa0U3Q3I2b1RGZ1RnL1dFT2FmK2JBZTNHVElIazl5VENT?=
 =?utf-8?B?Z21oVTZXM2Rnbjk4SDhIdnQvZXRZOWxGaHAvRFYwenQrQ1c3LzRaY3AyRGJO?=
 =?utf-8?B?c1VxL2pINTNHbW5LcWtSMjZBSmhuUW5aLytXYVdNS2xCcFVRTFNjb0p5NDBK?=
 =?utf-8?B?UVFSeWgyeE1mVDJTZ0FkbUdUUE8yWXBwdXZFUjRaNGgxTG95ajhPSDFpNHNh?=
 =?utf-8?B?ZHdoWmQ4Lys2RTNJWkFTbjk5U2hXOGZIZkgxRGhGVjIrTHpPbnpRRk5XSUI0?=
 =?utf-8?B?MFU3NXRYc20wWDE2ck5vek1xcGhEdmxncnYrQVdWR0xXa3psMFZKaC93bVlW?=
 =?utf-8?B?dTAzNWdpbUxOUXlhWkVOMnhYb01hcU8zY1RGbjBjV3A0N1RXY0QzRjNvTjE3?=
 =?utf-8?B?dmFqWk0zeExCbW5BY0RtZWpLZDhxR00wRnVmMkx1cXNrKzYxajdyM0NoZjlv?=
 =?utf-8?B?YnBsOXhaaC9YSFIyN1EvNSt6ZCttcmtZNUgwazdnTm1sOWJrWWU3TVVYaXBZ?=
 =?utf-8?B?Mk40MEcwbnhBbEhSNVMzRXR2QWk1NFJ4WTNqS1dFZ3djL0xpSlNhTmZzTW8v?=
 =?utf-8?B?OHZ4bTJkZEtPREFjNzZ3U2lHV1AzeDR5WVFQdTdxTnAveGpjZUFUNHNNQjlO?=
 =?utf-8?B?bzZoVm1IemtqQzhCaFpDWTZiSytNQTdJVERNcURxWG45RUFuS1dOeTZSenps?=
 =?utf-8?B?VUExZFJQN3JPQmV1cDI0TUIrbUJ0Smp5VFdQRGJQR3VaTlZFcmRkb1RvSEVn?=
 =?utf-8?B?cWVqeGRwSWFsa0ZyWXQ5eTlkNEN5TkR3YitIOFVrYjB6UHhWbVFQOUZHRkUy?=
 =?utf-8?B?a3JLUGZFZDRRSjhmZStlTU16ajJqMExZVXpGZ3VOWDYxY3VEUE5oSytLejho?=
 =?utf-8?B?N1N5bjZoMzNqR2xucC9aZzBnaWJhRC9LbjBxeXZQbEZORG9XamYzTTlWRWlB?=
 =?utf-8?B?YzZuSjh4T0docnVlcHViUmlLRk1zR3lnL2hTMk0rQUNhK1YzSmJwS3c0KzJF?=
 =?utf-8?B?K213M21QQ2hjMnlha0xzUmNoWmFXQnJSWlROMzFMb0Foa09lcHFJVnlrdXBX?=
 =?utf-8?B?a0ExSGEwekMwK2JINHNWRWhqRXo3anljS0VDRU9XRW13anJDZG9oYVlUUUM0?=
 =?utf-8?B?eWNpQ3JlOHNtUlVjdkRHT3U1QXQwUngyNlFqbEZEYnNRK1BHQzRSbkxyclpL?=
 =?utf-8?Q?v3fAQNkNjW/SQvMGOA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: B0JGk8nBCIpFGDtXiLMOYbXMgE2+inYu/zB1I3pto5JaYSAkZR63ohfCUCb3hOknzbX05gk0qIadYfhqGVA1lSAjUE1x4TPmu+bZxuFO1f9lOwuHML2NkrWGXJqX1NaU1Say70CqbJgjG9iUh+3b2IlqWqKJtv3DAUhD6D4asx8RPuvKsZozMXVey7P1cGjV9QPDozFjQWnlYpC7BhMqXOWy38zvNZOAydXtEz+ke5UdvFJ/LzmhKC+6eD790cxSTsxSNyxAnF20ielq8spEMcEjlNnP80+/nN8JI9Bakhuc8qeDlPPI06dRCIlhvyqJ4InlYItz6HLEYmvRFC700A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8040.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a48d41d5-049a-4043-4155-08df198befe4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 16:01:32.5707 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HfuxtDdHG0JM8yc95oRwiLNRu4s7FcblW8fyHSkklSkXm0NyEsnzmqTXw/krJOZnYbgqHq7aYC06b+53fu6JrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6605
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

SGkgQEpvb25hcyBMYWh0aW5lbiwNCg0KV2hlbiBzaGlmdGluZyBmcm9tIFdBIG9wdGlvbiAjMiB0
byBvcHRpb24gIzEsICAgIHJlbW92aW5nIGEgZ2xvYmFsIHNldHRpbmcgLT4gICBhZGRpbmcgYSBw
ZXItY29udGV4dCBzZXR0aW5nLiAgV2UgdGhvdWdodCBpdCB3YXMgYSBwZXItY29udGV4dCBvcGVy
YXRpb24uICBIb3dldmVyLCBkdWUgdG8gdGhlICJ3ZWFrZXN0IGxpbmsiIGVmZmVjdCwgdGhpcyBy
ZW1haW5zIGEgZ2xvYmFsIG9wZXJhdGlvbi4NClRodXMsIG1ha2luZyBpdCBwZXItY2xpZW50IGhh
cyBubyBlZmZlY3QgZWl0aGVyLiAgQ29udGFpbmVycyB3aWxsIGludGVyZmVyZSB3aXRoIGVhY2gg
b3RoZXIuDQoNClRoYW5rcywNCkppYQ0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLSANCj4g
RnJvbTogSm9vbmFzIExhaHRpbmVuIDxqb29uYXMubGFodGluZW5AbGludXguaW50ZWwuY29tPg0K
PiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMjIsIDIwMjYgMTE6NTIgUE0NCj4gVG86IFlhbywg
SmlhIDxqaWEueWFvQGludGVsLmNvbT47IHNhc2hpa28tYm90QGtlcm5lbC5vcmc7IHNhc2hpa28t
DQo+IHJldmlld3NAbGlzdHMubGludXguZGV2DQo+IENjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnOyBpbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBSb3BlciwNCj4gTWF0
dGhldyBEIDxtYXR0aGV3LmQucm9wZXJAaW50ZWwuY29tPjsgVHZydGtvIFVyc3VsaW4NCj4gPHR1
cnN1bGluQHVyc3VsaW4ubmV0Pg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIHY5XSBkcm0vaTkxNS9k
ZzI6IEFkZCBwZXItY29udGV4dCBjb250cm9sIGZvcg0KPiBXYV8yMjAxMzA1OTEzMQ0KPiANCj4g
UXVvdGluZyBZYW8sIEppYSAoMjAyNi0wOS0yMiAxNzozNDowOCkNCj4gPiBIaSBASm9vbmFzIExh
aHRpbmVuLA0KPiA+DQo+ID4gRm9yIFJDUyAtPiBVTlNFVA0KPiA+IEZvciBDQ1MNCj4gPiAxLiBP
bGQgY29tcHV0ZSBydW50aW1lIC0+IFVOU0VUDQo+ID4gMi4gTmV3IGNvbXB1dGUgcnVudGltZSAt
PiBVU0VSDQo+ID4NCj4gPiBJZiB3ZSB0YWtlIHRoZXJlJ3Mgb25seSBvbmUgY29tcHV0ZSBydW50
aW1lIHZlcnNpb24sIGFuZCBwcmlvcml0eSBVU0VSID4NCj4gVU5TRVQ/ICBXaGVyZSdzIHRoZSBj
b25mbGljdCBjb21lIGZyb20/DQo+IA0KPiBTZWUgYmVsb3cuDQo+IA0KPiA+IEJ1dCBpZiB3ZSB0
YWtlIHRoZXJlJ3MgbW9yZSB0aGFuIG9uZSBjb21wdXRlIHJ1bnRpbWUgdmVyc2lvbiwgYW5kIHRo
ZWlyDQo+IHByaW9yaXR5IGlzIGVxdWFsLCAgVU5TRVQgY2FuIGNvdmVyIFVTRVIsICBVU0VSIGNh
biBjb3ZlciBVTlNFVCwgIGV2ZW4gd2l0aA0KPiB0d28gY2xpZW50cyB0aGV5IGNvdWxkIGNvdmVy
IGVhY2ggb3RoZXIuDQo+IA0KPiBJIGRpZG4ndCBmb2xsb3cgdGhpcyBwYXJ0LiBIb3cgZG9lcyB0
aGUgcHJpb3JpdHkgY29tZSBpbnRvIHBsYXk/DQo+IA0KPiBXZSBoYXZlIHRvIGtlZXAgc3dpdGNo
aW5nIHRoZSBtb2RlIGFzIHRoZSBEUk0gY2xpZW50cyBjb21lIGFuZCBnby4NCj4gDQo+ID4gV2Ug
c2hvdWxkIHRha2UgaXQgZWFzeS4NCj4gPiBPbmNlIHdlIHJlYWNoZWQgVVNFUiwgc2V0IGJ5IG5l
dyBjb21wdXRlLCB3ZSBzaG91bGQgbGF0Y2ggaXQsIGZvciB0aGUgV0ENCj4gaGFzIGJlZW4gaW1w
bGVtZW50ZWQgYnkgVVNFUi4NCj4gDQo+IFRoYXQgd29uJ3Qgd29yay4gSWYgeW91IGFyZSBydW5u
aW5nIHR3byBkaWZmZXJlbnQgY29udGFpbmVycywgeW91IG1heSBoYXZlDQo+IGRpZmZlcmVudCBj
b21wdXRlIHJ1bnRpbWUgdmVyc2lvbnMuIEFsc28sIE1lc2EgY2FuIGJlIHN1Ym1pdHRpbmcgdG8g
Q0NTIHRvbw0KPiBmb3IgYXN5bmMgY29tcHV0ZSwgQUZBSUsuDQo+IA0KPiBUbyBwcm9wZXJseSBj
b3ZlciB0aGluZ3MsIHdlIHNob3VsZCBtYWtlIGl0IGludG8gcGVyIERSTS1jbGllbnQgc2V0dGlu
ZyBhbmQNCj4gc3dpdGNoIHRoZSBtb2RlIGFjY29yZGluZ2x5IHdoZW4gZGlmZmVyZW50IERSTSBj
bGllbnQgaXMgcnVuLg0KPiANCj4gQW5kIGZvciB0aGUgZ2l2ZW4gU0tVIHdpdGggb25seSBvbmUg
Q0NTLCBhcyBleHBsYWluZWQgZWFybGllciwgaXQgc2hvdWxkIGJlDQo+IGFscmVhZHkgZ3VhcmFu
dGVlZCB0aGF0IHR3byBkaWZmZXJlbnQgRFJNIGNsaWVudHMgYXJlIG5vdCBhY3RpdmUgb24gdGhl
DQo+IGhhcmR3YXJlIGF0IHRoZSBzYW1lIHRpbWUgZHVlIHRvIHRoZSBhZGRyZXNzIHNwYWNlIG1h
dGhpbmcgcmVxdWlyZW1lbnQNCj4gYmV0d2VlbiBSQ1MgYW5kIENDUy4NCj4gDQo+IElmIHRoaXMg
bmVlZHMgdG8gYmUgZXh0ZW5kZWQgdG8gbXVsdGkgQ0NTIFNLVXMsIHRoZW4gaXQnZCBiZSBhIGJp
Z2dlcg0KPiBpbXBsZW1lbnRhdGlvbiBlZmZvcnQuDQo+IA0KPiBSZWdhcmRzLCBKb29uYXMNCj4g
DQo+ID4NCj4gPiBUaGFua3MsDQo+ID4gSmlhDQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBKb29uYXMgTGFodGluZW4gPGpvb25hcy5sYWh0aW5lbkBs
aW51eC5pbnRlbC5jb20+DQo+ID4gPiBTZW50OiBNb25kYXksIFNlcHRlbWJlciAyMSwgMjAyNiAx
MTo0NyBQTQ0KPiA+ID4gVG86IFlhbywgSmlhIDxqaWEueWFvQGludGVsLmNvbT47IHNhc2hpa28t
Ym90QGtlcm5lbC5vcmc7IHNhc2hpa28tDQo+ID4gPiByZXZpZXdzQGxpc3RzLmxpbnV4LmRldg0K
PiA+ID4gQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7DQo+ID4gPiBpbnRlbC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBSb3BlciwgTWF0dGhldyBEDQo+ID4gPiA8bWF0dGhl
dy5kLnJvcGVyQGludGVsLmNvbT47IFR2cnRrbyBVcnN1bGluIDx0dXJzdWxpbkB1cnN1bGluLm5l
dD4NCj4gPiA+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjldIGRybS9pOTE1L2RnMjogQWRkIHBlci1j
b250ZXh0IGNvbnRyb2wgZm9yDQo+ID4gPiBXYV8yMjAxMzA1OTEzMQ0KPiA+ID4NCj4gPiA+IFF1
b3RpbmcgWWFvLCBKaWEgKDIwMjYtMDktMjEgMjA6MzM6MDMpDQo+ID4gPiA+IEhpIEBMYWh0aW5l
biwgSm9vbmFzLA0KPiA+ID4gPg0KPiA+ID4gPiBUaGUga2V5IGlzIExTQ19DSElDS0VOX0JJVF8w
IGlzIGEgZ2xvYmFsIHJlZ2lzdGVyLg0KPiA+ID4gPg0KPiA+ID4gPiBFdmVuIHdlIHVzZSBwZXIt
Y2xpZW50LCAgd2Ugc2hvdWxkIGNvbnNpZGVyIHRoZSBmb2xsb3dpbmcgY2FzZXM6DQo+ID4gPiA+
DQo+ID4gPiA+IDEuIFNob3VsZCBjb25mbGljdGluZyBjb25maWd1cmF0aW9ucyB3aXRoaW4gYSBj
bGllbnQgYmUgcmVqZWN0ZWQ/DQo+ID4gPiA+IEkgcmVjb21tZW5kIHRoZSBmaXJzdCBzZXR0aW5n
IHNob3VsZCBiZSBsYXRjaGVkLg0KPiA+ID4NCj4gPiA+IEZyb20gdUFQSSBwZXJzcGVjdGl2ZSBp
dCB3b3VsZCBiZSBzaW1wbGVyIHRvIHNldCB0aGlzIGF0IHRoZSBEUk0NCj4gPiA+IGNsaWVudCBs
ZXZlbCBhdCBvbmNlLiBIb3dldmVyIHdlIGRvbid0IHNlZW0gdG8gaGF2ZSBzdWNoIHVBUEkgaW4N
Cj4gPiA+IGFjdGl2ZSB1c2UgY3VycmVudGx5IChhbGwNCj4gPiA+IGRybV9ub29wKSBzbyB5b3Un
ZCBoYXZlIHRvIGNvbXBhcmUgdGhlIGNvbXBsZXhpdHkgYmV0d2VlbiBpbmRpcmVjdGx5DQo+ID4g
PiBzZXR0aW5nIGl0IGF0IERSTSBjbGllbnQgbGV2ZWwgYnkgZmlyc3QgY3JlYXRlZCBjb250ZXh0
IG9yIGFkZGluZw0KPiA+ID4gc3VjaCBhbiB1QVBJIHRvIHNldCBpdCBleHBsaWNpdGx5IHBlciBj
bGllbnQuDQo+ID4gPg0KPiA+ID4gPiAyLiBTaG91bGQgY29uZmxpY3RpbmcgY29uZmlndXJhdGlv
bnMgYWNyb3NzIGRpZmZlcmVudCBjbGllbnRzIGJlIHJlamVjdGVkPw0KPiA+ID4gPiBJIHRoaW5r
IHRoZSBsYXR0ZXIgc2V0dGluZyBjYW4gY292ZXIgcHJldmlvdXMgb25lLg0KPiA+ID4NCj4gPiA+
IERSTSBjbGllbnRzIG5lZWQgdG8gYmUgaW5kZXBlbmVudCBmcm9tIHRoZSBkcml2ZXIgcGVyc3Bl
Y3RpdmUsIHdlDQo+ID4gPiBjYW4ndCBkbyB0aGF0Lg0KPiA+ID4NCj4gPiA+IFRoZSB3aG9sZSBw
b2ludCBvZiBtYWtpbmcgaXQgcGVyIERSTSBjbGllbnQgaXMgdGhhdCBnaXZlbiB0aGUNCj4gPiA+
IGltcGFjdGVkIFNLVSBvbmx5IGhhcyAxIENDUyBlbmdpbmUuIFdlIGhhdmUgdGhlIGFkZHJlc3Mg
c3BhY2UNCj4gPiA+IG1hdGNoaW5nIHJlcXVpcmVtZW50IGJldHdlZW4gQ0NTIGFuZCBSQ1MsIHNv
IHdoZW4gYm90aCBDQ1MgYW5kIFJDUw0KPiA+ID4gYXJlIHJ1bm5pbmcsIHdlIGtub3cgdGhleSBi
ZWxvbmcgdG8gdGhlIHNhbWUgRFJNIGNsaWVudCBhbmQgdGh1cw0KPiA+ID4gdGhleSB3aWxsIG5v
dCBjb25mbGljdCB3aXRoIHRoZSBXQSBtb2RlLiBBbmQgaWYgb25seSBvbmUgb2YgdGhlbSBpcw0K
PiA+ID4gcnVubmluZywgdGhlcmUgY2FuIGJlIG5vIGNvbmZsaWN0IGVpdGhlciBhcyBpdCdzIGp1
c3Qgb25lIGNvbnRleHQuDQo+ID4gPg0KPiA+ID4gPiBFdmVuIGxpa2UgdGhpcywgc3RpbGwgY2Fu
J3QgY292ZXIgYWxsIHRoZSByYWNlIGNvbmRpdGlvbi4NCj4gPiA+DQo+ID4gPiBXaGljaCByYWNl
IGNvbmRpdGlvbnMgZG8geW91IHRoaW5rIHdvdWxkIHJlbWFpbj8gV2UgZGVmaW5pdGVseSBoYXZl
DQo+ID4gPiB0byBlbGltaW5hdGUgYW55IHJhY2UgY29uZGl0aW9ucyB0byBsYW5kIHRoaXMuDQo+
ID4gPg0KPiA+ID4gUmVnYXJkcywgSm9vbmFzDQo=
