Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A967CA5FA7
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 19:09:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7FFE10F05F;
	Tue, 29 Sep 2026 19:09:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Gh8286lb";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4631E10F05D;
 Tue, 29 Sep 2026 19:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790708953; x=1822244953;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=VzhwFrw7tV1nlGW5ZSHMi1NCo+H8SgT/8nRcGeUvwm0=;
 b=Gh8286lbvUdH+0EO1OKdY7AuOhm6m3jYG0B70uJ96FfqCPmIMu97Xa5J
 e1JVqlw1a05ibR4CvdN+tn01O5tIaTs9h9kFPAAsY4nkOYFidktI0rDLL
 ygub9bMAULHSRANwCeYNNG9A632KyGiISGFpu8s/VXa+Ens+Wr4jbDOWp
 Jb6kC1sTPt+oIP5ncfdrtZrzIe/VMNWtkFn5SMpQUscrEbRqUKcdyZupe
 NGPpuih2juZBdaLTNpT4U7R4mcO/tkmEFtCgWJ26Xluc6CWygHjWgQZ3H
 lXasathEvjPC3W1WjnkHAa5lD+ZC3g+b3p+L+scAawbDyL+28kxMPDbFy Q==;
X-CSE-ConnectionGUID: dQzjxfO9R0WqtNsi6w8UGg==
X-CSE-MsgGUID: 7bcMlWKOT6O9GeTTAFYtlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90481566"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="90481566"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 12:09:12 -0700
X-CSE-ConnectionGUID: /Kbz9kRFR5KcXYjkMBsJOQ==
X-CSE-MsgGUID: uG48jDNkTEm6Htsk4+7QiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="273233685"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 12:09:12 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 12:09:11 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 12:09:11 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.47)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 12:09:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cp9VV9cxZCMS/nHPkI7uATVkLu/1OwC6+GzB2k0wKgyDJ7P1WWekOehjckZCE1sdQJl/Lv6eLcIcfDFXQvKrb5q4ntfZnHC2Hj7qsXFOJpItDc2n/gWBddmVelW/GbK07FK2taCSHgDvlrarlhmAXRazIzGM8QwKdt32bHcfOmIS5V8GouXC+I3p9l+o39h/ArGEpgkF0I5ziYd491GLqZCuBUO1nUBLu+JhZi6b813ynInExIzuufw7pUYZPKEPQVJMVv1oLB5ufJMncMbkOsr3qoMCDUXK95LED4yROOxBfkkirIzKfk+9rI7BGkzIEb9MmS3BYZQUA9aJBbxc/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VzhwFrw7tV1nlGW5ZSHMi1NCo+H8SgT/8nRcGeUvwm0=;
 b=W8BiVffO0fneE50uZidBj4W9pNS16PenQ1i8n6SXmOgX0rsLhx+aomr0eZ3kvrkx+IvzivmQ+hpeddEDHBgkQr2ScG1ym0qPKKb1I9KzF1CPD+4PSOQ5vqT0rPVZCm9IKk82c++DSR2H+roe97YBCxiGXMDndC6xGN5sDwefWIYYodavZVoio5CJS3A3nzaeR9V2xC3l3HcRzgohaCSRgdBmGCz7q1VhN8YOUeL0B1JfriIM/nR7cb2OESuBUmQrYUpyeZCsXx85TOTp4dIfdoE85FnbNlAtRg7y2ia5hLvbie0xQZYtcyU+G1aq7rGJE4Di23taLz6AJnCEAxMOhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LVWPR11MB9883.namprd11.prod.outlook.com (2603:10b6:408:3c0::11)
 by PH7PR11MB6835.namprd11.prod.outlook.com (2603:10b6:510:1ee::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 19:07:32 +0000
Received: from LVWPR11MB9883.namprd11.prod.outlook.com
 ([fe80::310:e83f:69b8:e11e]) by LVWPR11MB9883.namprd11.prod.outlook.com
 ([fe80::310:e83f:69b8:e11e%4]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 19:07:32 +0000
From: "Teres Alexis, Alan Previn" <alan.previn.teres.alexis@intel.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
Subject: Re: [PATCH] drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep
 maximums
Thread-Topic: [PATCH] drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep
 maximums
Thread-Index: AQHdUC099CgRshjD2kyMmB4UgR3pf7blvAgAgAAvK4A=
Date: Tue, 29 Sep 2026 19:07:32 +0000
Message-ID: <2e5c830b8834d54a7f808eb49e74a26e2afa5de2.camel@intel.com>
References: <20260929161125.1973918-2-alan.previn.teres.alexis@intel.com>
 <20260929161842.A9DB61F000FF@smtp.kernel.org>
In-Reply-To: <20260929161842.A9DB61F000FF@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR11MB9883:EE_|PH7PR11MB6835:EE_
x-ms-office365-filtering-correlation-id: 01dd1453-a4f3-4cbf-8b1c-08df1e5cea35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|11063799006|56012099006|5023799004|4143699003|6133799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: vuJx0G95MLupPgGIq8GRYov70grXMj0yyl/etZF3eoj/EALy4+MF4tzXVVgPWIEkigXOoZ/e11nkkAL+0GV+A7ZTKZEahKh5j8sS/kveTLZoHIG/b80xJwLGUkuagWVJKy2rgCAFyXHpgeFS10SlMutUFb3lbYmUK0tLMEMtC/F7mszHjEX48mKfGjB6UTf675AGX4H9wNHn8fD0lMarwPbeyA3ZRK2Aity+WBShwEbH1mms33xQ8WeZJ9nCnlbmxQhBfoRs6tTjpOPRkcx4DSh5vKYGMVR/CrRW8rEqzJG6y3eNrlMKT1G1izUji9lG7PAu2EdIUvfD3ZytbK7J9pR15pOhTGOycuaPvItIqkTioWwC5CjqxIqpoNpmubidEB03g8mfqGhBrbPUcJJ8SuU/GujRuFTR+aLyKsXfS2J3TH4uSWT7IceH1tSqu9UQvALT12UCVC5kmimFJSvJKtlWf54zM5nIqLf8saQktOwL6xUSuNK0ERZoRah7aFzswXKJDvJDx/fTzgJJ1zwF/UBB2lOPJfm5sYgEtnCZx5pkSwV+bS3pqit8kusCFZd4mxIbgVSNAyp9sN8GGfDYWnwYXuTykgUoWeetgH89qZRyo1UfecpWu6Usiwes7fHPQCw81JyjbkgDXeiTTZi0HaPSaHw5QiVDKgks/E0Tq2YDhd4PM4xLtPnVL5JbHWSW8MB3iTVqcoGq1P03Xu8hLf6txAWEF8vtrjh167nlLq4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LVWPR11MB9883.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(11063799006)(56012099006)(5023799004)(4143699003)(6133799003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3FWWkFKQnpsdmduNGF3S25BbitpOTcvMGZCU3EzdEFmdjBJK1ZsKzBvQlVq?=
 =?utf-8?B?ZStsRDQwZFYxRjRGRGJnMWN5M3JzQStEZTNvL1JINHRsTFh1RTI4VFZQQXc3?=
 =?utf-8?B?S3c5Y05FeWR2WkxoVmZUbEErS1FiRldmL0hwYnJDWjNGOHJVUjUzUGl0K2Zl?=
 =?utf-8?B?ZllZOEF3bkhsRGVVSlVkWS9VRnlaY3BjR1lyYzZCZzR2blB5VzY5cFhXeVJ1?=
 =?utf-8?B?dmF5RWZaNzNaMWcxcnpvQlY4bVIvVkcrei8xNnBuNmV6ZnpTRksvWXBDbnRn?=
 =?utf-8?B?bXV4NTU4YnVLd3ExQUI1Q3RBUmJvSlVrTnRrc2hBODJqeERUOVY1UytwN29E?=
 =?utf-8?B?bTRnbXl6dnkvampJN3Y5bGZ6RGtiYkFURFNEV28vVkdPRkVIdDVkVTZWSWdo?=
 =?utf-8?B?T1RmdklmcGhXV05aejhvTTRVRURlQXcxMFhNWUtTMTd0Wk9USUN3emZadkIw?=
 =?utf-8?B?UnJzUEtkNGpYMWYwNk5xWksvcVAyY0VveGNzRC95TVQyNWExMEhkcitROHRT?=
 =?utf-8?B?dlhyaUNEK3VGTUMxYXRUV2JoV3RNd2ZEdXdtTllxZGRYTG5aLzVGVDUzOTBZ?=
 =?utf-8?B?dWxGZWgzOG9jSmtuNEpSVGFtMFJsQ3JLZDltdlVGK2l4YTJZMm1WT3hTV1pN?=
 =?utf-8?B?TlpKcExmcThrSzJvckVaNG8vV2J0cWVvRVgvRHJmWlpSNjB1NnN2MTZ3b01h?=
 =?utf-8?B?SWI2bzJCTG5HaFE5MjRSbG0vNDcyR3FvUFJlSkhDRmdXRlQ0ekIzVnV2U0pq?=
 =?utf-8?B?c09oNHpWOExaZHhXQW51M1ZtaGlTVUtNaG5aa0Z1M2FIVkVNZW5MNS9mVUxt?=
 =?utf-8?B?akZ1cU5EOTRhdkczMW5mMXU3T1lBR2tHNWZkR3FMV2RJOEplYy9MaE56a005?=
 =?utf-8?B?NzFtZ0hlb0R5MGw4WGpGeUpWdkR3emIrR3Fqd01VL3RVRjR5U0ovZHlWQ2Iy?=
 =?utf-8?B?Mk12REJ5LzJpaUV2bEkzalFoaEI3aFJscm5URjhWU09FNVZTSGJUMHo5TDln?=
 =?utf-8?B?ZFJVL2NoRnQ2cTdTbW9FSDBRNllXdlFzNHhZZDRvM0lPankwTDcyRy91R2g4?=
 =?utf-8?B?bzRmVkVuRzdrVUgzMFc5R1Z4a0dWdG5lcjc1TnE1SHd2dU1NZ1NtellVMGp6?=
 =?utf-8?B?SWVyMjVQc25FVENRMnlJWWVuWFBpaFB3R3dWME5KNkZWRkJQSjFlVDJhRzU3?=
 =?utf-8?B?TFlFRTJxaEFHNmhZVUxZSy9nSlpJWCsrbkRabm9hM0p0NERabEJGemNURE1Q?=
 =?utf-8?B?VE9RREovMnpYVUhFUDc4V1owdVJOWnU4YmhRaitabTdVZTdYcXdoMEpOUWZz?=
 =?utf-8?B?MHVPQzUvc09RTElrMUJ2M3BkVnFsZVZPdzNVNFFqSjNPRW91eGdtdWxKM25o?=
 =?utf-8?B?RVkyRUhUWGtjaXhsZHN3TjBVSTViZEM3QWthd1RuYUxVK2J1ajE1eGZzRWVi?=
 =?utf-8?B?UkRyOEllWGNXSnozUUgwWG0yRnhON2NPai9QSGd6QW1Dbk4rb29xZkFobHdj?=
 =?utf-8?B?Zjd0Q1RGczB1UHFnNVgzeFdaSkdDZlRiQnAzcUNNQnRVVDlpMkw3T3MrMU9I?=
 =?utf-8?B?WHphSmZBT05mZFBHUmhEQVR0TUlqc3lnUHRCUDFZTkppKzU5Q1B3ckkwdlNx?=
 =?utf-8?B?TGF1RXRlTEI5NU0zVHNVWTJuU1NsWXFIbDJDWGZwbVJ1dm1aQ0lOdFBSNDEv?=
 =?utf-8?B?Y3NZUFdvOVJWSWtHaytOWlZIcHpNYU81eVI0TWtDMDVkZG03SmZJRWMwQlQ0?=
 =?utf-8?B?U25NZmE0Y3k0aTR2NlpLSjlqc2h1My9lbGlqbktIUGRPSVpzZzZqcFlqZ2ZT?=
 =?utf-8?B?ZjcyTnFoTEsvYWxONTc0UWVxVDR4dG1TRUNrcTdCQ1lPRDNMa2VVWWs0M0NO?=
 =?utf-8?B?VW1RbzNrdXhBUVdtOVBoMjZZcVBYcnZ3MmtvNjVFbVpJdjh4M0Rua0dGYnRC?=
 =?utf-8?B?RjJUM2FJRFQ1RzJsd0E1cTF1c09Wa2FZajVpbkkxRkY3V2RQdWNVbU1jWHFK?=
 =?utf-8?B?a0ptSUYwaVJFK0NnMklaS1pJcnlMMXpEOWxhdm9MOEpMeEc4YUxUWDloWUdL?=
 =?utf-8?B?YTlEWW1IRkd3bFpNOGtyOWxXS1BHYlJtSXpPQmFETHg3aDZVNUw3K3hjeXFL?=
 =?utf-8?B?Q3l5Q3gvMVVJS2dzbk9xd1VnTUpHWXpvdHNIZ1JUWFFjYjFWMFMybFdwZDg0?=
 =?utf-8?B?bWtLbGlyT0N2N3hncTl3M1FPNis5ZE1QV1Y4bS9IN3NoOHRXRUpoVGkxYzJ6?=
 =?utf-8?B?NHJKNS9vMkRBNWF6Wmk3MFg0UVRyR1EvWXZVR05CN0dDTlJIUk5GY0tIekwy?=
 =?utf-8?B?UFM4Y3dYR2xUamRUNytWOS8zSmozT2hLeTRuU0JzMUxXOFA0RjVhSFRlWjJT?=
 =?utf-8?Q?bn8vr2KMNdLQ7H/vs9+m8LmCTk4CM2GI1D5bJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <628560609BD3084A86EB9ADA871983FB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: U/HwMSOE+/YYxvh9kY0xyd3bvpm2lOVT7CSXarj2sufHYLwxmGB7whFjGDntg7AMFbAixzI7PSqSzrJnEzxu0v6HU43E3St9Vqggq8ldemLhgKWlW9vZY8pW/Nq+L/xIS3+bxPyfeg+msNihL59dcGv4mYF4Uwr23q0wvolipQ03kALV0EKARxSx1szeuoBs3z2KGK7/8uk6w4EBCHGmlfW+wCylhoXkkCBk3z4N+4gZPbHGzx1RFDE4HHyP3pUmCrGyLhRG3n702X3f3+FOwknZLQmyN/rc72tSamhbdMT6wSpGHYhUXjM5zpq1evH2uWCGyCwYIoLVX8JbCc3TZg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR11MB9883.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01dd1453-a4f3-4cbf-8b1c-08df1e5cea35
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 19:07:32.4714 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6HKlQzMaaJx4csHUrS+dRW0Gj/tIm7iJOGqXXTHD41Asc3teQFPKHID9m2g8WB7zqqGWlSkVOquZ9becVUXupyaJGHlW6X/UGJ6kA+umvPlQuo4BEmNz1TB6Lyz2iht7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6835
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

T24gVHVlLCAyMDI2LTA5LTI5IGF0IDE2OjE4ICswMDAwLCBzYXNoaWtvLWJvdEBrZXJuZWwub3Jn
IHdyb3RlOg0KPiBUaGFuayB5b3UgZm9yIHlvdXIgY29udHJpYnV0aW9uISBTYXNoaWtvIEFJIHJl
dmlldyBmb3VuZCAyIHBvdGVudGlhbCBpc3N1ZShzKSB0byBjb25zaWRlcjoNCj4gLSBbTG93XSBk
cm0veGU6IGNvbW1pdCBtZXNzYWdlIGRlc2NyaWJlcyBkcm9wcGVkIGRlc2lnbiBjaGFuZ2VzDQo+
IC0gW0xvd10gZHJtL3hlOiBwcmVwcm9jZXNzb3IgbWFjcm8gZGVmaW5lZCBpbnNpZGUgZnVuY3Rp
b24gYm9keQ0KPiAtLQ0KPiANCmFsYW46c25pcA0KPiBbU2V2ZXJpdHk6IE1lZGl1bV0NCj4gVGhp
cyBpc24ndCBhIGJ1ZyBpbnRyb2R1Y2VkIGJ5IHRoaXMgcGF0Y2gsIGJ1dCBfX3hlX21taW9fd2Fp
dDMyIGlzIGNhbGxlZA0KPiB3aXRoIHdhaXQgdmFsdWVzIHRoYXQgY2FuIHJlYWNoIDEwMCwwMDAg
bWljcm9zZWNvbmRzICgxMDBtcykgZHVlIHRvIHRoZQ0KPiBiYWNrb2ZmIGxpbWl0LiBBY2NvcmRp
bmcgdG8gdGhlIGtlcm5lbCB0aW1lciBndWlkZWxpbmVzLCB1c2xlZXBfcmFuZ2UNCj4gc2hvdWxk
IG9ubHkgYmUgdXNlZCBmb3IgZGVsYXlzIHVuZGVyIDIwbXMsIHdoaWxlIG1zbGVlcCBpcyByZWNv
bW1lbmRlZA0KPiBmb3IgbGFyZ2VyIGRlbGF5cyB0byBhdm9pZCB1c2luZyBoaWdoLW92ZXJoZWFk
IGhydGltZXJzLiBDb3VsZCB3ZSBzd2l0Y2gNCj4gdG8gbXNsZWVwIGZvciB0aGUgbG9uZ2VyIGl0
ZXJhdGlvbnM/DQo+IA0KYWxhbjogSSBjYW50IGZpbmQgdGhpcyBtZW50aW9uIG9mICJrZXJuZWwg
dGltZXIgZ3VpZGVsaW5lcywgdXNsZWVwX3JhbmdlDQpzaG91bGQgb25seSBiZSB1c2VkIGZvciBk
ZWxheXMgdW5kZXIgMjBtcyIgaW4gZmFjdCBsaW51eCBrZXJuZWwgZG9jdW1lbnRhdGlvbg0KZXhw
bGljaXRseSBzdGF0ZXMgdGhhdCB1c2xlZV9yYW5nZSBpcyBnb29kIGZvciBib3RoIHNob3J0IGFu
ZCBsb25nIGRlbGF5czoNCmh0dHBzOi8vZG9jcy5rZXJuZWwub3JnL3RpbWVycy9kZWxheV9zbGVl
cF9mdW5jdGlvbnMuaHRtbA0KVGh1cywgd2lsbCBpZ25vcmUgdGhpcyBvbmUuDQoNCldpbGwgZml4
IHRoZSBvdGhlciBsb3cgcHJpb3JpdHkgZmVlZGJhY2suDQoNCmFsYW46c25pcA0K
