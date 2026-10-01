Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0325CA5FCF
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 06:22:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E3D410E1FB;
	Thu,  1 Oct 2026 06:22:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NzhEDjME";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C33DE10E0ED;
 Thu,  1 Oct 2026 06:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790835770; x=1822371770;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=7uY/m9SCgWFQwg+o0jdkY9f4d5siKCwxpKZBAVwPgj8=;
 b=NzhEDjMEWOJqwyiNIWvArQnEI8n/rfpYmn9ylmQrNMkObzLXezQzHks+
 DHDopxwUedJIqEC+gTfNoig8atsMRRW8d82BrIEPiYn2CalqAUzpp62De
 UCSgZKVVILYQRJtAG8uHf9MRiz8cyzoSBSSv2mStKHzamT52xvCMJ5g3p
 rx6RmJ9T6xaP/WBVd5oVf/1RjwmoqLu38vrHyivVeFRqQ0RpVJiNXMRUq
 nwRV3ezTtTKkmKYOwjNI9aM/3RKeotGZTbHvSUOAvWBzDgxM/E6D+k5y+
 oAe/m/Md2VN+/vVSvUwMTh0INkPVmGsehlto+5Vqg+QZ+RH7vTUQ92T1G w==;
X-CSE-ConnectionGUID: fCiObR/qRQm/lAKxf4RIEQ==
X-CSE-MsgGUID: 6F8fwc6WRPyRcgo3v9rRiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="107965776"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="107965776"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 23:22:50 -0700
X-CSE-ConnectionGUID: OS/DVa0nQ+q6p28aKpvqow==
X-CSE-MsgGUID: BaPEHYp6SPqUsv6sqg3Taw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="305413553"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 23:22:50 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 23:22:48 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 23:22:48 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.16) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 23:22:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNZ6lMdC9eM1ZFUM/jnWH1ZGctRrtFhpJLCnvJAUbN63U07SygUlQagGCX+woUY1Y4OIlx6Ta3GQhQS6vJvOS228tzQrJajjNMuJ2zUMa1UYv6n2OVXNvSKlUPizf11QL/kzVuLJb9py7xUd3/NbqcmD37RvSsYguMhNAFCBxxNjk5Q/bak+f81n7Zse5CnGnHsuFhQI3lmJiAnPY+zFmf1jLG7CIw8wqXoSs0axaKa25ghSrMgjxzEeiRPKp/hH0Ze0A5RTDv/EwCZjbAyXI2Q2yhB9LunloHrJPzbJ0v1gHqkcaoEqhLfApGVHIWbqu+yhiOJZWa3x2dFs9fJO+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uY/m9SCgWFQwg+o0jdkY9f4d5siKCwxpKZBAVwPgj8=;
 b=bZBrSp7/iWmBxzH5wEwOI9DQJJPcDuT0Ou9ysZSHNJZ2dtQRnLTH5EhyUszusBDNo92QxW6B9aWGBrpOIRyuxwHDh82WrN/ehMvR70dSvTi3bMW/53rnwoS6W8ZW8eunY6y1qXcZft74nE8V9QEQJHGMvLRop7HmSLx3mFc9wfSLSCzRUKn8OlH3iZ2iM8Fe49nyj/pdsRyvDdzXlBJmObi855M+hlVjBeNycjlAwNx/YyKX1Ay1bhqgh9+Uz7ZH1GeOop+wnQLf5XRuoRLKX1xHg9hnMvRA3UGwIxwqRZUwO3dxy8AyKZUXGDBkp8ygB0/kI1PokqbqOj+kuxjnEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6019.namprd11.prod.outlook.com (2603:10b6:8:60::5) by
 DSM1PF3F9CB0CA1.namprd11.prod.outlook.com (2603:10b6:f:fc02::146)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 06:22:47 +0000
Received: from DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762]) by DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762%6]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 06:22:47 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Manna,
 Animesh" <animesh.manna@intel.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>
CC: "Kandpal, Suraj" <suraj.kandpal@intel.com>, "Nikula, Jani"
 <jani.nikula@intel.com>
Subject: Re: [PATCH v6 10/18] drm/i915/alpm: Modify LFPS cycle count for DP
 ALPM
Thread-Topic: [PATCH v6 10/18] drm/i915/alpm: Modify LFPS cycle count for DP
 ALPM
Thread-Index: AQHdRUGRiTfjuDQDlEuObs12e4Y2FLboUAeA
Date: Thu, 1 Oct 2026 06:22:46 +0000
Message-ID: <5973833da40acc6c07ab0478cfc799bebb889862.camel@intel.com>
References: <20260915180449.277933-1-animesh.manna@intel.com>
 <20260915180449.277933-11-animesh.manna@intel.com>
In-Reply-To: <20260915180449.277933-11-animesh.manna@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6019:EE_|DSM1PF3F9CB0CA1:EE_
x-ms-office365-filtering-correlation-id: 593bb404-ef67-473e-5e15-08df1f84692c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|38070700021|3023799007|11063799006|10067099003|4143699003|56012099006;
x-microsoft-antispam-message-info: o8ep39L6rO3pHdnDBge5BlSQbMXXIFAapbWWw78pqr7DNfovmseq+ZyY9thU7oIQa0KgFnhok0wWKcsIyL50fVW4n+ktQcPxCBnfWsRY8goO+6NbXH9bOy80NhcGxxywnI7LbVBh2yc3KYSdKPJi5Py4cBfXqgXUq+XeB7tGj5VPssHv2Sn+8eIOyXmk+hzfTwUm9MoFXdvC2jE+EURoTBAB+AGhptzmbZZqi5E9x+lvphbhT5qK5v6jtE2Espkrp9kebF+2vXn93C5LvUrJoxhfmQYEJ1iWTH3pwYXsIuNXF5S6jsLd/LWUTCye2GHmiPDloz+9AfCJ/VlViWkSxRIDrlDtOKBQNKFI9iVVluvBZLbklyMUhV1MvGAA6yhsv5WLtesYhC8Dzrv+gDqqiJHnDb+axQ1zhBPZMcwGfvlw1eu8C/kQod/QJ/eb22Uo+jrUCVw1XirJP60XT7nfi83jaeta31Qg6abVt7pb3rF0dO4t6bb54aGcnT6K2ctJuFvbox6faISWNbZSlblzY+vBNBXYGNrpHtHf7I3oldBVw+k9epdvazKY0w4yY/0HwL+65aKQ2UT1GV8h0pzDfhPeSXoZ073N6sYqKBAjpcuUCm8afUZcXj+GUzhaMt9ADRP59/CK4NKPzAalb4kzcnHhz+SF0ezezURA2xA1MtE0kxjmCigkcqSRH71FK/0PxbLmPB64r5ZTJb5Hl9cDKlbeZEMJPJm+gWEf+jM63PA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6019.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(38070700021)(3023799007)(11063799006)(10067099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHJsN0ZBMHgwakRPN0lTSEdpN0ZxZlN0OXNSSE9DcHVlb3R5Wnk2cUp2L054?=
 =?utf-8?B?SEFEeHlSRlVzQ3lrMkJRYktlQjA2VWZCUlRkbVR3RTI2bWNwTE51OXN2SDVl?=
 =?utf-8?B?UjJ6a1Yzd1FuVkh1ZXI0SkpIWDRvc2Y4WW40ZTBBcjRiUnZRd0x3a0svNktj?=
 =?utf-8?B?bUtBK1hha25sY2ZlLzVGNGJ0b3NsVzN5QU80UjMvUVVRZnNxQmhXbC8raSt0?=
 =?utf-8?B?M3BOc1gvM3pOUkZDT0RFT0pTZDY3NVlZZnZhYkdQV2dYNGlVTWp1L2FOMkpo?=
 =?utf-8?B?Y0luSEJzajAwTVBvR1dDNjlsTDZrc0Nha1hMdVZhRFRaQ3BVd1pCWGptMzEx?=
 =?utf-8?B?Z1h2VElia1lBc0xOMDU3WDFJTUdVWTUybG9IWEVmamtEa1RSYXdJV2lSbmxw?=
 =?utf-8?B?MTlWaEVQV1dTQVlqS2dPWlJsYU5kd2FkRnljTFVrUk5OL0JuVWJaR2l2NVNw?=
 =?utf-8?B?OUdZVHNXS2lRZUpYRFNKeG5vSDg1SmRqYWZORXZSenNEWCthSVprT3cvSE53?=
 =?utf-8?B?OGtKNEpxdkZpUXR4LzNmVTkyNlFqV28xZDFxY0VoNXNyNEIydGhJeDN5UGVo?=
 =?utf-8?B?RGRKVE5Oc3BXWFMzekNqRmJtZFVlQWRQMXZuZFBkOXBkNm5qUXFmK3R3V1F4?=
 =?utf-8?B?VmNkL3JUMnJSVU9NTjZ0L3lHdUFnbkNaS1Z1L3dST2ZRS2JYL09Ua0RaQno1?=
 =?utf-8?B?Q2dYZkZFMXRTVHhPNjRraHdLNkdNZTUzREs0YW8welVtd0NCdmsxczhEZS9i?=
 =?utf-8?B?eUpSQ2dGaTgyZTJjaVdST2xTOVNqQ3BTQ3JNQ21jS1hNbjFWSjJnN1B5T044?=
 =?utf-8?B?bDZBS0R2SDJVOFVOL3ZXamNEd0xoVWRZV0VuUGcwYkJUNXhSbWUvb0pwc25Q?=
 =?utf-8?B?MXd6bDZWUjhGZEtMMzhKREJyWFJRVWR3c1lMQnNPb3pOWXF1L0pLcmx5NVJL?=
 =?utf-8?B?bnNmR1NZa2lQK3RZTVo1NFFEZHVsWlRWbGFMQU13SzcxZStoUGx4REJ2Zm9y?=
 =?utf-8?B?VFFhNWtZS2RmaTV5U01qMmVGN2F3RWpUS1hkV2Mrbi9Kb21WU3ZUNjRKMzhJ?=
 =?utf-8?B?cTZ2aVNQNVpjUjBIUzhmakdtMk9yWVlVZHFtd3pDTTJxUmV4QlUvZDFXZGFB?=
 =?utf-8?B?N1dnK2F0R0R5aGp6S20zMWNHbW9IdGI3dXVOSlp4TlE0Q3JWQmZOSEJCNjE4?=
 =?utf-8?B?NmZHK0xib2JsQkN0TGJTWDdXajJ6bitaMFpreEFyR2NiWUhqbVVWL0FLdjdx?=
 =?utf-8?B?VnY1Z2w1ZDZ1ckZpbmVuUjdRNkU4QklFZS9wakZXVU9GVHN1N29ZdFgwRU5r?=
 =?utf-8?B?ak5uSUpEbFEyRytZVHozamNDVGYrb2VNS0lubE5GMm05b2wyTDlVWkVOTkVB?=
 =?utf-8?B?OFIveFRjaUV6Tmp1L1RlNHpyUlFDMlVicW9vaGR1UFV0OVUzQ3Y2MmJ5T3RJ?=
 =?utf-8?B?elYvbEF1K0M4V3B3Vm1JaWNncFhQWGd3L0hYK3F4cGU0TFFSRFFRQkNIczV3?=
 =?utf-8?B?a3RKeUJjVXdwdXkyMGFCaDlHMjhIRFBNZmltd1FHZGNndHFPNmRYOEJPOWht?=
 =?utf-8?B?cUxCVnJFZE5HSENSQnpUcVhmNnZpN05md2JvTGg1UWQ0bHJpdVBvZHFXSDlV?=
 =?utf-8?B?bWQ4djd4K1B5SDlzQ0VvTExYVU9lOVhNMEZyQTNwdURKdzg2T3FVdnA5aFdi?=
 =?utf-8?B?b1g2azR2V1JPZkhQc2h5WFo2Mm1ScWk1OFZ6cjVNQ0RoZmhHaWkzRWpFNzlF?=
 =?utf-8?B?dDh5dkNxSG9oQVpRNmRwTUFXS2NIak1Vd3o0ZURnT3R3ejhSTEQ1TlhBT3Bh?=
 =?utf-8?B?QW5VYUhiOGdsZUJ6T0FmQ2wyWW1pT2ZaNU1GdXpla3p4dmdqdWlmeUdKQ0Rz?=
 =?utf-8?B?bFNMbTdCODFyblZMSk1DOG1UWDhvaUpkNnA5RE9GbkZwcllORHlXZk0yWVRH?=
 =?utf-8?B?eFZIYlRYZGE2TWo1bXVDRTBsZTVSRVZzeG5RUU5pNlVURng3UGRySjV1ZDNl?=
 =?utf-8?B?NjZwVW15Y0sxdmJzdDRSYlZaWHNTbnQ5MVhUdGhUSVhpczBzd3BwMUhRbWUw?=
 =?utf-8?B?d2thcm5FVi9FaXlhSUVNRHRlOGVJYkhPTHlNTThXWW52dEJ2QlVPM3YyUHc5?=
 =?utf-8?B?VWF5cW80TGh5MGtCUHRjc2RuYnBWdDNoRGNvWWdQQTJWcThxYm5SbzZpOFB2?=
 =?utf-8?B?N09vUkZ6Q1BmMzh4VGdBNTZaZzZERGlLSEtkQ1VjUTRNZHV5Rlo2T2ZLVTE5?=
 =?utf-8?B?QzBhS0dzbktsNDR5Q0FRQllKRWFpNjFqd0VRVGNQcVpFckc4d0hRSEEzTTlG?=
 =?utf-8?B?bDM1Q21DMWIyakQyQkt3Wml0b2luVXh5M2xmZkR0MFhEemUyUHA5b2dhTU1u?=
 =?utf-8?Q?hatJMOeSOSNP2hTw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00623F8E7C958E489D9578E97FE550DB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DDZioDomv0Ft3wUrAxltmF0UJlgVBA9av1jORPPaQahuL/9107TE4qUfTHXDJhj+g1JuK34BI/FJH1pzZEzdsgjQWWy5TTRRci4jzksaiQgNXYaNMOaiXxuYBy5st1qgC3/eVZpCRGdM+aQcb39LcAM/U/ixy6G3nDR2F8P9aKCYWHF34/MaLwDWa9OwGzww/u2rQTwb1SBA+pM46rr39z3C4Cg55IZUa3Po/w5yrUBPX9Buwi4Y4GVyrJl4A55poa6V5jkyDnWIeOGk0SWNUMrsnov8tIHJgzzgENroKkKe5SQy5epxubn2EBe7R6hu/pESHbl8rqT4yn6y6Tg7fA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 593bb404-ef67-473e-5e15-08df1f84692c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 06:22:47.0185 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YUYof+v58C3dWkfyDg2lk5nRDz2lqEjTL4DVzxLujLkp5dOwa2RSLWFNYP8G95Itivz8x73cB/PQ71lfpPBHyq/mIaN2l3YTSAtOT3uCoVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSM1PF3F9CB0CA1
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
PiBGb3IgRFAgbWluaW11bSBMRlBTIGNvdW50IGlzIHNldCB0byBtaW5pbXVtIDE2Lg0KPiANCj4g
Q2M6IEpvdW5pIEjDtmdhbmRlciA8am91bmkuaG9nYW5kZXJAaW50ZWwuY29tPg0KPiBTaWduZWQt
b2ZmLWJ5OiBBbmltZXNoIE1hbm5hIDxhbmltZXNoLm1hbm5hQGludGVsLmNvbT4NCj4gLS0tDQo+
IMKgZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9hbHBtLmMgfCAxNiArKysrKysr
KysrKysrLS0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDMgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9p
bnRlbF9hbHBtLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0u
Yw0KPiBpbmRleCAxNGVjYjI3MDk1YjIuLjIyZWQzNDE3NjNmYSAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9hbHBtLmMNCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9hbHBtLmMNCj4gQEAgLTI0LDcgKzI0LDggQEANCj4g
wqAJCQkJKFNJTEVOQ0VfUEVSSU9EX01BWF9USU1FIC0JXA0KPiDCoAkJCQkgU0lMRU5DRV9QRVJJ
T0RfTUlOX1RJTUUpIC8gMikNCj4gwqANCj4gLSNkZWZpbmUgTEZQU19DWUNMRV9DT1VOVCAxMA0K
PiArI2RlZmluZSBMRlBTX0NZQ0xFX0NPVU5UCTEwDQo+ICsjZGVmaW5lIExGUFNfQ1lDTEVfQ09V
TlRfRFAJMTYNCj4gwqANCj4gwqBib29sIGludGVsX2FscG1fYXV4X3dha2Vfc3VwcG9ydGVkKHN0
cnVjdCBpbnRlbF9kcCAqaW50ZWxfZHApDQo+IMKgew0KPiBAQCAtMTIxLDEwICsxMjIsMTkgQEAg
c3RhdGljIGludCBnZXRfbGZwc19jeWNsZV90aW1lKGNvbnN0IHN0cnVjdA0KPiBpbnRlbF9jcnRj
X3N0YXRlICpjcnRjX3N0YXRlKQ0KPiDCoAlyZXR1cm4gdGxmcHNfY3ljbGVfbWluICvCoCAodGxm
cHNfY3ljbGVfbWF4IC0NCj4gdGxmcHNfY3ljbGVfbWluKSAvIDI7DQo+IMKgfQ0KPiDCoA0KPiAr
c3RhdGljIGludCBnZXRfbGZwc19jeWNsZV9jb3VudChjb25zdCBzdHJ1Y3QgaW50ZWxfY3J0Y19z
dGF0ZQ0KPiAqY3J0Y19zdGF0ZSkNCj4gK3sNCj4gKwkvKiBFeHRlcm5hbCBEUCB1c2VzIGEgbWlu
aW11bSBvZiAxNiBMRlBTIGN5Y2xlcy4gKi8NCg0KSSB0aGluayB0aGlzIGNvbW1lbnQgaXMgdXNl
bGVzcy4gQW55d2F5czoNCg0KUmV2aWV3ZWQtYnk6IEpvdW5pIEjDtmdhbmRlciA8am91bmkuaG9n
YW5kZXJAaW50ZWwuY29tPg0KDQo+ICsJaWYgKCFpbnRlbF9jcnRjX2hhc190eXBlKGNydGNfc3Rh
dGUsIElOVEVMX09VVFBVVF9FRFApKQ0KPiArCQlyZXR1cm4gTEZQU19DWUNMRV9DT1VOVF9EUDsN
Cj4gKw0KPiArCXJldHVybiBMRlBTX0NZQ0xFX0NPVU5UOw0KPiArfQ0KPiArDQo+IMKgc3RhdGlj
IGludCBnZXRfbGZwc19oYWxmX2N5Y2xlX2Nsb2Nrcyhjb25zdCBzdHJ1Y3QgaW50ZWxfY3J0Y19z
dGF0ZQ0KPiAqY3J0Y19zdGF0ZSkNCj4gwqB7DQo+IMKgCXJldHVybiBnZXRfbGZwc19jeWNsZV90
aW1lKGNydGNfc3RhdGUpICogY3J0Y19zdGF0ZS0NCj4gPnBvcnRfY2xvY2sgLyAxMDAwIC8NCj4g
LQkJMTAwMCAvICgyICogTEZQU19DWUNMRV9DT1VOVCk7DQo+ICsJCTEwMDAgLyAoMiAqIGdldF9s
ZnBzX2N5Y2xlX2NvdW50KGNydGNfc3RhdGUpKTsNCj4gwqB9DQo+IMKgDQo+IMKgI2RlZmluZSBN
TF9QSFlfTE9DS19MRU4JCTI1Mg0KPiBAQCAtNzc5LDcgKzc4OSw3IEBAIHZvaWQgaW50ZWxfYWxw
bV9wb3J0X2NvbmZpZ3VyZShzdHJ1Y3QgaW50ZWxfZHANCj4gKmludGVsX2RwLA0KPiDCoAkJCVBP
UlRfQUxQTV9DVExfTUFYX1BIWV9TV0lOR19IT0xEKDApIHwNCj4gwqAJCQlQT1JUX0FMUE1fQ1RM
X1NJTEVOQ0VfUEVSSU9EKA0KPiDCoAkJCQljcnRjX3N0YXRlLQ0KPiA+YWxwbV9zdGF0ZS5zaWxl
bmNlX3BlcmlvZF9zeW1fY2xvY2tzKTsNCj4gLQkJbGZwc19jdGxfdmFsID0NCj4gUE9SVF9BTFBN
X0xGUFNfQ1RMX0xGUFNfQ1lDTEVfQ09VTlQoTEZQU19DWUNMRV9DT1VOVCkgfA0KPiArCQlsZnBz
X2N0bF92YWwgPQ0KPiBQT1JUX0FMUE1fTEZQU19DVExfTEZQU19DWUNMRV9DT1VOVChnZXRfbGZw
c19jeWNsZV9jb3VudChjcnRjX3N0YXRlKSkNCj4gfA0KPiDCoAkJCVBPUlRfQUxQTV9MRlBTX0NU
TF9MRlBTX0hBTEZfQ1lDTEVfRFVSQVRJT04oDQo+IMKgCQkJCWNydGNfc3RhdGUtDQo+ID5hbHBt
X3N0YXRlLmxmcHNfaGFsZl9jeWNsZV9udW1fb2Zfc3ltcykgfA0KPiDCoAkJCVBPUlRfQUxQTV9M
RlBTX0NUTF9GSVJTVF9MRlBTX0hBTEZfQ1lDTEVfRFVSDQo+IEFUSU9OKA0KDQo=
