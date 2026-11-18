Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081A4606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 11:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EWadBR7r;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Z49pGbWq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A27110E74D;
	Wed, 18 Nov 2026 11:44:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A71110E74D;
 Wed, 18 Nov 2026 11:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795002264; x=1826538264;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=0OjcoUEo4Ur6AQMZRDRPMekeKKCYbunOJfH0DC/bNZw=;
 b=EWadBR7r44GzIbfKMRjqwe4EcJ886BrhTONWQKgpcbUif+6vxAobEg6F
 prUU8hLQSJCTDOF3DoBntsnbY/p8METRORL/Xz33VSdUHih1wrjQey62F
 T0lEN8XVHTS0lMDeUZeuF3yePqBDL2QPI2AdixzLV1iqn11d8Tn/S1KlZ
 xBz5ijUTFkWbzNnqTHJfzHRXf0G6S4Tug7Sfb6V1C+dDNf7IhBtIjd13J
 j0HYJ/QIMg95Dkg44K7tgo907SwF9qxF2TMI2eS9N5DEmNJfHbqAa9XH9
 R6nrwaMpZQM3kC6oU+Q7/9V/o5PnWEd8PWUr38ycg/trOl3dC/lVHdP/O g==;
X-CSE-ConnectionGUID: ZneijFFVSOKBL4tWpA+mXA==
X-CSE-MsgGUID: HCm83PwuSLaXcgpuSEDG3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3799384"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3799384"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 03:44:23 -0800
X-CSE-ConnectionGUID: Mbt0YK9OR+2AOBymxzhfBg==
X-CSE-MsgGUID: isAYmfc6Tmulk3QxaosnFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10032409"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 03:44:22 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 03:44:22 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 03:44:22 -0800
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.38) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 03:44:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hkHfL8Gkah1HoaB7FPrdYkiT0VMHVAK6OBdaUJDnfrTRVVXpZZOHlfRLLks/b0D26kuK8k4LeLz2ZIUo0wgdtAXw2Om7Kg0zBXBEcTwvw0pVQcbks9IW55lNAJVLBa6zX9iYL9eo2foXNSNkHyYXo7mOC1xvug0DrCnJrQuD78slR9S3N9sgvhjLRnzPPyTjPm9n1F+OP+jgy5ODMMHOBUV2/U5Tp4BoEfxRnja0DCDAKu8OOSGOtBaKDUp18X2UwmmlZO65C6XEUJBhwOaC6A6ooUNdSXLqCX12FQoVeJMCqCO7yY7AgzXIbnfV6gdTAwUJmfeDDklQoZuJXIfQXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0OjcoUEo4Ur6AQMZRDRPMekeKKCYbunOJfH0DC/bNZw=;
 b=Dkr6YATHNB6LRZFlDgxZfkXVkUfZijv05bsDwNGt4TcQ+wf7MqUleejrSqlLuf9ok2eM8okdEN+dgNGrXpOR+4wcZkOCVHifFovK/x6mHZcuw0HrPjOrtOBKHRAyk78m+zzJ7Y0w1Qyw5rD1aHTMwjjRikS/5ZeluR4rFUUv6aZgc4seei5//qCEGuZy2vRJQD2fRg9sVz4372p0vVXH3uii92LPpMeKlmKyrneYOD2I/RS1OdFTjJleB0IcfD+7sh04D2pNBYQ34sBDE+ZWp7Zf35sUwxdU7RlFRBGagxE9zUANDFW6hc2KCp2Ei/uZgRKrU1MM4Xqmj6+ADBhnpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OjcoUEo4Ur6AQMZRDRPMekeKKCYbunOJfH0DC/bNZw=;
 b=Z49pGbWqecKawNm80NHKe4KOfpVM6uQLfGSKvPFmHX67mHE5IaIVk2pYOvaN46L/ehEpJOJCHW/7JSXUCGVcOxX0mW3tjBtsuUy6k9wV579UZs7OP5E0HWRqb3/oFSkhinbPdTeXQwbTHwKUxg62sFJ1EPnSEx3UeOV9RJ5/aAE=
Received: from LV2PR11MB6024.namprd11.prod.outlook.com (2603:10b6:408:17a::16)
 by SA3PR11MB7653.namprd11.prod.outlook.com (2603:10b6:806:306::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 11:44:14 +0000
Received: from LV2PR11MB6024.namprd11.prod.outlook.com
 ([fe80::38ad:3190:bbb2:412b]) by LV2PR11MB6024.namprd11.prod.outlook.com
 ([fe80::38ad:3190:bbb2:412b%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 11:44:14 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Manna,
 Animesh" <animesh.manna@intel.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>
CC: "Kandpal, Suraj" <suraj.kandpal@intel.com>, "Nikula, Jani"
 <jani.nikula@intel.com>
Subject: Re: [PATCH v7 02/20] drm/dp: Add DPCD definitions for DP2.1 ALPM
 capability
Thread-Topic: [PATCH v7 02/20] drm/dp: Add DPCD definitions for DP2.1 ALPM
 capability
Thread-Index: AQHdZQyD9E+OR6tsDEGhQFetteaqj7cz2ikA
Date: Wed, 18 Nov 2026 11:44:13 +0000
Message-ID: <bc4959388cc52cad886ed54abb6ab7d71f60f5ea.camel@intel.com>
References: <20261026054001.799894-1-animesh.manna@intel.com>
 <20261026054001.799894-3-animesh.manna@intel.com>
In-Reply-To: <20261026054001.799894-3-animesh.manna@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6024:EE_|SA3PR11MB7653:EE_
x-ms-office365-filtering-correlation-id: 65fbe06e-2682-4dd8-6451-08df4569450f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|6133799003|22082099003|18002099003|261009223027099003|261009221227099003|261021123027099003|261021121427099003|261026121527099003|261102123227099003|56012099006|11063799006|10067099003|4143699003|38070700021;
x-microsoft-antispam-message-info: L6m9QXRLr9jc2dhyfSpqshqDMqBn4i2hy/x0TaJ6cAP7WnpHF4aVgOjJrzWZQtngOAHxqJ7p/is04RzJB/BdPjNvqKkYpN6TcDmWv6tyNjGSLaECTsQQOq8k3YbaypfSEv5G9sVHe+kGP4O+QCwm4eWxEJQsaWLgyvDjTU6y0kQ9z3ZlGGmInrXgClRPU3mCS3x6otReS1pzEDicMfXcAi9R3WuDJBMmZnfyAsnjbfKeVEmgZtU7163wU2xSMDu3uiZurM49RoNF7ciBDt9q3bWYt/qfh4u5g1+RcSXsjwtrdLYtHFjw3ZwEWFNFYR6WEzJLeGT+Ou/zQcoxbZHuzLQHQrgCO6dqX+fKqFgU3/eEH1K21FFgMRq3qfeUPWR/m46CJ5I+cBOrOj3t03WToMyBvxsCZYILSRSvOg+E84tFRv3Ssrpm6WyPqDt7uFhYfCbErqJxB+RuZjqXg6X7DhI8Ua2lnyzne/CzFOPTbJD77HKfCStKgUCPn+UfR+NkgooZsTKJ4JyGAT75Mr88h0HBejku/ghQk/8tzoZn8FYmfidVQiHJ2nN4WRy17PY2u8YuHpi76aouahILParOqsX5AD5tHhjsjLwkeC0717jG6KPwuC0KD9/5QsSmJetl5/6fxttSlWy9Jpp6z2bNEo2A1CyHTdhn0vISA2Z1FS/zl2Pzos/7EAh5FZalDwE0gzfrDZVg9vj2EEXSU9prcA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB6024.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(261009223027099003)(261009221227099003)(261021123027099003)(261021121427099003)(261026121527099003)(261102123227099003)(56012099006)(11063799006)(10067099003)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VEZqVTJPQTJIWStjQTBIcTI0aGhkRERqSVBvWnJoaXo2azlRUHZlYjNqMVps?=
 =?utf-8?B?TTg4Q0xqMEVZT05QanVnbmVRS1JZZS9OVHF2MGlHT3phZnJPY3U4TldTd1Vk?=
 =?utf-8?B?bjgxYzYrTy9BMzdHLzlERGRBaEhvOVluN3VPem1VZ2pTdzRRSHRtU0tyemVI?=
 =?utf-8?B?RnY3aC9IYUJ0TnoreklhcTZOdUozcVppTlJDZVAyYmhrUDFrMVphNk9OTVdZ?=
 =?utf-8?B?RlJBQVNQcEJXajZZL0draytCRXRnRG1Ea0NKRTBkSnZqaHNoMTV0ekliTmdT?=
 =?utf-8?B?N3kyQkhTQ1FnS2hlbjdrQkl2emlmaU1haCtpVU56WC94bjB5dDAybjR4M2Qw?=
 =?utf-8?B?c3puLzRjN2FVZ00zd1Jkc0VzdWNFUFNqTXZFMXFSYmp3R0s1dmduTnBMaVJC?=
 =?utf-8?B?R2xQM29PSzJWNThOS09lU1pnOXpqZWNyaEQ4dk9ub3R3T0crNU0xUWpORFFI?=
 =?utf-8?B?aFZJM0x2VEYwSVpFU0RITzhiOGRmZFNnbUptZHg3Y0JrUWpYM1RGeS92VXZl?=
 =?utf-8?B?d01ON1VlQ1RtVU8ySXhEQ2wzZkNaK0Z5K1JUa0c0M1NZL2ZaUG9ONmRySlQ1?=
 =?utf-8?B?d1UyS2pzZkdyeVhJQm1PT3QvNWxtaUQ0cnFsNnBSSE5NaTk3Y2dGek5BUjBF?=
 =?utf-8?B?T29ER2x3NGF4eWJyYkRQRGE3RGpiN1FBRk5mZjU4bmpIUWI1WnRHdVh6NHU5?=
 =?utf-8?B?cDVqbHZKMVBObGJUYTJBaWpyZ0t5bkIwVytpV01DN2xVenJQcHhzc1cxQjg0?=
 =?utf-8?B?SGhub2hKay9VcldSNXNHSm9IbFQ1Z0NWcTFYQXh2R1RUdU5tSGhsdkhZZ3Ns?=
 =?utf-8?B?NVRPTms0RU45d2Nhc29RbEtqZjFXVzIwUGNZOGFkM2xIQjFOOFg0UWJkR1Jh?=
 =?utf-8?B?dTJ5V3diMW1zNWpOYjV2N1kzajFEcFpZUS9meFc3clZWMW1nRG5CSmhkZ2lv?=
 =?utf-8?B?czZXRC9jU2doRnp5UmdVMDlSNFpPdU96QTFpUGZSMDA3OTUxWURuaHdybWpB?=
 =?utf-8?B?cGE1eWVqdjNzbDJQK0hDRVVFMFNCV2lCTTFFbEVtb2FqY1MyanNtVGhNOUpS?=
 =?utf-8?B?UVZ1V0dTci9WTCtoUnEwQndHKytpb3NGWTV6aXlKSXpjQitZQW9aTTQ2dXhC?=
 =?utf-8?B?MFFoR0VUMTQrK1dzS2xNQThWbDBKNUo4dmlJMUFjcmpxV3BOR3B6aXI2cVg4?=
 =?utf-8?B?VnNOSm9jL2pxSUZvNHJqeG40cGRlNDcwZDhxMTNWcXJNTm1ISDIyY0RWOXpu?=
 =?utf-8?B?eTF4ZG5ZVlFlQkl3UStYZFAydjlaaFBiMFc1eWRET09rSXpISW5MZzJuTHc5?=
 =?utf-8?B?V2Y3QURoK0kxZXRSU3JpREx2enlFcHQ5eklOWlQ3Z3hZd3IxZVdwQ0YrNTQw?=
 =?utf-8?B?S2lpeUY0OGVQemhiekE2S28xdlYyNWIzNi9JS1pyUTYvQ2NxU1JRb3pMMnVZ?=
 =?utf-8?B?M1FXS0JUN2RhR1hQZDdvMCswOE53R05DSzZzSUtNa3hJcWRTRndIZlBxa0tW?=
 =?utf-8?B?UXFzOThneDN3TGZ1Y2hTTWlmTjlIOXZwU1luejdTNkdKeVBTYURvZWgxU3pu?=
 =?utf-8?B?R0ZXbDY4ZVV6czk4Y3k4a1FwY2dIMHFzSnNWZkF0NTQxS3ozQjNTU0wwdHpU?=
 =?utf-8?B?ei9WTy9FUURPb3NZL0N2QVBrNkZ0Q3ZrdFNheW1qSVRmRFRmR1U2b2oxNUdB?=
 =?utf-8?B?dHlYTXlFNVVZMU92SjA5ZFBKM3hKQnhwTjhlRzhpdzNIZm1GTTNFd3R4SUMr?=
 =?utf-8?B?QVNGb040c1pRSHA5eDN5N3JmUU9Hcms5RHphY1FSa1RiL1plb25lNjFTR0F3?=
 =?utf-8?B?N2VKQjY4MVNDMm8ycnZhTW14bGtVc1c3SlU5ZUFnUXB3SHVsazg3ZFNzbCs1?=
 =?utf-8?B?cjNPdlFVbXYvSVc4WEo2QUplakhranZzQTJ4c0M0RExWZG0wSUk0cC9EZ3hR?=
 =?utf-8?B?dEsvY0YvenlydytJWmcrUitFYkY1ZmEvWisvMklRTkF0OGZuam96ZmVFOXNK?=
 =?utf-8?B?TWRGMGI5VXBheVVJSFNKR1VMVXl6anRCRHdqQ0szN1NOakRyVzV2ajBQMUpx?=
 =?utf-8?B?OUhXeUgwaGFFWmRoUFREZUQwRllmS1ZodnA4bXp2UjM4Z2NQVkZ1Z2Nsd3RU?=
 =?utf-8?B?UmFLazY1bzVVRjYxcnF2U1B1ZFNPMkpHOFhKNU82UmxseXhBcmthUXlaOVA3?=
 =?utf-8?B?dDlzUU05cFNmb3l3QzY5czVKM2kzdzFVcUpqWXhrNHlwU1lwWWlhN1NtOVNU?=
 =?utf-8?B?OUQ5dzQxRDlXR0ZEbWhaOXFHc2Ywem16NEp6b1VrclBsTUcwRWpIaExaVDkv?=
 =?utf-8?B?VGVxcVpmYm5sSXBjenNERTZCb1NMUVdEclZqanl4cFFtaXRwdEo2MXVjakxo?=
 =?utf-8?Q?xzXcOSOn2IChFpL8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B23EA3A358F7C408A31E0845549CD5A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IqC2LvzXD7zp/pxl8rbO/fe+taFSrHfKFV3cycGgP9CdBdCdFEEjIB1/LHK6bNK/UeAw+AVRryrffyDKNju/9kbhc9NWgeePMe/OnRJzrgNFz2W0ZFV6gTE+7RrrzUlcWL91hXgEbtsmUdQ8Cxql6Xi6o32dDHfRohw2dvr+mMeaRY9J8qJtOaspHVNoGCCQsQ2sNby1/FnjXfUZv+wnNJ9jnfwjiSPME/HuupPA+PVLMD+LxsdejLieq2pfgEJxiBrfCzH9wwmuXa228ZuoDmM6xPQ5l87Xx+rLPivsLifTwDYsVzFSemZPgGgTUE1yekjpSyNlpZ81tpR8w/BtVQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65fbe06e-2682-4dd8-6451-08df4569450f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 11:44:14.1820 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: npPRWzgwAq6XVASK6pPSbqZxCxeZ0El3gUtX3hOT5S2bt0PV1z2DX4+K0dlYurKG4vX/2/IF+46CW7x9JXA/y9269MAdGRiby63rLPyPQDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7653
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

T24gTW9uLCAyMDI2LTEwLTI2IGF0IDExOjA5ICswNTMwLCBBbmltZXNoIE1hbm5hIHdyb3RlOg0K
PiBBZGQgdGhlIExUVFBSIEFMUE0gY2FwYWJpbGl0aWVzIHJlZ2lzdGVyICgweGYwMDA5KSB3aXRo
IHRoZSBBVVgtbGVzcw0KPiBBTFBNIHN1cHBvcnRlZCBiaXQsIGFuZCB0aGUgdG90YWwgTFRUUFIg
Y291bnQgcmVnaXN0ZXIgKDB4ZjAwMGEpLA0KPiBib3RoDQo+IGFkZGVkIGluIERQMi4xLiBUaGV5
IGFyZSBuZWVkZWQgdG8gZW5hYmxlIERQMi4xIEFMUE0gd2l0aCBMVFRQUnMuDQo+IA0KPiBFeHRl
bmQgRFBfTFRUUFJfQ09NTU9OX0NBUF9TSVpFIGZyb20gOCB0byAxMCBzbyB0aGF0IHRoZSBMVFRQ
UiBBTFBNDQo+IGNhcGFiaWxpdHkgaXMgcmVhZCBhcyBwYXJ0IG9mIHRoZSBMVFRQUiBjb21tb24g
Y2FwYWJpbGl0aWVzLiBUaGlzDQo+IG1ha2VzDQo+IGRybV9kcF9yZWFkX2x0dHByX2NvbW1vbl9j
YXBzKCkgcmVhZCB0d28gbW9yZSBieXRlcyBmb3IgYWxsIGl0cw0KPiB1c2VycywNCj4gRFBfUEhZ
X1JFUEVBVEVSX0VRX0RPTkUgKDB4ZjAwMDgpIGFuZCBEUF9MVFRQUl9BTFBNX0NBUEFCSUxJVElF
Uw0KPiAoMHhmMDAwOSkuIFRoZSBleGlzdGluZyBoZWxwZXJzIGRvbid0IHVzZSB0aGVzZSBieXRl
cy4NCj4gDQo+IHYyOiBBZGQgRFBfTFRUUFJfQVVYX0xFU1NfQUxQTV9TVVBQT1JURUQgYml0IGRl
ZmluaXRpb24uDQo+IHYzOiBVc2UgZHJtL2RwIHByZWZpeCBhbmQgZGVzY3JpYmUgdGhlIERQX0xU
VFBSX0NPTU1PTl9DQVBfU0laRQ0KPiBjaGFuZ2UuDQo+IA0KPiBDYzogSm91bmkgSMO2Z2FuZGVy
IDxqb3VuaS5ob2dhbmRlckBpbnRlbC5jb20+DQo+IENjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnDQo+IFJldmlld2VkLWJ5OiBTdXJhaiBLYW5kcGFsIDxzdXJhai5rYW5kcGFsQGlu
dGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQW5pbWVzaCBNYW5uYSA8YW5pbWVzaC5tYW5uYUBp
bnRlbC5jb20+DQoNClJldmlld2VkLWJ5OiBKb3VuaSBIw7ZnYW5kZXIgPGpvdW5pLmhvZ2FuZGVy
QGludGVsLmNvbT4NCg0KPiAtLS0NCj4gwqBpbmNsdWRlL2RybS9kaXNwbGF5L2RybV9kcC5oIHwg
NSArKysrLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2RybS9kaXNwbGF5L2RybV9kcC5oDQo+IGIv
aW5jbHVkZS9kcm0vZGlzcGxheS9kcm1fZHAuaA0KPiBpbmRleCBlNjNjN2YwNzVmNTQuLmVhOGNk
NDk3YjY1OCAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9kcm0vZGlzcGxheS9kcm1fZHAuaA0KPiAr
KysgYi9pbmNsdWRlL2RybS9kaXNwbGF5L2RybV9kcC5oDQo+IEBAIC0xNTQxLDYgKzE1NDEsOSBA
QA0KPiDCoC8qIFNlZSBEUF8xMjhCMTMyQl9TVVBQT1JURURfTElOS19SQVRFUyBmb3IgdmFsdWVz
ICovDQo+IMKgI2RlZmluZSBEUF9QSFlfUkVQRUFURVJfMTI4QjEzMkJfUkFURVMJCQnCoMKgwqAg
MHhmMDAwNw0KPiAvKiAyLjAgKi8NCj4gwqAjZGVmaW5lIERQX1BIWV9SRVBFQVRFUl9FUV9ET05F
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
MHhmMDAwOA0KPiAvKiAyLjAgRTExICovDQo+ICsjZGVmaW5lIERQX0xUVFBSX0FMUE1fQ0FQQUJJ
TElUSUVTwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
MHhmMDAwOQ0KPiAvKiAyLjEgKi8NCj4gKyMgZGVmaW5lIERQX0xUVFBSX0FVWF9MRVNTX0FMUE1f
U1VQUE9SVEVEwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICgxIDw8IDApDQo+
ICsjZGVmaW5lIERQX1RPVEFMX0xUVFBSX0NOVMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAweGYwMDBhDQo+IC8qIDIuMSAq
Lw0KPiDCoA0KPiDCoGVudW0gZHJtX2RwX3BoeSB7DQo+IMKgCURQX1BIWV9EUFJYLA0KPiBAQCAt
MTcyMCw3ICsxNzIzLDcgQEAgZW51bSBkcm1fZHBfcGh5IHsNCj4gwqAjZGVmaW5lIERQX0RTQ19C
UkFOQ0hfQ0FQX1NJWkUJCTMNCj4gwqAjZGVmaW5lIEVEUF9QU1JfUkVDRUlWRVJfQ0FQX1NJWkUJ
Mg0KPiDCoCNkZWZpbmUgRURQX0RJU1BMQVlfQ1RMX0NBUF9TSVpFCTUNCj4gLSNkZWZpbmUgRFBf
TFRUUFJfQ09NTU9OX0NBUF9TSVpFCTgNCj4gKyNkZWZpbmUgRFBfTFRUUFJfQ09NTU9OX0NBUF9T
SVpFCTEwDQo+IMKgI2RlZmluZSBEUF9MVFRQUl9QSFlfQ0FQX1NJWkUJCTMNCj4gwqANCj4gwqAj
ZGVmaW5lIERQX1NEUF9BVURJT19USU1FU1RBTVAJCTB4MDENCg==
