Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E682C61DC6
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 01:24:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17D4810E217;
	Thu, 27 Aug 2026 01:24:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="BhSKTKxY";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Ogcd91Pr";
	dkim-atps=neutral
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A36A10E217
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 01:24:34 +0000 (UTC)
X-UUID: 0ca71dc0a1b611f18dc8c9802ae25ab1-20260827
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=NEnWjXwkOMZTTlyfF8G/2hs64WJ1P38D/7iyM8VOVg0=; 
 b=BhSKTKxYVZUtv5KSlNBd2l4AP1kgV7WtBH4qU0nKL13iQUAeyXs9IONCCGeU6hElXOToR3n6dkdqLQ3OtVysHuif7ODgid5DerSHqk6wNEQbTO1uX3l70AW9B+ffCHa0pAldVz5Z/J22I+NGCFcNBziWeEL2BOol5aDBhz74Xh8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:cc4d44a4-3832-43d1-8114-bb73c7135d92, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:7db8b62, CLOUDID:c7573ac3-610e-480f-b463-9bb53aa0aeaf,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|136|836|865|888|898,TC
 :-5,Content:0|15|50|99,EDM:-3|-100,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:
 nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
 :0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0ca71dc0a1b611f18dc8c9802ae25ab1-20260827
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1041910438; Thu, 27 Aug 2026 09:24:29 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 27 Aug 2026 09:24:28 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 27 Aug 2026 09:24:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQe9/X1Z+6aYqeKQHR3epL/Ur/K7ZmRNy5kxrXsapMPmBuxOoLLabDFOyJGYsuiBIeVrNDGG9vDTEu7eprJ2vPXiigZbYONrwSqNJRBLopx69NWjNYYA++BnS8fTW2xdQ6PA7MjYYen8lWWxeIds/eX2aFFroF7PpkL2pp9k1l1RVrOQpuva9tqoiTZUguWmcgYo2ij9bcqG1gRokwK1pPZyr710GRs7Tenl+RlQA4mOWQ/5mMyegwRuQqUWv40/51VHUu5/tFfszpASsI06jVHDX1VxSGcTEnLXwpoxoKlEPsSvXmI6vJ/G4mReObthaMglTfdDWkq9/yHAKx38bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEnWjXwkOMZTTlyfF8G/2hs64WJ1P38D/7iyM8VOVg0=;
 b=ORegeCnfu0n2/UozcqYIKH8b7j347NQZhBvIAHDjYdKo7lY/yqTi0Ll0a5banljTGnu1JVqLQKvRWKKZL6bWDllSiEP/n550/eXhVkhN+k9FvwS+++QmJ9Z2EdBnBDGOGR12N281eXTxQmmPgfW5gtfFEgd0qcJqdwFS7IRz+uyztbeLpLIXcCqOfTGItgGhTXkmHNlogwIAd3toO325LTMK02F5D0KmXl2ZQ7kmoEqVb1OUjvWsYwkWdF26byl5B/bB2QrZt/qy3dGzxS07/CNSS/sY7H24MrnsKFLdgefc55JhgvNZfdprtilZCYVURggSpN8xgcSIMkXrCJCBcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEnWjXwkOMZTTlyfF8G/2hs64WJ1P38D/7iyM8VOVg0=;
 b=Ogcd91PrZUb96s8Q1YBSyyuukXfRDflLOcI5boZqKNCriGI6QdENLT1284OTVDW7ZBtxcURzSxiRxkdb+56WPd0wsSEcsqHLqwWWuU+wT/d67FrglSDv4xxOcs/CXpzmrr9xzUpTe6CzBR+TuLT5eVgUtz4F+DuCPH262Z6k/+Y=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by JH0PR03MB7877.apcprd03.prod.outlook.com (2603:1096:990:33::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 01:24:23 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 01:24:23 +0000
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
Subject: Re: [PATCH v6 06/11] drm/mediatek: mtk_dsi: Transfer register offsets
 to per-SoC const
Thread-Topic: [PATCH v6 06/11] drm/mediatek: mtk_dsi: Transfer register
 offsets to per-SoC const
Thread-Index: AQHdFGHzIbt6A7WHMkSEAqH3PtWf37axXNAA
Date: Thu, 27 Aug 2026 01:24:23 +0000
Message-ID: <a10d4d338ffa0bd973ecb8c1f70a56eaeeb7b983.camel@mediatek.com>
References: <20260715135703.46540-1-angelogioacchino.delregno@collabora.com>
 <20260715135703.46540-7-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260715135703.46540-7-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|JH0PR03MB7877:EE_
x-ms-office365-filtering-correlation-id: 6ef8c50a-2222-4da8-1743-08df03d9ed38
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|42112799006|1800799024|23010399003|7416014|22082099003|10067099003|18002099003|11063799006|5023799004|4143699003|56012099006|38070700021;
x-microsoft-antispam-message-info: PIpWu+rlF1D2CJTGOGF76QC2GxSjNfwLystom4D/oLshvtc2Mnrr/WEeLh7/5NTxYKGSYCvtxVFx5y577U5Or1T3k/WgpzMPuIifiBkOxeqKisuhydl41q5hvYN8K0C7UJpIUUAMaOEfwmZn47MdgdQaLhdp2aQy3Wdu6wDM0UeSs2lvSBH5sn6CoCi8UeCq/VP25H4nEuhUD+/bfnCygt9FlVlwx88GdyXxCO6dQuMbER7XkopoQ7UpkZOg75A6dEuNpTY3tlNX21njrKqfhcrPnyfDuXt6lpzHpwEbm3gD0380srndLgNMt8f8byHUQWzncJEf2XKHoOujLv64jrfHAdG70wxpaTgcALJNvs8OyPA2R/JxJswGyUPWmVqo5jkh4pJlxpLPusRR7R/XOTHmsS5XSBteCjuYhGo2GceyXyruydTtferzus4K1A5qiZoOCdpYni7KO9IgCKuSdYldA3tWK/XY/87FUY8X5MUezPBhB3dHyseidhCTiP6sW07smSE/lhgm9orxGWfUN4QUqi6jX2VYVQO4CxbhPLWHeOdtISo/adK17Kfq2dNKZLSTTOhSVQcDZqeAdfSAnaOeAIMKFVQVx0Iktx9dGByPnlxvN3IEec8dXs29XfmvvFNQLT7Hp85Edu8UsnOH3RPMcLnnmbJznT7UUPVvs2dyCD8Rt/SPkALZsjNfQqd7JpSU6/tF/cdfGS7Eb8q0mgLboaXUCmqwdwtuiOWCbRM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(42112799006)(1800799024)(23010399003)(7416014)(22082099003)(10067099003)(18002099003)(11063799006)(5023799004)(4143699003)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1FMY2cyTElIR2NGUENlMm9YVnNDVWdITkJ2NWF3V3VKeUtEdmhCMkt1bjFJ?=
 =?utf-8?B?dmc0RlE0dHlIcHg5TEtFYndwZTlhN1ZWNE9ldm5TQ0s5Wm5IRDNVK1lXNk05?=
 =?utf-8?B?Mm1TaU5aOHUvakdrYjEzaHA5OVhBQmViODVGcGNMN3MyWGNhN1l0Tkxyc3dR?=
 =?utf-8?B?WFNzZ0o2ZjhnMTNyaU9VT0NtRzNrQlRFQ3ZDTkVqVUo2QTlFYURiWkhpdWtk?=
 =?utf-8?B?T0VURmNrQ3VrdGtxWmFPRC9xOUN2RzkrWUdsbHRrUDZ4L1FuaitjeE9nc25v?=
 =?utf-8?B?T29nbWVtUldoSExETmU0aTdEV3hBTTk5TWcrUU1CaVdYYmQ0Q2IycEtmYkhx?=
 =?utf-8?B?eHVvZWUzVGUvRmJMR2h3SmllV284V1dPMGxoWXROTGlnRFFMK0tGNE5RNXhX?=
 =?utf-8?B?MmdGWERFZERGeVRjdDNiSGFqNGsxKzZUWXBqQVZGdXg3elFyUzVvQlBEYlkw?=
 =?utf-8?B?bEpCb3lHaWRrVHhQdHlOOGpnMGxialNUbFVyVjNNWHBFSkt4eTM3MFk4YzFy?=
 =?utf-8?B?WE85TTlHb2NEZ3cwUGhHNzZoYlk1cmVSa2xET1YrNllXRWFtSDBGY1ZSQWtX?=
 =?utf-8?B?MUxOeXRHTGQ4SHRON05nZFpDVXgwenlBZ2xVcFkxYlc4UkpPZzJBYjhPaENr?=
 =?utf-8?B?QnhkQXY4YXE5TkRjODUxNzBweTZkZVJDNjBkSmtIcnJ5L0NqQXZ0cmp3TVZa?=
 =?utf-8?B?dnlDWnBYSVVIWG95WURpZ29hc0xtL3l4SnRReHRvcE9DSlZSa0QyNVpWc2Vr?=
 =?utf-8?B?QVk4dlNhMkNPTDJoZE54dDlQYzhsblBUeFZVNWdTREp4UzJzaEhBS0ZlbkdJ?=
 =?utf-8?B?OElpbExrbkhrdDd6MFNMRmlwUW4wUmNrblZ5dEFqaUlwd1d5eDBxU2ZqcTVk?=
 =?utf-8?B?QzBZemMwS3ArOStyYnB6eXlxd1A2STVNTE91UEFxVFFzVmN2dGFVaWs0aWJv?=
 =?utf-8?B?cXBtZEx4YTgrZ0JhSkdwY1p2QlNvZEJEMjVKSytpemdxL3Nrb2tKWHBrZ2s3?=
 =?utf-8?B?KzBxeXVzVXd4OU9lV0gyQnhrbVExQ3lyNm5wOFpsbFlxekVSMnh3MnVqRzBF?=
 =?utf-8?B?RTRVMVpBcGZvazFTejdFNmprSWIxYTkzR1duUTVySDFWSFpHRlBOeHYxZ0ZU?=
 =?utf-8?B?RnhyWGdUckF1S3F1eWpkbG9LanEzek55UzhmeFVqQy9KYnpaM1MzUnhtZFNa?=
 =?utf-8?B?VzNPSXl1VHBOS2dxRUlOcHlHZTQrTlgzM240RnY2QWlVTVFQNEMvSUdtYzhw?=
 =?utf-8?B?M1RYSWZTckpRU3AxQkNpQms5eUhQeDgxdlZxZWZ0QkQ3Z29XUzdITnhGL0hY?=
 =?utf-8?B?ek0wUkxJWWhCQ1pkaVhiT2ZPVHorenZzSXA2c0F3N1hHQk9yZW9Zd0pNZUgy?=
 =?utf-8?B?RURWK1lkdTVCQnJtSlNRYUUzUXpPWGlWZ0FLS3RteVVSQ0psNmFCZlVjbjhY?=
 =?utf-8?B?cEF4b3RvblBBRDFDbWlGV2hZWGovY1doRU5WQXNwMzBBL1VjT093QUxFN3lT?=
 =?utf-8?B?VWNjSTJVSitaVzVaT1gwY1AwR1YwblkrWmZnUStRejRhQ0JzOHM1amJyNnJG?=
 =?utf-8?B?dVBZWFlDZW5aTlkrcll5OU1JQ08wcHBEVlJkY1ZMckpMejhiTFY0cFZTZnhm?=
 =?utf-8?B?WFpncWYyMzNuM0NFMVd6YXdZc0liK2szN1YzUE5JNnhLS3dhenlwcTkwSXo1?=
 =?utf-8?B?ZjJYTktlMzczdnc2cmpMY2J5cE1jOVhDTTc2Y2VpYkY5ME9RNTRaZVF0azlo?=
 =?utf-8?B?N3hvaHFua0VtemUvZFVjL016VW1BWlA3MzBhVTJGUkZxdENrNURDZzJscDZ3?=
 =?utf-8?B?d2JPWVRNaTNuYUdwSmNjaitmUjEyRW1UT2V0bkljZnI4MFJydmpiRGVoS2ND?=
 =?utf-8?B?T2FMenlLdXZFWkZpenkrQ21aMy9tN05Tdm9VNEZoM0xWRk9veGQ4c0l6ZGlS?=
 =?utf-8?B?WDh1MFZuK2dORHNSWGhpQ1B5K2lRVXpYd2dDbmdOZWt3SnNubG9KK2ZqS0tm?=
 =?utf-8?B?QzZ0WUZXNks0TnAzZEdVaVZMY3NKdU1DMGtkUDRDSExHZ0RvOElDK1pjOFFD?=
 =?utf-8?B?Vi9QaHUwNEZjWkVzOHRzeElMM3p0eEpyNnJEWUNDY3lrNWdtaTB3elJlbE9y?=
 =?utf-8?B?N0Q5NzZxNkVkbHFGL2NwVWUwNk5TcDdPLzdDQmVGaGlEN1l5K2xGVlpZOElr?=
 =?utf-8?B?Zm5kczlvL0NSTlZ2dURJU2M5Z0JxTkRuZ1BvWk15SzRjV0F1TXJFa1NtUlhx?=
 =?utf-8?B?eFppU2xkZjNNWDRkQ1c4Rm9ydFQ5MWJRUlRSODRoRGhqdlUvck1ETlVaaUw0?=
 =?utf-8?B?ZjZTVExqNWljblRjVGNJMGhvVklaV250bUZRU1V1TXRmNjNkZko3Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <684BC08E7B5DB44EA96DEE9AA0F19796@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 1RrCg5UUvbIm1Y6IiOoJj+efL80sr36jEbWsNMOaUbJADs6TjJkNL38q8Jew1y5jpjI9MrE7J/f+z/HNi65BKkFk8LitMfJCgGxi5b+/hphzrzppYsXoLKvp7lHCQtSk9n4mwVjHyvpea6gWlugo5pAIKeVqHCZK/WZpQ/m6h89TRhS88IKSG+Tixb3Mef5O+RaUvLWGP9anwXFkKLclfp6QJFQdazxHruAMjGlYU7RVU/DRWTU8mX/9n/bgMPzlELJudKwGrvwrEaVJPagySofaFoaVWfVkp9g06Y0acQVmlEgPZbONXr2VwAIBgMer9XRaiNiEsYl9Rw5Czy/4ZA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef8c50a-2222-4da8-1743-08df03d9ed38
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2026 01:24:23.2350 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xu8hMxFWUjP1GpIBQftBrT0+AyR9XhUm0MQzmnNQYbeWVN4BP1PmE1CNWOG1VV8zYUW9tWZrc9eN5wKop0odqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7877
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

T24gV2VkLCAyMDI2LTA3LTE1IGF0IDE1OjU2ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gQXMgb2Ygbm93LCB0aGUgYWxsIG9mIHRoZSBzdXBwb3J0ZWQgU29DcyBo
YXZlIHNtYWxsIGRpZmZlcmVuY2VzIGluDQo+IHRoZSByZWdpc3RlciBvZmZzZXRzIGZvciB0aGVp
ciB2ZXJzaW9uIG9mIHRoZSBEU0kgSVAsIGF0IGxlYXN0IGZvcg0KPiB0aGUgVk1fQ01EX0NPTiwg
U0hBRE9XX0RFQlVHIGFuZCBDTURRIG9mZnNldHMuDQo+IA0KPiBBcyBhIHByZXBhcmF0aW9uIGZv
ciBpbnRyb2R1Y2luZyBzdXBwb3J0IGZvciBuZXdlciBnZW5lcmF0aW9uIERTSQ0KPiBJUHMsIGhh
dmluZyBldmVuIG1vcmUgZGlmZmVyZW5jZXMgaW4gdGhlIHJlZ2lzdGVyIG9mZnNldHMgKGJ1dCBu
b3QNCj4gaW4gdGhlIGxheW91dCBvZiB0aGVpciBmaWVsZHMsIG5vciBpbiB0aGUgYWN0dWFsIHBy
b2dyYW1taW5nKSwgYXMNCj4gZm91bmQgb24gRGltZW5zaXR5IDk0MDAgTVQ2OTkxLCBLb21wYW5p
byBVbHRyYSBNVDgxOTYgYW5kIEdlbmlvDQo+IFBybyA1MTAwIE1UODg5NCwgdHJhbnNmZXIgYWxs
IHRoZSByZWdpc3RlciBvZmZzZXRzIHRvIHR3byBjb25zdA0KPiBhcnJheXMsIHNwbGl0dGluZyB0
aGUgRFNJIElQIHZlcnNpb24gc3BlY2lmaWMgcmVnaXN0ZXJzIGZyb20gdGhlDQo+IFNvQyBzcGVj
aWZpYyBvbmVzIChhcyB0aG9zZSBkZXBlbmQgb24gaW50ZXJmYWNpbmcgd2l0aCBDTURRIGFuZA0K
PiBvdGhlciBJUHMgZXh0ZXJuYWwgdG8gRFNJLCBidXQgaW50ZXJuYWwgdG8gdGhlIFNvQywgYW5k
IGVtYmVkZGVkDQo+IGluIERTSSkuDQo+IA0KPiBUaGlzIGNoYW5nZSBicmluZ3Mgbm8gZnVuY3Rp
b25hbCBkaWZmZXJlbmNlLCBhcyBpdCBvbmx5IGNoYW5nZXMNCj4gaG93IHRoZSByZWdpc3RlciBv
ZmZzZXRzIGFyZSByZXRyaWV2ZWQgYW5kIG5vdGhpbmcgZWxzZS4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25v
QGNvbGxhYm9yYS5jb20+DQo+IC0tLQ0KDQpbc25pcF0NCg0KPiAgDQo+IC0jZGVmaW5lIERTSV9D
T05fQ1RSTAkJMHgxMA0KPiArLyogRFNJX0NPTl9DVFJMICovDQo+ICAjZGVmaW5lIERTSV9SRVNF
VAkJCUJJVCgwKQ0KPiAgI2RlZmluZSBEU0lfRU4JCQkJQklUKDEpDQo+ICAjZGVmaW5lIERQSFlf
UkVTRVQJCQlCSVQoMikNCj4gKyNkZWZpbmUgQ01ETU9ERV9XQUlUX0RBVEFfRVZFUllfTElORV9F
TglCSVQoMjQpDQoNClRoaXMgZG9lcyBub3QgcmVsYXRlIHRvIHRoaXMgcGF0Y2gsIHNvIGRyb3Ag
aXQuDQoNCj4gIA0KPiAtI2RlZmluZSBEU0lfTU9ERV9DVFJMCQkweDE0DQo+ICsvKiBEU0lfTU9E
RV9DVFJMICovDQo+ICAjZGVmaW5lIE1PREUJCQkJKDMpDQo+ICAjZGVmaW5lIENNRF9NT0RFCQkJ
MA0KPiAgI2RlZmluZSBTWU5DX1BVTFNFX01PREUJCQkxDQo+IEBAIC02MCw3ICs2Myw3IEBADQo+
ICAjZGVmaW5lIEZSTV9NT0RFCQkJQklUKDE2KQ0KPiAgI2RlZmluZSBNSVhfTU9ERQkJCUJJVCgx
NykNCj4gIA0KDQpbc25pcF0NCg0KPiAgc3RhdGljIGJvb2wgbXRrX2RzaV9jbGtfaHNfc3RhdGUo
c3RydWN0IG10a19kc2kgKmRzaSkNCj4gIHsNCj4gLQlyZXR1cm4gcmVhZGwoZHNpLT5yZWdzICsg
RFNJX1BIWV9MQ0NPTikgJiBMQ19IU19UWF9FTjsNCj4gKwljb25zdCB1MTYgKnJlZ29mZiA9IGRz
aS0+ZHJpdmVyX2RhdGEtPnJlZ19tYWluOw0KDQpPdGhlciBmdW5jdGlvbiB1c2UgJ3JlZ19tYWlu
Jywgc28gYWxpZ24gdG8gb3RoZXIgZnVuY3Rpb24uDQoNCj4gKw0KPiArCXJldHVybiByZWFkbChk
c2ktPnJlZ3MgKyByZWdvZmZbRFNJX1BIWV9MQ0NPTl0pICYgTENfSFNfVFhfRU47DQo+ICB9DQo+
ICANCg0KW3NuaXBdDQoNCj4gIA0KPiAgc3RhdGljIHZvaWQgbXRrX2RzaV9zZXRfbW9kZShzdHJ1
Y3QgbXRrX2RzaSAqZHNpKQ0KPiAgew0KPiAtCXUzMiB2aWRfbW9kZSA9IENNRF9NT0RFOw0KPiAr
CWNvbnN0IHUxNiAqcmVnX21haW4gPSBkc2ktPmRyaXZlcl9kYXRhLT5yZWdfbWFpbjsNCj4gKwl1
MzIgdmlkX21vZGU7DQoNClJlbW92ZSBpbml0aWFsIHNldHRpbmcgZG9lcyBub3QgcmVsYXRlIHRv
IHRoaXMgcGF0Y2gsIHNvIGRyb3AgdGhpcy4NCg0KPiAgDQo+ICAJaWYgKGRzaS0+bW9kZV9mbGFn
cyAmIE1JUElfRFNJX01PREVfVklERU8pIHsNCj4gIAkJaWYgKGRzaS0+bW9kZV9mbGFncyAmIE1J
UElfRFNJX01PREVfVklERU9fQlVSU1QpDQo+IEBAIC0zNjcsMTkgKzQ4NSwyNCBAQCBzdGF0aWMg
dm9pZCBtdGtfZHNpX3NldF9tb2RlKHN0cnVjdCBtdGtfZHNpICpkc2kpDQo+ICAJCQl2aWRfbW9k
ZSA9IFNZTkNfUFVMU0VfTU9ERTsNCj4gIAkJZWxzZQ0KPiAgCQkJdmlkX21vZGUgPSBTWU5DX0VW
RU5UX01PREU7DQo+ICsJfSBlbHNlIHsNCj4gKwkJdmlkX21vZGUgPSBDTURfTU9ERTsNCj4gIAl9
DQo+ICANCj4gLQl3cml0ZWwodmlkX21vZGUsIGRzaS0+cmVncyArIERTSV9NT0RFX0NUUkwpOw0K
PiArCXdyaXRlbCh2aWRfbW9kZSwgZHNpLT5yZWdzICsgcmVnX21haW5bRFNJX01PREVfQ1RSTF0p
Ow0KPiAgfQ0KPiAgDQoNCltzbmlwXQ0KDQo+IEBAIC00MjYsNiArNTQ5LDggQEAgc3RhdGljIHZv
aWQgbXRrX2RzaV9wc19jb250cm9sX2RzYyhzdHJ1Y3QgbXRrX2RzaSAqZHNpLCBib29sIGNvbmZp
Z192YWN0KQ0KPiAgDQo+ICBzdGF0aWMgdm9pZCBtdGtfZHNpX3BzX2NvbnRyb2xfdW5jb21wcmVz
c2VkKHN0cnVjdCBtdGtfZHNpICpkc2ksIGJvb2wgY29uZmlnX3ZhY3QpDQo+ICB7DQo+ICsJY29u
c3Qgc3RydWN0IG10a19kc2lfZHJpdmVyX2RhdGEgKmRhdGEgPSBkc2ktPmRyaXZlcl9kYXRhOw0K
PiArCWNvbnN0IHUxNiAqcmVnX21haW4gPSBkc2ktPmRyaXZlcl9kYXRhLT5yZWdfbWFpbjsNCj4g
IAl1MzIgZHNpX2J1Zl9icHAsIHBzX3ZhbCwgcHNfd2MsIHNpemVfdmFsLCB2YWN0X25sOw0KPiAg
DQo+ICAJaWYgKGRzaS0+Zm9ybWF0ID09IE1JUElfRFNJX0ZNVF9SR0I1NjUpDQo+IEBAIC00NTcs
MTYgKzU4MiwxNiBAQCBzdGF0aWMgdm9pZCBtdGtfZHNpX3BzX2NvbnRyb2xfdW5jb21wcmVzc2Vk
KHN0cnVjdCBtdGtfZHNpICpkc2ksIGJvb2wgY29uZmlnX3ZhYw0KPiAgDQo+ICAJaWYgKGNvbmZp
Z192YWN0KSB7DQo+ICAJCXZhY3RfbmwgPSBGSUVMRF9QUkVQKFZBQ1RfTkwsIGRzaS0+dm0udmFj
dGl2ZSk7DQo+IC0JCXdyaXRlbCh2YWN0X25sLCBkc2ktPnJlZ3MgKyBEU0lfVkFDVF9OTCk7DQo+
IC0JCXdyaXRlbChwc193YywgZHNpLT5yZWdzICsgRFNJX0hTVFhfQ0tMX1dDKTsNCj4gKwkJd3Jp
dGVsKHZhY3RfbmwsIGRzaS0+cmVncyArIHJlZ19tYWluW0RTSV9WQUNUX05MXSk7DQo+ICsJCXdy
aXRlbChwc193YywgZHNpLT5yZWdzICsgcmVnX21haW5bRFNJX0hTVFhfQ0tMX1dDXSk7DQo+ICAJ
fQ0KPiAtCXdyaXRlbChwc192YWwsIGRzaS0+cmVncyArIERTSV9QU0NUUkwpOw0KPiArCXdyaXRl
bChwc192YWwsIGRzaS0+cmVncyArIHJlZ19tYWluW0RTSV9QU0NUUkxdKTsNCj4gIA0KPiAtCWlm
IChkc2ktPmRyaXZlcl9kYXRhLT5oYXNfc2l6ZV9jdGwpIHsNCj4gKwlpZiAoZGF0YS0+aGFzX3Np
emVfY3RsKSB7DQoNCmRhdGEgaXMgdXNlZCBvbmx5IG9uY2UsIGRyb3AgaXQuDQoNCj4gIAkJc2l6
ZV92YWwgPSBGSUVMRF9QUkVQKERTSV9IRUlHSFQsIGRzaS0+dm0udmFjdGl2ZSk7DQo+ICAJCXNp
emVfdmFsIHw9IEZJRUxEX1BSRVAoRFNJX1dJRFRILCBkc2ktPnZtLmhhY3RpdmUpOw0KPiAgDQo+
IC0JCXdyaXRlbChzaXplX3ZhbCwgZHNpLT5yZWdzICsgRFNJX1NJWkVfQ09OKTsNCj4gKwkJd3Jp
dGVsKHNpemVfdmFsLCBkc2ktPnJlZ3MgKyByZWdfbWFpbltEU0lfU0laRV9DT05dKTsNCj4gIAl9
DQo+ICB9DQo+ICANCg0KW3NuaXBdDQoNCj4gQEAgLTY0OSwxNSArNzc2LDE3IEBAIHN0YXRpYyBp
bnQgbXRrX2RzaV9zZXRfZHNjX3BhcmFtcyhzdHJ1Y3QgbXRrX2RzaSAqZHNpKQ0KPiAgDQo+ICBz
dGF0aWMgaW50IG10a19kc2lfY29uZmlnX3Zkb190aW1pbmcoc3RydWN0IG10a19kc2kgKmRzaSkN
Cj4gIHsNCj4gKwljb25zdCBzdHJ1Y3QgbXRrX2RzaV9kcml2ZXJfZGF0YSAqZGF0YSA9IGRzaS0+
ZHJpdmVyX2RhdGE7DQo+ICsJY29uc3QgdTE2ICpyZWdfbWFpbiA9IGRhdGEtPnJlZ19tYWluOw0K
PiAgCXN0cnVjdCB2aWRlb21vZGUgKnZtID0gJmRzaS0+dm07DQo+ICAJaW50IHJldDsNCj4gIA0K
PiAtCXdyaXRlbCh2bS0+dnN5bmNfbGVuLCBkc2ktPnJlZ3MgKyBEU0lfVlNBX05MKTsNCj4gLQl3
cml0ZWwodm0tPnZiYWNrX3BvcmNoLCBkc2ktPnJlZ3MgKyBEU0lfVkJQX05MKTsNCj4gLQl3cml0
ZWwodm0tPnZmcm9udF9wb3JjaCwgZHNpLT5yZWdzICsgRFNJX1ZGUF9OTCk7DQo+IC0Jd3JpdGVs
KHZtLT52YWN0aXZlLCBkc2ktPnJlZ3MgKyBEU0lfVkFDVF9OTCk7DQo+ICsJd3JpdGVsKHZtLT52
c3luY19sZW4sIGRzaS0+cmVncyArIHJlZ19tYWluW0RTSV9WU0FfTkxdKTsNCj4gKwl3cml0ZWwo
dm0tPnZiYWNrX3BvcmNoLCBkc2ktPnJlZ3MgKyByZWdfbWFpbltEU0lfVkJQX05MXSk7DQo+ICsJ
d3JpdGVsKHZtLT52ZnJvbnRfcG9yY2gsIGRzaS0+cmVncyArIHJlZ19tYWluW0RTSV9WRlBfTkxd
KTsNCj4gKwl3cml0ZWwodm0tPnZhY3RpdmUsIGRzaS0+cmVncyArIHJlZ19tYWluW0RTSV9WQUNU
X05MXSk7DQo+ICANCj4gLQlpZiAoZHNpLT5kcml2ZXJfZGF0YS0+c3VwcG9ydF9wZXJfZnJhbWVf
bHApDQo+ICsJaWYgKGRhdGEtPnN1cHBvcnRfcGVyX2ZyYW1lX2xwKQ0KDQpkYXRhIGlzIHVzZWQg
b25seSBvbmNlLCBkcm9wIGl0Lg0KDQo+ICAJCW10a19kc2lfY29uZmlnX3Zkb190aW1pbmdfcGVy
X2ZyYW1lX2xwKGRzaSk7DQo+ICAJZWxzZQ0KPiAgCQltdGtfZHNpX2NvbmZpZ192ZG9fdGltaW5n
X3Blcl9saW5lX2xwKGRzaSk7DQo+IEBAIC02NzcsMjUgKzgwNiwyNSBAQCBzdGF0aWMgaW50IG10
a19kc2lfY29uZmlnX3Zkb190aW1pbmcoc3RydWN0IG10a19kc2kgKmRzaSkNCj4gIA0KDQpbc25p
cF0NCg0KPiBAQCAtNzMwLDE5ICs4NTksMjAgQEAgc3RhdGljIHMzMiBtdGtfZHNpX3dhaXRfZm9y
X2lycV9kb25lKHN0cnVjdCBtdGtfZHNpICpkc2ksIHUzMiBpcnFfZmxhZywNCj4gIA0KPiAgc3Rh
dGljIGlycXJldHVybl90IG10a19kc2lfaXJxKGludCBpcnEsIHZvaWQgKmRldl9pZCkNCj4gIHsN
Cj4gLQlzdHJ1Y3QgbXRrX2RzaSAqZHNpID0gZGV2X2lkOw0KPiAgCXUzMiBzdGF0dXMsIHRtcDsN
Cj4gLQl1MzIgZmxhZyA9IExQUlhfUkRfUkRZX0lOVF9GTEFHIHwgQ01EX0RPTkVfSU5UX0ZMQUcg
fCBWTV9ET05FX0lOVF9GTEFHOw0KPiArCXN0cnVjdCBtdGtfZHNpICpkc2kgPSBkZXZfaWQ7DQoN
ClBsYWNlIHN0cnVjdCBiZWZvcmUgdTMyLg0KDQo+ICsJY29uc3QgdTE2ICpyZWdfbWFpbiA9IGRz
aS0+ZHJpdmVyX2RhdGEtPnJlZ19tYWluOw0KPiArCWNvbnN0IHUzMiBmbGFnID0gTFBSWF9SRF9S
RFlfSU5UX0ZMQUcgfCBDTURfRE9ORV9JTlRfRkxBRyB8IFZNX0RPTkVfSU5UX0ZMQUc7DQo+ICAN
Cj4gLQlzdGF0dXMgPSByZWFkbChkc2ktPnJlZ3MgKyBEU0lfSU5UU1RBKSAmIGZsYWc7DQo+ICsJ
c3RhdHVzID0gcmVhZGwoZHNpLT5yZWdzICsgZHNpLT5kcml2ZXJfZGF0YS0+cmVnX21haW5bRFNJ
X0lOVFNUQV0pICYgZmxhZzsNCg0KWW91IGFscmVhZHkgZGVmaW5lIHJlZ19tYWluLg0KDQo+ICAN
Cj4gIAlpZiAoc3RhdHVzKSB7DQo+ICAJCWRvIHsNCj4gLQkJCW10a19kc2lfbWFzayhkc2ksIERT
SV9SQUNLLCBSQUNLLCBSQUNLKTsNCj4gLQkJCXRtcCA9IHJlYWRsKGRzaS0+cmVncyArIERTSV9J
TlRTVEEpOw0KPiArCQkJbXRrX2RzaV9tYXNrKGRzaSwgcmVnX21haW5bRFNJX1JBQ0tdLCBSQUNL
LCBSQUNLKTsNCj4gKwkJCXRtcCA9IHJlYWRsKGRzaS0+cmVncyArIHJlZ19tYWluW0RTSV9JTlRT
VEFdKTsNCj4gIAkJfSB3aGlsZSAodG1wICYgRFNJX0JVU1kpOw0KPiAgDQo+IC0JCW10a19kc2lf
bWFzayhkc2ksIERTSV9JTlRTVEEsIHN0YXR1cywgMCk7DQo+ICsJCW10a19kc2lfbWFzayhkc2ks
IHJlZ19tYWluW0RTSV9JTlRTVEFdLCBzdGF0dXMsIDApOw0KPiAgCQltdGtfZHNpX2lycV9kYXRh
X3NldChkc2ksIHN0YXR1cyk7DQo+ICAJCXdha2VfdXBfaW50ZXJydXB0aWJsZSgmZHNpLT5pcnFf
d2FpdF9xdWV1ZSk7DQo+ICAJfQ0KPiBAQCAtNzgxLDkgKzkxMSwxMCBAQCBzdGF0aWMgdm9pZCBt
dGtfZHNpX2xhbmVfcmVhZHkoc3RydWN0IG10a19kc2kgKmRzaSkNCj4gIA0KPiAgc3RhdGljIGlu
dCBtdGtfZHNpX3Bvd2Vyb24oc3RydWN0IG10a19kc2kgKmRzaSkNCj4gIHsNCj4gKwljb25zdCBz
dHJ1Y3QgbXRrX2RzaV9kcml2ZXJfZGF0YSAqZGF0YSA9IGRzaS0+ZHJpdmVyX2RhdGE7DQo+ICAJ
c3RydWN0IGRldmljZSAqZGV2ID0gZHNpLT5ob3N0LmRldjsNCj4gLQlpbnQgcmV0Ow0KPiAgCXUz
MiBiaXRfcGVyX3BpeGVsOw0KPiArCWludCByZXQ7DQoNClRoaXMgaXMgbm90IHJlbGF0ZWQgdG8g
dGhpcyBwYXRjaC4NCg0KPiAgDQo+ICAJaWYgKCsrZHNpLT5yZWZjb3VudCAhPSAxKQ0KPiAgCQly
ZXR1cm4gMDsNCj4gQEAgLTgyMCw5ICs5NTEsMTAgQEAgc3RhdGljIGludCBtdGtfZHNpX3Bvd2Vy
b24oc3RydWN0IG10a19kc2kgKmRzaSkNCj4gIA0KPiAgCW10a19kc2lfZW5hYmxlKGRzaSk7DQo+
ICANCj4gLQlpZiAoZHNpLT5kcml2ZXJfZGF0YS0+aGFzX3NoYWRvd19jdGwpDQo+ICsJLyogQnlw
YXNzIHNoYWRvdyBhbmQgZm9yY2UgY29tbWl0IG9ubHkgaWYgdGhlIHJlZ2lzdGVyIGlzIHByZXNl
bnQgKi8NCj4gKwlpZiAoZGF0YS0+cmVnX2FkdltEU0lfU0hBRE9XX0RFQlVHXSkNCj4gIAkJd3Jp
dGVsKEZPUkNFX0NPTU1JVCB8IEJZUEFTU19TSEFET1csDQo+IC0JCSAgICAgICBkc2ktPnJlZ3Mg
KyBkc2ktPmRyaXZlcl9kYXRhLT5yZWdfc2hhZG93X2RiZ19vZmYpOw0KPiArCQkgICAgICAgZHNp
LT5yZWdzICsgZGF0YS0+cmVnX2FkdltEU0lfU0hBRE9XX0RFQlVHXSk7DQo+ICANCj4gIAltdGtf
ZHNpX3Jlc2V0X2VuZ2luZShkc2kpOw0KPiAgCW10a19kc2lfcGh5X3RpbWNvbmZpZyhkc2kpOw0K
PiBAQCAtODczLDcgKzEwMDUsNyBAQCBzdGF0aWMgdm9pZCBtdGtfZHNpX3Bvd2Vyb2ZmKHN0cnVj
dCBtdGtfZHNpICpkc2kpDQo+ICAJbXRrX2RzaV9sYW5lMF91bHBfbW9kZV9lbnRlcihkc2kpOw0K
PiAgCW10a19kc2lfY2xrX3VscF9tb2RlX2VudGVyKGRzaSk7DQo+ICAJLyogc2V0IHRoZSBsYW5l
IG51bWJlciBhcyAwIHRvIHB1bGwgZG93biBtaXBpICovDQo+IC0Jd3JpdGVsKDAsIGRzaS0+cmVn
cyArIERTSV9UWFJYX0NUUkwpOw0KPiArCXdyaXRlbCgwLCBkc2ktPnJlZ3MgKyBkc2ktPmRyaXZl
cl9kYXRhLT5yZWdfbWFpbltEU0lfVFhSWF9DVFJMXSk7DQoNCllvdSBoYXZlIGRlZmluZWQgZGF0
YS4gVXNlIGRhdGEuDQoNCj4gIA0KPiAgCW10a19kc2lfZGlzYWJsZShkc2kpOw0KPiAgDQo+IEBA
IC0xMTczLDkgKzEzMDUsMTAgQEAgc3RhdGljIHZvaWQgbXRrX2RzaV93YWl0X2Zvcl9pZGxlKHN0
cnVjdCBtdGtfZHNpICpkc2kpDQo+ICAJaW50IHJldDsNCj4gIAl1MzIgdmFsOw0KPiAgCXN0cnVj
dCBkcm1fZGV2aWNlICpkcm0gPSBkc2ktPmJyaWRnZS5kZXY7DQo+ICsJY29uc3Qgc3RydWN0IG10
a19kc2lfZHJpdmVyX2RhdGEgKmRhdGEgPSBkc2ktPmRyaXZlcl9kYXRhOw0KPiAgDQo+IC0JcmV0
ID0gcmVhZGxfcG9sbF90aW1lb3V0KGRzaS0+cmVncyArIERTSV9JTlRTVEEsIHZhbCwgISh2YWwg
JiBEU0lfQlVTWSksDQo+IC0JCQkJIDQsIDIwMDAwMDApOw0KPiArCXJldCA9IHJlYWRsX3BvbGxf
dGltZW91dChkc2ktPnJlZ3MgKyBkYXRhLT5yZWdfbWFpbltEU0lfSU5UU1RBXSwNCj4gKwkJCQkg
dmFsLCAhKHZhbCAmIERTSV9CVVNZKSwgNCwgMjAwMDAwMCk7DQo+ICAJaWYgKHJldCkgew0KPiAg
CQlkcm1fd2Fybihkcm0sICJwb2xsaW5nIGRzaSB3YWl0IG5vdCBidXN5IHRpbWVvdXQhXG4iKTsN
Cj4gIA0KPiBAQCAtMTIwOSwxMCArMTM0MiwxMiBAQCBzdGF0aWMgdTMyIG10a19kc2lfcmVjdl9j
bnQodTggdHlwZSwgdTggKnJlYWRfZGF0YSkNCj4gIA0KPiAgc3RhdGljIHZvaWQgbXRrX2RzaV9j
bWRxKHN0cnVjdCBtdGtfZHNpICpkc2ksIGNvbnN0IHN0cnVjdCBtaXBpX2RzaV9tc2cgKm1zZykN
Cj4gIHsNCj4gKwljb25zdCBzdHJ1Y3QgbXRrX2RzaV9kcml2ZXJfZGF0YSAqZGF0YSA9IGRzaS0+
ZHJpdmVyX2RhdGE7DQo+ICAJY29uc3QgY2hhciAqdHhfYnVmID0gbXNnLT50eF9idWY7DQo+IC0J
dTggY29uZmlnLCBjbWRxX3NpemUsIGNtZHFfb2ZmLCB0eXBlID0gbXNnLT50eXBlOw0KPiArCWNv
bnN0IHU4IHR5cGUgPSBtc2ctPnR5cGU7DQoNCk1ha2luZyAndHlwZScgdG8gYmUgY29uc3QgaXMg
bm90IHJlbGF0ZWQgdG8gdGhpcyBwYXRjaC4NCg0KUmVnYXJkcywNCkNLDQoNCg0KPiAgCXUzMiBy
ZWdfdmFsLCBjbWRxX21hc2ssIGk7DQo+IC0JdTMyIHJlZ19jbWRxX29mZiA9IGRzaS0+ZHJpdmVy
X2RhdGEtPnJlZ19jbWRxX29mZjsNCj4gKwl1OCBjbWRxX3NpemUsIGNtZHFfb2ZmOw0KPiArCXU4
IGNvbmZpZzsNCj4gIA0KPiAgCWlmIChNVEtfRFNJX0hPU1RfSVNfUkVBRCh0eXBlKSkNCj4gIAkJ
Y29uZmlnID0gQlRBOw0KPiBAQCAtMTIzNSwxNSArMTM3MCwxNSBAQCBzdGF0aWMgdm9pZCBtdGtf
ZHNpX2NtZHEoc3RydWN0IG10a19kc2kgKmRzaSwgY29uc3Qgc3RydWN0IG1pcGlfZHNpX21zZyAq
bXNnKQ0KPiAgCX0NCj4gIA0KDQoNCg==
