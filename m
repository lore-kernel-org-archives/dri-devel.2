Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5705CD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 00:23:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 033EE10E075;
	Tue, 19 May 2026 00:23:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HrG4of6V";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73FAD10E075
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 00:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779150196; x=1810686196;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=VDiVDW/2zCHZCAN5O0j9GfghRNKoNcTL9wSIWE/2x0U=;
 b=HrG4of6VF8ffw4d8DgnFnZI1Qc/h12oC1jW6qlbwVGbAFJHqs5KGuQYr
 ByioV6CR7uGWBvrGewUneIOHWFVzSpgbzl97/eDngimD8sRoVNuFPnORW
 3NsAeR9+y3D+/O6wvI2x1R9hDoS4kUdEuftBoUkpmj+znP8BAFBwDIBJv
 4Xw/sU2bT3yJf36kLLt2G/HYV3I9clEZnBAtcw+ufYShf78VbTsImX/+t
 +VyJ3/oxWZHei+WTXivFuovFmucGg+LHws3QJeOZH3rJYedqVZ5yILt78
 m+XRBpmGZ5xBLOnNM+wRzfrpZxVbc2SGfI8kPlo5fEdy2xLX2Do1dgoxI g==;
X-CSE-ConnectionGUID: 0FujMkQQSd2iH0Cb4bXy7w==
X-CSE-MsgGUID: CuAoacAJQMarFvSFJL5XhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="97585648"
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; d="scan'208";a="97585648"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 17:23:16 -0700
X-CSE-ConnectionGUID: qWSPY2iWQ8uyf4f6cHRlBg==
X-CSE-MsgGUID: FVpC9ZmESOeCjW+8wR+QBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; d="scan'208";a="238763475"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 17:23:16 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 17:23:15 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 18 May 2026 17:23:15 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.13) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 17:23:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IPedL3RhT8E4xDx22LSHDG+mJ6x693f00lviWmwFwy7YoDsS7sO3T5Hz2S9j/LGADZe95L7VneRhvw1/y3f2LT9I3BHRyrBGuLK42mRkWVnvkm/BnNHY3qMpVEjbKvR77DAlIXBrtSgsChpwbCtPkuaCP9wnbFJQrY+NBFkB9jgB27do6gYtFhbJqCk4RwipnsZPuOYbsCTPmDaiOmyzeUF7+ExxDwfzSha74/jzYXr6rlKNp5S48T5abcA9FIM5CzZeQ1xc/70iP6s1ozT3TVvGRL3VaQkNBH4K2sviWt+fhKm+EySN5CLFNDPJ7WcIMeBZXsdUsudPm98DH+3qNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDiVDW/2zCHZCAN5O0j9GfghRNKoNcTL9wSIWE/2x0U=;
 b=odaWrxKeDOZC2oQvgnFfSdsTxn3AGJDIEX9o+7cZuxVkgH02HzfEqyk0MfMnfa88L9cfuuPFcJR6XOJJu8XM84akdKJ1tJQh1yHRCJYD56tOpSycZCNVaD9uF17rZ7Eg1M6MeronDh0oMjxQpI0XAZgU9ZETgnZS6YeL+bR+eaRbzH+7a45o12/vhO/DA8RWGQgql9Y1Q3WSHvFsAAVezzYHw9c/g/nf4d8ji39LAXd2LFKZ8D+GRRaURuCoFSSmxWVvvqstS7egU94hxzu98QIKXeABNTD+ohojn0+NIU6N+Bp1n0DuJm8ESnm6o8k9T4m/+84o6eOTIYAhj6mmNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5112.namprd11.prod.outlook.com (2603:10b6:510:3b::18)
 by PH7PR11MB6907.namprd11.prod.outlook.com (2603:10b6:510:203::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 19 May
 2026 00:23:10 +0000
Received: from PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::4307:5ef8:b6f9:44c5]) by PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::4307:5ef8:b6f9:44c5%6]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 00:23:10 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "airlied@redhat.com" <airlied@redhat.com>, "kraxel@redhat.com"
 <kraxel@redhat.com>
Subject: RE: [PATCH v8 2/3] drm/virtio: Add support for saving and restoring
 virtio_gpu_objects
Thread-Topic: [PATCH v8 2/3] drm/virtio: Add support for saving and restoring
 virtio_gpu_objects
Thread-Index: AQHc5ib5WXECW3MZUkCvzhm+J7MqIbYUfjSw
Date: Tue, 19 May 2026 00:23:10 +0000
Message-ID: <PH0PR11MB5112A54866C6888080137302FA002@PH0PR11MB5112.namprd11.prod.outlook.com>
References: <20260429204729.993669-1-dongwon.kim@intel.com>
 <20260429204729.993669-3-dongwon.kim@intel.com>
 <4ec04daf-9665-4b15-9e62-b83eb9aaa7c9@collabora.com>
In-Reply-To: <4ec04daf-9665-4b15-9e62-b83eb9aaa7c9@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5112:EE_|PH7PR11MB6907:EE_
x-ms-office365-filtering-correlation-id: 519e84c0-6770-4c2a-54cb-08deb53ccebf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|38070700021|22082099003|56012099003|11063799003|4143699003;
x-microsoft-antispam-message-info: qfB4cG0RLvOB1uAxE2JZQDsuKZrhQvj2Byd1qzAYyhfSxgidAAdCqtoN7vHRanEMoxdDS8JikbETIqLvRO3hbvzup0S//Et/A6UcAEO7V4pC8oRu1jSOOzVja/wL2H1U1e7q8PghqqyV1ydIRzFjQnrlrdnYwrtHKTPpKl93B5Z812p7tBqv6PA5GrIhL/gqYOoJSYQ6sZNDuXgDajOLo85q05jbf619qEana2eXVAJj4+dsXmpcPpREp3xX2KvszSxTQVpIbXCNByhodN85CgTq/nwR5nUR2adGjlroGFSM4CZJla8fD4UKfotbnLzDY8d0mRzBOm7UQZJtTBS58gHrMfoWS+CHh3tI7PM3aB5uBCxfLPca+hqqa2hZrRsFG84WswQedsbWBx0DaxRj7FJyQCQBvxLazX/aVUJteMDCnE4gSVJKxZqNeAJ7TTMfPe7OFXD7WWmSdj4uGUp+AzUnuZwYid3OwjiQRdtwz3T+xVCJb2Wnf4nty7Y4ILI/NAya0GPmpkLWoro1h4Q92oU1YE0u0xmq7mDd09OXXpeIx49bKqtqI2OdvjjvvuM68ETFWvMImtFavl8uWTROsPaSLKBVo9AnrMjd3aS4wXTGtXHuI4Bglh6LsHbtkbPVWKT6b9wcH4HyCSO6ATi3B2Qu2eWvpTGh3XzKP+wz6jyPXL+94oRWH9JFMVrqQlTKqP7kxyLIdDIJ/HZoah16TKFY+TvnH+qQKWyH+MdbPvojkmDuwAfieLcRT0xWfOhq
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5112.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(38070700021)(22082099003)(56012099003)(11063799003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXljTU5sV1pxRitob2FmWjFSdzRJT082OWNaNXc5bE9oRXZSeXFSZzBEeVpU?=
 =?utf-8?B?NmQrKzdiRmhNVWN4OTlzRWFWVlZ6M3ptZG52K2NqSXY3b3Z3SEhlUEhra0VL?=
 =?utf-8?B?R2ZtcW5ONmZUakFiTkZoSG9CUE81dGltK29HYklsaXFOcHBKeWlxanlHeVR2?=
 =?utf-8?B?OHBkbW1IU1hIR0poN0VjTlJ5bVhCMmZHL3RUZjBMclR4VENueml0WjVYT2pM?=
 =?utf-8?B?UlgxZGRBR2lYWUViVWZDdWtBMnRVSDVzYitlVGVLQXlpMVhRSjV2eEtiYkVL?=
 =?utf-8?B?WHprSVRyRjNWaVFtQmVXZWFsUmNDKzNmZElVdmJ0VjFRdzdVSkJLQXgrSkc3?=
 =?utf-8?B?S1F0c1N5eXBNU050ZTlRSndTK3plVW9kZlNLUTRnMFJCK2JrbmZoMnROTlZl?=
 =?utf-8?B?V2ZOeER6c1Z4VTljeWZCWmtCZlZlV2Y4cHAxSFVidjZEYThHMVl2QVVWMXdM?=
 =?utf-8?B?c3ZzY0N3L3dIdFhSUktYdnkya2pTR0JwZElEOWh1bWQ3UDE1MGZWN1RJaXhV?=
 =?utf-8?B?NXh2Z3NJSTRpWlNaeC9ENEZZd2tFczFDVzZ4MlY3eGxnRTZUcEVJVlpOcDQw?=
 =?utf-8?B?Y3ZJNVBUYTVGMjczcEl3WmdGcW1JY2lVajMwNW54aDIxTE5EY0l5NVVKYTNk?=
 =?utf-8?B?dFlFWFBFWkV5bndHaXo0VDZsWWN1RU5QSEtYWWc0dTI5QTF2Ri9BMzRPcXc4?=
 =?utf-8?B?aHRlbC9KcU9rUW9yZ1lKSldzTWlEelVtcTY5UFdYUFM0bThxck5KWnk0R1dw?=
 =?utf-8?B?YlA3NnhXZnlvejJOcUFTS01kYVlNWHlvdlR5bFRWdWkxQ0RDc1RSelMrRFNh?=
 =?utf-8?B?bkRpSzNSdUZwTHU4SXdMU3dwSXBITGxxU2FjMWZtdjZObGdFUFIwWW9RbHpX?=
 =?utf-8?B?cHdjaEJGYTM4cFY2ZThLdW9lMng0aE5KY3U0ZVlVTU5xZDVjanZ0elR6cE5R?=
 =?utf-8?B?eWJjeHdLdUZMYWx0RmE0bndWU2ptUmg5aFpabVc0M1dVMUJJYk9uVDZQcTlY?=
 =?utf-8?B?WE1xaWJQNEZVN21zU2hrUXFkMGVLa0Nobng1M1M1MXFHem9qUDZHdU0xR1NK?=
 =?utf-8?B?YjNRRmxZUUlsNmo0UkhxZ3Z1UUV3TXlyVHlrQTc3V3F4cE5uWG9iYmZIR3lU?=
 =?utf-8?B?K3NYdEJjSVVHYjZlYXVZNWVqVTNWUU5NZlNESnExNm5mMUR4Mk1OQUZpNGZp?=
 =?utf-8?B?UndaNG1VUlVMZ21XbHg4VmVFUndiM3oxQmtrMU93S0lGSWpwSXNlaS95ZXVm?=
 =?utf-8?B?dUQ5eVRCSVcrU3pvOTYyS2oxQXQ0SUxlVTBRbzZWWlk1TWR1S05oazlYdWsv?=
 =?utf-8?B?cHlEZ2V4emFCSzkrME9wZCt4VVVXZ0txcHFsdzFkRllqZ0E3ZmpnL1o1K3hj?=
 =?utf-8?B?RDFzWS82eGhUU1Q2TUo2dmtjdCtNdHdGc2kxTS9UdzJuaFdnVE1mQUdUcHc2?=
 =?utf-8?B?NDNrTlZkbWxaWjNTQzlMMjd4SWthakUxUE9IVmd1UkRHRkc3N2NOUEVBTG80?=
 =?utf-8?B?T2g0aG1HejdVTXhuaEZLK3pKQVlJTmFheGVVUmZqYWxhR3dwM2lJS0JZclFD?=
 =?utf-8?B?V2ZLZEFDUy9FdzlmS09vNWNCVm0zNmg4SWdiTmFieTZ3ZFQ1M1ZVSmRrOWVI?=
 =?utf-8?B?OGZKdDcyekU4Z1NrUEcxUGRpZFJTcFozY21pYWx2MUJicjBScklqbXFtZTc1?=
 =?utf-8?B?NTd4VWl6NTRiYUkzZ24vOU1ka2FPQkFJMDlPWFd5amJRNnArOU1EWTBQSyty?=
 =?utf-8?B?Y3EvNWppeXRoNnJ0WnE4aml2T0Y2WUxiU3BMUzFCZzNzNFI2dkFLWm9VeU1v?=
 =?utf-8?B?a3RHUkJlcmVicGdCeDRkTFVtR3BLdFNUWE10bFpKaW5YZlRidC90Z2p1a2tZ?=
 =?utf-8?B?QUNiMjB4TVJIaTVOUm9CT1pUN0RaWVpOM3Jzc2NJMHV5QU5qMDFoSlVxUi9U?=
 =?utf-8?B?WlZKOCtYMnhVUDhnQ1F5dFB2MkNCL1JEL3RRREROSThLSTFZOFhSczFOMHIr?=
 =?utf-8?B?ZHRodlJRdUQza2VhaTcxdUo5aW9iZS8rLytTSmxqWFFBdFZuUGlXYUhQMHBx?=
 =?utf-8?B?OEFwZkx6eWRTSnp1RlpRUm56dXlXcmN2eG5XUlJMaHBsZlR3UnEya0J0elpB?=
 =?utf-8?B?MkFkcjczeitOZmdTUEUxeVNLbVRORXNkb1B2RktyZS8vMVh5aXJ3dlVwTTUy?=
 =?utf-8?B?dHdFMTBacmZuRXB2S21EZkhOaXpDNjFSM1p2T0NHSG9BSEYzVTczTzd0SnFu?=
 =?utf-8?B?OHY2enJycmtrZ1I2V0REMEF5dCtrVVFWblVEcTFkNWJYZWxzSkpKYzdRR0V2?=
 =?utf-8?B?TThKQTBpcW1TNVZvcU5wQVVrVGpPNlB1eURoZE1KNzM4ZHVGQ09mZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XmaJYs+SkL6X5zLzz+RCmBfVBVWFgxUQf0Hcsn+3J+pc3HW10CJJvfHo9SZyzKrcTqa3l3+zJHUan3lE6FneWKsk/J0t2y5ZjVQRFb7vmWnZgVdmbGi2zVpKBoNTmDjpEuECeprWwq6MSj90k2ALrotl0VZVZ5pPWn0MWb98Fq9aybS9JXxLCv2zh+OLkbCDatl1jdv2IqF165ABq9ashKFpvX/nhT/QENutz+f61/wrkIVNehjvAIa2HHSMLd7inSVB4GoPde1/e++dULZ6kICq4kls61UOehrXi2FmzV0QySAHFP1VOHFpOecfzkX5XnNXSVqqcmsRN4QtwhG8RA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5112.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 519e84c0-6770-4c2a-54cb-08deb53ccebf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 00:23:10.3956 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pOHKDFNYZkGgP+rzCkykd0GOIZv6FlanvE0p1szTrkJEHw19STJoq17wPaZ8Yw6ZtzPKRVFKV9WsuS9vXwIQGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6907
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

SGkgRG1pdHJ5LA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjggMi8zXSBkcm0vdmlydGlvOiBB
ZGQgc3VwcG9ydCBmb3Igc2F2aW5nIGFuZCByZXN0b3JpbmcNCj4gdmlydGlvX2dwdV9vYmplY3Rz
DQo+IA0KPiAyOS4wNC4yMDI2IDIzOjQ3LCBkb25nd29uLmtpbUBpbnRlbC5jb20g0L/QuNGI0LXR
gjoNCj4gPiAgdm9pZCB2aXJ0aW9fZ3B1X2NsZWFudXBfb2JqZWN0KHN0cnVjdCB2aXJ0aW9fZ3B1
X29iamVjdCAqYm8pICB7DQo+ID4gIAlzdHJ1Y3QgdmlydGlvX2dwdV9kZXZpY2UgKnZnZGV2ID0g
Ym8tPmJhc2UuYmFzZS5kZXYtPmRldl9wcml2YXRlOw0KPiBAQA0KPiA+IC05NCw2ICsxMDMsNyBA
QCBzdGF0aWMgdm9pZCB2aXJ0aW9fZ3B1X2ZyZWVfb2JqZWN0KHN0cnVjdCBkcm1fZ2VtX29iamVj
dA0KPiAqb2JqKQ0KPiA+ICAJc3RydWN0IHZpcnRpb19ncHVfZGV2aWNlICp2Z2RldiA9IGJvLT5i
YXNlLmJhc2UuZGV2LT5kZXZfcHJpdmF0ZTsNCj4gPg0KPiA+ICAJaWYgKGJvLT5jcmVhdGVkKSB7
DQo+ID4gKwkJdmlydGlvX2dwdV9yZW1vdmVfZnJvbV9yZXN0b3JlX2xpc3QoYm8pOw0KPiA+ICAJ
CXZpcnRpb19ncHVfY21kX3VucmVmX3Jlc291cmNlKHZnZGV2LCBibyk7DQo+IA0KPiBDYW4gdmly
dGlvX2dwdV9yZW1vdmVfZnJvbV9yZXN0b3JlX2xpc3QoKSBiZSBtb3ZlZCB0bw0KPiB2aXJ0aW9f
Z3B1X2NtZF91bnJlZl9yZXNvdXJjZSgpPw0KDQpZZXMsIHRlY2huaWNhbGx5IGl0IGNhbiBiZSBk
b25lIGFuZCB3ZSBjYW4gcmVtb3ZlIHNvbWUgcmVkdW5kYW5jeSBidXQNCmRvbid0IHlvdSB0aGlu
ayBhZGRpbmcgaXQgb3IgcmVtb3ZpbmcgaXQgZnJvbSB0aGUgbGlzdCB3b3VsZCBiZSBiZXR0ZXIg
dG8gYmUNCmhhbmRsZWQgb3V0c2lkZSBvZiB2cSBmdW5jdGlvbnMgKHZpcnRncHVfdnEuYykgd2hl
cmUgYWN0dWFsIGNvbW11bmljYXRpb24NCm1lc3NhZ2VzIGFyZSBwcm9jZXNzZWQ/DQogDQpUaGFu
a3MsDQpEVw0KDQo+IA0KPiAtLQ0KPiBCZXN0IHJlZ2FyZHMsDQo+IERtaXRyeQ0K
