Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94450CA5FFC
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 17:40:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62A5C10E5EA;
	Mon,  5 Oct 2026 17:40:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s0GO047c";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013025.outbound.protection.outlook.com
 [40.107.201.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBB1310E00D;
 Mon,  5 Oct 2026 17:40:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RFx7oU3V3S+6d0WgtWmVT2WS/IF3C7hrdva83QTJz+flQj2LzT+AznkMb9eto4SgzJF2oMA2kGJA9IsdHZ4CU3/a2TMxnZXwWxxPi0oH7JVAx0NAbR1Zb0ZofCrET6/y2fNAV6u7WKaggpqBMHsLf8kJdUy0053MFOcGsRlsK20q2l2FUwA7uuhZ3MLtH7f7cweUztFtCwQGzfeg5cGVIK92bkPyjRIq9kA/pEfux5l5XcGqqdyspScaT7dUJyP0vXwWCyCVooXCLhPZeNM9GnhQ3YdVhRadq86vu2a/NOGLS9C90umwtME+RHgpADTaRs7P5QW4HgpxNcpajEqEMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VGztB8rvMo92HLmFj4ntLlWhqf08IsnC7kLIemnlN0=;
 b=W/KcDzZnhZoDQw8XCnt2YNCZI0nVTHLZUacjYdA6FeJxjUgpx0LcjvrBD563mtC8XcPow/994T25I0O5BoN1bd6hycryknsnq2/qhLkNxYfytqtBWmyYcgSxR19G+mgYh4pWgTXsb7tAAzlUsHkkBL134Ijg9A1gywPCcJMxsiVtiU2arDBkOmHLIdso3lyBRdxZ9b21SZ7hU79Z/C8jMqH6bzSs/zA/bC4L6Nm1X2kRwt1s+Qg3BNZNUqA7sZoK+OXTk4wKCfODbJhNmmZYqnLQDT1qBqjcYnFLZiZSJCKxdqTpxLS0u2Y1rs5UDJtglr4XdM+HuzGLzoooweg3uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VGztB8rvMo92HLmFj4ntLlWhqf08IsnC7kLIemnlN0=;
 b=s0GO047cSPcsFr6zKOpXpogTtM3Kdp7VMG7Af12I7PzeJmQ+xVME4qS9Uh9uVPf/xd/9hJCSMEY30mG36sDJavvfkE9xNN6EsNqQy4sX93a1qQyLysWYMpWFFOiIZnj62QZ9Lzqo1112Aiz6olctTu9ajH32T3FsXwQHCzSI8PI=
Received: from DSWPR12MB999127.namprd12.prod.outlook.com (2603:10b6:8:36c::7)
 by SJ2PR12MB9240.namprd12.prod.outlook.com (2603:10b6:a03:563::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 17:40:19 +0000
Received: from DSWPR12MB999127.namprd12.prod.outlook.com
 ([fe80::54e1:5b6e:4c39:d7b2]) by DSWPR12MB999127.namprd12.prod.outlook.com
 ([fe80::54e1:5b6e:4c39:d7b2%5]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 17:40:19 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: Mattia Tadini <info@mtsistemi.it>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, Rodrigo
 Siqueira <siqueira@igalia.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drm/amd/display: only clear the hotplug sources the ASIC
 has
Thread-Topic: [PATCH] drm/amd/display: only clear the hotplug sources the ASIC
 has
Thread-Index: AQHdSZiTpdYEazYqBUKbe3ZRKzwfArbvTXAw
Date: Mon, 5 Oct 2026 17:40:18 +0000
Message-ID: <DSWPR12MB999127F3357DE2C8467181508F89962@DSWPR12MB999127.namprd12.prod.outlook.com>
References: <178984953065.33228.16670066468362794046@mtsistemi.it>
In-Reply-To: <178984953065.33228.16670066468362794046@mtsistemi.it>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-10-05T17:39:12.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DSWPR12MB999127:EE_|SJ2PR12MB9240:EE_
x-ms-office365-filtering-correlation-id: f62651db-2eaf-407e-8b6d-08df2307b95f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|10067099003|11063799006|56012099006|5023799004|38070700021|18002099003|22082099003|921020;
x-microsoft-antispam-message-info: +IthAgGhPrz4VGKSWE+RyZReIWezIdfU6Bos9K3KEmxZk3Db6YpRLodKKfCzGRII4mvFJyFUflHJlcXZ3hgYDWRt69yV+3wK2XXX3jMXhNVeBGrlWAlT7uAQkAW5PLJZOjFgkjDpWOkMAIPry/nrruuh9Fn16W4ha/jI5pNdjPQcFfUSnkhux4UiTZ7gj4t5inrJgK4MzMmaUsNfB5ZlT5IcvA1MKN1W6E+VnURO7kvH7d/vn4/3JdzGo2Sv7PiBx9JuPWywSWXsAwH43epQZT6YP3ez36O/SajNlu2p402zw3WfzX1YH7NLDzWO79ibN0SYSpPfdjz6n4iycnR2j8pcChsbtErvJDV95zk5yygACTv+lsUxIsNlgfhnw9iOMn/7SKM/an8yeZZW4qinbABcgbMftNSBqyF9EsCvRveWG2B2euDKPvUCc8yQoxCOKe2svX2F/E4InUZxt9ldS3c7/zc0V0tlHoNK+cxUDrgZjwbkL0ZljnOvutS9Oh7iqtmF4REGyU1J5bc0wOhmgmEUUbCVeio+3PvROuoceXLo7UF4WCplbcYoTdbd6eC7EqmqcSF+ZoEjbaU+xr21ChGZQYBMoYT7ywIXVe/v50iITIgicfPz9yXjCmDLlgZhoTmaFGtDmV3TdWay3LYnG/QBCVuwTXv0jBe3gn1XgbwgQMj2FhvHZHKklDT2YMtXXzs9qc5u07jr0R3eAHorJcoxvYItxRBoh+ENHmwg2GBL2MtZm9kwhSfXwwggEatZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DSWPR12MB999127.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(11063799006)(56012099006)(5023799004)(38070700021)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VE9wK21MdFp2MHJmTmJ3bnBUWmVLenhMN3F0OXM4Q1M3SXFXby8vNzJISHhj?=
 =?utf-8?B?dXhnUGdSTzZZWHB5S2IveTN3YUR4cG5OdDYvU3JESFpDM3gzVjJKSHE0Y1Iv?=
 =?utf-8?B?bGJ0cW1iUFZ5SlVSWkFyTGpmWjVwVkVKa0h4UjJIVXYxRURoMEtUdHZUemRn?=
 =?utf-8?B?Rk9zTmtFWFY2bGYzYmg5UzVyK2lvMkFiODVGK05IWXZDbTVDb09RMDBscFRu?=
 =?utf-8?B?MXA1dlJWM1dZSCtWcnVadDJtYmpra2RwaGVHM0hSNDJpTDkrc2JIRS8wei9J?=
 =?utf-8?B?V3BzWFRKYjNSUXMvbm1icGJjQzEyTkFIcTlJVGVBUTlyQWF2VUUvR3V6UEhv?=
 =?utf-8?B?RVdUcG96RmthLy9GWXdmY0hjeE1uTlNwNktZamk1Y1RoSEx5ZTlaL2g3UmIv?=
 =?utf-8?B?cmV1ZWl6eWQzMzhqVnA2dk9YekFoanlBUVBXT1ZwZFhON002K1Y3WDFqRGIr?=
 =?utf-8?B?TTB3RDFnYWJjMUl0UWlROFlidUt0Y1pBZnR5S3dBaFpZVTBaMmtkbjcwMktF?=
 =?utf-8?B?bFF2b1ZRWDAxUGx0b2pPTEhReXRGa0JacTBETlZ2WVZxVUJrZG9IT1FmK1dY?=
 =?utf-8?B?OURiQ1pjUGRNeHhpbXBZUW5BZ1QzZEJlK1QvVXZ5WGZkRXdvZWg5T0VOQXlu?=
 =?utf-8?B?enRRN1RGYVJKZS9aR0lQVm94TTdmR3dxd0lRcDk4dWM1MCtKN0srZS9oMm8r?=
 =?utf-8?B?SG5UUnRpbVB1R3Z2d0lCeStJOXhpc1dSNGtpVktRN1lJbmkwb2pidnp5KytY?=
 =?utf-8?B?WFV1eFpaaGYzV1JCQ1p6Mk0xQmljcHpRZDFGSVkreEh0ck91NStsSy9GbXha?=
 =?utf-8?B?RHdmaTNyelp2anNZaEpHYXlFSFFYelVrT1JwaUZKeWtOTnFJVFJ5S2NOVU8x?=
 =?utf-8?B?YXNlMGhHOCtnK0c0VGFqaHZjSW1RSmdxNjg5OFd5TXBtRWQveThHQ1JYUXdK?=
 =?utf-8?B?MkN1KzNiSWdKb0JDUzROQ3pQNk5RdU02YWd0QUVJWDZ2R0pYSE9XZDhVcmFj?=
 =?utf-8?B?UTBBN0lHalhYejFXaklKcXNlL3VxZTJLN0FyZk92LzRMV2NPNndoei9HVDhV?=
 =?utf-8?B?akZrbTlZSVJubEZSZTBFWURTdjNUbnFQRjcza2M0M0pqUXNDTTRwcVBuU3k0?=
 =?utf-8?B?a01DUVBLaEFzVVFpaC91NG5OdURLU01NOU10WU9RbWJ2YncwZTBZWnc0Ylhv?=
 =?utf-8?B?M2REaWQvdGFLOFE0YVcwb0p6SzVHZnJoaEFFd1pCWjA3Z2ZSOHZvUlJsaURs?=
 =?utf-8?B?djJjWVFta25Idm9RbnVlbGFoL1c0aXZsQnpwQTM4bE4rdXNmakhFOW40TURU?=
 =?utf-8?B?Mnp2bzRBdkI1bmhJRnAxL2p0NTV5NlJCMXNOZU9OcmpGWU9xZ05nUk9VV25F?=
 =?utf-8?B?UDFHa3FHcDdSYzdBTURNWitXVHlUWlM2anJjY2h1V1BZbnR1ZGNNcjJXclpy?=
 =?utf-8?B?b2Y1Q2c0OUh5TGJacnZKZVFIZUxacFRCMnhrZVkwMGw4Z2J6QW95S1A2MWQw?=
 =?utf-8?B?L1hQN0czbnE3MnplRkdHZ0RyTFhQb2tLZFpGVmZTSEVLWVB6QiticnoydS9w?=
 =?utf-8?B?SnE5dnFsZkpGU21KQXUwckJqM3RZSDB3UzZCQ2d4bm1rRUM1RytVSURuckhi?=
 =?utf-8?B?eTJNUGhhODMxM24vSStEVVRQenNRZ2JYUkRPVkt1eGRDL2paTjNxTURISW9Z?=
 =?utf-8?B?QzNjbFN5cndubDQ4OGV6L1gzY0JtRForVkhmYlh6RlhLc3FZK3BFODZTSmQy?=
 =?utf-8?B?RzlGeUV2OEo5NkxuZlBWUm5kUm1BdVdWNnhVZTUrMUhqSHJ2MFpwaEQ3VVd3?=
 =?utf-8?B?U3JWUUxsTUNjZHl6eHlCNS9MTDdNY28vNjZJd0Z4K05IT0xKdTBzbFd2ZDhU?=
 =?utf-8?B?ck1GV2hkcFFSRHBmWDR5QVExRUZhcjZTWUl3TVRvKzR2ZXZ2Q3hjb1dXaUcv?=
 =?utf-8?B?YVFFYmZLTmdTQXZNeWYwdGNzWDJ0SWdnVHczbVk5WXZUZWw4MWM3K2RPaDRk?=
 =?utf-8?B?ZmxSNDNLV2k3ODdyZ1FZaUZUNUdSWG4vL0k1NVlEeVdmM1RYRzZTNFRxMHpw?=
 =?utf-8?B?QzZvcVRUSDBucHV4aXZQekdwbHJXWUlrVE84VHIwUjh5ZUhIQVBLN1YzVmlO?=
 =?utf-8?B?K1ZzZ3JQbzhwVG40S01UUHdqVk5XYUNjV0dmbzZLVEpycFVLa0dJcjFna0pp?=
 =?utf-8?B?a3FUYzdlMEY4MmVEMEZDdnRlRGU5SWEyQ3crMFQ3VG5GemZ2UVZJSkVrY1Bk?=
 =?utf-8?B?Zmw0bjNvdlFyZ0JBUVhENWx1eDlXUkdDVWJhQ1BlWDN3Nk83ZDZadXpqSnpV?=
 =?utf-8?Q?ag4g4Qvi4lm2MMzLBL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DSWPR12MB999127.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f62651db-2eaf-407e-8b6d-08df2307b95f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 17:40:19.0475 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eVhPkOqXJ+tjKrZJtZyr+njFTCJ6kIeRNuJZYIbGW8c/k8YBGhdAbqeinpbUuMwF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9240
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

UHVibGljDQoNClJldmlld2VkLWJ5OiBSb21hbiBMaSA8cm9tYW4ubGlAYW1kLmNvbT4NCg0KPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5j
ZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgTWF0dGlhDQo+IFRhZGluaQ0K
PiBTZW50OiBTYXR1cmRheSwgU2VwdGVtYmVyIDE5LCAyMDI2IDQ6MjYgUE0NCj4gVG86IFdlbnRs
YW5kLCBIYXJyeSA8SGFycnkuV2VudGxhbmRAYW1kLmNvbT47IExpLCBTdW4gcGVuZyAoTGVvKQ0K
PiA8U3VucGVuZy5MaUBhbWQuY29tPjsgUm9kcmlnbyBTaXF1ZWlyYSA8c2lxdWVpcmFAaWdhbGlh
LmNvbT47IERldWNoZXIsDQo+IEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47
IEtvZW5pZywgQ2hyaXN0aWFuDQo+IDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBEYXZpZCBB
aXJsaWUgPGFpcmxpZWRAZ21haWwuY29tPjsgU2ltb25hIFZldHRlcg0KPiA8c2ltb25hQGZmd2xs
LmNoPg0KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IGRyaS1kZXZlbEBsaXN0
cy5mcmVlZGVza3RvcC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1
YmplY3Q6IFtQQVRDSF0gZHJtL2FtZC9kaXNwbGF5OiBvbmx5IGNsZWFyIHRoZSBob3RwbHVnIHNv
dXJjZXMgdGhlIEFTSUMgaGFzDQo+DQo+IFtTb21lIHBlb3BsZSB3aG8gcmVjZWl2ZWQgdGhpcyBt
ZXNzYWdlIGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tDQo+IGluZm9AbXRzaXN0ZW1pLml0LiBM
ZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQNCj4gaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91
dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4NCj4gYW1kZ3B1X2RtX2hwZF9pbml0KCkgY2xlYXJz
IGV2ZXJ5IGhvdHBsdWcgc291cmNlIGluIHRoZSBlbnVtIGJlZm9yZSBlbmFibGluZyB0aGUNCj4g
b25lcyBpdCBuZWVkczoNCj4NCj4gICAgICAgICBmb3IgKGkgPSBEQ19JUlFfU09VUkNFX0hQRDE7
IGkgPD0gRENfSVJRX1NPVVJDRV9IUEQ2Ulg7IGkrKykNCj4NCj4gREMgZmlsbHMgdGhlIHVudXNl
ZCBzbG90cyBvZiBpdHMgaW50ZXJydXB0IHRhYmxlIHdpdGggZHVtbXkgaGFuZGxlcnMgdGhhdCBh
c3NlcnQgd2hlbg0KPiB0b3VjaGVkLCBzbyBvbiBhbiBBU0lDIHdpdGggZmV3ZXIgdGhhbiBzaXgg
SFBEIGxpbmVzIHRoYXQgc3dlZXAgd2FybnMgYW5kIHRhaW50cw0KPiB0aGUga2VybmVsLiBEQ04g
Mi4wLjEgaGFzIHR3bzoNCj4gbW1IUEQwX0RDX0hQRF9JTlRfQ09OVFJPTCBhbmQgbW1IUEQxX0RD
X0hQRF9JTlRfQ09OVFJPTA0KPiBhcmUgdGhlIG9ubHkgaG90cGx1ZyByZWdpc3RlcnMgaW4gZGNu
XzJfMF8xX29mZnNldC5oLCBhZ2FpbnN0IGZpdmUgaW4NCj4gZGNuXzJfMV8wX29mZnNldC5oLCBh
bmQgaXJxX3NlcnZpY2VfZGNuMjAxLmMgZGVmaW5lcyBocGRfaW50X2VudHJ5KDApIGFuZCAoMSkN
Cj4gYWNjb3JkaW5nbHkuDQo+DQo+IE9uIGFuIEFNRCBCQy0yNTAsIHdoaWNoIGFwcGVhcnMgdG8g
YmUgdGhlIG9ubHkgR1BVIHVzaW5nIERDTiAyMDEsIGV2ZXJ5IGJvb3QNCj4gcHJvZHVjZXMgdGhp
cyBmb3Igc291cmNlcyAzIHRvIDY6DQo+DQo+ICAgW2RybV0gKkVSUk9SKiBkYWxfaXJxX3NlcnZp
Y2VfZHVtbXlfYWNrOiBjYWxsZWQgZm9yDQo+ICAgICAgIG5vbi1pbXBsZW1lbnRlZCBpcnEgc291
cmNlLCBzcmNfaWQ9MCwgZXh0X2lkPTANCj4gICBbZHJtXSBkYWxfaXJxX3NlcnZpY2Vfc2V0OiBz
cmM6IDMsIHN0OiAwDQo+ICAgV0FSTklORzogLi4uL2Rpc3BsYXkvZGMvaXJxL2lycV9zZXJ2aWNl
LmM6MTI5DQo+ICAgICAgIGF0IGRhbF9pcnFfc2VydmljZV9zZXQuY29sZCsweDJkLzB4NzYgW2Ft
ZGdwdV0NCj4gICAgZGFsX2lycV9zZXJ2aWNlX3NldCsweDRjLzB4MTAwIFthbWRncHVdDQo+ICAg
IGFtZGdwdV9kbV9ocGRfaW5pdC5jb2xkKzB4MTUvMHgxMmUgW2FtZGdwdV0NCj4gICAgZG1faHdf
aW5pdCsweDRjLzB4MTcwIFthbWRncHVdDQo+ICAgIGFtZGdwdV9kZXZpY2VfaW5pdC5jb2xkKzB4
MTcyNy8weDFlYzAgW2FtZGdwdV0NCj4NCj4gYW5kIHRoZSBtYWNoaW5lIGNvbWVzIHVwIHRhaW50
ZWQgVywgd2hpY2ggbWFrZXMgZXZlcnkgdW5yZWxhdGVkIGJ1ZyByZXBvcnQgZnJvbQ0KPiBpdCBo
YXJkZXIgdG8gcmVhZC4NCj4NCj4gV2FsayB0aGUgbGlua3MgdGhpcyBBU0lDIGhhcyBpbnN0ZWFk
IG9mIHRoZSB3aG9sZSBlbnVtLCBhbmQgc2tpcCBhIGxpbmsgd2l0aCBubw0KPiBob3RwbHVnIGxp
bmUgb2YgaXRzIG93biwgd2hpY2ggaXMgdGhlIHNhbWUgZ3VhcmQgdGhlIGVuYWJsZSBsb29wIGZ1
cnRoZXIgZG93bg0KPiBhbHJlYWR5IGFwcGxpZXMuIEEgc291cmNlIG93bmVkIGJ5IGEgcmVhbCBs
aW5rIGlzIGltcGxlbWVudGVkIGJ5IGRlZmluaXRpb24sIHNvIHRoZQ0KPiBkdW1teSBoYW5kbGVy
cyBhcmUgbm8gbG9uZ2VyIHJlYWNoZWQuDQo+IFBhcnRzIHdpdGggc2l4IEhQRCBsaW5lcyBhcmUg
dW5hZmZlY3RlZC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogTWF0dGlhIFRhZGluaSA8aW5mb0BtdHNp
c3RlbWkuaXQ+DQo+IC0tLQ0KPg0KPiBUZXN0ZWQgb24gYW4gQVNSb2NrIEFNRCBCQy0yNTAgKEN5
YW4gU2tpbGxmaXNoLCBEQ04gMi4wLjEsIHR3byBIUEQgbGluZXMpLA0KPiBrZXJuZWwgNy4yLjYs
IGFjcm9zcyByZWJvb3RzIGJlZm9yZSBhbmQgYWZ0ZXIgdGhlIGNoYW5nZToNCj4NCj4gICBiZWZv
cmU6ICAyIFdBUk4gc3BsYXRzIGFuZCA4IGVycm9yIGxpbmVzIHBlciBib290LCBmb3Igc291cmNl
cyAzIHRvIDYNCj4gICAgICAgICAgICAvcHJvYy9zeXMva2VybmVsL3RhaW50ZWQgPSAxMjg2NA0K
PiAgIGFmdGVyOiAgIG5vIGR1bW15X2Fjaywgbm8gaXJxX3NlcnZpY2Ugd2FybmluZywgbm8gY2Fs
bCB0cmFjZSBhdCBhbGwNCj4gICAgICAgICAgICAvcHJvYy9zeXMva2VybmVsL3RhaW50ZWQgPSAx
MjM1Mg0KPg0KPiBUaGUgNTEyIHRoYXQgZ29lcyBhd2F5IGlzIHRoZSBXIGJpdC4gV2hhdCBpcyBs
ZWZ0IGNvbWVzIGZyb20gYW4gdW5yZWxhdGVkIG91dC1vZi0NCj4gdHJlZSBtb2R1bGUgb24gdGhh
dCBtYWNoaW5lLg0KPg0KPiBOb3RoaW5nIHJlZ3Jlc3NlZDogYm90aCBEaXNwbGF5UG9ydCBjb25u
ZWN0b3JzIHN0aWxsIHJlcG9ydCB0aGUgcmlnaHQgc3RhdHVzLCB0aGUNCj4gZHJpdmVyIGxvZ3Mg
bm8gSFBEIGZhaWx1cmUsIGFuZCBhbWRncHUga2VlcHMgc2VydmljaW5nIGludGVycnVwdHMgbm9y
bWFsbHkuDQo+DQo+IEkgZG8gbm90IGhhdmUgYW4gQVNJQyB3aXRoIHNpeCBIUEQgbGluZXMgdG8g
dGVzdCB0aGUgdW5jaGFuZ2VkIHBhdGggb24uDQo+ICAuLi4vZHJtL2FtZC9kaXNwbGF5L2FtZGdw
dV9kbS9hbWRncHVfZG1faXJxLmMgfCAyMiArKysrKysrKysrKysrKy0tLS0tDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX2lycS5j
DQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1faXJx
LmMNCj4gaW5kZXggZTQ5ODAzYS4uYjBlZGU1ZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1faXJxLmMNCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1faXJxLmMNCj4gQEAgLTkw
MywxMSArOTAzLDIzIEBAIHZvaWQgYW1kZ3B1X2RtX2hwZF9pbml0KHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2KQ0KPiAgICAgICAgIGludCBpOw0KPiAgICAgICAgIGJvb2wgdXNlX3BvbGxpbmcg
PSBmYWxzZTsNCj4NCj4gLSAgICAgICAvKiBGaXJzdCwgY2xlYXIgYWxsIGhwZCBhbmQgaHBkcngg
aW50ZXJydXB0cyAqLw0KPiAtICAgICAgIGZvciAoaSA9IERDX0lSUV9TT1VSQ0VfSFBEMTsgaSA8
PSBEQ19JUlFfU09VUkNFX0hQRDZSWDsgaSsrKSB7DQo+IC0gICAgICAgICAgICAgICBpZiAoIWRj
X2ludGVycnVwdF9zZXQoYWRldi0+ZG0uZGMsIGksIGZhbHNlKSkNCj4gLSAgICAgICAgICAgICAg
ICAgICAgICAgZHJtX2VycihkZXYsICJGYWlsZWQgdG8gY2xlYXIgaHBkKHJ4KSBzb3VyY2U9JWQg
b24gaW5pdFxuIiwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpKTsNCj4gKyAg
ICAgICAvKg0KPiArICAgICAgICAqIEZpcnN0LCBjbGVhciBhbGwgaHBkIGFuZCBocGRyeCBpbnRl
cnJ1cHRzLCBvdmVyIHRoZSBsaW5rcyB0aGlzIEFTSUMNCj4gKyAgICAgICAgKiBoYXMgcmF0aGVy
IHRoYW4gb3ZlciB0aGUgd2hvbGUgZW51bTogdGhlIHVudXNlZCBzbG90cyBvZiB0aGUgREMNCj4g
KyAgICAgICAgKiBpbnRlcnJ1cHQgdGFibGUgaG9sZCBkdW1teSBoYW5kbGVycyB0aGF0IGFzc2Vy
dCB3aGVuIHRvdWNoZWQuDQo+ICsgICAgICAgICovDQo+ICsgICAgICAgZm9yIChpID0gMDsgaSA8
IGFkZXYtPmRtLmRjLT5saW5rX2NvdW50OyBpKyspIHsNCj4gKyAgICAgICAgICAgICAgIGNvbnN0
IHN0cnVjdCBkY19saW5rICpsaW5rID0gYWRldi0+ZG0uZGMtPmxpbmtzW2ldOw0KPiArDQo+ICsg
ICAgICAgICAgICAgICBpZiAobGluay0+aXJxX3NvdXJjZV9ocGQgIT0gRENfSVJRX1NPVVJDRV9J
TlZBTElEICYmDQo+ICsgICAgICAgICAgICAgICAgICAgIWRjX2ludGVycnVwdF9zZXQoYWRldi0+
ZG0uZGMsIGxpbmstPmlycV9zb3VyY2VfaHBkLCBmYWxzZSkpDQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgIGRybV9lcnIoZGV2LCAiRmFpbGVkIHRvIGNsZWFyIGhwZCBzb3VyY2U9JWQgb24gaW5p
dFxuIiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsaW5rLT5pcnFfc291cmNl
X2hwZCk7DQo+ICsNCj4gKyAgICAgICAgICAgICAgIGlmIChsaW5rLT5pcnFfc291cmNlX2hwZF9y
eCAhPSBEQ19JUlFfU09VUkNFX0lOVkFMSUQgJiYNCj4gKyAgICAgICAgICAgICAgICAgICAhZGNf
aW50ZXJydXB0X3NldChhZGV2LT5kbS5kYywgbGluay0+aXJxX3NvdXJjZV9ocGRfcngsIGZhbHNl
KSkNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgZHJtX2VycihkZXYsICJGYWlsZWQgdG8gY2xl
YXIgaHBkcnggc291cmNlPSVkIG9uIGluaXRcbiIsDQo+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgbGluay0+aXJxX3NvdXJjZV9ocGRfcngpOw0KPiAgICAgICAgIH0NCj4NCj4gICAg
ICAgICBkcm1fY29ubmVjdG9yX2xpc3RfaXRlcl9iZWdpbihkZXYsICZpdGVyKTsNCj4gLS0NCj4g
Mi41NS4wDQoNCg==
