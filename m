Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E3B0C61DBE
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 02:59:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9648810E37B;
	Thu, 27 Aug 2026 02:59:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="dvvlFeYi";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="vcFhlP0+";
	dkim-atps=neutral
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25BEB10E37B
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 02:59:26 +0000 (UTC)
X-UUID: 4c87bc58a1c311f1b1788b6acf885367-20260827
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=a2gc+olp50O+NJTcwzzHVtlpqDlf/oj5hzu5ST2K+8c=; 
 b=dvvlFeYietHgJpc8iuf61zy70oZfWzVUFLvtsNal+u6W+ZU2slghgk3xeJO228iGDUNq6EuwYAI5de2UQJoeharpS0GzMGfp6BDx/t/NiXcGhJf+N/F7QVTvyCli0+8H7CaIAquxDv7rHZOSpuABa7Z8aBHG7zTFNnHGms+p9wE=;
X-CID-CACHE: Type:Local,Time:202608271059+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:6e853776-fbbb-44af-aef7-f1506547b5ff, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:7db8b62, CLOUDID:23d977fe-f4cb-4ad2-b022-e3ac6648bf25,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
 1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4c87bc58a1c311f1b1788b6acf885367-20260827
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 809791527; Thu, 27 Aug 2026 10:59:19 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 27 Aug 2026 10:59:18 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 27 Aug 2026 10:59:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XCkxpZiIdfeyf7waa6hzeKLjslCyRJ4juZ3bgUUILK+R6ExC6/TjLxSAjwEekv91dRi7+5U9J4KwdsYHtu783ZDzYsBfchNd4rlDcNwzrTfcmpmGt/KfbP4auemKZ8wNnZmgOxO8NoGdMJsTOXTqUI8qOLj6MEmOR+jN90WBDKolq0AQBxhhB155g5dJPnnfu+/0NGId7H2UBrmcYop6OAi9eNLscP5U8MH7pWukQUMxBtYs3u2r0DcP4RnMBK+skQxwsOCY1s6t5AA6eSV+aFMF8lUVUatDx7zCyt4tH+yAJ1ZSZJo5t9+tRxkFIkmZGVP1hcb5mOjusMCr4/qttA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2gc+olp50O+NJTcwzzHVtlpqDlf/oj5hzu5ST2K+8c=;
 b=aItUR2WNBR0Cykn+86yVuk4C+TsiklO9LfB/omLPI7d+J1dvoAbzKny1fX1JNFV39ahJ4mRMJF0DP4O2smbc8jo6HEN5uzCEnlsQgshSZ2sBbgMNwnIc4vejFmf8zHKw2TdOIy95SC7nvSBQWHaLXpjuggNBgdP1PEv+UJG+SybMWWUCQ0dfCZvC7dnk9G2JrqlRNCLl0t3bFpwfzoIyk71iJDqXZkU2SfVi0ggTRW2y8MVUiEqf55uMcc9oJhv5A7OzZ9gkuvK9n+w8JYV1J1Irbe0InnvrXbk4E4/Z1Z1Rpdh0+RiK4gMOcMnfZ6roBRi2+LDuE/60K2EtT+vgBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2gc+olp50O+NJTcwzzHVtlpqDlf/oj5hzu5ST2K+8c=;
 b=vcFhlP0+oE71zGW1XBS+HqTBT9N/VPEJ0a7b1lglZmsuoLFLkTdX6E50rOoypqKOmRU888ZuJ/QjKm8HooiuFzlTi9cHFVNNm6sgn2qPLJ8U++SeSmCMVom+9BnL5x2ug6BWZk+v0l+Qubf6tHtnWZ2sefQtZAXVi2S61tdOPoY=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB7267.apcprd03.prod.outlook.com (2603:1096:101:73::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 02:59:13 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 02:59:13 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "kernel@collabora.com" <kernel@collabora.com>, "robh@kernel.org"
 <robh@kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "mripard@kernel.org"
 <mripard@kernel.org>, =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?=
 <jitao.shi@mediatek.com>, "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "p.zabel@pengutronix.de"
 <p.zabel@pengutronix.de>, "airlied@gmail.com" <airlied@gmail.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
 <matthias.bgg@gmail.com>, =?utf-8?B?SnVzdGluIFllaCAo6JGJ6Iux6IyCKQ==?=
 <Justin.Yeh@mediatek.com>, =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?=
 <Jason-JH.Lin@mediatek.com>
Subject: Re: [PATCH v6 09/11] drm/mediatek: mtk_dsi: Enable PM Runtime on probe
Thread-Topic: [PATCH v6 09/11] drm/mediatek: mtk_dsi: Enable PM Runtime on
 probe
Thread-Index: AQHdFGH7IIc36pD6gkWjDozjDTbHZbaxd1CA
Date: Thu, 27 Aug 2026 02:59:13 +0000
Message-ID: <9ea69731c546bc3a2c1fc419f9265e0a4bad25d0.camel@mediatek.com>
References: <20260715135703.46540-1-angelogioacchino.delregno@collabora.com>
 <20260715135703.46540-10-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260715135703.46540-10-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB7267:EE_
x-ms-office365-filtering-correlation-id: eb23e0cc-449b-449a-2929-08df03e72ce5
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|42112799006|376014|7416014|23010399003|366016|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 1Knv1WOPqJNv3LlhTNyH0WipFRnCNzFoDUGLhQkE+TPn9afPzbZ23TA/x3VBO+mzG/ez3VOPTQ9B2tZ0rCGcRxNKukOT1AeEt6rkVwc2Ou4jQrRDIJYMEOznMCUygKkGq1WUGTqtEDqHPNbebPtkVqtebMzEC0kvQpKzbmvG/rPXNd/eqx/UJpUJTWBCYzlDQ7o/akSDIuRyGE8SDsr4a+ltN/ofI0QHw7RzUA3jxEHUL1c/127H/PvDIlX6pcFuuvx9L/s2zE9EdE2iSW3uqvaRVMBk7YC0+zPvhU/kJzoBgrQHapdimcBLFDZJmlZJLlZ7Zoc2QM17lzxrYpESl+31otZkBlg7FwI34Lp/ZiBvCzJrOeGMeIIH3Dku/CEzd4ibrj5ei6sXwTRkGZbt6sjE136Pj2j9y8EaQnn4aUbHxNeeSOgCxOQqIpTBP/aKiFkQ8OLnaOFZ0d2PN5AObSRBV5aQ6lZRMFXdfyigTtVv8nXUcCAXx4fYoGtq38ir6wQ8tltDcS53ZkfboGAbF1BzBmRgxAgJLyRt/9AlDip+Egf8MrCPPda3SPFzZKhy9o9S+DEt70bTL2sc/sTTQsU5iYNTBjIfg4DxCXItGr6YsuwoxJSDdTFDQsSLGqhHt5QV2uvJuTdA/aBHEMwnNtS1m0Ob7Rjd1aNB7BhO1GwpYnv9WQ59UHligf6RZiAzEW7wbkd3DjGFpxZ1bvIjEvlZ8IJ3K4/9ya2eTJNcOus=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(42112799006)(376014)(7416014)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1Z6ZHZZVDVhVmFwM0I0M2FXYW1lckh0eWUyenZmVzArVkNNUlRpT1VyMDFk?=
 =?utf-8?B?OTloUllFNzRINTRjcDQ0NzY0YWpaOUtlNk84Nm5leDQ2MlJGT1IyS0wwaEhM?=
 =?utf-8?B?UFBNQlZ0NWs4dnNGVTJzZ3NvcWU0Nk9NQzRieHhZdTRVNVFsV2xJSWFYYmZt?=
 =?utf-8?B?M2ZaZEFqS1Z4WGF2MGF4b1Y4YXBmaDlIY29tbDY1d2VIcWZvZ0p6OTdhQnBw?=
 =?utf-8?B?TUQvOWlidFNSU2p5Z3VHcUlaczB4Rm1zd3ZUSkR5S0k3NG5UdEF5Qy9IVUM3?=
 =?utf-8?B?b0FPM0plQWNOL094dlhnV3Zld3lLQTd5aTRUaGFRL0VJZ0hkdUh1Z0lucnBY?=
 =?utf-8?B?bWtTSGs5eUIybWJUcDRPLzBPT3VyVXdDTFIwdjRXTXF3UGxJT2FyL1VtbENq?=
 =?utf-8?B?Mk5KQUlXdFlLdkZkZHZXQU1FRHBEOU5HalVTZXZsbjlwVHFNaXIvQ2g3UXpl?=
 =?utf-8?B?dC94K3lMWFB6a2NRN2tOcDVEa29pYnBiK0N3STNtZmNRV3FJcGV0VHRzdW03?=
 =?utf-8?B?K0xxZE55R0NqMjhSTUFsMjlSRlpTM21TbHdLcEoxdWV4dGVtOVVnS0lYZ3hX?=
 =?utf-8?B?amY2dXdHUWFld3E2bXNYYkpKZTI3eVJ4clMxbU1SVnhZbGVsbG8wN2RHbFJL?=
 =?utf-8?B?YWJ6amFPc3ZYcytuOUw0aFArN3gxcWNuR0dkdUN0L0dVbkpuSHpjNlhzZ3BL?=
 =?utf-8?B?WUxuNVhOUW9ac2ttRHBFQzhjY0Y5QjNUM3YxNVlOWnVZQjc2TFVSVnBPaFhQ?=
 =?utf-8?B?VVc2bjJjK0w1ZDBqNXVHSjVRUS96NXVGOEZzazlDMFl0enRxZVVKSS9obkh3?=
 =?utf-8?B?dFdlc1VOdXU1SkZhdUZyWllNRm0rOHdXUVJKR2tiWTdVVnFvSExCZkpjSXND?=
 =?utf-8?B?eDA1Q21RNzRmU2l4bjBBVzFXMTJFYVF0ZFdENmRZQy9ZaDFvRk5KdGIxUGw2?=
 =?utf-8?B?UUFmVUZyeDV0R1d1d0QxWk81M0JJd1I1bjhJc1g2VTZFQmJ0V1dRK2FyeVI0?=
 =?utf-8?B?WjQ2QUY3QWVFQms2MVZuMFIyOU9mWjhJTFAyTmVZeWVqRlNYUHdpY3pGd1pl?=
 =?utf-8?B?Y0VFT09EblBZc0lYZUwxN3RoUWk2M2lsclljSkpjbkVXdy9PaVZhRHRxNHo3?=
 =?utf-8?B?LzFnSm1sUUNXK2pHMnpCa3JkdzZrRyt5S2FZQ013cng3OXQ2Nmw2MVdIeTdB?=
 =?utf-8?B?MTA1dmVzK21WQzZtM216SzMxYXA0ekR0djBqblJkZ3dJSWptcURTK1FJUi80?=
 =?utf-8?B?Sjh2UmRWY3hKbDlOeGRyUWRwSlZlb1FSMDVSRjZMaGt6amY0bm1tVnlrdFlV?=
 =?utf-8?B?V3BUYW1vY2lEWEh1b2lZeE9vYzhicFp5U1dEdVZmTzVtRG4wQktWLy9XS3RI?=
 =?utf-8?B?U1lBL2tGMWpJWkY3aU9NVkRyaUo2QTc0Z2RnTnBqazI4RlJCUUdmYXl6aHZQ?=
 =?utf-8?B?L2M4cVArRTl4cFl6WEFuck9tSVBPRlM0aVJDMklpYlphWTFRMTFUMDdjTnNx?=
 =?utf-8?B?R1A1SWl3RjNoSXp4Q3V6SjBrZ1BNeHFnS0JueHBESTFNWjc5Q2Y3VDR5YmN4?=
 =?utf-8?B?MEtIQWtVNis3bzM4MXY4R1lBSXd0LzJTdlA2KzU4Q1BYeVd1cGRBUGh4MUhO?=
 =?utf-8?B?emJtWG00NnhIclJZZ3AyQ2xJRk03R3Z4ZUp3ZFBRaHpPQWtiYTdvNUhOc28z?=
 =?utf-8?B?Skx3K09JZFg4dktIMDZSNXV6cjNhSmpKVy9HNXJFWFRpcjBRK3c0cjE2WkZ5?=
 =?utf-8?B?elFiYWNmY2kzU1hXY25hYlpsZERCM3BYUTJnRnU0V0FoakF6eUk5U1ZPQURp?=
 =?utf-8?B?S1IxK0lsTWFhc1RLZTRWTGJzZUVSSUN1SnJ0MlRXNERUR1pTdGtvd2Y5YWtF?=
 =?utf-8?B?OWFuZytKemlYcENlMXR0eVBEcEw1WE1PamZVYTd2R2FqZWZpRDFrbE5EK2Zp?=
 =?utf-8?B?MVVuUHczUFpMUi9Ta2JEbUxoa3czWFU0R3lGN21vZGVoeUtSd0lFaGQ2aFps?=
 =?utf-8?B?V2RTR0lkSXpYc2g2MVl3bFdGQmQxZThvWHNuajR4eVVqNlF3STRhT1dFRGxQ?=
 =?utf-8?B?MzFDbnBBUUN5VFVZdnVkV0tjMWw1T1FlcC9uYW0wT05yU2tPUkxwUHU3VUYy?=
 =?utf-8?B?VnE5ZmdkR0FITmNWWkpaditvdVJxTFhpOFlwK1cwSTFBNkNCUlFiZUpCeHJI?=
 =?utf-8?B?V0tJNXRoYUxKSVIzR0w3WmxWeTEyTUNhYzY2T1lBdHpCWDRnZHVZcDVyWTZq?=
 =?utf-8?B?M044VGdadGdvT3hUa1FndW0zSGFsVE8xcytaYzY2ZHdmd2dLQlBYS216cW9F?=
 =?utf-8?B?b2pkV1hUM0NBSTlDZm96dS9SZVNrV0hLMnpmRFN0SUQ4Wk95dlJGdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <072F428B7404FF4AAB6A6271CA8F076D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MYmQStT+75W5eXcPANd22xVvyW2slD/SrVd5HXSfS4L4tqZ6UaD/v3H4tbsz1PgujW9sGiD4F8uSB3OAc08rm+GMfYqBP8AnSQmWejDVdo1ThbvvkRbBOUvb4jGj1vgi+BCyDz0oCDTbP00NSGZ+Buzw5P3FkxY5LepzDOqa/XUe2iA7NRlO1oCpVZOgnU8IZlLZNRpUz/rWZW/Lj4jnqGNrRWHDhjMoNtXyKSNH7sGpckBCRkceHsFodng3mCJBmudRbYAjU/4UP5JNfh0JWUoSk3WmIPSmT34qQOPNy/BbhUhwUxdzPDnNeg7do7LoGZPmBmGd8Ik15sOF595s3A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb23e0cc-449b-449a-2929-08df03e72ce5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2026 02:59:13.5313 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vReGWCu3Kaw8M6rAEJopmPXOuxf7MEO/aXPGWt5ilfsP/WH0kKPT2J8E+r4RJxZlpbMl9kmiIeSk+wwqXgO/gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7267
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

T24gV2VkLCAyMDI2LTA3LTE1IGF0IDE1OjU3ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRW5hYmxlIFBNIFJ1bnRpbWUgYXQgdGhlIGVuZCBvZiBtdGtfZHNpX3By
b2JlKCkgc28gdGhhdCB0aGUNCj4gbWVkaWF0ZWstZHJtIG10a19kZHBfY29tcF9wb3dlcl9vbigp
IGZ1bmN0aW9uIGlzIGFibGUgdG8gZG8NCj4gcG1fcnVudGltZV9yZXN1bWVfYW5kX2dldCgpIGFu
ZCwgYW5hbG9nb3VzbHksIHRoZSBmdW5jdGlvbg0KPiBtdGtfZGRwX2NvbXBfcG93ZXJfb2ZmKCkg
dG8gcG1fcnVudGltZV9wdXQoKSBmb3IgdGhlIERTSQ0KPiBkZXZpY2UuDQo+IA0KPiBUaGlzIG1h
a2VzIHN1cmUgdGhhdCB0aGUgcG93ZXIgZG9tYWlucyBmb3IgdGhlIERTSSBJUCBhcmUNCj4gdHVy
bmVkIG9uIGFuZCBvZmYgd2hlbiBuZWNlc3NhcnkuDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2su
aHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG9HaW9hY2NoaW5v
IERlbCBSZWdubyA8YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiAt
LS0NCg==
