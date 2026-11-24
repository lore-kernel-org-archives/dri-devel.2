Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F62F606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 02:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=CFD/bb2d;
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=pasWkBAs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9918D10F2CD;
	Tue, 24 Nov 2026 02:31:39 +0000 (UTC)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9260310F2E5
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 02:31:28 +0000 (UTC)
X-UUID: 24fd11d8e7af11f18dc8c9802ae25ab1-20261124
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=k7/Td9BIRq9/tQEwZkr2bar8Jaioor79U/uNYdFTFgw=; 
 b=CFD/bb2dzSmF1sP52wdGzMV0mbz0sFyUXPOOSf44cZGaFxjt37/MdPpo4XR/E2sPEawTZBAaBQRH7lZo5boIn2Nj0R3a2sQXnWkCif75349ql9ZSHYV4r+MnAPpCK8i1ELc//w9xm4Mzyhl20CTrVHMVQ9oMVnyYtsRDsU5SOSc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21, REQID:bbdfbb55-7f55-4209-b1c6-9b3aa2d853d1, IP:0,
 U
 RL:12,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:12
X-CID-META: VersionHash:b0318ac, CLOUDID:9fd54231-f289-4656-bb36-27baf4489f11,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:99|11|97|93|83|106|80|1,File:130,RT:0
 ,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,B
 RR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 24fd11d8e7af11f18dc8c9802ae25ab1-20261124
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 271574964; Tue, 24 Nov 2026 10:31:25 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 24 Nov 2026 10:31:23 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.56 via Frontend Transport; Tue, 24 Nov 2026 10:31:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GFjQSHC40xShTVQiQjx2BLzWQhTcL9B2fXemY5Z+OaTTRHoxZC4ybDaBCQmSWDd4zlnk2M6AfbWU2MFKIE/aoCzJ3CSjm/L5xb72+ahVIbOSnHYO6mB5qUDzor5x8NM3xwQKJJw53shyw+xF8Mi3bVRlwACmLXRV/zsKnOUC2Ra50ajDoviYcSwhpj2TijbP8G6mdKsvcgMdR2+fVasAsSh9FVt5uCwWYxjrjIzaQLi0uHXyPTeRpxpz9BVzSBfW0reKDoJLVAUrlpKbX9hgxztZs6DUZu9HN1U3okB5qE0IXyXYRON9PpLCiMuYf3mh437BiiAje0nYHjQrsWkrHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7/Td9BIRq9/tQEwZkr2bar8Jaioor79U/uNYdFTFgw=;
 b=F6jkvSCMewBSm1SKzJpUMEGcI3JiRYJIhtzso5fyX7VKBjscMIWy+fXNIC55ZurZzhgjJPXYKmF69llnJQirPCrwqhJze45hhMTQjL+7EUZI0ZSmodnMDZAirCuKCmPwHsW/cCzS1XUD/yelV/r8vEjJE5gmAkQzGW56+fPhp8dEYfLb51HNHFC4Qvug32QOW5Rk9gSYo7Li2C6gLtD6k2zB8h/45g2PEC2lwd7B0iuoRhU/J2XY2Fjs/1P+52muwsMfoa2a0mubFxtPmiUcSUXzF4tVZkGwaIi9Xi3NdWcZNnn8dtDw+G+3813P7o1vHf41SBO5dWMdF33k3J40FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7/Td9BIRq9/tQEwZkr2bar8Jaioor79U/uNYdFTFgw=;
 b=pasWkBAsKfMj/TCSGoROAcRwchmCPdby2OWFXDOXw9pzHKrNVZ67bBaFoogj8YqkFMp4ryMhtqrhTBu4l2GOAnRjOCHsOlXQPRKm7/aar5ruvQMHCunoiSC5efsoyWXZ/NChZeckDdA3S4Xw60Zl82y4XINxEu6w9IYPAMfuZuU=
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com (2603:1096:d10:91::20)
 by SE1PPFFD46BE63E.apcprd03.prod.outlook.com (2603:1096:108:1::873)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 02:31:19 +0000
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b]) by KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b%5]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 02:31:19 +0000
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
Subject: Re: [PATCH v2 30/46] dt-bindings: display: mediatek: Introduce MT8196
 Layer Blender
Thread-Topic: [PATCH v2 30/46] dt-bindings: display: mediatek: Introduce
 MT8196 Layer Blender
Thread-Index: AQHdE4ZnDez1KIL5zEeH3wHu886ZGLc9ULmA
Date: Tue, 24 Nov 2026 02:31:19 +0000
Message-ID: <70ed0b351afc640bb297d33582a20825460d9c11.camel@mediatek.com>
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-31-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260714114414.184512-31-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR03MB9902:EE_|SE1PPFFD46BE63E:EE_
x-ms-office365-filtering-correlation-id: 85dc2138-c1b3-41d5-7db0-08df49d305e6
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|42112799006|23010399003|1800799024|366016|376014|7416014|261102123227099003|261022115727099003|261022105027099003|261022113327099003|261022075727099003|261021121427099003|261021130227099003|261028144727099003|261021123027099003|261021133027099003|261021135927099003|261026140227099003|261026121527099003|261026130827099003|38070700021|4143699003|11063799006|56012099006|261026135527099003|10067099003|18002099003|22082099003|6133799003|261009223027099003|4133799003|3023799007;
x-microsoft-antispam-message-info: A6Q6OzaX4NZOrtAbexIiclY0wEr1MPD5IBHYfqY8GA3Sgef8Fc8KlvC8w4ZuMIKuEtwBOtPqrIp6lpwtTIyN3IQBmbB565FMn4s8ac4tGSChvXx5desleAOrr4abP/Uu9I1hvNAErLne7dNMDDpc79pzro7upG/3ShDeEjoJkoVZQwB1CZwcuDnYr4PCwNpPQ2Un8dpRLqHQDhxlQMtI9GgY4kI++N97gd9BLV4MnlbTX0him9qhkztDSb3zE6fE2ClO12wZlScq3cKvVZAHQchEtP5S9RcSQiGnqb0Bb6deszXVzJ5MUbmTiFAn51UjjtZiwX6CRS37GoT7uUsBa+fzu5Xic8lhOqwxoiiZoA6tqOwGNu0ZC7I9XMCHlwZGEFFLKcQAxhg+jBUMOlCPTztTXsZZuIkh68V7N2pfhNIfMyZyunF6/0gtbXOqgHsth5XiZCDAlFGBxyrR3Yzc76b20Fty3TJNN2YlNZL3qHjWbMNrYZL2bIyZyttSGqPpzb4ay0ovC5SODSkW2Cftzj+AUGxn+nfv5Xb9ufwCrRtH2HW5J9o1sOJuvBcck1sZQagjVINVbmgjcuK+vSKc2q24yxA2v7bW72hax2jpMna07OCYgIhf4wlJxqbkwuHolbqm6wDsAQcQxqImuXAPb1l5jRw/dDIK4L7NdhnkRJ4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUYPR03MB9902.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(23010399003)(1800799024)(366016)(376014)(7416014)(261102123227099003)(261022115727099003)(261022105027099003)(261022113327099003)(261022075727099003)(261021121427099003)(261021130227099003)(261028144727099003)(261021123027099003)(261021133027099003)(261021135927099003)(261026140227099003)(261026121527099003)(261026130827099003)(38070700021)(4143699003)(11063799006)(56012099006)(261026135527099003)(10067099003)(18002099003)(22082099003)(6133799003)(261009223027099003)(4133799003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2JqY2JUNldjeXdJa0p2cFREYUF3RStsTk1QbEVNZ1haQzFpdjhxVEpPTWk2?=
 =?utf-8?B?TnhkR1Y0MjVad2RBRVkrbUJlUDFOUitzTzIzQm04K3hlNlhiNy9MNHJhUENz?=
 =?utf-8?B?L09aZGNCTi9ZUUZaZ00yL0tlTHhqbGR3cW1WVVFVUmtpLzQvQkNiL1Z3YkNZ?=
 =?utf-8?B?TTJxeG05V0JheC9BVVVSam9PQzhnVU9DTUQ1bnZPYURGRFZySEpzZzliSHFl?=
 =?utf-8?B?Q1JpYmZvTit0L0ExWi9mSHZRcXdXR1VZbU9WTTdjT1M4TjZ4bVI4YlYvL1NS?=
 =?utf-8?B?c0dzd01KYWpRdjFFVGxETm9VaVNjd010WG42TXhtOEZudXZ6d1l6WFdMSFF6?=
 =?utf-8?B?bWFMbEs3MGgxdWhvZlJmUlFyQTdUbVNLUG55WlFGTGEvZXR3Qll4SHBScm1I?=
 =?utf-8?B?UGl1dmcyREozQW9tV0g1MmFBam8rUkZhN2trbnlRR0JTdk5oVzA0V0oyaTFZ?=
 =?utf-8?B?OHBMREhUSDl2Z1ZEMFhqWGxMTm1ZS21vNFg5eXJYSmIza2cyeGgzV21yNmdC?=
 =?utf-8?B?d3lMYkV1ZTBLemlMUFNDWU00Ym51cDFFUW10a1ozUThPV2J5c3ZQYklNT05M?=
 =?utf-8?B?TzRTT1Q2RTU2YTN2aXRpTXpURWFxVlBGems2QzFvL1FxQ2Y5cEY2cFhVYUJB?=
 =?utf-8?B?N2p3bkxBbG5ZZDdkVDRpUGhSKzNOZDNlbTllUHNIckFZbVJTZjFEN0E4aDRq?=
 =?utf-8?B?NU1EQVJhTEd5NVpjU3pycWMwZUdxWGVXbW91QjhxQTREOHRqdERqV3o2WFlG?=
 =?utf-8?B?UFRtSXh3N2JCK1lTRkdYUkFhWWdGM0xZOUg1TzJDZUFzT0lmMlBnckJ3clVU?=
 =?utf-8?B?RFZzUGErR2JETnFBdzBOYkpXN29pS0pNYUd5MmtVQ1M3cHpoWDRPUUI2R0FB?=
 =?utf-8?B?aEUvRm1rV09wYkJjcGFMYW81ODRiS1lzMEQzTTFPVDR2ME5XY1FLL2VqOTYy?=
 =?utf-8?B?MzNSOWdQTU0xcEMrU0dmT2lZaUUyWEFibHdkTFdBTlkwUStDYTcxbVQ3a3RS?=
 =?utf-8?B?YVUxcjMzeWlPRXhNN1Vkbk84dDZmN0dGUDUycWtnWC8va0NZamVwNmtJMmFZ?=
 =?utf-8?B?ZTNDTzg1QzNqbHJLd1ZuYm1qQzV3THBiSVFsYU5tVGI3b3I1MDh5R1lmMUdZ?=
 =?utf-8?B?Y3FCcG15Y0hhUjdJTFVuLzNndng4cndTSitsZ2s1Y1N5QWVLMCt5dWhPamE5?=
 =?utf-8?B?dmtZSG44dlVPM1RxSTU0MWZQZi8xSGV4Z0hYRFFnQTAzeG12WU9vV3dFSStJ?=
 =?utf-8?B?OW5nbVZzSGI5aElkVlQ5aTI4OGhvS3RhbjJXTXV4d0JaUWtwRmsrWWxRVE5Z?=
 =?utf-8?B?Q3J2Y21YaWduWU15aXh5L3l1Zko3N1dESjFWUWkvQ0VxUnZDWVh2bXNNS2hK?=
 =?utf-8?B?NDhyM3ZPeFRYeWlyRjBoOW1Na2xJL2dUQVcwbnVHRGJEZ05yWmpveU55U2w4?=
 =?utf-8?B?REhBaGZqbjZ5dXpseG8xNTkvai9teDJmaHFON1IwMmRZcFV4S1h4Nm9OOTQ5?=
 =?utf-8?B?V0Z4M3ZreFhMZ1puWjFaRzFDV1pCNjRlQVZ3aXNZenphc045eS9vWGQvckVr?=
 =?utf-8?B?MVJ3eGZydEp2Qm9WbVZ0cXNxU0xtbU8xclB6U2s0N0hBTzJVbWlDTGQvWEl6?=
 =?utf-8?B?b2dvWFh4Y2dwUndoSHlTeGlRQnY0ekdyS3ZORDhZZVNVdEZNbUV0TEx4R0pj?=
 =?utf-8?B?S3VUSmFLZzZtcVQwMFpNYjhvQXV3Tm9LdWIrc0Z5MC9jRkZSbmhxTTZ2SXA2?=
 =?utf-8?B?SEp1RTZkaWkxd2diSW5tb0xFMDZTaU5xQmE3bkx5OTVpTEpDaENRL213Rlg3?=
 =?utf-8?B?KzIwTmN1Y2lybDI1TVFxMXAySFdkajBSdHc0L01qN0JRSWJIK1pqT21QQjND?=
 =?utf-8?B?YXhlbVNwOFM2dzdMWUVieTlFMWtvR0NuWWtKVC8rQVVkVUNjSlJvb2VaeXUw?=
 =?utf-8?B?RDhLOW1HRHFxK2d4VndiSmlmczJoaG0rcURnVURjaWZTUEhJRFpETFFYTXBQ?=
 =?utf-8?B?YTRZZkI4bFE4b3pBeFRDVE44QXo1eVFoWENEck9OWTR6a3V3ZjZhYVdZdlZ1?=
 =?utf-8?B?alExR0lEb1IvOE00aDBFSlFFbU4waEVUbUhwZk5qSWRJbDBHaXpqbzZGTVhs?=
 =?utf-8?B?THl1aEZvNEJMeXVlZTk0dXk1V2lMN3lNc1BaUWNxY2ZsLzRNQXN4UVJjdnAv?=
 =?utf-8?B?cFhzdTV4a2ZQRzl1MGxYZGVxcjcvSTRQMnpWcktCZHlnVEZ5UjhZamJwaHZa?=
 =?utf-8?B?RVR4cVF6UVdQLzRPN1NueFZjc0krdDBsK1NsdXkyY2xlZWd2U0NQSEw0bEtU?=
 =?utf-8?B?Z3hTcXEvVHRWbUVVcmNjRTFXZUlZZTUvN2llOGVTTm9KWndEYWZnZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C3889780E181348ACF90C5984357278@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZVbzxZU9StUD+nHGepZb9TZRHhEfrKeuCHvE4Sf1lyhtlYQfui1BKCjtCqfIx7eAKIXCvK/Az6R9GoAW1ns1dQZxCxX2/7Gu7cQCvqg60c+ujj08+IHa16hlSVBzVehXIZESK8adW6yKImEPpnfQZ363z6lHTyNTIpRQRARzPEhOhKSF/4FZMdaJueyxmakQT3eDiGbDFY9o9blM62VYqNXw/FTBO/0+fg/DMiW1deoB77SZ0B6VVj4+HM92bdOSvbHK057eDM1qFG6X7uLXmVWB2ldCjuGV5+ttegRY6KMqrBeMskhM6d+qEc17xWwFyL0Gy+s9jDNCFZzh4R+7Kg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR03MB9902.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85dc2138-c1b3-41d5-7db0-08df49d305e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 02:31:19.5626 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JCSzA1C8uykcC/K4/Ib9kAoidEzon7RTxyfU8++xEUmIrZbtSFibgnaH1whjqhK5wTRFiUp+G6QUsluxpy/7nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPFFD46BE63E
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
ZWdubyB3cm90ZToNCj4gQWRkIGRvY3VtZW50YXRpb24gZm9yIHRoZSBPdmVybGF5IExheWVyIEJs
ZW5kZXIgSVAgZm91bmQgaW4gdGhlDQo+IG5ld2VyIGdlbmVyYXRpb24gU29DcyBsaWtlIE1UODE5
NiwgTVQ4ODk0LCBNVDY5OTEsIGFuZCB0aGVpcg0KPiB2YXJpYW50cy4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9naW9hY2NoaW5vLmRlbHJl
Z25vQGNvbGxhYm9yYS5jb20+DQo+IC0tLQ0KPiAgLi4uL21lZGlhdGVrL21lZGlhdGVrLG10ODE5
Ni1ibGVuZGVyLnlhbWwgICAgIHwgOTcgKysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNo
YW5nZWQsIDk3IGluc2VydGlvbnMoKykNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxtdDgxOTYt
YmxlbmRlci55YW1sDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssbXQ4MTk2LWJsZW5kZXIueWFtbCBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlh
dGVrLG10ODE5Ni1ibGVuZGVyLnlhbWwNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXgg
MDAwMDAwMDAwMDAwLi40MDJlY2NiNWZkNzANCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxt
dDgxOTYtYmxlbmRlci55YW1sDQo+IEBAIC0wLDAgKzEsOTcgQEANCj4gKyMgU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KPiArJVlBTUwgMS4y
DQo+ICstLS0NCj4gKyRpZDogaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHA6Ly9kZXZp
Y2V0cmVlLm9yZy9zY2hlbWFzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssbXQ4MTk2LWJsZW5k
ZXIueWFtbCpfXztJdyEhQ1RSTktBOXdNZzBBUmJ3IWdmSWRleFJBSnFJa25MU1U4Ny1SeXZLUFlt
Q2d0TFAxNkNXc3Rva0NwTHlEN3h3c2ZJWThYbi1hM2RQek5jbjhkSGxERWlUb05wUGtQdEkybkh6
U01GeUZBX29jJCANCj4gKyRzY2hlbWE6IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRw
Oi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCpfXztJdyEhQ1RSTktBOXdN
ZzBBUmJ3IWdmSWRleFJBSnFJa25MU1U4Ny1SeXZLUFltQ2d0TFAxNkNXc3Rva0NwTHlEN3h3c2ZJ
WThYbi1hM2RQek5jbjhkSGxERWlUb05wUGtQdEkybkh6U01KSVRXVlVfJCANCj4gKw0KPiArdGl0
bGU6IE1lZGlhVGVrIERpc3BsYXkgT3ZlcmxheSBMYXllciBCbGVuZGVyDQo+ICsNCj4gK21haW50
YWluZXJzOg0KPiArICAtIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9naW9hY2No
aW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+ICsNCj4gK2Rlc2NyaXB0aW9uOg0KPiArICBU
aGUgTWVkaWFUZWsgRGlzcGxheSBPdmVybGF5IExheWVyIEJsZW5kZXIgaGFyZHdhcmUgaXMgcmVz
cG9uc2libGUNCj4gKyAgZm9yIHBlcmZvcm1pbmcgdGhlIGFscGhhIGJsZW5kaW5nIG9wZXJhdGlv
biBmb3Igb3ZlcmxhcHBpbmcgbGF5ZXJzDQo+ICsgIGZyb20gdmFyaW91cyBzb3VyY2VzLg0KPiAr
DQo+ICtwcm9wZXJ0aWVzOg0KPiArICBjb21wYXRpYmxlOg0KPiArICAgIGNvbnN0OiBtZWRpYXRl
ayxtdDgxOTYtZGlzcC1ibGVuZGVyDQo+ICsNCj4gKyAgcmVnOg0KPiArICAgIG1heEl0ZW1zOiAx
DQo+ICsNCj4gKyAgY2xvY2tzOg0KPiArICAgIG1heEl0ZW1zOiAxDQo+ICsNCj4gKyAgcG93ZXIt
ZG9tYWluczoNCj4gKyAgICBtYXhJdGVtczogMQ0KPiArDQo+ICsgIHBvcnRzOg0KPiArICAgICRy
ZWY6IC9zY2hlbWFzL2dyYXBoLnlhbWwjL3Byb3BlcnRpZXMvcG9ydHMNCj4gKw0KPiArICAgIHBy
b3BlcnRpZXM6DQo+ICsgICAgICBwb3J0QDA6DQo+ICsgICAgICAgICRyZWY6IC9zY2hlbWFzL2dy
YXBoLnlhbWwjL3Byb3BlcnRpZXMvcG9ydA0KPiArDQo+ICsgICAgICBwb3J0QDE6DQo+ICsgICAg
ICAgICRyZWY6IC9zY2hlbWFzL2dyYXBoLnlhbWwjL3Byb3BlcnRpZXMvcG9ydA0KPiArDQo+ICsg
ICAgcmVxdWlyZWQ6DQo+ICsgICAgICAtIHBvcnRAMA0KPiArICAgICAgLSBwb3J0QDENCj4gKw0K
PiArICB0cmlnZ2VyLXNvdXJjZXM6DQo+ICsgICAgbWF4SXRlbXM6IDENCj4gKw0KPiArcmVxdWly
ZWQ6DQo+ICsgIC0gY29tcGF0aWJsZQ0KPiArICAtIHJlZw0KPiArICAtIGNsb2Nrcw0KPiArICAt
IGNsb2NrLW5hbWVzDQoNCmNsb2NrLW5hbWVzIGlzIHJlcXVpcmVkLCBidXQgaXQncyBub3QgbGlz
dGVkIGluIHByb3BlcnRpZXMuDQoNClJlZ2FyZHMsDQpDSw0KDQo+ICsgIC0gcG9ydHMNCj4gKw0K
PiArYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+ICsNCg==
