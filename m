Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2434BC61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 06:03:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2185A10E3A0;
	Thu, 27 Aug 2026 06:03:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="ODnClPdy";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="JuAiyQLU";
	dkim-atps=neutral
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71B5710E38C
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 06:03:14 +0000 (UTC)
X-UUID: fa8963e2a1dc11f18dc8c9802ae25ab1-20260827
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=u4k4fMro5AYBegZihVJowd9C+b/9wb51y6wclcv7j8E=; 
 b=ODnClPdyj5e41fdWoI+JtYjwwTldkWKHlsi+gg/8NL0Z7bLi6ZBIndXDlHFrI3mMoNen8LDuO42wlG+iWH3rkuB7P8P/DSDxjW/jHICEXBp3KnCClgAZ6HxVbBuYWYc+jng1P8FtXibX3yDAHLrCLHvD35WF8c8Mpe3ypzDvy5I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:80a0950a-1158-4cf2-8720-ca6a4bebbd1b, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:7db8b62, CLOUDID:16bd8a5d-df34-4a8e-9b9a-92fccd5ae594,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
 1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: fa8963e2a1dc11f18dc8c9802ae25ab1-20260827
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1033911215; Thu, 27 Aug 2026 14:03:09 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 27 Aug 2026 14:03:08 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 27 Aug 2026 14:03:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K0FN6Dr0N3AZNkyCkYgIHSSQOGPo2g59BQtHOFDuGhqUpSa7FHGl/S6xzji6wk3etW3zH/IB6etWDGSEqynj3BXJnFpBfP6Q+vMU4sKWeR8Zro141bjmAOUPOrGZE3nkDl6HiS9rIOuq7+F6XvQMdjt3q4/7pE1LQHbO/H9KiQ2otIAgK3tMQhLQiGVYOdhtViwjVEt/PuS5/R9fbcHsiKu9J2eelywERbIwrxAMvwX+mTm8HL+/mFZkW3agF0nSgA3WSPRPsNnRKlIOCD7m2AyTUtZzbw/l8b7InlgDXT1ipjY+tHoSXx7qNjfLIkW/fb48PWHG0IeTyd46aSOSiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4k4fMro5AYBegZihVJowd9C+b/9wb51y6wclcv7j8E=;
 b=IaIUlVgLw1oldO8cQepidMc2x2QM5cJLIdqzj0+MvU+liNyicPZVGLt3telUVb+nNTxzs5rbeQH7ebQoPYzZrdLyJB+e1fWPBWztLOpTazIKj5VtXz0fpg27z0Zy14XyNOvLPipUjlRgsMaLTWAhCBwZNT9npbPMTb98m1XWeUYUW26VpxRXV6FCezoQMWA2hz5B3bW2TlAgRCglTd9FAmxg432vj2ajxiO78pryUVZfpL2Z34EsD2y8szRucaDwhZLz5x01W7snxMGxxDlUKW6vPXY6CClKg1ocZCnuV6TEvxeIMRn1vCOSIobojD/C8sji+WqtjpaxC1YWrjsPSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4k4fMro5AYBegZihVJowd9C+b/9wb51y6wclcv7j8E=;
 b=JuAiyQLUzVoR7e+x3mavP4tjY/Cgd5vlVXwUEJ6irvd/2qS4qJJxOfhNd65sDI0aw8icx1u/CdJ8CQPREitKrvBySQ0nbyilb2f8maXlKunY3u9Ogeh66m2oRkNqnyKPY/Km5W7LZnFa1J8eteORPoe3yQb+Hb54jD3iHx3Iujc=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYQPR03MB9405.apcprd03.prod.outlook.com (2603:1096:405:2fe::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Thu, 27 Aug
 2026 06:03:04 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 06:03:04 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "kernel@collabora.com" <kernel@collabora.com>, "robh@kernel.org"
 <robh@kernel.org>, Alexandre Mergnat <amergnat@baylibre.com>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>, "dmitry.osipenko@collabora.com"
 <dmitry.osipenko@collabora.com>, =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?=
 <jitao.shi@mediatek.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "granquet@baylibre.com"
 <granquet@baylibre.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "airlied@gmail.com" <airlied@gmail.com>,
 =?utf-8?B?SnVzdGluIFllaCAo6JGJ6Iux6IyCKQ==?= <Justin.Yeh@mediatek.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= <Rex-BC.Chen@mediatek.com>
Subject: Re: [PATCH v4 01/12] dt-bindings: display: mediatek: dp: Deprecate
 nvmem efuse data
Thread-Topic: [PATCH v4 01/12] dt-bindings: display: mediatek: dp: Deprecate
 nvmem efuse data
Thread-Index: AQHdD5ahv3e3aHroqEG4Peb965KVGraxtEOA
Date: Thu, 27 Aug 2026 06:03:04 +0000
Message-ID: <75a7c3a62f8fa8b174903e2de38a27454b060241.camel@mediatek.com>
References: <20260709113148.49090-1-angelogioacchino.delregno@collabora.com>
 <20260709113148.49090-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260709113148.49090-2-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYQPR03MB9405:EE_
x-ms-office365-filtering-correlation-id: 112c0251-0ede-41e2-7716-08df0400dbc3
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|23010399003|1800799024|42112799006|38070700021|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: 2THwtGflbS0BPOHLARkMiHe65r3YGKsrsl4nbGethgX5uw65us9bkB3qHV7vmfiM9EHoybjFzl55/YCFYQn06TlHBP1KLKVSNtzkkVoH/nilwF6JCPjMPEDARxXh8R2+3cyVM6hugHasyAnB8vfO7ukRIeVt5QlPlgpl5ExIfO8XxLHOEBypHKUzfvmGlsdWcsA1Kttyvg6o7OqXvQOLjx89PaNliuZKNdFRYxv3lu9mh7s0+3TWyIkRskLHKody3OZbNrc5ou1gGHfJKzYOMn8GAqbD1+xYlYo1arIqJ9vdekHSHEQ8VKqVdUSIw5ZQB8uh18m+KFm7XQd0mngbfT0kxt7PuE7Gbg9ce8y6vzlR7XuIajmv3yvSeND+aHUUDGB4x0gnF6fLCWd3+GXvEdsNz0ghXezr2YQpRWmNVQDoSCFCuAxxumtlFMSNVPEBmlrf5vsHnDrZm8eKr+8aSO8dETSLltYe0wyp+ycp7mSA4NyTWMzVpoTyjoNJ6VLDGjIQ+1Jdz1D+3n35vg2XfsEFY4FCpHWBM75qIvS1WwpuCYWuM08ug69gbUUbP3NWDPxTcA/mu6n8+TUrr8wHVI1DpBjNJMAbVumcXhdAHcwLChRfAjsznHHkAJP1SV3OaHXcwiYheNXBCS1PSN9kSO/A8I7ENA6Rze63DThIn0cgy0t2eZZxHJk6zYC+ZBGDXcLIZUbQeGn0sUMDHk5Qn+EtvCj3Xm6tetNaXI8D9Ug=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(42112799006)(38070700021)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2V0elVjQnNkTlR3TktaenN6dXp0SmJ0R2tnbXJ0czRxWXJBWVZSRkJmdHNP?=
 =?utf-8?B?Skh5TjBXdzQzWktMNzlFUzNMZjMzci9NZzc2ZU96NzZWTFNBOVZpN1pzdm5u?=
 =?utf-8?B?amRSUXRSK1czQkhHd2VSdEpvYnZMMG5vWXZTRU1LTmpmT0hoMTFNaUJsUi9U?=
 =?utf-8?B?dWJuUFc0bVRGc2NWSlo2UTMzT0ZtcDFMKzFBYVNIYXZ6N1ZpK2ZXTlduQnNO?=
 =?utf-8?B?YlF2dm5UbjRTRHg3cnlaSk5LbjFrZWRYSmxDeGsvTVdXNkRmOUt2azJKUXRD?=
 =?utf-8?B?bDZUaFhoZmNhRnV1SWt5QkV3YXN5TmRIcVdENE5MS0pvTXl4SWJXQTM2YkRR?=
 =?utf-8?B?aGl6aElGZlN1QTFvUXZoTTVJRzB6OVE5YjBtMU4xK2FFdnRpUEpnVW9DQ0xs?=
 =?utf-8?B?ZUVwOGxnL3prc1gzcUdvT3hSU2s5Z2U3bDNPRDRMMmxGNUVmS080Sm81Mkd1?=
 =?utf-8?B?MHJHV25OSTRNUDdXSEUrSmNnM0tqcU9BdFhtZGRTNkN6WDRyendKMEJ3WmJD?=
 =?utf-8?B?WG1lbFIvVjUrOXhyK1A1cG04NklQWUJDSGxjZUpsSG41Q2lmTEYzSk1GZXp2?=
 =?utf-8?B?cUl1YWRCa0NnWUJXMEZoRm53OVR5Z3kyK2dsbCs5aXpsdkZ6Vm9aWG55bldl?=
 =?utf-8?B?VFlPczF2cWd4bmZwL2NpdmQwalB6RlA5Y2I1ZElMMUxDTGtGdFRsTGhPRGxR?=
 =?utf-8?B?K3dFWldkNnBySkI5cnN1d3JCVlBpMXI4dndzeGk4MG40M0JrQjIyLzhUWlBR?=
 =?utf-8?B?bmY2T0pIcTNoYjUvMFpUNmN5MForWnpKckc5S0VCcHViSVlxSHVoc3V0dDcw?=
 =?utf-8?B?VDVvNUx5bXdZSDgwQllpNnpqdjIveGp2WTNJaDZKUjMwU3pabElPOVJRZWxu?=
 =?utf-8?B?eXkyQnh5bGpxWXRGQzl3SEE3bUtDWlEyS3ljc2k0Qk1URUV1NityTUxvV2hF?=
 =?utf-8?B?STZkVFcwTWE3NDN3cmRycGt5bjd2NEJpbENYKytRUnVwSmJJWU5WNWczeVU0?=
 =?utf-8?B?SzNyQkl2OHRkOU8zRnpkUktJT0pJVkZMeG9iaDFqTy8yN3ltQjRLaXpXcWhr?=
 =?utf-8?B?UmY4c0RRdHJmZjNsT3p4QWlGYklqSzFwZmFLMTBFMUJPcEhpTkpXbVhmSGo3?=
 =?utf-8?B?TG1oS2s3c0JLY3VSVVFlL1JCdWF1MlQ3TTNHOTNyNzFvUVcwU3FrK0ZEZjJ3?=
 =?utf-8?B?YzdqY3o0aXh5NlFRbWpCak5KTjBxdy8rYU5ZUy9hZnBmRld6RUE5SzZJNGo2?=
 =?utf-8?B?OXN0ZXF5NjhWb2ZVUDI2UzJqUGJYNlpubmI3ckJvZTRFN0l4RHV2Y2JWdzla?=
 =?utf-8?B?VFBqaVFDUTgrR2t2dlIrODJ5YU85KzF6c0c2bUxFMnpQd281K1dYOVo1Q0NQ?=
 =?utf-8?B?SlpJYlZ4WFliZnpRUjdXZE41RFVtRDFJKzF2TFlvZWJnbWVDWlBXNXBKRkh5?=
 =?utf-8?B?TjBpZXI0V0V4ekZmNkdVN3RCSE54ZThsMzVYcUd6cTlMcGQrN1lIT0twQXgw?=
 =?utf-8?B?akI5Q1JaZ1pNQ1lOOW5hbWZQWnI3KzR1MmE1TEN2ak9SYUg3a09XZldORklE?=
 =?utf-8?B?bmF4cmNueWtoREJrV0pjMmRYakVDeHg4amk2U2JLZTI4UUw2bGZRVlNqcngr?=
 =?utf-8?B?TjhBbTIwUXhTMVJjdFM5Skt6SS9paTEwWXRoaWdyVDVYZllwYlJrb0dHZGpM?=
 =?utf-8?B?bjBqL056MksyZEpnRzNnY2t0VVRNanNuRnZXUHdjdWplSWlhT2Fnb05jdGJ5?=
 =?utf-8?B?Y3JIaVVWMVdFV3VVUGlRRVk1bllmdnJaUjBnY0w4WTFBUXdCOFh5WnNnVGtx?=
 =?utf-8?B?bkV4NVBWL3g1bmV1YWNMMG9IUW9aMzN3cS9xRVRJdldGWHhZaStKTWdxTHUy?=
 =?utf-8?B?TTJBU2k3Y2JSNnM0eERFdE8xN0FKcDRTQVgxQ050aFFiM1c5STVCUkxDN1RH?=
 =?utf-8?B?RW9UeE8yZDhoemRMZmRiZk1OWVArblhDY3RYc0hqRDNSUWd3QVRWQndHcWhJ?=
 =?utf-8?B?amZTL3lReFZwNG9hRnlCZGtWWS9NVnB4NFdUSTZEbXdVYkk3aUFGblVoQ3lT?=
 =?utf-8?B?OTZoQWZ5V28zZ2lZNGdRQnhhZ2oxbU9TYy9TamU2UlQwUC9jVk1lMVJ2SEJI?=
 =?utf-8?B?Q3drdWo4Q2w5aWZadGVvdGRsVTNOWWU2ZGJSelZLVEs1eHpOWUdmOUdKS2Za?=
 =?utf-8?B?UGltRU50Yjg1ajVFNGVBQ0todld4UkwyK0hIdmtrOGxRV0JGMTdkTVdEZDcr?=
 =?utf-8?B?T1BGSUVEK1RIamJ5WmMvUmlwcG1DM0NXWCtadlpUN0szWE5sOC90R0xzZlFD?=
 =?utf-8?B?UUltWi8vS05lanhKdU9kYm9mTXh1WXhWM2JHVVZxWUFaMWZrYU5vUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40BEC315EDAA1D48B3CC9C52DE982CF7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 5ShmLzwe7uICkGzGnfCE2TBCq3mcz5268xdV1GwNuIHvSaKdlVYyBzNVKkTed1y04RlGAVk50w1MEa9B3MHtmRn1hmc9YxMN93m/n+XpnaZHXdGkSQMRtktylYKDBSU1FrwWh6FKYBfvG61HrQcny7q2E+BpDUcW2I3GaFvsP4n4gCzYVSUxSJxITUkU4RBs65wJsOun3hNJWRXvwi2JQSq2/82J0xLGWlFVGHTj8c+4FcfU2biDIk9PxpBBbw2TrBbnm6cM+D7h4l5k1RmPofCmoQNHf0IMgcLXoOA1nRAsKfTgdm2GcNXfeDsgYXEFPDL1vu2HgNTBus3aBet0WA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 112c0251-0ede-41e2-7716-08df0400dbc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2026 06:03:04.3355 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +IyBeCYB611eGj5cI+W18e1dlbkwhRICpwP3ZMSSjZUFd9kuoC55RN3sxb3/eWOVmOpgn7C1NpdSMr2nJIL7Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYQPR03MB9405
X-MTK: N
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

T24gVGh1LCAyMDI2LTA3LTA5IGF0IDEzOjMxICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRGVwcmVjYXRlIG52bWVtLWNlbGxzIGFuZCBudm1lbS1jZWxsLW5hbWVz
IGFuZCBjbGFyaWZ5IHRoZWlyDQo+IHB1cnBvc2UsIGFzIHRob3NlIGFyZSBmb3IgUEhZIGNhbGli
cmF0aW9uIGRhdGEsIG5vdCBmb3IgdGhlIERQDQo+IElQIGl0c2VsZiwgYW5kIHRoYXQgZGF0YSBz
aGFsbCBnbyBpbiB0aGUgUEhZIGJpbmRpbmcgaW5zdGVhZC4NCg0KUmV2aWV3ZWQtYnk6IENLIEh1
IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dpb2Fj
Y2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+
DQo+IC0tLQ0KPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRp
YXRlayxkcC55YW1sICAgICB8IDQgKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRwLnlhbWwgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxk
cC55YW1sDQo+IGluZGV4IDhmNGJkOWZiNTYwYi4uOTgwZjc2NjY3YWRhIDEwMDY0NA0KPiAtLS0g
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRp
YXRlayxkcC55YW1sDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9k
aXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRwLnlhbWwNCj4gQEAgLTMwLDEwICszMCwxMiBAQCBw
cm9wZXJ0aWVzOg0KPiAgICAgIG1heEl0ZW1zOiAxDQo+ICANCj4gICAgbnZtZW0tY2VsbHM6DQo+
ICsgICAgZGVwcmVjYXRlZDogdHJ1ZQ0KPiAgICAgIG1heEl0ZW1zOiAxDQo+IC0gICAgZGVzY3Jp
cHRpb246IGVmdXNlIGRhdGEgZm9yIGRpc3BsYXkgcG9ydCBjYWxpYnJhdGlvbg0KPiArICAgIGRl
c2NyaXB0aW9uOiBlZnVzZSBkYXRhIGZvciBkaXNwbGF5IHBvcnQgcGh5IGNhbGlicmF0aW9uDQo+
ICANCj4gICAgbnZtZW0tY2VsbC1uYW1lczoNCj4gKyAgICBkZXByZWNhdGVkOiB0cnVlDQo+ICAg
ICAgY29uc3Q6IGRwX2NhbGlicmF0aW9uX2RhdGENCj4gIA0KPiAgICBwb3dlci1kb21haW5zOg0K
DQo=
