Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCFC606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XrwsYsMh;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=MIJV4gwn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21AAA10E7BC;
	Wed, 18 Nov 2026 12:55:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0912B10E7BC;
 Wed, 18 Nov 2026 12:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795006546; x=1826542546;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=bQ9rUP305LVbYn1pZ4SLo6A0ceI4jLOOMn5zWfnFpzc=;
 b=XrwsYsMh/TaOyOhKZJu326doFgbdizHe4uqdM7ggM0tf+J5x1sqBe0hp
 lIhZzTx4/97ol0r4CsBkr9bSgR2w+LBqlRfbIQrytom8WV+CaxltkZL3z
 KzlJoHgLZkq4OOVPTYnsnl07uu0cb1DxrbOgJg5WdsB/N+kcaY4sco7z5
 rFKoml0ow443voMMbioqvz+TPWHFU+ABGs0EVtmMjzzqZEieIq+bDvb5v
 T8oQs1QVG5/IKTi2fPc0pwC0cv/g/ZcJECmMd9fr4KjPCeNhul1NqqCz3
 XaaHmuDqpL2FVJ/6OEc+au+USzPmeVL0pCr1mZImsJ5vCG0UnTWlhUXL2 Q==;
X-CSE-ConnectionGUID: inEywjz2QTSB0CZW6rA7gw==
X-CSE-MsgGUID: PbAoBm7KQfK5WvmaQWISRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3705644"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3705644"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 04:55:45 -0800
X-CSE-ConnectionGUID: NoL41TkVQ9yUkI7jBI/mbQ==
X-CSE-MsgGUID: FH2zAJmISqyWj+DSvqUkyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10477145"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 04:55:44 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 04:55:44 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 04:55:44 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.0) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 04:55:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OpswiXQ3SvgYWB4AYJGcJt6SzKw68HXqpbf+AyIwl4QPduQYovQdBCsDmDdYewtocq0bVyIHU4+yvG6BMiph1+hS7Jp/XwZcSZ94+gUII3oeLqb8yl2cI5uBYjzY0xHdTm0XwqLT1jCAVy6Ut1DOKsrZ5vsIEoyux5r4wjtGJatEkzrro9RiyJ9ALe8/C9Oe7ZBaW0D8fssl8Ik8ayyfvF0502/34c5PPLcjN2Y3t06ryR1V8GPb6aWmjTG3GKspHIaD/WQl51gE5gNZbKLezqECsiwW0XC4qG7E2CuteNUsKNV0dm5UGugLediBVdcn5KH51nXI0owIZAsgNhHuaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQ9rUP305LVbYn1pZ4SLo6A0ceI4jLOOMn5zWfnFpzc=;
 b=PNxA0ayJD986Bs5h6HG94/ceZyaZuAeXa3W0iPKmqt+LCmpZwOKumFFpzyQMp2uOGMhkF5f6EzRmC5pH4vW5sWRaWa66NTDM+mkq4wlhYF9XlzejHT4VyFLVrvxFVv1BeJjpSlUEvzbyMZXtmEpseIW/ZUazyXA1j2DYZZf8tWTDYLKo4HaOxwqMdJWxJZ/rJ49U1hCQ88lnSfy88HCJtlDgkg0MCIy/POLXAwufeefACf4a5zfUjjht6hvDFQW8LH97jribH/am5mKU92pJz37ctxYoe+SPyjNdkyac/aRTMh9BX95j25dC2ynI5yv++6777/+oOYpYX7WnuwCiMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQ9rUP305LVbYn1pZ4SLo6A0ceI4jLOOMn5zWfnFpzc=;
 b=MIJV4gwnvq0Q+SUZqvQbJy5TDqGpr3tyJzGNJUc8eZnLLwFTaf6N7dT4hgKWm2wfNDnlaUQ1rN1PehRPkE9C8aXoQKiXcZvkb1MVSfYONoc3vko4sOcatNgz7q8zEkzZv+RoxBE8K7bbJ02azxhXkf7NxS8R3umtZL9KppP0V6M=
Received: from LV2PR11MB6024.namprd11.prod.outlook.com (2603:10b6:408:17a::16)
 by DM4PR11MB7325.namprd11.prod.outlook.com (2603:10b6:8:107::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 12:55:41 +0000
Received: from LV2PR11MB6024.namprd11.prod.outlook.com
 ([fe80::38ad:3190:bbb2:412b]) by LV2PR11MB6024.namprd11.prod.outlook.com
 ([fe80::38ad:3190:bbb2:412b%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 12:55:41 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Manna,
 Animesh" <animesh.manna@intel.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>
CC: "Kandpal, Suraj" <suraj.kandpal@intel.com>, "Nikula, Jani"
 <jani.nikula@intel.com>
Subject: Re: [PATCH v7 16/20] drm/i915/alpm: Replace is_edp() with
 alpm_is_possible()
Thread-Topic: [PATCH v7 16/20] drm/i915/alpm: Replace is_edp() with
 alpm_is_possible()
Thread-Index: AQHdZQydKBBzTj0Vh0mPXpVCx5lOULcz7h+A
Date: Wed, 18 Nov 2026 12:55:41 +0000
Message-ID: <c2f109423c5f96c965fb0b3adc6754bad10aafb6.camel@intel.com>
References: <20261026054001.799894-1-animesh.manna@intel.com>
 <20261026054001.799894-17-animesh.manna@intel.com>
In-Reply-To: <20261026054001.799894-17-animesh.manna@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6024:EE_|DM4PR11MB7325:EE_
x-ms-office365-filtering-correlation-id: 9e3eb840-114e-488a-0e0a-08df45734063
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|261021123027099003|38070700021|10067099003|261022075727099003|56012099006|4143699003|11063799006|261021121427099003|261102123227099003|261009223027099003|18002099003|6133799003|22082099003;
x-microsoft-antispam-message-info: CHa0LEgOt50diNBho3O+up9P9UuMNVk2AnAMBH8+Jkn4+WGXjxA/TzJkK9vzEmI/9IX/P19/xnM0A9XErt7bE+lz3xG9tzKIBUqzxEf9EcBSuQ9eJNvOK79Cf4KdkyQ3kKaBInp5tVKrRhlNmV7Gpj6vTI0O8vkwFRpiJ5NalhB6WNOnovp8lnX2sHc4na8wlpfUTjlGMU66g89UVDKLG7qsAo1q69c/3SATGaQwTHuNADx1U+IgyLv7VAvVAiwAo/YVYYPUNiTMZLCXG4tf3NqaN3F8TskgzquteJHA8XnIOdeE2kb63NasKwoSYaYMomndkmBap3uR7UBTisJzY6GF+zKmz2xiQ+g9+bFvjz6XQjUPcZnKhBgUUi7cVJGhqCMvSRMZrxTD3nbGiGWpKcEjHgB9nCEP1zUNzeYYw/O/fItqP38oVsDHTb/+87c3GvWldgzBy0dnNxv/3UlkZ9VfUxIMDNn7CfKAk5tcHMEopeCcSYFkncvj8nuy/q4LUuUKEbHlm0puWHnav3qAtRK+H4vLeI7rH7GZ0xT55rU721G5tOueN4kgnb3Ax1efbEDnms2MZ3UtsTXftDCqa0zjD8oE7+VADCQcZqfUYI9XD2B5Dfb8KhCoQ2JvY7z+Xoo3E291vh1gUEylfyCVHQ2i69SRjrczDJ2W0vMaI+YETIglfrj1vH0d2eQSttNtd0HpPvNwOrN6EmeoOzdTG0y+UTuBjMyarUbq3lmkyj0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB6024.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(261021123027099003)(38070700021)(10067099003)(261022075727099003)(56012099006)(4143699003)(11063799006)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(6133799003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZXQxMjlkalpkM3FUNEJPSHBraElCNi9lajB1RFV2ZkNzTmhpRW5lcEtVN2VL?=
 =?utf-8?B?OUl2SXdQUFVZTFZMdVJmMWtacm5KQm9MWnNyeUhHa051R2JaRU0xN2s0NWhx?=
 =?utf-8?B?UHRSa0lmYmlRdThJRXh4U1F5c04zU1YyNlB4R2syVktNSTA1bVpyOWJscXFI?=
 =?utf-8?B?c041OVlXUE1SU2NEclNlM0p4dWhyZEFwZ1F1RFMvaVpYdWxkbmRESW1uL01R?=
 =?utf-8?B?TkhVdDhzSjVDSVd5RlltbGtyQlUvT1o5UE4wMUNKb2ZHV1FhVE1VaEJYL3g0?=
 =?utf-8?B?MktyWDRGSDdSbFIyK1J6dUpIR2pVemlLQ1lWS3JuTlFKY01xZzVrWkd5M1Uw?=
 =?utf-8?B?Mk4rWTZFOTZSTElad2hVWE5MVXd4Rk50VlJZTFl4bGxtOWpyL2x0RVVuSXdN?=
 =?utf-8?B?Y0IxMjliNVJTWUNBS0toeGg3eisybngwYWZpUEV3TDd6dzlRQnk0L0p4cnNP?=
 =?utf-8?B?R1BOSi9TK0JkNDJvRGttSnd2bEpQN1BlazVUSDdEb0h2czJqb0V5YWFxVXIx?=
 =?utf-8?B?MDByT1BTd0ZtdCtuRnUwSFVUZ3M1VmI3Y0JnRUtOZG9GanJsWUlRZXAxc2Iy?=
 =?utf-8?B?dTdHTWR0NTQ3cE1ZcnQ3Q2tjN0YrajQ4dzdoT3QxNFd2SFR6NlJHMTZ3UVpv?=
 =?utf-8?B?QXpKVndRUEh4UGREOTg0SEhGMTRxMFR0UHhDb2NDT09LaC9POE1HcEQ0WVh3?=
 =?utf-8?B?QUZ6RytpK2lnVjBqUnJ6UTFpMTV6RmxXTCswZ1UwTXBDTC91ZmRYb1R6cE4v?=
 =?utf-8?B?L2I4N0Z6SDhzZGpYYmR6MGxNS050WEQxcVlnRG5CYkxxMFY5dTlZRWRxVndX?=
 =?utf-8?B?MmFUR2lzSzNCOVBZOWk1VVh5OGphRDVJdXJYNFdhTDY1ZFpxZWtVdjREd0l5?=
 =?utf-8?B?elRpZWcyYWJKT1haNDNrQW9wZm9mbHk5dmxGU0dMcjUrbXhOTkNVNlNTdWFX?=
 =?utf-8?B?TTRPZ2FISGJBbHZVc0pwZFF5c1FQZHJTTU9oZmc5S3hsMDQ3OVFQQ2lLSzkw?=
 =?utf-8?B?cVJ4SU5KSFlFVHh1bjUzVXg3aE9HZjdnb1BCbjR5YmtGZzZRb3hVU3dwWTRo?=
 =?utf-8?B?K1lmVnNFdTJ3bzE4QURpMml5cCtlZEZOYVpFL1pKVTNGTFF6MXZRNUxsNE5t?=
 =?utf-8?B?MGpweEw1RGxQb2xMaEpzQlp6MjgzV2lKRWZqQnJyejY3OWlHdmZHRzgvblU0?=
 =?utf-8?B?UUR0ZERFRkRVMmVvVnR4Vm9qbk5Yd0VUMlFIS2hJbFQxWXJBMVNYVFVsUno0?=
 =?utf-8?B?V2ErdDB4ZWpHajF0K2U0RmVnL1dmcmVyZmRnUWFNVjh5dFBlV24rSlJnNDdm?=
 =?utf-8?B?ZzlPRmkxQlR2OVhseldXcDl3SWFQcHNJWms5TjRicFJrL28zMCtpMFNBdklo?=
 =?utf-8?B?WU96TjBYOTgrbGlCVnJXK05DQlBHY0xJRDBnVUltUFVONDQzOFhqNVpFNVc4?=
 =?utf-8?B?SGhzTjlwTnFkZmN6SFJJL2FnUkpBT052Nm94QmtDd2hVeXVtNTU1ZlVOWk5l?=
 =?utf-8?B?TVpZeEtHMGx6UzZUeVdYeEFHL2YvWmJjcGMvdGtRdndDZGQ3RzdXbUplMEpK?=
 =?utf-8?B?SGNJQW1TZmQ0WHJxNmVDS2hjWDN1M1FxalNCNG8xUEN3YkRwTWhBczdQS1Nv?=
 =?utf-8?B?a01mTFVsb05SM2NhMEo4RzFJVVRvVExqYzhCSGdNa3ZZWmZkMW11bzlsN1cr?=
 =?utf-8?B?Kzc1NDBVZkYvUWErZXVma2k3TXpRMGVIZ1ozbXpMbU4wM1o0TVZtSk44cWFK?=
 =?utf-8?B?VUk0dXM2WEozWWFRK3J2T01uYlZXbCtEWklOdzZSb1NxT05lc0QwQWltQjA1?=
 =?utf-8?B?S2hsbk1Ea0NZTy9PamFHalZlVXhBMkw2cW13WVdQemJjbS9rNnBaemhiZWxW?=
 =?utf-8?B?ZkJpd0g0ZFNaeTVnVjlHWnZxZDlPMis3cFF3RVdvTzY4SExPUXZlMllZSUpG?=
 =?utf-8?B?b0RoZ1g5L1pBMEkwbHQ0dlBFemFPY2JqYWQrelhMQmRGQ1VPOHE3eWJ0NWhk?=
 =?utf-8?B?bTNsUi9TK3hVcnNXSWhHdkJzNDdqbUVKSHBvaVpGQkp5VzBwSXRQclY1NmVu?=
 =?utf-8?B?VkpnQm44NmVaQnVFSkc1MDdjcERFTXN5eUFvcW9ZS09oUzVidGg0VUJoL0p1?=
 =?utf-8?B?bVlwdnl5YzR1OUVDeElKUFVjVzdPOFA0akoyV1p2SlJZbVhLdGo1cmtCUjI2?=
 =?utf-8?B?bUNpQXNqWFArRzlTNTBZdVFUbzNJMm9iUXA1L0FTSC9FTUdJaE4wbHRRTGdk?=
 =?utf-8?B?eklOMDJaamk2MXpQdWpiYlkrTEZDTWhDMjNFd0VWN1pUYVJ1WWtFWmdwRkQx?=
 =?utf-8?B?WU9IVnRrZG96MGNaUnpicjhnVzEvUE5zUDVzVnIrTU93TDE5SGNibTZ4aEVt?=
 =?utf-8?Q?soV6goA6vTAMOuA8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E55A32CF0F95704A95F10045E2514763@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MTY3p/sA+pWALM9nPadMoWWQiLiZGqxCQAiundB509rVKdvi6F4pzB2qYQwgXQ6KUOW031cJFfaSltHR7aa1dVOGmO0d01iZ/jt8Lf08Yob93ak+dAZGqIx1Iv+80PMPN/ZGHGpvOvhN18H1oUtiSI0yN/GWD/8qL2TGgI6jbF+fO1zdJdwODaG1LmIBMOKAyGchaSl3bER0QyyEUPaYUUf4hYhVSXqSG1GyricPm8MUEugQtailHxUeXU8KxsMMilsjbnd3uak+q3vP63qk5dmoaCnBQJZ0M6T+5VvY3m0GpGwJgDj//Hj1JVAF2U5fjjNbxCnBWI0TeEp80PLQLA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3eb840-114e-488a-0e0a-08df45734063
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 12:55:41.2982 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rjmxHRMjGNXkkVQkU7AXLe6M1jfrAPi9wlR8ysfTareevfp21XIrKLHHmEzZObj9HJA8e4tEqT/kBDrgFxG9SzXubVpfKuVyR59YSsKOCaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7325
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
PiBBZGQgYSBzZXBhcmF0ZSBhbHBtX2lzX3Bvc3NpYmxlKCkgd2hpY2ggd2lsbCBjaGVjayBmb3Ig
YWxwbQ0KPiBjYXBhYmlsaXR5IGZyb20gZHBjZCBpbmZvLg0KPiANCj4gQUxQTSBpcyBwb3NzaWJs
ZSBpZiB0aGUgc2luayBzdXBwb3J0cyBBVVgtd2FrZSBvciBBVVgtbGVzcyBBTFBNLiBXaXRoDQo+
IExUVFBScyBwcmVzZW50IG9ubHkgQVVYLWxlc3MgQUxQTSBpcyBwb3NzaWJsZSwgc28gYm90aCB0
aGUgc2luayBhbmQNCj4gdGhlDQo+IExUVFBScyBtdXN0IHN1cHBvcnQgQVVYLWxlc3MgQUxQTS4N
Cj4gDQo+IExPQkYgZW5hYmxlL2Rpc2FibGUgYXJlIG9ubHkgY2FsbGVkIGJhc2VkIG9uIGhhc19s
b2JmIGluIHRoZSBjcnRjDQo+IHN0YXRlLA0KPiB3aGljaCBpcyBjb21wdXRlZCB1c2luZyBhbHBt
X2lzX3Bvc3NpYmxlKCksIHNvIGRyb3AgdGhlIGNhcGFiaWxpdHkNCj4gY2hlY2sNCj4gZnJvbSB0
aGVyZS4gVGhpcyBhbHNvIGF2b2lkcyBsZWF2aW5nIEFMUE1fQ1RMIGVuYWJsZWQgb24gaG90LXVu
cGx1ZywNCj4gYXMNCj4gdGhlIHNpbmsgY2FwYWJpbGl0aWVzIGFyZSByZXNldCBiZWZvcmUgTE9C
RiBpcyBkaXNhYmxlZC4NCg0KVGhpcyBjb21taXQgaXMgYWxsb3dpbmcgQUxQTSBvbiBVSEJSIGxp
bmsgcmF0ZXMgYXMgd2VsbC4gWW91IGNhbiBhdm9pZA0KdGhpcyBieSBzcXVhc2hpbmcgaW50byA1
NTY1YjQ2NDc5NDU0NGFmZTc4NmMyODBkN2I0NWE2ZWU2ZTkzNDM4Lg0KDQpCUiwNCkpvdW5pIEjD
tmdhbmRlcg0KPiANCj4gdjI6IERyb3AgRElTUExBWV9WRVIoKSBjaGVjayBhcyBpbnRlbF9hbHBt
X3NvdXJjZV9zdXBwb3J0ZWQNCj4gYWxyZWFkeSBjaGVja2luZyBhbmQgcG9wdWxhdGluZyBkcGNk
IGluZm8uIFtKb3VuaV0NCj4gdjM6DQo+IC0gQ2hlY2sgQUxQTSBjYXBhYmlsaXR5IGJpdHMgb2Yg
c2luayBhbmQgTFRUUFIuIFtzYXNoaWtvXQ0KPiAtIERyb3AgYWxwbV9pc19wb3NzaWJsZSgpIGNo
ZWNrIGZyb20gTE9CRiBlbmFibGUvZGlzYWJsZS4gW0pvdW5pLA0KPiBzYXNoaWtvXQ0KPiANCj4g
Q2M6IEpvdW5pIEjDtmdhbmRlciA8am91bmkuaG9nYW5kZXJAaW50ZWwuY29tPg0KPiBTaWduZWQt
b2ZmLWJ5OiBBbmltZXNoIE1hbm5hIDxhbmltZXNoLm1hbm5hQGludGVsLmNvbT4NCj4gLS0tDQo+
IMKgZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9hbHBtLmMgfCAzMCArKysrKysr
KysrKysrKysrKy0tLS0NCj4gLS0NCj4gwqBkcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2lu
dGVsX2FscG0uaCB8wqAgMSArDQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCsp
LCA4IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1
L2Rpc3BsYXkvaW50ZWxfYWxwbS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9p
bnRlbF9hbHBtLmMNCj4gaW5kZXggNGU3NjEwMjI0ODVkLi4yMDVmMWFlMTBkNDMgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5jDQo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5jDQo+IEBAIC03Niw2ICs3
NiwyNSBAQCB2b2lkIGludGVsX2FscG1faW5pdChzdHJ1Y3QgaW50ZWxfZHAgKmludGVsX2RwKQ0K
PiDCoAltdXRleF9pbml0KCZpbnRlbF9kcC0+YWxwbS5sb2NrKTsNCj4gwqB9DQo+IMKgDQo+ICti
b29sIGludGVsX2FscG1faXNfcG9zc2libGUoc3RydWN0IGludGVsX2RwICppbnRlbF9kcCkNCj4g
K3sNCj4gKwl1OCBsdHRwcl9hbHBtX2NhcHM7DQo+ICsNCj4gKwlpZiAoIShpbnRlbF9kcC0+YWxw
bV9kcGNkICYgKERQX0FMUE1fQ0FQIHwNCj4gRFBfQUxQTV9BVVhfTEVTU19DQVApKSkNCj4gKwkJ
cmV0dXJuIGZhbHNlOw0KPiArDQo+ICsJaWYgKGRybV9kcF9sdHRwcl9jb3VudChpbnRlbF9kcC0+
bHR0cHJfY29tbW9uX2NhcHMpIDw9IDApDQo+ICsJCXJldHVybiB0cnVlOw0KPiArDQo+ICsJLyog
V2l0aCBMVFRQUnMgb25seSBBVVgtbGVzcyBBTFBNIGlzIHBvc3NpYmxlIGFuZCBMVFRQUnMNCj4g
bXVzdCBzdXBwb3J0IGl0ICovDQo+ICsJbHR0cHJfYWxwbV9jYXBzID0NCj4gKwkJaW50ZWxfZHAt
DQo+ID5sdHRwcl9jb21tb25fY2Fwc1tEUF9MVFRQUl9BTFBNX0NBUEFCSUxJVElFUyAtDQo+ICsJ
CQkJCcKgwqDCoA0KPiBEUF9MVF9UVU5BQkxFX1BIWV9SRVBFQVRFUl9GSUVMRF9EQVRBX1NUUlVD
VFVSRV9SRVZdOw0KPiArDQo+ICsJcmV0dXJuIGludGVsX2FscG1fYXV4X2xlc3Nfd2FrZV9zdXBw
b3J0ZWQoaW50ZWxfZHApICYmDQo+ICsJwqDCoMKgwqDCoMKgIGx0dHByX2FscG1fY2FwcyAmIERQ
X0xUVFBSX0FVWF9MRVNTX0FMUE1fU1VQUE9SVEVEOw0KPiArfQ0KPiArDQo+IMKgc3RhdGljIGlu
dCBnZXRfc2lsZW5jZV9wZXJpb2Rfc3ltYm9scyhjb25zdCBzdHJ1Y3QgaW50ZWxfY3J0Y19zdGF0
ZQ0KPiAqY3J0Y19zdGF0ZSkNCj4gwqB7DQo+IMKgCXJldHVybiBTSUxFTkNFX1BFUklPRF9USU1F
ICoNCj4gaW50ZWxfZHBfbGlua19zeW1ib2xfY2xvY2soY3J0Y19zdGF0ZS0+cG9ydF9jbG9jaykg
Lw0KPiBAQCAtNTM3LDcgKzU1Niw3IEBAIHZvaWQgaW50ZWxfYWxwbV9sb2JmX2NvbXB1dGVfY29u
ZmlnKHN0cnVjdA0KPiBpbnRlbF9kcCAqaW50ZWxfZHAsDQo+IMKgCWlmIChpbnRlbF9kcC0+YWxw
bS5zaW5rX2FscG1fZXJyb3IpDQo+IMKgCQlyZXR1cm47DQo+IMKgDQo+IC0JaWYgKCFpbnRlbF9k
cF9pc19lZHAoaW50ZWxfZHApKQ0KPiArCWlmICghaW50ZWxfYWxwbV9pc19wb3NzaWJsZShpbnRl
bF9kcCkpDQo+IMKgCQlyZXR1cm47DQo+IMKgDQo+IMKgCWlmIChESVNQTEFZX1ZFUihkaXNwbGF5
KSA8IDIwKQ0KPiBAQCAtODI5LDkgKzg0OCw2IEBAIHZvaWQgaW50ZWxfYWxwbV9sb2JmX2Rpc2Fi
bGUoY29uc3Qgc3RydWN0DQo+IGludGVsX2NydGNfc3RhdGUgKm5ld19jcnRjX3N0YXRlKQ0KPiDC
oA0KPiDCoAkJaW50ZWxfZHAgPSBlbmNfdG9faW50ZWxfZHAoZW5jb2Rlcik7DQo+IMKgDQo+IC0J
CWlmICghaW50ZWxfZHBfaXNfZWRwKGludGVsX2RwKSkNCj4gLQkJCWNvbnRpbnVlOw0KPiAtDQo+
IMKgCQltdXRleF9sb2NrKCZpbnRlbF9kcC0+YWxwbS5sb2NrKTsNCj4gwqAJCWludGVsX2RlX3dy
aXRlKGRpc3BsYXksIEFMUE1fQ1RMKGRpc3BsYXksDQo+IGNwdV90cmFuc2NvZGVyKSwgMCk7DQo+
IMKgCQlkcm1fZGJnX2ttcyhkaXNwbGF5LT5kcm0sICJMaW5rIG9mZiBiZXR3ZWVuIGZyYW1lcw0K
PiAoTE9CRikgZGlzYWJsZWRcbiIpOw0KPiBAQCAtODcwLDEwICs4ODYsOCBAQCB2b2lkIGludGVs
X2FscG1fbG9iZl9lbmFibGUoY29uc3Qgc3RydWN0DQo+IGludGVsX2NydGNfc3RhdGUgKm5ld19j
cnRjX3N0YXRlKQ0KPiDCoA0KPiDCoAkJaW50ZWxfZHAgPSBlbmNfdG9faW50ZWxfZHAoZW5jb2Rl
cik7DQo+IMKgDQo+IC0JCWlmIChpbnRlbF9kcF9pc19lZHAoaW50ZWxfZHApKSB7DQo+IC0JCQlp
bnRlbF9hbHBtX2VuYWJsZV9zaW5rKGludGVsX2RwLA0KPiBuZXdfY3J0Y19zdGF0ZSk7DQo+IC0J
CQlpbnRlbF9hbHBtX2NvbmZpZ3VyZShpbnRlbF9kcCwNCj4gbmV3X2NydGNfc3RhdGUpOw0KPiAt
CQl9DQo+ICsJCWludGVsX2FscG1fZW5hYmxlX3NpbmsoaW50ZWxfZHAsIG5ld19jcnRjX3N0YXRl
KTsNCj4gKwkJaW50ZWxfYWxwbV9jb25maWd1cmUoaW50ZWxfZHAsIG5ld19jcnRjX3N0YXRlKTsN
Cj4gwqAJfQ0KPiDCoH0NCj4gwqANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1
L2Rpc3BsYXkvaW50ZWxfYWxwbS5oDQo+IGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9p
bnRlbF9hbHBtLmgNCj4gaW5kZXggMWNiMjI2YmMzNDJhLi45MzE5NTcyYzIyMWUgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5oDQo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5oDQo+IEBAIC0xNyw2ICsx
Nyw3IEBAIHN0cnVjdCBpbnRlbF9jcnRjOw0KPiDCoA0KPiDCoGludCBpbnRlbF9hbHBtX2luaXRf
ZHBjZChzdHJ1Y3QgaW50ZWxfZHAgKmludGVsX2RwKTsNCj4gwqB2b2lkIGludGVsX2FscG1faW5p
dChzdHJ1Y3QgaW50ZWxfZHAgKmludGVsX2RwKTsNCj4gK2Jvb2wgaW50ZWxfYWxwbV9pc19wb3Nz
aWJsZShzdHJ1Y3QgaW50ZWxfZHAgKmludGVsX2RwKTsNCj4gwqBib29sIGludGVsX2FscG1fY29t
cHV0ZV9wYXJhbXMoc3RydWN0IGludGVsX2RwICppbnRlbF9kcCwNCj4gwqAJCQnCoMKgwqDCoMKg
wqAgc3RydWN0IGludGVsX2NydGNfc3RhdGUgKmNydGNfc3RhdGUpOw0KPiDCoHZvaWQgaW50ZWxf
YWxwbV9sb2JmX2NvbXB1dGVfY29uZmlnKHN0cnVjdCBpbnRlbF9kcCAqaW50ZWxfZHAsDQo=
