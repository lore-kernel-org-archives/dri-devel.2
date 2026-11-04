Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590A6606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 01:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GsSckYB6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8000F10E67A;
	Wed,  4 Nov 2026 01:39:17 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E48E10E67A;
 Wed,  4 Nov 2026 01:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793756352; x=1825292352;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=2mPkPraMaK/TP/aKJRML5KDjAmwVlSBZUOlKgC2mLrU=;
 b=GsSckYB6JAXYrIyn3MIOvT1A2+9JMQQfUmPhJskZDRm7clPsx6yw74U2
 9X9L1Pj2rGtQ5Sho/lpRKe2o4R0XQMIbpJdeoMokrfPy6AQ/9MTQVEU4u
 8oj/rVkUPB8RlmweBNTy0tr+anCLOWGhCoIzQtiZpNZ7U1n7rOJjArCGE
 0ZNymaRSbMSlDnk+44sJT9zDqeHdRKLxJAz7sff2Uej9fXY4yjVnIoFqx
 wycqGS3ygYwZzKlaD89+wl9jP5BEFtjc3G3sX18Xg8GUWP9RTvEWarhWd
 F137S5hSfrnTnG+6YVBFXpVUIcJgMfkQ+I6tNhZ4VNdEPFHAfiFPKJmgh Q==;
X-CSE-ConnectionGUID: 34tObph4T7eNAQgmn8j0Vg==
X-CSE-MsgGUID: GPIaDh9VSGGNBb3hZO/IgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2381964"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2381964"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 17:39:11 -0800
X-CSE-ConnectionGUID: 0A8Y1EvuQ86I0yLybM0grw==
X-CSE-MsgGUID: xj+5b5dPTiKmAw+qWSfXOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="6596835"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 17:39:10 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 17:39:10 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 17:39:10 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.51) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 17:39:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9BmV/6OCAWkH0JMcLcpO9zEpEO0o6EF4hOkV7DcmP2np4sD6nnOozD39l61TXEeagYU//6cZykMwWqgGjiCmiNB/qaGZ347Ozphbq/iBWan181K8Q4LIsE2aljf1qSuYX0Os7YgWK5cSxJErI+rWVX5WKIXII2bz1TQEWlLQVLWyJ7xdyOKVo8+gY4Fypv5K7z/rhIUiHlML+CMafiPMaMmTx1NdfXZIAVWUfczWJ5T13FVwcdegtpfLhXGO0YlbIlrRY4oDjfLwP/rCCdjoppRHic4nj2ou6s8MtcCF8wCPje8zp0qHMDAWo0/fC2rBNC71vZEDWcKOOt1mYFWLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mPkPraMaK/TP/aKJRML5KDjAmwVlSBZUOlKgC2mLrU=;
 b=BNzgUQzS07e2WbwS/FhAgDvnPWbjCz/ZjXpv35MzZuWFVbNWK7gEHjBKCE9OR6YY7JcW0GnH9kf26vB28XNfan87wi2K9H5olQ0sN3KpzYNONatqkkUP7cfS1DMVyp2SafY3GfZTVB33gtifausaPnleQ1xAUD9VdprAONX0lGzxeEJ892fgTMousbOMhuTs3A252S7jUIOcInykMYPcoJyyrvixsIxXMjYZHByYvE1NsZLU5eeW05tBpCzd4qCqI/fl/yyJt2kGU3L9yTFwX2tv1Os9N7cSRHk6Z2dsl3WgOJ0VEeZlxJtRxBoU5Vp57EP8FYPjkikCTDQxGDzWoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8134.namprd11.prod.outlook.com (2603:10b6:8:15a::9) by
 PH7PR11MB6907.namprd11.prod.outlook.com (2603:10b6:510:203::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 01:39:08 +0000
Received: from DS0PR11MB8134.namprd11.prod.outlook.com
 ([fe80::d95d:cb19:df8f:1610]) by DS0PR11MB8134.namprd11.prod.outlook.com
 ([fe80::d95d:cb19:df8f:1610%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 01:39:07 +0000
From: "Chang, Junxiao" <junxiao.chang@intel.com>
To: Maarten Lankhorst <dev@lankhorst.se>, "jani.nikula@linux.intel.com"
 <jani.nikula@linux.intel.com>, "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
 "Brost, Matthew" <matthew.brost@intel.com>,
 "thomas.hellstrom@linux.intel.com" <thomas.hellstrom@linux.intel.com>,
 "airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>, 
 "bigeasy@linutronix.de" <bigeasy@linutronix.de>, "clrkwllms@kernel.org"
 <clrkwllms@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>
Subject: RE: [PATCH 2/2] drm/xe/gsc: warn about GSC stolen memory usage on RT
 kernels
Thread-Topic: [PATCH 2/2] drm/xe/gsc: warn about GSC stolen memory usage on RT
 kernels
Thread-Index: AQHda0RAHqYfS6vTK0+qpOgiHZLFcrccNKcAgADuZ9A=
Date: Wed, 4 Nov 2026 01:39:07 +0000
Message-ID: <DS0PR11MB81346BAF50836254E2EA08FAEC682@DS0PR11MB8134.namprd11.prod.outlook.com>
References: <20261104032732.30681-1-junxiao.chang@intel.com>
 <20261104032732.30681-3-junxiao.chang@intel.com>
 <ec59fe20-1e22-4009-89b9-af5b3d37fcee@lankhorst.se>
In-Reply-To: <ec59fe20-1e22-4009-89b9-af5b3d37fcee@lankhorst.se>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8134:EE_|PH7PR11MB6907:EE_
x-ms-office365-filtering-correlation-id: 2fbe86d2-4a89-4b96-7f77-08df3a146b0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|1800799024|23010399003|22082099003|18002099003|56012099006|10067099003|921020|261022113327099003|261022105027099003|261022075727099003|4143699003|11063799006|38070700021|261028144727099003|261026121527099003|261026140227099003;
x-microsoft-antispam-message-info: zVvt59eSSexpeNvwwnUx4uN3D568fKzba7QiNGgT08MCBJ6FOBQEtwj4MXL4v54pey1gcLGmWUVVeX4dg7bDHG5YSUVnuBLQWwWgNqMJoNJqdPhPHq3F4OUsGGq1357t7s8xfZRw7JEeCqGZvufFW/gabt3k4Ep9yx+dIhXdv74TdKhgSGz/KGUQEvpDA8LiNOUnRRMfDftidrBTUCub8j35OwXJFLikraHpCtTWFkrlbgnRmX2WvKfRV2jyaGWMKy2WTXMPREmXhz1fD3RgzBEAoAdbV+eGHl2LhdxhQKU8XAo8Ut+y6LdH5/pr0hLl/wSxJgIAZEbbKdnhz4p5s+ExRzYUhhIR1HY7shIbFsLS8fp85M4KXL6QN2AT+OuTxChcQWr1idNeDXq/Cjd21QypTCf65QoLKtGV/CbIFTccgvQCG3ED5F994xt6KIFNdL/GyDeojw87fDtNGWd1L2odyzesb2ypH5gO/JWvKZ8rDdAHBR2TIfdUR8J+w9GQbYkZnESn0mLJmi4Mp4TI/E1BTSh0MlDeXuhkDSaOcbLPTtlEtxGea6s3zMDlgnQW7WekzHMS1w4hemppjANMSnDfoP9BFDeBnLiz+gvnEz4aIUH4+j5yuQvF5uk9XXwMmfJOIEwfpJGkBvvUZ1wAymU9eaHpZmvUKRPvJccnHcXzDBzbctUmBBaJoCvIDb99fYOLKtK/6CMoaFj2xglNgkcoAjuQQk8jYZ+4GMl4Th5Y7Xto5RhuJE3/0a6Ubq46
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8134.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(10067099003)(921020)(261022113327099003)(261022105027099003)(261022075727099003)(4143699003)(11063799006)(38070700021)(261028144727099003)(261026121527099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3g4cllmQ0lTQVNVOGg5NnBnUzFwcU9vMkx5NHh2ZkVGQjRjZlhwWGMzZ3FW?=
 =?utf-8?B?ajZlcGZtV0dSS2lGVlpUMG92b284eFFzVDE2RldNemNhSGphaGpqdFpUUlJ2?=
 =?utf-8?B?a0JOcG1NaDlFRHdDZkhPL1RLZGVQZzhOTk5sU2pKa3ZPLzI1UW1OcjlQcFNM?=
 =?utf-8?B?dkxzL0hTaStWMGkyU3N6K083a1pGWHFoV2cvSzcxZW5VS28xak8vQ3B0bHN5?=
 =?utf-8?B?c2pieGFVME1ZeXdKUEl0M3l4eU1MQkV3cGVqSm5vSWk2bWJCOWZaT2xEQk80?=
 =?utf-8?B?elU2dit6Z0RvSkxxazJIcjgrQTN4WXZHdkZPeS9UUWNlWlVWUzhLZFhMeFV0?=
 =?utf-8?B?R0R5YnRScE9jNzBWTkVhb1g4TktvcTk4aUNGbTgvTmtHV05ia0pnTGR3Uzgy?=
 =?utf-8?B?OTJiOUV4SU5qK21ldXJqTmlHWDhOOS9nTHpoS25UQ2lOY1F5Ym1OUjJ5L05w?=
 =?utf-8?B?WFBtYkFmMUhQODdiYnpXd05MZTB0UkNBSHp2cXVjOSs3anFYWFM1dXpRNFE2?=
 =?utf-8?B?eE55NHdWY2w4VHlER1VMOHdubE1DeUs1cU1maGdVcDhhd3VUM2l6ZDZJQUs1?=
 =?utf-8?B?U0x1T2NhM2V3ZUE3Mzk3bVVaYXpqd2xycVV5N2c0NWxhc0ZqS29Hd2JJTGRY?=
 =?utf-8?B?RVN2eU1kNmR1VHpoalBXSGlURlozV3dQVmNtYlU0N09EbWdWU3BxWXpvR2d0?=
 =?utf-8?B?K01JenVURldLMFhya2Y2NkI0VmtrUENWRENOWER0NjBxUzBEb3VvMHQ1RE1i?=
 =?utf-8?B?QzdvWHN4NlVobkgxQlUyamE4d04wMXAwd2dwTHJuYUYxZjN5Q0c2ODlZS01F?=
 =?utf-8?B?NGFjVVg1Q3R5bStBMGFEZ3FRRFNwZStySHVPWjZyU2RHaGs2NkE1em5vTTdS?=
 =?utf-8?B?bDJTMmZSbUg4ZGlkWlZaMXR3OG8yb2l2THRnTE5FL3NBWDNjUk9rcHlNVjZx?=
 =?utf-8?B?MzU0RWUvaExJTnRaS2p6M3NpYXgrbk1laUNzMmFQRkpXdnVmRUw5WkRyUUky?=
 =?utf-8?B?TENHcDlvMHJTT2lhSlZjdzBkL2pWeWxOQTUwNnNVRHNLWVczNVN4SlVnOHAr?=
 =?utf-8?B?L1V0THltQytzbWVvYnhhZFF6clFIWUsrZFhEcGJQSnIrR2JkcWpEWmJBNDZ1?=
 =?utf-8?B?WC8yQmhDeVV5UzM4RFd4WE5pRGo2M25UR3ZNV04wUkZzUHZhcnd5WGwreVMz?=
 =?utf-8?B?b3kxaWhVdzdGaFY3Q2FES3FYWWg4T09HTEVyZTBCVjM5NERZU0JrR0ZFdUVO?=
 =?utf-8?B?aDhmZFFuL3E4c1FpaXNFQ3NwaTR0ZzB3eUpRWGxCMGIwRytPMTFXQlpBdGtt?=
 =?utf-8?B?Mks0ajU2T204VmdmYlpET0YrSzdTWGYxMkRlZi81WSt6N2xSbjUwT0RIbHR6?=
 =?utf-8?B?clc3d2VBYTdXaU1OZWYraHNrZTNJVzg4cjZVK0M1bHhNenFzOWg1OHM4TGJE?=
 =?utf-8?B?VkQ3UHIvMUJrVytsbU5zRDY3OWZ2czVPam56OWJ0WjM5U1BTYWk0c08zM0p1?=
 =?utf-8?B?dU00cWdxRkdSR050Wkg1VWtEUmZGa2I1VHlWUXl5Q1hvWmxwMjArMVB1Rjdo?=
 =?utf-8?B?QjF5TGdmWWtwMyt1MEs4bWFtWHFlOXZOVHVINjRzUk43cnp4OHlqYXNaaWY5?=
 =?utf-8?B?MEJLVVBva1pSODZsNVdsWEY4T0ZQbHczTTRqekRVeDRDQ3lOWXVFMGVIdjNt?=
 =?utf-8?B?cVc1aEE1L0ZDZmdIL3M2ZmY1VnlxMnluN1IvL3YzdnN4ODU1MGVXWmtqZ2dq?=
 =?utf-8?B?S1pTMkFpU25SUDBGUHN3Zm1yTWlQTEs5eHQwUndqSWwwRVJpNWhGU01ZVTNS?=
 =?utf-8?B?VXN3a1JSa3FteGdXWmZaYlNqTjE4dFI4dnFFSUVJU2FNeEl5THZFRWNCSW5z?=
 =?utf-8?B?b3NML1pWUDJxNFVrSE41dlBDblBqY1hoTzBpZ1hYMlNDWDIyakY1Z1BuTWhu?=
 =?utf-8?B?ZXJRY1J0blh6bDF5MWd4Sk9sZ21LME13UVVkV1VtalA4alo1WkhYOE1SdVlN?=
 =?utf-8?B?SHpxTm9sWXc3d3dvbk4ySXQ5akhYVXFQQ2g4RU03K2JUbUE3cFg5OGhHL3Ju?=
 =?utf-8?B?NFIrOXlPWVU5Uk1abThBdTlyYWlBdTlGNEVRV3VSc2c5QlRHMmxRWDJ2eEpV?=
 =?utf-8?B?M3U1VTZld0xUMEdFWXVZYk5PMmxMVnNUVmN4M3BrWEViWWZnakoxM3hwbmVr?=
 =?utf-8?B?WmNXaTBmVUp2N3ZLT2RWaHVnOUt5dzd0Qkl6N2NVVkNNRytKWEpmQytLZWxS?=
 =?utf-8?B?UkluRDQ4dkZhcWhSYk1Wb1F1allUM01uYmd0OVhSSDN0TktNNWRNZWZVb09P?=
 =?utf-8?B?YWZQWVR3alJDZXZvUWYrRmpETGZ2alA4dGwrRUs2c3RtWTFRdVpVdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OLiRVX42YXRHFTGmBQmwebamOMNQHKwv75hVGb+MKVVUDiu9kSIhiau9gSdtbFRcinM+ec1G20xNLhcA8FD/lkdE+EA6vpR0g+6NtRCKeoSfZ2nJXva5O6tkdVDTjLPpV67MrMLw4wMlNYKpMVgPO/u1KeoW8lchSskKdmiEiuFxHmTSDrPzVbQf4770ocGGt8DuVA2S5NdR0Rwg/lIuVsKsHevi/2mjzpO4PlCE4n8eKoZApbHG0MHKup8r4uCq2uFkp2xodRdOXGcWFvher6IremAxWNQyfJxhn67eXMoC81wDR/9N2K/FgHDvvP0HtEDYSVFeZ/c5W9UwCYAvTA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fbe86d2-4a89-4b96-7f77-08df3a146b0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 01:39:07.8917 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nB3opwGp5VIicKTMWhxcrI2aDdoM495+YFRUQ1/rHxmJlyrLAppLBjxlV3voJJ5sqAMEhTRSKndvP8vZnL9Ddw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6907
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PkZyb206IE1hYXJ0ZW4gTGFua2hvcnN0IDxkZXZAbGFua2hvcnN0LnNlPg0KPg0KPkhleSwNCj4N
Cj5JcyB0aGlzIGEgcHJvYmxlbSBvbiBkaXNjcmV0ZSBhcyB3ZWxsLCBvciBvbmx5IG9uIGludGVn
cmF0ZWQ/DQoNCkN1cnJlbnRseSwgdGhpcyBpc3N1ZSBhcHBlYXJzIHRvIGJlIGxpbWl0ZWQgdG8g
aW50ZWdyYXRlZCBncmFwaGljcy4gR1NDIGlzIGF2YWlsYWJsZSBvbiBQVEwsIExOTCwgYW5kIE1U
TC4NCg0KPg0KPktpbmQgcmVnYXJkcywNCj5+TWFhcnRlbiBMYW5raG9yc3Q+ICsNCg0K
