Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04F2606A325
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 02:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=XuBRG6ul;
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=igcstzGD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C025112838;
	Fri, 20 Nov 2026 02:17:30 +0000 (UTC)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39BA3112838
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 02:17:18 +0000 (UTC)
X-UUID: 7e6cb8cee48811f1b1788b6acf885367-20261120
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=5yasbLriWQvPaJa40hFvC8MO7A37zYTwPFwvA/y4WIk=; 
 b=XuBRG6ulqYVjHeskp0tLc+gqssz0dZDJDZazzr0q4YOgMQF/lvIzVg5Nk02QuvmU/bfg136WyKlCYbilV1E9f9X7d95EjqRGdfwwcwxn/QDdiHSLlmNhrBV7yU7hbyJS4RBLHa97Q2VHeQ0nPn9RGrT8qaozlAyEwciSveIlVDU=;
X-CID-CACHE: Type:Local,Time:202611201017+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21, REQID:4804aabf-c249-492f-b04a-5ea8f77d8d65, IP:0,
 U
 RL:12,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:12
X-CID-META: VersionHash:b0318ac, CLOUDID:32288b66-4b51-4c95-bb1b-80ac6aad9c96,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:97|93|83|106|11|99|80|1,File:130,RT:0
 ,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,B
 RR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7e6cb8cee48811f1b1788b6acf885367-20261120
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1629318593; Fri, 20 Nov 2026 10:17:11 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 20 Nov 2026 10:17:10 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 20 Nov 2026 10:17:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8dTxiMOnvCQfXiIyvUtRBjE+5ZZKo51AsI1nrUdU7moR48F6kYpLiAovbs4h7WQc3LwspSFeRA2fro9IEWrrsMM0PN5giTOUIScAMa4XwVWGuh8II6CYGXoxhhukd+fZbhRqTTLnY0xbfKCQQsOR3Z1BZBKUexVEi8Tt7qYbQYDOwGAm6uzj7A7gF2yCg7fukGHihXbX9+7ZAkjo6lO0i/ssVssKp5f+kQh8IdKE+Jue77XoVwu6N+R9VUERAYtgfsNQHM5M8VQuRI29XywIkQSkOqM1NDGBFLbAc7rBlFriiiOYYY0/sI+nRbjShS348hI6qWxad8Tn1YCeF3NDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yasbLriWQvPaJa40hFvC8MO7A37zYTwPFwvA/y4WIk=;
 b=hCTuOn74PhO/Qbfj8JXzabksBs8gX3DJ5MlefmPBq2pHzC78sfP2VP6vrYoPM/DJq2tzwR8NaR8GIMNoAM6Ujx/kXve3F3QB/GzUjuxnzQqx2cTOb4VZbGFj6S9gQ33Rsxw6iu6s+Rgwf9dhZPvO49qi3wFQG0g9qhGa0gqGZ8hgt00ZsWdppIeRt17LYiSzDDlpWND0XALJPMhkBAemqBSukq8//cxLM+W6A4t8gRHa1ayMcXSGyZhv7ne3SpHiYeA1yxuj/oD+Aayc1hOLG3hwUg+cMNWtkogfbR7MRmhIf5/UTFJXFC4kJZqluEpNWjodeXWfl9Zjtaro4ROq/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yasbLriWQvPaJa40hFvC8MO7A37zYTwPFwvA/y4WIk=;
 b=igcstzGDvxXaKHXUQMOWjVFZ4tqPBhCz7y74jsVwmwU4mCt0ZZejFx/yK45j2GfWJO8lAOXZO8ovL4XNXJcaPnEHMj3kuW+78oDyKefQoabwWJaccCgsQRNJLYWVd0T19o4TgWsGYFl/SRg7P7WncbitkHulzSJ+mQtxwbn7Yr8=
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com (2603:1096:d10:91::20)
 by JH0PR03MB8289.apcprd03.prod.outlook.com (2603:1096:990:46::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 02:17:02 +0000
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b]) by KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b%5]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 02:17:02 +0000
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
Subject: Re: [PATCH v2 27/46] dt-bindings: display: mediatek: Introduce
 Digital Video Output HW
Thread-Topic: [PATCH v2 27/46] dt-bindings: display: mediatek: Introduce
 Digital Video Output HW
Thread-Index: AQHdE4ZnYaB7NIHUHkaBzgPvK3IT1rc3A2eA
Date: Fri, 20 Nov 2026 02:17:02 +0000
Message-ID: <98cde7319f539cab9f72ec370d309b26569889c9.camel@mediatek.com>
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-28-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260714114414.184512-28-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR03MB9902:EE_|JH0PR03MB8289:EE_
x-ms-office365-filtering-correlation-id: 0315abe9-5e34-40f9-d095-08df46ac5d91
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|42112799006|366016|23010399003|7416014|376014|1800799024|6133799003|22082099003|18002099003|4133799003|3023799007|11063799006|4143699003|5023799004|56012099006|261022113327099003|261026135527099003|261022075727099003|261022105027099003|261022115727099003|261028144727099003|261026140227099003|261021121427099003|261021133027099003|261021130227099003|261021135927099003|261009223027099003|261102123227099003|261021123027099003|261026130827099003|38070700021|10067099003|261026121527099003;
x-microsoft-antispam-message-info: l7anHaY7FZdVN8T+NfUvpOftA+LED0lOXWzHXk9i8bRDNlFqs42NLrMItGG55fOhPVLxFYmqzZAXR6ZUak0si6vAq3QdF5yhomr7PQN03s1cG//7InHEx4E6cUCGzmpJkF6b9z6YlOt+cjQCNJWPHOhwnvbr0nksJRA88rXI0JsM9loJ++CDfrcMrzewCIo6mrLNFeuATSjdnRjIUiP8S6WQ8FSa1POl/8Sy2gbkEazoEcbB31OBElsHu5UhHDa6VtlRcLSmYVa9f/rO1cuiNTVtqhRB9GAfhXBXnHtd+B9OlVqQogKIn/4y3NOXZ+fuOsBDAZhcLsekioY5S4sV9R4thG6X8G5Ohnm6AS2FEPYGAG0TZTUoJtuilSB6p2d9r/8ii6smEPkazNtJXQ8QVGQcO7qLmk8Lj5mRXaMOb4saR925ttQfmIcZkelWUYz0iKDbBio9dzOqcECV402pbdMdXOgqKHYLa7i+op+0WCyFaY2zPk93XW2kE8Oqc2VR6uRHSAa8jF9CuxrIMgT+kidaXq0v9+UJ/LkQlSgIvNJg4ayjqJak2Ti/bnM5N3QSx70Ss8O4z47wLtLn9rSYJu8EwGu7okqKxbS6CC/BWbk8wtQHuJxtdzWAZAlqRuRgVKNfIUddkYBAzY0Q0+F9TmdBc3nwM5J59ZGDPQkpnPU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUYPR03MB9902.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(366016)(23010399003)(7416014)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(4133799003)(3023799007)(11063799006)(4143699003)(5023799004)(56012099006)(261022113327099003)(261026135527099003)(261022075727099003)(261022105027099003)(261022115727099003)(261028144727099003)(261026140227099003)(261021121427099003)(261021133027099003)(261021130227099003)(261021135927099003)(261009223027099003)(261102123227099003)(261021123027099003)(261026130827099003)(38070700021)(10067099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFAzUlRDQWFJOEYwalZXdUpuR04wOVd2bXY1ODhvL29NUUVUVVVnMVB0dVBV?=
 =?utf-8?B?eEhWL1hCc1lrNGQ3bTB5Z2p5UVBxQ2dvd2JHYW5ndVhpYVJXcWZTR0g3Z3BS?=
 =?utf-8?B?SnowRmUxNlNqUkJEZTZCN3owb3p2dWNnNWNTM0xYakxhWHRCK2FUUTl0Tngz?=
 =?utf-8?B?dFA1Nng0SFpMakZCMkgwVkU4aVVlZ2JkUGNybWlDOS9jZ0FvNDQrT2NyUlFB?=
 =?utf-8?B?QmRkZnBXM3dqN1NXZ21tMzUyV0UvbE94M2FRbm9hNGJqaUpFNk1SdWFsOGRu?=
 =?utf-8?B?THlrd3BkK0NVYUU1NTBITzBDalo1VHhBbGE3cW5OQytpdEJyaVZOdXk4dEdj?=
 =?utf-8?B?NVpJd0gyR3lCcjFGeXZEUXhSS2owWndDYjE2Ymk1c3ltcDg2MWd5U2hxeXFV?=
 =?utf-8?B?dFBJdnhKT01kTlpqL2ZVM1BqbS9QNDhxTVF0M1JEa21PR21hWTFlOFBFM0ts?=
 =?utf-8?B?bzVXUldqZVpjd0hISXkzeE1uK2kwUnk5V1EzU0pQWWxIUmFJeFpCbHFlbzlp?=
 =?utf-8?B?bnlhR3NPTHhkKzlZY3FWQ21ZZFM0UWpTbTNZSmg0Qnh5SklsSC9tOVEvNmN5?=
 =?utf-8?B?czRmK0R4ZzE4TGpad0RQVDBhb3AvNGhCbnlFQXRDcjZWeHpjWXJaQTY1RE92?=
 =?utf-8?B?RTg0ZklCbk44YUNsM21Wc1FuYll3MGxob1ViS2lKUG1iRllBS0tEaitHdDds?=
 =?utf-8?B?N0NoYjFpYTlMKzk0ZmxVWU04WGlCRmZNWVZGdXl4SktZbmxqQkFOVHlyVHR4?=
 =?utf-8?B?eDVHWTlKbTRzSS9nWkZ2S2RJeWZoampjVDRhQWV5NmdLdm9EUnlCWHJnZ0Nr?=
 =?utf-8?B?MnNlUlozWUlFUlFaWnhhK2tJektDc1ArMEZXS29nSUJtK0R1Y0c3a0lacUJo?=
 =?utf-8?B?dDlIZVlFOWttQU5Uc2lKMVJGMWFGTlUzSnM2RlJvSTFzbitZWkpwTjduNThO?=
 =?utf-8?B?QXNLMk9iR0tGSWxmUXlsZ3VsVDhPK3gvcEJpTzVQS3F1LzB0akVNQ0xpcGEv?=
 =?utf-8?B?MXhTeVJ4Sk9hNmRlc3h4WVMva05QR1hyb2hOdEtHbFZWa0dmczEvR0dtWnRH?=
 =?utf-8?B?Q3VvRGlEdUtQdmhXYW9VeTBSekNwZGF3eWc3azU4T2JpK2dyMVVkaVZyODdH?=
 =?utf-8?B?RkhURGI1eHkwYzM2RmJhelRsWXI5QWpuQlJjQkxSd3pJZUdxNVQ3UmtoUXFO?=
 =?utf-8?B?TTNyc2hGcVp4c0Z1c0pwM0lKYVZUdGFObkh1d1REVDFmZ2ZDM0cyNlA1UDU1?=
 =?utf-8?B?RmlVakFKcGFmSnlHcklmSExSQ29wbTZUaFVEUXFydDFneng2SjZUUlBVMFYx?=
 =?utf-8?B?WU13NWsycXg5ZEZ1SWF0dWU5YnYvYVIzTXdnNHdFeHJRSGxLZTRhNDFrNFNB?=
 =?utf-8?B?ekE5UjN2eU5QUFFUODV6VnRwOGF6Tkw5RmxjMk5HT1RjcEV2Qmh5SW9JVmlN?=
 =?utf-8?B?aHJ2S0pXamgrZCtxKzY4YjJZTnJ2emU4dFhxWXpyYVlDckQyWmNXYUpnUUNY?=
 =?utf-8?B?YWNuSUFCdnREUmFld1czWHFJTjRFL3h6eEdxd2NTNmJLMEpSaitUbnNvUU1j?=
 =?utf-8?B?WURheFJVaE5JVUxuUTRqZEtaUTZuWEtLMW5sUWVtcFRISE04WHhCVkFZWW56?=
 =?utf-8?B?c3paNWVKN0Jjb2FSM1g2MDBQRThGNm84bGZ2ZXBZYy9vSDlFUzNjZ1VHNDEy?=
 =?utf-8?B?ODhaQ2tZUFlINnRHY2JheUkwNkdKUy9ZcjlaN0pNS2RKSjhwSTc2WDhDWkdv?=
 =?utf-8?B?bzNSL04rUlFQMlV3ckxwR04wOCtaZkxNMlY3NS9jRmZBV3lOblZzVlAzdmQr?=
 =?utf-8?B?VE9jWS94ekZ1bklJbmlJL05PazlUZWRGbzBnY3p1UWRkTUszcG9kMmxHSy93?=
 =?utf-8?B?K01lL2hJZWVjTStPcVNBLytTWTl4YnlPcGRPdnRQYnVuTTJHY2tYRzYzVklk?=
 =?utf-8?B?UnhnS094RTlHY1o3K1NjVHVWN2hwM2JnRkZ1aUg1b0o1Y2JQVFJ3c29paUIy?=
 =?utf-8?B?Vm5WT24yS0c0M0xCZ0RSOWNIa1M2VWpwa2EzSEVqT0JnODBvVk9oaEFGMGVU?=
 =?utf-8?B?bDYrOU1aWVBkb3I3SW00c2k3WVVyajlHemc2ZVg5Q1JIbUczd29oWENHQ3Vu?=
 =?utf-8?B?TFJta3lvbkZLRjhLQzU1d2ZzeTA1ZjR2TnNuOUVQU0tTTkxaQVdnMzJ4U2ZP?=
 =?utf-8?B?L0lnM0dkK2ZOdTlTcG93cEpPeFFUZUprRy9ZbEFBOFdKa29zUm5wd2pRSFQv?=
 =?utf-8?B?Unk4SW1xanhVSnVGODk0V3lDVzhMWEEzYmF3NlBLMjF6cURsTHlkM1ExYlFk?=
 =?utf-8?B?QitpY3BMWXFLa1NFNVBVWU9XQVlFZHBDTTBmWVlEeHhRcCtUbGYzQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B95891766B4584CB5CAC42406784BFD@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hVA4j9zVeTRU/xelDTUNjyZeefR3FeD1W6UEhl+7g0fPbcnkrqDoHbaIsqBVAgnubTjvkT319GKbLnhjUEZo8UpGuaH4l2sxxOS7EOqG9O0/sbm1tb7sjecOesMf6BCzTtjsydR3UFAS7lkmIrlV1RmsC9VOGRwaB7kQvFDjMt0f2bqL+1pxODX1lDCJKZx9ljQhRgDQyIS0hs9hvABbYvQbOhSB4xYAGv59jbKbtX2FnAXMTVjQzsxV2oEVraIuZaOjlrFd7ws22D50t3EbjdhvtxZ8ivAG2e74i48VfWxdPW9THc9Nbiv5a2Iy0MTGxPLAPRhRokpkEyQgFoZPgA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR03MB9902.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0315abe9-5e34-40f9-d095-08df46ac5d91
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2026 02:17:02.7710 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MMzLMGJWwvkI9Iai6IwoZa7JKHew2u7ToFx+Ww93IenBMkzsb8c1RFYhjMDtaO2YFTTmJCmHV7scrW9m/fRTFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8289
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
ZWdubyB3cm90ZToNCj4gQWRkIGRvY3VtZW50YXRpb24gZm9yIHRoZSBEaWdpdGFsIFZpZGVvIE91
dHB1dCAoRFZPKSBJUCBmb3VuZCBpbg0KPiB0aGUgbmV3ZXIgZ2VuZXJhdGlvbiBTb0NzIE1UODE5
NiwgTVQ4MTg5IGFuZCB0aGVpciB2YXJpYW50cy4NCj4gDQo+IFRoaXMgaXMgZWZmZWN0aXZlbHkg
YSBtb3JlIGNhcGFibGUgYmxvY2sgcmVwbGFjaW5nIHRoZSBEaXNwbGF5UG9ydA0KPiBJbnRlcmZh
Y2UgKERQSS9EUF9JTlRGKSBvbmUgZm91bmQgaW4gb2xkZXIgU29Dcy4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9naW9hY2NoaW5vLmRlbHJl
Z25vQGNvbGxhYm9yYS5jb20+DQo+IC0tLQ0KPiAgLi4uL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0
ZWssbXQ4MTk2LWR2by55YW1sIHwgMTQzICsrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNo
YW5nZWQsIDE0MyBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssbXQ4MTk2
LWR2by55YW1sDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssbXQ4MTk2LWR2by55YW1sIGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssbXQ4
MTk2LWR2by55YW1sDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAw
MC4uYjM4OTYwMzI3Y2ExDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssbXQ4MTk2LWR2by55
YW1sDQoNClRoaXMgZmlsZSB3b3VsZCBpbmNsdWRlIG11bHRpcGxlIFNvQyBkdm8sIHNvIGl0J3Mg
YmV0dGVyIHRvIHVzZSBtZWRpYXRlayxkdm8ueWFtbC4NCg0KPiBAQCAtMCwwICsxLDE0MyBAQA0K
PiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1
c2UpDQo+ICslWUFNTCAxLjINCj4gKy0tLQ0KPiArJGlkOiBodHRwczovL3VybGRlZmVuc2UuY29t
L3YzL19faHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvZGlzcGxheS9tZWRpYXRlay9tZWRp
YXRlayxtdDgxOTYtZHZvLnlhbWwqX187SXchIUNUUk5LQTl3TWcwQVJidyFuM3BrOTRrS29OLTd6
ZmVtNVNIZkpuX2l4RG1BbGVGT1cyZEp3bVo4VzVnSnotaUVRR0FONnlPa3B1cGFNWEF2QWxyM0tm
QW5kQjVGank1N3ROWHN4QV91dk55MyQgDQo+ICskc2NoZW1hOiBodHRwczovL3VybGRlZmVuc2Uu
Y29tL3YzL19faHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwqX187
SXchIUNUUk5LQTl3TWcwQVJidyFuM3BrOTRrS29OLTd6ZmVtNVNIZkpuX2l4RG1BbGVGT1cyZEp3
bVo4VzVnSnotaUVRR0FONnlPa3B1cGFNWEF2QWxyM0tmQW5kQjVGank1N3ROWHN4Tnp0V09pSCQg
DQo+ICsNCj4gK3RpdGxlOiBNZWRpYVRlayBEaWdpdGFsIFZpZGVvIE91dHB1dCAoRFZPKSBDb250
cm9sbGVyDQo+ICsNCj4gK21haW50YWluZXJzOg0KPiArICAtIEFuZ2Vsb0dpb2FjY2hpbm8gRGVs
IFJlZ25vIDxhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+ICsNCj4g
K2Rlc2NyaXB0aW9uOg0KPiArICBUaGUgTWVkaWFUZWsgRGlnaXRhbCBWaWRlbyBPdXRwdXQgKERW
TykgaGFyZHdhcmUgcHJvdmlkZXMgMTIwLWJpdHMgKDRQKSBkYXRhLA0KPiArICB2aWRlbyB0aW1p
bmcgYW5kIGluZm8gZGF0YSBmb3IgdGhlIEVtYmVkZGVkIERpc3BsYXlQb3J0LCBoYXJkd2FyZS1h
YnN0cmFjdGluZw0KDQpGcm9tIHRoZSBjb21wYXRpYmxlIGxpc3RlZCBiZWxvdywgRFZPIG5vdCBv
bmx5IGZvciBlRFAsIGJ1dCBhbHNvIERQLCByaWdodD8NCg0KPiArICB0aGUgcHJldmlvdXMgZ2Vu
ZXJhdGlvbiBEaXNwbGF5IFBvcnQgSW50ZXJmYWNlIChEUEkvRFBfSU5URikgYmxvY2tzLCBvdGhl
cg0KPiArICB0aGFuIHByb3ZpZGluZyBuZXcgY2FwYWJpbGl0aWVzLg0KDQpObyBuZXcgY2FwYWJp
bGl0eT8gQnV0IHdoYXQgeW91IGxpc3QgYmVsb3cgaXMgbmV3IGNhcGFiaWxpdHkgb3IgdGhlIHNh
bWUgYXMgRFBJL0RQX0lOVEY/DQoNCj4gKyAgVGhpcyBoYXJkd2FyZSBibG9jayBzdXBwb3J0cyAx
LzIvNCBwaXhlbHMgcGVyIGl0ZXJhdGlvbiBpbiBib3RoIGl0cyBpbnB1dCBhbmQNCj4gKyAgb3V0
cHV0IGFuZCBwcm92aWRlcyA4LzEwLWJpdCBSR0IsIFlVVjQyMiBhbmQgWVVWNDQ0IGRhdGEgZm9y
bWF0cyBpbiBvdXRwdXQsDQo+ICsgIG90aGVyIHRoYW4gc3VwcG9ydGluZyBpbnB1dC9vdXRwdXQg
dmlkZW8gd2luZG93IGNyb3BwaW5nIGFuZCBwYWRkaW5nLg0KPiArICBEaWdpdGFsIFZpZGVvIE91
dHB1dCBhbHNvIHByb3ZpZGVzIFBhbmVsIFNlbGYgUmVmcmVzaCAoUFNSKSBhbmQgTXVsdGktU1NU
DQo+ICsgIE9wZXJhdGlvbiAoTVNPKSBmZWF0dXJlcyBmb3IgZURQIDEuMy8xLjQuDQo+ICsNCj4g
K3Byb3BlcnRpZXM6DQo+ICsgIGNvbXBhdGlibGU6DQo+ICsgICAgZW51bToNCj4gKyAgICAgIC0g
bWVkaWF0ZWssbXQ4MTg5LWRwLWR2bw0KPiArICAgICAgLSBtZWRpYXRlayxtdDgxODktZWRwLWR2
bw0KDQpUaGlzIHNlcmllcyBpcyBzbyBsYXJnZSwgc28gaXQncyBiZXR0ZXIgdG8gZHJvcCBhbnkg
dGhpbmcgdGhhdCBpcyBub3QgcmVsYXRlZCB0byBtdDgxOTYgYW5kIHlvdSBjb3VsZCBhZGQgdGhl
bSBiYWNrIGxhdGVyLg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiArICAgICAgLSBtZWRpYXRlayxtdDgx
OTYtZWRwLWR2bw0KPiArDQo+ICsgIHJlZzoNCj4gKyAgICBtYXhJdGVtczogMQ0KPiArDQo+ICsg
IGludGVycnVwdHM6DQo+ICsgICAgbWF4SXRlbXM6IDENCj4gKw0KPiANCg0K
