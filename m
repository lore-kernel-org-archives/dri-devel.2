Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 378D8C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 06:25:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8589010E571;
	Fri,  3 Jul 2026 06:25:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="q9QvDk0f";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="EgLnC5Wu";
	dkim-atps=neutral
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5459010E571
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 06:25:14 +0000 (UTC)
X-UUID: ef0cb7a476a711f18dc8c9802ae25ab1-20260703
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=G0f60lYkRY5PnOCTMmX0a6qLX89PI4ye9WUi3cLhnZE=; 
 b=q9QvDk0fDWtTzqJYmzJoxxqtuThjavVhyht6tz5haQJeCKw8RqdrbcK9IqL83vLloQUAuG2WghRX7zm5gAehyvq15A9JP29kb0/mYGnAIBymoNN7OpaIP3FXBcVPYQOuLO2qJ9c1/1EWmJZ+dj3bAaoEgMhIIXxoPLyuXqUISYY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17, REQID:59f70b2a-9a0b-40f7-869f-45ee476f966f, IP:0,
 U
 RL:0,TC:0,Content:1,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:1
X-CID-META: VersionHash:d497b38, CLOUDID:da33b014-ea64-44d4-98db-4e1fb89955a3,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:4|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
 1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ef0cb7a476a711f18dc8c9802ae25ab1-20260703
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 669584132; Fri, 03 Jul 2026 14:25:06 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 3 Jul 2026 14:25:05 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 3 Jul 2026 14:25:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H11ruO1oTZE1+FwY1WMLVpss++a7krbAxjLFJmlAwK4wAkNq2lLksGhYzdlfclliXdCtVgLzhSyGe7R/ZKs6nqupQuSr7BdzhP5tGE4frrt0T4VDBBZxx8uCXfEWDB+UI+7TvbqDLJaML8GZOlsPbm8Xfa+ACXeSKaBTNwaUIQo/lRO1YxfBGso2FZJVxxHOo98cQIdS9LyB5yVxZklbbIL9j/3+NFVPWT/2FN7+PYBhVPaVUwoHO7rDWlatdueQpHdn/b6Y683cXwBH4JdHWqdAdG2vkU9HSbOsEtnGhSLGFeCueXfeoJ+pZyamsxnpkYT6C8APmWzyYXyii4pYGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0f60lYkRY5PnOCTMmX0a6qLX89PI4ye9WUi3cLhnZE=;
 b=YWLA6XkOlyKsbmMN3vzFYZ2oC/esxYYDPPHB597OkY0w8Y9uXl9wNTAGVrDMfIebf7bj2L9p6O9fhAPsvhusQH+PWZfG6dNOiCiDu4FBJMvpBrC+uj6+ua2qMQ/HeaS36ZXdY2hWLpAcR3SKJ1eA2xCOoEiQ1Ij9url8ugXsR4iZJjcYRPmBn7tdLQV/XxSmMfRaAqkPnvgt2YpSLRTksMk1tGf7j2jJ/wkZFe5HP3smMqSAk20Lxr53Q0hqaAt1Z1JQx+e6bGcQnDS/bSXi+dW8lC3n70sZcpJzM//Y+IlEkoDcNPxH374JDs00cRIGQO3SpSukqbHynEquksip2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0f60lYkRY5PnOCTMmX0a6qLX89PI4ye9WUi3cLhnZE=;
 b=EgLnC5Wu1NBkJHYSAMDzfclqhmbblhUIPOlIAMV7YyY8vUShg5KT+UvL4ZtK/dhiobmjpgrS9UHpU1DB7ZdqQFwvZSJnCLPBXjY+Vj9+hiAfbZTq+iKIqaJeG25AA1ghX6eBnGVS5uSpLhD90xw2tToApYbEQXizbXFYEi358fw=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB7583.apcprd03.prod.outlook.com (2603:1096:400:410::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 06:25:01 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 06:25:01 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "mripard@kernel.org" <mripard@kernel.org>, "kernel@collabora.com"
 <kernel@collabora.com>, "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "p.zabel@pengutronix.de"
 <p.zabel@pengutronix.de>, "airlied@gmail.com" <airlied@gmail.com>,
 =?utf-8?B?SnVzdGluIFllaCAo6JGJ6Iux6IyCKQ==?= <Justin.Yeh@mediatek.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
Subject: Re: [PATCH 05/42] drm/mediatek: Rename all display component type to
 have DISP_ prefix
Thread-Topic: [PATCH 05/42] drm/mediatek: Rename all display component type to
 have DISP_ prefix
Thread-Index: AQHdCVQxaVYrjxpCukGF1HdRmAL5wLZbVrEA
Date: Fri, 3 Jul 2026 06:25:01 +0000
Message-ID: <d196191de45bda097847037240d0534b327ee6d3.camel@mediatek.com>
References: <20260701122057.19648-1-angelogioacchino.delregno@collabora.com>
 <20260701122057.19648-6-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260701122057.19648-6-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB7583:EE_
x-ms-office365-filtering-correlation-id: 984ab505-ba6c-4026-c2c8-08ded8cbd044
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|42112799006|366016|376014|7416014|23010399003|38070700021|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: noDCcj3AdI/HNYlIQbstCGbgI2LPHVzt0jNV45grqlpjo3CqmIHtxtf0kGexiFXwWnnPasilGQISNFi7vINEp+by6p57HLv8h3pJxSXnNKDPmv9vTvnAhpvS53mxkZVtgcZzMNy47ajf6VBHUteX04LEo1906L4fzQliyMh+ub+wEmxLR/ld7dPbFseJl4Bz1lWgjUy/8sKMjm5O/z764AxujzjpGeWgUKK2qbB0mk8k5Q6THe4/vIydb+JjxGvMoS3MBofViHBfj/zf4/sNMY6DhypdUHEf4wNYoUA8zOYXILxw7hlDX+bajQ7NK3Hz7d3nyreweo8s4uCxX5fwXXUGqT6aZfd7aY6mw+whdVZG/HrIaZcrrR7gS88GxIctLtHeeBYdewMcLIdP4284Zd7wPybRbwmcKy9eNUL2MkBxa/buJjrsxVRavyRF5O7nTejvo4InIrrYf1vvha2eQSWiZQGyl8SVifnv0TS8h2uq/Kw66paYJxgzvxqyJl8J2wJsej0ZIyJC4IbfnSNUMAffae2KoaOdm4KyeYZyDV1+7sgYMgUtTZkui9+qnpdYoLW1Kk5h51QJgRg84hOX5A3Rfbldl8GYXePii1VcTGsVAq3225SObZe/08flvHs1ZAK0qGDuVWd66C+zlJBieuVSdLMVuejX/EoYl1JGNtoQCd1mODuT8bRuZChataJnnzjU58zNW5SyXv1x0Y0QgQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(42112799006)(366016)(376014)(7416014)(23010399003)(38070700021)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MG5TaWJadU51cWhSSDQ5WUZTMzlnZlFrY1p2RHhZdHplTXZ6SkQzVWtZNVFt?=
 =?utf-8?B?WWlLRE9hRDkrNVlJWXQrbzBKdndFNnM3KzE2WjZFMXRxWk9NR1o3TC9DSWZC?=
 =?utf-8?B?VU5YbGM2a3BCOVdFTGJOUXhLNzJZK2h0eXlUek94R05ESExqWW11N3Z2WE5N?=
 =?utf-8?B?TFFnS1Rrc2ZacjcyM3hSTS94VEN4b0p1ZjUvblNMUmw0R2xmY2FZOEZLME1q?=
 =?utf-8?B?bXp5UUkvcGxEeStReHAwa1d2M3A2a0IzcEYvdHkydUZiQWVhemlVZnZxYjdS?=
 =?utf-8?B?Sm5sRVdNbFJqbTJYUnlyUEdYSlYveEVNdFV1bW1vVTNwZDJGT2xGRGllSnps?=
 =?utf-8?B?bVhYZmEvZHYzWGo2SXFxQzJoSzJBU0lmNmg3a3ZEQWE4Rk5jVnJ0ZkRCMWhF?=
 =?utf-8?B?YkxzcS9VaW9Lcms3dGhRMVVuWm5GUURKbzViUDhhbE5UdGM3bjVmVFFMaHds?=
 =?utf-8?B?S1haNThvNmNpa3VJSkhxT3FkZkdRdExqaGdXcUxHaXlBYVYyRU16RVFQREk4?=
 =?utf-8?B?Z2FoWEpjQnVWaGVXNGdsUXVKNXhaRGJISUhVTVVremZVR0NUUUJEUURINWo2?=
 =?utf-8?B?WHNJVGsvNTUrUHFMMUJILzRHeHpieC9rVjVMa29BSTcxcUhQYlBSNjdRU1Ux?=
 =?utf-8?B?VTVUdDhlUk5uV2paRFdsY1VycGsyaFlGVERtbDB3N1cwVWtzN3k0K3VrOWcw?=
 =?utf-8?B?cXBKWGxwN2lJRmRraXFYSlpuZWM0VUlJb25PNENYdlFEU0d4MmcwZGZFYWlr?=
 =?utf-8?B?djE0eTRuTXdnL1JkRzUySGtFN0hFeU84aWFlRXIzTjA2Ynl0UnFLOVZ4RXFR?=
 =?utf-8?B?ZnFuRmpLaGI5cGxMU0l3TUV5SmdNYTlEWVI5M1ZzamNhdU44Y2t3RGtpSzZ0?=
 =?utf-8?B?UGZJNEVpSmY2YTMyK1c0aFVOZlRUQ055alNDWWRZWlhtRjhLSTF6S2NIQWw2?=
 =?utf-8?B?SGFTZXVnLzh5b3BnWXBWN3JiMkl5NUZZRGFZMFR6cmM4MXNGdjdDZ3paL2Ux?=
 =?utf-8?B?bWtUaEVEYWlFM09aTWgzOFFQRmpEeWkxUi9ueFVZekFDeFg1bTVqdC94ME1q?=
 =?utf-8?B?NTlqQ21wSENLMCt5K1ExRG1saGRMTmRFK0RHSFQrKzFLbFI3SUhzK3d3T09V?=
 =?utf-8?B?MHFBNFRLVklLdktlbm9aZ1lxRERlN2VMaHFvQ0ZMekE1NWM5OXg4amw5NjBH?=
 =?utf-8?B?L3BKbjUvdy9EdHFRODFsVkU2UkU1eTZUc1B4dmhpWE1oVXRIQjVPdXVFNDZh?=
 =?utf-8?B?cjlhVndUalM0ajl4azREM3F5Q1BMbjdWUXNMUDNpWC9RNmsrZXJvV3IxZGN2?=
 =?utf-8?B?V09BS1pBSnZMb2dZcm5wbzVOMExia1lPaDEvQTVoL1g0bVpWSWYwMzI3QXM0?=
 =?utf-8?B?TU1rNG5CVVpZMGZTdDVObngzcm80Qy9GbFBJNjFhNWdQdGtoNmJVT2tMNG9D?=
 =?utf-8?B?Wjc3Mkw2bVMxNU9Db3ZaYnNrbW14VDI2LzRNb0tOMTBnd2RxMnNmbWhmK0hh?=
 =?utf-8?B?WTRFWHVPeTFVT2hUYU9rNE1vVWEySi82ZXFPOW5abVd3OHYyZXhFdWtnTU56?=
 =?utf-8?B?Vk0wQVRsdk1WUTYza0V1TS8yM05lMXhTcWQyYld5cE8zZ3JITlJoTFNCcEtv?=
 =?utf-8?B?UUVZY3NyVXlBZGVmWmlTK2VDamtmaGxuL3MxMlZMdzJuN0hUcnpNK1psVW5M?=
 =?utf-8?B?WkNTZFBrNkZtWW1QTkZjcmFMbjZScnVBbmVYRmZhMTdjUUZrb3MwbjRGcnI3?=
 =?utf-8?B?c09qTTJIbTQyakx4WVIrMWhoN1N5em5NMzRZSmJKdWUxSWlIdnNMUEZwQXJp?=
 =?utf-8?B?YlFqUzFqNHVxUHJBS0NJQ0pSSHN1SDMyWXBOaFVPMkpJei9kaVozbEJYSG1i?=
 =?utf-8?B?VWgxVXMyUFBiTXRQOHBGRzZieC9kdDRoc0NFWFJHSU5nTEJVdWdRMWhFam1W?=
 =?utf-8?B?NlZCN2M5R3BOYXgyOE01V2xJYmNndm93bVdUMGVQZTcwVjZ6d2JuMmtwd1hN?=
 =?utf-8?B?MUVLY2c1T3BLZzVkL2RBNmRvc3hFbEhDLzY1YzVKVjRHUlVaVG16NmM3WDRr?=
 =?utf-8?B?TFRjTHhnSHBIdE1DaFlpRVF0em12SHA1N2lVUHZQN1pDOElJczEwVUZvZnND?=
 =?utf-8?B?RlZaTmdnMXBKSnVlR1lWL3F5RjFTWmgyR3ppVndjREtaeEsrUWtld2QxaXMz?=
 =?utf-8?B?QTZCSG1qbU5PbXlUWDVtemFYRFlGcVBYcHJyc2Y1Z3daRVJyVUt0TTZySHJF?=
 =?utf-8?B?cnAyVUl0cUtKWTNjbVZGYitUNnpHVW1mUTAyR1BiUjVaekdwU3FuT0V0WkJT?=
 =?utf-8?B?YkJ6eC80K3crZXJtS3pqbnlwVVIwVVlDYkIvcmsyWkFRZFE4bXlxZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F69AA9260A13148876EF4207667DF6B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: T5THelJMg1Ot9sOyAK52osZi0FTVxOE5W4S9AOckM5NqPCdfcSNw9TQc3JMxhTSEkMcPBmavtGhYYWznlFOG/rmO8OMWEGnrPLGi9BWuMwblDs8MEwjgUVO0RmuRePNPH6XtprpjDzQ/kZSlO0zldVjBBTB5xXUVTcdttEkXXbM2RS9JaWeeVY+gyxUL09uXNMx3xlXaOPqbh1UI0ihbgLrmdgI+oNTkVwHOhWacWvf1PXcDwvlv0eBb3UGMg221iy0haHlap+of49JOD5E4XCv2WIenBUaeBvLoJ7KtFrwdyYFB6hh7u0LkfW0aL4XDJL4+/hq6BKrHy+/tll9c4g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 984ab505-ba6c-4026-c2c8-08ded8cbd044
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 06:25:01.7000 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XVuyP2qvdGkVZNtNw1gTLAbE1MDxMM4wSjjm6LdkdN86lBdquqb5h82tOIs/MpfrYrn1zXGWA6Ur9DFHBGkn5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7583
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

T24gV2VkLCAyMDI2LTA3LTAxIGF0IDE0OjIwICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gVGhlIG10a19kZHBfY29tcF90eXBlIGVudW1lcmF0aW9uIHdpbGwgZW5k
IHVwIGNvbnRhaW5pbmcgYm90aCB0aGUNCj4gRGlzcGxheSBDb250cm9sbGVyIGFuZCBNZWRpYSBE
YXRhIFBhdGggQ29udHJvbGxlciBjb21wb25lbnRzOiB0aGlzDQo+IGlzIGJlY2F1c2UgdGhvc2Ug
Y2FuIGJlIGludGVyY29ubmVjdGVkIHRvZ2V0aGVyIChhcyBpbiwgdXNpbmcgTURQDQo+IGNvbXBv
bmVudHMgaW4gRGlzcGxheSBDb250cm9sbGVyIHBhdGhzIGlzIHBvc3NpYmxlISkgYW5kIGJlY2F1
c2UNCj4gYm90aCBNTVNZUyBhbmQgTXV0ZVggYXJlIG1hbmFnaW5nIGJvdGggb2YgdGhvc2UgaW4g
cHJhY3RpY2FsbHkgdGhlDQo+IHNhbWUgd2F5Lg0KPiANCj4gUmVuYW1lIGFsbCBvZiB0aGUgRGlz
cGxheSBDb250cm9sbGVyIHJlbGF0ZWQgSFcgY29tcG9uZW50cyBpbiB0aGUNCj4gbGlzdCB0byBh
bHdheXMgaGF2ZSBhICJESVNQXyIgcHJlZml4Lg0KPiBUaGlzIGluY2x1ZGVzIGNvbXBvbmVudHMg
dGhhdCBhcmUgaW4gdGhlIE1EUCBDb250cm9sbGVyIGluc3RlYWQsDQo+IGFuZCB0aGUgc3RyYXRl
Z3kgaGVyZSBpcyBmb3Igc29tZSBvZiB0aG9zZSB0byBhbHNvIGhhdmUgdGhlIHNhbWUNCj4gRElT
UF8gcHJlZml4LCBzbyB0aGF0Og0KPiAgLSBEaXNwbGF5IENvbnRyb2xsZXIgc3BlY2lmaWMgY29t
cG9uZW50cyBoYXZlIGEgRElTUF8gcHJlZml4DQo+ICAgIC0gRXhhbXBsZTogTVRLX0RJU1BfKE5B
TUUpDQo+ICAtIE1EUCBDb250cm9sbGVyIGNvbXBvbmVudHMgdGhhdCBjYW4gYmUgaW50ZXJjb25u
ZWN0ZWQgdG8gdGhlDQo+ICAgIERpc3BsYXkgQ29udHJvbGxlciB3aWxsIGhhdmUgYm90aCBESVNQ
XyBhbmQgTURQXyBwcmVmaXhlcw0KPiAgICAtIEV4YW1wbGU6IE1US19ESVNQX01EUF8oTkFNRSkN
Cj4gIC0gTURQIENvbnRyb2xsZXIgY29tcG9uZW50cyB0aGF0IGFyZSBleGNsdXNpdmUgdG8gTURQ
IGFuZCBjYW4NCj4gICAgbm90IGJlIGludGVyY29ubmVjdGVkIHdpdGggRGlzcGxheSBDb250cm9s
bGVyIHdpbGwgb25seSBoYXZlDQo+ICAgIGFuIE1EUF8gcHJlZml4IGJ1dCBub3QgYSBESVNQXyBw
cmVmaXgNCj4gICAgLSBFeGFtcGxlOiBNVEtfTURQXyhOQU1FKS4NCg0KUmV2aWV3ZWQtYnk6IENL
IEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5j
b20+DQo+IC0tLQ0KDQoNCg==
