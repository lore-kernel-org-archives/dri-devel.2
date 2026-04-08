Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4CB10FC443
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 21:45:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D29E10E6E7;
	Wed,  8 Apr 2026 21:45:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Ju1Xa3XB";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11023095.outbound.protection.outlook.com [52.101.72.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A56FB10E6E7
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 21:45:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4AS6k6h6W3Xd5SWVEwgE0Bwr2GVYQ8hygBjX8aCPs5lmaYR9ntrDh0ZBc/cwPzLnf63PZQ6Jc64gQho7BU4kuKbg3Zmy1zkiB7GBWRtsLRyPYN16LQX1FVFs97dKx63Y8uiEP0Z96Ircm/fFvKH/S0kJkADE+fziCA1JQLsnup/DEbFPrZX8NgQH88uWIkUlIl46Y7vU+a/yX8wLtQ9vb4YZ3hdg/n0SoPfRaU+MMzeRkJ9A3XKpC40fRuPpfgfOxasgpzb2ZwusAc0LR9fQsgc2Y459b3DTMeJ9d86zIB5T+ZC4SgKfjBemw9cl0i31efm90ZZ7uGnqg2cEYPwbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2rUoGxUH/8FLXgMOERAwl4g1V3RgPK8eZZ6YDt681c=;
 b=xSprcSC/jc8uS/AUSx//2rFArPdfUMV5p5Pa2P65pK/67GO6Eij0Mf0ldb8WXjRdAZICX8rPetxOgZpDAK51SorISW4p2XsnPk2b7dMcu4m0gpiG4shqPIf/y7ELEgslNE78Ie9rFUUTqsrZXB1T5LSbHIpogQvn+ComVhSyLAH+RsmowFa4T6f+dxc9D5Ci0raMNFNZ8GsVQkVvl45famgPWsHVST2bbNGtYWPDltcIM8YDuvwfI1J0O88DNH3o68I2E9lnriHzpcPgHlcAiQrqJykfDSJIe1vw7kS4Ee3i0zyhkivMBHIl29UFFAm+pB+quY8TZ6Jbp+FqKsgNsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2rUoGxUH/8FLXgMOERAwl4g1V3RgPK8eZZ6YDt681c=;
 b=Ju1Xa3XBg6eTqfGZax8agQXlO8Ov/XvNVuI5nYR/LAxFVHaZwvxr7nyk4AVClvQ/POkChldjZZoku6mMdBz8g8RFAQP5IrvEtu1kasQwDZFnhJCYzrlGP0/j9NpFXAHnsFgXbUUGnlpciwLtd/2qJhptzmkVh1tnowyR7WJJogyHJgtB/YSNckxIvT4lirIVSXoZf3eQjtkeD6iBjfdLkNV1MphWE1xVxWtjpXaCQxKEILLsb5xUlzFc0PjU3DSEcfR+2xhmkHPojLW70kKBiCRCD+7UDzF5UCLpXWKM/7oEJI19JMXN4ZDOhH3e01tjBs09z4HC6EsGK5Q9e81Y7A==
Received: from GV2P195MB2328.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:dc::8) by
 AMBP195MB2951.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:6ab::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17; Wed, 8 Apr 2026 21:45:41 +0000
Received: from GV2P195MB2328.EURP195.PROD.OUTLOOK.COM
 ([fe80::f5b2:c6b4:ffb4:9e76]) by GV2P195MB2328.EURP195.PROD.OUTLOOK.COM
 ([fe80::f5b2:c6b4:ffb4:9e76%6]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 21:45:41 +0000
From: Dominik Haller <d.haller@phytec.de>
To: "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 "Frank.li@nxp.com" <Frank.li@nxp.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "sam@ravnborg.org" <sam@ravnborg.org>, "upstream@phytec.de"
 <upstream@phytec.de>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/2] drm/panel: simple: Add EDT ETML1010G0DKA panel
Thread-Topic: [PATCH 2/2] drm/panel: simple: Add EDT ETML1010G0DKA panel
Thread-Index: AQHcxjlMfRC3BkdiaUi/TLy6acK9drXVtZ2A
Date: Wed, 8 Apr 2026 21:45:40 +0000
Message-ID: <293726a8033b8a2a0f9db0a8b2424c6b44698972.camel@phytec.de>
References: <20220818124518.42080-1-d.haller@phytec.de>
 <20220818124518.42080-2-d.haller@phytec.de>
 <ba13246c-3838-4993-12ef-420d82730b28@phytec.de>
 <adRw6sNItxMNEfK6@lizhi-Precision-Tower-5810>
In-Reply-To: <adRw6sNItxMNEfK6@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2P195MB2328:EE_|AMBP195MB2951:EE_
x-ms-office365-filtering-correlation-id: 988108dd-c158-4963-d65c-08de95b82df6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: 8/Wv8I4AENxpOY1ewY/4+cewi4WtkEmWSVXhUtv00A9/2XUQSm1bDL1YZTlgcACpgLH1M2rhD8QRJXvTIZxodyVKl5v2XoNaeR57N8IHpK6hgfVGidhgJMDd+uNNoB6/lpIQfg+3FsmzrhqMFzf4lqHgzTZJVdd4h4eWcIM4XqiYoC4WKPmqERznIGFxbBfjIn4Ki+eGkLBTDir5Ro3SQNfmq90THPayX0Y+CHuGp730vTHL6vr4LW8BhuogG1Ey8eBtTpFLIX1oRc42LSTFS5zNwLAAWlLitwN8VTSJWxYxLMTjw9WOfQEIkTI57h0ZUc9QodijGOQPx8WfwmrGXMRvBMeqMkMNLLQZioTm4xM6NMvDLgpDUPGVixFs57B0auqS1eOQKmtEeN9lFp4balcFMeLKqHEZYx0xncX6VhqJ7G6HdVFztzwvrF4cFsZHN68W50HybWcNJS7D6BTyFGbeN38nG4UMkywDB0rpNvdfO/+UInzTFwMmFpyqI52xVeeqIvWGcLrEXH7xQ+OfaM+XHV2mb+sfy7+zkPAmiYM03DSreTleFKdSzqVb3esvn/iuIwLtVLV5wxM4R9Cg3fklGzdMlqoRJMot/f0AX/+ApTQWE2MWzlxM3mYcFT29Dqi/2Re3smQzXOtP6b4d15fSPG870UonhZLcNbANjHwh198LE9pT2Xy296MvRtYt+VhsQoD5nBCEuatBnxHxH0+tXKTt/MlS1LLGNxtHPb/wa6fzQNiSWcNfbstcTujC6HRM0Ewxhyf87TmR00TJgKaNn7XUbVfrKADtVgRNYhs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2P195MB2328.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekZWVEY2ZCtRenowYlZ6QStqTHlJWG1GSkpnMkFUME00SzJ1ODFoVGpscStw?=
 =?utf-8?B?RkpNYmdoNHF3cUwwNGFUdVZaZi93YW1uOE83S3RnMjNYYS8yOGxobnRPa1dN?=
 =?utf-8?B?NkFnT25rNlZiMUp4YzlIZ0M0Wk43OFZ1V1VOaitIRDdySnF6ck1vSTd2bzl6?=
 =?utf-8?B?cmkwd25PbEFQTktWQTI4aUU0R2FpYWcvSmw4SXdUOXVpamxmMzBVRVhGSXpN?=
 =?utf-8?B?RGcrSFZGamg0Vzg4VVJJS0lYdkF4UmpHUlpHam5tL3pTRUlaaGpsRTFPZWRT?=
 =?utf-8?B?TUN5K0NGU3BQRnhRcFJncDVnSWo1cE9MSC9wMGZRdk9QNmlObkszTldjK3Rv?=
 =?utf-8?B?MDVNaDVseVY3Y2dnSzR0UjYyQVNVYjM3aEF4bkdMajFQNlRnRUZVOHd2c29o?=
 =?utf-8?B?YUQ3TStiUVdHUTlFMlZxek9KVUJCS3JHdkRnYWRmbGtOMDlkekJOZXNKUmFh?=
 =?utf-8?B?S0dRN0grSE56bkJtT25Xa2VOdUNOVk5oVG9rSXJ5VGlVZ2VzcERiT0I4Z2po?=
 =?utf-8?B?OE5SUmJCbktDTUNmT1lRSEt1aDNyZUVnNHJRRzN5cWI1RTJ4S1BxZDBKTGRS?=
 =?utf-8?B?SVJRVEdzaUFEamxOdG81bC84eC8waHFOK2NjdUMveDkwaFpJNUlkSmtYUmox?=
 =?utf-8?B?TUI4bUlHSDltUVMzcFFwQ2kwRnAvc1dCK3FlY2xwSEZTR29xOHo2TWRVS3VI?=
 =?utf-8?B?czhYeS9reVNpa05wNys2ajArL0VHZ0F2L2I1VUlCVmxFbnA3T3d5MUUwcFls?=
 =?utf-8?B?OEtDY0E3THR2dTJlb3F1R2kvZjkwSHI3Q3V3QmE3Zi8wanJVV3dqTGZoaFN6?=
 =?utf-8?B?aHMvcWhpcVdsdCt6YU5TL0dZeGJuaFRSMTgwSjlBUUE4MTZ2TnMxV0R6OXEr?=
 =?utf-8?B?dmVRR1hTdmVYQ2NmekVqaUxDeFFmKzJTV3NBZkxxWHVvdU1Db1p6K3ZndlNn?=
 =?utf-8?B?NXU2WE9MdDdiR285bXpEcGZ3OWg4Mm5jOVp5WElvQVcyMzJleUtBdzRPUS9W?=
 =?utf-8?B?L2ZNTTIvU05QUDJoenJ2VW1STXRRODU0MThMM1lidXBibVliOHJacHJ3bFhh?=
 =?utf-8?B?NzRRbWhIY2NZLzNjUEFjWHVyREJ3Y0xkbzVXdWVVZGtmZm1Va0ZtYlc5cXF2?=
 =?utf-8?B?MW5vZzVyY1M3dlZZYTFEd2xvNVhhaVk2KzVqU0NkditDQU1IOGdISENibmRs?=
 =?utf-8?B?bmVNWFVvckorZ3FOY3pQT2hIbEFkV2tKUlZJMmNuWXBxUzMyQWVLeEw1a1Nk?=
 =?utf-8?B?RER1T1RRMG5LalpOL2xac20xZzU1a2NUUDJIVW9YQlNRSnp3c2JLQlNRTXRn?=
 =?utf-8?B?SDFDYit6OVhmSGxIZjEzclhlUXFwL0ErV2hsQVJ0dE9WTGJJZ1kwMEJEYlFX?=
 =?utf-8?B?b0JNUmRTRWhwcGFlYVh2ZGUvSEFyVEtFaURsbklDeUlPRzJ0dzdWZXY3SVpF?=
 =?utf-8?B?LzZjMGFETU5qN0svRmJCdUt2UlhMcWwzdXBTYXRvWVZKWUNpQ05mb3NENTV4?=
 =?utf-8?B?YytuYVZ6UkRYbWNlMEhSeGJsV01xaitjZkdJTzU1dlF2Zm8rTXFQQnJUVjNZ?=
 =?utf-8?B?RVNzYnNhbjBxNnk5aTNMSDdoNjZJdnZHVEZpelJTMTVoY3pVR3ZPU0M5bVZW?=
 =?utf-8?B?T1pQeW5vZ3JoR3NNaElJMWNLbkYyTE01SW16VDRVL0FKdStGQVg1R0FBZGht?=
 =?utf-8?B?Y1QrS2ozb0xZZFVhSDNoWlpPV3ZEMzJld0pXNnZSNWtJMFBMTXZZWklKQ2dj?=
 =?utf-8?B?VmN6SXlqcEZiSnAwZG1yVUNmRXppRWFaVGVzSDF2WHA0TTlBZHFqMVloK0Nh?=
 =?utf-8?B?cFB1bXA2ZEhra2hhSnR2aStvL05JeC8rRmxuVVFMT3pOSDRkSjdkKzJkSHRY?=
 =?utf-8?B?dHhLa29WaE1kRythTUwrNldyMXE2bFI2VVoxbjZtRHFjejNGd1pqMmYzTFpX?=
 =?utf-8?B?MlZoWHBkZnBnSC9HQjQ5MWRzWklQSHRyaEoyV2pYS0toUEdwKzNBbGpGUEs5?=
 =?utf-8?B?b25GcE5LWGVNdGJQT3phLzBRcUVRMWV5cWluc0lhUnhrWkRiMVo5QnZ6cDdC?=
 =?utf-8?B?c3VFMXluRFRmSk15SXVkbUpaaEVMRiszNUdyM2ZiSWFYZGFnMFAvQ3R2NkUy?=
 =?utf-8?B?U2pZTDhkWUI2ZHBCTnhkVi91aDNXZU9Dd2ZOY1VUL1ArOVRrdWFHSTVwMnMz?=
 =?utf-8?B?YkRDeDhiaGNvWStmZnFoRldXWmU2UFI0eTFwM0NjMjdReGhPK2hYeWU2R2Zn?=
 =?utf-8?B?RisrWXFCaTAyN3J6aGxldEZPdkNQbGQvUjdmMEN2b1ZDYUNSelI5bFoycnBk?=
 =?utf-8?B?UExLa0ZIQnVIaUs1K1NqajU3WVpvdk96LzNMZlpoTk1VTCswcTdFRmZ1andp?=
 =?utf-8?Q?tUzG7VvNVXf8BxRWMnYREWliFc0f3c352s9ILGzb0WFJW?=
x-ms-exchange-antispam-messagedata-1: 2HH350gLpVFZlw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <1914E0B6E1B043479AC358645701EB59@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2P195MB2328.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 988108dd-c158-4963-d65c-08de95b82df6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 21:45:41.0692 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yQ81WDCcKXscK+V8+E+3320uoFCnmSsToC1+sZmaivL725z5fd0XbSOAi3UPaY5j6q9ie2UrbDAz8wUVL8Nwbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBP195MB2951
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

T24gTW8sIDIwMjYtMDQtMDYgYXQgMjI6NTAgLTA0MDAsIEZyYW5rIExpIHdyb3RlOg0KPiBPbiBN
b24sIEZlYiAwNiwgMjAyMyBhdCAwMjoyMDozMVBNICswMDAwLCBEb21pbmlrIEhhbGxlciB3cm90
ZToNCj4gPiBIZWxsbywNCj4gDQo+IE5laWwgQXJtc3Ryb25nOg0KPiANCj4gSXQgaXMgcXVpdGUg
b2xkLiBBbnkgcmVhc29uIHdoeSBub3QgcGljayB0aGlzIHBhdGNoPw0KSGksDQoNCnRoaXMgcGFu
ZWwgaXMgZW9sIGFuZCB3ZSd2ZSBzd2l0Y2hlZCB0byBldG1sMTAxMGczZHJhIGFuZA0KcGgxMjg4
MDB0MDA2LXpoYzAxIGluIG91ciBraXRzLg0KDQpTbyB0aGlzIHBhdGNoIGNhbiBiZSBkcm9wcGVk
Lg0KDQpEb21pbmlrDQo+IA0KPiBGcmFuaw0KPiA+IA0KPiA+IHBpbmcgaGVyZSwgdGhpcyBvbmUg
Z290IGZvcmdvdHRlbi4NCj4gPiBJdCBzdGlsbCBhcHBsaWVzIG9uIGRybS1taXNjLW5leHQgYW5k
IHY2LjItcmM3DQo+ID4gDQo+ID4gDQo+ID4gT24gMTguMDguMjIgMTQ6NDUsIERvbWluaWsgSGFs
bGVyIHdyb3RlOg0KPiA+ID4gQWRkIHN1cHBvcnQgZm9yIHRoZSBFRFQgRVRNTDEwMTBHMERLQSAx
MC4xIiAxMjgweDgwMCBMVkRTIHBhbmVsLg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBE
b21pbmlrIEhhbGxlciA8ZC5oYWxsZXJAcGh5dGVjLmRlPg0KPiA+ID4gLS0tDQo+ID4gPiDCoCBk
cml2ZXJzL2dwdS9kcm0vcGFuZWwvcGFuZWwtc2ltcGxlLmMgfCAyOQ0KPiA+ID4gKysrKysrKysr
KysrKysrKysrKysrKysrKysrKw0KPiA+ID4gwqAgMSBmaWxlIGNoYW5nZWQsIDI5IGluc2VydGlv
bnMoKykNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9wYW5lbC9w
YW5lbC1zaW1wbGUuYw0KPiA+ID4gYi9kcml2ZXJzL2dwdS9kcm0vcGFuZWwvcGFuZWwtc2ltcGxl
LmMNCj4gPiA+IGluZGV4IGY5ZTFmODVkYWVmNy4uOTMxNGRiMjRhYjUxIDEwMDY0NA0KPiA+ID4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL3BhbmVsL3BhbmVsLXNpbXBsZS5jDQo+ID4gPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vcGFuZWwvcGFuZWwtc2ltcGxlLmMNCj4gPiA+IEBAIC0xNzc5LDYgKzE3
NzksMzIgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwYW5lbF9kZXNjDQo+ID4gPiBlZHRfZXRtbDA3
MDB5NWRoYSA9IHsNCj4gPiA+IMKgwqAJLmNvbm5lY3Rvcl90eXBlID0gRFJNX01PREVfQ09OTkVD
VE9SX0xWRFMsDQo+ID4gPiDCoCB9Ow0KPiA+ID4gDQo+ID4gPiArc3RhdGljIGNvbnN0IHN0cnVj
dCBkcm1fZGlzcGxheV9tb2RlIGVkdF9ldG1sMTAxMGcwZGthX21vZGUgPSB7DQo+ID4gPiArCS5j
bG9jayA9IDcwMDAwLA0KPiA+ID4gKwkuaGRpc3BsYXkgPSAxMjgwLA0KPiA+ID4gKwkuaHN5bmNf
c3RhcnQgPSAxMjgwICsgMTAwLA0KPiA+ID4gKwkuaHN5bmNfZW5kID0gMTI4MCArIDEwMCArIDE5
LA0KPiA+ID4gKwkuaHRvdGFsID0gMTI4MCArIDEwMCArIDE5ICsgNDEsDQo+ID4gPiArCS52ZGlz
cGxheSA9IDgwMCwNCj4gPiA+ICsJLnZzeW5jX3N0YXJ0ID0gODAwICsgNCwNCj4gPiA+ICsJLnZz
eW5jX2VuZCA9IDgwMCArIDQgKyA0LA0KPiA+ID4gKwkudnRvdGFsID0gODAwICsgNCArIDQgKyAx
NSwNCj4gPiA+ICsJLmZsYWdzID0gRFJNX01PREVfRkxBR19QSFNZTkMgfCBEUk1fTU9ERV9GTEFH
X1BWU1lOQywNCj4gPiA+ICt9Ow0KPiA+ID4gKw0KPiA+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qg
cGFuZWxfZGVzYyBlZHRfZXRtbDEwMTBnMGRrYSA9IHsNCj4gPiA+ICsJLm1vZGVzID0gJmVkdF9l
dG1sMTAxMGcwZGthX21vZGUsDQo+ID4gPiArCS5udW1fbW9kZXMgPSAxLA0KPiA+ID4gKwkuYnBj
ID0gOCwNCj4gPiA+ICsJLnNpemUgPSB7DQo+ID4gPiArCQkud2lkdGggPSAyMTYsDQo+ID4gPiAr
CQkuaGVpZ2h0ID0gMTM1LA0KPiA+ID4gKwl9LA0KPiA+ID4gKwkuYnVzX2Zvcm1hdCA9IE1FRElB
X0JVU19GTVRfUkdCODg4XzFYN1g0X1NQV0csDQo+ID4gPiArCS5idXNfZmxhZ3MgPSBEUk1fQlVT
X0ZMQUdfREVfSElHSCwNCj4gPiA+ICsJLmNvbm5lY3Rvcl90eXBlID0gRFJNX01PREVfQ09OTkVD
VE9SX0xWRFMsDQo+ID4gPiArfTsNCj4gPiA+ICsNCj4gPiA+IMKgIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgZHJtX2Rpc3BsYXlfbW9kZSBlZHRfZXRtdjU3MGcyZGh1X21vZGUgPSB7DQo+ID4gPiDCoMKg
CS5jbG9jayA9IDI1MTc1LA0KPiA+ID4gwqDCoAkuaGRpc3BsYXkgPSA2NDAsDQo+ID4gPiBAQCAt
NDA1Nyw2ICs0MDgzLDkgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQNCj4gPiA+
IHBsYXRmb3JtX29mX21hdGNoW10gPSB7DQo+ID4gPiDCoMKgCX0sIHsNCj4gPiA+IMKgwqAJCS5j
b21wYXRpYmxlID0gImVkdCxldG1sMDcwMHk1ZGhhIiwNCj4gPiA+IMKgwqAJCS5kYXRhID0gJmVk
dF9ldG1sMDcwMHk1ZGhhLA0KPiA+ID4gKwl9LCB7DQo+ID4gPiArCQkuY29tcGF0aWJsZSA9ICJl
ZHQsZXRtbDEwMTBnMGRrYSIsDQo+ID4gPiArCQkuZGF0YSA9ICZlZHRfZXRtbDEwMTBnMGRrYSwN
Cj4gPiA+IMKgwqAJfSwgew0KPiA+ID4gwqDCoAkJLmNvbXBhdGlibGUgPSAiZWR0LGV0bXY1NzBn
MmRodSIsDQo+ID4gPiDCoMKgCQkuZGF0YSA9ICZlZHRfZXRtdjU3MGcyZGh1LA0KPiA+IA0KPiA+
IA0KPiA+IC0tDQo+ID4gUEhZVEVDIE1lc3N0ZWNobmlrIEdtYkggfCBCYXJjZWxvbmEtQWxsZWUg
MSB8IDU1MTI5IE1haW56LCBHZXJtYW55DQo+ID4gDQo+ID4gR2VzY2jDpGZ0c2bDvGhyZXI6IERp
cGwuLUluZy4gTWljaGFlbCBNaXRlemtpLCBEaXBsLi1JbmcuIEJvZG8gSHViZXINCj4gPiB8DQo+
ID4gSGFuZGVsc3JlZ2lzdGVyIE1haW56IEhSQiA0NjU2IHwgRmluYW56YW10IE1haW56LU1pdHRl
IHwgU3QuTnIuDQo+ID4gMjY2NTAwNjA4LCBERSAxNDkwNTk4NTUNCj4gPiANCg0K
