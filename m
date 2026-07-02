Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3851FC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 09:36:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92FF710F26B;
	Thu,  2 Jul 2026 09:36:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="LFeORvOy";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="vEFItDJ+";
	dkim-atps=neutral
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C71D10F26B
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 09:36:20 +0000 (UTC)
X-UUID: 7893227e75f911f1b1788b6acf885367-20260702
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=Rpesd51GG6vO18wb3K3ocm8zfScdYa5SMOzWDhpHmxw=; 
 b=LFeORvOyTnTJY+PeUNc0+kEePlSxgpoRJmWWfYrqs3QJ2B8DrDpMBNiJ0pf68h26UMolR1psPcy3kemvSdPT0l9jcHskncwsaccaHzsk9ih8+Fr1RlqmhxRKVit+ImeepwSpCXRtDtYw9r+Sa3LWlKYnDdXn2se3+J+V+QlEcpA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17, REQID:a251366f-d523-4864-b57c-a1806a9249c2, IP:0,
 U
 RL:0,TC:0,Content:1,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:1
X-CID-META: VersionHash:d497b38, CLOUDID:0969e881-6310-4e6b-a6b1-aca20d98ed8b,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:4|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
 1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7893227e75f911f1b1788b6acf885367-20260702
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 8665580; Thu, 02 Jul 2026 17:36:15 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 2 Jul 2026 17:36:15 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 2 Jul 2026 17:36:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ud5umy2HeXgbMGdz1JX2qX4kN+SW4nrGoaoSC8qwSVart/ETn/BADR3L8R5ZvMdNsWljbCGJnccmwuWxy63tusivPw4mEaIAv5G8Q5G2K8Qm/89FtiK+UWttePL1FQ3PzNMVplCyWJEwUXBQh5GXqnW04u6I1BxB8OrzbiFcR0dTD4JOI/ZharoascF8FZY52h2BFq/PSo4v+nWY472lfhI/yO7lEruO4Ow/LfJs1F6aWSItsB9l56bMVs60OLpRiYggiQ/VPEgq1POTPWM9o7kOq7Usfk+KsPur60AoghseqkOrYTNRteFvwVrf0EeKYYaVlT0gGju8oS+ojQwWoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rpesd51GG6vO18wb3K3ocm8zfScdYa5SMOzWDhpHmxw=;
 b=qE1GeXZwOfUN77T5yFhhiJCoVEcXYMjaIxSJZtp5mP46eLSczYYYc0T/iaF+qwadnEAj7CNQzWuWhmQK4bM++dEfcxROC6/fmrRMjYSKV8BbQKSVpqMS/K62oLetXPF1L3zZa+clc7jFNvk/IU31CRuQcSg/Th63iNaq6XlTkF4cWEHdmwbOTweyCyNEP5o4jIHZngJrEHGJ/lENuPU7ZoS4iB72EiwBVjL55r6Eao47EwBDECWUJDZnNVysNZBPV1Dd6g7Io7Mva9TRfexFWvtwzr5LijJO0QtAJuEVieFp5HewdvKW8oyScyWAAFZOLnpU2VVu4zTNzcqabUX3dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rpesd51GG6vO18wb3K3ocm8zfScdYa5SMOzWDhpHmxw=;
 b=vEFItDJ+0qZgVTzUFNEuJ++cQSkQSei0uZkaDKKrFO6OXgXky1kcz3i63/m7IkANlQ8IPhQRfVgjCoLiMTHzsJ3QzbRw861bUz0lbYI4C8xMg6CwMRJuAsPtmTtxWvNNiCx5Hbj/P6UWg16Z/GMfOcS6ybpERKk+DrnKIa2EeuQ=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by OSNPR03MB10493.apcprd03.prod.outlook.com (2603:1096:604:480::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 09:36:12 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 09:36:12 +0000
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
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 =?utf-8?B?UGF1bC1wbCBDaGVuICjpmbPmn4/pnJYp?= <Paul-pl.Chen@mediatek.com>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
 "airlied@gmail.com" <airlied@gmail.com>,
 =?utf-8?B?SnVzdGluIFllaCAo6JGJ6Iux6IyCKQ==?= <Justin.Yeh@mediatek.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
Subject: Re: [PATCH 02/42] drm/mediatek: Export OVL formats definitions and
 format conversion API
Thread-Topic: [PATCH 02/42] drm/mediatek: Export OVL formats definitions and
 format conversion API
Thread-Index: AQHdCVQz0xbT9MFPnk+tfMnuJcgw+LZZ+cSA
Date: Thu, 2 Jul 2026 09:36:11 +0000
Message-ID: <fb138206f2b2043d5207f341a1d97f53b024a2e7.camel@mediatek.com>
References: <20260701122057.19648-1-angelogioacchino.delregno@collabora.com>
 <20260701122057.19648-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260701122057.19648-3-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|OSNPR03MB10493:EE_
x-ms-office365-filtering-correlation-id: b48d4595-ee52-45a5-2eb1-08ded81d5a9f
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|42112799006|23010399003|366016|38070700021|18002099003|22082099003|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info: wgK3a2YLLinYJBZVjya/0PSIu1NTcNgtNargB0ka6NjsrqTseOj9d9DVVlfrPveplaLZnHZyjcVQVYcAKJ7Y+k/73HeAyRwBDLmR+kY0hrZn/bPu2AtT/RLxiTbqA+eCRXATnES9bT6l/TizvI97fIj5WaXfLzMPF3kqYrDhOxcGAk1+A++WmWP4AzqNl1M5Limc+tFI4JlwB6ZUzVOJzMu1+Ico4ChC0bfFAfypa1YjGzxxxmntniIhfDi3IPNhRokTxzcTCOBm99cU3PLUBK5BOyH7rqWjs65ZXGXsQ3TtMfC2uNRrjBuciXwFEiDIeeDG3r6B4jJW9EAfA79BJkpwCwmicwuJYyYxT1XrAnuYS/l+nF0wMgOY0shMCprhfez7gORWtxZbI6MAm72P40hv0rNdzAXuu36o0/rvsvJaqEpHTjDIGEY4/nRfEiLkxA2lVGCI/n6d/syFG+kwft6TF3mVoLHMNvzkhZ+vB5aJUjZDCFGrQSfZ62Sv7gOrCkCZLd+Yc/X6NJAsBNxaah4xcoXpJS2yJkK92w9TK8m0HhK9GSl9wC5XLXMXS5O3+iNlEKZc11oJovXHolnEYOKBESpbX9+bBBo3xKV7LOdvg9hlNm2nBujvMtt6QeJ3gWsYn1sqLiyecCPpCv1HH+RPrnum8nUuGCXrJ55+AyhyVqK/TEXTpfnmyermfsSl195vgPLvvwr9JF9+L4yIr0ryFxf2f+PyIe7a4mE9lEA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(42112799006)(23010399003)(366016)(38070700021)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3JPb0dVaWNib1hQK0RYWDFDUXdSajlkR25sWFBkVmpTY21FalZNcUZENFE4?=
 =?utf-8?B?VUllTHU5YUdSdmhlSTVqVkFLTGx5SE1RaDFKTkdxZjlsV2IwMFprSG5UL0Fv?=
 =?utf-8?B?WUJzd0xNMURjYXU5MHhoUGVVZWxXZVk4aUU0bHA5dk54dEFKdzdKS1p3RzZI?=
 =?utf-8?B?Y3RvN1dyaVQrb0dTWVk4VGY2SVJjOW95UDladUJwMTE2a1lCSy83TjloV2JR?=
 =?utf-8?B?SndkTnVQa0dZUHc2OTRwY29JaFB1QzFMSGRhcnM1RFNJTWs4VXNyREIxU2o4?=
 =?utf-8?B?bWpVbVdnZW1zbnh6WWtRMGJOanBxOFp0UGxHeVZhQ0crQis4OW1wSHVqTHUw?=
 =?utf-8?B?bjVyUGVaV21mTm5jdEVRSjBobjY4MGlJR3NtS0N4ak4ramRIUnR2aXAxNTB6?=
 =?utf-8?B?M1EyczIzNzdlSFpYRThiaFJpR3l0UDVvQTJucUVzQThkVXg4V3VIRmpWRE9B?=
 =?utf-8?B?cWdKZ2lsOERxcTJIMi9UdXRxK09ZY2tPK3d4alpDdDBrNy85NDhYdFpTTHNs?=
 =?utf-8?B?L0d6S0c1Sk1HOWdCRU5yb0hxZ1VEQkJYbEQ0MmNreDZWS0ZkVXJoTDNTaUNo?=
 =?utf-8?B?L0hSeEhyRlptYklnQlJkUk05dVk0ZzdJZTg5WkdzQkFxejZFanp6Ujh2NElI?=
 =?utf-8?B?RW11dk5NTmtrYW9PK2N5OVdxNEVxVjNOaUQrYkphWXZxeDdRTCsvUGNzbkZy?=
 =?utf-8?B?K0xzRm9IcldLZ2tJcUY4Yi9Za2sxOEtMSHRNRDFGekkxKy9JYmF3TzhoVFFk?=
 =?utf-8?B?MnI5ekhzUlIvZTRSZkpQUFBjWmE3MFVUbFpuZ0JkcVNDWEt1WnRiVU9xNWU4?=
 =?utf-8?B?OWlKSm1VeHhDc05wUkR5eUFHWkkyUHpCOTFraGwyRUpZdlhtTjRlTTFUc3pT?=
 =?utf-8?B?YnNmcW9TZkNZYlBJSnM2KzNZL3J2SGVRVnVlM1ArK3diOWhVaGtSZCszakE1?=
 =?utf-8?B?Vkk5TVZrTW1Zdm5FcUZsUW5ybXl5YlBpQWwzaTdXSTA5cXh2TVJEWU8rMWdJ?=
 =?utf-8?B?ZTN4bk4vYmtTUk1FMUNFN3dUdnA0R2ZmZWxOcUFZWFRDUmJ6bnpKT0poem5z?=
 =?utf-8?B?eUlQek1VVG5KZVQxWHZxVExpMEltbU9nZkVJakF6SktIWi83clA2WE5MQUo1?=
 =?utf-8?B?b1R6MmhNaWJGMFpOOG1YODBlbENzMkU0QktadnBXQVlzZlQySGlxMEk1Tys0?=
 =?utf-8?B?ZjhFb3ovbEU1dkJsRVBZMkZ1TGhLMko2WWREbHc4VnIzRjEyaDhRU01iUjRV?=
 =?utf-8?B?ZS9XaW9STUpNWXVjQllxUUhDMHVsaTdXdWxpUDdZcnE3VFBad296c3NGelo0?=
 =?utf-8?B?RXl0YWFNNzhCak5OWUtrdWM5OE1lRjRCd1YvaDNsZWZVWUU3ZjJPaGk3a2d2?=
 =?utf-8?B?L1UxdmNTVFN6V25aTm9tWVQ3OFdTM0IyWnU4YTdxUVZCclEzNmpBL2ZuYzFv?=
 =?utf-8?B?UWNpejVzU2JmckVvSXBySjlIbm1jczVOUUNYUFU0Uk1MT3QyNEVxWTRpOWMz?=
 =?utf-8?B?em1KYUZKZHFiOEVWdTFTck5nblE5UE82TWVKNkJHa3ZLS2xoTzZFZXhHOXFF?=
 =?utf-8?B?V1VkVGZFRWVrNUVDQU1lb0Nuem0wK2dpZ2s2U3p5VnZmcUZtQTZ6VUVKZE1h?=
 =?utf-8?B?c1U3VHMrSmdISTdwck4xb2dpVW1jK2RiM0N6bWdYMm4yNENPTjlpY2ErdEhI?=
 =?utf-8?B?MnFTdVRvcTEwbHoralI4NnJ1Zjg0ZFVXd09ZM1NQTkFZOXhjMFFJSzlIeG84?=
 =?utf-8?B?QlZaTjY5b0M5SWVqTUZVNTUzRlZVK3JzaTB0bTM1Q1MwUHlObGt1N3gxc1Zq?=
 =?utf-8?B?aFVQcEcvbUs4eGcxblpmaE92RlJjc0xVRlIwcHJkc1FZMXFnRVN6S1E5SVBv?=
 =?utf-8?B?N0o5SXZqVFArWUo4aEZZUlRrR2Z0R3I5TW1meEVRQS9NM09BeG4vQnFybTU3?=
 =?utf-8?B?TUdtZzl6TGNVWTdyQjZUN1RHbWYyTWxHL1NUcnVPaEUzYWFhVnZDWktobUQ1?=
 =?utf-8?B?VjJUM2FkMDR3dHpmUTVDbzhDZ0t1RmxKZ0F6cVp3cHhyR1hDVVdJYzdEWkFK?=
 =?utf-8?B?bkZFNk4rbmI2aWtoK3draXhSWkdJS0NXS05kTXdaelAva0NjdTJRRXpGV05W?=
 =?utf-8?B?WVYwZ1MvNXlZc3NGejU3UEZCUUp1M252NFhSMzNTNVRCZjdRSnJJS1BlSkJI?=
 =?utf-8?B?b1dQRmtVVGV6M29vZkFKQXBiRnhRcnZVbSt0bHZZRVVQQmZCSHpNaFFoT2xo?=
 =?utf-8?B?QUFRYVBJY0VJaStMZnR4YVUzVmlpR2ZZWUF3VC9WbU1iVGVUYTVmZmtYWDFv?=
 =?utf-8?B?M0I3b0VNeWVKR29iVG9JT0tQcncxNEIrVC9kbmNBcDh4M1E3eFg4Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <666021798C510247A44BF0A61B5C8D84@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PJEelLdZYW//z9UG/q7ZxGEPjcNrSx4dggOo3ua5iS1e9a5aErabzUrP++hXT4ruik/+4Uz+5WFGZw8olOrBC9FUPKqbHoShzgOgWhrDlCmm4G2Uefo1FjICptWhOd+SLV//YjiHRyyEBDZWeUVh4+kQm9S9T21AaAe3fecqsvYbvEpomPpqcVk0pJElameBs48b/pz0yXTYa1Y0s90lbBVXFZIUFf2Cuf2RU9wLXjbsix+0eoSuRLZQOTZQOahcyNibxMzekY1gE5AGed1sdkdFQOy5HlroieIEKscPIoRhCYeGlvRRSNHl8RhkwRLOnA0VNwAHMtlhbAu2iGRo/g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b48d4595-ee52-45a5-2eb1-08ded81d5a9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2026 09:36:11.8930 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZguVuiMNNwbB1JtEJhjL1DzkqbsKSiLNrHnpOmJL/QpaMq8iComyM3E/ydkG4wOtB9rPVvV0Ws56Twf7GsYPLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR03MB10493
X-MTK: N
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

T24gV2VkLCAyMDI2LTA3LTAxIGF0IDE0OjIwICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRnJvbTogTmFuY3kgTGluIDxuYW5jeS5saW5AbWVkaWF0ZWsuY29tPg0K
PiANCj4gSW4gdXBjb21pbmcgU29DcywgdGhlIE9WTCBjb21wb25lbnQgd2lsbCBiZSBkaXZpZGVk
IGludG8gbXVsdGlwbGUNCj4gc21hbGxlciBoYXJkd2FyZSB1bml0cyB0byBlbmhhbmNlIGZsZXhp
YmlsaXR5LiBUbyBmYWNpbGl0YXRlIHRoaXMNCj4gdHJhbnNpdGlvbiwgdGhlIE9WTCBmb3JtYXQg
ZGVmaW5pdGlvbnMgYW5kIGZvcm1hdCBjb252ZXJzaW9uIEFQSQ0KPiBzaG91bGQgYmUgZXhwb3J0
ZWQgZm9yIHJldXNlIGFjcm9zcyB0aGVzZSB1bml0cy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE5h
bmN5IExpbiA8bmFuY3kubGluQG1lZGlhdGVrLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogUGF1bC1w
bCBDaGVuIDxwYXVsLXBsLmNoZW5AbWVkaWF0ZWsuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbmdl
bG9HaW9hY2NoaW5vIERlbCBSZWdubyA8YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJv
cmEuY29tPg0KPiAtLS0NCg0KW3NuaXBdDQoNCj4gIA0KPiAtc3RhdGljIHVuc2lnbmVkIGludCBt
dGtfb3ZsX2ZtdF9jb252ZXJ0KHN0cnVjdCBtdGtfZGlzcF9vdmwgKm92bCwNCj4gLQkJCQkJc3Ry
dWN0IG10a19wbGFuZV9zdGF0ZSAqc3RhdGUpDQo+ICt1bnNpZ25lZCBpbnQgbXRrX292bF9mbXRf
Y29udmVydCh1bnNpZ25lZCBpbnQgZm10LCB1bnNpZ25lZCBpbnQgYmxlbmRfbW9kZSwNCj4gKwkJ
CQkgYm9vbCBmbXRfcmdiNTY1X2lzXzAsIGJvb2wgY29sb3JfY29udmVydCwNCj4gKwkJCQkgdTgg
Y2xyZm10X3NoaWZ0LCB1MzIgY2xyZm10X21hbiwgdTMyIGJ5dGVfc3dhcCwgdTMyIHJnYl9zd2Fw
KQ0KPiAgew0KPiAtCXVuc2lnbmVkIGludCBmbXQgPSBzdGF0ZS0+cGVuZGluZy5mb3JtYXQ7DQo+
IC0JdW5zaWduZWQgaW50IGJsZW5kX21vZGUgPSBEUk1fTU9ERV9CTEVORF9DT1ZFUkFHRTsNCj4g
LQ0KPiAtCS8qDQo+IC0JICogRm9yIHRoZSBwbGF0Zm9ybXMgd2hlcmUgT1ZMX0NPTl9DTFJGTVRf
TUFOIGlzIGRlZmluZWQgaW4gdGhlIGhhcmR3YXJlIGRhdGEgc2hlZXQNCj4gLQkgKiBhbmQgc3Vw
cG9ydHMgcHJlbXVsdGlwbGllZCBjb2xvciBmb3JtYXRzLCBzdWNoIGFzIE9WTF9DT05fQ0xSRk1U
X1BBUkdCODg4OC4NCj4gLQkgKg0KPiAtCSAqIENoZWNrIGJsZW5kX21vZGVzIGluIHRoZSBkcml2
ZXIgZGF0YSB0byBzZWUgaWYgcHJlbXVsdGlwbGllZCBtb2RlIGlzIHN1cHBvcnRlZC4NCj4gLQkg
KiBJZiBub3QsIHVzZSBjb3ZlcmFnZSBtb2RlIGluc3RlYWQgdG8gc2V0IGl0IHRvIHRoZSBzdXBw
b3J0ZWQgY29sb3IgZm9ybWF0cy4NCj4gLQkgKg0KPiAtCSAqIEN1cnJlbnQgRFJNIGFzc3VtcHRp
b24gaXMgdGhhdCBhbHBoYSBpcyBkZWZhdWx0IHByZW11bHRpcGxpZWQsIHNvIHRoZSBiaXRtYXNr
IG9mDQo+IC0JICogYmxlbmRfbW9kZXMgbXVzdCBpbmNsdWRlIEJJVChEUk1fTU9ERV9CTEVORF9Q
UkVNVUxUSSkuIE90aGVyd2lzZSwgbXRrX3BsYW5lX2luaXQoKQ0KPiAtCSAqIHdpbGwgZ2V0IGFu
IGVycm9yIHJldHVybiBmcm9tIGRybV9wbGFuZV9jcmVhdGVfYmxlbmRfbW9kZV9wcm9wZXJ0eSgp
IGFuZA0KPiAtCSAqIHN0YXRlLT5iYXNlLnBpeGVsX2JsZW5kX21vZGUgc2hvdWxkIG5vdCBiZSB1
c2VkLg0KPiAtCSAqLw0KPiAtCWlmIChvdmwtPmRhdGEtPmJsZW5kX21vZGVzICYgQklUKERSTV9N
T0RFX0JMRU5EX1BSRU1VTFRJKSkNCj4gLQkJYmxlbmRfbW9kZSA9IHN0YXRlLT5iYXNlLnBpeGVs
X2JsZW5kX21vZGU7DQo+ICsJdW5zaWduZWQgaW50IGNvbiA9IDA7DQo+ICsJYm9vbCBuZWVkX2J5
dGVfc3dhcCA9IGZhbHNlLCBuZWVkX3JnYl9zd2FwID0gZmFsc2U7DQo+ICANCj4gIAlzd2l0Y2gg
KGZtdCkgew0KPiAgCWRlZmF1bHQ6DQo+ICAJY2FzZSBEUk1fRk9STUFUX1JHQjU2NToNCj4gLQkJ
cmV0dXJuIE9WTF9DT05fQ0xSRk1UX1JHQjU2NShvdmwpOw0KPiArCQljb24gPSBmbXRfcmdiNTY1
X2lzXzAgPw0KPiArCQkJT1ZMX0NPTl9DTFJGTVRfUkdCNTY1KGNscmZtdF9zaGlmdCkgOiBPVkxf
Q09OX0NMUkZNVF9SR0I4ODgoY2xyZm10X3NoaWZ0KTsNCj4gKwlicmVhazsNCg0KT25lIG1vcmUg
aW5kZW50Lg0KDQo+ICAJY2FzZSBEUk1fRk9STUFUX0JHUjU2NToNCj4gLQkJcmV0dXJuIE9WTF9D
T05fQ0xSRk1UX1JHQjU2NShvdmwpIHwgT1ZMX0NPTl9CWVRFX1NXQVA7DQo+ICsJCWNvbiA9IGZt
dF9yZ2I1NjVfaXNfMCA/DQo+ICsJCQlPVkxfQ09OX0NMUkZNVF9SR0I1NjUoY2xyZm10X3NoaWZ0
KSA6IE9WTF9DT05fQ0xSRk1UX1JHQjg4OChjbHJmbXRfc2hpZnQpOw0KPiArCQluZWVkX2J5dGVf
c3dhcCA9IHRydWU7CS8qIFJHQjU2NSAtPiBCR1I1NjUgKi8NCj4gKwlicmVhazsNCj4gIAljYXNl
IERSTV9GT1JNQVRfUkdCODg4Og0KPiAtCQlyZXR1cm4gT1ZMX0NPTl9DTFJGTVRfUkdCODg4KG92
bCk7DQo+ICsJCWNvbiA9IGZtdF9yZ2I1NjVfaXNfMCA/DQo+ICsJCQlPVkxfQ09OX0NMUkZNVF9S
R0I4ODgoY2xyZm10X3NoaWZ0KSA6IE9WTF9DT05fQ0xSRk1UX1JHQjU2NShjbHJmbXRfc2hpZnQp
Ow0KPiArCWJyZWFrOw0KPiAgCWNhc2UgRFJNX0ZPUk1BVF9CR1I4ODg6DQo+IC0JCXJldHVybiBP
VkxfQ09OX0NMUkZNVF9SR0I4ODgob3ZsKSB8IE9WTF9DT05fQllURV9TV0FQOw0KPiArCQljb24g
PSBmbXRfcmdiNTY1X2lzXzAgPw0KPiArCQkJT1ZMX0NPTl9DTFJGTVRfUkdCODg4KGNscmZtdF9z
aGlmdCkgOiBPVkxfQ09OX0NMUkZNVF9SR0I1NjUoY2xyZm10X3NoaWZ0KTsNCj4gKwkJbmVlZF9i
eXRlX3N3YXAgPSB0cnVlOwkvKiBSR0I4ODggLT4gQkdSODg4ICovDQo+ICsJYnJlYWs7DQo+ICAJ
Y2FzZSBEUk1fRk9STUFUX1JHQlg4ODg4Og0KPiAgCWNhc2UgRFJNX0ZPUk1BVF9SR0JBODg4ODoN
Cj4gIAljYXNlIERSTV9GT1JNQVRfUkdCWDEwMTAxMDI6DQo+ICAJY2FzZSBEUk1fRk9STUFUX1JH
QkExMDEwMTAyOg0KPiAtCQlyZXR1cm4gYmxlbmRfbW9kZSA9PSBEUk1fTU9ERV9CTEVORF9DT1ZF
UkFHRSA/DQo+IC0JCSAgICAgICBPVkxfQ09OX0NMUkZNVF9SR0JBODg4OCA6DQo+IC0JCSAgICAg
ICBPVkxfQ09OX0NMUkZNVF9QUkdCQTg4ODg7DQo+ICsJCWlmIChibGVuZF9tb2RlID09IERSTV9N
T0RFX0JMRU5EX0NPVkVSQUdFKSB7DQo+ICsJCQljb24gPSBPVkxfQ09OX0NMUkZNVF9SR0JBODg4
OChjbHJmbXRfc2hpZnQpOw0KPiArCQl9IGVsc2Ugew0KPiArCQkJY29uID0gT1ZMX0NPTl9DTFJG
TVRfUEFSR0I4ODg4KGNscmZtdF9zaGlmdCwgY2xyZm10X21hbik7DQo+ICsJCQluZWVkX2J5dGVf
c3dhcCA9IHRydWU7CS8qIFBBUkdCODg4OCAtPiBQQkdSQTg4ODggKi8NCj4gKwkJCW5lZWRfcmdi
X3N3YXAgPSB0cnVlOwkvKiBQQkdSQTg4ODggLT4gUFJHQkE4ODg4ICovDQo+ICsJCX0NCj4gKwli
cmVhazsNCj4gIAljYXNlIERSTV9GT1JNQVRfQkdSWDg4ODg6DQo+ICAJY2FzZSBEUk1fRk9STUFU
X0JHUkE4ODg4Og0KPiAgCWNhc2UgRFJNX0ZPUk1BVF9CR1JYMTAxMDEwMjoNCj4gIAljYXNlIERS
TV9GT1JNQVRfQkdSQTEwMTAxMDI6DQo+IC0JCXJldHVybiBibGVuZF9tb2RlID09IERSTV9NT0RF
X0JMRU5EX0NPVkVSQUdFID8NCj4gLQkJICAgICAgIE9WTF9DT05fQ0xSRk1UX0JHUkE4ODg4IDoN
Cj4gLQkJICAgICAgIE9WTF9DT05fQ0xSRk1UX1BCR1JBODg4ODsNCj4gKwkJaWYgKGJsZW5kX21v
ZGUgPT0gRFJNX01PREVfQkxFTkRfQ09WRVJBR0UpIHsNCj4gKwkJCWNvbiA9IE9WTF9DT05fQ0xS
Rk1UX1JHQkE4ODg4KGNscmZtdF9zaGlmdCk7DQo+ICsJCQluZWVkX2J5dGVfc3dhcCA9IHRydWU7
CS8qIFJHQjg4ODggLT4gQkdSODg4OCAqLw0KDQovKiBSR0JBODg4OCAtPiBCR1JBODg4OCAqLw0K
DQpSZWdhcmRzLA0KQ0sNCg0KPiArCQl9IGVsc2Ugew0KPiArCQkJY29uID0gT1ZMX0NPTl9DTFJG
TVRfUEFSR0I4ODg4KGNscmZtdF9zaGlmdCwgY2xyZm10X21hbik7DQo+ICsJCQluZWVkX2J5dGVf
c3dhcCA9IHRydWU7CS8qIFBBUkdCODg4OCAtPiBQQkdSQTg4ODggKi8NCj4gKwkJfQ0KPiArCWJy
ZWFrOw0KPiAgCWNhc2UgRFJNX0ZPUk1BVF9YUkdCODg4ODoNCj4gIAljYXNlIERSTV9GT1JNQVRf
QVJHQjg4ODg6DQo+ICAJY2FzZSBEUk1fRk9STUFUX1hSR0IyMTAxMDEwOg0KPiAgCWNhc2UgRFJN
X0ZPUk1BVF9BUkdCMjEwMTAxMDoNCj4gLQkJcmV0dXJuIGJsZW5kX21vZGUgPT0gRFJNX01PREVf
QkxFTkRfQ09WRVJBR0UgPw0KPiAtCQkgICAgICAgT1ZMX0NPTl9DTFJGTVRfQVJHQjg4ODggOg0K
PiAtCQkgICAgICAgT1ZMX0NPTl9DTFJGTVRfUEFSR0I4ODg4Ow0KPiArCQlpZiAoYmxlbmRfbW9k
ZSA9PSBEUk1fTU9ERV9CTEVORF9DT1ZFUkFHRSkNCj4gKwkJCWNvbiA9IE9WTF9DT05fQ0xSRk1U
X0FSR0I4ODg4KGNscmZtdF9zaGlmdCk7DQo+ICsJCWVsc2UNCj4gKwkJCWNvbiA9IE9WTF9DT05f
Q0xSRk1UX1BBUkdCODg4OChjbHJmbXRfc2hpZnQsIGNscmZtdF9tYW4pOw0KPiArCWJyZWFrOw0K
PiAgCWNhc2UgRFJNX0ZPUk1BVF9YQkdSODg4ODoNCj4gIAljYXNlIERSTV9GT1JNQVRfQUJHUjg4
ODg6DQo+ICAJY2FzZSBEUk1fRk9STUFUX1hCR1IyMTAxMDEwOg0KPiAgCWNhc2UgRFJNX0ZPUk1B
VF9BQkdSMjEwMTAxMDoNCj4gLQkJcmV0dXJuIGJsZW5kX21vZGUgPT0gRFJNX01PREVfQkxFTkRf
Q09WRVJBR0UgPw0KPiAtCQkgICAgICAgT1ZMX0NPTl9DTFJGTVRfQUJHUjg4ODggOg0KPiAtCQkg
ICAgICAgT1ZMX0NPTl9DTFJGTVRfUEFCR1I4ODg4Ow0KPiArCQlpZiAoYmxlbmRfbW9kZSA9PSBE
Uk1fTU9ERV9CTEVORF9DT1ZFUkFHRSkgew0KPiArCQkJY29uID0gT1ZMX0NPTl9DTFJGTVRfQVJH
Qjg4ODgoY2xyZm10X3NoaWZ0KTsNCj4gKwkJCW5lZWRfcmdiX3N3YXAgPSB0cnVlOwkvKiBBUkdC
ODg4OCAtPiBBQkdSODg4OCAqLw0KPiArCQl9IGVsc2Ugew0KPiArCQkJY29uID0gT1ZMX0NPTl9D
TFJGTVRfUEFSR0I4ODg4KGNscmZtdF9zaGlmdCwgY2xyZm10X21hbik7DQo+ICsJCQluZWVkX3Jn
Yl9zd2FwID0gdHJ1ZTsJLyogUEFSR0I4ODg4IC0+IFBBQkdSODg4OCAqLw0KPiArCQl9DQo+ICsJ
YnJlYWs7DQo+ICAJY2FzZSBEUk1fRk9STUFUX1VZVlk6DQo+IC0JCXJldHVybiBPVkxfQ09OX0NM
UkZNVF9VWVZZIHwgT1ZMX0NPTl9NVFhfWVVWX1RPX1JHQjsNCj4gKwkJY29uID0gT1ZMX0NPTl9D
TFJGTVRfVVlWWShjbHJmbXRfc2hpZnQpOw0KPiArCQlpZiAoY29sb3JfY29udmVydCkNCj4gKwkJ
CWNvbiB8PSBPVkxfQ09OX01UWF9ZVVZfVE9fUkdCOw0KPiArCWJyZWFrOw0KPiAgCWNhc2UgRFJN
X0ZPUk1BVF9ZVVlWOg0KPiAtCQlyZXR1cm4gT1ZMX0NPTl9DTFJGTVRfWVVZViB8IE9WTF9DT05f
TVRYX1lVVl9UT19SR0I7DQo+ICsJCWNvbiA9IE9WTF9DT05fQ0xSRk1UX1lVWVYoY2xyZm10X3No
aWZ0KTsNCj4gKwkJaWYgKGNvbG9yX2NvbnZlcnQpDQo+ICsJCQljb24gfD0gT1ZMX0NPTl9NVFhf
WVVWX1RPX1JHQjsNCj4gKwlicmVhazsNCj4gIAl9DQo+ICsNCj4gKwlpZiAobmVlZF9ieXRlX3N3
YXApDQo+ICsJCWNvbiB8PSBieXRlX3N3YXA7DQo+ICsNCj4gKwlpZiAobmVlZF9yZ2Jfc3dhcCkN
Cj4gKwkJY29uIHw9IHJnYl9zd2FwOw0KPiArDQo+ICsJcmV0dXJuIGNvbjsNCj4gIH0NCj4gIA0K
DQo=
