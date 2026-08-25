Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49241C61DB6
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 08:15:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5B8A10E963;
	Tue, 25 Aug 2026 08:15:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="I9E//9hG";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="NNzg6Ws4";
	dkim-atps=neutral
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36B3C10E967
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 08:15:16 +0000 (UTC)
X-UUID: 17a4ebe4a05d11f1b1788b6acf885367-20260825
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=lEDGa+YiFhnsJf7VOYk0Dkb0U+89m6XL+uW8VMIkT/c=; 
 b=I9E//9hG4qKnPRyqpoKeujvtFaf/vU3NnciwpM0xVHznjcIsEFWqZ8dLUk1IHK7l0+LmxJH1CA2YYHY9cefXPPE4MiW3p9rjnEQACjN+eJR6aiviFReJBzSentolfGj6ea5GBqeGTkLPiYyv6OwZiJx7DEADx0h/kS56GYOSs2E=;
X-CID-CACHE: Type:Local,Time:202608251615+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:2522a049-2f6f-4216-af58-65fcbcadd3a2, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:7db8b62, CLOUDID:52e02d34-3db0-43f0-93e4-5f75d4b038b8,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
 1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 17a4ebe4a05d11f1b1788b6acf885367-20260825
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1293362380; Tue, 25 Aug 2026 16:15:11 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Aug 2026 16:15:10 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 25 Aug 2026 16:15:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/OQ5QftNbvq2akXoqCK5Zahm7nhWo0CVbEDDTC4p5whTdgH7yoHSm0j9bjZcB6fl6Fa97/1YfforaF/hTBMNbxnYKlqcQZXc2mmO1B7RsIWA+TZJ2dCfQLE8kUOwbF0yzcMuHAuNNqiqq3a07RDL1Xbmope931NGj0nLzpKtQyLmyZp8/rNsogQyiH0gM09NTPxMFBMi7FkLNGBVHI4Q9EI8p/d1w/mlaD+N1Q21eG36DGejql+S3B67x2aU0xL+YO/FxOoAsRDW4znLjJk9YuSNjym3o34osA1MZMF5ttfoB+E1agb0ZtnUBUfDTkQUXRwS+XYOftkTZddNVDbsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEDGa+YiFhnsJf7VOYk0Dkb0U+89m6XL+uW8VMIkT/c=;
 b=IfVTaKvY3kIeq+GU3FXKOmiHxGz8YkNHq1ClB+2m7F6fiNxIX9bdA3oe83bV59gnjV9eChbDdJ/zxApfNUYe8X1fVae98TunW+5JztOB2d1YDCW9+gYZu5WoCnkldP+GxVKiRVSEDdwXOx4YmTq6dAg6l7FPSXEDy5MQ6ytgGF3kzTLhibvYuTT0zeSu6OSGlees3ojHihuSQud7d47j6MUoBdveBBKqJBnG6yXZpeVbRAxTFbW+2csK+hlOD4OYec2aXs597hnmN11Brx9jjcGyE228u6THIqzZL+icK6qX6j2JTEJZ1ZuCpD8e22OlSH6Nbr6rzJ4TsHI80V/FuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEDGa+YiFhnsJf7VOYk0Dkb0U+89m6XL+uW8VMIkT/c=;
 b=NNzg6Ws41mrnb9p5t1uWGEWj8PhPD4LP+iTlh9fCQvZEzGDacN0339dFfqwkWs4kYKZP68qweK9xFbzYHMPab/BQWo5dgok3s8P5/eF2ptBxLgi/UqYMMt8dDYgWr7+tnmJ4aUEsmWWbdEtEuGKljRjRfuIEP25Gtob57VMgUcM=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB6961.apcprd03.prod.outlook.com (2603:1096:101:bf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 08:15:05 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 08:15:05 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "kernel@collabora.com" <kernel@collabora.com>, "robh@kernel.org"
 <robh@kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "mripard@kernel.org"
 <mripard@kernel.org>, =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?=
 <jitao.shi@mediatek.com>, "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "p.zabel@pengutronix.de"
 <p.zabel@pengutronix.de>, "airlied@gmail.com" <airlied@gmail.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
 <matthias.bgg@gmail.com>, =?utf-8?B?SnVzdGluIFllaCAo6JGJ6Iux6IyCKQ==?=
 <Justin.Yeh@mediatek.com>, =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?=
 <Jason-JH.Lin@mediatek.com>
Subject: Re: [PATCH v6 01/11] dt-bindings: display: mediatek: dsc: Add MT8196
 compatible
Thread-Topic: [PATCH v6 01/11] dt-bindings: display: mediatek: dsc: Add MT8196
 compatible
Thread-Index: AQHdFGHq/9pJRMM9AEK1x1I6IXVcBrauquYA
Date: Tue, 25 Aug 2026 08:15:05 +0000
Message-ID: <79d8f0b15d924633f0a89492c52f8ad056cb8de4.camel@mediatek.com>
References: <20260715135703.46540-1-angelogioacchino.delregno@collabora.com>
 <20260715135703.46540-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260715135703.46540-2-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB6961:EE_
x-ms-office365-filtering-correlation-id: 2176d937-b21e-4bec-09aa-08df0280f837
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|7416014|42112799006|366016|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: igkx+cMPdpzX4+QrM1tOtroM0DzxFF/PbbqJdp7qqrfP4nD0y7/gdNh4dWLUTjhVMq6QdV8NV8OL55ywePTHwxGJUpahlahML0oQClEtfIwXrj0k4iMXdB6LetNIdOht+WvmSydiVR7H4Ra7bnCO0Uja4uWP0vlj7D4Q+lRICJlvmkG/0aJRBw9u1D1mUWbBDVh3kNW8q8t6slZxfNHHKbn4OmsZqyBEkoidx8F7Xld1JgrbyAV2lqRam1a62z62NM6O0NU6Lj4FEeAOR0sopn3gw105Ks2ytwqaC/PPWOjSxbKQDjpwdJeBmJNjhU4jt+xpecgVSGbZ9K9yW2eZVNXLIm+yZZ0YqlO2Yuyj8+Zi6OQZCeT6GxLknMCoKKkfOTBMVTQJQ0ozPdvmsRD9PvHsq1Pz6qLd68aFKxmd5fvKzcnzbdPzavo63fUI3hSADSjxbFepHk5Y/8P6Kyhh/TEQxkG72YPzIx+YsD4KUCHsPoWF3+X/Tgms/buwieQ1uYGZQHB8/kt5G87dRRBrVynvFB7mUvw1fWZ0PUdok7juY5nIVn0a0fL3x5zEORY87gsBTu6/rv3XMuQOLF2wb/9RX89KX9UHJ4fETv0XikUOXJzB51GGwldbbYvzg4GilQbpECFvwTTj8srj5XYUGjfoecPwMXCfAL1MkExSxq2ohm20ZusU/jTqd64UVOaJcRsnCbw/qqPmtYYS+HQoy7DUEvnNnBzAS555tZpHRkQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(42112799006)(366016)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1FTcEFMR1JRa25adVV6Rmt2QTMyQUhTcTQxQkxsQlBnK1RGSHNOQkJSaUN5?=
 =?utf-8?B?L3pUeDMrbTBtNkpSS2xDYi9pNkkvM3BEYjJHSW1ldHNzNVk1OUcwcUZxZjZJ?=
 =?utf-8?B?WUR6cmFFTmFMcmt0bHNNTjNRdUxpWGZnODFLSE5nTlkzeUd2YytNayttY1hp?=
 =?utf-8?B?YmtDeHZuR0ZlV3YrUC9YenFFVUpWRTYrekxxaWNTZUd2TjlWRitFZ0ZSM2Yw?=
 =?utf-8?B?d25rUHBNc2x0aVh1Tm81Y0JOZUMvYWZXL25Uc3RnYUZOSTVqVVFFdG5lYXJu?=
 =?utf-8?B?eEhqb0p0MmNucWN6elJyT2p1SVQ5QkxBT0ppQ3FuWGVMcU9FL3lJV1JUR1Mz?=
 =?utf-8?B?TFFGdnVram9ZK3h2QmR3Zks5cXdvTGFLS0VYaThoYjVvcmptMWQwb29KckpU?=
 =?utf-8?B?amNQTWsxSElZUzJGc0ZXMTByVVBNdkk4Nm9ma0FSVlpyOVp3QzdoaElCWDIx?=
 =?utf-8?B?VS9iQ2dEYlozUzhmekFkV01OL3pDRjlIRU5uaWNzaHRRVkEwalg4dkZKZWEw?=
 =?utf-8?B?Y0owUGN3WkhHRE9BWmMwNWN2cytiWUk0d3haNjZsUkpZTEQzTGkzMlNNSmtt?=
 =?utf-8?B?NFM2aGJaeWJIa2VrRWc2blBjRDBJWGtvSkdaUldSMm5iRWV3WmtNRi9lZmM0?=
 =?utf-8?B?UzEzaDNDU1M0Q0VRSWdxa3Uwa05tZTJ0RWkyVkFFOHFNU3pXRVY0dEVKSWlK?=
 =?utf-8?B?UjYyd2hOSllpVHQ3ZmMxM3VoNmltR1NZMThyc3VKdVRJVFpXOTYycGkrS2lO?=
 =?utf-8?B?MFRWZXFyTEZMY0tHb2ZMaDRYWjh0cHh6WGs5elJOaTZBdURTYkZvS3A5dSsv?=
 =?utf-8?B?cGdYOVcraHZpL1ZVVjdjaGZQTFBJdnNnNHdCRXNkNVBHTkdwNVdDNXhOZjU3?=
 =?utf-8?B?Z2s4cmFZRlc2MFI2cktKcEszMGpVZS9nbHZzM3ZzSjV6Mll0a2lYMEIrVm05?=
 =?utf-8?B?bnZwaHN1dmV0djdwREw0VkcvUGhFdTUvMkt5THJ2THBDVlZZMHM2dWlNdUNZ?=
 =?utf-8?B?VkZ6aU5OYU9ZNmVCMHFJTXVyK0VGWXJmNWF6MFVZaHdsMlFlZ296K3RpLysx?=
 =?utf-8?B?MHdEU3JuVmRTTVJLVXJ2VVFiLzA5RURuU2lrTSs4QW9YYlNzRHZObk5KaDV5?=
 =?utf-8?B?blR3N3BxZHd6ZUZaeEY0T2lsYzRkZ2pxdFVoQXkyZ2J4VlNCVmYxNHVtWmZ4?=
 =?utf-8?B?WWhURE9NRGoxRjBlQ3pJVkc1YWFTTHpiQTBmNjNkS3V3dTZqaHBaZVVMYU9k?=
 =?utf-8?B?SEpNRnVmdjc2cDlaalROVDJlN0lmSTlEbHN5VzhLdkRkdnVvaTA3RXhVaWZC?=
 =?utf-8?B?VTVaV3hWNzVhVTdqWkJOaXZJQVFOS0d3ZjFQM2U1bCttbld2bnZKelFOeGJG?=
 =?utf-8?B?bk1KMDA0U04vQ2RYdEttakZHKzFKSGFNeUxTd0xRVHdPRTFobjBrZm5ia01V?=
 =?utf-8?B?VW94d2NvYnBJKzFvZE1GbWlGU1FNd2Zoam80eUNMbkp4SkNpQXY4WFh6aENC?=
 =?utf-8?B?UTZUTGhCSklWbE1XR2E0bXNGclhINFdSbVluOVlPL0I4Z2ZOOVFjTnhDbGNi?=
 =?utf-8?B?Sk9nNXcvc0piYmVZV0R5MmVSRDlmSFFETCtSSjJmdU80RFAwM3ViVlpUMU5M?=
 =?utf-8?B?Z1hwVjQ0SUhGUTBiZFRhQW04MHQxWURTbFNDbGZCc2tlR2pWa0h4aXhqd3Ew?=
 =?utf-8?B?ajBWMU15M00raUlHdXZoOU9aTDJSZmlHQ0RtSUNqendGOVRZZUhqTFo4OVo2?=
 =?utf-8?B?WHljeDlXclRoS3dJTWswN2w2aHFoYTl3TTFkaXQ4eXZCRlF5SUtJWjRkeDdv?=
 =?utf-8?B?WmJuQkhpaVFkbSs0ZG9uaWxRMEVOMTc1TnpsdSt1VU9QVm11Rm9LK2xyYWxC?=
 =?utf-8?B?YXptMFRTMTVTZnljRDBMc2FabEVwMXJUR09USEVEQzN4TDVWQnJUSEJDeTlS?=
 =?utf-8?B?UktUTENmYUdZQTBOZzhQdXU4UTZUNFJ4b0IzdmpyVlc1U3BpdjZRWHp6YlNk?=
 =?utf-8?B?ckVJK0x2T0ViNlJjK09BV1Z4SmRLVEV2aFZ6d1F0aWhlNGVyM05JaERHMk5Q?=
 =?utf-8?B?SC9QdCttZzRTQzdxck9jL0dCMm9VOSs2dVBVZzM4SG43Z0I5WUpkK3NnYlRW?=
 =?utf-8?B?T1RzY0hmckl5UzVEdGM3T0xwWDZwQjQ5VGUwTHU1ZmRrcWJHb3FqMlhLZE1V?=
 =?utf-8?B?Tm1ZVmROZGJPUXVWMkZNSWl3TWM4b04xUkV3QUNDWWpOdkpjTTdCTWRRUmVt?=
 =?utf-8?B?ZVp1Y04rWG91MlU4dVRYaTZ4WTRVRVIrNExjVC9mcndJMzJpZno4SXk2NFp6?=
 =?utf-8?B?Q2JYS1hMNnY5dUg3RVlPVG1pK2dxVENKclFJcGE3cGJaNGpSdDN2QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCE7A8120B1B4C4AB640D78BC900BA86@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: O+3JubRsGdZZ3u7or0xPS692UdlUpPFNBxnBm/x+aEasIxCQcn8EY6KJWkZxgBf0oMXClW+lJyk2/DlgVqJKlXgpcaoSey6G8M1SpMujsYAPx/oHCTO53ZkdUnq7qShnopQsa2z6Mx8QE7MHU7VMhA5yX1moOWlQCDs9JDexFIaUVnROq8bHmSeJ4ioiervR5HZHG+NFT+R6C7I79q7qkjuTW4C8PUJgWYxTcw7t2+IhipKgnh3mDF1DRfhv91f3ayTd5XO6JCpT23C9KXUMfBBb6uhutZzf9IuD5Dzvbz38ZRYaIVL1n+h8wVtAnSaTgl6Z54/Kh9vftp9D9+ArCQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2176d937-b21e-4bec-09aa-08df0280f837
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 08:15:05.2693 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8kl39cGKJ6oorp1qM65LuT8MOp+EE0y0v8WYaUKp0gN+DMrypcieBv9b0Ba21vxG2gcClXXkWE9pZpuRl/HcEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6961
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

T24gV2VkLCAyMDI2LTA3LTE1IGF0IDE1OjU2ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gQWRkIGNvbXBhdGlibGUgZm9yIHRoZSBEaXNwbGF5IFN0cmVhbSBDb21w
cmVzc2lvbiAoRFNDKSBJUCBmb3VuZA0KPiBpbiB0aGUgZGlzcGxheSBjb250cm9sbGVyIG9mIHRo
ZSBNVDgxOTYgU29DLg0KPiANCj4gVGhpcyBJUCBpcyBjb21wYXRpYmxlIHdpdGggdGhlIG9uZSBm
b3VuZCBpbiBNVDgxOTUuDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29t
Pg0KDQo+IA0KPiBBY2tlZC1ieTogUm9iIEhlcnJpbmcgKEFybSkgPHJvYmhAa2VybmVsLm9yZz4N
Cj4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPGFuZ2Vsb2dpb2Fj
Y2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gLS0tDQoNCg==
