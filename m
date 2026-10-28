Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A1D606A31D
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 08:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=KKYPc24H;
	dkim=pass (1024-bit key, unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=B7ht27RC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4631F10E5C4;
	Wed, 28 Oct 2026 08:33:53 +0000 (UTC)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C72810E5EC
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 08:33:41 +0000 (UTC)
X-UUID: 44b216d2d2aa11f18dc8c9802ae25ab1-20261028
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=x1wjdkkLHKbPyq4rwxuPHIyH/DMK9lBe0YinXFIkN8w=; 
 b=KKYPc24Hnz1iFKjnaMCuwgTmnF5YbVpOHlSEAQMF8nZPWHep/3pUR2EwVvilSsfb+jNyKjfdKXnzNc+Az5Z1xVtZfQfQa3r9vPmqxk3TIRxnHg53EEHkr3Gk1oVPE0PxUYXIxaD4HneBF101ykCGpPsMCfZeTDoC6GPEJUODPTY=;
X-CID-CACHE: Type:Local,Time:202610281633+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20, REQID:3c45b5d8-eecb-4a40-8db3-7db36a1db68e, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:291e20b, CLOUDID:d08f8344-f973-40c6-9c31-f078afa73356,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
 1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 44b216d2d2aa11f18dc8c9802ae25ab1-20261028
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 306256192; Wed, 28 Oct 2026 16:33:36 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 28 Oct 2026 16:33:33 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 28 Oct 2026 16:33:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jk52nlp6Hk3wt0FcXBatxL0M1AhCK4AQqwaWvEnus+FcZjceaiEmv6onxIAf/FLCOZ+g7nUQrFlE9bvap15Pf63JaHKZwkkoWcy7xO1ChRdeSf73JoE4PYV+kvocMvoF8z5GktJ+J9LPYALVG1ZXmiz8r2wZJkI6pgJjuk0Fg/ZxZA8JkJlNz+1poojKd7GIq/vtb6sAuxiZ4LcNZ/dSx3utmxKsZ06kOI9egVUY6O8U/98B4geM2X6WXzovV5VI0Iypdorqb3HlOGDEFxJfmizRqDDt48AeaoXvfyudUWGrxSpeGQr68+eFNmbZbttKEsrlW3ffRN/sE7SHvG8HQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1wjdkkLHKbPyq4rwxuPHIyH/DMK9lBe0YinXFIkN8w=;
 b=ftqy4DkhHr7dsqm0nR0FAx9ZowcpMaFZCTQLX+Fggbkp7i4iS2ltQ4xgFW/lsRtK4LKxdb+9/UBnQucQnvpco7hdoY564DGmlKInkUZOMzWv7qyzZwUqUNKrmMWggndwqd8txnYWOO18K7nk32JTnRZIhd2zZOwKjXkHNJCJhpVWiwLfDIxQWFRDdhhpuClhfQzp7Ozu1dLp1Ybyq6ovCStDYC8KXz2w4wT9MVVsST2WaymZfDmuhD11RX+fn1WkvbYnokuJExjnDYouvMsdBJq4lvldCi03piqdF7+AK3675Xo11aeh3YHCpaQONHTfdMDfp6NO+dyy/mAZZWmM9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1wjdkkLHKbPyq4rwxuPHIyH/DMK9lBe0YinXFIkN8w=;
 b=B7ht27RCGYxt+8SOdM81DCRTYqgk4VQbp8kSX8SSon7QkwnVt3EflCFLnUlkpXxqPIolRBddUsuUDO35bcCzSYcfNSLN0aFP2nDPAiunE+xPFNcP42tYnSxKtRUX5eSSCBX4o91CUOQIcB0GS25+CDsiJ//my8y1mr1RpFLjl94=
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com (2603:1096:d10:91::20)
 by SEZPR03MB10114.apcprd03.prod.outlook.com (2603:1096:101:337::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 08:33:13 +0000
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b]) by KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b%5]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 08:33:13 +0000
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
Subject: Re: [PATCH v2 12/46] dt-bindings: soc: mediatek: mutex: Allow
 #trigger-source-cells
Thread-Topic: [PATCH v2 12/46] dt-bindings: soc: mediatek: mutex: Allow
 #trigger-source-cells
Thread-Index: AQHdE4ZU/5fF0zNiPk+f20Lijb7RU7cTRuSA
Date: Wed, 28 Oct 2026 08:33:13 +0000
Message-ID: <8ca1d3e045427e48007572c573eaf37115ad2acf.camel@mediatek.com>
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-13-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260714114414.184512-13-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR03MB9902:EE_|SEZPR03MB10114:EE_
x-ms-office365-filtering-correlation-id: 7a717a3e-489d-46f2-1572-08df34ce1b59
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|23010399003|42112799006|38070700021|261021123027099003|56012099006|11063799006|4143699003|10067099003|261021121427099003|18002099003|6133799003|22082099003;
x-microsoft-antispam-message-info: 2KvzmoJ8GEwscJPtt8wQdP0po5SJvElc1Z3cJqrhnxFkF5tUcpqMhX5YkFARwVrjBROwNc9YtMBWfaFzzwIf2MIxbEO4Ivkh18RuwH+GxRp0SLZ2lH46mRwJrIKmdETNgGnnj9qxIK099DhS6NUFxSRAOUGO6akWWgbFj6Jxv69sN0L001fQn/TGob3ivRhaPuhMEXdh+i3qZbmjNZFhRQq2c0X98OsqD3l3uO0vI80+kiOON4aS+avI/V93FnK8q0aHnYp9ntt//DPwQQa/ITgKGMIS+cNDyAk6w9l9RbaOGMMTfT0dqaR4YZ/R9qXJHbCwtfbNcWckyJEmA/T2XeHW3grPlT+4KZdMiypHjPpxsHxwb/IrJgOFrHoBN2h1n9ADJ8n6C7+qpqYGbGmEVFAAAbyWllIByCPKDo5J1muTeYKYWQZnoN6V1JOIg8q3MICNBH1mX5Epcu5R7Tf6IukbRV/XR3jsICWcUfkv2d3XKC0nScudNS38Q3yJ3OrkYPtWp8pl4WZakNLyd62nPSFprVdszdUvDN3+Id1mrIQGqkbILKVhvQeVrNNOle3N3GFAPBJGCf7aGTdLgNdShC18vm9S3QpMXVLqa/WkpVEJ66yWW1O7NyZ4KHc8evR8Guf58Ocy+OVV/MfHuwG8l1o1Is/ReTbL4XxOeX+s15LfUY0hMS7pJ6OwquoDv9pQpP43n3LT5/Y3siF97mDn+KuN39ARvYT9RHzxUpTdI8w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUYPR03MB9902.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(42112799006)(38070700021)(261021123027099003)(56012099006)(11063799006)(4143699003)(10067099003)(261021121427099003)(18002099003)(6133799003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDhXNEpnOEpmRVZHWnFnSytwUUtCcTZGajdDQUtLcTZhNlBJUFNqUHgyZ3ZN?=
 =?utf-8?B?Q1hOcHJWSUNYRGpHQzhmc0ZCYnN6MXVaaWlRUlVXWnd4V3RZWFgrZEsyeEE5?=
 =?utf-8?B?bG5ibWxnTHVrSjYyaHFaZk9CUWVLazFLOGhLKzUxV1o2L0VybjVZTGNXc291?=
 =?utf-8?B?UnI3Q3JlTFBqUXJYSjVBYm4yTlhNQ3lkenFwK2tMMnE1d2lqVDhjYkJxRmVh?=
 =?utf-8?B?bVJFZ3FTcFUrWFQ4RjV3RXBWRHlRRERld3loVFlJMlFrRGFlR2pGK0sxSFgz?=
 =?utf-8?B?SGJMTzJYTFV0QzFXNEwzQUI2RXNBK3hPb2lFL2dTL0pnOVAwdG5sWEV2Zk9M?=
 =?utf-8?B?MlIwaE1zY2Y0RVkyTEQrcHZjT0J4czZMZGlTRnBScFNtNUJDdkhFcDRreGVT?=
 =?utf-8?B?RnZRVFJlTFNvbnNWTjFnZUxHTlVqVUMvQjBibkpCZ1luK1BMbWEzT1BhQ3Zs?=
 =?utf-8?B?WFhJblZhSXZwWUJFRGVKZjBkUHRsbGx1L2NrNzJNVXNxbW1adkg1WCswTUFJ?=
 =?utf-8?B?VGRMNmF0VEJHSjdPeTVMT2Y0dm5XekRHdjc4ZklVbG14TmQ3eTZCN0xzRlc0?=
 =?utf-8?B?NTVPU21pOHNTY1B4UFIzTStNenAvcUNqOVI4T2hqY3NPdDRCNk91bnBTZzNR?=
 =?utf-8?B?dTZHSFlvcUJtbTNzTENKaHUzSFFOWkcyNGdKR3p3TXpqclQvd2ZwUTlLSmVU?=
 =?utf-8?B?aFh3ZnAwQlpZZkJyendkNDEzSXlGbU5nVzNiWXNCT1dWcFk2MzZ5cWRNWkFw?=
 =?utf-8?B?L1dXSXpVMVVJZUpOZHRCcnoxeW9vbHNXTXh3QzcwZHp4RzNKSEZRVG11Zm5j?=
 =?utf-8?B?bGpSNGZ1UHkzR1ArY0tHekJvSUoxeVJDMzNJc1B1ZWZhTWdiZENHTkpYT0py?=
 =?utf-8?B?bUdZNEZmZ2Y5c3ZMS0FDdUtIbXhJTTQ2RitkVWczWktxS25TUHdLRTg2ZGlJ?=
 =?utf-8?B?YTVoOVAyWjJSN1FiVXNrekJ4YWVWb3N2ZjlqZjIvOGRFTEx2K2pjWXlvTmdG?=
 =?utf-8?B?ZzNhMjNIUTVOSlhPQUlZeUlxMkZ2ODVsS3JhM0xxV1NEY2liQnp1VEpHaGJl?=
 =?utf-8?B?SjJUUGlJZnp0TFIvRDFITlVyYlVYS0lTalFBdTBYUGxXWFdvbThGUkg5NmdN?=
 =?utf-8?B?L2RKeEFPeHVORm1aK3dWbERkUXFzQ1FDWVNRMXBMVkZaaVVRTGc3d0YveDhq?=
 =?utf-8?B?d1JucHVPTERRWkF6bHlSRTl4dnlBUGxzMElsMGVkU042VzEyM3BIMWVIV2Uv?=
 =?utf-8?B?WllLUWhteDVkMUEzYjZsWmNQc2wxNTZPVmkxcDhzNGUvWlloY29SN21lTXZq?=
 =?utf-8?B?VG94YTBUWFp4NUpxRzB0S3ZMQXJqUHJCTjVWMmIzZ0cxVFh2RWZNLzFHdE1q?=
 =?utf-8?B?dms5YzFCbVpCRlU3UVpmRmJkd1VmOFlxRVloLytRSklyem1QamMzZUVCM29z?=
 =?utf-8?B?a0VkOW9LLy9aamlFS3ZZOHkxRUExUGtoc0lRZFhzbTFadWFxMlZFdjl1TWFV?=
 =?utf-8?B?V0xmUnhDZkxWODZ4aGxFNUw0cUNkV3BZLzQ0OHFyQWZnVGRBV1B5N2pXQUhB?=
 =?utf-8?B?UlVoSUxrVUVQNk5md1dxcldrWFhKM05aYXh4TStVRmRnNkZUcTdRRVd4WEJt?=
 =?utf-8?B?ZHVqWFZaSFRYNy83Ujl3cGJDVUdyVHczU2h6ckM1ZjZOdU9GZ0JkMHhkaFVs?=
 =?utf-8?B?bVdKQ2tsOGFqRXNhYlg0TThHek9zRE90Ym45a29mOCtRcWZIZ1ZXRzhvQzBM?=
 =?utf-8?B?ZklrTFdlMXFycnNjVHJWSFlQRlU3VGNzM3dJKzNqZjQrZjdhOUFySjFQRnE3?=
 =?utf-8?B?bVBSQ1RYNElIMFczWFMzaUttUTI4a1lvU1pVeXJBL2NrL3hMaUk5bzhqYWVY?=
 =?utf-8?B?M0NwcWtxd3FpYmk1cUZnU0hMWHFqbEZNMk04Q1k5aTFGNVdnQnJnaHV0Znox?=
 =?utf-8?B?RGh6S2dSdnVkWTBOYkYzOEVDcTFLRFJCaHpCTFZKR09OK3VieENHMzRQbXht?=
 =?utf-8?B?NkNmNU5rcGVZbnFlOVJUM1I0cEoyeTd6Y1hBVVRnU1ZPNm03Q3J2NXBIc0sv?=
 =?utf-8?B?TU52S0JkdU9nVW1vTU1ONkRyYXRqdE15eDFFWERJN1IyVkZZM0Q2ZXNhdHZH?=
 =?utf-8?B?aVJYRDFCUlNnM1FHS1hqaDhFbFo1Y25vL09ya0xPeFI5MDZiOFhLN055M3g1?=
 =?utf-8?B?YmlKZG03OGk1bUY0ZHdwWmhVeThWRE1yVHF5Z05HUE5tN2pob0EvcldYek1m?=
 =?utf-8?B?RnZ1OVhlc3UwSjQ4N3k2TGtVM0RNckN4UXVpdWNHMGQ4d0tFcGdZbys2YVVH?=
 =?utf-8?B?a25QdzI2OE0zNkhDU3hRbkZMdUttMDAyUkFHcDlLYU1WUno1c0Y0Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <453E3538EA097243AE5C6FD080BB48DB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gPEptzeAX1OnW32+bajsAXyxv/dcR4AsiuwwmeL4rGRhw5BdMB3IRg6YVLVdTGeSDzS49fgMkCQHItsV7Jg3W7M90632yxH+XNpqn82OcMsERaC2MGRbdBzmhTZFPzfkkaer31rtQWVHIQL2W3v50bkAZ6nFYXdQcWDTop+FABoGYdMqGXpiU+0BO4L6zaO8UIW/KwVPT9040uAyDj3E4ccKwnQH2ItKqW2DdtgvwvfJMgFX81rbhvXJPBMDMkVMFFXjRRGeMlf2ZKTg2O3I6uSivPVtxP5+YoDe9BirSRHE90NlDx4FRu4xAG8j6KR2xWWPoTqjj6VxxhJr69kynA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR03MB9902.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a717a3e-489d-46f2-1572-08df34ce1b59
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 08:33:13.6558 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PEj64avJ90QGYkuifW0gcy0uznaqGhyeua4eNUPdyUOYka3VZFzn/jmPTWys40b7PcWB4QpGqdlU56xrs5TKdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB10114
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
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVHVlLCAyMDI2LTA3LTE0IGF0IDEzOjQzICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gVGhpcyBoYXJkd2FyZSBjb250cm9scyB0cmlnZ2VyIHNvdXJjZXMsIGFu
ZCB0aGVyZSdzIGV2ZW4gYSBnZW5lcmljDQo+IGJpbmRpbmcganVzdCBmb3IgdGhhdDogYWxsb3cg
I3RyaWdnZXItc291cmNlLWNlbGxzIGluIE11dGVYLCBzbw0KPiB0aGF0IHRoaXMgaXMgYWxsb3dl
ZCB0byBwcm92aWRlIHRyaWdnZXJzIHRvIGV4dGVybmFsIEhXLg0KDQpSZXZpZXdlZC1ieTogQ0sg
SHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCg0KPiANCj4gQWNrZWQtYnk6IEFuZ2Vsb0dpb2FjY2hp
bm8gRGVsIFJlZ25vIDxhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+
IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9naW9hY2No
aW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+IC0tLQ0KDQo=
