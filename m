Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B81A606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 01:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MmuxnoSo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0350A10F914;
	Wed,  4 Nov 2026 01:35:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCFE910F8F5;
 Wed,  4 Nov 2026 01:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793756132; x=1825292132;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=yyJLp4eKpWYLd/pKK0UkuFflWBwgT/HzXEXGnucQWNI=;
 b=MmuxnoSorMRijY5Ar4h6Gb4+RO12W4T1x4MkPRs3OFOUjiUYkF1pW/c7
 Gdmr4FyUA8U58zpdZiEL6/QOnuUvUoUM9iH+rn/eQjVdY8L6Kqni9YHl6
 EDcph8CXB76vtk2QAxRK9gRqFN5kj2SBMBIHWd3iJzLw7l1LvkpxeKQ4F
 G5WAK6m/QhGexdre7AFTxgnxx/ruKFOZOthGEPZun1kleqZprzTUHZOFb
 8RhvJwWwbSS7JW1GZ7t5M/MOdXsq4krRq63SESUilhmnLGxO9+bATZIr/
 qiCxbb8/V202FxtEr90uh1ApF4jdsUyJN5sGsUs2ZWZLSCr+uv9kczdJO g==;
X-CSE-ConnectionGUID: +J1jsJOvQwGK8qFZ/B1pyg==
X-CSE-MsgGUID: uD/rKuE8So2mEo55V6cB6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2517837"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2517837"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 17:35:31 -0800
X-CSE-ConnectionGUID: Q81Yz7kbT9OpLztne4A9WQ==
X-CSE-MsgGUID: Gmn25r1RRXOJ5XQMNy48EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="6911760"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 17:35:31 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 17:35:30 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 17:35:30 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.66) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 17:35:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KxpIztOiMPLIm0tWkSe77DbOLNvy8WFrH9JsWUIK4APRwwIh5O20kkthU6siOKQnaoZVGJg7pa1F+Fi3H3VEw39JZfanASdNqjCTMylINPHooMDOkopr5wecnZbQynilyTrrmtLFNfo+1v3g8NQxgua7ObPUA4AoBiCuvYqJKwV2XzcS0eYrmOnokB91Zydkp8dL5vmbfas4txwEZuUZYxFaPI51s0pso41Barj0x50Ovz0wC93RRlVfWGiiuakjKEWN0OE8VE9oRrNLb7t31hH0JO1Fo0Oh/US0d3tGSkbu3n9+l+QRwPCldV1PcDf+fFRyC5xzC88dOIGK8d1P/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyJLp4eKpWYLd/pKK0UkuFflWBwgT/HzXEXGnucQWNI=;
 b=zDMmXADWO3QVqdi8UA8vkm1Bd/pL20Lhbx42xl6BcuNcOKMWxaKMT15+3tTMDqBAaY3HwUtkyqvXlCOObth8tNEMK1OcLRzrUMmWGapwij9KA1m4QH/x/vrOhOnpP4ChNfRc3JtyDILc/vYo7wDxTHG602H9u/fJEbs7tURybmWfUSf+vje0vtixRNxWNhQ32KHpdANzwO6rvvBvG7aBq2sotzeqbIVuDTgB8LjhVNiI5MLseajxx8n85bfbm21s5r5yXCPilJcjIhwo67TYu1cnuXWrX96f7M2B4X5fR37ZFBFpQ7ujg2yZrDqrxTT2DS75klgCE+dIVosTBOQUHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8134.namprd11.prod.outlook.com (2603:10b6:8:15a::9) by
 PH7PR11MB6907.namprd11.prod.outlook.com (2603:10b6:510:203::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 01:35:27 +0000
Received: from DS0PR11MB8134.namprd11.prod.outlook.com
 ([fe80::d95d:cb19:df8f:1610]) by DS0PR11MB8134.namprd11.prod.outlook.com
 ([fe80::d95d:cb19:df8f:1610%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 01:35:26 +0000
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
Subject: RE: [PATCH 1/2] drm/xe/display: Skip initial plane allocation from
 stolen memory on RT
Thread-Topic: [PATCH 1/2] drm/xe/display: Skip initial plane allocation from
 stolen memory on RT
Thread-Index: AQHda0Q7lDfsqfAqaUi6ti4zRu9aNLccKkKAgAD3WpA=
Date: Wed, 4 Nov 2026 01:35:26 +0000
Message-ID: <DS0PR11MB81344F9A6B315D482BE659CEEC682@DS0PR11MB8134.namprd11.prod.outlook.com>
References: <20261104032732.30681-1-junxiao.chang@intel.com>
 <20261104032732.30681-2-junxiao.chang@intel.com>
 <65fae402-e053-4a4f-ba55-6b5b51690eba@lankhorst.se>
In-Reply-To: <65fae402-e053-4a4f-ba55-6b5b51690eba@lankhorst.se>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8134:EE_|PH7PR11MB6907:EE_
x-ms-office365-filtering-correlation-id: 294e1d5e-f570-4004-dc9b-08df3a13e716
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|1800799024|23010399003|22082099003|18002099003|261102123227099003|56012099006|10067099003|921020|261021121427099003|261022075727099003|4143699003|11063799006|38070700021|261026121527099003;
x-microsoft-antispam-message-info: RFY0+26eDhJiGjGjZTv9FAgvC4YbuIU5Y30f5o8MWygfZdR25WlpH8vIgC4J+Y+VD76tpUziM9/DHFp/V2842RDK5jifZqoAREqhPZNzHqRiogNRei2OAwBRqLnLqfwwNFS9QV/eDmJPXhrjaQ+jKOROXRkiCaBaUBDj9WlJgvXhwGld01h0WQKLEyf6FZQD+dC7m+4fq4g77TJBDXOTeqz3WVyHZ+JAa7krS/Io0Tu7CKWK5XlNdyPwOLc2jyI1l57ImkKqz9ndnaENacDnb0aj5TrqVMufhLbKaErvNcUdS8HN2Q/aRHQe/5eSnveI7R/IvBaEiILVfoQJQIbc5QWgzPBd+F/HGLQQD9PdtEYDX4bQ18eErxoTX3bdAKM+KDrojomS3YNyIbmEm69eSLOHEg3ev0sp/CxvNwyUVTzBxXHDK321dByOHS+y22skwQwO/AAr7ojUcFl6WUKdbqH3I3+JJynuZiGmhKTF6QS9TFcCa5KNzOSBhpu2O0KCey7TyLY3ELqjFBHP2tB4cGnwEi6kWyZJJoBCxudFupOXhR+8BNgZwK/VEtyAi3usp3AblDD0GYV9pduDsH0aDyA5rN8mSmxO/fF6X8d1RPXDnHVyaUoat7uw+nk1diS8GdCsvfdGRx/bePMNUx+BUsGa0pzcX3tH/3dqWdbBZNKpHOvvkmcJL9xaKQLD8V4H
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8134.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(261102123227099003)(56012099006)(10067099003)(921020)(261021121427099003)(261022075727099003)(4143699003)(11063799006)(38070700021)(261026121527099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnpUNmRGaU8yaUlUSGV3YjMxaFNERlRVM2RZNWxtSmJ1VGhDNHcwcW9iT0p3?=
 =?utf-8?B?YXJ0cVRidThPVDhLYmE1WmlzSUxsa2hieGRKZFNlVFo2cFlnWHB0c0hrMjdE?=
 =?utf-8?B?MVFZdm9YU3VOQTlVVlJ1ZHlNSUV3eURUYzBGbzNWeW1OT2h4RXhGN3ZybjFu?=
 =?utf-8?B?clB3QzNQc210djNKak9XT2RrOWd1UDE4S3VxNDU1QVhwZGZNa2RrMEdFaGVE?=
 =?utf-8?B?dE9PZkt1OVJhMmlocmd2WUtVVG13RkhUN3l1RDgvUkNPTGFHTlpaL1FWWWt5?=
 =?utf-8?B?cFk5UkxtcW5uWG12Y3JUSklFUXExNThpUHdpa1BPa25nOW5EQnBPWHJYc0F0?=
 =?utf-8?B?bFR5cnRNVTRuSVdpQlEvZXJ2MGFZUnN3SUlQb25qZTZOTHlaYXV6UnRVMVRP?=
 =?utf-8?B?a3VCT3JES0Q4clg2NU9FSHNpbUpYRXpjbWxmdWV1ZmFVLzU0Qk5SNHNydHZa?=
 =?utf-8?B?WTVDQ2ZwSVdiWE40L0RuZ1IxQ0x3b1hXUm5CRUxPeU92bFVvYWxXNUVPeWpn?=
 =?utf-8?B?bzhMWG5nV2ZUK2tIL0YrUWhKVHRDQTRaMFlUR0xvc3gzUTM5bkpWeUh0WEZl?=
 =?utf-8?B?QTl1N3pXbVZuYkRZVGsycURGQUgvV3Nnb3R1S2h5Sjk4WEgrZUZQdm02cVN1?=
 =?utf-8?B?NHFOMjNLQnBlRVdydmdKQkthYnJSVjhqQmpUWnlESTkxdEFmdmdqK29GWWk3?=
 =?utf-8?B?d25aL0RoN3hMWTlFVmhSdDM4RitwWThidjhKbmdUamN5bjNGNy9kYzFnekJh?=
 =?utf-8?B?UWNFalk1c3ZJR0dkTTMzRzQ3V205N0lvS0ZxK1NCdXpJdkkzL0dDUUh6TWxY?=
 =?utf-8?B?aXBzWjlna2hKNGpCaGE0NTBSekVpdWpuTXhKclVoSFlUUDFCdjhZc2E2MjZO?=
 =?utf-8?B?MEJ4N2FSN1pxcGM1YTFCMkw1dmFyQTFPTVo3QjlHNjVLSXBGRklnY2ZHUTJu?=
 =?utf-8?B?SDBWaGtUSDZxZmpaYUxZcnhQTEJ4M0RQU1NzdnhlS0ZJZnhHWitzUFRVTG9n?=
 =?utf-8?B?NXRFUmRyNldRdWYvVW1MZFpIY3duQk1UR3VzUjI4NEZoeGxabHpOQkRQcWJj?=
 =?utf-8?B?cGxrT0VsSSt2NnNvK1lVc0NTdkM1dE5RNUFPcjRNSFU2VWhwaUxQcnJYeE1t?=
 =?utf-8?B?VFk2M0loc1FsK2pMV3lDajFzSlNCREZqUHRNSTZzMXlIWjFNQ1Y4SGMwWVFC?=
 =?utf-8?B?Y2Q3RUJtOFhUY09JaEF3b3h2RzN2dUdHSVI4ZzRuN3FJMzZIL0lSTkc0MFBP?=
 =?utf-8?B?MWpNSnJhdThNa1gxNExmbXhOTkdMZ05yT0JlKzh4Q1NhN0VwY1k4cS94UkpT?=
 =?utf-8?B?UHA0QTN4a2k2OGJDR09iWS9qbXhkK21mQ1dpRk9BYjYvR2JuWHpvdTFIQmlJ?=
 =?utf-8?B?RGI5d0FnZEEycXdFcEFyWTh4VDgyMytOT1FkWmtuMWNURFcwYnhuRjlwQlcw?=
 =?utf-8?B?eUw1ZVVPZHExTVhZMHdJRDRsRnNTMEplZlUyTmJ2UTgyUi8rRytJY3RYZ0hE?=
 =?utf-8?B?QllMWmNxZ0xGbkVpNDUxSVVHZzBnZWdISjB2TytRNWhYYTNsMFEyS0dSTXJi?=
 =?utf-8?B?QmF3dkVrZTN2djFyM3V5a2QwMzUvWmdCZTQwVzRzbEVLaUR4eWxKbit6WlY0?=
 =?utf-8?B?UmFERHlLUE81VWU2RXM0ZFBicGhNay9GdzRTUVNIQ09aUGpyYi9rakJNUmNJ?=
 =?utf-8?B?TnlDWVpUTXYrZ1VQYkRVUWZxYmx5ek0zQW55aTIxelVRcGJHNEZuSUFQZHdy?=
 =?utf-8?B?TUloc0FZWWRKMzBqSUJQK1FFV0xiN21oQnhBQUxPRDcwUi91WW96YVZDK0Vt?=
 =?utf-8?B?UVJKUmtFWEZsbjNYTndBNnFQS05Ha2JVSHhERU9rekwwckx6ZjdBVUYvYlMz?=
 =?utf-8?B?eW1VRTBhRTEwUzdxeEpoY0tlTzFlYXJOWHVKV0Zzd0EyZXRsNTlZcUV2WGJ1?=
 =?utf-8?B?ZXU3dlFYR1dqdm9OcnJTT1FEaGVWdjUvRisvTUhFdHo5eXRjWFRXcnBEUEkv?=
 =?utf-8?B?S0x3WHhEbkxZZjBYM3FFdUtwR0pRcW85NCtvS0pZSGxoMGF5Mnlabmg4M25p?=
 =?utf-8?B?Z1NrUTM0UWRhNXRZbFBPUGMyQXYzV1NTSFVJZWI2Smx0VktWYzVyWitWckVJ?=
 =?utf-8?B?eWdBZURaQ25YRzI2S3NsZ2IwYzQwaEZFOEo1dWpNdVNBTDhmSHFrQ1h1Nk8v?=
 =?utf-8?B?bU5yTmluN214R1k4ZFI2cndJR2FxK2phN0JjNHJmTGJ6S0dQUGJhSTE4T3Bk?=
 =?utf-8?B?czhNVC9vdVNyU29HL1FDUUdVVWo4dllKTGlsYWt2UEdQY1pIREJIaUlOYTR0?=
 =?utf-8?B?aTdBdTBuYzk0RTlRanIwVnpodndBTTdHR1psdE1vaGp6dFpHdHgyZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FsWlRkavgmkEQxitNCrTcXhsxtBC31+pOJypiLOQyQGOX2GmIIMD6lE54ivQrTZML0OSkWokUwIPpQlZUvnpW2L1Utxd7t5rJcSkEWWggVTNlw1X7nkoN/G5EvIxLcoH/AWR9E9gQg5qdgeegVj9ss5Ux9QqrEOSU2l94oXNGGDGJ0+0i9KWKwOLvJiPqLlskWtNctXRUtH6JuRA1QXExZV/w3PT2k/5yiiTVtzhfI7NlfuTtAkOvQKGJUIbS/RsjTBszThajgFOB+yQptKTiI66KlXGPAQI6iXxiGZc/09vtd5eSuzbhia2zMYnMoH8+mt6H+fdkE8qf/SKqrAuPw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 294e1d5e-f570-4004-dc9b-08df3a13e716
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 01:35:26.5544 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Iaiy8RunopXEzlXozs9dsd5t5zH61PuqOSAsq4aC3mIvSCNooyUVGhESKoNP6t5SGt0MkRRZ1Mrl89CAvxDNEA==
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
Cj5JcyBhIHNpbmdsZSBwZXJmb3JtYW5jZSBoaXQgZHVyaW5nIGJvb3QgYWxsb3dlZD8NCj5JZiBz
bywgdGhpcyBpcyBhIGJldHRlciBzb2x1dGlvbiwgYXMgaXQgaGVscHMgb24gIVBSRUVNUFRfUlQg
YXMgd2VsbDoNCj4NCj5odHRwczovL3BhdGNod29yay5mcmVlZGVza3RvcC5vcmcvc2VyaWVzLzE3
MDc1OS8NCj4NCj5UaGUgZmlyc3QgcGF0Y2ggaW4gdGhhdCBzZXJpZXMgaXMgYSBiZXR0ZXIgc29s
dXRpb24gdGhhbiB1bmNvbmRpdGlvbmFsbHkgZGlzYWJsaW5nDQo+c3RvbGVuIG1lbW9yeSwgYXMg
SSBmcm9tIHdoYXQgSSB1bmRlcnN0YW5kIHRoZSBwcm9ibGVtIG9ubHkgZXhpc3RzIHdoZW4gbWVk
aWENCj5ndCBpcyBlbmFibGVkLg0KPg0KPklmIG5vdCwgd2Ugc2hvdWxkIHByb2JhYmx5IHVuY29u
ZGl0aW9uYWxseSBkaXNhYmxlIHN0b2xlbiBmcmFtZWJ1ZmZlciBhbGwgdGhlIHRpbWUuDQo+DQo+
QnV0IHdpdGggdGhlIHNlcmllcywgd2UgcHJlc2VydmUgdGhlIGluaXRpYWwgZnJhbWVidWZmZXIg
Y29udGVudHMgYW5kIGVuc3VyZSBhDQo+c21vb3RoIGhhbmRvdmVyLCBldmVuIHdpdGhvdXQgc3Rv
bGVuLg0KDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KWW91ciBzb2x1dGlvbiBtYWtlcyBz
ZW5zZSB0byBtZS4gSXQgYWRkcmVzc2VzIHRoZSBpc3N1ZSB3aXRob3V0IGRpc2FibGluZyBzdG9s
ZW4gbWVtb3J5IGdsb2JhbGx5IGFuZCBwcm92aWRlcyBiZW5lZml0cyBiZXlvbmQgUFJFRU1QVF9S
VCBhcyB3ZWxsLiBJJ2xsIGhvbGQgb2ZmIG9uIGZ1cnRoZXIgY2hhbmdlcyBmb3Igbm93IGFuZCBm
b2xsb3cgdXAgb25jZSB0aGlzIHNlcmllcyBoYXMgYmVlbiBtZXJnZWQuDQoNCj4NCj5UaGUgd2Fy
bmluZyBpbiAyLzIgaXMgcHJvYmFibHkgZmluZS4NCj4NCj5LaW5kIHJlZ2FyZHMsDQo+fk1hYXJ0
ZW4gTGFua2hvcnN0DQo+DQo=
