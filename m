Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB520606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 08:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=DrGhBZTi;
	dkim=pass (1024-bit key, unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=sswDajS/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BCCA10FA3F;
	Wed, 28 Oct 2026 08:35:37 +0000 (UTC)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7337010FA3F
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 08:35:25 +0000 (UTC)
X-UUID: 8146cc3cd2aa11f18dc8c9802ae25ab1-20261028
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=jHrlwZx6/rM5dfzKCYZyGiRhlLV3m9y9gRPOyreZ9ys=; 
 b=DrGhBZTiCRnRXFZsMAnCIPeb4w409KBEQ10UZKoV/02zEwGv7IjMHtaIN39p8Tq1ztcPmdJbEuNQ+sS70VpHNt+sfHcEx9jwB5p5kTOUFtSe/wYQMPNfGYtLSD3/4wl2j3GVfCiAJElKFV9oIs+bCUeb0vjAuYog11bHVMaD7xc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20, REQID:47f24d6b-312b-4c47-8224-d287e54f5ac0, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:291e20b, CLOUDID:77938344-f973-40c6-9c31-f078afa73356,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
 1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8146cc3cd2aa11f18dc8c9802ae25ab1-20261028
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1424234054; Wed, 28 Oct 2026 16:35:18 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 28 Oct 2026 16:35:16 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 28 Oct 2026 16:35:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jaZjd3EzSNf1LaNkroOAl0hpwIpOSp5EKBwamkJmXYwJlnE88/rCzFZJ1qpx7JjumtbwJRHbfLFn3gfTHR1ikRumfk0dEfeAd1GFOUquOzxEJjMH8O/FZ+GPyIVAnJVh+QhPEiLtSinLSPRiuXiwcFR75En6KaYBF8UIRkbP62wRINKqlRezCXG4hG6pblCijS3D5/5pTa4+HUE57Ab4AfF+gKRehZkkxi9DfAcX65iJzJjzc6ryxWFfHxvzfA4pCkq6t9qWL7bCIkwg/SPgA99w09/yM8yfV/87dK5JXI7HG6fmgjZ6ARPeEGZzGaAWrZvGJN5JEP156+vqnIfEkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHrlwZx6/rM5dfzKCYZyGiRhlLV3m9y9gRPOyreZ9ys=;
 b=LnZ4OUfq1F0lIC3fI0BUTcV/Udgmx2+cA7AnDFmBdRg0xXXzx/PqDNU2ClI+E4KN0z9CjY4DSxEePAM3XRvT89gw0mKAsnjo98kxmD6GoCSngoHCn4Pp0SxfLVNLB3q41+H9LDji61TZbC7Nx6xcbChsGduRAClywg3k2huOUz5yqcm3k0rF9ViftdxHiGKgRW1sc1yZ2rR8QfwIr8pupGzwRc8UBTu5uCjWtzCqN6dkqhDW9iJOLZIVpqK7JGxec8z5/xrRTQkEBKm2FTUqykXYMUVED0Y5Ko0lcV7E3inAkWvkJ8WY0ceq69C1i8DZTGbr4esFuO5H9ZRwdMs6PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHrlwZx6/rM5dfzKCYZyGiRhlLV3m9y9gRPOyreZ9ys=;
 b=sswDajS/KLjReE+z4HWGEFb3Sx1V3Q4we5vLiR5K7ynobvdJXdCWk9HsZ8TE6C/YFdduYHdL4L6XZeRBJyuOSdbg5BklHk+ytCzkOISip1e38wso2ehIwlDb8f7Jb2uXKdgX3FPBHhdwUb8HFE9zILQdi802DllO6am7jVxEBOc=
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com (2603:1096:d10:91::20)
 by SEZPR03MB10114.apcprd03.prod.outlook.com (2603:1096:101:337::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 08:35:13 +0000
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b]) by KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b%5]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 08:35:12 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "krzysztof.kozlowski@oss.qualcomm.com"
 <krzysztof.kozlowski@oss.qualcomm.com>, "tzimmermann@suse.de"
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
Subject: Re: [PATCH v2 13/46] dt-bindings: display: mediatek: Allow
 trigger-sources on relevant HW
Thread-Topic: [PATCH v2 13/46] dt-bindings: display: mediatek: Allow
 trigger-sources on relevant HW
Thread-Index: AQHdE4ZV1HWjpJxQaEeUx/Zo1nhNvLcTR3IA
Date: Wed, 28 Oct 2026 08:35:12 +0000
Message-ID: <d814fb7b48a96357f7cb1483facd8f9c103d632b.camel@mediatek.com>
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-14-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260714114414.184512-14-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR03MB9902:EE_|SEZPR03MB10114:EE_
x-ms-office365-filtering-correlation-id: b89fbef5-1ff7-4091-cd46-08df34ce6272
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|23010399003|42112799006|38070700021|261021123027099003|56012099006|11063799006|4143699003|10067099003|261021121427099003|18002099003|6133799003|22082099003;
x-microsoft-antispam-message-info: /2ovYaxuhC2YwwcN1BtlHUFjM/1QIe6h2FuCUxQ3m1bAXj8oULVH42yruUjwzk36Bu2lc0wLtIW9YpVonfozq23R07AAD+L6tfPfTKrRetoSAbmOgNvYDiup9lE6qzJWwhsy1uUoUj11r4KWd9gxF4r/G6UKCr11CFeU8htN4O3QFxnLfSU0+J/U8EdEeu8i2PxxBqUM0hOUOJj+MGqN5tRNCBHsCLnGOFv5/ERIyjLmnnuBSOn72UghujCwlikfGLGopZoVtq4dFcFjvbgroQIUQLgTeUHhsFJwIfK00H5IVL3Ty3Nk5SYInWwQp6JmTYjjlWgMdBnser6Wk8LTqIuUGHIegMgpfCGLxGMiOM6f0u1pOm4yRKiRD47B3DgAmHwlCUP3AO1XXHeDQ4ucMuk0hPav5t+2MzsZWB43lGfuly1MmhZ18OrWhXG9Wayfi9uImOtRjtm3byJ4etncNi1Wb59djTjs01g7SCd5ZNdyx8LAhAl9TTVPdhaC56FhmDJ4puEMeNDXECH4fuql7++jNcrM6fncxTPdmZ+ASSfXt2ebDp0YobHjM4v4Eeh/uQXcmHb51rzth6M/YAqttSLCnpPFUiF3jGHOyqaEF3HRW/PYuI0V6iDeLnPDiiO4MWweZDMhTbmj1QHJ7sJbe0fzLDfak1etQcwnNK21vJZV1qScyQysEHa+8arRlf6LFxcV8/dDk2n7vdYgNc8cMncuPe3k3O8CrsG0J0Vy1lc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUYPR03MB9902.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(42112799006)(38070700021)(261021123027099003)(56012099006)(11063799006)(4143699003)(10067099003)(261021121427099003)(18002099003)(6133799003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUhNdkxUcUwzRGIrcUdPOUpxNmw0dklLMWVIUVA2dzFlQ1FrZnBTZFRoNXoz?=
 =?utf-8?B?RFlXbThCS0l2R3FwNWtxUHpzZVBGT3ZhMU1SS0lXbTdoTVB0blRhdTlQLy9H?=
 =?utf-8?B?OUxoRDlUb29mWUFkSlNITElXVFpzcEZlaFhIc1BZUlZZZVFFNVU3dXAyK2kw?=
 =?utf-8?B?ZzZZRnp5QTBkd2QwVU9DczdEMGlvY3J0OXpyMGpDdXpXSkpkZEYrRlVsdml4?=
 =?utf-8?B?WXc0M1NoNUpLVzV6NVJhL3czSWRmbDBnbHgwMzVybzFzSjVJN05rNjFSNkhX?=
 =?utf-8?B?QXJsYmZ6YWtmSEY3THN6aDJNdkFMMGNSaFdhWjV0YWtncUJhY1VuekhGSUpQ?=
 =?utf-8?B?V3RkYXlpcXBuQXZCTU0xWC9tN3FsTGFYbUVaM2ZHWlVJcG81RXdDdWxWOFZ2?=
 =?utf-8?B?UFc2cVc3ZHJnK2tWTXdaME40TGlsN3N2NnFtM09DR0ZJRDl1OVdTd0F0TWhW?=
 =?utf-8?B?aEVLNmd3MFBhbjNMcmpCR1VVeCsvZGJQTVN0aTcyRjVIQ3Jwejc2YlExU3RI?=
 =?utf-8?B?eUVPZzhVRlhIQkQ0M2JrWGRtVmJ5TUswN2kvWkowUWVSUjhxWkFXSDcyMlZD?=
 =?utf-8?B?WHIyYllpZ0N5L3lnRURuSU1hcjg5bFJMUVczZXY2WkJ5Sk12WG8zd2NOTVRY?=
 =?utf-8?B?dnRaN2ZQRDhsZVhkZ25WclE3SXp1UXM4Tk5EWGl4YnROMUZma05xNm5RZ0p0?=
 =?utf-8?B?b0JWNDJsMnNxK1FEWjA0eDFKbUFybHNsdmZ1aEFiUXcxbDR0V3llWGFQK2pD?=
 =?utf-8?B?aUlqaTZDS3IvRXVZLy9sb2lDQlFBMkpGdGNIYW03YXZPMjVHdUpKR01Wb3N3?=
 =?utf-8?B?WHhRdklmeTVKWGF4d2t1Zy84MDJJOVFGaEw5WTc5TFVtVkpmTjV1OHFqN1Qr?=
 =?utf-8?B?YnVlTjMvRDNlUDdUcWNaUlhySHM3TzYzNjRqa21DbWVBQm1VZXI4UVBOckhP?=
 =?utf-8?B?MjlJRDB1bEVzcmV3SkxmS1FEb3FpT3FIYlhiNktlRTFsdmFKbzYwTE54ZFcr?=
 =?utf-8?B?UDJBbG9RZUVKNm1KQkNJaGlWZXMzdVNJalNhVnNoeWZWc3JacVNVLzZUWmVt?=
 =?utf-8?B?ZWNBRWEwRzE0aDBzRXpVMnFIRCs3Tmt3T0lJcE5CR1MzVlRtdmEvUEZJc21w?=
 =?utf-8?B?WnNOMkdXQ0Vta0hoM0d1aTAySHhEVWRPV0tqUmVrYkJGaUJENUE4dWhWQ2cz?=
 =?utf-8?B?U3hEL0xEcXhmQ09oNHRESWwwZ2R1c2hmcXpnNXRSaDVmL3NlQXEyblpyYTVF?=
 =?utf-8?B?VVZtWHIzZndIdUV0MW1aRTVyYnlvZmw5WmNzWVM5TSt4MkwybnR6bnBEY0xu?=
 =?utf-8?B?NDF6elpEWHl2K3JJaXFnaG9wMnNGUWRhZUFmR0VKS2JnQzZjNlBaTG5mcFh0?=
 =?utf-8?B?U05iQ25aaFdCN3NnN1dxUDRXRkdvNi9LTkZUQkFDWm5xMk5PK3BRU0ZBamhB?=
 =?utf-8?B?Yk5GUFVPeVdNUHBOUHJXa2oxdlFMUVJlOUFIbmk4WW1ucXBuREhUeTJHN2V3?=
 =?utf-8?B?eUtZbXVBd295WVBIeldrbWNSZnZsb3p5cUVta25ZaEdTaUJ6eEpOV1Q2Y1Rx?=
 =?utf-8?B?b3BDVkNQdXA3dGFHejhCd2xPc2xOelNSSCsxdzduVUowL3M3N01MVWZtUTZo?=
 =?utf-8?B?eWNTbVBDYVdEVS9WelNwajVWeURZS0ZkcXcxbWpYN0JacXl3c0NFU3E3ZzBM?=
 =?utf-8?B?RS9EOUUwSXZnWWlrQ1l4bUpwQWw4NCtMMDhVaFFIeFF6WDZTNFB2dGJzRTNN?=
 =?utf-8?B?STZTMkhyUGdhVG5idmNtSmtrOFc4QmhuL241b0FMdEVnSXVabDV6bjRPUEtU?=
 =?utf-8?B?M2IyTmoxM0liNTdpSDNrd2J4NEpiMU5ydFJwYlFLTGt1T3lZZy9aK0xYM0RY?=
 =?utf-8?B?ZDdKKzc3cVlUdVZnR3NCRVdVczNMZFM2aHFXYWlrL2p2S0dBUmtySC9jU2Ns?=
 =?utf-8?B?eGJVOXg0MlVFUHNMV01lamIzdXpObE5IWC9weVNtV2dxbnlDZGNGODRLRW5U?=
 =?utf-8?B?TU5RcnFLUHlGN053QitMSGdKbG1vejYyd1pDU1JsT042REVuYlFodGVncjk2?=
 =?utf-8?B?WWllcnhUM2dBaktQdTZNcHJUQkNXdkQxRmtxVzRINHpFTTd1VWt4a2Q0L1NH?=
 =?utf-8?B?QVZheTA5eXRaSGtyZTIzMWp4S1o4dTBUSmluRm9seWVWbHBVYkRaRzgvWHg1?=
 =?utf-8?B?MXhPUTc2SE9uSk9ucDBDZmEyRjNiNkFObys0YTVGZUVJZmRXd21WdEFLa01n?=
 =?utf-8?B?azYveVltRWdzVThLMjRGU2NoTmhXdXZrUUthdWYrYVFYNmNXUWdTMnEzeUUv?=
 =?utf-8?B?OFFmZnhQZWFQSmN0aHg5MFhYZWdEQUN1WHZKSFBUMWxoRHBsYTlrdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A77AF25D83E8E9458BA95C76E5CAC42D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: q7dqvbUQC8NajBC0vNz0BK1XjKNAN+Ehbzlutq8Sx4DL5XovCyZhTxF2+Y9dtULfHgjUzeuUFS23911NSVNswK709n1I18yGGJLHB1ZKbKQJYoO9pjKqS7SpkagzWUK47YFAhTTDH++upBvwFnDAPPMECKZ4SooCKhg/dDv1/YiXwZV9/juzU/CIc38nbtccNrXvh23U2bczeGkmNL/vxGT1BjfHd0y1ETWypmAVVgclFXR+5FDsS7bG+ds3ko98ky70Oz5ricBavbnUocZ1gIMIu6JCWY/RmkgeGIdpUdfxLNIbdbSDRDChxv2FLeV5MrWF9g4QNo3TDz/NLRjmBg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR03MB9902.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b89fbef5-1ff7-4091-cd46-08df34ce6272
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 08:35:12.9179 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hN66yNtA817hEC1ieN7KBkQ8kfpZeJS0GefvQpKpLEoE3jKoIVmpr2/7FJnP8B7/qg2PwBKfIZn7RAzklRwTGw==
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
ZWdubyB3cm90ZToNCj4gTW9zdCBvZiB0aGUgTWVkaWFUZWsgRGlzcGxheSBDb250cm9sbGVyIGhh
cmR3YXJlIHN1Yi1JUHMgbmVlZCBhDQo+IHNwZWNpZmljIChhbmQgcmVzZXJ2ZWQgdG8gdGhlbSkg
TXV0ZVggdHJpZ2dlci4NCj4gDQo+IFNpbmNlIG5vdyBNdXRlWCBpcyBhIHRyaWdnZXIgc291cmNl
LCBhbGxvdyBzcGVjaWZ5aW5nIHRyaWdnZXINCj4gc291cmNlcyBpbiBhbGwgb2YgdGhlIGRpc3Bs
YXkgSVBzIHRoYXQgc3VwcG9ydCBvbmUuDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVk
aWF0ZWsuY29tPg0KDQo+IA0KPiBSZXZpZXdlZC1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6
eXN6dG9mLmtvemxvd3NraUBvc3MucXVhbGNvbW0uY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbmdl
bG9HaW9hY2NoaW5vIERlbCBSZWdubyA8YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJv
cmEuY29tPg0KPiAtLS0NCg0K
