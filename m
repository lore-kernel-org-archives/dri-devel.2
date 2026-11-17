Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C9F606A333
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dz2aWTaT;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=QvOlD2ry
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC22510F76F;
	Tue, 17 Nov 2026 14:16:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C81AC10F76B;
 Tue, 17 Nov 2026 14:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794924986; x=1826460986;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=34i0tKajmk64xEdtEmoY0ijHR3zkkzSRNN47QDJz1SU=;
 b=dz2aWTaTL6N9tUl0bNm49RSyvlkZJVYEGejqjt4afmXqwRSsbJ9RIye0
 JuM2H8NvBBLHgHCX9VEY65frVML1+ZLe2LPBnVXQ1Eg2r/aH9K1mymSrZ
 VcIt0ixlDk446fvMnEYLeSYLOLCmBOcLqkxyc+L3ro18KpkikLaZJQs4r
 XE+q//rsUWuPP1DyiAkpfGYpHuFoEUW7VUINtBDwhONvIL5Hx0xGUkfAf
 cBub2Jk18MClDBUs0p/w4yclBZtjGZBwfBsmx46Mw3o4NB9bRD1uZ5ZC9
 qv4jkODUVoFNVV8i1OVGFMEusMwtWuoeIPb6gCmdfCcwHSWCvfqsZ8l3j w==;
X-CSE-ConnectionGUID: tA/CBNW9QmaD30BlBeVc/g==
X-CSE-MsgGUID: MK6b/lwHTpCC591l773U5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3610670"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3610670"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 06:16:25 -0800
X-CSE-ConnectionGUID: A7bvYJg7Qcy/nrKx/pq+Rg==
X-CSE-MsgGUID: Y8TJ2VWhRKClU5hldCk4yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; d="scan'208";a="10024518"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 06:16:25 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 06:16:24 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 17 Nov 2026 06:16:24 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.11) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 06:16:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7UHAz7tGke+h9e4tXTbPEjTRJoeO9XjcIuNo0LhQpUnCpDzx/ywA06Gk0iAlf1MqVzYECVd+4S6n7oL9vmy2ibyw72g/jayVCeLEJCcdvyzM/Y8dlmlXFmTNhnY8XTwiqLsdu15X/0QlvNjx3L4xMISknxhuaVNiVWsjAKgJm4SJs87i5pDRduGt8TI3oAzfpsksEz8F6SVXJiKdzA2DfQkvk/Q4J0axz9GN+BN5RKOjB31L0vJPyJ7cRomDFYYeM0ly/kfr8WolqNqmg1Uz+78vxBvMynKvfFZ7OdTGmt9hHpkPoTIevts5GS5VZMgtOok+V6ppxKcE0ZYUHmt9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34i0tKajmk64xEdtEmoY0ijHR3zkkzSRNN47QDJz1SU=;
 b=IRstKaoXRTvZ2KhG9Tq2FLbrEMopmSXHyanm38QlRrrcvOtwppL3zpKkdpDfYqfhO2hmmN+QV5E9NIH8txd3HG1KZMs91rawlmXhbXfX1MbRHzYDD9FDfnuXh4DEpiVP+j3XwLj33NyL/rLyxKmIfLOvbY0Lm9IZKM2mDbcOB+UNvW3XHrbzgwaBRRvHRljx96OcB8RABqoZz0V50Wnty80e6rA4iS016cYcdApqtDLnd6OksgxEmsZNiuRuoi2dsQFEBAP0C5kAzpONDa2SnWLoSjsgeA/+H4/PZqDjnDCFDbovfl/BiAzBDKRRPcSvBGJTEhfDG0+ZH85MBQ/8cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34i0tKajmk64xEdtEmoY0ijHR3zkkzSRNN47QDJz1SU=;
 b=QvOlD2ryG/u4fvNsGdVoZMpxBsA+IrVYV+9Koiv3hwSwDcdvMT8Ncp/0NHAwxJ3J3WquBUaYhyJPzEJv1Om9zxzktL8TdmKaPvpbA+S4Ify0VkUKXns3LfmxtC/LxbFRf9j53DsL400SxmzG1dZPvl4+b91uGsXttCc5ot6EsWs=
Received: from DM3PPF4C5964328.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f1e) by CH3PR11MB7938.namprd11.prod.outlook.com
 (2603:10b6:610:12f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 14:16:17 +0000
Received: from DM3PPF4C5964328.namprd11.prod.outlook.com
 ([fe80::2eab:ee79:1a42:8a2e]) by DM3PPF4C5964328.namprd11.prod.outlook.com
 ([fe80::2eab:ee79:1a42:8a2e%6]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 14:16:17 +0000
From: "Upadhyay, Tejas" <tejas.upadhyay@intel.com>
To: "Yadav, Arvind" <arvind.yadav@intel.com>, "intel-xe@lists.freedesktop.org"
 <intel-xe@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>
CC: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>, "Brost, Matthew"
 <matthew.brost@intel.com>, "Ghimiray, Himal Prasad"
 <himal.prasad.ghimiray@intel.com>, "thomas.hellstrom@linux.intel.com"
 <thomas.hellstrom@linux.intel.com>, "Yadav, Sanjay Kumar"
 <sanjay.kumar.yadav@intel.com>, "Charles, Daniel" <daniel.charles@intel.com>
Subject: RE: [PATCH v3 1/3] drm/xe: Hold a device reference across deferred VM
 destruction
Thread-Topic: [PATCH v3 1/3] drm/xe: Hold a device reference across deferred
 VM destruction
Thread-Index: AQHddZOwQt+RuQhA+0+DI9NG7niz4LcyUSig
Date: Tue, 17 Nov 2026 14:16:17 +0000
Message-ID: <DM3PPF4C59643280A8EEAAFC108D5D4585F817B2@DM3PPF4C5964328.namprd11.prod.outlook.com>
References: <20261116062804.1242511-1-arvind.yadav@intel.com>
 <20261116062804.1242511-2-arvind.yadav@intel.com>
In-Reply-To: <20261116062804.1242511-2-arvind.yadav@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF4C5964328:EE_|CH3PR11MB7938:EE_
x-ms-office365-filtering-correlation-id: fc66cf95-f0b3-45d6-86e1-08df44b55899
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|261009223027099003|261022075727099003|261022105027099003|261021123027099003|261021121427099003|261026140227099003|261026121527099003|261028144727099003|56012099006|11063799006|10067099003|261102123227099003|4143699003|38070700021;
x-microsoft-antispam-message-info: jG8pCEE/inj6/AbtDxX6TRgu8Cwdhv+oJ0lHBnDX1EWYP3YSpvJJocNppJxqc93SdtItimDrB3RAVAmt+K48+cm33G9Nr+OETgYOBOYzffr1W7u9aP3dbjTIZccm1Let56iOywm7VkBUrLfzwXq2HiwZFzgquPl1uz/rOIrnZv0pWJXqV4iWZM4rcGM1USJWv4+db3HFtzTwdx5J3z32AXLKbSotBE0V37htfpsreKmplpNM/SjS52+SnwWdY81DjUU5mRB6u1FG0raXRGUa/WNZlzOZNS28lni9gUxdJaQi82lgfb7631CJpun+po/r4yJjha/ZbnQr4gp5Ky8qjrZ9uIABA8N+Qw0N6D/NBB6widjUZm8dyvMNpC2lyAnIPdAPtrvGvhv+6MjJNSvkVui5cqilvP7bYeAf3fxTtNHjP3D9B0RSiTZNaaAHfLyf18C78/wcMmgbWkFePKNdYu5v2qGe48PLLDxNP5+5XSmZ16YfU3JXEB/TK0XtJb8Tcn6Hdn2Zy2v2yu1wAkNxjWuzAxker9GJcknHSXn149vGKiPqQyWSkJ9K5IhqEHwcbokKvJ9Mha1+JAa+UwzHIr292yKWErJ+L0EsozcdOwSkT2M1R4orvI9irn7qVQJuJua1uDRGv/q1Z0BCJEDzmTdtz2p/jy8Ezc6y0+szEXSBAHLS0OIlXDeHG4REMnsHABLBHIX57fq/QjJ7hMEt81uAz5VF3f611GQcDSG4qNk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF4C5964328.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(261009223027099003)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261026140227099003)(261026121527099003)(261028144727099003)(56012099006)(11063799006)(10067099003)(261102123227099003)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OW12YnR6cmRFbW1nQUwzaVVMaHZML3FWcjhCV3NKRjBBalRIVnVNWVVpTTNC?=
 =?utf-8?B?Rm5VNWtWdGRFcW5oUUFwYkg0eWRTQTVrYkNFOURPSkk1dGpOS1E0M2gvRzNV?=
 =?utf-8?B?bzMvU3p1YjdQd05IU25Jc2VpVTNEZXBMQUYzK08xQXU2MW01Y3hpcm1BMjkw?=
 =?utf-8?B?UTZSMWE5bzRhU1EzdHM2S0ZnU01WQnN3Q0MrRkdZU3N5SUNzTmtHT0RWSkFX?=
 =?utf-8?B?SHExV29LdnlidzlYNkplMFQzZENmeXMzcVoxaHZ1b1c4NW0zdmZwQ0JtdnpL?=
 =?utf-8?B?cXRydjd2MjNjNTJoTDBxUm93U2t0RDJWSkIvR1hNN1U1VzlZclE0ZDkvaWtT?=
 =?utf-8?B?cjRvMHY2RXpJQm9LVVB6S0tjbGRQY0owbW50WmVOZnRrQVpVQzRIUEdSbEYz?=
 =?utf-8?B?QW1qUFYxcFJjaXBTTHpwNlRIQVMzT3dqZzNlN3hNZmJGWjUySTFvMm9RM21U?=
 =?utf-8?B?a2xncVVZVTZHTXNlbTB0YWRHeENGSWNXWVpSRXd2ZmUvTjhTYmhtcXAxMUlq?=
 =?utf-8?B?QlZaVzN1RTcrWnF4d1oyZHhHS0ZxN2R2a2REbkdmUS91QmZCWDNzeDdWUTY1?=
 =?utf-8?B?cVFFcVRKSHkrL0dzbkNOaGNyVVM1a2xCclpvZUw4Ulp0Q2lQTzZBbnlYSTdG?=
 =?utf-8?B?aE1DK0NlbkRxdC9aWmtoODFURmcxdGVZNzZMMnF2cGNtOHc3amhqZXpkYTRz?=
 =?utf-8?B?SkxoTFBLRklQVTVMNHdPRFZIVEZYK3RjQ2JQUFlGbUNDQTAwa3VCcjl1eTdE?=
 =?utf-8?B?ODNxNXphdWNRWjZoVUdIRkJQTWs2WTRMT0xrdnZaOGRVRGpUYW91cjdSbGo0?=
 =?utf-8?B?dmd5N2xNYkhSKzFucWxMMjc4TXJDVml1RjBPYkFnQ3E4MDc0QUN5UGtnZEw5?=
 =?utf-8?B?L3dINlNmaHV6MDBpMSsxaVorUjN4V2k5SnZHQzNjV3pscTM4R3gzTkg5bk4w?=
 =?utf-8?B?eXFac0hidmNtckxRYS93a21NS282a1R4aUZPNU1nVUlTSTJhQytqM0lYWUhr?=
 =?utf-8?B?emE2VDFxeVlseGZWaXk2RGF6dHFoWTlrMFdPSTNyTW1KRVZrVXphUjZSd0JC?=
 =?utf-8?B?dm9qNklYNTM4NEk1ZVgrNVo4alQwcWRPcGhlMlNyZDZoS3BnS292djB3K2cx?=
 =?utf-8?B?VXRKR0dhY1RYRmQ0ZUs1RkRib1l3K2FIV0ptT2tOTHY5WjBqSzF0R051MllS?=
 =?utf-8?B?KzZ1ZWhSRE9Veml3LzkvVTZpaWNvdElPaWhEOStGbEs4M1p4aHNFbGM1ejJY?=
 =?utf-8?B?NVVsUml3QUdGR09FNjhIYm5vbHYydGhDdzJNakJCV2lVSFN6SkZwU0N1M01Y?=
 =?utf-8?B?dEpzUzBlQkdVQkdVRnh5T2tMa2s1WXg2TUxqN2YzTmxoSWgzRmxNcmNhQmsy?=
 =?utf-8?B?Y051RXdNOERTWUk0c3hYcCtGV0pXNXJSNTJYY3RHT1RFWWJhODd4MjVUZ2VQ?=
 =?utf-8?B?T1Q4RFhTUkNTcm1VeVEyYUV4Q00wWU5TdjVYeGhuaTlpYUxQTkg3RzZ3cEhz?=
 =?utf-8?B?U0tOdC9EWjVETUJxK1lGV1VtS2hGZXJPTUEzU1I0cTZ2K3J3LzdTUFE3ZU1R?=
 =?utf-8?B?RVk1dnlza2g5SHFvaDFEQlY1WWpFZzRHbkUwdlBMbG41VjZMT2IyS0NFcXRo?=
 =?utf-8?B?R3hCTjlVRHpJMnMyZGRGZ0laaUl3RVJNOGhlUVJRMGlXeFhQMSt6QlNPRTkz?=
 =?utf-8?B?YUkxKzVkeHpUQUxPMFYwWVZnaFh0aHArSmJEaGRxUWdwRzNDTFBIeWJEM0Q0?=
 =?utf-8?B?NGU4bzhubTk4bUtGSzRNV20wVXloYkpRQXFyNklzK2dsdkI2aXErTTVPVlBI?=
 =?utf-8?B?YTEwSEt3Q1NSWFpXNEloU083MFd3ZDhwc3R0MmFkVFdvSFc0bWM2d1Y3TUl3?=
 =?utf-8?B?YXpHNVNzZFcxK3hLc1ZOZHNHdUxjeklQbndNald1K0ExTjc0TmNMQ1pLNW0w?=
 =?utf-8?B?M2xRRG1xZ3c3WklWS2NmM29TdnJyc0I2U0o0L3ZoNjYwbmlCeXpCaTJZVis1?=
 =?utf-8?B?Uk82ZkpDeFJqRUhKM3U5TWYvMWxZVkIyQmVkbmVaOVloTlN5ZTUxUmlndGxm?=
 =?utf-8?B?ZXZHTThnK0c5ZmpQQ1dBZ0sxODh5L0hiWkVUcmNuaGpsdVd3Y2JVTElyWHgr?=
 =?utf-8?B?aEZYNkdvQncrNWNBbFZLL2tHL0V4NzdmdXI4QXBNVjJQMCtBZVZFTVJlbC9y?=
 =?utf-8?B?YkZSeUI4M3NmUHRLT3BEYVRqWm55WWpzeVNPakJlSWhXS0RaT3Y4c3hZdENT?=
 =?utf-8?B?elBYNVR5ZFYyY2s5ejYrQkF2S1gvbXNOV2JpOUR1cVN4RFBwTHMzZmkwaXNj?=
 =?utf-8?B?N2dBKzRjODZKaVVzMXFaaExBRnhjYTVEeGk3VTNyUEtSSzh5U1pEQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SrkFOQhZtLl1UpQd5n0bdIr9LsHNQ6+29k15bWx9FjYguAiDYX8hvTy7BQ66JYqPmoYMzlI0oD0hqMF6Ux5jMvGCs2PZ9QUBslMfkio8F0O7bOKts3H8lb0Y2ONCkWKIDehJ9Dw/WQkISIireoeNuDsOsC0RPYPjDsftonn4PpLyA96C2ncOPYc3yB2LX+1vUle32eHd5oL9LcvYl9WT5xqeRP06wNEQfwNJRmFPhzjt2RIpgz3gIcHvk+llTn1w3J9/dBybvrE6JbdjVN5pJRsfzbf1cUht0ZMkXf/GpGCLBR+pZghmzds1EFKkU2Ipk+n3ARYtVBFo4pBPthjATQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF4C5964328.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc66cf95-f0b3-45d6-86e1-08df44b55899
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 14:16:17.5715 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CZ6TIOPVzQEqMW9iWfeNnZ466xYSdbovZp34uDjuq84DrAQDK+pPVCHFGstkfXCFRaw6gBmViYWPdy/m0x4UtzBSHYbK+4N8UXmTpRdXuBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7938
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWWFkYXYsIEFydmluZCA8
YXJ2aW5kLnlhZGF2QGludGVsLmNvbT4NCj4gU2VudDogMTYgTm92ZW1iZXIgMjAyNiAxMTo1OA0K
PiBUbzogaW50ZWwteGVAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBkcmktZGV2ZWxAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnDQo+IENjOiBWaXZpLCBSb2RyaWdvIDxyb2RyaWdvLnZpdmlAaW50ZWwuY29t
PjsgQnJvc3QsIE1hdHRoZXcNCj4gPG1hdHRoZXcuYnJvc3RAaW50ZWwuY29tPjsgR2hpbWlyYXks
IEhpbWFsIFByYXNhZA0KPiA8aGltYWwucHJhc2FkLmdoaW1pcmF5QGludGVsLmNvbT47IHRob21h
cy5oZWxsc3Ryb21AbGludXguaW50ZWwuY29tOw0KPiBZYWRhdiwgU2FuamF5IEt1bWFyIDxzYW5q
YXkua3VtYXIueWFkYXZAaW50ZWwuY29tPjsgVXBhZGh5YXksIFRlamFzDQo+IDx0ZWphcy51cGFk
aHlheUBpbnRlbC5jb20+OyBDaGFybGVzLCBEYW5pZWwgPGRhbmllbC5jaGFybGVzQGludGVsLmNv
bT4NCj4gU3ViamVjdDogW1BBVENIIHYzIDEvM10gZHJtL3hlOiBIb2xkIGEgZGV2aWNlIHJlZmVy
ZW5jZSBhY3Jvc3MgZGVmZXJyZWQgVk0NCj4gZGVzdHJ1Y3Rpb24NCj4gDQo+IHhlX3ZtX2ZyZWUo
KSBxdWV1ZXMgdm1fZGVzdHJveV93b3JrX2Z1bmMoKSBhbmQgcmV0dXJucy4NCj4gZHJtX2dwdXZt
X2ZyZWUoKSB0aGVuIGRyb3BzIGl0cyBkZXZpY2UgcmVmZXJlbmNlLCBidXQgdGhlIHdvcmtlciBz
dGlsbA0KPiBhY2Nlc3NlcyBkZXZpY2Ugc3RhdGUgd2hpbGUgZmluaXNoaW5nIFZNIGRlc3RydWN0
aW9uLg0KPiANCj4gVGFrZSBhIGRldmljZSByZWZlcmVuY2UgYmVmb3JlIHF1ZXVlaW5nIHRoZSB3
b3JrIGFuZCByZWxlYXNlIGl0IGFmdGVyIHRoZQ0KPiB3b3JrZXIgaGFzIGZpbmlzaGVkIHVzaW5n
IHRoZSBkZXZpY2UuDQo+IA0KPiBSdW4gdGhlIHdvcmtlciBvbiB0aGUgbW9kdWxlLWxpZmV0aW1l
IGRlc3Ryb3kgd29ya3F1ZXVlLiBSZWxlYXNpbmcgdGhlIGxhc3QNCj4gZGV2aWNlIHJlZmVyZW5j
ZSBjYW4gY2FsbCB4ZV9kZXZpY2VfZGVzdHJveSgpLCB3aGljaCBkcmFpbnMNCj4geGUtPmRlc3Ry
b3lfd3EuIFJ1bm5pbmcgb24gdGhhdCBwZXItZGV2aWNlIHdvcmtxdWV1ZSB3b3VsZCBtYWtlIHRo
ZQ0KPiB3b3JrZXIgd2FpdCBmb3IgaXRzZWxmLg0KPiANCj4gdjM6DQo+IC0gTW92ZSBmaW5hbCBW
TSBkZXN0cnVjdGlvbiB0byB0aGUgbW9kdWxlLWxpZmV0aW1lIGRlc3Ryb3kgd29ya3F1ZXVlDQo+
ICAgaW4gdGhpcyBwYXRjaCB0byBhdm9pZCBzZWxmLWRlYWRsb2NrIG9uIHRoZSBsYXN0IGRldmlj
ZSBwdXQuIChTYXNoaWtvKQ0KPiANCj4gRml4ZXM6IDYxZTE4NTI1MDIzYSAoImRybS94ZTogUm91
dGUgZGVmZXJyZWQgeGVfdm1hL3hlX3ZtIHRlYXJkb3duIG9mZg0KPiBzeXN0ZW1fZGZsX3dxIikN
Cj4gQ2M6IE1hdHRoZXcgQnJvc3QgPG1hdHRoZXcuYnJvc3RAaW50ZWwuY29tPg0KPiBDYzogVGhv
bWFzIEhlbGxzdHLDtm0gPHRob21hcy5oZWxsc3Ryb21AbGludXguaW50ZWwuY29tPg0KPiBDYzog
SGltYWwgUHJhc2FkIEdoaW1pcmF5IDxoaW1hbC5wcmFzYWQuZ2hpbWlyYXlAaW50ZWwuY29tPg0K
PiBDYzogUm9kcmlnbyBWaXZpIDxyb2RyaWdvLnZpdmlAaW50ZWwuY29tPg0KPiBDYzogRGFuaWVs
IENoYXJsZXMgPGRhbmllbC5jaGFybGVzQGludGVsLmNvbT4NCj4gQ2M6IFRlamFzIFVwYWRoeWF5
IDx0ZWphcy51cGFkaHlheUBpbnRlbC5jb20+DQo+IEFzc2lzdGVkLWJ5OiBMTE0NCj4gVGVzdGVk
LWJ5OiBTYW5qYXkgWWFkYXYgPHNhbmpheS5rdW1hci55YWRhdkBpbnRlbC5jb20+DQo+IFNpZ25l
ZC1vZmYtYnk6IEFydmluZCBZYWRhdiA8YXJ2aW5kLnlhZGF2QGludGVsLmNvbT4NCj4gLS0tDQo+
ICBkcml2ZXJzL2dwdS9kcm0veGUveGVfdm0uYyB8IDE3ICsrKysrKysrKysrKystLS0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0veGUveGVfdm0uYyBiL2RyaXZlcnMvZ3B1L2RybS94
ZS94ZV92bS5jIGluZGV4DQo+IGRkODU1ODc2ZjU3MS4uMTJhZmIzMzYzZTc5IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0veGUveGVfdm0uYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
eGUveGVfdm0uYw0KPiBAQCAtMjEwOSw2ICsyMTA5LDggQEAgc3RhdGljIHZvaWQgdm1fZGVzdHJv
eV93b3JrX2Z1bmMoc3RydWN0DQo+IHdvcmtfc3RydWN0ICp3KQ0KPiAgCQl4ZV9maWxlX3B1dCh2
bS0+eGVmKTsNCj4gDQo+ICAJa2ZyZWUodm0pOw0KPiArDQo+ICsJZHJtX2Rldl9wdXQoJnhlLT5k
cm0pOw0KPiAgfQ0KPiANCj4gIHN0YXRpYyB2b2lkIHhlX3ZtX2ZyZWUoc3RydWN0IGRybV9ncHV2
bSAqZ3B1dm0pIEBAIC0yMTE2LDExICsyMTE4LDE4DQo+IEBAIHN0YXRpYyB2b2lkIHhlX3ZtX2Zy
ZWUoc3RydWN0IGRybV9ncHV2bSAqZ3B1dm0pDQo+ICAJc3RydWN0IHhlX3ZtICp2bSA9IGNvbnRh
aW5lcl9vZihncHV2bSwgc3RydWN0IHhlX3ZtLCBncHV2bSk7DQo+IA0KPiAgCS8qDQo+IC0JICog
VG8gZGVzdHJveSB0aGUgVk0gd2UgbmVlZCB0byBiZSBhYmxlIHRvIHNsZWVwLg0KPiAtCSAqIGRy
bV9ncHV2bSBrZWVwcyBhdCBsZWFzdCBvbmUgZGV2aWNlIHJlZmVyZW5jZSBhdCB0aGlzDQo+IC0J
ICogcG9pbnQgc28geGUtPmRlc3Ryb3lfd3EgbXVzdCBzdGlsbCBiZSBhbGl2ZS4NCj4gKwkgKiBk
cm1fZ3B1dm0gZHJvcHMgaXRzIGRldmljZSByZWZlcmVuY2UgYXMgc29vbiBhcyB0aGlzIGNhbGxi
YWNrDQo+ICsJICogcmV0dXJucywgYnV0IHZtX2Rlc3Ryb3lfd29ya19mdW5jKCkgc3RpbGwgdXNl
cyBkZXZpY2Ugc3RhdGUuIEhvbGQgYQ0KPiArCSAqIHJlZmVyZW5jZSBhY3Jvc3MgdGhlIGRlZmVy
cmVkIHdvcmsuDQo+ICsJICovDQo+ICsJZHJtX2Rldl9nZXQoJnZtLT54ZS0+ZHJtKTsNCj4gKw0K
PiArCS8qDQo+ICsJICogVGhlIHdvcmtlciBtYXkgcmVsZWFzZSB0aGUgbGFzdCBkZXZpY2UgcmVm
ZXJlbmNlLiBVc2UgdGhlDQo+ICsJICogbW9kdWxlLWxpZmV0aW1lIHdvcmtxdWV1ZSBzbyBkZXZp
Y2UgZGVzdHJ1Y3Rpb24gY2Fubm90IGRyYWluDQo+ICsJICogdGhlIHdvcmtxdWV1ZSBydW5uaW5n
IHRoaXMgd29ya2VyLg0KPiAgCSAqLw0KPiAtCXF1ZXVlX3dvcmsodm0tPnhlLT5kZXN0cm95X3dx
LCAmdm0tPmRlc3Ryb3lfd29yayk7DQo+ICsJeGVfZGVzdHJveV93cV9xdWV1ZSgmdm0tPmRlc3Ry
b3lfd29yayk7DQo+ICB9DQoNCkxHVE0sDQpSZXZpZXdlZC1ieTogVGVqYXMgVXBhZGh5YXkgPHRl
amFzLnVwYWRoeWF5QGludGVsLmNvbT4NCg0KVGVqYXMNCj4gDQo+ICBzdHJ1Y3QgeGVfdm0gKnhl
X3ZtX2xvb2t1cChzdHJ1Y3QgeGVfZmlsZSAqeGVmLCB1MzIgaWQpDQo+IC0tDQo+IDIuNDMuMA0K
DQo=
