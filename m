Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E162C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 06:17:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2614C10EE72;
	Thu, 27 Aug 2026 06:17:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="MoRLmexf";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="gXucx+ht";
	dkim-atps=neutral
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48DE710E3AE
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 06:17:29 +0000 (UTC)
X-UUID: f8732834a1de11f18dc8c9802ae25ab1-20260827
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=1ji0DWZ4DH+zZCWxV3jvfT+oyXKohwDLDO5LuM49mos=; 
 b=MoRLmexfwbFWLdenG04hS/DVCHcHr5w7RGPmhScxZ9nWsQf6f3II1AMcWmsD+N5zQFtYuvhyfSV5NuNjloAzUs9A2R7B8cpW4uyZUSb/LmcxkbO/8r+R69+xXhuFJYP1ZqH+X3R+bnKgG2uLFg8u4VwsrxP0JEu7o7JNbdeBJRs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:37300430-be24-4c32-bf31-9b3ca7175b80, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:7db8b62, CLOUDID:e3423dc3-610e-480f-b463-9bb53aa0aeaf,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
 1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f8732834a1de11f18dc8c9802ae25ab1-20260827
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 82667352; Thu, 27 Aug 2026 14:17:24 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 27 Aug 2026 14:17:23 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 27 Aug 2026 14:17:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eShvDUTvD9mGc3K7AtmQR4jXp3n6xLzmuswOIdW+43VRqWzSOpZ/iSRQJaJKrbBuTF6MJ9BQWc4yvDMotmBJAGbgikKWrf5TdaH37I+oMHDaU58qlt5bdbDfZCD80eCutKMet0UI8HJjKYvsRiPrevs9V/3fR9nSO5XnTrOegzFREDRUFQurfXqT3akmzyI4B2X8Gn6wC31Kha1FzfBmtMrhO+0UyZeZschnuuKnMCvtownXmNO/JlIGxtoWzWE1ilqnWvGSUUoM/PsdtvE4adVh6EQ0am1BoZ0EtG8VEd6JPNAV65jvIkFvIWAYs6SktphzPXSyan/NelqgJqH0DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ji0DWZ4DH+zZCWxV3jvfT+oyXKohwDLDO5LuM49mos=;
 b=oxX6ZcIBU+seyY+f0Uochc365oTYD0pGWkROQCLMOT2HC3f/9ISQVVLj6aM2jjtlh7xXdxw10wHbS8JTVNq3azZOuXiC/WPzKVyfuO4cbzSXYUIYxokVeuUJrzL8XiooeRV4o649nzEZtBWU4D3gIj5lcLHWUxgQzuOfvXPTH1a4wpG5N2QS64y8LXjOS96ijoqTF+O7E9NqrlDcv7H6Az4JLyP3prcgdW2JkJKWtlzqILh7b6nvrDgrybtJIfdFPyCUm7voB0B2+nAOvQSF7/UYHk66nYqrqt9r3pg/xP72yv0ZZsELNb+t7oneDR/CHXCY8O2KnByaNi4cFplk4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ji0DWZ4DH+zZCWxV3jvfT+oyXKohwDLDO5LuM49mos=;
 b=gXucx+htl053Q832olK+GWU+ZbHTSPzrOOJBiWiCiNj0qreBJ/tg4h/mAr5+/Q3lWPPC/Ys/b4j8JQ04v9J2z8xjcPMxwz16e9PfyJ3MatLrATXI2dRyAMO5932uI9mWgdA7917HH0vYm1zBscl7/Iaofo3W2yQQpbVewfC/z0I=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB7297.apcprd03.prod.outlook.com (2603:1096:101:12e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Thu, 27 Aug
 2026 06:17:16 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 06:17:15 +0000
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
Subject: Re: [PATCH v4 02/12] dt-bindings: display: mediatek: dp: Add
 compatible for MT8196 eDP
Thread-Topic: [PATCH v4 02/12] dt-bindings: display: mediatek: dp: Add
 compatible for MT8196 eDP
Thread-Index: AQHdD5arL7CCoF0PIkGysy/5ed2qS7axuDoA
Date: Thu, 27 Aug 2026 06:17:15 +0000
Message-ID: <c5bb863bb324d6ae6291cf4b9d7236208239f5b8.camel@mediatek.com>
References: <20260709113148.49090-1-angelogioacchino.delregno@collabora.com>
 <20260709113148.49090-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260709113148.49090-3-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB7297:EE_
x-ms-office365-filtering-correlation-id: 4b38e7ac-517b-471d-e4e8-08df0402d744
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|1800799024|366016|42112799006|38070700021|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: Ls3VCBA+rA/Qx3m9aoFpaRqemQlMPHm5Ew7TWTbiRNOuMxP7OYb1nNeNH629EGGk5B3Ca/ibMvIN1xEIDdhNSDRr78uOiNPsSrPtKbVh/qS1shcQnp5eZoCMKb3wtT0lKUXUQoW68YM9TR+YYJiCpeCkPBLffuRiJlp5GDxYuc4g3Uy43zHnwYdXvk0e/iudHVy9PAX/Ka1ORnFWtwILTxXb1h9TABUhio6itvYwC2n/GPka72db7Tv5me/8EJC4bJ09cMPf20bhiOjfvNzmeOV0+py6omMLhirFDfRnKCSLoUWL1kC4Aq4Oqzq6X4INvoHo1U63QzKag+0MG6+PnFRO9gXIpgCNXyCM/lnJzlW7+oWUnAB0C8KSI2C04Sm8+60rsZfWryNo2jnKbO96qUp7PvWICuQhcUlpNjpzd3+tx/6r70otb8RFDLu5pELuO8mhU7iB0pdRe+3SAAdg8deH9GLWEPISNIE3vxmz05Mg47wIcFly/CdZAnkb9hYJ8tjsktO2S66b57sBYMuQ4Ejtu1nURKtdcEKveDMq7kLiDAXI1as8nuM1cEs9t8yiWO+GU3mE2oQMZ/wyB5qlp0zGP8Dze1Ez0/1+39Xc3Rj72zBOiZcIZLMjFuKX64AflojzJoIyZV6WvtVHouw+bRIpAz4JFE9FzQLBSPNHqnk7dW/F9iNNIOgPM6z+axZqbX3kd6Qw4S2SMSDOQ/ngtuIPLHtwOWJVSAWHwj80Fws=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(42112799006)(38070700021)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnhUS3p3eEpNWmhTZXlQZDhvK2tyVDFuMytaNUdIakVpbkdTa2xPK3lQWUpM?=
 =?utf-8?B?cDJHT3dPWXpNSSt4UWlqdkFkSC94V1Jkc1ZCUUFXNWtIelZsbWJZM28vOGpW?=
 =?utf-8?B?R0tONmtZbnVwVUY1UjRhTyt3enhEdVJDL3hrWVZQN0ErZ0JPYmQ2U1BnTTFD?=
 =?utf-8?B?T0QyWTdWaXN6MmhXalFLRWlraTFjbG10czNIeC9QRkpKRVRQZnNHelRqK2Y3?=
 =?utf-8?B?eDQ4TVRUN0F0OTdUeUJ6c3ZWUFgwbmFsYXhnQkdrY2Z1RW16NlNOMm9CNXNM?=
 =?utf-8?B?cmZPS3NBajRsZ3IrbkhNandQOWNLYloxczdvRnhTNEFXRWVVMGZLOWFCQ0Zo?=
 =?utf-8?B?Y3Z2TzJYT0g4ZWdNbGFROU1xVUJ1UFZKeml3anFuYmpHNnNTWi9WTXJpTllY?=
 =?utf-8?B?c0x6R3lUeFZxUHJLU1l0Sk1qWlpLdGlPRGFBa3d4SDIybzFLdTFkZVYvT0Zx?=
 =?utf-8?B?cEp3VzJiRnlLQ3NyMllzWmNqWHNpWG1CNjZIckN6UUNZOG5ja3JLQXJ4d3RT?=
 =?utf-8?B?NFBBVnR4b3I3UU9FRXN3bkZpTHNpQXRRMGZHNGFYT0JZcllYMnl3NUZoVWV3?=
 =?utf-8?B?UnBiVkJlNy95clJ4U2EzNTJZZis5U0pqTVF2c3d5RFVFZDRuQ0NHMm1oemlT?=
 =?utf-8?B?S2RnYWlENTk4RmVpMGJ6VElsNkp0OEE3ZlcvWUxZUER1ajNnTDRJNUVoN1Ft?=
 =?utf-8?B?enFob1dIV3AxbStKaVVPVmxabWp4aEZXRjJmTU5oSkFRM1hVKzliWlgwcmVL?=
 =?utf-8?B?U1JDOTJvWkI2OTRxRC9JSG81SUovekdYOTlqQWZBdUhhaTFJblhOOGxBRXMx?=
 =?utf-8?B?andzTjFDSU9lbDBSYUk1dTdHK3E1M2RYdEdNL2pvdkw4aW5yeVY3a1l5ODJi?=
 =?utf-8?B?akk0RmNFZm5nK1Rsd3dIRGx6MXpMamxOL1g4d0Y0MmhUdU5mR2kxenRQOCtF?=
 =?utf-8?B?NUhrZDc5MVQyR0FvVXFUS0xPdENHbTVCSlZLNm5rNVlSQ0phWVF1dk5pekNz?=
 =?utf-8?B?MG1hbkdkNkZoaC9QVXhub3J3a0Z2czBBeXMxK05LTnBGazRiRUFTRGhUdUtz?=
 =?utf-8?B?c0w0a1hzTXZEbkdNSzNKOTE4aG92Z2tERGczelAyNXhyYm1EVFRPTWt5NWEy?=
 =?utf-8?B?am13bm1rcmlGaGZXV040Rm1LR3J4K3ViUjFsUjZoSE1pZ3E5UHVhbENBc2M3?=
 =?utf-8?B?c2tqSFZETFcxWVUwekg1Lzh1ZTZESnk1K2VHRXM0YStoMmpRWmVXVndIaVE3?=
 =?utf-8?B?cld1TjQ4eG01bDhEWE1LYXRXelFLWDZYdDVtSVJrcUNOK2k5a09UOEtwd3hm?=
 =?utf-8?B?ekpaa3pwNmRuMFE1eXQ4VVNBSXBDWXgxYzlGWnQ4Z3lhZmhrMy9ESU04UUsr?=
 =?utf-8?B?MUYxd3ZBblRrN2ZQT1hvNzRRWVZDd1FRdkhuS00xR2hXa0hDNFZ5UCt4eTRS?=
 =?utf-8?B?czBVZEZZM04xQ1V5NFJNWWxGMW9TZzRPaEhobm1KdW1GelNrcWkrRnRzSFJC?=
 =?utf-8?B?WXg5TkVNWDMzZUJBR0hyamNKR0Y4NGV4Ym9NQnpTOGEwOEliWURRU0JjR2kx?=
 =?utf-8?B?ZFhyMGNuMnZabUY0SGlHaEVXQXVmZTY4N29xR0UzZVRFVURaOVUwdm55WHg1?=
 =?utf-8?B?Z3VsSjFYWTkyUVFFNzUrM0MvL2dhbDF0czRmbkU5a0JqWHAyMThhcU5uNkxC?=
 =?utf-8?B?U2RVaVJXNnMrU2NSYk5GSHNKN0Q4OEt5dE9XamhMNFg5QnZTZGhnYVZrY2ta?=
 =?utf-8?B?aVJVYUpkN0NGTUJNSTA0UlErcmUzdTBvOVNGa2JzbkNLa2dDamN0aG5FUGpx?=
 =?utf-8?B?VU5hOUpmMjRJMW5RQjhjSkl1VUpRdVJVamtQQ3lNZmtYdGJNM2hXdk8wRjZY?=
 =?utf-8?B?bGhiaXRJMy85QUh3Y2ZYTkNYRTk1Ny9qTVlqZUJwN1F6aEJlMGlKeEtxTTYv?=
 =?utf-8?B?RUJyVnlmVGVkSklHMjBVbnhKbzdJaFN1TlpPZTgyK2xML1FnNFByeEQyV0pr?=
 =?utf-8?B?N1FyTXpsUUlCcGlvWXJDMjFBZy9rcFdCWS84dUFKbmRqd1dHZzZPeXZUN1kx?=
 =?utf-8?B?VW9ic3N0UW5oUkI2K3p5UUV4aWNuK1JVQnMxa25TR0FjLzBnM2w1eVA2a1d0?=
 =?utf-8?B?WEh2NitZdEg1TnRxcGE1bWExRXQwcVpzUzMzcGNkL0d6SS9Vci81elMrT2lh?=
 =?utf-8?B?Zk12S0gvVElqaFo0T0tXdm5PV2F2Z0hFTVNnYUYvQXpzYitnUWEwc3ZPbzZw?=
 =?utf-8?B?S3JLWHVkbWtjZWdieTRpY3lEdkFtd09MUXhJZFZMb1F0eTVYQTVaYU9SRU1a?=
 =?utf-8?B?QmcwTGtBNDhPVHFnZzVZdUt2eXM4dHU2ZGpkbmRQbDJ5aytxdFArUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <35837676674E3B469A0854AA2EE81BFF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oxFgNdc2urR+WuyOM4UujOaOcvF2onspF+X89BByloxPr1D9H7hXIGszDVBT6n6lYw1ZCJnS31weZSWrYUVJGZ7Ibu+vpXPU6832ZI42bpr+Guw7KT3iOGjAlzf81T2M0azBebdLLSXaFT9GxRtzCpTQ/B5WroQ89eZS8+cVqam1hFf+MAw1n/nWVzym5dBhLy6PYkZnwQAqRQpfaunp7h4O89zpqmzViWkKQQoDuz2LwReE+sgfv9AL6O0axw7zRsfgSqKmQ44IDvpWzjIiA7BNnPiUFJi7W/R0v8vOZfT7DY6q89wajIhL+1PkHFFcpm+Q2ZfNMlBP/jBqikq0eA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b38e7ac-517b-471d-e4e8-08df0402d744
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2026 06:17:15.7499 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rWu73uuZpbB/3TyZdTIoK0HQOpF0sXOZG8TfNmbGHx6DrDBCZ6/4r26/7q5hHPVVr/tTpXIGUiH7Z68Z70EL8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7297
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
ZWdubyB3cm90ZToNCj4gQWRkIGEgbmV3IGNvbXBhdGlibGUgZm9yIHRoZSBFbWJlZGRlZCBEaXNw
bGF5UG9ydCBJUCBmb3VuZCBpbiB0aGUNCj4gTVQ4MTk2IFNvQy4NCj4gDQo+IFRoaXMgSVAgaXMg
Y29tcGF0aWJsZSB3aXRoIHRoZSBwcmV2aW91cyBvbmVzLCBidXQgbm90IGZ1bGx5Lg0KDQpSZXZp
ZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9A
Y29sbGFib3JhLmNvbT4NCj4gLS0tDQo+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5
L21lZGlhdGVrL21lZGlhdGVrLGRwLnlhbWwgICAgICAgIHwgMSArDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkcC55YW1sIGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHAu
eWFtbA0KPiBpbmRleCA5ODBmNzY2NjdhZGEuLjNhNzUyYTk5OTQ5YSAxMDA2NDQNCj4gLS0tIGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0
ZWssZHAueWFtbA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlz
cGxheS9tZWRpYXRlay9tZWRpYXRlayxkcC55YW1sDQo+IEBAIC0yNSw2ICsyNSw3IEBAIHByb3Bl
cnRpZXM6DQo+ICAgICAgICAtIG1lZGlhdGVrLG10ODE4OC1lZHAtdHgNCj4gICAgICAgIC0gbWVk
aWF0ZWssbXQ4MTk1LWRwLXR4DQo+ICAgICAgICAtIG1lZGlhdGVrLG10ODE5NS1lZHAtdHgNCj4g
KyAgICAgIC0gbWVkaWF0ZWssbXQ4MTk2LWVkcC10eA0KPiAgDQo+ICAgIHJlZzoNCj4gICAgICBt
YXhJdGVtczogMQ0KDQo=
