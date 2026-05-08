Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8EC7CD342F
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 07:20:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 455F610F387;
	Fri,  8 May 2026 07:20:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="LYFUOFLv";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="racfLJ8/";
	dkim-atps=neutral
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4E4410F387
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 07:19:58 +0000 (UTC)
X-UUID: 4f6141224aae11f1b96f91537e34a508-20260508
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From;
 bh=X+dp+oMylW30PF9qX8sWxt1A4PQZ8bXDXftBw8Yuk3M=; 
 b=LYFUOFLvpiletgKTwvtHGlrS+K6/E+ohXsgr5DY3BGquUkyUXj7MDvhpDlm9us/6xy8MgQ6+AUrYxbMfHPOL9loMTwlVjAocNccc4YDWpeE8ARJN5I+c8Z0oFcgvMeXUvKAAbgCqf73QLDgOVBaSQEW8J8Gf0kM31WrhIuF7/1s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:9b1a0391-ebd0-4880-8e63-b25d5bccf287, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:ccf20ebf-65a8-4b41-ac18-3671578a914d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
 l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4f6141224aae11f1b96f91537e34a508-20260508
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 560377503; Fri, 08 May 2026 15:19:54 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 8 May 2026 15:19:52 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 8 May 2026 15:19:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IdvxM7lGu+ajjZyUhlb2UHjxWSoZuHXZEfibtgd8SVjzkpbdQiirpOjeKXU1ihrytFOZuGFE+YYw4cuuRbXHwbPKDATAqzNO5gy3nNpbX0lkTgSji+a4y3UZuTV+jMXSNXfpHW7TzS2l8gOc1blv2IJuxAcPL9mMas7kWQX7DwS7mLd+oJY66geELR+nrblyRSv8HQDkCjm62+yBTLGrraaizheRLyfPh5QlBELj4f315xlZNPY/RJZhir4kIx8iyVvTZZ6YwMCURsAQVI9GQ4JR8NLAKrqkCgRLWtRiCK12RbC0j1eNb5NJN1I9ahLsYlJxMhx4f4SBZ8/vRvPR7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+dp+oMylW30PF9qX8sWxt1A4PQZ8bXDXftBw8Yuk3M=;
 b=YYOugIXtdzPEDjVvMWGj4eTLWa5ZiArhgRArVLmBMHb1+tLsGN5Dx0wfjKRGvjAbHTH72YzAqFhWhKQ6y00TPoFtru5kwAtLt0M/G3GMrc0EL/j7xPTJljRMpZ4//jwwbTyGCfTSdyKmGN1gXzLi5x4uXyNDwYtk0ZUToGMy7iCgHr60wCO0vYb1QPhdEekrQ4KRHg/NECbjfwl/GUC3chrdX6Qc7B6d/sl7yUnDrhbvHYB7rNjV855iCP1v1Jv+daHiNT9JNPkqvy5MnmeqS5m/gTjIZKZNytskg4Zdoxuhc8kuXZHbmEvOWOlFnYkOT0/nnYCITIiEshy08CAw8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+dp+oMylW30PF9qX8sWxt1A4PQZ8bXDXftBw8Yuk3M=;
 b=racfLJ8/J5uprBaceljuyVVEVxdqn8BIgZ0+P92ieuerA64yCXuWfWZdwzeW6TtsGSmPr2fwyfeYied5n1HPcQX/gX1FZqc2WH9OXp0CAzrW5fdc7pCUQmMD5dyKQX56HWXYLSRbyZE6l9X7hl/WMJfwhmVoUskHn/kWY0Ciw1c=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by JH0PR03MB7655.apcprd03.prod.outlook.com (2603:1096:990:d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 07:19:49 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a3c2:b94a:70f:e640%4]) with mapi id 15.20.9891.008; Fri, 8 May 2026
 07:19:48 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "simona@ffwll.ch"
 <simona@ffwll.ch>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, "junzhi.zhao@mediatek.com"
 <junzhi.zhao@mediatek.com>, "airlied@gmail.com" <airlied@gmail.com>,
 "daniel@makrotopia.org" <daniel@makrotopia.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "p.zabel@pengutronix.de"
 <p.zabel@pengutronix.de>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jie.qiu@mediatek.com" <jie.qiu@mediatek.com>
Subject: Re: [PATCH 1/2] drm/mediatek: hdmi: pulse audio clocks on bridge
 enable
Thread-Topic: [PATCH 1/2] drm/mediatek: hdmi: pulse audio clocks on bridge
 enable
Thread-Index: AQHczOk3RX9XysZCzUKjK/lk8WOlsbYD3EeA
Date: Fri, 8 May 2026 07:19:47 +0000
Message-ID: <effea6b19a05460371c9f6b639c5e08ab0fe1111.camel@mediatek.com>
References: <a3e22cbae528c9a38d854a586d1736b860998d41.1776265222.git.daniel@makrotopia.org>
In-Reply-To: <a3e22cbae528c9a38d854a586d1736b860998d41.1776265222.git.daniel@makrotopia.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|JH0PR03MB7655:EE_
x-ms-office365-filtering-correlation-id: bb9bbef0-7a05-4dac-fa06-08deacd22fe6
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|42112799006|7416014|376014|366016|1800799024|38070700021|921020|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: ucPpFYwjYD0GEcXmaiH4Nf8x2lqHgbeFgapalz1mF4EP+PlvtyWOFHHv4H5LhvraYmjZHqBnw5yWQaE/Ydie0cxIfWljlC6s7ANlhvDEqlNbsU/A3YvbcWsb/KKbdU5VLzYHwiUJGUWCdLrwZrNeAAuVV4oj636mwnXT2CUcMdY3djQdq1gqBftOgUK/Lex4EEfL5LTKwZQweXPu6lcq7KVu4HtJ8yyQOn45CCqyo/euy4M84RmyM42o3yJ6k0BtipiTdWkNBt38q5EnS/FspQ1Kzo+LmVEkO/RIPjmNIKu3bhzGICxw5tUzl14qPakOdCQVuP8CXjl4kiFHrwuhdLO6pMmsusUXHs1tZMwQ/weHjPT55NgkY5cCtgGRb/3DJxRlzlDfHl/BSNQ4HNpTJR8yeM3xhceo3MPOsb81QAKY/E2B7Zu9bZKpaoXNOuUy/EmUWVfsbGfvSCGtxJ0RWy00Z4mg39mQ3N7TGZ2/dK2LwKhb1BJx0Uv3w0lRpIK21IFCOPEm2JQrsA2F6DUqxI0Bd//ALG8V/9u/7urwbfmjSoMvQFU9F0S3UMpF8ATTt6F5jhlHS+uoqYRoWlpRnHBGZlRVMYA1Bnmpl91OTp6iLZATAInw6dCoplMwZQu4pzpyoOKfr8Gdw7Le8bOES1xzDa7eQv1Ls7iQ7yHUFAF/E05YUdDieOeHB/FBaE5xG4OPz9jqjbJL7EA04pLv+qyXNPZWnWzKSA8i5sgaXjPgZmpA3eimA5udhDmsk2uTT3piRUokF6ZuOhqbuEjLaw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB6624.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(7416014)(376014)(366016)(1800799024)(38070700021)(921020)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXlPc0xMZS9QRlBpZDZ1em82Q25vc3YyaVQrY3VXbHFhZ3RCYmdQSUpHWi9L?=
 =?utf-8?B?OEdtbkJhOGQ5S0FObzZoUWdELytFOHo4QlIwWW0wUnRXYktDVDIzWGhzNXhG?=
 =?utf-8?B?aThPTWRKeVArcDhwa0k3bFR6L1I0VFdYczhlSVBYSVpHQ05RdEtTTHVFY3Ey?=
 =?utf-8?B?M0ZteFM4V0xUQUF2N3lDMWVMcFlzTTk5eDZ2N29mSjZacTkyVlplSDV0OWhB?=
 =?utf-8?B?OWpsSWJHdEE2UVVFU2ZMUXBLNWdsTzNPTk9MbFF1dmxOYXhUYkxlK080MEs1?=
 =?utf-8?B?R1FnWEh3OThQVVFEaTFNeklDV2ZVNlJaV2o0aHdpaVd6TXN3cHEvcHVNVnlF?=
 =?utf-8?B?d3F6UHFtTmpqM3BLUmR5bG0xN3Y4L1JCTEtaNWovMG4rUjhMazRlT1pucXNl?=
 =?utf-8?B?MHVrYjAvOVBmMy9CT1pJaDRZWkhkMmVzTDQ2L3FnWElmQzRMTHBua2xGU3Iz?=
 =?utf-8?B?Q3hUMXRZVEliRjlzcG5xRDNWMFh3ZVR6TzBxWmd5bHhCU3FrUit1bFZyTnI5?=
 =?utf-8?B?RkVaM0xMUHJEK1J4V2pDWUpGUGQxcGRQeUE3NVNPQkRFTHBkVSs5dUpsNnhy?=
 =?utf-8?B?STF1Q3BJYUtaM1VtUFZ4dzZYZ2U5NjRGY2tBU3FRV2E4VkE0NEpwSmp2Nnl1?=
 =?utf-8?B?dGt6Z2dNZ25LZTgvQUY3dFdWb1ViazhhRUM4Szh5bEYydHdYRnhMM01uK0hx?=
 =?utf-8?B?NDZXZnd4b1lqSHV2eFhTYnJ3OHVPT0JveG9MdVNZejhRamlKckQzRnZUbnBW?=
 =?utf-8?B?RHVFRjdzd3I4MEhGNG50NGpiNVVjTm0yaEJ2MmNSMURTUnkrYnpxUnhidFkw?=
 =?utf-8?B?dndSazB0aGJrUytoV0hjWExRR0hPUXkyVHFMeVhMMWF5U0xzRzM2U0VzWTVq?=
 =?utf-8?B?RGtEYnFvcS9qYzNVVXVSeXlVTktWaitnajNHQWdiWUxKSmpKdlVSeGVxUzQ2?=
 =?utf-8?B?Y0d4UmVCQ1F1TUgweXZpQkJ5Vk1tcmI3R0liMUNZbFAxajZjRHExbWt4a3Ny?=
 =?utf-8?B?VjZRZjV6ZDUrYy91ZDRjQW5udGM3ekUzekp4V1d4eWUzNFMwUm5pWXY1elRa?=
 =?utf-8?B?K0NBN3hmUjNmUlNmdjN0aFZqbE41SXBKSHBYUktjdFFwSXRieTAxUHNqeHJR?=
 =?utf-8?B?eWxleHZWejY1Nmhva1NOVGY5WFFJRWhyTU80MDllbHdPNkppK0NIcmtra0xO?=
 =?utf-8?B?RXB3UithY0tXNjd3UERGYVhnSlBCNHBZMHRlb2FjNlVPb2pyWXdVQkRaMTVo?=
 =?utf-8?B?RTVQWWhrVExnSndLVGcwaTBXbXg0bTNiVWs4RUx1REFkRlB1bUt1SHdRb3c0?=
 =?utf-8?B?RDVCY2ZzYkd2WTA1anp5U0NIVEhvVi9jb3dESjRqQWV4VUZBalVTNnBHZG9k?=
 =?utf-8?B?N1gxa29rVElRYzdLcWdIRjgwZGpMYnpZMld6U3FVTWlsNGcvTmo3SERrVHIx?=
 =?utf-8?B?SngwV0JHaWg2Qm9xbGpMemVYcmVmbzdHVDZxMjM0bU04Q1BZcmhLTkFKK3Jw?=
 =?utf-8?B?Yitkc01QRG5kVXFGM1ZSeDdUUEVyVFdXVEpTbll3ZUcvdDZxV1V2WUdtMURk?=
 =?utf-8?B?M0tIWGtvUjVPTjdncUlmYjQ0dEs4UFVDTU9DRklnaDZyUDFLQUk1YUVMNlNl?=
 =?utf-8?B?ZEFDT3ZVeDhYRDZRd2NoZVFtdWZTQ2crZFQxajlqQ1YyWGVFcHg0R3BOZWpx?=
 =?utf-8?B?Sk9kOUtpUTdra3ZJWDJ2QjROaXVpbTIvK0NxVzNuRFpDOFF0Q1lhTXRsOVhn?=
 =?utf-8?B?Y2pqc1drejM5SWJBNXg0UXpzNWZaNDZaUkp0b2ZXUnFibGJIRmZTNVFpZ2I5?=
 =?utf-8?B?em9YUUVOZXV1RFhKSjd2bWFUZi9iRVlrL2phYlNPRWNndVB5SGhlYUxpQ3hC?=
 =?utf-8?B?d0RzYUlGVkJrRW1HYnVqS0h3QXBUYVZPdW5PdW5vQk9rTHZrNEJIbHQwcVVl?=
 =?utf-8?B?ZW9yYXRwZGZCd3lUYis5MDZJT3NWbVFvK1BjTUsycjJTWVBWQWhMa1ZCVEVy?=
 =?utf-8?B?MTE4L3dJTlhKUHBxQlZMSm5mVy9VL3dMdGtqTWdmMWQ5WHRPRjNwSFY5VFhm?=
 =?utf-8?B?Mmx4L1I5c0xqRUdKbVJPYzZCSEgwWjUrRzgxMjlpTDJ0MEtQamVaNTBQa3lU?=
 =?utf-8?B?M1VDeGcwS3oyYjZxL0xZdGV3dTBWbENueWpSazJoS2J2anhvS3RMNTV5aktG?=
 =?utf-8?B?bkZFd1huY0VnbUNnblJGTkswMzNUcW9tcWFsdG5Rc2xRa1FrUUw1TUxUSGVK?=
 =?utf-8?B?YW5ERG5yY05HQ1I4WjYwcjN1TzBzdXhTNGxYNTNFVkdaN2M2VDJ6OFFaNW5S?=
 =?utf-8?B?KzNBZ0E2dkhhb0lMVEVLNHk5aStUeTFYZkVSSjhHRTVDK1NESWpRQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <828FBD0E183E2E409E79EC67B4C62385@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dwlEKvr1xxP9RP7DWZJN4PmGN6mcEwF0efb9HC0ahtUdaf9NsWaU3NMDiExMeDryOrZyFsWXSuubD5Gofn7Ws7z6IMFNdxFZvVcx/AOmaONuAnYUnL+7ppvuZh+XpG+NA5cPycPm4WViaI8D4Ze+1SBcQNv/2/t5NOWDSaGbU0I1QXrMfe2lFgCOQFvJJDV3f63iLdHFIcfhhvzrMMl+9hj1s70x4MWeMgxeyqfO36bAKtbyjbMHGAvHs2mDC3rifYIVopmlOCBfIjkyd9ZixWbsLihnGyQXhPP4iuaOlKmIhbJEyKKjMruirwB+YQjMnoIu+HHfgiWQ9k9SkEq2wg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb9bbef0-7a05-4dac-fa06-08deacd22fe6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 07:19:47.9422 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4FIs+QmUlex1K6hLCDuXCuepY0YA7zP4C+DDDVnjL1AdPRs6UdXjJm0g9W4clJRLFmRJU357NavJY+t9smhcwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7655
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

T24gV2VkLCAyMDI2LTA0LTE1IGF0IDE2OjA0ICswMTAwLCBEYW5pZWwgR29sbGUgd3JvdGU6DQo+
IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFj
aG1lbnRzIHVudGlsIHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQu
DQo+IA0KPiANCj4gVGhlIENMS19NTV9IRE1JX0FVRElPIGFuZCBDTEtfTU1fSERNSV9TUERJRiBt
bXN5cyBnYXRlcyBmZWVkIHRoZQ0KPiBIRE1JIFRYIGludGVybmFsIGF1ZGlvIG1lYXN1cmVtZW50
IGJsb2NrIHdoaWNoIGRlcml2ZXMgQ1RTIHZhbHVlcw0KPiBmb3IgdGhlIEFDUiBwYWNrZXRzIGVt
YmVkZGVkIGluIHRoZSBUTURTIHN0cmVhbS4gVGhlc2UgY2xvY2tzIGFyZQ0KPiBlbmFibGVkIG9u
Y2UgYXQgZHJpdmVyIHByb2JlIHRpbWUgYW5kIHRoZW4gbGVmdCB1bnRvdWNoZWQgYWNyb3NzDQo+
IGJyaWRnZSBhdG9taWNfZW5hYmxlIC8gYXRvbWljX2Rpc2FibGUgY3ljbGVzLg0KPiANCj4gT24g
ZXZlcnkgb2JzZXJ2ZWQgc3RhbGUtc3RhdGUgZXZlbnQgLS0gYSBibGFuay91bmJsYW5rIGN5Y2xl
LCBvcg0KPiBhIGNvbGQgYm9vdCB3aXRoIHRoZSBtb25pdG9yIG9mZiBmb2xsb3dlZCBieSBhIGxh
dGVyIGhvdHBsdWcgLS0NCj4gdGhlIG1lYXN1cmVtZW50IGJsb2NrIHJlbWFpbnMgYXJtZWQgYWdh
aW5zdCB0aGUgcHJldmlvdXMgc3RhdGUNCj4gYW5kIGZhaWxzIHRvIGxhdGNoIGEgdmFsaWQgQ1RT
IG9uIHRoZSBzdWJzZXF1ZW50IGJyaWRnZSBlbmFibGUuDQo+IFZpZGVvIHJlY292ZXJzIGNsZWFu
bHkgYnV0IHRoZSBhdWRpbyBkYXRhIGlzbGFuZHMgbmV2ZXIgcmVnYWluDQo+IGxvY2sgYW5kIHRo
ZSBIRE1JIHNpbmsgc2VlcyBubyBhdWRpbywgZXZlbiB0aG91Z2ggdGhlIEFTb0Mgc3RhY2ssDQo+
IHRoZSBBRkUsIGFuZCB0aGUgSERNSSBUWCBhdWRpbyBwYWNrZXRpemVyIGFyZSBhbGwgcHJvZ3Jh
bW1lZA0KPiBjb3JyZWN0bHkuDQo+IA0KPiBEZWJ1Z2dpbmcgdGhlIGlzc3VlIG9mIGF1ZGlvIG5v
IGxvbmdlciB3b3JraW5nIGFmdGVyIHZibGFuayBpdCB3YXMNCj4gZm91bmQgdGhhdCBhbiB1bmJp
bmQrYmluZCBvZiB0aGUgbWVkaWF0ZWstZHJtLWhkbWkgcGxhdGZvcm0gZHJpdmVyDQo+IHJlY292
ZXJzIGF1ZGlvIGluIGFsbCBzdWNoIHNjZW5hcmlvcyB3aXRob3V0IGRpc3R1cmJpbmcgdmlkZW8u
DQo+IFRoZSBvbmx5IGF1ZGlvLXJlbGV2YW50IHNpZGUgZWZmZWN0IG9mIHRoYXQgcmViaW5kIGlz
IGFuIG9mZi0+b24gZWRnZQ0KPiBvbiBDTEtfTU1fSERNSV9BVURJTyAvIENMS19NTV9IRE1JX1NQ
RElGIHZpYSB0aGUgcHJvYmUgcGF0aC4gUHVsc2luZw0KPiB0aG9zZSB0d28gY2xvY2tzIGRpcmVj
dGx5IGF0IHRoZSBlbmQgb2YgbXRrX2hkbWlfYnJpZGdlX2F0b21pY19lbmFibGUNCj4gcmVwcm9k
dWNlcyB0aGF0IHJlY292ZXJ5IG9uIGV2ZXJ5IGVuYWJsZSBhbmQgZG9lc24ndCBodXJ0IG9uIHRo
ZQ0KPiBmaXJzdCBlbmFibGUgYWZ0ZXIgYm9vdC4NCj4gDQo+IEZpeGVzOiA4ZjgzZjI2ODkxZTEg
KCJkcm0vbWVkaWF0ZWs6IEFkZCBIRE1JIHN1cHBvcnQiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBEYW5p
ZWwgR29sbGUgPGRhbmllbEBtYWtyb3RvcGlhLm9yZz4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2hkbWkuYyB8IDE2ICsrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBj
aGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19oZG1pLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2hk
bWkuYw0KPiBpbmRleCAxZWEyNTk4NTQ3ODAwLi45MDUwZDc3ODVmMTA5IDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2hkbWkuYw0KPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2hkbWkuYw0KPiBAQCAtMTA2NSw2ICsxMDY1LDIyIEBAIHN0YXRp
YyB2b2lkIG10a19oZG1pX2JyaWRnZV9hdG9taWNfZW5hYmxlKHN0cnVjdCBkcm1fYnJpZGdlICpi
cmlkZ2UsDQo+ICAgICAgICAgcGh5X3Bvd2VyX29uKGhkbWktPnBoeSk7DQo+ICAgICAgICAgbXRr
X2hkbWlfc2VuZF9pbmZvZnJhbWUoaGRtaSwgJmhkbWktPm1vZGUpOw0KPiANCj4gKyAgICAgICAv
Kg0KPiArICAgICAgICAqIFB1bHNlIHRoZSBIRE1JIFRYIGF1ZGlvIGNsb2NrcyBvZmYvb24gb24g
ZXZlcnkgYnJpZGdlIGVuYWJsZS4NCj4gKyAgICAgICAgKiBUaGUgQ0xLX01NX0hETUlfQVVESU8g
YW5kIENMS19NTV9IRE1JX1NQRElGIG1tc3lzIGdhdGVzIGZlZWQNCj4gKyAgICAgICAgKiB0aGUg
SERNSSBUWCBpbnRlcm5hbCBhdWRpbyBtZWFzdXJlbWVudCBibG9jayB0aGF0IGRlcml2ZXMgQ1RT
DQo+ICsgICAgICAgICogZm9yIHRoZSBBQ1IgcGFja2V0cyBlbWJlZGRlZCBpbiB0aGUgVE1EUyBz
dHJlYW0uIFdpdGhvdXQgYW4NCj4gKyAgICAgICAgKiBvZmYtPm9uIGVkZ2UgYXQgYnJpZGdlIGVu
YWJsZSB0aGUgYmxvY2sgY2FuIHN0YXkgYXJtZWQgYWdhaW5zdA0KPiArICAgICAgICAqIHN0YWxl
IHN0YXRlIGZyb20gYSBwcmV2aW91cyBlbmFibGUgKGUuZy4gYWZ0ZXIgYmxhbmsvdW5ibGFuaywN
Cj4gKyAgICAgICAgKiBvciBhZnRlciBhIG1vbml0b3IgdGhhdCB3YXMgb2ZmIGF0IGJvb3QgaXMg
cGx1Z2dlZCBpbiBsYXRlcikNCj4gKyAgICAgICAgKiBhbmQgZmFpbHMgdG8gbGF0Y2ggYSB2YWxp
ZCBDVFMsIGxlYXZpbmcgdGhlIGF1ZGlvIHBhdGggc2lsZW50DQo+ICsgICAgICAgICogZXZlbiB0
aG91Z2ggdmlkZW8gcmVjb3ZlcnMuIFRoZSBwdWxzZSBpcyB3aGF0IGFuIHVuYmluZCtiaW5kDQo+
ICsgICAgICAgICogb2YgdGhlIEhETUkgcGxhdGZvcm0gZHJpdmVyIGVmZmVjdGl2ZWx5IGRvZXMs
IGFuZCBpdCByZWNvdmVycw0KPiArICAgICAgICAqIGF1ZGlvIGluIGFsbCBvYnNlcnZlZCBzdGFs
ZS1zdGF0ZSBzY2VuYXJpb3MuDQo+ICsgICAgICAgICovDQo+ICsgICAgICAgbXRrX2hkbWlfY2xr
X2Rpc2FibGVfYXVkaW8oaGRtaSk7DQo+ICsgICAgICAgbXRrX2hkbWlfY2xrX2VuYWJsZV9hdWRp
byhoZG1pKTsNCg0KV2h5IG5vdCBhbGlnbiBhdWRpbyBjbG9jayBvbi9vZmYgdGltaW5nIHRvIHZp
ZGVvIGNsb2NrIHRpbWluZy4NCkkgbWVhbiwgZG8gbm90IHR1cm4gb24gYXVkaW8gY2xvY2sgd2hl
biBwcm9iZSBhbmQgdHVybiBvbiBpdCBpbiBhdG9taWMgZW5hYmxlIGFuZCB0dXJuIG9mZiBpdCBp
biBhdG9taWMgZGlzYWJsZS4NCkkgdGhpbmsgaXQncyByZWFzb25hYmxlIHRvIGFsaWduIGF1ZGlv
IGNsb2NrIGFuZCB2aWRlbyBjbG9jayBvbi9vZmYgdGltaW5nLg0KDQpSZWdhcmRzLA0KQ0sNCg0K
PiArDQo+ICAgICAgICAgaGRtaS0+ZW5hYmxlZCA9IHRydWU7DQo+ICB9DQo+IA0KPiAtLQ0KPiAy
LjUzLjANCj4gDQoNCg==
