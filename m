Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C09106FD9A
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 08:47:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86E3810E032;
	Fri, 13 Mar 2026 08:47:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="LCzLg49u";
	dkim-atps=neutral
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazon11011011.outbound.protection.outlook.com [40.107.74.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20A9F10E032
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 08:47:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S/LVoZXsDHrR6cF9JUNE0t9Peh5vVyKXbSWZuwSMTzixk/6uz/Fg4jk3X+cT2iCJYKjQJFCNQOONe9nO1wgxAeG8apn7K/W9sC0inSijiUCJFhclqAPecMnRUr/U7CKMNDaWKYlEXG1q0Yi9FayLwZiNgz6ZeamnvnlV14Pdu8dDR/UlkKz+SJJJyCkHwXGSWCMeVXWZktyWsZTuCHrdPfzRhipo0RWFOsN4Z/+Xr1jbzqfzrUxqERpV3Q80wOT/8wMCti1jUaGIoee0rg7OsvhSsGuW+EnlR5Hx3Kb4SGsN9y4FKMLIq5McnKUNV2RSG15037ezwbXeyyyxht6JtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHtXRgAXSt5HcEnLoie2IZVYTRC/j2ouD3f+GYdZakE=;
 b=ODocDlHwNNeb+Q3UrKraTwGmH5VOzRnk/Qq3OKVSKas1jjGmogBs0ZH8y+mmT1NRD5MQwMN7dNxxBa12qAfFx7oxNqGCdlwupde0VaJ2pVVECdrToLWCzuvTOPkZyOdz386nwcr06zbWS3P80/l5dtqaBBAjvkKuSsPEQIytzf+XyH3wQ2r0yaKCwWCyoYSG/MSIeZ493LSGnmc50JWm+Qu5qECvcp65bKcRc1JgwTkVBvufRtN2EEPVY99VjblJzg8X2mX2b33dbevqashDjYmMIa04TYnaEooegnThXYfFS+kn078siQcP+hqLXl6VZlPpo1M2lN7EXwGclKAebw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHtXRgAXSt5HcEnLoie2IZVYTRC/j2ouD3f+GYdZakE=;
 b=LCzLg49u2z+3SjXaeHYd5OwCXlsowaM2akpbjsDHRSC3phXJ7ebfqz0+/ngflYe3Dfi4uDkcRuFKdMvWwnMzALVGmRuUeJb0nlx6fD8zgeD/YwguC0iY3VYeHYIlNs+flrR3wMJmQIDHUlMp8dIoyOqNXLeyTLhhdIe+qa3SMnU=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYRPR01MB13071.jpnprd01.prod.outlook.com (2603:1096:405:1ce::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Fri, 13 Mar
 2026 08:47:04 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9700.015; Fri, 13 Mar 2026
 08:47:17 +0000
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
Thread-Index: AQHcp96eSUoAacjqcU2c+U96UWFVr7WrPdqAgAAB0YCAAPjHAIAAA3bg
Date: Fri, 13 Mar 2026 08:47:17 +0000
Message-ID: <TY3PR01MB11346BC4CA799C6435959FE0B8645A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260227114509.165572-1-tzimmermann@suse.de>
 <20260227114509.165572-6-tzimmermann@suse.de> <abL5rcYIaFFO3GW2@tom-desktop>
 <TY3PR01MB113460CA616D3576DA0C3FC698644A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <d3818663-2673-4de4-b483-557602f6e8b9@suse.de>
In-Reply-To: <d3818663-2673-4de4-b483-557602f6e8b9@suse.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYRPR01MB13071:EE_
x-ms-office365-filtering-correlation-id: 5d2c2056-b67c-4238-489e-08de80dd21d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|1800799024|366016|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: US3rYuHrwut+uRH9xjbR/ay0OyMTk31XOqMtoo7gzlGb3unsxcH89vz2SfdHALsCVEVZwgImjFBfenTuwhMceHGbJCnIx6/siDRbBrNqwpUyYbniviaBx8Zm6w/aaGMpjfmjt5FV7xC6jE5btUGBuaxGUF2FOE8qJPMkzr6LpHGVcIjUfwAgT8uU6NVliCrmj4YTQ67LjQkFfmprIwM+mM12005gZRDdqmi6kl1M7jz5X79PVG9v2AQTKTtBA4YLdRc3sJ+/dh7f8Cagl9s4wris/l2BLHCY7VqH8O6RoX5QyYv3p7bMxbiiR4cyoBfZoDpOr+aHGEa+2axvQQmdRlgk4e7lol2Nqo2N2Dm6Wk/4NkZvqEBq4hLtvFT9HcugV6CDF1n1/1A1PilEpat+0lHE/8pFvNRCXot9qqS/gh9fxItWv83hI3MyT+KNbendcwAtPs6HjgVuB94YybL5FxsaVS/478Y6oBQpOHHfpUfCRLaZN3BRW8k3fG9q9F+2qReOxYPh7BADVSDgLYgj7UBedbzngzlAEvGyaNIJ7D4xI6ZZ1swa7Rt6XduDxXuDACLX8n9dCnqSs17RqqNfdi/v7MUkAhEDBPK3hUxgKH0vys1/SVc2LX14mXand4eF8XTRv0tdOv25YLQp9gkt5zO4IwECO7KJvAvStGOhkwA5HXZ2c0Cnelge1pYQE7QOkH6ly4LApp5EsWvN3KrXPxUwOeV9pa6BlhbdZdWwADo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2FZUGJqaG51YVYyR29DNW4yWlhYZHNTTmdya3hmbXlBbldyZ09VRjJJaUhv?=
 =?utf-8?B?NnFYcStrTTV0VWZ3ejZ6R1ZseWtseU5xejRTU1AwT3ozN0F0ZnNoK3VhNXcy?=
 =?utf-8?B?RkpVekVmL3lBR05XUlZPclZBM29zaElxVENKK25wZVNIdis0NC9lb2hXVXNS?=
 =?utf-8?B?ZUgxN3JtYTFjVXFLZ3BISUJwOWUyK3ZPTjdGSk9kbFZOWmRIajNjMjl2YTRj?=
 =?utf-8?B?czdUWFZoVmpQUURBNy8xS0NRR3JYZUtCT2hKQm9BdGZlK21KQzlDNElWRDl3?=
 =?utf-8?B?ZVZYMm1xbEtxNDVLZ21HOUUrVEVwbVN0U0NoTE95R1pzeC9LVUcxOG0vSHhw?=
 =?utf-8?B?RlhRU25Ea25DbHh6NVNSS3RaTzlkSnI3UDFXOFl6di84UjlkaE1zbXV3Ukk1?=
 =?utf-8?B?c3JMRW5GOGVZUndBaUZIZ2tqRVE2b0xJOWN6VWJwTE9pR3FpRkd3eXVEdm9D?=
 =?utf-8?B?SkxKazR1cHZnb3BYZUNvWmFMUVdNYm1aTDhFWm4vTkZxNHNEUGo5aXJNNWpL?=
 =?utf-8?B?ZFRCZDM0bUZKWDJkeFFxWmRramFsRDBKTmN4dUdhRUpIVStLOE5oMDM2Qzda?=
 =?utf-8?B?V0NsUWJOMXJZWjZySEh3VWZqT3EydmVrNDlwQlQyWmFNWkVWUFdGWmxLUy9l?=
 =?utf-8?B?dmNiMVdQR0tNMk03bVE4WFg2QVZJMTBSbks5SVcwT1FLdEdhN3RGb0RoYXNZ?=
 =?utf-8?B?S2pZVnBDSVRSL3d0QkxwMWVBL3JGMnVjdzRKT1VBaEZ3cFVHdzgzbE0xU0Js?=
 =?utf-8?B?M3lOVDNnZmNidGM2VVNRSjFMazE3c2NWV3R2blJzUTNTaGFyb3dmcm96eENC?=
 =?utf-8?B?U3NqRmhWaDJDUGJWa1BCMkZDOVAzZ3BPamZyMnF3cW8xOHJLMXg2VFNzVzlw?=
 =?utf-8?B?eUpnbXpTeC8xRmVzc3JVVEtKak5McmlPTm5tbzJVNFF0Sy9vUDFCaWtoVzA0?=
 =?utf-8?B?ZXBiRDJqd24vV0ZNZnZoZ3pmaDM2eCtxV0pEMG54aHRRNmN1QkZ5RGRFemM3?=
 =?utf-8?B?Rjk3RWhPdWRnSnZVWTlvTi9QZUVuU05pVElFZDhNbFV6emtUWi92S0hTdDZ0?=
 =?utf-8?B?M3JEVGpqQUtYeWRFZkdkYWxLWjMyaTRjN3lqVUJyZ2pDeEdQV3ZwMjMrbkRh?=
 =?utf-8?B?ak5BOW5YZWlobjdlQVF6bHYvaDJTMVFlbS9QeHQyRUYwTHMvZHlWdjhwWVVC?=
 =?utf-8?B?M203WmtoV3hpOTFIditXYnYrODBQKzJPYitpRStBazd2VmdsZyswdUhBS3VC?=
 =?utf-8?B?MlBpTWtUa2E2VWlMSXZoWHFram1JYXFjWXVwc0xJVzVjcjVEUnFDTE5GaDhG?=
 =?utf-8?B?YnVQMlB5T2pCT2tGcWtCS0V5a1ByVnRhVkpnbExkZEpUVmYwa1hxbm1SMjZp?=
 =?utf-8?B?ZmxPd0JnUWliaWtKVE5HTW5FYjhETkRSSkM0b1lXTFVxNU9qdkRuUXowcWMx?=
 =?utf-8?B?bzVoK0pzcHFrZDBRNEowdG5Qd0w0dkhDY05uT2w5dmdnUWR0UWpLRFJXazd2?=
 =?utf-8?B?OU5QY1Y4WDdqKzRxMEY3amI5Nmxxalo3TmNsM3h0N2R2QTNRUWVNNkI5bHlm?=
 =?utf-8?B?R0NtWWFldW10eHhqczdEQjh5amdFUWd4d3ZueFZNUjVZRURNVDVNem9EL0R4?=
 =?utf-8?B?SlZVaUZ6ZW1qZmdGVDNmTGplTER1WFdoUnkzWlcvNDZlNTNGT3k4QjFaS3kr?=
 =?utf-8?B?Vm9oTE1lSFdubndvMldEUEowd1Nid1UxR1hsRVM5L25nU0Y2ZUwxTUJhQlJQ?=
 =?utf-8?B?ZEx6M2ZXbVpNSjl1ckw0L3BiUUVpOGt2cHFWVHhDcFpyU0gxVkVMNkhPVXJQ?=
 =?utf-8?B?VzhUZ2xOZjRhWVB0NW01aUloWlFZKy9QVlJNSlJzM0N5MTAreG1aTy8rU1RP?=
 =?utf-8?B?ajgvQzlHbmJzVEZweFlqcmZ1QmZLMXVEUFYrd1BPbVFsTVE4TDI3dzd4K3hC?=
 =?utf-8?B?cU1DL1Y1bjRFVFBHU3B3ODdiNXJsNUMweTNiUWRGLzArdW52WkxIdTNpRWJP?=
 =?utf-8?B?a2JRQXFlVjFzNENDMTVpeDhpTWtzYmlhRVZJR1oyMGtNWElpMXhvdTU0Zito?=
 =?utf-8?B?cGJaZVgwWnZjaXBSVEdlNkhhVTRMbENrRmUwaDZZMkVUTk9XWDVzYWVSRU5w?=
 =?utf-8?B?MmJzZW81QlduMTZ2QWxvRXhWNzRpSTFKTVhIVlZJV1M4ZWN6V2xZVzI5cFg4?=
 =?utf-8?B?aWxrTmIxcEo1TlNsbWYrZG5ibXZEcGlnUGZ5OHQzLzFEK2xoQmlhbkx0Wm54?=
 =?utf-8?B?ZHV3U25tbU16bkYwNGJpNTRpeHZvbkFYMlRlYkUyVEIySk85elJuNlFxamhR?=
 =?utf-8?B?d2dpY0o2b1JLc2loWGtFa25kMTNpVU9yY3BkMWNnaDZoVE9EMzlFUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2c2056-b67c-4238-489e-08de80dd21d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 08:47:17.6056 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ucx1L3m/ZGRzeo7MWTAUTZ8e49wjuSvpv0OgnnrnuKBkZTpK4sZ1hTYtIAJsbNf1LrlWJckG99BsV+lhnT34uAsnf3Ld5gg27lUMuujG1Tc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13071
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

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFRob21hcyBaaW1tZXJtYW5u
IDx0emltbWVybWFubkBzdXNlLmRlPg0KPiBTZW50OiAxMyBNYXJjaCAyMDI2IDA4OjM0DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjQgNS82XSBkcm0vZ2VtLXNobWVtOiBUcmFjayBmb2xpbyBhY2Nl
c3NlZC9kaXJ0eSBzdGF0dXMgaW4gbW1hcA0KPiANCj4gSGkNCj4gDQo+IEFtIDEyLjAzLjI2IHVt
IDE4OjQ2IHNjaHJpZWIgQmlqdSBEYXM6DQo+ID4gSGkgVG9tbWFzbywNCj4gPg0KPiA+PiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBUb21tYXNvIE1lcmNpYWkgPHRvbW1h
c28ubWVyY2lhaS54ckBicC5yZW5lc2FzLmNvbT4NCj4gPj4gU2VudDogMTIgTWFyY2ggMjAyNiAx
NzozNw0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDUvNl0gZHJtL2dlbS1zaG1lbTogVHJh
Y2sgZm9saW8gYWNjZXNzZWQvZGlydHkNCj4gPj4gc3RhdHVzIGluIG1tYXANCj4gPj4NCj4gPj4g
SGkgVGhvbWFzLA0KPiA+PiBUaGFua3MgZm9yIHlvdXIgcGF0Y2guDQo+ID4+DQo+ID4+IEknbSB3
b3JraW5nIG9uIERTSSBzdXBwb3J0IGZvciBSWi9HM0UgZnJvbSB0aGlzIG1vcm5pbmcgcmViYXNp
bmcgb24NCj4gPj4gdG9wIG9mIG5leHQtMjAyNjAzMTEgSSdtIHNlZWluZyB0aGF0IHdlc3RvbiBo
YW5nIG9uIG15IHNpZGU6DQo+ID4+DQo+ID4+IFJldmVydGluZyB0aGlzIHBhdGNoIGZpeCB0aGUg
aXNzdWUuDQo+ID4+IChnaXQgcmV2ZXJ0IDI4ZTM5MTgxNzlhYSkNCj4gDQo+IEp1c3QgYSBndWVz
cywgYnV0IG1heWJlIHZtX2ZpbGUgaXMgTlVMTC4gVGhlIGF0dGFjaGVkIHBhdGNoIHNob3VsZCBo
YW5kbGUgdGhpcy4gQ291bGQgZWl0aGVyIG9mIHlvdQ0KPiBwbGVhc2UgdGVzdD8NCg0KTm8gTHVj
ay4gSSB3aWxsIHRyeSB0byBlbmFibGUgc29tZSBwcmludCBpbiBwYW5mcm9zdCBkcml2ZXIuDQoN
Cm9vdEBzbWFyYy1yenYybDp+IyBzeXN0ZW1jdGwgc3RhdHVzIHdlc3Rvbg0KKiB3ZXN0b24uc2Vy
dmljZSAtIFdlc3RvbiwgYSBXYXlsYW5kIGNvbXBvc2l0b3IsIGFzIGEgc3lzdGVtIHNlcnZpY2UN
CiAgICAgTG9hZGVkOiBsb2FkZWQgKC91c3IvbGliL3N5c3RlbWQvc3lzdGVtL3dlc3Rvbi5zZXJ2
aWNlOyBlbmFibGVkOyBwcmVzZXQ6IGVuYWJsZWQpDQogICAgIEFjdGl2ZTogYWN0aXZlIChydW5u
aW5nKSBzaW5jZSBTYXQgMjAwMC0wMS0wMSAwMDowMDowNiBVVEM7IDU2cyBhZ28NClRyaWdnZXJl
ZEJ5OiAqIHdlc3Rvbi5zb2NrZXQNCiAgICAgICBEb2NzOiBtYW46d2VzdG9uKDEpDQogICAgICAg
ICAgICAgbWFuOndlc3Rvbi5pbmkoNSkNCiAgICAgICAgICAgICBodHRwOi8vd2F5bGFuZC5mcmVl
ZGVza3RvcC5vcmcvDQogICBNYWluIFBJRDogMjM4ICh3ZXN0b24pDQogICAgICBUYXNrczogMCAo
bGltaXQ6IDE3OTYpDQogICAgIE1lbW9yeTogMi40TSAocGVhazogMi45TSkNCiAgICAgICAgQ1BV
OiAxNDBtcw0KICAgICBDR3JvdXA6IC9zeXN0ZW0uc2xpY2Uvd2VzdG9uLnNlcnZpY2UNCiAgICAg
ICAgICAgICA+IDIzOCAvdXNyL2Jpbi93ZXN0b24gLS1tb2R1bGVzPXN5c3RlbWQtbm90aWZ5LnNv
DQoNCkphbiAwMSAwMDowMDowMSBzbWFyYy1yenYybCBzeXN0ZW1kWzFdOiBTdGFydGluZyBXZXN0
b24sIGEgV2F5bGFuZCBjb21wb3NpdG9yLCBhcyBhIHN5c3RlbSBzZXJ2aWNlLi4uDQpKYW4gMDEg
MDA6MDA6MDYgc21hcmMtcnp2Mmwgc3lzdGVtZFsxXTogU3RhcnRlZCBXZXN0b24sIGEgV2F5bGFu
ZCBjb21wb3NpdG9yLCBhcyBhIHN5c3RlbSBzZXJ2aWNlLg0Kcm9vdEBzbWFyYy1yenYybDp+Iw0K
