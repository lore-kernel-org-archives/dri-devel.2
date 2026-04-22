Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9B9F9B5EE
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 09:09:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47A7510E98D;
	Wed, 22 Apr 2026 09:09:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="WJEdd7J6";
	dkim-atps=neutral
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazon11010005.outbound.protection.outlook.com [52.101.228.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C35210E997
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 09:09:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jrvFnJAdXOnJcyzNcMheFvWkT6XxRAU78hnR9VGcNTVdOODr7k6ylf9ogFEPjGst5DScOjrhxc7QLp6mq6jojFDswJJG3GNPjv/MQIOjGEV8CDQmzQA6jZXgXawfiLBK6UK9zTfWf53PKsAw7waNAmYJymp90a93bBswOeRclCC7PA1Q/BPey9DWgWYqEw65sAbojCn0Qjv+th59Kw49c+Vzj3c4XyjHREf9cEKY4vqtSGdHbXco/AhPSJYkMjUOBkHtgliJyrp1BUTFnG7NpAzEN5HI7TYWwbqFm758DeXshWX43btP9+4xmov/wnU2crnEfxyuGswbTJm5ffRk8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mW7Uy+R7FsmM1WcpIKGp04W+dwLox/NxhKPQV7yi6I=;
 b=Ss87UajdH8h3e9wSF8Vdp7qO7BvkzjrR/tp32nLQrjKlkV6e0hFKWGQQW8oMVpp3befE3uRds5iLbgQHYAfr8qNf/2qDouUVncSdBgF9HuJuRum0HMYz9ldZVFgbwEePFXPeGLF3bih1npEn5KeiriMgTfVpYJIlUzzdHc32d+TpnVsEQ6B9p3Oxi/y4G/eq2rEwWip/lKck2u91itN+ibINWeSZTmGBNL0B/2bV4RgXaiHY/HGatpK62mowV8jLxgfRae22JRGTfKUB2KJ0SyskNsyYkcufnZaAFrJARrIWPn0Iosp0eId9pww99wN5jjSWtH/BPFxVRLpPsNnmwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mW7Uy+R7FsmM1WcpIKGp04W+dwLox/NxhKPQV7yi6I=;
 b=WJEdd7J6S0pyi0P8dqNGz98Z2uH7F9j7GOLLS82Mvo4DqV15uxvStKcwRyqLodytEZolKRpXVv9cPQ6x2ZM06w08XXaI2Q/tYw6f8+ekQ45gedme/BKhowjxFEdnxdmbUomc3MY0aHFs5Y64lX66d2MKrwJ+CuM4lGdcPv35xpQ=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY7PR01MB14553.jpnprd01.prod.outlook.com (2603:1096:405:23f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 09:09:45 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 09:09:45 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>
CC: biju.das.au <biju.das.au@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>, magnus.damm
 <magnus.damm@gmail.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-renesas-soc@vger.kernel.org"
 <linux-renesas-soc@vger.kernel.org>, Prabhakar Mahadev Lad
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Tommaso Merciai
 <tommaso.merciai.xr@bp.renesas.com>
Subject: RE: [PATCH 3/3] drm: renesas: rz-du: Add support for RZ/G3L LVDS
 encoder
Thread-Topic: [PATCH 3/3] drm: renesas: rz-du: Add support for RZ/G3L LVDS
 encoder
Thread-Index: AQHczpL/Ukn6EchJEUKwiqN+6dKGQLXmjZUAgAKy8ACAACR/gIABaWmAgAACu6A=
Date: Wed, 22 Apr 2026 09:09:44 +0000
Message-ID: <TY3PR01MB113469796FCD753980BEF8CB7862D2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260417175235.224809-1-biju.das.jz@bp.renesas.com>
 <20260417175235.224809-4-biju.das.jz@bp.renesas.com>
 <td55nrjrchomtatyx5phbojvjipwh64gnlnydqame5xakviafp@ixzaju2lnkpm>
 <9523bd97-2730-4b99-b3d0-6accc7622478@tuxon.dev>
 <m225f2xw3xkzacscycaifnc4hb3mv3o6ezaxjyhtphnjo5cfw3@6smswij3txnc>
 <d087c4f0-024d-480d-8711-5a47610b99b4@tuxon.dev>
In-Reply-To: <d087c4f0-024d-480d-8711-5a47610b99b4@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY7PR01MB14553:EE_
x-ms-office365-filtering-correlation-id: d1b18bae-074f-4440-fd86-08dea04ee56d
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: BIqhORTcMNX9DK0AUq6us7zvfUQM4DpLUOlzI8eJk8qZG3v6eLpjr0VnVNEGIKEcDgVbY7Eq5wHJIQ3CfymktumaP8XFQE2eIHbF9tYu7EDUhEZ7Nd/A+rLBepQF86ihoFpCAHYakRwFjeM9uQ3XP2itfgo+jSvT31qSmw/xdZh014Y5wGZdGztL0ESV18gfS97X7g/Y36HV5qcL1skHW4hHQPnfkOFdx9a4OSbQr9Vu70Vy1TtMK2gS3NDdJXzxcdRzMEeoDWdFdep1qpD+7aYcQvQWAKAezZ69U63xKdhU7KmtkWGBx81PXBKVYX17H3fZ9Dsl7HFgMJY97gemuNxszKDTa0r8Y7Fz0REhzvu0LGPhkHe2xtAin3QDbyQyOBGmuDDjSLMkwrbqENef1RMz1vXAFS3xkdlQnDdps0YNX0aY6VkmPdoIhkugOJKw+x94vhLSSlm9Bz5FUJrwnkogTbbHL/ZgTCo05zL+CSKt5b7cD6V9WG3MGRtyz6wLKDVufmEv4dBLpElZIelv0A1TjaJDGnmCs7s4Q2BsReu97lCgZVjRL1atGHfmN9N4TvGzros5FqfM7i4uVS8i7Gxggi/rqZDaRzMqz70GyJz6GMKTWjlrZH1AyUV64hyX/pvoQ/XY+hMWfS8J4AyHmZM26K+pg+FRhNi64clfA2uP1Lmz7qpPb3xd5rsVnfzMPw2GAqjyK0co7eeo6TXx0ra3UQXCug5wPNC64zq3zfTVs9jxJ33vRHjH0s8reOEa4/C6QlF1NIzvKPHH7jqh91IWnJwY7pnGc8VpopUMp30=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXpQd3hFak9OT0JIcnVQc0Z0WTR4aFU0aXBpN0VpYjRwazZyczVzblY3WGZB?=
 =?utf-8?B?eDIzV1o2bzByTHVVbGE0bEdQT21tM21Nek56S09ob09jbmJYQkF0bkx3OHp6?=
 =?utf-8?B?RkNyWHFRYklyNWd4VVBWTGpuaWk1bHJOT1hHdS9GMElNaTNPKzJoajFURTZZ?=
 =?utf-8?B?a2NyNEgyVW11aW5rNURKVnUxTTgxQjE4blJpOXE0d0kySCs5NStpeTZ4NGJG?=
 =?utf-8?B?YnhRMDdsMG1aRGU0UnQybEVQL2FsS0ZqZFRSOVB2Tms1ai9MSnAyQ2hwcVRv?=
 =?utf-8?B?YjhyVTJCRGVXWXo2K0poUU1GY1BJTW9iMFJsbGxjczVhOGRKeVlhclUrcW1X?=
 =?utf-8?B?QlppVVNXTDI3eXNGRkZtdTFHeW1PTjBzVUYwNE4zdUNsd08vMUZUWTk4Q2Zr?=
 =?utf-8?B?QnNaRjVZMERaMnpuRzlnM2ZiN1VjYnYrL3pkZWd3QXZVNVczMFpyN29sQko2?=
 =?utf-8?B?UEwwSHUvQjV2MTJEeW5Zdm9SVlN6ZkEwVTl5eE8yWXZMTVREdjM4a2VNYUVa?=
 =?utf-8?B?K04ycmNyc0poY21OQlYwREM3UnRoaFpCTGdLNk9PNEZoRVFGOVYwQVZ0YUlD?=
 =?utf-8?B?eEhaQW44Z0laZEZjdVpZcm1xOSt3Ulo1ZHJKQWgxMG83OWRBQjZwcHdVSTV3?=
 =?utf-8?B?Z1FjZnVVNkVodjQrNWdXWEh4U1JIaWZFQkw2aWtSZXh1ajZJTVNNT2V0b3pD?=
 =?utf-8?B?NmJtamRzNnY5TjV2OS9Tdmo1OW5WVGZtVDNmbE8rbDR1ZEtXM2V5dThBbDgv?=
 =?utf-8?B?Lzd2N3NSSHRpVmgzaHMwUFhyY3ZRZ2lKZHdPZFE1cE16VGtBaU5yRlRsQ09j?=
 =?utf-8?B?bklnNG1PL3l1Ym5XTlhuYVZCUEljUm1wR0twaVJrTzh1Vkh4VDBGWUcvTG9W?=
 =?utf-8?B?RVlsT2JqdnZGVGpubWhVaGsxazc2MHhScld6a0dYQWV4MEJjQ055amJQbFNi?=
 =?utf-8?B?VmdtTCt5WnpyalpSc2RrbDdKM2Yxazl6ZmRqYUIra2lSMGsxL3c0R3BYQkdh?=
 =?utf-8?B?UlBVUFhJYStKcE1QcFBkL0t0cW5kWWhlMzlXR3JtUDZQWWVZbUtVL1RDQVo5?=
 =?utf-8?B?ZmZSeC9CbTV1MHJOTS9hUDFKK0dLMzNEb1NtazVoL3lBTFZyRTYxY2Q0MEF1?=
 =?utf-8?B?R2hDSTlhSUxWM1FBY0RYZDcwWGRYaDduRG9pUFFjcHZkckdXSjg2L3N6NUtk?=
 =?utf-8?B?ZjcwanAxQituTXVISGpVbU1IVTZUVTI5YUNUUktKSFpreFVqa2tYeTBPNXZG?=
 =?utf-8?B?RFZja0FtUXJqTC94NDVoT2xBOUF1VVhZYjBqZEFVNU1LWGJrZ0JMTGVBTHFa?=
 =?utf-8?B?aFBsekpBcnJiS3JrYWFjeWRKWGNhU3IrNVdHVGt4eEJTUG1qd3p3aGlnWElL?=
 =?utf-8?B?MFZKZnBDRDdySHZYNFEzbzhpN1l2Ymo0cHJRNnJwTXhDVEJRTjlVYXdrWHVt?=
 =?utf-8?B?ZzFxTXhkb1cxU3ZaZ0RUTEphbFVEV1AxVHdacWtBTXR2SWN3dFJEK3pqSHZE?=
 =?utf-8?B?Q2tvbE0rQ0w0elNqRmJ1aFh3WTFiNjBheFV1aWNvaWhzdEJSUEZza3ZXWW05?=
 =?utf-8?B?OXpPNWltaFBJK2NvTmRrbzJUMm9SMk9WT04vYTJ1T25rdkM1WHZsL3p5NjNp?=
 =?utf-8?B?MDEzZ2NORm12N2tDK3dtUWMvMWRGNWFOa1c5K2IrV0N1cERoL0o0SE9sL2pM?=
 =?utf-8?B?QWRHVVhMQW8zSzdGOUg5UmZ4WWNEV0N4N0xQSThSZktlRmxCaGZ0emEvNGd0?=
 =?utf-8?B?eFY5TlhsY2p6dHBUUE5udHZka0ErRWpEeUpUL2JGaDJUcnlyejIvcjN6WUxz?=
 =?utf-8?B?c29hVmUrVFhNR3d3WndxVXViMWpyNEwxNUlJTWFCdEpNVFBPSXM4dzlhQ3FR?=
 =?utf-8?B?dEJ4bFB3eWFwVVZhM1lrdkQ5N3dZdUxBS1R4YU5JcG4vcGxyNWhLNDBwbjM2?=
 =?utf-8?B?T29JTmcwUm0vY3NwczQ4Sk9KM2R0V2NKMkN0ZjUxclUyeEZyYkdCMmpHYitr?=
 =?utf-8?B?ZEczVWZTak00RDMyclNtUWR1UW9xVkJESkhaYTdyS2xZc3o4czlVb0ErdGFQ?=
 =?utf-8?B?QzZFZ2h1WkxrRDk0d3IzWWxVVTJOVlRSWVlmeEVZb1psUDN3ZkgyUW0xNFBx?=
 =?utf-8?B?dDBmU0d1aCtBdnQ1MUZWeUEyME5HdXNXYlZ5YlRMMEFLY05PS3Bub0ZDOWM1?=
 =?utf-8?B?UHBDTk1URmNJdVJ5aG4wUmxnK0I2dmpEU3NsdFI4YmJIVDIwQTlwM0hLZWM0?=
 =?utf-8?B?K0JuamZaRmcyMWxpVjh3MXZxSFpNQWhFUTNkLzVmVmNlSm91TldMNWJ3Snoz?=
 =?utf-8?B?a3pmcFRpazBzTnRqS3JEcTl3WDVSMklhUzdnQVdMaWtPYitwWUl0QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b18bae-074f-4440-fd86-08dea04ee56d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 09:09:45.0155 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jCh+nyKyh7n2ZGwut8VlLamelEUaSmKtgP1bEtWaW4OBSRVi4OdTbE0lbbRxBSpsYmIXuA0gZu3lFhdJIRkHYpuQGaWGDAMuaJPe0d4BWMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14553
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2xhdWRpdSBCZXpuZWEg
PGNsYXVkaXUuYmV6bmVhQHR1eG9uLmRldj4NCj4gU2VudDogMjIgQXByaWwgMjAyNiAwOTo1Ng0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIDMvM10gZHJtOiByZW5lc2FzOiByei1kdTogQWRkIHN1cHBv
cnQgZm9yIFJaL0czTCBMVkRTIGVuY29kZXINCj4gDQo+IA0KPiANCj4gT24gNC8yMS8yNiAxNDoy
MiwgRG1pdHJ5IEJhcnlzaGtvdiB3cm90ZToNCj4gPiBPbiBUdWUsIEFwciAyMSwgMjAyNiBhdCAx
MjoxMToyOFBNICswMzAwLCBDbGF1ZGl1IEJlem5lYSB3cm90ZToNCj4gPj4gSGksDQo+ID4+DQo+
ID4+IE9uIDQvMTkvMjYgMTg6NTgsIERtaXRyeSBCYXJ5c2hrb3Ygd3JvdGU6DQo+ID4+PiBPbiBG
cmksIEFwciAxNywgMjAyNiBhdCAwNjo1MjozMFBNICswMTAwLCBCaWp1IHdyb3RlOg0KPiA+Pj4+
IEZyb206IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gPj4+Pg0KPiA+
Pj4+IEFkZCBzdXBwb3J0IGZvciB0aGUgUlovRzNMIExWRFMgZW5jb2RlciBkcml2ZXIuIEl0IG9w
ZXJhdGVzIGluDQo+ID4+Pj4gc2luZ2xlLWxpbmsgbW9kZSB3aXRoIDQgbGFuZXMgKERhdGEpICsg
MSBsYW5lIChDbG9jaykgYW5kIHN1cHBvcnRzDQo+ID4+Pj4gcGl4ZWwgY2xvY2sgcmF0ZXMgZnJv
bSAyNSB0byA4NyBNSHouIFRoZSBMVkRTIG1vZHVsZSBjYW5ub3QgYmUgdXNlZA0KPiA+Pj4+IGF0
IHRoZSBzYW1lIHRpbWUgYXMgTUlQSS1EU0kuIEhvd2V2ZXIsIExWRFMgYW5kIHRoZSBEU0kgaW50
ZXJmYWNlDQo+ID4+Pj4gc2hhcmUgYSBwZXJpcGhlcmFsIGNsb2NrIGFuZCB0aGUgTUlQSV9EU0lf
UFJFU0VUX04gcmVzZXQgc2lnbmFsLg0KPiA+Pj4+IEFsc28sIHRoZSBNSVBJX0RTSV9DTU5fUlNU
QiBhbmQgTUlQSV9EU0lfQVJFU0VUX04gcmVzZXQgc2lnbmFscw0KPiA+Pj4+IG11c3QgYmUgYXNz
ZXJ0ZWQgYmVmb3JlIHVzaW5nIHRoZSBMVkRTIG1vZHVsZS4NCj4gPj4+Pg0KPiA+Pj4+IFNpZ25l
ZC1vZmYtYnk6IFRvbW1hc28gTWVyY2lhaSA8dG9tbWFzby5tZXJjaWFpLnhyQGJwLnJlbmVzYXMu
Y29tPg0KPiA+Pj4+IFNpZ25lZC1vZmYtYnk6IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5l
c2FzLmNvbT4NCj4gPj4+PiAtLS0NCj4gPj4NCj4gPj4gWyAuLi5dDQo+ID4+DQo+ID4+Pj4gKy8q
DQo+ID4+Pj4gKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+Pj4+ICstLS0tLS0tLS0tLQ0KPiA+Pj4+ICsgKiBCcmlk
Z2UNCj4gPj4+PiArICovDQo+ID4+Pj4gK3N0YXRpYyB2b2lkIHJ6ZzNsX2x2ZHNfYXRvbWljX2Vu
YWJsZShzdHJ1Y3QgZHJtX2JyaWRnZSAqYnJpZGdlLA0KPiA+Pj4+ICsJCQkJICAgICBzdHJ1Y3Qg
ZHJtX2F0b21pY19zdGF0ZSAqc3RhdGUpIHsNCj4gPj4+PiArCXN0cnVjdCByemczbF9sdmRzICps
dmRzID0gYnJpZGdlX3RvX3J6ZzNsX2x2ZHMoYnJpZGdlKTsNCj4gPj4+PiArCWNvbnN0IHN0cnVj
dCBkcm1fYnJpZGdlX3N0YXRlICpicmlkZ2Vfc3RhdGU7DQo+ID4+Pj4gKwlpbnQgcmV0Ow0KPiA+
Pj4+ICsJdTMyIGZtdDsNCj4gPj4+PiArDQo+ID4+Pj4gKwkvKiBHZXQgdGhlIExWRFMgZm9ybWF0
IGZyb20gdGhlIGJyaWRnZSBzdGF0ZS4gKi8NCj4gPj4+PiArCWJyaWRnZV9zdGF0ZSA9IGRybV9h
dG9taWNfZ2V0X25ld19icmlkZ2Vfc3RhdGUoc3RhdGUsIGJyaWRnZSk7DQo+ID4+Pj4gKwlpZiAo
IWJyaWRnZV9zdGF0ZSkgew0KPiA+Pj4+ICsJCWRldl9lcnIobHZkcy0+ZGV2LCAiZmFpbGVkIHRv
IGdldCBicmlkZ2Ugc3RhdGVcbiIpOw0KPiA+Pj4+ICsJCXJldHVybjsNCj4gPj4+PiArCX0NCj4g
Pj4+PiArDQo+ID4+Pj4gKwlzd2l0Y2ggKGJyaWRnZV9zdGF0ZS0+b3V0cHV0X2J1c19jZmcuZm9y
bWF0KSB7DQo+ID4+Pj4gKwljYXNlIE1FRElBX0JVU19GTVRfUkdCODg4XzFYN1g0X0pFSURBOg0K
PiA+Pj4+ICsJCWZtdCA9IFJaRzNMX0xWRFNfTU9ERV9KRUlEQTsNCj4gPj4+PiArCQlicmVhazsN
Cj4gPj4+PiArCWNhc2UgTUVESUFfQlVTX0ZNVF9SR0I4ODhfMVg3WDRfU1BXRzoNCj4gPj4+PiAr
CQlmbXQgPSBSWkczTF9MVkRTX01PREVfVkVTQTsNCj4gPj4+PiArCQlicmVhazsNCj4gPj4+PiAr
CWRlZmF1bHQ6DQo+ID4+Pj4gKwkJZm10ID0gUlpHM0xfTFZEU19NT0RFX1ZFU0E7DQo+ID4+Pj4g
KwkJZGV2X3dhcm4obHZkcy0+ZGV2LCAiVW5zdXBwb3J0ZWQgYnVzIGZtdCAweCUwNHhcbiIsDQo+
ID4+Pj4gKwkJCSBicmlkZ2Vfc3RhdGUtPm91dHB1dF9idXNfY2ZnLmZvcm1hdCk7DQo+ID4+Pj4g
KwkJYnJlYWs7DQo+ID4+Pj4gKwl9DQo+ID4+Pj4gKw0KPiA+Pj4+ICsJcmV0ID0gcG1fcnVudGlt
ZV9yZXN1bWVfYW5kX2dldChsdmRzLT5kZXYpOw0KPiA+Pj4NCj4gPj4+IElmIHRoaXMgIGZhaWxz
IGZvciBhbnkgcmVhc29uLCB0aGUgYXRvbWljX2Rpc2FibGUoKSB3b3VsZCBzdGlsbCBiZQ0KPiA+
Pj4gY2FsbGVkIGFuZCBpdCB3aWxsIGRlY3JlbWVudCB0aGUgY291bnRlciwgcG90ZW50aWFsbHkg
dW5kZWZsb3dpbmcgaXQuDQo+ID4+PiBDb25zaWRlciBzd2l0Y2hpbmcgdG8gcG1fcnVudGltZV9n
ZXRfc3luYygpLCB3aGljaCBzdWl0cyBiZXR0ZXIgaGVyZS4NCj4gPj4NCj4gPj4gQUZBSUssIHRo
ZSBjbG9ja3Mgb2YgdGhpcyBIVyBibG9ja3MgaGF2ZSBNU1RPUCBmdW5jdGlvbmFsaXR5LiBIVw0K
PiA+PiBtYW51YWwgb2YgUlovRzNTIFsxXSAoc2hvdWxkIGJlIHRoZSBzYW1lIGZvciBSWi9HM0wg
YXMgd2VsbCkgbWVudGlvbnMNCj4gPj4gdGhlIGZvbGxvd2luZyBpbiB0aGUgY2hhcHRlciA0MS4y
LjEuICJJZiB0aGUgbWFzdGVyIGFjY2Vzc2VzIGEgbW9kdWxlDQo+ID4+IHRoYXQgaGFzIHRoZSBj
bG9jayBzdG9wcGVkIGFuZCB0aGUgTVNUT1AgYml0IHNldCwgYSBidXMgZXJyb3Igd2lsbA0KPiA+
PiBvY2N1ciIuIFsxXSBNU1RPUCBpcyBzZXQgdGhvdWdoIHRoZSBjbG9jayBlbmFibGUvZGlzYWJs
ZSBBUElzLg0KPiA+Pg0KPiA+PiBUaGUgY2xvY2tzIG9uIFJaL0czTCBhcmUgcGFydCBvZiBjbG9j
ayBwb3dlciBkb21haW5zLiBJZiB0aGUNCj4gPj4gcG1fcnVudGltZV9yZXN1bWVfYW5kX2dldCgp
IGZhaWxzIChvciBhbnkgcnVudGltZSBQTSByZXN1bWUgY2FsbHMpLA0KPiA+PiB0aGUgY2xvY2tz
IHdpbGwgYmUgb2ZmIGFuZCBNU1RPUCBzZXQuIEluIHRoaXMgY2FzZSwgY2FsbGluZw0KPiA+PiBh
dG9taWNfZGlzYWJsZSgpIG9yIGFueSBBUEkgc2V0dGluZyBIVyByZWdpc3RlcnMgd2lsbCBsZWFk
IHRvIHN5bmMgYWJvcnRzLg0KPiA+DQo+ID4gVGhlbiB5b3UndmUgaWRlbnRpZmllZCBhIGJ1ZyBp
biB0aGUgY29kZS4gVGhlIGF0b21pY19lbmFibGUoKSBkb2Vzbid0DQo+ID4gZmFpbCwgc28gZm9y
IGVhY2ggZW5hYmxlIHRoZXJlIGFsd2F5cyB3aWxsIGJlIGFuIGF0b21pY19kaXNhYmxlKCkgY2Fs
bC4NCj4gPg0KPiANCj4gSXMgdGhpcyBzb21ldGhpbmcgdGhhdCBzaG91bGQgYmUgc29sdmVkIGJ5
IGluZGl2aWR1YWwgZHJpdmVycyBwcm92aWRpbmcgc3RydWN0IGRybV9icmlkZ2VfZnVuY3MgdG8g
dGhlDQo+IHVwcGVyIGxheWVycyBvciBieSB0aGUgc3Vic3lzdGVtIGl0c2VsZj8NCg0KVGhpcyB1
c2UgY2FzZSBpcyBsaWtlIHN5c3RlbSBzdXNwZW5kL3Jlc3VtZSByaWdodC4NCg0KRm9yIGVhY2gg
c3lzdGVtIHJlc3VtZSBjYWxsLCB0aGVyZSB3aWxsIGJlIGEgc3lzdGVtIHN1c3BlbmQgY2FsbCBp
biBmdXR1cmUuDQoNCkNoZWVycywNCkJpanUNCg==
