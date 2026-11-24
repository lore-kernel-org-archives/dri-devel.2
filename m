Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE80606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 06:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=c8d/5Aqz;
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=p4EKCs28
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8216210E3C2;
	Tue, 24 Nov 2026 06:14:05 +0000 (UTC)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C963C10E3C2
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 06:13:53 +0000 (UTC)
X-UUID: 36e00012e7ce11f1b1788b6acf885367-20261124
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=PhJLYy6Ro4tW5aVHuqa3y0dxGE2kvAIE4F+xXAGct0Y=; 
 b=c8d/5Aqzvpy7W3peGJab6pdDJfxfizf7NTIPCfPPzEJc7yCnDkiAXppA5SaPO6HBxO+2a/6hAnXJrT1S5336e+SWSEzf+97ZrSynoRHHP4vhuaGdYB6P2PRiNrTF4uQ4Qbn1pXy/khnWHbyYS5e4sRDn8K3jE1apD6DJXbYhu1U=;
X-CID-CACHE: Type:Local,Time:202611241413+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21, REQID:2e3378fc-f802-4e33-a455-30c7b913702a, IP:0,
 U
 RL:12,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:12
X-CID-META: VersionHash:b0318ac, CLOUDID:473512ed-0ff0-4c47-975b-86f238fbd439,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:11|97|93|83|106|99|80|1,File:130,RT:0
 ,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,B
 RR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 36e00012e7ce11f1b1788b6acf885367-20261124
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1307114034; Tue, 24 Nov 2026 14:13:49 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 24 Nov 2026 14:13:48 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.56 via Frontend Transport; Tue, 24 Nov 2026 14:13:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcGFnLn024z6FFzXexwt/judCm+5ytEFNYCP61cvTu9Bx38Kp/H0UUzLm340fAKZjc07IOneNl7KOj04GFm29UZgn/0xz4VehClj7U1Aa+ZizVajKZJfjG+GbU6/YWwEl5nQlNn2wG8rT++SEh+nq+agTXmkw7QXQiN2CcwTK8nsyMydGMqHN3qg5SEzgVpmFADbULQyVYR0mX2h4tp85ChLwSWPEQ+hmW9crUIov+ETzMZB7B1iNdSqggScVQ4qP3cQ9BT+SaXKnhHX3C08FjmkMD4x9Ny2IMWQlHChIkqrWyd5NAo8l0/RhWt4mkh7gYKqkETg7JCoNWIYOlzMFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PhJLYy6Ro4tW5aVHuqa3y0dxGE2kvAIE4F+xXAGct0Y=;
 b=k4k+AiSJ67OfamdGz+3opW1VHLZSu8Xl/In93QR4QrMNEVpHc+AXa245v2Omy7u7+6s6V0FADm4YExuS8pMeqOvMmoqiTXVTGvSb1azmBzWW/qKbiardA8W8K9cxjtuioE6rtEAmbVXR0Hm66xECm9/gEafPB8qCACNLyA95YSkzKj7ib1oAzhQWWsdqp2OXJmTfoVa7K2OnQ5EskgGqnEzoGhdrIX0inutCBZsLsjdyPRcf5F9xvO+17k67V+phPtV3z2/mdQHdp4EFOfzUxoX2TUrtBjTRGusR6tl7vQFUzFMd/Scca4Sk5Fi7tln0Y4QrlFFHcIUL1FawqEETVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhJLYy6Ro4tW5aVHuqa3y0dxGE2kvAIE4F+xXAGct0Y=;
 b=p4EKCs28Le97h5vZ01tnjLLGy+hB4mwe+ypc2ed6vFvTmCR5tnyfHzfPJLQ2Cj8EPHNO1wGMTShIv8kIIl+g7chiKVHYImpR4pnnPfubC1my580UWfjyVFibhPn3tAADvAIw/uWNjwI0rCzkyu2u/Vz0tHjV69/udn9jd8MUTs8=
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com (2603:1096:d10:91::20)
 by SE2PPF1E16A26CA.apcprd03.prod.outlook.com (2603:1096:108:1::48b)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 06:13:41 +0000
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b]) by KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b%5]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 06:13:41 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "conor+dt@kernel.org" <conor+dt@kernel.org>, "robh@kernel.org"
 <robh@kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "mripard@kernel.org"
 <mripard@kernel.org>, "kernel@collabora.com" <kernel@collabora.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "p.zabel@pengutronix.de"
 <p.zabel@pengutronix.de>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "airlied@gmail.com" <airlied@gmail.com>, 
 =?utf-8?B?SnVzdGluIFllaCAo6JGJ6Iux6IyCKQ==?= <Justin.Yeh@mediatek.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 27/46] dt-bindings: display: mediatek: Introduce
 Digital Video Output HW
Thread-Topic: [PATCH v2 27/46] dt-bindings: display: mediatek: Introduce
 Digital Video Output HW
Thread-Index: AQHdE4ZnYaB7NIHUHkaBzgPvK3IT1rc3A2eAgAU53YCAAVGVAA==
Date: Tue, 24 Nov 2026 06:13:41 +0000
Message-ID: <3ab396c26424834e9fa591a86ba7ff8f5561f847.camel@mediatek.com>
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-28-angelogioacchino.delregno@collabora.com>
 <98cde7319f539cab9f72ec370d309b26569889c9.camel@mediatek.com>
 <33cf13e4-6df0-45f8-b621-ffe3f43419c9@collabora.com>
In-Reply-To: <33cf13e4-6df0-45f8-b621-ffe3f43419c9@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR03MB9902:EE_|SE2PPF1E16A26CA:EE_
x-ms-office365-filtering-correlation-id: f5209ab3-b1f7-407e-35e3-08df49f21611
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|42112799006|376014|7416014|23010399003|366016|1800799024|18002099003|22082099003|6133799003|261009223027099003|4133799003|3023799007|261022113327099003|10067099003|11063799006|56012099006|4143699003|5023799004|261021135927099003|261028144727099003|261102123227099003|261026135527099003|261022075727099003|261021130227099003|261022105027099003|261026140227099003|261021133027099003|261021121427099003|261026121527099003|261021123027099003|261022115727099003|261026130827099003|38070700021;
x-microsoft-antispam-message-info: mGpQ80xPLY1jc8H5CkeSHvSGZQzI99591fkApH6bTt4Zdsdw9/9+qM26+N+e5nifbeiivguGAj+AQ8Qeatzv13GBa8L74ykwkxj7c6O3RzJosrxTBddeRMPJLhpego8yCGpRAPYnPfU7xqHPBXn5EpuGceDRrGR1rFSm0Dw784FjpsB4KfM/Pfzgpsosahx83RQK4i3k+3wUhF1GCgyvpSLCcjnj0lXmmwJzNr8dxZe3ph+7lbYcVGiedD3uuF8ggHS6u4Xli7LAiXPkyNqatRUeTpjHwx/aIpcrMIZ/rpka5d6Rk4WFdoQHcis995ma/VN0PMyIz1UMrAuW7DzkuQigQdrMxPqZ1CemKW0lSN/7kvTNCLJ4mLfYfZXJ+WOcjUUDLsb8dhyqw3N9kEchRmVRImQ0ZyDP/y3cgEyz15AKUBP0KsU8xr1w+5Pn2XEr1TUCo2gT9/fT7Qv/bFxDYFXI0Hc6+RTHKupSUR43gST8C6yeqOHTrpPJ6L6TYX8XTyh3ADhNmxfKoYiisXGHPV3s8hHhN6IXs8fg8G4cnpXVLvMmFaED7TPi33CnlEMVLvS8HzCZ/xXFOBSh50+3goyXICe2s1kRnalN3xOPitT5vQkHHLrXkoTnFognOV7JfLhAAjQHCFYz1kBsmC5bi9HylgIHWRYDXyw6zml6GJM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUYPR03MB9902.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(376014)(7416014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(6133799003)(261009223027099003)(4133799003)(3023799007)(261022113327099003)(10067099003)(11063799006)(56012099006)(4143699003)(5023799004)(261021135927099003)(261028144727099003)(261102123227099003)(261026135527099003)(261022075727099003)(261021130227099003)(261022105027099003)(261026140227099003)(261021133027099003)(261021121427099003)(261026121527099003)(261021123027099003)(261022115727099003)(261026130827099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlltQmQvdVRlZjNmT1BYaWJZWHIwV3JjZDdPSnNpdDFqdW90N2ZiWnpxVjNq?=
 =?utf-8?B?SzQ0M1Fvbm8xU1p4QlZXZWxGTWhMTFk4NWRLQTUyb3FIdWxGT0QvODhQa0Jp?=
 =?utf-8?B?SjhKZ21YVzEzWUZwTjB3ZEhWNk1qOVV3b2wvQVhBTjB3b3RVTWJmczVDb2NT?=
 =?utf-8?B?VmFVRmNDMWorZWU4d0lQbWFYUHR3VmhOTU1ON0h2VFJuN0pnZ2lZMXhWc01G?=
 =?utf-8?B?RzJtUzFHVUNZRVJrMWpwTytzTFhNakFNcWRZTUZnNzBjRmtpNG13OHRSb2Js?=
 =?utf-8?B?SWVqVytLWVNCTjFTZytXbTEyN1lXSTc5dkRoV0hkSUZTbUFuTGNJWlY5OTZE?=
 =?utf-8?B?b2FXL3ZpV3NZRkZwbnRXMHQzTXV5eTYyRlJsNU5nT0I2OXY0L1BMRkw0aEtp?=
 =?utf-8?B?Q2ZiOHNjTHB6RytyVkgzS0VQNm9pSWJlZFNMbGtTUlQrWEJrT3ZpUXZuZXNG?=
 =?utf-8?B?MFNEQVFORmxrcHBMVjBmZGdBamFnQjVlc3YrVURHbVBLQXZSV3FWRnhKN0pE?=
 =?utf-8?B?bG12UFpNRGxRVVhCakxiemV1VWJ5aGd3bTZTT3d5b2piblU4OFoxOW94ckR3?=
 =?utf-8?B?YXM0S2lVQXFqQXJJMDhDZ2l1UlNFeU5HSmJSQUk3eURLRVhrWmRKN2hQM0tB?=
 =?utf-8?B?NFRpOGNXWmlyTnd2TVRvd2JKNlVYallWc2ZOT2xFRjNXWFlKU0I1UFM3VGta?=
 =?utf-8?B?ODZwN3NiUjF6NDRNRWRUY0pUWGdlQ2p6alc4N2xhaFVvNkhhR0dVU2V4VVBS?=
 =?utf-8?B?YVUwWDFESHVGMEFNa2wwLyswTXVNb3JONitubjR1anErRWVGVnZtTXZURzlG?=
 =?utf-8?B?dEsvZDR4MFRyMkE1dzFqOSszVXlUYTFVeE9GVUJPMDY4RzBFZ0R2VXg2R2hY?=
 =?utf-8?B?QXIzWUJuUWxvUENNeDJxdXRlemxCQlFtZmR0cVRzSGFtREovRFZjUGgyMTM4?=
 =?utf-8?B?dWI5UHg5VFRVRWYxNFhsMmVrN3NxTWJKRkNsWDlNSFNiSExMRkJYZ1dsdEgx?=
 =?utf-8?B?a2V6SStlNHdOU0dxZk9QTWRqajZ2SFNhRW8xclUyMm94TThCSHRtLzJMT3gz?=
 =?utf-8?B?L0pIc2JwQVJFM2srRkNkNnVFbXlwU2VHcHhuaWQ3T1FMdUJmVmZCNml5V083?=
 =?utf-8?B?UVR6Q2pIcFp1OVV5c3h2TXJrOHFEVFMxbEtyZStVdHlwRGd5enUrVlR5aVdl?=
 =?utf-8?B?YW81aUNwby9naHRsU21BSTdaYmtHenB4YUxTU1VONmVCZEZmVHBiT2VMRjBm?=
 =?utf-8?B?Nkt1Rm9rem4rNTFMUkRjWEdNSUpKUjBUQ2JUUS91UzdLamFxbS9ZamU2aEp2?=
 =?utf-8?B?Vk13V1JBTVVnUDdwNmhYeDBaNkxJK2YvaWR3WGYrUzd3T3lTOEI2Y1FLRVpr?=
 =?utf-8?B?RDhVdldDNFRReWtVdzNpeUtaaFcvQ1pENkw2UjRuTG5jSktFOEZOMm9tbndo?=
 =?utf-8?B?TGFadG40ZmVMdkRwYXU5ZS9vOXVFMlYzSzVaTkRHTDVnUWd6NlJyTTRIS0po?=
 =?utf-8?B?M2ZTRVNaUlhjTDFsdUppV0dJZnpDNTJnbytDZWp5TUtOM3JYYVZKMlNJaXBh?=
 =?utf-8?B?TGNLb2g4ZUZxcFRmV3NJWVBZOC9JTUg3OXJQckh3WHExaTBjakc2Q2RaTmxD?=
 =?utf-8?B?ZGE3V0EvMFRCUHNNVkJxL0ZHcnhZUEZUZHYyczI4YzlaZWRLbVhCSFNiWkp6?=
 =?utf-8?B?UjY1Q2xMM0Z1L3VpaG5ONjc1ZWlsbERzSnBqRG5kM3FmMkMxTklhZWpRWlBH?=
 =?utf-8?B?emdpM1JOSE9DQ01JZ0ZweWY5RXlRZVUzMDFLUk5ua1pNQ1pGaHBjRmt4cHl6?=
 =?utf-8?B?SE51UzdYbGZaZ3ppWWlNMFk1RktYSzJvNHNTbVNtUFFNV05mWERGWml1MnJz?=
 =?utf-8?B?OGpjaUxKVVhRTnZ1K1BaajF1V2JVV3N5N0FGVHNWVXJpcVNpTW1LWFpYV2lp?=
 =?utf-8?B?aGxUbVVjQmcwdjN5NG5YK1NaTFlEdld5MnI4LzNOUnM3bUJyYnFuWW5vN20w?=
 =?utf-8?B?bklPdTZLRzhFMktlWWY4RytIYkxNS2djeml2MEZRMmpLVlBYWk5sdFRqQUZy?=
 =?utf-8?B?MVV1M1JxS1dyM2E1NCtZc0ovbFgyeHlWZFJFZG9EazhJdlRsYVdVMTF4cVBQ?=
 =?utf-8?B?L2VRKzR4cFJzZnA0MEw3dzE5KzgyS0pKNjJRZzRacmxGeGlkRFZVYmJ2ZDJM?=
 =?utf-8?B?TTJYTnlTd05Bczd3S0l0NUhLQTl2R0Z3VDBXMkFLRWRVbmlEY3gvdGw0b1dN?=
 =?utf-8?B?SE1YTzdEZU5McXdHbU5OTzlLeCs4NHVqakZIY1JrZ3B5U0xJUHQ0Yi9TQ3BD?=
 =?utf-8?B?anYrWFpHd2JUTmhuMXY0U1l0OGVXUFR0dVdKVHFGQzBTMGNQVEVQZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9210F52E8D7F14CA059CB3C0E0D6021@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Jw0LKi+/jfYmEtu9VI8TmbmSimQnwrt6DWwGJOu9MvtjB8YL+eAPEx3fK2N7zQdPlzimxydZSj4C576slGELWcHi24wRUaudy2xvME4VU1609jyFkNtE/YkwyvRwA9eU6YXjWJymlvq5xqr7v4QK6HAPJEYk0i/pIYPcAMmo8VIJvIt1xrNdZJzuUysSHhS/lRipbX8BqDLF+yrk8Wllpfk9fh9XrBYxKhgsOjhGbZc/nym2kYBsg4zqmERaG9PENUSEO7F2AWvvngvkLRZzgKtrqN3crf6oDfIAw/5YwwIQQ/VxUPd36XOqDYME8TwmIhvqOJHBxCz3nieJ3VvTAg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR03MB9902.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5209ab3-b1f7-407e-35e3-08df49f21611
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 06:13:41.0866 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hRt0g7nlnZB8BiyNOVgKIWWWcLCdZhajGp4q/gfe4Hk/dxTububTdqwxTQvD52g/jzBxQZu6ku3a5CB1DtH5yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF1E16A26CA
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

T24gTW9uLCAyMDI2LTExLTIzIGF0IDExOjA1ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gT24gMTEvMjAvMjYgMDM6MTcsIENLIEh1ICjog6Hkv4rlhYkpIHdyb3Rl
Og0KPiA+IE9uIFR1ZSwgMjAyNi0wNy0xNCBhdCAxMzo0MyArMDIwMCwgQW5nZWxvR2lvYWNjaGlu
byBEZWwgUmVnbm8gd3JvdGU6DQo+ID4gPiBBZGQgZG9jdW1lbnRhdGlvbiBmb3IgdGhlIERpZ2l0
YWwgVmlkZW8gT3V0cHV0IChEVk8pIElQIGZvdW5kIGluDQo+ID4gPiB0aGUgbmV3ZXIgZ2VuZXJh
dGlvbiBTb0NzIE1UODE5NiwgTVQ4MTg5IGFuZCB0aGVpciB2YXJpYW50cy4NCj4gPiA+IA0KPiA+
ID4gVGhpcyBpcyBlZmZlY3RpdmVseSBhIG1vcmUgY2FwYWJsZSBibG9jayByZXBsYWNpbmcgdGhl
IERpc3BsYXlQb3J0DQo+ID4gPiBJbnRlcmZhY2UgKERQSS9EUF9JTlRGKSBvbmUgZm91bmQgaW4g
b2xkZXIgU29Dcy4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlu
byBEZWwgUmVnbm8gPGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4g
PiA+IC0tLQ0KPiA+ID4gICAuLi4vZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxtdDgxOTYtZHZv
LnlhbWwgfCAxNDMgKysrKysrKysrKysrKysrKysrDQo+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAx
NDMgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssbXQ4MTk2LWR2
by55YW1sDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxtdDgxOTYtZHZvLnlhbWwgYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRl
ayxtdDgxOTYtZHZvLnlhbWwNCj4gPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gPiBpbmRl
eCAwMDAwMDAwMDAwMDAuLmIzODk2MDMyN2NhMQ0KPiA+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ID4g
KysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsv
bWVkaWF0ZWssbXQ4MTk2LWR2by55YW1sDQo+ID4gDQo+ID4gVGhpcyBmaWxlIHdvdWxkIGluY2x1
ZGUgbXVsdGlwbGUgU29DIGR2bywgc28gaXQncyBiZXR0ZXIgdG8gdXNlIG1lZGlhdGVrLGR2by55
YW1sLg0KPiANCj4gRGV2aWNldHJlZSBiaW5kaW5ncyBtYWludGFpbmVycyB3aWxsIGRpc2FncmVl
IHdpdGggdGhpcyBzdGF0ZW1lbnQgOy0pDQoNCk9oLCBpdCBzZWVtcyBtYW55IG1lZGlhdGVrIGRp
c3BsYXkgYmluZGluZyBkb2N1bWVudCBzaG91bGQgY2hhbmdlIGZpbGUgbmFtZS4NCg0KPiANCj4g
PiANCj4gPiA+IEBAIC0wLDAgKzEsMTQzIEBADQo+ID4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQo+ID4gPiArJVlBTUwgMS4yDQo+
ID4gPiArLS0tDQo+ID4gPiArJGlkOiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cDov
L2RldmljZXRyZWUub3JnL3NjaGVtYXMvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxtdDgxOTYt
ZHZvLnlhbWwqX187SXchIUNUUk5LQTl3TWcwQVJidyFuM3BrOTRrS29OLTd6ZmVtNVNIZkpuX2l4
RG1BbGVGT1cyZEp3bVo4VzVnSnotaUVRR0FONnlPa3B1cGFNWEF2QWxyM0tmQW5kQjVGank1N3RO
WHN4QV91dk55MyQNCj4gPiA+ICskc2NoZW1hOiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19f
aHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwqX187SXchIUNUUk5L
QTl3TWcwQVJidyFuM3BrOTRrS29OLTd6ZmVtNVNIZkpuX2l4RG1BbGVGT1cyZEp3bVo4VzVnSnot
aUVRR0FONnlPa3B1cGFNWEF2QWxyM0tmQW5kQjVGank1N3ROWHN4Tnp0V09pSCQNCj4gPiA+ICsN
Cj4gPiA+ICt0aXRsZTogTWVkaWFUZWsgRGlnaXRhbCBWaWRlbyBPdXRwdXQgKERWTykgQ29udHJv
bGxlcg0KPiA+ID4gKw0KPiA+ID4gK21haW50YWluZXJzOg0KPiA+ID4gKyAgLSBBbmdlbG9HaW9h
Y2NoaW5vIERlbCBSZWdubyA8YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29t
Pg0KPiA+ID4gKw0KPiA+ID4gK2Rlc2NyaXB0aW9uOg0KPiA+ID4gKyAgVGhlIE1lZGlhVGVrIERp
Z2l0YWwgVmlkZW8gT3V0cHV0IChEVk8pIGhhcmR3YXJlIHByb3ZpZGVzIDEyMC1iaXRzICg0UCkg
ZGF0YSwNCj4gPiA+ICsgIHZpZGVvIHRpbWluZyBhbmQgaW5mbyBkYXRhIGZvciB0aGUgRW1iZWRk
ZWQgRGlzcGxheVBvcnQsIGhhcmR3YXJlLWFic3RyYWN0aW5nDQo+ID4gDQo+ID4gIEZyb20gdGhl
IGNvbXBhdGlibGUgbGlzdGVkIGJlbG93LCBEVk8gbm90IG9ubHkgZm9yIGVEUCwgYnV0IGFsc28g
RFAsIHJpZ2h0Pw0KPiA+IA0KPiANCj4gWWVhaCwgb24gTVQ4MTg5IGl0J3MgYWxzbyBmb3IgRFAu
DQoNClNvIHRoZSBkZXNjcmlwdGlvbiBzaG91bGQgYmU6DQoNClRoZSBNZWRpYVRlayBEaWdpdGFs
IFZpZGVvIE91dHB1dCAoRFZPKSBoYXJkd2FyZSBwcm92aWRlcyAxMjAtYml0cyAoNFApIGRhdGEs
DQp2aWRlbyB0aW1pbmcgYW5kIGluZm8gZGF0YSBmb3IgdGhlIChFbWJlZGRlZCkgRGlzcGxheVBv
cnQNCg0KPiANCj4gPiA+ICsgIHRoZSBwcmV2aW91cyBnZW5lcmF0aW9uIERpc3BsYXkgUG9ydCBJ
bnRlcmZhY2UgKERQSS9EUF9JTlRGKSBibG9ja3MsIG90aGVyDQo+ID4gPiArICB0aGFuIHByb3Zp
ZGluZyBuZXcgY2FwYWJpbGl0aWVzLg0KPiA+IA0KPiA+IE5vIG5ldyBjYXBhYmlsaXR5PyBCdXQg
d2hhdCB5b3UgbGlzdCBiZWxvdyBpcyBuZXcgY2FwYWJpbGl0eSBvciB0aGUgc2FtZSBhcyBEUEkv
RFBfSU5URj8NCj4gPiANCj4gDQo+IFRoZSBuZXcgY2FwYWJpbGl0aWVzIGluY2x1ZGUgUFNSIGFu
ZCBNU08sIG90aGVyIHRoYW4gdGhlIDRUMVIgaW4gb3V0cHV0IChhcyBEUF9JTlRGDQo+IGRpZCBz
dXBwb3J0IHRoYXQgYnV0IG9ubHkgZm9yIHZlcnkgc3BlY2lmaWMgY29uZmlndXJhdGlvbnMpLg0K
DQpNeSBFbmdsaXNoIGlzIG5vdCBnb29kLiBJIGp1c3QgdGhvdWdodCAnb3RoZXIgdGhhbicgbWVh
bnMgJ25vdCcuDQoNCj4gDQo+ID4gPiArICBUaGlzIGhhcmR3YXJlIGJsb2NrIHN1cHBvcnRzIDEv
Mi80IHBpeGVscyBwZXIgaXRlcmF0aW9uIGluIGJvdGggaXRzIGlucHV0IGFuZA0KPiA+ID4gKyAg
b3V0cHV0IGFuZCBwcm92aWRlcyA4LzEwLWJpdCBSR0IsIFlVVjQyMiBhbmQgWVVWNDQ0IGRhdGEg
Zm9ybWF0cyBpbiBvdXRwdXQsDQo+ID4gPiArICBvdGhlciB0aGFuIHN1cHBvcnRpbmcgaW5wdXQv
b3V0cHV0IHZpZGVvIHdpbmRvdyBjcm9wcGluZyBhbmQgcGFkZGluZy4NCj4gPiA+ICsgIERpZ2l0
YWwgVmlkZW8gT3V0cHV0IGFsc28gcHJvdmlkZXMgUGFuZWwgU2VsZiBSZWZyZXNoIChQU1IpIGFu
ZCBNdWx0aS1TU1QNCj4gPiA+ICsgIE9wZXJhdGlvbiAoTVNPKSBmZWF0dXJlcyBmb3IgZURQIDEu
My8xLjQuDQo+ID4gPiArDQo+ID4gPiArcHJvcGVydGllczoNCj4gPiA+ICsgIGNvbXBhdGlibGU6
DQo+ID4gPiArICAgIGVudW06DQo+ID4gPiArICAgICAgLSBtZWRpYXRlayxtdDgxODktZHAtZHZv
DQo+ID4gPiArICAgICAgLSBtZWRpYXRlayxtdDgxODktZWRwLWR2bw0KPiA+IA0KPiA+IFRoaXMg
c2VyaWVzIGlzIHNvIGxhcmdlLCBzbyBpdCdzIGJldHRlciB0byBkcm9wIGFueSB0aGluZyB0aGF0
IGlzIG5vdCByZWxhdGVkIHRvIG10ODE5NiBhbmQgeW91IGNvdWxkIGFkZCB0aGVtIGJhY2sgbGF0
ZXIuDQo+IA0KPiBBcmUgeW91IHN1cmUgeW91IHdhbnQgbWUgdG8gZHJvcCB0aGF0Pw0KPiANCj4g
SXQncyBqdXN0IDEwIGxpbmVzIG9mIGNvZGUgYW5kIHNvbWUgcGxhdGZvcm0gZGF0YSByZWFsbHks
IEkgZG9uJ3QgdGhpbmsgaXQncyBhbGwNCj4gdGhhdCBtdWNoIHRvIGp1c3RpZnkgZHJvcHBpbmcg
aXQ/DQoNCklmIHlvdSBrZWVwIG10ODE4OSBjb21wYXRpYmxlIGhlcmUsIHlvdSBzaG91bGQgZGVz
Y3JpYmUgd2hhdCdzIHRoZSBkaWZmZXJlbmNlIG9mIHRoZXNlIGNvbXBhdGlibGUuDQpNYXliZSBl
dmVyeSByZXZpZXdlciBzZWUgdGhpcyB3b3VsZCBhc2sgeW91IGFnYWluIGJlY2F1c2UgdGhpcyBz
ZXJpZXMgaXMgZm9yIG10ODE5Ni4NClJlbW92ZSB0aGVtIGlzIG11Y2ggZWFzaWVyLiBJZiB5b3Ug
a2VlcCB0aGVtLCBpbnRyb2R1Y2UgdGhlbS4NCg0KUmVnYXJkcywNCkNLDQoNCj4gDQo+IENoZWVy
cywNCj4gQW5nZWxvDQo+IA0KPiA+IA0KPiA+IFJlZ2FyZHMsDQo+ID4gQ0sNCj4gPiANCj4gPiA+
ICsgICAgICAtIG1lZGlhdGVrLG10ODE5Ni1lZHAtZHZvDQo+ID4gPiArDQo+ID4gPiArICByZWc6
DQo+ID4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gPiArDQo+ID4gPiArICBpbnRlcnJ1cHRzOg0K
PiA+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ID4gKw0KPiA+ID4gDQo+ID4gDQoNCg==
