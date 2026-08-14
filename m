Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E92C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:41:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56C2F10F693;
	Fri, 14 Aug 2026 15:41:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mTzpuZmv";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010051.outbound.protection.outlook.com
 [52.101.193.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DED9710F691;
 Fri, 14 Aug 2026 15:41:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cAwoVb/EjuK/j4Y5q33vc4bTdIV4ru0tB7oduOwbv0Cf4TAdB+/+O2OJe3biJhFKEBm9e/UydN6dZIYQF+/ikzttxaPYT8qzOzVgNVwCoSK6W6gv3UMm2IfNhCtcC1OMfh6c2uXwZs8pSpKVebU4VsFZhXFGoxB/lS+v09EbGJm9ZkwIopYveewAJX7Iv7v7lnen7BJCs+DhQQIiVkcyhVWYGWXqXmJm2yvlH9sQKMIvcQ7fr5y/70uc+lxX84w73kzDiF8mG6f6dFp3BOKmpWtcooY2YHxnJ9gmtjubArkYbzg4fwB7jmExynpPkfjAFl4malhOtIHNDsxAa/+Pug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYAcIOAhrkvfx9sLQ2ZevIfRRhjzKWVz3QvYTh+Yy4o=;
 b=fFYxKYCX9i6EocVY2PQV0KkPY4OmbHCBCTTkm96wYyqw4GK+C+bB8Kyx4NVfbarVWwWhGBf4E0ZT6/KWmsz7Cei+udMSE3aARApG4TUbVBYnLY1itcjUOKybowG5NHrjUF8CirNEz36LWtjvkI9kz/Qu0sfslnyZYIBWl/fwYotjSQ/01Gw+9XM0hRNF462iTkI/lrZytr80h9/0xegenhTUs8LlaTJ5BzdFCA48Wk6wSEiOTmTvqivHMtdzDfVQWOhh1ZzdOi7Oji2G/yjT+8K6tXbZDCX4sssaBVjvk4KKa+M4i/mWpgQIH2jnDrenVDYSwI810a0Fjz0swcf87g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYAcIOAhrkvfx9sLQ2ZevIfRRhjzKWVz3QvYTh+Yy4o=;
 b=mTzpuZmvz7MZnVQEeo+C+JTEYT7gONweN/pL36qrd5x8qCs6sLUrRLyRUitCzeBp4V7Jtb2zdvkNPOeo9BT7dLsqM+CaKlkT12H8dfZfpJfhaht7JVcEyYAdQr/VWI7oXe1fK3ouSjYaMmX3xO99Tl6xoIat3+wakfzRNpMeGcA=
Received: from CHXPR12MB999220.namprd12.prod.outlook.com
 (2603:10b6:610:2fd::7) by PH7PR12MB6809.namprd12.prod.outlook.com
 (2603:10b6:510:1af::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Fri, 14 Aug
 2026 15:41:19 +0000
Received: from CHXPR12MB999220.namprd12.prod.outlook.com
 ([fe80::c13f:e49a:47dc:5c61]) by CHXPR12MB999220.namprd12.prod.outlook.com
 ([fe80::c13f:e49a:47dc:5c61%6]) with mapi id 15.21.0315.011; Fri, 14 Aug 2026
 15:41:19 +0000
From: "Zuo, Jerry" <Jerry.Zuo@amd.com>
To: Daniel Stone <daniel@fooishbar.org>
CC: Derek Foreman <derek.foreman@collabora.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, =?utf-8?B?VG9tYXN6IFBha3XFgmE=?=
 <tomasz.pakula.oficjalny@gmail.com>
Subject: RE: [PATCH v3 4/4] drm/amd/display: Add HDMI ALLM support
Thread-Topic: [PATCH v3 4/4] drm/amd/display: Add HDMI ALLM support
Thread-Index: AQHdKSnNhfuPuwnpwUmYPQuaeuvZVbaY3bmAgAAawwCAAIyfEIACJgGAgAH3w0A=
Date: Fri, 14 Aug 2026 15:41:19 +0000
Message-ID: <CHXPR12MB999220E41E57B2B63AE08AAFABE5DA2@CHXPR12MB999220.namprd12.prod.outlook.com>
References: <20260806205449.16806-1-jerry.zuo@amd.com>
 <20260811003921.1398292-1-jerry.zuo@amd.com>
 <20260811003921.1398292-5-jerry.zuo@amd.com>
 <0102019ff114857a-259b7f40-8202-425a-bfbc-71bb92acf184-000000@eu-west-1.amazonses.com>
 <CAPj87rMSYC0wKP66p5Q5uOL+-Fb04-gYJFcRxdxxZ2-_du89GQ@mail.gmail.com>
 <CHXPR12MB9992200C6E9ABE2BF4CB8EB53EE5DC2@CHXPR12MB999220.namprd12.prod.outlook.com>
 <CAPj87rPsEUKEtOMzpvwnAJ1AHG=TyhLVu75kByPLwqbJ5yK1sw@mail.gmail.com>
In-Reply-To: <CAPj87rPsEUKEtOMzpvwnAJ1AHG=TyhLVu75kByPLwqbJ5yK1sw@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-14T14:38:40.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CHXPR12MB999220:EE_|PH7PR12MB6809:EE_
x-ms-office365-filtering-correlation-id: 0e78caec-21d3-4b19-4714-08defa1a7c76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|18002099003|11063799006|4143699003|22082099003|6133799003|56012099006|3023799007|10067099003|38070700021;
x-microsoft-antispam-message-info: HNIvJqmYqeuU1HMa/OeUYdwRayVbdiH3wA+HYbJC20s2ZZWjoGAmYKE0zVw8wSCkvLpQ7bGhS6r0Ex9CbXJatvMbs/uta0a7EtkBwDpp+9jH8GK6vxVCe8p/kOxu1zeiPugr7S30iZn4oUSy/GCOW7Y+VTj/euGEEGaThUln82j703jFg17m4rCFYR90dzBKLfJdQjwabRAm777qWlYrkTB6p9A/1ghpFvIqR61IxVANKhoqkJ2Vvcrs0n+ifm2AC8QUo5C9edggYMTn23ReHprPgngf0QdPDyuJNtewgAPcamp6f/sWwF6v9IIta56Jy6dh795hHj0oGE4X/tOFTU3m6LHgpN/G17LAtkgyjZHSxj1EeAyVLBePgs3fvGw9jxU7wo4FyN01fGPDaR2mjyKB3t6KWCBxhscg/0oxsvAUSoz5U7xx7SkyLp8kDkdpu89uRe0iWsqKFMqPa3kaeL6pGchAfYQmwp3587oZcirJmm0PrI65dczMARCm7ZcuJrUpDGFKT2RVP6LSaHWx7TcN4yFu1RWchfZTXNahWM8yOG70ZUtOkQiE/RNKprHCtWCH7hIFByxpQRn1YZIubsArrlyPGlV/gIWU9H37bn66O2ApDx6qbeJud+dDWhR+of13DxVpv/8lLc98qhZlkRRLFDOVrA1eIidILfsVvYJ/dyK6s7Uv/Yqodj7FkmC14Sxw3faayDj0kZ67ju3j+L9X9nuaMcaRdyL81BP/O6g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHXPR12MB999220.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(11063799006)(4143699003)(22082099003)(6133799003)(56012099006)(3023799007)(10067099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akh2ZlMraDcxVkt1RkdOMXVyMnBWMlR2QnB4MlJXdlQwVHBwVFpWUkZJaGtX?=
 =?utf-8?B?M2gxS3NmY3J1NVdjdGhLOTJhMmNWUncwblRsWTFkMEdSMmxPT05JNVRjcmVF?=
 =?utf-8?B?NEpnRmJlaDkwWGJjdXk0cmNPUHg1ZDNKaFlHZ0gxVnIyKzFaMXNOcnhHSXE2?=
 =?utf-8?B?Ukt3MzN2VjFkWnVRcFpMcFRxVmN6a1VrRHNQUjV0SkhyNHRWSHVvTlpqU1dl?=
 =?utf-8?B?TXk3bTErYmFkTU5qNWpIV3N4Tlp5T1VWWWY5T2d4MksxUkMrazhPQ1A1dlhN?=
 =?utf-8?B?d0ZaZGdKRGtYcmw4UmdaZEJLNWl1bjdvZ0xSR29ObU1xYjM5M05IVTRsR0Qy?=
 =?utf-8?B?R0VDZzg1bDN1YmhYa3VzRStHVGxJWkRkencyOHpqVU1uanBFbG1oM0lROXRx?=
 =?utf-8?B?MDlOQ0pzbmF5SHlGaEdjcitxckMwRzZQUklnc2N1cmJMYUZ3MVpiemVHenEz?=
 =?utf-8?B?bzUxbDh1OGhVODRtMGNOTTl2U001N20xRFlwRXQ2VTRpc2E5MWFOUk1TZkJs?=
 =?utf-8?B?MTFlVDFQTUNOTFhNZ3R1VTZvcnFYbGllWWpOQjY1QW02eExNZ1V4NTdHOGtQ?=
 =?utf-8?B?V0FSYUdNcXZ5Vnk4TWxUblppelNvMXZnSWdvVkRKZXVISlhMd2YyYWdycWRI?=
 =?utf-8?B?S1grcHd1NUJPTTVIREdHSG85UHl0SFFldThIWCt0WU0zSS9NdXhjSU43TmVH?=
 =?utf-8?B?YTQ5b3ZNY3pLdmV0SkVTZkFlU1Qza1czMm0vYU9LdHBMRzJaNExFY0s5TVdS?=
 =?utf-8?B?QTUwNFVQWkVrak1OWHB1Z01VQ0lHbEpsZmd4NWlwWTN3aUxtRDIvWkx1Z1J0?=
 =?utf-8?B?RG5nNk1RaHdKb1JwOU5DZnRhSDcrd08xbDdNR29KaGVBcGwzczA1YWdsLzdq?=
 =?utf-8?B?ZTNYcHRuYXV2ejVKSmNta1VDeHlJNWFRcjgvSTd0YkVmMVlwMW5QeC9tVjlE?=
 =?utf-8?B?SEtSaTEySWVnUWswZFRFdlNndEVqSjBjNkFPbm5Fd0NDc0VQeDJTMTV3NVQ4?=
 =?utf-8?B?eGxxcWpmcGs1ZGk5UFoybGVCMTMxZGJCb0RwRWZxS21wYzEzWXdNN1dQcFp2?=
 =?utf-8?B?L1Z0UHRwQ1NiK3NsYW9EbzhuS1V2Rk1ocXRQelZEVVJPK0xHNyt4b080L2Fn?=
 =?utf-8?B?eElGbmZ6UEE2U1dMZXJmRDZ6VVVDS1RXRVJSSzM0c3V1ay9kaklTL0lJQzRV?=
 =?utf-8?B?QUhEWmFpSGV5NnlBT2YraXRlTDVERUx1VTVGVGFpUTRMY0lvaUVaQ1ZXdXp2?=
 =?utf-8?B?bU9nSzZzd3BKUVZQL0RLbDh2cUVocGswaUdGeExmdVNHQ2FXcjV2cnI0UDZz?=
 =?utf-8?B?M1JVcVdFS3ZOaU5uK0h6ZmpZV01idUtUWGFWTmdiU21tWStKOENsYWFiVEF2?=
 =?utf-8?B?Q0I2SFp4WFdnZzNUYUR5cEZNUUZoNE9QWGlMQ25DMW1EbFk2c05KdzFFcCtZ?=
 =?utf-8?B?d2NJNUNWd1RTS2d4SzFja0huWlpVczdyUTAvbXZLbFlxK3pjUjdhN0xKWEVq?=
 =?utf-8?B?TU5TdzN1TDVTK3EzUGRwTDJLeSs5dkRROEZ2cTRZcElnMEpueTZFZFg0NVgz?=
 =?utf-8?B?UlQ4Q3JHRCtRS0ZGYnRvK1dIM2NTODdWT0x5UE1SenpKck9uVkxkWWxIa2o1?=
 =?utf-8?B?RFRTOUhDdXJZSXR6MEhhbmxzT0dycy9UVmhEZVVwSjF1WkMwa3R2Q2hpZWg1?=
 =?utf-8?B?bEcwQURlUVh2OGkyUGkvTk5rZWU3K3ZGNkRGeUpXaXk0OXpNaVN2b3dOTFNG?=
 =?utf-8?B?Q2g2ZjJ1aTBlVXgyZkdEWWZRb0FSTmlENjRvd3RkYUVEcWhML29yWDZVcU9l?=
 =?utf-8?B?QWZMTzdtVnhXWXVGM2NrbDdMV01vdWZWZEF2MXhPNmZLTTRoejlKK1d5cWRK?=
 =?utf-8?B?SW5QRW11UWdlOHRSRXA4ajBUZnlCK3c0OUEreDdLMk1aVGxOay9wRERwbmpG?=
 =?utf-8?B?YW1scCtpRFRlSHEwaGhVSmUzS1hKeVZGdE5JNXRoeVp3RjFyeEswcHVpQ2sx?=
 =?utf-8?B?YlcyZ1FXdUt4dDQ0MThUL3JKNUk0UmIrNmE0OFpZdHVoNjYvQmtHdGZZUk1P?=
 =?utf-8?B?TkFPY3BzK1pmRDI0RDFWMDh3MnNCWVY0ZHpsN2lMelFBTGxxWGpyTlVsZnBR?=
 =?utf-8?B?TmRHNVQwaWNzV2xFTTJPQW1PR2lFTFlaZTZRdkhQbEtaRnNkc0ZnN1hMRDJa?=
 =?utf-8?B?RGJIWkY3aG1Qcm5oNTQ0eEJISkd6eFN2WnJlNFNYY2lkaElqYmdzL05hVGdL?=
 =?utf-8?B?eFNNWVZJMERuSmpMeSsvYUIrdnM5Yk5SQjBrK3V4aHlTVHpSaThTWTV2L3dJ?=
 =?utf-8?Q?AXhsrIPwlD6mwE8u6Y?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CHXPR12MB999220.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e78caec-21d3-4b19-4714-08defa1a7c76
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 15:41:19.7164 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /AnLHbamH4Qx2KHXgVKWK+RYbRfSxMBbRnM927taVhrpU6evdEMZhvImP/TpdNMn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6809
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

QU1EIEdlbmVyYWwNCg0KSGk6DQoNCiAgICBUaGFua3MgZm9yIHlvdXIgZmVlZGJhY2suDQoNCj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuaWVsIFN0b25lIDxkYW5pZWxA
Zm9vaXNoYmFyLm9yZz4NCj4gU2VudDogVGh1cnNkYXksIEF1Z3VzdCAxMywgMjAyNiAwNDozNg0K
PiBUbzogWnVvLCBKZXJyeSA8SmVycnkuWnVvQGFtZC5jb20+DQo+IENjOiBEZXJlayBGb3JlbWFu
IDxkZXJlay5mb3JlbWFuQGNvbGxhYm9yYS5jb20+OyBhbWQtDQo+IGdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmc7IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFdlbnRsYW5kLCBIYXJy
eQ0KPiA8SGFycnkuV2VudGxhbmRAYW1kLmNvbT47IFRvbWFzeiBQYWt1xYJhDQo+IDx0b21hc3ou
cGFrdWxhLm9maWNqYWxueUBnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgNC80
XSBkcm0vYW1kL2Rpc3BsYXk6IEFkZCBIRE1JIEFMTE0gc3VwcG9ydA0KPg0KPiBIaSB0aGVyZSwN
Cj4NCj4gT24gV2VkLCAxMiBBdWcgMjAyNiBhdCAwMTo0MywgWnVvLCBKZXJyeSA8SmVycnkuWnVv
QGFtZC5jb20+IHdyb3RlOg0KPiA+IEJlbG93IHR3byBzY2VuYXJpb3MgYmVsb25nIHRvIHN0YXRp
Yy9tb2Rlc2V0IEFMTE0NCj4NCj4gVGhhbmtzIGEgbG90IGZvciB0aGVzZSBjbGFyaWZpY2F0aW9u
cy4NCj4NCj4gPiAjMy4gR2FtaW5nLVZSUg0KPiA+ID4gSXMgaXQgbWFuZGF0b3J5IGZvciB0aGUg
c291cmNlIHRvIHNldCBBTExNIHdoZW4gdGhlIHNpbmsgYWR2ZXJ0aXNlcw0KPiA+ID4gQUxMTSBz
dXBwb3J0LCBhbmQgZ2FtZS1WUlIgaXMgYWN0aXZlPw0KPiA+IE1hbmRhdG9yeSB0byBzZXQgQUxM
TSA9PSAxDQo+ID4gRnJvbSBzcGVjIDcuNi42LCBQMjQwDQo+ID4gSXQgaXMgc3BlYyBtYW5kYXRv
cnksIGFuZCB3ZSBmb2xsb3cgaXQuDQo+ID4NCj4gPiAjNC4gUU1TLVZSUg0KPiA+ID4gSXMgaXQg
YWxsb3dhYmxlIGZvciB0aGUgc291cmNlIHRvIHNldCBBTExNIHdoZW4gdGhlIHNpbmsgYWR2ZXJ0
aXNlcw0KPiA+ID4gQUxMTSBzdXBwb3J0LCBhbmQgbm9uLWdhbWUtVlJSIGlzIGFjdGl2ZT8NCj4g
PiBJdCBpcyBRTVMtVlJSLCBtYW5kYXRvcnkgdG8gc2V0IEFMTE0gPT0gMCBGcm9tIHNwZWMgMTAu
MTEsIFA0NTYsIDI0MA0KPiA+IEl0IGlzIHNwZWMgbWFuZGF0b3J5IHdoZW4gZW5hYmxpbmcgUU1T
LVZSUiwgYnV0IGl0IGlzIG5vdCB5ZXQgaW1wbGVtZW50ZWQNCj4gaW4gY3VycmVudCBjaGFuZ2Uu
DQo+DQo+IFRoaXMgaXMgdGhlIGludGVyZXN0aW5nIHBhcnQuDQo+DQo+ID4gPiA+IFR5aW5nIHRo
aXMgdG8gR2FtaW5nLVZSUiBzZWVtcyBwb3RlbnRpYWxseSBzdXJwcmlzaW5nLiBHYW1pbmctVlJS
DQo+ID4gPiA+IGRvZXNuJ3QgbWVhbiB3ZSdyZSBwbGF5aW5nIGEgZ2FtZS4gV2UgbWlnaHQgYmUg
dXNpbmcgaXQgdG8gcGxheQ0KPiA+ID4gPiBiYWNrIGp1ZGRlciBmcmVlIHZpZGVvICh3aGVyZSB3
ZSdkIGxpa2UgQUxMTSBvZmYgdG8gcHJlc2VydmUgdGhlDQo+ID4gPiA+IHNpbmsncyBpbWFnZSBl
bmhhbmNlbWVudCksIG9yIHdlIG1pZ2h0IGJlIGF0IHRoZSBkZXNrdG9wLg0KPiA+ID4gPg0KPiA+
ID4gPiBJJ2QgaW1hZ2luZSBzb21lIHVzZXJzIHdvdWxkIHN0aWxsIHdhbnQgdGhlaXIgc2luayB0
byB1c2UgYWxsIHRoZQ0KPiA+ID4gPiBpbWFnZSBlbmhhbmNlbWVudHMgdGhleSBzYXcgaW4gdGhl
IHNob3dyb29tIGV2ZW4gd2hlbiBwbGF5aW5nIGENCj4gPiA+ID4gZ2FtZSwgc28gSSdtIG5vdCBz
dXJlIGFueSBraW5kIG9mICJhdXRvIiBkZWNpc2lvbiBtYWtpbmcgaW4gdGhlDQo+ID4gPiA+IGtl
cm5lbCBtYWtlcyBzZW5zZSBhdCBhbGwsIGV2ZW4gYmFzZWQgb24gY29udGVudCB0eXBlLiBJdCdz
IGEgdmVyeQ0KPiBzdWJqZWN0aXZlIHRyYWRlLW9mZi4NCj4gPiA+ID4NCj4gPiA+ID4gVG8gbWUs
IHRoaXMgc2VlbXMgbGlrZSBzb21ldGhpbmcgYSBjb21wb3NpdG9yIHdvdWxkIHdhbnQgY29udHJv
bA0KPiA+ID4gPiBvZiB3aXRoIGEgc2ltcGxlIGJvb2xlYW4gcHJvcGVydHkuDQo+ID4NCj4gPiBB
TExNX01vZGUgaXMgYSBwcm90b2NvbC1sZXZlbCBIRi1WU0lGIGJpdDsgbGlrZSBWUlJfRU4sIHRo
ZSBkcml2ZXINCj4gPiBkZXJpdmVzIGl0IGZyb20gZXhpc3RpbmcgY29tcG9zaXRvci1zZXQgS01T
IHN0YXRlIHJhdGhlciB0aGFuIGV4cG9zaW5nIGENCj4gbmV3IGJpdC4NCj4NCj4gVlJSX0VOQUJM
RUQgaXMgYSBjb21wbGV0ZWx5IHNlcGFyYXRlIGJpdCB0aG91Z2guDQoNClllcywgVlJSX0VOQUJM
RUQgaXMgaXRzIG93biBkZWRpY2F0ZWQgcHJvcGVydHkgdGhhdCBtYXBzIDE6MSB0byBWUlJfRU4u
DQpUaGVyZSBhcmUgdHdvIGluZGVwZW5kZW50IHRyaWdnZXJzIGluIHRoZSBwYXRjaCwgYW5kIG9u
bHkgb25lIG9mIHRoZW0gaXMgYQ0KcG9saWN5IGRlY2lzaW9uOg0KMS4gRHVyaW5nIEdhbWluZy1W
UlIgdGhlIHNpbmsgaXMgZXhwZWN0ZWQgdG8gYmUgaW4gaXRzIGxvdy1sYXRlbmN5IG1vZGUNCnJl
Z2FyZGxlc3Mgb2YgdGhlIGJpdCDigJQgYSBjb21wb3NpdG9yIHByb3BlcnR5IHRoYXQgY2xlYXJl
ZCBBTExNIGhlcmUNCndvdWxkIGJlIGJvdGggbm9uLWNvbXBsaWFudCBhbmQgaW5lZmZlY3RpdmUu
IFRoaXMgcGFydCB0aGVyZWZvcmUgaGFzIHRvDQpzdGF5IGluIHRoZSBkcml2ZXIuDQoyLiBjb250
ZW50X3R5cGUgPT0gR2FtZSAtPiBBTExNLiBUaGlzIG9uZSBJIGFncmVlIGlzIGEgcG9saWN5IGRl
Y2lzaW9uLCBhbmQNCml0J3MgdGhlIHN1YmplY3RpdmUgdHJhZGUtb2ZmIHlvdSdyZSBkZXNjcmli
aW5nLg0KKEdhbWUgd2l0aCBBTExNX01vZGU9MCBpcyBhIHZhbGlkIGNvbWJpbmF0aW9uKQ0KDQo+
DQo+ID4gVGhlIEdhbWluZy1WUlIgY2FzZSAjMyBpcyBub3QgcG9saWN5IGF0IGFsbC4gNy42LjYg
bWFuZGF0ZXMNCj4gPiBBTExNX01vZGU9MSB3aGVuIFZSUl9FTj0xIGFuZCB0aGUgc2luayBhZHZl
cnRpc2UgQUxMTSwgc28gaXQgbXVzdCBsaXZlDQo+IGluIHRoZSBkcml2ZXIuDQo+ID4NCj4gPiBU
aGUgb25seSBkaXNjcmV0aW9uYXJ5IHBpZWNlIGlzIGNvbnRlbnRfdHlwZSA9IEdhbWUg4oeSIEFM
TE0gKCMxLCAjMiksDQo+ID4gd2hpY2ggQ1RBLTg2MSdzIGxhdGVuY3ktbWluaW1pemF0aW9uIHJl
Y29tbWVuZGF0aW9uIGZvciBHYW1lIElUDQo+ID4gY29udGVudCBtYWtlcyBhIHJlYXNvbmFibGUg
ZGVmYXVsdCAoQXBwZW5kaXggRyBsaXN0cyBpdCBhcyBhbGxvd2FibGUpLg0KPiA+IFRvIGF2b2lk
IHBlci1kcml2ZXIgZGl2ZXJnZW5jZSwgdGhhdCBkZWZhdWx0IGNvdWxkIGxpdmUgaW4gYSBEUk0N
Cj4gPiBoZWxwZXIsIHdpdGggcm9vbSB0byBhZGQgYW4gZXhwbGljaXQgb3ZlcnJpZGUgcHJvcGVy
dHkgbGF0ZXIgaWYgYSBjb25jcmV0ZQ0KPiBuZWVkIGFyaXNlcy4NCj4gPiBJdCBjYW4gYmUgcGxh
bm5lZCBpbiB0aGUgZnV0dXJlLg0KPg0KPiBJIHJlYWxseSB0aGluayB0aGUgYnVyZGVuIG9mIHBy
b29mIGZvciBpbXBsaWNpdCBzZW1hbnRpY3MgaW4gS01TIHNob3VsZCBiZSB0aGUNCj4gb3RoZXIg
d2F5IGFyb3VuZDogZG8gd2UgdW5hdm9pZGFibHkgbmVlZCB0aGlzLCBvciBpcyB0aGVyZSAoY3Vy
cmVudGx5KSBubw0KPiBvdGhlciBvcHRpb24gYXQgYWxsPw0KPg0KPiBJIGRvbid0IHRoaW5rIEFM
TE0gZmFsbHMgaW50byB0aGlzIGJhc2tldCBhdCBhbGwuIEl0J3MgbmljZSB0byBoYXZlIGZvciBn
YW1pbmcgKGFuZA0KPiBtYW5kYXRvcnkgZm9yIGdhbWluZyBWUlIgbW9kZSksIGJ1dCB0aGVyZSBh
cmUgcGxlbnR5IG9mIGRpZmZlcmVudCBzY2VuYXJpb3MNCj4gd2hlcmUgaGF2aW5nIGl0IG9uIG9y
IG9mZiBpcyBhIGxlZ2l0aW1hdGUgY2hvaWNlLiBGb3IgaW5zdGFuY2UsIHNob3VsZCBkZXNrdG9w
cw0KPiBpbXBseSBBTExNIGJlY2F1c2UgdGhleSBhcmVuJ3QgZ29pbmcgdG8gc21vb3RoIHlvdXIg
dGV4dCBpbnRvIG9ibGl2aW9uLCBvcg0KPiBzaG91bGQgdGhleSBub3QgYmVjYXVzZSB5b3UncmUg
cHJvYmFibHkgbm90IGdvaW5nIHRvIHJlYWQgdGV4dCBvbiBhIDQ5Ig0KPiBkaXNwbGF5PyBTaG91
bGQgYWxsIGdhbWVzIGltcGx5IEFMTE0gYmVjYXVzZSB5b3UgbmVlZCB0aGUgcmVzcG9uc2UgdGlt
ZSwNCj4gb3IgYXJlIHlvdSBtYXliZSBwbGF5aW5nIE15c3Qgb24geW91ciBUVj8NCj4NCj4gSSB1
bmRlcnN0YW5kIHRoZSBhdHRyYWN0aW9uIGJlaGluZCAnd2UgY2FuIGp1c3Qgc3R1ZmYgdGhpcyBp
biB0aGUga2VybmVsIGFuZCBpdA0KPiB3aWxsIGR0cnQnLCBidXQgaGV5LCB0aGF0J3Mgd2hhdCBw
ZW9wbGUgdGhvdWdodCBhYm91dCBCcm9hZGNhc3QgUkdCIGF0IHRoZQ0KPiB0aW1lLiBPciBjb2xv
dXIgbW9kZWwvc3Vic2FtcGxpbmcgc2VsZWN0aW9uIG9uIHRoZSB3aXJlLiBPciBvciBvciAuLi4N
Cj4NCg0KWWVzIEkgYWdyZWVkLiBjb250ZW50X3R5cGUgLT4gQUxMTSBkb2Vzbid0IGNsZWFyIHRo
YXQgYmFyLCBhbmQgSSdsbCBkcm9wIGl0Lg0KDQpJJ2xsIHN1Ym1pdCBhbm90aGVyIHY0IGJhc2Vk
IG9uIGJlbG93IHNvb246DQoxLiBLZWVwIG9ubHkgdGhlIGNhc2Ugd2UgaGF2ZSBubyBjaG9pY2Ug
YWJvdXQ6IHNldCBBTExNX01vZGU9MSB3aGVuDQogICAgR2FtaW5nLVZSUiBpcyBhY3RpdmUgKFZS
Ul9FTj0xKSBhbmQgdGhlIHNpbmsgYWR2ZXJ0aXNlcyBBTExNLCBwZXIgc3BlYyA3LjYuNi4NCiAg
ICBUaGlzIHN0YXlzIGluIHRoZSBkcml2ZXIuDQoyLiBSZW1vdmUgdGhlIGNvbnRlbnRfdHlwZSA9
PSBHYW1lIGhldXJpc3RpYyBmcm9tIGJvdGggdGhlIG1vZGVzZXQgYW5kIHRoZQ0KICAgICBmcmVl
c3luYyBwYXRocy4gTm8gaW1wbGljaXQgQUxMTSBkZXJpdmVkIGZyb20gY29udGVudCB0eXBlLg0K
My4gTm8gbmV3IGltcGxpY2l0IHNlbWFudGljcywgYW5kIG5vIERSTS1oZWxwZXIgImRlZmF1bHQi
IGVpdGhlci4gSWYgYQ0KICAgIGNvbmNyZXRlIG5lZWQgZm9yIGV4cGxpY2l0IEFMTE0gY29udHJv
bCBzaG93cyB1cCwgaXQgc2hvdWxkIGJlIGEgcHJvcGVyDQogICAgKGlkZWFsbHkgZ2VuZXJpYykg
cHJvcGVydHkgd2l0aCBhIHJlYWwgdXNlcnNwYWNlIHVzZXIgZHJpdmluZyBpdCwgbm90DQogICAg
c29tZXRoaW5nIHRoZSBrZXJuZWwgaW5mZXJzLg0KDQpSZWdhcmRzLA0KSmVycnkNCg0KPiBDaGVl
cnMsDQo+IERhbmllbA0K
