Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 104FEC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 05:38:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ACB210E56C;
	Fri,  3 Jul 2026 05:38:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="p2E2t42h";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="CxgDxVZr";
	dkim-atps=neutral
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00B6B10E54F
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 05:38:10 +0000 (UTC)
X-UUID: 5dcc81e476a111f1b1788b6acf885367-20260703
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=eo2EMP6krYMZICgHTH7LnNjN/gTjHOXWwyBPTdiuC9o=; 
 b=p2E2t42hxszzWYGCoE+5TOTbPOHI+OzJr8xhKG/DlJTOlk6vhFMu70Chd//dZ0swlwd2R3eWvd/u+okzixvMPPX1761sCJkP0duqy0uqd3k3xPULqw+BQnIaMIfCi53S1QsF8pzIjeRc//Z7muhJPmnpQIbFWnuclnQVS7P1N/w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17, REQID:b2c753f4-cb5e-4345-a524-38a3f5f309a0, IP:0,
 U
 RL:0,TC:0,Content:1,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:1
X-CID-META: VersionHash:d497b38, CLOUDID:30ba3f04-3795-4a90-800e-68e9393a343e,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:4|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
 1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5dcc81e476a111f1b1788b6acf885367-20260703
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 343139647; Fri, 03 Jul 2026 13:38:06 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 3 Jul 2026 13:38:04 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 3 Jul 2026 13:38:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dkABzZszvjKqifktgq6I34BRTceYMR0odZztuzI62uxUg5S27G/F6lewVPSvlQu9d78V+bhhHpkBoClhxE3SNuFmsm2gQ6x5rbzzxDczSJ81iy7NoUX71CQixDWbf2ykfyZbe8rC/x9MQxFsF0UWyoty1fFfNtdTbpjBTgtq+aUAUZ+n1f8jokbbQ2PNP0Q3NZNFbnLKE3ojcIFIjXUfFLxuKk5SZn2C+ofXBWx4M6Ri5BsMCrz09J704TRVYXYQrQHKQrzYIdDWABJEyXMp1ehnnhmDkFjbM5yZfDohMbOVAxPx+IgvA24JyukT9WzphOpcIapLbM7nVGS7my7yxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eo2EMP6krYMZICgHTH7LnNjN/gTjHOXWwyBPTdiuC9o=;
 b=qpePSy6Ww5zVtPu963Za8U8RZPWGuMATmrWtY9T4/FDh6Ees8SMWEDgUi2jG6wOLQ8gbmosUZdJJ+cfAAp1iyj+sZO/GdEmUwKKa4jGDZ/j5KzfvfePpPQyioh9ccAzcOd3GJxRFLa1rbUzblNhPR1rjvFS87MP5nydh3qFQexkvNz/o83NLAH1HfviABspE3WHT1Mz4aVaXGkj46/QI3pzjQbWFKV4n9MXONOfijHDFiCGVB1FdSKd1X0ad8dgFaThXHWvlV+RK/piSIO+/4UjxXtuiXyZGU1CFLmZ6lDLZm4gB5jWZFXv+fmiJzvBoD+tKauBBIg8VCDT6RmZnhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eo2EMP6krYMZICgHTH7LnNjN/gTjHOXWwyBPTdiuC9o=;
 b=CxgDxVZrnA4A2JH9FGyTKqlIawHlsWLGNheta5LucprmOgyT/DfXh4nyhXTzM7/h+Cixu6M4vXY9RSBuegG5okkZ1C5SstHWKLOPvaEmAqj8fXLG18fMhkMeECdo/+b//4U7Ei8GH0+f5s6meTHzuWVaG7WdNfdGR7kUrNydoVQ=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SI2PR03MB6712.apcprd03.prod.outlook.com (2603:1096:4:1ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 05:38:01 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 05:38:01 +0000
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
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 =?utf-8?B?UGF1bC1wbCBDaGVuICjpmbPmn4/pnJYp?= <Paul-pl.Chen@mediatek.com>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
 "airlied@gmail.com" <airlied@gmail.com>,
 =?utf-8?B?SnVzdGluIFllaCAo6JGJ6Iux6IyCKQ==?= <Justin.Yeh@mediatek.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
Subject: Re: [PATCH 03/42] drm/mediatek: Export OVL Blend function
Thread-Topic: [PATCH 03/42] drm/mediatek: Export OVL Blend function
Thread-Index: AQHdCVQy3JQmcSrRkk66DuLw3I83DrZbSZCA
Date: Fri, 3 Jul 2026 05:38:01 +0000
Message-ID: <a1f7548137633981f5b0fe8be2bfa09f7bef99d7.camel@mediatek.com>
References: <20260701122057.19648-1-angelogioacchino.delregno@collabora.com>
 <20260701122057.19648-4-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260701122057.19648-4-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SI2PR03MB6712:EE_
x-ms-office365-filtering-correlation-id: 0d3d74bb-d537-426d-4d75-08ded8c53f6a
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|1800799024|42112799006|366016|4143699003|11063799006|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: iP+4LiYOeAyMlZt31h4sreZf/OaNSneh5qlK6HFhFwqALnPO+Bpi5uuKmrVStQnmZBf7RXP3o2dgxFEffFQal96VC3dKfsYhpJYQpVGn+abuExAtdKdiQF0e1N2fQZhQpz/uLsVqJ1LRvnUyQfq0ig9SSWqospXSYZYEO5F3FGbT24VHP/iMRUxGvTNfMbCvneYTQZo5Hwrni3JN/TDFgHSyZfc2AHtArzCu8uMhkbuLCC7uo+WJQ8Gx+AcXbtVb/kRr9aM+AhTPbRCTq4hkjWT20S3laV4jmfFpzCKg8IQ7vmXW8j+lOGagtgVUClZM6XBn+6YU7qWoc7wWxG7SUU4d8MGDxOqcDZxFMNnfgTDIXtdaIWybc4R5gnClaz/+NlwPN+XJXPotP3kcL2xk4mu5Tn6u7iwvSog1cJBYcp5UnweaJasMIaUub9dIrF5hyQyxs+swQgsvGrl0/7/hwmBaANN2+Ojum35sdlFsg7WCwK8RonF5VaEMTRtokkJl7r7Kc404fSU3z7vjULbn9rVTvw4mVp2cShN3C/mGhpfE6YXS4OnqFSOh2pkTKxZ7yW49MLDq8wR3JYhQQV0ICfsc+IEvP5E7qKEPragUXRiyD7RM3AsfaaWhI2/4bduxJ32K9u5djNyOt0bl10VPX0DGyDKz+NwP52Mq2nNFno38Anl6TCpff2T0tUMjKXrL7MMdclTWq/Mix3uJokx7Y+t4Ij/voRd13vCP9domOI8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(42112799006)(366016)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWVMaU14R2ZCMzI2b2lYZU85RGxMY2RaOEc3bUNkZWNxbGxQNFEvKzZuQ0Qy?=
 =?utf-8?B?Z0dzZzV5TlZFSzlqWGJlZDFjMUxXaEk3bjlxSE8zcnI4d0tqZnozSnU5QTIz?=
 =?utf-8?B?b2NTWmN3TjVyV1hldndjMzUybGsxMEkva1dzUnlocEphTzA2aTd5Y1NQQTE3?=
 =?utf-8?B?R2lhMCtJTmlIVWp2MU5QMlBXbld4TmlRUGVhTXMwcWF3a0YyREE2Q01NTkla?=
 =?utf-8?B?enNPSysvMEUzQitmNktsSmhZMU5QTGZFeTNCUzN4OHNNWmp3cER0Njl4MUdj?=
 =?utf-8?B?Mi9GQTZvbmF6SmpwM1E5TmVwcDlQdjlOMFhkYkZ6N0gzd0lMU3RwTEU3RXFY?=
 =?utf-8?B?MDJMOU90cWFUdjIvMjhTY0hDUy92LzdGbHdKQzVSajU0OXdNSW1BT241RlI1?=
 =?utf-8?B?b3dMUnpaSFlzM3ozb21vSFp2WlNYUUpZaS92Z2VMSTZNVjdHbVlOVGhpemVB?=
 =?utf-8?B?c2txYmc2UXB2Wm1Lb0Z3YmtOMkpQSVpyU3JaVVhscEFiKzhGbjA4ZVNJMGVE?=
 =?utf-8?B?eFZHczVGQnQrSVlIanduU0ZYcWczUEx2R21PcUFNVWt5Q0F6OU55SFhJK2My?=
 =?utf-8?B?U0lrVlNwSjJRdVprWGR6c04rR2JNOXpxSUxrKzNlRFFBb3ZvQ2VIVSszUFdl?=
 =?utf-8?B?U01ocy9zbUM5NVV6TlVrcjM3ZFY3LzUyTmswU2xEQWNvelk5eUlKSUxObG05?=
 =?utf-8?B?L0xnQzhXV2htTGgza1VFc0ZhbE52cjN6UHpReUVsaHRuZzkxTm5KUisvSXJJ?=
 =?utf-8?B?T3pCdkE1V3hsN1hNNkQrblZzQU5BQ3NGaWxYdlpEdXZTTEFubm0zZExvUXcx?=
 =?utf-8?B?eVdkRzNWZCtlaU5OTlcvNVNOZE5tR2xMSDZ2aGtySElkS1d2TXlvcUhybXpj?=
 =?utf-8?B?RmJ2UTZLc3l0RU9SMHRESXhqa1ZtUHFuWVRvbEpSTWRveGU2VCt5ZGNyUzZS?=
 =?utf-8?B?Q3dIZXVkcWc4NjdoRzZnQXJLd0s1WHpvOVlQREsxTHI5WC9iVDV6NGRSd1c1?=
 =?utf-8?B?U1FNVWRWL016SldxMklZMW1pYXFiTDNQMGpKZDZxVkJ3TG5QZjBxMWRFWDQz?=
 =?utf-8?B?NXA0Vk15R3NjNkt4citlOUpITmNkSjllR3lrU3BZbURxS0d1TUVwbk1Zdzcw?=
 =?utf-8?B?NnNtRW0xKzJZZi9NUDZ6UnV6RUtYdk1pWFJjV1owUjAzZTcxVmFWbnBlclFQ?=
 =?utf-8?B?OG5CUWJkdlpxS1hPTmxZZkc1ay85NlZKVmdpQURwMEpjNDZENWd6RW96ekZa?=
 =?utf-8?B?T04vbHRSNUt4R1k2bkI4R25Od0p4U3FSeHIyQTZYb2tMcGdsTG1RZ0hCSzdQ?=
 =?utf-8?B?MG5pQ21zNmtpaVo1YUdBQUU5bGVlVmQwK09VU2h6eHhCVlVpZTVNVnhMVGtS?=
 =?utf-8?B?WXBISUhYbG84TzBOYnUybzRUeHFjWVhCQmN6ZzdodDhSMlMxK1JpUUorZGdl?=
 =?utf-8?B?VVNtOHcrMEdhMGx5dGVxOHk3amlXSHRIY0MvckJ1OVFBNU93a3pJdGJnQXV5?=
 =?utf-8?B?ejZqUHhaUEFYeW9xdWorQzhNZm1hdzZuY01rWFZjOWNVMG9BUFpYNWt2YUQv?=
 =?utf-8?B?LysvelkzSzJ5SzJOYW1jOFFtN1hyeTIxc01mT25iTUtpdzRsVzU2MERIYmVk?=
 =?utf-8?B?Z2VHRmVzSUNzdWlsNG93bytPanNybkdUUW16c0JHRXkrb0lhM3V3ZkNIR3BO?=
 =?utf-8?B?UldaUGlwb2M2TEVtSVd5b3ZlZU8rMnR1VDF0RDRvWWZ3b0ZBdHkyNlFDWCs4?=
 =?utf-8?B?Z0MvLysyZGZHQVluTkNqT2ZzWkFJNnRnWVdsL0FGZGxiRkREZTZ6MFpwcWps?=
 =?utf-8?B?Z0FPOVErbmZjNTdMdGlDZHRsREhuRkRuZnhkaGU4RnVFajdRWWVoT0Q4K3Bt?=
 =?utf-8?B?VVVxMTl1MmYyVm9kZjBuNHVweGNZT21rZFQ4ekM0dWpWRWFpUE45NFMvZnNN?=
 =?utf-8?B?ZnpVRVlMYmhFTVJLVThmVDEvRUZSM2ZSQnBBR3BDbk44cHFwd1ljd2lua2Mz?=
 =?utf-8?B?aFJHVitlakc3MW9xc05UVU81LzN3eG51YjcxRDVocCtnTlRhMFBVL1gzYWVD?=
 =?utf-8?B?dVZoU1VWdWtDa0IyS2JpZnVtU1RSRnlxT2Q2YUc1R0xHNXY1ejhOQzJyNnJz?=
 =?utf-8?B?WXJGTHRWRVBCbnUxU0lRUWtTZ1lWeFlydzZnRG9TMDZsajZia2k5cGMyM3V2?=
 =?utf-8?B?NUlGY09vaUVMOWFlVTBlNlBYbjRvNmZvUzJUL05GcXZOTitoRmc3SG1HVDh1?=
 =?utf-8?B?SXNYTGRUVzRaN1dvWS9IQ2lEcUVTYVdZaGN4TXhjK2JKSVl0MEpOS2JObGV6?=
 =?utf-8?B?K3dzQ2daU1pOMHBYS0laWXhscGxrUWZuYlZwcTkvK2xkUnJEUFlTUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4027FF2C5D10BF4EAC64EFB7B6E40335@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: T7XYuCD8dtv3MRLNY5dCf2IwepxgJ0oSQy1KRjTbmFMdOojOs8P87fJeR7dLi3FR9/swvkILJyxkwYDx+DKp8JtvG9oqylaC+47KQ8djKFVZlPV5kbLLoxktSEZCBiwvkfs2n4/eZ/hoCx0NyvGnxEwmFMjO9Xlvl0apSOMAONKiIviOxRHdXLecTui4/Lv73ZMk3c1mbVlHciYX3YhZlEv5Zc+pcEqSc3zpgUtEb7lFses4GAHuG4FwaEPWhFzseWyN+D5cQJwOXuZyzSJa7y2DvlCoQLQi40+LSPyJzQ6/DXPg25Zrr9l3oh8iC5h8IHEVwRI9u8DYA2WYseibWA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d3d74bb-d537-426d-4d75-08ded8c53f6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 05:38:01.6847 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hh5YOKurOXRlmg5kwrh6DTsKAJ+wk/P/rqWk+X6kR3l1dk7RaSY1HGGXJ8Ys9aOrmbRJy+Li/UTB/udyoOHfwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6712
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
ZWdubyB3cm90ZToNCj4gRnJvbTogUGF1bC1wbCBDaGVuIDxwYXVsLXBsLmNoZW5AbWVkaWF0ZWsu
Y29tPg0KPiANCj4gRm9yIHRoZSBuZXcgQkxFTkRFUiBjb21wb25lbnQsIHRoZSBPVkwgaWdub3Jl
IHBpeGVsIGFscGhhIGxvZ2ljDQo+IHNob3VsZCBiZSBleHBvcnRlZCBhcyBhIGZ1bmN0aW9uIGFu
ZCByZXVzZWQgaXQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBOYW5jeSBMaW4gPG5hbmN5LmxpbkBt
ZWRpYXRlay5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFBhdWwtcGwgQ2hlbiA8cGF1bC1wbC5jaGVu
QG1lZGlhdGVrLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVn
bm8gPGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gLS0tDQo+ICBk
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMgfCA2OCArKysrKysrKysrKysr
KysrKy0tLS0tLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmgg
fCAgOCArKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgNTYgaW5zZXJ0aW9ucygrKSwgMjAgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
aXNwX292bC5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jDQo+IGlu
ZGV4IDlkZWQyMDIwMjE5MS4uZmE0NjA3MzA0YWNiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kaXNwX292bC5jDQo+IEBAIC0yMTUsNiArMjE1LDIzIEBAIHZvaWQgbXRrX292
bF9kaXNhYmxlX3ZibGFuayhzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICAJd3JpdGVsX3JlbGF4ZWQo
MHgwLCBvdmwtPnJlZ3MgKyBESVNQX1JFR19PVkxfSU5URU4pOw0KPiAgfQ0KPiAgDQo+ICtib29s
IG10a19vdmxfaXNfaWdub3JlX3BpeGVsX2FscGhhKHN0cnVjdCBtdGtfcGxhbmVfc3RhdGUgKnN0
YXRlLCB1bnNpZ25lZCBpbnQgYmxlbmRfbW9kZSkNCj4gK3sNCj4gKwlpZiAoIXN0YXRlLT5iYXNl
LmZiKQ0KPiArCQlyZXR1cm4gZmFsc2U7DQo+ICsNCj4gKwkvKg0KPiArCSAqIEFsdGhvdWdoIHRo
ZSBhbHBoYSBjaGFubmVsIGNhbiBiZSBpZ25vcmVkLCBDT05TVF9CTEQgbXVzdCBiZSBlbmFibGVk
DQo+ICsJICogZm9yIFhSR0IgZm9ybWF0LCBvdGhlcndpc2UgT1ZMIHdpbGwgc3RpbGwgcmVhZCB0
aGUgdmFsdWUgZnJvbSBtZW1vcnkuDQo+ICsJICogRm9yIFJHQjg4OCByZWxhdGVkIGZvcm1hdHMs
IHdoZXRoZXIgQ09OU1RfQkxEIGlzIGVuYWJsZWQgb3Igbm90IHdvbid0DQo+ICsJICogYWZmZWN0
IHRoZSByZXN1bHQuIFRoZXJlZm9yZSB3ZSB1c2UgIWhhc19hbHBoYSBhcyB0aGUgY29uZGl0aW9u
Lg0KPiArCSAqLw0KPiArCWlmIChibGVuZF9tb2RlID09IERSTV9NT0RFX0JMRU5EX1BJWEVMX05P
TkUgfHwgIXN0YXRlLT5iYXNlLmZiLT5mb3JtYXQtPmhhc19hbHBoYSkNCj4gKwkJcmV0dXJuIHRy
dWU7DQo+ICsNCj4gKwlyZXR1cm4gZmFsc2U7DQo+ICt9DQo+ICsNCj4gIHUzMiBtdGtfb3ZsX2dl
dF9ibGVuZF9tb2RlcyhzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICB7DQo+ICAJc3RydWN0IG10a19k
aXNwX292bCAqb3ZsID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+IEBAIC00MDEsNiArNDE4LDI5
IEBAIHZvaWQgbXRrX292bF9sYXllcl9vZmYoc3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZCBp
bnQgaWR4LA0KPiAgCQkgICAgICBESVNQX1JFR19PVkxfUkRNQV9DVFJMKGlkeCkpOw0KPiAgfQ0K
PiAgDQo+ICt1bnNpZ25lZCBpbnQgbXRrX292bF9nZXRfYmxlbmRfbW9kZShzdHJ1Y3QgbXRrX3Bs
YW5lX3N0YXRlICpzdGF0ZSwgdW5zaWduZWQgaW50IGJsZW5kX21vZGVzKQ0KPiArew0KPiArCXVu
c2lnbmVkIGludCBibGVuZF9tb2RlID0gRFJNX01PREVfQkxFTkRfQ09WRVJBR0U7DQo+ICsNCj4g
KwkvKg0KPiArCSAqIEZvciB0aGUgcGxhdGZvcm1zIHdoZXJlIE9WTF9DT05fQ0xSRk1UX01BTiBp
cyBkZWZpbmVkIGluIHRoZSBoYXJkd2FyZSBkYXRhIHNoZWV0DQo+ICsJICogYW5kIHN1cHBvcnRz
IHByZW11bHRpcGxpZWQgY29sb3IgZm9ybWF0cywgc3VjaCBhcyBPVkxfQ09OX0NMUkZNVF9QQVJH
Qjg4OA0KPiArCSAqIGFuZCBzdXBwb3J0cyBwcmVtdWx0aXBsaWVkIGNvbG9yIGZvcm1hdHMsIHN1
Y2ggYXMgT1ZMX0NPTl9DTFJGTVRfUEFSR0I4ODg4Lg0KPiArCSAqDQo+ICsJICogQ2hlY2sgYmxl
bmRfbW9kZXMgaW4gdGhlIGRyaXZlciBkYXRhIHRvIHNlZSBpZiBwcmVtdWx0aXBsaWVkIG1vZGUg
aXMgc3VwcG9ydGVkLg0KPiArCSAqIElmIG5vdCwgdXNlIGNvdmVyYWdlIG1vZGUgaW5zdGVhZCB0
byBzZXQgaXQgdG8gdGhlIHN1cHBvcnRlZCBjb2xvciBmb3JtYXRzLg0KPiArCSAqDQo+ICsJICog
Q3VycmVudCBEUk0gYXNzdW1wdGlvbiBpcyB0aGF0IGFscGhhIGlzIGRlZmF1bHQgcHJlbXVsdGlw
bGllZCwgc28gdGhlIGJpdG1hc2sgb2YNCj4gKwkgKiBibGVuZF9tb2RlcyBtdXN0IGluY2x1ZGUg
QklUKERSTV9NT0RFX0JMRU5EX1BSRU1VTFRJKS4gT3RoZXJ3aXNlLCBtdGtfcGxhbmVfaW5pdCgp
DQo+ICsJICogd2lsbCBnZXQgYW4gZXJyb3IgcmV0dXJuIGZyb20gZHJtX3BsYW5lX2NyZWF0ZV9i
bGVuZF9tb2RlX3Byb3BlcnR5KCkgYW5kDQo+ICsJICogc3RhdGUtPmJhc2UucGl4ZWxfYmxlbmRf
bW9kZSBzaG91bGQgbm90IGJlIHVzZWQuDQo+ICsJICovDQo+ICsJaWYgKGJsZW5kX21vZGVzICYg
QklUKERSTV9NT0RFX0JMRU5EX1BSRU1VTFRJKSkNCj4gKwkJYmxlbmRfbW9kZSA9IHN0YXRlLT5i
YXNlLnBpeGVsX2JsZW5kX21vZGU7DQo+ICsNCj4gKwlyZXR1cm4gYmxlbmRfbW9kZTsNCj4gK30N
Cj4gKw0KPiAgdW5zaWduZWQgaW50IG10a19vdmxfZm10X2NvbnZlcnQodW5zaWduZWQgaW50IGZt
dCwgdW5zaWduZWQgaW50IGJsZW5kX21vZGUsDQo+ICAJCQkJIGJvb2wgZm10X3JnYjU2NV9pc18w
LCBib29sIGNvbG9yX2NvbnZlcnQsDQo+ICAJCQkJIHU4IGNscmZtdF9zaGlmdCwgdTMyIGNscmZt
dF9tYW4sIHUzMiBieXRlX3N3YXAsIHUzMiByZ2Jfc3dhcCkNCj4gQEAgLTUyOSw3ICs1NjksNyBA
QCB2b2lkIG10a19vdmxfbGF5ZXJfY29uZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQg
aW50IGlkeCwNCj4gIAl1bnNpZ25lZCBpbnQgcm90YXRpb24gPSBwZW5kaW5nLT5yb3RhdGlvbjsN
Cj4gIAl1bnNpZ25lZCBpbnQgb2Zmc2V0ID0gKHBlbmRpbmctPnkgPDwgMTYpIHwgcGVuZGluZy0+
eDsNCj4gIAl1bnNpZ25lZCBpbnQgc3JjX3NpemUgPSAocGVuZGluZy0+aGVpZ2h0IDw8IDE2KSB8
IHBlbmRpbmctPndpZHRoOw0KPiAtCXVuc2lnbmVkIGludCBibGVuZF9tb2RlID0gc3RhdGUtPmJh
c2UucGl4ZWxfYmxlbmRfbW9kZTsNCj4gKwl1bnNpZ25lZCBpbnQgYmxlbmRfbW9kZSA9IG10a19v
dmxfZ2V0X2JsZW5kX21vZGUoc3RhdGUsIG92bC0+ZGF0YS0+YmxlbmRfbW9kZXMpOw0KDQpJbiBb
MDIvNDJdLCB5b3UgYWRkIHRoZXNlIHN0YXRlbWVudC4NCg0KKyAgICAgICBpZiAob3ZsLT5kYXRh
LT5ibGVuZF9tb2RlcyAmIEJJVChEUk1fTU9ERV9CTEVORF9QUkVNVUxUSSkpDQorICAgICAgICAg
ICAgICAgICBjb24gPSBtdGtfb3ZsX2ZtdF9jb252ZXJ0KGZtdCwgYmxlbmRfbW9kZSwNCisgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG92bC0+ZGF0YS0+Zm10
X3JnYjU2NV9pc18wLCB0cnVlLCBPVkxfQ09OX0NMUkZNVF9TSElGVCwNCisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE9WTF9DT05fQ0xSRk1UX01BTiwgT1ZM
X0NPTl9CWVRFX1NXQVAsIE9WTF9DT05fUkdCX1NXQVApOw0KKyAgICAgICBlbHNlDQorICAgICAg
ICAgICAgICAgICBjb24gPSBtdGtfb3ZsX2ZtdF9jb252ZXJ0KGZtdCwgRFJNX01PREVfQkxFTkRf
Q09WRVJBR0UsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBvdmwtPmRhdGEtPmZtdF9yZ2I1NjVfaXNfMCwgdHJ1ZSwgT1ZMX0NPTl9DTFJGTVRfU0hJRlQs
DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBPVkxfQ09O
X0NMUkZNVF9NQU4sIE9WTF9DT05fQllURV9TV0FQLCBPVkxfQ09OX1JHQl9TV0FQKTsNCg0KQW5k
IGhlcmUgeW91IGNoYW5nZSBkZWZpbml0aW9uIG9mIGJsZW5kX21vZGUsIHNvIHRoZXNlIHN0YXRl
bWVudCBjb3VsZCBiZSBzaW1wbGlmaWVkIGFzDQoNCisgICAgICAgY29uID0gbXRrX292bF9mbXRf
Y29udmVydChmbXQsIGJsZW5kX21vZGUsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgb3ZsLT5kYXRhLT5mbXRfcmdiNTY1X2lzXzAsIHRydWUsIE9WTF9DT05fQ0xSRk1UX1NISUZU
LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE9WTF9DT05fQ0xSRk1UX01BTiwg
T1ZMX0NPTl9CWVRFX1NXQVAsIE9WTF9DT05fUkdCX1NXQVApOw0KDQoNCj4gIAl1bnNpZ25lZCBp
bnQgaWdub3JlX3BpeGVsX2FscGhhID0gMDsNCj4gIAl1bnNpZ25lZCBpbnQgY29uOw0KPiAgDQo+
IEBAIC01NTQsMTcgKzU5NCw4IEBAIHZvaWQgbXRrX292bF9sYXllcl9jb25maWcoc3RydWN0IGRl
dmljZSAqZGV2LCB1bnNpZ25lZCBpbnQgaWR4LA0KPiAgCQkgKiBGb3IgYmxlbmRfbW9kZXMgc3Vw
cG9ydGVkIFNvQ3MsIGFsd2F5cyBlbmFibGUgYWxwaGEgYmxlbmRpbmcuDQo+ICAJCSAqIEZvciBi
bGVuZF9tb2RlcyB1bnN1cHBvcnRlZCBTb0NzLCBlbmFibGUgYWxwaGEgYmxlbmRpbmcgd2hlbiBo
YXNfYWxwaGEgaXMgc2V0Lg0KPiAgCQkgKi8NCj4gLQkJaWYgKGJsZW5kX21vZGUgfHwgc3RhdGUt
PmJhc2UuZmItPmZvcm1hdC0+aGFzX2FscGhhKQ0KPiArCQlpZiAoc3RhdGUtPmJhc2UucGl4ZWxf
YmxlbmRfbW9kZSB8fCBzdGF0ZS0+YmFzZS5mYi0+Zm9ybWF0LT5oYXNfYWxwaGEpDQo+ICAJCQlj
b24gfD0gT1ZMX0NPTl9BRU47DQo+IC0NCj4gLQkJLyoNCj4gLQkJICogQWx0aG91Z2ggdGhlIGFs
cGhhIGNoYW5uZWwgY2FuIGJlIGlnbm9yZWQsIENPTlNUX0JMRCBtdXN0IGJlIGVuYWJsZWQNCj4g
LQkJICogZm9yIFhSR0IgZm9ybWF0LCBvdGhlcndpc2UgT1ZMIHdpbGwgc3RpbGwgcmVhZCB0aGUg
dmFsdWUgZnJvbSBtZW1vcnkuDQo+IC0JCSAqIEZvciBSR0I4ODggcmVsYXRlZCBmb3JtYXRzLCB3
aGV0aGVyIENPTlNUX0JMRCBpcyBlbmFibGVkIG9yIG5vdCB3b24ndA0KPiAtCQkgKiBhZmZlY3Qg
dGhlIHJlc3VsdC4gVGhlcmVmb3JlIHdlIHVzZSAhaGFzX2FscGhhIGFzIHRoZSBjb25kaXRpb24u
DQo+IC0JCSAqLw0KPiAtCQlpZiAoYmxlbmRfbW9kZSA9PSBEUk1fTU9ERV9CTEVORF9QSVhFTF9O
T05FIHx8ICFzdGF0ZS0+YmFzZS5mYi0+Zm9ybWF0LT5oYXNfYWxwaGEpDQo+IC0JCQlpZ25vcmVf
cGl4ZWxfYWxwaGEgPSBPVkxfQ09OU1RfQkxFTkQ7DQo+ICAJfQ0KPiAgDQo+ICAJLyoNCj4gQEAg
LTU5MCw2ICs2MjEsOSBAQCB2b2lkIG10a19vdmxfbGF5ZXJfY29uZmlnKHN0cnVjdCBkZXZpY2Ug
KmRldiwgdW5zaWduZWQgaW50IGlkeCwNCj4gIA0KPiAgCW10a19kZHBfd3JpdGVfcmVsYXhlZChj
bWRxX3BrdCwgY29uLCAmb3ZsLT5jbWRxX3JlZywgb3ZsLT5yZWdzLA0KPiAgCQkJICAgICAgRElT
UF9SRUdfT1ZMX0NPTihpZHgpKTsNCj4gKw0KPiArCWlmIChtdGtfb3ZsX2lzX2lnbm9yZV9waXhl
bF9hbHBoYShzdGF0ZSwgYmxlbmRfbW9kZSkpDQoNCmlmIChtdGtfb3ZsX2lzX2lnbm9yZV9waXhl
bF9hbHBoYShzdGF0ZSwgc3RhdGUtPmJhc2UucGl4ZWxfYmxlbmRfbW9kZSkpDQoNClJlZ2FyZHMs
DQpDSw0KDQo+ICsJCWlnbm9yZV9waXhlbF9hbHBoYSA9IE9WTF9DT05TVF9CTEVORDsNCj4gIAlt
dGtfZGRwX3dyaXRlX3JlbGF4ZWQoY21kcV9wa3QsIHBpdGNoX2xzYiB8IGlnbm9yZV9waXhlbF9h
bHBoYSwNCj4gIAkJCSAgICAgICZvdmwtPmNtZHFfcmVnLCBvdmwtPnJlZ3MsIERJU1BfUkVHX09W
TF9QSVRDSChpZHgpKTsNCj4gIAltdGtfZGRwX3dyaXRlX3JlbGF4ZWQoY21kcV9wa3QsIHNyY19z
aXplLCAmb3ZsLT5jbWRxX3JlZywgb3ZsLT5yZWdzLA0KPiANCg0K
