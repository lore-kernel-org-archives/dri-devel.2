Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D4E606A32A
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DEmuPrc0;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=E0RErLUf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 677C810FB69;
	Wed, 18 Nov 2026 12:05:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D7D010FB69;
 Wed, 18 Nov 2026 12:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795003535; x=1826539535;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=J+9FVg+9L4/u0U0D2FdYNfPe7j25FUFHNxBjWdMUGmI=;
 b=DEmuPrc0VMthKX7hoGfm0kO/Uz9uf+Ok152Awja8pBSMFyVB4MyzY0eO
 7hvr7wAKiMq0EeH8Yjqu/S6Awv4ykLNFqoUm0PSW7uutoUtjs+OuOVDyp
 r62AplX7FTkdfnEdJFbUO67rkzrq0BtGJNe0NeQH7n6lJ5Yt7GBj072HG
 dQ76srxZuvKL2vMRZNIiUbSVdmkS1H+m0x42SJQ/RogPSjdNXx23X266s
 ut7BMEBrDB2VGzOIoZRJGNXuaZUhFl8vsUFCFvVptQrd9gKgucvjecGLx
 3VEzX5VAHfwTZ6V2OK+fewOdtOw8a0Zu4VpA/7H67OaCQz7DQschSNgz8 g==;
X-CSE-ConnectionGUID: jBwryahTQASYTL/y8EsMmw==
X-CSE-MsgGUID: Qi5KDbHPR2Cr8n5gv1EeAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3727263"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3727263"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 04:05:35 -0800
X-CSE-ConnectionGUID: cbRTtURPSj6+MW18RqdjOA==
X-CSE-MsgGUID: 3vOm11XnR2qaoNPAaRwn8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10145722"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 04:05:35 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 04:05:34 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 04:05:34 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.12) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 04:05:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DiDhqsdAAHoNR4vDhKYaQ5AGo0m2KjWJRGQJj9WP+2d937tLxWI4jHkulXg7pG9PAwvmU7+Z7CnraRoFW2ImbV6Fg3LVE3FF7mJrSjjdOhLyuh1QxQBS1Vh0flNkM+bUDaOdQO+Af3kZMaF5+UMWkZAP8K2BzXu7GQ3nu9fUAbehR/PftWq2A2hJ+a5SAr1vd6Ys5Y0zP++M0ZMYVUpcA3nL0YDLFSIIOj3o+4akHZTtknSQfVvYXqxvWTeIh3HPLNKv7FwihCek8zCBwoH6jFHCB7T7oxQkcZJIC7D4z3RzeC/I8aNXgttI5z35463litVDjGYZEWb6InsuzYuYfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+9FVg+9L4/u0U0D2FdYNfPe7j25FUFHNxBjWdMUGmI=;
 b=MixK3agp6gMDY20qzrPrM5AutTtTyVs1MrebMnCH+484iUovba/6ffHpaHbUyXemksuES4N9lrDBYudaVZlPAZ5m/4K9h5+gdh4vWhw+yWNtCRSWu/qQ+xLTbBnWyy2DuuvXA1UeoD1OgnlOp4iSiNECrZDtbByTCJYoAwB2zgdMhjjNGGfaNtOXubA3JhgaR64JLzYYzOB8qsr2IbVPeK/gZaAOvH0l57DNNzJiYMiYVCbBTgiHIQiZfB9UPlCbRpT1meeWeNAGSz3HijyL2udlqBUghFxiB13V5DwL8NgGpLvHHP0b+xCDskcjCROFgFM/oDMvCnbFwPLfV0LRyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+9FVg+9L4/u0U0D2FdYNfPe7j25FUFHNxBjWdMUGmI=;
 b=E0RErLUfqgdhBgEh2LdKv8lWOCZBGb2mEW2MILbaFmCdzCKvdnNsc53E3uV0mEONHq/kv1w31feBhMYyajAXCskCtL056xzd2+tUAxUXsOsRmSLUHzfw0kg2OSouIhWOF/r54koFUKSxlF++U+80V3hTSjwgF0xKAJV1OeogULM=
Received: from LV2PR11MB6024.namprd11.prod.outlook.com (2603:10b6:408:17a::16)
 by IA0PR11MB8377.namprd11.prod.outlook.com (2603:10b6:208:487::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 12:05:32 +0000
Received: from LV2PR11MB6024.namprd11.prod.outlook.com
 ([fe80::38ad:3190:bbb2:412b]) by LV2PR11MB6024.namprd11.prod.outlook.com
 ([fe80::38ad:3190:bbb2:412b%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 12:05:32 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Manna,
 Animesh" <animesh.manna@intel.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>
CC: "Kandpal, Suraj" <suraj.kandpal@intel.com>, "Nikula, Jani"
 <jani.nikula@intel.com>
Subject: Re: [PATCH v7 08/20] drm/i915/alpm: Modify AUX_LESS_WAKE_TIME
 bitfield for xe3lpd
Thread-Topic: [PATCH v7 08/20] drm/i915/alpm: Modify AUX_LESS_WAKE_TIME
 bitfield for xe3lpd
Thread-Index: AQHdZQyRfn4M+thqS0qGkzGlDaI6qrcz4BwA
Date: Wed, 18 Nov 2026 12:05:31 +0000
Message-ID: <bc70e753f815029eb3836f7b4f34ecd5e6411120.camel@intel.com>
References: <20261026054001.799894-1-animesh.manna@intel.com>
 <20261026054001.799894-9-animesh.manna@intel.com>
In-Reply-To: <20261026054001.799894-9-animesh.manna@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6024:EE_|IA0PR11MB8377:EE_
x-ms-office365-filtering-correlation-id: d099bad5-160d-4b92-fc69-08df456c3ead
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|261009223027099003|22082099003|18002099003|261009221227099003|56012099006|4143699003|11063799006|261102123227099003|261022075727099003|261021123027099003|261021121427099003|38070700021|10067099003;
x-microsoft-antispam-message-info: L2dCNSIT3JjTL3UlOJdHXdKRyL7vk3x4O7d2CPz3LLyp8caARvZAxjx4czKXhnT4N9loHDHJHF2CMQk48QNzN4r+/rmGHFdjYaXzChTzSXJyaabjKFpcwtwmLnCWtLyN+Nn1q+hD8OexTt6DXLyu/dFMLhbY7mGentr/vQxHV75Mc/Y05PftjyM9fc6AQ7aofsf84k6+yxta6IVKqpDdQ8T5z1FShVuXgpPCMMmfE/tJglfU7k5WSxwu4xt0LZ65+z0eoJ5GQEQ7zEJz23U8ZnOYtWPR7KzaDjDXKOHo4fY1ix5QyrsvnEffN/zuZiTkuzFrBe2PIaQ+dGUPEANIuH3iLf2+BYeEO9BTxmrsvrlKVLd3BEfcgVKsPFmCDMYbzFqISSlwqYpcDR/o7s72+rgjYwkOR97Uf2y9niSgR9yAKGxzGLZX9/TbG2/4m4kUZzzgrD6oJ2aoalgZUF5Vw40OdcV1bNblpA2Q8IzQx4XY7TtayrfUCuyyvMwiCF/lA4/DmuB+C1+bxGhpTJ0MUqXrJw6VJBe86ARLyPrt8n8R6na0/CE5dSfIUQ+r6VJ3sslXpvccgfxW2kxkRTXaiCBsbBhBnJG1mY7ne9fd2MFdiZbwESJ3cyuK71aXEtrseloWmQHStoo6/OdUHktSM3XJ4jv1s9o9QFR6Hu69pMyaKU7XD7kV9Ocw/RVEswzvA/qcZS+QZ6rpuwjCTCIVr0sck7pVYD3xg5EnSf1fR2I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB6024.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(261009223027099003)(22082099003)(18002099003)(261009221227099003)(56012099006)(4143699003)(11063799006)(261102123227099003)(261022075727099003)(261021123027099003)(261021121427099003)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVhsNEk3aHhlaXc3a0lvWlNuTlRoRFFRTU9QV1BuQ2R5WCtJTTJtanlFSnZy?=
 =?utf-8?B?MXBzd0xkNk9nODZSbnJMVkhVTEFaZWZ0eGE1WG1NMWpwQkFpczVjQWd2SFJJ?=
 =?utf-8?B?MDFCUWN3Zy9mc0pOZGRZM1M2YjFKV2dIeElMZUlUTVJiL2ZYemFSNHR0ZWRi?=
 =?utf-8?B?OEkvTEFvdFJDNkkwTDJ1NVF1STR3UWxMQXQwYVE4SEVVM00wWGF1Um9MZzFk?=
 =?utf-8?B?OVNqK3NNbW0xMWlkQS9xVHFwU01la01VbG0wUXlsYzNBLytpSUY1bDVWVnRl?=
 =?utf-8?B?S0l4Q3pxazB6YmlMU1hWU3ZoTEtPbHRmeGxFd1dZY0FsSjlmZGpTeFRLVUd6?=
 =?utf-8?B?ZXdka3lwaENQbHRnNWtTWktJZGpmSzVTNkFsY205c2N4UkEzSW01WDdTMnJG?=
 =?utf-8?B?SmVBdEZmeldzWm03NmV6bURkTTVMMFJMNVk2dFV2TWFqUTRlQU5sTWdHQTgw?=
 =?utf-8?B?QUVrRGgvYXVCMitzaW8rUENMRnRONDNtNTdCTHd2Zk1WeUk4ejcrcnAvTnlS?=
 =?utf-8?B?K0dKNVBYTXg3Ui9MbEx1Q09xbEVZOExaeS9XZXZsNkZXbDluZnNaQXB6bzRx?=
 =?utf-8?B?SlRQOHR5c3pGR0FPeFRrT08vczc0MUpkNVY1dFpOMFVmVjk2VG84eC80V1V4?=
 =?utf-8?B?RCtuVFU2RWpTL1FCelA4SU5BU25QRk52TzZuUzlCaFFzamRQeGVmMkYrMWVX?=
 =?utf-8?B?VldyWmoxMzZiRWdqVGMzUU9GUUdCd3dnbFFYMU5nNWd0ZEE3aHozemVjclVT?=
 =?utf-8?B?Y0hJSUpoMXZXamluQUFXb3JHdnNEcmFGbWtrLzJaWm9nV1dKcXk4by9UUFFB?=
 =?utf-8?B?bnNBK2ZnRlJWbkFnaHFqTVNBbzR1TzJmQ0NSSFNYSGtVRWNkUFlrMFl6VEg3?=
 =?utf-8?B?anFvajh6UEtZWWcyVXFENE5TZjJBREludWN6TFBmTVlkY1hWZEtjVURSdXdk?=
 =?utf-8?B?ZTd3eWRKWHoyVWxGU2ZDei9LL01UbllQcWR0NkpPV1k2TjM1SkdEUGoyT1Ja?=
 =?utf-8?B?TTlEdDBjdjd6Kyt3UlR3TWdMR2w5UzBUcTR2U0R2YmcyRjhTY1VsRHdrMHRp?=
 =?utf-8?B?OVRJWlR3SmFZYy81MmNKVW0vZ0QzMW1WSys4ZVYxbnVHeEpZS1ZOU3pXYkJ3?=
 =?utf-8?B?dy9TOVgvSnhGaG1mWlVvTml4WnljbThNZEJsclRuN3pqL1ZCeEkyWURwTWNy?=
 =?utf-8?B?RzlwUlVGcWJEZ0taMmd6NDdFVjZ2ek0va3I4cWtZNmNlNUhaSHVsbGlGK2Zk?=
 =?utf-8?B?cklwTURHbm00WEU0c2JVOEZOS3Y3dUF1a25zYlowa1k3SitRUzZWWHFXTDR1?=
 =?utf-8?B?SE9SMjhrRUIrN0hiTjdKSkw4bnZ3K0llcXhBSDVSWGtRYVZCRTFwamtJOFRV?=
 =?utf-8?B?Z3A3Qys3a1N0OC9abkIrZVh2TWpLQjJiYnhoSVB5VlJQRHc4anI0ek1YWS9C?=
 =?utf-8?B?K1pvTUJvY1FpeEdiSjZlRk41Njh4VGliODkvNGxNN01RL2JjZ0s5VEVKcmVm?=
 =?utf-8?B?SWJrWG82VXJTMDloc1p4MWptS1J4U0lQWU15dmpUY1NSNUlQdnhjM2dkMVBu?=
 =?utf-8?B?NDJydnBwR0prbG1NWE5KWEE4ODNFOVdlVThRZlRSUUhncGRQdjA1ZG81Vmpo?=
 =?utf-8?B?UGZzY2ZYZk05L2V0aHN5Ym5Db1BXdnAvRXhBYVBaamRUdWc3QXRXY09acXBp?=
 =?utf-8?B?cllOWnJWakFzWWFicFpab0hIdTQrdjlwUmlFQ0gxeGo0cFVULy9MMm1Ea09T?=
 =?utf-8?B?a21PYlAzRGRwTU13SzJLMHJQN0JHR0hkNDBsNGVYRzhJdDJWbUZGS29ZdDF6?=
 =?utf-8?B?b0JJSFMyVlJOQmd0dmlLLzhDa2NTTEwwQmVjb3VNbUxic0ErSThpWmw3Nld3?=
 =?utf-8?B?OStLQ0F3NHhid29hb3VlSmQ0bGxuNXRNWmxwRm5nNUlqeml0djZzV1dXV3Zk?=
 =?utf-8?B?bFJXVGpmek04N0JNYmpmNkoyZENkemlaZmVIbVZlL2lOL2hTbk1oc0NVdnZS?=
 =?utf-8?B?Qks3MVRpVGxXUFdvVGJWZHcvaGFZYXJFbEo5dkE4UDhKbXA4SVQ0VG9tVmlu?=
 =?utf-8?B?SW5aRldoa3Fwb3Z1NitXb0hHU1FvNzNYU1FPRmhHb3RlTDFjMUZhSHpFYjE0?=
 =?utf-8?B?SUFEalA0S0hNcW1rTFdjZ00zYm5OMHJJWkxIQjBvUUZ3WWU3MTFPWnJXNjBw?=
 =?utf-8?B?Q3BKMlpwcDdLcEhJRDFEUFVGaVgyZExUTXJzY01jL1lqTHFMbGhtM20za0ly?=
 =?utf-8?B?N2lJM2tiYXppSWw3NGlFYjhUNloxTE9rb0hoL0VtQnVCVmlyOG1MVWlhaldp?=
 =?utf-8?B?N2lhbVN6STNnY3RtYnpKUzRoRmFoc3oxdlV3KytWNjVmdHpXOWI4ejJud2Yw?=
 =?utf-8?Q?Uoen7V3aQXE6/Iwk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4318657E5305F4FA3B030C5E415B0C8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: zyT60XRiqLfwJL2c8V9cfVWtMFzgnpoA1+kV5JGKSRG9KwbLMGgUGT4nQLTI6ldGSBpKJsSAfPzvubQvlWatD/rfSttcKQIWrlMQtgAhlhZq3GgXDmKI+VR0aPnPhMxtRX9zXD+RtSQlbsi7GqiZlnvOBpK1ztHXf/70Msx2xrXxH56o679sqWuVr2Ys3lCV80V0t4XMot21Lx8xtcZApF0cFxVX6KBfsMihEFlQbtrXKtK42IMXg5z2kzxcKVqFi8rTKJDLTNMj41vpL4hDjG+qyj5C+yqrgkZF4i9Ocv6HDA30Pvau2ahodk5cQrmYUXALe76OBOZe4E3c2/KdeQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d099bad5-160d-4b92-fc69-08df456c3ead
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 12:05:31.9814 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nZY6Z/nhfd5ryhcWlItYE7wAIIfLaUzaXtAtKJOX24cKfAbt/lgZ0XwbRbKyFGumwd+UZbR23cjaQwKUjJlxrVadMAY0E0KKXsurnJ3LaMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8377
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gTW9uLCAyMDI2LTEwLTI2IGF0IDExOjA5ICswNTMwLCBBbmltZXNoIE1hbm5hIHdyb3RlOg0K
PiBUaGUgQVVYX0xFU1NfV0FLRV9USU1FIGJpdGZpZWxkIGluIEFMUE1fQ1RMIGlzIHdpZGVuZWQg
ZnJvbSA2IGJpdHMgdG8NCj4gOCBiaXRzIHN0YXJ0aW5nIGZyb20geGUzbHBkIChkaXNwbGF5IHZl
cnNpb24gMzUpLiBBZGQgdGhlIHJlZ2lzdGVyDQo+IG1hc2sNCj4gYW5kIGZpZWxkIG1hY3JvIGZv
ciB0aGUgd2lkZXIgYml0ZmllbGQgYW5kIHByb2dyYW0gdGhlIHdha2UgdGltZQ0KPiB1c2luZw0K
PiB0aGUgYXBwcm9wcmlhdGUgbWFjcm8gYmFzZWQgb24gdGhlIGRpc3BsYXkgdmVyc2lvbi4gQWxz
byB1c2UgdGhlDQo+IHdpZGVyDQo+IGxpbWl0IHdoZW4gdmFsaWRhdGluZyB0aGUgY29tcHV0ZWQg
d2FrZSBsaW5lcyBhbmQgZm9yIHRoZSBzYWZlc3QNCj4gcGFyYW1zDQo+IGZhbGxiYWNrLg0KPiAN
Cj4gdjI6IE1vZGlmeSBBVVhfTEVTU19XQUtFX1RJTUUgYml0ZmllbGQgZm9yIHhlM2xwZC4gW1N1
cmFqXQ0KPiB2MzogU2VwYXJhdGUgb3V0IEFVWF9MRVNTX1dBS0VfVElNRSBiaXRmaWVsZCBjaGFu
Z2UgaW50byBpdHMgb3duDQo+IHBhdGNoLiBbSm91bmldDQo+IHY0OiBVc2UgdGhlIHdpZGVyIGJp
dGZpZWxkIGxpbWl0IGluIGF1eC1sZXNzIHdha2UgdGltZSBjb21wdXRhdGlvbg0KPiBhbmQgc2Fm
ZXN0IHBhcmFtcy4gW0pvdW5pLCBzYXNoaWtvXQ0KPiANCj4gQnNwZWM6IDcxNDc3DQo+IENjOiBK
b3VuaSBIw7ZnYW5kZXIgPGpvdW5pLmhvZ2FuZGVyQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1i
eTogQW5pbWVzaCBNYW5uYSA8YW5pbWVzaC5tYW5uYUBpbnRlbC5jb20+DQoNClJldmlld2VkLWJ5
OiBKb3VuaSBIw7ZnYW5kZXIgPGpvdW5pLmhvZ2FuZGVyQGludGVsLmNvbT4NCj4gLS0tDQo+IMKg
ZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9hbHBtLmPCoMKgwqDCoCB8IDIwICsr
KysrKysrKysrKysrKy0tDQo+IC0tDQo+IMKgZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9p
bnRlbF9wc3JfcmVncy5oIHzCoCAyICsrDQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAxOCBpbnNlcnRp
b25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlz
cGxheS9pbnRlbF9hbHBtLmMNCj4gaW5kZXggYjllMzFjMjlhYjk2Li4wMDgzNzUyZDk0ZjAgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5jDQo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5jDQo+IEBAIC0y
MDQsNiArMjA0LDEyIEBAIHN0YXRpYyBpbnQNCj4gX2xubF9jb21wdXRlX2F1eF9sZXNzX3dha2Vf
dGltZShzdHJ1Y3QgaW50ZWxfZHAgKmludGVsX2RwLA0KPiDCoAkJCcKgwqDCoCBlc3RhYmxpc2ht
ZW50X3BlcmlvZCwgMTAwMCk7DQo+IMKgfQ0KPiDCoA0KPiArc3RhdGljIGludCBnZXRfYXV4X2xl
c3Nfd2FrZV9saW5lc19tYXgoc3RydWN0IGludGVsX2Rpc3BsYXkNCj4gKmRpc3BsYXkpDQo+ICt7
DQo+ICsJcmV0dXJuIERJU1BMQVlfVkVSKGRpc3BsYXkpID49IDM1ID8NCj4gQUxQTV9DVExfQVVY
X0xFU1NfV0FLRV9USU1FX01BU0tfWEUzTFBEIDoNCj4gKwkJCQkJwqDCoMKgDQo+IEFMUE1fQ1RM
X0FVWF9MRVNTX1dBS0VfVElNRV9NQVNLOw0KPiArfQ0KPiArDQo+IMKgc3RhdGljIGludA0KPiDC
oF9sbmxfY29tcHV0ZV9hdXhfbGVzc19hbHBtX3BhcmFtcyhzdHJ1Y3QgaW50ZWxfZHAgKmludGVs
X2RwLA0KPiDCoAkJCQnCoCBzdHJ1Y3QgaW50ZWxfY3J0Y19zdGF0ZQ0KPiAqY3J0Y19zdGF0ZSkN
Cj4gQEAgLTIyMCwxNCArMjI2LDE0IEBAIF9sbmxfY29tcHV0ZV9hdXhfbGVzc19hbHBtX3BhcmFt
cyhzdHJ1Y3QNCj4gaW50ZWxfZHAgKmludGVsX2RwLA0KPiDCoA0KPiDCoAlsZnBzX2hhbGZfY3lj
bGUgPSBnZXRfbGZwc19oYWxmX2N5Y2xlX2Nsb2NrcyhjcnRjX3N0YXRlKTsNCj4gwqANCj4gLQlp
ZiAoYXV4X2xlc3Nfd2FrZV9saW5lcyA+IEFMUE1fQ1RMX0FVWF9MRVNTX1dBS0VfVElNRV9NQVNL
DQo+IHx8DQo+ICsJaWYgKGF1eF9sZXNzX3dha2VfbGluZXMgPg0KPiBnZXRfYXV4X2xlc3Nfd2Fr
ZV9saW5lc19tYXgoZGlzcGxheSkgfHwNCj4gwqAJwqDCoMKgIHNpbGVuY2VfcGVyaW9kID4gUE9S
VF9BTFBNX0NUTF9TSUxFTkNFX1BFUklPRF9NQVNLIHx8DQo+IMKgCcKgwqDCoCBsZnBzX2hhbGZf
Y3ljbGUgPCAxIHx8DQo+IMKgCcKgwqDCoCBsZnBzX2hhbGZfY3ljbGUgPg0KPiBQT1JUX0FMUE1f
TEZQU19DVExfTEFTVF9MRlBTX0hBTEZfQ1lDTEVfRFVSQVRJT05fTUFTSyArIDEpDQo+IMKgCQly
ZXR1cm4gZmFsc2U7DQo+IMKgDQo+IMKgCWlmIChkaXNwbGF5LT5wYXJhbXMucHNyX3NhZmVzdF9w
YXJhbXMpDQo+IC0JCWF1eF9sZXNzX3dha2VfbGluZXMgPQ0KPiBBTFBNX0NUTF9BVVhfTEVTU19X
QUtFX1RJTUVfTUFTSzsNCj4gKwkJYXV4X2xlc3Nfd2FrZV9saW5lcyA9DQo+IGdldF9hdXhfbGVz
c193YWtlX2xpbmVzX21heChkaXNwbGF5KTsNCj4gwqANCj4gwqAJY3J0Y19zdGF0ZS0+YWxwbV9z
dGF0ZS5hdXhfbGVzc193YWtlX2xpbmVzID0NCj4gYXV4X2xlc3Nfd2FrZV9saW5lczsNCj4gwqAJ
Y3J0Y19zdGF0ZS0+YWxwbV9zdGF0ZS5zaWxlbmNlX3BlcmlvZF9zeW1fY2xvY2tzID0NCj4gc2ls
ZW5jZV9wZXJpb2Q7DQo+IEBAIC02MTcsMTAgKzYyMywxNiBAQCBzdGF0aWMgdm9pZCBsbmxfYWxw
bV9jb25maWd1cmUoc3RydWN0IGludGVsX2RwDQo+ICppbnRlbF9kcCwNCj4gwqAJICogY2hlY2sg
cGFuZWwgc3VwcG9ydCBhdCB0aGlzIHBvaW50Lg0KPiDCoAkgKi8NCj4gwqAJaWYgKGludGVsX2Fs
cG1faXNfYWxwbV9hdXhfbGVzcyhpbnRlbF9kcCwgY3J0Y19zdGF0ZSkpIHsNCj4gKwkJaW50IHdh
a2VfbGluZXMgPSBjcnRjX3N0YXRlLQ0KPiA+YWxwbV9zdGF0ZS5hdXhfbGVzc193YWtlX2xpbmVz
Ow0KPiArDQo+IMKgCQlhbHBtX2N0bCA9IEFMUE1fQ1RMX0FMUE1fRU5BQkxFIHwNCj4gwqAJCQlB
TFBNX0NUTF9BTFBNX0FVWF9MRVNTX0VOQUJMRSB8DQo+IC0JCQlBTFBNX0NUTF9BVVhfTEVTU19T
TEVFUF9IT0xEX1RJTUVfNTBfU1lNQk9MUw0KPiB8DQo+IC0JCQlBTFBNX0NUTF9BVVhfTEVTU19X
QUtFX1RJTUUoY3J0Y19zdGF0ZS0NCj4gPmFscG1fc3RhdGUuYXV4X2xlc3Nfd2FrZV9saW5lcyk7
DQo+ICsJCQlBTFBNX0NUTF9BVVhfTEVTU19TTEVFUF9IT0xEX1RJTUVfNTBfU1lNQk9MUw0KPiA7
DQo+ICsNCj4gKwkJaWYgKERJU1BMQVlfVkVSKGRpc3BsYXkpIDwgMzUpDQo+ICsJCQlhbHBtX2N0
bCB8PQ0KPiBBTFBNX0NUTF9BVVhfTEVTU19XQUtFX1RJTUUod2FrZV9saW5lcyk7DQo+ICsJCWVs
c2UNCj4gKwkJCWFscG1fY3RsIHw9DQo+IEFMUE1fQ1RMX0FVWF9MRVNTX1dBS0VfVElNRV9YRTNM
UEQod2FrZV9saW5lcyk7DQo+IMKgDQo+IMKgCQlpZiAoaW50ZWxfZHAtPmFzX3NkcF9zdXBwb3J0
ZWQpDQo+IMKgCQkJaW50ZWxfYWxwbV9jb25maWd1cmVfcHJfYXNfc2RwKGludGVsX2RwLA0KPiBj
cnRjX3N0YXRlKTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkv
aW50ZWxfcHNyX3JlZ3MuaA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxf
cHNyX3JlZ3MuaA0KPiBpbmRleCA3OGEwNTM4N2VhYjUuLjEyNGFhNzRlMWRiYiAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9wc3JfcmVncy5oDQo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfcHNyX3JlZ3MuaA0KPiBAQCAt
MzAxLDcgKzMwMSw5IEBADQo+IMKgI2RlZmluZcKgIEFMUE1fQ1RMX0VYVEVOREVEX0ZBU1RfV0FL
RV9NSU5fTElORVMJCTUNCj4gwqAjZGVmaW5lwqANCj4gQUxQTV9DVExfRVhURU5ERURfRkFTVF9X
QUtFX1RJTUUobGluZXMpCVJFR19GSUVMRF9QUkVQKEFMUE1fQ1RMX0VYVEVOREVEX0ZBU1RfV0FL
RV9USU1FX01BU0ssKGxpbmVzKS1BTFBNX0NUTF9FWFRFTkRFRF9GQVNUX1dBS0VfTUlOX0xJTkVT
KQ0KPiDCoCNkZWZpbmXCoA0KPiBBTFBNX0NUTF9BVVhfTEVTU19XQUtFX1RJTUVfTUFTSwkJUkVH
X0dFTk1BU0soNSwgMCkNCj4gKyNkZWZpbmXCoA0KPiBBTFBNX0NUTF9BVVhfTEVTU19XQUtFX1RJ
TUVfTUFTS19YRTNMUEQJUkVHX0dFTk1BU0soNywgMCkNCj4gwqAjZGVmaW5lwqANCj4gQUxQTV9D
VExfQVVYX0xFU1NfV0FLRV9USU1FKHZhbCkJCVJFR19GSUVMRF9QUkVQKEFMUE1fQ1RMX0FVWF9M
RVNTX1dBS0VfVElNRV9NQVNLLHZhbCkNCj4gKyNkZWZpbmXCoA0KPiBBTFBNX0NUTF9BVVhfTEVT
U19XQUtFX1RJTUVfWEUzTFBEKHZhbCkJUkVHX0ZJRUxEX1BSRVAoQUxQTV9DVExfQVVYX0xFU1Nf
V0FLRV9USU1FX01BU0tfWEUzTFBELHZhbCkNCj4gwqANCj4gwqAjZGVmaW5lIF9BTFBNX0NUTDJf
QQkweDYwOTU0DQo+IMKgI2RlZmluZSBBTFBNX0NUTDIoZGV2X3ByaXYsIHRyYW4pCV9NTUlPX1RS
QU5TMihkZXZfcHJpdiwgdHJhbiwNCj4gX0FMUE1fQ1RMMl9BKQ0K
