Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14256C61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 09:33:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6214710F31A;
	Fri, 28 Aug 2026 09:33:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SEFb5xg+";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010021.outbound.protection.outlook.com [52.101.56.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17A5810F31D;
 Fri, 28 Aug 2026 09:33:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6ByLo0skfr1Bnbu4HP7ZnMZKRkH9a45L3fQfqesKh2MwkME9lBjY5D5mNNG3Qc0mrvJEBjPLekTKtXSwuF/S6djP9WjKKv9H6og8XPdcNl0rPF+gW0ARS2M3iTEMuCVz8OCC4Jh2X7NmT6LLJ9tF4H+4SfqwXD6BGPaY2H+uQqSVSjsEmb6f7184n+HeaH4oSL8m6++DNQSBggqHhh3+4Tr0LZR9Nc2LPIxj1+OQavi6FLnFjgYHlSIo+X09G9aeTJQxTNL0KA4LVa6kRsmcjMO1XCCpdHC1sPQDmaMlpOJY8paBOaxGCBioOOxLhfR3+1J53IO9CnwwX8IoqBSbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDDx7/FscsuMij3hmbW/+LUILSpsljmhbkyqauKaMq4=;
 b=PMkuc7l4xDrn9LF/uh7mDh29CdnDgtRDpomfss8vQT50naQuL6QLAjXqKeHr/62p+zFn6U+JzoaJ3Dyf9v1ewC5kpOiLGpoWwwobaclx0NOutRkQigI15k+ti5hWZDOarX+6jW15XQKZg4Rg5MXr4d3AXWqATucmkdhGE25xijwE7Fv6fpRsUZZTl32Q5u+Ov/p1EqPxqMzw+v/IYjlG88+ShOUiw4VVdS8vUmEcqWP+biU4+rrFH1jKzNacw36Q7LJTc3FwDkMr33+zl9Vx581XXeKIylMPN76lO1pDLphW2Tnu+VujTjTj5Gu/JRiBemqhL2Y+KJue8459P5yJkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDDx7/FscsuMij3hmbW/+LUILSpsljmhbkyqauKaMq4=;
 b=SEFb5xg+K9/uE8hfWrq6tImsfegIpxVbwTYkwnlyQOVzusZ0Jy0+l6926//rH8uquh/8dozxhHdCVQtLs14tJpLRrcWF/AborB3+sam3zvbv5ww8tI/6jnsAob6M1AKg+yGiFoPKmgtd7sdx5MpZpwJTuKrqqgLMPneAixjQr6o=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by BL1PR12MB5755.namprd12.prod.outlook.com (2603:10b6:208:392::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 28 Aug
 2026 09:33:00 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 09:33:00 +0000
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
Thread-Index: AQHdNrb7lReEpXy+F0Kp6tSXBWP37LazDQSAgAANE9CAAAQQgIAAAovggAAMmwCAAAT5sA==
Date: Fri, 28 Aug 2026 09:32:59 +0000
Message-ID: <IA0PR12MB820827005555ABFE974E007C90AC2@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260828063103.4106629-1-srinivasan.shanmugam@amd.com>
 <20260828063103.4106629-2-srinivasan.shanmugam@amd.com>
 <apE17lJZmTD4+5jR@gsse-cloud1.jf.intel.com>
 <IA0PR12MB8208533952E71C3153ED308190AC2@IA0PR12MB8208.namprd12.prod.outlook.com>
 <1ea90a49-ec2f-4150-a7e2-4f645ef3a98b@amd.com>
 <IA0PR12MB820813A9D08CAF799558FB5A90AC2@IA0PR12MB8208.namprd12.prod.outlook.com>
 <99a34ffb-b702-45c8-aa0c-129442841c2f@amd.com>
In-Reply-To: <99a34ffb-b702-45c8-aa0c-129442841c2f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-28T09:30:23.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|BL1PR12MB5755:EE_
x-ms-office365-filtering-correlation-id: 9156b152-2c58-44f0-e0e5-08df04e759b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|7416014|376014|10067099003|3023799007|22082099003|18002099003|11063799006|4143699003|56012099006|38070700021;
x-microsoft-antispam-message-info: MYA1wqX4G98cVorMtLj2v858aIZ1Qcvpq0QJ8K0FrrdtjMg41OqpWdjCZlxbh1Nw0ujO7pOe/nP95O786Lk+nu+29/k7OTynDzgt7b2eJXGtD6vuIQctBxnKUTWP2erz3b2i8S/MpV/PCDcEeECrihP1XXBVzaWIn0Z5IA8d7nIIox0hPCwsfGHE+FKXFwABPMN+Lp8C1sKqJ0i3U8lg5RMSek0/3WfAqA2bbKab16/5HdwHu//j7FmS4tuMOR4VoPGpkko/dymoAU0Pt9LSF0eBf5/N91gyH6aftGa5mZ0RJGJbNaiIfgIJ5XOigN1qsz/1m5I//+3Q7WqnhD4SKDEWd5lkvN+bjN4dtmHpeEcKAHAwdLfeU+xfe/cuZALZ53Zp2PqMWG+ndfftLUwHG8obWyjMoX9nfRS56im2FYlu6AvS5mNGyHt5xIvUrSVTzgj1fCSP4q9WwLSIhudDNQixLe29IDOzJVpSJr5YoRedee75Ys9X1IE0R3XsoFFCrtwrj5/Q/I26Bmjc5iyjcbV3uAAR+oJZlpaNggU5wQgenpVtKyyQfUC8P8g4qXk//fyk3rS5ASyFfXzL3ES+M26hZdpNKOI5b8rUetpwccN8VTCVc1GbZSuc12wZwUxCW5t11FQByMDC6nonn8tQFb9dg5LovTWQ/xd6P4XzANLfEZpHqVFpZEePYOJeD8WDUHQyShjMvlFo1SabNIm9g1STuc207A7L1n7pQhDSB2k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(10067099003)(3023799007)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c24yY3lEUG5FM3VrR1E3QWNHZUVUM3pLMVdlK0NhRzI4YVlWWGM5bkhLMkZF?=
 =?utf-8?B?MTMvdlE1NjFSRWVoNGNnaGxiNkVudlJRRTFLdnRvalYyeEpIUkxBZnc4UHpJ?=
 =?utf-8?B?TkxuWVZjUzVPd0pBM05xVTBydzVLaG1IaXROalZnL29jaFphWGxEZ0JyaDEv?=
 =?utf-8?B?N2o1aDk0citOK2pKZHBsVUxmM1NxRW5VRFlBWDBjWVYzUUZrbnc2d2JTSllN?=
 =?utf-8?B?ZWFEc1dFSjV6QXNhS0VGcWVtQTU3dmdsSCsyYlhxd2N5VXhKckladmtYNlZR?=
 =?utf-8?B?Z09xNEVGZmRuOWpHdkhqd0xwTjZhZzBnSVVOeDg2VmJMVkxrWUI0QUtzVnlt?=
 =?utf-8?B?T1hFeHhmelBnZ05IaVZnWG4rMHBUWGVtWkdsN2ExSHZ6SFNYc3ZiZmthaEJW?=
 =?utf-8?B?V1ZLS0pqUGp5VFd3b01DTWFrd0xkZ1IxT2Q0ZXQrSDlFN2lXcjlCSnp5eE5r?=
 =?utf-8?B?SkFQaENYUzJZSy9HT29JVWlkYkdaKzFwNVdmeUM2QWJXb1BGVjBnSmt5YlJs?=
 =?utf-8?B?VzYrTHV5dkNEN214T1B2Z1pDSmVjYTVpdVNsVDlTRkRSb0ZaZDR3SmQvcmMr?=
 =?utf-8?B?emlJbnBRVGZ6cnhibHpaTXlQZTlUcEdjWFoyLzEySnFuKzU3KzRwRWdpNEY3?=
 =?utf-8?B?TlJvaHJWVHNqOUhRbzRzL1JYRitUU0Jnb1pyUzU0S0JwMm1ZZmtjaHB4Szht?=
 =?utf-8?B?cW0raFBUemN0eE9pRStBOGdUK2FxUEllWS8yOFY3cU1XckcwWFYycmMwcjkv?=
 =?utf-8?B?RzZQVUNPZXh1dnpLd2diZmpSWUo5bnJpR2N4eGhWL1Z2YnRUbnVlYlZSODFR?=
 =?utf-8?B?eW16bFZ6NGszd056VjFyVHJzdldwTCtQTmpnS1dvWDlVSVdpWmw4STh0QW0y?=
 =?utf-8?B?Zjd2YWtzam1WVGxMUmd0d2xkZlY1YWtZK3hFeVRMR01BSTNQeWxlNnk1RTJ0?=
 =?utf-8?B?RGxuMXlKQkVvWCtoRlh4cmtsMllvd0g2TzI0dzI5YTZRQWZibTdvelNodUhX?=
 =?utf-8?B?Z21Nd09seVB2OVplQVVSdEJwZDNiNFBETEVrQm1makZsTzFJTVdOaGx4NjRH?=
 =?utf-8?B?YklvY3BWRUVlT1pHL21Ra1NtLzJBQXRuc05QSmkreHNIZ1hFUEZic2NPRDh0?=
 =?utf-8?B?OHJhVGU0U1hkN0x3K3l0M2YvUTlZdHNoaDMvZnVzVzBoSmdpcmpyR2ZwOFZP?=
 =?utf-8?B?QytuOE1sRFVweUZ6cm5XWk5BTTc4RWxOVW1iMS9tajZ4c1JsRnQxbGFJSVo1?=
 =?utf-8?B?NVBGVG9CUWRkejJYdXgxQXYwbTFieUNjM1p4Nk9Kb3Zlbm9uWWVtTDdFeXJp?=
 =?utf-8?B?QXJRZERYZkFBdktrYzlXSGpHd2JtRDczTXRNSnkxNkFCLzhqanIrb3Bnc2o2?=
 =?utf-8?B?YXdCelZNbm1NY1ZLS1BFTGh4UjMxRWwrOGIzUFlBUzQxbGxnZFRCZ1RYaU9k?=
 =?utf-8?B?cU5PbGo0THVEVU90VEhrSldkeVlqeWQ2eTJHWFlKNXdDZ2NmOXdQbVpLcVc1?=
 =?utf-8?B?NmRNTkFyUy81Z0NnNENKTUJnTG5TTmdxTHlSdmpucmtBVzl1Zmx5K1BLbk9q?=
 =?utf-8?B?bnJhZXM5MHZ1RGhXUHRGUWlZYXIwRXRMekI2NWYrZ3pPTVFlTHhUV3NLWHZv?=
 =?utf-8?B?VmlGd2tmeEk3eGVrbDRIT3BRa212amh3YkhYV2F0ZFFFenJMdnZxRHptQ0VL?=
 =?utf-8?B?UmhJWUFKRWtNSTcrTHlvRUJFdkdKL2sxY0xxWVdFemlneGtWOGlzVTI1dCtC?=
 =?utf-8?B?cys0aDJwYVRPeVlBU1FUMDg2WWNVZTV0ZU45R3dpcmRoVVl4dFhWTlBwSTlC?=
 =?utf-8?B?b2xYOWRmbkQ0bXBGWitkUHNPOW53UnZmQ2s1NTJrdHpRU0J3VVJVMVgzK1hO?=
 =?utf-8?B?R25VQzd6V3IyZmZ0Q0dwRUk0bG9IR3RyeWk1STVvZTM0TTVkbUNtcWlsN2RE?=
 =?utf-8?B?OEVxM3ZVTGd6T3Nvam1EWm53NlNtZnRuam1xREh6WjkzN3o1U3pVMFdaYnNI?=
 =?utf-8?B?cWMwVTZmL2xPYzJhVzMxbVhHN0pGbDdYNytSTVpqU3paSkdLaEtIWC9Bd1Rl?=
 =?utf-8?B?WHFyVnRtdWhUUkQwWWhzbnlmR2EweDdYYjRPWlhRTzdOREtvWmpUc254YVN3?=
 =?utf-8?B?R0oyYzc4bXVzQll1amd6WkpPQzQ1TjFCR01kMUxYdUs1WWtuYnRaaFNlcVk2?=
 =?utf-8?B?dU5BcDV0cjQ3cUYxRm5YUnBhU1U0VnRFcmFLaW1va2ZrdEpLTWNyZDVlcUdV?=
 =?utf-8?B?R01XR3dTUmtRQzdWMVQycnpVamtYSHo3aFVVaUgvcHcySGhPTW15NzdNaHI2?=
 =?utf-8?Q?+avYhRT4NQfmIafSik?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9156b152-2c58-44f0-e0e5-08df04e759b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 09:32:59.9008 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: igrFnueSsVJgwfia1Xmr6t6mFq0PhhsJKM1KmktQMO0s9ybBGXLfFqRAs+UUROiLrG8BTrdNYkfP9h257MVo2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5755
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
IEF1Z3VzdCAyOCwgMjAyNiAyOjQzIFBNDQo+IFRvOiBTSEFOTVVHQU0sIFNSSU5JVkFTQU4gPFNS
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
X2ZlbmNlIGhlbHBlcg0KPg0KPiBPbiA4LzI4LzI2IDEwOjMxLCBTSEFOTVVHQU0sIFNSSU5JVkFT
QU4gd3JvdGU6DQo+ID4gQU1EIEdlbmVyYWwNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiA+PiBGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0Bh
bWQuY29tPg0KPiA+PiBTZW50OiBGcmlkYXksIEF1Z3VzdCAyOCwgMjAyNiAxOjQ4IFBNDQo+ID4+
IFRvOiBTSEFOTVVHQU0sIFNSSU5JVkFTQU4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+
Ow0KPiBNYXR0aGV3DQo+ID4+IEJyb3N0IDxtYXR0aGV3LmJyb3N0QGludGVsLmNvbT4NCj4gPj4g
Q2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IE1hYXJ0
ZW4gTGFua2hvcnN0DQo+ID4+IDxtYWFydGVuLmxhbmtob3JzdEBsaW51eC5pbnRlbC5jb20+OyBN
YXhpbWUgUmlwYXJkDQo+ID4+IDxtcmlwYXJkQGtlcm5lbC5vcmc+OyBUaG9tYXMgWmltbWVybWFu
biA8dHppbW1lcm1hbm5Ac3VzZS5kZT47IERhdmlkDQo+ID4+IEFpcmxpZSA8YWlybGllZEBnbWFp
bC5jb20+OyBTaW1vbmEgVmV0dGVyIDxzaW1vbmFAZmZ3bGwuY2g+OyBTdW1pdA0KPiA+PiBTZW13
YWwgPHN1bWl0LnNlbXdhbEBsaW5hcm8ub3JnPjsgVGhvbWFzIEhlbGxzdHLDtm0NCj4gPj4gPHRo
b21hcy5oZWxsc3Ryb21AbGludXguaW50ZWwuY29tPjsgZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZzsNCj4gPj4gaW50ZWwtIHhlQGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgbGludXgtbWVk
aWFAdmdlci5rZXJuZWwub3JnOw0KPiA+PiBsaW5hcm8tbW0tIHNpZ0BsaXN0cy5saW5hcm8ub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZw0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDEvMl0gZHJtOiBBZGQgY29t
bW9uIGRybV91c2VyX2ZlbmNlIGhlbHBlcg0KPiA+Pg0KPiA+PiBPbiA4LzI4LzI2IDEwOjA2LCBT
SEFOTVVHQU0sIFNSSU5JVkFTQU4gd3JvdGU6DQo+ID4+IC4uLg0KPiA+Pj4+PiArLyoqDQo+ID4+
Pj4+ICsgKiBzdHJ1Y3QgZHJtX3VzZXJfZmVuY2UgLSBlbWJlZGRhYmxlIERSTSB1c2VyIGZlbmNl
DQo+ID4+Pj4+ICsgKg0KPiA+Pj4+PiArICogRHJpdmVycyBlbWJlZCB0aGlzIGluIHRoZWlyIG93
biBzdHJ1Y3R1cmUgYW5kIGltcGxlbWVudA0KPiA+Pj4+PiArICogJmRybV91c2VyX2ZlbmNlX29w
cy4gQ2FsbCBkcm1fdXNlcl9mZW5jZV9pbml0KCkgYXQgY3JlYXRpb24NCj4gPj4+Pj4gK2FuZA0K
PiA+Pj4+PiArICogZHJtX3VzZXJfZmVuY2VfYWRkX2NhbGxiYWNrKCkgdG8gYXJtIG9uIGEgZG1h
LWZlbmNlLg0KPiA+Pj4+PiArICogQ2FsbCBkcm1fdXNlcl9mZW5jZV9jYW5jZWxfc3luYygpIGJl
Zm9yZSBkcml2ZXIgdGVhcmRvd24uDQo+ID4+Pj4+ICsgKi8NCj4gPj4+Pj4gK3N0cnVjdCBkcm1f
dXNlcl9mZW5jZSB7DQo+ID4+Pj4NCj4gPj4+PiBTaG91bGQgdGhpcyBjb21tb24gbGF5ZXIgYmUg
c3BsaXQgaW50byB0d28gZGlzdGluY3QgY29uY2VwdHM/DQo+ID4+Pj4NCj4gPj4+PiAtIGRybV93
b3JrX2ZlbmNlOiA5MCUgb2Ygd2hhdCBpcyBoZXJlLCBtaW51cyB0aGUga3RocmVhZF91c2VfbW0o
KSBhbmQNCj4gPj4+PiAgIG1tLXJlbGF0ZWQgY29kZS4NCj4gPj4+PiAtIGRybV91c2VyX2ZlbmNl
OiBhIHN1YmNsYXNzIG9mIGRybV93b3JrX2ZlbmNlIHRoYXQgYWRkcyB0aGUNCj4gPj4+PiAgIGt0
aHJlYWRfdXNlX21tKCkgYW5kIG1tLXJlbGF0ZWQgY29kZS4NCj4gPj4+Pg0KPiA+Pj4+IEkgc3Vn
Z2VzdCB0aGlzIGJlY2F1c2UgSSB3YXMgdGhpbmtpbmcgYWJvdXQgaXQgdGhlIG90aGVyIGRheSAo
SQ0KPiA+Pj4+IGZvcmdldCB0aGUgZXhhY3QNCj4gPj4+PiBjb250ZXh0KSBhbmQgcmVjb25zaWRl
cmVkIGEgcGF0dGVybiB3aGVyZSBhIGZlbmNlIHNpZ25hbHMgYW5kIHRoZW4NCj4gPj4+PiBJIG5l
ZWQgYSB3b3JrZXIgYmVjYXVzZSBzb21lIHdvcmsgbXVzdCBiZSBkb25lIG91dHNpZGUgb2YgSVJR
IGNvbnRleHQuDQo+ID4+Pj4gQSB1c2VyIGZlbmNlIGlzIG9uZSBleGFtcGxlLCBzaW5jZSBjb3B5
X3RvX3VzZXIoKSBjYW4gZmF1bHQsIHdoaWNoDQo+ID4+Pj4gaXMgbm90IGFsbG93ZWQgaW4gSVJR
IGNvbnRleHQuIEF0IHZhcmlvdXMgdGltZXMgaW4gWGUgd2UndmUgaGFkDQo+ID4+Pj4gbXVsdGlw
bGUgcGF0dGVybnMgbGlrZSB0aGlzLCBhbHRob3VnaCBhdCB0aGUgbW9tZW50IHVzZXIgZmVuY2Vz
IGFyZQ0KPiA+Pj4+IHByb2JhYmx5IHRoZSBvbmx5IGNhc2UgdGhhdCByZXF1aXJlcyBpdC4gSWYg
d2UgbG9va2VkIGFjcm9zcyBEUk0gYXMNCj4gPj4+PiBhIHdob2xlLCBJIHN1c3BlY3QNCj4gPj4g
d2UnZCBmaW5kIHRoaXMgcGF0dGVybiBvcGVuLWNvZGVkIGluIGEgbnVtYmVyIG9mIHBsYWNlcy4N
Cj4gPj4+Pg0KPiA+Pj4+IFllcywgZHJtX3VzZXJfZmVuY2Ugd291bGQgYmUgYSB2ZXJ5IHRoaW4g
bGF5ZXIgb24gdG9wIG9mDQo+ID4+Pj4gZHJtX3dvcmtfZmVuY2UsIGJ1dCBJIHN0aWxsIHNlZSB2
YWx1ZSBpbiB0aGUgc3BsaXQuDQo+ID4+Pg0KPiA+Pj4gSGkgTWF0dCwNCj4gPj4+DQo+ID4+PiBU
aGFua3MgZm9yIHRoZSByZXZpZXcgYW5kIGZvciBiZWluZyBzdXBwb3J0aXZlIG9mIHRoZSBpZGVh
Lg0KPiA+Pj4NCj4gPj4+IFRoZSBzcGxpdCBpbnRvIGRybV93b3JrX2ZlbmNlIChnZW5lcmFsIGZl
bmNlLXRvLXdvcmtxdWV1ZSBwYXR0ZXJuKQ0KPiA+Pj4gYW5kIGRybV91c2VyX2ZlbmNlIChzdWJj
bGFzcyBhZGRpbmcga3RocmVhZF91c2VfbW0pIG1ha2VzIHNlbnNlLg0KPiA+Pj4gSSdsbCByZXN0
cnVjdHVyZSB2NSBhcyBmb2xsb3dzOg0KPiA+Pj4NCj4gPj4+ICAgZHJtX3dvcmtfZmVuY2U6IGty
ZWYsIHdvcmtfc3RydWN0LCBkbWFfZmVuY2VfY2IsIHN0b3JlZCBmZW5jZSByZWYsDQo+ID4+PiAg
ICAgICAgICAgICAgICAgICB3cSwgb3BzIOKAlCBhZGRfY2FsbGJhY2ssIGNhbmNlbCwgY2FuY2Vs
X3N5bmMNCj4gPj4NCj4gPj4gWWVhaCwgdGhpcyBwYXR0ZXJuIGNhbWUgdXAgc28gb2Z0ZW4gdGhh
dCBJIGFscmVhZHkgY29uc2lkZXJlZCBhZGRpbmcNCj4gPj4gaXQgdG8gdGhlIGNvcmUgZG1hX2Zl
bmNlIGZyYW1ld29yay4NCj4gPg0KPiA+IEhpIENocmlzdGlhbiwNCj4gPg0KPiA+IFRoYW5rcyBm
b3IgdGhlIGZlZWRiYWNrLg0KPiA+DQo+ID4gT24gZG1hX2ZlbmNlX3dvcms6IHdvdWxkIHlvdSBw
cmVmZXIgSSBwbGFjZSB0aGUgZ2VuZXJpYyBmZW5jZS10by13b3JrDQo+ID4gaGVscGVyIGRpcmVj
dGx5IGluIHRoZSBjb3JlIGRtYV9mZW5jZSBmcmFtZXdvcmsgKGRyaXZlcnMvZG1hLWJ1Zi8pLCBv
cg0KPiA+IGlzIHN0YXJ0aW5nIHdpdGggZHJtX3dvcmtfZmVuY2UgaW4gRFJNIGFuZCBwcm9tb3Rp
bmcgaXQgbGF0ZXIgYWxzbw0KPiA+IGFjY2VwdGFibGU/DQo+DQo+IE1heWJlIGFzayBBSSB0byBz
ZWFyY2ggZm9yIHVzZSBjYXNlcy4gSWYgeW91IGZpbmQgc29tZXRoaW5nIG91dHNpZGUgb2YNCj4g
ZHJpdmVycy9ncHUvZHJtIHRoZW4gcGxlYXNlIHBsYWNlIGl0IHVuZGVyIGRyaXZlcnMvZG1hLWJ1
Zi4NCj4NCj4gSWYgeW91IGRvbid0IGZpbmQgYW55IGV4aXN0aW5nIHVzZSBjYXNlIGRyaXZlcnMv
Z3B1L2RybSBzaG91bGQgZG8gYXMgd2VsbC4NCg0KSGkgQ2hyaXN0aWFuLA0KDQpTZWFyY2hlZCB0
aGUgdHJlZSBmb3IgZmlsZXMgY29tYmluaW5nIGRtYV9mZW5jZV9jYiArIHdvcmtfc3RydWN0DQpv
dXRzaWRlIG9mIGRyaXZlcnMvZ3B1L2RybS86DQoNCiAgJCBncmVwIC1ybCAiZG1hX2ZlbmNlX2Ni
IiAuIC0taW5jbHVkZT0iKi5jIiB8IFwNCiAgICAgIGdyZXAgLXYgImRyaXZlcnMvZ3B1L2RybSIg
fCBcDQogICAgICB4YXJncyBncmVwIC1sICJ3b3JrX3N0cnVjdCIgMj4vZGV2L251bGwNCiAgKG5v
IG91dHB1dCkNCg0KTm8gbWF0Y2hlcyBmb3VuZCBvdXRzaWRlIGRyaXZlcnMvZ3B1L2RybS8uIEZp
bGVzIHVzaW5nDQpkbWFfZmVuY2VfYWRkX2NhbGxiYWNrIG91dHNpZGUgRFJNIGFyZSB0aGUgY29y
ZSBmcmFtZXdvcmsgaXRzZWxmDQooZG1hLWZlbmNlLmMsIGRtYS1mZW5jZS1jaGFpbi5jLCBkbWEt
YnVmLmMpIOKAlCBub3QgY29uc3VtZXJzIG9mIHRoZQ0KZmVuY2UtdG8td29yayBwYXR0ZXJuLg0K
DQpCYXNlZCBvbiB5b3VyIHN1Z2dlc3Rpb25zLCBJJ2xsIGtlZXAgdGhlIGhlbHBlciBhcyBkcm1f
d29ya19mZW5jZSBpbg0KZHJpdmVycy9ncHUvZHJtLy4gSSdsbCBhZGQgdGhlIHZhbHVlIGNvbXBh
cmlzb24gbG9naWMgYW5kIHRoZQ0KZG1hX2ZlbmNlX29wcyB3YXJuaW5nIGluIHRoZSBuZXh0IHZl
cnNpb24uDQoNClRoYW5rcywNClNyaW5pDQo=
