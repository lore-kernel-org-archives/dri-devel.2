Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A367AC61DCD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 08:31:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F381010E48E;
	Fri, 28 Aug 2026 08:31:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o/DL9MJ2";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010068.outbound.protection.outlook.com [52.101.61.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E15F10E43C;
 Fri, 28 Aug 2026 08:31:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqoMxerTUTpjPMJa1vB6Vhtg+YgmZNjCxSgtDMGjIY7L5dK0bcYYEwK+Mz9BJxzu0QCsFWdvBsSWQI7OMtdGbqsGj2JTJJqXrAuUI4oXdLSV4+3F4bjryuMVVUlzObbojGJpvP4VO66+KgfFoPKu51eJ8nJ8Usn2cyKTxMn+G+q2UR70vyuVgY1us9AHNDcy8tyUAsOa2eBF3Cw4wsZPZwy6CtabrBkqpC1IJaIG3h1gJRG7C3uVXnP8S1awJ1Hy/jVWzxIf8m8AW4k9GZaE6tRA2aEyFdjH5l/Dfvdwt3jX+p3L/yl8wfVxyvaRLKSLwpSB/m3Mhe/4XFZ/iOIuJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gcWZYTYkkL3t+WB0PsIeGXS9wqnpF6OovyJ2Yd34fUM=;
 b=d2dC1dFkDdAVe9I61cKH0Orb7GmqYFCI9zE6URZTj3o2/mEDAK0vUcpUZWrn1a7jZOwgLxOmzWLRTdl5NltrQXqdnHnT+UPLdkZ2kOJdUhlQrbNUBkw/06Nj8OqhWNJF8CCaR76VJUXGEocDJzrfiZgEth76RHmAr6xum+1j0aLtqonuB9oIrnfkTqVjfjpjap80gHEd9vUy3oRNCQqVER8DzFXBgmOpAJAebenGGhZmNIeGvYy1+77c2TgCHpqkn/OvBxebJFogy38QUc8CNFt6RSjbmPfE5e+mGjQGfBVwGL9pepwBN6UINp6O/n3aMhLsaVtvs8gOwIcpEdHPlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcWZYTYkkL3t+WB0PsIeGXS9wqnpF6OovyJ2Yd34fUM=;
 b=o/DL9MJ2qvSuyeMUj/Ax0wyn5SZHuFbqgMKdCdOzPwj0RC+034EV3Q9m3U3g+CF6t3W0k4WFXHtEMMIuEDVvFj9b2DboK/7dZb+ElDFtjPkHgn/opcnVPKFg4MOX2TuBuD1NXTPv68gMKVPumeSBo/CheIZ6eCNMbytetzBPlfg=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by SJ5PPFDF5E260D0.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 08:31:27 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 08:31:27 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, Matthew Brost
 <matthew.brost@intel.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?B?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas.hellstrom@linux.intel.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v4 1/2] drm: Add common drm_user_fence helper
Thread-Topic: [PATCH v4 1/2] drm: Add common drm_user_fence helper
Thread-Index: AQHdNrb7lReEpXy+F0Kp6tSXBWP37LazDQSAgAANE9CAAAQQgIAAAovg
Date: Fri, 28 Aug 2026 08:31:27 +0000
Message-ID: <IA0PR12MB820813A9D08CAF799558FB5A90AC2@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260828063103.4106629-1-srinivasan.shanmugam@amd.com>
 <20260828063103.4106629-2-srinivasan.shanmugam@amd.com>
 <apE17lJZmTD4+5jR@gsse-cloud1.jf.intel.com>
 <IA0PR12MB8208533952E71C3153ED308190AC2@IA0PR12MB8208.namprd12.prod.outlook.com>
 <1ea90a49-ec2f-4150-a7e2-4f645ef3a98b@amd.com>
In-Reply-To: <1ea90a49-ec2f-4150-a7e2-4f645ef3a98b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-28T08:27:29.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|SJ5PPFDF5E260D0:EE_
x-ms-office365-filtering-correlation-id: 4d0d7c66-d231-4995-8e7c-08df04dec0c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: juySxho3AL3auIPoBpfsNRd78290NN3xpTAoiO/9ayl63NR55W9iHoL09X+QhBZTE4Rbg6qWgW21LeHAWwojT5ULqUNGtZMcckTnDn1xZsbMp+1ojNn4ajtqCQd6mP2CqCQyUdb5esS+cR/vofWU5Rqg1Sj/bUCzaNG0Vl8/Z8qBP94Aa31mfl8rhj/MqQ3RsZ9MZmRwDBZv6Eu5e9BfuIslZDAWkTlKFlVXhlMJgoPihwpRxoHXXJLaqmYf7K23ygfp9CzFUKoj8MtWOMWWZJaPv5OoUhfblqHsA8vTSaZMA8rU58fUSfPDKY+hnzeOmDIPlV2SsNj7xXspCMgeyAjyb5cbK6+Ur8CU/cWqNBhS6hfmfEXq5blqvLvvdA/8B1iYw2N0+xk+BoUGwD+TSt03dsJXHoa2VPggG8MVlHiDgY9adqN8OHu3fMIRY07/+GjgTNwM8ZH7H5IkEBKvjYmcXU2A3ww0SxECFn/YpYNxSlvJa69oXhIInpkzt/6NbIMLfCElIf+Dn8u7P2cNzmsIIbUZD5mgIK7GXQoBnuNUTqTPoHFfpZAicDx3cw7WPWu0b1a8JeinxU04DqZv0fWs0ssNkm83SBbAuI0jibDURi1zjzOsKGHKDf1/niQoQ68CXhr8Vv5lwk053cGQoTUFp5nDuLjAPBcygs+EE5QfruCaZE1Ej1sxYIGOX5XqjNIdKVkEKM+nJVmvG+joTS2GcfcCgRQt4TNqpbchSX8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1FSS2pnRHVUNWhWZit0MXpiSnFyR3lvOWQ2em1lN3FSOXNmYXVLVDVBNjdF?=
 =?utf-8?B?ZSttTUJVN1BtSmJ6eHRsYVhuaGpaa2ZlU2Rza0crOVdpalR5dkErK3QrdHZP?=
 =?utf-8?B?VUIyakZNRUJ4NXBxSkpZT2hPMDFCN0daL3lKZWF0WjBocFZuMTFGWS9SaHZJ?=
 =?utf-8?B?WjFsOU9Fc3AwQ0xxd3k2Skc4eTNFSE1NTnR4TzkrQzR4cHcrWkJhdEpoZlYy?=
 =?utf-8?B?ZkE3VFpjc0ZDSFVwdklHeUFmM1JqSFl1SmRqdTZyT0Y3b1hERTZIWmdYZ2Vn?=
 =?utf-8?B?cjB6WHptTWFMTlZzRWtNYXlDS2IydkgvWlRWTlh5YWQyczZyZERGSmNsa25Q?=
 =?utf-8?B?alREejZlbVhBMTk5emJIR3VUVmE2U21tSjduREtoQlBpejQ2cjlaTXlzV0ox?=
 =?utf-8?B?Vkd3ZndQR0JLbDA4Y2NGWFE5M2hiZXpSWXplQ2lIbXlwYW9UenpiQ3ppY0R3?=
 =?utf-8?B?QmJpZGFQQVVKTXlVenQzOVZXMjVORERGWVdpZ3Uybm1lR01Qd29PVGRVbnVw?=
 =?utf-8?B?VjR5OTQ1UnFwbzM3K1BGVU8vUzJtV3pndUs1ZGM2S3RId0luWk9lN1VGMEc1?=
 =?utf-8?B?RVZKem5YbGpGcDJPemZ1Tlh3djlVbHo0MUpnODRTaHdTbzhwU3NINm40Z0Y1?=
 =?utf-8?B?NnZiMXc0L1EzWWFNcVFFQTN0ajNvNkNaaVdBNnpPWDJjSFpndXYrOGlZWERZ?=
 =?utf-8?B?K2llQ3RXUzV4bitnZWlVZm9NK2hjaEdLcTBwYUJ5NVd0M2JVb25BSmxqVGJF?=
 =?utf-8?B?TFgyT2FEMEx0cGx0Ynl1UUE2aTBkL3JIZy96T2FWdjEyVVU1eitud2x0RHhY?=
 =?utf-8?B?S0NLRHp5bkJpV2pHRlJGQ2NmcEtYaG9Ub2VnVjVqU2pVaDBHQVI0dUlJMlhR?=
 =?utf-8?B?YXFVZTJnT3A1b2FBOEs1and3KzNETEo5ck0wenZvWkNsUkVzUHJWUVZZK1ZZ?=
 =?utf-8?B?L0c5Smh5VFB3U21JOXJrVGlyY2xCOEdtSnJ4SEpnUUM4amx3ZjIzbTJIQUJD?=
 =?utf-8?B?b0daTytZYTZKcVNVRTZhZzZiMjU2eC9ZejU4d1RnWTdQSm9IV3Bmei9JeWpw?=
 =?utf-8?B?clc2K05Hc0pOaGN5SDFwaG9DNHVZbFB1OGczMWx2UEFRTjNRUFVZbjBhVkJ5?=
 =?utf-8?B?d3hIeCtPUEthcEJHaDNPTnl4cERNRDIvTjRrUzErYVptQkpCakgwYlhLZUtn?=
 =?utf-8?B?UzZPdlU1ZmdiajBLZGh5WmJFWEhmK0w0VE50VlRvN0lTUGRPRjZnM3hjb0xE?=
 =?utf-8?B?b0VSMVJvbkZyTmZsVVpqdENoQ1M0d1Z1Yi84cEdJMlJzaVZReDgvQVVoSDcv?=
 =?utf-8?B?aDBRcXQ4bjJwQXBrdXRFQ0tHc1hiQkhMZy9vSzhMMDNBWDFnMXZVcXlHTkdS?=
 =?utf-8?B?aFZHWmx2MDRnZS9IZU4vbldINDViOVhJNWNEc01qSkp5alBXRFNQcGVWdkNE?=
 =?utf-8?B?OWtuc01ZTmVNcGRJdHRKb1NQcVVhMFNPa0hDQWNDQVFhNjR6RjNPZVpleEp1?=
 =?utf-8?B?Q3VlU1lwd1B5QWQ2MkhibWFVSURoR0ZXUkp5K1M4UEN3eDR1Sjh5ZTRUam1p?=
 =?utf-8?B?VjUrV21abE80N2k4NzdDR3RBOFhDV2ZYeG1MZktXNFVCdTFDVGoxUTVHQTlC?=
 =?utf-8?B?TVZLN3c2T3I4VlRTSFhkYjdibDdsVUpjWDFZYS9BMHlqTUk4YjB6TnV4Q0pF?=
 =?utf-8?B?RjFHY1V1VERobXlkUzRZZ21wV3h5M0VCUE5IdzgvRnQrb0tCQ29OaDFDRVJt?=
 =?utf-8?B?M25FSi9WWWxwUjdNOW5BeXgrMkQ4TGtLVXVqZ3VOUmxlajQrdDFIRGRlTXNB?=
 =?utf-8?B?SHFVcnQ1b2dXWlhRUUlzanFCNFNTanZyQXo3ME0xZ2srR3NyL2gyVHZJbjF4?=
 =?utf-8?B?M2J6VlpneExycVFleXNlRXNabmZjTFR3WTNmQ1F2L3RLYlI2cmVHUngxTm5y?=
 =?utf-8?B?U0o1MVVDOUtVV1dLK1kwYSt3U3NhZmNXRDkvR0JNV3N5MW1tcEg3dU1Pdm5T?=
 =?utf-8?B?SHM1VDV0bVNnWU9qcWZPUzhoclFKcWpKbDlJYmVZS2F1ZGp1bk1mVHZSaytq?=
 =?utf-8?B?ZHBORHE4Z3YyL0t6NzIrZzVWWEFNd3JIZHU2eGVwUU9DYmxQNG9McGV6RjMx?=
 =?utf-8?B?YU0zMFBCcXpqaFhERk4yWWtYeW1SNURkcGtsS2o0Ni82R05SUnUrRzRmcHdt?=
 =?utf-8?B?OVhaZVBLS01Md3pMbVhmenpMQktSZWZ1UUo4STVhdTVCVmt4SnlqL2QrUmFs?=
 =?utf-8?B?bFFVcStmSFNuc2hrQ3pSaU9sdGVXVW9mL1AzNnd3YUtZN1pWZHBkNm1jZHRm?=
 =?utf-8?Q?MvJ0ICRbITaHD1f3wy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0d7c66-d231-4995-8e7c-08df04dec0c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 08:31:27.2855 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gSCWZwGDxx6ykx3Tg0hLXPi8srmo7P1GIYrpWs8YRi2VjnTcHaAjnq7A+5LoKK+vOBMA6VSnGEC96oXTyBzsOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDF5E260D0
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

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLb2Vu
aWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTZW50OiBGcmlkYXks
IEF1Z3VzdCAyOCwgMjAyNiAxOjQ4IFBNDQo+IFRvOiBTSEFOTVVHQU0sIFNSSU5JVkFTQU4gPFNS
SU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+Ow0KPiBNYXR0aGV3IEJyb3N0IDxtYXR0aGV3LmJy
b3N0QGludGVsLmNvbT4NCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNo
ZXJAYW1kLmNvbT47IE1hYXJ0ZW4gTGFua2hvcnN0DQo+IDxtYWFydGVuLmxhbmtob3JzdEBsaW51
eC5pbnRlbC5jb20+OyBNYXhpbWUgUmlwYXJkIDxtcmlwYXJkQGtlcm5lbC5vcmc+Ow0KPiBUaG9t
YXMgWmltbWVybWFubiA8dHppbW1lcm1hbm5Ac3VzZS5kZT47IERhdmlkIEFpcmxpZQ0KPiA8YWly
bGllZEBnbWFpbC5jb20+OyBTaW1vbmEgVmV0dGVyIDxzaW1vbmFAZmZ3bGwuY2g+OyBTdW1pdCBT
ZW13YWwNCj4gPHN1bWl0LnNlbXdhbEBsaW5hcm8ub3JnPjsgVGhvbWFzIEhlbGxzdHLDtm0NCj4g
PHRob21hcy5oZWxsc3Ryb21AbGludXguaW50ZWwuY29tPjsgZHJpLWRldmVsQGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZzsgaW50ZWwtDQo+IHhlQGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgbGludXgtbWVk
aWFAdmdlci5rZXJuZWwub3JnOyBsaW5hcm8tbW0tDQo+IHNpZ0BsaXN0cy5saW5hcm8ub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDEvMl0gZHJtOiBBZGQgY29tbW9uIGRybV91c2Vy
X2ZlbmNlIGhlbHBlcg0KPg0KPiBPbiA4LzI4LzI2IDEwOjA2LCBTSEFOTVVHQU0sIFNSSU5JVkFT
QU4gd3JvdGU6DQo+IC4uLg0KPiA+Pj4gKy8qKg0KPiA+Pj4gKyAqIHN0cnVjdCBkcm1fdXNlcl9m
ZW5jZSAtIGVtYmVkZGFibGUgRFJNIHVzZXIgZmVuY2UNCj4gPj4+ICsgKg0KPiA+Pj4gKyAqIERy
aXZlcnMgZW1iZWQgdGhpcyBpbiB0aGVpciBvd24gc3RydWN0dXJlIGFuZCBpbXBsZW1lbnQNCj4g
Pj4+ICsgKiAmZHJtX3VzZXJfZmVuY2Vfb3BzLiBDYWxsIGRybV91c2VyX2ZlbmNlX2luaXQoKSBh
dCBjcmVhdGlvbiBhbmQNCj4gPj4+ICsgKiBkcm1fdXNlcl9mZW5jZV9hZGRfY2FsbGJhY2soKSB0
byBhcm0gb24gYSBkbWEtZmVuY2UuDQo+ID4+PiArICogQ2FsbCBkcm1fdXNlcl9mZW5jZV9jYW5j
ZWxfc3luYygpIGJlZm9yZSBkcml2ZXIgdGVhcmRvd24uDQo+ID4+PiArICovDQo+ID4+PiArc3Ry
dWN0IGRybV91c2VyX2ZlbmNlIHsNCj4gPj4NCj4gPj4gU2hvdWxkIHRoaXMgY29tbW9uIGxheWVy
IGJlIHNwbGl0IGludG8gdHdvIGRpc3RpbmN0IGNvbmNlcHRzPw0KPiA+Pg0KPiA+PiAtIGRybV93
b3JrX2ZlbmNlOiA5MCUgb2Ygd2hhdCBpcyBoZXJlLCBtaW51cyB0aGUga3RocmVhZF91c2VfbW0o
KSBhbmQNCj4gPj4gICBtbS1yZWxhdGVkIGNvZGUuDQo+ID4+IC0gZHJtX3VzZXJfZmVuY2U6IGEg
c3ViY2xhc3Mgb2YgZHJtX3dvcmtfZmVuY2UgdGhhdCBhZGRzIHRoZQ0KPiA+PiAgIGt0aHJlYWRf
dXNlX21tKCkgYW5kIG1tLXJlbGF0ZWQgY29kZS4NCj4gPj4NCj4gPj4gSSBzdWdnZXN0IHRoaXMg
YmVjYXVzZSBJIHdhcyB0aGlua2luZyBhYm91dCBpdCB0aGUgb3RoZXIgZGF5IChJDQo+ID4+IGZv
cmdldCB0aGUgZXhhY3QNCj4gPj4gY29udGV4dCkgYW5kIHJlY29uc2lkZXJlZCBhIHBhdHRlcm4g
d2hlcmUgYSBmZW5jZSBzaWduYWxzIGFuZCB0aGVuIEkNCj4gPj4gbmVlZCBhIHdvcmtlciBiZWNh
dXNlIHNvbWUgd29yayBtdXN0IGJlIGRvbmUgb3V0c2lkZSBvZiBJUlEgY29udGV4dC4NCj4gPj4g
QSB1c2VyIGZlbmNlIGlzIG9uZSBleGFtcGxlLCBzaW5jZSBjb3B5X3RvX3VzZXIoKSBjYW4gZmF1
bHQsIHdoaWNoIGlzDQo+ID4+IG5vdCBhbGxvd2VkIGluIElSUSBjb250ZXh0LiBBdCB2YXJpb3Vz
IHRpbWVzIGluIFhlIHdlJ3ZlIGhhZCBtdWx0aXBsZQ0KPiA+PiBwYXR0ZXJucyBsaWtlIHRoaXMs
IGFsdGhvdWdoIGF0IHRoZSBtb21lbnQgdXNlciBmZW5jZXMgYXJlIHByb2JhYmx5DQo+ID4+IHRo
ZSBvbmx5IGNhc2UgdGhhdCByZXF1aXJlcyBpdC4gSWYgd2UgbG9va2VkIGFjcm9zcyBEUk0gYXMg
YSB3aG9sZSwgSSBzdXNwZWN0DQo+IHdlJ2QgZmluZCB0aGlzIHBhdHRlcm4gb3Blbi1jb2RlZCBp
biBhIG51bWJlciBvZiBwbGFjZXMuDQo+ID4+DQo+ID4+IFllcywgZHJtX3VzZXJfZmVuY2Ugd291
bGQgYmUgYSB2ZXJ5IHRoaW4gbGF5ZXIgb24gdG9wIG9mDQo+ID4+IGRybV93b3JrX2ZlbmNlLCBi
dXQgSSBzdGlsbCBzZWUgdmFsdWUgaW4gdGhlIHNwbGl0Lg0KPiA+DQo+ID4gSGkgTWF0dCwNCj4g
Pg0KPiA+IFRoYW5rcyBmb3IgdGhlIHJldmlldyBhbmQgZm9yIGJlaW5nIHN1cHBvcnRpdmUgb2Yg
dGhlIGlkZWEuDQo+ID4NCj4gPiBUaGUgc3BsaXQgaW50byBkcm1fd29ya19mZW5jZSAoZ2VuZXJh
bCBmZW5jZS10by13b3JrcXVldWUgcGF0dGVybikgYW5kDQo+ID4gZHJtX3VzZXJfZmVuY2UgKHN1
YmNsYXNzIGFkZGluZyBrdGhyZWFkX3VzZV9tbSkgbWFrZXMgc2Vuc2UuIEknbGwNCj4gPiByZXN0
cnVjdHVyZSB2NSBhcyBmb2xsb3dzOg0KPiA+DQo+ID4gICBkcm1fd29ya19mZW5jZToga3JlZiwg
d29ya19zdHJ1Y3QsIGRtYV9mZW5jZV9jYiwgc3RvcmVkIGZlbmNlIHJlZiwNCj4gPiAgICAgICAg
ICAgICAgICAgICB3cSwgb3BzIOKAlCBhZGRfY2FsbGJhY2ssIGNhbmNlbCwgY2FuY2VsX3N5bmMN
Cj4NCj4gWWVhaCwgdGhpcyBwYXR0ZXJuIGNhbWUgdXAgc28gb2Z0ZW4gdGhhdCBJIGFscmVhZHkg
Y29uc2lkZXJlZCBhZGRpbmcgaXQgdG8gdGhlIGNvcmUNCj4gZG1hX2ZlbmNlIGZyYW1ld29yay4N
Cg0KSGkgQ2hyaXN0aWFuLA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCg0KT24gZG1hX2Zl
bmNlX3dvcms6IHdvdWxkIHlvdSBwcmVmZXIgSSBwbGFjZSB0aGUgZ2VuZXJpYyBmZW5jZS10by13
b3JrDQpoZWxwZXIgZGlyZWN0bHkgaW4gdGhlIGNvcmUgZG1hX2ZlbmNlIGZyYW1ld29yayAoZHJp
dmVycy9kbWEtYnVmLyksDQpvciBpcyBzdGFydGluZyB3aXRoIGRybV93b3JrX2ZlbmNlIGluIERS
TSBhbmQgcHJvbW90aW5nIGl0IGxhdGVyIGFsc28NCmFjY2VwdGFibGU/DQoNCkknbGwgYWRkIHRo
ZSB2YWx1ZSBjb21wYXJpc29uIGxvZ2ljIGFuZCB3aWxsIGFkZCBhIGNsZWFyIG5vdGUgdGhhdCB0
aGlzIGNhbm5vdCBiZQ0KdXNlZCB0byBpbXBsZW1lbnQgZG1hX2ZlbmNlX29wcy4NCg0KVGhhbmtz
LA0KU3JpbmkNCg==
