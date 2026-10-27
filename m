Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3B2606A31D
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 07:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=bAiMCxi4;
	dkim=pass (1024-bit key, unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=U92NmsXP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99D5E10E1F8;
	Tue, 27 Oct 2026 07:42:21 +0000 (UTC)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF35E10F2B8
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 07:42:09 +0000 (UTC)
X-UUID: e7df760ad1d911f18dc8c9802ae25ab1-20261027
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=2HT48ylWBJhy+CGwEa5UNCwp3lYDkY7Ry/TVbRPWuRo=; 
 b=bAiMCxi4tILwH9NHWmBaA2Laua/OSuhKs0DFkNjkUNcnSAOAMSgId2v3BCEieP3Iw9fZY360S+7YIYg/n+cCTNqSyjrJgqXWWjYuIn3oa6BS4ZS1ZkmzSEN3liKa4HkrO/yH38Tmq2UCUkVIYFf2ipxlkzquzwAct92GVVqktBw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20, REQID:348cb046-9c3f-4a14-b628-0a5d3ce74931, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:291e20b, CLOUDID:901e7eb9-4279-411e-a32e-f7638bbb2c8b,
 B
 ulkID:nil,BulkQuantity:0,SF:81|82|83|102|110|111|836|865|888|898,TC:-5,Con
 tent:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,C
 OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e7df760ad1d911f18dc8c9802ae25ab1-20261027
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1440261802; Tue, 27 Oct 2026 15:42:05 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 27 Oct 2026 15:42:04 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 27 Oct 2026 15:42:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EjjA5+3JUvIzuyjqNIyzbIYlULHFruDhr83MG8dL+BgmOyrKIgyzpa8HQE+Qwcr/2o4bq3BIS+tDLsRUGpolrv+nl8WnQBG4aFue+o+ew4PFqO80v2xu+NHUw6g2Jgx5agcXsKBBwd+CLQcfr0XAnrRmjdlm7Xd1fEeP0nNKL0iQLwOs0X9o+Eon+gq2/4r1en47UR03hq3UOTlmd/1M5kM3AJ3lfBS4sCPsAGdptEbfOJ3bWCejRd2ghBpkNpvZm7q3RTJVyr6N4p75nLHYSb7wyPjS3E7rA1xNygfuKuxPalAfjcNO1FZlSfGF2f7+nksCZobMABf5o7OaXmFOlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2HT48ylWBJhy+CGwEa5UNCwp3lYDkY7Ry/TVbRPWuRo=;
 b=afAtB+k8WBxtDV3quG9fyDVJ2KV9kot053vAyC3vscOJVZveW/zLZwgOJHzxfaHJZcchNe7L4tD37uSnr9O10/kyPr1zrRCh4mt2JTq0KiZ7B6cBwTbFJPfw7/p2eUZrVXeBkp6iFe+i2r3xhcA0h/lJaRvSOeb8g0nV3fREgKWeEJxDtAN8xCjw6v/YuDwbDt5l2oYs6R/ZpaoI382f0fS5zNQ0B4JB+197CibtpHteyDNIIsMA0+eMQOYlW9Z2thyLb4jjVNrTAbtY2l51AwzwPbXljPwA4AllhIGkR9fg7WCw47o9uAf4yf/o+pL139hliIUaa9ikKPa9IdW+KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HT48ylWBJhy+CGwEa5UNCwp3lYDkY7Ry/TVbRPWuRo=;
 b=U92NmsXPmF7r6LymtNNB4W13T+Pgrit9+Uq7xai9jcxDrh4uZ8pkRbGTmp4WJ0R4bdCkvm22CoZpwwuQsaAUtHkKckrMsAeqPOekeMLBiv7NbJShbiHT6dW9SJ15mZzt9eACdPTeUpWwGtlbIEUkzDy+H7/NQ/+JmU12rQDYlbo=
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com (2603:1096:d10:91::20)
 by SEZPR03MB7266.apcprd03.prod.outlook.com (2603:1096:101:72::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 07:42:00 +0000
Received: from KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b]) by KUYPR03MB9902.apcprd03.prod.outlook.com
 ([fe80::9598:2e59:20dd:960b%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 07:42:00 +0000
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
Subject: Re: [PATCH v2 07/46] drm/mediatek: Use hashtable for components
 discovery and registration
Thread-Topic: [PATCH v2 07/46] drm/mediatek: Use hashtable for components
 discovery and registration
Thread-Index: AQHdE4ZLJBmZGanwqUi83gYBq7RaTLcRpj+A
Date: Tue, 27 Oct 2026 07:42:00 +0000
Message-ID: <925c8a17bf65734deeb5b70c0dc580a4402c24b7.camel@mediatek.com>
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-8-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260714114414.184512-8-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUYPR03MB9902:EE_|SEZPR03MB7266:EE_
x-ms-office365-filtering-correlation-id: 77636b21-d777-4c1d-3136-08df33fdc914
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|42112799006|376014|7416014|1800799024|18002099003|22082099003|56012099006|11063799006|4143699003|10067099003|261021123027099003|38070700021;
x-microsoft-antispam-message-info: Bi/81IdUH11+iXpU+FAmCo93koM6qqKaw6tr3l+9o3mtUIONT0fjQPpfs88J52XvGmsCHwfzXeicwrr4wih09j0pcMT8zDuWBMbUb2E/9Li2kEHtCcWaauXgB97qD43p5EVWy5dLA1MJgwbT1B66Zozhi4OcqrDCxq1lNCw/3IfWU8OBpbaVYWfMWv9UQ2TcZlJhg3hG2MONnvHUaIsYIrjVws40s+okkywwhHOrvjBqgAgOr3axK9He5wmXdXCblDUvnipIIGI70u9utAC5cVO9pS0GcfrBaG3X4W7XjyqPER++gVmq/iORxqjulS5WSDCOaacQMm9wy44/LzsUzjEYHNK5VFfUW2GNvz0mES12C+glMzXRAMPm20coBtvHCs0Cj9y4M5iShQkXBkDx09ddy/BH4IGeu7sZdeiRoyWjIdlfvbUYcKt7RzJfQ0s1jFXDVKxea1Jp/7iULGT91vuHTOzAcP9bb+8cewtuI6JGmnL+1kT5TvYvP/+GWldWXSlvzq/+El3e2yFahzap8CpBFCyYQfmAkJJ1wwZE8wOoMnwOnjdrKWWqMDg5d9QXXW83nRaKOrMf7v8cfzXlXM2/rX/N+gWnYeUDWBcP+aA3nqVQQ1UhcxG2VBJaMbNOe2Uo6CIokbqlvQrl6YUSuuLX9zNVUf7RN2BvvEk6AuaDZ+8TKuZ9jwqpJZcAM5U+r8xQs4e/TXtvC/+SCs6EHoHsGo6ed2WvWQJ3a/QmLJU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KUYPR03MB9902.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(42112799006)(376014)(7416014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(10067099003)(261021123027099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnB1eHo0WU1mM0VMVTJuMjJ0NUJhcWJoOFF0alBkNk56SS9iQ1lqaGEzcXlD?=
 =?utf-8?B?RVpZeExWeFhsTTczbHNXLzM2L21xZ3IrUllGNVlIRzk4OGhKbmNMNDFTUm9O?=
 =?utf-8?B?V09Pci9RWmRhWHpReCs0Z1NEcjA2dDZweEd1ZVh1S21OcUw3ODRBQ2syNERr?=
 =?utf-8?B?TURsRkkxZnFFakFwa1NZM0lZcGFKcGN5cTg5SFZpNEpTSjlhemUxOGRvQ1NC?=
 =?utf-8?B?NWtiMEJtNnpHMll3UWxSRWJ0NWlDRW1LNXhRQjNqOVJjVGtMU0s2YnduUmtI?=
 =?utf-8?B?Qnh2ZGVBTitkRHVBeEZabHVXR2RueVZPaHpHNUJjaDIrQzhyM0tNa1RnMFQ0?=
 =?utf-8?B?a09VVWxESzh5VmM3TExsMDBlTkIzSmI3d25lWVJ1c09IVzdvZ2pjdmc3d3o5?=
 =?utf-8?B?OS93ejdSOXpGejQ1U2dEVXJscWJMWEhxVlZJclBpcnUrVXpMZDhhNHVMcG1a?=
 =?utf-8?B?c3RwSnVCUGN6bU1pRG1xQUpwQXdKeUdoTnFkT0FPU2x0cnNHYXJaTUdDUXJD?=
 =?utf-8?B?dU5BUlNkUDR1c1hHU0dIZ2FJNENXckZyYmx2RDR5eVFYV3VXc05yV3F6TzdP?=
 =?utf-8?B?MUZPRDR3MEpBZ1JINWwyQVg0b2ZPTkhpTi8xZ1J1VGFhZVE3RWFOREk2TjN3?=
 =?utf-8?B?bzExbHdEK2RwcCtOdXA0dVgzOUxxeCtJb0cyNUx2RHJScDVjb2t6MTByazd5?=
 =?utf-8?B?bkk3aUMwbUhVbkYwT0t3elNCQjh4VGRwYm81RFNOYnFwTlo3S2s3WStVNnlI?=
 =?utf-8?B?aEtabWgwNk9SNHVqVTVvTmVVdTZPcjJ0ZU5BV0VqMGdkNlFualdlZzdSYjVS?=
 =?utf-8?B?dEE5R21rY2lJUWZWdFlTSmFnMm9kSHF3YzJqK2FYcWdSSmlBaE9MV1lPSUxm?=
 =?utf-8?B?RFg3WFRMZGxNWUlSeTh2eVJZY1hhRGFZNFNiUm4rSllkTXVIUzhYRDVoaVNs?=
 =?utf-8?B?QzU3VUFoaW9NQTM1bGZOZnRLWUxmd0RZRGZNaTNUUE9DaVlFOWZnREhLNS95?=
 =?utf-8?B?VnpEbC81Smo0NXNyWlMyMUU4RzR3TU5OZTd1dTVsY21BR2lUYVV4T3c1MThz?=
 =?utf-8?B?aVhWNmhkb2ErUVFJQjNyaHB2VzZSdGNjc0liOGIwZHR4SmNkWTFrVmhwc0NT?=
 =?utf-8?B?cU1iZzVoWUJkUVBFa05BU3pPQVZkcWdFS3FwdjI2S3lZNitHSzF6S1ZHU2lL?=
 =?utf-8?B?Tmg1djJuWnBhdnZ1eENoNkxUcVhuUENWY3huY29zdzNERldXT2Z1ek9NVldu?=
 =?utf-8?B?WmlTRjNVV0lDSFBwcmIrV3JOWlZqMTRhZWlNK1hQRlRVRXd3SklDRS9FRXNZ?=
 =?utf-8?B?ZXo1UjdDUzNCOUtlaUdIdkl0eHBybmZpVmh5VzNBZDRKRzZ4WUZRaFRnVE1D?=
 =?utf-8?B?OS9WV0NENmpyc2tLaVoyQVFsZjV2eE1tMlk5dGUxSG5EM1J4c2Q0MFBHd3Fn?=
 =?utf-8?B?aXE0NXhoMzlaREtjcFlha0xZeUg1Q3B1SVF4eDBQZlJQWFd6YTlvTU9VRlVs?=
 =?utf-8?B?TjJ5bDJXT29rVlpWa0dWcmhlZUF6YVdHNkIyelYrY280U2pnL1docE9MTFVz?=
 =?utf-8?B?N1NVMVRadWYzakFENERnamtGWWlxMzNEanh4OTRQNHNSUDZLZmFBK3NDd2ND?=
 =?utf-8?B?TUd1Wk1pZmUrcnNvY3d2TGRuV2c1Ui9sWk9udFV5OHdDRG5WV1dCSEhKSWtv?=
 =?utf-8?B?ZXhJUUdaNko1NUg4emtsM3J2am1vbjN0Yk1FRTQ5MFQ2MEk1eEh0Lzlia253?=
 =?utf-8?B?ZkYydThTUnNHYkNFT2w1ekZxMm1QNW1kSUM4VmVkeTY0YVpOTHRQdTFzdWUw?=
 =?utf-8?B?SGFiR0JQeEdWOXVRa1FXUjc4RHVGbWg0ZStmQW9YVUYxYWtHNmg4NGtEVXJw?=
 =?utf-8?B?WXJXT0dxRU0xR2wwVHh2dW1ZT1ZwNWV2STN2VXhtRjZBRkh3OFVrajVOZy8r?=
 =?utf-8?B?T0ZBdERzWDlvRG15VkJ6Q2FaaWErYnp2cDdzUHkweklWSGtBcE80YmpHTUdB?=
 =?utf-8?B?NVQ0dWtFb2lkV3FJYThXdXg5eEZWdHpwbDk1ZFdpZENoRXpUVGE2YWNFd1Ns?=
 =?utf-8?B?SkZFcjJEamRDZ1BxeFpDRGJhdDVaNU5WUFp1cWdJVnJLbm5DY1FyMGF4aTgv?=
 =?utf-8?B?UmpMWUFkR2ZwaXFBM0pRdy9oVmdya3dzcHp1RzBrSkhoeG1neXo4YUR4a242?=
 =?utf-8?B?YTFQMHRwVXJNa2h5TVV0M05sS2N5OHYxWFNSWVJGOHNaUDJ0V0VpR3hzejVV?=
 =?utf-8?B?NFVLaWJmRnRYb2VFRFFiK1lOdGF2R2V2Q2M1UHBIRVR6VDhVeWNLY2l3Vi9z?=
 =?utf-8?B?VlVlTjJac1R0aEc3UFMvZVpNZUpsdk0xQ0lEWHpZU3NBbEh4YU5uZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A3D2CF353D0E942B265CBB1D19F4233@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JGeBBvWPJUdc9+9Wyo8jxIDszJDmZBuZXj6fELrdhjAurZRZgld0bOxSSMoLmJrRIJ98N3FeEF2yZ0b1xVxxIby+tS7/OHAIoB7rXwp3EQ2LErahyDBFLweYhGqucTPfRGQEQlIZz741imlVSnvKqstaCOiQFvCS9/LCsMXe9YUnw+eTompAVf4YIrGfmBo/z2X1DMUvyb/jswdk5zaHME8KWkNxwUC8GnA1Qx6/Mi3NxfTaeyCVyYrv641iy1qz9ulSV/Wyy4GRxR3le09/dtCalPLOLVRB7eweuw+ZpzoiIgu8WObkZf3K4yWF6BWG2V/Unf/HgecX3hK0jt8gdQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUYPR03MB9902.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77636b21-d777-4c1d-3136-08df33fdc914
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 07:42:00.2796 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JqnoqVVHDVsuytmj/cu26aczKcgaNoFXj+aettdlUn5xeRHCdYZGZdb2Xw6ltmNeMnlmoa39PBQxTljMQBDl2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7266
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
ZWdubyB3cm90ZToNCj4gQXMgYSBwcmVwYXJhdGlvbiBmb3IgcmVmYWN0b3JpbmcgdGhlIGNvbmNl
cHQgb2YgaGFyZHdhcmUgY29tcG9uZW50DQo+IGlkZW50aWZpY2F0aW9uLCBzZWFyY2gsIGFuZCBm
aW5hbCB1c2FnZSwgcmVtb3ZlIHRoZSBkZHBfY29tcCBhcnJheQ0KPiBvZiBjb21wb25lbnRzIGFu
ZCByZXBsYWNlIGl0IHdpdGggYSBoYXNodGFibGUsIGluZGV4ZWQgYnkgSUQuDQoNClJldmlld2Vk
LWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBB
bmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xs
YWJvcmEuY29tPg0KPiAtLS0NCg0K
