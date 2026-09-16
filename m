Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD74DC982D2
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 19:10:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D066610E123;
	Wed, 16 Sep 2026 19:10:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="DVoS4n8V";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B894C10E0BD;
 Wed, 16 Sep 2026 19:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789585815; x=1821121815;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ZwuzfajKKiEozVfzmhMjbz16enbE/d6ZqCuWJD+L1nY=;
 b=DVoS4n8VYc01ywZFRJ7QpGjvxdu1Jla/SRmJa0RC6Bq5sCt7RPjPt3kH
 hsm6Y88QOaljm36KTnARHccPegrDWd+fRxRElZSLjWV28MH2Z+X8svJJT
 bMN9LCTWkkiy1gemvlirMl0oXxXC6Fs3SqocF6YJr7H0V7aM0hcg5dQ3r
 n+ivEFo1Ee0riplXsx1PnNb+/Z5kZ21tCaaL84+DfBtD/F71BvfpIUYeo
 ejwXeI7fUVjHZQuyVp5ZjSIiFY1Fd9IgfMLRv5jPPNIUpNdmy2dxHOoi9
 QQcVBeh4gZtGq6/G2XUxvxPVsiYGCCGgiT9xMuLF7VPBTD+rrin9yLk04 g==;
X-CSE-ConnectionGUID: v2TuARwcR36SYhaszubnzQ==
X-CSE-MsgGUID: AYg7KzTfQCu/9KKNW6t9ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="479690"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="479690"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 12:10:15 -0700
X-CSE-ConnectionGUID: mADasuAYRumqnxzUowDwjQ==
X-CSE-MsgGUID: QZJz/07AT8ScRr63o0DQ/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1651666"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 12:10:15 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 12:10:14 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 16 Sep 2026 12:10:14 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.20) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 12:10:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qf61Fq1eeki2N7xkKfRl6zplWjsPtV1+wPpYV8ujcmHW0zfAuQmkxzzKMkOf4dq+7eCPTYNL1/1QVlzdRH/XnUgbZBNeh2QxRIKr4y7blOENs47huMZSgJvGqc419qLGjNjJ6d3QmBS6fD4/odb0Cej7LmZAm2wZ7H6i7GaOMeVmiyNgSiVrkC+N9cKhHS6weC8vYjHe336YhrVJwwL2k82w4+MMC7JM0dhDsFzvIu56pHtct2WzpIBosSTjbgXlv3z9HDaRdQOwssRYTsFL0DnUk9gj7yN+ZZyHULc5SQOiKwdrVDa9Ch9yWFZaixHMg8+LBLXpLxEnaSL7YNBTLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwuzfajKKiEozVfzmhMjbz16enbE/d6ZqCuWJD+L1nY=;
 b=B7L8/btNhcnO4+TjjOQ4Z2IWLV9pmiW42UHC1ynebNVXw3CF5gpwceS8LepzqeLX5ZYjaAbmiklvz83ih0AmawlbquOrKWkjN8AEzq9pnVgUf9LMXjTnnTmZ4XIJpS0v/BO5Txy1qpJTVTcHZSh445dMaxUZwn4gxCPDnBCi3cwPEk2KlW4UlokyJyDxMmsD0Xm/mm1BMOKkDLQIEqIlzFTb6JolM/TusdkaHlnqzoKAhnOKgTOtSrd9xV0xeiqCi8KVC9uFA/zUd5TfJer2xAQnYrg6t8SGj+05Luuovg8jEzOgOGGVApdXNkmXXCFIFU2lcQNBpaARm+iXoQHN3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LVWPR11MB9883.namprd11.prod.outlook.com (2603:10b6:408:3c0::11)
 by MW6PR11MB8338.namprd11.prod.outlook.com (2603:10b6:303:247::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 19:10:11 +0000
Received: from LVWPR11MB9883.namprd11.prod.outlook.com
 ([fe80::310:e83f:69b8:e11e]) by LVWPR11MB9883.namprd11.prod.outlook.com
 ([fe80::310:e83f:69b8:e11e%4]) with mapi id 15.21.0428.009; Wed, 16 Sep 2026
 19:10:11 +0000
From: "Teres Alexis, Alan Previn" <alan.previn.teres.alexis@intel.com>
To: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Nikula, 
 Jani" <jani.nikula@intel.com>, "Roper, Matthew D" <matthew.d.roper@intel.com>
Subject: Re: [PATCH] drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep
 maximums
Thread-Topic: [PATCH] drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep
 maximums
Thread-Index: AQHdRJQayossBqMXeEuwdmvTfN5itbbPQDQAgACNaICAAHK1AIABVHkA
Date: Wed, 16 Sep 2026 19:10:11 +0000
Message-ID: <6f8deb9d5f07feae11f35363e8b22d5ae606e63d.camel@intel.com>
References: <20260914215746.272721-2-alan.previn.teres.alexis@intel.com>
 <683c9836e408389852f6e6e956cc6862b1429b2a@intel.com>
 <145460bc090d7406d03f1335feaadb07172cff20.camel@intel.com>
 <aqnL7lUojj9jm8q_@intel.com>
In-Reply-To: <aqnL7lUojj9jm8q_@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR11MB9883:EE_|MW6PR11MB8338:EE_
x-ms-office365-filtering-correlation-id: eed0e234-f2e7-4054-dce7-08df1426219a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: CMkVY2NOmMNO62l6Z8uawKT9MLGybka3xpZW1OVbugBjLMkLcXzu0QmZLtOj+xvckZ9as8Kh8J0JkishxPXbLSB6Cwb/GWLf9VXGFS6fsTwKIg3tqV9TnfN9vR81NHHIxJWhLAR2sEfK76eygBEMIj2w5Vfb2VLWfRMakRf/Mw9+O+1TOZSiGPmm1LvzPxpNa3pDhgTxRqxYE2NNB2BvS5ElmVdyCqyLLDR7knYGyskm5RcJlFq+30c851Cq8FLnu4e8WevQ+sQDMO6c7yvvY0D2e0wOMMz3NWUIgG6C5L+4lRQL7IKCRkPJSnbzEi0L4uTxLqV2lECs5hxDq1wfhDJVGbErJe34d1YpXn3p/B+dhC47GSLge7x3Dowp+RFYOz0do3+ysatalDsGNK4gcPmW3vViTkCcVBNBFITAVvTd7tEnTmguIAw0jyurOU8Nyq0u2GrxBKTEUIbH3VSkwuQc8h1vNVVdpTx71gbmf1WUKsy3us+b6eZR9EcIwDC60+I4n1pv9rg5uW71iqIq16ZqeFcv2+MCmR3gisis4d621trK9DXLP+h8PQVpsGLZK4nLQYVrwN91GzgmzUg9qGwU6uUgkteflp/ResrkRYzI99AaoxPy/qRnRh74VrW2OevBBuZb+gtQ1ZqnAZIGmviRuxExipbrXPrvPKipBxKl5Lole0FO8tZzbxcKUpPAiZRkO3Z3UvIM9Xkzr8yGI9LKVrAOqPLqxOoqLQmqWoE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LVWPR11MB9883.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFdvS2d1NzU0Z3N3SzdpeExpaHVBSUdKM0UvOXh5UEpja2N6YjhKRHJlRHUw?=
 =?utf-8?B?VU5WdUxXNk5DUGlZR0t6VFhkbGRNdmJCcGhMOENYb25mQmNlUlNVS2l0WW55?=
 =?utf-8?B?MGxLNGt1NEk2SEtmcitITVJRd3NCS25OZk1oQkFxYWJ1NkZESHRuS003QmhR?=
 =?utf-8?B?cHc3ZmdBMllTclJrZ1VwcGswb0Fhc1JQK3IzbmN6cVE5bjhPSS9hMllUSGd3?=
 =?utf-8?B?ZzJEL2k4eW5vRmF4MnA5YkdzNVNLK0czempETThNVjQ5c2ZDbW81VWszUTFo?=
 =?utf-8?B?UDZlREdENGk5NlU4ZW5pY0RkSjBaMkVwY01oZmxVQ2h5TlNGbmVGUzBzVzN1?=
 =?utf-8?B?YjhjUlhHSS9DRjk2RHhuTFR1cWk1WnZvWmNwSHR0RzlZMklmQ2daYXliZ1VZ?=
 =?utf-8?B?eEh5YXZ3cFArWTJMaVA0SnR6akcrT3o0NThHaUtPTkd6NFR2REVoMzlSOG1F?=
 =?utf-8?B?VUM1RkFhMGFUWk4ySUN5YnNoOVVwOGIyT21RZWtBVDVIbjZ4Y2EvV2R5Y3U1?=
 =?utf-8?B?V1cwWllWT2ZwU0l3eGdsUUN1NnpFYjBJcWxIMXliU3F1Yk93RTFob0daRlB1?=
 =?utf-8?B?YVRzZEhRN2VzcHhQYkxBSk5vcTk2YUNtKytnOFZ3N3A2RldEVHBuaGtyK2to?=
 =?utf-8?B?RURzMGhqWkxreWhKWUdoUko2S2dPQThoQ3llSExCYWM4U29qM1NzczZLcTlB?=
 =?utf-8?B?ck1jbFo4b2VyZGhNSk9kdFBLRVoxci91OUdFdHd3aFlRZjlRSGx3ZnV1d2o1?=
 =?utf-8?B?dHlwbzg2Nm1qV3QvQmRIazQ5dGFlVXhuMW5sdmplWUU5MTBIa3A2eXFxUTRQ?=
 =?utf-8?B?MjJZS3lsQWt2WHMxQ25VT1Q2WkV0SUh1WUthR0tyZ0ljelkvK2YyYjNnM1Nt?=
 =?utf-8?B?MS9NSno2MVdoREhHL3Ywb01KNVQ1M0h4RGV3T0NQVFovZmhzeEdsTVVRckh3?=
 =?utf-8?B?c2JNdm5FbUxUTEsyeS94WDRBb3NyOHpxNWxqVXpidGNaaFlKcHRYVEJZeUpm?=
 =?utf-8?B?Nzlram1sQ0dWRGJrRGhyYWFoOFB0ZU1qTVZQeVFKdi9JL2FlQ2FzVjNLSVVU?=
 =?utf-8?B?RTA3b283aTZRQ25ER3NwenhKR0R5Yk9SNENuamdVUjIwOGQ4S3R4UlU4ZUVR?=
 =?utf-8?B?ajRnUlNJYlJyb21POCtVMG1LNmprUWRweDUyUXRhU0JKUUJXbit3ZE1aSURW?=
 =?utf-8?B?SjYzYmJCMEFwcWhadUhleElPMk1CVTI2cTlyOERBTGZUM2kvUGVVM1hodjFu?=
 =?utf-8?B?NjNVZFhVSm02QWVSQ2RXR2RNanZjeDQ2dnV6akc1L0w5alRVNVcvcUM4ZmRx?=
 =?utf-8?B?Si9mcG16QXZJNDlzRGdmUzFPblpKUUtaQVV4cE4xWTZ0dkwxUEEzRXkrUmc2?=
 =?utf-8?B?T01hdXNNMmRxdnFSc2RjYkpSNXY2cVFIa1NzeUVUTXN2QWh6REZ4NEZhU0gr?=
 =?utf-8?B?WXBsaUJmR1VKakNROW1hY3p6MlVHOCtkeFI2RjYvUmVSaHJ5MkJaZ25pNGJ5?=
 =?utf-8?B?NlN5RnFGM0ZxbmFIUXZXQUplb2JxYmZCbnJXczg2eW82UmhPTnk4b09jaHZ5?=
 =?utf-8?B?SjhSK0crYU52eVNFM2Z2b2FIZFVFMVBBKzl5eWMxOGRDTWtIRDhFeWo5aHRI?=
 =?utf-8?B?Ym5zenp1c0pBblF4MU80OEdRcDZWZUE3OEpGVlV6RU1IbFZLOEhWcG9MZnFY?=
 =?utf-8?B?azJJOU83aVJ5T0dJY2d6UVY2YVFDNjNsMUIzUlNkTEE0bWlSM0pySHBHVHlO?=
 =?utf-8?B?SkpJeXM3ZXFIZTNhSDFwYUxSeTFjOTdHaEhybTlrN2RzR1puamxvSnV4em16?=
 =?utf-8?B?R1d3Z1FvKzdDTmVxYW5zaklLNnVwME03T3pxc1RMSTEvOFhTZ2FYVURKUlhY?=
 =?utf-8?B?WDNxd0xUYVlxZThPaTJ2YUt4M2djdlIyZEZ4WUdNUFJIMlBmd0NLeWNYZ2ts?=
 =?utf-8?B?UVNsL2w1bDdnR0V0a0s0Z21yRGlsU2l0Um5RUjdjREJJbUhobVc5dlRZMkQ1?=
 =?utf-8?B?emIwQUNUUFppSi9TdFdCcjdnZmk3ZFBkd1I1clBuUVBzc0gvTXU3ckRNNWc2?=
 =?utf-8?B?c2ExVEw4YS9OS2VFaHJ5eG1pdHphWm84VVpIVjNsS09RbGFuWURlL0JyTWgx?=
 =?utf-8?B?Z2dSSHpobzRqR25LQ0dEUnZDWGZrbXRMYnZMRDVoamh5WVpkUFhVTjBTaGlr?=
 =?utf-8?B?VTdac2E3TG1SR2h5Zm4vZ0Z6ejByVk9tYVovQi9xbzBoYW9RVDljUlBZZ2lw?=
 =?utf-8?B?VGhEeDFGK1IrZVVFekZGSXZSam1VcWZwYzZNalRpaGVGNG04VHNqVmZrMVl5?=
 =?utf-8?B?cy84R0NSS09uUzdZaE5zbnVTRUVZL0hGTHB4ZG9sVTl6Q1d3SzltMGdUVHA1?=
 =?utf-8?Q?30wyFH7Fdh1uyMUrObMvfki2+WPv8x6sTVaWf?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0AAFC1A8156AC746B4B8D608E8A86B6C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HZRB0DtZ3MFZQtU2J+LkDr7oo6lDjFtq5YEVOi0mcuuqKh5PPZqY/05J8ylqn8wISTuNswsITOmQJXOeMjuWHSxAQ2sqVNkuVl87GuEbfrcjRqw1gTdnInAHwuv4g+igOh7udl/3Vo7sx83yXunuJWsp2Z3wiq6qO0rdGHHKli68NgGs+YjUuYr6ppmaWsgFUshKb8UddrAv0Qke/WWKM4olKspcM9ZiIY40vxDmUP6FeicehXDPFlGt5ivCcMA1YA8st8fArrqqLyp9mXjxIQnmNaRV8vW1vGDzJgxT8i0EcEkQ/VdlGdD4cJ5eRV9iLW7AJm5fGNbwYFEJAkWx+w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR11MB9883.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eed0e234-f2e7-4054-dce7-08df1426219a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 19:10:11.4993 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nFV/HHebhYzTVh8oTN1mxTSsYOAu22jxk1v/yDGmaxXOrRNRRXX5iiT8Whe0d1cB0ddAPlSyk8H/0/dpunJdOi3hldiw69m62mmwgaM3EHujzS5k6t9R95IHA28ZGG0l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8338
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

T24gVHVlLCAyMDI2LTA5LTE1IGF0IDE4OjUxIC0wNDAwLCBWaXZpLCBSb2RyaWdvIHdyb3RlOg0K
PiBPbiBUdWUsIFNlcCAxNSwgMjAyNiBhdCAwNDowMDo1NFBNICswMDAwLCBUZXJlcyBBbGV4aXMs
IEFsYW4gUHJldmluIHdyb3RlOg0KPiA+IE9uIFR1ZSwgMjAyNi0wOS0xNSBhdCAxMDozNCArMDMw
MCwgTmlrdWxhLCBKYW5pIHdyb3RlOg0KPiA+ID4gT24gTW9uLCAxNCBTZXAgMjAyNiwgQWxhbiBQ
cmV2aW4gPGFsYW4ucHJldmluLnRlcmVzLmFsZXhpc0BpbnRlbC5jb20+IHdyb3RlOg0KPiA+IGFs
YW46c25pcA0KPiA+ID4gPiAgaW50IHhlX21taW9fd2FpdDMyKHN0cnVjdCB4ZV9tbWlvICptbWlv
LCBzdHJ1Y3QgeGVfcmVnIHJlZywgdTMyIG1hc2ssIHUzMiB2YWwsIHUzMiB0aW1lb3V0X3VzLA0K
PiA+ID4gPiAtCQkgICB1MzIgKm91dF92YWwsIGJvb2wgYXRvbWljKQ0KPiA+ID4gPiArCQkgICB1
MzIgKm91dF92YWwpDQo+ID4gPiA+ICB7DQo+ID4gPiA+IC0JcmV0dXJuIF9feGVfbW1pb193YWl0
MzIobW1pbywgcmVnLCBtYXNrLCB2YWwsIHRpbWVvdXRfdXMsIG91dF92YWwsIGF0b21pYywgdHJ1
ZSk7DQo+ID4gPiA+ICsJdTMyIHJlYWQ7DQo+ID4gPiA+ICsJaW50IHJldDsNCj4gPiA+ID4gKw0K
PiA+ID4gPiArCXJldCA9IHBvbGxfdGltZW91dF91cyhyZWFkID0geGVfbW1pb19yZWFkMzIobW1p
bywgcmVnKSwgKHJlYWQgJiBtYXNrKSA9PSB2YWwsDQo+ID4gPiA+ICsJCQkgICAgICAxMCwgdGlt
ZW91dF91cywgZmFsc2UpOw0KPiA+ID4gDQo+ID4gPiBZb3UgcHJvYmFibHkgZG8gbmVlZCB0byBs
ZXQgdGhlIGNhbGxlcnMgcGFzcyBpbiB0aGUgd2FpdCB0b28uIDEwIHVzIHdhaXQNCj4gPiA+IHdp
dGggYSBsb25nIHRpbWVvdXQgaXMgZ29pbmcgdG8gYmUgcHJldHR5IGJhZC4NCj4gDQo+IGFncmVl
ZA0KPiANCj4gPiA+IA0KPiA+ID4gDQo+ID4gYWxhbjogb2theSAtIHBlcmhhcHMgaSBjYW4gbWFr
ZSBldmVyeSBjYWxsZXIgcGFzcyBpbiBhIHBvbGxpbmctd2FpdCB0aGF0cyBhIGZyYWN0aW9uIG9m
IHRoZWlyIHdhaXQgdGltZS4NCj4gPiAoYXMgYSBzdGFydGluZyBwb2ludCBzaW5jZSBpIGRvbnQg
a25vdyB3aGF0J3MgdGhlIGV4cGVjdGVkIGJlaGF2aW9yIG9mIGV2ZXJ5IGNhbGxlcikuDQo+ID4g
c28gcGVyaGFwcyBzb21ldGhpbmcgbGlrZSAidGltZW91dF91cyA8PCA0IiAoaS5lLiAxLzE2dGgp
IGJ1dCBwYXNzIGluIDEwIHVzIGlmIGl0cyBhbnl0aGluZyBzbWFsbGVyIHRoYW4gdGhhdA0KPiA+
IChpLmUuIHNtYWxsZXIgdGhhbiAxNiB1c2VjKS4NCj4gDQo+IEkgdGhpbmsgd2UgbWlnaHQgYmUg
Y29tcGxpY2F0aW5nIHRoaXMgdG9vIG11Y2guLg0KPiANCj4gd2hhdCBhYm91dCBzb21ldGhpbmcg
c2ltcGxlciBsaWtlOg0KPiANCj4gI2RlZmluZSBYRV9NTUlPX1dBSVRfTUFYX0JBQ0tPRkZfVVMg
ICAxMDAwDQo+IA0KPiAuLi4NCj4gLSAgICAgICAgICAgICB3YWl0IDw8PSAxOw0KPiArICAgICAg
ICAgICAgIHdhaXQgPSBtaW5fdChzNjQsIHdhaXQgPDwgMSwgWEVfTU1JT19XQUlUX01BWF9CQUNL
T0ZGX1VTKTsNCj4gDQo+IA0KDQphbGFuOiBpIGRvbnQgdW5kZXJzdGFuZCB5b3VyIHRoaXMgY29t
bWVudCBvbiB0aGUgaW5jcmVhc2luZyB0aGUgIndhaXQgYnkgeDIiIGluIHRoZSBsb29wIGFmdGVy
IGFncmVlaW5nIHdpdGggSmFuaSBvbiB0aGUgZWFybGllciBzdGF0ZW1lbnQuDQpTb21lIGhpc3Rv
cmljYWwgY29udGV4dDoNCg0KIDEuIGN1cnJlbnQgYmFzZWxpbmUgY29kZSBpdCBzdGFuZHMgdG8g
ZGF5IElTIGluIHZpb2xhdGlvbiBvZiBsaW51eCBydWxlcyBmb3IgaG93IHRvIHVzZSB0aG9zZSBz
bGVlcC9kZWxheSBmdW5jdGlvbnMNCiAyLiBteSBpbml0aWFsIHJldnMgb24gZml4aW5nIHRoaXMg
d2FzIHRvIG1pbmltaXplIHRoZSBjaGFuZ2VzIHNvIGl0cyBub3QgY29tcGxpY2F0ZWQgYnkgc2lt
cGx5IGZpeGluZyB0aGUgY29kZSBpbiBwbGFjZS4NCiAzLiBKYW5pIHNhaWQgd2UgcmVhbGx5IHNo
b3VsZCB1c2UgdGhlIHByb3BlciBsaW51eCBrZXJuZWwgaGVscGVyczogcG9sbF90aW1lb3V0X3Vz
IC8gcG9sbF90aW1lb3V0X3VzX2F0b21pYy4NCiA0LiBUaG9zZSBoZWxwZXJzIGhhdmUgdGhlICJ0
aW1lb3V0X3VzIiBhbmQgdGhlICJpbnRyYS1sb29wLXdhaXQtdXMiIHBlcmlvZC4gSSBoYXJkY29k
ZWQgdG8gMTAgdXNlYy4NCgktIEphbmkgc2FpZCBpIHNob3VsZCBub3QgaGFyZGNvZGUgYW5kIGVu
c3VyZSBhbGwgdXAtdGhlLXN0YWNrIGNhbGxlcnMgb2YgdGhlIHhlX21taW9fd2FpdDMyIGZ1bmN0
aW9uIHBhc3NlcyBpbiB0aGUgaW50cmEtd2FpdC1sb29wDQp2YWx1ZS4gDQoJLSBUaGVuIHlvdSAo
Um9kcmlnbykgYWdyZWVkIHdpdGggaGlzIHJlcXVlc3QgYnV0IGdvIG9uIHRvIHByb3Bvc2UgZ29p
bmcgYmFjayB0byBleHBvbmVudGlhbCAyeCBpbnRyYS13YWl0LWxvb3AuDQoJCS0gYnV0IHRoYXQg
Y29udHJhZGljdHMgSmFuaSdzIHJlcXVlc3QgdSBhZ3JlZWQgdG8gYW5kIGFsc28gdGhhdCBtZWFu
cyB3ZSBpbXBsZW1lbnQgdGhlIGludHJhLXdhaXQtbG9vcD8gKGkuZS4gZG9udCB1c2UgdGhlDQpw
cm9wZXIgbGludXggaGVscGVyPykNCg0KIC4uLmFsYW4NCg0KDQo+IEFsc28gdGhlIEZpeGVzIHRh
ZyBpcyBub3QgdGhlIHJpZ2h0IG9uZS4uLiB0aGUgYnVnIHdhcyB0aGVyZSBiZWZvcmUuLi4NCj4g
DQo+ID4gDQo+ID4gLi4uYWxhbg0KDQo=
