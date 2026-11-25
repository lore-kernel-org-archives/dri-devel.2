Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24E8606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 03:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=RuWz6DBZ;
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=IjS7W2S6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3FAA10E702;
	Wed, 25 Nov 2026 03:03:11 +0000 (UTC)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AAB610E5DB
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 03:02:59 +0000 (UTC)
X-UUID: b4ce0088e87c11f18dc8c9802ae25ab1-20261125
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=LW4cWdTOnXh2ySRrasQxqVclxhw5sgizjTlTrQ/bbTM=; 
 b=RuWz6DBZL+7kRa3ARWzXvEulXGKgG7ISzKD5VYL2RZVDRkTAzJ/deiJgS9UaNmZK6cOtTnD4su0gEuUxo8T0yDzfY73/dEDJZDmXq/0HPU4tXfFPAPdQFiKN6EZjCI19Wj8IxUcyj2K4W7VUDam/ozTICyVyF0FysHkmu8Mpx+Q=;
X-CID-CACHE: Type:Local,Time:202611251102+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21, REQID:f931d90f-45b8-42fb-96a0-a23b16946fd8, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:b0318ac, CLOUDID:0c2d4f31-f289-4656-bb36-27baf4489f11,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:n
 il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b4ce0088e87c11f18dc8c9802ae25ab1-20261125
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 2127561095; Wed, 25 Nov 2026 11:02:53 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 25 Nov 2026 11:02:51 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.56 via Frontend Transport; Wed, 25 Nov 2026 11:02:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WHwLD/LVOKqnzV83eTvRhpa67y5zCHU9yRykN7ebz6PwRPs/6RitHTdia/oTqi37RaZKCu86i9l9Rd+o/oWl92LxmhJ/NJAJjJW5JyY+G7OpoG/AJzHRNd/brmvnlZUmemFa6LveAP3eK9Yjmm6hp7VJNHhKlXSc0v1fvcCbeYTEvMDdXnY3zYG9VGjh2rk1s9zcHErZcjThzoHr6ia1Vp2tHpL5eQse68L+FR7gVVGsbiPthq49txUsomR4xIAmqNpCpVj+E3P/2lAJ0ELvgSSv8mfWqAylt5Ny6hmMvLFW/yykzbbXzdXGLqES7K1yN77ToHO5wFMdm0M57dsESQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LW4cWdTOnXh2ySRrasQxqVclxhw5sgizjTlTrQ/bbTM=;
 b=yZeM6HyIcJN8AUt/prx85tOagIOjH30ibudtpAsQiXl+lu7o2a9gjJoJZCDkthN2Lau/+fZrJwb9ed0Jg9qJGJiFiMW+8L9a3LvOcyxTPuKhvfksHqpEOi4wwkvW7UoXrhL3NXvcmuzMiz35OfABtyxLLUlHBnKBTfWXpOu44RvmEZ83+KvGCyS2nENJnN/68tlpXWR09TbRQ/FcdsGQhAgZdME+TJiLuk+5Fb0blzUfAeUFBjpkoshBrwOrvEUBVtCWDYk8WXXw/k4SIjr6kUPETkj6exSmpvVD6w1jhLZ+M4ky7FAP/YpiOqAd+v052VCD9js/PvL76S1AO6d6Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LW4cWdTOnXh2ySRrasQxqVclxhw5sgizjTlTrQ/bbTM=;
 b=IjS7W2S6FQxicV0epuXTu7mep3H12eZpU5geuPP0OOERm9ZQI7WrC5KldBY2c6OtLQVvuG1YVyHemrvmkfmniq0tTJBhAotQXvlh0I0tPJ0yVR2eYVNh5ps1gmz+4qbMM9iQwhI25sgJvOPlsRLVUEVqx/HiTTKs1UldLJ+TpM8=
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com (2603:1096:d10:91::20)
 by JH0PR03MB7546.apcprd03.prod.outlook.com (2603:1096:990:a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.5; Wed, 25 Nov
 2026 03:02:48 +0000
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b]) by KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b%5]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 03:02:46 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
 "haoxiang_li2024@163.com" <haoxiang_li2024@163.com>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@collabora.com>, "junzhi.zhao@mediatek.com"
 <junzhi.zhao@mediatek.com>, "airlied@gmail.com" <airlied@gmail.com>,
 "jie.qiu@mediatek.com" <jie.qiu@mediatek.com>, "simona@ffwll.ch"
 <simona@ffwll.ch>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/mediatek: mtk_hdmi_common: Fix clock reference leaks
Thread-Topic: [PATCH] drm/mediatek: mtk_hdmi_common: Fix clock reference leaks
Thread-Index: AQHdd9SoFZHJU5tHLkq9tH0WU++uJ7c+IzmA
Date: Wed, 25 Nov 2026 03:02:46 +0000
Message-ID: <aade78ffcc8fa95c0c4c5a75b815688a6838a56a.camel@mediatek.com>
References: <20261119031734.2797802-1-haoxiang_li2024@163.com>
In-Reply-To: <20261119031734.2797802-1-haoxiang_li2024@163.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR03MB9902:EE_|JH0PR03MB7546:EE_
x-ms-office365-filtering-correlation-id: a1e2b86d-fd35-4e65-88c3-08df4aa09532
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|42112799006|1800799024|23010399003|376014|7416014|366016|22082099003|18002099003|56012099006|261028144727099003|11063799006|261022105027099003|261026121527099003|261026140227099003|38070700021|10067099003;
x-microsoft-antispam-message-info: UMj5HgTrMibwY+GDZXgJpG3gZv4XP6nDgS0ERTLHl8YcRGFH7gc/azEjmPlwsLMFzhIlnDTMgk4o49vUcUdCU0azk/EY9j7MYGZ1IuYqH2OzQN5G4/T6nkWc+9biIub2Iw4sUInyNzZKchwipPlIKN+4itdwNYxiFog66FeXzF0b1tRr50w9V6TtVGt7o6d/xaG+Itx2/KuL/CN1xtqhMiaVQIOfmy0eMZbNRGDL6DMwEQCyQZE9aXwymHr1nHBfxLxgTLCsC+ESviwc+furpwsyTuqUX2S55LoDDGoepvBg3xNMQAJ/3e92HgxdxgaKJeQ1huX7UiQkd98IqxxRsCiBlOh6/YzCJqwrP5hI7YpUxQk2HJjym4D1UgOuq28HIldVbAo3nGOxRqguwKHMJEZkO7+bONONiLADdK/WHo/TjMeVw/IRH9SwPX58q56tIoN9MVsYfIQoQ8imNrFaoO6OmZ3g06A832ycVjgcQPU9TTnFkDJhxgJ5FxMt/EgG3RTlkQefSNDObkfrbHaA91+pSIj+MJLhXQcyxb/0mxLGVVz0oPKDf3SOZUgBAwtbVTHT1C3URdjMIdq7sbxw2acr3zM/E0xy4Y9IAvnNhTBeKzixMhN2wCQOsB2luQDL2a6YHXUrPqzQmHsYDyAjdHV2rtDhO+dbtqgo7mCpeQah37NQX2L7PgsFFJa9hRydXoKof8M4n2juezTpRaUdAkadI6Upo/L5Wi/eqYzMpwk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUYPR03MB9902.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(1800799024)(23010399003)(376014)(7416014)(366016)(22082099003)(18002099003)(56012099006)(261028144727099003)(11063799006)(261022105027099003)(261026121527099003)(261026140227099003)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1U5ZXd1ZnhuSHdkT0t1czJSekQ1QXQwY0o1VkNWWGFqODIzNzE4OGNhZzFj?=
 =?utf-8?B?eVQxWCs4YkV1ajI1MkFkd0lhaG9EZ2Y2SDBqcWRHTVRBdlhCNjAvUnovcDZ4?=
 =?utf-8?B?MC8yWVZydnlMa0gxUWQxOWFUVk1zc2xiK2RFaWJNSDV6MUJsUXZaRE5vczNz?=
 =?utf-8?B?enp2VHhwS1BrM3pqbXNEYzNyb1dwWjJDcHcwOHdCalpSTHp1eitKYWJPbDlO?=
 =?utf-8?B?alEwWC9VaUlwS2ZCbzRvVHc1YU0yYkpnVVlEcENMY3VFYU85eGtOMlVLUHlW?=
 =?utf-8?B?T01NSUxSRnF5dEdaaUxyMVdGaUhDbkMxWUZwdTNOODhnbWIva0prRk1MMkxr?=
 =?utf-8?B?L1lxVlFvOXc0UUZON253MmJQa3VrOXE0Q3BoU0l4NjRPeHF5S0h3Z3FXekQv?=
 =?utf-8?B?TFJOZFhOMUJ0VnpnQk5TbHZhKzRQZGQ4ell3a2l4UjhGSUhmcGw3NnhHbE9K?=
 =?utf-8?B?K3c2MjVMbzZNemhkNk8reE1SekQ2VXJQRHBEaXIwR2FRNVRBQTJHeVlLT2cy?=
 =?utf-8?B?aGd1MUNwVmNQTEFEWnZGQmZPSkpNQkpOSUtDeFNidmEwTzU0c3JITkpOeUZF?=
 =?utf-8?B?d0VxMUFrRWR3OVV2bWtkck5jZ3REeHJkVXlBdFNrZUpDRTZlY2YwR21hckN3?=
 =?utf-8?B?dFgyY3VQcXBGa2N4TTlwNU5GRnlHdUxOdGh6KzZPSzBWK0d3ckQ0WXAzRmc1?=
 =?utf-8?B?KzVXZUpzWmppVzRyQnNvSHoxM0I2aXBzNGxxTzBtOVN4QTJQbHdpbGpwMXBy?=
 =?utf-8?B?N1RJaUJmcHE5SzlmclZHNFN2WGkxb0l3VVZCTXpIOTVwbzZNV3BJcHNOMlM2?=
 =?utf-8?B?Ylg2S2xLRCs5aWZlQXpvY016TWx6dCtFVGd0RFFJUDRCTlVweDdYbHRkVWNp?=
 =?utf-8?B?M2tJdlpXV0pIdXZ0bFp2K0E1UysvM252Qyt3UnNyNlJVbjFOMENTaUovbzYy?=
 =?utf-8?B?NVFlM0EvSnhHTUNFbU9ONUZzRmRNQmFGVFYySFZtazJkeXVMVUk5VCtSM29l?=
 =?utf-8?B?KzFEd2pPS3NoT3FTRmFFTU91NGJScW9VMHExWDdqWXhDQnMrOFpHeEpWRVJh?=
 =?utf-8?B?ZUNieEc2d01leTJNRGtwR0JSNmE0WXF0eVBxdWwzSGV6cngwUmZPZGl2ZjVU?=
 =?utf-8?B?TGJKZjBhNG5jMUVWQktTWlhzQ2U2RnUxL1U3UEljUjZXQXVmbGkvMDErdnBs?=
 =?utf-8?B?OEpaQVZhQ0o3K1RhYzdSMEw3RUpISUlRSitUcE1CQmtnWWxYVG0xSHFaTzI2?=
 =?utf-8?B?MmlqOVNYN2FOREdCWVBJeDRLbnRIUXR0MHdlRGI0VnI5cGVHcW9tRDMva1Ri?=
 =?utf-8?B?YWxOMktoVDMwUXBJTjJmcWt4U3B3RDdRS0JsVmlFMERpcE9MUFRXdGY0TXZT?=
 =?utf-8?B?SytrQW1TaVVIUWt3US9MSjZMc0ZtNVQ3bnh1aVVWTENaUUY0ODRSVHJHZlNJ?=
 =?utf-8?B?ZzhmTkpSWTBCRDV0VmZLU2xoSzZYRmlwSVlPYUpqY2d4NXFNYWlJTjBuaENP?=
 =?utf-8?B?aWsxY2szckthb1JTMDc2Zm5iUURlcDZUUXdtc2VKZVhmM0dkMDZNZVpzZEF0?=
 =?utf-8?B?ekV5WjR0M1M0ZENFZGwycUtlZEp1V2E3eGtmbm1qYlZCNCszZmhndTZKNnRB?=
 =?utf-8?B?djdKRmprVlBiYTBtVTBtTjMyWjBnVHpqeWxqRTBtYVprUlo3S2Q3eEpxMlJI?=
 =?utf-8?B?SUxlYlpQTTZDZEYxMG9pMmVEUGhsY1R4eWQrSXlHRmJqREF3S3NZY2ZBeUl6?=
 =?utf-8?B?NWRrS3JadnN4NUwxYUxSTThBYkRkRFgyK1ZiWmpPOGMyNkUrZzZ0b0FNQnND?=
 =?utf-8?B?MDZBeit6cndaNGJDcUxyZUs1VkhrNDlBQ0VhVVF3YXlYMWVmZHRRZnlSYVo0?=
 =?utf-8?B?WlBZWER6STI2cUFIeGNXUnZpaFlZSGJEWnV4bGxVTDN3RmJqblI2RFpLZlVa?=
 =?utf-8?B?d0hUeUJYUGc5T2R6bkVkSDRPcy9FQjBqdnBHUitxMTEzUkdPNVIvOGJ4eWRM?=
 =?utf-8?B?TEVzK3psZGdBUGEzaG4va0lTQU0yZTdTNFNkVGpoTktnVUZkR0xXNjZiUzJk?=
 =?utf-8?B?TEhNdDErNzVLV2pDQ0tJRjFpTFJaRUg0V1N1MXU1Nk1LNllvT3NSbVBHVGF4?=
 =?utf-8?B?UlZSQjU3T1FtYnFHdkRYMzJvU1EwdDV5ZFNGcENpQXFhMVRxbnFOUTR6aDg3?=
 =?utf-8?B?MXoyaSs5OFBEejNxT3lnT1lXdUVob3I0VXBhSUdMOGtBMXdhakJEYStoZzVP?=
 =?utf-8?B?MFlDRk4yaFEyaVQrT0xaUDdFdlAzTERTT2J6bHhPd1RWQmg5UWUxcXVaMW4z?=
 =?utf-8?B?eS9RYnlmeWMxYzdRRnliWmM1OEgvaDUvdmZjVjlqbC90djkvS1lKZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7D15FA63746B2419F7EA4089DA0D371@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mfvnfrhBgSW/v84Ms7KOLiPeMVmBD13hHS7Y1bAwaHBJV6mM5qiS2EmFJTd+7znq7n2nKztmOKVExS541zo/D2ji4Xju3AglnLU2MA2QyN8q68KQA8KH6eK0rX2hrfFiL2R24ZpnQ9P+YpMB7YBYYwI2fYSuzA7JWN5jrSujOqAvVZAzLYsejNu2bScsJC6Den/5Ux0N7hMKw2j2kUHtqh9jg6yVrwrICgnR0J6zUAg4aHDEZUO4L1Pb3xCmDV+FecLYzGaBasnZWHnBo8/cL90yil5jGC+lx0d8INznX2yoMPYZwUjyoReE+SWf0XzY03q4bHHT3UO3NZznC0hTSQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR03MB9902.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e2b86d-fd35-4e65-88c3-08df4aa09532
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 03:02:46.7672 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yFYpv82xO551TdGtdwI4vsocs72swO72xMilC+VYJOv44jzF8yMcfULvz4bgN8HeksQSRGFcilb9fQ7j1bbD/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7546
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

T24gVGh1LCAyMDI2LTExLTE5IGF0IDExOjE3ICswODAwLCBIYW94aWFuZyBMaSB3cm90ZToNCj4g
RXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4N
Cj4gDQo+IA0KPiBtdGtfaGRtaV9nZXRfYWxsX2NsaygpIGFjcXVpcmVzIGNsb2NrIHJlZmVyZW5j
ZXMgdXNpbmcNCj4gb2ZfY2xrX2dldF9ieV9uYW1lKCksIGJ1dCB0aGVzZSByZWZlcmVuY2VzIGFy
ZSBuZXZlciByZWxlYXNlZC4NCj4gVGhleSBsZWFrIHdoZW4gYSBsYXRlciBjbG9jayBsb29rdXAg
b3Igc3Vic2VxdWVudCBwcm9iZSBzdGVwDQo+IGZhaWxzLCBhcyB3ZWxsIGFzIG9uIGRyaXZlciB1
bmJpbmQuDQo+IA0KPiBVc2UgZGV2bV9jbGtfZ2V0KCkgdG8gYXV0b21hdGljYWxseSByZWxlYXNl
IGVhY2ggc3VjY2Vzc2Z1bGx5IGFjcXVpcmVkDQo+IGNsb2NrIHJlZmVyZW5jZSBvbiBwcm9iZSBm
YWlsdXJlIG9yIGRyaXZlciB1bmJpbmQuIFJlbW92ZSB0aGUgbm93DQo+IHVudXNlZCBkZXZpY2Ut
bm9kZSBwYXJhbWV0ZXIgZnJvbSBtdGtfaGRtaV9nZXRfYWxsX2NsaygpIGFuZCB1cGRhdGUNCj4g
aXRzIGNhbGxlci4NCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoN
Cj4gDQo+IEZpeGVzOiA4ZjgzZjI2ODkxZTEgKCJkcm0vbWVkaWF0ZWs6IEFkZCBIRE1JIHN1cHBv
cnQiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBIYW94aWFuZyBMaSA8aGFveGlhbmdfbGkyMDI0QDE2My5j
b20+DQo+IC0tLQ0K
