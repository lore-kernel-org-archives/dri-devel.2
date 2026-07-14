Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F985C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 06:34:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 035A910E2A8;
	Tue, 14 Jul 2026 06:34:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="VfhChgXk";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04F7D10E2A8
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 06:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784010847; x=1815546847;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ejh7e5NKodgIHEwjdlV8BJy88NYt8sK7Y7U5aNODaXY=;
 b=VfhChgXkVt74oT0oRbvcF0nB724lUNi3EGIno5U2tnS7FNEvH+nbOc+j
 uqEwoR/Zlgd8otXx1KUKAaVQBi5x3SBUUM6dBSSLisPHn0Jbb2BgQQ6L0
 okuXdOfhhm0cjrvdBaQrwqNI96ec0GrYeEaxYo72hVOuL/uj3cFZSDJuR
 /UIyFgSd+Rk1jdysxVeOjVaeszwwQhWY4ZhzAcXpPXxNG3SYn3v5px4k5
 yR3UavGQFZQoBdwOXniZOWARMetq2lQlp0K+0lpetRDNgO9RR4OL7kiuF
 WvlUJ519l/JaKNiM4z/sK8LC+CmfNLJn/1xMli/sb59p0YROHXCQ8ux0n Q==;
X-CSE-ConnectionGUID: oD+tNI4qTPOb4w/yiFtCKQ==
X-CSE-MsgGUID: XgKpKgAoTyOfOKk59ncr4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="94978830"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; d="scan'208";a="94978830"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2026 23:33:53 -0700
X-CSE-ConnectionGUID: Kdf8knMWT9udwJhuKFrvkg==
X-CSE-MsgGUID: ZAL2cmA6TRSQSXIeHFDbLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; d="scan'208";a="279030128"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2026 23:33:53 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 23:33:52 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 13 Jul 2026 23:33:52 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.59)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 23:33:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZFU22zBRL5qQimlGbqAf42zFbgZS1XsS0K5K7pHn5kG1A2xJB8sSyHrnrGqIk4FBx6rjwRUV3s/AWyx95Vf/3TVWFz7afEt3ljt/yodBDkgQy5oEijKVJ9ofeOnl9tgwpvU+7S+4YRHVbKucAPRQsRLAacgt1cKLrM7o86SStlmKHYSWo9tIsx/nvg6RAu5gP4j0KfeWzdNESUU0mGA5Nk++dd+kAZiEGlGqgW6Z52ZQkR/T5mwOpvUlK2Rz9LXInDEBXuNsjO/LqSfmE/t5bJiAUCTl/bNq5kLE3csUTMPShJutma1q0B1J7WtgMHvLfh2lHnlj9kRrx+acONnqaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejh7e5NKodgIHEwjdlV8BJy88NYt8sK7Y7U5aNODaXY=;
 b=H1L1DBqIVHn3mixzSaUC9a7h4Q2T7gmlCQZYXApTflommkTQ+/hgfcCjhv1lT/wIfsvGinOsEqUu99buWC4lXu/lanHgVRKc2oXMc3PCfQRsblZ8SzYlqYpbeAcD+S9Fl/5CB22L9kGn3B4NwF/7WXF5KYmxs6pwuaeSiPdzXXpSE/SYCtnwm8KmWLG7j9I001OFvl1WmYlmJNpDz2pbwhzD8+g03Kq6uIAL2402r+roA18NVokgNvyZYbBLTyQ4G/hrcY1BECoF8oT8NZi/MKWC13eNMMCYWZ9WiY3xbpVQvGTpVS5ZFpSANaNpvothN6kG4Um5Msu/qxIDlDT3Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by CH3PR11MB7180.namprd11.prod.outlook.com (2603:10b6:610:148::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Tue, 14 Jul
 2026 06:33:44 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%6]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 06:33:43 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Robert Mader <robert.mader@collabora.com>, Mikhail Gavrilov
 <mikhail.v.gavrilov@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, "Sumit
 Semwal" <sumit.semwal@linaro.org>, =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?=
 <christian.koenig@amd.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: RE: [PATCH v1] udmabuf: Ensure to perform cache synchronisation in
 begin_cpu_udmabuf()
Thread-Topic: [PATCH v1] udmabuf: Ensure to perform cache synchronisation in
 begin_cpu_udmabuf()
Thread-Index: AQHdBiPkMKsKSbqE3kGKFxz4AuYPGrZSPxQAgAMg2QCAAA5PgIAAAo4AgAZHdACABVWQsIAKJk2AgADWOuA=
Date: Tue, 14 Jul 2026 06:33:43 +0000
Message-ID: <IA0PR11MB7185115DA785B3B51C521275F8F92@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20260627105725.9083-1-robert.mader@collabora.com>
 <CABXGCsPHdi3=Tpg2uZhZMuLNmg8r9Bg=OgD39eyMc=pv8gc_TQ@mail.gmail.com>
 <bc41095d-8956-4c3e-8f99-f4bda41f81e7@collabora.com>
 <CABXGCsNYEhkprpTh9Pd8Y46520fwNJngS_Bg_QJCQPCf3_qv0g@mail.gmail.com>
 <0a444d8c-6107-4577-bed3-0039333a5244@collabora.com>
 <9fa5e38c-0200-4724-b5db-739ea67c1181@collabora.com>
 <IA0PR11MB71853CC1CC0D0C778DAC154BF8F02@IA0PR11MB7185.namprd11.prod.outlook.com>
 <c5d207ea-6995-4cac-9286-b02e067384a0@collabora.com>
In-Reply-To: <c5d207ea-6995-4cac-9286-b02e067384a0@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|CH3PR11MB7180:EE_
x-ms-office365-filtering-correlation-id: 22a799b3-008e-4ebf-2be4-08dee171da15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|38070700021|56012099006|4143699003|5023799004|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: Dx2Nc7OWxPuxf6nQz+M4gkpsDDot0gwHFoSd0f0xGZ8XmdmU3YUHZnXo4/ZEvuwGuO34QGXnY87rcPIrEKFG4wBZR5KNw9wtv3vfrseEb77Xjnf6hr4RyZC9rOpiGHb3yfzmD6Vlzu+o4lxqqYX9Eb26kJALCE8QFGc3SpyW7tLJbnm02S7j4sxJrgO9gBBTPlpUattXSa43bdUj7sPn8ilyL8TunOhuPCkXBtIApZYhXv08JpYVPpGLFKz/07+OsZ96GmO12vZmlXT2QJL1Yv6NZ+ev3xnb8yU1i20NEsExDOto7qr+NDmsB7v/t0ieP/kCjZSrBO8e9jf5zkrgONBM6of7uaTwwJlHLyAlFKqDjhxCpWFP4HA4KrTBXPpwv3ZIgJQD3tq1A4RNxrMtcjyKQwYNS48RpQ9LylCa+/5FfLBcgi77sOl0W07r+CscVjVCNu4mIkObAqHJsBZCJBVi8AfU5dD60goRta0A8fTSm9PltCuYGCEHf8mrP2QmR1ObbLEokw1I8Y78jNccjEfm6nWkrVXXxWJSQPTjtE+Yo2qs+0mYw/sosbn6rxatCEP37kAL30mU3M2kvTnQ816hyjT+hH6ES+5EIhYkBMdFZRL29ob+mI6VV9Bpru0Opqkx7YrZzThyOXbQzQtWBi+Tn6PeLibeM4hkillUJfQqN3+eKKfnyQDubO9UYdczQz3e6iFyUDuPsfIanFGXx+8kyvYKdTBzKgMHp9xmuDo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(38070700021)(56012099006)(4143699003)(5023799004)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGxLTmo3Mk1UMys4dHZaWjJzMGRjaytONFNqbXBLdnMxU0hvdno0WG4xRFRr?=
 =?utf-8?B?d3B0QWlzb1U2NXQzVTc4S2trd2crMzNUcHVMYlpGRzJEeGc1L1k2a3AvQXcr?=
 =?utf-8?B?cE1YVUhrMGcxZ1ZhZithZ0w1OXEweE5wZTg0MWhEeU45VjR1SE91anVEelF3?=
 =?utf-8?B?eCtjQjB6b0tKSnJOZFFBWXVITmFTY1RQNTVaV3B5MHo1dHh6MzV4cDdFY2s5?=
 =?utf-8?B?L3JpdHlVTkRiQ3NLaUs1ai8wcm1YcVc4dGtYUWNsVEVnRVZJTFZHVGdGUTMr?=
 =?utf-8?B?U1o5SjlXU2xJTnltZERhUDY0M1AxT0RBcjlZYi9LNmVkVlU1U0xFZ1ZJMmRB?=
 =?utf-8?B?L1YvUFBuOHZsdnFidGZZQzZ5d05mSFZZT0tydzVPaFpuS2VGYlVIbWlDWHdp?=
 =?utf-8?B?azB3eU9aUUNHcTJQSlo0SktKZnVHdDFxd0ZMZGxyRmlWdXdBbzdacWg4V1pI?=
 =?utf-8?B?VzR1WThhYk93ekRZTUlzbVhzZWRhWUNZWXNYNnIwQ0RRYk1Mbmx0UjFoZ203?=
 =?utf-8?B?bHM3eVY1SmY4SGkvK1N1Mko2SHdkZ0QvWVhBYXlacEN5RWFrUk8yZkM4VFJV?=
 =?utf-8?B?NENUekQwK0pDOHVrMGk3bTV5KzZ4a0N1RlduRlNha2NxSmYzcE11VWEvMlp4?=
 =?utf-8?B?cHdKZk56aUo4ak81VlRYVTRPVnE4a0dJWVJJMWV4MHpZOE11amtTSG1kRWV4?=
 =?utf-8?B?Yko3VlVwU2w0QnVoeUtuWFg5QVluQ3E5SENhcTBMSzhDQVNkMDczRGtjcHBU?=
 =?utf-8?B?STFZU2I5R25uSzQrUlpqdzdlLzZVT3YyU1RVaFE3K2lFRGN6NUpLU21qOGNz?=
 =?utf-8?B?dVBxS29rUUc5MWx2aGJTMmNrZzg5YlJFaDlzYW9BM2tmTGRzY3BRNUF4bHRC?=
 =?utf-8?B?Q3JqNkw0SVZhNjhNN3BXdkYvbEphc24weUljN1pNYTNwRkxsSko1YUxvcisz?=
 =?utf-8?B?SXBHak0vcmFNNlI2MzM1bWx0TTNQYUYrTXNMYVRGSERHL0VUcW90eWVGTHd6?=
 =?utf-8?B?ZzcweGphZkdlUzVXY0VFNUp2MlFSVWRucVE4YktTUTNRa2dVUjJtYVFXS25v?=
 =?utf-8?B?cXViT2hkWE1tUDF2NjBhbDJMWXl2NnJkVWI1T1JNcW9VcmZvSmVwR24yMGtT?=
 =?utf-8?B?OXh0eXg3S09SK2pMbC9haEdaZzZLeWtxbW9KOFFQZHRJaWVkMlJ2VENsVXpu?=
 =?utf-8?B?NHRxMzVlT0FyWndYSnBOVkMxUFlEQWE4Q1V6SlVCY0E0czBmVUtxTTVha2xD?=
 =?utf-8?B?U3ZVZ2RWb0xKNkFaN0IrMUh1cGhFTHZkb1daTlcvTEVPQVpVMEpZdU1HdEZG?=
 =?utf-8?B?ak9TSFc3MGtwdUt4bll3NElCNkVyR2JqczFYZ0VlK2Q3NzFYaVhBVDVsVEta?=
 =?utf-8?B?NlQxU0JXTm9qbFYxK0JzTWozZStDb2haeVRzUTZuUytYMWxBNFNEeFRwVGVX?=
 =?utf-8?B?SGNIN3lYblAzdW80M2tMRFl0ZUthckl4UjdKczlaeU04dDRBRTU1TkVCRlRE?=
 =?utf-8?B?dTloRlpuOUg3NC9ab2R5RkJpY25jNjJUZXFGekZDV2w5RzF2TVVHeHpmdS9q?=
 =?utf-8?B?WjNLYVdoejVZR2lFMTJUNVl4cVc1ZUlDR2lkbkFYN2xSbnlReWd5VnZsWlM2?=
 =?utf-8?B?akJ3d1IwWlk1MXQwK09wUzEvTWVNRi9wOGlQZTZkRElyOUlmMjZQME9CaUZE?=
 =?utf-8?B?dUkyVVhFSENBY21NVWord0psSmh4WHk3OUM0RXlXMjh4MzF3UmhaSjZXbEpm?=
 =?utf-8?B?czR0bWdtbDNjK213cVhGcDMzSTRLN21iUW40UTFaR0JNdnBCMTJsOGFlMG50?=
 =?utf-8?B?ZGZiM0VqZUN1cTN4UHZHWnk2d2xOaDRodHZMbjNVQ2hIOUo3RFllUytzNUpV?=
 =?utf-8?B?cGVjY1R4Rmk2Zk1BcFFSYVN3Q2dpVSs3WWZaU2lmalpJclRMMlZjYjNlMWZ6?=
 =?utf-8?B?NnVyMzhsQmE4dGZhaFd3VWRvaVBPT05XQ3VsVXJBTW5zYWdmTUxPV2lqNWx1?=
 =?utf-8?B?NzNncVFMTXUwZVpPY2YxbFJrMnlJVFRaQysya29TeGFkTGxRdUFLcVprWG1Z?=
 =?utf-8?B?M2JVeXAwa3lFK0szTDVLWlFlWk1wdEVZS2ViakFMSG1pTWhoY1BGRnRLeHQy?=
 =?utf-8?B?YWtYSGNXVXBHc25pbHU2a3FRRGZEZEs2aHRJb3JjTDc3SFMxYS9tZldBUkYr?=
 =?utf-8?B?M2hBaEJORUUrSUIrUlFxWk15Z3drL2ZhVjVMRUhURnpQcUNGb1JQZDZMT2du?=
 =?utf-8?B?cFVJWlRGK1MxYnVYM0EwczRTcVROZXB3MWpzSVUrR1pXY2pFNEdmaE1pMkkw?=
 =?utf-8?B?Um02VXZYaklsYndNMzFZdEhvVldIZEJRNC9mTTUwL25KdjY2S3prdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Wr0EmcqsecMmfw+QLezSjoo8EdxO0C+pVQ/HMcfZPwe0CR9L/qpG/Cs0+Hn+DVnax3nFwTbTExnGoDwmhUR5QEcmlTEiam7A5iZUdhKz+AAmY39JIsAsd+9afsjg4J8ZAYH+PZ4pUEiWPC//ptrIBbYadb39YM3e7K9xZ0Q77Pvz5oYw2y8rBkmDVdzjQk9dcf4ax0/RIBNn6f7XCGWO79HShdWomRHjsfvajRiTpLlwuqD870IUyttLIMgjl7fxrfk2gY3D2ocrZSHYofu2pEwDewzPX8udLcxSFfgnyWFoc1/JYD5qLqvLYwNcxLsx3yqoDl5981M+8k8L9D4L9w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a799b3-008e-4ebf-2be4-08dee171da15
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 06:33:43.9245 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UrS12wHGOLGneSlNIfac3VBDoAgTBZi+/VsPGWj+hDRBmEctl6PDOTNg9hRiJSlWfPEsZpXasMWiYSfyxjJeqvfSoJM6GLcYtPOZ/Lih8k4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7180
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYxXSB1ZG1hYnVmOiBFbnN1cmUgdG8gcGVyZm9ybSBjYWNo
ZQ0KPiBzeW5jaHJvbmlzYXRpb24gaW4gYmVnaW5fY3B1X3VkbWFidWYoKQ0KPiANCj4gSGksDQo+
IA0KPiBPbiAwNy4wNy4yNiAwODoxNiwgS2FzaXJlZGR5LCBWaXZlayB3cm90ZToNCj4gPj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2MV0gdWRtYWJ1ZjogRW5zdXJlIHRvIHBlcmZvcm0gY2FjaGUNCj4g
Pj4gc3luY2hyb25pc2F0aW9uIGluIGJlZ2luX2NwdV91ZG1hYnVmKCkNCj4gPj4NCj4gPj4gSGks
IHNvcnJ5IGZvciB0aGUgbm9pc2UgLSBhZGRpbmcgbW9yZSB1ZG1hYnVmIG1haW50YWluZXJzIGlu
IGNhc2UNCj4gVml2ZWsNCj4gPj4gZG9lc24ndCBoYXZlIHRpbWUgdG8gbG9vayBpbnRvIGl0IGF0
bSwganVzdCB0byBlbnN1cmUgcGVvcGxlIGFyZQ0KPiBhd2FyZS4NCj4gPj4NCj4gPj4gR2VyZCwg
U3VtaXQsIENocmlzdGlhbjogdGhpcyBpcyBhIHNpbXBsZSBmaXggZm9yIGEgbWlub3IgcmVncmVz
c2lvbiBpbg0KPiA+PiB0aGUgdXBjb21pbmcgNy4yIHJlbGVhc2UgLSBpdCB3b3VsZCB0aGVyZWZv
ciBiZSBncmVhdCBpZiBhbnlvbmUgY291bGQNCj4gPj4gcGljayBpdCB0byB0aGUgZml4ZXMgYnJh
bmNoIDopDQo+ID4gSGkgUm9iZXJ0LA0KPiA+DQo+ID4gWW91ciBwYXRjaCBMR1RNLiBJZiBubyBv
bmUgZWxzZSBwaWNrcyBpdCB1cCBzb29uLCBJJ2xsIHB1c2ggaXQgdG8gZHJtLQ0KPiBtaXNjLWZp
eGVzIGluIHRoZQ0KPiA+IG5leHQgZmV3IGRheXMuDQo+IA0KPiBnZW50bGUgcGluZyA7KSBXb3Vs
ZCBiZSBncmVhdCBpZiB0aGlzIGNvdWxkIGdvIGludG8gdGhpcyB3ZWVrcyBmaXhlcyBwdXNoLg0K
SGkgUm9iZXJ0LA0KDQpJIHB1c2hlZCB5b3VyIHBhdGNoIHRvIGRybS1taXNjLWZpeGVzIGxhc3Qg
d2Vlaywgc28gaXQgc2hvdWxkIGJlIGFibGUgdG8gbWFrZQ0KaXQgdG8gdGhpcyB3ZWVrJ3MgZml4
ZXMuDQoNClRoYW5rcywNClZpdmVrDQoNCj4gDQo+IFRoYW5rcyBhbmQgYmVzdCByZWdhcmRzLA0K
PiANCj4gUm9iZXJ0DQo+IA0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IFZpdmVrDQo+ID4NCj4gPj4g
VGhhbmtzIGFuZCBiZXN0IHJlZ2FyZHMsDQo+ID4+DQo+ID4+IFJvYmVydA0KPiA+Pg0KPiA+PiBP
biAyOS4wNi4yNiAxMzo1OCwgUm9iZXJ0IE1hZGVyIHdyb3RlOg0KPiA+Pj4gT24gMjkuMDYuMjYg
MTM6NDgsIE1pa2hhaWwgR2F2cmlsb3Ygd3JvdGU6DQo+ID4+Pj4gT24gTW9uLCBKdW4gMjksIDIw
MjYgYXQgMzo1N+KAr1BNIFJvYmVydCBNYWRlcg0KPiA+Pj4+IDxyb2JlcnQubWFkZXJAY29sbGFi
b3JhLmNvbT4gd3JvdGU6DQo+ID4+Pj4+IEhpIE1pa2hhaWwsDQo+ID4+Pj4+DQo+ID4+Pj4+IHRo
YW5rcyBmb3IgdGhlIHF1aWNrIHJldmlldyEgQW5kIG5vIHdvcnJpZXMsIEkgd2FzIHZlcnkgaGFw
cHkNCj4gYWJvdXQNCj4gPj4+Pj4geW91cg0KPiA+Pj4+PiBwYXRjaCwgd2hpY2ggaXMgd2h5IEkg
bG9va2VkIGRlZXBlciBpbnRvIGl0IGluIHRoZSBmaXJzdCBwbGFjZS4NCj4gPj4+Pj4NCj4gPj4+
Pj4gR2l2ZW4gdGhlIHBhdGNoIGZpeGVzIGEgbmV3bHkgaW50cm9kdWNlZCByZWdyZXNzaW9uIChh
bmQgaXMgdmVyeQ0KPiA+Pj4+PiBzaW1wbGUpLCBkbyB5b3UgdGhpbmsgdGhlcmUncyBhIGNoYW5j
ZSB0byBzdGlsbCBnZXQgaXQgaW50byA3LjEgLSBvcg0KPiA+Pj4+PiB3b3VsZCBpdCBuZWVkIHRv
IGdvIHZpYSB0aGUgdXN1YWwgNy4yLzcuMyByZWxlYXNlIHNjaGVkdWxlICsNCj4gPj4gYmFja3Bv
cnQ/DQo+ID4+Pj4gSGkgUm9iZXJ0LA0KPiA+Pj4+DQo+ID4+Pj4gVGhlIHRpbWluZyBkZXBlbmRz
IG9uIFZpdmVrIGFuZCB0aGUgZHJtLW1pc2MgbWFpbnRhaW5lcnMsIG5vdA0KPiBtZSwNCj4gPj4+
PiBidXQgaGVyZSdzIHRoZSBzaXR1YXRpb24gYXMgSSB1bmRlcnN0YW5kIGl0Og0KPiA+Pj4+DQo+
ID4+Pj4gVGhlIG9yaWdpbmFsIGNvbW1pdCA1MDRlMmI0YWI5N2Egb25seSBsYW5kZWQgaW4gNy4y
IChpdCB3ZW50IGludG8NCj4gPj4+PiBkcm0tbWlzYy1uZXh0LCBub3QgZHJtLW1pc2MtZml4ZXMp
LiBTbyA3LjEgd2FzIG5ldmVyIGFmZmVjdGVkIGJ5DQo+ID4+Pj4gdGhlIHJlZ3Jlc3Npb24gLS0g
dGhlcmUncyBub3RoaW5nIHRvIGZpeCB0aGVyZS4NCj4gPj4+Pg0KPiA+Pj4+IEZvciA3LjI6IHNp
bmNlIHlvdXIgcGF0Y2ggZml4ZXMgYSByZWdyZXNzaW9uIGludHJvZHVjZWQgaW4gdGhlIHNhbWUN
Cj4gPj4+PiBjeWNsZSwgaXQgd291bGQgaWRlYWxseSBnbyB0aHJvdWdoIGRybS1taXNjLWZpeGVz
IHRvIGxhbmQgaW4gNy4yDQo+ID4+Pj4gYmVmb3JlIHJlbGVhc2UsIGF2b2lkaW5nIGEgYnJva2Vu
IGNvbW1pdCBpbiB0aGUgZmluYWwgdHJlZS4gVGhhdCdzDQo+ID4+Pj4gdGhlIGNsZWFuZXN0IG91
dGNvbWUuDQo+ID4+Pj4NCj4gPj4+PiBBZGRpbmcgVml2ZWsgLS0gaGUgcHVzaGVkIHRoZSBvcmln
aW5hbCBwYXRjaCBhbmQgd291bGQga25vdw0KPiA+PiB3aGV0aGVyDQo+ID4+Pj4gZHJtLW1pc2Mt
Zml4ZXMgaXMgdGhlIHJpZ2h0IHJvdXRlIGF0IHRoaXMgcG9pbnQgaW4gdGhlIGN5Y2xlLg0KPiA+
Pj4gSGkgTWlraGFpbCwgSSBvZiBjb3Vyc2UgbWVhbnQgNy4yLCBub3QgNy4xLCBzb3JyeSEgQW5k
IGFncmVlZCwgdGhhdA0KPiA+Pj4gd291bGQgYmUgaWRlYWwgLyBwZXJmZWN0Lg0KPiA+Pj4NCj4g
Pj4gLS0NCj4gPj4gUm9iZXJ0IE1hZGVyDQo+ID4+IENvbnN1bHRhbnQgU29mdHdhcmUgRGV2ZWxv
cGVyDQo+ID4+DQo+ID4+IENvbGxhYm9yYSBMdGQuDQo+ID4+IFBsYXRpbnVtIEJ1aWxkaW5nLCBT
dCBKb2huJ3MgSW5ub3ZhdGlvbiBQYXJrLCBDYW1icmlkZ2UgQ0I0IDBEUywgVUsNCj4gPj4gUmVn
aXN0ZXJlZCBpbiBFbmdsYW5kICYgV2FsZXMsIG5vLiA1NTEzNzE4DQo=
