Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10D8606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 06:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=IRPun8Wk;
	dkim=pass (1024-bit key, unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=WYdvYVPN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E14EB10E927;
	Thu,  5 Nov 2026 06:19:37 +0000 (UTC)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48AAD10E927
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 06:19:26 +0000 (UTC)
X-UUID: d7e299ccd8e011f1b1788b6acf885367-20261105
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=7+Kpsrdqjg3PJmHWUuD4MZ+nwOv4i9yLYdGM1NEdmA0=; 
 b=IRPun8WkTWS4jpVvwYJBhLOTjXXUUYP3Sw4WXXxj4uJwjpndFp1n0dkxnldhNtKhBHjTIQy0IXSNxbgcoMVCtEO+bE2WZaaJx0FR1z+9PW6HTN3VOrBAT51+79eKUTcTSjiTDkgeWcslar3G4wKdiqOj/5T5qNogVTJ7/zjvIl8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21, REQID:04011c15-ccbc-4b80-b4e3-8a8e79594308, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:b0318ac, CLOUDID:bdfaa456-6f68-464f-9fe4-a2bcffa484f1,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:n
 il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d7e299ccd8e011f1b1788b6acf885367-20261105
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 729193087; Thu, 05 Nov 2026 14:19:23 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 5 Nov 2026 14:19:21 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 5 Nov 2026 14:19:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IyBdjamSDQEmoo3iMkmmBEzRYxw37Ue+uSVHQ7th1ltOzh+Xcc5UESnZprSh0a5DiH39zTkPgWLLNERwn/x7pAhEXqZpoVbdcTAAfxBrVCOHYwcW43w6QeWXuo4XzOvUqkEtbJapvjHuzyXsaUZpLw7Z6m98SsJisAYaVMOTxCR6Zx3LGBxJsNTzBOnAAs/DOW3Ca/r8VkDiHJIVBn6waMv2CTG5L4SCNZqa8IIbHNO9UFDZ1B/90pAewdPm9nRnBevYIpxlmzszV7wEb8v1KTslj4a/LlR05eqyAmfOC22atlVebhzM0WrioeYUxArQ7QLLoSqebrIdmcUJ8u1lvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+Kpsrdqjg3PJmHWUuD4MZ+nwOv4i9yLYdGM1NEdmA0=;
 b=TfcobU4cx9jLZNHadafPap+wUhqL6jE2UJbWGpRX3nUx1/thd7btDE2F8IPUGYnY1vd3PioiuSMIlx3Va0s6WE8ZgG5qBqpwu6OtMqwCZ9RGnXuTMPQd2h7cSnklOytTEpX3M4MhLcAM/aPO1flS16nc5G//bx00/RuiFVdgpktHhzy5jETkdpSsvxiezxHlatf5k56IBM3qteUGPLOpLrIXTvg61EbGA53N4oG4PIBe2s2xs6vCe8Q9unOEPqL3mMQ4TPzL1vp4m9N3E5lK9AxSCi5o+X7hCX4gBlTI2yt2kqRqiYIn9E04IZ8gejF6xN3pmEzaguUZZcCyT571/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+Kpsrdqjg3PJmHWUuD4MZ+nwOv4i9yLYdGM1NEdmA0=;
 b=WYdvYVPNu6dv7uxRZnkMMk9INU5qQo3C0iJjmbOyV38NGz8XFd5BJNkMZrGaDLFER4pMa772Eho4srRnPdHHm308gGHudWPK0S4HaQboHc8jifmmZS+oHmSAHkEWF0Z+RQtAwH3vIuAXY6sqtbO+op8vMfCUIq5PPbrg8A+dexE=
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com (2603:1096:d10:91::20)
 by TYZPR03MB7362.apcprd03.prod.outlook.com (2603:1096:400:423::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 06:19:16 +0000
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b]) by KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 06:19:16 +0000
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
Subject: Re: [PATCH v2 19/46] drm/mediatek: mtk_crtc: Minimize spinlocked time
 in cmdq callback
Thread-Topic: [PATCH v2 19/46] drm/mediatek: mtk_crtc: Minimize spinlocked
 time in cmdq callback
Thread-Index: AQHdE4ZdtZQ2tvvxpkidqRdo1mgifLcftB4A
Date: Thu, 5 Nov 2026 06:19:16 +0000
Message-ID: <a7bd1730e2de56f882921e934c035f73e327c470.camel@mediatek.com>
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-20-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260714114414.184512-20-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR03MB9902:EE_|TYZPR03MB7362:EE_
x-ms-office365-filtering-correlation-id: df71884f-8fce-4c55-e465-08df3b04b835
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|1800799024|366016|42112799006|38070700021|261026140227099003|11063799006|5023799004|4143699003|56012099006|261022075727099003|261021123027099003|261021121427099003|261026121527099003|261022105027099003|261102123227099003|261009223027099003|261028144727099003|10067099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: H1wB9AxEb5ciTw+dGew92ceGCD9/8Wo3TgfsYu0OKpdyv9t2jX6xORuBn++WfWNdSQLB0Mp4B/7/2XUSOpCNZYZBtn9vkU97MdJokcDTUWs9GbecYsf8lLPpcT4/fgj0nerrv0iOqHb74zWZX89y5TiIgouVqK5HFGLmHCf5Dwv0P3ZwQzxQj20P595cE7JR+HD+n89zxjmxtr6cSp79SpnqygFy6Q6m27pTg2WUOnR9Mriyvvi3en+whocONHn4KYB6TlCTKZnHSIcISzN78CYbxhXT7NLUy/pYsQkn3wF+yqPkORHfP+zeFZX6AmlDRPpeNbXLPU0z/f+xCKMyTzlpQ5Ay/nWAKmLoohYfw/SJzLbdVp8o2+OK6262xjCsF+ty52HgEdejrOh9HfwePlg82VyWyINJVvi0FLiq583Mqsf9yK5P87gHW7eYRx9PLvjqaexFE2YEhXipfRu4Lp9Yh6uhPbngeiJ8BTShja4yl01KUCaxDdLxpVzm48gfHrdDMN08HVmYcjUBMxrEdtGk7BH3kdbPr7OAfdsdmHtMBNZ2xXWtLvBtJi+LjOqbvr1Zm0QeEE69ZLaVDVAO0KrHRKlQYQdE0DFdJ/yHiG8zW89LglnwmcUSEowWbfQqRv1lkhxsU2IN+RXyaXJ2T2t1TFs2hl1KAy1TCozk20G1Q3ENFpX4QuJ7t0FjVEDCJQFkCuP0nWMpqQ0HCISXryWaSV8t2fbQ7oRu7XoMSx4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUYPR03MB9902.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(42112799006)(38070700021)(261026140227099003)(11063799006)(5023799004)(4143699003)(56012099006)(261022075727099003)(261021123027099003)(261021121427099003)(261026121527099003)(261022105027099003)(261102123227099003)(261009223027099003)(261028144727099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnBWWFM5TFRoVkRONm80ZmdJWjdCa1lrVGFuaEloRmxRMU5vS0xweXZGeUl6?=
 =?utf-8?B?M3h1Z29VYlo1bU1KQ1dpTGp5M2I5S0Y3bkVtN2hIV29ROUdqMk82TUY3UnVQ?=
 =?utf-8?B?TE5aN29MdmZwLzJlNUZSaVp5ZjZSUEdGYlA2OEltalMzZ1J0aU53aDNnZElr?=
 =?utf-8?B?VzAyaVhlSk1uZXJacHBuTUZSMk13Q1V3Mm5PeEFMeWtUTEgwUEJodGwrVk96?=
 =?utf-8?B?VjV3WFVaSDVLUHBHbGthMmJ1ZmVmWjR1UzZ4QmQwdm1URE9oem53OEczak5D?=
 =?utf-8?B?ODErNkJQRjh6TVBzTmZmb21hOHh5UjZNemhsWDQzL3hpZTVWZkR2amtCdk5H?=
 =?utf-8?B?a3Mwc2JVb25OZ2M2VjZPS3pRUG5OTjBWUGV5cWxlcGRWcWVLc1pOYVdCcEFZ?=
 =?utf-8?B?eWxKOGk1RUtER3B5MWoyRVJhbUozcWtNUEcyQ1gzOVJzQkdvZ21hclFGS2Vq?=
 =?utf-8?B?UkNQaW1aVVFwdlVKSkdBd1NiTG5ZTmdmZUxjTnhRTTRzMW00REljWHlORkNs?=
 =?utf-8?B?cll4SkpUdjJTcFB5cDNjMEJiYjc1cmdHQkNSajdqK0lseUhJUytteEh6Zjl0?=
 =?utf-8?B?ZHhkVjZpejdmVUl5OUtPU0NKV0l4RnBJbEV5Tjh2aXlxUytxeitIU25ZQkZK?=
 =?utf-8?B?ZlNNWUNOcDZHelh6SmVQa0hucVJEL3dBWkV1bEdXTXlON1gvWkUwVHY3NEdi?=
 =?utf-8?B?VG45VStoWmhFY3lLc1RlSnBsbFlxZHRmZCs3dVFZaEp3WG5lNERGVy80RlI4?=
 =?utf-8?B?RVFUT0liYzV1bFM4Q0dNVEJMb2pzcnB1djE3SGJzV3UvekNIZng0dlpqWmVN?=
 =?utf-8?B?Ly8yNTNmaXEvaVRFd0o2Mmd6UHlxQzRwWXFWYjB0eEk3WVR3c2Nobmp0bFdh?=
 =?utf-8?B?bzAxSzc1USthbUdUejZtTDQyRXh6YWg5bEVXaGtSM0NpUEpJV3FGUHNabGlM?=
 =?utf-8?B?Y2l2MFpqaUhJYTlIKzVJNHBQZzR2ZWFncWVHaWlEY202RU4yM0kwU1l6aFJi?=
 =?utf-8?B?NEtzQVgwM3lIWUwwZklPM2dTQzE3SVJvNkJjbU1UcWR6VTgybmtBOWZwNkM3?=
 =?utf-8?B?Qk9zZ1VJQVY0ekJCLzN1WjFVYjZBaElrWTlScW9obGs4QXVWQ011Y2ZJY1Uv?=
 =?utf-8?B?aUFOZGlwcC9RUVVLbTRWZnZkUGVxUWJtSFM3S0k4TzhIaGVYMGdONzc1WXUx?=
 =?utf-8?B?enpZcDJEYzBpV3V5NkJUb2hJalUvYmZiZGdUaERiWkVqODVMWWZoMHRzRDdM?=
 =?utf-8?B?MXhrNFNtQ1VObWxDNUFyUkF3bVNVZm03N1cyTXlCUTJsOHdOdmJGL25BV09k?=
 =?utf-8?B?ZFZFenVkWEF1TjJrNkYxaVBPejlJeWlGSXllUXNWQ1dydW1aOGNLY1pHVVZO?=
 =?utf-8?B?eGJqOGZLcnZTZnVRaXhqWkdiTU1WN0RFSW5WdE1iQzVCdzJNaUQ2eWJ2VkpU?=
 =?utf-8?B?TitWb2Faa1o1dEI3cnBFdWVDWW5KdkxSZVk4aXFSTi9KUWtUbUc0Z1g2Uzk2?=
 =?utf-8?B?ZGVKY3B0YnAzLytiSGs5TWh1TGgwVVJsQTB0cTh5UExHOTNXOGhkaHNNajhl?=
 =?utf-8?B?UDZzaGhCaHcrK0hMcjhzRFBrTndkMGVpbW1wZnh3TENNRnNUMy9HR2Z0NEZU?=
 =?utf-8?B?WStrRFQ3UCtSOUlJYVZSdzUrVnNsVlFFb1RRMTFsSTdFVmhEc3VsYjhHak1k?=
 =?utf-8?B?SUk1ZFdYcU83bllsTlhYL2dxdWtUbWRETDkwQllqUWRYcUVvNkJ1NEpyYmkz?=
 =?utf-8?B?S0dPTFN4SEM2Qm1Pd01SbXJCdTZSS0I5Nmo1WG9SUU94NUFZamJuc09yWjJX?=
 =?utf-8?B?akcxN1BLWkMyTFJERWczc1hadkd2b21yUWpRblF5MWNLV3BubnhEdU9tVC9R?=
 =?utf-8?B?SDF4emgrSFlUS2FkNytINHBkRTNGMVBrd2MzczlBekMrMk1sU2lkcTJ1aUgr?=
 =?utf-8?B?QlAyM3NSaDgwRFB0NXdiVndQLzkramdUY2NHcDBDVWJNS2hXZVlHZ0lpQzJH?=
 =?utf-8?B?MzN3WnRFUHh4MHZLblEzZFZwVWlIdnhQa3NwMzhKUXZ2SFpDYmR5SlN0U0t1?=
 =?utf-8?B?RnFYa3Irb3dEKzhDNms3TWx3ZnFPeUZScDlRaWhPZXYrd2pZNlpPSlJwVERL?=
 =?utf-8?B?VENWRGxkRG9ucHRNOG9zRmFDVnhCYWFIMS90T1RkcUlDajh5WUhaRm1iQ2Z1?=
 =?utf-8?B?c1JzbGZDRWM0Mk9vejNlNlVDR21Uc1BTR0ZDR0M1R0ltVWtoL1ZPZjB6UnpZ?=
 =?utf-8?B?UStZV1ZRT1hZb2ZHb2RjKzdreEl1SHU2aVAvYnBKaHd3YmxNc2Y5N2xrZWFU?=
 =?utf-8?B?TzFUaUdSelUwUlhnL29KSThWZ0xkMzN2NVloYXJTNlBpY1NZZDdhdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <634E43CFBD21824FB300E55DDB4A2B36@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: j34jp4urmHj7kIWXREdt4EYBwn5acDZN27zxOrg8rmZpCFBT4BbfJeERP5+iTuX1J5vkWJjeN6BYIKCdDwczgB5sNS+IEDcfCqBxVNxQUMEFD4ANNb+n2IX8cqHzYo/i00/nta/VYZrGuIxsLJ+7MwJZ8at/0+Jgq6Wvp74rkxbnlY6Bjye9TPYG9WRvK+Wn2L9oE8Rd2K/YcLcQz3RAWPnzG5DsqmjuSuPWK5dd52ClaByqdMt0DeYRkp13Vi9VhgDh/D7qBTPbGU3GzrKpQo1w6XfQKxviOGXQXwEJMV3zDA+IOLjnnobuIg76HxSeykgYZDGakif5qsCgWJjsIw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR03MB9902.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df71884f-8fce-4c55-e465-08df3b04b835
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 06:19:16.6050 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 82R2z7k+k4nD8+3b2XWRfbjQVCjTh6NMvw3HeJXMuRX5GRIZvVgne8vWjviBJKhPUT9wkl+/Swl5KgiTgxIg6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7362
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVHVlLCAyMDI2LTA3LTE0IGF0IDEzOjQzICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSW4gZGRwX2NtZHFfY2IgKHRoZSBDTURRIG1haWxib3ggY2FsbGJhY2sp
LCB0aGUgY29uZmlnX2xvY2sgc3Bpbg0KPiBsb2NrIGlzIGJlaW5nIGxvY2tlZCB0byByZWFkIHRo
ZSBjb25maWdfdXBkYXRpbmcgdmFyaWFibGUgaW4gdGhlDQo+IG10a19jcnRjIHN0cnVjdHVyZSwg
YXMsIGlmIGNvbmZpZ3VyYXRpb24gaXMgdXBkYXRpbmcsIHRoZSBjYWxsYmFjaw0KPiBmdW5jdGlv
biBzaGFsbCBub3QgcnVuIChvciBzaGFsbCBydW4gYXQgYSBsYXRlciB0aW1lKS4NCj4gDQo+IEl0
IGlzIHRoZXJlZm9yZSB1bm5lY2Vzc2FyeSB0byBrZWVwIHRoZSBzcGlubG9jayB1bnRpbCB0aGUg
ZW5kIG9mDQo+IHRoZSBmdW5jdGlvbiwgaW4gY2FzZSBwZW5kaW5nIGNvbmZpZywgcGxhbmVzLCBv
ciBhc3luYyBwbGFuZXMNCj4gYm9vbHMgbmVlZCB0byBiZSB1cGRhdGVkLg0KPiANCj4gVGhvdWdo
IHRoZSBjbWRxIGNhbGxiYWNrIGlzIG5vdCBhIHBlcmZvcm1hbmNlIHBhdGggaW4gdGhpcyBjYXNl
LA0KPiB0aGlzIG1heSBiZSBydW5uaW5nIGZvciBlYWNoIGZyYW1lIHRoYXQgaXMgcHVzaGVkIHRv
IHRoZSBkaXNwbGF5LA0KPiBzbyBmcm9tIDMwIChvciBsZXNzKSB1cCB0byAxNDQgdGltZXMgKG9y
IG1vcmUpIHBlciBzZWNvbmQuDQo+IA0KPiBBZGQgYSB0ZW1wb3JhcnkgImNmZ191cGRhdGluZyIg
dmFyaWFibGUgdG8gYWlkIHdpdGggcmVhZGFiaWxpdHksDQo+IGFuZCB1bmxvY2sgdGhlIHNwaW5s
b2NrIGFzIHNvb24gYXMgdGhlIGNvbmZpZ191cGRhdGluZyB2YXJpYWJsZQ0KPiByZWFkIG9wZXJh
dGlvbiBpcyBkb25lIGFzIGEgbWljcm8tb3B0aW1pemF0aW9uLg0KDQpjZmdfdXBkYXRpbmcgaXMg
dXNlZCB0byBwcm90ZWN0IHBlbmRpbmdfKiB2YXJpYWJsZXMgYW5kIHRoZXNlIHZhcmlhYmxlIHNo
b3VsZCBiZSB1cGRhdGVkIGluIGF0b21pYy4NCkluIGRkcF9jbWRxX2NiKCksIGl0IGp1c3QgY2xl
YW4gYWxsIHBlbmRpbmdfKiB2YXJpYWJsZXMsIHNvIHlvdSBjb3VsZCBtb3ZlIG10a19jcnRjX2Zp
bmlzaF9wYWdlX2ZsaXAoKSBvdXQgb2YgdGhpcyBzcGlubG9jayByZWdpb24uDQoNClJlZ2FyZHMs
DQpDSw0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8
YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfY3J0Yy5jIHwgOSArKysrKy0tLS0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19jcnRjLmMgYi9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2NydGMuYw0KPiBpbmRleCBlNzRmNjI0NDYwNmYuLjJjZGYyOGEwZTJmZiAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19jcnRjLmMNCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19jcnRjLmMNCj4gQEAgLTI4OCw2ICsyODgs
NyBAQCBzdGF0aWMgdm9pZCBkZHBfY21kcV9jYihzdHJ1Y3QgbWJveF9jbGllbnQgKmNsLCB2b2lk
ICptc3NnKQ0KPiAgCXN0cnVjdCBtdGtfY3J0Y19zdGF0ZSAqc3RhdGU7DQo+ICAJdW5zaWduZWQg
aW50IGk7DQo+ICAJdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gKwlib29sIGNmZ191cGRhdGluZzsN
Cj4gIA0KPiAgCS8qIHJlbGVhc2UgR0NFIEhXIHVzYWdlIGFuZCBzdGFydCBhdXRvc3VzcGVuZCAq
Lw0KPiAgCXBtX3J1bnRpbWVfbWFya19sYXN0X2J1c3koY21kcV9jbC0+Y2hhbi0+bWJveC0+ZGV2
KTsNCj4gQEAgLTI5OSw3ICszMDAsMTAgQEAgc3RhdGljIHZvaWQgZGRwX2NtZHFfY2Ioc3RydWN0
IG1ib3hfY2xpZW50ICpjbCwgdm9pZCAqbXNzZykNCj4gIAlzdGF0ZSA9IHRvX210a19jcnRjX3N0
YXRlKG10a19jcnRjLT5iYXNlLnN0YXRlKTsNCj4gIA0KPiAgCXNwaW5fbG9ja19pcnFzYXZlKCZt
dGtfY3J0Yy0+Y29uZmlnX2xvY2ssIGZsYWdzKTsNCj4gLQlpZiAobXRrX2NydGMtPmNvbmZpZ191
cGRhdGluZykNCj4gKwljZmdfdXBkYXRpbmcgPSBtdGtfY3J0Yy0+Y29uZmlnX3VwZGF0aW5nOw0K
PiArCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJm10a19jcnRjLT5jb25maWdfbG9jaywgZmxhZ3Mp
Ow0KPiArDQo+ICsJaWYgKGNmZ191cGRhdGluZykNCj4gIAkJZ290byBkZHBfY21kcV9jYl9vdXQ7
DQo+ICANCj4gIAlzdGF0ZS0+cGVuZGluZ19jb25maWcgPSBmYWxzZTsNCj4gQEAgLTMyOSwxNCAr
MzMzLDExIEBAIHN0YXRpYyB2b2lkIGRkcF9jbWRxX2NiKHN0cnVjdCBtYm94X2NsaWVudCAqY2ws
IHZvaWQgKm1zc2cpDQo+ICAJfQ0KPiAgDQo+ICBkZHBfY21kcV9jYl9vdXQ6DQo+IC0NCj4gIAlp
ZiAobXRrX2NydGMtPnBlbmRpbmdfbmVlZHNfdmJsYW5rKSB7DQo+ICAJCW10a19jcnRjX2Zpbmlz
aF9wYWdlX2ZsaXAobXRrX2NydGMpOw0KPiAgCQltdGtfY3J0Yy0+cGVuZGluZ19uZWVkc192Ymxh
bmsgPSBmYWxzZTsNCj4gIAl9DQo+ICANCj4gLQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZtdGtf
Y3J0Yy0+Y29uZmlnX2xvY2ssIGZsYWdzKTsNCj4gLQ0KPiAgCW10a19jcnRjLT5jbWRxX3ZibGFu
a19jbnQgPSAwOw0KPiAgCXdha2VfdXAoJm10a19jcnRjLT5jYl9ibG9ja2luZ19xdWV1ZSk7DQo+
ICB9DQoNCg==
