Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1AC606A695
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=hcyOevwx;
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=rmT272wr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8188A10F317;
	Tue, 24 Nov 2026 08:31:46 +0000 (UTC)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F05E10F317
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 08:31:34 +0000 (UTC)
X-UUID: 71c800aee7e111f18dc8c9802ae25ab1-20261124
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=qztIg0RUpc6C8qFT892yxHJS90jMsV0EutzrKNRQljY=; 
 b=hcyOevwxjnb23ExlRpe1HU3gUu62Tde81Vznut0ADQBBxFxaoHgBXo9PqSvn7hW9Lk2BYHRahhbALjp/J7ULRCnz3/b91aXH5citupaU6xR+oGQ25F2ge2vXXkhuJDCdQk2UNmJg4ulyZkRCW0oc4zLKA8pmXmBez3BzmDUfh8w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21, REQID:6602094c-cb03-4c57-84cf-a5f4588659d6, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:b0318ac, CLOUDID:2d92900a-13f1-4a67-84b6-dc87fe97c2ec,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|136|836|865|888|898,TC
 :-5,Content:0|15|50|99,EDM:-3|-100,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:
 nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
 C:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 71c800aee7e111f18dc8c9802ae25ab1-20261124
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 304881328; Tue, 24 Nov 2026 16:31:28 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 24 Nov 2026 16:31:27 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.56 via Frontend Transport; Tue, 24 Nov 2026 16:31:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vhUHa+eVXeEgJgOQT8gh+jO9QThhfwIltHBY74rr2SX1Qx++lH0a3N+r9np06Hqh8ZkqnRQZ48lpTNYmHTWLNk38R7t4lHNEguD05F8U14pGfHqnS7NAwNH5oIbtJuFz6yJDBHPXEzTLzDMMKVbTMHTVUgvTGb/VylPgpd9mfGAHGFO7b3UGaRvDyz9QCA/oM9MXF+p9Mx5CUX+bz9G8/yxAmbyq/0KlQ6TR+jwOSwfpqac50Wo/ayDZlmi1aQynSv8Sh7YpcK5adWsTC7RsdgEDD66LFTM+Hai2cE+2evOMYBapns6ktCrd3GrUnKpVNd5pgU/eOdk/fUb+bW5QeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qztIg0RUpc6C8qFT892yxHJS90jMsV0EutzrKNRQljY=;
 b=B5CJHHrlKm1t8mTo55KxN6pa+NRH/ecoxCxmam7mtO4zM4pUKFJR0CJJc098afRblf+dIUNzmqu98A27lcwEhKSbIa+gqMqZXWvcr5V+6N+NQ03+OU9qghjKA4/rCw4SdOAXep7iLIz9jkXOf6Y7YEnj21ilTB6CooNwT2/vYdVSJhL4s+qu7e2j8aCT4ElZGzKbfHOaGTs5seUdk+NexHBviUDQjGzqBlPA7S4DygAIHDhN28fX7u1/3iEk1npu6zKuCsmiCdmIj5RQjLBPX2zMsGTh+Qbbj+lDXVNJuGMjy3ffV2Xq4KMkp1rvyqmSTuI1XcK/NAKx/k7Dr4DDOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qztIg0RUpc6C8qFT892yxHJS90jMsV0EutzrKNRQljY=;
 b=rmT272wrVQSx28doM7M+1BFcbCdAoJHJ5SfFyr81GqlQD5Wx/cDdo1W6dKC6f+rgf1l9i+pf5Fx3qrp7T2Yb1dWCD89re/SH72rPFFalE3xzkJ9Z3Y8VU1xQ3tqOkzyASqvtmYpPdW0F5QAtZSATZGcK7c+btnzSHd9siUE9o7Y=
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com (2603:1096:d10:91::20)
 by TYZPR03MB6494.apcprd03.prod.outlook.com (2603:1096:400:1c9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 08:31:22 +0000
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b]) by KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b%5]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 08:31:22 +0000
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
Subject: Re: [PATCH v2 31/46] drm/mediatek: Add support for Display Layer
 Blender component
Thread-Topic: [PATCH v2 31/46] drm/mediatek: Add support for Display Layer
 Blender component
Thread-Index: AQHdE4ZtbOpSm2hufEyueWiwkDpwf7c9tVIA
Date: Tue, 24 Nov 2026 08:31:22 +0000
Message-ID: <f69ba9f0142a691dc7f68bdb46e3d90c9e024996.camel@mediatek.com>
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-32-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260714114414.184512-32-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR03MB9902:EE_|TYZPR03MB6494:EE_
x-ms-office365-filtering-correlation-id: 2f35d93b-1da5-41cc-13aa-08df4a055256
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|42112799006|366016|1800799024|376014|7416014|22082099003|18002099003|11063799006|56012099006|261009223027099003|261021123027099003|4143699003|38070700021|10067099003;
x-microsoft-antispam-message-info: coIV+hk3UKxnOWemvoC31sAwuqHkhU2bSoY4ej51Ae+ahRfiC0mCVtGSaduLynaG7j97IMwYvYztaUx843KC57rK3dnvbFVXtYesPK06yfR2af279NkHllkyMpeyrOGgsWlvdX5SDdH8UOQy4qjZ4c6MOuYb39x2lphNrGMv+C2MeRDg52mK1EqD5/jGkRWiFB4+mwuf/l8mE2Y+Xdhyp1gPpsqPqUQBG4VhIy+fdgcUH3TdAO/JOlKmW8l83bLXSWi8hXTFpOm8OdFyG2AVWFbnwAkriW6XITbBNX2JBLAXqo0Bj9Q5jOgHT4tkIfJRz2npZgQjivlcGgKgUVQ0wDyDmAY6bUAVQXSCOz6nVeLwUHfRur6jNFAvS+gFRClU7tgFvgv2yRocaG0w16/Baz4FYDZ6VtZxV9dNB1gG+w3yxra8UJ3lHaYXvxeM55ERvmPJhaCYKIZs/a0DUIpxbb5cL/l4aBiqBUY7PE5+GzZ8DXs7CeYjEq1WMhVBy28fGtJkteDcBx081v0+WVJV+Lp/V63SJHEnoJ3BRFqpg/YgzXYU7uO5xzGSaWcXg/gARInsCQmkXhAMkWA5LjstZv2Gf7DcDPjxPhwOw/UDwhl9l193CDBoAltpSZV8Tzddwdn0aex5cNtP/GJ+oQJyuxRf4LF3lYB5ffQFdNxfFNuL0tK4ON2/jcO221aykK0KCpnBVJC7dZDRijKx0mTLU2Fuj5Qg9kv6WLZz/9UrSqw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUYPR03MB9902.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(42112799006)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(11063799006)(56012099006)(261009223027099003)(261021123027099003)(4143699003)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGdWOVcwQktzME5wRFpTelFPMjBwaEkzb2NGUVR3TmcvNUZYUFQ4ZlZRS09R?=
 =?utf-8?B?cFJCbE5TVURteDViNDVPWlRoMXhtSTU2YlBwNnN0N0xQY0ZRWUh4bXNodExp?=
 =?utf-8?B?Zm9WZFYvWWZDZkRzc3NxbFMzNENwb0NxeUhoaGNtQVFmazNlaUo4SmpMcWFj?=
 =?utf-8?B?cEIxa25tcW9zUHFwd0FKMjN2WVZodEVva1dWZmZtdUhOUzFvbHhZVjZJUWRR?=
 =?utf-8?B?ZTB6eStJOFdzTkVEelZqZnVYV0t2NW5tOFdRRW9aR3o1VVQxUnlib1hhblJO?=
 =?utf-8?B?aTY5QTF1aUo1bERoMHFwTlZyTjlVaitESU15THp4bXVrdjk4c1B2Qm4xK2Ur?=
 =?utf-8?B?K1NNTEkvSzZNSnBlNjB6UkgzU2RDMFRodlkvYTk2VTJkNmNFS3F5cFgwRzl4?=
 =?utf-8?B?Qkk2RERjcStSM3FNUjQySVRKc0ptS3hQUkpxRG9MYkI2NE9OQkVqYm12Tzcz?=
 =?utf-8?B?aFNtUENCOU5jUFZsOWNyUXQ1azNNdFU2UGJVVWI2MTJoeUlaL2JHR2JKNXlq?=
 =?utf-8?B?eXEySGs2dEx5SlcyNFkzY05BcGNKMVI4Z3hPYXJLNFgxQ2lTV25mclE5aENG?=
 =?utf-8?B?ZTNIbXdaRnN2dDNZRW9kRHd2SHFuYzJwTW92TVB4TjlJUEFkSW1NcTJ3M21U?=
 =?utf-8?B?OHZMd1BkZUFmR1dkenBrcjBVLy9jenFPUElxVDlBbEl0Z1pBSnoyY2RzM0dp?=
 =?utf-8?B?QVBLOHl4bHNteUJvYXd6bTFhMmRLQlhLWDZ1a09lWlhZUW5VYWlqWmdsZUxO?=
 =?utf-8?B?SUlGN0IyOEVzLzhEanZZdDJBNExQQXQ2VGVWcklqdG4wVlpmaysxQ1B6d1JD?=
 =?utf-8?B?Rnh3dDlOK2VaWWFGVnBIOTRlM3hteGY3WDZsbXlUY0wzVncrdFBuUWRocTlR?=
 =?utf-8?B?SjBFTmZ3VVI4UmRTNWd4RU9idExnWG5kVkdFMWxSYmd6LzZOOHNDTlo5UmlS?=
 =?utf-8?B?anZUd0l3bzRnZEplQ1NXKzdDVmRoWTdiZXF3N09zdXJmbnJuQVVjd1U0WkJa?=
 =?utf-8?B?d1dmT3B4R0NCUWlQMWE3WGZpMFZqRHZhTVF6YU4yUDl4Tjh6Zkg2Q3ZldnlQ?=
 =?utf-8?B?MWpuay8wRTRKV3lTT3ZtQ2ZnRC84dlRZTnU3Ulk3Z1BPRVAzL09PK3lSRFFz?=
 =?utf-8?B?MGZwTXYzMFBKUlErbzU5MFdoTU9tSE5VOU5XU3puaXlEVk80cEhRNXlYQlph?=
 =?utf-8?B?ZEE0NHV3Tk5LYVlDcnJYQm9OZjhndHpDOFhLR3pVL3JsZDFsNjJXa2s2WGlY?=
 =?utf-8?B?YS8xbk9uT2hramIreURqZVE0VXYrMEhaNDgvbTNDcG1OTmpMNSsxbmtWemgr?=
 =?utf-8?B?WW9lU0gzS0VxUWNabCs0a0pmWmxKOVdMaU45QjBvQUd4VXRSaGNxWWh6d2I5?=
 =?utf-8?B?TlNIOFRJbmlRUDNxTkhCNGRaOElLcDdRbSs4U3cvTUdHTjlaK2NrZzIrTFQ2?=
 =?utf-8?B?czhlbWRWeGszQS9jSnlaWmtmb1cxQ3NuMGZVQVFwclNmV0g2VjE3TVY3Zm9y?=
 =?utf-8?B?OFBFdk1vV1NpMGkyNjZweDV6czNTL2xzaXNEelp0NWp6VnVydGFBN3RSL2xJ?=
 =?utf-8?B?b1EvRmM3b0VUSGtIdmRzVmdQWi84YStLdmhxbXRmYzVOZXd6YVVzTmdkUzRp?=
 =?utf-8?B?VGVqS2ZjWlhUbkdjSE53dE5iMXVGaWpERm9XUGlkdFhIWjZDa0pRS0hlYzhY?=
 =?utf-8?B?V2VvUjRYaVJLYmpIRzlaRk5IcXAwMXdTM1FvT05PQnBjL3BTKzNoNGVUZnB3?=
 =?utf-8?B?c0dFV2cvbDcwNUhGNjdEMTB4UVgrSHd6SjArT1VtTWl1MmNiNEdYOFgyT3E2?=
 =?utf-8?B?aXdUNG9ENTZuOGR4Q3FNNVBRcnJVbmkvY0U5QXNEaGUxRUVDOFVjMDkzbjBT?=
 =?utf-8?B?ZE5MV052Q0NNMnZnNmF5M3MwS2tiOUpkWGlrMjA3UEpOWFJiL0FBNjBwUGlD?=
 =?utf-8?B?Vnp5MFBpcDgrcVN2T1ZyQkJGK0RFbTFrWFQrcWhmUUpvaFZkbnUvR0FmcWIv?=
 =?utf-8?B?ZVNnaTQ4UWpDdVRjbDR6eGdKSTNHaWRxTzlYcGJuTGtYbmVDaFVIOVp2TVMr?=
 =?utf-8?B?aDUxM24xRWJ5ZmpWR3AxZ1U4dVN1aDJGeXIvdDFpZEJtUlgvNXdCMnh5OGxW?=
 =?utf-8?B?SEZtYyt0NTk1NlJwdytSTy9CQ1FEb04yWlB4WTZBdHd3ME1QRDdoNjdMODNW?=
 =?utf-8?B?c3lBcFdCVEhkdUhBNTJFSmdXVzhrKzhNMlNpbmhGTXdtQkhKakRFbllFY2Nh?=
 =?utf-8?B?UVJFRWRkZzdFZzR0Q2VLN3EzQjJOMkR6bVVrc0oxaTloZFBWZHZkQ3pYZTMv?=
 =?utf-8?B?ZFNxYjZ1MlJRY0RnWjdMZDZLSWZFS3k1NFpJeVdxVVdlWGJDY2JOdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <03F243490340F44E93DCFE1A70C27F0D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: i4Bzj3mlDQMytcS6H2BEoHJyFKgktgwVETugq2W/sV0vhVL00AtSBFWtPBTrROdsa2uHO2mMYZxKfi0TVRhUpmBqVFZc25ryH+IWArNZNsj5fHmk9Jt2S3x0ZtC0HWbSpLTV4Im451qVpKHQSsjp+fOFDkW4ylOGeycC7zvOKFrPqrTiyZyLmdYX65+w+dAhRjCIqcMUXrtyW2oqnGLRIuiwx4dbrIguIpWJDeAcNZvFtgmq2YuLe8CLi5IVhv8ICLnRIu6n2SxlUayO3x3CQ7oCJhxpeLSV+R+qR8PvozxevQb5EvWl96wrr3GRdQ1PmMUqlwaVyw3QY6mYnooEAA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR03MB9902.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f35d93b-1da5-41cc-13aa-08df4a055256
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 08:31:22.6446 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qmaoi6FyM31igarO/Jirdfut5vBz4DfV2v+hFiQFCX2Jsk4Jxz1gpR2VyZYhznL4+DDDw2NCxBnHDkFtndkqNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6494
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
ZWdubyB3cm90ZToNCj4gQWRkIHN1cHBvcnQgZm9yIHRoZSBMYXllciBCbGVuZGVyIGhhcmR3YXJl
IGNvbXBvbmVudCwgZm91bmQgaW4gdGhlDQo+IE1lZGlhVGVrIEtvbXBhbmlvIFVsdHJhIE1UODE5
NiwgR2VuaW8gUHJvIDUxMDAgTVQ4ODk0LCBEaW1lbnNpdHkNCj4gOTQwMCBNVDY5OTEgYW5kIG90
aGVycy4NCj4gDQo+IFRoaXMgY29tcG9uZW50IGlzIHJlc3BvbnNpYmxlIGZvciBtYW5hZ2luZyBi
bGVuZGluZyBvZiBzaW5nbGUNCj4gbGF5ZXIgc3RhZ2VzIGFuZCB0aGVyZWZvcmUgaW1wbGVtZW50
cyBvbmUgZnVsbCBsYXllciBzdGFnZSB3aGljaA0KPiBnZXRzIGNvbXBsZXRlZCBieSBhbiBleERN
QSBoYXJkd2FyZSBjb21wb25lbnQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG9HaW9hY2No
aW5vIERlbCBSZWdubyA8YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0K
PiAtLS0NCg0KW3NuaXBdDQoNCj4gK3N0YXRpYyB2b2lkIG10a19ibGVuZGVyX3Vuc2V0X2lucHV0
X2JnY2xyKHN0cnVjdCBtdGtfZGlzcF9ibGVuZGVyICpwcml2KQ0KPiArew0KPiArCXUzMiB2YWw7
DQo+ICsNCj4gKwl2YWwgPSByZWFkbChwcml2LT5yZWdzICsgRElTUF9SRUdfT1ZMX0JMRF9EQVRB
UEFUSF9DT04pOw0KPiArCXZhbCAmPSB+T1ZMX0JMRF9CR0NMUl9JTl9TRUw7DQo+ICsJd3JpdGVs
KHZhbCwgcHJpdi0+cmVncyArIERJU1BfUkVHX09WTF9CTERfREFUQVBBVEhfQ09OKTsNCg0KbXRr
X2RkcF93cml0ZV9tYXNrKCkuDQoNCj4gK30NCj4gKw0KDQpbc25pcF0NCg0KPiArdm9pZCBtdGtf
YmxlbmRlcl9jb25maWcoc3RydWN0IG10a19kZHBfY29tcCAqY29tcCwgdW5zaWduZWQgaW50IHcs
DQo+ICsJCQkgICAgIHVuc2lnbmVkIGludCBoLCB1bnNpZ25lZCBpbnQgdnJlZnJlc2gsDQo+ICsJ
CQkgICAgIHVuc2lnbmVkIGludCBicGMsIHN0cnVjdCBjbWRxX3BrdCAqY21kcV9wa3QpDQo+ICt7
DQo+ICsJc3RydWN0IG10a19kaXNwX2JsZW5kZXIgKnByaXYgPSBkZXZfZ2V0X2RydmRhdGEoY29t
cC0+ZGV2KTsNCj4gKwl1MzIgdmFsOw0KPiArDQo+ICsJLyogU2V0IFJPSSBmb3IgdGhpcyBCbGVu
ZGVyICovDQo+ICsJdmFsID0gKChoICYgR0VOTUFTSygxNSwgMCkpIDw8IDE2KSB8ICh3ICYgR0VO
TUFTSygxNSwgMCkpOw0KPiArCXdyaXRlbCh2YWwsIHByaXYtPnJlZ3MgKyBESVNQX1JFR19PVkxf
QkxEX1JPSV9TSVpFKTsNCg0KVGhlcmUgaXMgcGFyYW1ldGVyIGNtZHFfcGt0LCBzbyB1c2UgbXRr
X2RkcF93cml0ZSgpLg0KDQo+ICsNCj4gKwkvKg0KPiArCSAqIFNldCBib3RoIGJhY2tncm91bmQg
Y29sb3IgYW5kIGNvbnN0YW50IGxheWVyIGNvbG9yIHRvIE9wYXF1ZSBCbGFjaw0KPiArCSAqIChB
UkdCKSBmb3IgZXZlbnR1YWwgQWxwaGEgQmxlbmRpbmcgdG8gYmUgZWZmZWN0aXZlDQo+ICsJICov
DQo+ICsJd3JpdGVsKE9WTF9CTERfQkdDTFJfQkxBQ0ssIHByaXYtPnJlZ3MgKyBESVNQX1JFR19P
VkxfQkxEX0JHQ0xSX0NMUik7DQo+ICsJd3JpdGVsKE9WTF9CTERfQkdDTFJfQkxBQ0ssIHByaXYt
PnJlZ3MgKyBESVNQX1JFR19PVkxfQkxEX0wwX0NMUik7DQo+ICt9DQo+ICsNCj4gK3ZvaWQgbXRr
X2JsZW5kZXJfY29ubmVjdChzdHJ1Y3QgbXRrX2RkcF9jb21wICpjb21wLCBzdHJ1Y3QgZGV2aWNl
ICptbXN5c19kZXYsDQo+ICsJCQkgICAgICBzdHJ1Y3QgbXRrX2RkcF9jb21wICpuZXh0KQ0KPiAr
ew0KPiArCXN0cnVjdCBtdGtfZGlzcF9ibGVuZGVyICpwcml2ID0gZGV2X2dldF9kcnZkYXRhKGNv
bXAtPmRldik7DQo+ICsJY29uc3QgdTMyIG1hc2sgPSBPVkxfQkxEX0JHQ0xSX09VVF9UT19QUk9D
IHwNCj4gKwkJCSBPVkxfQkxEX0JHQ0xSX09VVF9UT19ORVhUX0xBWUVSIHwNCj4gKwkJCSBPVkxf
QkxEX0JHQ0xSX0lOX1NFTDsNCj4gKwl1MzIgZGF0YV9wYXRoID0gT1ZMX0JMRF9CR0NMUl9JTl9T
RUw7DQo+ICsJdTMyIHZhbDsNCj4gKw0KPiArCS8qIFVzdWFsbHkgdGhlIG5leHQgY29tcG9uZW50
IGlzIGVpdGhlciBhbm90aGVyIE9VVFBST0Mgb3IgYW4gZXhETUEgKi8NCj4gKwlpZiAobmV4dC0+
dHlwZSA9PSBNVEtfRElTUF9PVVRQUk9DKQ0KDQpNVEtfRElTUF9PVVRQUk9DIGlzIG5vdCBkZWZp
bmVkIHVudGlsIHRoaXMgcGF0Y2guDQpNb3ZlIHRoaXMgcGF0Y2ggYWZ0ZXIgTVRLX0RJU1BfT1VU
UFJPQyBpcyBkZWZpbmVkLg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiArCQlkYXRhX3BhdGggfD0gT1ZM
X0JMRF9CR0NMUl9PVVRfVE9fUFJPQzsNCj4gKwllbHNlDQo+ICsJCWRhdGFfcGF0aCB8PSBPVkxf
QkxEX0JHQ0xSX09VVF9UT19ORVhUX0xBWUVSOw0KPiArDQo+ICsJdmFsID0gcmVhZGwocHJpdi0+
cmVncyArIERJU1BfUkVHX09WTF9CTERfREFUQVBBVEhfQ09OKTsNCj4gKwl2YWwgPSAodmFsICYg
fm1hc2spIHwgZGF0YV9wYXRoOw0KPiArCXdyaXRlbCh2YWwsIHByaXYtPnJlZ3MgKyBESVNQX1JF
R19PVkxfQkxEX0RBVEFQQVRIX0NPTik7DQo+ICsNCj4gKwltdGtfbW1zeXNfaHdfY29ubmVjdCht
bXN5c19kZXYsDQo+ICsJCQkgICAgIGNvbXAtPnR5cGUsIGNvbXAtPmluc3RfaWQsIG5leHQtPnR5
cGUsIG5leHQtPmluc3RfaWQpOw0KPiArfQ0KPiArDQoNCg==
