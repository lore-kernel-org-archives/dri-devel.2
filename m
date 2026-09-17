Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E10C88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 18:49:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C926010F064;
	Thu, 17 Sep 2026 18:49:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ClLm6Y03";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CECF010F05F;
 Thu, 17 Sep 2026 18:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789670974; x=1821206974;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=kInPI8XMFpFlDChhfwiuF4jzClqLvnaqTJY1pTCq49A=;
 b=ClLm6Y03dwYqxG3VnQ/C/lL3bBGdVdoFyTWwI6V9N/2z1zQWwzSZngT9
 o2Dj84C6NbKW1TrUV5URTqqrVWqC1TuCFwyTjZ/D8Zy6njmi1HfPhawuR
 K3UAVu9ku85DGgy7F5+AcYGT2K4HXXpg0j38di7vC8MAdUuytAX1Arpf6
 3rFWSo+TjsBXxTITdsMXOb07FnLZblOTFSVf6oAYPLG2Pb2TBg1Zu77xm
 aaQ3iWdbZeNJiyjYgn0uo8bDszkYF3GIeWbEQs3RnSHmENRCLtoJqO9hV
 oP9rsTdkK9WqvbNJOGED3wyO7Mt/Ey3hq9g2mUA+AGhcPEav60yA68KyC w==;
X-CSE-ConnectionGUID: bCypN8sqQ7u75vaNB7VTaQ==
X-CSE-MsgGUID: y1CYFsVITaGV6yzs1msRVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100791736"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="100791736"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 11:49:34 -0700
X-CSE-ConnectionGUID: W7ogd70kQkK1eH29nIcxww==
X-CSE-MsgGUID: m0vkKqTNQomTvCuBUBj5tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="297447477"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 11:49:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 11:49:29 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 11:49:29 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.45) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 11:49:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uovYyQAFISeZNX4+1LGQhVk7Mzu06yE1yXTYjZcrRO33prpGv1HJHtf7DWGBtsQAnv0gzJdKM9ziTeHTmalHuqO4Nrv0QS0Wn+rONTcquhhpVY1zoLO0cIqv83UfKAgLQBfBdqMuRQGu31m7W9fZw+3mpq65edaRjXHBVEHDQ416JNaAz+u9oeKdoMiUClKVXviw+0tiUKMmVAClSyQxtBXeXahfSDnp6t/58UuX1BxVlUC2F4nMi4lRSuJ2/nBDK81BoZouIyKrGLoGwsE8QhXwHdSc8BV7QMD6vVT68Lb95rPN/vgZce/EChMlAS87bPrywbEx7J9ZYnKBxonOWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kInPI8XMFpFlDChhfwiuF4jzClqLvnaqTJY1pTCq49A=;
 b=QI7oIYjxsTcYzEROO+YWILiKsxEsfk3+PSv7rgTwugnfWYIR4jQqmITo2bwApXKCB0cqGG2XboxDWgOgvCWYU1OVMd0W7EErAyGLMWj4g3QAyIuV1U5GUWYFi3Go1CExMZDq7q1BDIcFM9t0H5f5aPuw0KIQDXlELcx+L1RESbzCBUE2lLDhU1rBl732nB/1MXYFJBNiFu9yX336QpW4soxE5dlgYV8auJSBVjR5dx9sz/aoL130DqdIEOiAvz+2ClL9gPfDSqlqT1ly7I0lnzHbbT79g2M03eFoYQoF9X8KErZIC2IsNn3s4hwjJgvxKCNHMK51gJZOYBKod9/Mjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LVWPR11MB9883.namprd11.prod.outlook.com (2603:10b6:408:3c0::11)
 by MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 18:49:20 +0000
Received: from LVWPR11MB9883.namprd11.prod.outlook.com
 ([fe80::310:e83f:69b8:e11e]) by LVWPR11MB9883.namprd11.prod.outlook.com
 ([fe80::310:e83f:69b8:e11e%4]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 18:49:20 +0000
From: "Teres Alexis, Alan Previn" <alan.previn.teres.alexis@intel.com>
To: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Nikula, 
 Jani" <jani.nikula@intel.com>, "Roper, Matthew D" <matthew.d.roper@intel.com>
Subject: Re: [PATCH] drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep
 maximums
Thread-Topic: [PATCH] drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep
 maximums
Thread-Index: AQHdRJQayossBqMXeEuwdmvTfN5itbbPQDQAgACNaICAAHK1AIABVHkAgABgO4CAABRDAIABGAwA
Date: Thu, 17 Sep 2026 18:49:19 +0000
Message-ID: <9e129e0348ced40800e5071d288654480d9517b4.camel@intel.com>
References: <20260914215746.272721-2-alan.previn.teres.alexis@intel.com>
 <683c9836e408389852f6e6e956cc6862b1429b2a@intel.com>
 <145460bc090d7406d03f1335feaadb07172cff20.camel@intel.com>
 <aqnL7lUojj9jm8q_@intel.com>
 <6f8deb9d5f07feae11f35363e8b22d5ae606e63d.camel@intel.com>
 <aqs6Q9D_JywZ65-z@intel.com>
 <f4f3390fe950479cd6ef9367924861a3ec74ee95.camel@intel.com>
In-Reply-To: <f4f3390fe950479cd6ef9367924861a3ec74ee95.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR11MB9883:EE_|MW4PR11MB5776:EE_
x-ms-office365-filtering-correlation-id: 35b572cb-8767-434c-bd50-08df14ec6215
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|18002099003|22082099003|38070700021|4143699003|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info: RPjY5embUW6C0doXj+EQOgBmHslHW1xoH/vd8r/auBh8P3a02Dhlsl/fF8P1s9SkDjPjYHMNJ2Jb6mN25hW5U7HyIAsCFjytkZalI9v4YK5hM5LY3+8ZVYkadtZ1WXaAx8km2jXMIKCPheSpKHWlY4pTjXC8jOq5IBkrUwldmnziHCYejJwYgd6RQbaNhuWMgXZzo7YCFOaTo7jakq8et1BekuHn2VIYxGu4t2y8Lq3GF7DeymwMDFmDKXdx70micwk5cy/GpdnAxcgDN0nR/QcfxVeVy0Bk9ftrnpQkhV+KZq2m/wlb41PaDh/s/Pqc94DSFUYb4aBAfpv6aoo75pNFyXwbq/BJ5hmrJ51tp19WveoMEQGs4Qcl6qsNf49GhYnLLohCE4MGooGR3li5RC1uXHBYbQrWxi6HkNKQEFO+JVY4JFG5x85N6iADm90UG7cwX65vuk3kLBWPW9RF1I6lDIVoDPqTC7xQfuuJ/WWsS8r2AYHLpHgmVbKdiAyRGUx+nxiirNYQI5Ka81MEWMwJKSNk4IxgRG1Z9+YuRGQSbIVkXs6soWLHzRtDD0l72txPooxZAVv0ny6dYqc9R/DaX6fDujSYIs7x6DApfC6TW9zYF33y1Srm8SZbeV7kQDIZ80755gGEYIZ957DAamL7vgT5Ravttr+1IUPxLXVCl+hbYeYXAhVpeEF1m7iE1ScZiYd+QiGet8BkZS4gBPw6L4Hee57GfWgs96YovHs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LVWPR11MB9883.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(38070700021)(4143699003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qjc1TVhiUHBaUGNFSXpMY2FFcjkySDRmUFU1MjV1V1QyMW41bU43M05qTnZh?=
 =?utf-8?B?RGdTMGY5amJFVklZalRYRW9yalNXQ0RGTmMvNmMrY3FVRnZ4R3NtSnpUS2Mw?=
 =?utf-8?B?a0pYM09KaFczL3JkOUNkU2FMcDFNMDROcGpxRU8yUkF6amw1QmFmckwxWDZO?=
 =?utf-8?B?bk1xT1pSYzJwZTdjTHBhbEt1c0U1N3NMRUxuOUd2dkg3ZmRsTnU2WENLS2px?=
 =?utf-8?B?bUxMcTczcDN4anRVc3VTK2dOL0wzTnBqRXJQTHc5Q1MxdWtZQTZ1TFYyRjNN?=
 =?utf-8?B?ZG1CVFJqS1B6czFpbGtMeUpKVXhkODRadXJrTGY3cVhvd2RRclFyb1ZFREdq?=
 =?utf-8?B?QTV0VlhwOW9jVGRkQjhXSzRISWhob0Nzb3N0ZGV0Znd1ZzNvem5sTnU4V1ZM?=
 =?utf-8?B?Q2NyYTZqNkcxd3d0d2owTHN1M2pZKytrQzlXOXJsLzRaMjFIUXBOWTZnMzk0?=
 =?utf-8?B?ZjN3a3oyS1NtSitxY2thdDhtM3BBUUI4Yi80VVIwLyt4U3BpbXJBb1pJMUxD?=
 =?utf-8?B?eENDbzRpU05NdnNGcXZlYmF3eDQ3bHFURzFNYjUxbUdKZzJFYllneUZycFlD?=
 =?utf-8?B?ekFlU2Nvcy9QZVBDd2s0VkxwdTh1TDVwK1JQZnVIaTJqR05kakQwd2dkUXZv?=
 =?utf-8?B?SlYxZWRnRFVSZUhMbUNKSXV5eU1WdHFucWc5YWFqaVgyQ2Jqd3hibnpubmYz?=
 =?utf-8?B?Y014TThFRmhaczRodGFyT1QrT3BjYk5kQmxNaERycjdDWWNqN2gvM1VoeEZK?=
 =?utf-8?B?S2luOCtaMEhHTGFxb0N4SWZSaC9ZS3JxT0orbmFFVXhMNDBQY0M2NDRuSTNj?=
 =?utf-8?B?cFI2STltYlVjTzVxQ1lzRHJ0U2hBRDE3SzE5RUZwNlN3MCswQThEUmg5Z3M4?=
 =?utf-8?B?NGdna1hBY0c1SXlManoya1ZVOXd5bXFSQkZKNUQvSzVOMXdVS2hGQ2xKRHhB?=
 =?utf-8?B?ZzBTbUt2eGIwT3AzNTZhdENqN3BGRCtTeHJKQmFGRWZncVRYZ2gvTHlESUxS?=
 =?utf-8?B?VTlGYUl6YTErMGFlSDJDcVQ4S3N1K1BzendFaXZPcEtHRXhNQTRETnlRS0Ri?=
 =?utf-8?B?MTJ3d2NEdlJYdWpFR1NDdmIzalNhdElaZHAyMElkVUZIb0p2ZjYzK1hpTU9L?=
 =?utf-8?B?OVVzamxuOUhiZ0grZEV2cE5Xd3I3R3VNRUNldG9Fa0krdW8vUTZKaGoybTc4?=
 =?utf-8?B?YjdXcjQ2WnIwdmtMRkI0RkZqZytJRHVqZDN6eVVISkdlRFdiNU1sU1ZLNS8w?=
 =?utf-8?B?Vit3V0hhL3I4UGlNQVRJRG5mUkN3Z2Z1WERZa24yN1phWmdUbE16bXBrZjhB?=
 =?utf-8?B?bmxtMmh6UGZhRHJCY2ExeHV4MXBRNUp1dlV6azF2OThMUzBsY0Mrb05Ycnk2?=
 =?utf-8?B?T1ZSSFdkNnpDeEdyWGhSaXJIZ1krcjBLWERpWFhxWHdtVzJOL0JtUFg5VWM3?=
 =?utf-8?B?MlpHWTZ5UWVKV1gzOGxTb0FhcEdOL05xUU9Mc1M4ZERTL1hOVTNuTVRVQk1T?=
 =?utf-8?B?ek9sS284Y3p3N0RJSlFaR3hqVUlPZ1c2RFdoRUtqdThOSDNYR2VnWG55d05Q?=
 =?utf-8?B?WnppcENuaTQ2NGJmcTlnVTlTdVArZ0NNQWV1elFRU2taTWwrMHhJREFWZlRw?=
 =?utf-8?B?UHcrd3hNUUg2b0RvZ2h5eFBpZ3BzZWVXWjJLOTZyRTVkMkVvU0w0d295NVJY?=
 =?utf-8?B?MEtnQWhPbWpLcSt5V1dWa0xlUXBFOHJHcXZVSC9QNUNobThFZFhhcitRd2ta?=
 =?utf-8?B?SURFcWJndVFhVEZxV0N1aSsxOVBobXA1QTBaWWgweXUrOUJlM1dRRDR2bFlw?=
 =?utf-8?B?SmJ4U2FkOEpVc1B2am8rWXdHQTd5MzV0a0RPamtaL2xJSUhWT1NYamhKbmFx?=
 =?utf-8?B?cVgrWms2UFJ1akJoQlVGb3NJa1N2Z1dqSGFtUzFpOU4xUGxiSzNtRWZGSmgz?=
 =?utf-8?B?Nmo4dUVudGhlb3NKNDJsNlp5SU40di9Oc004WVhJeUhLVCtTRzk0L05YK1hs?=
 =?utf-8?B?VkI3THJxNW1hMU14QzZDTmlSVXFqNnhTMStOd1dJREhZcTBXeXJZN0pxcW1I?=
 =?utf-8?B?MGFOTVlxS3ZiYS9NQjNnWHNzMjlNN01VZUtnbjF0YmF4dmVjRGdSWUtEWTkv?=
 =?utf-8?B?Q3NCS2hYQ2lKUkZ4ZFJxdW9BNzE2TE1CNFQ4UE1jWDNZL3NtWlJ2UUgzamZU?=
 =?utf-8?B?STlOeWlwTzBjbW5UT0ZxZHUyNFR2ZFRzdDZLeEo2YWNhVFZjV3VZb1VMYmdt?=
 =?utf-8?B?S0pTdFg1TFRYZ1hRSEt3bE8vVzFvakkvZjFyU2w0QUphbXJVQW52V1p3RFRs?=
 =?utf-8?B?NzJadGpJSUFpSDBNRmZLNzI2RENzeUlCdElIT0FxVWZ2NzYwQ1lZN3JZamZP?=
 =?utf-8?Q?by8FGRKJnmKr/24hof2RVxdwvQC1y+D7R0Yhp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBD2A900AA117342A1C5C15B0FDD544C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WoUKukivbpwtJ+HikhEr2MUpErWKlOMdjImUXmGYVt9owp6TWr40X43/ENmrbboNWEqsd5U/iJWj/zIUKIW0a/K7xCW6wbpS6n+6FpxPFBIUFkPPZ4JKBaYTVxsvIdavHP5pINwuQbu5a8oCzEWQWTLYedykHPmTqGWwItdFveOAmUQEcU8UHY/MAKWw2LlGm2gmC/Q/a60Z8E7AUYLEjEGR/Dr+3tSGhVMyxngiwXiGyJ3g+5E4R9h3pQtWDnVcl0rqrCkFDV/pfCbibu8ErLb0q69tiwjRw2htj/3oGkKem9/J0gsCh16e86LtLoREfZ5heUeEOZ9XdPuJOQZ1jg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR11MB9883.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b572cb-8767-434c-bd50-08df14ec6215
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2026 18:49:20.0304 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 96WD95pfY8v0wz5Y5S7+AizUZTcvscmEYgPb9/ysdr8W+IQzqyOkv8mFg70u+aQvrAsAH2Xgm45pDCl8f1vW8/FQNSfetpzORXviUyD07+dFGdPGpf+GLtRLI7EJFwqU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5776
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

PiA+IA0KQWN0dWFsbHksIGhvbGQgb2ZmIGZ1cnRoZXIgcmV2aWV3LiBsZXQgbWUgcG9zdCBhIG5l
dyBzZXJpZXPCoHdpdGggMiBwYXRjaGVzDQotIGZpcnN0IHBhdGNoID0gcmUtcmV2IG9mIHRoaXMg
b25lIC0gYnV0IGFsaWduZWQgdG8gUm9kcmlnbydzIGRpcmVjdGlvbiB0byBrZWVwDQppdCBzaW1w
bGUgKGZvciAiZml4ZXMiIG1hbmFnZW1lbnQpIHdpdGggc2ltcGxlIGludHJhLWxvb3AgY2Fwcy4g
DQotIHNlY29uZCBwYXRjaCB0byBhbGlnbiB3aXRoIEphbmkncyAoYXMgd2VsbCBhcyBvdGhlciBv
ZmZsaW5lIGlucHV0cykgdGhhdA0Kd2UgU0hPVUxEIGFjdHVhbGx5IGJlIHVzaW5nIHRoZSBrZXJu
ZWwgcG9sbGluZyBoZWxwZXJzLg0KDQpidXQgaSB0aGluayBpIHdvbnQgdXBkYXRlIGFsbCBjYWxs
ZXJzIHRvIHNlcGFyYXRlIGF0b21pYyB2cyBub24tYXRvbWljIChhcyBwZXIgSmFuaSdzKQ0KcmVx
dWVzdC4gSSBhZ3JlZSB3aXRoIGhpbSwgYnV0IG5lZWRzIHRvIGJlIGEgc2VwYXJhdGUgc2VyaWVz
IGJlY2F1c2Ugc2luY2UgaSBzZWUNCnVzIHVzaW5nIHRob3NlIHBhcmFtLWJhc2VkLWF0b21pYy1z
ZXBhcmF0aW9uIGVsc2V3aGVyZSBpbiB0aGUgZHJpdmVyIGluIG90aGVyIHN1YnN5c3RlbXMuDQoN
Cg0KdGhhbmtzIGFnYWluIGV2ZXJ5b25lIGZvciBhbGwgdGhlIGlucHV0cy4gd2lsbCB3b3JrIG9u
IHRoZSByZS1yZXYuDQoNCg0KYWxhbjpzbmlwDQo+ID4gPiBhbGFuOiBpIGRvbnQgdW5kZXJzdGFu
ZCB5b3VyIHRoaXMgY29tbWVudCBvbiB0aGUgaW5jcmVhc2luZyB0aGUgIndhaXQgYnkgeDIiIGlu
IHRoZSBsb29wIGFmdGVyIGFncmVlaW5nIHdpdGggSmFuaSBvbiB0aGUgZWFybGllciBzdGF0ZW1l
bnQuDQo+ID4gDQo+ID4gV2hhdCBJIGFncmVlZCB3aXRoIEphbmkgd2FzIHRoYXQgYSBoYXJkY29k
ZWQgMTB1cyBwb2xsIGludGVydmFsIGFnYWluc3QNCj4gPiBhIDJzIHRpbWVvdXQgaXMgYmFkLiBU
aGF0IHdhcyBhbGwuDQo+ID4gDQo+ID4gPiBTb21lIGhpc3RvcmljYWwgY29udGV4dDoNCj4gPiA+
IA0KPiA+ID4gIDEuIGN1cnJlbnQgYmFzZWxpbmUgY29kZSBpdCBzdGFuZHMgdG8gZGF5IElTIGlu
IHZpb2xhdGlvbiBvZiBsaW51eCBydWxlcyBmb3IgaG93IHRvIHVzZSB0aG9zZSBzbGVlcC9kZWxh
eSBmdW5jdGlvbnMNCj4gPiANCj4gPiByaWdodCwgYW5kIEkgYmVsaWV2ZSB0aGF0IHRoaXMgc2lu
Z2xlIGxpbmUgY2hhbmdlIGlzIGVub3VnaCB0byBmaXggdGhpcw0KPiA+IHZpb2xhdGlvbi4NCj4g
PiANCj4gPiBUaGUgcHJvYmxlbSBpcyB0aGF0IHdlIGRvdWJsZSB3YWl0IGV2ZXJ5IGxvb3AgMTAs
IDIwLCA0MCwgODAg4oCmIDIwNDgwLCA0MDk2MCBhbmQNCj4gPiBuZXZlciBzdG9wcyBkb3VibGlu
Zy4gdWRlbGF5KCkgaXMgb25seSBsZWdhbCB1cCB0byB+NTAwMHVzIChwZXJoYXBzIDEwMDA/ISks
DQo+ID4gc28gb25jZSB0aGUgZG91YmxpbmcgcGFzc2VzIHRoYXQsIHdlJ3JlIGJyZWFraW5nIHRo
ZSBydWxlLg0KPiA+IA0KPiA+IFNhbWUgb24gdGhlIHNsZWVwaW5nIHNpZGU6IGl0IGVuZHMgdXAg
YXNraW5nIHVzbGVlcF9yYW5nZSgpIHRvIHNsZWVwIDEuMyBzLA0KPiA+IHdoaWNoIGlzIG5vdCB3
aGF0IHRoYXQgZnVuY3Rpb24gaXMgZm9yLg0KPiA+IA0KPiA+IFRoZSBvbmUgbGluZSBqdXN0IHN0
b3BzIHRoZSBkb3VibGluZyBhdCAxMDAwdXM6DQo+ID4gDQo+ID4gd2FpdCA9IG1pbl90KHM2NCwg
d2FpdCA8PCAxLCAxMDAwKTsNCj4gPiANCj4gPiBBZnRlciB0aGF0LCB0aGUgd2FpdCBjYW4gYmUg
MTAsIDIwLCA0MCDigKYgdXAgdG8gMTAwMCwgYW5kIHRoZW4gaXQgc3RheXMgYXQNCj4gPiAxMDAw
IGZvcmV2ZXIuIEl0IGNhbiBuZXZlciByZWFjaCAyMDQ4MCBvciAxMzAwMDAwLg0KPiA+IA0KPiA+
IFNvIHRoZSBpbGxlZ2FsIHZhbHVlIG5ldmVyIGdldHMgcGFzc2VkIHRvIHVkZWxheSgpIG9yIHVz
bGVlcF9yYW5nZSgpIOKAlCBldmVyLg0KPiA+IA0KPiA+ID4gIDIuIG15IGluaXRpYWwgcmV2cyBv
biBmaXhpbmcgdGhpcyB3YXMgdG8gbWluaW1pemUgdGhlIGNoYW5nZXMgc28gaXRzIG5vdCBjb21w
bGljYXRlZCBieSBzaW1wbHkgZml4aW5nIHRoZSBjb2RlIGluIHBsYWNlLg0KPiA+IA0KPiA+IEkg
YmVsaWV2ZSB0aGlzIHNpbXBsZSBsaW5lIGFsaW5ncyB3aXRoIHlvdXIgdjEsIGJ1dCBqdXN0IHNp
bXBsZXIuDQo+ID4gDQo+ID4gPiAgMy4gSmFuaSBzYWlkIHdlIHJlYWxseSBzaG91bGQgdXNlIHRo
ZSBwcm9wZXIgbGludXgga2VybmVsIGhlbHBlcnM6IHBvbGxfdGltZW91dF91cyAvIHBvbGxfdGlt
ZW91dF91c19hdG9taWMuDQo+ID4gPiAgNC4gVGhvc2UgaGVscGVycyBoYXZlIHRoZSAidGltZW91
dF91cyIgYW5kIHRoZSAiaW50cmEtbG9vcC13YWl0LXVzIiBwZXJpb2QuIEkgaGFyZGNvZGVkIHRv
IDEwIHVzZWMuDQo+ID4gPiAJLSBKYW5pIHNhaWQgaSBzaG91bGQgbm90IGhhcmRjb2RlIGFuZCBl
bnN1cmUgYWxsIHVwLXRoZS1zdGFjayBjYWxsZXJzIG9mIHRoZSB4ZV9tbWlvX3dhaXQzMiBmdW5j
dGlvbiBwYXNzZXMgaW4gdGhlIGludHJhLXdhaXQtbG9vcA0KPiA+ID4gdmFsdWUuIA0KPiA+ID4g
CS0gVGhlbiB5b3UgKFJvZHJpZ28pIGFncmVlZCB3aXRoIGhpcyByZXF1ZXN0IGJ1dCBnbyBvbiB0
byBwcm9wb3NlIGdvaW5nIGJhY2sgdG8gZXhwb25lbnRpYWwgMnggaW50cmEtd2FpdC1sb29wLg0K
PiA+ID4gCQktIGJ1dCB0aGF0IGNvbnRyYWRpY3RzIEphbmkncyByZXF1ZXN0IHUgYWdyZWVkIHRv
IGFuZCBhbHNvIHRoYXQgbWVhbnMgd2UgaW1wbGVtZW50IHRoZSBpbnRyYS13YWl0LWxvb3A/IChp
LmUuIGRvbnQgdXNlIHRoZQ0KPiA+ID4gcHJvcGVyIGxpbnV4IGhlbHBlcj8pDQo+ID4gDQo+ID4g
c29ycnkgZm9yIG5vdCBiZWluZyBjbGVhciBvbiBteSBwcmV2aW91cyByZXNwb25zZS4gUGVyaGFw
cyB3ZSBoYXZlIGEgY2xlYW5lcg0KPiA+IGVuZCBjb2RlIHdpdGggdGhlIHBvbGxfdGltZW91dF91
cyBhbmQgcG9sbF90aW1lb3V0X3VzX2F0b21pYyBpbmRlZWQuDQo+ID4gDQo+ID4gVGhlbiBwZXJo
YXBzIHdlIGhhdmUgdGhpcyBzaW5nbGUgZml4ZXMgcGF0Y2ggYW5kIGRvIG90aGVyIGF0dGVtcHRz
IGluIGdldA0KPiA+IGNsZWFuZXIgbG9vcHM/DQo+ID4gDQo+ID4gVGhhbmtzLA0KPiA+IFJvZHJp
Z28uDQo+ID4gDQo+IGFsYW46IEkgdGhpbmsgaSB1bmRlcnN0YW5kIHdoYXQgdSBtZWFuLiBCdXQg
aSBiZWxpZXZlIGEgc2luZ2xlIGxpbmUgcGF0Y2ggd2lsbCBOT1Qgc3VmZmljZQ0KPiB0byBtYWlu
dGFpbiBleGlzdGluZyBiZWhhdmlvciBmb3IgdGhlIG5vbi1hdG9taWMgY2FzZS4gSW4gdGhlIG9s
ZCBjb2RlLCBpZiBjYWxsZXIgd2FzDQo+IHJlcXVlc3RpbmcgZm9yIG5vbi1hdG9taWMsICd3YWl0
JyB3b3VsZCBjb250aW51ZSBkb3VibGluZyBpbiB1c2xlZXBfcmFuZ2UgKHdoaWNoIGhhcyBubw0K
PiBvdmVyZmxvdyBsaW1pdCBmb3IgaXRzIHBhcmFtcykgc28gd2UgYWN0dWFsbHkgQ0FOIGtlZXAg
ZG91YmxpbmcuIFRodXMgY2FsbGVycyB0aGF0IGhhdmUNCj4gdmVyeSBsYXJnZSB0aW1lb3V0cywg
d2UnbGwgYmUgc2F2aW5nIG9uIENQVSBjeWNsZXMgYXMgaXQgaW5jcmVhc2VzLiBCdXQgd2l0aCBh
IDEgbXMgY2hhbmdlDQo+IGFzIHlvdSBwcm9wb3NlZCwgd2UnZCBiZSBpbmNyZWFzaW5nIENQVSBj
eWNsZXMgdG8gZ2V0IHVzIHRvIHRoZSBlbmQuIE9mYyBJIGFncmVlIHRoYXQNCj4gZG91Ymxpbmcg
Zm9yZXZlciBpcyBub3QgaWRlYWwgZXZlbiBmb3IgdGhlIG5vbi1hdG9taWMgdXNsZWVwX3Jhbmdl
IGNhc2UsIChrZXJuZWwNCj4gZG9jdW1lbnRhdGlvbiBzdGF0aW5nIHRoYXQgaXRzIGdvb2QgZm9y
IGJvdGggc2hvcnQgYW5kIGxvbmcgdGltZW91dHMpLCBob3dldmVyIGtlcm5lbA0KPiBkb2N1bWVu
dGF0aW9uIERPRVMgc3RhdGUgaXQncyBhbiBleHBlbnNpdmUgb3BlcmF0aW9uIHdpdGggdGhlIGhy
dHRpbWVyLCB3aGljaCBpcyB3aHkNCj4gaSB3YW50ZWQgdG8gYWxsb3cgdGhlIGRvdWJsaW5nIG9m
ICd3YWl0JyBmb3IgdXNsZWVwX3JhbmdlIGNhc2UgKGxpa2Ugb3JpZ2luYWwgY29kZSkgYnV0DQo+
IGNhcCBpdCB0byAyNSUgb2YgdGhlIGNhbGxlciBwcm92aWRlZCBmaW5hbCB0aW1lb3V0LiAod2hp
bGUgY2FwcGluZyB0aGUgYXRvbWljIHZlcnNpb24gdG8NCj4gTUFYX1VERUxBWV9NUyBmb3Igc2hv
cnQgZGVsYXlzIG9yIHRoZSBzYW1lIDI1JSBmb3IgbG9uZyBkZWxheXMpLiBUaGlzIHdpbGwgZW5z
dXJlIHRoZQ0KPiBvdmVyYWxsIGJlaGF2aW9yIGluIHRlcm1zIG9mIGNwdSBjeWxlcyBhbmQgZXhw
ZW5zaXZlIGhydHRpbWVyIGNhbGxzIGFyZSBzaW1pbGlhciBhcyBiZWZvcmUNCj4gQU5EIGFsc28g
Zml4aW5nIGluIGFjY29yZGFuY2UgdG8gdGhlIHJ1bGVzLiBBY3R1YWxseSBpZiB1IHNlZSByZXYz
LCB0aGlzIGlzIHdoYXQgaSBtZWFuDQo+IEl0cyBub3QgMSBsaW5lIGJ1dCBpdHMgbXVjaCBzaW1w
bGVyIGZpeCBhbmQgZG9lcyBJIGJlbGlldmUgaXQgZG9lcyBhbGlnbiB3aXRoIHlvdXIgdmlzaW9u
Lg0KPiANCj4gPiA+IA0KPiA+ID4gIC4uLmFsYW4NCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiA+IEFs
c28gdGhlIEZpeGVzIHRhZyBpcyBub3QgdGhlIHJpZ2h0IG9uZS4uLiB0aGUgYnVnIHdhcyB0aGVy
ZSBiZWZvcmUuLi4NCj4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gLi4uYWxhbg0KPiA+
ID4gDQo+IA0KDQo=
