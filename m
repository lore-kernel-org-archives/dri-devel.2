Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB7C606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=KABycfFq;
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=hjJL+eIx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7681A10EE3D;
	Wed, 11 Nov 2026 09:57:02 +0000 (UTC)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CB0C10EE3D
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 09:56:51 +0000 (UTC)
X-UUID: 33c07c9eddb611f1b1788b6acf885367-20261111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=CMFR19XcgMapQIXbGCnba7KoJC9yO3fE4UdAzigvJ3o=; 
 b=KABycfFqhPIal635fYzIv3GYsFpC4xHxaEpnfskZBXmqL5SNQeBezU7TRdrUwo2J+wbXLx3k4XK+HvKo1+mpsxrvUqiBHwEz7IhQv5uKRVvQ6RVd7+snHr3PZwMS9Sj3LSl8IWTHbJQ2wiTYz37w58eO7GC7GcT9WjWKbfv2Ycc=;
X-CID-CACHE: Type:Local,Time:202611111756+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21, REQID:e8bc72eb-7efa-4f5f-8532-d1680274434c, IP:0,
 U
 RL:0,TC:0,Content:6,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:6
X-CID-META: VersionHash:b0318ac, CLOUDID:7b27998d-b3e7-4795-ae33-b1b4d51e21d7,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:4|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:n
 il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 33c07c9eddb611f1b1788b6acf885367-20261111
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1026505592; Wed, 11 Nov 2026 17:56:44 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 11 Nov 2026 17:56:43 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 11 Nov 2026 17:56:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kqm6NVZyo4yqQaH3UBkDLq4uk9JrY43Jd79nK7fOXF1mih+ms8H+wukTFA4HMiwggPjO1yt3M/LxCv3M/syZ9zAuLcjsPfDmHBr8bgkcL/yiBm5fZS28IAGyF2zcBd1CXoLjRrShkV1svUdca3R+1ctBdWVyFznopNlMgfaMhyZET/C8cko7SaNZTlWcuGIA1VSRZNCIL2kT/NvqTOGfNZ7XhnXFm5p/SWPl7bKstic0jou+DCFMlzLv2Q4ANThCURPBuRipDKAzf6YHONI77l7emMSChIJakg5dUENiZPa/Xzji0LlCnQ2ifbSbIhd0wuRcEW9F918qvQcb0QK+wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMFR19XcgMapQIXbGCnba7KoJC9yO3fE4UdAzigvJ3o=;
 b=gT5GxQtS91RRV2DhhBklPPMMaG+C+PJlZWbb3J40Nr03eqM0wSwuExAS9wLUpMnE4CNsZaVY0i5+RSANiac2r5+YJT6mbRe1z1UMjyeIeQd1+f+S2CR8PSHVsQRAKaYdr/aPe9DyPw0sU+LGECR1JXzydsCukUYxj6f6bfa0VUWjkx9c5Nwxz/Eqiv4uVU6TKo7uI+99eUsa7q4eTARqk1qujJuuhCUEwmCWi8RSJtBD7iAOsw+x4M2VMJyW+CNcAt5k4T1y+sQuSyRJPTwSPRFM97MUH+H8uGpJnTguMWyewITuRx3wodMmdXejkCd1opvYXNn1K2UnJwYS4njGpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMFR19XcgMapQIXbGCnba7KoJC9yO3fE4UdAzigvJ3o=;
 b=hjJL+eIxUv9rR/aMwlWETmgk04d1haG+8Lcj5hlU9Mre05K9srLHHevwfG0av3gbK34u9JrvF0WE78HBpMzxhpDzv8zVqVELAbubbYE4AVwcBL6FfzIqT9SI6A5aj/TS3ZUAn+vr6kPQbPQexPwF3lbrr5Bdds8U6jEM9UJsSCM=
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com (2603:1096:d10:91::20)
 by TYSPR03MB7764.apcprd03.prod.outlook.com (2603:1096:400:432::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 09:56:40 +0000
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b]) by KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 09:56:39 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "fshao@chromium.org" <fshao@chromium.org>, "chunkuang.hu@kernel.org"
 <chunkuang.hu@kernel.org>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>
CC: "simona@ffwll.ch" <simona@ffwll.ch>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "airlied@gmail.com" <airlied@gmail.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "p.zabel@pengutronix.de"
 <p.zabel@pengutronix.de>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2] drm/mediatek: Validate gamma_lut size
Thread-Topic: [PATCH v2] drm/mediatek: Validate gamma_lut size
Thread-Index: AQHdbds9CGLxlkpHmk+c2ersGcjh0Lcoqi2A
Date: Wed, 11 Nov 2026 09:56:39 +0000
Message-ID: <3ef84cb09ef956c59a45af256be68d637063b590.camel@mediatek.com>
References: <20261106103932.1219696-1-fshao@chromium.org>
In-Reply-To: <20261106103932.1219696-1-fshao@chromium.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR03MB9902:EE_|TYSPR03MB7764:EE_
x-ms-office365-filtering-correlation-id: ef934c0d-cd3a-48b7-1d4a-08df3fda1504
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|1800799024|366016|42112799006|10067099003|261026121527099003|56012099006|38070700021|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: Z/nddAskGeGKxFdrczMOe8cUAxJfMw2axmVJQWtwtIckCznHPzbio/rtUaddERV7qESK1cNw2SDdTMedzwWUznBT5IMpKn3/htQJENfF448SOsCZqFBQI3C6QMQomh7fIB4iM6Evl/jhNyTy8Faq+G+MzW1GA7Ypdfm2IsQyHZNLor0dZVRkYp74qfGjVD77j0vcHSOvwdNh+Nqzipzlzh6aGLOR90OmuLriawhVakA69Gc1wkt87L8a7Lhu0Ro3JUSqrRz4cHad31ueEYN2i58fk8B9Y6oFYKnwVAfddp4afEy9bSBOj4YVB61Rc5jNfJcFEFjSsSFNmEQHQi/aukQADpnEm5Tw0Q40woWh2CHDC0ELXDK9wLXrGRUBfUJ+meveKZlvwqtxLiHeJTU/ZRqvnqfVBywUhxdAKebRA6RwKRq/rqeu0kHLDbvdDlIxDxaGZjUuWCWaFQxFZdrEFX/0Iag2BQ1a6+aWdQVIcRZHN8rmnguie+4MZjeJctdycw5d2jYEQRqE9MBHnQNQHMCbSHIwAppZjxfmi1iqj+Ypp7GOrFPYFcv55N8JIME4KhOXZYElTCNzLeqguW/goWG/ONP2/wBu63YsfBjgtch+SmZjMx69YrjiTJz1bg58PQcKuxXqeYpmiWaIIO5vdct5SC5R+RpV03z9exnkW6FfU4mwegJH+jkOViwiY8mnCmQqXJGDUYqTaPARr7p91g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUYPR03MB9902.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(42112799006)(10067099003)(261026121527099003)(56012099006)(38070700021)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3MrNnBudmM4NUY3OFV2dnR2Y3VIV09mQTNXamI5MTJqTWJMNU1jTHUzUEdw?=
 =?utf-8?B?T3hXNEZwZzBQQnhXSHl3a3VZREFnTWZUYnd5WWljKytaTFhaVGNqTnFQdmtK?=
 =?utf-8?B?eHlvRVN4azhIUEN4UkJoNWMvNWpYMmFSY0xFMCtYVk5JV09RZGhTM1ZNL29i?=
 =?utf-8?B?c0UrK21nK1RiSHd6QWppUTJlanVWU2tKK015b3gzdjh3bW5wM1ZobzBxb0ZS?=
 =?utf-8?B?elFFN3JoSUJqcHNuNUQ0OXdRNytiWWZUQWdrYk1JblNWSmF2MU9wdmpYbjE4?=
 =?utf-8?B?bXF4NnNMUkRxZlVpMEM3d0p0WnpVWnVKY0pWYytWQUVtUVQ1cVQzcEc0aWE4?=
 =?utf-8?B?eCs4NE9yQ0JjMjR0bDdnbnpnRmdyT25iYk9YZWEwVTZPMlFxK2hoU290RExh?=
 =?utf-8?B?VFhhUFVmb1NTa2h0M3lnT3M2aU1LbjJhYzcycWcrdDdhNm9Vd2xSR1NtV0Zs?=
 =?utf-8?B?YzZjdWJSb2FDMCtSWEFoRmtKL2l5R1FRMFo0SUNjZDBZSWcrVm1YaVdZTnJo?=
 =?utf-8?B?c0NzdkFOdkV4SnBhMkZMK2hWUGpvNkZxa1h5U1NwbVQ1dHd5WTNONS9PWlVO?=
 =?utf-8?B?VVVTV0xFUW8rMG9YUFZOYmx6WXE4WWpEYzVsQjVUY3kyVW9jTTNyRVdnUXZa?=
 =?utf-8?B?OTBWWHJLZjZTUHdkKzc5ZE83a2lENExkdmxyK3VSTGlTanFpTnlNYkNyTG44?=
 =?utf-8?B?cEJtRXAzVklQQW9vbTQza0FHLzdkd1A4L0N1TlhzdG5iV0FNSHE5ZUZBb1J4?=
 =?utf-8?B?TEZIKzd3NUhxVGxRYUVFUGhsSGxXczc4dEJ1ZjFFVTVKaSsrZWNFWm9uVUJs?=
 =?utf-8?B?QWw2cjNxcUxwcE5KVTFaazVtbVhNN0w4L3ZXTkhEWDJsTnp2RjNnNGtNTkVQ?=
 =?utf-8?B?T1J4RXNBSUxZUXlKSFl0eGNMNGJhQVUxblVTejRkdXFMNHBRY0x4ZGJuNDJw?=
 =?utf-8?B?R3dUbWtJSjNUY0JSajRCZ09sYW85NUNFNWtNVTBiQXpCcHcyc2ZPS0NZR01I?=
 =?utf-8?B?OE9PbDhxVGxJYjFQamRubC91SHdvSWdDNzhncHlJalJGNE1ZcXR1RlExSTZl?=
 =?utf-8?B?SnVGUXU3TVZadXYyUzRicG5QblRZT0gwVkpCbVpDdGY4cGoyM0JPR2NVOFFj?=
 =?utf-8?B?VjV3NEFFLy9FSzZjR3hidjVrcldUVFBQU2lHb1h4d0IzcEFjUWdDZ1NrUDJF?=
 =?utf-8?B?NW16YWlqUjVsOGdOZHJYVkZTbUhFSnp0U1B6V1RORHBXamQ3WVV5ZWI3cFhz?=
 =?utf-8?B?Y2RQdHFZSXI3VzBmRWJ4c3VmMDdrbGpadkNYREE2ZWkvTWRINysvditwTUVB?=
 =?utf-8?B?NGdVMkdYb0t2Mml5cFpHb3oyWThxRjRNeXdFMFFMZ3BVNjlLOWpzQW4yRE14?=
 =?utf-8?B?T1g4UUt2Lyt2bS9jWFJpc1pFT3BRelZkbXdpSXFwQnlrZi9ydjRTWGxWNm1P?=
 =?utf-8?B?SVVkZXl1T2xZTzkvTDlRMUk1QTdBY0ZnNkRVdUo1NElDR2IyRnI3VVJHUGFv?=
 =?utf-8?B?ZzlvdzN1TlZRUGJiZmlnb1NuUjlmeFM4QXozT0VQSlF0Zmg5bWVUcy9xZ3ZP?=
 =?utf-8?B?eTVqdkp3QUdLdVBraVB2WXYrK3RGVko2RDBYb0Zka3ozam5mbVZ6TUQ2S3Iy?=
 =?utf-8?B?UmNMcGtoZTR6cHNXaysrcjRXQWZTR01rTlRvcVMvYkZobjFYSi83S3dVN3k5?=
 =?utf-8?B?R1l6QzlNSk91cFNuRzk1SmlNYmNIRDRqMmFaQ1Evd01OenBzYllwSUFMNWZ6?=
 =?utf-8?B?L0h3Vnp1TUNsQlhJWE00d0xCdXVmSjZ5NzJTcWJwN0x1RDY4cVJsZ1A4RWhi?=
 =?utf-8?B?MG1nUGFEWXBIUXZ5RXJJNW5OSDBJcXpSWUxSOEVkek5kdi9EV1psV0NyK3JD?=
 =?utf-8?B?dmliZXJ1NElEaStqaFBsUXdaWTJvb0RnYjUrY2xLZVRuY2k1bHQrbnJrK05I?=
 =?utf-8?B?cjA1MEF2aXBJOXlyU1d4UjZaZjU0MzlVKzNhcUttREk4ZEV0aUpqNGRIbTRo?=
 =?utf-8?B?RkNlMUtTRStHSXFJWG1venNYTzlLeWRibCtKOHNLMDlkcFRlZFVqa0NydnhW?=
 =?utf-8?B?ZDM0SW5YTnRrVU5iSTFCa3orK2QrV3ROYVdvSlpDUlRBcitDSysxWnEyKzA4?=
 =?utf-8?B?NEFrR0xUZEVSa3dDQVhiUHFieEFOMWxGV1dkMWliTUM0OFpkdmNlTFNWdWtq?=
 =?utf-8?B?eTE5dGNISWFoSHhadHlkYytBMDhCeVQ2SWQ0aFJYZzVtVDNwRFBVT2R1YnZT?=
 =?utf-8?B?SklzbUpuL1NReEdwVDF1YkF1eUdRUWVjUGxMSVU5cGdVVWh4eDVkU29pbGJT?=
 =?utf-8?B?L1ZKRXdhOHc4emJUdW80dy8vUm1TUjVqd0JuL2tEVXZkcjdhdlJYUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <35D415F9A1F4204F902081B5D4652DE9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 5a4uWqKyWZOGk/77diOR1vXwVtFQhYIRQykTewrMecUan/d6Xef2mhuEjcszlMpUrxAaF4l9AvhDZWlywyFq6hvn9KDaahrhAgRWrOrnNAH7Mt3+A5+zBE+WyBmsBr7Voj9DbrrFoDNq1ZmGsYq2RN2JlDT5zCvSMylOWbUnHuDXj6Na/kve8V5Ql2uGOUL9F5ftFW75yBoBconYfIMy4ZMRkDwjP0o//9izbU5R80MdvR2gta/d7Cwq2BkGXvf9g1wcNcT5tzvd9bHrNWtoIOTlvB/RnzHDFr8GVYEW/hTuugKcvaZYfUcFY6KPIkVw615yCAWgL99kKPscYlkWVg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR03MB9902.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef934c0d-cd3a-48b7-1d4a-08df3fda1504
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 09:56:39.7002 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JeVkE3nar1qKrAFMApkkZPlc2ZuzghScqooWsD9hL7TIalq+JCJgd2qu/R93t+dwiCu9s/9zWf+O92/scmfBNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7764
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
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gRnJpLCAyMDI2LTExLTA2IGF0IDE4OjM5ICswODAwLCBGZWkgU2hhbyB3cm90ZToNCj4gVGhl
IERSTSBjb3JlIGNoZWNrcyB0aGF0IGEgZ2FtbWFfbHV0IGJsb2IgaXMgYWxpZ25lZCB0bw0KPiBz
aXplb2Yoc3RydWN0IGRybV9jb2xvcl9sdXQpIGFuZCBhdCBtb3N0IEdBTU1BX0xVVF9TSVpFIGVu
dHJpZXMsIHNvDQo+IHNob3J0ZXIgYmxvYnMgc3RpbGwgcmVhY2ggdGhlIGRyaXZlci4gbXRrX2Fh
bF9nYW1tYV9zZXQoKSBhbmQNCj4gbXRrX2dhbW1hX3NldCgpIHJlYWQgdXAgdG8gdGhlIGZpeGVk
IGhhcmR3YXJlIExVVCBzaXplLCB3aGljaCBpcyBhbiBPT0INCj4gcmVhZCB3aGVuIHRoZSBibG9i
IGlzIHNob3J0ZXIuDQo+IA0KPiBBZGQgbXRrX2NydGNfYXRvbWljX2NoZWNrKCkgYW5kIHJlamVj
dCBnYW1tYV9sdXQgaWYgaXRzIGVudHJ5IGNvdW50IGRvZXMNCj4gbm90IG1hdGNoIGNydGMtPmdh
bW1hX3NpemUuDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+
IA0KPiBGaXhlczogMmYzZjRkZGE3NDdjICgiZHJtL21lZGlhdGVrOiBBZGQgZ2FtbWEgY29ycmVj
dGlvbi4iKQ0KPiBTaWduZWQtb2ZmLWJ5OiBGZWkgU2hhbyA8ZnNoYW9AY2hyb21pdW0ub3JnPg0K
PiAtLS0NCg0K
