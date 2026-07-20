Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77790C44524
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:04:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F8C310E6C7;
	Mon, 20 Jul 2026 07:04:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="faZ+cf+1";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE9F810E6B9;
 Mon, 20 Jul 2026 07:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784531042; x=1816067042;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3dI6YVMpigH6F8Ph+BSyIfEBPTxZMxat9e5biPD9PQc=;
 b=faZ+cf+1NnN6cVRIK/8PSBFLgAF/FWw/q/g2wC3L+y7R8EAAWCvqXujo
 jJW6EvpMG7Czn5ynkX0VNzh4arl5NUS1hWJbFZtHgGF86mkTNcpM6j6Ib
 Bo4+Z6y8pOzMz7YyqHG5uHQ7Nymy9W+qCzd1MTzYC8tvbEc1O6DPIPJmD
 fIO66j6auD3+Ca2ABNMzL8ZUUNF9H4fXk8HIdIr0WQxJOrc4DXO808sJy
 nyjDkxSYR0hwmkfkE3A6s7mszNZqwNdjSI20NWxipJFXtRIh5GVpvxJK1
 6d2pSGrbghDM14E0v6xPF4U4fvi74d8kE1VosuFQMO0t0txfhJRgIjH0R g==;
X-CSE-ConnectionGUID: 8lKIZG4fRGqZ81wM4cXQ1w==
X-CSE-MsgGUID: 0LvZPhK/TpiLYGwTEUhBEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="96242096"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="96242096"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 00:03:33 -0700
X-CSE-ConnectionGUID: jcDwsozOSgqbeYLMJMqHpQ==
X-CSE-MsgGUID: UhG8pGvNRvejDeWe9+IUSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="256204908"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 00:03:31 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 00:03:30 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 00:03:30 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.30) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 00:03:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNW2bKeQsFTGKbOCEArZ10T7RdH9vtdUWgML8DWTH1jD/L/ULuXTCf5ImCmmSxBWuvzVlInlLGghT2sXVlzY+pLGBV9T/WA/ykx47rY0rkCyVHxtMetlYCKISgylf43tVArRlK1gsXtNLdimfxgUQLPKvqT3RsUgOODyei6UO1kfpP5xx1DX+PqRqCvrLwBwtll4ttuqvembrwOFJM6h9Rr71TxTSYje3yVYr3J3zjkxIywtbbTeKqsOGMFV4ukpCCxZIcZXW3V3zHCst08qNR+K8YObRA2/kIcOfdvkvhbE4TjZq7en+I/4rLSNmKcywB397ncOqBb4vQ6uBTq/WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3dI6YVMpigH6F8Ph+BSyIfEBPTxZMxat9e5biPD9PQc=;
 b=mcnuHCie8vQQtFqq33wSVS9zUYnv+iy8UFPaMwzs55mDer+wQLC6zNALFzywk58NhsMXwzR30+foHwsCWWgOBq4+Z/3ENWOV6ZYFsSEqG+D1GehKfZXl9QoZF1x3FWyR6rDWz1H1dW5JCcirzo30Q1CImpGNOiQkir6dbAdyUL8E/1cXgcGc/pBYtv4501xVYW9VtqRhBUBElPADH/nZmhUyMK0kGBK5cvVrgTbtjvRxPV2zguSVg9Agxb6mU/aVdAqRUQsBFsfVV6CV4WMzMoxftd5SoEvL1nZj9RX1REdIyQ/380uqbTa5y9ILTGJMo5WHHGeylsQ8bPre+Yh7Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7307.namprd11.prod.outlook.com (2603:10b6:208:437::10)
 by CY8PR11MB7847.namprd11.prod.outlook.com (2603:10b6:930:7c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 07:03:25 +0000
Received: from IA0PR11MB7307.namprd11.prod.outlook.com
 ([fe80::9d4a:f89:f548:dbc7]) by IA0PR11MB7307.namprd11.prod.outlook.com
 ([fe80::9d4a:f89:f548:dbc7%2]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 07:03:25 +0000
From: "Murthy, Arun R" <arun.r.murthy@intel.com>
To: Xaver Hugl <xaver.hugl@kde.org>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Jani Nikula
 <jani.nikula@linux.intel.com>, "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, "harry.wentland@amd.com" <harry.wentland@amd.com>,
 "Shankar, Uma" <uma.shankar@intel.com>, "louis.chauvet@bootlin.com"
 <louis.chauvet@bootlin.com>, "Kumar, Naveen1" <naveen1.kumar@intel.com>,
 "Yella, Ramya Krishna" <ramya.krishna.yella@intel.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Kandpal,
 Suraj" <suraj.kandpal@intel.com>
Subject: RE: [PATCH v11 1/7] drm: Define user readable error codes for atomic
 ioctl
Thread-Topic: [PATCH v11 1/7] drm: Define user readable error codes for atomic
 ioctl
Thread-Index: AQHcwO2h0lc1uuNC60qFzPhAYUNuwLZQbWwAgCY1jhA=
Date: Mon, 20 Jul 2026 07:03:25 +0000
Message-ID: <IA0PR11MB7307B483A07E89019126ADCEBAC32@IA0PR11MB7307.namprd11.prod.outlook.com>
References: <20260331-atomic-v11-0-6a1df7ec5af8@intel.com>
 <20260331-atomic-v11-1-6a1df7ec5af8@intel.com>
 <CAFZQkGy6f9vr5HjjnKtObOGA08TvhEhoaxiBd_0_i7WqJ2S8ow@mail.gmail.com>
In-Reply-To: <CAFZQkGy6f9vr5HjjnKtObOGA08TvhEhoaxiBd_0_i7WqJ2S8ow@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7307:EE_|CY8PR11MB7847:EE_
x-ms-office365-filtering-correlation-id: 8879ca52-6f79-4c2c-480f-08dee62cfe35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|366016|18002099003|22082099003|38070700021|56012099006|4143699003|11063799006|10067099003;
x-microsoft-antispam-message-info: yON2iFZdVEjzt1UFZ6Ab+6bpAp1AoKmUQ14vtRiFlR9e0fKJ8oItZ37DYJB8KlhGppgHlA8igwFRXCO779vIXqA8hEFUxpxO3ZnJkDhWbZ85epNQy2Ec+9PdM6ilmuUkO2dYAPLc+d+Zqbm7xeXuDeetrMD8/+S0oqxPiwkgfRmPBEugc492t+CGqVcU97FX6SiREO0RzJDn3XFC1A0NMrs0rleuh1pHG9gTo1zYVEx6PokDNsBLq6PF/zPOrDtqYsWTZDjJ/cjfUIIJ+ZSYgENnZIG4Z6E5blAUgq7mrgNYagorQuYWFE3Zz4ViCw+8i5YrpDttQL4Nz22+Os4qmRk9RyKR9XfHesCpGd32BZrGy1MOZHcNdoHXDSRnw6qnoyhaZelKL3nHZXJIUv4mHF7V7TLGDxAZs8rNjFAstMrY5Vbq161I/hQpWpSMKyFCVxa2ixsZSrnMi/V93GiFUi0ppSXN9VOFoqXpUbqFzX9abPHkEa10QK3tLfqiS4xPZbglSHJCwEjWQv9xatgRxi27Hk0jP5KSfybc8n5/BRYCSMKxl72Eff7LzyUr79//wNGJtPesQ7Vp68/g6VerXyT5P5020cnSChjQsEDsYfuW/+i1pPGHWRsEpe900UrYZvILoWkFRQKrzvHu7LJJ1+oD0RXcLqXoyVTMgjledYfPlJG8AhvFY5e4GicFaPveildlTJQAf29ttVDk5hYzraQne30uS9Xcsz1n3fm9PRs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7307.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(18002099003)(22082099003)(38070700021)(56012099006)(4143699003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2lPTXQ4NHpBOHArRlM2SmtEZW5xTzJUZ0p4V0w4REVGeWhYa1hoSlgzaWhE?=
 =?utf-8?B?VU5sVUhSWDZGYU03VVhnelB4YmhOVUVVWGNDUC9TVm5SSUJ4Vmo4c2FJSnMy?=
 =?utf-8?B?S0ZKeTN3NkZHcHZWM1N2VGlXbnJtbGtzeEhjVktQSk8zMVZIdzA5aGh6M2xR?=
 =?utf-8?B?VFNXRThrbkF1aUtxM0NaTTcxVTkxMzkxbUdIOHVFSEIvcnhIVEp4TWQ0aG1p?=
 =?utf-8?B?bGNWMERxVDZCVVlhanlJWWx5aENzS3VNLzdKMVd2YW04Ui96NUZSMm50OHE1?=
 =?utf-8?B?RHZCNHdvbGFGLzlDU0lDNXZzSDZBR25NbWRPSndoU2RnOFlZZm5kdndRQVFx?=
 =?utf-8?B?c3VTalJ5VHd1NEF0OEwzVFg0eTEvUityOWEzS2x3T1pBVVFDQWhBdER4cmpt?=
 =?utf-8?B?M1NER0FncU0wVE9XbHlPQ2djNFk1U1BkQSt4d2dnMFUxL2hLRWNqUnFZeUJu?=
 =?utf-8?B?R281NTlBdU13UGw3OU1VTFhDNmlZNmllYmNDWGU5QnJRWjNKZys4MzNQRWRJ?=
 =?utf-8?B?NytFTlp3cmZLWlUrTkpyR1pTUkVNYTR1M2VIcVdQWlhZODExTXBaYmNtdmIy?=
 =?utf-8?B?ek5hZzQzQWllMDZmSlF6WXFyTFJZZXVRUEZXUkVselYrTW01Vm16dExiQ2Jw?=
 =?utf-8?B?TEtKRU9ST3hQNU10dDNNN1JMVEs0VGs5aVphZXF2RGRub3VmOGprSE85TVZO?=
 =?utf-8?B?eVVqMGpodVMrNkxoVGI0L3haOTgzc1g2d3FoKzMxZEVMUjBXVGt6S3RWUmdz?=
 =?utf-8?B?TnVZbTRnbkc3dmVEUUp2b0pkSitJL2VjQnVQOTJJWlNHc1MyTUlPZUpVTU01?=
 =?utf-8?B?a05Ib1JUTzhrNlRBckdacWxYUXJnT281MzdvVDJNbmRrYlVkZlJsK1l2U0Fs?=
 =?utf-8?B?ZHVtSHdtMkhwczZSQitMV1pDclFCNVZReG0vL3hmL1c2ekxMSkRHckRWbkVJ?=
 =?utf-8?B?bkFRelMzWXpIZUZYRWxVWnNXTlBSWnJCSUkyOVEzTUpzZHlTMk1mTGM1SWc5?=
 =?utf-8?B?YlNIY0Q2TTRrRW0vc3VseVBxZC96dkdHbVVzakIrdzViTHBLdGtaTGVLcE9z?=
 =?utf-8?B?N2tMaHozL3Z3MElDT2NrZlNEZHNiMmFrNWpCUWNjNDdVOFVXZzRQSC9MWVBi?=
 =?utf-8?B?RTZYT2ZhSFNib0tDRTJ0Q1lEbWppN3pWNUtDeXF6QkNpbWpoYWc1d1V6eHBa?=
 =?utf-8?B?MHF5OWtFNXBxaVVqbUpLNVlvdHhTOGM2Y3JUc2wzaHdJbVArdlZkdlhwejlX?=
 =?utf-8?B?ZkZRdG5zRm5IQ3ptc09IZ1I0NzFFZkJDRkVVMkZtc3B6N1gzb0lEYlB5WHVO?=
 =?utf-8?B?ZFFzR3FJbi9rZkh0aEo1YjFBUkZVYVkyTmJxdFR1cVZyazM3cEwraktnZ1Vx?=
 =?utf-8?B?QVFuRFFpZHpHOUIyOU1qZmxHM0lveHFyUFN3OWxuaFJNZ3Q1ZTBvODFvOVc5?=
 =?utf-8?B?SkhITHlJYlk5dk5IMXU1WjVmbEExaWJzVVBiOW5yVDE4d0g2UXdkWDNlbitW?=
 =?utf-8?B?aDI5eFcvY0UrS3VlNTJQNWRkQnhQT1BIRjNua1RDeFpHeUw4UWdsbitJVFJ0?=
 =?utf-8?B?NDFMOGtSUkVlMHVMc2Roa29haHVXd1o0N3ZrdnJpVTBoZ04xNjQ5a3pvOXlp?=
 =?utf-8?B?V05vZFNNNWliNHFZQnlGSUxmS2FsWVhFdmRZcStsWXQxamhVUmlLWlZlYWow?=
 =?utf-8?B?UlRxcUNxenhKWm1sVjhqSHY4UTN5dzB6TU82dnJYNGt4Z0lkRjJSRnZMWmti?=
 =?utf-8?B?M25VZDF4ZXc0RnFaYURWWFNoY3Y5RkVtZEVLNHBoZjRudldSdE82clZLSjJP?=
 =?utf-8?B?L04zRENRajE0QlpjMkx1R3U5bjUrQ1JvWUtTMndrZ3BoU2c5UFJyUEg4TUNu?=
 =?utf-8?B?bmhwUVhyaFNDNDM4RmRoK3lGWFNZaEN1YXdoQjdKTTFnbHUzQU1ZRmxrT044?=
 =?utf-8?B?TkswMHFObk9EZlpOb2tKNjYvRnNRZTZOWXdhcmU1c1RCK2tYWS9ZaGU0OG5z?=
 =?utf-8?B?V3VUbGp5d3VkZFVlVXJsZi9YRVNEdEFUVTU2YWY1V3B5NkwyeTBLUSt1aVkz?=
 =?utf-8?B?Z3dEUDVqNGNCTkFVMzVrRE10MmtrNHJweU15czg0eTh6Sy9Xelo0NUo4WkVq?=
 =?utf-8?B?TGIwWVM0R09FdmdRMTFMR0dMaDl5cTE0MjJveDN2UGpsS0t1a3laK3FPQkFv?=
 =?utf-8?B?cklRQXZhOWMvK2kybmJYSDV5bUwrNjg4Zkh0M3pkQlpoNVhPaENFUnowRGtF?=
 =?utf-8?B?QWQ0U2ZWVkZiTkNWZFdOdktBVldkYnFreTJ3dkJCZEFCdWRrRzlYV3NPeXY0?=
 =?utf-8?B?N05GY3p6cHRHMktaZGtZb3hndGlnZkRLazc4RSs5c2VUSFpFdnYzUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Uz1dbTx0wv8sIIFEkN0k6Zzk1ny0S1zBHjyLXh+/YybheuPhAizzrqsVjiFhs83mNuntuz8R3B/7dNaRHxopEBOAv7Vl7P+yG/ArUHlxL/nFwOEJCu2t0M3EQs4nOpgL2XYOT3tpzC1WfZPRpFOfAbHRag1vdvoyYv1OW5XRPkhwheO0z6uRdhP7pqJCVnmNilR4Kif6yxb0VLqaxbXuAXV/J+q0ceYq9zUuVYKmEgaS7PXL3Rl+/76+rsawoVVmEyrbik8xJhIY4L0qCdl7plblXleQICeYWPAfYlJ9tPnj9R+yCB6OD5uqeP8qU5jhnoEp0vN4zz2dfkWZtdEQiA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7307.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8879ca52-6f79-4c2c-480f-08dee62cfe35
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 07:03:25.0731 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aCq2INRWff0ukt7/EP//2/QTv2+xie2GpupkMkSjpyD5p40HUb8SGTz2kYc5Y56K2kxO1zoBHJ03kt3qE4M7/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7847
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

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFhhdmVyIEh1Z2wgPHhhdmVy
Lmh1Z2xAa2RlLm9yZz4NCj4gU2VudDogRnJpZGF5LCBKdW5lIDI2LCAyMDI2IDQ6MzkgQU0NCj4g
VG86IE11cnRoeSwgQXJ1biBSIDxhcnVuLnIubXVydGh5QGludGVsLmNvbT4NCj4gQ2M6IE1hYXJ0
ZW4gTGFua2hvcnN0IDxtYWFydGVuLmxhbmtob3JzdEBsaW51eC5pbnRlbC5jb20+OyBNYXhpbWUg
UmlwYXJkDQo+IDxtcmlwYXJkQGtlcm5lbC5vcmc+OyBUaG9tYXMgWmltbWVybWFubiA8dHppbW1l
cm1hbm5Ac3VzZS5kZT47IERhdmlkDQo+IEFpcmxpZSA8YWlybGllZEBnbWFpbC5jb20+OyBTaW1v
bmEgVmV0dGVyIDxzaW1vbmFAZmZ3bGwuY2g+OyBKYW5pIE5pa3VsYQ0KPiA8amFuaS5uaWt1bGFA
bGludXguaW50ZWwuY29tPjsgVml2aSwgUm9kcmlnbyA8cm9kcmlnby52aXZpQGludGVsLmNvbT47
IEpvb25hcw0KPiBMYWh0aW5lbiA8am9vbmFzLmxhaHRpbmVuQGxpbnV4LmludGVsLmNvbT47IFR2
cnRrbyBVcnN1bGluDQo+IDx0dXJzdWxpbkB1cnN1bGluLm5ldD47IGhhcnJ5LndlbnRsYW5kQGFt
ZC5jb207IFNoYW5rYXIsIFVtYQ0KPiA8dW1hLnNoYW5rYXJAaW50ZWwuY29tPjsgbG91aXMuY2hh
dXZldEBib290bGluLmNvbTsgS3VtYXIsIE5hdmVlbjENCj4gPG5hdmVlbjEua3VtYXJAaW50ZWwu
Y29tPjsgWWVsbGEsIFJhbXlhIEtyaXNobmENCj4gPHJhbXlhLmtyaXNobmEueWVsbGFAaW50ZWwu
Y29tPjsgZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgaW50ZWwtDQo+IGdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmc7IGludGVsLXhlQGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgS2FuZHBh
bCwgU3VyYWoNCj4gPHN1cmFqLmthbmRwYWxAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHYxMSAxLzddIGRybTogRGVmaW5lIHVzZXIgcmVhZGFibGUgZXJyb3IgY29kZXMgZm9yIGF0
b21pYw0KPiBpb2N0bA0KPiANCj4gSGksDQo+IA0KU29ycnkgZm9yIGdldHRpbmcgYmFjayBsYXRl
IG9uIHRoaXMhDQoNCj4gSSBmaW5hbGx5IGdvdCBhcm91bmQgdG8gdXBkYXRpbmcgdGhlIEtXaW4g
aW1wbGVtZW50YXRpb24sIGFuZCBtYWRlIGl0IGhhbmRsZQ0KPiBzb21lIG1vcmUgY2FzZXMuIEkg
Zm91bmQgc29tZSBpc3N1ZXMgdGhvdWdoLg0KPiANCkdvb2QgdG8gaGVhciENCklmIHRoZSBkZXNp
Z24gZW5kIHRvIGVuZCBmbG93IHdpc2UgbG9va3MgZ29vZCwgY2FuIEkgZ2V0IGFuIEFDSyBvbiB0
aGlzLiBTbyB0aGF0IEkgY2FuIGdvIGFoZWFkIGdldCB0aGUgZHJtLWNvcmUgcGF0Y2hlcyBtZXJn
ZWQgd29yayBvbiB0byBlbmhhbmNlL2NvbXBsZXRlIHRoaXMuDQoNCj4gQW0gRGkuLCAzMS4gTcOk
cnogMjAyNiB1bSAxMTowNiBVaHIgc2NocmllYiBBcnVuIFIgTXVydGh5DQo+IDxhcnVuLnIubXVy
dGh5QGludGVsLmNvbT46DQo+ID4gKy8qKg0KPiA+ICsgKiBlbnVtIGRybV9tb2RlX2F0b21pY19m
YWlsdXJlX2NvZGVzIC0gIGVycm9yIGNvZGVzIGZvciBmYWlsdXJlcyBpbg0KPiA+ICthdG9taWNf
aW9jdGwNCj4gPiArICogQERSTV9NT0RFX0FUT01JQ19VTlNQRUNJRklFRF9FUlJPUjogdGhpcyBp
cyB0aGUNCj4gZGVmYXVsdC91bnNwZWNpZmllZCBlcnJvci4NCj4gPiArICogQERSTV9NT0RFX0FU
T01JQ19JTlZBTElEX0FQSV9VU0FHRTogaW52YWxsaWQgQVBJDQo+IHVzYWdlKERSTV9BVE9NSUMg
bm90DQo+ID4gKyAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW5hYmxlZCwg
aW52YWxpZCBmYWxnLCBwYWdlX2ZsaXAgZXZlbnQNCj4gdHlwbzogZmFsZyAtPiBmbGFnDQo+IA0K
PiA+ICsgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHdpdGggdGVzdC1vbmx5
LCBldGMpDQo+ID4gKyAqIEBEUk1fTU9ERV9BVE9NSUNfTkVFRF9GVUxMX01PREVTRVQ6IE5lZWQg
ZnVsbCBtb2Rlc2V0IG9uIGFsbA0KPiA+ICsgY29ubmVjdGVkIGNydGMncw0KPiA+ICsgKiBARFJN
X01PREVfQVRPTUlDX0FTWU5DX1BST1BfQ0hBTkdFRDogUHJvcGVydHkgY2hhbmdlZCBpbg0KPiBh
c3luYw0KPiA+ICsgZmxpcA0KPiA+ICsgKiBARFJNX01PREVfQVRPTUlDX1NDQU5PVVRfQlc6IEZv
ciBhIGdpdmVuIHJlc29sdXRpb24sIHJlZnJlc2gNCj4gcmF0ZSBhbmQgdGhlDQo+ID4gKyAqICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgY29sb3IgZGVwdGggY2Fubm90IGJlIGFjY29tb2Rh
dGVkLiBSZXNvbHV0aW9uDQo+IHR5cG86IGFjY29tb2RhdGVkIC0+IGFjY29tbW9kYXRlZA0KPiAN
Cj4gPiArICogICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpcyB0byBsb3dlciB0aGUgcmVm
cmVzaCByYXRlIG9yIGNvbG9yIGRlcHRoLg0KPiA+ICsgKiBARFJNX01PREVfQVRPTUlDX0NPTk5F
Q1RPUl9CVzogUmVmZXJzIHRvIHRoZSBsaW1pdGF0aW9uIG9uIHRoZQ0KPiBsaW5rIHJhdGUgb24N
Cj4gPiArICogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGEgZ2l2ZW4gY29ubmVjdG9y
Lg0KPiA+ICsgKiBARFJNX01PREVfQVRPTUlDX1BJUEVfQlc6IExpbWl0YXRpb24gb24gdGhlIHBp
cGUsIGVpdGhlciBwaXBlIG5vdA0KPiBhdmFpbGFibGUNCj4gPiArICogICAgICAgICAgICAgICAg
ICAgICAgICAgICBvciB0aGUgcGlwZSBzY2FsaW5nIGZhY3RvciBsaW1pdGF0aW9uLg0KPiBXaGF0
IGFyZSBhY3Rpb25hYmxlIHRoaW5ncyBhIGNvbXBvc2l0b3IgY2FuIG9yIHNob3VsZCBkbyBpbiBy
ZXNwb25zZSB0byBwaXBlDQpPbmUgc2ltcGxlIGNvcnJlY3RuZXNzIHdvdWxkIGJlIHRvIG1vdmUg
b24gdG8gdGhlIG5leHQgYXZhaWxhYmxlIHBpcGUuDQpSZWFzb24gZm9yIGZhaWx1cmUgY2FuIGJl
IHVuLWF2YWlsYWJpbGl0eSBvZiB0aGUgcGlwZShLTUQgaW50ZXJuYWxseSBtYXliZSB1c2luZyBp
dCBmb3Igam9pbmVyIHB1cnBvc2UpLCBwaXBlIHNjYWxpbmcgbGltaXRhdGlvbiwgZXRjLi4uDQoN
Cj4gYmFuZHdpZHRoIGxpbWl0YXRpb25zPyBKdXN0IHR1cm5pbmcgb2ZmIGRpc3BsYXlzLCB1c2lu
ZyBhIGxvd2VyIHJlc29sdXRpb24gb3INCj4gcmVmcmVzaCByYXRlPyBJdCdzIG5vdCBjbGVhciB0
byBtZSBpZiBpdCdzIHByYWN0aWNhbGx5IGRpZmZlcmVudCB0byBzY2Fub3V0X2J3IGluDQo+IHRo
YXQgd2F5Lg0KPiANCj4gPiArICogQERSTV9NT0RFX0FUT01JQ19NRU1PUllfRE9NQUlOOiBBbnkg
b3RoZXINCj4gbWVtb3J5L2JhbmR3aWR0aCByZWxhdGVkIGxpbWl0YXRpb24NCj4gPiArICogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBvdGhlciB0aGVuIHRoZSBvbmVzIHNwZWNpZmll
ZCBhYm92ZS4NCj4gPiArICogQERSTV9NT0RFX0FUT01JQ19TUEVDX1ZJT0xPQVRJT046IExpbWl0
YXRpb24gb2YgYSBwYXJ0aWN1bGFyDQo+IGZlYXR1cmUgb24gdGhhdA0KPiA+ICsgKiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgaGFyZHdhcmUuIFRvIGdldCB0byBrbm93IHRoZSBm
ZWF0dXJlLCB0aGUNCj4gPiArICogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBy
b3BlcnR5L29iamVjdCBjYXVzaW5nIHRoaXMgaXMgYmVpbmcgc2VudA0KPiA+ICsgKiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgYmFjayB0byB1c2VyIEBmYWlsdXJlX29ianNfcHRy
IGluIHRoZQ0KPiA+ICsgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0
IGRybV9tb2RlX2F0b21pY19lcnJfY29kZQ0KPiBJIGRpZG4ndCBmaW5kIGFueSBjYXNlIHRoZXNl
IHR3byB2YWx1ZXMgd291bGQgYmUgdXNlZnVsIGluIEtXaW4geWV0LCBzaG91bGQgd2UNCj4ganVz
dCBsZWF2ZSB0aGVtIGFzICJ1bnNwZWNpZmllZCIgZm9yIG5vdz8NCj4gDQpBZGRlZCB0aGlzIGJh
c2VkIG9uIHRoZSBmZWVkYmFjayBmcm9tIHRoZSBvcGVuIGZvcnVtLiBUaGlzIGZhaWx1cmUgY29k
ZSBpcyBiYXNpY2FsbHkgZm9yIGEgcGFydGljdWxhciBmZWF0dXJlIG5vdCBzdXBwb3J0ZWQgYnkg
dGhlIGhhcmR3YXJlLg0KV2hhdCBjb3JyZWN0bmVzcyBjYW4gdGhlIGNvbXBvc2l0b3IgZG8gZGVw
ZW5kcyBpcyBkZWNpZGVkIGZyb20gdGhlIG9iaiBzZW50IGJhY2sgZnJvbSB0aGUgS01ELiBLTUQg
d2lsbCBzZW5kIHRoZSBvYmplY3QgdGhhdCBpcyBjYXVzaW5nIHRoZSBmYWlsdXJlIGFuZCBjb21w
b3NpdG9yIGNhbiBnbyBmb3Igc3cgY29tcG9zaXRpb24gYW5kIHJldHJ5Lg0KRmV3IGV4YW1wbGVz
IGZhbGxpbmcgdW5kZXIgdGhpcyBmYWlsdXJlIGNvZGUgaXMsIGFzeW5jIGZhaWx1cmUgb24gY3Vy
c29yIHBsYW5lIHdoaWNoIGlzIG5vdCBzdXBwb3J0ZWQgb24gSW50ZWwgaGFyZHdhcmUuIFNvIHRo
ZSBvYmplY3Qgd2lsbCBwb2ludCB0byB0aGUgY3Vyc29yIHBsYW5lIGVuYWJsZSwgYW5kIGFzIGEg
Y29ycmVjdGl2ZSBtZWFzdXJlbWVudCBjb21wb3NpdG9yIGNhbiBnbyBmb3Igc3cgY29tcG9zaXRp
b24gb2YgY3Vyc29yIHBsYW5lLiBBbm90aGVyIGV4YW1wbGUgY2FuIGJlIGEgbW9kaWZpZXIvcGl4
ZWwgZm9ybWF0IHdoaWNoIGlzIG5vdCBzdXBwb3J0ZWQgYnkgdGhhdCBwbGFuZS4NCg0KPiA+ICtz
dHJ1Y3QgZHJtX21vZGVfYXRvbWljX2Vycl9jb2RlIHsNCj4gPiArICAgICAgIF9fdTY0IGZhaWx1
cmVfY29kZTsNCj4gPiArICAgICAgIF9fdTY0IGZhaWx1cmVfb2Jqc19wdHI7DQo+IEkgbWFkZSB1
c2Ugb2YgdGhlIG9iamVjdCBsaXN0IGluIHRoZSBLV2luIGltcGxlbWVudGF0aW9uIGZvciB0aGUN
Cj4gQ09OTkVDVE9SX0JXIGNhc2UsIHRvIHJlZHVjZSB0aGUgbW9kZSByZXNvbHV0aW9uIGFuZCBy
ZWZyZXNoIHJhdGUgb24gb25seQ0KPiB0aGUgYWZmZWN0ZWQgY29ubmVjdG9yLg0KPiBXaGVuIEkg
ZGlkIHRoYXQgdGhvdWdoLCBJIG5vdGljZWQgdGhhdCB0aGUgbWVtb3J5IG1hbmFnZW1lbnQgb2Yg
dGhhdCBwb2ludGVyDQo+IGlzbid0IGRlZmluZWQuIEhvdyBpcyBpdCBzdXBwb3NlZCB0byB3b3Jr
Pw0KPiANCkF0IHRoZSBtb21lbnQgZHJtIGJhaWxzIG91dCBvbiB0aGUgZmlyc3QgZmFpbHVyZSBl
dmVuIHRob3VnaCB0aGUgY29tbWl0IGNhbiBoYXZlIG11bHRpcGxlIGZhaWx1cmVzLiBTbyBvbiBm
aXJzdCBmYWlsdXJlIG1lYW5zIHRoYXQgdGhlcmUgd2lsbCBiZSBvbmx5IG9uZSBvYmoobm90IGEg
aGFyZCBydWxlLCB0d28gb2JqZWN0IGNhbiBwb2ludCB0byBhIHNpbmdsZSBmYWlsdXJlIGFzIHdl
bGwpDQo+IEkgdGhpbmsgYSBnb29kIHdheSB0byBkbyBpdCBjb3VsZCBiZSB0byBsZXQgdXNlcnNw
YWNlIHNldCBpdCB0byBhIHBvaW50ZXIgdG8gYW4NCj4gYXJyYXkgb2YgdWludDMyX3QgKyBzcGVj
aWZ5IHRoZSBtYXggbnVtYmVyIG9mIGVsZW1lbnRzIGluIGNvdW50X29ianMuIEVpdGhlcg0KPiB3
YXksIGlmIGl0J3MgaW5jbHVkZWQgaW4gdGhlIHN0cnVjdCwgaXRzIHVzZSBuZWVkcyB0byBiZSBp
bXBsZW1lbnRlZCwgc28gdGhlc2UNCj4gcXVlc3Rpb25zIGFyZSBkZWZpbml0ZWx5IGFuc3dlcmVk
IGFuZCBpdCBjYW4gYmUgdGVzdGVkLg0KPiANClllcywgdGhlIHBvaW50ZXIgd2lsbCBoYXZlIHRv
IGJlIGFsbG9jYXRlZCBieSB0aGUgdXNlciBhbmQgdGhlIHNpemUgb2YgdGhpcyBpcyB0aGUgbnVt
YmVyIGZvciBvYmplY3RzIHRoYXQgaXMgYmVpbmcgc2VudCBpbiB0aGUgYXRvbWljX2NvbW1pdC4N
CkxldHMgc2F5IHRoZXJlIGFyZSA1IGNoYW5nZXMgdGhhdCB1c2VyIGlzIGRvaW5nIGluIHRoaXMg
YXRvbWljX2NvbW1pdCwgc28gY29tcG9zaXRvciB3aWxsIGhhdmUgdG8gYWxsb2NhdGUgNSB1MzIg
Zm9yIHRoZSBmYWlsdXJlX29ial9wdHIuKGVhY2ggcG9pbnRpbmcgdG8gdGhlIG9iaiBpZCkNCktN
RCBvbiBmYWlsdXJlLCB3aWxsIHNlbmQgdGhlIG9iamVjdCBjYXVzaW5nIHRoaXMgZmFpbHVyZSBh
bmQgaWYgdGhlIGZhaWx1cmUgY2F1c2luZyBvYmplY3QgYXJlIG9ubHkgMiB0aGVuIHRoZSBjb3Vu
dF9vYmpzIHdpbGwgYmUgMi4gSW4gdGhpcyBjYXNlIGNvbXBvc2l0b3IgY2FuIGdldCB0byBrbm93
IHRoYXQgb25seSAyIG9iamVjdHMgb2YgdGhlIDUgb2JqZWN0cyBpcyBjYXVzaW5nIHRoZSBmYWls
dXJlIGFuZCBjYW4gZnVydGhlciBnZXQgYmFjayB0aGUgb2JqZWN0IGZyb20gdGhlIG9iamVjdCBp
ZC4NCg0KVGhhbmtzIGFuZCBSZWdhcmRzLA0KQXJ1biBSIE11cnRoeQ0KLS0tLS0tLS0tLS0tLS0t
LS0tLS0NCg0KPiAtIFhhdmVyDQo=
