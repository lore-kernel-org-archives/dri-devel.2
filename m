Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC7ABC61DC6
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 08:33:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 177AF10F2CD;
	Fri, 28 Aug 2026 08:33:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="eyw+T0Sb";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="t6cxzDeO";
	dkim-atps=neutral
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8526D10F2CD
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 08:33:25 +0000 (UTC)
X-UUID: 1f4bf4eaa2bb11f1b1788b6acf885367-20260828
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=z7+en2aBsjfAx7kAWr8lsI3VQJA48TguJqnPVr4j420=; 
 b=eyw+T0SbSHzNgD87dBIeVhzf5jdDRotpIDJO51sQ2V+psnbPhc+8Q/Dm1MUHH01aXLYLPM7J62AW1+MkNs4zXdNel4J11eG5dOeur1lI8w2Hi1ZN2DJZX7pCdGJRnyLQ58Jni9krQ05e0QtYafTJ8r9A1PodypmwVjXh2w1AfVE=;
X-CID-CACHE: Type:Local,Time:202608281633+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:1744ebec-2c72-4f4d-9c28-7d9907ce3531, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:7db8b62, CLOUDID:59e9c796-b5d1-4a50-aaf0-17be89180372,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
 1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1f4bf4eaa2bb11f1b1788b6acf885367-20260828
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1971763066; Fri, 28 Aug 2026 16:33:19 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 28 Aug 2026 16:33:18 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 28 Aug 2026 16:33:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aWEVqDDZZ7knl3MbKut8EPol+lThgboDtVLw9DRNpa9A3MNUsC3XqeX/TQLXNLNCV1FopfsgjhT183rDT3XYiYAB8yUMEQxkQoEQD4jKugXkT/E/dhbiwfrMvTVy/0o23n2/raUlaFjXBm1Zq22Aw0Laj7KdyGIeHHgNG99JC0XvD+S/Q1+tpQmx15yDuXUx5ccWbyYW9UgM5vX/CTgNQQJvBps+dE8IIQWCs6gcwMuHU0XctiymuBsTQQIzt7Q4aeFfHlgmP8kpdpwWn7RNqyzRp6NrPcXOLrjzMflgxL084qT+hOnTEzVcYQ7pW6NqLBue1x8UgWKdYgEKP0I2/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7+en2aBsjfAx7kAWr8lsI3VQJA48TguJqnPVr4j420=;
 b=DS38juHUXkRYtEcnXFX5eN66bZqyrVSTQj35S6UeE18F+5yrUB6udmQAX5oCKoibCvugvdcZewKv3SrfNLu7xzS5YNxtUJKud7QUV8hyB6gSMLZMx/qnK7zJTHOP55fs6T57tlnfR3ZQaqg9c0Y38wB5UcKL53vbPuSdREUFbGt/2ZGcDkbUJ3jqDRlgnQFbK0AFCl15XBHf25TrgOhJc5X3SPDwcYPtL573bovZ6tHqyytc5icG15neBfd0FjfzXY7DlhdT1b6Im3f/X7TZkd77oivoYm58Aft0weilYdly/tnlrnucBt9BPrSNDaNlKFFGlMuOJOKD9Ha3noFMuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7+en2aBsjfAx7kAWr8lsI3VQJA48TguJqnPVr4j420=;
 b=t6cxzDeOwdr/h/7I//uZ5J52FnvsaWwlNG+C4I9+R1ZjPlCTjptw3QDGMPXZYWSglarxul+rcitzEMGgb6pH3JyYg1Sy2j17q/zwJzVHNmQBddhc5AnVg537cE5g7IBS5nPY6rZjmWfW+0svVRTA1CYplUCVgELJ87aRM8ZbVmw=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB8317.apcprd03.prod.outlook.com (2603:1096:820:10b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 08:33:14 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 08:33:14 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "kernel@collabora.com" <kernel@collabora.com>, "robh@kernel.org"
 <robh@kernel.org>, Alexandre Mergnat <amergnat@baylibre.com>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>, "dmitry.osipenko@collabora.com"
 <dmitry.osipenko@collabora.com>, =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?=
 <jitao.shi@mediatek.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "granquet@baylibre.com"
 <granquet@baylibre.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "airlied@gmail.com" <airlied@gmail.com>,
 =?utf-8?B?SnVzdGluIFllaCAo6JGJ6Iux6IyCKQ==?= <Justin.Yeh@mediatek.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= <Rex-BC.Chen@mediatek.com>
Subject: Re: [PATCH v4 12/12] drm/mediatek: mtk_dp: Clarify XTAL freq and
 Debounce registers
Thread-Topic: [PATCH v4 12/12] drm/mediatek: mtk_dp: Clarify XTAL freq and
 Debounce registers
Thread-Index: AQHdD5au0B8WRlnL1E29sBRuGfF8f7azcIwA
Date: Fri, 28 Aug 2026 08:33:13 +0000
Message-ID: <3207851aa09a444d3f57648b2fc3d547730088ea.camel@mediatek.com>
References: <20260709113148.49090-1-angelogioacchino.delregno@collabora.com>
 <20260709113148.49090-13-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260709113148.49090-13-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB8317:EE_
x-ms-office365-filtering-correlation-id: b6f32027-572d-43aa-3f61-08df04df005e
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|42112799006|18002099003|22082099003|56012099006|11063799006|38070700021|4143699003|10067099003;
x-microsoft-antispam-message-info: CiU5xJE1Et83kx+Swg8tcMjQ8KhSN9BoJY58XzjVkHwFCJceE0VVyQhl3ttCecOnwv6Luca60fELSr7CMFWfmiYg77Bxjkvqy+Wp1tAG188FfeODTCYyVzogSw8ierJpFCHPKtn8b5qvrP4ds1UCL07KOrz8y/DOyzhaq3OvH/vi/hUfz6LmENiyZ086bB7ibMsDWoFoEW4aVfg0mil91osigsIVN+/XkumBmswVwI/jIIxSjX9jIBJ5TMTW9HbYMH8ByQxJ57bvOhL6rPcR3P2LvRTDLnH6Lq/zKOhpF31ZduTS3M06Mgsdi7QAz1lR/UP/zJvuKAla9cz3j2uY7a+sePWA53l9DjHrH99PFeKaqSLvMaZ8+MgATpZ/URUXxZDp0d/nEIKUrxWgQvZIkYR+S73pRQ5upaAOmBi3oMk938qVJyb5Ihe7H73xW7V+HZfPHm7diINbgZ3bEjghN2xbIyzDTGAiY10MPBkpr0knQ9zE4QnhQ3EeB+wYojK2SdpZikDy0OOTjxR46a4glx0ZQfuNBCM1mLsPsBsikIUUrZYP2zYT1VT+sWDRlM2p4SWfGVNCrJIycK/3ylTiG6KReD65dQnDHlUlC0YFvAkST6T16JD0ea7jNAht/gtd+NVtqeTzkCPEg3DmzftdcJRL+jFVUso8iaaviuiYaLpvjUubyRGACFqp/CV3CVq2jLq/s/Aoz5Fhl9fVOAeJiQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(42112799006)(18002099003)(22082099003)(56012099006)(11063799006)(38070700021)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cThXTitQREhzc25mT2FhTGkvcjVEZHAzNGRkZXRSMEdUVkIzN0YzRVhNc0lU?=
 =?utf-8?B?ZlFHdHk4UFU3MUIxM2ZoU25IOWtRcjV5TUdQRm9uQ3ZXak1Qd1crZTJEbVh2?=
 =?utf-8?B?VjFid1ZtWmVUSk1RT3V2aytKMGhVUGxYSldaVWs1QWtLYXNkaTdraXBQU2p0?=
 =?utf-8?B?RWhzVDJHckJJblBZemhHSjF2emdlM1VnQW02dHdmc2x5T09DVVk3WVc3VnFM?=
 =?utf-8?B?RVZNdGwvWXZJYit1cVRnT0pNaVZxajEwcmdzS2hNWUQwTnhvQzRlVWN4QnVa?=
 =?utf-8?B?OGs5VCtXbndlaTh5VkpRQWQ5K3V0WkIwcGE5T3NTZEs0WW5ZcjdEMlJqK2Rk?=
 =?utf-8?B?OUVGR0xSbUNFNjczNkI5OTJQdS9pMENFWGF4OWF1NXRUbHltaEtqNGZpNDZv?=
 =?utf-8?B?MjZ0aGFIQzhsUDMvUmFTeTFpNFFmNzJ0djJnYzV0YnFNOVFaZ3h5MmR0aWt0?=
 =?utf-8?B?UmlUS1cyWWo2Z2pZNW5jeWtGbCt0ZEZxNm9xTCt4YTkvNWxreFlHTVJFc0lx?=
 =?utf-8?B?b29SOWQrWTRVQ3ArbFZNa2Z4emVrZkVDNzQ5b0g4bVJpaUxXQW9DaHB4allt?=
 =?utf-8?B?a1dsbGJvOVBRbFpQQkdYSnJrSUF3MGZoNlN5cTM4VG5lWStnd0orQkVQdTY5?=
 =?utf-8?B?SStDMzR5MndlblVGZFFabXlVazFldURtKzZiVnEyVWNZam02Q0JtYXQ1QlBa?=
 =?utf-8?B?ZmtUUG9GdWlGVTN0WGtWTXRTRjRyZFY1d21CZ3R6VjVDRFFZcHU0dXZvWjFW?=
 =?utf-8?B?cWl2eVFpbVpRNG9OUEZVRW93TllBU09hOUMxaHFWNTM2ZmVYOU9WbEF3eGZo?=
 =?utf-8?B?cW45ZVFNbFdoTU51dUxHdjFXVlNZNWd1N2RpL3BVSTRjWmkzcmpUejViWGhV?=
 =?utf-8?B?Vk02ZjBqQVJtaUdDd253NE4vc2tPVWNsOGxyMk9ZR1ZWYnhObkY2QWVTWFdk?=
 =?utf-8?B?RnBveXlnNjFIRk5hUlRURWRVS1hNbGdteW1yQ3YwZXpPNldHSXRJaDBEQ1BI?=
 =?utf-8?B?QTg1YVdHdmZUSDdWSk9MdmJkd3VDNTh1NnZTVktBZGZjK1B6TkhXWXNrR3ZU?=
 =?utf-8?B?c3d3TmloYU9HS1lqS1pSM3BON1JnaVl1N0FLak9LWTBFcnNQT2dGb1B3MlRH?=
 =?utf-8?B?ME85c1lKbzQ2S05aaHJSNDlVY1M1VDhEbDlHN3Y0WTNaZ1VsbDFBRzBmTlhC?=
 =?utf-8?B?SjVaeTd1SVFBMXZWUVhWM2szK1VTTnE3eVpDL1p1WWdiZzAxUEp1cW9XN25E?=
 =?utf-8?B?VUs1Y0xTdEI5cnA3OVNKc3VFSnlVV25jVHpWK3FmZkRiZ2FwWmVUT3h5V29j?=
 =?utf-8?B?MW1wcUthK1ZVUHpXY3Z0Q1NMalNiWExDUkFGOGdVMnA5S1NqVkd4T1ozSjQz?=
 =?utf-8?B?VlhDN3huMVdWRnZqUDc1NDdUaXVVem9TWXN0MUg4dTVrWkZKK2xHOU5jdVd4?=
 =?utf-8?B?bzlMV3Q0Y3duWEZMWVAyN1NlTnhaQVpjalpVL3dJR2cyb2ZoNWNZc2hPeHVM?=
 =?utf-8?B?dXc3Q0w5V0FzS2NxQWtwYStBRGNhZVFYbTAxZXM3TmdxdGhVd3EwZEl2a0dq?=
 =?utf-8?B?b3pXVTlFWE0zMzUyTkRRL09pWmtVVVgzOTBaeE0vMXkvdFZWUFltQTBDaUZq?=
 =?utf-8?B?TWZRZ2ZVazNlS0wvcklJNlY0QmozdXV3UzhzYTU1ajZHNkNjUENBUEtBWFVN?=
 =?utf-8?B?RldJVFNlS25NeUlWSjR3M3lTUTV1dUNhQ25YSlF6ZFF6enFudkFTa0RBd2d6?=
 =?utf-8?B?Y3U1Q09HL2Jxb2Jab05FNGZaUXpHU0p3cmF1WC9DYUNldFFGenFXSFhHcGZM?=
 =?utf-8?B?S1BtUnF6VDd2a3B5UEN6SndQQ0VCWWJjUGN1REVRZkszSGFlL0hJVVVLWlMx?=
 =?utf-8?B?eWJ0WDFaZ0hTSHozUnRqTVZXaDVTNUt3TmJIbEFLZzBsMHgzd1FaT0l6QlBy?=
 =?utf-8?B?Z3EvTWxkcVlCL21XdGNQelJQRTZnc3hZTGFEYUwxdTFCZzNFL2NqMGUzL053?=
 =?utf-8?B?TUxkbmIrbnQvb0pISkhZdVp1K1BxZTF3aSttb1VzaXh1Y1FkVURnS25yNTlu?=
 =?utf-8?B?TVdoaGVhOXVCYzVNMHBJWUgzNzdMWlp1N3YyZGNEay9La3FHWCtFcy90MXp1?=
 =?utf-8?B?S1lEVStzVzhLUzlDUGluWGJwVjRmaWsyWG9qVzI3disxUmFNMVVhSDVxM3Qv?=
 =?utf-8?B?aFRVeVlXM1VGNVM3emtxeUdUTzlxeHRQRVZEcUZRSzFNK01TVUc1a0ZCa1g1?=
 =?utf-8?B?ZjVxT1BScU1zN0o3d2NXZklIQ1F2QlB4V3B2TUkrU0dYMVo3U1lDaUk2Umth?=
 =?utf-8?B?L0dSZndnN2l1bVVHQjdlQk9kbGxPcG1RQ2tvSlZjVzJnTjdhQlRZQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D130981319F6640AF9F19467384175C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pDvRDKpLhJdKsx06B+6PTUhyitUcwg0RqMl89cmm2Yo9w1rYkJHglSxPVyIgMYvHPyPxnulTNov/p0QORC+xw1bSWammV64VRp5vn87HhCWJ3hfjG3guHQj9BMobZM2qzKPMgnPAVfCX0y2NhhuoZCaL43u63Zu1PeRnw1Nu4sGU9tC6TUB8hjpDv0P8wo6CwyQ09S8+p+vEyZX5UXHb/g9+8K31sVA1LQypsMMBCSjOGOfjA1haoJWVhm/KgpyXxw6gX6VhdCPhWv/5423ArCKPXsQsxPrJGiYNyoXBWGOEujvyjz67lAwrjSk2SHunITlnp83CjRGGmZxUJNeptw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f32027-572d-43aa-3f61-08df04df005e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 08:33:13.9940 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /KZ3VjPqFrMhIIhCzm9ac4WAzDfmiAT3tHZZHwgfCjXvRQ2lM9UskJjZxMMLoNY4tKQ6sukZqG5bfU+1Z+M87Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8317
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

T24gVGh1LCAyMDI2LTA3LTA5IGF0IDEzOjMxICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gQ2xhcmlmeSB0aGUgbWVhbmluZyBvZiB0aGUgc3ViLWZpZWxkcyBpbiB0
aGUgY3J5c3RhbCBmcmVxdWVuY3kgYW5kDQo+IHRyYW5zbWl0dGVyIGludGVycnVwdCBkZWJvdW5j
ZSByZWdpc3RlcnMsIHdpdGggdGhlIG9ubHkgcHVycG9zZSBvZg0KPiBpbmNyZWFzaW5nIGh1bWFu
IHJlYWRhYmlsaXR5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwg
UmVnbm8gPGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gLS0tDQo+
ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwLmMgICAgIHwgMzUgKysrKysrKysrKysr
KysrKy0tLS0tLS0tLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwX3JlZy5o
IHwgIDYgKysrLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgMTYgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kcC5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcC5jDQo+IGluZGV4IGZlN2Uw
NWUyN2Y2Zi4uMTE4MzczOGFiOTAzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2RwLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcC5j
DQo+IEBAIC0xMjE2LDkgKzEyMTYsMTUgQEAgc3RhdGljIHZvaWQgbXRrX2RwX2luaXRpYWxpemVf
c2V0dGluZ3NfdjJwMShzdHJ1Y3QgbXRrX2RwICptdGtfZHApDQo+ICANCj4gIHN0YXRpYyB2b2lk
IG10a19kcF9pbml0aWFsaXplX3NldHRpbmdzKHN0cnVjdCBtdGtfZHAgKm10a19kcCkNCj4gIHsN
Cj4gKwkvKg0KPiArCSAqIFNldCBEUCBYVEFMIGZyZXEgdG8gMjZNSHogYW5kIGFjY3VtdWxhdG9y
IHRvIDEuDQo+ICsJICogVmFsaWQgdmFsdWVzIGZvciBYVEFMIGZyZXEgYXJlIDEyIGFuZCAyNi4N
Cj4gKwkgKi8NCj4gIAltdGtfZHBfdXBkYXRlX2JpdHMobXRrX2RwLCBNVEtfRFBfVFJBTlNfUDBf
MzQyQywNCj4gLQkJCSAgIFhUQUxfRlJFUV9EUF9UUkFOU19QMF9ERUZBVUxULA0KPiAtCQkJICAg
WFRBTF9GUkVRX0RQX1RSQU5TX1AwX01BU0spOw0KPiArCQkJICAgRklFTERfUFJFUF9DT05TVChY
VEFMX0ZSRVFfRFBfQUNDVU1fTlVNX01BU0ssIDEpIHwNCj4gKwkJCSAgIEZJRUxEX1BSRVBfQ09O
U1QoWFRBTF9GUkVRX0RQX0NMT0NLX01IWl9NQVNLLCAyNiksDQo+ICsJCQkgICBYVEFMX0ZSRVFf
RFBfQUNDVU1fTlVNX01BU0sgfCBYVEFMX0ZSRVFfRFBfQ0xPQ0tfTUhaX01BU0spOw0KPiArDQo+
ICAJbXRrX2RwX3VwZGF0ZV9iaXRzKG10a19kcCwgTVRLX0RQX1RSQU5TX1AwXzM1NDAsDQo+ICAJ
CQkgICBGRUNfQ0xPQ0tfRU5fTU9ERV9EUF9UUkFOU19QMCwNCj4gIAkJCSAgIEZFQ19DTE9DS19F
Tl9NT0RFX0RQX1RSQU5TX1AwKTsNCj4gQEAgLTEyNjAsMjggKzEyNjYsMjkgQEAgc3RhdGljIHZv
aWQgbXRrX2RwX2luaXRpYWxpemVfYXV4X2hwZF9kZXRlY3Rfc2V0dGluZ3Moc3RydWN0IG10a19k
cCAqbXRrX2RwKQ0KPiAgDQo+ICBzdGF0aWMgdm9pZCBtdGtfZHBfaW5pdGlhbGl6ZV9ocGRfZGV0
ZWN0X3NldHRpbmdzKHN0cnVjdCBtdGtfZHAgKm10a19kcCkNCj4gIHsNCj4gLQl1MzIgdmFsOw0K
PiAtDQo+ICAJLyogTWFzayBBVVggVE9QIGludGVycnVwdCwgYXMgdGhpcyB1c2VzIHRyYW5zbWl0
dGVyIGZvciBIUEQgKi8NCj4gIAltdGtfZHBfdXBkYXRlX2JpdHMobXRrX2RwLCBNVEtfRFBfVE9Q
X0lSUV9NQVNLLA0KPiAgCQkJICAgQVVYX1RPUF9JUlFfTVNLLCBBVVhfVE9QX0lSUV9NU0spOw0K
PiAgDQo+IC0JLyogRGVib3VuY2UgdGhyZXNob2xkICovDQo+ICsJLyogU2V0IEhvdHBsdWcgZGVi
b3VuY2UgdGhyZXNob2xkIHRpbWU6IHh0YWxfcGVyaW9kICogZGViX3RoZCAqLw0KPiAgCW10a19k
cF91cGRhdGVfYml0cyhtdGtfZHAsIE1US19EUF9UUkFOU19QMF8zNDEwLA0KPiAgCQkJICAgOCwg
SFBEX0RFQl9USERfRFBfVFJBTlNfUDBfTUFTSyk7DQo+ICANCj4gLQl2YWwgPSAoSFBEX0lOVF9U
SERfRFBfVFJBTlNfUDBfTE9XRVJfNTAwVVMgfA0KPiAtCSAgICAgICBIUERfSU5UX1RIRF9EUF9U
UkFOU19QMF9VUFBFUl8xMTAwVVMpIDw8IDQ7DQoNCkl0IHNlZW1zIHRoZSBvcmlnaW5hbCBjb2Rl
IGhhcyBidWcgaGVyZS4NCkZpeCB0aGUgYnVnIGZpcnN0IChpdCBjb3VsZCBiZSBiYWNrcG9ydCks
IGFuZCB0aGVuIGNsYXJpZnkgcmVnaXN0ZXIuDQoNCj4gLQltdGtfZHBfdXBkYXRlX2JpdHMobXRr
X2RwLCBNVEtfRFBfVFJBTlNfUDBfMzQxMCwNCj4gLQkJCSAgIHZhbCwgSFBEX0lOVF9USERfRFBf
VFJBTlNfUDBfTUFTSyk7DQo+IC0NCj4gIAkvKg0KPiAtCSAqIENvbm5lY3QgdGhyZXNob2xkIDEu
NW1zICsgNSB4IDAuMW1zID0gMm1zDQo+IC0JICogRGlzY29ubmVjdCB0aHJlc2hvbGQgMS41bXMg
KyA1IHggMC4xbXMgPSAybXMNCj4gKwkgKiBTZXQgaW50ZXJydXB0IGRlYm91bmNlIHRocmVzaG9s
ZCB0aW1lDQo+ICsJICogVkFMICB8ICAwICAgICAxICAgICAyICAgICAzICBJTlRfVEhEDQo+ICsJ
ICogTG93ICB8IDEwMCAgIDMwMCAgIDUwMCAgIDcwMCB1Uw0KPiArCSAqIEhpZ2ggfCA3MDAgICA5
MDAgIDExMDAgIDEzMDAgdVMNCj4gIAkgKi8NCj4gLQl2YWwgPSAoNSA8PCA4KSB8ICg1IDw8IDEy
KTsNCj4gIAltdGtfZHBfdXBkYXRlX2JpdHMobXRrX2RwLCBNVEtfRFBfVFJBTlNfUDBfMzQxMCwN
Cj4gLQkJCSAgIHZhbCwNCj4gKwkJCSAgIEZJRUxEX1BSRVBfQ09OU1QoSFBEX0lOVF9MT1dfVEhE
X0RQX1RSQU5TX1AwX01BU0ssIDIpIHwNCj4gKwkJCSAgIEZJRUxEX1BSRVBfQ09OU1QoSFBEX0lO
VF9ISUdIX1RIRF9EUF9UUkFOU19QMF9NQVNLLCAyKSwNCj4gKwkJCSAgIEhQRF9JTlRfVEhEX0RQ
X1RSQU5TX1AwX01BU0spOw0KPiArDQo+ICsJLyogQ29ubmVjdGlvbiBhbmQgRGlzY29ubmVjdGlv
biB0aHJlc2hvbGRzOiAxLjVtcyArICg1IHggMC4xKSBtcyA9IDJtcyAqLw0KPiArCW10a19kcF91
cGRhdGVfYml0cyhtdGtfZHAsIE1US19EUF9UUkFOU19QMF8zNDEwLA0KPiArCQkJICAgRklFTERf
UFJFUF9DT05TVChIUERfRElTQ19USERfRFBfVFJBTlNfUDBfTUFTSywgNSkgfA0KPiArCQkJICAg
RklFTERfUFJFUF9DT05TVChIUERfQ09OTl9USERfRFBfVFJBTlNfUDBfTUFTSywgNSksDQo+ICAJ
CQkgICBIUERfRElTQ19USERfRFBfVFJBTlNfUDBfTUFTSyB8DQo+ICAJCQkgICBIUERfQ09OTl9U
SERfRFBfVFJBTlNfUDBfTUFTSyk7DQo+ICAJbXRrX2RwX3VwZGF0ZV9iaXRzKG10a19kcCwgTVRL
X0RQX1RSQU5TX1AwXzM0MzAsDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RwX3JlZy5oIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcF9yZWcuaA0K
PiBpbmRleCA5Y2FmNzQzZjRmZTYuLmNlNDdiOTlkZGRjNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kcF9yZWcuaA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2RwX3JlZy5oDQo+IEBAIC0yNTMsNiArMjUzLDggQEANCj4gICNkZWZpbmUg
TVRLX0RQX1RSQU5TX1AwXzM0MTAJCQkJMHgxNDEwDQo+ICAjZGVmaW5lIEhQRF9ERUJfVEhEX0RQ
X1RSQU5TX1AwX01BU0sJCQkJR0VOTUFTSygzLCAwKQ0KPiAgI2RlZmluZSBIUERfSU5UX1RIRF9E
UF9UUkFOU19QMF9NQVNLCQkJCUdFTk1BU0soNywgNCkNCj4gKyNkZWZpbmUgSFBEX0lOVF9ISUdI
X1RIRF9EUF9UUkFOU19QMF9NQVNLCQkJR0VOTUFTSyg3LCA2KQ0KPiArI2RlZmluZSBIUERfSU5U
X0xPV19USERfRFBfVFJBTlNfUDBfTUFTSwkJCUdFTk1BU0soNSwgNCkNCj4gICNkZWZpbmUgSFBE
X0lOVF9USERfRFBfVFJBTlNfUDBfTE9XRVJfNTAwVVMJCQkoMiA8PCA0KQ0KPiAgI2RlZmluZSBI
UERfSU5UX1RIRF9EUF9UUkFOU19QMF9VUFBFUl8xMTAwVVMJCQkoMiA8PCA2KQ0KDQpVc2VsZXNz
LCByZW1vdmUgaXQuDQoNClJlZ2FyZHMsDQpDSw0KDQo+ICAjZGVmaW5lIEhQRF9ESVNDX1RIRF9E
UF9UUkFOU19QMF9NQVNLCQkJCUdFTk1BU0soMTEsIDgpDQo+IEBAIC0yNjcsOCArMjY5LDggQEAN
Cj4gICNkZWZpbmUgSVJRX01BU0tfRFBfVFJBTlNfUDBfSU5UX0lSUQkJCQkoQklUKDMpIDw8IDQp
DQo+ICAjZGVmaW5lIElSUV9TVEFUVVNfRFBfVFJBTlNfUDBfTUFTSwkJCQlHRU5NQVNLKDE1LCAx
MikNCj4gICNkZWZpbmUgTVRLX0RQX1RSQU5TX1AwXzM0MkMJCQkJMHgxNDJjDQo+IC0jZGVmaW5l
IFhUQUxfRlJFUV9EUF9UUkFOU19QMF9ERUZBVUxUCQkJCShCSVQoMCkgfCBCSVQoMykgfCBCSVQo
NSkgfCBCSVQoNikpDQo+IC0jZGVmaW5lIFhUQUxfRlJFUV9EUF9UUkFOU19QMF9NQVNLCQkJCUdF
Tk1BU0soNywgMCkNCj4gKyNkZWZpbmUgWFRBTF9GUkVRX0RQX0FDQ1VNX05VTV9NQVNLCQkJCUdF
Tk1BU0soMSwgMCkNCj4gKyNkZWZpbmUgWFRBTF9GUkVRX0RQX0NMT0NLX01IWl9NQVNLCQkJCUdF
Tk1BU0soNywgMikNCj4gICNkZWZpbmUgTVRLX0RQX1RSQU5TX1AwXzM0MzAJCQkJMHgxNDMwDQo+
ICAjZGVmaW5lIEhQRF9JTlRfVEhEX0VDT19EUF9UUkFOU19QMF9NQVNLCQkJR0VOTUFTSygxLCAw
KQ0KPiAgI2RlZmluZSBIUERfSU5UX1RIRF9FQ09fRFBfVFJBTlNfUDBfSElHSF9CT1VORF9FWFQJ
CUJJVCgxKQ0KDQo=
