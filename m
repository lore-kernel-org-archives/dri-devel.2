Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED58CA5FCB
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 11:32:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F138B10E029;
	Thu,  1 Oct 2026 11:32:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="lr2C6XN+";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C21910E029;
 Thu,  1 Oct 2026 11:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790854346; x=1822390346;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nd5wejIx6v3lr/9sjMk5ug99/yt0yItnvrIkfWcA9sA=;
 b=lr2C6XN+iwWzRss5vL0ZsyOoiuwWIU5ofeYyvo5irWUMVdlRpN0IojHs
 fvdPFYLU5tmY0hIdLijx8/crLIkrsnUn00cZDKOGuijrbkSmCfJ3JZYrP
 cRpyotTteIc2Yx13UrUrLcs5pXZ/EP5rsdeQi8G0SJPQh6e0VwkEG7psz
 RCEeXC403wMnsbdMtttYOvzBKBRhWS850HLD5x1rxVdxbMTFR1ve2zONZ
 4nnXNa9ebrPT1FrWIiAh+EJxNijwalDEIE48u5I+nmxyiWV81SL4mGWqP
 SDbDl+tfchrCrlFVZBIhSbWXG/cmpm5YBp5SAm+pYJIqYYcAjX7SJNSdp A==;
X-CSE-ConnectionGUID: jwsRoh5RQBSxSLqJkcqhMw==
X-CSE-MsgGUID: ejAvNgHiSM+lpkB7Zz2r1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="91624589"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="91624589"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 04:32:26 -0700
X-CSE-ConnectionGUID: MefnMalHR7KHTe4BMTaH9Q==
X-CSE-MsgGUID: DFNrPMhvR9ybRpqviJPP/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="275504421"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 04:32:26 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 04:32:25 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 04:32:25 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.47) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 04:32:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E41AJ/eYqRl+xP8tAd/k6L7RbNw6T11jeUBWKFKMPX9tBcfLk8AkytopFN9v5fsI9rn9+zF64hDG+MulKGI/APHPkVFGquIQMFLgMyXGHuKUfTEzEWoNpKWXR9ZaGaiyT2dUDDIxVgcmLSuBcT1QlSbeY1b7ZUWpTL/87mXKiHPO1YpYcRXfPWcrrnr/d87jMHjjgUZCUztL7Qyg+wpnbcVsG+VEIpVem9r0RxjgJ+XrynD7GvTPmnCX3YknPKpKQOzkm+2+CgRwtnqxg1uH/B02eoNyY9deyyGGm2vx2tsIRl9HfovCwebbGK/UWztDTMDkxH3FZIAUddc4gzMwNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nd5wejIx6v3lr/9sjMk5ug99/yt0yItnvrIkfWcA9sA=;
 b=iIYkOLY1g6klgZTulzuraNjRwLTFc1thSKpC40eTEdaqcP2c8fLAycCOxjaSKyAZpOh7Vw6jyg9tQDI87k/0BQyvSMAm2D2sIbGWzduEEytx//YMBjSNt0Ogc+umOKxM9bGr5LPyZxFHfRW41Pyz7H+sZND+ZdEHxy5HU1TxpsocG9uTcBGKkC/luSs7JKHkMq/A+GUBzrIyAuZKXhikYcZ+8GvwsCJTB/QYDJu4dB4Tbmj7hJa7wwF8ajsjGeNaTaM/sUz9/XIv1LolWgCpOfo1eNJH0D0iCBoKnun0C8dqdZz/2KTBr1zbGMbyfUXipqLfcUhQHCGWeTRjnDTzoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8049.namprd11.prod.outlook.com (2603:10b6:8:116::6) by
 DS0PR11MB7851.namprd11.prod.outlook.com (2603:10b6:8:fb::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.26; Thu, 1 Oct 2026 11:32:23 +0000
Received: from DS0PR11MB8049.namprd11.prod.outlook.com
 ([fe80::603c:772d:6793:d4eb]) by DS0PR11MB8049.namprd11.prod.outlook.com
 ([fe80::603c:772d:6793:d4eb%6]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 11:32:23 +0000
From: "Manna, Animesh" <animesh.manna@intel.com>
To: "Hogander, Jouni" <jouni.hogander@intel.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
CC: "Kandpal, Suraj" <suraj.kandpal@intel.com>, "Nikula, Jani"
 <jani.nikula@intel.com>
Subject: RE: [PATCH v6 04/18] drm/i915/alpm: Enable debugfs for DP2.1
Thread-Topic: [PATCH v6 04/18] drm/i915/alpm: Enable debugfs for DP2.1
Thread-Index: AQHdRUGGwwyySpHj1kGqgymAxs4Tubbj7NIAgAS30kA=
Date: Thu, 1 Oct 2026 11:32:23 +0000
Message-ID: <DS0PR11MB8049AF56AF4BFC89809B0E29F98A2@DS0PR11MB8049.namprd11.prod.outlook.com>
References: <20260915180449.277933-1-animesh.manna@intel.com>
 <20260915180449.277933-5-animesh.manna@intel.com>
 <337289744188eab13f37d8725002ce9dcbd4cc9f.camel@intel.com>
In-Reply-To: <337289744188eab13f37d8725002ce9dcbd4cc9f.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8049:EE_|DS0PR11MB7851:EE_
x-ms-office365-filtering-correlation-id: 12fd08c6-0819-4657-7967-08df1fafa97f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|366016|376014|23010399003|1800799024|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: b2X9sgblzWpn30tBOXfJQv+AdlimLIKY2dDYPYtejYC7x/D1VKSJfFfuPvtAydZX7i+cpDYvp7a/A18qJGFvSDXG3FrOe2jrlnZRacIV3dME9Wxm/8MKiD6sUvAT6yH5ZP1+6rwL/mE5Rzu2nWkzC07aply3lnSYGEq2mxRaFzMKtZCC+J9ebm/BKyJDBihlTBg571GCk5tsjFRy3ruTQcEn45/ZIG9valkvHlY2xCsiamxVA6LlHxcCEemRS/pFOPqpNDgBNkVAibHz2xq7in3qW/UNEaVCOhy/o6Enxkct/2KRTeIewIv9li2gZ8jiA699gAUhDXsgTtrAjORhGVgGWQdsL26XRLZxA2iSV6Gc87kuOtR7Ml8BZ1SH0UBUqjzR3tFVcQtLsmO3/DvcuPjn3B3JFsMF9V/WOHj0NjZ/+jGRSL8zo5YCgdeFmg0hLAUupkSgVCUZGKT4ZLeaKPbha9cfbwohA5MC0QWjIc1TOFfrT1tF3ttQDNScZP53+pI353w4diQCODwAjaW7MGzJU2lIv5RqvO3pr5Y2V9g4BXUTNPPKlKNNzQQi6iTyBeg0Ev+u2IXdN+ymTTsLOfoSvF1FvG6gPePTlzgWihMLqabN0Ccu10PAH1ni7PWJFl4AcDe9gSMEJM13JwSIwaDtMOwYDXq4oHmhdMnk4ImU9+D5Ns1EfXS+b4MU91B166HThHmh9izbbYmBJF9u4Q8wSUChaZ5fnnUZhjmeCPE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8049.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(376014)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnVtM1dySDR3R2RiQ3dBdG5MbjNseVQ0bS9sUEhUb0NjSHJwY3ZMZGtGbHZN?=
 =?utf-8?B?TERTdmhBaGNLcW00ejNzaWd2MmhMVVNwbnU4MXNvK1MwOVVQNlh0YUQrOUVk?=
 =?utf-8?B?WHFlZC9IaFdCMWVPZWkrNTVncWMzWEU0ekxGcEVLS0xYTGdyU2I4Q21VaVIr?=
 =?utf-8?B?OEgvVVRLaXRJMkFmOVFhRSs5V2czcFVmU1A4VVo3MkFOTjNBbmdrNkJXYlls?=
 =?utf-8?B?NFhYYVR3MEg4NDJBb3VJbGlYNnBiOXlNemQyY1l4alZ2WW9HTm42aFZYc3JR?=
 =?utf-8?B?b0FtUlBMcjFEbE9xYXd5WHd1OEFBZXJhSklLNTYwMHp0S0NCcUdVQ0t2d0Fy?=
 =?utf-8?B?VHE4NldpNGt2OVZQd2t1bHJ5a3A3bFdibGZvZmpEcEVzWFRQRlBWbFUyTE01?=
 =?utf-8?B?MTBYRXAxV0FNMGVXaDdPaE11RVI0UTcwMEluZXArN1N1K0RBcFptaDA2MnpY?=
 =?utf-8?B?aUdqZ2NPM0N1akQ1Z2tqaTZiSFZZOG1Sa3dHY1ZtK0p1NUZIZ3BHcDAvdXpi?=
 =?utf-8?B?ZC81eVRpWjJPSjlORnN6MW1nMmIwMEswUmlZckRySVZJRkp6QUhhak96V1l2?=
 =?utf-8?B?c0JqdldESFN1d0VFeWtETnlwVUs3UlNFcVhyakg3SHJZMGVmcVRKUldsZEtU?=
 =?utf-8?B?SmdtR2YyMmJMUHRaWnJRdllkR1Mxa0svSENnTm9rcVBjUUsvQVhUMGlsY25p?=
 =?utf-8?B?Q3JhTFB0VXlISU1CNzdIM0RVczM0blN5aUsyNVhFZUZWWTJPc2N0SExGUldo?=
 =?utf-8?B?M09MWWlmUlNIdTNodk15SXAwL2MybU1BSDljeDlQSzJzZXpOVVFJM29JS0s0?=
 =?utf-8?B?NmNMRFRXOStkWS9saTBmMWNEdTFQbkY3anBVcDBnaFpqTDlsc0VXSWRJVzVt?=
 =?utf-8?B?Q2ozb2N5OGluK1JzWE5hVGhJb2p4aEdEYWQ0RTBFTWtHc0ZveW9RR1pzL1Bs?=
 =?utf-8?B?REtiNk1MSGhYWCtXeDg0TTZhb1NhNEFFOXZ2cjBtQ2s2enhpSVBUOWpSc3g1?=
 =?utf-8?B?VDBqTFZEd2xyMzdWN1JoMWtiRjNUUVdYVW0zMkJRWW9GcFpDbFM0NXdyc29l?=
 =?utf-8?B?VFFmSk4zUDM5cE5QR2RDK0tBUmtZTm9EYkI4ZTR6dVExbWEwK1U2ZG5leFFD?=
 =?utf-8?B?WGpHMjZzNGdRVXg5WXlsUTF3alRpTzBOejhYbU10cHgvSTVvdG5INnFKRjE1?=
 =?utf-8?B?d2I1clJ6ODM1UEVzdGNXRm43eEk4aS92S1locXUxTlFqdEpEZ3ljWUo1L25h?=
 =?utf-8?B?YThQb2tmK2N3R1gybnUvWW5xWW9FZVBiMjlaZEF3RWljdFJYTy9oYWl3SnUy?=
 =?utf-8?B?SmM4OVczUE9od3RRRmM1QUhnYUtsajBvd3NPbVNidGp2bDYzdm02M2ZBQkIy?=
 =?utf-8?B?MFV4dFErMTVreU0rVU8vS3gxb01qVkNIaFl3ck9iUTVHTmRBMGhKdVU0Rmpi?=
 =?utf-8?B?OWFWSjBpeFF6SWIxM2tCa3F5RTZJTUNNSUIrN20vMkwyenJKOTU3QUowRlFZ?=
 =?utf-8?B?VUhvU3huNzZjTzBicVdGUXBuVlpRWVFUMXNhY1BxM1BYRVV5am55TG5vSHFv?=
 =?utf-8?B?MnI3ZDBZQy9XN1lDNnZGRk1OeUxxVFVmR0xoL3lDR2JWeFdMcS8wd3RRc1ll?=
 =?utf-8?B?SVU2c25WYmpYY1ZmMW40bHh2V1hkbHFIbHU4M052TkRHU09Jc0FNV3NjeUNS?=
 =?utf-8?B?RlB6dXl3eGpSbUg4YlhWYmJNVHNBZU5JeGVSVUxYVDcwM2c3eTA3ZmRqNGNX?=
 =?utf-8?B?NDBmbmRxTGhmUHpkb1crYzZxUXk4d3IvdjhsN2lQd1ZXbVRMWEpCUkpQWndG?=
 =?utf-8?B?OXVmKzdXajUrdjBydDZLYm9xVndVVVNkdDRzdVRyM3VPWTB1VnArUUEvTlNU?=
 =?utf-8?B?czkxV2pMYTd6NFFKYzFEZmdQOGFoYmhhSFJhaHdEMjlNLzdoNnJZZXVkdVlX?=
 =?utf-8?B?eUhBUHdJb2V3d0lrdlRuNVkxY01BZGtSSXJMNEZIYUF0dVlWeGpKdFhmNk1y?=
 =?utf-8?B?aUZEdllTQkh2bkRIaDNrOTB3MDhOQW95aDMraTM2ZkVmTXJxcGZmb0JqVFRF?=
 =?utf-8?B?bCs4SFlRSTdvTG5TejBPNnZOSlBFbUIwdDU5Q0hQZmo1MTBORWtRVFNBV0xP?=
 =?utf-8?B?ZWdnMi9LcElFdW4xUUtxSjNrejBMWVhFQ0dLS3cyV0JzSnU3Rnd3NjJiZmdS?=
 =?utf-8?B?cytzNU9TQWZjeXFoalRwUUpySWIyNTRtRTJrdVYxWjBHalNtZXJLZElUbDZN?=
 =?utf-8?B?ZGtvdnVSbkpZYktGbVhvd1MyK243VFA2eTdXNVdpbFhYOTcvYzJDWXgyOVk4?=
 =?utf-8?B?WmdIMk5UUDNRWXRPUWpuTG9aY2tGY05oV1F2NXBJTkNGOHVIQi81OFdrbUF3?=
 =?utf-8?Q?I2SrQ2uT50H3Szl4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: umYgRoDvtP2kUiDbgwlZS6HHPDbvovr5oSwjZiQWGavOzg101QaAODiJP467ItFcDj7LqiY1RPjQFVel7xzZgnjih4CIjjh6w+nCH6MKTh9FkmPtX/uN6WM31MJCzJt3z2BFuWh0mPdxuNGbDHyGqpJFo4Rb0lPiu75pkyq1qvJKQzVfqRs8ScAkDm11spVk2JxphRe7q4alEaY4uP5kcu4cW9eCQZ4iIsAk/M7hXVDuslOAgxRKK9pmSu1Xew+XGA+0DKNBluMZUJLk1ufbhY6+sOn1uqZgjPsLrKugFyqqspfFdJG4S9LJSdIgZfxytopZqLppZHE42He9F2hYNA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8049.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12fd08c6-0819-4657-7967-08df1fafa97f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 11:32:23.3266 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jVJURLBvkrqomemYabSONru8nB8KeKTM0qcXhwdjHL77wbCtqSXyB9z89CDVtTwz4SKEPmPzoqutpi1mk059Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7851
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSG9nYW5kZXIsIEpvdW5p
IDxqb3VuaS5ob2dhbmRlckBpbnRlbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDI4
LCAyMDI2IDQ6NTMgUE0NCj4gVG86IGludGVsLXhlQGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgZHJp
LWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgTWFubmEsDQo+IEFuaW1lc2ggPGFuaW1lc2gu
bWFubmFAaW50ZWwuY29tPjsgaW50ZWwtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzog
S2FuZHBhbCwgU3VyYWogPHN1cmFqLmthbmRwYWxAaW50ZWwuY29tPjsgTmlrdWxhLCBKYW5pDQo+
IDxqYW5pLm5pa3VsYUBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMDQvMThd
IGRybS9pOTE1L2FscG06IEVuYWJsZSBkZWJ1Z2ZzIGZvciBEUDIuMQ0KPiANCj4gT24gVHVlLCAy
MDI2LTA5LTE1IGF0IDIzOjM0ICswNTMwLCBBbmltZXNoIE1hbm5hIHdyb3RlOg0KPiA+IEVuYWJs
ZSBBTFBNIGRlYnVnIGluZm8gdGhyb3VnaCBsb2JmIGRlYnVnIGluZm8uDQo+ID4NCj4gPiB2Mjog
Y29zbWV0aWMgY2hhbmdlLiBbU3VyYWpdDQo+ID4gdjM6IFVzZSBjb21tb24gYXBpIGluc3RlYWQg
b2YgRElTUExBWV9WRVIgY2hlY2sgaW4gbXVsdGlwbGUgcGxhY2VzLg0KPiA+IFtKYW5pXQ0KPiA+
IHY0OiBBZGQgZGlzcGxheS12ZXJzaW9uIGNoZWNrIGFzIGl0IGRyb3BwZWQgZm9yIEVEUC4NCj4g
Pg0KPiA+IENjOiBKb3VuaSBIw7ZnYW5kZXIgPGpvdW5pLmhvZ2FuZGVyQGludGVsLmNvbT4NCj4g
PiBSZXZpZXdlZC1ieTogU3VyYWogS2FuZHBhbCA8c3VyYWoua2FuZHBhbEBpbnRlbC5jb20+DQo+
ID4gU2lnbmVkLW9mZi1ieTogQW5pbWVzaCBNYW5uYSA8YW5pbWVzaC5tYW5uYUBpbnRlbC5jb20+
DQo+ID4gLS0tDQo+ID4gwqBkcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0u
YyB8IDYgKysrKy0tDQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rp
c3BsYXkvaW50ZWxfYWxwbS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2lu
dGVsX2FscG0uYw0KPiA+IGluZGV4IDQ4MDFmYzZiYWRlMi4uOTAxNDkzYmIxNDQ4IDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5jDQo+ID4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9hbHBtLmMNCj4gPiBAQCAt
NzM5LDggKzczOSwxMCBAQCB2b2lkIGludGVsX2FscG1fbG9iZl9kZWJ1Z2ZzX2FkZChzdHJ1Y3QN
Cj4gPiBpbnRlbF9jb25uZWN0b3IgKmNvbm5lY3RvcikNCj4gPiDCoAlzdHJ1Y3QgaW50ZWxfZGlz
cGxheSAqZGlzcGxheSA9IHRvX2ludGVsX2Rpc3BsYXkoY29ubmVjdG9yKTsNCj4gPiDCoAlzdHJ1
Y3QgZGVudHJ5ICpyb290ID0gY29ubmVjdG9yLT5iYXNlLmRlYnVnZnNfZW50cnk7DQo+ID4NCj4g
PiAtCWlmIChESVNQTEFZX1ZFUihkaXNwbGF5KSA8IDIwIHx8DQo+ID4gLQnCoMKgwqAgY29ubmVj
dG9yLT5iYXNlLmNvbm5lY3Rvcl90eXBlICE9DQo+ID4gRFJNX01PREVfQ09OTkVDVE9SX2VEUCkN
Cj4gPiArCWlmIChESVNQTEFZX1ZFUihkaXNwbGF5KSA8IDIwKQ0KPiA+ICsJCXJldHVybjsNCj4g
PiArDQo+ID4gKwlpZiAoIWludGVsX2FscG1fc291cmNlX3N1cHBvcnRlZChjb25uZWN0b3IpKQ0K
PiA+IMKgCQlyZXR1cm47DQo+ID4NCj4gPiDCoAlkZWJ1Z2ZzX2NyZWF0ZV9maWxlKCJpOTE1X2Vk
cF9sb2JmX2RlYnVnIiwgMDY0NCwgcm9vdCwNCj4gDQo+IFRoZXNlIGFyZSBuYW1lZCBhcyBpOTE1
X2VkcF9sb2JmX2RlYnVnIGV2ZW4gaWYgdGhleSBhcmUgY3JlYXRlZCBvbiBEUA0KPiBjb25uZWN0
b3IuDQoNCldlIGhhdmUgY291cGxlIG9mIG9wdGlvbnMsDQppKSByZW5hbWUgdG8gaTkxNV9sb2Jm
X2RlYnVnLCBidXQgYmFja3dhcmQgY29tcGF0aWJpbGl0eSB3aWxsIGJlIGJyb2tlbi4NCmlpKSBj
cmVhdGUgYSBuZXcgZGVidWdmcyBmb3IgZHAgLSBpOTE1X2RwX2xvYmZfZGVidWcuIENvZGUgZHVw
bGljYXRpb24gd2lsbCBiZSB0aGVyZS4NCmlpKSBhcyBMT0JGIGludHJvZHVjZWQgZmlyc3Qgb24g
ZWRwIHRvIHNvIERQIHdpbGwgdXNlIGV4aXN0aW5nIGVkcC1pbnRlcmZhY2UuIA0KDQpHb29kIHRv
IGtub3cgeW91ciBvcGluaW9uLCBJIHNlZSBhbGwgdGhlc2Ugb3B0aW9ucyBoYXZlIHByb3MgYW5k
IGNvbnMuDQoNClJlZ2FyZHMsDQpBbmltZXNoIA0KPiANCj4gQlIsDQo+IEpvdW5pIEjDtmdhbmRl
cg0KDQo=
