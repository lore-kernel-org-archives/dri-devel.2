Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7078CC61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 07:28:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABD6A10EEBF;
	Thu, 27 Aug 2026 07:28:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="oNRjYa4B";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="XkbJxNn+";
	dkim-atps=neutral
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AB2D10EEBF
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 07:28:40 +0000 (UTC)
X-UUID: e7e807f0a1e811f18dc8c9802ae25ab1-20260827
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=ZAbcViov5PU3f151k7VTs1UX4V8If1stVJKA3pZ0BtU=; 
 b=oNRjYa4BysmzgLPdmuvqru9sTRogN//fTAX8oHTDzPKjRhJHPhfoJ9OC8dYLWPhmXt6Hl81tjjBONZKAgQFQcCkWwTsD6TikeTMD0t4qnYMaumNLLegDvq6N49vvLWTtVZHr1BESaiPrdUwU5hXHcqoVYSqvbhCk8LWDoEdAMok=;
X-CID-CACHE: Type:Local,Time:202608271528+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:5b9ce50b-1454-4b46-97e2-281d7d068c9f, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:7db8b62, CLOUDID:4f8424f2-6b5d-4016-ba8d-9f799a78b7e4,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
 1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e7e807f0a1e811f18dc8c9802ae25ab1-20260827
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1113959893; Thu, 27 Aug 2026 15:28:32 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 27 Aug 2026 15:28:30 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 27 Aug 2026 15:28:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yFhoYo95pT7sGhQ17B+x025LfhJIHbkANt9tbb+uugsXLL5JQyN1S4WLFKjcKEZk2MHQGzA5iKZa5KkX77gcT8LagRRBgWPIo0+tKZiuz9DE2mYXOxu306ygsaXWAKRG1yhAAl3NUQAG0BpaOH+egos8DvdDI/hkAjyI/vgxRWSlo0TojixQ3V1ZClE3WwFqdiyhBYHcWJa1+/weF7D8/r6x5DQ8+yPR2QsS2NHPVm6CwpDLGL0qBRngY4pw5aXCZNfX5nTJKchbK5sCMwLp6mwl/PRG5kL8yJ4yenrrjyPbXV3CnmWs5VG0LofY0ya3BYl71Zwwd3MA1VrJkC/6UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAbcViov5PU3f151k7VTs1UX4V8If1stVJKA3pZ0BtU=;
 b=CyKztcPen84VTvMhT7sSsTCBY+/ME9ePn6+PYtcqYAfRPbuepzCH6yRjy6q/P5Qg7pIkXGqA7VzyvZn4WOUeWEW6+wJUObMwvISIDsXJTpe3WunTMMe+t/ZGnBKhmdad7Wr8odlvUeM6uMhbK7d8mTBkXsFV3pWgTQjFLfs391JAEpEriR37vZlWvni97sU2l41TrELEppLTKSMvFVEIShjUpjdG0liy2kum32dNipkTNiqKmjPovqEInxB7W9OOjLpXiyKhx40fF8aHucPrHSV7eHkUoHyc5RVnYXjlgR04DUWAiBhAbI1H25oCNzh8AYaaGHMF1/hf9rdNguHHQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAbcViov5PU3f151k7VTs1UX4V8If1stVJKA3pZ0BtU=;
 b=XkbJxNn+nAey01gjJ4goY8110xj9loxOm4W6Wp9vPa41IH9dQ/2+xEhDT+tUp06O4Yn1wMYfOz3CIcdvqLFJ42Q2NdklsjpkPzh8H91zFrqUhvbPvC1Hfa4RHSi5k21461QKHHG2NRcE/uLsue7K/uyPPngBc0J+8XyZG4EgxDw=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB8588.apcprd03.prod.outlook.com (2603:1096:405:b5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Thu, 27 Aug
 2026 07:28:27 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 07:28:27 +0000
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
Subject: Re: [PATCH v4 05/12] drm/mediatek: mtk_dp: Clarify SMC eDP/DP video
 unmute commands
Thread-Topic: [PATCH v4 05/12] drm/mediatek: mtk_dp: Clarify SMC eDP/DP video
 unmute commands
Thread-Index: AQHdD5asPRsSGhykpEa88pEoSbrwlLaxzB4A
Date: Thu, 27 Aug 2026 07:28:27 +0000
Message-ID: <7027d877cb62820edd67f29310688f635e26bf62.camel@mediatek.com>
References: <20260709113148.49090-1-angelogioacchino.delregno@collabora.com>
 <20260709113148.49090-6-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260709113148.49090-6-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB8588:EE_
x-ms-office365-filtering-correlation-id: b1395df5-e912-4963-a574-08df040cc93b
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|42112799006|1800799024|7416014|376014|56012099006|3023799007|10067099003|18002099003|22082099003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: E3pMaXuMgkY1WCtD3Jvclnyxy59PKPTFcYd9DRXtPrk2dThZnNbcom40eDQgSDkigHyA0R06zyGpmBjCsHXFVSRoAtiLb5PmGtpKSPq0p83Xw7cwS33Z+1jG3RDO/0a877/NpozRf7n9wYTgcK/pAbq5PcAfnleIMCWuF5po0dZcmLXt6jiUstNerXme1eRM6tIVfisTBpO2Aqx+ZoBr2EcUJeYEDNdADI92WF3xtoNT0ZdciYty8HQZkPhwQsCL8syAhDTMykUQEdg+UV+3CzoZI9YXlD3S1vCTnete5KUJicRXEIvqJLaywdKneP84zWgsw6fJg64QTh6ACR2PohmKJjUj/kqjFLyPcbRRrzYMR07qMGInEtk1+elPYy70NN851XdPiZSuAa60CX5B/3Wl3V73zOkW60Cunhcrr3JvvFicNwKdsfm+nmDAO+o+RMFYALkuNwH7Q8EWRw5hAMFe79vEZ7kimx977cQIT62pz2VxrqgbXBwBdQXaNqWIiK+duKSkjPZZZmAkz+o85ds61oUljWwTlBmviS8SpnLgrfvNx1MGfe/PxzDaedupRRVuXAVRiqdJHkmSdv2aQMpOAcVyFeAHuzi4qH49LPcKIsCn5XvZoyA2KOpX8i4+59LqxTJOC19dpnSmc73FlBy6jshyVHSp4BE/wl4T4GohrGVfnhss9WNm0Spt3qYM4mlqC4bDKPfrbowjAga+gw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(42112799006)(1800799024)(7416014)(376014)(56012099006)(3023799007)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWtjQVBVU25ORHNESGlHUFhuVTNHdE1leTNWbWRYakx6ZXppeWxYTXNOTk1J?=
 =?utf-8?B?WGFDbFBkMlFZUHBkRnJjcGlVNElRMFc1TnRkY0MxVkpseFM5QVVvYjE2SjZw?=
 =?utf-8?B?dXlmdWovNVg1OEpEQXdjMHM1bHpud1VKKzVUeHlhYUFhUmFZV25QNTNlWWJC?=
 =?utf-8?B?bzFveHlOYTJJNWliaGdIK1MwTDlpUXRUd1JKT05ZOHgwVDdjbitkaHpMNUxw?=
 =?utf-8?B?YUh1ZkpzMGNCczhxd0pqY21DTmpXb25xMGhoeUZWTTRsaEh6VVRrYUNBMXFZ?=
 =?utf-8?B?M0lKNVBRMmxtK0dROFdNOWxvTjhHTnJPaVczSHh5d0ZpSWdpUFNma3liSm1k?=
 =?utf-8?B?RWoxWXhZdHhhTytrVGFLRlZTRzNPYytrTEpIbW9Nd3NUN254cEs2aS8xMjhX?=
 =?utf-8?B?Z2tlQndBdmg3K1hvYTVRQlNmZTFlMDJSWENjUFVvN09LSytiQ25LSnV4VEFt?=
 =?utf-8?B?c1V3dWQ4RXV1dGRnK3p6c2RLZWNycWhObGV4SWlKMUtYQ3ZBUXhSTFpqalJZ?=
 =?utf-8?B?VFRPcjVQbXJwdlZSZW81cmJScmJKTWlZYVNwS0JVeWhQalhNNUdWMFU2SEFH?=
 =?utf-8?B?ZmRIb0JTRmN6VlJDRm9XNWhDd1B3aytXVU5peG82cVlwUWRUQ1NIZkVLMXVa?=
 =?utf-8?B?WHpzNEFUZWhFbkVSQk1GMktwdHdSdlRjTndMY0lic1B5NTd0SUowN2xHcnpX?=
 =?utf-8?B?endURmQrcUVqY1V0ejczK2dnVkM1YkhLTU5QUFJYcXJKdlV5V1hNM243aDkz?=
 =?utf-8?B?WVd2b1pwYXJpc090Qjc2T1FtY21pdWtGb3A3Tm5BQ1NzWm1xbU9QaGNKczdF?=
 =?utf-8?B?YjJTZ3crdnR6VDJNNUFQbGdYMHgyQTBGekNROGViZGh4anV0L1ZHSElkaUs2?=
 =?utf-8?B?NHNBUkI2Qm9aOFo3QmxwWEdTS0hDdXNwK0hnL2VvYy85Q1BOckVia3Y2a2pB?=
 =?utf-8?B?RzlsMFMva2paRTZGeWpicXU2K0RaK3dRNGZ6MU5lUzljbXVSdnVrY3dKWTNV?=
 =?utf-8?B?Wk9pR1l3c3FFeFNsOTgxMThVQjlQUDEydThoN0JQNzEybEVCMnlteW5ZMGRt?=
 =?utf-8?B?Y2c5bUtWODFIQjNCR0JIZTNsZ0hHWkJoN0dWUytWd0k1NVJRSENHMG1Qak1P?=
 =?utf-8?B?c0QrVVNSTlhTSWJsSkt4TzZJV01OQlRSRWtGZUZtUE1DbmN5WUdRdk1KalMy?=
 =?utf-8?B?Um8vRGJOUU9WNXowZDBmWHhJY0R6SGdLRko0VGhnK3BlYXFJeEtXWk9EVU1O?=
 =?utf-8?B?R3ZHQU1HQzNpN1Z5V0ZscGN0QkRIUXRJSGtzaCtlVVphclVud3dQcFQ0L29i?=
 =?utf-8?B?RUJjTzdKNlplTldPakFWSmp2TFE5bWlQdUxEd3NqNzFhOHkwdkhMbmZ3RGhy?=
 =?utf-8?B?eHI1RjhKdi9SZ1RGZVNsdG1zOGF6a3ZBdEpnUmN6c2dOUzc1WmtHKzV1S3Nh?=
 =?utf-8?B?THprMmd2dnVtVnl0N1BoNTBQZEJtVzJXb01XZGJDQjFpQ2E2MFg3S1FyZmhM?=
 =?utf-8?B?NitlUVltSUdlYnJRM2Z0ZG9ybjJGb3hVYjR6Wi9CRGt3bjZaZFVNMEY0UmZq?=
 =?utf-8?B?YkZiRlVja2ZVcCtKOGViMkdUbXkxaU13WU9CS214WmpTWnFEMStlRlBOODNU?=
 =?utf-8?B?cXdpbDBpQkxjWXE2a2txbkNMcElCWmNQV1hmZjlBSGZwbTNxVURzVlIvaEdY?=
 =?utf-8?B?eHNaajZmN1lMeDZDMmxuRUhmb2xOSVVLNUhISjZCQllHUDJEWXEzSmxabkRI?=
 =?utf-8?B?SEd4cCsyK0pZQ0ZIWnVGM0hLcGduZk93ZjFuQTZlaFlUaFBSUmZYZ3hyNTA0?=
 =?utf-8?B?a1l0VVlvcm5QMXk4VGVaanNhMEpKaUV5RnIvNDBBRUQ1a21yanY2WEFuWGFJ?=
 =?utf-8?B?ODRSNjdXMllSMjBGVFV4NjlZSys0RTZCRHZNeGZ3QzViVlJxay9wbzV1UlZ3?=
 =?utf-8?B?S2p4UUd6WWFGeW84TktBNmxGdk9pTlFidU5OS0JNNGFwMDhZUmdiUUhiVzVW?=
 =?utf-8?B?R0VpM3ZKSGZ5bkVNdFh2azhDbGMrSkpEaFpEeC91a20rRS9Wa3F6U2JjS1Ji?=
 =?utf-8?B?SWh4UC8yVkkvWkI4Q1JVQWI2S29DcDM1OUhpSHZVVGtQaWZXYUw5MlBHZ0Zl?=
 =?utf-8?B?NUV1Q05HWENjU0FrTnB0Y0hackQvcVZ5aExLMnJSRG1YOWlCSG5DNnNpTDZL?=
 =?utf-8?B?eDd5bi93aEN2SkJHMHlEalhBRjkvTnl3cUl0L29CMzZveFhPMWFDRUdiNFFG?=
 =?utf-8?B?ODFxSkFKRW1ETDZQbzZ1NU5WajlZQ1hyVE1nVGc5VHFwLzZwMUdyUHlVb2Zx?=
 =?utf-8?B?UFhidUdNeGpWMm9rOVVwNXp6MEZ3NlZZcHRpZm9pNEpXSFNUZWxWUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBAE744D19B34E44ACB3C918EF9E9913@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dTMYorT8FOpUCgWmFgrKeaHD7wEqw+tsX2slTNraiGC7R/FumC60VMfiANi7GBiAw6E2PWfvAOmQ85NXIt5VCcunKJ5Qr8IPNknOnEd+ILYzd19YSTQEVq8UcVB3rvD8HDcaLrhE1YtuVvIi2ShKPC6rGAp1iSI5yBNjqWrxYPkubpnTyeXDlcgu0bOWCdR6PHe2TsWg7OR2/jX+gPUcVfE2wWzGnvTkPbGG4vMnk9xj4M/hdFwEAlg7zJXT4FmnUZIG7ePwxqJkxEl74Vg4A6IAacHywsRFE7NwXTaRb9wkPX/sC8xND9Y6oM6m+g5tOpEv66zKVAJOFOWXlQAO6Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1395df5-e912-4963-a574-08df040cc93b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2026 07:28:27.1922 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z1gBsBhqHDk8YTqNyoYnuMaSAmcgcm6IBGLQShTAZy0Oda0Y8s0nrud87cbLbW/OxyeqeBGou3mXyzPZyAE9eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8588
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
ZWdubyB3cm90ZToNCj4gVGhlIGVEUC9EUCB2aWRlbyB1bm11dGUgY29tbWFuZHMgYXJlIG5vdCBl
eHByZXNzZWQgYXMgYml0czoNCj4gaW5zdGVhZCwgaW4gdGhlIGZpcm13YXJlLCB0aG9zZSBhcmUg
ZGVmaW5lZCBhcyBpbmNyZW1lbnRhbA0KPiB1bnNpZ25lZCBpbnRlZ2VyIG51bWJlcnM6IHVzZSB0
aGUgY29ycmVjdCByZXByZXNlbnRhdGlvbiBvZg0KPiB0aG9zZSB0byBpbXByb3ZlIHJlYWRhYmls
aXR5Lg0KPiANCj4gVGhpcyBjb21taXQgYnJpbmdzIG5vIGZ1bmN0aW9uYWwgY2hhbmdlcy4NCg0K
UmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9naW9hY2NoaW5vLmRlbHJl
Z25vQGNvbGxhYm9yYS5jb20+DQo+IC0tLQ0KDQo=
