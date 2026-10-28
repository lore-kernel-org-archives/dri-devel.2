Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D77A606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 21:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KEXnetJD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9666710E415;
	Wed, 28 Oct 2026 21:01:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E797F10E2DE;
 Wed, 28 Oct 2026 21:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793221290; x=1824757290;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=VnIfUB7+MO6Gnv3AT23MwTiswKyLCydCBZgj5h/yu1I=;
 b=KEXnetJDLy9+QJTISKPKXyay6MVBzw82fchBvCfe7/YJ6lXT2GDh+Wkh
 NuLrhp/OB2Dr4ROs2q1FMSP+lUoE8TngXYOf8VSLV5o6pgyVcj8wyBk77
 Z30EwuD+57Pdml9oyJesLBisKUw4Cph5tt3vm5EgBWXyxJ3oegbe2PYmT
 NI0iROtIT3bdRiuLOi6t5AjTViNZItKrkSN6lj0zZ+pzVAKttVPsP63KI
 QsAGCgdR3R4eIrMGyfevixiQadTewb8NwDZ4zhOth0Tx17PUr4o8W4wyM
 GlhRkGo7SDkjfHRIUuvnB74Mj2PJZYxXGXchXRCT9edsh5fGSgY1hgsmm Q==;
X-CSE-ConnectionGUID: 6yydTzfaQdO0W/5pGXkDtA==
X-CSE-MsgGUID: 7Y4TMH0BTrqDMOwdDO7isQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1839696"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1839696"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 14:01:30 -0700
X-CSE-ConnectionGUID: 3wMBV3KhRX21Sr/0NILGCQ==
X-CSE-MsgGUID: aMQiOBCpS4aBaR1lKZfe6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="6779717"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 14:01:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 14:01:28 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 28 Oct 2026 14:01:28 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.62) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 28 Oct 2026 14:01:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pz3C96S01DhU0bj0Al799h++pJc6L5yPFyk73jnE8ToaeWcmAmyYi9rOm+FNgyzOa+h0CdqZFIVeohq4IHnNsnpyHuvtoJ7D6alW/5iH0vuTm6KFB1sXfz0aEB/s4PyVGvtv81BYlZD/GW45mUdtKz8MKGceS/Usm77kQ5eKzbDFsiQ8N7sAx9B3rFqu3DNdLN+23l9/VpCoxJPBq0G982TxWVwOxsTw4jZkLXoR3LFmVHRWYTj6FApBVkDYh0TEB4/vUt/zlWRDAJT82tpIX9AMnlIAdbDd94+dpqsBRlIDPS/UD/m/Ln8WfkflNj4Y5bD81uosF9JSpq1Vr3BOBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VnIfUB7+MO6Gnv3AT23MwTiswKyLCydCBZgj5h/yu1I=;
 b=Jc8x63/5AwCFD7KrUuIuCVs1uGWLShrSvZJKwFRuwy/F+blMeFKIfbRRW5eq5R8hRLEq/Fo6OErq6xDPRc8v9/yJmNLQbPJD5wu3Dwl5OUBEA0erxHFCz0JwkEr9uNgw5VELv8vH84h3PRESSGHncKc7Ze11iBC1ODsXALDIlamV/ht8TiTCxxUFLTBRMoo3LtYqGHbObUXuDXfVHjhfKY3B1vPAc9lwR0N3u89vGwBSAxUsryUr1kppV/brggF/VDpZ97gpf/JBEM7PAXeS22Km+hUBMmqi90AyJZEZWiiuFdQPvcf7PoWbAFlW3wEyfjhHaGpfn5eoEMVAb4hyyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LVWPR11MB9883.namprd11.prod.outlook.com (2603:10b6:408:3c0::11)
 by IA3PR11MB9350.namprd11.prod.outlook.com (2603:10b6:208:574::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 21:01:21 +0000
Received: from LVWPR11MB9883.namprd11.prod.outlook.com
 ([fe80::310:e83f:69b8:e11e]) by LVWPR11MB9883.namprd11.prod.outlook.com
 ([fe80::310:e83f:69b8:e11e%4]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 21:01:21 +0000
From: "Teres Alexis, Alan Previn" <alan.previn.teres.alexis@intel.com>
To: "Jadav, Raag" <raag.jadav@intel.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Tauro,
 Riana" <riana.tauro@intel.com>, "Roper, Matthew D"
 <matthew.d.roper@intel.com>
Subject: Re: [PATCH 1/1] drm/xe/survivability: broadcast dmesg when engaging
 survivability
Thread-Topic: [PATCH 1/1] drm/xe/survivability: broadcast dmesg when engaging
 survivability
Thread-Index: AQHdYxUQrX/Q3sL74kOuQzp1gjK0A7cST8SAgAEpCAA=
Date: Wed, 28 Oct 2026 21:01:21 +0000
Message-ID: <f7f8745978c21de8687e1e539a15f0be9f9d4a6a.camel@intel.com>
References: <20261023173625.601113-2-alan.previn.teres.alexis@intel.com>
 <auFpdeRIafjgKSV9@black.igk.intel.com>
In-Reply-To: <auFpdeRIafjgKSV9@black.igk.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR11MB9883:EE_|IA3PR11MB9350:EE_
x-ms-office365-filtering-correlation-id: e1c0a332-9714-49ba-a560-08df35369e7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|261026140227099003|261028144727099003|56012099006|4143699003|5023799004|11063799006|10067099003|261021121427099003|261009223027099003|261022105027099003|261026121527099003|38070700021|261022075727099003;
x-microsoft-antispam-message-info: kaVXkmMM37VxtGjsenQ0TDE5JQTgKJu6XlgLa2DBJoJ+pN3gUC2BtvtLfJOJMVLWbQc6vK/enx/rWhDrG96o1MoCwqzWLUzC0zFIB+BgJ8zmMKFi/4grXA5WunNXCYTMXStWwx0U+BFpETjTLeuNO8z8pnPwO9WCRE06EiB5+eewGBbM1SJLIuTa4lHXKdWE/0IwUxs+nuiG3GANNnxK6N9xPF6TnB37X7CY5HA58o5cHP3+662Ji61CkVuGLIFAqibon0LGrPlS23WNSOngyq4hi9WiBVYQ8PR8btp6qGBYKCW8l+1kxOIHHTnRxAXeiShXx6Z48wHX7C1xDvL05/pPz7iRYzW3lZf2nYu7epRxBCYPDY5dHLiZ5kEPK2vNAnWjTxOmJU3TMYt/N9OaGPg/4rU7GX5Dfa2f1d2qrDpOOnHtGHepgC3S9pw3q2+Y/+HQsDztWUS6TM/f4slPPW2n/+ono+B2oY3HhvhZgqFMuR2+5Ovp5PHfDjFCAhQc6sLBsRwpySIBNasHTe0hCvoR5+ZhNUxHZSOzI6knKLViMRQsPLZfonj8ClEXga62/CqIch0jioqkWyBm5yTtBaGMnyzfKxINPWu/77yuRTrpPIGVN78mqzcFqUTpkpZEkevLioekMj6AZS3Y2iq4asH1IRYXl4d0V0WbPvdvrsMiCgBa8/pkN+3kQ0k+v9u2xFt16KqgFjYh1L26vvFLWze3L5urlxzmyji0ZxRKwgM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LVWPR11MB9883.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(261026140227099003)(261028144727099003)(56012099006)(4143699003)(5023799004)(11063799006)(10067099003)(261021121427099003)(261009223027099003)(261022105027099003)(261026121527099003)(38070700021)(261022075727099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEc4Z09HSnljdW5kbG9aN0szOExuYnFTQ21pMFQ5cVFROUQxRG55WVJONDdV?=
 =?utf-8?B?UUtsakhJaWg1SlRBWDZUZXNUQVFsdG9xYWk5c3FKSU9oaGhEeUpZeTIxT2RI?=
 =?utf-8?B?a2JDb2o5dk0xR2ZJbzA2OVFFeUVXSGFVR2NOQkdESUZPVTF6THhrQkRVQVh1?=
 =?utf-8?B?emhCZExpbWFVL1Zld0d1NUlVSGw0ckIwYzlGUGNQUENmdjBtcjdwV2xOWGlL?=
 =?utf-8?B?bko2bnVOaXlzWXU4SVJ1amtOWVQrVThDMkxBT0g5dkpNclZmZ1ZNZkZzZi9p?=
 =?utf-8?B?aHIrei9paEZjWVIzU3cxYzljVVR1dk9DSVZyek1rN2VSV2pnWE4xcEpBV2or?=
 =?utf-8?B?bm1DSUU5SktxSFNsbkx4UnF4M0NMSExpSzFTdXN5VjNOTVQwVEswUnBWUXo0?=
 =?utf-8?B?OTdKYUQ5QThpWnZGaGNCcHV2YXhUTzVNTTAwK2xXK1RReWhsTmorQUJ2NDMr?=
 =?utf-8?B?UVZETHdiSExWbFQvMWFqM1NKcWRKTkZENEJHcFJuWjVaeDZwR0piOW9MbFBp?=
 =?utf-8?B?NzlvRFMvSld4bzhkWnpyOVBmR0I1TkZJdDQyVWZLcS9hMS9zK3g2UVNsV25h?=
 =?utf-8?B?VjFWclVoazBJYmxzb0RCSzU0aTd3T21IZ2dodE9HWWVtZ3czQzR4MmNTVDl3?=
 =?utf-8?B?dFZ5dU0wWThxVDZxSjFNZXVCU0FhSlU1cjI2bjJJVFFzQUh6ZnR0Wjh3eEVB?=
 =?utf-8?B?a2sxYWorNW1kYnQ3anNrNmhrU1ozek1UYW5uSnZiQlp2d1pMbWFzZVRIZE5x?=
 =?utf-8?B?WXpleUR2eWlSRTE5VHhqbEhBYjZvSmZobVNqbEp2RWJoRGd0d2thS2QySXRk?=
 =?utf-8?B?aHowcmtXSlVkRVZ2SmNyYmI2WGw1eUV5MWs4UnZjWVg5RmpOVm5TeFBHelFN?=
 =?utf-8?B?ZG5oYTJ6c3l2NkFjeUltWURRU0tUWU5HbzJGaEFjZzZZV2tVYlFyWnNhRnpG?=
 =?utf-8?B?cTRid25MUjVYalUveFR1TU50NVAwL3dUSXlXdjluTjloZWR0R05FYURmVnNE?=
 =?utf-8?B?dU1TR0JwYWVGQWlxa2Y2QkVxTG82UXlacTBnT2NKdEw5U0NjTnhoditDNXdK?=
 =?utf-8?B?WHVKeHFqOWNTd2Y3b1o0ZEtSYThPMng1OWZERnUrb28wTmdmWW5QT3ZNTTBl?=
 =?utf-8?B?VHdrOU1zbUhvU0xFSjNFM0NRWHFDU2lrY2xMcEg1bEpkcjFWaVhrOWNoa2tG?=
 =?utf-8?B?YzBGY2g4RkxYSHk4cXJMNVFxSVhVVkdvVThSL2dKTURPNndSL3FjZ1NENkhG?=
 =?utf-8?B?a0daMkZqTTJBOXRUby9ISnBqM2dQTnNwUmRzRjhITWhHUTQrb3FuUjh0Zmxj?=
 =?utf-8?B?OG9RRnk1R3Z5VDZrbWYvRHhLTnNIK1dGTFhnOE1XZE1kdWtEWjNJVk9ySURI?=
 =?utf-8?B?WXdCT2NTWmo2WnhoL3huZFdteGdBV2lDWXhZU2h2NFQyT0N3ZXdkYUNHdEIy?=
 =?utf-8?B?QkpNcHk1Z0Z6cFkrKzB4SXJFeGh3UlFmTHZpQXpRaHJtTFpCaURNQTZtM3hP?=
 =?utf-8?B?aWVCMEc2OEYyRktaeTRCZlg3TS9DR0VwOUFOYlczZ01CM21kdmZiWGIySnB6?=
 =?utf-8?B?VUhRTHlnTkNXTkZvVy9xOU9QT1dqV0YyZmxITXpQZXFYNG9YZlJzeVZ1MW1o?=
 =?utf-8?B?UENnNFVwUGVlUUZVU1J5Nk9DTldpNndsT3Urc3c3Qkd3cEdZZGdCSjlpWDRp?=
 =?utf-8?B?WmhxOW1FSHZPZGNQdEZuSGtKOWMraS9uSXVqNituSkN6UnlvQWx2WVQrWlkv?=
 =?utf-8?B?YTI5dnROc0ZMQXRyZjRBVCtMTUlZVkdqbWNndWIrL1VsUHFvenNxdWdBMGp4?=
 =?utf-8?B?V3BYU2lpRDR5N2Zib09yNkUvQ05hU0JNb1ZjK1BPNmpvQ1BtcjN4cm5mZUly?=
 =?utf-8?B?TmR5VlNIaElFL0Q1RVMvak5NazB1MEptNld3Q2lwMDN4eE1OZktaaDRWSFMw?=
 =?utf-8?B?c2EwakQ5ZytlZTA1WkFrU2tDb0lOTk1SN1pyR204UXM5dFYyUUw3SXViWnlt?=
 =?utf-8?B?L0dtRmFLY05ESHNwNEhBNnJ4bkdGZU5obVZxYlRsajJOWGxHTnUrQjF4UTVE?=
 =?utf-8?B?RW81bHNZamprRHd4YTZqeWI1eW82dHJuTEpidmdEeXBiU3RlNmpNWmx0K0lW?=
 =?utf-8?B?QlhEeVgweS9COW81TGFxdVltZTFkU3o4anN1cS80cmc3dXd1ODVqcUVUckhZ?=
 =?utf-8?B?c0Z4NHJBaHF5b21BRmNyNnVBUE42N0h2L1BIcmlNMS9qYmJvZjRLeTNsS0cy?=
 =?utf-8?B?YjA2SEVFS01uZ3RSRmRCMHd1dDNXcU5wTXN1bXgvZVZuZnhKem00MEJDWWdz?=
 =?utf-8?B?NnZ2Q0tFdWtKeHpuZkYrcXEydW1HV0VXNmZhbi95QUdNMGdOSTJpcEltU3hN?=
 =?utf-8?Q?fRjag2hePV2zHjPVn9o2UiXOp2xHmxtd3zRv0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <071FB9BDAD442A43BF2E583E72FA38BC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 0lRnPfigP+51xnfV1Pjd6EoNN9C/dm+K1PdbGtaJMmX+tRJwuPZrQzYj2MU7LCSnp8CJ8VTDsspruxeJDIxLAtUTv17N2SURpvYzv8n4zvLBngooBpne7dakDWJIvox3eUxJU30rSiDfz0xtw+WeAHVFfnkuvrS8IF8WGdEUBzpL01iccavsOtHPvLUmYXPxwFO9KohRdaK7wjlKKS/Naj945uzRcZYeyfQEbIUgo97AZs06IsKLvWAhy1yYRqie1MblSH7oYZYHnzTNIkLazFnOS3yJtNKWz1G7tCzX4OzVuYOyrPpwyH4Jl/ryeC8U419YVi6NV94MXOQ6FIdEBA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR11MB9883.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c0a332-9714-49ba-a560-08df35369e7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 21:01:21.3429 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VLbI+BJobxf0vFY1qWqvSrTORjTiplUDXAfT9cdu2Et/VWdQKfd4crArM/+teU05D8hSmTt/+VWscUOwxl1QqAiiL0wVCUW7AdW9K1kGODNhlAbAKyAfCQmN3rk/TKyN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9350
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gV2VkLCAyMDI2LTEwLTI4IGF0IDA0OjE4ICswMTAwLCBKYWRhdiwgUmFhZyB3cm90ZToNCj4g
T24gRnJpLCBPY3QgMjMsIDIwMjYgYXQgMTA6MzY6MjVBTSAtMDcwMCwgQWxhbiBQcmV2aW4gd3Jv
dGU6DQo+ID4gVG9kYXksIHdoZW4gdGhlIGRyaXZlciBmYWNlcyBpc3N1ZXMgd2l0aCBlYXJseSBw
Y29kZSBlcnJvcnMNCj4gPiBhbmQgYXR0ZW1wdHMgdG8gZW50ZXIgc3Vydml2YWJpbHR5ICh3aGVu
IGV4cGxpY2l0bHkgcmVxdWVzdGVkKQ0KPiA+IGl0IG1heSBlaXRoZXIgc3VjY2VlZCBvciBmYWls
IChsYXR0ZXIgYmVpbmcgcG9zc2libGUgZHVlIHRvDQo+ID4gdW5kZXJseWluZyBzdWJzeXN0ZW0g
YmxvY2tlcnMpLiBEdXJpbmcgdGhpcyBmbG93IHRoZSBkcml2ZXIgcmVtYWlucw0KPiA+IGxvYWRl
ZCBhbmQgY29tcGxldGVseSBzaWxlbnQuIE5vIG1lc3NhZ2VzIGluZGljYXRlIHRoYXQgaXQgbWF5
IG5lZWQNCj4gPiBvciBpdCBhdHRlbXB0ZWQgYW5kIHN1Y2NlZWRlZCBvciBpdCBhdHRlbXB0ZWQg
YW5kIGZhaWxlZCwgdG8gZW50ZXINCj4gPiBzdXJ2aXZhYmlsaXR5IG1vZGUuIFRoaXMgcGF0Y2gg
YWRkcyBzb21lIGF3YXJlbmVzcyBpbiBkbWVzZy4NCj4gDQo+IFdoYXQgY2FzZSBhcmUgeW91IGV4
YWN0bHkgaGl0dGluZyBoZXJlPyBGcm9tIHdoYXQgSSB1bmRlcnN0YW5kIGJvdGggcGNvZGUNCj4g
YW5kIHN1cnZpdmFiaWxpdHkgZmFpbHVyZXMgYXJlIGxvZ2dlZCBpbnNpZGUgdGhlaXIgaGVscGVy
cy4NCj4gDQo+IFJhYWcNCg0KSSBiZWxpZXZlIHRoZSBpc3N1ZSBjb3VwbGUgb2YgdXMgb2JzZXJ2
ZWQgd2FzIHVuZXhwZWN0ZWQgdmFsdWUgaW4gY2hlY2tfYm9vdF9mYWlsdXJlDQpjYWxsZWQgZnJv
bSB4ZV9zdXJ2aXZhYmlsaXR5X21vZGVfaXNfcmVxdWVzdGVkLiBCdXQgYXMgd2Ugd2VudCBiYWNr
IHVwIHRoZSBzdGFjayB3ZQ0KaGFkIGFic29sdXRleSB6ZXJvIGluZGljYXRpb24gdGhlcmUgd2Fz
IGFueSBlcnJvci4gbm90aGluZyBpbmRpY2F0ZWQgd2Ugd2VyZSBldmVuDQppbiBzdXJ2aXZhYmls
aXR5IG1vZGUuIEF0IGxlYXN0IGluIHRoYXQgZmFpbHVyZSBwb2ludCBjYXNlLg0KDQpJIHVuZGVy
c3RhbmQgd2UgaGF2ZSBpbmplY3RlZCBzaWdpZCBjb2RlIGxvZ2dpbmcgaW4gdGhlIHZhcmlvdXMg
b3RoZXIgYnJhbmNoZXMNCm9mIGRvd25zdHJlYW0gbG9naWMgKGZyb20geGVfZGV2aWNlX3Byb2Jl
X2Vhcmx5LT54ZV9wY29kZV9wcm9iZV9lYXJseSAvDQp4ZV9zdXJ2aXZhYmlsaXR5X21vZGVfaXNf
cmVxdWVzdGVkKSwgaG93ZXZlciwgSSBpdCB3b3VsZCBiZSBtb3JlIGludHVpdGl2ZQ0KdG8gcHV0
IGEgc2luZ2xlIG1lc3NhZ2UgYXQgdGhhdCB0b3AgbGV2ZWwgdG8gYXQgbGVhc3QgaW5kaWNhdGUg
c29tZSBraW5kIG9mDQpzdXJ2aXZhYmlsaXR5IGFjdGl2aXR5IHdhcyBkaXJlY3RlZCwgYXR0ZW1w
dGVkIGFuZCBlbnRlcmVkLW9yLWZhaWxlZC10by1lbnRlcg0KDQpJZiB5b3UgYmVsaWV2ZSB0aGUg
Y29ycmVjdCBmaXggc2hvdWxkIGJlIHRvIE9OTFkga2VlcCBlcnJvciBsb2dzIGF0IGV2ZXJ5DQpz
dWJicmFuY2ggaW5zdGVhZCBhdCB0aGUgdG9wIGxldmVsLCB0aGF0cyBmaW5lIHdpdGggbWUgdG9v
IHRvbyBidXQgaSBub3RpY2UNCnRoZXkgY3VycmVudGx5IGRvbid0IGFjdHVhbGx5IGNvbnZleSB0
aGUgc3Vydml2YWJpbGl0eSBzdGF0ZS4NCldlIGhhdmUgbWVzc2FnZXMgbGlrZSAiRmlybXdhcmUg
Zmxhc2ggcmVxdWlyZWQiIG9yICJCb290IG1vZGUgZW5hYmxlZCINCmJ1dCBub3RoaW5nIHNheWlu
ZyB3ZSBhcmUgaW4gc3Vydml2YWJpbGl0eSBhbmQgdGhlIGdwdSBpc250IHVzYWJsZS4NCg0KDQoN
Cg==
