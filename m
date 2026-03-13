Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A103F106FD9A
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 08:41:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E10D410E00E;
	Fri, 13 Mar 2026 08:41:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="TUxMjcOx";
	dkim-atps=neutral
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazon11010044.outbound.protection.outlook.com [52.101.228.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25B5510E00E
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 08:41:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tSO/mcBj5Vr9sv9VPSc9ATxuqSub9vb99OPNmKLPtDCWYqdYUMylzmy4YCqLbD8anQHg9Zv1PE2y0tMFlQQ5UIOFEmd1ko6UDDBsD2Kv2XCsb0sCHVVvfg2eN5LhviqNw98r4GS3GzMuYU/9bqfmHP/ugmNutCk3/yh4bhHD48PN6cKW10sGqkHENJm+hCg8XldxTyBDWLtQvjoC8ZuQ8up8oCoyfm+QmjPNR/GAi4FXE+DsIipByZFRi12gCBH1JI1BRG80SLok/fxoJEuI4KVZU8WY+8E+OW0Br83J0TanAzo2GwoTvS4vJDV0nHMiC+KrjYN9YQbnLzxyw3KK5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4hSn0RxlwLZcgU9pNJrUrtP+ShwtsqNlKZPfQGl+tk=;
 b=P29oPJpcKdaTCE31cWC3c2J18sHTrScPCCdycLLjD6d0wJyl5wjlXRnSjXVdnZ3jT8I+0mwTUFyts3MX12nFDD97Hopn0W22N8HSwcIv9rdc430NrMPY5lHBFCikNeMVIsaDICxYqWMS4t0WxMu07toCCszimJjwgc60zAx6AawESGgJwgrNj0nFIboY/LyRSZAlEtQ43CPF3A+hY0Pe9Pwu+9+397X8jJ8Cv87FJeGOWa0anmTQ2lbo0o8iTDuXAHao3+bXhbmiwxq5OcSh7ss/x+fcyULfe9a0J59lqBGoUnrcUiGj+JXY/5prqQ0v/WiC/FW6dqAeNB8dBQnftg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4hSn0RxlwLZcgU9pNJrUrtP+ShwtsqNlKZPfQGl+tk=;
 b=TUxMjcOxNrgQPv877453PXUJiWeeEYpZP+6MMl5MV0mbYaxyLLrCQsw90BIK+f7nlX4jXoB+bZZ2cp5QpBueDZMeUO6mIWJ7myWiwBU3vuZoQ4PRC0tFzkgHskYyLDcM9I5MWf/pWdiSn9QrsvpUiEI3qCjLA2g3KZeomDunOy8=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYYPR01MB12843.jpnprd01.prod.outlook.com (2603:1096:405:15a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.16; Fri, 13 Mar
 2026 08:41:13 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9700.015; Fri, 13 Mar 2026
 08:41:19 +0000
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
Thread-Index: AQHcp96eSUoAacjqcU2c+U96UWFVr7WrPdqAgAAB0YCAANfgAIAAF6oAgAALMHA=
Date: Fri, 13 Mar 2026 08:41:19 +0000
Message-ID: <TY3PR01MB11346D6B46C079E640300B8BB8645A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
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
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYYPR01MB12843:EE_
x-ms-office365-filtering-correlation-id: a7286bb3-92c4-4ffa-bf37-08de80dc4c21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: HfIz9Tf5Zp8Kg6Ao5WOjYB0R8XXMs7e91TaAErVMUYkjebt+z3CfOA9XmWu7N+FcbPFky/fwQh22cZaTokKM8A0azCOd2UF/zz9lQF5YZYxDVVS4qA8bX+jzLyDDs00pylDAAbK0OGtiQBcxcER1LnyeMcSVD6FLHxZHZzvqAm1SuuAS43kh1BgrF/aRDhdgn/DtQSqyzL1lbwspod/1ct1CCywrm4Cz7WCKhlISpZ92ScgX83r+4FQHsILkDJvKGZwApDLDr4rmdfYwEiCRl/3W7572csgNumDxOJRsXGxwTVhBt7hF6nqpcFpODVHwZrg3qmm9kqhxuMyzlXqeBxbbj7SZlo5GuT5UsgdOHznEiVRdiQdJK5iJaDRi01aUeG0yoNZHlOHMgHJa6lZVybaXC9+XFb7mmEgQwYU/eujel6PPEfJCiRTFmZT4y78PPHFLPCN6ClV6eRCmm3LJOR/En5yU4AOCrxWXkcTr7as2hHvSFLMyvsXg/mXbvz10dyTmFlWZEbAAZaqiR3vaqSyQNnL/lI59PiYACxGw6OMM3LRZql9k3bw8VCXE4fQZ5fpTD0ryuIaQvBhlZy2UTnVazkXDKaj8JyszxPu0r5FawY9FeBgtq2G73OopQeuUqv0U+LtNXt7uZlgeJ8CD2D1xhwFHSjToQXTN/aW18wYnHN75vKrJxrny/M8HHxN002blB/q1Kv1t02Xm3jDrrVmoUSeVqjwv8ZCezR1rNvAgd/Y3o7QdPArwM8moTs8gh82zS/+4NVsDcSQ/Kw21yERimimn2BF9i9dWI2M+LyY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEt3S3pDbFpRT1ErMjR3NE0vbnhOaTU1N1dlTmxkVGlZdUQxVzF4MWJZSjJq?=
 =?utf-8?B?M2lSeitHdTB0RkRlQk9tZEQ3enhwL2c1QXlxYlBjaVJGSnBzVExOTlovbU5k?=
 =?utf-8?B?OTFSdURCK2ZlbEdHbHhiWU5oRVZiQ3p4WmJNRnFEaktiYkIzd05ZcjFtVGRy?=
 =?utf-8?B?aGcvN3UwVkFjTTFwYjlGRHRCaU1Oam5JclV1dU9JNTduMFFJSExqY2kwRnN4?=
 =?utf-8?B?ZW83dHhLdUl5cUN1c2F0MmlIWW5iSW5SMWdHdmNWTzZtbGlwRWZwa3JvQW04?=
 =?utf-8?B?S1YycGYvVXlVWUlJSzlCbWRMbG5CUVdDc1JhdldKUHJjd2dBOURQNXRIUmQy?=
 =?utf-8?B?STZvZnlYU0V6OHE1MUtQMVFCZHpNTVh4U1RQRVhwaWNYZkpKMHJRNjJ4a1Yz?=
 =?utf-8?B?SFNBTUNKMFlaTkpCQnRIR0hrNC9lQW9taWUzdlV6YXVmbzRRMVAyeWFpbXZ0?=
 =?utf-8?B?YkhHN2pxNWIwaWdvRTQzZGgraktLQk4xeElrbzhoREk5MWZaS3B6SGkzVTFa?=
 =?utf-8?B?bitPQWx0cDlPZ1BMd3cwOWdwMHNpTDl6WWdHcFYya1c4cEtaaExJM3VsbUdG?=
 =?utf-8?B?ZThsRWE2MTkzOWw0aVgwOEs5aHJNTENFWkpVQnU4T3IvdlJJek1Pck5BdEVn?=
 =?utf-8?B?TUE2c3J2WDZ1UUxvbTNBOExISHNwQnBNRXRXZnUzR0FVZTk4eTNYQi8xdE81?=
 =?utf-8?B?cHJhVlJNTENGR1IvUDNwNjBiMGU3NTFGOGV1UUZ1OWlhbVdETTVPRGEwRFNO?=
 =?utf-8?B?T2ovaEx0bTdhYSsyTlBOOXNEMGMvQ1I3Y2w1RVE2K3RVcENmbE9YSDdWOW5W?=
 =?utf-8?B?REN2UzhGZ1UxcDRuSk5kRHB2bjdtdkJMU1VsOGFDMHVneStmSW5yNzJaUzlT?=
 =?utf-8?B?QXg1eW8yYWpObkZoNE9WQU5sRXVVNDlaR2lIaGtHZGYveXM5U1FoRVpPNS9n?=
 =?utf-8?B?eUJPR0lvR3IzTkswQWNkS3pkR0ZZUTFnM1l2K21UUkhkU0NzNFdaYW1KVkRM?=
 =?utf-8?B?Z0E2U1Nla2VpWlhWZmxkR0x0U29QOWtVT1NoNnBNSHBlZVZYMmlSRmJjamZo?=
 =?utf-8?B?NmYxMHI5T0M0am1abkZXeWdFMGFuZHhsYWFKUGtFTndzMG9LaHk0RzlYd0ZZ?=
 =?utf-8?B?ZEM4aWxxa3FJZWVVMlgzTkpqdFhzM3ExNWZpckJVdmlwWmhQR1MzVFdnVjBH?=
 =?utf-8?B?Z1hwRVlRaDgzMUtlYTJoNmtnMVBGV1pxVU9hUVdqTHV0RkN1UWc0di9hUDlC?=
 =?utf-8?B?L203cks1c28wMFZrS3EyZXczYlpwUXh5WGljVTFNdCtlQnVQajFZMlAxQUdu?=
 =?utf-8?B?S0IvTzNQODNDb2hxY3lza04zVExvOUJaVk01WVh1NzBXVEpCcURoQnppemRs?=
 =?utf-8?B?SWhLaE1VczQ4c0lkaXpkcUJCQWIvVGpBbDdDbFBQKytjN2NBZWZhZEkyNFdo?=
 =?utf-8?B?VUQ5VEhPdHN0UGpTWmdoOW56QWNvdkNEbzU1NVF0U2Z4Vlh3K01QaVhYaEdN?=
 =?utf-8?B?Tk1XL3Urb1UwSjNBN2RHY0ZGalhzZ0h6UW82SXArWXJZYjVRT1N4anB3dnp0?=
 =?utf-8?B?eWpGUjIwcjNPd3NvNW9KcVAvZzhualY2QWlCWHhLT1RqSTJGR21NQU5YM09Y?=
 =?utf-8?B?NUpRc1ZUVk5GSkVkQ2UxaFI1NlhuSDRPV2FKUXVqdXdReitYaUEybHFhcEpO?=
 =?utf-8?B?Y1d2dGZBNjdaWDd1cm9ldVpjS01LYWwrNWR4MFlEZi9xS0k5OVc5QkNEWHdp?=
 =?utf-8?B?bW5UU1hvVkwrcStiUUdDaUptL05YdzRLczcxVFJ1MkNUdENWN1Q2aDFPTDhh?=
 =?utf-8?B?cTFveHFVRk9HNllLVlVZeHNROSsrSllQWEhPaFg2dVZnUVppbkM3S0tsbEFq?=
 =?utf-8?B?dmVNRTJtTGFQODZTVUZlaVRLZDBCdnV0OHZlWWc5ZTNtSlU5WjcyTUxQbWNQ?=
 =?utf-8?B?RUxmTlRldGo2NGJONm1vc1UvY3kxOUdvSlV6NVZzQmpGdGhPaFBWUDc2dmhq?=
 =?utf-8?B?eGl2M2p5ditSc2M0Mkk4ZlpSYkRXd3gzNU1kMGQ5WFg3TlZTSTExVnJXMlV2?=
 =?utf-8?B?RWx4SC91M09RM2pRK3FJdGlxK0NXTXJwdlU2N1FlcytKODhLbWQvZHBjRU05?=
 =?utf-8?B?RXQyd2luK0VaY1pkL3FIaE1XMkphcElZYUcyQXRxVlBvYTNFNUk1Sk1XVWpR?=
 =?utf-8?B?S3ZxRFU0SktSMUZCdjJMR210QW5QK2VVanBtL3Q4ZW5naS90WVdTNFpQNnZY?=
 =?utf-8?B?V3c0QkpnTWtOMTFUUVc0NzlxbytOSWFkb0swK0hBUXdCSjRFNWNWSG5sTDhG?=
 =?utf-8?B?QmE4NFI1enFTd2tocmRSdmRJMXdXSU9ld3pmb09YM2J3RVhMRXNxUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7286bb3-92c4-4ffa-bf37-08de80dc4c21
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 08:41:19.1259 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yfrkgz0ZHfzkZG+AXpU0K26yPOqLxr/1PtW3kgtcHQE1OhTXSdZglqaNxN9FdS9EO3ohICzXEGaG9jX6fmmkUdR3gVwf36vISkOACJLy83E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12843
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGhvbWFzIFppbW1lcm1h
bm4gPHR6aW1tZXJtYW5uQHN1c2UuZGU+DQo+IFNlbnQ6IDEzIE1hcmNoIDIwMjYgMDg6MDENCj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2NCA1LzZdIGRybS9nZW0tc2htZW06IFRyYWNrIGZvbGlvIGFj
Y2Vzc2VkL2RpcnR5IHN0YXR1cyBpbiBtbWFwDQo+IA0KPiBIaQ0KPiANCj4gQW0gMTMuMDMuMjYg
dW0gMDc6NDQgc2NocmllYiBCaWp1IERhczoNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiA+PiBGcm9tOiBkcmktZGV2ZWwgPGRyaS1kZXZlbC1ib3VuY2VzQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmDQo+ID4+IE9mIEJpanUgRGFzDQo+ID4+IFNlbnQ6IDEy
IE1hcmNoIDIwMjYgMTc6NDcNCj4gPj4gVG86IFRvbW1hc28gTWVyY2lhaSA8dG9tbWFzby5tZXJj
aWFpLnhyQGJwLnJlbmVzYXMuY29tPjsgVGhvbWFzDQo+ID4+IFppbW1lcm1hbm4gPHR6aW1tZXJt
YW5uQHN1c2UuZGU+DQo+ID4+IENjOiBib3Jpcy5icmV6aWxsb25AY29sbGFib3JhLmNvbTsgbG9p
Yy5tb2xpbmFyaUBjb2xsYWJvcmEuY29tOw0KPiA+PiB3aWxseUBpbmZyYWRlYWQub3JnOyBmcmFu
ay5iaW5uc0BpbWd0ZWMuY29tOyBtYXR0LmNvc3RlckBpbWd0ZWMuY29tOw0KPiA+PiBtYWFydGVu
Lmxhbmtob3JzdEBsaW51eC5pbnRlbC5jb207IG1yaXBhcmRAa2VybmVsLm9yZzsNCj4gPj4gYWly
bGllZEBnbWFpbC5jb207IHNpbW9uYUBmZndsbC5jaDsgbGludXgtbW1Aa3ZhY2sub3JnOw0KPiA+
PiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+ID4+IFN1YmplY3Q6IFJFOiBbUEFU
Q0ggdjQgNS82XSBkcm0vZ2VtLXNobWVtOiBUcmFjayBmb2xpbyBhY2Nlc3NlZC9kaXJ0eQ0KPiA+
PiBzdGF0dXMgaW4gbW1hcA0KPiA+Pg0KPiA+PiBIaSBUb21tYXNvLA0KPiA+Pg0KPiA+Pj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4+IEZyb206IFRvbW1hc28gTWVyY2lhaSA8dG9t
bWFzby5tZXJjaWFpLnhyQGJwLnJlbmVzYXMuY29tPg0KPiA+Pj4gU2VudDogMTIgTWFyY2ggMjAy
NiAxNzozNw0KPiA+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCA1LzZdIGRybS9nZW0tc2htZW06
IFRyYWNrIGZvbGlvDQo+ID4+PiBhY2Nlc3NlZC9kaXJ0eSBzdGF0dXMgaW4gbW1hcA0KPiA+Pj4N
Cj4gPj4+IEhpIFRob21hcywNCj4gPj4+IFRoYW5rcyBmb3IgeW91ciBwYXRjaC4NCj4gPj4+DQo+
ID4+PiBJJ20gd29ya2luZyBvbiBEU0kgc3VwcG9ydCBmb3IgUlovRzNFIGZyb20gdGhpcyBtb3Ju
aW5nIHJlYmFzaW5nIG9uDQo+ID4+PiB0b3Agb2YgbmV4dC0yMDI2MDMxMSBJJ20gc2VlaW5nIHRo
YXQgd2VzdG9uIGhhbmcgb24gbXkgc2lkZToNCj4gPj4+DQo+ID4+PiBSZXZlcnRpbmcgdGhpcyBw
YXRjaCBmaXggdGhlIGlzc3VlLg0KPiA+Pj4gKGdpdCByZXZlcnQgMjhlMzkxODE3OWFhKQ0KPiA+
Pj4NCj4gPj4+IEknbSB3b25kZXJpbmcgaWYgYW55b25lIGVuY291bnRlcmVkIHRoaXMgaXNzdWU/
DQo+ID4+PiBUaGFua3MgaW4gYWR2YW5jZS4NCj4gPj4NCj4gPj4gSSBhbSBhbHNvIHNlZWluZyBz
YW1lIGlzc3VlIG9uIFJaL0czTCB3aXRoIHdlc3Rvbi4NCj4gPiBKdXN0IGFkZCBJIGFtIHVzaW5n
IG1lc2Egd2l0aCBwYW5mcm9zdChNYWxpLUczMSkgb24gUlovRzNMLg0KPiANCj4gSSByYW4gdGhl
IHRlc3RzIHdpdGggYm9jaHMuwqAgSSBkb24ndCBoYXZlIHBhbmZyb3N0IGhhcmR3YXJlIHRvIHRl
c3Qgd2l0aCwgYnV0IG5vdGhpbmcgaW4gdGhlIGRyaXZlcg0KPiBzdGlja3Mgb3V0IGFzIHByb2Js
ZW1hdGljLiBPbmx5IHRoZSBnZW0gb3Blbi9jbG9zZSBsb2dpYyBsb29rcyBhIGJpdCBhd2t3YXJk
LiBUaGUgbW1hcCBjb2RlIGFwcGVhcnMgdG8NCj4gYmUgaWRlbnRpY2FsLg0KPiANCj4gPg0KPiA+
IERpc2FibGluZyBNYWxpLUczMSByZW5kZXJzIHdlc3RvbiBkZXNrdG9wIGR1cmluZyBib290Lg0K
PiA+DQo+ID4gTG9va3MgbGlrZSB0aGlzIHBhdGNoIGlzIGNyZWF0aW5nIHNvbWUgaGFuZyBpbiBw
YW5mcm9zdCBkcml2ZXINCj4gPiBkdXJpbmcgd2VzdG9uIGxhdW5jaC4NCj4gDQo+IERvZXMgZWl0
aGVyIG9mIHlvdSBzZWUgYW55IHdhcm5pbmdzIGluIHRoZSBrZXJuZWwgbWVzc2FnZXM/DQoNClRo
ZXJlIGlzIG5vIGtlcm5lbCBtZXNzYWdlcw0KDQpbICBPSyAgXSBGaW5pc2hlZCBWaXJ0dWFsIENv
bnNvbGUgU2V0dXAuDQpbICBPSyAgXSBTdGFydGVkIFVzZXIgTWFuYWdlciBmb3IgVUlEIDEwMDAu
DQpbICBPSyAgXSBTdGFydGVkIFNlc3Npb24gYzEgb2YgVXNlciB3ZXN0b24uDQoNCkNoZWVycywN
CkJpanUNCg==
