Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794E6606A32D
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 08:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=trsOA30v;
	dkim=pass (1024-bit key, unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=OiOMricU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFD8810F415;
	Tue,  3 Nov 2026 08:06:08 +0000 (UTC)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4B2C10F415
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 08:05:56 +0000 (UTC)
X-UUID: 63dd765cd75d11f1b1788b6acf885367-20261103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=YWhiE4d7QJnxpibuKAqe6D5KYTPZuecihfFXJrERnfQ=; 
 b=trsOA30v0t0hHHqlFfUnM7zuNHQ6hhLxtHe0SwWYLl0RztQEZTnDaxKlqG3OxuKVePkReD/AOYY8fr6/sDyIwaY3BhtfkYm+ZZMi4Bln65/P5IuQW0HPLa9OQ+C9LtXV/Ljq6Ll+gUrX7n+fAHsmFni6rCplzGbIOpPzeVyNgQs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21, REQID:a3cdfee6-c059-4d1d-81d7-3ef196845558, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:b0318ac, CLOUDID:e46156bb-4006-44bb-949c-6e25a7b8dad4,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:n
 il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 63dd765cd75d11f1b1788b6acf885367-20261103
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1849300296; Tue, 03 Nov 2026 16:05:53 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 3 Nov 2026 16:05:52 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 3 Nov 2026 16:05:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/OcuMei9FyZ7ldXFZ0DKTdpo3r0F/3gWyY6AYQCd8AsyvSDYtUTxc0Y1bBQeDktUTk5KBGH8MyVeS6tcs/JRnASagGdWluCNkkhmy9NL81a/WBdxTEK/jUsuyyoFoowQitQB6X+h2B+JiWxozmN+nUwZ6LKAM+esJC3F2pzyyKEys2+BqJcxpXU1YuKOAWKgTbZe/1aVD1lD6/cDezuXRmQMqHVHD8z9MUdc6bzgZwydCAyk1mHWLXe5dmDPKxw7iN08C/E6iNsPZ9/tfw+7Y+SkUe5mMvWCDDOxXdAIYlfAkKjSqvNmNN1z1zUDXfoL5iteDDHc9VKEbbgqcbeKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWhiE4d7QJnxpibuKAqe6D5KYTPZuecihfFXJrERnfQ=;
 b=xyW31q7Oyfr6L51p55bPHAIreZIycVg9aW61oDe3z0Tw2OJ9o3UE+dWucuF9RNvuq/7ilQ9KalHghgHz1SeaRaasrs68MgZflKh0jdEoWVwMrfigwIjLf6NJEVounMoawBiYEW0OMvyMuZ4VX1NEYXZstjaCBZLAZNyjkxCZ7QHpIROszyYMRtpmI0h2OHRV4GEmWH2mDf5fD3yXHdMrikrrmMik6nugM8xqM240scE677+D2SLwoVBFHFm3yeznt8stCs6iowz2ejFz6BreQ63Y0t0Tu6y0+bow/UxH6tkXJf06mcsgh+4HK0mr+FX4qIQCBenofQs8QW32sH7sEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWhiE4d7QJnxpibuKAqe6D5KYTPZuecihfFXJrERnfQ=;
 b=OiOMricUN44Xysz3aWOUOShE2DuE04MIAeqIJRrloFXiwIjUAvFHyT1BNd4Q5aOW56eKTBrPMrPBJ6rKmC6JEcRJBI4QfYMaZCaoV9+LAzvoE13KA5q8q9WZzftt1qLcnZwJ0dPH1IW6gvXyz/pE9y3/GRmDKu1PEFmkyRtce/0=
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com (2603:1096:d10:91::20)
 by TY1PPFA17DEBF51.apcprd03.prod.outlook.com (2603:1096:408::a62)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 08:04:45 +0000
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b]) by KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b%5]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 08:04:45 +0000
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
Subject: Re: [PATCH v2 15/46] drm/mediatek: ovl_adaptor: Add special MERGE
 component check
Thread-Topic: [PATCH v2 15/46] drm/mediatek: ovl_adaptor: Add special MERGE
 component check
Thread-Index: AQHdE4Zt+SA8meJe9EK6tfh41GwI67ccrOyA
Date: Tue, 3 Nov 2026 08:04:45 +0000
Message-ID: <8c040b2b471dbdbf9caf8bbfc199c93d05181a8f.camel@mediatek.com>
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-16-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260714114414.184512-16-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR03MB9902:EE_|TY1PPFA17DEBF51:EE_
x-ms-office365-filtering-correlation-id: 7eb9ba60-3f6c-4dc7-ad97-08df39811fa0
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|42112799006|7416014|376014|23010399003|1800799024|10067099003|22082099003|18002099003|38070700021|56012099006|4143699003|11063799006|261021123027099003|261009223027099003;
x-microsoft-antispam-message-info: Dr2Cb22H3rBlWebv+dyd6TyAjyvvmqYxlbag+sCMWCbD7h7+AtSU+7fKIkf2TI7CDOCzv5kGkJ+x5x+/QGt9uKZn/M3ZjV8IsmDXMhC0vR72HTDbBjbRM14pBhI6sO8G6AUZiC01FouF/7aIeV0bfCYMVCNWoRFPHz+X5mxGuF41EAzpSmY994WbI5wtY1/Vdom7O6ZrAdWuUmLTDQWyT+50VlCCbdiwVJK3F/92GhTnBwaDx0mzeuTH45pgcdm7Y765gJMe+v0xDDWAERrieOcfcoMpHP7XbwZcQT+JZU8ceg+PMWT4psSb4kiJ7EBDmaJ4aSI7R7oxKQef3R06brhR+JCcNGcA/wAGmK5dae7Rm7zGbzVbgqnAsjTbgWbpawJMMCvcbMdq88N9CuzgxVbOKpFU4SLVSykjseSovu4uvVx/ywtHw/aW9YKlgblNTF7zk7GxcVPDwvAp1aKpo8fM5UHDapjg7aVFmAIM2Ca6QgynZZ2jM3OQ4s26pPw3ygTzszhBMWH7yhnb0bsBAecISub7nHLZ8qsI5fb9KIfqzHdrzsgkOZPJHI8zpFCHjRZPniN8datUJiyraMlG4spwVfGInBHIzwnZXZENbEnEZv++ix2m7K9ocpRWPm+clws1fZtkpj0COnMU1fx4vPpXErxNE8zyvk9JLdSm96fU9GiKrGRmd6K7OGl/GWjGRxd1Ir06L9hv1cF7cq2ng9IObZJAzGmeshGY2+kyOdM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUYPR03MB9902.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(42112799006)(7416014)(376014)(23010399003)(1800799024)(10067099003)(22082099003)(18002099003)(38070700021)(56012099006)(4143699003)(11063799006)(261021123027099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDlVc2xJdlZJTWpJRGh2R2VhRmx5NkFFVnFoUmt2aWx4MUpvT3R6RWlJNUtX?=
 =?utf-8?B?T3JtMjRndjFYSXowVDB6dTVRd2p5c3ZHL1drWXVlSzZzVlN0RmQ5Y3E0a1N6?=
 =?utf-8?B?STlGSnI4anNWOUxMOFZ4N3V3VlpDbS9RdHkwMitLeHlFQkROQ25NVm9qaWtO?=
 =?utf-8?B?VlJBd1hacExNcTQwYjV3QndtTzBmNzRyUkJhN1o1MDVEdFRjb2IrZkNNYTY5?=
 =?utf-8?B?ZU5DNXlVYTV6QUhHY3FFZ2xSVGx4NWpXcVdSZXBFNmppdGxtOU1XL1U5eGRi?=
 =?utf-8?B?QnUxNTV1TENyQ1FYNmhDZkl4Z3BGeTN0cFV6QTNmSmkvVlREZkNyTXE1TVRk?=
 =?utf-8?B?WHpkbjV1VCtFTzV3Qml1bWlmNGFPRUtZU1oxV09zVkJRTEJmV281cVNvT1Q3?=
 =?utf-8?B?OUlnL2hlR3JWRjNmVjZHMEJldzAwNlpkd2FmWjQ0Q3ZGSVM0VUhsQk9CTGNJ?=
 =?utf-8?B?RTBRc0RPSUlzZis5V0RXTGZsbTVaV0FWcnRuNDg0eGx0QjBIS2ZJRUkrRk8r?=
 =?utf-8?B?WlNqMzg3cHJ0QXFQN0ZYTnlBaEErNlZXVzRDMWN6YXh4dGEzQWw4K0Y5d1JN?=
 =?utf-8?B?dU8xTkxiV3RTeWJvb2xIRUJpcGJvNmFldnl1SU5lTXNCaTBUWkRRZzFEZjU5?=
 =?utf-8?B?c2RoUUx6cUlQOUZtQjcxZURhbVE1c1B0elVNK0NTazAwT3JQRThGdTVnbHc2?=
 =?utf-8?B?YnBrekNUV1FDSS9SdjZuM0xPbDJaVzlzbEw1QllhNVNrRFA1cEIwM1NjSFFa?=
 =?utf-8?B?akhBdzJTdkJCSWlodFR0SDQrNTdWN3U0UGtKNXJCNlVnUHhhQjhYejlMR2Fi?=
 =?utf-8?B?OVRMRTZXUG9LN1BNRnZueVpwdDVnQXp3ekYweGhxUnlTYU1ZT2tkWUJZN001?=
 =?utf-8?B?NmhxWE1MU3c1cllUcHZKZHJTbk1Zc0ZSN054dUVRSTlEZGNoV0RBbW9QVnI5?=
 =?utf-8?B?aUxhdWdiRzdVQjJlakhFL0hVVUE5ZWY1Z0V6UmRXcTB6S3dIdVZQUmQwZ0NK?=
 =?utf-8?B?YUlIYUhFcnRFM3NxYVJ4L1Nac2EwcHMwaW5QNjUwci9QNVJ4cElPSmpsTldu?=
 =?utf-8?B?WTNwWGZWcytYck4xVDRaenVRVHplNFdFNEdhcFdwVjhJeWZtdjAyT0daY2V6?=
 =?utf-8?B?ZlF5d1dzTHM0cXVSaTRjeTIrSk9mYjlvK3RudkVkcWtHTUtmZXZNTk8rQm1B?=
 =?utf-8?B?WkFsdzV5T2YzUy80TDFaSU04Z0hPN3MweWhVcXg4ZCtoSmJEaGNzTmRIZEhr?=
 =?utf-8?B?SXFnU1pubFZBMkxHNDhSa3BFaThZRzQwWEh1QUtOZXJnbVN6L280YjBBdnk0?=
 =?utf-8?B?c1ovQzdOL010aDNraEZYZnlrUW1ya2Excmp6c2IzZnJvdVdDQ0VyRk1oWmhv?=
 =?utf-8?B?Y204REt3UURFZWQvRFhYQ0dZRHFCREFrWEx6OEIra0ltSG5ONmU4OFNxVFZZ?=
 =?utf-8?B?OVNPV3V3R2RZK3dZQStveEVRSzE5blNEVmZiV0NjWHd1NFEwSFBRM0o4a1Va?=
 =?utf-8?B?R2tkOGlCQWMvZ2RJOG9TNXdRN1ROSTR6TnlPRDhUSW15VmN0T1Bxb0w0bWZP?=
 =?utf-8?B?dkRadXVwZzFzMUFvQmJFYnFoaFQxV0ZZYitTcituRXg0QlhzWkJzVldEdjcy?=
 =?utf-8?B?bkVaZVZuOVF0ZzdoNkxUZUlKeUxzRjVwU0R6T2VseDhFdUhxRlM0dkVhclFr?=
 =?utf-8?B?UzMrOWNSK0JIb3Ywdk5qVDNudkdwNW9scVpzWHpnWlhCNi9VY050Z0dPUnpM?=
 =?utf-8?B?ME1FbVVlTHY0Z3BoclRhN2s1UGNIYXVCb0J2bUZMcGxpZHM2U3h0UmUxbE1S?=
 =?utf-8?B?ZXdzMHZ1TjdCNXRNby9ab244bGQ2ek14SEVzVmRydEFOMTNKY0ZJMU16dzBO?=
 =?utf-8?B?MHVONmR4SVpFc1VpV2FrcjM2OHVFTVpBbERQOTZpYmx1WDJ0bW5weWFnZjJW?=
 =?utf-8?B?dXlhQ0hmRzRGZVovb1p3UTdaTng1b0pjUEY1djduR252QzlWVjVZbWJJZzZI?=
 =?utf-8?B?R2N5V2dNa2QxZVZ6N1d2clJncWx2N2p4ZW5jVjF5VG0yaGwwdXAvT2ptQ29L?=
 =?utf-8?B?eFlaV21ESVBZYWk3MGlvelI1Y1hKWis2L1B0b050WHdPSlJkSTBQVG1MZnp1?=
 =?utf-8?B?SVZJSEZOamNYREl6VGhHeTN3MjV0Z3ZkVEY5OHloRDM5b1lRRWxWU2lHMEpm?=
 =?utf-8?B?VElJZm5vazdHOUlUbFlGbEpUUnkvZVVUTXc5bndEZ1VsRVo1eWlEdEg1dVdI?=
 =?utf-8?B?aUNKVHZLbXF1UTdQR1JHOWdjUnUrNTlWUWdneGNFN0xtVmZnZXMvNnh6R2F3?=
 =?utf-8?B?WU13MmJrVTRXekNFd0dCeVdUVXpzVmJNVGRUcTZwYTc0TFU3bEdxQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A6C3CE09B7090B488A3C8591E82201D7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AFHa+QA6/jS6Y0KHSt3tBMNtTRIFg6aYDQ0R5mcMOLO+uQtRx7mv/sSlIGoKDOvl27BPtLQyPdP88i+Csz72Dk8BDiLAUGrtTWh5baboELd+gnWi1t/6SVFIK1SR8TY3+7iDThzduvt5VoQaMY+EHzd1A1FDF6RGTaIcDltq+Dywt0ZU+0hNCHTupEgwb7K+CMpSSme7esAqMAFe6XBalTYvnz3OZD4CeqkI72t3CzvnrNuVHvgSMS8YCmgVR0nW88H5BTJ6Z/BEnBfLPE2LLCMTl01LA6A9V72c69K1CPZ5JdwajvxIWN/3R6rObMhj9gbhJQJUqT7iyJJPOJ9XrA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR03MB9902.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb9ba60-3f6c-4dc7-ad97-08df39811fa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 08:04:45.3458 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kh4DEdI79KLZamj6SZzKhfDBXDs2k2Nl6NfRYGJZEnOuH9R9z/Wsf+z4CY8qv4I5bvsf+LjEQkqilE7dMzOhog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFA17DEBF51
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
ZWdubyB3cm90ZToNCj4gT24gdGhlIGxlZ2FjeSBvdmxfYWRhcHRvciBmb3IgTVQ4MTk1IGFuZCBN
VDgxODgsIGZvdXIgTUVSR0UgSVBzDQo+IGZyb20gVlBQU1lTIGFyZSB1c2VkLCBhbmQgdGhvc2Ug
c2hhbGwgYmUgZXhjbHVzaXZlIHRvIHRoZSBPVkwNCj4gQWRhcHRvciBkcml2ZXIuDQo+IA0KPiBG
b3IgdGhpcyByZWFzb24sIGFkZCBhIGJyYW5jaCBpbiBtdGtfb3ZsX2FkYXB0b3JfaXNfY29tcF9w
cmVzZW50KCkNCj4gdG8gY2hlY2sgaWYgdGhlIGNvbXBvbmVudCB0aGF0IGlzIGJlaW5nIGNoZWNr
ZWQgaXMgTUVSR0UgYW5kLCBpZg0KPiBzbywgaXRlcmF0ZSB0aHJvdWdoIHRoZSBsaXN0IG9mIGNv
bXBvbmVudCBtYXRjaGVzIHRvIHVuZGVyc3RhbmQgaWYNCj4gaXQgaXMgb25lIG9mIHRob3NlIHRo
YXQgbXVzdCBiZSBleGNsdXNpdmUgdG8gT1ZMIEFkYXB0b3IuDQo+IA0KPiBUaGlzIHJlc29sdmVz
IGEgY29ybmVyIGNhc2UgaGFwcGVuaW5nIHdoZW4gbWVkaWF0ZWstZHJtIHJldHJpZXMgdG8NCj4g
cHJvYmUgYWZ0ZXIgYSBwcm9iZSBkZWZlcnJhbCwgd2hlcmUgYWxsIE1FUkdFIGNvbXBvbmVudHMg
d291bGQgZ2V0DQo+IGFkZGVkIHRvIGJvdGggIm5vcm1hbCIgYW5kIE9WTCBBZGFwdG9yIHBpcGVs
aW5lcy4NCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9naW9hY2No
aW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+IC0tLQ0KDQo=
