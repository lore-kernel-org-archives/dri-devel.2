Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EEB606A320
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=itneb07q;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Vow+vIm+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE1C310FB86;
	Wed, 18 Nov 2026 12:15:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B47E410FB86;
 Wed, 18 Nov 2026 12:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795004146; x=1826540146;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=WKy1YScGyqqk6Q7sB60sYuoH8J4FDq78Ca/R8y4/W1Y=;
 b=itneb07qYj3Aq2fCUiWGp8dAAm5KlwBX7S2woaGojiMthwQBITE+o770
 1aW0KflFEi6TYDPXs4rHwFMmXMYWP1NZSauqQ5dswJHyYNEhx7msYr6Lt
 eeJZ7K9lp8mvEPJibZjF3CDXRB7CPS1JGLkGISOEAuAa4uQJsLP3oDY8F
 XJhkmyP/SEK4XTQlcc1CrPYNj/w+iAC+VvFTdVcaV1eJ0mT1sH15QT98N
 7xhYUQL4Ixu9bNcT891ZlnJiTNMYpAR/rWM9TIkWRPMsquQuU3BlR6d/b
 wxinHRrnRZHn9XgbNHJT1EHeXIy+C4km90PnCbPo678pF1vU8PE5Z6DOb w==;
X-CSE-ConnectionGUID: Bre5akgZQQOpbtwXkhHJAg==
X-CSE-MsgGUID: keuNCAiQSEWAw5pI/9q1eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3692739"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3692739"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 04:15:46 -0800
X-CSE-ConnectionGUID: DcpYhVPyTZurknoOPoHvSQ==
X-CSE-MsgGUID: LYB5Pe4VTBCN2nQvrl31gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10136904"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 04:15:45 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 04:15:44 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 04:15:44 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.43) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 04:15:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yLR3ofyzWEL+m9aRrnq1UrMImIQv+77tVYc7ggJtFx4wbCJEdJOyIouS5+6NuZo/vAzSNqXAyTRQfm0Ta6Ml+01cThtzYWCTqUbyCmyqVqHRGKhsORaoSJBDUfkoQbGdyruj6RKYmQNA88n7XVu01Dkv2wXhjmv/Lz1IxkEMGu9COmll9utaS+q6v8/1/Ms0Ap7V4Cq0lvrNhWl6g/Cxkms75C67tdp62EdPR0zvjMrFuZ1KKLiD/rqTScqh8IEePG9kWf1pVtz+sZskFyb+tVYxwy7vx8mXNbnozaeuO06OY5QantYJI/GCFbN0ArF91AdHtdciiFtQNYfGWNQecA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKy1YScGyqqk6Q7sB60sYuoH8J4FDq78Ca/R8y4/W1Y=;
 b=X58i0w1RM4oZm9AEdDJjMjanJXp8KB6T6WrZPmeT558ejdGMXfpbiytY/P6eifoEzGttdgfNR+vYbqmQSD92RdHGxs0dYmy5+yw37aQoUP0Pd28QulUqaMYH80s/jB9aULPFzzXM7yyudjhPhT8vzFY96pdw5BTjZVVlgjDNFbjhB+5U9pcdh9z0aCXmwfk23MLMR2hV/v+NXR8OSiaCfRlPKFI99iJJwtep0tAwSmYoubAstc8+Qw7itF7SStQk3hwX68bE4UwgXcVmJ28Dav5TfokC/tErkMG/7Ko93QjOYx2xnh8f7teGnY+exWUYGpopaYsFSd5ck4bvT+VyTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKy1YScGyqqk6Q7sB60sYuoH8J4FDq78Ca/R8y4/W1Y=;
 b=Vow+vIm+jtbzZXa4MhC1eOH/FnaIIT4FO0DEu0GNDDioPxrFPvWN8KuwYb7ZjJWTQ/DPRi885qYu33kzgoRTggyXo5kAdCdPRGLKV1pEKuNhNXIXiMBAvc/v6LDqhdxWMaIWTzzH1o7BtsNYwH3X22hw8J4Yxq/nxQlOza3kJwc=
Received: from LV2PR11MB6024.namprd11.prod.outlook.com (2603:10b6:408:17a::16)
 by CY8PR11MB6868.namprd11.prod.outlook.com (2603:10b6:930:5c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 12:15:42 +0000
Received: from LV2PR11MB6024.namprd11.prod.outlook.com
 ([fe80::38ad:3190:bbb2:412b]) by LV2PR11MB6024.namprd11.prod.outlook.com
 ([fe80::38ad:3190:bbb2:412b%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 12:15:42 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Manna,
 Animesh" <animesh.manna@intel.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>
CC: "Kandpal, Suraj" <suraj.kandpal@intel.com>, "Nikula, Jani"
 <jani.nikula@intel.com>
Subject: Re: [PATCH v7 09/20] drm/i915/alpm: table based establishment period
Thread-Topic: [PATCH v7 09/20] drm/i915/alpm: table based establishment period
Thread-Index: AQHdZQyNHs4RZotjBEuX3RnwvCuCKbcz4vWA
Date: Wed, 18 Nov 2026 12:15:42 +0000
Message-ID: <5fed14c7b49282a500567f12a57ace69a649f773.camel@intel.com>
References: <20261026054001.799894-1-animesh.manna@intel.com>
 <20261026054001.799894-10-animesh.manna@intel.com>
In-Reply-To: <20261026054001.799894-10-animesh.manna@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6024:EE_|CY8PR11MB6868:EE_
x-ms-office365-filtering-correlation-id: c254cfd0-294c-4c6f-1ab6-08df456daa86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|261102123227099003|261026140227099003|261026121527099003|261028144727099003|261022075727099003|261021123027099003|261021121427099003|261022105027099003|38070700021|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003|261009223027099003|3023799007;
x-microsoft-antispam-message-info: jBoCzcUr2pavogcvZFl9Nfdouzs9njI1klbFnWKaER7oQpQjCRqvLLmomjob+AFD+bTEjc3dbSRN60ZU5i2EsXDMuwlZNCxiK+RIArPWb6EM2wOo9ZScJ4Yq6JY08Hr1zFVzD6TCQHAKBoNsvmEcUHPkuZdIhhi8IsxZZgbJE4u2ryi1UQy+A6MJYlAa88whqUVqiPpdhXMIUJSdb79tDH61w+BVjnoNKfMQJ85t0CVWxPiPQBrMlmhq1gkfP39XPQGr6cEWx0U8M/Aii2t03AJI3JCimZA6leBTOIKlu1cuAJSN2wIEz7fIi+vwvS8HyCmeswyKeZIILQ/7DZ1q+fDqyDueJWiwr95mwQRd7+jFu738uoaFs6fOloFjxRzPkj8mhKPRZ7ibQFH1BUkbOunToLgzYZK7mTLUVqEc5P+ju1MM8B21HbyloPkrtkq+Tx/zRtdaOH05jb46cGgBE9XBxALzBpyicJKndCUBMgej7E9b4zaPN+I8L8bhF5jhJi89LXzgMZAe5UqJ5jtzzMrroipoIP543iMcTtvdy86YP8jW+9usHMhthuVuFy5LnC0+o8ot0qwPI8uACQ7mOzz+VxVgFjD5/U3x+JLJmSVhk9MGPOom76FGnZMe/mv6tc2Qs+1LuCV+3ddo8e0rYlAiANj+O7YPzeUijOBT6a7dWo2ootdyb2UYWaLDI6WvCyDPOjZ8yTCmMzEGHU+7+Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB6024.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(261022075727099003)(261021123027099003)(261021121427099003)(261022105027099003)(38070700021)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(261009223027099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1VDcUUvMm13cVhKZ0hPY0xSZkFwbDFqTFJ1VXpUcm9hQ05JandEaDZVVkgx?=
 =?utf-8?B?dTIwbUQzdzBXQkdkbWZKbGt4cEl6NVR6WjhhZzlDazJVaG5oNXR2RS80ektm?=
 =?utf-8?B?ekFlNHNuZk1VZ2xtRHNJRGJRci9iakNCK1duUkdEUVQ5dTRuOXpmeXJzODJy?=
 =?utf-8?B?VXpJUDFRQUQ1S2x5Wk1TcFB2bVIwYnpRS0tYVk1nTXc1YXZFREdoTXRKc1JD?=
 =?utf-8?B?cDJqMXArdVZBcXgzM1QvVnAwYjE4YndodjV6U3NsOFFtVnorWElQZHNmMTJa?=
 =?utf-8?B?NjlxbnZIbmJ3RkdHcTN6T1hGNDFFOVl5ejl5ZVJlTFBCRTFpd1VzVmo0WXR2?=
 =?utf-8?B?alZIeHh0K3VmY0NIMlY5NGgrdWF1MXhwNElvRjdJMStOTFhQOFd3bjh0TDA4?=
 =?utf-8?B?QkRtTU5STmJpSVdqKzJIM2FHYXVYODdab2w5Y1VIOU9neXJJSHlyQmxWc0M3?=
 =?utf-8?B?MmpCdTFJeXRFeUhWVFRZT3RITjNzempTS1FHRktHYkQyeUdrTlp0WGpKNytv?=
 =?utf-8?B?TWZMY2pmTDU3Q2w4RlBKclRPVSt2OXk4TjAzb0N6ZHQzV3MzN1BQdE5KL0Q3?=
 =?utf-8?B?ZDh1SklPQ1pQY3pKNnhXRlFQZUpvZUQ0NDc5WGt3dzR2bHpSanVvYkw2Rm5W?=
 =?utf-8?B?U3ErYWlnZjBua0p5ZUI1enMrV2N6OS92dlVadzBaZTRFOEtHQmtkVlB0anFv?=
 =?utf-8?B?TlNsbDFJUjRucVZyRXBwT3A0TXZkUCtyM1ErR0Q4cjc1VGIycWJpTE9QT3cv?=
 =?utf-8?B?VWh6YkhHN09ZanBrV0lNRHNEWmNSc3NQZE9nZ1EwYWhoRUVaZnR6Zit0cUdQ?=
 =?utf-8?B?S0l4TGpHdzRLcmZLNkVrb2hqb1hZY2xxaTVCRXR5RWtMeEYzTVhWeHJZWHJz?=
 =?utf-8?B?RjJFZ1lOcHNYSnNRVy85bjZBbVU2a0NlUWJ4ZnJsbEtGMWlianZkaERieWNp?=
 =?utf-8?B?VU1mQmRiMGk2dnhXa2tyRmgyaVphMFdOQ1NXMjl3RDFEVGZDUzVpNjhXSkgx?=
 =?utf-8?B?bXN5Tkp5b3A5VVQrK3JxZ0srODVxOHpDQTluTWlQU3pvWUZ1VU02M2prUE5W?=
 =?utf-8?B?Zk5SY0RJZnVTT01uQng1aHVka2JwZFRwT1F1aWVDY0RpVmNacVd1dHhJbm5B?=
 =?utf-8?B?eW1yaGlMWEFWR21CdjFRd3R3WEJSeksrODJTV3hqeE1TeUg3SlgwZk1TenZw?=
 =?utf-8?B?ZlBPS0FkRE1CLzFsaCtBUDVsZDZNVWsyOExwNXI5WUJlVnR2cmdmZVUxeXMr?=
 =?utf-8?B?VmcyaFptL1krckdHQmdUNHUreThBRGJjOGFrUmxHOElBZTlXK3N2YUFYZ1Vz?=
 =?utf-8?B?WFNUTjYzc0hYemhQUmV1dm41ZFNLbnI1ZUJpK1RMTGU3YTZGQUpuaU55MU5r?=
 =?utf-8?B?cGJnc3FGd0tsSThwcUdkbzY4VnZ6d3k5NHVLUlZ3S2Z4aDFnTk5rWHROQjRO?=
 =?utf-8?B?NHI0cTJJWTNKUkpySG44M2g3eU9NZW1TSWY1dVFSUTlWb1VSaTNTbmFnWU5E?=
 =?utf-8?B?aS84aUhoYWNqSUh3ZnJpSXp5R05zZXE1UDNOdWRvN2ZzNTZoVnBhcFB4bVQ5?=
 =?utf-8?B?ek83bHBuWkxBaDZpMGlXM0lVT3E3Y0Z2ZGdxSWdYVE1La2ZNL2FJRnY3SEhU?=
 =?utf-8?B?UHFEYVhrN3Z2eW9IM0p3TDFOc2cxcW41YWxSdXBHaWdQS1lIUXh1RllsYjdF?=
 =?utf-8?B?OW1rWHFCN1lmM0tHVThta2pQQUk4d3dxYVdkODdpcDMvVENMS0FyRWJwTFVy?=
 =?utf-8?B?V0pBMUl6dWxqUHIzQWc1Q0pva2NxN2FZbFNDU05rWmZ6MS9MREpvQUtKeWVX?=
 =?utf-8?B?WkQzOFFVVkJkQUJVOXNab0hqVG41Z0RnMy9HUTNRSmV0b29SZnU5c1FFdGxx?=
 =?utf-8?B?QVR5WXJTK2hNb3hIUVlEeHloMXdsNGFYb2dnSDJZSzl6K2J4Ni9Ma2VacFRV?=
 =?utf-8?B?TTdJdTNFUTNhRU1LdmZ6YUx1NkE2RmczdFBvekxTSDZONkdMYlphQ3Z2emFL?=
 =?utf-8?B?NHFwaCtEUjFtakNyZFUzcDlEYUl3aVlaemFhSlZWdnR0Uk9LcXJRL0xJV205?=
 =?utf-8?B?RWY2aHFqL203cGZweExoSXZGdElUU2dYZlFzMWpjUUhGeVJ5Q2tpQ1ZRNEdU?=
 =?utf-8?B?cEpWVHdacmhTbXdZYlA2L3NGUEpRcFVGNm9RTkVVREVjdTlaSTJ4OGMwUXlv?=
 =?utf-8?B?ZzRRQkRvMnZGQmtkeEkxV0ZpTzhJVXhicDdoWDl4cGtQSlpuQ1k2Q2NSbE84?=
 =?utf-8?B?M3QrMXJaUkNOak5HYnJEMHVrY3dOVE9JdHBSdENuMExXYzVFc3hQZlUwRkxk?=
 =?utf-8?B?Y2R4cHFzN2xraldIVEIzUzhOSFZCUUYrN1AwRTl3TWJqSFhhYTJoYndRNkt5?=
 =?utf-8?Q?xhEOUxneChYULsMk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EAB84B111BEF9A42A4C1D1698A1960AC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hM2vO1EQdGsSsZL8EA/5lMr41pNUZiqTLVQRUbH0ZmYP8VMIaDrjW0hSYNtmxuc4NDi5ohwl4Ke/lkSNGl9vQ8pfsrFRacS39pvU9H7nlkR31cNGDk68q1Tf+h2J2pjTI5smezX8KMHohOfBTeuk5vKzqln+emrF+BeeWDaoaQpu12qNNNan6f2CoF791NFdkQQh5MTC/QWpr16t1yUR+WBlWxKaTNblxB4VND9ihG4/jozB3T6V9eOE+WDDOQFpOTvmqxZzwJYOqN8iS/rzpDpdWULYtdPyf3vb2vEQpM9OJr1dUZg8hbVkMocHE54UqC1cbmJDNIFyJGsIAFNtWw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c254cfd0-294c-4c6f-1ab6-08df456daa86
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 12:15:42.4526 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zx664krwgrOkBv5zDL9WVlDLiToDjXX5WheyR7JCbYvhcZN/NDVJpYaisfAbB4nHAyRTvMJxabsnzyfXQCkU4xJH4/jGR4YbVIx08sV0gZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6868
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
PiBXaXRoIExUVFBScyBwcmVzZW50LCB0aGUgZXN0YWJsaXNobWVudCBwZXJpb2QgY2FsY3VsYXRl
ZCBieSB0aGUNCj4gZm9ybXVsYQ0KPiBpcyBzaG9ydGVyIHRoYW4gdGhlIHZhbHVlcyB0YWJ1bGF0
ZWQgaW4gdGhlIERQMi4xIFZFU0Egc3BlYyBieQ0KPiByb3VnaGx5DQo+IG9uZSBMRlBTIHBlcmlv
ZCBwZXIgTFRUUFIsIGV2ZW4gd2hlbiBtYXggc2lsZW5jZSBhbmQgTEZQUyBwZXJpb2RzIGFyZQ0K
PiB1c2VkLiBUaGlzIGhhcyBiZWVuIG9ic2VydmVkIHRvIGNhdXNlIGZsaXAgZG9uZSB0aW1lb3V0
cyBkdXJpbmcgQUxQTQ0KPiB0ZXN0aW5nIG9uIGEgc2V0dXAgd2l0aCBMVFRQUnMuDQoNCldlcmUg
eW91IHNlZWluZyB0aGVzZSB0aW1lb3V0cyBhbHNvIHdpdGggYWxsIHRoZSBmaXhlZCBjYWxjdWxh
dGlvbnMgaW4NCnRoaXMgdmVyc2lvbiBvZiB0aGUgcGF0Y2ggc2V0IGFuZCB3aGVuIHVzaW5nIG1h
eCBzaWxlbmNlIGFuZCBsZnBzDQpwZXJpb2RzPw0KDQpCUiwNCkpvdW5pIEjDtmdhbmRlcg0KDQo+
IA0KPiBVc2UgdGhlIGVzdGFibGlzaG1lbnQgcGVyaW9kIGZyb20gdGhlIFZFU0Egc3BlYyB0YWJs
ZSBmb3IgdGhlIGxpc3RlZA0KPiBsaW5rIHJhdGVzIHdpdGggMSB0byA2IExUVFBScy4gRmFsbCBi
YWNrIHRvIHRoZSBjYWxjdWxhdGVkIHZhbHVlIGZvcg0KPiBsaW5rIHJhdGVzIG5vdCBpbiB0aGUg
dGFibGUsIExUVFBSIGNvdW50cyBiZXlvbmQgdGhlIHRhYmxlIGFuZCB3aGVuDQo+IG5vDQo+IExU
VFBSIGlzIHByZXNlbnQsIHdoZXJlIHRoZSBmb3JtdWxhIGFscmVhZHkgbWF0Y2hlcyB0aGUgc3Bl
Yy4NCj4gDQo+IHYyOiBBZGQgY2hlY2sgZm9yIG5lZ2F0aXZlIGVycm9yIGNvZGVzIGZyb20gZHJt
X2RwX2x0dHByX2NvdW50KCkuDQo+IFtzYXNoaWtvXQ0KPiB2MzoNCj4gLSBFeHBsYWluIHdoeSB0
aGUgc3BlYyB0YWJsZSBpcyB1c2VkIGluc3RlYWQgb2YgdGhlIGZvcm11bGEuIFtKb3VuaV0NCj4g
LSBEcm9wIHRoZSBuby1MVFRQUiByb3cgYXMgdGhlIGZvcm11bGEgbWF0Y2hlcyB0aGUgc3BlYyB0
aGVyZS4NCj4gLSBEcm9wIGxpbmsgcmF0ZXMgd2l0aG91dCB0YWJ1bGF0ZWQgdmFsdWVzIGFuZCBy
ZXBsYWNlIHRoZSBsaW5rIHJhdGUNCj4gwqAgZW51bSBhbmQgc3dpdGNoIHdpdGggYSBwb3J0X2Ns
b2NrIGJhc2VkIGxvb2t1cCB0YWJsZS4NCj4gDQo+IENjOiBKb3VuaSBIw7ZnYW5kZXIgPGpvdW5p
LmhvZ2FuZGVyQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQW5pbWVzaCBNYW5uYSA8YW5p
bWVzaC5tYW5uYUBpbnRlbC5jb20+DQo+IC0tLQ0KPiDCoGRyaXZlcnMvZ3B1L2RybS9pOTE1L2Rp
c3BsYXkvaW50ZWxfYWxwbS5jIHwgNDMNCj4gKysrKysrKysrKysrKysrKysrKysrKy0NCj4gwqAx
IGZpbGUgY2hhbmdlZCwgNDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5jDQo+IGIv
ZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9hbHBtLmMNCj4gaW5kZXggMDA4Mzc1
MmQ5NGYwLi4yYmYyY2E5NTY0MzkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1
L2Rpc3BsYXkvaW50ZWxfYWxwbS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3Bs
YXkvaW50ZWxfYWxwbS5jDQo+IEBAIC0xMjQsNiArMTI0LDQyIEBAIHN0YXRpYyBpbnQgZ2V0X21s
X3BoeV9sb2NrX2xlbihjb25zdCBzdHJ1Y3QNCj4gaW50ZWxfY3J0Y19zdGF0ZSAqY3J0Y19zdGF0
ZSkNCj4gwqAJcmV0dXJuIGludGVsX2RwX2lzX3VoYnIoY3J0Y19zdGF0ZSkgPyBNTF9QSFlfTE9D
S19MRU5fVUhCUiA6DQo+IE1MX1BIWV9MT0NLX0xFTjsNCj4gwqB9DQo+IMKgDQo+ICsvKg0KPiAr
ICogRXN0YWJsaXNobWVudCBwZXJpb2QgaW4gbnMgd2l0aCBMVFRQUnMsIHRha2VuIGZyb20gdGhl
IERQMi4xIFZFU0ENCj4gc3BlYy4NCj4gKyAqIFRoZSBzcGVjIHZhbHVlcyBhcmUgY29tcHV0ZWQg
d2l0aCB0aGUgbWF4IHNpbGVuY2UgYW5kIExGUFMNCj4gcGVyaW9kcyBhbmQNCj4gKyAqIGFyZSBs
b25nZXIgdGhhbiB3aGF0IHRoZSBmb3JtdWxhIGdpdmVzIHdpdGggTFRUUFJzIHByZXNlbnQuIFVz
aW5nDQo+IHRoZQ0KPiArICogZm9ybXVsYSByZXN1bHQgaGFzIGJlZW4gc2VlbiB0byBjYXVzZSBm
bGlwIGRvbmUgdGltZW91dHMsIHNvDQo+IHByZWZlciB0aGUNCj4gKyAqIHNwZWMgdmFsdWVzIGZv
ciB0aGUgbGlzdGVkIGxpbmsgcmF0ZXMuDQo+ICsgKi8NCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qg
ew0KPiArCWludCBwb3J0X2Nsb2NrOw0KPiArCWludCBwZXJpb2RbNl07CS8qIGluZGV4ZWQgYnkg
TFRUUFIgY291bnQgLSAxICovDQo+ICt9IGx0dHByX2VzdGFibGlzaG1lbnRfcGVyaW9kc1tdID0g
ew0KPiArCXvCoCAxNjIwMDAsIHsgMTU1NjcwLCAxODExNjAsIDIwNjY1MCwgMjMyMTQwLCAyNTc2
MjAsIDI4MzExMA0KPiB9IH0sCS8qIFJCUiAqLw0KPiArCXvCoCAyNzAwMDAsIHsgMTUxMzEwLCAx
NzI0NTAsIDE5MzU4MCwgMjE0NzEwLCAyMzU4NTAsIDI1Njk4MA0KPiB9IH0sCS8qIEhCUiAqLw0K
PiArCXvCoCA1NDAwMDAsIHsgMTQ4MDUwLCAxNjU5MTAsIDE4Mzc4MCwgMjAxNjUwLCAyMTk1MTAs
IDIzNzM4MA0KPiB9IH0sCS8qIEhCUjIgKi8NCj4gKwl7wqAgODEwMDAwLCB7IDE0Njk2MCwgMTYz
NzQwLCAxODA1MTAsIDE5NzI5MCwgMjE0MDcwLCAyMzA4NTANCj4gfSB9LAkvKiBIQlIzICovDQo+
ICsJeyAxMDAwMDAwLCB7IDE1MzY1MCwgMTc3MTIwLCAyMDA1OTAsIDIyNDA2MCwgMjQ3NTMwLCAy
NzEwMDANCj4gfSB9LAkvKiBVSEJSMTAgKi8NCj4gKwl7IDEzNTAwMDAsIHsgMTUxMzUwLCAxNzI1
MjAsIDE5MzY5MCwgMjE0ODYwLCAyMzYwMzAsIDI1NzIwMA0KPiB9IH0sCS8qIFVIQlIxMy41ICov
DQo+ICsJeyAyMDAwMDAwLCB7IDE0OTIyMCwgMTY4MjIwLCAxODcyOTAsIDIwNjMyMCwgMjI1MzYw
LCAyNDQzOTANCj4gfSB9LAkvKiBVSEJSMjAgKi8NCj4gK307DQo+ICsNCj4gK3N0YXRpYyBpbnQg
Z2V0X2x0dHByX2VzdGFibGlzaG1lbnRfcGVyaW9kKGludCBwb3J0X2Nsb2NrLCBpbnQNCj4gbHR0
cHJfY291bnQpDQo+ICt7DQo+ICsJaW50IGk7DQo+ICsNCj4gKwlpZiAobHR0cHJfY291bnQgPCAx
IHx8DQo+ICsJwqDCoMKgIGx0dHByX2NvdW50ID4NCj4gQVJSQVlfU0laRShsdHRwcl9lc3RhYmxp
c2htZW50X3BlcmlvZHNbMF0ucGVyaW9kKSkNCj4gKwkJcmV0dXJuIDA7DQo+ICsNCj4gKwlmb3Ig
KGkgPSAwOyBpIDwgQVJSQVlfU0laRShsdHRwcl9lc3RhYmxpc2htZW50X3BlcmlvZHMpOw0KPiBp
KyspIHsNCj4gKwkJaWYgKGx0dHByX2VzdGFibGlzaG1lbnRfcGVyaW9kc1tpXS5wb3J0X2Nsb2Nr
ID09DQo+IHBvcnRfY2xvY2spDQo+ICsJCQlyZXR1cm4NCj4gbHR0cHJfZXN0YWJsaXNobWVudF9w
ZXJpb2RzW2ldLnBlcmlvZFtsdHRwcl9jb3VudCAtIDFdOw0KPiArCX0NCj4gKw0KPiArCXJldHVy
biAwOw0KPiArfQ0KPiArDQo+IMKgc3RhdGljIGludCBnZXRfZXN0YWJsaXNobWVudF9wZXJpb2Qo
c3RydWN0IGludGVsX2RwICppbnRlbF9kcCwNCj4gwqAJCQkJwqDCoMKgIGNvbnN0IHN0cnVjdCBp
bnRlbF9jcnRjX3N0YXRlDQo+ICpjcnRjX3N0YXRlKQ0KPiDCoHsNCj4gQEAgLTEzNyw3ICsxNzMs
NyBAQCBzdGF0aWMgaW50IGdldF9lc3RhYmxpc2htZW50X3BlcmlvZChzdHJ1Y3QNCj4gaW50ZWxf
ZHAgKmludGVsX2RwLA0KPiDCoAkJaW50ZWxfZHBfbGlua19zeW1ib2xfc2l6ZShjcnRjX3N0YXRl
LT5wb3J0X2Nsb2NrKSAqDQo+IDEwMDAwMCAvDQo+IMKgCQljcnRjX3N0YXRlLT5wb3J0X2Nsb2Nr
Ow0KPiDCoAlpbnQgbHR0cHJfY291bnQgPSAwOw0KPiAtCWludCBudW1fbWxfcGh5X2xvY2ssIHRj
ZHM7DQo+ICsJaW50IG51bV9tbF9waHlfbG9jaywgdGNkcywgcGVyaW9kOw0KPiDCoA0KPiDCoAlp
ZiAoaW50ZWxfY3J0Y19oYXNfdHlwZShjcnRjX3N0YXRlLCBJTlRFTF9PVVRQVVRfRURQKSkgew0K
PiDCoAkJbnVtX21sX3BoeV9sb2NrID0gNyArIERJVl9ST1VORF9VUCg2NTAwLA0KPiB0bWxfcGh5
X2xvY2spICsgMTsNCj4gQEAgLTE1NSw2ICsxOTEsMTEgQEAgc3RhdGljIGludCBnZXRfZXN0YWJs
aXNobWVudF9wZXJpb2Qoc3RydWN0DQo+IGludGVsX2RwICppbnRlbF9kcCwNCj4gwqANCj4gwqAJ
dGNkcyA9IG51bV9tbF9waHlfbG9jayAqIHRtbF9waHlfbG9jazsNCj4gwqANCj4gKwlwZXJpb2Qg
PSBnZXRfbHR0cHJfZXN0YWJsaXNobWVudF9wZXJpb2QoY3J0Y19zdGF0ZS0NCj4gPnBvcnRfY2xv
Y2ssDQo+ICsJCQkJCQlsdHRwcl9jb3VudCk7DQo+ICsJaWYgKHBlcmlvZCkNCj4gKwkJcmV0dXJu
IHBlcmlvZDsNCj4gKw0KPiDCoAlpZiAobHR0cHJfY291bnQgPiAwKSB7DQo+IMKgCQkvKiB0bHcg
YW5kIHRjcyB2YWx1ZXMgYXJlIHRha2VuIGZyb20gRFAyLjEgc3BlYyAqLw0KPiDCoAkJaW50IHRs
dyA9IDEzMDAwOw0K
