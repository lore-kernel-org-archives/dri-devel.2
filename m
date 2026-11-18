Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA07606A320
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 11:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JsqtNNcY;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=atMfvcQz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B572310E794;
	Wed, 18 Nov 2026 11:46:46 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD6D610FB55;
 Wed, 18 Nov 2026 11:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795002396; x=1826538396;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=zvTtc8GgDjcBhhrQEotk6+82WR+SyWZRgkTP49dPHIA=;
 b=JsqtNNcYB8kL1gqe724+CkbIc/HaN5oGCwJhrw2b0r82OrYyQdokxz3J
 /DYYyM8vYyLlNeDyR/6R2BnOqsI8HKZfsQGZofCIfz3HGjljzg6C+gUUZ
 xs3zhlIS87Haj2392KjJNyKX0Zmn1YIy4A4ugpXdq7tTPpdJcjzMkGrQM
 wGjQVXO7bFY21t+dt4X68AQGrsXX9TPf2HI837PGbtzC49uB/NjtPuiYf
 ocF4V80J9exP1Y7pTj6uE02cUWoEI4sgStW+w8JzSXOkVEHVF0RXYFwZc
 dyI5rIc/dPNeAo8ptbVZAutCxuAtl8TGPdiGxp340T0gtF/hiSZuL59Ml Q==;
X-CSE-ConnectionGUID: eLIK6s2kSoKsExyY+B2IpQ==
X-CSE-MsgGUID: QaJ8Rbz8RumUspTuPNJECg==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3809931"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3809931"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 03:46:35 -0800
X-CSE-ConnectionGUID: d73yfKJqQCSuj7xzHcvgEw==
X-CSE-MsgGUID: VMi0c/NSQjW22ayVyEHD8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="11932169"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 03:46:35 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 03:46:34 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 03:46:34 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.6) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 03:46:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E3cfSopLGqL+xzgZCJB5dSQPPiYttukETqx3k6/miZ6XnFh7XSSVYS5zUlM6C7zpXuWiPan67Sq0FS/v1U0htI8yN3eoKxz5mDiwS6zyCuKuE3OXyJkCFKN+GRfRWC1LhZhSIdK+v4DRGlP+0E5I+xHAdf3ZlLH3U24Cba0i0aDYTl5qsxHr/EHI77wxqk9wqS9EDs8LP6BoMzf6vHhbLcTq+sc3Qo1/mXi2Ku1U5KivXs9RzpA5jlFk22Zo3v//vpsx5f/98oaC9T1gjdR1LRnK7LM1srksPbe84k5PPZUlsPUtrgp/DDXST+fi0PXGDG5VfPSg/vl3S2NpelnCAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvTtc8GgDjcBhhrQEotk6+82WR+SyWZRgkTP49dPHIA=;
 b=ymi7Ec400H5MPFlYHA1HawMr1JYKU4DPODKzdQ+HL6YRmNQnL3+CUneMidqx+ceLn81GUthyCIY1+mrKZH37KhHS4DedQMU689nAHkep+Xg+w2MfMMrsJ4mXCjGQNHQGqdKz8KT9CznV2eU/rrZdv+i4aCxyYS+g3wmmRwxkudnUSX4M+YwocTweEuUGakFikbfmkpzJREuRJyREqsqds+F2jwaYkm1aT2x2qpCu8bQxaE265dfVm8ApMpdqHZg7Scxw8NSDw6HhXVsuHfbzOI/uXli+Sr6T21tXgAf/QB7yAECA9QV1rvWaz2eE5V2Tagk4xyixkN4ppUMX6JtWBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvTtc8GgDjcBhhrQEotk6+82WR+SyWZRgkTP49dPHIA=;
 b=atMfvcQzPVpDGQ+MHwKQWW7bw4unMZRYwKaRmBslmWvJOd/Wk3pbg9MGgp8H3qII/KkvhEjWdqMY4QLbcJ99TRGi+pkF0lRIYUg2W+HzrDoRHo5S+mHAxqcyHJaFJbYCmwFPvvK39n6slaRdcg9WUKNFFNsC/gyQawj/C8MZcQ0=
Received: from LV2PR11MB6024.namprd11.prod.outlook.com (2603:10b6:408:17a::16)
 by CH3PR11MB7867.namprd11.prod.outlook.com (2603:10b6:610:12a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 11:46:27 +0000
Received: from LV2PR11MB6024.namprd11.prod.outlook.com
 ([fe80::38ad:3190:bbb2:412b]) by LV2PR11MB6024.namprd11.prod.outlook.com
 ([fe80::38ad:3190:bbb2:412b%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 11:46:21 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Manna,
 Animesh" <animesh.manna@intel.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>
CC: "Kandpal, Suraj" <suraj.kandpal@intel.com>, "Nikula, Jani"
 <jani.nikula@intel.com>
Subject: Re: [PATCH v7 06/20] drm/i915/alpm: Refactor Auxless wake time
 calculation
Thread-Topic: [PATCH v7 06/20] drm/i915/alpm: Refactor Auxless wake time
 calculation
Thread-Index: AQHdZQyIgdlFAQiyfE60WuOoVnhefrcz2sIA
Date: Wed, 18 Nov 2026 11:46:21 +0000
Message-ID: <7e22df8e96be969c4307e14b3a13012c2a80fbee.camel@intel.com>
References: <20261026054001.799894-1-animesh.manna@intel.com>
 <20261026054001.799894-7-animesh.manna@intel.com>
In-Reply-To: <20261026054001.799894-7-animesh.manna@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6024:EE_|CH3PR11MB7867:EE_
x-ms-office365-filtering-correlation-id: 0e032ae6-9103-40dd-8d71-08df456990ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|261102123227099003|261021121427099003|261021123027099003|38070700021|4143699003|11063799006|56012099006|10067099003|22082099003|18002099003|261009223027099003;
x-microsoft-antispam-message-info: +LUGrvzD38FgFJi4ONNAUOSN2pSXoNu17xuB1foQDokDjHaIqAe1b+5ukPUpOyTIxrfKskShmRnH9fJPgx0Ds7+clxowkMd0m7bv6Clx6rQqeU6A1F5TCndqY+Sroggmt79ODPgi53BGJAKlNvH3qTj59ps9HF11h4TtBZzbVXztX6XIdKHZ5hUbt4LahgoveX68H5Q80uy+Sf7TQXtYuOoFJrVFtO9ZI3R373YfgUNoNfyrccPl9eY96frvXTeSGg+bpbolUdqAIxQ54HSrrowUurMDutpvhYuatukker7bLEL109bAw5iR38vZ64Bd41JIFnweSPfmqDjp9umavK487kywWl8EwJ2n3B1pZAS2ScSgDgoejk7GbgYObbkny0C/WftoVzSd4XYiIZItfd++KE7bVGjxp/r13Jya6KWvEK6aSKfehEmUir43z3xVAwYsjT9NtdOeZKx+PCvJ6O+yNnDCiwI6y3MoIgZMJKINCFB+cP8CQKrhU1jlv5MMxwWUVvO8RTVrdbQq1cgnqaHGaawp/+qQ/q9UBBm5KVg2hG6NPHSUKDPJB+w7ZewmKhnsnHt+aAlnQUXNopaHklxNzsTmcWTCmbzzz9ImA2Oa5es5DctrbmHtGkhizg5tUyxe5e3yD40lQ8xYuC8wn04JTHqe1t3WzlRS3FvXvPGdjqiTW4x7F2E167tb4VsFGq4IxhQoLmkeQ2FrovZeTA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB6024.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(261102123227099003)(261021121427099003)(261021123027099003)(38070700021)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0I3cGMrMEZiSFNtMHhKd2Fla3psc1V1eHpMUHpIYnFzSUw3enJWUVNHc0RH?=
 =?utf-8?B?Y0FYTXFqciszaXJwOHFpeUdQY2dwZkZGbnh6RkZQQVR1WGEyZ0ZEMmpDMzFm?=
 =?utf-8?B?QnZiditLcmRPd2ozR0JCNWx0amZQbjlDL05WYlRjSnJWdHpjMEFIeDdmK3FF?=
 =?utf-8?B?TXh2Z2JvSGxwcHJsSkJISnhMWUw4eUNwS3NzcmhvR0luK0Q4L0M0OGZnblll?=
 =?utf-8?B?QnpERlJwK2JVOXFFV3M5M1hkSmhBWisxdkVqbzVEUUxvVVRwUW1sNnZ4VG9M?=
 =?utf-8?B?d1IveUFHLy9CZFZwZ1AyaXNDdzY2MlBUUXpUdGF0MzhPNzFkWW51RHFIRDJ3?=
 =?utf-8?B?azJMejUvblY5SmpQM0g2QnVVOUlIRVRyQTRhSjNLQmhORnRqbFhnVnJKQTYr?=
 =?utf-8?B?cmhkczZNMmFTN1haL053MHBPZGhVQXVOQ3NOeldvYlBHb0dXYUl6bVNNMWJZ?=
 =?utf-8?B?TjZsRjJLT1dKKzgyajBaT0dscXA2a0VpTlRTNG8rT1kzZ3NiZkhFUGFDa3lB?=
 =?utf-8?B?L2dwWUE0M3kwZWJQTU96Vk85MzVnbHdwanpXc3JsbkhzNGl5bU9UaEpxdG02?=
 =?utf-8?B?UGo4eUtVOHRJSVFRbWRMMWExb3AzSnorK0YwelIzejFTWVdhNXpPYWdhUFZC?=
 =?utf-8?B?TlEybXVSL0dPZENDcC9mQWh3Q2tlcXdvMmRUN0puQVUxSFlXcExweG1YMndQ?=
 =?utf-8?B?T01IekNjL3c5TlZtVEg0ME9FSlIwVHdHWjYvbWg4ZmFHSXZCdGpOVUI2aUJT?=
 =?utf-8?B?MGdNanpZcktWNEV5bVNTNmJSeldRaVVMU3FsWUFEdG9EVXE5K3VHWXZ4dHVx?=
 =?utf-8?B?QlVaRmo1K3JPbk5aQko3dG9yaHozMWVyMUNVWmp1b255YVI0cjRueFFFUjV6?=
 =?utf-8?B?S3crNWloQzlnMm4yNE5FYzFZSnkyK29VcWJVZGVhSTVTWFU3RjhEaWtiSDRM?=
 =?utf-8?B?azNWbDZPakFDZzZXK1pPajd0bnRnMXhFcUd6Q2dTODlyTVBaS2hMZy9YUkly?=
 =?utf-8?B?V0tYeVZBNUZjN2VTUzdDaVNRL3BDcnJRK0JjVFRvNXdXZ2NJMkNTU0ZhS0tz?=
 =?utf-8?B?eFI5K25uNDY1YlpNTDVYUXBBcTR3WC9tOXlnVHlrcTllc293SEt0VTdjSDNR?=
 =?utf-8?B?YWNDK0gwTWJTMXF5RlFyOGdvalR0Zmo3Uld0clJuOEhpL3JGbFo0U3NkNVJy?=
 =?utf-8?B?ek01Z1hzTjhnOGIvRUtGWjhSdStVN2VSK2ZKODVVQjhtMUNWMmlIY0laSHUw?=
 =?utf-8?B?L1p4R1BSMndSVFJKM0JobUdkYWZSbVNEZ094K3ZwRGcxeFJjSjMwT21CaGJD?=
 =?utf-8?B?MmJaN2J2bVQvMkRjTlpBTmdWaWxVZlEvUDJUMjZvMFdLUEJKNWEvalNUdXFV?=
 =?utf-8?B?SkFmNk9PWVRRa3hxcUFpTHpPVHhmWXNMZFd5dlhUelU0L21QUGVmRmxzZHR2?=
 =?utf-8?B?R1dmS0JRR3BEVkdaZk45bWl1Yzg2VXY2U3NWYU16U0N4NVlwMU5rYlZzcTQ0?=
 =?utf-8?B?UG9LR3RwOCtxMi8wZWhmd002bndXU3owSGZINEhQeDNuRHJRN1gxRlI0ZC9h?=
 =?utf-8?B?b1poWGdva3UwNVJtUEVEZ1BFTU9hQklvWm53Vk5wbjN0YWJhRS9nL0EzQ1lR?=
 =?utf-8?B?RWgzM3pIdmU2ak00cVliWUgvTEZUVXZLK3BONkEyUVZuN01YcjZsUTNkcm42?=
 =?utf-8?B?SzFNNzFYYURDeEpybWNxY1dkaEZVRlhUWG1Ba1NzL1BDVjhGUU9qaDVBVXJr?=
 =?utf-8?B?OHE5OVR0VnkrWkdYSEpTdlRxdnhmaDRHbEJjdklic0l0T1c1dkRLL1lFNnZT?=
 =?utf-8?B?WDVjc0RkWDB4S2phTWs2QmdHalJwUHJRRk01cC9SQjN5YlRRazIzR0t1ZUFT?=
 =?utf-8?B?RmpYUzI2WTlVQUZ4eEs5aEVNY1h3d3Y3RGszTkI1MHdJeFZqOXFUREdhREJu?=
 =?utf-8?B?eGo5ZFZyZmYvZFliYjR0NkpNZ3VwMWd5K1FKYjFGbnRPbHV2QWoyTkVXbVhV?=
 =?utf-8?B?d3pqMWdXQkdBOEtEOCtjbkxZUDVqbG5OeFdMZW11aXNwOUFoRkp2QXgwSkVF?=
 =?utf-8?B?WmN4blBJR2h3MDdoVWIzRjMwbmROQmhxVGRzRzFxME54VndEcWs1eVJSdnh2?=
 =?utf-8?B?ZW9JUVljQURUTEJEZmxWY3ZwcVd0OXJmUWRFVC9QTDVSN1VhS2Y0RUZScGdl?=
 =?utf-8?B?VWhjOXBYdlh0bUt0Kzhpajl6M3hkVnpNakVnQmV0L00yYWZGenRUUEY1U0tr?=
 =?utf-8?B?TFNxOWxsRHoyS0doMU9MV0Ezb05DamM1VFpwZmRxS3M0MGc1Z3lRdXg0K0tE?=
 =?utf-8?B?SUJRY1pZQlZrc1ZLTnd6U1lEWXg5Z01IYVljWTBiRDBpVDZOcVp4enRZVVdy?=
 =?utf-8?Q?gEWhCzVqxAyq3wDY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A73EC26061BA6949A24F53658B02BDD7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CjGQMUYW5p3bLr4q2LHu4Si6ASjD1g3cL9wyXD2I84rbVhh7EV+s0YgJST09j5N6NVkugM8lvdfCZKNz5LIG8StFrQNqM24LyOBWP9Q3LI96I3nyP7suHX6tRwQ/cYWYZaH/zG+/k4hripc8kM3qoQvLl6AgZQOtk5NPP0/4UgT0rdar+NKiIOUT7FQn8FpfRnmxi2HxTpkUQ9dMgnbX3ckFy03cEwkbxTpOvBC6v6VgVVFWMl2i4/FVGsk1Ta+5ejtndvOOZBb5SLSwfN3ZSlRA+/kGoVQOXTCe+KCd53rSBLVjKPEyYl4/W4au9lImcvyPeHhSF7u+gHNuX5+kSA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e032ae6-9103-40dd-8d71-08df456990ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 11:46:21.2874 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MBMIKWn8mZpan78nMbD6OWm/knV4yn+/vbIwJSLNp+yH8CaBK0sD06lpnexkD+NxCfn/xkvyxrx8OmqAepFOxgDMkHmO8omZKoxtKlkQMdY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7867
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
PiBEaXZpZGUgdGhlIGF1eGxlc3Mgd2FrZSB0aW1lIGNhbGN1bGF0aW9uIGluIHBhcnRzIHdoaWNo
IHdpbGwNCj4gaGVscCBsYXRlciB0byBhZGQgWGUzcCByZWxhdGVkIG1vZGlmaWNhdGlvbi4NCj4g
DQo+IHYyOiBSZWZhY3RvciBmaXJzdCBleGlzdGluZyBjYWxjdWxhdGlvbi4gW0phbmldDQo+IHYz
OiBDb3NtZXRpYyBjaGFuZ2VzLiBbSmFuaSwgU3VyYWpdDQo+IHY0OiBLZWVwIG51bV9tbF9waHlf
bG9jayBmb3IgcmVhZGFiaWxpdHkgYW5kIHJldHVybiB0aGUNCj4gwqDCoMKgIGVzdGFibGlzaG1l
bnQgcGVyaW9kIGRpcmVjdGx5LiBbSm91bmldDQo+IA0KPiBCc3BlYzogNzE0NzcNCj4gQ2M6IEpv
dW5pIEjDtmdhbmRlciA8am91bmkuaG9nYW5kZXJAaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTog
U3VyYWogS2FuZHBhbCA8c3VyYWoua2FuZHBhbEBpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6
IEFuaW1lc2ggTWFubmEgPGFuaW1lc2gubWFubmFAaW50ZWwuY29tPg0KDQpSZXZpZXdlZC1ieTog
Sm91bmkgSMO2Z2FuZGVyIDxqb3VuaS5ob2dhbmRlckBpbnRlbC5jb20+DQoNCj4gLS0tDQo+IMKg
ZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9hbHBtLmMgfCAzMSArKysrKysrKysr
KysrKysrLS0tLS0NCj4gLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwg
OSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9k
aXNwbGF5L2ludGVsX2FscG0uYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50
ZWxfYWxwbS5jDQo+IGluZGV4IDEyZGM3OTE5ODQ5NC4uYWI2NjEyYjQ1MDZlIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0uYw0KPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0uYw0KPiBAQCAtMTA5LDYgKzEw
OSwyNSBAQCBzdGF0aWMgaW50IGdldF9sZnBzX2hhbGZfY3ljbGVfY2xvY2tzKGNvbnN0DQo+IHN0
cnVjdCBpbnRlbF9jcnRjX3N0YXRlICpjcnRjX3N0YXRlKQ0KPiDCoAkJMTAwMCAvICgyICogTEZQ
U19DWUNMRV9DT1VOVCk7DQo+IMKgfQ0KPiDCoA0KPiArc3RhdGljIGludCBnZXRfdHBoeTJfcDJf
dG9fcDAoY29uc3Qgc3RydWN0IGludGVsX2NydGNfc3RhdGUNCj4gKmNydGNfc3RhdGUpDQo+ICt7
DQo+ICsJcmV0dXJuIDEyICogMTAwMDsNCj4gK30NCj4gKw0KPiArc3RhdGljIGludCBnZXRfZXN0
YWJsaXNobWVudF9wZXJpb2QoY29uc3Qgc3RydWN0IGludGVsX2NydGNfc3RhdGUNCj4gKmNydGNf
c3RhdGUpDQo+ICt7DQo+ICsJaW50IHQxID0gNTAgKiAxMDAwOw0KPiArCWludCB0cHM0ID0gMjUy
Ow0KPiArCS8qIHBvcnRfY2xvY2sgaXMgbGluayByYXRlIGluIDEwa2JpdC9zIHVuaXRzICovDQo+
ICsJaW50IHRtbF9waHlfbG9jayA9IDEwMDAgKiAxMDAwICogdHBzNCAvIGNydGNfc3RhdGUtDQo+
ID5wb3J0X2Nsb2NrOw0KPiArCWludCBudW1fbWxfcGh5X2xvY2ssIHRjZHM7DQo+ICsNCj4gKwlu
dW1fbWxfcGh5X2xvY2sgPSA3ICsgRElWX1JPVU5EX1VQKDY1MDAsIHRtbF9waHlfbG9jaykgKyAx
Ow0KPiArCXRjZHMgPSBudW1fbWxfcGh5X2xvY2sgKiB0bWxfcGh5X2xvY2s7DQo+ICsNCj4gKwly
ZXR1cm4gU0lMRU5DRV9QRVJJT0RfVElNRSArIHQxICsgdGNkczsNCj4gK30NCj4gKw0KPiDCoC8q
DQo+IMKgICogQVVYLUxlc3MgV2FrZSBUaW1lID0gQ0VJTElORyggKChQSFkgUDIgdG8gUDApICsg
dExGUFNfUGVyaW9kLA0KPiBNYXgrDQo+IMKgICogdFNpbGVuY2UsIE1heCsgdFBIWSBFc3RhYmxp
c2htZW50ICsgdENEUykgLyB0bGluZSkNCj4gQEAgLTEzMCwxNyArMTQ5LDExIEBAIHN0YXRpYyBp
bnQgZ2V0X2xmcHNfaGFsZl9jeWNsZV9jbG9ja3MoY29uc3QNCj4gc3RydWN0IGludGVsX2NydGNf
c3RhdGUgKmNydGNfc3RhdGUpDQo+IMKgICovDQo+IMKgc3RhdGljIGludCBfbG5sX2NvbXB1dGVf
YXV4X2xlc3Nfd2FrZV90aW1lKGNvbnN0IHN0cnVjdA0KPiBpbnRlbF9jcnRjX3N0YXRlICpjcnRj
X3N0YXRlKQ0KPiDCoHsNCj4gLQlpbnQgdHBoeTJfcDJfdG9fcDAgPSAxMiAqIDEwMDA7DQo+IC0J
aW50IHQxID0gNTAgKiAxMDAwOw0KPiAtCWludCB0cHM0ID0gMjUyOw0KPiAtCS8qIHBvcnRfY2xv
Y2sgaXMgbGluayByYXRlIGluIDEwa2JpdC9zIHVuaXRzICovDQo+IC0JaW50IHRtbF9waHlfbG9j
ayA9IDEwMDAgKiAxMDAwICogdHBzNCAvIGNydGNfc3RhdGUtDQo+ID5wb3J0X2Nsb2NrOw0KPiAt
CWludCBudW1fbWxfcGh5X2xvY2sgPSA3ICsgRElWX1JPVU5EX1VQKDY1MDAsIHRtbF9waHlfbG9j
aykgKw0KPiAxOw0KPiAtCWludCB0MiA9IG51bV9tbF9waHlfbG9jayAqIHRtbF9waHlfbG9jazsN
Cj4gLQlpbnQgdGNkcyA9IDEgKiB0MjsNCj4gKwlpbnQgdHBoeTJfcDJfdG9fcDAgPSBnZXRfdHBo
eTJfcDJfdG9fcDAoY3J0Y19zdGF0ZSk7DQo+ICsJaW50IGVzdGFibGlzaG1lbnRfcGVyaW9kID0N
Cj4gZ2V0X2VzdGFibGlzaG1lbnRfcGVyaW9kKGNydGNfc3RhdGUpOw0KPiDCoA0KPiDCoAlyZXR1
cm4gRElWX1JPVU5EX1VQKHRwaHkyX3AyX3RvX3AwICsNCj4gZ2V0X2xmcHNfY3ljbGVfdGltZShj
cnRjX3N0YXRlKSArDQo+IC0JCQnCoMKgwqAgU0lMRU5DRV9QRVJJT0RfVElNRSArIHQxICsgdGNk
cywgMTAwMCk7DQo+ICsJCQnCoMKgwqAgZXN0YWJsaXNobWVudF9wZXJpb2QsIDEwMDApOw0KPiDC
oH0NCj4gwqANCj4gwqBzdGF0aWMgaW50DQo=
