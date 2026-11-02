Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A7C606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 06:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=e6z+3ujg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 382E510E58F;
	Mon,  2 Nov 2026 06:07:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 100D010E4B9;
 Mon,  2 Nov 2026 06:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793599649; x=1825135649;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nORYRHWhEP7m8LJTGr50HAejOxtpnQs1ZaDQAoGwmmg=;
 b=e6z+3ujgfI6ZLYtIoE6CPj8rVIqyv//bIYsjJelxGilXQRBmMq6Y3P2I
 HkWqeJi32lYbalO0CzzwGw0yw/VRI+EfGH4NldDhgaqGvVvnEvCBL2ctN
 wNSD831T8TAi8uxRPHzACGLp7ZDNfoKhMzrWeezFmSs3n9tPUCF/IpAH4
 rdPjSuJddigkjf92Fwu23yN/Ry173B5o2B3AErMaSVl09m+SNDxeQ4Xf5
 kjU9K2uPm5WvDBnS4jICJ+gnCG8oz6IOtkK6LtrrXWmPTGW3BGJ6g2ewz
 MoIhO/8bCaY7/IyzwelyW9LJ61xSbd3SjKsRpC91HoaNKeR0JQnTTq/hw Q==;
X-CSE-ConnectionGUID: Vp5ZvPp9RU6DIK51E/C/5A==
X-CSE-MsgGUID: P/QE1grgS1OUey6yaHC5YQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2158161"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2158161"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Nov 2026 22:07:29 -0800
X-CSE-ConnectionGUID: 8/FqYe15S2W8jjRAof0ThA==
X-CSE-MsgGUID: e0yem4SeQ1K+Zn4SxutzgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6073336"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Nov 2026 22:07:29 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 1 Nov 2026 22:07:28 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Sun, 1 Nov 2026 22:07:28 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.42)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 1 Nov 2026 22:07:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HE0BWvfbtomjissVOwWV+QfGw1Yn3Kd4BBGqZh4cLMxQQ1Atyu4zidK9TwEWQ2mUL/RcvHbuJKAK1WFG1kfJNkancY41KsRbGWaLhJHDLCexMk/4YdoVW4hWlsOU38gusdR2dHkedgtshb9hvLoL83PmySp6i7XGsTfuSBGBTwZ3oPdOBLxxHYhwnVdZgUGyJEPcCegHnAyyU7YvZ6tl9iwx9kOfCRVOkfHvnmX3D5LvfTHU41b4JLAi51mSmpwY6IzwPWKi/sCltRBivWHFfuqrIR87xS/nnVdcE/B4jLjiuy5/zyKj65mMKvR61a0mvmeqE2lwwy1plAxzoTJJKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nORYRHWhEP7m8LJTGr50HAejOxtpnQs1ZaDQAoGwmmg=;
 b=VR3flTgPnhMDLhatmRpGYinGd052vrPG86+Oi7ASBu6WOUvIenMrKqoBGvprbZLufOxEuWxD+LfTKDU4G55qzjYtFAlDs+Ef0GevYqSizmYfaf13aI1tn14W+MHX2p2lYTS3FKJy+ez101BsYJ9NQrzZkGmHm+3MuXS4evHtT3EHVBjFHCGzhYskqJC3r2+Z2u7XXxdw+GJjK1t+nn7E2o6bpu8W8zA8YIH0z7e0rQgDSfKfqLJ4rIpCeygjB3loKVG59MurE8cF/jIt4JWi320s4dIabeB4M8Ck3NKfGlB+haNVmp7FWSYOteC7MLcBt5QYHWtXRAk//pzAMMpvqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::5b) by PH5PR11MB320987.namprd11.prod.outlook.com
 (2603:10b6:510:500::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 06:07:26 +0000
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::19f5:13eb:df52:68ff]) by DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::19f5:13eb:df52:68ff%8]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 06:07:26 +0000
From: "Kandpal, Suraj" <suraj.kandpal@intel.com>
To: "Manna, Animesh" <animesh.manna@intel.com>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC: "Hogander, Jouni" <jouni.hogander@intel.com>, "Nikula, Jani"
 <jani.nikula@intel.com>
Subject: RE: [PATCH v7 12/20] drm/i915/alpm: Modify LFPS_CYCLE_COUNT bitfield
 for xe3lpd
Thread-Topic: [PATCH v7 12/20] drm/i915/alpm: Modify LFPS_CYCLE_COUNT bitfield
 for xe3lpd
Thread-Index: AQHdZQyVHTTV63f9+0a9eJqB3fT3YLcaVrMw
Date: Mon, 2 Nov 2026 06:07:25 +0000
Message-ID: <DS4PPFE901A304FB73BD1E86CD699157168E36A2@DS4PPFE901A304F.namprd11.prod.outlook.com>
References: <20261026054001.799894-1-animesh.manna@intel.com>
 <20261026054001.799894-13-animesh.manna@intel.com>
In-Reply-To: <20261026054001.799894-13-animesh.manna@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPFE901A304F:EE_|PH5PR11MB320987:EE_
x-ms-office365-filtering-correlation-id: 4c25a523-09a6-4a98-62ac-08df38a79166
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|38070700021|4143699003|11063799006|56012099006|261021123027099003|261009223027099003|261009221227099003|261021121427099003|261022075727099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: Cvh2AJInxstwhKtw2JuNZO/5TpNrzkzKFxopPFn8vZyNKMKiVugd7/fummEI+D0U/NLamxs+3fAofAzEF8w7R+gfCJVaNsbuECkKyfYbbR/FWOhHzyyJWyuXhkfRTwjpWaRajTd8u7m/+oR1O6UhV0b7ge5YUJ5o4XWGemsdEyalirJgmqXWphRoOEyiXR35hjNr4jbu82eNJJ3YdbXQdf9RjQ75Wc8dONVdJTOdnq5/w9N/bTkwswxzToNm61SNdNc8wBzI/g7VwuLx6y+h4CAG7cQeecTpKefPu7HL52AOn6BEdfXRsQ83iu/YzeFDppTmgmrC8CA5RFvlzG3+3AMPQWxG/58m2KX9/qkwIja3eNf+UElNJ0RkwO8uihsxbuhOFnDhIeeFuCFaGk9Fn9ffzzLVoQTdaNBhkSFYFoIl1RleBqc/fD6xgByyxA4e/jMcDG+zzphDBPpCqM9o2TOVAVG7J+v/DdXE8ogt3x0/awwYK1HV+tgfyWKbwO905r7cHoh/rQr2hxWAvJLcJyCY3joJuX0iEGaqlTgOPEdIwTTd2JFZmg8eVeH0nUjSd04xF4cSR5ZsH0Q/zUpcKOwaVTKV83n3HJFHOI4OoU8iLYbWeSV7uWTNjZQj14+dINylWYYtiDQfinSqSZPbVFWznbMq6q+/Xy0G6DR0s3WYgYPIPff48QcM58p1MPw4/8WIDZWljKHEn3o1xA2m9/Oi50JzZ2rglthnpc8fokc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPFE901A304F.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(4143699003)(11063799006)(56012099006)(261021123027099003)(261009223027099003)(261009221227099003)(261021121427099003)(261022075727099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUhVaDJiZFJQVG51MGc5aHR5djhHSkxBYVIxbmZyNnowTTExenh6NlE5YmpB?=
 =?utf-8?B?STJPMmlvZEdkZ2E2emJYL1h3YnhacDZHZE0rUEdCdjhVcm5oTWRQU2pBVmVO?=
 =?utf-8?B?SCtSSUkyRXFaVGhBL09Bc2xBUkhkZG1UUXYxb1cveGszeDZsMmZLNTliYkN5?=
 =?utf-8?B?QUczUURvdzh2K3hvblRQTk5GUmh5YXVpSFBnbjZWcTdtL0tQV1o3bzZ0cW1F?=
 =?utf-8?B?OTIyQndLUEkvcjBGQ2N4NXJBRnFFWlpyYU9objZubys2SVZ1UlNGOEtRL283?=
 =?utf-8?B?ZFVnaWczbnl0c2g3SXEvWmg1YW9MbVd5cjRnQmpBdjhHVk8zYmdKZ1BCTXdR?=
 =?utf-8?B?RllRS0VwY0NuakdBMHArQklJTVV6T3RWSVFjOU1NZys2YzJBNUlnT29NQ3hS?=
 =?utf-8?B?RVpJYkxZUlJhbjhPa2FmQ1l3am9QVCsxSTNraSt3SCtma0tYT1hubmRnNzFB?=
 =?utf-8?B?bENRaE94WDBBSkpXaFNEVVplTkhLMVNEZVpMOVB5eXNiWldPKzk5cFdCTExG?=
 =?utf-8?B?bFpiRWFxSEV5QVJidEhJRzFYY05oRGtDQ2ZzL0V0NzB6aVJTVHBYNWtwTzVq?=
 =?utf-8?B?d3B2SmExT2M5VlhrZU03RTdCWWc3VjVWaDVkaExYengxVld2RCtidW1MN2lZ?=
 =?utf-8?B?cDFzckhlNXBqcDhjait3M09GYWRPZ3hNazBpS1grTmFSdlZmZ21nTUdUMG90?=
 =?utf-8?B?VVR2WldGaWY1R2RZRThMQmZCSS93Qy9Cc210dWFjQ3RqenRBQ3Y5djVRR2h2?=
 =?utf-8?B?ZUdFeTc2RThWdWd1anIraFNKSHB0bkVnMTl4OGk4eHZYaEFuOXlmN0tCT3Uv?=
 =?utf-8?B?ZVJRR0g1cnNBeVlLRmthOFJuMTR2U2Y4MWVXK3hyNU5sZW5LM25kQldrVEJw?=
 =?utf-8?B?cVpvYm9VWGNtaEoyMVNYUGdTU3Noc1E5a0x2UjJzUkxDMi9ibzBtTXRUOUI4?=
 =?utf-8?B?V2x0amViR1V1bGxzNnovWGs2a0lLZXlpYnhlb1R4dWdraVdlNjJ3bHdrOE0x?=
 =?utf-8?B?dHkwWlZ0TWlYVWgrblkxZ1EyWTUvN1BvekN6MXQvWEJJVHBtUkV5dFV3OHc5?=
 =?utf-8?B?b3dZekIyWkpTdmVJdmNvb2JldENaODF3eFN5UUd1RWplTGduUWRjNlZocVo2?=
 =?utf-8?B?UGMrWm5GaWdhVzR2dTUrYnlvV0NPUU1Ld1BFdW5nMStYWkVoM09RdXdTSk9u?=
 =?utf-8?B?aytjWTlBRW5mdjdueXlBcnA0aGN6eUZvUlkvQU5VaDJ6eTJMOFRMSUxNK3cv?=
 =?utf-8?B?QmpFUE5aL3NwQTNlY2gxa0J4KzdzM1MyRW5wV0NDendEa1gyVHFoUUthb2xo?=
 =?utf-8?B?YkE1OGJsdUQvbTNvSnlSSlk5SitpV0V2MEpMcWJ5a2hTNG1sRWplbytJbkhF?=
 =?utf-8?B?emkzNklUaGRkaWFlQ0Uzb1o5WUtUTVdXKzNyMkd5NXNhZ282OFVzR0RDZ0dv?=
 =?utf-8?B?SFVyZnhOVGtwYWhJdmphT01tcmZZY21XUDlVcmVMUjlvb2l0dlQ5bThBbHBk?=
 =?utf-8?B?R0tNa0FmTWtrYlZLMU1MWi9qRnNUaVBiY1NnSVd3aFpvejVkd3lMdG4zWUww?=
 =?utf-8?B?c1RXWnpqMXNUOGNydG9xM2poNTdqd0grc0lBdnNMREtoMy9Wc0krai9iTUtx?=
 =?utf-8?B?cHJka21XZzRXMjRaRVZNV04xcjRxWWdMNWg5aFovVE0wWmxhZ3BZbXMyNS9n?=
 =?utf-8?B?cDA0WHpVc1FyRE1Cc2FIdFdRYTJhWGx6R2dPaVRiYnhEd0hQRmFXZjlabzJW?=
 =?utf-8?B?WU5zUmFtd0pQU3hldjFGNnlIbURpc2YzT0FWemNsTlFZdGhuRVJsZjRYUlI5?=
 =?utf-8?B?UjZxOWpGZHhZRXc1Zm1DenNuekwvWFVFbFIvRi93MlNWYS9pMXoxMXJMNmln?=
 =?utf-8?B?MTRwSnF3UTZqczFUMDdJV3JNaStwbWkwUTRJc2Yxam0wc0dyUmdUTHBZaGpE?=
 =?utf-8?B?bXdRV2hvMFY1TUZiZGpmNWRUaDhxeCt1eFJwcDZhVGFXcWZhQjU3RUJLcHND?=
 =?utf-8?B?WGRCQ0dPeWUvVE9MZ2htbjhHN2hUYnpoN29ZT0JqZi9jaDVXczhNaHpTQ3BO?=
 =?utf-8?B?MVVSVkdPNyswSzVidWNXRzVWZ09QcGpBU2VVVDB0QnhseWRSbEp0UkIrRzVW?=
 =?utf-8?B?d1ZSQUZDdi8vTGZaYUpUNWhkQWg5bGwrWDR4R0J5UUU4VlVKYXV3ZlZ5NzUz?=
 =?utf-8?B?Y0pLd3l0MFdtR0VqaWlrbE80cjA4SVhKekxjUmpDZkRxN05DcFM2dlBuNllI?=
 =?utf-8?B?ZDRVT1p4SjUxVEUycHZkVUgvUlVHbDJMdWRvYjZwRkhmN0xGOXo5QlhrRk1q?=
 =?utf-8?B?TS83WnZEb0JIUmNOd2RDbm51aXF4RUhoNStCdEI0bG0xYW82Wm4wUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UG153OUk+/PeptzFyrngFO2R/czuxNJNSo0hYE7s4wOX2Um43viqAF2v+/4pQA9FkCBzZCv692cIyXpH+34Rlyta9JHVf8vma8a6PTHHJxfnlViYutagJYzxMzghe9UmHpT9/rAlRpn2hWB+kmHB9B3treBKuA7Z0oYfF3ptJqYCEjVpUfe1uAIimjJMzfABbj7i/sQdhSG8a+/xbKHUq1rHHn9Uqdmv38kBAdHxuHQ0YR5kmFkeLtVcd/o8upNAOlX3FCTK4VMuAmKhcYusoHPaZZeiVzC1ytyj0AnlGcBJ3HvzhLIlTfh1axaIg/RQJtav8O1Iua6OiM2CA3LH9g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFE901A304F.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c25a523-09a6-4a98-62ac-08df38a79166
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 06:07:25.9728 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4upY/FfBEhM9Ha9yAgN9g7qHjy6QwBQeXZf4xuF1GOQKopp2M2VFa4fhIMn0mESMTcAu3TlzIrTPfe8oW4XSqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR11MB320987
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

PiBTdWJqZWN0OiBbUEFUQ0ggdjcgMTIvMjBdIGRybS9pOTE1L2FscG06IE1vZGlmeSBMRlBTX0NZ
Q0xFX0NPVU5UDQo+IGJpdGZpZWxkIGZvciB4ZTNscGQNCg0KKlhlM3ANCg0KPiANCj4gVGhlIExG
UFNfQ1lDTEVfQ09VTlQgYml0ZmllbGQgaW4gUE9SVF9BTFBNX0xGUFNfQ1RMIGlzIHdpZGVuZWQg
ZnJvbQ0KPiA0IGJpdHMgKDI3OjI0KSB0byA3IGJpdHMgKDMwOjI0KSBzdGFydGluZyBmcm9tIHhl
M2xwZC4gQWRkIHRoZSB3aWRlciByZWdpc3Rlcg0KPiBtYXNrIGFuZCBmaWVsZCBtYWNybywgYW5k
IHByb2dyYW0gdGhlIGN5Y2xlIGNvdW50IHVzaW5nIHRoZSBhcHByb3ByaWF0ZQ0KPiBtYWNybyBi
YXNlZCBvbiB0aGUgZGlzcGxheSB2ZXJzaW9uLg0KPiANCj4gdjI6IFNwbGl0IGluIGEgc2VwYXJh
dGUgcGF0Y2guIFtKb3VuaV0NCj4gDQo+IENjOiBKb3VuaSBIw7ZnYW5kZXIgPGpvdW5pLmhvZ2Fu
ZGVyQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQW5pbWVzaCBNYW5uYSA8YW5pbWVzaC5t
YW5uYUBpbnRlbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9p
bnRlbF9hbHBtLmMgICAgIHwgMTEgKysrKysrKysrKy0NCj4gIGRyaXZlcnMvZ3B1L2RybS9pOTE1
L2Rpc3BsYXkvaW50ZWxfcHNyX3JlZ3MuaCB8ICAyICsrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDEy
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0uYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9p
OTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5jDQo+IGluZGV4IDFmZDUyOGNiN2ZlNi4uZjNjMDg4NDk4
OWNlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2Fs
cG0uYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0uYw0K
PiBAQCAtNzQ3LDEyICs3NDcsMjEgQEAgdm9pZCBpbnRlbF9hbHBtX3BvcnRfY29uZmlndXJlKHN0
cnVjdCBpbnRlbF9kcA0KPiAqaW50ZWxfZHAsDQo+ICAJCXJldHVybjsNCj4gDQo+ICAJaWYgKGlu
dGVsX2FscG1faXNfYWxwbV9hdXhfbGVzcyhpbnRlbF9kcCwgY3J0Y19zdGF0ZSkpIHsNCj4gKwkJ
aW50IGxmcHNfY3ljbGUgPSBnZXRfbGZwc19jeWNsZV9jb3VudChjcnRjX3N0YXRlKTsNCj4gKwkJ
dTMyIGxmcHNfY3ljbGVfdmFsOw0KPiArDQo+ICsJCWlmIChESVNQTEFZX1ZFUihkaXNwbGF5KSA+
PSAzNSkNCj4gKwkJCWxmcHNfY3ljbGVfdmFsID0NCj4gUE9SVF9BTFBNX0xGUFNfQ1RMX0xGUFNf
Q1lDTEVfQ09VTlRfWEUzTFBEKGxmcHNfY3ljbGUpOw0KPiArCQllbHNlDQo+ICsJCQlsZnBzX2N5
Y2xlX3ZhbCA9DQo+IFBPUlRfQUxQTV9MRlBTX0NUTF9MRlBTX0NZQ0xFX0NPVU5UKGxmcHNfY3lj
bGUpOw0KPiArDQo+ICAJCWFscG1fY3RsX3ZhbCA9IFBPUlRfQUxQTV9DVExfQUxQTV9BVVhfTEVT
U19FTkFCTEUgfA0KPiAgCQkJUE9SVF9BTFBNX0NUTF9NQVhfUEhZX1NXSU5HX1NFVFVQKDE1KSB8
DQo+ICAJCQlQT1JUX0FMUE1fQ1RMX01BWF9QSFlfU1dJTkdfSE9MRCgwKSB8DQo+ICAJCQlQT1JU
X0FMUE1fQ1RMX1NJTEVOQ0VfUEVSSU9EKA0KPiAgCQkJCWNydGNfc3RhdGUtDQo+ID5hbHBtX3N0
YXRlLnNpbGVuY2VfcGVyaW9kX3N5bV9jbG9ja3MpOw0KPiAtCQlsZnBzX2N0bF92YWwgPQ0KPiBQ
T1JUX0FMUE1fTEZQU19DVExfTEZQU19DWUNMRV9DT1VOVChnZXRfbGZwc19jeWNsZV9jb3VudChj
cnRjX3N0YXRlKQ0KPiApIHwNCj4gKw0KPiArCQlsZnBzX2N0bF92YWwgPSBsZnBzX2N5Y2xlX3Zh
bCB8DQo+IA0KPiAJUE9SVF9BTFBNX0xGUFNfQ1RMX0xGUFNfSEFMRl9DWUNMRV9EVVJBVElPTigN
Cj4gIAkJCQljcnRjX3N0YXRlLQ0KPiA+YWxwbV9zdGF0ZS5sZnBzX2hhbGZfY3ljbGVfbnVtX29m
X3N5bXMpIHwNCj4gDQo+IAlQT1JUX0FMUE1fTEZQU19DVExfRklSU1RfTEZQU19IQUxGX0NZQ0xF
X0RVUkFUSU9OKA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9p
bnRlbF9wc3JfcmVncy5oDQo+IGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9w
c3JfcmVncy5oDQo+IGluZGV4IDEyNGFhNzRlMWRiYi4uYWVlNGYyNTkyMzAyIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX3Bzcl9yZWdzLmgNCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9wc3JfcmVncy5oDQo+IEBAIC0z
MzUsOCArMzM1LDEwIEBADQo+ICAjZGVmaW5lIFBPUlRfQUxQTV9MRlBTX0NUTChwb3J0KQ0KPiAJ
X01NSU9fUE9SVChwb3J0LCBfUE9SVF9BTFBNX0xGUFNfQ1RMX0EsDQo+IF9QT1JUX0FMUE1fTEZQ
U19DVExfQikNCj4gICNkZWZpbmUgIFBPUlRfQUxQTV9MRlBTX0NUTF9MRlBTX1NUQVJUX1BPTEFS
SVRZDQo+IAlSRUdfQklUKDMxKQ0KPiAgI2RlZmluZSAgUE9SVF9BTFBNX0xGUFNfQ1RMX0xGUFNf
Q1lDTEVfQ09VTlRfTUFTSw0KPiAJUkVHX0dFTk1BU0soMjcsIDI0KQ0KPiArI2RlZmluZSAgUE9S
VF9BTFBNX0xGUFNfQ1RMX0xGUFNfQ1lDTEVfQ09VTlRfTUFTS19YRTNMUEQNCj4gCVJFR19HRU5N
QVNLKDMwLCAyNCkNCj4gICNkZWZpbmUgIFBPUlRfQUxQTV9MRlBTX0NUTF9MRlBTX0NZQ0xFX0NP
VU5UX01JTgkJNw0KPiAgI2RlZmluZSAgUE9SVF9BTFBNX0xGUFNfQ1RMX0xGUFNfQ1lDTEVfQ09V
TlQodmFsKQ0KPiAJUkVHX0ZJRUxEX1BSRVAoUE9SVF9BTFBNX0xGUFNfQ1RMX0xGUFNfQ1lDTEVf
Q09VTlRfTUFTSywNCj4gKHZhbCkgLSBQT1JUX0FMUE1fTEZQU19DVExfTEZQU19DWUNMRV9DT1VO
VF9NSU4pDQo+ICsjZGVmaW5lICBQT1JUX0FMUE1fTEZQU19DVExfTEZQU19DWUNMRV9DT1VOVF9Y
RTNMUEQodmFsKQ0KPiAJUkVHX0ZJRUxEX1BSRVAoUE9SVF9BTFBNX0xGUFNfQ1RMX0xGUFNfQ1lD
TEVfQ09VTlRfTUFTSw0KPiBfWEUzTFBELCAodmFsKSAtIFBPUlRfQUxQTV9MRlBTX0NUTF9MRlBT
X0NZQ0xFX0NPVU5UX01JTikNCj4gIC8qDQo+ICAgKiBUaGUgTEZQUyBoYWxmIGN5Y2xlIGR1cmF0
aW9uIGZpZWxkcyAoaW5jbHVkaW5nIHRoZSBmaXJzdCBhbmQgbGFzdCBoYWxmDQo+ICAgKiBjeWNs
ZSkgYXJlIHplcm8tYmFzZWQsIGkuZS4gdGhlIHZhbHVlIHByb2dyYW1tZWQgaXMgTl9TeW1ib2wg
LSAxLg0KPiAtLQ0KPiAyLjQzLjANCg0K
