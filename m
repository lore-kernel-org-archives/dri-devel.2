Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63665C624C9
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 12:36:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8268010E26D;
	Mon, 31 Aug 2026 12:36:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fej7ElxA";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012063.outbound.protection.outlook.com [40.107.209.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE57510E26D;
 Mon, 31 Aug 2026 12:36:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/y6L23Rg426gGVbycajoO4banak4hhQZUiPI2ScjssGDByQt6xajc3nCK41s+M80+3JEeSQQzNuXrbzID9FzBf+zENpvsYji3weeLanFIDLvnPyTbQ02+KUKTiP7TagDEVyTMk6xoH0iTef6pOxUpzJv5k28vaRGMU+BuEXEGo6Zy696zEQhXsls4F6HJ5y6oajcAT50ZFcziWeTLqEXoPW6OcIUO4CTB+Z8zZnlLsz4UszjXx7dVx/EpLzFrM57dbZLg/vH+c7lFG0c9SjsIuKknTKHK3i4NcCqG6lyFdZ3B8o8v/41+XeAkwqplvIH/8k4T5BLfdeuyx9Jl5I1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dE9iWxGDF0ig9B5n8VOSQGZkm4cTo1jVwTZNkRTlIwI=;
 b=Gbud1nBSu2yAXovela5KsCj/FcFN/mrMaC9I+0lHClH+bRTXRSIXIgNAnBRKN7vA+PF66A7ndaANYLcA3P7N9p15DpWWavmqdHncu7GPChyEFc8H/1pZw7FyVXdkCek9YJuEI1/DtalC2ZqBVTlZqoPpoU+Pdav4yqzoiGUQUMd9JGSmu3WIhbhA/8eCsw6wEaaBHNXdDxoeY3wKvQjGHNHsMq1NXoC/awL/GAyLxxHIZkkh1rXP6LrTb+ZQOxuvLnzQw5vsruGQCRC6BnGORmIwygRvMqyEPAor5/QJxj1oky3ex3FSZ4ugmDDv3PyzNsdNYKPBVamVMi2iovN7IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dE9iWxGDF0ig9B5n8VOSQGZkm4cTo1jVwTZNkRTlIwI=;
 b=fej7ElxAAUF7dNXvroT7qunJgv348u94v+oQtgOOZM7x4ElL2EdtdboRTXLAo3H81JHZf/fOfqD5YhuKGjRii8IZiH724LBKJ4poD4SbPRJNVn4kc6wuzk4X5/UiDZX0mqxzj2aIbMrro/dwvSnGN1EU6p6JuOaLUkNOG1MiBUk=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by PH0PR12MB5632.namprd12.prod.outlook.com (2603:10b6:510:14c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 12:36:37 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 12:36:37 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: =?utf-8?B?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas.hellstrom@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Mika
 Kuoppala <mika.kuoppala@linux.intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "intel-xe@lists.freedesktop.org"
 <intel-xe@lists.freedesktop.org>
Subject: RE: [PATCH v5 0/4] drm: Add common drm_work_fence/drm_user_fence
 helpers and convert XE
Thread-Topic: [PATCH v5 0/4] drm: Add common drm_work_fence/drm_user_fence
 helpers and convert XE
Thread-Index: AQHdOQt+fLKOC8idBEya+WClqd29KLa38WwAgAANkpCAABWjAIAAA+/Q
Date: Mon, 31 Aug 2026 12:36:36 +0000
Message-ID: <IA0PR12MB82085C11DA7C77450210BE1F90A92@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260827062142.4038272-1-srinivasan.shanmugam@amd.com>
 <20260831054154.107602-1-srinivasan.shanmugam@amd.com>
 <772d17307920288d82c55518322d2b65686fcd25.camel@linux.intel.com>
 <IA0PR12MB8208B09EDCF4E0D77B58299290A92@IA0PR12MB8208.namprd12.prod.outlook.com>
 <8278316a3ed83374568103f509d64d71aab8fa32.camel@linux.intel.com>
In-Reply-To: <8278316a3ed83374568103f509d64d71aab8fa32.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-31T12:36:21.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|PH0PR12MB5632:EE_
x-ms-office365-filtering-correlation-id: fc6e8c22-0036-4ff2-33b0-08df075c7fb0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|38070700021|6133799003|4143699003|11063799006|10067099003;
x-microsoft-antispam-message-info: IGy1UJ4MD2IpL0nMOfpM0zLxeLOLL/7GScn4yUW60W2nph2iwvv9Lhqd4E3XAp5idoTbaWfz4Yl9kZniRKPqBORJWc7kZmPHEiimzByVSgJdW8MNZ6V/sR/MN7Siy0M5ynXhF1S9xJYaaaYkwmsGSWTzW7bhIcTmjepSZBiVvzBMtNHdPf3E4aoSo16IGjvcyIt0LTnP1PuLOmc2HV6168tJBdWHU3Bi0wfqSj9s4g7nJu11hv01WeodxlZePcq5YPCnRorye3Lwz4BSUv789oBMJmXWjmgev1oTK/9l9ytptnfO/MNURQuP1CciDd78sn/7EFOQvUQAAPpDWR/y8p1tji2vMvIE/dOoGl3Ihn4QRuIg4cyhHxCpE92KF174JLL7+XTRFfebaPfa1Y2pE5DkoA3WjKHN/s1gl49FUYzVy+/dAM3ZOvEr6vQ5hjabX+zNWLIufiG4gGeG2I+SBirxjJJy1JCIotxInG/gBEsvM5Mn/ynOxCex2i3GfzKM9qNl3cxBKqbEDEkwQfKB34+SbhbNyInzgaZhftO1a1ciEqTUGfn+3moM67CDSXTCc4rF4B06DCjmztUy7fs3bsgrjM6gy6tX5WGX9DfHqvwMIm6+IismAL+z3H/pBXsMWvPFc5/MY/damPI0Kq1utHONLBJoL2UXl03kcRbRlMTJ6w4ewswiJqMJTYm2vzlRca+DVzW/ArcqWuKENbi3U2YImX8JiGwVMPEyfhYQv8s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(38070700021)(6133799003)(4143699003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vy9OU2lMQWlhN0lWNS95SjNkYysrY2lORXhDSE8yUEYwalRkKzZrck16dCt3?=
 =?utf-8?B?cFpXcmw5cG9TRDV4Q0xqdnFPRTcvRWNwUm8wMXJ5RWpvRlhJeWxTUml5Rllp?=
 =?utf-8?B?NEE2WmVUTGNsRDVoYWt3TnZ2cjdIbmVrdDlOaFlUSmExUXM3bkpoUjJselJu?=
 =?utf-8?B?Z29XcDJLUkFQbnpxU0k0OXdjd3RvZjNNcVBCalpLOXhBbW5ZdEpqRWVrT3Rk?=
 =?utf-8?B?YmhGQ0pnRHV4VVhHYXFVQisxTE5pa05XVVYvZHVpSFozdFBBYmRpME1KZTNY?=
 =?utf-8?B?TDQrN2xveG4vcDZ2R2VPblBUMk1GZFFveEw3SWF6UkRLTVdDU3dQSmUxa0hD?=
 =?utf-8?B?c2puWWJVVnZwemNBR1o2MHdrcUhpMERDQ3pnOHhpN05HYXNiWDZ1aWF1RXNw?=
 =?utf-8?B?WExXek5rV1JmdUFESFJGWTB2M1NCbXlORlE3d21ldTlkbGg0T1hrM2ZWRDlk?=
 =?utf-8?B?T3Fsb0NpTGNudnZpQXptR2xYUTdwRTdvdG5XNDVhR0tqc3dUbWdIMGprLzVH?=
 =?utf-8?B?RmViN1BUZUJmQ0xZcFZJM2t4MHM5UWNVMlhaclUwRk51WEJEY1RlT2lRY0VW?=
 =?utf-8?B?TnBZeTU3V1NGVUFGZnNJRG5hMkI5ZlVsR1phTWlZeGZkdUhQMkJQVGJLVHEw?=
 =?utf-8?B?bE0zL28rcWw3VW5Hcy9YWjhpYTAwSzh1eW5KQmdWdzBQVmVUT2lDaEQwWXI1?=
 =?utf-8?B?blhiRzZrZTdjeTQyWVBWdk9NUi9BMStTSElsd2xZNzlqL2lTaU8wSFk3K0Zp?=
 =?utf-8?B?d1JibUtpVzIyTk91enY4MlpPejVWZHVqTTNKVjJNUkxZckpyNHloa2tFdDRE?=
 =?utf-8?B?MnpaWDBta1dKVE01NlNITzMyajR5dnU0eHFrTmowSjAxb2UyZndHZWl6MHlm?=
 =?utf-8?B?ZWhnNkZVbW0xNU1vbjhSOXBieFNkNDUweUhQZXpIZm1lczZsdkFHQTkvS1hD?=
 =?utf-8?B?UjBCQ082YWxiNHRTa0ZkeGJYcWRKTWZyR0tmaHdwNmdtbHBUYVNmbmM4R2NT?=
 =?utf-8?B?anVnRnpzbm45UkZqcDlia2IvcDlSRVMyOUQ2ait6MURESDI4cFR5aWVUbjc1?=
 =?utf-8?B?UFlDZGRrOXdPWkxDM3A5Y1ZhaFFSYVAxTk1LSGRzNm8xZjZ3dHRhYm05MGZF?=
 =?utf-8?B?eCs4NDJmR0ZhRU9aRG9wcFlFelFZTU9Cc2E0d3FxUVR2UDh5TEdBWkREREg3?=
 =?utf-8?B?NGVyRThhZ3F0bjQxdm1VUEV3UjNjOEw3WU40SGhvdTR5ZDB6cWlLTXJuUDBz?=
 =?utf-8?B?d1h3aUdRUUVWeDMvYXNHNndUL3Z5d0l0MTE3bUgzRGEzQTF1YTZDMUNaQVc1?=
 =?utf-8?B?ZllUUWFvNEhrZUtHaFR1L1Z5UHdrMGFKcUp1T1RhbnRwb0FNNVpZZmdvZ0dB?=
 =?utf-8?B?dnFnRm0xSllRUlJSU2pvMnNKVGVabHZ3MDk2Vjk0UGdNWSs0RVNUajJ5SWNn?=
 =?utf-8?B?V29QYTdJMkdOWldWbzc4TVFHdlEyb1oyaWlkMi9QbWlvYnl5ZE1xUnhueHor?=
 =?utf-8?B?bkM0dEREc2UxWTMvTnFNVnNUdUFsWG9MTHV1dDRlNml1UWEvd3p5WjFiaFV4?=
 =?utf-8?B?VHlGSzd5QUR1a09BYlZLbENtVEhWTnUxbWNlYUx6UUw0b1FQQWdDcUZzejJ5?=
 =?utf-8?B?cVVqenNVR3pmRUkxdndZTzV2OFgwMFpkSFpFU1hFbGVXSXVJMmtvYWFyUUlk?=
 =?utf-8?B?OUEwdVpMLzBQMmt5bkdrazdoRVh1cUcralVQb3hPM3A4RUFQNjhNQU9FMkVz?=
 =?utf-8?B?eEN3SnQ3Y2dUa2xDMG9lWnlzUVdJOHY3UEtJRmlyak1uM0ZDS1U4NnFFaEF6?=
 =?utf-8?B?TlpIVDBDUmhXY21KSXQzL2FxVmNBY3JJbmtCYnB3ZUIzSE4yKzNMakFMZ0x4?=
 =?utf-8?B?czBBam5WRS9kL3N0Q0F2Ykx5RkJOQzc0Z0JTb1g4enp6T25ZNXJ2cG9sQ2xK?=
 =?utf-8?B?LzNRcnpmMndzVWZHdStVQVVId2dlYTVxRElQM3NmOHhUM3R6ZTdrMEhqbUU5?=
 =?utf-8?B?eFhXWFdnNmxQQ2FJWExMV01aaUFuQVZiQWMxL1ozTnlXQkZpellMdndNS0ti?=
 =?utf-8?B?Qy9JTGhXUWpmeEV3S0w0YUw4V0d0cWJuaDNHRFZVVWpGMDMwcE9LM3IwMWJn?=
 =?utf-8?B?eGo2U2FZVWkvWUtTS1BCZDNzd0U3VWR5eERxc1pjQWNZcDRCOENGa0NrVERC?=
 =?utf-8?B?OXVhY3FKL2JyTE5sZG5Gc0QzYzIvdCsyS0JncnFEMkVBbkJMNzFHRUJHTThB?=
 =?utf-8?B?MlN2aTZaNWpXVHVEU2RYNHdSd0NjSDdEaDFKVnZBMU1tM2RaaCt3VTNZazJi?=
 =?utf-8?Q?cwGka9Ohw3IzyQ/GyT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc6e8c22-0036-4ff2-33b0-08df075c7fb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 12:36:37.0225 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eFSWYrgaq6E7YZK+oICyhmxWbGUTVjXgcrwu6JGzm2xfg/688kK9/1Mm7gSFDdFDFQAalYhG7gUjjsGylZa20A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5632
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
IE1vbmRheSwgQXVndXN0IDMxLCAyMDI2IDU6NTIgUE0NCj4gVG86IFNIQU5NVUdBTSwgU1JJTklW
QVNBTiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT47DQo+IE1hdHRoZXcgQnJvc3QgPG1h
dHRoZXcuYnJvc3RAaW50ZWwuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4NCj4gPENocmlzdGlhbi5L
b2VuaWdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJA
YW1kLmNvbT4NCj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBNaWthIEt1b3Bw
YWxhDQo+IDxtaWthLmt1b3BwYWxhQGxpbnV4LmludGVsLmNvbT47IE1hYXJ0ZW4gTGFua2hvcnN0
DQo+IDxtYWFydGVuLmxhbmtob3JzdEBsaW51eC5pbnRlbC5jb20+OyBkcmktZGV2ZWxAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnOyBpbnRlbC0NCj4geGVAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMC80XSBkcm06IEFkZCBjb21tb24gZHJtX3dvcmtfZmVuY2Uv
ZHJtX3VzZXJfZmVuY2UNCj4gaGVscGVycyBhbmQgY29udmVydCBYRQ0KPg0KPiBPbiBNb24sIDIw
MjYtMDgtMzEgYXQgMTE6MTMgKzAwMDAsIFNIQU5NVUdBTSwgU1JJTklWQVNBTiB3cm90ZToNCj4g
PiBBTUQgR2VuZXJhbA0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
ID4gRnJvbTogVGhvbWFzIEhlbGxzdHLDtm0gPHRob21hcy5oZWxsc3Ryb21AbGludXguaW50ZWwu
Y29tPg0KPiA+ID4gU2VudDogTW9uZGF5LCBBdWd1c3QgMzEsIDIwMjYgMzo0NiBQTQ0KPiA+ID4g
VG86IFNIQU5NVUdBTSwgU1JJTklWQVNBTiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT47
DQo+IE1hdHRoZXcNCj4gPiA+IEJyb3N0IDxtYXR0aGV3LmJyb3N0QGludGVsLmNvbT47IEtvZW5p
ZywgQ2hyaXN0aWFuDQo+ID4gPiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgRGV1Y2hlciwg
QWxleGFuZGVyDQo+ID4gPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4gPiA+IENjOiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgTWlrYSBLdW9wcGFsYQ0KPiA+ID4gPG1pa2Eu
a3VvcHBhbGFAbGludXguaW50ZWwuY29tPjsgTWFhcnRlbiBMYW5raG9yc3QNCj4gPiA+IDxtYWFy
dGVuLmxhbmtob3JzdEBsaW51eC5pbnRlbC5jb20+Ow0KPiA+ID4gZHJpLWRldmVsQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZzsgaW50ZWwtIHhlQGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiA+ID4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2NSAwLzRdIGRybTogQWRkIGNvbW1vbg0KPiA+ID4gZHJtX3dvcmtf
ZmVuY2UvZHJtX3VzZXJfZmVuY2UgaGVscGVycyBhbmQgY29udmVydCBYRQ0KPiA+ID4NCj4gPiA+
IE9uIE1vbiwgMjAyNi0wOC0zMSBhdCAxMToxMSArMDUzMCwgU3Jpbml2YXNhbiBTaGFubXVnYW0g
d3JvdGU6DQo+ID4gPiA+IFdoZW4gYSBHUFUgZG1hLWZlbmNlIHNpZ25hbHMsIGRyaXZlcnMgb2Z0
ZW4gbmVlZCB0byBwZXJmb3JtIHdvcmsNCj4gPiA+ID4gdGhhdCBjYW5ub3QgcnVuIGluIElSUSBj
b250ZXh0LiBUaGlzIHBhdHRlcm4gaXMgY3VycmVudGx5DQo+ID4gPiA+IG9wZW4tY29kZWQgaW4g
bXVsdGlwbGUgZHJpdmVycy4NCj4gPiA+ID4NCj4gPiA+ID4gVGhpcyBzZXJpZXMgaW50cm9kdWNl
cyB0d28gbGF5ZXJlZCBoZWxwZXJzOg0KPiA+ID4gPg0KPiA+ID4gPiBQYXRjaCAxIGludHJvZHVj
ZXMgZHJtX3dvcmtfZmVuY2Ug4oCUIGEgZ2VuZXJpYyBlbWJlZGRhYmxlIGJhc2UNCj4gPiA+ID4g
c3RydWN0dXJlIHRoYXQgaGFuZGxlcyB0aGUgZG1hLWZlbmNlLWNhbGxiYWNrLXRvLXdvcmtxdWV1
ZQ0KPiA+ID4gPiBwYXR0ZXJuLg0KPiA+ID4gPiBBbnkgZHJpdmVyIG5lZWRpbmcgZGVmZXJyZWQg
ZmVuY2Ugd29yayBjYW4gdXNlIHRoaXMgZGlyZWN0bHkuDQo+ID4gPiA+DQo+ID4gPiA+IFBhdGNo
IDIgaW50cm9kdWNlcyBkcm1fdXNlcl9mZW5jZSDigJQgYSB0aGluIGxheWVyIG9uIHRvcCBvZg0K
PiA+ID4gPiBkcm1fd29ya19mZW5jZSB0aGF0IGFkZHMga3RocmVhZF91c2VfbW0oKSBzdXBwb3J0
IGZvciBkcml2ZXJzIHRoYXQNCj4gPiA+ID4gbmVlZCB0byBhY2Nlc3MgdXNlcnNwYWNlIG1lbW9y
eSB3aGVuIGEgZmVuY2Ugc2lnbmFscy4NCj4gPiA+ID4NCj4gPiA+ID4gUGF0Y2ggMyBjb252ZXJ0
cyBYRSB0byB1c2UgZHJtX3VzZXJfZmVuY2UuIFhFIGNvbnRpbnVlcyB0byB3cml0ZSBhDQo+ID4g
PiA+IGZlbmNlIGNvbXBsZXRpb24gdmFsdWUgdG8gYSB1c2Vyc3BhY2UgVkEgdXNpbmcgdGhlIG5l
dyBoZWxwZXIuDQo+ID4gPiA+DQo+ID4gPiA+IFBhdGNoIDQgYWRkcyBvcHRpb25hbCBwZXItc2ln
bmFsIGNvbXBhcmUgZnVuY3Rpb25hbGl0eSB0bw0KPiA+ID4gPiBkcm1fdXNlcl9mZW5jZS4NCj4g
PiA+ID4gV2hlbiBjbXBfYWRkciBpcyBzZXQsIHRoZSB3b3JrZXIgaXMgY2FsbGVkIG9ubHkgaWYg
dGhlIHZhbHVlIGF0DQo+ID4gPiA+IGNtcF9hZGRyIHNhdGlzZmllcyB0aGUgY29uZmlndXJlZCBj
b21wYXJpc29uLiBUaGlzIGVuYWJsZXMNCj4gPiA+ID4gQU1ER1BVJ3MgRU9QIGV2ZW50ZmQgcGVy
LXNpZ25hbCBmaWx0ZXJpbmcgd2l0aG91dCBvcGVuLWNvZGluZyB0aGUNCj4gPiA+ID4gcmVhZCtj
b21wYXJlDQo+ID4gPiA+IHBhdHRlcm4uDQo+ID4gPiA+DQo+ID4gPiA+IEEgZm9sbG93LW9uIHBh
dGNoIChub3QgaW4gdGhpcyBzZXJpZXMpIHdpbGwgd2lyZSBBTURHUFUncyByZW5kZXItDQo+ID4g
PiA+IG5vZGUgRU9QIGV2ZW50ZmQgc2lnbmFsaW5nIHBhdGggdG8gZHJtX3dvcmtfZmVuY2UuDQo+
ID4gPiA+DQo+ID4gPiA+IHY1Og0KPiA+ID4gPiAgLSBTcGxpdCBkcm1fdXNlcl9mZW5jZSBpbnRv
IGRybV93b3JrX2ZlbmNlIChnZW5lcmljKSBhbmQNCj4gPiA+ID4gZHJtX3VzZXJfZmVuY2UNCj4g
PiA+ID4gICAgKE1NLWJvcnJvd2luZyBzdWJjbGFzcykgcGVyIE1hdHRoZXcgQnJvc3QncyBzdWdn
ZXN0aW9uLg0KPiA+ID4gPiAgLSBBZGQgcGVyLXNpZ25hbCBjb21wYXJlIGZ1bmN0aW9uYWxpdHkN
Cj4gPiA+ID4gKGRybV91c2VyX2ZlbmNlX3NldF9jb21wYXJlKCkpDQo+ID4gPiA+ICAgIHBlciBD
aHJpc3RpYW4gS8O2bmlnJ3Mgc3VnZ2VzdGlvbi4NCj4gPiA+ID4gIC0gVXNlIG1tcHV0X2FzeW5j
KCkgaW5zdGVhZCBvZiBtbXB1dCgpIHRvIGF2b2lkIHBvdGVudGlhbA0KPiA+ID4gPiBkZWFkbG9j
ayBpbg0KPiA+ID4gPiAgICBNTVUgbm90aWZpZXIgcmVsZWFzZSBwYXRoLiAoU2FzaGlrbyByZXZp
ZXcpDQo+ID4gPiA+DQo+ID4gPiA+IFN1Z2dlc3RlZC1ieTogTWF0dGhldyBCcm9zdCA8bWF0dGhl
dy5icm9zdEBpbnRlbC5jb20+DQo+ID4gPiA+IFN1Z2dlc3RlZC1ieTogQ2hyaXN0aWFuIEvDtm5p
ZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KPiA+ID4gPiBDYzogTWlrYSBLdW9wcGFsYSA8
bWlrYS5rdW9wcGFsYUBsaW51eC5pbnRlbC5jb20+DQo+ID4gPiA+IENjOiBUaG9tYXMgSGVsbHN0
csO2bSA8dGhvbWFzLmhlbGxzdHJvbUBsaW51eC5pbnRlbC5jb20+DQo+ID4gPiA+IENjOiBNYWFy
dGVuIExhbmtob3JzdCA8bWFhcnRlbi5sYW5raG9yc3RAbGludXguaW50ZWwuY29tPg0KPiA+ID4g
PiBDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiA+ID4gPiBDYzogaW50ZWwt
eGVAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+ID4gPiA+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZw0KPiA+ID4NCj4gPiA+IEkgdGhpbmsgdGhlIGdldF91c2VyKCkgYW5kIHB1dF91
c2VyKCkgb2YgNjQtYml0IHZhbHVlcyBpbiBkcm0NCj4gPiA+IChkcml2ZXINCj4gPiA+IGNvbW1v
bikgY29kZSBpcyBub3Qgc2FmZSBmb3IgdHlwaWNhbCB1c2UtY2FzZXMgb24gMzItYml0IHN5c3Rl
bXMuDQo+ID4gPiBGb3IgeGUgd2UNCj4gPiA+IG9mZmljaWFsbHkgZG9uJ3QgKHlldCBhdCBsZWFz
dCkgc3VwcG9ydCAzMi1iaXQgc3lzdGVtcyBzbyBoZW5jZSB0aGUNCj4gPiA+IGNvZGUgaXMgYSBi
aXQgc2xvcHB5IGJ1dCBmb3IgZHJtIGhlbHBlcnMgSSdtIG5vdCBzdXJlIHdlIGNhbiBnZXQNCj4g
PiA+IGF3YXkgd2l0aCB0aGlzLiBBdCBsZWFzdCBub3Qgd2l0aG91dCBzb21lIGZvcm0gb2Ygd2Fy
bmluZyBvciBhc3NlcnQuDQo+ID4gPg0KPiA+ID4gSSB0aGluayB0byBtYWtlIDMyLWJpdCBzeXN0
ZW1zIDY0LWJpdCB1c2VyLWZlbmNlIHNhZmUsIHdlIHdvdWxkIG5lZWQNCj4gPiA+IHRvIHVzZXIN
Cj4gPiA+IHBpbl91c2VyX3BhZ2VzKCkgY29tYmluZWQgd2l0aCBjbXB4Y2hnNjQoKSBhbmQgYSBz
aW1pbGFyIGNtcHhjaGcNCj4gPiA+IG9wZXJhdGlvbiBvbiB0aGUgdXNlci1zcGFjZSBzaWRlLg0K
PiA+DQo+ID4gSGkgVGhvbWFzLA0KPiA+DQo+ID4gVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KPiA+
DQo+ID4gRm9yIHRoZSAzMi1iaXQgc2FmZXR5IGNvbmNlcm4gb24gZ2V0X3VzZXIoKSBvZiB1NjQg
dmFsdWVzIOKAlCBzaW5jZSBubw0KPiA+IGN1cnJlbnQgR1BVIGRyaXZlciBzdXBwb3J0cyAzMi1i
aXQgdXNlciBmZW5jZXMgKFhFIGV4cGxpY2l0bHkgZXhjbHVkZXMNCj4gPiAzMi1iaXQsIGFuZCBB
TURHUFUgdGFyZ2V0cyBtb2Rlcm4gaGFyZHdhcmUpLCB3b3VsZCBhZGRpbmcgYQ0KPiA+IEJVSUxE
X0JVR19PTiBvciBJU19FTkFCTEVEKENPTkZJR182NEJJVCkgZ3VhcmQgaW4NCj4gPiBkcm1fdXNl
cl9mZW5jZV9zZXRfY29tcGFyZSgpIGJlIGFjY2VwdGFibGUgZm9yIG5vdz8NCj4gPg0KPiA+IElm
IGEgMzItYml0IGRyaXZlciBldmVyIG5lZWRzIHRoaXMgaW4gdGhlIGZ1dHVyZSwgd2UgY2FuIGZv
bGxvdyB1cA0KPiA+IHdpdGggcGluX3VzZXJfcGFnZXMoKSArIGNtcHhjaGc2NCgpIGZvciBwcm9w
ZXIgYXRvbWljIGFjY2Vzcy4NCj4gPg0KPiA+IERvZXMgdGhhdCBhcHByb2FjaCB3b3JrIGZvciB5
b3U/DQo+DQo+IFhlIHN1cHBvcnRzIGJ1aWxkaW5nIG9uIDMyLWJpdCBidXQgbm90IHJ1bm5pbmcu
IENhbiB3ZSB1c2UgYQ0KPiBkcm1fV0FSTl9PTl9PTkNFKCFJU19FTkFCTEVEKENPTkZJR182NEJJ
VCkpIG9yIHNpbWlsYXIgc29tZXdoZXJlPw0KPiBQZXJoYXBzIHRoYXQgd2FzIHlvdXIgc2Vjb25k
IHN1Z2dlc3Rpb24/DQoNCkhpIFRob21hcywNCg0KWWVzLCB0aGF0IG1hdGNoZXMgb3VyIHN1Z2dl
c3Rpb24uIFdlIHdpbGwgYWRkOg0KDQogICAgV0FSTl9PTl9PTkNFKCFJU19FTkFCTEVEKENPTkZJ
R182NEJJVCkpOw0KDQppbiBkcm1fdXNlcl9mZW5jZV9zZXRfY29tcGFyZSgpLiBXZSBjYW5ub3Qg
dXNlIGRybV9XQVJOX09OX09OQ0UoKQ0Kc2luY2UgZHJtX3VzZXJfZmVuY2UgaGFzIG5vIHN0cnVj
dCBkcm1fZGV2aWNlICogcmVmZXJlbmNlLg0KDQpJcyBwbGFpbiBXQVJOX09OX09OQ0UgYWNjZXB0
YWJsZSwgb3Igc2hvdWxkIHdlIGFkZCBhIGRybV9kZXZpY2UNCnBvaW50ZXIgdG8gZHJtX3VzZXJf
ZmVuY2Vfc2V0X2NvbXBhcmUoKSB0byB1c2UgZHJtX1dBUk5fT05fT05DRSgpPw0KDQpUaGFua3Ms
DQpTcmluaQ0K
