Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4678ACA5FA2
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 11:23:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F6E310EA21;
	Mon, 28 Sep 2026 11:23:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ONA0+gdZ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDC6310E092;
 Mon, 28 Sep 2026 11:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790594562; x=1822130562;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=jSxy2ErK+igPFyfuNi5337yKDYhLI6ld5ekboy4fjXQ=;
 b=ONA0+gdZOXfUGRGgpeDlH0uSdu1WibaKB9kBRl71OWvmlZbmy6ma2p43
 a7uEJbGJyAPlO5J8bQ707sldWZSruKzi0/z0JjVn8fmz/yweu9YyAydId
 TLwZ3PK7VTmGK4TgvUoAL/JO5CsFtt4vlZ2qwVgEBcFhJw4ehULGCkp3B
 CdfQ1Ew7Ri/bBFZFEp3omNvvKeDsgcIahyAGs0XjPA1+WorGww+tsb33s
 X9Yp3Cg9WOgMRSoW1yylAJShtBrxpsunxwffNYQGONo3xf6zgpqpNa146
 C2fbCEv73DpfgZXepKmGCfR9QKFDbXMWU7ogp62uRjiGEQk9psD+61dlq g==;
X-CSE-ConnectionGUID: 0d8NKcPxSim9JnUPgf33nw==
X-CSE-MsgGUID: mNgF6WK9TlyCnWSNTse4TQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90418864"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="90418864"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 04:22:41 -0700
X-CSE-ConnectionGUID: ZTcxbLpRTS+9qYcGq6v6BQ==
X-CSE-MsgGUID: EWJYlI5USmyUyhujXY6ZMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="272822259"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 04:22:42 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 04:22:41 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 04:22:40 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.15) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 04:22:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UhvCowryeml57Rq8h8f5h4djDofUcv/gn+HIKAV9K0VrCTMtEX8KnMznY1Bz0D7nxMsREJwmi2w+W99LJiuWum3tg1YV2e0UVlxuyUC7aIs8qTrxiOlCp9THHFYFoWD4LvZ1wci2vaKGpW0SlZO4eSGfCSjJXzpzlNUFcvtAlXltcTCN/h4kGZqjRdyTyJyPn60VHeX0YFxrjuGKt9mbNAC2t8w/FtClKPAe96ty7nkBpaD88zeT8QbiaNVf05yqFYGjlui5iezNSlUSJCr0hmkDgsItAKPJU9w6/bpFUA3Wtceu6MEFpLj1sluD+huQrs1UkFDsiXmqKXUlTcg7uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jSxy2ErK+igPFyfuNi5337yKDYhLI6ld5ekboy4fjXQ=;
 b=uFwZi5HF+yJNqfy1/4sTmp/YzryT3UTklp8qogNnsqc28RSy0b3ndMxx7rZS9YNpjshdH+1YKg0YEKRfcZWyNW2xx9TvWM7A29QTDD5ZV5ceXekAlCaFgG/KDbHtJ9rCU04TpmjJFEM6jTWRL45W5bMHmYrHfD0EbSJ/CjHU1RIPnSbY0mUKz2M0U530n/P85//wyOQeu0tVRS9A8fHRP2U5UnqDDc/iGxQDTRHhQWVSPDg15K26WixPdEYBO2OoMekuW2yokw76nTAYNcHHTziSbD4dCk9SSwQu01HMeUc5Nq9jhQkb9xiIuXWbdjkJBit/MeUVW/+iPky/Si5aUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6019.namprd11.prod.outlook.com (2603:10b6:8:60::5) by
 CO1PR11MB5138.namprd11.prod.outlook.com (2603:10b6:303:94::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.24; Mon, 28 Sep 2026 11:22:39 +0000
Received: from DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762]) by DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 11:22:39 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Manna,
 Animesh" <animesh.manna@intel.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>
CC: "Kandpal, Suraj" <suraj.kandpal@intel.com>, "Nikula, Jani"
 <jani.nikula@intel.com>
Subject: Re: [PATCH v6 04/18] drm/i915/alpm: Enable debugfs for DP2.1
Thread-Topic: [PATCH v6 04/18] drm/i915/alpm: Enable debugfs for DP2.1
Thread-Index: AQHdRUGGiVamVKja4kCGBKljYMs6rLbj7NGA
Date: Mon, 28 Sep 2026 11:22:38 +0000
Message-ID: <337289744188eab13f37d8725002ce9dcbd4cc9f.camel@intel.com>
References: <20260915180449.277933-1-animesh.manna@intel.com>
 <20260915180449.277933-5-animesh.manna@intel.com>
In-Reply-To: <20260915180449.277933-5-animesh.manna@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6019:EE_|CO1PR11MB5138:EE_
x-ms-office365-filtering-correlation-id: b2314a7a-5355-478b-b046-08df1d52cdf0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|38070700021|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: 0nN0OMzYRPbB6NocWwRI/npDT5/ySY5ce3a992/B5MEdqCwqfov9K+3RNRo17VyTda10/6bcx5HcGq/NXaZbrxFwq2hjm8vry/7OrDZUIRYxKfcksCFe2+ZitRBDnaYSDJcuDXq7Q8y8BMvAlmNBSw5c5vyF2JQ48twyE5kGQ/ST4/ONu8X8q2P5cV/QXgePOpTWOoYD1LatDbW08q9iQ2EnMwo6wScSSfRaPf+FkewZmzb0sHZ+vE+wO24QmE/7O9zX4rbcM3/p9oPIAllp456Vd36adk7u0SUniBTRzLT7CERT7x6lVxo8OB6p/LVwqmBZsOHwrydoYfIJHE9HVMujs9GgfKJta88IxdPPlC7djEXHrCm/Y6XJMAYATb/4av7e3Mz9oeJUZWmm6sROGnQmudkzOKWx81PfLlM1WU36w8PpjJUCH7rb2VdzMpwR5IiqQzd/8rJrS5DDGbPhxNmqzhfeQGtP5w4ksV04t2vMlIJSwo28fpGWllbZxa4ilrDJStTEmBBZqyUKKDOwMATYcmsaS9oCirS1T8Jt9VqrxG8zz+MTHle94tudSj7iT8RiaEhh8olswLoIWw/zc0UT+tQH02XGIus6EEJzjhPUPZe7qWWdTUvR9A0lCHBkdk5ky5eGiRTuY4ttNxq6zh0pY6dfmxawM43B0l7TfE/edVAJYIotNWFMJZFLgulQYlCN29eWMuJjwOENwx5SA/1O5wb/EUBW1Zi4pSpHkLk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6019.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGdGaFlOYmlPMlNaMHRJalRFVTVCR21NQkQrbVN0S2JLKzBTcUNnK2JEcERm?=
 =?utf-8?B?b0djUDlyeTZELzZUdHF2dVRxSkE0ZG9Hc0s1bC9FeXpOakszWE9IaUp5T1hX?=
 =?utf-8?B?TlFzakJDTDA3V3lEQ3QzUktiUzliQWxMNlk1SjMzQnVZMzZkUXFYbkQ3TEtn?=
 =?utf-8?B?bTh6RElPYVpsT2tlU2hFcUZITVlLeXhUS1ZhNnpoeXFUU003aGJaVytxcHp4?=
 =?utf-8?B?SnRwOTVUUkg0eUJOT280aDM2UWRLL2tqQTdVeTNWdWNDaVQ0UTJDSGdLRVpS?=
 =?utf-8?B?MDRvejAyUHdSNEwySUViS1BYNDh4TkJ5UmJVaDJMT3F3emlxdmI1WEZjbkNs?=
 =?utf-8?B?STg0dDA1Mk9TTEl6V1hKendPb3dRS043aVFoT05HWTc4OUFzbXZpTkF3UFJW?=
 =?utf-8?B?UzNFVEJjY2o3Q1IzR29oL29vK3BGdWViNitoRjlET1pZMy9lN3IySGllbTUx?=
 =?utf-8?B?d3E4UzRra05rTEhCdlBRUmkwdW1kdm9OVmJ6RUdEdjlRb0tFcWg2czE3NXpW?=
 =?utf-8?B?Z2hycmFzdWFVdzQ3WCt5Yk44dG4vNlJFZG5iaHduWllaWGNmbnZoQlNVcGly?=
 =?utf-8?B?dG5FMFpYekpuKzRhVzI4ZjFpM05EdHpOSmVVdHE5ZDZoY2g4WWxvWjcwOGtS?=
 =?utf-8?B?R3hkZHpSWXcvbks4TWRpQmFsYUx5cklFcmtVWkVSejB0bUtHY2R1eHFuK3Y2?=
 =?utf-8?B?ZjBGKzV2Qk9TdjEvQnhrb2pBc0t4SXowMzBkUHZQM0hKeThnZVVRcWovRTJO?=
 =?utf-8?B?bmUxZW1IRTluQnh0Si9MMStsRkdwd2p0UmVhY0tKQXdUOHhCd29YU3h1QS9I?=
 =?utf-8?B?YmRDTHpsSk1Ici9UU2lsNGNkUXF5SzhiNW1MTVJmUEx0aEFvYXlkb3IvOVhS?=
 =?utf-8?B?WGJTeC8zNklEeTA4Ty96VU5nNGhJSzllT2VheitYZG1yR2tiNjdCR3FocS9I?=
 =?utf-8?B?WkpkeHhDZDYxaEM1a002Q3F1Y2N5SG9Rb1F0dVd3alpaZnF4UXZhQ1R1K2xX?=
 =?utf-8?B?NzdCaFZzSzV3U0hsTFFLb01xU2M4dXJTK2oxQnluU2ZuTU5EaG50M3Z2cGl3?=
 =?utf-8?B?QkRFZURnamkvRzJtTmJrYzBOV2NRV3NMc3RvR3dyNkwxUEYxOHEyWXIrSXMx?=
 =?utf-8?B?NE1hb1hNWGRscDhxMjBwOVVLbTFlS0tLK1M4V0tYSmpUY3oxbTBXZXNLaHR3?=
 =?utf-8?B?dW9lb0w0MEI5bnN6QTM5RzB4S2FCWXlJemIwVmRKd3RGblJxNS9rckVFUVI5?=
 =?utf-8?B?TkY2c0g3YVl4RjlzUkZSTFJrMUd1WHR2RHBKdWp4blpiV0pLTnlvOVJ3d3dv?=
 =?utf-8?B?cUhua1lzelBNUllBMi9JcTY4ZzAyek9mN2FXTmFsQ3R5UHQ1dWhhbXhXTmdj?=
 =?utf-8?B?MlQzSGtmNVZBNmNkQXFyNUZPdnppT3RCTjlvNVRJRzZsZFRDSnBCYVJleldJ?=
 =?utf-8?B?ZTZSOUVvdFp5VGJ0dHYvSVZYeE03YUI1eGNLNnNEMFFFd093bGhiM2pHRlR5?=
 =?utf-8?B?cUhhWHJkc0xEV09LWkFxbCtjSk5rbXJXeXRsUzVPYURQRUJJRUh0MitBdHEw?=
 =?utf-8?B?WHVsdERsUkFzd0FCSElFRVZuNWgyb1ZCYzBSbzdVQy9FVmhxdkphVmJPdVJB?=
 =?utf-8?B?bEVkTFU3QVJlbWlwU00yeEF5aytaSmZpaWVTV0Q2aWsvZ0VLbnNXb0hucGpP?=
 =?utf-8?B?dGlzZW1nK2Q4MTRZQWxPYS95OUhmbjRKYld2WnQ3RXc2YlFXNmtRK1pPeGxF?=
 =?utf-8?B?NVZLVGlhSzJYNVZRV09tL3FZOUJIVXNuS01SZitHbTNrWkFVbGlTLzhVWndG?=
 =?utf-8?B?R3Y5aFV5MXJEVFB1dVp4N085QmUwempRVS91N1ZGVGxaQW1sL3lrKzR0VVRy?=
 =?utf-8?B?blVlcEUrMFgvcUxMcXBaZzZXa2d0QzBsSmhRNHlNbExtRXVwcXcxWmRyaVZ6?=
 =?utf-8?B?akVkUmQ1YlVxcGVldW42dDRjS2ppM0RjN2tGcDF2SW1SYjFGWFdlRmthTlpX?=
 =?utf-8?B?Wi9kTGJSVG1YRURyK21oK21lVVlIUDZQRU45ODJuU2grK1hick8zOGZvTWc4?=
 =?utf-8?B?Z0J3cm1wUzBxSGViOGZEbkhwekt3TVd1UEpheGV2WXdibnV0V3RlTml3blE0?=
 =?utf-8?B?OXd4dzdrSGNCYk4xZEl1ejduZVArZEV6RGY5WHJVK2IrS2F5Vkwxc0pOZ010?=
 =?utf-8?B?Y21nYlRNTWFVdmFDdXMwNVMyemgraTJpRGxFUmNJcGZCZGRHVTFvSzdxbitQ?=
 =?utf-8?B?RzFoa3VudzZNU0gzTFBZNks0QUd3eEhRaTI4V0RxR3R0YlBoRVBDSlZpYVpB?=
 =?utf-8?B?QnF2V0luckxNeWJZeHYzRTFPWjI2YnVhOW5TVkhDTjB4OHhjODNMRmkvaHdj?=
 =?utf-8?Q?oH0NksfwLDoZBp3s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <729FD736326E844986422458B783AF68@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DEkT2XZcweZSCzTilLDc1dBUvMFl0x8oilyiFqIj28ENy4qahiVHxGVhofFwCc8A899ptdNobvesGq1cxOS5fpgU9dQR/O2D3Cmn+feODf/GoUyJahgQIEX8h6W6lcAZSwA2O6Vf/rEsgtpnkDpNZvBfAKLiq33gAsbImWGKGjWLlgJrZV2lavr0X8egzgZdH3YnZ6j9dTQNats3a2HQGrfHyP2FB2hTAWlgjXhHjj38n/1jdK1mGZ21X6HwTD/4Tbdvv5d2UKVd10mIvUxzKsuLWYs20VINKZqGJ5ci/EYOMVreAeorHqD8ndWC/F6BQV8bfPJnTRWfKkf4iSCEDg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2314a7a-5355-478b-b046-08df1d52cdf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 11:22:38.9195 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R10ETVmDd7DU4uH8VmPDTjFuCiz4UiU5/mzqL2YisZkPquNAN4HUJicumtu1RbkrRKd3z0hGFK7C20dBkYCt1xnOvY1R0iZXVBK7N5MrVkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5138
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
PiBFbmFibGUgQUxQTSBkZWJ1ZyBpbmZvIHRocm91Z2ggbG9iZiBkZWJ1ZyBpbmZvLg0KPiANCj4g
djI6IGNvc21ldGljIGNoYW5nZS4gW1N1cmFqXQ0KPiB2MzogVXNlIGNvbW1vbiBhcGkgaW5zdGVh
ZCBvZiBESVNQTEFZX1ZFUiBjaGVjayBpbiBtdWx0aXBsZSBwbGFjZXMuDQo+IFtKYW5pXQ0KPiB2
NDogQWRkIGRpc3BsYXktdmVyc2lvbiBjaGVjayBhcyBpdCBkcm9wcGVkIGZvciBFRFAuDQo+IA0K
PiBDYzogSm91bmkgSMO2Z2FuZGVyIDxqb3VuaS5ob2dhbmRlckBpbnRlbC5jb20+DQo+IFJldmll
d2VkLWJ5OiBTdXJhaiBLYW5kcGFsIDxzdXJhai5rYW5kcGFsQGludGVsLmNvbT4NCj4gU2lnbmVk
LW9mZi1ieTogQW5pbWVzaCBNYW5uYSA8YW5pbWVzaC5tYW5uYUBpbnRlbC5jb20+DQo+IC0tLQ0K
PiDCoGRyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5jIHwgNiArKysrLS0N
Cj4gwqAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5j
DQo+IGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9hbHBtLmMNCj4gaW5kZXgg
NDgwMWZjNmJhZGUyLi45MDE0OTNiYjE0NDggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1
L2Rpc3BsYXkvaW50ZWxfYWxwbS5jDQo+IEBAIC03MzksOCArNzM5LDEwIEBAIHZvaWQgaW50ZWxf
YWxwbV9sb2JmX2RlYnVnZnNfYWRkKHN0cnVjdA0KPiBpbnRlbF9jb25uZWN0b3IgKmNvbm5lY3Rv
cikNCj4gwqAJc3RydWN0IGludGVsX2Rpc3BsYXkgKmRpc3BsYXkgPSB0b19pbnRlbF9kaXNwbGF5
KGNvbm5lY3Rvcik7DQo+IMKgCXN0cnVjdCBkZW50cnkgKnJvb3QgPSBjb25uZWN0b3ItPmJhc2Uu
ZGVidWdmc19lbnRyeTsNCj4gwqANCj4gLQlpZiAoRElTUExBWV9WRVIoZGlzcGxheSkgPCAyMCB8
fA0KPiAtCcKgwqDCoCBjb25uZWN0b3ItPmJhc2UuY29ubmVjdG9yX3R5cGUgIT0NCj4gRFJNX01P
REVfQ09OTkVDVE9SX2VEUCkNCj4gKwlpZiAoRElTUExBWV9WRVIoZGlzcGxheSkgPCAyMCkNCj4g
KwkJcmV0dXJuOw0KPiArDQo+ICsJaWYgKCFpbnRlbF9hbHBtX3NvdXJjZV9zdXBwb3J0ZWQoY29u
bmVjdG9yKSkNCj4gwqAJCXJldHVybjsNCj4gwqANCj4gwqAJZGVidWdmc19jcmVhdGVfZmlsZSgi
aTkxNV9lZHBfbG9iZl9kZWJ1ZyIsIDA2NDQsIHJvb3QsDQoNClRoZXNlIGFyZSBuYW1lZCBhcyBp
OTE1X2VkcF9sb2JmX2RlYnVnIGV2ZW4gaWYgdGhleSBhcmUgY3JlYXRlZCBvbiBEUA0KY29ubmVj
dG9yLg0KDQpCUiwNCkpvdW5pIEjDtmdhbmRlcg0KDQo=
