Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CF7CA5FA7
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 05:34:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E2D210E78C;
	Tue, 29 Sep 2026 05:34:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="n6VlKFd4";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4E6010E74D;
 Tue, 29 Sep 2026 05:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790660049; x=1822196049;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ljuyKDI4mtBi4YuJS2ErrewN7EAIO7/iJZbYaz1dFFk=;
 b=n6VlKFd4F5XKeCElghqOQYTV7TxqZdDn3Ml8tHHFUVqi8U/oVhPFYonZ
 2PIbP83Ugc2uJ0Ue9zLYWieYaWOkLfdM3x81Fy50KJsXTVEweEkWNXQAv
 6P5YgI3HRerc2YAj66miJWFzrNBgOi6mjVYxwoRQGDxlSkOiUhI/pIL1W
 E67nf7+I8SB312cpETSi19JzPk73whGC5ngTlQhBdURcEG3mbKCc7CdyY
 Lp9YGCaqzOGBmvfYLtA0HjBOx5s5mChi+oWS6wpR4/WncWNeyY407b23E
 RDTk0h5mxYAYjIef4kxkHz8g60WkkuyfXSJ7HLktq3Gf09AIw41g2il/h Q==;
X-CSE-ConnectionGUID: sVG0fcwOQPOGSZAxRbsutQ==
X-CSE-MsgGUID: hRqm4lmVT1SuQ2UYix6jBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="108859917"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; d="scan'208";a="108859917"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 22:34:07 -0700
X-CSE-ConnectionGUID: VIWQacvMR/O1jlYruHc+ZQ==
X-CSE-MsgGUID: 5iSjYVc8RfCo63rKYqU+RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; d="scan'208";a="278619783"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 22:34:07 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 22:34:06 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 22:34:06 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.30) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 22:34:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p5mbc7oTr1OckPo63bksWHbKjU5BJ+d2Bzd9uYw+kg/40HCMknAdSL5ff+MuVr95cAo+yxHcDsCy/yQhMpqyebN57jubhZX28Uf6V77Z7OU8R3QPtokXKHTmhlQfzmsG0u+3eZRTyUFn/zuL6H0oRV1+Wouss+bcnZ03qsKclws7f9gN7Wo3FgV886ygxD7Y2sCv1yS4tXb+YftzCIOGQLTA98ovfq8jERW8+1z9NOY39ZP3dgYC13AJl/Nx3xfr7L6NNEDb7kocIZhHwDAhdg1fTTSvpnjMsEy5oVygu/5kqzX+ljpEU0eLesKtgA8FO83NOP/e8wRFipwj/SKfXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljuyKDI4mtBi4YuJS2ErrewN7EAIO7/iJZbYaz1dFFk=;
 b=S+sFetZSotyW14ehlXrLJtlvx//cE98zzzA9SgLnVyUnJBWH0Cov8Vb+XVKACTgP3KqU1hOppdWjmguTCHO4R4QkKIeBeEWIQeEXv/NQf9NsngFqHiXGVC1rtw5SN8cz0EhnhbwzeKvRsnFd8vK6Do6V0FNpJimWxvciCIMbAqhXdbRy49kKdKryYR3s0t4ne0qWcRi/X1r0xyFXthEuQU9sNUDtePIBHXS2PWECsX0A7+keuo7byPFXb5Uh+OIv3Xkr9/C/BNAcNlq/lF2gtUmVVTbKM5ByqiM/YgRhUDqPcay4qk+uHrWe/WCTxtwpl+CP/7GtCF64PMlIkM1yGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6019.namprd11.prod.outlook.com (2603:10b6:8:60::5) by
 SJ0PR11MB5200.namprd11.prod.outlook.com (2603:10b6:a03:2df::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.24; Tue, 29 Sep 2026 05:34:04 +0000
Received: from DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762]) by DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762%6]) with mapi id 15.21.0451.024; Tue, 29 Sep 2026
 05:34:04 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Manna,
 Animesh" <animesh.manna@intel.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>
CC: "Kandpal, Suraj" <suraj.kandpal@intel.com>, "Nikula, Jani"
 <jani.nikula@intel.com>
Subject: Re: [PATCH v6 06/18] drm/i915/alpm: Auxless wake time calculation for
 Xe3p
Thread-Topic: [PATCH v6 06/18] drm/i915/alpm: Auxless wake time calculation
 for Xe3p
Thread-Index: AQHdRUGLXN+a1tuO00KSxdTokGiymLblHcCA
Date: Tue, 29 Sep 2026 05:34:04 +0000
Message-ID: <5cef6cb6f540b893730076330c1b527197ed3504.camel@intel.com>
References: <20260915180449.277933-1-animesh.manna@intel.com>
 <20260915180449.277933-7-animesh.manna@intel.com>
In-Reply-To: <20260915180449.277933-7-animesh.manna@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6019:EE_|SJ0PR11MB5200:EE_
x-ms-office365-filtering-correlation-id: 5ae2635f-87cf-4dfa-d4d3-08df1deb4661
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|11063799006|56012099006|260925021911599003|3023799007|260925022911599003|260925021311599003|22082099003|18002099003|4143699003|38070700021;
x-microsoft-antispam-message-info: Xd5lIUQYXlhMcUx8bPsCuNM6csQGwXI0JC1ulMkTGS4c2MgLEbZrXy/I5xrfLmqA5VGaNedPx0tYvmcR13M9F8/Vi6f3KZmysZ2VI5AkT82zwlzTr67Kx8ffQI4zAoOKM17gDiCxr94rlXZ8vWN75CI5ajgQBO2YkgnsGgHZSQzpOF2HbZKVYLc91IMJ5GplzZHvvIc+F4jV6t9ZGttGHiPudDDdtTFjnGeqx9ZbYmhJF0GgLTasotod7GLxZL2xBtdENvF0a0+n4Yaa3A2+jOl4CXVJQVRDv6jRNXsmMD5MwLX1TvmT/wovjhnNQZwApcbJAxSmhhBR4bOqsZCCvePjdSn2SklUuLe7RktPZNXtmc8emXiaTirfL+Y5y7nB2etpzm1SDw8xcmsiFbF9SHbsH+/tMf4cKrEfWHhx1QUGjWXElMF++/IcadSAD8TYxrS21AeJLTCfRbkV3M8o7lm9fmhUL9mHMMJ4tmPZlliTJof784rQLwounKrT44W+Q8gwGGbG9c/2rU2Z8NGJ19O85ONSE5vW/P5LC1wg6K38uJg6ff5OUO4cGZkZ2VrsQREmVHJv03lxMkNJgES47Zg+Q77PB3x9lZeYEknkGeKbbfwBOCaOaFrfmsDTIDpJ1/Uaqo8g6L9BfnVvwPkY1gT4vANmTz08oU7U+68fj2tO8o39qQUMK9WtTPEQJYrDwukpH0nWN7YH98015XvSEEMq/7wsUEVNNekZniZVVE0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6019.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(260925021911599003)(3023799007)(260925022911599003)(260925021311599003)(22082099003)(18002099003)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnRGVFg2M3ZKbEt0UE9tdlN5bGhObEozL3VWaXRBWHluQjJxZXZJdG1VNk9l?=
 =?utf-8?B?eE5KUHp2TzhXUmJkRjRPaGlIbW03QWNEZytVRThobmxVTWc5ejZ3ektjSGk3?=
 =?utf-8?B?cXlZaW55Nis1ZDNudkR4eUlpS05yb2NyVVhqT3J1bTA1TElnRVp4WWRlQUpO?=
 =?utf-8?B?bUlUUVY4UlpaZVN4Zk9HdEdTQXJBWHhZSEszbVhRRTlYd2FvaXVxajErN3Jo?=
 =?utf-8?B?bUlrSE83U2dhSW1GWm0yTkJMcWtxcFRxb1VRaVB0alNCVDg3NWZMTTd6SGRo?=
 =?utf-8?B?QjRGekpwb0NEQkJ4TEpkN2tXWjNaWVAxVVBzUVpjM3hUa0c3b0tLY1h3YjY0?=
 =?utf-8?B?bERocWNyV0p3a2xBSzNuMC8rdFR5NitsV3d3UFZwb1Nra0VZM1JrT0VIQVBm?=
 =?utf-8?B?czR0clQwNis1SG15RmhjamJDME4zZkVMVGcwK0hOdWtKYWo0TlRUVTRNenQ5?=
 =?utf-8?B?eDk3aUhuZDN1RkkyUUpWNTg3V3FZUXNoQVBlZzUzZ1ZlRXdVNWJPL25uN1dh?=
 =?utf-8?B?UjE1VHBEUnJvbzhFbzZ6SWsySU5wVzVlQlgzK0NyM0VVcHFZLzhieWxzVkVq?=
 =?utf-8?B?K2xic2E1OXVDNkVGbTd6RjhQcVJUek5xaHpsdUR2dGhjRnhmOXF3T2JVdk54?=
 =?utf-8?B?MU9FR3RrbS9pVDRRa015bHUvQ3FPMlBRZFBNaS9CdE9KaXZqejZocXJXeVps?=
 =?utf-8?B?ZWZEY2tlMmk2Tm0wYUx2YmlVVXp0ZVhYK3Z6RTZFT1dxZUZoYlZKSVZVTVBF?=
 =?utf-8?B?bU8zams1OTZoZ0xPd0xBa0Fhd3NaQ29EVTRvUllyZDE0b0dBYWhqNGcrMGhj?=
 =?utf-8?B?bGFUZG43Z1lNaVEzcHNaSGtZcklJREoyWDRWbVhNQmhvcGxsRHI5NnNjYVlj?=
 =?utf-8?B?Z0lXKzZXQTEzRTQwYnRXUWVpNTJ1RXJrWitPRXFEd1dWbTNHVEZkTkEyODMw?=
 =?utf-8?B?dVlnUjc0MVRDZDlZMFVNL1lNNUpHcGtDaThxa3NHMzR4d3ZTbGJ2VmhWWXZ2?=
 =?utf-8?B?b1V5SGlwT1VjZm1FbVN5MmR5OXVpQTRXM0U1bG43RUVIcUVtTVRMaGZFeWlR?=
 =?utf-8?B?aWQ5Sm8vTStoSXNKUGNVRi9PRzg2bXduRk0yZDBieUN6Z0tlSkVMOUhnOEhQ?=
 =?utf-8?B?Lzh1K2ZhWS9SelNkdFVhdUdJR3JVbU5DcXdma3M0d0crSklXQ2piVnJMbnBF?=
 =?utf-8?B?VnUzU2U1eExua2FuMEsyQ2Z0R2JGNXBoSGI3NXJHT1pHZ0tmaTczOHRIMFo1?=
 =?utf-8?B?bU9mc1V5bU5qTVdjb3hVU2tBajRNUzRzQ1lzSkoya2xMOUQwK1hQU1U4UEp3?=
 =?utf-8?B?RUwwbGJsTlVHTUgzZTlhL3lrdU9KVHNEa2lDRVYzMlZsdSttbXdkVGMzR2o1?=
 =?utf-8?B?bS9IUjdFYzFyMSs1R2VKaDczbGl5Qkh2VEVZOHBzaWV3eFBiak9YcTY3RENG?=
 =?utf-8?B?cTA2ejdXT0Q3bnVzNGNmVlNSUEZYZC8vVHhVeG9PbmZhMFJycWNvd1lzcTNU?=
 =?utf-8?B?QTB2S0FxS2ZZQnUvK0t5emlEL1hHZXd3NVUzTjhsWGxsL0pibnNJa0pDYkRk?=
 =?utf-8?B?Y1QvZ0R2SmJ0SWgvWnE2dHE0VW1Rc09UNnF0emE1MFpIVkhod0QrOGJwUnlx?=
 =?utf-8?B?cWFSWlQzZ0FqVTh0T0tZWU92TFVKdUZ6Zkh6Qm16ZCtZZnU5RjBNVUF5dUYv?=
 =?utf-8?B?bGZDR1hxS1Zla0hCYTUrM0EvUGVMUnJkY2hBdEJXeE9oRXZFMFZBcktUYmtY?=
 =?utf-8?B?SnJ5VW1XT1JieXNGbnJuNDdDd2ZZclJpZ2RieUR6bXNvUE9RSXJsVVZpQ01s?=
 =?utf-8?B?YjdpYzhhYzd6bzJ2WlcrNGZibzVKUzdyUGhTQ3lienJzODg3SytjalduRzZJ?=
 =?utf-8?B?cTNjNTFCY01qSmZMMkk2K3hwaG82NS9IaTBnSDIrM1ZqYzRsRHd6SXk3VHZm?=
 =?utf-8?B?Y1lHOFYwL2tzWnpaSzgvNmJaSDVYTVp0S1plQVY0cGRNZlpwZTlieWg3M0hq?=
 =?utf-8?B?OHFzK0VGNXRhUjRSSmh0UjRhcmRUY1puZ0pjck5hL2RydmdCT1N2NXRJSmph?=
 =?utf-8?B?RGJJMFBkanBmVndWRFZVWWNZbHd2WEtkUmhtcU1UVGtsS3g1bEtwd3hHKzdn?=
 =?utf-8?B?U29WQXlvd05XWlNPZkc2SW9ha2crdTVGYlk0d2h5SksvWDcxUVZjSkVRdWdy?=
 =?utf-8?B?QkdDZHZIK21YaXQzL0dCeElLUitsYUk5U3hpcXdlS3JYRkI4R09STXc4Z2lZ?=
 =?utf-8?B?Sm82c0JTOStoYjl5UGJVdW5nK2IyV3Y5amZSdkJpejVqMXE2eFdSRnRsRERC?=
 =?utf-8?B?ZkJOV1ZXdEVCcm93M0VpM0pad2dpbCsxWDdCb256Ny9pb0w1eHVuMWpkNUlq?=
 =?utf-8?Q?xS/1wz+xRPEj5aQI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D265F3E4CDBE74AB44EAFA42C6E7631@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 5jlMB5eAjE+2M4fyzcZhI9jfFKcKSpovGonOg3UF1tHybuazhAQJC07kxOzN2IOz1ruyezjcNLsBK+1R5kgGAQw2Yer/kB+/AibAM3vqncQwqDYTxFsmzblsB6R0Ayk+7QuceREInRjEw9Dd8llD/+yFpnlkeI43Ap2S8T97/kLvyFK60PwHc3P3ncWcN861qL78t9PUXC1VrjVO8+bdnhZF5ALvvskwkHssBMgz+GDbM20e60vihA/c3suRNtImhgs3adF6oCcFHLQUxjOKT8O8bKEhQyUf0vO8yG02lhr2X1ifZVeX4ZNnMAsT293g6MmPDclbInmABe7ysSDowA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae2635f-87cf-4dfa-d4d3-08df1deb4661
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 05:34:04.4931 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SK5ZqWT6NJhycEQSvVWfqlV60XGjeD1CzyT5/TsGuxoJlyv6Zda1R6WYfCbP07K5Ac9sweg+I0PDrudWBKv2jSgt5MZSdHvCgEvhwJiPCc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5200
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
PiBBZGQgc3VwcG9ydCBmb3IgYXV4bGVzcyB3YWtldGltZSBjYWxjdWxhdGlvbiBmb3IgRFAyLjEg
QUxQTQ0KPiBhcyBkZXBlbmRlbnQgcGFyYW1ldGVyIGdvdCBjaGFuZ2VkLg0KPiANCj4gdjE6IElu
aXRpYWwgdmVyc2lvbi4NCj4gdjI6IFVzZSBpbnRlbF9kcF9pc191aGJyKCkuIFtKYW5pXQ0KPiB2
MzoNCj4gLSBTZXBhcmF0ZSBvdXQgc3dpdGNoIHRvIGFjdGl2ZSBsYXRlbmN5IGNhbGN1bGF0aW9u
Lg0KPiAtIFVzZSBtYWNybyBkZWZpbml0aW9uIGZvciBNTF9QSFlfTE9DSyBsZW5ndGguIFtTdXJh
al0NCj4gdjQ6DQo+IC0gRml4IDMyLWJpdCBzaWduZWQgaW50ZWdlciBvdmVyZmxvdy4gW3Nhc2hp
a29dDQo+IC0gRml4IG5lZ2F0aXZlIHJldHVybiBvZiBkcm1fZHBfbHR0cHJfY291bnQoKS4gW3Nh
c2hpa29dDQo+IC0gSW50cm9kdWNlIGdldF9tbF9waHlfbG9ja19sZW4oKSBhbmQgZ2V0X2RwX2xp
bmtfc3ltYm9sX3NpemUoKS4NCj4gW0pvdW5pXQ0KDQpNeSBjb21tZW50IHdhcyByZWZlcnJpbmcg
ZXhpc3RpbmcgaW50ZWxfZHAuYzppbnRlbF9kcF9saW5rX3N5bWJvbF9zaXplDQoNCj4gLSBBbGln
biB2YXJpYWJsZSBuYW1pbmcgd2l0aCBicGVjIGZvcm11bGEgb2YgZXN0YWJsaXNobWVudF9wZXJp
b2QuDQo+IFtKb3VuaV0NCj4gDQo+IEJzcGVjOiA3MTQ3Nw0KPiBDYzogSm91bmkgSMO2Z2FuZGVy
IDxqb3VuaS5ob2dhbmRlckBpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEFuaW1lc2ggTWFu
bmEgPGFuaW1lc2gubWFubmFAaW50ZWwuY29tPg0KPiAtLS0NCj4gwqBkcml2ZXJzL2dwdS9kcm0v
aTkxNS9kaXNwbGF5L2ludGVsX2FscG0uYyB8IDY5ICsrKysrKysrKysrKysrKysrKystLQ0KPiAt
LQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA1OCBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2Fs
cG0uYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5jDQo+IGlu
ZGV4IGQ1ODIzMTc0NTc2YS4uOTI0ZmE4ZGQ0NjM4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0uYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
aTkxNS9kaXNwbGF5L2ludGVsX2FscG0uYw0KPiBAQCAtMTAyLDIxICsxMDIsNjQgQEAgc3RhdGlj
IGludCBnZXRfbGZwc19oYWxmX2N5Y2xlX2Nsb2Nrcyhjb25zdA0KPiBzdHJ1Y3QgaW50ZWxfY3J0
Y19zdGF0ZSAqY3J0Y19zdGF0ZSkNCj4gwqAJCTEwMDAgLyAoMiAqIExGUFNfQ1lDTEVfQ09VTlQp
Ow0KPiDCoH0NCj4gwqANCj4gKyNkZWZpbmUgTUxfUEhZX0xPQ0tfTEVOCQkyNTINCj4gKyNkZWZp
bmUgTUxfUEhZX0xPQ0tfTEVOX1VIQlIJMzk2DQo+ICsNCj4gwqBzdGF0aWMgaW50IGdldF90cGh5
Ml9wMl90b19wMChjb25zdCBzdHJ1Y3QgaW50ZWxfY3J0Y19zdGF0ZQ0KPiAqY3J0Y19zdGF0ZSkN
Cj4gwqB7DQo+IC0JcmV0dXJuIDEyICogMTAwMDsNCj4gKwlzdHJ1Y3QgaW50ZWxfZGlzcGxheSAq
ZGlzcGxheSA9DQo+IHRvX2ludGVsX2Rpc3BsYXkoY3J0Y19zdGF0ZSk7DQo+ICsNCj4gKwlyZXR1
cm4gRElTUExBWV9WRVIoZGlzcGxheSkgPj0gMzUgPyAoMjAgKiAxMDAwKSA6ICgxMiAqDQo+IDEw
MDApOw0KDQpUaGlzIHNob3VsZCBhY3R1YWxseSB1c2UgSEFTX0xUX1BIWSgpLg0KDQo+ICt9DQo+
ICsNCj4gK3N0YXRpYyBpbnQgZ2V0X21sX3BoeV9sb2NrX2xlbihjb25zdCBzdHJ1Y3QgaW50ZWxf
Y3J0Y19zdGF0ZQ0KPiAqY3J0Y19zdGF0ZSkNCj4gK3sNCj4gKwlyZXR1cm4gaW50ZWxfZHBfaXNf
dWhicihjcnRjX3N0YXRlKSA/IE1MX1BIWV9MT0NLX0xFTl9VSEJSIDoNCj4gTUxfUEhZX0xPQ0tf
TEVOOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50IGdldF9kcF9saW5rX3N5bWJvbF9zaXplKGNv
bnN0IHN0cnVjdCBpbnRlbF9jcnRjX3N0YXRlDQo+ICpjcnRjX3N0YXRlKQ0KPiArew0KPiArCXJl
dHVybiBpbnRlbF9kcF9pc191aGJyKGNydGNfc3RhdGUpID8gMzIgOiAxMDsNCj4gwqB9DQoNClRo
aXMgaXMgZHVwbGljYXRlIG9mIGludGVsX2RwX2xpbmtfc3ltYm9sX3NpemUuDQoNCj4gwqANCj4g
LXN0YXRpYyBpbnQgZ2V0X2VzdGFibGlzaG1lbnRfcGVyaW9kKGNvbnN0IHN0cnVjdCBpbnRlbF9j
cnRjX3N0YXRlDQo+ICpjcnRjX3N0YXRlKQ0KPiArc3RhdGljIGludCBnZXRfZXN0YWJsaXNobWVu
dF9wZXJpb2Qoc3RydWN0IGludGVsX2RwICppbnRlbF9kcCwNCj4gKwkJCQnCoMKgwqAgY29uc3Qg
c3RydWN0IGludGVsX2NydGNfc3RhdGUNCj4gKmNydGNfc3RhdGUpDQo+IMKgew0KPiDCoAlpbnQg
dDEgPSA1MCAqIDEwMDA7DQo+IC0JaW50IHRwczQgPSAyNTI7DQo+IC0JLyogcG9ydF9jbG9jayBp
cyBsaW5rIHJhdGUgaW4gMTBrYml0L3MgdW5pdHMgKi8NCj4gLQlpbnQgdG1sX3BoeV9sb2NrID0g
MTAwMCAqIDEwMDAgKiB0cHM0IC8gY3J0Y19zdGF0ZS0NCj4gPnBvcnRfY2xvY2s7DQo+ICsJaW50
IHRwczQgPSBnZXRfbWxfcGh5X2xvY2tfbGVuKGNydGNfc3RhdGUpICoNCj4gZ2V0X2RwX2xpbmtf
c3ltYm9sX3NpemUoY3J0Y19zdGF0ZSk7DQo+ICsJLyoNCj4gKwkgKiBwb3J0X2Nsb2NrIGlzIGxp
bmsgcmF0ZSBpbiAxMGtiaXQvcyB1bml0cywgc28gbXVsdGlwbHlpbmcNCj4gYnkNCj4gKwkgKiAo
MTAwMCAqIDEwMDApLzEwID0gMTAwMDAwDQo+ICsJICovDQo+ICsJaW50IHRtbF9waHlfbG9jayA9
IDEwMDAwMCAqIHRwczQgLyBjcnRjX3N0YXRlLT5wb3J0X2Nsb2NrOw0KDQp0bWxfcGh5X2xvY2s6
DQoNCkZvciA4Yi8xMGI6IA0KMjUyIFN5bWJvbCBjbG9ja3MgKiAoIDEwIC8gKExpbmsgUmF0ZSBp
biBNYnBzKSApDQoNCkZvciAxMjhiLzEzMmI6DQozOTYgU3VwZXIgU3ltYm9sIGNsb2NrcyAqICgg
MzIvIChMaW5rIFJhdGUgaW4gTWJwcykgKQ0KDQpJbiBjb21tZW50IHlvdSBzaG91bGQgaGF2ZToN
CiogKDEwMDAwICogMTAwMDApL2ludGVsX2RwX2xpbmtfc3ltYm9sX3NpemUoKQ0KDQo+ICsJaW50
IGx0dHByX2NvdW50ID0gMDsNCj4gwqAJaW50IHRjZHMsIGVzdGFibGlzaG1lbnRfcGVyaW9kOw0K
PiDCoA0KPiAtCXRjZHMgPSAoNyArIERJVl9ST1VORF9VUCg2NTAwLCB0bWxfcGh5X2xvY2spICsg
MSkgKg0KPiB0bWxfcGh5X2xvY2s7DQo+IC0JZXN0YWJsaXNobWVudF9wZXJpb2QgPSAoU0lMRU5D
RV9QRVJJT0RfVElNRSArIHQxICsgdGNkcyk7DQo+ICsJaWYgKGludGVsX2NydGNfaGFzX3R5cGUo
Y3J0Y19zdGF0ZSwgSU5URUxfT1VUUFVUX0VEUCkpIHsNCj4gKwkJdGNkcyA9ICg3ICsgRElWX1JP
VU5EX1VQKDY1MDAsIHRtbF9waHlfbG9jaykgKyAxKSAqDQo+IHRtbF9waHlfbG9jazsNCj4gKwl9
IGVsc2Ugew0KPiArCQl0Y2RzID0gNyAqIHRtbF9waHlfbG9jazsNCj4gKwkJbHR0cHJfY291bnQg
PSBkcm1fZHBfbHR0cHJfY291bnQoaW50ZWxfZHAtDQo+ID5sdHRwcl9jb21tb25fY2Fwcyk7DQo+
ICsJfQ0KPiArDQo+ICsJaWYgKGx0dHByX2NvdW50ID4gMCkgew0KPiArCQkvKiB0bHcgYW5kIHRj
cyB2YWx1ZXMgYXJlIHRha2VuIGZyb20gRFAyLjEgc3BlYyAqLw0KPiArCQlpbnQgdGx3ID0gMTMw
MDA7DQo+ICsJCWludCB0Y3MgPSAxMDAwMDsNCj4gKwkJaW50IHRsZnBzX3BlcmlvZCA9IGdldF9s
ZnBzX2N5Y2xlX3RpbWUoY3J0Y19zdGF0ZSk7DQo+ICsJCWludCB0ZGNzID0gKFNJTEVOQ0VfUEVS
SU9EX1RJTUUgKyB0MSArIHRjcyArDQo+ICsJCQnCoMKgwqAgKGx0dHByX2NvdW50IC0gMSkgKiAo
dGx3ICsNCj4gdGxmcHNfcGVyaW9kKSk7DQo+ICsJCWludCB0YWNkcyA9IDcwMDAwOw0KPiArCQlp
bnQgdGRzID0gNyAqIHRtbF9waHlfbG9jazsNCj4gKw0KPiArCQkvKiB0ZHJsIGlzIHNhbWUgYXMg
dGNkcyovDQo+ICsJCWVzdGFibGlzaG1lbnRfcGVyaW9kID0gdGx3ICsgdGxmcHNfcGVyaW9kICsg
dGRjcyArDQo+IHRhY2RzICsNCj4gKwkJCQnCoMKgwqDCoMKgwqAgKGx0dHByX2NvdW50IC0gMSkg
KiB0ZHMgKw0KPiB0Y2RzOw0KPiArCX0gZWxzZSB7DQo+ICsJCS8qIFRPRE86IEFkZCBhIGNoZWNr
IGZvciBkYXRhIHJlYWxpZ24gYnkgRFBDRA0KPiAweDExNlszXSAqLw0KPiArDQo+ICsJCWVzdGFi
bGlzaG1lbnRfcGVyaW9kID0gKFNJTEVOQ0VfUEVSSU9EX1RJTUUgKyB0MSArDQo+IHRjZHMpOw0K
PiArCX0NCj4gwqANCj4gwqAJcmV0dXJuIGVzdGFibGlzaG1lbnRfcGVyaW9kOw0KPiDCoH0NCj4g
QEAgLTEzOCwxMiArMTgxLDE2IEBAIHN0YXRpYyBpbnQgZ2V0X2VzdGFibGlzaG1lbnRfcGVyaW9k
KGNvbnN0DQo+IHN0cnVjdCBpbnRlbF9jcnRjX3N0YXRlICpjcnRjX3N0YXRlKQ0KPiDCoCAqIHdp
dGhpbiB0aGUgQ0RTIHBlcmlvZCBjb21wbGV0ZSB3aXRoaW4gdGhlIENEUyBwZXJpb2QgcmVnYXJk
bGVzcw0KPiBvZg0KPiDCoCAqIGVudHJ5IGludG8gdGhlIHBlcmlvZA0KPiDCoCAqIHRNTF9QSFlf
TE9DSyA9IFRQUzQgTGVuZ3RoICogKCAxMCAvIChMaW5rIFJhdGUgaW4gTUh6KSApDQoNCkhlcmUg
YWxzbyBzd2l0Y2ggMTAgYXMgUmF0ZSBEaXYuDQoNCkJSLA0KSm91bmkgSMO2Z2FuZGVyDQoNCj4g
LSAqIFRQUzQgTGVuZ3RoID0gMjUyIFN5bWJvbHMNCj4gKyAqIE1MX1BIWV9MT0NLIExlbmd0aCAo
OGIvMTBiKTogMjUyDQo+ICsgKiBNTF9QSFlfTE9DSyBMZW5ndGggKDEyOGIvMTMyYik6IDM5Ng0K
PiArICogVFBTNCBMZW5ndGggPSBNTF9QSFlfTE9DSyAqIFJhdGUgRGl2DQo+ICsgKiBSYXRlIERp
diA9IDMyIGZvciAxMjhiLzEzMmIgYW5kIDEwIGZvciA4Yi8xMGIuDQo+IMKgICovDQo+IC1zdGF0
aWMgaW50IF9sbmxfY29tcHV0ZV9hdXhfbGVzc193YWtlX3RpbWUoY29uc3Qgc3RydWN0DQo+IGlu
dGVsX2NydGNfc3RhdGUgKmNydGNfc3RhdGUpDQo+ICtzdGF0aWMgaW50IF9sbmxfY29tcHV0ZV9h
dXhfbGVzc193YWtlX3RpbWUoc3RydWN0IGludGVsX2RwDQo+ICppbnRlbF9kcCwNCj4gKwkJCQkJ
wqDCoCBjb25zdCBzdHJ1Y3QNCj4gaW50ZWxfY3J0Y19zdGF0ZSAqY3J0Y19zdGF0ZSkNCj4gwqB7
DQo+IMKgCWludCB0cGh5Ml9wMl90b19wMCA9IGdldF90cGh5Ml9wMl90b19wMChjcnRjX3N0YXRl
KTsNCj4gLQlpbnQgZXN0YWJsaXNobWVudF9wZXJpb2QgPQ0KPiBnZXRfZXN0YWJsaXNobWVudF9w
ZXJpb2QoY3J0Y19zdGF0ZSk7DQo+ICsJaW50IGVzdGFibGlzaG1lbnRfcGVyaW9kID0NCj4gZ2V0
X2VzdGFibGlzaG1lbnRfcGVyaW9kKGludGVsX2RwLCBjcnRjX3N0YXRlKTsNCj4gwqANCj4gwqAJ
cmV0dXJuIERJVl9ST1VORF9VUCh0cGh5Ml9wMl90b19wMCArDQo+IGdldF9sZnBzX2N5Y2xlX3Rp
bWUoY3J0Y19zdGF0ZSkgKw0KPiDCoAkJCcKgwqDCoCBlc3RhYmxpc2htZW50X3BlcmlvZCwgMTAw
MCk7DQo+IEBAIC0xNTgsNyArMjA1LDcgQEAgX2xubF9jb21wdXRlX2F1eF9sZXNzX2FscG1fcGFy
YW1zKHN0cnVjdCBpbnRlbF9kcA0KPiAqaW50ZWxfZHAsDQo+IMKgCQlsZnBzX2hhbGZfY3ljbGU7
DQo+IMKgDQo+IMKgCWF1eF9sZXNzX3dha2VfdGltZSA9DQo+IC0JCV9sbmxfY29tcHV0ZV9hdXhf
bGVzc193YWtlX3RpbWUoY3J0Y19zdGF0ZSk7DQo+ICsJCV9sbmxfY29tcHV0ZV9hdXhfbGVzc193
YWtlX3RpbWUoaW50ZWxfZHAsDQo+IGNydGNfc3RhdGUpOw0KPiDCoAlhdXhfbGVzc193YWtlX2xp
bmVzID0gaW50ZWxfdXNlY3NfdG9fc2NhbmxpbmVzKCZjcnRjX3N0YXRlLQ0KPiA+aHcuYWRqdXN0
ZWRfbW9kZSwNCj4gwqAJCQkJCQnCoMKgwqDCoMKgwqANCj4gYXV4X2xlc3Nfd2FrZV90aW1lKTsN
Cj4gwqAJc2lsZW5jZV9wZXJpb2QgPSBnZXRfc2lsZW5jZV9wZXJpb2Rfc3ltYm9scyhjcnRjX3N0
YXRlKTsNCg0K
