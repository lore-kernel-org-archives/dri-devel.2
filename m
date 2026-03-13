Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 030FE105F78A
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 10:04:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B3B410E090;
	Fri, 13 Mar 2026 10:04:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="RUJTaDsl";
	dkim-atps=neutral
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazon11011058.outbound.protection.outlook.com [52.101.125.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D313110E090
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 10:04:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O04EuQZ+MYfHRbsu8sNFAXDA7mj7TX8qk09PcIfAGaVLH5dv5hCVBnDAyFxyPh64kqDi9dBzNkHuYKYB1PjzCEIyssgP3EwxCY/+07mI3WxHuOpS6pnjZBHcDJLlwNN8tIC+CxkRxhFnICDhahd9jbYmqJHBs+Q5iJ2kGOn7dqIJVmiuUhW1FEWnrsQPw7vrzU4t9cch2bW0roNqF3etV49n0eB4QsAfjajOhP5y1kmDp4wmSbiM98b8FscTrsTrzQSqzCFBEitvhM0joJ4mKxzG5QGgaxWQUsxfElYGBOpdS59nd2YW8dtFntdCuOZS5AVcCfI7erS+QqiePysTug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQ47Mj8+wDth3eljZXCLRVDUqvenDKWzU13EA2Si39w=;
 b=ITcYhJWQBFTd/qKYDKLJZXBFB6/xiPrWIHoqo6KJ0b8dKD0yMDQzyiaJA6IM2Vq37+JyrqsdhvKeAUFH4CqNkmvl1dS/XGTyyKN94qm0LeDhxivFfX8WyBmx3/LJ9kcw6nEYrmLTvvJAcNtKXV453sbOS56166IBsGzMBibvNfd4+Kf8rBBRaFhKTZUJUPaaPYD4h3SX6mC47pi3iT5vhwLVonGOpsggO2J33Wr9bf6BFolIdxWhi3yPbvKpzw5DZn3RjI2SVvotSs1fYnSAPqn4w7N2zHriZttIpwAcydkwm/yAJMvqS8TC5olCJKwGhOtdoGoCqVUVmEO/cKZ0Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQ47Mj8+wDth3eljZXCLRVDUqvenDKWzU13EA2Si39w=;
 b=RUJTaDsl6ZSiVNSUfeOxZf7wYQS66DBGCz6x0ZLhtf7brYkORlzpnc5+zkS8/iTEM2sj0gpEFL0z/3G7JTHZcW+g2xM2qB+9n3AQesDH4EhFla18GxxSyBmYoGwOB3L5t4eiGT1SugSk8lAajpgE+z6lNFi/sY+w1lxo+Pd1ExA=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY3PR01MB9747.jpnprd01.prod.outlook.com (2603:1096:400:22c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.16; Fri, 13 Mar
 2026 10:03:56 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9700.015; Fri, 13 Mar 2026
 10:03:53 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, Tommaso Merciai
 <tommaso.merciai.xr@bp.renesas.com>
CC: "boris.brezillon@collabora.com" <boris.brezillon@collabora.com>,
 "loic.molinari@collabora.com" <loic.molinari@collabora.com>,
 "willy@infradead.org" <willy@infradead.org>, "frank.binns@imgtec.com"
 <frank.binns@imgtec.com>, "matt.coster@imgtec.com" <matt.coster@imgtec.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>, "airlied@gmail.com"
 <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>
Subject: RE: [PATCH v4 5/6] drm/gem-shmem: Track folio accessed/dirty status
 in mmap
Thread-Topic: [PATCH v4 5/6] drm/gem-shmem: Track folio accessed/dirty status
 in mmap
Thread-Index: AQHcp96eSUoAacjqcU2c+U96UWFVr7WrPdqAgAAB0YCAANfgAIAAF6oAgAAh3dA=
Date: Fri, 13 Mar 2026 10:03:53 +0000
Message-ID: <TY3PR01MB11346D3DCB34CEF0C71086DD48645A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260227114509.165572-1-tzimmermann@suse.de>
 <20260227114509.165572-6-tzimmermann@suse.de> <abL5rcYIaFFO3GW2@tom-desktop>
 <TY3PR01MB113460CA616D3576DA0C3FC698644A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB113461ACB668738E1952EC8898645A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <20a82a3c-80ed-4f9a-912b-088284c27b68@suse.de>
In-Reply-To: <20a82a3c-80ed-4f9a-912b-088284c27b68@suse.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY3PR01MB9747:EE_
x-ms-office365-filtering-correlation-id: 55c043b3-5262-4d1a-0d9d-08de80e7d55c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: A7QAOi5OKDTGcteAKp5jVbzRHCVdHjmOAcoW3/HV8hdSDLMp5z3EilVpmVQ6lwpyEDCt+4+L2JlnCxN5g+nnZaCHWhpFDFSAale1EZ4Ipx76OGPA5WS+2rkOENdO4rjQ2S82/XqEmqjFl+rcZu+7aXFQKBix+Quta6bEcdsqTurcvwD8r/HGPZf6spEsLRrd+BTq6T7yeZIWznuKQm9GHRCml+UJCCv8KSEU2txGwgJwN8OTQh21X22PF8TBvLI6+H7snX61rGpcTCdT0lxDZZ/Ifxf3HDtyUCF11uPfNmx/Qg2f/K/LhGSUa+Z7Y689tKWhOZlzXaoulbmLsIagVq6qpZhOAR9pqhcufJvm241/8mAdEUBvdnj8VircYAvVBowxTvoD1lwMH/WcS4i7xvR03ou5H3OkqbpuR0fsTbo7MVyU2Y4qtrVyf4dEVwnNnwg6G7eJz9iPdc5UUxwUqI6H6F1Y4ulXRx1oaIsBSbKL3crWyl1t6sWe8qw2GaN/1IFVoOcQcFSVldq4RSzD/OV7K4cK3KIL4ip1ngTiuzn7qKlNgos+T0JLeDq2V/HaWb6s5Gd4wTMB831Wfz21LeDXDqJPorAgOIy2cMW4Q+dSW9pnSw9xpSbPFPARcpd2fzi40ZQE7uKtxd0Cpsis+K31EzcPnOTBrnHKk+cXfc6IOHhK0fsIMBWqOG5BZZmSWofj/qe0G+VRowl0GLNobNxiTXFzPNA90GVoVJdqwT01k0k2lC6Mp4y8fDM97iEsAIyovv9mOStWwKUf42836zOEZVL3vtmnKzZF/Aqv8ow=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eW81dmhEQWx4WkFwRDlLWHJHZjRUcHBvWll2Q2sxbmVIY1FpQWZ1VDZyUnIy?=
 =?utf-8?B?VXB6R21FUzNYSWZ4WDdWV3gxeVdOU1pSZWdWN1k4RGJjZ2tYTDBhUnZhSUVI?=
 =?utf-8?B?VTFoTVFQMnBSQm40K1RUYmwwd1hhU2ZFTm5HZmJvODdIbVNhSER5aWZsZ05q?=
 =?utf-8?B?NkNWNHAzQy96eDhmNXhiNnFvV2xVYk1zbHl1elAzZ1kwYjdEMmtvRGppL2J3?=
 =?utf-8?B?WnpuT0NNRlRmWDhSYUxiYUcyL2pwaEU2cmVhT0NSTFZkMFFqWDNtNlU0cXUr?=
 =?utf-8?B?RlE5eWhjcE14OW1NWkpNK09uZzE0azFLVkcrN09hdzNKWmU3TncwMC9McWZO?=
 =?utf-8?B?WkNPdC9kazIzT29lOTdwKytzaDJ1RUdiMXNqcndwZHg3UXIzRzVyNFQ2WWd5?=
 =?utf-8?B?UnVyaG9QMUJzRm5tSmRvODlKSnQ2YnNDaEJjVnUxT013MDY5aVRVYWt0Mmgz?=
 =?utf-8?B?WnA2M0VMczJDNlNkb0lFUjRyVFBDNFJmc09NY3NkZXl6RTNxRk10WHNoMDcz?=
 =?utf-8?B?SHBxRmR2NzZDMktkTmgvQTRKMUtlK3lEVEcwZHBWNi9wU3lCVUFMY2dZTlBr?=
 =?utf-8?B?WUZ0TVBJR1cyaXZDZkJTMmFtMWlQK0VMcWtORWR0TzdzR2pmUTZhVVU5dzNE?=
 =?utf-8?B?M0R1d0kvUitxMnF1OW1JYnAwVjFUR1hQdXBsOVVzOVp0aFM1RTZzMy9ONzVM?=
 =?utf-8?B?TC92WThRV05uWFJxekMvTi9SVVVqcDY5RlkxK0FCcWk3eW9wQTV6QXFrVWtV?=
 =?utf-8?B?L3ZBeXVkd29oTnQvb1JBUTNTUmk0dkhNK1NMWlFIUC9hK0Jqb3hrMkVNT0Vu?=
 =?utf-8?B?U2RZblBtcHg3cjhxSGdWSFFOaWYwSnZzdmhLSElxTkpaRjYrYmQrb2NTZlk1?=
 =?utf-8?B?eXpZVTZRTHdvQkRsRmNoaS8rZmRxQ0tPcUJYYVNzejZOS3hPU2pYbkVBNGUy?=
 =?utf-8?B?dGdHZWRjR2xKMC9VSEM2UXM3OVlkVWNZS0cwdEJ2cUx6Sng1MzBwdHVCWHdz?=
 =?utf-8?B?Q0hnZzZWcUE0UCtYMzBTbUdua0djbW4yb0FEVTRQY1hwOTNWK24xSmRNRG5p?=
 =?utf-8?B?WnRpV3ozbHovNkhWUy81N1B6aUgyeVhRbWYzVmVrdTh4MkRkQ24wMCtDeHZF?=
 =?utf-8?B?bE5GTVBoVy9lNE91VUhoek1RUU1ROUpsaWRoajQ3emNuSUpGZkZrNnlwU0Vk?=
 =?utf-8?B?ZjBqZElLLzVyVXNBVDZJb3hYclB3c1R3Tlg3ekFGMEoyRlFQOHEvaDlIWVpq?=
 =?utf-8?B?emhvUDVRWkt0d1hiOWovZlRJQjM1NmJNa2lrb2pYZ3owdTNabkFSd0tsSlhi?=
 =?utf-8?B?QkNuQ2NNWHZ5cWNqQnpzMmV6MWhsVXpsMUk3MzBTY0oweW0xWk1OSGRZTy9x?=
 =?utf-8?B?aG5CTlNTVkVuNzc2Vkk0OEpZL3N0K3NJK0FUamhBYTYzMG04TTBiTy9hTzZw?=
 =?utf-8?B?K2RYUmFsRjRQQkJKNjJvU0h1RkpSd2poSUlCbGpSSXZ3OW9Xa29hdm1ORTFh?=
 =?utf-8?B?ZHNmdlVQbWFnNjNsbE4vMytvRnJ1LzNTazJ0WE5lMjRWaG5NTm1QYVlqUjQ1?=
 =?utf-8?B?YXk2SUJyYnFVR2hTNmdXb05mNDZOSFlNV1VZeWhoa1U5Y3RhN1orbDd4Q0J0?=
 =?utf-8?B?OVZydllrdS81bFhtODh4aHEvcmROZ2RGRHhFdlFjYkk5cS9iL216c21GWFN4?=
 =?utf-8?B?b29OU2lxcFp0ZUxwNXpMVjBVTVZ1VEMydEQ4Nk9jLzJMa0hCbVcranlTZjE1?=
 =?utf-8?B?V01uV0tGSHdHUE9lcmRwNW02N1c4YTdzTkR0cXF5TzJKOStLR3pvVG95aDFJ?=
 =?utf-8?B?VFVrWXpTZXNLUUR0QXpPUGZsbUwwMC8vSlU3Yy9PTnlHdDFweGRYdTUxRk1W?=
 =?utf-8?B?WVJXb2M5Y3hRTWd2WTMzVllXVG5Vc09naGNkay9QTkJSSFpETU9QZ3hJMlRO?=
 =?utf-8?B?c2tvUWtPSUgrR0xJeEVBc1F4YTRVVllOQ3VqLy9rS01xT0JzL0Jaa3ZYYmov?=
 =?utf-8?B?RXJzbE1wSklPelFVOWl5SXJHaW1TR1pzcldVcVBZclVVa05Nc1lJWWhQU2F1?=
 =?utf-8?B?a0VvbG1IWjR3dHRRanVHNDNsV000WXFGU25sakZhRFRrclFseFpSbjFBWmNP?=
 =?utf-8?B?RS9qZGtzWGpiYTEybXpLNXk2TTFCdUhUZ2tBUDV0MWdtenJDVnRxeXUzKzNU?=
 =?utf-8?B?eFpOVjlwZ3JMc3I2SCtVd3hEZ2dXZnRCSmJlRWNHYVkxcTBsc2FnbHJmN3FX?=
 =?utf-8?B?NDZsUG1rNXBqc0FPWDdrM3owSzNYODh4TjRjb2FON3V6dGdkcXlTN2ljQ0lP?=
 =?utf-8?B?RmVReWJnM2ErL2g3akc0MG9GUWFyclJxUTVPYUNzTVU3SW9lUmlRUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c043b3-5262-4d1a-0d9d-08de80e7d55c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 10:03:53.8268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tFjDUHEo4T1ox44AuV0cZCO6txP3JtDpLjC+W2l76tsgN1Yw8SJDS5sukw6p1rYph+Md4Sv/zevgM5Fuv05EKjlE9L5SvR+JrSy6Ug0KPJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9747
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

SGkgVGhvbWFzLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFRob21h
cyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPg0KPiBTZW50OiAxMyBNYXJjaCAyMDI2
IDA4OjAxDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgNS82XSBkcm0vZ2VtLXNobWVtOiBUcmFj
ayBmb2xpbyBhY2Nlc3NlZC9kaXJ0eSBzdGF0dXMgaW4gbW1hcA0KPiANCj4gPiAgIGNvbnN0IHN0
cnVjdCB2bV9vcGVyYXRpb25zX3N0cnVjdCBkcm1fZ2VtX3NobWVtX3ZtX29wcyA9IHsNCj4gPiAg
IAkuZmF1bHQgPSBkcm1fZ2VtX3NobWVtX2ZhdWx0LA0KPiA+ICAgCS5vcGVuID0gZHJtX2dlbV9z
aG1lbV92bV9vcGVuLA0KPiA+ICAgCS5jbG9zZSA9IGRybV9nZW1fc2htZW1fdm1fY2xvc2UsDQo+
ID4gKwkucGZuX21rd3JpdGUgPSBkcm1fZ2VtX3NobWVtX3Bmbl9ta3dyaXRlLA0KDQpDb21tZW50
aW5nIHRoaXMgbWFrZXMgd2VzdG9uIHRvIHdvcmsuIEttc2N1YmUgd29ya3Mgd2l0aG91dCB0aGlz
IGNoYW5nZS4NCg0KQ2hlZXJzLA0KQmlqdQ0K
