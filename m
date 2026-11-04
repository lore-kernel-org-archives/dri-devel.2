Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90263606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 09:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=harNtsEK;
	dkim=pass (1024-bit key, unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=N5p2v3Nu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED96410E887;
	Wed,  4 Nov 2026 09:47:18 +0000 (UTC)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4685210EA1E
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 09:47:07 +0000 (UTC)
X-UUID: a4ef37b6d83411f1b1788b6acf885367-20261104
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=4Z6Pus2Kvn+kan+gg7WSVGVweI1s1elFxvHy1itE7gc=; 
 b=harNtsEKABwk6NAtsiKXc6gKWbKwU/dZMSOkmHWhftOFepIw7u5G+WJM9uGveDIb8iiZ0u2UNqkjK8MYpRHY/LiNbN3xH40mp99ahsuwA3SW+cFU1hv5hCFYvf2PxcJJSgwT15sLwoM2WITBnxdFcoHC6DyAzYyCupJu3/pvQkw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21, REQID:73cdb609-6261-4356-8b4f-42ecd271f0cf, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:b0318ac, CLOUDID:3d8a61bb-4006-44bb-949c-6e25a7b8dad4,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|136|836|865|888|898,TC
 :-5,Content:0|15|50|99,EDM:-3|-100,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:
 nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
 C:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a4ef37b6d83411f1b1788b6acf885367-20261104
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1986957966; Wed, 04 Nov 2026 17:46:44 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 4 Nov 2026 17:46:43 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 4 Nov 2026 17:46:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oiYRM5g9Yxk85mZpndXGEw2JJs6qbWRqAD0JKdHytJkMHbVSIkstkueNhKbURKeLY9qqX4OlhUS/AuAlx9pm9dt2vLELAcPFUkmD+Y44Lee6fAi6BGbIdUuuyYGHWyP/DqXjbPhnqTvodBYMskosGZWKSKoaMpXc4I482AoV0hc0JRtCgNG3wXijB5KL1VhUQbf3gd21c/PVlqlwLE5h08kz9B9StwGW1npTs73lhQeVUd9vB0usTmfBH6cdMzCZpU1oMow17RAtiKGAbrwYSTRxSQQaS9hFcaKkldsuMSNUtr+kZbMsbRnakjowVlQ5NCMLp1xiMvzUq/XxBFX7BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Z6Pus2Kvn+kan+gg7WSVGVweI1s1elFxvHy1itE7gc=;
 b=DcztO1rZY/b/qfaqAe8wRzq0dCjK5ABzRiu8ZMQG8hhkOpFa6idWZDhmI1FmdqPeHNsAgXXx/o/hXWlUjj/y7gf3KZQe4K2DJDGr7zppHR14y+u6Z4ISLp0T1bdW8/kV9HePFTqWMYzA6qJlImCzqS9MVRSyfZEf3Pp/k56CEjIWUkcDMIbzf6of27IAHQtCtQIEyq1bkz9y0Y9im579mXvTpxwA+o9Q5H03vz9e4Rx3U1CcWgbXZ2R97XVFyCSeZVsm/TA2BTuzdBc54wtRvDX5EeVWnmviHCHsbBVUh/O4cXkWr/bmLf6jwtGWel7Brht9/zq3xynKC8s0A9eNLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Z6Pus2Kvn+kan+gg7WSVGVweI1s1elFxvHy1itE7gc=;
 b=N5p2v3Nu79EeD5fHzCeiVmsBVznzBbOzwz60Wd0TrR4HdFbAcFJe/iOmK8vaCa+Dwd89dH0Z6eFXr3NO5sBX0sUVtkqE+3W3XLzxs8xk/fdirIMMMnlL5Zg4yeX5Ihs0yLWPSpWnuxdQDyntYTSnotgSMbdj9rcwu6OaQSwQp6M=
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com (2603:1096:d10:91::20)
 by TYPPR03MB9474.apcprd03.prod.outlook.com (2603:1096:405:319::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 09:46:39 +0000
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b]) by KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 09:46:39 +0000
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
Subject: Re: [PATCH v2 17/46] drm/mediatek: Add support for hardware
 multi-stage layers
Thread-Topic: [PATCH v2 17/46] drm/mediatek: Add support for hardware
 multi-stage layers
Thread-Index: AQHdE4ZpXGufC+fzVEK+W4y8i9Wdb7ceW7kA
Date: Wed, 4 Nov 2026 09:46:38 +0000
Message-ID: <10e114d1f682a24e5eeb29ef03980762fb9712ba.camel@mediatek.com>
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-18-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260714114414.184512-18-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR03MB9902:EE_|TYPPR03MB9474:EE_
x-ms-office365-filtering-correlation-id: bac08da4-fdcc-46ce-a086-08df3a58860f
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|42112799006|23010399003|366016|1800799024|6133799003|10067099003|22082099003|18002099003|3023799007|38070700021|56012099006|5023799004|4143699003|11063799006|261022105027099003|261022075727099003|261102123227099003|261026140227099003|261026121527099003|261028144727099003|261021123027099003|261021121427099003|261009223027099003;
x-microsoft-antispam-message-info: aM9YDWsUAyPDDmgrgH60h0p5UHxFS6NWD0x2F4FyPBRJxPoTPvkzBqzi0KV62EXBpyJb+k6TYPiaD9Swx2o2ckrqQzPWRcM8pRR37eSMp7tR5ZeZDqHg79GoJhmDyjgQwdfl3hFJe28XKXH1C3/1J75CjNNP5+EYQbYm/DhQDNOVtLdeZhguG2vEQlKxsyTtoUUtm7ED9lCQ6JjT+Aw509MacH0btMwRiZQztn+A0qCniO6Fh2DY7sWKJOz4aQx/2W1CTDW3MsY2lps/g8SzwioaUgcX0EyVIk6ikPJHqq7bcldtUaORr7kzqiYF2pi1hZAL7W9Z+aiHOt09xIYfSqGfsMAEMZUc4i0RyJK04MIU3OtpBRMyrS9poRd9Qu66mR72kC4L/IHOcs544jlAbu7mxhZljF3I6nWDCKetxraraG/2YHkkXiKrTrBSlrhJ0Quac9ql8LDaR0yot719p0L6OzK10asjBwUNwYVrn/pihIDZL1cvu5+atgb8mthj2YK6aBdHBVIkcTkZfY/7cMphyC7WQGtj0n9uC6ee45tfHimxOvyiZqlDBdo5Js61GPQe1PaD4SFSJ14t0sPnTkHuY5jDpJB/oHD+qQJfpZZLMzbqf2igdKa3JwQPMslBmJHbn3BegmOw6rlP9whwP/djtq/Uutyjied9lNleWy0/H4HRY2xlGnW8C0BTHfg0DaGsSCJYdu+o9Kg/vqFYqEQ7aavAyjEKA7Ks2k9r1P0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUYPR03MB9902.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(42112799006)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(3023799007)(38070700021)(56012099006)(5023799004)(4143699003)(11063799006)(261022105027099003)(261022075727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VCtXbDVQWk5KVmJseHAyL2xCN1ZQdWJyRDJKWE9vTldTdC8zMThzSXdIZGRl?=
 =?utf-8?B?aXhMZ0Z1SmZGNm5DV2RXS1NuT0s0Z044YjhTbG9YVVJURVByeENTM0syTGdh?=
 =?utf-8?B?c1dOTDhnbUVMdWdPc05YSW9sVVJJQWdKeWMvcVQ4Yi9YWDBLL242dWhOSm9B?=
 =?utf-8?B?UEJzOXoxMVQxZ0dBNG5mMkVJWUlReDg5VjJwa0pMZ1FKbGJTQjZVdlk1cit5?=
 =?utf-8?B?THB4cnlxOUI2dEJpUjFnUDF0ekZuU2p5aEtWZnE1OU9SLytSWG1Pc3J6ZW9n?=
 =?utf-8?B?Vm9xb1BQTmVsdGdkZDlnR3NSMmkwVWM4aDVialduSS9XeTRLNmR5czNxVk5r?=
 =?utf-8?B?UlZ3cjhQNWR4VThOWi9hbFgxS2JheklONnRIVHNTWGNvbVlYQnQzeXNXRUtq?=
 =?utf-8?B?aUIxQ092NVBaYmhBRjdmb3ZCWmdScEdXYlhIWmNlNkl6R2NMTzd0SUpGb1U5?=
 =?utf-8?B?cVY2eVBBcnZvQUpzalB6ZWFYcmM5N3FaWlY1dTR1OXpBUHA4RjkzME9IdlNk?=
 =?utf-8?B?SnV2Z1dlMmNGVG5lMXFwam9pekJIa3gvdU9pbVdRU3Q0VjJDWldycGJiZkVD?=
 =?utf-8?B?d3ViMlNqK3BRcmJCOGJlNndpZW5MNWVZenJUNGVRNE9wakI0UkhCQUNRT0tC?=
 =?utf-8?B?V0pTaTlSV2VPazZYU1RXRWJGNS9MZnJ1UWVoU1cyNDNMRlFQTVVCWTI0VHJS?=
 =?utf-8?B?R3FPcEZYS2VKRmNvNllxK05qZkFNYitZeDh1VnkycGZ4MzNqZk9mLzB0ZnNt?=
 =?utf-8?B?RGdGTjNtUHd3Rm9aS1JnSHRYeGFQYUtlT2FxanhtbGxXdWhsQURjWTk5ekRp?=
 =?utf-8?B?MXNkYUdZck1kcHQvR3BmRmR0V1BYWkoxNTdoRkN2OFFCTXREREdyY29rbENx?=
 =?utf-8?B?b0UraERubEpOckZmVjR2aFZzOHFNSzZic1FkTXhXcWNyQjNKMExFZlA1T25M?=
 =?utf-8?B?V1QyZUZSTi9YT29VbERoZEtteU1KUW9WVDRZNGRnZFI4NHViY2UxZ083SjNv?=
 =?utf-8?B?cW9NNWdMTk1RSlN5Z2pZSWt1cTBqSm42aDdWUUgrckM5VWE4QVh4WU9jeWJv?=
 =?utf-8?B?T2ZPc1pwYUVKMHArMkFleDVoQzl6cGFjQjZLaHZPSnRrUVN3SnBBRGtFUEk0?=
 =?utf-8?B?b2lrVzlhcFFQZFp5cStYMGFBOGk4L1AvS09ubmpwcTdxcXFRMHJGcWJWMExV?=
 =?utf-8?B?WHk3U0k0clhWQXl5bCt4MGZ2cnZZWm5nTTZ3dEN1cDBHdWtCdExpU3RYamRI?=
 =?utf-8?B?TnYwZXNMOXZOeGpQM1R0aHVwbVNqVmFqenpvdDlyWStyZElMTytJdkJnSXcy?=
 =?utf-8?B?Y2lmdmVGb2RHM0Rmdm5EMjg0ZVd1ZzVRcUJHb1dPa29kaHRWenZLRVlRL1Jv?=
 =?utf-8?B?c1BGQm5yNlh6SDZHL1pheWhycXIzd0xrUGJEdGtzYm1ZWXM2Qy9XU0tuTStH?=
 =?utf-8?B?cGpzbGhxQmwrSjlMVnQ3NUdYZHB2SzNrV0hPN1JHMWtQR2RBWTVpSVpuMTVL?=
 =?utf-8?B?Z0lNWWs1V0FwMGRpbnBaaGZiYjFINzRsVnFQUEFhN21rdDU0OU5uN0JyUUND?=
 =?utf-8?B?c3lDYk0wQ1RhUmJGcGdSR0RreTFiSEhJR1pWK3lDRUJUMzRmUjJ4bGM0UmRt?=
 =?utf-8?B?NURUUDdmMGxQMG1jdlF2N2FjbnlwZ255dEpnZjlOZWVSRmpyOUpFMXpwQVVn?=
 =?utf-8?B?NS9nSmRtSDd0VDlxSDQvTjVhL3p1Rk9qckxEcnJ3VzBEVyt3eXBuZDIxb1ZX?=
 =?utf-8?B?K1lmOUZTaUlOdktxbkNQejc4QUhTdDlXVWVBMTRzKy9ZSGE4RkpuRmhLbnVP?=
 =?utf-8?B?QTZocy9qLzZrY2pMRk52cWEzdE5qVGtNUjllRFBZZEhSN3UyUWZFdGtKT1l1?=
 =?utf-8?B?UHhzMEtaeG94RzNNVElHQmUxZ2sxemtjRXhyKzBsMTdhcTgrS2hPS0FQV0Fh?=
 =?utf-8?B?TkpDR0t4L0tkUjkxVHRlYjUrWmZqWjJ2Tm4zMWtVRjk4MGczOWxYRWl4bmhH?=
 =?utf-8?B?cVhxOCtURzB6Y2VjMU51d2pyS3l1WWwydHFHZnhML0l1TE4zeGgvQzluODVo?=
 =?utf-8?B?OVppTFJOVXNYSVI3OXo3M0NSSUZIWnZNYmdkZW5admFvdlJkTEFVODdCY0dl?=
 =?utf-8?B?Y0pWVHFsRUdoUUVJUkJtZFJwREtaU2tLdExZMThxNTZ5NVBEd2VxWGlpSEhi?=
 =?utf-8?B?MDRjNDYvN2NlbGFZKzZ5aFNrUVFJUnlXeEd1aFBwc1VER2dFWUxvd2RFbWpz?=
 =?utf-8?B?VU9Ecy9kbi92R2daMlNWR1M3bVVYZDg2WkRpT3JqbFZIaGpiQzFET1pUQXlT?=
 =?utf-8?B?TXNXVUZMK2I3L25kckFiS0QwcG9lQmtTK0RWTWtnbGJjSFh6NnFIQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14AFCDB8FB363A4587FF0D147B3D1FC2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: q6i94t0U0QmKgKFGnOntPj8jr/0Ide2aChc1CzAGZbcZEapG6OEk/5QnoNE0BNau319WTPawrANsoefo/6v9rbR7j+JY4Z3wTgOVkCsou2Eixee+TEMQwWg9G9EHT4OxCGSmAXqpgPLVbhkMmUi644cyBtP1/5R2f0R8qksMzlDKjIZ8MVEeBXfCiSWBJGgnhU0btcj0bChkZ95hgSm7+54RJHDF3SFm42oMH7szzZNj3Kk4pDA5D9rjuM/h5MGQBiFB3jq3p92fYSDW6acp/EAuHzYdgTDTsaD4wtRR1ORlCl2UzELERXZoAQBy8g5KVlgWTt3ZIXJYvwT/kK/9fQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR03MB9902.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bac08da4-fdcc-46ce-a086-08df3a58860f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 09:46:38.9991 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m3EYnE+GsQBg5Y1MCSt7UEIAsJD4/KkXSSKZL22N4ZNmohGTqa53RHSVF0fAKSIBbekbXUZdYpo2jjQiV8h3rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR03MB9474
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

T24gVHVlLCAyMDI2LTA3LTE0IGF0IDEzOjQzICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSW4gcHJlcGFyYXRpb24gZm9yIGFkZGluZyBzdXBwb3J0IGZvciBuZXdl
ciwgbW9yZSBjb21wbGV4LCBkaXNwbGF5DQo+IGNvbnRyb2xsZXJzIGxpa2UgdGhlIG9uZXMgZm91
bmQgaW4gdGhlIE1lZGlhVGVrIEtvbXBhbmlvIFVsdHJhIGFuZA0KPiBHZW5pbyBQcm8gNTEwMCAo
TVQ4MTk2L01UODg5NCksIGFkZCBzdXBwb3J0IGZvciBtdWx0aS1zdGFnZSBsYXllcnMNCj4gYXMg
aW4gbmV3ZXIgaGFyZHdhcmUsIHRoZXJlIGlzIGEgc3BlY2lhbCBzdHJhdGVneSB1c2luZyBtdWx0
aXBsZQ0KPiBoYXJkd2FyZSBjb21wb25lbnRzIG9mIG9uZSAob3IgbXVsdGlwbGUpIGRpc3BsYXkg
Y29udHJvbGxlcihzKSB0bw0KPiBmb3JtIG9uZSBzaW5nbGUgbGF5ZXIuDQo+IA0KPiBNdWx0aS1z
dGFnZSBsYXllcnMgYXJlIG9uZSBtb3JlIHN0ZXAgdG93YXJkcyBleHRyYSBmbGV4aWJpbGl0eSBv
Zg0KPiB0aGUgRGlzcGxheSBTdWJzeXN0ZW0sIG1ha2luZyBpdCBwb3NzaWJsZSB0byBjaGFuZ2Ug
Y2FwYWJpbGl0aWVzDQo+IG9mIERpc3BsYXkgQ29udHJvbGxlciBQaXBlbGluZXMgZGVwZW5kaW5n
IG9uIHRoZSBmaW5hbCBhcHBsaWNhdGlvbg0KPiBvZiBhIGJvYXJkOiBmb3IgZXhhbXBsZSwgb25l
IGJvYXJkIG1heSBjaG9vc2UgdG8gdXNlIGZld2VyIGxheWVycw0KPiBwZXIgcGlwZWxpbmUgdG8g
YWNoaWV2ZSBtb3JlIHBpcGVsaW5lcyAobW9yZSBjb25jdXJyZW50IG91dHB1dHMpLA0KPiBvciBt
b3JlIGxheWVycyB0byBhY2hpZXZlIGxlc3MsIGJ1dCBtb3JlIGNhcGFibGUgKGFzIGluIG9mZmxv
YWRpbmcNCj4gYW5kIGluIGFjaGlldmFibGUgYmFuZHdpZHRoKSBjb25jdXJyZW50IG91dHB1dHMu
DQo+IA0KPiBUaGlzIGN1cnJlbnRseSBhZGRzIGJvaWxlcnBsYXRlIHRvIHN1cHBvcnQgdGhpcyBo
YXJkd2FyZSwgYnV0IGRvZXMNCj4gbm90IHlldCBpbXBsZW1lbnQgdGhlIElQLXNwZWNpZmljIHN1
cHBvcnQgZm9yIE1UODE5Ni84ODk0LCB3aGljaA0KPiB3aWxsIGJlIGRvbmUgYWZ0ZXIgYWxsIHBy
ZXBhcmF0aW9uIGlzIGRvbmUuDQoNCkNvdWxkIHlvdSBhZGQgbXQ4MTk2IHN1cHBvcnQgYmFzZWQg
b24gb3JpZ2luYWwgbGF5ZXIgYXJjaGl0ZWN0dXJlIGZpcnN0IHRoZW4gaW50cm9kdWNlIHRoaXMg
bXVsdGktc3RhZ2UgYXJjaGl0ZWN0dXJlPw0KVGhpcyBzZXJpZXMgaXMgc28gbGFyZ2UgYW5kIEkg
d291bGQgbGlrZSB0byBicmVhayBpdCBpbnRvIG11bHRpcGxlIHNlcmllcy4NCkZvciBvdGhlciB1
cHN0cmVhbWVkIFNvQywgdGhlIGhhcmR3YXJlIGFsc28gaGFzIHNvbWUgZmxleGliaWxpdHkgdG8g
cm91dGUgZGlzcGxheSBwaXBlbGluZSwNCmJ1dCB3ZSBzdGlsbCBpbXBsZW1lbnQgdGhlIGZpeGVk
IHBpcGVsaW5lIGZpcnN0Lg0KVGhpcyBzdWdnZXN0aW9uIGp1c3Qgd2FudCB0byBzaW1wbGlmeSB0
aGUgcmV2aWV3IHByb2Nlc3MuDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dpb2FjY2hp
bm8gRGVsIFJlZ25vIDxhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+
IC0tLQ0KDQpbc25pcF0NCg0KPiArc3RhdGljIHZvaWQgbXRrX2NydGNfY29uZmlnX2xheWVyKHN0
cnVjdCBtdGtfY3J0YyAqbXRrX2NydGMsDQo+ICsJCQkJICBzdHJ1Y3QgbXRrX3BsYW5lX3N0YXRl
ICpwbGFuZV9zdGF0ZSwNCj4gKwkJCQkgIGludCBsYXllcl9udW0sIHN0cnVjdCBjbWRxX3BrdCAq
Y21kcV9wa3QpDQo+ICt7DQo+ICsJdTggKmxheWVyX3N0YWdlcyA9IG10a19jcnRjLT5od2xheWVy
c1tsYXllcl9udW1dLmxheWVyX3N0YWdlczsNCj4gKwl1OCBpID0gMDsNCg0KSW4gbXRrX2RkcF9j
b21wX2Zvcl9wbGFuZSgpLCBpdCBjb25zaWRlciBtdDgxODMgbWFpbiBwYXRoIHdoaWNoIHR3byBj
b21wb25lbnQgaGFzIE9WTCBsYXllcnM6IE9WTDAgYW5kIE9WTF8yTDAuDQpUaGF0IGNydGMgaGFz
IDYgcGxhbmVzLg0KV2hlbiBjYWxsaW5nIG10a19kZHBfY29tcF9sYXllcl9jb25maWcoKSB3aXRo
IE9WTF8yTDAsIHRoZSBsYXllcl9udW0gd291bGQgYmUgMCBvciAxIG5vdCA0IG9yIDUuDQpTbyBh
ZGQgdGhpcyBhZGp1c3RtZW50IGxpa2UgbXRrX2RkcF9jb21wX2Zvcl9wbGFuZSgpLg0KDQpJIHdv
dWxkIG5vdCByZXZpZXcgcmVzdCBwYXJ0IGJlY2F1c2UgeW91IG1heSBiYXNlIG9uIGEgd3Jvbmcg
YXNzdW1wdGlvbiB0byBpbXBsZW1lbnQuDQoNClJlZ2FyZHMsDQpDSw0KDQo+ICsNCj4gKwlkbyB7
DQo+ICsJCW10a19kZHBfY29tcF9sYXllcl9jb25maWcobXRrX2NydGMtPmRkcF9jb21wW2xheWVy
X3N0YWdlc1tpXV0sDQo+ICsJCQkJCSAgbGF5ZXJfbnVtLCBwbGFuZV9zdGF0ZSwgY21kcV9wa3Qp
Ow0KPiArCX0gd2hpbGUgKCsraSA8IG10a19jcnRjLT5od2xheWVyc1tsYXllcl9udW1dLmxheWVy
X3N0YWdlc19ucik7DQo+ICsNCj4gKwlyZXR1cm47DQo+ICt9DQo+ICsNCg==
