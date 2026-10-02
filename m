Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C79CA5FE1
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 05:04:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AB5910E4D9;
	Fri,  2 Oct 2026 05:04:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="DMRxjKXf";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90A4810E190;
 Fri,  2 Oct 2026 05:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790917464; x=1822453464;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=H+kaez2z/SocLvFOpV8Hxr+hryyngh4r+aKhZA1KmuI=;
 b=DMRxjKXfmdx4plnDbdeblZjcTw3Z4uqNvzoihTjmLwNDb2UR6mOWsS5x
 byw98xG5XN8zvQe4C0gOIsZLcjMc+iXyPRf4dFlsmTL7Gvgreoeb/U9S5
 AzSBeZ490/cqFuxv5yZ/vixRTqPh6H7poDVC0ESPxe8vyYfFRj3+pzAh5
 hOXA9z1a60NMqWe8OLdo+fBIvQwZhdPmh5FquUpb7Jn0Ak1Wg4V/pm9yX
 zVkXONxLlAdyZgGhp40QWyJcCjOJqEm0C+6GR4jW81vM5G4uM30meVKWG
 WvMbuEPtcOMlQvKPhIwmxnAqq5TG7nOqReksBxvQxoxM00+MdaNHFchBl g==;
X-CSE-ConnectionGUID: zsNUfAxNSUWC2bGwPur64w==
X-CSE-MsgGUID: 1bJlLgWaSyWNBWLY7cywgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="103058274"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="103058274"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 22:04:24 -0700
X-CSE-ConnectionGUID: SioysCOSQnWEzQ/LP5y7gg==
X-CSE-MsgGUID: qTszPZhoSt20/+jFC5ERig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="279466106"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 22:04:25 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 22:04:08 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 22:04:08 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.24) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 22:04:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4VOozKb99UxSEsvya27xLjIEwCKRBwlMrj6jUYYZ2fC2FhD2H7TDWQUGEJ/6Fs5NrQ7Dp7u9u3JMKLdpcmgFQR1fHwbd6/eX2L3Rj3gg7r8JLzxK9N0If70RlxlaTBDrIwShntMA5IkRH5EsRT6fQ2aJmj8Pk9dW2545682E/Il1IBPfCArPPRgXXw+5nIbKP4d5Mz+k8g+q9WX4FNtj2c82m2H10QEQLGLUQA1P9pUul7xG7I/JvjuM/v/zwVqEVDo68FYTRmidNY7qEXVwtWDxbN2Rw7YVx0sxYur0dGNzuRhvMtUJViovfbuPn2oTlvoFmOn0X8GbGdtJMRC+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+kaez2z/SocLvFOpV8Hxr+hryyngh4r+aKhZA1KmuI=;
 b=E7uMdC766A0RYUDz8QLgnFv+YedRfrUiu3IDr8jfTh1F2XiZbZdSMY+rsLzrEj4SLPuVllxYPFU5MZppYGBXsrb+45pdRVm7VjBqvf++Y6XIlfjegHIq4ive9KR30hS5pxXCe4qy/Xj0JXiU2PQEIzLXvKuHupQM4FLR88MyDAcKD5bFqus+TyVxOq3V1/eLRAApB6ozVKauVaulT0L8gzG1IZ/WkXTZUsqHrI08OGBvADPMDw/vG0h//tSiExrgjLKOswG9A+A+xNHl8vM+uuzR0bosbWJFMSwEeBNdA+1Qjiq1j33o4/2jqzersyCMjpfo7wNlMb5JHs7GPNlfJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6019.namprd11.prod.outlook.com (2603:10b6:8:60::5) by
 PH0PR11MB7588.namprd11.prod.outlook.com (2603:10b6:510:28b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Fri, 2 Oct
 2026 05:04:04 +0000
Received: from DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762]) by DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762%6]) with mapi id 15.21.0472.015; Fri, 2 Oct 2026
 05:04:04 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Manna,
 Animesh" <animesh.manna@intel.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>
CC: "Kandpal, Suraj" <suraj.kandpal@intel.com>, "Nikula, Jani"
 <jani.nikula@intel.com>
Subject: Re: [PATCH v6 13/18] drm/i915/alpm: Enable MAC Transmitting LFPS for
 LT PHY
Thread-Topic: [PATCH v6 13/18] drm/i915/alpm: Enable MAC Transmitting LFPS for
 LT PHY
Thread-Index: AQHdRUGaTYS4Ojw4UUK0cC66JZPwjLbpzF+A
Date: Fri, 2 Oct 2026 05:04:04 +0000
Message-ID: <8c19d9a50f5d86f6b12be333d2f3894d68334fe5.camel@intel.com>
References: <20260915180449.277933-1-animesh.manna@intel.com>
 <20260915180449.277933-14-animesh.manna@intel.com>
In-Reply-To: <20260915180449.277933-14-animesh.manna@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6019:EE_|PH0PR11MB7588:EE_
x-ms-office365-filtering-correlation-id: fa638f2c-a27d-44bb-ca4e-08df204294d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|38070700021|4143699003|260925022911599003|260925021311599003|260925021911599003|56012099006|10067099003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: E1pSVlgLBI9Abu7+PkpTIsvtBfyyOG5Cldsluc/a0lcxMEOPWrZtgZCx7wWc+RIOLV7izsmLKNTsqSiNEdhTGbcxezHov+Ki5eZNzCnZsfUAMA+XP8wUCevYhdf2Dhc53ehH+aK9OxMlm8A88SJ9bU3HGAPFIiieqneHQ8begQIkz62et/hGbi+0+LDLRCk23gBiVeWkDZQqxT5R8zXRzKhzlWrnC5BiWZZo2Q6O9d8u0v9VeDOPL0aHcyjUYLy/SPkWnZEUEYz7XKNyRB43dcxfwVPxnugLiX9MfXNavnUm+cgOJjmxgKKa8pHjJ0kd0PZGHnEHN5PqG13EMH5OgduE8gBUFATv/4rgcjPmiA8uqXVacUlnl01lDMETjy/3b2okou3cAYPXXq0SN82nAj1A7iM7Cd3A4taDg110I5cWD1o8DaFlnF+3CiM1Ita8dJLxdud4ZRWCxsGrZjKTWOkw0L61pF9k9t7ETbt0Vn8MVxRa8ldsaPorSU2oxYVbtGFX52nqL6eFiuTdfwUYn3fYbGTJGT2RQaEXGWZtu24tCwn5I+mUWR/YpN9Tb6RQqlvQqNWBo7X4mV7VlWZerblIib2jM6+hB6QYcC0mRWqb/x86p/vt7zhwVXpj5vzV4VUsVslQtpN6kUdTVjyaZlwqpDOJC+O8IFs1WIpwojptGJpXqPyaVODmsVynhlxdOI4oPp1CEh9uMn4EVXWu2dZeE+5llukRujD+FqVCLcI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6019.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(4143699003)(260925022911599003)(260925021311599003)(260925021911599003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2F1NCtPUW40aG5taXpqS2gzMHYwUVE5UncwZisySTB0akdkaDl0ZS9Wek04?=
 =?utf-8?B?U0tEcUFsc3ZiYmZrNExTNXhXZzhEQlZ4cnZyS2wxNm9Xa3FBY0xsNFhYQjhS?=
 =?utf-8?B?bjJaYlh0ZEx4d2xvYmE2VzBPVEplSW5jZ3g1eGFSckZ2Z09rcG1PSTgrc0c2?=
 =?utf-8?B?dmJ2Ky9xcWN5Q2dXWFYvUUdVV1lGSUdHRDAvR3hZeHM0QUJ4UjJaTDMybTRM?=
 =?utf-8?B?M1UrNGR3dWVJSUJ2NWhDWjVRbEtseEpRK3RCYjNNNVJhbEJOeXR6N29CUkJF?=
 =?utf-8?B?R0JIemRPWW4zV082ekRMK1ZqWFhWKzIvTEpTWjllcktTcC9lUWxoUkVxaXY1?=
 =?utf-8?B?dVkzUGIySmNjZjhRUzJjZWRTTTRyUTFYVDMxNm4zWVU0UG9wN25jcGRyR3NW?=
 =?utf-8?B?K3ZUZ1lXWnQwbTYxSXIrb1FBd0NZVmplWEd2YncvMEdpdGhkNVpCOWlhZmtz?=
 =?utf-8?B?czdyK0xBck8rSHpObnhPa2ZlUnZkMjdZWGdQV3BIa3BjZ21FdDhabFpOc2RK?=
 =?utf-8?B?VHEyMTZvc0NwYy94RnVmbThDQ3NDc1F3eGowaXpyTnpkNVVaMTlrSTlzMUZk?=
 =?utf-8?B?bG80NmI0TmJ4SGZtODhIbTBUbVdIazlwR3NKRENWUzlOUVFab0J4aXdwQTFK?=
 =?utf-8?B?WDVjNzVUSUg1TjVmRGxacFVyTjFIek9xbkR5Y0dydUxjb3pRR2d6N1VQZ2NM?=
 =?utf-8?B?d0FHRG94ejdRYWVRamQ2N1NvQ0ZOSU50ZVZuaGQ0SkZYRjU4VU5SSUt5WmFk?=
 =?utf-8?B?K2tLVklDYzJSLys3RVc3RFZMZHhnRG11Rmt0a0RxNkxpeWNvQW4ydEdBTm10?=
 =?utf-8?B?WGptMDl4eWwvcWZsc1RkV2RaSEtZN2hNQll6VHc2blJmR3N5bnhEQ1RFVGVL?=
 =?utf-8?B?UUtTNUUrSlFna25iYUl2U3U1dkw2ZTEyTVBlWm9sVlBxMkJPQTV4dDMzWVR4?=
 =?utf-8?B?QzhYUy9HL1AxT3RKMGIwU2hpZVdJeDl3MWFNNnNhbG50dWpaZHBGQ0lpL1lk?=
 =?utf-8?B?ZGxLYVo5UDdkUUVNOENCUTJ6Y00wNmJJTEd5M3BVY3o3R1p0WVpqSGlWUVJv?=
 =?utf-8?B?ejVuL3dPUStJWDlveVJmbzdIbWxmWkZFMC9HOUY3Tjdab3pmVzU4eVB6ZFZs?=
 =?utf-8?B?TVB0a1lWZ0VFSzhvdTRhNWdndmdHVytScVZqNzA4dVpFUXZzR0craGY0K3Bl?=
 =?utf-8?B?VThxcjlYNFpHYmM3eVQxUDJrTWJWNzFwa3NwNDBGeGs1Zi9vUGg2UllLVkdj?=
 =?utf-8?B?VjZvQnY5cFV3OUp2S2xPakw4NitlY0dLVktWTDhESExpdnByY01NcndBdXdV?=
 =?utf-8?B?OHR1UDFVZnloK3NCK0ZyeE9FSFlDY3ZaQkYvNUtranJJMCtOY2pFVm9IZW03?=
 =?utf-8?B?YWZMSDFTVTd6eEZtS2k3Vnc5dlgzalB6WmQ4ekpGMUViRGV0bzZBMm9UbXIv?=
 =?utf-8?B?RjFmQ0MvN2Z3UEQ3Y2diM1hIOTNXeUN5QWlMNXdlK0xpUTlLam5yVks4bndy?=
 =?utf-8?B?MWVzb3VaY2h3SDJjaWRRS0hUUHk0Q21WN0dqc0Z4a0dDVDQzWE4zakJLKzZa?=
 =?utf-8?B?emxYUms0K0Q2VUdNU0xSdzhLTjVMR2E1UXlZT1Z2NEplaGlRTTNVbDVnV1Vn?=
 =?utf-8?B?TjRUYkg4bzVWRmhFaG43VENYaVVMcTRvcnFXLzNEL1N5UEhidTgxZTN1L01L?=
 =?utf-8?B?TCtsQXNSWmZDOW5nNlY1aGFCMTVRZXlSUmZKYlFZN2F0Mk5XWUVUZEYvSjIx?=
 =?utf-8?B?M0o3Qll3M1AxcWZTM3JwRWxFM2daejE3Yms4SktST045cFMyejQvMUpsTjNl?=
 =?utf-8?B?WXhqRUt4V0Y1blltYUtIZnVUMXQvaWdreFlwRDFyM3E3dEQwR0pUcVJGVk5v?=
 =?utf-8?B?M0hiSmpjYkpFVEE5VjJVUkJucUFMMks0VGhOdGpMN2RxZGtNVjBtMzdienVG?=
 =?utf-8?B?aVFickxvRm1naTFqZFpTem42MWhhZHBwTTJRU3J5Zi9jSVVkUzJhcU1LYjFB?=
 =?utf-8?B?cVg3ai9UTDZ4Vm1tcXA0ZG1CQXY4bTFkM204NnRwQlVSRFNMcEx6VmFrcFFJ?=
 =?utf-8?B?ekRCaW1Qc28zSWdXRXFVWEdDYUgraVZ4WnV3c0ZTMG8zMmtYbHdJRm9HVUhu?=
 =?utf-8?B?NmZGSEhWRXp1dGFhWFluY1F6b0hHUkRTdU0zM1VycFE1STlwTTd6UllnbXpE?=
 =?utf-8?B?RFhad3ZKOHlUTzlnTTRIMHpvci9pN0JWOTg5bE9tMnZGcDBPbWo5bFdLM2Nv?=
 =?utf-8?B?bS9maDJDTnN5YXlEemVrNXEvMFlMbjN1bDhxZ2VlcG9FeHV3bGFJWjhjQ3FK?=
 =?utf-8?B?NW5ycWF1aUZJOTBPdFEvT1ZaQktMVitTVld3WEo4Q3ozVG1QTFhQd1M2bnov?=
 =?utf-8?Q?ibM4ePZZDOiwSlEk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <78AA4B4145D70D4BAA69839DE324A250@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hkRrtn71SRcq52kdAHUmMlI+cTIC7mF84XZ3xT2G3X34+gp6tmscrJB4wOq5bywmX2UQrWD574GUG+E/rMKJAxHnbe1Swm/aJAWoyhK4Kl8Ru4GbWjBgvMoQPOsX/H48IZN1eUh7JllbFynkkyT7ksfGMyOT4NGwAkyBysiTYPLo5H30VGxre+4c81xAtQGpOEL4CDwquTWdg9ZH7AjNLMA5SgDA96AhWshJMFqCvvfai3iioZzTOP/QGY8v2I9OutR36DkQf4UOM8dOjhzIvlsw1BW2/KbQKHwYtV+4P0iURoL/rWmIgxs0Kj5hRvyz0nOaDMp9tN8SUSvFz14CJA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa638f2c-a27d-44bb-ca4e-08df204294d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2026 05:04:04.6806 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SOAwvKGRbRLbCNi7jGAmSbgY/2FAqGmBO4WvgHjC+iOywqVS0791JKtzwwO00+hvWO6/kdjUWLa5yhpS/CWF97SlYSum+wb5r6vFfzM4PHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7588
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
PiBFbmFibGUgTUFDIHRvIHRyYW5zbWl0IExGUFMgdmlhIExUIFBIWSBkdXJpbmcgYXV4LWxlc3Mg
YWxwbS4NCj4gDQo+IHYyOg0KPiAtIENvcnJlY3QgY29tbWl0IGRlc2NyaXB0aW9uLiBbU3VyYWpd
DQo+IC0gUmVtb3ZlIGxvb3AgYXMgbm8gZGVwZW5kZW5jeSBvbiB0aGUgdHJhbnNtaXR0ZXIgTFRf
UEhZX0NNTl9DVEwwLg0KPiBbU3VyYWpdDQo+IHYzOiBDb3NtZXRpYyBjaGFuZ2VzLiBbU3VyYWpd
DQo+IA0KQnNwZWMgcmVmZXJlbmNlLg0KDQo+IENjOiBKb3VuaSBIw7ZnYW5kZXIgPGpvdW5pLmhv
Z2FuZGVyQGludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFN1cmFqIEthbmRwYWwgPHN1cmFqLmth
bmRwYWxAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbmltZXNoIE1hbm5hIDxhbmltZXNo
Lm1hbm5hQGludGVsLmNvbT4NCj4gLS0tDQo+IMKgZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxh
eS9pbnRlbF9kZGkuY8KgwqDCoMKgwqAgfMKgIDUgKysrLQ0KPiDCoGRyaXZlcnMvZ3B1L2RybS9p
OTE1L2Rpc3BsYXkvaW50ZWxfbHRfcGh5LmPCoMKgIHwgMjcNCj4gKysrKysrKysrKysrKysrKysr
Kw0KPiDCoGRyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfbHRfcGh5LmjCoMKgIHzC
oCAyICsrDQo+IMKgLi4uL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2x0X3BoeV9yZWdzLmjC
oCB8wqAgMyArKysNCj4gwqA0IGZpbGVzIGNoYW5nZWQsIDM2IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5
L2ludGVsX2RkaS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9kZGku
Yw0KPiBpbmRleCA5YjNiNTI2ZTVlNTUuLjUyNDQyMTgxMzJhYSAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9kZGkuYw0KPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2RkaS5jDQo+IEBAIC0zNzk2LDcgKzM3OTYsMTAgQEAg
c3RhdGljIHZvaWQNCj4gbXRsX2RkaV9wcmVwYXJlX2xpbmtfcmV0cmFpbihzdHJ1Y3QgaW50ZWxf
ZHAgKmludGVsX2RwLA0KPiDCoAkgKsKgwqDCoMKgIGlpLiBFbmFibGUgTUFDIFRyYW5zbWl0cyBM
RlBTIGluIHRoZSAiUEhZIENvbW1vbg0KPiBDb250cm9sIDAiIFBJUEUNCj4gwqAJICrCoMKgwqDC
oMKgwqDCoMKgIHJlZ2lzdGVyDQo+IMKgCSAqLw0KPiAtCWludGVsX2xubF9tYWNfdHJhbnNtaXRf
bGZwcyhlbmNvZGVyLCBjcnRjX3N0YXRlKTsNCj4gKwlpZiAoSEFTX0xUX1BIWShkaXNwbGF5KSkN
Cj4gKwkJaW50ZWxfeGUzcGxwZF9tYWNfdHJhbnNtaXRfbGZwcyhlbmNvZGVyLA0KPiBjcnRjX3N0
YXRlKTsNCg0KTWF5YmUgYmV0dGVyIHByZWZpeCBmb3IgdGhpcyB3b3VsZCBiZSBpbnRlbF9sdF9t
YWNfKg0KDQo+ICsJZWxzZQ0KPiArCQlpbnRlbF9sbmxfbWFjX3RyYW5zbWl0X2xmcHMoZW5jb2Rl
ciwgY3J0Y19zdGF0ZSk7DQo+IMKgfQ0KPiDCoA0KPiDCoHN0YXRpYyB2b2lkIGludGVsX2RkaV9w
cmVwYXJlX2xpbmtfcmV0cmFpbihzdHJ1Y3QgaW50ZWxfZHANCj4gKmludGVsX2RwLA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9sdF9waHkuYw0KPiBi
L2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfbHRfcGh5LmMNCj4gaW5kZXggODY0
OTI2NTFiMDFkLi40ZmUwMTBkZjIwYmUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9p
OTE1L2Rpc3BsYXkvaW50ZWxfbHRfcGh5LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUv
ZGlzcGxheS9pbnRlbF9sdF9waHkuYw0KPiBAQCAtNSw2ICs1LDcgQEANCj4gwqANCj4gwqAjaW5j
bHVkZSA8ZHJtL2RybV9wcmludC5oPg0KPiDCoA0KPiArI2luY2x1ZGUgImludGVsX2FscG0uaCIN
Cj4gwqAjaW5jbHVkZSAiaW50ZWxfY3gwX3BoeS5oIg0KPiDCoCNpbmNsdWRlICJpbnRlbF9jeDBf
cGh5X3JlZ3MuaCINCj4gwqAjaW5jbHVkZSAiaW50ZWxfZGRpLmgiDQo+IEBAIC0yMzU3LDMgKzIz
NTgsMjkgQEAgdm9pZCBpbnRlbF9sdF9waHlfdmVyaWZ5X3BsbHMoc3RydWN0DQo+IGludGVsX2Rp
c3BsYXkgKmRpc3BsYXkpDQo+IMKgCWludGVsX2x0X3BoeV9wbGxfdmVyaWZ5X3RhYmxlcyhkaXNw
bGF5LA0KPiB4ZTNwbHBkX2x0X2VkcF90YWJsZXMpOw0KPiDCoAlpbnRlbF9sdF9waHlfcGxsX3Zl
cmlmeV90YWJsZXMoZGlzcGxheSwNCj4geGUzcGxwZF9sdF9oZG1pX3RhYmxlcyk7DQo+IMKgfQ0K
PiArDQo+ICsvKg0KPiArICogQWNjb3JkaW5nIHRvIEhBUyB3ZSBuZWVkIHRvIGVuYWJsZSBNQUMg
VHJhbnNtaXR0aW5nIExGUFMgaW4gdGhlDQo+ICJQSFkgQ29tbW9uDQo+ICsgKiBDb250cm9sIDAi
IFBJUEUgcmVnaXN0ZXIgaW4gY2FzZSBvZiBBVVggTGVzcyBBTFBNIGlzIGdvaW5nIHRvIGJlDQo+
IHVzZWQuIFRoaXMNCj4gKyAqIGZ1bmN0aW9uIGlzIGRvaW5nIHRoYXQgYW5kIGlzIGNhbGxlZCBi
eSBsaW5rIHJldHJhaW4gc2VxdWVuY2UuDQo+ICsgKi8NCj4gK3ZvaWQgaW50ZWxfeGUzcGxwZF9t
YWNfdHJhbnNtaXRfbGZwcyhzdHJ1Y3QgaW50ZWxfZW5jb2RlciAqZW5jb2RlciwNCj4gKwkJCQnC
oMKgwqDCoCBjb25zdCBzdHJ1Y3QgaW50ZWxfY3J0Y19zdGF0ZQ0KPiAqY3J0Y19zdGF0ZSkNCj4g
K3sNCj4gKwlzdHJ1Y3QgaW50ZWxfZHAgKmludGVsX2RwID0gZW5jX3RvX2ludGVsX2RwKGVuY29k
ZXIpOw0KPiArCXN0cnVjdCByZWZfdHJhY2tlciAqd2FrZXJlZjsNCj4gKwl1OCBvd25lZF9sYW5l
X21hc2s7DQo+ICsNCj4gKwlpZiAoIWludGVsX2FscG1faXNfYWxwbV9hdXhfbGVzcyhpbnRlbF9k
cCwgY3J0Y19zdGF0ZSkpDQo+ICsJCXJldHVybjsNCg0KWW91IHNob3VsZCBhbHNvIGNoZWNrIGFs
cG0gb3IgbW9kaWZ5IGludGVsX2FscG1faXNfYWxwbV9hdXhfbGVzcy4NCg0KPiArDQo+ICsJd2Fr
ZXJlZiA9IGludGVsX2x0X3BoeV90cmFuc2FjdGlvbl9iZWdpbihlbmNvZGVyKTsNCj4gKw0KPiAr
CW93bmVkX2xhbmVfbWFzayA9IGludGVsX2x0X3BoeV9nZXRfb3duZWRfbGFuZV9tYXNrKGVuY29k
ZXIpOw0KPiArDQo+ICsJaW50ZWxfbHRfcGh5X3JtdyhlbmNvZGVyLCBvd25lZF9sYW5lX21hc2ss
IExUX1BIWV9DTU5fQ1RMXzAsDQo+ICsJCQkgTFRfUEhZX0NNTl9MRlBTX0VOQUJMRSwNCj4gKwkJ
CSBMVF9QSFlfQ01OX0xGUFNfRU5BQkxFLA0KPiBNQl9XUklURV9DT01NSVRURUQpOw0KPiArDQo+
ICsJaW50ZWxfbHRfcGh5X3RyYW5zYWN0aW9uX2VuZChlbmNvZGVyLCB3YWtlcmVmKTsNCj4gK30N
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfbHRfcGh5
LmgNCj4gYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2x0X3BoeS5oDQo+IGlu
ZGV4IDE2ZGUzOTQ4NDc3OS4uYzc2Yzk3YjkwOTQ2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2x0X3BoeS5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9pOTE1L2Rpc3BsYXkvaW50ZWxfbHRfcGh5LmgNCj4gQEAgLTQ5LDUgKzQ5LDcgQEAgdm9pZCBp
bnRlbF94ZTNwbHBkX3BsbF9lbmFibGUoc3RydWN0IGludGVsX2VuY29kZXINCj4gKmVuY29kZXIs
DQo+IMKgCQkJwqDCoMKgwqDCoCBjb25zdCBzdHJ1Y3QgaW50ZWxfZHBsbF9od19zdGF0ZQ0KPiAq
ZHBsbF9od19zdGF0ZSk7DQo+IMKgdm9pZCBpbnRlbF94ZTNwbHBkX3BsbF9kaXNhYmxlKHN0cnVj
dCBpbnRlbF9lbmNvZGVyICplbmNvZGVyKTsNCj4gwqB2b2lkIGludGVsX2x0X3BoeV92ZXJpZnlf
cGxscyhzdHJ1Y3QgaW50ZWxfZGlzcGxheSAqZGlzcGxheSk7DQo+ICt2b2lkIGludGVsX3hlM3Bs
cGRfbWFjX3RyYW5zbWl0X2xmcHMoc3RydWN0IGludGVsX2VuY29kZXIgKmVuY29kZXIsDQo+ICsJ
CQkJwqDCoMKgwqAgY29uc3Qgc3RydWN0IGludGVsX2NydGNfc3RhdGUNCj4gKmNydGNfc3RhdGUp
Ow0KPiDCoA0KPiDCoCNlbmRpZiAvKiBfX0lOVEVMX0xUX1BIWV9IX18gKi8NCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfbHRfcGh5X3JlZ3MuaA0KPiBi
L2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfbHRfcGh5X3JlZ3MuaA0KPiBpbmRl
eCBmZjZkNzgyOWRiYjkuLmI2NGZmNTdlMGMwOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9sdF9waHlfcmVncy5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfbHRfcGh5X3JlZ3MuaA0KPiBAQCAtMzUsNiArMzUsOSBA
QA0KPiDCoCNkZWZpbmUgTFRfUEhZX1RYWV9DVEwxMF9NQUMoaWR4KQlfTU1JTyhMVF9QSFlfVFhZ
X0NUTDEwKGlkeCkpDQo+IMKgI2RlZmluZcKgIExUX1BIWV9UWF9MQU5FX0VOQUJMRQkJUkVHX0JJ
VDgoMCkNCj4gwqANCj4gKyNkZWZpbmUgTFRfUEhZX0NNTl9DVExfMAkJKDB4ODAwKQ0KPiArI2Rl
ZmluZcKgIExUX1BIWV9DTU5fTEZQU19FTkFCTEUJCVJFR19CSVQ4KDEpDQoNCkxUX1BIWV9DTU5f
TUFDX1RSQU5TTUlUX0xGUFMgd291bGQgYmV0dGVyIGZvbGxvdyB3aGF0IGlzIGluIEJzcGVjLg0K
DQpCUiwNCkpvdW5pIEjDtmdhbmRlcg0KDQo+ICsNCj4gwqAvKiBMVCBQaHkgVmVuZG9yIFJlZ2lz
dGVyICovDQo+IMKgI2RlZmluZSBMVF9QSFlfVkRSXzBfQ09ORklHCTB4QzAyDQo+IMKgI2RlZmlu
ZcKgIExUX1BIWV9WRFJfRFBfUExMX0VOQUJMRQlSRUdfQklUKDcpDQoNCg==
