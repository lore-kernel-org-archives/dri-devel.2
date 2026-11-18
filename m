Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A646606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GCbw599v;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=EdLPT2Pt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D6F910FBDC;
	Wed, 18 Nov 2026 12:46:49 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEAAB10FBDC;
 Wed, 18 Nov 2026 12:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795005996; x=1826541996;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=xsOhDkP740Bqf97d63nIpa4ioHyu8iy3L676LKXO0Zs=;
 b=GCbw599vt5Imc3DztkzOi+NmzhsHUHPTo7iqz39PCUK571wDKDgLquOa
 5Fz1n/qKvrJZx+PMTTs+nG/se3VKV4YLCtWNrkQmmvxjw0NjK+jzOVkUA
 KnW5Gk6SlSdq0rAD/Q9cW+7k7w42X8WnKcCPTdTAqihBkTK0N+vCR/A5q
 iCHfE4/CrsM034zYpIV1uO55pq80gpPyz3Qy92v1FjyobaLz2Vy5SIfA5
 LTkluTwwFOZdil++onnFDxpKVN+zCReyywinEctw8dDkpW5JXReiQnJ9k
 l2rUHK2hfU9juxk4wnl0E6FqNkz+AyDntfwlHPLzmLPPP584ZF/agK1qV w==;
X-CSE-ConnectionGUID: KArN5nAITGilfF/vCvD8tw==
X-CSE-MsgGUID: lBhO7rPtTvSQunVUlckQvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3730950"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3730950"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 04:46:36 -0800
X-CSE-ConnectionGUID: lxKa2r2yR2S4hX3lENG86A==
X-CSE-MsgGUID: 5gzGZSpRRp2JnJDe5fjd5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10151668"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 04:46:35 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 04:46:35 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 04:46:35 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.44) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 04:46:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3Q9jD0E0W49XmEgSROvxZooMazCHEwS7HN2put3XeFx257lBzFoYbmyft0CxwyWwwse9i5gUtwqy7sng6gM9/ziat4MTpvf7G3zYHGvUc2o74aTYSEJlPD9jpsPpGm4et1pORyQf2KmW1cnWoG3YM8ayAiIBGJWpgyCSYCg2xJUwzm1OpXnYGsZknqg69Z7bHU3W5vtksEvjOFOR79kgxXPf+A3LfzjTLs8Zsn215PrpySZaAXw+LFcAdRKsQzammS4wMARqITZut1jsFWrya8hAcxzZ3aP8HsQfw6m0v1WTSnAVey2YLhp96q7vwlEOK/CPjjEcfBuHNcDjw2wlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xsOhDkP740Bqf97d63nIpa4ioHyu8iy3L676LKXO0Zs=;
 b=kI667lQMOsrdO5uIcvCC9s0lAjWTHfaHiMbm4kqchkKkJmxD/1caxjpoez0OEcrqFb+WvdKtw0Msd5xiNNsFZGuZO0juQVaYrAxt5K4CPwNPDLPcIrTZQazyXbkXekafLoRRhyhUzlVHpXg54adKLGkGV+GoYHHHSYdMwtlrHNLFSjW/DgiwYfnlT41b5WmQjXGdoohXBfOiqe66ZCp1BX3GmRFwI9V52Jq34BHPPMmN7bfbmoE7sWnMOQzAYhumqmREiDlK05BRz1gCTXTqvy4vQ2SlsU+bsEUJcS+JVowkHPqX7GfoMCXDOyFng97pGgv8hR4+WyQ8u7vUEmDwcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsOhDkP740Bqf97d63nIpa4ioHyu8iy3L676LKXO0Zs=;
 b=EdLPT2PtpXWqluA91TGOC8m7TUofde5upomorit4HlXm4APunPZZqC7vWN7i+2hLRw6TerT6MrKryST5YrW33qB9RmaeDjJ6rCyxRYW2dIZvEvGgzYFu9n9A0lT9NzwCzlZW835ySfKnXRfvGLKQpQ/yieQo+fhQD2FqxG2CT7A=
Received: from LV2PR11MB6024.namprd11.prod.outlook.com (2603:10b6:408:17a::16)
 by DM4PR11MB7325.namprd11.prod.outlook.com (2603:10b6:8:107::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 12:46:32 +0000
Received: from LV2PR11MB6024.namprd11.prod.outlook.com
 ([fe80::38ad:3190:bbb2:412b]) by LV2PR11MB6024.namprd11.prod.outlook.com
 ([fe80::38ad:3190:bbb2:412b%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 12:46:32 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Manna,
 Animesh" <animesh.manna@intel.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>
CC: "Kandpal, Suraj" <suraj.kandpal@intel.com>, "Nikula, Jani"
 <jani.nikula@intel.com>
Subject: Re: [PATCH v7 15/20] drm/i915/alpm: Compute and program switch to
 active latency
Thread-Topic: [PATCH v7 15/20] drm/i915/alpm: Compute and program switch to
 active latency
Thread-Index: AQHdZQyar3ddmfEFzkCI8glrUCgqlrcz65EA
Date: Wed, 18 Nov 2026 12:46:31 +0000
Message-ID: <9b987b9439a4d04044ca5937193e11b8be660f08.camel@intel.com>
References: <20261026054001.799894-1-animesh.manna@intel.com>
 <20261026054001.799894-16-animesh.manna@intel.com>
In-Reply-To: <20261026054001.799894-16-animesh.manna@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6024:EE_|DM4PR11MB7325:EE_
x-ms-office365-filtering-correlation-id: 3f513fbe-6667-4359-9a7b-08df4571f8ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|261021123027099003|38070700021|10067099003|261022075727099003|56012099006|4143699003|11063799006|261026140227099003|261022115727099003|261028144727099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|261009221227099003|18002099003|22082099003;
x-microsoft-antispam-message-info: FAvCrrudkYnbeg+e4ca4Zobi4o6op4h20ouFb0vxwWlXGjxjndPnD9omuxTgKNC1hT1DuKfomI1jOHdce7iLyPAd4Pml0uszLL3UMwEdaL8axEodpBUMcQQlDg+pfOgHzvmZ2txRM71/UpNPVpx1Sr3OZ9COb6fjm30hW6fNg0+4BxQILh4ZB1t/CYFMVgYmF4X6i4foANkzjxwPMQgF+uKewPvMNj0Id+MPKXmZ28zMY4to6F1yaROuL8rgmZMSPulrlPZl8T58NGTI4o7NwQTnnG8igL2cNy5w6wSj+0v8L0O1Qw9XWsD/iW9z2A1VFIY8kAp5JbxcKBuX/xeb/N5NPy/OGb90QwNNWxcgjjdhNFL74SvDbvdfN0ajE/1LU+9/xiiXv4SKh1i5fRWnffrYdr3/F+NBKKqeSJGU9gg3gfkW+gLtq+kv7LeoBRfzTv/OQ1YcXQxLqHa+0yDZ0zR8HJqvZklR17A8CKhD+AmiHoiiRLxz/u0dZULWHOk5tmb9lVsbiSKgrGTuHiAWBW2ee3hYVbxfWgYkFIBnCQ/P6fbvYcE8wqrUWQ+jQan+Hjjm80zmRcQm4zVDGHGpCp1NNELg5Fz9JXsZC+sfHvNkUlNsC+Aldvk4c7DDqxxAERhG1sOZx+P3ZwAZ521rnmhplCTmjltOuxCZYStkszXhNi8OTlk64u/1s4Y8bs+rlkwzlID/c2d4e9/LiDnbfL3ZZipu6xqwb9t56CoxkDc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB6024.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(261021123027099003)(38070700021)(10067099003)(261022075727099003)(56012099006)(4143699003)(11063799006)(261026140227099003)(261022115727099003)(261028144727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(261009221227099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c29YNThSaEdSR2YwSUdsZWJ1cXhyM3VzZzROa0pvWlpXV1huRHUzcEJqWXY0?=
 =?utf-8?B?cW1jbnZiMEFBRzZCV082SWk3VzNMbVpTSHF6RHBXT3dtSWZYRGZzM096NXJ4?=
 =?utf-8?B?RVYxcXUvMW04YTlFU2tMeXpVUG1PU2REZ2VGaHNQRnFraVZGSjEwakVjeDA3?=
 =?utf-8?B?TVRZU2V6MVpidWFrZkMrK0pOd1hHa3pkS3dmZVZQVE1VVUVETEVUdnJUMjV5?=
 =?utf-8?B?VEZSZEZISkZVV3dXVjdMaW5jOEdDUUVKTXlJdDdCaG9SS2htSjh3Mytsczhi?=
 =?utf-8?B?VWxkOFFhK0JpMEtTTEx3R3RBYUJrYlFkVnZYQU9ReElhZzVvOEtTYU9UYnNk?=
 =?utf-8?B?eTQvTkV5TG41bEJ2bGVuazh1WXFwazdGRW9iUzVFMHNSRlV6MmJxZjlic1dS?=
 =?utf-8?B?bTJlaGFwNnFZR1dMeEdhR1VDY251cGhKcFpHOVpzOEE1Nk1HcjJFNVQ1YmQr?=
 =?utf-8?B?R2tLK0FzZEREdUV5WStRWWxkVjR2ZW9idEtZcVdqT0RGaitvRWNaQ2FLa1dx?=
 =?utf-8?B?SkRmVUpGSmdXdE8wcWh0WXY3QlZNbWQyaEMzT3pkOHhCanhlQktyRkJIRm5h?=
 =?utf-8?B?eURMU1o5WTNhZzZaVHhNdWFIZlcxeVcvYytmMllQOEF2eWRoUDU1emF4cjN2?=
 =?utf-8?B?UFVmbmJ1NEJ1dmJSSHlVbGtESmlmem1LQVBla3UrVU55TXFBUUJqWDhLc1lP?=
 =?utf-8?B?U0J4Y1Bsekd0aDJvcXY1MDhLMldPSElCL2JqOVlyWXBqUFJpU1dkYmhZd1gy?=
 =?utf-8?B?SjI1S1IrU2sxT2hNS1UvYkw2czBsK3NycWxBbVRMNmo3cDF0ZUI0K1VzQVhQ?=
 =?utf-8?B?ZjVwSUhYRXNRSDZtS3I4UnFMT25JNHZEWGh4UTR3MHdSWXhwV3hFRmtBMFQ4?=
 =?utf-8?B?UjR2eWg2cjhZamhldk1oWUNESS8yUjBibHgvRjM3SkNDbDR1VWNrUXI2K1Js?=
 =?utf-8?B?NHFIOVVZUk5LQVd3S1VUdG5GejIyTHREWmFKaTJKWUFBNHcrVXREMUtaNk1o?=
 =?utf-8?B?bHZqSVRTcTNYaEhvV09nVmVzd2tpZ2szVlVKblVmaTAyaXVvcTA3SWdEZks5?=
 =?utf-8?B?emFOR2UrK1pnMzdiWW9idm54RnBWOEo2RU9vaGhBSTVZN2VhVUd2MEs3UHFn?=
 =?utf-8?B?ZEtNOStrS29lbEMyVDRPNnpvRGhxSU14YVNNTXd2ZXE1Smt4LzMxTkZRM3NK?=
 =?utf-8?B?MXR6VVUwbG9FTEJJZ3phRmRaWFJiMWRGMzczS04vUFNXTC9jWWVmanZ4MjI0?=
 =?utf-8?B?WkZydHBTb3FoWGJjcDU1YUpza25FOWN1TkhpQUluZUFORklVUTkvUG95djF4?=
 =?utf-8?B?Tm1rSE45VnBBS1dMenl1YjdGUnBFTWE4ZWR6WDF2bm9vSmx4Z28vTDFEUnVk?=
 =?utf-8?B?ZXZqdzdRQ2g5TEZGNlU5OVY3RnlvUkcvclgxbUxHUjZsR3llN2V3N3pOeFlz?=
 =?utf-8?B?c2M1b29IUkNPampQb1kwby9ZcWFYNXVKQVFaUnd5MWR0M1UyWHlWM1U5NFpT?=
 =?utf-8?B?WlZIcTlBdVJDMk43WDZZL3oxSjdhdXJWSnJJUVVxMDQ2aEdBV1lIcGNnOTkv?=
 =?utf-8?B?UG5zdTJvT3hPeURwZnJJbHR3TWNGQUFqZ2RmaXJWT0xjajhLc3R3K0VxZkNO?=
 =?utf-8?B?QTd1a3VBaUZLQi9WdkNqQStIMnNPUm5CQlowVTFvZEEvUVJGbmN0SXdLZjZM?=
 =?utf-8?B?VkVweS9jYkJ4a29IRFlWRXRSTUExbTVEL3RWbzg0Nm00VmtiVGpxaTRwLzlu?=
 =?utf-8?B?M2NGaHp2Q1ZOVm5PZ0pKbVc4aHd2djBVRmt2aGpjaHBnd1NWaHM5SFlnbEN2?=
 =?utf-8?B?dzhtVTdIbEVnVnV6eHNnNGdBTldROGtyZjB6KzA5WlEyOFp2NUgzV3U3N2ph?=
 =?utf-8?B?RllpZXhCdFVRWmUrZm9DOXY2aHp3UHJPQmJwRUZreG9UM0FMZUgrbnRBNW5H?=
 =?utf-8?B?eGtIOVBFM2hOTXV2MWRHSkVMajVFaFhwR1ZZRnVzSDFxYlk0THlJRjl4K25l?=
 =?utf-8?B?WFJGSXZBSzlrOEQ0SnUxeEhKOXR2Yk9peXNsVGVzOWdmdUpGV3Fabld5aENl?=
 =?utf-8?B?ZUJHV3kvdnFEbWZCVUcvUFhoR0sxWUV5WTBMbCs4dXMxL0puaDE3YVJCa3Iv?=
 =?utf-8?B?S3B6MVdDb3ZZMUI2UlVZWnpFdFNEMkluV2NSRlJsTEcrUFBrRmhVQ1pLUjZX?=
 =?utf-8?B?ZUkxMmJkK2lrUWs5MlhNaGZsRDlLYW4wS2hERDhrWUhxMjB3ZHBRdG43L2pW?=
 =?utf-8?B?eS9FZzRJOE5OTnp0TDBjb250ZUtlMjRncnNHT3VsdUt5M1M2OVJlUEV0WFVN?=
 =?utf-8?B?UFRaVU9IV0ZLZ2JsU3FMNDA1VDdBa3Uyazc1WFI2Y2lrRk9pSGxvSjIwV3d2?=
 =?utf-8?Q?MIEXoqB40oT9C5sw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC0D536CF38C2F429A73C866B2AEBBDB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Buw6d5jACN5KXdeE61Nudfz8gcm+dXqTjbeXAJeofZSZhhGaVo6OzHQCl0aZvD/Sl4X9BcbodcLRaHccRcYQ4p0DBiMBy/7t1oHiSvt7rowjSvi0wKZ4I4IHETOvAWcAKAQ2Y85paa0q/XQQf0Q0RvwB+NqyjmhAPddJACVieOEgF5oYxy+wyDUv8L81PDD+zFyxTiYG2897dwzS7+mYVMrg8E1+qGEji5uUfO67FGWFqCGdRV1DJGPdwWapmiQHd3fDatnrpH1yRxTDvNeifn8UWJg85eUZxTZH5bySt096nARskYgKdMNvHjGTbU7GgIb6Mg/8MS1LMOTUwO3i2Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f513fbe-6667-4359-9a7b-08df4571f8ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 12:46:31.9839 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LWzhUsr/SoP+VVR0Mfx9OFdP7+W0TOkHPgiEPgt5nZciVN5veZDzUk2GgAcLD/w+P5Sv9VamOxxW+ajR71UIqZ+U3T1wpxqyslrTychYf2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7325
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gTW9uLCAyMDI2LTEwLTI2IGF0IDExOjA5ICswNTMwLCBBbmltZXNoIE1hbm5hIHdyb3RlOg0K
PiBQcm9ncmFtIHRoZSBBTFBNIHN3aXRjaCB0byBhY3RpdmUgbGF0ZW5jeSBpbnRvIEFMUE1fQ1RM
Mi4gRm9yIFVIQlINCj4gbGluaw0KPiByYXRlcyB0aGUgbGF0ZW5jeSBpcyBkZXJpdmVkIGZyb20g
dGhlIGxpbmsgc3ltYm9sIGNsb2NrIGFuZCBjb252ZXJ0ZWQNCj4gdG8NCj4gc2NhbmxpbmVzLCBm
b3Igbm9uLVVIQlIgcmF0ZXMgaXQgaXMgemVyby4NCj4gDQo+IHYyOiBVc2UgbWFjcm8gaW5zdGVh
ZCBvZiBtYWdpYyBudW1iZXIgd2hlcmV2ZXIgcG9zc2libGUuIFtKb3VuaV0NCj4gdjM6DQo+IC0g
VXNlIGludGVsX2RwX2xpbmtfc3ltYm9sX2Nsb2NrKCkuIFtKb3VuaV0NCj4gLSBGaXggc3dpdGNo
IHRvIGFjdGl2ZSB0aW1lIHdoaWNoIHdhcyAzMiB0aW1lcyB0b28gbG9uZyBhcyB0aGUgc3ltYm9s
DQo+IMKgIGNsb2NrIGFscmVhZHkgYWNjb3VudHMgZm9yIHRoZSAzMiBiaXRzIHBlciBzeW1ib2wu
IFtzYXNoaWtvXQ0KPiAtIFJvdW5kIHRoZSBzd2l0Y2ggdG8gYWN0aXZlIHRpbWUgdXAgdG8gbWlj
cm9zZWNvbmRzLiBbc2FzaGlrb10NCj4gLSBDaGVjayB0aGUgc3dpdGNoIHRvIGFjdGl2ZSBsYXRl
bmN5IGZpdHMgaW50byBBTFBNX0NUTDIuIFtzYXNoaWtvXQ0KPiANCj4gQ2M6IEpvdW5pIEjDtmdh
bmRlciA8am91bmkuaG9nYW5kZXJAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbmltZXNo
IE1hbm5hIDxhbmltZXNoLm1hbm5hQGludGVsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEpvdW5pIEjD
tmdhbmRlciA8am91bmkuaG9nYW5kZXJAaW50ZWwuY29tPg0KPiAtLS0NCj4gwqBkcml2ZXJzL2dw
dS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0uY8KgwqDCoMKgIHwgMzUNCj4gKysrKysrKysr
KysrKysrKystLQ0KPiDCoC4uLi9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2Rpc3BsYXlfdHlwZXMu
aMKgwqDCoCB8wqAgMSArDQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAzNCBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rp
c3BsYXkvaW50ZWxfYWxwbS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRl
bF9hbHBtLmMNCj4gaW5kZXggODMxZGZhNWU2NzdiLi40ZTc2MTAyMjQ4NWQgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5jDQo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5jDQo+IEBAIC0yNTAsNiArMjUw
LDMxIEBAIHN0YXRpYyBpbnQgZ2V0X2VzdGFibGlzaG1lbnRfcGVyaW9kKHN0cnVjdA0KPiBpbnRl
bF9kcCAqaW50ZWxfZHAsDQo+IMKgCXJldHVybiBTSUxFTkNFX1BFUklPRF9USU1FICsgdDEgKyB0
Y2RzOw0KPiDCoH0NCj4gwqANCj4gK3N0YXRpYyBpbnQgZ2V0X3N3aXRjaF90b19hY3RpdmUoY29u
c3Qgc3RydWN0IGludGVsX2NydGNfc3RhdGUNCj4gKmNydGNfc3RhdGUpDQo+ICt7DQo+ICsJaW50
IHN3aXRjaF90b19hY3RpdmU7DQo+ICsNCj4gKwlpZiAoaW50ZWxfZHBfaXNfdWhicihjcnRjX3N0
YXRlKSkgew0KPiArCQkvKiBsaW5rIHN5bWJvbCBjbG9jayAoZkxpbmsgLyAzMikgaW4ga0h6ICov
DQo+ICsJCWludCBzeW1ib2xfY2xvY2sgPQ0KPiBpbnRlbF9kcF9saW5rX3N5bWJvbF9jbG9jayhj
cnRjX3N0YXRlLT5wb3J0X2Nsb2NrKTsNCj4gKw0KPiArCQkvKg0KPiArCQkgKiB0U3dpdGNoIHRv
IEFjdGl2ZSA9IDMyICogKE1MX1BIWV9MT0NLIExlbmd0aCArIDMNCj4gKyA2NCkgLyBmTGluaw0K
PiArCQkgKgkJwqDCoMKgwqAgPSAoTUxfUEhZX0xPQ0sgTGVuZ3RoICsgMyArIDY0KQ0KPiAvIHN5
bWJvbCBjbG9jaw0KPiArCQkgKg0KPiArCQkgKiBUaGUgIisgMyIgdGVybSBpcyB0aGUgdHJhaWxp
bmcgemVybyBwYWRkaW5nIGFmdGVyDQo+IHRoZQ0KPiArCQkgKiBQT1NUX0xUX1NDUkFNQkxFUl9S
RVNFVCwgdGhlICIrIDY0IiB0ZXJtDQo+IHJlcHJlc2VudHMgdGhlIE1UUA0KPiArCQkgKiB0aW1l
IHNsb3RzLiBUaGUgcmVzdWx0IGlzIHJvdW5kZWQgdXAgdG8NCj4gbWljcm9zZWNvbmRzLg0KPiAr
CQkgKi8NCj4gKwkJc3dpdGNoX3RvX2FjdGl2ZSA9DQo+IERJVl9ST1VORF9VUCgoTUxfUEhZX0xP
Q0tfTEVOX1VIQlIgKyAzICsgNjQpICogMTAwMCwNCj4gKwkJCQkJCXN5bWJvbF9jbG9jayk7DQo+
ICsJfSBlbHNlIHsNCj4gKwkJc3dpdGNoX3RvX2FjdGl2ZSA9IDA7DQo+ICsJfQ0KPiArDQo+ICsJ
cmV0dXJuIHN3aXRjaF90b19hY3RpdmU7DQo+ICt9DQo+ICsNCj4gwqAvKg0KPiDCoCAqIEFVWC1M
ZXNzIFdha2UgVGltZSA9IENFSUxJTkcoICgoUEhZIFAyIHRvIFAwKSArIHRMRlBTX1BlcmlvZCwN
Cj4gTWF4Kw0KPiDCoCAqIHRTaWxlbmNlLCBNYXgrIHRQSFkgRXN0YWJsaXNobWVudCArIHRDRFMp
IC8gdGxpbmUpDQo+IEBAIC0yOTIsNyArMzE3LDcgQEAgX2xubF9jb21wdXRlX2F1eF9sZXNzX2Fs
cG1fcGFyYW1zKHN0cnVjdCBpbnRlbF9kcA0KPiAqaW50ZWxfZHAsDQo+IMKgew0KPiDCoAlzdHJ1
Y3QgaW50ZWxfZGlzcGxheSAqZGlzcGxheSA9IHRvX2ludGVsX2Rpc3BsYXkoaW50ZWxfZHApOw0K
PiDCoAlpbnQgYXV4X2xlc3Nfd2FrZV90aW1lLCBhdXhfbGVzc193YWtlX2xpbmVzLCBzaWxlbmNl
X3BlcmlvZCwNCj4gLQkJbGZwc19oYWxmX2N5Y2xlOw0KPiArCQlsZnBzX2hhbGZfY3ljbGUsIHN3
aXRjaF90b19hY3RpdmVfbGluZXM7DQo+IMKgDQo+IMKgCWF1eF9sZXNzX3dha2VfdGltZSA9DQo+
IMKgCQlfbG5sX2NvbXB1dGVfYXV4X2xlc3Nfd2FrZV90aW1lKGludGVsX2RwLA0KPiBjcnRjX3N0
YXRlKTsNCj4gQEAgLTMwMiwxMCArMzI3LDE0IEBAIF9sbmxfY29tcHV0ZV9hdXhfbGVzc19hbHBt
X3BhcmFtcyhzdHJ1Y3QNCj4gaW50ZWxfZHAgKmludGVsX2RwLA0KPiDCoA0KPiDCoAlsZnBzX2hh
bGZfY3ljbGUgPSBnZXRfbGZwc19oYWxmX2N5Y2xlX2Nsb2NrcyhjcnRjX3N0YXRlKTsNCj4gwqAN
Cj4gKwlzd2l0Y2hfdG9fYWN0aXZlX2xpbmVzID0NCj4gaW50ZWxfdXNlY3NfdG9fc2NhbmxpbmVz
KCZjcnRjX3N0YXRlLT5ody5hZGp1c3RlZF9tb2RlLA0KPiArCQkJCQkJCcKgDQo+IGdldF9zd2l0
Y2hfdG9fYWN0aXZlKGNydGNfc3RhdGUpKTsNCj4gKw0KPiDCoAlpZiAoYXV4X2xlc3Nfd2FrZV9s
aW5lcyA+DQo+IGdldF9hdXhfbGVzc193YWtlX2xpbmVzX21heChkaXNwbGF5KSB8fA0KPiDCoAnC
oMKgwqAgc2lsZW5jZV9wZXJpb2QgPiBQT1JUX0FMUE1fQ1RMX1NJTEVOQ0VfUEVSSU9EX01BU0sg
fHwNCj4gwqAJwqDCoMKgIGxmcHNfaGFsZl9jeWNsZSA8IDEgfHwNCj4gLQnCoMKgwqAgbGZwc19o
YWxmX2N5Y2xlID4NCj4gUE9SVF9BTFBNX0xGUFNfQ1RMX0xBU1RfTEZQU19IQUxGX0NZQ0xFX0RV
UkFUSU9OX01BU0sgKyAxKQ0KPiArCcKgwqDCoCBsZnBzX2hhbGZfY3ljbGUgPg0KPiBQT1JUX0FM
UE1fTEZQU19DVExfTEFTVF9MRlBTX0hBTEZfQ1lDTEVfRFVSQVRJT05fTUFTSyArIDEgfHwNCj4g
KwnCoMKgwqAgc3dpdGNoX3RvX2FjdGl2ZV9saW5lcyA+DQo+IFJFR19GSUVMRF9NQVgoQUxQTV9D
VEwyX1NXSVRDSF9UT19BQ1RJVkVfTEFURU5DWV9NQVNLKSkNCj4gwqAJCXJldHVybiBmYWxzZTsN
Cj4gwqANCj4gwqAJaWYgKGRpc3BsYXktPnBhcmFtcy5wc3Jfc2FmZXN0X3BhcmFtcykNCj4gQEAg
LTMxNCw2ICszNDMsNyBAQCBfbG5sX2NvbXB1dGVfYXV4X2xlc3NfYWxwbV9wYXJhbXMoc3RydWN0
IGludGVsX2RwDQo+ICppbnRlbF9kcCwNCj4gwqAJY3J0Y19zdGF0ZS0+YWxwbV9zdGF0ZS5hdXhf
bGVzc193YWtlX2xpbmVzID0NCj4gYXV4X2xlc3Nfd2FrZV9saW5lczsNCj4gwqAJY3J0Y19zdGF0
ZS0+YWxwbV9zdGF0ZS5zaWxlbmNlX3BlcmlvZF9zeW1fY2xvY2tzID0NCj4gc2lsZW5jZV9wZXJp
b2Q7DQo+IMKgCWNydGNfc3RhdGUtPmFscG1fc3RhdGUubGZwc19oYWxmX2N5Y2xlX251bV9vZl9z
eW1zID0NCj4gbGZwc19oYWxmX2N5Y2xlOw0KPiArCWNydGNfc3RhdGUtPmFscG1fc3RhdGUuc3dp
dGNoX3RvX2FjdGl2ZSA9DQo+IHN3aXRjaF90b19hY3RpdmVfbGluZXM7DQo+IMKgDQo+IMKgCXJl
dHVybiB0cnVlOw0KPiDCoH0NCj4gQEAgLTczMSw2ICs3NjEsNyBAQCBzdGF0aWMgdm9pZCBsbmxf
YWxwbV9jb25maWd1cmUoc3RydWN0IGludGVsX2RwDQo+ICppbnRlbF9kcCwNCj4gwqAJCWx0dHBy
X2NvdW50ID0gMDsNCj4gwqANCj4gwqAJYWxwbV9jdGwyID0gQUxQTV9DVEwyX05VTUJFUl9PRl9M
VFRQUihsdHRwcl9jb3VudCk7DQo+ICsJYWxwbV9jdGwyIHw9IEFMUE1fQ1RMMl9TV0lUQ0hfVE9f
QUNUSVZFX0xBVEVOQ1koY3J0Y19zdGF0ZS0NCj4gPmFscG1fc3RhdGUuc3dpdGNoX3RvX2FjdGl2
ZSk7DQo+IMKgDQo+IMKgCWludGVsX2RlX3dyaXRlKGRpc3BsYXksIEFMUE1fQ1RMMihkaXNwbGF5
LCBjcHVfdHJhbnNjb2RlciksDQo+IGFscG1fY3RsMik7DQo+IMKgCWludGVsX2RlX3dyaXRlKGRp
c3BsYXksIEFMUE1fQ1RMKGRpc3BsYXksIGNwdV90cmFuc2NvZGVyKSwNCj4gYWxwbV9jdGwpOw0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9kaXNwbGF5
X3R5cGVzLmgNCj4gYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2Rpc3BsYXlf
dHlwZXMuaA0KPiBpbmRleCBkMDc0ODgzN2NlOTcuLjgyYTYzYTJlN2ZhMyAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9kaXNwbGF5X3R5cGVzLmgNCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9kaXNwbGF5X3R5cGVzLmgN
Cj4gQEAgLTE0NjksNiArMTQ2OSw3IEBAIHN0cnVjdCBpbnRlbF9jcnRjX3N0YXRlIHsNCj4gwqAJ
CXU4IGF1eF9sZXNzX3dha2VfbGluZXM7DQo+IMKgCQl1OCBzaWxlbmNlX3BlcmlvZF9zeW1fY2xv
Y2tzOw0KPiDCoAkJdTggbGZwc19oYWxmX2N5Y2xlX251bV9vZl9zeW1zOw0KPiArCQlpbnQgc3dp
dGNoX3RvX2FjdGl2ZTsNCj4gwqAJfSBhbHBtX3N0YXRlOw0KPiDCoA0KPiDCoAkvKiB0byB0cmFj
ayBjaGFuZ2VzIGluIHBsYW5lIGNvbG9yIGJsb2NrcyAqLw0K
