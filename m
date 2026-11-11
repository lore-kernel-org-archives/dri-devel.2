Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A39606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=selector1 header.b=oZpAsPQz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0208210E16D;
	Wed, 11 Nov 2026 09:34:03 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013007.outbound.protection.outlook.com
 [40.107.201.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83E9D10E16D
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 09:33:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fmXFXKPjewJ6K2CImsTw78J5j1lRCzUiF3s9Mgc+vO45NegF/VixPkYVtKZDus7iTDH50st6Y/+UdEtWCiBf3RYZs4F0PpKKiQj+UuQnvq76w/AYy/+PSo8AnDBQNZ/KI6ZtNIavsacmC7tNYN0rP2r8/XQ5ZxLacjHjMPRu93jXMR7/LKfKXseMkkTeTrKcxfuMuCqzniRCGeBiDbT30IQNA7P7qCRKzj9U7pg1/4+c8cWo/oMxEkbQ53XemcKkKTWO4Jdzvh25USkfKdrScGLa56l6ymDqKc1eCaNq4EU8mBIwHCz9wwXFaQ6JtAVxh7fFQ6whhU5Jq7jqw0qCPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0xj+ZvzX2GG1DfoZvjnGc71NPJYuIA+mMEl/x5UiS4=;
 b=KupYgnAzplxTzXRom4ff2ipDgI0BOE6iOqAu4KRexGLg6aV2uoUhBdlOgSApS7NcbVnz9pAnxxQ0jP8mi7P8s99GFko5PFtZ+bN/X49hrw6VHaecpzXzYfpTK9qByG7kmO4hEFCTGGTEnKvulTB0JW1DRbRnkLjj4XVwOBrwPnBDuhhDdj+uE2xWpJYh/oUJ6LYdOCy/dynJKI24shjEVqD5xFmHgtCk5smZsYBqTFJIYp6E+WGLvhjIVeFlAuLvajdG6evfdCN68p4fwtGaDH6JC9NV8V3qv6jF95hfNBF4eCSR1kYWUUapXD39Aj1IEvZOq8Wh+Bqgn4pWlfWMyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0xj+ZvzX2GG1DfoZvjnGc71NPJYuIA+mMEl/x5UiS4=;
 b=oZpAsPQzgh26aJns+4CHsmy+xnNsP/TssQhrd22u3sM42Z5Vifwf74WPUJEGWd8yHzVa8/N1KMPQ7twLdgPOAoy4Ox/Xj5dU2NE/tPY0OtJi50eWz3qK5rZZamSWGbrtWMEiX22Nw8b2qtyMRe1JZCgkwQ9NwR/6HZ2imlC6Pm7wh5F4u4zvYxhL+xZpA/PyuQaqOPLQeSS4WWAn3XJ7lee0l3I1OlLlIDPYv3pudrG6YBgjKLmVW8Ns/pLU8tQp2mmXG6KN7A95+CYnTciyXKUUujUvvRiqY935l6z1SpUdVLDWZcC6aLakDK7o30xK2zm2WkTml7CL62kvlkEd0g==
Received: from DS6PR11MB523643.namprd11.prod.outlook.com (2603:10b6:8:468::12)
 by SJ2PR11MB8300.namprd11.prod.outlook.com (2603:10b6:a03:548::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Wed, 11 Nov
 2026 09:33:53 +0000
Received: from DS6PR11MB523643.namprd11.prod.outlook.com
 ([fe80::1cc0:e019:a70b:f954]) by DS6PR11MB523643.namprd11.prod.outlook.com
 ([fe80::1cc0:e019:a70b:f954%4]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 09:33:52 +0000
From: <Manikandan.M@microchip.com>
To: <mripard@kernel.org>, <airlied@gmail.com>,
 <maarten.lankhorst@linux.intel.com>, <simona@ffwll.ch>, <tzimmermann@suse.de>
CC: <dri-devel@lists.freedesktop.org>, <alexandre.belloni@bootlin.com>,
 <claudiu.beznea@tuxon.dev>, <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH RESEND 10/83] drm/atmel-hlcdc: Switch to
 drm_mode_config_create_initial_state
Thread-Topic: [PATCH RESEND 10/83] drm/atmel-hlcdc: Switch to
 drm_mode_config_create_initial_state
Thread-Index: AQHdbTqmy3IaYnrTCEadcVFBDK3Y/LcopREA
Date: Wed, 11 Nov 2026 09:33:52 +0000
Message-ID: <96b132fa-4bbb-4b4b-8fab-b0d621aba3a2@microchip.com>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
 <20261105-drm-no-more-config-reset-v1-10-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-10-1f58d1e33380@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS6PR11MB523643:EE_|SJ2PR11MB8300:EE_
x-ms-office365-filtering-correlation-id: c8def268-283c-4653-a523-08df3fd6e643
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|18002099003|22082099003|10067099003|38070700021|56012099006|261009223027099003|261021135927099003|11063799006|261102123227099003|261028144727099003|4143699003|261026121527099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261026140227099003;
x-microsoft-antispam-message-info: YCIRUOe0GsoJOZ+OONKymAvybs2O2HZH8SF/gU3FCNVyZ1WC92C/QMbVtRzlO+QTIXQojEQjavMPOXO/YRh2Lc6D6iy2cMTViHlgY3H/FMTyIxKLEJIknwI40+uHr/BO9wPg1exCTjjNk5LFUYvWc6y2+rZKXXZPN+elAPRDNCiiPtePNL8SyLs2/sbIafcMFx1CrkNsMyzFyRiiqcPuygZ7hpDFJMg+O7JK0Fo5gxit+Olf5ysry6F4jx+nzT9vewWEktSCaWqhxgNXGKOQWa6m4bQ1ZZ5R2vhtw43VGD7t2vOzFf9kdniB5hFJoJZIcR6C/gIh/B7bzYO+9+T8F+O3ZMIULEFNP4lHDknxjayWDVV9y2jEgend5gsmtGaVdZr3ZcQKF86wc8GS3m4bubkMMtRF1SHinj2cLbhBPvOK2x2h5HLfHXDyhAqi2QkhGeZu6mHiHP9f1Fa2aNCUur7bnPRd/EOkDm7VPb79K8J7YbAosHGysb+sRiBI4zRzsSfwwLEWhlKnKN+OHX/ufWyiXIt2mO7mHzNWZUTuVIIBSGerKurfYwlrMwx5jjhLzvYzFhDDbDtiyW3GN9KirzmtTgO+ZRJmlMGSQ1NgzZPnx7X+T0OIyWrMuhD4jFcd5y0l6xHYJL5VjqNrq3R5CyaNnJJBe6i3yov0r0CMNtz46rH+kSL1IVf0VRHfKQOo2S1e3urHL+JDrq79GEPWxc+XZom26+r53UVIPv2QYj0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS6PR11MB523643.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(22082099003)(10067099003)(38070700021)(56012099006)(261009223027099003)(261021135927099003)(11063799006)(261102123227099003)(261028144727099003)(4143699003)(261026121527099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDVRTWtoRkNscHc3cUF5dlRZRTZybm5jOWd1aHBxZHBVYUZxRW1TSjRmbkFE?=
 =?utf-8?B?VmZJcTcvdFpuaWF2am93MHpzeWs0SmJMSzM1VXJnYUlLcmNrWjVMT2tuSTZZ?=
 =?utf-8?B?K1Z0R0U3T0lNZ2tNTU9VN0orMjBNbWEzVldrRFI2Q0tXQjJoUmh2cXIxRVdi?=
 =?utf-8?B?aitVV0xSSW5XNE53amE0WlFNbmsrQ0JWVjhzL1BEMjRhQ2MwNTB6T3dCSkdO?=
 =?utf-8?B?KytySS9mN2NJRGZPbTdEVWxPbm9CNXhqYkxaTzdQcDVzenpMcXN0U2F3c0tl?=
 =?utf-8?B?UGRWNTFMK1BxSVZleWJlaWVBOVRIdkV6RHJsSk96TmNBZDNIKzV0d2JkZThJ?=
 =?utf-8?B?UU5CVnJTbTZTM1o0M0RsRVBzMGJiMXZYa0FuMHJuQVcxWDZ4TndySXhLNHB3?=
 =?utf-8?B?K1hSdXJEZzJLTlFaNHhUazJpbVkyNDdDR3N5aXBZSzBVVktwZkxadG9iaWd1?=
 =?utf-8?B?OUY2dlNRQ00wZ0QyYzg0aS8rRzFuUFh5aE54NUIrSEF5OE9DYkk2U0NZNmZV?=
 =?utf-8?B?S0V2V1gwc0VmOGhSRjA3bTVBZ2ZGS0hmdU9DOU9tUmEvSjJCNEEwL3dJaENw?=
 =?utf-8?B?dGxYQVQ4KzAwUGNYS0Zxc1dKbGVzNlo0L2pkRHdSMHhhK2NyVFZMRC80NlI1?=
 =?utf-8?B?Vzc2UkZrK0w3OGljZ3U4NmJLczJlQTlyK1NmVGl3QnNJa1luenJ3MHZBY1B5?=
 =?utf-8?B?NHY3dHUxRW5IQkdsSm1DOW5QVkwvN0lxRnhPMlF6UW1rNTdPSDFQM2hjODNh?=
 =?utf-8?B?UlJLYXpyM29vbDNrdVJpaGFMZHNoeGM5azJ2eEhla0FVNVdhTWRtT2hwVFlG?=
 =?utf-8?B?d1JvMWFYRm1raVRxZytWNTF5MVJabUZnZVJLWmptR0V0eGcyM1hSNkQ1eUow?=
 =?utf-8?B?V2xVSmJQU0QxOWJWOG8xM05zdm5ldWhyZWlCV0RNamZIU29jaFlzdTVFWWJy?=
 =?utf-8?B?L0pkR0N5U1M3REhaRWlJUkJLamcyKzdlRWJhNTNta2t5MlZqcCtyR1orYTRp?=
 =?utf-8?B?T2ZmdUd1aHFkQlVMV0lWTWt3TDhwcW16ZFd0dEdnRnVaNlVRaWVqeUtCeGFR?=
 =?utf-8?B?SmlQZ285K3UwaXNzSXlMUnRQWVZXenFzeGl0aENYalpTc1dYdmVCOFdoc0Zm?=
 =?utf-8?B?aENiaWwxR1B6cmNyYUgwb2dqZlA4enN4U0xvRmRyUVIzZnNIaUVoNFdqWUlu?=
 =?utf-8?B?NVVaeUZuRUNzcGlqTC9CZk1oek9CTUFRWXBPZVNNTjhlSm9TSEwvZHBCbWdQ?=
 =?utf-8?B?bHoyWVZITktkR3NTMVgraTl1ZC9yRDBjN2JqUnlMMzBucGdGK1p6OWt4VVpE?=
 =?utf-8?B?MnNwM0Z6UnZXdVRkaTNoVlpLQkptZjFOMGZkdjFkbWIwZE03ZUdvdmlUVllq?=
 =?utf-8?B?YXFLK3ZkWmFtdzBIbm1sRHV3QVdmTUs3UWJNamFSMURyaWJFTXBWV1dKMG84?=
 =?utf-8?B?ejFOZXJHSlMwcDRKMkVEV05lQnJVZGdHeVJKVGJCUFk5N1QxYUhrVjJmbHlS?=
 =?utf-8?B?bEMrQUVsclRDbm9XeVRiTW5hcTAwYjlhUUFiOFVoWFppODVwaUE4bWZvdUFL?=
 =?utf-8?B?WHcxUGUwVTJUdFZ5Q0RhWEVXSG1yeU1GalN6SEhobU5iQ1BZRlBjLzJzK0hp?=
 =?utf-8?B?VmJCM0dpRmI2QlZxY2k4SDlrbXhaMkp3NXVRNWNSQWo4b1B4a0ZXYW9vVmor?=
 =?utf-8?B?VEYwZGUyRGltQkdiWkRqRXZVbitqOHc4aUpCcjdaN21yNzAyN1FuZ1RqVEx2?=
 =?utf-8?B?cGR3ZTFFR0RzRW8zKzlhcDlkT2hXZmdUaHV4QnY0WkRodWk2WXIxaTljdlBW?=
 =?utf-8?B?d2NSalY2V2dsWFlxUUxTM25FcHF4VFF6b3BqUXJoNlE3M1A4WHJwZVF5QTJo?=
 =?utf-8?B?b29kVTUxc3kzRGpCUS9PdWp3YzRyWkM5b1laZnpFUXVsUGNEcUpXSXAvbFls?=
 =?utf-8?B?MW9mUEQ1Sm9CY1h6anBuRTZDVVVtbmkrS24yeXlJcTBCZjQwbEk5Rm91ZkM2?=
 =?utf-8?B?TDBaVk9GK3FkdU94cnkyUEluWTRpMmlEcFFLTU1vKzE0NGp3Q2YyRkVObVdh?=
 =?utf-8?B?azdUckU2R21GZUZNYll6VmRxYU9ZR1k4TGhVaG5ESzNLOHBiaDdzMTNoZ0ti?=
 =?utf-8?B?cVRWYUs5N3BtOUJBV0R6RjNYRWtOY1U0bGc0NnU3eUFxL3VUWmxSR1Zpb0ls?=
 =?utf-8?B?RTNYaWN6dlJuMk1WdUpJMThmWElnc2UwcldubmdaZnBVc1ZlVm84YWZ3U2dZ?=
 =?utf-8?B?MExDRkVOYTJsSUtORU4xRVU3Z2J5L3VZNmlUeGwwTy80K0g4ZXE2QlJtcHUx?=
 =?utf-8?B?VVJSWExXMlBqL0paYk90M2hXNURTa0ZOSU5SeWJBK1I5aXJZYXNrdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <820BC7E209D5854580BE443961011D7A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS6PR11MB523643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8def268-283c-4653-a523-08df3fd6e643
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 09:33:52.8119 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wcFrq6r/OGGhdeICQPrp5VEnQafGHR12w9v48lrUBiobluJS9PxTgIMmR0VWtyqv4IgROwX+DdvoWULXICxl3I+F4tM2wqpUablBGG1NmYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8300
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gMTEvNS8yNiA4OjU5IFBNLCBNYXhpbWUgUmlwYXJkIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IGRybV9tb2RlX2NvbmZpZ19yZXNldCgpIGhhcyBh
IGR1YWwgcm9sZTogaXQgY3JlYXRlcyB0aGUgaW5pdGlhbCBLTVMNCj4gc3RhdGUgYXQgcHJvYmUg
dGltZSwgYW5kIHJlc2V0cyBoYXJkd2FyZSBhbmQgc29mdHdhcmUgc3RhdGUgZHVyaW5nDQo+IHN1
c3BlbmQvcmVzdW1lIGN5Y2xlcy4NCj4gDQo+IFNpbmNlIHRoZSB0d28gcm9sZXMgbmVlZCBkaWZm
ZXJlbnQgYmVoYXZpb3JzIChub3RhYmx5IGZvciBvYmplY3RzIGxpa2UNCj4gZHJtX3ByaXZhdGVf
b2JqIHRoYXQgbXVzdCBwZXJzaXN0IGFjcm9zcyBzdXNwZW5kL3Jlc3VtZSksDQo+IGRybV9tb2Rl
X2NvbmZpZ19jcmVhdGVfaW5pdGlhbF9zdGF0ZSgpIHdhcyBpbnRyb2R1Y2VkIHRvIGhhbmRsZSBv
bmx5DQo+IHRoZSBpbml0aWFsIHN0YXRlIGNyZWF0aW9uIGF0IHByb2JlIHRpbWUuDQo+IA0KPiBT
d2l0Y2ggdG8gZHJtX21vZGVfY29uZmlnX2NyZWF0ZV9pbml0aWFsX3N0YXRlKCkuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBNYXhpbWUgUmlwYXJkIDxtcmlwYXJkQGtlcm5lbC5vcmc+DQpBY2tlZC1i
eTogTWFuaWthbmRhbiBNdXJhbGlkaGFyYW4gPG1hbmlrYW5kYW4ubUBtaWNyb2NoaXAuY29tPg0K
VGVzdGVkLWJ5OiBNYW5pa2FuZGFuIE11cmFsaWRoYXJhbiA8bWFuaWthbmRhbi5tQG1pY3JvY2hp
cC5jb20+DQo+IC0tLQ0KPiBDYzogQWxleGFuZHJlIEJlbGxvbmkgPGFsZXhhbmRyZS5iZWxsb25p
QGJvb3RsaW4uY29tPg0KPiBDYzogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQHR1eG9u
LmRldj4NCj4gQ2M6IERoYXJtYSBCYWxhc3ViaXJhbWFuaSA8ZGhhcm1hLmJAbWljcm9jaGlwLmNv
bT4NCj4gQ2M6IE1hbmlrYW5kYW4gTXVyYWxpZGhhcmFuIDxtYW5pa2FuZGFuLm1AbWljcm9jaGlw
LmNvbT4NCj4gQ2M6IE5pY29sYXMgRmVycmUgPG5pY29sYXMuZmVycmVAbWljcm9jaGlwLmNvbT4N
Cj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2F0bWVsLWhsY2RjL2F0bWVsX2hsY2RjX2RjLmMg
fCA0ICsrKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2F0bWVsLWhsY2RjL2F0bWVs
X2hsY2RjX2RjLmMgYi9kcml2ZXJzL2dwdS9kcm0vYXRtZWwtaGxjZGMvYXRtZWxfaGxjZGNfZGMu
Yw0KPiBpbmRleCAyZjQxYmNlNTc0ZGMuLjQ1M2MzN2RlOWJlZSAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2F0bWVsLWhsY2RjL2F0bWVsX2hsY2RjX2RjLmMNCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2F0bWVsLWhsY2RjL2F0bWVsX2hsY2RjX2RjLmMNCj4gQEAgLTg4MCw1ICs4ODAs
NyBAQCBzdGF0aWMgaW50IGF0bWVsX2hsY2RjX2RjX2xvYWQoc3RydWN0IGRybV9kZXZpY2UgKmRl
dikNCj4gICAgICAgICAgfQ0KPiANCj4gLSAgICAgICBkcm1fbW9kZV9jb25maWdfcmVzZXQoZGV2
KTsNCj4gKyAgICAgICByZXQgPSBkcm1fbW9kZV9jb25maWdfY3JlYXRlX2luaXRpYWxfc3RhdGUo
ZGV2KTsNCj4gKyAgICAgICBpZiAocmV0KQ0KPiArICAgICAgICAgICAgICAgZ290byBlcnJfcGVy
aXBoX2Nsa19kaXNhYmxlOw0KPiANCj4gICAgICAgICAgcG1fcnVudGltZV9nZXRfc3luYyhkZXYt
PmRldik7DQo+IA0KPiAtLQ0KPiAyLjU1LjANCj4gDQoNCg0KLS0gDQpUaGFua3MgYW5kIFJlZ2Fy
ZHMsDQpNYW5pa2FuZGFuIE0uDQo=
