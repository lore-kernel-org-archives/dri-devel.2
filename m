Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 870A9CA5FE3
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 09:09:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCE8910F7DA;
	Fri,  2 Oct 2026 09:09:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="I5rhh37F";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5325610E460;
 Fri,  2 Oct 2026 09:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790932140; x=1822468140;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=/TqWXSIZf3m4s2MdDX3ehiZVJ2LIGZi05HtoeSZ/lYc=;
 b=I5rhh37FwqE/wpB53Nq1m9xYfWsQMS0lTOrWIA03XmtXi7mAYkAfKPpJ
 /GTmM+ir7gGGOAbUg8qhOREmFVSvz//u26QU5mQMMYYTSYLpPn8fgVT2c
 vBF8Qfk8cVEKrX89c71En+MOfMuY08c3PbpaosTa+wFjJeFJ+UZILG/Fm
 1QyO/H5DEFM5iS2XKY0rJCrae0pENsiJJGMfNmRoG1gtHVl/tfVjnE54k
 iZN3vxFg/aQSs7q9o2fByeTFNEvTOFkTQrQhxZDkhZrL4yMMZTL6kwpF+
 CSSr7av7DuEw/0/obM4qxfqmOI8mqoJatRaG81yYSgu+WdZInFpjp3Cbi g==;
X-CSE-ConnectionGUID: aF9HbIyAR0i9mZA1fVtK6g==
X-CSE-MsgGUID: VNZ+osQ9T82It276a3AH4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90728239"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="90728239"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 02:08:59 -0700
X-CSE-ConnectionGUID: EJ9IQV9dSHWxKaFBQyXemg==
X-CSE-MsgGUID: kJ/8Pb+uQIa1xcTxa7hINQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="302461805"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 02:08:58 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 02:08:58 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 2 Oct 2026 02:08:58 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.47) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 02:08:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iwFmOTG8UJoyk5BDll/Jfer7LaqQY5rxspVvACbKu00LK/qvZzHxBM5tawCYD4fNXTFZjzcwBmZZAh6ihPYcJeqzII8yOZlksvSkUfaM6YP3bFKm5qDt5XX9+mRrjN5uloE6H9inU+cGdvylBXMjhm5gRykBydFbbLPNk2iWrGxVSgonJaQfHnfMv0dFWccCDyu5/11gy3BTyG7M+iJh/gqc7Cmpp+oD2D43U3BURsU3yjcSZ5SsYjLLixqcebszTr7lsCb+nSz/JJf+Mzr6OHNydH2iCb0aF0+2c5WBYa4ChCVcr439gzTuQfybeB45X9sLbnTtRjlQroVj5D5qgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TqWXSIZf3m4s2MdDX3ehiZVJ2LIGZi05HtoeSZ/lYc=;
 b=o0dsoVq+EQVXABkHcuKv8/J+Gbq6NbqLLMEDeq/QxVNDDIfFh+FK5ydw2qHgdkizIAtYvEaAC+eUXRwcoGUXg7SsQo7zKOZ31D7qI3Ewu4Zt9OZIcx0aFU67Y9ylrApC+WIgi+Q3a1hmyHDaby1B/fRs+X3/PoDQUVit2XbGtZr+tcyJhvNkWg4+6yRtUDSsuLzJG70lAiAKRvvNCNWVFf6MFMMmTClolZNyQQ0V2P7gGsWVRkqDFoXc4Zlis7SA2UH5aXIUoYBUAY1IEd0LMylE230NfRxFzFIYVPbwpeKFThecW7faLVwZ7f85Txf9azYVNGL9bIuprHfrSproSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6019.namprd11.prod.outlook.com (2603:10b6:8:60::5) by
 IA1PR11MB7943.namprd11.prod.outlook.com (2603:10b6:208:3fc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 09:08:55 +0000
Received: from DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762]) by DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762%6]) with mapi id 15.21.0472.015; Fri, 2 Oct 2026
 09:08:55 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Manna,
 Animesh" <animesh.manna@intel.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>
CC: "Kandpal, Suraj" <suraj.kandpal@intel.com>, "Nikula, Jani"
 <jani.nikula@intel.com>
Subject: Re: [PATCH v6 17/18] drm/i915/alpm: Program zero-based LFPS half
 cycle duration
Thread-Topic: [PATCH v6 17/18] drm/i915/alpm: Program zero-based LFPS half
 cycle duration
Thread-Index: AQHdRUGfM6nioix+jkmcbT1cqaua3rbqEMeA
Date: Fri, 2 Oct 2026 09:08:55 +0000
Message-ID: <9ee54c5ac453ad0b26404734ad9cbb2fe130345f.camel@intel.com>
References: <20260915180449.277933-1-animesh.manna@intel.com>
 <20260915180449.277933-18-animesh.manna@intel.com>
In-Reply-To: <20260915180449.277933-18-animesh.manna@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6019:EE_|IA1PR11MB7943:EE_
x-ms-office365-filtering-correlation-id: 31068b71-c2db-49b0-83cc-08df2064c92b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|38070700021|11063799006|56012099006|4143699003|22082099003|10067099003|18002099003;
x-microsoft-antispam-message-info: 5gFYsIscNKQUVspsSOPj5C3DBJy4wA6uzgQu1B1NnwwBjyEfwfzatIDuegwx7298kDUc4aT5wMa4O8s50qwyZri2kp4lBcndQBESMCKCCJnSsz9VNQMrmB5Mmplw4hAS5hjznDoqwSKoR/GIPS3PX/JM5C9E1QnSdqV8IqEyl0rx00yBQcOmuLXapLcwPzioNkVVCtjmLNODT6fpg6ll9sOGHc2dMdGoJZ+iVjAb8XhIs/lEAVjuKg8Sr+sglqoEISPrZ5Wp5Ef5e171vhWRZQmcWxohzfCKE4JxHBsuRdxj4keAgJ4MStwsSSOjtBeDRVHeOwnGDPeU+JTt/GVn37vPRRwIBU5fI2vmfsFs0LGF92nH1BQIPTlycmoePJF8Qm8MfMaFkzyugmb9Ouukwqude8Hcvvg9x7iSEDuBRk90tmFEwOR561dPnhb4MHeTx5WOLEwshSb1zwDOM9BP+UVHMRXLudqQXvr1K6V1b/IoL3DCGyNKJhPnp0dM5k9wsTO60vlf2Dtb9DXq8Ldz0XGGDneQnwVu2XWd6ZlgUWlVLemrqm5+yiPticp4W/M0C3k8L82Aj0frvthSukXCD3kmsOCDlF7jibY16kxRKyk2MhXKWA988THXfcgTYYD+Wmvi3zvkHlvZi1Qi+VlcqEquvC4jZG+R0lnwIs9MI53EjJ7cnVzYQU7Ay0nhj0xi1qkcDF3OZ7d+d5vzo3w8UgtdGgVTJd75qVRCTc5imHk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6019.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(11063799006)(56012099006)(4143699003)(22082099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVVtK2J0U2daa2Z4ckhaOWJ6LzJFSVZJd1R2bFV6N25qQW4vTjNGWm9oSldx?=
 =?utf-8?B?RUxHbTB3eVVUK0N2WHZDWVBBTlY3bENiOUIvTlg0UGYzQlVnVDE1eTlLVFVZ?=
 =?utf-8?B?VS8xRU9VVHlKeVUveGNEdE5mWTdGdjdhTU9XbkFzUVBabWRIeFMrZE9rVnNj?=
 =?utf-8?B?NCtaTDJrc2xtSkVqQXVYNGNuWUFucXNnTGlXTlRxRjNmZ2JHTUV2M1lkc001?=
 =?utf-8?B?VVljVXVXOVpXY3RpR1lGSzhZd0ozMGtYZElOeGZMOFVsMUozWFN6VTNIc2Iw?=
 =?utf-8?B?R2tIbUp2NVpNZW9aS2Qwc1NLQS93SjMxVmdrRWl5NXlwUnZJOWZ1S2ZqTkJR?=
 =?utf-8?B?aXF3Ly9WbXcvZDlSYXBVeGxuc2tTK1Z6U3BKV3hXSTR6OXQyTXJhWnRLTDha?=
 =?utf-8?B?SFVUSTRzdHJzZlV1Rk1aWXM0WnVINVpLTW5zVWRFTVByZ3JPSHVWekxkN0hm?=
 =?utf-8?B?c0twS2Mxb3BpR3NONU9Gbit6NlV1d0JnajVqQTB2UlF1N2NTcThyMWh2OTFP?=
 =?utf-8?B?UUwrOThJSzcvMWVYYnlkN29Sd3lBSld3VDVRQXZsSWs2dFJtVVNaWXBYa05s?=
 =?utf-8?B?b0RGZGphMFcxS1N5Yko0K204aXZ3TjduV09rMU5sOG40V25KdW9qdVhJVktw?=
 =?utf-8?B?amt1SW1pWk8wRURoeDRIZDVUVHRxSCt2MWtHaXpmYy9jSTh4V28vcUlOREdk?=
 =?utf-8?B?QnVkRndSUzhxOEtFTlB2YmlXMVpWa1R3SXhEZDFJOWZQTmdjKzU5bTViRVkv?=
 =?utf-8?B?Y2RLWmNnVWp2eUtTU0Z6RmZOMjFQSkt3MXRkUjkzKzhmczlndXJYR25sZnMv?=
 =?utf-8?B?QjVlUFl5aEZ5M0RCbU9RTnJPNGJ3T0M2WWw4WDJZeTJ2b3Q3SStsbm9BS2l4?=
 =?utf-8?B?QTYyK2NVaTlHUjkyU0RqQlp5TjF6ZXVqWDFISjBlQmVremZKc1VjVU05NU9R?=
 =?utf-8?B?NmZVNUx6Y1FKSEloaEhCbzBPZXNPQUFOS0tkQlE2L3hZcGtacXJldkxpREs5?=
 =?utf-8?B?bHVyRzBHTEhrWjhtTWFKMzB4QWhSbmxpa1BkNWp3MXNxVHlGSXFrc2V6a0FT?=
 =?utf-8?B?dWtUZUV4eHlSdWN0K0Y4MStnNzhEb3dEMW5xQUFmQ1JtWWRwVkprVHpqRjRF?=
 =?utf-8?B?VTlLbWpoeWhrT0NXa0lpZDc0MktPZmNVOVVtM0loTEpUT1pSMUJaaFlaMFR4?=
 =?utf-8?B?bVNsWFNITjc2T2l6aHlndkluU3U1TlZ0eXZyMUQwRzZYaTFiSHhwaGFVeFZD?=
 =?utf-8?B?T05JQ2MvSk9sMVJuTVo2WmdWL2RVRVBqVWJCUHlMS0s4REt5OThlbkdVamoz?=
 =?utf-8?B?dXA4UHYyaGNlSVY5cWp5TWZ4cnQ2Qk50NmVaUzhaWnpnUUYzVFpyT3A3dDVi?=
 =?utf-8?B?WldHWGhibjBsejJKUDJxK2VYV2N4RnJyK01lQUVvL1VKWUlybUFLaFlCSXM4?=
 =?utf-8?B?TW05c0V1cW9IdXRhWVJZNHFpcjJmZkFDSkdpWHVIOTFYV1FzQk1CQ05aWU0v?=
 =?utf-8?B?cERKWEgvemtXYkFZQnJJdC9qN0U1WWRBcEZ5NmVXSU0wNktiZ3dxOGJnU0NK?=
 =?utf-8?B?V2MzQ2p0TThqQW1SRDNuaTVnYmtheWpGQ0dic3N6S1EvTm5mSGdhaVI0NlVu?=
 =?utf-8?B?MGtwZ1BZaXJKeWloL1paSGRmWUIwZk1mZ24zVVh6YUdkOHV4Zk5TeVBMMVQy?=
 =?utf-8?B?NUFVVmRGa3dSMnZ1TlBXTWl0NHdFRjJ0NUdqUkpCc1owOFlMN0oreUQwTE9F?=
 =?utf-8?B?cjRyWmNDQlpOUjBGQjI0NWJhbnJOcXNCVkZVUnEwQzJ4NFJPOU9aV0VibGhK?=
 =?utf-8?B?N2J1K01vQkREeFJaUXRGU2FSR3ArQ2N5R0NseVhjb0YzREVHK1Yzc2JxeDVN?=
 =?utf-8?B?OWZUdVhXTTB3eGtpdjdrRlJNcm0yVjZ6R2NTRmNrREI2dFJNa3k4bzVRbTVN?=
 =?utf-8?B?blc5QjFheUN6U1BWRUl2S1RscU1ZUCsrM25MK0lVU0FZaWd2ODhiK0lUR0V3?=
 =?utf-8?B?OXVlck12em5IbW9MamxtRFRNWkVQQ2dtNGk4aU15VDRtcGh0dGcvYWIvb2tP?=
 =?utf-8?B?K0ZmZm1hZzRLUHhBWmw5UjNpTnB3dnlKMDhaWEI3dVhzR2dPWDN2a2tDa2F1?=
 =?utf-8?B?UzFuT1VUOUxSK1JtM0RLMGs0a2tkcWZ0LzdKVitWSTJZRnB4VUJQOTBYSnJh?=
 =?utf-8?B?Vy9zSitoRVdmK0pVWEw0N1VjYjM1OWRBMHRPTnVYOW9jYkZsd0p2V1A1NWJk?=
 =?utf-8?B?b3dZZ2p0UmppR3lNZ1lpQWg1Y1pCT1IzWnRaZjJxQldwL2Rhd0ticWRoQzFU?=
 =?utf-8?B?QmRYNWJUYTFMZGYxODhhWUNYR2VHN0YrNUl3bWFCUCs5Tmx3VE5ONnZhL3py?=
 =?utf-8?Q?MbKZi/OcMapt6dvA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <13623CE3FF33AE4FA1F5E09ABAF8F7B7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NMQOtd+jqjfegiqTW1wGNzLV388pKW/x2QEZUYRsPUU6NSfIDluhab/iDZVAugmi6hLx6l7cqUJaRqReHW6tUSwQoKEFdu495Pf/4IITnY7ZfRRl6JGfBgtEnvRMrvbCz62Y2bYWwfgbqQgxQ1SgmiJL7le3MonuF/iAcXIW6XpjWmq9F+iP+pYYSg8cCOOVX79x1oLTZSpsSS1yxdvjONJJgEbrDmP4dRpgYQerJkbFnHrg8lVlyQ20DHQt8dnk8BIc1CXvSZkm0KVdQ8gylEIcfFevhiPYlJ9SpJFYwmNPu8dAMZvwvMH/FU1m7psKsODVOTdPcg9VWl21fKSiqw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31068b71-c2db-49b0-83cc-08df2064c92b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2026 09:08:55.3606 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lk/3EU4JEDp49sejiP5/bLDUcGJX3IbrM7e+Y2d792cD7Zc5PJziILzdYkMHFDZNwO+JjcwuqHA5tnGHTyusuRKiN45Wr9DQMmDpc/v8/ts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7943
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

T24gVHVlLCAyMDI2LTA5LTE1IGF0IDIzOjM0ICswNTMwLCBBbmltZXNoIE1hbm5hIHdyb3RlOg0K
PiBUaGUgTEZQUyBIYWxmIEN5Y2xlIER1cmF0aW9uIGZpZWxkLCBhcyB3ZWxsIGFzIHRoZSBGaXJz
dCBhbmQgTGFzdA0KPiBMRlBTDQo+IEhhbGYgQ3ljbGUgRHVyYXRpb24gZmllbGRzLCBpbiBQT1JU
X0FMUE1fTEZQU19DVEwgYXJlIHplcm8tYmFzZWQ6IHBlcg0KPiBCc3BlYyB0aGUgdmFsdWUgcHJv
Z3JhbW1lZCBtdXN0IGJlIE5fU3ltYm9sIC0gMS4gVGhlIG51bWJlciBvZg0KPiBzeW1ib2xzDQo+
IHdhcyBwcm9ncmFtbWVkIGRpcmVjdGx5LCBtYWtpbmcgZWFjaCBoYWxmIGN5Y2xlIG9uZSBzeW1i
b2wgY2xvY2sgdG9vDQo+IGxvbmcuDQo+IA0KPiBTdWJ0cmFjdCBvbmUgaW4gdGhlIFBPUlRfQUxQ
TV9MRlBTX0NUTF9MRlBTX0hBTEZfQ1lDTEVfRFVSQVRJT04sDQo+IFBPUlRfQUxQTV9MRlBTX0NU
TF9GSVJTVF9MRlBTX0hBTEZfQ1lDTEVfRFVSQVRJT04gYW5kDQo+IFBPUlRfQUxQTV9MRlBTX0NU
TF9MQVNUX0xGUFNfSEFMRl9DWUNMRV9EVVJBVElPTiBmaWVsZCBtYWNyb3Mgc28gdGhlDQo+IHBy
b2dyYW1tZWQgdmFsdWUgbWF0Y2hlcyB0aGUgemVyby1iYXNlZCBmaWVsZCBlbmNvZGluZy4NCj4g
DQo+IEJzcGVjOiA3MTYzMg0KPiBDYzogSm91bmkgSMO2Z2FuZGVyIDxqb3VuaS5ob2dhbmRlckBp
bnRlbC5jb20+DQo+IEFzc2lzdGVkLWJ5OiBDbGF1ZGU6Y2xhdWRlLW9wdXMtNC04DQo+IFNpZ25l
ZC1vZmYtYnk6IEFuaW1lc2ggTWFubmEgPGFuaW1lc2gubWFubmFAaW50ZWwuY29tPg0KDQpSZXZp
ZXdlZC1ieTogSm91bmkgSMO2Z2FuZGVyIDxqb3VuaS5ob2dhbmRlckBpbnRlbC5jb20+DQoNCj4g
LS0tDQo+IMKgZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9wc3JfcmVncy5oIHwg
MTIgKysrKysrKysrLS0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMyBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNw
bGF5L2ludGVsX3Bzcl9yZWdzLmgNCj4gYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2lu
dGVsX3Bzcl9yZWdzLmgNCj4gaW5kZXggOGY2MGI2NzE3NTVhLi4zODdlZGY4ZGY2ZTkgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfcHNyX3JlZ3MuaA0K
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX3Bzcl9yZWdzLmgNCj4g
QEAgLTMzOSwxMSArMzM5LDE3IEBADQo+IMKgI2RlZmluZcKgIFBPUlRfQUxQTV9MRlBTX0NUTF9M
RlBTX0NZQ0xFX0NPVU5UX01JTgkJNw0KPiDCoCNkZWZpbmXCoA0KPiBQT1JUX0FMUE1fTEZQU19D
VExfTEZQU19DWUNMRV9DT1VOVCh2YWwpCQlSRUdfRklFTERfUFJFUChQT1JUX0FMUE1fTEZQU19D
VExfTEZQU19DWUNMRV9DT1VOVF9NQVNLLCh2YWwpLVBPUlRfQUxQTV9MRlBTX0NUTF9MRlBTX0NZ
Q0xFX0NPVU5UX01JTikNCj4gwqAjZGVmaW5lwqANCj4gUE9SVF9BTFBNX0xGUFNfQ1RMX0xGUFNf
Q1lDTEVfQ09VTlRfWEUzTFBEKHZhbCkJUkVHX0ZJRUxEX1BSRVAoUE9SVF9BTFBNX0xGUFNfQ1RM
X0xGUFNfQ1lDTEVfQ09VTlRfTUFTS19YRTNMUEQsKHZhbCktUE9SVF9BTFBNX0xGUFNfQ1RMX0xG
UFNfQ1lDTEVfQ09VTlRfTUlOKQ0KPiArLyoNCj4gKyAqIFRoZSBMRlBTIGhhbGYgY3ljbGUgZHVy
YXRpb24gZmllbGRzIChpbmNsdWRpbmcgdGhlIGZpcnN0IGFuZCBsYXN0DQo+IGhhbGYNCj4gKyAq
IGN5Y2xlKSBhcmUgemVyby1iYXNlZCwgaS5lLiB0aGUgdmFsdWUgcHJvZ3JhbW1lZCBpcyBOX1N5
bWJvbCAtIDEuDQo+ICsgKg0KPiArICogQnNwZWM6IDcxNjMyDQo+ICsgKi8NCj4gwqAjZGVmaW5l
wqANCj4gUE9SVF9BTFBNX0xGUFNfQ1RMX0xGUFNfSEFMRl9DWUNMRV9EVVJBVElPTl9NQVNLCVJF
R19HRU5NQVNLKDIwLCAxNikNCj4gLSNkZWZpbmXCoA0KPiBQT1JUX0FMUE1fTEZQU19DVExfTEZQ
U19IQUxGX0NZQ0xFX0RVUkFUSU9OKHZhbCkJUkVHX0ZJRUxEX1BSRVAoUE9SVF9BTFBNX0xGUFNf
Q1RMX0xGUFNfSEFMRl9DWUNMRV9EVVJBVElPTl9NQVNLLHZhbCkNCj4gKyNkZWZpbmXCoA0KPiBQ
T1JUX0FMUE1fTEZQU19DVExfTEZQU19IQUxGX0NZQ0xFX0RVUkFUSU9OKHZhbCkJUkVHX0ZJRUxE
X1BSRVAoUE9SVF9BTFBNX0xGUFNfQ1RMX0xGUFNfSEFMRl9DWUNMRV9EVVJBVElPTl9NQVNLLCh2
YWwpLTEpDQo+IMKgI2RlZmluZcKgDQo+IFBPUlRfQUxQTV9MRlBTX0NUTF9GSVJTVF9MRlBTX0hB
TEZfQ1lDTEVfRFVSQVRJT05fTUFTSwlSRUdfR0VOTUFTSygxMg0KPiAsIDgpDQo+IC0jZGVmaW5l
wqANCj4gUE9SVF9BTFBNX0xGUFNfQ1RMX0ZJUlNUX0xGUFNfSEFMRl9DWUNMRV9EVVJBVElPTih2
YWwpCVJFR19GSUVMRF9QUkVQDQo+IChQT1JUX0FMUE1fTEZQU19DVExfRklSU1RfTEZQU19IQUxG
X0NZQ0xFX0RVUkFUSU9OX01BU0ssIHZhbCkNCj4gKyNkZWZpbmXCoA0KPiBQT1JUX0FMUE1fTEZQ
U19DVExfRklSU1RfTEZQU19IQUxGX0NZQ0xFX0RVUkFUSU9OKHZhbCkJUkVHX0ZJRUxEX1BSRVAN
Cj4gKFBPUlRfQUxQTV9MRlBTX0NUTF9GSVJTVF9MRlBTX0hBTEZfQ1lDTEVfRFVSQVRJT05fTUFT
SywgKHZhbCkgLSAxKQ0KPiDCoCNkZWZpbmXCoA0KPiBQT1JUX0FMUE1fTEZQU19DVExfTEFTVF9M
RlBTX0hBTEZfQ1lDTEVfRFVSQVRJT05fTUFTSwlSRUdfR0VOTUFTSyg0LCAwKQ0KPiAtI2RlZmlu
ZcKgDQo+IFBPUlRfQUxQTV9MRlBTX0NUTF9MQVNUX0xGUFNfSEFMRl9DWUNMRV9EVVJBVElPTih2
YWwpCVJFR19GSUVMRF9QUkVQKFBPUlRfQUxQTV9MRlBTX0NUTF9MQVNUX0xGUFNfSEFMRl9DWUNM
RV9EVVJBVElPTl9NQVNLLHZhbCkNCj4gKyNkZWZpbmXCoA0KPiBQT1JUX0FMUE1fTEZQU19DVExf
TEFTVF9MRlBTX0hBTEZfQ1lDTEVfRFVSQVRJT04odmFsKQlSRUdfRklFTERfUFJFUChQT1JUX0FM
UE1fTEZQU19DVExfTEFTVF9MRlBTX0hBTEZfQ1lDTEVfRFVSQVRJT05fTUFTSywodmFsKS0xKQ0K
PiDCoA0KPiDCoCNlbmRpZiAvKiBfX0lOVEVMX1BTUl9SRUdTX0hfXyAqLw0KDQo=
