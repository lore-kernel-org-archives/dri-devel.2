Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEAE606A886
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 03:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=hZcYSqNQ;
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=PkO1teN3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 508B710E049;
	Mon, 16 Nov 2026 03:27:14 +0000 (UTC)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 472AF10E049
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 03:27:02 +0000 (UTC)
X-UUID: 9359d79ee16d11f1b1788b6acf885367-20261116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=e2pKOB6QxvBsNmEiwNG9WfHEgxnQxS6lUW3vIoDgcOs=; 
 b=hZcYSqNQ7pRpBtyfr2/x2mu1LTLccGl9RWn3qIbfL+RDgQjmbRDY3fqsaQEEmcJSAJH6rCSB/qkQ+xCI200Td6BY1uEo8l10rUEg5d4dND5/mqBQigLxFlwOInFilNVS4N5+8zhabNwX86um6sHMspttlJrtsjT48jIg823kGVM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21, REQID:50c8c891-fbda-4e17-8b70-5add54ccdee0, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:b0318ac, CLOUDID:53bc9e19-ae4c-4a2b-b1c4-72e411efd0c9,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:n
 il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9359d79ee16d11f1b1788b6acf885367-20261116
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1141651905; Mon, 16 Nov 2026 11:26:56 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 16 Nov 2026 11:26:55 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 16 Nov 2026 11:26:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/BuLb8RbWBa87fjoN/6k54l4GUQySu7DCjm6vv8WwaIj+XigsiQqZIUu8Nbs2sH5OCHj0fffUfj8MVxyE15yM/x3qyylCH40WdYyrylNllXydSDjJuPQJQPy46gXuWQPqKohZJnRKIXrAGSsh8pyCrdk+bnsgNxxj2mq90Xy2wNCH23qc2M2ST1/InFM5a2l5ahVlMuYplgGNUXOk6Lm5KBsmB2T6mM0YXhkzqKZuqzO8yFo5TfqH0hf5zXoNputaPN4Gj+0XBUaltEbWjqnP7YL+O53MynjoY0GBRSygRBKbg4N6vgPrryH7Ebs3/jl28lyV+9MTHEYiBFGSNl3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2pKOB6QxvBsNmEiwNG9WfHEgxnQxS6lUW3vIoDgcOs=;
 b=ccFjtlKiiZyZ+myA6gtFE7x9xK5EvBiJQnKKLoovyIyTgOhjmsERhVT387v94eBjd8E/Plm9g8CPcky32p6r4M7+eBeagpOrp1eJxOov3DRBeNWL4bJHZ0iQ8Fnh/yFxqLgk4/kGxyXOdgmV419Nkbx/pqfemGCiemiJgOwttROcr4YgJTsfXnLJehF0lPv31cM0JjuM/W4Yw33Y7HqTpIseRG2tsUxZUot3rOejJMpDRtBx7Tm/0JzJMOrtPZGolv2MvpIaBQtwBprsw21X5+fXbWmcvoZIAMOg+uTf8BPW0bji9Uiihnjnd0ugwGpKtLcH9sc5QgGqkJJ08F+lcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2pKOB6QxvBsNmEiwNG9WfHEgxnQxS6lUW3vIoDgcOs=;
 b=PkO1teN3nB3uGUelgcScqVHu8W07QwT9RMECijpiOU1iDaRl+JxkxT0mG1wsUcmEl+EC+/wZPTf+jdxlv/2k8T6KlMTL7en4zon+Wt8Eur8LTb3aHgCscBrmP3OHUI8AZva5X1aQgYz1ipZIP/fTR7oL/JTl+vuvSrpsGYnD3MI=
Received: from TYNPR03MB9924.apcprd03.prod.outlook.com (2603:1096:405:3d6::13)
 by JH0PR03MB7805.apcprd03.prod.outlook.com (2603:1096:990:2d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 03:26:51 +0000
Received: from TYNPR03MB9924.apcprd03.prod.outlook.com
 ([fe80::6274:7513:996f:7f8d]) by TYNPR03MB9924.apcprd03.prod.outlook.com
 ([fe80::6274:7513:996f:7f8d%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 03:26:49 +0000
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
Subject: Re: [PATCH v2 25/46] drm/mediatek: mtk_dpi: Fully separate HW setup
 from common code
Thread-Topic: [PATCH v2 25/46] drm/mediatek: mtk_dpi: Fully separate HW setup
 from common code
Thread-Index: AQHdE4Zp6CJPVvWB90W+JFXrDea2V7cwzZMA
Date: Mon, 16 Nov 2026 03:26:49 +0000
Message-ID: <5f374025f65147e894d057416e818d4d79176241.camel@mediatek.com>
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-26-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260714114414.184512-26-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYNPR03MB9924:EE_|JH0PR03MB7805:EE_
x-ms-office365-filtering-correlation-id: e2c4432b-408c-4610-6b7e-08df43917356
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|42112799006|23010399003|1800799024|366016|376014|7416014|261102123227099003|261022075727099003|261022113327099003|261021123027099003|261021121427099003|261026121527099003|38070700021|11063799006|4143699003|56012099006|10067099003|18002099003|22082099003|6133799003|261009223027099003|3023799007;
x-microsoft-antispam-message-info: K5wxxHxq5YuhMp8yrPToIpcTGl0eoOHizEA9tTFXN/TGhg+bpokGBvZryHMmOazS1xtBytysL2LqAVluZwwHRQIYR41XOwMqnT2iTAE8Z05ijqaPfcCv7waYbMKEfNmfLR+8mcCkZ9IZU6ZXYHcuHYEdGHl54N/B9fx13FzDxZc0pzedd1zfyBYzJmZvGNfIcijWFOIOGxzNciLj3gZddKdH3BP1oxFSDoJz3X+5LaArntBAuIJ2rchl73AIfdawcpY7q8vBqslNe1BN8ZGv2LbkGiO6hRbQD2iL2LbIUygMM0X9fpE0UGGMiL7E6Bh6L/R/dtmg/+A2F/JCs0yirQeQ+NZOMizpsBpDnKgUd7P8gUO/r0KQH3Opfo0qCzQSKtyxRJx8nb1s81xM+RwN4rRmY1ZljlmSww3csnxFflhdhEk3LNqIRRlRCDMb5+dVyWwbyxK5Ab7gIoAwFGxalGVdtrQW+n2fH7K4RR7zZb7LCCnSliM+iP7b0AVMxS2FDNgLLABWtmZm42wJIiBp+uE1YMiXeRInZpxyoZe133lPweoyFMNQRDYvbRJIvOfL2l8Otz8Oim4Z/pdXsMaxPz41XUIkuI2PHL1E5SHB0hVGhEIp2zRkWntKXbXxBsmOxn5sUQ2ESJp8YDzDfTtyW3XbOZOFulvvHnE22b1Ve1PwrI4lCT6RFRSn00hOfmMkX5IvAm2CTp/Ov48rTMdXuY5qqLm5dMQ4CkgGaFe/u10=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR03MB9924.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(23010399003)(1800799024)(366016)(376014)(7416014)(261102123227099003)(261022075727099003)(261022113327099003)(261021123027099003)(261021121427099003)(261026121527099003)(38070700021)(11063799006)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003)(261009223027099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nk1DVUJRNTl2N2dCL3pOQzBnMlY5aDJ2RVovRTlRRGpMQ1hYNFk2dHQzNldh?=
 =?utf-8?B?Umk0aTBUcnFpcGdVNmd0L3VRSDFKb3lDS1ErMkprNnp2T0tVc0s1R3ArMnVX?=
 =?utf-8?B?aTZzY2JKQjRZcW9NcFRuaXAxWmlua0E5bTVrWjc3N1o3SGFSeVFHQkNjQ2dQ?=
 =?utf-8?B?WlU2bWFmZTcvRENnRDNJdVl2MXpXeEtLU2NVZklCY0FhYzhkcUpzd3Ftd0Q5?=
 =?utf-8?B?Qk1ZaGhobnJVTlpFWHlpbzgxQ1ZQbnhUNmNLSDNTU25rS0tJQmRVWTFDaTZx?=
 =?utf-8?B?UlRiS3Iva2tHR0JjVGdWMDFOdjFkZXV5cnpLVUROcnRRQ0k5cllYa2s4ZmJp?=
 =?utf-8?B?NkpwZi9PTFg5d3NudUNWcXgyRlkyU2llblQ5Uk1TYStlSGhyR1k3dmVrdUtZ?=
 =?utf-8?B?ZXlsWktCTXRmMXVISHFCMjlKTFlxb3gxWmpSOVd2MU5yZzNaQmdqanlRK2VG?=
 =?utf-8?B?ZVdQaHJjaHVoZ3hSZHpEeWNsKy8xY3Y1Z3krVlF1akt2ejYyMEllR2pFSlhE?=
 =?utf-8?B?UmUxNFQydDVsbnNJclVDSmY2Yi90NFA1dWxPYXdZMjViY1lUVjN3cHNuRnNM?=
 =?utf-8?B?TElHQUhLZU8xbWhsYVcwUmI1K3dnMWl0Q3lOd1NXY2k3YzF4M2l0U3gxcU16?=
 =?utf-8?B?bnRKRmFVellxWDNNODc3Z0FPT21LU2ZNRmZNVmNEVUZ2UWQ1NCtPdGVtRDVE?=
 =?utf-8?B?Y284MkVlUE1lVnk3VXlCcWJVamZwQXI4RExZY3J5MS84bGZvd0pLQnBZZ0tK?=
 =?utf-8?B?VlBnYVp6UlFURWEzcW8wcGsrTVlFU1licUpZV3pWTEJjZHVsQVl4c29Ocm5j?=
 =?utf-8?B?WXFjR0hNWGxvemtoRTNRdjFqdmkyZHhwamM5SnZMUS9NM1ROdXdFV3Y5NHJa?=
 =?utf-8?B?dXIyUGZvTUZkYjd5Mk9XNnpXa0tKbE1SNGlhR2w2b2VhTXlvME5Xb1hIMFMv?=
 =?utf-8?B?aGhPMUJVMmxhdWVVS09TQ1diYWtZeEgwY3hMam1mb0Q0a0NsM3FCUEdkby9P?=
 =?utf-8?B?YkZlNWRVRkdNc1huUkhpRkc2dXlmOVBJRFdRblF0NFNtZ0RMWFB5aDVCZkpu?=
 =?utf-8?B?dnJrZ05tYlRQN1RGVTNWSTdqamxVYlpNdjgwV0l3NjlBaEtBTytVODljV1BK?=
 =?utf-8?B?b1ZXVXBySTlrNkxGYnlSanVTamN4OWJwMTN1c2hEb3FyN0ZMWTV2M0I5V041?=
 =?utf-8?B?cldjSFppeTEwclFUK0F1ZWRQMlI5T0JxZU5lWXJkVUZFcTZuSU8yM3JMbnQz?=
 =?utf-8?B?clRGN1lmU29BMElzWXJzSURiZ2wzWkxIV3Q4Uis0dFZzWGwxL2VuNU1KdUNy?=
 =?utf-8?B?LzNteGdyTG83TjNCUVJiQWpSSzRTN3JYM0w2Zkw1OWQxTzBJbW1wYU9aQUtW?=
 =?utf-8?B?NnIyMFBoVW9ZemdEUFN6Y0pXRko4WTNaZ3hIR0F1Ly9qUk0xWkR0U1drNUxq?=
 =?utf-8?B?N3BRUXROVGptSWNJZ3dCc1g0c1ZyTFFiaGRVb2lFazJSOUxJZzVmOW9UM0d5?=
 =?utf-8?B?OGF2anQrRjh3cUZpTEFuSklhRG9CNTNxUE5FS2pNVzV2SlJSbVBYVGZ6L2VD?=
 =?utf-8?B?Qms1R3g3TlE0S0tzY0lqZkVyUDBQODJublFqbmVzbkNvbjdNQXdrNTRGKys5?=
 =?utf-8?B?bjFjV3EwNnpRVkRmYWFwbnhYOWJ3UXZTeHZ0WWVaTTZCbDA0MmxFV0ZrSVNO?=
 =?utf-8?B?YVFqWGJweUJ6MXVGWERyNEU2S2lhZUpGcHNtM3paZy9uNE91ZUZBSExVSFBq?=
 =?utf-8?B?Q1pXdGZEOFUvd05IOEpLenFma1prQWdQRUxPTXN5ajlySkw3QXd4UWR6UVlO?=
 =?utf-8?B?MWQyYU0raXB2dEdiT25TNG5zSDZDbkpvN2NtTzRGbzlteUljNTROczJDV1R1?=
 =?utf-8?B?L0VaZFlqeVcwRWFJeVNSYm41VVdVZ3dRK2htUUp1YkhYc0JqUEZYWFVvYVNk?=
 =?utf-8?B?cldhT0pRbTYzdEVEMW1FYXQ4dWFTcHpRNHBVbXlnTUtNS0Y2RlBOZlpSQ2xj?=
 =?utf-8?B?ZUpKZnZHbHBZWVAyczYrcTBYdWJGZDZLb2RNVmhsZkhSeXRYNDVpZ0VQZ2g3?=
 =?utf-8?B?M0YvWExmRzFsUk9CV3hHVkkzakdGMDI3ZjlLV2pGRFlVK2UxYXpBVmwwL2wz?=
 =?utf-8?B?LzZ1MjBaWDVQVXRocXZMS0ZENHczQktyL29WYWFCY2NtQjJiSHJaL0ZTZ3Rp?=
 =?utf-8?B?aXFNbU1CUGJ2TmJESjB3em5mN242eGg3U2ZJUjQ2RWVicFd0VlN5Wjd0Wis3?=
 =?utf-8?B?bTJDN0FLRTBGZkxuWXdKdnRzNkUxVGhtNG5kQ01aM2RxNWNNRW1UbkRob3RB?=
 =?utf-8?B?TDkrK0RQdmRRWXFQUFBVdldCa0lpc0VZSU8yMVl6VjlvNDZ2N2dkUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7899A224FFDD1499F59EFFE371E1CAD@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BrHicobq+W0w45Q46QP3AqiB3YiyIbtSgVpwyXAdq7XyNGuVba5RpDOJk9yOhx81mojV3jFLryd+xPxKEuEn+w6Oo5PWCZfEHc5JVGong2bsmkBFPl2W1zLs/GKLdVOWSgLk81Hecv8PZISCCSyqf8iuodGangdJGwtv5hKS+ISYSZauKe/PhH4w/BP7V/5IKGtm3Jiy3S3ZbUwCOojh+BZWbfd9OUlYWd7S3KVXlxplgIWyQB73TatxdKzl64q68fVsnhoUo1h/WbInhnW95Y1ZM9yYIK1w7jZ+gtiTzIgtWFKKlClfD3oiWtAaivS7LaAv8d2NxLQ4t1YomUyuGQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYNPR03MB9924.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c4432b-408c-4610-6b7e-08df43917356
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2026 03:26:49.3877 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uKFjQ6fiIauE0Q087Cqtz1vXPXu/zu+Iml0yeV99TxGJXiumedogR1v2LxZdGH+o5hhlIDhgFtlvSQCn3dG+Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7805
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
ZWdubyB3cm90ZToNCj4gQXMgYSBwcmVwYXJhdGlvbiBzdGVwIGZvciBhZGRpbmcgc3VwcG9ydCBm
b3IgRFZPIGFuZCBjcmVhdGluZyBhDQo+IG10a19kcGlfY29tbW9uIGxpYnJhcnksIGZ1bGx5IHNl
cGFyYXRlIGFsbCBvZiB0aGUgcmVnaXN0ZXIgd3JpdGluZw0KPiBtZWNoYW5pc21zIGZyb20gY29t
bW9uaXphYmxlIGhhcmR3YXJlIHNldHVwIGZ1bmN0aW9ucy4NCj4gDQo+IFdoaWxlIGF0IGl0LCBh
bHNvIHBlcmZvcm0gc29tZSBzcGFyZSBjb2RlIHN0eWxlIGNsZWFudXBzIGFuZCBhbHNvDQo+IHJl
bW92ZSB0aGUgbXRrX2RwaV9jb25maWdfdnN5bmNfe2wscn17b2RkLGV2ZW59KCkgZnVuY3Rpb25z
IGFuZA0KPiBvcGVuLWNvZGUgdGhlIHNpbmdsZSBsaW5lIGZvdW5kIGluIGVhY2ggb2YgdGhvc2Us
IGFzIG5vdyBhbGwgb2YNCj4gdGhlIHBhcmFtZXRlcnMgYXJlIGNsZWFybHkgbGFiZWxlZCBhbmQg
d29uJ3QgaGF2ZSBhbnkgbWVhbmluZ2Z1bA0KPiBpbXBhY3Qgb24gaHVtYW4gcmVhZGFiaWxpdHku
DQo+IA0KPiBUaGlzIGNoYW5nZSBicmluZ3Mgbm8gZnVuY3Rpb25hbCBkaWZmZXJlbmNlcy4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9naW9h
Y2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+IC0tLQ0KDQpbc25pcF0NCg0KPiBAQCAt
NTE2LDcgKzQ3NCw2IEBAIHN0YXRpYyB2b2lkIG10a19kcGlfcG93ZXJfb2ZmKHN0cnVjdCBtdGtf
ZHBpICpkcGkpDQo+ICAJaWYgKC0tZHBpLT5yZWZjb3VudCAhPSAwKQ0KPiAgCQlyZXR1cm47DQo+
ICANCj4gLQltdGtfZHBpX2Rpc2FibGUoZHBpKTsNCg0KQ29tbWl0IG1lc3NhZ2Ugc2F5cyBubyBm
dW5jdGlvbiBkaWZmZXJlbmNlLCBidXQgZnVuY3Rpb24gY2hhbmdlcyBoZXJlIGJlY2F1c2Ugb2Yg
cmVmZXJlbmNlIGNvdW50Lg0KVGhpcyBpcyBub3QgcmVsYXRlZCB0byB0aGUgdGl0bGUgIkZ1bGx5
IHNlcGFyYXRlIEhXIHNldHVwIGZyb20gY29tbW9uIGNvZGUiLA0Kc28gc2VwYXJhdGUgdGhpcyB0
byBhbiBpbmRlcGVuZGVudCBwYXRjaC4NCg0KPiAgCWNsa19kaXNhYmxlX3VucHJlcGFyZShkcGkt
PnBpeGVsX2Nsayk7DQo+ICAJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGRwaS0+dHZkX2Nsayk7DQo+
ICAJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGRwaS0+ZW5naW5lX2Nsayk7DQo+IEBAIC02MDcsNDAg
KzU2NCw0MCBAQCBzdGF0aWMgdm9pZCBtdGtfZHBpX3NldF9waXhlbF9jbGsoc3RydWN0IG10a19k
cGkgKmRwaSwgc3RydWN0IHZpZGVvbW9kZSAqdm0sIGludA0KPiAgCQlwbGxfcmF0ZSwgdm0tPnBp
eGVsY2xvY2spOw0KPiAgfQ0KPiAgDQo+IC1zdGF0aWMgaW50IG10a19kcGlfc2V0X2Rpc3BsYXlf
bW9kZShzdHJ1Y3QgbXRrX2RwaSAqZHBpLA0KPiArc3RhdGljIGludCBtdGtfZHBpX3NldF9kaXNw
bGF5X21vZGUoc3RydWN0IG10a19kcGkgKmRwaSwgc3RydWN0IHZpZGVvbW9kZSAqdm0sDQo+ICAJ
CQkJICAgIHN0cnVjdCBtdGtfZHBpX3N5bmMgKnN5bmMsDQo+IC0JCQkJICAgIHN0cnVjdCBkcm1f
ZGlzcGxheV9tb2RlICptb2RlKQ0KPiArCQkJCSAgICBzdHJ1Y3QgbXRrX2RwaV9wb2xhcml0aWVz
ICpkcGlfcG9sLA0KPiArCQkJCSAgICBzdHJ1Y3QgbXRrX2RwaV95Y19saW1pdCAqbGltaXQpDQo+
ICB7DQo+IC0Jc3RydWN0IG10a19kcGlfcG9sYXJpdGllcyBkcGlfcG9sOw0KPiAtCXN0cnVjdCB2
aWRlb21vZGUgdm0gPSB7IDAgfTsNCj4gKwlzdHJ1Y3QgZHJtX2Rpc3BsYXlfbW9kZSAqbW9kZSA9
ICZkcGktPm1vZGU7DQo+ICANCj4gLQlkcm1fZGlzcGxheV9tb2RlX3RvX3ZpZGVvbW9kZShtb2Rl
LCAmdm0pOw0KPiArCWRybV9kaXNwbGF5X21vZGVfdG9fdmlkZW9tb2RlKG1vZGUsIHZtKTsNCj4g
IA0KPiAgCWlmICghZHBpLT5jb25mLT5jbG9ja2VkX2J5X2hkbWkpDQo+IC0JCW10a19kcGlfc2V0
X3BpeGVsX2NsayhkcGksICZ2bSwgbW9kZS0+Y2xvY2spOw0KPiArCQltdGtfZHBpX3NldF9waXhl
bF9jbGsoZHBpLCB2bSwgbW9kZS0+Y2xvY2spOw0KPiAgDQo+IC0JZHBpX3BvbC5ja19wb2wgPSBN
VEtfRFBJX1BPTEFSSVRZX0ZBTExJTkc7DQo+IC0JZHBpX3BvbC5kZV9wb2wgPSBNVEtfRFBJX1BP
TEFSSVRZX1JJU0lORzsNCj4gLQlkcGlfcG9sLmhzeW5jX3BvbCA9IHZtLmZsYWdzICYgRElTUExB
WV9GTEFHU19IU1lOQ19ISUdIID8NCj4gKwlkcGlfcG9sLT5ja19wb2wgPSBNVEtfRFBJX1BPTEFS
SVRZX0ZBTExJTkc7DQo+ICsJZHBpX3BvbC0+ZGVfcG9sID0gTVRLX0RQSV9QT0xBUklUWV9SSVNJ
Tkc7DQo+ICsJZHBpX3BvbC0+aHN5bmNfcG9sID0gdm0tPmZsYWdzICYgRElTUExBWV9GTEFHU19I
U1lOQ19ISUdIID8NCj4gIAkJCSAgICBNVEtfRFBJX1BPTEFSSVRZX0ZBTExJTkcgOiBNVEtfRFBJ
X1BPTEFSSVRZX1JJU0lORzsNCj4gLQlkcGlfcG9sLnZzeW5jX3BvbCA9IHZtLmZsYWdzICYgRElT
UExBWV9GTEFHU19WU1lOQ19ISUdIID8NCj4gKwlkcGlfcG9sLT52c3luY19wb2wgPSB2bS0+Zmxh
Z3MgJiBESVNQTEFZX0ZMQUdTX1ZTWU5DX0hJR0ggPw0KPiAgCQkJICAgIE1US19EUElfUE9MQVJJ
VFlfRkFMTElORyA6IE1US19EUElfUE9MQVJJVFlfUklTSU5HOw0KPiAgDQo+ICAJLyoNCj4gIAkg
KiBEZXBlbmRpbmcgb24gdGhlIElQIHZlcnNpb24sIHdlIG1heSBvdXRwdXQgYSBkaWZmZXJlbnQg
YW1vdW50IG9mDQo+ICAJICogcGl4ZWxzIGZvciBlYWNoIGl0ZXJhdGlvbjogYWRqdXN0IHRoZSBk
aXNwbGF5IHBvcmNoZXMgYWNjb3JkaW5nbHkuDQo+ICAJICovDQo+IC0Jc3luYy0+aHN5bmMuc3lu
Y193aWR0aCA9IHZtLmhzeW5jX2xlbiAvIGRwaS0+Y29uZi0+cGl4ZWxzX3Blcl9pdGVyOw0KPiAt
CXN5bmMtPmhzeW5jLmJhY2tfcG9yY2ggPSB2bS5oYmFja19wb3JjaCAvIGRwaS0+Y29uZi0+cGl4
ZWxzX3Blcl9pdGVyOw0KPiAtCXN5bmMtPmhzeW5jLmZyb250X3BvcmNoID0gdm0uaGZyb250X3Bv
cmNoIC8gZHBpLT5jb25mLT5waXhlbHNfcGVyX2l0ZXI7DQo+ICsJc3luYy0+aHN5bmMuc3luY193
aWR0aCA9IHZtLT5oc3luY19sZW4gLyBkcGktPmNvbmYtPnBpeGVsc19wZXJfaXRlcjsNCj4gKwlz
eW5jLT5oc3luYy5iYWNrX3BvcmNoID0gdm0tPmhiYWNrX3BvcmNoIC8gZHBpLT5jb25mLT5waXhl
bHNfcGVyX2l0ZXI7DQo+ICsJc3luYy0+aHN5bmMuZnJvbnRfcG9yY2ggPSB2bS0+aGZyb250X3Bv
cmNoIC8gZHBpLT5jb25mLT5waXhlbHNfcGVyX2l0ZXI7DQo+ICAJc3luYy0+aHN5bmMuc2hpZnRf
aGFsZl9saW5lID0gZmFsc2U7DQo+ICANCj4gLQlzeW5jLT52c3luY19sX29kZC5zeW5jX3dpZHRo
ID0gdm0udnN5bmNfbGVuOw0KPiAtCXN5bmMtPnZzeW5jX2xfb2RkLmJhY2tfcG9yY2ggPSB2bS52
YmFja19wb3JjaDsNCj4gLQlzeW5jLT52c3luY19sX29kZC5mcm9udF9wb3JjaCA9IHZtLnZmcm9u
dF9wb3JjaDsNCj4gKwlzeW5jLT52c3luY19sX29kZC5zeW5jX3dpZHRoID0gdm0tPnZzeW5jX2xl
bjsNCj4gKwlzeW5jLT52c3luY19sX29kZC5iYWNrX3BvcmNoID0gdm0tPnZiYWNrX3BvcmNoOw0K
PiArCXN5bmMtPnZzeW5jX2xfb2RkLmZyb250X3BvcmNoID0gdm0tPnZmcm9udF9wb3JjaDsNCj4g
IAlzeW5jLT52c3luY19sX29kZC5zaGlmdF9oYWxmX2xpbmUgPSBmYWxzZTsNCj4gIA0KPiAtCWlm
ICh2bS5mbGFncyAmIERJU1BMQVlfRkxBR1NfSU5URVJMQUNFRCkgew0KPiArCWlmICh2bS0+Zmxh
Z3MgJiBESVNQTEFZX0ZMQUdTX0lOVEVSTEFDRUQpIHsNCj4gIAkJc3luYy0+dnN5bmNfbF9ldmVu
ID0gc3luYy0+dnN5bmNfbF9vZGQ7DQo+ICAJCXN5bmMtPnZzeW5jX2xfZXZlbi5zaGlmdF9oYWxm
X2xpbmUgPSB0cnVlOw0KPiAgDQo+IEBAIC02NTMsMjcgKzYxMCw1NSBAQCBzdGF0aWMgaW50IG10
a19kcGlfc2V0X2Rpc3BsYXlfbW9kZShzdHJ1Y3QgbXRrX2RwaSAqZHBpLA0KPiAgCQlzeW5jLT52
c3luY19yX29kZCA9IHN5bmMtPnZzeW5jX2xfb2RkOw0KPiAgCX0NCj4gIA0KPiArCWlmIChkcm1f
ZGVmYXVsdF9yZ2JfcXVhbnRfcmFuZ2UoJmRwaS0+bW9kZSkgPT0gSERNSV9RVUFOVElaQVRJT05f
UkFOR0VfTElNSVRFRCkgew0KDQpkcm1fZGVmYXVsdF9yZ2JfcXVhbnRfcmFuZ2UobW9kZSkNCg0K
UmVnYXJkcywNCkNLDQoNCj4gKwkJbGltaXQtPnlfYm90dG9tID0gMHgxMDsNCj4gKwkJbGltaXQt
PnlfdG9wID0gMHhmZTA7DQo+ICsJCWxpbWl0LT5jX2JvdHRvbSA9IDB4MTA7DQo+ICsJCWxpbWl0
LT5jX3RvcCA9IDB4ZmUwOw0KPiArCX0gZWxzZSB7DQo+ICsJCWxpbWl0LT55X2JvdHRvbSA9IDA7
DQo+ICsJCWxpbWl0LT55X3RvcCA9IDB4ZmZmOw0KPiArCQlsaW1pdC0+Y19ib3R0b20gPSAwOw0K
PiArCQlsaW1pdC0+Y190b3AgPSAweGZmZjsNCj4gKwl9DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4g
K30NCj4gKw0KDQo=
