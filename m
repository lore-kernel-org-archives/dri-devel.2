Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2645C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 08:52:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DECD10F2F8;
	Fri, 28 Aug 2026 08:52:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="iGbOEBN8";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="cNF1YlNi";
	dkim-atps=neutral
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6347D10F2F8
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 08:52:22 +0000 (UTC)
X-UUID: c3fdf7b6a2bd11f18dc8c9802ae25ab1-20260828
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=m31LIxUwPEWhjAmiNOv6x72iNYshRu91JNsnT9RXqMU=; 
 b=iGbOEBN87i9Smu9cgrQqAeLH2X3tyDxshzzi/5Nf2T9fBnhc+5a4lsg+Rw+si6ptCulblHMc7JBZkwJxtUmf3HuZswZrM6pH8bUf8mbhCuuzIPsSUJVHW4FkeATlOwHlxVyROsyajGhssJxTrj27f1hJDgGiFpE8yg+2Sk7tzDw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:9f8c4a72-8141-4169-964e-f49a77f1c8a8, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:7db8b62, CLOUDID:816d7b48-a092-428a-8992-6c9bab7043ec,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
 Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
 1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c3fdf7b6a2bd11f18dc8c9802ae25ab1-20260828
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by
 mailgw02.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1813604738; Fri, 28 Aug 2026 16:52:14 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 28 Aug 2026 16:52:11 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 28 Aug 2026 16:52:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R7qCmNUs8Z4Gj0Y+9ncjlH8SQAJ6NqYGOkp9TKEVwUxbfXETtmtM8ZoMpwXHWSPRJlcNbh1WM1slHJ52nL/v3Iw9Q3fvHTK6ovhW943xamllq4tSo2fzitw80NQelm/zJx2wieDCFd0R/nX/9kUfk5WTarJbuA8NHfhCToHm6z7wnmE/RzvLk90hLvEgpdpPlzUnV0PjGaq3S66N4AOSScHDWomvDvso6CVAlU2z6165qMEhfDmRnfG9UTQA7GAn4xwXcucfM50c9z1lImH8pxQt92+zNS8cxsEd8+CUo7nyg627Kk63xPXxbmSquJfSU/Pk3Ig6Z/fzFENQZI9/fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m31LIxUwPEWhjAmiNOv6x72iNYshRu91JNsnT9RXqMU=;
 b=YPI7/pgayHeB1lmkbVdB25ln/LteOP2gftBj+epwR9tXShuDl1BOePEwEHBXQA9cntWGwfjk+bCvFRgsQKVY4AOrwbzhD3ud+edeH71mIFXME+atCYtyZXYLvGAxYAp4gJlb9XBarzkSNQ+iA85WymmGqeIIg7enkYSORm9MOvH+S/eEB9ifaatJdkj1zMFxxx9ThKG5g+QK/wF2NK05/qctXcGF4elihe4sCHbLNCFhVgCQgjDgbN2ZJoJljVGhTwespBXCnyBAmzHG6xQgePyRq2DjmbIkwzCjpxZh+Kzp5L4fh6s8vj/3tUCA3nQbMwOkPWM43aHMP1CDHQ2MAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m31LIxUwPEWhjAmiNOv6x72iNYshRu91JNsnT9RXqMU=;
 b=cNF1YlNi1f8e+6rCdvjlIvwS/WhHNsRM+2e3Kj1lemzE3MdEAXEcEsnevzcTa0ELXI8tABg4k6oE05lS2mOm/1s/BhiQlU/qwsXtWNcwfX813kBTLRbcMXL2wEs27ak1875NzyKZRht1bS8XRv9iG479UOTnwgGZIKq6IOyEoCo=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by JH0PR03MB7752.apcprd03.prod.outlook.com (2603:1096:990:16::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 08:52:08 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 08:52:08 +0000
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
Subject: Re: [PATCH v2 02/46] drm/mediatek: Export OVL formats definitions and
 format conversion API
Thread-Topic: [PATCH v2 02/46] drm/mediatek: Export OVL formats definitions
 and format conversion API
Thread-Index: AQHdE4Y+6+kpNedDEUaqy+AEpgEiSrazbfWA
Date: Fri, 28 Aug 2026 08:52:07 +0000
Message-ID: <f2ad2f73baeb1b6746995e1e4948e133e2f40c7a.camel@mediatek.com>
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260714114414.184512-3-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|JH0PR03MB7752:EE_
x-ms-office365-filtering-correlation-id: 4e3dd512-c275-4da6-a60e-08df04e1a448
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|23010399003|42112799006|366016|38070700021|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: 8yAbXts6fleFi4dEEr63c2wQ1B7mehKa6svHBUZeKYxILleuDimNcsHB7uaKXxxFxJwTysF2jzurT7Hg3TgR5F8ULr6/On19SQBW8cDTjaBGLyv43WmnWINDq00IIvaK/zVSUl5j25IjaywE5XTki4eA/I/1xMRVbw5b+TGnRsD4Kw4eZfmi+N9llfRQr5XTkGaOXLwhuMl3ZO/N5jLkb+zORILK53X+Pg98ib3l8b0/NgSK6TaiNUePBga3BlcRmY+br/7RcDDpFNfg4ELaUguQ7XV25M9J600XqJ6NSEMYsLu5yBmqR7K1PzcFXEIAE0j+FJpqWrpK7n+0c7U/RS+vf+6MOVyz8XEgMOnIZkr09wvWkrTtfAxPnVWDtIqdHmrQP93biVm0LN7dzh0c06X1GylNqNFaQTuFTzOuVU0ysd5t2N/s+Pg1cTgAgXDZsa6C6kwcikV4eTG1idX69cN0knvsyE1yZhI/INBfBZAvNJk8ICutzZPgC4pJb+Ga/kkNcrYw2HUz1b73fS5OHYv1DvAncmGknjlYJFgvMAJQ9AMCSO19q1CfMwfwuA/qdNwUpjTLeZES/5m094RxOvkmP0yapuOBwjH90Z1IhH57+LVqZqvBkxdonMAERH/REq5XrksIzDeFGPDfwR/LjF5Rqf26KXlkmBbRwv4kj4rbsFGjztbDop5ujOAMahkuWQiTfrrMttxf11kRyWHzg0a6dw15YZ0p2xdyFW484lE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(42112799006)(366016)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFJKd0V0Wmg2ZUxiaDZSK3p0OWhvQWx0TUVZa2YzRXZrSmgwbmNuU1JGc1lJ?=
 =?utf-8?B?T0lGenhGbVpzd2hkamsrQjFES3NyZmltYVI3bmFnNEtrSENiL0EzL2ljRXZX?=
 =?utf-8?B?WkE1VFFkbkErWGNwNHBwZ29KNTB0dUd5RElQN25xV3cxT0pvbnpoZklsSjJ1?=
 =?utf-8?B?dmt4Y0ZpdmZYamRjYm9sNDdSSFJDN2NGdjdDWnc4MEZrR2VuSHppQktKUGFu?=
 =?utf-8?B?bWJBMElrMm8vd2prK0pOVjZvMWlBaWpidkJqOS9HYkhDU0FBVTNCVjhiM210?=
 =?utf-8?B?NHpER09jUGtaWWpFN250cXoxdHN5Z1EycU9XTW9kMVVCd2c0NnJrL25VYUYy?=
 =?utf-8?B?SkZDVnJZUmNaY1hyVzB3Y2lFcjZ0b2NMTzBzR3EySk5kZUZXSXJZbk1YRWVS?=
 =?utf-8?B?ZnJ4U1ZDSUw5d2Z0MkEyTUN1QkJqaUs4a2VwWU0yVFRkT2NLRkt4ZE5JRFRN?=
 =?utf-8?B?bkI0WVBwSkd4ZGVYY1NiOTNKV0I5SyszVWRQOXNCSThvKzBheFRDaGZmZGcy?=
 =?utf-8?B?TmdQWjI4d3hOQ3Z2S1cvVTdKaDNKU2tXalFQdUF5ZUYzS3BPeWRpaVF4UVpv?=
 =?utf-8?B?YXdVV1BCL1liamJ3RHUzSUMwcHB5L3hpTmlSNFdLTDBCeFREOCs2WU56d2JF?=
 =?utf-8?B?TDRUM0hQMTNIMldwaXorZlcrRnlHOUNSMVR5WndSd2hQQ0xQMHVMQnpQMU5w?=
 =?utf-8?B?QzE0eVdNbzAyQnYxcnVXQjdlN1dWM0gwL1YxVDA1eFlzbkxCYXJLZ0xTR1dR?=
 =?utf-8?B?b291RlRpWm13dkNEbk0yZGMvQlVFOW11NVNhTitnemVXTU16NTBkRFdYV1F6?=
 =?utf-8?B?RFlEdXM2dVo1RDhoZEoyRWJqYU1xTjBodXdKbE5wWEo2THgrclVaWVZPWVEx?=
 =?utf-8?B?WCtlZ1BOYlVVZkh5bWlSY1JEZ3Znem50VWJ2NlJDRlNJN0JPTllqUmRHZzdm?=
 =?utf-8?B?Y1hWeGFXKzBEZUtUZkpJdk1ZZVNtdWdIZXNmK1Z0MWZSTFFCWFNKYS8vN21R?=
 =?utf-8?B?YzA2cUU5K1d3N3cvczNrWGZkRU9LTkZlWjdPbksvWmI3dEo5cTlPanhzOHgv?=
 =?utf-8?B?V2xRK3NXYm1ERjFSRXpiTUg2SFRQLzJIWXIyVDhvdnNzR0h3bC80dTVTTk9P?=
 =?utf-8?B?d3NUQmtVaHV6SzBDYVFGZFQrZEdMUCtMbjJVWUpMQUNFU0M1dGJZTmx0OUdk?=
 =?utf-8?B?T1dvMmJBVG1YWXJaQlE5c3FXS3ZZUmJ3SXkvSU1QWEhsZW5tL0svVjAyQ2hB?=
 =?utf-8?B?SmRKVXcveFRhek41MVNtYkRMcWFhQUlYSUFENUk3TnFEMGZRc3ZpOWFTbzVz?=
 =?utf-8?B?K3AvVm9RNHRUeWtWZ21BTFYvaURDTkFvSnkvak0yb3NCc28vYktkdE5wUVQ1?=
 =?utf-8?B?bERjSlFEOGUrK05TYnZmeWhZTG9RREhKejh0WWVDM3VIc1VhcHcrV3NJVWZZ?=
 =?utf-8?B?eGNKaGk2Q1BPMGJ4dnMxenVER0cyQkxWdW5ZYVp0M3hOOW4zWTNxQkRSM0Y5?=
 =?utf-8?B?bG5nRHJwbnVZc1dkS0hWRm1FNUs4T2tPaUZXdTlBRFM3T2NLZytHdFBqOTVx?=
 =?utf-8?B?dlFxTEZnVXhCei9SVHcvN3UzckRJcnQxcExhMWdnN3dRRUdTbVp4bVVyRHJV?=
 =?utf-8?B?VS9NQ244Y1NSdXIwK3RBUkE2U1FhUkJESHYwTUtuR3J0emx2TStOUUcyL0k2?=
 =?utf-8?B?cWJJWU50UEFpbEFPbk1sdWFxYkpNMjVHYjBqS2RhbjBWaTRxRXovUm9Jb0Z4?=
 =?utf-8?B?RlptSlE1cHlQSjVGdjFqZXhMNXIwNCswL1RRc3NqZG5nekJncWpNNVIzZ2ZK?=
 =?utf-8?B?eWljVjl0R0dKTUV3WlVzem93L3ltczNJQWd1eFhmbWMzMVNWZ1pDODRpQzgy?=
 =?utf-8?B?ZkhvaEFGeTRiN1gxRWh0QWVhaVZUOWlLZkdwK2ZHTytJRjJ0bW5hcFNpcnZQ?=
 =?utf-8?B?RzZyQzB0YmJvT0FTQVV3SUFPeS9WVnRCdmVsdVZGZTU1Q2JJejYzYUl5R2NM?=
 =?utf-8?B?UzFjWVhnNXlhZFk1MXJVYWZ2VWRTeU1DMUxoSFBrK1F4di9uMXJOSmtXZ2hZ?=
 =?utf-8?B?THlkV0NJOEtWc2ZHL0xieWZzR25kVEFzUng3SUJ6K29aYkxEMjZYa2xvWGpE?=
 =?utf-8?B?SVZhQjlsUm5BU2dxOUhlbGJWTEpVbUhWdGxHakZhTVZjVTRhRHJ1cGVLTDJR?=
 =?utf-8?B?bjRqNm9OM0psTW1ObVM2U2pVc1VCMHlFUlU5Q1FQeWRpVW8yTm12eFhReGpE?=
 =?utf-8?B?QjZCaDNBTE4ycDBaSnFWSUpScW9OdmlqVTVoRUZtUWNpUnRUZXhVcHY4V09p?=
 =?utf-8?B?cWsrUXN1eGFzbGsyMDlHRXh1SzhjUEhZZkZCUWh1MEozZjhMTy8wUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D7EE3521CC7A9428BC21890DE75E023@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kOs0dlM71QAvcd0o1s8d7Mmy9qhvr+hdKVyy6CVyb/1qRFvcmo/kcGNE5GsIwzXpwTHAO6RWjENiY/wIN+BeGjlOh2dDv3Kqv/9u7s7lR9Z1vJNKSjzy65xW6CzQjy0SQORvt9fS2ln7gOgQhKTIKyeJEYdD/AbN8eDanpG92UTb8NZglrxOKp5TbFt7nC8t2hKp+0a5jnMqDiXphzawTQ3T8jJ7AHtdMjwh0sIGfxreruU91M41J2vo+vwqbMCx3pBUdMmi8MGDYK1AMDsXiss6YmxPhaT9Sfs5dcECBOJsPiNCPMGhewfXzdlsUjaRnRyZ6OY+R6o02j+g+42P2A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e3dd512-c275-4da6-a60e-08df04e1a448
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 08:52:07.9914 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zx2BQ3Pq5WF69q7sp6AWw4KDa81kag3H94I9bqSPRv9oaeSBNC2q9MVFwk+v1K7mTaJwtg+sidJrtIJrMeJkTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7752
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

T24gVHVlLCAyMDI2LTA3LTE0IGF0IDEzOjQzICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRnJvbTogTmFuY3kgTGluIDxuYW5jeS5saW5AbWVkaWF0ZWsuY29tPg0K
PiANCj4gSW4gdXBjb21pbmcgU29DcywgdGhlIE9WTCBjb21wb25lbnQgd2lsbCBiZSBkaXZpZGVk
IGludG8gbXVsdGlwbGUNCj4gc21hbGxlciBoYXJkd2FyZSB1bml0cyB0byBlbmhhbmNlIGZsZXhp
YmlsaXR5LiBUbyBmYWNpbGl0YXRlIHRoaXMNCj4gdHJhbnNpdGlvbiwgdGhlIE9WTCBmb3JtYXQg
ZGVmaW5pdGlvbnMgYW5kIGZvcm1hdCBjb252ZXJzaW9uIEFQSQ0KPiBzaG91bGQgYmUgZXhwb3J0
ZWQgZm9yIHJldXNlIGFjcm9zcyB0aGVzZSB1bml0cy4NCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxj
ay5odUBtZWRpYXRlay5jb20+DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE5hbmN5IExpbiA8bmFu
Y3kubGluQG1lZGlhdGVrLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogUGF1bC1wbCBDaGVuIDxwYXVs
LXBsLmNoZW5AbWVkaWF0ZWsuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG9HaW9hY2NoaW5v
IERlbCBSZWdubyA8YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiAt
LS0NCg0K
