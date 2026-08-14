Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A8FC5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 03:23:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A08B10E51A;
	Fri, 14 Aug 2026 03:23:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F81fTUx1";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012055.outbound.protection.outlook.com
 [40.107.200.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 367E410E51A;
 Fri, 14 Aug 2026 03:23:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/UA7WjvvWlf1PUhNlo0fMKKVoNWrKV9v5vLqanCX7LDAnRWI+Nt0HYmQXf5xielu8a2zA+hEeFGt1m8H2cOWlZhiuDlLentSJCBjCyGW40Q5OkPgvkqb1ggXsczx3ZgYEzsWlt3k0KBy7aC7BLyosMMVC1+dmrDIfOB/oeop8uCzJEW7MYhxAchmhdaDapN7eLLSXCji0vrNI1c7h0BE+LXXbtjrJe7FsY8YhXyW7S4iqnlZlUt62/TX9Zj34vvUCriZVO9bZXoWQdykAmQJQDLo+KDuIu2Xh8lY5OaP9a2d9ph6/eAJDHFWOqYYdhF6J+vUFKVj7ziDDKrJtY5rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=imfTuLPzdJHbLAPnAaN7hIheR4iNbKC9OdIUfian5Y8=;
 b=M9sniTFzahqUrfNBDHK9IIzv5zLfMY6q6DoTHCHptuOK3cF5vqoMCfDORLfg1raddN9QwZG6R4vaWMIT/0ZEVppnZhNXus/S+pMbu+o4fKgC/k8Bli/YWMeaNZHtqKj3pfSPSW5UfvaF/3sbEo6TelZByCwO2/Af82hRn5+SVheU6+L6vqMHNkGaDTmLEGk0E9bnNK803f2BgZxtuoyUkPv56ZTNkSSPJ5PsEC34+fGrN8Sk2QHuteOvbxWvKQv1BhDV2wlUmTgheM6ohoIUbmzGf8MauCdm63FSVFMnl2fXbavX3hbcndstF7738m48Xpkwte1yEjNT8fBJtKr9Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imfTuLPzdJHbLAPnAaN7hIheR4iNbKC9OdIUfian5Y8=;
 b=F81fTUx1ccLCYd+1g4yRb/jTAHgsF9mGHZLmgL7GM1Vj7/eKlYh+TLHyEhWoutzV88Og48um+mDFU8+fVV7zcNDWwJl/4wxIy7eyTMusfqGZSs530ycC4a/jCgzjMonlSd3HzAlH1+WOEHLb19De8kc4sJJ67DGizmRmGWWtFWY=
Received: from BN9PR12MB5211.namprd12.prod.outlook.com (2603:10b6:408:11c::24)
 by IA0PR12MB8277.namprd12.prod.outlook.com (2603:10b6:208:3de::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Fri, 14 Aug
 2026 03:23:16 +0000
Received: from BN9PR12MB5211.namprd12.prod.outlook.com
 ([fe80::1bae:ee6:d7f4:b85a]) by BN9PR12MB5211.namprd12.prod.outlook.com
 ([fe80::1bae:ee6:d7f4:b85a%5]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 03:23:16 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, Boqun Feng <boqun@kernel.org>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Mark
 Janes <mjanes@netflix.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Kamal, Asad"
 <Asad.Kamal@amd.com>, "Hosur, Priya" <Priya.Hosur@amd.com>, "M, Mythila"
 <Mythila.M@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Umio Yasuno
 <coelacanth_dream@protonmail.com>
Subject: RE: [PATCH] drm/amd/pm: Fix incorrect avg vcn utilization in
 gpu_metrics
Thread-Topic: [PATCH] drm/amd/pm: Fix incorrect avg vcn utilization in
 gpu_metrics
Thread-Index: AQHdJOMVMovV+Bqc60GnlZH3bheAc7acjboAgAAHK4CAAAaOgIAAKNMAgAApW1A=
Date: Fri, 14 Aug 2026 03:23:15 +0000
Message-ID: <BN9PR12MB5211679FCDBB9B1BC8ABA54A82DA2@BN9PR12MB5211.namprd12.prod.outlook.com>
References: <20260805140227.44868-1-boqun@kernel.org>
 <an44yIv7WG7vqTqQ@tardis.local>
 <CADnq5_PLV1rDw8DSawdHfQxyk8XgPp94TQa0HuFVdZVvZo+zmQ@mail.gmail.com>
 <an5ESxy8-OMYvD4d@tardis.local>
 <CADnq5_PQgYboc8pPCRYimpf7fALgSPid-GGJzNsA+TuODsa8gA@mail.gmail.com>
In-Reply-To: <CADnq5_PQgYboc8pPCRYimpf7fALgSPid-GGJzNsA+TuODsa8gA@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-14T03:19:23.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5211:EE_|IA0PR12MB8277:EE_
x-ms-office365-filtering-correlation-id: 04c97bb2-dfdf-4cb1-24e3-08def9b3614c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|38070700021|22082099003|18002099003|56012099006|11063799006|3023799007|4143699003|10067099003;
x-microsoft-antispam-message-info: q9W4CTpiiBkBnEme2EdLBSzuCplyc76uN/XhHNyhHULf/XSnqgOkiNbbbIEgtJelosNXLAlo92Qpr2MLecbwcY8URHaJOQmfQgu58f0hvjVet9TDVuSsGmaYfjUFYLU+UF4Ckg4hIOnyflqOPkw7KownAoQQ59YCB5SKq1GVshbCz52ClR+KdSIfylEIk5lcosPY3fcDOUIX+EfvfLAGWtXI3M5tgaKYo/F83zpYFjhCJFb+mAt0qlX8KFcQjsHp6jMuk7081hbVyUclDbNqmirmFle2d3+1SKXI+IgBk1T1P/OLvOy7IhyQoG7/YRt7VgBRFonIVUn73ihc+ElEYKQiByvHn6EWfaj4nKLq2RAolzDI10S3C4gjL+8Cqg1SbbinQjE4yCXmi40dkcK9AXiqq71mj9ePxazhwQNIu3JMGldvKYf4nrEcPUN38pOMgrN7LCN07cen5FySsQ9ek4gq0PTOYIpF7duDh3EX0F+r8fmVkhE52c3sa1zhos7ZC7qSIRi9LHNgFRcsT9LIQReVzSDJkkAmOn8Cf/lS+PxIW6s4zsRiFUR4Kw+p0NpKGpzFMRC2I7zvK8FDjnWmdHTYw3iuHMr7ALycDTzQIxnFxZ4iLUybDNqgkyzZ0n14XFlI1efJVMtIKgMe3kAwBdrcOhsT7xTVkw22UtQ1BkIvkeBXR71gRj8NsqP9FzlBCSHjZ/UCGpofgjRNm77x+g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5211.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(38070700021)(22082099003)(18002099003)(56012099006)(11063799006)(3023799007)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXM2ZWVHbGdObDNidGxmeU1CbnhFTnMzYlV4eWxEaFdlVjZkK243YXoyR0I2?=
 =?utf-8?B?OXBBalhFd2U5dnVLc1ppSFpRNVQyMjhiR3BpckR4MUNHQ0VXSGpFWWVkTGxn?=
 =?utf-8?B?VmVZaE1TcmxCbFdrOG8ySXRnRjZFaVFmZ25BYmlQWnNrU0dQWWsvRHd3VjV3?=
 =?utf-8?B?ZnNwcElVcTBJbS83eEJFSGlZTzhPZzczRFVCYU9tQU1YRSs2eUdLcGFJemor?=
 =?utf-8?B?SFpSM3FtOHVqaHdTdkt4YkJLaWpwb1ZZSCt1akpacnNRQnNhbW14M3ZZTmtL?=
 =?utf-8?B?NGZoa3NJaFhVTkdFUnVEdlZqTEZXR3RvMEN4aXN2SGRWN3lnWDZ0bHNrcFJW?=
 =?utf-8?B?N1l3REdQVzBiRTVmcFVrQUMyMk0xYXF6Wnc1VlJLRzZndjNhanpRb1diVk9a?=
 =?utf-8?B?NmZEQU04OWx1bnZ0WnRYSVoxaEg3THVTV3hRNVp3eUFicWNjdjFtRUhFdWpM?=
 =?utf-8?B?ZVZBNnBXT0JYVzJjQlJwb3I2YzlKZVFjdElPcSt4Q3hLMkd4TXdVODNUOGIw?=
 =?utf-8?B?T2RXRGtoMzhJNCt5WXplMHF6TEdXOHpwcFdzSXJvdFRFTE9nRUpqT3NBUEhR?=
 =?utf-8?B?a3dzaFBtUHA0aUt4bEZMQ2dRTitSRmVuRyt4bDJtQzRUSWkxcWVUQnp1NFRI?=
 =?utf-8?B?K05qS0VKSC9RZE9zRHdRdktxa1ZXMzZQMTlHZFVCMzlYT1JQODlEOVhVdVpT?=
 =?utf-8?B?cGw0WjRiQ3VNWXVidHI0ZG9FMjdFM2ErVXN4YUswWkZaRzFKNkRHa2tpc3Rh?=
 =?utf-8?B?Zlo5U2UyNk1uUnVIZXZPaW41NTJROFVxUW9reVhyVStGSXYyWU9EYUFnMm1X?=
 =?utf-8?B?K0l6bHBOSkZZUkRQTHI0UzRZeFRlZlpoalpuV2J4QkplRGN4VG11QkFVN0dZ?=
 =?utf-8?B?d1pONjhKcnBta2hMVzZKbGdDVElVaS9ZejF4djFCZUFLRHVaZFBDU2hGdUt0?=
 =?utf-8?B?UmQ5eElOaHh6QmVDY0Z1MEkzcENOTUtGZndOSmtJK1Flb3RYb0w1UjJHdzEr?=
 =?utf-8?B?TURJUlZvVUJJTllOaDErcFdVUU9wZnBrZ1F3c3hQRGxCMlZDRzcxbTdNaXNv?=
 =?utf-8?B?VGc4dGxrUkM5RVE3NTVveVpHQmxFTm45SmVVNUZjUVdvN3MwYnBXRXZTNURl?=
 =?utf-8?B?cy9wL3ZRNmR5UTFmOHR1Y1RCVjRIZXFia0RCcjgxUXh3bnUxSVpHV1FJbTV4?=
 =?utf-8?B?cisvOVZyemY4VURHL1haYUd0UmV5WGQwbGZvV0twQk05SU1zeGIxdlp0Q2pH?=
 =?utf-8?B?QmdVaUdEdFFCWnZvVjIyMmwyVWdJMUFQV0dqV2pXNGtib0wrSUxITjBBZ3JP?=
 =?utf-8?B?bGlxaThLV2wzZHlVYXFVY25ZS0IzRERWOUdLUVJkMFVQQ3A5ZmNmY041RmVN?=
 =?utf-8?B?cGhVU1o2R21KUm1RZ2NpQk9hdFdoL1REeVdqUU5HaS9sT2RyaHJzV1ZGS0xs?=
 =?utf-8?B?VHEyWnVJRjY2SDUwRk9YYy9WRmdJRmZvdXp0S0tlWVY5SXE2aUdhRjRhdVk4?=
 =?utf-8?B?Q2M1aFlmeDFyd09Fa2VpbmJwVkhPenBwT0RUUHIzdXM3Z2ZkYW1VTjlTSXlH?=
 =?utf-8?B?clFLSW44UzNFNkJpdUdCUmlNMDF1d1NMS2JxdFpqRFJCckpXR3ZVN29lUTM2?=
 =?utf-8?B?Mm1LSm5WckRGL2o2Mmx4TzdGSjhraEJBSHNrRW1sdnlPeW05eXJDaUp1ZkVt?=
 =?utf-8?B?Wm1tWUg5VTVNUlVIVFRPUWExTWlOSE16K0laNzcxZ3ZiWk9JY0ZYTkZ0TFJp?=
 =?utf-8?B?YjJiZStOZlNPSlFpRTYvUnB1YUtzUllBSm1XYUlrcGtqZ2poWTdudGtxaGFW?=
 =?utf-8?B?c3NJUTc1Mk9ycHF2U1V2dWlYV0QzemRnRitZQjBOZ3h5S3Nid0p5QWdiSEZq?=
 =?utf-8?B?d3R6QkpoVXNBc2p5eGU3M0E5SFlDNlRHcTdTVjJTQ0kvdEZWc0VkdkV1Tmpx?=
 =?utf-8?B?NFNhbzJ5VGE0dlRRTUhNMnBPU3Jxd0ZYZ3ZyVnVaR2kzb1VHak04U1VZQWhP?=
 =?utf-8?B?dVB4SUJaZkk4QnVEelRJQnpKelM0WkVMN3VUdC9zbjhzdW5qTjl4ZHhHSS9o?=
 =?utf-8?B?MFdHWmJVZk4vbEllblhQTnpMazI0WnFRdi9LTWxyNnd0ZWZNTGpBRWxCWEsw?=
 =?utf-8?B?TWw0ZXdzOE1JbmNYclBUWEVteFczZld2VFZTVHlLU3lVMURWaXI1K3pWRHZx?=
 =?utf-8?B?TkxadGhNakVPNHVMaE1UaWdqOWs3a0h1VkkvQS9pSVZVSW9VaFJuZCs0V1FH?=
 =?utf-8?B?ejdNOG5QUFJOZ2pOdnhhS2NqbVdHcUlxc1lIN0lxa0Z0RXNiUVhpNWdxYjRh?=
 =?utf-8?Q?1FAoG16fj0LLgZjFnE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5211.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c97bb2-dfdf-4cb1-24e3-08def9b3614c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 03:23:15.9679 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Ndo9UZO+GD+sIaittF+yA3F39VjoBWbWf077Fcl5TJv3mjDzglpQt9Z8CNtMrRw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8277
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

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4
IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBBdWd1c3Qg
MTQsIDIwMjYgODo1MSBBTQ0KPiBUbzogQm9xdW4gRmVuZyA8Ym9xdW5Aa2VybmVsLm9yZz4NCj4g
Q2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBNYXJrIEphbmVzIDxtamFuZXNAbmV0
ZmxpeC5jb20+OyBGZW5nLA0KPiBLZW5uZXRoIDxLZW5uZXRoLkZlbmdAYW1kLmNvbT47IERldWNo
ZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEtvZW5pZywgQ2hy
aXN0aWFuDQo+IDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBEYXZpZCBBaXJsaWUgPGFpcmxp
ZWRAZ21haWwuY29tPjsgU2ltb25hDQo+IFZldHRlciA8c2ltb25hQGZmd2xsLmNoPjsgTGF6YXIs
IExpam8gPExpam8uTGF6YXJAYW1kLmNvbT47IEthbWFsLCBBc2FkDQo+IDxBc2FkLkthbWFsQGFt
ZC5jb20+OyBXYW5nLCBZYW5nKEtldmluKSA8S2V2aW5ZYW5nLldhbmdAYW1kLmNvbT47DQo+IEhv
c3VyLCBQcml5YSA8UHJpeWEuSG9zdXJAYW1kLmNvbT47IE0sIE15dGhpbGEgPE15dGhpbGEuTUBh
bWQuY29tPjsNCj4gTGltb25jaWVsbG8sIE1hcmlvIDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29t
PjsgZHJpLQ0KPiBkZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IFVtaW8gWWFzdW5vDQo+IDxjb2VsYWNhbnRoX2RyZWFtQHByb3Rvbm1haWwu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kL3BtOiBGaXggaW5jb3JyZWN0IGF2
ZyB2Y24gdXRpbGl6YXRpb24gaW4NCj4gZ3B1X21ldHJpY3MNCj4NCj4gT24gVGh1LCBBdWcgMTMs
IDIwMjYgYXQgNjoyNeKAr1BNIEJvcXVuIEZlbmcgPGJvcXVuQGtlcm5lbC5vcmc+IHdyb3RlOg0K
PiA+DQo+ID4gT24gVGh1LCBBdWcgMTMsIDIwMjYgYXQgMDY6MDE6NDdQTSAtMDQwMCwgQWxleCBE
ZXVjaGVyIHdyb3RlOg0KPiA+ID4gT24gVGh1LCBBdWcgMTMsIDIwMjYgYXQgNTozNuKAr1BNIEJv
cXVuIEZlbmcgPGJvcXVuQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBPbiBX
ZWQsIEF1ZyAwNSwgMjAyNiBhdCAwNzowMjoyMUFNIC0wNzAwLCBCb3F1biBGZW5nIHdyb3RlOg0K
PiA+ID4gPiA+IEluIGEgU3RyaXggSGFsbyBzeXN0ZW0sIGEgPjEwMCBhdmVyYWdlX3Zjbl9hY3Rp
dml0eSBpbg0KPiA+ID4gPiA+IGdwdV9tZXRyaWNzIGNhbiBiZSBvYnNlcnZlZCBieSBydW5uaW5n
IHRoZSBmb2xsb3dpbmcgY29tbWFuZDoNCj4gPiA+ID4gPg0KPiA+ID4gPiA+ICAgICBmZm1wZWcg
LWh3YWNjZWwgdmFwcGkgLXZhcHBpX2RldmljZSAvZGV2L2RyaS9yZW5kZXJEMTI4IC1pIFwNCj4g
PiA+ID4gPiAgICAgfi9zYW1wbGUtMTBzLm1wNCAtdmYgaHd1cGxvYWQsc2NhbGVfdmFwcGk9Zm9y
bWF0PW52MTIgLWM6diBcDQo+ID4gPiA+ID4gICAgIGgyNjRfdmFwcGkgL3RtcC9vdXRwdXQubXA0
DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGlzIGlzIGluY29ycmVjdCBiZWNhdXNlIHRoZSB2YWx1
ZSBpcyBzdXBwb3NlZCB0byBiZSBpbiBbMC0xMDBdIHJhbmdlLg0KPiA+ID4gPiA+DQo+ID4gPiA+
ID4gVGhlIGNhdXNlIG9mIHRoZSBpc3N1ZSBpcyB0aGF0IHRoZSBtZXRyaWNzLlZjbkFjdGl2aXR5
IHJlcG9ydGVkDQo+ID4gPiA+ID4gYnkNCj4gPiA+ID4gPiBzbXVfY21uX2dldF9tZXRyaWNzX3Rh
YmxlKCkgaXMgYSBwZXJteXJpYWQgdmFsdWUgaW5zdGVhZCBvZiBhDQo+ID4gPiA+ID4gcGVyY2Vu
dGFnZSB2YWx1ZSAoZS5nLiBzbXVfdjE0XzBfMF9nZXRfc211X21ldHJpY3NfZGF0YSgpIGhhcyBh
DQo+ID4gPiA+ID4gZGl2aXNpb24gYnkgMTAwIHRvIHJlcG9ydCB0aGUgdmNuX2J1c3lfcGVyY2Vu
dCkuIFRoZXJlZm9yZSBmaXgNCj4gPiA+ID4gPiB0aGlzIGJ5IGFwcGx5aW5nIHRoZSBzYW1lIGRp
dmlzaW9uIGluIHNtdV92MTRfMF8wX2dldF9ncHVfbWV0cmljcygpLg0KPiA+ID4NCj4gPiA+IEkg
dGhpbmsgdGhpcyBpcyBjb3JyZWN0IGFzIGlzLiAgc211X3YxNF8wXzBfZ2V0X3NtdV9tZXRyaWNz
X2RhdGEoKQ0KPiA+ID4gaXMgdXNlZCB0byBmZXRjaCBkYXRhIGZvciBzdGFuZGFyZGl6ZWQgZm9y
bWF0cyBsaWtlIGh3bW9uIHdoaWxlDQo+ID4gPiBzbXVfdjE0XzBfMF9nZXRfZ3B1X21ldHJpY3Mo
KSBpcyBmb3IgZHVtcGluZyB0aGUgcmF3IG1ldHJpY3MgZGF0YS4NCj4gPiA+DQo+ID4NCj4gPiBX
ZWxsLCB0aGVuIGtnZF9wcF9pbnRlcmZhY2UuaCBuZWVkcyBzb21lIGhlbHA/DQo+ID4NCj4gPiBz
dHJ1Y3QgZ3B1X21ldHJpY3NfdjNfMCB7DQo+ID4gICAgICAgICAuLi4NCj4gPiAgICAgICAgIC8q
IFV0aWxpemF0aW9uICovDQo+ID4gICAgICAgICAvKiB0aW1lIGZpbHRlcmVkIEdGWCBidXN5ICUg
WzAtMTAwXSAqLw0KPiA+ICAgICAgICAgdWludDE2X3QgICAgICAgICAgICAgICAgICAgICAgICBh
dmVyYWdlX2dmeF9hY3Rpdml0eTsNCj4gPiAgICAgICAgIC8qIHRpbWUgZmlsdGVyZWQgVkNOIGJ1
c3kgJSBbMC0xMDBdICovDQo+ID4gICAgICAgICB1aW50MTZfdCAgICAgICAgICAgICAgICAgICAg
ICAgIGF2ZXJhZ2VfdmNuX2FjdGl2aXR5Ow0KPiA+ICAgICAgICAgLi4uDQo+ID4gfQ0KPiA+DQo+
ID4gQ2xlYXJseSBpdCdzIG5vdCB0cnVlLg0KPg0KPiBUaGF0IHdhcyBsaWtlbHkgY29weSBhbmQg
cGFzdGVkIGZyb20gdGhlIGZpcm13YXJlIGludGVyZmFjZQ0KPiAoc211MTRfZHJpdmVyX2lmX3Yx
NF8wXzAuaCk6DQo+IHVpbnQxNl90IFZjbkFjdGl2aXR5OyAgICAgICAgICAgICAgICAvL1RpbWUg
ZmlsdGVyZWQgVkNOIGJ1c3kgJSBbMC0xMDBdDQo+DQo+IE90aGVyIGdlbmVyYXRpb25zIHNlZW0g
dG8gZG8gdGhlIHNhbWUgdGhpbmcgKHJhdyBkYXRhIGluIG1ldHJpY3MgdGFibGUNCj4gYW5kICUg
aW4gdGhlIGh3bW9uIHR5cGUgaW50ZXJmYWNlcykuIEUuZy4sIHNtdV92MTNfMF80X3BwdC5jOg0K
PiBzbXVfdjEzXzBfNF9nZXRfZ3B1X21ldHJpY3MoKQ0KPiBncHVfbWV0cmljcy0+YXZlcmFnZV9t
bV9hY3Rpdml0eSA9IG1ldHJpY3MuVXZkQWN0aXZpdHk7IHZzDQo+IHNtdV92MTNfMF80X2dldF9z
bXVfbWV0cmljc19kYXRhKCk6DQo+ICp2YWx1ZSA9IG1ldHJpY3MtPlV2ZEFjdGl2aXR5IC8gMTAw
Ow0KDQpGb3IgU01VIDE0LjAuMCwgdGhlIFZDTiBhY3Rpdml0eSB2YWx1ZSByZXR1cm5lZCBmcm9t
IFBNRlcgcmFuZ2VzIGZyb20gMCB0byAxMDAwMCwgYW5kIHRoZSBkcml2ZXIgc2hhbGwgZGl2aWRl
IHRoaXMgdmFsdWUgYnkgMTAwIGJlZm9yZSByZXBvcnRpbmcgaXQuDQpUaGlzIHNjYWxpbmcgZG9l
cyAqKm5vdCoqIGFwcGx5IHRvIEdGWCBhY3Rpdml0eS4NCg0KQmVzdCBSZWdhcmRzLA0KS2V2aW4N
Cj4NCj4gQWxleA0KPg0KPiA+DQo+ID4gW0NjIGFtZGdwdV90b3BdDQo+ID4NCj4gPiBSZWdhcmRz
LA0KPiA+IEJvcXVuDQo+ID4NCj4gPiA+IEFsZXgNCj4gPiA+DQo+ID4gPiA+ID4NCj4gPiA+ID4g
PiBSZXBvcnRlZC1ieTogTWFyayBKYW5lcyA8bWphbmVzQG5ldGZsaXguY29tPg0KPiA+ID4gPiA+
IFNpZ25lZC1vZmYtYnk6IEJvcXVuIEZlbmcgPGJvcXVuQGtlcm5lbC5vcmc+DQo+ID4gPiA+DQo+
ID4gPiA+IFBpbmc/DQo+ID4gPiA+DQo+ID4gPiA+IFJlZ2FyZHMsDQo+ID4gPiA+IEJvcXVuDQo+
ID4gPiA+DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0v
c3dzbXUvc211MTQvc211X3YxNF8wXzBfcHB0LmMgfCAzICsrLQ0KPiA+ID4gPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPiA+ID4NCj4gPiA+
ID4gPiBkaWZmIC0tZ2l0DQo+ID4gPiA+ID4gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211
L3NtdTE0L3NtdV92MTRfMF8wX3BwdC5jDQo+ID4gPiA+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L3BtL3N3c211L3NtdTE0L3NtdV92MTRfMF8wX3BwdC5jDQo+ID4gPiA+ID4gaW5kZXggNTY4NjY1
MjY1YTEzLi4xMDU4MzM4MzQ0YjAgMTAwNjQ0DQo+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9wbS9zd3NtdS9zbXUxNC9zbXVfdjE0XzBfMF9wcHQuYw0KPiA+ID4gPiA+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTQvc211X3YxNF8wXzBfcHB0LmMNCj4g
PiA+ID4gPiBAQCAtNTY2LDcgKzU2Niw4IEBAIHN0YXRpYyBzc2l6ZV90DQo+IHNtdV92MTRfMF8w
X2dldF9ncHVfbWV0cmljcyhzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwNCj4gPiA+ID4gPiAgICAg
ICBncHVfbWV0cmljcy0+dGVtcGVyYXR1cmVfc2tpbiA9IG1ldHJpY3MuU2tpblRlbXA7DQo+ID4g
PiA+ID4NCj4gPiA+ID4gPiAgICAgICBncHVfbWV0cmljcy0+YXZlcmFnZV9nZnhfYWN0aXZpdHkg
PSBtZXRyaWNzLkdmeEFjdGl2aXR5Ow0KPiA+ID4gPiA+IC0gICAgIGdwdV9tZXRyaWNzLT5hdmVy
YWdlX3Zjbl9hY3Rpdml0eSA9IG1ldHJpY3MuVmNuQWN0aXZpdHk7DQo+ID4gPiA+ID4gKyAgICAg
LyogbWV0cmljcy5WY25BY3Rpdml0eSBpcyBwZXJteXJpYWQsIGNvbnZlcnQgaXQgdG8gcGVyY2Vu
dGFnZS4gKi8NCj4gPiA+ID4gPiArICAgICBncHVfbWV0cmljcy0+YXZlcmFnZV92Y25fYWN0aXZp
dHkgPSBtZXRyaWNzLlZjbkFjdGl2aXR5IC8NCj4gPiA+ID4gPiArIDEwMDsNCj4gPiA+ID4gPiAg
ICAgICBtZW1jcHkoJmdwdV9tZXRyaWNzLT5hdmVyYWdlX2lwdV9hY3Rpdml0eVswXSwNCj4gPiA+
ID4gPiAgICAgICAgICAgICAgICZtZXRyaWNzLklwdUJ1c3lbMF0sDQo+ID4gPiA+ID4gICAgICAg
ICAgICAgICBzaXplb2YodWludDE2X3QpICogOCk7DQo+ID4gPiA+ID4gLS0NCj4gPiA+ID4gPiAy
LjUwLjEgKEFwcGxlIEdpdC0xNTUpDQo+ID4gPiA+ID4NCg==
