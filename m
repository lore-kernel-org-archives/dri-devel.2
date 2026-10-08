Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF84CA6007
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 02:27:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AE2A10E4E6;
	Thu,  8 Oct 2026 02:27:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Psfr/MXm";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010069.outbound.protection.outlook.com [52.101.56.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B0D610E027;
 Thu,  8 Oct 2026 02:27:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rcvw4Gq8qZpPZB+GQMnw3fmRztsGn+9j6X+Gfyju9aC/PnBM7YskJ5q2JPOV7gJUpKGnyEwFwj4q4F9zwlBOVP2akQIBsPdDE23o12QWZbalS5jMKF7jje3tiu32AjN9+05OMwIPoYLsw5o3SQ9E7Nd+h83ADkahSmD4PoRepLyc/tO9bYqRcjPUDYLQYRMi8cDf7kHL9VduKbZID8o6IB2lFr+Tomx+2IU86EMn6kHeSnYJGzYhDa2lxUUtvAd96BeYk5zSi3/QQLH0PeAJElf3IfHLGrpdLvPRWmvuXKqr5DdztPq/OSbNnONkrN23YidBKDnu9GOYKPhos5p0lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwUSrqnxYGn/K/rScdkpNPZDTEsrgSrgLVNdCy9QVWc=;
 b=mc8aMPLT7LCSbr4e9c18n1iPgDO+ES2RxepPeXg1BHv4MKTiD+L2jwwDyfBPGJK2sD1oEE/geZ13mjxIU1bXBPQlpP7+Qm+SQLhuwdxwhbUDSe8TZB/dnq2jSX7Q3apEhI005mGPUPM74mPPVx1uQfbyHl3Cwtkf4HX1vN6/4oOWbpyl2QVH2LYzBBG/92XDjNhLmq7SV9g6hlPpurUjHrg88IW+GVii3whFjbEMMIGruM5Xbtg9PSxoisCZwgyAH9qtP6B3x/lhDtU4M0Gx7vOS6IaMzCn2C5QuC8R5h4KmvxH04oNyoXzgzGtrp3/yqiMpcZvUnyTsmas77Z93uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwUSrqnxYGn/K/rScdkpNPZDTEsrgSrgLVNdCy9QVWc=;
 b=Psfr/MXmDoDZwtmwzWz/EcPnDJkFbaCFqHsDrwRQXP9w7d6Ax9ww0KNZapC8NSvlJFdIvRAhrIqnBeEE7FHzrYx3feLdzK2ziIeo34mkK/uquPPqfux2qUVymxhP1mTbPYpvWM8uYqYq5958fJqqR33UBGaqiH2A7lx9OLraMRc=
Received: from IA0PPFD4454CAA9.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::be5) by SJ5PPF2CD49510F.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 02:25:28 +0000
Received: from IA0PPFD4454CAA9.namprd12.prod.outlook.com
 ([fe80::aca6:386c:e9ba:86c2]) by IA0PPFD4454CAA9.namprd12.prod.outlook.com
 ([fe80::aca6:386c:e9ba:86c2%7]) with mapi id 15.21.0451.014; Thu, 8 Oct 2026
 02:25:28 +0000
From: "Lin, Wayne" <Wayne.Lin@amd.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC: "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Li, Roman"
 <Roman.Li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "sashiko-bot@kernel.org"
 <sashiko-bot@kernel.org>
Subject: RE: [PATCH v2] drm/amd/display: add missing CRC engine 1 registers
 and masks for DCN3.2
Thread-Topic: [PATCH v2] drm/amd/display: add missing CRC engine 1 registers
 and masks for DCN3.2
Thread-Index: AQHdN5TCj4wzgs5G/kmtkGuTTf1m/bbSnNuAgCCG/AA=
Date: Thu, 8 Oct 2026 02:25:28 +0000
Message-ID: <IA0PPFD4454CAA918D3DA3D71405C9C7FD6FC932@IA0PPFD4454CAA9.namprd12.prod.outlook.com>
References: <20260829004608.25252-1-mikhail.v.gavrilov@gmail.com>
 <20260829085941.106318-1-mikhail.v.gavrilov@gmail.com>
 <CABXGCsNQZY+g5AB17yiZP4aD3eKBpNWWNqcOL3_eh5JLxp=H3A@mail.gmail.com>
In-Reply-To: <CABXGCsNQZY+g5AB17yiZP4aD3eKBpNWWNqcOL3_eh5JLxp=H3A@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-10-08T02:06:00.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PPFD4454CAA9:EE_|SJ5PPF2CD49510F:EE_
x-ms-office365-filtering-correlation-id: aba08f0a-60ec-4ca8-8c38-08df24e36afa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|38070700021|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003|6133799003|3023799007;
x-microsoft-antispam-message-info: /rdNPe5fnP+6VgU9oIOug+lqzrDndO87UDRqJXEoT4Xax7Ryu0PFdeK2lxjqJ8iaaC10/ugBNZcR0ppxA+Jk4ib1U7q/xqxwTDiz/wZsRpvRE0qybhO99SF3bHwFupFsFf76oAKXGdRugPv1Cga14i+l6sEhY1ojo4Adx01EsHFQrmd2AvY88YkmyCjBdAI15tTv96BGPr5ARf9DR8tDtonO9L5OsTSr1yogcsFL3uI+R5gMD4jhuimGedjgNZ7OYy6SftgSAu5Dgr6pXB5Btx1X+UcxGS7qCiVSW6WRsSRORQ2WyjtmjDvEmcPapJ7gtsF05brfnThbTixhnTwKcqX9akhZisb1c0WQihdpevENKiBZ6IoG4+m8tZ3JjxBexVltUthje21cWOMioanvI0haXGdouDN6lGyYJNkPBbbGjdJqggCiHxXjayAi1Tkao5P1ciLdmM90UBIyH2xQgaV1Oi3U5bxhgmmB3DIrGYV7Td5s+faZ6osjhd6kILmAPyhngmKGAqEZ1lKEwvZI8oZEEph0522IvVvjJXGnyOFKUozWfmRCFnyv5juwdI27jbwS/VJDWPIjBciNv9c3YiKxLlN4hqCEgRZ163fmdBiLt36HtWfLz6bhG8UcpuIF/OsYurkvE21RRgrEXca1RNzGa4eeo2iN8rmgVNwMDkIIVn/IvH/QNvCBIloWqdnVvR3Jzw5tt2Cj9vD+NE3deA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PPFD4454CAA9.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eW9MQVpjY2pOU0sxakVsYzlqYWxDbXRJQ1BDb29ja1FHc1o0cmc4YngybVBD?=
 =?utf-8?B?Ujd4NHB0Q0RoQnRMQjIwNXdXU0E4VGpRdnY4THVEWkNaeVhMSFQ5alBzQ2ds?=
 =?utf-8?B?TGluQityUTlNZkRRYmNDcnk0eFJDL3cyTGpJdWljeVpUYXV3bGVJM2VrVUVh?=
 =?utf-8?B?eVQrWHhMdDBNTk5LUU16YVZxSm04YXVkWDRxUlpkS0Uybk9aM0RaOUhwMkJ1?=
 =?utf-8?B?QnV5NEU5YmxLMFFYRFEvYTc2WEZYdVZyNzNQVStra2Ryek0zL1Z0T3djenF1?=
 =?utf-8?B?L0EzaGIzWmM2TDlNbnRjZEs5Wi9hT1Z2SHR0MlpJUTREcWNqdnBmNlNLT1VW?=
 =?utf-8?B?Y1FIM3ZXNTk0WExMbUFIdlg4bTk1Y0ZHeEJMaFRGTmhTVnh5T1ZmMmJMRGM2?=
 =?utf-8?B?RzlDOEx6WDkwSFoyNnErcmNHSlF0M2NEWlVpdDVqNGorRXBQNEgva1RmKzF0?=
 =?utf-8?B?eGMyMTVFUkNLSDlnT0ZJYlJtdHFCRjM0TTZrNjBCVmNGTUJFT0lFQm9pQ3lJ?=
 =?utf-8?B?V3c2VWt2YWJLazJyVkd5THlOanNxV2pXbEZGV3lYbjhDaVl0c29pcE5IamFG?=
 =?utf-8?B?V2o4aXNjdDczUGRBVkh1emd0S1R0M09GY1ByYzJNTmViazREUnd1N2tmd2xn?=
 =?utf-8?B?dVpxLzhwVm9Wc1ZlM210V3M5eGlyNjRBcmNuMXRwWjZpVGNXN0V6SE5qdEpP?=
 =?utf-8?B?YytQQ2RpZzVWMzRhZ0sxU2Z3UmxzTDRYRXhXWDdGbjJTOWk5TVoyVUE5eWZp?=
 =?utf-8?B?MXZTV2dISkMwclc5Y0duckp3UjZDVUl0VXNTcE1BVmdKYkdzNVJSelVqQzJq?=
 =?utf-8?B?UWZiRHZVeFphZ0svR0l4SWlGeWRlUXo5SXJCaHliSk1HYVJmelhXT3E3Vlpj?=
 =?utf-8?B?UXZ4eGZkSTdwN01iTlZ6K1RWNE8xdzhsdzI4akVqQnJWbndFRWVpbkF6VEp6?=
 =?utf-8?B?SXgwS0luZ3g5YXhLRHRaaU5nK1l0S1BvUWw4THlOSEN2VEh1YW45YnoxNVFm?=
 =?utf-8?B?cmFLVUFCZUNCYzg0OEQ0TFdxNHZKZ3EvVGoxS2JxV0M4S0pRYkU4c0VkQVN6?=
 =?utf-8?B?cktZVCtYRmtuNHBjVlRFUWZyV21FdkdpNFZuZEppTUdnK1dvVzBVUFhmeVIy?=
 =?utf-8?B?b3JGZUtPcmF6Qmtmd2ovcEtQcjZaU1pPVXZtcTkwU3Jhb0RIRjJ1dWxRbzB0?=
 =?utf-8?B?N2t4bDhVbmdNRzgySkczQ0RTMFZFRGE1b2pCektyVnA0SW1yV2Y3OS9SVHBG?=
 =?utf-8?B?c2FuMUkzamRHTjVZa1FORGw3VUJEZ3RqNjJrcEMxZmNDWWpjZElkOE1WalNZ?=
 =?utf-8?B?bUlrbThrSkUvTTczbXVqUDNnNkFnbVFrOURWbWdLVlFQU3oxNmJMTEx0YmlU?=
 =?utf-8?B?ZTE1OHd5RjFtRm15V0tmZHZsVFdKSlV3emxqbndIUk4way9rMURDaS93b21F?=
 =?utf-8?B?azFOUFA3dEpaMm0zeEphMFozcXJTV24yV1lFWHVoMnI2cnpoUmdyQ0IrUUpH?=
 =?utf-8?B?NE52QXlDQUZOMnkxNzlnTUlLOVQzbFU2bDZJa1QxK0M0amI1WC8zaDFyaExw?=
 =?utf-8?B?em9hajUwUkc2dW8wdGNqSStBNHVnWDl3dlpVUjFJUmhiSmxSNE1sVHpVR0t6?=
 =?utf-8?B?VkFFZWFUajI0bExuUU83TnAxMVg5a1hpdlJkMDAwaHJFOWZaV0xYem5KamJY?=
 =?utf-8?B?QnpyOUdMQllWaFZqRDcrcTZZTzVzTUZvdy91V2NwRGg4Z1RhNjk1VndEUWg4?=
 =?utf-8?B?MVNZc3JQWlNxQUNwbjFrQUIwUFNPSWhSTnBTVXVnTnFON2xFVkdyRklwOFVy?=
 =?utf-8?B?UHk5ZmJZdEVmMDFYM21FNVIzd2ZpRTZwclNGZTU1NHFRTHd6RXh4RjJ5Q1ZN?=
 =?utf-8?B?K3hUSWp3bGY2eE5vZzQvN2x3RlJXcUFvZFU2elpNazhqVzJXby9XZHdvRWo1?=
 =?utf-8?B?S1RwRmZvaVJNUUlmYVAxRHoyUGJMRXQxZndsWUVGY1JTcTloT09Tck01bU44?=
 =?utf-8?B?eXU0U1ZjNEM2NmFKdkx1UnpFdlFTZ0NwVFo3K1U0VTcyekUvZVoraTBkRWZR?=
 =?utf-8?B?VzVxVjI1MXNvZm1aYVRtQWE5MmE5bkhiZE1lVVJ4SmxOZCtTNlhCbzI3U05S?=
 =?utf-8?B?dW0vdkJ0MGJ3N3pZV3BOZ2oyUDB3ZkcxVys4d09UeU43MmNLZlo5M1ZGNERq?=
 =?utf-8?B?RzgySkExS0pDNFJRcFBFSXpDSUp0TzdyTkNaNnl5cy90bGcvTDFmdWN1ai92?=
 =?utf-8?Q?rUjk+0TUnabk0/NdBXnVckBR/4I+0DaS0fl+b8Q+U0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PPFD4454CAA9.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aba08f0a-60ec-4ca8-8c38-08df24e36afa
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 02:25:28.0449 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MePJV0c7xrxobYggOzHWqeyv31/FWHzXx6HNVO8ohUsvqsTXtJL5+pYYGyWO+oaCx8Uez9EOPdX6Ko9Fv/MYlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF2CD49510F
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

UHVibGljDQoNCkhpIE1pa2hhaWwsDQoNClRoYW5rcyBmb3IgY2F0Y2hpbmcgdGhpcyENCkNvdWxk
IEkgZ2l2ZSBhbm90aGVyIHBhdGNoIHRoYXQgd2lsbCBpbmNsdWRlIHRoaXMgZml4IGFsb25nIHdp
dGggYSBmZXcgb3RoZXIgRENOIGZpeGVzLCBwbGVhc2U/DQpJJ2xsIG1ha2Ugc3VyZSB0byBDQyB5
b3Ugd2hlbiBJIHNlbmQgaXQgb3V0IGxhdGVyLg0KDQpUaGFua3MsDQpXYXluZQ0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1pa2hhaWwgR2F2cmlsb3YgPG1pa2hhaWwu
di5nYXZyaWxvdkBnbWFpbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIgMTcsIDIw
MjYgNToyMiBQTQ0KPiBUbzogV2VudGxhbmQsIEhhcnJ5IDxIYXJyeS5XZW50bGFuZEBhbWQuY29t
PjsgTGksIFN1biBwZW5nIChMZW8pDQo+IDxTdW5wZW5nLkxpQGFtZC5jb20+OyBEZXVjaGVyLCBB
bGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IENjOiBMaW4sIFdheW5lIDxX
YXluZS5MaW5AYW1kLmNvbT47IENodW5nLCBDaGlhSHN1YW4gKFRvbSkNCj4gPENoaWFIc3Vhbi5D
aHVuZ0BhbWQuY29tPjsgTGksIFJvbWFuIDxSb21hbi5MaUBhbWQuY29tPjsgUm9kcmlnbw0KPiBT
aXF1ZWlyYSA8c2lxdWVpcmFAaWdhbGlhLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3Rp
YW4uS29lbmlnQGFtZC5jb20+Ow0KPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgZHJp
LWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IHNhc2hpa28tYm90QGtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0g
ZHJtL2FtZC9kaXNwbGF5OiBhZGQgbWlzc2luZyBDUkMgZW5naW5lIDEgcmVnaXN0ZXJzIGFuZA0K
PiBtYXNrcyBmb3IgRENOMy4yDQo+DQo+IFtZb3UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20g
bWlraGFpbC52LmdhdnJpbG92QGdtYWlsLmNvbS4gTGVhcm4gd2h5IHRoaXMgaXMNCj4gaW1wb3J0
YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+
DQo+IE9uIFNhdCwgQXVnIDI5LCAyMDI2IGF0IDE6NTnigK9QTSBNaWtoYWlsIEdhdnJpbG92IDxt
aWtoYWlsLnYuZ2F2cmlsb3ZAZ21haWwuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IE9wZW5pbmcg
dGhlIENSVEMgQ1JDIGRlYnVnZnMgZmlsZSBvbiBhIERDTjMuMiBjYXJkIHRyaWdnZXJzIGEgV0FS
Tg0KPiA+IGZyb20gZGNfaGVscGVyLmMgb24gdGhlIGZpcnN0IGF0dGVtcHQgYWZ0ZXIgYm9vdDoN
Cj4gPg0KPiA+ICAgV0FSTklORzogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxh
eS9kYy9kY19oZWxwZXIuYzo1MyBhdA0KPiA+ICAgc2V0X3JlZ19maWVsZF92YWx1ZXMuaXNyYS4w
KzB4MzBkLzB4NzMwIFthbWRncHVdLCBDUFUjMTogY2F0LzU4NDY4DQo+DQo+IEdlbnRsZSBwaW5n
LiAgSXMgdGhlcmUgYW55dGhpbmcgeW91IHdvdWxkIGxpa2UgY2hhbmdlZCBoZXJlPw0KPg0KPiBT
aW5jZSB0aGlzIGNhcnJpZXMgYSBGaXhlczogdGFnIGZvciBhIGNvbW1pdCB0aGF0IGxhbmRlZCBp
biB0aGUgNy4zIG1lcmdlIHdpbmRvdywgSQ0KPiB3YXMgbm90IHN1cmUgd2hldGhlciBpdCBiZWxv
bmdzIGluIGRybS1maXhlcyByYXRoZXIgdGhhbiBhbWQtc3RhZ2luZy1kcm0tbmV4dCAtDQo+IGhh
cHB5IHRvIHJlc2VuZCBhZ2FpbnN0IHdoaWNoZXZlciB0cmVlIHlvdSBwcmVmZXIuDQo+DQo+IEFu
ZCBpZiBEQyBoZWFkZXIgbGlzdHMgYXJlIGVhc2llciB0byByZWdlbmVyYXRlIGluIHlvdXIgaW50
ZXJuYWwgdHJlZSwgc2F5IHNvIGFuZCBJIHdpbGwNCj4gZHJvcCB0aGlzIHBhdGNoOiB0aGUgV0FS
TiBpcyBoYXJtbGVzcyBpbiBwcmFjdGljZSBhbmQgSSBvbmx5IHNlbnQgaXQgYmVjYXVzZSBJIGhh
ZA0KPiB0aGUgaGFyZHdhcmUgdG8gdGVzdCBpdC4NCj4NCj4gLS0NCj4gVGhhbmtzLA0KPiBNaWto
YWlsIEdhdnJpbG92Lg0K
