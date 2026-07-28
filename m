Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6407C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 22:38:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DB94882D0;
	Tue, 28 Jul 2026 22:38:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="FSfU0/ZJ";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11023122.outbound.protection.outlook.com
 [52.101.83.122])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E756710E621
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 22:38:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rbpFZ4wl2JwpTjS01puOpPzbsTgIifnmF4nlhb/6kJu9llHNZ1gq+zJKmgnZIbn+Tl/mp/j86qbAM5WA0Kw8Igkolzh6qqnW0FHyUA7gpJRnBEiy3vAgShXSpv6Qu9I0XyzMdhfLCk0uTrgC7ybPfwV2cSkZywve4VNxyEemDwvD6pHwVCQMBIQxT8ne0gRdSLx440v38Ra0xKdZvZ0Cx1M9hQGRNvSkgv6FAAuTtq3sPQlh5Z7ML33UMSZfERY8OSHPyks7T/5OvcV9H5GU7zASCTlCNjs+Bs5MuyCX7Ad4zX+4aOv4V8EYedD/P+oKoT2b/sbDqjlmFjW5pdfJ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kq3Uy8CD0lNkFmhGRtui6rw53TU5wpTpdvK7/y12dSc=;
 b=aU5xsT0phL12tVMR+f99tlx7n/tX5kPV2g0QHBHs8pBN1RJdr1icqQDctRnKcH5XX8NRrHp9qzH/pWf0MaL5ivzncUgDdU0tT66ohbW/zyCeNTooeaPW6Z7HwV8s08PB4GDAKhiZsfVkCmwG+cKMlpbsmZENwBYJenOzkFgJTCuCpYGmgNGFhqTbmc3FIzEutAkqpMfxvsbVYeZzJcpRryJTSpeOjVFoR28JHck44QwLf6LuJRZCCbaOUmFpf63Mop+kwovtLPGwxN3HY7tQNzx8Fl/tNiO3oUHUVJAMtDfPRLq8lXj4lcj44cD96daXCGFM/X2ZyZpOAqbL93UoRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kq3Uy8CD0lNkFmhGRtui6rw53TU5wpTpdvK7/y12dSc=;
 b=FSfU0/ZJx6IuteK3IqESEIqWH+igPFzT89r6iT2IEz1LtrNwv9nD5urxZ5rNOW6P67QGVix1D9XJ9naGBuzoPfrydhoGwYEzp3//AK+eclMQnLQk/JW/XCKPYL0ViiQUsbqeH7LBbI1Ry9oHAShjRMlhoQGJOBTulv0zhDRXkfwO66cZCKZk+U1v1xhpef0AjnoRjZ7js3jCu19F2h8Ey2B55uUmyyL75chKC4/agNTyiNAqHxJOCQRHG1Pp+UzywurU1TEMMdjc3gYZ7Fefq5LFv2N5hq5j45cksjFxRolMoTSDj5uq8T8oizhTPNMut93Jn4zc/sh6b4gfq4PbCw==
Received: from AS5P195MB3381.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:753::12)
 by VI0P195MB2573.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:215::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 22:37:59 +0000
Received: from AS5P195MB3381.EURP195.PROD.OUTLOOK.COM
 ([fe80::9db1:9521:64ef:f6e8]) by AS5P195MB3381.EURP195.PROD.OUTLOOK.COM
 ([fe80::9db1:9521:64ef:f6e8%5]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 22:37:58 +0000
From: Dominik Haller <d.haller@phytec.de>
To: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "y-d@ti.com" <y-d@ti.com>
Subject: Re: [PATCH v5 0/2] Add no-hpd property to the cadence bridge
Thread-Topic: [PATCH v5 0/2] Add no-hpd property to the cadence bridge
Thread-Index: AQHdHpE/id4xDEumdEiuUX9RDy0JY7aDhlaA
Date: Tue, 28 Jul 2026 22:37:58 +0000
Message-ID: <074a97451488f0e6d41afe968e9248399dffa88e.camel@phytec.de>
References: <20260728125336.776116-1-y-d@ti.com>
In-Reply-To: <20260728125336.776116-1-y-d@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS5P195MB3381:EE_|VI0P195MB2573:EE_
x-ms-office365-filtering-correlation-id: 21557548-5292-4a0b-9867-08deecf8e01a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10070799003|56012099006|10067099003|11063799006|6133799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: lD1ULZ0uWx0OE88I+hIRBDK1AmtfrtXh8YMtpYUZQE5DqNYW+8GnH67ZjsW9rUBC3bz4xs/HYX00dN/Pa2hZr3cPoKqdpAPfYjjK0qapcogONBB3Y/RAgJFL+qAiwi6RCMa0XEDBma3nlh2qnM+R42TeYt5d94XBhMYIw+g/CDq4GskioOSqQQotfCfbuI1Q3J373eJmP/TXE8Bk26frNtxF386twmPSOFNEcF9O8/u7Xd339cTcPxIqUAA0YhC8ZSh5iVO8qGMRi+I+XA9FcwZrMBBUERKL3RIH5W3ysJC3IzwoXY7M4M+/edj0MTx5/WlC7crUUHQhRveesxbWpNv/kHv4LQQfPqkz0BcS26W1pgd6PcScug6612tQ7wnV+qx7l/5mpMl60q5YFiQmxmMM/YuJP1l8JZuYCNDL/MVXru/pc4VaGY7CJJ0jdsgBfKfM4nOQYInpZ41PEF8u+Vo3ha4GZwVU9ljTi0ojc8lr/Ez7boUIoBTTWrDSz/4Z4ZNUYaJ/pSvbS5Y+KBwvEXC0K7lVIeKqZM5aCQJvDlx50AishnuUG/gCfaj8QHN7BNfdt/jpY9WB5vpXU3TTHj7/3MC4jf09pONCSTqZDQGbIBmwvL9Ck1g13rNcu6CyfLQe+fdSOlVNKLkE69Nc9rX4D9xaSTWFThp2nujB+10gaNmAcuxkISRvkv+IsXZowBkRXIcmlbbB5wHK2ctpSQoJXFZWxwY9KLmBb/H/RMM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5P195MB3381.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10070799003)(56012099006)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXhqU0s3R3FBVkNIS2JKTk0yWjZwZE1NWnhoYWluRW55bzdFTUNRUVZqN2M2?=
 =?utf-8?B?ckRvRE44RFlNVmlUZStyOGY1UjVJTEg0MzNwRFllRjJ2T0licTREemhPZTZh?=
 =?utf-8?B?Z01NVzhQSno0NHMwNVpKYmpCZjZaOXcvR0oyb3RVbnduVm9RM1NJMWNFK3A2?=
 =?utf-8?B?NWt4WE03dEN6Q2Rqc2RicmhzMkRoMWhLMDZQcnhFZFdlQ3UyNXo2ZWpvS1Vu?=
 =?utf-8?B?SkttZ2dlenRSbE5WaVhFSFpSaVM4NE93aG1EOGhjWWtHWkVremt3ZEhxZjF1?=
 =?utf-8?B?N2o4ejU0S0hUMXNzb2NHV09UK1BoM3J1clNldWtlWi9jUk1IU29HQkpSYW9Y?=
 =?utf-8?B?UmdldEVZUzB1YWdTdDJMTEFlbTVjekpQUVlKNWtKNUtxeTk5Wk5wdk13T3po?=
 =?utf-8?B?Ykt5MFJIZHFrZ1QvWldzTHVGVXRzRlArV2FKZGI2aWw4Mm94OVA4V05vUG5L?=
 =?utf-8?B?YnRaRTk1MDgwbmZqSHFmeDB0Wjd6U3V2a2s2eEdabnQwOGZaS2h5OGhlT0Yz?=
 =?utf-8?B?S1pSdVVDMlpkcTI0RzdqTlZHeFBhTVJ1cy9kSW1tTi9ka0JPSC9Hb21KZTda?=
 =?utf-8?B?VXB3czQxVjhsdEo1YlhtTnpaWmIxZUtySEp1SlkyRWZsdnZpVEpYV3RtbTNK?=
 =?utf-8?B?OGE1ZVZjSUZ3RVBzNjlXeWMwYXpYKzRJOFVhb0w4c1YwWUMvamc3cDBxVHQr?=
 =?utf-8?B?bE1aK0huVjJtTmJqQUdEalN0Y2hPQWt5aG8yUXhTNnIvODlQUWl0YUxhYm00?=
 =?utf-8?B?YkJ3enFuRk0zR3Y2RXhkOHhWdUxMcjM3dHZ1ZTViYnVHellCU0p1QlpTSkkr?=
 =?utf-8?B?ZS9FTCtDOXZ5Zm5DWUhCVVhuOHYwL0tvMGdodzRieWdHTC9yU1VjTFZaRW5V?=
 =?utf-8?B?dFZYMXlYM1poSnFXZ3NKYkdIK1pHRGNuSDhybzc3dkU2d0tKamZxTkNJT3B2?=
 =?utf-8?B?NVV3dCs1UW5nNE5SMjVlVmhNWmd6cVpLRXR1SStGRHNJZWNNMFpDQmYyc3dO?=
 =?utf-8?B?K3M3Ni9UT1YwdXZ6ZFhWOGpyK1Y4dHZ1NTJLT1lZUFhFTktLZ0lTN2pjclVW?=
 =?utf-8?B?QWNWOTl4OFJHeU9vcEFhK1l5OUpHNzVvY3pnd1dRNGw3WUR0WEQxdW8zSWJa?=
 =?utf-8?B?a0FFeUtIMHM2bG5CQlA2K3NLSnVhaGZNU0xpM3BMRVZtTHhyUjhrcGJoMUsw?=
 =?utf-8?B?NnJRQWtJd1hrZk1nS1lBWFAvM1BTTWw0VllRRnFLek03bmhGbXIxaURFaFVl?=
 =?utf-8?B?S29qZ0hQa3hMU0NkWG9TaVN2UjBJMGNWeGFGcmVzRms4aVpYdXBqejk1QWt1?=
 =?utf-8?B?MWxPL0NxMmpTM0lMNEthbGw1ZTl1N0k4WndrZ2VCYXdFaXltdFVic2xyVGVx?=
 =?utf-8?B?L2s3cFZpanptTEJXZktHdCtQdXVkYmJOUzM4U2JVdmtQNVFyY1FqbmswQ0F6?=
 =?utf-8?B?cWdvQXcrQUptd0twVFVBVE1yb1Blc2hlYmplS3FWMWpOd0FsTzhIMi91dkF0?=
 =?utf-8?B?elhrbTh6Nkx6dU1BTHBEUzcwaERiS0V4dmpSR1YxK1dMTTU3SEljRjJ2cXIw?=
 =?utf-8?B?aXA0dDdRaENuMkxoN3dBcmNNZ0tPVFVmR1ZiSkZQUS92RWowWUE1YWpLZ0d4?=
 =?utf-8?B?SHpXbUxHM0R3M3BOdzJhdVdrdGNvNFMzMC9Ta3VMZkRpeHN2bkhZZ29TbXRR?=
 =?utf-8?B?a29WUGJIYnRsN2FHZU9XQVBGSWhET0RHSGRPUHkrMlV1YW15aktFUXFXbStS?=
 =?utf-8?B?Z3J2MHBRaVNTRFhsZytKdlRlTWRFSE5nSml2aW04b3hYWitXVFdQbkcxenBh?=
 =?utf-8?B?QWNnK1p5K2cxRkRIYUVnTHBMVy9Hb3BEYnNCaFFob1VPaGptTitYU2N6NGNk?=
 =?utf-8?B?U0VJOTAvQjZMMWNCTG5IeXk1VDM3cTN4c3B5N1p5L0poSE0zd2dyUTRTLy84?=
 =?utf-8?B?Q2UyMG5pTlBwT2laUGJxMDEyR2dzdGNTRXlMR0I1WElGT2xTaUtzU2cxeitW?=
 =?utf-8?B?UkhvcHd5Y1A0WTZ0czdnUnFkMkpTZi9ORkRkTDAxeVI2N3BaSUN4MWZlM1Jp?=
 =?utf-8?B?dVFUMngzUU0rbUUyT1ljeDJvekpIa2RNNURRUHNubGQ3UkpNMnBIN0ZFeXJ0?=
 =?utf-8?B?WGxMcGE2WElzRVJaQStGTmc1ZDJNbUt6V2ZaMzg5TWRnWnFDR2FYczZxUDVZ?=
 =?utf-8?B?R3NiTU9lSDdrUkZGbStNb2N6ekQ2OXhRTm4rTDVraHZxRTlBbWZxZGl5eU84?=
 =?utf-8?B?ZWtSRXptRnR5bG82SWNYbUhyTmNNQzU4YVpWYWVJWDVycTJQVWhaWXdpbzJS?=
 =?utf-8?B?bElTbkNuRGVPbCtibGlqUzBYeHg3MTRRSXllTVlkYThiS1YzTDI5eE5zVEsz?=
 =?utf-8?Q?Fo3E+iPnPc5UcsNWik61CSILg11hEeU3P7VAR6NzJ2Ldz?=
x-ms-exchange-antispam-messagedata-1: VWF0p1SOcQrMlA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <BDE14CBA5336F543A585956EF716729D@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS5P195MB3381.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 21557548-5292-4a0b-9867-08deecf8e01a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2026 22:37:58.8576 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KbWKNdm1/KR52OG4PiaYkaRdldXL3xCPm65nT+lpJ3zouyHVy0W+lmXynMsrqPgJ0fcavbWOQCh04JNPZglnWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P195MB2573
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

T24gRGksIDIwMjYtMDctMjggYXQgMTg6MjMgKzA1MzAsIFlhc2hhcyBEIHdyb3RlOg0KPiBUaGlz
IHNlcmllcyBhZGRzICduby1ocGQnIGRldmljZSB0cmVlIHByb3BlcnR5IHN1cHBvcnQgdG8gdGhl
IENhZGVuY2UNCj4gTUhEUDg1NDYgYnJpZGdlIGRyaXZlciBmb3IgYm9hcmRzIHdoZXJlIHRoZSBI
UEQgbGluZSBjYW5ub3QgYmUgdXNlZA0KPiBmb3INCj4gaG90cGx1ZyBkZXRlY3Rpb24uDQo+IA0K
PiBPbiBUSSBKNzIxUzIgRVZNcywgdGhlIEhQRCBzaWduYWwgaXMgcm91dGVkIHRvIFNvQyBwaW4g
QUEyNA0KPiAoTUNBU1AxX0FDTEtYL0RQMF9IUEQpLiBUaGlzIHBpbiBpcyBtdXhlZCB3aXRoIHRo
ZSBNY0FTUDEgYXVkaW8gYml0DQo+IGNsb2NrOyBzZWxlY3RpbmcgRFAwX0hQRCBicmVha3MgYXVk
aW8uIFRoZXJlIGlzIG5vIGFsdGVybmF0aXZlIHBpbg0KPiBjYXJyeWluZyB0aGUgSFBEIHNpZ25h
bCB3aGljaCBtYWtlcyBpdCBpbXBvc3NpYmxlIHRvIHVzZSBIUEQNCj4gd2l0aG91dCBsb29zaW5n
IHRoZSBhdWRpbyBjYXBhYmlsaXRpZXMuDQpIaSBZYXNoYXMsDQoNCnRoaXMgZGVzY3JpcHRpb24g
aXMgbm90IGNvcnJlY3QuIE9uIHRoZSBKNzIxUzIgRVZNIHRoZSBwaW4gQUEyNA0KTUNBU1AxX0FD
TEtYIGlzIG5vdCB1c2VkIGZvciBhdWRpby4gDQpUaGUgcGluIGlzIGp1c3QgZmxvYXRpbmcgdW5s
ZXNzIHRoaXMgIkdFU0kiLWJvYXJkIHdpdGggYW4gYWRkaXRpb25hbA0KZXRoZXJuZXQgaW50ZXJm
YWNlIGlzIGNvbm5lY3QuIEFBMjQgaXMgdXNlZCBhcyBhcw0KTUNBU1AxX0FDTEtYLlJHTUlJMV9S
RDAgaW4gdGhpcyBjYXNlLg0KU2VlIGFyY2gvYXJtNjQvYm9vdC9kdHMvdGkvazMtajcyMXMyLWV2
bS1nZXNpLWV4cC1ib2FyZC5kdHNvDQoNCkFsc28gdGhlIEFBMjQgcGluIG5lZWRzIHRvIGJlIGNv
bmZpZ3VyZWQgYXMgSFBEIHBpbiAobXV4bW9kZSAzKQ0Kb3RoZXJ3aXNlIHRoZSBtaGRwIGZpcm13
YXJlIHdpbGwgbm90IHR1cm4gb24gdGhlIGJyaWRnZS4NCg0KRG9taW5paw0KDQoNCj4gV2hlbiAn
bm8taHBkJyBpcyBzZXQsIERSTV9CUklER0VfT1BfSFBEIGlzIG9taXR0ZWQgc28gdGhlIGZyYW1l
d29yaw0KPiBmYWxscyBiYWNrIHRvIHBvbGxpbmcgLmRldGVjdCgpIGV2ZXJ5IH4xMCBzZWNvbmRz
LiBNb25pdG9yIHByZXNlbmNlDQo+IGlzDQo+IGRldGVybWluZWQgdmlhIEFVWCBEUENEIHJlYWRz
IGluc3RlYWQgb2YgZmlybXdhcmUgSFBEIHN0YXR1cw0KPiByZWdpc3RlcnMuDQo+IFRoZSAuZGV0
ZWN0KCkgY2FsbGJhY2sgZHJpdmVzIGNkbnNfbWhkcF91cGRhdGVfbGlua19zdGF0dXMoKSBvbiBl
YWNoDQo+IHBvbGwgdG8ga2VlcCBtaGRwLT5wbHVnZ2VkIGN1cnJlbnQuIEF0IGF0dGFjaCB0aW1l
LCB0aGUgZHJpdmVyIHdhaXRzDQo+IGZvciBmaXJtd2FyZSB0byBiZSByZWFkeSBiZWZvcmUgcGVy
Zm9ybWluZyB0aGUgaW5pdGlhbCBBVVggcG9sbCBzaW5jZQ0KPiBubyBpbnRlcnJ1cHQgd2lsbCB0
cmlnZ2VyIGl0Lg0KPiANCj4gQ2hhbmdlcyBzaW5jZSB2NDoNCj4gLSBDb3JyZWN0ZWQgdGhlIGR0
LWJpbmRpbmcgU3ViamVjdA0KPiANCj4gTGluayB0byB2NDoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsLzIwMjYwNjMwMTAyNjEwLjE4NDk5MDItMS15LWRAdGkuY29tLw0KPiANCj4gUmFo
dWwgVCBSICgyKToNCj4gwqAgZHQtYmluZGluZ3M6IGRpc3BsYXk6IGJyaWRnZTogY2RucyxtaGRw
ODU0NjogQWRkIG5vLWhwZCBwcm9wZXJ0eSB0bw0KPiDCoMKgwqAgdGhlIGNhZGVuY2UgYnJpZGdl
DQo+IMKgIGRybTogYnJpZGdlOiBjZG5zLW1oZHA4NTQ2OiBBZGQgbm8taHBkIHByb3BlcnR5DQo+
IA0KPiDCoC4uLi9kaXNwbGF5L2JyaWRnZS9jZG5zLG1oZHA4NTQ2LnlhbWzCoMKgwqDCoMKgwqDC
oMKgIHwgMTcgKysrKysrDQo+IMKgLi4uL2RybS9icmlkZ2UvY2FkZW5jZS9jZG5zLW1oZHA4NTQ2
LWNvcmUuY8KgwqAgfCA1OCArKysrKysrKysrKysrKysrLQ0KPiAtLQ0KPiDCoC4uLi9kcm0vYnJp
ZGdlL2NhZGVuY2UvY2Rucy1taGRwODU0Ni1jb3JlLmjCoMKgIHzCoCAxICsNCj4gwqAzIGZpbGVz
IGNoYW5nZWQsIDY5IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+IA0KDQo=
