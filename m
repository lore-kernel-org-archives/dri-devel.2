Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43C2EA3C5C
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 12:07:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F53810E7D9;
	Thu,  9 Apr 2026 12:07:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Oh3Zpa/f";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 257C810E7DD;
 Thu,  9 Apr 2026 12:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775736474; x=1807272474;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=IIStAt9Qqf7cz0hi70F7zkmqd95Sr53TBLy9ES757Cc=;
 b=Oh3Zpa/f9pT9uEKZOsIiO32ePXEvMxSQsCVaHmdSfuIIB10EG9lhrmET
 m1sI2jgg83Z0HutE/4VTaWqvXwOEfroSF+13r/dc475eHYBfO7c9Cl0hP
 mtEfTWJKNoCTwPhLy9FCnA5WUN6/OEJ9Zfzy+rmxEcO+rg7Uony7Toahc
 RxN5XZDkgoN6cHRP372hqsco+27F/vrP1WgFPqVYhrQTJyfjeOz0MFfDg
 y4A0zOkz6EO2nFvDuILrXY25MiE0vVuhWoaToS/C2DgMGcyzj9t8Hl/dM
 0VEjVRpE08ilOjAfkodSAIKoieo85Lz8s+VeX5nIcOBPwfltZOis6R9MJ Q==;
X-CSE-ConnectionGUID: tWCoobigRKCo6dQ/6H/XIw==
X-CSE-MsgGUID: qSBojA+1T7q3LQTrK0rg3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="87362894"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="87362894"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 05:07:53 -0700
X-CSE-ConnectionGUID: /QcYBDB7SR28cUhQi1s9Vg==
X-CSE-MsgGUID: YQ214pNfQgSzNHuDsuVMag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="266728320"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 05:07:53 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 05:07:52 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 05:07:52 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.71) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 05:07:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jY4yt96pPslXq7e/ttMJakJwH5B6p0abwQOoT2R/uNsOHFuDEXiMC2zdT/i7aTmG5hRN2Bhn5eqF1ikfC/iEEkLMGJUKDpy41DIPxEOlm3rAIEUDVTXg8HH5pb9SeFBT0ukCJcNVhz0BhURHK8lSEc50mleDIZbUMZDzxq3qmz5Lj884IXIDmxGLAAF/2HZIexSVV4IGm1luMllXREFUlVLh4kYcqw2yxD3xIgCReUkPHmS5MsDj33f2W6cF3hRh6agyeNGp7Lo9VPp4er0fbUArM+/oLdyRb+l/bI+1KkOX9JA4iLLPKfp79e4DSxQUbAv/D2aQ8oEuswf4ngg4iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIStAt9Qqf7cz0hi70F7zkmqd95Sr53TBLy9ES757Cc=;
 b=OJT/qQuiM72hliC97NNDdTnBYgFpG5cpgbu3b6YeE0T0LIhG2iOH42MDfnMSDz+Oq7nOCV80iIvyPxXSBpfMek1Xd24QzImBIQm59ARs6ouSAurUZLfpR4aV9RruS+sYC0AsTZI5pSB6x3Gy2dl2jd9IC/8cp5umgr/vh8Zpck5d3SGO/vKM2RYxNdSKpeGKp27frF6OxFiQKwfu6reJOD7+e2kRtlTVEGBXoG5fiI9XeebSbFDmzMhoTKMNlUn3jRF90DjO6jGE2QGHS0uGkhbAITmwaLUx1HyX9LfH17HxMpdLiUOK5l8oKfegERQ001JBafX9ccxXC/aILAu9zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5663.namprd11.prod.outlook.com (2603:10b6:a03:3bc::9)
 by PH7PR11MB6772.namprd11.prod.outlook.com (2603:10b6:510:1b6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 9 Apr
 2026 12:07:48 +0000
Received: from SJ0PR11MB5663.namprd11.prod.outlook.com
 ([fe80::e4cb:d003:6475:26bd]) by SJ0PR11MB5663.namprd11.prod.outlook.com
 ([fe80::e4cb:d003:6475:26bd%3]) with mapi id 15.20.9769.018; Thu, 9 Apr 2026
 12:07:48 +0000
From: "Knop, Ryszard" <ryszard.knop@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Auld, 
 Matthew" <matthew.auld@intel.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "Brost, Matthew" <matthew.brost@intel.com>, "christian.koenig@amd.com"
 <christian.koenig@amd.com>, "airlied@redhat.com" <airlied@redhat.com>
Subject: Re: drm/ttm/tests: fix lru_count ASSERT
Thread-Topic: drm/ttm/tests: fix lru_count ASSERT
Thread-Index: AQHcyBlU0w9mnPOaIkeXcVi29aACKrXWosKA
Date: Thu, 9 Apr 2026 12:07:48 +0000
Message-ID: <cd648ad183c346a8a71d84f929c1d4fe5468ad4c.camel@intel.com>
References: <20260409111032.72141-2-matthew.auld@intel.com>
In-Reply-To: <20260409111032.72141-2-matthew.auld@intel.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5663:EE_|PH7PR11MB6772:EE_
x-ms-office365-filtering-correlation-id: 35614c00-b551-4f9a-ec6d-08de96309db8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: 5LUNV7xym0zKCbjckKrEHPJO54PHUsvxdG8bLEyW9rCXeD97A6agjQYhV9YlAJR0AoT+h+fDcYe+YpzKsKLZBTkbOiMVNKnbUnlDgVipsmEhN8+Bh9rASW1/TuufwM52gkBlrHwT7G4SlBm3nnmQVcUgF0jzPHAfmgPpUI/kDEu/Z1bPYrTnJm3HtB8Utae/7DBAFLWXwHIHF2Y+LSs5v6fBdge4ktQOq8wK75ofAee+2/oxfI+UGziq5snhYdvmtEu0or3qJ7eSjVq077wQQY9DSc5vES8EPmCg+22IaHaWzfZU6JjbVPFmqU9tR0mVu8sGuvlGoXeB1obsXPTXtZHvoye4jRNR1BGk7VLFHtoNHubZsU3JZ/6ydt+bRi19BVXUyqZV55GwOu66ATNpXnNzvSF++HpY4OY2zc23hmuOCO1QnBIPcAwkgtLD5JCECQkMkDALqprwz7Qx0mKvwRcoDnK1W/ASgHKB+ceznbZvAQOxRAsO2XuG+Im23bcNvQU4fAU+LwNwwLf82FIX5k2DoCJ9QjsUOrC+NeFFX4FQyLyyteLqrziT47x7gWVIPvi7xcWq9OQOQ+nx6CMsAHQpjciDjWe+bgRC6Hoz7op5VzjbJ0pcgVLEKMx5OWFu0GvIQOpvWE0UoNlIQWsXTgeA+v3Cr8eQRrNNS6dXBnLVB0v8pyZaIbNFVZ47iS84Nq6VCnHwXE81gG0N12BmG3qWOx2A7FvNd7ZqBBmXRzGVTL4rmeW/2qHuoIxsUSqH34p9LDiLzgSStHohjRZDOfk5xSl75QSZUX+b2G77D1E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB5663.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1RqWFM0aUQwSTExUHI1U2M0VmQ2NXJ5cktUWU5Ub0M1L1ljNzJCemZ6RXkv?=
 =?utf-8?B?UGZsZ01wMThma3hGVjRYNGlVeEU1R0E0RU50c3hxdG5qTStDM01xZUxFZnoz?=
 =?utf-8?B?V213THFyaHhxUW1UNDViUE9VRmFXcmVWSW54UmxTMEl3a0Q1bTdwQzBpdWY5?=
 =?utf-8?B?eUhsRE5EOFUzNFNUNGtkY0s4TXZ2alNvSytTVnY2cGo4NlBBWG5Fd1ZRaURJ?=
 =?utf-8?B?MWRjZ1Bic0VIYXhEWjhqcDlNK0hMdkVyT0ZVbU5IL2M3RFFRaDl4dUZMN2c3?=
 =?utf-8?B?clZTR2d6ZUwyVkpGdzRBSDB4TGRrTnUvZjNCQWNjcEtCb0ltMGNEb0paSEVF?=
 =?utf-8?B?TG82RXlZc3l3QXcvbG1sMlhkUGNydmM2L0QxNTU3UzcxT2ZJOXQxOUZZUGt6?=
 =?utf-8?B?RzE3NFdiTzJuSTU2a0VJejNSS1pWNWg4blBLMnNkeGsvcnJMOGRaYjFjVy9a?=
 =?utf-8?B?UFhKK3VzaDFFK3dIbjAvTE9sSjZCT1hlaXIyaEZmb1UzczlkUjd2Q0hwdFlz?=
 =?utf-8?B?cnJHdG1iQmp0eEtYWUZjMUdydFMyRm9BdGVvYURKY0NvRStjcUJJSUFjcnZT?=
 =?utf-8?B?VU16bk1wTStmOHVvaGJVVk03bGNZeTVOdGtueXdiNWtxTWhTS0wyT3BLUU9z?=
 =?utf-8?B?SkZxUXREWDRzV3dFY1JnSktjQmRENjZ1bW9qZUk1dmZtY1pCZFliUkxjdzA0?=
 =?utf-8?B?OVZKVUJCeTNiMldYODVHb3M4d2tNV3h2YkxxUDYwYVQzamFGRHhaZlg2TzJW?=
 =?utf-8?B?OXJoeVRHSk0xZkF4SFpTVHpxZTUvdkx6ODk0K1FTTnJDcnlwdjBqVlUvVnRo?=
 =?utf-8?B?SHhpT1BGSFU3dnVtc2J6SjRQM3FFZWVZUU4xbG1RL09rL2s4NkZxcDN3OHRU?=
 =?utf-8?B?a2x4dUd3S2ZhZzgvOENOaTY2MjNVWXFHTExiSjY3WXZQSTRPZmg3TUJuK1hI?=
 =?utf-8?B?cGswOEVOMDBoejlMam51dm1Cc3NWYVZPdHAxN2g1RExpRm5qQ0Z2Q2JDbWpP?=
 =?utf-8?B?b3FuQWt1ZzdYeEY2VlRPQkZUV2RpYW52UlhDKzhFd1YrNk1laHhqVnhZTUdS?=
 =?utf-8?B?OGhXaEVHVkk5VVltblpPdnEwZ09BNEtYNlBGT1FYRllES3JFb1BYUjZBWGx1?=
 =?utf-8?B?Nk12NHdRd1RaaVg2Ylc0U3FYS1ZETHpCZkdZUmJwNjBqem1RNVB1OFZsU2dy?=
 =?utf-8?B?TlR5U0FNNC9Rd0VzeUdqMTZMWENtb2IxMlpoaW9qVnltWnJyVEwwYzRTUEl3?=
 =?utf-8?B?V3cxQ2ViaDl1UEhrdS9RZXo5SHJlRFgrQUxNRjVtcTluWHRpSXl2dXhvYUwr?=
 =?utf-8?B?aEZva3VFZ2VuZjAzb2VWMEQrQjRhK1JNTnMvQkNMKzVwSkhJQTlKazkyVk5v?=
 =?utf-8?B?SGtsVThQeGp3d3JLREtKNjJsajZ2WGJZOVNnMjc5c1VFanZzTjhlZ3JSQzhI?=
 =?utf-8?B?enQ0WUNhVTlBQkI4OFgrekZXRTVrYUU5eTZxLzlNK0pFVjIrME4xZDhuU25r?=
 =?utf-8?B?aVFraE9kckRYYXM0Q3RIRW11T0ZIZ0Vvalpubm45YlFpL2txL0hyT1lJeXl1?=
 =?utf-8?B?QndMVnMrVGZjL01kQkltZ3ZzbXpIbm4rS0Jzc3p2dEk5czlpNUhEQi81Zk9R?=
 =?utf-8?B?UDdwTG9QOFJOSUVYelR6c3lkdGlzWnhRMGUxRVFjRTgyUmxVbUxZRkg5QjNT?=
 =?utf-8?B?T1VsL2VYZUVGZmNWN0FDaWxEV09XTFZSOVc0bXIzUkV2YTZQbS9kZEdzYThr?=
 =?utf-8?B?UUdxalBSSWlIVEx3c2Y4M2hCaERaYWpKSnVUcXZMZ3JVTCtZNDIybUJQNFU1?=
 =?utf-8?B?K0lqTmxnQWJMMVZOajMwZTRyK05GYmloYmxtY003Z28wT0RVTWR2dnRKdUYy?=
 =?utf-8?B?V3hhbm1iSEdVSC8ybkdsV2pvdGd3c0FRSUt4Nm1RTW5oV3BTOFFLZnJremxq?=
 =?utf-8?B?eW95TStNRUdjS2dTN0FFclRzOVNHNDNhYnpVT2hxUWpwM1BjQUZ6T1ZEUGZY?=
 =?utf-8?B?RE45cytTRW50dXVzZnQ5OEQ0dUhmbGNrb0FuaVkyVmlvUFBRSVNONDNYRm16?=
 =?utf-8?B?ZUF3NVJDa3FDQUl4YmZ0Rkdab2RxajZEMnM0a0ZVc2tHa1ltRmxJTVN3NjZ6?=
 =?utf-8?B?c2owclFZV2V0V0FxTjRmNFlJWXgrRHhzaDBRaThhcjJjYVluTjYzRk9xSGtW?=
 =?utf-8?B?cVJXcEZTVG1uL3hTT3B1ZUNCcW50RlVObmVDYkdsRnhCLzJyVHQ2NVg1UE4v?=
 =?utf-8?B?RW1DbXoyZjJFUGpNdWlveXFWWWN1VkYrMzRRYjR4akdRVzZEakxZNDliNlYw?=
 =?utf-8?B?MFB1Q2c3LzNYRG9nOEp5TWZhSlVRdWloa01hbHRIMUlkSXh2b0hURU9BZlhF?=
 =?utf-8?Q?g5eTbw0nNbX1eFiI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B98469F5EDAA1439F5C7937B1D2363A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DJlXVVc4SkQqg69QaXbMypfqQ8wJPt1lfglfE06OdeE7rHWf2JgdDT+mFQMMVxk+tjRY9Q8EUgNoUSQG081pdsznNHCk8jYmmAYokuWFXgPrHZHLkz5AmvSNR/se2Q1TaSrc120X5PvEXpY/m573RNgTyHjf8q7EQGEQnrsCGdTrh3ad/iuZb8nuAk+xhWhwBw0DWk4irgVd19YKo4ggCHTNc++rPD0KmMz4S7KlhrsJbr2LRJQWCK14/vrFozG9YtSSq6ChLVwCOpD0KjRACSOzjzWERy9pThNceMlSnCZiivG3+wzAH0Lq3sTd6ZgfUFOSEZX0ESjd9MLiPninpQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5663.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35614c00-b551-4f9a-ec6d-08de96309db8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 12:07:48.1823 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zXrT5I5ZWK4P1lhnkm2OrzoQts9PA7go+vcubt7+5ILUZXmt11kWquRodlx7HyWg98KOjgb8TT3Y9wDiP0BR7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6772
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

TEdUTSwgdmVyaWZpZWQgbG9jYWxseSB0aGlzIGZpeGVzIDIgS1VuaXQgZXJyb3JzLiBBIGZldyBt
aXNzaW5nDQpleHBlY3RlZCBzdWJ0ZXN0cyBzdGlsbCByZW1haW4gdGhvdWdoLg0KDQpSZXZpZXdl
ZC1ieTogUnlzemFyZCBLbm9wIDxyeXN6YXJkLmtub3BAaW50ZWwuY29tPg0KDQpPbiBUaHUsIDIw
MjYtMDQtMDkgYXQgMTI6MTAgKzAxMDAsIE1hdHRoZXcgQXVsZCB3cm90ZToNCj4gT24gcG9vbCBp
bml0IHdlIHNob3VsZCBleHBlY3QgdGhlIGxydV9jb3VudCBmb3IgZWFjaCBub2RlIHRvIGJlIHpl
cm9lZA0KPiBhcyBwZXIgX19saXN0X2xydV9pbml0IC0+IGluaXRfb25lX2xydSwgYnV0IGhlcmUg
d2UgYXJlIGFzc2VydGluZyB0aGUNCj4gb3Bwb3NpdGUuDQo+IA0KPiBDdXJyZW50bHkgb3VyIENJ
IGlzIGJsb3dpbmcgdXAgd2l0aDoNCj4gDQo+IDEwOjIzOjMzXSAjIHR0bV9kZXZpY2VfaW5pdF9w
b29sczogQVNTRVJUSU9OIEZBSUxFRCBhdCBkcml2ZXJzL2dwdS9kcm0vdHRtL3Rlc3RzL3R0bV9k
ZXZpY2VfdGVzdC5jOjE3OA0KPiBbMTA6MjM6MzNdIEV4cGVjdGVkICFsaXN0X2xydV9jb3VudCgm
cHQucGFnZXMpIHRvIGJlIGZhbHNlLCBidXQgaXMgdHJ1ZQ0KPiBbMTA6MjM6MzNdIFtGQUlMRURd
IERNQSBhbGxvY2F0aW9ucywgRE1BMzIgcmVxdWlyZWQNCj4gWzEwOjIzOjMzXSBbUEFTU0VEXSBO
byBETUEgYWxsb2NhdGlvbnMsIERNQTMyIHJlcXVpcmVkDQo+IFsxMDoyMzozM10gICAgICMgdHRt
X2RldmljZV9pbml0X3Bvb2xzOiBBU1NFUlRJT04gRkFJTEVEIGF0IGRyaXZlcnMvZ3B1L2RybS90
dG0vdGVzdHMvdHRtX2RldmljZV90ZXN0LmM6MTc4DQo+IFsxMDoyMzozM10gICAgIEV4cGVjdGVk
ICFsaXN0X2xydV9jb3VudCgmcHQucGFnZXMpIHRvIGJlIGZhbHNlLCBidXQgaXMgdHJ1ZQ0KPiAN
Cj4gRml4ZXM6IDQ0NGUyYTE5ZDdmZCAoInR0bS9wb29sOiBwb3J0IHRvIGxpc3RfbHJ1LiAodjIp
IikNCj4gU2lnbmVkLW9mZi1ieTogTWF0dGhldyBBdWxkIDxtYXR0aGV3LmF1bGRAaW50ZWwuY29t
Pg0KPiBDYzogTWF0dGhldyBCcm9zdCA8bWF0dGhldy5icm9zdEBpbnRlbC5jb20+DQo+IENjOiBD
aHJpc3RpYW4gS29lbmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+IENjOiBEYXZlIEFp
cmxpZSA8YWlybGllZEByZWRoYXQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS90dG0v
dGVzdHMvdHRtX2RldmljZV90ZXN0LmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vdHRtL3Rlc3RzL3R0bV9kZXZpY2VfdGVzdC5jIGIvZHJpdmVycy9ncHUvZHJtL3R0bS90ZXN0
cy90dG1fZGV2aWNlX3Rlc3QuYw0KPiBpbmRleCBkYjRiNGEwOWE3M2YuLjhiY2FjODRlOTg0NiAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3R0bS90ZXN0cy90dG1fZGV2aWNlX3Rlc3Qu
Yw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3Rlc3RzL3R0bV9kZXZpY2VfdGVzdC5jDQo+
IEBAIC0xNzYsNyArMTc2LDcgQEAgc3RhdGljIHZvaWQgdHRtX2RldmljZV9pbml0X3Bvb2xzKHN0
cnVjdCBrdW5pdCAqdGVzdCkNCj4gIA0KPiAgCQkJCWlmICh0dG1fcG9vbF91c2VzX2RtYV9hbGxv
Yyhwb29sKSkNCj4gIAkJCQkJS1VOSVRfQVNTRVJUX0ZBTFNFKHRlc3QsDQo+IC0JCQkJCQkJICAg
IWxpc3RfbHJ1X2NvdW50KCZwdC5wYWdlcykpOw0KPiArCQkJCQkJCSAgIGxpc3RfbHJ1X2NvdW50
KCZwdC5wYWdlcykpOw0KPiAgCQkJfQ0KPiAgCQl9DQo+ICAJfQ0K
