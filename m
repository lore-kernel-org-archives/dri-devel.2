Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FF1C5B572
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 05:49:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAF6110E0B9;
	Wed, 19 Aug 2026 05:49:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="ODQQ62En";
	dkim-atps=neutral
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazon11022097.outbound.protection.outlook.com [52.101.126.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1326110E0B9
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 05:49:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lgyMxGFgjakNA/zSOZV171ZO19yxwhPSsoakFnMZn7e/j9pEDpPqbhNJQT72VCS1NkStdMcn1Bv9SvACMBzoU14GFOITCvPqZ8Mxq6fEauAWUdLj5o7rto/j0SlQWBb4f4Lmui/TmKtPp31gMSL+9wqQ9tqQG8L7ZNGSYM6iTrlFhRPxUxpTglPoKwPHT+M6Zwzuad71kVSQxPMlYCrozR305i/AgJOF5sGXZb519f8oqBHDdWEGn4SNs5JD98kFAJHtVpyqNaFYqctqoihEr0E/yu3+rzkH9abyUSxZ90bySRJgLpEK4+3Zvw1nIDUFF2NrvDU+2HO5pNQ8rrU76g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRB4XvXg/YSUIJntDnG/16T4OzlYY4H05aww7c0uBIA=;
 b=UNlGzM1JC2HVBQ7SasJfLE+1wR1U5MLafPAkGBWt6geD1a/oT5N+6nVVJjfxbVKEUznCuhjsUtRugJeiAAJMYYAenuNNsuf92vGrC7n/lgY2/F14EUBoCX8J4xBNCTGzzSAc4IBBQ5Cti1W9T/sJfv6rWEQzhoUgupDxLTLyCEf2VJMH90zqj0bPcgjBn44rSF5COKgWufSEiPsdHX+MxUva0DBBW9Dnjr9aekb9eHYdVN0yOUE/Hz5T4zWrtcVYaqVopuCLBAKgYpC/kEWfNLDJNGjM54KsTNytosGNdxZujlvfv44MOY+e2LWPwRc9RN5HnoMYe9qFTa4x3vu2SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRB4XvXg/YSUIJntDnG/16T4OzlYY4H05aww7c0uBIA=;
 b=ODQQ62En62W1pASaUz/REOMwbK+mJv0siMaQCUQ8EuNDk/FsxH/AV6iPQiEE9zhfjo/zwbd1iR2aiEH/XAzwHWF8NDk1b7uK2vZPQ0t/6SwHAdKiKzUF5lLxjf4cdbQzBLA2zmPd+hYoUZ83kD6YYWStdERniQvxQ9gjfV+uOxJAgf9bdUvfiDyNjkv3CNb2JIlCRcP+6y0rkaDKpyZk1D38nw5PZPGohRax6YLN3JI1EaR8i2p7D8/feOSdRq2rlYHnp5lDZAwFxLQ2zcdO8ZJarH4haBQp6fS5hUtpLqYPn3PYCg6NJEtuVOcIFKgFgk0EjznXnI1BAgSZkJNRqw==
Received: from JH0PR06MB7577.apcprd06.prod.outlook.com (2603:1096:990:81::6)
 by TY0PR06MB5845.apcprd06.prod.outlook.com (2603:1096:400:278::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 05:49:00 +0000
Received: from JH0PR06MB7577.apcprd06.prod.outlook.com
 ([fe80::3e98:e283:3222:826e]) by JH0PR06MB7577.apcprd06.prod.outlook.com
 ([fe80::3e98:e283:3222:826e%5]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 05:49:00 +0000
From: Jammy Huang <jammy_huang@aspeedtech.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, Jani Nikula
 <jani.nikula@linux.intel.com>, Dave Airlie <airlied@redhat.com>, Jocelyn
 Falempe <jfalempe@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?utf-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] drm/ast: DisplayPort edid supports 256 bytes
Thread-Topic: [PATCH v2] drm/ast: DisplayPort edid supports 256 bytes
Thread-Index: AQHctghLcM60vWSjB0q2hmYy6od4zrWz5cqAgB8T2UCAruV5AIAEv6LwgB2uTnCAABE+AIABb1Rw
Date: Wed, 19 Aug 2026 05:49:00 +0000
Message-ID: <JH0PR06MB757742281B0587A3D9A5790BF1A52@JH0PR06MB7577.apcprd06.prod.outlook.com>
References: <20260317-upstream_ast_dp_edid-v2-1-31166703c491@aspeedtech.com>
 <2efefedd-a36a-4b3c-a2cd-89db3499ebdb@suse.de>
 <TYZPR06MB6568D830FCFB93A9776333ECF1C22@TYZPR06MB6568.apcprd06.prod.outlook.com>
 <b601f8842b959f6d8a2bd22bf6743dabad6d980c@intel.com>
 <TYZPR06MB65681FB22E654846896F81A4F1C92@TYZPR06MB6568.apcprd06.prod.outlook.com>
 <SI6PR06MB7590EB0C73CC9229B3A867D9F1A62@SI6PR06MB7590.apcprd06.prod.outlook.com>
 <35bf3f76-c1fc-41a8-9b88-1b773f337e32@suse.de>
In-Reply-To: <35bf3f76-c1fc-41a8-9b88-1b773f337e32@suse.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR06MB7577:EE_|TY0PR06MB5845:EE_
x-ms-office365-filtering-correlation-id: 9a86a803-8d12-4af9-1d2c-08defdb59162
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|56012099006|6133799003|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: t4AzdY0qx9pR+ejwO9ip4lLelwAd+rGUUCH796GrtD4pTHhXbQyOHudK77RVGnNVqccMdq/7j1OyKMAMdjgE2NnmP9q4osYM83/zzfQTyZyqm4U3isp4k6mAE5ueDOQ0T8PdDRY4O7cXzd4YAtGJfQVxPF72ccmi5I0ZR86G/pAJ+1ZnbWOAsnfWdzR+fIg9HT4yYwKvBszBsaR7AtMIH9uP10bbYD8Gnoo1X1f28A9pDHBISKI8pYYLfHfQdT7+1Uf2/HIAO50jff9nxOUf+73h8n+45iB2eRJgK0jLUcoS7smHI0AGHQQZ5wENSoIftmc1VpORSgk0p0KdmMD8Byys3hI2oUk3qBuEsge3uGFdVJ3w+DFINTaJ3PlOnjRAYuDxVEnAk1nDVZUi/kjCXvwuzaqouEUowlZRYwPSIodW+Qv/P768BSzpTFbE3BkKYeqob5tthbsVDjp8tNCTYv4BvPVb+qRU/G4986y35wBUPKtqAThlYzwYyHMwBm/mj0/S9mmI09W59bjWozWCS2WCD6YWHKsJzoHtHJ+mpcRYp35xIonBp00xsqy7QFXftsc50jMTq3/tn9ZTbgmuu0xzjtl0xMWIAckWLnOEAi96SVRXC4IzrVBSkaYmlcbl9BFiCOIB5UKSCIixsb0F7+KGhx9CqFq9p1EJ5XDu6cc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:JH0PR06MB7577.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(56012099006)(6133799003)(4143699003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzMxQ0JNeWEzclUwZFJDRHFzVmpFNzBuVE4yaXhKbnBCSHFHUjNkZDE5RXpv?=
 =?utf-8?B?TmFzM01PQWhUMzNlQWRRSEl0WmxUcEM3cHMveXVRNDdDV1FkeTVyTTgxNmxJ?=
 =?utf-8?B?Y1IzdHJpR2QrM3VNSWk1MUZuQUNIRXdtSXpvYWFLTlMvZFE3aTJ2WERvRE5W?=
 =?utf-8?B?akZreXdNbjllOWsyemlCbEh4ZkIyQmtPdlZja0g2SDd5b1Zkc21Hb2YyOXVK?=
 =?utf-8?B?U1U3NmpEZUVSZ1M3UmtYQVh6MGFYKzI5QjdHdzU2bTJIV29Ed0k3bEpFY2Fo?=
 =?utf-8?B?MjltR3luNkpsU0pnT3VnQkh3dzNxWXRJSXJUaDlKMzY5MnBaTWVCNFdGQVBi?=
 =?utf-8?B?UGFlY3ZKZ0xQaERMMlNDbW5HTVJZM2E1aGhSMHU1YVJ0L1R2ai9OTCtOTnZr?=
 =?utf-8?B?TCs4R0VRUWF0QzM2cldLaG85UmkyeUtLQXFwZ0hlcEdRRjV4aFYvMVVaOTRz?=
 =?utf-8?B?aXR1bDZIT016WW5IcTFpZFY2MW95cTM3UW5sUFBHUEVYM0dRdk96TWJpTEFZ?=
 =?utf-8?B?SnZ5Y21YN204NCtnRERET0t5ZFEwSDZjTnBSYkVRRGZSOXEzWFJ2QnNoQXdI?=
 =?utf-8?B?WVJKak1DeDF5WklXYS9zNUxlZmZHN3hsUEF4MEN6MDNNM2FzeGRJdTRlV2FF?=
 =?utf-8?B?blBVakRweDJEank1Tnp3S0ZWNmhtQkpIak9JeWU4aUdxa05mQXFlelREL2ZS?=
 =?utf-8?B?OFZVNFgzY3dHQ0ZNOXhyRVdFbFo1SVRqTkdDVTZURGlBdWp2UkJ2NWdHbjNm?=
 =?utf-8?B?WmpIZjc5VGtsa1QxajRpVHJvQndnMlN0V1IxQU8zajErVzFXaWtCQzdkSXhu?=
 =?utf-8?B?YzMwS2l5OG4zbllDUldFcWZPL1hxb3ZVSU1pRDkyOVp3c3dFSHhMSzBwV2cy?=
 =?utf-8?B?TERrTE1tYzJNVmhXRWNZSjRGRk1WSEZ4Wk44UVJnRExzendsUDRsS2Y2WE1n?=
 =?utf-8?B?by9LREd3d0g1Z2owaGNKWCtQa3VSVGZaZXNvRm9lS0tScTFDUFZsOStZZWJj?=
 =?utf-8?B?U0I0VTFQOVBjdWlxZG11RnA1M1RwRnZmb281ZmkxYkFoVW94QVZEL0I3cVJ6?=
 =?utf-8?B?NVFpRUU2OVNHY3M3WDJoYU9lbkRYTXZvSHk0ZzFyZVZmMjAxVmVxMjlMK3Vl?=
 =?utf-8?B?WEdGczZaTG1QSU9WMVFoam5UR1MrSGFyZm9RaC9nYzI2bUpDZFgzSWVKSzk5?=
 =?utf-8?B?cUthOHc1MjlOZkZuQzAyVTBMcHA2cWlpcVhnN0xUanFKdmZtOFdNZHRoQW9j?=
 =?utf-8?B?SzkzaHVEU0lIWDBXejNYTGNoZ05mK1RodVhlSEEwdVVLS2Z1TXV2TnAyRUR5?=
 =?utf-8?B?dWh5dWRmTU1iMlFuaDBqQTF5aU5SdjEvWjNoaDRoZTB5QjZtdUdheCtpZjRD?=
 =?utf-8?B?UmxPQjFScU02VGlabjZHNWV4VzZ5eFdJUkFBbTFpWjBwdkFFeEUrK3VyN1Ft?=
 =?utf-8?B?V0FHNEFyV1FyRFNQWjBlV2dnOEJHNk02a1lJWFVwRFY0cndiQTdhYmtoNGxj?=
 =?utf-8?B?TWxuNndUTFB3VUhjRWNkTFd5QVJjUWRoOEZ2ZklSWVZod3NBOUxCL2xyMUZ0?=
 =?utf-8?B?eGdBOXZ3QUxjeXFVeXVGclZ0ZU1YSlcya0xwc0hsYjg4UkJTK2NyWTN4OE1Q?=
 =?utf-8?B?bGc3NVJEZWxYV0p6MXVLREIxZHdzbzd5OVBxc2I5TXBLYkd6NE9Rb0svZUVt?=
 =?utf-8?B?a2xINGh2UnlnTzRBVHBxbFVaSTBBK0JVNFEzcGZ2U0hOTWJYbmp3SnZiby83?=
 =?utf-8?B?MWY2ZE4yTkZVN2VHc1hpd3hDQTdwMWF5QWNrTXhqNzNteFYyZ0NDK2lsT2Nj?=
 =?utf-8?B?ZytkQlVtUzZJUDBRRVVhTVpjZVlTemZPUTh1ZzIzVjBnaDcxMDA2aXV5VEtl?=
 =?utf-8?B?RWk2N0tYNWs2WWdWdFN1THVJdloybGJENDlqdkRHaVNFNGdQYVhIYko2eWlE?=
 =?utf-8?B?QzF2ZjNDM0V5SmlJYXBUM1VIc2R0RHkzekVBV1RRc0xlRTZHa1FVQmpFUHc2?=
 =?utf-8?B?WE5MY1hOTEV2S0lZK0dMdXBsc1BRUUJwUS9wNjk0VXEvRVZPeVVObDVXWCtB?=
 =?utf-8?B?dWNqQWtuTFA4N05YV291SVlYVEIyaDlLS0tJT0hIOGZGYncrTXZhUmdMRXdK?=
 =?utf-8?B?QmxyczkrZFd1WVU1dUxJN0txOStjbzY4NlpMdWhLTlpJZ0hlNmVWOWx6WDdy?=
 =?utf-8?B?d25UUjJNSzVncnVpc0JuSDR2RkpCL3cxNnBicDhzY0R1aXovdUorcUVKS29Y?=
 =?utf-8?B?R3hRZUtEM1BMU3MyM0g1cC96c2hjWGxqNmkwRVVCWVMyWFlWak13a0xzTWh2?=
 =?utf-8?B?dEYwZnlIa1BsN3A0c21vMmFPakE5eE8xcCs0WWdzYnJSdDcyUXJndz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: s4B5ckjvQsbR1Dtc1PPguREK/renI6gAj19L3KMBXo8vVmFhmaGJDkmXxQimfUzn9VKY3NBjqP5HrTDjyqE+bCUWN9m86/YkzRvr5758hM6/mR02p5SI56ng8q0Nx0T3gmGaFmZ14zGx0Avh+FhSAB5arH7cqDR9k/IDKMF08TYbHENzp8N2We8V622/JDts7P08wbVRRGw0CcKXQ2oWNdfKPIxbOKO0v2u4G6ZGHy+R6yMG0YbtShQuXk/fG8AiO4nt/pYzyWJwX98OCZ/+xGaxNlk14v4W+Mgwqxr8nOmGWtA3naU0CbmqFJOZHIdeAIbehW4liIHpqm3InHi5pw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB7577.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a86a803-8d12-4af9-1d2c-08defdb59162
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2026 05:49:00.3014 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: meQibRKl48LxqkbHDWgNHNqdgD9imdkq9MtwAs+Z+rK6F9zzzI9XEBLrN6mGq+KxH6owlkHeC3zPkrXgIlrimYth8xVtFonwnu59dbSRliU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5845
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

SGkgVGhvbWFzLA0KDQpNYW55IHRoYW5rcyBmb3IgeW91ciBpbnB1dC4gSSB3aWxsIHByb3ZpZGUg
cGF0Y2ggdjMgaW4gd2hpY2ggemVyby1vdXQgdGhlIEVESUQgYnVmZmVycyA+IDEuDQoNCkJlc3Qg
cmVnYXJkcywNCkphbW15DQoNCj4gDQo+IEhpIEphbW15DQo+IA0KPiBBbSAxOC4wOC4yNiB1bSAw
ODo0MyBzY2hyaWViIEphbW15IEh1YW5nOg0KPiA+IEhpIFRob21hcywNCj4gPg0KPiA+IEknZCBs
aWtlIHRvIGdldCB5b3VyIHRob3VnaHRzIG9uIEphbmkncyBwb2ludCB0aGF0IHRoZSBrZXJuZWwg
c2hvdWxkIGF2b2lkDQo+IG1vZGlmeWluZyBFRElEIGFuZCBpbnN0ZWFkIGV4cG9zZSB0aGUgZGF0
YSBhcy1pcyB0byB1c2Vyc3BhY2UuDQo+IA0KPiBJIGFncmVlIHdpdGggSmFuaSB0aGF0IHRoZSBF
RElEIHNob3VsZCBiZXN0IGJlIHVubW9kaWZpZWQuIEJ1dCBJJ3ZlIGZvdW5kIHRoYXQNCj4gcmV0
dXJuaW5nIHVucHJvY2Vzc2VkIEVESUQgbWFrZXMgb3RoZXIgY29tcG9uZW50cyBmYWlsLiBJbiBz
b21lIGNhc2VzLCBzdWNoDQo+IGFzIGFzdCwgYXQgbGVhc3QgdGhlIGNoZWNrc3VtIG5lZWRzIHRv
IGJlIGNvcnJlY3RlZC4NCj4gDQo+ID4NCj4gPiBJbiBwcmFjdGljZSwgbW9zdCBtb25pdG9ycyBJ
IGhhdmUgZW5jb3VudGVyZWQgb25seSBjb250YWluIHR3byBFRElEIGJsb2NrcywNCj4gc28gc2lt
cGx5IHJldHVybmluZyBibG9jayAwIGFuZCBibG9jayAxIGFscmVhZHkgd29ya3MgZm9yIHRoZSBt
YWpvcml0eSBvZiBjYXNlcy4NCj4gPg0KPiA+IEdpdmVuIHRoYXQsIHdvdWxkIHlvdSBhZ3JlZSB0
aGF0IGl0IG1heSBiZSBhY2NlcHRhYmxlIHRvIHN0b3AgbW9kaWZ5aW5nIHRoZQ0KPiBFRElEIGlu
IHRoZSBkcml2ZXIgYW5kIG9ubHkgc3VwcG9ydCB0aGUgYmxvY2tzIHRoZSBoYXJkd2FyZSBjYW4g
YWN0dWFsbHkgcmVhZA0KPiBub3c/DQo+IA0KPiBBRkFJSyB0aGVyZSdzIGN1cnJlbnRseSBubyBj
bGVhciB3YXkgdG8gc2lnbmFsIGFuIEVPRiB0byB0aGUgRURJRA0KPiBwYXJzZXIuwqAgUmV0dXJu
aW5nIGFueSBlcnJubyBjb2RlIHdpbGwgbWFrZSBpdCBmYWlsIGhhcmQuwqAgwqBJTUhPIHRoYXQN
Cj4gbmV4dCBiZXN0IHRoaW5nIGlzIHRvIHplcm8tb3V0IHRoZSBFRElEIGJ1ZmZlciwgc28gdGhh
dCB0aGUgcGFyc2VyIHN0b3BzDQo+IHNpbGVudGx5LiAoWW91ciB2MywgSSB0aGluay4pIFRoYXQn
cyBhbHNvIGVhc3kgZW5vdWdoIHRvIHJldmVydCBpZi93aGVuDQo+IHRoZSBFRElEIHBhcnNlciBn
ZXRzIGEgcmVhbCBFT0Ygc3RhdGUuDQo+IA0KPiBCZXN0IHJlZ2FyZHMNCj4gVGhvbWFzDQo+IA0K
PiANCj4gPg0KPiA+IEJlc3QgcmVnYXJkcywNCj4gPiBKYW1teQ0KPiA+DQo+ID4+IEhpIEphbmks
DQo+ID4+DQo+ID4+IFRoYW5rcyBmb3IgeW91ciBpbnB1dC4gU28sIHlvdXIgc3VnZ2VzdGlvbiBp
cyBnbyBiYWNrIHRvIHJldHVybiAtRUlPIGZvciBibG9jaw0KPiA+DQo+ID4+IDEsIGFuZCBzdG9w
IHRyeWluZyB0byBtb2RpZnkgdGhlIEVESUQuDQo+ID4+IEluIHRoaXMgd2F5LCB3ZSBjYW4gaGFu
ZGxlIEVESUQgd2hvc2UgYmxvY2tzIGlzIGxlc3MgdGhhbiAyLg0KPiA+Pg0KPiA+PiBCUiwNCj4g
Pj4gSmFtbXkNCj4gPj4NCj4gPj4+PiBIaSBUaG9tYXMsDQo+ID4+Pj4NCj4gPj4+PiBHb29kIGNh
dGNoIC0gcmV0dXJuaW5nIDAgd2l0aG91dCB3cml0aW5nIHRvIGJ1ZiB3YXNuJ3Qgc2FmZS4gQnV0
IEkNCj4gPj4+PiBhbHNvIGZvdW5kIHRoYXQgcmV0dXJuaW5nIC1FSU8gaXNuJ3QgcmlnaHQgZWl0
aGVyOg0KPiA+Pj4+IF9kcm1fZG9fZ2V0X2VkaWQoKSB0cmVhdHMgRURJRF9CTE9DS19SRUFEX0ZB
SUwgYXMgZmF0YWwgZm9yIGFueQ0KPiA+Pj4+IGJsb2NrIGluZGV4LCBub3QganVzdCBibG9jayAw
LCBzbyB0aGF0IHdvdWxkIGhhdmUgZGlzY2FyZGVkIHRoZQ0KPiA+Pj4+IHdob2xlIEVESUQgZm9y
IGFueSBtb25pdG9yIHJlcG9ydGluZyBtb3JlIHRoYW4gb25lIGV4dGVuc2lvbi4NCj4gPj4+Pg0K
PiA+Pj4+IEluIHYzLCBmb3IgYmxvY2sgPiAxIEkgbm93IHplcm8gdGhlIGJ1ZmZlciBleHBsaWNp
dGx5IGFuZCByZXR1cm4gMC4NCj4gPj4+PiBUaGF0IG1ha2VzIGRybV9lZGlkJ3MgYmxvY2sgY2hl
Y2tlciBjbGFzc2lmeSBpdCBhcyBFRElEX0JMT0NLX1pFUk8NCj4gPj4+PiBpbnN0ZWFkLCB3aGlj
aCBpcyBub24tZmF0YWwgLSBpdCBnZXRzIHRyaW1tZWQgdmlhDQo+ID4+Pj4gZWRpZF9maWx0ZXJf
aW52YWxpZF9ibG9ja3MoKSAoZXh0ZW5zaW9ucyBjb3VudCByZWR1Y2VkLCBjaGVja3N1bQ0KPiA+
Pj4+IHJlY29tcHV0ZWQpLCBhbmQgYmxvY2tzIDAgYW5kIDEgc3RpbGwgY29tZSB0aHJvdWdoIGZp
bmUuIFRoaXMgYWxzbw0KPiA+Pj4+IGRpcmVjdGx5IGFkZHJlc3NlcyB5b3VyIHBvaW50IGFib3V0
IHRoZSBidWZmZXIgbm90IGJlaW5nIGd1YXJhbnRlZWQNCj4gPj4+PiB6ZXJvZWQsIHNpbmNlIHdl
IHplcm8gaXQgb3Vyc2VsdmVzIG5vdy4NCj4gPj4+IFRoZXJlJ3MgYSBsb25nLXRlcm0gZ29hbCB0
byAqbm90KiBtb2RpZnkgdGhlIEVESUQgaW4ga2VybmVsLCBidXQNCj4gPj4+IHJhdGhlciByZXR1
cm4gZXZlbiB0aGUgYnJva2VuIEVESUQgZXh0ZW5zaW9ucyB0byB1c2Vyc3BhY2UsIGlmIHRoYXQn
cyB3aGF0DQo+ID4+IHRoZSBkaXNwbGF5IGhhcy4NCj4gPj4+IFRoZXJlIGFyZSBwcm9iYWJseSBh
IGJ1bmNoIG9mIGh1cmRsZXMgaW4gbWFraW5nIHRoYXQgaGFwcGVuLCBidXQNCj4gPj4+IGludGVu
dGlvbmFsbHkgcmV0dXJuaW5nIHplcm9lZCBvdXQgRURJRCBibG9ja3MgaXMganVzdCBhZGRpbmcg
YW5vdGhlcg0KPiA+PiB1bm5lY2Vzc2FyeSBodXJkbGUuDQo+ID4+Pg0KPiA+Pj4gQlIsDQo+ID4+
PiBKYW5pLg0KPiA+Pj4NCj4gPj4+DQo+ID4+PiAtLQ0KPiA+Pj4gSmFuaSBOaWt1bGEsIEludGVs
DQo+IA0KPiAtLQ0KPiAtLQ0KPiBUaG9tYXMgWmltbWVybWFubg0KPiBHcmFwaGljcyBEcml2ZXIg
RGV2ZWxvcGVyDQo+IFNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSA0KPiBGcmFu
a2Vuc3RyLiAxNDYsIDkwNDYxIE7DvHJuYmVyZywgR2VybWFueSwgd3d3LnN1c2UuY29tDQo+IEdG
OiBKb2NoZW4gSmFzZXIsIEFuZHJldyBNY0RvbmFsZCwgKEhSQiAzNjgwOSwgQUcgTsO8cm5iZXJn
KQ0KPiANCg0K
