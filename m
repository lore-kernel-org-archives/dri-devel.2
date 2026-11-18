Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C75C606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 11:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=selector1 header.b=ql0leM0Q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 080EC10FAFF;
	Wed, 18 Nov 2026 11:10:22 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012052.outbound.protection.outlook.com
 [40.93.195.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E2A110FAFF
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 11:10:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1RcN00PTErHTYMXhKM22vu+cNt6ubSFOfKE/SzrcLnCLoVU6EIRKnkSbATr3EqhWXt5CLuJdQ11K8IsOKMTtNrT1ClLJTGJI+TuidoYNN5h1Lbw/fD7jGS+9I1+plZwyGwdvIFJ7tUoeN+8Mjw7tmW58xq1Go9hdw2ngpH24Le9IKPehuvWX9syBj+I7WhYQIghzz60fZEibPy3Y+tA5hvkCfpJE/f+/eIED0aIWsGzfGlyRB1OjSS47J8rGR5eCWIYFudOnaRxW0n9NJWSVQeJQHHVZ+GOx4xqZ4W8E7VtmLVspg53ARGBzJO03+mLylTiMR/R7imuZRCoRl+hxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0m7rov7o9LUK+IBKpyihzyFmmxt551kkMJcWVrVV1tA=;
 b=lGSLvyFZlkJEyEAeXmnzsMEKipU8h5Wx1gZbXW9SvJ/T9ic2vWGnHjhJfROPv0yhoGGi9CSx6/YzqoSq3+vHPpTr/X56nB7B03vRUJ3kQWC9zXZHcC4OFbR3ZMoNkOcrjO2YXtUYtFu28RGJZOrZXZrqNoYtKtridkbn/+kgOASnWRqJr2ZLVavChIB3nuHdzKa5aHC0nMQQxcGTXy8uU7dXJ4FVekFK5j0cmr6Nj/1ZJuMGq2TR1780iqPU/OTfcmkE4L+KshrAu65GJ0UpldJS9VRmXHRgwq3z61ywLFjTfMVvO0Y8lV7WfCjO0a3/5btgAdMZbdm4VVhlMaWyjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0m7rov7o9LUK+IBKpyihzyFmmxt551kkMJcWVrVV1tA=;
 b=ql0leM0QmFObJKxgL3A0NRybSXR2yeGxEO0P15xcARGpSlBtIz7i2SyNXuBsopVNOVwtBqj1YYNb1gQCxTRuwCSisbER7TXmkXhSaOWzzhjc1L087oSvXeeog0xR5I/e32M9k17/zWACw8CI8uzWu/MRZODOo21+539PrmaiccGQ1O40sIbY6FCBP7sf4npvXT81sWM4d8q5k0PgpKvOoyXFDFWoopJXNbUfDv8kGawSxeaImVMfiMZ0+nKldnaW7MX9a08PIysRlNfXjNnfkD8yansqvxuYea4yE9UcWPy/UCeC8IEx9lR0jgAZ8wsLsI/Y2vbrUbAzKkkbl7PCZQ==
Received: from DS4PR11MB973201.namprd11.prod.outlook.com (2603:10b6:8:4f0::10)
 by DS4PPFEC77118F8.namprd11.prod.outlook.com (2603:10b6:f:fc02::5e)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 11:10:08 +0000
Received: from DS4PR11MB973201.namprd11.prod.outlook.com
 ([fe80::8f9f:b5f1:1a02:a8b7]) by DS4PR11MB973201.namprd11.prod.outlook.com
 ([fe80::8f9f:b5f1:1a02:a8b7%7]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 11:10:08 +0000
From: <Conor.Dooley@microchip.com>
To: <pengjunhao409@gmail.com>, <neil.armstrong@linaro.org>
CC: <dri-devel@lists.freedesktop.org>, <jesszhan0024@gmail.com>,
 <mripard@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>
Subject: Re: [PATCH v3 0/3] drm/panel: ilitek-ili9881c: add Industio Purple Pi
 OH panel
Thread-Topic: [PATCH v3 0/3] drm/panel: ilitek-ili9881c: add Industio Purple
 Pi OH panel
Thread-Index: AQHdd0OJHg/cFczmsEC0ZfRaTYG3tbczrDYA
Date: Wed, 18 Nov 2026 11:10:08 +0000
Message-ID: <7ab3275a-0f40-429d-90a2-bffa9da67a15@microchip.com>
References: <20261118095905.127658-1-pengjunhao409@gmail.com>
In-Reply-To: <20261118095905.127658-1-pengjunhao409@gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PR11MB973201:EE_|DS4PPFEC77118F8:EE_
x-ms-office365-filtering-correlation-id: e8232456-c7fd-48ed-a0fc-08df4564819a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|23010399003|366016|22082099003|18002099003|261009223027099003|11063799006|56012099006|261026140227099003|261026121527099003|261021121427099003|261022075727099003|261022105027099003|261028144727099003|261102123227099003|261102124527099003|10067099003|38070700021;
x-microsoft-antispam-message-info: otmqy1SrvAHg6eRce9xLaGetmydC2vX3mR4eGF1VbwgXv/kULZMm1Do2uyhTvIlXWVWhEMcmKh43Sm0DSllQB7eUg55UbYlyp49HSn0pTd5+8P9qK3Fqs0/owJ53Ug9c7+4TEyHyn5HJLDaNTGJT2RWBz7SM7cNffqFQg6OFmMIavrJa4gU3Tw1Nzffsdr/5tcPrs7csAehwO0CZw1C6ChnGqX+Q1g/bIb4V3RZKoXMdY6ZRW8uV5NSL70JFRSQepbah7U/QEBeIeO0Zy/pJiRfB8QblSUndcLdwSiRGQtyyBdUaktL4VqMBetsM5SlSY3qAgh/ZD9SaPL8vyx8j78MialKINidQAart0MTCwSZbnptjB6M4YYjU2WrfMth+EwoPAO0ve2kHyOY6RG3ORJrefspq9GEIAA5wkATGpD/pD6+6IbHFpUP7CI7F/PG8ocAC0z8+jSrt2g+M3b76wsvhFszFenQDUB52L3SRxMUj+pPrh/6g/ax+TKSZF8ehbiudwZ+tiD7Et1MJy+0mzR1h9EZFGX6V0f0bl1HNfqtUTmGqkTEIrPi5JPKO0pa4Qq2MSRDmO8ImVhczX94ZGTqxrhs3tIb3prW0DWMYKlhszvShTdyMcjn9K6ne4+lubk/lPid1gCFZWk+Q0FEbT3b5O48C2kKIlnS2X80G0qJBvKeJHoEFybjjsCSXpjifIxQxgk8BBU/2SUitBZDDWtfSu95CapaiKp7snfo7kY4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PR11MB973201.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(11063799006)(56012099006)(261026140227099003)(261026121527099003)(261021121427099003)(261022075727099003)(261022105027099003)(261028144727099003)(261102123227099003)(261102124527099003)(10067099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDQzYmk5S0tWakdQWkdBMDdBL0t0dnRsY0UxanRIZG52cDdQNVdPUWxKaS94?=
 =?utf-8?B?WkV3UVpQdVF5bGhiL1R1WTM5b21ta1EyMzVMcFFIZmJZeXhlNTg1QkRxSGNJ?=
 =?utf-8?B?eVlPWElQTUdSakNQUStMZ2R6WDAwYnhWdE9ldEpnMEszR29YVHd0Q1pva3V1?=
 =?utf-8?B?Ti9LNEJIWUlBcFFaSVlrSkg0Q3ZxWnd0ZkxKSm9IRUhCcDhSSHorTFM2QkFk?=
 =?utf-8?B?cEF0ZHBvelU3eUdNUU05RHp2bHloNmozdW9jTlpGR3FqUU5TSSt6WXRiZDlY?=
 =?utf-8?B?UlBISjlxamU1SjJacmh0Q1BxT0ttcGVXMFZDb0xzbHkvRENQTEFFc2hkTEhs?=
 =?utf-8?B?Yzd3RDlCdStVU0lRL0ZzQ0JxK05ubWhmZDliUWs4clFYQytJYkc5YTRabTlE?=
 =?utf-8?B?ZEYrT3pzR3lwbzZoYmtzNEVtY2JKRi9RMnJyeWpWUC9LYm41VVh5Wk9xSjA1?=
 =?utf-8?B?U1paSzZYNXdRVmRCdURha29IYU1TL3dPa2N4RVRKeXlaejJDbHRRVUdoRkQ3?=
 =?utf-8?B?bDl5NkRJZ25qRENFRVc1OFhwSXN5VnNVTkNveE0zQTVIeXowYlFUNXdXdlJP?=
 =?utf-8?B?M0I0VVVQbEkwTW5DZU9ka0orVjZyYnExTDcwbGNDbTl5ZlpNazh3dXIxTk5O?=
 =?utf-8?B?eHdKT3pJcEhWdjJiYVY1K2dkMU5GZ2hEelBhUEgwU0JjWjFJZVNZMHZjQUsv?=
 =?utf-8?B?aGVCWHhoOXBld1FYaDg5Sjl6aHQ5bTRrSXJWTU9oOTV6SHBieWZQSys4WUgy?=
 =?utf-8?B?QngyWWNKaEhZdk1uUzVGdzkyZGhsWTEwWENNV3Y1L3NjTkhxRGZCdmd3bkFl?=
 =?utf-8?B?RU5PMTVpVnc3cWFLYzA2NkhXUWpBS01HQW9GemhYTUEwclVocEFHWi9lNEJU?=
 =?utf-8?B?T2FYTXFBZ2pDck96REs4T0dBK0FwZkdaU0NBMURMdlhPblNKWWo5cjJlWU9a?=
 =?utf-8?B?OXFRaE1KRTRFYXRuYnp2TVBrSVpoRCtzUUN0NXUyVkNIeVJWckZyandvUGtS?=
 =?utf-8?B?N2FMdnJaaW14VEVYa3RndUVuQTdNdUxFMEFzZlNFNGlNelVKVXAzUU02M0JE?=
 =?utf-8?B?Um1jbVBHOXVPY3MwUGtkM1ZaN0paTnVVOHorSzFJWGhYVHpyQnZjb0o1ak15?=
 =?utf-8?B?Vi9ZZEVLa0Jtc2V2Y1VhVUlET2x2LzFmN0ZQUmdQbExiYVdVQmJwM2NVRUZR?=
 =?utf-8?B?ZHdRNldnQWovZTJoRXRvekNXVURxcXNhOFVlU0tpM0dDM2FiSGRWalRJSnJ6?=
 =?utf-8?B?Q0d0bVZ6eitTVktlZVhBUlZVQ2pwWUxhM0l0Qi9razkrMXVXWGM2OE0wcUpS?=
 =?utf-8?B?dGpqaDdMNFdjRVc3V1JKMzY4QXMwUEhnOTJJM1oyem9lWHJ4ZjVpYzJpOWZ5?=
 =?utf-8?B?aHVOMGczTjVWcmZQcHFMVlB6czI0c0VYSVlydk15U2F2aEtjcmZXTDF2bmFR?=
 =?utf-8?B?d2t4TTR0MmtKTWxEMHpMR1h2SEpCc25ZUDQ5b3BqYnBsTUVYdVFkNGtzUXRT?=
 =?utf-8?B?K1JJandjL0FEc01WWE9xcW42QzcvSDBzb0o1M1BkUHEvZ20vekFoc3V0aUJO?=
 =?utf-8?B?YTY4Vm90V09KSHZ6TmtXUmRxRXNET0JmNlprdkZKbThVSjN4b0JqSXNxOER2?=
 =?utf-8?B?T1pieEZVd0RUdEZlS1JZamUxeU4zSXhNb0xVZm9vVjRMZWlYVi9LMXRXTGdn?=
 =?utf-8?B?Q1p6UFVlVERCN3dGeXZxK0szOHFycTIwVEgvWGk1aWlzNHNDdG00ekhNRmlr?=
 =?utf-8?B?cEtCNVV6MkdTRW9aQnBNMlE2TDl3R2J0cm1Lc1E0aDR2U1N5c05xazdXSDdt?=
 =?utf-8?B?OHVaRDFZVkd4K1JYTXRkdGt2cGRRdlFaQVZXSElpM2hzYXJ0bkkvOWI3UUdq?=
 =?utf-8?B?ZEZZdXFKeXpnZlR6Z0s0L3ZCVnhlOWovQ2dVTU1YaDA5ZHZ1N2FIWE8wM0pw?=
 =?utf-8?B?N2hHZnZsQ1ZRdjgvU1UxR21QL1ZCdkZQTy9CTThDZnd3cVR6d2o5RVFxSmsv?=
 =?utf-8?B?K1RKZ0pqUmFBNmhTSVdDVHlGSGtVZGhOWnVmd1A1UENkQmRqUTNnNGZUSHBt?=
 =?utf-8?B?bFo5ZVNUZXgzb1Y3R2pwM0FGRkNGcUhRY1lNaGxkUjRoMHRPNjBTblhXTTJw?=
 =?utf-8?B?SWNGbFB0M2JBZC9pcGw5TWJXM1ZSK0h6azEveEYycm0zY2NjZlQ4TTFOTVdt?=
 =?utf-8?B?dlFmVWFta2p4S3hhUStQWW5RQ0x5WWNPYnBzb09pcmpFMG5MY0JMdEpTOW5r?=
 =?utf-8?B?ZzJrU1BFMisvd1JLMjlhU1FvNTVoMUVtMVQ4SmhlZXVxMHJPazl6OFRkcVNz?=
 =?utf-8?B?dE5uZXBvbUhTaDhlOXZFaVdFTWdOOHV0S1dyejYzNEJEeGEzNTNpNGV5b2N4?=
 =?utf-8?Q?7IqkMNh3GdbQJWhY55pnpMY/qSQt9+DeOrX7DIDHw2XCV?=
x-ms-exchange-antispam-messagedata-1: /xp1pzlpzvpzAQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <58AC9312AED1B44295F3D1CEB99D7310@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PR11MB973201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8232456-c7fd-48ed-a0fc-08df4564819a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 11:10:08.2994 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YvbPgkyPaXpNE26Ww73hl+oMt1g1lauxA/qne/dEYF/C/cCVDgGDAUApQyJyQdIINHzNCAtMSGTs+h0J6RG/NobrjYGzL19k69eSbSKgFGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFEC77118F8
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gMTgvMTEvMjAyNiAwOTo1OSwgcGpoNDU2IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBj
b250ZW50IGlzIHNhZmUNCj4gDQo+IFRoaXMgc2VyaWVzIGFkZHMgc3VwcG9ydCBmb3IgdGhlIDct
aW5jaCA4MDB4MTI4MCBJTEk5ODgxQyBwYW5lbCB1c2VkIG9uDQo+IHRoZSBJbmR1c3RpbyBQdXJw
bGUgUGkgT0ggKFJLMzU2NikuDQo+IA0KPiBQYXRjaCAxIGFkZHMgdGhlIFNoZW56aGVuIEluZHVz
dGlvIFRlY2hub2xvZ3kgdmVuZG9yIHByZWZpeC4gIFBhdGNoIDINCj4gYWRkcyBhIGJvYXJkLXNw
ZWNpZmljIHBhbmVsIGNvbXBhdGlibGUgd2l0aCBpbGl0ZWssaWxpOTg4MWMgYXMgdGhlDQo+IGZh
bGxiYWNrOyB0aGUgbW9kdWxlIGlzIG1hcmtlZCBaQy03MDAwMTBCSCBhbmQgaGFzIGEgOTR4MTUx
IG1tIGFjdGl2ZQ0KPiBhcmVhLiAgVGhlIHZlbmRvciBkZXZpY2UgdHJlZSBvbmx5IGRlc2NyaWJl
cyBpdCBhcyBhIGdlbmVyaWMNCj4gInNpbXBsZS1wYW5lbC1kc2kiLCBzbyBubyBwYW5lbC12ZW5k
b3IgY29tcGF0aWJsZSBpcyBrbm93bi4NCj4gDQo+IFBhdGNoIDMgYWRkcyBhIGRlZGljYXRlZCBk
cml2ZXIgZW50cnkgd2l0aCB0aGUgdmVuZG9yIGluaXRpYWxpc2F0aW9uDQo+IHNlcXVlbmNlLiAg
VGhlIGV4aXN0aW5nIGFtODAwMTI4MGcgZW50cnkgKGFub3RoZXIgNy1pbmNoIDgwMHgxMjgwDQo+
IElMSTk4ODFDIHBhbmVsKSB3YXMgdGVzdGVkIG9uIHRoaXMgaGFyZHdhcmUgYW5kIG9ubHkgbGln
aHRzIHRoZQ0KPiBiYWNrbGlnaHQgd2l0aG91dCBhIHBpY3R1cmUsIHNvIHRoZSB2ZW5kb3Igc2Vx
dWVuY2UgaXMgcmVxdWlyZWQuDQo+IA0KPiBUaGUgcGFuZWwgaXMgcmVzZXQgdGhyb3VnaCBHUElP
MF9ENiBhbmQgaXRzIGJhY2tsaWdodCBpcyBkcml2ZW4gYnkgUFdNNC4NCj4gT24gaGFyZHdhcmUs
IHRoZSBwYW5lbCBwcm9iZXMgYXMgRFNJLTEgOTR4MTUxLCBtb2RldGVzdCByZXBvcnRzIHRoZQ0K
PiBleHBlY3RlZCBtb2RlLCBhbmQgdGhlIGdlb21ldHJ5IHRlc3QgcGF0dGVybiBpcyBjb3JyZWN0
Lg0KPiANCj4gVGhlIGJvYXJkIERUUyB0aGF0IHVzZXMgdGhpcyBjb21wYXRpYmxlIGlzIHBhcnQg
b2YgYSBzZXBhcmF0ZSBQdXJwbGUgUGkNCj4gT0ggYm9hcmQgc2VyaWVzLg0KPiANCj4gQUkgYXNz
aXN0YW5jZTogcGFydHMgb2YgdGhpcyBzZXJpZXMgd2VyZSBkcmFmdGVkIHdpdGggQUkgY29kaW5n
DQo+IGFzc2lzdGFudHMsIHVzaW5nIHRoZSB2ZW5kb3IgZGV2aWNlIHRyZWUgYXMgaW5wdXQuICBB
bGwgY2hhbmdlcyB3ZXJlDQo+IHJldmlld2VkLCBidWlsdCBhbmQgdGVzdGVkIG9uIGhhcmR3YXJl
IGJ5IHRoZSBzdWJtaXR0ZXIsIHdobyB0YWtlcyBmdWxsDQo+IHJlc3BvbnNpYmlsaXR5IGZvciB0
aGUgY29udGVudC4NCg0KUGxlYXNlIHN0b3Agc2VuZGluZyBtZSBvZmYtbGlzdCBlbWFpbHMuIEJp
bmRpbmcgcGF0Y2hlcyBtdXN0IGdvIHRvIHRoZQ0KZHQgbWFpbGluZyBsaXN0Lg0KQWxzbywgc2Vu
ZGluZyAzIHZlcnNpb25zIGluIDIgaG91cnMgaXMgbXVjaCB0b28gcmFwaWQuIEZpZ3VyZSBvdXQg
dGhlDQpsaXN0cyBhbmQgc2VuZCB2NCBvciAidjMgcmVzZW5kIiB0b21vcnJvdy4NCg0KVGhhbmtz
LA0KQ29ub3IuDQoNCg0KPiANCj4gdjM6IHJlc2VuZCBhcyBwamg0NTYgPHBlbmdqdW5oYW80MDlA
Z21haWwuY29tPi4gIFRoZSB2MiBwb3N0aW5nIHVzZWQgdGhlDQo+ICAgICAgMTQ3MTQ4MzgzQHFx
LmNvbSBhZGRyZXNzIHRocm91Z2ggR21haWwncyBTTVRQLCB3aGljaCBpcyBub3QNCj4gICAgICBE
TUFSQy1hbGlnbmVkLCBzbyBpdCBuZXZlciByZWFjaGVkIHRoZSBsaXN0cy4NCj4gdjI6IGFkZCB0
aGUgdmVuZG9yIHByZWZpeCB0byB0aGlzIHNlcmllcywgZHJvcCB0aGUgcmVkdW5kYW50DQo+ICAg
ICAgd2lkdGgtbW0vaGVpZ2h0LW1tIHByb3BlcnRpZXMgKHRoZSBkcml2ZXIgc3VwcGxpZXMgdGhl
IHBhbmVsDQo+ICAgICAgZ2VvbWV0cnkpLCBhbmQgcmVtb3ZlIHRoZSBub24tc3RhbmRhcmQgQXNz
aXN0ZWQtYnkgdGFncyBmcm9tIHRoZQ0KPiAgICAgIGNvbW1pdCBtZXNzYWdlcy4NCj4gDQo+IHBq
aDQ1NiAoMyk6DQo+ICAgIGR0LWJpbmRpbmdzOiB2ZW5kb3ItcHJlZml4ZXM6IGFkZCBTaGVuemhl
biBJbmR1c3RpbyBUZWNobm9sb2d5DQo+ICAgIGR0LWJpbmRpbmdzOiBkaXNwbGF5OiBwYW5lbDog
aWxpdGVrLGlsaTk4ODFjOiBhZGQgSW5kdXN0aW8gUHVycGxlIFBpDQo+ICAgICAgT0ggcGFuZWwN
Cj4gICAgZHJtL3BhbmVsOiBpbGl0ZWstaWxpOTg4MWM6IGFkZCBJbmR1c3RpbyBQdXJwbGUgUGkg
T0ggcGFuZWwNCj4gDQo+ICAgLi4uL2Rpc3BsYXkvcGFuZWwvaWxpdGVrLGlsaTk4ODFjLnlhbWwg
ICAgICAgIHwgICAxICsNCj4gICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy92ZW5kb3ItcHJlZml4
ZXMueWFtbCAgfCAgIDIgKw0KPiAgIGRyaXZlcnMvZ3B1L2RybS9wYW5lbC9wYW5lbC1pbGl0ZWst
aWxpOTg4MWMuYyB8IDIyMiArKysrKysrKysrKysrKysrKysNCj4gICAzIGZpbGVzIGNoYW5nZWQs
IDIyNSBpbnNlcnRpb25zKCspDQo+IA0KPiANCj4gYmFzZS1jb21taXQ6IDdlMTM5MmE0MmVhMjg4
ZDcwYTI2NmY2NTUzZmUwNmY1N2Y4NjQ3ZWENCj4gLS0NCj4gMi41Ni4xDQo+IA0KDQo=
