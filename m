Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A0FC4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 10:39:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4B8310E30B;
	Tue, 21 Jul 2026 10:39:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="D7rdDeyG";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011062.outbound.protection.outlook.com
 [40.93.194.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2EE110E30B;
 Tue, 21 Jul 2026 10:39:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i9a1899xeRqFVeAFqdUrB67tPThEP2dbNLhxAfI+9ALf1U3hcCpqQbG9l8BZh3U907jcuFqgnV1LyO/5bgHKrO/JMQ4TmMWkFfuwv9lltqH9HvNbJmamftoBi4SlC6icpjY5VJhd45/Kf8Qf+FZf0FvSrGruQIKqEUNqPhjAguXRoe4mIwHIysVC5CA6QJWdbNsLMIzlcSMVYp5LEV7FGs+E7Buf81BEV4LPR0ApGWtsp4DlOS+4fFA0lTTWsKr7gy1zmYLOJIOdPgZ8s6shRAmD0GDDm3EE7CNw9HAMKCXdwRFOc0UwcZM/5a/hwkJUTJJStZMyupJRPTZtYcItCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9lHxDhezLGPYV+D76eh74GLVaP21lyi9y7ZlaN+NdY=;
 b=fpGm3/rAtU4yH87cv7SZpHRAbt6xJqHYXN3w56wjddCgdvYKMK2AdsttVWsC96mpFZUeBl46jjwqZ/Dn2uBJoYg6s4bN7TmWU7LDuPCz04BmSru7oSWSdT5zPH0EfGMbxZpmNsP5pzcapJYZHPEYJFOK1htXWfT/c/ZIxLn04PYv5xjSAuIP+VhvQB2ImJUmIlQZ0CAPgZuq+SXyEbAb+ID9TGEH2xVXDMK7PWQ0PlyXURGPE5Ev/uMOIPrHukQtJQwPHmIu1g9d7zgstxk9ZWIIVN/8CGba0p2Ta4NLJs2/qfoI8S0JAPoTsoy7FAmS2SeFs9BKlqGxgZs2L094oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9lHxDhezLGPYV+D76eh74GLVaP21lyi9y7ZlaN+NdY=;
 b=D7rdDeyG73CoHVpnGDcEiIDur6vKyl9lyvc6zJ+emVz9XmSAFXjJwZybTSRl3JKoNBGn8LyRWwuDBWI3TeSzGzvyquR4RXgVb90PeeFkbjG11q70XCTdQmIysFbWkWbpk2d73sHWTuNGdTYJ9/3nwf0GUJEITluQL5YoNBXt6KZEK1a3YcgyDXBzpdiogzH0U1KaBtaWklr/Mw5d2qHLjur/8ZfDE+0mBOmyFX6CIy0EBkpLr+rL43mWpzNv3C1EY3GO5YMcvuKBnBYk41113a9faAJxJxYoHPaKjBMQdf49VnUJaZrAwu9z/sntt5a8derTkQakbmYWbXw2S4oTxg==
Received: from CH3PR12MB8711.namprd12.prod.outlook.com (2603:10b6:610:176::20)
 by MW4PR12MB7334.namprd12.prod.outlook.com (2603:10b6:303:219::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 10:39:48 +0000
Received: from CH3PR12MB8711.namprd12.prod.outlook.com
 ([fe80::edc:28a2:dfe4:5f83]) by CH3PR12MB8711.namprd12.prod.outlook.com
 ([fe80::edc:28a2:dfe4:5f83%4]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 10:39:48 +0000
From: Milos Tijanic <mtijanic@nvidia.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mohamedahmedegypt2001@gmail.com" <mohamedahmedegypt2001@gmail.com>
CC: "tzimmermann@suse.de" <tzimmermann@suse.de>, "simona@ffwll.ch"
 <simona@ffwll.ch>, "lyude@redhat.com" <lyude@redhat.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "mary@mary.zone" <mary@mary.zone>, "airlied@gmail.com" <airlied@gmail.com>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "dakr@kernel.org" <dakr@kernel.org>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org"
 <mripard@kernel.org>
Subject: Re: [PATCH 0/6] drm/nouveau: GSP telemetry via RUSD, and fdinfo
 telemetry exposure
Thread-Topic: [PATCH 0/6] drm/nouveau: GSP telemetry via RUSD, and fdinfo
 telemetry exposure
Thread-Index: AQHdE9XwK9w27OkIZk+GwTWHRc8CAbZ30tIA
Date: Tue, 21 Jul 2026 10:39:48 +0000
Message-ID: <e0cc44dcc3efac7f354ce9a6eba1a9a87a1b096f.camel@nvidia.com>
References: <20260714211429.238355-1-mohamedahmedegypt2001@gmail.com>
In-Reply-To: <20260714211429.238355-1-mohamedahmedegypt2001@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8711:EE_|MW4PR12MB7334:EE_
x-ms-office365-filtering-correlation-id: 8d10bf38-65e6-433e-0038-08dee714631e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|10070799003|376014|7416014|366016|10067099003|11063799006|56012099006|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: oAj4kDyX9mwrXBHzy+ZyXfYEpUkpIFuqkCCyOJadcb6OGzriwHcxVWPdzlxGVeoxfq06N4WN+GYwp7Pg57RkkoHmCm7WvkbxupQeoK0SjkWK4QGSTlLa9+azGuUL9ebezmAmEPoxCPVY7bv+SkaqxAA/s+V0C2bWPrFGne5w//GEeeuav1nkTKZwZ65NkKgSM7E3Njs2924EKHhO1ORfCCpMCE4B3631D5nq+qgPu4FbOAwSEFJUQs9HF2dxUDq4pOpVoKf+0pISKb3E4gwUpGZ7d7NJ4TH2GKdMKD6SxsJJ/jnppf4MMfxmCyX2YueLf0PPx09ImP5ysac4HmYlijsphp30f4l0GAvd0xLUo0zED8FJOAFbiZSzv7H6PkuHIIpJQ1IvlFNw6TOcrzgfM7g6QhcPVYMtzDJbS9QXG87E6ko5ucGqjamkHwK4O8bOj4rl08VNF/1Ny+NwnfN8KAmdZINvIj5Lr6kf5hrej0f4wu3vBxvrSkFpLBge/nInsDgH5KFl8pCGalaOfPzO1G3Oy/V+o7SHJ/xpRABE2x/X4Bm++C3BtOCOovpfJ04+BZrADmS+7v6b/D0Rq8/Hx54sWLhTVvY5VOQnLwdqzOQcSZjcWvOUtWN0+a+pSA9zGzMuNundUud60dOQ2du5H8FObYZafDtIZEGM1/oBhbFFhYc8YjLFR8Lryg2gl4l0XJgjNBDfh0Xn9gNmoJfIdM0MNvLsGJ/DNG5vkR1+j8c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8711.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(10070799003)(376014)(7416014)(366016)(10067099003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clIycnVoN3ltcFlKMHhYUWwxejg0MkhLZUt1T0c3RzJ1a3ZSV3NyV1B2eUhL?=
 =?utf-8?B?VkV3UTVCbURNTjhweExXM2FEVFVlbnNOSG1BVGp5c3Y5cWpTaEk5VnRYWkxh?=
 =?utf-8?B?ZmwwRjJtRjFGRzcyOExHbTZ5UWdtdUJLUU8vWXNVeCtHbHVzL0RKcWxzcGJB?=
 =?utf-8?B?MkFJbnQ3blQ3N09ROXprbnhQcmpjRVlQZEVpRDlIbC84cUJ4NEJ1dFdMMW5X?=
 =?utf-8?B?bndwcUVWUHJsNE02NzhsNEZJOHZuK2QwbkhGK0ROQXFvbFk1WVpPZmZmL0sv?=
 =?utf-8?B?NjFxSFRUaVdtMXBFdWJXVTNRZlNMa21udFpQV1plUWZ4S054ekNyTjB1YjNl?=
 =?utf-8?B?cTljcDhWVndsZE45Qzg3eDdxS3RmdnFGemZuRFdJckNSNXluSWMxdmFtMDFT?=
 =?utf-8?B?RU5pU09sdVhaaXp6L2xwY1JFdHZxQjMrc082TEVleml0RkkrbUROUHpBTGRV?=
 =?utf-8?B?QmU2ZTBkaTdzOWEvUnRsR3Bzd1hISUFreVN0MnE3WXdRVnkyalRLaER5VTBm?=
 =?utf-8?B?NFFKYmFnQ0o2NTF5QXBNb3hvbThKbzkxYjVIeXAyVG9kRnJlMTZldGtoaTZk?=
 =?utf-8?B?Sk9tS20zOGRDQnNOVk5oa3ozY1RPTE9QandjWWMvUDVjd0hxdlo3UE1iRDA4?=
 =?utf-8?B?MkFCeUF6TGVUclp1OWNlMGUxUjh2U1Z5R3BtV01NbUFXc3RxSjlRajQ0Z2dy?=
 =?utf-8?B?SkhVSHgrQ2FPRitmOGhtUEpRZmhuQ1VpRUxKS3pYaWJDZlRuV1Z1dzhKNENs?=
 =?utf-8?B?bkFTYnQ4a2s1RU52bGVGSVh1WCtYTEQ2RWpwbG9LQ3RhR1h0OUdyMHEzWnpm?=
 =?utf-8?B?Rll1bFBqWk9CdEtrL2ZTYWdMRlRlTGdxVmNUNFlEM3dOVStKcmNBVVc4VFFp?=
 =?utf-8?B?TXY5ZTZRMXFIdmZtZGd4djJIUzM4b3U0d0hlYzY4OFBJeG1TSGVnQWlQY2lh?=
 =?utf-8?B?RXhEYVBqSlRweUlXMUVieDJoR2JPTmUrcVVIYy91VThlVmdzajR1UXBFQ1ZT?=
 =?utf-8?B?Q2llVWVBSzNHRy9UWlRtaGJ4SHcxLzdXWUN5RFZBWmV2WW5CajNFMVVrRUF0?=
 =?utf-8?B?NmMyemtYS284bjNVMElWbjJPQzRUeFA1VW9IV1l2ZHVKK3ZzK0ZrNjZYREhi?=
 =?utf-8?B?RFlsRzVpczNFNURRTTk0bHZzUG1MKzZQdFBDVXNHMC83L0pUYWRQZlpGcE1s?=
 =?utf-8?B?UFBzblRyVFIydHBlcnROOElYMWV0Mk40NTM5UEhkeVArZDlaSy9JdG0wUy9p?=
 =?utf-8?B?UDd0TWQxMVBueDlOdklVVzl5V3M2S1BpaFFuNXBVdTFpTHlnT1dVSjJQZXlX?=
 =?utf-8?B?VWZGUDV4djUwYm5RbUlXamJzaDk5RzFuWmsvUDFrUFZHM3RZY3ZEMTc4K2V4?=
 =?utf-8?B?Wkp5ZEZmeExwSmg5d1JTdHZrZlo0eDFTamRnQThJYkZNQm9XZERrTURrUFEw?=
 =?utf-8?B?N3JwOHZQdi95NlBOM2FwWGtyQjF2Y3hxT0JJNzFxY2JHNnd5dXFUekdnTDhz?=
 =?utf-8?B?V09hd2hwWjB5a0xIekRybzRDekVxUVg1NUJ3VWk0UGZWU3BqaHhQbzZ0cG1K?=
 =?utf-8?B?WmdlR1cyVHFGeVlQbWthYmpZRVhOL1BDK1RiaFk3bW5WVU1QRWJPL1Bqd20y?=
 =?utf-8?B?dmxibThkVGhhZmNTWUI4L0RaSGxBOHNtNVlZL1AwdC9zY0x0VGF5SG5lVkZl?=
 =?utf-8?B?MUNqYS9KQjZpc0tueEVFTUUrTVlhM2JncURZc2VjMFlMY2NwbUc3RlAwVFNl?=
 =?utf-8?B?d3VTZE80aWRrWDF2WCtKcVdBUkUrR2RmWFhuaU53dG1ETmRWVEdsczFFZXl2?=
 =?utf-8?B?Vlp6dlFLR3dxcEVncVZhSG0rZllPM1hUMGlSb1dpaTlnVW5VeS82ODBCRjFv?=
 =?utf-8?B?SmxmanBZdnpvYjdpSm53MEM1Zmo1RStaenhJbTNyTnF0S0xPVkRoREdwN2ZF?=
 =?utf-8?B?UnBrYTVGb2k2YTQ0YlBBYVZNZFFHbWo2TVlqOVNBZVQ2M1VlaE4yWlA5L05S?=
 =?utf-8?B?czVMQjdiTlhBMklIdE1idEdEbzY5NkM4eW9EemQyZTNXMlJrelg5MUFjN0Nk?=
 =?utf-8?B?Ynk5RkxrRThvVzMvVW9Td1hHS1RGMzZWUzU3V2prVmpjVkRsdXlJcUJFcnpZ?=
 =?utf-8?B?VEpOMTduUGhWYUdoazFXc1c3R1NYSkdzN0dOYTNyK2R3S08yL1Y4SXZiQ1lk?=
 =?utf-8?B?TjB4aWZKL21YcHlMbzRMTzIxYzV4ajNyaEQ0cGR3NmU1TlFpdS9YWjRQL1JR?=
 =?utf-8?B?MWJieGMzMjFJeTZPSDlXV1EreEVYWm00NElXdjRFR0pQRnR3clFyRm41bk11?=
 =?utf-8?B?Y04zekdyOHloYld4ek1yUndyZ2xMZmxIVkR4OEU4OG1acmN0a2VBUytFdW5U?=
 =?utf-8?Q?QRwdLYs6HjL1yJtzv/nMIeUWRZX40WR7oRC3kdPOoJf96?=
x-ms-exchange-antispam-messagedata-1: uQmuyz2uwlrs0A==
Content-Type: text/plain; charset="utf-8"
Content-ID: <37FB9A13E4F728418E21547364D87E08@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d10bf38-65e6-433e-0038-08dee714631e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 10:39:48.1306 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BDNDH31Or136khx1wFCkIkf1XRXUiKlMhhdIHjYKXKCuvnzFm/oxFYXI3zUElb6MVydAUtUEVkcSf0sEeuNCKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7334
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
Reply-To: Milos Tijanic <mtijanic@nvidia.com>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

T24gV2VkLCAyMDI2LTA3LTE1IGF0IDAxOjE0ICswNDAwLCBNb2hhbWVkIEFobWVkIHdyb3RlOg0K
PiBBIHNlY3Rpb24gdGhhdCBoYXMNCj4gbm90IGJlZW4gcG9sbGVkIHlldCwgb3IgdGhhdCB0aGUg
Ym9hcmQgZG9lcyBub3Qgc3VwcG9ydCwgcmVhZHMNCj4gLUVOT0RBVEEuDQoNClBlciBod21vbi9z
eXNmcy1pbnRlcmZhY2UucnN0OiAiQWxsIGVudHJpZXMgKGV4Y2VwdCBuYW1lKSBhcmUgb3B0aW9u
YWwsDQphbmQgc2hvdWxkIG9ubHkgYmUgY3JlYXRlZCBpbiBhIGdpdmVuIGRyaXZlciBpZiB0aGUg
Y2hpcCBoYXMgdGhlDQpmZWF0dXJlLiINCg0KSXQgZmVlbHMgcmVhbGx5IHdlaXJkIHRvIGhhdmUg
YSBidW5jaCBvZiB0aGluZ3MgdGhlcmUgdGhhdCBqdXN0IGdpdmUgYW4NCmVycm9yIGNvZGUgd2hl
biByZWFkaW5nLiBEb2VzIGFueXRoaW5nIGVsc2UgdXNlIHRoaXMgcGF0dGVybj8NCg0KPiAgIC0g
VGhlIHN5c2ZzIGludGVyZmFjZSBleHBvc2VkIGhlcmUgc2hvdWxkIGJlIHN0YWJsZSBhbmQgdmFs
aWQgZm9yDQo+IG5vdmEgYXMgd2VsbC4NCg0KQWdyZWVkLiBQbGVhc2UgYWxsb3cgYSBiaXQgb2Yg
dGltZSBmb3IgdXMgdG8gcmV2aWV3IHRoZSB1QVBJIGZvciBOb3ZhDQphbmQgZnV0dXJlIEdTUCB2
ZXJzaW9ucy4NCg0KPiAgUlVTRCBpcyBzdGFibGUgYW5kIG9ubHkgZ3Jvd3MgbW9yZSBmaWVsZHMg
d2l0aCBuZXdlciBHU1AgZmlybXdhcmUNCj4gKGUuZy4sIGZhbiB0ZWxlbWV0cnkgZ2V0cyBhZGRl
ZCBpbiByNTgwKSwgc28gaXQgaXMgcG9zc2libGUgICB0byBrZWVwDQo+IHRoZSBzYW1lIGludGVy
ZmFjZSBhcyB3ZSB1c2UgbmV3ZXIgZmlybXdhcmUNCg0KRG9uJ3QgYXNzdW1lIHRoaXMuIFdvcmsg
aXMgdW5kZXJ3YXkgdG8gc2lnbmlmaWNhbnRseSByZXdvcmsgdGhlIFJVU0QNCmxheW91dCB0byBt
YWtlIGl0IGV4dGVuc2liZSBpbiBBQkktY29tcGF0aWJsZSB3YXlzLCBidXQgdGhlcmUgd2lsbCBi
ZQ0KYSBzaW5nbGUgbGFyZ2UgQUJJIGJyZWFrIGNvbXBhcmVkIHRvIDU3MC4gVGhpcyB3aWxsIGhh
cHBlbiB3aGVuIHdlIGFkZA0KUlVTRCBzdXBwb3J0IHRvIE5vdmEsIHNvIGl0J3Mgc29tZSBtb250
aHMgb3V0IHN0aWxsLg0KDQo+ICAgLSBhbWRncHUgb2ZmZXJzIGEgc2luZ2xlIGJpbmFyeSBibG9i
IHdpdGggYWxsIHRoZSB0ZWxlbWV0cnkNCj4gZW1iZWRkZWQgaW4NCj4gICAgYWRkaXRpb24gdG8g
dGhlIHN5c2ZzIHNlbnNvciBmaWxlcy4gVGhpcyBzZXJpZXMgY3VycmVudGx5IG9ubHkNCj4gZXhw
b3Nlcw0KPiAgICAgc2Vuc29yIGZpbGVzLCBidXQgaXQgaXMgcG9zc2libGUgdG8gYWRkIGEgc2lt
aWxhciBiaW5hcnkgZm9yIGENCj4gdjIuDQo+ICAgICBUaGlzIG1haW5seSBvZmZlcnMgYSBtb3Jl
IGVmZmljaWVudCB3YXkgdG8gcmVhZCB0aGUgdGVsZW1ldHJ5IGFzDQo+ICAgICBjbGllbnRzIHdv
dWxkIHJlYWQgb25seSBhIGZldyBmaWxlcyBpbnN0ZWFkIG9mIHJlYWRpbmcgYWxsIG9mDQo+IHRo
ZW0uDQoNCklJVUMgdGhlIHJlYXNvbiBhbWRncHUgZG9lcyB0aGF0IGlzIHNvIHlvdSBjYW4gdGFr
ZSBhIHNlbGYtY29uc2lzdGVudA0KYXRvbWljIHNuYXBzaG90IG9mIGFsbCB0aGUgdGVsZW1ldHJ5
IHJlYWRpbmdzLiBUaGF0J3MganVzdCBub3QgaG93IFJVU0QNCndvcmtzLCBzbyB3ZSBkb24ndCBu
ZWVkL3dhbnQgaXQuDQoNCldlIGRvbid0IHdhbnQgdG8gZXhwb3NlIGJpbmFyeSBSVVNEIHRvIHVz
ZXJzcGFjZSB3aGlsZSBpdCBpcyB1bnN0YWJsZS4NCk9uY2UgaXQgZG9lcyBiZWNvbWUgc3RhYmxl
LCB0aGUgd2F5IHRoaXMgd2FzIG1lYW50IHRvIGJlIGV4cG9zZWQgaXMgdG8NCmFsbG93IHVzZXJz
cGFjZSB0byBSTyBtbWFwIHRoZSBidWZmZXIgYW5kIHJlYWQgdGhlIHRlbGVtZXRyeSBkaXJlY3Rs
eSwNCndpdGggbm8gc3lzY2FsbCBvdmVyaGVhZC4gQnV0IEknbSBraW5kIG9mIGxvYXRoZSB0byBk
byB0aGF0IGV2ZW4gd2l0aA0KdGhlIG5ldyBmb3JtYXQgYXMgaXQgd2lsbCByZXF1aXJlIHNvbWUg
cGFyc2luZyBhbmQgdGhhdCdzIGVhc3kgdG8gZ2V0DQp3cm9uZyBvbiB0aGUgdXNlcnNwYWNlIHNp
ZGUgYW5kIHN0aWxsIHdvcmsgaW4gYSBnaXZlbiB2ZXJzaW9uLCB0aGVuDQpicmVhayB3aXRoIGFu
IHVwZGF0ZS4NCg0KV2UgY2FuIHJldmlzaXQgdGhpcyB3aGVuIEFCSS1zdGFibGUgUlVTRCBjb21l
cywgYW5kIHRoZW4gbWF5YmUgaGF2ZSBhDQpyZWZlcmVuY2UgbGlicnVzZCB0aGF0IGRvZXMgdGhl
IHBhcnNpbmcuDQoNCg0K
