Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CE7606A33E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=S8x87mOh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C00F10EF36;
	Mon, 23 Nov 2026 15:19:12 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012039.outbound.protection.outlook.com [52.101.48.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEF0C10EF33;
 Mon, 23 Nov 2026 15:19:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jujlLaJLAE3A6VBcwXpbP6oIHeN8xMLwhddpVnNu2FS9GoXoI/+I24aD6TvjCpX6PqmFrLXt51KZQY8YPMRkXxoDvl9r+Nb0S2sPwMTUHmxUgPzGSN08JjirkPYypL4zb/gldiq7gsmOimNm8p+OGIzc2ZV0WrhXv7kWOPnqIb/F4PkME97H7d+itzr8ysabhMp1Kqm6Dh3hxBmDt07LMNzb/W0bHTfPrG+a3rtGCA9H3kTwefmKWnctftCcKhzSQgD7b66ipaf6CJhMuwI+teHCedpPYPPNIS85o0FkSbf3RiLIq8QXh8AdtYs9wet37ZyfFCy/Q0hwILL9MbybTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvmJF5kTtbYgR3MZO53Cz0ws83Vsg8UYDpWuln8bE9o=;
 b=sTQpeNGpFY/eKShxNjYhkIhZKJ6453JRpTZ5Nqfi7giJmSY6kAcRiw3BQobTwK/3e1xDq53oYffAbyv7dky2BhPyYmWmmEfxyRBCJowOspScOTtnzsFR5FwQFdWhSe5e3QE5AZGyoo7/ssIFn2CL+k55MpIoBoVX2CzbGC+8/vM7Ga3B9nh0JO6gZfICAfkiekPabE0D53awK8URr90UMiqFzXoglXO1O6QKryWIjqKDnzLvHXpK6MZoR2FYw8eUbp82l5yk7y63hv+kHTlFG5LxFeCK1QOvOrM3Uv24CPRCbY+sQOQSRE/bP8sw0Q5fAg8rivpUULjxp3EHBDqDlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvmJF5kTtbYgR3MZO53Cz0ws83Vsg8UYDpWuln8bE9o=;
 b=S8x87mOhP+OBjLKeLHRKJlyXdCyI1HC2tM4NlM/N2CRz/Ln4kOPHua8R0X0cvdojHz4TooYxyEZeOxlYDjweT+yT8Ke85ifBxzs+MK3fELMSeYBHhIlNpXtlMkl2NRpoPinJyNusrJW02F39TrPgMUFqXr6xfoEZxgqvnyyYVZU=
Received: from IA0PR12MB7505.namprd12.prod.outlook.com (2603:10b6:208:443::15)
 by SN7PR12MB8603.namprd12.prod.outlook.com (2603:10b6:806:260::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 15:19:01 +0000
Received: from IA0PR12MB7505.namprd12.prod.outlook.com
 ([fe80::9012:fd0b:696:a346]) by IA0PR12MB7505.namprd12.prod.outlook.com
 ([fe80::9012:fd0b:696:a346%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 15:19:01 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>, "Pelloux-Prayer,
 Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: Sashiko-bot <sashiko-bot@kernel.org>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 1/6] drm/amdkfd: avoid NULL kfd_process_device in
 kfd_profiler_pmc
Thread-Topic: [PATCH v4 1/6] drm/amdkfd: avoid NULL kfd_process_device in
 kfd_profiler_pmc
Thread-Index: AQHdcG3D2ca745EOwEGuYWn8osZPubc7y6EAgAAO51A=
Date: Mon, 23 Nov 2026 15:19:01 +0000
Message-ID: <IA0PR12MB7505F20F3321543804DEC2B985452@IA0PR12MB7505.namprd12.prod.outlook.com>
References: <20261109171333.4329-1-pierre-eric.pelloux-prayer@amd.com>
 <367d0247-8523-42bb-9c8c-5194f0c9fe95@damsy.net>
In-Reply-To: <367d0247-8523-42bb-9c8c-5194f0c9fe95@damsy.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-23T15:17:03.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7505:EE_|SN7PR12MB8603:EE_
x-ms-office365-filtering-correlation-id: 0b22350b-102c-471a-3cb1-08df49751a6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|261009223027099003|22082099003|18002099003|261022105027099003|261021123027099003|261021121427099003|921020|261026121527099003|261026140227099003|261028144727099003|261102123227099003|56012099006|4143699003|10067099003|38070700021|11063799006;
x-microsoft-antispam-message-info: KHNP2wIMiP68aGIGnMl43DaOW+Do0rLse3PEOrGgsSLb2ZuF823R+HhHtUwouvW/XaQ8tB7ZMvUbfSh7ioQD9EXNWOcnws3l3bXYZbGsSSFyZdmirxUvV+l31pPYFEcqVgG0W5GUK0tpfZtu2osPZFPtycltbvYbrWUV8Z5NBJ/XldrmyjXDF7gtq2vPqiUDZyDduJy1TndMB2+bCcMR6lJGlxgKQ58slCMtRaiR08EzO4Uw61R80J8zDkJoJRWrPOMXa6o8rYDmfct4VNhsw5Q/p82E3q8KH4TgZTy3Fj9Vi7nhTUciX4OQ6fQBr/9dZJN2MRUJej5NLRjwK/W1GRN7eyYeIWvIAbwNtcw1J+NNaqd9H5JTo2sTDFJ9Q68s7m/gm0lBxJu+whUbR/G+dTbTjq2WmEmzzEPtDl1hJPPmTx8OFeca5gLZ7ORP8UWFu6iycfdjCTkK0MdG95QO4mdyAiA+bh3EqgbM7HUqsrVbHd99Md30fdlF/2v+xyHyVzJuaV2AgsD06kVuSvybOPZmz+IfgwswFvrqSBf3TWo7yQ1pm9sGxiiWPU9mOV9cDJUCwchJHR82QDTjZQKzp/ayu6GFxrWyQYgj3n6/xTtS8nf7BdYpHqVxUXSY1DX0OGUnFbTLbLuLdF6u6vhYpvoyuHlRvEZFbvIUPswz0T0lQoYjqnWRZ0Iec+VD9lrC
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB7505.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(261009223027099003)(22082099003)(18002099003)(261022105027099003)(261021123027099003)(261021121427099003)(921020)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(56012099006)(4143699003)(10067099003)(38070700021)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1czY1JpdFNyK0tpZFczaDJzeWMwY2IwY01QZC80MXJLS3ZkZTRGbUpOVmFL?=
 =?utf-8?B?RExMdkVsOXVVU0J0OGhJQ3pqaytmakZEZ2NwUDlickxXeVprOGhrNklpVHha?=
 =?utf-8?B?L3FUdnIvZTU4cnE2ejhYbnY0Q2lTbzAxclZvWGhPaDNJa01jakNyQVNEUVNN?=
 =?utf-8?B?NEEyUC9kbzd2RDVrdCtlSE40blNTMFpIZkoyNWxGRjhzZnhpeUdvdHlYaEJN?=
 =?utf-8?B?RGZYa1NDTnRDZE5zZVptTGpEUUk0cldNUjEyRG5vNVpIR004VnNHRVh2MXBt?=
 =?utf-8?B?enVCeU96eXp3V3kvcFBQbnpzT01KT2VraE9aU1dqay9SQjdtclBzdG5wdDZ2?=
 =?utf-8?B?UHBHNm5yeHZkVi9PU3F5VFUyM25Ma0NjYWdvbENEYncwVEowY3ZMRXZtd2J1?=
 =?utf-8?B?V2t1TlM0cWl2dmdnbjRkV2hDN2RoZDNYQ0NydnVFaGZnb2M0bk45ZElYZHVs?=
 =?utf-8?B?eFlIc2xWbU40bjA5NCs2VWRsK3NDUmh0Y2xINDFxOWQzSjhicStnNEhFTWRk?=
 =?utf-8?B?aTRiaE1vNUtlNDNrYnF4d0V5K2NRNlFHUG5adllrN0ZyM2JVM2ptRElMTnFm?=
 =?utf-8?B?UnRObmRTR0loMXB4YXdQeG01L0c5US9XY2dEVi92aWJHN1h2dStjNko4ZmRQ?=
 =?utf-8?B?eE9iSWZqNHdBaVd4MUpRNEFVYi9LQk85MG5QeEoxUnlON1k5SWNsbGNSM1Av?=
 =?utf-8?B?bEx4ZnBobnpDbUplNlRDd2lIeUxLRkxlcWxWSkRkUENwQzU2Ym9waWd2TG5E?=
 =?utf-8?B?MUxWeXI2blUyS3RRODNNdkhGb0gvNktveDlQa2wrMU42Zzhzd0VheVFnaS9m?=
 =?utf-8?B?bnJ5TlhiWis2ZXVtYjU1c09uMmhXRDVQVjE5Y1JWZ09mWWQwS01qZWdCKzQw?=
 =?utf-8?B?ZEJWT2N4bUtiMGpOeUZ6UHdDUVBwOUhIMmkydTRTRVBnTlVQYitQQk1xdFl5?=
 =?utf-8?B?YWJPczdZT1MwNG1aNm95N2NKVHNzdWkvV252Y0NnWW1EM0ZuSUh5Ym0xbDJ3?=
 =?utf-8?B?V3VwOGxwaStNRjNFVkhGYVVBU0NtRXY2eWhidm9nd3NCZUlzTjU5MlVJUDFX?=
 =?utf-8?B?OEM5NkVoY0RGc1lDR2FzUzY5SE1FUVppQzQ1WEpHMG5mWUVMbmZnYlgzbTZK?=
 =?utf-8?B?emJUQnZsdVNTSHJkV21IL3I4RWVKZW1FUkxqZnVVQ05NL2NYbjlKZW9jeTNG?=
 =?utf-8?B?czFvL2t4QUo4Vk5YelNaeFgwMzZjb2E5UGpwVi9xK0ZuVGpIbnRPTnFFNWkx?=
 =?utf-8?B?OVl5RVF3c0NBN1Z0dVowSEIwNG9kM0dIdjFHaFFyUHkwWnIwMEczT2tmQWEy?=
 =?utf-8?B?SGM3YjlyRkg2UnZ3YS9JM0phM3RJeGpONnlYQmRFUlduRjNpMmxnaHFTV0NK?=
 =?utf-8?B?WStYanJSZVBUaERFdm5ZVTdYelJHRXEyeU5pTnRkdDliRElaL3FVUmNZTERE?=
 =?utf-8?B?ajFvVjZjUFlCa2pCSVJrSWZWZ1hyV1pUbEJ3bmwvcUROS2xab0o1M2xhYTlE?=
 =?utf-8?B?MnhRVmhEVElibmM5THNwNFhWalNrZGppYU9wY1hUS3cxaUtRVWxDU3dFWVVz?=
 =?utf-8?B?UUJNRDFXUU5NVW93eUtFbzlZYXZlTzBaQkZPVE9SdXZlNmVBVTBrUUZXMXhv?=
 =?utf-8?B?OFliNjVPRUFmeUZHb1liZ2ZYdkRDcnZKUmpOQUpQUURlWFduNjZxR2RHeDVV?=
 =?utf-8?B?MXYrVGcybTl6REUySnllRWRxemY2K1BHbXJHbVY3ZmdXM2ExZ0dSV0NGb1Vx?=
 =?utf-8?B?SFlCSUZWZ29XN0VTd2JQem1QUHhPdGw1M3RleFFqa2wxNDF0eUJNSGZiRERW?=
 =?utf-8?B?WXhONkFGWHM0NnJ0aEtBcWdUd2szbldQTEY1K0JaVzI0K1R4REtTeGhuZ3hW?=
 =?utf-8?B?ZTdrbHUxd2Rhb1hNbWVGWUNQM0V6SUhiTGhkSFE2WHNobnZxV3FrakxLdEtM?=
 =?utf-8?B?ZzZkNldJaTlTTjVIVFRwNWxNYVZVUlF2SEcvZG9vYjBnUUxKTkwwSG9yaThI?=
 =?utf-8?B?RTEyRmtEekFMOHpGR2ptY0Q1Y1g0OHAxdmNYZUxrc0t6SUx0WXBLT28yVWZk?=
 =?utf-8?B?d3lLc1psMk4vdzJETFFBWnB4TjhPeVZscjdMK1JZWDQ1NXVuK09BUWxyUXc5?=
 =?utf-8?B?elM2UHoydHRqSkVTMzYyODNraHpPOTN3Si9kUWdNQW5BdGJjZkNxVkpmWmR6?=
 =?utf-8?B?dXlKWHFUSkNvQU5wQW01a2d2RFlBdWpsTkt6dVVCS1paN2tJb3VyMXY2cW40?=
 =?utf-8?B?ZjNYajFrV3VtK2cvTEdjUWJJZDZyR3MwOUJDbG9VRWptUWJIaGwxakk3Wk5C?=
 =?utf-8?Q?5Q8+Pdtz2ei7m+eor7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b22350b-102c-471a-3cb1-08df49751a6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 15:19:01.2608 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bjqakP6wOuJek/CczJ2lWyBLGWJQbMQnbX9xipVP9GDn77p1aProb4uAPSf69zZ2ofi06ywSgQUcEKQ7OPSceQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8603
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

QU1EIEdlbmVyYWwNCg0KUmV2aWV3ZWQtYnk6IEtlbnQgUnVzc2VsbCA8a2VudC5ydXNzZWxsQGFt
ZC5jb20+DQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGFtZC1n
ZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBQ
aWVycmUtDQo+IEVyaWMgUGVsbG91eC1QcmF5ZXINCj4gU2VudDogTm92ZW1iZXIgMjMsIDIwMjYg
OToyNCBBTQ0KPiBUbzogUGVsbG91eC1QcmF5ZXIsIFBpZXJyZS1FcmljIDxQaWVycmUtZXJpYy5Q
ZWxsb3V4LXByYXllckBhbWQuY29tPjsgS3VlaGxpbmcsDQo+IEZlbGl4IDxGZWxpeC5LdWVobGlu
Z0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQu
Y29tPjsgS29lbmlnLCBDaHJpc3RpYW4NCj4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IERh
dmlkIEFpcmxpZSA8YWlybGllZEBnbWFpbC5jb20+OyBTaW1vbmEgVmV0dGVyDQo+IDxzaW1vbmFA
ZmZ3bGwuY2g+DQo+IENjOiBTYXNoaWtvLWJvdCA8c2FzaGlrby1ib3RAa2VybmVsLm9yZz47IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBkcmktDQo+IGRldmVsQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHY0IDEvNl0gZHJtL2FtZGtmZDogYXZvaWQgTlVMTCBrZmRfcHJvY2Vzc19kZXZpY2UgaW4N
Cj4ga2ZkX3Byb2ZpbGVyX3BtYw0KPg0KPiBwaW5nID8NCj4NCj4gTGUgMDkvMTEvMjAyNiDDoCAx
ODoxMywgUGllcnJlLUVyaWMgUGVsbG91eC1QcmF5ZXIgYSDDqWNyaXQgOg0KPiA+IEFsbCBvdGhl
ciBjYWxsZXJzIG9mIGtmZF9wcm9jZXNzX2RldmljZV9kYXRhX2J5X2lkIGRlYWwgd2l0aA0KPiA+
IGEgcG9zc2libGUgTlVMTCByZXR1cm4gdmFsdWUgZXhjZXB0IGtmZF9wcm9maWxlcl9wbWMuDQo+
ID4NCj4gPiBDaGVjayBpdCBhZnRlciB0aGUgbXV0ZXggdW5sb2NrIGFuZCByZXR1cm4gLUVJTlZB
TCBhcyBvdGhlcnMNCj4gPiBwbGFjZSBkby4NCj4gPg0KPiA+IFJlcG9ydGVkLWJ5OiBTYXNoaWtv
LWJvdCA8c2FzaGlrby1ib3RAa2VybmVsLm9yZz4NCj4gPiBDbG9zZXM6IGh0dHBzOi8vc2FzaGlr
by5kZXYvIy9wYXRjaHNldC8yMDI2MTAyOTE1MjAwMC4yMjAwMS0xLXBpZXJyZS0NCj4gZXJpYy5w
ZWxsb3V4LXByYXllckBhbWQuY29tP3BhcnQ9NA0KPiA+IFNpZ25lZC1vZmYtYnk6IFBpZXJyZS1F
cmljIFBlbGxvdXgtUHJheWVyIDxwaWVycmUtZXJpYy5wZWxsb3V4LQ0KPiBwcmF5ZXJAYW1kLmNv
bT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2
LmMgfCA0ICsrKy0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfY2hhcmRldi5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NoYXJk
ZXYuYw0KPiA+IGluZGV4IDZjNzEwZTRhNTIyMC4uYWQwODYyNDBhNmRkIDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMNCj4gPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jDQo+ID4gQEAgLTM0NjMsOCAr
MzQ2MywxMCBAQCBzdGF0aWMgaW5saW5lIGludCBrZmRfcHJvZmlsZXJfcG1jKHN0cnVjdCBrZmRf
cHJvY2Vzcw0KPiAqcCwNCj4gPiAgICAgLyogRW5hYmxlL2Rpc2FibGUgcGVyZmNvdW50IGlmIHJl
cXVlc3RlZCAqLw0KPiA+ICAgICBtdXRleF9sb2NrKCZwLT5tdXRleCk7DQo+ID4gICAgIHBkZCA9
IGtmZF9wcm9jZXNzX2RldmljZV9kYXRhX2J5X2lkKHAsIGFyZ3MtPmdwdV9pZCk7DQo+ID4gLSAg
IGRxbSA9IHBkZC0+ZGV2LT5kcW07DQo+ID4gICAgIG11dGV4X3VubG9jaygmcC0+bXV0ZXgpOw0K
PiA+ICsgICBpZiAoIXBkZCkNCj4gPiArICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiAr
ICAgZHFtID0gcGRkLT5kZXYtPmRxbTsNCj4gPg0KPiA+ICAgICBkcW0tPm9wcy5zZXRfcGVyZmNv
dW50KGRxbSwgYXJncy0+cGVyZmNvdW50X2VuYWJsZSk7DQo+ID4gICAgIHJldHVybiBzdGF0dXM7
DQoNCg==
