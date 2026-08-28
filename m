Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F072C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:48:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9668310F26F;
	Fri, 28 Aug 2026 06:48:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="Ql49Kh/l";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="m40gva1N";
	dkim-atps=neutral
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F167E10F26F
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 06:48:16 +0000 (UTC)
X-UUID: 7057952ea2ac11f18dc8c9802ae25ab1-20260828
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=DOqeylZ3tOkPMkhTDvPIK2b46nZjqjkeRoswg2h/dRg=; 
 b=Ql49Kh/l1RPHVHUf+1XVSVgsI+doH8GbnSq8vWtTteRtzzrg7la1J67n/WYxktPJeAzM/So4MAXdr4hUw1unsxKMsjH0eIyFmnvpZw9cvrpi5nHbMAHunWdcgFF66wmhbvDSJQyJWLi9MiTMVfUSlLRlZpkV2eIawcRw4rCpmQw=;
X-CID-CACHE: Type:Local,Time:202608281448+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:65a2b051-5896-4514-9452-3e03715a97a0, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:7db8b62, CLOUDID:b28affd9-399d-4fb2-bf59-1c094fb0e05e,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|136|836|865|888|898,TC
 :-5,Content:0|15|50|99,EDM:-3|-100,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:
 nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
 :0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7057952ea2ac11f18dc8c9802ae25ab1-20260828
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1167537693; Fri, 28 Aug 2026 14:48:12 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 28 Aug 2026 14:48:11 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 28 Aug 2026 14:48:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LHAx2j3mFC37xBafSuy1oJ2tQC0iy7zKlJgqYO4+yGrHoshMS8i0jXfvaFNB7Se52X8y9doSe5SgPGrHzg3vApeQwRFd9aYAQoZfP/ot1YjgABbzzDaV9XFMEjo0NS6G4KV1gPdkZ875QCl/55VvKtu4m5EdiJvPCMzKMgrJDd6LomeryFNHa7LRFpjK2qTDgS0DeB3GK8klBkz8em0yAt7nSKjZ5SeJq7T31tBatNBBKGekviQR1KItVoY+Yn4l8VZOGeOMBaQkpf5A7j4DkbqrdEM2WwjqPoKrvch4IekM6CUkyAZEliKBJ6PsNLnWxCuLeD0zkqRxBvkbgLooeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOqeylZ3tOkPMkhTDvPIK2b46nZjqjkeRoswg2h/dRg=;
 b=e7UeEPMqiA9d1Eoc8qCfSFWILhGYSkYP0GhA8b3cv5p3J7Oj+XEXxsDgJzpqq9LIlb6HmJDf7SL62QiFYTADCM8URaSPH5+NSrXHSEyyAbealmLiHunS3NtigIOLXmsRtt2P1eqsSzvelSYkcCToiUimQybcUZhUb1KPsD8c9azw8ZK6L6eupW/HuZnn+uRPCGhjdYQuvlW5BDFTQPRrToQn84m92sP9kc++5p2LkN3vS+9dxutPZqwF5joDYYJ1umOBNeaSU46B+MdNkXmYWZnQ6kGD7olBY0Bw5MwwyCV6HalPaGMZyylkrNAhmZ+YuKpkO67Nzxs7wVRw/ZsPDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOqeylZ3tOkPMkhTDvPIK2b46nZjqjkeRoswg2h/dRg=;
 b=m40gva1NIVnF7RE/sLdIFWhvZ1lZhPi/DSMkHlN23UYFNgoeejH37UvH2N8IABIVMhTpKIzrWrGwvrTi5ylnXnCkMWky84V9WRwsMi8gszE3TUTxJ02XMjIM1EWcycgM/yEpBo1+VZqVKRysPbaBTc/tp7uhZzAolF0AaHGL6fQ=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB6769.apcprd03.prod.outlook.com (2603:1096:101:68::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 06:48:06 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 06:48:05 +0000
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
Subject: Re: [PATCH v4 10/12] drm/mediatek: mtk_dp: Add support for HotPlug
 Detection in DP AUX
Thread-Topic: [PATCH v4 10/12] drm/mediatek: mtk_dp: Add support for HotPlug
 Detection in DP AUX
Thread-Index: AQHdD5av2q2OR1TkdkixzewHOFxL0LazUy2A
Date: Fri, 28 Aug 2026 06:48:05 +0000
Message-ID: <8cdcf1554c6dcaebf2e10a742deab7a37cdbc858.camel@mediatek.com>
References: <20260709113148.49090-1-angelogioacchino.delregno@collabora.com>
 <20260709113148.49090-11-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260709113148.49090-11-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB6769:EE_
x-ms-office365-filtering-correlation-id: 8951e7bd-7550-4aea-37d9-08df04d05045
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|42112799006|366016|23010399003|7416014|376014|1800799024|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: h7gS67Snb/ZFrX5EhDhR6mrTe1xJS7seqMzIbyVAaxp9IU9o0focofDX5DbzrT7j31RHG2cui5Is4JDEhzz8/5/vLP5B7daB8q4ElgrfejscoZPcl2tWYZTlD/Srsq2ZtouPhKsvxE40IQRJJONB/5kYvsD7TeWRepjy+TWwvuT1+BoPGJufqxRxVHHXJ8fYpjiiFArfSr2akPoP/P3a4CFp1IraWqUzHHfhmT9ktkWce9GYpVQSspHTEkV6aJBqnU7qshtU6Eh558dmYv3yy5gh0QiVyQ522/N0a6DhhXg7v3/mF+/qAAsUB3QAGgK5QPUbqdg0lRh606SVwxs3A+u2jJd/AO9i6MQHp34raaLpyq38hFJxpMwsMS1HAHDninX+YdRaVPEu9xnEsPX8lRkFZB+Rz9Ugyj5uCvKS76CB78n6iJmdwEqJ6QDO2YTggyzilZOyUi3sbrtLV14KdqpOoOV6a/XiEr9dSNxgElKPuBZQjIsSfMiweSIrO8i+JlTL9U9IfpRhXsg8OKWGInYT/HcwzuNXsF3rN+ytYbi/Mod9JFUK+Yvpnoz9YIQt4Aqz/lDeoLt6c7+td5hUF0nyIaJgm2tJwdV7H7AEsd0v1d8fYhHN1jESj/bUVxxo7DdCHgggyu8nXkFDrLBWIALDgUe3zIYzgkPDOFu43M7FFD0/s5QNRVg4uZnoc3LNqHPJPjoTgBNaP7/fJke7Ew==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(366016)(23010399003)(7416014)(376014)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkkvVUsvbnF3YThtWmkrS2xpd1JNT05wcWRTYURqaU5vMjA0TlBOWWh1Z2U1?=
 =?utf-8?B?YmZpN0pCNUxvR0FQZVF5cEU2eFFtay9kQzRJWktrem93dzNvL05pMHo4TmRH?=
 =?utf-8?B?NXBrYlh3QVJLeWZzMklpR0l5SnZSTlFSOWFRcjlWYUxpaVRzS2F2VTVweGlE?=
 =?utf-8?B?akJqN3NTcjJuYUNHREhNSG1ua2x3ZFI5aGVjekppMDZTT3dnNTREUWJ1RWx4?=
 =?utf-8?B?MTBZSnluaFlrQWtIMzVKanpjaDVoQThXSitodC9BOG9qdEdGSXlKZTdLRXhr?=
 =?utf-8?B?aUZvVWY1bjhVcDdvS29tdjQ5WXNWTXJVSkhhS3BrbEFGZStGSTlLNngwRzZF?=
 =?utf-8?B?VzRiTWxSN0pkcDRPbFNpVFZ0Zzc0RkM1cFNiU0w3cUZQYjdYS2VzMm16aTl5?=
 =?utf-8?B?UWNOMmlSZld1aHlCM21zRWdYUGJVa3Z2QXZHRkU1eFhrQXhZeVpYQ2c5SmlR?=
 =?utf-8?B?ZTFWOFBVbzZmWCs2aTJ6bklodThkMjUxa0lnekcyVS8xYTFJaDlaRXlYNWdU?=
 =?utf-8?B?SDdIMDI0UHVSTXIzejdrZ0tzVTg2MTZtSGY3cHBzbk1PUzVwSHBoYWVmTmhZ?=
 =?utf-8?B?YmlJM1NUVkR1LzBGN0puWFBCOStBUVpHalFsZXRVNHhwZjlJM1dFN1g4ckpu?=
 =?utf-8?B?SG04MG4zMHFGbmJ3UHBFUnl1TzhZYTdxeHJpdGZldGxXS3JGeDZjU2xjNUFI?=
 =?utf-8?B?MHE2bzMwRWREOGlLcllSQTVqa1IyZmJNS2RIQjdHVEJTcCtFZ1U0YnNVSFpT?=
 =?utf-8?B?bjBIM0VoWFRZcUtGMkhEbzNXTGsrbFhWODlzclROM2htSkZpY2M0UmdDdGZ5?=
 =?utf-8?B?dVhKVlkwdGFGYTlnQWdPaXVKb2NOYVNyY0RwUXhTc3dHVW1GZW5sSlpaeGlw?=
 =?utf-8?B?ZmtZeWJzem1NbCtqOHpCU0U1Vkt4QmNqM1BRMm4wSVJ0ZE5XSndDL24yNGxm?=
 =?utf-8?B?L3BuaVg4dDlEK3dLcWtPV09XcGFpd3VPUzFQa2VaRUZvdWZQYkVnaFpJc2Nk?=
 =?utf-8?B?eFBwT09JcnR3VENMOWNVMW9OeUFMR0ZGNlJOMG5FdkRTYjdia244TG10bmd3?=
 =?utf-8?B?UldabCtoZGFCRXZDd09OcVRqN0xCdU1oTjE5cmlHM3d3VFpFWTVpRDRFeGpC?=
 =?utf-8?B?Qm5SRlp5aisvTFhPaXk3WjlQL2pYUFdNM3dhd1UwdGhJa3FqVTVETkhWWGl6?=
 =?utf-8?B?bEJVNG9zNW9iQXltMWpRZlZ6N0tLa2srRVA1M2Y2ZHp2TWJHRjFlczdSS0xI?=
 =?utf-8?B?cVRBSDA0UnZKblRmZU05OUNFOGdRTzh1U0pHTCtQRXFoS2VKb0o5Znc2R2hQ?=
 =?utf-8?B?eUl4Z3FyQnE5Qm1MQUNFMHZ2azlHdW0vNGt2N0hMNHNEUTZRNldCYTlRSFo1?=
 =?utf-8?B?ZHlNUlJHZEdrbm8zemRpcXB6SDJDbXRqeG50cGdUSlJnanlQY3FUM09McXI2?=
 =?utf-8?B?ZXdxSUJoUjlRaWVMNmxhWUV4MVZPMkk2N3pIaTRZRi9ZUm9WZVZ6TnlvRU52?=
 =?utf-8?B?bnFpa3RudGVuSitRMFFrNCs3YWhwNlVzb25aRXFUM3VmcXFGMXB2UzdSVUpB?=
 =?utf-8?B?Wkp3Nk1FTjZqUkRxaUhCZXNsOWN1Rko1c3l3a1NDRjFoTVlrTklZYzRtZEFC?=
 =?utf-8?B?enkyOG9KNUtuNlRpYTBLcnJjcXlISkFOanU1WUVRZEhyTW1Kdld5RFkxZkZG?=
 =?utf-8?B?YVUrelNvYmo4azhJYUQ4WnhhWU81VHVnTmlHemFZVHY3VlJUVGF6UnBabGtx?=
 =?utf-8?B?MHF5ZkZlMWt5R0dRcU03VDBxZlJyczZ3ck9HanN2TmFlbk52QU5wM3hmekl1?=
 =?utf-8?B?dWdXYTQ2aFJQUm9kb0h1WHAzRk9vRjFJdXpzQ3lYaUJvMTFXVGsyM2xlRDdn?=
 =?utf-8?B?ckFyWU5lSVp3VURydGxURlFuTUxsbUdpdGxCK0hvcXdrUFoyckIzNE9xTU9I?=
 =?utf-8?B?SlFULzAydzZIQ0dmbnEzOVAzUUZoUjRJc3N1YVZqd2kwdU1uQWNaY20vQmZQ?=
 =?utf-8?B?Wld3dEUzNkZBY1ZBSnkzeXg1c0tvTkhJclUrdHpxRXd6ZksybnlHeC9sR1p1?=
 =?utf-8?B?TTVZSHdMU0hYc014dTd4V2FPTmczSXhEUmFlM1F5cEVXR3RFU3J5V09uREVw?=
 =?utf-8?B?N2FzOVFWcElXcVlOcHd1V0E0ZSs1blFqV0U4djRxUVZCb3NUdEJTSXgyU0JW?=
 =?utf-8?B?ME1VMVU5VzZ5eDhXUkVheEZ1cWZhYlA4eHdmcFVzVFJaNURsc2t5TGRrc3I1?=
 =?utf-8?B?T3VKaHA3dFRGTFhaQWNKbHFwL3kvUnN0M3dYcnpYSGZJMTBnUnIvZGlsZHVS?=
 =?utf-8?B?VjZUV29yRTVPQXdqRkFINXkxWkRsczVTVDJBQW1OWTUwdFFOenBhdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9F48A572A05E34CA9B3593C2AA859F7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: y1+0yFisCzEcd/FsZf6X+FoKM33qe7yTnqO+SKq7CLV+xOqpjPJeC8N/CI30kFBY+8wGzbqMQUeQWVpw/F8mzHR2kjO17uiM3gKQppAaRTBnsGpFTaaEnV2tL+qyK65n+35ThVr1ewIJN6wNZUqOxwnKCjtMpKFDzFBpovEBuE1bo6ogCvCOpb2d0JESilcy2V99CLpa+tD3gbsXFzqfu2P86lcTZUOCWZvbOog+rbB5xAx/CBvFHryKlKqgEDZ4MsnRZQaCR/aLbMg+E08BuoGnBj7mq6lyH33zR5jCB/xt7kuSUSsc/eJZs5wXEMSp4wYZcH33Dt4LhO2y3Ru+lg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8951e7bd-7550-4aea-37d9-08df04d05045
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 06:48:05.5321 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aN68o/2ijOz28JaS7/1WRjOkjjggWtFzbUqwQbMBC93fn15Gptd2+DBf3y2pGLdwoJ+1MG0WZjrSDjQt3oazYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6769
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
ZWdubyB3cm90ZToNCj4gTmV3ZXIgTWVkaWFUZWsgRGlzcGxheVBvcnQgSVBzIGNhbiBmaW5hbGx5
IHVzZSB0aGUgQVVYIHRvIHBlcmZvcm0NCj4gaG90cGx1ZyBkZXRlY3Rpb24gKEhQRCkgd2l0aG91
dCBoYXZpbmcgdG8gcG93ZXIgdXAgdGhlIGVudGlyZSBlRFANCj4gb3IgRFAgSVAgKHRyYW5zbWl0
dGVyLCBlbmNvZGVyLCBldGMpLg0KPiANCj4gRW5hYmxlIHN1cHBvcnQgZm9yIGNvbmZpZ3VyaW5n
IGFuZCBwZXJmb3JtaW5nIEhQRCBpbiBBVVggYW5kIGNoZWNrDQo+IHRoZSBjb3JyZWN0IEhQRCBz
dHJhdGVneSB3aXRoIGEgbmV3IHBsYXRmb3JtIGRhdGEgdmFyaWFibGUuDQo+IFRoaXMgaXMgZG9u
ZSBpbiBwcmVwYXJhdGlvbiBmb3IgYWRkaW5nIHN1cHBvcnQgZm9yIHRoZSBlbWJlZGRlZA0KPiBE
aXNwbGF5UG9ydCAoZURQKSBJUCBmb3VuZCBpbiB0aGUgTVQ4MTk2IFNvQy4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9naW9hY2NoaW5vLmRl
bHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+IC0tLQ0KDQpbc25pcF0NCg0KPiAgc3RhdGljIHZvaWQg
bXRrX2RwX2h3aXJxX2VuYWJsZShzdHJ1Y3QgbXRrX2RwICptdGtfZHAsIGJvb2wgZW5hYmxlKQ0K
PiAgew0KPiArCXUzMiBtYXNrLCB2YWw7DQo+ICsNCj4gKwkvKiBPbiBTb0NzIHdpdGggd29ya2lu
ZyBBVVggSFBELCB0aGUgdHJhbnNtaXR0ZXIgSFBEIHJlZ2lzdGVyIGlzIGlnbm9yZWQgYnkgSFcg
Ki8NCj4gKwlpZiAoZW5hYmxlKSB7DQo+ICsJCW1hc2sgPSBIUERfQ09OTkVDVF9FVkVOVCB8IEhQ
RF9JTlRFUlJVUFRfRVZFTlQgfCBIUERfRElTQ09OTkVDVF9FVkVOVDsNCj4gKwkJdmFsID0gMDsN
Cj4gKwl9IGVsc2Ugew0KPiArCQltYXNrID0gRFBfVFhfQVVYX0lOVF9NQVNLOw0KPiArCQl2YWwg
PSBEUF9UWF9BVVhfSU5UX01BU0s7DQo+ICsJfQ0KPiArCW10a19kcF91cGRhdGVfYml0cyhtdGtf
ZHAsIE1US19EUF9UWF9BVVhfSU5UX01BU0tJTkcsIHZhbCwgbWFzayk7DQoNCldoeSBub3QgcmVm
ZXIgdG8gYmVsb3cgY29kaW5nPw0KDQpSZWdhcmRzLA0KQ0sNCg0KPiArDQo+ICAJbXRrX2RwX3Vw
ZGF0ZV9iaXRzKG10a19kcCwgTVRLX0RQX1RSQU5TX1AwXzM0MTgsDQo+ICAJCQkgICBlbmFibGUg
PyAwIDoNCj4gIAkJCSAgIElSUV9NQVNLX0RQX1RSQU5TX1AwX0RJU0NfSVJRIHwNCj4gQEAgLTEw
ODksOSArMTEzMywzNCBAQCBzdGF0aWMgdm9pZCBtdGtfZHBfaW5pdGlhbGl6ZV9zZXR0aW5ncyhz
dHJ1Y3QgbXRrX2RwICptdGtfZHApDQo+ICAJCQkgICBJUlFfTUFTS19BVVhfVE9QX0lSUSwgSVJR
X01BU0tfQVVYX1RPUF9JUlEpOw0KPiAgfQ0KPiAgDQoNCj4gIA0KDQo=
