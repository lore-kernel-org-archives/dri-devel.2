Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399AD606A32D
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 07:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=WcADhDRp;
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=GWu/dGcy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B58F10E53E;
	Thu, 12 Nov 2026 07:01:18 +0000 (UTC)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 948F410E53E
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 07:01:06 +0000 (UTC)
X-UUID: d18a4238de6611f1b1788b6acf885367-20261112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=Glco7WlbQSewXHkYjLvIA2clNYZKnaeVkqiiPTpLK3I=; 
 b=WcADhDRp5FlXOjXMv364BOQDEzXtFOMmGx5H4MBgC8L7ue+yLglhFH2imBVt+FgrkfGaNcpIC5w/z4z6xng2KCud1NzkyUi1D51PFXMdhfJahsRIRckJGlVqny07oloYhTMebq7rnW+sYMo8PTPe9qCU/8+rlkc5v8OpZSzgQzY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21, REQID:19ea798b-74df-400d-8bc2-3888409fe6f2, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:b0318ac, CLOUDID:7b6c3066-4b51-4c95-bb1b-80ac6aad9c96,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:n
 il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d18a4238de6611f1b1788b6acf885367-20261112
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 735501726; Thu, 12 Nov 2026 15:01:00 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 12 Nov 2026 15:00:59 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 12 Nov 2026 15:00:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uKZPcXWPiQU9sY/2bdhKZ/X4KeyTIvJcKHQnzXpWDEFzluRAxXz8FGwvTKhAG8jIyl5ZYPWUib67c18az1QyB22JanJMcWk+qL2pmwGcj8Kig1pcF5xT2dLMuDu2CE9mSbAAW7Jbdkitfl1FtE446fRjguO4+ikC2VMRN/VzfWqiaAEXEf57XdQimG2oQR6Avelz+WYPUOjQYs4hIbEOo/FQKaIZri4vV+iodayZ9pHlTX+5o/YvatsTH8YBKjsNYU/Kds0K1L6xytuMDhRDuMg5LD0fC5M0KO2Ka8X42uqJIy/Zlm5VCSO/HEWtIHR0ccer4uwkbQEUBUuJQDLKlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Glco7WlbQSewXHkYjLvIA2clNYZKnaeVkqiiPTpLK3I=;
 b=LtmoB+WHZ2m1/+otCCTH0xvYlCuYUlbJyphbEh/N+hsfiGh2hvlpzhw2ntCN3yLkJU3baHU5GyXmDZBz0kcZbOu+HLm9oh/5/Jft8xc03Uac3zlj4HNODwS2OUkmxMeiV8bOBE6G65NMqrw2yh0gAKN4l1nUjvCWUgpGwqvfky9kk7TvsVoCbwUGmiFDWUTzrWODruk8XeTyg3Razj0jhmROc+ruAXXG2+faHmpL2wZLGfr0BFP6kNu0u8tBaOtDTwH6WGHYw4MxRs6YRNPjUJ2h6COOMcmZb5EkdP8dVceurjfRQ8UQJnlb8WTy602LZtcwQfbNySs2mD/rHxKkgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Glco7WlbQSewXHkYjLvIA2clNYZKnaeVkqiiPTpLK3I=;
 b=GWu/dGcy3V+vjV6pWL+SUGMP9yL0Wswavh5cuDZE9brxtJpwAHMQJn1sP3uM5hlJeqGk7cwezrnyw5qtV959BdY875QzmfW5Jaym7tWOhT9lGz4op/wfpf7q8EaMLNckmdTl5R+RP7F9oCR8C21BLSz/Dw7i0NDHCLFSydfLMOc=
Received: from TYNPR03MB9924.apcprd03.prod.outlook.com (2603:1096:405:3d6::13)
 by TY2PPF956618BAA.apcprd03.prod.outlook.com (2603:1096:408::9dd)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 07:00:54 +0000
Received: from TYNPR03MB9924.apcprd03.prod.outlook.com
 ([fe80::6274:7513:996f:7f8d]) by TYNPR03MB9924.apcprd03.prod.outlook.com
 ([fe80::6274:7513:996f:7f8d%5]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 07:00:54 +0000
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
Subject: Re: [PATCH v2 24/46] drm/mediatek: mtk_dpi: Pass parameters with new
 mtk_dpi_sync structure
Thread-Topic: [PATCH v2 24/46] drm/mediatek: mtk_dpi: Pass parameters with new
 mtk_dpi_sync structure
Thread-Index: AQHdE4ZhlnIFCbqI4UqHpmhZ72S0yLcqwBCA
Date: Thu, 12 Nov 2026 07:00:54 +0000
Message-ID: <ba2a10ee5e1c2a4090b89a5991038d234a4b6791.camel@mediatek.com>
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-25-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260714114414.184512-25-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYNPR03MB9924:EE_|TY2PPF956618BAA:EE_
x-ms-office365-filtering-correlation-id: 77c0cb15-a4a3-4e9a-f317-08df408ab1e2
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|42112799006|38070700021|10067099003|11063799006|56012099006|4143699003|261028144727099003|261021123027099003|261021121427099003|261022105027099003|261026140227099003|261022075727099003|261102123227099003|261009223027099003|18002099003|22082099003|3023799007|6133799003;
x-microsoft-antispam-message-info: 0WNlEdJw+phw4lHILKxIVxso6cOKGsZ+DMkSsy5UDBRU2M3JGzvhxZZexy/95sitQBSoChEfoG9Qlsj1kSvSeTqfEoVkBxRgl2t1pZJffRuBdXxyFon9B/ogA5yfWA7bV05fFc6AbHbztAfBIbhTCrLIJAedrn3qT1JCJZnikSg3GPfBTrCpF9q2+OyibJdbjmgBnO0/mvDtIMvk5wXqEKzAYpCF90JIgXZqlrzLaSwKAzkk48EZjXVII8dw63Z1slAcH7niaebRb5HoHq/7psn+g4MY09VKnc1YOlnHFhE+bLkoWPLfFAhUEYS4DkXz50Ddnln4zjZA9Y9vBfI/HhuI0LcGqvln0pt2beWM6XMHRtuZPyHKv7723vM1+Z8d12VK7QbS5hUYJW4gOAZqlFBaO+rDSwyU4x2sqNC2kd5rcdak8Czf5cTErK+IwkGu9XIgl0PZMQK7J5KpYHzllU1luHfhJhkIaLHrjQ2fkLG3sOp3UKm0uPxjQ/M9rxkCNiBZwiWIX3I7Stitdc2H3TE3cQs7Vh5C4/VtiojbRYvMrpM/+t0fQiFMUJvyIUCTye8TwalOarTgjaiAK1IrNn7gOnATrU0L2teEue5vLFz6nJBs7lvY+R14gQPmOmWZWnOzdy+zZDLjXD0TsXYhiQrESa25Z2000PDgEubUmWTxbnAoDMIw9uV1YNOOwFCZJsc4/1zCFt6xSRXTGHWmHb/XCh0vzASSJm/0enXF5rg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR03MB9924.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(42112799006)(38070700021)(10067099003)(11063799006)(56012099006)(4143699003)(261028144727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261026140227099003)(261022075727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(3023799007)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sm14YTVWQmpSUXJMM01Kazk2dllDRWZXM2h2aytzV2VhcnU5ZWxyemVnZUFv?=
 =?utf-8?B?bjRxaDFOaWFSWnBHenZ3bkl1aUpkQS9VQWRBa2V5TXBqWWcwVkZMS2Q0MzZH?=
 =?utf-8?B?Zk1PL1kvS0xVU1UrUUN3cTBsZW9SWFBMTGZEUGhqeVA5T1lhU3lRSnMzQVhi?=
 =?utf-8?B?alJ4VUp6YkRmSWloRUJqTllQcmM4WUpSSzdSUlhDWjQ1ZGZ2VkJYK2VuOEdE?=
 =?utf-8?B?dHhhKytMVDA5a0QyUXd4WFFEM2s5UkZ5YlBLZGFxeGp2TU5LSzV1aGQyTVp1?=
 =?utf-8?B?SndqWElaU0kzUzhzazN0NmM4UVNURmt4eVhXVjBVR21KN01uUHFYUFltU0E0?=
 =?utf-8?B?bkdETkdOeUhYT3paL3BFc1kxOERFcW9GQlFjU0IyZ21iUVhSSENoWWlWMWRS?=
 =?utf-8?B?Q284WUsyc1hxWStpeFFiY21EbFhmQkJwV1d6VDdHTkllRVQyd0ZVUFo0MGwy?=
 =?utf-8?B?bUViK1pLcXNieVBkTUxDcXFzbS9BYnR5NXUreEFLMXVzdHVUdGcyN3B3MDBZ?=
 =?utf-8?B?RXc2ZTVEVW5GRlZ3amdBOEhEeEZFTS9idXYrclFXQlVDS1NBMnNoZ0NSWW1U?=
 =?utf-8?B?TWpvQWZTLy9TK2JlODdZbk1jSk5xcjhkVmJkeUYzK1o2T0d3bDN6TWUxYjVS?=
 =?utf-8?B?ZlVIaWRrWEQvVE9YdDdBbWdTMHdxWU01WXlWYWNnekF1WGFJNFZ2NzF1ZURF?=
 =?utf-8?B?eGlXREY2Y1VRY1Ewd280Z1cxeERZSnRtMGtNU1k4RlFib21oYWM0ZTEwVFFM?=
 =?utf-8?B?NnM2RCtVRlY0OFVTZUw4YllEaWZEMWRYYWZDU1pzc3lNQlY1bFlWZWExS1Vx?=
 =?utf-8?B?QUxoR3dYeWt1Z2IwT05QMysyUEI0MStNY2NTWVp2V3FjYlY1cUNOeUU3eVB4?=
 =?utf-8?B?YXQ4Zm4wNmRJTGk0OFUyYzhxVytZMjBhak5LMGx3bUV1VFdXb00wV3Q1NmRK?=
 =?utf-8?B?MHhDZEx3cXhLSWthYWxydjBxYklJckYyQ1JtNmd2c2Nud2kxKzNCZjdiemtU?=
 =?utf-8?B?WWxUM29mWEY5MUlGYzk0TlNZZ2Z0dS9TYWFLVFFLaURlQjAvY3VpYTFqWEVl?=
 =?utf-8?B?cGlYNzE2UDYwM1l4KzY4ZkZ1OUUreGZYMHA3NEF6VzkzSFd0Qll5UHJSdkp2?=
 =?utf-8?B?YW1sZVczb3QzaER2RDgvMm5JTGFGRGpZcDVuNnIvTUI0LzhBUTlWbDdQcEhp?=
 =?utf-8?B?VVBBOWVwVFp4VjNJWkhRc014SVBZUHQyQzRxbzhQZE0vZWpEaU1OQnlOSFRF?=
 =?utf-8?B?VStUYzBZOFo2V0lQM1hLSkV4bGlDVm85SUtUR1lmdUFVcGJCZFRMWkNlaUJD?=
 =?utf-8?B?NmFoRnluQURwWUpNTHVsRGdBUjR2ZW9LTjdieGUreVNmTUFwZ3M3NXEya2Y2?=
 =?utf-8?B?ZW5DbHhwUXFDdTUxVk1lN3FOSUlmK25lWCtGRzFkNVVGYUZ1WXhpM0lzeXN4?=
 =?utf-8?B?L1d0Y1dzS1B5K0dCSlhLb0d3THl1dHNtRG45dks4eFNDTmkybW1uUk8yNW4x?=
 =?utf-8?B?YUUzTjlIais2MllPL0tXN280Y1IvVVN1QkZJWHZtWEVEckZqQnpRdjBNZVFV?=
 =?utf-8?B?dlBzdk1kQXFkRkd1KzlFRGpvakp4WE8vMU1oN3ZYWkFpU0ZTbXpkOGxGMWRp?=
 =?utf-8?B?MFA1T1o5c3lDTTRMamk4NUxadmErNktVMllpWHBDa0I2TTdsLzFaRHJCbWxr?=
 =?utf-8?B?ZTJ5N0NnVjNBZmhCeFlVZHYxRER4UE50WE4wK0NHZ3hRdlV0Q3lpRzhNQ3po?=
 =?utf-8?B?VW1Wa3d1d0pDTVJkN0JnaHllZTlQMDR6VE5PN2g4bm51cCt0NzVIOUpWbG11?=
 =?utf-8?B?citnSzhpS1duVUE4YzJ4Q01jb1I1TVIwWlBqa29NK3dDbEl5UzlITFZ6R3Yr?=
 =?utf-8?B?eG1MbWErZXlMVUVuZUhLVnRXTnhVUlNrVHBsaHJybHZ3OWhISThtaHl1OVg4?=
 =?utf-8?B?NVNRUXVzK2ZQOXVBcTdsOG42cGRmbytodWQ0TWZvalZ2bmhYcml6TWtDbXVS?=
 =?utf-8?B?UEdTT1Rjd3MwbW12amxwM21sL1dFdFo0SDNUa1BzYXRrT2hYdWdhQ082V0Vw?=
 =?utf-8?B?aThQQmF0M0NrTDZkTG5rbHBaaVlJaWNMUnlFODZxaHlKYmFROFcyRkxaRmNL?=
 =?utf-8?B?aUNQcWs2UWE0MmpUZmNUaGRGakhqelMvaHpYZVRrdFZLRlZMTUJqR1FTNXFo?=
 =?utf-8?B?d2RabGFBRjVvUTViTnJTRHlPVWFFZGJ0Um5mck9xRGxlVEY2VExUdU11UnZi?=
 =?utf-8?B?QlZjZ3ZlbjhWNzlIVDBaT2xvbDk0ckhocXZYUU1wRFZGVmVvem9zMjVTdElh?=
 =?utf-8?B?MHZHQUJlSjZsN0dqL3lTMllFTm1taXlKS0haQ0lHaHBRV0E3Z2d1Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9AE09010CA1FCE44ABDCF28CE1118776@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vkDugxkJ9EZGYJ4moqrZiWLWkDrvciwn+9QSTJE8GmR7ZgRYCWKRxHAIhbR0X0AgccYQNiTuw9YUu+KgDAu3q2hjKSxUlNc8s0STchn9pHBn3VCAqasuHB6VVLccNBP6Vuelq/eVPQzh52GUmcCqSgejV7Ljvb++zU0ghT2fUF0hYh1M8WLNgmBNqDj9/9sH4w9AMHEfg4TABjozKhf0/I5mOFxMZnBn9m5hVrDFxdlD7M9ay0VkKy7i1QvVlChMSmlSviezPNd8UXpVGuIG5kjxgLk/yeJhwwmvcm/4pI7GddH7LlSGRgxt2hWy9As/Lgi7GsZI8+lmOwtZMFkSsw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYNPR03MB9924.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c0cb15-a4a3-4e9a-f317-08df408ab1e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 07:00:54.3724 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oWWELttST1tT+yd7araokNPOdLTpZNLZ9zYzyzallmtjchPiy7M28lHIMu3TUK6Ir9yQeUR4zgxGb53qHfN/cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPF956618BAA
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
ZWdubyB3cm90ZToNCj4gSW4gcHJlcGFyYXRpb24gZm9yIG1vdmluZyBjb21tb24gY29kZSBiZXR3
ZWVuIERQSSBhbmQgRFZPIGludG8gYQ0KPiBuZXcgbXRrX2RwaV9jb21tb24gbGlicmFyeSwgYWRk
IGEgbmV3IG10a19kcGlfc3luYyBzdHJ1Y3R1cmUgd2hpY2gNCj4gY29udGFpbnMgYWxsIG9mIHRo
ZSBzeW5jIHBhcmFtZXRlcnMsIHN1Y2ggYXMgSFNZTkMgYW5kIExlZnQvUmlnaHQNCj4gT2RkIGFu
ZCBFdmVuIFZTWU5DLg0KPiANCj4gVGhpcyBpcyBub3cgcGFzc2VkIGFzIHBhcmFtZXRlciBvZiBt
dGtfZHBpX3NldF9kaXNwbGF5X21vZGUoKSBhbmQNCj4gc3RhY2sgaW5pdGlhbGl6ZWQgaW4gbXRr
X2RwaV9icmlkZ2VfZW5hYmxlKCk6IGZ1dHVyZSBwcmVwYXJhdGlvbg0KPiBjaGFuZ2VzIHdpbGwg
YWRkIGFic3RyYWN0aW9uIGZvciBoYXJkd2FyZSBzcGVjaWZpYyBjb25maWd1cmF0aW9uDQo+IHdo
aWNoIHB1cnBvc2Ugd2lsbCBiZSB0byBpbnRlcnByZXQgdGhlIGdlbmVyaWMgcGFyYW1ldGVycyB0
byB3cml0ZQ0KPiB0aG9zZSB0byB0aGUgaGFyZHdhcmUgc3BlY2lmaWMgcmVnaXN0ZXJzLg0KPiAN
Cj4gVGhpcyBicmluZ3Mgbm8gZnVuY3Rpb25hbCBjaGFuZ2UuDQoNClJldmlld2VkLWJ5OiBDSyBI
dSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG9HaW9h
Y2NoaW5vIERlbCBSZWdubyA8YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29t
Pg0KPiAtLS0NCg0K
