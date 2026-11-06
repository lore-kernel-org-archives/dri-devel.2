Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA01606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 08:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=ZSoeRNbH;
	dkim=pass (1024-bit key, unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=HV7BR69L
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C15A1112857;
	Fri,  6 Nov 2026 08:36:34 +0000 (UTC)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D4BA11283A
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 08:36:23 +0000 (UTC)
X-UUID: 234d8930d9bd11f18dc8c9802ae25ab1-20261106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=kB+X+9Cz09bxjis1cG8SubO+c6I3qEYhlI0P2vxPyz4=; 
 b=ZSoeRNbH9yWUuIkL4dTGFkbxnFSD6znKXL4xwtJrcNm+KVDwByG5nKZcU/wbTvSCMDrA+Fi7c8enTA/sbCGWcGJPUkavZF4z6/Qvf/ZhPzUbyATH0kALg7NodFxq+me6Lz+5174PDYCFjuXHMZPq+bVj0VvcdgIzmKcY6divlrI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21, REQID:0dc37710-a95e-493b-b447-90faf913fbea, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:b0318ac, CLOUDID:fda12aee-6961-456c-adce-6d277e14e6ad,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:n
 il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 234d8930d9bd11f18dc8c9802ae25ab1-20261106
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 2034233557; Fri, 06 Nov 2026 16:36:18 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 6 Nov 2026 16:36:17 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 6 Nov 2026 16:36:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+hu9SZxuQyZCfAfws2C05Xeqc5SAiCP92fJP4QaY1k1ujzX1Uc9iGOMBOa9hbaErXw7q5K0vUjE53LhcQDAjrqJ/l2R4aSHmmzwkWwLqx/C/RpK/048nr0WeMuQaaFz+vUP1Yq4bwktPsB7cC8q6aWziCpNoKx/xVLc4ouKr7wnCNo5CgSARSl3uJhL43mpqEUxlaJGjEJSextj4m6geE/M0plfoIlvWQos6rMydT7NMd7Wg5VMuJ7FZ05KRTa4GTWNEc5e/uuZwcUpQEr2nh4p3/AnI107hYOKBBibVszobxtY4Xbr8pF8Jl3l6P06RlsW0kRhIMd+eYncjMFeIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kB+X+9Cz09bxjis1cG8SubO+c6I3qEYhlI0P2vxPyz4=;
 b=mJQv64wwdQUY4TdKJQUhzJ2dx4vtCw2wW+GFEzP3GKeihjQNWQo+qwhxHgt7PokGRYHZrGSjuws/LrvMtpXRx/Cw9PtAroJ2Whm+Lxe9SXugshcmatJDPOoC28x0U9J2o1dnEupCgcM2lfPdVHnfdvvp1fjj2EIsdCpUk1nY7h9DA5JI0hg/P8moae3/t7J5DIk7jfNIpLrlTM+uwHcrHnC1W1rnAFoPsPlnj0RLeJc70qJoJaKdaYXyQ6E0J8Mto3u9VuFJfYhfRCcIk4tjUa/KfPEa7IEqIAxSh1Ig544jPemDhNrVytyA42UIKx9cJe1S7awm2CBvUx7qs36xcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kB+X+9Cz09bxjis1cG8SubO+c6I3qEYhlI0P2vxPyz4=;
 b=HV7BR69LypMJvWrP18WvuGryHfvC9/h1Zvl7VXjlFY+uY3lxXns59BlBsS/cewMSWhtfB5UC+2yfqsEfQoVqWByVATvDuROwGeCnrExADEe2sWBNNrM2YvxjcqW4DALcbAwQAVAdB1GbBR+aqrG0xG85Qa1Z6zfpGZTsLbk42/g=
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com (2603:1096:d10:91::20)
 by OSQPR03MB8747.apcprd03.prod.outlook.com (2603:1096:604:282::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 08:36:11 +0000
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b]) by KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b%5]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 08:36:10 +0000
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
Subject: Re: [PATCH v2 23/46] drm/mediatek: Fully migrate to new Display
 Controller HW indexing
Thread-Topic: [PATCH v2 23/46] drm/mediatek: Fully migrate to new Display
 Controller HW indexing
Thread-Index: AQHdE4ZgtyEAp8vnA0uZTTyYmRu0S7chbLIA
Date: Fri, 6 Nov 2026 08:36:10 +0000
Message-ID: <e720371d6a3e4bb9ffa56bd8e06ae759c4d4c5cc.camel@mediatek.com>
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-24-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260714114414.184512-24-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR03MB9902:EE_|OSQPR03MB8747:EE_
x-ms-office365-filtering-correlation-id: baba10e2-7dca-421a-c64b-08df3be10287
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|1800799024|42112799006|366016|38070700021|261026140227099003|11063799006|4143699003|56012099006|261102123227099003|261021121427099003|261021123027099003|261009223027099003|261022105027099003|261028144727099003|261022075727099003|10067099003|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info: h3ZEyi4FK38y6kUhtxl0wsx59/2ueSaLu+/Ynu5mDk+r/78kFVvZSv2h1P+WaHR9TyFkJQ1BOhd0xmiaxtr9Oji2Fv8ue2w5ZIIYkDK1vFTovWW4ySOrk7g5Cz+7gV4pnNs2Zz+twOcg8vyADYjVcp2k2+ikqRg+0+CexfjvKfRd9OrcdW0Gzat7BI5vj6z+4EM3FZcIoR/Oxo5OOKZaAIgT8eWjpt21CHWzyoyu849aIwpFq33YutcLTExjtloVJd+dx62QZvjTuFArz81qLrsGXJPN3aoQi5LuVGyoA/+FyuK85Io0t7Zj3rWvJ6F4MSd7oYb7fVWpy9/9HjK9euhJ9DhDOxeVm6H/YzcFKkHkkU+Uyz63cxvpt+43Nx76fMn/rURJLvr81HAk9hQomFFJ8chsyZjhaj3sMjCg61mGRmkrzi1XKeh0q4Wjlrnt9gyTkWv41ewuLlfV3Ynj4ACAJwRKGaeF/6EnEZOC7V/8rVihU2aN8vUwzTLf3VQOQDRJh6jNVdxug8Y9/O8ISFkLZD/K87MrnpXTkpyIRr/bWYqEmrC3N+vE/Mu1dgh49BQRxUjPD5RtnjDH0CgsRMS4q4MwFqRrqND+PiISJud25868Mdg/R5JmwTfKaL34v8Mumeci2DfVZQqNd9DvZQebfJ22qHtqgeBKVB/Cf9s598+Er2qjrHa+UlNXA7a08i2+6uAryuEa1vxIZkqyIfANf9+R6umvMGbfHkM2BTE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUYPR03MB9902.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(42112799006)(366016)(38070700021)(261026140227099003)(11063799006)(4143699003)(56012099006)(261102123227099003)(261021121427099003)(261021123027099003)(261009223027099003)(261022105027099003)(261028144727099003)(261022075727099003)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WW1TekZsUjZ2OWJPbGV2TXlJYXFabERtUHRTeUxDMGJpQURxTHpSdXh5NXY4?=
 =?utf-8?B?amRFRVFnOU9Xb0pxdjZvTmJMR0tkUTlQMGx5ZHJGWXFzZGR6TFUwNDBlbktX?=
 =?utf-8?B?Q1VpNTNwVURlaHpDOEk1YnNDR2NKNmJoL3JhTXI3aUVZL1BjV0pXQ3UxaGF1?=
 =?utf-8?B?bEVoZWlHQTMvNXRYdHE1b3dncFpSR3ppQXNpRHNkYmhBdjJWekEzL0Y3cHc0?=
 =?utf-8?B?aUl2NXkwTURhZ3VKbXErR3JoZ0VwWG5rWGh3eHRZa0p4UXJNR1V2dWRoOXZ3?=
 =?utf-8?B?ak1oV1N5cnhVbzk2UWFSbVdWWXVaMCt6TVFpNm5WaTlxeTFXU25oTGhUMlBK?=
 =?utf-8?B?L3JxeE5QQ1BScmRsYk94dE5iMlBvbVBWNk0vMklZeXludXhZUFl4a2dYZnIy?=
 =?utf-8?B?N3pJaUV6bzFVSGM2WVFjT1dPK1p6cTNOVVdVclhsaFJqcHpNSDdMSlR2RHF1?=
 =?utf-8?B?RitxVnF2T0FIRU1iUGQ1ckJDQjduUkxNZkMwZFpORTN6a0x1VzIxV3pLNldI?=
 =?utf-8?B?bG1uYkNldE8yOTRpUDcwOVhEZlRCalB6NEhMcVJwQ1dybGVFTExWYm1MYjQy?=
 =?utf-8?B?bnA5dzdZUmw1L1ZIa09YdXJnZkdJUmhYL1l1V0tPenFqa3ZrRlJDNWM0Tnl5?=
 =?utf-8?B?di92dzVSa3ltSDBlV2JFRmtseHhxK2ZwMGc4NkY4TTJVenBxQjRtay9uM1Z1?=
 =?utf-8?B?T1BEY0FReG9zU2U4bUloblBpMTBNSlIxYllNWkJ5dC92ckllV2o4M2lLcFZw?=
 =?utf-8?B?QStyaXFIRUpWV2tMSDh4TGpYUlR5SlM3QWZxRDQzVEoxNFZRMVd1VlpBcTlH?=
 =?utf-8?B?K01jVXVOTEcwZnVwWUErL0Fwd2FTNElya0JveDZpc0JQNWRjbmdhdkgrSmdN?=
 =?utf-8?B?YVE4Z1M3WHE2Mi91Ti9nS3o0bmxsMnZpUFpBTXNMTmgybDdNSDVRQzlLMUlk?=
 =?utf-8?B?ZXZENlVNem5sN3Z6cVN1ZWErUHllOEFaTWt6c3ByUVloaFI0dEN3Nk83cVpQ?=
 =?utf-8?B?c1JWZFpubm9RNnAxQjhsRDRsMUQ4VFFlRXhpcTBVK2RXNHVQWkNKWDFKWUxQ?=
 =?utf-8?B?ZnQ1a0s1UGJhQVNUcFRpSFhVbzlLK3FWVFozQVppSDdPOVZSS2ZSRmEwSjZJ?=
 =?utf-8?B?TXZvSHdoSnF0Qit4aXlGUlZOV1I4WkFtVmVZMk5uKzZYd21lV3o2VEJQOGF3?=
 =?utf-8?B?WnBaOXNweDVNd2ZpUmZ3S21ZM0l0OVphOG11alVaQ0hKU0xXdnk4bFBPOEx6?=
 =?utf-8?B?dU82amVIbHVMNlVZSTRjTnMxZFhBMFpkcFk5UDdrQmo1dFRzZ1FWOUh2dFIy?=
 =?utf-8?B?ZVphUG1TdUhKVUo2TjJZaE01WDNYRGtHaFc1a1pIUkpmY2YyNlovK0JjSXo4?=
 =?utf-8?B?ZmJObjFCTTBiSkdxNlQzQ3dlTjJvNkhpWGwwREJ2RzZ2R3VlMWptbWV3REpP?=
 =?utf-8?B?OE9YNUtIdnNZNnRSZC9lekYrYXE2ZXFVbjlhaWJ2YTNqcU9Fem1icmJaZG9K?=
 =?utf-8?B?NTIvVWcyN2VsRThlYzk1OEdYVWhyTHNWeUFVWVhGREdwdWpaamo4YWFCREJy?=
 =?utf-8?B?Vk9EaEdJM3lyYjhZUmRsMTFaZDA2UkFjV1NTTzRDcEwweUJGZXNpZnNibzl5?=
 =?utf-8?B?T2hKdm45dzQweDhtdW5NS05PM3p2YUJnUGl1cVRGR2crcElqMnVDb3dQSytQ?=
 =?utf-8?B?MmgxM0YvWmxld0h0N2RYc2l0UWQwT0lYbG0yUi9BaTBOWENpUlJZeVJoRTFt?=
 =?utf-8?B?SkZPV1YzZ1habElmbDBhODZZMmRQLy95WHB2aVk4NlpqZGErb1BDZzUrWUNH?=
 =?utf-8?B?RTRhUEhYblhKa3ZOdXFBb0ZCN1hzdnFDZ0Q2cnJRdVBVZjB2d2paR0k1aEYr?=
 =?utf-8?B?bFRwdFJSbFNGMmpHYWMvRXo5Q2J3VGZ6WndjbUJHdVd6eWhaV05ncXA1bVFn?=
 =?utf-8?B?ME93Nm9NRmZ3cmdiZVFyT21VSUswbnZYcG1NS3lVcUZFbGhmR2Vjek9TaGl4?=
 =?utf-8?B?TmlYMkZ2ZkNOVWkvQlpOQkNsb1BETUVMNjVNWFJEcE1BeStDMEFtZURaVDRr?=
 =?utf-8?B?dzZyQTl1c2prMTUxaHpvekNGK0J2a1dIdDVnSE9ZVTlsQWFVK0I3Tnh3SkhV?=
 =?utf-8?B?aTR0aGl0UnlCTU9LYTNtemtNN04zZEE5bVIxeFpuTUUwRy9qeHI1Tm55aitV?=
 =?utf-8?B?eG1qdnppSy9Iem5qcU5uYmlLdXZnRGp6d1dibE9ZREwvUlB3d3EyMTNnYUQx?=
 =?utf-8?B?TW9hQlpOMUorcTN4M3dJeXViZkUwWmFjVERWUWV5QkdIbW9vWG9wVklXVWR2?=
 =?utf-8?B?bk1uaEdnWm1GbExBRHZkSnlseG1XMEtBTmI3eGpIcnoxWmY0and5QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1AE78617498E444C8B8A7BB068FFF4D0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 2A9FjpmaP9xHDfPcTzMrc2nzx9pR2TJ3KpptE38Di0qcwP9/DvM5aAguWTzIsEuLIIx1KgIsKmpgyLdO1rY06uMpV6SRihVS2AvYD5l9wleQkN0pQTrs7TiNgO9RW0W9WozxobNiWVcnRaffzGa+YSX0VcFDoE44ZMwzrY2Z0/xTRTR6TNor2FTRxtkH06NSxOVeOLX6ALreg1b1n+vzwpyQmyz6Hzg7lUMzE0XrYmhEjvHFBYiAiWMG2bnzMdoLAYI5YN3cnVLlr1OPGlr2+2xr2IWFVr9TJibsP9I/hw07AJvGFr0tE5hPO13bS5GvalQYLnVQaqEiby2Yc87sgA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR03MB9902.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baba10e2-7dca-421a-c64b-08df3be10287
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 08:36:10.5424 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hwXzTM0LkG+3uyZB4Jo1m4rco1qjI4/snywwAdqMsbYKpLqvelwudQ0deDXqMM3e147+mJeHPAxFIGGLOzwv/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8747
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
ZWdubyB3cm90ZToNCj4gUGVyZm9ybSBhIGZ1bGwgbWlncmF0aW9uIHRvIEhXIFR5cGUgLT4gSFcg
SW5zdGFuY2UgSUQgaW5kZXhpbmcNCj4gZm9yIGFsbCBvZiB0aGUgY3VycmVudGx5IHN1cHBvcnRl
ZCBEaXNwbGF5IENvbnRyb2xsZXIgaGFyZHdhcmUNCj4gc3ViLWNvbXBvbmVudHMuDQo+IA0KPiBU
aGlzIGFsbG93cyB0byByZW1vdmUgdGhlIGJpZyBmaXhlZC1zaXplIGNhdGNoLWFsbCBjb21wb25l
bnRzDQo+IGFycmF5ICh0aGF0IGNvbnRhaW5zIGFzIG1hbnkgZWxlbWVudCBhcyBtdWNoIGFzIHRo
ZSBudW1iZXIgb2YNCj4gc3VwcG9ydGVkIGhhcmR3YXJlIGFuZCBudW1iZXIgb2YgaW5zdGFuY2Vz
IG9mIHRoYXQpLCB3aGljaCBpcw0KPiBjdXJyZW50bHkgZ3Jvd2luZyBiaWdnZXIgYW5kIGJpZ2dl
ciBhdCBldmVyeSBzdWItaXAgc3VwcG9ydA0KPiBhZGRpdGlvbiBpbiBtZWRpYXRlay1kcm0uDQo+
IA0KPiBOb3RlIHRoYXQgdGhpcyBjbGVhbnVwIGJlY2FtZSBuZWNlc3Nhcnkgc2VlbiB0aGUgbmVl
ZCB0byBhZGQNCj4gc3VwcG9ydCBmb3IgbmV3IGNvbXBvbmVudHMgZm91bmQgaW4gTVQ4MTk2LCBN
VDg5OTQgYW5kIG90aGVyDQo+IHZhcmlhbnRzIG9mIGl0LCBhbmQgb2YgY291cnNlIHRob3NlIFNv
Q3Mgd29uJ3QgYmUgdGhlIGxhc3QNCj4gb25lcyB0byBiZSB1cHN0cmVhbWVkLi4uIHNvIHRoZSBz
aXplIG9mIHRoYXQgYXJyYXkgd291bGQgZ2V0DQo+IG91dCBvZiBjb250cm9sIHByZXR0eSBmYXN0
IChhbmQgYWdhaW4sIGl0J3MgYWxyZWFkeSB2ZXJ5IGJpZykuDQo+IA0KPiBBcyBhIHNpZGUgZWZm
ZWN0LCB3aGlsZSBzYXZpbmcgbWVtb3J5IGNvbXBhcmVkIHRvIGJlZm9yZSB0aGlzDQo+IGNoYW5n
ZSwgdGhpcyBhbHNvIGFsbG93cyB0byBoYXZlIHVwIHRvIDI0IChhcyBhbiBleHRlbnNpYmxlIGZp
eGVkDQo+IHNpemUgZGVjbGFyZWQgaW4gdGhpcyBkcml2ZXIpIGluc3RhbmNlcyBvZiB0aGUgc2Ft
ZSBIVyBUeXBlIHdpdGgNCj4gbm8gZnVydGhlciBpbmNyZWFzZSBpbiBtZW1vcnkgZm9vdHByaW50
Lg0KPiBTaW1pbGFybHksIGFkZGluZyBzdXBwb3J0IGZvciBuZXcgaGFyZHdhcmUgd2lsbCBub3Qg
cHJvZHVjZSBhbg0KPiBpbmNyZWFzZSBvZiBtZW1vcnkgZm9vdHByaW50IG9uIGFsbCBTb0NzIChp
ZiBub3Qgb25seSB0ZW1wb3JhcmlseQ0KPiB3aGlsZSB0aGUgcHJvYmUgcHJvY2VzcyBpcyBpbiBw
bGFjZSkgYXMgdGhlcmUncyBubyBtb3JlIGNhdGNoLWFsbA0KPiBhcnJheSwgYnV0IG9ubHkgYSBk
eW5hbWljYWxseSBhbGxvY2F0ZWQgbGlzdCBvZiBwZXIgZGlzcGxheSBvdXRwdXQNCj4gY29tcG9u
ZW50cy4NCj4gDQo+IFVuZm9ydHVuYXRlbHksIHRoaXMgY2hhbmdlIG5lZWRzIHRvIGdvIGFsb25n
IHdpdGggdGhlIHJlbGF0ZWQgb25lDQo+IGluIHRoZSBtdGstbW1zeXMgZHJpdmVyLCBvdGhlcndp
c2UgZnVuY3Rpb25hbGl0eSBvZiB0aGUgRGlzcGxheQ0KPiBDb250cm9sbGVyIHdpbGwgcmVncmVz
cy4NCj4gDQo+IFRoZSBvbmx5IHdheSB0byBtYWtlIHRoaXMgcG9zc2libGUgaW4gdHdvIHN0ZXBz
IGlzIHRvIGR1cGxpY2F0ZQ0KPiBhbGwgb2YgdGhlIHJvdXRlcyBzdHJ1Y3R1cmUgYXJyYXlzIGZv
ciBhbGwgb2YgdGhlIFNvQ3MsIHdoaWNoDQo+IHdvdWxkIHJlc3VsdCBpbiBhIHRvdGFsIG9mIGFy
b3VuZCB+MTIwMCBsaW5lcyBjaGFuZ2VkIHR3aWNlLCBhbmQNCj4gdGhhdCBpZ25vcmVzIHRoZSBi
aWcgaW5jcmVhc2UgaW4gc2l6ZSBmb3IgdGhpcyBkcml2ZXIgZHVyaW5nIHRoZQ0KPiBtaWdyYXRp
b24gcHJvY2VzcyBzbywgaW4gb3JkZXIgdG8gYXZvaWQgdXNlbGVzcyBibG9hdCwgSSBvcHRlZA0K
PiBmb3IgYW4gaW50ZXItZGVwZW5kZW5jeSBiZXR3ZWVuIHRoZSB0d28gY2hhbmdlczogbWVkaWF0
ZWstZHJtDQo+IGFuZCBtdGstbW1zeXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG9HaW9h
Y2NoaW5vIERlbCBSZWdubyA8YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29t
Pg0KPiAtLS0NCg0KW3NuaXBdDQoNCj4gQEAgLTExNDMsMjUgKzExNTgsMTUgQEAgaW50IG10a19j
cnRjX2NyZWF0ZShzdHJ1Y3QgZHJtX2RldmljZSAqZHJtX2RldiwNCj4gIAkJY3J0Y19pKys7DQo+
ICANCj4gIAlmb3IgKGkgPSAwOyBpIDwgb3V0cHV0X3BhdGhbaV0ubGVuOyBpKyspIHsNCj4gLQkJ
ZW51bSBtdGtfZGRwX2NvbXBfaWQgY29tcF9pZCA9IG91dHB1dF9wYXRoLT5jb21wW2ldLnR5cGU7
DQo+IC0JCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZTsNCj4gKwkJZW51bSBtdGtfZGRwX2NvbXBf
dHlwZSBjb21wX3R5cGUgPSBvdXRwdXRfcGF0aC0+Y29tcFtpXS50eXBlOw0KPiArCQl1OCBjb21w
X2luc3QgPSBvdXRwdXRfcGF0aC0+Y29tcFtpXS5pbnN0X2lkOw0KPiAgCQlzdHJ1Y3QgbXRrX2Rk
cF9jb21wICpjb21wOw0KPiAgDQo+IC0JCW5vZGUgPSBwcml2LT5jb21wX25vZGVbY29tcF9pZF07
DQo+IC0JCWNvbXAgPSBtdGtfZGRwX2NvbXBfZmluZF9ieV9pZCgmcHJpdi0+aGxpc3QsIGNvbXBf
aWQpOw0KPiAtDQo+IC0JCS8qIE5vdCBhbGwgZHJtIGNvbXBvbmVudHMgaGF2ZSBhIERUUyBkZXZp
Y2Ugbm9kZSwgc3VjaCBhcyBvdmxfYWRhcHRvciwNCj4gLQkJICogd2hpY2ggaXMgdGhlIGRybSBi
cmluZyB1cCBzdWIgZHJpdmVyDQo+IC0JCSAqLw0KPiAtCQlpZiAoIW5vZGUgJiYgY29tcF9pZCAh
PSBERFBfQ09NUE9ORU5UX0RSTV9PVkxfQURBUFRPUikgew0KPiAtCQkJZGV2X2luZm8oZGV2LA0K
PiAtCQkJCSJOb3QgY3JlYXRpbmcgY3J0YyAlZCBiZWNhdXNlIGNvbXBvbmVudCAlZCBpcyBkaXNh
YmxlZCBvciBtaXNzaW5nXG4iLA0KPiAtCQkJCWNydGNfaSwgY29tcF9pZCk7DQo+IC0JCQlyZXR1
cm4gMDsNCg0KVGhlIG9yaWdpbmFsIGJlaGF2aW9yIGZvciBkaXNhYmxlZCBjb21wb25lbnQgd291
bGQgcmV0dXJuIDAsIGJ1dCB5b3UgY2hhbmdlIHRoZSBiZWhhdmlvciBoZXJlLg0KSXMgaXMgc2Fm
ZSBmb3IgbGVnYWN5IFNvQz8NCg0KPiAtCQl9DQo+IC0NCj4gKwkJY29tcCA9IG10a19kZHBfY29t
cF9maW5kX2J5X2lkKCZwcml2LT5obGlzdCwgY29tcF90eXBlLCBjb21wX2luc3QpOw0KPiAgCQlp
ZiAoIWNvbXAgfHwgIWNvbXAtPmRldikgew0KPiAtCQkJZGV2X2VycihkZXYsICJDb21wb25lbnQg
JXBPRiBub3QgaW5pdGlhbGl6ZWRcbiIsIG5vZGUpOw0KPiArCQkJZGV2X2VycihkZXYsDQo+ICsJ
CQkJIkNSVEMlZDogQ29tcG9uZW50IHR5cGU9JXUgaW5zdD0ldSBub3QgaW5pdGlhbGl6ZWRcbiIs
DQo+ICsJCQkJY3J0Y19pLCBjb21wX3R5cGUsIGNvbXBfaW5zdCk7DQo+ICAJCQlyZXR1cm4gLUVO
T0RFVjsNCj4gIAkJfQ0KPiAgCX0NCj4gDQoNCltzbmlwXQ0KDQo+ICBzdGF0aWMgYm9vbCBtdGtf
ZGRwX2ZpbmRfY29tcF9kZXZfaW5fdGFibGUoY29uc3Qgc3RydWN0IG10a19kcm1fY29tcF9saXN0
ICpobGlzdCwNCj4gLQkJCQkJICAgY29uc3QgdW5zaWduZWQgaW50IGNvbXBfaWQsDQo+ICsJCQkJ
CSAgIGNvbnN0IHVuc2lnbmVkIGludCBjb21wX3R5cGUsDQo+ICAJCQkJCSAgIHN0cnVjdCBkZXZp
Y2UgKmRldikNCj4gIHsNCj4gIAlzdHJ1Y3QgbXRrX2RkcF9jb21wICpkZHBfY29tcDsNCj4gIA0K
PiAtCWhhc2hfZm9yX2VhY2hfcG9zc2libGUoaGxpc3QtPmRkcF9saXN0LCBkZHBfY29tcCwgbG5v
ZGUsIGNvbXBfaWQpIHsNCj4gKwloYXNoX2Zvcl9lYWNoX3Bvc3NpYmxlKGhsaXN0LT5kZHBfbGlz
dCwgZGRwX2NvbXAsIGxub2RlLCBjb21wX3R5cGUpIHsNCg0KWW91IGNoYW5nZSB0aGUgY29tcF9p
ZCB0byBjb21wX3R5cGUuDQpJZiB0aGUgY29ycmVjdCBtYXRjaCBpcyBEUEkwLCBhZnRlciB0aGlz
IHBhdGNoLCB0aGUgRFBJMSB3b3VsZCBtYXRjaD8NCg0KPiAgCQlpZiAoZGRwX2NvbXAtPmRldiA9
PSBkZXYpDQo+ICAJCQlyZXR1cm4gdHJ1ZTsNCj4gIAl9DQo+IA0KDQpbc25pcF0NCg0KPiAgaW50
IG10a19kZHBfY29tcF9nZXRfaWQoc3RydWN0IGRldmljZV9ub2RlICpub2RlLA0KPiAgCQkJZW51
bSBtdGtfZGRwX2NvbXBfdHlwZSBjb21wX3R5cGUpDQo+ICB7DQo+IC0JaW50IGlkID0gb2ZfYWxp
YXNfZ2V0X2lkKG5vZGUsIG10a19kZHBfY29tcF9zdGVtW2NvbXBfdHlwZV0pOw0KPiAtCWludCBp
Ow0KPiAtDQo+IC0JZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUobXRrX2RkcF9tYXRjaGVzKTsg
aSsrKSB7DQo+IC0JCWlmIChjb21wX3R5cGUgPT0gbXRrX2RkcF9tYXRjaGVzW2ldLnR5cGUgJiYN
Cj4gLQkJICAgIChpZCA8IDAgfHwgaWQgPT0gbXRrX2RkcF9tYXRjaGVzW2ldLmFsaWFzX2lkKSkN
Cj4gLQkJCXJldHVybiBpOw0KPiArCS8qIElmIHRoZXJlJ3MgYW4gYWxpYXMsIHJldHVybiB0aGUg
SUQgZnJvbSB0aGF0ICovDQo+ICsJaWYgKG10a19kZHBfY29tcF9zdGVtW2NvbXBfdHlwZV0pIHsN
Cj4gKwkJaW50IGFsaWFzX2lkID0gb2ZfYWxpYXNfZ2V0X2lkKG5vZGUsIG10a19kZHBfY29tcF9z
dGVtW2NvbXBfdHlwZV0pOw0KPiArCQlpZiAoYWxpYXNfaWQgPj0gMCkNCj4gKwkJCXJldHVybiBh
bGlhc19pZDsNCj4gIAl9DQo+ICANCj4gLQlyZXR1cm4gLUVJTlZBTDsNCj4gKwlyZXR1cm4gMDsN
Cg0KMCBpcyB2YWxpZCBpZCBzbyB0aGlzIGZ1bmN0aW9uIHdvdWxkIG5vdCByZXR1cm4gZXJyb3Iu
DQpZb3UgY2hhbmdlIHRoaXMgYmVoYXZpb3IsIHNvIEkgd291bGQgbGlrZSBzb21lIGV4cGxhaW4u
DQoNCj4gIH0NCj4gIA0KPiAgaW50IG10a19maW5kX3Bvc3NpYmxlX2NydGNzKHN0cnVjdCBkcm1f
ZGV2aWNlICpkcm0sIHN0cnVjdCBkZXZpY2UgKmRldikNCj4gDQoNCltzbmlwXQ0KDQo+IEBAIC0x
Niw2ICsxNiw3IEBADQo+ICAjaW5jbHVkZSA8ZHJtL2RybV9tb2Rlcy5oPg0KPiAgDQo+ICAjZGVm
aW5lIE1US19ESVNQX0NPTlRST0xMRVJfTUFYX0NPTVBfUEVSX1BBVEgJCTI0DQo+ICsjZGVmaW5l
IE1US19ESVNQX0NPTlRST0xMRVJfTUFYX0hXX0NPTVBfSU5TVEFOQ0UJMzINCg0KTVRLX0RJU1Bf
Q09OVFJPTExFUl9NQVhfSFdfQ09NUF9JTlNUQU5DRSBpcyB1c2VsZXNzLCBzbyBkcm9wIGl0Lg0K
DQo+ICANCj4gIHN0cnVjdCBkZXZpY2U7DQo+ICBzdHJ1Y3QgZGV2aWNlX25vZGU7DQo+IA0KDQpb
c25pcF0NCg0KPiBAQCAtOTI0LDE4ICs5MjgsMTYgQEAgc3RhdGljIGludCBtdGtfZHJtX3Byb2Jl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJCQljb250aW51ZTsNCj4gIAkJfQ0K
PiAgDQo+IC0JCWNvbXBfaWQgPSBtdGtfZGRwX2NvbXBfZ2V0X2lkKG5vZGUsIGNvbXBfdHlwZSk7
DQo+IC0JCWlmIChjb21wX2lkIDwgMCkgew0KPiArCQljb21wX2luc3RfaWQgPSBtdGtfZGRwX2Nv
bXBfZ2V0X2lkKG5vZGUsIGNvbXBfdHlwZSk7DQo+ICsJCWlmIChjb21wX2luc3RfaWQgPCAwKSB7
DQoNCmNvbXBfaW5zdF9pZCBpcyB1OCwgc28gdGhpcyB3b3VsZCBuZXZlciBoYXBwZW4uDQoNClJl
Z2FyZHMsDQpDSw0KDQo+ICAJCQlkZXZfd2FybihkZXYsICJTa2lwcGluZyB1bmtub3duIGNvbXBv
bmVudCAlcE9GXG4iLA0KPiAgCQkJCSBub2RlKTsNCj4gIAkJCWNvbnRpbnVlOw0KPiAgCQl9DQo+
ICANCj4gLQkJaWYgKCFtdGtfZHJtX2ZpbmRfbW1zeXNfY29tcChwcml2YXRlLCBjb21wX2lkKSkN
Cj4gKwkJaWYgKCFtdGtfZHJtX2ZpbmRfbW1zeXNfY29tcChwcml2YXRlLCBjb21wX3R5cGUsIGNv
bXBfaW5zdF9pZCkpDQo+ICAJCQljb250aW51ZTsNCj4gIA0KPiAtCQlwcml2YXRlLT5jb21wX25v
ZGVbY29tcF9pZF0gPSBvZl9ub2RlX2dldChub2RlKTsNCj4gLQ0KPiAgCQkvKg0KPiAgCQkgKiBD
dXJyZW50bHkgb25seSB0aGUgQUFMLCBDQ09SUiwgQ09MT1IsIEdBTU1BLCBNRVJHRSwgT1ZMLCBS
RE1BLCBEU0ksIGFuZCBEUEkNCj4gIAkJICogYmxvY2tzIGhhdmUgc2VwYXJhdGUgY29tcG9uZW50
IHBsYXRmb3JtIGRyaXZlcnMgYW5kIGluaXRpYWxpemUgdGhlaXIgb3duDQo+IA0KDQoNCg==
