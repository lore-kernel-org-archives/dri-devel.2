Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E8AC5DF70
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 07:03:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B54010E4F3;
	Tue, 18 Aug 2026 07:03:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="G83KIT/z";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013053.outbound.protection.outlook.com [52.101.72.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FA4D10E4F3
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 07:03:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ON9u84/UzYJpa0RKwz//PicYTiXzBQbh7dhJmEKJvmczxvh7jB6d5KUTXBcxMD6RxrWNbNywS4gRWg6dCliv0Y2yOPZonrNAxMFp2tcrWGCoxU4WDyC5sXS7p086usLyobLzY2co382QzSuJBLsMKvZM49dXBGAQ1VI5QqdIoS6f/zH2cZ8IapIFgWPlKcj29naS36Si30sL5eVdNrCYY2wDwPiFGI4La9Mw/9GHtqdBsJQ/hmH9CfHPTyL9Kb02r2Xhr9kbInyyxz4VUxtWZ9EOUI9qrebqwrF52cLF+ZMqFfeX+ivypvqCZce9k8J9Zvd/sejjPJ2hq3MWMCPA+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1KkQiDYbXiMFWRkTKRjKoAkDImkYSoB2mXmgyf+P9k=;
 b=erBZpRjvG/0u46BC+rpjrHLv0l5SYatX3b5UwVSNYvaaHwHhmQTSYcXUDII119yXZ30uZys81RJaaqLYR/ioylt70yEqUFlWVtpq/JRFpHTQJ+bSjxLPjBY4ktmzOQ0WV+LjlNoy0aUbhCBk1nWEJLS47a/J0M/lOTkVL33ot/3YOKRyF0kng7niKo3RloozYPUAm9i61/HDy64hRQNCbJZ7sfv9T0nvEeQSyXdltJVR0cLVpvkf/pJqQ1mqg09oFfo+jZfyknRvkRo/6bQuTphmcWdoVbS7ndqk0t6KJrExz5ZT5dnf3QRhb6zLMqY9lvjCB0Ep+E3Ge6s+7DX37g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1KkQiDYbXiMFWRkTKRjKoAkDImkYSoB2mXmgyf+P9k=;
 b=G83KIT/z3Jgt2ckOF5oxcpvI557dZHSAoeW3BQ9Feuj4mn74n8sY+5ECkAHVE78jzRQIVAA6Ujh9foaTMW2ACpswM/+WNfn2oE7j8mS+vSsxppz2qE045Tha8ggmiyMaqt67VCcM03f1TRbUwLsLgKj+6xhDnuM+6k1SAFd2g5do0m5F6IOJn025VI4noiJYHfhKUeVk112PeSFN8vpVXihNQ1xQIa5OYLOmD2gX1ltPKtj8SgBtqN4gsfWHk3HcWOgw65uDFMQHUBqA92/GeIGkaEzRaCULWT6PejUgiZ0XrTyRt4mgfcZ7nkRELMu2kyjwdQAXrFEq61jWhHnyQg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DU0PR10MB6678.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:402::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 07:03:50 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%6]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 07:03:50 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "lee@kernel.org" <lee@kernel.org>, "linux-leds@vger.kernel.org"
 <linux-leds@vger.kernel.org>
Subject: Re: [PATCH 1/2] backlight: led_bl: Add devm_led_backlight_register()
 helper
Thread-Topic: [PATCH 1/2] backlight: led_bl: Add devm_led_backlight_register()
 helper
Thread-Index: AQHdLmsCORtFKJdUIUuGB40t5YkF6Laie+gAgADmsYA=
Date: Tue, 18 Aug 2026 07:03:50 +0000
Message-ID: <ba719f8b29164ad49c2d79862977f140c0c765a4.camel@siemens.com>
References: <20260817170817.1933046-1-alexander.sverdlin@siemens.com>
 <20260817170817.1933046-2-alexander.sverdlin@siemens.com>
 <20260817171809.1F0241F000E9@smtp.kernel.org>
In-Reply-To: <20260817171809.1F0241F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DU0PR10MB6678:EE_
x-ms-office365-filtering-correlation-id: 56c5cfc8-8299-40b1-621e-08defcf6db5f
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|55112099003|56012099006|38070700021|6133799003|4143699003|11063799006|10067099003;
x-microsoft-antispam-message-info: uXwgGj0i6I4ZMW9kLfQUvx65WBdQaIFQWcqQcvtyJHGVbIGd+uJawnRYAIzGCLnX031i15hKs+1pkVkou53z0uNjnfH1aXgVBWexuzNK2SiiwUBSgWo+xE8eP1nqbDlZU1+fhIzVHiBZrdwXQWnIZOR5J1ZyLQaOX3NenAsSjjcnP7cOxPG/m41wkQ8/kZ7ErW0LFppEaGAnuakJRP89F/Etg6LbJopI6iXGQ2UluWG+sEZPFiT/n/m0Xvu/Fki1Sp2MXKqUK+zYls6V8d9Fr7X7iVFzLd8C2npohtGkmv2xZtAuqBWvZ0TdUi4/e9b3YFzQ9xfBxT8Is9H5ARQTSOuGRKK7vKoc4nV5CqCroMTz07DAyeNvIHyZii89FGu87hSXMbSTq7oWaemlLRT2NmUWUQWFyz6iETgyWoxYDIeqBDerAUKwVwNPa1HHVUWX3qDIzpfIIcnR36Y9yfr2Gy2GAvCJ4n/JBHsVdxtiz3zAMObzyXJWq5nwFZfWfwfF/k8u4tnLErenNyawFRO6ngwedwAog9zUla0muhs/SzMGW7S8UTCKzmA8xhhEC4DRzkI+c1S7iBSI9gk3YnT5le67d4CpCDcH0BW95YuRrpJZSnW3bM3mpLGBA049RuFb/TwCmtlacxZVeePN0Xm1JHHW/HVJnhtZJEExnFigetA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(55112099003)(56012099006)(38070700021)(6133799003)(4143699003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWVZc0ZkeGxtdG85bEZiOU5MQnFybGRxRVBmMkdOVis0cUtKdUpvem9rUzJr?=
 =?utf-8?B?TDFISUFiVWNCbC9udzBXZFFlOHdGa0xweHJoSmhpUlBEQXR4d1dqTUcxb2FS?=
 =?utf-8?B?MGxjMVh2UVpJK2VzSm43aTBwTGtqNkR6blRtVEFlNmtJU1JaQmNNV3pFSndi?=
 =?utf-8?B?alNqMDhhdGplQ2kwb1FSc3VXUmUyd3F5ZEl0Yk9nNjhOMXVGakt2UHVEZksr?=
 =?utf-8?B?S2JVdkR2TFhvcHpNNFpLMGJWbFc4UUxEZXZZMTF0YUZyaG4wMzZ0MUY4Yzh2?=
 =?utf-8?B?THdVVU1JZGl3clRFUUt3dzY2UVQwT0FrbVVaWnRzdHc3Tmd0OStkRUNwY0cy?=
 =?utf-8?B?L3BMeTlrcFl4d3pOdjlIVWdHVGVnZDcwdFNSYllFVFYzYkNhZjdGelkxVjhM?=
 =?utf-8?B?bWxFVDNCSkJoV0tLZDBmK0diNDM1R3lGTFh3VWt3NnhlRzZMaGk4WXJUcWZr?=
 =?utf-8?B?S1Z1ckpDWEJXci9aVzFpbHhRSkc4Zk9BNEFodkc4RmVqNVdGK29FdWV4Z2ky?=
 =?utf-8?B?V251ZXNMVUxndVNRTlp1Q3NxcU1CdkdqaVJoT2VGV3ZUTnl4L1ducS9WeW5P?=
 =?utf-8?B?UUM1Y1Ivb3hxQ01WVFdPMUEvWUZaWjcwakdlV0U2WVQ2VkxkdVdwSWQ4U05T?=
 =?utf-8?B?RnRSYzh3Mm9EQzhpSGtVVW5nZDc0Sm4vSldnbEEzRzdyWmpZSHd1c1F6MU42?=
 =?utf-8?B?cEVHTkw3MUxvMTBwcWNsdXR2aUdRWnA0UEdzcVM2K20xTGJUQTErL0pmQ2Z0?=
 =?utf-8?B?cGJBR0ttamlLcUM0NFlDclM1ZEFnWDVFNTlNWEZ6QzBJZEFPM1pCaVdiSTBL?=
 =?utf-8?B?MjhKNitNUmpldm9oUVFlLzJHWHRhblk4eCtGTm5YUzJEZzZJK25qUW9Dbnlu?=
 =?utf-8?B?eWlBSG04Z1ViOGtieDVCVHZVWEZveGMwODlacklMcXJpOFZGRUg1Q0YwaEpR?=
 =?utf-8?B?N1ZLbVRNTEpRSDlLblJQNzZYYnMyQk90K0pST0lqVmIvYU9BblpiZzVoY2FV?=
 =?utf-8?B?ZlByc2xYSTRXL3liVTlTbXNUVHRxdGcwTUdub1J6U0UvbGQyc0VIaGFtcFJw?=
 =?utf-8?B?by84cmtLV0lJOURoV2hMN1hXeGtEQnFEcUY4TFFPSTNJbGdTUlo4SW1CdkVI?=
 =?utf-8?B?eXA1MTd3WmtBeU11bVNUTmFjeG5lL2NNUU1ZL1hoYU9FSTJLemNralIrQWdo?=
 =?utf-8?B?YjJyamdSRWdzRVdqNDloU054ME92ZkVHeVY2ZnV5MGZCSmJtR2hVVkx1SlRn?=
 =?utf-8?B?VzBrbFZpaGgvUXRaV2RUZnFrdXpPNmM5UENqbVo5MlNGOGtMQVA5d1FmYzRB?=
 =?utf-8?B?bWdWaXB1amZVajk0dmlvR05LQU1YT2R3Z2l2LzJCTk93UitMakNMWk1Sellm?=
 =?utf-8?B?dmZGUW1pVktnWkFNbUIzUWFrZEZ2eXlJTk0rRnl1RHZDRFljWVgreG55YmVv?=
 =?utf-8?B?VS9wek1VWTIwTVhLRmlkeGxxT0lqcDRtZzEzY054N1hIc2czYnlyN1lKWkNM?=
 =?utf-8?B?SSs3dkM0YWRubnVjTm1iSW00OVQzaTMyMzN3YVczdzBLcngrdEV5Vkc4Ympm?=
 =?utf-8?B?UjVlemE0YVo5b0JpNmRrZlFFeCtIWmdtQXFvL05ib2lneFdtWm1EWld6aklI?=
 =?utf-8?B?QXdFYWQ2eFdzNlhjalhFdWQ0MG45QVpUbTI3SHZVeUxtbnh3WktsenI0cCsv?=
 =?utf-8?B?OHhLcjJyOGhVOER3dm02eTVtV1lPT25tL2FzUTRPeHp4SlJmZkxhMEFlU2x1?=
 =?utf-8?B?Z3JjR3FaR2djaEx4QnRKeTJ5RTFEMkhSUVlqNDBIUWtXbEIyMEVOc0JlSTdS?=
 =?utf-8?B?N1g1UnZxdWtzVjdta0M4R3BmelBqZUx6MUFqVmJ6WUJOY3FScm1leW8zdXl0?=
 =?utf-8?B?T1c0ZUg0UnYrUUE3SVJoL3FJaWpXZlpwTGtNeUZYSjhCOUhMYWMrRnZXZWIr?=
 =?utf-8?B?N1NNM0M2RU1KVHlFZTdzZ1daZlhFektib0NDTS9yR3R1d3JjTnNCYVVUQnNM?=
 =?utf-8?B?T3ZYZ0o4ZHBrWm1DUkhmMkRxNEtMb2M3eGkyckg2VUVTd3FUNHRhWHdZalZ4?=
 =?utf-8?B?bEhPdzlsUkpQSzhvc0lybGE4aDJwOG53MUgvTVNrc29KYllVdE00RDF1L2Uy?=
 =?utf-8?B?ZW1CREt6djJEUW85eGQrODBaa0J5SGF3b2JqOS9HWmUvNENrVW8vRFVGN1lt?=
 =?utf-8?B?Unpid2tPcld6WnJ5aDZ5azM4RUQ4VXVoV0lFWXJqbzMydE1mR2M1Si9XcFZq?=
 =?utf-8?B?Q2JBMUd4SHpTd3kzc05qWGx2OFVZTEYzeS9DK2lXY1ZyZlE0K2pxS1MvcmVM?=
 =?utf-8?B?VmN1eGtYbEFJYzZUT1ZlcDF5UWc2MGROMURCUlQwUDRaaTNDWnduTko2NjNW?=
 =?utf-8?Q?R2zaNU0EkuPDqaIU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCCF8333F7CE664F91BCF8D76EF3C524@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c5cfc8-8299-40b1-621e-08defcf6db5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 07:03:50.5195 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QgugflMpQAhvvZB/UVehx+xdsuUJtd1J5DR9MwQaoSWjuOgC6uPFj7BKmLmQYuII7CMfGOkjaRQZ1p7Kiio5JN4/mZ0O8yb3KJ4ZctyjBxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6678
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

SGkgYWxsLA0KDQpPbiBNb24sIDIwMjYtMDgtMTcgYXQgMTc6MTggKzAwMDAsIHNhc2hpa28tYm90
QGtlcm5lbC5vcmcgd3JvdGU6DQo+IFRoYW5rIHlvdSBmb3IgeW91ciBjb250cmlidXRpb24hIFNh
c2hpa28gQUkgcmV2aWV3IGZvdW5kIDMgcG90ZW50aWFsIGlzc3VlKHMpIHRvIGNvbnNpZGVyOg0K
PiANCj4gTmV3IGlzc3VlczoNCj4gLSBbSGlnaF0gVGhlIGRldnJlcyByZWdpc3RyYXRpb24gb3Jk
ZXIgZm9yIHRoZSBiYWNrbGlnaHQgZGV2aWNlIGFuZCB0aGUgTEVEIGRpc2FibGUgYWN0aW9uIGlz
IHJldmVyc2VkLCBjcmVhdGluZyBhIFRPQ1RPVSByYWNlIGNvbmRpdGlvbiBvbiBkZXZpY2UgcmVt
b3ZhbCB0aGF0IGFsbG93cyB0aGUgaGFyZHdhcmUgdG8gYmUgaW1wcm9wZXJseSB0dXJuZWQgYmFj
ayBvbi4NCj4gLSBbTWVkaXVtXSBIYXJkY29kaW5nIGBkZXZfbmFtZShkZXYpYCBhcyB0aGUgYmFj
a2xpZ2h0IGRldmljZSBuYW1lIHByZXZlbnRzIGEgc2luZ2xlIGRldmljZSBmcm9tIHJlZ2lzdGVy
aW5nIG11bHRpcGxlIExFRC1iYWNrZWQgYmFja2xpZ2h0cy4NCg0KbWFrZSBzZW5zZSEgV2lsbCBi
ZSBmaXhlZCBpbiB2Mi4NCg0KPiBQcmUtZXhpc3RpbmcgaXNzdWVzOg0KPiAtIFtIaWdoXSBEZXJl
ZmVyZW5jaW5nIGEgcG90ZW50aWFsbHkgTlVMTCBgc3VwcGxpZXJgIHBvaW50ZXIgaW5zaWRlIGBk
ZXZfbmFtZSgpYCBkdXJpbmcgYW4gZXJyb3IgcGF0aCBjYXVzZXMgYSBrZXJuZWwgcGFuaWMuDQo+
IC0tDQo+IA0KPiAtLS0gUGF0Y2ggWzFdOiBbUEFUQ0ggMS8yXSBiYWNrbGlnaHQ6IGxlZF9ibDog
QWRkIGRldm1fbGVkX2JhY2tsaWdodF9yZWdpc3RlcigpIGhlbHBlciAtLS0NCj4gY29tbWl0IDk4
NjZhNGE5OTI0ZjM0YWU3YTY1OTk0N2QwMWZjYzlkYzk3NDRlYzINCj4gQXV0aG9yOiBBbGV4YW5k
ZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVyZGxpbkBzaWVtZW5zLmNvbT4NCj4gDQo+IGJhY2ts
aWdodDogbGVkX2JsOiBBZGQgZGV2bV9sZWRfYmFja2xpZ2h0X3JlZ2lzdGVyKCkgaGVscGVyDQo+
IA0KPiBUaGlzIGNvbW1pdCBmYWN0b3JzIG91dCB0aGUgYmFja2xpZ2h0IHJlZ2lzdHJhdGlvbiBp
bnRvIGEgbGVkX2JsX3JlZ2lzdGVyKCkNCj4gaGVscGVyIGFuZCBhZGRzIGRldm1fbGVkX2JhY2ts
aWdodF9yZWdpc3RlcigpLiBUaGlzIGFsbG93cyBzZWxmLWNvbnRhaW5lZA0KPiBMRUQgcHJvdmlk
ZXJzIHRvIGV4cG9zZSBhIGJhY2tsaWdodCBpbnRlcmZhY2UuIEl0IGFsc28gc3dpdGNoZXMgdG8N
Cj4gZGV2cmVzLW1hbmFnZWQgZnVuY3Rpb25zIHRvIGhhbmRsZSB0ZWFyZG93biwgcmVtb3Zpbmcg
dGhlIGV4cGxpY2l0IC5yZW1vdmUNCj4gY2FsbGJhY2suDQo+IA0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3ZpZGVvL2JhY2tsaWdodC9sZWRfYmwuYyBiL2RyaXZlcnMvdmlkZW8vYmFja2xpZ2h0
L2xlZF9ibC5jDQo+ID4gaW5kZXggZjdhYjliMzYwNzMxMy4uZjg3YTQ4Zjc0MTg2YSAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL3ZpZGVvL2JhY2tsaWdodC9sZWRfYmwuYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvdmlkZW8vYmFja2xpZ2h0L2xlZF9ibC5jDQo+IA0KPiBbIC4uLiBdDQo+IA0KPiA+IEBA
IC0yMDMsMjQgKzIwMCwyOCBAQCBzdGF0aWMgaW50IGxlZF9ibF9wcm9iZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAJcHJvcHMuYnJpZ2h0bmVzcyA9IHByaXYtPmRlZmF1bHRf
YnJpZ2h0bmVzczsNCj4gPiAgCXByb3BzLnBvd2VyID0gKHByaXYtPmRlZmF1bHRfYnJpZ2h0bmVz
cyA+IDApID8gQkFDS0xJR0hUX1BPV0VSX09GRiA6DQo+ID4gIAkJICAgICAgQkFDS0xJR0hUX1BP
V0VSX09OOw0KPiA+IC0JcHJpdi0+YmxfZGV2ID0gYmFja2xpZ2h0X2RldmljZV9yZWdpc3Rlcihk
ZXZfbmFtZSgmcGRldi0+ZGV2KSwNCj4gPiAtCQkJJnBkZXYtPmRldiwgcHJpdiwgJmxlZF9ibF9v
cHMsICZwcm9wcyk7DQo+ID4gLQlpZiAoSVNfRVJSKHByaXYtPmJsX2RldikpIHsNCj4gPiAtCQlk
ZXZfZXJyKCZwZGV2LT5kZXYsICJGYWlsZWQgdG8gcmVnaXN0ZXIgYmFja2xpZ2h0XG4iKTsNCj4g
PiAtCQlyZXR1cm4gUFRSX0VSUihwcml2LT5ibF9kZXYpOw0KPiA+IC0JfQ0KPiA+ICsJcHJpdi0+
YmxfZGV2ID0gZGV2bV9iYWNrbGlnaHRfZGV2aWNlX3JlZ2lzdGVyKGRldiwgZGV2X25hbWUoZGV2
KSwgZGV2LA0KPiA+ICsJCQkJCQkgICAgICBwcml2LCAmbGVkX2JsX29wcywgJnByb3BzKTsNCj4g
DQo+IFtTZXZlcml0eTogTWVkaXVtXQ0KPiBTaW5jZSBkZXZfbmFtZShkZXYpIGlzIHVzZWQgZm9y
IHRoZSBiYWNrbGlnaHQgZGV2aWNlIG5hbWUsIHdpbGwgdGhpcyBwcmV2ZW50DQo+IGEgc2luZ2xl
IGRldmljZSBmcm9tIHJlZ2lzdGVyaW5nIG11bHRpcGxlIExFRC1iYWNrZWQgYmFja2xpZ2h0cz8N
Cj4gDQo+IElmIGEgc2luZ2xlIGNvbnRyb2xsZXIgZHJpdmVyIGNhbGxzIGRldm1fbGVkX2JhY2ts
aWdodF9yZWdpc3RlcigpIG1vcmUgdGhhbg0KPiBvbmNlIGZvciBkaWZmZXJlbnQgTEVEcywgaXQg
c2VlbXMgdGhlIHNlY29uZCBjYWxsIHdpbGwgZmFpbCBkdWUgdG8gYSBzeXNmcw0KPiBuYW1pbmcg
Y29sbGlzaW9uICgtRUVYSVNUKSBiZWNhdXNlIHRoZSBuYW1lIGlzIGhhcmRjb2RlZCB0byB0aGUg
cGFyZW50DQo+IGRldmljZSdzIG5hbWUuDQo+IA0KPiA+ICsJaWYgKElTX0VSUihwcml2LT5ibF9k
ZXYpKQ0KPiA+ICsJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgUFRSX0VSUihwcml2LT5ibF9k
ZXYpLA0KPiA+ICsJCQkJICAgICAiRmFpbGVkIHRvIHJlZ2lzdGVyIGJhY2tsaWdodFxuIik7DQo+
ID4gIA0KPiA+ICAJZm9yIChpID0gMDsgaSA8IHByaXYtPm5iX2xlZHM7IGkrKykgew0KPiA+ICsJ
CXN0cnVjdCBkZXZpY2UgKnN1cHBsaWVyID0gcHJpdi0+bGVkc1tpXS0+ZGV2LT5wYXJlbnQ7DQo+
ID4gIAkJc3RydWN0IGRldmljZV9saW5rICpsaW5rOw0KPiA+ICANCj4gPiAtCQlsaW5rID0gZGV2
aWNlX2xpbmtfYWRkKCZwZGV2LT5kZXYsIHByaXYtPmxlZHNbaV0tPmRldi0+cGFyZW50LA0KPiA+
IC0JCQkJICAgICAgIERMX0ZMQUdfQVVUT1JFTU9WRV9DT05TVU1FUik7DQo+ID4gLQkJaWYgKCFs
aW5rKSB7DQo+ID4gLQkJCWRldl9lcnIoJnBkZXYtPmRldiwgIkZhaWxlZCB0byBhZGQgZGV2bGlu
ayAoY29uc3VtZXIgJXMsIHN1cHBsaWVyICVzKVxuIiwNCj4gPiAtCQkJCWRldl9uYW1lKCZwZGV2
LT5kZXYpLCBkZXZfbmFtZShwcml2LT5sZWRzW2ldLT5kZXYtPnBhcmVudCkpOw0KPiA+IC0JCQli
YWNrbGlnaHRfZGV2aWNlX3VucmVnaXN0ZXIocHJpdi0+YmxfZGV2KTsNCj4gPiAtCQkJcmV0dXJu
IC1FSU5WQUw7DQo+ID4gLQkJfQ0KPiA+ICsJCS8qDQo+ID4gKwkJICogQkwgYW5kIHRoZSBMRUQg
YXJlIHRoZSBzYW1lIGRldmljZSBpZiBpbnN0YW50aWF0ZWQgdmlhDQo+ID4gKwkJICogZGV2bV9s
ZWRfYmFja2xpZ2h0X3JlZ2lzdGVyKCkNCj4gPiArCQkgKi8NCj4gPiArCQlpZiAoc3VwcGxpZXIg
PT0gZGV2KQ0KPiA+ICsJCQljb250aW51ZTsNCj4gPiArDQo+ID4gKwkJbGluayA9IGRldmljZV9s
aW5rX2FkZChkZXYsIHN1cHBsaWVyLCBETF9GTEFHX0FVVE9SRU1PVkVfQ09OU1VNRVIpOw0KPiA+
ICsJCWlmICghbGluaykNCj4gPiArCQkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCAtRUlOVkFM
LA0KPiA+ICsJCQkJCSAgICAgIkZhaWxlZCB0byBhZGQgZGV2bGluayAoY29uc3VtZXIgJXMsIHN1
cHBsaWVyICVzKVxuIiwNCj4gPiArCQkJCQkgICAgIGRldl9uYW1lKGRldiksIGRldl9uYW1lKHN1
cHBsaWVyKSk7DQo+IA0KPiBbU2V2ZXJpdHk6IEhpZ2hdDQo+IFRoaXMgaXMgYSBwcmUtZXhpc3Rp
bmcgaXNzdWUsIGJ1dCBjb3VsZCB0aGlzIGRldl9uYW1lKHN1cHBsaWVyKSBjYWxsIHRyaWdnZXIg
YQ0KPiBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2U/DQo+IA0KPiBJZiBhbiBMRUQgY2xhc3NkZXYg
d2l0aG91dCBhIHBhcmVudCBkZXZpY2UgKHdoZXJlIHBhcmVudCA9IE5VTEwpIGlzIHBhc3NlZA0K
PiB0byBkZXZtX2xlZF9iYWNrbGlnaHRfcmVnaXN0ZXIoKSwgc3VwcGxpZXIgYmVjb21lcyBOVUxM
Lg0KPiANCj4gU2luY2UgZGV2aWNlX2xpbmtfYWRkKCkgdW5jb25kaXRpb25hbGx5IHJldHVybnMg
TlVMTCB3aGVuIHRoZSBzdXBwbGllciBpcw0KPiBOVUxMLCB0aGUgZXJyb3IgcGF0aCB3aWxsIGV4
ZWN1dGUgYW5kIGRldl9uYW1lKHN1cHBsaWVyKSB3aWxsIHBhbmljIGJ5DQo+IGRlcmVmZXJlbmNp
bmcgTlVMTC4NCj4gDQo+ID4gIAl9DQo+ID4gIA0KPiA+ICAJZm9yIChpID0gMDsgaSA8IHByaXYt
Pm5iX2xlZHM7IGkrKykgew0KPiA+IEBAIC0yMjksMjYgKzIzMCw2OCBAQCBzdGF0aWMgaW50IGxl
ZF9ibF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAJCW11dGV4X3Vu
bG9jaygmcHJpdi0+bGVkc1tpXS0+bGVkX2FjY2Vzcyk7DQo+ID4gIAl9DQo+ID4gIA0KPiA+ICsJ
cmV0ID0gZGV2bV9hZGRfYWN0aW9uX29yX3Jlc2V0KGRldiwgbGVkX2JsX2Rpc2FibGUsIHByaXYp
Ow0KPiA+ICsJaWYgKHJldCkNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiANCj4gW1NldmVyaXR5OiBI
aWdoXQ0KPiBEb2VzIHJlZ2lzdGVyaW5nIHRoZSBsZWRfYmxfZGlzYWJsZSBhY3Rpb24gaGVyZSBj
cmVhdGUgYSByYWNlIGNvbmRpdGlvbg0KPiBkdXJpbmcgZGV2aWNlIHJlbW92YWw/DQo+IA0KPiBC
ZWNhdXNlIGRldnJlcyBhY3Rpb25zIGV4ZWN1dGUgaW4gTElGTyBvcmRlciAocmV2ZXJzZSBvZiBy
ZWdpc3RyYXRpb24pLA0KPiBsZWRfYmxfZGlzYWJsZSgpIHdpbGwgcnVuIGJlZm9yZSB0aGUgYmFj
a2xpZ2h0IGRldmljZSBpcyB1bnJlZ2lzdGVyZWQuDQo+IA0KPiBUaGlzIG1lYW5zIGxlZF9ibF9k
aXNhYmxlKCkgdHVybnMgb2ZmIHRoZSBMRUQsIGJ1dCB0aGUgYmFja2xpZ2h0IHN5c2ZzIG5vZGVz
DQo+IGFyZSBzdGlsbCBhY3RpdmUuIENvdWxkIHVzZXJzcGFjZSB3cml0ZSB0byB0aGUgYmFja2xp
Z2h0J3Mgc3lzZnMgYnJpZ2h0bmVzcw0KPiBhdHRyaWJ1dGUgZHVyaW5nIHRoaXMgd2luZG93LCB0
dXJuaW5nIHRoZSBMRUQgYmFjayBvbiBqdXN0IGJlZm9yZSB0aGUgZHJpdmVyDQo+IGlzIHJlbW92
ZWQsIHRodXMgbGVhdmluZyB0aGUgaGFyZHdhcmUgcG93ZXJlZCBvbj8NCg0KLS0gDQpBbGV4YW5k
ZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K
