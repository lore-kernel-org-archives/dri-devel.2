Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6124AC61DFD
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 11:13:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F25210E2D8;
	Mon, 31 Aug 2026 11:13:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iby3EnCm";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012048.outbound.protection.outlook.com
 [40.93.195.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFD2910E195;
 Mon, 31 Aug 2026 11:13:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QGP9rCQKkHSHAjj5t1FLK6lELdjnepv94O3rEHifkVn61KEvZAQw5PILMCsG4XTtLqLlYwQdtKlir/+JEfPmp7e7WhPHKSe/GoW45rRVg/hnlyJKc2LqcoRXkM+Q14XMaFH9ZyqJlnJh4JplPsWKwErePc+e9QW4CY6jrZxMKYPtY2df/OhjkLNC5O9DhcGPgpLRpT5ZFWX6abjPxEfN3xSuZUTVrE6rY+kV0NQRqLFG+j2BHMxiNOLFxojHxDV3pUU/UVK47wm8Y1DM9bLPxz+c3M+7gvkdBu/0H1fdff05kqzMoAOrVEUmEPN2lPkh5+HINdc2Qh/NqXPHTD5a5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2jqjb8ClgAgPR5pB8gpLSRiAjPf+ICUZ9715GD7eVY=;
 b=MJ9q7SWt+MDhVZ9XFySd6BCcfkkDMr/y7uarx56QqT3YsmzIuFw9ErBvj+HaX/E1eomg3iILtYAOZOBBgejyWGMqYqhbKLZKCQw/IPdk7NLOtySelf4mv0lGIunI3WiRai8AcBBC+fikLjA1sH4UhknnvfteLLy5m0kx6EtGHwbarqF/pJ092orJSp/ip9UAWknm+H5qhZ7s3mF9SJcsaRy/0IPuWX380cpxXfEibBolSKfK905f0oQiu+97/qlWaYdNYmhgyYLUVDHocquCNwT1ampS8Z9PTTzLGFwHG6iOzHdJA7APbKBh0KzWKt3T4c+AJBP1nbGeRFVAhSm66A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2jqjb8ClgAgPR5pB8gpLSRiAjPf+ICUZ9715GD7eVY=;
 b=iby3EnCm1pR44BKmPVNBP5Q4nXaQKSXnSKOIg38gpwJqtMzq6uctdBlAvqO84PAvcLhaRH/zWLW965NIo1wXULoDZA2yyC5DU/cxKH2rIMWGAvK3NYElTOyF5HT+DZkWWLmkJraJiaRZZybgMlRmwCA1qajS8CcA1yqQIqOH1/I=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by IA0PR12MB9047.namprd12.prod.outlook.com (2603:10b6:208:402::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 11:13:21 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 11:13:21 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: =?utf-8?B?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas.hellstrom@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Mika
 Kuoppala <mika.kuoppala@linux.intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "intel-xe@lists.freedesktop.org"
 <intel-xe@lists.freedesktop.org>, "SHANMUGAM, SRINIVASAN"
 <SRINIVASAN.SHANMUGAM@amd.com>
Subject: RE: [PATCH v5 0/4] drm: Add common drm_work_fence/drm_user_fence
 helpers and convert XE
Thread-Topic: [PATCH v5 0/4] drm: Add common drm_work_fence/drm_user_fence
 helpers and convert XE
Thread-Index: AQHdOQt+fLKOC8idBEya+WClqd29KLa38WwAgAANkpA=
Date: Mon, 31 Aug 2026 11:13:21 +0000
Message-ID: <IA0PR12MB8208B09EDCF4E0D77B58299290A92@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260827062142.4038272-1-srinivasan.shanmugam@amd.com>
 <20260831054154.107602-1-srinivasan.shanmugam@amd.com>
 <772d17307920288d82c55518322d2b65686fcd25.camel@linux.intel.com>
In-Reply-To: <772d17307920288d82c55518322d2b65686fcd25.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-31T11:04:50.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|IA0PR12MB9047:EE_
x-ms-office365-filtering-correlation-id: 1a4aeb2f-cf5a-4230-0c3b-08df0750de1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|38070700021|6133799003|4143699003|11063799006|10067099003;
x-microsoft-antispam-message-info: Iv1QXl9kBMCk/zFB9gfqnDESZg93HzFD3XHbew53MMYypV33+0EtMIimfdkczKXCCjsogahiTIHHiJcvYQgKeAYynmrqrFOExmQDLbi4c5+HSmtCVv38t18eJpAW5hUsz0/Fe8wE6xx4IoeA1X2sHbHy2+4hwWXd3SRALGmSEqYC4Kx2n7s7PxMzp3GmjTfTAlSzrQT+Nk8cRX76hYm9l6W5Vg9M+k8RTU5gs7oACRiBGy6jfb1S2veOeAD1/vY4+/KUw2CdVVT4UiqSlUOr/tLchzK3sU70VH0KuE0+Nzj8xtNHroEZj0H37dEUWD7Kcc2gZSv/SQ4QO62s8fgbXrql+mVrPqn9PkbVdzlryvz3HGRR0g6n2qqv9s5WJ8I35xxRW4U/sOKawauwDUy/5VCtVJYFpN357AgK0B2kk62ReZBauaMzm+MDpVWCBD5vYvqPTlYnDrCS1wMLWQsnzyJtsc1MFTmDSlwy/XwsI8p7AaVSVjqd5msHUGczire3vQv2N7w5vxuNcZupx0ojllML0wu5WbAti62maFjUthLFJSMJW3cG1DxE8mIbq6xefjiifCU21fbJUXkyi4/FAbWwDX47wY6V566MTx+VFTOlGBiqyMWNNqajH9sLOEYAoZNQ4u4XQa+aG1AvSeL/zYIN+PafhfcEqS/1B+O+GOska5sMSp+KJ3N/epxSy5HvO9pjOjlOEdC5s4VCDDZIsnMmkimRfBu1P5/ylmQti2A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(38070700021)(6133799003)(4143699003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDdXNnA0aUpUWDBQTmszUTFmLzhOd3ErclIxMmp3bWViaDJKSkUxY2FaZmxZ?=
 =?utf-8?B?SmxTQ2I3QWR3WjZJYkw4WUR6bW5SU0ZSOFhFOUczU2lkZlNYeUllWmQ2WWdu?=
 =?utf-8?B?QmUvNFZhWGgzNlRzaFh2K09PNGoyZ1hYYmI2VUsySDdIVSs0YS9Ld3ZEVnBS?=
 =?utf-8?B?YUNPN2p5V3NGYXlWUG1NRkFSd0NhSTdETUFZMm9ETHRjVGE5b3V6Q0FIbDNY?=
 =?utf-8?B?VW1WdUQ2TjM0d2M5c1FMblRHdGVRbVM4UW9LaDFDUzFPbXBySmtkRFcrdGQ5?=
 =?utf-8?B?Vk4zaWxQbHJjRHBENlRRTFlwOE0yM0RCVFdydGQ0YVFLWEFGSzFMSXF6ZjhL?=
 =?utf-8?B?ME9xVEtzS2s3RGtwcVhFSVB1RlZ5SmZ2ODRTQmJYaGtJQm14QVBHSmtheVZ6?=
 =?utf-8?B?V0dLSnB0WmlSbWtOZXZwR0U1WVhBM1FDYTFpZVBaWUhQYlJaYUJrRFZ5SzQy?=
 =?utf-8?B?M2h2eDlrWit5VUQxS2FXU3ZZZFNrY1RPbm1oWWxzUTljUFdrdncxRkFKYStF?=
 =?utf-8?B?UlVrd3pRdlArVEFPMXdsTVlLKzJmWmZxZ1FXdVA5T3pjTEJqek9HV0JEM1d0?=
 =?utf-8?B?MVJXOFMxRHNHdHoyUlQ3SGFlam5kdUZBQy94TzV5OGl6VFVoc2ZEcjNYMm1F?=
 =?utf-8?B?MnZjbGdESGNEQW9CYWRHcUdOSDdCQy9ZS1lRMXNRd3FSSHZORVlQRi9YSjU1?=
 =?utf-8?B?NnBNRHdkY3hpWHg2MXdIY0RYMjB4blRQZUIvaVdUdURsWEpwTGVCdkpJa0Zx?=
 =?utf-8?B?N1MwbExOMlcySkozWUFNMTRaR1VpeFJiQ2F6V2F2OUtjUUZZZGlaa09JSTJz?=
 =?utf-8?B?ODBuaGx0OHNzNFVsYXorczFUMmxvbVZwcmR0VW5xMjFMdEt5WkNWci9GOUtt?=
 =?utf-8?B?eGt3TWdFeFhMR0VoVU1RTjNMRVprSXVZZFFsUGR0dG41UWMzMGRIUGVPazV4?=
 =?utf-8?B?ZjdSbjd6NEIxaThrZE1PK3pOMVNrN3ZlbFcwYW9IK1pjR2gzVkNTOTRsVGZH?=
 =?utf-8?B?R1dESHJCTGtrYkJ3RmF3ZlBaNlhnNVd6Wk9SVU9JKzg4eHRtaW50K01xY2NJ?=
 =?utf-8?B?SjIxODc0a24vUWQxTjA0aXJReHA3dWNTTUlaZStURDN1N0E1cVd4UFptSExV?=
 =?utf-8?B?M01SOXBSMUZnZnN2U3NaenhZSjYxVG91SjJ5UVJTcVZvcy80RUNsWTVWVGNW?=
 =?utf-8?B?VTIxMjBBNHRBQnAzWXlvRXBDKzNOcU9sTTFOV1JmRUtXd0lqalF3ZFJMVVkw?=
 =?utf-8?B?cmNPTElKN2d5ckhpejhXMGxia0o5THJaMGNaRWpORXlNcjRndUF0a2RPakt3?=
 =?utf-8?B?Qk5DT0xRY3VKZUR3RXVZTHF5VGxJOStxcVlBTjJya0VqWnp5SmNVS2IxZ2Fk?=
 =?utf-8?B?U2RxR2w4TXFlOFRIc1N2WVpFRVdiWE9Cbjc4d3NPTEEvcUlTNU9tZ2ZTa3U5?=
 =?utf-8?B?elFiOVRVa1VoZHAzZkJ3eXVYVzhJNlZTenFCK2Q1WllwcnZPNjhhWFYwZ1dV?=
 =?utf-8?B?QWtvVEQxQkMvcE85OG9vTlBzNkNrb24xV1kwaXRxNlJNd0lMUVkvbGtva0FU?=
 =?utf-8?B?QkhhOE13RENlVWZOcC9WSzRUZnNCSk9rb2Nrb0wzaXBEb3hpWDlwVU0xVm5N?=
 =?utf-8?B?K2NhTEpFVFpoeDNtc25SdSthSk15NENmWmxLd01XYjdzQ0UveW5lS05Samlo?=
 =?utf-8?B?cUREVm9Bc1J2ZVVTdVhqeGNaTFhhV3NOMkZkeTExNkZ4N1czSTJYeFQ4S2R3?=
 =?utf-8?B?RkRZNlR3RUU5Wm8zdW5Ca2I4MHovemRYYkExUGdERzNUbHJwZmNCckdIYVBl?=
 =?utf-8?B?UmIwY3JpWkIxWW1zbGJGNDNkZU5FMW41NEpEc1h6S1Y3U293WWtNVWM5bWhw?=
 =?utf-8?B?a2VoQitBVFNxWUMrcEg4S0Q4OWlLWjNMU0JaWG5DZDc1UnhSRDVwdnNZYU9j?=
 =?utf-8?B?OEhad0ZuVC83R0Zudk5OL3BtNkwrbmR2T1Y0NTNnYjQyUXBHY2puY3R0TlFh?=
 =?utf-8?B?ak1Ca2drTnZVbXd0RkFQVnlLYm0ramFUU2p4WXdLY1crM0VreFZkbEhKK0FG?=
 =?utf-8?B?b1JvMXZlcktPYTNRWFNONlNvaU84cEpNUSsrNnZCeTVacEFOeU5JR05xVlFp?=
 =?utf-8?B?Zzgxa2JLNitZMmhBR2RJaGZ3b014LzRheXN4QSs5SEpDTWRuWXNRQ1VPS1lR?=
 =?utf-8?B?MkR4eVpCaCtBblhkbDZRb3lZRzVxL3h5TjcxS0V4SERGaUd4UEtYY0ZtUHBw?=
 =?utf-8?B?b0cyYzJiZERZWlpZWWZudTF1Q2lEOTlmQ2dnakJqOUgzSlZiK2JsVkJOU3g1?=
 =?utf-8?Q?gJiIzQZ2vLbK7ST/ZP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4aeb2f-cf5a-4230-0c3b-08df0750de1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 11:13:21.4764 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WV0S2TRLMPfQm1rh+7DQ7JYJyHfBnB+wNsnTtDpCaP9MfNSvuCr2jfMJcVY4jzCU1qLd1lTdNN9ylXIId2uUXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9047
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

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaG9t
YXMgSGVsbHN0csO2bSA8dGhvbWFzLmhlbGxzdHJvbUBsaW51eC5pbnRlbC5jb20+DQo+IFNlbnQ6
IE1vbmRheSwgQXVndXN0IDMxLCAyMDI2IDM6NDYgUE0NCj4gVG86IFNIQU5NVUdBTSwgU1JJTklW
QVNBTiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT47DQo+IE1hdHRoZXcgQnJvc3QgPG1h
dHRoZXcuYnJvc3RAaW50ZWwuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4NCj4gPENocmlzdGlhbi5L
b2VuaWdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJA
YW1kLmNvbT4NCj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBNaWthIEt1b3Bw
YWxhDQo+IDxtaWthLmt1b3BwYWxhQGxpbnV4LmludGVsLmNvbT47IE1hYXJ0ZW4gTGFua2hvcnN0
DQo+IDxtYWFydGVuLmxhbmtob3JzdEBsaW51eC5pbnRlbC5jb20+OyBkcmktZGV2ZWxAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnOyBpbnRlbC0NCj4geGVAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMC80XSBkcm06IEFkZCBjb21tb24gZHJtX3dvcmtfZmVuY2Uv
ZHJtX3VzZXJfZmVuY2UNCj4gaGVscGVycyBhbmQgY29udmVydCBYRQ0KPg0KPiBPbiBNb24sIDIw
MjYtMDgtMzEgYXQgMTE6MTEgKzA1MzAsIFNyaW5pdmFzYW4gU2hhbm11Z2FtIHdyb3RlOg0KPiA+
IFdoZW4gYSBHUFUgZG1hLWZlbmNlIHNpZ25hbHMsIGRyaXZlcnMgb2Z0ZW4gbmVlZCB0byBwZXJm
b3JtIHdvcmsgdGhhdA0KPiA+IGNhbm5vdCBydW4gaW4gSVJRIGNvbnRleHQuIFRoaXMgcGF0dGVy
biBpcyBjdXJyZW50bHkgb3Blbi1jb2RlZCBpbg0KPiA+IG11bHRpcGxlIGRyaXZlcnMuDQo+ID4N
Cj4gPiBUaGlzIHNlcmllcyBpbnRyb2R1Y2VzIHR3byBsYXllcmVkIGhlbHBlcnM6DQo+ID4NCj4g
PiBQYXRjaCAxIGludHJvZHVjZXMgZHJtX3dvcmtfZmVuY2Ug4oCUIGEgZ2VuZXJpYyBlbWJlZGRh
YmxlIGJhc2UNCj4gPiBzdHJ1Y3R1cmUgdGhhdCBoYW5kbGVzIHRoZSBkbWEtZmVuY2UtY2FsbGJh
Y2stdG8td29ya3F1ZXVlIHBhdHRlcm4uDQo+ID4gQW55IGRyaXZlciBuZWVkaW5nIGRlZmVycmVk
IGZlbmNlIHdvcmsgY2FuIHVzZSB0aGlzIGRpcmVjdGx5Lg0KPiA+DQo+ID4gUGF0Y2ggMiBpbnRy
b2R1Y2VzIGRybV91c2VyX2ZlbmNlIOKAlCBhIHRoaW4gbGF5ZXIgb24gdG9wIG9mDQo+ID4gZHJt
X3dvcmtfZmVuY2UgdGhhdCBhZGRzIGt0aHJlYWRfdXNlX21tKCkgc3VwcG9ydCBmb3IgZHJpdmVy
cyB0aGF0DQo+ID4gbmVlZCB0byBhY2Nlc3MgdXNlcnNwYWNlIG1lbW9yeSB3aGVuIGEgZmVuY2Ug
c2lnbmFscy4NCj4gPg0KPiA+IFBhdGNoIDMgY29udmVydHMgWEUgdG8gdXNlIGRybV91c2VyX2Zl
bmNlLiBYRSBjb250aW51ZXMgdG8gd3JpdGUgYQ0KPiA+IGZlbmNlIGNvbXBsZXRpb24gdmFsdWUg
dG8gYSB1c2Vyc3BhY2UgVkEgdXNpbmcgdGhlIG5ldyBoZWxwZXIuDQo+ID4NCj4gPiBQYXRjaCA0
IGFkZHMgb3B0aW9uYWwgcGVyLXNpZ25hbCBjb21wYXJlIGZ1bmN0aW9uYWxpdHkgdG8NCj4gPiBk
cm1fdXNlcl9mZW5jZS4NCj4gPiBXaGVuIGNtcF9hZGRyIGlzIHNldCwgdGhlIHdvcmtlciBpcyBj
YWxsZWQgb25seSBpZiB0aGUgdmFsdWUgYXQNCj4gPiBjbXBfYWRkciBzYXRpc2ZpZXMgdGhlIGNv
bmZpZ3VyZWQgY29tcGFyaXNvbi4gVGhpcyBlbmFibGVzIEFNREdQVSdzDQo+ID4gRU9QIGV2ZW50
ZmQgcGVyLXNpZ25hbCBmaWx0ZXJpbmcgd2l0aG91dCBvcGVuLWNvZGluZyB0aGUgcmVhZCtjb21w
YXJlDQo+ID4gcGF0dGVybi4NCj4gPg0KPiA+IEEgZm9sbG93LW9uIHBhdGNoIChub3QgaW4gdGhp
cyBzZXJpZXMpIHdpbGwgd2lyZSBBTURHUFUncyByZW5kZXItbm9kZQ0KPiA+IEVPUCBldmVudGZk
IHNpZ25hbGluZyBwYXRoIHRvIGRybV93b3JrX2ZlbmNlLg0KPiA+DQo+ID4gdjU6DQo+ID4gIC0g
U3BsaXQgZHJtX3VzZXJfZmVuY2UgaW50byBkcm1fd29ya19mZW5jZSAoZ2VuZXJpYykgYW5kDQo+
ID4gZHJtX3VzZXJfZmVuY2UNCj4gPiAgICAoTU0tYm9ycm93aW5nIHN1YmNsYXNzKSBwZXIgTWF0
dGhldyBCcm9zdCdzIHN1Z2dlc3Rpb24uDQo+ID4gIC0gQWRkIHBlci1zaWduYWwgY29tcGFyZSBm
dW5jdGlvbmFsaXR5DQo+ID4gKGRybV91c2VyX2ZlbmNlX3NldF9jb21wYXJlKCkpDQo+ID4gICAg
cGVyIENocmlzdGlhbiBLw7ZuaWcncyBzdWdnZXN0aW9uLg0KPiA+ICAtIFVzZSBtbXB1dF9hc3lu
YygpIGluc3RlYWQgb2YgbW1wdXQoKSB0byBhdm9pZCBwb3RlbnRpYWwgZGVhZGxvY2sgaW4NCj4g
PiAgICBNTVUgbm90aWZpZXIgcmVsZWFzZSBwYXRoLiAoU2FzaGlrbyByZXZpZXcpDQo+ID4NCj4g
PiBTdWdnZXN0ZWQtYnk6IE1hdHRoZXcgQnJvc3QgPG1hdHRoZXcuYnJvc3RAaW50ZWwuY29tPg0K
PiA+IFN1Z2dlc3RlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQu
Y29tPg0KPiA+IENjOiBNaWthIEt1b3BwYWxhIDxtaWthLmt1b3BwYWxhQGxpbnV4LmludGVsLmNv
bT4NCj4gPiBDYzogVGhvbWFzIEhlbGxzdHLDtm0gPHRob21hcy5oZWxsc3Ryb21AbGludXguaW50
ZWwuY29tPg0KPiA+IENjOiBNYWFydGVuIExhbmtob3JzdCA8bWFhcnRlbi5sYW5raG9yc3RAbGlu
dXguaW50ZWwuY29tPg0KPiA+IENjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+
ID4gQ2M6IGludGVsLXhlQGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiA+IENjOiBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZw0KPg0KPiBJIHRoaW5rIHRoZSBnZXRfdXNlcigpIGFuZCBwdXRf
dXNlcigpIG9mIDY0LWJpdCB2YWx1ZXMgaW4gZHJtIChkcml2ZXINCj4gY29tbW9uKSBjb2RlIGlz
IG5vdCBzYWZlIGZvciB0eXBpY2FsIHVzZS1jYXNlcyBvbiAzMi1iaXQgc3lzdGVtcy4gRm9yIHhl
IHdlDQo+IG9mZmljaWFsbHkgZG9uJ3QgKHlldCBhdCBsZWFzdCkgc3VwcG9ydCAzMi1iaXQgc3lz
dGVtcyBzbyBoZW5jZSB0aGUgY29kZSBpcyBhIGJpdCBzbG9wcHkNCj4gYnV0IGZvciBkcm0gaGVs
cGVycyBJJ20gbm90IHN1cmUgd2UgY2FuIGdldCBhd2F5IHdpdGggdGhpcy4gQXQgbGVhc3Qgbm90
IHdpdGhvdXQgc29tZQ0KPiBmb3JtIG9mIHdhcm5pbmcgb3IgYXNzZXJ0Lg0KPg0KPiBJIHRoaW5r
IHRvIG1ha2UgMzItYml0IHN5c3RlbXMgNjQtYml0IHVzZXItZmVuY2Ugc2FmZSwgd2Ugd291bGQg
bmVlZCB0byB1c2VyDQo+IHBpbl91c2VyX3BhZ2VzKCkgY29tYmluZWQgd2l0aCBjbXB4Y2hnNjQo
KSBhbmQgYSBzaW1pbGFyIGNtcHhjaGcgb3BlcmF0aW9uIG9uDQo+IHRoZSB1c2VyLXNwYWNlIHNp
ZGUuDQoNCkhpIFRob21hcywNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQpGb3IgdGhlIDMy
LWJpdCBzYWZldHkgY29uY2VybiBvbiBnZXRfdXNlcigpIG9mIHU2NCB2YWx1ZXMg4oCUDQpzaW5j
ZSBubyBjdXJyZW50IEdQVSBkcml2ZXIgc3VwcG9ydHMgMzItYml0IHVzZXIgZmVuY2VzDQooWEUg
ZXhwbGljaXRseSBleGNsdWRlcyAzMi1iaXQsIGFuZCBBTURHUFUgdGFyZ2V0cyBtb2Rlcm4gaGFy
ZHdhcmUpLA0Kd291bGQgYWRkaW5nIGEgQlVJTERfQlVHX09OIG9yIElTX0VOQUJMRUQoQ09ORklH
XzY0QklUKSBndWFyZCBpbg0KZHJtX3VzZXJfZmVuY2Vfc2V0X2NvbXBhcmUoKSBiZSBhY2NlcHRh
YmxlIGZvciBub3c/DQoNCklmIGEgMzItYml0IGRyaXZlciBldmVyIG5lZWRzIHRoaXMgaW4gdGhl
IGZ1dHVyZSwgd2UgY2FuIGZvbGxvdyB1cA0Kd2l0aCBwaW5fdXNlcl9wYWdlcygpICsgY21weGNo
ZzY0KCkgZm9yIHByb3BlciBhdG9taWMgYWNjZXNzLg0KDQpEb2VzIHRoYXQgYXBwcm9hY2ggd29y
ayBmb3IgeW91Pw0KDQpUaGFua3MsDQpTcmluaQ0K
