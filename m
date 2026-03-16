Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD5F5F46441
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 10:10:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B11D10E067;
	Mon, 16 Mar 2026 10:10:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="BGkcT/dk";
	dkim-atps=neutral
Received: from SY8PR01CU002.outbound.protection.outlook.com
 (mail-australiaeastazolkn19010023.outbound.protection.outlook.com
 [52.103.72.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9810510E067;
 Mon, 16 Mar 2026 10:10:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/Y4uH/DDoiVEBdBt0KfSWNLmq76dJlZvcu4CJy7GJ3FirPLwjC+e8/upiyHUJuwtYmzQw1dViqtPEZtA+k63I8QJSJjW4IIjPA1eblVxvF2W2yffNqo93/HHx8W7bcXNiZ9qlD1y3VPRL2hWsnPEYsS4zltGM0rxwfj+SbN0wnedsavvM85IyLq8TvehESaOCIq0V/0igZj9c/BpULa+vVrSttFKMMmlucsIVu3jaCA6qNJc6jgm+f+/21tbEwshpNx5VqRX4RZwnVwQ3A2ycBVeQaKGZycKK28voPjaT1j2uy5t32bmWa1v1pFkzfz4pkjD125ANyFjUGjyUCbJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3JZspisjv6KbvgiOFcBJzOxzVoS+PN8IVKEZkZYNZk=;
 b=J8SyGya01pJAvasuFG1c5Z11KqGpyngVf4neLmH25kOKqHM4rz7o7AWw8WVJMA712VT4Rbzg0XUc4w9GNwQyXdn9yo6EaxoxC6oFYVyjociKEqROK0SenX8eIxZ6z6RnQnk1kpDFVtjisk1Y0toh6c3p9Gby5UOnBvBwky5/cW7yhi6HN4hujTUGA4cCJXxDNWYH2UXklrxqteHgCayaroqCF434BK27cmnsV+g7IpurQowmBQATV4x2ZHTfXCPindBGmFmUgoYxZBZwf2E94xVrvlvaWk85RjTCiWfGVeJ3jMx6DdRc3RbEvz5PbsD3rVf0nGPDNqrx7Ji6CcNbbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3JZspisjv6KbvgiOFcBJzOxzVoS+PN8IVKEZkZYNZk=;
 b=BGkcT/dkxq9OPySrZjDWSRNkY/Tesg9eYhWtCdrqwLUwJVzJ8rWo4TQXI2FsXgLsREvRhBZBgS+q64Ph9urbdfN3bchVv3zq+Ek/uUrs5x4i4SWpTVP6Qx7510y5dQLqJSh43kHC0NYAYmk9MFcRUQnua/XoN4CMyq1JCg7xN6s6J1VOdbwei7ef8RYdn8LX8zrGYBsER3XYJxA7bSBZGY0CDwV+2XGQdUw2yIfp3Qx4W7tBEwXotPzoms9Ia+bSQ4I0qIKnYWG8qRNuHjMY/PIkCcxpOOJybJMOw//b9FkvJWtDlTLyHzqDv8f3IbT5gF1HH3XlgARwCDwuCQdt2g==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by MEYPR01MB6535.ausprd01.prod.outlook.com (2603:10c6:220:11a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Mon, 16 Mar
 2026 10:10:29 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%5]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 10:10:29 +0000
From: Junrui Luo <moonafterrain@outlook.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "Markus.Elfring@web.de"
 <Markus.Elfring@web.de>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Yuhao Jiang <danisjiang@gmail.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/amdgpu/userq: fix memory leak in MQD creation error
 paths
Thread-Topic: [PATCH] drm/amdgpu/userq: fix memory leak in MQD creation error
 paths
Thread-Index: AQHcs8hGwEBqfqGCO0+uHWGWL9p3mrWwg30AgABvKIA=
Date: Mon, 16 Mar 2026 10:10:29 +0000
Message-ID: <F21AC290-0B53-40AF-A0A0-0647B86AD2C3@outlook.com>
References: <SYBPR01MB7881A279A361F81B670CDEEAAF42A@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <PH7PR12MB6000A8C0694949AA83702AE2FB40A@PH7PR12MB6000.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB6000A8C0694949AA83702AE2FB40A@PH7PR12MB6000.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB7881:EE_|MEYPR01MB6535:EE_
x-ms-office365-filtering-correlation-id: c3889e59-2d1d-4136-d620-08de834440a2
x-microsoft-antispam: BCL:0;
 ARA:14566002|41001999006|51005399006|8062599012|8060799015|22091999003|24121999003|19110799012|461199028|31061999003|15080799012|40105399003|3412199025|440099028|10035399007|102099032|12091999003;
x-microsoft-antispam-message-info: =?utf-8?B?cEYxWXE2L25INDhvSFEvT0FlQ3JuQ0dkTGo5dlJVZWRsNVppWCtWd05DSXhz?=
 =?utf-8?B?MEhVNWFoNW12dlUxY2ZQTEZ0d0lXOTNoWWRrcDhwYjRBbEY5T2huY3JoQTNl?=
 =?utf-8?B?OStqeXl6eHlYeTVpNENRcUpKdlcxdSsyT3NiZTUwRDVySVBEb3FmbzhwWGs0?=
 =?utf-8?B?SDZNb2hhV3QvWkZkMXA2d0I3T1JjR1NURzRKT1Zob3lTcjhyT3JwVWlhRVox?=
 =?utf-8?B?UDdEZnMrSkFlUDdsTUtJZjZocGFrS2s3N1lIaXJtL1FnV0p2WGQrRmY1eHg4?=
 =?utf-8?B?aWlvK1MyY3FWdEZibHA0d29ZWXlGNjlFUzlnei93TTF0ZWNIWXplNEhVRXlJ?=
 =?utf-8?B?ei9LdUdKcEkrRkRRWnJWNzhELytIZWxmdXExU05rR2NMTXBTc0hDT09KOVBP?=
 =?utf-8?B?a0lWbDV1NEpiV0J0WElEUkVjMVlFNnFVNm5NZlNWbDlOWGhDKzNwUkpBNGI5?=
 =?utf-8?B?QmFUa2kzMzdWOVJqdGIzWC9vMlpLZ1NkNE5YcXVDamFyN29kOXc5THBWcmxD?=
 =?utf-8?B?VHpYQ0VZcTBMRE1NR3JJS2pwYVN5TnpyRThxOUdMWWJObTUwRjN5b245bHBZ?=
 =?utf-8?B?QWJyalVvNDAvMEVXZFRDWWM5UCt2dHFrMTV4akZZWTJwSHlzU01TQk9JeEpT?=
 =?utf-8?B?dEl4aFllbnl1MlVybEdDK1VRaHZEa0ZsUjN6VStNbGlUN1ZUTmFsZzJxbDkr?=
 =?utf-8?B?SjV0elhYZE9iK0h0TWVYbE5NbXQ3ZTR6YmdSZ29UU3hyaDNHTXpLTkJOQ3NR?=
 =?utf-8?B?TU5wdUtZb3dWN0tubzRHam1kUHNiclV4cUV2QUdtT09qN0RyV09FOWIyWXk0?=
 =?utf-8?B?TURIbVpNN3VPWFgxTmNaUnBacDhyZ1gyZTg1NW5tN2s2YThIcmlzbmhQeXVa?=
 =?utf-8?B?bnV6UFVERlFkWXYxU2tkelJUOG5uSE9KTXVsZ04vQ3I3anF5WWN1TityRnEr?=
 =?utf-8?B?MUo1ZW1aOHpIdkp6Z29aS3k4TDE2c2hDQmZKTVg0Z0lJSy9nSzNVT2t4c21I?=
 =?utf-8?B?OEszeXlaT0VwQkI5RkxqcmlkSmp4eHp2Z2VmSFAwTStpZXc0KzhOdzFxWnNX?=
 =?utf-8?B?YjBQbFJKQnFySnEzVG1xZVE3QlZuT1JYK01EUFp5ZmpkNG5TeE1FZWdpV2Ux?=
 =?utf-8?B?U0ZSYzhnMUVjcThCR2hhdXI5Y3N2WWlnUDhybXdhVS9hMW5iZVprc2dtNDVj?=
 =?utf-8?B?Mzl3Q0Y0eXFkMWJIOHdFakxjelFZMmw3TVBIWVhlZmtaUzJKUFVtRktGelFO?=
 =?utf-8?B?ZnRiNHRpR3NIWEVXVXVQVDFybzRXWUZPdXh6KzBLV2w2ZlpDaHluTUR1ZzhM?=
 =?utf-8?B?SEVQbjAzZUFIcjZiZWQ0OVB6UjBVbVArVU9jTDEzVWQ0SCtYWFlKeFZSNHNn?=
 =?utf-8?B?N0tXZ01PenJHZU5YN1Irc1hhOFVLU2V4NElSelJhS0tKUmdlZEhNejFPaUg5?=
 =?utf-8?Q?e0udR7fY?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHVaUUxic2FMK3g0cWhxUHhSTkpTSnZuVmNoSVkwVXN0MkU5RWpIbjE1NUo2?=
 =?utf-8?B?bnMwRzRtalhBNzFDanFxOGREZkd2bytvQW45VXpGM0gvQUlRK09XazJnR04z?=
 =?utf-8?B?K21PY2xPNVdSL2hHY2JvazdVY2lQTk9vNFcrV2ZtdVpIQzlrOXpQcURkbzJY?=
 =?utf-8?B?RVcvR2NtUXRvYzhCNkF5VWozSmZaUit0VWJTM0lpamU2d1BFczJEbUtNZm1K?=
 =?utf-8?B?NjdWd2pQdU9jNXdmeTE1M29OVk5DcC9NSUZjWGNudzVmWmpRdnEvVllzTlFm?=
 =?utf-8?B?OThHYlNhYUpGQUl4ZlAvdWxqcmhSUi9GWGlhQUhGVC96OFhNcVgzMC9vZnph?=
 =?utf-8?B?L0tzRVYzdEpCTjZKMkRRMm5JNkxEUFJGS0prcitSbUthaW9QaG85VXhwck15?=
 =?utf-8?B?M2xxTVdDbE1veUpaSXdadTN1WUdBM0VZcjFlWHN4MjVZS2R1TXFDYWZaOGZ4?=
 =?utf-8?B?ZWJSR0pDN0xMSGxxOW1VS2c4cFduSFFEQnVlMlhFRTRiWVpqeEJXMWMya3ZX?=
 =?utf-8?B?REYrc2lqSEZLb0N5RmZqMmdrL0FRUC9TR0FpYmliZzl4bDJTbisySWVpTWNQ?=
 =?utf-8?B?YWxWTFVnRnNrY1RmOVBmV09SOHN1V3RZVWI2YTYvVnpuNjU3SjExNjBOc3I0?=
 =?utf-8?B?a3FGYmZ5eXFuamw1dURhOXlaSFN2dkt3b3hyYXI2MXpjYnRjbzRQRkZHeXFr?=
 =?utf-8?B?cXllMTk2TFpIV3dKYW01SVhmdVVrZk5GYy8xcFlvSnBiTnVsOGFuU1IxMGdW?=
 =?utf-8?B?Z2x2emxWM1ozWHdoenU2cCtIYkQrMmJEcEFXNW9DUFMzYTdETjIraXpUQ0lq?=
 =?utf-8?B?YzNZZW80Mk0wSnMwejN5RGVOL1BpQ2ZnME1RaVZ5aWNVRE1uS2lDenVtRUJq?=
 =?utf-8?B?MFByS0ljZkgvOTYyZlZBdjJQTWZPSW9BNCs0RHE1cm1uQ2tlcy92cTFQU3Jr?=
 =?utf-8?B?VjRFdnNZaDFVdU1WQXpINHVqV0dnMDlKdEpkcUZQMmxmU0UzdVlacWFham1W?=
 =?utf-8?B?cUNDSXdtZDlOd2RBazJjTERKRjhKdVpOeThRMDA5S0ltM1NmLys5cjdKY09w?=
 =?utf-8?B?Z0lVRFgvdkVnTUM5QVlnRWYyQkh0RURPT1RMTGt0NUJtNnJqbGRVZEtBVVJU?=
 =?utf-8?B?QW85SnE2YllLbnR2RkJaNUJHeGllQnNJRjFoR2ErY0wrMHlLMkk3dzEzKzY5?=
 =?utf-8?B?RUQ5am1xdzQwOVlUT3JMK1BrYmlqTm05cXE5TGlUYU1YVmdSdUpWU2pyYjgw?=
 =?utf-8?B?SURJaHFvRTcrVnQwN0IzWkdPTjhJRklodFV3eWM2VkxGT0FoZ3F1VzBnQUJQ?=
 =?utf-8?B?SVlyVzR1SnZkcmxFT2tqZi9GK1NOL2JWREJqZTFuNStRaHhsVTdia3VIdmkz?=
 =?utf-8?B?L01nNTN1UHNFTElpWU5EZE5TSWwrdkl2b1h4UitMZFF5Zm5ENlNhbm1QT2Ni?=
 =?utf-8?B?Z09NSFFrTVBZYkNpa3B1NlRZd0V5cXhrckZDMTdpR2JaMXZhZEcvVXpWYVc0?=
 =?utf-8?B?ZW00MC9wQU1SdDNWY1J1dW5KUlFNSU1Pbm1wSHM3RytvZTdGcE1hMHVHcm9t?=
 =?utf-8?B?eFRXckdLN3RBK3MzTWR2djRFM2w2elo3dE1WeTJ6Q041ZEVLdWhGd2c2TUtq?=
 =?utf-8?B?RUFydU5OOElrUUlmS0tyODNkOEZLRXFFdFJtSStObHAwS1IvUWx0T21TY3NL?=
 =?utf-8?B?L1V3MTU2NCtjRlVYeFl1MEEvd3l1TGpiVHl6bFFiR2wvN1FHWWdVeklYdW9V?=
 =?utf-8?B?cjA3YUJ5Y0tLOU1KNGFiRW9NTXR0R012YmlxYU5lcS9nZmhCL0plazZrS1FM?=
 =?utf-8?B?aCs4MXhZeEF3Zjg2b0VUR3NYNExxSFNZL2g4bFNxTjJDZytwUmQyMDdtRTkz?=
 =?utf-8?B?QSs0eGpORTdXblc5Y0l6Z25VdVNKRmk0aG00MVdEWWtTWWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA1EBC642EF8F848B6B720D04D0618D4@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c3889e59-2d1d-4136-d620-08de834440a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 10:10:29.8027 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEYPR01MB6535
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

T24gU3VuLCBNYXIgMTUsIDIwMjYgYXQgMTA6NTA6NDRBTSArMDEwMCwgTWFya3VzIEVsZnJpbmcg
d3JvdGU6DQo+IElmIHlvdSB3b3VsZCBsaWtlIHRvIHN0aWNrIHRvIHRoZSB1c2FnZSBvZiBnb3Rv
IGxhYmVscyBzbyBmYXIsDQo+IEkgc2VlIGZ1cnRoZXIgcG9zc2liaWxpdGllcyB0byBhdm9pZCBh
bHNvIGR1cGxpY2F0ZSBzb3VyY2UgY29kZSBmb3INCj4gdGhlIGFmZmVjdGVkIGltcGxlbWVudGF0
aW9uIG9mIHRoZSBmdW5jdGlvbiDigJxtZXNfdXNlcnFfbXFkX2NyZWF0ZeKAnS4NCj4gaHR0cHM6
Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjcuMC1yYzMvc291cmNlL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L21lc191c2VycXVldWUuYyNMMjc1LUw0MzQNCg0KDQpPbiBNb24sIE1hciAx
NiwgMjAyNiBhdCAwMzozMjozNEFNICswMDAwLCBMaWFuZywgUHJpa2Ugd3JvdGU6DQo+IFRoYW5r
cyBmb3IgdGhlIGZpeC4gV2UgY291bGQgZnVydGhlciByZWZpbmUgdGhpcyBieSB3cmFwcGluZyBh
IHVuaWZpZWQgaGVscGVyIGZvciBmZXRjaGluZyBhbmQgdmFsaWRhdGluZyB0aGUgdXNlcnEgTVFE
IHJhdyBkYXRhLg0KIA0KVGhhbmtzIGZvciB0aGUgcmV2aWV3IGFuZCBzdWdnZXN0aW9ucy4NCg0K
SSdtIHRoaW5raW5nIG9mIGEgZm9sbG93LXVwIHBhdGNoIHRoYXQgc3BsaXRzIHRoZSBicmFuY2hl
cyBpbnRvIHNlcGFyYXRlDQpoZWxwZXIgZnVuY3Rpb25zLiBFYWNoIGZ1bmN0aW9uIHdvdWxkIHVz
ZSBfX2ZyZWUoa2ZyZWUpIHRvIG1hbmFnZSB0aGUNCm1lbWR1cCBsaWZldGltZSBpbnRlcm5hbGx5
LiBUaGUgbWFpbiBmdW5jdGlvbiB3b3VsZCBvbmx5IGRpc3BhdGNoIGFuZA0KZm9yd2FyZCBlcnJv
cnMgdG8gdGhlIGV4aXN0aW5nIGdvdG8gY2hhaW4uDQoNCkZvciBpbnN0YW5jZToNCg0Kc3RhdGlj
IHZvaWQgKm1lc191c2VycV9tcWRfcmVhZChzdHJ1Y3QgZHJtX2FtZGdwdV91c2VycV9pbiAqbXFk
X3VzZXIsDQoJCQkJc2l6ZV90IHNpemUsIGNvbnN0IGNoYXIgKmlwX25hbWUpDQp7DQoJdm9pZCAq
bXFkOw0KDQoJaWYgKG1xZF91c2VyLT5tcWRfc2l6ZSAhPSBzaXplIHx8ICFtcWRfdXNlci0+bXFk
KSB7DQoJCURSTV9FUlJPUigiSW52YWxpZCAlcyBNUURcbiIsIGlwX25hbWUpOw0KCQlyZXR1cm4g
RVJSX1BUUigtRUlOVkFMKTsNCgl9DQoNCgltcWQgPSBtZW1kdXBfdXNlcih1NjRfdG9fdXNlcl9w
dHIobXFkX3VzZXItPm1xZCksIHNpemUpOw0KCWlmIChJU19FUlIobXFkKSkgew0KCQlEUk1fRVJS
T1IoIkZhaWxlZCB0byByZWFkICVzIHVzZXIgTVFEXG4iLCBpcF9uYW1lKTsNCgkJcmV0dXJuIEVS
Ul9QVFIoLUVOT01FTSk7DQoJfQ0KDQoJcmV0dXJuIG1xZDsNCn0NCg0Kc3RhdGljIGludCBtZXNf
dXNlcnFfbXFkX2luaXRfY29tcHV0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCgkJCQkg
ICAgICBzdHJ1Y3QgYW1kZ3B1X3VzZXJtb2RlX3F1ZXVlICpxdWV1ZSwNCgkJCQkgICAgICBzdHJ1
Y3QgZHJtX2FtZGdwdV91c2VycV9pbiAqbXFkX3VzZXIsDQoJCQkJICAgICAgc3RydWN0IGFtZGdw
dV9tcWRfcHJvcCAqdXNlcnFfcHJvcHMpDQp7DQoJc3RydWN0IGRybV9hbWRncHVfdXNlcnFfbXFk
X2NvbXB1dGVfZ2Z4MTEgKm1xZCBfX2ZyZWUoa2ZyZWUpID0gTlVMTDsNCglpbnQgcjsNCg0KCW1x
ZCA9IG1lc191c2VycV9tcWRfcmVhZChtcWRfdXNlciwgc2l6ZW9mKCptcWQpLCAiY29tcHV0ZSIp
Ow0KCWlmIChJU19FUlIobXFkKSkNCgkJcmV0dXJuIFBUUl9FUlIobXFkKTsNCg0KCXIgPSBhbWRn
cHVfdXNlcnFfaW5wdXRfdmFfdmFsaWRhdGUoYWRldiwgcXVldWUsIG1xZC0+ZW9wX3ZhLCAyMDQ4
KTsNCglpZiAocikNCgkJcmV0dXJuIHI7DQoNCgl1c2VycV9wcm9wcy0+ZW9wX2dwdV9hZGRyID0g
bXFkLT5lb3BfdmE7DQoJdXNlcnFfcHJvcHMtPmhxZF9waXBlX3ByaW9yaXR5ID0gQU1ER1BVX0dG
WF9QSVBFX1BSSU9fTk9STUFMOw0KCXVzZXJxX3Byb3BzLT5ocWRfcXVldWVfcHJpb3JpdHkgPSBB
TURHUFVfR0ZYX1FVRVVFX1BSSU9SSVRZX01JTklNVU07DQoJdXNlcnFfcHJvcHMtPmhxZF9hY3Rp
dmUgPSBmYWxzZTsNCgl1c2VycV9wcm9wcy0+dG16X3F1ZXVlID0NCgkJbXFkX3VzZXItPmZsYWdz
ICYgQU1ER1BVX1VTRVJRX0NSRUFURV9GTEFHU19RVUVVRV9TRUNVUkU7DQoJcmV0dXJuIDA7DQp9
DQoNCi8qIHNpbWlsYXJseSBmb3IgbWVzX3VzZXJxX21xZF9pbml0X2dmeC9zZG1hICovDQoNClRo
ZW4gaW4gbWVzX3VzZXJxX21xZF9jcmVhdGUoKToNCg0KaWYgKHF1ZXVlLT5xdWV1ZV90eXBlID09
IEFNREdQVV9IV19JUF9DT01QVVRFKQ0KCXIgPSBtZXNfdXNlcnFfbXFkX2luaXRfY29tcHV0ZShh
ZGV2LCBxdWV1ZSwgbXFkX3VzZXIsDQoJCQkJICAgICAgIHVzZXJxX3Byb3BzKTsNCmVsc2UgaWYg
KHF1ZXVlLT5xdWV1ZV90eXBlID09IEFNREdQVV9IV19JUF9HRlgpDQoJciA9IG1lc191c2VycV9t
cWRfaW5pdF9nZngoYWRldiwgcXVldWUsIG1xZF91c2VyLCB1c2VycV9wcm9wcyk7DQplbHNlIGlm
IChxdWV1ZS0+cXVldWVfdHlwZSA9PSBBTURHUFVfSFdfSVBfRE1BKQ0KCXIgPSBtZXNfdXNlcnFf
bXFkX2luaXRfc2RtYShhZGV2LCBxdWV1ZSwgbXFkX3VzZXIsIHVzZXJxX3Byb3BzKTsNCg0KaWYg
KHIpDQoJZ290byBmcmVlX21xZDsNCg0KV291bGQgdGhpcyBkaXJlY3Rpb24gYmUgYWNjZXB0YWJs
ZSBhcyBhIGZvbGxvdy11cD8NCg0KVGhhbmtzLA0KSnVucnVpIEx1bw0KDQo=
