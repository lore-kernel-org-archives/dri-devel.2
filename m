Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B1F106F304
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 08:55:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38C8810EA16;
	Thu, 26 Mar 2026 08:55:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="FbYPSD+U";
	dkim-atps=neutral
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazon11010011.outbound.protection.outlook.com [52.101.229.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E910910EA16
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 08:55:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNeTDb2MhDE4RioUyQgqeZTtuDINgx843rsqWqMU5KNOnmtCcIHZ4zXNaHtW4MNmK+5DOkWtctSi2FYq1j3YJ0cqMNvf4aoeZmfsEmOSsVlnf/qy3SAc0EiGCdu78NXHd5WzIVkg9PsUKd2xPHgYot072wM4qaTkLgwAx9EAbNbQfGwIxrcETrCD1pI1YV95CMB8KZHd1iU7ljaBwLSON0LtiFTiXBdhDPUcaPm8dHiL7s0x07L2L24ism7SNfwqKue8PL81enY0ddYZKt83kXZD18tlX5fwQSv/f2+xCGzA04njrhlB2ZcwJBR+PwqzhvKb8TrhqmqxJKT58My2vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJ3ik9HN7PitIcvWlhq9EWgZaEmt3wkoT/hCl5YUROg=;
 b=W8GHZv5h1wcvkUWsgte3kILGNipUuNr18Y+6vpHnlatfiSZvSTcg4vCrg++rD5+8pUuYt7cD0h+A9Rl+s1kNoIFyf8BIncgrD0a2FAlRQm/tB8TRfLHHBFXY4Kv7qugDgctVZMkMDUz5lOwqjMjGgtl7EifnAQ59jqeODZ9S3qjrOuaK9lTobBUFq9dOu27Ai+bCxyggYtF4pyiyKazuoa3HBLqlUQNlereGa5RazxHI2XG1GPVyfN/j4MhXPygW5AxS6/bDM0hdrICdjXUeg96m93JJBHXi6yFc5sJOk05Io9lSv0YT5RUjxKMmhfFaBDgkP1aSus6v/JcdegQIwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJ3ik9HN7PitIcvWlhq9EWgZaEmt3wkoT/hCl5YUROg=;
 b=FbYPSD+UcIvwh+bIXEuuqy+ptEDDoJJ+n8ZQI8GR7HSVReG8EyJMAgedQ0ukP1JlWfaSg2MnCcNczSlWFsPz+A+1KA+9iaqqG4hkWgAx0EBJT5Z82RmM472d230hYxnZ59HcE7WHTFjVzGxMBP4WT9SEFtUbMskj5CWsXqI9aKk=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS7PR01MB14746.jpnprd01.prod.outlook.com (2603:1096:604:39d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 08:55:48 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9745.022; Thu, 26 Mar 2026
 08:55:47 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?utf-8?B?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
CC: Boris Brezillon <boris.brezillon@collabora.com>, Rob Herring
 <robh@kernel.org>, Steven Price <steven.price@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 2/4] drm/panfrost: Drop redundant optional clock checks
 in runtime PM
Thread-Topic: [PATCH v2 2/4] drm/panfrost: Drop redundant optional clock
 checks in runtime PM
Thread-Index: AQHcuIh8hfFALj8wyUqqAbYPOoEkkbW37WqAgAADFaCAAReyAIAE6PwAgAKaFbA=
Date: Thu, 26 Mar 2026 08:55:47 +0000
Message-ID: <TY3PR01MB11346F913241559462D109F2D8656A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260320164158.487406-1-biju.das.jz@bp.renesas.com>
 <20260320164158.487406-3-biju.das.jz@bp.renesas.com>
 <ab25E0kTBA4EjZ3Y@sobremesa>
 <TY3PR01MB11346F3DF5ACB55B5FE8DC96F864CA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB11346DD20F7E2AB23A54A274B864DA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <acLFYNHPODCYArCk@sobremesa>
In-Reply-To: <acLFYNHPODCYArCk@sobremesa>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS7PR01MB14746:EE_
x-ms-office365-filtering-correlation-id: 0040be7a-b74d-4a18-5a2d-08de8b157950
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: pI0XkXk8OO0WyUCWsOgKM0OtbRvqKDVuMlWLwan+7V++0C1rEcIG1ug7XSe5+bDPmSsP9YuGupSxzKCOXja/hBwgBPKlOBTUcWv02eViXsV4gbE3utwH9S/3oQjQ0rZ6eRV6WZmHXv+4a5JOtzuV23Myz7iA9qHiAhfe/cuUXlxu9fSxUQbwN7O7hz3VTbpSIrIE95utcMZeNS8AX3F8I9JSO03ueVnZW75fYE9Z/mOhlAEYt/kHWJUbTcuF4jlvryWUfsHOmY9qYukusVtmxe6EQGNbhMmH3H0pBzm9sjRd+PJirz7s33kDI7L1ke93h1EgelfFer6wKgr82/myndjKutFOxo0BUE4HzlSwfMEIuZGG7kbuc5q51Ia8xpdLT/fCJTIR+Kp3wXPKG02wWLMg2AlqatgfvtFvgxtnWtAxdB+AOOFHInoiaFLiW1o+sZzEk2o1gKwXa/Mbv5fyqqnBe2lr3/kncEYqVHXRYo5Ytm4MIAYDdD161BmUe1snnjp61FQB3AsYBmRJca3eraUeT1Buv/7jMuLMgv8/3DMxajGXZBVO6utD3f5lEXSkNXdK54/IAawvmm7EBYRtknihMU6iUaHvfPhFifLz9h8jId7ySwUXXVA7n7/c9KI7FtnWSkHY+aWxvxtmqLieMJ80T+n/rnNhvziJDlBxjMYrqksbzq8Pqe5K88aelD4cteYojOWyBKFKXUR2ScD5jDSrN3cdZjuYLZD1kqfDCIz3qfNjsF5YR4whOPuP3Hwkb9sN5ULzjwkGbc/a+diBZlrUgu0QPUK0hcyThFRBrGQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0c2TEx3OUNOOEgrZlNmT0Yrc210QVFXUHNuT3dwdE1RbXd0Q0VFY1NLL1dh?=
 =?utf-8?B?Z0VrRWZqRnBUQlZ2V0V5R29xNVhBcFR3bWUzdE9DS3BuT0IrT0hUMW5LU0NS?=
 =?utf-8?B?OTJCeGQ5UHRkWVYyWHNUUC9tTHdTVW9KZEppZWRiR2xEdUxNRlVGaUdGc3lv?=
 =?utf-8?B?ZVpyaFlIaHhDMXBtR3BqVVVOZWVrSWF4YzBkQUpEYVkrdEZjc3hndDc1MFZw?=
 =?utf-8?B?SnRhQzNtV3pnNDJFbFEwWXJvZ2hRRjV2VFZNWC96c0FGeHdwcDdxTG9yMXNT?=
 =?utf-8?B?NmxWS3YxMnZFOWdFa2dpT1pNQmV4eENFVWVGTmE3R09Nb01BdjZ2RjlCWHd1?=
 =?utf-8?B?bXFwZ3ZnQVk4WlY1UStlMzBNc3FGSmZta0FtS203TkgwZnRxWWJYVU8ycndX?=
 =?utf-8?B?UjVkeWExd2VXZ3owTmU1Z0VIZElMSHpQM3VKSEx5QmNWZnRMdVEvL2hveEJv?=
 =?utf-8?B?ZjBNT2lpeUVQN25hQk5DdVJmbkxaNy8wb1NZMUdTRjI3Zmd0ci9WTXg0T2xD?=
 =?utf-8?B?VmVXVkhkS0pHNys4L20vRDJscmV3Rmw4QVowSzg2cXRFdU9pN1l2TGRyV3pS?=
 =?utf-8?B?bE5sMG1xZ3Yra2JnQUtpRkpzUlhSc0tFRy9ZM1lIUFhyRW1PQi9xaVlnRjRJ?=
 =?utf-8?B?ODJDTEV2K0cycjcwbDltMldIVXZiRWdwQSsxaVdCMEhqRHJiVVZpWmUzWnVO?=
 =?utf-8?B?WVlIeDVDT29POGhkODF0VGZqZ0hmd1NwZnB3SU8xRVNiN1pRR0F5d0VWbys3?=
 =?utf-8?B?Nmlzb0FMVFQzRGNLZjB4YTlnRElPUW81OGs1cVJDMnZsYm5ld0pkQXA1SGdD?=
 =?utf-8?B?UW55Y0JsaUFaVlBWV2tFbXJ6MldCbVhTbFpKUlMxdWxwNkJndjRHc0lLR1d0?=
 =?utf-8?B?NVVtTm1BcXJIWmVHVExKdWpialRjMG9XLzlDM1JCMFl4NkJ4Z3A3cGxrdmJE?=
 =?utf-8?B?OHlEV3IzdDBxSkpBazhNRTRDUm54clcvaXFtcTJwZmowUE1xcks1NjZnd0hq?=
 =?utf-8?B?cVU1OGtYMGJUNDh0c1hybWpFT29XQVI2aFhZYmNncTZXZXNXSG05T0R1Ympt?=
 =?utf-8?B?OWlXOS9ZK3JHRGxGTTlxeUtxbTYrUWVGUEdxNVFCdDlJM0h3TFBvL05DbkVy?=
 =?utf-8?B?T3hNK2xXWjJwRXIzWjVZTDRWSE9SRmUydVF1TG91bzJ5RGF2Vk45MDhFRktX?=
 =?utf-8?B?Mk1ZOUZaSHBvblFIalhiSXlwcW9pdmxUV0dQVVdmR2xCdDEvYlFsVjRrcmxW?=
 =?utf-8?B?MmhIbHUwT0JZNmVnTEJmS0lJK05LRzNVMXlGdmxNM3plTjUySERLM3owRVZT?=
 =?utf-8?B?VjJyK0tNaEtqUlNzMDMwRDRCUXc3UU80Z3lZRVRsM05zeGZleFJFUTJtTDR2?=
 =?utf-8?B?NXZEZXJzdFF1Qno3d2p0QWtwSUw3MkdPQUlxeGdtdDJvVmdqQmlrdVZsb1Np?=
 =?utf-8?B?cTVFVjBuNWN1UTNkVVFCREFxM296ZXhHUllpY0tLSVpreGxwZCtSWERTY1Fa?=
 =?utf-8?B?QTlaQW85K2doUlpFQXRuT2xaNGxUbjFqbEdJdVpGcjVJeHJXK0F3Q1ZaQkQy?=
 =?utf-8?B?VTlYZHc3dXJ1MWNxUm5uaG5sREFIcDdZNmhUR3RNV3JkRms0Y0RZRWVVMGpS?=
 =?utf-8?B?bTNIRFJDYnlScVQ3bzNXNXdJQUdDM1RiaU9HejViTFFETTdkdVltSk1TMHpB?=
 =?utf-8?B?eUxyV01IK1pERjZtRGZqbnpGUVVoS1B4VTZFcldwNmxMMzRiYTg2ZExFSVVo?=
 =?utf-8?B?RVFsUGpIb2M4WmV3WGtmUWVzcHhzZTZYQ1lWaDczRGI2R1hKTmgzVEUxdjV2?=
 =?utf-8?B?c1h0Qml4RGtmNTh3NFVZNnVKZEZxOW0zT2plcVBFKzdsRWJWb2ZQdUgzNHZI?=
 =?utf-8?B?dmtjYjRtWWc3S2t6WHZCUDVHTldvZ0RTMGhDcDcwbGo3SEI1Rm94WHNuNFM5?=
 =?utf-8?B?NWJsdURBSktXMXZ5YitEMXd0NllObG02ZE1RMk5Xd3FKSG81MkE1a2UrZ0VB?=
 =?utf-8?B?bkFBdlN3Rnc3c1VBUnYxdWtKOFFqVCsvZzRpQzFtbjgyRktxS1dLMm9tZnNP?=
 =?utf-8?B?dGphN05JUHlZL1p5UFFzMkJqK28ydEwvZ0dlWE1BWkVOYktUd0E0cWRTMTdC?=
 =?utf-8?B?SGZpckdSSnJjempUSlRqRGMvWXVtQkxIN2EvdXR3dlJxOFRzc21nMldvNW43?=
 =?utf-8?B?ZXhlZzVlN0hWWk1MK003SFFDZkh3T3EwL3d5YVZRTG5uVmN4VmQvUlZKME1H?=
 =?utf-8?B?NDYwWWZsVWpFbzhiOGRvaENqTml0TGYzS0ZORHV5MEhLNm5IbEcwYVVYVFN3?=
 =?utf-8?B?OVdWVkZUTERaUnA0RzJIT1NqK3pVSUhOaUtCUWpSbjhDUTZ1SkJ1UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0040be7a-b74d-4a18-5a2d-08de8b157950
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 08:55:47.8543 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T9PStZ/ytYnnhf2qDDbNZX2OA0hw5lLj+NoJPCwaUD5YtU+PnhgkWxfLBitUtj1pl14BRhZkYQ6jhC85ZMgSp5hvpM5R6TOOGTkOgPGG08w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14746
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

SGkgQWRyaWFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFkcmnD
oW4gTGFydW1iZSA8YWRyaWFuLmxhcnVtYmVAY29sbGFib3JhLmNvbT4NCj4gU2VudDogMjQgTWFy
Y2ggMjAyNiAxNzoxMQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDIvNF0gZHJtL3BhbmZyb3N0
OiBEcm9wIHJlZHVuZGFudCBvcHRpb25hbCBjbG9jayBjaGVja3MgaW4gcnVudGltZSBQTQ0KPiAN
Cj4gT24gMjEuMDMuMjAyNiAxNDoxNiwgQmlqdSBEYXMgd3JvdGU6DQo+ID4gSGkgQWRyacOhbiBM
YXJ1bWJlLA0KPiA+DQo+ID4gVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQo+ID4NCj4gPiA+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBkcmktZGV2ZWwgPGRyaS1kZXZl
bC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmDQo+ID4gPiBPZiBCaWp1
IERhcw0KPiA+ID4gU2VudDogMjAgTWFyY2ggMjAyNiAyMTozMg0KPiA+ID4gU3ViamVjdDogUkU6
IFtQQVRDSCB2MiAyLzRdIGRybS9wYW5mcm9zdDogRHJvcCByZWR1bmRhbnQgb3B0aW9uYWwNCj4g
PiA+IGNsb2NrIGNoZWNrcyBpbiBydW50aW1lIFBNDQo+ID4gPg0KPiA+ID4NCj4gPiA+DQo+ID4g
PiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+IEZyb206IGRyaS1kZXZlbCA8
ZHJpLWRldmVsLWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbg0KPiA+ID4gPiBCZWhh
bGYgT2YgQWRyacOhbiBMYXJ1bWJlDQo+ID4gPiA+IFNlbnQ6IDIwIE1hcmNoIDIwMjYgMjE6MjAN
Cj4gPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAyLzRdIGRybS9wYW5mcm9zdDogRHJvcCBy
ZWR1bmRhbnQgb3B0aW9uYWwNCj4gPiA+ID4gY2xvY2sgY2hlY2tzIGluIHJ1bnRpbWUgUE0NCj4g
PiA+ID4NCj4gPiA+ID4gSGkgQmlqdSwNCj4gPiA+ID4NCj4gPiA+ID4gT24gMjAuMDMuMjAyNiAx
Njo0MSwgQmlqdSB3cm90ZToNCj4gPiA+ID4gPiBGcm9tOiBCaWp1IERhcyA8YmlqdS5kYXMuanpA
YnAucmVuZXNhcy5jb20+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGUgY2xrX2VuYWJsZSgpIGFu
ZCBjbGtfZGlzYWJsZSgpIEFQSXMgYWxyZWFkeSBoYW5kbGUgTlVMTA0KPiA+ID4gPiA+IGNsb2Nr
IHBvaW50ZXJzIGdyYWNlZnVsbHkg4oCUIGNsa19lbmFibGUoKSByZXR1cm5zIDAgYW5kDQo+ID4g
PiA+ID4gY2xrX2Rpc2FibGUoKSByZXR1cm5zIGltbWVkaWF0ZWx5IHdoZW4gcGFzc2VkIGEgTlVM
TCBvciBvcHRpb25hbA0KPiA+ID4gPiA+IGNsb2NrLiBUaGUgZXhwbGljaXQgaWYNCj4gPiA+ID4g
PiAocGZkZXYtPmJ1c19jbG9jaykgZ3VhcmRzIGFyb3VuZCB0aGVzZSBjYWxscyBpbiB0aGUgcnVu
dGltZQ0KPiA+ID4gPiA+IHN1c3BlbmQvcmVzdW1lIHBhdGhzIGFyZSB0aGVyZWZvcmUgdW5uZWNl
c3NhcnkuIFJlbW92ZSB0aGVtIHRvIHNpbXBsaWZ5IHRoZSBjb2RlLg0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gUmV2aWV3ZWQtYnk6IFN0ZXZlbiBQcmljZSA8c3RldmVuLnByaWNlQGFybS5jb20+DQo+
ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMu
Y29tPg0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+IHYxLT52MjoNCj4gPiA+ID4gPiAgKiBDb2xs
ZWN0ZWQgdGFnDQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9wYW5m
cm9zdC9wYW5mcm9zdF9kZXZpY2UuYyB8IDEyICsrKystLS0tLS0tLQ0KPiA+ID4gPiA+ICAxIGZp
bGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPiA+ID4gPiA+DQo+
ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9wYW5mcm9zdC9wYW5mcm9zdF9k
ZXZpY2UuYw0KPiA+ID4gPiA+IGIvZHJpdmVycy9ncHUvZHJtL3BhbmZyb3N0L3BhbmZyb3N0X2Rl
dmljZS5jDQo+ID4gPiA+ID4gaW5kZXggZGVkYzEzZTU2NjMxLi4wMWU3MDJhMGIyZjAgMTAwNjQ0
DQo+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3BhbmZyb3N0L3BhbmZyb3N0X2Rldmlj
ZS5jDQo+ID4gPiA+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3BhbmZyb3N0L3BhbmZyb3N0X2Rl
dmljZS5jDQo+ID4gPiA+ID4gQEAgLTQyOSwxMSArNDI5LDkgQEAgc3RhdGljIGludCBwYW5mcm9z
dF9kZXZpY2VfcnVudGltZV9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ID4gPiA+ICAJ
CWlmIChyZXQpDQo+ID4gPiA+ID4gIAkJCWdvdG8gZXJyX2NsazsNCj4gPiA+ID4gPg0KPiA+ID4g
PiA+IC0JCWlmIChwZmRldi0+YnVzX2Nsb2NrKSB7DQo+ID4gPiA+ID4gLQkJCXJldCA9IGNsa19l
bmFibGUocGZkZXYtPmJ1c19jbG9jayk7DQo+ID4gPiA+ID4gLQkJCWlmIChyZXQpDQo+ID4gPiA+
ID4gLQkJCQlnb3RvIGVycl9idXNfY2xrOw0KPiA+ID4gPiA+IC0JCX0NCj4gPiA+ID4gPiArCQly
ZXQgPSBjbGtfZW5hYmxlKHBmZGV2LT5idXNfY2xvY2spOw0KPiA+ID4gPiA+ICsJCWlmIChyZXQp
DQo+ID4gPiA+ID4gKwkJCWdvdG8gZXJyX2J1c19jbGs7DQo+ID4gPiA+ID4gIAl9DQo+ID4gPiA+
DQo+ID4gPiA+IEl0IHNlZW1zIGNsa19wcmVwYXJlX2VuYWJsZSgpIGNhbiBhbHNvIGRlYWwgd2l0
aCBOVUxMIGNsb2NrIGRldmljZQ0KPiA+ID4gPiBwb2ludGVycyBncmFjZWZ1bGx5LCBzbyBtYXli
ZSB5b3UgY291bGQgYWxzbyBkbyBhd2F5IHdpdGggcG9pbnRlciBjaGVja3MgaW4gcGFuZnJvc3Rf
Y2xrX2luaXQ/DQo+ID4gPg0KPiA+ID4gVGhpcyBpcyB0aGUgb25seSBjaGVjayBhbmQgbm8gbmVl
ZCB0byBwcmludCByYXRlIGZvciBvcHRpb25hbCBjbGsuDQo+ID4gPiBUaGF0IGlzIHRoZSByZWFz
b24gSSBoYXZlIG5vdCB0b3VjaGVkIHRoaXMuDQo+ID4gPg0KPiA+ID4gCWlmIChwZmRldi0+YnVz
X2Nsb2NrKSB7DQo+ID4gPiAJCXJhdGUgPSBjbGtfZ2V0X3JhdGUocGZkZXYtPmJ1c19jbG9jayk7
DQo+ID4gPiAJCWRldl9pbmZvKHBmZGV2LT5iYXNlLmRldiwgImJ1c19jbG9jayByYXRlID0gJWx1
XG4iLCByYXRlKTsNCj4gPiA+DQo+ID4gPiAJCWVyciA9IGNsa19wcmVwYXJlX2VuYWJsZShwZmRl
di0+YnVzX2Nsb2NrKTsNCj4gPiA+IAkJaWYgKGVycikNCj4gPiA+IAkJCWdvdG8gZGlzYWJsZV9j
bG9jazsNCj4gPiA+IAl9DQo+ID4NCj4gPiBUaGUgYWJvdmUgYmxvY2sgaXMgZ29vZCBmb3Igb3B0
aW9uYWwgY2xvY2suDQo+ID4NCj4gPiBPdGhlcndpc2UsIHRoZXJlIHdpbGwgYmUgMiBjaGVja3Mg
Zm9yIG9wdGlvbmFsIGNsay4NCj4gPg0KPiA+IE9uZSBoZXJlOg0KPiA+DQo+ID4gaWYgKHBmZGV2
LT5idXNfY2xvY2spIHsNCj4gPiAJcmF0ZSA9IGNsa19nZXRfcmF0ZShwZmRldi0+YnVzX2Nsb2Nr
KTsNCj4gPiAJZGV2X2luZm8ocGZkZXYtPmJhc2UuZGV2LCAiYnVzX2Nsb2NrIHJhdGUgPSAlbHVc
biIsIHJhdGUpOyB9DQo+ID4NCj4gPiBhbmQgb25lIGluc2lkZSB0aGUgY2xrX3ByZXBhcmVfZW5h
YmxlKCk6DQo+ID4NCj4gPiBlcnIgPSBjbGtfcHJlcGFyZV9lbmFibGUocGZkZXYtPmJ1c19jbG9j
ayk7DQo+ID4NCj4gPiBQbGVhc2UgbGV0IG1lIGtub3cgeW91ciB0aG91Z2h0cy4NCj4gDQo+IFlv
dSdyZSByaWdodCwgaXQncyBwcm9iYWJseSBiZXN0IHRvIGxlYXZlIGl0IHRoZSB3YXkgaXQgaXMu
DQoNCklmIHlvdSBhcmUgaGFwcHkgd2l0aCB0aGUgc2VyaWVzLCBjYW4geW91IHBsZWFzZSBtZXJn
ZSBpdD8NCg0KQ2hlZXJzLA0KQmlqdQ0K
