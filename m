Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85219606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 07:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=nQm9vchh;
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=wXNHUCkH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85FCE10E129;
	Fri, 27 Nov 2026 07:29:44 +0000 (UTC)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27A6B10E129
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 07:29:33 +0000 (UTC)
X-UUID: 480c6174ea3411f1b9cf3d4034dccee2-20261127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=ki1/13LFmMHNkpGDrcaHZwflqcjttgqECaKacsJsdq0=; 
 b=nQm9vchhz2U//8lXO022BDl1nzFuDrYKZin/wMMhdYtfNU2hR4G4JwAhUBGIZFw5tzS5SXvN7T8JFMOfcZ+1OGNHiYMXdklfzAVkIayhQlNnnlOXpH9NnpRWYKsVYIFxhHU5x3Oo9dftPgvtnoqwHE07y1eiUkfBSxTGduPkCf4=;
X-CID-CACHE: Type:Local,Time:202611271529+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21, REQID:907b1b26-11c6-4f5c-8732-9f940da5ba44, IP:0,
 U
 RL:0,TC:0,Content:3,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:3
X-CID-META: VersionHash:b0318ac, CLOUDID:cbfa6a31-f289-4656-bb36-27baf4489f11,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|136|836|865|888|898,TC
 :-5,Content:4|15|50|99,EDM:-3|-100,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:
 nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
 C:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 480c6174ea3411f1b9cf3d4034dccee2-20261127
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 682805918; Fri, 27 Nov 2026 15:29:29 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 27 Nov 2026 15:29:28 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.56 via Frontend Transport; Fri, 27 Nov 2026 15:29:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jirXt4Lma/oDqv7r8yTIv5U7dzT1hwM/LPJ6ogF1Avc+Rj70eXlkLkrk+35KLvXb3c9LGd2k9ABMsGVEYOxmtRMj671zdYgNAmKi4HaxEXpDV11hg7wVwGeg5Gp77qC90bNp9SUvBqWjUA+0aPydD1bFRpQUUCiZCQrtdwP0ULwDHcmRR+E91g4igiS8Ds4ulg6qnA3wZjKh3xd7UYTwbxR6zHnxZmWuNr2MKPMg6wjnlIkzJkZ4DtetO2KLa7G9NL/v8Crh9aG2mr9+p26KR8E28wz5KKjUOfENhZOMgmrtb/oRcqeKmWVneIw2lLhKvsRp4tIUkzP+DMNGrOoOPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ki1/13LFmMHNkpGDrcaHZwflqcjttgqECaKacsJsdq0=;
 b=WXkSGPqekz8WPxF8oi+msAtSlB78d5krwkr/mPXx2eOrpQrc21wQRVLXypxBiZewQArpj1TvxB6tqA0am0fMyjC84Xj7DpmkPKrkMFyv8P1Ygv/KiJdCHhMsWUY+kKTPFr9gtr4ZCJ2gNePU9LtsI2MjRcTRhOz6469g1e3tGW8CVYB+q7pfKmN3tdLEJd6exHn7zi54+0nn9y5FEmkr1vTokQz/fjnP+rl64OYHghdxKT8Tibsui8IBpOueTbsZPrz5qTiZO1J7FYxE6z7GWF4e+oVBibgLIe5mQKd6RqCNdyTSaC9h8FlMHNQ2A3xQSmmPXjade0Z8jCGdLiCkTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ki1/13LFmMHNkpGDrcaHZwflqcjttgqECaKacsJsdq0=;
 b=wXNHUCkHK74zT8bqXZFgiCkpfR6+UmkeH2Eyvz53YjSVASbIbANYJrNfIjQU7pU8qgZUz/4rvqoOpPDj3WFkHM2ck0w5jhkWJkzl6OQOuEivgsApEwhkQPjyS4QsTKofoU8mv9PQOb137lrWy5YLcPVpY+jIgvtrFTWTb5ueffY=
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com (2603:1096:d10:91::20)
 by TYSPR03MB8833.apcprd03.prod.outlook.com with HTTP via P2P;
 Fri, 27 Nov 2026 07:29:24 +0000
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b]) by KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b%5]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 07:29:24 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
 <chunkuang.hu@kernel.org>, "ryanbrue.dev@gmail.com" <ryanbrue.dev@gmail.com>, 
 "airlied@gmail.com" <airlied@gmail.com>, "matthias.bgg@gmail.com"
 <matthias.bgg@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm/mediatek: ovl: Report coverage blending on older
 SoCs
Thread-Topic: [PATCH v2] drm/mediatek: ovl: Report coverage blending on older
 SoCs
Thread-Index: AQHde6vcQMi3HvGCLk+3ZFV2JX0cV7dBirSA
Date: Fri, 27 Nov 2026 07:29:24 +0000
Message-ID: <be8f55da565839dd1721c02892e476f390ca3579.camel@mediatek.com>
References: <20261123-rbrue-suez-mtk-ovl-coverage-v2-1-4149e2ed5fee@gmail.com>
In-Reply-To: <20261123-rbrue-suez-mtk-ovl-coverage-v2-1-4149e2ed5fee@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
x-ms-traffictypediagnostic: KUYPR03MB9902:EE_|TYSPR03MB8833:EE_
x-ms-publictraffictype: Email
client-request-id: 1c163288-b97d-42a1-8d38-c969dd81863d
request-id: 24e60edc-852d-451c-3dc4-08df4c58293d
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|42112799006|7416014|376014|366016|6133799003|18002099003|22082099003|11063799006|56012099006|10067099003|261026121527099003|261102123227099003|261026140227099003|261022105027099003|261028144727099003|261021121427099003;
x-microsoft-antispam-message-info: K9FKJw5y9+VcVTMu+E1l1rYJvAcZMj/BRBP4WehfIuXgk0ET/pcBb0EBGXx8g4xaNVUxlSvIbzbUt0WB+Ap8lntKp1CN4M/B+WwojO3vBEXsElMLptuLICbVsKKvSre/Cy/dgVlGlSFYMLammbCIZtiTXV5WTKJEc/0zVoPJiCU3rXIGoMgMjXFOAX/hI6nzhqRP3HHu9VT3xqRlNzULonyfFO1cxGs/OjZ8Fu+fwnqXVriJ2zrO9glyQHfBns8JUA/kOmAK8Q6OtiZAVFQ/9YO6PLdvYYiHafVHdiJZloX+CtFv5rtZmMURGp7uNs9qWsurlQ+6bSuNnvJfCVr0RnV74Jc+hsM3PnJMQrPiS12f637gdFHYHS2s3iehubDCRxdh2VVIXKWn0AktAbmLMrzorMAgLDzKzXNOII9Rnq4RDpSJsIsTbEvPBLd4lCt+LC1pd8lfqbqBFgwHspCmuWwxCDpZdJtXZSDcPe8So/U0xBUm5aZYDgR4RqoI/hAKyNG4m0tv7jQHWPHra4hO4hQdZxtrtoXJZCUN1Ee2Y2nlArlccD3iCy3r6QsdG+xKb+vmTs/BmgSL9b+Wdw+edeKHbw2YV3tg5AE/ZjSZwA7q+2WYFgsp7Rf5p1z3ZRHq3BsLxjZwL7I6C0cEvJwXsuvHHZssdudi5xpe0umFluU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(42112799006)(7416014)(376014)(366016)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003)(261026121527099003)(261102123227099003)(261026140227099003)(261022105027099003)(261028144727099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cU1ocUl4OXAzeldxZ0NYY29zVFc4ZnVhZjJIK3VPY0tIVjNwKzcydE9TdEd0?=
 =?utf-8?B?amd5YitFQyt1UnNKamxENlJCUm9YaTBveWpWR0pqS3VhNDdjR3hpUXVEb20y?=
 =?utf-8?B?V3U3OWZzaW16MHY3VHRaYkh6dmd1V1pPTms0VTgwZktLbnJSeXZUa3RZQU1W?=
 =?utf-8?B?MDd4MG8wM2d6RnZ3MlZ0OHJReEVQRWhOdmhsSW5Sa0JlbkVQelBuN05xalN3?=
 =?utf-8?B?UksrUEp6TTFSeDQ0eHFRWlk0bzZndHduWi9Lc3VWRXZFVkRoWDdkS1Y2ZHlM?=
 =?utf-8?B?UFE2M25OdW9GZGxFSWlONDZDUjNhR083ZkNZWHE0Z2hSVElDSVRnM2p5L2lU?=
 =?utf-8?B?aTVJUUhOSG9WeG1BNHBNWkE1b1Z1d2htOElwSGU2VXkyWWp6OE5KWk13RHFQ?=
 =?utf-8?B?cFE2ZzBUVlFyNnVwdFNwcy94bEZPaHhTbnl0dGlGUzNreXQ3SklnMlA3OVhj?=
 =?utf-8?B?TTN4Y05LQmtqN3hmVkJ4S0pMOG43Vm4vQ24yZXpFcUlNWUtOdzFzYnUrMnJt?=
 =?utf-8?B?Z0QvcDNlWVlRNUxIMHRWQkxOTjJsNjJnM0FVOXA3eDh6WHpLWlF6N2IvY0p6?=
 =?utf-8?B?Vi9IU1NhWXRXKzVWYnBsSHhVZkdySHowQ2ZVbFA0KysrajZFZjAvZTFpL2hJ?=
 =?utf-8?B?VmhnUnBVdEUzaDJDVnZGVktFNVBDYnNoWGFFdTdWOFpCWWFCUFRpN0gwdEZJ?=
 =?utf-8?B?VW5BYXljeTlnNU4xYmdLRjA2S0NrM1RIQ0xydUJZRnVOTmdQcEJKUjJPS3lE?=
 =?utf-8?B?TU1mU3pCMWtXZmJZYWxsdXZpNFlrcmQ2TEF3L1ZCR0NROVRqSzhCM3luY2Nm?=
 =?utf-8?B?ci8yaHlrTUVKSEszaU1KS0cxaGgvTW5FQkZDUnBrK1RUcm56Y1Nsc0RVcHVD?=
 =?utf-8?B?cmVDN2VMR0NoVk1KeUp4d21VSFdLUDh3WE1TQUlHT014TlM4YnRzVG1kM3V4?=
 =?utf-8?B?N2dtOTNFampYQkxQTW1BK3VHOUQxZDRBZHp0R2Q4TWJWdXRkTUJGbUMwQmpS?=
 =?utf-8?B?aVhkSDJWV0wwV011RndrTndOSmZTQUVRSFVETjBVMEpRaFZsRjh1TE93RFox?=
 =?utf-8?B?TlVrb0xRdUczRC9hWGJUWjZxK3dPc0dJaW1vck56OWhVSTB4WHFZenEwUlNo?=
 =?utf-8?B?QVhyMnN0aStZVGJyRU1Vc05FNXllYURySE1mSXR6N0FaemFBZTA4WEl0Q1Ry?=
 =?utf-8?B?dW9Iczk5dW5jM3lSZ081SFlUZjQzTlhQUGJ4ZTZoY2R5dW9aSThLa1Nod1ND?=
 =?utf-8?B?TnFIRWtvbWhRYnVuSnk5QStvZ01aOTAwcWtDMFUwTGpMMXJTK3IwN1BHUnlK?=
 =?utf-8?B?bzdlNldsdC9kYVRmdmpvQ2czOTFGY0MrQzBIdWxIWWRac1ZGWWlDenJISER1?=
 =?utf-8?B?WER4dzZJRDdBR1RIL294RkJhSUVIcUFTZnZreTV6ajZWZForUXRVWG1obCsw?=
 =?utf-8?B?bmw1dUtDbnFRemJlVjB2SkdWaTV3VHJDNkZEQ1l0TDNIUi83RmVBb2JXWmNV?=
 =?utf-8?B?NDNqbzVWS3JSazR5TjlYSTN0SCttRmlObzR2TmhBTllUaGh3bEZ5cHlHcG9Z?=
 =?utf-8?B?YXFxK05tYkowSTlBZ0JqT2FrMXEveWYxcktKa1VZUE1kR1AwUU45Zm9oQ0xW?=
 =?utf-8?B?QXQzMW1pMThJR2JndE43T0tkbGdDcUw0MGJoeFhDVDZvNWNWTGhPM3VWNnhJ?=
 =?utf-8?B?ZUZpRUUwSHpFYWUvenBkZG52OUQ3L0Z3WkszNk9iM215NmdKdURXZDdEZmpw?=
 =?utf-8?B?dTVRZ0JDWU5uOFEwWnc1K3JwY1VKakdpR0RqN1A5VmFLbWxZTWhmQU94WWdz?=
 =?utf-8?B?cU9vSnAvaXZrQ1JXdDUyaWdUSnpRbyt4eW5IdHJvUmd3bE1XbkZsWTd5aE1l?=
 =?utf-8?B?bEw1eUw0Q0crY3M2UWJrUmlCQXp3ZzIrbjNMZ1JGRWZ6UHU1NjlmZW8wWk1T?=
 =?utf-8?B?Z2ZaYVYrYmdzRW1KR29tcjNwRkRzdjYvZ1B0UGEyeHhqRkFTSjc1cFZ5R3k0?=
 =?utf-8?B?ZXpWb1VieUh2NDFoZGNzMUtWdTN6ZkQ3RmExaDZKM2xQUG9LNEtWNzhLaDBB?=
 =?utf-8?B?RmhnbElYd3ZCTWlSRWZjZkc2MXBNSnRRcHhtYkgxSm1PU1czS3N6eVNqNlIr?=
 =?utf-8?B?b0JjVk1uY09KQkdyKzJUdHg1TVR3ZG1NenVmMy9YRnBWM1hSa0ZzTzBGeU1F?=
 =?utf-8?B?NFVBaWdNQ2w5ajRlVU9CMmxtTVJKNmVEUlBkcFo5MDU5d0ZoWlZUcHVhSm9w?=
 =?utf-8?B?SkZ2b1BzVzE4SGdMRWh6Zm5VL2MrbWw4VHJ5aUlHKzczOEJDOHRJbXM2Y1JI?=
 =?utf-8?B?cUxpZHZYNXJ6bjc1ejVvSHEyZlZ2RkdZckJtZEZKa3lJUVgrSmJIdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C723D0E68E646458C0BD289C38B3678@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VOvyh6gOIWQ5HqgQ9JYYZFKg68hEb18hNN6zns0avSNsTopEZE4+e4Bss3bnm2Tui1UgdZCClv4PWrQc601bpE0K03BX0Ju/SUVaLJcrrzT9Y56CKXW4Pev2Ji53qe1c1SwAOadzqufZncRyTpxeEvoarkGM+9FmKN77aDBpYN6aA8DgrCwt2NCrZ+HfXliWncOQzDaZmAcpT8VhsNgF+7IqeaeRZhicwnFnh5UAka4Jw0wdmrs0QXwRRXmCNF5uzSoI0Xk0Q+ziJSlYRBXc3KHPswvfVQIPyS9aXzpLOCwiCeRe/h7hhfclBr5FiQ5k8ADfxNzaw35EgyA3XvUyOA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR03MB9902.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e60edc-852d-451c-3dc4-08df4c58293d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2026 07:29:24.2313 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mT27rV6MVimT+QQ3DHBOqCs7WH+3erog3tb/8IZ7cTIkEPfRF/v1zKv/YFBerlfLX/7rcMkjC7ytHKfKtv6FUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8833
X-MTK: N
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gTW9uLCAyMDI2LTExLTIzIGF0IDE4OjM1IC0wNjAwLCBSeWFuIEJydWUgd3JvdGU6DQo+IEV4
dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1l
bnRzIHVudGlsIHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+
IA0KPiANCj4gU2luY2UgY29tbWl0IDg2MGU3NDhiZGRjYyAoImRybTogZW5zdXJlIGJsZW5kIG1v
ZGUgc3VwcG9ydGVkIGlmIHBpeGVsDQo+IGZvcm1hdCB3aXRoIGFscGhhIGV4cG9zZWQiKSwgZXZl
cnkgT1ZMIHBsYW5lIG9uIE1UMjcwMSwgTVQ4MTY3LCBNVDgxNzMNCj4gYW5kIE1UODE4MyB3YXJu
cyBhdCBib290Og0KPiANCj4gICBbZHJtXSBbUExBTkU6Mzc6cGxhbmUtMF0gcGl4ZWwgZm9ybWF0
IHdpdGggYWxwaGEgZXhwb3NlZCBidXQgYmxlbmQNCj4gICBtb2RlIG5vdCBzZXR1cC4gUGxlYXNl
IGZpeC4NCj4gDQo+IFRoZXNlIE9WTHMgZXhwb3NlIEFSR0IgZm9ybWF0cyBidXQgZG9uJ3QgaGF2
ZSBibGVuZF9tb2RlcyBpbiB0aGVpciBkcml2ZXINCj4gZGF0YSwgc28gbm8gInBpeGVsIGJsZW5k
IG1vZGUiIHByb3BlcnR5IGlzIGNyZWF0ZWQuIFRoZXkgY2FuJ3QgYmxlbmQNCj4gcHJlbXVsdGlw
bGllZCBwaXhlbHM6IG10a19vdmxfZm10X2NvbnZlcnQoKSBhbHdheXMgc2VsZWN0cyB0aGUNCj4g
bm9uLXByZW11bHRpcGxpZWQgY29sb3IgZm9ybWF0cyBmb3IgdGhlbSwgd2hpY2ggaXMgdGhlIERS
TSAiQ292ZXJhZ2UiDQo+IGVxdWF0aW9uLiBTaW5jZSBjb21taXQgOTgxM2UxNThkMTNkICgiZHJt
L2RybV9ibGVuZDogYWxsb3cgYmxlbmQgbW9kZQ0KPiBwcm9wZXJ0eSB3aXRob3V0IFBSRU1VTFRJ
IikgYSBjb3ZlcmFnZS1vbmx5IHByb3BlcnR5IGlzIGFsbG93ZWQsIHNvDQo+IGFkdmVydGlzZSBp
dCBhbmQgZHJvcCB0aGUgY29tbWVudCBzYXlpbmcgaXQgY291bGRuJ3QgYmUgY3JlYXRlZC4NCj4g
DQo+IFRoZSBwbGFuZSBzdGF0ZSB0aGVuIGRlZmF1bHRzIHRvIENvdmVyYWdlICgxKSBpbnN0ZWFk
IG9mIFByZS1tdWx0aXBsaWVkDQo+ICgwKSwgYW5kIG10a19vdmxfbGF5ZXJfY29uZmlnKCkgZW5h
YmxlcyBhbHBoYSBibGVuZGluZyBmb3IgYW55IG5vbi16ZXJvDQo+IGJsZW5kIG1vZGUuIE9uIHRo
ZXNlIFNvQ3MgdGhhdCB3b3VsZCBzZXQgT1ZMX0NPTl9BRU4gZm9yIFhSR0IgZm9ybWF0cw0KPiB0
b28sIHdoaWNoIHRoZXkgY2FuJ3QgaWdub3JlIHRoZSBwaXhlbCBhbHBoYSBvZiwgdGhlIGJyZWFr
YWdlIGZpeGVkIGJ5DQo+IGNvbW1pdCA5OTVkNGQ1NThlZWEgKCJkcm0vbWVkaWF0ZWs6IG92bDog
Rml4IFhSR0IgZm9ybWF0IGJyZWFrYWdlIGZvcg0KPiBibGVuZF9tb2RlcyB1bnN1cHBvcnRlZCBT
b0NzIikuIE9ubHkgbG9vayBhdCB0aGUgYmxlbmQgbW9kZSBvbiBTb0NzIHRoYXQNCj4gc3VwcG9y
dCBwcmVtdWx0aXBsaWVkIGJsZW5kaW5nLCBhcyBtdGtfb3ZsX2ZtdF9jb252ZXJ0KCkgZG9lcywg
c28gdGhlc2UNCj4gU29DcyBrZWVwIGVuYWJsaW5nIGFscGhhIGJsZW5kaW5nIGZvciBmb3JtYXRz
IHdpdGggYWxwaGEgb25seS4NCj4gDQo+IFRlc3RlZCBvbiBNVDgxNzMgKEFtYXpvbiBGaXJlIEhE
IDEwIDIwMTcpLiBUaGUgd2FybmluZyBpcyBnb25lLCBldmVyeQ0KPiBwbGFuZSByZXBvcnRzIGEg
InBpeGVsIGJsZW5kIG1vZGUiIG9mIENvdmVyYWdlLCBhbmQgdGhlIE9WTDAgbGF5ZXINCj4gcmVn
aXN0ZXJzIGFyZSB1bmNoYW5nZWQuDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0
ZWsuY29tPg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSeWFuIEJydWUgPHJ5YW5icnVlLmRldkBn
bWFpbC5jb20+DQo+IC0tLQ0K
