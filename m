Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DEFBC5DF70
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:05:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D24610E1FA;
	Sun, 16 Aug 2026 14:05:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="rL07Ax+q";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazolkn19013083.outbound.protection.outlook.com
 [52.103.33.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DE7010F36E
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 07:17:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSas1H90kMycSj+Lq6mIGEimDTpKnpkB7SzI63P94ZeU8EnNbMYdiDBS939anquAs5R6dL3nIi2gXKzVuwcH85q9WzLbO6fKCUSsDmyzM+4WBM0FsbEmm6x1O9CXaFj9Nw3UEtnkyFPCTvuf6ECia+E3h815I0kLHclF19mMjMpx0eEutzRQ+oC6oOw4im0kbjBhzzA83foIfWJsynWXW0MZGTCWRWJW3dqrLi9Q8aCQdcLhY7ZzNTHh+IOeAFuUIZSpVgSSah1g4MhYJFa2qNEjTPDW4YQ37IUjodNjdDtafoBPE3LW5X3pRWPOHA/YuOfVCkl7GqC4664KZTqokw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdWy/DR35dHh76AmVHo78h41MOvwgs14IuZSg/0IHqI=;
 b=phMqh5qKU4YGUiWAaW1fWJ8qj2JpNrBPnHJdEaaRg11ICB7lA6GExDIiRL6ex8yrmHv4GK/165lJLmegOI4MJDDWdPFBMXSQPQvVBerYyMnGc+MejFv6dErYMv0rEBv2i49ucfg4x2d3+UFE3BqIiFZLVS7ConyCGE9pn08aQLjknc9yfPgw+2SaO4toC6yrBqh018cAZpizwluC/MnRIaCLBGoEwf41m2ChRVxTxWvQNWF2GkeXGcCrVqb3MwyZeU12oVQ0qi9Yas5bQW4zQ30Y9er5knmJq+D7HE7a27EFDyZlzY37MpupfOVaNoAaDjaCS4vOKhzSuwkGNKBviQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdWy/DR35dHh76AmVHo78h41MOvwgs14IuZSg/0IHqI=;
 b=rL07Ax+qCGmIOOSkUGfdEnHteoVBlDm0hKD6AB4czVXY69YRTGc3ldbmdfiDQ4kvuWo8NNYnsS6s9qjH+j27tOAgBpXZ+qjO6QoJDoEUb/XC1xNoYGGpHSpHf22oVbZP0XcJmu3FQttVSpwmHLEWd8YUgoffTj4hegPagoSGW6j8HbI2yetskF+KmQLY4phER2ZJWvLSR/9QqPWfD4fSx3Z8VqCQa5379Ef5QfSIDwyPbzHHxXLx0X6TyaDV0Hi2FGtvwRiXyRNPUWZIpEg3tpH8YIqzOGXuvOJSk5nOBt50TqRnzR1RQ0Wwhw+ujkaQvi8afmTRg8iVI8iotiDtGw==
Received: from DU0P190MB2445.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:5a5::8) by
 VE1P190MB0832.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:1b0::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.13; Fri, 14 Aug 2026 07:17:25 +0000
Received: from DU0P190MB2445.EURP190.PROD.OUTLOOK.COM
 ([fe80::5dcd:351e:4e91:2380]) by DU0P190MB2445.EURP190.PROD.OUTLOOK.COM
 ([fe80::5dcd:351e:4e91:2380%3]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 07:17:25 +0000
From: Muhammed Subair <msubair@hotmail.com>
To: Maxime Ripard <mripard@kernel.org>, "heiko@sntech.de" <heiko@sntech.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Sebastian Reichel
 <sebastian.reichel@collabora.com>, "hjc@rock-chips.com" <hjc@rock-chips.com>, 
 Alexey Charkov <alchark@flipper.net>, "linux-rockchip@lists.infradead.org"
 <linux-rockchip@lists.infradead.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Andy Yan <andy.yan@rock-chips.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "royalnet026@gmail.com"
 <royalnet026@gmail.com>
Subject: RK3576: rockchip-pm-domain fw_devlink device-link failures for nested
 power-domain nodes
Thread-Topic: RK3576: rockchip-pm-domain fw_devlink device-link failures for
 nested power-domain nodes
Thread-Index: AQHdKh2u/c0cvWeN902nqdu6wxj8IbadJUBQ
Date: Fri, 14 Aug 2026 07:17:25 +0000
Message-ID: <DU0P190MB24456FE9DB02005BCDDEC336BCDA2@DU0P190MB2445.EURP190.PROD.OUTLOOK.COM>
References: <33aa66b2-cd6d-416d-b1ef-20cc83e0ee10@hotmail.com>
In-Reply-To: <33aa66b2-cd6d-416d-b1ef-20cc83e0ee10@hotmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0P190MB2445:EE_|VE1P190MB0832:EE_
x-ms-office365-filtering-correlation-id: 1ebc216c-038b-499b-5cd1-08def9d41795
x-microsoft-antispam: BCL:0;
 ARA:14566002|37011999003|51005399006|25031999004|25010399006|31061999003|8062599012|8060799015|19110799012|15080799012|55001999006|13091999003|24021099003|3412199025|440099028|102099032|40105399003|2607281247196008;
x-microsoft-antispam-message-info: =?utf-8?B?dmJmQUxkWGozUjg1cDRTdVk0SnByS2E5N1QzejIyOTNzem1HN0dEM0ZxdTQx?=
 =?utf-8?B?VHpnS2FjT3pLSWpYNmFaSlFhenZ1bUFwQ2xNMFBuTkUzUEdCdGtZc296UzNa?=
 =?utf-8?B?MG9hdTNJbDQ1TlZES2N0RnBjREJ0Ry9FOHR4YnBZR3p2TDhIelhTVnhTeURW?=
 =?utf-8?B?UStqeU9qUlpZanBBV3diekxhTlNSTEt1dWNkYkRxSklsajc1ak9TUDFTRERN?=
 =?utf-8?B?L2M5MlVNNXR2UzJ3UnlVNzdOTFQydzkrejh3ekJlWDBjS2JhdnplSEFiblM4?=
 =?utf-8?B?L0RTT3FqN1ZKV2kzdllrc2hrME52LzVNekRpa3RpWTNLaW5YRUpxTXY3WHBn?=
 =?utf-8?B?UGVYRzcwNEpRSkhjLzhZRmVVTUpQSGw2ZWFlQXVrTHdpcUl6OTBlZDZYK2hz?=
 =?utf-8?B?MGF1L3RvUWZOSllsbjlWR3RuR0R2NUVzMkZQV3BYRGZQRWxteGdsVUh4MEx6?=
 =?utf-8?B?RU1BNnc3RU1BS3l1eE1HNEY3RUhDeE0yVWtuNkgwTGNkOVpmRUxsakZDaG9Q?=
 =?utf-8?B?azhzRnhrQXd5OWJKZjRVeVVabVlER2FyeWlyOWl0dlNROVVyeVRmWWg3UTlL?=
 =?utf-8?B?Ni9ES1VFUUtka00rSEVoUVV6cUtZSW9qWFZGZlJKS3kwTmMxVjJxa3l1SmJB?=
 =?utf-8?B?MzdIaWwrRUg3OThmbkpFZ3VIT1JlcFBsbTkxZHExZW84eWJBdUQ1b0hPM2Zx?=
 =?utf-8?B?TVNzd2llQm8wMXg5UXRMMkRUOWxra0xxVk9nRGpFVDRsd01USlYxKytOUXlE?=
 =?utf-8?B?NVlHNG1jY1hXS09vUENJSWNHd0FaT09EWllkclJFNGtsZHZtSjRvRVVoOGE2?=
 =?utf-8?B?M2dxaHNoSTl3OUJubWFtYWVmNXI1WkI3TzZ1TVFGTFZLU3plY0lrVDROL1VL?=
 =?utf-8?B?MFNiWXhQdFRsMTFuaTg0WlRNTXcwYWVzZmY1L3hrcWlUQlRsR1BHRFdjeFM5?=
 =?utf-8?B?UG5GVFVLYm1DenN2UUxacURlTXpvZEhCSEtMSlQ5RVJyY1NHUjdXeVpTM0Mv?=
 =?utf-8?B?c3NnZzlSRGhONDhobnFmaWRxNzNwTE9LZHREeU5mMzZUbHlKNmJqOU5hWEtz?=
 =?utf-8?B?bUsrc2t2aUdnT0VDaG1HRjF2RkZlTExzT05YNmt0eWRLK01Yd3Q1VkYrRkJF?=
 =?utf-8?B?a05Sc0pnK0pPVDJxcld4bGxGelVvVm8zN3J5Z21tY3BaMmtERjFSM0RRTFdm?=
 =?utf-8?B?WDJXbUF2bnlnanFWS0t3eEt0aEowN2lrZTVyUkg0Zk9MV3ByRHIxczhSUXhp?=
 =?utf-8?B?dUJ3SjNyaWdkek9zc0hUbWdSYW15blFBYStJUG0vOHhYdklrVkhVSmxwdVNo?=
 =?utf-8?B?RlJFRGtVdEQ1NTBlRDlZazhPNE03dDJnSHFSTUI3YjhoYzZSeU1VS2tnWk5u?=
 =?utf-8?B?enpzQnE3Z0l6M3dSVTVFVzFkenEvTGpXNXhoenZpbjBaUmJkYnhiaVNTVDJj?=
 =?utf-8?Q?GM/TzD4V?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czFHQkFCT09iUldUbVFrSHpNMkFsQms2bk5JbkRMb2NXL1dUblh0UUR6djJS?=
 =?utf-8?B?N2pOVTZlN0ozbFBtV0VNZHdhSTBTSFJWeURHVENmUmJ4VHA5UFlSbS9uQWpE?=
 =?utf-8?B?S0FtNlR5Ny8xRXZoKzFuZlAzYUoxVkxxWW1hYWNiMUhCeitNN1pwTzdoc2Zt?=
 =?utf-8?B?cXpBU014QmpvUU5rUm4rV2xFZ0V5WWg1Wng2aEhSd1d3TkRndkxqYnRQajBl?=
 =?utf-8?B?SVBCTkVYd1VPd0x6V3hycENCWnpKZ0N3d1VRRmxLTC9wL3lPUy9RT1k0a25u?=
 =?utf-8?B?RFRwTXZoMGZaSWFZeVFKRnpyOTJkOGVVK1R2Y29XOFVyaU9ybkd3cVhlb3pr?=
 =?utf-8?B?cmxxQ24zTGEzbkhNYUR5WEQ4YTRWWXFZODU4a3YvODl2OTNybEF6TjVQckt3?=
 =?utf-8?B?djJQdWs2SktOeEp2eElBZU9ORTRkUzdCZjJUNXZ3cExSdWdLQVpOOGo0K2dD?=
 =?utf-8?B?amc2N2FMaWwvY0hUUmhFNldlTGtHR3llR1lIVDFpVjBUa0sxOW5iRDlyWGtr?=
 =?utf-8?B?S1hWN0ozcHQyWnUzemlxc3dKb1JYU2txeFBmRjNiTEg2R29lbTd4UUUyYWpE?=
 =?utf-8?B?a2tydHhBV1hwMTAzbFFac28yODJ5OVNVK3ExdnFPTlhvL3l4M2VZYXBtQ21O?=
 =?utf-8?B?Tnp6SlU0NFp3MWNnZUpraTNLMm4yQUlqTHA5bk03NXlMc2txVWwyN0kzKzMv?=
 =?utf-8?B?OXVxTU9vUVE0OVVNMHpWZUtEaXNpb1d3c2themMzVDFoR1J1SGtIY09GUmNU?=
 =?utf-8?B?SXU4TkIwKytoM2FBN2xrdDdiYW5JWDdCK3F5WUkvaXNpbHR0MThYRitONUd5?=
 =?utf-8?B?bDJ4dmFMVnFXci9TaVM4aGlnS2RHWENIdXZVaS81VUZEZTYrRXFWS1k3dHJi?=
 =?utf-8?B?dG9rYnk1d0s1eUM0c1ZMcWpTaXh3YllZY3BnNk5VTmZBSUVDV3FRL1VkbWpS?=
 =?utf-8?B?andjRnl3OFV5K0hTMlk4T1Z1S3F2SW9FU1BkWXVsM0pHMVEvbUd0OERPVWJR?=
 =?utf-8?B?dVptN29qb3RoN09ZaU90K1RMdW9ITEZiR0xwcEZORHRPUmdHMVQ2czJ0SDBu?=
 =?utf-8?B?S3h2YnZ6T3NjS2g2SlRQNVVFdEYrVmdRSEJSVDMxUitjRnFKa3dmU2kxUjJ5?=
 =?utf-8?B?cUpPNHdVTlNxYU5BSUlIV250ZHErOWhLNUpmYUcwZElFdFdreFhQcGhLWERm?=
 =?utf-8?B?Z2dQQkVjNkNnZmY2dEJLa2FHdkd2TGF5NGpqZTQvQ1ZETlBMRWNDVW1oMGsr?=
 =?utf-8?B?ek13cWpKNXMyQU1HZjJKUVdYWVh2UjFkdkwzcGU0R01LK0RiN2l5TlRVa2Rh?=
 =?utf-8?B?VmNwNWd4ZmhlRzBUdUt1Ulh3VU5XSFovbHlOa1ZtSVdOZnRYK2hxSVRHTXk0?=
 =?utf-8?B?aW9adEtnc0t6NWN4bWdxamZpelJDNVBRUHh2Z09IMGxoOGJWNkpTczd6KzRY?=
 =?utf-8?B?Mis3NU5lQ2M5R1BEbE5GeEdmN203bk5xQUxvM082TDNVTHZiSXY1NVhVZ1pI?=
 =?utf-8?B?TVViWXI4U0N3RW82WnFSSmlKRWEvaDRKNTVoV3FWZ25PV2RBaUNYNFNxeGRD?=
 =?utf-8?B?YmUvbjFlRWtEeU55Q0UyVnpHNUdNcTY4S3F0bndHeWRTN0lWL1lvQ0ljT1JI?=
 =?utf-8?B?VXllTk9QUjBCU0lneE13NnRWUXNodjdCZXVKbzJIdno4a1AvZVdKR3haQjFq?=
 =?utf-8?B?T2JuOWk3YnR4L0d3NHdwckcra1M5VENEcnpOZXViQ0FvUFFZdUZZOVY0UmZq?=
 =?utf-8?B?RExlSXgyVUxGekVlelFUWHp0a0pieEI3T0w2RkZmMFMrNStzZkVLd0RLRzQr?=
 =?utf-8?Q?19X9UiIl25T3eERoefVEKk5xL7n6V+1b1frUM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-b33f1.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0P190MB2445.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebc216c-038b-499b-5cd1-08def9d41795
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 07:17:25.7177 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P190MB0832
X-Mailman-Approved-At: Sun, 16 Aug 2026 14:05:11 +0000
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

SGkgUm9ja2NoaXAva2VybmVsIGZvbGtzLCANCg0KSSBhbSBicmluZ2luZyB1cCBhbiBSSzM1NzYg
Ym9hcmQgb24gYSA3LjEueCBiYXNlZCBrZXJuZWwgYW5kIEkgc2VlIHRoZSBmb2xsb3dpbmcgZWFy
bHkgYm9vdCBlcnJvcnMgZnJvbQ0KDQpmd19kZXZsaW5rL2RldmljZS1saW5rczogWyAwLjI2MDM4
OF0gcm9ja2NoaXAtcG0tZG9tYWluDQoyNzM4MDAwMC5wb3dlci1tYW5hZ2VtZW50OnBvd2VyLWNv
bnRyb2xsZXI6IEZhaWxlZCB0byBjcmVhdGUgZGV2aWNlIGxpbmsNCigweDE4MCkgd2l0aCBzdXBw
bGllciBzb2MgZm9yDQovc29jL3Bvd2VyLW1hbmFnZW1lbnRAMjczODAwMDAvcG93ZXItY29udHJv
bGxlci9wb3dlci1kb21haW5AMC9wb3dlci1kb21haW5AMQ0KWyAwLjI2MjE2OF0gcm9ja2NoaXAt
cG0tZG9tYWluDQoyNzM4MDAwMC5wb3dlci1tYW5hZ2VtZW50OnBvd2VyLWNvbnRyb2xsZXI6IEZh
aWxlZCB0byBjcmVhdGUgZGV2aWNlIGxpbmsNCigweDE4MCkgd2l0aCBzdXBwbGllciBzb2MgZm9y
DQovc29jL3Bvd2VyLW1hbmFnZW1lbnRAMjczODAwMDAvcG93ZXItY29udHJvbGxlci9wb3dlci1k
b21haW5AMC9wb3dlci1kb21haW5AMS9wb3dlci1kb21haW5AMg0KLi4uIFsgMC4yODU5MjddIHJv
Y2tjaGlwLXBtLWRvbWFpbg0KMjczODAwMDAucG93ZXItbWFuYWdlbWVudDpwb3dlci1jb250cm9s
bGVyOiBGYWlsZWQgdG8gY3JlYXRlIGRldmljZSBsaW5rDQooMHgxODApIHdpdGggc3VwcGxpZXIg
c29jIGZvcg0KL3NvYy9wb3dlci1tYW5hZ2VtZW50QDI3MzgwMDAwL3Bvd2VyLWNvbnRyb2xsZXIv
cG93ZXItZG9tYWluQDE4L3Bvd2VyLWRvbWFpbkAxNw0KDQpUaGUgYm9hcmQgb3RoZXJ3aXNlIGJv
b3RzIGFuZCB0aGUgYWZmZWN0ZWQgZG9tYWlucyBhcHBlYXIgZnVuY3Rpb25hbC4gDQpQQ0llL05W
TWUsIEhETUksIEV0aGVybmV0LCBldGMuIGFyZSB3b3JraW5nLiBUaGUgUkszNTc2IHBvd2VyLWNv
bnRyb2xsZXIgbm9kZSBoYXMgbmVzdGVkIHBvd2VyLWRvbWFpbiBjaGlsZHJlbi4gDQpUaGVzZSBj
aGlsZCBkb21haW4gbm9kZXMgY29udGFpbiBwcm9wZXJ0aWVzIHN1Y2ggYXMgYGNsb2Nrc2AgYW5k
IGBwbV9xb3NgLCBzaW1pbGFyIHRvIFJLMzU4OC9SSzM1NjgsIGFuZCBgI3Bvd2VyLWRvbWFpbi1j
ZWxsc2AgaXMgcHJlc2VudCBhcyByZXF1aXJlZCBieSBgcm9ja2NoaXAscG93ZXItY29udHJvbGxl
ci55YW1sYC4gDQpNeSBjdXJyZW50IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCB0aGUgUm9ja2NoaXAg
UE0gZG9tYWluIGRyaXZlciBjb25zdW1lcyB0aGVzZSBjaGlsZCBub2RlcyBpbnRlcm5hbGx5IGFu
ZCByZWdpc3RlcnMgdGhlIHByb3ZpZGVyIGZyb20gdGhlIHRvcC1sZXZlbCBgcG93ZXItY29udHJv
bGxlcmAgdmlhIGBvZl9nZW5wZF9hZGRfcHJvdmlkZXJfb25lY2VsbCgpYC4NCkhvd2V2ZXIsIGZ3
X2RldmxpbmsgcmVjdXJzZXMgaW50byB0aGUgY2hpbGQgZndub2RlcyBhbmQgdHJpZXMgdG8gY3Jl
YXRlIHByb3h5IHN1cHBsaWVyIGxpbmtzIGZvciBkZXBlbmRlbmNpZXMgc3VjaCBhcyBgY2xvY2tz
YC4gDQpTaW5jZSB0aGUgY2hpbGQgcG93ZXItZG9tYWluIG5vZGVzIGFyZSBub3Qgbm9ybWFsIGRl
dmljZXMsIHRoaXMgZW5kcyB1cCBhcyBmYWlsZWQgbGlua3MgZnJvbSBgcm9ja2NoaXAtcG0tZG9t
YWluYCB0byBzdXBwbGllciBgc29jYC4gDQpJcyB0aGlzIGV4cGVjdGVkIG5vaXNlIGZvciBuZXN0
ZWQgUm9ja2NoaXAgcG93ZXItZG9tYWluIG5vZGVzLCBvciBpcyBSSzM1NzYgbWlzc2luZyBhIERU
L2RyaXZlciBhbm5vdGF0aW9uIHRvIHByZXZlbnQgZndfZGV2bGluayBmcm9tIHRyeWluZyB0byBj
cmVhdGUgZGV2aWNlIGxpbmtzIGZvciB0aGVzZSBpbnRlcm5hbCBjaGlsZCBub2Rlcz8gDQpJIGNv
bXBhcmVkIHdpdGggUkszNTg4L1JLMzU2OCBhbmQgZGlkIG5vdCBmaW5kIGFuIG9idmlvdXMgbWlz
c2luZyBwcm9wZXJ0eSBpbiBSSzM1NzYuIEkgYWxzbyBkbyBub3Qgd2FudCB0byB1c2UgYGZ3X2Rl
dmxpbms9b2ZmYCwgDQpzaW5jZSB0aGF0IGhpZGVzIHRoZSBpc3N1ZSBnbG9iYWxseS4gQ291bGQg
eW91IGFkdmlzZSB3aGV0aGVyIHRoZSByaWdodCBmaXggc2hvdWxkIGJlOiANCg0KMS4gYSBEVCBj
aGFuZ2UgZm9yIFJLMzU3NiBwb3dlci1kb21haW4gbm9kZXMsIA0KMi4gYSBSb2NrY2hpcCBQTS1k
b21haW4gZHJpdmVyIGNoYW5nZSB0byBtYXJrIGNoaWxkIGZ3bm9kZXMgYXMgaW50ZXJuYWwvbm90
IGRldmljZXMgZm9yIGZ3X2RldmxpbmssIG9yIA0KMy4gYW4gT0YvZndfZGV2bGluayBjaGFuZ2Ug
dG8gYXZvaWQgY3JlYXRpbmcgcHJveHkgbGlua3MgZnJvbSBnZW5lcmljIHBvd2VyLWRvbWFpbiBj
aGlsZCBub2Rlcz8gDQoNCg0KVGhhbmtzLCBTdWJhaXINCg0K
