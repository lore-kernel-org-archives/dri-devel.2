Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C3FC98309
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 04:22:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 390D610E7CC;
	Wed, 23 Sep 2026 04:22:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="oE3YjoP6";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33F5D10E052;
 Wed, 23 Sep 2026 04:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790137354; x=1821673354;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=9Oj9pW5VeGTqAr3aDVaSiI7L+EbUH2WhKDvFS0dbKyw=;
 b=oE3YjoP684yfXBJvsATLVjcr5VdkbRE6QcxI+aI+2ut4zsZaWcje+4Gz
 4Saei27ubh3AB3kAgB+VP0zlFXN0myzzF+x/+LlmekfZQ75GxDwBCrkwy
 wKtOGWdpRmYLM1SgGI1n/A2QEixeC+zfGz3xrD2udExwusy5wb+f0KM7B
 MHXIw45CaOYcQdZ9yX8CI8FZfOvTICdQbS0zS4rxx4Z7bUeVX9aVHZY8T
 VFXg1gfsOmqEFgyDvtTbsvMT6877qPSLfEdIJ1V+OMvmWshZ9UBd3yxsT
 tceLcjXJiJfxpFlFviQWL78F9m2a9HzmitJQFzv+KGcwpq3KYmVMIvBqU Q==;
X-CSE-ConnectionGUID: AV45APkZRoqnY3Fb5xI0fQ==
X-CSE-MsgGUID: TfO1VVu+RPW1MblrgXfkeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="90815810"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; d="scan'208";a="90815810"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 21:22:34 -0700
X-CSE-ConnectionGUID: dQnQeyP0QtG3emWRS4MB7Q==
X-CSE-MsgGUID: 6dZrLCz6SYCw9pyP8RPr5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="4461272"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 21:22:33 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 21:22:33 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 21:22:33 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.15)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 21:22:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljs2b7d8h7GP80Og06C+x8rxuqDH04YEIopxbXQy4G/XRuswkZOQdcIOsUUxPa3v8PwkXSJgIwVtSLP2tSqb9DuTQm6BSl6scCjV8mBwLptmZOjDpyTEfvtXklBZTOz8+CnHyQLHcAikjGHJb/tcItS8m3dVg3mNBgG42VtGy75JHIfB8xxepgBHyS4Et1TfcxF7bNPpSqBiEH/Ixj2fWQxj0PluYoHtnuUT1ydAFEFXCrQa7gNiO8rfgc7b7aYNm/2OKex6+duXrkZjw8ZuaUWiz6prY/mrbLqgGOwHRqPH/OuPjy32LEgiZHn0l6CLcGQ7hG8VMMKe4T5k5j8fww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Oj9pW5VeGTqAr3aDVaSiI7L+EbUH2WhKDvFS0dbKyw=;
 b=JN24g6vGnDkT4UEU1TNLg3wHs1SA2ovOqk2BBCbFLYgkeBRRMPNRgLsCzLkQ3iebVjxv0JLuo0RfyPolO6gpEZB6ajEKasvHrdwzhvqPyr6XbxMOvQu7iOuoUh1NJJ3Ndryg97aDjeQa+P/qY5Dk48HxGGavueF9fG2ffl8cUooLl0L4C9mtYntcMaWzseOnIt6TSl+PyiPOOMWIkGz2KnI6oZd0agksJHlemX62H+Ks3bRbqD4Fno7yyS1ZsX0tHuZK1RA5Y7SX74+jZPBR1TqZVelDHUzdqxSgwZHuJNKT6j3X5SUO7gQKteryqOmF3kGjxFpTA8tDPI+p3KnUiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7307.namprd11.prod.outlook.com (2603:10b6:208:437::10)
 by CH2PR11MB8833.namprd11.prod.outlook.com (2603:10b6:610:282::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Wed, 23 Sep
 2026 04:22:25 +0000
Received: from IA0PR11MB7307.namprd11.prod.outlook.com
 ([fe80::9d4a:f89:f548:dbc7]) by IA0PR11MB7307.namprd11.prod.outlook.com
 ([fe80::9d4a:f89:f548:dbc7%4]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 04:22:25 +0000
From: "Murthy, Arun R" <arun.r.murthy@intel.com>
To: =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel.daenzer@mailbox.org>
CC: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Jani
 Nikula" <jani.nikula@linux.intel.com>, =?utf-8?B?VmlsbGUgU3lyasOkbMOk?=
 <ville.syrjala@linux.intel.com>, "Nautiyal, Ankit K"
 <ankit.k.nautiyal@intel.com>, "G M, Adarsh" <adarsh.g.m@intel.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: RE: [PATCH libdrm 2/2] tests/crtclist: add utility to inspect CRTC
 usage
Thread-Topic: [PATCH libdrm 2/2] tests/crtclist: add utility to inspect CRTC
 usage
Thread-Index: AQHdScpnqmrGFHjZPkOpfhOqXdeyUbbZEO8AgAGVhQCAAOwNQA==
Date: Wed, 23 Sep 2026 04:22:24 +0000
Message-ID: <IA0PR11MB73077B0140F367F1C358C5F7BA822@IA0PR11MB7307.namprd11.prod.outlook.com>
References: <20260921130747.2557722-1-arun.r.murthy@intel.com>
 <20260921130747.2557722-3-arun.r.murthy@intel.com>
 <IA0PR11MB7307D575C550CFF4AB2866BCBA842@IA0PR11MB7307.namprd11.prod.outlook.com>
 <737a7039-9b77-416f-a331-698a9cd980a2@mailbox.org>
In-Reply-To: <737a7039-9b77-416f-a331-698a9cd980a2@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7307:EE_|CH2PR11MB8833:EE_
x-ms-office365-filtering-correlation-id: 4a7f8a3a-9dee-45bf-2097-08df192a4536
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|22082099003|18002099003|4143699003|38070700021;
x-microsoft-antispam-message-info: fQMvVhw1GMl3hNZ47HIQl1nBcUw/CR4lpNwdXj5xy2oKc2RTOYYqCfotPS6dRBUV0vyfJC1xpYMslbYsXNz7LjQbALoOFs1NcicGGmpXHorn394w85xhPzmCVkqKeBx5KOX5tup4Vu5FxbkBGA82YdwdGNXuVzIIBaIJxkZEVAIn4KQjhvrGUsKILIu2Wk2zunfRV7prkiqXUdqSPynOeK+Gz48juZ/QUojMk8m8ycEkrjikXAAykSc6pgivsZGQDJSVHzb7Xtlm5eZSw00vT0UfsQUve8ZhmKzY8J96iYLTXYOx0vaijp0POJdZR6SOEW7O6mIN6doUS1RdonWG+v7yX/vTFvzIt0+d3zEnXgODin/9MvVo9uDGl5LaNqNOfZAzOEHrPaf3+ZZe/hFJavzUKXeNyaW8BgrEkv9Rqc2APGSiA2RNwOqkk0ztPkxsx/jkYKyy5vZg9FFzelydsQPDkGE07d2NBYwTQSYpw6h/dkyhjPKDyUnIpL2bRBpT2Z8u5qdoTsgSnpIqj2ICWv/BtxUkqocMt59KBjDN4CgGQ0EngWpwQBh/cm+lDCi8z0NkOoLRIBsdv0bpS1h38L7lArX2AsLjSWNEux6i+t6FqCvLMSTJlsq0wo5HO+uA2+Ic4vHE5/KiX3j4tR6JbKO8M50rS7ng4IEiMLHQGuw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7307.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3lIQk9ORm5zMzZJdmYrTVZDR2dJbzRzWk9hMndOaTZUaU11RGNMYmxsb05W?=
 =?utf-8?B?aXU3UUR4ZElxRFRwNDR5UzBUUEZ2ZnBQSllVK1pMdndMVGtGNW5ETG15cmx6?=
 =?utf-8?B?QzVGenJyK3RuL1BBa2pSWUo0aE8vNWdSUzNTSGpYb2lOMVZrZmxVRHh3T0J6?=
 =?utf-8?B?M29QRFV6ZjhZL3UzOUllazJ5NkNTYzRwR0FFa2RKbk9xU3pPWE1JbnYyQ3JU?=
 =?utf-8?B?SW8yRTJtR1p5dDJtVS90ZjIxNTRrd3BhY3RodTRFazgrZDZqUDduYmU1V0Jh?=
 =?utf-8?B?T2JaL01wTjNadG5QbWVaQkZhbHhYQkgyL1I3VGY3UVNqTW5pVW1ZMUgyRFY3?=
 =?utf-8?B?OVFwMVRnMVYzQ1JERzRmV1ZTaWxIZWhwNDU1VW9hN05LYk1BQVJlcmJHeGJp?=
 =?utf-8?B?ay9pL0crT01HanUvcitZSFN0cGt4MXYvd2pzU2RvMkRwRTFObkRPVmR2aWNo?=
 =?utf-8?B?K1dJWldMRFd3YmZCVW5DK3lIUGx1R1B2dkdWTFE0WEVtWFBQQndMSWc1eWNJ?=
 =?utf-8?B?aXdHL1RlL2NhR2dJTi9KeG9GYTUvSzFjbEgrVFYvR1R6VThEeTk4YUtUa01H?=
 =?utf-8?B?K1FpNzN6aVl6eXpQT1lTWElMT083bXo1bm9SV2tWWkI1enZGY3FIckRMdTB5?=
 =?utf-8?B?bVF3WDJIVG5sWVI0ODBvbExoZ0MwMnVlQmw4RU12ZzEvVDF4anFZU1ZGTkVl?=
 =?utf-8?B?Y21NdXMrTGNEclRPSlpWNHJRQ0IyNmpBeWtCa2JYVUlhbnowVTdkOGJmRDRj?=
 =?utf-8?B?ZnJMOHNWdGhLUjU5S3hKa29BUXBCVmNDS2U5cWgzMTk4N0pJeXBQSDR2Sm9p?=
 =?utf-8?B?N2dQOERIRDRLNml6bHQ3SWg5YjE5bzdjY0hIdU5yQ3EzeDAxWmJYMHZueEJx?=
 =?utf-8?B?RkVzQkF3QXFJd0grOHlJc0dvcnQvdnNlcUFOWnF4ZzJDb0dYeGZaMlRsaUo5?=
 =?utf-8?B?VGdVTUtXQzhLSytEZCtuRXlCRjJtd3ZmR1QwVzI1ejYxUUlCUm9tTmI5aUc1?=
 =?utf-8?B?QnNMZzdLdVhtYWlhZ0IwU3hKMWlpNnNhS3FMeGM3RFA3V2Q0cld2a2FUKzZp?=
 =?utf-8?B?WFhzcGVScVgvWEhWVzN5MC9XanpTaWNRT0tPUTJTUVhKYW5tSTRyQnVnVXBU?=
 =?utf-8?B?QlVpK0F5R0UrTjl1bm5MOE5qcjVnV1JxSmhhWENnUmpSYkZzL3dvckk1RUlH?=
 =?utf-8?B?U2J4bFBCTkUvNzc0QnU1QVMzbjNZZHJVMXUvT1ArZ09wL3BFbkhhVjVuWHBy?=
 =?utf-8?B?bmloam9mK1pSWjlVOEpYblhsT3RoSTB3TjczU1R3T0tuUUtQQXhxay9CZFBQ?=
 =?utf-8?B?aEZjaE5peVVObzYxOEFWZmxxRlVWWm9lUHovZUlLR2NmbFR5Y1pBQ0wzRExo?=
 =?utf-8?B?bW5mVXNac0UrMXZqSG1PZ2Q2RnUvcm8zNzU0aEpuaWw5Uk5vOWFGNHl2VElX?=
 =?utf-8?B?Tk0raDFWVitieTJmK1JqR3V4UVYyTmIzZkkvdWJQYnpIaFVmNVZrSXhiUzAz?=
 =?utf-8?B?SVFveFVmR3hnTWVyN2JLSXorNGZnbHo2dVlJQm8zM3NXbWxDK043Y2JmUWpI?=
 =?utf-8?B?WUYxdFFsTmFLZEZmR1lQcDlXYXl4UnFkK3IwRHlyVDVQWDkwQmgxcXc2MTR5?=
 =?utf-8?B?QXdUTkZONERIa2RGVkI4NEx5R1pkemRBanQ3NlZ0MXJDMlpvYnJUaEtnZjRT?=
 =?utf-8?B?dGFORHEyaHVtTnpqTGhaelNpZlE0ODgvYTIzT2VwNTdrcWl5enN4SW5TUlAx?=
 =?utf-8?B?U2ZCMmN5UVZ4QkNaVjl5ekhiNElLR3FsK2hpeTcwcko0QjVFbWFiNUhFRmM1?=
 =?utf-8?B?bC9ST3lIdGQwRnRzOGQySFFoeFhWTWhsM0ZIQUpBQkxvL0MrV3lWWVNVTzZE?=
 =?utf-8?B?a1AxK2JlRHhRNTdjWFNyYzBlZnVHc09zN1haTzkrUFpFbFQ0NEQ1NTY2TndW?=
 =?utf-8?B?RTVOZEJuUlRlV2luNGRQcVhvZERwTjhxdWtaaWg3WXU2bTZVVUNVazgxMy9s?=
 =?utf-8?B?SWkzSXdyRm8wc3NsakhxdDdIcm5PLzFVOGI2UXR0cW5yd0RhVlhudE5DWDFh?=
 =?utf-8?B?Wi9yZ251cHY5T0gyU0NSU3doYk9IUHhwQ1pxY1R5WGFhektzVC9iTmkrbHlB?=
 =?utf-8?B?NjYrZmN5N2tCTXdNeHErL1pHM1FPMHNnVXoxdzVYdlI4M3JQcnJYYXhLeHdU?=
 =?utf-8?B?TVFORzhyRzAzWmJJMnU4UzZWNkZ4WmRLQTAycm1ScWdQMmlrQ3E3dnVxNUh0?=
 =?utf-8?B?Q2REdlRNRjA0THdMREZrNGtWWUZQMXNIVHdoNDRvMlVDZkp0WE5mUFZKSE1K?=
 =?utf-8?B?VCtEMWZWTGtXMVMwV2RUQXNwUjFhSXJHM0ZpMlUwb01oTFRnR3RFUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: f42e0QJfBAeOfdqYMLSVoyz5rGTZz7pDs2cLrtNrhjNnBsACanCiluDvcPKtZXZ5WG0ZiLc5v1gM3SOgAvjnnTsJer9tOwrn2oysAqtdhm7kF2aSdCxDaneD4QLdT27jET3VIgzYRKHT9qyirxArQfzzTY6g07juhljltqe1SkgWGvIQBddQOEaiEcueRpJJwqt0kRgEL9Br3H292CW7esL4LSVK2KKYv5DUPFt1z9NF8Ij6jV93p0ldRDeEbgesKTgGD/WPMHYRjdXj0Me72hT70Fv5hBsqvRLKslbWKxS5Uyfj7pQSMDlIInoIojg2lo6CYZc3DP73yUhdvxU3Cw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7307.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a7f8a3a-9dee-45bf-2097-08df192a4536
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 04:22:25.0066 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: US6giKLCZoItJe6tcicwmUJ8JFea6nCgDoJL1Wm6p+KeFkkIFeZ3rjscW+p0rUiadxv7I56Au5Un2tVhdtfVbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8833
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWNoZWwgRMOkbnplciA8bWlj
aGVsLmRhZW56ZXJAbWFpbGJveC5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAyMiwg
MjAyNiA3OjQ3IFBNDQo+IFRvOiBNdXJ0aHksIEFydW4gUiA8YXJ1bi5yLm11cnRoeUBpbnRlbC5j
b20+DQo+IENjOiBpbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBpbnRlbC14ZUBsaXN0
cy5mcmVlZGVza3RvcC5vcmc7IEphbmkgTmlrdWxhDQo+IDxqYW5pLm5pa3VsYUBsaW51eC5pbnRl
bC5jb20+OyBWaWxsZSBTeXJqw6Rsw6QgPHZpbGxlLnN5cmphbGFAbGludXguaW50ZWwuY29tPjsN
Cj4gTmF1dGl5YWwsIEFua2l0IEsgPGFua2l0LmsubmF1dGl5YWxAaW50ZWwuY29tPjsgRyBNLCBB
ZGFyc2gNCj4gPGFkYXJzaC5nLm1AaW50ZWwuY29tPjsgZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIGxpYmRybSAyLzJdIHRlc3RzL2NydGNsaXN0
OiBhZGQgdXRpbGl0eSB0byBpbnNwZWN0IENSVEMgdXNhZ2UNCj4gDQo+IE9uIDkvMjEvMjYgMTY6
MDcsIE11cnRoeSwgQXJ1biBSIHdyb3RlOg0KPiA+PiBGcm9tOiBNdXJ0aHksIEFydW4gUiA8YXJ1
bi5yLm11cnRoeUBpbnRlbC5jb20+DQo+ID4+DQo+ID4+IEFkZCBhIHNtYWxsIGRpYWdub3N0aWMg
dXRpbGl0eSBidWlsdCBvbiB0aGUgbmV3IGRybU1vZGVHZXRDcnRjTGlzdCgpDQo+ID4+IEFQSS4g
SXQgcHJpbnRzIHRoZSB0b3RhbCBudW1iZXIgb2YgQ1JUQ3MsIGhvdyBtYW55IGFyZSBmcmVlIHZz
IGluDQo+ID4+IHVzZSwgYW5kIGEgcGVyLUNSVEMgbGluZSB3aXRoIHN0YXRlLCBzY2Fub3V0IGZy
YW1lYnVmZmVyIGFuZCBhY3RpdmUgbW9kZS4NCj4gPj4NCj4gPj4gQnVpbHQgbGlrZSB0aGUgb3Ro
ZXIgdGVzdHMvIHV0aWxpdGllcyAoZHJtZGV2aWNlLCBtb2RlcHJpbnQpOyBpdCBpcyBhDQo+ID4+
IGh1bWFuLWZhY2luZyB0b29sIGFuZCBpcyBpbnRlbnRpb25hbGx5IG5vdCByZWdpc3RlcmVkIGFz
IGEgbWVzb24NCj4gPj4gdGVzdCwgc2luY2UgY29ycmVjdG5lc3MgaXMgY292ZXJlZCBieSB0aGUg
ZHJtbW9kZV9jcnRjX2xpc3RfdWx0IHN1aXRlLg0KPiA+Pg0KPiA+IFVMVCBpcyByZW1vdmVkIGZy
b20gdGhpcyBwYXRjaCwgYXMgdGhpcyB1dGlsaXR5IGl0c2VsZiBzaG91bGQgc3VmZmljZS4NCj4g
PiBUaGlzIHBhcmFncmFwaCB3aWxsIGJlIHJlbW92ZWQgaW4gdGhlIG5leHQgdmVyc2lvbi4NCj4g
DQo+IE5vdGUgdGhhdCB3ZSB1c2UgZ2l0bGFiIE1ScyBmb3IgbGliZHJtOg0KPiBodHRwczovL2dp
dGxhYi5mcmVlZGVza3RvcC5vcmcvbWVzYS9saWJkcm0vLS9tZXJnZV9yZXF1ZXN0cw0KPiANCj4g
DQpOb3RlZCENCkNyZWF0ZWQgTVIgLSBodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvbWVz
YS9saWJkcm0vLS9tZXJnZV9yZXF1ZXN0cy80OTANCg0KVGhhbmtzIGFuZCBSZWdhcmRzLA0KQXJ1
biBSIE11cnRoeQ0KLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gLS0NCj4gRWFydGhsaW5nIE1pY2hl
bCBEw6RuemVyICAgICAgIFwgICAgICAgIEdOT01FIC8gWHdheWxhbmQgLyBNZXNhIGRldmVsb3Bl
cg0KPiBodHRwczovL3JlZGhhdC5jb20gICAgICAgICAgICAgXCAgICAgICAgICAgICAgIExpYnJl
IHNvZnR3YXJlIGVudGh1c2lhc3QNCg==
