Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D95606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 19:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jQupgkWk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3A6C10F1BC;
	Mon,  2 Nov 2026 19:33:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC0EF10F1B3;
 Mon,  2 Nov 2026 19:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793647997; x=1825183997;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=o297WHouOgMNqOalVRe5051KvTVAemlUv09vk24dvtw=;
 b=jQupgkWkUEOtSt8MKRwDOAgCZ01joAV0OFcRnyjrFLs9yebsM65hFrX3
 FrPdpHlg4Lffm1o/KYio4b5566j5uc9FLDIINQ6CWwAwbGi8G4uEIjudp
 aEX7BnBsrPyEvzjpYecDZKWI+bcJI1mrwTDVGE9bspStIYL4bn+w41dCz
 viakh2JJOP/SYcChBtyX65K/I+zOKiwzDUbWjLjFbl5IFiCocP5DI2wO/
 E++ymi43MX4ZVXOMiYaRHTBYv0tPLNwXBvucodsqmxmc4nN6CNiRl05Hl
 vbVRQSS/BYSiUsrCVzSdhqw7+n6axHxIsragEDpLrDKYk3/JmL24wSb2u g==;
X-CSE-ConnectionGUID: EThjor8/RrWnEuLf1rZZWA==
X-CSE-MsgGUID: hZyLs8I/Tly09FagoE8TkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2362318"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2362318"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 11:33:16 -0800
X-CSE-ConnectionGUID: 4YRjUSMvSV6/3hbGR1uk0g==
X-CSE-MsgGUID: GSltIIKnSQaxmBhvbUDSgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6332835"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 11:33:15 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 11:33:14 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 11:33:14 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.51) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 11:33:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bdhRdjZBY8qnst2KlmwaD9XEny5MaCtjvDRr3qkLdduixONfLD5lkZQjZNAg7tRuNgih5iK27vgSSe5v4HA/7sOJ58L4596EvTRiiV23FaEtAtmkV6ZLu16oPrvZHdZR00mDzQv1EBkmh0oDaHH0Uq6rTWm55/k6bjMCiGgMS4mA1uJGC/jAs6TBixFWakRS2rgKKOWKjai/b1jp9vXG0Fix2wxZK3Yqx18WxikaZANz2wny8g3OUB8z+bq3M8SRmE97YsazAv4wamhcZm7KEt3kPRzhDJJGwiUvlBKCw+v5ThUPrdISBLHGf1t74qBu0ssJvzOkPZKGWsjxctYM0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o297WHouOgMNqOalVRe5051KvTVAemlUv09vk24dvtw=;
 b=EUi78sy1HVHO7fXZ/+jQb5baYGH8HGp/8GRbmY77UhQud4hjVh6L2g2ilKllNiGWWAeizZu1OcUkfnR3ClWTdMJ9SunEq2bpEk1OI9YGn384Rhi+dGVNiPy1UbDsj3ziPcSY2Mjhkz8nOnJS9M49eZEWbhGfeFPfgz4EEJuAX3p2hFItPepMpUzy8pVGOKFkp9LG7UtNIJteIoZLzOFU5TB0LgdURGGyn6npPeRZW+JdxXXuR4F38UJKhdIEkSYorihKr6KLXmpPF7dzzshxcHHLoyudEJlddyOFAk0jSSn7jE/WL35nIxmDYe0OYb6MAQGfp1gNL8TnzPBJ8QwSiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LVWPR11MB9883.namprd11.prod.outlook.com (2603:10b6:408:3c0::11)
 by CH9PR11MB9903.namprd11.prod.outlook.com (2603:10b6:610:341::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 19:33:12 +0000
Received: from LVWPR11MB9883.namprd11.prod.outlook.com
 ([fe80::310:e83f:69b8:e11e]) by LVWPR11MB9883.namprd11.prod.outlook.com
 ([fe80::310:e83f:69b8:e11e%4]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 19:33:12 +0000
From: "Teres Alexis, Alan Previn" <alan.previn.teres.alexis@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Tauro, 
 Riana" <riana.tauro@intel.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "Jadav, Raag" <raag.jadav@intel.com>, "Roper, Matthew D"
 <matthew.d.roper@intel.com>
Subject: Re: [PATCH 1/1] drm/xe/survivability: broadcast dmesg when engaging
 survivability
Thread-Topic: [PATCH 1/1] drm/xe/survivability: broadcast dmesg when engaging
 survivability
Thread-Index: AQHdaJKYjPqA60I6xkigAs/H1j3DC7caS0kAgADljgA=
Date: Mon, 2 Nov 2026 19:33:12 +0000
Message-ID: <9f9206a1bc81d6d54a02b6fa845338f192abc1d5.camel@intel.com>
References: <20261030171738.674775-2-alan.previn.teres.alexis@intel.com>
 <97194eeb-c204-483e-9945-e76db69b3fee@intel.com>
In-Reply-To: <97194eeb-c204-483e-9945-e76db69b3fee@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR11MB9883:EE_|CH9PR11MB9903:EE_
x-ms-office365-filtering-correlation-id: 0669e605-0b6d-4eb6-5da8-08df39182211
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|18002099003|22082099003|38070700021|261102123227099003|56012099006|11063799006|4143699003|261028144727099003|261021121427099003|261022105027099003|261022075727099003|261026140227099003|261026121527099003|261009223027099003|261021123027099003;
x-microsoft-antispam-message-info: qW7PVU+ZKFm3T3kA4+GyJOYJSAuzDBowz3oX2j+nAiNfzQIRSQs4ZnEz2E1aVbKDeMF3/q57r2zVLDESkwAJX429AUumpPo5kgjogqCVrdWkXoOHUdoqC0z7B+F8PDA0Ea+0l4uzJ18BKl8J1AR7VgqWSbKDruaCdvxz68EXDeOjYbmyEtnWEX0JE/UDdp7gcV60hkHjnSdiUzQFI0tbAr/EZgcn1oSHd1lLLZPm7iJef4A4wFOTvIFfQYFcthddsGB0MudTxvGc5PVc5Ak+H5+41NJEFxsVMh2WdOsQdWkwKBqoIbJDK1qLsIZ078y1ElunVjoNGqXBwQjyOUfhG4H30HcGeoHw0kPWW/CdNigO3x7zxfuExNYV9e4pLk+3cgKs2Tk3X8vNtI+nYuQ8La7JfTpeYmsZE42r3B/J59iDSyKX53CpzzU4ZooyYDA9IU82DGCSSI9SqWNK9gvOfalUJfuBEdk780x+FV2AXhIWVjJ1VKdf3hCp8I4P+A5GpTFTV9g4rGii+5cBzl9ptJskM4Z9ohGwlROqUcT2kBCPtnuYIZ3jHPnr3yotEuToF/cQx5znw4vflT/W2L+OqnPQeWJhNO2wwOQpQLuybM3l97IfnqpCKBPKryDfqC/sSZmBLuFUfftiiRXLm3CAfmQZWKmXelpZA0vAjb0k3Q+dXBPH+LUJweGwZczBCnG7IfZjcp+boFLyKkBuySRTTFljR4tjtD41K1AA6O9D4e0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LVWPR11MB9883.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(18002099003)(22082099003)(38070700021)(261102123227099003)(56012099006)(11063799006)(4143699003)(261028144727099003)(261021121427099003)(261022105027099003)(261022075727099003)(261026140227099003)(261026121527099003)(261009223027099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anZyd3VQV3Y3eGlXcmU1VE03NFJTdVpobGh2dDNIK01oVzYvMUMwZVNNL3VB?=
 =?utf-8?B?S3gyVGloNmprQXJ0YkMrYU9WcUk4MGF4dFJWQWttTElqeWNKWkZZL1VBbFdq?=
 =?utf-8?B?bnVaSm9LTFJ1M05EZjlZL0lVOEREUFJORjlMQS9MRVBDdFpQWllRL1RpajZN?=
 =?utf-8?B?K2FDWDZ5VTNKalY5Z09oNjliOWxMOWl1dHdVYUV5MkZWamZvNVRvVFJEY05q?=
 =?utf-8?B?NnRYSVNEVjhiQXlOQWlhMkdmVWFWWDAxeWxKaG1aVlJuRVljQ2V1N1VJSks2?=
 =?utf-8?B?QWlyRkxuUThVUlhDbk9EZnNHNCs2cXZ1c0ZDYUZBN1FWaExrKy9TTzEwVlZR?=
 =?utf-8?B?blQ2SEdwVGFxRDU3TmVEcFVoeWRKNnZKWmlCdHVuUnZzNGhCc3d5K2NjTUdl?=
 =?utf-8?B?b0R5MTVPbnJKQzNGSkJ4d0QzQzg5NklnTVB1UGwzZElUVnlYM1FTNW1JVHQx?=
 =?utf-8?B?MmZjTmZNYWFnaTlTSU9HcWRudTNCRExMbHRCcUpHSzhtMEtKMENMdmxMeThv?=
 =?utf-8?B?Qjd5L050L3pjakNjMElCUC9yUkRWY2lYRkx2YklzUDhHZVhxclRwMm5LTUlq?=
 =?utf-8?B?b2NnRHBPVDdlUUFmbnFCQVFZZ1lFTHJQUW9SNFZOeUQ3aFAvelAvQ09leGc1?=
 =?utf-8?B?MFhKQTQxeGgrczZrU093UkNQN1MzOEp1WVRQMVUyVGYxWmxQQ01ObU1Eb3M0?=
 =?utf-8?B?MVdBZ05BTDN3dW91S3hxb1FQSWZxazhBZmd2TFB4cGNCT0t0a2JycWlLMld1?=
 =?utf-8?B?ZElNSWlyRGlRL0lGbHNORmZXT0dRd3FRbHlmWkJuQ2FLSUk3REtxZDA3a1px?=
 =?utf-8?B?bjBwcDc2bUVkM09FZGc5S3VGMmpTYXVQVE9DUkh6WUFvOFVYSmpYTzcwZnRj?=
 =?utf-8?B?SUpmcG1RTDRZUDRkU3JWTjNZQ00vSWNrWVdqeHQ5QmlCZFB1QnpCWHMyNTM2?=
 =?utf-8?B?aVJ5Y1FLZlhoVnNIME1QUDFSZGJEY1pxb0FiSG1XYWtLK1V0R0pSTWN1ZDJ4?=
 =?utf-8?B?S2FBTDZNRHU0QzFRdnRrY2RNTk82Tmg5WUtQZm9oNjdzRkRJeFBHem00TXF2?=
 =?utf-8?B?K0Y3Z2tFbnMybGxuL0ZhaHYwNlZ1TDFYTkU4bVFEbUZ6NlNmbWdvL3kwOUlL?=
 =?utf-8?B?aDN0RGRjQXRhS2dHRWpHTE56RjFhZ1pEbnpGWTRyeG0yVEorSUdsOWs2OUQ4?=
 =?utf-8?B?MU10Uk96eTJzbGRjcW1hMXltUU1pWnpEOEljWEtKZ2RNNUY3bnNNc3dtSHRj?=
 =?utf-8?B?WDlHMjdXQ1FEYis5WkJmdi9xMDZKSnkrNFNRYS9MNXBHaVl3Z1hhNVJ1REtw?=
 =?utf-8?B?L2RrbDNzY05JcGNhZk9pQzZ4WU1CWVJVQVIvU2k5TG5neDlTbmdkekU4UklF?=
 =?utf-8?B?bFZNNXF6VnJWL3VwamlReHBFMmxIamlUWU5OQmg4QWJQVUVpL0JzRDIzeTFk?=
 =?utf-8?B?L2Y4elUzUTV3ZjRNOE9aUjhPclVqQ0FCTjg1ZGw5VDBXQ0hTUVFEUWg5enpI?=
 =?utf-8?B?SmZicUwvTFhQVE5ydDRmb2ZWSHZtd2xhTmNDWU0wdFZYWVRjU0ltWU50d2hj?=
 =?utf-8?B?ZDZZVXMydDFvL2ZxMTNrSXJFYkdEMDhuZDMxbXhJMy9UQTJzZWYzZHpIODNO?=
 =?utf-8?B?bElRb1BJZG55cTJmQUdRaUJxZkZuNVJGQ25ET1RhNW84N2NTV0tvVmd5UnBa?=
 =?utf-8?B?STBBck9UQlMxTWthaTJnR3VIMG1XaG5xdlZBZG5NTVIyQTdFV0l0YWUyd0tw?=
 =?utf-8?B?KzYzMzJrN1JrNHlDeXlkRHhKeU8rU0VrOWNXWnFpaHVxOURLWjhuUWJyVDBm?=
 =?utf-8?B?S3oxSCtLeXMrdnRVYUFjVWVLZ3FkQjQ5WjRKSFo1MTF2VXNEcUg0QXloK2M1?=
 =?utf-8?B?YUd4Z0hQUkN4NHY1YWFmVGpiQy96dWd4UnZiNWpjUmR0RVZ4V2pCZnNlRzI0?=
 =?utf-8?B?WTJSU3VZMVcwYmpGWjZPcEhmekRmOFV0OG9IajNiNEdGa293NkNjVDFta3A1?=
 =?utf-8?B?cjViK3MzUmNoYy9CNTF0V2ttNkxycno4YWY1a21aTkNodlczaDNtVWpMSHZQ?=
 =?utf-8?B?VXc1czNLamRTcEJpTm9zWjZ6Q0U0S1JEWSt6dmlzT3lQZnRZaVRDY3p2SFdG?=
 =?utf-8?B?eGJLelZtZnp5YTJnNmVXMTFKT0JFaTZIL3lwTDhvQnl2bFh3SEVsd0FJTU81?=
 =?utf-8?B?UUtoR1FRZnNxNVJyNjhFZ3VVRlRPb09EQ3E3OEhMRitseVpTU3kvTGpvTEpq?=
 =?utf-8?B?SG1FWWpqbDJKOEh2OE1IU3lDa251NVZWbDZmM21KN2xUdE5DVW9MbDRra0NQ?=
 =?utf-8?B?TDcvcHRsYjRaNlljSVBITGRKNENKN3RxUkpFQ3g4T05uYVZSNitpVjZsSlhU?=
 =?utf-8?Q?LqtEg9yPwnw+EAGSb/rMSXEQtlu4oTm4S0avP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0AD569B1FDE80E4B9D1D85F16BA776A1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BzTCi4cN30/rqDs/pwuVenHAelDGmUCYmNxdWDDFbYMzb2Yvi7nqVxq0ifGm83ZuQF41UTCVvkTqaYwhxNztWf37J1PNkCFcQkDNc4rAnX6qDjAK+Voh+4cTcUvqnIS0L7tzk6iZVvUBw9CHwd0dl9Zv0kneIbUO5NDmFLcVlnKvqPJtlI8qyeqJWvYqNaTyIGald6Nonekc45MnmA7TMjIR20dTsBTqNAf5cff7Ni52EvKGgYaJhPECga2TjZ6x9k3NmpLEcQsMmxygAI1aJqckAOHGp/oywM00O/83N/Bbcvr6cC39qpbRKKOUyhE4L2ycJGuY2sgd0/VsO6xnqw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR11MB9883.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0669e605-0b6d-4eb6-5da8-08df39182211
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 19:33:12.3226 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7+6lY5GBlEO3XUmsu2qdINmGQI0QOnyDSPwAweoAxSlM3ttyBbitZbx4u7HRmBymq/n0XEAKmjFLw+3FcmnhzHYDGnNsgrTTaMqKF2ILU9Y8cna2lRMtmHamaw4SbHxX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR11MB9903
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

T24gTW9uLCAyMDI2LTExLTAyIGF0IDExOjIxICswNTMwLCBUYXVybywgUmlhbmEgd3JvdGU6DQo+
IE9uIDMwLTEwLTIwMjYgMjI6NDcsIEFsYW4gUHJldmluIHdyb3RlOg0KPiA+IFdoZW4gdXNlciBy
ZXF1ZXN0cyB0byBlbnRlciBzdXJ2aXZhYmlsdHkgdmlhIGNvbmZpZ2ZzLCBvciBpZg0KPiA+IGNo
ZWNrX2Jvb3RfZmFpbHVyZSBpcyBoaXQgaW5zaWRlIHhlX3N1cnZpdmFiaWxpdHlfbW9kZV9pc19y
ZXF1ZXN0ZWQsDQo+ID4gbm8gaW5kaWNhdGlvbiBpcyBwdWJsaXNoZWQuIFRoaXMgcGF0Y2ggYWRk
cyBzb21lIGF3YXJlbmVzcyBpbiBkbWVzZy4NCj4gPiANCj4gPiAgIHYzIDogTGltaXQgbWVzc2Fn
ZSB0byB4ZV9zdXJ2aXZhYmlsaXR5X21vZGVfaXNfcmVxdWVzdGVkLiAoUmlhbmEpDQo+ID4gICB2
MiA6IFJlbW92ZSAvIG1vZGlmeSBtZXNzYWdlcyB0byByZWZsZWN0IHVuZGVybHlpbmcgYmVoYXZp
b3IuIChTYXNoaWtvKQ0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsYW4gUHJldmluIDxhbGFu
LnByZXZpbi50ZXJlcy5hbGV4aXNAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9n
cHUvZHJtL3hlL3hlX3N1cnZpdmFiaWxpdHlfbW9kZS5jIHwgMTAgKysrKysrKystLQ0KPiA+ICAg
MSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiANCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3hlL3hlX3N1cnZpdmFiaWxpdHlfbW9kZS5j
IGIvZHJpdmVycy9ncHUvZHJtL3hlL3hlX3N1cnZpdmFiaWxpdHlfbW9kZS5jDQo+ID4gaW5kZXgg
ZDczY2RhZDBiM2E5Li4zNDRiNDAyZWI3MjggMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL3hlL3hlX3N1cnZpdmFiaWxpdHlfbW9kZS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L3hlL3hlX3N1cnZpdmFiaWxpdHlfbW9kZS5jDQo+ID4gQEAgLTQxMywxMyArNDEzLDE5IEBAIGJv
b2wgeGVfc3Vydml2YWJpbGl0eV9tb2RlX2lzX3JlcXVlc3RlZChzdHJ1Y3QgeGVfZGV2aWNlICp4
ZSkNCj4gPiAgIA0KPiA+ICAgCXN1cnZpdmFiaWxpdHlfbW9kZSA9IHhlX2NvbmZpZ2ZzX2dldF9z
dXJ2aXZhYmlsaXR5X21vZGUocGRldik7DQo+ID4gICAJLyogRW5hYmxlIHN1cnZpdmFiaWxpdHkg
bW9kZSBpZiBzZXQgdmlhIGNvbmZpZ2ZzICovDQo+ID4gLQlpZiAoc3Vydml2YWJpbGl0eV9tb2Rl
KQ0KPiA+ICsJaWYgKHN1cnZpdmFiaWxpdHlfbW9kZSkgew0KPiA+ICsJCXhlX2xvZ19pbmZvKHhl
LCBTVVJWSVZBQklMSVRZLCAiQm9vdCBtb2RlIHJlcXVlc3RlZC4iKTsNCj4gPiAgIAkJcmV0dXJu
IHRydWU7DQo+ID4gKwl9DQo+ID4gICANCj4gPiAgIAlkYXRhID0geGVfbW1pb19yZWFkMzIobW1p
bywgUENPREVfU0NSQVRDSCgwKSk7DQo+ID4gICAJc3Vydml2YWJpbGl0eS0+Ym9vdF9zdGF0dXMg
PSBSRUdfRklFTERfR0VUKEJPT1RfU1RBVFVTLCBkYXRhKTsNCj4gPiAgIA0KPiA+IC0JcmV0dXJu
IGNoZWNrX2Jvb3RfZmFpbHVyZSh4ZSk7DQo+ID4gKwlpZiAoY2hlY2tfYm9vdF9mYWlsdXJlKHhl
KSkgew0KPiA+ICsJCXhlX2xvZ19lcnJfZmF0YWwocGRldiwgU1VSVklWQUJJTElUWSwgMCwgIkJv
b3QgTW9kZSBlbmFibGVkIVxuIik7DQo+ID4gKwkJcmV0dXJuIHRydWU7DQo+ID4gKwl9DQo+ID4g
KwlyZXR1cm4gZmFsc2U7DQo+ID4gICB9DQo+IA0KPiBDYW4gd2UgYWxzbyByZW1vdmUgbG9ncyBm
cm9tIGVuYWJsZV9ib290X3N1cnZpdmFiaWxpdHlfbW9kZSB0byBhdm9pZCANCj4gcmVkdW5kYW50
IGxvZ3MuDQo+IA0KPiBUaGFua3MNCj4gUmlhbmENCg0KYWxhbjogc3VyZSAtIGkgY2FuIGRvIHRo
YXQgLSBpdCB3b3VsZCBhbHNvIG1lYW4gZW5hYmxlX2Jvb3Rfc3Vydml2YWJpbGl0eV9tb2RlIHdv
dWxkDQpoYXZlIG5vIG1vcmUgcmVhc29uIHRvIGNhbGwgY2hlY2tfYm9vdF9mYWlsdXJlLg0KDQph
bGFuOiBBbHNvLCBsb29raW5nIGF0IHRoZSBiYXNlbGluZSBjb2RlIGFuZCB0aGlua2luZyBhYm91
dCBhIHdheSB0byBlbnN1cmUgYWxsIG9mIHRoZSBmb2xsb3dpbmcgbWlnaHQgcmVxdWlyZSByZWZh
Y3RvcmluZyB0aGUgY2FsbGluZyBsYXlvdXIgaW4geGVfZGV2aWNlLmMNCjEuIG5vIGR1cGxpY2F0
ZWQgbWVzc2FnZXMNCjIuIEFORCwuLiAgbm8gc2lsZW5jZSB3aGVuIHdlIEFSRSBhdHRlbXB0aW5n
IHRvIGdvIGludG8gc3Vydml2YWJpbGl0eQ0KMy4gQU5ELC4uLiBubyBzbGllY25lIGlmIHdlIHN1
Y2NlZWRpbmcgT1IgZmFpbGluZyBhY3R1YWxseSBlbnRlcmluZyBzdXJ2aXZhYmlsaXR5IG1vZGUN
Cg0KdGhpcyBpcyBwcmltYXJpbHkgYmVjYXVzZSB4ZV9kZXZpY2VfcHJvYmVfZWFybHkgY2FsbHMg
eGVfc3Vydml2YWJpbGl0eV9tb2RlX2lzX3JlcXVlc3RlZCBBTkQgaWYgdGhhdA0KcmV0dXJucyB0
cnVlLCB0aGUgc2FtZSBjb2RlIHByb2NlZWRzIHRvIGNhbGwgeGVfc3Vydml2YWJpbGl0eV9tb2Rl
X2Jvb3RfZW5hYmxlIHdoaWNoIGNhbGxzDQp4ZV9zdXJ2aXZhYmlsaXR5X21vZGVfaXNfcmVxdWVz
dGVkIGFnYWluLiBCdXQgaWYgd2UgZG9udCBwdXQgYSBtZXNzYWdlIGluIHhlX3N1cnZpdmFiaWxp
dHlfbW9kZV9pc19yZXF1ZXN0ZWQsDQp3ZSBlbmQgdXAgZ2V0dGluZyBzaWxlbmNlIGluIHNvbWUg
Y2FzZXMgbm90IGFsbCBjYXNlcy4gSSB0aGluayB3ZSBtaWdodCB3YW5uYSBuZWVkIGEgYml0IG1v
cmUgb2YgYQ0KcmVmYWN0b3IgaWYgdSBhYnNvbHV0ZXkgd2FudCB0byBlbnN1cmUgYWxsIDMgY29u
ZGl0aW9ucyBpIGxpc3RlZCBhYm92LiBhbHRlcm5hdGl2ZWx5LCB3ZSBjb3VsZCBhZGQNCmEgcGFy
YW0gaW50byB4ZV9zdXJ2aXZhYmlsaXR5X21vZGVfaXNfcmVxdWVzdGVkIHN1Y2ggYXMgICJib29s
IHNpbGVudF9jaGVjayIgYnV0IEkgZG9udCBsaWtlIHRoZSBpZGVhDQphcyBpdCBtYXkgZW5kIHVw
IGdldHRpbmcgd3JvbmdseSB1c2VkIChpZiBmdXR1cmUgY2hhbmdlcyBhcmUgbWFkZSkgdW5sZXNz
IHNvbWVvbmUgZ29lcyB0aHJ1IGV2ZXJ5IHBvc3NpYmxlDQpjYWxsc3RhY2sgYWdhaW4uIFNvIG5v
dCBhbiBpbnR1aXRpdmUvc2NhbGFibGUgb3B0aW9uLg0KDQpsZXQgbWUgdHJ5IHRvIHJlZmFjdG9y
IG9uIG5leHQgdmVyc2lvbi4NCi4uYWxhbg0K
